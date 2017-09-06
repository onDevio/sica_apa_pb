HA$PBExportHeader$w_reparos_listados.srw
forward
global type w_reparos_listados from w_listados
end type
end forward

global type w_reparos_listados from w_listados
string title = "Listados de Reparos"
end type
global w_reparos_listados w_reparos_listados

on w_reparos_listados.create
call super::create
end on

on w_reparos_listados.destroy
call super::destroy
end on

event open;call super::open;
dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

// Se desplaza el apuntador al primer registro
dw_listados_varios.scrolltorow(1)
dw_listados_varios.setfocus()

end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_reparos_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_reparos_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_reparos_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_reparos_listados
end type

type cb_ver from w_listados`cb_ver within w_reparos_listados
end type

event cb_ver::clicked;call super::clicked;string sql, listado,descripcion, n_colegiado,  n_reg

// dw_1.accepttext()
dw_listados.accepttext()
dw_1.of_setprintpreview(TRUE)

// Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado

dw_1.of_SetTransObject(SQLCA)
sql = dw_1.describe("datawindow.table.select")

// Se asigna el titulo del informe con la descripcion
descripcion=dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'descripcion')
dw_1.object.st_titulo_listado.text = descripcion

//Se inicializan los id de Colegiado y cliente para no alterar el sql
dw_listados.setitem(1,'id_col','')
dw_listados.setitem(1,'id_registro','')

n_colegiado = dw_listados.getitemstring(1,'n_colegiado')
if not f_es_vacio(n_colegiado) then
	dw_listados.setitem(1,'id_col',f_busca_id_colegiado_por_codigo(n_colegiado))
end if	

n_reg = dw_listados.getitemstring(1,'n_registro')
if not f_es_vacio(n_reg) then
	dw_listados.setitem(1,'id_registro',f_devuelve_id_fase_por_num(n_reg))
end if	

//Hacer f_sql de todos los campos de la dw_listados de forma analoga a la ventana de consulta
f_sql('fases_reparos.id_fase','LIKE','id_registro',dw_listados,sql,g_tipo_base_datos,'N. Registro')
f_sql('fases_reparos.tipo_reparo','LIKE','tipo_reparo',dw_listados,sql,g_tipo_base_datos,'Tipo Reparo')
f_sql('fases_reparos.id_col','LIKE','id_col',dw_listados,sql,g_tipo_base_datos,'N. Colegiado')
f_sql('fases_reparos.usuario','LIKE','usuario',dw_listados,sql,g_tipo_base_datos,'Usuario')
f_sql('fases_reparos.notificado','LIKE','notificado',dw_listados,sql,g_tipo_base_datos,'Notif. Carta')
f_sql('fases_reparos.email','LIKE','email',dw_listados,sql,g_tipo_base_datos,'Notif. Email')
f_sql('fases_reparos.f_emision','>=','f_emision_desde',dw_listados,sql,g_tipo_base_datos,'Fecha Emisi$$HEX1$$f300$$ENDHEX$$n desde')
f_sql('fases_reparos.f_emision','<','f_emision_hasta',dw_listados,sql,g_tipo_base_datos,'Fecha Emisi$$HEX1$$f300$$ENDHEX$$n hasta')
f_sql('fases_reparos.f_subsanacion','>=','fecha_subsanacion_desde',dw_listados,sql,g_tipo_base_datos,'Fecha Subsan. desde')
f_sql('fases_reparos.f_subsanacion','<','fecha_subsanacion_hasta',dw_listados,sql,g_tipo_base_datos,'Fecha Subsan. hasta')


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
	cb_escala.enabled  = true
	cb_ordenar.enabled  = true
else
	messagebox(g_titulo,'No se han encontrados registros segun las especificaciones.')
end if

end event

type cb_salir from w_listados`cb_salir within w_reparos_listados
end type

type dw_listados from w_listados`dw_listados within w_reparos_listados
string dataobject = "d_reparos_consulta"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event dw_listados::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event dw_listados::buttonclicked;call super::buttonclicked;string id_persona,id_fase

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

type cb_imprimir from w_listados`cb_imprimir within w_reparos_listados
end type

type cb_zoom from w_listados`cb_zoom within w_reparos_listados
end type

type cb_esp from w_listados`cb_esp within w_reparos_listados
end type

type cb_guardar from w_listados`cb_guardar within w_reparos_listados
end type

type cb_escala from w_listados`cb_escala within w_reparos_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_reparos_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_reparos_listados
end type

type dw_1 from w_listados`dw_1 within w_reparos_listados
integer x = 37
integer width = 3602
end type

