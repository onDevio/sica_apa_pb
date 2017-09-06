HA$PBExportHeader$w_proconta_facturas_contabiliza.srw
forward
global type w_proconta_facturas_contabiliza from w_sheet
end type
type cb_apuntes from commandbutton within w_proconta_facturas_contabiliza
end type
type dw_modo_cont from u_dw within w_proconta_facturas_contabiliza
end type
type st_progreso from statictext within w_proconta_facturas_contabiliza
end type
type st_cuantas_facturas from statictext within w_proconta_facturas_contabiliza
end type
type tab_1 from tab within w_proconta_facturas_contabiliza
end type
type tabpage_4 from userobject within tab_1
end type
type dw_cobros_no_ejercicio from u_csd_dw within tabpage_4
end type
type dw_facturas from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_cobros_no_ejercicio dw_cobros_no_ejercicio
dw_facturas dw_facturas
end type
type tabpage_3 from userobject within tab_1
end type
type dw_cobros_multiple from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_cobros_multiple dw_cobros_multiple
end type
type tabpage_5 from userobject within tab_1
end type
type dw_cobros from u_dw within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_cobros dw_cobros
end type
type tabpage_1 from userobject within tab_1
end type
type dw_cobros_mult_facturas_contab from u_dw within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type dw_cobros_facturas_contabilizadas from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_cobros_mult_facturas_contab dw_cobros_mult_facturas_contab
st_2 st_2
st_1 st_1
dw_cobros_facturas_contabilizadas dw_cobros_facturas_contabilizadas
end type
type tabpage_apuntes from userobject within tab_1
end type
type dw_apuntes1 from u_dw within tabpage_apuntes
end type
type tabpage_apuntes from userobject within tab_1
dw_apuntes1 dw_apuntes1
end type
type tab_1 from tab within w_proconta_facturas_contabiliza
tabpage_4 tabpage_4
tabpage_3 tabpage_3
tabpage_5 tabpage_5
tabpage_1 tabpage_1
tabpage_apuntes tabpage_apuntes
end type
type dw_fechas from u_dw within w_proconta_facturas_contabiliza
end type
type cb_salir from commandbutton within w_proconta_facturas_contabiliza
end type
type cb_imprimir_ap from commandbutton within w_proconta_facturas_contabiliza
end type
type cb_actualizar from commandbutton within w_proconta_facturas_contabiliza
end type
type cb_buscar from commandbutton within w_proconta_facturas_contabiliza
end type
end forward

global type w_proconta_facturas_contabiliza from w_sheet
integer x = 0
integer y = 0
integer width = 4311
integer height = 2584
string title = "Contabilizaci$$HEX1$$f300$$ENDHEX$$n Facturas Pendientes"
string menuname = "m_proconta_facturas_contabiliza"
windowstate windowstate = maximized!
boolean clientedge = true
event csd_apuntes_cobros_multiple ( )
event csd_apuntes_facturas ( )
event csd_apuntes_fact_contabilizadas ( )
event csd_cobros_simples ( )
event csd_cobros_multiples ( )
event csd_cobros_multiples_fact_contabil ( )
cb_apuntes cb_apuntes
dw_modo_cont dw_modo_cont
st_progreso st_progreso
st_cuantas_facturas st_cuantas_facturas
tab_1 tab_1
dw_fechas dw_fechas
cb_salir cb_salir
cb_imprimir_ap cb_imprimir_ap
cb_actualizar cb_actualizar
cb_buscar cb_buscar
end type
global w_proconta_facturas_contabiliza w_proconta_facturas_contabiliza

type variables
u_dw idw_facturas, idw_cobros, idw_cobros_multiples, idw_cobros_facturas_contabilizadas, idw_cobros_mult_facturas_contab, idw_apuntes, idw_cobros_no_ejercicio

long i_asiento_exp, i_asiento_ot, i_asiento_cobros_mult, i_asiento_rem, i_asiento_general
long il_coord_x =0 , il_coord_y =0 ,il_tamanyo_x =0 , il_tamanyo_y =0 
double id_importe_resumido

boolean ib_comprobadas_variables = false
boolean ib_aglutinar_iva_conceptos, ib_resumida, ib_aglutinar_irpf, ib_dv_pdtes_abono, ib_concepto_solo_num_reg
boolean b_continuar, b_dv_pdtes_abono,  b_aglutinar_iva_conceptos

string is_nombre, is_concepto, is_concepto_base, is_concepto_numeracion,  is_cuenta_cp, is_cuenta_col, is_cuenta_ret,is_concepto_solo_num_reg
string is_concepto_garantia, is_concepto_cobro_a_cuenta, is_asunto, is_observaciones_fact
string id_fase, id_minuta, id_factura, id_col, is_tipo_factura, is_n_factura, is_orden_apunte

datetime	idt_fecha_fact

Datastore ids_lineas

///*** SCP-728. Se crea variable para el control de la generaci$$HEX1$$f300$$ENDHEX$$n de apuntes de garant$$HEX1$$ed00$$ENDHEX$$as. Alexis. 20/09/2011 ***///
string Instance_var_permitir_generar_apuntes_garantias
end variables

forward prototypes
public subroutine wf_preproceso ()
public function long wf_verificar_facturas ()
public subroutine wf_crear_apunte (datetime fecha, string cuenta, string concepto, double debe, double haber, string orden_apunte, string contrapartida)
public function boolean wf_comprobar_si_cambiar_asiento (string modo_contabilizacion, string n_remesa, string n_remesa_old, string id_fase, string id_minuta, string id_fase_old, string id_minuta_old)
public function string wf_hay_ingreso_formapago (string as_tipo_pago)
public function string wf_cuenta_contable_banco (string as_banco)
public function boolean wf_valida_campo_dw (datawindow dw_1, string as_campo)
public subroutine wf_apuntes_cobros_fact (string ls_concepto_obs_fact, datetime ldt_fecha, double ld_subtotal_fact)
public subroutine wf_genera_apuntes_linea_fact (string ls_tipo_factura, string n_col, datastore ds_iva, string ls_orden_apunte)
public subroutine wf_carga_variables_instancia ()
end prototypes

event csd_apuntes_cobros_multiple();//// 1.-  CM->  Facturas
string 		ls_hay_ingreso, ls_tipo_documento_cm, id_cobro_multiple, ls_formapago, ls_banco, ls_concepto, ls_cta_contable_banco
string			n_expedi, n_visado, ls_orden_apunte, id_cobro_multipl_ant, ls_pagador, ls_tipo_factura, ls_cuenta_col
string 		ls_nif, ls_nombre, cuenta_contable, ls_concepto_cobro, id_cobro_multiple_old
int				i, fila_cobro, ll_found, j, k, ll
double 		ld_total, importe_cobro, total_factura, ld_descuadre, ld_dif
datetime		ldt_fecha_pago
string id_factura_old 
u_dw			dw_temp 


id_cobro_multipl_ant = 'zz'

// Validamos de que existan datos que procesar
if idw_cobros_multiples.rowcount() <= 0 then return

	//Se obtiene el tipo de documento de cobros multiples
	ls_tipo_documento_cm = g_sica_t_doc.cobros_multiples
	// Se valida que el la tipo_documento_cm no este vacio
	if f_es_vacio(ls_tipo_documento_cm) then ls_tipo_documento_cm = 'CM'

	dw_temp = idw_cobros_multiples

	for i = 1 to idw_cobros_multiples.rowcount()
		k = g_conta.row
		id_factura = idw_cobros_multiples.getitemstring(i,'id_factura' )
		// Filtramos el dw de cobros para la factura concreta
		idw_cobros_multiples.setfilter("csi_facturas_emitidas.id_factura='"+id_factura+"'")
		idw_cobros_multiples.filter()

		if  i > 	idw_cobros_multiples.rowcount() then continue
		// Se obtienen los datos necesarios para generar los apuntes
		id_cobro_multiple 	= idw_cobros_multiples.getitemstring(i,'csi_cobros_multiples_id_cobro_multiple')
		ls_formapago 		= upper(idw_cobros_multiples.getitemstring(i, 'csi_cobros_multiples_forma_pago'))
		ld_total	 			= idw_cobros_multiples.getitemNumber(i, 'csi_cobros_multiples_importe')
		ls_banco  			= idw_cobros_multiples.getitemstring(i, 'csi_cobros_multiples_banco')
		ls_concepto 			= idw_cobros_multiples.getitemstring(i, 'lista_fact')
		ldt_fecha_pago 	= idw_cobros_multiples.GetitemDatetime(i, 'csi_cobros_multiples_fecha')
		ls_pagador			= idw_cobros_multiples.Getitemstring(i, 'csi_cobros_multiples_pagador')
	
		if id_cobro_multipl_ant = id_cobro_multiple then continue
		// Actualizamos la variable pa que vaya bien
		id_cobro_multipl_ant = id_cobro_multiple
		
		// Si verifica si el tipo de forma de pago tenga Ingreso 
		ls_hay_ingreso 				= wf_hay_ingreso_formapago(ls_formapago)
		ls_cta_contable_banco 	= wf_cuenta_contable_banco(ls_banco)

		/* SE RELLENA LA ESTRUCTURA DE APUNTES */
		g_apunte.n_apunte 		= '00000'
		g_apunte.n_doc			= id_cobro_multiple
		g_apunte.fecha				= datetime(date(ldt_fecha_pago), time("00:00:00"))
		g_apunte.t_asiento 		= g_t_asiento_apuntes_automaticos
		g_apunte.centro			= idw_cobros_multiples.GetItemString(i,'centro') // El tipo de documento deber$$HEX1$$ed00$$ENDHEX$$a ir vinculado a la serie y al concepto, tomando preferentemente este $$HEX1$$fa00$$ENDHEX$$ltimo.
		if f_es_vacio(g_apunte.centro) then g_apunte.centro = g_centro_por_defecto
		g_apunte.proyecto			= g_explotacion_por_defecto
		g_apunte.nombre 			= ls_pagador
		g_apunte.orden_apunte  = ls_orden_apunte
		g_apunte.diario 			= g_sica_diario.facts_emitidas_general
		g_apunte.n_asiento 		= RightA('0000000' + trim(string(i_asiento_general)),7)
		
		
		//SCP-427 Verificamos que la fecha del cobro pertenece al ejercicio actual
		if string(year(date(idw_cobros_multiples.GetItemDateTime(i, 'csi_cobros_multiples_fecha'))))<>g_ejercicio then 
			if g_conta_cobros_ejercicio_noactual = 'N' then continue //scp-2123
		end if
		
		// SE OBTIENE EL CONCEPTO
			ls_concepto_cobro = LeftA('Ing CC ' + ls_concepto,57)
			
			choose case ls_formapago
					case g_formas_pago.transferencia
								g_apunte.t_doc = g_sica_t_doc.transferencia
					case g_formas_pago.talon
								g_apunte.t_doc = g_sica_t_doc.talon
					case else
								g_apunte.t_doc = g_sica_t_doc.generico
			end choose
	
		if ls_hay_ingreso = 'S' then
		
			// Se busca la cuenta del colegiado pagador seg$$HEX1$$fa00$$ENDHEX$$n el tipo de factura generada
			
			if  is_tipo_factura = '04' then
				ls_cuenta_col = g_cobros_multiples_cuenta_puente
			end if

	
		
			if idw_cobros_multiples.getitemstring(i, 'csi_cobros_multiples_contabilizado') <> 'S' then
				//Apunte por el haber	
				wf_crear_apunte(ldt_fecha_pago, is_cuenta_col, ls_concepto_cobro, 0,  ld_total,is_orden_apunte, ls_cta_contable_banco)
				//apunte por el debe
				wf_crear_apunte(ldt_fecha_pago, ls_cta_contable_banco, "CC "+ls_concepto, ld_total, 0, is_orden_apunte, '')
				ld_dif = idw_cobros_multiples.getitemdecimal(i,'diferencia')
				if ld_dif<> 0 then
					g_apunte.n_doc = ''
					g_apunte.t_doc = g_t_doc_descuadre
						if  ld_dif > 0 then
								//apunte por el Haber
								wf_crear_apunte(ldt_fecha_pago,g_cuenta_puente_descuadre, g_concepto_descuadre_caja,  0 ,ld_dif,  is_orden_apunte, is_cuenta_col)
							else
								//apunte por el debe
								wf_crear_apunte(ldt_fecha_pago, g_cuenta_puente_descuadre,g_concepto_descuadre_caja, ld_dif, 0, is_orden_apunte,is_cuenta_col)
							end if
						end if
				
				int l
				boolean b_continue = true
				id_factura_old=id_factura
				idw_cobros_multiples.setredraw(false)
				idw_cobros_multiples.setfilter("")
				idw_cobros_multiples.filter()
				idw_cobros_multiples.setfilter("empresa = '"+g_empresa + "'")
				idw_cobros_multiples.filter()
				idw_cobros_multiples.setredraw(true)
				for j= 1 to dw_temp.rowcount()
					if  dw_temp.getitemstring(j,'csi_cobros_multiples_id_cobro_multiple') = id_cobro_multiple then 
						
						idw_cobros_multiples.SetItem(j, 'csi_cobros_multiples_f_contabilizado',ldt_fecha_pago)
						idw_cobros_multiples.SetItem(j, 'csi_cobros_multiples_contabilizado','S')
						
					
					end if
				next
		
			end if
	
				
		end if
		i_asiento_general++
		idw_cobros_multiples.setredraw(false)
		idw_cobros_multiples.setfilter("")
		idw_cobros_multiples.filter()
		idw_cobros_multiples.setfilter("empresa = '"+ g_empresa + "'")
		idw_cobros_multiples.filter()
		idw_cobros_multiples.setredraw(true)
	next




end event

event csd_apuntes_facturas();// GENERA LOS APUNTES DE LAS FACTURAS
string 	ls_formadepago,ls_banco,  ls_n_expedi, ls_nif,   ls_cliente
string 	ls_hay_ingreso, ls_cta_contable_banco,  ls_concepto_factura, ls_n_visado, ls_null, ls_n_registro
string 	ls_cuenta_iva, ls_concepto_iva, ls_concepto_tipo_factura, ls_concepto_obs_fact, ls_concepto_pend_abono
string		 t_iva , id_cobro_multiple, id_cobro_multiple_old, ls_tipo_actuacion, ls_cuenta_col_pa
int 		i, j, k, m, ll_found, il_asiento_temp
double	ld_total, ld_subtotal, ld_descuento, ld_base_imp, ld_importe_reten, ld_subtotal_iva

setnull(ls_null)

// DATASTORE PARA PROCESAR LAS LINEAS DE FACTURA (SOLO EN GASTOS)
ids_lineas = create datastore
ids_lineas.DataObject = 'd_conta_lineas_fact_emitidas'
ids_lineas.SetTransObject(SQLCA)

// DAtastore para almacenar los tipos de iva y el importe asociado a cada uno de ellos por factura
Datastore ds_iva
ds_iva = create datastore
ds_iva.DataObject = 'd_conta_d_contab_iva'
ds_iva.SetTransObject(SQLCA)
ds_iva.Retrieve()
id_cobro_multiple_old = '-1'
if idw_facturas.RowCount() > 0 then

for i = 1 to idw_facturas.RowCount()
//Le decimos por donde vamos
	st_progreso.text = 'Procesando ' + string(i) + ' de ' + string(idw_facturas.RowCount())+' facturas. '+string(idw_apuntes.RowCount())+' apuntes generados.'
	yield()
	
	//Preproceso necesario para el c$$HEX1$$e100$$ENDHEX$$lculo de IVA totalizado por tipo
		FOR k=1 TO ds_iva.RowCount()
			ds_iva.SetItem(k,'importe',0)
			ds_iva.SetItem(k,'base_imp',0)
		NEXT
	//Fin preproceso IVA/IGIC

	id_importe_resumido = 0

	//SE MARCAN COMO CONTABILIZADA LAS FACTURAS
	idw_facturas.SetItem(i,'contabilizada','S')
	idw_facturas.SetItem(i,'f_conta',idw_facturas.GetItemDatetime(i, 'fecha'))

	// DATOS COMUNES A FACTURAS DE HONORARIOS Y DE GASTOS:
	idt_fecha_fact		= idw_facturas.GetItemDatetime(i, 'fecha')
	is_tipo_factura 		= idw_facturas.GetItemString(i,'tipo_factura')
	ls_formadepago	= upper(idw_facturas.GetItemString(i,'formadepago'))
	ls_banco 			= idw_facturas.GetItemString(i,'banco')
	id_factura 			= idw_facturas.GetItemString(i,'id_factura')
	is_n_factura 		= idw_facturas.GetItemString(i,'n_fact')
	ls_n_expedi 		= idw_facturas.GetItemString(i,'expedientes_n_expedi')+'-'+idw_facturas.GetItemString(i,'fases_fase')
	id_fase 				= idw_facturas.GetItemString(i,'id_fase')
	id_minuta			= idw_facturas.GetItemString(i,'id_minuta')
	///***SCP-901. Alexis. 24/01/2011***///
	if not f_es_vacio(id_minuta) then
		ls_n_registro 		= f_dame_n_reg (id_minuta)
		else 	
		ls_n_registro 		= f_dame_n_reg (f_minutas_id_fase(id_fase))	
	end if
	
	ls_nif 					= idw_facturas.GetItemString(i,'nif')
	is_nombre 			= idw_facturas.GetItemString(i,'nombre')
	is_orden_apunte 	= idw_facturas.GetItemString(i,'orden_apunte')
	if is_tipo_factura = '04' then
		id_col  				= idw_facturas.GetItemString(i,'emisor')
	else
		id_col					= idw_facturas.GetItemString(i,'id_persona')
	end if
	ls_cliente 			= idw_facturas.GetItemString(i,'nombre')
	ld_total 				= idw_facturas.GetItemNumber(i,'total')
	ld_subtotal 			= idw_facturas.GetItemNumber(i,'subtotal')
	ld_descuento 		= idw_facturas.GetItemNumber(i,'descuento')
	ld_base_imp		= idw_facturas.GetItemNumber(i,'base_imp')
	ld_importe_reten 	= idw_facturas.GetItemNumber(i,'importe_reten')
	ld_subtotal_iva		= idw_facturas.GetItemNumber(i,'iva')
	
