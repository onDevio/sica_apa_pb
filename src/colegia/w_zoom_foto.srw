HA$PBExportHeader$w_zoom_foto.srw
forward
global type w_zoom_foto from w_response
end type
type p_2 from picture within w_zoom_foto
end type
type p_1 from picture within w_zoom_foto
end type
type cb_1 from commandbutton within w_zoom_foto
end type
end forward

global type w_zoom_foto from w_response
integer width = 2688
integer height = 1764
string title = "Foto"
boolean clientedge = true
p_2 p_2
p_1 p_1
cb_1 cb_1
end type
global w_zoom_foto w_zoom_foto

event open;f_centrar_ventana(this)

string imagen

imagen = Message.StringParm

p_2.pictureName = imagen

if p_2.Width < 2505 Then 
	p_1.Width = p_2.Width
Else
	p_1.Height = p_2.Height * 2505 / p_2.Width
End If

if p_2.Height < 1404 Then 
	p_1.Height = p_2.Height
Else
	p_1.Width = p_2.Width * 1404 / p_2.Height
End If

p_1.pictureName = imagen

this.Width = p_1.Width + 200
this.Height = p_1.Height + 400

cb_1.X = p_1.X + p_1.Width/2 - 200
cb_1.Y = p_1.Y + p_1.Height + 50

end event

on w_zoom_foto.create
int iCurrent
call super::create
this.p_2=create p_2
this.p_1=create p_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_2
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.cb_1
end on

on w_zoom_foto.destroy
call super::destroy
destroy(this.p_2)
destroy(this.p_1)
destroy(this.cb_1)
end on

type p_2 from picture within w_zoom_foto
boolean visible = false
integer x = 942
integer y = 176
integer width = 471
integer height = 352
boolean originalsize = true
boolean focusrectangle = false
end type

type p_1 from picture within w_zoom_foto
integer x = 96
integer y = 64
integer width = 2505
integer height = 1404
borderstyle borderstyle = styleraised!
end type

type cb_1 from commandbutton within w_zoom_foto
integer x = 1115
integer y = 1512
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cerrar"
boolean cancel = true
boolean default = true
end type

event clicked;parent.event pfc_close()
end event

