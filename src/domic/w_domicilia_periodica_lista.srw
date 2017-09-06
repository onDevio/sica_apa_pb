HA$PBExportHeader$w_domicilia_periodica_lista.srw
forward
global type w_domicilia_periodica_lista from w_mant_busq
end type
type cb_salir from commandbutton within w_domicilia_periodica_lista
end type
type cb_1 from commandbutton within w_domicilia_periodica_lista
end type
type rb_col from radiobutton within w_domicilia_periodica_lista
end type
type rb_ape from radiobutton within w_domicilia_periodica_lista
end type
type em_importe from editmask within w_domicilia_periodica_lista
end type
type cb_2 from commandbutton within w_domicilia_periodica_lista
end type
type tab_1 from tab within w_domicilia_periodica_lista
end type
type tabpage_1 from userobject within tab_1
end type
type dw_consulta from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_consulta dw_consulta
end type
type tabpage_2 from userobject within tab_1
end type
type dw_consulta_2 from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_consulta_2 dw_consulta_2
end type
type tab_1 from tab within w_domicilia_periodica_lista
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_borrar_todos from u_cb within w_domicilia_periodica_lista
end type
type rb_cuota from radiobutton within w_domicilia_periodica_lista
end type
type rb_multiplicar from radiobutton within w_domicilia_periodica_lista
end type
type gb_orden from groupbox within w_domicilia_periodica_lista
end type
type gb_tipo_importe from groupbox within w_domicilia_periodica_lista
end type
end forward

global type w_domicilia_periodica_lista from w_mant_busq
integer width = 3575
integer height = 2016
string title = "Gesti$$HEX1$$f300$$ENDHEX$$n de Domiciliaciones"
cb_salir cb_salir
cb_1 cb_1
rb_col rb_col
rb_ape rb_ape
em_importe em_importe
cb_2 cb_2
tab_1 tab_1
cb_borrar_todos cb_borrar_todos
rb_cuota rb_cuota
rb_multiplicar rb_multiplicar
gb_orden gb_orden
gb_tipo_importe gb_tipo_importe
end type
global w_domicilia_periodica_lista w_domicilia_periodica_lista

type variables
datawindow idw_consulta, idw_consulta_2
datastore  ids_print

end variables

on w_domicilia_periodica_lista.create
int iCurrent
call super::create
this.cb_salir=create cb_salir
this.cb_1=create cb_1
this.rb_col=create rb_col
this.rb_ape=create rb_ape
this.em_importe=create em_importe
this.cb_2=create cb_2
this.tab_1=create tab_1
this.cb_borrar_todos=create cb_borrar_todos
this.rb_cuota=create rb_cuota
this.rb_multiplicar=create rb_multiplicar
this.gb_orden=create gb_orden
this.gb_tipo_importe=create gb_tipo_importe
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_salir
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.rb_col
this.Control[iCurrent+4]=this.rb_ape
this.Control[iCurrent+5]=this.em_importe
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.tab_1
this.Control[iCurrent+8]=this.cb_borrar_todos
this.Control[iCurrent+9]=this.rb_cuota
this.Control[iCurrent+10]=this.rb_multiplicar
this.Control[iCurrent+11]=this.gb_orden
this.Control[iCurrent+12]=this.gb_tipo_importe
end on

on w_domicilia_periodica_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_salir)
destroy(this.cb_1)
destroy(this.rb_col)
destroy(this.rb_ape)
destroy(this.em_importe)
destroy(this.cb_2)
destroy(this.tab_1)
destroy(this.cb_borrar_todos)
destroy(this.rb_cuota)
destroy(this.rb_multiplicar)
destroy(this.gb_orden)
destroy(this.gb_tipo_importe)
end on

event open;call super::open;idw_consulta = tab_1.tabpage_1.dw_consulta
idw_consulta_2 = tab_1.tabpage_2.dw_consulta_2

//Ponemos una nueva fila vacia.
idw_consulta.insertrow(0)
idw_consulta_2.insertrow(0)

//Ponemos el boton Salir al final junto con los otros.
inv_resize.of_Register (cb_salir, "FixedtoBottom")
inv_resize.of_Register (cb_borrar_todos, "FixedtoBottom")


ids_print  				= create datastore
ids_print.dataobject 	= 'd_conceptos_listado'

dw_1.sharedata(ids_print)
end event

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje 
string res1,res1_new,res2,res2_new
int fila, retorno=1

if f_puedo_escribir(g_usuario,'0000000031')=-1 then return -1

//Se debe asignar un valor al colegiado, y al concepto

