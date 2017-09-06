HA$PBExportHeader$w_premaat_liquid_lista.srw
forward
global type w_premaat_liquid_lista from w_lista
end type
type dw_2 from u_dw within w_premaat_liquid_lista
end type
type dw_modo_liq from u_dw within w_premaat_liquid_lista
end type
end forward

global type w_premaat_liquid_lista from w_lista
integer width = 3735
integer height = 1324
string menuname = "m_premaat_liquidaciones_lista"
event csd_talones ( )
event csd_transferencias ( )
event csd_contabilizar ( )
event csd_contabilizar_pago_colegiados ( )
dw_2 dw_2
dw_modo_liq dw_modo_liq
end type
global w_premaat_liquid_lista w_premaat_liquid_lista

type variables
st_cobros_datos_remesa i_datos_remesa
boolean i_reproceso
end variables

forward prototypes
public function integer wf_generar_talones (string n_talon_inicial, datetime fecha, string banco, datetime f_vencimiento, string texto_manual)
end prototypes

event csd_talones();string n_talon_inicial, banco, texto_manual
datetime fecha_talon, f_vencimiento

st_liquidacion_datos_talon ds_talon
//i_modo_liq = dw_modo_liq.GetItemString(1,'modo_liquidacion')

if i_reproceso then
	Messagebox(g_titulo,g_idioma.of_getmsg('premaat.liq_pdtes_talones',"Recuerde que no todas las liquidaciones est$$HEX1$$e100$$ENDHEX$$n pendientes, por lo que este proceso S$$HEX1$$d300$$ENDHEX$$LO imprime talones. NO SE ACTUALIZARAN DATOS!!"),Exclamation!)
else
	Open(w_premaat_liquid_n_talon_inicial)
	ds_talon = Message.PowerObjectParm
	if ds_talon.n_talon_inicial='-1' then return   //Opci$$HEX1$$f300$$ENDHEX$$n Cancelar de la ventana de tal$$HEX1$$f300$$ENDHEX$$n inicial
	n_talon_inicial = ds_talon.n_talon_inicial
	fecha_talon	= ds_talon.fecha_talon
	banco = ds_talon.banco
	// Modficiado Ricardo 04-02-23
	f_vencimiento = ds_talon.f_vencimiento
	texto_manual =  ds_talon.texto_manual
end if

wf_generar_talones(n_talon_inicial,fecha_talon, banco, f_vencimiento, texto_manual)
// FIN Modficiado Ricardo 04-02-23
Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.proceso_finalizado','Proceso Finalizado.'))

i_reproceso = true
this.enabled = FALSE

end event

event csd_transferencias();string lista_liquidaciones,nombre_ventana

nombre_ventana = classname() // A fin de evitar Bad Runtime Reference
SetPointer(Hourglass!)

IF NOT gnv_control_cuentas_bancarias.of_validar_datos_bancarios_movimientos('P', dw_lista) THEN RETURN
Openwithparm(w_premaat_datos_remesa, 'PREMAAT')
i_datos_remesa = Message.PowerObjectParm	
IF f_genera_csb34(dw_lista, i_datos_remesa, nombre_ventana, lista_liquidaciones) = -1 THEN RETURN

f_imprimir_listado_transferencias (nombre_ventana, lista_liquidaciones)
SetPointer(Arrow!)
end event

event csd_contabilizar();// Modificado Ricardo 04-03-15
if not g_contabilidad_automatica then return

dw_modo_liq.accepttext()
dw_lista.AcceptText()

//SCP-166 Verificamos que el ejercicio contable esta abierto
if NOT f_ejercicio_abierto(g_ejercicio) then
	Messagebox(g_titulo,'El ejercicio contable '+ g_ejercicio + ' no est$$HEX2$$e1002000$$ENDHEX$$abierto. No es posible continuar con el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n',stopsign!)
	return
end if

//SCP-492 Llamamos desde aqu$$HEX2$$ed002000$$ENDHEX$$al control de eventos para no modificar el c$$HEX1$$f300$$ENDHEX$$digo existente en el menu de la ventana
st_control_eventos c_evento
c_evento.evento='CONTA_PRESTA'
f_control_eventos(c_evento)
if c_evento.param1='1' then 
	event csd_contabilizar_pago_colegiados()
	return
end if
//Fin SCP-492

long cuantos, asiento
string mensaje = ''
int continuar
int i
datetime fecha, fecha_anterior
double importe, saldo = 0, saldo_deudor = 0
string estado, concepto_base, concepto, formadepago, id_liquidacion, id_colegiado, cuenta_col, id_beneficiario, nombre
string ctabanco, contabilizada, n_documento, id_cli, cuenta_presupuestaria
string modo_contabilizacion, desc_banco
double total_asiento = 0

