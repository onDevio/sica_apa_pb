HA$PBExportHeader$w_musaat_listados.srw
forward
global type w_musaat_listados from w_listados
end type
type tab_1 from tab within w_musaat_listados
end type
type tabpage_1 from userobject within tab_1
end type
type dw_2 from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_2 dw_2
end type
type tabpage_2 from userobject within tab_1
end type
type gb_1 from groupbox within tabpage_2
end type
type gb_15 from groupbox within tabpage_2
end type
type cb_todos5 from commandbutton within tabpage_2
end type
type cb_todos1 from commandbutton within tabpage_2
end type
type cb_borrar5 from commandbutton within tabpage_2
end type
type dw_situaciones from u_dw within tabpage_2
end type
type dw_residente from u_dw within tabpage_2
end type
type dw_opcion_situaciones from u_dw within tabpage_2
end type
type dw_opcion_residente from u_dw within tabpage_2
end type
type dw_alta_si_no from u_dw within tabpage_2
end type
type dw_ejerciente_si_no from u_dw within tabpage_2
end type
type cb_borrar1 from commandbutton within tabpage_2
end type
type tabpage_2 from userobject within tab_1
gb_1 gb_1
gb_15 gb_15
cb_todos5 cb_todos5
cb_todos1 cb_todos1
cb_borrar5 cb_borrar5
dw_situaciones dw_situaciones
dw_residente dw_residente
dw_opcion_situaciones dw_opcion_situaciones
dw_opcion_residente dw_opcion_residente
dw_alta_si_no dw_alta_si_no
dw_ejerciente_si_no dw_ejerciente_si_no
cb_borrar1 cb_borrar1
end type
type tab_1 from tab within w_musaat_listados
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_musaat_listados from w_listados
integer width = 3758
integer height = 2880
string title = "Listado de Seguros"
tab_1 tab_1
end type
global w_musaat_listados w_musaat_listados

type variables
u_dw idw_opcion_residente, idw_residente,  idw_ejerciente_sn, idw_opcion_sit, idw_situaciones,idw_listados_1, idw_listados_2, idw_alta_sn
end variables

on w_musaat_listados.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_musaat_listados.destroy
call super::destroy
destroy(this.tab_1)
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

inv_resize.of_Register (dw_listados, "ScaletoRight&Bottom")

idw_listados_1=tab_1.tabpage_1.dw_2
idw_listados_1.insertrow(0)
idw_residente = tab_1.tabpage_2.dw_residente
idw_opcion_residente = tab_1.tabpage_2.dw_opcion_residente
idw_ejerciente_sn = tab_1.tabpage_2.dw_ejerciente_si_no
idw_alta_sn=tab_1.tabpage_2.dw_alta_si_no
idw_alta_sn.insertrow(0)
idw_residente.retrieve()
idw_opcion_residente.insertrow(0)
idw_ejerciente_sn.insertrow(0)
idw_opcion_sit=tab_1.tabpage_2.dw_opcion_situaciones
idw_situaciones=tab_1.tabpage_2.dw_situaciones
idw_opcion_sit.insertrow(0)
idw_situaciones.retrieve()

end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_musaat_listados
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_musaat_listados
string tag = "texto=general.guardar_pantalla"
end type

type cb_limpiar from w_listados`cb_limpiar within w_musaat_listados
string tag = "texto=general.limpiar_consulta"
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_musaat_listados
integer x = 2537
integer y = 180
integer width = 1170
integer height = 1376
end type

type cb_ver from w_listados`cb_ver within w_musaat_listados
end type

event cb_ver::clicked;call super::clicked;string sql, listado, codigos, sql_aux, operador, opcion, alta, sql_aux2='', conceptos_domi, forma_pago_domi
int i
double importe_desde_domi, importe_hasta_domi
boolean coma

dw_listados.Accepttext()
dw_1.of_SetPrintPreview(TRUE)
//Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado
dw_1.of_settransobject(sqlca)
sql = dw_1.describe("Datawindow.Table.Select")

