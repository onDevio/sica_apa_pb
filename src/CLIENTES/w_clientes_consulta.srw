HA$PBExportHeader$w_clientes_consulta.srw
forward
global type w_clientes_consulta from w_consulta
end type
end forward

global type w_clientes_consulta from w_consulta
integer width = 2226
integer height = 1460
string title = "Consulta de Terceros"
end type
global w_clientes_consulta w_clientes_consulta

on w_clientes_consulta.create
call super::create
end on

on w_clientes_consulta.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_clientes_consulta
string tag = "text=general.recuperar_pantalla"
integer x = 2158
integer y = 716
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_clientes_consulta
string tag = "texto=general.guardar_pantalla"
integer x = 2158
integer y = 836
end type

type cb_limpiar from w_consulta`cb_limpiar within w_clientes_consulta
string tag = "texto=general.limpiar_consulta"
integer x = 2158
integer y = 1120
end type

type st_5 from w_consulta`st_5 within w_clientes_consulta
string tag = "texto=clientes.int_param_consulta_aceptar"
end type

type cb_1 from w_consulta`cb_1 within w_clientes_consulta
integer x = 475
integer y = 1216
integer width = 517
end type

event cb_1::clicked;call super::clicked;string sql_nuevo
SetPointer(HourGlass!)
sql_nuevo = g_dw_lista.describe("datawindow.table.select")

f_sql('clientes.n_cliente','LIKE','num_cliente',dw_1,sql_nuevo,'1','')
f_sql('clientes.nif','LIKE','nif',dw_1,sql_nuevo,'1','')
f_sql('clientes.apellidos','LIKE','apellidos_sociedad',dw_1,sql_nuevo,'1','')
f_sql('clientes.nombre','LIKE','nombre',dw_1,sql_nuevo,'1','')
f_sql('clientes.tipo_persona','LIKE','tipo_persona',dw_1,sql_nuevo,'1','')
f_sql('clientes.nombre_via','LIKE','nom_via',dw_1,sql_nuevo,'1','')
f_sql('clientes.cod_pob','LIKE','poblacion',dw_1,sql_nuevo,'1','')
f_sql('clientes.visible_web','LIKE','visible_web',dw_1,sql_nuevo,'1','')
f_sql('clientes.n_cliente','LIKE','num_cliente',dw_1,sql_nuevo,'1','')
f_sql('clientes.cuenta_contable','LIKE','cuenta_contable',dw_1,sql_nuevo,'1','')

if not f_es_vacio(dw_1.getitemstring(1, 'c_tercero')) then
	sql_nuevo = f_sql_join(sql_nuevo, {'( clientes.id_cliente = clientes_terceros.id_cliente )'})
	f_sql('clientes_terceros.c_tercero','LIKE','c_tercero',dw_1,sql_nuevo,'1','')
end if

if PosA(upper(sql_nuevo), "WHERE") > 0 then
	if not isnull(dw_1.getitemstring(1,'lista_clientes')) then
		sql_nuevo = sql_nuevo + "and clientes.nif IN ("+f_coloca_comillas(dw_1.getitemstring(1,'lista_clientes'))+")"
	end if
else
	if not isnull(dw_1.getitemstring(1,'lista_clientes')) then
		sql_nuevo = sql_nuevo + "WHERE clientes.nif IN ("+f_coloca_comillas(dw_1.getitemstring(1,'lista_clientes'))+")"
	end if
end if

if PosA(upper(sql_nuevo), "WHERE") > 0 then
	if g_activa_multiempresa='S' and g_clientes_utiliza_multiempresa='S' then
		sql_nuevo += " AND clientes.empresa = '" + g_empresa + "'"
	end if
else
	if g_activa_multiempresa='S' and g_clientes_utiliza_multiempresa='S' then
		sql_nuevo += " WHERE clientes.empresa = '" + g_empresa + "'"
	end if
end if

// Todos los colegiados que pertenezcan a la lista de colegiados elegida..
// Pero comprobando si hay que incluirlos o incluirlos
string incl_excl, operador_not,sql_aux
operador_not = ''
sql_aux = ''
incl_excl = dw_1.GetItemString(1,'incluir_lista')
if incl_excl = 'E' then operador_not = ' NOT '

if PosA(upper(sql_nuevo), "WHERE") > 0 then
	sql_aux = "and clientes.id_cliente " + operador_not + "IN (SELECT id_cliente FROM listas_miembros WHERE id_lista='"+dw_1.getitemstring(1,'lista_cliente')+"')"
else
	sql_aux = "WHERE clientes.id_cliente " + operador_not + "IN (SELECT id_cliente FROM listas_miembros WHERE id_lista='"+dw_1.getitemstring(1,'lista_cliente')+"')"
end if	
if not isnull(sql_aux) then sql_nuevo += sql_aux



g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")

Parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_clientes_consulta
integer x = 1042
integer y = 1216
integer width = 539
end type

type cb_ayuda from w_consulta`cb_ayuda within w_clientes_consulta
string tag = "texto=general.ayuda"
integer x = 2158
integer y = 976
end type

type dw_1 from w_consulta`dw_1 within w_clientes_consulta
integer y = 136
integer width = 2007
integer height = 1052
string dataobject = "d_clientes_consulta"
end type

event dw_1::buttonclicked;string pob
choose case dwo.name
	CASE 'b_pob'
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(1,'poblacion',pob)
//		this.event itemchanged(1, this.object.cod_pob, pob)

case 'b_listas'
	string texto,lista
		Open(w_listas_seleccion)
		this.SetItem(1,'lista_cliente',Message.Stringparm)
		lista = Message.Stringparm
	select nombre_lista into :texto from listas_colegiados where id_lista = :lista;
	this.SetItem(1,'lista_cliente_texto',texto)
end choose
end event