mensaje += f_valida(dw_1,'id_colegiado','NOVACIO','Debe especificar un colegiado.'+cr)
mensaje += f_valida(dw_1,'concepto','NOVACIO','Debe especificar un concepto.'+cr)

// Controlamos si hay duplicados en las filas visualizadas,es decir un colegiado puede estar con
//distintos conceptos con importes distintos, pero no distintos importes para un mismo concepto.
//$$HEX1$$bf00$$ENDHEX$$PREGUNTAR?
//Miraremos el status de la Row para saber los valores que hemos modificado y los que insertamos
//para comprobar que no hay filas repetidas.
//For fila = 1 to dw_1.RowCount() 
//	IF dw_1.GetItemStatus( fila,0, Primary!) = NotModified! then 
//		res1=trim(dw_1.GetItemString(fila,'id_colegiado'))
//		res2=trim(dw_1.GetItemString(fila,'concepto'))
//	END IF
//	IF dw_1.GetItemStatus( fila,0, Primary!)= NewModified! then 
//			res1_new=trim(dw_1.GetItemString(dw_1.RowCount() ,'id_colegiado'))
//			res2_new=trim(dw_1.GetItemString(dw_1.RowCount() ,'concepto'))
//		ELSEIF dw_1.GetItemStatus( fila,0, Primary!)= DataModified! then 
//			res1_new=trim(dw_1.GetItemString(fila,'id_colegiado'))
//			res2_new=trim(dw_1.GetItemString(fila,'concepto'))
//		ELSEIF dw_1.GetItemStatus( fila,0, Primary!)= New! then 
//			res1_new=trim(dw_1.GetItemString(dw_1.RowCount() ,'id_colegiado'))
//			res2_new=trim(dw_1.GetItemString(dw_1.RowCount() ,'concepto'))
//	END IF 
//	if (res1= res1_new) and (res2=res2_new)then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ cr
//
//next

// Modificado DAVID 26/12/03
// El c$$HEX1$$f300$$ENDHEX$$digo anterior no encuentra duplicados si las filas no son contiguas
dwitemstatus status
string id_col, conc, existe
For fila = 1 to dw_1.RowCount()
	status = dw_1.GetItemStatus( fila,0, Primary!)
	// Modificado Ricardo 04-01-12
	// Solo verificamos esto con las nuevas filas 
	IF dw_1.GetItemStatus(fila,0,Primary!) = NewModified! or dw_1.GetItemStatus(fila,0,Primary!) = NewModified! then
	// FIN Modificado Ricardo 04-01-12
		id_col=dw_1.GetItemString(fila,'id_colegiado')
		conc=dw_1.GetItemString(fila,'concepto')
		
		SELECT conceptos_domiciliables.id_colegiado  
    	INTO :existe  
    	FROM conceptos_domiciliables  
   	WHERE ( conceptos_domiciliables.id_colegiado = :id_col ) AND  
      	   ( conceptos_domiciliables.concepto = :conc )   ;

		if not f_es_vacio(existe) then mensaje += 'Hay un valor repetido en la fila '+string(fila)+ cr
	END IF 
	// Modificado Ricardo 04-01-12
	// Tratamiento especial para los data modified
	IF dw_1.GetItemStatus(fila,0,Primary!) = dataModified!  then
		string id_col_original, conc_original
		id_col=dw_1.GetItemString(fila,'id_colegiado')
		conc=dw_1.GetItemString(fila,'concepto')
		
		id_col_original=dw_1.GetItemString(fila,'id_colegiado', primary!, true)
		conc_original=dw_1.GetItemString(fila,'concepto', primary!, true)
		
		if id_col<>id_col_original or conc <> conc_original then
			SELECT conceptos_domiciliables.id_colegiado  
			INTO :existe  
			FROM conceptos_domiciliables  
			WHERE ( conceptos_domiciliables.id_colegiado = :id_col ) AND  
					( conceptos_domiciliables.concepto = :conc )   ;
	
			if not f_es_vacio(existe) then mensaje += 'Hay un valor repetido en la fila '+string(fila)+ cr
		end if
	end if
Next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

event pfc_print;// SOBREESCRITO
cb_1.event clicked()

return 1

end event

type cb_recuperar_pantalla from w_mant_busq`cb_recuperar_pantalla within w_domicilia_periodica_lista
integer x = 3547
integer y = 1416
end type

type cb_guardar_pantalla from w_mant_busq`cb_guardar_pantalla within w_domicilia_periodica_lista
integer x = 3547
integer y = 1296
end type

