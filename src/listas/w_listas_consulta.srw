HA$PBExportHeader$w_listas_consulta.srw
forward
global type w_listas_consulta from w_consulta
end type
end forward

global type w_listas_consulta from w_consulta
integer width = 2313
integer height = 1076
string title = "Consulta de Listas"
end type
global w_listas_consulta w_listas_consulta

on w_listas_consulta.create
call super::create
end on

on w_listas_consulta.destroy
call super::destroy
end on

event open;call super::open;dw_1.setitem(1,'activa','%')
end event

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_listas_consulta
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_listas_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_listas_consulta
string tag = "texto=general.limpiar_consulta"
end type

type st_5 from w_consulta`st_5 within w_listas_consulta
string tag = "texto=listas.int_param_consulta_aceptar"
end type

type cb_1 from w_consulta`cb_1 within w_listas_consulta
string tag = "texto=general.aceptar"
integer x = 462
integer y = 788
end type

event cb_1::clicked;call super::clicked;string sql_nuevo

sql_nuevo = g_dw_lista.describe("datawindow.table.select")

f_sql('listas_colegiados.nombre_lista','LIKE','nombre_lista',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('listas_colegiados.propietario','LIKE','usuario_propietario',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('listas_colegiados.activa','LIKE','activa',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('listas_colegiados.fecha_creacion','>=','fecha_creacion_desde',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('listas_colegiados.fecha_creacion','<=','fecha_creacion_hasta',dw_1,sql_nuevo,g_tipo_base_datos,'')

g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
Parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_listas_consulta
string tag = "texto=general.cancelar"
integer x = 1289
integer y = 788
end type

type cb_ayuda from w_consulta`cb_ayuda within w_listas_consulta
string tag = "texto=general.ayuda"
integer x = 1655
integer y = 784
end type

type dw_1 from w_consulta`dw_1 within w_listas_consulta
integer x = 105
integer y = 192
integer width = 2121
integer height = 448
string dataobject = "d_listas_consulta"
end type

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)


end event

