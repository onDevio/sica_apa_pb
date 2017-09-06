HA$PBExportHeader$w_incidencias_fases.srw
forward
global type w_incidencias_fases from w_mant_simple
end type
type st_1 from statictext within w_incidencias_fases
end type
type cb_salir from u_cb within w_incidencias_fases
end type
end forward

global type w_incidencias_fases from w_mant_simple
integer x = 498
integer width = 2743
integer height = 1440
string title = "Control de incidencias"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
windowstate windowstate = normal!
st_1 st_1
cb_salir cb_salir
end type
global w_incidencias_fases w_incidencias_fases

on w_incidencias_fases.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_salir=create cb_salir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_salir
end on

on w_incidencias_fases.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_salir)
end on

event open;call super::open;long x1,y1
string id_expedi

x1=w_aplic_frame.Height
y1=w_aplic_frame.Width
this.x=(y1/2)-(this.width/2) + 100
this.y=(x1/2)-(this.height/2) + 100

dw_1.of_SetDropDownCalendar(True)
dw_1.iuo_calendar.of_register(dw_1.iuo_calendar.DDLB)
dw_1.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_1.iuo_calendar.of_SetInitialValue(True)

// Modificado Paco 16/11/2005. Llamaba a la funci$$HEX1$$f300$$ENDHEX$$n incorrecta.
  SELECT fases.id_expedi  
    INTO :id_expedi  
    FROM fases  
   WHERE fases.id_fase = :g_incidencias.id   ;

st_1.text= 'Expediente : ' + f_dame_numero_expedi (id_expedi)


inv_resize.of_register (cb_salir, "fixedtobottom")
end event

event pfc_postopen;dw_1.retrieve(g_incidencias.id)
ii_ayuda=50
end event

event pfc_close();call super::pfc_close;integer i
string op
dw_1.accepttext()
for i=1 to dw_1.rowcount()
        if dw_1.getitemstring(i,'codigo')=' ' or f_es_vacio(dw_1.getitemstring(i,'codigo')) then
                MessageBox(g_titulo,'Debe introducir una incidencia en la fila ' + string(i))
                return
        end if
next
if dw_1.rowcount() > 0 then op='S'
closewithreturn(w_incidencias_exp,op)

end event

type dw_1 from w_mant_simple`dw_1 within w_incidencias_fases
integer y = 204
integer width = 2688
integer height = 988
integer taborder = 50
string dataobject = "d_incidencias_fases"
end type

event type long dw_1::pfc_addrow();call super::pfc_addrow;dw_1.setitem(dw_1.getrow(),'id_incidencias',f_siguiente_numero('INCIDENCIAS-EXP', 10))
dw_1.setitem(dw_1.getrow(),'id_fase',g_incidencias.id)
dw_1.setitem(dw_1.getrow(),'fecha',datetime(today()))
return 1
end event

event type long dw_1::pfc_insertrow();call super::pfc_insertrow;dw_1.setitem(dw_1.getrow(),'id_incidencias',f_siguiente_numero('INCIDENCIAS-EXP', 10))
dw_1.setitem(dw_1.getrow(),'id_fase',g_incidencias.id)
dw_1.setitem(dw_1.getrow(),'fecha',datetime(today()))
return 1
end event

event dw_1::doubleclicked;string obser, data_item

CHOOSE CASE dwo.name
	CASE 'observaciones'
		g_busqueda.titulo="Observaciones"
		obser    =this.GetItemString(row, 'observaciones')
		openwithparm(w_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
			if not isnull(obser) then 
				dw_1.SetItem(row,'observaciones',obser)
			end if
		end if
END CHOOSE
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_incidencias_fases
integer taborder = 20
end type

type cb_borrar from w_mant_simple`cb_borrar within w_incidencias_fases
integer taborder = 30
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_incidencias_fases
boolean visible = false
integer x = 1746
integer taborder = 10
end type

type st_1 from statictext within w_incidencias_fases
integer x = 338
integer y = 56
integer width = 1920
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_salir from u_cb within w_incidencias_fases
integer x = 2354
integer y = 1208
integer taborder = 40
boolean bringtotop = true
string text = "&Salir"
end type

event clicked;call super::clicked;integer i
string op
dw_1.accepttext()
for i=1 to dw_1.rowcount()
	if dw_1.getitemstring(i,'codigo')=' ' or f_es_vacio(dw_1.getitemstring(i,'codigo')) then
		MessageBox(g_titulo,'Debe introducir una incidencia en la fila ' + string(i))
		return
	end if
next
if dw_1.rowcount() > 0 then op='S'
closewithreturn(parent,op)
end event

