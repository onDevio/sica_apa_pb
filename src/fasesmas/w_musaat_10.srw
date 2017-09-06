HA$PBExportHeader$w_musaat_10.srw
forward
global type w_musaat_10 from w_response
end type
type cb_2 from commandbutton within w_musaat_10
end type
type cb_1 from commandbutton within w_musaat_10
end type
type st_1 from statictext within w_musaat_10
end type
type dw_1 from u_dw within w_musaat_10
end type
end forward

global type w_musaat_10 from w_response
integer width = 1582
integer height = 924
cb_2 cb_2
cb_1 cb_1
st_1 st_1
dw_1 dw_1
end type
global w_musaat_10 w_musaat_10

on w_musaat_10.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_1
end on

on w_musaat_10.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;call super::open;f_centrar_ventana(this)

dw_1.insertrow(0)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_musaat_10
integer taborder = 30
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_musaat_10
end type

type cb_2 from commandbutton within w_musaat_10
integer x = 841
integer y = 668
integer width = 370
integer height = 104
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;Closewithreturn(parent,'NN')
end event

type cb_1 from commandbutton within w_musaat_10
integer x = 283
integer y = 668
integer width = 370
integer height = 104
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;string retorno, generar = 'N', facturar = 'N'

dw_1.accepttext()

if dw_1.getitemstring(1, 'generar') = 'S' then 
	generar = 'S'
else
	generar = 'N'
end if

if dw_1.getitemstring(1, 'facturar') = 'S' then
	facturar = 'S'
else
	facturar = 'N'
end if

retorno = generar + facturar
closewithreturn(parent, retorno)

end event

type st_1 from statictext within w_musaat_10
integer x = 37
integer y = 32
integer width = 800
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Esta obra es Oficial :"
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_musaat_10
integer x = 114
integer y = 132
integer width = 1326
integer height = 424
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_musaat_10"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

