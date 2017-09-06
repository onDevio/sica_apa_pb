HA$PBExportHeader$w_premaat_pago_prestaciones.srw
forward
global type w_premaat_pago_prestaciones from w_response
end type
type cb_4 from commandbutton within w_premaat_pago_prestaciones
end type
type st_1 from statictext within w_premaat_pago_prestaciones
end type
type dw_pagos from u_dw within w_premaat_pago_prestaciones
end type
type cb_generar from commandbutton within w_premaat_pago_prestaciones
end type
type dw_opciones from u_dw within w_premaat_pago_prestaciones
end type
type st_2 from statictext within w_premaat_pago_prestaciones
end type
type cb_buscar from commandbutton within w_premaat_pago_prestaciones
end type
type dw_apuntes_automaticos from u_dw within w_premaat_pago_prestaciones
end type
type dw_prestaciones from u_dw within w_premaat_pago_prestaciones
end type
type cb_transferencias from commandbutton within w_premaat_pago_prestaciones
end type
type cb_talones from commandbutton within w_premaat_pago_prestaciones
end type
end forward

global type w_premaat_pago_prestaciones from w_response
integer width = 3602
integer height = 2300
string title = "Pago de Prestaciones de PREMAAT"
event csd_pago_unico ( )
event csd_borrar_unicas ( )
event csd_contabilizar_pagos ( )
event csd_pago_por_prestacion ( )
event csd_listado_pagos ( )
event csd_contabilizar_pagos_1_asiento ( )
event csd_contabilizar_pago_colegiados ( )
cb_4 cb_4
st_1 st_1
dw_pagos dw_pagos
cb_generar cb_generar
dw_opciones dw_opciones
st_2 st_2
cb_buscar cb_buscar
dw_apuntes_automaticos dw_apuntes_automaticos
dw_prestaciones dw_prestaciones
cb_transferencias cb_transferencias
cb_talones cb_talones
end type
global w_premaat_pago_prestaciones w_premaat_pago_prestaciones

type variables
st_cobros_datos_remesa i_datos_remesa

end variables

forward prototypes
public function integer f_generar_talones (string n_talon_inicial, datetime fecha, string banco, datetime f_vencimiento, string texto_manual)
public subroutine wf_crear_apunte (datetime fecha, string cuenta, string concepto, double debe, double haber, string orden_apunte, string contrapartida)
end prototypes

event csd_pago_unico();double i, fila_insertada
datastore ds_lista_prestaciones_ordenada
boolean bl_aplica_paga_extra=false, bl_no_unica = false
string descripcion = ''

bl_aplica_paga_extra = (dw_opciones.getitemstring(1, 'paga_extra')  = 'S')

// Datastore preparado para hacer el barrido
ds_lista_prestaciones_ordenada = create datastore
ds_lista_prestaciones_ordenada.dataobject = 'd_premaat_prestaciones_lista'
ds_lista_prestaciones_ordenada .settransobject(sqlca)
if dw_prestaciones.RowsCopy ( 1, dw_prestaciones.rowcount(), Primary!, ds_lista_prestaciones_ordenada, 1, Primary! ) <> 1 then
	messagebox(g_titulo, g_idioma.of_getmsg('premaat.err_gen_pres','Error generando las prestaciones de PREMAAT'))
	return
end if
if ds_lista_prestaciones_ordenada.setsort('tipo_persona A, id_persona A forma_pago A') <> 1 then
	messagebox(g_titulo,g_idioma.of_getmsg('premaat.err_gen_pres', 'Error generando las prestaciones de PREMAAT'))
	return	
end if
if ds_lista_prestaciones_ordenada.sort()<> 1 then
	messagebox(g_titulo,g_idioma.of_getmsg('premaat.err_gen_pres','Error generando las prestaciones de PREMAAT'))
	return		
end if


// Hacemos el barrido para preparar los pagos
double dl_importe_total = 0, dl_importe_linea_act = 0, dl_importe_linea_sig = 0
string sl_tipo_persona_act, sl_id_persona_act, sl_forma_de_pago_act
string sl_tipo_persona_ant = '@', sl_id_persona_ant= '@', sl_forma_de_pago_ant= '@'

// Algoritmo
dl_importe_total = 0
for i = 1 to ds_lista_prestaciones_ordenada.rowcount()

	// Leemos l$$HEX1$$ed00$$ENDHEX$$nea actual
	sl_tipo_persona_act = ds_lista_prestaciones_ordenada.getitemstring(i, 'tipo_persona') 
	sl_id_persona_act = ds_lista_prestaciones_ordenada.getitemstring(i, 'id_persona') 
	sl_forma_de_pago_act = ds_lista_prestaciones_ordenada.getitemstring(i, 'forma_pago') 
	dl_importe_linea_act = ds_lista_prestaciones_ordenada.getitemnumber(i, 'importe') 
	bl_no_unica = ( ds_lista_prestaciones_ordenada.getitemstring(i, 'premaat_tipo_pres_es_extra')  = 'N' )
	
	if ((sl_tipo_persona_ant = sl_tipo_persona_act) and (sl_id_persona_ant = sl_id_persona_act) and  (sl_forma_de_pago_ant = sl_forma_de_pago_act)) or (i = 1) then
	// Ir acumulando importes mientras se cumpla esta condici$$HEX1$$f300$$ENDHEX$$n		
		dl_importe_total += dl_importe_linea_act
		descripcion += f_dame_tipo_prestacion(ds_lista_prestaciones_ordenada.getitemstring(i, 'tipo_prestacion')) +', '
		if bl_aplica_paga_extra and bl_no_unica then dl_importe_total += dl_importe_linea_act
	else
//		// pasar pago
//		if dl_importe_total <> 0 then
			fila_insertada = dw_pagos.event pfc_addrow()	
			dw_pagos.SetItem(fila_insertada,'id_liquidacion',f_siguiente_numero('LIQUIDACIONES',10))
			dw_pagos.SetItem(fila_insertada,'estado','P')
			dw_pagos.SetItem(fila_insertada,'contabilizada','N')
			dw_pagos.SetItem(fila_insertada,'forma_pago',sl_forma_de_pago_ant)
			if RightA(descripcion, 2) = ', ' then 	descripcion = MidA(descripcion, 1, LenA(descripcion)- 2 )
			dw_pagos.SetItem(fila_insertada,'descripcion_larga',descripcion)
			dw_pagos.SetItem(fila_insertada,'importe',f_redondea(dl_importe_total))
			choose case sl_tipo_persona_ant
				case 'B'
					dw_pagos.SetItem(fila_insertada,'id_beneficiario',sl_id_persona_ant)
					dw_pagos.SetItem(fila_insertada,'nombre',f_premaat_dame_nombre_beneficiario('B', sl_id_persona_ant))
					dw_pagos.Setitem(fila_insertada,'banco',gnv_control_cuentas_bancarias.of_obtener_iban_nombre_modulo ('CLIENTES',sl_id_persona_ant) )
				case 'C'
					dw_pagos.SetItem(fila_insertada,'id_colegiado',sl_id_persona_ant)
					dw_pagos.SetItem(fila_insertada,'nombre',f_premaat_dame_nombre_beneficiario('C', sl_id_persona_ant))
					dw_pagos.Setitem(fila_insertada,'banco',gnv_control_cuentas_bancarias.of_obtener_iban_nombre_modulo ('COL_REMESABLE',sl_id_persona_ant) )
			end choose
			dw_pagos.Setitem(fila_insertada,'f_liquidacion',today())	
			dw_pagos.Setitem(fila_insertada,'empresa',g_empresa)	
			dw_pagos.Setitem(fila_insertada,'cod_usuario',g_usuario)	
			// Actualizado importe
			dl_importe_total = dl_importe_linea_act
			if bl_aplica_paga_extra and bl_no_unica then dl_importe_total += dl_importe_linea_act
			descripcion = f_dame_tipo_prestacion(ds_lista_prestaciones_ordenada.getitemstring(i, 'tipo_prestacion')) + ', '
