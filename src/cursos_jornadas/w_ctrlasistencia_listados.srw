HA$PBExportHeader$w_ctrlasistencia_listados.srw
forward
global type w_ctrlasistencia_listados from w_listados
end type
end forward

global type w_ctrlasistencia_listados from w_listados
string title = "Listados de Control de Asistencia"
end type
global w_ctrlasistencia_listados w_ctrlasistencia_listados

on w_ctrlasistencia_listados.create
call super::create
end on

on w_ctrlasistencia_listados.destroy
call super::destroy
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

// Se desplaza el apuntador al primer registro
dw_listados_varios.scrolltorow(1)
dw_listados_varios.setfocus()

end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_ctrlasistencia_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_ctrlasistencia_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_ctrlasistencia_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_ctrlasistencia_listados
end type

type cb_ver from w_listados`cb_ver within w_ctrlasistencia_listados
fontcharset fontcharset = ansi!
end type

event cb_ver::clicked;call super::clicked;string sql, listado,descripcion,id_persona

dw_listados.AcceptText()
dw_1.of_setprintpreview(TRUE)

// Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado

dw_1.of_SetTransObject(SQLCA)
sql = dw_1.describe("datawindow.table.select")

// Se asigna el titulo del informe con la descripcion
descripcion=dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'descripcion')



//Hacer f_sql de todos los campos de la dw_listados de forma analoga a la ventana de consulta

f_sql('formacion_ctrl_asistencia.id_curso','LIKE','id_curso',parent.dw_listados,sql,g_tipo_base_datos,'')
//f_sql('fecha','>=','f_desde',parent.dw_listados,sql,g_tipo_base_datos,'')
//f_sql('fecha','<=','f_hasta',parent.dw_listados,sql,g_tipo_base_datos,'')
//


dw_1.SetTransobject(sqlca)
dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
dw_1.retrieve()

// Al final:
if dw_1.rowcount() > 0 then
	dw_1.visible 		  = true
	dw_1.event pfc_printpreview()
	this.enabled        = false
	cb_zoom.enabled     = true
	cb_imprimir.enabled = true
	cb_guardar.enabled  = true
	cb_ordenar.enabled  = true
else
	messagebox(g_titulo,'No se han encontrados registros segun las especificaciones.')
end if

end event

type cb_salir from w_listados`cb_salir within w_ctrlasistencia_listados
end type

type dw_listados from w_listados`dw_listados within w_ctrlasistencia_listados
string dataobject = "d_ctrlasistencia_listados_consulta"
end type

event dw_listados::csd_oculta;call super::csd_oculta;string  dwactual, descactual
integer nro_opcion

dwactual  = dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'dw')
descactual= dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'descripcion')
nro_opcion= dw_listados_varios.getrow()

// Se oculta la opcion del tipo de registro del dw de consulta  por presentar la de Listados
//dw_listados.object.es.visible				= false // la de consulta
//dw_listados.object.es_listados.visible	= True // la de listados
//
// aqui va el campo por donde se filtrara
// this.object.departamento.visible   = (pos("d_listado_1 d_listado_2", lower(dwactual)) > 1)
// this.object.departamento_t.visible = this.object.departamento.visible
//
//CHOOSE CASE nro_opcion
//		
//	CASE 1
////		dw_listados.object.b_nombre.visible  	= true
//		dw_listados.object.b_apellidos.visible = true
//		dw_listados.object.nombre_t.visible    = true
//		dw_listados.object.nombre.visible  		= true
//		dw_listados.object.apellidos_t.visible = true
//		dw_listados.object.apellidos.visible   = true
//		dw_listados.object.asignatura_t.visible= false		
//		dw_listados.object.id_asignatura.visible  = false
//		dw_listados.object.grupo_t.visible= false		
//		dw_listados.object.id_grupo.visible  = false
	
	
//end choose
end event

type cb_imprimir from w_listados`cb_imprimir within w_ctrlasistencia_listados
end type

type cb_zoom from w_listados`cb_zoom within w_ctrlasistencia_listados
end type

type cb_esp from w_listados`cb_esp within w_ctrlasistencia_listados
end type

type cb_guardar from w_listados`cb_guardar within w_ctrlasistencia_listados
end type

type cb_escala from w_listados`cb_escala within w_ctrlasistencia_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_ctrlasistencia_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_ctrlasistencia_listados
end type

type dw_1 from w_listados`dw_1 within w_ctrlasistencia_listados
end type

