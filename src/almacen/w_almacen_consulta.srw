HA$PBExportHeader$w_almacen_consulta.srw
forward
global type w_almacen_consulta from w_consulta
end type
end forward

global type w_almacen_consulta from w_consulta
integer width = 1947
integer height = 1756
string title = "Consulta de Almac$$HEX1$$e900$$ENDHEX$$n"
end type
global w_almacen_consulta w_almacen_consulta

on w_almacen_consulta.create
call super::create
end on

on w_almacen_consulta.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_almacen_consulta
integer y = 1288
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_almacen_consulta
integer y = 1160
end type

type cb_limpiar from w_consulta`cb_limpiar within w_almacen_consulta
integer y = 1088
end type

type st_5 from w_consulta`st_5 within w_almacen_consulta
end type

type cb_1 from w_consulta`cb_1 within w_almacen_consulta
integer x = 357
integer y = 1432
end type

event cb_1::clicked;call super::clicked;string sql_nuevo
datetime pd, ph

sql_nuevo=g_dw_lista.describe("datawindow.table.select")

dw_1.AcceptText()

f_sql('tipo_almacen','LIKE','tipo',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('cod_almacen','LIKE','cod_almacen',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('ub_pasillo','LIKE','pasillo',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('num_contenedor','LIKE','contenedor',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('ub_profundidad','LIKE','profundidad',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('ub_celda','LIKE','celda',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
///*** Se a$$HEX1$$f100$$ENDHEX$$ade tratamiento para el campo anulada. Alexis 11-09-2009 ***///
f_sql('anulada','LIKE','anulada',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')

//f_sql('aparatos_tecnicos.prestable','LIKE','prestable',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
//f_sql('aparatos_tecnicos.f_entrada','>=','f_entrada_desde',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
//f_sql('aparatos_tecnicos.f_entrada','<','f_entrada_hasta',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
//
//// Pr$$HEX1$$e900$$ENDHEX$$stamos
//pd = dw_1.getitemdatetime(1, 'fecha_desde')
f_sql('fecha_desde','<=','fecha_desde',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha_hasta','>=','fecha_desde',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')

//if not f_es_vacio(string(pd)) then
//	if pos(upper(sql_nuevo),'WHERE') > 0 then
//		sql_nuevo=sql_nuevo + " and id_almacen in ( select id_almacen from almacen where fecha_desde <= '" + string(pd,'dd/mm/yyyy') + "' and fecha_hasta >= '" + string(pd) + "')"
//	else
//		sql_nuevo=sql_nuevo + "WHERE id_almacen in ( select id_almacen from almacen where  fecha_desde <= '" + string(pd,'dd/mm/yyyy') + "' and fecha_hasta >= '" + string(pd) + "')"
//	end if
//end if
//ph = dw_1.getitemdatetime(1, 'fecha_hasta')
//
//if not f_es_vacio(string(pd)) and  f_es_vacio(string(ph)) then
//f_sql('fecha_desde','>=','fecha_desde',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
//end if
//if  f_es_vacio(string(pd)) and  not f_es_vacio(string(ph)) then
//f_sql('fecha_hasta','<','fecha_hasta',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
//end if
//if not f_es_vacio(string(pd)) and  not f_es_vacio(string(ph)) then
//f_sql('fecha_desde','>=','fecha_desde',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
//f_sql('fecha_hasta','<','fecha_hasta',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
//end if
//	f_sql('prestamos.f_prestamo','<','f_prestamo_hasta',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
//end if
string nvisado
nvisado=dw_1.getitemstring(1,'visado')
if not f_es_vacio(nvisado) then
	if PosA(upper(sql_nuevo),'WHERE') > 0 then
		sql_nuevo=sql_nuevo + " and id_almacen in ( select id_almacen from almacen_visados,fases where fases.archivo='" +nvisado + "' and fases.id_fase=almacen_visados.id_fase)"
	else
		sql_nuevo=sql_nuevo + "WHERE id_almacen in ( select id_almacen from almacen_visados,fases where fases.archivo ='" +nvisado + "' and fases.id_fase=almacen_visados.id_fase)"
	end if
end if
//MessageBox('',sql_nuevo)
g_dw_lista.modify("Datawindow.table.select=~"" + sql_nuevo + "~"")

parent.event pfc_close()
end event

type cb_2 from w_consulta`cb_2 within w_almacen_consulta
integer x = 978
integer y = 1432
end type

type cb_ayuda from w_consulta`cb_ayuda within w_almacen_consulta
integer y = 1088
end type

type dw_1 from w_consulta`dw_1 within w_almacen_consulta
integer x = 69
integer y = 224
integer width = 1810
integer height = 984
string dataobject = "d_almacen_consulta"
end type

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

