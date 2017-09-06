HA$PBExportHeader$w_caja_salidas_detalle.srw
forward
global type w_caja_salidas_detalle from w_response
end type
type dw_1 from u_dw within w_caja_salidas_detalle
end type
type cb_1 from commandbutton within w_caja_salidas_detalle
end type
type cb_2 from commandbutton within w_caja_salidas_detalle
end type
end forward

global type w_caja_salidas_detalle from w_response
integer width = 2917
integer height = 1108
string title = "Salidas de Caja"
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_caja_salidas_detalle w_caja_salidas_detalle

event open;call super::open;st_caja_salidas datos

datos = message.powerobjectparm

if datos.id = 'NUEVO' then
	dw_1.InsertRow(0)
	dw_1.SetItem(1,'id_caja_salida',f_siguiente_numero('CAJA_SAL',10))
	dw_1.SetItem(1,'fecha',datos.fecha)
	dw_1.SetItem(1,'centro',datos.centro)
	dw_1.SetItem(1,'id_usuario',g_usuario)
	dw_1.SetItem(1,'empresa',g_empresa)
else
	dw_1.Retrieve(datos.id)
end if

f_centrar_ventana(this)

end event

on w_caja_salidas_detalle.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_caja_salidas_detalle.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje = ""

mensaje += f_valida(dw_1,'fecha','NONULO','Debe especificar la fecha')
mensaje += f_valida(dw_1,'centro','NOVACIO','Debe especificar el centro')
mensaje += f_valida(dw_1,'tipo','NOVACIO','Debe especificar el tipo de salida')

if mensaje<>"" then
	MessageBox(g_titulo,mensaje,StopSign!)
	return -1
end if


return 1
end event

event pfc_postopen;call super::pfc_postopen;dw_1.of_SetDropDownCalendar(True)
dw_1.iuo_calendar.of_register(dw_1.iuo_calendar.DDLB)
dw_1.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_1.iuo_calendar.of_SetInitialValue(True)

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_caja_salidas_detalle
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_caja_salidas_detalle
end type

type dw_1 from u_dw within w_caja_salidas_detalle
integer x = 64
integer y = 20
integer width = 2779
integer height = 744
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_caja_salidas_detalle"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_1 from commandbutton within w_caja_salidas_detalle
integer x = 887
integer y = 844
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
end type

event clicked;int ok

ok = parent.event pfc_save() 

if ok >=0 then close(parent)


end event

type cb_2 from commandbutton within w_caja_salidas_detalle
integer x = 1353
integer y = 844
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
boolean cancel = true
end type

event clicked;parent.ib_disableclosequery = true

close(parent)
end event

