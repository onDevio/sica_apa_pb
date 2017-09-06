HA$PBExportHeader$w_acreditaciones_listados.srw
forward
global type w_acreditaciones_listados from w_listados
end type
end forward

global type w_acreditaciones_listados from w_listados
integer width = 3707
string title = "Listados de Acreditaciones"
end type
global w_acreditaciones_listados w_acreditaciones_listados

on w_acreditaciones_listados.create
call super::create
end on

on w_acreditaciones_listados.destroy
call super::destroy
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

// Se desplaza el apuntador al primer registro
dw_listados_varios.scrolltorow(1)
dw_listados_varios.setfocus()

end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_acreditaciones_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_acreditaciones_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_acreditaciones_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_acreditaciones_listados
integer x = 2258
integer width = 1330
end type

type cb_ver from w_listados`cb_ver within w_acreditaciones_listados
end type

event cb_ver::clicked;call super::clicked;string sql, listado, ls_sql_aux
int i, indice
long   ll_on, ll_or, ll_vs, ll_ot, ll_ch


g_ultima_consulta = ''

dw_listados.accepttext()

dw_1.of_SetPrintPreview(TRUE)

// Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado
indice = dw_listados_varios.GetRow()

dw_1.of_SetTransObject(SQLCA)

if listado = 'd_plantilla_altas_colegiados' or listado = 'd_plantilla_bajas_colegiados' or listado = 'd_plantilla_bajas_habilitaciones' then
	dw_1.insertrow(0)
	
elseif listado = 'd_colegiados_listados_resumen_trabajo_mca' then
	DataWindowChild dwc_on,dwc_or
	integer rtncode,rtncod
	string sql_on,sql_or
	datetime  ldt_f_ini_d, ldt_f_ini_h, ldt_f_fin_d, ldt_f_fin_h
	
	ldt_f_ini_d = dw_listados.getitemdatetime(1,"f_inicio_desde")
	ldt_f_ini_h = dw_listados.getitemdatetime(1,"f_inicio_hasta")
	
	ldt_f_fin_d = dw_listados.getitemdatetime(1,"f_final_desde")
	ldt_f_fin_h = dw_listados.getitemdatetime(1,"f_final_hasta")
	
	
	rtncode = dw_1.GetChild("dw_on", dwc_on)
	IF rtncode = -1 THEN MessageBox("Error", "Not a DataWindowChild")
		dwc_on.SetTransObject(SQLCA)
		sql_on = dwc_on.describe("Datawindow.Table.Select")
			
		rtncod = dw_1.GetChild("dw_or", dwc_or)
		IF rtncod = -1 THEN MessageBox("Error", "Not a DataWindowChild")
			dwc_or.SetTransObject(SQLCA)
			sql_or = dwc_or.describe("Datawindow.Table.Select")
			
			//Visados
			if not isnull(ldt_f_ini_d) or not isnull(ldt_f_ini_h) then
				f_sql('fases.f_visado','>=','f_inicio_desde',dw_listados,sql_on,g_tipo_base_datos,'Fecha inicio Desde :')
				f_sql('fases.f_visado','<','f_inicio_hasta',dw_listados,sql_on,g_tipo_base_datos,'Fecha inicio Hasta :')
			end if
			
			if not isnull(ldt_f_fin_d) or not isnull(ldt_f_fin_h) then
				f_sql('fases.f_visado','>=','f_final_desde',dw_listados,sql_on,g_tipo_base_datos,'Fecha fin Desde :')
				f_sql('fases.f_visado','<','f_final_hasta',dw_listados,sql_on,g_tipo_base_datos,'Fecha fin Hasta :')
			end if
			
			if  not isnull(ldt_f_ini_d) and not isnull(ldt_f_ini_h) and not isnull(ldt_f_fin_d) and not isnull(ldt_f_fin_h) then
				f_sql('fases.f_visado','>=','f_inicio_desde',dw_listados,sql_on,g_tipo_base_datos,'Fecha inicio Desde :')
				f_sql('fases.f_visado','<','f_inicio_hasta',dw_listados,sql_on,g_tipo_base_datos,'Fecha inicio Hasta :')
			end if

			//Finales de Obra
			if not isnull(ldt_f_ini_d) or not isnull(ldt_f_ini_h) then
				f_sql('fases.f_visado','>=','f_inicio_desde',dw_listados,sql_or,g_tipo_base_datos,'Fecha inicio Desde :')
				f_sql('fases.f_visado','<','f_inicio_hasta',dw_listados,sql_or,g_tipo_base_datos,'Fecha inicio Hasta :')
			end if
			
			if not isnull(ldt_f_fin_d) or not isnull(ldt_f_fin_h) then
				f_sql('fases.f_visado','>=','f_final_desde',dw_listados,sql_or,g_tipo_base_datos,'Fecha fin Desde :')
				f_sql('fases.f_visado','<','f_final_hasta',dw_listados,sql_or,g_tipo_base_datos,'Fecha fin Hasta :')
			end if
			
			if  not isnull(ldt_f_ini_d) and not isnull(ldt_f_ini_h) and not isnull(ldt_f_fin_d) and not isnull(ldt_f_fin_h) then
				f_sql('fases.f_visado','>=','f_inicio_desde',dw_listados,sql_or,g_tipo_base_datos,'Fecha inicio Desde :')
				f_sql('fases.f_visado','<','f_inicio_hasta',dw_listados,sql_or,g_tipo_base_datos,'Fecha inicio Hasta :')
			end if
			
			dwc_on.SetTransobject(sqlca)
			dwc_or.SetTransobject(sqlca)
			/*Modify DW*/
			dwc_on.modify("datawindow.table.select= ~"" + sql_on+ "~"")
			dwc_or.modify("datawindow.table.select= ~"" + sql_or+ "~"")
			
			ll_on = dwc_on.retrieve()
			ll_or = dwc_or.retrieve()
			
	
else
	
	sql = dw_1.describe("datawindow.table.select")
	
	///*** Introducido por Alexis 22-07-2009.  	 ICTL-158 ****/
		ls_sql_aux =  ''
	///*** Fin introducido pro Alexis 22-07-2009 ****/
	// Creamos la sentencia SQL para poder coger los datos entre las fechas asignadas.
	
	// Fecha Inicio
	CHOOSE CASE g_colegio
		CASE 'COAATZ', 'COAATGC', 'COAATGU', 'COAATLE', 'COAATA', 'COAATNA',  'COAATTGN', 'COAATTER', 'COAATMCA', 'COAATLL'
			f_sql('fases.f_abono','>=','f_inicio_desde',Parent.dw_listados,sql,'1','Fecha Inicio')
			f_sql('fases.f_abono','<','f_inicio_hasta',Parent.dw_listados,sql,'1','Fecha Inicio')
		///*** Introducido por Alexis 22-07-2009, se quito COAATTEB de la opci$$HEX1$$f300$$ENDHEX$$n anterior.  ICTL-158 ****/
		CASE 'COAATTEB'
			f_sql('fases.f_abono','>=','f_inicio_desde',Parent.dw_listados,ls_sql_aux,'1','Fecha Inicio')
			f_sql('fases.f_abono','<','f_inicio_hasta',Parent.dw_listados,ls_sql_aux,'1','Fecha Inicio')
		///*** Fin introducido pro Alexis 22-07-2009  ***/
		CASE ELSE
			f_sql('fases.f_visado','>=','f_inicio_desde',Parent.dw_listados,sql,'1','Fecha Inicio')
			f_sql('fases.f_visado','<','f_inicio_hasta',Parent.dw_listados,sql,'1','Fecha Inicio')	
	END CHOOSE
	
	// Fecha Final
	CHOOSE CASE g_colegio
		CASE 'COAATGU', 'COAATLE', 'COAATNA', 'COAATMCA'
			f_sql('fases_minutas.fecha_pago','>=','f_final_desde',Parent.dw_listados,sql,'1','Fecha Final')
			f_sql('fases_minutas.fecha_pago','<','f_final_hasta',Parent.dw_listados,sql,'1','Fecha Final')
		CASE 'COAATA',  'COAATTGN', 'COAATLR','COAATLL'
			if PosA(listado, 'fin')>0 then			
				f_sql('fases_finales.f_intro','>=','f_final_desde',Parent.dw_listados,sql,'1','Fecha Final')
				f_sql('fases_finales.f_intro','<','f_final_hasta',Parent.dw_listados,sql,'1','Fecha Final')
			end if
		///*** Introducido por Alexis 22-07-2009. ICTL-158. Se quit$$HEX2$$f3002000$$ENDHEX$$COAATTEB de las DOS opciones. Estaba en las dos. ****/
		CASE 'COAATTEB'
			f_sql('fases_minutas.fecha_pago','>=','f_final_desde',Parent.dw_listados,ls_sql_aux,'1','Fecha Final')
			f_sql('fases_minutas.fecha_pago','<','f_final_hasta',Parent.dw_listados,ls_sql_aux,'1','Fecha Final')
			f_sql('fases_finales.f_intro','>=','f_final_desde',Parent.dw_listados,ls_sql_aux,'1','Fecha Final')
			f_sql('fases_finales.f_intro','<','f_final_hasta',Parent.dw_listados,ls_sql_aux,'1','Fecha Final')
		///*** Fin introducido pro Alexis 22-07-2009 ****/
		
		CASE ELSE
			f_sql('expedientes.f_cierre','>=','f_final_desde',Parent.dw_listados,sql,'1','Fecha Final')
			f_sql('expedientes.f_cierre','<','f_final_hasta',Parent.dw_listados,sql,'1','Fecha Final')
		END CHOOSE

	if g_colegio = 'COAATAVI' then
		dw_1.retrieve(dw_listados.getitemdatetime(1,'f_inicio_desde'), dw_listados.getitemdatetime(1,'f_inicio_hasta'))
	else
		///**** Cambios efectuados por Alexis 22/07/2009 especial para Terres, va a permitir mostrar las fases de ****/
		///**** colegiados funcionarios con fecha de entrada coincida con las fechas de inicio. ICTL-158  ****/		
		
		if g_colegio = 'COAATTEB' then
			ls_sql_aux = ls_sql_aux + " ) or ( fases_colegiados.facturado = 'S' "
			f_sql('fases.f_entrada','>=','f_inicio_desde',Parent.dw_listados,ls_sql_aux,'1','Fecha Inicio')
			f_sql('fases.f_entrada','<','f_inicio_hasta',Parent.dw_listados,ls_sql_aux,'1','Fecha Inicio')
			sql = sql + ' and (( ' + rightA(ls_sql_aux, lenA(ls_sql_aux) - 6) + '))'
		end if	
		///**** Fin modificado por Alexis (ICTL-158)  *****/
		dw_1.SetTransobject(sqlca)
		dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
		dw_1.retrieve()
	end if
end if


if dw_1.rowcount() > 0 then
	dw_1.sort()
	dw_1.visible 		  = true
	 if dw_1.Describe("DataWindow.Nested") = "no" and dw_1.describe("Datawindow.Label.Columns") = "0" then
		dw_1.event pfc_printpreview()
	end if	
//	dw_1.event pfc_printpreview()
	if dw_1.describe("t_parametros.name") = "t_parametros" then dw_1.object.t_parametros.text = g_ultima_consulta	
	this.enabled        = false
	cb_zoom.enabled     = true
	cb_imprimir.enabled = true
	cb_guardar.enabled  = true
	cb_escala.enabled  = true
	cb_ordenar.enabled  = true
else
	messagebox(g_titulo,'No se han encontrado registros segun las especificaciones.')
end if

end event

type cb_salir from w_listados`cb_salir within w_acreditaciones_listados
end type

