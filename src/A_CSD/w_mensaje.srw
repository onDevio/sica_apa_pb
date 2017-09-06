HA$PBExportHeader$w_mensaje.srw
forward
global type w_mensaje from w_response
end type
type st_mensaje from statictext within w_mensaje
end type
type cb_1 from commandbutton within w_mensaje
end type
end forward

global type w_mensaje from w_response
integer width = 2103
integer height = 720
st_mensaje st_mensaje
cb_1 cb_1
end type
global w_mensaje w_mensaje

on w_mensaje.create
int iCurrent
call super::create
this.st_mensaje=create st_mensaje
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_mensaje
this.Control[iCurrent+2]=this.cb_1
end on

on w_mensaje.destroy
call super::destroy
destroy(this.st_mensaje)
destroy(this.cb_1)
end on

event open;st_ventana_mensaje datos_mensaje

f_centrar_ventana(this)

datos_mensaje = Message.PowerObjectParm

this.title = datos_mensaje.titulo_ventana
st_mensaje.text = datos_mensaje.mensaje

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_mensaje
integer x = 1042
integer y = 472
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_mensaje
integer x = 864
integer y = 32
end type

type st_mensaje from statictext within w_mensaje
integer x = 50
integer y = 76
integer width = 1993
integer height = 352
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_mensaje
string tag = "texto=general.aceptar"
integer x = 882
integer y = 488
integer width = 343
integer height = 92
integer taborder = 10
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

event clicked;Close(parent)
end event