// ------ Pre-contabilizaci$$HEX1$$f300$$ENDHEX$$n
if isnull(g_num_digitos) or g_num_digitos > 10 or g_num_digitos < 6 then mensaje = mensaje + cr + "g_num_digitos"
if f_es_vacio(g_conta.cuenta_clientes_general) then mensaje = mensaje + cr + "g_conta.cuenta_clientes_general"
if f_es_vacio(g_prefijo_arqui) then mensaje = mensaje + cr + "g_prefijo_arqui"
if f_es_vacio(g_sica_diario.liq_premaat) then mensaje = mensaje + cr + "g_sica_diario.liq_premaat"
if f_es_vacio(g_t_asiento_apuntes_automaticos) then mensaje = mensaje + cr + "g_t_asiento_apuntes_automaticos"
if f_es_vacio(g_sica_t_doc.transferencia) then mensaje = mensaje + cr + "g_sica_t_doc.transferencia" 
if f_es_vacio(g_sica_t_doc.talon) then mensaje = mensaje + cr + "g_sica_t_doc.talon" 
if f_es_vacio(g_sica_t_doc.generico) then mensaje = mensaje + cr + "g_sica_t_doc.generico" 
if f_es_vacio(g_centro_por_defecto) then mensaje = mensaje + cr + "g_centro_por_defecto"
if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
if f_es_vacio(g_explotacion_por_defecto) then mensaje = mensaje + cr + "g_explotacion_por_defecto"

select count(*) into :cuantos from csi_bancos where cuenta_contable = null or cuenta_contable = '';
if cuantos > 0 then Messagebox(g_titulo,g_idioma.of_getmsg('premaat.bancos_sin_cuenta',"Hay bancos sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso."),Stopsign!)

//select count(*) into :cuantos from csi_formas_de_pago where cuenta = null or cuenta = '';
//if cuantos > 0 then Messagebox(g_titulo,"Hay Formas de Pago sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso.",Stopsign!)

if mensaje <> '' then
	mensaje = g_idioma.of_getmsg('premaat.definir_variables','Hay que definir las siguientes variables para poder contabilizar:') + cr + mensaje
	messagebox(g_titulo,mensaje,Stopsign!)
	Messagebox(g_titulo,g_idioma.of_getmsg('premaat.valores-defecto','De momento les pondremos valores por defecto, pero no se debe poner en marcha si se lee este mensaje!!!'),Stopsign!)
	continuar = Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.desea_continuar','$$HEX2$$bf002000$$ENDHEX$$Desea Continuar ? '),Question!, YesNo!)
	if continuar = 2 then return	
end if

// MODIFICADO RICARDO 2005-04-27
// Miramos si alguna de las fechas est$$HEX2$$e1002000$$ENDHEX$$fuera del ejercicio actual
for i = 1 to dw_lista.RowCount()
	// Permitimos que vaya viendo como las marcamos
	yield()
	
	estado = dw_lista.GetItemString(i,'estado')
	// Solo miramos las liquidadas
	if estado <> 'L' then continue
	contabilizada = dw_lista.GetItemString(i,'contabilizada')
	// No contabilizadas, claro
	if contabilizada = 'S' then continue	
	
	if string(year(date(dw_lista.GetItemDateTime(i,'f_liquidacion'))))<>g_ejercicio then
		MessageBox(g_titulo, g_idioma.of_getmsg('premaat.liq_fuera_ejer',"Alguna de las fechas de las liquidaciones no corresponden al ejercicio actual, por lo que se cancela el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n."), stopsign!)
		return
	end if
next
// fin MODIFICADO RICARDO 2005-04-27

if f_es_vacio(g_conta.cuenta_clientes_general) then g_conta.cuenta_clientes_general = '4400000'
if f_es_vacio(g_prefijo_arqui) then g_prefijo_arqui = '430'

modo_contabilizacion = dw_modo_liq.getitemstring(1, 'modo_contabilizacion')
asiento = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.liq_premaat,7))
if modo_contabilizacion = 'N' then asiento = asiento - 1
if isnull(asiento) then asiento = 0

// Modificado Ricardo 2005-01-31
if modo_contabilizacion = 'F' then
	// Ordenamos por fecha de liquidacion
	dw_lista.Setsort("f_liquidacion A")
	dw_lista.sort()
	setnull(fecha_anterior)
