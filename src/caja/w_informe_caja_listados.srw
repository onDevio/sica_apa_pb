HA$PBExportHeader$w_informe_caja_listados.srw
forward
global type w_informe_caja_listados from w_listados
end type
end forward

global type w_informe_caja_listados from w_listados
end type
global w_informe_caja_listados w_informe_caja_listados

on w_informe_caja_listados.create
call super::create
end on

on w_informe_caja_listados.destroy
call super::destroy
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

// Se desplaza el apuntador al primer registro
dw_listados_varios.scrolltorow(1)
dw_listados_varios.setfocus()

dw_listados.SetItem(1,'f_desde',datetime(today()))
dw_listados.SetItem(1,'f_hasta',datetime(today()))
//dw_listados.SetItem(1,'centro',f_devuelve_centro(g_cod_delegacion))
//dw_listados.setitem(1,'usuario', g_usuario)

//if f_puedo_escribir(g_usuario, '0000000019')= -1 then  dw_listados.object.usuario.protect = true
end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_informe_caja_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_informe_caja_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_informe_caja_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_informe_caja_listados
end type

type cb_ver from w_listados`cb_ver within w_informe_caja_listados
end type

event cb_ver::clicked;call super::clicked;datetime f_desde,f_hasta
string centro, usuario
string listado,sql,sql_nuevo

dw_listados.Accepttext()
dw_1.of_SetPrintPreview(TRUE)

//Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado

dw_1.of_settransobject(sqlca)
centro=dw_listados.GetItemString(1,'centro')
f_desde=datetime(date(dw_listados.GetItemDateTime(1,'f_desde')), time('00:00:00'))
f_hasta=datetime(date(dw_listados.GetItemDateTime(1,'f_hasta')), time('23:59:59'))

if isnull(centro) or centro = '' then centro = '%'
	
	dw_1.retrieve(f_desde,f_hasta, centro)
	if dw_1.rowcount()>0 then
		dw_1.visible = true
		// No se puede hacer un printpreview de un composite
		if dw_1.Describe("DataWindow.Nested") = "no" then dw_1.event pfc_printpreview()
		this.enabled = false
		cb_zoom.enabled = true
		cb_imprimir.enabled = true
		cb_guardar.enabled = true
		cb_escala.enabled  = true
		cb_ordenar.enabled  = true
		// Devuelvo el estado normal
		setpointer(arrow!)
	else
		// Devuelvo el estado normal
		setpointer(arrow!)
		messagebox(g_titulo,'No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.')
	end if	
	dw_1.modify("datawindow.table.select= ~"" + sql + "~"")	
	

		

end event

type cb_salir from w_listados`cb_salir within w_informe_caja_listados
end type

type dw_listados from w_listados`dw_listados within w_informe_caja_listados
integer y = 232
integer height = 184
string dataobject = "d_informe_caja_listados_consulta"
end type

type cb_imprimir from w_listados`cb_imprimir within w_informe_caja_listados
end type

type cb_zoom from w_listados`cb_zoom within w_informe_caja_listados
end type

type cb_esp from w_listados`cb_esp within w_informe_caja_listados
end type

type cb_guardar from w_listados`cb_guardar within w_informe_caja_listados
end type

type cb_escala from w_listados`cb_escala within w_informe_caja_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_informe_caja_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_informe_caja_listados
end type

type dw_1 from w_listados`dw_1 within w_informe_caja_listados
end type

