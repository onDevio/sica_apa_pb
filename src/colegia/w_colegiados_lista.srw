HA$PBExportHeader$w_colegiados_lista.srw
forward
global type w_colegiados_lista from w_lista
end type
type dw_mailing from u_dw within w_colegiados_lista
end type
type dw_1 from datawindow within w_colegiados_lista
end type
type dw_2 from datawindow within w_colegiados_lista
end type
type cb_consell from commandbutton within w_colegiados_lista
end type
type cb_directorio from commandbutton within w_colegiados_lista
end type
end forward

global type w_colegiados_lista from w_lista
integer width = 3625
integer height = 1364
string title = "Lista Previa de Colegiados"
string menuname = "m_lista_colegiados"
event csd_genera_lista_personal ( )
event csd_genera_facturas_personal ( )
event csd_plantillas ( )
event csd_mailing ( )
event csd_email ( )
event csd_registro_cartas ( string plantilla )
dw_mailing dw_mailing
dw_1 dw_1
dw_2 dw_2
cb_consell cb_consell
cb_directorio cb_directorio
end type
global w_colegiados_lista w_colegiados_lista

type prototypes
SUBROUTINE Sleep(ulong milli) LIBRARY "Kernel32.dll"

end prototypes

type variables
OleObject i_word
string i_adjuntos_full
end variables

event csd_genera_lista_personal();string id_col_ant

if dw_lista.RowCount() = 0 then return

//Obtener nombre de la nueva lista:
string id_lista, nombre_lista
open(w_listas_nombre_lista)
if Message.StringParm = '' then return
nombre_lista = Message.StringParm

//Generar cabecera de la lista
id_lista = f_siguiente_numero('LISTAS_COLEGIADOS',10)
Datastore ds_lista
ds_lista = create datastore
ds_lista.DataObject = 'd_listas_detalle'
ds_lista.SetTransObject(SQLCA)
ds_lista.InsertRow(0)
ds_lista.SetItem(1,'id_lista',id_lista)
ds_lista.setitem(1, 'fecha_creacion', datetime(Today()))
ds_lista.setitem(1, 'activa', 'S')
ds_lista.setitem(1, 'propietario', g_usuario)
ds_lista.setitem(1, 'nombre_lista', nombre_lista)

//Generar los miembros de la lista:
Datastore ds_lista_miembros
ds_lista_miembros = create datastore
ds_lista_miembros.DataObject = 'd_listas_miembros'
ds_lista_miembros.SetTransObject(SQLCA)
string id_col
long i
SetPointer(Hourglass!)
FOR i=1 TO dw_lista.RowCount()
	id_col = dw_lista.GetItemString(i,'id_colegiado')
	//Luis CBI-135
	if(id_col <> id_col_ant)then
		ds_lista_miembros.InsertRow(0)
		ds_lista_miembros.SetItem(ds_lista_miembros.RowCount(), 'id_lista',id_lista) 
		ds_lista_miembros.SetItem(ds_lista_miembros.RowCount(), 'id_lista_miembro',id_col) 
		ds_lista_miembros.SetItem(ds_lista_miembros.RowCount(), 'id_cliente','X') 
	end if
	id_col_ant = id_col
NEXT
ds_lista.Update()
ds_lista_miembros.Update()
destroy ds_lista
destroy ds_lista_miembros
Messagebox(g_titulo,g_idioma.of_getmsg('colegiados.proceso_finalizado',"Proceso finalizado!"),Information!)
end event

event csd_genera_facturas_personal;open(w_colegiados_factura_n)
end event

event csd_plantillas();// **********************************		DECLARACION DE VARIABLES		*************************** 
int i, j
datastore ds_colegiados
double insertadas
string id_col, codigo, ruta,email, n_col, tipo_persona, circulares_mail
st_retorno_seleccion retorno
n_csd_plantillas uo_plantillas
n_csd_impresion_formato uo_impresion

uo_impresion= create n_csd_impresion_formato