end if
// Fin Modificado Ricardo 2005-01-31
// Contabilizamos las liquidadas no contabilizadas
g_apunte.n_apunte = '00000'
for i = 1 to dw_lista.RowCount()
	// Permitimos que vaya viendo como las marcamos
	yield()
	
	estado = dw_lista.GetItemString(i,'estado')
	// Solo miramos las liquidadas
	if estado <> 'L' then continue
	contabilizada = dw_lista.GetItemString(i,'contabilizada')
	// No contabilizadas, claro
	if contabilizada = 'S' then continue	
	
	// Modificado Ricardo 2005-01-31
	if modo_contabilizacion = 'F' then
		if isnull(fecha_anterior) then fecha_anterior = dw_lista.GetItemDateTime(i,'f_liquidacion')
		if date(fecha_anterior)<>date(dw_lista.GetItemDateTime(i,'f_liquidacion')) then
			// En este caso ponemos el concepto que toca
			Concepto = g_idioma.of_getmsg('premaat.pago_prestaciones',"PAGO PRESTACIONES PREMAAT")
			// Cargo a Banco
			g_apunte.concepto = concepto
			g_apunte.cuenta = ctabanco
			g_apunte.debe = 0
			g_apunte.haber = f_redondea(total_asiento)
			f_apunte_dw(g_apunte,dw_2,'E')	
					
			// Pasamos al siguiente apunte y vaciamos el acumulado
			asiento++
			total_asiento = 0
			g_apunte.n_apunte = '00000'
		end if
	end if
	// Fin Modificado Ricardo 2005-01-31
	
	id_liquidacion = dw_lista.GetItemString(i,'id_liquidacion')
	fecha = dw_lista.GetItemDateTime(i,'f_liquidacion')
	importe = dw_lista.GetItemNumber(i,'importe')
	id_colegiado = dw_lista.GetItemString(i,'id_colegiado')
	id_beneficiario = dw_lista.GetItemString(i,'id_beneficiario')	
	n_documento = dw_lista.GetItemString(i,'n_documento')

	concepto_base = g_idioma.of_getmsg('premaat.pago_prest','PAGO PREST.PREMAAT: ')
	formadepago = dw_lista.GetItemString(i,'forma_pago')
	ctabanco = dw_lista.GetItemString(i,'cta_pago')
	
	//Rellenamos DATOS GENERALES DE G_APUNTE
	if modo_contabilizacion = 'N' then asiento++
	g_apunte.n_asiento = RightA('0000000' + trim(string(asiento)),7)
	g_apunte.n_doc = n_documento
	g_apunte.id_interno = id_liquidacion
	g_apunte.fecha = datetime(date(fecha), time("00:00:00"))
	g_apunte.t_asiento = g_t_asiento_apuntes_automaticos
	if modo_contabilizacion = 'N' then 	g_apunte.n_apunte = '00000'
	g_apunte.diario = g_sica_diario.liq_honos
	g_apunte.proyecto = g_explotacion_por_defecto
	g_apunte.centro = g_centro_por_defecto
	g_apunte.cta_presupuestaria = cuenta_presupuestaria	
	choose case formadepago
		case g_formas_pago.transferencia
			g_apunte.t_doc = g_sica_t_doc.transferencia
		case g_formas_pago.talon
			g_apunte.t_doc = g_sica_t_doc.talon
		case else
			g_apunte.t_doc = g_sica_t_doc.generico
	end choose
	if not f_es_vacio(id_beneficiario) then
		nombre = f_dame_cliente(id_beneficiario)
	else
		nombre =	 f_colegiado_apellido(id_colegiado)
	end if
	if f_es_vacio(nombre) then nombre = ''
	concepto_base = concepto_base + nombre
	
	// Abono a la Cuenta de PREMAAT
	concepto = LeftA(concepto_base,57)
	g_apunte.concepto = concepto
	g_apunte.cuenta = g_cuenta_pago_prestaciones
	g_apunte.debe = importe
	g_apunte.haber = 0
	g_apunte.contrapartida = ctabanco	
	f_apunte_dw(g_apunte,dw_2,'E')	
	
	total_asiento += importe
	//Marcamos la liquidacion como contabilizada:
	dw_lista.SetItem(i,'contabilizada','S')
	
	if modo_contabilizacion = 'N' then 	
		// Cargo a Banco
		g_apunte.concepto = concepto
		g_apunte.cuenta = ctabanco
		g_apunte.debe = 0
		g_apunte.haber = importe
		g_apunte.contrapartida = g_cuenta_pago_prestaciones	
		f_apunte_dw(g_apunte,dw_2,'E')	
	end if
	fecha_anterior = fecha
