HA$PBExportHeader$w_final_obra_listados.srw
forward
global type w_final_obra_listados from w_listados
end type
end forward

global type w_final_obra_listados from w_listados
integer width = 3694
integer height = 1748
string title = "Listados de Finales de Obra"
end type
global w_final_obra_listados w_final_obra_listados

on w_final_obra_listados.create
call super::create
end on

on w_final_obra_listados.destroy
call super::destroy
end on

event open;call super::open;//Para relacionar los registros que se encuentran en la tabla de listados
dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_final_obra_listados
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_final_obra_listados
string tag = "texto=general.guardar_pantalla"
end type

type cb_limpiar from w_listados`cb_limpiar within w_final_obra_listados
string tag = "texto=general.limpiar_consulta"
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_final_obra_listados
integer x = 2304
integer y = 164
end type

type cb_ver from w_listados`cb_ver within w_final_obra_listados
end type

event cb_ver::clicked;DataWindowChild dwc_lista,dwc_resumen
string sql,sql_r
string listado, descripcion
integer rtncode,rtncod
datetime f_intro_desde,f_intro_hasta
dw_listados.Accepttext()
dw_1.of_SetPrintPreview(TRUE)

//Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
descripcion = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'descripcion')
dw_1.dataobject = listado
dw_1.of_settransobject(sqlca)

sql = dw_1.describe("Datawindow.Table.Select")

CHOOSE CASE upper(listado)
	CASE  upper('d_final_obra_general_listados'), upper('d_final_obra_listados_mca'), upper('d_final_obra_listado_laboratorio_mca')
		if upper(listado) = upper('d_final_obra_listado_laboratorio_mca') then
			rtncode = dw_1.GetChild("dw_1", dwc_lista)
			IF rtncode = -1 THEN MessageBox("Error", "Not a DataWindowChild")
			dwc_lista.SetTransObject(SQLCA)
			
			rtncod = dw_1.GetChild("dw_2", dwc_resumen)
			IF rtncod = -1 THEN MessageBox("Error", "Not a DataWindowChild")
			dwc_resumen.SetTransObject(SQLCA)
			//sql_r = dwc_resumen.describe("Datawindow.Table.Select")
			
			sql = dwc_lista.describe("Datawindow.Table.Select")
			
			f_sql('fases.n_expedi','LIKE','n_expedi',dw_listados,sql,'1','')
			f_sql('fases.n_registro','LIKE','n_registro',dw_listados,sql,'1','')
			f_sql('fases.archivo','LIKE','archivo',dw_listados,sql,'1','')
			
			//De la tabla fases_finales debemos comprobar los parametros de la consulta
			f_sql('fases_finales.total_parcial','LIKE','total_parcial',dw_listados,sql,'1','')
			
			f_sql('fases_finales.fecha','>=','fecha_desde',dw_listados,sql,'1','')
			f_sql('fases_finales.fecha','<','fecha_hasta',dw_listados,sql,'1','')
			
			f_sql('fases_finales.f_intro','>=','f_intro_desde',dw_listados,sql,'1','')
			f_sql('fases_finales.f_intro','<','f_intro_hasta',dw_listados,sql,'1','')
			
			f_sql('fases_finales.presupuesto','>=','presupuesto_desde',dw_listados,sql,'1','')
			f_sql('fases_finales.presupuesto','<','presupuesto_hasta',dw_listados,sql,'1','')
			
			f_sql('fases_finales.num_viv','=','num_viv',dw_listados,sql,'1','')
			f_sql('fases_finales.num_edif','=','num_edif',dw_listados,sql,'1','')
			
			f_sql('fases_finales.sup_viv','=','sup_viv',dw_listados,sql,'1','')
			f_sql('fases_finales.sup_otros','=','sup_otros',dw_listados,sql,'1','')
			
			f_sql('fases_finales.sup_garage','=','sup_garage',dw_listados,sql,'1','')
			f_sql('fases_finales.descripcion','LIKE','descripcion',dw_listados,sql,'1','')
			if g_colegio='COAATMCA' then
				f_sql('fases_finales.f_visado','>=','f_visado_d',dw_listados,sql,'1','')
				f_sql('fases_finales.f_visado','<','f_visado_h',dw_listados,sql,'1','')
			else
				f_sql('fases.f_visado','>=','f_visado_d',dw_listados,sql,'1','')
				f_sql('fases.f_visado','<','f_visado_h',dw_listados,sql,'1','')
			end if				
			
			dwc_lista.SetTransobject(sqlca)
			dwc_lista.modify("datawindow.table.select= ~"" + sql+ "~"")
			dwc_resumen.SetTransobject(sqlca)
			dwc_resumen.modify("datawindow.table.select= ~"" + sql+ "~"")
			dwc_lista.retrieve()
			dwc_resumen.retrieve()	
			
			//Al final:
			if dwc_lista.RowCount() > 0 then
				///dw_1.dynamic event pfc_printpreview()
				dw_1.visible = true
				this.enabled = false
				cb_zoom.enabled = true
				cb_imprimir.enabled = true
				cb_guardar.enabled = true
				cb_escala.enabled  = true
				cb_ordenar.enabled  = true
			else
				messagebox(g_titulo,g_idioma.of_getmsg('msg_final_obra.no_registros_especificaciones','No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.'))
			end if	
		
		else			
			//De la tabla fases debemos comprobar : n_expedi,n_registro
			f_sql('fases.n_expedi','LIKE','n_expedi',dw_listados,sql,'1','')
			f_sql('fases.n_registro','LIKE','n_registro',dw_listados,sql,'1','')
			f_sql('fases.archivo','LIKE','archivo',dw_listados,sql,'1','')
			
			//De la tabla fases_finales debemos comprobar los parametros de la consulta
			f_sql('fases_finales.total_parcial','LIKE','total_parcial',dw_listados,sql,'1','')
			
			f_sql('fases_finales.fecha','>=','fecha_desde',dw_listados,sql,'1','')
			f_sql('fases_finales.fecha','<','fecha_hasta',dw_listados,sql,'1','')
			
			f_sql('fases_finales.f_intro','>=','f_intro_desde',dw_listados,sql,'1','')
			f_sql('fases_finales.f_intro','<','f_intro_hasta',dw_listados,sql,'1','')
			
			f_sql('fases_finales.presupuesto','>=','presupuesto_desde',dw_listados,sql,'1','')
			f_sql('fases_finales.presupuesto','<','presupuesto_hasta',dw_listados,sql,'1','')
			
			f_sql('fases_finales.num_viv','=','num_viv',dw_listados,sql,'1','')
			f_sql('fases_finales.num_edif','=','num_edif',dw_listados,sql,'1','')
			
			f_sql('fases_finales.sup_viv','=','sup_viv',dw_listados,sql,'1','')
			f_sql('fases_finales.sup_otros','=','sup_otros',dw_listados,sql,'1','')
			
			f_sql('fases_finales.sup_garage','=','sup_garage',dw_listados,sql,'1','')
			f_sql('fases_finales.descripcion','LIKE','descripcion',dw_listados,sql,'1','')
			
			if g_colegio='COAATMCA' then
				f_sql('fases_finales.f_visado','>=','f_visado_d',dw_listados,sql,'1','')
				f_sql('fases_finales.f_visado','<','f_visado_h',dw_listados,sql,'1','')	
			else
				f_sql('fases.f_visado','>=','f_visado_d',dw_listados,sql,'1','')
				f_sql('fases.f_visado','<','f_visado_h',dw_listados,sql,'1','')	
			end if		
		
			dw_1.SetTransobject(sqlca)
			dw_1.modify("datawindow.table.select= ~"" + sql+ "~"")			
			dw_1.retrieve()
			
			//Al final:
			long rows
			rows = dw_1.RowCount()
			if dw_1.RowCount() > 0 then
				dw_1.dynamic event pfc_printpreview()
				dw_1.visible = true
				this.enabled = false
				cb_zoom.enabled = true
				cb_imprimir.enabled = true
				cb_guardar.enabled = true
				cb_escala.enabled  = true
				cb_ordenar.enabled  = true
			else
				messagebox(g_titulo,g_idioma.of_getmsg('msg_final_obra.no_registros_especificaciones','No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.'))
			end if	
		
		end if		
