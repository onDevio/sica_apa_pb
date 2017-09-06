HA$PBExportHeader$w_demandas_consulta.srw
forward
global type w_demandas_consulta from w_consulta
end type
end forward

global type w_demandas_consulta from w_consulta
integer width = 2194
integer height = 1264
string title = "Consulta de Demandas"
end type
global w_demandas_consulta w_demandas_consulta

on w_demandas_consulta.create
call super::create
end on

on w_demandas_consulta.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_demandas_consulta
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_demandas_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_demandas_consulta
end type

type st_5 from w_consulta`st_5 within w_demandas_consulta
end type

type cb_1 from w_consulta`cb_1 within w_demandas_consulta
integer x = 233
integer y = 1032
end type

event cb_1::clicked;call super::clicked;//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo
SetPointer(HourGlass!)
sql_nuevo = g_dw_lista.describe("datawindow.table.select")

//De la tabla bt_demandas debemos comprobar los parametros de la consulta
f_sql('bt_demandas.id_col','=','id_col',dw_1,sql_nuevo,'1','')
f_sql('bt_demandas.f_inicio','>=','f_inicio',dw_1,sql_nuevo,'1','')
f_sql('bt_demandas.f_inicio','<','f_ini_hasta',dw_1,sql_nuevo,'1','')
f_sql('bt_demandas.f_fin','>=','f_fin',dw_1,sql_nuevo,'1','')
f_sql('bt_demandas.f_fin','<','f_fin_hasta',dw_1,sql_nuevo,'1','')
//De la tabla bt_demandas_tipo debemos comprobar los parametros de la consulta
f_sql('bt_demandas_tipo.tipo_demanda','LIKE','tipo_demanda',dw_1,sql_nuevo,'1','')

// Alta
if dw_1.getitemstring(1, 'alta') = 'S' then
	sql_nuevo += "and (bt_demandas.f_fin is null or bt_demandas.f_fin >= '" + string(today(), 'yyyymmdd') + "')" +&
				 + " and (bt_demandas.f_inicio is null or bt_demandas.f_inicio <= '" + string(today(), 'yyyymmdd') + "')"
end if
if dw_1.getitemstring(1, 'alta') = 'N' then
	sql_nuevo += "and not ((bt_demandas.f_fin is null or bt_demandas.f_fin >= '" + string(today(), 'yyyymmdd') + "')" +&
				 + " and (bt_demandas.f_inicio is null or bt_demandas.f_inicio <= '" + string(today(), 'yyyymmdd') + "'))"
end if	

g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")

//messagebox('', sql_nuevo)

Parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_demandas_consulta
integer x = 1079
integer y = 1032
end type

type cb_ayuda from w_consulta`cb_ayuda within w_demandas_consulta
end type

type dw_1 from w_consulta`dw_1 within w_demandas_consulta
integer x = 37
integer y = 116
integer width = 2007
integer height = 676
string dataobject = "d_demandas_consulta"
end type

event dw_1::buttonclicked;call super::buttonclicked;string id_col,n_col,desc_pob
string pob

choose case dwo.name
	case "b_busca_colegiado"
  		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()   
		if NOT f_es_vacio(id_col)  then
			this.setitem(1,'n_colegiado',f_colegiado_n_col(id_col))
			this.setitem(1,'nombre_colegiado',f_nombre_colegiado(id_col))
		end if
		this.setitem(1,'id_col',id_col)
END CHOOSE

end event

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event dw_1::itemchanged;call super::itemchanged;choose case dwo.name
	case "n_colegiado"
		this.setitem(1,'nombre_colegiado',f_nombre_colegiado(f_colegiado_id_col(data)))
		this.setitem(1,'id_col', f_colegiado_id_col(data))
END CHOOSE

end event