// **********************************		SELECCIONAMOS LA PLANTILLA 		***************************
//Abrimos la ventana de selecci$$HEX1$$f300$$ENDHEX$$n de plantillas
st_plantillas_seleccion datos_plantillas
datos_plantillas.modulo='COLEGIADOS'
if dw_lista.rowcount()=1 then
	datos_plantillas.mostrar_cbx_editar_plantilla=true
	uo_impresion.ruta_relativa3 = dw_lista.GetItemString(dw_lista.GetRow(),'n_colegiado')
	uo_impresion.masivo=false
else
	datos_plantillas.mostrar_cbx_editar_plantilla=false
	uo_impresion.masivo=true
end if

OpenwithParm(w_plantillas_seleccion,datos_plantillas)

retorno = Message.powerobjectparm

if retorno.ruta = '-1' then return

uo_impresion.nombre = left(retorno.ruta, len(retorno.ruta) - 4) + '_'+string(today(),'yyyymmdd')
uo_impresion.masivo_cambiar_nombre=true
uo_impresion.masivo_cambiar_asunto=true
uo_impresion.papel = 'S'
uo_impresion.sms = 'X'
uo_impresion.ruta_automatica=true

uo_impresion.serie='COLEGIA'
uo_impresion.generar_registro='X'

retorno.ruta = g_directorio_rtf + retorno.ruta

if not fileexists(retorno.ruta) then
	messagebox(g_titulo_aplicacion,g_idioma.of_getmsg('colegiados.plantilla','La plantilla seleccionada no existe'))
	return	
end if

if uo_impresion.f_opciones_impresion()=-1 then return


//Valida que cuando la plantilla es de caracter individual debe haber solo un colegiado
if dw_lista.rowcount()>1 and retorno.individual = 'S' then
	messagebox(g_titulo,g_idioma.of_getmsg('colegiados.seleccion-colegiado',"Seleccione solo un colegiado para generar el documento"))
	return
end if

//Creamos el datastore de Colegiados para las plantillas de colegiados
ds_colegiados = create datastore
ds_colegiados.dataobject = 'd_plantillas_colegiados'

// Creamos el objeto de plantillas y rellenamos sus parametros
uo_plantillas=create n_csd_plantillas
uo_plantillas.ruta_plantilla = retorno.ruta
uo_plantillas.mdb='plantillas.txt'
uo_plantillas.ruta_mdb=g_directorio_rtf+'plantillas.txt'
uo_plantillas.i_impresion = uo_impresion
setpointer(hourglass!)

// ********		RELLENAMOS EL DATASTORE CON LOS DATOS DE LOS COLEGIADOS   ********
//Para cada colegiado... deberemos llamar a la funcion de f_colegiados_rellena_estructura
for i= 1 to dw_lista.rowcount()
	id_col = dw_lista.GetItemString(i,'id_colegiado')
	n_col = dw_lista.getitemstring(i, 'n_colegiado')
	f_colegiados_rellena_estructura(id_col,ds_colegiados,retorno)
	//Modificado Jesus CLE-121 
	//Mejora para enviar la plantilla solo a los que tienen 'Circulares Mail' activado (Colegiados -> Otros Datos -> Otros Datos)
//	choose case g_colegio
//			
//		case 'COAATLE'
//			//Comprobamos si quiere circulares mail o no
//			SELECT s_n into :circulares_mail
//			FROM otros_datos_colegiado
//			WHERE id_colegiado= :id_col and cod_caracteristica='04' ; //Codigo de 'CIRCULARES EMAIL'
//			
//			if circulares_mail = 'S' and (retorno.codigo = '' or retorno.codigo='') then
//				//*** Poner codigos de plantillas una vez insertadas en la tabla plantillas ***//
//				f_colegiados_rellena_estructura(id_col,ds_colegiados,retorno)
//			end if
//			
//		case else
//			f_colegiados_rellena_estructura(id_col,ds_colegiados,retorno)
//			
//	end choose	
next
	
