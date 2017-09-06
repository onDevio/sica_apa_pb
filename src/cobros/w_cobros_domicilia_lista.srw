HA$PBExportHeader$w_cobros_domicilia_lista.srw
forward
global type w_cobros_domicilia_lista from w_lista
end type
type cb_f19 from commandbutton within w_cobros_domicilia_lista
end type
type cb_fichero from commandbutton within w_cobros_domicilia_lista
end type
type st_aviso from statictext within w_cobros_domicilia_lista
end type
type cb_marcar from commandbutton within w_cobros_domicilia_lista
end type
type rb_col from radiobutton within w_cobros_domicilia_lista
end type
type rb_ape from radiobutton within w_cobros_domicilia_lista
end type
type dw_modo_cont from u_dw within w_cobros_domicilia_lista
end type
type gb_orden from groupbox within w_cobros_domicilia_lista
end type
type cb_ocultar_apuntes from commandbutton within w_cobros_domicilia_lista
end type
type cb_actualizar_apuntes from commandbutton within w_cobros_domicilia_lista
end type
type dw_apuntes from u_dw within w_cobros_domicilia_lista
end type
type cb_imprimir_apuntes from commandbutton within w_cobros_domicilia_lista
end type
type cb_desmarcar from commandbutton within w_cobros_domicilia_lista
end type
type dw_historico from pfc_u_dw within w_cobros_domicilia_lista
end type
end forward

global type w_cobros_domicilia_lista from w_lista
integer width = 3863
integer height = 1752
string title = "Lista de Cobros"
string menuname = "m_cobros_lista"
event csd_f19 ( )
event csd_contabilizar ( )
event csd_cobrar ( )
event csd_contabilizar_old ( )
event csd_cobros_vencimiento ( )
cb_f19 cb_f19
cb_fichero cb_fichero
st_aviso st_aviso
cb_marcar cb_marcar
rb_col rb_col
rb_ape rb_ape
dw_modo_cont dw_modo_cont
gb_orden gb_orden
cb_ocultar_apuntes cb_ocultar_apuntes
cb_actualizar_apuntes cb_actualizar_apuntes
dw_apuntes dw_apuntes
cb_imprimir_apuntes cb_imprimir_apuntes
cb_desmarcar cb_desmarcar
dw_historico dw_historico
end type
global w_cobros_domicilia_lista w_cobros_domicilia_lista

type variables
st_cobros_datos_remesa i_datos_remesa
datastore i_ds_domiciliaciones
string i_banco
string i_lista_no_validos = ''
string i_orden_listado = 'NUMERO' //NUMERO O APELLIDOS

// Para la parte de contabilizacion de cobros sueltos
long i_asiento_exp, i_asiento_ot, i_asiento_rem
boolean ib_pendiente_guardar_contabilizacion = false


end variables

forward prototypes
public function boolean wf_comprobar_si_cambiar_asiento (string modo_contabilizacion, string n_remesa, string n_remesa_old, string id_fase, string id_minuta, string id_fase_old, string id_minuta_old)
public subroutine wf_crear_apunte (datetime fecha, string cuenta, string concepto, double debe, double haber, string orden_apunte, string contrapartida)
end prototypes

event csd_f19;cb_f19.event clicked()
end event

event csd_contabilizar();// PROCESO REMODELADO POR RICARDO 2005-03-07
// Creado por Ricardo 04-04-27
// Evento que contabiliza todos aquellos cobros cuyas facturas est$$HEX1$$e100$$ENDHEX$$n ya contabilizadas y han sido pagados
// La contabilizaci$$HEX1$$f300$$ENDHEX$$n puede ser cobro a cobro (modo contabilizacion = 'N')
//                              por remesas   (modo contabilizacion = 'R')

if not g_contabilidad_automatica then return

//SCP-166 Verificamos que el ejercicio contable esta abierto
if NOT f_ejercicio_abierto(g_ejercicio) then
	Messagebox(g_titulo,'El ejercicio contable '+ g_ejercicio + ' no est$$HEX2$$e1002000$$ENDHEX$$abierto. No es posible continuar con el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n.',stopsign!)
	return
end if

// Acpetamos los posible cambios que hayan hecho
dw_modo_cont.accepttext()
dw_lista.AcceptText()


// Variables adicionales
string mensaje = '', modo_contabilizacion, tipo_documento_remesa
long cuantos, continuar, fila_cobro
boolean b_actualizar_cobros = false, b_cambiar_asiento
double total_asiento, total_remesa
// VAriables para cobros
string contabilizado, pagado,tipo_pago_cobro,banco_cobro, forma_pago_cobro
string nombre, nif, id_col, id_persona, tipo_factura
string n_expedi, id_fase, id_minuta, id_fase_old, id_minuta_old,n_remesa, n_remesa_old = '-1'
boolean b_HayIngresocobro
datetime fecha_pago_cobro
double total_cobro
// Variables para la factura
string formadepago,n_visado
double subtotal, importe_reten, subtotal_iva
// VAriables para el asiento
string concepto_base, concepto_cobro, concepto, cuenta_col, cuenta_ret,ctabanco_cobro, id_factura, cuenta_cp


// ------ Pre-contabilizaci$$HEX1$$f300$$ENDHEX$$n
if isnull(g_num_digitos) or g_num_digitos > 10 or g_num_digitos < 6 then mensaje = mensaje + cr + "g_num_digitos"
if f_es_vacio(g_conta.cuenta_clientes_general) then mensaje = mensaje + cr + "g_conta.cuenta_clientes_general"
if f_es_vacio(g_prefijo_arqui) then mensaje = mensaje + cr + "g_prefijo_arqui"
if f_es_vacio(g_sica_diario.facts_emitidas_exp) then mensaje = mensaje + cr + "g_sica_diario.facts_emitidas_exp"
if f_es_vacio(g_sica_diario.facts_emitidas_ot) then mensaje = mensaje + cr + "g_sica_diario.facts_emitidas_ot"
if f_es_vacio(g_sica_diario.remesas) then mensaje = mensaje + cr + "g_sica_diario.remesas"
if f_es_vacio(g_t_asiento_apuntes_automaticos) then mensaje = mensaje + cr + "g_t_asiento_apuntes_automaticos"
if f_es_vacio(g_sica_t_doc.facts_emitidas_exp) then mensaje = mensaje + cr + "g_sica_t_doc.facts_emitidas_exp"
if f_es_vacio(g_sica_t_doc.facts_emitidas_ot) then mensaje = mensaje + cr + "g_sica_t_doc.facts_emitidas_ot"
if f_es_vacio(g_sica_t_doc.transferencia) then mensaje = mensaje + cr + "g_sica_t_doc.transferencia"
if f_es_vacio(g_sica_t_doc.talon) then mensaje = mensaje + cr + "g_sica_t_doc.talon"
if f_es_vacio(g_sica_t_doc.generico) then mensaje = mensaje + cr + "g_sica_t_doc.generico"
if f_es_vacio(g_centro_por_defecto) then mensaje = mensaje + cr + "g_centro_por_defecto"

if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
if f_es_vacio(g_explotacion_por_defecto) then mensaje = mensaje + cr + "g_explotacion_por_defecto"


select count(*) into :cuantos from csi_bancos where cuenta_contable = null or cuenta_contable = '' and empresa =: g_empresa;
if cuantos > 0 then Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.cuenta_cont_indef',"Hay bancos sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso."),Stopsign!)
//select count(*) into :cuantos from csi_formas_de_pago where cuenta = null or cuenta = '';
//if cuantos > 0 then Messagebox(g_titulo,"Hay Formas de Pago sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso.",Stopsign!)
tipo_documento_remesa = g_sica_t_doc.remesas
if f_es_vacio(tipo_documento_remesa) then tipo_documento_remesa = 'RE'

if mensaje <> '' then
	mensaje = g_idioma.of_getmsg('msg_cobros.definir_variables','Hay que definir las siguientes variables para poder contabilizar:') + cr + mensaje
	messagebox(g_titulo,mensaje,Stopsign!)
	Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.valores_defecto','De momento les pondremos valores por defecto, pero no se debe poner en marcha si se lee este mensaje!!!'),Stopsign!)
	continuar = Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.desea_continuar','$$HEX2$$bf002000$$ENDHEX$$Desea Continuar ? '),Question!, YesNo!)
	if continuar = 2 then return	
end if