next

// Modificado Ricardo 2005-01-31
if modo_contabilizacion = 'F' then
	// En este caso ponemos el concepto que toca
	Concepto = g_idioma.of_getmsg('premaat.pago_prestaciones',"PAGO PRESTACIONES PREMAAT")
	// Cargo a Banco
	g_apunte.concepto = concepto
	g_apunte.cuenta = ctabanco
	g_apunte.debe = 0
	g_apunte.haber = f_redondea(total_asiento)
	f_apunte_dw(g_apunte,dw_2,'E')	
end if
// Fin Modificado Ricardo 2005-01-31


if modo_contabilizacion = '1' then
	Concepto = g_idioma.of_getmsg('premaat.pago_prestaciones',"PAGO PRESTACIONES PREMAAT")
	// Cargo a Banco
	g_apunte.concepto = concepto
	g_apunte.cuenta = ctabanco
	g_apunte.debe = 0
	g_apunte.haber = f_redondea(total_asiento)
	f_apunte_dw(g_apunte,dw_2,'E')	
end if

// Actualizamos los datos
dw_lista.Update()
if dw_2.rowcount() >0 then
	dw_2.Update()
	f_actualiza_numero_bd_ejercicio(g_sica_diario.liq_premaat, asiento)	
	dw_2.reset()
end if

messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.proceso_finalizado','Proceso Finalizado'))

end event

event csd_contabilizar_pago_colegiados();dw_modo_liq.accepttext()
dw_lista.AcceptText()


long cuantos, asiento
string mensaje = ''
int continuar
int i
datetime fecha, fecha_anterior
double importe, saldo = 0, saldo_deudor = 0
string estado, concepto_base, concepto, formadepago, id_liquidacion, id_colegiado, cuenta_colegiado, id_beneficiario, nombre
string ctabanco, contabilizada, n_documento, id_cli, cuenta_presupuestaria
string modo_contabilizacion, desc_banco
double total_asiento = 0

// ------ Pre-contabilizaci$$HEX1$$f300$$ENDHEX$$n
if isnull(g_num_digitos) or g_num_digitos > 10 or g_num_digitos < 6 then mensaje = mensaje + cr + "g_num_digitos"
if f_es_vacio(g_conta.cuenta_clientes_general) then mensaje = mensaje + cr + "g_conta.cuenta_clientes_general"
if f_es_vacio(g_prefijo_arqui) then mensaje = mensaje + cr + "g_prefijo_arqui"
if f_es_vacio(g_sica_diario.liq_premaat) then mensaje = mensaje + cr + "g_sica_diario.liq_premaat"
if f_es_vacio(g_t_asiento_apuntes_automaticos) then mensaje = mensaje + cr + "g_t_asiento_apuntes_automaticos"
if f_es_vacio(g_sica_t_doc.transferencia) then mensaje = mensaje + cr + "g_sica_t_doc.transferencia" 
if f_es_vacio(g_sica_t_doc.talon) then mensaje = mensaje + cr + "g_sica_t_doc.talon" 
if f_es_vacio(g_sica_t_doc.generico) then mensaje = mensaje + cr + "g_sica_t_doc.generico" 
if f_es_vacio(g_centro_por_defecto) then mensaje = mensaje + cr + "g_centro_por_defecto"
if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
if f_es_vacio(g_explotacion_por_defecto) then mensaje = mensaje + cr + "g_explotacion_por_defecto"

select count(*) into :cuantos from csi_bancos where cuenta_contable = null or cuenta_contable = '';
if cuantos > 0 then Messagebox(g_titulo,g_idioma.of_getmsg('premaat.bancos_sin_cuenta',"Hay bancos sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso."),Stopsign!)


if mensaje <> '' then
	mensaje = g_idioma.of_getmsg('premaat.definir_variables','Hay que definir las siguientes variables para poder contabilizar:') + cr + mensaje
	messagebox(g_titulo,mensaje,Stopsign!)
	Messagebox(g_titulo,g_idioma.of_getmsg('premaat.valores-defecto','De momento les pondremos valores por defecto, pero no se debe poner en marcha si se lee este mensaje!!!'),Stopsign!)
	continuar = Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.desea_continuar','$$HEX2$$bf002000$$ENDHEX$$Desea Continuar ? '),Question!, YesNo!)
	if continuar = 2 then return	
end if

