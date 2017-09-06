HA$PBExportHeader$w_garantias_liquidaciones.srw
forward
global type w_garantias_liquidaciones from w_lista
end type
type dw_2 from u_dw within w_garantias_liquidaciones
end type
type dw_informe from u_dw within w_garantias_liquidaciones
end type
end forward

global type w_garantias_liquidaciones from w_lista
integer width = 3735
integer height = 1880
string title = "Lista Previa de Otros Pagos"
string menuname = "m_premaat_liquidaciones_lista"
event csd_talones ( )
event csd_transferencias ( )
event csd_contabilizar ( )
event csd_informe ( )
event csd_mensual ( )
dw_2 dw_2
dw_informe dw_informe
end type
global w_garantias_liquidaciones w_garantias_liquidaciones

type variables
st_cobros_datos_remesa i_datos_remesa
boolean i_reproceso

string sql_consulta
end variables

forward prototypes
public function integer f_generar_talones (string n_talon_inicial, datetime fecha, string banco, datetime f_vencimiento, string texto_manual)
public function string wf_busca_tipo_factura (string id_factura)
public subroutine wf_crear_apunte (datetime fecha, string cuenta, string concepto, double debe, double haber, string orden_apunte, string contrapartida)
end prototypes

event csd_talones();string n_talon_inicial, banco, texto_manual
datetime fecha_talon, f_vencimiento

st_liquidacion_datos_talon ds_talon
//i_modo_liq = dw_modo_liq.GetItemString(1,'modo_liquidacion')

//if i_reproceso then
//	Messagebox(g_titulo,"Recuerde que no todas las liquidaciones est$$HEX1$$e100$$ENDHEX$$n pendientes, por lo que este proceso S$$HEX1$$d300$$ENDHEX$$LO imprime talones. NO SE ACTUALIZARAN DATOS!!",Exclamation!)
//else
	Open(w_premaat_liquid_n_talon_inicial)
	ds_talon = Message.PowerObjectParm
	if ds_talon.n_talon_inicial='-1' then return   //Opci$$HEX1$$f300$$ENDHEX$$n Cancelar de la ventana de tal$$HEX1$$f300$$ENDHEX$$n inicial
	n_talon_inicial = ds_talon.n_talon_inicial
	fecha_talon	= ds_talon.fecha_talon
	banco = ds_talon.banco
	f_vencimiento = ds_talon.f_vencimiento
	texto_manual = ds_talon.texto_manual
//end if

f_generar_talones(n_talon_inicial, fecha_talon, banco, f_vencimiento, texto_manual)

Messagebox(g_titulo,'Proceso Finalizado.')

//i_reproceso = true
//this.enabled = FALSE

end event

event csd_transferencias();string lista_liquidaciones, nombre_ventana
nombre_ventana = classname() // A fin de evitar Bad Runtime Reference
SetPointer(Hourglass!)
IF NOT gnv_control_cuentas_bancarias.of_validar_datos_bancarios_movimientos('P', dw_lista) THEN RETURN
Openwithparm(w_premaat_datos_remesa, 'GARANTIAS')
i_datos_remesa = Message.PowerObjectParm	
IF f_genera_csb34(dw_lista,i_datos_remesa,nombre_ventana, lista_liquidaciones) = -1 THEN RETURN
f_imprimir_listado_transferencias (nombre_ventana, lista_liquidaciones) 
SetPointer(Arrow!)

end event

event csd_contabilizar();// Modificado Ricardo 04-03-17
if not g_contabilidad_automatica then return

//SCP-166 Verificamos que el ejercicio contable esta abierto
if NOT f_ejercicio_abierto(g_ejercicio) then
	Messagebox(g_titulo,'El ejercicio contable '+ g_ejercicio + ' no est$$HEX2$$e1002000$$ENDHEX$$abierto. No es posible continuar con el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n.',stopsign!)
	return
end if

dw_lista.AcceptText()

string mensaje = '',factura, n_asiento, n_asiento_old, n_asiento_renumerado, formapago_ant, formapago_ult, ctabanco_d
long i, fila, continuar, cuantos, asiento
datetime fecha, fecha_anterior
double importe, saldo = 0, saldo_deudor = 0,  total_asiento = 0
string estado, concepto_base, concepto, formadepago, id_liquidacion, id_colegiado, id_beneficiario, cuenta_col, cliente, n_expedi, id_minuta
string ctabanco, contabilizada, n_documento, id_cli, cuenta_presupuestaria, nombre, desc_banco, cuenta_cp, descp_breve
boolean seguir

