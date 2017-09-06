HA$PBExportHeader$w_reparos_consulta.srw
forward
global type w_reparos_consulta from w_consulta
end type
end forward

global type w_reparos_consulta from w_consulta
integer width = 2153
integer height = 1420
string title = "Consulta de Reparos"
end type
global w_reparos_consulta w_reparos_consulta

on w_reparos_consulta.create
call super::create
end on

on w_reparos_consulta.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_reparos_consulta
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_reparos_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_reparos_consulta
end type

type st_5 from w_consulta`st_5 within w_reparos_consulta
end type

type cb_1 from w_consulta`cb_1 within w_reparos_consulta
integer x = 489
integer y = 1184
end type

event cb_1::clicked;string sql_nuevo,sql_prueba,id_fase,n_reg,n_colegiado
long p

dw_1.accepttext()

sql_nuevo = g_dw_lista.describe("datawindow.table.select")
//Se inicializan los id de Colegiado y cliente para no alterar el sql
dw_1.setitem(1,'id_col','')
dw_1.setitem(1,'id_registro','')

n_colegiado = dw_1.getitemstring(1,'n_colegiado')
if not f_es_vacio(n_colegiado) then
	dw_1.setitem(1,'id_col',f_busca_id_colegiado_por_codigo(n_colegiado))
end if	

n_reg = dw_1.getitemstring(1,'n_registro')
if not f_es_vacio(n_reg) then
	dw_1.setitem(1,'id_registro',f_devuelve_id_fase_por_num(n_reg))
end if	

f_sql('fases_reparos.id_fase','LIKE','id_registro',dw_1,sql_nuevo,'1','')
f_sql('fases_reparos.tipo_reparo','LIKE','tipo_reparo',dw_1,sql_nuevo,'1','')
f_sql('fases_reparos.id_col','LIKE','id_col',dw_1,sql_nuevo,'1','')
f_sql('fases_reparos.usuario','LIKE','usuario',dw_1,sql_nuevo,'1','')
f_sql('fases_reparos.notificado','LIKE','notificado',dw_1,sql_nuevo,'1','')
f_sql('fases_reparos.email','LIKE','email',dw_1,sql_nuevo,'1','')
f_sql('fases_reparos.f_emision','>=','f_emision_desde',dw_1,sql_nuevo,'1','')
f_sql('fases_reparos.f_emision','<','f_emision_hasta',dw_1,sql_nuevo,'1','')
f_sql('fases_reparos.f_subsanacion','>=','fecha_subsanacion_desde',dw_1,sql_nuevo,'1','')
f_sql('fases_reparos.f_subsanacion','<','fecha_subsanacion_hasta',dw_1,sql_nuevo,'1','')
f_sql('fases_reparos.telfax','LIKE','telfax',dw_1,sql_nuevo,'1','')

g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
Parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_reparos_consulta
integer x = 1111
integer y = 1184
end type

type cb_ayuda from w_consulta`cb_ayuda within w_reparos_consulta
end type

type dw_1 from w_consulta`dw_1 within w_reparos_consulta
integer y = 124
integer width = 1929
integer height = 880
string dataobject = "d_reparos_consulta"
end type

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

//this.setformat('f_inicio_desde','dd/mm/yyyy')

//this.setformat('f_inicio_hasta','dd/mm/yyyy')

end event

event dw_1::buttonclicked;string id_persona,id_fase

choose case dwo.name
		
CASE 'b_busqueda_colegiados'
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
			g_busqueda.dw="d_lista_busqueda_colegiados"
			id_persona=f_busqueda_colegiados()
			if id_persona="-1" then
				this.deleterow(row)
			else
				//this.setitem(this.getrow(),'id_col',id_persona)
				this.setitem(this.getrow(),'n_colegiado',f_colegiado_n_col(id_persona))
			end if

CASE 'b_busqueda_registros'
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Fase"
			g_busqueda.dw="d_lista_busqueda_fases"
			id_fase=f_busqueda_fases()
			if id_fase="-1" then
				this.deleterow(row)
			else
				//this.setitem(this.getrow(),'id_col',id_persona)
				this.setitem(this.getrow(),'n_registro',f_dame_n_reg(id_fase))
				this.setitem(this.getrow(),'id_registro',id_fase)
			end if	

end choose

end event

