HA$PBExportHeader$w_factufase_facturar.srw
forward
global type w_factufase_facturar from w_response
end type
type dw_lista_receptores from u_dw within w_factufase_facturar
end type
type dw_total_gastos from u_dw within w_factufase_facturar
end type
type gb_2 from groupbox within w_factufase_facturar
end type
type dw_aux from u_dw within w_factufase_facturar
end type
type cb_cerrar from commandbutton within w_factufase_facturar
end type
type dw_tipo_facturacion from u_dw within w_factufase_facturar
end type
type cb_facturar from commandbutton within w_factufase_facturar
end type
type cb_liquidar from commandbutton within w_factufase_facturar
end type
type gb_4 from groupbox within w_factufase_facturar
end type
type dw_facturas_pendientes from u_dw within w_factufase_facturar
end type
type gb_3 from groupbox within w_factufase_facturar
end type
type dw_lista_gastos from u_dw within w_factufase_facturar
end type
type tab_1 from tab within w_factufase_facturar
end type
type tabpage_1 from userobject within tab_1
end type
type dw_formatos from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_formatos dw_formatos
end type
type tabpage_2 from userobject within tab_1
end type
type dw_impresos from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_impresos dw_impresos
end type
type tabpage_3 from userobject within tab_1
end type
type dw_firma from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_firma dw_firma
end type
type tab_1 from tab within w_factufase_facturar
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type dw_informes from u_dw within w_factufase_facturar
end type
type st_1 from statictext within w_factufase_facturar
end type
type dw_estadistica from u_dw within w_factufase_facturar
end type
type dw_fases_detalle from u_dw within w_factufase_facturar
end type
end forward

global type w_factufase_facturar from w_response
integer width = 4448
integer height = 2448
boolean controlmenu = false
event csd_agregar_colegiados_fase ( )
event csd_agregar_clientes_fase ( )
event csd_genera_gastos ( )
event csd_actualiza_totales_gastos ( )
event csd_calcula_cantidad_liquidacion ( )
event type long csd_factura ( string facturar_musaat_diferenciado,  string as_empresa )
event csd_marcar_facturado ( string tipo,  string id )
event type string csd_comprobar_abono_total ( )
event csd_facturar_todo ( )
event csd_facturar_seleccion ( )
event csd_resetea_estructura ( )
event csd_facturas_pendientes ( string id_col )
event csd_opciones_defecto ( )
event csd_opciones_impresion ( )
event type integer csd_validar_iva_2010 ( integer destinatario )
event csd_comp ( )
event csd_cargar_pagadores ( )
event type long csd_factura_por_empresa ( string as_facturar_musaat_diferenciado )
dw_lista_receptores dw_lista_receptores
dw_total_gastos dw_total_gastos
gb_2 gb_2
dw_aux dw_aux
cb_cerrar cb_cerrar
dw_tipo_facturacion dw_tipo_facturacion
cb_facturar cb_facturar
cb_liquidar cb_liquidar
gb_4 gb_4
dw_facturas_pendientes dw_facturas_pendientes
gb_3 gb_3
dw_lista_gastos dw_lista_gastos
tab_1 tab_1
dw_informes dw_informes
st_1 st_1
dw_estadistica dw_estadistica
dw_fases_detalle dw_fases_detalle
end type
global w_factufase_facturar w_factufase_facturar

type variables
string i_id_fase, i_proforma
u_dw idw_formatos_impresion, idw_impresos, idw_firma, idw_fases_estadistica, idw_1, idw_fases_datos_exp
boolean i_facturado,i_bloquear_redraw=false
boolean i_bloquear_facturacion=false //evita que se le de dos veces al boton de facturar
boolean i_no_saldo=false //Indica que algun colegiado no tiene suficiente saldo en su cuenta personal y tiene seleccionada esa opci$$HEX1$$f300$$ENDHEX$$n de forma de pago
boolean i_cliente_externo=false //Indica que se intenta facturar a un cliente externo en cuenta personal
long i_num_facturas_creadas=0
double id_pem
st_factufa_opciones i_opciones

st_facturas i_datos_facturacion
st_fases_consulta i_datos_fase
datastore i_ds_informes,i_ds_asemas

n_csd_impresion_formato i_impresion_formato

DatawindowChild i_dwc_colegiados_empresas, i_dwc_pagador_externo,i_dwc_pagador

string is_empresa_seleccionada

string is_formapago_plataforma, is_id_fases_pago_plataforma
boolean ibl_conciliar_pago, ibl_avisado


end variables

forward prototypes
public function integer wf_inserta_linea_gastos (st_factufa_lineas_factura datos)
public function integer wf_desactiva_filtro_gastos ()
public subroutine wf_activa_filtro_gastos (boolean ver)
public function double wf_cantidad_facturada (string articulo, string tipo)
public function string wf_tipo_factura (string tipo_receptor)
public function integer wf_comprobar_hay_gastos_seleccionados (string modo_comprobacion)
public subroutine wf_opciones_impresion_colegio ()
public subroutine wf_imprimir (string id_fact)
public function integer wf_estado_cuenta_colegiado (string tipo, string id)
public function boolean wf_requiere_conciliar (string id_fase, string id_colegiado)
end prototypes

event csd_agregar_colegiados_fase();long i,fila,pos
int estado_cuenta_colegiado
datastore ds_col
double por=0,por_pdte,cuantos,porcentaje, importe_gastos,saldo
string id_col,facturado,formapago,banco_pago,concepto,nombre_col,lista_baja,email,id_empresa
Datetime f_nula

//Cargamos los datos en el desplegable de pagadores
this.Event csd_cargar_pagadores()

SetNull(f_nula)
ds_col = create datastore
ds_col.dataobject = 'd_fases_colegiados'
ds_col.SetTransObject(SQLCA)

ds_col.Retrieve(i_id_fase)

for i= 1 to ds_col.rowcount()
	id_col = ds_col.GetItemString(i,'id_col')
	if f_colegiado_es_moroso(id_col) then MessageBox(g_titulo, "El " + g_idioma.of_getmsg('colegiados.colegiado','colegiado') + ' ' + f_colegiado_n_col(id_col) + ' es ' +  g_idioma.of_getmsg('colegiados.moroso','moroso'),Exclamation!, OK!,1)	
	nombre_col = f_colegiado_nombre_apellido(id_col)
	pos = PosA(i_opciones.formapago_gastos,'COL_',1)
	formapago = g_forma_pago_por_defecto
	banco_pago = g_banco_por_defecto
	//Por defecto la cuenta de colegido esta 'ok'
	estado_cuenta_colegiado=1
	
	//Comprobamos el estado de la cuenta personal del colegiado
	if formapago = g_formas_pago.cuenta_personal and not f_es_vacio(g_prefijo_cuenta_bancaria_col) then
		st_saldo_cuenta_bancaria_colegiado lst_entrada
		lst_entrada.id_colegiado = id_col
		lst_entrada.f_desde = datetime(date('01/01/'+g_ejercicio),time('00:00'))
		lst_entrada.f_hasta = datetime(Today(), time('23:59:59'))
	
		saldo = f_saldo_cuenta_bancaria_col(lst_entrada.id_colegiado, lst_entrada.f_desde, lst_entrada.f_hasta)
		//Si el saldo no permite incluir ning$$HEX1$$fa00$$ENDHEX$$n importe mas, no permitimos que aparezca como forma de pago del colegiado
		if saldo <= 0 then
			estado_cuenta_colegiado=0			
		end if
	end if
	
		
// 19/11/10 En Aparejadores se emplea el check facturado para anotar si un Colegiado es Funcionario: para detectar si un Receptos ya est$$HEX2$$e1002000$$ENDHEX$$facturado, se comprobar$$HEX2$$e1002000$$ENDHEX$$si tiene alg$$HEX1$$fa00$$ENDHEX$$n concepto pendiente de facturar
	por = ds_col.GetItemNumber(i,'porcen_a')
	//Comprobamos si hay importes
	select sum(cuantia_colegiado) into :importe_gastos from fases_informes where id_fase = :i_id_fase;
	if importe_gastos = 0 then return

	
	fila = dw_lista_receptores.InsertRow(0)
	dw_lista_receptores.SetItem(fila,'id',id_col)
	id_empresa=ds_col.GetItemString(i,'id_empresa')
	dw_lista_receptores.SetItem(fila,'id_empresa',id_empresa)
	dw_lista_receptores.SetItem(fila,'descripcion',nombre_col)
	dw_lista_receptores.SetItem(fila,'porcentaje',por)	
	dw_lista_receptores.SetItem(fila,'tipo','C')  //Colegiados
	//Para las proformas, el campo 'Pagado' no ser$$HEX2$$e1002000$$ENDHEX$$visible
	if i_datos_fase.proforma='S' then
		dw_lista_receptores.SetItem(fila,'pagado','N')
		dw_lista_receptores.object.pagado.visible=false
		dw_lista_receptores.object.f_pago.visible=false
		dw_lista_receptores.object.pagado_t.visible=false
	else
		if estado_cuenta_colegiado=1 then
			if formapago='DB' or formapago='PE' or formapago='PP' then
				dw_lista_receptores.SetItem(fila,'pagado','N')
				dw_lista_receptores.SetItem(fila,'f_pago',f_nula)
			else
				dw_lista_receptores.SetItem(fila,'pagado','S')
				dw_lista_receptores.SetItem(fila,'f_pago',datetime(today()))
			end if
		else
			//Si la forma de pago es en Cuenta Personal y el colegiado no tiene saldo.
			formapago = ''
			banco_pago = ''
			dw_lista_receptores.SetItem(fila,'pagado','N')
			dw_lista_receptores.SetItem(fila,'f_pago',f_nula)
		end if
	end if

	dw_lista_receptores.SetItem(fila,'f_factura',datetime(today()))
	dw_lista_receptores.SetItem(fila,'formapago',formapago)
	dw_lista_receptores.SetItem(fila,'banco',banco_pago)
	dw_lista_receptores.SetItem(fila,'facturado',ds_col.GetItemString(i,'facturado'))
	email=f_devuelve_mail_profesional(id_col)
	dw_lista_receptores.SetItem(fila,'mail',email)
	dw_lista_receptores.SetItem(fila,'facturas_pendientes','N')
	//Si gestionamos las facturas pendientes entonces buscamos las facturas del colegiado...
	if i_opciones.gestion_facturas_pendientes then this.Event csd_facturas_pendientes(id_col)

next	

if not(f_es_vacio(lista_baja)) then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Los siguientes colegiados est$$HEX1$$e100$$ENDHEX$$n dados de baja:"+cr+lista_baja	)
end if

destroy(ds_col)
end event

event csd_agregar_clientes_fase();long i,fila,cuantos,informes
datastore ds_cli
double porcen_total=0,porcen_parcial,importe_gastos,porcen
string id_cliente,facturado,pagador,email,formapago
datetime f_nula

cuantos = 0
importe_gastos = 0
SetNull(f_nula)
ds_cli = create datastore
ds_cli.dataobject = 'd_fases_promotores'
ds_cli.SetTransObject(SQLCA)

ds_cli.Retrieve(i_id_fase)

informes = Message.WordParm

formapago=g_forma_pago_por_defecto
for i= 1 to ds_cli.rowcount()
	id_cliente = ds_cli.GetItemString(i,'id_cliente')
	facturado = ds_cli.GetItemString(i,'facturado')
	pagador   = ds_cli.GetItemString(i,'pagador')
	porcen = ds_cli.GetItemNumber(i,'porcen')
	porcen_total = ds_cli.GetItemNumber(i,'suma')

	if (porcen_total = 0 or isnull(porcen_total)) then return
	//Comprobamos si hay importes
	select sum(cuantia_cliente) into :importe_gastos from fases_informes where id_fase = :i_id_fase;
	if importe_gastos = 0 then return
	
	if pagador = 'N' or porcen=0 or isnull(porcen) then continue
	if facturado='S' then continue	
	
	fila = dw_lista_receptores.InsertRow(0)
	dw_lista_receptores.SetItem(fila,'id',id_cliente)
	dw_lista_receptores.SetItem(fila,'descripcion',f_dame_cliente(ds_cli.GetItemString(i,'id_cliente')))
	dw_lista_receptores.SetItem(fila,'porcentaje',porcen)//Porcentaje absoluto	
	dw_lista_receptores.SetItem(fila,'tipo','P')	//Promotores
	if i_datos_fase.proforma='S' then
		dw_lista_receptores.object.pagado.visible=false
		dw_lista_receptores.object.f_pago.visible=false
		dw_lista_receptores.object.pagado_t.visible=false
	else
		if formapago='DB' or formapago='PE' or formapago='PP' then
			dw_lista_receptores.SetItem(fila,'pagado','N')
			dw_lista_receptores.SetItem(fila,'f_pago',f_nula)
		else
			dw_lista_receptores.SetItem(fila,'pagado','S')
			dw_lista_receptores.SetItem(fila,'f_pago',datetime(today()))
		end if			
	end if
	dw_lista_receptores.SetItem(fila,'f_factura',datetime(today()))
	dw_lista_receptores.SetItem(fila,'facturado',facturado)
	email=f_devuelve_mail_persona(id_cliente,'P')
	dw_lista_receptores.SetItem(fila,'mail',email)
	dw_lista_receptores.SetItem(fila,'formapago',formapago)
	dw_lista_receptores.SetItem(fila,'banco',g_banco_por_defecto)
next	

destroy(ds_cli)
end event

event csd_genera_gastos();//Este evento genera todos los gastos que se han generado en la fase
long i,fila,j, ll_found, cont
double cuantia_informe_inicial,cuantia_col,cuantia_cli,cuantia_facturada, cuantia_facturada_receptores
double por, retorno, importe_temp, por_temp, minimo_tarifa
string tipo_factura

cuantia_facturada=0

st_factufa_lineas_factura st_lineas
st_musaat_datos st_musaat_datos

SELECT pem INTO :id_pem FROM fases_usos WHERE id_fase = :i_id_fase ;

