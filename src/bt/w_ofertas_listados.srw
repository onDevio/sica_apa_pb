HA$PBExportHeader$w_ofertas_listados.srw
forward
global type w_ofertas_listados from w_listados
end type
end forward

global type w_ofertas_listados from w_listados
integer width = 3922
string title = "Listados de Ofertas"
end type
global w_ofertas_listados w_ofertas_listados

on w_ofertas_listados.create
call super::create
end on

on w_ofertas_listados.destroy
call super::destroy
end on

event open;call super::open;
//Para relacionar los registros que se encuentran en la tabla de listados
dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)
end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_ofertas_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_ofertas_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_ofertas_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_ofertas_listados
integer x = 2331
integer width = 983
end type

type cb_ver from w_listados`cb_ver within w_ofertas_listados
end type

event cb_ver::clicked;call super::clicked;string sql,ls_sql1,ls_sql2
string listado
long ll_contador

dw_listados.Accepttext()
dw_1.of_SetPrintPreview(TRUE)

//Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado

dw_1.of_settransobject(sqlca)
sql = dw_1.describe("Datawindow.Table.Select")
ls_sql1 = Trim(Mid(sql,1,581))
ls_sql2 = Trim(Mid(sql,581,1000))


do while (ll_contador < 2)
		if(ll_contador = 0)then
			sql = ls_sql1
		else
			sql = ls_sql2
		end if
		
		//De la tabla bt_demandas debemos comprobar los parametros de la consulta
		f_sql('bt_ofertas.n_oferta','LIKE','n_oferta',dw_listados,sql,'1','')
		f_sql('bt_ofertas.tipo_bolsa','LIKE','tipo_bolsa',dw_listados,sql,'1','')
		f_sql('bt_ofertas.id_ofertante','LIKE','id_ofertante',dw_listados,sql,'1','')
		f_sql('bt_ofertas.tipo_act','LIKE','tipo_act',dw_listados,sql,'1','')
		f_sql('bt_ofertas.tipo_obra','LIKE','tipo_obra',dw_listados,sql,'1','')
		f_sql('bt_ofertas.descripcion_larga','LIKE','descripcion',dw_listados,sql,'1','')
		f_sql('bt_ofertas.condiciones','LIKE','condiciones',dw_listados,sql,'1','')
		f_sql('bt_ofertas.f_oferta','>=','f_oferta',dw_listados,sql,'1','')
		f_sql('bt_ofertas.f_oferta','<','f_oferta_hasta',dw_listados,sql,'1','')
		f_sql('bt_ofertas.f_fin','>=','f_fin',dw_listados,sql,'1','')
		f_sql('bt_ofertas.f_fin','<','f_fin_hasta',dw_listados,sql,'1','')
		
		
		// Alta
		string alta, sql_aux
		alta = dw_listados.getitemstring(1, 'alta')
		
		if alta <> '%' then
			if PosA(upper(sql), "WHERE") > 0  then
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
			if not isnull(sql_aux) then
				sql+= sql_aux
			end if
		end if
		if(ll_contador = 0)then
			ls_sql1 = sql
		else
			ls_sql2 = sql
		end if
		ll_contador+=1
	loop

sql = ls_sql1 + ls_sql2

dw_1.SetTransobject(sqlca)
dw_1.modify("datawindow.table.select= ~"" + sql+ "~"")
dw_1.retrieve()

//Al final:
if dw_1.RowCount() > 0 then
	// No tiene reports, hacer el printpreview		
	if dw_1.Describe("DataWindow.Nested") = "no" then dw_1.event pfc_printpreview()
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

type cb_salir from w_listados`cb_salir within w_ofertas_listados
end type

type dw_listados from w_listados`dw_listados within w_ofertas_listados
integer width = 2231
string dataobject = "d_ofertas_consulta"
end type

event dw_listados::buttonclicked;call super::buttonclicked;string id_ofertante, id_col

choose case dwo.name
	case 'b_busqueda_ofertante'
	//Abrimos la ventana de b$$HEX1$$fa00$$ENDHEX$$squeda de ofertantes
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Empresas"
		g_busqueda.dw="d_lista_busqueda_terceros"
		
		id_ofertante=f_busqueda_terceros(g_terceros_codigos.ofertante)
		if f_es_vacio(id_ofertante) then return
		dw_listados.SetItem(1,'id_ofertante',id_ofertante)
		dw_listados.SetItem(1,'nom_ofertante',f_dame_cliente_nom_ape(id_ofertante))
		
	case "b_busca_colegiado"
  		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()   
		if NOT f_es_vacio(id_col)  then
			this.setitem(1,'n_colegiado',f_colegiado_n_col(id_col))
		end if
		this.setitem(1,'id_col',id_col)
		
	case else
end choose

end event

type cb_imprimir from w_listados`cb_imprimir within w_ofertas_listados
end type

type cb_zoom from w_listados`cb_zoom within w_ofertas_listados
end type

type cb_esp from w_listados`cb_esp within w_ofertas_listados
end type

type cb_guardar from w_listados`cb_guardar within w_ofertas_listados
end type

type cb_escala from w_listados`cb_escala within w_ofertas_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_ofertas_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_ofertas_listados
end type

type dw_1 from w_listados`dw_1 within w_ofertas_listados
integer width = 3854
integer height = 1452
end type