// Modificado Ricardo 2005-04-27
// miramos que todas las fechas de pago est$$HEX1$$e900$$ENDHEX$$n dentro del ejercicio
FOR fila_cobro = 1 TO dw_lista.RowCount()
	yield()
	contabilizado = dw_lista.GetItemString(fila_cobro,'contabilizado')
	if contabilizado = 'S' then continue	
	// Miramos si est$$HEX2$$e1002000$$ENDHEX$$pagado
	pagado = dw_lista.GetItemString(fila_cobro,'pagado')
	if pagado = 'N' then continue	
	// Miramos que la factura est$$HEX2$$e9002000$$ENDHEX$$contabilizada
	contabilizado = dw_lista.GetItemString(fila_cobro,'csi_facturas_emitidas_contabilizada')
	if contabilizado = 'N' then continue	

	if string(year(date(dw_lista.GetItemDateTime(fila_cobro,'f_pago'))))<>g_ejercicio then 
		MessageBox(g_titulo, "La fecha de pago del cobro (fila "+string(fila_cobro)+") no pertenece al ejercicio actual. El proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n ha sido cancelado.", stopsign!)
		return
	end if
NEXT
// fin Modificado Ricardo 2005-04-27



if f_es_vacio(g_conta.cuenta_clientes_general) then g_conta.cuenta_clientes_general = '4400000'
if f_es_vacio(g_prefijo_arqui) then g_prefijo_arqui = '430'
tipo_documento_remesa = g_sica_t_doc.remesas
if f_es_vacio(tipo_documento_remesa) then tipo_documento_remesa = 'RE'

// Vaciamos los aputnes existentes para no liar la perdiz
if dw_apuntes.RowCount()>0 and dw_apuntes.trigger event pfc_updatespending()>0 then
	if Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.apuntes_generados_noguardados', "Existen ya apuntes generados y no guardados")+cr+g_idioma.of_getmsg('msg_cobros.desea_descartar_apuntes',"$$HEX1$$bf00$$ENDHEX$$Desea descartar estos apuntes?"), question!, yesno!, 2) = 2 then return
end if
dw_apuntes.reset()
dw_apuntes.visible = false
cb_ocultar_apuntes.text = '&Mostrar Ap.' // CAmbio el texto de todas formas
cb_actualizar_apuntes.visible = false
cb_ocultar_apuntes.visible = false
cb_imprimir_apuntes.visible = false



modo_contabilizacion = dw_modo_cont.getitemstring(1, 'modo_contabilizacion')
i_asiento_exp = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.facts_emitidas_exp,7))
i_asiento_ot =  long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.facts_emitidas_ot,7))
i_asiento_rem = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.remesas ,7))
i_asiento_exp = i_asiento_exp - 1
i_asiento_ot = i_asiento_ot - 1
i_asiento_rem = i_asiento_rem - 1
if isnull(i_asiento_exp) then i_asiento_exp = 0
if isnull(i_asiento_ot) then i_asiento_ot = 0
if isnull(i_asiento_rem) then i_asiento_rem = 0
g_apunte.n_apunte = '00000'


// Miramos cada uno de los cobros... 
// Si pertenecen a una factura contabilizada y el cobro est$$HEX2$$e1002000$$ENDHEX$$no contabilizado lo procesaremos
//Messagebox(g_titulo, "Solo se contabilizar$$HEX1$$e100$$ENDHEX$$n los cobros pagados de facturas contabilizadas."+cr+"Las facturas que hayan sido abonadas incluyendose en una liquidaci$$HEX1$$f300$$ENDHEX$$n el cobro de la misma no genera apuntes, quedan englobados en la liquidaci$$HEX1$$f300$$ENDHEX$$n correspondiente")

// Si la contabilizacion es por remesas debemos ordenar pos este valor
if modo_contabilizacion = 'R' OR modo_contabilizacion = 'R' then 
	dw_lista.setsort("n_remesa_real A, de_expediente A, id_fase D, id_remesa D")
else
	dw_lista.setsort("de_expediente A, id_fase D, id_minuta D")
end if
dw_lista.sort()


//////////////////////////////////////////////////////////////////////////////////
// Ahora procesamos los cobros de facturas ya contabilizadas
//////////////////////////////////////////////////////////////////////////////////
b_cambiar_asiento = true // Hay que crear el primer asiento seguro!
total_remesa = 0
total_asiento = 0


FOR fila_cobro = 1 TO dw_lista.RowCount()
	yield()
	
	contabilizado = dw_lista.GetItemString(fila_cobro,'contabilizado')
	if contabilizado = 'S' then continue	
	// Miramos si est$$HEX2$$e1002000$$ENDHEX$$pagado
	pagado = dw_lista.GetItemString(fila_cobro,'pagado')
	if pagado = 'N' then continue	
//	// Miramos que la factura est$$HEX2$$e9002000$$ENDHEX$$contabilizada
//	contabilizado = dw_lista.GetItemString(fila_cobro,'csi_facturas_emitidas_contabilizada')
//	if contabilizado = 'N' then continue	
	
	
	n_remesa = dw_lista.getitemstring(fila_cobro, 'n_remesa_real')
	id_factura = dw_lista.GetItemString(fila_cobro,'id_factura')
	id_fase = dw_lista.GetItemString(fila_cobro,'id_fase')
	id_minuta = dw_lista.GetItemString(fila_cobro,'id_minuta')

	if n_remesa_old = '-1' or (f_es_vacio(n_remesa_old) and not f_es_vacio(n_remesa) and modo_contabilizacion<>'A')  then n_remesa_old = n_remesa // Inicializamos el valor de la remesa al de la primera remesa


	if (modo_contabilizacion = 'R' or modo_contabilizacion = 'A')  and n_remesa_old <> n_remesa then
		// Hay que hacer la contabilizacion de la remesa anterior y preparar la siguiente
		// Total: al debe del banco