//	if ls_formadepago = 'CM' then continue // Se valida que no se contabilicen en este proceso las facturas que tienen Cobro Multiple
	if isnull(ld_descuento) then ld_descuento = 0
	//SI EXISTE DESCUENTO SE RECALCULA EL SUBTOTAL
	if ld_descuento <> 0 then ld_subtotal = ld_subtotal - ld_descuento	
	
 	if wf_valida_campo_dw(idw_facturas,'fases_archivo') then 
		ls_n_visado 		= idw_facturas.GetItemString(i,'fases_archivo_real')
	else 
		ls_n_visado = ''
	end if
	
	//
	ls_tipo_actuacion = f_dame_fase (f_devuelve_id_fase_minuta(id_fase))
	if isnull(ls_tipo_actuacion) then ls_tipo_actuacion= ''
	
	// SE OBTIENE SI HAY INGRESO Y LA CUENTA CONTABLE DEL BANCO
	ls_hay_ingreso 				= wf_hay_ingreso_formapago(ls_formadepago)
	ls_cta_contable_banco 	= wf_cuenta_contable_banco(ls_banco)
	

    //Rellenamos DATOS GENERALES DE G_APUNTE
	ls_concepto_factura = ''
	is_concepto_base = ''
	

    //SE RELLENA LA ESTRUCTURA DE APUNTES 
	g_apunte.n_apunte 		= '00000'
	g_apunte.n_doc			= is_n_factura
	g_apunte.fecha				= datetime(date(idt_fecha_fact), time("00:00:00"))
	g_apunte.t_asiento 		= g_t_asiento_apuntes_automaticos
	g_apunte.id_interno 		= id_factura
	g_apunte.centro			= idw_facturas.GetItemString(i,'centro') // El tipo de documento deber$$HEX1$$ed00$$ENDHEX$$a ir vinculado a la serie y al concepto, tomando preferentemente este $$HEX1$$fa00$$ENDHEX$$ltimo.
	if f_es_vacio(g_apunte.centro) then g_apunte.centro = g_centro_por_defecto
	g_apunte.proyecto			= g_explotacion_por_defecto
	g_apunte.nif 				= ls_nif
	g_apunte.nombre 			= is_nombre
	g_apunte.orden_apunte = is_orden_apunte
	g_apunte.diario 			= g_sica_diario.facts_emitidas_general
	g_apunte.n_asiento 		= RightA('0000000' + trim(string(i_asiento_general)),7)
	
	// Entraria si el modo de contabilizaci$$HEX1$$f300$$ENDHEX$$n en mostrar los apuntes de cobros y facturas juntas
	if g_contabilidad_conjunta = 'S' then
		if  ls_formadepago = 'CM'  then
			ll_found = idw_cobros_multiples.find("csi_facturas_emitidas.id_factura='"+id_factura+"'", 1, idw_cobros_multiples.rowcount())
			if ll_found > 0 then 
				id_cobro_multiple = idw_cobros_multiples.getitemstring(ll_found, 'csi_cobros_multiples_id_cobro_multiple')
				if id_cobro_multiple <> id_cobro_multiple_old then
					il_asiento_temp = 	long(g_apunte.n_asiento)
					i_asiento_general++
				end if
				if id_cobro_multiple_old = '-1' or (f_es_vacio(id_cobro_multiple_old) and not f_es_vacio(id_cobro_multiple) )  then id_cobro_multiple_old = id_cobro_multiple
				for m = 1 to g_conta.row
					if  g_conta.id_factura[m] = id_factura then	g_apunte.n_asiento 	= g_conta.n_asiento[m]
				next
				// se valida para evitar saltos en los apuntes
				if il_asiento_temp > long(g_apunte.n_asiento) then i_asiento_general = il_asiento_temp
			end if
		else
			i_asiento_general++
		end if
	end if
	
	if f_es_vacio(id_minuta) and f_es_vacio(id_fase) then
		g_apunte.t_doc 			= g_sica_t_doc.facts_emitidas_ot 
	else
		g_apunte.t_doc 			= g_sica_t_doc.facts_emitidas_exp
	end if
	

	if not  f_es_vacio(id_fase) or not f_es_vacio(id_minuta) then
		if not f_es_vacio(g_conta.concepto_exp)  then is_concepto_base = g_conta.concepto_exp +' ' + ls_n_expedi
			
	///*** SCP-1644. Alexis. 04/08/2011 ***///		
			choose case is_concepto_solo_num_reg
				case 'R'
					is_concepto_base = 'N$$HEX1$$ba00$$ENDHEX$$Reg. '+ls_n_registro	
				case 'E'
					is_concepto_base = 'N$$HEX2$$ba002000$$ENDHEX$$Exp. ' + ls_n_expedi
					//is_concepto_base = 
				case'V'
					if not f_es_vacio(ls_n_visado) then 
						is_concepto_base = 'V$$HEX2$$ba002000$$ENDHEX$$' + ls_n_visado
					else 
						is_concepto_base = 'N$$HEX1$$ba00$$ENDHEX$$Reg. '+ls_n_registro	
					end if 	
			end choose
		
		
end if
	is_concepto_numeracion = is_concepto_base
	
	// Le incrementamos al concepto base con el cliente
	is_concepto_base			= is_concepto_base + ' ' + ls_cliente
	
	is_cuenta_cp = f_dame_cuenta_col(id_col,'CP')
	is_cuenta_ret = f_dame_cuenta_col(id_col,'R')	// ret. vol
	ls_cuenta_iva = f_dame_cuenta_col(id_col,'I') 
	is_cuenta_col = f_dame_cuenta_col(id_col,'P')	// personal / honorarios	

	
/***********************************************************************************/
/*								 PROCESAMOS LAS LINEAS DE LAS FACTURAS        											        */
/*																																				   */
/*FACTURA DE HONORARIOS : COLEGIADO A CLIENTE  '04'	 NO se procesan las lineas								   */
/*FACTURA DE GASTOS A PROMOTOR: COLEGIO A CLIENTE '02' Cambia la cuenta del colegiado por la del cliente  */
/*																																				   */
/***********************************************************************************/

	ids_lineas.Retrieve(id_factura)
	if is_tipo_factura =  '02'  then
		is_cuenta_cp = ''
		is_cuenta_col = f_clientes_cuenta_contable(id_col)
		ib_dv_pdtes_abono = (ls_formadepago =g_formas_pago.pendientes_abono)
	END if
	if is_tipo_factura =  '03'  then //Puesto el 050808 Yexa
		is_cuenta_col =  f_dame_cuenta_col(id_col,'G') // Se asigna la cuenta de gasto
	end if
	wf_genera_apuntes_linea_fact( is_tipo_factura,  idw_facturas.GetItemString(i,'n_col'), ds_iva, is_orden_apunte)

/***********************************************************************************/
/*											CONTABILIZACION DE LA FACTURA  										       			   */
/*																																				   */
/***********************************************************************************/

string 	ls_concepto_irpf, ls_concepto_fact_iva, ls_concepto_fact_ret, ls_concepto_garantia, ls_concepto_cobro_cuenta, ls_cuenta_irpf
double	ld_subtotal_fact, ld_importe_garantia, ld_importe_cobro_a_cuenta, ld_importe_ret_vol, t_ret_vol
	

/***********************************/
/*	 SE OBTIENE EL CONCEPTO CONTABLE 		 */
/***********************************/
ls_concepto_factura 	=  is_concepto_base																			// Concepto simple solo la base
ls_concepto_irpf	  	= 	LeftA(g_conta.concepto_irpf + ' ' + is_concepto_base,57)						// Concepto IRPF 
ls_concepto_fact_ret	=   LeftA(g_conta.concepto_rv + ' ' + is_concepto_base,57)							// Concepto retenci$$HEX1$$f300$$ENDHEX$$n voluntaria
ls_concepto_garantia	=	 LeftA(trim(is_concepto_garantia) + ' ' + is_concepto_base,57)					// Concepto de garantia
ls_concepto_cobro_cuenta = LeftA(trim(is_concepto_cobro_a_cuenta) + ' ' + is_concepto_base,57)	// Concepto de cobro a cuenta


choose case is_tipo_factura
	case '04' //Factura de Honorarios
			if  ls_formadepago = 	g_formas_pago.pendientes_abono  then	ls_concepto_pend_abono= 'Hon.pdtes ' +is_concepto_base
			if not ib_aglutinar_iva_conceptos and not ib_resumida then
				ls_concepto_factura	= 'Hon' + is_concepto_base
			else
				if not f_es_vacio(g_conta.concepto_fact_general) then ls_concepto_factura = g_conta.concepto_fact_general +' '+ is_n_factura
			end if
				//Para ver la descripcion del tipo de IVA en las facturas de honorarios,
				select t_iva into :t_iva from csi_lineas_fact_emitidas where id_factura = :id_factura and articulo = :g_codigos_conceptos.honorarios;
				select descripcion into :ls_concepto_fact_iva from csi_t_iva where t_iva = :t_iva;	
				
	case '02'
				is_cuenta_col = ''
				is_cuenta_ret = g_cuenta_irpf_cliente_generica
				select cuenta_contable into :is_cuenta_col from clientes where id_cliente = :id_col;
				if isnull(is_cuenta_col) and g_conta.crear_cuentas_clientes_terceros = 'S' then
					is_cuenta_col = f_cuenta_contable_defecto_cli_provs('C',id_col)
				elseif f_es_vacio(is_cuenta_col) then
					is_cuenta_col = g_conta.cuenta_clientes_general
				end if
			

	Case '03'
				is_cuenta_col =  f_dame_cuenta_col(id_col,'G') // Se asigna la cuenta de gasto
end choose

ls_concepto_factura =  LeftA(ls_concepto_factura,57)
ls_concepto_fact_iva =  LeftA(ls_concepto_fact_iva,57)
//FIN BUSQUEDA CONCEPTOS

ld_importe_garantia = 0
select sum(total) into :ld_importe_garantia from csi_lineas_fact_emitidas where id_factura = :id_factura and articulo = :g_conta.garantia_codigo_articulo;
// Miramos los cobros a cuenta de la factura

	ld_importe_cobro_a_cuenta = 0
	select sum(total) into :ld_importe_cobro_a_cuenta from csi_lineas_fact_emitidas where id_factura = :id_factura and articulo = :g_codigos_conceptos.cobro_a_cuenta;
	
	if g_conta.aglutina_importe_garantia = 'S' then
		// Se redondea el subtotal
		if ld_importe_garantia <> 0 then
			ld_subtotal = f_redondea(ld_subtotal - ld_importe_garantia) 
		end if
	end if
	
	if g_conta.aglutina_importe_cobro_cuenta = 'S' then
	// Se redondea el subtotal
		if (ld_importe_cobro_a_cuenta <> 0)   then
			ld_subtotal = f_redondea(ld_subtotal - ld_importe_cobro_a_cuenta) 
		end if
	end if
		
///*Se traslado de varias lineas arriba, para que recoja el importe del cobro a cuenta y las garantias. CZA-121. Alexis. 17/02/2010 *///
//SE OBTIENE EL SUBTOTAL DE LA FACTURA
ld_subtotal_fact = ld_subtotal +ld_subtotal_iva		
		
// En el caso que el colegiado tuviese retencion voluntaria calculamos la parte que le corresponde
				t_ret_vol = 0
				ld_importe_ret_vol = 0
				if g_conta.ret_vol = 'C' then
//					//Ver si tiene retenci$$HEX1$$f300$$ENDHEX$$n voluntaria:
					select ret_voluntaria into :t_ret_vol from colegiados where id_colegiado = :id_col;
					if isnull(t_ret_vol) then t_ret_vol = 0
					ld_importe_ret_vol = round(ld_subtotal * t_ret_vol / 100 , 2)
				end if


/*******************************************/
/*	PROCESO DE GENERAR LOS APUNTES DE LA FACTURA */
/******************************************/

	// Apuntes de garantia
	/// *** SCP-728. Se a$$HEX1$$f100$$ENDHEX$$ade control de acceso a la creaci$$HEX1$$f300$$ENDHEX$$n de dichos apuntes. var global permitir_generar_apuntes_garantias .Alexis. 20/09/2011 ***///
	if Instance_var_permitir_generar_apuntes_garantias = 'S' then 
		if  ld_importe_garantia <> 0 then
			if dw_fechas.getitemstring(1, 'aglutinar_garantia') = 'S' then
				wf_crear_apunte(idt_fecha_fact,g_conta.garantia_cuenta, ls_concepto_garantia, ld_importe_garantia, 0, is_orden_apunte, '')
			else
				
				//Debe
				wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_garantia, ld_importe_garantia, 0, is_orden_apunte, '')
				//Haber
				wf_crear_apunte(idt_fecha_fact, g_conta.garantia_cuenta, ls_concepto_garantia,  0,ld_importe_garantia,  is_orden_apunte, '')
			end if
		end if
	end if	
	//apunte Factura
	if is_tipo_factura = '04' then
		if  ls_formadepago = 	g_formas_pago.autoliquidacion  then 
			if dw_fechas.getitemstring(1,'autoliquidacion') = 'N' then 
				i_asiento_general --
				continue
			else
				// /* COAATZ-26. Se comenta l$$HEX1$$ed00$$ENDHEX$$nea de creaci$$HEX1$$f300$$ENDHEX$$n del apunte de IRPF poruqe ya lo crea a posteriori. */
				//wf_crear_apunte(idt_fecha_fact, is_cuenta_col, 'IRPF ' +ls_concepto_factura, ld_importe_reten, 0, is_orden_apunte, '')
				wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_factura, ld_subtotal+ld_subtotal_iva - ld_importe_reten, 0, is_orden_apunte, '')
	
			end if
		end if
		if  ls_formadepago = 	g_formas_pago.pendientes_abono  then
					// Este es especial para zaragoza... 
					// Tenemos que montarnos un proceso especial para estas facturas. 
					// -> VA apunte y contraapunte por el total a la cuenta del colegiado :O
					// -> apunte contra la 44100001 y contraapunte por el total a la cuenta especial del colegiado :O (con prefijo 4130)
					wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_pend_abono, ld_subtotal+ld_subtotal_iva, 0, is_orden_apunte, '')
					///*CZA-121. Cambio para que reste donde deba el pago a cuenta. Alexis.04032010*/// 
					
					ls_cuenta_col_pa = f_dame_cuenta_col(id_col,'A')	// Cuenta pendite abono
					
					if  ld_importe_cobro_a_cuenta <> 0   and g_conta.aglutina_importe_cobro_cuenta = 'S' then

						//is_cuenta_col = f_dame_cuenta_col(id_col,'A')	// Cuenta pendite abono
						
						if  ld_importe_cobro_a_cuenta > 0 then
							wf_crear_apunte(idt_fecha_fact, ls_cuenta_col_pa, ls_concepto_pend_abono, 0, ld_subtotal+ld_subtotal_iva - ld_importe_cobro_a_cuenta, is_orden_apunte, g_cuenta_puente_pendiente_abono_hon)
							wf_crear_apunte(idt_fecha_fact, ls_cuenta_col_pa, ls_concepto_pend_abono, 0, ld_importe_cobro_a_cuenta, is_orden_apunte, g_cuenta_puente_pendiente_abono_hon)
						else 
							wf_crear_apunte(idt_fecha_fact, g_cuenta_puente_pendiente_abono_hon, ls_concepto_pend_abono, ld_importe_cobro_a_cuenta, 0, is_orden_apunte, ls_cuenta_col_pa)
							wf_crear_apunte(idt_fecha_fact, g_cuenta_puente_pendiente_abono_hon, ls_concepto_pend_abono, 0, ld_subtotal+ld_subtotal_iva + ld_importe_cobro_a_cuenta, is_orden_apunte, ls_cuenta_col_pa)
						end if
										
					else 	
						wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_pend_abono, 0, ld_subtotal+ld_subtotal_iva, is_orden_apunte, '')
						wf_crear_apunte(idt_fecha_fact, g_cuenta_puente_pendiente_abono_hon, ls_concepto_pend_abono, ld_subtotal+ld_subtotal_iva, 0, is_orden_apunte, ls_cuenta_col_pa)
						wf_crear_apunte(idt_fecha_fact, ls_cuenta_col_pa, ls_concepto_pend_abono, 0, ld_subtotal+ld_subtotal_iva, is_orden_apunte, g_cuenta_puente_pendiente_abono_hon)
					end if
					///*Fin del cambio CZA-121.Alexis.04032010*///	
		end if
		
		if  ls_formadepago = g_formas_pago.otras_entidades then
					// Este es especial para zaragoza... VA apunte y contraapunte por el total a la cuenta del colegiado :O
					//wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_factura, 0, ld_subtotal+ld_subtotal_iva, is_orden_apunte, '')
					wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_factura, ld_subtotal+ld_subtotal_iva, 0, is_orden_apunte, '')
		end if
		
		// CZA-121 Para reflejar el pago en cuenta en cualquier otra forma de pago 
		if  ls_formadepago <> g_formas_pago.otras_entidades and ls_formadepago <> g_formas_pago.pendientes_abono and ls_formadepago <> g_formas_pago.autoliquidacion and g_conta.aglutina_importe_cobro_cuenta = 'S' then
				wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_cobro_cuenta, 0, ld_importe_cobro_a_cuenta, is_orden_apunte, '')
		end if	
		// Fin modificaci$$HEX1$$f300$$ENDHEX$$n CZA-121
		
		if (not (ib_resumida and ib_aglutinar_irpf)) or ((ib_resumida and ib_aglutinar_irpf) and ls_cuenta_irpf <> is_cuenta_col ) then
				if  ld_subtotal_iva >0   then 
					if  dw_fechas.getitemstring(1,'iva_honorario') = 'N' then
						//PORRERO COAM-360//
						if not ib_aglutinar_irpf then
							wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_factura, 0, ld_subtotal, is_orden_apunte, '')
						else
							wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_factura, 0, ld_subtotal - ld_importe_reten, is_orden_apunte, '')
						end if
					else
						if  ls_formadepago  <>	g_formas_pago.pendientes_abono  then
							if not ib_aglutinar_irpf then
								wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_factura, 0, ld_subtotal_fact, is_orden_apunte, '')
							else
								wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_factura, 0, ld_subtotal_fact - ld_importe_reten, is_orden_apunte, '')
							end if
						end if
					end if
					////////////////////////////////
				else
				 	if not ib_aglutinar_irpf then
						if  ls_formadepago  <>	g_formas_pago.pendientes_abono  then 
							//PORRERO COAM-360//
							if  dw_fechas.getitemstring(1,'iva_honorario') = 'N' then
								wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_factura, 0, ld_subtotal, is_orden_apunte, '') 	
							else
								wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_factura, 0, ld_subtotal_fact, is_orden_apunte, '')
							end if
							////////////////////////////
						end if
					else
						//PORRERO COAM-360//
						if  dw_fechas.getitemstring(1,'iva_honorario') = 'N' then
							wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_factura, 0, ld_subtotal - ld_importe_reten, is_orden_apunte, '')
						else
							wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_factura, 0, ld_subtotal_fact - ld_importe_reten, is_orden_apunte, '')
						end if
						////////////////////////////
					end if
				end if
		else
			if  dw_fechas.getitemstring(1,'iva_honorario') = 'N' then
				wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_factura, 0, ld_subtotal - ld_importe_reten, is_orden_apunte, '')
			else
				wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_factura, 0, ld_subtotal_fact - ld_importe_reten, is_orden_apunte, '')
			end if
		end if
	end if
	
	// Apuntes para IRPF
	if ld_importe_reten <> 0 then
		ls_cuenta_irpf = is_cuenta_ret
	choose case is_tipo_factura
		case '04'
			if ( ls_formadepago <> g_formas_pago.pendientes_abono) then 
				if (not (ib_resumida and ib_aglutinar_irpf)) or ((ib_resumida and ib_aglutinar_irpf) and ls_cuenta_irpf <> is_cuenta_col ) then
					if not ib_aglutinar_irpf then 	
						wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_irpf,ld_importe_reten,0, is_orden_apunte, '')
					end if
				else
					//Apunte por el debe
					if not ib_aglutinar_irpf then  
						wf_crear_apunte(idt_fecha_fact, ls_cuenta_irpf, ls_concepto_irpf, ld_importe_reten, 0,  is_orden_apunte, '')
					end if
				end if
			end if 	
		
	case '03'
			//Apunte por el haber
			wf_crear_apunte(idt_fecha_fact, is_cuenta_col, is_concepto_base, 0, ld_subtotal_fact - ld_importe_reten, is_orden_apunte, '')
		
	case '02'
		// Generamos el apunte del debe y el del haber
			wf_crear_apunte(idt_fecha_fact, is_cuenta_ret,ls_concepto_irpf, ld_importe_reten, 0, is_orden_apunte, is_cuenta_col)
				//	 Lo sacamos de la cuenta del cliente
			wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_irpf, 0, ld_importe_reten, is_orden_apunte, is_cuenta_ret)
	end choose
	
	end if	

	
//	///* Se introduce para que genere el apunte correspondiente al pago a cuenta. CZA-121.ALEXIS.17/02/2010*///
//	
//		// Apuntes de cobro a cuenta
//		if  ld_importe_cobro_a_cuenta <> 0   and g_conta.aglutina_importe_cobro_cuenta = 'S' then
//			
//				wf_crear_apunte(idt_fecha_fact,is_cuenta_col, is_concepto_cobro_a_cuenta + ' ' + ls_concepto_factura, 0, ld_importe_cobro_a_cuenta, is_orden_apunte, '')
//			
//		end if
//
//	///*Fin del c$$HEX1$$f300$$ENDHEX$$digo introducido con motivo de la incidencia CZA-121. ALEXIS. 17/02/2010*///
//	//Apunte de IVA
	
	double imp_iva, base_imp_iva
	string  ls_cuenta_iva_repecurtido, ls_concepto_fact_iva_rp
	
		
			FOR k=1 TO ds_iva.RowCount()
					imp_iva = ds_iva.GetItemNumber(k,'importe')
					base_imp_iva = ds_iva.GetItemNumber(k,'base_imp')
					if imp_iva = 0 and base_imp_iva = 0 then continue
					ls_concepto_fact_iva = LeftA(trim(ds_iva.GetItemString(k,'descripcion')) + ' ' + is_concepto_base, 57)
					ls_cuenta_iva = ds_iva.GetItemString(k,'id_cuenta_repercutido')
					//Apunte a la cuenta de iva
					g_apunte.base_imp = ds_iva.GetItemNumber(k,'base_imp')
					g_apunte.nombre = is_nombre
					g_apunte.nif = idw_facturas.GetItemString(i, 'nif')
					g_apunte.t_iva = ds_iva.GetItemString(k, 't_iva')
					if is_tipo_factura<>  '04' then	
					//Apuntes del iva
						wf_crear_apunte(idt_fecha_fact, ls_cuenta_iva, ls_concepto_fact_iva, 0, imp_iva, is_orden_apunte, is_cuenta_col)
					else
						if  ls_formadepago = 	g_formas_pago.autoliquidacion and  dw_fechas.getitemstring(1,'autoliquidacion') = 'S'  and dw_fechas.getitemstring(1,'iva_honorario') = 'N' then 
							wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_fact_iva, 0, imp_iva, is_orden_apunte, is_cuenta_col)
						end if
						if  (ls_formadepago <> g_formas_pago.autoliquidacion) and (ls_formadepago <> 	g_formas_pago.otras_entidades)  and dw_fechas.getitemstring(1,'iva_honorario') = 'N' then
							wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_fact_iva, 0, imp_iva, is_orden_apunte, is_cuenta_col)
						end if
						
					end if
						g_apunte.base_imp = 0
				
					if not ib_resumida and not ib_aglutinar_iva_conceptos and is_tipo_factura <>  '04'then
						//Apunte a la cuenta del colegiado
						wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_fact_iva,  imp_iva,0, is_orden_apunte, ls_cuenta_iva)
					else
						// Vamos incrementando el total
						id_importe_resumido+=imp_iva
					end if
				NEXT
	
	
