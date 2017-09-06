HA$PBExportHeader$w_coaatg_honos_modulaje.srw
forward
global type w_coaatg_honos_modulaje from w_response
end type
type dw_modulaje from u_csd_dw within w_coaatg_honos_modulaje
end type
type cb_1 from commandbutton within w_coaatg_honos_modulaje
end type
end forward

global type w_coaatg_honos_modulaje from w_response
integer x = 214
integer y = 221
integer width = 2318
integer height = 1548
string title = "Modulaci$$HEX1$$f300$$ENDHEX$$n de porcentajes"
dw_modulaje dw_modulaje
cb_1 cb_1
end type
global w_coaatg_honos_modulaje w_coaatg_honos_modulaje

on w_coaatg_honos_modulaje.create
int iCurrent
call super::create
this.dw_modulaje=create dw_modulaje
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_modulaje
this.Control[iCurrent+2]=this.cb_1
end on

on w_coaatg_honos_modulaje.destroy
call super::destroy
destroy(this.dw_modulaje)
destroy(this.cb_1)
end on

event open;call super::open;string id_tabla
f_centrar_ventana(this)

id_tabla = message.stringparm
dw_modulaje.retrieve(id_tabla)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_coaatg_honos_modulaje
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_coaatg_honos_modulaje
end type

type dw_modulaje from u_csd_dw within w_coaatg_honos_modulaje
integer x = 18
integer y = 32
integer width = 2245
integer height = 1232
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_coaatg_honos_modulaje"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type cb_1 from commandbutton within w_coaatg_honos_modulaje
integer x = 901
integer y = 1288
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
string text = "&Salir"
end type

event clicked;close(parent)
end event