//Primero insertamos informes
for i= 1 to i_ds_informes.rowcount()
	
	st_lineas.id_articulo = i_ds_informes.GetItemString(i,'tipo_informe')
	///*** SCP-1126. Alexis. 08/03/2011. Se pasa el dato de la empresa proviniente  de fases_informes ***///
	st_lineas.cod_empresa = i_ds_informes.GetItemString(i,'empresa')
	st_lineas.texto_adicional =f_csi_articulo_descripcion(st_lineas.id_articulo, st_lineas.cod_empresa)
	st_lineas.t_iva 		= i_ds_informes.GetItemString(i,'t_iva')
	cuantia_col = i_ds_informes.GetItemNumber(i,'cuantia_colegiado')
	cuantia_cli = i_ds_informes.GetItemNumber(i,'cuantia_cliente')
	
	

	for j= 1 to dw_lista_receptores.rowcount()
	
		st_lineas.importe_individual=0
		st_lineas.tipo   = dw_lista_receptores.GetItemString(j,'tipo')
		// tipo_cliente-factura
		IF st_lineas.tipo  = 'C' THEN 
			tipo_factura = g_colegio_colegiado
			cuantia_informe_inicial = cuantia_col
			
		ELSEIF st_lineas.tipo  = 'P' THEN
			tipo_factura = g_colegio_cliente
			cuantia_informe_inicial = cuantia_cli
		END IF
		//Redondeamos la cuantia inicial para evitar problemas al compararla con el total facturado que viene redondeado.
		cuantia_informe_inicial=f_redondea(cuantia_informe_inicial)
		st_lineas.cuantia_informe_inicial = cuantia_informe_inicial
		st_lineas.id	  = dw_lista_receptores.GetItemString(j,'id')
		st_lineas.nombre_cliente = dw_lista_receptores.GetItemString(j,'descripcion')
		por  = dw_lista_receptores.GetItemNumber(j,'porcentaje') // Quitado f_redondea para q vaya bien con porcentajes como 33.33333
		por_temp = por
		
		//scp-1295 Se verifica para el tipo de tramite si el articulo aplica el porcentaje de participaci$$HEX1$$f300$$ENDHEX$$n
		if f_aplica_part_articulo_tramite(i_datos_fase.tipo_tramite, g_colegio, st_lineas.id_articulo) = 'N' then 
			dw_lista_receptores.setfilter("tipo = 'C'")
			dw_lista_receptores.filter()

			por_temp = 100/dw_lista_receptores.rowcount()
			dw_lista_receptores.setfilter("")
			dw_lista_receptores.filter()
			st_lineas.aplica_porc_part  = 'N'
		else
			st_lineas.aplica_porc_part  = 'S'
		end if
						
		//importe_temp_total=  f_redondea(f_total_concepto_fases_informes(i_id_fase,  st_lineas.id_articulo, st_lineas.tipo))
		importe_temp=  f_redondea((f_total_concepto_fases_informes_receptor(i_id_fase,  st_lineas.id_articulo, st_lineas.tipo)*por_temp)/100)
		cuantia_facturada = f_total_facturado_concepto(i_id_fase, st_lineas.id_articulo, tipo_factura, st_lineas.id, '%')
		cuantia_facturada_receptores = f_total_facturado_concepto(i_id_fase, st_lineas.id_articulo, tipo_factura, '%', '%')
		st_lineas.porc_participacion=por
		
		if (cuantia_informe_inicial <> 0 and (cuantia_informe_inicial <> cuantia_facturada_receptores)) then 
			// Caso General (NO MUSAAT)
			IF st_lineas.id_articulo <>  g_codigos_conceptos.musaat_variable THEN 
				st_lineas.tipo_musaat = '' 
				st_lineas.porcentaje = 100
				if importe_temp>0 then 
					st_lineas.importe_individual =importe_temp
				else
					st_lineas.importe_individual = f_redondea((cuantia_informe_inicial*por)/100)
				end if
				
				///*** SCP-1542.Alexis.28/09/2011. En caso de tener activa la variable, se comparacontra el minimo ***///
				if funcion_aplica_minimos_facturacion() = 'S' then
					minimo_tarifa = funcion_obtener_minimo_tarifa(i_id_fase, st_lineas.id_articulo)
					if minimo_tarifa <> -1 then
						st_lineas.importe_individual = max( st_lineas.importe_individual , minimo_tarifa )
					end if			
				end if
				
				st_lineas.importe_individual= st_lineas.importe_individual - cuantia_facturada
							
			
			ELSE
			// MUSAAT
				st_musaat_datos = f_musaat_tipo_movimiento_facturar(i_id_fase,st_lineas.id,cuantia_facturada)
				st_lineas.tipo_musaat = st_musaat_datos.tipo_csd
				st_lineas.porcentaje = st_musaat_datos.porcentaje
				// C$$HEX1$$e100$$ENDHEX$$lculo prima Musaat
					st_musaat_datos.n_visado = i_id_fase
					st_musaat_datos.id_col = st_lineas.id
					st_musaat_datos.id_minuta = ''
					st_musaat_datos.recuperar = TRUE
					st_musaat_datos.genera_movi = FALSE
					
					//if st_musaat_datos.tipo_csd= '23' or st_musaat_datos.tipo_csd= '25' then
						//int l
						//l= f_musaat_importe_certificacion(st_musaat_datos, i_id_fase)
						// se debe verificar el pem_certificacion que debe cambiar seg$$HEX1$$fa00$$ENDHEX$$n lo que se ha puesto
						// en el campo importe
					//end if
				
					if f_colegiado_tipopersona( st_lineas.id) = 'S' then
						retorno = f_musaat_calcula_prima_sociedad(st_musaat_datos)			
					else
						retorno = f_musaat_calcula_prima(st_musaat_datos)
					end if	
					
					if st_musaat_datos.tipo_csd= '23' or st_musaat_datos.tipo_csd= '25'  or st_musaat_datos.tipo_csd= '20'then
						cuantia_informe_inicial = st_musaat_datos.prima_total
					else
						cuantia_informe_inicial = st_musaat_datos.prima_comp
					end if
					st_lineas.prima_total = st_musaat_datos.prima_total
				   
					st_lineas.pem =st_musaat_datos.pem
					// No se aplica el porcentaje, se aplica el c$$HEX1$$e100$$ENDHEX$$lculo individual

					if (cuantia_informe_inicial > cuantia_facturada) and (cuantia_facturada > 0) and (st_musaat_datos.tipo_csd = '10') then 
						st_lineas.tipo_musaat = '20'
					end if 
					
					st_lineas.importe_individual = f_redondea(cuantia_informe_inicial - cuantia_facturada)
					IF g_musaat_aplica_calculo_pc_2015 = 'S' AND NOT f_musaat_tiene_certificaciones(i_id_fase) and not(st_musaat_datos.tipo_csd= '23' or st_musaat_datos.tipo_csd= '25') THEN st_lineas.importe_individual = 0
			END IF 
		END IF
		
		if st_lineas.importe_individual = 0 then continue

		st_lineas.importe_facturar = st_lineas.importe_individual 
		st_lineas.importe_iva = f_aplica_t_iva(st_lineas.importe_facturar,st_lineas.t_iva)
		st_lineas.total_linea = f_redondea(st_lineas.importe_facturar + st_lineas.importe_iva)
		if dw_lista_gastos.rowcount() >0 then
			ll_found = dw_lista_gastos.Find("id_articulo='"+i_ds_informes.getitemstring(i,'tipo_informe') +"' and id='" +st_lineas.id +"'", 1, dw_lista_gastos.RowCount())
		end if
		if ll_found> 0 then continue
		wf_inserta_linea_gastos(st_lineas)
	next		
	

next			
end event

event csd_actualiza_totales_gastos();long i 
double base=0,importe_facturar=0,impuestos=0,total=0
string t_iva,exento

for i= 1 to dw_lista_gastos.RowCount()
	if dw_lista_gastos.getitemstring(i, 'facturar') = 'S' then
	importe_facturar = dw_lista_gastos.GetItemNumber(i,'importe_facturar')
	
	IF NOT(f_es_vacio(g_t_iva_00)) AND NOT(f_es_vacio(g_t_iva_exento)) THEN 
		
	ELSE

	END IF
	
	base = base + importe_facturar
	impuestos = impuestos + dw_lista_gastos.GetItemNumber(i,'importe_iva')	
	total = total + dw_lista_gastos.GetItemNumber(i,'total_factura')
end if
next

dw_total_gastos.SetItem(1,'base',base)
dw_total_gastos.SetItem(1,'importe_iva',impuestos)
dw_total_gastos.SetItem(1,'total',total)


end event

event type long csd_factura(string facturar_musaat_diferenciado, string as_empresa);///*** SCP-1055. Se a$$HEX1$$f100$$ENDHEX$$ade el par$$HEX1$$e100$$ENDHEX$$metro as_empresa para que este evento s$$HEX1$$f300$$ENDHEX$$lo se encargue de facturar los conceptos relacionados con una empresa.. Alexis. 01/03/2011 ***///

string mensaje = ''
string id_factura,id_linea_musaat, t_iva, serie, id_articulo, ls_serie_abono, tipo_musaat
long retorno = 1, fila_cabecera, fila_conceptos, fila_anyadida
double uds, precio, subtotal, subtotal_dto, subtotal_iva, total, porcen_dto, base_imp, importe_musaat, porcentaje_musaat, pem_certificacion, prima_total, total_factura
datetime fecha
string receptor,id_empresa,id_pagador,tipo_pagador
st_musaat_datos st_musaat_datos
datastore ds_datos_pagos
long ll_id_pago_conciliado
int i

ll_id_pago_conciliado  = -1

// Se invoca a f_factura en funci$$HEX1$$f300$$ENDHEX$$n de los valores en pantalla para su generaci$$HEX1$$f300$$ENDHEX$$n 
// Se puede elegir c$$HEX1$$f300$$ENDHEX$$mo facturar: 
//		* Todo, de forma conjunta en una misma factura (facturar_musaat_diferenciado='%')
//		* S$$HEX1$$f300$$ENDHEX$$lo el MUSAAT => (facturar_musaat_diferenciado='SOLO_MUSAAT_PV')
// 		* Todo Menos MUSAAT => (facturar_musaat_diferenciado='NO_MUSAAT_PV')
SetPointer(Hourglass!)
	
	fecha = dw_lista_receptores.GetItemDateTime(dw_lista_Receptores.GetRow(),'f_factura')
	IF f_es_vacio(facturar_musaat_diferenciado) THEN facturar_musaat_diferenciado = '%'
	//////////////////////////////////////////////
	// GENERACION LINEAS
	//////////////////////////////////////////////
	datastore ds_lineas_factura
	ds_lineas_factura = create Datastore
	ds_lineas_factura.DataObject = 'd_fases_lineas_facturas'
	ds_lineas_factura.SetTransObject(SQLCA)
	tipo_musaat = ''

	// Recorremos las lineas para saber cuanto sube la factura
	FOR fila_conceptos = 1 TO dw_lista_gastos.Rowcount()		
		// S$$HEX1$$f300$$ENDHEX$$lo se procesan filas seleccionadas
		IF dw_lista_gastos.getitemstring(fila_conceptos,'facturar')= 'N' THEN CONTINUE
		///*** SCP-1055. Alexis. 01/03/2011. Si la empresa es diferente a la enviada, no se facturar$$HEX2$$e1002000$$ENDHEX$$el concepto en ese momento. ***///
		if dw_lista_gastos.getItemstring(fila_conceptos,'empresa') <> as_empresa then CONTINUE
		
		id_articulo = dw_lista_gastos.object.id_articulo[fila_conceptos]
		
		// Excepci$$HEX1$$f300$$ENDHEX$$n para Facturar la Prima Variable de MUSAAT en otra factura diferenciada. Se aplica filtrado para seleccionar las l$$HEX1$$ed00$$ENDHEX$$neas a generar.
		CHOOSE CASE facturar_musaat_diferenciado 
			CASE '%'  
				// Se procesan y se a$$HEX1$$f100$$ENDHEX$$aden todos los conceptos a la factura. No se quita nada.
			CASE 'SOLO_MUSAAT_PV'
				IF id_articulo <> g_codigos_conceptos.musaat_variable THEN 
						CONTINUE 			
				END IF
			CASE 'NO_MUSAAT_PV'
				IF id_articulo = g_codigos_conceptos.musaat_variable THEN 
					CONTINUE 			
				END IF
		END CHOOSE 
		
		// Calculamos los totales de la cabecera, por lo que necesitamos coger los datos de las lineas
		uds			= 1
		precio		= dw_lista_gastos.getitemnumber(fila_conceptos,'importe_facturar')
		t_iva			= dw_lista_gastos.getitemstring(fila_conceptos,'t_iva')
		if isnull(porcen_dto) then porcen_dto=0
		subtotal 		= precio
		subtotal_dto 	= subtotal*porcen_dto/100
		// El IVA se calcula despues de descuento
		subtotal_iva 	= f_redondea(f_aplica_t_iva(subtotal - subtotal_dto,t_iva))
		// Evitamos los nulos
		if IsNull(subtotal) then subtotal = 0
		if isnull(uds) then uds=1
		if IsNull(subtotal_dto) then subtotal_dto = 0
		if IsNull(subtotal_iva) then subtotal_iva = 0
		total = subtotal + subtotal_iva
		
		total_factura += total
		// Colocamos los datos en el datastore para que se puedan luego pasar a la funcion f_factura
		// Uso la notaci$$HEX1$$f300$$ENDHEX$$n dot por ser m$$HEX1$$e100$$ENDHEX$$s r$$HEX1$$e100$$ENDHEX$$pida en ejecucion
		fila_anyadida = ds_lineas_factura.insertrow(0)
		ds_lineas_factura.object.descripcion[fila_anyadida] = dw_lista_gastos.object.texto_adicional[fila_conceptos]
		ds_lineas_factura.object.precio[fila_anyadida] = precio
		ds_lineas_factura.object.unidades[fila_anyadida] = uds
		ds_lineas_factura.object.subtotal[fila_anyadida] = precio
		ds_lineas_factura.object.t_iva[fila_anyadida] =t_iva
		ds_lineas_factura.object.subtotal_iva[fila_anyadida] = subtotal_iva
		ds_lineas_factura.object.total[fila_anyadida] = total
		ds_lineas_factura.object.articulo[fila_anyadida] = id_articulo
		ds_lineas_factura.object.porcent_dto[fila_anyadida] = porcen_dto
		ds_lineas_factura.object.descripcion_larga[fila_anyadida] = dw_lista_gastos.object.texto_adicional[fila_conceptos]
		
		// Se almacena en variables para un proceso posterior datos del MUSAAT s$$HEX1$$f300$$ENDHEX$$lo si el concepto MUSAAT
		IF id_articulo = g_codigos_conceptos.musaat_variable THEN 
			tipo_musaat = dw_lista_gastos.object.tipo_musaat[fila_conceptos]
			importe_musaat = precio
			porcentaje_musaat = dw_lista_gastos.object.porc_participacion[fila_conceptos]
			pem_certificacion= dw_lista_gastos.getitemdecimal(fila_conceptos,'pem')
			prima_total = dw_lista_gastos.getitemdecimal(fila_conceptos,'prima_total')
		END IF
	NEXT
	//////////////////////////////////////////////
	// FIN GENERACION LINEAS
	//////////////////////////////////////////////

	i_datos_facturacion.id_fase			= i_id_fase
	i_datos_facturacion.fecha				= fecha
	i_datos_facturacion.fecha_factura	= fecha // En COAATMCA estaba asignando 01/01/1900 si no se inicializa
	i_datos_facturacion.proforma  		= dw_tipo_facturacion.getitemstring(1,'proforma')
	
	// Diferenciaci$$HEX1$$f300$$ENDHEX$$n Serie
	CHOOSE CASE  i_datos_facturacion.proforma 
		// 	SI PROFORMA	
		CASE  'S' 
			serie = g_serie_proforma 
		
		// SI FACTURAMOS 
		CASE ELSE 
			IF facturar_musaat_diferenciado = 'SOLO_MUSAAT_PV' THEN // Se le asigna la serie exclusiva de Musaat PV si se factura s$$HEX1$$f300$$ENDHEX$$lo este concepto
				serie =  g_fases_serie_musaat// dw_tipo_facturacion.getitemstring(1,'serie')
				//  Si negativo...
				//IF total <0 THEN 
				If total_factura < 0 then
					select serie_abono into :ls_serie_abono from csi_series where serie = :serie and empresa = :as_empresa and anyo = :g_ejercicio;
					if not f_es_vacio(ls_serie_abono) then serie = ls_serie_abono
				END IF // Si negativo...
				
			ELSE
				
				select serie
				into :serie
				from csi_series 
				where empresa = :as_empresa and anyo = :g_ejercicio and serie_por_defecto = 'S';
				
				if f_es_vacio(serie) then serie = g_serie_fases
				// Si negativo...
				If total_factura < 0 then
					select serie_abono into :ls_serie_abono from csi_series where serie = :serie and empresa = :as_empresa and anyo = :g_ejercicio;
					if not f_es_vacio(ls_serie_abono) then 
						serie = ls_serie_abono
					else
						if  f_empresa_es_colegio2(as_empresa) = 'S' then 
							serie = g_facturas_negativas_serie
						end if
					end if
				END IF // Si negativo...
			END IF // facturar_musaat_diferenciado S/N
	END CHOOSE	// SI PROFORMAMOS/FACTURAMOS 
	i_datos_facturacion.serie = serie  
	i_datos_facturacion.incluir_todos	= 'S'
	i_datos_facturacion.anulada			= 'N'	
	i_datos_facturacion.pagada			= dw_lista_receptores.GetItemString(dw_lista_Receptores.GetRow(),'pagado')
	i_datos_facturacion.fecha_pago 	= dw_lista_receptores.GetItemDateTime(dw_lista_Receptores.GetRow(),'f_pago')
	i_datos_facturacion.formapago		= dw_lista_receptores.GetItemString(dw_lista_Receptores.GetRow(),'formapago')
	i_datos_facturacion.banco 			= dw_lista_receptores.GetItemString(dw_lista_Receptores.GetRow(),'banco')
	
	///***SCP-1055. Alexis. 01/03/2011. Se pasa el dato de la empresa para que se introduzca en la factura. ***///
	i_datos_facturacion.cod_empresa = as_empresa
	
	
	// Asunto: lo asignamos de forma gen$$HEX1$$e900$$ENDHEX$$rica (mismo para todos) pese a que en f_factura hab$$HEX1$$ed00$$ENDHEX$$a diferenciaciones
	// 12/11/10 Por defecto ser$$HEX2$$e1002000$$ENDHEX$$siempre el miismo valor: N$$HEX1$$ba00$$ENDHEX$$Reg + N$$HEX2$$ba002000$$ENDHEX$$Cli
	string as_n_reg, as_cli, as_n_salida
	select n_registro into :as_n_reg from fases where id_fase = :i_datos_facturacion.id_fase;
	select clientes.apellidos into :as_cli from clientes, fases_clientes where fases_clientes.id_fase = :i_datos_facturacion.id_fase and fases_clientes.id_cliente = clientes.id_cliente;
		if f_es_vacio(as_cli) then as_cli=''
		//as_n_salida =  f_fases_n_salida(i_id_fase)
		as_n_salida = ''
		if NOT(f_es_vacio(as_n_salida)) THEN 
			as_n_salida +=  'N.Sal.'+as_n_salida+'; '
			as_n_reg = ''
		else
			as_n_salida =  ''
			as_n_reg = 'N.Ref.'+as_n_reg+'; '
		end if

	// Se pondr$$HEX2$$e1002000$$ENDHEX$$en primer lugar el N$$HEX2$$ba002000$$ENDHEX$$Visado si existe. En caso que no, el N$$HEX2$$ba002000$$ENDHEX$$Registro. A continuaci$$HEX1$$f300$$ENDHEX$$n, el cliente.
	i_datos_facturacion.asunto			= as_n_salida + as_n_reg+'Cli.: '+as_cli
	i_datos_facturacion.obs				= ''	
	i_datos_facturacion.incluir_todos  = 'S'
	
	receptor= dw_lista_receptores.GetItemString(dw_lista_Receptores.GetRow(),'receptor')	
	i_datos_facturacion.id_receptor = dw_lista_receptores.GetItemString(dw_lista_Receptores.GetRow(),'id')
	id_empresa=dw_lista_receptores.GetItemString(dw_lista_Receptores.GetRow(),'id_empresa')
	id_pagador=dw_lista_receptores.GetItemString(dw_lista_Receptores.GetRow(),'id_pagador')	
	tipo_pagador=dw_lista_receptores.GetItemString(dw_lista_Receptores.GetRow(),'tipo_pagador')	
	
    if receptor ='E' then
          dw_lista_receptores.SetItem(dw_lista_Receptores.GetRow(),'tipo','P')	
		 i_datos_facturacion.id_receptor = id_empresa
    end if
	
	i_datos_facturacion.tipo_factura = wf_tipo_factura(dw_lista_receptores.GetItemString(dw_lista_Receptores.GetRow(),'tipo'))
	
	// Si se debe conciliar pagos y el receptor se trata de un colegiado
	if ibl_conciliar_pago=true and receptor ='C' then 
		// Comprobamos si dispone de un pago sin conciliar el colegiado para la fase
		ds_datos_pagos= f_obtener_pagos_no_conciliados( i_datos_facturacion.id_fase, i_datos_facturacion.id_receptor)
		
		if IsValid(ds_datos_pagos)then 
			//if (total_factura = lst_fases_pagos.importe_pago)
			for i=1 to ds_datos_pagos.rowcount()
				if ll_id_pago_conciliado > -1 then continue

				if (total_factura = ds_datos_pagos.getitemnumber( i, 'importe_pago')) then 
					ll_id_pago_conciliado = ds_datos_pagos.getitemnumber( i, 'id_fases_pagos_plataforma')
					ds_datos_pagos.setitem( i, 'conciliado', 'S')
					//Los datos se guardan una vez generada la factura. Ahora actualizamos la forma de pago de la factura.
					
					i_datos_facturacion.formapago		= ds_datos_pagos.GetItemString(i,'forma_pago_plataforma')
					if i_datos_facturacion.formapago = g_formas_pago.domiciliacion then 
						i_datos_facturacion.pagada	= 'N'
					else	
						i_datos_facturacion.banco = ds_datos_pagos.getitemstring( i, 'banco')
						if i_datos_facturacion.formapago = g_formas_pago.transferencia and ibl_avisado= false then 
							ibl_avisado = true 
							MessageBox(g_titulo,'Se ha conciliado facturas con forma de pago por Transferencia' + cr + 'Recuerde revisar el justificante del pago correspondiente')
						end if 	
						i_datos_facturacion.pagada	= 'S'
					end if	
					
				end if	
					
			next 	
		end if 	
	end if 	

	
	
	//if receptor='E' then
		//i_datos_facturacion.es_empresa=true
	if receptor='C' and tipo_pagador<>'A' then
		//Unificamos los funcionamientos
		i_datos_facturacion.imprime_cta_banco_col='N'
		i_datos_facturacion.paga_empresa='S'
		i_datos_facturacion.paga_externo='S'
		i_datos_facturacion.id_cliente_pagador= id_pagador
	elseif receptor='C' and tipo_pagador='A' then
		i_datos_facturacion.imprime_cta_banco_col='S'
		i_datos_facturacion.paga_empresa='S'
		i_datos_facturacion.paga_externo='S'
		i_datos_facturacion.id_cliente_pagador= id_empresa
	else
		i_datos_facturacion.imprime_cta_banco_col='N'
		i_datos_facturacion.paga_empresa='N'		
		i_datos_facturacion.paga_externo='N'

	end if

	// Pasamos el datastore
	i_datos_facturacion.ds_lineas = ds_lineas_factura
	
	//////////////////////////////////////////////
	// GENERACION FACTURA
	//////////////////////////////////////////////
	
	id_factura = f_factura(i_datos_facturacion)
	IF id_factura = '-1' then 
		retorno = -1
	ELSE 
		wf_imprimir(id_factura)
		retorno = 1
		
		// Continuamos S$$HEX1$$f300$$ENDHEX$$lo si hay l$$HEX1$$ed00$$ENDHEX$$nea de MUSAAT...
		id_linea_musaat = f_musaat_id_linea_factura (id_factura)
		 IF NOT(f_es_vacio(id_linea_musaat)) THEN
			// => Backup de datos de MUSAAT 
			//////////////////////////////////////////////
			string id_musaat, n_contrato_ant
			double pem
				id_musaat = f_siguiente_numero ('MUSAAT_PARAMS_FE',10)
				SELECT n_contrato_ant INTO :n_contrato_ant FROM fases WHERE id_fase = :i_id_fase ;
				SELECT pem INTO :pem FROM fases_usos WHERE id_fase = :i_id_fase ;
				
				if tipo_musaat= '23' or tipo_musaat= '25' or tipo_musaat= '20' then pem = pem_certificacion
				
				INSERT INTO musaat_params_linea_fe (id_musaat, id_linea, pem_certificacion, tipo_csd, n_contrato_ant, porcentaje, base_musaat, prima_total, id_col) 
					VALUES (:id_musaat, :id_linea_musaat, :pem, :tipo_musaat, :n_contrato_ant, :porcentaje_musaat, :importe_musaat, :prima_total, :i_datos_facturacion.id_receptor );
			
			// => Alta de datos de MUSAAT si Facturamos (si no PROFORMA)
			//////////////////////////////////////////////
			// comprueba dentro de la funci$$HEX1$$f300$$ENDHEX$$n no sea Proforma //IF i_datos_fase.proforma = 'N' THEN 
			f_musaat_alta_movimiento_facturar (id_factura)

			else
				f_crear_movimientos_tarifa_d(i_id_fase)
			
		END IF // S$$HEX1$$f300$$ENDHEX$$lo si hay l$$HEX1$$ed00$$ENDHEX$$nea de factura de MUSAAT	
		
		// Incrementamos el n$$HEX2$$ba002000$$ENDHEX$$de docs. creados
		i_num_facturas_creadas++
		
		/// Se guarda datos de la conciliaci$$HEX1$$f300$$ENDHEX$$n si corresponde. 
		if (ll_id_pago_conciliado > -1) then
						
			datastore ds_fases_pagos_facturas
			ds_fases_pagos_facturas = create datastore
			ds_fases_pagos_facturas.dataobject = 'd_fases_pagos_facturas'
			ds_fases_pagos_facturas.settransobject(sqlca)
			
			i = ds_fases_pagos_facturas.insertrow(0)
			ds_fases_pagos_facturas.setitem(i, 'id_fases_pagos_plataforma', ll_id_pago_conciliado)
			ds_fases_pagos_facturas.setitem(i, 'id_factura',id_factura)			
			ds_fases_pagos_facturas.setitem(i, 'n_fact', f_dame_n_fact_de_id(id_factura) )
			ds_fases_pagos_facturas.setitem(i, 'n_col', f_colegiado_n_col(id_pagador) )
			ds_fases_pagos_facturas.setitem(i, 'total', total_factura)
			
			ds_datos_pagos.update( )
			ds_fases_pagos_facturas.update()
			destroy ds_fases_pagos_facturas
			
		end if 	
		
	END IF
	//////////////////////////////////////////////
	// FIN GENERACION FACTURA
	//////////////////////////////////////////////
	destroy ds_lineas_factura
	destroy ds_datos_pagos

