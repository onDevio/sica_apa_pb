HA$PBExportHeader$w_fases_otras_fases.srw
forward
global type w_fases_otras_fases from window
end type
type dw_2 from u_dw within w_fases_otras_fases
end type
type cbx_automatico from checkbox within w_fases_otras_fases
end type
type cb_aceptar from commandbutton within w_fases_otras_fases
end type
type cb_nuevo from commandbutton within w_fases_otras_fases
end type
type dw_1 from u_dw within w_fases_otras_fases
end type
end forward

global type w_fases_otras_fases from window
integer width = 3255
integer height = 1396
boolean titlebar = true
string title = "Otras Fases"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
dw_2 dw_2
cbx_automatico cbx_automatico
cb_aceptar cb_aceptar
cb_nuevo cb_nuevo
dw_1 dw_1
end type
global w_fases_otras_fases w_fases_otras_fases

type variables
string i_id_expedi
end variables

on w_fases_otras_fases.create
this.dw_2=create dw_2
this.cbx_automatico=create cbx_automatico
this.cb_aceptar=create cb_aceptar
this.cb_nuevo=create cb_nuevo
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.cbx_automatico,&
this.cb_aceptar,&
this.cb_nuevo,&
this.dw_1}
end on

on w_fases_otras_fases.destroy
destroy(this.dw_2)
destroy(this.cbx_automatico)
destroy(this.cb_aceptar)
destroy(this.cb_nuevo)
destroy(this.dw_1)
end on

event open;call super::open;long x1,x2,y1,y2
string id_expedi,exp,fase,ult_fase,id_fase,n_expedi
st_fases_otras_fases st_otras_fases

f_centrar_ventana(this)

dw_2.settrans(SQLCA)
dw_2.insertrow(0)

//id_expedi = Message.Stringparm
//id_fase = 

st_otras_fases = message.PowerObjectParm
dw_1.retrieve(st_otras_fases.id_expedi, st_otras_fases.id_fase)

//dw_1.retrieve(id_expedi)
if dw_1.rowcount() = 0 then
	dw_2.enabled=false
	cb_aceptar.enabled=false
	return
end if

dw_2.enabled=true
cb_aceptar.enabled=true
dw_1.PostEvent(Rowfocuschanged!)
dw_2.postevent("csd_poner_desc")

end event

type dw_2 from u_dw within w_fases_otras_fases
event csd_poner_desc ( )
integer x = 37
integer y = 928
integer width = 3150
integer height = 164
integer taborder = 40
string dataobject = "d_fases_otras_fases_tipo_fases_est"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_poner_desc();string descripcion
descripcion = dw_1.getitemstring(1, 'descripcion')
dw_2.setitem(1, 'descripcion', dw_1.getitemstring(1, 'descripcion'))
dw_2.setitem(dw_2.getrow(), 'descripcion', dw_1.getitemstring(1, 'descripcion'))
dw_2.setitem(1, 'descripcion', descripcion)
end event

type cbx_automatico from checkbox within w_fases_otras_fases
boolean visible = false
integer x = 2313
integer y = 896
integer width = 654
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Importar N$$HEX2$$ba002000$$ENDHEX$$de Registro"
end type

type cb_aceptar from commandbutton within w_fases_otras_fases
integer x = 37
integer y = 1156
integer width = 288
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;string tipo_fase,n_expedi,id_fase,id_expedi,fase
double cuantos
st_fases_importacion_fase datos_importacion

dw_2.accepttext()

id_fase		= dw_1.GetItemString(dw_1.GetRow(),'id_fase')
id_expedi	= dw_1.GetItemString(dw_1.GetRow(),'id_expedi')

fase 			= dw_2.getitemstring( 1, 'fase')
tipo_fase 		= dw_2.GetItemString(1,'tipo')

if isnull(fase) then
	MessageBox(g_titulo,'Debe de especificar un Tipo de Actuaci$$HEX1$$f300$$ENDHEX$$n  Correcto')
	return
end if

// Modificado David - 17/02/2005
// Ahora permitimos el mismo tipo de actuaci$$HEX1$$f300$$ENDHEX$$n para que 
// se pueda importar si es otro tipo de registro
//SELECT count(*)  INTO :cuantos FROM fases  WHERE fases.id_expedi LIKE :id_expedi and fases.fase=:fase  ;
//if cuantos>0 then
//	MessageBox(g_titulo,'Este Tipo de Actuaci$$HEX1$$f300$$ENDHEX$$n YA EXISTE, debe especificar otra.')
//	return
//end if


// Modifica David - 20/10/2006
// Avisamos que ya existe y que hagan lo que quieran
SELECT count(*)  INTO :cuantos FROM fases  WHERE fases.id_expedi LIKE :id_expedi and fases.fase=:fase  ;

if cuantos>0 then Messagebox(g_titulo,'ATENCION !!! Este Tipo de Actuaci$$HEX1$$f300$$ENDHEX$$n YA existe dentro de este expediente.')


datos_importacion.id_fase = id_fase
datos_importacion.tipo_importacion = tipo_fase
datos_importacion.num_fase = fase
datos_importacion.honorarios = dw_2.getitemnumber(1, 'honorarios')
datos_importacion.descripcion = dw_2.getitemstring(1, 'descripcion')

closewithreturn(w_fases_otras_fases,datos_importacion)

end event

type cb_nuevo from commandbutton within w_fases_otras_fases
integer x = 453
integer y = 1156
integer width = 297
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;string tipo_fase
st_fases_importacion_fase datos_importacion

datos_importacion.id_fase = '-1'
datos_importacion.tipo_importacion = '-1'
datos_importacion.num_fase = '-1'

closewithreturn(w_fases_otras_fases,datos_importacion)

end event

type dw_1 from u_dw within w_fases_otras_fases
integer x = 37
integer y = 32
integer width = 3150
integer height = 868
integer taborder = 10
string dataobject = "d_fases_otras_fases"
end type

event doubleclicked;call super::doubleclicked;cb_aceptar.TriggerEvent(Clicked!)
end event

event rowfocuschanged;call super::rowfocuschanged;if this.RowCount() < 1 then return

integer i
string exp,fase,ult_fase,n_expedi,id_fase

this.selectrow(0,false)
this.selectrow(Getrow(), true)

fase=dw_1.getitemstring(currentrow,'fase')
id_fase=dw_1.getitemstring(currentrow, 'id_fase')
fase=dw_1.getitemstring(currentrow,'fase')

//fase=string(integer(fase) + 1,'000')	
//dw_2.setitem(1,'fase',fase)
string descripcion
descripcion = dw_1.getitemstring(currentrow, 'descripcion')
dw_2.setitem(1, 'descripcion', descripcion)

end event

