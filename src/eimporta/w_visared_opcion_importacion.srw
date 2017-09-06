HA$PBExportHeader$w_visared_opcion_importacion.srw
forward
global type w_visared_opcion_importacion from w_response
end type
type st_2 from statictext within w_visared_opcion_importacion
end type
type cb_1 from u_cb within w_visared_opcion_importacion
end type
type cb_2 from u_cb within w_visared_opcion_importacion
end type
type st_1 from statictext within w_visared_opcion_importacion
end type
type dw_opcion_importacion from u_dw within w_visared_opcion_importacion
end type
type st_3 from statictext within w_visared_opcion_importacion
end type
type st_31 from statictext within w_visared_opcion_importacion
end type
type st_32 from statictext within w_visared_opcion_importacion
end type
type st_33 from statictext within w_visared_opcion_importacion
end type
type dw_1 from u_dw within w_visared_opcion_importacion
end type
type gb_1 from groupbox within w_visared_opcion_importacion
end type
type gb_2 from groupbox within w_visared_opcion_importacion
end type
type gb_3 from groupbox within w_visared_opcion_importacion
end type
end forward

global type w_visared_opcion_importacion from w_response
integer width = 2030
integer height = 1396
st_2 st_2
cb_1 cb_1
cb_2 cb_2
st_1 st_1
dw_opcion_importacion dw_opcion_importacion
st_3 st_3
st_31 st_31
st_32 st_32
st_33 st_33
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_visared_opcion_importacion w_visared_opcion_importacion

type variables
//string is_opcion_importacion
st_visared_detalle_importacion st_importacion
st_visared_busq_fase ist_fase
end variables

on w_visared_opcion_importacion.create
int iCurrent
call super::create
this.st_2=create st_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.dw_opcion_importacion=create dw_opcion_importacion
this.st_3=create st_3
this.st_31=create st_31
this.st_32=create st_32
this.st_33=create st_33
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_opcion_importacion
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_31
this.Control[iCurrent+8]=this.st_32
this.Control[iCurrent+9]=this.st_33
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_3
end on

on w_visared_opcion_importacion.destroy
call super::destroy
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.dw_opcion_importacion)
destroy(this.st_3)
destroy(this.st_31)
destroy(this.st_32)
destroy(this.st_33)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;
//Ponemos la opci$$HEX1$$f300$$ENDHEX$$n de cancelar por defecto
f_centrar_ventana(this)
st_importacion.tipo_importacion = '-1'

ist_fase=message.powerobjectparm

//dw q nos muestra la fase/s asociadas al paquete q se importa
if ist_fase.few then
	dw_1.DataObject='d_lista_fases_few'
end if
dw_1.settransobject(SQLCA)
dw_1.retrieve(ist_fase.n_expedi, ist_fase.n_registro)

//si no 
if dw_1.rowcount()=0 then 
	dw_opcion_importacion.object.opcion_importacion.protect=1
end if

//marcamos la 1a siempre, x defecto
dw_1.setitem(1, 'selec', 'S')
end event

event close;call super::close;closewithreturn(this,st_importacion)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_visared_opcion_importacion
integer x = 622
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_visared_opcion_importacion
integer x = 622
end type

type st_2 from statictext within w_visared_opcion_importacion
integer x = 73
integer y = 372
integer width = 914
integer height = 144
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Seleccione opci$$HEX1$$f300$$ENDHEX$$n de importaci$$HEX1$$f300$$ENDHEX$$n:"
boolean focusrectangle = false
end type

type cb_1 from u_cb within w_visared_opcion_importacion
integer x = 608
integer y = 1160
integer taborder = 11
boolean bringtotop = true
string text = "Aceptar"
end type

event clicked;call super::clicked;st_importacion.tipo_importacion = dw_opcion_importacion.getitemstring(1,'opcion_importacion')
close(parent)
end event

type cb_2 from u_cb within w_visared_opcion_importacion
integer x = 1024
integer y = 1160
integer taborder = 21
boolean bringtotop = true
string text = "Cancelar"
end type

