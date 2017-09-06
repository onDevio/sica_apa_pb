HA$PBExportHeader$w_factu_e_tipo_fact.srw
forward
global type w_factu_e_tipo_fact from w_response
end type
type dw_1 from u_dw within w_factu_e_tipo_fact
end type
type cb_1 from commandbutton within w_factu_e_tipo_fact
end type
type cb_2 from commandbutton within w_factu_e_tipo_fact
end type
type cbx_1 from checkbox within w_factu_e_tipo_fact
end type
end forward

global type w_factu_e_tipo_fact from w_response
integer width = 1289
integer height = 900
string title = "Tipos de Factura"
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
cbx_1 cbx_1
end type
global w_factu_e_tipo_fact w_factu_e_tipo_fact

type variables
st_imprimir_factura_obj_impr ist_tipo_fact
end variables

event open;call super::open;f_centrar_ventana(this)

dw_1.retrieve()
end event

on w_factu_e_tipo_fact.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cbx_1
end on

on w_factu_e_tipo_fact.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cbx_1)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_factu_e_tipo_fact
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_factu_e_tipo_fact
end type

type dw_1 from u_dw within w_factu_e_tipo_fact
integer x = 41
integer y = 40
integer width = 1170
integer height = 456
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_factu_e_tipo_fact"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type cb_1 from commandbutton within w_factu_e_tipo_fact
integer x = 105
integer y = 632
integer width = 402
integer height = 104
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

event clicked;// Se pasa en la estructura 
// tipo_fact = array con los tipos seleccionados
// n_tipo    = cantidad de tipos seleccionados

int i, j=0

for i=1 to dw_1.rowcount()
	if dw_1.getitemstring(i,'activo') ='S' then
		j++
		ist_tipo_fact.tipo_fact[j]= dw_1.getitemstring(i,'codigo')
	
	end if
next
ist_tipo_fact.n_tipo = j

closewithreturn(parent,ist_tipo_fact)
end event

type cb_2 from commandbutton within w_factu_e_tipo_fact
integer x = 773
integer y = 632
integer width = 402
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;closewithreturn(parent,ist_tipo_fact)
end event

type cbx_1 from checkbox within w_factu_e_tipo_fact
boolean visible = false
integer x = 873
integer y = 48
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todos"
end type

event clicked;int i

if this.checked = true then
	for i= 1 to dw_1.rowcount()
		dw_1.setitem(i, 'activo', 'S')
	next
else
	for i= 1 to dw_1.rowcount()
		dw_1.setitem(i, 'activo', 'N')
	next
end if
end event

