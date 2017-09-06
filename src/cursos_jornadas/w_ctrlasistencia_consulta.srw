HA$PBExportHeader$w_ctrlasistencia_consulta.srw
forward
global type w_ctrlasistencia_consulta from w_consulta
end type
end forward

global type w_ctrlasistencia_consulta from w_consulta
string title = "Consulta de Control de Asistencia"
end type
global w_ctrlasistencia_consulta w_ctrlasistencia_consulta

on w_ctrlasistencia_consulta.create
call super::create
end on

on w_ctrlasistencia_consulta.destroy
call super::destroy
end on

event open;call super::open;//dw_1.SetItem(1,'f_desde',datetime(today()))
//dw_1.SetItem(1,'f_hasta',datetime(today()))
end event

type cb_limpiar from w_consulta`cb_limpiar within w_ctrlasistencia_consulta
end type

type st_5 from w_consulta`st_5 within w_ctrlasistencia_consulta
end type

type cb_1 from w_consulta`cb_1 within w_ctrlasistencia_consulta
end type

event cb_1::clicked;string sql_nuevo

sql_nuevo=g_dw_lista.describe("datawindow.table.select")

dw_1.AcceptText()

f_sql('id_asistencia_fecha','LIKE','id_asistencia_fecha',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha','>=','f_desde',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha','<=','f_hasta',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')


g_dw_lista.modify("Datawindow.table.select=~""+sql_nuevo+"~"")

Parent.event pfc_close()
end event

type cb_2 from w_consulta`cb_2 within w_ctrlasistencia_consulta
end type

type cb_ayuda from w_consulta`cb_ayuda within w_ctrlasistencia_consulta
end type

type dw_1 from w_consulta`dw_1 within w_ctrlasistencia_consulta
string dataobject = "d_ctrlasistencia_consulta"
end type

