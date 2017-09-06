HA$PBExportHeader$w_caja_salidas_listados.srw
forward
global type w_caja_salidas_listados from w_listados
end type
end forward

global type w_caja_salidas_listados from w_listados
integer width = 3694
integer height = 1852
end type
global w_caja_salidas_listados w_caja_salidas_listados

on w_caja_salidas_listados.create
call super::create
end on

on w_caja_salidas_listados.destroy
call super::destroy
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

// Se desplaza el apuntador al primer registro
dw_listados_varios.scrolltorow(1)
dw_listados_varios.setfocus()

dw_listados.SetItem(1,'f_desde',datetime(today()))
dw_listados.SetItem(1,'f_hasta',datetime(today()))
dw_listados.SetItem(1,'centro',f_devuelve_centro(g_cod_delegacion))
end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_caja_salidas_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_caja_salidas_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_caja_salidas_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_caja_salidas_listados
end type

type cb_ver from w_listados`cb_ver within w_caja_salidas_listados
end type

event cb_ver::clicked;call super::clicked;datetime f_desde,f_hasta
string centro
string listado,sql,sql_nuevo

dw_listados.Accepttext()
dw_1.of_SetPrintPreview(TRUE)

//Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado

dw_1.of_settransobject(sqlca)
centro=dw_listados.GetItemString(1,'centro')
f_desde=datetime(date(dw_listados.GetItemDateTime(1,'f_desde')), time('00:00:00'))
f_hasta=datetime(date(dw_listados.GetItemDateTime(1,'f_hasta')), time('23:59:59'))


if listado= 'd_caja_salidas_list_cuadre'	then
	
		dw_1.Retrieve(f_desde,f_hasta,centro,g_empresa)
		
		Datawindowchild dwc_fact_visados,dwc_fact_no_visados,dwc_ing_ret,dwc_salidas,dwc_saldo,dwc_retiradas
		
		dw_1.GetChild('dw_facturas_visados',dwc_fact_visados)		
		dw_1.GetChild('dw_facturas_no_visados',dwc_fact_no_visados)
		dw_1.GetChild('dw_ingresa_retira',dwc_ing_ret)
		dw_1.GetChild('dw_salidas',dwc_salidas)
		dw_1.GetChild('dw_saldo',dwc_saldo)
		dw_1.GetChild('dw_retiradas',dwc_retiradas)
				
		double ent,sal,iva,irpf
		
		ent = 0
		sal = 0
		iva = 0
		irpf = 0
		
		if dwc_fact_visados.RowCount() > 0 then
			ent += dwc_fact_visados.GetItemNumber(dwc_fact_visados.RowCount(),'totalizado_total')
			iva += dwc_fact_visados.GetItemNumber(dwc_fact_visados.RowCount(),'totalizado_iva')
			irpf += dwc_fact_visados.GetItemNumber(dwc_fact_visados.RowCount(),'totalizado_irpf')
		end if
		
		if dwc_fact_no_visados.RowCount() > 0 then
			ent += dwc_fact_no_visados.GetItemNumber(dwc_fact_no_visados.RowCount(),'totalizado_total')
			iva += dwc_fact_no_visados.GetItemNumber(dwc_fact_no_visados.RowCount(),'totalizado_iva')
			irpf += dwc_fact_no_visados.GetItemNumber(dwc_fact_no_visados.RowCount(),'totalizado_irpf')
		end if
		
		if dwc_ing_ret.RowCount() > 0 then
			ent += dwc_ing_ret.GetItemNumber(dwc_ing_ret.RowCount(),'totalizado_base_imponible')
		end if
		
		if dwc_retiradas.RowCount() > 0 then
			sal += dwc_retiradas.GetItemNumber(dwc_retiradas.RowCount(),'totalizado_base_imponible')
		end if
		
		if dwc_salidas.RowCount() > 0 then
			sal += dwc_salidas.GetItemNumber(dwc_salidas.RowCount(),'totalizado_importe')
		end if
		
		
		
		dwc_saldo.InsertRow(0)
		dwc_saldo.SetItem(1,'saldo_entradas',ent)
		dwc_saldo.SetItem(1,'saldo_salidas',sal)
		dwc_saldo.SetItem(1,'saldo_iva',iva)
		dwc_saldo.SetItem(1,'saldo_irpf',irpf)
		
		dw_1.visible = true
		// No se puede hacer un printpreview de un composite
		if dw_1.Describe("DataWindow.Nested") = "no" then dw_1.event pfc_printpreview()
		this.enabled = false
		cb_zoom.enabled = true
		cb_imprimir.enabled = true
		cb_guardar.enabled = true
		cb_escala.enabled  = true
		cb_ordenar.enabled  = true
		// Devuelvo el estado normal
		setpointer(arrow!)

else
	sql = dw_1.describe("Datawindow.Table.Select")
	sql_nuevo=sql
	f_sql('caja_salidas.fecha','>=','f_desde',Parent.dw_listados,sql_nuevo,g_tipo_base_datos,'')
	f_sql('caja_salidas.fecha','<','f_hasta',Parent.dw_listados,sql_nuevo,g_tipo_base_datos,'')
	f_sql('caja_salidas.centro','=','centro',Parent.dw_listados,sql_nuevo,g_tipo_base_datos,'')
	
if Pos(Upper(sql_nuevo), "WHERE") > 0 then 
	sql_nuevo = sql_nuevo + " and caja_salidas.empresa = '"+ g_empresa +"' "
else
	sql_nuevo = sql_nuevo + " where caja_salidas.empresa = '"+ g_empresa +"' "
end if 
	
	dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")	
	dw_1.retrieve()
	if dw_1.rowcount()>0 then
		dw_1.visible = true
		// No se puede hacer un printpreview de un composite
		if dw_1.Describe("DataWindow.Nested") = "no" then dw_1.event pfc_printpreview()
		this.enabled = false
		cb_zoom.enabled = true
		cb_imprimir.enabled = true
		cb_guardar.enabled = true
		cb_escala.enabled  = true
		cb_ordenar.enabled  = true
		// Devuelvo el estado normal
		setpointer(arrow!)
	else
		// Devuelvo el estado normal
		setpointer(arrow!)
		messagebox(g_titulo,'No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.')
	end if	
	dw_1.modify("datawindow.table.select= ~"" + sql + "~"")	
	
end if
		

end event

type cb_salir from w_listados`cb_salir within w_caja_salidas_listados
end type

type dw_listados from w_listados`dw_listados within w_caja_salidas_listados
integer height = 368
string dataobject = "d_caja_salidas_listados_consulta"
end type

type cb_imprimir from w_listados`cb_imprimir within w_caja_salidas_listados
end type

type cb_zoom from w_listados`cb_zoom within w_caja_salidas_listados
end type

type cb_esp from w_listados`cb_esp within w_caja_salidas_listados
end type

type cb_guardar from w_listados`cb_guardar within w_caja_salidas_listados
end type

type cb_escala from w_listados`cb_escala within w_caja_salidas_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_caja_salidas_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_caja_salidas_listados
end type

type dw_1 from w_listados`dw_1 within w_caja_salidas_listados
end type

