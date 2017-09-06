HA$PBExportHeader$w_asesoria_juridica_consulta.srw
forward
global type w_asesoria_juridica_consulta from w_consulta
end type
end forward

global type w_asesoria_juridica_consulta from w_consulta
integer width = 2519
integer height = 1012
string title = "Consulta de Asesor$$HEX1$$ed00$$ENDHEX$$a Jur$$HEX1$$ed00$$ENDHEX$$dica"
end type
global w_asesoria_juridica_consulta w_asesoria_juridica_consulta

on w_asesoria_juridica_consulta.create
call super::create
end on

on w_asesoria_juridica_consulta.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_asesoria_juridica_consulta
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_asesoria_juridica_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_asesoria_juridica_consulta
end type

type st_5 from w_consulta`st_5 within w_asesoria_juridica_consulta
integer x = 55
end type

type cb_1 from w_consulta`cb_1 within w_asesoria_juridica_consulta
integer x = 416
integer y = 768
end type

event cb_1::clicked;call super::clicked;//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo
SetPointer(HourGlass!)
sql_nuevo = g_dw_lista.describe("datawindow.table.select")

//De la tabla asesoria_juridica.
f_sql('asesoria_juridica.n_asesoria','LIKE','n_asesoria',dw_1,sql_nuevo,'1','')
f_sql('asesoria_juridica.id_col','LIKE','id_col',dw_1,sql_nuevo,'1','')

//De la tabla asesoria_juridica.
f_sql('asesoria_juridica.fecha','=','fecha',dw_1,sql_nuevo,'1','')
f_sql('asesoria_juridica.tipo_asunto','LIKE','tipo_asunto',dw_1,sql_nuevo,'1','')
f_sql('asesoria_juridica.descripcion_asunto','LIKE','descripcion_asunto',dw_1,sql_nuevo,'1','')
f_sql('asesoria_juridica.observaciones','LIKE','observaciones',dw_1,sql_nuevo,'1','')

g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")


Parent.event pfc_close()


end event

type cb_2 from w_consulta`cb_2 within w_asesoria_juridica_consulta
integer x = 1563
integer y = 768
end type

type cb_ayuda from w_consulta`cb_ayuda within w_asesoria_juridica_consulta
end type

type dw_1 from w_consulta`dw_1 within w_asesoria_juridica_consulta
integer x = 37
integer y = 128
integer width = 2395
integer height = 572
string title = "Consulta de Asesor$$HEX1$$ed00$$ENDHEX$$a Jur$$HEX1$$ed00$$ENDHEX$$dica"
string dataobject = "d_asesoria_juridica_consulta"
end type

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event dw_1::buttonclicked;call super::buttonclicked;string id_col


choose case dwo.name
	case "b_busca_colegiado"
  		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()   
		if NOT f_es_vacio(id_col)  then
			this.setitem(1,'id_col',id_col)
			this.setitem(1,'n_col',f_colegiado_n_col(id_col))
			this.setitem(1,'nombre_col',f_nombre_colegiado(id_col))
		end if

END CHOOSE
end event

event dw_1::itemchanged;call super::itemchanged;string id_col,n_col

choose case dwo.name
		case "n_col"
		id_col=f_colegiado_id_col(data)
		if NOT f_es_vacio(id_col) then
				this.setitem(1,'id_col',id_col)
				this.setitem(1,'nombre_col',f_nombre_colegiado(id_col))
			else 
			messagebox('El colegiado insertado no existe',data)
		end if

END CHOOSE
end event

