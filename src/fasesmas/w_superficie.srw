HA$PBExportHeader$w_superficie.srw
forward
global type w_superficie from w_response
end type
type st_1 from statictext within w_superficie
end type
type cb_1 from commandbutton within w_superficie
end type
type st_sup from statictext within w_superficie
end type
type dw_1 from u_dw within w_superficie
end type
end forward

global type w_superficie from w_response
integer width = 1531
integer height = 1236
boolean controlmenu = false
st_1 st_1
cb_1 cb_1
st_sup st_sup
dw_1 dw_1
end type
global w_superficie w_superficie

type variables
double i_sup
end variables

on w_superficie.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_1=create cb_1
this.st_sup=create st_sup
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_sup
this.Control[iCurrent+4]=this.dw_1
end on

on w_superficie.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.st_sup)
destroy(this.dw_1)
end on

event open;call super::open;i_sup  = message.doubleparm

st_sup.text = 'Nueva Superficie = ' + string(i_sup, "#,##0.00")

f_centrar_ventana(this)

dw_1.retrieve(g_id_fase)
// modificado Ricardo 2004-08-17
// Colocamos un 0 en los 3 campos de superficies
dw_1.setitem(1, 'nueva_sup_viv', 0)
dw_1.setitem(1, 'nueva_sup_garage', 0)
dw_1.setitem(1, 'nueva_sup_otros', 0)
// FIN modificado Ricardo 2004-08-17

dw_1.setitem(1, 'nueva_sup_baj', 0)
dw_1.setitem(1, 'nueva_sup_sob', 0)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_superficie
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_superficie
integer y = 1132
integer taborder = 0
end type

type st_1 from statictext within w_superficie
integer x = 37
integer y = 32
integer width = 1257
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
string text = "Introduzca la distribuci$$HEX1$$f300$$ENDHEX$$n del nuevo valor de la superficie :"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_superficie
integer x = 526
integer y = 960
integer width = 402
integer height = 112
integer taborder = 20
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

event clicked;double sup_total

dw_1.accepttext()

sup_total = dw_1.getitemnumber(1, 'nueva_sup_total')
if isnull(sup_total) then sup_total = 0

if string(sup_total) <> string(i_sup) then 
	messagebox(g_titulo, 'La superficie total no coincide con la nueva superficie')
else
	g_st_datos_superficie.sup_viv = dw_1.getitemnumber(1, 'nueva_sup_viv')
	g_st_datos_superficie.sup_gar = dw_1.getitemnumber(1, 'nueva_sup_garage')
	g_st_datos_superficie.sup_otros = dw_1.getitemnumber(1, 'nueva_sup_otros')
	g_st_datos_superficie.sup_sob = dw_1.getitemnumber(1, 'nueva_sup_sob')
	g_st_datos_superficie.sup_baj = dw_1.getitemnumber(1, 'nueva_sup_baj')
	close(parent)
end if

end event

type st_sup from statictext within w_superficie
integer x = 242
integer y = 140
integer width = 800
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_superficie
integer x = 37
integer y = 248
integer width = 1431
integer height = 644
integer taborder = 10
string dataobject = "d_valores_superficie"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;// Sobreescrito
end event