//Hacer f_sql de todos los campos de la dw_listados
f_sql('colegiados.n_colegiado', 'LIKE', 'n_col', idw_listados_1,sql, '1', '')
f_sql('colegiados.delegacion','=','delegacion',idw_listados_1,sql, '1', '')
f_sql('colegiados.ejerciente','like','ejerciente',idw_ejerciente_sn,sql,'1','')
f_sql('colegiados.alta_baja','like','alta',idw_alta_sn,sql,'1','')
f_sql('musaat.n_mutualista', 'LIKE', 'n_mutualista',idw_listados_1,sql, '1', '')
f_sql('musaat.src_alta', 'LIKE', 'src_de_alta', idw_listados_1,sql, '1', '')
f_sql('musaat.src_prefijo', '=', 'src_prefijo',idw_listados_1,sql, '1', '')
f_sql('musaat.src_n_poliza', 'LIKE', 'src_n_poliza', idw_listados_1,sql, '1', '')
f_sql('musaat.src_cober', 'LIKE', 'src_cober', idw_listados_1,sql, '1', '')
f_sql('musaat.src_estado', 'LIKE', 'src_estado', idw_listados_1,sql, '1', '')
//f_sql('musaat.src_cia', '=', 'cia_src', idw_listados_1,sql, '1', '')
f_sql('musaat.accidentes_alta', 'LIKE', 'acci_de_alta', idw_listados_1,sql, '1', '')
f_sql('musaat.accidentes_n_poliza', 'LIKE', 'acci_n_poliza', idw_listados_1,sql, '1', '')
f_sql('musaat.accidentes_cober_muerte', '=', 'acci_cober_muerte', idw_listados_1,sql, '1', '')
f_sql('musaat.accidentes_cober_invalidez2', '=', 'acci_cober_invalidez', idw_listados_1,sql, '1', '')
f_sql('musaat.accidentes_cia', '=', 'cia_accidentes', idw_listados_1,sql, '1', '')
f_sql('musaat.tasadores_alta', 'LIKE', 'tasa_de_alta', idw_listados_1,sql, '1', '')
f_sql('musaat.tasadores_n_poliza', '=', 'tasa_n_poliza', idw_listados_1,sql, '1', '')
f_sql('musaat.tasadores_cober', 'LIKE', 'tasa_cober',idw_listados_1,sql, '1', '')
f_sql('musaat.tasadores_cia', '=', 'cia_tasaciones', idw_listados_1,sql, '1', '')
f_sql('musaat.peritos_alta', 'LIKE', 'peri_de_alta',idw_listados_1,sql, '1', '')
f_sql('musaat.peritos_n_poliza', '=', 'peri_n_poliza', idw_listados_1,sql, '1', '')
f_sql('musaat.peritos_cober', 'LIKE', 'peri_cober', idw_listados_1,sql, '1', '')
f_sql('musaat.peritos_cia', '=', 'cia_peritos',idw_listados_1,sql, '1', '')
f_sql('musaat.otros', 'LIKE inside', 'otros_datos', idw_listados_1,sql, '1', '')
f_sql('musaat.exceso', 'LIKE', 'exceso_alta',  idw_listados_1,sql, '1', '')
f_sql('musaat.exceso_n_poliza', 'LIKE', 'exceso_n_poliza',  idw_listados_1,sql, '1', '')
f_sql('musaat.exceso_cobertura', 'LIKE', 'exceso_cober',  idw_listados_1,sql, '1', '')
f_sql('musaat.src_coef_cm', '>=', 'src_bonus_malus_desde',idw_listados_1,sql, '1', '')
f_sql('musaat.src_coef_cm', '<=', 'src_bonus_malus_hasta', idw_listados_1,sql, '1', '')
f_sql('musaat.src_t_poliza', '=', 'src_t_poliza', idw_listados_1,sql, '1', '')

//Todos los colegiados que Tengan el residente elegido, ya q se pueden elegir varias de una lista
opcion = idw_opcion_residente.GetItemString(1,'opcion')
if opcion<>'%' then
	if not f_es_vacio(sql_aux2) then sql_aux2 = 'and '+sql_aux2
	coma=false
	for i=1 to idw_residente.RowCount()
		if idw_residente.GetItemString(i,'activo') = 'S' then
			if coma then codigos= codigos+','
			codigos = codigos+"'"+idw_residente.GetItemString(i,'c_geografico')+"'"
			coma = true
		end if
	next
	if codigos<>'' then
		if pos(upper(sql), "WHERE") > 0  then
			sql_aux = "and colegiados.c_geografico "+operador+" IN ("+codigos+")" 
		else
			sql_aux = "WHERE colegiados.c_geografico "+operador+" IN ("+codigos+")"
		end if	
		if not isnull(sql_aux) then sql += sql_aux
	end if
end if

