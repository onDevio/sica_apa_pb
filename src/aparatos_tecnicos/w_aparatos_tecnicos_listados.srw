HA$PBExportHeader$w_aparatos_tecnicos_listados.srw
forward
global type w_aparatos_tecnicos_listados from w_listados
end type
end forward

global type w_aparatos_tecnicos_listados from w_listados
string title = "Listados de Aparatos T$$HEX1$$e900$$ENDHEX$$cnicos"
end type
global w_aparatos_tecnicos_listados w_aparatos_tecnicos_listados

on w_aparatos_tecnicos_listados.create
call super::create
end on

on w_aparatos_tecnicos_listados.destroy
call super::destroy
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

// Se desplaza el apuntador al primer registro
dw_listados_varios.scrolltorow(1)
dw_listados_varios.setfocus()

end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_aparatos_tecnicos_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_aparatos_tecnicos_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_aparatos_tecnicos_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_aparatos_tecnicos_listados
end type

type cb_ver from w_listados`cb_ver within w_aparatos_tecnicos_listados
end type

event cb_ver::clicked;call super::clicked;string sql, listado
datetime pd, ph

dw_listados.accepttext()
dw_1.of_setprintpreview(TRUE)

// Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado

dw_1.of_SetTransObject(SQLCA)
sql = dw_1.describe("datawindow.table.select")


f_sql('aparatos_tecnicos.n_equipo','LIKE','n_equipo',parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('aparatos_tecnicos.descripcion','LIKE','descripcion',parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('aparatos_tecnicos.prestado','LIKE','prestado',parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('aparatos_tecnicos.prestable','LIKE','prestable',parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('aparatos_tecnicos.f_entrada','>=','f_entrada_desde',parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('aparatos_tecnicos.f_entrada','<','f_entrada_hasta',parent.dw_listados,sql,g_tipo_base_datos,'')

// Pr$$HEX1$$e900$$ENDHEX$$stamos
pd = dw_listados.getitemdatetime(1, 'f_prestamo_desde')
ph = dw_listados.getitemdatetime(1, 'f_prestamo_hasta')

if not f_es_vacio(string(pd)) or not f_es_vacio(string(ph)) then
	sql = f_sql_join(sql, {'( aparatos_tecnicos.id_aparato = prestamos.id_aparato )'})
	f_sql('prestamos.f_prestamo','>=','f_prestamo_desde',parent.dw_listados,sql,g_tipo_base_datos,'')
	f_sql('prestamos.f_prestamo','<','f_prestamo_hasta',parent.dw_listados,sql,g_tipo_base_datos,'')
end if


dw_1.SetTransobject(sqlca)
dw_1.modify("datawindow.table.select= ~"" + sql+ "~"")
dw_1.retrieve()

if dw_1.rowcount() > 0 then
	dw_1.visible 		  = true
	dw_1.event pfc_printpreview()
	this.enabled        = false
	cb_zoom.enabled     = true
	cb_imprimir.enabled = true
	cb_guardar.enabled  = true
	cb_escala.enabled  = true
	cb_ordenar.enabled  = true
else
	messagebox(g_titulo,'No se han encontrados registros segun las especificaciones.')
end if

end event

type cb_salir from w_listados`cb_salir within w_aparatos_tecnicos_listados
end type

type dw_listados from w_listados`dw_listados within w_aparatos_tecnicos_listados
integer y = 204
integer width = 2048
integer height = 896
string dataobject = "d_aparatos_tecnicos_consulta"
boolean ib_isupdateable = false
end type

event dw_listados::itemchanged;call super::itemchanged;datetime fp, fd

choose case dwo.name
	//se comprueba que la fecha de pr$$HEX1$$e900$$ENDHEX$$stamo desde sea anterior que la fecha de pr$$HEX1$$e900$$ENDHEX$$stamo hasta	
	case 'f_prestamo_hasta'
		fp = this.GetItemDatetime(this.GetRow(),'f_prestamo_desde')
		if datetime(date(data)) < fp then
			messagebox(g_titulo,'La fecha de prestamo hasta no puede ser anterior a la fecha de pr$$HEX1$$e900$$ENDHEX$$stamo desde.')
			return 1
		end if	
		
	//se comprueba que la fecha de devolucion real desde sea anterior que la fecha de devolucion real hasta	
	case 'f_devolucion_real_hasta'
		fd = this.GetItemDatetime(this.GetRow(),'f_devolucion_real_desde')
		if datetime(date(data)) < fd then
			messagebox(g_titulo,'La fecha de devoluci$$HEX1$$f300$$ENDHEX$$n real hasta no puede ser anterior a la fecha de devoluci$$HEX1$$f300$$ENDHEX$$n real desde.')
			return 1
		end if	
end choose	

end event

type cb_imprimir from w_listados`cb_imprimir within w_aparatos_tecnicos_listados
end type

type cb_zoom from w_listados`cb_zoom within w_aparatos_tecnicos_listados
end type

type cb_esp from w_listados`cb_esp within w_aparatos_tecnicos_listados
end type

type cb_guardar from w_listados`cb_guardar within w_aparatos_tecnicos_listados
end type

type cb_escala from w_listados`cb_escala within w_aparatos_tecnicos_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_aparatos_tecnicos_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_aparatos_tecnicos_listados
end type

type dw_1 from w_listados`dw_1 within w_aparatos_tecnicos_listados
integer width = 3616
end type

