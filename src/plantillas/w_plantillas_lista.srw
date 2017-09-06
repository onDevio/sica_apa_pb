HA$PBExportHeader$w_plantillas_lista.srw
forward
global type w_plantillas_lista from w_lista
end type
type cb_1 from commandbutton within w_plantillas_lista
end type
end forward

global type w_plantillas_lista from w_lista
integer width = 4503
integer height = 1372
string title = "Lista Previa de Plantillas"
string menuname = "m_plantillas_lista"
cb_1 cb_1
end type
global w_plantillas_lista w_plantillas_lista

on w_plantillas_lista.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_plantillas_lista" then this.MenuID = create m_plantillas_lista
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_plantillas_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event activate;call super::activate;g_dw_lista = dw_lista
g_w_lista = g_lista_plantillas
g_w_detalle = g_detalle_plantillas
g_lista = 'w_plantillas_lista'
g_detalle = 'w_plantillas_detalle'




end event

event csd_detalle;int retorno
retorno = Event closequery()
if retorno = 1 then return


string codigo
//codigo = dw_lista.GetItemString(dw_lista.GetRow(),'modulo')
codigo = dw_lista.GetItemString(dw_lista.GetRow(),'codigo')
OpenWithParm(w_plantillas_campos, codigo)

end event

event csd_nuevo();call super::csd_nuevo;//Opensheet(g_detalle_plantillas,g_detalle,w_aplic_frame,0,original!)
dw_lista.event pfc_addrow()
end event

event pfc_postopen;call super::pfc_postopen;g_dw_lista_plantillas = dw_lista
dw_lista.event csd_retrieve()
end event

event open;call super::open;inv_resize.of_register (this.cb_1, "fixedtoright&bottom")
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_plantillas_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_plantillas_lista
end type

type st_1 from w_lista`st_1 within w_plantillas_lista
integer y = 1044
end type

type dw_lista from w_lista`dw_lista within w_plantillas_lista
event csd_abri_fichero_anexo ( integer fila )
event csd_abrir_plantilla ( )
event csd_nueva_plantilla ( integer fila )
integer x = 37
integer y = 32
integer width = 4375
string dataobject = "d_plantillas_lista"
end type

event dw_lista::csd_abri_fichero_anexo(integer fila);string 	fichero, origen, codigo, extension_fichero, nombre_completo,nombre
long 		correcto

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02

// Desde este script asociamos los anexos que ven$$HEX1$$ed00$$ENDHEX$$an con el registro 

//origen=g_directorio_fotos
correcto=getfileopenname('Selecci$$HEX1$$f300$$ENDHEX$$n del fichero de anexo', nombre_completo, fichero,"doc","Ficheros Word (*.doc;*.docx;*.dot;*.dotx), *.doc;*.docx;*.dot;*.dotx")

if correcto = 1 then
	//Introducimos en el campo clave el valor obtenido desde el contador.
	codigo = f_siguiente_numero('PLANTILLAS',10)
	This.SetItem(this.getrow(),'ruta',fichero)
	
end if
// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02


end event

event dw_lista::csd_abrir_plantilla();OleObject word

string codigo, ruta

ruta = this.getitemstring(this.getrow(),'ruta')

if(fileexists(g_directorio_rtf+ruta)) then
	//Creamos el objeto Ole para manipular los datos del word
	//OleObject word
	word = create OleObject
	word.connecttonewobject("word.application")
	
	word.Documents.open(g_directorio_rtf+ruta)
	word.application.visible = true
	
	word.DisconnectObject()
	destroy word
end if

end event

event dw_lista::csd_nueva_plantilla(integer fila);long correcto
string nombre, ruta, ruta_bda
OleObject word

this.accepttext()

nombre = this.getitemstring(fila, 'descripcion')

if (nombre = '') or isnull(nombre) then
	messagebox(g_titulo_aplicacion,'Debe de introducir el nombre de la plantilla en el campo descripci$$HEX1$$f300$$ENDHEX$$n')
else
//	ruta_bda = g_directorio_rtf + 'correspondencias.mdb'
	ruta = g_directorio_rtf + nombre + '.doc'
	if (fileExists(ruta)) then 
		this.event csd_abrir_plantilla()
	else
		//Creamos el objeto Ole para manipular los datos del word
		//OleObject word
		word = create OleObject
		word.connecttonewobject("word.application")

		word.Documents.Add()
//		word.ActiveDocument.MailMerge.openDataSource(ruta_bda,0,0,0,0,0,'','',0,'','','','TABLE colegiados')
		word.ActiveDocument.saveas(ruta)	
		word.application.visible = true
		this.setitem(fila, 'ruta', nombre + '.doc')
	
		word.DisconnectObject()
		destroy word
		this.update()
	end if
end if
end event

event dw_lista::buttonclicked;call super::buttonclicked;// Se ejecuta el evento del dialogo
choose case dwo.name
	case 'b_busca_ruta'
		this.Post Event csd_abri_fichero_anexo(this.getrow())	
	case 'b_nuevo'
		this.event csd_nueva_plantilla(this.getrow())
	case 'b_abrir'
		this.event csd_abrir_plantilla()
end choose
end event

event dw_lista::pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = True
am_dw.m_table.m_addrow.enabled = True
am_dw.m_table.m_delete.enabled = True
end event

event dw_lista::pfc_addrow;call super::pfc_addrow;this.SetItem(this.GetRow(),'codigo',f_siguiente_numero('PLANTILLAS',10))
RETURN 1
end event

event dw_lista::pfc_insertrow;call super::pfc_insertrow;this.SetItem(this.GetRow(),'codigo',f_siguiente_numero('PLANTILLAS',10))
RETURN 1
end event

event dw_lista::doubleclicked;event csd_detalle()
end event

event dw_lista::pfc_predeleterow;call super::pfc_predeleterow;string ruta
int respuesta
boolean borrado

ruta = this.getitemstring(this.GetRow(),'ruta')

respuesta = MessageBox(g_titulo_aplicacion,"Se va a borrar la plantilla, $$HEX1$$bf00$$ENDHEX$$desea continuar?",Exclamation!, OKCancel!, 2)

if respuesta = 1 then
	//Si el fichero no existe devolvemos el error -1
	if (not FileExists(ruta)) or isnull(ruta) then 
		return ancestorreturnvalue
	else
		borrado = filedelete(ruta)
	end if

	if borrado = true then
		return ancestorreturnvalue
	else
		return -1
	end if
else
	return -1
end if
end event

type cb_consulta from w_lista`cb_consulta within w_plantillas_lista
end type

type cb_detalle from w_lista`cb_detalle within w_plantillas_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_plantillas_lista
end type

type cb_1 from commandbutton within w_plantillas_lista
integer x = 4114
integer y = 1024
integer width = 293
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;string campo_formulario, campo_interno
int num_plantilla, retorno
string codigo

datastore ds_imprimir_plantilla

retorno = parent.event closequery()
if retorno = 1 then return

codigo=dw_lista.getitemstring(dw_lista.getrow(),'codigo')

ds_imprimir_plantilla = create datastore
ds_imprimir_plantilla.dataobject = 'd_plantillas_listado'
ds_imprimir_plantilla.SetTransObject(SQLCA)

ds_imprimir_plantilla.Retrieve(codigo)
ds_imprimir_plantilla.print()




destroy ds_imprimir_plantilla
end event

