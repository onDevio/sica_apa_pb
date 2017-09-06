HA$PBExportHeader$w_premaat_selecciona_beneficiario.srw
forward
global type w_premaat_selecciona_beneficiario from w_response
end type
type dw_1 from u_dw within w_premaat_selecciona_beneficiario
end type
type cb_1 from commandbutton within w_premaat_selecciona_beneficiario
end type
type cb_2 from commandbutton within w_premaat_selecciona_beneficiario
end type
end forward

global type w_premaat_selecciona_beneficiario from w_response
integer width = 2327
string title = "Selecci$$HEX1$$f300$$ENDHEX$$n Beneficiarios"
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_premaat_selecciona_beneficiario w_premaat_selecciona_beneficiario

on w_premaat_selecciona_beneficiario.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_premaat_selecciona_beneficiario.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;string id_col

f_centrar_ventana(this)
id_col = message.stringparm

dw_1.retrieve(id_col)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_premaat_selecciona_beneficiario
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_premaat_selecciona_beneficiario
end type

type dw_1 from u_dw within w_premaat_selecciona_beneficiario
integer x = 37
integer y = 40
integer width = 2245
integer height = 1116
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_premaat_selecciona_beneficiario"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetTransObject(SQLCA)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

type cb_1 from commandbutton within w_premaat_selecciona_beneficiario
string tag = "texto=general.aceptar"
integer x = 613
integer y = 1204
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
string text = "&Aceptar"
boolean default = true
end type

event clicked;Closewithreturn(parent, dw_1.getitemstring(dw_1.getrow(), 'id_cliente'))
end event

type cb_2 from commandbutton within w_premaat_selecciona_beneficiario
string tag = "texto=general.cancelar"
integer x = 1065
integer y = 1204
integer width = 402
integer height = 104
integer taborder = 40
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

event clicked;Closewithreturn(parent, '-1')
end event