RETURN retorno 
end event

event csd_marcar_facturado(string tipo, string id);int i

if tipo = 'C'  then // es un colegiado
	update fases_colegiados set facturado = 'S' where id_fase = :i_id_fase and id_col = :id;
else		//es un promotor
	update fases_clientes set facturado = 'S' where id_fase = :i_id_fase and id_cliente = :id;
end if

commit;
end event

event type string csd_comprobar_abono_total();boolean parcial = false,pago_postpuesto = false//,faltan_honorarios = false
int i,vencimiento
double cant_pendiente=0,cant=0,honorarios_totales=0//,hon,hon_iva
string retorno,formapago

/*retorno = i_datos_fase.estado

f_desactiva_filtro_gastos()
f_desactiva_filtro_honorarios()

//select honorarios,honorariosiva into :hon,:hon_iva from fases_honorarios where id_fase = :i_datos_fase.id_fase;
//if isnull(hon) then hon=0
//if isnull(hon_iva) then hon_iva=0

for i=1 to dw_lista_gastos.RowCount()
	cant = cant + dw_lista_gastos.GetItemNumber(i,'total_factura')
	if dw_lista_gastos.GetItemString(i,'facturado')='S' then continue
	cant_pendiente = cant_pendiente + dw_lista_gastos.GetItemNumber(i,'total_factura')
next

if i_datos_fase.tipo_gestion='C' then
	for i=1 to dw_honorarios.RowCount()
		cant = cant + dw_honorarios.GetItemNumber(i,'total_factura')
		honorarios_totales = honorarios_totales + dw_honorarios.GetItemNumber(i,'total_factura')
		if dw_honorarios.GetItemString(i,'facturado')='S' then continue
		cant_pendiente = cant_pendiente + dw_honorarios.GetItemNumber(i,'total_factura')
	next
end if

if i_datos_fase.tipo_gestion = 'F' then
	update fases_minutas set pendiente ='N' where id_fase= :i_id_fase;
end if

if i_opciones.gestion_pagos_postpuestos then
	if i_datos_fase.tipo_gestion = 'C' then pago_postpuesto = true 
end if

//if honorarios_totales > hon + hon_iva then faltan_honorarios=true

// LUIS 27/10/2005: Para que no se quede el estado no abonado si no hay gastos
if cant_pendiente = 0 and i_datos_fase.tipo_gestion = 'F' then return 'AC'

if cant_pendiente = cant then return '-1'


if cant_pendiente>0 then 
	retorno ='AP'	//Abonado parcial
else
	if not pago_postpuesto then
		retorno = 'AC'   //Abonado Completo
	else
		retorno = i_opciones.estado_pagos_postpuestos
	end if
end if
//Si no es ninguno de los casos anteriores el estado no cambia, es el que ten$$HEX1$$ed00$$ENDHEX$$amos...

*/return retorno
end event

event csd_facturar_todo();long i,linea_origen//,copias,j

SetPointer(HourGlass!)    
linea_origen = dw_lista_receptores.GetRow()

//copias = idw_formatos_impresion.Getitemnumber(1,'originales')

//dw_lista_receptores.SetRedraw(FALSE)
//dw_lista_gastos.SetRedraw(FALSE)
//dw_total_gastos.SetRedraw(FALSE)


//  VALIDACION DEL IVA 2010 //
integer res
boolean lb_error

for i=1 to dw_lista_receptores.RowCount()
	dw_lista_receptores.SetRow(i)
	dw_lista_receptores.Event RowFocusChanged(i)	
	res=event csd_validar_iva_2010(i)
	if res<0 then
		lb_error=true
		exit
	end if
next

If lb_error then 
	if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Alguno de los conceptos a facturar tiene un tipo de IVA distinto al que le corresponde seg$$HEX1$$fa00$$ENDHEX$$n la fecha de facturaci$$HEX1$$f300$$ENDHEX$$n.$$HEX1$$bf00$$ENDHEX$$Desea continuar?",Question!,YesNo!)<>1 then
		dw_lista_receptores.SetRedraw(TRUE)
		dw_lista_gastos.SetRedraw(TRUE)
		dw_total_gastos.SetRedraw(TRUE)
		cb_cerrar.enabled = true
		SetPointer(Arrow!)		
		return
	end if
end if

// FIN DE VALIDACIONES DEL IVA

//Validamos el saldo disponible en la cuenta personal

string id,tipo

if i_datos_fase.proforma = 'N' then
	for i=1 to dw_lista_receptores.RowCount()
		//Para aquellos colegiados que tengan seleccionada la forma de pago 'Cuenta personal' validamos que tenga saldo suficiente
		if dw_lista_receptores.getItemString(i,'formapago') =  g_formas_pago.cuenta_personal and dw_lista_receptores.getItemString(i,'pagado')='S' and dw_lista_receptores.getItemString(i,'tipo')='C' then
			id =dw_lista_receptores.getItemString(i,'id')
			tipo=dw_lista_receptores.getItemString(i,'tipo')
		
			if wf_estado_cuenta_colegiado(tipo,id)= 0 then
				dw_lista_receptores.setItem(i,'no_saldo','S')
				i_no_saldo=true
			end if
		elseif dw_lista_receptores.getItemString(i,'formapago') =  g_formas_pago.cuenta_personal and dw_lista_receptores.getItemString(i,'tipo')='P' then
			i_cliente_externo=true
			
		end if
		
	next
end if

//Fin Validaci$$HEX1$$f300$$ENDHEX$$n saldo cuenta personal
	
if i_no_saldo=true or i_cliente_externo=true then	
	return
else
	for i=1 to dw_lista_receptores.RowCount()
	//	if dw_lista_receptores.GetItemString(i,'facturado') ='S' then continue
		dw_lista_receptores.SetRow(i)
		dw_lista_receptores.Event RowFocusChanged(i)
		this.TriggerEvent('csd_facturar_seleccion')
	next
	
	dw_lista_receptores.SetRow(linea_origen)
	dw_lista_receptores.Event RowFocusChanged(linea_origen)
	dw_lista_receptores.SetRedraw(TRUE)
	dw_lista_gastos.SetRedraw(TRUE)
	dw_total_gastos.SetRedraw(TRUE)
	SetPointer(Arrow!)
end if
end event

event csd_facturar_seleccion();//Tenemos que imprimir las facturas de gastos y honorarios q tenemos en pantalla...
string nombre_destinatario,mail

if wf_comprobar_hay_gastos_seleccionados('') = 0 then 
// 19/11/10  S$$HEX1$$f300$$ENDHEX$$lo en el caso que se haya aplicado la facturaci$$HEX1$$f300$$ENDHEX$$n del Receptor Seleccionado, se muestra el mensaje si no hay l$$HEX1$$ed00$$ENDHEX$$neas de gastos con importes para ser facturados para un determinado receptor
	IF  dw_tipo_facturacion.GetItemString(1,'tipo') = 'S' THEN
		nombre_destinatario = dw_lista_receptores.GetItemString(dw_lista_receptores.GetRow(),'descripcion')
		IF IsNull(nombre_destinatario) THEN nombre_destinatario = ''
		MessageBox(g_titulo,'Para el destinatario '+nombre_destinatario+' no hay gastos seleccionados.')
	END IF
	RETURN 
end if

//select t_iva into :t_iva_exento from csi_t_iva where exento = 'S' ;
//f_pago = dw_lista_receptores.GetItemDatetime(dw_lista_receptores.GetRow(),'f_pago')
//gastos = dw_lista_receptores.GetItemString(dw_lista_receptores.GetRow(),'emitir_gastos')
//id = dw_lista_receptores.GetItemString(dw_lista_receptores.GetRow(),'id')
//tipo = dw_lista_receptores.GetItemString(dw_lista_receptores.GetRow(),'tipo')
mail = dw_lista_receptores.GetItemString(dw_lista_receptores.GetRow(),'mail')

i_impresion_formato.direccion_email = mail
this.event csd_opciones_impresion()
//this.TriggerEvent('csd_resetea_factura')
if f_es_vacio(dw_lista_receptores.getItemString(dw_lista_receptores.GetRow(),'formapago')) and dw_lista_receptores.getItemString(dw_lista_receptores.GetRow(),'pagado')='S' then
	MessageBox(g_titulo,'Para el colegiado '+dw_lista_receptores.getItemString(dw_lista_receptores.GetRow(),'descripcion')+' no es posible facturar conceptos sin forma de pago y marcados como pagados.')
