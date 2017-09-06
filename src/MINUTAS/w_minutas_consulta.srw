HA$PBExportHeader$w_minutas_consulta.srw
forward
global type w_minutas_consulta from w_consulta
end type
end forward

global type w_minutas_consulta from w_consulta
integer width = 1897
integer height = 1796
string title = "Consulta de Minutas"
end type
global w_minutas_consulta w_minutas_consulta

on w_minutas_consulta.create
call super::create
end on

on w_minutas_consulta.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_minutas_consulta
integer taborder = 30
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_minutas_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_minutas_consulta
integer taborder = 60
end type

type st_5 from w_consulta`st_5 within w_minutas_consulta
end type

type cb_1 from w_consulta`cb_1 within w_minutas_consulta
integer y = 1588
integer taborder = 40
end type

event cb_1::clicked;call super::clicked;string sql_nuevo
//Recuperamos le select del datawindow de lista
sql_nuevo = g_dw_lista.describe("datawindow.table.select")
f_sql('fases_minutas.n_aviso', 'LIKE', 'n_aviso',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_minutas.fecha','>=','fecha_desde',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_minutas.fecha','<','fecha_hasta',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_minutas.fecha_pago','>=','fecha_pago_desde',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_minutas.fecha_pago','<','fecha_pago_hasta',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_minutas.id_colegiado','=','colegiado',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_minutas.id_cliente','=','cliente',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_minutas.tipo_gestion','=','tipo_gestion',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_minutas.forma_pago','=','forma_pago',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_minutas.banco','=','banco',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_minutas.total_aviso','>=','importe_desde',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_minutas.total_aviso','<=','importe_hasta',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_minutas.pendiente','LIKE','pendiente',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_minutas.anulada','LIKE','anulada',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases.n_registro','=','n_registro',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases.n_expedi','=','n_expedi',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_minutas.pagador','LIKE','pagador',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
// ... f_sql$$HEX1$$b400$$ENDHEX$$s
//modificamos el dw con los parametros de la ventana de consulta

g_dw_lista.modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

Parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_minutas_consulta
integer y = 1588
integer taborder = 50
end type

type cb_ayuda from w_consulta`cb_ayuda within w_minutas_consulta
integer taborder = 70
end type

type dw_1 from w_consulta`dw_1 within w_minutas_consulta
integer x = 46
integer y = 112
integer width = 1760
integer height = 1448
integer taborder = 20
string dataobject = "d_minutas_consulta"
end type

event dw_1::buttonclicked;call super::buttonclicked;CHOOSE CASE dwo.name
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

event dw_1::constructor;call super::constructor;datawindowchild dwc_formapago
this.GetChild('forma_pago', dwc_formapago)
dwc_formapago.settransobject(sqlca)
dwc_formapago.setfilter("tipo_pago<>'CM'")
dwc_formapago.filter()
end event