// ------ Pre-contabilizaci$$HEX1$$f300$$ENDHEX$$n
if isnull(g_num_digitos) or g_num_digitos > 10 or g_num_digitos < 6 then mensaje = mensaje + cr + "g_num_digitos"
if f_es_vacio(g_conta.cuenta_clientes_general) then mensaje = mensaje + cr + "g_conta.cuenta_clientes_general"
if f_es_vacio(g_prefijo_arqui) then mensaje = mensaje + cr + "g_prefijo_arqui"
if f_es_vacio(g_sica_diario.liq_honos) then mensaje = mensaje + cr + "g_sica_diario.liq_honos"
if f_es_vacio(g_t_asiento_apuntes_automaticos) then mensaje = mensaje + cr + "g_t_asiento_apuntes_automaticos"
if f_es_vacio(g_sica_t_doc.transferencia) then mensaje = mensaje + cr + "g_sica_t_doc.transferencia" 
if f_es_vacio(g_sica_t_doc.talon) then mensaje = mensaje + cr + "g_sica_t_doc.talon" 
if f_es_vacio(g_centro_por_defecto) then mensaje = mensaje + cr + "g_centro_por_defecto"

if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
if f_es_vacio(g_explotacion_por_defecto) then mensaje = mensaje + cr + "g_explotacion_por_defecto"

select count(*) into :cuantos from csi_bancos where cuenta_contable = null or cuenta_contable = '';
if cuantos > 0 then Messagebox(g_titulo,"Hay bancos sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso.",Stopsign!)


if mensaje <> '' then
	mensaje = 'Hay que definir las siguientes variables para poder contabilizar:' + cr + mensaje
	messagebox(g_titulo,mensaje,Stopsign!)
	Messagebox(g_titulo,'De momento les pondremos valores por defecto, pero no se debe poner en marcha si se lee este mensaje!!!',Stopsign!)
	continuar = Messagebox(g_titulo,'$$HEX2$$bf002000$$ENDHEX$$Desea Continuar ? ',Question!, YesNo!)
	if continuar = 2 then return	
end if

// Modificado Ricardo 2005-04-27 
// Miramos que todas las fechas a contabilizar est$$HEX1$$e100$$ENDHEX$$n dentro del periodo actual
for i = 1 to dw_lista.RowCount()
	// Permitimos que vea lo que hagamos
	yield()
	estado = dw_lista.GetItemString(i,'estado')
	if estado <> 'L' then continue
	
	contabilizada = dw_lista.GetItemString(i,'contabilizada')
	if contabilizada = 'S' then continue	
	
	if string(year(date(dw_lista.GetItemDateTime(i,'f_liquidacion'))))<>g_ejercicio then
		messagebox(g_titulo, "Alguna de las liquidaciones a contabilizar tiene una fecha que est$$HEX2$$e1002000$$ENDHEX$$fuera del ejercicio actual. El proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n se ha cancelado", stopsign! )
		return 
	end if	
next
// fin Modificado Ricardo 2005-04-27 



if f_es_vacio(g_conta.cuenta_clientes_general) then g_conta.cuenta_clientes_general = '4400000'
if f_es_vacio(g_prefijo_arqui) then g_prefijo_arqui = '430'

asiento = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.liq_otros_pagos,7))
if isnull(asiento) then asiento = 0

// Ordenamos por fecha de liquidacion
dw_lista.Setsort("f_liquidacion A, forma_pago A")
dw_lista.sort()
setnull(fecha_anterior)
setnull(formapago_ant)

// Contabilizamos las liquidadas no contabilizadas
g_apunte.n_apunte = '00000'
g_apunte.t_asiento = g_t_asiento_apuntes_automaticos
g_apunte.diario = g_sica_diario.liq_otros_pagos
g_apunte.proyecto = g_explotacion_por_defecto