else
	///*** SCP-1055. Se cambia los eventos csd_factura por csd_factura_por_empresa para que sea capaz de diferenciar la facturaci$$HEX1$$f300$$ENDHEX$$n por empresas. Alexis. 01/03/2011***///
	IF g_facturar_musaat_pc_serie_aparte = 'S' THEN 
		IF wf_comprobar_hay_gastos_seleccionados('NO_MUSAAT_PV') = 1 then // S$$HEX1$$f300$$ENDHEX$$lo se lanza el proceso si hay conceptos v$$HEX1$$e100$$ENDHEX$$lidos a procesar
			If this.Trigger Event csd_factura_por_empresa('NO_MUSAAT_PV') < 0 THEN MessageBox(g_titulo,'Se ha producido un error al crear la factura.')
		END IF
		IF wf_comprobar_hay_gastos_seleccionados('SOLO_MUSAAT_PV') = 1 then // S$$HEX1$$f300$$ENDHEX$$lo se lanza el proceso si hay conceptos v$$HEX1$$e100$$ENDHEX$$lidos a procesar
			If this.Trigger Event csd_factura_por_empresa('SOLO_MUSAAT_PV') < 0 THEN MessageBox(g_titulo,'Se ha producido un error al crear la factura.')
		END IF
	ELSE
		If this.Trigger Event csd_factura_por_empresa('%') < 0 THEN MessageBox(g_titulo,'Se ha producido un error al crear la factura.')
	END IF
end if



// Genero MUSAAT para colegiados....
/*IF tipo = 'C' THEN 
	st_musaat_datos.n_visado = i_id_fase
	st_musaat_datos.id_col = id
	st_musaat_datos.id_minuta = ''
	st_musaat_datos.tipo_csd = '10'
	st_musaat_datos.recuperar = TRUE
	st_musaat_datos.genera_movi = TRUE
	f_musaat_calcula_prima (st_musaat_datos)
END IF*/

/*
i_datos_facturacion.impresion_avanzada = i_impresion_formato
//Seguimos con los Gastos...Si tenemos activado el check de gastos 
	//A los clientes de momento no se les env$$HEX1$$ed00$$ENDHEX$$a documentaci$$HEX1$$f300$$ENDHEX$$n electr$$HEX1$$f300$$ENDHEX$$nica
	i_impresion_formato.pdf='N'
	i_impresion_formato.email= 'N'

if gastos='S' then
	//si se emite factura de ASEMAS a parte ... la tenemos que quitar de aki...
	if i_opciones.emitir_factura_asemas then
		filtro = "tipo = '"+ tipo +"' and id ='"+id+"' and asemas = 'N'"
		dw_lista_gastos.SetFilter(filtro)
		dw_lista_gastos.Filter()
	end if

	originales = idw_formatos_impresion.GetItemNumber(1,'originales')
	copias = idw_formatos_impresion.GetItemNumber(1,'copias')
	pagado = dw_lista_receptores.GetItemString(dw_lista_receptores.GetRow(),'pagado')
	if pagado='N' then setnull(f_pago)
	i_datos_facturacion.num_originales	= originales
	i_datos_facturacion.num_copias		= copias
	i_datos_facturacion.contabilizar = 'N'
	i_datos_facturacion.id_emisor 	=''
	i_datos_facturacion.id_receptor = dw_lista_receptores.GetItemString(dw_lista_receptores.GetRow(),'id')
	i_datos_facturacion.pagado = pagado
	i_datos_facturacion.f_pago = f_pago
	i_datos_facturacion.txt_desc	= i_id_fase
	i_datos_facturacion.banco 			= dw_lista_receptores.GetItemString(dw_lista_receptores.GetRow(),'banco')
	i_datos_facturacion.formapago		= dw_lista_receptores.GetItemString(dw_lista_receptores.GetRow(),'formapago')
	i_datos_facturacion.dw_desglose = dw_lista_gastos
	i_datos_facturacion.irpf 			= 0
	
	id_factura_gastos = f_factura(i_datos_facturacion)
	
	this.Event csd_marcar_facturado(tipo,id)
	//Si emitimos ASEMAS a parte... aqui se emite la 
	if i_opciones.emitir_factura_asemas then
		i_datos_facturacion.serie = i_opciones.serie_factura_asemas
		f_desactiva_filtro_gastos()
		f_activa_filtro_gastos(FALSE)
		filtro = "tipo = '"+ tipo +"' and id ='"+id+"' and asemas = 'S'"
		dw_lista_gastos.SetFilter(filtro)
		dw_lista_gastos.Filter()
		if dw_lista_gastos.rowcount()>0 then 
			id_factura_src = f_factura(i_datos_facturacion)
		end if
		f_desactiva_filtro_gastos()
		f_activa_filtro_gastos(FALSE)
	//Si la forma de pago es Con Gesti$$HEX1$$f300$$ENDHEX$$n de Fct. y Cobro entonces se emite liquidacion
			
	end if
	i_datos_facturacion.txt_desc = ''
	//Marcamos al receptor como facturado
	dw_lista_receptores.SetItem(dw_lista_receptores.GetRow(),'facturado','S')
	dw_lista_receptores.SetItem(dw_lista_receptores.GetRow(),'id_factura',id_factura_gastos)
	dw_lista_gastos.enabled=false
	cb_facturar.enabled = false
	//Marcamos los conceptos como facturados
	total_factura_sin_asemas = 0
	for i= 1 to dw_lista_gastos.rowcount()
		if dw_lista_gastos.GetItemString(i,'facturar')='N' then continue
		dw_lista_gastos.SetItem(i,'facturado','S')
		//Si emitimos hoja de liquidacion, tenemos que incluir la l$$HEX1$$ed00$$ENDHEX$$nea de ASEMAS...
		if dw_lista_gastos.GetItemString(i,'id_articulo') = 'SRC' then
		//Si pagamos el ASEMAS lo tenemos que marcar en fases como 'Pagado'			
			for j= 1 to i_ds_asemas.rowcount()
				if i_ds_asemas.GetItemString(j,'id_col') = id and pagado='S' then
					i_ds_asemas.SetItem(j,'estado','P')
					i_ds_asemas.SetItem(j,'f_cargo',f_pago)
					i_ds_asemas.Update()
				end if
			next
		else
			total_factura_sin_asemas = total_factura_sin_asemas + dw_lista_gastos.GetItemNumber(i,'total_factura')
		end if
	next

end if
*/
end event

event csd_opciones_impresion();//Ponemos por defecto las opciones de impresi$$HEX1$$f300$$ENDHEX$$n de documentos...
//f_opciones_impresion(dw_1)
string texto1,texto2,texto3,texto4,nombre_certificado

idw_formatos_impresion.Accepttext()
//idw_firma.AcceptText()
//Datos de copias en papel
i_impresion_formato.papel 	= idw_formatos_impresion.GetItemstring(1, "papel") 
i_impresion_formato.copias 	= idw_formatos_impresion.GetItemnumber(1, "originales") 
i_impresion_formato.email 	= idw_formatos_impresion.GetItemstring(1, "email") 
i_impresion_formato.pdf 	= idw_formatos_impresion.GetItemstring(1, "pdf") 

//i_impresion_formato.asunto_email = '('+f_fases_datos_cadena(i_id_fase,2)+') Facturaci$$HEX1$$f300$$ENDHEX$$n'
//i_impresion_formato.texto_email = 'Adjuntamos al mensaje, factura del expediente cuyos datos mostramos a continuaci$$HEX1$$f300$$ENDHEX$$n: '+cr+cr+cr+ f_fases_datos_cadena(i_id_fase,1)

//Datos de copias en pdf
i_impresion_formato.visualizar_web = 'S'
i_impresion_formato.ruta_base = g_directorio_documentos_visared
//i_impresion_formato.ruta_base = f_obtener_ruta_base(g_anyo_numeracion)
i_impresion_formato.ruta_relativa = ''
i_impresion_formato.pdf_previsualizar = false	//No se muestra una previsualizaci$$HEX1$$f300$$ENDHEX$$n del pdf

//General
i_impresion_formato.destino ='F'
i_impresion_formato.referencia2 = i_id_fase
//i_impresion_formato.dw =
i_impresion_formato.avisos = 1					//Modo con Avisos
i_impresion_formato.modo_creacion	= 0		//Si el fichero ya existe, se sustituye


/*//FIRMA DE FACTURAS
nombre_certificado=idw_firma.GetItemString(1,'nombre_certificado')
i_impresion_formato.firmar_pdf = 'N' //Indica si hay que firmar el PDF

if not(f_es_vacio(nombre_certificado)) and idw_formatos_impresion.GetItemString(1,'pdf')='S' then
	i_impresion_formato.firmar_pdf = 'S' 
	i_impresion_formato.certificado = idw_firma.GetItemString(1,'nombre_certificado')  //Ruta del certificado
	i_impresion_formato.password = idw_firma.GetItemString(1,'password') 			// Password del certificado
	i_impresion_formato.nombre_cer = idw_firma.GetItemString(1,'nombre')			// Nombre del firmante
	i_impresion_formato.razon = idw_firma.GetItemString(1,'razon')				
	i_impresion_formato.situacion = idw_firma.GetItemString(1,'situacion')		
end if*/

/*
//FIRMA DE FACTURAS
if idw_formatos_impresion.GetItemString(1,'pdf')='N' then
	i_impresion_formato.firmar_pdf = 'N' //Indica si hay que firmar el PDF
else
	i_impresion_formato.firmar_pdf = 'S' 
	i_impresion_formato.certificado = idw_firma.GetItemString(1,'nombre_certificado')  //Ruta del certificado
	i_impresion_formato.password = idw_firma.GetItemString(1,'password') 			// Password del certificado
	i_impresion_formato.nombre_cer = idw_firma.GetItemString(1,'nombre')			// Nombre del firmante
	i_impresion_formato.razon = idw_firma.GetItemString(1,'razon')				
	i_impresion_formato.situacion = idw_firma.GetItemString(1,'situacion')
end if
*/



end event

event type integer csd_validar_iva_2010(integer destinatario);boolean lb_error=false
datetime fecha
long i,res
string t_iva

fecha=dw_lista_receptores.GetItemdateTime(destinatario,'f_factura')

for i=1 to dw_lista_gastos.rowcount()
	t_iva=dw_lista_gastos.getItemString(i,'t_iva')
	res=gnv_ivajulio2010.of_valida_iva_fecha(fecha,t_iva)
	if res<0 then 
		lb_error=true
		exit
	end if
next

/*if not(lb_error) then
	for i=1 to dw_honorarios.rowcount()
		t_iva=dw_honorarios.getItemString(i,'t_iva')
		res=gnv_ivajulio2010.of_valida_iva_fecha(fecha,t_iva)
		if res<0 then 
			lb_error=true
			exit
		end if
	next
end if
*/
if lb_error then
	return -1
else
	return 1
end if
end event

event csd_cargar_pagadores();int i,j,fila
datastore ds_cli,ds_col

string id_empresa,id_cliente,id_colegiado

//Cargamos datos clientes
ds_cli = create datastore
ds_cli.dataobject = 'd_fases_promotores'
ds_cli.SetTransObject(SQLCA)
//Cargamos datos colegiados
ds_col = create datastore
ds_col.dataobject = 'd_fases_colegiados'
ds_col.SetTransObject(SQLCA)

ds_col.Retrieve(i_id_fase)
ds_cli.Retrieve(i_id_fase)

dw_lista_receptores.getChild('desplegable_pagador',i_dwc_pagador)
//Restricciones
//Para Paga_empresa y Paga Asalariado, el colegiado debe tener activa la empresa en la pesta$$HEX1$$f100$$ENDHEX$$a del contrato.
//En caso contrario solo aparecer$$HEX2$$e1002000$$ENDHEX$$la opci$$HEX1$$f300$$ENDHEX$$n de Paga Externo
for i=1 to ds_col.rowCount()
	id_colegiado= ds_col.GetItemString(i,'id_col')
	//Paga empresa
	id_empresa=ds_col.getItemString(i,'id_empresa')
	if not f_es_vacio(id_empresa) then
		fila=i_dwc_pagador.insertrow(0)
		i_dwc_pagador.setItem(fila,'id_pagador',id_empresa)
		i_dwc_pagador.setItem(fila,'nombre',f_dame_cliente(id_empresa))
		i_dwc_pagador.setItem(fila,'codigo','E')
		i_dwc_pagador.setItem(fila,'id_colegiado',id_colegiado)
	end if
	//Paga Cliente
	for j=1 to ds_cli.rowCount()
		id_cliente=ds_cli.GetItemString(j,'id_cliente')
		fila=i_dwc_pagador.insertrow(0)
		i_dwc_pagador.setItem(fila,'id_pagador',id_cliente)
		i_dwc_pagador.setItem(fila,'nombre',f_dame_cliente(id_cliente))
		i_dwc_pagador.setItem(fila,'codigo','C')
		i_dwc_pagador.setItem(fila,'id_colegiado',id_colegiado)
	next
	//Paga Asalariado
	if not f_es_vacio(id_empresa) then
		fila=i_dwc_pagador.insertrow(0)
		i_dwc_pagador.setItem(fila,'id_pagador',id_colegiado)
		i_dwc_pagador.setItem(fila,'id_colegiado',id_colegiado)
		i_dwc_pagador.setItem(fila,'nombre',f_colegiado_nombre_apellido(id_colegiado))
		i_dwc_pagador.setItem(fila,'codigo','A')
	end if
next

destroy(ds_col)
destroy(ds_cli)
end event

event type long csd_factura_por_empresa(string as_facturar_musaat_diferenciado);///***SCP-1055. Alexis. 01/03/2011. Esto es nuevo evento que se encarga de llamar al evento csd_factura indicandole la empresa con la que facturar. ***///

long ll_return
string ls_empresa, ls_tipo_pagador, ls_id_pagador
int li_contador, li_cantidad, li_cant_empresas, li_contador_linea_musaat
datastore ds_empresas

ls_tipo_pagador = dw_lista_receptores.getitemstring(dw_lista_receptores.getrow(), 'tipo')
ls_id_pagador = dw_lista_receptores.GetItemString(dw_lista_receptores.getrow(),'id')

ll_return = 0

if not f_es_vacio(is_empresa_seleccionada) then
	ll_return = this.Trigger Event csd_factura(as_facturar_musaat_diferenciado, is_empresa_seleccionada)
else
	ds_empresas = create datastore
	ds_empresas.dataobject = 'd_dddw_csi_empresas'
	ds_empresas.settransobject( SQLCA)
	ds_empresas.retrieve( )
	
	FOR li_cant_empresas = 1 TO ds_empresas.Rowcount()
		if ll_return < 0 then continue
		
		ls_empresa = ds_empresas.getitemstring(li_cant_empresas, 'codigo')
		
		li_cantidad = 0
			FOR li_contador = 1 TO dw_lista_gastos.Rowcount()	
				IF dw_lista_gastos.getitemstring(li_contador,'facturar')= 'N' THEN CONTINUE
				//if f_obtener_empresa_articulo(dw_lista_gastos.getItemstring(li_contador,'id_articulo')) = ls_empresa then
				if dw_lista_gastos.getItemstring(li_contador,'empresa') = ls_empresa then
					if (dw_lista_gastos.getItemstring(li_contador,'id') = ls_id_pagador) and (dw_lista_gastos.getItemstring(li_contador,'tipo')= ls_tipo_pagador)then
						li_contador_linea_musaat = li_contador
						li_cantidad =  li_cantidad +1		
					end if	
				end if	
			next	
			if li_cantidad >0 then 
				///***Si $$HEX1$$e900$$ENDHEX$$l concepto a facturar es musaat y tienen serie aparte, si se quiere s$$HEX1$$f300$$ENDHEX$$lo facturar musaat se entrar$$HEX1$$e100$$ENDHEX$$. Si no, se para hasta que s$$HEX1$$f300$$ENDHEX$$lo se quiera facturar musaat ***//
				if (li_cantidad = 1) and (dw_lista_gastos.getItemstring(li_contador_linea_musaat,'id_articulo') = g_codigos_conceptos.musaat_variable) and g_facturar_musaat_pc_serie_aparte = 'S' then
					if (as_facturar_musaat_diferenciado = 'SOLO_MUSAAT_PV') then
						ll_return = this.Trigger Event csd_factura(as_facturar_musaat_diferenciado, ls_empresa)
					else 	
						ll_return = 1
					end if	
				else 
					if (as_facturar_musaat_diferenciado = 'NO_MUSAAT_PV') or (as_facturar_musaat_diferenciado = '%') then
						ll_return = this.Trigger Event csd_factura(as_facturar_musaat_diferenciado, ls_empresa)
					else
						ll_return = 1
					end if	
				end if	
			end if	
		//li_cant_empresas += 1
	next

	destroy(ds_empresas)