//Todos los colegiados que pertenezcan a la situaci$$HEX1$$f300$$ENDHEX$$nes elegidas, ya q se pueden elegir varias de una lista
opcion = idw_opcion_sit.GetItemString(1,'opcion')
if opcion<>'%'  then
	coma=false
	for i=1 to idw_situaciones.RowCount()
		if idw_situaciones.GetItemString(i,'activo') = 'S' then
			if coma then codigos= codigos+','
			codigos = codigos+"'"+idw_situaciones.GetItemString(i,'codigo')+"'"
			coma = true
		end if
	next
	if opcion = 'S' then operador=''
	if opcion = 'N' then operador = 'NOT'
	
	if codigos<>'' then
		if pos(upper(sql), "WHERE") > 0  then
			sql_aux = "and colegiados.situacion "+operador+" IN ("+codigos+")"
		else
			sql_aux = "WHERE colegiados.situacion "+operador+" IN ("+codigos+")"
		end if	
		if not isnull(sql_aux) then sql += sql_aux
	end if
end if

conceptos_domi = dw_listados.getitemstring(1, 'conceptos_domi')
importe_desde_domi = dw_listados.getitemnumber(1, 'importe_desde_domi')
importe_hasta_domi = dw_listados.getitemnumber(1, 'importe_hasta_domi')
forma_pago_domi = dw_listados.getitemstring(1, 'forma_pago_domi')
if (not f_es_vacio(conceptos_domi)) or (not isnull(importe_desde_domi)) or (not isnull(importe_hasta_domi)) or (not f_es_vacio(forma_pago_domi)) then
	sql = f_sql_join(sql, {'( musaat.id_col = conceptos_domiciliables.id_colegiado )'})
end if
if not f_es_vacio(conceptos_domi) then sql += " and ( conceptos_domiciliables.concepto like'"+conceptos_domi+"')"
if not isnull(importe_desde_domi) then sql += " and ( conceptos_domiciliables.importe >= "+f_cambia_comas_decimales(importe_desde_domi)+")"
if not isnull(importe_hasta_domi) then sql += " and ( conceptos_domiciliables.importe <= "+f_cambia_comas_decimales(importe_hasta_domi)+")"
if not f_es_vacio(forma_pago_domi) then sql += " and ( conceptos_domiciliables.forma_de_pago like'"+forma_pago_domi+"')"


sql = f_sql_join(sql, {'( musaat.id_col = src_colegiado.id_colegiado )'})
f_sql('src_colegiado.numero_poliza', 'LIKE', 'n_poliza_otros_src', idw_listados_1,sql, '1', '')
f_sql('src_colegiado.alta', 'LIKE', 'alta_otros_src', idw_listados_1,sql, '1', '')
f_sql('src_colegiado.src_cia', '=', 'cia_otros_src', idw_listados_1,sql, '1', '')
f_sql('src_colegiado.f_alta','>=','f_alta_desde_otros_src',idw_listados_1,sql, '1', '')
f_sql('src_colegiado.f_alta','<','f_alta_hasta_otros_src',idw_listados_1,sql, '1', '')
f_sql('src_colegiado.f_baja','>=','f_baja_desde_otros_src',idw_listados_1,sql, '1', '')
f_sql('src_colegiado.f_baja','<','f_baja_desde_otros_src',idw_listados_1,sql, '1', '')

dw_1.SetTransobject(sqlca)
dw_1.Modify("Datawindow.table.Select= ~"" + sql + "~"")

//messagebox('kk', sql)

if listado = 'd_musaat_listado_primas_fijas' then 
	if f_es_vacio(conceptos_domi) then dw_1.retrieve(g_codigos_conceptos.musaat_fija) else dw_1.retrieve('%')
else
	dw_1.retrieve()
end if

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
	messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.no_registros_especificaciones','No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.'))
end if	

end event

type cb_salir from w_listados`cb_salir within w_musaat_listados
end type

type dw_listados from w_listados`dw_listados within w_musaat_listados
boolean visible = false
integer x = 41
integer y = 160
integer width = 2363
integer height = 1976
string dataobject = "d_musaat_consulta"
end type

type cb_imprimir from w_listados`cb_imprimir within w_musaat_listados
end type

type cb_zoom from w_listados`cb_zoom within w_musaat_listados
end type

type cb_esp from w_listados`cb_esp within w_musaat_listados
end type

type cb_guardar from w_listados`cb_guardar within w_musaat_listados
end type