for i = 1 to dw_lista.RowCount()
	// Permitimos que vea lo que hagamos
	yield()
	estado = dw_lista.GetItemString(i,'estado')
	if estado <> 'L' then continue
	contabilizada = dw_lista.GetItemString(i,'contabilizada')
	if contabilizada = 'S' then continue	
	
	if isnull(fecha_anterior) then fecha_anterior = dw_lista.GetItemDateTime(i,'f_liquidacion')

	id_liquidacion	= dw_lista.GetItemString(i,'id_liquidacion')	
	fecha 				= dw_lista.GetItemDateTime(i,'f_liquidacion')
	importe 			= dw_lista.GetItemNumber(i,'importe')
	id_colegiado 	= dw_lista.GetItemString(i,'id_colegiado')
	id_beneficiario 	= dw_lista.GetItemString(i,'id_beneficiario')	
	n_documento 	= dw_lista.GetItemString(i,'n_documento')
	id_minuta 		= dw_lista.GetItemString(i,'id_fase')
	n_expedi 		= f_dame_exp(dw_lista.GetItemString(i,'id_fase'))

	concepto_base=''
	concepto_base = 'DEVOLUCION GARANTIA - ' + n_expedi + ' - ' 
	
	formadepago = dw_lista.GetItemString(i,'forma_pago')
	ctabanco = dw_lista.GetItemString(i,'cta_pago')

	if formapago_ant <> formadepago then
		asiento++
		g_apunte.n_apunte = '00000'
	end if
	g_apunte.n_asiento = RightA('0000000' + trim(string(asiento)),7)
	g_apunte.n_doc = n_documento
	g_apunte.id_interno = id_liquidacion
	g_apunte.fecha = datetime(date(fecha), time("00:00:00"))
	g_apunte.centro = dw_lista.GetItemString(i,'centro')
	if f_es_vacio(g_apunte.centro) then g_apunte.centro = g_centro_por_defecto	
	g_apunte.cta_presupuestaria = cuenta_presupuestaria	
	
	
	
	choose case formadepago
		case g_formas_pago.transferencia
			g_apunte.t_doc = g_sica_t_doc.transferencia
		case g_formas_pago.talon
			g_apunte.t_doc = g_sica_t_doc.talon
		case g_formas_pago.metalico
			g_apunte.t_doc ='ME'
		case else
			g_apunte.t_doc = g_sica_t_doc.generico
	end choose

	if not f_es_vacio(id_beneficiario) then
		nombre = f_dame_cliente(id_beneficiario)
		//Obtenci$$HEX1$$f300$$ENDHEX$$n cuenta contable del cliente. Si es vac$$HEX1$$ed00$$ENDHEX$$a se pone la general
		select cuenta_contable into :cuenta_col from clientes where id_cliente = :id_beneficiario;
		if f_es_vacio(cuenta_col) and g_conta.crear_cuentas_clientes_terceros = 'S' then
			cuenta_col = f_cuenta_contable_defecto_cli_provs('C', id_beneficiario)
		elseif f_es_vacio(cuenta_col) then
			cuenta_col = g_conta.cuenta_clientes_general
		end if
	else
		if not f_es_vacio(id_colegiado) then
			nombre =	 f_colegiado_apellido(id_colegiado)
			cuenta_col = f_dame_cuenta_col(id_colegiado,'G') //Modificado 13/02/09 Yexa Los otros pagos se toman a la cuenta de gastos
			// Si existe la cuenta personal y es distinta de la de cuotas se contabiliza a la personal
			if not f_es_vacio(g_prefijo_cuenta_bancaria_col) then 
				cuenta_cp = f_dame_cuenta_col(id_colegiado,'CP')
				//Modificado Yexaira 20-08-2007
				// Se comprueba que la factura no provenga de un recibo rectificado
				factura = wf_busca_tipo_factura(dw_lista.getitemstring(i, 'id_factura'))
				if cuenta_col <> cuenta_cp  and isnull(factura)then cuenta_col = cuenta_cp
			end if
		else
			// Si no es a cliente ni a colegiado es a "otro"
			cuenta_col = dw_lista.GetItemString(i,'contrapartida')
		end if
	end if
	
	if f_es_vacio(nombre) then nombre = ''
	concepto_base = concepto_base + nombre

	if dw_lista.GetItemString(i,'tipo') = '3' then
		//Otros pagos
		concepto_base = dw_lista.GetItemString(i,'descripcion_larga') + ' - '
		concepto_base = concepto_base + nombre
		concepto = LeftA(concepto_base,57)
		// Apunte por el debe
		wf_crear_apunte(datetime(date(fecha), time("00:00:00")),cuenta_col, concepto, importe, 0, '00',ctabanco)
	else
		// Abono a la Cuenta de PREMAAT
		concepto = LeftA(concepto_base,57)
		// Apunte por el debe
		wf_crear_apunte(datetime(date(fecha), time("00:00:00")),g_conta.garantia_cuenta, concepto, importe, 0, '00',ctabanco)
	end if
	
	total_asiento += importe
	
	// Si no se tiene banco se busca la cuenta contable asociada de la forma de pago
	if f_es_vacio(ctabanco) then
		select cuenta, descripcion_breve,b.nombre into :ctabanco_d, :descp_breve, :desc_banco
		from csi_formas_de_pago fp,csi_bancos b where fp.tipo_pago = :formadepago and fp.banco_asociado=b.codigo and b.empresa=:g_empresa;
		ctabanco = ctabanco_d
	else
		select nombre into :desc_banco from csi_bancos where cuenta_contable = :ctabanco and empresa=:g_empresa;
		select  descripcion_breve into  :descp_breve from csi_formas_de_pago where tipo_pago = :formadepago;
		ctabanco_d = ctabanco
	end if

	if g_colegio='COAATGU' then
		Concepto ='Transferencia liquidaci$$HEX1$$f300$$ENDHEX$$n '+ desc_banco
	else
		Concepto ='Pago  '+ lower( descp_breve ) //+ctabanco	
	end if	
	
	
