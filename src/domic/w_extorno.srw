HA$PBExportHeader$w_extorno.srw
forward
global type w_extorno from w_sheet
end type
type dw_listado from u_dw within w_extorno
end type
type dw_fact from u_dw within w_extorno
end type
type st_1 from statictext within w_extorno
end type
type dw_1 from u_dw within w_extorno
end type
type dw_3 from u_dw within w_extorno
end type
type cb_3 from commandbutton within w_extorno
end type
type cb_2 from commandbutton within w_extorno
end type
type cb_1 from commandbutton within w_extorno
end type
type dw_2 from u_dw within w_extorno
end type
type cb_4 from commandbutton within w_extorno
end type
end forward

global type w_extorno from w_sheet
integer width = 2629
integer height = 2244
string title = "Extorno"
string menuname = "m_cerrar"
windowstate windowstate = maximized!
boolean ib_isupdateable = false
event csd_calcular_extorno ( )
event csd_crear_lineas_fact ( )
event csd_crear_facturas ( )
event csd_crear_liquidaciones ( )
dw_listado dw_listado
dw_fact dw_fact
st_1 st_1
dw_1 dw_1
dw_3 dw_3
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
cb_4 cb_4
end type
global w_extorno w_extorno

event csd_calcular_extorno();string id_col, mensaje='', concepto, proc='N'
double i, fila_insertada, importe, extorno, porcent
datetime f_desde, f_hasta

// Validaciones
dw_2.reset()
dw_3.accepttext()
mensaje += f_valida(dw_3,'f_desde','NONULO','Debe especificar un valor en el campo Fecha Desde.')
mensaje += f_valida(dw_3,'f_hasta','NONULO','Debe especificar un valor en el campo Fecha Hasta.')
mensaje += f_valida(dw_3,'concepto','NOVACIO','Debe especificar un valor en el campo Concepto.')
if isnull(dw_3.getitemnumber(1,'porcentaje')) then mensaje += cr+'Debe especificar un valor en el campo % Extorno.'
	
if mensaje <> '' then
	messagebox(g_titulo, mensaje, stopsign!)
	return 
end if

concepto = dw_3.getitemstring(1,'concepto')
porcent = dw_3.getitemnumber(1,'porcentaje')
f_desde = datetime(date(dw_3.getitemdatetime(1,'f_desde')), time('00:00:00'))
f_hasta = datetime(date(dw_3.getitemdatetime(1,'f_hasta')), time('23:59:59'))

// DS que obtiene los gastos por colegiado en un periodo
datastore ds_fact
ds_fact = create datastore
ds_fact.dataobject = 'd_infocol_gastos_resumen'
ds_fact.settransobject(sqlca)

setpointer(hourglass!)
// Recuperamos y procesamos todos los colegiados de alta
dw_1.retrieve()
for i = 1 to dw_1.rowcount()
	st_1.text = 'Procesando ' + string(i) + ' de ' + string(dw_1.rowcount())	
	id_col = dw_1.getitemstring(i, 'id_colegiado')
	
	// Filtramos para obtener solo el concepto en cuesti$$HEX1$$f300$$ENDHEX$$n
	ds_fact.retrieve(id_col, f_desde, f_hasta, g_empresa)
	ds_fact.setFilter("csi_lineas_fact_emitidas_articulo ='" + concepto + "'")
	ds_fact.filter()

	// Si el importe <> 0 calculamos el extorno y lo marcamos para generar la factura
	if ds_fact.rowcount() > 0 then
		importe = ds_fact.getitemnumber(1, 'compute_0003')
		extorno = importe * porcent / 100
		proc = 'N'
		if extorno > 0 then proc = 'S' // No marcamos los importes negativos
	else
		importe = 0
		extorno = 0
		proc = 'N'
	end if

	fila_insertada = dw_2.insertrow(0)
	dw_2.setitem(fila_insertada, 'proc', proc)
	dw_2.setitem(fila_insertada, 'id_colegiado', dw_1.getitemstring(i, 'id_colegiado'))
	dw_2.setitem(fila_insertada, 'n_colegiado', dw_1.getitemstring(i, 'n_colegiado'))
	dw_2.setitem(fila_insertada, 'colegiado', dw_1.getitemstring(i, 'compute_3'))
	dw_2.setitem(fila_insertada, 'importe', importe)
	dw_2.setitem(fila_insertada, 'extorno', f_redondea(extorno))
