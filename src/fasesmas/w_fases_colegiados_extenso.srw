HA$PBExportHeader$w_fases_colegiados_extenso.srw
forward
global type w_fases_colegiados_extenso from w_response
end type
type dw_1 from u_dw within w_fases_colegiados_extenso
end type
type cb_1 from commandbutton within w_fases_colegiados_extenso
end type
type cb_2 from commandbutton within w_fases_colegiados_extenso
end type
end forward

global type w_fases_colegiados_extenso from w_response
integer width = 2743
integer height = 1372
string title = "Informaci$$HEX1$$f300$$ENDHEX$$n del colegiado"
boolean controlmenu = false
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_fases_colegiados_extenso w_fases_colegiados_extenso

type variables
boolean i_modificado=false
end variables

on w_fases_colegiados_extenso.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_fases_colegiados_extenso.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;DatawindowChild dwc_empresa
st_fases_colegiados datos

datos = Message.PowerObjectParm
f_centrar_ventana(this)

dw_1.GetChild('id_empresa',dwc_empresa)
dwc_empresa.SetTransObject(SQLCA)
dwc_empresa.retrieve(datos.id_col)

dw_1.InsertRow(0)
dw_1.retrieve(datos.id_fase,datos.id_col)
if dw_1.getitemstring(1,"reposicion")="S" then
	dw_1.modify( 't_14.visible=TRUE' )
	dw_1.modify( 'proy.visible=TRUE' )
else
		dw_1.modify( 't_14.visible=FALSE' )
		dw_1.modify( 'proy.visible=FALSE' )
end if
if isnull(datos.porcen_a) then datos.porcen_a=0
if isnull(datos.porcen_b) then datos.porcen_b=0
if isnull(datos.porcen_gastos) then datos.porcen_gastos=0


//dw_1.SetItem(1,'tipo_a',datos.autor)
//dw_1.SetItem(1,'tipo_d',datos.director)
//dw_1.SetItem(1,'porc_aut',datos.porcen_a)
//dw_1.SetItem(1,'porcen_d',datos.porcen_b)
//dw_1.SetItem(1,'porcen_a',datos.porcen_gastos)
//dw_1.SetItem(1,'cobertura',datos.cobertura)
//dw_1.SetItem(1,'observa',datos.observaciones)
//dw_1.SetItem(1,'facturado',datos.facturado)
//dw_1.SetItem(1,'renunciado',datos.renunciado)
//dw_1.SetItem(1,'tipo_gestion',datos.tipo_gestion)
//dw_1.SetItem(1,'otro_seguro',datos.otro_seguro)
//dw_1.SetItem(1,'id_col',datos.id_col)
//dw_1.SetItem(1,'coef_cm',datos.coef_cm)
//dw_1.SetItem(1,'situacion',datos.situacion)
//dw_1.SetItem(1,'c_geografico',datos.c_geografico)
//dw_1.SetItem(1,'id_empresa',datos.id_empresa)
////dw_1.SetItem(1,'empresa',datos.empresa)

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_colegiados_extenso
integer x = 206
integer y = 1532
integer taborder = 30
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_colegiados_extenso
integer x = 206
integer y = 1404
end type

type dw_1 from u_dw within w_fases_colegiados_extenso
integer x = 37
integer y = 32
integer width = 2661
integer height = 1012
integer taborder = 20
boolean bringtotop = true
string title = "Datos Colegiado"
string dataobject = "d_fases_colegiados_extenso"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;i_modificado = true
string esrepo
i_modificado = true
//if g_colegio="COAATCC" and data='S' and dwo="reposicion" then
if data='S' and dwo.name="reposicion" then
	this.modify( 't_14.visible=TRUE' )
	this.modify( 'proy.visible=TRUE' )
end if
if data='N' and dwo.name="reposicion" then
	this.modify( 't_14.visible=FALSE' )
	this.modify( 'proy.visible=FALSE' )
end if
end event

type cb_1 from commandbutton within w_fases_colegiados_extenso
integer x = 951
integer y = 1112
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;st_fases_colegiados datos

dw_1.AcceptText()

datos.autor = dw_1.GetItemString(1,'tipo_a')
datos.director = dw_1.GetItemString(1,'tipo_d')
//se cruzan los porcentajes, porque se va a operar con porcen_a para calcular las facturas.
datos.porcen_a = dw_1.GetItemNumber(1,'porc_aut') 
datos.porcen_gastos = dw_1.GetItemNumber(1,'porcen_a') //El porcentaje sobre el que se calculan las facturas
datos.porcen_b = dw_1.GetItemNumber(1,'porcen_d')
datos.cobertura = dw_1.GetItemString(1,'cobertura')
//datos.empresa = dw_1.GetItemString(1,'empresa')
datos.id_empresa = dw_1.GetItemString(1,'id_empresa')
datos.facturado = dw_1.GetItemString(1,'facturado')
datos.observaciones = dw_1.GetItemString(1,'observa')
datos.renunciado = dw_1.GetItemString(1,'renunciado')
datos.tipo_gestion = dw_1.GetItemString(1,'tipo_gestion')
datos.otro_seguro = dw_1.GetItemString(1,'otro_seguro')
datos.coef_cm = dw_1.GetItemNumber(1,'coef_cm')
datos.modificado = i_modificado
dw_1.update()
dw_1.resetupdate( )
CloseWithReturn(parent,datos)

end event

type cb_2 from commandbutton within w_fases_colegiados_extenso
integer x = 1463
integer y = 1112
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;st_fases_colegiados datos

datos.modificado = false

CloseWithReturn(parent,datos)

end event

