HA$PBExportHeader$w_facturacion_emitida_listados.srw
forward
global type w_facturacion_emitida_listados from w_listados
end type
type aviso_recuperacion_t from statictext within w_facturacion_emitida_listados
end type
end forward

global type w_facturacion_emitida_listados from w_listados
integer width = 3703
integer height = 2368
string title = "Listados de Facturas Emitidas"
aviso_recuperacion_t aviso_recuperacion_t
end type
global w_facturacion_emitida_listados w_facturacion_emitida_listados

type variables
string   is_musaat_fija,is_musaat_fija1,is_musaat_fija2, is_musaat, is_cip, is_dv, is_cuota_colegial, is_colegiado
end variables

forward prototypes
public function string wf_composite_dw (u_dw dw)
end prototypes

public function string wf_composite_dw (u_dw dw);// Devuelve el resultado 
// de la comprobaci$$HEX1$$f300$$ENDHEX$$n de si un dw es Composite
//  S
//  N
 
string es_composite = 'N'
if dw.Describe("DataWindow.Processing")= '5' then es_composite = 'S' 
 
RETURN es_composite

end function

on w_facturacion_emitida_listados.create
int iCurrent
call super::create
this.aviso_recuperacion_t=create aviso_recuperacion_t
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.aviso_recuperacion_t
end on

on w_facturacion_emitida_listados.destroy
call super::destroy
destroy(this.aviso_recuperacion_t)
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

// Se desplaza el apuntador al primer registro
dw_listados_varios.scrolltorow(1)
dw_listados_varios.setfocus()



end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_facturacion_emitida_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_facturacion_emitida_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_facturacion_emitida_listados
integer x = 2313
integer y = 2000
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_facturacion_emitida_listados
integer x = 2231
integer width = 1390
integer height = 1920
end type