next

setpointer(arrow!)
st_1.text = ''
destroy ds_fact

end event

event csd_crear_lineas_fact();// Evento que genear las lineas de factura con el concepto y el importe correspondiente
string id_articulo, descripcion, t_iva, descr_conc
double importe
int i,j

// Obtenemos el concepto, la descripci$$HEX1$$f300$$ENDHEX$$n y el tipo de iva
id_articulo = dw_3.getitemstring(1,'concepto')
descr_conc = dw_3.getitemstring(1,'descr_conc')

SELECT descripcion, t_iva  
INTO :descripcion, :t_iva  
FROM csi_articulos_servicios  
WHERE codigo = :id_articulo ;

if f_es_vacio(descr_conc) then descr_conc = descripcion

// Procesamos todos los colegiados
dw_2.accepttext()
for i=1 to dw_2.rowcount()
	if dw_2.getitemstring(i, 'proc') = 'N' then continue // Los no marcados los saltamos
	if dw_2.getitemnumber(i, 'extorno') = 0 then continue // Los de importe 0 los saltamos

	// El importe es el extorno en negativo
	importe = (-1) * dw_2.getitemnumber(i,'extorno')
	
	// Insertamos la linea
	dw_fact.event pfc_addrow()
	dw_fact.setitem(dw_fact.rowcount(),'n_col',dw_2.getitemstring(i,'n_colegiado'))
	dw_fact.setitem(dw_fact.rowcount(),'id_col',dw_2.getitemstring(i,'id_colegiado'))
	dw_fact.SetItem(dw_fact.rowcount(),'texto_adicional',descr_conc)
	dw_fact.SetItem(dw_fact.rowcount(),'unidades',1)
	dw_fact.SetItem(dw_fact.rowcount(),'precio',importe)
	dw_fact.SetItem(dw_fact.rowcount(),'importe',importe)
	dw_fact.SetItem(dw_fact.rowcount(),'t_iva',t_iva)
	dw_fact.SetItem(dw_fact.rowcount(),'importe_iva',f_aplica_t_iva(importe,t_iva))
	dw_fact.SetItem(dw_fact.rowcount(),'total_linea',importe + f_aplica_t_iva(importe,t_iva))
next

end event

event csd_crear_facturas();// Evento que crea las facturas a partir de las lineas
long i, totalfilas, j
st_facturas datos_facturacion
datastore lineas_factura

// Pasamos los datos a la estructura
datos_facturacion.serie				= dw_3.GetItemString(1,'serie')
datos_facturacion.fecha				= dw_3.GetItemDateTime(1,'fecha')
datos_facturacion.formapago		= dw_3.GetItemString(1,'formapago')
datos_facturacion.pagada			= dw_3.GetItemString(1,'pagada')
datos_facturacion.banco				= dw_3.GetItemString(1,'banco')
datos_facturacion.asunto			= dw_3.GetItemString(1,'asunto')
datos_facturacion.obs				= dw_3.GetItemString(1,'observaciones')
datos_facturacion.centro			= dw_3.GetItemString(1,'centro')
datos_facturacion.num_originales	= 0 //dw_3.GetItemNumber(1,'n_originales')
datos_facturacion.num_copias		= 0 //dw_3.GetItemNumber(1,'n_copias')
datos_facturacion.incluir_todos 	= 'S'
datos_facturacion.es_colegiado	= true
datos_facturacion.tipo_factura	= g_colegio_colegiado

SetPointer(Hourglass!)

