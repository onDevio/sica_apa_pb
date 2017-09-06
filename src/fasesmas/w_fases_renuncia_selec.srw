HA$PBExportHeader$w_fases_renuncia_selec.srw
forward
global type w_fases_renuncia_selec from w_response
end type
type dw_seleccion from u_dw within w_fases_renuncia_selec
end type
type cb_1 from commandbutton within w_fases_renuncia_selec
end type
type cb_2 from commandbutton within w_fases_renuncia_selec
end type
end forward

global type w_fases_renuncia_selec from w_response
integer x = 214
integer y = 221
integer width = 837
integer height = 544
string title = "Seleccion"
dw_seleccion dw_seleccion
cb_1 cb_1
cb_2 cb_2
end type
global w_fases_renuncia_selec w_fases_renuncia_selec

on w_fases_renuncia_selec.create
int iCurrent
call super::create
this.dw_seleccion=create dw_seleccion
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_seleccion
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_fases_renuncia_selec.destroy
call super::destroy
destroy(this.dw_seleccion)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;string renuncia
f_centrar_ventana(this)
dw_seleccion.insertrow(0)
renuncia=Message.StringParm
if Not(IsNull(renuncia)) then dw_seleccion.SetItem(1,'renuncia',renuncia)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_renuncia_selec
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_renuncia_selec
end type

type dw_seleccion from u_dw within w_fases_renuncia_selec
integer x = 27
integer y = 20
integer width = 768
integer height = 296
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_fases_renuncia_selec"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;open(w_fases_reposiciones)
end event

type cb_1 from commandbutton within w_fases_renuncia_selec
integer x = 114
integer y = 348
integer width = 283
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
end type

event clicked;CloseWithReturn(parent,dw_seleccion.GetItemString(1,'renuncia'))
end event

type cb_2 from commandbutton within w_fases_renuncia_selec
integer x = 430
integer y = 348
integer width = 288
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
end type

event clicked;Close(parent)
end event

