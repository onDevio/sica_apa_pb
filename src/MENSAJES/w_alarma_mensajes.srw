HA$PBExportHeader$w_alarma_mensajes.srw
forward
global type w_alarma_mensajes from w_popup
end type
type cb_1 from commandbutton within w_alarma_mensajes
end type
type st_1 from statictext within w_alarma_mensajes
end type
end forward

global type w_alarma_mensajes from w_popup
integer x = 741
integer y = 652
integer width = 1467
integer height = 236
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 255
boolean palettewindow = true
cb_1 cb_1
st_1 st_1
end type
global w_alarma_mensajes w_alarma_mensajes

on w_alarma_mensajes.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_1
end on

on w_alarma_mensajes.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.st_1)
end on

type cb_1 from commandbutton within w_alarma_mensajes
integer x = 1129
integer y = 20
integer width = 261
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
end type

event clicked;close(parent)
end event

type st_1 from statictext within w_alarma_mensajes
integer x = 41
integer y = 32
integer width = 987
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 255
boolean enabled = false
string text = "Tiene mensajes nuevos en su buz$$HEX1$$f300$$ENDHEX$$n!"
boolean focusrectangle = false
end type

