HA$PBExportHeader$w_administrativa_judicial_listados.srw
forward
global type w_administrativa_judicial_listados from w_listados
end type
end forward

global type w_administrativa_judicial_listados from w_listados
integer width = 4155
integer height = 1756
string title = "LISTADOS DE ADMINISTRATIVA Y JUDICIAL"
end type
global w_administrativa_judicial_listados w_administrativa_judicial_listados

on w_administrativa_judicial_listados.create
call super::create
end on

on w_administrativa_judicial_listados.destroy
call super::destroy
end on

event open;call super::open;//Para relacionar los registros que se encuentran en la tabla de listados
dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)
end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_administrativa_judicial_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_administrativa_judicial_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_administrativa_judicial_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_administrativa_judicial_listados
integer x = 2857
integer y = 156
integer width = 1189
integer height = 796
end type

type cb_ver from w_listados`cb_ver within w_administrativa_judicial_listados
end type

event cb_ver::clicked;call super::clicked;string sql
string listado

dw_listados.Accepttext()
dw_1.of_SetPrintPreview(TRUE)

//Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado

dw_1.of_settransobject(sqlca)
sql = dw_1.describe("Datawindow.Table.Select")

//De la tabla fases debemos comprobar : n_expedi,n_registro
f_sql('fases.n_expedi','LIKE','n_expediente',dw_listados,sql,'1','')
f_sql('fases.n_registro','LIKE','n_registro',dw_listados,sql,'1','')

//De la tabla fases_administrativa_judicial debemos comprobar los parametros de la consulta
f_sql('fases_administrativa_judicial.n_interno','LIKE','n_administrativo',dw_listados,sql,'1','')
f_sql('fases_administrativa_judicial.n_musaat','LIKE','n_musaat',dw_listados,sql,'1','')

f_sql('fases_administrativa_judicial.fecha','>=','fecha_registro_desde',dw_listados,sql,'1','')
f_sql('fases_administrativa_judicial.fecha','<','fecha_registro_hasta',dw_listados,sql,'1','')

f_sql('fases_administrativa_judicial.fecha_cierre','>=','fecha_cierre_desde',dw_listados,sql,'1','')
f_sql('fases_administrativa_judicial.fecha_cierre','<','fecha_cierre_hasta',dw_listados,sql,'1','')
f_sql('fases_administrativa_judicial.autos','LIKE','autos',dw_listados,sql,'1','')
f_sql('fases_administrativa_judicial.juzgado','LIKE','juzgado',dw_listados,sql,'1','')

f_sql('fases_administrativa_judicial.procurador','LIKE','procurador',dw_listados,sql,'1','')
f_sql('fases_administrativa_judicial.tipo_reclamacion','LIKE','tipo_reclamacion',dw_listados,sql,'1','')

dw_1.SetTransobject(sqlca)
dw_1.modify("datawindow.table.select= ~"" + sql+ "~"")
dw_1.retrieve()

//Al final:
if dw_1.RowCount() > 0 then
	dw_1.event pfc_printpreview()
	dw_1.visible = true
	this.enabled = false
	cb_zoom.enabled = true
	cb_imprimir.enabled = true
	cb_guardar.enabled = true
	cb_escala.enabled  = true
	cb_ordenar.enabled=true
else
	messagebox(g_titulo,'No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.')
end if	
end event

type cb_salir from w_listados`cb_salir within w_administrativa_judicial_listados
end type

type dw_listados from w_listados`dw_listados within w_administrativa_judicial_listados
integer x = 27
integer y = 200
integer width = 2811
integer height = 908
string dataobject = "d_administrativa_judicial_consulta"
end type

event dw_listados::itemchanged;call super::itemchanged;string id_col,n_col

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

event dw_listados::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event dw_listados::buttonclicked;call super::buttonclicked;string id_col


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

type cb_imprimir from w_listados`cb_imprimir within w_administrativa_judicial_listados
end type

type cb_zoom from w_listados`cb_zoom within w_administrativa_judicial_listados
end type

type cb_esp from w_listados`cb_esp within w_administrativa_judicial_listados
end type

type cb_guardar from w_listados`cb_guardar within w_administrativa_judicial_listados
end type

type cb_escala from w_listados`cb_escala within w_administrativa_judicial_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_administrativa_judicial_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_administrativa_judicial_listados
end type

type dw_1 from w_listados`dw_1 within w_administrativa_judicial_listados
integer width = 4078
end type

