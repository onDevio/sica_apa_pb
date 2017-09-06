HA$PBExportHeader$w_n_copias.srw
forward
global type w_n_copias from w_response
end type
type st_1 from statictext within w_n_copias
end type
type cb_2 from commandbutton within w_n_copias
end type
type cb_1 from commandbutton within w_n_copias
end type
type dw_1 from u_dw within w_n_copias
end type
end forward

global type w_n_copias from w_response
integer width = 882
integer height = 684
string title = "N$$HEX2$$ba002000$$ENDHEX$$Copias"
boolean controlmenu = false
event csd_comprobar_todo_cobrado ( )
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_n_copias w_n_copias

type variables
u_dw i_dw_minutas
string tipo_cobro,i_id_minuta

end variables

on w_n_copias.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
end on

on w_n_copias.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;string cons

cons = message.stringparm

f_centrar_ventana(this)

dw_1.insertrow(0)

event csd_recuperar_consulta(cons)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_n_copias
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_n_copias
end type

type st_1 from statictext within w_n_copias
integer x = 69
integer y = 64
integer width = 658
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione n$$HEX1$$fa00$$ENDHEX$$mero de copias"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_n_copias
integer x = 489
integer y = 416
integer width = 283
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;closewithreturn(parent, 'CANCELAR')

end event

type cb_1 from commandbutton within w_n_copias
integer x = 69
integer y = 416
integer width = 297
integer height = 92
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

event clicked;string  sl_copias

sl_copias = dw_1.getitemstring(1, 'n_copias')

closewithreturn(parent, sl_copias)
end event

type dw_1 from u_dw within w_n_copias
integer x = 155
integer y = 204
integer width = 507
integer height = 112
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_n_copias"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;string num

CHOOSE CASE dwo.name
	CASE 'b_mas'
		num = this.getitemstring(1, 'n_copias')
		if num < '98' then this.setitem(1, 'n_copias', string(integer(num) + 1, '00'))
	CASE 'b_men'
		num = this.getitemstring(1, 'n_copias')
		if num > '00' then this.setitem(1, 'n_copias', string(integer(num) - 1, '00'))
END CHOOSE

end event

event itemchanged;call super::itemchanged;if not isnumber(data) then this.post setitem(1, 'n_copias', '00')

end event