//end if

if ib_resumida then
	// Si la opcion es resumida aqu$$HEX2$$ed002000$$ENDHEX$$es cuando hacemos el totalizado, contra la cuenta del colegiado
	if isNull(ls_formadepago) then ls_formadepago=""
	///*CZA-121. Cambio para que no se introduzca el apunte en caso de ser pendiente de abono. Alexis.04032010*///
	if ls_formadepago <> g_formas_pago.pendientes_abono then
		if is_tipo_factura <> '04'  and  (ls_formadepago <> 'CM'  or g_asiento_unico_cc = 'N' ) then
				wf_crear_apunte(idt_fecha_fact, is_cuenta_col, 'Fact '+is_n_factura, id_importe_resumido, 0, is_orden_apunte, '')
		end if
		if  is_tipo_factura='04' and g_asiento_unico_cc = 'N' then 
			 if date(idt_fecha_fact) <>  date(idw_facturas.GetItemDatetime(i, 'f_pago')) then
			//Apunte por el  Haber
				wf_crear_apunte(idt_fecha_fact, is_cuenta_col,'V$$HEX2$$ba002000$$ENDHEX$$' + ls_n_visado,  ld_subtotal+ld_subtotal_iva - ld_importe_reten,0, is_orden_apunte, '')
			end if
		end if
	else 
		if is_tipo_factura <> '04'  and  (ls_formadepago <> 'CM'  or g_asiento_unico_cc = 'N' )  and g_colegio = 'COAATZ' then
				wf_crear_apunte(idt_fecha_fact, is_cuenta_col, 'Fact '+is_n_factura, id_importe_resumido, 0, is_orden_apunte, '')
		end if
	
	end if	
end if


/***********************************************************************************/
/*											CONTABILIZACION DE LA COBROS  										       			   */
/*																																				   */
/***********************************************************************************/

		ls_concepto_obs_fact = f_factura_observaciones_text(idw_facturas.getitemstring(i, 'id_factura'))
		if idw_facturas.getitemstring(i, 'pagado') = 'N' then continue
		if ls_formadepago <> 'CM' then
			idw_cobros.setfilter("id_factura='"+id_factura+"'")
			idw_cobros.filter()
			if idw_cobros.rowcount() <= 0 then continue
			is_asunto = idw_facturas.GetItemString(i,'asunto')
			is_concepto = ls_concepto_factura
			wf_apuntes_cobros_fact( ls_concepto_obs_fact,idt_fecha_fact, ld_subtotal_fact)
			idw_cobros.setredraw(false)
			idw_cobros.setfilter("")
			idw_cobros.filter()
			idw_cobros.setfilter("empresa = '"+ g_empresa + "'")
			idw_cobros.filter()
			idw_cobros.setredraw(false)
		else

				if idw_cobros_multiples.rowcount() <= 0 then continue
				this.triggerevent('csd_cobros_multiples')
				idw_cobros_multiples.setredraw(false)
				idw_cobros_multiples.setfilter("")
				idw_cobros_multiples.filter()
				idw_cobros_multiples.setfilter("empresa = '"+ g_empresa + "'")
				idw_cobros_multiples.filter()
				idw_cobros_multiples.setredraw(true)				

		
		end if
	
	if g_contabilidad_conjunta = 'N' then i_asiento_general++

next // Fin de facturas

end if
end event

event csd_apuntes_fact_contabilizadas();//
long 		fila_cobro, saltados
string		ls_concepto_cobro, ls_concepto, ls_n_expedi, ls_cuenta_cobro, ls_cta_contable_banco_cobro, ls_banco, ls_hay_ingreso
string		id_cobro_multiple, ls_forma_pago_cobro, ls_pagado, ls_cuenta_contrapartida, ls_cuenta_col_pa, ls_cta_puente_pa, ls_cuenta_irpf, ls_concepto_irpf
string 	ls_n_remesa,ls_cliente, banco_cobro, nif, nombre, formadepago, ls_cta_contable_banco, concepto_cobro, n_plazo, ls_n_registro, ls_formadepago, n_visado
double	total_remesa, total_asiento, total_cobro, importe_reten , subtotal, subtotal_iva, ld_importe_reten
datetime	ldt_fecha_cobro
string 	tipo_documento_remesa, contabilizado_fact, id_persona, ls_n_remesa_old, id_fase_old, id_minuta_old
boolean	b_HayIngresocobro, b_aglutina_remesa, b_cambiar_asiento = false

b_aglutina_remesa = (dw_fechas.getitemString(1, 'aglutinar_remesa') ='S')
ls_n_remesa_old ='-1'

idw_cobros_facturas_contabilizadas.setfilter("empresa = '"+g_empresa+ "'")
idw_cobros_facturas_contabilizadas.filter()

if idw_cobros_facturas_contabilizadas.RowCount()>0 then
	tipo_documento_remesa = g_sica_t_doc.remesas
	if f_es_vacio(tipo_documento_remesa) then tipo_documento_remesa = 'RE'
	g_apunte.n_asiento = right('0000000' + trim(string(i_asiento_general)),7)
	//PORRERO 28/12/09 COAM-245
	g_apunte.diario 			= g_sica_diario.facts_emitidas_general
	g_apunte.proyecto			= g_explotacion_por_defecto
	g_apunte.n_apunte = '00000'
	// POnemos el centro por defecto
	g_apunte.centro = g_centro_por_defecto
	g_apunte.base_imp = 0
	g_apunte.nif = ''
	g_apunte.nombre = ''
// Colocamos la inicializacion de las variables
	total_remesa = 0
	total_asiento = 0
	
// Si la contabilizacion es por remesas debemos ordenar pos este valor
	if b_aglutina_remesa then 
		idw_cobros_facturas_contabilizadas.setsort("n_remesa_real A, de_expediente A, id_fase D, id_remesa D")
	else
		idw_cobros_facturas_contabilizadas.setsort("de_expediente A, id_fase D, id_minuta D")
	end if
	idw_cobros_facturas_contabilizadas.sort()

	saltados = 0
	FOR fila_cobro = 1 TO idw_cobros_facturas_contabilizadas.RowCount()
		//scp-2116
		if idw_cobros_facturas_contabilizadas.getitemstring(fila_cobro,'csi_cobros_contabilizado')= 'S' then continue
		//SCP-427 Verificamos que la fecha del cobro pertenece al ejercicio actual
		if string(year(date(idw_cobros_facturas_contabilizadas.GetItemDateTime(fila_cobro, 'csi_cobros_f_pago'))))<>g_ejercicio then 
			if g_conta_cobros_ejercicio_noactual = 'N' then continue //scp-2123
		end if
		st_progreso.text = 'Procesando ' + string(fila_cobro) + ' de ' + string(idw_cobros_facturas_contabilizadas.RowCount())+' cobro de Fact. Cont. '+string(idw_apuntes.RowCount())+' apuntes generados.'
		yield()
		ls_n_remesa 	= idw_cobros_facturas_contabilizadas.getitemstring(fila_cobro, 'n_remesa_real')
		id_factura 		= idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'id_factura')
		id_fase 			= idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'id_fase')
		id_minuta 		= idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'id_minuta')
		contabilizado_fact = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'contabilizada')
	
		///***SCP-901. Alexis. 24/01/2011***///
		if not f_es_vacio(id_minuta) then
		ls_n_registro 		= f_dame_n_reg (id_minuta)
		else 	
		ls_n_registro 		= f_dame_n_reg (f_minutas_id_fase(id_fase))	
	end if
	
		if contabilizado_fact = 'N' then
			// Tenemos que mirar si est$$HEX2$$e1002000$$ENDHEX$$esta vez seleccionado, o saltarselo este cobro!
			if idw_facturas.find("id_factura = '"+id_factura+"'", 1, idw_facturas.RowCount()) = 0 then
				saltados++
				continue
			end if
		end if

		// Cogemos variables temporales que nos ser$$HEX1$$e100$$ENDHEX$$n necesarias
		id_persona		= idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'id_persona')
		is_tipo_factura = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'tipo_factura')
		ls_cliente = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'nombre')
		ls_n_expedi = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'expedientes_n_expedi')
		ls_forma_pago_cobro = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'csi_cobros_forma_pago')
		ls_formadepago = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'formadepago')
		ldt_fecha_cobro = idw_cobros_facturas_contabilizadas.GetItemDateTime(fila_cobro,'csi_cobros_f_pago')
		total_cobro	= idw_cobros_facturas_contabilizadas.GetItemNumber(fila_cobro,'csi_cobros_importe')
		banco_cobro = idw_cobros_facturas_contabilizadas.getitemstring(fila_cobro, 'csi_cobros_banco')
		nif = idw_cobros_facturas_contabilizadas.getitemstring(fila_cobro, 'nif')
		nombre = idw_cobros_facturas_contabilizadas.getitemstring(fila_cobro, 'nombre')
		formadepago = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'formadepago')
		subtotal = idw_cobros_facturas_contabilizadas.GetItemNumber(fila_cobro,'subtotal')
		importe_reten = idw_cobros_facturas_contabilizadas.GetItemNumber(fila_cobro,'importe_reten')
		subtotal_iva = idw_cobros_facturas_contabilizadas.GetItemNumber(fila_cobro,'iva')
		n_visado = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'fases_archivo_real')
		if is_tipo_factura = '04' then
			id_col  				= idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'emisor')
			else
			id_col					= idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'id_persona')
		end if
		// SE OBTIENE SI HAY INGRESO Y LA CUENTA CONTABLE DEL BANCO
		ls_hay_ingreso 				= wf_hay_ingreso_formapago(ls_forma_pago_cobro)
		ls_cta_contable_banco 	= wf_cuenta_contable_banco(banco_cobro)

		b_HayIngresocobro = (upper(ls_hay_ingreso) = 'S')
		
		// SE OBTIENE LAS CUENTAS
		is_cuenta_cp = f_dame_cuenta_col(id_col,'CP')
		is_cuenta_col = f_dame_cuenta_col(id_col,'P')	// personal / honorarios	
		
		choose case is_tipo_factura
			case '02'
				is_cuenta_col = ''
				select cuenta_contable into :is_cuenta_col from clientes where id_cliente = :id_col;
				if  f_es_vacio(is_cuenta_col)  and g_conta.crear_cuentas_clientes_terceros = 'S' then
					is_cuenta_col = f_cuenta_contable_defecto_cli_provs('C',id_col)
				elseif  f_es_vacio(is_cuenta_col) then
					is_cuenta_col = g_conta.cuenta_clientes_general
				end if
			case '03'
				is_cuenta_col = f_dame_cuenta_col(id_persona,'G') // Cuenta de gastos
		end choose
		
		if  ls_n_remesa = '' then 
			g_apunte.n_asiento = right('0000000' + trim(string(i_asiento_general)),7)
			g_apunte.n_apunte = '00000'
			i_asiento_general++ 
		end if
		
		if b_aglutina_remesa  then
			if ( ls_n_remesa_old <> ls_n_remesa ) and  ls_n_remesa <> '' then
				// Hay que hacer la contabilizacion de la remesa anterior y preparar la siguiente
				// Total: al debe del banco
				g_apunte.id_interno = ls_n_remesa_old
				g_apunte.n_doc = ls_n_remesa_old
				g_apunte.t_doc = tipo_documento_remesa
				g_apunte.nif = ''
				g_apunte.nombre = ''
				wf_crear_apunte(ldt_fecha_cobro, ls_cta_contable_banco, 'Rem. '+ ls_n_remesa_old, total_remesa, 0, '', '')
				// VAciamos la remesa
				total_remesa = 0
				ls_n_remesa_old =ls_n_remesa
				
				i_asiento_general++ 
				g_apunte.n_asiento = right('0000000' + trim(string(i_asiento_general)),7)
				g_apunte.n_apunte = '00000'
	
			end if
			
		end if 
		if ls_n_remesa_old = '-1' or (f_es_vacio(ls_n_remesa_old) and not f_es_vacio(ls_n_remesa) )  then ls_n_remesa_old = ls_n_remesa // Inicializamos el valor de la remesa al de la primera remesa
		if ls_forma_pago_cobro = 'CP' then ls_cta_contable_banco = is_cuenta_cp
		
		is_concepto_base = 'Pago Fact N$$HEX2$$ba002000$$ENDHEX$$'+idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'n_fact')
		//concepto_cobro = LeftA('Ing ' + is_concepto_base,57)
		if ls_formadepago = g_formas_pago.pendientes_abono then
			choose case is_concepto_solo_num_reg
				case 'R'
					is_concepto_base = 'N$$HEX1$$ba00$$ENDHEX$$Reg. '+ls_n_registro	+ ' ' + ls_cliente
				case 'E'
					is_concepto_base = 'N$$HEX2$$ba002000$$ENDHEX$$Exp. ' + ls_n_expedi + ' ' + ls_cliente
					//is_concepto_base = 
				case'V'
					if not f_es_vacio(n_visado) then
						is_concepto_base = 'V$$HEX2$$ba002000$$ENDHEX$$' + n_visado + ' ' + ls_cliente
					else
						is_concepto_base = 'N$$HEX1$$ba00$$ENDHEX$$Reg. '+ls_n_registro + ' ' + ls_cliente
					end if
			end choose 		
		end if

		if ls_formadepago = 'CP' then
			concepto_cobro = LeftA( is_concepto_base, 57)
		else
			concepto_cobro = LeftA('Ing ' + is_concepto_base,57)
		end if
		
		if ls_forma_pago_cobro = g_formas_pago.domiciliacion then concepto_cobro = LeftA('Dom ' + is_concepto_base,57)
		if ls_forma_pago_cobro = g_formas_pago.metalico then concepto_cobro = LeftA('Efec. ' + is_concepto_base,57)
//		// Si es un pago fraccionado indicamos el plazo correspondiente
		if lower(idw_cobros_facturas_contabilizadas.describe("n_plazo.name")) = 'n_plazo' then n_plazo = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'n_plazo')
		if not f_es_vacio(n_plazo) then concepto_cobro += ' (Plazo ' + n_plazo + '$$HEX1$$ba00$$ENDHEX$$)'				

		idw_cobros_facturas_contabilizadas.SetItem(fila_cobro, 'csi_cobros_f_contabilizado',ldt_fecha_cobro)
		idw_cobros_facturas_contabilizadas.SetItem(fila_cobro, 'csi_cobros_contabilizado','S')
	
		CHOOSE CASE ls_forma_pago_cobro
			CASE g_formas_pago.liquidacion
				// Si la forma de pago del cobro es 'LI' o de la factura es 'LI' saltamos la generacion del apunte
				continue
			CASE g_formas_pago.cargo
				// Si la forma de pago del cobro es 'CA' o de la factura es 'CA' saltamos la generacion del apunte
				continue
			CASE g_formas_pago.pendientes_abono
				// Si la forma de pago del cobro es 'PA' o de la factura es 'PA' saltamos la generacion del apunte
				setnull(ldt_fecha_cobro)
				idw_cobros_facturas_contabilizadas.SetItem(fila_cobro, 'csi_cobros_f_contabilizado',ldt_fecha_cobro)
				idw_cobros_facturas_contabilizadas.SetItem(fila_cobro, 'csi_cobros_contabilizado','N')
				continue
		END CHOOSE
		
		// No procesamos las 'LI' ni las 'CA'
		if formadepago = g_formas_pago.liquidacion then continue
		if formadepago = g_formas_pago.cargo then continue
		
		IF not b_HayIngresocobro then continue
		// Modificamos el concepto apra decir que es parte de una remesa
		if b_aglutina_remesa and not f_es_vacio(ls_n_remesa) then concepto_cobro = 'Rem. '+ls_n_remesa+' ('+concepto_cobro+')'

//		////////////////////////////////////////////////////////
//		//Rellenamos DATOS GENERALES DE G_APUNTE
//		////////////////////////////////////////////////////////

		g_apunte.centro = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'centro')	
		choose case ls_forma_pago_cobro
			case g_formas_pago.transferencia
				g_apunte.t_doc = g_sica_t_doc.transferencia
			case g_formas_pago.talon
				g_apunte.t_doc = g_sica_t_doc.talon
			case else
				g_apunte.t_doc = g_sica_t_doc.generico
		end choose

//		// Si pertenece a una remesa, el tipo de documento ser$$HEX2$$e1002000$$ENDHEX$$remesa
		if f_es_vacio(ls_n_remesa) and b_aglutina_remesa  then 
			g_apunte.id_interno = id_factura
			g_apunte.n_doc = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'n_fact')
		else
			g_apunte.n_doc = ls_n_remesa
			g_apunte.t_doc = tipo_documento_remesa
			g_apunte.id_interno = ls_n_remesa
		end if


string concepto
//		// Generamos el apunte correspondiente...
		CHOOSE CASE formadepago
			CASE g_formas_pago.pendientes_abono
								
			
//				// Tratamiento especial para zaragoza
				CHOOSE CASE is_tipo_factura
					CASE '04'
												
						///*** SCP-901. Alexis. 25/01/2011. Se introduce premisa por la cual s$$HEX1$$f300$$ENDHEX$$lo si no est$$HEX2$$e1002000$$ENDHEX$$seleccionada la opci$$HEX1$$f300$$ENDHEX$$n de que s$$HEX1$$f300$$ENDHEX$$lo se muestre n$$HEX1$$fa00$$ENDHEX$$m. de registro, se pueda mostra el n$$HEX1$$fa00$$ENDHEX$$m de visado. ***///  
						///*** SCP-1644. Alexis. 04/11/2011. Cambio para permitir introducir el n$$HEX2$$ba002000$$ENDHEX$$de expediente***///
						choose case is_concepto_solo_num_reg
							case 'R'
								concepto = 'Pago fra. pte. N$$HEX1$$ba00$$ENDHEX$$Reg. '+ls_n_registro	+ ' ' + ls_cliente
							case 'E'
								concepto = 'Pago fra. pte. N$$HEX2$$ba002000$$ENDHEX$$Exp. ' + ls_n_expedi + ' ' + ls_cliente
								//is_concepto_base = 
							case'V'
								if not f_es_vacio(n_visado) then
									concepto = 'Pago fra. pte. V$$HEX2$$ba002000$$ENDHEX$$' + n_visado + ' ' + ls_cliente
								else
									concepto = 'Pago fra. pte. N$$HEX1$$ba00$$ENDHEX$$Reg. '+ls_n_registro + ' ' + ls_cliente
								end if
						end choose
					
									
						is_cuenta_col = f_dame_cuenta_col(id_col,'A')	// Cuenta pendite abono
						wf_crear_apunte(ldt_fecha_cobro, is_cuenta_col, concepto, subtotal+subtotal_iva, 0, '', '')
						wf_crear_apunte(ldt_fecha_cobro, g_cuenta_puente_pendiente_abono_hon, concepto, 0, subtotal+subtotal_iva, '', '')
						
						is_cuenta_col = f_dame_cuenta_col(id_col,'P')	// Cuenta pendite abono
						wf_crear_apunte(ldt_fecha_cobro, is_cuenta_col, concepto, 0, subtotal+subtotal_iva , '', '')
						
						
						//*** COAATZ-23 Se pasa la creaci$$HEX2$$f3002000$$ENDHEX$$de los apuntes del IRPF desde la contabilizaci$$HEX1$$f300$$ENDHEX$$n de facturas a la de los cobros de las facturas con forma de pago "EXPEDIENTES PTES. DE ABONO".
							
							if  ls_formadepago  =	g_formas_pago.pendientes_abono  then
								select importe_reten into :ld_importe_reten from csi_facturas_emitidas where id_factura =:id_factura;
								
								ls_concepto_irpf = LeftA(g_conta.concepto_irpf + ' ' + is_concepto_base,57)						// Concepto IRPF 
								
								is_cuenta_ret = f_dame_cuenta_col(id_col,'R')	// ret. vol
								if ld_importe_reten <> 0 then ls_cuenta_irpf = is_cuenta_ret
								
								if (not (ib_resumida and ib_aglutinar_irpf)) or ((ib_resumida and ib_aglutinar_irpf) and ls_cuenta_irpf <> is_cuenta_col ) then
									if not ib_aglutinar_irpf then 	
										wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_irpf,ld_importe_reten,0, is_orden_apunte, '')
									end if
								else
									//Apunte por el debe
									if not ib_aglutinar_irpf then  
										wf_crear_apunte(idt_fecha_fact, ls_cuenta_irpf, ls_concepto_irpf, ld_importe_reten, 0,  is_orden_apunte, '')
									end if
								end if
							end if 	
					 //**** FIN COAATZ-23****//
						
						
						
					CASE '02'
												
						///*** SCP-1644. Alexis. 04/11/2011. Cambio para permitir introducir el n$$HEX2$$ba002000$$ENDHEX$$de expediente***///
						choose case is_concepto_solo_num_reg
							case 'R'
								concepto = 'N$$HEX1$$ba00$$ENDHEX$$Reg. '+ls_n_registro	
							case 'E'
								concepto = 'N$$HEX2$$ba002000$$ENDHEX$$Exp. ' + ls_n_expedi
								//is_concepto_base = 
							case'V'
								if not f_es_vacio(n_visado) then
									concepto = 'V$$HEX2$$ba002000$$ENDHEX$$' + n_visado
								else
									concepto = 'N$$HEX1$$ba00$$ENDHEX$$Reg. '+ls_n_registro	
								end if
						end choose
						
						// Tenemos que deshacer lo que hizo el apunte en su dia
						wf_crear_apunte(ldt_fecha_cobro, g_cuenta_puente_pendiente_abono_dv, concepto, 0, subtotal+subtotal_iva, '', '')
						wf_crear_apunte(ldt_fecha_cobro, is_cuenta_col, concepto, subtotal+subtotal_iva, 0, '', '')
						wf_crear_apunte(ldt_fecha_cobro, is_cuenta_col, concepto, 0, subtotal+subtotal_iva, '', '')
						
				END CHOOSE
			CASE ELSE
				if is_tipo_factura <> '04' then
