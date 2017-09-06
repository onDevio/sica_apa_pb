HA$PBExportHeader$w_libros_duplicado.srw
forward
global type w_libros_duplicado from window
end type
type st_2 from statictext within w_libros_duplicado
end type
type cb_2 from commandbutton within w_libros_duplicado
end type
type cb_1 from commandbutton within w_libros_duplicado
end type
type st_1 from statictext within w_libros_duplicado
end type
type sle_1 from singlelineedit within w_libros_duplicado
end type
end forward

global type w_libros_duplicado from window
integer width = 1527
integer height = 656
boolean titlebar = true
string title = "Duplicaci$$HEX1$$f300$$ENDHEX$$n de Libros"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
st_2 st_2
cb_2 cb_2
cb_1 cb_1
st_1 st_1
sle_1 sle_1
end type
global w_libros_duplicado w_libros_duplicado

on w_libros_duplicado.create
this.st_2=create st_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.sle_1=create sle_1
this.Control[]={this.st_2,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.sle_1}
end on

on w_libros_duplicado.destroy
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.sle_1)
end on

event open;long x1,x2,y1,y2,xx

x1=w_aplic_frame.Height 
y1=w_aplic_frame.Width
this.x=(y1/2)-(this.width/2)
this.y=(x1/2)-(this.height/2)
end event

type st_2 from statictext within w_libros_duplicado
integer x = 187
integer y = 112
integer width = 549
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "al nuevo libro duplicado :"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_libros_duplicado
integer x = 869
integer y = 436
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
end type

event clicked;closewithreturn(w_libros_duplicado,'')
end event

type cb_1 from commandbutton within w_libros_duplicado
integer x = 279
integer y = 440
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;string n_reg
long existe
n_reg=sle_1.text
//select count(*) into :existe from libros where libros.n_registro = :n_reg;
//if existe > 0 then
//	MessageBox(g_titulo,'Ya hay un libro con este N$$HEX2$$ba002000$$ENDHEX$$de registro, por favor, introduzca otro.')
//	return 2
//end if
closewithreturn(w_libros_duplicado,n_reg)
end event

type st_1 from statictext within w_libros_duplicado
integer x = 187
integer y = 40
integer width = 974
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Introduzca el N$$HEX2$$ba002000$$ENDHEX$$de Registro que desea dar"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_libros_duplicado
integer x = 521
integer y = 236
integer width = 475
integer height = 72
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