event clicked;call super::clicked;close(parent)
end event

type st_1 from statictext within w_visared_opcion_importacion
integer x = 69
integer y = 632
integer width = 1797
integer height = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
string text = "Se crear$$HEX2$$e1002000$$ENDHEX$$una fase nueva con los datos de la fase."
boolean focusrectangle = false
end type

type dw_opcion_importacion from u_dw within w_visared_opcion_importacion
integer x = 1257
integer y = 364
integer width = 631
integer height = 176
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_visared_opcion_importacion"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;event pfc_addrow()

end event

event itemchanged;call super::itemchanged;choose case data
	case 'NO'
		st_1.text =  'Se crear$$HEX2$$e1002000$$ENDHEX$$una fase nueva con los datos de la fase.'
		dw_1.visible = false
//	case 'ST'
//		st_1.text =  'Se sobreescribir$$HEX1$$e100$$ENDHEX$$n los datos de la fase'
//		st_1.text += ' y los documentos anexados a la fase ser$$HEX1$$e100$$ENDHEX$$n sustituidos.'
	case 'AD'
		st_1.text = 'Se a$$HEX1$$f100$$ENDHEX$$adir$$HEX1$$e100$$ENDHEX$$n los documentos del paquete a la fase seleccionada: '
		if dw_1.rowcount()>0 then dw_1.visible = true
//	case 'SA'
//		st_1.text = 'Se sobreescribir$$HEX1$$e100$$ENDHEX$$n los datos de la fase'
//		st_1.text += ' y se a$$HEX1$$f100$$ENDHEX$$adir$$HEX1$$e100$$ENDHEX$$n los documentos del paquete, conservando los existentes'		
end choose
end event

type st_3 from statictext within w_visared_opcion_importacion
integer x = 64
integer y = 56
integer width = 1824
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "El sistema ha detectado, que la fase seleccionada ya fu$$HEX2$$e9002000$$ENDHEX$$importada con anterioridad"
boolean focusrectangle = false
end type

type st_31 from statictext within w_visared_opcion_importacion
integer x = 64
integer y = 108
integer width = 1824
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Deber$$HEX2$$e1002000$$ENDHEX$$elegir la opci$$HEX1$$f300$$ENDHEX$$n de importaci$$HEX1$$f300$$ENDHEX$$n para este caso:"
boolean focusrectangle = false
end type

type st_32 from statictext within w_visared_opcion_importacion
integer x = 91
integer y = 160
integer width = 1541
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "- Fase Nueva : Crear$$HEX2$$e1002000$$ENDHEX$$una fase nueva con la documentaci$$HEX1$$f300$$ENDHEX$$n asociada"
boolean focusrectangle = false
end type

type st_33 from statictext within w_visared_opcion_importacion
integer x = 91
integer y = 212
integer width = 1746
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "- A$$HEX1$$f100$$ENDHEX$$adir Documentaci$$HEX1$$f300$$ENDHEX$$n: Se a$$HEX1$$f100$$ENDHEX$$adir$$HEX2$$e1002000$$ENDHEX$$la documentaci$$HEX1$$f300$$ENDHEX$$n a la fase correspondiente"
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_visared_opcion_importacion
boolean visible = false
integer x = 69
integer y = 724
integer width = 1870
integer height = 352
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_lista_fases"
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;if data='S' then
	st_importacion.id_fase=dw_1.getitemstring(row, 'id_fase')
end if
end event

event buttonclicked;call super::buttonclicked;string id_fase

choose case dwo.name
	case 'b_1'
		id_fase= this.getitemstring(row, 'id_fase')
		openwithparm(w_fase_mas_datos, id_fase)
end choose
end event

type gb_1 from groupbox within w_visared_opcion_importacion
integer x = 32
integer y = 568
integer width = 1952
integer height = 548
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_visared_opcion_importacion
integer x = 1216
integer y = 308
integer width = 768
integer height = 260
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_3 from groupbox within w_visared_opcion_importacion
integer y = 4
integer width = 1984
integer height = 296
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