/*	
	// Si no se tiene banco se busca la cuenta contable asociada de la forma de pago
	if f_es_vacio(ctabanco) then
		select cuenta, descripcion_breve into :ctabanco_d, :descp_breve from csi_formas_de_pago where tipo_pago = :formadepago;
		ctabanco = ctabanco_d
	else
		select nombre into :desc_banco from csi_bancos where cuenta_contable = :ctabanco;
		select  descripcion_breve into  :descp_breve from csi_formas_de_pago where tipo_pago = :formadepago;
		ctabanco_d = ctabanco
	end if
	
	// Se busca el concepto
	Concepto ='Pago  '+ lower( descp_breve ) //+ctabanco	
*/		

	//Marcamos la liquidacion como contabilizada:
	dw_lista.SetItem(i,'contabilizada','S')
	
	if formadepago <> 'TR' then
		// Cargo a Banco apunte por el haber
		wf_crear_apunte(datetime(date(fecha), time("00:00:00")),ctabanco, concepto,0, importe, '00',cuenta_col)
		total_asiento = 0
		if (date(fecha_anterior)<>date(dw_lista.GetItemDateTime(i,'f_liquidacion'))) then
			asiento++
			g_apunte.n_apunte = '00000'
		 elseif (  i<dw_lista.RowCount()) then
			if (formadepago = dw_lista.GetItemstring(i+1,'forma_pago'))   and ( date(dw_lista.GetItemDateTime(i,'f_liquidacion'))<>date(dw_lista.GetItemDateTime(i+1,'f_liquidacion'))) then 
				asiento++
				g_apunte.n_apunte = '00000'
			end if
		end if
		 formapago_ult = formadepago
	else
		if  ((formapago_ant<> formapago_ult)  and ( formapago_ult<>'')) then 
			seguir = true
		elseif (  i=dw_lista.RowCount()) then 
			seguir = true
		elseif (  i<dw_lista.RowCount() and (formadepago<>dw_lista.GetItemstring(i+1,'forma_pago'))  ) then 
			seguir = true
		elseif (  i<dw_lista.RowCount() and (formadepago = dw_lista.GetItemstring(i+1,'forma_pago'))  )  and ( date(dw_lista.GetItemDateTime(i,'f_liquidacion'))<>date(dw_lista.GetItemDateTime(i+1,'f_liquidacion'))) then 
			asiento++
			g_apunte.n_apunte = '00000'
			seguir = true
		elseif ( date(fecha_anterior)<>date(dw_lista.GetItemDateTime(i,'f_liquidacion')))  and (formapago_ant<> 'TR')then
			seguir = true
		end if
		if seguir then
			g_apunte.n_doc = ''
			// Cargo a Banco Apunte al debe
			wf_crear_apunte(datetime(date(fecha), time("00:00:00")),ctabanco_d, concepto,0,  f_redondea(total_asiento), '00','')		
			total_asiento = 0
			g_apunte.n_apunte = '00000'
			seguir=false
		end if
	end if

	
	fecha_anterior = fecha
	formapago_ant = formadepago
