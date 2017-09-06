HA$PBExportHeader$n_csd_facturacion_proformas.sru
forward
global type n_csd_facturacion_proformas from nonvisualobject
end type
end forward

global type n_csd_facturacion_proformas from nonvisualobject
end type
global n_csd_facturacion_proformas n_csd_facturacion_proformas

type variables
String is_lista_id_factura, is_forma_pago, is_banco, is_pagado, is_cobros_a_cero, is_id_liquidacion
datetime is_fecha_factura, is_fecha_pago
end variables

forward prototypes
public function integer of_init (st_datos_facturas_proforma ast_datos)
public function integer wf_factura ()
public function integer wf_comprueba_datos ()
end prototypes

public function integer of_init (st_datos_facturas_proforma ast_datos);
is_lista_id_factura = ast_datos.lista_id_factura
is_forma_pago = ast_datos.forma_pago
is_banco = ast_datos.banco
is_pagado = ast_datos.pagado
is_fecha_factura = ast_datos.fecha_facturacion
is_fecha_pago = ast_datos.fecha_pago
is_cobros_a_cero = ast_datos.cobros_a_cero
is_id_liquidacion = ast_datos.id_liquidacion

return 1

end function

public function integer wf_factura ();///**** Funci$$HEX1$$f300$$ENDHEX$$n encargada de facturar con los par$$HEX1$$e100$$ENDHEX$$metros cargados. Alexis. 16/11/2010 ****///
///**** Devuelve 1 si el proceso se ha realizado correctamente. -1 si ocurio alg$$HEX1$$fa00$$ENDHEX$$n fallo  ****///

long resp, resp_ds_facturas_proforma, resp_ds_historico_proformas, i
double ldb_iva_fact, ldb_total_fact
resp = 0
string sql_nuevo, ls_n_fact, ls_id_factura, ls_null, ls_serie_abono, ls_gen_mov_musaat, ls_serie_defecto
setnull(ls_null)
datastore ds_facturas_proforma, ds_historico_proformas, ds_lineas_factura
int li_res, li_j
st_facturas lst_facturas
 

string id_fase

///***Se comprueba que los datos enviados sean coherentes. ***///
li_res  = wf_comprueba_datos()

if li_res < 1 then
	return 0
end if	


ds_facturas_proforma = create datastore
ds_facturas_proforma.dataobject = "d_factufa_proforma_procesadas"
ds_facturas_proforma.setTransObject(SQLCA)
//ds_facturas_proforma.retrieve('2010')//obtener empresa

ds_historico_proformas = create datastore
ds_historico_proformas.dataobject = "d_proforma_a_factura"
ds_historico_proformas.setTransObject(SQLCA)

ds_lineas_factura = create datastore
ds_lineas_factura.dataobject = "d_lineas_fact_emitidas"
ds_lineas_factura.setTransObject(SQLCA)

///SetPointer(Hourglass!)

// Concatenamos a la SQL el filtrado por los id_factura seleccionados en la ventana previa
sql_nuevo = ds_facturas_proforma.describe("datawindow.table.select")
if NOT f_es_vacio(is_lista_id_factura) then  sql_nuevo += " AND id_factura IN ("+f_coloca_comillas(is_lista_id_factura) +")"
ds_facturas_proforma.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
ds_facturas_proforma.Retrieve ()

IF ds_facturas_proforma.RowCount() = 0 THEN 
	MessageBox(g_titulo,'No hay documentos v$$HEX1$$e100$$ENDHEX$$lidos para continuar.'+cr+'Se aborta este proceso.', StopSign!)
	Return -1
END IF 

