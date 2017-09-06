HA$PBExportHeader$w_demandas_listados.srw
forward
global type w_demandas_listados from w_listados
end type
type rb_num_col from radiobutton within w_demandas_listados
end type
type rb_apellidos from radiobutton within w_demandas_listados
end type
type gb_11 from groupbox within w_demandas_listados
end type
end forward

global type w_demandas_listados from w_listados
string title = "Listados de Demandas"
rb_num_col rb_num_col
rb_apellidos rb_apellidos
gb_11 gb_11
end type
global w_demandas_listados w_demandas_listados

on w_demandas_listados.create
int iCurrent
call super::create
this.rb_num_col=create rb_num_col
this.rb_apellidos=create rb_apellidos
this.gb_11=create gb_11
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_num_col
this.Control[iCurrent+2]=this.rb_apellidos
this.Control[iCurrent+3]=this.gb_11
end on

on w_demandas_listados.destroy
call super::destroy
destroy(this.rb_num_col)
destroy(this.rb_apellidos)
destroy(this.gb_11)
end on

event open;call super::open;//Para relacionar los registros que se encuentran en la tabla de listados
dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)
end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_demandas_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_demandas_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_demandas_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_demandas_listados
end type

type cb_ver from w_listados`cb_ver within w_demandas_listados
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

//De la tabla bt_demandas debemos comprobar los parametros de la consulta
f_sql('bt_demandas.id_col','LIKE','id_col',dw_listados,sql,'1','')
f_sql('bt_demandas.f_inicio','>=','f_inicio',dw_listados,sql,'1','')
f_sql('bt_demandas.f_inicio','<','f_ini_hasta',dw_listados,sql,'1','')
f_sql('bt_demandas.f_fin','>=','f_fin',dw_listados,sql,'1','')
f_sql('bt_demandas.f_fin','<','f_fin_hasta',dw_listados,sql,'1','')

if not f_es_vacio(dw_listados.getitemstring(1, 'tipo_demanda')) then
	sql = f_sql_join(sql, {'( bt_demandas.id_col = bt_demandas_tipo.id_col )'})
	f_sql('bt_demandas_tipo.tipo_demanda','LIKE','tipo_demanda',dw_listados,sql,'1','')
end if

// Alta
if dw_listados.getitemstring(1, 'alta') = 'S' then
	sql += "and (bt_demandas.f_fin is null or bt_demandas.f_fin >= '" + string(today(), 'yyyymmdd') + "')" +&
		 + " and (bt_demandas.f_inicio is null or bt_demandas.f_inicio <= '" + string(today(), 'yyyymmdd') + "')"
end if
if dw_listados.getitemstring(1, 'alta') = 'N' then
	sql += "and not ((bt_demandas.f_fin is null or bt_demandas.f_fin >= '" + string(today(), 'yyyymmdd') + "')" +&
		 + " and (bt_demandas.f_inicio is null or bt_demandas.f_inicio <= '" + string(today(), 'yyyymmdd') + "'))"
end if	

dw_1.SetTransobject(sqlca)
dw_1.modify("datawindow.table.select= ~"" + sql+ "~"")
dw_1.retrieve()

//Al final:
if dw_1.RowCount() > 0 then
	// Ponemos en el titulo del listado la bolsa que estan consultando
	if listado = 'd_demandas_listados_colegiados' then
		string bolsa, titulo
		bolsa = dw_listados.getitemstring(1, 'tipo_demanda')
		if not f_es_vacio(bolsa) then
			SELECT bt_tipo_bolsa.descripcion  
			INTO :titulo
			FROM bt_tipo_bolsa  
			WHERE bt_tipo_bolsa.bt_tipo_bolsa = :bolsa   ;
	
			dw_1.object.st_titulo_listado.text = 'LISTADO ' + titulo
		end if
	end if
	
	if rb_num_col.checked = TRUE then
		int j
		j = dw_1.SetSort("n_colegiado A")
		dw_1.Sort()
		dw_1.groupcalc()
	end if
	if rb_apellidos.checked = TRUE then
		j = dw_1.SetSort("apellidos A, nombre A")
		dw_1.Sort()
		dw_1.groupcalc()		
	end if
	dw_1.visible = true
	// No tiene reports y no son etiquetas, hacemos el preview
	if dw_1.Describe("DataWindow.Nested") = "no" and dw_1.describe("Datawindow.Label.Columns") = "0" then
		dw_1.event pfc_printpreview()
	end if
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

type cb_salir from w_listados`cb_salir within w_demandas_listados
end type

type dw_listados from w_listados`dw_listados within w_demandas_listados
integer height = 628
string dataobject = "d_demandas_consulta"
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
			this.setitem(1,'nombre_colegiado',f_nombre_colegiado(id_col))
		end if
		this.setitem(1,'id_col',id_col)		
END CHOOSE

end event

event dw_listados::itemchanged;call super::itemchanged;choose case dwo.name
	case "n_colegiado"
		this.setitem(1,'nombre_colegiado',f_nombre_colegiado(f_colegiado_id_col(data)))
		this.setitem(1,'id_col', f_colegiado_id_col(data))
END CHOOSE

end event

type cb_imprimir from w_listados`cb_imprimir within w_demandas_listados
end type

type cb_zoom from w_listados`cb_zoom within w_demandas_listados
end type

type cb_esp from w_listados`cb_esp within w_demandas_listados
end type

type cb_guardar from w_listados`cb_guardar within w_demandas_listados
end type

type cb_escala from w_listados`cb_escala within w_demandas_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_demandas_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_demandas_listados
end type

type dw_1 from w_listados`dw_1 within w_demandas_listados
integer height = 1448
end type

type rb_num_col from radiobutton within w_demandas_listados
integer x = 64
integer y = 992
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$ba002000$$ENDHEX$$Colegiado"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type rb_apellidos from radiobutton within w_demandas_listados
integer x = 64
integer y = 1068
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Apellidos"
borderstyle borderstyle = stylelowered!
end type

type gb_11 from groupbox within w_demandas_listados
integer x = 41
integer y = 908
integer width = 448
integer height = 252
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Ordenar por"
borderstyle borderstyle = stylelowered!
end type

