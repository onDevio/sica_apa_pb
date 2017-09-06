HA$PBExportHeader$w_asesoria_juridica_listados.srw
forward
global type w_asesoria_juridica_listados from w_listados
end type
end forward

global type w_asesoria_juridica_listados from w_listados
string title = "Listados de Asesor$$HEX1$$ed00$$ENDHEX$$a Jur$$HEX1$$ed00$$ENDHEX$$dica"
end type
global w_asesoria_juridica_listados w_asesoria_juridica_listados

on w_asesoria_juridica_listados.create
call super::create
end on

on w_asesoria_juridica_listados.destroy
call super::destroy
end on

event open;call super::open;//Para relacionar los registros que se encuentran en la tabla de listados
dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)
end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_asesoria_juridica_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_asesoria_juridica_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_asesoria_juridica_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_asesoria_juridica_listados
integer x = 2450
integer y = 184
end type

type cb_ver from w_listados`cb_ver within w_asesoria_juridica_listados
end type

event cb_ver::clicked;call super::clicked;string sql
string listado, descripcion

dw_listados.Accepttext()
dw_1.of_SetPrintPreview(TRUE)

//Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
descripcion = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'descripcion')
dw_1.dataobject = listado

dw_1.of_settransobject(sqlca)
sql = dw_1.describe("Datawindow.Table.Select")


CHOOSE CASE upper(listado)
	CASE  upper('d_asesoria_juridica_general_listados')
		//De la tabla asesoria_juridica.
		f_sql('asesoria_juridica.n_asesoria','LIKE','n_asesoria',dw_listados,sql,'1','')
		f_sql('asesoria_juridica.id_col','LIKE','id_col',dw_listados,sql,'1','')
		
		//De la tabla asesoria_juridica.
		f_sql('asesoria_juridica.fecha','=','fecha',dw_listados,sql,'1','')
		f_sql('asesoria_juridica.tipo_asunto','LIKE','tipo_asunto',dw_listados,sql,'1','')
		f_sql('asesoria_juridica.descripcion_asunto','LIKE','descripcion_asunto',dw_listados,sql,'1','')
		f_sql('asesoria_juridica.observaciones','LIKE','observaciones',dw_listados,sql,'1','')
	
		dw_1.SetTransobject(sqlca)
		dw_1.modify("datawindow.table.select= ~"" + sql+ "~"")
		dw_1.retrieve()
	
END CHOOSE


//Al final:
if dw_1.RowCount() > 0 then
	dw_1.event pfc_printpreview()
	dw_1.visible = true
	this.enabled = false
	cb_zoom.enabled = true
	cb_imprimir.enabled = true
	cb_guardar.enabled = true
	cb_escala.enabled  = true
	cb_ordenar.enabled  = true
else
	messagebox(g_titulo,'No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.')
end if	
end event

type cb_salir from w_listados`cb_salir within w_asesoria_juridica_listados
end type

type dw_listados from w_listados`dw_listados within w_asesoria_juridica_listados
integer width = 2395
string dataobject = "d_asesoria_juridica_consulta"
end type

event dw_listados::itemchanged;call super::itemchanged;string id_col,n_col

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

event dw_listados::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event dw_listados::buttonclicked;call super::buttonclicked;string id_col


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

type cb_imprimir from w_listados`cb_imprimir within w_asesoria_juridica_listados
end type

type cb_zoom from w_listados`cb_zoom within w_asesoria_juridica_listados
end type

type cb_esp from w_listados`cb_esp within w_asesoria_juridica_listados
end type

type cb_guardar from w_listados`cb_guardar within w_asesoria_juridica_listados
end type

type cb_escala from w_listados`cb_escala within w_asesoria_juridica_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_asesoria_juridica_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_asesoria_juridica_listados
end type

type dw_1 from w_listados`dw_1 within w_asesoria_juridica_listados
integer width = 3616
integer height = 1448
end type