//		end if
	end if

	sl_tipo_persona_ant = sl_tipo_persona_act
	sl_id_persona_ant = sl_id_persona_act
	sl_forma_de_pago_ant = sl_forma_de_pago_act
	
	// $$HEX1$$da00$$ENDHEX$$ltimo pago
	if i = ds_lista_prestaciones_ordenada.rowcount()  then

		fila_insertada = dw_pagos.event pfc_addrow()	
		dw_pagos.SetItem(fila_insertada,'id_liquidacion',f_siguiente_numero('LIQUIDACIONES',10))
		dw_pagos.SetItem(fila_insertada,'estado','P')
		dw_pagos.SetItem(fila_insertada,'contabilizada','N')
		dw_pagos.SetItem(fila_insertada,'forma_pago',sl_forma_de_pago_act)
		dw_pagos.SetItem(fila_insertada,'descripcion_larga', MidA(descripcion,1,LenA(descripcion) - 2) )
		dw_pagos.SetItem(fila_insertada,'importe',f_redondea(dl_importe_total))
		choose case sl_tipo_persona_act
			case 'B'
				dw_pagos.SetItem(fila_insertada,'id_beneficiario',sl_id_persona_act)
				dw_pagos.SetItem(fila_insertada,'nombre',f_premaat_dame_nombre_beneficiario('B', sl_id_persona_act))
				dw_pagos.Setitem(fila_insertada,'banco',gnv_control_cuentas_bancarias.of_obtener_iban_nombre_modulo ('CLIENTES',sl_id_persona_act) )
			case 'C'
				dw_pagos.SetItem(fila_insertada,'id_colegiado',sl_id_persona_act)
				dw_pagos.SetItem(fila_insertada,'nombre',f_premaat_dame_nombre_beneficiario('C', sl_id_persona_act))
				dw_pagos.Setitem(fila_insertada,'banco',gnv_control_cuentas_bancarias.of_obtener_iban_nombre_modulo ('COL_REMESABLE',sl_id_persona_act) )
		end choose
		dw_pagos.Setitem(fila_insertada,'f_liquidacion',today())
		dw_pagos.Setitem(fila_insertada,'empresa',g_empresa)	
		dw_pagos.Setitem(fila_insertada,'cod_usuario',g_usuario)	
	end if // Fin $$HEX1$$fa00$$ENDHEX$$ltimo pago
	
	
next

if dw_pagos.RowCount() > 0 then
	cb_transferencias.enabled = TRUE
	cb_talones.enabled = TRUE
	// con el filtro quitamos los pagos que sean 0
	dw_pagos.filter()
End if
destroy ds_lista_prestaciones_ordenada

end event

event csd_borrar_unicas();boolean bl_aplica_borrar_unicas, bl_es_unica
long i

bl_aplica_borrar_unicas = (dw_opciones.getitemstring(1, 'borrar_extras')  = 'S')

if not bl_aplica_borrar_unicas then return

st_1.Text='Borrando pagas $$HEX1$$fa00$$ENDHEX$$nicas... '
for i = dw_prestaciones.rowcount() to 1 step -1
	bl_es_unica =  (dw_prestaciones.getitemstring(i, 'premaat_tipo_pres_es_extra') = 'S' )
	
	if bl_es_unica then
		dw_prestaciones.deleterow(i)
	end if
	
next

if dw_prestaciones.update()<> 1 then
	messagebox(g_titulo, 'Error:No se eliminaron las prestaciones $$HEX1$$fa00$$ENDHEX$$nicas')
	return
end if
end event

event csd_contabilizar_pagos();boolean bl_aplica_contabilizar = false
double dl_asiento, dl_asiento_inicial, dl_asiento_final
boolean bl_primer_asiento = true
bl_aplica_contabilizar = (dw_opciones.getitemstring(1, 'contabilizar')  = 'S')

if not bl_aplica_contabilizar then return
IF not g_contabilidad_automatica then return //Modificado Ricardo 2005-04-28
//SCP-166 Verificamos que el ejercicio contable esta abierto
if NOT f_ejercicio_abierto(g_ejercicio) then
	Messagebox(g_titulo,'El ejercicio contable '+ g_ejercicio + ' no est$$HEX2$$e1002000$$ENDHEX$$abierto. No es posible continuar con el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n',stopsign!)
	return
end if

st_1.Text=g_idioma.of_getmsg('premaat.contabilizando_pagos','Contablilizando pagos... ')

dw_pagos.AcceptText()

long cuantos, continuar, i, fila
datetime fecha
double importe, saldo = 0, saldo_deudor = 0
string estado, concepto_base, concepto, formadepago, id_colegiado, cuenta_col, cliente, n_expedi
string mensaje = '', ctabanco, contabilizada, n_documento,  cuenta_presupuestaria, id_beneficiario, nombre = ''
string  n_asiento, n_asiento_old, n_asiento_renumerado
// ------ Pre-contabilizaci$$HEX1$$f300$$ENDHEX$$n
if isnull(g_num_digitos) or g_num_digitos > 10 or g_num_digitos < 6 then mensaje = mensaje + cr + "g_num_digitos"
if f_es_vacio(g_conta.cuenta_clientes_general) then mensaje = mensaje + cr + "g_conta.cuenta_clientes_general"
if f_es_vacio(g_prefijo_arqui) then mensaje = mensaje + cr + "g_prefijo_arqui"
if f_es_vacio(g_sica_diario.liq_premaat) then mensaje = mensaje + cr + "g_sica_diario.liq_premaat"
if f_es_vacio(g_t_asiento_apuntes_automaticos) then mensaje = mensaje + cr + "g_t_asiento_apuntes_automaticos"
if f_es_vacio(g_sica_t_doc.talon) then mensaje = mensaje + cr + "g_sica_t_doc.talon"
if f_es_vacio(g_sica_t_doc.transferencia) then mensaje = mensaje + cr + "g_sica_t_doc.transferencia" 
if f_es_vacio(g_sica_t_doc.generico) then mensaje = mensaje + cr + "g_sica_t_doc.generico" 
if f_es_vacio(g_centro_por_defecto) then mensaje = mensaje + cr + "g_centro_por_defecto"