//			g_apunte.diario = g_sica_diario.remesas
		g_apunte.id_interno = n_remesa_old
		g_apunte.n_doc = n_remesa_old
		g_apunte.t_doc = tipo_documento_remesa
		g_apunte.nif = ''
		g_apunte.nombre = ''
		// Generamos el apunte
		wf_crear_apunte(fecha_pago_cobro, ctabanco_cobro, 'Rem. '+ n_remesa_old, total_remesa, 0, '', '')		
		// Cuando hay varios diarios, al hay que ver si cambia de uno a otro para saber si hay que cambiar de asiento o no
		if not b_cambiar_asiento then b_cambiar_asiento = wf_comprobar_si_cambiar_asiento(modo_contabilizacion, n_remesa, n_remesa_old, id_fase,id_minuta,id_fase_old,id_minuta_old)

		// VAciamos la remesa
		total_remesa = 0
		n_remesa_old = n_remesa
	else
		// Cuando hay varios diarios, al hay que ver si cambia de uno a otro para saber si hay que cambiar de asiento o no
		if not b_cambiar_asiento then b_cambiar_asiento = wf_comprobar_si_cambiar_asiento(modo_contabilizacion, n_remesa, n_remesa_old, id_fase,id_minuta,id_fase_old,id_minuta_old)
	end if
	
	// Cogemos variables temporales que nos ser$$HEX1$$e100$$ENDHEX$$n necesarias
	id_persona = dw_lista.GetItemString(fila_cobro,'id_persona')
	tipo_factura = dw_lista.GetItemString(fila_cobro,'tipo_factura')
	n_expedi = dw_lista.GetItemString(fila_cobro,'n_exp')
	forma_pago_cobro = dw_lista.GetItemString(fila_cobro,'forma_pago')
	fecha_pago_cobro = dw_lista.GetItemDateTime(fila_cobro,'f_pago')
	total_cobro	= dw_lista.GetItemNumber(fila_cobro,'importe')
	banco_cobro = dw_lista.getitemstring(fila_cobro, 'banco')
	nif = dw_lista.getitemstring(fila_cobro, 'n_col') //$$HEX1$$bf00$$ENDHEX$$?
	nombre = dw_lista.getitemstring(fila_cobro, 'csi_facturas_emitidas_nombre')
	formadepago = dw_lista.GetItemString(fila_cobro,'facturas_formadepago')
	subtotal = dw_lista.GetItemNumber(fila_cobro,'facturas_subtotal')
	importe_reten = dw_lista.GetItemNumber(fila_cobro,'facturas_importe_reten')
	subtotal_iva = dw_lista.GetItemNumber(fila_cobro,'facturas_iva')
	// Obtenemos algunos datos adicionales
	select hay_ingreso into :tipo_pago_cobro from csi_formas_de_pago where tipo_pago = :forma_pago_cobro;
	b_HayIngresocobro = (upper(tipo_pago_cobro) = 'S')
	//Banco y su cuenta contable:
	select cuenta_contable into :ctabanco_cobro from csi_bancos where codigo = :banco_cobro and empresa =:g_empresa;

	CHOOSE CASE tipo_factura
		CASE '04'
			// Factura de honorarios
			cuenta_col = f_dame_cuenta_col(id_persona,'P')	// personal / honorarios
			cuenta_cp = f_dame_cuenta_col(id_persona,'CP')
		CASE '03'
			// Factura de gastos, o de colegiado
			cuenta_col = f_dame_cuenta_col(id_persona,'G')	// personal / honorarios
			cuenta_cp = f_dame_cuenta_col(id_persona,'CP')
		CASE '02'
			// Factura a cliente
			cuenta_ret = g_cuenta_irpf_cliente_generica
			cuenta_col = ''
			cuenta_cp = ''
			//Obtenci$$HEX1$$f300$$ENDHEX$$n cuenta contable del cliente. Si es vac$$HEX1$$ed00$$ENDHEX$$a se pone la general
			select cuenta_contable into :cuenta_col from clientes where id_cliente = :id_persona;
			if f_es_vacio(cuenta_col) and g_conta.crear_cuentas_clientes_terceros = 'S' then
				cuenta_col = f_cuenta_contable_defecto_cli_provs('C', id_persona)
			elseif f_es_vacio(cuenta_col) then
				cuenta_col = g_conta.cuenta_clientes_general
			end if
	END CHOOSE
	
	// David - Modificado 20/09/2007
	if forma_pago_cobro = 'CP' then ctabanco_cobro = cuenta_cp
	
	concepto_base = 'Pago Fact N$$HEX2$$ba002000$$ENDHEX$$'+dw_lista.GetItemString(fila_cobro,'n_fact')
	concepto_cobro = LeftA('Ing ' + concepto_base,57)
	if forma_pago_cobro = g_formas_pago.domiciliacion then concepto_cobro = LeftA('Dom ' + concepto_base,57)
	
	dw_lista.SetItem(fila_cobro, 'f_contabilizado',fecha_pago_cobro)
	dw_lista.SetItem(fila_cobro, 'contabilizado','S')

	CHOOSE CASE forma_pago_cobro
		CASE g_formas_pago.liquidacion
			// Si la forma de pago del cobro es 'LI' o de la factura es 'LI' saltamos la generacion del apunte
			continue
		CASE g_formas_pago.cargo
			// Si la forma de pago del cobro es 'CA' o de la factura es 'CA' saltamos la generacion del apunte
			continue
		CASE g_formas_pago.pendientes_abono
			// Si la forma de pago del cobro es 'PA' o de la factura es 'PA' saltamos la generacion del apunte
			setnull(fecha_pago_cobro)
			dw_lista.SetItem(fila_cobro, 'f_contabilizado',fecha_pago_cobro)
			dw_lista.SetItem(fila_cobro, 'contabilizado','N')
			continue
	END CHOOSE
	// No procesamos las 'LI' ni las 'CA'
	if formadepago = g_formas_pago.liquidacion then continue
	if formadepago = g_formas_pago.cargo then continue

	IF not b_HayIngresocobro then continue

	// Modificamos el concepto apra decir que es parte de una remesa
	if (modo_contabilizacion = 'R' or modo_contabilizacion = 'A') and not f_es_vacio(n_remesa) then concepto_cobro = 'Rem. '+n_remesa+' ('+concepto_cobro+')'

	
	////////////////////////////////////////////////////////
	//Rellenamos DATOS GENERALES DE G_APUNTE
	////////////////////////////////////////////////////////
	if b_cambiar_asiento then
		if (modo_contabilizacion = 'R' or modo_contabilizacion = 'A') and not f_es_vacio(n_remesa) then
			// VAn contra el diario de la remesa
			i_asiento_rem++
			g_apunte.diario = g_sica_diario.remesas
			g_apunte.n_asiento = RightA('0000000' + trim(string(i_asiento_rem)),7)
			g_apunte.n_apunte = '00000'

			// Si el diario de exp es el mismo, hay que incrementar la otra variable tambien
			if g_sica_diario.remesas = g_sica_diario.facts_emitidas_ot then i_asiento_ot++
			// Si el diario de ot es el mismo, hay que incrementar la otra variable tambien
			if g_sica_diario.remesas = g_sica_diario.facts_emitidas_exp then i_asiento_exp++
			// POnemos el centro por defecto
			g_apunte.centro = g_centro_por_defecto
			g_apunte.base_imp = 0
			g_apunte.nif = ''
			g_apunte.nombre = ''
			
			b_cambiar_asiento = false
		else
			// SEg$$HEX1$$fa00$$ENDHEX$$n si la factura va relacionada con un contrato o no va contra uno u otro diario
			if f_es_vacio(id_fase) and f_es_vacio(id_minuta) then
				i_asiento_ot++
				g_apunte.diario = g_sica_diario.facts_emitidas_ot
				g_apunte.n_asiento = RightA('0000000' + trim(string(i_asiento_ot)),7)
				g_apunte.n_apunte = '00000'
				
				// Si el diario de exp es el mismo, hay que incrementar la otra variable tambien
				if g_sica_diario.facts_emitidas_ot = g_sica_diario.facts_emitidas_exp then i_asiento_exp++
				// Si el diario de remesas es el mismo, hay que incrementar la otra variable tambien
				if g_sica_diario.facts_emitidas_ot = g_sica_diario.remesas then i_asiento_rem++
				// POnemos el centro por defecto
				g_apunte.centro = g_centro_por_defecto
				g_apunte.base_imp = 0
				g_apunte.nif = ''
				g_apunte.nombre = ''
			else
				i_asiento_exp++
				g_apunte.diario = g_sica_diario.facts_emitidas_exp
				g_apunte.n_asiento = RightA('0000000' + trim(string(i_asiento_exp)),7)
				g_apunte.n_apunte = '00000'

				// Si el diario de ot es el mismo, hay que incrementar la otra variable tambien
				if g_sica_diario.facts_emitidas_exp = g_sica_diario.facts_emitidas_ot then i_asiento_ot++
				// Si el diario de remesas es el mismo, hay que incrementar la otra variable tambien
				if g_sica_diario.facts_emitidas_exp = g_sica_diario.remesas then i_asiento_rem++
				// POnemos el centro por defecto
				g_apunte.centro = g_centro_por_defecto
				g_apunte.base_imp = 0
				g_apunte.nif = ''
				g_apunte.nombre = ''
			end if
			b_cambiar_asiento = false
		end if
	end if
	g_apunte.centro = dw_lista.GetItemString(fila_cobro,'centro')	
	choose case forma_pago_cobro
		case g_formas_pago.transferencia
			g_apunte.t_doc = g_sica_t_doc.transferencia
		case g_formas_pago.talon
			g_apunte.t_doc = g_sica_t_doc.talon
		case else
			g_apunte.t_doc = g_sica_t_doc.generico
	end choose

	// Si pertenece a una remesa, el tipo de documento ser$$HEX2$$e1002000$$ENDHEX$$remesa
	if modo_contabilizacion = 'N' or (f_es_vacio(n_remesa) and (modo_contabilizacion = 'R' or modo_contabilizacion = 'A'))  then 
		g_apunte.id_interno = id_factura
		g_apunte.n_doc = dw_lista.GetItemString(fila_cobro,'n_fact')
	end if 
	if (modo_contabilizacion = 'R' or modo_contabilizacion = 'A') and not f_es_vacio(n_remesa) then 
		g_apunte.n_doc = n_remesa
		g_apunte.t_doc = tipo_documento_remesa
		g_apunte.id_interno = n_remesa
	end if

	// Generamos el apunte correspondiente...
	CHOOSE CASE formadepago
		CASE g_formas_pago.pendientes_abono
			// Tratamiento especial para zaragoza
			CHOOSE CASE tipo_factura
				CASE '04'
					n_visado = dw_lista.GetItemString(fila_cobro,'n_salida')
					concepto = 'V$$HEX2$$ba002000$$ENDHEX$$' +n_visado+' '+nombre
					// Este es especial para zaragoza... 
					// Tenemos que deshacer lo que hizo el apunte en su dia
					// -> VA apunte y contraapunte por el total a la cuenta del colegiado :O
					// -> apunte contra la 44100001 y contraapunte por el total a la cuenta especial del colegiado :O (con prefijo 4130)
					cuenta_col = f_dame_cuenta_col(id_persona,'A')	// Cuenta pendite abono
					wf_crear_apunte(fecha_pago_cobro, cuenta_col, concepto, subtotal+subtotal_iva, 0, '', '')
					wf_crear_apunte(fecha_pago_cobro, g_cuenta_puente_pendiente_abono_hon, concepto, 0, subtotal+subtotal_iva, '', '')
					cuenta_col = f_dame_cuenta_col(id_persona,'P')	// Personal//Honorarios
					wf_crear_apunte(fecha_pago_cobro, cuenta_col, LeftA('IRPF ' + concepto,57), importe_reten, 0, '', '')
					wf_crear_apunte(fecha_pago_cobro, cuenta_col, concepto, 0, subtotal+subtotal_iva, '', '')
				CASE '02'
					n_visado = dw_lista.GetItemString(fila_cobro,'fases_archivo_real')
					concepto = 'V$$HEX2$$ba002000$$ENDHEX$$' +n_visado+' '+nombre
					// Este es especial para zaragoza... 
					// Tenemos que deshacer lo que hizo el apunte en su dia
					wf_crear_apunte(fecha_pago_cobro, g_cuenta_puente_pendiente_abono_dv, concepto, 0, subtotal+subtotal_iva, '', '')
					wf_crear_apunte(fecha_pago_cobro, cuenta_col, concepto, subtotal+subtotal_iva, 0, '', '')
					wf_crear_apunte(fecha_pago_cobro, cuenta_col, concepto, 0, subtotal+subtotal_iva, '', '')
			END CHOOSE
		CASE ELSE
			if tipo_factura <> '04' then
				//Abono en cuenta del colegiado:
				g_apunte.nif = nif
				g_apunte.nombre = nombre
				wf_crear_apunte(fecha_pago_cobro, cuenta_col, concepto_cobro, 0, total_cobro, '', ctabanco_cobro)
			end if
	END CHOOSE
	if modo_contabilizacion = 'N' or f_es_vacio(n_remesa) then
		// Total: al debe del banco
		wf_crear_apunte(fecha_pago_cobro, ctabanco_cobro, concepto_cobro, total_cobro, 0, '', cuenta_col)
	end if
	// Solo si estamos con una remesa valida vamos 
	if not(modo_contabilizacion = 'N' or f_es_vacio(n_remesa)) then total_remesa += total_cobro
	total_asiento += total_cobro
	n_remesa_old = n_remesa
	id_fase_old = id_fase
	id_minuta_old = id_minuta
	
