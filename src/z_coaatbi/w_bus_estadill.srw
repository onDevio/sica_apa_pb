HA$PBExportHeader$w_bus_estadill.srw
$PBExportComments$A revisar (for_biz.pbl)
forward
global type w_bus_estadill from window
end type
type rb_2 from radiobutton within w_bus_estadill
end type
type rb_1 from radiobutton within w_bus_estadill
end type
type sle_1 from singlelineedit within w_bus_estadill
end type
type st_2 from statictext within w_bus_estadill
end type
type st_1 from statictext within w_bus_estadill
end type
type ddlb_1 from dropdownlistbox within w_bus_estadill
end type
type cb_2 from commandbutton within w_bus_estadill
end type
type cb_1 from commandbutton within w_bus_estadill
end type
type gb_1 from groupbox within w_bus_estadill
end type
end forward

global type w_bus_estadill from window
integer x = 786
integer y = 600
integer width = 2075
integer height = 1200
boolean titlebar = true
string title = "Estadillo Consejo General"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 82042848
rb_2 rb_2
rb_1 rb_1
sle_1 sle_1
st_2 st_2
st_1 st_1
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
end type
global w_bus_estadill w_bus_estadill

on w_bus_estadill.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.sle_1=create sle_1
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.Control[]={this.rb_2,&
this.rb_1,&
this.sle_1,&
this.st_2,&
this.st_1,&
this.ddlb_1,&
this.cb_2,&
this.cb_1,&
this.gb_1}
end on

on w_bus_estadill.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
end on

type rb_2 from radiobutton within w_bus_estadill
integer x = 1179
integer y = 692
integer width = 375
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 82042848
string text = "Habilitados"
borderstyle borderstyle = stylelowered!
end type

type rb_1 from radiobutton within w_bus_estadill
integer x = 430
integer y = 692
integer width = 384
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 82042848
string text = "Colegiados"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_bus_estadill
integer x = 553
integer y = 360
integer width = 247
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_bus_estadill
integer x = 265
integer y = 368
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 82042848
boolean enabled = false
string text = "A$$HEX1$$d100$$ENDHEX$$O:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_bus_estadill
integer x = 265
integer y = 180
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 82042848
boolean enabled = false
string text = "MES:"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_bus_estadill
integer x = 553
integer y = 136
integer width = 1248
integer height = 504
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"ENERO","FEBRERO","MARZO","ABRIL","MAYO","JUNIO","JULIO","AGOSTO","SEPTIEMBRE","OCTUBRE","NOVIEMBRE","DICIEMBRE"}
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_bus_estadill
integer x = 1175
integer y = 908
integer width = 329
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
end type

on clicked;close(parent)
end on

type cb_1 from commandbutton within w_bus_estadill
integer x = 416
integer y = 904
integer width = 302
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Aceptar"
boolean default = true
end type

event clicked;//open(w_estadillo2)
end event

type gb_1 from groupbox within w_bus_estadill
integer x = 247
integer y = 572
integer width = 1541
integer height = 260
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 82042848
string text = "Tipo de Estadillo"
borderstyle borderstyle = stylelowered!
end type