if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
if f_es_vacio(g_explotacion_por_defecto) then mensaje = mensaje + cr + "g_explotacion_por_defecto"

select count(*) into :cuantos from csi_bancos where cuenta_contable = null or cuenta_contable = '';
if cuantos > 0 then Messagebox(g_titulo,g_idioma.of_getmsg('premaat.bancos_sin_cuenta',"Hay bancos sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso."),Stopsign!)

if mensaje <> '' then
	mensaje = 'Hay que definir las siguientes variables para poder contabilizar:' + cr + mensaje
	messagebox(g_titulo,mensaje,Stopsign!)
	Messagebox(g_titulo,g_idioma.of_getmsg('premaat.valores-defecto','De momento les pondremos valores por defecto, pero no se debe poner en marcha si se lee este mensaje!!!'),Stopsign!)
	continuar = Messagebox(g_titulo,'$$HEX2$$bf002000$$ENDHEX$$Desea Continuar ? ',Question!, YesNo!)
	if continuar = 2 then 
		st_1.Text=''
		return	
	end if
	
end if

// Contabilizamos las liquidadas no contabilizadas
for i = 1 to dw_pagos.RowCount()
	estado = dw_pagos.GetItemString(i,'estado')
	if estado <> 'L' then continue
	contabilizada = dw_pagos.GetItemString(i,'contabilizada')
	if contabilizada = 'S' then continue	
	if string(year(date(dw_pagos.GetItemDateTime(i,'f_liquidacion'))))<>g_ejercicio then 
		Messagebox(g_titulo, g_idioma.of_getmsg('premaat.liq_fuera_ejer',"Alguna de las fechas de las liquidaciones a procesar no pertenece al ejercicio actual, por lo que el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n se cancelar$$HEX1$$e100$$ENDHEX$$"), stopsign!)
		st_1.Text=''
		return 
	end if
next


if f_es_vacio(g_conta.cuenta_clientes_general) then g_conta.cuenta_clientes_general = '4400000'
if f_es_vacio(g_prefijo_arqui) then g_prefijo_arqui = '430'

dl_asiento = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.liq_premaat,7))
if isnull(dl_asiento) then dl_asiento = 0

g_apunte.diario = g_sica_diario.liq_premaat
g_apunte.proyecto = g_explotacion_por_defecto
g_apunte.centro = g_centro_por_defecto
g_apunte.cta_presupuestaria = cuenta_presupuestaria	

// Contabilizamos las liquidadas no contabilizadas
for i = 1 to dw_pagos.RowCount()
	fecha 				= dw_pagos.GetItemDateTime(i,'f_liquidacion')
	importe 			= dw_pagos.GetItemNumber(i,'importe')
	estado 			= dw_pagos.GetItemString(i,'estado')
	contabilizada 	= dw_pagos.GetItemString(i,'contabilizada')
	id_colegiado 	= dw_pagos.GetItemString(i,'id_colegiado')
	id_beneficiario 	= dw_pagos.GetItemString(i,'id_beneficiario')	
	n_documento 	= dw_pagos.GetItemString(i,'n_documento')
	formadepago 	= dw_pagos.GetItemString(i,'forma_pago')
	ctabanco 		= dw_pagos.GetItemString(i,'cta_pago')
	
	if estado <> 'L' then continue
	if contabilizada = 'S' then continue	
		
	concepto_base=''
	concepto_base = g_idioma.of_getmsg('premaat.pago_prest','PAGO PREST.PREMAAT: ')
	

	//Rellenamos DATOS GENERALES DE G_APUNTE
	dl_asiento++
	if bl_primer_asiento then 
		dl_asiento_inicial = dl_asiento
		bl_primer_asiento = false
	end if
	dl_asiento_final = dl_asiento -1

	g_apunte.n_asiento = RightA('0000000' + trim(string(dl_asiento)),7)
	g_apunte.n_apunte = '00000'
	g_apunte.n_doc = n_documento
	g_apunte.id_interno = ''	
	g_apunte.fecha = datetime(date(fecha), time("00:00:00"))
	g_apunte.t_asiento = g_t_asiento_apuntes_automaticos
	
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
	
	//Modificado Jesus 18/02/2010 cbi-112
	//Cojemos el apunte inicial y el final para mostrarlos en la pantalla
	if g_colegio = 'COAATB' then
		if i=1 then
			dl_asiento_inicial = dl_asiento - 1
		elseif i=dw_pagos.RowCount() then
			dl_asiento_final = dl_asiento - 1
		end if
	end if
		
	// Apunte por el debe// Abono a la Cuenta de PREMAAT
	wf_crear_apunte(datetime(date(fecha), time("00:00:00")),g_cuenta_pago_prestaciones, concepto, importe, 0, '00',ctabanco)
	
	// Si esta activa el parametro de apuntes por colegiado en pago de prestaciones se realizan apuntes a la cuenta del colegiado
	//g_premaat_col_apunte_puente
//	wf_crear_apunte(datetime(date(fecha), time("00:00:00")),cuenta_col, concepto, importe, 0, '00',g_cuenta_pago_prestaciones)
//	wf_crear_apunte(datetime(date(fecha), time("00:00:00")),cuenta_col, concepto, 0,importe, '00',ctabanco)
	
	
	//Apunte por el haber // Cargo a Banco
	wf_crear_apunte(datetime(date(fecha), time("00:00:00")),ctabanco, concepto, 0, importe, '00',g_cuenta_pago_prestaciones)
	
	
	//Marcamos la liquidacion como contabilizada:
	dw_pagos.SetItem(i,'contabilizada','S')

next

if dw_apuntes_automaticos.RowCount()>0 then
	n_asiento = "-1"
	n_asiento_old = ''
	FOR fila = 1 to dw_apuntes_automaticos.RowCount()
		n_asiento = dw_apuntes_automaticos.getitemstring(fila, 'n_asiento')
		// Si cambia de asiento/diario, renumeramos de nuevo
		if n_asiento <> n_asiento_old  then
			n_asiento_renumerado = f_siguiente_numero_bd_ejercicio(g_sica_diario.liq_honos,7) // ESto asegura que los numeros de asiento se hagan bien
		end if
		// Cambiamos el asiento segun
		dw_apuntes_automaticos.SetItem(fila, 'n_asiento', n_asiento_renumerado)
		// Mantenemos los datos de la iteracion anterior
		n_asiento_old = n_asiento
	
	NEXT
	dw_pagos.Update()
	dw_pagos.groupcalc()
	dw_apuntes_automaticos.Update()
	dw_apuntes_automaticos.reset()
end if

st_1.text = 'Asientos:  ' + string(dl_asiento_inicial) + ' - ' + string(dl_asiento_final)
end event

event csd_pago_por_prestacion();double i, fila_insertada
datastore ds_lista_prestaciones_ordenada
boolean bl_aplica_paga_extra=false, bl_no_unica = false

bl_aplica_paga_extra = (dw_opciones.getitemstring(1, 'paga_extra')  = 'S')