next




if dw_2.RowCount()>0 then
	n_asiento = "-1"
	n_asiento_old = ''
	FOR fila = 1 to dw_2.RowCount()
		n_asiento = dw_2.getitemstring(fila, 'n_asiento')
		// Si cambia de asiento/diario, renumeramos de nuevo
		if n_asiento <> n_asiento_old  then
			n_asiento_renumerado = f_siguiente_numero_bd_ejercicio(g_sica_diario.liq_honos,7) // ESto asegura que los numeros de asiento se hagan bien
		end if
		// Cambiamos el asiento segun
		dw_2.SetItem(fila, 'n_asiento', n_asiento_renumerado)
		// Mantenemos los datos de la iteracion anterior
		n_asiento_old = n_asiento
	
	NEXT
	dw_lista.Update()
	dw_lista.groupcalc()
	dw_2.Update()
	dw_2.reset()
end if



messagebox(g_titulo, 'Proceso Finalizado')
end event

event csd_informe();string id_liq, articulo, ape, nom, ape_nom
long i, j, fila
datastore ds_lineas
double lineas_honos, lineas_gastos, importe

if dw_lista.rowcount()<= 0 then return

setpointer(hourglass!)
dw_informe.reset()

ds_lineas = create datastore
ds_lineas.dataobject = 'ds_garantias_informe_liquidacion'
ds_lineas.SetTransObject(SQLCA)


for i=1 to dw_lista.rowcount()
	id_liq = dw_lista.getitemstring(i, 'id_liquidacion')

   // Las retenidas y anuladas las saltamos
   if dw_lista.getitemString(i, 'estado')  = 'R' or dw_lista.getitemString(i, 'estado')  = 'A' then continue
	
	ds_lineas.retrieve(id_liq)
	lineas_gastos = ds_lineas.rowcount()	
	articulo = ''
	for j=1 to ds_lineas.rowcount()
		if ds_lineas.getitemstring(j, 'articulo') <> articulo then
			fila = dw_informe.insertrow(0)
			f_logo_empresa(g_empresa ,dw_informe, '008') 
			dw_informe.setitem(fila, 'id_liquidacion', dw_lista.getitemstring(i, 'id_liquidacion'))
			dw_informe.setitem(fila, 'colegiado', dw_lista.getitemstring(i, 'id_colegiado'))
			nom = dw_lista.getitemstring(i, 'nombre')
			dw_informe.setitem(fila, 'ape_nom', nom)
			dw_informe.setitem(fila, 'f_liquidacion', dw_lista.getitemdatetime(i, 'f_liquidacion'))
			dw_informe.setitem(fila, 'concepto', f_garantias_expediente(dw_lista.getitemstring(i, 'id_liquidacion')))
			importe = dw_lista.getitemnumber(i, 'importe')
			dw_informe.setitem(fila, 'importe', importe)
			dw_informe.setitem(fila, 'irpf', f_liquidacion_irpf_factura_honos(id_liq))
			articulo = ds_lineas.getitemstring(j, 'articulo')
			dw_informe.setitem(fila, 'factu_articulo', ds_lineas.getitemstring(j, 'articulo'))
			dw_informe.setitem(fila, 'factu_concepto', ds_lineas.getitemstring(j, 'descripcion_larga'))
			dw_informe.setitem(fila, 'factu_importe', ds_lineas.getitemnumber(j, 'subtotal_linea'))
			dw_informe.setitem(fila, 'factu_iva', ds_lineas.getitemnumber(j, 'iva_linea'))
			dw_informe.setitem(fila, 'factu_total', ds_lineas.getitemnumber(j, 'total_linea'))
		end if
	next
next

destroy ds_lineas
	
dw_informe.groupcalc()
//dw_informe.sort()

setpointer(arrow!)

if dw_informe.RowCount()>0 then dw_informe.print()
if dw_informe.RowCount()>0 and g_colegio = 'COAATZ' then dw_informe.print()
if dw_informe.RowCount()>0 and g_colegio = 'COAATGU' then dw_informe.print()

