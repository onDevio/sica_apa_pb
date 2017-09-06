HA$PBExportHeader$w_facturar_documentos.srw
forward
global type w_facturar_documentos from w_response
end type
type dw_1 from u_dw within w_facturar_documentos
end type
type dw_2 from u_dw within w_facturar_documentos
end type
type cb_1 from commandbutton within w_facturar_documentos
end type
type cb_2 from commandbutton within w_facturar_documentos
end type
type st_proceso from statictext within w_facturar_documentos
end type
type dw_pago from u_dw within w_facturar_documentos
end type
end forward

global type w_facturar_documentos from w_response
integer width = 2962
integer height = 1596
string title = "Facturaci$$HEX1$$f300$$ENDHEX$$n de Documentos Anexos"
boolean controlmenu = false
dw_1 dw_1
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
st_proceso st_proceso
dw_pago dw_pago
end type
global w_facturar_documentos w_facturar_documentos

type variables
string i_id_fase
w_fases_detalle i_w
datawindow idw_colegiados, idw_otros_docs


end variables

on w_facturar_documentos.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_proceso=create st_proceso
this.dw_pago=create dw_pago
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.st_proceso
this.Control[iCurrent+6]=this.dw_pago
end on

on w_facturar_documentos.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_proceso)
destroy(this.dw_pago)
end on

event open;call super::open;i_id_fase = message.stringparm

dw_2.retrieve(i_id_fase, '')

dw_1.insertrow(0)

dw_pago.insertrow(0)
dw_pago.SetItem(1,'fecha',DateTime(Today(),Now()))
dw_pago.Setitem(1,'formapago',g_forma_pago_por_defecto)
dw_pago.SetItem(1,'banco',g_banco_por_defecto)

i_w = g_detalle_fases
idw_colegiados = i_w.idw_fases_colegiados
idw_otros_docs = i_w.idw_fases_documentos
end event

event pfc_postopen();call super::pfc_postopen;dw_pago.of_SetDropDownCalendar(True)
dw_pago.iuo_calendar.of_register(dw_pago.iuo_calendar.DDLB)
dw_pago.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_pago.iuo_calendar.of_SetInitialValue(True)

dw_pago.object.t_7.visible = false
dw_pago.object.t_8.visible = false
dw_pago.object.concepto.visible = false
dw_pago.object.lista_col.visible = false
dw_pago.object.b_1.visible = false
dw_pago.object.receptor_factura.visible = false
dw_pago.object.t_receptor_factura.visible = false

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_facturar_documentos
integer x = 1294
integer y = 1508
integer taborder = 30
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_facturar_documentos
integer x = 727
integer y = 1508
end type

type dw_1 from u_dw within w_facturar_documentos
integer x = 23
integer y = 652
integer width = 2034
integer height = 100
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_facturar_documentos_consulta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;dw_2.retrieve(i_id_fase, data)

end event

type dw_2 from u_dw within w_facturar_documentos
integer x = 37
integer y = 768
integer width = 2702
integer height = 432
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_facturar_otros_documentos"
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
inv_rowselect.of_setstyle(inv_rowselect.multiple)

end event

type cb_1 from commandbutton within w_facturar_documentos
integer x = 37
integer y = 1340
integer width = 379
integer height = 116
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Facturar"
end type

event clicked;long i=0, j=0, k=0, colegiados
string mensaje='', doc, articulo, descripcion,t_iva
double importe, porcen, suma_porcent
st_facturas datos_facturacion
datastore lineas_factura

dw_pago.AcceptText()
dw_2.AcceptText()

SetPointer(Hourglass!)

colegiados = idw_colegiados.rowcount()

doc = dw_1.getitemstring(1, 'cf_li_lo')

lineas_factura = create Datastore
lineas_factura.DataObject = 'd_fases_lineas_facturas'
lineas_factura.SetTransObject(SQLCA)

if f_es_vacio(dw_pago.GetItemString(1,'serie')) then mensaje +='Debe especificar una serie para las facturas.'+cr
if f_es_vacio(dw_pago.GetItemString(1,'formapago')) then mensaje +='Debe especificar una forma de pago para las facturas.'+cr
if f_es_vacio(dw_pago.GetItemString(1,'banco')) then mensaje +='Debe especificar un banco para las facturas.'+cr
if isnull(dw_pago.GetItemdatetime(1,'fecha')) then mensaje +='Debe especificar una fecha para las facturas.'+cr
if f_es_vacio(dw_pago.GetItemString(1,'asunto')) then mensaje +='Debe especificar un asunto para las facturas.'+cr

FOR j=1 TO dw_2.rowcount()
	if dw_2.isselected(j) then i=1
NEXT
if i=0 then mensaje +='Debe seleccionar al menos un documento.' + cr

if mensaje <>'' then
	Messagebox(g_titulo,mensaje)
	return
end if

st_proceso.text = 'Generando facturas...'

datos_facturacion.formapago		= dw_pago.GetItemString(1,'formapago')
datos_facturacion.serie				= dw_pago.GetItemString(1,'serie')
datos_facturacion.fecha				= dw_pago.GetItemDateTime(1,'fecha')
datos_facturacion.num_originales	= dw_pago.GetItemNumber(1,'n_originales')
datos_facturacion.num_copias		= dw_pago.GetItemNumber(1,'n_copias')
datos_facturacion.asunto			= dw_pago.GetItemString(1,'asunto')
datos_facturacion.id_fase			= i_id_fase
//datos_facturacion.id_minuta		= i_id_fase
datos_facturacion.es_colegiado	= true
datos_facturacion.pagada			= 'S'
datos_facturacion.banco				= dw_pago.GetItemString(1,'banco')
datos_facturacion.incluir_todos	= 'S'
datos_facturacion.tipo_factura 	= g_colegio_colegiado