type cb_ver from w_listados`cb_ver within w_facturacion_emitida_listados
end type

event cb_ver::clicked;call super::clicked;string sql, listado,lista,miembro, sql_aux, ls_pago, ls_selecc, ls_articulo, ls_cod_delegacion, ls_estado_liquidacion
long i,indice
datastore d_detalle_transferencias
boolean b_visible = false
long posicion

SetPointer(Hourglass!) //25/01/11 

g_parametros_listados=''
g_etiquetas_listados=''

// dw_1.accepttext()
dw_listados.accepttext()
dw_1.of_setprintpreview(TRUE)

// Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado
indice = dw_listados_varios.GetRow()

dw_1.of_SetTransObject(SQLCA)
sql = dw_1.describe("datawindow.table.select")

//Listado de transferencias de IVA externa
if listado = 'd_listado_transferencias_iva_ext' then
	dw_1.dataobject = 'd_listado_transferencias_iva'
	sql=''
	dw_1.of_SetTransObject(SQLCA)
	sql = dw_1.describe("datawindow.table.select")
	
	d_detalle_transferencias = create datastore
	d_detalle_transferencias.dataobject = listado
	
	listado = 'd_listado_transferencias_iva'
end if

// Se asigna el titulo del informe con la descripcion
//dw_1.object.titulo_t.text = dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'descripcion')
datetime f_liq_desde,f_liq_hasta

f_liq_desde = datetime(date(dw_listados.getitemdatetime(1,'fecha_desde')), time('00:00:00'))
f_liq_hasta = datetime(date(dw_listados.getitemdatetime(1,'fecha_hasta')), time('23:59:59'))

ls_pago = dw_listados.getitemstring(1,"pagado")

string id_persona, ls_centro, ls_banco
id_persona = dw_listados.getitemstring(1,'id_persona')
if f_es_vacio(id_persona) then id_persona = '%'
ls_centro = dw_listados.getitemstring(1,'centro')
if f_es_vacio(ls_centro) then ls_centro = '%'
ls_banco = dw_listados.getitemstring(1,'banco')
if f_es_vacio(ls_banco) then ls_banco = '%'

if listado = 'd_listado_facturas_x_usuario' then sql += ' and csi_facturas_emitidas.usuario = ~'' +g_usuario + '~''
	
//SCP-933 - Se filtra por el campo proforma para todos los listados menos para el de proformas
if listado <> 'd_listado_proformas' then
	f_sql('csi_facturas_emitidas.proforma','LIKE','proforma',dw_listados,sql,g_tipo_base_datos,'')
end if

//Hacer f_sql de todos los campos de la dw_listados de forma analoga a la ventana de consulta
choose case listado 
	case 'd_libro_iva_factu_e_general', 'd_libro_iva_factu_r_general', 'd_conta_extracto_irpf_colegio_detalle', &
		  'd_conta_extracto_irpf_colegio_lineas', 'd_libro_iva_factu_e_exentas'
		if isnull(f_liq_desde) or isnull(f_liq_hasta) then
			messagebox(g_titulo, 'Es necesario que introduzca las fechas desde y hasta para este listado')
			return
		end if
		if not isnull(sql_aux) then sql += sql_aux	
		dw_1.retrieve(f_liq_desde, f_liq_hasta, ls_centro,g_empresa,g_t_iva_00)		
		b_visible = dw_1.RowCount()>0 
		
	// SCP-886
	case 'd_listado_fact_l_g_c_composite', 'd_listado_fact_l_g_c_composite_des'
		if isnull(f_liq_desde) or isnull(f_liq_hasta) then
			messagebox(g_titulo, 'Es necesario que introduzca las fechas desde y hasta para este listado')
			return
		end if
		// Asignamos la delegacion para filtrar Liquidaciones: Si hubiera >1 Delegaci$$HEX1$$f300$$ENDHEX$$n con el mismo centro, deber$$HEX1$$ed00$$ENDHEX$$amos activar el Filtrado por Delegaci$$HEX1$$f300$$ENDHEX$$n
		select cod_delegacion INTO :ls_cod_delegacion from delegaciones WHERE centro = :ls_centro ;
		IF f_es_vacio (ls_cod_delegacion) THEN ls_cod_delegacion = '%'
		// Se recuperan tambi$$HEX1$$e900$$ENDHEX$$n liquidaciones comprobando el estado aplicando la siguiente equivalencia: 
		IF ls_pago ='S' THEN 
			ls_estado_liquidacion = 'L' // Liquidada
		ELSEIF ls_pago ='N' THEN  
			ls_estado_liquidacion = 'P' // Pendiente
		ELSE // '%'
			ls_estado_liquidacion = ls_pago // No filtrar
		END IF
		dw_1.retrieve (ls_centro,ls_banco,g_empresa,f_liq_desde, f_liq_hasta,ls_cod_delegacion,ls_pago,ls_estado_liquidacion,g_formas_pago.autoliquidacion)		
		b_visible = dw_1.RowCount()>0 
		
	//Andr$$HEX1$$e900$$ENDHEX$$s: d_iva_colegiado_za es la modificaci$$HEX1$$f300$$ENDHEX$$n de d_infocol_iva para zaragoza	
	case 'd_infocol', 'd_infocol_iva','d_iva_colegiado_za'
		if isnull(f_liq_desde) or isnull(f_liq_hasta) then
			messagebox(g_titulo, 'Es necesario que introduzca las fechas desde y hasta para este listado')
			return
		end if
		if f_es_vacio(id_persona) then
			messagebox(g_titulo, 'Es necesario que introduzca el colegiado para este listado')
			return
		end if
		dw_1.retrieve(id_persona,f_liq_desde, f_liq_hasta, '%',g_empresa)
		b_visible = dw_1.RowCount() > 0 
	//LISTADO ESPECIFICO DE COAATMU 
	case 'd_listado_transferencias_iva', 'd_listado_transferencias_iva_detallado' 
		if isnull(f_liq_desde) or isnull(f_liq_hasta) then
			messagebox(g_titulo, 'Es necesario que introduzca las fechas desde y hasta para este listado')
			return
		end if		
		// Restringimos los detalles a solo aquellos articulos que sean de retencion de IVA por el colegio
		sql += ' and csi_lineas_fact_emitidas.articulo = ~'' + g_codigos_conceptos.ret_iva + '~''
		//Modificado 27/11/2009 
		if PosA(upper(sql), "WHERE") > 0 then
			sql_aux = " and csi_facturas_emitidas.empresa ='"+g_empresa+"'"
		else
			sql_aux = " WHERE csi_facturas_emitidas.empresa ='"+g_empresa+"'"
		end if	
		if not isnull(sql_aux) then sql += sql_aux	
		// MODIFICADO RICARDO 2005-03-09
		// Hacemos que no se tengan en cuenta las de solo a efecto de pago
		f_sql('csi_facturas_emitidas.solo_pagos','LIKE','solo_pagos',dw_listados,sql,g_tipo_base_datos,'')		
		dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
		dw_1.retrieve(id_persona,f_liq_desde, f_liq_hasta, ls_centro)	
		b_visible = dw_1.RowCount()>0 
		if listado = 'd_listado_transferencias_iva' then
			listado = 'd_listado_transferencias_iva_ext'
		end if
		
	case 'd_factu_e_listado_articulos', 'd_factu_e_listado_articulos_desglosado'
		// Colocamos el puntero de rat$$HEX1$$f300$$ENDHEX$$n a reloj de arena para que el usuario no haga nada
		setpointer(hourglass!)
		aviso_recuperacion_t.visible = true
		// Listado composite que agrupa la facturaci$$HEX1$$f300$$ENDHEX$$n emitida por articulos y un resumen por iva
		DataWindowChild dw_articulos_honos, dw_articulos_gastos, dw_resumenes_iva
		string sql_articulos_honos, sql_articulos_gastos, sql_resumen_iva
		
		
		// Capturamos cada uno de los composite
		dw_1.getchild( 'dw_articulos_honos' , dw_articulos_honos)
		dw_1.getchild( 'dw_articulos_gastos' , dw_articulos_gastos)
		dw_1.getchild( 'dw_resumenes_iva' , dw_resumenes_iva)
		dw_articulos_honos.settransobject(SQLCA)
		dw_articulos_gastos.settransobject(SQLCA)
		dw_resumenes_iva.settransobject(SQLCA)
		// Sacamos las sql de cada uno de ellos
		sql_articulos_honos = dw_articulos_honos.describe("datawindow.table.select")
		sql_articulos_gastos = dw_articulos_gastos.describe("datawindow.table.select")
		sql_resumen_iva = dw_resumenes_iva.describe("datawindow.table.select")

//		Modificado Ricardo 04-02-12
		// para el primer report
		f_sql('csi_facturas_emitidas.centro','LIKE','centro',dw_listados,sql_articulos_honos,g_tipo_base_datos,'')		
		f_sql('csi_facturas_emitidas.f_pago','>=','f_pago_desde',dw_listados,sql_articulos_honos,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.f_pago','<','f_pago_hasta',dw_listados,sql_articulos_honos,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','>=','fecha_desde',dw_listados,sql_articulos_honos,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','<','fecha_hasta',dw_listados,sql_articulos_honos,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.solo_pagos','LIKE','solo_pagos',dw_listados,sql_articulos_honos,g_tipo_base_datos,'')// MODIFICADO RICARDO 2005-03-09. Hacemos que no se tengan en cuenta las de solo a efecto de pago
		f_sql('csi_facturas_emitidas.anulada','LIKE','anulada',dw_listados,sql_articulos_honos,g_tipo_base_datos,'')
		f_sql('csi_lineas_fact_emitidas.articulo','LIKE','concepto',dw_listados,sql_articulos_honos,g_tipo_base_datos,'')
		// A$$HEX1$$f100$$ENDHEX$$adido proyecto a las consultas.  Paco 20/02/09
		f_sql('csi_facturas_emitidas.proyecto','LIKE','proyecto',dw_listados,sql_articulos_honos,g_tipo_base_datos,'')
		f_sql('csi_lineas_fact_emitidas.t_iva','LIKE','t_iva',dw_listados,sql_articulos_honos,g_tipo_base_datos,'')
		
		//Modificado Julian CGN-293
		f_sql('csi_facturas_emitidas.n_fact','LIKE','serie',dw_listados,sql_articulos_honos,g_tipo_base_datos,'')
		
		//Modificado 27/11/2009 
		if PosA(upper(sql_articulos_honos), "WHERE") > 0 then
			sql_aux = " and csi_facturas_emitidas.empresa ='"+g_empresa+"'"
		else
			sql_aux = " WHERE csi_facturas_emitidas.empresa ='"+g_empresa+"'"
		end if	
		if not isnull(sql_aux) then sql_articulos_honos += sql_aux	
		// para el segundo report
		f_sql('csi_facturas_emitidas.centro','LIKE','centro',dw_listados,sql_articulos_gastos,g_tipo_base_datos,'')		
		f_sql('csi_facturas_emitidas.f_pago','>=','f_pago_desde',dw_listados,sql_articulos_gastos,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.f_pago','<','f_pago_hasta',dw_listados,sql_articulos_gastos,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','>=','fecha_desde',dw_listados,sql_articulos_gastos,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','<','fecha_hasta',dw_listados,sql_articulos_gastos,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.solo_pagos','LIKE','solo_pagos',dw_listados,sql_articulos_gastos,g_tipo_base_datos,'')// MODIFICADO RICARDO 2005-03-09. Hacemos que no se tengan en cuenta las de solo a efecto de pago		
		f_sql('csi_facturas_emitidas.anulada','LIKE','anulada',dw_listados,sql_articulos_gastos,g_tipo_base_datos,'')		
		f_sql('csi_lineas_fact_emitidas.articulo','LIKE','concepto',dw_listados,sql_articulos_gastos,g_tipo_base_datos,'')
		f_sql('csi_lineas_fact_emitidas.t_iva','LIKE','t_iva',dw_listados,sql_articulos_gastos,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.proyecto','LIKE','proyecto',dw_listados,sql_articulos_gastos,g_tipo_base_datos,'')
		
		//Modificado Julian CGN-293
		f_sql('csi_facturas_emitidas.n_fact','LIKE','serie',dw_listados,sql_articulos_gastos,g_tipo_base_datos,'')
		
		//Modificado 27/11/2009 
		if PosA(upper(sql_articulos_gastos), "WHERE") > 0 then
			sql_aux = " and csi_facturas_emitidas.empresa ='"+g_empresa+"'"
		else
			sql_aux = " WHERE csi_facturas_emitidas.empresa ='"+g_empresa+"'"
		end if	
		if not isnull(sql_aux) then sql_articulos_gastos += sql_aux	
		
		// para el resumen
		f_sql('csi_facturas_emitidas.centro','LIKE','centro',dw_listados,sql_resumen_iva,g_tipo_base_datos,'')		
		f_sql('csi_facturas_emitidas.f_pago','>=','f_pago_desde',dw_listados,sql_resumen_iva,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.f_pago','<','f_pago_hasta',dw_listados,sql_resumen_iva,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','>=','fecha_desde',dw_listados,sql_resumen_iva,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','<','fecha_hasta',dw_listados,sql_resumen_iva,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.solo_pagos','LIKE','solo_pagos',dw_listados,sql_resumen_iva,g_tipo_base_datos,'')// MODIFICADO RICARDO 2005-03-09. Hacemos que no se tengan en cuenta las de solo a efecto de pago
		f_sql('csi_facturas_emitidas.anulada','LIKE','anulada',dw_listados,sql_resumen_iva,g_tipo_base_datos,'')
		f_sql('csi_lineas_fact_emitidas.articulo','LIKE','concepto',dw_listados,sql_resumen_iva,g_tipo_base_datos,'')
		f_sql('csi_lineas_fact_emitidas.t_iva','LIKE','t_iva',dw_listados,sql_resumen_iva,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.proyecto','LIKE','proyecto',dw_listados,sql_resumen_iva,g_tipo_base_datos,'')		
		
		//Modificado Julian CGN-293
		f_sql('csi_facturas_emitidas.n_fact','LIKE','serie',dw_listados,sql_resumen_iva,g_tipo_base_datos,'')
		
		
//		FIN Modificado Ricardo 04-02-12
		
		//Modificado 27/11/2009 
		if PosA(upper(sql_resumen_iva), "WHERE") > 0 then
			sql_aux = " and csi_facturas_emitidas.empresa ='"+g_empresa+"'"
		else
			sql_aux = " WHERE csi_facturas_emitidas.empresa ='"+g_empresa+"'"
		end if	
		if not isnull(sql_aux) then sql_resumen_iva += sql_aux	

		// Modificamos las sql de los reports y retriveamos
		dw_articulos_honos.Modify("DataWindow.Table.Select= ~"" + sql_articulos_honos + "~"")
		dw_articulos_gastos.Modify("DataWindow.Table.Select= ~"" + sql_articulos_gastos + "~"")
		dw_resumenes_iva.Modify("DataWindow.Table.Select= ~"" + sql_resumen_iva + "~"")
		if dw_articulos_honos.retrieve() > 0 then b_visible = true
		if dw_articulos_gastos.retrieve() > 0 then b_visible = true
		if dw_resumenes_iva.retrieve() > 0 then b_visible = true

		// Colocamos en la etiqueta las fechas de pago
		datetime f_pago_desde, f_pago_hasta
		string parametros_listado = ''
		f_pago_desde = dw_listados.getitemdatetime(1,'f_pago_desde')
		f_pago_hasta = dw_listados.getitemdatetime(1,'f_pago_hasta')
		if not isnull(f_pago_desde) then parametros_listado = "Fecha Pago Desde: "+string(f_pago_desde, "DD/MM/YYYY")+"     "
		if not isnull(f_pago_hasta) then parametros_listado += "Fecha Pago Hasta: "+string(f_pago_hasta, "DD/MM/YYYY")
		// Metemos las fechas que me ha comentado Paco en el listados
		dw_1.object.parametros_t.text = parametros_listado		
		aviso_recuperacion_t.visible = false
	case 'd_resumen_movimientos_caja_teb'
		datetime ldt_f_pago_desde, ldt_f_pago_hasta, ldt_fecha_desde, ldt_fecha_hasta
		string ls_concepto, ls_vacio = ''
		long  k
		real total_importe1, total_importe2, total_importe3, ll_fila
		DataWindowChild dw_ingresos_egresos, dw_total_ingresos_egresos, dw_calculo_ingresos_egresos
		dw_1.getchild( 'dw_ingresos_egresos' , dw_ingresos_egresos)
		dw_1.getchild( 'dw_total_ingresos_egresos' , dw_total_ingresos_egresos)
		dw_1.getchild( 'dw_calculo_ingresos_egresos' , dw_calculo_ingresos_egresos)
		dw_ingresos_egresos.settransobject(SQLCA)
		dw_calculo_ingresos_egresos.settransobject(SQLCA)
		ll_fila = dw_total_ingresos_egresos.insertrow(0)
		
		ls_concepto = dw_listados.getitemstring(1,'concepto')
		if(f_es_vacio(ls_concepto))then ls_concepto = '%'
		ldt_f_pago_desde = dw_listados.getitemdatetime(1,'f_pago_desde')
		if isnull(ldt_f_pago_desde)then ldt_f_pago_desde = datetime(date('1900/01/01'))
		ldt_f_pago_hasta = dw_listados.getitemdatetime(1,'f_pago_hasta')
		if isnull(ldt_f_pago_hasta)then ldt_f_pago_hasta =datetime(date('2100/01/01'))
		ldt_fecha_desde = dw_listados.getitemdatetime(1,'fecha_desde')
		if isnull(ldt_fecha_desde)then ldt_fecha_desde = datetime(date('1900/01/01'))
		ldt_fecha_hasta = dw_listados.getitemdatetime(1,'fecha_hasta')
		if isnull(ldt_fecha_hasta)then ldt_fecha_hasta = datetime(date('2100/01/01'))
			
		dw_ingresos_egresos.retrieve(ls_centro, ls_concepto, ldt_f_pago_desde, ldt_f_pago_hasta, ldt_fecha_desde, ldt_fecha_hasta)		
		dw_calculo_ingresos_egresos.retrieve( )
		b_visible = dw_ingresos_egresos.RowCount()>0 
	
		total_importe1=total_importe1+dw_ingresos_egresos.getitemnumber(1,'suma_total_1')
		total_importe2=total_importe2+dw_ingresos_egresos.getitemnumber(1,'suma_total_2')
		
		for k=1 to dw_calculo_ingresos_egresos.rowcount( )
			total_importe3 = total_importe3 + dw_calculo_ingresos_egresos.getitemnumber(k,'importe')
		next
		total_importe2=total_importe2+total_importe3
		dw_total_ingresos_egresos.setitem(ll_fila,'total_ingresos', total_importe1)
		dw_total_ingresos_egresos.setitem(ll_fila,'total_egresos', total_importe2)

	
	case 'd_colegiados_listado_importe_facturado_347'
		datetime f_des, f_has
		
		f_des = dw_listados.getitemdatetime(1,'fecha_desde')
		f_has = dw_listados.getitemdatetime(1,'fecha_hasta')
		if(f_es_vacio(string(date(f_des))) or f_es_vacio(string(date(f_has))))then
			MessageBox(g_titulo,'Debe especificar un rango que represente el a$$HEX1$$f100$$ENDHEX$$o sobre el que se calcula el 347')
			return
		end if
		dw_1.retrieve(f_des,f_has,g_empresa)	
		b_visible = dw_1.RowCount()>0 
		
	// LISTADO DE SITUACION ECONOMICA COLEGIAL RESUMEN
	case 'd_colegiado_listado_sit_resumen'
		

		
		if ls_pago = 'S' then
			ls_selecc = 'PAGADO'
		elseif ls_pago = 'N' then
			ls_selecc = 'IMPAGADO'
		else
			ls_selecc = 'TODOS'
		end if
		
		if isnull(f_liq_desde) or isnull(f_liq_hasta) then
			messagebox(g_titulo, 'Es necesario que introduzca las fechas desde y hasta para este listado')
			return
		end if		
		
		f_sql('csi_facturas_emitidas.fecha','>=','fecha_desde',dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','<','fecha_hasta',dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.pagado','LIKE','pagado',dw_listados,sql,g_tipo_base_datos,'')
		if PosA(upper(sql), "WHERE") > 0 then
			sql_aux = " and csi_facturas_emitidas.empresa ='"+g_empresa+"'"
		else
			sql_aux = " WHERE csi_facturas_emitidas.empresa ='"+g_empresa+"'"
		end if	
		if not isnull(sql_aux) then sql += sql_aux	
		dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
		dw_1.retrieve()	
		b_visible = dw_1.RowCount()>0 
		
		if dw_1.RowCount()>0 then
			is_cuota_colegial = g_codigos_conceptos.cuota_colegial
			is_musaat_fija    = g_codigos_conceptos.musaat_fija
			is_musaat_fija1  = g_codigos_conceptos.musaat_fija_plazo1
			is_musaat_fija2  = g_codigos_conceptos.musaat_fija_plazo2
			is_musaat          = g_codigos_conceptos.musaat_variable
			is_cip                = g_codigos_conceptos.cip
			is_dv                 = g_codigos_conceptos.dv
			
			dw_1.setitem(1,"cuota_colegial",is_cuota_colegial)
			dw_1.setitem(1,"prima_fija",is_musaat_fija)
			dw_1.setitem(1,"prima_fija_plazo1",is_musaat_fija1)
			dw_1.setitem(1,"prima_fija_plazo2",is_musaat_fija2)
			dw_1.setitem(1,"prima_complementaria",is_musaat)
			dw_1.setitem(1,"cip",is_cip)
			dw_1.setitem(1,"cvv",is_dv)
			
			dw_1.object.t_fecha.text = 'PERIODO:  ' + string(date(f_liq_desde)) + ' ' + ' A ' + string(date(f_liq_hasta))
			dw_1.object.t_seleccion.text = 'Selecci$$HEX1$$f300$$ENDHEX$$n:  ' + ls_selecc
			
		end if
		
	// LISTADO DE SITUACION ECONOMICA COLEGIAL DETALLADO
	case 'd_colegiado_listado_sit_detallado'
		
		if isnull(f_liq_desde) or isnull(f_liq_hasta) then
			messagebox(g_titulo, 'Es necesario que introduzca las fechas desde y hasta para este listado')
			return
		end if	
		
		if ls_pago = 'S' then
			ls_selecc = 'PAGADO'
		elseif ls_pago = 'N' then
			ls_selecc = 'IMPAGADO'
		else
			ls_selecc = 'TODOS'
		end if
	
		f_sql('csi_facturas_emitidas.fecha','>=','fecha_desde',dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','<','fecha_hasta',dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.pagado','LIKE','pagado',dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_lineas_fact_emitidas.t_iva','LIKE','t_iva',dw_listados,sql,g_tipo_base_datos,'')
		
		if not f_es_vacio(dw_listados.getitemstring(1, 'n_col')) then
			f_sql('csi_facturas_emitidas.n_col','LIKE','n_col',dw_listados,sql,g_tipo_base_datos,'')
		end if
		if PosA(upper(sql), "WHERE") > 0 then
			sql_aux = " and csi_facturas_emitidas.empresa ='"+g_empresa+"'"
		else
			sql_aux = " WHERE csi_facturas_emitidas.empresa ='"+g_empresa+"'"
		end if	
		if not isnull(sql_aux) then sql += sql_aux	
		
		dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
		dw_1.retrieve()	
		b_visible = dw_1.RowCount() > 0 
		
		if dw_1.RowCount() > 0 then
			is_cuota_colegial = g_codigos_conceptos.cuota_colegial
			is_musaat_fija    = g_codigos_conceptos.musaat_fija
			is_musaat_fija1  = g_codigos_conceptos.musaat_fija_plazo1
			is_musaat_fija2  = g_codigos_conceptos.musaat_fija_plazo2
			is_musaat          = g_codigos_conceptos.musaat_variable
			is_cip                = g_codigos_conceptos.cip
			is_dv                 = g_codigos_conceptos.dv
			
			for i = 1 to dw_1.RowCount()
				ls_articulo = dw_1.getitemstring(i,"csi_lineas_fact_emitidas_articulo")
				
				if ls_articulo = is_cuota_colegial then
					dw_1.setitem(i,"cuota_colegial",is_cuota_colegial)
					dw_1.setitem(i,"c_articulo",'C')
				end if
				if ls_articulo = is_musaat_fija then
					dw_1.setitem(i,"prima_fija",is_musaat_fija)
					dw_1.setitem(i,"c_articulo",'PF')
				end if
				if ls_articulo = is_musaat_fija1 then
					dw_1.setitem(i,"prima_fija_plazo1",is_musaat_fija1)
					dw_1.setitem(i,"c_articulo",'PF1')
				end if
				if ls_articulo = is_musaat_fija2 then
					dw_1.setitem(i,"prima_fija_plazo2",is_musaat_fija2)
					dw_1.setitem(i,"c_articulo",'PF2')
				end if
				if ls_articulo = is_musaat then
					dw_1.setitem(i,"prima_complementaria",is_musaat)
					dw_1.setitem(i,"c_articulo",'PC')
				end if
				if ls_articulo = is_cip or ls_articulo = '43' then // 43=Mantenimiento
					dw_1.setitem(i,"cip",is_cip)
					dw_1.setitem(i,"c_articulo",'CIP')
				end if
				if ls_articulo = '15' then // 15=Honorarios
					dw_1.setitem(i,"varios",ls_articulo)
					dw_1.setitem(i,"c_articulo",'H')
				end if				
				if ls_articulo = is_dv then
					dw_1.setitem(i,"cvv",is_dv)
					dw_1.setitem(i,"c_articulo",'CVV')
				end if
				
				if ls_articulo <> is_dv and ls_articulo <> is_cip and ls_articulo <> '15' and ls_articulo <> '43' and  ls_articulo <> is_musaat and &
				   ls_articulo <> is_musaat_fija2 and ls_articulo <> is_musaat_fija1 and ls_articulo <> is_musaat_fija and &
				   ls_articulo <> is_cuota_colegial then
					dw_1.setitem(i,"varios",ls_articulo)
					dw_1.setitem(i,"c_articulo",'Varios')
				end if
		
			next
	
			
			dw_1.object.t_fecha.text = 'PERIODO:  ' + string(date(f_liq_desde)) + ' ' + ' A ' + string(date(f_liq_hasta))
			dw_1.object.t_seleccion.text = 'Selecci$$HEX1$$f300$$ENDHEX$$n:  ' + ls_selecc
			
		end if	
		dw_1.groupcalc()
		
	case 'd_factu_e_listado_cip_mensual' 
	
	f_sql('fases_renuncias.fecha','>=','fecha_desde',Parent.dw_listados,sql,g_tipo_base_datos,'Fecha Desde')
	f_sql('fases_renuncias.fecha','<','fecha_hasta',Parent.dw_listados,sql,g_tipo_base_datos, 'Fecha Hasta')
	
	dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
	dw_1.retrieve()
	b_visible = dw_1.RowCount()>0
				
	case else
		// Todos los colegiados que pertenezcan a la lista de colegiados elegida..
		if not ( f_es_vacio(dw_listados.getitemstring(1, 'lista_colegiados'))) then
			// Pero comprobando si hay que incluirlos o incluirlos
			if PosA(upper(sql), "WHERE") > 0 then
				sql_aux = "and csi_facturas_emitidas.tipo_factura = '03' and csi_facturas_emitidas.id_persona IN (SELECT id_lista_miembro FROM listas_miembros WHERE id_lista='"+dw_listados.getitemstring(1,'lista_colegiados')+"')"
			else
				sql_aux = "WHERE csi_facturas_emitidas.tipo_factura = '03' and csi_facturas_emitidas.id_persona IN (SELECT id_lista_miembro FROM listas_miembros WHERE id_lista='"+dw_listados.getitemstring(1,'lista_colegiados')+"')"
			end if	
			if not isnull(sql_aux) then sql += sql_aux
		end if		
		// Minuta
		if not ( f_es_vacio(dw_listados.getitemstring(1, 'fase'))) then
			if PosA(upper(sql), "WHERE") > 0 then
				sql_aux = "and csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM fases_minutas WHERE id_minuta='"+dw_listados.getitemstring(1,'id_minuta')+"')"
			else
				sql_aux = "WHERE csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM fases_minutas WHERE id_minuta='"+dw_listados.getitemstring(1,'id_minuta')+"')"
			end if	
			if not isnull(sql_aux) then sql += sql_aux
		end if
		// Registro
		if not ( f_es_vacio(dw_listados.getitemstring(1, 'n_registro'))) then
			if PosA(upper(sql), "WHERE") > 0 then
				sql_aux = "and csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM fases, fases_minutas WHERE fases_minutas.id_fase = fases.id_fase and fases.id_fase='"+dw_listados.getitemstring(1,'id_fase')+"')"
			else
				sql_aux = "WHERE csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM fases, fases_minutas WHERE fases_minutas.id_fase = fases.id_fase and fases.id_fase='"+dw_listados.getitemstring(1,'id_fase')+"')"
			end if	
			if not isnull(sql_aux) then sql += sql_aux	
		end if
		// Expediente
		if not ( f_es_vacio(dw_listados.getitemstring(1, 'n_expedi'))) then
			if PosA(upper(sql), "WHERE") > 0 then
				sql_aux = "and csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM expedientes, fases, fases_minutas WHERE expedientes.id_expedi = fases.id_expedi and fases_minutas.id_fase = fases.id_fase and expedientes.id_expedi='"+dw_listados.getitemstring(1,'id_expedi')+"')"
			else
				sql_aux = "WHERE csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM expedientes, fases, fases_minutas WHERE expedientes.id_expedi = fases.id_expedi and fases_minutas.id_fase = fases.id_fase and expedientes.id_expedi='"+dw_listados.getitemstring(1,'id_expedi')+"')"
			end if	
			if not isnull(sql_aux) then sql += sql_aux
		end if

		// Por familia de conceptos
		if not f_es_vacio(dw_listados.getitemstring(1, 'familia')) then
			if PosA(upper(sql), "WHERE") > 0 then
				sql_aux = " and csi_facturas_emitidas.id_factura IN (SELECT id_factura FROM csi_lineas_fact_emitidas, csi_articulos_servicios WHERE csi_lineas_fact_emitidas.articulo = csi_articulos_servicios.codigo and familia = '"+dw_listados.getitemstring(1,'familia')+"')"
			else
				sql_aux = " WHERE csi_facturas_emitidas.id_factura IN (SELECT id_factura FROM csi_lineas_fact_emitidas, csi_articulos_servicios WHERE csi_lineas_fact_emitidas.articulo = csi_articulos_servicios.codigo and familia = '"+dw_listados.getitemstring(1,'familia')+"')"
			end if	
			if not isnull(sql_aux) then sql += sql_aux
		end if
		
		//Modificado por Luis 28/04/2009 para incidencia cte-52
		// Por conceptos
		if listado = 'd_listado_fact_emit_tipofact' then
			if not f_es_vacio(dw_listados.getitemstring(1, 'concepto')) then
				posicion = PosA(sql, "FROM")
				sql = Mid(sql,1,posicion - 1) 
				sql_aux =   "FROM csi_facturas_emitidas, csi_formas_de_pago, csi_lineas_fact_emitidas WHERE ( csi_facturas_emitidas.formadepago *= csi_formas_de_pago.tipo_pago) and (csi_facturas_emitidas.id_factura = csi_lineas_fact_emitidas.id_factura) "  
				if not isnull(sql_aux) then sql += sql_aux
				f_sql('csi_lineas_fact_emitidas.articulo','LIKE','concepto',dw_listados,sql,g_tipo_base_datos,'Concepto')
				f_sql('csi_lineas_fact_emitidas.t_iva','LIKE','t_iva',dw_listados,sql,g_tipo_base_datos,'')
			end if
		end if
		//fin modificaci$$HEX1$$f300$$ENDHEX$$n
		
		f_sql('csi_facturas_emitidas.n_fact','LIKE','n_fact',Parent.dw_listados,sql,g_tipo_base_datos,'N. Factura')
		f_sql('csi_facturas_emitidas.n_fact','>=','n_fact_desde',Parent.dw_listados,sql,g_tipo_base_datos,'N. Factura desde')
		f_sql('csi_facturas_emitidas.n_fact','<=','n_fact_hasta',Parent.dw_listados,sql,g_tipo_base_datos,'N. Factura hasta')
		f_sql('csi_facturas_emitidas.tipo_factura','LIKE','tipo_factura',Parent.dw_listados,sql,g_tipo_base_datos,'Tipo Factura')
		f_sql('csi_facturas_emitidas.n_col','LIKE','n_col',Parent.dw_listados,sql,g_tipo_base_datos,'N$$HEX2$$ba002000$$ENDHEX$$')
		f_sql('csi_facturas_emitidas.nombre','LIKE','nombre',Parent.dw_listados,sql,g_tipo_base_datos,'Nombre')
		f_sql('csi_facturas_emitidas.domicilio_largo','LIKE','domicilio',Parent.dw_listados,sql,g_tipo_base_datos,'Domicilio')
		f_sql('csi_facturas_emitidas.nif','LIKE','nif',Parent.dw_listados,sql,g_tipo_base_datos,'NIF')
		f_sql('csi_facturas_emitidas.poblacion','LIKE','poblacion',Parent.dw_listados,sql,g_tipo_base_datos,'Poblaci$$HEX1$$f300$$ENDHEX$$n')
		f_sql('csi_facturas_emitidas.formadepago','LIKE','formadepago',Parent.dw_listados,sql,g_tipo_base_datos,'Forma de Pago')
		f_sql('csi_facturas_emitidas.banco','LIKE','banco',Parent.dw_listados,sql,g_tipo_base_datos,'Banco')
		f_sql('csi_facturas_emitidas.pagado','LIKE','pagado',Parent.dw_listados,sql,g_tipo_base_datos,'Pagado')
		f_sql('csi_facturas_emitidas.emitida','LIKE','emitida',Parent.dw_listados,sql,g_tipo_base_datos,'Emitida')
		f_sql('csi_facturas_emitidas.reimpresa','LIKE','reimpresa',Parent.dw_listados,sql,g_tipo_base_datos,'Reimpresa')
		f_sql('csi_facturas_emitidas.contabilizada','LIKE','contabilizada',Parent.dw_listados,sql,g_tipo_base_datos,'Contabilizada')
		f_sql('csi_facturas_emitidas.fecha','>=','fecha_desde',Parent.dw_listados,sql,g_tipo_base_datos,'Fecha Desde')
		f_sql('csi_facturas_emitidas.fecha','<','fecha_hasta',Parent.dw_listados,sql,g_tipo_base_datos, 'Fecha Hasta')
		f_sql('csi_facturas_emitidas.f_pago','>=','f_pago_desde',Parent.dw_listados,sql,g_tipo_base_datos,'F. Pago Desde')
		f_sql('csi_facturas_emitidas.f_pago','<','f_pago_hasta',Parent.dw_listados,sql,g_tipo_base_datos,'F. Pago Hasta')
		f_sql('csi_facturas_emitidas.f_conta','>=','f_conta_desde',Parent.dw_listados,sql,g_tipo_base_datos,'F. Conta Desde')
		f_sql('csi_facturas_emitidas.f_conta','<','f_conta_hasta',Parent.dw_listados,sql,g_tipo_base_datos,'F. Conta Hasta')
		f_sql('csi_facturas_emitidas.total','>=','total_desde',dw_listados,sql,'1','')
		f_sql('csi_facturas_emitidas.total','<=','total_hasta',dw_listados,sql,'1','')
		f_sql('csi_facturas_emitidas.centro','LIKE','centro',dw_listados,sql,'1','')		
		f_sql('csi_lineas_fact_emitidas.total','>=','importe_concepto_desde',dw_listados,sql,'1','')
		f_sql('csi_lineas_fact_emitidas.total','<=','importe_concepto_hasta',dw_listados,sql,'1','')
		
		
		f_sql('csi_facturas_emitidas.anulada','LIKE','anulada',dw_listados,sql,g_tipo_base_datos,'')
		
		//SCP-933 Se extrae esta f_sql fuera del choose case para que filtren todos los listados
		/*
		//SCP-665 Filtramos los listados para no mostrar Proformas
		f_sql('csi_facturas_emitidas.proforma','=','proforma',dw_listados,sql,'1','')
		*/
		
		if (listado<>'d_listado_fact_emit_formapago' and listado<>'d_listado_fact_emit_tipofact' and listado<>'d_listado_facturas_general') then
			f_sql('csi_lineas_fact_emitidas.t_iva','=','t_iva',dw_listados,sql,'1','')
		end if
		if PosA(upper(sql), "WHERE") > 0 then
			sql_aux = " and csi_facturas_emitidas.empresa ='"+g_empresa+"'"
		else
			sql_aux = " WHERE csi_facturas_emitidas.empresa ='"+g_empresa+"'"
		end if	
		if not isnull(sql_aux) then sql += sql_aux	
		
		//Modificado por Luis 27/04/2009 para incidencia cte-52
		if not f_es_vacio(dw_listados.getitemstring(1, 'concepto')) then
			if(listado <> 'd_listado_fact_emit_tipofact')then
				sql = f_sql_join(sql, {'( csi_facturas_emitidas.id_factura = csi_lineas_fact_emitidas.id_factura )'})
				f_sql('csi_lineas_fact_emitidas.articulo','LIKE','concepto',dw_listados,sql,g_tipo_base_datos,'Concepto')
				f_sql('csi_lineas_fact_emitidas.t_iva','LIKE','t_iva',dw_listados,sql,g_tipo_base_datos,'')
			end if
		end if
		//fin modificaci$$HEX1$$f300$$ENDHEX$$n
		//f_sql('csi_lineas_fact_emitidas.articulo','LIKE','concepto',dw_listados,sql,g_tipo_base_datos,'Concepto')
		
		// MODIFICADO RICARDO 2005-03-09
		// Hacemos que no se tengan en cuenta las de solo a efecto de pago
		f_sql('csi_facturas_emitidas.solo_pagos','LIKE','solo_pagos',dw_listados,sql,g_tipo_base_datos,'')		
		
		//Cambio realizado por Luis para la incidencia cgn-256 13/01/2009
		f_sql('csi_facturas_emitidas.proyecto','LIKE','proyecto',dw_listados,sql,g_tipo_base_datos,'')
		
		
		dw_1.SetTransobject(SQLCA)
		dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
		dw_1.retrieve()		
//		datetime f_hasta
////		string parametros_listado = ''
//		f_hasta = dw_listados.getitemdatetime(1,'f_pago_hasta')
//		if not isnull(f_hasta) then g_parametros_listados += "Fecha Hasta: "+string(f_hasta, "DD/MM/YYYY")
//		dw_1.object.valores[1] = g_parametros_listados		
		b_visible = dw_1.RowCount()>0
end choose		

//Listado de transferencias de IVA externa
if listado = 'd_listado_transferencias_iva_ext' then
	// Recorremos las lineas para ir acumulando los importe por colegiado 
	// y rellenando la datawindow externa
	string n_col = '', n_col_ant = '', cuenta, nom_col, cuenta_ant, nom_col_ant
	double importe_col, fila_nueva
	for i = 1 to dw_1.rowcount()
		n_col = dw_1.getitemstring(i, 'colegiados_n_colegiado')
		cuenta = dw_1.getitemstring(i, 'conceptos_remesables_datos_bancarios')
		nom_col = dw_1.getitemstring(i, 'compute_9')
		if n_col <> n_col_ant then
			if n_col_ant <> '' then
				fila_nueva = d_detalle_transferencias.insertrow(0)
				d_detalle_transferencias.setitem(fila_nueva, 'n_col', n_col_ant)
				d_detalle_transferencias.setitem(fila_nueva, 'nom_col', nom_col_ant)
				d_detalle_transferencias.setitem(fila_nueva, 'cuenta', cuenta_ant)
				d_detalle_transferencias.setitem(fila_nueva, 'importe_total', importe_col)				
			end if
			importe_col = dw_1.getitemnumber(i, 'subtotal')
		else
			importe_col += dw_1.getitemnumber(i, 'subtotal')
		end if
		n_col_ant = n_col
		cuenta_ant = cuenta
		nom_col_ant = nom_col
		if i = dw_1.rowcount() then
			fila_nueva = d_detalle_transferencias.insertrow(0)
			d_detalle_transferencias.setitem(fila_nueva, 'n_col', n_col_ant)
			d_detalle_transferencias.setitem(fila_nueva, 'nom_col', nom_col_ant)
			d_detalle_transferencias.setitem(fila_nueva, 'cuenta', cuenta_ant)
			d_detalle_transferencias.setitem(fila_nueva, 'importe_total', importe_col)					
		end if
	next
	// Visualizaremos la datawindow externa
	dw_1.dataobject = 'd_listado_transferencias_iva_ext'
	// Rellenamos la dw externa desde la datastore
	for i = 1 to d_detalle_transferencias.rowcount()
		fila_nueva = dw_1.insertrow(0)
		dw_1.setitem(fila_nueva, 'n_col', d_detalle_transferencias.getitemstring(i,'n_col'))
		dw_1.setitem(fila_nueva, 'nom_col', d_detalle_transferencias.getitemstring(i,'nom_col'))
		dw_1.setitem(fila_nueva, 'cuenta', d_detalle_transferencias.getitemstring(i,'cuenta'))
		dw_1.setitem(fila_nueva, 'importe_total', d_detalle_transferencias.getitemnumber(i,'importe_total'))				
	next
end if



// Al final: (Cambiado por Ricardo por el datawindow composite incluido 16-09-03)
if b_visible then
	dw_1.visible = true
	// No tiene reports y no son etiquetas, hacemos el preview
	if dw_1.Describe("DataWindow.Nested") = "no" and dw_1.describe("Datawindow.Label.Columns") = "0" then
		dw_1.event pfc_printpreview()
	end if
	this.enabled        = false
	cb_zoom.enabled     = true
	cb_imprimir.enabled = true
	cb_guardar.enabled  = true
	cb_escala.enabled  = true
	cb_ordenar.enabled  = true
	// Restauro el puntero si lo he tocado
	setpointer(arrow!)
else
	messagebox(g_titulo,'No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.')
	// Restauro el puntero si lo he tocado
	setpointer(arrow!)
end if

end event

type cb_salir from w_listados`cb_salir within w_facturacion_emitida_listados
end type

