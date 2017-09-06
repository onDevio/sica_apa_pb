HA$PBExportHeader$w_siniestros_listados.srw
forward
global type w_siniestros_listados from w_listados
end type
end forward

global type w_siniestros_listados from w_listados
integer width = 3771
integer height = 1748
string title = "Listados de Siniestros"
end type
global w_siniestros_listados w_siniestros_listados

on w_siniestros_listados.create
call super::create
end on

on w_siniestros_listados.destroy
call super::destroy
end on

event open;call super::open;
//Para relacionar los registros que se encuentran en la tabla de listados
dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)
end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_siniestros_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_siniestros_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_siniestros_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_siniestros_listados
integer x = 2670
integer y = 168
integer width = 1038
integer height = 1196
end type

type cb_ver from w_listados`cb_ver within w_siniestros_listados
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
f_sql('fases.emplazamiento','LIKE','emplazamiento_obra',dw_listados,sql,'1','')

//De la tabla fases_siniestros debemos comprobar los parametros de la consulta
f_sql('fases_siniestros.n_interno','LIKE','n_siniestro',dw_listados,sql,'1','')
f_sql('fases_siniestros.n_musaat','LIKE','n_siniestro_musaat',dw_listados,sql,'1','')
f_sql('fases_siniestros.constructor','LIKE','nombre_constructor',dw_listados,sql,'1','')
f_sql('fases_siniestros.fecha','>=','fecha_registro_desde',dw_listados,sql,'1','')
f_sql('fases_siniestros.fecha','<','fecha_registro_hasta',dw_listados,sql,'1','')

f_sql('fases_siniestros.fecha_siniestro','>=','fecha_siniestro_desde',dw_listados,sql,'1','')
f_sql('fases_siniestros.fecha_siniestro','<','fecha_siniestro_hasta',dw_listados,sql,'1','')

f_sql('fases_siniestros.fecha_cierre','>=','fecha_cierre_desde',dw_listados,sql,'1','')
f_sql('fases_siniestros.fecha_cierre','<','fecha_cierre_hasta',dw_listados,sql,'1','')


f_sql('fases_siniestros.tipo_danyos','LIKE','tipo_danyos',dw_listados,sql,'1','')
f_sql('fases_siniestros.tipo_estado_obra','LIKE','tipo_estado_obra',dw_listados,sql,'1','')
f_sql('fases_siniestros.importe_danyos','>=','importe_desde',dw_listados,sql,'1','')
f_sql('fases_siniestros.importe_danyos','<','importe_hasta',dw_listados,sql,'1','')

f_sql('fases_siniestros.fecha_siniestro','>=','fecha_siniestro_desde',dw_listados,sql,'1','')
f_sql('fases_siniestros.fecha_siniestro','<','fecha_siniestro_hasta',dw_listados,sql,'1','')


f_sql('fases_siniestros.autos','LIKE','autos',dw_listados,sql,'1','')
f_sql('fases_siniestros.juzgado','LIKE','juzgado',dw_listados,sql,'1','')

f_sql('fases_siniestros.promotor','LIKE','nombre_promotor',dw_listados,sql,'1','')
f_sql('fases_siniestros.procurador','LIKE','procurador',dw_listados,sql,'1','')

if (not f_es_vacio(dw_listados.getitemstring(1, 'n_colegiado')) OR not f_es_vacio(dw_listados.getitemstring(1, 'src_cia')) )  then
	sql = f_sql_join(sql, {'( fases_siniestros.id_siniestro = fases_siniestros_coles.id_siniestro )'})
	if not f_es_vacio(dw_listados.getitemstring(1, 'n_colegiado')) then f_sql('fases_siniestros_coles.id_colegiado','=','id_col',dw_listados,sql,'1','')
	if not f_es_vacio(dw_listados.getitemstring(1, 'src_cia')) then
		f_sql('fases_siniestros_coles.src_cia','=','src_cia',dw_listados,sql,'1','')
		if f_es_vacio(dw_listados.getitemstring(1, 'n_colegiado')) then sql = Replace (sql,1,7,'SELECT DISTINCT ')
	end if
end if

dw_1.SetTransobject(sqlca)
dw_1.modify("datawindow.table.select= ~"" + sql+ "~"")
dw_1.retrieve()

if listado = 'd_siniestros_designacion_letrado_gc' then
	int i
	for i=1 to dw_1.rowcount()
		dw_1.setitem(i, 'asegurado', f_siniestros_obtener_asociados(dw_1.getitemstring(i, 'fases_siniestros_id_siniestro'),'N'))
		dw_1.setitem(i, 'telefono', f_siniestros_telefonos_asegurados(dw_1.getitemstring(i, 'fases_siniestros_id_siniestro')))
		dw_1.setitem(i, 'ubicacion', f_dame_direccion_contrato(dw_1.getitemstring(i, 'fases_id_fase')))
		dw_1.setItem(i, 'lugar_fecha', 'En Las Palmas de Gran Canaria, a '+string(day(today()))+' de ' + &
		lower(f_obtener_mes(datetime(today())))+' de '+string(year(today())))
	next
end if



//Al final:
if dw_1.RowCount() > 0 then
	// No tiene reports, hacer el printpreview
	if dw_1.Describe("DataWindow.Nested") = "no" and listado <> 'd_siniestros_designacion_letrado_gc' then dw_1.event pfc_printpreview()
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

type cb_salir from w_listados`cb_salir within w_siniestros_listados
end type

type dw_listados from w_listados`dw_listados within w_siniestros_listados
integer x = 14
integer y = 156
integer width = 2642
integer height = 1240
string dataobject = "d_siniestros_consulta"
end type

event dw_listados::buttonclicked;call super::buttonclicked;string id_col,n_col,desc_pob
string pob

choose case dwo.name
	case "b_busca_colegiado"
  		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()   
		if NOT f_es_vacio(id_col)  then
			this.setitem(1,'n_colegiado',f_colegiado_n_col(id_col))
			this.setitem(1,'nombre_apellidos_colegiado',f_nombre_colegiado(id_col))
		end if
		this.setitem(1,'id_col',id_col)		
	CASE 'b_busca_poblacion'
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		desc_pob=f_dame_poblacion(pob)
		if f_es_vacio(pob) then return
		if f_es_vacio(desc_pob) then return
		this.SetItem(1,'poblacion',pob)
		this.SetItem(1,'desc_poblacion',desc_pob)

END CHOOSE
end event

event dw_listados::itemchanged;call super::itemchanged;choose case dwo.name
	case "n_colegiado"
		this.setitem(1,'nombre_apellidos_colegiado',f_nombre_colegiado(f_colegiado_id_col(data)))
		this.setitem(1,'id_col',f_colegiado_id_col(data))
		
	CASE "poblacion"
		this.setitem(1,'desc_poblacion',f_poblacion_descripcion(data))
END CHOOSE
end event

type cb_imprimir from w_listados`cb_imprimir within w_siniestros_listados
end type

type cb_zoom from w_listados`cb_zoom within w_siniestros_listados
end type

type cb_esp from w_listados`cb_esp within w_siniestros_listados
end type

type cb_guardar from w_listados`cb_guardar within w_siniestros_listados
end type

type cb_escala from w_listados`cb_escala within w_siniestros_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_siniestros_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_siniestros_listados
end type

type dw_1 from w_listados`dw_1 within w_siniestros_listados
integer width = 3703
end type