// Datastore preparado para hacer el barrido
ds_lista_prestaciones_ordenada = create datastore
ds_lista_prestaciones_ordenada.dataobject = 'd_premaat_prestaciones_lista'
ds_lista_prestaciones_ordenada .settransobject(sqlca)
if dw_prestaciones.RowsCopy ( 1, dw_prestaciones.rowcount(), Primary!, ds_lista_prestaciones_ordenada, 1, Primary! ) <> 1 then
	messagebox(g_titulo, g_idioma.of_getmsg('premaat.err_gen_pres','Error generando las prestaciones de PREMAAT'))
	return
end if
if ds_lista_prestaciones_ordenada.setsort('tipo_persona A, id_persona A forma_pago A') <> 1 then
	messagebox(g_titulo, g_idioma.of_getmsg('premaat.err_gen_pres','Error generando las prestaciones de PREMAAT'))
	return	
end if
if ds_lista_prestaciones_ordenada.sort()<> 1 then
	messagebox(g_titulo,g_idioma.of_getmsg('premaat.err_gen_pres', 'Error generando las prestaciones de PREMAAT'))
	return		
end if

//messagebox('filas en dw prestaciones', string(dw_prestaciones.rowcount()))
//messagebox('filas en ds prestaciones', string(ds_lista_prestaciones_ordenada.rowcount()))


// Hacemos el barrido para preparar los pagos
string sl_tipo_persona, sl_id_persona, sl_forma_de_pago
double dl_importe_total = 0

// Algoritmo
dl_importe_total = 0
for i = 1 to ds_lista_prestaciones_ordenada.rowcount()
//	if ds_lista_prestaciones_ordenada.getitemstring(i, 'aplicar') <> 'S' then continue
	// Leemos l$$HEX1$$ed00$$ENDHEX$$nea actual
	sl_tipo_persona = ds_lista_prestaciones_ordenada.getitemstring(i, 'tipo_persona') 
	sl_id_persona = ds_lista_prestaciones_ordenada.getitemstring(i, 'id_persona') 
	sl_forma_de_pago = ds_lista_prestaciones_ordenada.getitemstring(i, 'forma_pago') 
	dl_importe_total = ds_lista_prestaciones_ordenada.getitemnumber(i, 'importe') 
	bl_no_unica = ( ds_lista_prestaciones_ordenada.getitemstring(i, 'premaat_tipo_pres_es_extra')  = 'N' )
	
	if bl_aplica_paga_extra and bl_no_unica then dl_importe_total += dl_importe_total
	fila_insertada = dw_pagos.event pfc_addrow()	
	dw_pagos.SetItem(fila_insertada,'id_liquidacion',f_siguiente_numero('LIQUIDACIONES',10))
	dw_pagos.SetItem(fila_insertada,'estado','P')
	dw_pagos.SetItem(fila_insertada,'contabilizada','N')
	dw_pagos.SetItem(fila_insertada,'forma_pago',sl_forma_de_pago)
	string descripcion_prestacion
	descripcion_prestacion = f_dame_tipo_prestacion(ds_lista_prestaciones_ordenada.getitemstring(i, 'tipo_prestacion'))
	dw_pagos.SetItem(fila_insertada,'descripcion_larga',descripcion_prestacion)

	dw_pagos.SetItem(fila_insertada,'importe',f_redondea(dl_importe_total))
	choose case sl_tipo_persona
		case 'B'
			dw_pagos.SetItem(fila_insertada,'id_beneficiario',sl_id_persona)
			dw_pagos.SetItem(fila_insertada,'nombre',f_premaat_dame_nombre_beneficiario('B', sl_id_persona))
			dw_pagos.Setitem(fila_insertada,'banco',gnv_control_cuentas_bancarias.of_obtener_iban_nombre_modulo ('CLIENTES',sl_id_persona))
		case 'C'
			dw_pagos.SetItem(fila_insertada,'id_colegiado',sl_id_persona)
			dw_pagos.SetItem(fila_insertada,'nombre',f_premaat_dame_nombre_beneficiario('C', sl_id_persona))
			dw_pagos.Setitem(fila_insertada,'banco',gnv_control_cuentas_bancarias.of_obtener_iban_nombre_modulo ('COL_REMESABLE',sl_id_persona))
	end choose
	dw_pagos.Setitem(fila_insertada,'f_liquidacion',today())		
	dw_pagos.Setitem(fila_insertada,'empresa',g_empresa)	
	dw_pagos.Setitem(fila_insertada,'cod_usuario',g_usuario)	
	
next

if dw_pagos.RowCount() > 0 then
	cb_transferencias.enabled = TRUE
	cb_talones.enabled = TRUE
End if
destroy ds_lista_prestaciones_ordenada

end event

event csd_listado_pagos();string sql_nueva, lista_liquidaciones=''
long i
boolean bl_listado = false
bl_listado = (dw_opciones.getitemstring(1, 'listado') = 'S')
if not bl_listado then return
for i = 1 to dw_pagos.rowcount()
	lista_liquidaciones += "'"+dw_pagos.getitemstring(i, 'id_liquidacion') + "'"+', '
next
lista_liquidaciones = '( ' + MidA(lista_liquidaciones, 1, LenA(lista_liquidaciones) - 2) + ' )'

datastore ds_liquidacion_listado
ds_liquidacion_listado = create datastore
ds_liquidacion_listado.dataobject = 'd_premaat_listado_remesa_pagos'
ds_liquidacion_listado.SetTransObject(SQLCA)
sql_nueva = ds_liquidacion_listado.describe("datawindow.table.select") + ' WHERE estado = ~'L~' and id_liquidacion in ' + lista_liquidaciones
ds_liquidacion_listado.modify("datawindow.table.select= ~"" + sql_nueva + "~"")
//messagebox('kk', ds_liquidacion_listado.describe("datawindow.table.select"))
ds_liquidacion_listado.retrieve()
ds_liquidacion_listado.groupcalc()
ds_liquidacion_listado.sort()
ds_liquidacion_listado.print()
destroy ds_liquidacion_listado
end event

event csd_contabilizar_pagos_1_asiento();boolean bl_aplica_contabilizar = false
double dl_asiento, dl_asiento_inicial, dl_asiento_final
boolean bl_primer_asiento = true
bl_aplica_contabilizar = (dw_opciones.getitemstring(1, 'contabilizar')  = 'S')

if not bl_aplica_contabilizar then return
if not g_contabilidad_automatica then return // Modificado Ricardo 2005-04-28
//SCP-166 Verificamos que el ejercicio contable esta abierto
if NOT f_ejercicio_abierto(g_ejercicio) then
	Messagebox(g_titulo,'El ejercicio contable '+ g_ejercicio + ' no est$$HEX2$$e1002000$$ENDHEX$$abierto. No es posible continuar con el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n',stopsign!)
	return
end if

st_1.Text=g_idioma.of_getmsg('premaat.contabilizando_pagos','Contablilizando pagos... ')
dw_pagos.AcceptText()


