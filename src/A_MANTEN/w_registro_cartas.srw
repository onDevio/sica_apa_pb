HA$PBExportHeader$w_registro_cartas.srw
forward
global type w_registro_cartas from w_mant_simple
end type
type dw_2 from u_dw within w_registro_cartas
end type
type cb_1 from commandbutton within w_registro_cartas
end type
end forward

global type w_registro_cartas from w_mant_simple
integer width = 3237
integer height = 1872
string title = "Registro de cartas"
dw_2 dw_2
cb_1 cb_1
end type
global w_registro_cartas w_registro_cartas

on w_registro_cartas.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_1
end on

on w_registro_cartas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.cb_1)
end on

event open;call super::open;dw_2.insertrow(0)
end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_registro_cartas
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_registro_cartas
end type

type dw_1 from w_mant_simple`dw_1 within w_registro_cartas
integer x = 37
integer y = 436
integer width = 3131
integer height = 1196
string dataobject = "d_registro_cartas"
end type

event dw_1::constructor;call super::constructor;this.of_SetRowSelect(TRUE)
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








this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event dw_1::doubleclicked;string ruta_plantilla
OleObject word

//Busca la ruta donde se encuentra el documento guardado
ruta_plantilla = g_directorio_documentos_plantillas+ dw_1.getitemstring(this.getrow(), 'ruta_fichero')+dw_1.getitemstring(this.getrow(), 'nombre_fichero')

//Se creo el objeto word
word = create OleObject
//conecta con la aplicaci$$HEX1$$f300$$ENDHEX$$n de word
word.connecttonewobject("word.application")
//Verifica que exista el documento
if (fileExists(ruta_plantilla)) then 
	//Abre el documento 
	word.Documents.open(ruta_plantilla)
	word.application.visible = true
else
	messagebox(g_titulo, g_idioma.of_getmsg('general.msg_fich_no_existe',"No existe el fichero en esa ruta"))
	
end if
end event

event dw_1::buttonclicked;call super::buttonclicked;string id_colegiado

choose case dwo.name
		
		
	case 'b_colegiado'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		
		id_colegiado=f_busqueda_colegiados()
		if f_es_vacio(id_colegiado) then return
		this.setitem(row,'id_referencia',id_colegiado)
		
		
case 'b_fichero'
		string ls_ruta_doc,ls_nom_doc,ls_ruta_guardar,ls_ruta_dest
		string ls_ruta_relativa_documentos
		int li_valor
		n_file_dialogs lnv_file_dialog
		n_cst_filesrvwin32 lnv_filesrv
		boolean lb_existe
		
		lnv_filesrv=create n_cst_filesrvwin32
		ls_ruta_relativa_documentos=g_anyo_numeracion+'\Plantillas\'+dw_1.getitemstring(dw_1.getrow(),'n_registro')		
		ls_ruta_guardar=g_directorio_documentos_plantillas+ls_ruta_relativa_documentos+"\"
			
		//Comprobamos que existe g_directorio_documentos_fases+g_anyo_numeracion ya que sino, no podemos crear
		//un directorio por debajo de este
		
		lb_existe=lnv_filesrv.of_directoryexists(g_directorio_documentos_plantillas+g_anyo_numeracion+'\Plantillas\')
		
		if not lb_existe then
			li_valor=lnv_filesrv.of_createdirectory(g_directorio_documentos_plantillas+g_anyo_numeracion+'\Plantillas\')
		end if
		
		if li_valor=-1 then 
			Messagebox(g_idioma.of_getmsg('general.error','Error'),g_idioma.of_getmsg('general.error_dir_contratos','Error al crear el directorio donde se copiar$$HEX1$$e100$$ENDHEX$$n los documentos asociados a este contrato.')&
			+cr+g_idioma.of_getmsg('general.dir_asegurar','Aseg$$HEX1$$fa00$$ENDHEX$$rese de que el directorio ')+g_directorio_documentos_plantillas+g_idioma.of_getmsg('general.existe',' existe.'),StopSign!)
			return
	   end if
		//Seleccionamos el fichero y lo copiamos al directorio adecuado
		//S$$HEX1$$f300$$ENDHEX$$lo permitimos seleccionar un fichero
		lnv_file_dialog.ib_allowmultiselect = false

		li_valor = lnv_file_dialog.of_getopenfilename("Seleccionar Documento", ls_ruta_doc, ls_nom_doc,"", "Todos los archivos,*.*,")
		if li_valor = 1 then
			//creamos el directorio y copiamos el fichero
			ls_ruta_dest=ls_ruta_guardar+ls_nom_doc
			lnv_filesrv.of_createdirectory(ls_ruta_guardar)
			lnv_filesrv.of_filecopy(ls_ruta_doc + "\" + ls_nom_doc, ls_ruta_dest, FALSE)
			//guardamos el nombre del fichero
			this.setitem(row,'nombre_fichero',ls_nom_doc) 
			this.setitem(row,'ruta_fichero',ls_ruta_relativa_documentos)
		end if 		
		
end choose

end event

event dw_1::pfc_insertrow;call super::pfc_insertrow;
////Se ingresa en el campo clave de la DW el valor obtenido desde el contador
//this.setitem(this.getrow(), 'id_carta', f_siguiente_numero('ID_CARTA', 10))
//this.setitem(this.getrow(), 'n_registro',f_siguiente_numero('N_REGISTRO', 10))
//this.setitem(this.getrow(), 'tipo','')
//this.setitem(this.getrow(), 'modulo_asociado','CO')
//this.setitem(this.getrow(), 'cod_usuario',g_usuario)
trigger event pfc_addrow()
return 1
end event

event dw_1::retrieveend;call super::retrieveend;SetPointer(Arrow!)
end event

event dw_1::pfc_addrow;call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.getrow(), 'id_carta', f_siguiente_numero('ID_CARTA', 10))
this.setitem(this.getrow(), 'n_registro',f_siguiente_numero('N_REGISTRO', 10))
this.setitem(this.getrow(), 'tipo','')
this.setitem(this.getrow(), 'plantilla','0000000000')
this.setitem(this.getrow(), 'modulo_asociado','COLEGIADOS')
this.setitem(this.getrow(), 'cod_usuario',g_usuario)
this.setitem(this.getrow(), 'fecha', today())
return 1
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_registro_cartas
boolean visible = false
integer x = 37
end type

type cb_borrar from w_mant_simple`cb_borrar within w_registro_cartas
boolean visible = false
integer x = 329
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_registro_cartas
boolean visible = false
integer x = 1358
end type