//Comprobamos que todas las liquidaciones tienen fecha perteneciente al ejercicio actual
for i = 1 to dw_lista.RowCount()
	// Permitimos que vaya viendo como las marcamos
	yield()
	
	estado = dw_lista.GetItemString(i,'estado')
	// Solo miramos las liquidadas y NO contabilizadas
	if estado <> 'L' then continue
	contabilizada = dw_lista.GetItemString(i,'contabilizada')
	if contabilizada = 'S' then continue	
	
	if string(year(date(dw_lista.GetItemDateTime(i,'f_liquidacion'))))<>g_ejercicio then
		MessageBox(g_titulo, g_idioma.of_getmsg('premaat.liq_fuera_ejer',"Alguna de las fechas de las liquidaciones no corresponden al ejercicio actual, por lo que se cancela el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n."), stopsign!)
		return
	end if
next

if f_es_vacio(g_conta.cuenta_clientes_general) then g_conta.cuenta_clientes_general = '4400000'
if f_es_vacio(g_prefijo_arqui) then g_prefijo_arqui = '430'

modo_contabilizacion = dw_modo_liq.getitemstring(1, 'modo_contabilizacion')
asiento = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.liq_premaat,7))
if modo_contabilizacion = 'N' then asiento = asiento - 1
if isnull(asiento) then asiento = 0

if modo_contabilizacion = 'F' then
	// Ordenamos por fecha de liquidacion
	dw_lista.Setsort("f_liquidacion A")
	dw_lista.sort()
	setnull(fecha_anterior)
end if

// Contabilizamos las liquidadas NO contabilizadas
g_apunte.n_apunte = '00000'
for i = 1 to dw_lista.RowCount()
	// Permitimos que vaya viendo como las marcamos
	yield()
	
	estado = dw_lista.GetItemString(i,'estado')
	// Solo miramos las liquidadas y NO contabilizadas
	if estado <> 'L' then continue
	contabilizada = dw_lista.GetItemString(i,'contabilizada')
	if contabilizada = 'S' then continue	
	
	if modo_contabilizacion = 'F' then
		if isnull(fecha_anterior) then fecha_anterior = dw_lista.GetItemDateTime(i,'f_liquidacion')
		//Comprobamos si ha cambiado la fecha de liquidaci$$HEX1$$f300$$ENDHEX$$n y en ese caso finalizamos el asiento
		if date(fecha_anterior)<>date(dw_lista.GetItemDateTime(i,'f_liquidacion')) then
			Concepto = g_idioma.of_getmsg('premaat.pago_prestaciones',"PAGO PRESTACIONES PREMAAT")
			//Creamos apunte para la cuenta de prestaciones
			g_apunte.concepto = concepto
			g_apunte.cuenta = g_cuenta_pago_prestaciones
			g_apunte.debe = f_redondea(total_asiento)
			g_apunte.haber = 0
			g_apunte.contrapartida = ctabanco
			f_apunte_dw(g_apunte,dw_2,'E')
			
			//Creamos el apunte para el banco
			g_apunte.concepto = concepto
			g_apunte.cuenta = ctabanco
			g_apunte.debe = 0
			g_apunte.haber = f_redondea(total_asiento)
			g_apunte.contrapartida = g_cuenta_pago_prestaciones
			f_apunte_dw(g_apunte,dw_2,'E')	
					
			// Pasamos al siguiente apunte y vaciamos el acumulado
			asiento++
			total_asiento = 0
			g_apunte.n_apunte = '00000'
		end if
	end if	
	
	id_liquidacion = dw_lista.GetItemString(i,'id_liquidacion')
	fecha = dw_lista.GetItemDateTime(i,'f_liquidacion')
	importe = dw_lista.GetItemNumber(i,'importe')
	id_colegiado = dw_lista.GetItemString(i,'id_colegiado')
	id_beneficiario = dw_lista.GetItemString(i,'id_beneficiario')	
	n_documento = dw_lista.GetItemString(i,'n_documento')
	
	if f_es_vacio(id_colegiado) then
		select id_col into :id_colegiado from premaat_beneficiarios where id_heredero= :id_beneficiario;
	end if
	//Obtenemos cuenta de Colegiado
	//Le pasamos P como tipo de cuenta, este tipo hace referencia a la variable g_prefijo_arqui
	cuenta_colegiado=f_dame_cuenta_col(id_colegiado,'P')

	concepto_base = g_idioma.of_getmsg('premaat.pago_prest','PAGO PREST.PREMAAT: ')
	formadepago = dw_lista.GetItemString(i,'forma_pago')
	ctabanco = dw_lista.GetItemString(i,'cta_pago')
	
	//Rellenamos DATOS GENERALES DE G_APUNTE
	if modo_contabilizacion = 'N' then asiento++
	g_apunte.n_asiento = RightA('0000000' + trim(string(asiento)),7)
	g_apunte.n_doc = n_documento
	g_apunte.id_interno = id_liquidacion
	g_apunte.fecha = datetime(date(fecha), time("00:00:00"))
	g_apunte.t_asiento = g_t_asiento_apuntes_automaticos
	if modo_contabilizacion = 'N' then 	g_apunte.n_apunte = '00000'
	g_apunte.diario = g_sica_diario.liq_honos
	g_apunte.proyecto = g_explotacion_por_defecto
	g_apunte.centro = g_centro_por_defecto
	g_apunte.cta_presupuestaria = cuenta_presupuestaria	
	choose case formadepago
		case g_formas_pago.transferencia
			g_apunte.t_doc = g_sica_t_doc.transferencia
		case g_formas_pago.talon
			g_apunte.t_doc = g_sica_t_doc.talon
		case else
			g_apunte.t_doc = g_sica_t_doc.generico
	end choose
	if not f_es_vacio(id_beneficiario) then
		nombre = f_dame_cliente(id_beneficiario)
	else
		nombre =	 f_colegiado_apellido(id_colegiado)
	end if
	if f_es_vacio(nombre) then nombre = ''
	concepto_base = concepto_base + nombre
	
	concepto = LeftA(concepto_base,57)
	
	//Creamos Apunte para el Haber en cuenta colegiado
	g_apunte.concepto = concepto
	g_apunte.cuenta = cuenta_colegiado
	g_apunte.debe = 0
	g_apunte.haber = importe
	f_apunte_dw(g_apunte,dw_2,'E')

	//Creamos Apunte para el Debe en cuenta colegiado
	g_apunte.concepto = concepto
	g_apunte.cuenta = cuenta_colegiado
	g_apunte.debe = importe
	g_apunte.haber = 0
	f_apunte_dw(g_apunte,dw_2,'E')
	
	total_asiento += importe
	//Marcamos la liquidacion como contabilizada:
	dw_lista.SetItem(i,'contabilizada','S')
	
	if modo_contabilizacion = 'N' then 
		//Creamos apunte para la cuenta de prestaciones
		Concepto = g_idioma.of_getmsg('premaat.pago_prestaciones',"PAGO PRESTACIONES PREMAAT")
		g_apunte.concepto = concepto
		g_apunte.cuenta =g_cuenta_pago_prestaciones	
		g_apunte.debe = importe
		g_apunte.haber = 0
		g_apunte.contrapartida =cuenta_colegiado
		f_apunte_dw(g_apunte,dw_2,'E')	
		// Cargo a Banco
		g_apunte.concepto = concepto
		g_apunte.cuenta = ctabanco
		g_apunte.debe = 0
		g_apunte.haber = importe
		g_apunte.contrapartida = cuenta_colegiado	
		f_apunte_dw(g_apunte,dw_2,'E')	
	end if
	fecha_anterior = fecha
