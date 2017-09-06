HA$PBExportHeader$w_consejo_estadillo.srw
forward
global type w_consejo_estadillo from w_listados
end type
end forward

global type w_consejo_estadillo from w_listados
integer width = 3726
string title = "Listados del Estadillo del Consejo"
end type
global w_consejo_estadillo w_consejo_estadillo

on w_consejo_estadillo.create
call super::create
end on

on w_consejo_estadillo.destroy
call super::destroy
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

// Se desplaza el apuntador al primer registro
dw_listados_varios.scrolltorow(1)
dw_listados_varios.setfocus()

end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_consejo_estadillo
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_consejo_estadillo
end type

type cb_limpiar from w_listados`cb_limpiar within w_consejo_estadillo
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_consejo_estadillo
end type

type cb_ver from w_listados`cb_ver within w_consejo_estadillo
event antiguo ( )
end type

event cb_ver::antiguo();//string sql, listado
//int i, indice
//datetime f_desde, f_hasta
//int total_fin,total_anterior,residentes,no_residentes
//int mes
//
//
//dw_listados.accepttext()
//
//f_desde = dw_listados.getitemdatetime(1, 'f_desde')
//f_hasta = dw_listados.getitemdatetime(1, 'f_hasta')
//f_hasta = datetime(relativedate(date(f_hasta), 1))
//
//dw_1.of_SetPrintPreview(TRUE)
//
//// Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
//listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
//dw_1.dataobject = listado
//indice = dw_listados_varios.GetRow()
//
//dw_1.of_SetTransObject(SQLCA)
//sql = dw_1.describe("datawindow.table.select")
//
////Creamos la sentencia SQL para poder coger los datos entre las fechas asignadas.
//if listado = 'd_estadillo_consejo_altas' then
//	f_sql('colegiados.f_alta','>=','f_desde',Parent.dw_listados,sql,'1','Fecha Desde')
//	f_sql('colegiados.f_alta','<','f_hasta',Parent.dw_listados,sql,'1','Fecha Hasta')
//end if
//
////if listado = 'd_consejo_estadillo_totales' then
////	f_sql('altas_bajas_situaciones.fecha','>=','f_desde',Parent.dw_listados,sql,'1','Fecha Desde')
////	f_sql('altas_bajas_situaciones.fecha','<','f_hasta',Parent.dw_listados,sql,'1','Fecha Hasta')
////end if
//
//if listado = 'd_estadillo_consejo_bajas' then
//	f_sql('colegiados.f_baja','>=','f_desde',Parent.dw_listados,sql,'1','Fecha Desde')
//	f_sql('colegiados.f_baja','<','f_hasta',Parent.dw_listados,sql,'1','Fecha Hasta')
//end if
//
//dw_1.SetTransobject(sqlca)
//dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
//dw_1.retrieve()
//
////residentes = f_consejo_obtener_residentes(f_hasta)
////no_residentes = f_consejo_obtener_no_residentes(f_hasta)
//total_fin = f_consejo_calcular_colegiados(f_hasta)
////f_hasta = f_consejo_obtener_mes_anterior(dw_listados.getitemdatetime(1, 'f_hasta'))
//total_anterior = f_consejo_calcular_colegiados(f_hasta)
//
//
//dw_1.object.t_total_fin_mes.text = string(total_fin)
//dw_1.object.t_total_mes_anterior.text = string(total_anterior)
////dw_1.object.t_residentes.text = string(residentes)
////dw_1.object.t_no_residentes.text = string(no_residentes)
//
//dw_1.setitem(1, 'col_antes', f_num_colegiados_hasta(f_desde))
//dw_1.setitem(1, 'altas', f_dame_numero_de_altas(f_desde, f_hasta))
//dw_1.setitem(1, 'bajas', f_dame_numero_de_bajas(f_desde, f_hasta))
//
//// Al final:
//if dw_1.rowcount() > 0 then
//	dw_1.sort()
//	dw_1.visible 		  = true
//	dw_1.event pfc_printpreview()
//	this.enabled        = false
//	cb_zoom.enabled     = true
//	cb_imprimir.enabled = true
//	cb_guardar.enabled  = true
//	cb_escala.enabled  = true
//else
//	dw_1.insertrow(0)
//	dw_1.setitem(1, 'col_antes', f_num_colegiados_hasta(f_desde))
//	dw_1.setitem(1, 'altas', f_dame_numero_de_altas(f_desde, f_hasta))
//	dw_1.setitem(1, 'bajas', f_dame_numero_de_bajas(f_desde, f_hasta))
//	dw_1.visible 		  = true
//	dw_1.event pfc_printpreview()
//	this.enabled        = false
//	cb_zoom.enabled     = true
//	cb_imprimir.enabled = true
//	cb_guardar.enabled  = true
//	cb_escala.enabled  = true
//	messagebox(g_titulo,'No se han encontrado registros segun las especificaciones.')
//end if
//
end event

event cb_ver::clicked;call super::clicked;string sql, listado
int i, indice
datetime f_desde, f_hasta
int total_fin,total_anterior,residentes,no_residentes
int mes


dw_listados.accepttext()

f_desde = dw_listados.getitemdatetime(1, 'f_desde')
f_hasta = dw_listados.getitemdatetime(1, 'f_hasta')
f_hasta = datetime(relativedate(date(f_hasta), 1))

dw_1.of_SetPrintPreview(TRUE)

// Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado
indice = dw_listados_varios.GetRow()

dw_1.of_SetTransObject(SQLCA)
sql = dw_1.describe("datawindow.table.select")


