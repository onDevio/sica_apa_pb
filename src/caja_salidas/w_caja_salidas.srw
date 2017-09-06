HA$PBExportHeader$w_caja_salidas.srw
forward
global type w_caja_salidas from w_response
end type
type dw_1 from u_dw within w_caja_salidas
end type
type dw_2 from u_dw within w_caja_salidas
end type
end forward

global type w_caja_salidas from w_response
integer x = 214
integer y = 221
integer width = 3191
integer height = 1912
dw_1 dw_1
dw_2 dw_2
end type
global w_caja_salidas w_caja_salidas

on w_caja_salidas.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
end on

on w_caja_salidas.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_caja_salidas
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_caja_salidas
end type

type dw_1 from u_dw within w_caja_salidas
integer x = 110
integer y = 280
integer width = 3008
integer height = 1508
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_caja_salidas_lista"
end type

type dw_2 from u_dw within w_caja_salidas
integer x = 110
integer y = 40
integer width = 2981
integer height = 216
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_caja_salidas_consulta"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

