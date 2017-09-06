HA$PBExportHeader$w_eimporta_procesando.srw
forward
global type w_eimporta_procesando from w_response
end type
type st_1 from statictext within w_eimporta_procesando
end type
type cb_1 from commandbutton within w_eimporta_procesando
end type
end forward

global type w_eimporta_procesando from w_response
integer x = 1202
integer y = 600
integer width = 928
integer height = 512
string title = "Procesando..."
boolean controlmenu = false
st_1 st_1
cb_1 cb_1
end type
global w_eimporta_procesando w_eimporta_procesando

on w_eimporta_procesando.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_eimporta_procesando.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_1)
end on

event open;call super::open;f_centrar_ventana(this)


end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_eimporta_procesando
integer x = 0
integer y = 1292
integer width = 549
string text = "Recuperar pantalla"
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_eimporta_procesando
integer x = 5
integer y = 1180
integer width = 549
string text = "Guardar pantalla"
end type

type st_1 from statictext within w_eimporta_procesando
integer x = 101
integer y = 88
integer width = 773
integer height = 120
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Espere por favor..."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_eimporta_procesando
integer x = 238
integer y = 248
integer width = 402
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
boolean default = true
end type

event clicked;g_interrupt=true
end event

