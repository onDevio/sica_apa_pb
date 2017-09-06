HA$PBExportHeader$w_retirada_documentacion.srw
forward
global type w_retirada_documentacion from w_mant_simple
end type
type cb_salir from u_cb within w_retirada_documentacion
end type
type dw_2 from datawindow within w_retirada_documentacion
end type
type cb_1 from commandbutton within w_retirada_documentacion
end type
end forward

global type w_retirada_documentacion from w_mant_simple
integer x = 498
integer y = 221
integer width = 2789
integer height = 896
string title = "Retirada de documentaci$$HEX1$$f300$$ENDHEX$$n"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
windowstate windowstate = normal!
cb_salir cb_salir
dw_2 dw_2
cb_1 cb_1
end type
global w_retirada_documentacion w_retirada_documentacion

type variables
string id_expedi
end variables

on w_retirada_documentacion.create
int iCurrent
call super::create
this.cb_salir=create cb_salir
this.dw_2=create dw_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_salir
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_1
end on

on w_retirada_documentacion.destroy
call super::destroy
destroy(this.cb_salir)
destroy(this.dw_2)
destroy(this.cb_1)
end on

event open;call super::open;long x1,y1


x1=w_aplic_frame.Height
y1=w_aplic_frame.Width
this.x=(y1/2)-(this.width/2) + 100
this.y=(x1/2)-(this.height/2) + 100

id_expedi = message.StringParm
dw_1.settransobject(sqlca)
dw_1.retrieve(id_expedi)


dw_1.of_SetDropDownCalendar(True)
dw_1.iuo_calendar.of_register(dw_1.iuo_calendar.DDLB)
dw_1.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_1.iuo_calendar.of_SetInitialValue(True)

//// Modificado Paco 16/11/2005. Llamaba a la funci$$HEX1$$f300$$ENDHEX$$n incorrecta.
//  SELECT fases.id_expedi  
//    INTO :id_expedi  
//    FROM fases  
//   WHERE fases.id_fase = :g_incidencias.id   ;
//
//st_1.text= 'Expediente : ' + f_dame_numero_expedi (id_expedi)



//inv_resize.of_register (cb_salir, "fixedtobottom")
end event

event pfc_postopen;//dw_1.retrieve(g_incidencias.id)
//ii_ayuda=50
end event

event pfc_close;call super::pfc_close;//integer i
//string op
//dw_1.accepttext()
//for i=1 to dw_1.rowcount()
//        if dw_1.getitemstring(i,'codigo')=' ' or f_es_vacio(dw_1.getitemstring(i,'codigo')) then
//                MessageBox(g_titulo,'Debe introducir una incidencia en la fila ' + string(i))
//                return
//        end if
//next
//if dw_1.rowcount() > 0 then op='S'
//closewithreturn(w_incidencias_exp,op)
//
end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_retirada_documentacion
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_retirada_documentacion
end type

type dw_1 from w_mant_simple`dw_1 within w_retirada_documentacion
integer y = 52
integer width = 2734
integer height = 620
integer taborder = 50
string dataobject = "d_retirada_documentacion"
end type

event dw_1::pfc_addrow;call super::pfc_addrow;//dw_1.setitem(dw_1.getrow(),'id_incidencias',f_siguiente_numero('INCIDENCIAS-EXP', 10))
//dw_1.setitem(dw_1.getrow(),'id_fase',g_incidencias.id)
//dw_1.setitem(dw_1.getrow(),'fecha',datetime(today()))
return 1
end event

event dw_1::pfc_insertrow;call super::pfc_insertrow;//dw_1.setitem(dw_1.getrow(),'id_incidencias',f_siguiente_numero('INCIDENCIAS-EXP', 10))
//dw_1.setitem(dw_1.getrow(),'id_fase',g_incidencias.id)
//dw_1.setitem(dw_1.getrow(),'fecha',datetime(today()))
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

event dw_1::constructor;call super::constructor;//this.of_SetDropDownCalendar(True)
//this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
//this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
//this.iuo_calendar.of_SetInitialValue(True)
//
//
//this.setformat('f_retirada','dd/mm/yyyy')
//

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_retirada_documentacion
integer y = 692
integer taborder = 20
end type

event cb_anyadir::clicked;call super::clicked;dw_1.setitem(dw_1.getrow(),'id_retirada',f_siguiente_numero('ID_FASE_RETIRADA',10))
dw_1.setitem(dw_1.getrow(),'id_expedi',id_expedi)
dw_1.setitem(dw_1.getrow(),'f_retirada',today())
dw_1.setitem(dw_1.getrow(),'usuario',g_usuario)
return 1
end event

type cb_borrar from w_mant_simple`cb_borrar within w_retirada_documentacion
integer x = 325
integer y = 692
integer taborder = 30
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_retirada_documentacion
boolean visible = false
integer x = 1746
integer taborder = 10
end type

type cb_salir from u_cb within w_retirada_documentacion
integer x = 2354
integer y = 692
integer taborder = 40
boolean bringtotop = true
string text = "&Salir"
end type

event clicked;call super::clicked;//integer i
//string op
//dw_1.accepttext()
//for i=1 to dw_1.rowcount()
//	if dw_1.getitemstring(i,'codigo')=' ' or f_es_vacio(dw_1.getitemstring(i,'codigo')) then
//		MessageBox(g_titulo,'Debe introducir una incidencia en la fila ' + string(i))
//		return
//	end if
//next
//if dw_1.rowcount() > 0 then op='S'
//closewithreturn(parent,op)

closewithreturn(parent, 1)


end event

type dw_2 from datawindow within w_retirada_documentacion
boolean visible = false
integer x = 18
integer y = 204
integer width = 2734
integer height = 988
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_retirada_documentacion"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string obser, data_item

CHOOSE CASE dwo.name
	CASE 'observaciones'
		g_busqueda.titulo="Observaciones"
		obser    =this.GetItemString(row, 'observaciones')
		openwithparm(w_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
			if not isnull(obser) then 
				dw_2.SetItem(row,'observaciones',obser)
			end if
		end if
END CHOOSE
end event

type cb_1 from commandbutton within w_retirada_documentacion
integer x = 1915
integer y = 692
integer width = 343
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Guardar"
end type

event clicked;dw_1.update()
end event