//if listado='d_consejo_estadillo_totales' or listado='d_consejo_estadillo_totales_tfe' or listado='d_consejo_estadillo_totales_gc' or &
//	listado='d_consejo_estadillo_totales_gui' or listado='d_consejo_estadillo_altas' or listado='d_consejo_estadillo_altas_gc' or &
//	listado='d_consejo_estadillo_bajas' or listado='d_consejo_estadillo_bajas_gc' or listado='d_consejo_estadillo_totales_avi' then

if listado='d_consejo_cambios_domicilios' then
		f_sql('colegiados_cambios_dom.fecha','>=','f_desde',Parent.dw_listados,sql,'1','Fecha Desde')
		f_sql('colegiados_cambios_dom.fecha','<','f_hasta',Parent.dw_listados,sql,'1','Fecha Hasta')
	
else
		f_sql('altas_bajas_situaciones.fecha','>=','f_desde',Parent.dw_listados,sql,'1','Fecha Desde')
		f_sql('altas_bajas_situaciones.fecha','<','f_hasta',Parent.dw_listados,sql,'1','Fecha Hasta')
end if


dw_1.SetTransobject(sqlca)
dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
dw_1.retrieve()


residentes = f_consejo_obtener_residentes(f_hasta)
no_residentes = f_consejo_obtener_no_residentes(f_hasta)
total_fin = f_consejo_calcular_colegiados(f_hasta)
f_hasta = f_consejo_obtener_mes_anterior(dw_listados.getitemdatetime(1, 'f_hasta'))
total_anterior = f_consejo_calcular_colegiados(f_hasta)

//if listado='d_consejo_estadillo_totales' or listado='d_consejo_estadillo_totales_tfe' or listado='d_consejo_estadillo_totales_gc' or &
//	listado='d_consejo_estadillo_totales_gui' or listado='d_consejo_estadillo_totales_avi' then
//	dw_1.object.mes.text = f_obtener_mes(dw_listados.getitemdatetime(1, 'f_hasta'))
//	dw_1.object.t_residentes.text = string(residentes)
//	dw_1.object.t_no_residentes.text = string(no_residentes)
//	dw_1.object.t_total_fin_mes.text = string(total_fin)
//	dw_1.object.t_total_mes_anterior.text = string(total_anterior)
//	dw_1.object.t_13.text = g_col_provincia
//end if
//if listado =  'd_consejo_estadillo_altas' or listado = 'd_consejo_estadillo_bajas' or &
//	listado =  'd_consejo_estadillo_altas_gc' or listado = 'd_consejo_estadillo_bajas_gc' then
//	dw_1.object.t_total_mes_anterior.text = string(total_anterior)
//	dw_1.object.t_total_fin_mes.text = string(total_fin)
//end if

if lower(dw_1.describe("mes.name")) = 'mes' then dw_1.object.mes.text = f_obtener_mes(dw_listados.getitemdatetime(1, 'f_hasta'))
if lower(dw_1.describe("t_residentes.name")) = 't_residentes' then dw_1.object.t_residentes.text = string(residentes)
if lower(dw_1.describe("t_no_residentes.name")) = 't_no_residentes' then dw_1.object.t_no_residentes.text = string(no_residentes)
if lower(dw_1.describe("t_total_fin_mes.name")) = 't_total_fin_mes' then dw_1.object.t_total_fin_mes.text = string(total_fin)
if lower(dw_1.describe("t_total_mes_anterior.name")) = 't_total_mes_anterior' then dw_1.object.t_total_mes_anterior.text = string(total_anterior)
if g_colegio='COAATMCA' then
	if lower(dw_1.describe("t_13.name")) = 't_13' then dw_1.object.t_13.text = 'PALMA DE MALLORCA'
else
	if lower(dw_1.describe("t_13.name")) = 't_13' then dw_1.object.t_13.text = g_col_provincia
end if

if dw_1.rowcount() > 0 then
	dw_1.sort()
	dw_1.visible 		  = true
	dw_1.event pfc_printpreview()
	this.enabled        = false
	cb_zoom.enabled     = true
	cb_imprimir.enabled = true
	cb_guardar.enabled  = true
	cb_escala.enabled  = true
	cb_ordenar.enabled  = true
else
	dw_1.visible 		  = true
	dw_1.event pfc_printpreview()
	this.enabled        = false
	cb_zoom.enabled     = true
	cb_imprimir.enabled = true
	cb_guardar.enabled  = true
	cb_escala.enabled  = true
	cb_ordenar.enabled  = true
	messagebox(g_titulo,'No se han encontrado registros segun las especificaciones.')
end if

end event

type cb_salir from w_listados`cb_salir within w_consejo_estadillo
end type

type dw_listados from w_listados`dw_listados within w_consejo_estadillo
integer y = 292
integer width = 1623
integer height = 340
string dataobject = "d_consejo_meses"
end type

event dw_listados::itemchanged;call super::itemchanged;choose case dwo.name
	case 'mes'
		datetime f_desde
		string mes
		mes = data
		
		f_desde = datetime(date('01/'+mes+'/'+string(year(today()))), time('00:00:00'))
		this.setitem(1, 'f_desde', f_desde)
		this.setitem(1, 'f_hasta', f_ultimo_dia_mes(f_desde))
		
end choose
end event

type cb_imprimir from w_listados`cb_imprimir within w_consejo_estadillo
end type

type cb_zoom from w_listados`cb_zoom within w_consejo_estadillo
end type

type cb_esp from w_listados`cb_esp within w_consejo_estadillo
end type

type cb_guardar from w_listados`cb_guardar within w_consejo_estadillo
end type

type cb_escala from w_listados`cb_escala within w_consejo_estadillo
end type

type cb_ordenar from w_listados`cb_ordenar within w_consejo_estadillo
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_consejo_estadillo
end type

type dw_1 from w_listados`dw_1 within w_consejo_estadillo
integer x = 32
integer y = 212
integer height = 1396
end type

