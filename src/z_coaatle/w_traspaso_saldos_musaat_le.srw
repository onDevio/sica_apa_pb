HA$PBExportHeader$w_traspaso_saldos_musaat_le.srw
$PBExportComments$Esta ventana NO est$$HEX2$$e1002000$$ENDHEX$$acabada porque pidieron otra opci$$HEX1$$f300$$ENDHEX$$n.
forward
global type w_traspaso_saldos_musaat_le from w_sheet
end type
type dw_listado from u_dw within w_traspaso_saldos_musaat_le
end type
type st_1 from statictext within w_traspaso_saldos_musaat_le
end type
type dw_3 from u_dw within w_traspaso_saldos_musaat_le
end type
type cb_3 from commandbutton within w_traspaso_saldos_musaat_le
end type
type cb_2 from commandbutton within w_traspaso_saldos_musaat_le
end type
type cb_1 from commandbutton within w_traspaso_saldos_musaat_le
end type
type dw_2 from u_dw within w_traspaso_saldos_musaat_le
end type
end forward

global type w_traspaso_saldos_musaat_le from w_sheet
integer x = 214
integer y = 221
integer width = 3127
integer height = 1824
string title = "Extorno"
string menuname = "m_cerrar"
windowstate windowstate = maximized!
boolean ib_isupdateable = false
event csd_crear_liquidaciones ( )
dw_listado dw_listado
st_1 st_1
dw_3 dw_3
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
end type
global w_traspaso_saldos_musaat_le w_traspaso_saldos_musaat_le

event csd_crear_liquidaciones();//// Evento que genera las liquidaciones de las facturas creadas
//long j, totalfilas
//st_liquidacion st_liquidacion
//
//totalfilas = dw_fact.rowcount()
//for j=1 to totalfilas
//	st_liquidacion.id_fase			= 'EXTORNO' // No hay minuta para enlazar
//	st_liquidacion.id_col			= dw_fact.getitemstring(j, 'id_col')
//	st_liquidacion.importe			= abs(dw_fact.getitemnumber(j, 'total_factura'))
//	st_liquidacion.importe_suma	= abs(dw_fact.getitemnumber(j, 'total_factura'))	
//	st_liquidacion.concepto			= dw_3.getitemstring(1,'conc_liq')
//	st_liquidacion.forma_pago		= dw_3.getitemstring(1,'formapago_liq')
//	st_liquidacion.tipo				= '1'
//	st_liquidacion.f_entrada 		= dw_3.getitemdatetime(1,'f_liquidacion')
//	st_liquidacion.contabilizada 	= 'N'
//	f_liquidacion(st_liquidacion)
//
//	st_1.text = 'Generando liquidaciones...' + string(j) + ' de ' + string(totalfilas)
//next
//
//st_1.text = ''
//MessageBox(g_titulo, 'Proceso finalizado.', Information!)
//
end event

on w_traspaso_saldos_musaat_le.create
int iCurrent
call super::create
if this.MenuName = "m_cerrar" then this.MenuID = create m_cerrar
this.dw_listado=create dw_listado
this.st_1=create st_1
this.dw_3=create dw_3
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_listado
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_2
end on

on w_traspaso_saldos_musaat_le.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_listado)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
end on

event open;call super::open;dw_3.insertrow(0)

//dw_3.setitem(1, 'f_desde', datetime(date('01/01/'+g_ejercicio),time('00:00')))
//dw_3.setitem(1, 'f_hasta', datetime(date('31/12/'+g_ejercicio),time('00:00')))
//dw_3.setitem(1, 'concepto', g_codigos_conceptos.cip)

//string concepto
//
//SELECT csi_articulos_servicios.concepto_conta  
//INTO :concepto  
//FROM csi_articulos_servicios  
//WHERE csi_articulos_servicios.codigo = :g_codigos_conceptos.cip   ;
//
//dw_3.SetItem(1,'serie',g_facturas_negativas_serie)
//dw_3.SetItem(1,'fecha',datetime(Today()))
//dw_3.SetItem(1,'formapago',g_formas_pago.liquidacion)
//dw_3.SetItem(1,'banco',g_banco_por_defecto)
//dw_3.SetItem(1,'asunto','Extorno ' + concepto + ' A$$HEX1$$f100$$ENDHEX$$o ' + g_ejercicio)
//dw_3.SetItem(1,'observaciones','Extorno ' + concepto + ' A$$HEX1$$f100$$ENDHEX$$o ' + g_ejercicio)
//dw_3.SetItem(1,'descr_conc','Extorno ' + concepto)
//dw_3.SetItem(1,'centro',f_devuelve_centro(g_cod_delegacion))
//
//dw_3.SetItem(1,'f_liquidacion',datetime(Today()))
//dw_3.SetItem(1,'conc_liq','Extorno ' + concepto + ' A$$HEX1$$f100$$ENDHEX$$o ' + g_ejercicio)