NEXT
if (modo_contabilizacion = 'R' or modo_contabilizacion = 'A') and not (f_es_vacio(n_remesa_old) or n_remesa_old = '-1') then
	// Hay que hacer la contabilizacion de la remesa anterior puesto que era la ultima antes de salir del bucle y faltar$$HEX2$$e1002000$$ENDHEX$$el contraasiento
	// Total: al debe del banco
	g_apunte.id_interno = n_remesa_old
	g_apunte.n_doc = n_remesa_old
	g_apunte.t_doc = tipo_documento_remesa
	g_apunte.nif = ''
	g_apunte.nombre = ''
	wf_crear_apunte(fecha_pago_cobro, ctabanco_cobro, 'Rem. '+ n_remesa_old, total_remesa, 0, '', '')
end if


dw_apuntes.groupcalc()
cb_ocultar_apuntes.text = '&Ocultar Ap.' // CAmbio el texto de todas formas
if dw_apuntes.RowCount()>0 then
	if messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.proceso_finalizado','Proceso Finalizado')+cr+ g_idioma.of_getmsg('msg_cobros.pulsar_grabar_apuntes',"Los apuntes generado no se guardar$$HEX1$$e100$$ENDHEX$$n hasta que pulse el bot$$HEX1$$f300$$ENDHEX$$n de grabar apuntes.") +cr+g_idioma.of_getmsg('msg_cobros.visualizar_apuntes','$$HEX1$$bf00$$ENDHEX$$Desea visualizar los apuntes para revisarlos antes de que queden grabados?'), question!, yesno!, 1)=1 then
		// visualizamos el dw de apuntes
		dw_apuntes.visible = true
	else
		cb_ocultar_apuntes.text = '&Mostrar Ap.' // CAmbio el texto de todas formas
	end if
	// Mostramos los botones de todas formas
	cb_actualizar_apuntes.visible = true
	cb_ocultar_apuntes.visible = true
	cb_imprimir_apuntes.visible = true
	ib_pendiente_guardar_contabilizacion = true
elseif b_actualizar_cobros then
	dw_lista.update() // Como solo se ha marcado el check de algunos cobros que no generan apuntes, grabamos automaticamente
	Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.finalizado_sin_apunte', 'Proceso finalizado sin la generaci$$HEX1$$f300$$ENDHEX$$n de ning$$HEX1$$fa00$$ENDHEX$$n apunte'))
else	
	Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.finalizado_sin_apunte', 'Proceso finalizado sin la generaci$$HEX1$$f300$$ENDHEX$$n de ning$$HEX1$$fa00$$ENDHEX$$n apunte'))
end if

end event

event csd_cobrar();// CREADO POR RICARDO 04-04-30
// Creado para cobrar una serie de cobros mostrados en la lista

// Si no hay cobros en pantalla salimos 
if dw_lista.rowcount()<1 then return

// Si no hay cobros por pagar salimos sin grabar
st_cobros_pagar_cobros st_cobros
double importe_pagar = 0
long fila, res
boolean b_sin_pagar = false


// hacemos el aceptext y el grabado
dw_lista.trigger event pfc_accepttext(true)
dw_modo_cont.trigger event pfc_accepttext(true)

// Intentamos grabar los cambios
if dw_lista.trigger event pfc_updatespending() >0 then
	if messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.antes_grabar_cambios',"Antes de realizar este proceso deben grabarse todos los cambios realizados. ")+cr+g_idioma.of_getmsg('msg_cobros.actualizar_ahora',"$$HEX1$$bf00$$ENDHEX$$Actualizar ahora?"), question!, yesno!, 2) = 2 then return
	res = this.trigger event pfc_save()
	if res < 0 then return // Ha fallado el grabado
end if



// Recorremos la lista para acumular la suma de lo que nos tienen que pagar (y averiguar si hay sin pagar)
FOR fila = 1 TO dw_lista.RowCount()
	dw_lista.SetItem(fila, 'modificado', 'N') // Modificamos esto pero a la vez le decimos que no
	dw_lista.SetItemStatus(fila, 'modificado', primary!, notmodified!) // Modificamos esto pero a la vez le decimos que no
	
	if dw_lista.GetItemString(fila, 'pagado') = 'N' then
		b_sin_pagar = true
		importe_pagar += dw_lista.GetItemNumber(fila, 'importe')
	end if
NEXT

/*
OCULTADO POR LA PELIGROSIDAD QUE CONLLEVA, ya que si est$$HEX1$$e100$$ENDHEX$$n remesados la remesa podria que dar vacia
// Si no hay cobros sin pagar, salimos directamente
if not b_sin_pagar then 
	// Si ya est$$HEX1$$e100$$ENDHEX$$n todos marcados como pagados la unica utilidad que podemos ofrecer es cambiarles la forma de pago, fecha y banco si no est$$HEX1$$e100$$ENDHEX$$n ya pagados
	// FALTA POR DESARROLLAR
	if Messagebox(g_titulo, "Todos los cobros seleccionados ya est$$HEX1$$e100$$ENDHEX$$n cobrados. " + cr + "$$HEX1$$bf00$$ENDHEX$$Desea cambiar forma de pago, fecha de pago y banco de todos ellos?"+cr+"Si responde afirmativamente todos los cobros quedar$$HEX1$$e100$$ENDHEX$$n marcados automaticamente despagados y podr$$HEX2$$e1002000$$ENDHEX$$cobrarse nuevamente", question!, yesno!, 2)=2 then
		return
	else
		importe_pagar  = 0
		FOR fila = 1 TO dw_lista.RowCount()
			if dw_lista.GetItemString(fila, 'contabilizado') = 'N' then
				dw_lista.SetItem(fila, 'pagado', 'N') 
				importe_pagar += dw_lista.GetItemNumber(fila, 'importe')
			end if
		NEXT
	end if
else
	if Messagebox(g_titulo, "Est$$HEX2$$e1002000$$ENDHEX$$a punto de cobrar toda una serie de cobros de factura. " + cr + "$$HEX1$$bf00$$ENDHEX$$Desea continuar igualmente?", question!, yesno!,2)=2 then return
end if
*/

// Colocamos los datos para la otra ventana
st_cobros.ventana=this.classname()
st_cobros.importe_total=importe_pagar
st_cobros.dw_lista = dw_lista
st_cobros.contabilizar = 'N'
st_cobros.forma_pago = ''
st_cobros.retorno = ''

// Simplemente abrimos la ventana que pedir$$HEX2$$e1002000$$ENDHEX$$cosas. Como estamos 
openwithparm(w_cobros_cobrar_cobros, st_cobros)

st_cobros = message.powerobjectparm
if st_cobros.retorno = '-1' then 
	this.trigger event csd_actualiza_listas()
	return // Han salido cancelando
