HA$PBExportHeader$w_siniestros_consulta.srw
forward
global type w_siniestros_consulta from w_consulta
end type
end forward

global type w_siniestros_consulta from w_consulta
integer x = 214
integer y = 221
integer width = 2697
integer height = 1712
string title = "Consulta de Siniestros"
end type
global w_siniestros_consulta w_siniestros_consulta

on w_siniestros_consulta.create
call super::create
end on

on w_siniestros_consulta.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_siniestros_consulta
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_siniestros_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_siniestros_consulta
end type

type st_5 from w_consulta`st_5 within w_siniestros_consulta
integer x = 73
end type

type cb_1 from w_consulta`cb_1 within w_siniestros_consulta
integer x = 352
integer y = 1476
end type

event cb_1::clicked;call super::clicked;//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo

SetPointer(HourGlass!)
sql_nuevo = g_dw_lista.describe("datawindow.table.select")
//De la tabla fases debemos comprobar : n_expedi,n_registro
f_sql('fases.n_expedi','LIKE','n_expediente',dw_1,sql_nuevo,'1','')
f_sql('fases.n_registro','LIKE','n_registro',dw_1,sql_nuevo,'1','')
f_sql('fases.emplazamiento','LIKE','emplazamiento_obra',dw_1,sql_nuevo,'1','')

//De la tabla fases_siniestros debemos comprobar los parametros de la consulta
f_sql('fases_siniestros.n_interno','LIKE','n_siniestro',dw_1,sql_nuevo,'1','')
f_sql('fases_siniestros.n_musaat','LIKE','n_siniestro_musaat',dw_1,sql_nuevo,'1','')
f_sql('fases_siniestros.constructor','LIKE','nombre_constructor',dw_1,sql_nuevo,'1','')
f_sql('fases_siniestros.fecha','>=','fecha_registro_desde',dw_1,sql_nuevo,'1','')
f_sql('fases_siniestros.fecha','<','fecha_registro_hasta',dw_1,sql_nuevo,'1','')

f_sql('fases_siniestros.fecha_siniestro','>=','fecha_siniestro_desde',dw_1,sql_nuevo,'1','')
f_sql('fases_siniestros.fecha_siniestro','<','fecha_siniestro_hasta',dw_1,sql_nuevo,'1','')

f_sql('fases_siniestros.fecha_cierre','>=','fecha_cierre_desde',dw_1,sql_nuevo,'1','')
f_sql('fases_siniestros.fecha_cierre','<','fecha_cierre_hasta',dw_1,sql_nuevo,'1','')

f_sql('fases_siniestros.tipo_danyos','LIKE','tipo_danyos',dw_1,sql_nuevo,'1','')
f_sql('fases_siniestros.tipo_estado_obra','LIKE','tipo_estado_obra',dw_1,sql_nuevo,'1','')
f_sql('fases_siniestros.importe_danyos','>=','importe_desde',dw_1,sql_nuevo,'1','')
f_sql('fases_siniestros.importe_danyos','<','importe_hasta',dw_1,sql_nuevo,'1','')

f_sql('fases_siniestros.fecha_siniestro','>=','fecha_siniestro_desde',dw_1,sql_nuevo,'1','')
f_sql('fases_siniestros.fecha_siniestro','<','fecha_siniestro_hasta',dw_1,sql_nuevo,'1','')

f_sql('fases_siniestros.autos','LIKE','autos',dw_1,sql_nuevo,'1','')
f_sql('fases_siniestros.juzgado','LIKE','juzgado',dw_1,sql_nuevo,'1','')

f_sql('fases_siniestros.promotor','LIKE','nombre_promotor',dw_1,sql_nuevo,'1','')
f_sql('fases_siniestros.procurador','LIKE','procurador',dw_1,sql_nuevo,'1','')

if (not f_es_vacio(dw_1.getitemstring(1, 'n_colegiado')) OR not f_es_vacio(dw_1.getitemstring(1, 'src_cia')) )  then
	sql_nuevo = f_sql_join(sql_nuevo, {'( fases_siniestros.id_siniestro = fases_siniestros_coles.id_siniestro )'})
	if not f_es_vacio(dw_1.getitemstring(1, 'n_colegiado')) then f_sql('fases_siniestros_coles.id_colegiado','=','id_col',dw_1,sql_nuevo,'1','')
	if not f_es_vacio(dw_1.getitemstring(1, 'src_cia')) then
		f_sql('fases_siniestros_coles.src_cia','=','src_cia',dw_1,sql_nuevo,'1','')
		if f_es_vacio(dw_1.getitemstring(1, 'n_colegiado')) then sql_nuevo = Replace (sql_nuevo,1,7,'SELECT DISTINCT ')
	end if
end if

// Modificado Ricardo 15-10-03
// En el caso de haber introducido alguno de los par$$HEX1$$e100$$ENDHEX$$metros que tiran de fase, hay que quitar
// el auterjoin para que la consulta sea correcta
if not f_es_vacio(dw_1.getitemstring(1, 'n_expediente')) or &
	not f_es_vacio(dw_1.getitemstring(1, 'n_registro')) or &
	not f_es_vacio(dw_1.getitemstring(1, 'emplazamiento_obra')) then
	// Quitamos el auter join
	sql_nuevo = f_reemplaza_cadena(sql_nuevo, "fases.id_fase =* fases_siniestros.id_fase", "fases.id_fase = fases_siniestros.id_fase")
end if

g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")

//messagebox('', sql_nuevo)

Parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_siniestros_consulta
integer x = 1787
integer y = 1476
end type

type cb_ayuda from w_consulta`cb_ayuda within w_siniestros_consulta
end type

type dw_1 from w_consulta`dw_1 within w_siniestros_consulta
integer x = 14
integer y = 104
integer width = 2651
integer height = 1304
string dataobject = "d_siniestros_consulta"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event dw_1::buttonclicked;call super::buttonclicked;string id_col,n_col,desc_pob
string pob

choose case dwo.name
	case "b_busca_colegiado"
  		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()   
		if NOT f_es_vacio(id_col)  then
			this.setitem(1,'n_colegiado',f_colegiado_n_col(id_col))
			this.setitem(1,'nombre_apellidos_colegiado',f_nombre_colegiado(id_col))
		end if
		this.setitem(1,'id_col',id_col)		
	CASE 'b_busca_poblacion'
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		desc_pob=f_dame_poblacion(pob)
		if f_es_vacio(pob) then return
		if f_es_vacio(desc_pob) then return
		this.SetItem(1,'poblacion',pob)
		this.SetItem(1,'desc_poblacion',desc_pob)
END CHOOSE
end event

event dw_1::itemchanged;call super::itemchanged;choose case dwo.name
	case "n_colegiado"
		this.setitem(1,'nombre_apellidos_colegiado',f_nombre_colegiado(f_colegiado_id_col(data)))
		this.setitem(1,'id_col',f_colegiado_id_col(data))
		
	CASE "poblacion"
		this.setitem(1,'desc_poblacion',f_poblacion_descripcion(data))
END CHOOSE
end event