// **********************************		COMBINAMOS CON WORD			***************************
if ds_colegiados.rowcount() > 0 then
	uo_plantillas.nombre_plantilla = f_obtiene_nombre_plantilla(retorno.codigo)
	uo_plantillas.is_modulo_asociado = retorno.modulo
	//Si la plantilla es masiva se selecciona el Colegiado Ficticio
	if retorno.individual = 'N' then
		uo_plantillas.is_colegiado = string(g_colegiado_comodin)
	else
		uo_plantillas.is_colegiado = n_col
	end if
	
	uo_plantillas.is_codigo = retorno.codigo
	uo_plantillas.is_registro = ds_colegiados.getitemstring(1, 'registro_salida')
	//Introducido por Alexis para que se guarden los registros de impresi$$HEX1$$f300$$ENDHEX$$n.
//	uo_plantillas.is_modulo_asociado = retorno.modulo
//	uo_plantillas.is_colegiado = n_col
	//Fin introducio por Alexis. 15/09/2009
	uo_plantillas.f_combinar_plantilla()
	
	//if g_colegio = 'COAATA' then event csd_registro_cartas(retorno.codigo)
else
	messagebox(g_titulo,g_idioma.of_getmsg('colegiados.fallo_captura', "Imposible generar los documentos por un fallo en la captura de datos"))
end if
	

//Destruimos los datastores, el objeto ole y desconectamos.
destroy ds_colegiados

setpointer(arrow!)


end event

event csd_mailing();// Ver evento csd_email
/* 
// Sistema de envio por mail antiguo (Usa el Outlook)
if dw_lista.RowCount() = 0 then 
	Messagebox(g_titulo,'No se han seleccionado colegiados.', StopSign!)
	return
end if


long i
string direccion,todas
string apellidos,nombre
todas = ''
direccion = ''
for i = 1 to dw_lista.RowCOunt()
	apellidos = dw_lista.GetItemString(i,'apellidos')
	nombre = dw_lista.GetItemString(i,'nombre')
	if isnull(apellidos) then apellidos = ''
	if isnull(nombre) then nombre = ''
	direccion = dw_lista.GetItemString(i,'email') 
	if not f_es_vacio(direccion) then
		if todas = '' then
			todas = nombre + ' ' + apellidos + '<' + direccion + '>'
		else
			todas += ';' + nombre + ' ' + apellidos + '<' + direccion + '>'
		end if
	end if
Next

if f_es_vacio(todas) then 
	MessageBox(g_titulo,'Ning$$HEX1$$fa00$$ENDHEX$$n colegiado de los seleccionados tiene definida un direcci$$HEX1$$f300$$ENDHEX$$n de correo electr$$HEX1$$f300$$ENDHEX$$nico v$$HEX1$$e100$$ENDHEX$$lida.',StopSign!)
	return
end if


dw_mailing.InsertRow(0)
dw_mailing.visible = true

dw_mailing.SetItem(1,'destinatario',todas)
dw_mailing.SetFocus()
*/

end event

event csd_email();// Sistema de envio de mails usando sockets
st_mail parametros
string email, direcciones
int i

//parametros.asunto = ''
//parametros.mensaje = ''

// Obtenemos las direcciones de los colegiados de la lista y las concatenamos
parametros.dw_adjuntos='d_email_adjuntos'
for i=1 to dw_lista.rowcount()
	email = dw_lista.getitemstring(i, 'email')
	if not isnull(email) and email <> '' then direcciones += email + '; '
next
direcciones=left(direcciones, len(direcciones) - 2)
//parametros.direccion = direcciones
parametros.cco =  direcciones

OpenWithParm(w_csd_mail_send_sock,parametros)

end event

event csd_registro_cartas;//Registramos la obtenci$$HEX1$$f300$$ENDHEX$$n de la plantilla (no podemos saber si imprimen)
string ls_id_carta, ls_id_referencia, ls_tipo, ls_modulo_asociado, ls_plantilla, n_registro, nombre, ruta
date ld_fecha
int i

ld_fecha = today()
ls_modulo_asociado = 'CO'

for i= 1 to dw_lista.rowcount()
	ls_id_carta      = f_siguiente_numero('ID_CARTA',10)
	ls_id_referencia = dw_lista.GetItemString(i,'id_colegiado')
	n_registro		  = f_siguiente_numero('N_REGISTRO', 10)
					 
