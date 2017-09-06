HA$PBExportHeader$w_garantias_listados.srw
forward
global type w_garantias_listados from w_listados
end type
end forward

global type w_garantias_listados from w_listados
integer width = 4037
string title = "Listados de Garant$$HEX1$$ed00$$ENDHEX$$as/Fondos"
end type
global w_garantias_listados w_garantias_listados

on w_garantias_listados.create
call super::create
end on

on w_garantias_listados.destroy
call super::destroy
end on

event open;call super::open;//Para relacionar los registros que se encuentran en la tabla de listados
dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)
end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_garantias_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_garantias_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_garantias_listados
integer y = 1408
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_garantias_listados
integer x = 3040
integer y = 192
integer width = 969
end type

type cb_ver from w_listados`cb_ver within w_garantias_listados
end type

event cb_ver::clicked;call super::clicked;string sql
string listado, descripcion

dw_listados.Accepttext()
dw_1.of_SetPrintPreview(TRUE)

//Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
descripcion = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'descripcion')
dw_1.dataobject = listado

dw_1.of_settransobject(sqlca)
sql = dw_1.describe("Datawindow.Table.Select")


CHOOSE CASE upper(listado)
	CASE  upper('d_garantias_general_listados'), upper('d_garantias_general_listados_tg') 
	
		//De la tabla fases debemos comprobar : n_expedi,n_registro
		f_sql('fases.n_expedi','LIKE','n_expediente',dw_listados,sql,'1','')
		f_sql('fases.n_registro','LIKE','n_registro',dw_listados,sql,'1','')
		
		//De la tabla colegiados
		f_sql('colegiados.n_colegiado','LIKE','n_colegiado',dw_listados,sql,'1','')
		f_sql('colegiados.nombre','LIKE','nombre_colegiado',dw_listados,sql,'1','')
		f_sql('colegiados.apellidos','LIKE','apellidos_colegiado',dw_listados,sql,'1','')
		
		//De la tabla clientes
		f_sql('clientes.n_cliente','LIKE','n_cliente',dw_listados,sql,'1','')
		f_sql('clientes.nombre','LIKE','nombre_cliente',dw_listados,sql,'1','')
		f_sql('clientes.apellidos','LIKE','apellidos_cliente',dw_listados,sql,'1','')
		
		//De la tabla garantias
		f_sql('fases_garantias.importe','>=','importe_desde',dw_listados,sql,'1','')
		f_sql('fases_garantias.importe','<','importe_hasta',dw_listados,sql,'1','')
		
		f_sql('fases_garantias.f_in','>=','f_in_desde',dw_listados,sql,'1','')
		f_sql('fases_garantias.f_in','<','f_in_hasta',dw_listados,sql,'1','')
		
		f_sql('fases_garantias.f_out','>=','f_out_desde',dw_listados,sql,'1','')
		f_sql('fases_garantias.f_out','<','f_out_hasta',dw_listados,sql,'1','')
		
		dw_1.SetTransobject(sqlca)
		dw_1.modify("datawindow.table.select= ~"" + sql+ "~"")
		dw_1.retrieve()
	
END CHOOSE

	if dw_1.describe("t_parametros.name") = "t_parametros" then dw_1.object.t_parametros.text = g_ultima_consulta	
//Al final:
if dw_1.RowCount() > 0 then
	dw_1.event pfc_printpreview()
	dw_1.visible = true
	this.enabled = false
	cb_zoom.enabled = true
	cb_imprimir.enabled = true
	cb_guardar.enabled = true
	cb_escala.enabled  = true
	cb_ordenar.enabled  = true
else
	messagebox(g_titulo,'No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.')
end if	
end event

type cb_salir from w_listados`cb_salir within w_garantias_listados
end type

type dw_listados from w_listados`dw_listados within w_garantias_listados
integer y = 192
integer width = 2967
integer height = 968
string dataobject = "d_garantias_consulta"
end type

type cb_imprimir from w_listados`cb_imprimir within w_garantias_listados
end type

type cb_zoom from w_listados`cb_zoom within w_garantias_listados
end type

type cb_esp from w_listados`cb_esp within w_garantias_listados
end type

type cb_guardar from w_listados`cb_guardar within w_garantias_listados
end type

type cb_escala from w_listados`cb_escala within w_garantias_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_garantias_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_garantias_listados
end type

type dw_1 from w_listados`dw_1 within w_garantias_listados
integer width = 3968
end type

