HA$PBExportHeader$w_factu_e_negativa.srw
forward
global type w_factu_e_negativa from w_response
end type
type dw_1 from u_dw within w_factu_e_negativa
end type
type cb_1 from commandbutton within w_factu_e_negativa
end type
type cb_2 from commandbutton within w_factu_e_negativa
end type
end forward

global type w_factu_e_negativa from w_response
integer x = 214
integer y = 221
integer width = 2057
integer height = 984
string title = "Facturas Rectificativa"
boolean controlmenu = false
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_factu_e_negativa w_factu_e_negativa

type variables
st_generar_facturas_minutas i_parametros_factura_minuta
end variables

on w_factu_e_negativa.create
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

on w_factu_e_negativa.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;
i_parametros_factura_minuta = message.PowerObjectParm

f_centrar_ventana(this)
dw_1.insertrow(0)

dw_1.setitem(1,'fecha',today())
dw_1.setitem(1,'tipo','A')
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_factu_e_negativa
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_factu_e_negativa
end type

type dw_1 from u_dw within w_factu_e_negativa
event csd_calendario ( )
integer x = 50
integer y = 92
integer width = 1938
integer height = 612
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_factu_e_negativa"
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
this.iuo_calendar.of_SetDateformat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event constructor;call super::constructor;post event csd_calendario()
end event

type cb_1 from commandbutton within w_factu_e_negativa
integer x = 512
integer y = 724
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
string text = "&Acepta"
boolean default = true
end type

event clicked;call super::clicked;long li_seleccion
string ls_id_nueva_factura, ls_n_nueva_factura


dw_1.accepttext()

i_parametros_factura_minuta.f_anul      =  dw_1.getitemdatetime(1,'fecha')
i_parametros_factura_minuta.motivo_anul =  dw_1.getitemstring(1,'motivo_anula')
i_parametros_factura_minuta.tipo_anul   =  dw_1.getitemstring(1,'tipo')

//Se genera la factura en negativo
ls_id_nueva_factura=f_genera_factura_negativa(i_parametros_factura_minuta)

i_parametros_factura_minuta.id_factura = ls_id_nueva_factura



CloseWithReturn(parent,i_parametros_factura_minuta)
end event

type cb_2 from commandbutton within w_factu_e_negativa
integer x = 1175
integer y = 724
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancela"
end type

event clicked;CloseWithReturn(parent,i_parametros_factura_minuta)
end event

