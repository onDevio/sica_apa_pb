HA$PBExportHeader$w_csd_netfocus_incidencias.srw
forward
global type w_csd_netfocus_incidencias from window
end type
type dw_1 from u_csd_dw within w_csd_netfocus_incidencias
end type
type cb_1 from commandbutton within w_csd_netfocus_incidencias
end type
end forward

global type w_csd_netfocus_incidencias from window
integer width = 3168
integer height = 1876
boolean titlebar = true
string title = "Incidencias"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
dw_1 dw_1
cb_1 cb_1
end type
global w_csd_netfocus_incidencias w_csd_netfocus_incidencias

on w_csd_netfocus_incidencias.create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_1}
end on

on w_csd_netfocus_incidencias.destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;
datastore lds_mensaje
f_centrar_ventana(this)
lds_mensaje = message.PowerObjectParm

lds_mensaje.RowsCopy(lds_mensaje.GetRow(),lds_mensaje.RowCount(), Primary!, dw_1, 1, Primary!)

end event

type dw_1 from u_csd_dw within w_csd_netfocus_incidencias
integer x = 37
integer y = 32
integer width = 3035
integer height = 1480
integer taborder = 10
string dataobject = "d_csd_netfocus2"
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean hsplitscroll = true
end type

type cb_1 from commandbutton within w_csd_netfocus_incidencias
integer x = 1353
integer y = 1576
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
end type

event clicked;Close(parent)
end event

