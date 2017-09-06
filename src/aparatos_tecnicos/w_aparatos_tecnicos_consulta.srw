HA$PBExportHeader$w_aparatos_tecnicos_consulta.srw
forward
global type w_aparatos_tecnicos_consulta from w_consulta
end type
end forward

global type w_aparatos_tecnicos_consulta from w_consulta
integer x = 214
integer y = 221
integer width = 2112
integer height = 1476
string title = "Consulta de Aparatos T$$HEX1$$e900$$ENDHEX$$cnicos"
end type
global w_aparatos_tecnicos_consulta w_aparatos_tecnicos_consulta

type variables

end variables

on w_aparatos_tecnicos_consulta.create
call super::create
end on

on w_aparatos_tecnicos_consulta.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_aparatos_tecnicos_consulta
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_aparatos_tecnicos_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_aparatos_tecnicos_consulta
integer x = 1559
integer y = 1208
end type

type st_5 from w_consulta`st_5 within w_aparatos_tecnicos_consulta
end type

type cb_1 from w_consulta`cb_1 within w_aparatos_tecnicos_consulta
integer x = 402
integer y = 1208
fontcharset fontcharset = ansi!
end type

event cb_1::clicked;string sql_nuevo
datetime pd, ph

sql_nuevo=g_dw_lista.describe("datawindow.table.select")

dw_1.AcceptText()

f_sql('aparatos_tecnicos.n_equipo','LIKE','n_equipo',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('aparatos_tecnicos.descripcion','LIKE','descripcion',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('aparatos_tecnicos.prestado','LIKE','prestado',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('aparatos_tecnicos.prestable','LIKE','prestable',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('aparatos_tecnicos.f_entrada','>=','f_entrada_desde',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('aparatos_tecnicos.f_entrada','<','f_entrada_hasta',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')

// Pr$$HEX1$$e900$$ENDHEX$$stamos
pd = dw_1.getitemdatetime(1, 'f_prestamo_desde')
ph = dw_1.getitemdatetime(1, 'f_prestamo_hasta')

if not f_es_vacio(string(pd)) or not f_es_vacio(string(ph)) then
	sql_nuevo = f_sql_join(sql_nuevo, {'( aparatos_tecnicos.id_aparato = prestamos.id_aparato )'})
	f_sql('prestamos.f_prestamo','>=','f_prestamo_desde',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
	f_sql('prestamos.f_prestamo','<','f_prestamo_hasta',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
end if

//MessageBox('',sql_nuevo)

g_dw_lista.modify("Datawindow.table.select=~"" + sql_nuevo + "~"")

parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_aparatos_tecnicos_consulta
integer x = 1024
integer y = 1208
end type

type cb_ayuda from w_consulta`cb_ayuda within w_aparatos_tecnicos_consulta
integer x = 1568
integer y = 1208
end type

type dw_1 from w_consulta`dw_1 within w_aparatos_tecnicos_consulta
integer x = 9
integer y = 144
integer width = 2039
integer height = 916
string dataobject = "d_aparatos_tecnicos_consulta"
end type

event dw_1::itemchanged;call super::itemchanged;string id
datetime fp

choose case dwo.name
	//se comprueba que la fecha de prestamo desde sea anterior que la fecha de pretamo hasta	
	case 'f_prestamo_hasta'
		fp = this.GetItemDatetime(this.GetRow(),'f_prestamo_desde')
		if datetime(date(data)) < fp then
			messagebox(g_titulo,'La fecha de prestamo hasta no puede ser anterior a la fecha de pr$$HEX1$$e900$$ENDHEX$$stamo desde.')
			return 1
		end if	
	//se comprueba que la fecha de devolucion real desde sea anterior que la fecha de devolucion real hasta	
	case 'f_devolucion_real_hasta'
		fp = this.GetItemDatetime(this.GetRow(),'f_devolucion_real_desde')
		if datetime(date(data)) < fp then
			messagebox(g_titulo,'La fecha de devoluci$$HEX1$$f300$$ENDHEX$$n real hasta no puede ser anterior a la fecha de devoluci$$HEX1$$f300$$ENDHEX$$n real desde.')
			return 1
		end if	
end choose	

end event