type dw_1 from w_mant_busq`dw_1 within w_domicilia_periodica_lista
integer x = 37
integer y = 720
integer width = 3456
integer height = 956
integer taborder = 120
string dataobject = "d_conceptos_bancarios"
end type

event dw_1::constructor;call super::constructor;//this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)
this.of_SetTransObject(SQLCA)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

// Enable printpreview service
of_SetPrintPreview (true)


end event

event dw_1::buttonclicked;call super::buttonclicked;string id_col
int cant

CHOOSE CASE dwo.name
	CASE 'b_busq_col'
		//Introducimos el c$$HEX1$$f300$$ENDHEX$$digo necesario para hacer una b$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()
		if f_es_vacio(id_col) then return
		this.setitem(row,'id_colegiado',id_col)
		this.setitem(row,'n_colegiado',f_colegiado_n_col(id_col))
		this.setitem(row,'nif',f_devuelve_nif(id_col))
		
	CASE 'b_info_col'
		id_col=this.GetItemString(row,'id_colegiado')
		select count(*) into :cant from colegiados where colegiados.id_colegiado=:id_col;
		if cant >0 then
			if not(f_es_vacio(id_col)) then OpenWithParm(w_fases_ficha_colegiado,id_col)
		else
			MessageBox(g_titulo,'El colegiado NO existe.')
		end if
		
END CHOOSE

end event

event dw_1::pfc_addrow;call super::pfc_addrow;////Introducimos los valores del concepto y de la forma de pago.
dw_1.SetItem(dw_1.rowcount(),'concepto',idw_consulta.GetItemString(1,'concepto'))
dw_1.SetItem(dw_1.rowcount(),'forma_de_pago',idw_consulta.GetItemString(1,'forma_pago'))
dw_1.SetItem(dw_1.rowcount(),'conceptos_domiciliables_empresa',g_empresa)
return ancestorreturnvalue
end event

event dw_1::pfc_insertrow;call super::pfc_insertrow;////Introducimos los valores del concepto y de la forma de pago.
dw_1.SetItem(dw_1.rowcount(),'concepto',idw_consulta.GetItemString(1,'concepto'))
dw_1.SetItem(dw_1.rowcount(),'forma_de_pago',idw_consulta.GetItemString(1,'forma_pago'))
dw_1.SetItem(dw_1.rowcount(),'conceptos_domiciliables_empresa',g_empresa)
return ancestorreturnvalue
end event

event dw_1::pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_debug.enabled = false
end event

event dw_1::itemchanged;call super::itemchanged;string id_col

choose case dwo.name
	case 'n_colegiado'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_colegiado', f_colegiado_id_col(data))
		this.setitem(row,'nif',f_devuelve_nif(id_col))
end choose
this.SetItem(row,'conceptos_domiciliables_empresa',g_empresa)
end event

event dw_1::retrieveend;call super::retrieveend;// MODIFICADO RICARDO 04-09-14
// Cuando carguemos la DW, para todas aquellas filas que no tengan valor les colocamos el valor del check a 'N'
long fila

for fila = 1 to rowcount
	if f_es_vacio(this.GetItemString(fila, 'es_extra')) then this.SetItem(fila, 'es_extra', 'N')
next
// Grabamos la dw, de esta forma el usuario no se entera que estamos tocando el campo
this.update()
// FIN MODIFICADO RICARDO 04-09-14   

end event

type cb_anyadir from w_mant_busq`cb_anyadir within w_domicilia_periodica_lista
integer x = 32
integer y = 1704
integer taborder = 130
end type

event cb_anyadir::clicked;call super::clicked;////Introducimos los valores del concepto y de la forma de pago.
dw_1.SetItem(dw_1.rowcount(),'concepto',idw_consulta.GetItemString(1,'concepto'))
dw_1.SetItem(dw_1.rowcount(),'forma_de_pago',idw_consulta.GetItemString(1,'forma_pago'))
dw_1.SetItem(dw_1.rowcount(),'conceptos_domiciliables_empresa',g_empresa)

end event

type cb_borrar from w_mant_busq`cb_borrar within w_domicilia_periodica_lista
integer x = 334
integer y = 1704
integer width = 283
integer taborder = 140
end type

type cb_ayuda from w_mant_busq`cb_ayuda within w_domicilia_periodica_lista
boolean visible = false
integer x = 3547
integer y = 1104
integer taborder = 40
end type