end event

event csd_mensual();// Llamamos a la ventana que genera los pagos mensuales
open(w_otros_pagos_mensual)

end event

public function integer f_generar_talones (string n_talon_inicial, datetime fecha, string banco, datetime f_vencimiento, string texto_manual);string n_talon, ctabanco, sql_nueva, lista_liquidaciones = '( '
long i
datastore ds_talon

ctabanco = f_dame_cuenta_contable_banco(banco)//i_datos_remesa.banco)

ds_talon						= create datastore
ds_talon.dataobject		= g_informe_talon_garantias
ds_talon.SetTransObject(SQLCA)

n_talon = n_talon_inicial

for i= 1 to dw_lista.RowCount()
//	st_1.Text='Tramitando liquidaci$$HEX1$$f300$$ENDHEX$$n '+string(i)+' de '+string(dw_lista.RowCount())
	if dw_lista.getitemstring(i,'estado')='P' and dw_lista.getitemstring(i,'forma_pago')= g_formas_pago.talon then
//		if not i_reproceso then
			ds_talon.InsertRow(0)
			ds_talon.SetItem(ds_talon.RowCount(),'id_colegiado',dw_lista.GetItemString(i,'id_colegiado'))
			ds_talon.SetItem(ds_talon.RowCount(),'f_liquidacion',fecha)
			ds_talon.SetItem(ds_talon.RowCount(),'importe',dw_lista.GetItemNumber(i,'importe'))
			ds_talon.SetItem(ds_talon.RowCount(),'n_documento',n_talon)
			ds_talon.SetItem(ds_talon.RowCount(),'descripcion_larga',dw_lista.GetItemString(i,'descripcion_larga'))
			// Averiguamos si el campo tipo existe, en ese caso lo copiamos tambien
			if ds_talon.Describe("tipo.Name")="tipo" then ds_talon.SetItem(ds_talon.RowCount(),'tipo',dw_lista.GetItemString(i,'tipo'))
		
			dw_lista.SetItem(i,'n_documento',n_talon)
			dw_lista.SetItem(i,'estado','L')
			dw_lista.SetItem(i,'f_liquidacion',fecha)		
			dw_lista.SetItem(i,'cta_pago',ctabanco)
			dw_lista.Update()
			ds_talon.Retrieve(dw_lista.GetItemString(i,'id_liquidacion'))
			n_talon = RightA('0000000000000000000000'+string(long(n_talon) + 1 ),8)
			
//			ds_talon.Print()
			ds_talon.Reset()
//		end if
	end if
next

