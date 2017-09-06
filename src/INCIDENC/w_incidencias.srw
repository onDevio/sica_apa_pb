HA$PBExportHeader$w_incidencias.srw
forward
global type w_incidencias from w_mant_simple
end type
type st_1 from statictext within w_incidencias
end type
type cb_salir from u_cb within w_incidencias
end type
end forward

global type w_incidencias from w_mant_simple
integer x = 498
integer y = 221
integer width = 2469
integer height = 1448
string title = "Incidencias"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
windowstate windowstate = normal!
st_1 st_1
cb_salir cb_salir
end type
global w_incidencias w_incidencias

on w_incidencias.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_salir=create cb_salir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_salir
end on

on w_incidencias.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_salir)
end on

event open;call super::open;long x1,y1

x1=w_aplic_frame.Height
y1=w_aplic_frame.Width
this.x=(y1/2)-(this.width/2) + 100
this.y=(x1/2)-(this.height/2) + 100

dw_1.of_SetDropDownCalendar(True)
dw_1.iuo_calendar.of_register(dw_1.iuo_calendar.DDLB)
dw_1.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_1.iuo_calendar.of_SetInitialValue(True)

inv_resize.of_register (cb_salir, "fixedtobottom")

if g_incidencias.tipo='C' then
	st_1.text=f_colegiado_apellido (g_incidencias.id)
else
	st_1.text=f_dame_cliente(g_incidencias.id)
end if
//dw_1.retrieve(g_incidencias.id)
end event

event pfc_postopen;dw_1.retrieve(g_incidencias.id)
ii_ayuda=50
end event

event pfc_close();call super::pfc_close;integer i
string op
dw_1.accepttext()
for i=1 to dw_1.rowcount()
        if dw_1.getitemstring(i,'texto')=' ' or f_es_vacio(dw_1.getitemstring(i,'texto')) then
                MessageBox(g_titulo,'Debe introducir una incidencia en la fila ' + string(i))
                return
        end if
next
if dw_1.rowcount() > 0 then op='S'
closewithreturn(w_incidencias,op)  


end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_incidencias
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_incidencias
end type

type dw_1 from w_mant_simple`dw_1 within w_incidencias
integer y = 204
integer width = 2409
integer height = 988
string dataobject = "d_incidencias"
end type

event dw_1::pfc_addrow;call super::pfc_addrow;dw_1.setitem(dw_1.getrow(),'id_incidencias',f_siguiente_numero('INCIDENCIAS', 10))
dw_1.setitem(dw_1.getrow(),'tipo',g_incidencias.tipo)
dw_1.setitem(dw_1.getrow(),'id',g_incidencias.id)
dw_1.setitem(dw_1.getrow(),'fecha',datetime(today()))
return 1
end event

event dw_1::pfc_insertrow;call super::pfc_insertrow;dw_1.setitem(dw_1.getrow(),'id_incidencias',f_siguiente_numero('INCIDENCIAS', 10))
dw_1.setitem(dw_1.getrow(),'tipo',g_incidencias.tipo)
dw_1.setitem(dw_1.getrow(),'id',g_incidencias.id)
dw_1.setitem(dw_1.getrow(),'fecha',datetime(today()))
return 1
end event

event dw_1::clicked;call super::clicked;string incid

CHOOSE CASE dwo.name
	case 'b_incidencia'
		g_busqueda.titulo="Incidencia"
		incid = this.GetItemString(row, 'texto')
		openwithparm(w_observaciones, incid)
		if Message.StringParm <> '-1' then
			incid = Message.StringParm
			if not isnull(incid) then
				dw_1.SetItem(row, 'texto', incid)
			end if
		end if
		
END CHOOSE
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_incidencias
end type

type cb_borrar from w_mant_simple`cb_borrar within w_incidencias
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_incidencias
integer x = 1413
end type

type st_1 from statictext within w_incidencias
integer x = 78
integer y = 56
integer width = 1888
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

type cb_salir from u_cb within w_incidencias
integer x = 1774
integer y = 1208
integer taborder = 20
boolean bringtotop = true
string text = "&Salir"
end type

event clicked;integer i
string op
dw_1.accepttext()
for i=1 to dw_1.rowcount()
	if dw_1.getitemstring(i,'texto')=' ' or f_es_vacio(dw_1.getitemstring(i,'texto')) then
		MessageBox(g_titulo,'Debe introducir una incidencia en la fila ' + string(i))
		return
	end if
next
if dw_1.rowcount() > 0 then op='S'
closewithreturn(w_incidencias,op)
end event