of_SetResize (true)
inv_resize.of_register (dw_2, "scaletobottom")

dw_3.setitem(1, 'f_apuntes', datetime(date('01/01/'+g_ejercicio),time('00:00')))
end event

event pfc_postopen();call super::pfc_postopen;//Recuperamos la consulta de Inicio en caso de que exista
This.Event csd_recuperar_consulta('INICIO')
end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_traspaso_saldos_musaat_le
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_traspaso_saldos_musaat_le
end type

type dw_listado from u_dw within w_traspaso_saldos_musaat_le
boolean visible = false
integer x = 2391
integer y = 144
integer width = 544
integer height = 188
integer taborder = 80
string dataobject = "d_traspaso_saldo_musaat_listado_le"
boolean vscrollbar = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type st_1 from statictext within w_traspaso_saldos_musaat_le
integer x = 32
integer y = 388
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

type dw_3 from u_dw within w_traspaso_saldos_musaat_le
integer x = 37
integer y = 32
integer width = 2171
integer height = 308
integer taborder = 10
string dataobject = "d_traspaso_saldo_musaat_consulta_le"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yy")
this.iuo_calendar.of_SetInitialValue(True)
end event

type cb_3 from commandbutton within w_traspaso_saldos_musaat_le
integer x = 2258
integer y = 32
integer width = 256
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Inicio"
end type

event clicked;string id_col, mensaje='', concepto, proc='N'
double i, fila_insertada, importe, extorno, porcent, musaat, saldo
datetime f_desde, f_hasta, f_apuntes

// Validaciones
dw_2.reset()
dw_3.accepttext()
//mensaje += f_valida(dw_3,'f_desde','NONULO','Debe especificar un valor en el campo Fecha Desde.')
//mensaje += f_valida(dw_3,'f_hasta','NONULO','Debe especificar un valor en el campo Fecha Hasta.')
mensaje += f_valida(dw_3,'concepto','NOVACIO','Debe especificar un valor en el campo Concepto.')
//if isnull(dw_3.getitemnumber(1,'porcentaje')) then mensaje += cr+'Debe especificar un valor en el campo % Extorno.'
	
if mensaje <> '' then
	messagebox(g_titulo, mensaje, stopsign!)
	return 
end if

concepto = dw_3.getitemstring(1,'concepto')
//porcent = dw_3.getitemnumber(1,'porcentaje')
//f_desde = datetime(date(dw_3.getitemdatetime(1,'f_desde')), time('00:00:00'))
//f_hasta = datetime(date(dw_3.getitemdatetime(1,'f_hasta')), time('23:59:59'))
f_apuntes = dw_3.getitemdatetime(1,'f_apuntes')

setpointer(hourglass!)
// DS que obtiene el importe de la cuota de musaat por colegiado
datastore ds_cuota
ds_cuota = create datastore
ds_cuota.dataobject = 'd_conceptos_bancarios'
ds_cuota.settransobject(sqlca)
// Filtramos para obtener solo el concepto en cuesti$$HEX1$$f300$$ENDHEX$$n
ds_cuota.retrieve()
ds_cuota.setFilter("concepto ='" + concepto + "'")
ds_cuota.filter()


// Recuperamos y procesamos los colegiados con cuota
//dw_1.retrieve()
for i = 1 to ds_cuota.rowcount()
	st_1.text = 'Procesando ' + string(i) + ' de ' + string(ds_cuota.rowcount())	
	id_col = ds_cuota.getitemstring(i, 'id_colegiado')
	