//					//Abono en cuenta del colegiado:
					g_apunte.nif = nif
					g_apunte.nombre = nombre
					wf_crear_apunte(ldt_fecha_cobro, is_cuenta_col, concepto_cobro, 0, total_cobro, '', ls_cta_contable_banco)
				end if
		END CHOOSE
//				
		if not b_aglutina_remesa or f_es_vacio(ls_n_remesa) then
//			// Total: al debe del banco
			wf_crear_apunte(ldt_fecha_cobro, ls_cta_contable_banco, concepto_cobro, total_cobro, 0, '', is_cuenta_col)
	end if
//		// Solo si estamos con una remesa valida vamos 
		if not(not b_aglutina_remesa or f_es_vacio(ls_n_remesa)) then total_remesa += total_cobro
		total_asiento += total_cobro
		ls_n_remesa_old = ls_n_remesa

	NEXT
	
	if b_aglutina_remesa and not(f_es_vacio(ls_n_remesa) or ls_n_remesa_old = '-1') then
	// Hay que hacer la contabilizacion de la remesa anterior puesto que era la ultima antes de salir del bucle y faltar$$HEX2$$e1002000$$ENDHEX$$el contraasiento
	// Total: al debe del banco
		g_apunte.id_interno = ls_n_remesa
		g_apunte.n_doc = ls_n_remesa
		g_apunte.t_doc = tipo_documento_remesa
		g_apunte.nif = ''
		g_apunte.nombre = ''
		wf_crear_apunte(ldt_fecha_cobro, ls_cta_contable_banco, 'Rem. '+ ls_n_remesa, total_remesa, 0, '', '')
		i_asiento_general++ 
	end if
end if

end event

event csd_cobros_simples();long 		fila_cobro
string		ls_concepto_cobro, ls_concepto, ls_n_plazo, ls_cuenta_cobro, ls_cta_contable_banco_cobro, ls_banco, ls_hay_ingreso
string		id_cobro_multiple, ls_forma_pago, ls_pagado, ls_cuenta_contrapartida, ls_cuenta_col_pa, ls_cta_puente_pa, ls_concepto_obs_fact
string		ls_tipo_factura, ls_orden_apunte, ls_nif, ls_nombre, ls_n_expedi, ls_n_visado, ls_n_registro, ls_cuenta_irpf, ls_concepto_irpf
double	ld_total_cobro, ld_subtotal_fact, ld_importe_reten
datetime	ldt_fecha_cobro, ldt_fecha_fact

is_concepto_base = ''

FOR fila_cobro = 1 TO idw_cobros.RowCount()
	//SCP-427 Verificamos que la fecha del cobro pertenece al ejercicio actual.
		if string(year(date(idw_cobros.GetItemDateTime(fila_cobro, 'csi_cobros_f_pago'))))<>g_ejercicio then 
			if g_conta_cobros_ejercicio_noactual = 'N' then continue //scp-2123
		end if

	// Se valida para evitar apuntes duplicados
	if idw_cobros.getitemstring(fila_cobro,'csi_cobros_contabilizado')= 'S' then continue
	id_cobro_multiple 	= idw_cobros.getitemstring(fila_cobro, 'csi_cobros_id_cobro_multiple')
	if not f_es_vacio(idw_cobros.getitemstring(fila_cobro, 'n_remesa_real'))  then continue //SE VALIDA QUE NO TENGA REMESAS
		
	id_factura			= idw_cobros.getitemstring(fila_cobro, 'id_factura')
	ls_forma_pago 		= upper(idw_cobros.getitemstring(fila_cobro, 'csi_cobros_forma_pago'))
	ls_pagado 			= idw_cobros.getitemstring(fila_cobro, 'csi_cobros_pagado')
	ld_total_cobro		= idw_cobros.getitemNumber(fila_cobro, 'csi_cobros_importe')
	ls_banco 			= idw_cobros.getitemstring(fila_cobro, 'csi_cobros_banco')
	ldt_fecha_cobro		= datetime(date(idw_cobros.GetItemDateTime(fila_cobro, 'csi_cobros_f_pago')), time("00:00:00"))
	ldt_fecha_fact		= datetime(date(idw_cobros.GetItemDateTime(fila_cobro, 'fecha')), time("00:00:00"))
	ld_subtotal_fact		= idw_cobros.GetItemDecimal(fila_cobro, 'subtotal') + idw_cobros.GetItemDecimal(fila_cobro, 'iva')
	ls_concepto_obs_fact = f_factura_observaciones_text(id_factura)
	ls_tipo_factura		= idw_cobros.getitemstring(fila_cobro, 'tipo_factura')
	is_n_factura			= idw_cobros.getitemstring(fila_cobro, 'n_fact')
	ls_orden_apunte	= idw_cobros.getitemstring(fila_cobro, 'orden_apunte')
	ls_nif					= idw_cobros.getitemstring(fila_cobro, 'nif')
	ls_nombre			= idw_cobros.getitemstring(fila_cobro, 'nombre')
	ls_n_expedi 		= idw_cobros.GetItemString(fila_cobro,'expedientes_n_expedi')+'-'+idw_cobros.GetItemString(fila_cobro,'fases_fase')
	ls_n_visado 		= idw_cobros.GetItemString(fila_cobro,'fases_archivo_real')
	id_fase				= idw_cobros.GetItemString(fila_cobro,'id_fase')
	id_minuta			= idw_cobros.GetItemString(fila_cobro,'id_minuta')
	
	///***SCP-901. Alexis. 24/01/2011***///
	if not f_es_vacio(id_minuta) then
		ls_n_registro 		= f_dame_n_reg (id_minuta)
		else 	
		ls_n_registro 		= f_dame_n_reg (f_minutas_id_fase(id_fase))	
	end if
	
	if ls_tipo_factura = '04' then
		id_col  				= idw_cobros.GetItemString(fila_cobro,'emisor')
	else
		id_col					= idw_cobros.GetItemString(fila_cobro,'id_persona')
	end if
	
	// Si verifica si el tipo de forma de pago tenga Ingreso 
	ls_hay_ingreso 					   = wf_hay_ingreso_formapago(ls_forma_pago)
	ls_cta_contable_banco_cobro = wf_cuenta_contable_banco(ls_banco)
	
	if ls_forma_pago = 'CP' then ls_cta_contable_banco_cobro = is_cuenta_cp
	
	is_concepto_base = ''
	/* SE RELLENA LA ESTRUCTURA DE APUNTES */
	g_apunte.n_apunte 		= '00000'
	g_apunte.n_doc			= is_n_factura
	g_apunte.fecha				= datetime(date(ldt_fecha_fact), time("00:00:00"))
	g_apunte.t_asiento 		= g_t_asiento_apuntes_automaticos
	g_apunte.id_interno 		= id_factura
	g_apunte.centro			= idw_cobros.GetItemString(fila_cobro,'centro') // El tipo de documento deber$$HEX1$$ed00$$ENDHEX$$a ir vinculado a la serie y al concepto, tomando preferentemente este $$HEX1$$fa00$$ENDHEX$$ltimo.
	if f_es_vacio(g_apunte.centro) then g_apunte.centro = g_centro_por_defecto
	g_apunte.proyecto			= g_explotacion_por_defecto
	g_apunte.nif 				= ls_nif
	g_apunte.nombre 			= ls_nombre
	g_apunte.orden_apunte  	= ls_orden_apunte
	g_apunte.diario 			= g_sica_diario.facts_emitidas_general
	g_apunte.n_asiento 		= RightA('0000000' + trim(string(i_asiento_general)),7)
	
	
	/**/
	// SE OBTIENE EL CONCEPTO
	if not f_es_vacio(g_conta.concepto_exp)  then is_concepto_base = g_conta.concepto_exp +' ' + ls_n_expedi
	
	///*** SCP-901. Alexis. 25/01/2011. Se introduce premisa por la cual s$$HEX1$$f300$$ENDHEX$$lo si no est$$HEX2$$e1002000$$ENDHEX$$seleccionada la opci$$HEX1$$f300$$ENDHEX$$n de que s$$HEX1$$f300$$ENDHEX$$lo se muestre n$$HEX1$$fa00$$ENDHEX$$m. de registro, se pueda mostra el n$$HEX1$$fa00$$ENDHEX$$m de visado. ***///  
	///*** SCP-1644.Alexis. 04/08/2011. Se introducen cambios para poder identificar por el n$$HEX2$$ba002000$$ENDHEX$$de expediente. ***///
	/*if not (ib_concepto_solo_num_reg) and not f_es_vacio(ls_n_visado) and ls_n_visado <> '' then 
		is_concepto_base = 'V$$HEX2$$ba002000$$ENDHEX$$' + ls_n_visado
	else	
		is_concepto_base = 'N$$HEX1$$ba00$$ENDHEX$$Reg. ' + ls_n_registro
	end if	*/
	choose case is_concepto_solo_num_reg
		case 'R'
			is_concepto_base = 'N$$HEX1$$ba00$$ENDHEX$$Reg. '+ls_n_registro	
		case 'E'
			is_concepto_base = 'N$$HEX2$$ba002000$$ENDHEX$$Exp. ' + ls_n_expedi
			//is_concepto_base = 
		case'V'
			if not f_es_vacio(ls_n_visado) then 
				is_concepto_base = 'V$$HEX2$$ba002000$$ENDHEX$$' + ls_n_visado
			else 
				is_concepto_base = 'N$$HEX1$$ba00$$ENDHEX$$Reg. '+ls_n_registro	
			end if 
	end choose
			
	// Le incrementamos al concepto base con el cliente
	
	is_concepto_base			= is_concepto_base + ' ' + ls_nombre
	ls_concepto					= is_concepto_base
	
	if f_es_vacio(id_fase) and f_es_vacio(id_minuta) then
		ls_concepto = is_asunto //asunto de la factura
		if f_es_vacio(ls_concepto) then ls_concepto= ls_concepto_obs_fact
		if f_es_vacio(ls_concepto) then ls_concepto = is_n_factura
//	else
//		ls_concepto = is_concepto_base
	end if
		if ls_forma_pago = 'CP' then
			ls_cta_contable_banco_cobro = is_cuenta_cp
			ls_concepto_cobro = LeftA('Pago Fact. '+is_n_factura, 57)
		else
			ls_concepto_cobro = LeftA('Ing ' + ls_concepto,57)
			end if
	
	// Si el pago es fraccionado indicamos el plazo correspondiente
	if lower(idw_cobros.describe( 'n_plazo.name')) = 'n_plazo' then ls_n_plazo = idw_cobros.getitemstring(fila_cobro, 'n_plazo')
	if not f_es_vacio(ls_n_plazo) then ls_concepto_cobro += '(Plazo ' + ls_n_plazo + '$$HEX1$$ba00$$ENDHEX$$)'
	if ls_forma_pago = g_formas_pago.domiciliacion then ls_concepto_cobro = LeftA('Dom ' + ls_concepto,57)
	// SE OBTIENE LAS CUENTAS
	is_cuenta_cp = f_dame_cuenta_col(id_col,'CP')
	is_cuenta_col = f_dame_cuenta_col(id_col,'P')	// personal / honorarios	
		
	choose case  ls_tipo_factura 
			case  '04' 
			if ls_forma_pago=  g_formas_pago.pendientes_abono  then 
				ls_cuenta_col_pa = f_dame_cuenta_col(id_col,'A')
				ls_cta_puente_pa = g_cuenta_puente_pendiente_abono_hon
			end if
			case '02'
				is_cuenta_col = ''
				select cuenta_contable into :is_cuenta_col from clientes where id_cliente = :id_col;
				if  f_es_vacio(is_cuenta_col)  and g_conta.crear_cuentas_clientes_terceros = 'S' then
					is_cuenta_col = f_cuenta_contable_defecto_cli_provs('C',id_col)
				elseif f_es_vacio(is_cuenta_col) then
					is_cuenta_col = g_conta.cuenta_clientes_general
				end if
				ls_cta_puente_pa = g_cuenta_puente_pendiente_abono_dv
			case '03' //Puesto el 050808 Yexa
				is_cuenta_col =  f_dame_cuenta_col(id_col,'G') // Se asigna la cuenta de gasto
				// Se comprueba si la cuenta de gasto y la cuenta de honorario son diferentes
				// Solo para el caso de forma de pago cargo en cuenta 
				if ls_forma_pago = 'CA'  and is_cuenta_col <>  f_dame_cuenta_col(id_col,'P') then ls_cta_contable_banco_cobro =  f_dame_cuenta_col(id_col,'P')
		end choose
		

		// SE GENERAN LOS APUNTES
		if  ls_tipo_factura  <> '04' then
			choose case ls_forma_pago
					case g_formas_pago.transferencia
								g_apunte.t_doc = g_sica_t_doc.transferencia
					case g_formas_pago.talon
								g_apunte.t_doc = g_sica_t_doc.talon
					case else
								g_apunte.t_doc = g_sica_t_doc.generico
			end choose
		end if
		
		if ls_hay_ingreso = 'S' then
		if ls_pagado = 'S' then	
			if not f_es_vacio(idw_cobros.getitemstring(fila_cobro, 'n_remesa_real'))  then continue //SE VALIDA QUE NO TENGA REMESAS
			idw_cobros.setitem(fila_cobro, 'csi_cobros_f_contabilizado',ldt_fecha_cobro )
			idw_cobros.setitem(fila_cobro, 'csi_cobros_contabilizado','S' )
			choose case ls_forma_pago
					
				case g_formas_pago.pendientes_abono
					// Apuntes Cuenta Pendiente de Abono
					//Haber
					if ls_tipo_factura = '04' then
						wf_crear_apunte(idt_fecha_fact, is_cuenta_col, is_concepto_base, 0, ld_subtotal_fact, is_orden_apunte,'' )
					end if
					//Debe
					wf_crear_apunte(idt_fecha_fact, ls_cta_puente_pa, is_concepto_base,  ld_subtotal_fact, 0 , is_orden_apunte,'' )
					
					//Apunte por el Haber
					wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_cobro, 0, ld_subtotal_fact, is_orden_apunte,'' )
					//Total : Apunte por el debe al banco
					wf_crear_apunte(ldt_fecha_cobro, ls_cta_contable_banco_cobro, is_concepto_base,  ld_total_cobro,0, is_orden_apunte, '')
					
					//*** COAATZ-23 Se pasa la creaci$$HEX2$$f3002000$$ENDHEX$$de los apuntes del IRPF desde la contabilizaci$$HEX1$$f300$$ENDHEX$$n de facturas a la de los cobros de las facturas con forma de pago "EXPEDIENTES PTES. DE ABONO".
					//ld_importe_reten = idw_facturas.GetItemNumber(i,'importe_reten')
					
							select importe_reten into :ld_importe_reten from csi_facturas_emitidas where id_factura =:id_factura;
							
							ls_concepto_irpf = LeftA(g_conta.concepto_irpf + ' ' + is_concepto_base,57)						// Concepto IRPF 
							
							is_cuenta_ret = f_dame_cuenta_col(id_col,'R')	// ret. vol
							if ld_importe_reten <> 0 then ls_cuenta_irpf = is_cuenta_ret
							
							if (not (ib_resumida and ib_aglutinar_irpf)) or ((ib_resumida and ib_aglutinar_irpf) and ls_cuenta_irpf <> is_cuenta_col ) then
								if not ib_aglutinar_irpf then 	
									wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_irpf,ld_importe_reten,0, is_orden_apunte, '')
								end if
							else
								//Apunte por el debe
								if not ib_aglutinar_irpf then  
									wf_crear_apunte(idt_fecha_fact, ls_cuenta_irpf, ls_concepto_irpf, ld_importe_reten, 0,  is_orden_apunte, '')
								end if
							end if
					 //**** FIN COAATZ-23****//
					
				case else
//					if ls_forma_pago = 'CP' then is concepto_base 
					if ls_tipo_factura <> '04' then
						//Apunte por el Haber
						wf_crear_apunte(ldt_fecha_cobro, is_cuenta_col, ls_concepto_cobro, 0, ld_total_cobro, is_orden_apunte,ls_cuenta_cobro )
					end if
						//Apunte por el  Debe
					wf_crear_apunte(ldt_fecha_cobro, ls_cta_contable_banco_cobro,is_concepto_base,  ld_total_cobro,0, is_orden_apunte, is_cuenta_col)
			end choose
			i_asiento_general++
			
		else
			if ls_forma_pago <> g_formas_pago.pendientes_abono then
				idw_cobros.setitem(fila_cobro, 'csi_cobros_f_contabilizado',ldt_fecha_cobro )
				idw_cobros.setitem(fila_cobro, 'csi_cobros_contabilizado','S' )
			end if
			
		end if
	end if
		
	
		
	NEXT // Cobros de factura (fila_cobro)
end event

event csd_cobros_multiples();//// 1.-  CM->  Facturas
string 		ls_hay_ingreso, ls_tipo_documento_cm, id_cobro_multiple, ls_formapago, ls_banco, ls_concepto, ls_cta_contable_banco
string			n_expedi, n_visado, ls_orden_apunte, id_cobro_multipl_ant, ls_pagador, ls_tipo_factura, ls_cuenta_col
string 		ls_nif, ls_nombre, cuenta_contable, ls_concepto_cobro, id_cobro_multiple_old, ls_concepto_descuadre
int				i, fila_cobro, ll_found, j, k, ll, z
double 		ld_total, importe_cobro, total_factura, ld_descuadre, ld_dif, j_total
datetime		ldt_fecha_pago
string id_factura_old , jid_factura, jtipo_fact
string jn_col, jid_col, cta_col
datastore ds_fact_cobros

ds_fact_cobros = create datastore
ds_fact_cobros.dataObject = 'ds_facturas_cobros_multip'
ds_fact_cobros.settransobject( SQLCA)
u_dw			dw_temp 


id_cobro_multipl_ant = 'zz'