type st_1 from w_mant_busq`st_1 within w_domicilia_periodica_lista
boolean visible = false
integer x = 101
integer y = 100
integer taborder = 10
end type

type st_2 from w_mant_busq`st_2 within w_domicilia_periodica_lista
boolean visible = false
integer y = 100
integer taborder = 100
end type

type sle_1 from w_mant_busq`sle_1 within w_domicilia_periodica_lista
boolean visible = false
integer y = 100
integer taborder = 90
end type

type sle_2 from w_mant_busq`sle_2 within w_domicilia_periodica_lista
boolean visible = false
integer y = 100
integer taborder = 110
end type

type cb_buscar from w_mant_busq`cb_buscar within w_domicilia_periodica_lista
integer x = 2473
integer y = 32
integer taborder = 30
end type

event cb_buscar::clicked;//SOBREESCRITO para que no aparezcan los botones q hemos heredado
//de w_mant_busq.
string sql_nuevo, sql_original

idw_consulta.accepttext()
idw_consulta_2.accepttext() 
dw_1.AcceptText()

SetPointer(HourGlass!)
sql_nuevo = DW_1.describe("datawindow.table.select")
sql_original = sql_nuevo
//Realizamos la consulta pertinente para que nos salgan los datos q buscamos
f_sql('colegiados.n_colegiado','=','num_colegiado',idw_consulta,sql_nuevo,'1','')
f_sql('conceptos_domiciliables.concepto','=','concepto',idw_consulta,sql_nuevo,'1','')
f_sql('conceptos_domiciliables.forma_de_pago','=','forma_pago',idw_consulta,sql_nuevo,'1','')
f_sql('conceptos_domiciliables.importe','>=','importe_desde',idw_consulta,sql_nuevo,'1','')
f_sql('conceptos_domiciliables.importe','<=','importe_hasta',idw_consulta,sql_nuevo,'1','')
if not f_es_vacio(idw_consulta.getitemstring(1, 'familia')) then
	sql_nuevo = f_sql_join(sql_nuevo, {'( conceptos_domiciliables.concepto = csi_articulos_servicios.codigo )'})
	f_sql('csi_articulos_servicios.familia','=','familia',idw_consulta,sql_nuevo,'1','')
end if
f_sql('colegiados.f_nacimiento','>=','f_nacimiento_desde',idw_consulta_2,sql_nuevo,g_tipo_base_datos,'')
f_sql('colegiados.f_nacimiento','<','f_nacimiento_hasta',idw_consulta_2,sql_nuevo,g_tipo_base_datos,'')
f_sql('colegiados.f_colegiacion','>=','f_coleg_desde',idw_consulta_2,sql_nuevo,'1','')
f_sql('colegiados.f_colegiacion','<','f_coleg_hasta',idw_consulta_2,sql_nuevo,'1','')
f_sql('colegiados.f_titulacion','>=','f_carrera_desde',idw_consulta_2,sql_nuevo,'1','')
f_sql('colegiados.f_titulacion','<','f_carrera_hasta',idw_consulta_2,sql_nuevo,'1','')
f_sql('colegiados.c_geografico','LIKE','residente',idw_consulta_2,sql_nuevo,'1','')
f_sql('colegiados.tipo_persona','LIKE','sociedad',idw_consulta_2,sql_nuevo,'1','')
f_sql('colegiados.situacion','LIKE','situacion',idw_consulta_2,sql_nuevo,'1','')
f_sql('colegiados.alta_baja','LIKE','alta_baja',idw_consulta_2,sql_nuevo,'1','')
f_sql('colegiados.ejerciente','LIKE', 'ejerciente', idw_consulta_2,sql_nuevo, '1', '')

//Para la delegaci$$HEX1$$f300$$ENDHEX$$n
if not isnull(idw_consulta.getitemstring(1,'delegacion')) then
	if PosA(upper(sql_nuevo), "WHERE") > 0 then
		sql_nuevo = sql_nuevo + " and conceptos_domiciliables.id_colegiado IN (SELECT id_colegiado FROM colegiados WHERE delegacion='"+idw_consulta.getitemstring(1,'delegacion')+"')"
	else
		sql_nuevo = sql_nuevo + " WHERE conceptos_domiciliables.id_colegiado IN (SELECT id_colegiado FROM colegiados WHERE delegacion='"+idw_consulta.getitemstring(1,'delegacion')+"')"
	end if	
end if

//messagebox('',sql_nuevo)

dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
dw_1.retrieve()
dw_1.modify("datawindow.table.select= ~"" + sql_original + "~"")



end event

type cb_salir from commandbutton within w_domicilia_periodica_lista
integer x = 3141
integer y = 1708
integer width = 352
integer height = 92
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;// cerramos la ventana.
close(parent)
end event

type cb_1 from commandbutton within w_domicilia_periodica_lista
integer x = 3209
integer y = 292
integer width = 270
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
end type

event clicked;

if rb_col.checked = TRUE then
	dw_1.SetSort("n_colegiado A")
	dw_1.Sort()
	dw_1.groupcalc()
else
	dw_1.SetSort("colegiados_apellidos A, colegiados_nombre A")
	dw_1.Sort()
	dw_1.groupcalc()		
end if	

ids_print.print()
end event

type rb_col from radiobutton within w_domicilia_periodica_lista
integer x = 2587
integer y = 244
integer width = 343
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
string text = "N$$HEX2$$ba002000$$ENDHEX$$Coleg."
boolean checked = true
end type

type rb_ape from radiobutton within w_domicilia_periodica_lista
integer x = 2587
integer y = 316
integer width = 475
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
string text = "Apellidos, nombre"
end type

type em_importe from editmask within w_domicilia_periodica_lista
integer x = 2597
integer y = 596
integer width = 361
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "None"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_domicilia_periodica_lista
integer x = 3209
integer y = 600
integer width = 270
integer height = 80
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Modificar"
end type

event clicked;double importe, importe_origen,resultado
int i



if rb_cuota.checked = true then
if MessageBox(g_titulo,'$$HEX1$$bf00$$ENDHEX$$Desea modificar todos los importes de las cuotas seleccionadas?',Question!,YesNo!)=2 then return

importe = double(em_importe.Text)

for i=1 to dw_1.rowcount()
	dw_1.SetItem(i,'importe',importe)
next
end if

if rb_multiplicar.checked = true then
	if MessageBox(g_titulo,'$$HEX1$$bf00$$ENDHEX$$Desea modificar todos los importes de las cuotas seleccionadas?',Question!,YesNo!)=2 then return

importe = double(em_importe.Text)

for i=1 to dw_1.rowcount()
importe_origen = 	dw_1.getitemnumber(i,'importe')
resultado = importe_origen * importe
f_redondea(resultado)
dw_1.SetItem(i,'importe',resultado)
next
	
	
	
end if

//dw_1.Update()

end event

type tab_1 from tab within w_domicilia_periodica_lista
event create ( )
event destroy ( )
integer x = 37
integer y = 32
integer width = 2395
integer height = 668
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
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
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2359
integer height = 552
long backcolor = 79741120
string text = "General"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_consulta dw_consulta
end type

on tabpage_1.create
this.dw_consulta=create dw_consulta
this.Control[]={this.dw_consulta}
end on

on tabpage_1.destroy
destroy(this.dw_consulta)
end on

type dw_consulta from u_dw within tabpage_1
integer x = 27
integer y = 40
integer width = 2158
integer height = 340
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_concepto_importe_desde_hasta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2359
integer height = 552
long backcolor = 79741120
string text = "Otros Datos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_consulta_2 dw_consulta_2
end type

on tabpage_2.create
this.dw_consulta_2=create dw_consulta_2
this.Control[]={this.dw_consulta_2}
end on

on tabpage_2.destroy
destroy(this.dw_consulta_2)
end on

type dw_consulta_2 from u_dw within tabpage_2
integer x = 27
integer y = 40
integer width = 2318
integer height = 388
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_consulta_gestion_domic_otros_datos"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

type cb_borrar_todos from u_cb within w_domicilia_periodica_lista
integer x = 631
integer y = 1704
integer taborder = 140
boolean bringtotop = true
string text = "Borrar &Todos"
end type

event clicked;call super::clicked;long fila
for fila = dw_1.rowCount() to 1 step -1
	dw_1.deleterow(1)	
next
end event

type rb_cuota from radiobutton within w_domicilia_periodica_lista
integer x = 2592
integer y = 456
integer width = 471
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
string text = "Nueva Cuota"
boolean checked = true
end type

type rb_multiplicar from radiobutton within w_domicilia_periodica_lista
integer x = 2592
integer y = 524
integer width = 530
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
string text = "Multiplicaci$$HEX1$$f300$$ENDHEX$$n importe"
end type

type gb_orden from groupbox within w_domicilia_periodica_lista
integer x = 2473
integer y = 180
integer width = 1024
integer height = 208
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Orden Listado Salida"
end type

type gb_tipo_importe from groupbox within w_domicilia_periodica_lista
integer x = 2473
integer y = 396
integer width = 1024
integer height = 296
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cambio de Importes"
end type