//	if ds_fact.rowcount() > 0 then
//		importe = ds_fact.getitemnumber(1, 'compute_0003')
//		extorno = importe * porcent / 100
//		proc = 'N'
//		if extorno > 0 then proc = 'S' // No marcamos los importes negativos
//	else
//		importe = 0
//		extorno = 0
//		proc = 'N'
//	end if

	musaat = ds_cuota.getitemnumber(i, 'importe')
	saldo = f_colegiado_saldo_cuenta_fecha(id_col, g_prefijo_arqui_rf+'%',f_apuntes)*(-1)
	if saldo < 0 then
		importe = 0
	elseif musaat>= saldo then
		importe = saldo
	else
		importe = musaat
	end if

	proc = 'N'
	if importe > 0 then proc = 'S'

	fila_insertada = dw_2.insertrow(0)
	dw_2.setitem(fila_insertada, 'proc', proc)
	dw_2.setitem(fila_insertada, 'id_colegiado', ds_cuota.getitemstring(i, 'id_colegiado'))
	dw_2.setitem(fila_insertada, 'n_colegiado', ds_cuota.getitemstring(i, 'n_colegiado'))
	dw_2.setitem(fila_insertada, 'colegiado', ds_cuota.getitemstring(i, 'apell_col'))
	dw_2.setitem(fila_insertada, 'musaat', musaat)
	dw_2.setitem(fila_insertada, 'saldo', saldo)
	dw_2.setitem(fila_insertada, 'importe', importe)
	
next

setpointer(arrow!)
st_1.text = ''
destroy ds_cuota

end event

type cb_2 from commandbutton within w_traspaso_saldos_musaat_le
integer x = 2770
integer y = 32
integer width = 256
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generar"
end type

event clicked;//if dw_2.rowcount() <= 0 then
//	messagebox(g_titulo, 'No existen datos todav$$HEX1$$ed00$$ENDHEX$$a, pulse el bot$$HEX1$$f300$$ENDHEX$$n de inicio')
//	return
//end if
//
//// Validaciones
//string mensaje = ''
//dw_3.AcceptText()
//if f_es_vacio(dw_3.GetItemString(1,'concepto')) then mensaje +='Debe especificar un valor para el concepto.'+cr
//if f_es_vacio(dw_3.GetItemString(1,'serie')) then mensaje +='Debe especificar una serie para las facturas.'+cr
//if isnull(dw_3.GetItemdatetime(1,'fecha')) then mensaje +='Debe especificar una fecha para las facturas.'+cr
//if f_es_vacio(dw_3.GetItemString(1,'formapago')) then mensaje +='Debe especificar una forma de pago para las facturas.'+cr
//if f_es_vacio(dw_3.GetItemString(1,'banco')) then mensaje +='Debe especificar un banco para las facturas.'+cr
//if f_es_vacio(dw_3.GetItemString(1,'asunto')) then mensaje +='Debe especificar un asunto para las facturas.'+cr
//if isnull(dw_3.GetItemdatetime(1,'f_liquidacion')) then mensaje +='Debe especificar una fecha para las facturas.'+cr
//
//if mensaje <>'' then
//	Messagebox(g_titulo,mensaje)
//	return
//end if
//
//// Creamos las lineas
//this.enabled = false
//parent.trigger event csd_crear_lineas_fact()
//
//// Avisamos de lo que se va a hacer
//int i
//if dw_fact.rowcount() > 0 then
//	i = messagebox(g_titulo,'Se van a generar ' + string(dw_fact.rowcount()) + ' facturas y las liquidaciones correspondientes. $$HEX1$$bf00$$ENDHEX$$Desea Continuar?',Question!,YesNo!)
//	if i = 2 then return
//end if
//
//parent.trigger event csd_crear_facturas()
//parent.trigger event csd_crear_liquidaciones()
//
end event

type cb_1 from commandbutton within w_traspaso_saldos_musaat_le
integer x = 2514
integer y = 32
integer width = 256
integer height = 84
integer taborder = 40
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

//dw_listado.object.periodo.text = string(dw_3.getitemdatetime(1,'f_desde'),"dd/mm/yyyy") + &
//+ " a " + string(dw_3.getitemdatetime(1,'f_hasta'),"dd/mm/yyyy")

// Vamos a imprimir solo los marcados
dw_listado.setfilter("proc = 'S'")
dw_listado.filter()

dw_listado.print()

end event

type dw_2 from u_dw within w_traspaso_saldos_musaat_le
integer x = 37
integer y = 452
integer width = 2999
integer height = 1088
integer taborder = 20
string dataobject = "d_traspaso_saldo_musaat_lista_le"
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