// Validamos de que existan datos que procesar
if idw_cobros_multiples.rowcount() <= 0 then return

	//Se obtiene el tipo de documento de cobros multiples
	ls_tipo_documento_cm = g_sica_t_doc.cobros_multiples
	// Se valida que el la tipo_documento_cm no este vacio
	if f_es_vacio(ls_tipo_documento_cm) then ls_tipo_documento_cm = 'CM'

	dw_temp = idw_cobros_multiples

	for i = 1 to idw_cobros_multiples.rowcount()
		k = g_conta.row
		// Filtramos el dw de cobros para la factura concreta
	idw_cobros_multiples.setfilter(" csi_facturas_emitidas.id_factura='"+id_factura+"'")
	idw_cobros_multiples.filter()

		if  i > 	idw_cobros_multiples.rowcount() then continue
		// Se obtienen los datos necesarios para generar los apuntes
		id_cobro_multiple 	= idw_cobros_multiples.getitemstring(i,'csi_cobros_multiples_id_cobro_multiple')
		ls_formapago 		= upper(idw_cobros_multiples.getitemstring(i, 'csi_cobros_multiples_forma_pago'))
		ld_total	 			= idw_cobros_multiples.getitemNumber(i, 'csi_cobros_multiples_importe')
		ls_banco  			= idw_cobros_multiples.getitemstring(i, 'csi_cobros_multiples_banco')
		ls_concepto 			= idw_cobros_multiples.getitemstring(i, 'lista_fact')//'EXP(' +idw_cobros_multiples.getitemstring(i, 'csi_cobros_multiples_expediente') +') '//+idw_cobros_multiples.getitemstring(i, 'csi_cobros_multiples_pagador')
		ldt_fecha_pago 	= idw_cobros_multiples.GetitemDatetime(i, 'csi_cobros_multiples_fecha')
	//	ls_orden_apunte	= idw_cobros_multiples.Getitemstring(i, 'orden_apunte')
		ls_pagador			= idw_cobros_multiples.Getitemstring(i, 'csi_cobros_multiples_pagador')
	
		if id_cobro_multipl_ant = id_cobro_multiple then continue
		// Actualizamos la variable pa que vaya bien
		id_cobro_multipl_ant = id_cobro_multiple
		
		// Si verifica si el tipo de forma de pago tenga Ingreso 
		ls_hay_ingreso 				= wf_hay_ingreso_formapago(ls_formapago)
		ls_cta_contable_banco 	= wf_cuenta_contable_banco(ls_banco)
	
	//SCP-427 Verificamos que la fecha del cobro pertenece al ejercicio actual
		if string(year(date(idw_cobros_multiples.GetItemDateTime(i, 'csi_cobros_multiples_fecha'))))<>g_ejercicio then 
			if g_conta_cobros_ejercicio_noactual = 'N' then continue //scp-2123
		end if
		
		// SE OBTIENE EL CONCEPTO
			ls_concepto_cobro = LeftA('Ing CC ' + ls_concepto,57)
			
			choose case ls_formapago
					case g_formas_pago.transferencia
								g_apunte.t_doc = g_sica_t_doc.transferencia
					case g_formas_pago.talon
								g_apunte.t_doc = g_sica_t_doc.talon
					case g_formas_pago.metalico 
							 ls_concepto_cobro = LeftA('Efec. ' + ls_concepto,57)
							 g_apunte.t_doc = g_sica_t_doc.generico
					case else
								g_apunte.t_doc = g_sica_t_doc.generico
			end choose
	
		if ls_hay_ingreso = 'S' then
		
			// Se busca la cuenta del colegiado pagador seg$$HEX1$$fa00$$ENDHEX$$n el tipo de factura generada
			
			if  is_tipo_factura = '04' then
				ls_cuenta_col = g_cobros_multiples_cuenta_puente
			end if

			// Crea el apunte por el Debe
			g_apunte.n_doc = id_cobro_multiple
			g_apunte.id_interno = id_cobro_multiple
			// Se obtiene el nif  a partir del id_pagador  y el tipo_pagador 1:colegiado
			if idw_cobros_multiples.getitemstring(i, 'csi_cobros_multiples_tipo_pagador') <> '1' then
				ls_nif = f_dame_nif( idw_cobros_multiples.getitemstring(i, 'csi_cobros_multiples_id_pagador'))
			else
				ls_nif = f_devuelve_nif( idw_cobros_multiples.getitemstring(i, 'csi_cobros_multiples_id_pagador'))
			end if
			g_apunte.nif = ls_nif // nif del pagador
			g_apunte.nombre = ls_pagador//nombre 			
		
			if idw_cobros_multiples.getitemstring(i, 'csi_cobros_multiples_contabilizado') <> 'S' then
				if g_asiento_unico_cc = 'N' then 
						
					//\\//\\//\\//\\//\\//\\//\\//\\=======----PORRERO 01/02/10-------======//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
					ds_fact_cobros.retrieve( id_cobro_multiple)
					for z = 1 to ds_fact_cobros.rowcount( )
						jtipo_fact = ds_fact_cobros.getItemString(z,'csi_facturas_emitidas_tipo_factura')
						jid_factura = ds_fact_cobros.getItemString(z,'csi_facturas_emitidas_id_factura')
						jn_col = ds_fact_cobros.getItemString(z,'csi_facturas_emitidas_n_col')
						j_total = ds_fact_cobros.getItemNumber( z, 'csi_facturas_emitidas_total')
						if jtipo_fact = '02' then // Si es colegio-> Cliente cogemos las cuenta del cliente
							cta_col = f_clientes_cuenta_contable(jid_col)
						else //Colegio -> Colegiado y Honorarios
							SELECT id_colegiado into :jid_col from colegiados where n_colegiado = :jn_col;
							cta_col = f_dame_cuenta_col(jid_col,'G')
						end if
						string condicion
						if jtipo_fact <> '04' then //Si la factura es de honorarios no se hace el apunte.
							condicion="procesado='S' and csi_cobros_multiples_id_cobro_multiple<>'"	+idw_cobros_multiples.GetItemString(i,'csi_cobros_multiples_id_cobro_multiple')+"'"
							if idw_cobros_multiples.Find(condicion,1,idw_cobros_multiples.rowcount())<=0 then
								wf_crear_apunte(ldt_fecha_pago, cta_col, 'Ing. CC '+ ls_concepto, 0,  j_total,is_orden_apunte, ls_cta_contable_banco)
								idw_cobros_multiples.SetItem(i,'procesado','S')
							end if
						end if
					next
					//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
					
				end if
//				
				//apunte por el debe
				wf_crear_apunte(ldt_fecha_pago, ls_cta_contable_banco, "CC "+ls_concepto, ld_total, 0, is_orden_apunte, '')

				// Si existe diferencia se crea el apunte de descuadre
				ld_dif =  idw_cobros_multiples.getitemnumber(i,'diferencia')
				if ld_dif <> 0 then
			//	if idw_cobros_multiples.getitemdecimal(i,'diferencia')<> 0 then
					g_apunte.n_doc = ''
					g_apunte.t_doc = g_t_doc_descuadre
					ls_concepto_descuadre = g_concepto_descuadre_caja + idw_cobros_multiples.getitemstring(i, 'lista_fact')
						if  idw_cobros_multiples.getitemnumber(i,'diferencia') > 0 then
								//apunte por el Haber
								wf_crear_apunte(ldt_fecha_pago, g_cuenta_puente_descuadre, ls_concepto_descuadre, ld_dif , 0, is_orden_apunte,'')
							else
								//apunte por el debe
								wf_crear_apunte(ldt_fecha_pago, g_cuenta_puente_descuadre, ls_concepto_descuadre, 0,ld_dif ,  is_orden_apunte, '' )
							end if
				end if
				
				int l
				boolean b_continue = true
				id_factura_old=id_factura
				idw_cobros_multiples.setredraw(false)
				idw_cobros_multiples.setfilter("")
				idw_cobros_multiples.filter()
				idw_cobros_multiples.setfilter("empresa = '"+g_empresa+ "'")
				idw_cobros_multiples.filter()
				idw_cobros_multiples.setredraw(true)
				for j= 1 to dw_temp.rowcount()
					if  dw_temp.getitemstring(j,'csi_cobros_multiples_id_cobro_multiple') = id_cobro_multiple then 
						
						idw_cobros_multiples.SetItem(j, 'csi_cobros_multiples_f_contabilizado',ldt_fecha_pago)
						idw_cobros_multiples.SetItem(j, 'csi_cobros_multiples_contabilizado','S')
	
						
						for l= 1 to k
								if g_conta.id_factura[l]  =  dw_temp.getitemstring(j,'id_factura') then 
									b_continue = false
									continue
								else
									b_continue = true
									
								end if
						next
						if  b_continue then 
							k++
							g_conta.id_factura[k] = dw_temp.getitemstring(j,'id_factura')
							g_conta.n_asiento[k]	= g_apunte.n_asiento 
												
						end if
					
					end if
				next
				g_conta.row = k
			end if
	
				
		end if
		
	next
	idw_cobros_multiples.setredraw(false)
	idw_cobros_multiples.setfilter("")
	idw_cobros_multiples.filter()
	idw_cobros_multiples.setfilter("empresa = '"+ g_empresa + "'")
	idw_cobros_multiples.filter()
	idw_cobros_multiples.setredraw(true)

end event

event csd_cobros_multiples_fact_contabil();//// 1.-  CM->  Facturas
string 		ls_hay_ingreso, ls_tipo_documento_cm, id_cobro_multiple, ls_formapago, ls_banco, ls_concepto, ls_cta_contable_banco
string			n_expedi, n_visado, ls_orden_apunte, id_cobro_multipl_ant, ls_pagador, ls_tipo_factura, ls_cuenta_col
string 		ls_nif, ls_nombre, cuenta_contable, ls_concepto_cobro, id_cobro_multiple_old, ls_concepto_descuadre
int				i, fila_cobro, ll_found, j, k, ll, z
double 		ld_total, importe_cobro, total_factura, ld_descuadre, ld_dif, j_total
datetime		ldt_fecha_pago
string id_factura_old , jid_factura, jtipo_fact
string jn_col, jid_col, cta_col, condicion
datastore ds_fact_cobros

ds_fact_cobros = create datastore
ds_fact_cobros.dataObject = 'ds_facturas_cobros_multip'
ds_fact_cobros.settransobject( SQLCA)
u_dw			dw_temp 

g_apunte.n_asiento = right('0000000' + trim(string(i_asiento_general)),7)
g_apunte.diario 			= g_sica_diario.facts_emitidas_general
g_apunte.proyecto			= g_explotacion_por_defecto
g_apunte.n_apunte = '00000'
// POnemos el centro por defecto
g_apunte.centro = g_centro_por_defecto
g_apunte.base_imp = 0
g_apunte.nif = ''
g_apunte.nombre = ''

id_cobro_multipl_ant = 'zz'
idw_cobros_mult_facturas_contab.setfilter("empresa = '"+g_empresa+ "'")
idw_cobros_mult_facturas_contab.filter()
// Validamos de que existan datos que procesar
if idw_cobros_mult_facturas_contab.rowcount() <= 0 then return

	//Se obtiene el tipo de documento de cobros multiples
	ls_tipo_documento_cm = g_sica_t_doc.cobros_multiples
	// Se valida que el la tipo_documento_cm no este vacio
	if f_es_vacio(ls_tipo_documento_cm) then ls_tipo_documento_cm = 'CM'

	dw_temp = idw_cobros_mult_facturas_contab

	for i = 1 to idw_cobros_mult_facturas_contab.rowcount()
	
		// Se obtienen los datos necesarios para generar los apuntes
		id_cobro_multiple 	= idw_cobros_mult_facturas_contab.getitemstring(i,'csi_cobros_multiples_id_cobro_multiple')
		
		// SCP-2020
		condicion="csi_cobros_multiples_id_cobro_multiple='"+id_cobro_multiple+"' AND csi_cobros_multiples_contabilizado='S'"
		if idw_cobros_multiples.Find(condicion,1,idw_cobros_multiples.rowcount())>0 then CONTINUE 
		
		ls_formapago 		= upper(idw_cobros_mult_facturas_contab.getitemstring(i, 'csi_cobros_multiples_forma_pago'))
		ld_total	 			= idw_cobros_mult_facturas_contab.getitemNumber(i, 'csi_cobros_multiples_importe')
		ls_banco  			= idw_cobros_mult_facturas_contab.getitemstring(i, 'csi_cobros_multiples_banco')
		ls_concepto 			= idw_cobros_mult_facturas_contab.getitemstring(i, 'lista_fact')
		ldt_fecha_pago 	= idw_cobros_mult_facturas_contab.GetitemDatetime(i, 'csi_cobros_multiples_fecha')
		ls_pagador			= idw_cobros_mult_facturas_contab.Getitemstring(i, 'csi_cobros_multiples_pagador')
	
		//SCP-427 Verificamos que la fecha del cobro pertenece al ejercicio actual
		if string(year(date(idw_cobros_mult_facturas_contab.GetItemDateTime(i, 'csi_cobros_multiples_fecha'))))<>g_ejercicio then 
			if g_conta_cobros_ejercicio_noactual = 'N' then continue //scp-2123
		end if
		
	
		// Si verifica si el tipo de forma de pago tenga Ingreso 
		ls_hay_ingreso 				= wf_hay_ingreso_formapago(ls_formapago)
		ls_cta_contable_banco 	= wf_cuenta_contable_banco(ls_banco)

		if id_cobro_multipl_ant = id_cobro_multiple then continue
		// Actualizamos la variable pa que vaya bien
		id_cobro_multipl_ant = id_cobro_multiple
		
		// SE OBTIENE EL CONCEPTO
		ls_concepto_cobro = LeftA('Ing CC ' + ls_concepto,57)
			
		choose case ls_formapago
			case g_formas_pago.transferencia
				g_apunte.t_doc = g_sica_t_doc.transferencia
			case g_formas_pago.talon
				g_apunte.t_doc = g_sica_t_doc.talon
			case g_formas_pago.metalico 
				ls_concepto_cobro = LeftA('Efec. ' + ls_concepto,57)
				g_apunte.t_doc = g_sica_t_doc.generico
			case else
				g_apunte.t_doc = g_sica_t_doc.generico
		end choose
	
		if ls_hay_ingreso = 'S' then
			// Se busca la cuenta del colegiado pagador seg$$HEX1$$fa00$$ENDHEX$$n el tipo de factura generada
			
			//if  is_tipo_factura = '04' then ls_cuenta_col = g_cobros_multiples_cuenta_puente

			// Crea el apunte por el Debe
			g_apunte.n_doc = id_cobro_multiple
			g_apunte.id_interno = id_cobro_multiple
			// Se obtiene el nif  a partir del id_pagador  y el tipo_pagador 1:colegiado
			if idw_cobros_mult_facturas_contab.getitemstring(i, 'csi_cobros_multiples_tipo_pagador') <> '1' then
				ls_nif = f_dame_nif( idw_cobros_mult_facturas_contab.getitemstring(i, 'csi_cobros_multiples_id_pagador'))
			else
				ls_nif = f_devuelve_nif( idw_cobros_mult_facturas_contab.getitemstring(i, 'csi_cobros_multiples_id_pagador'))
			end if
			g_apunte.nif = ls_nif // nif del pagador
			g_apunte.nombre = ls_pagador//nombre 			
		
			if idw_cobros_mult_facturas_contab.getitemstring(i, 'csi_cobros_multiples_contabilizado') <> 'S' then
				if g_asiento_unico_cc = 'N' then 
					//wf_crear_apunte(ldt_fecha_pago, is_cuenta_col, 'Ing. CC '+ ls_concepto, 0,  ld_total,is_orden_apunte, ls_cta_contable_banco)
					
					ds_fact_cobros.retrieve(id_cobro_multiple)
					for z = 1 to ds_fact_cobros.rowcount( )
						jtipo_fact = ds_fact_cobros.getItemString(z,'csi_facturas_emitidas_tipo_factura')
						jid_factura = ds_fact_cobros.getItemString(z,'csi_facturas_emitidas_id_factura')
						jn_col = ds_fact_cobros.getItemString(z,'csi_facturas_emitidas_n_col')
						j_total = ds_fact_cobros.getItemNumber( z, 'csi_facturas_emitidas_total')
						if jtipo_fact = '02' then // Si es colegio-> Cliente cogemos las cuenta del cliente
							cta_col = f_clientes_cuenta_contable(jid_col)
						else //Colegio -> Colegiado y Honorarios
							SELECT id_colegiado into :jid_col from colegiados where n_colegiado = :jn_col;
							cta_col = f_dame_cuenta_col(jid_col,'G')
						end if
						if jtipo_fact <> '04' then //Si la factura es de honorarios no se hace el apunte.
						///*** SCP-1741. Alexis. 27/09/2010. Se comenta la condici$$HEX1$$f300$$ENDHEX$$n y el consiguiente marcado ya produc$$HEX1$$ed00$$ENDHEX$$an un error en el procesado. Se soluciona comentando el c$$HEX1$$f300$$ENDHEX$$digo y ordenando el dw dw_cobros_mult_facturas_contab ***///
//							condicion="procesado='S' and csi_cobros_multiples_id_cobro_multiple<>'"	+idw_cobros_mult_facturas_contab.GetItemString(i,'csi_cobros_multiples_id_cobro_multiple')+"'"
//							if idw_cobros_mult_facturas_contab.Find(condicion,1,idw_cobros_mult_facturas_contab.rowcount())<=0 then
								wf_crear_apunte(ldt_fecha_pago, cta_col, 'Ing. CC '+ ls_concepto, 0,  j_total,is_orden_apunte, ls_cta_contable_banco)
//								idw_cobros_mult_facturas_contab.SetItem(i,'procesado','S')
//							end if
						end if
					next
					
				end if
				//apunte por el debe
				wf_crear_apunte(ldt_fecha_pago, ls_cta_contable_banco, "CC "+ls_concepto, ld_total, 0, is_orden_apunte, '')

				// Si existe diferencia se crea el apunte de descuadre
				ld_dif =  idw_cobros_mult_facturas_contab.getitemnumber(i,'diferencia')
				if ld_dif <> 0 then
					g_apunte.n_doc = ''
					g_apunte.t_doc = g_t_doc_descuadre
					ls_concepto_descuadre = g_concepto_descuadre_caja + idw_cobros_mult_facturas_contab.getitemstring(i, 'lista_fact')
					if  idw_cobros_mult_facturas_contab.getitemnumber(i,'diferencia') > 0 then
						//apunte por el Haber
						wf_crear_apunte(ldt_fecha_pago, g_cuenta_puente_descuadre, ls_concepto_descuadre, ld_dif , 0, is_orden_apunte,'')
					else
						//apunte por el debe
						wf_crear_apunte(ldt_fecha_pago, g_cuenta_puente_descuadre, ls_concepto_descuadre, 0,ld_dif ,  is_orden_apunte, '' )
					end if
				end if
				
			
				idw_cobros_mult_facturas_contab.SetItem(i, 'csi_cobros_multiples_f_contabilizado',ldt_fecha_pago)
				idw_cobros_mult_facturas_contab.SetItem(i, 'csi_cobros_multiples_contabilizado','S')
	

			end if
		end if
			i_asiento_general++ 
	next
end event

public subroutine wf_preproceso ();//Revisi$$HEX1$$f300$$ENDHEX$$n datos generales contabilidad
if f_es_vacio(g_conta.concepto_exp) then g_conta.concepto_exp = 'Exp'
if f_es_vacio(g_conta.concepto_rv) then g_conta.concepto_rv = 'RV'
if f_es_vacio(g_conta.cuenta_clientes_general) then g_conta.cuenta_clientes_general = '4400000'
if f_es_vacio(g_conta.ret_vol) then g_conta.ret_vol = 'C'
if f_es_vacio(g_prefijo_arqui) then g_prefijo_arqui = '430'
if f_es_vacio(g_prefijo_arqui_iva) then g_prefijo_arqui_iva = g_prefijo_arqui
if f_es_vacio(g_prefijo_arqui_rf) then g_prefijo_arqui_rf = g_prefijo_arqui

end subroutine

public function long wf_verificar_facturas ();long i, fila_cobro, fila_cobro_multiple, j
boolean b_error = false
long retorno = 1
long opcion
boolean error_cobro=false
string mensaje,n_fact, msg
long k=1

// Modificado Ricardo 2005-04-28
// Miramos si todas las facturas y dem$$HEX1$$e100$$ENDHEX$$s est$$HEX1$$e100$$ENDHEX$$n dentro del ejercicio actual
st_progreso.text = 'Buscando si hay facturas de otros ejercicios'
st_progreso.visible = true