//	DECLARE lcursor_empresas CURSOR FOR
//	SELECT codigo FROM csi_empresas;
//	
//	OPEN lcursor_empresas;
//	
//	FETCH lcursor_empresas INTO :ls_empresa;
//	
//	DO WHILE (SQLCA.sqlcode = 0 and ll_return >= 0)
//		li_cantidad = 0
//		FOR li_contador = 1 TO dw_lista_gastos.Rowcount()	
//			if f_obtener_empresa_articulo(dw_lista_gastos.getItemstring(li_contador,'id_articulo')) = ls_empresa then
//				li_cantidad = 1		
//			end if	
//		next	
//		if li_cantidad = 1 then 
//			ll_return = this.Trigger Event csd_factura(as_facturar_musaat_diferenciado, ls_empresa)
//		end if	
//				
//		FETCH lcursor_empresas INTO :ls_empresa;
//	LOOP
//
//	CLOSE lcursor_empresas;
	
	
	
	//ll_return = csd_factura(as_facturar_musaat_diferenciado, is_empresa_seleccionada)
end if	


return ll_return
end event

public function integer wf_inserta_linea_gastos (st_factufa_lineas_factura datos);long fila
string ls_empresa 

fila = dw_lista_gastos.InsertRow(0)
dw_lista_gastos.SetItem(fila,'facturar', 'S')
dw_lista_gastos.SetItem(fila,'id_articulo',datos.id_articulo)
dw_lista_gastos.SetItem(fila,'aplicar_porc_participacion',datos.aplica_porc_part)
dw_lista_gastos.SetItem(fila,'importe_individual',datos.importe_individual)
// Se almacenan datos calculados en nuevos campos para evitar c$$HEX1$$e100$$ENDHEX$$lculos posteriores al hacer uso del Check Aplicar % Participaci$$HEX1$$f300$$ENDHEX$$n
dw_lista_gastos.SetItem(fila,'cuantia_informe_inicial',datos.cuantia_informe_inicial)
dw_lista_gastos.SetItem(fila,'importe_pendiente_inicial',datos.importe_facturar)
dw_lista_gastos.SetItem(fila,'tipo_musaat',datos.tipo_musaat)
dw_lista_gastos.SetItem(fila,'porcentaje',datos.porcentaje)
dw_lista_gastos.SetItem(fila,'importe_facturar',datos.importe_facturar)
dw_lista_gastos.SetItem(fila,'t_iva',datos.t_iva)
dw_lista_gastos.SetItem(fila,'importe_iva',datos.importe_iva)
dw_lista_gastos.SetItem(fila,'total_linea',datos.total_linea)
dw_lista_gastos.SetItem(fila,'texto_adicional',datos.texto_adicional)
dw_lista_gastos.SetItem(fila,'tipo',datos.tipo)
dw_lista_gastos.SetItem(fila,'id',datos.id)
dw_lista_gastos.SetItem(fila,'nombre_cliente',datos.nombre_cliente)
dw_lista_gastos.SetItem(fila,'unidades',1)

if not isnull(datos.pem) then dw_lista_gastos.SetItem(fila,'pem',datos.pem)
if not isnull(datos.pem) then dw_lista_gastos.SetItem(fila,'b_calc_musaat', datos.importe_individual)

dw_lista_gastos.SetItem(fila,'porc_participacion',datos.porc_participacion)
dw_lista_gastos.SetItem(fila,'prima_total',datos.prima_total)

//SCP-834
if datos.id_articulo =  g_codigos_conceptos.musaat_variable and (datos.tipo_musaat='10' or datos.tipo_musaat='12') then
	dw_lista_gastos.SetItem(fila,'musaat_inhabilita','S')
end if

///***SCP-1126. Se a$$HEX1$$f100$$ENDHEX$$ade la empresa. Alexis. 08/03/2011 ***///
dw_lista_gastos.SetItem(fila,'empresa',datos.cod_empresa)

return 1
end function

public function integer wf_desactiva_filtro_gastos ();dw_lista_gastos.SetRedraw(FALSE)
dw_lista_gastos.SetFilter('')
dw_lista_gastos.Filter()
return 1
end function

public subroutine wf_activa_filtro_gastos (boolean ver);string id,tipo,filtro
if i_bloquear_redraw then 
	ver = false
else
	ver = true
end if
id = dw_lista_receptores.GetItemString(dw_lista_receptores.GetRow(),'id')
tipo = dw_lista_receptores.GetItemString(dw_lista_receptores.GetRow(),'tipo')

filtro = "tipo = '"+ tipo +"' and id ='"+id+"'"

dw_lista_gastos.SetFilter(filtro)
dw_lista_gastos.Filter()
dw_lista_gastos.SetRedraw(ver)
end subroutine

public function double wf_cantidad_facturada (string articulo, string tipo);//Calcula si hay cantidad ya facturada de ese art$$HEX1$$ed00$$ENDHEX$$culo en esa fase para sustra$$HEX1$$e900$$ENDHEX$$rselo a la cantidad
//que indica el informe
string tipo_factura
double total_facturado=0,total_recibos=0
/*
if tipo = 'C' 	then 
	tipo_factura= g_colegio_colegiado
else
	tipo_factura = g_colegio_cliente
end if

select sum(L.subtotal) into :total_facturado from csi_facturas_emitidas F,csi_lineas_fact_emitidas L 
	where F.id_factura = L.id_factura and	F.id_fase = :i_id_fase 
	and F.tipo_factura=:tipo_factura and L.articulo = :articulo;

if isnull(total_facturado) then total_facturado = 0

select sum(L.subtotal) into :total_recibos from csi_recibos F,csi_lineas_recibo L 
	where F.id_factura = L.id_factura and	F.id_fase = :i_id_fase 
	and F.tipo_factura=:tipo_factura and L.articulo = :articulo;

if isnull(total_recibos) then total_recibos = 0

total_facturado = total_facturado + total_recibos
	
if isnull(total_facturado) then total_facturado=0
		*/
return total_facturado	
end function

public function string wf_tipo_factura (string tipo_receptor);String tipo_factura
// Dado el tipo de receptor, se devuelve el tipo de factura

IF tipo_receptor = 'P' OR  tipo_receptor = 'E' THEN 
	tipo_factura = g_colegio_cliente
ELSE //IF tipo_receptor = 'C' THEN 
	tipo_factura = g_colegio_colegiado
END IF

RETURN tipo_factura
end function

public function integer wf_comprobar_hay_gastos_seleccionados (string modo_comprobacion);// Devolver$$HEX1$$e100$$ENDHEX$$:
//	1, si S$$HEX2$$cd002000$$ENDHEX$$hay al menos un gasto marcado para facturar para los datos a procesar
//	0, si NO hay al menos un gasto marcado para facturar para los datos a procesar

// Par$$HEX1$$e100$$ENDHEX$$metros: modo_comprobacion
	//	vac$$HEX1$$ed00$$ENDHEX$$o	=>  acumula todas las l$$HEX1$$ed00$$ENDHEX$$neas v$$HEX1$$e100$$ENDHEX$$lidas
	//  NO_MUSAAT_PV	=> acumula siempre que no sea MUSAAT
	//  SOLO_MUSAAT_PV	=> acumula S$$HEX1$$d300$$ENDHEX$$LO para MUSAAT

long cuantos=0, fila_conceptos, hay_gastos=0

FOR fila_conceptos = 1 TO dw_lista_gastos.Rowcount()		
		IF dw_lista_gastos.getitemstring(fila_conceptos,'facturar')= 'S' THEN 
			
			// Modo comprobaci$$HEX1$$f300$$ENDHEX$$n
			IF f_es_vacio(modo_comprobacion) THEN 
				cuantos++
			ELSEIF modo_comprobacion='NO_MUSAAT_PV' THEN 
				IF dw_lista_gastos.getitemstring(fila_conceptos,'id_articulo') <> f_devuelve_cod_musaat() THEN cuantos++
			ELSE 	
				IF dw_lista_gastos.getitemstring(fila_conceptos,'id_articulo') = f_devuelve_cod_musaat() THEN cuantos++
			END IF
			
		END IF// L$$HEX1$$ed00$$ENDHEX$$neas V$$HEX1$$e100$$ENDHEX$$lidas
		
NEXT

if cuantos > 0 then hay_gastos =1
RETURN hay_gastos
end function

public subroutine wf_opciones_impresion_colegio ();	CHOOSE CASE g_colegio		
		CASE 'COAATTFE'
			// Colocamos 2 copias de cada uno de los tipos de facturas
			idw_formatos_impresion.setitem(1,'copias',2)
		CASE 'COAATZ'	,'COAATGC'		
			idw_formatos_impresion.setitem(1,'copias',2)
			
		CASE 'COAATA'
				idw_formatos_impresion.setitem(1,'originales',1)
				idw_formatos_impresion.setitem(1,'copias',1)
		
		CASE 'COAATNA','COAATTEB', 'COAATMCA','COAATCC', 'COAATTGN'
			idw_formatos_impresion.setitem(1,'copias',0)
		CASE 'COAATTER', 'COAATLL'
			idw_formatos_impresion.setitem(1,'copias',1)
	END CHOOSE
end subroutine

public subroutine wf_imprimir (string id_fact);string id_factura
string id_persona, n_inf, tipo_factura, n_col, nif, nombre, tipo_persona, domicilio, poblacion, id_informe, id_fase, id_linea, cta, ctap, t_iva, tipo
string id_recibo, colegio, id_emisor, n_talon, formapago, des, pagada, id_minuta, id_movimiento_musaat, incluir_todos, asunto, n_fact_unico, cod_articulo
string mensaje='', n_fact, modificacion, proforma,paga_empresa,paga_externo,id_pagador,imprime_cta_banco_col

id_factura		= id_fact
id_emisor 		= i_datos_facturacion.id_emisor	
id_persona 		= i_datos_facturacion.id_receptor
id_fase 			= i_datos_facturacion.id_minuta
id_minuta 		= i_datos_facturacion.id_fase
incluir_todos 	= i_datos_facturacion.incluir_todos
pagada 			= i_datos_facturacion.pagada
asunto			= i_datos_facturacion.asunto
tipo_factura 	= i_datos_facturacion.tipo_factura
formapago 		= i_datos_facturacion.formapago
// Podemos pasar el n$$HEX1$$fa00$$ENDHEX$$mero de factura, en formato string y num$$HEX1$$e900$$ENDHEX$$rico para actualizar el contador de la serie al siguiente.
select n_fact into :n_fact from csi_facturas_emitidas where id_factura= :id_factura;
//n_fact 			= i_datos_facturacion.n_fact
proforma			= i_datos_facturacion.proforma
paga_empresa = i_datos_facturacion.paga_empresa
paga_externo   = i_datos_facturacion.paga_externo
id_pagador      = i_datos_facturacion.id_cliente_pagador
imprime_cta_banco_col	    = i_datos_facturacion.imprime_cta_banco_col
// Miramos si querian imprimir las facturas
		datawindow dw_vacio
				
		st_imprimir_factura_obj_impr st_imp_fact
		//n_csd_impresion_formato ncsd_impresion_formato
		//ncsd_impresion_formato= create n_csd_impresion_formato
		
		st_imp_fact.id_factura 			= id_factura
		st_imp_fact.id_persona 			= id_persona
		st_imp_fact.tipo 					= tipo_factura
		st_imp_fact.dw	 					= dw_vacio
		st_imp_fact.impresion_formato = i_impresion_formato
		st_imp_fact.paga_empresa		= paga_empresa
		st_imp_fact.paga_externo 		= paga_externo
		st_imp_fact.id_cliente_pagador = id_pagador
		st_imp_fact.imprime_cta_banco_col	= imprime_cta_banco_col
		// ORIGINALES
		st_imp_fact.copia = 'N'
		st_imp_fact.impresion_formato.asunto_email = 'Factura ' + n_fact
		st_imp_fact.impresion_formato.nombre = n_fact
		st_imp_fact.impresion_formato.copias = idw_formatos_impresion.getItemNumber(1,'originales')
		f_imprimir_factura_objeto_impr(st_imp_fact)
		// COPIAS
		st_imp_fact.copia = 'S'
		st_imp_fact.impresion_formato.email = 'N' // Evitamos que envie el email 2 veces
		st_imp_fact.impresion_formato.copias = idw_formatos_impresion.getItemNumber(1,'copias')
		f_imprimir_factura_objeto_impr(st_imp_fact)
		// PDF
		st_imp_fact.copia = 'V' // Esto es necesario porque f_imprimir_factura hace cosas distintas en funci$$HEX1$$f300$$ENDHEX$$n del valor de st_imp_fact.copia
		st_imp_fact.impresion_formato.copias = 1
		f_imprimir_factura_objeto_impr(st_imp_fact)
end subroutine

public function integer wf_estado_cuenta_colegiado (string tipo, string id);string filtro
double saldo,saldo_facturar
st_saldo_cuenta_bancaria_colegiado lst_entrada
//Obtenemos el saldo de la cuenta personal del colegiado
lst_entrada.id_colegiado = id
lst_entrada.f_desde = datetime(date('01/01/'+g_ejercicio),time('00:00'))
lst_entrada.f_hasta = datetime(Today(), time('23:59:59'))

saldo = f_saldo_cuenta_bancaria_col(lst_entrada.id_colegiado, lst_entrada.f_desde, lst_entrada.f_hasta)
		

//Obtenemos el total a facturar para el colegiado
filtro = "tipo = '"+ tipo +"' and id ='"+id+"'"
if isnull(filtro) then return 1
dw_lista_gastos.SetFilter(filtro)
dw_lista_gastos.Filter()

this.event csd_actualiza_totales_gastos()

saldo_facturar=dw_total_gastos.getItemNumber(1,'total')

if saldo < saldo_facturar then
	return 0
else
	return 1
end if
end function

public function boolean wf_requiere_conciliar (string id_fase, string id_colegiado);int li_cantidad

string ls_n_colegiado

if not f_es_vacio(id_colegiado) and id_colegiado <> '%' then 
	ls_n_colegiado = f_colegiado_n_col(id_colegiado)
else
	ls_n_colegiado = '%'
end if 	

select count(*) into :li_cantidad
from fases_pagos_plataforma
where id_fase =:id_fase
and n_colegiado like :ls_n_colegiado
and conciliado = 'N';

if li_cantidad > 0 then return true

return false
end function

on w_factufase_facturar.create
int iCurrent
call super::create
this.dw_lista_receptores=create dw_lista_receptores
this.dw_total_gastos=create dw_total_gastos
this.gb_2=create gb_2
this.dw_aux=create dw_aux
this.cb_cerrar=create cb_cerrar
this.dw_tipo_facturacion=create dw_tipo_facturacion
this.cb_facturar=create cb_facturar
this.cb_liquidar=create cb_liquidar
this.gb_4=create gb_4
this.dw_facturas_pendientes=create dw_facturas_pendientes
this.gb_3=create gb_3
this.dw_lista_gastos=create dw_lista_gastos
this.tab_1=create tab_1
this.dw_informes=create dw_informes
this.st_1=create st_1
this.dw_estadistica=create dw_estadistica
this.dw_fases_detalle=create dw_fases_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_lista_receptores
this.Control[iCurrent+2]=this.dw_total_gastos
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.dw_aux
this.Control[iCurrent+5]=this.cb_cerrar
this.Control[iCurrent+6]=this.dw_tipo_facturacion
this.Control[iCurrent+7]=this.cb_facturar
this.Control[iCurrent+8]=this.cb_liquidar
this.Control[iCurrent+9]=this.gb_4
this.Control[iCurrent+10]=this.dw_facturas_pendientes
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.dw_lista_gastos
this.Control[iCurrent+13]=this.tab_1
this.Control[iCurrent+14]=this.dw_informes
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.dw_estadistica
this.Control[iCurrent+17]=this.dw_fases_detalle
end on

on w_factufase_facturar.destroy
call super::destroy
destroy(this.dw_lista_receptores)
destroy(this.dw_total_gastos)
destroy(this.gb_2)
destroy(this.dw_aux)
destroy(this.cb_cerrar)
destroy(this.dw_tipo_facturacion)
destroy(this.cb_facturar)
destroy(this.cb_liquidar)
destroy(this.gb_4)
destroy(this.dw_facturas_pendientes)
destroy(this.gb_3)
destroy(this.dw_lista_gastos)
destroy(this.tab_1)
destroy(this.dw_informes)
destroy(this.st_1)
destroy(this.dw_estadistica)
destroy(this.dw_fases_detalle)
end on