// Impresi$$HEX1$$f300$$ENDHEX$$n de Talones
for i= 1 to dw_lista.RowCount()
//	st_1.Text='Imprimiendo Tal$$HEX1$$f300$$ENDHEX$$n '+string(i)+' de '+string(dw_lista.RowCount())
	if dw_lista.getitemstring(i,'estado')='L' and dw_lista.getitemstring(i,'forma_pago')= g_formas_pago.talon then
		ds_talon.Retrieve(dw_lista.GetItemString(i,'id_liquidacion'))
		if i <> dw_lista.rowcount() then
			lista_liquidaciones += '~'' + dw_lista.getitemstring(i, 'id_liquidacion') + + '~'' + ', '
		else
			lista_liquidaciones += '~'' + dw_lista.getitemstring(i, 'id_liquidacion') + + '~'' + ' )'
		end if		
		
		// Modificado Ricardo 04-02-23
		if not f_es_vacio(dw_lista.getitemstring(i, 'id_colegiado')) then
			ds_talon.Modify("texto1.Text='Estimado Compa$$HEX1$$f100$$ENDHEX$$ero:'")
			ds_talon.Modify("texto2.Expression=~"Adjuntamos documento a compensar a tu favor, por liquidaci$$HEX1$$f300$$ENDHEX$$n del saldo resultante detallado en el recuadro inferior~"")                    
			ds_talon.Modify("texto3.Text='Un cordial saludo'")
			ds_talon.Modify("texto4.Expression=~"'DOCUMENTO :  ' + if (not f_es_vacio( descripcion_larga ),  descripcion_larga, 'PAGO GEN$$HEX1$$c900$$ENDHEX$$RICO')~"")
			ds_talon.Modify("fecha_vencimiento.Text='"+string(f_vencimiento, "DD/MM/YYYY")+"'")
			ds_talon.Modify("fecha_vencimiento_talon.Text='"+string(string(day(date( f_vencimiento ))) + space(14)+ Upper(f_obtener_mes (f_vencimiento )) + FillA(' ', 30 - LenA(f_obtener_mes(f_vencimiento ))) + string(year(date(f_vencimiento))))+"'")            
		elseif not f_es_vacio(dw_lista.getitemstring(i, 'id_beneficiario')) then
			ds_talon.Modify("texto1.Text='Muy Se$$HEX1$$f100$$ENDHEX$$or Nuestro:'")
			ds_talon.Modify("texto2.Expression=~"Adjuntamos documento a compensar a tu favor, por liquidaci$$HEX1$$f300$$ENDHEX$$n del saldo resultante detallado en el recuadro inferior~"")                    
			ds_talon.Modify("texto3.Text='Un cordial saludo'")
			ds_talon.Modify("texto4.Expression=~"'DOCUMENTO :  ' + if (not f_es_vacio( descripcion_larga ),  descripcion_larga, 'PAGO GEN$$HEX1$$c900$$ENDHEX$$RICO')~"")
			ds_talon.Modify("fecha_vencimiento.Text='"+string(f_vencimiento, "DD/MM/YYYY")+"'")
			ds_talon.Modify("fecha_vencimiento_talon.Text='"+string(string(day(date( f_vencimiento ))) + space(14)+ Upper(f_obtener_mes (f_vencimiento )) + FillA(' ', 30 - LenA(f_obtener_mes(f_vencimiento ))) + string(year(date(f_vencimiento))))+"'")            
		end if
		// FIN Modificado Ricardo 04-02-23
		
		
		ds_talon.Print()
		ds_talon.Reset()	
  end if
next

messagebox('IMPRESION DEL LISTADO DE TALONES GENERADOS', 'Coloque papel blanco en la impresora , va a salir el listado de talones generado')
datastore ds_liquidacion_listado
ds_liquidacion_listado = create datastore
ds_liquidacion_listado.dataobject = g_listado_talones_otros_pagos
ds_liquidacion_listado.SetTransObject(SQLCA)

sql_nueva = ds_liquidacion_listado.describe("datawindow.table.select") + ' and premaat_liquidaciones.id_liquidacion in ' + lista_liquidaciones
ds_liquidacion_listado.modify("datawindow.table.select= ~"" + sql_nueva + "~"")
ds_liquidacion_listado.retrieve()
ds_liquidacion_listado.groupcalc()
ds_liquidacion_listado.print()
destroy ds_liquidacion_listado

//i_reproceso = true

destroy ds_talon
return 1
end function

public function string wf_busca_tipo_factura (string id_factura);string n_factura, ls_null

Select n_fact
into  :n_factura
from  csi_facturas_emitidas
where id_factura = :id_factura;
// RECTIF
if MidA(n_factura, 0 ,6) <> 'RECTIF' then
	setnull(n_factura)
end if


return n_factura

end function

public subroutine wf_crear_apunte (datetime fecha, string cuenta, string concepto, double debe, double haber, string orden_apunte, string contrapartida);// Generacion del apunte
g_apunte.fecha = datetime(date(fecha), time("00:00:00"))
g_apunte.cuenta = cuenta
g_apunte.concepto = trim(concepto)
g_apunte.debe = debe
g_apunte.haber = haber
g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)				
g_apunte.orden_apunte = orden_apunte
g_apunte.contrapartida = contrapartida
f_apunte_dw(g_apunte,dw_2,'E')
end subroutine

on w_garantias_liquidaciones.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_premaat_liquidaciones_lista" then this.MenuID = create m_premaat_liquidaciones_lista
this.dw_2=create dw_2
this.dw_informe=create dw_informe
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_informe
end on

on w_garantias_liquidaciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_informe)
end on

event activate;call super::activate;g_dw_lista  = dw_lista
g_w_lista   = g_lista_premaat_liquid
g_lista     = 'w_premaat_liquid_lista'

end event

event csd_consulta;call super::csd_consulta;// Abrimos la ventana de consulta
// No le pasamos parametro a la ventana para discernir por tipo pq ya hecemos un filtro en el dw