end if
if long(st_cobros.retorno) < 0 then 
	this.trigger event csd_actualiza_listas()
	return // Algun error producido, volvemos a refrescar la ventana de cobros con la consulta pedida
end if
if st_cobros.retorno = 'csd_actualiza_listas' then 
	this.trigger event csd_actualiza_listas()
	return // Han cancelado la domiciliacion bancaria, volvemos a retrivear los cambios
end if
if st_cobros.retorno = '1'then
	if st_cobros.contabilizar = 'N' then return // No quieren contabilizar ahora
	if st_cobros.contabilizar = 'S' then this.trigger event csd_contabilizar()
end if

end event

event csd_cobros_vencimiento;//Llamamos a la ventana de listados
open(w_cobros_vencimiento)
end event

public function boolean wf_comprobar_si_cambiar_asiento (string modo_contabilizacion, string n_remesa, string n_remesa_old, string id_fase, string id_minuta, string id_fase_old, string id_minuta_old);// CReada por ricardo 2005-03-07
// funcion encargada de averiguar cuando toca cambiar de asiento contable!
// FALLA EN EL SIGUIENTE CASO:> cuando se pasa de no remesa a remesa, con el modo 'R' y con asientos en diferentes diarios



boolean anterior_ot, actual_ot

// En el modo de 2 apuntes por cobro, no influyen las remesas!
if modo_contabilizacion = 'N' then 
	n_remesa = ''
	n_remesa_old = ''
end if


// Si lleva numero de remesa y estamos en el modo que cada vez que cambie de remesa se cambia de numero, decimos que hay que cambiar
if not f_es_vacio(n_remesa) then 
	if n_remesa_old = n_remesa then return false
	if (modo_contabilizacion = 'A')  and n_remesa_old <> n_remesa then
		return true
	end if
	// Falta por definir este caso... Cuando se pase de una sin remesa a una con remesa!
	anterior_ot = (f_es_vacio(id_fase_old) and f_es_vacio(id_minuta_old))
	if anterior_ot then
		if g_sica_diario.facts_emitidas_ot <> g_sica_diario.remesas then
			return true
		else
			return false
		end if
	else
		if g_sica_diario.facts_emitidas_exp <> g_sica_diario.remesas then
			return true
		else
			return false
		end if
	end if
else
	// No hay numero de remesa, luego, solo si hay asientos diferentes toca cambiar de asiento
	if g_sica_diario.facts_emitidas_ot <> g_sica_diario.facts_emitidas_exp then
		anterior_ot = (f_es_vacio(id_fase_old) and f_es_vacio(id_minuta_old))
		actual_ot = (f_es_vacio(id_fase) and f_es_vacio(id_minuta))
		
		if anterior_ot<>actual_ot then 
			// PAsamos de una de expediente a una que no o viceversa
			return true 
		else 
			// SE mantiene donde estaba por lo que no se cambia
			return false
		end if
	else
		// Si es el mismo diario, no hace falta cambiar de asiento
		return false
	end if
end if


		
return true
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
f_apunte_dw(g_apunte,dw_apuntes,'E')


end subroutine

on w_cobros_domicilia_lista.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_cobros_lista" then this.MenuID = create m_cobros_lista
this.cb_f19=create cb_f19
this.cb_fichero=create cb_fichero
this.st_aviso=create st_aviso
this.cb_marcar=create cb_marcar
this.rb_col=create rb_col
this.rb_ape=create rb_ape
this.dw_modo_cont=create dw_modo_cont
this.gb_orden=create gb_orden
this.cb_ocultar_apuntes=create cb_ocultar_apuntes
this.cb_actualizar_apuntes=create cb_actualizar_apuntes
this.dw_apuntes=create dw_apuntes
this.cb_imprimir_apuntes=create cb_imprimir_apuntes
this.cb_desmarcar=create cb_desmarcar
this.dw_historico=create dw_historico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_f19
this.Control[iCurrent+2]=this.cb_fichero
this.Control[iCurrent+3]=this.st_aviso
this.Control[iCurrent+4]=this.cb_marcar
this.Control[iCurrent+5]=this.rb_col
this.Control[iCurrent+6]=this.rb_ape
this.Control[iCurrent+7]=this.dw_modo_cont
this.Control[iCurrent+8]=this.gb_orden
this.Control[iCurrent+9]=this.cb_ocultar_apuntes
this.Control[iCurrent+10]=this.cb_actualizar_apuntes
this.Control[iCurrent+11]=this.dw_apuntes
this.Control[iCurrent+12]=this.cb_imprimir_apuntes
this.Control[iCurrent+13]=this.cb_desmarcar
this.Control[iCurrent+14]=this.dw_historico
end on

on w_cobros_domicilia_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_f19)
destroy(this.cb_fichero)
destroy(this.st_aviso)
destroy(this.cb_marcar)
destroy(this.rb_col)
destroy(this.rb_ape)
destroy(this.dw_modo_cont)
destroy(this.gb_orden)
destroy(this.cb_ocultar_apuntes)
destroy(this.cb_actualizar_apuntes)
destroy(this.dw_apuntes)
destroy(this.cb_imprimir_apuntes)
destroy(this.cb_desmarcar)
destroy(this.dw_historico)
end on

event activate;g_dw_lista  = dw_lista
g_w_lista   = g_lista_cobros
g_lista     = 'w_cobros_domicilia_lista'


end event

event pfc_postopen();call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_cobros = dw_lista

//Recuperamos la consulta de Inicio en caso de que exista
This.post Event csd_recuperar_consulta('INICIO')

end event

