HA$PBExportHeader$w_fases_visado.srw
forward
global type w_fases_visado from window
end type
type cbx_4 from checkbox within w_fases_visado
end type
type cbx_3 from checkbox within w_fases_visado
end type
type cbx_2 from checkbox within w_fases_visado
end type
type cb_2 from commandbutton within w_fases_visado
end type
type cb_1 from commandbutton within w_fases_visado
end type
type st_1 from statictext within w_fases_visado
end type
type cbx_1 from checkbox within w_fases_visado
end type
type fecha from editmask within w_fases_visado
end type
end forward

global type w_fases_visado from window
integer width = 1275
integer height = 984
boolean titlebar = true
string title = "Visto Bueno"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
cbx_4 cbx_4
cbx_3 cbx_3
cbx_2 cbx_2
cb_2 cb_2
cb_1 cb_1
st_1 st_1
cbx_1 cbx_1
fecha fecha
end type
global w_fases_visado w_fases_visado

type variables
string i_fase, i_expedi
u_dw idw_1
w_fases_detalle  i_w
end variables

on w_fases_visado.create
this.cbx_4=create cbx_4
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.cbx_1=create cbx_1
this.fecha=create fecha
this.Control[]={this.cbx_4,&
this.cbx_3,&
this.cbx_2,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.cbx_1,&
this.fecha}
end on

on w_fases_visado.destroy
destroy(this.cbx_4)
destroy(this.cbx_3)
destroy(this.cbx_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cbx_1)
destroy(this.fecha)
end on

event open;long x1,x2,y1,y2,xx
string id_fase
string id_expedi, tramite
boolean tiene_seguridad
x1=w_aplic_frame.Height 
y1=w_aplic_frame.Width
this.x=(y1/2)-(this.width/2)
this.y=(x1/2)-(this.height/2)


id_fase=message.stringparm
i_fase = id_fase
id_expedi = f_fases_id_expedi(id_fase)
i_expedi = id_expedi

tramite = f_fases_tipo_tramite(id_fase)

if g_asignar_n_visado='S' then 
	cbx_2.checked=true
else 
	cbx_2.checked=false
end if

if tramite = 'REDAP' then 
	cbx_2.checked=false
end if
//tiene_seguridad = f_tiene_seguridad(id_expedi)
//if tiene_seguridad and left(f_dame_fase(id_fase),1) <> '0' then
//	cbx_1.visible=true
//else
//	cbx_1.visible=false
//end if

fecha.text=string(today(),'dd/mm/yyyy')

i_w = g_detalle_fases
idw_1 = i_w.dw_1

end event

type cbx_4 from checkbox within w_fases_visado
integer x = 256
integer y = 416
integer width = 951
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Cambiar de estado a Visado/Tramitado"
boolean checked = true
end type

type cbx_3 from checkbox within w_fases_visado
integer x = 256
integer y = 192
integer width = 768
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Asignar fecha de visado/V$$HEX2$$ba002000$$ENDHEX$$B$$HEX1$$ba00$$ENDHEX$$"
boolean checked = true
end type

type cbx_2 from checkbox within w_fases_visado
integer x = 256
integer y = 128
integer width = 768
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Asignar n$$HEX1$$fa00$$ENDHEX$$mero de visado"
boolean checked = true
end type

type cb_2 from commandbutton within w_fases_visado
integer x = 731
integer y = 704
integer width = 343
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
boolean cancel = true
end type

event clicked;string verificado
Verificado=''
closewithreturn(w_fases_visado, verificado)
end event

type cb_1 from commandbutton within w_fases_visado
integer x = 256
integer y = 704
integer width = 343
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
boolean default = true
end type

event clicked;string Verificado,id_fase,id_informe
double aportacion,cantidad
datetime f_visado

if cbx_2.checked=true then	
	Verificado= 'V' //marco que hay que dar n$$HEX1$$fa00$$ENDHEX$$mero
else
	Verificado= 'N'
end if
	Verificado=fecha.text +Verificado //se da fecha
if cbx_3.checked=true then	

	f_visado = datetime(date(fecha.text), now())
	idw_1.setitem(1, 'f_visado', f_visado)	

end if

if cbx_4.checked=true then	
	Verificado=Verificado + '2' //Se cambia de estado
else
	Verificado=Verificado + '1'
end if

closewithreturn(w_fases_visado, verificado)
end event

type st_1 from statictext within w_fases_visado
integer x = 256
integer y = 320
integer width = 306
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Fecha V$$HEX2$$ba002000$$ENDHEX$$B$$HEX2$$ba002000$$ENDHEX$$:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_fases_visado
boolean visible = false
integer x = 256
integer y = 480
integer width = 462
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Visar Seguridad"
end type

type fecha from editmask within w_fases_visado
integer x = 585
integer y = 288
integer width = 439
integer height = 88
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "00/00/0000"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

