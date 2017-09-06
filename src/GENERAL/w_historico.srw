HA$PBExportHeader$w_historico.srw
forward
global type w_historico from window
end type
type cb_2 from commandbutton within w_historico
end type
type cb_1 from commandbutton within w_historico
end type
type dw_1 from datawindow within w_historico
end type
end forward

global type w_historico from window
integer y = 100
integer width = 3607
integer height = 1260
boolean titlebar = true
string title = "Hist$$HEX1$$f300$$ENDHEX$$rico"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_historico w_historico

on w_historico.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_historico.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;string tipo_id, tipo_modulo
dw_1.SetTransObject(SQLCA)

// Se recuperan los datos modificados de acuerdo al m$$HEX1$$f300$$ENDHEX$$dulo
tipo_id    =LeftA(message.stringparm,LenA(message.stringparm) - 2 )
tipo_modulo=RightA(message.stringparm,2)
dw_1.retrieve(tipo_id, tipo_modulo)

// Se coloca el titulo a la ventana de acuerdo al m$$HEX1$$f300$$ENDHEX$$dulo
string modulo
CHOOSE CASE tipo_modulo
	CASE '01'
		modulo = "Colegiados"
	CASE '02'
		modulo = "Expedientes"
	CASE '03'
		modulo = "Fases"
	CASE '04'
		modulo = "Musaat"
	CASE '05'
		modulo = "Facturas Emitidas"
	CASE 'VG'
		modulo = "Variables Globales"
END CHOOSE

this.title = modulo +" - Hist$$HEX1$$f300$$ENDHEX$$rico"

end event

type cb_2 from commandbutton within w_historico
integer x = 2587
integer y = 1024
integer width = 425
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
boolean default = true
end type

event clicked;if dw_1.rowcount() > 0 then dw_1.print()
end event

type cb_1 from commandbutton within w_historico
integer x = 3127
integer y = 1024
integer width = 425
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
boolean cancel = true
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_historico
integer x = 37
integer y = 32
integer width = 3515
integer height = 964
integer taborder = 10
string title = "none"
string dataobject = "d_historico"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