next

// Modificado Ricardo 2005-01-31
if modo_contabilizacion = 'F' then
	// En este caso ponemos el concepto que toca
	Concepto = g_idioma.of_getmsg('premaat.pago_prestaciones',"PAGO PRESTACIONES PREMAAT")
	//Creamos apunte para la cuenta de prestaciones
	g_apunte.concepto = concepto
	g_apunte.cuenta = g_cuenta_pago_prestaciones
	g_apunte.debe = f_redondea(total_asiento)
	g_apunte.haber = 0
	g_apunte.contrapartida = ctabanco
	f_apunte_dw(g_apunte,dw_2,'E')
	
	//Creamos el apunte para el banco
	g_apunte.concepto = concepto
	g_apunte.cuenta = ctabanco
	g_apunte.debe = 0
	g_apunte.haber = f_redondea(total_asiento)
	g_apunte.contrapartida = g_cuenta_pago_prestaciones
	f_apunte_dw(g_apunte,dw_2,'E')	
end if
// Fin Modificado Ricardo 2005-01-31


if modo_contabilizacion = '1' then
	Concepto = g_idioma.of_getmsg('premaat.pago_prestaciones',"PAGO PRESTACIONES PREMAAT")
	//Creamos apunte para la cuenta de prestaciones
	g_apunte.concepto = concepto
	g_apunte.cuenta = g_cuenta_pago_prestaciones
	g_apunte.debe =  f_redondea(total_asiento)
	g_apunte.haber = 0
	g_apunte.contrapartida = ctabanco
	f_apunte_dw(g_apunte,dw_2,'E')	
	// Cargo a Banco
	g_apunte.concepto = concepto
	g_apunte.cuenta = ctabanco
	g_apunte.debe = 0
	g_apunte.haber = f_redondea(total_asiento)
	g_apunte.contrapartida = g_cuenta_pago_prestaciones
	f_apunte_dw(g_apunte,dw_2,'E')	