type dw_listados from w_listados`dw_listados within w_facturacion_emitida_listados
event csd_tipo_factura ( )
integer width = 2126
integer height = 2016
string dataobject = "d_facturacion_emitida_consulta"
end type

event dw_listados::csd_tipo_factura();string tipo_fact

accepttext()

tipo_fact = this.getitemstring(1, 'tipo_factura')

CHOOSE CASE tipo_fact
	CASE '03'
		this.object.b_busqueda_clientes_exp.visible = false
		this.object.b_busqueda_clientes_csi.visible = false
		this.object.b_busqueda_colegiados.visible = true
	CASE '02', '04'
		this.object.b_busqueda_clientes_exp.visible = true
		this.object.b_busqueda_clientes_csi.visible = false
		this.object.b_busqueda_colegiados.visible = false
	CASE ELSE
		this.object.b_busqueda_clientes_exp.visible = true
		this.object.b_busqueda_clientes_csi.visible = false
		this.object.b_busqueda_colegiados.visible = true
END CHOOSE
end event

event dw_listados::itemchanged;call super::itemchanged;string tipo_factura
string id_persona
tipo_factura = this.getitemstring(1, 'tipo_factura')
choose case dwo.name
		
	// SCP-933.
	
	// Se a$$HEX1$$f100$$ENDHEX$$ade c$$HEX1$$f300$$ENDHEX$$digo de la ventana de consulta para que tanto el campo proforma como los dos desplegables de series se comporten igual que la ventana de consulta
	CASE 'serie','serie_proforma'
		//En caso de modificar la serie y estar con proforma='S', el campo proforma pasar$$HEX2$$e1002000$$ENDHEX$$a ser NO
		if this.GetItemString(1,'proforma')='S' and data<>g_serie_proforma then this.setItem(1,'proforma','N')
		//En caso de estar en todos y seleccionar la serie PROFORM, el check proforma pasa a SI
		if this.GetItemString(1,'proforma')='%' and data=g_serie_proforma then this.setItem(1,'proforma','S')
		this.SetItem(1,'n_fact','')
		this.SetItem(1,'n_fact_desde','')
		this.SetItem(1,'n_fact_hasta','')		
		//En este caso ponemos en el n_factura el nombre de la serie
		if LeftA(data,6) <> 'COLEGI' then
			this.SetItem(1,'n_fact',data)
		else
			this.SetItem(1,'n_fact_desde',FillA('0',15))
			this.SetItem(1,'n_fact_hasta',FillA('9',15))
		end if
	
	CASE 'proforma'
		//Dejamos en blanco estos campos por si anteriormente se ha seleccionado 'COLEGI' y se han mostrado.
		this.SetItem(1,'n_fact_desde','')
		this.SetItem(1,'n_fact_hasta','')
		CHOOSE CASE data
			case 'S'
				this.object.serie_proforma.visible=false
				//Dejamos en blanco la serie para que aparezca PROFOR
				this.setItem(1,'serie','')
				this.setItem(1,'serie',g_serie_proforma)
				this.setItem(1,'n_fact',g_serie_proforma)				
			case 'N'
				this.object.serie_proforma.visible=false
				this.setItem(1,'serie','')
				this.setItem(1,'n_fact','')
			case '%'
				//Al seleccionar todos, el desplegable de series incluir$$HEX2$$e1002000$$ENDHEX$$la serie 'PROFORM'
				this.object.serie_proforma.visible=true
				this.setItem(1,'serie','')
				this.setItem(1,'serie_proforma','')
				this.setItem(1,'n_fact','')
		END CHOOSE
	//Fin SCP-933
	
	case 'serie'
		this.setitem(1,'n_fact',data)
	case 'n_col'
		if this.object.b_busqueda_colegiados.visible = true then
//			id_persona=f_busqueda_colegiados()
//			//Comprobamos que el colegiado existe
//			if id_persona="-1" then
//				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
//				this.setfocus()
//				return -1
//			else
//				this.SetItem(1,'id_persona',id_persona)
//				this.SetItem(1,'n_col',f_colegiado_n_col(id_persona))				
//			end if			
		elseif this.object.b_busqueda_clientes_exp.visible = true then
//			id_persona=f_busqueda_clientes_exp()
//		
//			if id_persona="-1" then
//				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de cliente v$$HEX1$$e100$$ENDHEX$$lido.')
//				this.setfocus()
//				return -1
//			else
//				this.SetItem(1,'id_persona',id_persona)
//				this.SetItem(1,'n_col',f_clientes_n_cliente(id_persona))				
//			end if			
		elseif this.object.b_busqueda_clientes_csi.visible = true then
//			id_persona=f_busqueda_clientes_csi()
//
//			if id_persona="-1" then
//				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de cliente v$$HEX1$$e100$$ENDHEX$$lido.')
//				this.setfocus()
//				return -1
//			else
//				this.SetItem(1,'id_persona',id_persona)
//				this.SetItem(1,'n_col',f_csi_dame_codigo(id_persona))				
//			end if			
		else
//			id_persona=f_busqueda_colegiados()
//			//Comprobamos que el colegiado existe
//			if id_persona="-1" then
//				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
//				this.setfocus()
//				return -1
//			else
//				this.SetItem(1,'id_persona',id_persona)
//				this.SetItem(1,'n_col',f_colegiado_n_col(id_persona))				
//			end if						
		end if
	case 'tipo_factura'
		this.event csd_tipo_factura()	
		
end choose

end event

event dw_listados::buttonclicked;call super::buttonclicked;this.accepttext()
string id_persona,cuenta
// C$$HEX1$$f300$$ENDHEX$$digo a ejecutar cuando se pincha sobre el btn de B$$HEX1$$fa00$$ENDHEX$$squeda asociado a la persona a la que
//  se le ha emitido la factura

CHOOSE CASE dwo.name
	CASE 'b_busqueda_colegiados'
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
			g_busqueda.dw="d_lista_busqueda_colegiados"
			id_persona=f_busqueda_colegiados()
			//Comprobamos que el colegiado existe
			if id_persona="-1" then
				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
				this.setfocus()
				return -1
			else
				this.SetItem(1,'id_persona',id_persona)
				this.SetItem(1,'n_col',f_colegiado_n_col(id_persona))				
			end if
		case 'b_busqueda_colegiados2'
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
			g_busqueda.dw="d_lista_busqueda_colegiados"
			id_persona=f_busqueda_colegiados()
			//Comprobamos que el colegiado existe
			if id_persona="-1" then
				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
				this.setfocus()
				return -1
			else
				this.SetItem(1,'id_persona',id_persona)
				this.SetItem(1,'n_col_2',f_colegiado_n_col(id_persona))				
			end if
			
		CASE 'b_busqueda_clientes_exp'
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Clientes de Expedientes"
			g_busqueda.dw="d_lista_busqueda_clientes"
			id_persona=f_busqueda_clientes_exp()
		
			if id_persona="-1" then
				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de cliente v$$HEX1$$e100$$ENDHEX$$lido.')
				this.setfocus()
				return -1
			else
				this.SetItem(1,'id_persona',id_persona)
				this.SetItem(1,'nif',f_dame_nif(id_persona))				
			end if
			
		CASE 'b_busqueda_clientes_csi'
//			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Clientes Generales"
//			g_busqueda.dw="d_lista_busqueda_clientes_csi"
//			id_persona=f_busqueda_clientes_csi()
//
//			if id_persona="-1" then
//				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de cliente v$$HEX1$$e100$$ENDHEX$$lido.')
//				this.setfocus()
//				return -1
//			else
//				this.SetItem(1,'id_persona',id_persona)
//				this.SetItem(1,'n_col',f_csi_dame_codigo(id_persona))				
//			end if
	end choose
		RETURN 1
end event

event dw_listados::csd_oculta;call super::csd_oculta;boolean lb_fecha_visible = TRUE
string listado
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')

this.setredraw(false)
this.reset()
this.insertrow(0)

	//Martin
		this.object.t_1.visible = true
		this.object.anulada.visible = true	
		//fin Martin
		

choose case listado
	case 'd_libro_iva_factu_e_general', 'd_libro_iva_factu_e_general_f_conta', 'd_libro_iva_factu_r_general', &
		  'd_listado_transferencias_iva', 'd_infocol', 'd_infocol_iva', 'd_listado_transferencias_iva_detallado', &
		  'd_listado_transferencias_iva_ext', 'd_conta_extracto_irpf_colegio_detalle','d_conta_extracto_irpf_colegio_lineas', &
		  'd_iva_colegiado_za', 'd_libro_iva_factu_e_exentas'
		this.object.serie.visible = false; 					this.object.serie_t.visible = false
		this.object.n_fact.visible = false; 				this.object.n_fact_t.visible = false
		this.object.n_fact_desde.visible = false;			this.object.n_fact_desde_t.visible = false
		this.object.n_fact_hasta.visible = false;			this.object.n_fact_hasta_t.visible = false
		this.object.centro.visible = false;					this.object.centro_t.visible = false
		this.object.tipo_factura.visible = false;			this.object.tipo_factura_t.visible = false
		this.object.n_col.visible = false;					this.object.n_col_t.visible = false
		this.object.nombre.visible = false;					this.object.nombre_t.visible = false
		this.object.domicilio.visible = false;				this.object.domicilio_t.visible = false
		this.object.nif.visible = false;						this.object.nif_t.visible = false
		this.object.poblacion.visible = false;				this.object.poblacion_t.visible = false
		this.object.formadepago.visible = false;			this.object.formadepago_t.visible = false
		this.object.banco.visible = false;					this.object.banco_t.visible = false
		this.object.pagado.visible = false;					this.object.pagado_t.visible = false			
		this.object.emitida.visible = false;				this.object.emitida_t.visible = false						
		this.object.reimpresa.visible = false;				this.object.reimpresa_t.visible = false								
		this.object.contabilizada.visible = false	;		this.object.contabilizada_t.visible = false							
		this.object.n_expedi.visible = false; 				this.object.n_expedi_t.visible = false
		this.object.n_registro.visible = false; 			this.object.n_registro_t.visible = false
		this.object.lista_colegiados.visible = false;	this.object.lista_colegiados_t.visible = false
		this.object.familia.visible = false;				this.object.familia_t.visible = false
		this.object.concepto.visible = false;				this.object.concepto_t.visible = false		
		this.object.f_pago_desde_t.visible = false					
		this.object.f_pago_desde.visible = false;			this.object.f_pago_hasta.visible = false								
		this.object.f_conta_desde_t.visible = false					
		this.object.f_conta_desde.visible = false;		this.object.f_conta_hasta.visible = false			
		this.object.total_t.visible = false					
		this.object.total_desde.visible = false;			this.object.total_hasta.visible = false			
		this.object.fase.visible = false;					this.object.t_t_iva.visible = false;
		this.object.documento_t.visible = false;			this.object.t_iva.visible = false;
		this.object.total_concepto.visible = false					
		this.object.importe_concepto_desde.visible = false
		this.object.importe_concepto_hasta.visible = false		
		this.object.b_busqueda_colegiados.visible = false
		this.object.b_busqueda_clientes_exp.visible = false
		this.object.b_busqueda_clientes_csi.visible = false	
		
		//Martin
		this.object.t_1.visible = false	
		this.object.anulada.visible = false	
		//fin Martin
		
		
		
	
	case 'd_colegiado_listado_sit_resumen','d_colegiado_listado_sit_detallado'
		this.object.serie.visible = false; 					this.object.serie_t.visible = false
		this.object.n_fact.visible = false; 				this.object.n_fact_t.visible = false
		this.object.n_fact_desde.visible = false;			this.object.n_fact_desde_t.visible = false
		this.object.n_fact_hasta.visible = false;			this.object.n_fact_hasta_t.visible = false
		this.object.centro.visible = false;					this.object.centro_t.visible = false
		this.object.tipo_factura.visible = false;			this.object.tipo_factura_t.visible = false
		this.object.n_col.visible = true;					this.object.n_col_t.visible = true
		this.object.nombre.visible = false;					this.object.nombre_t.visible = false
		this.object.domicilio.visible = false;				this.object.domicilio_t.visible = false
		this.object.nif.visible = false;						this.object.nif_t.visible = false
		this.object.poblacion.visible = false;				this.object.poblacion_t.visible = false
		this.object.formadepago.visible = false;			this.object.formadepago_t.visible = false
		this.object.banco.visible = false;					this.object.banco_t.visible = false
		this.object.pagado.visible = true;					this.object.pagado_t.visible = true			
		this.object.emitida.visible = false;				this.object.emitida_t.visible = false						
		this.object.reimpresa.visible = false;				this.object.reimpresa_t.visible = false								
		this.object.contabilizada.visible = false	;		this.object.contabilizada_t.visible = false							
		this.object.n_expedi.visible = false; 				this.object.n_expedi_t.visible = false
		this.object.n_registro.visible = false; 			this.object.n_registro_t.visible = false
		this.object.lista_colegiados.visible = false;	this.object.lista_colegiados_t.visible = false
		this.object.familia.visible = false;				this.object.familia_t.visible = false
		this.object.concepto.visible = false;				this.object.concepto_t.visible = false		
		this.object.f_pago_desde_t.visible = false					
		this.object.f_pago_desde.visible = false;			this.object.f_pago_hasta.visible = false								
		this.object.f_conta_desde_t.visible = false					
		this.object.f_conta_desde.visible = false;		this.object.f_conta_hasta.visible = false			
		this.object.total_t.visible = false					
		this.object.total_desde.visible = false;			this.object.total_hasta.visible = false			
		this.object.fase.visible = false					
		this.object.documento_t.visible = false
		this.object.total_concepto.visible = false					
		this.object.importe_concepto_desde.visible = false
		this.object.importe_concepto_hasta.visible = false		
		this.object.b_busqueda_colegiados.visible = true
		this.object.b_busqueda_clientes_exp.visible = false
		this.object.b_busqueda_clientes_csi.visible = false	
		this.object.centro.visible = false	
		this.object.centro_t.visible = false	
		this.object.t_1.visible = false	
		this.object.anulada.visible = false	
		this.object.t_2.visible = false	
		this.object.proyecto.visible = false
		this.object.t_t_iva.visible = false;
		this.object.t_iva.visible = false;
		
				//Martin
		this.object.t_1.visible = false	
		this.object.anulada.visible = false	
		//fin Martin
	
	CASE 'd_factu_e_listado_articulos', 'd_factu_e_listado_articulos_desglosado', 'd_resumen_movimientos_caja_teb'
		
		/*this.object.serie.visible = false; CGN-293*/
		this.object.serie.visible = true;				this.object.serie_t.visible = true		
		this.object.n_fact.visible = false; 				this.object.n_fact_t.visible = false	
		this.object.n_fact_desde.visible = false; 		this.object.n_fact_desde_t.visible = false					
		this.object.n_fact_hasta.visible = false; 		this.object.n_fact_hasta_t.visible = false					
		this.object.centro.visible = false; 				this.object.centro_t.visible = false					
		this.object.tipo_factura.visible = false; 		this.object.tipo_factura_t.visible = false					
		this.object.n_col.visible = false; 					this.object.n_col_t.visible = false					
		this.object.nombre.visible = false;					this.object.nombre_t.visible = false					
		this.object.domicilio.visible = false;				this.object.domicilio_t.visible = false					
		this.object.nif.visible = false; 					this.object.nif_t.visible = false					
		this.object.poblacion.visible = false; 			this.object.poblacion_t.visible = false					
		this.object.formadepago.visible = false; 			this.object.formadepago_t.visible = false					
		this.object.banco.visible = false;					this.object.banco_t.visible = false					
		this.object.pagado.visible = false;					this.object.pagado_t.visible = false			
		this.object.emitida.visible = false;				this.object.emitida_t.visible = false						
		this.object.reimpresa.visible = false;				this.object.reimpresa_t.visible = false								
		this.object.contabilizada.visible = false;		this.object.contabilizada_t.visible = false
		this.object.n_expedi.visible = false; 				this.object.n_expedi_t.visible = false
		this.object.n_registro.visible = false; 			this.object.n_registro_t.visible = false
		this.object.lista_colegiados.visible = false;	this.object.lista_colegiados_t.visible = false
		this.object.familia.visible = false;				this.object.familia_t.visible = false
		this.object.f_pago_desde.visible = true; 			this.object.f_pago_desde_t.visible = true		
		this.object.f_conta_desde.visible = false;		this.object.f_conta_desde_t.visible = false
		this.object.f_conta_hasta.visible = false			
		this.object.total_desde.visible = false; 			this.object.total_t.visible = false
		this.object.total_hasta.visible = false			
		this.object.concepto.visible = true;				this.object.concepto_t.visible = true
		this.object.total_concepto.visible = false
		this.object.f_pago_hasta.visible = true		
		this.object.importe_concepto_desde.visible = false
		this.object.importe_concepto_hasta.visible = false
		this.object.b_busqueda_colegiados.visible = false
		this.object.b_busqueda_clientes_exp.visible = false
		this.object.b_busqueda_clientes_csi.visible = false
		this.object.fase.visible = false	
		this.object.documento_t.visible = false
		this.object.t_t_iva.visible = false;
		this.object.t_iva.visible = false;
		if(listado = 'd_resumen_movimientos_caja_teb')then
			this.object.anulada.visible = false	
			this.object.t_1.visible = false	
			this.object.proyecto.visible = false	
			this.object.t_2.visible = false	
		end if
		
			//Martin
		this.object.t_1.visible = false	
		this.object.anulada.visible = false	
		//fin Martin
		
		
	CASE 'd_colegiados_listado_importe_facturado_347', 'd_factu_e_listado_cip_mensual'
		
		this.object.serie_t.visible = false;				this.object.n_fact.visible = false; 				
		this.object.n_fact_t.visible = false	
		this.object.n_fact_desde.visible = false; 		this.object.n_fact_desde_t.visible = false					
		this.object.n_fact_hasta.visible = false; 		this.object.n_fact_hasta_t.visible = false					
		this.object.centro.visible = false; 				this.object.centro_t.visible = false					
		this.object.tipo_factura.visible = false; 		this.object.tipo_factura_t.visible = false					
		this.object.n_col.visible = false; 					this.object.n_col_t.visible = false					
		this.object.nombre.visible = false;					this.object.nombre_t.visible = false					
		this.object.domicilio.visible = false;				this.object.domicilio_t.visible = false					
		this.object.nif.visible = false; 					this.object.nif_t.visible = false					
		this.object.poblacion.visible = false; 			this.object.poblacion_t.visible = false					
		this.object.formadepago.visible = false; 			this.object.formadepago_t.visible = false					
		this.object.banco.visible = false;					this.object.banco_t.visible = false					
		this.object.pagado.visible = false;					this.object.pagado_t.visible = false			
		this.object.emitida.visible = false;				this.object.emitida_t.visible = false						
		this.object.reimpresa.visible = false;				this.object.reimpresa_t.visible = false								
		this.object.contabilizada.visible = false;		this.object.contabilizada_t.visible = false
		this.object.n_expedi.visible = false; 				this.object.n_expedi_t.visible = false
		this.object.n_registro.visible = false; 			this.object.n_registro_t.visible = false
		this.object.lista_colegiados.visible = false;	this.object.lista_colegiados_t.visible = false
		this.object.familia.visible = false;				this.object.familia_t.visible = false
		this.object.f_pago_desde.visible = false;     this.object.f_conta_desde.visible = false;		
		this.object.f_conta_desde_t.visible = false
		this.object.serie_t.visible = false
		this.object.serie.visible = false
		this.object.concepto_t.visible = false
		this.object.concepto.visible = false
		this.object.f_conta_hasta.visible = false			
		this.object.f_pago_desde_t.visible = false
		this.object.f_pago_desde.visible = false
		this.object.f_pago_hasta.visible = false
		this.object.total_desde.visible = false; 			this.object.total_t.visible = false
		this.object.total_hasta.visible = false			
		this.object.concepto.visible = false;				this.object.concepto_t.visible = false
		this.object.total_concepto.visible = false
		this.object.f_pago_hasta.visible = false		
		this.object.importe_concepto_desde.visible = false
		this.object.importe_concepto_hasta.visible = false
		this.object.b_busqueda_colegiados.visible = false
		this.object.b_busqueda_clientes_exp.visible = false
		this.object.b_busqueda_clientes_csi.visible = false
		this.object.fase.visible = false	
		this.object.documento_t.visible = false	
		this.object.anulada.visible = false	
		this.object.t_1.visible = false	
		this.object.proyecto.visible = false	
		this.object.t_2.visible = false	
		this.object.t_t_iva.visible = false;
		this.object.t_iva.visible = false;
		
CASE  'd_facturas_listado_impagadas'
	   this.object.serie.visible = false; 					this.object.serie_t.visible = false
		this.object.n_fact.visible = false; 				this.object.n_fact_t.visible = false
		this.object.n_fact_desde.visible = false;			this.object.n_fact_desde_t.visible = false
		this.object.n_fact_hasta.visible = false;			this.object.n_fact_hasta_t.visible = false
		this.object.centro.visible = false;					this.object.centro_t.visible = false
		this.object.tipo_factura.visible = false;			this.object.tipo_factura_t.visible = false
		this.object.n_col.visible = false;					this.object.n_col_t.visible = false
		this.object.nombre.visible = false;					this.object.nombre_t.visible = false
		this.object.domicilio.visible = false;				this.object.domicilio_t.visible = false
		this.object.nif.visible = false;						this.object.nif_t.visible = false
		this.object.poblacion.visible = false;				this.object.poblacion_t.visible = false
		this.object.formadepago.visible = false;			this.object.formadepago_t.visible = false
		this.object.banco.visible = false;					this.object.banco_t.visible = false
		this.object.pagado.visible = false;					this.object.pagado_t.visible = false			
		this.object.emitida.visible = false;				this.object.emitida_t.visible = false						
		this.object.reimpresa.visible = false;				this.object.reimpresa_t.visible = false								
		this.object.contabilizada.visible = false	;		this.object.contabilizada_t.visible = false							
		this.object.n_expedi.visible = false; 				this.object.n_expedi_t.visible = false
		this.object.n_registro.visible = false; 			this.object.n_registro_t.visible = false
		this.object.lista_colegiados.visible = false;	this.object.lista_colegiados_t.visible = false
		this.object.familia.visible = false;				this.object.familia_t.visible = false
		this.object.concepto.visible = false;				this.object.concepto_t.visible = false		
		this.object.f_pago_desde_t.visible = false					
		this.object.f_pago_desde.visible = false;			this.object.f_pago_hasta.visible = false								
		this.object.f_conta_desde_t.visible = false					
		this.object.f_conta_desde.visible = false;		this.object.f_conta_hasta.visible = false			
		this.object.total_t.visible = false					
		this.object.total_desde.visible = false;			this.object.total_hasta.visible = false			
		this.object.fase.visible = false
		this.object.documento_t.visible = false
		this.object.total_concepto.visible = false					
		this.object.importe_concepto_desde.visible = false
		this.object.importe_concepto_hasta.visible = false		
		this.object.b_busqueda_colegiados.visible = false
		this.object.b_busqueda_clientes_exp.visible = false
		this.object.b_busqueda_clientes_csi.visible = false	
		this.object.t_t_iva.visible = false;
		this.object.t_iva.visible = false;
		
				//Martin
		this.object.t_1.visible = false	
		this.object.anulada.visible = false	
		//fin Martin
		
	
	// SCP-886, SCP-892 Se activa el nuevo informe.
	// Consultaremos por Centro, Banco, Fecha desde ... Hasta, y Fecha Pago desde ... Hasta
	// Este informe no aplicar$$HEX2$$e1002000$$ENDHEX$$f_sql por ser un composite: se le aplicar$$HEX2$$e1002000$$ENDHEX$$Retrieve 
	CASE 'd_listado_fact_l_g_c_composite', 'd_listado_fact_l_g_c_composite_des'	
	   this.object.serie.visible = false; 					this.object.serie_t.visible = false
		this.object.n_fact.visible = false; 				this.object.n_fact_t.visible = false
		this.object.n_fact_desde.visible = false;			this.object.n_fact_desde_t.visible = false
		this.object.n_fact_hasta.visible = false;			this.object.n_fact_hasta_t.visible = false
		this.object.centro.visible = TRUE;					this.object.centro_t.visible = TRUE
		this.object.tipo_factura.visible = false;			this.object.tipo_factura_t.visible = false
		this.object.n_col.visible = false;					this.object.n_col_t.visible = false
		this.object.nombre.visible = false;					this.object.nombre_t.visible = false
		this.object.domicilio.visible = false;				this.object.domicilio_t.visible = false
		this.object.nif.visible = false;						this.object.nif_t.visible = false
		this.object.poblacion.visible = false;				this.object.poblacion_t.visible = false
		this.object.formadepago.visible = false;			this.object.formadepago_t.visible = false
		this.object.banco.visible = TRUE;					this.object.banco_t.visible = TRUE
		this.object.pagado.visible = TRUE;					this.object.pagado_t.visible = TRUE
		this.object.emitida.visible = false;				this.object.emitida_t.visible = false						
		this.object.reimpresa.visible = false;				this.object.reimpresa_t.visible = false								
		this.object.contabilizada.visible = false	;		this.object.contabilizada_t.visible = false							
		this.object.n_expedi.visible = false; 				this.object.n_expedi_t.visible = false
		this.object.n_registro.visible = false; 			this.object.n_registro_t.visible = false
		this.object.lista_colegiados.visible = false;	this.object.lista_colegiados_t.visible = false
		this.object.familia.visible = false;				this.object.familia_t.visible = false
		this.object.concepto.visible = false;				this.object.concepto_t.visible = false		
		this.object.f_pago_desde_t.visible = false					
		this.object.f_pago_desde.visible = false;			this.object.f_pago_hasta.visible = false
		this.object.f_conta_desde_t.visible = false					
		this.object.f_conta_desde.visible = false;		this.object.f_conta_hasta.visible = false			
		this.object.total_t.visible = false					
		this.object.total_desde.visible = false;			this.object.total_hasta.visible = false			
		this.object.fase.visible = false
		this.object.documento_t.visible = false
		this.object.total_concepto.visible = false					
		this.object.importe_concepto_desde.visible = false
		this.object.importe_concepto_hasta.visible = false		
		this.object.b_busqueda_colegiados.visible = false
		this.object.b_busqueda_clientes_exp.visible = false
		this.object.b_busqueda_clientes_csi.visible = false	
		this.object.t_1.visible = false	
		this.object.anulada.visible = false	
		this.object.t_2.visible = false	
		this.object.proyecto.visible = false
		this.object.t_t_iva.visible = false;
		this.object.t_iva.visible = false;
		
	case else
		this.object.serie.visible = true; 					this.object.serie_t.visible = true		
		this.object.n_fact.visible = true;					this.object.n_fact_t.visible = true	
		this.object.n_fact_desde.visible = true;			this.object.n_fact_desde_t.visible = true					
		this.object.n_fact_hasta.visible = true;			this.object.n_fact_hasta_t.visible = true					
		this.object.centro.visible = true;					this.object.centro_t.visible = true					
		this.object.tipo_factura.visible = true;			this.object.tipo_factura_t.visible = true					
		this.object.n_col.visible = true;					this.object.n_col_t.visible = true					
		this.object.nombre.visible = true;					this.object.nombre_t.visible = true					
		this.object.domicilio.visible = true;				this.object.domicilio_t.visible = true					
		this.object.nif.visible = true;						this.object.nif_t.visible = true					
		this.object.poblacion.visible = true;				this.object.poblacion_t.visible = true					
		this.object.formadepago.visible = true;			this.object.formadepago_t.visible = true					
		this.object.banco.visible = true;					this.object.banco_t.visible = true					
		this.object.pagado.visible = true;					this.object.pagado_t.visible = true			
		this.object.emitida.visible = true;					this.object.emitida_t.visible = true						
		this.object.reimpresa.visible = true;				this.object.reimpresa_t.visible = true								
		this.object.contabilizada.visible = true;			this.object.contabilizada_t.visible = true
		this.object.n_expedi.visible = true; 				this.object.n_expedi_t.visible = true
		this.object.n_registro.visible = true; 			this.object.n_registro_t.visible = true
		this.object.lista_colegiados.visible = true; 	this.object.lista_colegiados_t.visible = true	
		this.object.familia.visible = true;					this.object.familia_t.visible = true		
		this.object.concepto.visible = true;				this.object.concepto_t.visible = true		
		this.object.f_pago_desde_t.visible = true					
		this.object.f_pago_desde.visible = true;			this.object.f_pago_hasta.visible = true								
		this.object.f_conta_desde_t.visible = true					
		this.object.f_conta_desde.visible = true;			this.object.f_conta_hasta.visible = true			
		this.object.total_t.visible = true					
		this.object.total_desde.visible = true;			this.object.total_hasta.visible = true
		this.object.total_concepto.visible = false
		this.object.fase.visible = true			
		this.object.documento_t.visible = true							
		this.object.importe_concepto_desde.visible = false
		this.object.importe_concepto_hasta.visible = false
		this.object.b_busqueda_colegiados.visible = true		
		this.object.b_busqueda_clientes_exp.visible = true
		this.object.b_busqueda_clientes_csi.visible = true
		this.object.t_t_iva.visible = true;
		this.object.t_iva.visible = true;
		
					//Martin
		this.object.t_1.visible = true
		this.object.anulada.visible = true	
		//fin Martin
		
		if (listado='d_listado_fact_emit_formapago' or listado='d_listado_fact_emit_tipofact' or listado='d_listado_facturas_general' or listado = 'd_factu_e_listado_impagos_premaat') then
			this.object.t_t_iva.visible = false;
			this.object.t_iva.visible = false;
		end if
		this.event csd_tipo_factura()
end choose

// N.colegiado
if listado = 'd_infocol' or listado = 'd_listado_transferencias_iva' or listado = 'd_infocol_iva' or listado = 'd_listado_transferencias_iva_detallado' &
or listado = 'd_iva_colegiado_za'  then
	this.object.n_col_2.visible = true				
	this.object.n_col_2_t.visible = true	
	this.object.b_busqueda_colegiados2.visible = true
else
	this.object.n_col_2.visible = false			
	this.object.n_col_2_t.visible = false	
	this.object.b_busqueda_colegiados2.visible = false	
end if

// Centro
if listado = 'd_infocol' or listado = 'd_infocol_iva' or listado = 'd_iva_colegiado_za' or listado = 'd_colegiados_listado_importe_facturado_347' &
 or listado ='d_colegiado_listado_sit_resumen' or listado ='d_colegiado_listado_sit_detallado' then
	this.object.centro.visible    = false
	this.object.centro_t.visible = false	
else
	this.object.centro.visible    = true			
	this.object.centro_t.visible = true
end if

// Por concepto
If listado = 'd_listado_facturas_general_detallado' then
	this.object.concepto.visible = true;		this.object.concepto_t.visible = true
	this.object.total_concepto.visible = true
	this.object.importe_concepto_desde.visible = true; 		this.object.importe_concepto_hasta.visible = true
	this.object.t_t_iva.visible = true
	this.object.t_iva.visible = true
	
end if

// MODIFICADO RICARDO 2005-03-09
// Juli$$HEX1$$e100$$ENDHEX$$n Se deja visible si el listado es de facturas general y para el colegio COAATTEB
If listado = 'd_listado_facturas_general' and g_colegio = 'COAATTEB' then
	this.object.solo_pagos.visible = true; this.object.solo_pagos_t.visible = true
else
	this.object.solo_pagos.visible = false // ESte nunca lo dejamos visible
	this.object.solo_pagos_t.visible = false // ESte nunca lo dejamos visible
end if

//SCP-933 Se vuelve a hacer visible el campo proforma excepto para los listados que ya est$$HEX1$$e100$$ENDHEX$$n filtrados
// SCP-1088 Se ocultan tb. las opciones de Proforma dado que no est$$HEX2$$e1002000$$ENDHEX$$disponible para 'd_listado_fact_l_g_c_composite', 'd_listado_fact_l_g_c_composite_des'	
if listado='d_factu_e_listado_articulos' or listado='d_factu_e_listado_articulos_desglosado' or listado='d_listado_facturas_x_usuario' &
or listado='d_conta_extracto_irpf_colegio_detalle' or listado='d_listado_transferencias_iva_ext' &
or listado='d_listado_transferencias_iva_detallado' or listado='d_colegiados_listado_importe_facturado_347' &
or listado='d_libro_iva_factu_e_general' or listado='d_listado_fact_emit_tipofact' or listado='d_libro_iva_factu_e_exentas' &
or listado='d_listado_fact_l_g_c_composite' or listado= 'd_listado_fact_l_g_c_composite_des'	&
or listado = 'd_listado_proformas' then
	//SCP-665 Se hace NO visible el campo proforma utilizado para la consulta de facturas
	this.object.proforma.visible=false
	this.object.proforma_t.visible=false
	if listado = 'd_listado_proformas' then
		this.object.serie_proforma.visible = false
		this.object.serie.visible = false
		this.object.serie_t.visible = false
	end if
else
	this.object.proforma.visible=true
	this.object.proforma_t.visible=true
end if


this.setredraw(true)



end event

type cb_imprimir from w_listados`cb_imprimir within w_facturacion_emitida_listados
end type

