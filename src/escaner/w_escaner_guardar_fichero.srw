HA$PBExportHeader$w_escaner_guardar_fichero.srw
forward
global type w_escaner_guardar_fichero from w_response
end type
type sle_1 from singlelineedit within w_escaner_guardar_fichero
end type
type st_1 from statictext within w_escaner_guardar_fichero
end type
type cb_aceptar from u_cb within w_escaner_guardar_fichero
end type
type cb_cancelar from u_cb within w_escaner_guardar_fichero
end type
end forward

global type w_escaner_guardar_fichero from w_response
integer width = 1614
integer height = 560
string title = "Guardar imagen"
sle_1 sle_1
st_1 st_1
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
end type
global w_escaner_guardar_fichero w_escaner_guardar_fichero

on w_escaner_guardar_fichero.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_aceptar
this.Control[iCurrent+4]=this.cb_cancelar
end on

on w_escaner_guardar_fichero.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
end on

event open;call super::open;f_centrar_ventana(this)

sle_1.text=Message.StringParm
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_escaner_guardar_fichero
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_escaner_guardar_fichero
end type

type sle_1 from singlelineedit within w_escaner_guardar_fichero
integer x = 55
integer y = 168
integer width = 1454
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_escaner_guardar_fichero
integer x = 55
integer y = 52
integer width = 1312
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Escriba un nombre para el fichero (sin extensi$$HEX1$$f300$$ENDHEX$$n)"
boolean focusrectangle = false
end type

type cb_aceptar from u_cb within w_escaner_guardar_fichero
integer x = 361
integer y = 328
integer taborder = 11
boolean bringtotop = true
string text = "&Aceptar"
end type

event clicked;call super::clicked;CloseWithReturn(parent,sle_1.text)
end event

type cb_cancelar from u_cb within w_escaner_guardar_fichero
integer x = 741
integer y = 328
integer taborder = 21
boolean bringtotop = true
string text = "&Cancelar"
end type

event clicked;call super::clicked;Close(parent)
end event