//	INSERT INTO cartas VALUES (:ls_id_carta, :ls_tipo, :ld_fecha, :ls_modulo_asociado, :ls_id_referencia, :g_usuario, :plantilla, :n_registro, :ls_nom_doc, :ls_ruta_dest);
next


IF SQLCA.SQLCode = -1 THEN
	rollback;
	MessageBox(g_titulo, "Error al registrar la impresi$$HEX1$$f300$$ENDHEX$$n del certificado")
ELSE
	commit;
END IF

end event

event activate;call super::activate;g_dw_lista  = dw_lista
g_w_lista   = g_lista_colegiados
g_w_detalle = g_detalle_colegiados
g_lista     = 'w_colegiados_lista'
g_detalle   = 'w_colegiados_detalle'
end event

event csd_consulta;call super::csd_consulta;//Abrimos la ventana de consulta
open(w_colegiados_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()

end event

on w_colegiados_lista.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_lista_colegiados" then this.MenuID = create m_lista_colegiados
this.dw_mailing=create dw_mailing
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_consell=create cb_consell
this.cb_directorio=create cb_directorio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mailing
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_consell
this.Control[iCurrent+5]=this.cb_directorio
end on

on w_colegiados_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_mailing)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_consell)
destroy(this.cb_directorio)
end on

event csd_detalle;call super::csd_detalle;if dw_lista.getrow() < 1 then return
//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
SetPointer(HourGlass!)
g_colegiados_consulta.id_colegiado = dw_lista.getitemstring(dw_lista.getrow(),'id_colegiado')
message.stringparm = "w_colegiados_detalle"
w_aplic_frame.postevent("csd_colegiadosdetalle")

end event

event csd_listados;call super::csd_listados;//Llamamos a la ventana de listados
open(w_colegiados_listados)
end event

event pfc_postopen;call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_colegiados = dw_lista
end event

event csd_nuevo;call super::csd_nuevo;opensheet(g_detalle_colegiados, g_detalle, w_aplic_frame, 0, original!)
end event

event close;call super::close;if isvalid(i_word) then
	i_word.application.Quit()
	//Destruimos el objeto ole y desconectamos.
	i_word.DisconnectObject()
	destroy i_word
end if

end event

event open;call super::open;	inv_resize.of_Register (dw_mailing, "ScaleToRight&Bottom")

if(g_colegio = 'COAATTGN' or g_colegio = 'COAATTEB' or g_colegio = 'COAATLL')then
	cb_consell.visible = true
	cb_directorio.visible = true	
	inv_resize.of_Register (cb_consell, "FixedtoBottom")
	inv_resize.of_Register (cb_directorio, "FixedtoBottom")
end if

end event

event key;//Si est$$HEX2$$e1002000$$ENDHEX$$visible el dw de mailing no lanzamos el detalle
if dw_mailing.visible then return

// Si se pulsa intro lanzamos la edici$$HEX1$$f300$$ENDHEX$$n de la fila seleccionada en la datawindow
if key=KeyEnter! and dw_lista.rowcount() > 0 then this.event csd_detalle()

end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_colegiados_lista
integer x = 37
integer y = 1416
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_colegiados_lista
integer x = 37
integer y = 1296
end type

type st_1 from w_lista`st_1 within w_colegiados_lista
integer x = 37
integer y = 1072
end type

type dw_lista from w_lista`dw_lista within w_colegiados_lista
integer x = 37
integer y = 32
integer width = 3515
string dataobject = "d_colegiados_lista"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event dw_lista::retrieveend;call super::retrieveend;SetPointer(Arrow!)
end event

event dw_lista::pfc_prermbmenu;//asasas
end event

type cb_consulta from w_lista`cb_consulta within w_colegiados_lista
string tag = "texto=general.consulta"
integer x = 3529
integer y = 1108
end type

type cb_detalle from w_lista`cb_detalle within w_colegiados_lista
string tag = "texto=general.detalle"
integer x = 3525
integer y = 732
end type