long cuantos
string mensaje = ''
int continuar
int i
datetime fecha
double importe, saldo = 0, saldo_deudor = 0, importe_total = 0
string estado, concepto_base, concepto, formadepago, id_colegiado, cuenta_col, cliente, n_expedi
string ctabanco, contabilizada, n_documento,  cuenta_presupuestaria
string id_beneficiario
string nombre = ''
// ------ Pre-contabilizaci$$HEX1$$f300$$ENDHEX$$n
if isnull(g_num_digitos) or g_num_digitos > 10 or g_num_digitos < 6 then mensaje = mensaje + cr + "g_num_digitos"
if f_es_vacio(g_conta.cuenta_clientes_general) then mensaje = mensaje + cr + "g_conta.cuenta_clientes_general"
if f_es_vacio(g_prefijo_arqui) then mensaje = mensaje + cr + "g_prefijo_arqui"
if f_es_vacio(g_sica_diario.liq_premaat) then mensaje = mensaje + cr + "g_sica_diario.liq_premaat"
if f_es_vacio(g_t_asiento_apuntes_automaticos) then mensaje = mensaje + cr + "g_t_asiento_apuntes_automaticos"
if f_es_vacio(g_sica_t_doc.talon) then mensaje = mensaje + cr + "g_sica_t_doc.talon"
if f_es_vacio(g_sica_t_doc.transferencia) then mensaje = mensaje + cr + "g_sica_t_doc.transferencia" 
if f_es_vacio(g_sica_t_doc.generico) then mensaje = mensaje + cr + "g_sica_t_doc.generico" 
if f_es_vacio(g_centro_por_defecto) then mensaje = mensaje + cr + "g_centro_por_defecto"
if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
if f_es_vacio(g_explotacion_por_defecto) then mensaje = mensaje + cr + "g_explotacion_por_defecto"

select count(*) into :cuantos from csi_bancos where cuenta_contable = null or cuenta_contable = '';
if cuantos > 0 then Messagebox(g_titulo,g_idioma.of_getmsg('premaat.bancos_sin_cuenta',"Hay bancos sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso."),Stopsign!)

//select count(*) into :cuantos from csi_formas_de_pago where cuenta = null or cuenta = '';
//if cuantos > 0 then Messagebox(g_titulo,"Hay Formas de Pago sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso.",Stopsign!)

if mensaje <> '' then
	mensaje = 'Hay que definir las siguientes variables para poder contabilizar:' + cr + mensaje
	messagebox(g_titulo,mensaje,Stopsign!)
	Messagebox(g_titulo,g_idioma.of_getmsg('premaat.definir_variables','De momento les pondremos valores por defecto, pero no se debe poner en marcha si se lee este mensaje!!!'),Stopsign!)
	continuar = Messagebox(g_titulo,'$$HEX2$$bf002000$$ENDHEX$$Desea Continuar ? ',Question!, YesNo!)
	if continuar = 2 then 
		st_1.Text=''
		return	
	end if
	
end if

// Modificado Ricardo 2005-04-28
// Miramos que todas las fechas de las liquidaciones a realizar est$$HEX1$$e900$$ENDHEX$$n dentro del ejercicio actual
// Contabilizamos las liquidadas no contabilizadas
for i = 1 to dw_pagos.RowCount()
	estado = dw_pagos.GetItemString(i,'estado')
	if estado <> 'L' then continue
	contabilizada = dw_pagos.GetItemString(i,'contabilizada')
	if contabilizada = 'S' then continue	
	
	if string(year(date(dw_pagos.GetItemDateTime(i,'f_liquidacion'))))<>g_ejercicio then
		Messagebox(g_titulo, g_idioma.of_getmsg('premaat.liq_fuera_ejer',"Alguna de las liquidaciones a contabilizar no pertenecen al ejercicio actual, por lo que el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n se cancelar$$HEX1$$e100$$ENDHEX$$"), stopsign!)
		st_1.Text=''
		return
	end if
next
// FIN Modificado Ricardo 2005-04-28




if f_es_vacio(g_conta.cuenta_clientes_general) then g_conta.cuenta_clientes_general = '4400000'
if f_es_vacio(g_prefijo_arqui) then g_prefijo_arqui = '430'

dl_asiento = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.liq_premaat,7))
g_apunte.n_apunte = '00000'
//dl_asiento = dl_asiento - 1
if isnull(dl_asiento) then dl_asiento = 0

// Contabilizamos las liquidadas no contabilizadas
for i = 1 to dw_pagos.RowCount()
	
	fecha = dw_pagos.GetItemDateTime(i,'f_liquidacion')
	importe = dw_pagos.GetItemNumber(i,'importe')
	estado = dw_pagos.GetItemString(i,'estado')
	if estado <> 'L' then 
		continue
	end if
	contabilizada = dw_pagos.GetItemString(i,'contabilizada')
	if contabilizada = 'S' then 	
		continue	
	end if
	id_colegiado = dw_pagos.GetItemString(i,'id_colegiado')
	id_beneficiario = dw_pagos.GetItemString(i,'id_beneficiario')	
	n_documento = dw_pagos.GetItemString(i,'n_documento')
	
	concepto_base=''
	concepto_base = 'PAGO PREST.PREMAAT: '
	formadepago = dw_pagos.GetItemString(i,'forma_pago')
	ctabanco = dw_pagos.GetItemString(i,'cta_pago')

	//Rellenamos DATOS GENERALES DE G_APUNTE
	g_apunte.n_asiento = RightA('0000000' + trim(string(dl_asiento)),7)
//	g_apunte.n_apunte = '00000'
	g_apunte.n_doc = n_documento
	g_apunte.id_interno = ''
	g_apunte.fecha = datetime(date(fecha), time("00:00:00"))
	g_apunte.t_asiento = g_t_asiento_apuntes_automaticos
	g_apunte.diario = g_sica_diario.liq_premaat
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
	f_apunte_dw(g_apunte,dw_apuntes_automaticos,'E')	
	
	importe_total += importe

	//Marcamos la liquidacion como contabilizada:
	dw_pagos.SetItem(i,'contabilizada','S')
	
next

// Contrapartida total a banco
g_apunte.concepto = 'PAGO PRESTACIONES PREMAAT'
g_apunte.cuenta = ctabanco
g_apunte.debe = 0
g_apunte.haber = importe_total
g_apunte.contrapartida = g_cuenta_pago_prestaciones
f_apunte_dw(g_apunte,dw_apuntes_automaticos,'E')	

//Actualizar todo
dw_pagos.Update()
dw_apuntes_automaticos.Update()
f_actualiza_numero_bd_ejercicio(g_sica_diario.liq_premaat, dl_asiento)
dw_apuntes_automaticos.reset()

st_1.text = 'Asiento:  ' + string(dl_asiento)
end event

event csd_contabilizar_pago_colegiados();boolean bl_aplica_contabilizar = false
double dl_asiento, dl_asiento_inicial, dl_asiento_final
boolean bl_primer_asiento = true
bl_aplica_contabilizar = (dw_opciones.getitemstring(1, 'contabilizar')  = 'S')

