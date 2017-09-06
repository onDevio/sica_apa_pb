HA$PBExportHeader$w_pem_minimo_aux.srw
forward
global type w_pem_minimo_aux from w_response
end type
type dw_1 from u_dw within w_pem_minimo_aux
end type
type cb_1 from commandbutton within w_pem_minimo_aux
end type
end forward

global type w_pem_minimo_aux from w_response
integer width = 2235
integer height = 1316
boolean titlebar = false
boolean controlmenu = false
boolean ib_isupdateable = false
dw_1 dw_1
cb_1 cb_1
end type
global w_pem_minimo_aux w_pem_minimo_aux

on w_pem_minimo_aux.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_pem_minimo_aux.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;call super::open;string opc

opc = message.stringparm

f_centrar_ventana(this)


choose case opc
	case 'U'
		dw_1.dataobject = 'd_usos_tarifa_2'
	case 'P'
		dw_1.dataobject = 'd_preguntas_tarifa_1'		
end choose

dw_1.settransobject(sqlca)
dw_1.retrieve()

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_pem_minimo_aux
integer x = 2427
integer y = 1084
integer taborder = 30
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_pem_minimo_aux
integer x = 2427
integer y = 956
end type

type dw_1 from u_dw within w_pem_minimo_aux
integer x = 37
integer y = 32
integer width = 2162
integer height = 1096
integer taborder = 20
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_1 from commandbutton within w_pem_minimo_aux
integer x = 946
integer y = 1192
integer width = 343
integer height = 92
integer taborder = 40
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

event clicked;dw_1.AcceptText()

closewithreturn(parent, dw_1.getitemnumber(1, 'resultado'))
end event

