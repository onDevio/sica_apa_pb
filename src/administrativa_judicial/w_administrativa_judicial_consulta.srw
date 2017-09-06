HA$PBExportHeader$w_administrativa_judicial_consulta.srw
forward
global type w_administrativa_judicial_consulta from w_consulta
end type
end forward

global type w_administrativa_judicial_consulta from w_consulta
integer x = 214
integer y = 221
integer width = 2962
integer height = 1308
string title = "Consulta V$$HEX1$$ed00$$ENDHEX$$a Administrativa y Judicial"
end type
global w_administrativa_judicial_consulta w_administrativa_judicial_consulta

on w_administrativa_judicial_consulta.create
call super::create
end on

on w_administrativa_judicial_consulta.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_administrativa_judicial_consulta
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_administrativa_judicial_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_administrativa_judicial_consulta
end type

type st_5 from w_consulta`st_5 within w_administrativa_judicial_consulta
end type

type cb_1 from w_consulta`cb_1 within w_administrativa_judicial_consulta
integer x = 306
integer y = 1080
end type

event cb_1::clicked;call super::clicked;//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo
SetPointer(HourGlass!)
sql_nuevo = g_dw_lista.describe("datawindow.table.select")

//De la tabla fases debemos comprobar : n_expedi,n_registro
f_sql('fases.n_expedi','LIKE','n_expediente',dw_1,sql_nuevo,'1','')
f_sql('fases.n_registro','LIKE','n_registro',dw_1,sql_nuevo,'1','')

//De la tabla fases_administrativa_judicial debemos comprobar los parametros de la consulta
f_sql('fases_administrativa_judicial.n_interno','LIKE','n_administrativo',dw_1,sql_nuevo,'1','')
f_sql('fases_administrativa_judicial.n_musaat','LIKE','n_musaat',dw_1,sql_nuevo,'1','')

f_sql('fases_administrativa_judicial.fecha','>=','fecha_registro_desde',dw_1,sql_nuevo,'1','')
f_sql('fases_administrativa_judicial.fecha','<','fecha_registro_hasta',dw_1,sql_nuevo,'1','')

f_sql('fases_administrativa_judicial.fecha_cierre','>=','fecha_cierre_desde',dw_1,sql_nuevo,'1','')
f_sql('fases_administrativa_judicial.fecha_cierre','<','fecha_cierre_hasta',dw_1,sql_nuevo,'1','')

f_sql('fases_administrativa_judicial.autos','LIKE','autos',dw_1,sql_nuevo,'1','')
f_sql('fases_administrativa_judicial.abogado','LIKE','abogado',dw_1,sql_nuevo,'1','')
f_sql('fases_administrativa_judicial.juzgado','LIKE','juzgado',dw_1,sql_nuevo,'1','')

f_sql('fases_administrativa_judicial.procurador','LIKE','procurador',dw_1,sql_nuevo,'1','')
f_sql('fases_administrativa_judicial.tipo_reclamacion','LIKE','tipo_reclamacion',dw_1,sql_nuevo,'1','')
f_sql('fases_administrativa_judicial.asunto','LIKE','asunto',dw_1,sql_nuevo,'1','')


g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")


Parent.event pfc_close()


end event

type cb_2 from w_consulta`cb_2 within w_administrativa_judicial_consulta
integer x = 1833
integer y = 1080
end type

type cb_ayuda from w_consulta`cb_ayuda within w_administrativa_judicial_consulta
end type

type dw_1 from w_consulta`dw_1 within w_administrativa_judicial_consulta
string tag = "Consulta Adiministrativa y Judicial"
integer x = 37
integer y = 136
integer width = 2880
integer height = 896
string title = "Consulta Adiministrativa y Judicial"
string dataobject = "d_administrativa_judicial_consulta"
end type

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event dw_1::buttonclicked;call super::buttonclicked;string id_col


choose case dwo.name
	case "b_busqueda_colegiado"
  		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()   
		if NOT f_es_vacio(id_col)  then
			this.setitem(1,'n_colegiado',f_colegiado_n_col(id_col))
			this.setitem(1,'nombre_apellidos_colegiado',f_nombre_colegiado(id_col))
		end if

END CHOOSE
end event

event dw_1::itemchanged;call super::itemchanged;string id_col,n_col

choose case dwo.name
		case "n_colegiado"
		id_col=f_colegiado_id_col(data)
		if NOT f_es_vacio(id_col) then
			this.setitem(1,'nombre_apellidos_colegiado',f_nombre_colegiado(id_col))
			else 
			messagebox('El colegiado insertado no existe',data)
		end if

END CHOOSE
end event