lineas_factura = create Datastore
lineas_factura.DataObject = 'd_fases_lineas_facturas'
lineas_factura.SetTransObject(SQLCA)

// Recorremos las lineas de facturas y las insertamos en el ds que se le pasa a la funci$$HEX1$$f300$$ENDHEX$$n
totalfilas = dw_fact.RowCount()
FOR j=1 TO totalfilas
	datos_facturacion.id_receptor		= dw_fact.GetItemString(j,'id_col')
	
	lineas_factura.reset()
	lineas_factura.InsertRow(0)
	lineas_factura.SetItem(1,'descripcion',dw_fact.GetItemString(j,'texto_adicional'))
	lineas_factura.SetItem(1,'descripcion_larga',dw_fact.GetItemString(j,'texto_adicional'))
	lineas_factura.SetItem(1,'precio',dw_fact.GetItemNumber(j,'precio'))
	lineas_factura.SetItem(1,'unidades',dw_fact.GetItemNumber(j,'unidades'))
	lineas_factura.SetItem(1,'subtotal',dw_fact.GetItemNumber(j,'importe'))
	lineas_factura.SetItem(1,'t_iva',dw_fact.GetItemString(j,'t_iva'))
	lineas_factura.SetItem(1,'subtotal_iva',dw_fact.GetItemNumber(j,'importe_iva'))
	lineas_factura.SetItem(1,'articulo',dw_3.GetItemString(1,'concepto'))
	lineas_factura.SetItem(1,'total',dw_fact.GetItemNumber(j,'importe') + dw_fact.GetItemNumber(j,'importe_iva'))

	datos_facturacion.ds_lineas = lineas_factura
	
	st_1.text = 'Generando facturas...' + string(j) + ' de ' + string(totalfilas)
	f_factura(datos_facturacion)
NEXT

st_1.text = ''
destroy lineas_factura

end event

event csd_crear_liquidaciones();// Evento que genera las liquidaciones de las facturas creadas
long j, totalfilas
st_liquidacion st_liquidacion

totalfilas = dw_fact.rowcount()
for j=1 to totalfilas
	st_liquidacion.id_fase			= 'EXTORNO' // No hay minuta para enlazar
	st_liquidacion.id_col			= dw_fact.getitemstring(j, 'id_col')
	st_liquidacion.importe			= abs(dw_fact.getitemnumber(j, 'total_factura'))
	st_liquidacion.importe_suma	= abs(dw_fact.getitemnumber(j, 'total_factura'))	
	st_liquidacion.concepto			= dw_3.getitemstring(1,'conc_liq')
	st_liquidacion.forma_pago		= dw_3.getitemstring(1,'formapago_liq')
	st_liquidacion.tipo				= '1'
	st_liquidacion.f_entrada 		= dw_3.getitemdatetime(1,'f_liquidacion')
	st_liquidacion.contabilizada 	= 'N'
	f_liquidacion(st_liquidacion)

	st_1.text = 'Generando liquidaciones...' + string(j) + ' de ' + string(totalfilas)
next

st_1.text = ''
MessageBox(g_titulo, 'Proceso finalizado.', Information!)

end event

on w_extorno.create
int iCurrent
call super::create
if this.MenuName = "m_cerrar" then this.MenuID = create m_cerrar
this.dw_listado=create dw_listado
this.dw_fact=create dw_fact
this.st_1=create st_1
this.dw_1=create dw_1
this.dw_3=create dw_3
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_listado
this.Control[iCurrent+2]=this.dw_fact
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.dw_2
this.Control[iCurrent+10]=this.cb_4
end on

on w_extorno.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_listado)
destroy(this.dw_fact)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.cb_4)
end on

event open;call super::open;dw_3.insertrow(0)

dw_3.setitem(1, 'f_desde', datetime(date('01/01/'+g_ejercicio),time('00:00')))
dw_3.setitem(1, 'f_hasta', datetime(date('31/12/'+g_ejercicio),time('00:00')))
dw_3.setitem(1, 'concepto', g_codigos_conceptos.cip)

