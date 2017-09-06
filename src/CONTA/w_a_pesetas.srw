HA$PBExportHeader$w_a_pesetas.srw
forward
global type w_a_pesetas from w_response
end type
type st_1 from statictext within w_a_pesetas
end type
type importe from editmask within w_a_pesetas
end type
type cb_cancelar from commandbutton within w_a_pesetas
end type
type cb_aceptar from commandbutton within w_a_pesetas
end type
end forward

global type w_a_pesetas from w_response
integer x = 814
integer y = 820
integer width = 1554
integer height = 356
string title = "Conversi$$HEX1$$f300$$ENDHEX$$n de Pesetas a Euros"
st_1 st_1
importe importe
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
end type
global w_a_pesetas w_a_pesetas

on w_a_pesetas.create
int iCurrent
call super::create
this.st_1=create st_1
this.importe=create importe
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.importe
this.Control[iCurrent+3]=this.cb_cancelar
this.Control[iCurrent+4]=this.cb_aceptar
end on

on w_a_pesetas.destroy
call super::destroy
destroy(this.st_1)
destroy(this.importe)
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
end on

event open;importe.text = String(f_euro_convierte(Message.DoubleParm, 'E', 'P'))
importe.SetFocus()

end event

type st_1 from statictext within w_a_pesetas
integer x = 64
integer y = 96
integer width = 558
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Importe en Pesetas:"
boolean focusrectangle = false
end type

type importe from editmask within w_a_pesetas
integer x = 645
integer y = 100
integer width = 343
integer height = 72
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,###.00"
end type

type cb_cancelar from commandbutton within w_a_pesetas
integer x = 1097
integer y = 148
integer width = 357
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
end type

event clicked;CloseWithReturn(Parent, -1 )
end event

type cb_aceptar from commandbutton within w_a_pesetas
integer x = 1097
integer y = 40
integer width = 357
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;CloseWithReturn (Parent, f_euro_convierte(Double(importe.text), 'P', 'E' ) )

end event

