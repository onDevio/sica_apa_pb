HA$PBExportHeader$w_facturacion_emitida_datos_pagador.srw
forward
global type w_facturacion_emitida_datos_pagador from w_response
end type
type dw_1 from u_dw within w_facturacion_emitida_datos_pagador
end type
type cb_1 from commandbutton within w_facturacion_emitida_datos_pagador
end type
end forward

global type w_facturacion_emitida_datos_pagador from w_response
integer width = 1970
integer height = 1036
string title = "Serie de Facturas"
boolean controlmenu = false
dw_1 dw_1
cb_1 cb_1
end type
global w_facturacion_emitida_datos_pagador w_facturacion_emitida_datos_pagador

on w_facturacion_emitida_datos_pagador.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_facturacion_emitida_datos_pagador.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;call super::open;string id_factura

id_factura = message.stringparm

if f_es_vacio(id_factura) then 
	return
end if
dw_1.retrieve(id_factura)

f_centrar_ventana(this)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_facturacion_emitida_datos_pagador
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_facturacion_emitida_datos_pagador
end type

type dw_1 from u_dw within w_facturacion_emitida_datos_pagador
integer x = 114
integer y = 72
integer width = 1691
integer height = 632
integer taborder = 10
string dataobject = "d_facturas_emitidas_datos_pagador"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type cb_1 from commandbutton within w_facturacion_emitida_datos_pagador
integer x = 800
integer y = 780
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;close(parent)
end event