// Miramos las facturas
for i = 1 to idw_facturas.RowCount()
	// Le decimos por donde vamos
	yield()
	if string(year(date(idw_facturas.GetItemDatetime(i, 'fecha'))))<>g_ejercicio then
		Messagebox(g_titulo, "Alguna de las facturas a contabilizar no pertenece al ejercicio actual. El proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n ha sido cancelado.", stopsign!)
		b_error = true
		retorno = -1
		st_progreso.text = ''
		exit
	end if
next
// Miramos los cobros de las facturas

//SCP-427 Para los cobros normales modificamos la forma de tratar los cobros con fecha diferente al ejercicio actual
FOR fila_cobro = 1 TO idw_cobros.RowCount()
	if string(year(date(idw_cobros.GetItemDateTime(fila_cobro, 'csi_cobros_f_pago'))))<>g_ejercicio then
		error_cobro=true
		//Mostramos en un mensaje las facturas afectadas por los cobros que no pertenecen al ejercicio
		k=idw_cobros_no_ejercicio.insertrow(1)
		n_fact=idw_cobros.GetItemstring(fila_cobro, 'n_fact')
		idw_cobros_no_ejercicio.setitem(k,'numero_factura',n_fact)
	end if
NEXT
//FIN SCP-427

FOR fila_cobro = 1 TO idw_cobros_multiples.RowCount()
	if string(year(date(idw_cobros_multiples.GetItemDateTime(fila_cobro, 'csi_cobros_multiples_fecha'))))<>g_ejercicio then
		error_cobro=true
		k=idw_cobros_no_ejercicio.insertrow(1)
		n_fact=idw_cobros_multiples.GetItemstring(fila_cobro, 'n_fact')
		idw_cobros_no_ejercicio.setitem(k,'numero_factura',n_fact)
	end if
NEXT

// Miramos los cobros de facturas contabilizadas
//SCP-427
FOR fila_cobro = 1 TO idw_cobros_facturas_contabilizadas.RowCount()
	if string(year(date(idw_cobros_facturas_contabilizadas.GetItemDateTime(fila_cobro, 'csi_cobros_f_pago'))))<>g_ejercicio then
		error_cobro=true
		k=idw_cobros_no_ejercicio.insertrow(1)
		n_fact=idw_cobros_facturas_contabilizadas.GetItemstring(fila_cobro, 'n_fact')
		idw_cobros_no_ejercicio.setitem(k,'numero_factura',n_fact)
	end if
NEXT
//porrero 20/03/2010 anulo los returns porque no tienen sentido


// Miramos los cobros de facturas contabilizadas
//SCP-2123
FOR fila_cobro = 1 TO idw_cobros_mult_facturas_contab.RowCount()
	if string(year(date(idw_cobros_mult_facturas_contab.GetItemDateTime(fila_cobro, 'csi_cobros_multiples_fecha'))))<>g_ejercicio then
		error_cobro=true
		k=idw_cobros_no_ejercicio.insertrow(1)
		n_fact=idw_cobros_mult_facturas_contab.GetItemstring(fila_cobro, 'n_fact')
		idw_cobros_no_ejercicio.setitem(k,'numero_factura',n_fact)
	end if
NEXT

//porrero 20/03/2010
// Miramos las formas de pago
FOR j = 1 TO idw_facturas.RowCount()
	if isNull(idw_facturas.GetitemString(j, 'formadepago')) or f_es_vacio(idw_facturas.GetitemString(j, 'formadepago')) then
		Messagebox(g_titulo, "Existen facturas sin forma de pago asociada, se pueden producir errores en el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n.", stopsign!)
		st_progreso.text = ''
		exit
	end if		
NEXT
st_progreso.text = ''


//A$$HEX1$$f100$$ENDHEX$$adimos variable para no mostrar el mensaje para cada cobro que no pertenezca al ejercicio actual.
//Solo mostramos el mensaje al final del proceso.
if error_cobro then
	//SCP-427 Incluimos diferenciaci$$HEX1$$f300$$ENDHEX$$n para hacer coherente el mensaje con otros mensajes aparecidos.
	if b_error then
		opcion=Messagebox(g_titulo, 'Algunas de las facturas a contabilizar no pertenece al ejercicio actual,  no ser$$HEX1$$e100$$ENDHEX$$n contabilizados. El proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n ha sido cancelado.', stopsign!)
	else
		msg = 'Algunos de los cobros de facturas a contabilizar y/o contabilizadas no pertenece al ejercicio actual,'
		if g_conta_cobros_ejercicio_noactual = 'N' then 
			msg +=  'no ser$$HEX1$$e100$$ENDHEX$$n contabilizados.'
		else
			msg +=  'los cobros se contabilizaran en el ejercicio incorrecto.'
		end if
		
		opcion=Messagebox(g_titulo, msg+ cr + cr  +'Desea continuar con el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n?', Exclamation!,YESNO!)
			if opcion=2 then
				b_error = true
				retorno = -1
				st_progreso.text = ''
			end if
		end if
	//Siempre damos opci$$HEX1$$f300$$ENDHEX$$n a imprimir las facturas afectadas por estos cobros
	opcion=MessageBox(g_titulo,'$$HEX1$$bf00$$ENDHEX$$Desea imprimir el listado con las facturas afectadas?',QUESTION!,YESNO!)
	if opcion=1 then f_opciones_impresion(idw_cobros_no_ejercicio)
end if

//FIN SCP-427

if b_error then retorno = -1 else retorno = 1
return retorno


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
f_apunte_dw(g_apunte,idw_apuntes,'E')


end subroutine

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

public function string wf_hay_ingreso_formapago (string as_tipo_pago);// Funci$$HEX1$$f300$$ENDHEX$$n: 
// Devuelve si tiene ingreso o no la forma de pago que se pasa.

string 	ls_hay_ingreso

select 	hay_ingreso 
into 	    :ls_hay_ingreso 
from 		csi_formas_de_pago 
where 	tipo_pago = :as_tipo_pago

;

return ls_hay_ingreso
end function

public function string wf_cuenta_contable_banco (string as_banco);//	Funci$$HEX1$$f300$$ENDHEX$$n: wf_cuenta_contable_banco
//  Creada: 14/05/08
//	Devuele la cuenta contable asociada al banco que se pasa por argumento

string ls_cuenta_contable

SELECT	cuenta_contable
INTO		:ls_cuenta_contable
FROM		csi_bancos
WHERE	codigo = :as_banco
and empresa=:g_empresa
;


return ls_cuenta_contable

end function

public function boolean wf_valida_campo_dw (datawindow dw_1, string as_campo);int ll_row, i
string ls_ColName
boolean lb_existe = false

ll_row = long(dw_1.Describe("DataWindow.Column.Count"))


// Aplico estilos y se muestran solo los datos obligatorios
for i= 1 to ll_row
		
		// Se obtiene el nombre de cada campo
		ls_ColName = dw_1.Describe('#'+string(i) + '.Name') 
		if  ls_ColName = as_campo then 
			lb_existe = true
			continue
		end if
	next
	
	
	return lb_existe
end function

public subroutine wf_apuntes_cobros_fact (string ls_concepto_obs_fact, datetime ldt_fecha, double ld_subtotal_fact);long 		fila_cobro
string		ls_concepto_cobro, ls_concepto, ls_n_plazo, ls_cuenta_cobro, ls_cta_contable_banco_cobro, ls_banco, ls_hay_ingreso
string		id_cobro_multiple, ls_forma_pago, ls_pagado, ls_cuenta_contrapartida, ls_cuenta_col_pa, ls_cta_puente_pa
double	ld_total_cobro
datetime	ldt_fecha_cobro



	FOR fila_cobro = 1 TO idw_cobros.RowCount()
		//SCP-427 Verificamos que la fecha del cobro pertenece al ejercicio actual.
		if string(year(date(idw_cobros.GetItemDateTime(fila_cobro, 'csi_cobros_f_pago'))))<>g_ejercicio then 
				if g_conta_cobros_ejercicio_noactual = 'N' then continue //scp-2123
		end if
		// Se valida para evitar apuntes duplicados
		if idw_cobros.getitemstring(fila_cobro,'csi_cobros_contabilizado')= 'S' then continue
		id_cobro_multiple 	= idw_cobros.getitemstring(fila_cobro, 'csi_cobros_id_cobro_multiple')
		if not f_es_vacio(idw_cobros.getitemstring(fila_cobro, 'n_remesa_real'))  then continue //SE VALIDA QUE NO TENGA REMESAS
		if not f_es_vacio(id_cobro_multiple) then 
			idw_cobros.setitem(fila_cobro, 'csi_cobros_f_contabilizado',ldt_fecha_cobro )
			idw_cobros.setitem(fila_cobro, 'csi_cobros_contabilizado','S' )
			continue //SE VALIDA QUE NO SE CUELE ALGUN COBRO MULTIPLE
		end if

		
		ls_forma_pago 		= upper(idw_cobros.getitemstring(fila_cobro, 'csi_cobros_forma_pago'))
		ls_pagado 			= idw_cobros.getitemstring(fila_cobro, 'csi_cobros_pagado')
		ld_total_cobro		= idw_cobros.getitemNumber(fila_cobro, 'csi_cobros_importe')
		ls_banco 			= idw_cobros.getitemstring(fila_cobro, 'csi_cobros_banco')
		ldt_fecha_cobro	= datetime(date(idw_cobros.GetItemDateTime(fila_cobro, 'csi_cobros_f_pago')), time("00:00:00"))

		
		// Si verifica si el tipo de forma de pago tenga Ingreso 
		ls_hay_ingreso 					   = wf_hay_ingreso_formapago(ls_forma_pago)
		ls_cta_contable_banco_cobro = wf_cuenta_contable_banco(ls_banco)
				
		// SE OBTIENE EL CONCEPTO
		if f_es_vacio(id_fase) and f_es_vacio(id_minuta) then
			ls_concepto = is_asunto //asunto de la factura
			if f_es_vacio(ls_concepto) then ls_concepto= ls_concepto_obs_fact
			if f_es_vacio(ls_concepto) then ls_concepto = is_n_factura
		else
			ls_concepto = is_concepto_base
		end if
		
		if ls_forma_pago = 'CP' then
			ls_cta_contable_banco_cobro = is_cuenta_cp
			if(f_es_vacio(is_asunto))then
				ls_concepto_cobro = LeftA('Pago Fact. '+is_n_factura, 57)
			else
				ls_concepto_cobro = is_asunto
			end if
		else
			ls_concepto_cobro = LeftA('Ing ' + ls_concepto,57)
			end if
		// Si el pago es fraccionado indicamos el plazo correspondiente
		if lower(idw_cobros.describe( 'n_plazo.name')) = 'n_plazo' then ls_n_plazo = idw_cobros.getitemstring(fila_cobro, 'n_plazo')
		if not f_es_vacio(ls_n_plazo) then ls_concepto_cobro += '(Plazo ' + ls_n_plazo + '$$HEX1$$ba00$$ENDHEX$$)'
		
		if ls_forma_pago = g_formas_pago.domiciliacion then ls_concepto_cobro = LeftA('Dom ' + ls_concepto,57)
		if ls_forma_pago = g_formas_pago.metalico then ls_concepto_cobro = LeftA('Efec. ' + ls_concepto,57)
		
		// SE OBTIENE LAS CUENTAS
		is_cuenta_cp = f_dame_cuenta_col(id_col,'CP')
		is_cuenta_col = f_dame_cuenta_col(id_col,'P')	// personal / honorarios	
		
		choose case  is_tipo_factura 
			case  '04' 
			if ls_forma_pago=  g_formas_pago.pendientes_abono  then 
				ls_cuenta_col_pa = f_dame_cuenta_col(id_col,'A')
				ls_cta_puente_pa = g_cuenta_puente_pendiente_abono_hon
			end if
			case '02'
				is_cuenta_col = ''
				select cuenta_contable into :is_cuenta_col from clientes where id_cliente = :id_col;
				if f_es_vacio(is_cuenta_col) and g_conta.crear_cuentas_clientes_terceros = 'S' then
					is_cuenta_col = f_cuenta_contable_defecto_cli_provs('C',id_col)
				elseif f_es_vacio(is_cuenta_col) then
					is_cuenta_col = g_conta.cuenta_clientes_general
				end if
				ls_cta_puente_pa = g_cuenta_puente_pendiente_abono_dv
			case '03' //Puesto el 050808 Yexa
				is_cuenta_col =  f_dame_cuenta_col(id_col,'G') // Se asigna la cuenta de gasto
				// Se comprueba si la cuenta de gasto y la cuenta de honorario son diferentes
				// Solo para el caso de forma de pago cargo en cuenta personal
				if ls_forma_pago = 'CA'  and is_cuenta_col <>  f_dame_cuenta_col(id_col,'P') then ls_cta_contable_banco_cobro =  f_dame_cuenta_col(id_col,'P')
			end choose
		

		// SE GENERAN LOS APUNTES
		if  is_tipo_factura  <> '04' then
			choose case ls_forma_pago
					case g_formas_pago.transferencia
								g_apunte.t_doc = g_sica_t_doc.transferencia
					case g_formas_pago.talon
								g_apunte.t_doc = g_sica_t_doc.talon
					case else
								g_apunte.t_doc = g_sica_t_doc.generico
			end choose
		end if
		
		if ls_hay_ingreso = 'S' then
		if ls_pagado = 'S' then	
			if not f_es_vacio(idw_cobros.getitemstring(fila_cobro, 'n_remesa_real'))  then continue //SE VALIDA QUE NO TENGA REMESAS
			idw_cobros.setitem(fila_cobro, 'csi_cobros_f_contabilizado',ldt_fecha_cobro )
			idw_cobros.setitem(fila_cobro, 'csi_cobros_contabilizado','S' )
			if   ldt_fecha_cobro<> idt_fecha_fact then
				i_asiento_general++
				g_apunte.n_asiento 		= RightA('0000000' + trim(string(i_asiento_general)),7)
				i_asiento_general++
			end if
			choose case ls_forma_pago
					
				case g_formas_pago.pendientes_abono
					// Apuntes Cuenta Pendiente de Abono
					//Haber
					if is_tipo_factura = '04' then
						wf_crear_apunte(idt_fecha_fact, is_cuenta_col, is_concepto_base, 0, ld_subtotal_fact, is_orden_apunte,'' )
					end if
					//Debe
					wf_crear_apunte(idt_fecha_fact, ls_cta_puente_pa, is_concepto_base,  ld_subtotal_fact, 0 , is_orden_apunte,'' )
					
					//Apunte por el Haber
					wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_cobro, 0, ld_subtotal_fact, is_orden_apunte,'' )
					//Total : Apunte por el debe al banco
					wf_crear_apunte(ldt_fecha_cobro, ls_cta_contable_banco_cobro, is_concepto_base,  ld_total_cobro,0, is_orden_apunte, '')
				case else
					if is_tipo_factura <> '04' then
						//Apunte por el Haber
						// /*CZA-139. Para Zaragoza solicitan que retorne al estado anterior por el cual los conceptos al colegiado y al banco estaban intercambiados. Alexis. 24/06/2010 */ //
						If g_colegio = 'COAATZ' then
							wf_crear_apunte(ldt_fecha_cobro, is_cuenta_col, ls_concepto_cobro, 0, ld_total_cobro, is_orden_apunte,ls_cuenta_cobro )
						else
							wf_crear_apunte(ldt_fecha_cobro, is_cuenta_col, is_concepto_base, 0, ld_total_cobro, is_orden_apunte,ls_cuenta_cobro )
						end if
						// /* Fin cambio CZA-139. Falta el apunte al debe justo abajo */ // 
					end if
					if idt_fecha_fact <> ldt_fecha_cobro and is_tipo_factura='04' then 
							//Apunte por el  Haber
						wf_crear_apunte(ldt_fecha_cobro, is_cuenta_col,'Ing. Fact '+is_n_factura,  0,ld_total_cobro, is_orden_apunte, ls_cta_contable_banco_cobro)
					end if
						//Apunte por el  Debe
					// /* CZA-139. Se retorna el antiguo concepto tambi$$HEX1$$e900$$ENDHEX$$n para el apunte al banco. */ //
					If g_colegio = 'COAATZ' then
						wf_crear_apunte(ldt_fecha_cobro, ls_cta_contable_banco_cobro, is_concepto_base,  ld_total_cobro,0, is_orden_apunte, is_cuenta_col)
					else 
						wf_crear_apunte(ldt_fecha_cobro, ls_cta_contable_banco_cobro,ls_concepto_cobro,  ld_total_cobro,0, is_orden_apunte, is_cuenta_col)
					end if
			end choose
			
			
		else
			if ls_forma_pago <> g_formas_pago.pendientes_abono then
				idw_cobros.setitem(fila_cobro, 'csi_cobros_f_contabilizado',ldt_fecha_cobro )
				idw_cobros.setitem(fila_cobro, 'csi_cobros_contabilizado','S' )
			end if
			
		end if
	end if
		
	
		
	NEXT // Cobros de factura (fila_cobro)
end subroutine

public subroutine wf_genera_apuntes_linea_fact (string ls_tipo_factura, string n_col, datastore ds_iva, string ls_orden_apunte);//
// variables para la contabilizacion de las lineas
String		linea_t_iva, linea_cuenta, linea_cuenta_presupuestaria, linea_proyecto, linea_concepto_conta,linea_familia, ls_concepto_linea, ls_cuenta_linea
string 	is_cuenta_ret_linea, ls_cuenta_contra_ret, ls_concepto_ret, linea_cuenta_gasto
double 	linea_subtotal, linea_iva, linea_dto,ld_linea_iva_subtotal
int			j, k
boolean es_exento

