HA$PBExportHeader$w_clientes_listados.srw
forward
global type w_clientes_listados from w_listados
end type
end forward

global type w_clientes_listados from w_listados
string title = "Listados de Terceros"
end type
global w_clientes_listados w_clientes_listados

on w_clientes_listados.create
call super::create
end on

on w_clientes_listados.destroy
call super::destroy
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1) 


end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_clientes_listados
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_clientes_listados
string tag = "texto=general.guardar_pantalla"
end type

type cb_limpiar from w_listados`cb_limpiar within w_clientes_listados
string tag = "texto=general.limpiar_consulta"
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_clientes_listados
end type

type cb_ver from w_listados`cb_ver within w_clientes_listados
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
//messagebox('kk', sql)
//Hacer f_sql de todos los campos de la dw_listados
f_sql('clientes.n_cliente','LIKE','num_cliente',dw_listados,sql,'1','')
f_sql('clientes.nif','LIKE','nif',dw_listados,sql,'1','')
f_sql('clientes.apellidos','LIKE','apellidos_sociedad',dw_listados,sql,'1','')
f_sql('clientes.nombre','LIKE','nombre',dw_listados,sql,'1','')
f_sql('clientes.tipo_persona','LIKE','tipo_persona',dw_listados,sql,'1','')
f_sql('clientes.nombre_via','LIKE','nom_via',dw_listados,sql,'1','')
f_sql('clientes.cod_pob','LIKE','poblacion',dw_listados,sql,'1','')
f_sql('clientes_terceros.c_tercero','LIKE','c_tercero',dw_listados,sql,'1','')
f_sql('clientes.n_cliente','LIKE','num_cliente',dw_listados,sql,'1','')
f_sql('clientes.cuenta_contable','LIKE','cuenta_contable',dw_listados,sql,'1','')

if not f_es_vacio(dw_listados.getitemstring(1, 'c_tercero')) then
	sql = f_sql_join(sql, {'( clientes.id_cliente = clientes_terceros.id_cliente )'})
	f_sql('clientes_terceros.c_tercero','LIKE','c_tercero',dw_listados,sql,'1','')
end if

if PosA(upper(sql), "WHERE") > 0 then
	if not isnull(dw_listados.getitemstring(1,'lista_clientes')) then
		sql = sql + "and clientes.nif IN ("+f_coloca_comillas(dw_listados.getitemstring(1,'lista_clientes'))+")"
	end if
else
	if not isnull(dw_listados.getitemstring(1,'lista_clientes')) then
		sql = sql + "WHERE clientes.nif IN ("+f_coloca_comillas(dw_listados.getitemstring(1,'lista_clientes'))+")"
	end if
end if

sql+= " and clientes.empresa ='" + g_empresa + "'"

//messagebox('kk', sql)

dw_1.SetTransobject(sqlca)
dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
dw_1.retrieve()

//Al final:
if dw_1.RowCount() > 0 then
	// No tiene reports y no son etiquetas, hacemos el preview
	if dw_1.Describe("DataWindow.Nested") = "no" and dw_1.describe("Datawindow.Label.Columns") = "0" then
		dw_1.event pfc_printpreview()
	end if
	dw_1.visible = true
	this.enabled = false
	cb_zoom.enabled = true
	cb_imprimir.enabled = true
	cb_guardar.enabled = true
	cb_escala.enabled  = true
	cb_ordenar.enabled  = true
else
	messagebox(g_titulo,g_idioma.of_getmsg('msg_cliente.registros_especif','No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.'))
end if	


end event

type cb_salir from w_listados`cb_salir within w_clientes_listados
end type

type dw_listados from w_listados`dw_listados within w_clientes_listados
string dataobject = "d_clientes_consulta"
end type

event dw_listados::buttonclicked;call super::buttonclicked;string pob
choose case dwo.name
	CASE 'b_pob'
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(1,'poblacion',pob)
//		this.event itemchanged(1, this.object.cod_pob, pob)
	case 'b_listas'
		Open(w_listas_seleccion)		
		this.SetItem(1,'lista_cliente_texto',Message.Stringparm)
end choose
end event

type cb_imprimir from w_listados`cb_imprimir within w_clientes_listados
integer y = 32
end type

type cb_zoom from w_listados`cb_zoom within w_clientes_listados
end type

type cb_esp from w_listados`cb_esp within w_clientes_listados
end type

type cb_guardar from w_listados`cb_guardar within w_clientes_listados
end type

type cb_escala from w_listados`cb_escala within w_clientes_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_clientes_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_clientes_listados
end type

type dw_1 from w_listados`dw_1 within w_clientes_listados
integer y = 128
integer width = 3602
integer height = 1472
end type

event dw_1::retrievestart;call super::retrievestart;// Indicamos que queremos cambiar el idioma
if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)
end event