// Modificado por Ricardo 10-11-03
// Porcentaje participacion
suma_porcent = 0
for k=1 to colegiados
	if idw_colegiados.getitemstring(k, 'renunciado') = 'N' then
		suma_porcent += idw_colegiados.getitemnumber(k, 'porcen_a')
	end if
next

if suma_porcent = 0 then 
	Messagebox(g_titulo, "No existe ningun colegiado al que facturar los documentos", stopsign!)
	return
end if

FOR j=1 TO dw_2.rowcount()
	if dw_2.isselected(j) then
		for k=1 to colegiados
			if idw_colegiados.getitemstring(k, 'renunciado') = 'N' then
				datos_facturacion.id_receptor = idw_colegiados.getitemstring(k, 'id_col')
				porcen = idw_colegiados.getitemnumber(k, 'porcen_a')
				
				//hay que recalcular el porcentaje porque el maximo puede no ser 100% dependiendo de si hay renunciado
				porcen = porcen * 100 / suma_porcent
				
				lineas_factura.reset()
				lineas_factura.InsertRow(0)
				
				SELECT descripcion,importe,t_iva INTO :descripcion,:importe,:t_iva  
				FROM csi_articulos_servicios  WHERE codigo = :doc ;
				
				importe = f_redondea(importe*porcen/100)
				
				lineas_factura.SetItem(1,'descripcion', descripcion)
				lineas_factura.SetItem(1,'descripcion_larga',descripcion)
				lineas_factura.SetItem(1,'precio',importe)
				lineas_factura.SetItem(1,'unidades',1)
				lineas_factura.SetItem(1,'subtotal',importe)
				lineas_factura.SetItem(1,'t_iva',t_iva)
				lineas_factura.SetItem(1,'subtotal_iva',f_aplica_t_iva(importe,t_iva))
				lineas_factura.SetItem(1,'articulo', doc)
				lineas_factura.SetItem(1,'total',importe + f_aplica_t_iva(importe,t_iva))
			
				datos_facturacion.ds_lineas = lineas_factura
				// Si el importe es 0 no debe generar factura
				if importe <= 0 then continue
				f_factura(datos_facturacion)
				dw_2.setitem(j,'f_retira',datos_facturacion.fecha)				
			end if
		next
	end if
	st_proceso.text = 'Procesando ' + string(j) + ' de ' + string(dw_2.rowcount())
NEXT



// Codigo antiguo -->
//FOR j=1 TO dw_2.rowcount()
//	if dw_2.isselected(j) then
//		for k=1 to colegiados
//			datos_facturacion.id_receptor = idw_colegiados.getitemstring(k, 'id_col')
//			porcen = idw_colegiados.getitemnumber(k, 'porcen_a')
//			
//			lineas_factura.reset()
//			lineas_factura.InsertRow(0)
//			
//			SELECT descripcion,importe,t_iva INTO :descripcion,:importe,:t_iva  
//			FROM csi_articulos_servicios  WHERE codigo = :doc ;
//			
//			importe = f_redondea(importe*porcen/100)
//			
//			lineas_factura.SetItem(1,'descripcion', descripcion)
//			lineas_factura.SetItem(1,'descripcion_larga',descripcion)
//			lineas_factura.SetItem(1,'precio',importe)
//			lineas_factura.SetItem(1,'unidades',1)
//			lineas_factura.SetItem(1,'subtotal',importe)
//			lineas_factura.SetItem(1,'t_iva',t_iva)
//			lineas_factura.SetItem(1,'subtotal_iva',f_aplica_t_iva(importe,t_iva))
//			lineas_factura.SetItem(1,'articulo', doc)
//			lineas_factura.SetItem(1,'total',importe + f_aplica_t_iva(importe,t_iva))
//		
//			datos_facturacion.ds_lineas = lineas_factura
//			f_factura(datos_facturacion)
//		next
//	end if
//	dw_2.setitem(j,'f_retira',datos_facturacion.fecha)
//	st_proceso.text = 'Procesando ' + string(j) + ' de ' + string(dw_2.rowcount())
//NEXT
// FIN Modificado por Ricardo 10-11-03



dw_2.update()
idw_otros_docs.retrieve(i_id_fase)
st_proceso.text = 'Proceso finalizado.'
MessageBox(g_titulo, 'Proceso finalizado.', Information!)	

destroy lineas_factura

end event

type cb_2 from commandbutton within w_facturar_documentos
integer x = 2359
integer y = 1340
integer width = 379
integer height = 116
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
boolean cancel = true
boolean default = true
end type

event clicked;close(parent)

end event

type st_proceso from statictext within w_facturar_documentos
integer x = 37
integer y = 1216
integer width = 1701
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_pago from u_dw within w_facturar_documentos
integer x = 37
integer width = 2834
integer height = 652
integer taborder = 50
string dataobject = "d_colegiados_datos_factura_cualquier_con"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;CHOOSE CASE DWO.NAME 
	case 'forma_pago'
		// Colocamos el banco
		this.setitem(1, 'banco', f_banco_asociado_a_forma_pago(string(data)))
end choose
end event

event constructor;call super::constructor;datawindowchild dwc_forma_pago
// Capturamos el desplegable
this.getchild ('formapago', dwc_forma_pago)
dwc_forma_pago.settransobject (SQLCA)
dwc_forma_pago.setfilter("tipo_pago <>'CM'")
dwc_forma_pago.filter()

end event