///*Cambiado por la incidencia cza-168. Se guarda la consulta inicial y despu$$HEX1$$e900$$ENDHEX$$s se vuelve a asiganar al listado.
// /****** Alexis. 04022010 *******///
string lsql_consulta_old

lsql_consulta_old = g_dw_lista.describe("datawindow.table.select")

openwithparm(w_premaat_liquid_consulta,'')
if Message.DoubleParm = -1 then return
sql_consulta = g_dw_lista.getsqlselect()
dw_lista.Event csd_retrieve()

dw_lista.modify("datawindow.table.select= ~"" + lsql_consulta_old + "~"")
end event

event pfc_postopen();call super::pfc_postopen;g_dw_lista_premaat_liquid = dw_lista

//Recuperamos la consulta de Inicio en caso de que exista
This.post Event csd_recuperar_consulta('INICIO')


end event

event open;call super::open;// Ponemos el de Gran Canaria que es el colegio que lo ha pediddo
dw_informe.dataobject = 'd_informe_liquid_transf_no_hon_gc'
dw_informe.SetTransObject(SQLCA)		
end event

event type integer pfc_preupdate();call super::pfc_preupdate;if f_puedo_escribir(g_usuario, '0000000007')= -1 then return -1
return 1

end event

event csd_nuevo();// MODIFICADO RICARDO 04-05-11
// EVENTO SOBREESCRITO PARA QUE NO MODIFIQUE LA VAR GLOBAL GB_NUEVO Y PRODUZCA EFECTOS RAROS
// FIN MODIFICADO RICARDO 04-05-11


open(w_garantias_liquidaciones_generar)

end event

event csd_listados;call super::csd_listados;open(w_garantias_liquidaciones_listados)
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_garantias_liquidaciones
integer y = 1800
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_garantias_liquidaciones
integer y = 1680
end type

type st_1 from w_lista`st_1 within w_garantias_liquidaciones
integer x = 37
integer y = 1628
end type

type dw_lista from w_lista`dw_lista within w_garantias_liquidaciones
event csd_prepara_liquidacion ( )
integer x = 37
integer y = 32
integer width = 3625
integer height = 1476
string dataobject = "d_garantias_liquid_lista"
boolean hscrollbar = true
end type

event dw_lista::csd_prepara_liquidacion();//string estado
//long i
//
//i_reproceso = false
//
//FOR i=1 TO this.RowCount()
//	estado = this.GetItemString(i,'estado')
//	if estado <> 'P' then
//		i_reproceso = true
//		continue
//	END IF
//NEXT
//
//if i_reproceso then
//	messagebox(g_titulo,"Ha seleccionado liquidaciones ya procesadas: NO SE ACTUALIZARAN DATOS.",Exclamation!)
//	messagebox(g_titulo,"Si desea actualizar datos seleccione s$$HEX1$$f300$$ENDHEX$$lo liquidaciones pendientes",Information!)
//end if
//
end event

event dw_lista::doubleclicked;//this.print()
end event

event dw_lista::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event dw_lista::csd_retrieve;string ls_sql_old='',ls_sql_nuevo='', ls_nombre, ls_sql

this.accepttext()

ls_sql = this.describe("datawindow.table.select")
ls_sql+=" and premaat_liquidaciones.empresa = '"+g_empresa+"' "

this.modify("datawindow.table.select= ~"" + ls_sql + "~"")

this.Retrieve()
	

end event

type cb_consulta from w_lista`cb_consulta within w_garantias_liquidaciones
integer y = 1512
end type

type cb_detalle from w_lista`cb_detalle within w_garantias_liquidaciones
integer y = 1512
end type

type cb_ayuda from w_lista`cb_ayuda within w_garantias_liquidaciones
integer y = 1512
end type

type dw_2 from u_dw within w_garantias_liquidaciones
boolean visible = false
integer x = 32
integer y = 964
integer width = 3625
integer height = 524
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_apuntes_automaticos"
end type

event constructor;call super::constructor;SetTransObject(bd_ejercicio)
end event

type dw_informe from u_dw within w_garantias_liquidaciones
boolean visible = false
integer x = 3109
integer y = 572
integer width = 370
integer height = 252
integer taborder = 31
boolean bringtotop = true
string dataobject = "d_informe_liquidacion_transferencia_biz"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