///ESTOY POR AQU$$HEX1$$cd00$$ENDHEX$$
FOR i = 1 TO ds_facturas_proforma.RowCount()
	// Dato Variable
	 ls_gen_mov_musaat = 'N'
	//Se obtiene la serie de la factura dependiendo del tipo de IVA aplicado y el total de la factura.
	ldb_iva_fact = ds_facturas_proforma.GetItemnumber(i,'iva')
	ldb_total_fact = ds_facturas_proforma.GetItemnumber(i,'total')
	ls_id_factura = ds_facturas_proforma.GetItemString(i,'id_factura')
	
	ds_lineas_factura.retrieve(ls_id_factura)
	
	for li_j = 1 to ds_lineas_factura.rowcount()
		if ds_lineas_factura.getitemstring(li_j, 'articulo') = g_codigos_conceptos.musaat_variable then
			ls_gen_mov_musaat = 'S'
		end if	
	next	
	
	ls_serie_defecto = f_obtener_serie_defecto (f_obtener_empresa_factura(ls_id_factura), g_ejercicio)
	
	if ls_serie_defecto = '-1' then
		ls_serie_defecto = g_serie_fases
	end if	
	
	lst_facturas.cod_empresa = f_obtener_empresa_factura(ls_id_factura)
	lst_facturas.tipo_factura = ds_facturas_proforma.GetItemString(i,'tipo_factura')
	
	If ldb_iva_fact > 0 then 
		// Serie de expediente
		if ldb_total_fact > 0 then 
			
