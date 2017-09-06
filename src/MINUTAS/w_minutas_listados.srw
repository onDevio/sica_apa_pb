HA$PBExportHeader$w_minutas_listados.srw
forward
global type w_minutas_listados from w_listados
end type
end forward

global type w_minutas_listados from w_listados
string title = "Listados de Avisos de Factura"
end type
global w_minutas_listados w_minutas_listados

on w_minutas_listados.create
call super::create
end on

on w_minutas_listados.destroy
call super::destroy
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)
end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_minutas_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_minutas_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_minutas_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_minutas_listados
end type

type cb_ver from w_listados`cb_ver within w_minutas_listados
end type

event cb_ver::clicked;call super::clicked;string sql_nuevo, listado

dw_listados.Accepttext()
dw_1.of_SetPrintPreview(TRUE)

//Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado

dw_1.of_settransobject(sqlca)
sql_nuevo = dw_1.describe("Datawindow.Table.Select")

//Recuperamos le select del datawindow de lista
sql_nuevo = dw_1.describe("datawindow.table.select")
f_sql('fases_minutas.n_aviso', 'LIKE', 'n_aviso',Parent.dw_listados,sql_nuevo,'1','')
f_sql('fases_minutas.fecha','>=','fecha_desde',Parent.dw_listados,sql_nuevo,'1','')
f_sql('fases_minutas.fecha','<','fecha_hasta',Parent.dw_listados,sql_nuevo,'1','')
f_sql('fases_minutas.fecha_pago','>=','fecha_pago_desde',Parent.dw_listados,sql_nuevo,'1','')
f_sql('fases_minutas.fecha_pago','<','fecha_pago_hasta',Parent.dw_listados,sql_nuevo,'1','')
f_sql('fases_minutas.id_colegiado','=','colegiado',Parent.dw_listados,sql_nuevo,'1','')
f_sql('fases_minutas.id_cliente','=','cliente',Parent.dw_listados,sql_nuevo,'1','')
f_sql('fases_minutas.tipo_gestion','=','tipo_gestion',Parent.dw_listados,sql_nuevo,'1','')
f_sql('fases_minutas.forma_pago','=','forma_pago',Parent.dw_listados,sql_nuevo,'1','')
f_sql('fases_minutas.banco','=','banco',Parent.dw_listados,sql_nuevo,'1','')
f_sql('fases_minutas.total_aviso','>=','importe_desde',Parent.dw_listados,sql_nuevo,'1','')
f_sql('fases_minutas.total_aviso','<=','importe_hasta',Parent.dw_listados,sql_nuevo,'1','')
f_sql('fases_minutas.pendiente','LIKE','pendiente',Parent.dw_listados,sql_nuevo,'1','')
f_sql('fases_minutas.anulada','LIKE','anulada',Parent.dw_listados,sql_nuevo,'1','')
f_sql('fases.n_registro','=','n_registro',Parent.dw_listados,sql_nuevo,'1','')
f_sql('fases.n_expedi','=','n_expedi',Parent.dw_listados,sql_nuevo,'1','')
f_sql('fases_minutas.pagador','LIKE','pagador',Parent.dw_listados,sql_nuevo,'1','')
// ... f_sql$$HEX1$$b400$$ENDHEX$$s
//modificamos el dw con los parametros de la ventana de consulta
//messagebox('kk', sql_nuevo)
dw_1.modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

//dw_1.Modify('Datawindow.table.Select"'+sql_nuevo+'"')
dw_1.retrieve()

//Al final:
if dw_1.RowCount() > 0 then
	dw_1.visible = true
	dw_1.event pfc_printpreview()
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

type cb_salir from w_listados`cb_salir within w_minutas_listados
end type

type dw_listados from w_listados`dw_listados within w_minutas_listados
integer y = 164
integer height = 1480
string dataobject = "d_minutas_consulta"
end type

event dw_listados::buttonclicked;call super::buttonclicked;CHOOSE CASE dwo.name
	CASE 'b_colegiado'
		string id_colegiado
		
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"

		id_colegiado=f_busqueda_colegiados()
		
		setItem(1,'colegiado',id_colegiado)
	CASE 'b_cliente'
		string id_cliente
		
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
		g_busqueda.dw="d_lista_busqueda_clientes"
		id_cliente=f_busqueda_clientes("")
		
		setitem(1,'cliente',id_cliente)
		
END CHOOSE

end event

type cb_imprimir from w_listados`cb_imprimir within w_minutas_listados
end type

type cb_zoom from w_listados`cb_zoom within w_minutas_listados
end type

type cb_esp from w_listados`cb_esp within w_minutas_listados
end type

type cb_guardar from w_listados`cb_guardar within w_minutas_listados
end type

type cb_escala from w_listados`cb_escala within w_minutas_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_minutas_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_minutas_listados
end type

type dw_1 from w_listados`dw_1 within w_minutas_listados
end type

