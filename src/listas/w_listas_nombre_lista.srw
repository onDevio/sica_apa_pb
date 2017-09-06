HA$PBExportHeader$w_listas_nombre_lista.srw
forward
global type w_listas_nombre_lista from window
end type
type cb_2 from commandbutton within w_listas_nombre_lista
end type
type cb_1 from commandbutton within w_listas_nombre_lista
end type
type st_1 from statictext within w_listas_nombre_lista
end type
type sle_1 from singlelineedit within w_listas_nombre_lista
end type
end forward

global type w_listas_nombre_lista from window
integer width = 1883
integer height = 512
boolean titlebar = true
string title = "Introduzca el nombre de la lista a crear"
windowtype windowtype = response!
long backcolor = 67108864
cb_2 cb_2
cb_1 cb_1
st_1 st_1
sle_1 sle_1
end type
global w_listas_nombre_lista w_listas_nombre_lista

event open;f_centrar_ventana(this)
end event

on w_listas_nombre_lista.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.sle_1=create sle_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_1,&
this.sle_1}
end on

on w_listas_nombre_lista.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.sle_1)
end on

type cb_2 from commandbutton within w_listas_nombre_lista
string tag = "texto=general.cancelar"
integer x = 1038
integer y = 268
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
end type

event clicked;Closewithreturn(parent,'')
end event

type cb_1 from commandbutton within w_listas_nombre_lista
string tag = "texto=general.aceptar"
integer x = 398
integer y = 268
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;string retonno

if f_puedo_escribir(g_usuario,'0000000023')=-1 then return -1

retonno = sle_1.text
if f_es_vacio(retonno) then
	Messagebox(g_titulo,g_idioma.of_getmsg('msg_listas.nombre_lista',"Es necesario indicar un nombre para la lista."),Stopsign!)
	return
end if
closewithreturn(parent,retonno)
end event

type st_1 from statictext within w_listas_nombre_lista
string tag = "texto=listas.nombre"
integer x = 41
integer y = 64
integer width = 219
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nombre:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_listas_nombre_lista
integer x = 283
integer y = 64
integer width = 1541
integer height = 148
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

