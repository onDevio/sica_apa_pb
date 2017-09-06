HA$PBExportHeader$w_carta_propiedad.srw
forward
global type w_carta_propiedad from w_response
end type
type cb_3 from commandbutton within w_carta_propiedad
end type
type cb_2 from commandbutton within w_carta_propiedad
end type
type cb_1 from commandbutton within w_carta_propiedad
end type
type dw_lista from u_dw within w_carta_propiedad
end type
type dw_consulta from u_dw within w_carta_propiedad
end type
type st_1 from statictext within w_carta_propiedad
end type
type dw_1 from u_dw within w_carta_propiedad
end type
type cb_marcar from commandbutton within w_carta_propiedad
end type
type cb_desmarcar from commandbutton within w_carta_propiedad
end type
end forward

global type w_carta_propiedad from w_response
integer width = 2491
integer height = 1900
string title = "Comunicaci$$HEX1$$f300$$ENDHEX$$n Propiedad"
boolean ib_isupdateable = false
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_lista dw_lista
dw_consulta dw_consulta
st_1 st_1
dw_1 dw_1
cb_marcar cb_marcar
cb_desmarcar cb_desmarcar
end type
global w_carta_propiedad w_carta_propiedad

type variables
string isql_original
end variables

on w_carta_propiedad.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_lista=create dw_lista
this.dw_consulta=create dw_consulta
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_marcar=create cb_marcar
this.cb_desmarcar=create cb_desmarcar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_lista
this.Control[iCurrent+5]=this.dw_consulta
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.cb_marcar
this.Control[iCurrent+9]=this.cb_desmarcar
end on

on w_carta_propiedad.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_lista)
destroy(this.dw_consulta)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_marcar)
destroy(this.cb_desmarcar)
end on

event open;call super::open;f_centrar_ventana(this)

dw_consulta.insertrow(0)
dw_1.insertrow(0)

this.of_setresize(true)

inv_resize.of_Register (cb_1, "FixedToBottom")
inv_resize.of_Register (cb_2, "FixedToRight&Bottom")
inv_resize.of_Register (cb_3, "FixedToBottom")

inv_resize.of_Register (dw_consulta, "ScaleToRight")
inv_resize.of_Register (dw_lista, "ScaleToRight&Bottom")

isql_original = dw_lista.describe("datawindow.table.select")	

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_carta_propiedad
integer x = 2080
integer y = 1224
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_carta_propiedad
integer x = 2080
integer y = 1096
integer taborder = 0
end type

type cb_3 from commandbutton within w_carta_propiedad
integer x = 1202
integer y = 1660
integer width = 416
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir Cartas"
end type

event clicked;// Evento que rellena la carta de comunicaci$$HEX1$$f300$$ENDHEX$$n a la propiedad (Zaragoza)
string sl_cliente, sl_fecha, pobla, sl_colegiado, sl_f_inicio='', id_col, n_col, apell, id_cliente_mayor_porc
string nomb, nif, daf, paf, descripcion, id_cliente, t_via, nomvia, numero, des_via, emplazamiento, cp
long j, i, porc_cli_mayor = 0, fila
datetime ldtt_hoy, f_inicio
date ldt_hoy

datastore ds_imprime_hoja
ds_imprime_hoja = create datastore
string sl_formato_de_carta
CHOOSE CASE upper(g_colegio)
	CASE 'COAATZ'
		sl_formato_de_carta='d_oficio_cli_za'		
	CASE 'COAATGU'
		sl_formato_de_carta='d_oficio_cli_gu'
	CASE ELSE
		sl_formato_de_carta='d_oficio_cli_za'
END CHOOSE
ds_imprime_hoja.dataobject = sl_formato_de_carta
ds_imprime_hoja.settransobject(sqlca)

// Fecha de hoy
ldtt_hoy =datetime(today(),now())
ldt_hoy  = today()
sl_fecha = g_col_ciudad + ', ' + string(day(ldt_hoy)) + ' de ' + lower(f_obtener_mes (ldtt_hoy)) + ' de ' + string(year(ldt_hoy))

