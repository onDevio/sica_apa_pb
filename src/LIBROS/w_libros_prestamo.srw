HA$PBExportHeader$w_libros_prestamo.srw
forward
global type w_libros_prestamo from w_response
end type
type dw_1 from u_dw within w_libros_prestamo
end type
type cb_aceptar from commandbutton within w_libros_prestamo
end type
type cb_cancelar from commandbutton within w_libros_prestamo
end type
end forward

global type w_libros_prestamo from w_response
integer x = 214
integer y = 221
integer width = 1568
integer height = 992
string title = "Pr$$HEX1$$e900$$ENDHEX$$stamo"
boolean controlmenu = false
dw_1 dw_1
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
end type
global w_libros_prestamo w_libros_prestamo

type variables
st_libro_busqueda ist_parametros
end variables

on w_libros_prestamo.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_aceptar
this.Control[iCurrent+3]=this.cb_cancelar
end on

on w_libros_prestamo.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
end on

event open;call super::open;string ls_tipo

f_centrar_ventana(this)

ist_parametros =  message.PowerObjectParm
ls_tipo			=	ist_parametros.opcion

dw_1.insertrow(0)
if ls_tipo = '2' then
	this.title    = 'Devoluci$$HEX1$$f300$$ENDHEX$$n'
	dw_1.object.t_2.text = 'Devoluci$$HEX1$$f300$$ENDHEX$$n Real:'
	dw_1.object.t_1.text = 'Devoluci$$HEX1$$f300$$ENDHEX$$n Prevista:'
	dw_1.setitem(1,'f_prestamo', ist_parametros.f_prestamo_desde)
	
else
	dw_1.setitem(1, 'f_prestamo', today())
end if




end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_libros_prestamo
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_libros_prestamo
end type

type dw_1 from u_dw within w_libros_prestamo
event csd_calendario ( )
integer x = 59
integer y = 64
integer width = 1362
integer height = 456
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_libros_fecha"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_calendario;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event constructor;call super::constructor;post event csd_calendario()
end event

event itemchanged;//
end event

event clicked;//
end event

event pfc_update;return -1
end event

type cb_aceptar from commandbutton within w_libros_prestamo
integer x = 279
integer y = 728
integer width = 402
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;
string id_libro


dw_1.accepttext()
ist_parametros.f_prestamo_desde			= dw_1.GetItemdatetime(1,'f_prestamo')
ist_parametros.f_devolucion_real_desde	= dw_1.GetItemdatetime(1,'f_devolucion_prevista')
ist_parametros.isbn ='1'
CloseWithReturn(parent,ist_parametros)

end event

type cb_cancelar from commandbutton within w_libros_prestamo
integer x = 818
integer y = 728
integer width = 402
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;call super::clicked;st_libro_busqueda st_parametros

st_parametros.isbn ='-1'

CloseWithReturn(Parent,st_parametros)
end event

