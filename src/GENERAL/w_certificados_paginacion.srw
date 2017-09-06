HA$PBExportHeader$w_certificados_paginacion.srw
forward
global type w_certificados_paginacion from window
end type
type dw_1 from datawindow within w_certificados_paginacion
end type
type cb_1 from commandbutton within w_certificados_paginacion
end type
end forward

global type w_certificados_paginacion from window
integer width = 987
integer height = 620
boolean titlebar = true
string title = "Control de paginaci$$HEX1$$f300$$ENDHEX$$n"
windowtype windowtype = response!
long backcolor = 67108864
dw_1 dw_1
cb_1 cb_1
end type
global w_certificados_paginacion w_certificados_paginacion

event open;f_centrar_ventana(this)
dw_1.settransobject(SQLCA)
dw_1.insertrow(0)
end event

on w_certificados_paginacion.create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_1}
end on

on w_certificados_paginacion.destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

type dw_1 from datawindow within w_certificados_paginacion
integer x = 87
integer y = 52
integer width = 745
integer height = 280
integer taborder = 10
string title = "none"
string dataobject = "d_certificados_paginacion"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_certificados_paginacion
integer x = 530
integer y = 420
integer width = 402
integer height = 96
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
end type

event clicked;dw_1.accepttext()
if dw_1.getitemstring(1,'paginacion')='S' then
	closewithreturn(parent,string(dw_1.getitemnumber(1,'pagina')))
else
	closewithreturn(parent,'0')
end if
end event