if not bl_aplica_contabilizar then return
if not g_contabilidad_automatica then return
//SCP-166 Verificamos que el ejercicio contable esta abierto
if NOT f_ejercicio_abierto(g_ejercicio) then
	Messagebox(g_titulo,'El ejercicio contable '+ g_ejercicio + ' no est$$HEX2$$e1002000$$ENDHEX$$abierto. No es posible continuar con el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n',stopsign!)
	return
end if

st_1.Text=g_idioma.of_getmsg('premaat.contabilizando_pagos','Contablilizando pagos... ')
dw_pagos.AcceptText()


long cuantos
string mensaje = ''
int continuar
int i
datetime fecha
double importe, saldo = 0, saldo_deudor = 0, importe_total = 0
string estado, concepto_base, concepto, formadepago, id_colegiado, cuenta_col, cliente, n_expedi
string ctabanco, contabilizada, n_documento,  cuenta_presupuestaria
string id_beneficiario
string nombre = ''
string cuenta_colegiado
// ------ Pre-contabilizaci$$HEX1$$f300$$ENDHEX$$n
if isnull(g_num_digitos) or g_num_digitos > 10 or g_num_digitos < 6 then mensaje = mensaje + cr + "g_num_digitos"
if f_es_vacio(g_conta.cuenta_clientes_general) then mensaje = mensaje + cr + "g_conta.cuenta_clientes_general"
if f_es_vacio(g_prefijo_arqui) then mensaje = mensaje + cr + "g_prefijo_arqui"
if f_es_vacio(g_sica_diario.liq_premaat) then mensaje = mensaje + cr + "g_sica_diario.liq_premaat"
if f_es_vacio(g_t_asiento_apuntes_automaticos) then mensaje = mensaje + cr + "g_t_asiento_apuntes_automaticos"
if f_es_vacio(g_sica_t_doc.talon) then mensaje = mensaje + cr + "g_sica_t_doc.talon"
if f_es_vacio(g_sica_t_doc.transferencia) then mensaje = mensaje + cr + "g_sica_t_doc.transferencia" 
if f_es_vacio(g_sica_t_doc.generico) then mensaje = mensaje + cr + "g_sica_t_doc.generico" 
if f_es_vacio(g_centro_por_defecto) then mensaje = mensaje + cr + "g_centro_por_defecto"
if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
if f_es_vacio(g_explotacion_por_defecto) then mensaje = mensaje + cr + "g_explotacion_por_defecto"

select count(*) into :cuantos from csi_bancos where cuenta_contable = null or cuenta_contable = '';
if cuantos > 0 then Messagebox(g_titulo,g_idioma.of_getmsg('premaat.bancos_sin_cuenta',"Hay bancos sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso."),Stopsign!)

if mensaje <> '' then
	mensaje = 'Hay que definir las siguientes variables para poder contabilizar:' + cr + mensaje
	messagebox(g_titulo,mensaje,Stopsign!)
	Messagebox(g_titulo,g_idioma.of_getmsg('premaat.definir_variables','De momento les pondremos valores por defecto, pero no se debe poner en marcha si se lee este mensaje!!!'),Stopsign!)
	continuar = Messagebox(g_titulo,'$$HEX2$$bf002000$$ENDHEX$$Desea Continuar ? ',Question!, YesNo!)
	if continuar = 2 then 
		st_1.Text=''
		return	
	end if
	
end if

//Comprobamos que todas las liquidaciones tienen fecha perteneciente al ejercicio actual
for i = 1 to dw_pagos.RowCount()
	estado = dw_pagos.GetItemString(i,'estado')
	if estado <> 'L' then continue
	contabilizada = dw_pagos.GetItemString(i,'contabilizada')
	if contabilizada = 'S' then continue	
	
	if string(year(date(dw_pagos.GetItemDateTime(i,'f_liquidacion'))))<>g_ejercicio then
		Messagebox(g_titulo, g_idioma.of_getmsg('premaat.liq_fuera_ejer',"Alguna de las liquidaciones a contabilizar no pertenecen al ejercicio actual, por lo que el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n se cancelar$$HEX1$$e100$$ENDHEX$$"), stopsign!)
		st_1.Text=''
		return
	end if
next

if f_es_vacio(g_conta.cuenta_clientes_general) then g_conta.cuenta_clientes_general = '4400000'
if f_es_vacio(g_prefijo_arqui) then g_prefijo_arqui = '430'

dl_asiento = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.liq_premaat,7))
g_apunte.n_apunte = '00000'
if isnull(dl_asiento) then dl_asiento = 0

// Contabilizamos las liquidadaciones no contabilizadas
for i = 1 to dw_pagos.RowCount()
	
	fecha = dw_pagos.GetItemDateTime(i,'f_liquidacion')
	importe = dw_pagos.GetItemNumber(i,'importe')
	estado = dw_pagos.GetItemString(i,'estado')
	if estado <> 'L' then 
		continue
	end if
	contabilizada = dw_pagos.GetItemString(i,'contabilizada')
	if contabilizada = 'S' then 	
		continue	
	end if
	id_colegiado = dw_pagos.GetItemString(i,'id_colegiado')
	id_beneficiario = dw_pagos.GetItemString(i,'id_beneficiario')
	if f_es_vacio(id_colegiado) then
		select id_col into :id_colegiado from premaat_beneficiarios where id_heredero= :id_beneficiario;
	end if
	n_documento = dw_pagos.GetItemString(i,'n_documento')
	
	concepto_base=''
	concepto_base = 'PAGO PREST.PREMAAT: '
	formadepago = dw_pagos.GetItemString(i,'forma_pago')
	ctabanco = dw_pagos.GetItemString(i,'cta_pago')
	
	//Obtenemos cuenta de Colegiado
	//Le pasamos P como tipo de cuenta, este tipo hace referencia a la variable g_prefijo_arqui
	cuenta_colegiado=f_dame_cuenta_col(id_colegiado,'P')
	if not f_es_vacio(id_beneficiario) then
		nombre = f_dame_cliente(id_beneficiario)
	else
		nombre =	 f_colegiado_apellido(id_colegiado)
	end if
	if f_es_vacio(nombre) then nombre = ''

//Datos generales del Apunte
	g_apunte.n_asiento = RightA('0000000' + trim(string(dl_asiento)),7)
	g_apunte.n_doc = n_documento
	g_apunte.id_interno = ''
	g_apunte.fecha = datetime(date(fecha), time("00:00:00"))
	g_apunte.t_asiento = g_t_asiento_apuntes_automaticos
	g_apunte.diario = g_sica_diario.liq_premaat
	g_apunte.proyecto = g_explotacion_por_defecto
	g_apunte.centro = g_centro_por_defecto
	
	concepto_base = concepto_base + nombre
	concepto = LeftA(concepto_base,57)
	
//Creamos Apunte para el Haber en cuenta colegiado
	g_apunte.concepto = concepto
	g_apunte.cuenta = cuenta_colegiado
	g_apunte.debe = 0
	g_apunte.haber = importe
	g_apunte.contrapartida = g_cuenta_pago_prestaciones
	f_apunte_dw(g_apunte,dw_apuntes_automaticos,'E')