end if

// Actualizamos los datos
dw_lista.Update()
if dw_2.rowcount() >0 then
	dw_2.Update()
	f_actualiza_numero_bd_ejercicio(g_sica_diario.liq_premaat, asiento)	
	dw_2.reset()
end if

messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.proceso_finalizado','Proceso Finalizado'))

end event

public function integer wf_generar_talones (string n_talon_inicial, datetime fecha, string banco, datetime f_vencimiento, string texto_manual);datastore	ds_talon
long i
string n_talon
string ctabanco
string sql_nueva, lista_liquidaciones = '( '

ctabanco = f_dame_cuenta_contable_banco(banco)//i_datos_remesa.banco)

ds_talon						= create datastore
ds_talon.dataobject		= g_informe_talon_premaat
ds_talon.SetTransObject(SQLCA)

n_talon = n_talon_inicial

for i= 1 to dw_lista.RowCount()
	st_1.Text='Tramitando liquidaci$$HEX1$$f300$$ENDHEX$$n '+string(i)+' de '+string(dw_lista.RowCount())
	if dw_lista.getitemstring(i,'estado')='P' and dw_lista.getitemstring(i,'forma_pago')= g_formas_pago.talon then
		if not i_reproceso then
			ds_talon.InsertRow(0)
			ds_talon.SetItem(ds_talon.RowCount(),'id_colegiado',dw_lista.GetItemString(i,'id_colegiado'))
			ds_talon.SetItem(ds_talon.RowCount(),'f_liquidacion',fecha)
			ds_talon.SetItem(ds_talon.RowCount(),'importe',dw_lista.GetItemNumber(i,'importe'))
			ds_talon.SetItem(ds_talon.RowCount(),'n_documento',n_talon)
		
			dw_lista.SetItem(i,'n_documento',n_talon)
			dw_lista.SetItem(i,'estado','L')
			dw_lista.SetItem(i,'f_liquidacion',fecha)		
			dw_lista.SetItem(i,'cta_pago',ctabanco)
			dw_lista.Update()
			ds_talon.Retrieve(dw_lista.GetItemString(i,'id_liquidacion'))
			n_talon = RightA('0000000000000000000000'+string(long(n_talon) + 1 ),8)
			
		   // Modificado Ricardo 04-02-23
			ds_talon.Modify("fecha_vencimiento.Text='"+string(f_vencimiento, "DD/MM/YYYY")+"'")
			ds_talon.Modify("fecha_vencimiento_talon.Text='"+string(string(day(date( f_vencimiento ))) + space(14)+ Upper(f_obtener_mes (f_vencimiento )) + FillA(' ', 30 - LenA(f_obtener_mes(f_vencimiento ))) + string(year(date(f_vencimiento))))+"'")
		   // FIN Modificado Ricardo 04-02-23
			
			messagebox(g_idioma.of_getmsg('general.impresion_talones','IMPRESION DE TALONES'),g_idioma.of_getmsg('general.impresos_talon','Coloque los impresos de tal$$HEX1$$f300$$ENDHEX$$n en la impresora en la posici$$HEX1$$f300$$ENDHEX$$n adecuada, por favor'))
			ds_talon.Print()
			ds_talon.Reset()
		end if
	end if
next

// Impresi$$HEX1$$f300$$ENDHEX$$n de Talones
for i= 1 to dw_lista.RowCount()
	if dw_lista.getitemstring(i,'estado')='L' and dw_lista.getitemstring(i,'forma_pago')= g_formas_pago.talon and i_reproceso then
		ds_talon.Retrieve(dw_lista.GetItemString(i,'id_liquidacion'))
		lista_liquidaciones += '~'' + dw_lista.getitemstring(i, 'id_liquidacion') + + '~'' + ', ' 
		messagebox(g_idioma.of_getmsg('general.impresion_talones','IMPRESION DE TALONES'),g_idioma.of_getmsg('general.impresos_talon','Coloque los impresos de tal$$HEX1$$f300$$ENDHEX$$n en la impresora en la posici$$HEX1$$f300$$ENDHEX$$n adecuada, por favor'))
		ds_talon.Print()
		ds_talon.Reset()	
  end if
