HA$PBExportHeader$w_observaciones.srw
forward
global type w_observaciones from w_busqueda
end type
type mle_observaciones from multilineedit within w_observaciones
end type
end forward

global type w_observaciones from w_busqueda
integer height = 1192
string title = "Colegiados"
boolean controlmenu = false
mle_observaciones mle_observaciones
end type
global w_observaciones w_observaciones

on w_observaciones.create
int iCurrent
call super::create
this.mle_observaciones=create mle_observaciones
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_observaciones
end on

on w_observaciones.destroy
call super::destroy
destroy(this.mle_observaciones)
end on

event open;call super::open;string texto

mle_observaciones.setfocus()
// recogemos el texto que se nos pasa como par$$HEX1$$e100$$ENDHEX$$metro y lo colocamos a menos que sea nulo
texto = message.StringParm
//IF not f_es_vacio(texto) THEN dw_1.SetItem(1, 'observaciones', texto)
IF not f_es_vacio(texto) THEN mle_observaciones.text=texto
this.mle_observaciones.displayonly=g_busqueda.solo_despliega_texto


end event

type cb_recuperar_pantalla from w_busqueda`cb_recuperar_pantalla within w_observaciones
end type

type cb_guardar_pantalla from w_busqueda`cb_guardar_pantalla within w_observaciones
end type

type sle_1 from w_busqueda`sle_1 within w_observaciones
boolean visible = false
integer taborder = 20
end type

type dw_2 from w_busqueda`dw_2 within w_observaciones
boolean visible = false
integer taborder = 50
end type

type st_1 from w_busqueda`st_1 within w_observaciones
boolean visible = false
integer width = 443
integer weight = 700
string text = "Observaciones:"
end type

type st_2 from w_busqueda`st_2 within w_observaciones
boolean visible = false
end type

type cb_1 from w_busqueda`cb_1 within w_observaciones
integer y = 948
boolean default = false
end type

event cb_1::clicked;Closewithreturn(parent, mle_observaciones.text)
end event

type cb_2 from w_busqueda`cb_2 within w_observaciones
integer y = 948
integer taborder = 60
boolean cancel = true
end type

event cb_2::clicked;call super::clicked;Message.Stringparm = '-1'
//Closewithreturn(parent, '-1')
end event

type dw_1 from w_busqueda`dw_1 within w_observaciones
boolean visible = false
integer x = 37
integer y = 196
integer taborder = 40
end type

type mle_observaciones from multilineedit within w_observaciones
integer x = 27
integer y = 44
integer width = 2610
integer height = 860
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