string concepto

SELECT csi_articulos_servicios.concepto_conta  
INTO :concepto  
FROM csi_articulos_servicios  
WHERE csi_articulos_servicios.codigo = :g_codigos_conceptos.cip   ;

dw_3.SetItem(1,'serie',g_facturas_negativas_serie)
dw_3.SetItem(1,'fecha',datetime(Today()))
dw_3.SetItem(1,'formapago',g_formas_pago.liquidacion)
dw_3.SetItem(1,'banco',g_banco_por_defecto)
dw_3.SetItem(1,'asunto','Extorno ' + concepto + ' A$$HEX1$$f100$$ENDHEX$$o ' + g_ejercicio)
dw_3.SetItem(1,'observaciones','Extorno ' + concepto + ' A$$HEX1$$f100$$ENDHEX$$o ' + g_ejercicio)
dw_3.SetItem(1,'descr_conc','Extorno ' + concepto)
dw_3.SetItem(1,'centro',f_devuelve_centro(g_cod_delegacion))

dw_3.SetItem(1,'f_liquidacion',datetime(Today()))
dw_3.SetItem(1,'conc_liq','Extorno ' + concepto + ' A$$HEX1$$f100$$ENDHEX$$o ' + g_ejercicio)

of_SetResize (true)
inv_resize.of_register (dw_2, "scaletobottom")
inv_resize.of_register (cb_1, "fixedtobottom")
inv_resize.of_register (cb_2, "fixedtobottom")
inv_resize.of_register (cb_3, "fixedtobottom")
inv_resize.of_register (cb_4, "fixedtobottom")
end event

event pfc_postopen();call super::pfc_postopen;//Recuperamos la consulta de Inicio en caso de que exista
This.Event csd_recuperar_consulta('INICIO')
end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_extorno
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_extorno
integer taborder = 20
end type

type dw_listado from u_dw within w_extorno
boolean visible = false
integer x = 2373
integer y = 888
integer width = 544
integer height = 188
integer taborder = 110
string dataobject = "d_extorno_listado"
boolean vscrollbar = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type dw_fact from u_dw within w_extorno
boolean visible = false
integer x = 2373
integer y = 672
integer width = 544
integer height = 188
integer taborder = 100
string dataobject = "d_colegiados_datos_factura_cualquier_col"
boolean hscrollbar = true
end type

type st_1 from statictext within w_extorno
integer x = 32
integer y = 1184
integer width = 1271
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_extorno
boolean visible = false
integer x = 2363
integer y = 448
integer width = 544
integer height = 188
integer taborder = 90
string dataobject = "d_extorno_colegiados"
boolean vscrollbar = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'EXTORNO'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

end event

type dw_3 from u_dw within w_extorno
integer x = 37
integer y = 32
integer width = 2171
integer height = 1140
integer taborder = 30
string dataobject = "d_extorno_consulta"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yy")
this.iuo_calendar.of_SetInitialValue(True)
end event

type cb_3 from commandbutton within w_extorno
integer x = 37
integer y = 1904
integer width = 402
integer height = 96
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Inicio"
end type

event clicked;parent.trigger event csd_calcular_extorno()
end event

type cb_2 from commandbutton within w_extorno
integer x = 1271
integer y = 1904
integer width = 402
integer height = 96
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generar"
end type

event clicked;if dw_2.rowcount() <= 0 then
	messagebox(g_titulo, 'No existen datos todav$$HEX1$$ed00$$ENDHEX$$a, pulse el bot$$HEX1$$f300$$ENDHEX$$n de inicio')
	return
end if