event csd_consulta();call super::csd_consulta;//Abrimos la ventana de consulta
g_consulta_actual = i_sentencia_sql_lista // Es la mejor forma de pasar la consulta antigua
open(w_cobros_domicilia_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()



end event

event open;call super::open;inv_resize.of_Register (cb_f19, "FixedtoBottom")
inv_resize.of_Register (cb_fichero, "FixedtoBottom")
inv_resize.of_Register (st_aviso, "FixedtoBottom")
inv_resize.of_Register (gb_orden, "FixedtoBottom")
inv_resize.of_Register (rb_col, "FixedtoBottom")
inv_resize.of_Register (rb_ape, "FixedtoBottom")
inv_resize.of_Register (dw_modo_cont, "FixedtoBottom")
inv_resize.of_Register (cb_actualizar_apuntes, "FixedtoBottom")
inv_resize.of_Register (cb_ocultar_apuntes, "FixedtoBottom")
inv_resize.of_Register (cb_imprimir_apuntes, "FixedtoBottom")
inv_resize.of_Register (dw_apuntes, "ScaletoRight&Bottom")
inv_resize.of_Register (cb_marcar, "FixedtoBottom")
inv_resize.of_Register (cb_desmarcar, "FixedtoBottom")
end event

event csd_listados;call super::csd_listados;//Llamamos a la ventana de listados
open(w_cobros_listados)
end event

event pfc_preupdate;call super::pfc_preupdate;if f_puedo_escribir(g_usuario,'0000000029')=-1 then return -1

if ib_pendiente_guardar_contabilizacion then
	Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.espera_descartar_apuntes', "Se est$$HEX2$$e1002000$$ENDHEX$$a la espera de la actualizaci$$HEX1$$f300$$ENDHEX$$n de apuntes. Para descartar los apuntes y poder hacer cambios debe refrescar la lista previamente"), stopsign!)
	return -1
end if


// MODIFICADO RICARDO 04-04-06
long fila, fila2
string mensaje = ''
// PAra el marcado de las facturas
string id_factura
double importe_cobros
boolean b_sobreescribir_cabecera, b_mensaje_contabilizar = false

// No deberiamos dejar tocar un cobro ya contabilizado, por lo que se impedir$$HEX1$$e100$$ENDHEX$$n grabar si han modificado cobros contabilizados
FOR fila = 1 TO dw_lista.RowCount()
	if dw_lista.getitemstatus(fila, 'f_pago', primary!) = datamodified! or &
		dw_lista.getitemstatus(fila, 'pagado', primary!) = datamodified! then
		if dw_lista.GetItemString(fila, 'contabilizado') = 'S' and not b_mensaje_contabilizar then
			// Colocamos esto en el mensaje y salimos
			mensaje += g_idioma.of_getmsg('msg_cobros.posible_modificar_cobros', "No es posible modificar cobros ya contabilizados")+cr
			b_mensaje_contabilizar = true
		end if
		// MODIFICADO RICARDO 04-05-20
		if dw_lista.GetItemString(fila, 'pagado') = 'N' and dw_lista.GetItemString(fila, 'tipo_factura') = g_colegiado_cliente then
			mensaje+= g_idioma.of_getmsg('msg_cobros.cobros_honorarios_no_pagados',"Los cobros de facturas de honorarios no pueden marcarse como no pagados (fila ")+string(fila)+" ) "+cr
		end if
		// FIN MODIFICADO RICARDO 04-05-20
		if dw_lista.GetItemString(fila, 'pagado') = 'S' then
			// Si la fecha de pago es vacia no dejamos continuar
			if isnull(dw_lista.GetItemDateTime(fila, 'f_pago')) then mensaje += g_idioma.of_getmsg('msg_cobros.fecha_cobro',"Debe indicar la fecha en la que se ha pagado el cobro (fila ")+string(fila)+" ) "+cr
		end if
	end if
NEXT

if g_colegio = 'COAATLR' then
	if not f_es_vacio(mensaje) then 
		messagebox(g_titulo, mensaje, stopsign!)
		return -1
	end if
end if

// Si modifican el pagado o bien el importe debemos mirar si eso suma lo suficiente para cubrir la cabecera de la factura
datastore ds_facturacion_emitida_detalle

ds_facturacion_emitida_detalle = create datastore
ds_facturacion_emitida_detalle.dataobject = 'ds_facturas_emitidas'
ds_facturacion_emitida_detalle.settransobject (SQLCA)


// FUNCIONA INCORRECTAMENTE SI SE MODIFICAN VARIOS COBROS DE LA MISMA FACTURA A LA VEZ
// Ahora es cuando deberiamos mirar las cabeceras de las facturas correspondientes
dw_lista.setredraw(false)
FOR fila = 1 TO dw_lista.RowCount()
	if dw_lista.GetitemString(fila, 'pagado') <> dw_lista.GetitemString(fila, 'pagado', primary!, true) then
		id_factura = dw_lista.GetItemString(fila, 'id_factura')
		if ds_facturacion_emitida_detalle.retrieve(id_factura) = 1 then
			if ds_facturacion_emitida_detalle.GetItemString(1, 'pagado') = 'N' then
				// Cogemos la suma de los importes de los cobros de esa factura
				select sum(importe) into :importe_cobros from csi_cobros where id_factura = :id_factura and pagado = 'S';
				if isnull(importe_cobros) then importe_cobros = 0
				// Comprobamos todos los dem$$HEX1$$e100$$ENDHEX$$s cobros por si son tambien de esta factura, incrementando o decrementando esa cantidad seg$$HEX1$$fa00$$ENDHEX$$n corresponda
				FOR fila2 = 1 TO dw_lista.RowCount()
					if dw_lista.GetitemString(fila2, 'id_factura') = id_factura then
						if dw_lista.GetitemString(fila2, 'pagado') <> dw_lista.GetitemString(fila2, 'pagado', primary!, true) then
							// Recorremos la ventana para ver si hay otros cobros de esta factura modificados
							if dw_lista.GetitemString(fila2, 'pagado') = 'S' then
								// Le incrementamos lo de este cobro concreto que todavia no se ha pagado todavia
								importe_cobros += dw_lista.GetItemNumber(fila2, 'importe')
							else
								// Le decrementamos lo de este cobro concreto que todavia no se ha pagado todavia
								importe_cobros -= dw_lista.GetItemNumber(fila2, 'importe')
							end if
						end if
					end if
				NEXT
				
				// Miramos si se parece al total de la factura
				if abs(ds_facturacion_emitida_detalle.GetItemNumber(1, 'total') - importe_cobros)<0.5 then
					// Marcaremos la factura como pagada y grabaremos
					ds_facturacion_emitida_detalle.SetItem(1, 'pagado', 'S')
					ds_facturacion_emitida_detalle.SetItem(1, 'f_pago', dw_lista.GetItemDateTime(fila, 'f_pago'))
				end if
			end if
			// En el caso que hayan pedido actualizar los datos de la cabecera cambiaremos la forma de pago y el banco si no est$$HEX2$$e1002000$$ENDHEX$$contabilizada
			if ds_facturacion_emitida_detalle.GetItemString(1, 'contabilizada') = 'N' then
				if isnull(b_sobreescribir_cabecera) then b_sobreescribir_cabecera = (Messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.actualizar_f_pago_banco',"$$HEX1$$bf00$$ENDHEX$$Desea actualizar la forma de pago y el banco en las cabeceras de las facturas con la del cobro correspondiente si no est$$HEX1$$e100$$ENDHEX$$n contabilizadas?"), question!, yesno!, 2)=1)
				if f_es_vacio(ds_facturacion_emitida_detalle.GetItemString(1, 'formadepago')) or b_sobreescribir_cabecera then ds_facturacion_emitida_detalle.SetItem(1, 'formadepago', dw_lista.GetItemString(fila, 'forma_pago'))
				if f_es_vacio(ds_facturacion_emitida_detalle.GetItemString(1, 'banco')) or b_sobreescribir_cabecera then ds_facturacion_emitida_detalle.SetItem(1, 'banco', dw_lista.GetItemString(fila, 'banco'))
			end if			
			if ds_facturacion_emitida_detalle.update()<>1 then
				Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.error_actualizar_cobros_pagos', "Se ha producido un error cuando se intentaban actualizar las facturas de los cobros indicados"), exclamation!)
				return -1
			end if
		end if
	end if
NEXT
dw_lista.setredraw(true)
destroy ds_facturacion_emitida_detalle
// MODIFICADO RICARDO 04-04-06



return AncestorReturnValue

end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_cobros_domicilia_lista
string tag = "texto=general.recuperar_pantalla"
integer y = 1700
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_cobros_domicilia_lista
string tag = "texto=general.guardar_pantalla"
integer y = 1580
end type

type st_1 from w_lista`st_1 within w_cobros_domicilia_lista
integer x = 37
integer y = 1444
end type

type dw_lista from w_lista`dw_lista within w_cobros_domicilia_lista
integer x = 41
integer y = 32
integer width = 3739
integer height = 1348
string dataobject = "d_cobros_domicilia_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_lista::retrieveend;call super::retrieveend;//  MODIFICADO RICARDO 04-0504

// ESTE CODIGO ESTABA PUESTO EN EL CSD_CONSULTA LO CUAL HACIA QUE EN CUANTO LE DIESES AL ACTUALIZAR LA VENTANA 
// DESAPARECIESEN LOS DOS VALORES

int i
//string id_fact
// Paco 23/05/2007
// Este proceso era lent$$HEX1$$ed00$$ENDHEX$$simo
//for i=1 to dw_lista.rowcount()
//	id_fact = dw_lista.getitemstring(i, 'id_factura')
//	
//	dw_lista.setitem(i, 'n_reg', f_numero_registro_de_factura_emitida(id_fact))
//	dw_lista.setitemstatus(i, 'n_reg', primary!, notmodified!)
//	dw_lista.setitem(i, 'n_exp', f_numero_expedi_de_factura_emitida(id_fact))
//	dw_lista.setitemstatus(i, 'n_exp', primary!, notmodified!)
//	dw_lista.setitem(i, 'n_salida', f_numero_salida_de_factura_emitida(id_fact))
//	dw_lista.setitemstatus(i, 'n_salida', primary!, notmodified!)
//	dw_lista.setitemstatus(i, 0, primary!, notmodified!)
//next

for i=1 to dw_lista.rowcount()
	dw_lista.setitem(i, 'activo', 'S')
	dw_lista.setitemstatus(i, 'activo', Primary!, NotModified!)
next


// Ricardo 04-05-05
dw_apuntes.reset()
dw_apuntes.visible = false
cb_actualizar_apuntes.visible = false
cb_ocultar_apuntes.visible = false
cb_imprimir_apuntes.visible = false
// FIN Ricardo 04-05-05
ib_pendiente_guardar_contabilizacion = false
//  FIN MODIFICADO RICARDO 04-0504

end event

event dw_lista::itemchanged;call super::itemchanged;
if ib_pendiente_guardar_contabilizacion then
	post Messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.espera_actualiz_apuntes_previo',"Se est$$HEX2$$e1002000$$ENDHEX$$a la espera de la actualizaci$$HEX1$$f300$$ENDHEX$$n de apuntes. Para descartar los apuntes y poder hacer cambios debe refrescar la lista previamente"), stopsign!)
	return 2
end if


CHOOSE CASE dwo.name
	CASE 'pagado'
		if data = 'S' then
			// Colocamos la fecha de pagado a dia de hoy
			this.setitem(row, 'f_pago', datetime(today(), time("00:00")))
		end if
	case 'activo'
		this.post setitemstatus(row, 'activo', Primary!, NotModified!)		
	
END CHOOSE





/***********   HISTORICO DE DATOS *******************/


// Actualiza los datos modificados en la tabla "modificaciones"
// ------------------------------------------------------------
string  colegiado, modificacion, tipo,campo,id_colegiado,nombre_dw,anterior
integer fila
dw_historico.settransobject(SQLCA)
campo = dwo.name
// Se devuelve un valor campo de la DW segun sea el tipo de dato
tipo=dw_lista.Describe(campo+".ColType")
if tipo='!' then return // Define un tipo constanste

anterior=''
CHOOSE CASE upper(LeftA(tipo ,2))
	CASE 'CH' // Tipo 'String'
		anterior=dw_lista.getitemstring(row,campo)
	CASE 'DA' // Tipo 'DateTime'
		anterior=string(dw_lista.getitemdatetime(row,campo),'dd/mm/yyyy')
	CASE ELSE // queda 'Number'
      anterior=string(dw_lista.getitemnumber(row,campo))
END CHOOSE

if f_es_vacio(anterior) then anterior=''   // return

//se a$$HEX1$$f100$$ENDHEX$$ade un registro a modificaci$$HEX1$$f300$$ENDHEX$$n de datos

	dw_historico.triggerevent("pfc_addrow")


fila        =dw_historico.rowcount()


 modificacion = data

colegiado = dw_lista.getitemstring(dw_lista.getrow(),'id_factura') + "05"

// se concatenan las modificaciones con la anterior
if isnull(modificacion) then modificacion =anterior
  nombre_dw = 'COBROS'
//if  LeftA(nombre_dw,6) = 'COBROS' then 
	modificacion = modificacion + ' ' + nombre_dw + ' ' + campo + '=' + anterior + '; '
/*else
	modificacion = modificacion + nombre_dw + ' ' + campo + '=' + data + '; '
end if*/

// Se actualiza la dw de modificaciones oculta
dw_historico.setitem(fila,'id_colegiado',colegiado)
dw_historico.setitem(fila,'modificacion',modificacion)
dw_historico.setitem(fila,'fecha',datetime(today(),now()))
dw_historico.setitem(fila,'usuario',g_usuario)


  dw_historico.update()


g_recien_grabado_modificacion=FALSE


/******* FIN HISTORICO *************/
end event

event dw_lista::doubleclicked;call super::doubleclicked;if row < 1 then return
//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
g_facturacion_emitida_consulta.id_factura = dw_lista.getitemstring(row,'id_factura')
message.stringparm = "w_facturacion_emitida_detalle"
w_aplic_frame.postevent("csd_facturacion_emitida_detalle")


end event

event dw_lista::clicked;call super::clicked;int i
string ls_marcar
choose case dwo.name
	case 'check_paga'
			ls_marcar = this.getitemstring(1,'check_paga')
			if ls_marcar = 'S' then
				ls_marcar = 'N'
			else
				ls_marcar = 'S'
			end if
			this.setitem(1, 'check_paga',ls_marcar)
			for i = 1 to dw_lista.rowcount()
				dw_lista.setitem(i, 'pagado', ls_marcar)
			next
end choose
end event

type cb_consulta from w_lista`cb_consulta within w_cobros_domicilia_lista
string tag = "texto=cobros.consultar"
integer x = 3835
integer y = 712
end type

type cb_detalle from w_lista`cb_detalle within w_cobros_domicilia_lista
string tag = "texto=cobros.detalle"
integer x = 3881
integer y = 500
end type

type cb_ayuda from w_lista`cb_ayuda within w_cobros_domicilia_lista
string tag = "texto=cobros.ayuda"
integer x = 3881
integer y = 636
end type

type cb_f19 from commandbutton within w_cobros_domicilia_lista
string tag = "texto=cobros.generar_domic_fichero_banco"
boolean visible = false
integer x = 3886
integer y = 548
integer width = 1010
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generar Domiciliaciones y Fichero del Banco"
end type

event clicked;// MODIFICADO RICARDO 04-05-14
long res, fila
double importe_cobros
string id_factura
datastore ds_facturacion_emitida_detalle
st_cobros_datos_pre_remesa datos

// Si no hay cobros en pantalla salimos 
if dw_lista.rowcount()<1 then return
// hacemos el aceptext y el grabado
dw_lista.trigger event pfc_accepttext(true)
// Intentamos grabar los cambios
if dw_lista.trigger event pfc_updatespending() >0 then
	if messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.grabar_antes',"Antes de realizar este proceso deben grabarse todos los cambios realizados. ")+cr+g_idioma.of_getmsg('msg_cobros.actualizar_ahora',"$$HEX1$$bf00$$ENDHEX$$Actualizar ahora?"), question!, yesno!, 2) = 2 then return
	res = parent.trigger event pfc_save()
	if res < 0 then return // Ha fallado el grabado
end if
// FIN MODIFICADO RICARDO 04-05-14

// Filtramos para que s$$HEX1$$f300$$ENDHEX$$lo se domicilien los cobros marcados
dw_lista.setredraw(false)
string orden
orden = dw_lista.Describe ("DataWindow.Table.Sort")
dw_lista.setfilter("activo='S'")
dw_lista.filter()

datos.dw_lista = dw_lista
datos.modulo='COBROS'
OpenWithParm(w_cobros_pre_remesa,datos)

dw_lista.setfilter("")
dw_lista.filter()
dw_lista.setsort(orden)
dw_lista.sort()
dw_lista.setredraw(true)

// MODIFICADO RICARDO 04-05-14
// En el caso que se haya salido de la ventana de remesas habiendo actualizado datos, hay que conseguir que se queden las cabeceras
// De las facturas marcadas como pagado
if message.stringparm = '-1' then return

if dw_lista.update()<>1 then 
	Messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.error_actualizar_cobros_revisar',"Se ha producido un error cuando se intentaba actualizar los cobros. Revise cada uno de ellos"), exclamation!)
	return
end if

ds_facturacion_emitida_detalle = create datastore
ds_facturacion_emitida_detalle.dataobject = 'd_facturacion_emitida_detalle'
ds_facturacion_emitida_detalle.settransobject(SQLCA)

// Ahora es cuando deberiamos mirar las cabeceras de las facturas correspondientes
FOR fila = 1 TO dw_lista.RowCount()
	if dw_lista.GetItemString(fila, 'modificado') =  'S' then
		id_factura = dw_lista.GetItemString(fila, 'id_factura')
		if ds_facturacion_emitida_detalle.retrieve(id_factura) = 1 then
			if ds_facturacion_emitida_detalle.GetItemString(1, 'pagado') = 'N' then
				// Cogemos la suma de los importes de los cobros de esa factura
				select sum(importe) into :importe_cobros from csi_cobros where id_factura = :id_factura and pagado = 'S';
				if isnull(importe_cobros) then importe_cobros = 0
				// Miramos si se parece al total de la factura
				if abs(ds_facturacion_emitida_detalle.GetItemNumber(1, 'total') - importe_cobros)<0.5 then
					// Marcaremos la factura como pagada y grabaremos
					ds_facturacion_emitida_detalle.SetItem(1, 'pagado', 'S')
					ds_facturacion_emitida_detalle.SetItem(1, 'f_pago', dw_lista.GetItemDateTime(fila, 'f_pago'))
				end if
			end if
			// En el caso que hayan pedido actualizar los datos de la cabecera cambiaremos la forma de pago y el banco si no est$$HEX2$$e1002000$$ENDHEX$$contabilizada
			if ds_facturacion_emitida_detalle.GetItemString(1, 'contabilizada') = 'N' then
				ds_facturacion_emitida_detalle.SetItem(1, 'formadepago', dw_lista.GetItemString(fila, 'forma_pago'))
				ds_facturacion_emitida_detalle.SetItem(1, 'banco', dw_lista.GetItemString(fila, 'banco'))
			end if			
			if ds_facturacion_emitida_detalle.update()<>1 then
				Messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.error_actualizar_facturas_revisar',"Se ha producido un error cuando se intentaba actualizar las facturas de los cobros indicados"), exclamation!)
				exit
			end if
		end if
	end if
NEXT
destroy ds_facturacion_emitida_detalle
// FIN MODIFICADO RICARDO 04-05-14

end event

type cb_fichero from commandbutton within w_cobros_domicilia_lista
string tag = "texto=cobros.generar_fichero_domic_pendientes"
boolean visible = false
integer x = 3886
integer y = 664
integer width = 1038
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Generar fichero de domiciliaciones pendientes"
end type

event clicked;//st_aviso.text='Generando fichero F19'
//i_datos_remesa.orden_listado = i_orden_listado
//f_apuntes_genera_fichero19(i_datos_remesa)
//st_aviso.Text='Proceso Finalizado'
//st_aviso.text=''
end event

type st_aviso from statictext within w_cobros_domicilia_lista
boolean visible = false
integer x = 1445
integer y = 1704
integer width = 1417
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_marcar from commandbutton within w_cobros_domicilia_lista
string tag = "texto=cobros.marcar_todos"
integer x = 457
integer y = 1428
integer width = 320
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Marcar todos"
end type

event clicked;int i

for i = 1 to dw_lista.rowcount()
	//dw_lista.setitem(i, 'pagado', 'S') modificado
	dw_lista.setitem(i, 'activo', 'S')
next
end event

type rb_col from radiobutton within w_cobros_domicilia_lista
string tag = "texto=cobros.numero_col."
boolean visible = false
integer x = 526
integer y = 1764
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX1$$fa00$$ENDHEX$$mero col."
boolean checked = true
end type

event clicked;i_orden_listado = 'NUMERO'
end event

type rb_ape from radiobutton within w_cobros_domicilia_lista
string tag = "texto=cobros.apellidos_nombre"
boolean visible = false
integer x = 969
integer y = 1764
integer width = 498
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Apellidos, nombre"
end type

event clicked;i_orden_listado = 'APELLIDOS'
end event

type dw_modo_cont from u_dw within w_cobros_domicilia_lista
integer x = 1216
integer y = 1444
integer width = 1563
integer height = 80
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_cobros_modo_contabilizacion"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;// Metemos una linea para que se pueda elegir como se quiere trabajar
this.insertrow(0)
end event

type gb_orden from groupbox within w_cobros_domicilia_lista
string tag = "texto=cobros.orden_listado_salida"
boolean visible = false
integer x = 462
integer y = 1712
integer width = 1106
integer height = 128
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Orden Listado Salida"
end type

type cb_ocultar_apuntes from commandbutton within w_cobros_domicilia_lista
string tag = "texto=cobros.ocultar_ap"
integer x = 3442
integer y = 1428
integer width = 334
integer height = 88
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Ocultar Ap."
end type

event constructor;this.visible = false
end event

event clicked;if dw_apuntes.visible then
	dw_apuntes.visible = false
	cb_ocultar_apuntes.text = '&Mostrar Ap.'
else
	dw_apuntes.visible = true
	cb_ocultar_apuntes.text = '&Ocultar Ap.'
end if
end event

type cb_actualizar_apuntes from commandbutton within w_cobros_domicilia_lista
string tag = "texto=cobros.actualizar_ap"
integer x = 3109
integer y = 1428
integer width = 334
integer height = 88
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Actualizar Ap."
end type

event constructor;this.visible = false
end event

event clicked;// Yexa 30/01/09
// Se realiza el cambio para que se compruebe que todo este correcto y se confirme la numeraci$$HEX1$$f300$$ENDHEX$$n de los asientos
// Simplemente grabamos los distintos datawindows, haciendolos atomicos el grabado
long asiento_exp, asiento_ot, asiento_rem, asiento_cobros_mult
long fila
string n_asiento, n_asiento_old, n_asiento_renumerado, diario, diario_old

// Cogemos los numeros de asientos correspondientes, pq vamos a renumerar todos los asientos generados
boolean b_error = false, b_autocomit_SQLCA, b_autocomit_bd_ejercicio

// Quitamos los autocomit
b_autocomit_SQLCA = SQLCA.autocommit
b_autocomit_bd_ejercicio = bd_ejercicio.autocommit
SQLCA.autocommit = false
bd_ejercicio.autocommit = false
// Iniciamos una transaccion, para hacer el proceso atomico
Execute Immediate "BEGIN tran" using SQLCA;
EXECUTE IMMEDIATE "BEGIN tran" USING bd_ejercicio;

// MODIFICADO RICARDO 2005-07-27
// PARA LA RENUMERACI$$HEX1$$d300$$ENDHEX$$N DE ASIENTOS CONTABLES
n_asiento = "-1"
diario = "-1"
n_asiento_old = ''
diario_old = ''
FOR fila = 1 to dw_apuntes.RowCount()
	diario = dw_apuntes.getitemstring(fila, 'diario')
	n_asiento = dw_apuntes.getitemstring(fila, 'n_asiento')
	// Si cambia de asiento/diario, renumeramos de nuevo
	if n_asiento <> n_asiento_old or diario<>diario_old then
		n_asiento_renumerado = f_siguiente_numero_bd_ejercicio(diario,7) // ESto asegura que los numeros de asiento se hagan bien
	end if
	// Cambiamos el asiento segun
	dw_apuntes.SetItem(fila, 'n_asiento', n_asiento_renumerado)
	
	// Mantenemos los datos de la iteracion anterior
	n_asiento_old = n_asiento
	diario_old = diario
NEXT
dw_apuntes.groupcalc()

if dw_apuntes.Update()<>1 then b_error = true


if not b_error then
	// Confirmamos los cambios
	Execute Immediate "COMMIT Transaction" using SQLCA;
	Execute Immediate "COMMIT Transaction" using bd_ejercicio;
	commit USING SQLCA; 
	commit USING bd_ejercicio;

else
	// Desacemos los cambios realizados
	Execute Immediate "ROLLBACK Transaction" using SQLCA;
	Execute Immediate "ROLLBACK Transaction" using bd_ejercicio;
	EXECUTE IMMEDIATE "rollback" USING SQLCA;
	EXECUTE IMMEDIATE "rollback" USING bd_ejercicio;
	rollback USING SQLCA; 
	rollback USING bd_ejercicio;
	//messagebox(g_titulo, "Se ha producido un error al intentar actualizar facturas y grabar los apuntes generados"+cr+"Avise al departamento de inform$$HEX1$$e100$$ENDHEX$$tica", stopsign!)
		Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.error_guardar_apuntes', "Se ha producido un error al intentar guardar los apuntes"), stopsign!)
	return
end if
// Cerramos la transaccion
EXECUTE IMMEDIATE "END tran" USING SQLCA;
EXECUTE IMMEDIATE "END tran" USING bd_ejercicio;
// restauramos los autocomit
SQLCA.autocommit = b_autocomit_SQLCA
bd_ejercicio.autocommit = b_autocomit_bd_ejercicio





//if dw_apuntes.update()<0 then
//	Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.error_guardar_apuntes', "Se ha producido un error al intentar guardar los apuntes"), stopsign!)
//	return
//end if
if dw_lista.update()<0 then
	Messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.error_guardar_cobros',"Se ha producido un error al intentar guardar los cobros"), stopsign!)
	return
end if
ib_pendiente_guardar_contabilizacion = false

//// Actualizamos el numero del ejercicio si lo de antes ha ido correctamente
//f_actualiza_numero_bd_ejercicio(g_sica_diario.facts_emitidas_exp, i_asiento_exp)
//f_actualiza_numero_bd_ejercicio(g_sica_diario.facts_emitidas_ot, i_asiento_ot)
//f_actualiza_numero_bd_ejercicio(g_sica_diario.remesas, i_asiento_rem)
//ib_pendiente_guardar_contabilizacion = false

end event

type dw_apuntes from u_dw within w_cobros_domicilia_lista
integer x = 37
integer y = 32
integer width = 3739
integer height = 1340
integer taborder = 90
string dataobject = "d_apuntes_automaticos"
end type

event constructor;call super::constructor;SetTransObject(bd_ejercicio)
this.visible = false
end event

type cb_imprimir_apuntes from commandbutton within w_cobros_domicilia_lista
string tag = "texto=cobros.imprimir_ap"
integer x = 2770
integer y = 1428
integer width = 334
integer height = 88
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir Ap."
end type

event clicked;if dw_apuntes.rowCount()>0 then
	dw_apuntes.print()
end if
end event

event constructor;this.visible = false
end event

type cb_desmarcar from commandbutton within w_cobros_domicilia_lista
string tag = "texto=cobros.desmarcar_todos"
integer x = 777
integer y = 1428
integer width = 411
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Desmarcar todos"
end type

event clicked;int i

for i = 1 to dw_lista.rowcount()
	//dw_lista.setitem(i, 'pagado', 'N')
	dw_lista.setitem(i, 'activo', 'N')
next
end event

type dw_historico from pfc_u_dw within w_cobros_domicilia_lista
boolean visible = false
integer x = 2597
integer y = 1088
integer width = 256
integer height = 128
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_historico"
end type

event pfc_addrow;call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.rowcount(), 'id_modificacion', f_siguiente_numero('MODIFICACIONES', 10))
this.setitem(this.rowcount(), 'id_colegiado', dw_lista.GetItemString(1,'id_factura') )
this.setitem(this.rowcount(), 'tipo_modulo', '05')
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