type cb_zoom from w_listados`cb_zoom within w_facturacion_emitida_listados
end type

type cb_esp from w_listados`cb_esp within w_facturacion_emitida_listados
end type

type cb_guardar from w_listados`cb_guardar within w_facturacion_emitida_listados
end type

event cb_guardar::clicked;// SOBRESCRITO
// Hacemos esto para poder exportar los libros de iva que son dw composite

int resp

// S$$HEX1$$f300$$ENDHEX$$lo pediremos confirmaci$$HEX1$$f300$$ENDHEX$$n respecto al formato de exportaci$$HEX1$$f300$$ENDHEX$$n si se trata de un listado Composite
IF wf_composite_dw(dw_1) = 'S' THEN
	resp = MessageBox(g_titulo,"Este es un listado compuesto que se exportar$$HEX2$$e1002000$$ENDHEX$$conjuntamente, para continuar Pulse S$$HEX1$$ed00$$ENDHEX$$."+cr+ &
			"En caso que desee realizar la exportaci$$HEX1$$f300$$ENDHEX$$n por separado, Pulse No.",Exclamation!,YesNo!)
	if resp <> 1 then 
		DataWindowChild dw_cabecera, dw_resumen
		dw_1.GetChild('dw_cabecera',dw_cabecera)
		dw_1.GetChild('dw_resumen',dw_resumen)
		MessageBox(g_titulo,'Introduzca primero el nombre para la Cabecera, y en la segunda ventana introduzca el nombre para el Resumen.')
		dw_cabecera.Saveas()
		dw_resumen.Saveas()
	end if
END IF 

// Caso habitual de Exportaci$$HEX1$$f300$$ENDHEX$$n
IF (wf_composite_dw(dw_1) = 'N' OR (wf_composite_dw(dw_1) = 'S' ANd resp = 1) ) THEN
	dw_1.Saveas()
END IF

end event

type cb_escala from w_listados`cb_escala within w_facturacion_emitida_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_facturacion_emitida_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_facturacion_emitida_listados
integer y = 2204
integer height = 116
end type

type dw_1 from w_listados`dw_1 within w_facturacion_emitida_listados
integer width = 3602
integer height = 2148
end type

type aviso_recuperacion_t from statictext within w_facturacion_emitida_listados
boolean visible = false
integer x = 41
integer y = 2136
integer width = 2162
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
string text = "Recuperando informaci$$HEX1$$f300$$ENDHEX$$n. Este proceso puede tardar..."
boolean focusrectangle = false
end type

