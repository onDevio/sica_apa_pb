HA$PBExportHeader$w_ing_ret_consulta.srw
forward
global type w_ing_ret_consulta from w_consulta
end type
end forward

global type w_ing_ret_consulta from w_consulta
integer width = 2661
integer height = 1476
string title = "Consulta Ingresa/Retira "
end type
global w_ing_ret_consulta w_ing_ret_consulta

type variables
u_dw idw_general,idw_fechas
string i_sql_nuevo
end variables

on w_ing_ret_consulta.create
call super::create
end on

on w_ing_ret_consulta.destroy
call super::destroy
end on

event open;call super::open;// Centramos la ventana
f_centrar_ventana(this) 

end event

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_ing_ret_consulta
integer x = 69
integer y = 1104
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_ing_ret_consulta
integer x = 69
integer y = 932
end type

type cb_limpiar from w_consulta`cb_limpiar within w_ing_ret_consulta
integer x = 1975
integer y = 932
end type

type st_5 from w_consulta`st_5 within w_ing_ret_consulta
integer height = 64
end type

type cb_1 from w_consulta`cb_1 within w_ing_ret_consulta
integer x = 681
integer y = 1212
end type

event cb_1::clicked;call super::clicked;string sql_nuevo 

// Cogemos la sql y la modificamos
sql_nuevo = g_dw_lista.describe("datawindow.table.select")
f_sql('csi_traspasos_basicos.numero','LIKE','numero',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_traspasos_basicos.numero','>=','n_desde',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_traspasos_basicos.numero','<=','n_hasta',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_traspasos_basicos.id_colegiado','LIKE','id_colegiado',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_traspasos_basicos.banco','LIKE','banco',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_traspasos_basicos.forma_pago','LIKE','forma_pago',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_traspasos_basicos.tipo','LIKE','tipo',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_traspasos_basicos.fecha','>=','fecha_desde',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_traspasos_basicos.fecha','<','fecha_hasta',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_traspasos_basicos.n_talon','LIKE','n_talon',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_traspasos_basicos.centro','LIKE','centro',dw_1,sql_nuevo,g_tipo_base_datos,'')

///*** SCP-1846 - Alexis. Se a$$HEX1$$f100$$ENDHEX$$ade filtrado por empresa ***///
if Pos(Upper(sql_nuevo), "WHERE") > 0 then 
	sql_nuevo = sql_nuevo + " and csi_traspasos_basicos.empresa = '"+ g_empresa +"' and csi_centros.empresa = '"+ g_empresa +"'  and csi_bancos.empresa = '"+ g_empresa +"' "
else
	sql_nuevo = sql_nuevo + " where csi_traspasos_basicos.empresa = '"+ g_empresa +"' and csi_centros.empresa = '"+ g_empresa +"'  and csi_bancos.empresa = '"+ g_empresa +"' "
end if 

// Colocamos el nuevo sql
g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")

// Cerramos la ventana
Parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_ing_ret_consulta
integer x = 1321
integer y = 1212
end type

type cb_ayuda from w_consulta`cb_ayuda within w_ing_ret_consulta
integer x = 1975
integer y = 948
integer height = 76
end type

type dw_1 from w_consulta`dw_1 within w_ing_ret_consulta
integer x = 265
integer y = 124
integer width = 2194
integer height = 1004
string dataobject = "d_ing_ret_consulta"
end type

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event dw_1::buttonclicked;call super::buttonclicked;string id_colegiado

CHOOSE CASE dwo.name
	CASE 'cb_busqueda_colegiado'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_colegiado=f_busqueda_colegiados()

		if not f_es_vacio(id_colegiado) then
			this.SetItem(1,'id_colegiado',id_colegiado)
			this.SetItem(1,'n_col',f_colegiado_n_col(id_colegiado))
		end if		
END CHOOSE

end event

event dw_1::itemchanged;call super::itemchanged;string id_col

CHOOSE CASE dwo.name
	CASE 'n_col'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_colegiado', id_col)
END CHOOSE

end event