//			ls_n_fact = f_siguiente_n_fact_emitida(ds_facturas_proforma.GetItemString(i,'tipo_factura'),g_serie_fases,'', is_fecha_factura)
			ls_n_fact = f_siguiente_n_fact_emitida_empresa(lst_facturas,ls_serie_defecto,'', is_fecha_factura)
		else 
			// Serie rectificativa de expedientes
		     ls_n_fact = f_siguiente_n_fact_emitida_empresa(lst_facturas,g_facturas_negativas_serie,'',is_fecha_factura)
		end if
	else // Factura de musaat 
		
		//Trabaja con la serie de musaat. 
		if g_facturar_musaat_pc_serie_aparte = 'S' and ls_gen_mov_musaat = 'S' then 
			// Serie de MUSAAT
			if ldb_total_fact > 0 then 
				//ls_n_fact = f_siguiente_n_fact_emitida(ds_facturas_proforma.GetItemString(i,'tipo_factura'),g_fases_serie_musaat,'',is_fecha_factura)
				ls_n_fact = f_siguiente_n_fact_emitida_empresa(lst_facturas,g_fases_serie_musaat,'',is_fecha_factura)
			// Serie rectificativa de MUSAAT
			else 
				select serie_abono into :ls_serie_abono from csi_series where serie = :g_fases_serie_musaat;
				if not f_es_vacio(ls_serie_abono) then
				  //ls_n_fact = f_siguiente_n_fact_emitida(ds_facturas_proforma.GetItemString(i,'tipo_factura'),ls_serie_abono,'',is_fecha_factura)
				  ls_n_fact = f_siguiente_n_fact_emitida_empresa(lst_facturas,ls_serie_abono,'',is_fecha_factura)
				else 
					// Si no tiene serie de abono se pone sobre la misma serie de musaat
					//ls_n_fact = f_siguiente_n_fact_emitida(ds_facturas_proforma.GetItemString(i,'tipo_factura'),g_fases_serie_musaat,'',is_fecha_factura)
					ls_n_fact = f_siguiente_n_fact_emitida_empresa(lst_facturas,g_fases_serie_musaat,'',is_fecha_factura)
				end if	
			end if
		else
			// No trabaja con serie de Musaat. Serie de expediente
			if ldb_total_fact > 0 then 
			//	ls_n_fact = f_siguiente_n_fact_emitida(ds_facturas_proforma.GetItemString(i,'tipo_factura'),g_serie_fases,'',is_fecha_factura)
			ls_n_fact = f_siguiente_n_fact_emitida_empresa(lst_facturas,ls_serie_defecto,'', is_fecha_factura)
			// Serie rectificativa de expedientes
			else 
				ls_n_fact = f_siguiente_n_fact_emitida_empresa(lst_facturas,g_facturas_negativas_serie,'',is_fecha_factura)
				// ls_n_fact = f_siguiente_n_fact_emitida(ds_facturas_proforma.GetItemString(i,'tipo_factura'),g_facturas_negativas_serie,'',is_fecha_factura)
			end if
		end if	
	end if	
		
		
	// Proforma - Datos
	ds_historico_proformas.InsertRow(0)
	ds_historico_proformas.SetItem(i,'id_factura',ls_id_factura)
	ds_historico_proformas.SetItem(i,'fecha_proforma',ds_facturas_proforma.GetItemDateTime(i,'fecha'))
	ds_historico_proformas.SetItem(i,'n_fact_proforma',ds_facturas_proforma.GetItemString(i,'n_fact'))
	ds_historico_proformas.SetItem(i,'pagado_proforma',ds_facturas_proforma.GetItemString(i,'pagado'))
	ds_historico_proformas.SetItem(i,'f_pago_proforma',ds_facturas_proforma.GetItemDateTime(i,'f_pago'))
	ds_historico_proformas.SetItem(i,'forma_pago_proforma',ds_facturas_proforma.GetItemString(i,'formadepago'))
	ds_historico_proformas.SetItem(i,'banco_proforma',ds_facturas_proforma.GetItemString(i,'banco'))
	ds_historico_proformas.SetItem(i,'contabilizada_proforma',ds_facturas_proforma.GetItemString(i,'contabilizada'))
	ds_historico_proformas.SetItem(i,'f_conta_proforma',ds_facturas_proforma.GetItemdatetime(i,'f_conta'))
	ds_historico_proformas.SetItem(i,'anulada_proforma',ds_facturas_proforma.GetItemString(i,'anulada'))
	ds_historico_proformas.SetItem(i,'fecha',is_fecha_factura)
	ds_historico_proformas.SetItem(i,'n_fact',ls_n_fact)
	ds_historico_proformas.SetItem(i,'pagado',is_pagado)
	ds_historico_proformas.SetItem(i,'f_pago',is_fecha_pago)
	ds_historico_proformas.SetItem(i,'forma_pago',is_forma_pago)
	ds_historico_proformas.SetItem(i,'banco',is_banco)
	
			
	// Factura - Datos que cambian 
	ds_facturas_proforma.SetItem(i,'proforma','N')
	
	ds_facturas_proforma.SetItem(i,'fecha',is_fecha_factura)
	ds_facturas_proforma.SetItem(i,'n_fact',ls_n_fact)
	ds_facturas_proforma.SetItem(i,'pagado',is_pagado)
	ds_facturas_proforma.SetItem(i,'f_pago',is_fecha_pago)
	ds_facturas_proforma.SetItem(i,'formadepago',is_forma_pago)
	ds_facturas_proforma.SetItem(i,'banco',is_banco)
	ds_facturas_proforma.SetItem(i,'id_liquidacion',is_id_liquidacion)
	ds_facturas_proforma.SetItem(i,'contabilizada','N')
	ds_facturas_proforma.SetItem(i,'f_conta',ls_null)
	ds_facturas_proforma.SetItem(i,'anulada','N')
	ds_facturas_proforma.SetItem(i,'visared','N')
	ds_facturas_proforma.SetItem(i,'reclamar','S')
	ds_facturas_proforma.SetItem(i,'emitida','N')	
	ds_facturas_proforma.SetItem(i,'reimpresa','N')	
	
//	f_genera_factura_cobro(id_informe,formapago,datos_factura.fecha,datos_factura.banco,n_talon,0, pagada)
	if is_cobros_a_cero = 'S' then // Para los cobros multiples. Cobros a importe 0
		f_genera_factura_cobro(ls_id_factura,is_forma_pago,is_fecha_pago,is_banco,ls_null,0, is_pagado,f_obtener_empresa_factura(ls_id_factura))
	else
		f_genera_factura_cobro(ls_id_factura,is_forma_pago,is_fecha_pago,is_banco,ls_null,ldb_total_fact, is_pagado,f_obtener_empresa_factura(ls_id_factura))
	end if 	
	
	//SCP-792 Obtenemos el id del contrato asociado a la factura
	 id_fase=ds_facturas_proforma.GetItemString(i,'id_minuta')
	 
	 if not f_es_vacio(id_fase) then
		f_anyadir_f_abono(id_fase)
		f_cambia_estado_si_facturado(id_fase)
	end if
	
	