event open;double cant_clientes,cant_col,ingreso
string id,tipo,filtro,titulo,informe,texto_inicio_titulo
long i,lineas_totales=0,informes, resp
st_control_eventos c_evento
DataWindowChild dwc_bancos

ibl_avisado=false

i_impresion_formato = create n_csd_impresion_formato
i_facturado=false

idw_formatos_impresion = tab_1.tabpage_1.dw_formatos

f_centrar_ventana(this)
i_datos_fase = Message.PowerObjectParm  

idw_formatos_impresion.InsertRow(0)
dw_tipo_facturacion.InsertRow(0)

if wf_requiere_conciliar(i_datos_fase.id_fase, '%') then 
	dw_tipo_facturacion.object.t_conciliar_pagos.visible = true	
	dw_tipo_facturacion.object.conciliar_pagos.visible = true
	dw_tipo_facturacion.setitem( dw_tipo_facturacion.getrow(), 'conciliar_pagos', 'S')
end if

// Serie: se asigna en el evento de facturar
// Personalizamos la pantalla a Proformar $$HEX2$$f3002000$$ENDHEX$$Facturar
dw_tipo_facturacion.setitem(1,'proforma',i_datos_fase.proforma)
IF i_datos_fase.proforma = 'S' THEN 
	cb_facturar.text = 'Proformar'
	texto_inicio_titulo = 'Proformas'
ELSE
	texto_inicio_titulo = 'Facturaci$$HEX1$$f300$$ENDHEX$$n'
END  IF

//***SCP-1055. Alexis. 24/02/2011. Se inicia el valor de la empresa con la empresa activa***//
dw_tipo_facturacion.setitem(1,'empresa',g_empresa)
is_empresa_seleccionada = g_empresa

i_id_fase = i_datos_fase.id_fase

//Datos del Contrato

datawindowchild dwc_serie
dw_tipo_facturacion.getchild('serie',dwc_serie)
dwc_serie.settransobject(SQLCA)
dwc_serie.retrieve()

c_evento.dw = dw_lista_receptores
c_evento.evento ='ABRIR_FACTURA_FASE'
f_control_eventos(c_evento)

dw_facturas_pendientes.Reset()
titulo = f_dame_exp(i_id_fase)+' - '+f_dame_fase(i_id_fase)
titulo = texto_inicio_titulo + ' de Gastos del Contrato :  ' + titulo
this.Title = titulo

//Creamos los datastore que vamos a utilizar durante todo el proceso
i_ds_informes = create datastore
// 19/11/10 Se quieren obtener los importes agrupados para un determinado informe, a fin de evitar problemas al descontar las cantidades facturadas cuando un mismo informe aparezca m$$HEX1$$e100$$ENDHEX$$s de una vez
i_ds_informes.dataobject = 'd_fases_informes'
i_ds_informes.SetTransObject(SQLCA)

i_ds_asemas = create datastore
i_ds_asemas.dataobject = 'd_fases_src'
i_ds_asemas.SetTransObject(SQLCA)

i_ds_informes.Retrieve(i_id_fase)
// S$$HEX1$$f300$$ENDHEX$$lo procesamos l$$HEX1$$ed00$$ENDHEX$$neas no facturadas completamente
///***SCP-1055. Alexis. 25-02-2011. Se filtran los datos por la empresa activa ***///
filtro = "facturado <> 'S' and empresa ='" + g_empresa +"'"
i_ds_informes.SetFilter(filtro)
resp = i_ds_informes.Filter()
if resp = -1 Then MessageBox(g_titulo,'Filtro de informes incorrecto')

//Vemos como se reparten los gastos de tasas entre clientes y colegiados
for i= 1 to i_ds_informes.rowcount()
	cant_clientes = cant_clientes + i_ds_informes.GetItemNumber(i,'cuantia_cliente')
	cant_col = cant_col + i_ds_informes.GetItemNumber(i,'cuantia_colegiado')
next
if cant_clientes >0 then informes = 1 else informes = 0
this.TriggerEvent('csd_agregar_colegiados_fase')
this.TriggerEvent('csd_agregar_clientes_fase',informes,informes)

dw_lista_receptores.groupcalc( )

if dw_lista_receptores.rowcount()=0  then 
	ClosewithReturn(this,-1)
	return
end if



dw_total_gastos.InsertRow(0)
id = dw_lista_receptores.GetItemString(1,'id')
tipo = dw_lista_receptores.GetItemString(1,'tipo')

filtro = "tipo = '"+ tipo +"' and id ='"+id+"'"
this.TriggerEvent('csd_genera_gastos')
dw_lista_gastos.SetFilter(filtro)
dw_lista_gastos.Filter()
dw_lista_gastos.Sort()
this.triggerEvent('csd_actualiza_totales_gastos')

dw_lista_gastos.SetFilter(filtro)
dw_lista_gastos.Filter()


///***SCP-1055. Alexis. 24/02/2011. Se filtra por empresa los bancos. En principio por la empresa activa ***///

dw_lista_receptores.getchild('banco',dwc_bancos)
dwc_bancos.SetTransobject(sqlca)

dwc_bancos.setfilter("empresa ='" + g_empresa +"'")
dwc_bancos.Filter()

dw_lista_receptores.SetFocus()
dw_lista_receptores.SetRow(1)
dw_lista_receptores.SelectRow(1,true)

string visared

idw_formatos_impresion.SetItem(1,'originales',1)
idw_formatos_impresion.SetItem(1,'copias',0)
idw_formatos_impresion.SetItem(1,'papel','S')
//SCP-917 - Si la fase es de Visared, colocar el check de PDF por defecto.
SELECT e_mail into :visared FROM fases WHERE id_fase = :i_datos_fase.id_fase;
if visared='V' then
	idw_formatos_impresion.SetItem(1,'PDF','S')
	idw_formatos_impresion.SetItem(1,'papel','N')
else
	idw_formatos_impresion.SetItem(1,'PDF','N')
end if
idw_formatos_impresion.SetItem(1,'email','N')

//Actualizamos las opciones de impresion en funci$$HEX1$$f300$$ENDHEX$$n de g_colegio

wf_opciones_impresion_colegio()
dw_tipo_facturacion.setitem(1,'visible',g_borrar_empresa)
end event

event pfc_postopen;call super::pfc_postopen; 
dw_lista_receptores.of_SetDropDownCalendar(True)
dw_lista_receptores.iuo_calendar.of_register(dw_lista_receptores.iuo_calendar.DDLB)
dw_lista_receptores.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_lista_receptores.iuo_calendar.of_SetInitialValue(True)


/*if idw_formatos_impresion.GetITemString(1,'pdf')='S' then
	tab_1.tabpage_3.visible=true
else
	tab_1.tabpage_3.visible=false
end if*/

// Si hay sesion de sellado iniciada cargamos los datos
/*if not(f_es_vacio(g_sellador_certificado)) then
	idw_firma.Object.t_iniciado.visible=true
	idw_firma.Object.t_no_iniciado.visible=false	
	idw_firma.SetItem(1,'nombre_certificado',g_sellador_certificado)
	idw_firma.SetItem(1,'password',g_sellador_password)
end if*/
	

end event

event close;destroy(i_ds_asemas)
destroy(i_ds_informes)

end event

event csd_recuperar_consulta;call super::csd_recuperar_consulta;// Se pone un comentario para solucionar 1 problema de herencia
//NO BORRAR ESTO (AUNQUE PAREZCA QUE NO SIRVE PARA NADA)
end event

event pfc_close;//... SOBREESCRITO
st_fases_consulta datos_fase

/*SCP-647
if i_facturado = true then 
	datos_fase.estado = this.Event csd_comprobar_abono_total()
else
	datos_fase.estado = '-1'
end if
*/	
destroy i_impresion_formato
CloseWithReturn(this,datos_fase)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_factufase_facturar
integer y = 1384
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_factufase_facturar
integer y = 1256
integer taborder = 20
end type

type dw_lista_receptores from u_dw within w_factufase_facturar
integer x = 46
integer y = 228
integer width = 4334
integer height = 568
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_factufase_lista"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event rowfocuschanged;string id,tipo,filtro,facturado,informe
boolean ver = true

id = dw_lista_receptores.GetItemString(currentrow,'id')
tipo = dw_lista_receptores.GetItemString(currentrow,'tipo')

if dw_tipo_facturacion.Rowcount()=0 then return

	
filtro = "tipo = '"+ tipo +"' and id ='"+id+"'"
if isnull(filtro) then return
dw_lista_gastos.SetFilter(filtro)
dw_lista_gastos.Filter()

// La comprobaci$$HEX1$$f300$$ENDHEX$$n de facturado pasa a realizarse por el n$$HEX1$$fa00$$ENDHEX$$mero de conceptos que dicho receptor tiene pendientes de facturar, en lugar de comprobar su propiedad 'facturado'
//facturado = dw_lista_receptores.GetItemString(currentrow,'facturado')
//if dw_lista_gastos.RowCount() > 0 then facturado = 'S'

/*if facturado = 'S' then
	dw_lista_gastos.enabled = false
//	dw_honorarios.enabled = false
	if i_datos_fase.tipo_gestion = 'P' then cb_facturar.enabled = false
	if i_datos_fase.tipo_gestion = 'C' then cb_liquidar.enabled = true	
else
	if dw_tipo_facturacion.GetItemString(1,'tipo')='S' then 
		dw_lista_gastos.enabled = true
//		dw_honorarios.enabled = true
		cb_facturar.enabled = true
		cb_liquidar.enabled = false
	end if
end if*/
	

//if i_opciones.gestion_facturas_pendientes and tipo='C' then
//	dw_facturas_pendientes.Setfilter("id_col = '"+ id+"'")
//	dw_facturas_pendientes.filter()
//end if

// Se ocultan los datos de pagado del resumen por receptor, se dejar$$HEX1$$e100$$ENDHEX$$n en la cabecera con el resto de datos del receptor
//dw_total_gastos.SetItem(1,'pagado',this.GetItemString(currentrow,'pagado'))
//dw_total_gastos.SetItem(1,'f_pago',this.GetItemDatetime(currentrow,'f_pago'))

/*informe = idw_impresos.GetItemString(1,'informe')

choose case informe
	case 'AC'  //Aviso de Cobro (Sistema)
		idw_impresos.dynamic Event csd_genera_avisocobro()
		dw_informes.Object.Datawindow.Zoom = 85
	case 'CA'  //Carta de pago (Caja Arquitectos)
		idw_impresos.dynamic Event csd_genera_aviso_caja_arq()
		dw_informes.Object.Datawindow.Zoom = 85
	case 'CL'  //Carta Liquidaci$$HEX1$$f300$$ENDHEX$$n
		idw_impresos.dynamic Event csd_genera_carta_liquidacion()
		dw_informes.Object.Datawindow.Zoom = 85
	case 'FG'  //Factura de Gastos 
		idw_impresos.dynamic TriggerEvent('csd_rellena_estructura_facturas')
		dw_informes.Object.Datawindow.Zoom = 85
	case 'HG'
		idw_impresos.dynamic Event csd_genera_avisogastos()
		dw_informes.Object.Datawindow.Zoom = 85
end choose*/

parent.triggerEvent('csd_actualiza_totales_gastos')
end event

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)

this.GetChild('id_empresa',i_dwc_colegiados_empresas)

i_dwc_colegiados_empresas.settransobject(sqlca)
i_dwc_colegiados_empresas.InsertRow (0)
end event

event itemchanged;call super::itemchanged;string tipo_pago, banco, tipo_pago_ant
string id_pagador,tipo_pagador,pagador[]
Datetime f_nula
long saldo
datawindowchild dw_child_aux
SetNull(f_nula)

choose case dwo.name
		
		case 'desplegable_pagador'
			//Antes de modificar nada validamos que la forma de pago no sea Cuenta Personal
			if i_datos_fase.proforma='N' and this.getItemString(row,'formapago')=g_formas_pago.cuenta_personal then
				MessageBox(g_titulo,'La forma de pago Cuenta Personal no es coherente con el pagador seleccionado',StopSign!)
				return 2
			else
				f_separa_string(data,';',pagador)
				this.setItem(row,'tipo_pagador',pagador[1])
				this.setItem(row,'id_pagador',pagador[2])
			end if
			
		case 'receptor'
			if data='E' then
				this.setItem(row,'tipo_pagador','')
				this.setItem(row,'id_pagador','')
				this.setItem(row,'desplegable_pagador','')
			end if
			
		case 'formapago'
			
			tipo_pago = string(data)
			//A las proformas no les afectan los cambios en las formas de pago
			if i_datos_fase.proforma='N' then
				tipo_pago_ant=this.getItemString(row,'formapago')
				//Comprobamos el estado de la cuenta del colegiado para evitar que facturen a la cuenta personal si no tiene saldo
				if tipo_pago = g_formas_pago.cuenta_personal and not f_es_vacio(g_prefijo_cuenta_bancaria_col) and dw_lista_receptores.getItemString(dw_lista_receptores.GetRow(),'tipo')='C' then
					st_saldo_cuenta_bancaria_colegiado lst_entrada
					lst_entrada.id_colegiado = this.getItemString(row,'id')
					lst_entrada.f_desde = datetime(date('01/01/'+g_ejercicio),time('00:00'))
					lst_entrada.f_hasta = datetime(Today(), time('23:59:59'))
				
					saldo = f_saldo_cuenta_bancaria_col(lst_entrada.id_colegiado, lst_entrada.f_desde, lst_entrada.f_hasta)
					//Si el saldo no permite incluir ning$$HEX1$$fa00$$ENDHEX$$n importe mas, no permitimos que aparezca como forma de pago del colegiado
					if saldo <= 0 then
						openwithparm(w_saldo_cuenta_bancaria_colegiado,lst_entrada)
						this.setItem(row,'formapago',tipo_pago_ant)
						return 2
					end if					
				else
					this.setItem(row,'no_saldo','N')
				end if
				
				//Modificamos el Banco, el estado de pagado y la fecha en funci$$HEX1$$f300$$ENDHEX$$n de la forma de pago seleccionada.
				if tipo_pago='DB' or tipo_pago='PE' or tipo_pago='PP' then
					this.setItem(row,'pagado','N')
					this.setItem(row,'f_pago',f_nula)			
				else				
					this.setItem(row,'pagado','S')
					this.setItem(row,'f_pago',datetime(today()))					
				end if
				
				if tipo_pago = g_formas_pago.cuenta_personal and not f_es_vacio(this.getItemString(row,'tipo_pagador')) then
					MessageBox(g_titulo,'No se permite tener seleccionado un pagador al utilizar esta forma de pago.',Exclamation!)
					this.setItem(row,'tipo_pagador','')
					this.setItem(row,'id_pagador','')
					this.setItem(row,'desplegable_pagador','')
				end if
			end if
			/// ***Los bancos por defecto son correctos $$HEX1$$fa00$$ENDHEX$$nicamente para la empresa de colegios
			if f_empresa_es_colegio2(is_empresa_seleccionada) = 'S' then 
				SELECT csi_formas_de_pago.banco_asociado  
				INTO :banco  
				FROM csi_formas_de_pago  
				WHERE csi_formas_de_pago.tipo_pago = :tipo_pago ;
			else
				setnull(banco)
			end if
			
				this.SetItem(row,'banco',banco)
				
			
		case 'pagado'
			if data='S' then
				this.setItem(row,'f_pago',datetime(today()))
			else
				this.setItem(row,'f_pago',f_nula)
			end if
		
	
end choose
end event

event buttonclicked;call super::buttonclicked;choose case dwo.name
	case 'b_borrar_empresa'
		this.setitem(row,'id_pagador','')
		this.setItem(row,'tipo_pagador','')
		this.setItem(row,'desplegable_pagador','')
end choose
		
end event

event clicked;call super::clicked;string filtro,id_col
choose case dwo.name 
	case 'desplegable_pagador'
		id_col=dw_lista_receptores.getItemString(row,'id')
		filtro="id_colegiado='"+id_col+"'"
		i_dwc_pagador.setfilter(filtro)
		i_dwc_pagador.filter()
end choose
end event

type dw_total_gastos from u_dw within w_factufase_facturar
integer x = 585
integer y = 1552
integer width = 3159
integer height = 144
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_factufase_total_gastos"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;datetime fecha