type dw_listados from w_listados`dw_listados within w_acreditaciones_listados
integer y = 292
integer width = 1623
integer height = 516
string dataobject = "d_acreditaciones_consulta"
end type

event dw_listados::itemchanged;call super::itemchanged;datetime fi,ff

this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)


////Se comprueba que la fecha inicio sea anterior que la fecha final
//fi = this.GetItemDatetime(this.GetRow(),'f_inicio')
//ff = this.GetItemDatetime(this.GetRow(),'f_final')
//
//	if fi>ff then 
//		messagebox(g_titulo,'La fecha de inicio de la habilitaci$$HEX1$$f300$$ENDHEX$$m no puede ser anterior a la fecha final.')
//		return 1
//	end if	
//
end event

event dw_listados::constructor;call super::constructor;if g_colegio = 'COAATAVI' then
	this.object.f_final_desde.visible = false
	this.object.f_final_hasta.visible = false
	this.object.t_1.visible = false
	this.object.t_2.text = 'Fecha:'
end if
end event

type cb_imprimir from w_listados`cb_imprimir within w_acreditaciones_listados
end type

type cb_zoom from w_listados`cb_zoom within w_acreditaciones_listados
end type

type cb_esp from w_listados`cb_esp within w_acreditaciones_listados
end type

type cb_guardar from w_listados`cb_guardar within w_acreditaciones_listados
end type

type cb_escala from w_listados`cb_escala within w_acreditaciones_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_acreditaciones_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_acreditaciones_listados
end type

type dw_1 from w_listados`dw_1 within w_acreditaciones_listados
end type