type cb_escala from w_listados`cb_escala within w_musaat_listados
integer y = 24
end type

type cb_ordenar from w_listados`cb_ordenar within w_musaat_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_musaat_listados
boolean visible = true
integer x = 23
integer y = 2508
integer width = 3429
integer height = 140
end type

type dw_1 from w_listados`dw_1 within w_musaat_listados
integer x = 32
integer y = 176
integer width = 3689
integer height = 2580
end type

event dw_1::retrievestart;call super::retrievestart;// Indicamos que queremos cambiar el idioma
if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)
end event

type tab_1 from tab within w_musaat_listados
integer x = 37
integer y = 180
integer width = 2505
integer height = 2460
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
string tag = "texto=musaat.musaat"
integer x = 18
integer y = 112
integer width = 2469
integer height = 2332
long backcolor = 79741120
string text = "Musaat"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_1.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_1.destroy
destroy(this.dw_2)
end on

type dw_2 from u_dw within tabpage_1
integer y = 52
integer width = 2464
integer height = 2264
integer taborder = 21
string dataobject = "d_musaat_consulta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;string id_colegiado

CHOOSE CASE dwo.name
	CASE 'b_col'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"

		id_colegiado=f_busqueda_colegiados()
		
		setItem(1,'n_col',f_colegiado_n_col(id_colegiado))
END CHOOSE
end event

event clicked;call super::clicked;string t_poliza,cia_src

// Filtramos las coberturas seg$$HEX1$$fa00$$ENDHEX$$n el tipo de poliza
CHOOSE CASE dwo.name
	CASE 'src_cober'
		t_poliza = this.getitemstring(1, 'src_t_poliza')
		if isnull(t_poliza) then t_poliza = ''
		DataWindowChild dwc_cober_src
		this.GetChild('src_cober', dwc_cober_src)
		dwc_cober_src.setfilter("t_poliza = '" + t_poliza + "'")		
		dwc_cober_src.filter()
END CHOOSE

end event

event itemchanged;call super::itemchanged;datawindowchild  ldwc_src_cober
Long num_digitos
string ls_null,ls_codigo
setnull(ls_null)
choose case dwo.name
	case 'cia_src'	
			this.getchild("src_cober", ldwc_src_cober)	
			ldwc_src_cober.settransobject(sqlca)
			this.setitem(1,'src_cober',ls_null)
			ldwc_src_cober.retrieve(data)
	case 'src_t_poliza_1'
			this.setitem(1,'src_cober',ls_null)			
end choose
end event

type tabpage_2 from userobject within tab_1
string tag = "texto=musaat.colegiados"
integer x = 18
integer y = 112
integer width = 2469
integer height = 2332
long backcolor = 79741120
string text = "Colegiados"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_1 gb_1
gb_15 gb_15
cb_todos5 cb_todos5
cb_todos1 cb_todos1
cb_borrar5 cb_borrar5
dw_situaciones dw_situaciones
dw_residente dw_residente
dw_opcion_situaciones dw_opcion_situaciones
dw_opcion_residente dw_opcion_residente
dw_alta_si_no dw_alta_si_no
dw_ejerciente_si_no dw_ejerciente_si_no
cb_borrar1 cb_borrar1
end type

on tabpage_2.create
this.gb_1=create gb_1
this.gb_15=create gb_15
this.cb_todos5=create cb_todos5
this.cb_todos1=create cb_todos1
this.cb_borrar5=create cb_borrar5
this.dw_situaciones=create dw_situaciones
this.dw_residente=create dw_residente
this.dw_opcion_situaciones=create dw_opcion_situaciones
this.dw_opcion_residente=create dw_opcion_residente
this.dw_alta_si_no=create dw_alta_si_no
this.dw_ejerciente_si_no=create dw_ejerciente_si_no
this.cb_borrar1=create cb_borrar1
this.Control[]={this.gb_1,&
this.gb_15,&
this.cb_todos5,&
this.cb_todos1,&
this.cb_borrar5,&
this.dw_situaciones,&
this.dw_residente,&
this.dw_opcion_situaciones,&
this.dw_opcion_residente,&
this.dw_alta_si_no,&
this.dw_ejerciente_si_no,&
this.cb_borrar1}
end on

on tabpage_2.destroy
destroy(this.gb_1)
destroy(this.gb_15)
destroy(this.cb_todos5)
destroy(this.cb_todos1)
destroy(this.cb_borrar5)
destroy(this.dw_situaciones)
destroy(this.dw_residente)
destroy(this.dw_opcion_situaciones)
destroy(this.dw_opcion_residente)
destroy(this.dw_alta_si_no)
destroy(this.dw_ejerciente_si_no)
destroy(this.cb_borrar1)
end on

type gb_1 from groupbox within tabpage_2
string tag = "texto=musaat.situaciones"
integer x = 1207
integer y = 244
integer width = 910
integer height = 1508
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Situaciones"
end type

type gb_15 from groupbox within tabpage_2
string tag = "texto=musaat.residente"
integer x = 91
integer y = 244
integer width = 1019
integer height = 1500
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Residente"
end type

type cb_todos5 from commandbutton within tabpage_2
string tag = "texto=general.seleccionar_todos"
boolean visible = false
integer x = 91
integer y = 1804
integer width = 325
integer height = 68
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Sel. Todos"
end type

event clicked;int i

for i=1 to idw_residente.rowcount() 
	idw_residente.SetItem(i,'activo','S')
next
end event

type cb_todos1 from commandbutton within tabpage_2
string tag = "texto=general.seleccionar_todos"
boolean visible = false
integer x = 1202
integer y = 1804
integer width = 325
integer height = 68
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Sel. Todos"
end type

event clicked;int i

for i=1 to idw_situaciones.rowcount() 
	idw_situaciones.SetItem(i,'activo','S')
next
end event

type cb_borrar5 from commandbutton within tabpage_2
string tag = "texto=general.borrar_todos"
boolean visible = false
integer x = 434
integer y = 1804
integer width = 325
integer height = 68
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Borrar Todos"
end type

event clicked;int i

for i=1 to idw_residente.rowcount() 
	idw_residente.SetItem(i,'activo','N')
next
end event

type dw_situaciones from u_dw within tabpage_2
boolean visible = false
integer x = 1230
integer y = 488
integer width = 864
integer height = 1256
integer taborder = 61
boolean bringtotop = true
string dataobject = "d_colegiados_situaciones_consulta"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;string opcion

opcion = idw_opcion_sit.GetItemString(1,'opcion')
if opcion='%' then idw_opcion_sit.SetItem(1,'opcion','S')
end event

type dw_residente from u_dw within tabpage_2
boolean visible = false
integer x = 105
integer y = 488
integer width = 974
integer height = 752
integer taborder = 71
boolean bringtotop = true
string dataobject = "d_colegiados_consulta_residente"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;string opcion

opcion = idw_opcion_residente.GetItemString(1,'opcion')
if opcion='%' then idw_opcion_residente.SetItem(1,'opcion','S')
end event

type dw_opcion_situaciones from u_dw within tabpage_2
integer x = 1243
integer y = 360
integer width = 800
integer height = 112
integer taborder = 51
boolean bringtotop = true
string dataobject = "d_colegiados_consulta_opciones"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;if data ='S' then
	cb_todos1.visible=true
	cb_borrar1.visible=true
	dw_situaciones.visible = true
else
	cb_todos1.visible=false
	cb_borrar1.visible=false
	dw_situaciones.visible=false
end if 
end event

type dw_opcion_residente from u_dw within tabpage_2
integer x = 128
integer y = 360
integer width = 910
integer height = 112
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_colegiados_consulta_opciones"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;if data ='S' then
	cb_todos5.visible=true
	cb_borrar5.visible=true
	dw_residente.visible = true
else
	cb_todos5.visible=false
	cb_borrar5.visible=false
	dw_residente.visible=false
end if 
end event

type dw_alta_si_no from u_dw within tabpage_2
integer x = 1193
integer y = 52
integer width = 955
integer height = 136
integer taborder = 31
string dataobject = "d_colegiados_consulta_alta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type dw_ejerciente_si_no from u_dw within tabpage_2
integer x = 78
integer y = 52
integer width = 1111
integer height = 136
integer taborder = 61
boolean bringtotop = true
string dataobject = "d_colegiados_consulta_ejerciente"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type cb_borrar1 from commandbutton within tabpage_2
string tag = "texto=general.borrar_todos"
boolean visible = false
integer x = 1545
integer y = 1804
integer width = 325
integer height = 68
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Borrar Todos"
end type

event clicked;int i

for i=1 to idw_situaciones.rowcount() 
	idw_situaciones.SetItem(i,'activo','N')
next
end event

