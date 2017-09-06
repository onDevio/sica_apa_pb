HA$PBExportHeader$w_jg_reuniones_consulta.srw
forward
global type w_jg_reuniones_consulta from w_consulta
end type
end forward

global type w_jg_reuniones_consulta from w_consulta
integer width = 1961
integer height = 1056
string title = "Consulta de Junta de Gobierno"
end type
global w_jg_reuniones_consulta w_jg_reuniones_consulta

on w_jg_reuniones_consulta.create
call super::create
end on

on w_jg_reuniones_consulta.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_jg_reuniones_consulta
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_jg_reuniones_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_jg_reuniones_consulta
end type

type st_5 from w_consulta`st_5 within w_jg_reuniones_consulta
end type

type cb_1 from w_consulta`cb_1 within w_jg_reuniones_consulta
integer x = 247
integer y = 844
end type

event cb_1::clicked;call super::clicked;string sql_nuevo
SetPointer(HourGlass!)
sql_nuevo = g_dw_lista.describe("datawindow.table.select")

f_sql('jg_reuniones.fecha','>=','f_desde',dw_1,sql_nuevo,'1','')
f_sql('jg_reuniones.fecha','<','f_hasta',dw_1,sql_nuevo,'1','')
f_sql('jg_reuniones.tipo','LIKE','tipo',dw_1,sql_nuevo,'1','')
f_sql('jg_reuniones.tema','LIKE','tema',dw_1,sql_nuevo,'1','')
f_sql('jg_reuniones.lugar','LIKE','lugar',dw_1,sql_nuevo,'1','')

g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")

Parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_jg_reuniones_consulta
integer x = 955
integer y = 848
end type

type cb_ayuda from w_consulta`cb_ayuda within w_jg_reuniones_consulta
end type

type dw_1 from w_consulta`dw_1 within w_jg_reuniones_consulta
integer x = 37
integer y = 136
integer width = 1874
integer height = 484
string dataobject = "d_jg_reuniones_consulta"
end type

event dw_1::itemchanged;call super::itemchanged;choose case dwo.name
	case 'mes'
		datetime f_desde
		string mes
		mes = data
		
		f_desde = datetime(date('01/'+mes+'/'+string(year(today()))), time('00:00:00'))
		this.setitem(1, 'f_desde', f_desde)
		this.setitem(1, 'f_hasta', f_ultimo_dia_mes(f_desde))
		
end choose
end event