type cb_ayuda from w_lista`cb_ayuda within w_colegiados_lista
string tag = "texto=general.ayuda"
integer x = 3529
integer y = 1056
end type

type dw_mailing from u_dw within w_colegiados_lista
boolean visible = false
integer width = 3474
integer height = 1044
integer taborder = 11
boolean titlebar = true
string title = "Mailing a colegiados seleccionados"
string dataobject = "d_lista_mailing"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
boolean border = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;string fichero,origen,adjuntos

choose case dwo.name
	case 'b_enviar'
		dw_mailing.AcceptText()
		SetPointer(HourGlass!)
		f_mailing2(dw_lista,i_adjuntos_full + ';',this.GetItemString(1,'asunto'),this.GetItemString(1,'texto_mail'),dw_mailing.GetItemString(1,'ficheros_adjuntos'))
		this.visible = false
		this.DeleteRow(1)
		
	case 'b_adjuntar'
		if getfileOpenName('Seleccione el fichero a adjuntar...',origen,fichero) = 1 then 
		adjuntos = dw_mailing.GetItemString(1,'ficheros_adjuntos')
		if f_es_vacio(adjuntos) then
			adjuntos = fichero
			i_adjuntos_full = origen
		else
			adjuntos = adjuntos + ';' + fichero
			i_adjuntos_full = i_adjuntos_full + ';' + origen
		end if
		dw_mailing.SetItem(1,'ficheros_adjuntos',adjuntos)
	end if
end choose


end event

type dw_1 from datawindow within w_colegiados_lista
boolean visible = false
integer x = 3529
integer y = 912
integer width = 133
integer height = 104
integer taborder = 40
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_colegiados_lista
boolean visible = false
integer x = 3529
integer y = 840
integer width = 146
integer height = 96
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_colegiados_lista_fichero"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_consell from commandbutton within w_colegiados_lista
boolean visible = false
integer x = 626
integer y = 1056
integer width = 315
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Consell"
end type

event clicked;string dwsyntax_str, sql_syntax, ruta, fecha, ERRORS
n_cst_filesrvwin32 g_manejador_de_ficheros
g_manejador_de_ficheros = create n_cst_filesrvwin32 

//sql_syntax = "SELECT n_colegiado, nombre, apellidos from colegiados" 	
//sqlca.autocommit=TRUE
//dwsyntax_str = SQLCA.SyntaxFromSQL(sql_syntax,'', ERRORS)	
//dw_1.Create( dwsyntax_str, ERRORS)
dw_1.settransobject(sqlca)
dw_1.retrieve()	
//sqlca.autocommit=FALSE
	
boolean existe
ruta = 'C:\ficheros\' 
existe = g_manejador_de_ficheros.of_directoryexists(ruta)
if existe = false then g_manejador_de_ficheros.of_createdirectory(ruta)

fecha = 'consell_'+string(day(today()))+'_'+	string(month(today()))+'_'+Mid(string(year(today())),3,2)				
ruta = ruta +fecha
ruta = RightTrim(ruta)
ruta = ruta+".txt"
dw_1.saveas(ruta,Text!,FALSE)

integer ll_fichero, i
string fila, nombre, apellidos, direccion_activa, nif, cod_postal, poblacion, activa, cobertura, malus, pobla,g_num_consell
dw_2.settransobject(sqlca)
dw_2.retrieve()	
dw_2.setsort("n_colegiado A")
dw_2.sort()

//SCP-1353 recuperamos la variable global con el numero de colegio del consell
SELECT texto INTO :g_num_consell FROM var_globales WHERE nombre = 'g_num_consell';
ll_fichero = FileOpen(ruta, LineMode!, Write!, LockWrite!, Append!)
for i = 1 to dw_2.rowcount( )
	nombre = dw_2.getitemstring(i,'nombre')
	apellidos = dw_2.getitemstring(i,'apellidos')
	direccion_activa = dw_2.getitemstring(i,'domicilio_activo')
	if isnull(direccion_activa) then direccion_activa = ''
	activa = dw_2.getitemstring(i,'poblacion_activa')
	//pobla = dw_2.getitemstring(i,'poblaciones_descripcion')
	if isnull(activa) then activa = ''
	if isnull(pobla) then pobla = ''	
	cod_postal = Mid(activa,1,5)
	poblacion = Mid(activa,7,100)
	nif = dw_2.getitemstring(i,'nif')
	if isnull(nif) then nif = ''	
	cobertura = left(right('0000000' + string(f_musaat_dame_cobertura_src (dw_2.getitemstring(i,'id_colegiado'))), 7),4)
	malus = string(f_musaat_dame_coef_cm(dw_2.getitemstring(i,'id_colegiado')))
	fila = g_num_consell+';'+apellidos+','+nombre+';'+direccion_activa+';'+cod_postal+';'+poblacion+';'+nif+';A;'+cobertura+';'+malus
	FileWrite(ll_fichero, fila)
next
FileClose(ll_fichero)
end event

type cb_directorio from commandbutton within w_colegiados_lista
boolean visible = false
integer x = 978
integer y = 1056
integer width = 315
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Directorio"
end type

event clicked;string dwsyntax_str, sql_syntax, ruta, fecha, ERRORS
n_cst_filesrvwin32 g_manejador_de_ficheros
g_manejador_de_ficheros = create n_cst_filesrvwin32 

//sql_syntax = "SELECT n_colegiado, nombre, apellidos from colegiados" 	
//sqlca.autocommit=TRUE
//dwsyntax_str = SQLCA.SyntaxFromSQL(sql_syntax,'', ERRORS)	
//dw_1.Create( dwsyntax_str, ERRORS)
//dw_1.settransobject(sqlca)
//dw_1.retrieve()	
//sqlca.autocommit=FALSE
	
boolean existe
ruta = 'C:\ficheros\' 
existe = g_manejador_de_ficheros.of_directoryexists(ruta)
if existe = false then g_manejador_de_ficheros.of_createdirectory(ruta)

fecha = 'directori_colegiats_'+string(day(today()))+'_'+	string(month(today()))+'_'+Mid(string(year(today())),3,2)				
ruta = ruta +fecha
ruta = RightTrim(ruta)
ruta = ruta+".txt"
dw_1.saveas(ruta,Text!,FALSE)

integer ll_fichero, i
string fila, numero, nombre, apellidos, email, direccion_activa, telefono, cod_postal, poblacion, activa, pobla
dw_2.settransobject(sqlca)
dw_2.retrieve()
dw_2.setsort("apellidos A, nombre A")
dw_2.sort()
ll_fichero = FileOpen(ruta, LineMode!, Write!, LockWrite!, Append!)
for i = 1 to dw_2.rowcount( )
	numero = dw_2.getitemstring(i,'n_colegiado')
	nombre = dw_2.getitemstring(i,'nombre')
	apellidos = dw_2.getitemstring(i,'apellidos')
	email = dw_2.getitemstring(i,'email')
	if isnull(email) then email = ''
	direccion_activa = dw_2.getitemstring(i,'domicilio_activo')
	if isnull(direccion_activa) then direccion_activa = ''
	activa = dw_2.getitemstring(i,'poblacion_activa')
	//pobla = dw_2.getitemstring(i,'poblaciones_descripcion')
	if isnull(activa) then activa = ''
	if isnull(pobla) then pobla = ''
	cod_postal = Mid(activa,1,5)
	poblacion = Mid(activa,7,100)
	telefono = dw_2.getitemstring(i,'telefono_1')
	if (isNull(telefono)) then telefono = ''
//	cobertura = left(right('0000000' + string(f_musaat_dame_cobertura_src (dw_2.getitemstring(i,'id_colegiado'))), 7),4)
//	malus = string(f_musaat_dame_coef_cm(dw_2.getitemstring(i,'id_colegiado')))
	fila = numero+ leftA(f_completar_con_caracteres(apellidos+','+nombre,30,'D',' '),30)+leftA(f_completar_con_caracteres(email,35,'D',' '),35)
	fila += leftA(f_completar_con_caracteres(direccion_activa,30,'D',' '),30)+leftA( f_completar_con_caracteres(cod_postal+poblacion,35,'D',' '),35)
	fila += leftA(f_completar_con_caracteres(telefono,12,'D',' '),12)
	FileWrite(ll_fichero, fila)
next
FileClose(ll_fichero)
end event

