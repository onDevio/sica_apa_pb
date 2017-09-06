HA$PBExportHeader$w_fase_mas_datos.srw
forward
global type w_fase_mas_datos from w_response
end type
type dw_1 from u_dw within w_fase_mas_datos
end type
type cb_1 from commandbutton within w_fase_mas_datos
end type
end forward

global type w_fase_mas_datos from w_response
integer width = 3657
integer height = 1220
string title = "Detalle de la Fase"
dw_1 dw_1
cb_1 cb_1
end type
global w_fase_mas_datos w_fase_mas_datos

on w_fase_mas_datos.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_fase_mas_datos.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;call super::open;string id_fase

f_centrar_ventana(this)

id_fase= message.stringparm

dw_1.settransobject(SQLCA)
dw_1.retrieve(id_fase)

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fase_mas_datos
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fase_mas_datos
end type

type dw_1 from u_dw within w_fase_mas_datos
integer x = 5
integer y = 40
integer width = 3589
integer height = 896
integer taborder = 10
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_fases_detalle2"
boolean vscrollbar = false
boolean ib_isupdateable = false
end type

type cb_1 from commandbutton within w_fase_mas_datos
integer x = 3182
integer y = 984
integer width = 366
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;close(parent)
end event