type dw_2 from u_dw within w_registro_cartas
integer x = 27
integer y = 36
integer width = 2098
integer height = 392
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_busqueda_cartas"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event buttonclicked;call super::buttonclicked;string id_persona

g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
g_busqueda.dw="d_lista_busqueda_colegiados"
id_persona=f_busqueda_colegiados()
this.setitem(1,'n_colegiado',f_colegiado_n_col(id_persona))
this.setitem(1,'id_colegiado',id_persona)
end event

type cb_1 from commandbutton within w_registro_cartas
string tag = "texto=general.buscar"
integer x = 2254
integer y = 212
integer width = 366
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Buscar"
end type

event clicked;string sql_nuevo, sql_old, ls_cadena
ls_cadena=''
dw_2.AcceptText()
sql_nuevo=dw_1.describe("datawindow.table.select")
sql_old = sql_nuevo

f_sql('cartas.id_referencia','LIKE','id_colegiado',dw_2,sql_nuevo,g_tipo_base_datos,'')
f_sql('cartas.fecha','>=','f_desde',dw_2,sql_nuevo,g_tipo_base_datos,'')
f_sql('cartas.fecha','<=','f_hasta',dw_2,sql_nuevo,g_tipo_base_datos,'')
f_sql('cartas.plantilla','LIKE','plantilla',dw_2,sql_nuevo,g_tipo_base_datos,'')

//if dw_2.getitemstring(1,'plantilla') ='0000000000' then
//	sql_nuevo +=" and cartas.tipo <> ''"
//else
//	f_sql('cartas.plantilla','LIKE','plantilla',dw_2,sql_nuevo,g_tipo_base_datos,'')
//end if

//messagebox("sql_nuevo", sql_nuevo)

dw_1.modify("Datawindow.table.select=~"" + sql_nuevo + "~"")
dw_1.Retrieve('%')


dw_1.modify("datawindow.table.select= ~"" + sql_old + "~"")
end event