choose case dwo.name
	case 'pagado'
		dw_lista_receptores.SetItem(dw_lista_receptores.GetRow(),'pagado',data)
		if data='S' then
			fecha = datetime(today())
			dw_lista_receptores.SetItem(dw_lista_receptores.GetRow(),'f_pago',fecha)
			this.SetItem(1,'f_pago',fecha)
		else
			setnull(fecha)
			dw_lista_receptores.SetItem(dw_lista_receptores.GetRow(),'f_pago',fecha)
			this.SetItem(1,'f_pago',fecha)
		end if
		
	case 'f_pago'
		dw_lista_receptores.SetItem(dw_lista_receptores.GetRow(),'f_pago',datetime(date(data),Now()))
end choose

		
end event

type gb_2 from groupbox within w_factufase_facturar
integer x = 32
integer y = 196
integer width = 4379
integer height = 612
integer taborder = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
end type

type dw_aux from u_dw within w_factufase_facturar
boolean visible = false
integer x = 1975
integer y = 1952
integer width = 101
integer height = 88
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_factufa_lista_honorarios"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type cb_cerrar from commandbutton within w_factufase_facturar
integer x = 2670
integer y = 1984
integer width = 306
integer height = 84
integer taborder = 200
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;dw_facturas_pendientes.ResetUpdate()
parent.Event pfc_close()
end event

type dw_tipo_facturacion from u_dw within w_factufase_facturar
integer y = 32
integer width = 4315
integer height = 160
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_factufase_tipo_facturacion"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;/* La comprobaci$$HEX1$$f300$$ENDHEX$$n de facturado por cada receptor se realiza por el n$$HEX1$$fa00$$ENDHEX$$mero de conceptos que tiene pendientes de facturar, en lugar de comprobar su propiedad 'facturado'
boolean facturado=true,liquidado=true
int i

facturado = (dw_lista_receptores.GetItemString(dw_lista_receptores.GetRow(),'facturado')='S')
liquidado = f_es_vacio(dw_lista_receptores.GetItemString(dw_lista_receptores.GetRow(),'liquidado'))


choose case dwo.name
	case 'tipo'
		if data='S' then 
			facturado = (dw_lista_receptores.GetItemString(dw_lista_receptores.GetRow(),'facturado')='S')
			liquidado = (dw_lista_receptores.GetItemString(dw_lista_receptores.GetRow(),'liquidado')='S')
			cb_facturar.enabled=not facturado
			cb_liquidar.enabled=not liquidado
		else
			for i=1 to dw_lista_receptores.rowcount()
				if dw_lista_receptores.GetItemstring(i,'facturado')='N' then facturado=false
				if dw_lista_receptores.GetItemstring(i,'liquidado')='N' then liquidado=false
			next
			cb_facturar.enabled=not facturado
			cb_liquidar.enabled=not liquidado
		end if
end choose*/
int i, li_i
long fila_receptores,porcent_musaat,opcion
string id_articulo, filtro, ls_banco 
DataWindowChild dwc_bancos
		
		

choose case dwo.name
	case 'tipo'
		if data='S' then 
			dw_lista_gastos.enabled=true
						
		else
						
			opcion=Messagebox(g_titulo,'Los gastos ser$$HEX1$$e100$$ENDHEX$$n recalculados al valor inicial. $$HEX1$$bf00$$ENDHEX$$Desea continuar?',exclamation!,Yesno!)
			if opcion=2 then
				return 2
			else
				this.setredraw(false)
				fila_receptores=dw_lista_receptores.getrow()
				dw_lista_gastos.reset()
				parent.event csd_genera_gastos()
				dw_lista_receptores.event rowfocuschanged(fila_receptores)
				this.setredraw(true)
				//Bloqueamos el dw para que no puedan modificar mientras este seleccionado esta opci$$HEX1$$f300$$ENDHEX$$n
				dw_lista_gastos.enabled=false
			end if
			
		end if
		
	///*** SCP-1055. Alexis. 25/02/2011. Se agrega c$$HEX1$$f300$$ENDHEX$$digo para soportar la modificaci$$HEX1$$f300$$ENDHEX$$n del campo empresa ***///	
	case 'empresa'
	    
		Messagebox(g_titulo,'Recuerde que los bancos han variado. Seleccione el banco apropiado. ',exclamation!,OK!)
		
		is_empresa_seleccionada = data
		
		i_ds_informes.setfilter("")
		i_ds_informes.Filter()
		
		If f_es_vacio(data) then
			data = '%'
		else
			data = data + '%'
		end if	
		
		dw_lista_receptores.SetRedraw(false)
		dw_lista_receptores.getchild('banco',dwc_bancos)
    	     dwc_bancos.SetTransobject(sqlca)
		dwc_bancos.setfilter("")
		dwc_bancos.Filter()
		dwc_bancos.setfilter("empresa LIKE '" + data +"'")
		dwc_bancos.Filter()
		
		if f_empresa_es_colegio2(data) = 'N' then 
			setnull(ls_banco)
			for li_i = 1 to dw_lista_receptores.rowcount()
				dw_lista_receptores.SetItem(li_i,'banco',ls_banco)
			next	
		end if
		
		
		//dwc_bancos.modify("dddw.lines = 15")
		//dw_lista_receptores.modify( "banco.dddw.lines = 15")
		dw_lista_receptores.SetRedraw(true)
		
		
			
		filtro = "facturado <> 'S' and empresa like'" + data +"'"
		i_ds_informes.SetFilter(filtro)
 		i_ds_informes.Filter()
		
		if dw_tipo_facturacion.getitemstring(dw_tipo_facturacion.getrow(),'tipo')='S' then 
			dw_lista_gastos.enabled=true
			dw_lista_gastos.reset()
			parent.event csd_genera_gastos()
		else
			//opcion=Messagebox(g_titulo,'Los gastos ser$$HEX1$$e100$$ENDHEX$$n recalculados al valor inicial. $$HEX1$$bf00$$ENDHEX$$Desea continuar?',exclamation!,Yesno!)
			//if opcion=2 then
			//	return 2
			//else
				this.setredraw(false)
				fila_receptores=dw_lista_receptores.getrow()
				dw_lista_gastos.reset()
				parent.event csd_genera_gastos()
				dw_lista_receptores.event rowfocuschanged(fila_receptores)
				this.setredraw(true)
				//Bloqueamos el dw para que no puedan modificar mientras este seleccionado esta opci$$HEX1$$f300$$ENDHEX$$n
				dw_lista_gastos.enabled=false
			//end if
			
		end if
		 
end choose

end event

event buttonclicked;call super::buttonclicked;
string ls_null 

setnull(ls_null)

if dwo.name = 'cb_anular_empresa' then
		dw_tipo_facturacion.setitem(row, 'empresa', ls_null )
end if

this.event itemchanged(row, dw_tipo_facturacion.object.empresa, ls_null)
end event

event itemerror;call super::itemerror;string ls_dato

if dwo.name = 'empresa' then
	if (f_es_vacio(data) and g_borrar_empresa = 'N') then 
		return 3
	end if	
end if
end event

event clicked;call super::clicked;	//majid	  
//	string emp
//	emp=	 getitemstring(dw_tipo_facturacion.getrow(),'empresa')
//	    if(f_es_vacio(emp)) then 
//		 Messagebox(g_titulo,'esta vacio '+emp,exclamation!,OK!)
//		    //this.setitem(row,'empresa',g_empresa)
//			//data = g_empresa
//		else  
//			Messagebox(g_titulo,' no esta vacio '+emp,exclamation!,OK!)
//		end if
end event

type cb_facturar from commandbutton within w_factufase_facturar
integer x = 2267
integer y = 1984
integer width = 306
integer height = 84
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Facturar"
end type

event clicked;string opcion, texto_proforma_factura,texto_proforma_factura_pagada,id,tipo
boolean no_pagada, lbl_conciliar
long i
//Reseteamos las variables
i_no_saldo=false
i_cliente_externo=false
no_pagada=false
lbl_conciliar = false


// Impedimos lanzar el proceso de facturaci$$HEX1$$f300$$ENDHEX$$n de nuevo antes de haber finalizado una ejecuci$$HEX1$$f300$$ENDHEX$$n anterior del mismo proceso
IF i_bloquear_facturacion then RETURN 

dw_lista_receptores.AcceptText()
dw_total_gastos.AcceptText()
dw_tipo_facturacion.AcceptText()
opcion = dw_tipo_facturacion.GetItemString(1,'tipo') 

if opcion = '%' then 
	this.visible = false
	i_bloquear_redraw= true
else
	i_bloquear_redraw= false	
end if 

// Mensaje informativo
IF  i_datos_fase.proforma = 'S' THEN 
	texto_proforma_factura = 'proforma'
	texto_proforma_factura_pagada = 'Pagada' 
ELSE 
	texto_proforma_factura = ' factura'
	texto_proforma_factura_pagada = 'No Pagada'
END IF
// Validaci$$HEX1$$f300$$ENDHEX$$n no facturen en la Serie de Facturas Proforma si hay alguna Pagada
for i = 1 to dw_lista_receptores.Rowcount()
	if opcion = 'S' AND (i <> dw_lista_receptores.GetRow()) THEN CONTINUE // Individual s$$HEX1$$f300$$ENDHEX$$lo comprueba la que se va a procesar
	
	// Comprobamos que si es colegiado, est$$HEX2$$e1002000$$ENDHEX$$marcada la opci$$HEX1$$f300$$ENDHEX$$n de conciliar gastos y dipone de gastos por conciliar. 
	if opcion = '%' and dw_tipo_facturacion.getitemstring(dw_tipo_facturacion.getrow(), 'conciliar_pagos') = 'S' and wf_requiere_conciliar(i_datos_fase.id_fase, dw_lista_receptores.GetItemString(i,'id')) then 
		lbl_conciliar = true
		 	
	end if 
	
	if dw_lista_receptores.GetItemString(i,'pagado') = 'N' and i_datos_fase.proforma='N' then 
			no_pagada=true
	end if		
next 

if (lbl_conciliar=true) then 
	if MessageBox(g_titulo,'Est$$HEX2$$e1002000$$ENDHEX$$activada la opci$$HEX1$$f300$$ENDHEX$$n para la conciliaci$$HEX1$$f300$$ENDHEX$$n los pagos.'+cr+'Si las cantidades totales de la factura emitida coincide con el total de un pago no conciliado, los pagos quedar$$HEX1$$e100$$ENDHEX$$n marcados como conciliados.'+cr+'$$HEX1$$bf00$$ENDHEX$$Desea continuar de todas formas?',StopSign!,YesNo!) = 2 THEN 	
		this.visible=true
		RETURN
	end if
	ibl_conciliar_pago= true
else 	
	ibl_conciliar_pago= false
end if 

if (no_pagada=true) and (lbl_conciliar = false) then
	if MessageBox(g_titulo,'Hay al menos una '+texto_proforma_factura+'  que se va a crear como '+texto_proforma_factura_pagada+cr+'$$HEX1$$bf00$$ENDHEX$$Desea continuar de todas formas?',StopSign!,YesNo!) = 2 THEN 	
		this.visible=true
		RETURN
	end if
end if


//cb_cerrar.enabled = false
i_bloquear_facturacion=true

SetPointer(HourGlass!)

CHOOSE CASE opcion
	CASE 'S' 
		// ** VALIDACION DEL IVA 2010 **//
		integer res
		boolean lb_error
		res=event csd_validar_iva_2010(dw_lista_receptores.GetRow())
		If res<0 then 
			if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Alguno de los conceptos a facturar tiene un tipo de IVA distinto al que le corresponde seg$$HEX1$$fa00$$ENDHEX$$n la fecha de facturaci$$HEX1$$f300$$ENDHEX$$n.$$HEX1$$bf00$$ENDHEX$$Desea continuar?",Question!,YesNo!)<>1 then
				dw_lista_receptores.SetRedraw(TRUE)
				dw_lista_gastos.SetRedraw(TRUE)
				dw_total_gastos.SetRedraw(TRUE)
				cb_cerrar.enabled = true
				SetPointer(Arrow!)		
				return
			end if
		end if
		// FIN DE VALIDACIONES DEL IVA
		//Validaci$$HEX1$$f300$$ENDHEX$$n del saldo existente en la cuenta personal
		if i_datos_fase.proforma = 'N' then
			if dw_lista_receptores.getItemString(dw_lista_receptores.GetRow(),'formapago')=g_formas_pago.cuenta_personal and dw_lista_receptores.getItemString(dw_lista_receptores.GetRow(),'pagado')='S' and dw_lista_receptores.getItemString(dw_lista_receptores.GetRow(),'tipo')='C' then
				id =dw_lista_receptores.getItemString(dw_lista_receptores.GetRow(),'id')
				tipo=dw_lista_receptores.getItemString(dw_lista_receptores.GetRow(),'tipo')
		
				if wf_estado_cuenta_colegiado(tipo,id)= 0 then
					dw_lista_receptores.setItem(dw_lista_receptores.GetRow(),'no_saldo','S')
					i_no_saldo=true
				end if
			elseif dw_lista_receptores.getItemString(dw_lista_receptores.GetRow(),'formapago')=g_formas_pago.cuenta_personal and dw_lista_receptores.getItemString(dw_lista_receptores.GetRow(),'tipo')='P' then
				i_cliente_externo=true
			end if
		end if
		
		//Fin validaci$$HEX1$$f300$$ENDHEX$$n saldo
		if i_no_saldo=false and i_cliente_externo=false then	
			parent.event csd_facturar_seleccion()
		end if
		
	CASE '%' 
		parent.event csd_facturar_todo()
END CHOOSE

if i_no_saldo=true then
	MessageBox(g_titulo,"Alguno de los colegiados con gastos pendientes de facturar no tiene cr$$HEX1$$e900$$ENDHEX$$dito suficiente en su cuenta personal. Revise las formas de pago.",stopSign!)
	this.visible = true
	i_bloquear_facturacion=false
	return
elseif i_cliente_externo=true then
	MessageBox(g_titulo,'No es posible el pago en cuenta personal para clientes externos',StopSign!)
	this.visible = true
	i_bloquear_facturacion=false
	return
else	
	SetPointer(Arrow!)
	
	IF i_num_facturas_creadas > 0 THEN
		//SCP-792 A$$HEX1$$f100$$ENDHEX$$adimos al contrato la fecha de abono en caso de haber creado alguna factura y que el contrato a$$HEX1$$fa00$$ENDHEX$$n no tenga esta fecha.
		if i_datos_fase.proforma <> 'S' then
			//A$$HEX1$$f100$$ENDHEX$$adimos fecha de abono al contrato en caso de ser necesario
			f_anyadir_f_abono(i_id_fase)
			f_cambia_estado_si_facturado(i_id_fase)
			//Refrescamos
			if isvalid(g_dw1) then g_fases_consulta.id_fase = g_dw1.getitemstring(1, 'id_fase')
			if isvalid(g_dw1) then g_dw1.dynamic Trigger Event csd_retrieve()
		end if
		//Fin		
		dw_lista_gastos.enabled=false
		dw_tipo_facturacion.Enabled = False
		cb_facturar.enabled = false
		MessageBox(g_titulo,'Proceso Finalizado. Se ha/n creado '+String(i_num_facturas_creadas)+' '+texto_proforma_factura+'/s.')
	END IF
	
	i_facturado = true
	cb_cerrar.enabled = true
	i_bloquear_facturacion=false
	
	Close (Parent)
end if



end event

type cb_liquidar from commandbutton within w_factufase_facturar
boolean visible = false
integer x = 1865
integer y = 1952
integer width = 82
integer height = 84
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Liquidar"
end type

event clicked;string opcion
opcion = dw_tipo_facturacion.GetItemString(1,'tipo')
if opcion= 'S' then	parent.TriggerEvent('csd_liquidar_seleccion')
if opcion= '%' then parent.TriggerEvent('csd_liquidar_todo') 


end event

type gb_4 from groupbox within w_factufase_facturar
integer x = 37
integer y = 1824
integer width = 4059
integer height = 512
integer taborder = 150
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
end type

type dw_facturas_pendientes from u_dw within w_factufase_facturar
boolean visible = false
integer x = 3008
integer y = 764
integer width = 219
integer height = 152
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_factufase_facturas_no_pagadas"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type gb_3 from groupbox within w_factufase_facturar
integer x = 32
integer y = 820
integer width = 4379
integer height = 892
integer taborder = 210
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Gastos Colegiales"
end type

type dw_lista_gastos from u_dw within w_factufase_facturar
event csd_recalcula_importe ( )
integer x = 46
integer y = 864
integer width = 4334
integer height = 672
integer taborder = 110
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_factufa_lista_conceptos"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_recalcula_importe();double importe_facturar, importe_iva, total
string t_iva
long fila

fila = Message.LongParm