//Creamos Apunte para el Debe en cuenta colegiado
	g_apunte.concepto = concepto
	g_apunte.cuenta = cuenta_colegiado
	g_apunte.debe = importe
	g_apunte.haber = 0
	g_apunte.contrapartida = g_cuenta_pago_prestaciones
	f_apunte_dw(g_apunte,dw_apuntes_automaticos,'E')
	
	
	importe_total += importe

	//Marcamos la liquidacion como contabilizada:
	dw_pagos.SetItem(i,'contabilizada','S')
	
next

//Creamos apunte para la cuenta de pago de prestaciones
g_apunte.concepto = 'PAGO PRESTACIONES PREMAAT'
g_apunte.cuenta = g_cuenta_pago_prestaciones
g_apunte.debe = importe_total
g_apunte.haber = 0
g_apunte.contrapartida = ctabanco
f_apunte_dw(g_apunte,dw_apuntes_automaticos,'E')	
// Contrapartida total a banco
g_apunte.concepto = 'PAGO PRESTACIONES PREMAAT'
g_apunte.cuenta = ctabanco
g_apunte.debe = 0
g_apunte.haber = importe_total
g_apunte.contrapartida = g_cuenta_pago_prestaciones
f_apunte_dw(g_apunte,dw_apuntes_automaticos,'E')	

//Actualizar todo
dw_pagos.Update()
dw_apuntes_automaticos.Update()
f_actualiza_numero_bd_ejercicio(g_sica_diario.liq_premaat, dl_asiento)
dw_apuntes_automaticos.reset()

st_1.text = 'Asiento:  ' + string(dl_asiento)
end event

public function integer f_generar_talones (string n_talon_inicial, datetime fecha, string banco, datetime f_vencimiento, string texto_manual);datastore	ds_talon
long i, ll_n_talon = 0
string n_talon
string cuenta_banco

cuenta_banco = f_dame_cuenta_contable_banco(banco)

ds_talon						= create datastore
ds_talon.dataobject		= g_informe_talon_premaat
ds_talon.SetTransObject(SQLCA)

n_talon = n_talon_inicial
n_talon = RightA('00000000'+n_talon ,8)
// Setitems
for i= 1 to dw_pagos.RowCount()
	  if dw_pagos.getitemstring(i,'estado')='P' and dw_pagos.getitemstring(i,'forma_pago')= g_formas_pago.talon then
			ll_n_talon++
			st_1.Text='Tramitando tal$$HEX1$$f300$$ENDHEX$$n '+string(ll_n_talon)+' de '+string(dw_pagos.getitemnumber(dw_pagos.rowcount(), 'total_talones'))
			dw_pagos.SetItem(i,'n_documento',n_talon)
			dw_pagos.SetItem(i,'estado','L')
			dw_pagos.SetItem(i,'f_liquidacion',fecha)	
			dw_pagos.SetItem(i,'cta_pago',cuenta_banco)
			n_talon = RightA('00000000'+string(long(n_talon) + 1 ),8)
	  end if
next
// Actualizar
dw_pagos.Update()
ll_n_talon = 0
// Imprimir
for i= 1 to dw_pagos.RowCount()
	 if dw_pagos.getitemstring(i,'forma_pago')= g_formas_pago.talon then
		ll_n_talon++
		st_1.Text='Imprimiendo tal$$HEX1$$f300$$ENDHEX$$n '+string(ll_n_talon)+' de '+string(dw_pagos.getitemnumber(dw_pagos.rowcount(), 'total_talones'))
		ds_talon.InsertRow(0)
		ds_talon.SetItem(ds_talon.RowCount(),'id_colegiado',dw_pagos.GetItemString(i,'id_colegiado'))
		ds_talon.SetItem(ds_talon.RowCount(),'f_liquidacion',fecha)
		ds_talon.SetItem(ds_talon.RowCount(),'importe',dw_pagos.GetItemNumber(i,'importe'))
		ds_talon.SetItem(ds_talon.RowCount(),'n_documento',n_talon)
		ds_talon.Retrieve(dw_pagos.GetItemString(i,'id_liquidacion'))
	
	   // Modificado Ricardo 04-02-23
		ds_talon.Modify("fecha_vencimiento.Text='"+string(f_vencimiento, "DD/MM/YYYY")+"'")		
		ds_talon.Modify("fecha_vencimiento_talon.Text='"+string(string(day(date( f_vencimiento ))) + space(14)+ Upper(f_obtener_mes (f_vencimiento )) + FillA(' ', 30 - LenA(f_obtener_mes(f_vencimiento ))) + string(year(date(f_vencimiento))))+"'")
		// FIN Modificado Ricardo 04-02-23

	
		ds_talon.Print()
		ds_talon.Reset()	
	end if
next

destroy ds_talon
return 1
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
f_apunte_dw(g_apunte,dw_apuntes_automaticos,'E')
end subroutine

event open;call super::open;f_centrar_ventana(this)

dw_opciones.insertrow(0)
end event

on w_premaat_pago_prestaciones.create
int iCurrent
call super::create
this.cb_4=create cb_4
this.st_1=create st_1
this.dw_pagos=create dw_pagos
this.cb_generar=create cb_generar
this.dw_opciones=create dw_opciones
this.st_2=create st_2
this.cb_buscar=create cb_buscar
this.dw_apuntes_automaticos=create dw_apuntes_automaticos
this.dw_prestaciones=create dw_prestaciones
this.cb_transferencias=create cb_transferencias
this.cb_talones=create cb_talones
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_4
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_pagos
this.Control[iCurrent+4]=this.cb_generar
this.Control[iCurrent+5]=this.dw_opciones
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.cb_buscar
this.Control[iCurrent+8]=this.dw_apuntes_automaticos
this.Control[iCurrent+9]=this.dw_prestaciones
this.Control[iCurrent+10]=this.cb_transferencias
this.Control[iCurrent+11]=this.cb_talones
end on

on w_premaat_pago_prestaciones.destroy
call super::destroy
destroy(this.cb_4)
destroy(this.st_1)
destroy(this.dw_pagos)
destroy(this.cb_generar)
destroy(this.dw_opciones)
destroy(this.st_2)
destroy(this.cb_buscar)
destroy(this.dw_apuntes_automaticos)
destroy(this.dw_prestaciones)
destroy(this.cb_transferencias)
destroy(this.cb_talones)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_premaat_pago_prestaciones
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_premaat_pago_prestaciones
end type

type cb_4 from commandbutton within w_premaat_pago_prestaciones
string tag = "texto=general.salir"
integer x = 3182
integer y = 2080
integer width = 343
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
boolean cancel = true
end type

event clicked;close(parent)

end event

type st_1 from statictext within w_premaat_pago_prestaciones
integer x = 2002
integer y = 2056
integer width = 1115
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388736
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_pagos from u_dw within w_premaat_pago_prestaciones
integer x = 14
integer y = 1224
integer width = 3525
integer height = 828
integer taborder = 20
string dataobject = "d_premaat_liquidaciones_generadas"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetSort(TRUE)
inv_sort.of_SetColumnHeader (true)
inv_sort.of_SetStyle (2)

// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

