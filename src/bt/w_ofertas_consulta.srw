HA$PBExportHeader$w_ofertas_consulta.srw
forward
global type w_ofertas_consulta from w_consulta
end type
end forward

global type w_ofertas_consulta from w_consulta
integer x = 214
integer y = 221
integer width = 2441
integer height = 1696
string title = "Consulta de Ofertas"
end type
global w_ofertas_consulta w_ofertas_consulta

on w_ofertas_consulta.create
call super::create
end on

on w_ofertas_consulta.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_ofertas_consulta
integer x = 2249
integer y = 1200
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_ofertas_consulta
integer x = 2249
end type

type cb_limpiar from w_consulta`cb_limpiar within w_ofertas_consulta
end type

type st_5 from w_consulta`st_5 within w_ofertas_consulta
end type

type cb_1 from w_consulta`cb_1 within w_ofertas_consulta
integer x = 443
integer y = 1408
end type

event cb_1::clicked;call super::clicked;//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo
SetPointer(HourGlass!)
sql_nuevo = g_dw_lista.describe("datawindow.table.select")

//De la tabla bt_ofertas debemos comprobar los parametros de la consulta
f_sql('bt_ofertas.n_oferta','LIKE','n_oferta',dw_1,sql_nuevo,'1','')
f_sql('bt_ofertas.tipo_bolsa','LIKE','tipo_bolsa',dw_1,sql_nuevo,'1','')
f_sql('bt_ofertas.id_ofertante','LIKE','id_ofertante',dw_1,sql_nuevo,'1','')
f_sql('bt_ofertas.tipo_act','LIKE','tipo_act',dw_1,sql_nuevo,'1','')
f_sql('bt_ofertas.tipo_obra','LIKE','tipo_obra',dw_1,sql_nuevo,'1','')
f_sql('bt_ofertas.descripcion_larga','LIKE','descripcion',dw_1,sql_nuevo,'1','')
f_sql('bt_ofertas.condiciones','LIKE','condiciones',dw_1,sql_nuevo,'1','')
f_sql('bt_ofertas.f_oferta','>=','f_oferta',dw_1,sql_nuevo,'1','')
f_sql('bt_ofertas.f_oferta','<','f_oferta_hasta',dw_1,sql_nuevo,'1','')
f_sql('bt_ofertas.f_fin','>=','f_fin',dw_1,sql_nuevo,'1','')
f_sql('bt_ofertas.f_fin','<','f_fin_hasta',dw_1,sql_nuevo,'1','')

// Colegiado Asignado
if not f_es_vacio(dw_1.getitemstring(1, 'id_col')) then
	sql_nuevo = f_sql_join(sql_nuevo, {'( bt_ofertas.id_oferta = bt_ofertas_asigna.id_oferta )'})
	f_sql('bt_ofertas_asigna.id_colegiado','LIKE','id_col',dw_1,sql_nuevo,'1','')
end if

// Alta
string alta, sql_aux
alta = dw_1.getitemstring(1, 'alta')

if alta <> '%' then
	if PosA(upper(sql_nuevo), "WHERE") > 0  then
		if alta = 'S' then
			sql_aux += "and (bt_ofertas.f_fin is null or bt_ofertas.f_fin >= '" + string(today(), 'yyyymmdd') + "')" +&
						 + " and (bt_ofertas.f_oferta is null or bt_ofertas.f_oferta <= '" + string(today(), 'yyyymmdd') + "')"
		end if
		if alta = 'N' then
			sql_aux += "and not ((bt_ofertas.f_fin is null or bt_ofertas.f_fin >= '" + string(today(), 'yyyymmdd') + "')" +&
						 + " and (bt_ofertas.f_oferta is null or bt_ofertas.f_oferta <= '" + string(today(), 'yyyymmdd') + "'))"
		end if
	else
		if alta = 'S' then
			sql_aux += "WHERE (bt_ofertas.f_fin is null or bt_ofertas.f_fin >= '" + string(today(), 'yyyymmdd') + "')" +&
						 + " and (bt_ofertas.f_oferta is null or bt_ofertas.f_oferta <= '" + string(today(), 'yyyymmdd') + "')"
		end if
		if alta = 'N' then
			sql_aux += "WHERE not ((bt_ofertas.f_fin is null or bt_ofertas.f_fin >= '" + string(today(), 'yyyymmdd') + "')" +&
						 + " and (bt_ofertas.f_oferta is null or bt_ofertas.f_oferta <= '" + string(today(), 'yyyymmdd') + "'))"
		end if
	end if
	if not isnull(sql_aux) then sql_nuevo += sql_aux
end if

g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")

//messagebox('', sql_nuevo)

Parent.event pfc_close()


end event

type cb_2 from w_consulta`cb_2 within w_ofertas_consulta
integer x = 1065
integer y = 1408
end type

type cb_ayuda from w_consulta`cb_ayuda within w_ofertas_consulta
end type

type dw_1 from w_consulta`dw_1 within w_ofertas_consulta
integer x = 27
integer y = 160
integer width = 2331
integer height = 1096
string dataobject = "d_ofertas_consulta"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event dw_1::buttonclicked;call super::buttonclicked;string id_ofertante, id_col

choose case dwo.name
	case 'b_busqueda_ofertante'
	//Abrimos la ventana de b$$HEX1$$fa00$$ENDHEX$$squeda de ofertantes
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Empresas"
		g_busqueda.dw="d_lista_busqueda_terceros"
		
		id_ofertante=f_busqueda_terceros(g_terceros_codigos.ofertante)
		if f_es_vacio(id_ofertante) then return
		dw_1.SetItem(1,'id_ofertante',id_ofertante)
		dw_1.SetItem(1,'nom_ofertante',f_dame_cliente_nom_ape(id_ofertante))
		
	case "b_busca_colegiado"
  		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()   
		if NOT f_es_vacio(id_col)  then
			this.setitem(1,'n_colegiado',f_colegiado_n_col(id_col))
		end if
		this.setitem(1,'id_col',id_col)
end choose

end event

event dw_1::itemchanged;call super::itemchanged;choose case dwo.name
	case "n_colegiado"
		this.setitem(1,'id_col', f_colegiado_id_col(data))
END CHOOSE

end event