//datetime	ldt_fecha



	FOR j=1 TO ids_lineas.RowCount()
				
			// Datos b$$HEX1$$e100$$ENDHEX$$sicos
			linea_cuenta_presupuestaria 	= ids_lineas.GetItemString(j,'cuenta_presupuestaria')
			linea_concepto_conta	 			= ids_lineas.GetItemString(j,'concepto_conta')
			linea_cuenta 						= ids_lineas.GetItemString(j,'cuenta')
			linea_proyecto 						= ids_lineas.GetItemString(j,'proyecto')
			linea_familia 						= ids_lineas.GetItemString(j,'familia')
			linea_t_iva 							= ids_lineas.GetItemString(j,'t_iva')
			linea_subtotal 						= ids_lineas.GetItemNumber(j,'subtotal')
			linea_iva 							= f_redondea(ids_lineas.GetItemNumber(j,'subtotal_iva'));if isnull(linea_iva) then linea_iva = 0
			linea_dto 							= ids_lineas.GetItemNumber(j,'importe_dto')
			linea_cuenta_gasto				= ids_lineas.GetItemString(j,'cta_gasto')
			
			// Se validan datos basicos
			if isnull(linea_dto) then linea_dto = 0
			if linea_dto <> 0 then linea_subtotal = linea_subtotal - linea_dto		
			if f_es_vacio(linea_proyecto) then linea_proyecto = g_explotacion_por_defecto
			
			//Se  prefijan los conceptos en funci$$HEX1$$f300$$ENDHEX$$n del articulo/servicio
			if isnull(linea_concepto_conta) then linea_concepto_conta = ''
			ls_concepto_linea = trim(linea_concepto_conta) + ' '

			if f_es_vacio(id_fase) and f_es_vacio(id_minuta) then
				ls_concepto_linea =  ls_concepto_linea + ' ' +ids_lineas.GetItemString(j,'descripcion_larga')
				if PosA(upper(ids_lineas.GetItemString(j,'descripcion_larga')), "EXTORNO")>0 then ls_concepto_linea = ids_lineas.GetItemString(j,'descripcion_larga') + ' ' + is_nombre  
			else
				ls_concepto_linea=  ls_concepto_linea + ' ' +is_concepto_base		
				
			end if
			
			if g_colegio <> 'COAATTGN' AND  g_colegio<>'COAATLL' then
				if ls_tipo_factura = '03' and (linea_familia= '01' or linea_familia = '02' or linea_familia='GA') then
					ls_concepto_linea = linea_concepto_conta +' '+is_concepto_numeracion +' '+ is_nombre+ ' ['+ n_col   +']'
				end if
			end if
			//Se obtiene el concepto contable de articulos/servicios
			ls_concepto_linea =  LeftA(ls_concepto_linea,57)
				
			// Se obtiene las cuentas contables
			if is_cuenta_cp <> is_cuenta_col then
				ls_cuenta_linea 		= is_cuenta_cp
				is_cuenta_ret_linea	= ''
				ls_cuenta_contra_ret	= is_cuenta_cp
				ls_concepto_ret 		= ls_concepto_linea
			//	id_importe_resumido += linea_subtotal
			else
				ls_cuenta_linea 		= is_cuenta_col
				is_cuenta_ret_linea	= is_cuenta_ret
				ls_cuenta_contra_ret 	= is_cuenta_ret
				ls_concepto_ret		= 'Ret Vol Ingreso Cuenta'
			end if
	
		if linea_cuenta <> 'RV' then
			if ib_aglutinar_iva_conceptos then 
				ld_linea_iva_subtotal = linea_subtotal+linea_iva
			else
				ld_linea_iva_subtotal = linea_subtotal
			end if
		end if
			
		//////////////////////////////////////////////////////////////////////	
		// SE GENERAN LOS APUNTES DE LA LINEAS SEG$$HEX1$$da00$$ENDHEX$$N EL TIPO
		////////////////////////////////////////////////////////////////////
			g_apunte.proyecto = linea_proyecto
		if is_tipo_factura <> '04' then	
			//Caso Retenci$$HEX1$$f300$$ENDHEX$$n Voluntaria
			if linea_cuenta = 'RV' then
				//Apunte por el debe
				if is_cuenta_cp <> is_cuenta_col then
					wf_crear_apunte(idt_fecha_fact, ls_cuenta_linea, ls_concepto_linea, 0, linea_subtotal, ls_orden_apunte, is_cuenta_ret_linea)
					id_importe_resumido+=linea_subtotal
				else
					//Ret Vol: al debe de la cuenta de honorarios
					wf_crear_apunte(idt_fecha_fact, ls_cuenta_linea, ls_concepto_linea, linea_subtotal, 0, ls_orden_apunte, is_cuenta_ret_linea)
					wf_crear_apunte(idt_fecha_fact, ls_cuenta_contra_ret, 'Ret. Vol Ingreso Cuenta', 0, linea_subtotal, ls_orden_apunte, is_cuenta_col)
				end if
			else
				// Se pone esta opci$$HEX1$$f300$$ENDHEX$$n para ver si la cuenta de gastos es diferente a la cuenta de ingresos.
				if linea_subtotal< 0  and not f_es_vacio(linea_cuenta_gasto) then 
					if linea_cuenta_gasto <> linea_cuenta then linea_cuenta=linea_cuenta_gasto
				end if
				//Apunte de Ingreso por el debe
				wf_crear_apunte(idt_fecha_fact, linea_cuenta, ls_concepto_linea, 0, linea_subtotal, ls_orden_apunte, is_cuenta_col)
				
				if not ib_resumida then  
						//CONTRAPARTIDA AL COLEGIADO: (Si se aglutina el iva, incrementamos la cantidad con el iva)
						wf_crear_apunte(idt_fecha_fact, is_cuenta_col, ls_concepto_linea, ld_linea_iva_subtotal, 0, ls_orden_apunte, linea_cuenta)
					
				else
						// Vamos incrementando el total para la resumida
						id_importe_resumido+=linea_subtotal
				end if
			end if
		end if
		
			//Proceso para acumular el importe para cada tipo de IVA/IGIC
				es_exento=false;
				if (linea_t_iva = g_t_iva_exento) then es_exento = true
				if (linea_iva = 0 or isnull(linea_iva)) and not es_exento then continue //Si no hay IVA y no es iva exento nos vamos a la siguiente linea
				FOR k=1 TO ds_iva.RowCount()
					if linea_t_iva <> ds_iva.GetItemString(k,'t_iva') then continue
					ds_iva.SetItem(k,'importe',ds_iva.GetItemNumber(k,'importe') + linea_iva)
					// Almacenamos tambien la base imponible
					ds_iva.SetItem(k,'base_imp',ds_iva.GetItemNumber(k,'base_imp') + linea_subtotal)
				NEXT
				//Fin proceso acumulaci$$HEX1$$f300$$ENDHEX$$n IVA/IGIC
			
			Next 
end subroutine

public subroutine wf_carga_variables_instancia ();///*** SCP-728. Funci$$HEX1$$f300$$ENDHEX$$n creada para la carga de variables para el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n.. Alexis. 20/09/2011 ***///

select sn into :Instance_var_permitir_generar_apuntes_garantias
from var_globales where nombre = 'permitir_generar_apuntes_garantias';

if f_es_vacio(Instance_var_permitir_generar_apuntes_garantias) then Instance_var_permitir_generar_apuntes_garantias = 'S'




end subroutine

on w_proconta_facturas_contabiliza.create
int iCurrent
call super::create
if this.MenuName = "m_proconta_facturas_contabiliza" then this.MenuID = create m_proconta_facturas_contabiliza
this.cb_apuntes=create cb_apuntes
this.dw_modo_cont=create dw_modo_cont
this.st_progreso=create st_progreso
this.st_cuantas_facturas=create st_cuantas_facturas
this.tab_1=create tab_1
this.dw_fechas=create dw_fechas
this.cb_salir=create cb_salir
this.cb_imprimir_ap=create cb_imprimir_ap
this.cb_actualizar=create cb_actualizar
this.cb_buscar=create cb_buscar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_apuntes
this.Control[iCurrent+2]=this.dw_modo_cont
this.Control[iCurrent+3]=this.st_progreso
this.Control[iCurrent+4]=this.st_cuantas_facturas
this.Control[iCurrent+5]=this.tab_1
this.Control[iCurrent+6]=this.dw_fechas
this.Control[iCurrent+7]=this.cb_salir
this.Control[iCurrent+8]=this.cb_imprimir_ap
this.Control[iCurrent+9]=this.cb_actualizar
this.Control[iCurrent+10]=this.cb_buscar
end on

on w_proconta_facturas_contabiliza.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_apuntes)
destroy(this.dw_modo_cont)
destroy(this.st_progreso)
destroy(this.st_cuantas_facturas)
destroy(this.tab_1)
destroy(this.dw_fechas)
destroy(this.cb_salir)
destroy(this.cb_imprimir_ap)
destroy(this.cb_actualizar)
destroy(this.cb_buscar)
end on

event open;call super::open;this.of_setresize(true)
f_centrar_ventana(this)

// Colocamos los valores de las variables de instancia
idw_facturas				= tab_1.tabpage_4.dw_facturas
idw_cobros					= tab_1.tabpage_5.dw_cobros
idw_cobros_multiples		= tab_1.tabpage_3.dw_cobros_multiple
idw_cobros_facturas_contabilizadas = tab_1.tabpage_1.dw_cobros_facturas_contabilizadas
idw_cobros_mult_facturas_contab =  tab_1.tabpage_1.dw_cobros_mult_facturas_contab
idw_apuntes				= tab_1.tabpage_apuntes.dw_apuntes1
idw_cobros_no_ejercicio = tab_1.tabpage_4.dw_cobros_no_ejercicio

// Regristramos los reescalados que deben haber en la ventana
inv_resize.of_register (st_cuantas_facturas, "fixedtoright&bottom")
inv_resize.of_register (st_progreso, "fixedtoright&bottom")
inv_resize.of_register (tab_1, "scaletoright&bottom")
inv_resize.of_register (idw_facturas, "scaletoright&bottom")
inv_resize.of_register (idw_cobros, "scaletoright&bottom")
inv_resize.of_register (idw_cobros_multiples, "scaletoright&bottom")
inv_resize.of_register (idw_cobros_facturas_contabilizadas, "scaletoright")
inv_resize.of_register (idw_cobros_mult_facturas_contab, "scaletoright&bottom")
inv_resize.of_register (idw_apuntes, "scaletoright&bottom")

//Botonera
inv_resize.of_register (cb_buscar, "fixedtobottom")
inv_resize.of_register (cb_apuntes, "fixedtobottom")
inv_resize.of_register (cb_actualizar, "fixedtobottom")
inv_resize.of_register (cb_imprimir_ap, "fixedtobottom")
inv_resize.of_register (cb_salir, "fixedtobottom")

// Colocamos una linea en el dw que consulta
dw_fechas.Event pfc_addrow( )
dw_fechas.SetItem(1,'f_inicio',date(string(Today())))
dw_fechas.SetItem(1,'f_fin',date(string(Today())))
CHOOSE CASE g_colegio
	CASE 'COAATLR'
		dw_fechas.setitem(1, 'resumida', 'S')
		dw_fechas.setitem(1, 'aglutinar_iva_conceptos', 'N')
	CASE 'COAATZ'
		dw_fechas.setitem(1, 'resumida', 'N')
		dw_fechas.setitem(1, 'aglutinar_iva_conceptos', 'S')
	CASE ELSE
		dw_fechas.setitem(1, 'resumida', 'N')
		dw_fechas.setitem(1, 'aglutinar_iva_conceptos', 'N')
END CHOOSE

dw_fechas.setitem(1, 'solo_n_registro',g_conta_concepto_solo_n_registros)



end event

event pfc_postopen;call super::pfc_postopen;//Recuperamos la consulta de Inicio en caso de que exista
This.Event csd_recuperar_consulta('INICIO')

///*** SCP-728. Se llama a la funcion para cargar variables de instancia a partir de la BD. Alexis. 20/09/2011 ***///
wf_carga_variables_instancia()

end event

event closequery;//SOBREESCRITO...

//////////////////////////////////////////////////////////////////////////////
//
//	Event:  closequery
//
//	Description:
//	Search for unsaved datawindows prompting the user if any
//	pending updates are found.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Enhanced control on what objects are to be updated.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Constant Integer	ALLOW_CLOSE = 0
Constant Integer	PREVENT_CLOSE = 1

Integer	li_msg
Integer	li_rc
String	ls_msgparms[]
Powerobject lpo_updatearray[]

// Check if the CloseQuery process has been disabled
If ib_disableclosequery Then
	Return ALLOW_CLOSE
End If

// Call event to perform any pre-CloseQuery processing
If This.Event pfc_preclose ( ) <> 1 Then
	// Prevent the window from closing
	Return PREVENT_CLOSE 
End If

// Prevent validation error messages from appearing while the window is closing
// and allow others to check if the  CloseQuery process is in progress
ib_closestatus = True

// Determine the objects for which an update will be attempted.
// For the CloseQuery, the order sequence is as follows: 
//		1) Specified permananent sequence (thru of_SetUpdateObjects(...)).
//		2) None was specified, so use default window control array.
If UpperBound(ipo_updateobjects) > 0 Then
	lpo_updatearray = ipo_updateobjects
Else
	lpo_updatearray = This.Control		
End If

// Check for any pending updates
li_rc = of_UpdateChecks(lpo_updatearray)
If li_rc = 0 Then
	// Updates are NOT pending, allow the window to be closed.
	ib_closestatus = False
	Return ALLOW_CLOSE
ElseIf li_rc < 0 Then
	// There are Updates pending, but at least one data entry error was found.
	// Give the user an opportunity to close the window without saving changes
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_failsvalidation', &
					 ls_msgparms, gnv_app.iapp_object.DisplayName)
	Else
		li_msg = of_MessageBox ("", &
					gnv_app.iapp_object.DisplayName, &
					"La informaci$$HEX1$$f300$$ENDHEX$$n introducida no pasa el test de validaci$$HEX1$$f300$$ENDHEX$$n "  + &
					"y debe ser corregida antes de que se salven los cambios.~r~n~r~n" + &
					"$$HEX1$$bf00$$ENDHEX$$Desea salir sin grabar?", &
					exclamation!, YesNo!, 2)
	End If
	If li_msg = 1 Then
		ib_closestatus = False
		Return ALLOW_CLOSE
	End If
Else
	// Changes are pending, prompt the user to determine if they should be saved
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_savechanges',  &
					ls_msgparms, gnv_app.iapp_object.DisplayName)		
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_savechanges", &
					gnv_app.iapp_object.DisplayName, &
					"$$HEX1$$bf00$$ENDHEX$$Desea grabar los cambios?", exclamation!, YesNoCancel!, 1)
	End If
	Choose Case li_msg
		Case 1
			// YES - Update
			// If the update fails, prevent the window from closing
//			If This.Event pfc_save() >= 1 Then
				// Se debe grabar pinchando en el bot$$HEX1$$f300$$ENDHEX$$n sino no se actuliza el n$$HEX2$$ba002000$$ENDHEX$$de asiento por ejemplo
				cb_actualizar.TriggerEvent(Clicked!)
				// Successful update, allow the window to be closed
				ib_closestatus = False
				Return ALLOW_CLOSE
//			End If
		Case 2
			// NO - Allow the window to be closed without saving changes
			ib_closestatus = False
			Return ALLOW_CLOSE
		Case 3
			// CANCEL -  Prevent the window from closing
	End Choose
End If

// Prevent the window from closing
ib_closestatus = False
Return PREVENT_CLOSE

end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_proconta_facturas_contabiliza
integer y = 2048
integer taborder = 0
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_proconta_facturas_contabiliza
integer y = 1928
integer taborder = 0
end type

type cb_apuntes from commandbutton within w_proconta_facturas_contabiliza
string tag = "&Apuntes"
integer x = 421
integer y = 2252
integer width = 366
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Generar Ap."
end type

event clicked;if f_puedo_escribir(g_usuario,'0000000008')=-1 then return -1
// No permitimos que nos vuelvan a pinchar hasta que acabemos
//this.enabled = false
if idw_facturas.RowCount()>500 then
	if messageBox(g_titulo, "Dada la gran cantidad de facturas, para agilizar el proceso, $$HEX1$$bf00$$ENDHEX$$desea NO MOSTRAR los apuntes hasta finalizado el proceso?", question!,yesno!,1)=1 then idw_apuntes.setredraw(false)
end if

string  concepto_garantia, concepto_cobro_a_cuenta
double  saltados

SetPointer(Hourglass!)

ib_resumida = (dw_fechas.getitemString(1, 'resumida') ='S')
ib_aglutinar_iva_conceptos = (dw_fechas.getitemString(1, 'aglutinar_iva_conceptos') ='S')
ib_aglutinar_irpf = (dw_fechas.getitemString(1, 'aglutinar_irpf') ='S')

is_concepto_solo_num_reg = dw_fechas.getitemstring(1,'solo_n_registro')


// Funcion que pone algunos valores por defecto a variables globales que no tienen
wf_preproceso()

// Apunte de asiento automatico
i_asiento_general = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.facts_emitidas_general,7))

// Evitamos los nulos
if isnull(i_asiento_general) then i_asiento_general = 0


// Algunos datos genericos
select concepto_conta into :concepto_garantia from csi_articulos_servicios where codigo = :g_conta.garantia_codigo_articulo and empresa=:g_empresa;
select concepto_conta into :concepto_cobro_a_cuenta from csi_articulos_servicios where codigo = :g_codigos_conceptos.cobro_a_cuenta and empresa=:g_empresa;


is_concepto_cobro_a_cuenta =concepto_cobro_a_cuenta
is_concepto_garantia = concepto_garantia


idw_apuntes.reset()// Vaciamos los apuntes!
this.enabled = false
idw_facturas.AcceptText()
yield()

// GENERA LOS APUNTES DE FACTURAS 
if idw_facturas.rowcount() > 0 then parent.triggerevent('csd_apuntes_facturas')

// GENERA LOS APUNTES DE Cobros Multiples
IF g_contabilidad_conjunta = 'N' and idw_cobros_multiples.rowcount() > 0 then parent.triggerevent('csd_apuntes_cobros_multiple')

// GENERA LOS APUNTES DE Cobros Simples
IF g_contabilidad_conjunta = 'N' and idw_cobros.rowcount() > 0 then parent.triggerevent('csd_cobros_simples')

// GENERA LOS APUNTES DE FACTURAS CONTABILIZADAS
// 		Cobros simples
IF idw_cobros_facturas_contabilizadas.rowcount() > 0 then parent.triggerevent('csd_apuntes_fact_contabilizadas')

// 		Cobros multiples
IF idw_cobros_mult_facturas_contab.rowcount() > 0 then parent.triggerevent('csd_cobros_multiples_fact_contabil')

yield()

idw_apuntes.setSort("diario A, long(n_asiento)  A, n_doc A, n_apunte A")
idw_apuntes.Sort()
idw_apuntes.GroupCalc()
st_progreso.text = 'Generaci$$HEX1$$f300$$ENDHEX$$n de apuntes finalizada: '+string(idw_apuntes.RowCount())+' apuntes generados.'
yield()
cb_actualizar.enabled = (idw_apuntes.RowCount() > 0)
cb_imprimir_ap.enabled = (idw_apuntes.RowCount() > 0)

idw_apuntes.setredraw(true)
//
end event

type dw_modo_cont from u_dw within w_proconta_facturas_contabiliza
boolean visible = false
integer x = 2473
integer y = 308
integer width = 1531
integer height = 88
integer taborder = 20
string dataobject = "d_cobros_modo_contabilizacion"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;// Metemos una linea para que se pueda elegir como se quiere trabajar
this.insertrow(0)

end event

type st_progreso from statictext within w_proconta_facturas_contabiliza
integer x = 2011
integer y = 2276
integer width = 2222
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
boolean border = true
boolean focusrectangle = false
end type

type st_cuantas_facturas from statictext within w_proconta_facturas_contabiliza
integer x = 2011
integer y = 2184
integer width = 2222
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
boolean border = true
boolean focusrectangle = false
end type

type tab_1 from tab within w_proconta_facturas_contabiliza
integer x = 23
integer y = 420
integer width = 4206
integer height = 1728
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_4 tabpage_4
tabpage_3 tabpage_3
tabpage_5 tabpage_5
tabpage_1 tabpage_1
tabpage_apuntes tabpage_apuntes
end type

on tab_1.create
this.tabpage_4=create tabpage_4
this.tabpage_3=create tabpage_3
this.tabpage_5=create tabpage_5
this.tabpage_1=create tabpage_1
this.tabpage_apuntes=create tabpage_apuntes
this.Control[]={this.tabpage_4,&
this.tabpage_3,&
this.tabpage_5,&
this.tabpage_1,&
this.tabpage_apuntes}
end on

on tab_1.destroy
destroy(this.tabpage_4)
destroy(this.tabpage_3)
destroy(this.tabpage_5)
destroy(this.tabpage_1)
destroy(this.tabpage_apuntes)
end on

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4169
integer height = 1612
long backcolor = 79741120
string text = "Facturas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cobros_no_ejercicio dw_cobros_no_ejercicio
dw_facturas dw_facturas
end type

on tabpage_4.create
this.dw_cobros_no_ejercicio=create dw_cobros_no_ejercicio
this.dw_facturas=create dw_facturas
this.Control[]={this.dw_cobros_no_ejercicio,&
this.dw_facturas}
end on

on tabpage_4.destroy
destroy(this.dw_cobros_no_ejercicio)
destroy(this.dw_facturas)
end on

type dw_cobros_no_ejercicio from u_csd_dw within tabpage_4
boolean visible = false
integer x = 617
integer y = 168
integer width = 1093
integer height = 436
integer taborder = 21
string dataobject = "d_cobros_no_ejercicio"
end type

type dw_facturas from u_dw within tabpage_4
integer width = 4160
integer height = 1564
integer taborder = 80
string dataobject = "d_proconta_facturas_contabiliza_za"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_rmbmenu = false
end type

event retrieveend;call super::retrieveend;cb_apuntes.enabled = (this.RowCount() > 0) or  (idw_cobros_multiples.RowCount() > 0) or (idw_cobros.RowCount() > 0) or (idw_cobros_facturas_contabilizadas.RowCount()>0) or (idw_cobros_mult_facturas_contab.RowCount()>0)
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'CONTA_FTURAS'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

// Evitamos que aparezcan las 'PA' de momento
//this.setfilter("formadepago <> 'PA'")  

end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4169
integer height = 1612
long backcolor = 79741120
string text = "Cobros Compuestos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cobros_multiple dw_cobros_multiple
end type

on tabpage_3.create
this.dw_cobros_multiple=create dw_cobros_multiple
this.Control[]={this.dw_cobros_multiple}
end on

on tabpage_3.destroy
destroy(this.dw_cobros_multiple)
end on

event constructor;// RICARDO 04-07
// Solo hacemos visible el tab de cobros multiples si tambien lo est$$HEX2$$e1002000$$ENDHEX$$la entrada de menu
//tab_1.tabpage_3.visible = m_aplic_frame.m_file.m_new.m_contabilidad0.m_cobrosmultiples.visible

// Vamos a mirar en la bd porque pierde la referencia del men$$HEX1$$fa00$$ENDHEX$$
string vis

SELECT visible INTO :vis FROM menu WHERE activo = 'S' AND codigo = '0000000154'  ;

if vis = '0' then tab_1.tabpage_3.visible = false

end event