NEXT

// CONTROL DEL VALOR DEVUELTO
resp_ds_facturas_proforma = ds_facturas_proforma.Update()
resp_ds_historico_proformas = ds_historico_proformas.Update()
IF not (resp_ds_facturas_proforma =1 AND resp_ds_historico_proformas = 1) THEN 
	return -1
end if 

ds_lineas_factura.reset()

FOR i = 1 TO ds_facturas_proforma.RowCount()
	// Dato Variable
	ls_gen_mov_musaat = 'N'
	ls_id_factura = ds_facturas_proforma.GetItemString(i,'id_factura')	
		
	ds_lineas_factura.retrieve(ls_id_factura)
	
	for li_j = 1 to ds_lineas_factura.rowcount()
		if ds_lineas_factura.getitemstring(li_j, 'articulo') = g_codigos_conceptos.musaat_variable then
			ls_gen_mov_musaat = 'S'
		end if	
	next	

	if ls_gen_mov_musaat = 'S' then
		f_musaat_alta_movimiento_facturar(ls_id_factura)  
	end if	
next	

return 1
	
end function

public function integer wf_comprueba_datos ();///*** Comprueba que los datos enviados bien con la funci$$HEX1$$f300$$ENDHEX$$n of_init sean coherentes o porque se hayan asignado directamente al objeto. Alexis 16/11/2010 ***///

string mensaje = ''
long ll_num_facturas_anteriores

int li_return

li_return = 1

// VALIDACIONES OBLIGATORIAS
// La fecha de factura no puede ser vac$$HEX1$$ed00$$ENDHEX$$a 

if f_es_vacio(is_lista_id_factura) then 
	mensaje = "No se han indicado las proformas que se deben facturar"
end if	
if f_es_vacio(is_forma_pago) then
	mensaje = + CR + "Debe indicar la forma de pago de las facturas"
end if 
if f_es_vacio(is_banco) and is_forma_pago <> g_formas_pago.cargo then
	mensaje = + CR + "Debe indicar el banco para las facturas"
end if	

if f_es_vacio(is_pagado) or is_pagado <> 'N'  then
	is_pagado = 'S'
end if

if f_es_vacio( string(is_fecha_factura)) then
	is_fecha_factura = datetime(today())
end if	

if f_es_vacio(string(is_fecha_pago)) then
	is_fecha_pago = datetime(today())
end if	

if is_pagado <> 'S' then 
	setnull(is_fecha_pago)
end if	

IF NOT f_es_vacio(mensaje) THEN 
	MessageBox(g_titulo,mensaje)
	li_return = 0
	
END IF
	
// VALIDACIONES Opcionales
// NO deben haber facturas con fecha posterior en la misma serie (tendr$$HEX1$$e100$$ENDHEX$$n un n$$HEX1$$fa00$$ENDHEX$$mero anterior)
//SELECT COUNT(*) INTO :ll_num_facturas_anteriores FROM csi_facturas_emitidas 	WHERE fecha > :is_fecha_facturacion AND n_fact like :serie_aux ;
//IF num_facturas_anteriores > 0 THEN 
//	resp_temp = MessageBox(g_titulo,'Hay facturas con fecha posterior en la misma serie.'+cr+'$$HEX1$$bf00$$ENDHEX$$Desea continuar de todas formas? (se generar$$HEX1$$e100$$ENDHEX$$n facturas con n$$HEX1$$fa00$$ENDHEX$$mero posterior en fecha anterior a las existentes)',Exclamation!,YesNo!) 
//	IF resp_temp  = 2 THEN 	RETURN -1
//END IF

// Otro Caso, OK
RETURN li_return
end function

on n_csd_facturacion_proformas.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_csd_facturacion_proformas.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

