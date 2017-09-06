HA$PBExportHeader$w_sellador_cambio_nombre.srw
forward
global type w_sellador_cambio_nombre from w_response
end type
type sle_1 from u_sle within w_sellador_cambio_nombre
end type
type st_1 from statictext within w_sellador_cambio_nombre
end type
type cb_1 from u_cb within w_sellador_cambio_nombre
end type
type cb_cancelar from u_cb within w_sellador_cambio_nombre
end type
end forward

global type w_sellador_cambio_nombre from w_response
integer width = 1815
integer height = 480
sle_1 sle_1
st_1 st_1
cb_1 cb_1
cb_cancelar cb_cancelar
end type
global w_sellador_cambio_nombre w_sellador_cambio_nombre

on w_sellador_cambio_nombre.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_cancelar
end on

on w_sellador_cambio_nombre.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_cancelar)
end on

event open;call super::open;sle_1.Text=Message.StringParm
f_centrar_ventana(this)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_sellador_cambio_nombre
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_sellador_cambio_nombre
integer taborder = 20
end type

type sle_1 from u_sle within w_sellador_cambio_nombre
integer x = 50
integer y = 136
integer width = 1678
integer taborder = 30
boolean bringtotop = true
boolean autohscroll = true
integer limit = 100
end type

type st_1 from statictext within w_sellador_cambio_nombre
integer x = 59
integer y = 72
integer width = 443
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nombre del Fichero:"
boolean focusrectangle = false
end type

type cb_1 from u_cb within w_sellador_cambio_nombre
integer x = 517
integer y = 252
integer taborder = 40
boolean bringtotop = true
string text = "&Aceptar"
end type

event clicked;call super::clicked;
CloseWithReturn(parent,sle_1.text)
end event

type cb_cancelar from u_cb within w_sellador_cambio_nombre
integer x = 896
integer y = 252
integer taborder = 50
boolean bringtotop = true
string text = "&Cancelar"
end type

event clicked;call super::clicked;CloseWithReturn(parent,"-1")
end event