type dw_cobros_multiple from u_dw within tabpage_3
integer y = 4
integer width = 4165
integer height = 1568
integer taborder = 11
string dataobject = "d_proconta_cobros_multipl_contabiliza"
boolean ib_rmbmenu = false
end type

event retrieveend;call super::retrieveend;cb_apuntes.enabled = (this.RowCount() > 0) or  (idw_facturas.RowCount() > 0) or (idw_cobros.RowCount() > 0) or (idw_cobros_facturas_contabilizadas.RowCount()>0) or (idw_cobros_mult_facturas_contab.RowCount()>0)
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'CONTA_CM'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4169
integer height = 1612
long backcolor = 79741120
string text = "Cobros"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cobros dw_cobros
end type

event constructor;//this.visible = false
end event

on tabpage_5.create
this.dw_cobros=create dw_cobros
this.Control[]={this.dw_cobros}
end on

on tabpage_5.destroy
destroy(this.dw_cobros)
end on

type dw_cobros from u_dw within tabpage_5
integer y = 4
integer width = 4160
integer height = 1556
integer taborder = 11
string dataobject = "d_proconta_cobros_contabiliza"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_rmbmenu = false
end type

event retrieveend;call super::retrieveend;cb_apuntes.enabled = (this.RowCount() > 0) or  (idw_cobros_multiples.RowCount() > 0) or (idw_facturas.RowCount() > 0) or (idw_cobros_facturas_contabilizadas.RowCount()>0) or (idw_cobros_mult_facturas_contab.RowCount()>0)
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'CONTA_COBROS'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4169
integer height = 1612
long backcolor = 79741120
string text = "Cobros Fact. Contabilizadas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cobros_mult_facturas_contab dw_cobros_mult_facturas_contab
st_2 st_2
st_1 st_1
dw_cobros_facturas_contabilizadas dw_cobros_facturas_contabilizadas
end type

on tabpage_1.create
this.dw_cobros_mult_facturas_contab=create dw_cobros_mult_facturas_contab
this.st_2=create st_2
this.st_1=create st_1
this.dw_cobros_facturas_contabilizadas=create dw_cobros_facturas_contabilizadas
this.Control[]={this.dw_cobros_mult_facturas_contab,&
this.st_2,&
this.st_1,&
this.dw_cobros_facturas_contabilizadas}
end on

on tabpage_1.destroy
destroy(this.dw_cobros_mult_facturas_contab)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_cobros_facturas_contabilizadas)
end on

type dw_cobros_mult_facturas_contab from u_dw within tabpage_1
integer x = -5
integer y = 1056
integer width = 4133
integer height = 480
integer taborder = 21
string dataobject = "d_proconta_cobros_multipl_facts_contab"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'CONTA_CFACTC'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return
end event

event retrieveend;call super::retrieveend;cb_apuntes.enabled = (this.RowCount() > 0) or  (idw_cobros_multiples.RowCount() > 0) or (idw_cobros.RowCount() > 0) or (idw_facturas.RowCount()>0) or (idw_cobros_facturas_contabilizadas.RowCount()>0) 
end event

type st_2 from statictext within tabpage_1
integer x = 9
integer y = 976
integer width = 357
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 33554432
long backcolor = 67108864
string text = "Cobros m$$HEX1$$fa00$$ENDHEX$$ltiples"
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_1
integer x = 18
integer y = 28
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 33554432
long backcolor = 67108864
string text = "Cobros simples"
boolean focusrectangle = false
end type

type dw_cobros_facturas_contabilizadas from u_dw within tabpage_1
integer x = -5
integer y = 96
integer width = 4133
integer height = 864
integer taborder = 11
string dataobject = "d_proconta_cobros_facts_contabilizada"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_rmbmenu = false
end type

event retrieveend;call super::retrieveend;cb_apuntes.enabled = (this.RowCount() > 0) or  (idw_cobros_multiples.RowCount() > 0) or (idw_cobros.RowCount() > 0) or (idw_facturas.RowCount()>0) or (idw_cobros_mult_facturas_contab.RowCount()>0)
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'CONTA_CFACTC'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return
end event

type tabpage_apuntes from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4169
integer height = 1612
long backcolor = 79741120
string text = "Apuntes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_apuntes1 dw_apuntes1
end type

on tabpage_apuntes.create
this.dw_apuntes1=create dw_apuntes1
this.Control[]={this.dw_apuntes1}
end on

on tabpage_apuntes.destroy
destroy(this.dw_apuntes1)
end on

type dw_apuntes1 from u_dw within tabpage_apuntes
integer y = 4
integer width = 4155
integer height = 1564
integer taborder = 11
string dataobject = "d_apuntes_automaticos"
end type

event constructor;call super::constructor;SetTransObject(bd_ejercicio)
of_SetPrintPreview(TRUE)
this.trigger event pfc_printpreview()
end event

event doubleclicked;call super::doubleclicked;//parent.setredraw(false)
//if il_coord_x >0 then
//	// Restauramos el tama$$HEX1$$f100$$ENDHEX$$o original
//	this.x = il_coord_x
//	this.y = il_coord_y
//	this.width = il_tamanyo_x
//	this.height = il_tamanyo_y
//	
//	il_coord_x = 0
//	il_coord_y = 0
//	il_tamanyo_x = 0
//	il_tamanyo_y = 0
//else
//	// Maximizamos
//	il_coord_x = this.x
//	il_coord_y = this.y 
//	il_tamanyo_x = this.width
//	il_tamanyo_y = this.height
//
//	this.x = 32
//	this.y = 336
//	this.width =  il_tamanyo_x
//	this.height = il_coord_y+il_tamanyo_y - 336
//end if
//this.visible = true
//parent.setredraw(true)
end event

type dw_fechas from u_dw within w_proconta_facturas_contabiliza
integer width = 3803
integer height = 400
integer taborder = 10
string dataobject = "d_facturas_desdehasta"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

// Paco 22/05/2007
//CHOOSE CASE g_colegio
//	CASE 'COAATLR'
//		this.modify("resumida.visible = '1'")
//		this.modify("aglutinar_iva_conceptos.visible = '0'")
//		this.modify("aglutinar_irpf.visible = '0'")
//	CASE 'COAATZ'
//		this.modify("resumida.visible = '0'")
//		this.modify("aglutinar_iva_conceptos.visible = '1'")
//		this.modify("aglutinar_irpf.visible = '0'")
//	CASE 'COAATGU', 'COAATLE', 'COAATAVI'
//		this.modify("resumida.visible = '1'")
//		this.modify("aglutinar_iva_conceptos.visible = '0'")
//		this.modify("aglutinar_irpf.visible = '1'")
//	CASE ELSE
//		this.modify("resumida.visible = '1'") // Solo temporal
//		this.modify("aglutinar_iva_conceptos.visible = '0'")
//		this.modify("aglutinar_irpf.visible = '0'")
//END CHOOSE

end event

event pfc_updatespending;return 0
end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE 'aglutinar_irpf'
		// Solo se puede aglutinar irpf con la contabilizaci$$HEX1$$f300$$ENDHEX$$n resumida
		if data ='S' and this.getitemstring(row, 'resumida')='N' then
			post messagebox(g_titulo, "S$$HEX1$$f300$$ENDHEX$$lo se puede aglutinar irpf con la contabilizaci$$HEX1$$f300$$ENDHEX$$n resumida", exclamation!)
			return 2
		end if
END CHOOSE
end event

type cb_salir from commandbutton within w_proconta_facturas_contabiliza
boolean visible = false
integer x = 1595
integer y = 2252
integer width = 366
integer height = 88
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;Close(Parent)
end event

type cb_imprimir_ap from commandbutton within w_proconta_facturas_contabiliza
integer x = 1179
integer y = 2252
integer width = 366
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Imprimir Ap."
end type

event clicked;//dw_apuntes.Print()
f_opciones_impresion(idw_apuntes)
end event

type cb_actualizar from commandbutton within w_proconta_facturas_contabiliza
event cliced_old ( )
string tag = "&Apuntes"
integer x = 800
integer y = 2252
integer width = 366
integer height = 88
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Actualizar Ap."
end type

event cliced_old();/*

boolean b_error = false, b_autocomit_SQLCA, b_autocomit_bd_ejercicio

// Quitamos los autocomit
b_autocomit_SQLCA = SQLCA.autocommit
b_autocomit_bd_ejercicio = bd_ejercicio.autocommit
SQLCA.autocommit = false
bd_ejercicio.autocommit = false
// Iniciamos una transaccion, para hacer el proceso atomico
Execute Immediate "BEGIN tran" using SQLCA;
EXECUTE IMMEDIATE "BEGIN tran" USING bd_ejercicio;

if idw_facturas.Update()<>1 then b_error = true
if idw_cobros.Update()<>1 then b_error = true
if idw_cobros_multiples.Update()<>1 then b_error = true
if dw_apuntes.Update()<>1 then b_error = true
if idw_cobros_facturas_contabilizadas.update()<>1 then b_error = true

if not b_error then
	// Confirmamos los cambios
	Execute Immediate "COMMIT Transaction" using SQLCA;
	Execute Immediate "COMMIT Transaction" using bd_ejercicio;
	commit USING SQLCA; 
	commit USING bd_ejercicio;
	// Ahora actualizamos las bbdd de contadores
	f_actualiza_numero_bd_ejercicio(g_sica_diario.facts_emitidas_exp, i_asiento_exp)
	f_actualiza_numero_bd_ejercicio(g_sica_diario.facts_emitidas_ot, i_asiento_ot)
	f_actualiza_numero_bd_ejercicio(g_sica_diario.cobros_multiples, i_asiento_cobros_mult)
	f_actualiza_numero_bd_ejercicio(g_sica_diario.remesas, i_asiento_rem)
else
	// Desacemos los cambios realizados
	Execute Immediate "ROLLBACK Transaction" using SQLCA;
	Execute Immediate "ROLLBACK Transaction" using bd_ejercicio;
	EXECUTE IMMEDIATE "rollback" USING SQLCA;
	EXECUTE IMMEDIATE "rollback" USING bd_ejercicio;
	rollback USING SQLCA; 
	rollback USING bd_ejercicio;
	messagebox(g_titulo, "Se ha producido un error al intentar actualizar facturas y grabar los apuntes generados"+cr+"Avise al departamento de inform$$HEX1$$e100$$ENDHEX$$tica", stopsign!)
end if
// Cerramos la transaccion
EXECUTE IMMEDIATE "END tran" USING SQLCA;
EXECUTE IMMEDIATE "END tran" USING bd_ejercicio;
// restauramos los autocomit
SQLCA.autocommit = b_autocomit_SQLCA
bd_ejercicio.autocommit = b_autocomit_bd_ejercicio

this.enabled = false
*/
end event

event clicked;// Simplemente grabamos los distintos datawindows, haciendolos atomicos el grabado
long asiento_exp, asiento_ot, asiento_rem, asiento_cobros_mult
long fila
string n_asiento, n_asiento_old, n_asiento_renumerado, diario, diario_old

//SCP-166 Verificamos que el ejercicio contable esta abierto
if NOT f_ejercicio_abierto(g_ejercicio) then
	Messagebox(g_titulo,'El ejercicio contable '+ g_ejercicio + ' no est$$HEX2$$e1002000$$ENDHEX$$abierto. No es posible continuar con el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n.',stopsign!)
	return
end if

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
FOR fila = 1 to idw_apuntes.RowCount()
	diario = idw_apuntes.getitemstring(fila, 'diario')
	n_asiento = idw_apuntes.getitemstring(fila, 'n_asiento')
	// Si cambia de asiento/diario, renumeramos de nuevo
	if n_asiento <> n_asiento_old or diario<>diario_old then
		n_asiento_renumerado = f_siguiente_numero_bd_ejercicio(diario,7) // ESto asegura que los numeros de asiento se hagan bien
	end if
	// Cambiamos el asiento segun
	idw_apuntes.SetItem(fila, 'n_asiento', n_asiento_renumerado)
	
	// Mantenemos los datos de la iteracion anterior
	n_asiento_old = n_asiento
	diario_old = diario
NEXT
idw_apuntes.groupcalc()

// FIN MODIFICADO RICARDO 2005-07-27

if idw_facturas.Update()<>1 then b_error = true
if idw_cobros.Update()<>1 then b_error = true
if idw_cobros_multiples.Update()<>1 then b_error = true
if idw_apuntes.Update()<>1 then b_error = true
if idw_cobros_facturas_contabilizadas.update()<>1 then b_error = true
if idw_cobros_mult_facturas_contab.update()<>1 then b_error = true

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
	messagebox(g_titulo, "Se ha producido un error al intentar actualizar facturas y grabar los apuntes generados"+cr+"Avise al departamento de inform$$HEX1$$e100$$ENDHEX$$tica", stopsign!)
end if
// Cerramos la transaccion
EXECUTE IMMEDIATE "END tran" USING SQLCA;
EXECUTE IMMEDIATE "END tran" USING bd_ejercicio;
// restauramos los autocomit
SQLCA.autocommit = b_autocomit_SQLCA
bd_ejercicio.autocommit = b_autocomit_bd_ejercicio

this.enabled = false


end event

type cb_buscar from commandbutton within w_proconta_facturas_contabiliza
integer x = 41
integer y = 2252
integer width = 366
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Buscar Fact"
end type

event clicked;idw_apuntes.Reset()
datetime f_inicio,f_fin
string centro, serie
string mensaje=''
long num_filas


if not ib_comprobadas_variables then
	long cuantos
	if isnull(g_num_digitos) or g_num_digitos > 10 or g_num_digitos < 6 then mensaje = mensaje + cr + "g_num_digitos"
	
	if f_es_vacio(g_conta.concepto_exp) then mensaje = mensaje + cr + "g_conta.concepto_exp"
	if f_es_vacio(g_conta.concepto_rv) then mensaje = mensaje + cr + "g_conta.concepto_rv"
	if f_es_vacio(g_conta.cuenta_clientes_general) then mensaje = mensaje + cr + "g_conta.cuenta_clientes_general"
	if f_es_vacio(g_conta.ret_vol) then mensaje = mensaje + cr + "g_conta.ret_vol"
	if f_es_vacio(g_prefijo_arqui) then mensaje = mensaje + cr + "g_prefijo_arqui"
	if f_es_vacio(g_sica_diario.facts_emitidas_exp) then mensaje = mensaje + cr + "g_sica_diario.facts_emitidas_exp"

	if f_es_vacio(g_sica_diario.facts_emitidas_ot) then mensaje = mensaje + cr + "g_sica_diario.facts_emitidas_ot"
	if f_es_vacio(g_sica_diario.remesas) then mensaje = mensaje + cr + "g_sica_diario.remesas"
	if f_es_vacio(g_t_asiento_apuntes_automaticos) then mensaje = mensaje + cr + "g_t_asiento_apuntes_automaticos"
	if f_es_vacio(g_sica_t_doc.facts_emitidas_exp) then mensaje = mensaje + cr + "g_sica_t_doc.facts_emitidas_exp"
	if f_es_vacio(g_sica_t_doc.facts_emitidas_ot) then mensaje = mensaje + cr + "g_sica_t_doc.facts_emitidas_ot"
	if f_es_vacio(g_sica_t_doc.remesas) then mensaje = mensaje + cr + "g_sica_t_doc.remesas"
	if f_es_vacio(g_sica_t_doc.cobros_multiples) then mensaje = mensaje + cr + "g_sica_t_doc.cobros_multiples"
	if f_es_vacio(g_sica_t_doc.transferencia) then mensaje = mensaje + cr + "g_sica_t_doc.transferencia"
	if f_es_vacio(g_sica_t_doc.talon) then mensaje = mensaje + cr + "g_sica_t_doc.talon"
	if f_es_vacio(g_sica_t_doc.generico) then mensaje = mensaje + cr + "g_sica_t_doc.generico"
	if f_es_vacio(g_centro_por_defecto) then mensaje = mensaje + cr + "g_centro_por_defecto"


	if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
	
	select count(*) into :cuantos from csi_bancos where cuenta_contable = null or cuenta_contable = '';
	if cuantos > 0 then Messagebox(g_titulo,"Hay bancos sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso.",Stopsign!)
	
	select count(*) into :cuantos from csi_t_iva where descripcion = null or descripcion = '';
	if cuantos > 0 then Messagebox(g_titulo,"Hay Tipos de IVA sin descripci$$HEX1$$f300$$ENDHEX$$n: Se generar$$HEX1$$e100$$ENDHEX$$n mal los conceptos.",Stopsign!)
	
	select count(*) into :cuantos from csi_t_iva where id_cuenta_repercutido = null or id_cuenta_repercutido = '';
	if cuantos > 0 then Messagebox(g_titulo,"Hay Tipos de IVA sin la cuenta contable definida: Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso.",Stopsign!)
	
	select count(*) into :cuantos from csi_articulos_servicios where cuenta = null or cuenta = '';
	if cuantos > 0 then Messagebox(g_titulo,"Art$$HEX1$$ed00$$ENDHEX$$culos/Servicios sin la cuenta contable definida: Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso.",Stopsign!)
	
	select count(*) into :cuantos from csi_articulos_servicios where concepto_conta = null or concepto_conta = '';
	if cuantos > 0 then Messagebox(g_titulo,"Art$$HEX1$$ed00$$ENDHEX$$culos/Servicios sin el concepto (resumen). Se generar$$HEX1$$e100$$ENDHEX$$n mal los conceptos.",Stopsign!)
	
	if mensaje <> '' then
		mensaje = 'Hay que definir las siguientes variables para poder contabilizar:' + cr + mensaje
		messagebox(g_titulo,mensaje,Stopsign!)
		Messagebox(g_titulo,'De momento les pondremos valores por defecto, pero no se debe poner en marcha si se lee este mensaje!!!',Stopsign!)
	end if
	ib_comprobadas_variables = true
end if


mensaje = ''


dw_fechas.AcceptText()

SetPointer(HourGlass!)

// Cogemos los datos de la consulta que tenemos
f_inicio = dw_fechas.GetItemDateTime(1,'f_inicio')
f_inicio = datetime(date(f_inicio), time('00:00:00'))
f_fin		= DateTime(RelativeDate(Date(dw_fechas.GetItemDateTime(1,'f_fin')),1))
centro = dw_fechas.GetItemString(1,'centro')
if f_es_vacio(centro) then centro = '%'
serie= dw_fechas.GetItemString(1,'serie')
if f_es_vacio(serie) then serie= '%' else serie += '%'
// Hacemos las validaciones pertinentes sobre la consulta
if isnull(f_inicio) then mensaje += 'La fecha de inicio no puede ser nula.'+cr
if isnull(f_fin) then mensaje += 'La fecha final no puede ser nula.'+cr
if f_fin<f_inicio then mensaje += 'La fecha final no puede ser anterior a la fecha inicio.'

// Si hay errores los mostramos... sino, recuperamos las filas y lo ponemos en pantalla
if mensaje<>'' then
	messagebox(g_titulo,mensaje)
	return
else
	string texto
	num_filas = idw_facturas.Retrieve(f_inicio,f_fin, centro, serie)	
	texto = string(num_filas)+ ' Facturas.'
	// REcuperamos cobros y cobros multiples
	idw_cobros.Retrieve(f_inicio,f_fin, centro, serie)
	num_filas = idw_cobros_multiples.Retrieve(f_inicio,f_fin, centro, serie)
	if num_filas>0 then texto += '  -  ' + string(num_filas)+ ' Cobros multiples.'

	num_filas = idw_cobros_facturas_contabilizadas.Retrieve(f_inicio,f_fin, centro, serie)	
	if num_filas>0 then texto += '  -  ' + string(num_filas)+ ' Cobros de fact. contab. o bien de fact. remesadas no contab.'
	
	num_filas =  idw_cobros_mult_facturas_contab.Retrieve(f_inicio,f_fin, centro, serie)
	if num_filas>0 and idw_cobros_facturas_contabilizadas.RowCount() < 1  then texto += '  -  ' + string(idw_cobros_mult_facturas_contab.GetitemNumber(1, 'cobros_multiples'))+ ' Cobros de fact. contab. o bien de fact. remesadas no contab.'

	st_cuantas_facturas.text= texto
end if

mensaje = ''

// Modificado Ricardo 2005-04-28
// Miramos si son todas del a$$HEX1$$f100$$ENDHEX$$o actual para contabilizarlas
if wf_verificar_facturas()<1  then cb_apuntes.enabled = false


// Vaciamos el otro texto, que suele quedar mal que se quede visible
st_progreso.text = ''

SetPointer(Arrow!)
end event