// Validaciones
string mensaje = ''
dw_3.AcceptText()
if f_es_vacio(dw_3.GetItemString(1,'concepto')) then mensaje +='Debe especificar un valor para el concepto.'+cr
if f_es_vacio(dw_3.GetItemString(1,'serie')) then mensaje +='Debe especificar una serie para las facturas.'+cr
if isnull(dw_3.GetItemdatetime(1,'fecha')) then mensaje +='Debe especificar una fecha para las facturas.'+cr
if f_es_vacio(dw_3.GetItemString(1,'formapago')) then mensaje +='Debe especificar una forma de pago para las facturas.'+cr
if f_es_vacio(dw_3.GetItemString(1,'banco')) then mensaje +='Debe especificar un banco para las facturas.'+cr
if f_es_vacio(dw_3.GetItemString(1,'asunto')) then mensaje +='Debe especificar un asunto para las facturas.'+cr
if isnull(dw_3.GetItemdatetime(1,'f_liquidacion')) then mensaje +='Debe especificar una fecha para las facturas.'+cr

if mensaje <>'' then
	Messagebox(g_titulo,mensaje)
	return
end if

// Creamos las lineas
this.enabled = false
parent.trigger event csd_crear_lineas_fact()

// Avisamos de lo que se va a hacer
int i
if dw_fact.rowcount() > 0 then
	i = messagebox(g_titulo,'Se van a generar ' + string(dw_fact.rowcount()) + ' facturas y las liquidaciones correspondientes. $$HEX1$$bf00$$ENDHEX$$Desea Continuar?',Question!,YesNo!)
	if i = 2 then return
end if

parent.trigger event csd_crear_facturas()
parent.trigger event csd_crear_liquidaciones()

end event

type cb_1 from commandbutton within w_extorno
integer x = 448
integer y = 1904
integer width = 402
integer height = 96
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Listado"
end type

event clicked;if dw_2.rowcount() <= 0 then
	messagebox(g_titulo, 'No existen datos todav$$HEX1$$ed00$$ENDHEX$$a, pulse el bot$$HEX1$$f300$$ENDHEX$$n de inicio')
	return
end if

dw_listado.reset()

dw_2.rowscopy(1, dw_2.rowcount(), Primary!, dw_listado, 1, Primary!)

dw_listado.object.periodo.text = string(dw_3.getitemdatetime(1,'f_desde'),"dd/mm/yyyy") + &
+ " a " + string(dw_3.getitemdatetime(1,'f_hasta'),"dd/mm/yyyy")


// Que elijan entre imprimirlos todos o s$$HEX1$$f300$$ENDHEX$$lo los marcados
if messagebox('Imprimir Listado','$$HEX1$$bf00$$ENDHEX$$Desea que aparezcan s$$HEX1$$f300$$ENDHEX$$lo los colegiados marcados?',Question!,YesNo!) = 1 then
	dw_listado.setfilter("proc = 'S'")
	dw_listado.filter()
end if

dw_listado.print()

end event

type dw_2 from u_dw within w_extorno
integer x = 37
integer y = 1248
integer width = 2496
integer height = 612
integer taborder = 40
string dataobject = "d_extorno_lista"
boolean hscrollbar = true
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;//this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)
this.of_SetTransObject(SQLCA)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

// Enable printpreview service
of_SetPrintPreview (true)


end event

type cb_4 from commandbutton within w_extorno
integer x = 859
integer y = 1904
integer width = 402
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Guardar Como..."
end type

event clicked;if dw_2.rowcount() <= 0 then
	messagebox(g_titulo, 'No existen datos todav$$HEX1$$ed00$$ENDHEX$$a, pulse el bot$$HEX1$$f300$$ENDHEX$$n de inicio')
	return
end if

dw_listado.reset()

dw_2.rowscopy(1, dw_2.rowcount(), Primary!, dw_listado, 1, Primary!)

dw_listado.object.periodo.text = string(dw_3.getitemdatetime(1,'f_desde'),"dd/mm/yyyy") + &
+ " a " + string(dw_3.getitemdatetime(1,'f_hasta'),"dd/mm/yyyy")


// Vamos a imprimir solo los marcados
dw_listado.setfilter("proc = 'S'")
dw_listado.filter()

dw_listado.Saveas()

end event