importe_facturar = this.GetItemNumber(fila,'importe_facturar')
if isnull(importe_facturar) then importe_facturar=0
this.SetItem(fila,'importe_facturar',importe_facturar)

t_iva = this.GetItemString(fila,'t_iva')
importe_iva = f_aplica_t_iva(importe_facturar,t_iva)
if isnull(importe_iva) then importe_iva=0
this.SetItem(fila,'importe_iva',importe_iva)

total = f_redondea(importe_facturar+ importe_iva)
if isnull(total) then total=0
this.SetItem(fila,'total_factura',total)
end event

event itemchanged;double  importe_individual,importe_facturar,porcentaje, porc_musaat, pem
string tipo_musaat

CHOOSE CASE  dwo.name 
	// Si se cambia el importe individual, actualizamos el importe a  facturar aplicando el porcentaje 
	CASE 'importe_individual'
		importe_individual = Double(data)
		// Importe Individual = 0
		IF Isnull(importe_individual) OR importe_individual = 0 THEN 
			importe_facturar = 0
		// Importe Individual <> 0
		ELSE 
			porcentaje = This.GetItemNumber(row,'porcentaje')
			IF Isnull(porcentaje) OR porcentaje = 0 THEN 
				importe_facturar = 0
			ELSE
				importe_facturar = f_redondea ( importe_individual * porcentaje / 100 )
			END IF
		END IF
		this.SetItem(row,'importe_facturar',importe_facturar)
				tipo_musaat = this.getitemstring(row,'tipo_musaat')
		//Validaci$$HEX1$$f300$$ENDHEX$$n para Musaat
		if (this.getitemstring(row,'id_articulo') = g_codigos_conceptos.musaat_variable ) and (tipo_musaat = '23' or tipo_musaat= '25') then
			// Calculamos el porc de musaat y el pem que corresponde
				//porc_musaat = f_redondea(importe_individual/ this.getitemnumber(row,'b_calc_musaat')*100)
				porc_musaat = ( importe_individual * 100)/this.getitemnumber(row, 'prima_total')
				//this.setitem(row, 'pem', pem)
				this.setitem(row, 'pem', f_redondea(id_pem *porc_musaat/100))
		end if	

	// Si se cambia el porcentaje, actualizamos el importe a  facturar
	CASE 'porcentaje'
		porcentaje = Double(data)
		IF Isnull(porcentaje) OR porcentaje = 0 THEN 
			importe_facturar = 0
		ELSE
			importe_facturar = f_redondea (This.GetItemNumber(row,'importe_individual') * porcentaje / 100 )
		END IF
		
		this.SetItem(row,'importe_facturar',importe_facturar)

	// Si se factura un importe cambiando el reparto proporcional del porcentaje ...
	CASE 'aplicar_porc_participacion' 
	
			// Si se desmarca: Se le asigna el importe pendiente de facturar para ese concepto a todos los receptores (para ese tipo de receptor) 
			IF data = 'N' THEN 
				importe_facturar = f_redondea( This.GetItemNumber(row,'cuantia_informe_inicial')  - f_total_facturado_concepto(i_id_fase,This.GetItemString(row,'id_articulo') , wf_tipo_factura(This.GetItemString(row,'tipo')), '%', '%') )
			// Si se vuelve a marcar tras haver desmarcado:Se le asigna de nuevo el importe pendiente de facturar de dicho concepto para ese receptor en funci$$HEX1$$f300$$ENDHEX$$n del porcentaje asignando el importe calculado anteriormente
			ELSE
				importe_facturar = This.GetItemNumber(row,'importe_pendiente_inicial')
			END IF
	
		// ACCIONES...
			// Se asigna importe calculado a facturar
			This.setitem(row,'importe_individual',importe_facturar)
			This.setitem(row,'porcentaje',100)
			
			This.setitem(row,'importe_facturar',importe_facturar)
	
			// Colateralmente, se deshabilita la opci$$HEX1$$f300$$ENDHEX$$n de Facturar toda la fase, por no refrescar los importes del resto de receptores
			//dw_tipo_facturacion.Enabled = False
			//dw_tipo_facturacion.setitem(1,'tipo','S')
			CASE 'tipo_musaat'
			if data='10' or data='12' then
				This.setitem(row,'musaat_inhabilita','S')
			else
				This.setitem(row,'musaat_inhabilita','N')
			end if
		
		
			
END CHOOSE

// En todos los casos, se recalculan importes y se acumulan totales
this.postEvent ('csd_recalcula_importe',0,row)
parent.PostEvent('csd_actualiza_totales_gastos')


end event

type tab_1 from tab within w_factufase_facturar
integer x = 73
integer y = 1888
integer width = 1719
integer height = 416
integer taborder = 180
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 15780518
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1682
integer height = 300
long backcolor = 79741120
string text = "Opciones"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_formatos dw_formatos
end type

on tabpage_1.create
this.dw_formatos=create dw_formatos
this.Control[]={this.dw_formatos}
end on

on tabpage_1.destroy
destroy(this.dw_formatos)
end on

type dw_formatos from u_dw within tabpage_1
integer y = 48
integer width = 1618
integer height = 232
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_factufa_seleccion_formato"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;/*choose case dwo.name
	case 'pdf'
		if data='S' then 
			tab_1.tabpage_3.visible=true
		else
			tab_1.tabpage_3.visible=false
		end if
end choose*/
end event

type tabpage_2 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 1682
integer height = 300
long backcolor = 79741120
string text = "Impresos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_impresos dw_impresos
end type

on tabpage_2.create
this.dw_impresos=create dw_impresos
this.Control[]={this.dw_impresos}
end on

on tabpage_2.destroy
destroy(this.dw_impresos)
end on

type dw_impresos from u_dw within tabpage_2
event csd_genera_avisogastos ( )
event csd_previsualizar_factura_gastos ( string es_visible )
event csd_restaurar_informes ( )
boolean visible = false
integer x = 27
integer y = 56
integer width = 1637
integer height = 320
integer taborder = 11
string dataobject = "d_factufase_previsual"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_genera_avisogastos();/*string id,tipo,filtro,col,informe
long i,fila
boolean gastos = true
double irpf

f_desactiva_filtro_gastos() 

//Los colegiados con Domiciliaci$$HEX1$$f300$$ENDHEX$$n no deben aparecer en el Aviso de Cobro

dw_informes.Dataobject = 'd_fases_preinforme'
dw_informes.SetTransObject(SQLCA)

//Vemos los gastos
for i= 1 to dw_lista_gastos.RowCount()
	if dw_lista_gastos.GetItemString(i,'facturar')='N' then continue
	tipo = dw_lista_gastos.GetItemString(i,'tipo')
	fila = dw_informes.InsertRow(0)
	dw_informes.SetItem(fila,'irpf',0)
	dw_informes.SetItem(fila,'informe',dw_lista_gastos.getItemString(i,'texto_adicional'))
	dw_informes.SetItem(fila,'iva',dw_lista_gastos.GetItemNumber(i,'importe_iva'))
	dw_informes.SetItem(fila,'tipo',tipo)
	dw_informes.SetItem(fila,'id_fase',i_id_fase)
	dw_informes.SetItem(fila,'exp',f_dame_exp(i_id_fase))
	dw_informes.SetItem(fila,'tipo_cobro',i_datos_fase.tipo_gestion)
	dw_informes.SetItem(fila,'nombree',dw_lista_gastos.GetItemString(i,'nombre_cliente'))
	dw_informes.SetItem(fila,'c_infor',dw_lista_gastos.GetItemString(i,'id_articulo'))
	dw_informes.SetItem(fila,'cantidad',dw_lista_gastos.GetItemNumber(i,'importe'))
next

//Incl$$HEX1$$fa00$$ENDHEX$$imos las facturas pendientes del arquitecto que hayamos inclu$$HEX1$$ed00$$ENDHEX$$do...
for i= 1 to dw_facturas_pendientes.RowCount()
	tipo = 'C'
	id = dw_facturas_pendientes.GetItemString(i,'id_col')
	if dw_facturas_pendientes.GetItemString(i,'incluir')<>'S' then continue
	fila = dw_informes.InsertRow(0)
	dw_informes.SetItem(fila,'irpf',0)
	dw_informes.SetItem(fila,'informe','Factura N$$HEX2$$ba002000$$ENDHEX$$'+dw_facturas_pendientes.getItemString(i,'n_fact'))
	dw_informes.SetItem(fila,'iva',dw_facturas_pendientes.GetItemNumber(i,'iva'))
	dw_informes.SetItem(fila,'tipo',tipo)
	dw_informes.SetItem(fila,'id_fase',i_id_fase)
	dw_informes.SetItem(fila,'exp',f_dame_exp(i_id_fase))
	dw_informes.SetItem(fila,'tipo_cobro',i_datos_fase.tipo_gestion)
	dw_informes.SetItem(fila,'nombree',f_colegiado_nombre_apellido(id))
//	dw_informes.SetItem(fila,'c_infor',dw_lista_gastos.GetItemString(i,'id_articulo'))
	dw_informes.SetItem(fila,'cantidad',dw_facturas_pendientes.GetItemNumber(i,'subtotal'))
next

f_activa_filtro_gastos(TRUE)
dw_informes.sort()	
dw_informes.GroupCalc()*/
end event

event csd_previsualizar_factura_gastos(string es_visible);string informe
i_datos_facturacion.id_receptor = dw_lista_receptores.GetItemString(dw_lista_receptores.GetRow(),'id')
i_datos_facturacion.dw_desglose = dw_lista_gastos
i_datos_facturacion.id_fase 	  = i_datos_fase.id_fase
if dw_lista_receptores.GetItemString(dw_lista_receptores.GetRow(),'tipo')='C' then
	i_datos_facturacion.tipo_factura=g_colegio_colegiado
else
	i_datos_facturacion.tipo_factura=g_colegio_cliente
end if
select plantilla into :informe from tipos_facturas where codigo = :i_datos_facturacion.tipo_factura;
dw_informes.dataobject = informe
dw_informes.SetTransObject(SQLCA)


/*SCP-647 f_previsualizar_factura(i_datos_facturacion,dw_informes)*/
if dw_informes.rowcount()=0 then
	Messagebox(g_titulo,'No existen datos para la previsualizaci$$HEX1$$f300$$ENDHEX$$n')
	return
end if
dw_informes.Object.Datawindow.Zoom = 85

end event

event csd_restaurar_informes();/*string informe

informe = this.getitemstring(1,'informe')

if f_es_vacio(informe) then return
choose case informe
	case 'AC'  //Aviso de Cobro (Sistema)
		this.Event csd_genera_avisocobro()
		dw_informes.Object.Datawindow.Zoom = 85
	case 'CA'  //Carta de pago (Caja Arquitectos)
		this.Event csd_genera_aviso_caja_arq()
		dw_informes.Object.Datawindow.Zoom = 85
	case 'CL'  //Carta Liquidaci$$HEX1$$f300$$ENDHEX$$n
		this.Event csd_genera_carta_liquidacion()
		dw_informes.Object.Datawindow.Zoom = 85
	case 'FG'  //Factura de Gastos 
		parent.TriggerEvent('csd_rellena_estructura_facturas')
		this.Event csd_previsualizar_factura_gastos('S')
	case 'HG'
		this.Event csd_genera_avisogastos()
		dw_informes.Object.Datawindow.Zoom = 85
end choose*/

end event

event buttonclicked;call super::buttonclicked;int snumero_or,snumero_c,copias_informes,i
string informe

snumero_or = this.GetItemNumber(1,'n_originales')
snumero_c = this.GetItemNumber(1,'n_copias')
copias_informes = this.GetItemNumber(1,'copias_informes')

choose case dwo.name
	case 'b_omas'
		snumero_or++
		this.SetItem(1,'n_originales',snumero_or)
	case 'b_omenos'
		if snumero_or=0 then return
		snumero_or --
		this.SetItem(1,'n_originales',snumero_or)
	case 'b_cmas'
		snumero_c ++
		this.SetItem(1,'n_copias',snumero_c)
	case 'b_cmenos'
		if snumero_c=0 then return
		snumero_c --
		this.SetItem(1,'n_copias',snumero_c)
	case 'b_previsualizar'
		if f_es_vacio(this.GetItemString(1,'informe')) then return
		this.Object.b_previsualizar.visible = false
		this.Object.informe.Protect= 1
		this.Object.b_cerrar.visible = true
		informe = this.getitemstring(1,'informe')
		dw_informes.visible=true

	case 'b_imprimir'
		dw_informes.SetRedraw(FALSE)
		dw_informes.Object.Datawindow.Zoom = 100
		for i = 1 to copias_informes
			dw_informes.Print()
		next
		dw_informes.Object.Datawindow.Zoom = 85
		dw_informes.SetRedraw(TRUE)
	case 'b_cerrar'
		dw_informes.visible=false
		this.object.informe.protect = 0 
		this.Object.b_previsualizar.visible = true
		this.Object.b_cerrar.visible = false
end choose
end event

event itemchanged;call super::itemchanged;/*string informe

choose case dwo.name
	case 'informe'
	if f_es_vacio(this.GetItemString(1,'informe')) then return
		informe = data
		choose case informe
			case 'AC'  //Aviso de Cobro (Sistema)
				this.Event csd_genera_avisocobro()
				dw_informes.Object.Datawindow.Zoom = 85
			case 'CA'  //Carta de pago (Caja Arquitectos)
				this.Event csd_genera_aviso_caja_arq()
				dw_informes.Object.Datawindow.Zoom = 85
			case 'CL'  //Carta Liquidaci$$HEX1$$f300$$ENDHEX$$n
				this.Event csd_genera_carta_liquidacion()
				dw_informes.Object.Datawindow.Zoom = 85
			case 'FG'  //Factura de Gastos 
				parent.TriggerEvent('csd_rellena_estructura_facturas')
				this.Event csd_previsualizar_factura_gastos('S')
			case 'HG'
				this.Event csd_genera_avisogastos()
				dw_informes.Object.Datawindow.Zoom = 85
		end choose
end choose*/
end event

type tabpage_3 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 1682
integer height = 300
long backcolor = 81324524
string text = "Firma"
long tabtextcolor = 8388608
long tabbackcolor = 81324524
long picturemaskcolor = 536870912
dw_firma dw_firma
end type

on tabpage_3.create
this.dw_firma=create dw_firma
this.Control[]={this.dw_firma}
end on

on tabpage_3.destroy
destroy(this.dw_firma)
end on

type dw_firma from u_dw within tabpage_3
integer x = 5
integer y = 8
integer width = 1669
integer height = 336
integer taborder = 11
string dataobject = "d_csd_seleccion_formato_certificado"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event clicked;call super::clicked;string certificado
string nulo

choose case dwo.name
	case 'b_certificado'	
		open(w_certificados)
		certificado=Message.StringParm
		
		if Not(IsNull(certificado)) and certificado<>'' then
			idw_firma.SetItem(1,'nombre_certificado',certificado)
			idw_firma.SetItem(1,'password','')
		end if
	case 'b_quitar'
		SetNull(nulo)
		idw_firma.SetItem(1,'nombre_certificado','')
		idw_firma.SetItem(1,'password',nulo)
		idw_firma.SetItem(1,'nombre','')
		idw_firma.SetItem(1,'razon','')
		idw_firma.SetItem(1,'situacion','')
	case 'b_grabar'		
		f_grabar_consulta_un_dw(idw_firma,'w_factufase_facturar','INICIO')

end choose
end event

type dw_informes from u_dw within w_factufase_facturar
boolean visible = false
integer x = 37
integer y = 204
integer width = 3246
integer height = 1656
integer taborder = 120
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type st_1 from statictext within w_factufase_facturar
integer x = 73
integer y = 1736
integer width = 3456
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "Recuerde que deber$$HEX2$$e1002000$$ENDHEX$$editar manualmente las cantidades si la suma de los porcentajes de participaci$$HEX1$$f300$$ENDHEX$$n totales para Colegiados $$HEX2$$f3002000$$ENDHEX$$Clientes difiere de 100"
boolean focusrectangle = false
end type

type dw_estadistica from u_dw within w_factufase_facturar
boolean visible = false
integer x = 3511
integer y = 1696
integer width = 73
integer height = 96
integer taborder = 160
boolean bringtotop = true
string title = "none"
string dataobject = "d_fases_expedientes_estadistica"
boolean border = false
end type

type dw_fases_detalle from u_dw within w_factufase_facturar
boolean visible = false
integer x = 3584
integer y = 1728
integer width = 110
integer height = 64
integer taborder = 190
boolean bringtotop = true
string title = "none"
string dataobject = "d_fases_detalle"
boolean border = false
end type