END CHOOSE



end event

type cb_salir from w_listados`cb_salir within w_final_obra_listados
end type

type dw_listados from w_listados`dw_listados within w_final_obra_listados
integer y = 188
integer width = 1746
integer height = 1052
string title = "LISTADOS DE FINALES DE OBRA"
string dataobject = "d_final_obra_consulta"
end type

event dw_listados::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event dw_listados::buttonclicked;call super::buttonclicked;string id_fase, ls_n_visado, pob,ls_poblacion

CHOOSE CASE dwo.name
	case 'b_busqueda_fase'
		//Buscamos las fases
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida"
		g_busqueda.dw="d_lista_busqueda_fases"
		id_fase=f_busqueda_fases()  
		if NOT f_es_vacio(id_fase) then
			//Ponemos para que se visualize el valor del expediente y del registro
			this.setitem(1,'n_registro',f_dame_n_reg(id_fase))	
			this.setitem(1,'n_expedi',f_dame_exp(id_fase))	
			this.setitem(1,'archivo',f_dame_n_visado(id_fase))	
		end if 

		
	CASE 'b_poblacion'
		
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		ls_poblacion = f_poblacion_descripcion_contrato( pob )
		this.SetItem(row,'poblacion',ls_poblacion)

END CHOOSE



end event

type cb_imprimir from w_listados`cb_imprimir within w_final_obra_listados
end type

type cb_zoom from w_listados`cb_zoom within w_final_obra_listados
end type

type cb_esp from w_listados`cb_esp within w_final_obra_listados
end type

type cb_guardar from w_listados`cb_guardar within w_final_obra_listados
end type

type cb_escala from w_listados`cb_escala within w_final_obra_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_final_obra_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_final_obra_listados
end type

type dw_1 from w_listados`dw_1 within w_final_obra_listados
integer width = 3593
end type

