HA$PBExportHeader$w_cursos_form_consulta.srw
forward
global type w_cursos_form_consulta from w_consulta
end type
end forward

global type w_cursos_form_consulta from w_consulta
integer width = 2071
integer height = 1392
string title = "Consulta de Convocatorias"
end type
global w_cursos_form_consulta w_cursos_form_consulta

on w_cursos_form_consulta.create
call super::create
end on

on w_cursos_form_consulta.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_cursos_form_consulta
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_cursos_form_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_cursos_form_consulta
end type

type st_5 from w_consulta`st_5 within w_cursos_form_consulta
end type

type cb_1 from w_consulta`cb_1 within w_cursos_form_consulta
integer x = 416
integer y = 1108
end type

event cb_1::clicked;call super::clicked;string sql_nuevo

sql_nuevo=g_dw_lista.describe("datawindow.table.select")

dw_1.AcceptText()

f_sql('nombre','LIKE','nombre',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('codigo','LIKE','codigo',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('estado','LIKE','estado',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('f_ini_inscripcion','>=','f_ini_inscripcion_desde',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('f_ini_inscripcion','<=','f_ini_inscripcion_hasta',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('f_fin_inscripcion','>=','f_fin_inscripcion_desde',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('f_fin_inscripcion','<=','f_fin_inscripcion_hasta',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('f_ini_curso','>=','f_ini_curso_desde',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('f_ini_curso','<=','f_ini_curso_hasta',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('f_fin_curso','>=','f_fin_curso_desde',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('f_fin_curso','<=','f_fin_curso_hasta',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')


g_dw_lista.modify("Datawindow.table.select=~""+sql_nuevo+"~"")

Parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_cursos_form_consulta
integer x = 1038
integer y = 1108
end type

type cb_ayuda from w_consulta`cb_ayuda within w_cursos_form_consulta
end type

type dw_1 from w_consulta`dw_1 within w_cursos_form_consulta
integer x = 32
integer y = 128
integer width = 1961
integer height = 888
string dataobject = "d_cursos_form_consulta"
end type