type cb_generar from commandbutton within w_premaat_pago_prestaciones
boolean visible = false
integer x = 3145
integer y = 192
integer width = 425
integer height = 112
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Visualizar Pagos"
boolean default = true
end type

event clicked;boolean bl_aplica_pago_unico=false

if f_es_vacio(dw_opciones.getitemstring(1, 'forma_pago')) then
	messagebox(g_titulo,g_idioma.of_getmsg('premaat.msg_forma_pago','Especifique una forma de pago'))
	return
end if

dw_pagos.reset()

bl_aplica_pago_unico = (dw_opciones.getitemstring(1, 'pago_unico')  = 'S')


if bl_aplica_pago_unico then parent.event csd_pago_unico() else parent.event csd_pago_por_prestacion() 





end event

type dw_opciones from u_dw within w_premaat_pago_prestaciones
integer x = 46
integer y = 28
integer width = 3049
integer height = 292
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_premaat_opciones_pago"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'paga_extra'
//		dw_prestaciones.retrieve(data)
//		dw_pagos.reset()
		cb_buscar.post event clicked()
end choose



end event

type st_2 from statictext within w_premaat_pago_prestaciones
integer x = 2002
integer y = 2136
integer width = 1115
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388736
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_buscar from commandbutton within w_premaat_pago_prestaciones
integer x = 3141
integer y = 40
integer width = 425
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Buscar"
boolean default = true
end type

event clicked;string forma_pago,mes

forma_pago = dw_opciones.getitemstring(1, 'forma_pago')
mes = dw_opciones.getitemstring(1, 'mes')

dw_prestaciones.retrieve(dw_opciones.getitemstring(1, 'paga_extra'), forma_pago,mes)

// DAVID - 09/09/2004
// Para los beneficiarios en estado pasivo no debe generar prestaci$$HEX1$$f300$$ENDHEX$$n
int i
for i=dw_prestaciones.rowcount() to 1 step -1
	if dw_prestaciones.getitemstring(i, 'tipo_persona') = 'B' then
		if f_premaat_beneficiario_pasivo(dw_prestaciones.getitemstring(i, 'id_persona')) then
			dw_prestaciones.deleterow(i)
		end if
	end if
next

cb_generar.triggerevent(clicked!)

if forma_pago = 'TA' then cb_talones.visible = true
if forma_pago = 'TR' then cb_transferencias.visible = true

st_1.text = ''
st_2.text = ''
end event

type dw_apuntes_automaticos from u_dw within w_premaat_pago_prestaciones
boolean visible = false
integer x = 41
integer y = 1232
integer width = 361
integer height = 128
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_apuntes_automaticos"
end type

event constructor;call super::constructor;SetTransObject(bd_ejercicio)
end event

type dw_prestaciones from u_dw within w_premaat_pago_prestaciones
integer x = 14
integer y = 324
integer width = 3520
integer height = 904
integer taborder = 11
string dataobject = "d_premaat_prestaciones_lista"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;long i
string sl_marcar
choose case dwo.name
	case 'b_select'
		if dw_prestaciones.getitemstring(1, 'aplicar') = 'S' then
			sl_marcar = 'N'
		else
			sl_marcar = 'S'
		end if
		
		for i = 1 to dw_prestaciones.rowcount()
			dw_prestaciones.setitem(i, 'aplicar' , sl_marcar)
		next
end choose
end event

event constructor;call super::constructor;this.of_SetSort(TRUE)
inv_sort.of_SetColumnHeader (true)
inv_sort.of_SetStyle (2)
end event

type cb_transferencias from commandbutton within w_premaat_pago_prestaciones
boolean visible = false
integer x = 1367
integer y = 2068
integer width = 613
integer height = 148
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Emitir Transferencias"
end type

event clicked;//SCP-492 En funci$$HEX1$$f300$$ENDHEX$$n del control de eventos se contabilizar$$HEX2$$e1002000$$ENDHEX$$de forma distinta
string lista_liquidaciones,nombre_ventana
st_control_eventos c_evento
c_evento.evento='CONTA_PRESTA'
f_control_eventos(c_evento)

nombre_ventana = Parent.classname() // A fin de evitar Bad Runtime Reference
SetPointer(Hourglass!)

// Comprobar que hay tranferencias
if dw_pagos.getitemnumber(dw_pagos.rowcount(), 'total_transferencias') <= 0 then
	messagebox(g_titulo,g_idioma.of_getmsg('premaat.tranf_proc','No hay transferencias para procesar'))
	return
end if

IF NOT gnv_control_cuentas_bancarias.of_validar_datos_bancarios_movimientos('P', dw_pagos) THEN RETURN -1
Openwithparm(w_premaat_datos_remesa, 'PREMAAT')
i_datos_remesa = Message.PowerObjectParm	
IF f_genera_csb34(dw_pagos, i_datos_remesa, nombre_ventana, lista_liquidaciones) = -1 THEN RETURN -1

SetPointer(HourGlass!)
parent.event csd_borrar_unicas()

if c_evento.param1='1' then
	parent.event csd_contabilizar_pago_colegiados()
else
	parent.event csd_contabilizar_pagos_1_asiento()
end if

IF dw_opciones.getitemstring(1, 'listado') = 'S' THEN f_imprimir_listado_transferencias (nombre_ventana, lista_liquidaciones) // parent.event csd_listado_pagos() 


SetPointer(Arrow!)

Messagebox(g_titulo,g_idioma.of_getmsg('premaat.msg_fin_proceso','Proceso Finalizado.'))
end event

type cb_talones from commandbutton within w_premaat_pago_prestaciones
boolean visible = false
integer x = 1367
integer y = 2064
integer width = 613
integer height = 148
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Emitir Talones"
end type

event clicked;string n_talon_inicial, banco, texto_manual
datetime fecha_talon, f_vencimiento

if dw_pagos.getitemnumber(dw_pagos.rowcount(), 'total_talones') <= 0 then
	messagebox(g_titulo, g_idioma.of_getmsg('premaat.talones_procesar','No hay talones para procesar'))
	return
end if

st_liquidacion_datos_talon ds_talon

Open(w_premaat_liquid_n_talon_inicial)
ds_talon = Message.PowerObjectParm
if ds_talon.n_talon_inicial='-1' then return   //Opci$$HEX1$$f300$$ENDHEX$$n Cancelar de la ventana de tal$$HEX1$$f300$$ENDHEX$$n inicial
n_talon_inicial = ds_talon.n_talon_inicial
fecha_talon	= ds_talon.fecha_talon
banco = ds_talon.banco
// MODIFICADO RICARDO 04-02-23
f_vencimiento = ds_talon.f_vencimiento
texto_manual = ds_talon.texto_manual


f_generar_talones(n_talon_inicial,fecha_talon,banco, f_vencimiento, texto_manual)
// FIN MODIFICADO RICARDO 04-02-23

//this.enabled = FALSE

parent.event csd_borrar_unicas()
parent.event csd_contabilizar_pagos()
parent.event csd_listado_pagos()

Messagebox(g_titulo,g_idioma.of_getmsg('premaat.msg_fin_proceso','Proceso Finalizado.'))

end event

