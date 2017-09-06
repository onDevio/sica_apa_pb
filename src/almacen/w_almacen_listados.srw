HA$PBExportHeader$w_almacen_listados.srw
forward
global type w_almacen_listados from w_listados
end type
end forward

global type w_almacen_listados from w_listados
end type
global w_almacen_listados w_almacen_listados

on w_almacen_listados.create
call super::create
end on

on w_almacen_listados.destroy
call super::destroy
end on

event open;call super::open;//Para relacionar los registros que se encuentran en la tabla de listados
dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)
end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_almacen_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_almacen_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_almacen_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_almacen_listados
end type

type cb_ver from w_listados`cb_ver within w_almacen_listados
end type

event cb_ver::clicked;call super::clicked;string sql_nuevo,sql,listado
datetime pd, ph

sql_nuevo=g_dw_lista.describe("datawindow.table.select")

dw_1.of_SetPrintPreview(TRUE)
dw_listados.AcceptText()
//Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado

dw_1.of_settransobject(sqlca)
sql_nuevo = dw_1.describe("Datawindow.Table.Select")
g_ultima_consulta=''
f_sql('almacen.tipo_almacen','LIKE','tipo',parent.dw_listados,sql_nuevo,g_tipo_base_datos,'Tipo Almac$$HEX1$$e900$$ENDHEX$$n: ')
f_sql('almacen.cod_almacen','LIKE','cod_almacen',parent.dw_listados,sql_nuevo,g_tipo_base_datos,'C$$HEX1$$f300$$ENDHEX$$digo Almac$$HEX1$$e900$$ENDHEX$$n: ')
f_sql('almacen.ub_pasillo','LIKE','pasillo',parent.dw_listados,sql_nuevo,g_tipo_base_datos,'Pasillo: ')
f_sql('almacen.num_contenedor','LIKE','contenedor',parent.dw_listados,sql_nuevo,g_tipo_base_datos,'Contenedor: ')
f_sql('almacen.ub_profundidad','LIKE','profundidad',parent.dw_listados,sql_nuevo,g_tipo_base_datos,'Profuncidad: ')
f_sql('almacen.ub_celda','LIKE','celda',parent.dw_listados,sql_nuevo,g_tipo_base_datos,'Celda: ')
f_sql('fecha_desde','<=','fecha_desde',parent.dw_listados,sql_nuevo,g_tipo_base_datos,'Fecha Desde: ')
f_sql('fecha_hasta','>=','fecha_desde',parent.dw_listados,sql_nuevo,g_tipo_base_datos,'Fecha Hasta: ')
///*** Se a$$HEX1$$f100$$ENDHEX$$ade tratamiento para el campo anulada. Alexis 11-09-2009 ***///
//Corregido Luis CAL-224
f_sql('anulada','LIKE','anulada',parent.dw_listados,sql_nuevo,g_tipo_base_datos,'')


string nvisado
nvisado=dw_listados.getitemstring(1,'visado')
if not f_es_vacio(nvisado) then
	if PosA(upper(sql_nuevo),'WHERE') > 0 then
		sql_nuevo=sql_nuevo + " and almacen.id_almacen in ( select id_almacen from almacen_visados,fases where fases.archivo='" +nvisado + "' and fases.id_fase=almacen_visados.id_fase)"
	else
		sql_nuevo=sql_nuevo + "WHERE almacen.id_almacen in ( select id_almacen from almacen_visados,fases where fases.archivo ='" +nvisado + "' and fases.id_fase=almacen_visados.id_fase)"
	end if
end if

dw_1.SetTransobject(sqlca)
dw_1.modify("datawindow.table.select= ~"" + sql_nuevo+ "~"")

dw_1.retrieve()

//Al final:
if dw_1.RowCount() > 0 then
	dw_1.event pfc_printpreview()
	dw_1.visible = true
	this.enabled = false
	cb_zoom.enabled = true
	cb_imprimir.enabled = true
	cb_guardar.enabled = true
	cb_escala.enabled  = true
	cb_ordenar.enabled=true
	if dw_1.describe("t_parametros.name") = "t_parametros" then dw_1.object.t_parametros.text = g_ultima_consulta
else
	messagebox(g_titulo,'No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.')
end if	

end event

type cb_salir from w_listados`cb_salir within w_almacen_listados
end type

type dw_listados from w_listados`dw_listados within w_almacen_listados
string dataobject = "d_almacen_consulta"
boolean ib_isupdateable = false
end type

type cb_imprimir from w_listados`cb_imprimir within w_almacen_listados
end type

type cb_zoom from w_listados`cb_zoom within w_almacen_listados
end type

type cb_esp from w_listados`cb_esp within w_almacen_listados
end type

type cb_guardar from w_listados`cb_guardar within w_almacen_listados
end type

type cb_escala from w_listados`cb_escala within w_almacen_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_almacen_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_almacen_listados
end type

type dw_1 from w_listados`dw_1 within w_almacen_listados
boolean ib_isupdateable = false
end type