for j=1 to dw_lista.rowcount()
	if dw_lista.GetItemString(j,'impr')='N' then continue
		
	// Otros datos del contrato
	t_via = dw_lista.getitemstring(j,"tipo_via_emplazamiento")
	nomvia = dw_lista.getitemstring(j,"emplazamiento")
	numero = dw_lista.getitemstring(j,"n_calle")
	cp = dw_lista.getitemstring(j,"poblacion")
	descripcion = dw_lista.getitemstring(j, 'descripcion')
	pobla = f_poblacion_descripcion(cp)
	des_via = f_dame_desc_tipo_via(t_via)
	
	if isnull(des_via) then des_via = ""
	if isnull(nomvia) then nomvia = ""
	if isnull(numero) then numero = ""
	if isnull(cp) then cp = ""
	if isnull(pobla) then pobla = ""
	if isnull(descripcion) then descripcion = ""
	
	emplazamiento = trim(des_via) + " " + trim(nomvia) + " " + trim(numero)

	datastore ds_fases_promotores
	ds_fases_promotores = create datastore
	ds_fases_promotores.dataobject = 'd_fases_promotores'
	ds_fases_promotores.SetTransObject(SQLCA)
	ds_fases_promotores.retrieve(dw_lista.getitemstring(j, 'id_fase'))	
	
	CHOOSE CASE g_colegio
		CASE 'COAATGU' // Vamos a coger el cliente de mayor %
			for i = 1 to ds_fases_promotores.rowcount()
				if ds_fases_promotores.getitemnumber(i, 'porcen') > porc_cli_mayor then
					id_cliente_mayor_porc = ds_fases_promotores.getitemstring(i, 'id_cliente')
				end if
			next
			sl_cliente = f_cliente_etiqueta(id_cliente_mayor_porc)
			
			fila = ds_imprime_hoja.insertrow(0)
			
			ds_imprime_hoja.setitem(fila,"emplazamiento",emplazamiento)  
			ds_imprime_hoja.setitem(fila,"descripcion",descripcion)
			ds_imprime_hoja.setitem(fila,"fecha",sl_fecha)
			ds_imprime_hoja.setitem(fila,"localidad",pobla)
			ds_imprime_hoja.setitem(fila,"n_contrato",dw_lista.getitemstring(j, 'n_registro'))
			ds_imprime_hoja.setitem(fila,"eti_cliente",sl_cliente)
			
			ds_imprime_hoja.setitem(fila,"n_expediente",dw_lista.getitemstring(j, 'n_expedi'))
			ds_imprime_hoja.setitem(fila,"n_visado",dw_lista.getitemstring(j, 'fases_archivo'))
	
		CASE 'COAATZ' // Una carta por cliente
			for i = 1 to ds_fases_promotores.rowcount()
				fila = ds_imprime_hoja.insertrow(0)
				
				ds_imprime_hoja.setitem(fila,"emplazamiento",emplazamiento)  
				ds_imprime_hoja.setitem(fila,"descripcion",descripcion)
				ds_imprime_hoja.setitem(fila,"fecha",sl_fecha)
				ds_imprime_hoja.setitem(fila,"localidad",pobla)
				ds_imprime_hoja.setitem(fila,"n_contrato",dw_lista.getitemstring(j, 'n_registro'))
				sl_cliente = f_cliente_etiqueta(ds_fases_promotores.getitemstring(i, 'id_cliente'))
				ds_imprime_hoja.setitem(fila,"eti_cliente",sl_cliente)
			next		
	END CHOOSE
next

if ds_imprime_hoja.rowcount() > 0 then
	for i=1 to long(dw_1.getitemstring(1, 'n_copias'))
		ds_imprime_hoja.print()
	next
end if

destroy ds_imprime_hoja
destroy ds_fases_promotores

end event

type cb_2 from commandbutton within w_carta_propiedad
integer x = 2016
integer y = 1660
integer width = 416
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_carta_propiedad
integer x = 1202
integer y = 1660
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir listado"
end type

event clicked;//double i, fila
//
//If dw_lista.rowcount() <= 0 then
//	messagebox(g_titulo, 'No ha seleccionado ninguna obra')
//	return
//end if
//
//datastore ds_listado
//ds_listado = create datastore
//ds_listado.dataobject = 'd_arte_cemento_listado'
//
// for i = 1 to dw_lista.rowcount()
//
//	fila = ds_listado.insertrow(0)
//    ds_listado.setitem(fila,'fecha_visado',dw_lista.getitemdatetime(i,'fases_f_visado'))
//    ds_listado.setitem(fila,'tipo_actuacion',f_dame_desc_tipo_actuacion(dw_lista.getitemstring(i,'fases_fase')))
//    ds_listado.setitem(fila,'tipo_obra',f_dame_desc_tipo_obra(dw_lista.getitemstring(i,'fases_tipo_trabajo')))
//    ds_listado.setitem(fila,'tipo_uso',f_dame_desc_destino_obra(dw_lista.getitemstring(i,'fases_trabajo')))
//    ds_listado.setitem(fila,'calle',dw_lista.getitemstring(i,'fases_emplazamiento'))
//    ds_listado.setitem(fila,'numero',dw_lista.getitemstring(i,'fases_n_calle'))
//    ds_listado.setitem(fila,'poblacion',dw_lista.getitemstring(i,'poblaciones_descripcion'))
//    ds_listado.setitem(fila,'cliente_nombre',dw_lista.getitemstring(i,'clientes_nombre'))
//    ds_listado.setitem(fila,'cliente_apellidos',dw_lista.getitemstring(i,'clientes_apellidos'))
//    ds_listado.setitem(fila,'presupuesto',dw_lista.getitemnumber(i,'fases_usos_pem'))
//    ds_listado.setitem(fila,'num',dw_lista.getitemnumber(i,'fases_usos_num_viv'))
//    ds_listado.setitem(fila,'expediente',dw_lista.getitemstring(i,'fases_n_expedi'))
//next
//
//ds_listado.print()
////MODIFICADO RICARDO 04-03-02
//if messageBox(g_titulo, "$$HEX1$$bf00$$ENDHEX$$Desea guardar el listado impreso en fichero?", question!, yesno!, 2)=1 then
//	// Permitimos que el listado pueda ser guardado en fichero
//	n_cst_filesrvwin32 cambia_directorio
//	string directorio, nombrefichero
//	cambia_directorio = create n_cst_filesrvwin32
//	directorio = cambia_directorio.of_getcurrentdirectory()
//	if GetFileSaveName('Seleccione nombre de fichero',NombreFichero,NombreFichero,'.txt','Ficheros de datos (*.txt),*.txt')<> 1 Then 
//		// MODIFICADO RICARDO 04-03-02
//		// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
//		cambia_directorio.of_changedirectory(directorio)
//		destroy cambia_directorio
//		// FIN MODIFICADO RICARDO 04-03-02
//		return
//	end if	
//	ds_listado.saveasascii(nombrefichero)
//	// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
//	cambia_directorio.of_changedirectory(directorio)
//	destroy cambia_directorio
//end if
////FIN MODIFICADO RICARDO 04-03-02
//destroy ds_listado
//
end event

