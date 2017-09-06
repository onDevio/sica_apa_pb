HA$PBExportHeader$w_presentacion.srw
forward
global type w_presentacion from window
end type
type st_2 from statictext within w_presentacion
end type
type st_1 from statictext within w_presentacion
end type
type p_1 from picture within w_presentacion
end type
type st_pruebas from statictext within w_presentacion
end type
end forward

global type w_presentacion from window
integer x = 823
integer y = 360
integer width = 3273
integer height = 1500
boolean enabled = false
boolean border = false
windowtype windowtype = child!
long backcolor = 276856960
st_2 st_2
st_1 st_1
p_1 p_1
st_pruebas st_pruebas
end type
global w_presentacion w_presentacion

on w_presentacion.create
this.st_2=create st_2
this.st_1=create st_1
this.p_1=create p_1
this.st_pruebas=create st_pruebas
this.Control[]={this.st_2,&
this.st_1,&
this.p_1,&
this.st_pruebas}
end on

on w_presentacion.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.st_pruebas)
end on

event open;string aviso_llegada

f_centrar_ventana(this)

if g_pruebas then 
	p_1.visible = false
	st_pruebas.visible = true	
else
	p_1.visible = true
	st_pruebas.visible = false	
end if

aviso_llegada=ProfileString(g_dir_aplicacion+"sica.ini","VISARED","aviso_llegada","N")
if aviso_llegada='S' then
	st_1.visible=true
	st_2.visible=true
else
	st_1.visible=false	
	st_2.visible=false
end if
end event

type st_2 from statictext within w_presentacion
integer x = 174
integer y = 1272
integer width = 2912
integer height = 156
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 276856960
string text = "X archivos XML"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_presentacion
integer x = 174
integer y = 1144
integer width = 2912
integer height = 156
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 276856960
string text = "X archivos en bandeja de entrada"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_1 from picture within w_presentacion
integer x = 174
integer y = 8
integer width = 2912
integer height = 892
string picturename = "bannerSica.jpg"
end type

type st_pruebas from statictext within w_presentacion
integer x = 174
integer y = 240
integer width = 2912
integer height = 892
integer textsize = -72
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 276856960
string text = "PRUEBAS"
alignment alignment = center!
boolean focusrectangle = false
end type