next

lista_liquidaciones = LeftA(lista_liquidaciones, LenA(lista_liquidaciones)-2) + ' )'

messagebox(g_idioma.of_getmsg('general.impresion_talones_gen','IMPRESION DEL LISTADO DE TALONES GENERADOS'), g_idioma.of_getmsg('general.impresion_papel','Coloque papel blanco en la impresora , va a salir el listado de talones generado'))
datastore ds_liquidacion_listado
ds_liquidacion_listado = create datastore
ds_liquidacion_listado.dataobject = 'd_premaat_liquid_listado'
ds_liquidacion_listado.SetTransObject(SQLCA)
sql_nueva = ds_liquidacion_listado.describe("datawindow.table.select") + ' and premaat_liquidaciones.id_liquidacion in ' + lista_liquidaciones
ds_liquidacion_listado.modify("datawindow.table.select= ~"" + sql_nueva + "~"")
ds_liquidacion_listado.retrieve()
ds_liquidacion_listado.groupcalc()
ds_liquidacion_listado.print()
destroy ds_liquidacion_listado

i_reproceso = true

destroy ds_talon
return 1
end function

on w_premaat_liquid_lista.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_premaat_liquidaciones_lista" then this.MenuID = create m_premaat_liquidaciones_lista
this.dw_2=create dw_2
this.dw_modo_liq=create dw_modo_liq
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_modo_liq
end on

on w_premaat_liquid_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_modo_liq)
end on

event activate;call super::activate;g_dw_lista  = dw_lista
g_w_lista   = g_lista_premaat_liquid
g_lista     = 'w_premaat_liquid_lista'

end event

event csd_consulta();call super::csd_consulta;//Abrimos la ventana de consulta
openwithparm(w_premaat_liquid_consulta,'1')
if Message.DoubleParm = -1 then return

dw_lista.Event csd_retrieve()
end event

event pfc_postopen;call super::pfc_postopen;g_dw_lista_premaat_liquid = dw_lista

end event

event open;call super::open;inv_resize.of_Register (dw_modo_liq, "FixedtoBottom")
dw_modo_liq.insertrow(0)

end event

event csd_listados();call super::csd_listados;open(w_premaat_liquid_listados)
end event

event type integer pfc_preupdate();call super::pfc_preupdate;if f_puedo_escribir(g_usuario, '0000000024')= -1 then return -1
return 1

end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_premaat_liquid_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_premaat_liquid_lista
end type

type st_1 from w_lista`st_1 within w_premaat_liquid_lista
integer y = 1028
end type

type dw_lista from w_lista`dw_lista within w_premaat_liquid_lista
event csd_prepara_liquidacion ( )
integer width = 3648
integer height = 956
string dataobject = "d_premaat_liquid_lista"
boolean hscrollbar = true
end type

event dw_lista::csd_prepara_liquidacion();string estado
long i

i_reproceso = false

FOR i=1 TO this.RowCount()
	estado = this.GetItemString(i,'estado')
	if estado <> 'P' then
		i_reproceso = true
		continue
	END IF
NEXT

if i_reproceso then
	messagebox(g_titulo,g_idioma.of_getmsg('premaat.liq_ya_procesadas',"Ha seleccionado liquidaciones ya procesadas: NO SE ACTUALIZAR$$HEX1$$c100$$ENDHEX$$N DATOS."),Exclamation!)
	messagebox(g_titulo,g_idioma.of_getmsg('premaat.actualizar_liq_ya_procesadas',"Si desea actualizar datos seleccione s$$HEX1$$f300$$ENDHEX$$lo liquidaciones pendientes"),Information!)
end if

end event

event dw_lista::retrieveend;call super::retrieveend;this.TriggerEvent("csd_prepara_liquidacion")

end event

event dw_lista::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

type cb_consulta from w_lista`cb_consulta within w_premaat_liquid_lista
end type

type cb_detalle from w_lista`cb_detalle within w_premaat_liquid_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_premaat_liquid_lista
end type

type dw_2 from u_dw within w_premaat_liquid_lista
boolean visible = false
integer x = 41
integer y = 1232
integer width = 357
integer height = 240
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_apuntes_automaticos"
end type

event constructor;call super::constructor;SetTransObject(bd_ejercicio)
end event

type dw_modo_liq from u_dw within w_premaat_liquid_lista
integer x = 517
integer y = 860
integer width = 1166
integer height = 276
integer taborder = 11
string dataobject = "d_liquidacion_modo"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