type dw_lista from u_dw within w_carta_propiedad
integer x = 37
integer y = 572
integer width = 2395
integer height = 1032
integer taborder = 20
string dataobject = "d_carta_propiedad_lista_za"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False

end event

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)
inv_sort.of_SetStyle (2)

end event

type dw_consulta from u_dw within w_carta_propiedad
integer x = 37
integer y = 32
integer width = 2048
integer height = 416
integer taborder = 10
string dataobject = "d_carta_propiedad_consulta"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event buttonclicked;call super::buttonclicked;string sql_nuevo

choose case dwo.name
	case 'b_1'
		SetPointer(HourGlass!)
		dw_consulta.AcceptText()
		
		if isnull(dw_consulta.getitemdatetime(1, 'f_abono_desde')) and &
		   isnull(dw_consulta.getitemdatetime(1, 'f_abono_hasta')) and &
		   f_es_vacio(dw_consulta.getitemstring(1, 'n_visado')) and &			
		   isnull(dw_consulta.getitemdatetime(1, 'f_entrada_desde')) and &
            isnull(dw_consulta.getitemdatetime(1, 'f_entrada_hasta')) and &
            f_es_vacio(dw_consulta.getitemstring(1, 'n_registro'))  then return
		
		sql_nuevo = dw_lista.describe("datawindow.table.select")		
				
		f_sql('fases.f_abono','>=','f_abono_desde',dw_consulta,sql_nuevo,'1','')
		f_sql('fases.f_abono','<','f_abono_hasta',dw_consulta,sql_nuevo,'1','')
		f_sql('fases.f_entrada','>=','f_entrada_desde',dw_consulta,sql_nuevo,'1','')
		f_sql('fases.f_entrada','<','f_entrada_hasta',dw_consulta,sql_nuevo,'1','')
		f_sql('fases.n_registro','LIKE','n_registro',dw_consulta,sql_nuevo,'1','')
		f_sql('fases.archivo','LIKE','n_visado',dw_consulta,sql_nuevo,'1','')
		
		dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
		
		dw_lista.retrieve()
		
		dw_lista.modify("datawindow.table.select= ~"" + isql_original + "~"")
end choose

end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

type st_1 from statictext within w_carta_propiedad
integer x = 96
integer y = 480
integer width = 1431
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean italic = true
long textcolor = 8388608
long backcolor = 67108864
string text = "Borre con bot$$HEX1$$f300$$ENDHEX$$n derecho las obras de las que no desee la carta:"
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_carta_propiedad
integer x = 667
integer y = 1660
integer width = 480
integer height = 112
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_n_copias"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;string num

CHOOSE CASE dwo.name
	CASE 'b_mas'
		num = this.getitemstring(1, 'n_copias')
		if num < '98' then this.setitem(1, 'n_copias', string(integer(num) + 1, '00'))
	CASE 'b_men'
		num = this.getitemstring(1, 'n_copias')
		if num > '00' then this.setitem(1, 'n_copias', string(integer(num) - 1, '00'))
END CHOOSE

end event

event itemchanged;call super::itemchanged;if not isnumber(data) then this.post setitem(1, 'n_copias', '00')

end event

type cb_marcar from commandbutton within w_carta_propiedad
integer x = 37
integer y = 1636
integer width = 430
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Marcar Todos"
end type

event clicked;long i
for i=1 to dw_lista.RowCount() 
	dw_lista.SetItem(i,'impr','S')
next
end event

type cb_desmarcar from commandbutton within w_carta_propiedad
integer x = 37
integer y = 1716
integer width = 430
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Desmarcar Todos"
end type

event clicked;long i
for i=1 to dw_lista.RowCount() 
	dw_lista.SetItem(i,'impr','N')
next
end event

