HA$PBExportHeader$w_facturacion_emitida_serie.srw
forward
global type w_facturacion_emitida_serie from w_response
end type
type dw_1 from u_dw within w_facturacion_emitida_serie
end type
type cb_1 from commandbutton within w_facturacion_emitida_serie
end type
end forward

global type w_facturacion_emitida_serie from w_response
integer width = 1294
integer height = 700
string title = "Serie de Facturas"
boolean controlmenu = false
dw_1 dw_1
cb_1 cb_1
end type
global w_facturacion_emitida_serie w_facturacion_emitida_serie

on w_facturacion_emitida_serie.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_facturacion_emitida_serie.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;call super::open;dw_1.InsertRow(0)

f_centrar_ventana(this)

if f_tengo_permiso(g_usuario,'FACT_E_MOD' ,'%') = 1 then
	dw_1.object.fact_automatica.Protect = 0
	dw_1.object.fact_automatica.Color = 0
else
	dw_1.object.fact_automatica.Protect = 1
	dw_1.object.fact_automatica.Color = RGB(125,125,125)
end if

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_facturacion_emitida_serie
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_facturacion_emitida_serie
end type

type dw_1 from u_dw within w_facturacion_emitida_serie
integer x = 114
integer y = 72
integer width = 1015
integer height = 364
integer taborder = 10
string dataobject = "d_facturas_emitidas_series"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;string n_fact,serie

n_fact = this.GetItemString(1,'n_fact')

if (dwo.name = 'serie' ) and this.GetItemString(1,'fact_automatica') = 'N' then
	this.SetItem(1,'n_fact',data)
end if

if ( dwo.name = 'fact_automatica' ) and data = 'N' then
	serie = this.GetItemString(1,'serie')
	if not f_es_vacio(serie) then this.SetItem(1,'n_fact',serie)
end if
end event

type cb_1 from commandbutton within w_facturacion_emitida_serie
integer x = 425
integer y = 484
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;string texto=''
int cuantos

dw_1.AcceptText()

texto = dw_1.GetItemString(1,'serie')

if f_es_vacio(texto) then 
	texto=''
	messagebox(g_titulo, 'Debe especificar una serie')
	return
end if

string aut, n_fact

aut = dw_1.GetItemString(1,'fact_automatica')
n_fact = dw_1.GetItemString(1,'n_fact')

if aut = 'N' and f_es_vacio(n_fact) then
	MessageBox(g_titulo,'Si no utiliza facturaci$$HEX1$$f300$$ENDHEX$$n autom$$HEX1$$e100$$ENDHEX$$tica, debe indicar el n$$HEX1$$fa00$$ENDHEX$$mero de factura',StopSign!)
	return
end if

st_facturacion_emitida_nueva datos_factura

datos_factura.serie = texto
datos_factura.automatico = (aut = 'S')
datos_factura.n_fact = n_fact

CloseWithReturn(parent,datos_factura)
end event

