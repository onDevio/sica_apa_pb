HA$PBExportHeader$w_csd_mail_send_sock.srw
$PBExportComments$Ventana de envio de mails
forward
global type w_csd_mail_send_sock from w_response
end type
type st_status_bar from statictext within w_csd_mail_send_sock
end type
type mle_asunto from multilineedit within w_csd_mail_send_sock
end type
type cb_send_mail from commandbutton within w_csd_mail_send_sock
end type
type cb_close from commandbutton within w_csd_mail_send_sock
end type
type gb_5 from groupbox within w_csd_mail_send_sock
end type
type gb_subject from groupbox within w_csd_mail_send_sock
end type
type cb_grabar from commandbutton within w_csd_mail_send_sock
end type
type cb_comprimir from commandbutton within w_csd_mail_send_sock
end type
type cb_help from commandbutton within w_csd_mail_send_sock
end type
type tab_1 from tab within w_csd_mail_send_sock
end type
type tabpage_1 from userobject within tab_1
end type
type mle_mensaje from multilineedit within tabpage_1
end type
type tabpage_1 from userobject within tab_1
mle_mensaje mle_mensaje
end type
type tabpage_2 from userobject within tab_1
end type
type dw_adjuntos from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_adjuntos dw_adjuntos
end type
type tabpage_3 from userobject within tab_1
end type
type cb_cargar_opciones from u_cb within tabpage_3
end type
type cb_grabar_opciones from u_cb within tabpage_3
end type
type dw_opciones from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cb_cargar_opciones cb_cargar_opciones
cb_grabar_opciones cb_grabar_opciones
dw_opciones dw_opciones
end type
type tab_1 from tab within w_csd_mail_send_sock
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type tab_2 from tab within w_csd_mail_send_sock
end type
type tabpage_4 from userobject within tab_2
end type
type sle_destino from multilineedit within tabpage_4
end type
type pb_1 from u_pb within tabpage_4
end type
type cb_1 from u_cb within tabpage_4
end type
type tabpage_4 from userobject within tab_2
sle_destino sle_destino
pb_1 pb_1
cb_1 cb_1
end type
type tabpage_5 from userobject within tab_2
end type
type sle_cc from multilineedit within tabpage_5
end type
type pb_2 from u_pb within tabpage_5
end type
type cb_2 from u_cb within tabpage_5
end type
type tabpage_5 from userobject within tab_2
sle_cc sle_cc
pb_2 pb_2
cb_2 cb_2
end type
type tabpage_6 from userobject within tab_2
end type
type sle_cco from multilineedit within tabpage_6
end type
type pb_3 from u_pb within tabpage_6
end type
type cb_3 from u_cb within tabpage_6
end type
type tabpage_6 from userobject within tab_2
sle_cco sle_cco
pb_3 pb_3
cb_3 cb_3
end type
type tab_2 from tab within w_csd_mail_send_sock
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type
end forward

global type w_csd_mail_send_sock from w_response
integer x = 9
integer y = 221
integer width = 2565
integer height = 2196
string title = "Enviar correo electr$$HEX1$$f300$$ENDHEX$$nico"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
event csd_enviar ( )
event csd_adjuntar ( )
event csd_cargar_preferencias ( )
event csd_cargar_opciones ( )
event csd_comprimir_zip ( )
event type boolean csd_enviar_gae ( )
event csd_enviar_sockets_dividido ( )
st_status_bar st_status_bar
mle_asunto mle_asunto
cb_send_mail cb_send_mail
cb_close cb_close
gb_5 gb_5
gb_subject gb_subject
cb_grabar cb_grabar
cb_comprimir cb_comprimir
cb_help cb_help
tab_1 tab_1
tab_2 tab_2
end type
global w_csd_mail_send_sock w_csd_mail_send_sock

type variables
u_dw idw_fase
u_dw idw_adjuntos, idw_opciones
MultiLineEdit imle_mensaje
n_file_dialogs inv_file_dialog

// Objeto de envio de mails
n_smtp in_smtp
string is_mensaje,is_asunto,is_email,is_tipo
// Configuracion cuenta correo
string is_servidor_smtp,is_servidor_pop
string is_direccion,is_nombre,is_login,is_password,is_recordar
// Opciones de configuracion
boolean ib_confirmacion_lectura,ib_compresion,ib_html,ib_plantilla


// Esta opcion indica la fase, en caso de que el mail se tenga que rellenar con los 
// datos de ella (como pasa en el sellador). En otros casos, sera nulo.
string is_id_fase

datastore ids_destinatarios,ids_cc,ids_cco
MultiLineEdit isle_destino,isle_cc,isle_cco


end variables

forward prototypes
public subroutine wf_cargar_adjuntos ()
public function string wf_cargar_direcciones (datastore ds_direcciones)
end prototypes

event csd_enviar();
string ls_filename,texto,maximo_envios
long i,posicion_coma
st_login datos_login
n_cst_encrypt encriptacion
encriptacion=create n_cst_encrypt
n_cst_string lnv_string
string dividir_email

is_mensaje=imle_mensaje.text
is_asunto=mle_asunto.text


dividir_email=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","partir_envio_masivo", "N")
if dividir_email='S' then
	event csd_enviar_sockets_dividido()
	return
end if

// Aplicamos la plantilla
if ib_plantilla then 
	f_email_aplicar_plantilla(is_mensaje,is_asunto,is_id_fase,idw_opciones.GetItemString(1,'plantilla'))
end if

// Opciones de envio.
in_smtp.of_SetReceipt(ib_confirmacion_lectura)
in_smtp.of_SetServer(is_servidor_smtp)
in_smtp.of_SetFrom(is_direccion,is_nombre)
in_smtp.of_SetSubject(is_asunto)
in_smtp.of_SetBody(is_mensaje, ib_html)

if f_es_vacio(is_login) or f_es_vacio(is_password) then
	Open(w_email_login)
	datos_login=Message.PowerObjectParm
	if f_es_vacio(datos_login.login) or f_es_vacio(datos_login.password) then
		MessageBox("Usuario Incorrecto","No ha introducido password para el usuario "+is_login,StopSign!)
		return
	else
		Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","login", datos_login.login)
		Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","recordar", datos_login.recordar)
		maximo_envios = ProfileString(g_dir_aplicacion+"sica.ini","CORREO","maximo_envios", "")
		if datos_login.recordar='S' then
			Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","password",  encriptacion.of_encrypt(datos_login.password))
		end if
		is_login=datos_login.login
		is_password=datos_login.password				
	end if
end if	

in_smtp.of_SetLogin(is_login,is_password)	
in_smtp.of_Reset()

string direccion_email
long ll_posicion_puntoycoma,ll_diferencia_pos

// Obtenemos la lista de destinatarios
texto=isle_destino.text
if Not(IsNull(texto)) and (trim(texto)<>"") then
	f_email_tratamiento_direcciones(in_smtp, texto, 'destino')
//	posicion_coma=1
//	do while posicion_coma<>0 
//		posicion_coma=PosA(texto,',')
//		if posicion_coma<>0 then
//			in_smtp.of_Addto(trim(MidA(texto,1,posicion_coma - 1)))
//		else
//			in_smtp.of_Addto(trim(MidA(texto,1)))
//		end if
//		texto=MidA(texto,posicion_coma+1)
//	loop
end if

// Obtenemos la lista de destinatarios con copia
texto=isle_cc.text

if Not(IsNull(texto)) and (trim(texto)<>"") then
	f_email_tratamiento_direcciones(in_smtp, texto, 'cc')
//	posicion_coma=1
//	do while posicion_coma<>0 
//		posicion_coma=PosA(texto,',')
//		if posicion_coma<>0 then
//			in_smtp.of_Addcc(trim(MidA(texto,1,posicion_coma - 1)))
//		else
//			in_smtp.of_Addcc(trim(MidA(texto,1)))
//		end if
//		texto=MidA(texto,posicion_coma+1)
//	loop
end if



// Obtenemos la lista de destinatarios con copia oculta
texto=isle_cco.text
if Not(IsNull(texto)) and (trim(texto)<>"") then
//	posicion_coma=1
//	do while posicion_coma<>0 
//		posicion_coma=PosA(texto,',')
//		if posicion_coma<>0 then
//			in_smtp.of_Addbcc(trim(MidA(texto,1,posicion_coma - 1)))
//		else
//			in_smtp.of_Addbcc(trim(MidA(texto,1)))
//		end if
//		texto=MidA(texto,posicion_coma+1)
//	loop
f_email_tratamiento_direcciones(in_smtp, texto, 'occ')
end if



/*// Obtenemos la lista de destinatarios
texto=isle_destino.text
posicion_coma=1
do while posicion_coma<>0 
	posicion_coma=PosA(texto,',')
	if posicion_coma<>0 then
		in_smtp.of_AddTo(trim(MidA(texto,1,posicion_coma - 1)))
	else
		in_smtp.of_AddTo(trim(MidA(texto,1)))
	end if
	texto=MidA(texto,posicion_coma+1)
loop

// Obtenemos la lista de destinatarios con copia
texto=isle_cc.text
if Not(IsNull(texto)) and (trim(texto)<>"") then
	posicion_coma=1
	do while posicion_coma<>0 
		posicion_coma=PosA(texto,',')
		if posicion_coma<>0 then
			in_smtp.of_Addcc(trim(MidA(texto,1,posicion_coma - 1)))
		else
			in_smtp.of_Addcc(trim(MidA(texto,1)))
		end if
		texto=MidA(texto,posicion_coma+1)
	loop
end if

// Obtenemos la lista de destinatarios con copia oculta
texto=isle_cco.text
if Not(IsNull(texto)) and (trim(texto)<>"") then
	posicion_coma=1
	do while posicion_coma<>0 
		posicion_coma=PosA(texto,',')
		if posicion_coma<>0 then
			in_smtp.of_Addbcc(trim(MidA(texto,1,posicion_coma - 1)))
		else
			in_smtp.of_Addbcc(trim(MidA(texto,1)))
		end if
		texto=MidA(texto,posicion_coma+1)
	loop
end if
*/

// A$$HEX1$$f100$$ENDHEX$$adimos los adjuntos. Si tenemos que comprimir, comprimimos y enviamos el adjunto.
if ib_compresion then
	this.event csd_comprimir_zip()
else
	For i = 1 To idw_adjuntos.rowcount()
		ls_filename = idw_adjuntos.GetItemString(i,'nombre_fichero')
		in_smtp.of_AddFile(ls_filename)
	Next
end if
boolean res
// Enviar el mensaje
if is_tipo='G' then
	res=event csd_enviar_gae()
else
	res=in_smtp.of_SendMail()
end if

if res then
	st_status_bar.text="El mensaje fue enviado correctamente"
	st_status_bar.textcolor=rgb(0,196,0)
	MessageBox(g_titulo, "El mensaje fue enviado correctamente")
	cb_close.triggerevent(clicked!)
else
	st_status_bar.text="No se pudo enviar el mensaje"
	st_status_bar.textcolor=rgb(255,0,0)
	//MessageBox(g_titulo, "No se pudo enviar el mensaje",Exclamation!)
end if


end event

event csd_cargar_preferencias();// Obtencion de los datos del .ini
string dir_copia
n_cst_encrypt encriptacion

encriptacion=create n_cst_encrypt

is_tipo=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","tipo_envio", "S")
is_servidor_smtp=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","servidor_smtp", "")
is_servidor_pop=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","servidor_pop", "")
is_direccion=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","direccion", "")
is_nombre=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","nombre", "")
is_recordar=Upper(ProfileString(g_dir_aplicacion+"sica.ini","CORREO","recordar", "N"))
dir_copia=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","direccion_copia", "")

if not(f_es_vacio(dir_copia)) then
	tab_2.tabpage_6.sle_cco.text+=','+dir_copia
end if

if is_recordar='S' then
	is_login=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","login", "")
	is_password=encriptacion.of_decrypt(ProfileString(g_dir_aplicacion+"sica.ini","CORREO","password", ""))
	
else
	is_login=""
	is_password=""
end if





end event

event csd_cargar_opciones();
if idw_opciones.GetItemString(1,'confirmacion_lectura')='S' then
	ib_confirmacion_lectura=true
else
	ib_confirmacion_lectura=false
end if

if idw_opciones.GetItemString(1,'comprimir_archivos')='S' then
	ib_compresion=true
else
	ib_compresion=false
end if

if idw_opciones.GetItemString(1,'enviar_html')='S' then
	ib_html=true
else
	ib_html=false
end if

if idw_opciones.GetItemString(1,'adjuntar_plantilla')='S' then
	ib_plantilla=true
else
	ib_plantilla=false
end if
end event

event csd_comprimir_zip();string nombre_zip,fichero_zip
string ruta_zip,doc
int fila,i
oleobject zip,files,oFile

//Creamos el zip
zip = create oleobject
zip.ConnectToNewObject("SAWZip.Archive")

//Generamos el nombre y ruta del fichero zip
nombre_zip = idw_opciones.GetItemString(1,'nombre_zip')
if IsNull(nombre_zip) or trim(nombre_zip)="" then nombre_zip = "fichero_comprimido"
if RightA(nombre_zip,4)='.zip' then nombre_zip=MidA(nombre_zip,1,LenA(nombre_zip)-4)

	
ruta_zip = g_directorio_temporal + nombre_zip + '.zip'
fichero_zip =  nombre_zip + '.zip'

//Comprobamos si esta para a$$HEX1$$f100$$ENDHEX$$adirlo o crear el zip
if fileexists(ruta_zip) then
	FileDelete(ruta_zip)
end if

zip.create(ruta_zip)

Files = create oleobject
Files.ConnectToNewObject("SAWZip.Files")
Files = zip.Files

//Adjuntamos la lista
for i=1 to idw_adjuntos.rowcount()
	doc=idw_adjuntos.GetItemString(i,'nombre_fichero')
	oFile = create oleobject
	oFile.ConnectToNewObject("SAWZip.File")	
	oFile.Name = doc
	Files.Add(oFile)	
next


//Cerramos el zip y destruimos los objetos
zip.close()

// A$$HEX1$$f100$$ENDHEX$$adimos el zip como adjunto
in_smtp.of_AddFile(ruta_zip)

destroy zip
destroy files
destroy oFile

end event

event type boolean csd_enviar_gae();string texto,direc
long posicion_coma, ll_pos_punto_coma
datastore ds_enviados
string ls_dw_err, ls_sql_syntax,ls_dw_syntax
string ls_cuerpo,ls_asunto,n_registro
long ll_fila_aux,res
ds_enviados = create datastore
ls_sql_syntax= "  SELECT csd_sms_enviados.movil_contacto,  csd_sms_enviados.nif, csd_sms_enviados.nombre, " + &   
" csd_sms_enviados.apellidos,  csd_sms_enviados.f_envio, csd_sms_enviados.envio, csd_sms_enviados.mensaje, " + &   
" csd_sms_enviados.id_sms, csd_sms_enviados.id_campanya, csd_sms_enviados.id_sms_predefinido, csd_sms_enviados.envio_mensaje, " + &   
" csd_sms_enviados.tipo_aviso, csd_sms_enviados.email, csd_sms_enviados.fecha_envio_final, csd_sms_enviados.hora_envio,  " + & 
" csd_sms_enviados.texto, csd_sms_enviados.id_sms_enviados  FROM csd_sms_enviados    "


	
/*if f_es_vacio(isle_destino.text) then
	return false
end if*/


ls_dw_syntax = SQLCA.SyntaxFromSQL(ls_sql_syntax , "style(type=grid) ", ls_dw_err)
ds_enviados.create(ls_dw_syntax,ls_dw_err)
ds_enviados.settransobject(SQLCA)

// Obtenemos la lista de destinatarios
texto=isle_destino.text
posicion_coma=1
ll_pos_punto_coma = 1

do while posicion_coma<>0 and ll_pos_punto_coma <>0 
	posicion_coma=PosA(texto,',')
	//ICC-349. Introducido por Alexis. 29/04/2010. Tratamiento del punto y coma.
	ll_pos_punto_coma=PosA(texto,';')
	
	if (posicion_coma < ll_pos_punto_coma and posicion_coma <> 0)  then
				if not f_es_vacio(trim(MidA(texto,1,posicion_coma - 1))) then
					direc=trim(MidA(texto,1,posicion_coma - 1))
				end if
				texto=MidA(texto,posicion_coma+1)
	else
		if ll_pos_punto_coma <> 0 then
			if not f_es_vacio(trim(MidA(texto,1,ll_pos_punto_coma - 1))) then	
				direc=trim(MidA(texto,1,ll_pos_punto_coma - 1))
			end if
			texto=MidA(texto,ll_pos_punto_coma+1)
		else 
			if posicion_coma <> 0 then
				if not f_es_vacio(trim(MidA(texto,1,posicion_coma - 1))) then
					direc=trim(MidA(texto,1,posicion_coma - 1))
				end if
				texto=MidA(texto,posicion_coma+1)
			else 
				direc=trim(MidA(texto,1))
			end if
		end if
	end if	
	
//	if posicion_coma<>0 then
//		direc=trim(MidA(texto,1,posicion_coma - 1))
//	else
//		direc=trim(MidA(texto,1))
//	end if
//	
	
	ll_fila_aux=ds_enviados.insertRow(0)	
	
	ds_enviados.setitem(ll_fila_aux,'id_sms_enviados',f_siguiente_numero("SMS_ENVIADOS",10))
	ds_enviados.setitem(ll_fila_aux,'nombre','')
	ds_enviados.setitem(ll_fila_aux,'apellidos','')
	ds_enviados.setitem(ll_fila_aux,'movil_contacto','')
	ds_enviados.setitem(ll_fila_aux,'email',direc)
	
	ds_enviados.setitem(ll_fila_aux,'id_sms',"")
	ds_enviados.setitem(ll_fila_aux,'f_envio',datetime(string(today(),"dd-mm-yyyy")))
	ds_enviados.setitem(ll_fila_aux,'hora_envio',time(string(now(),"hh:mm")))	
	ds_enviados.setitem(ll_fila_aux,'envio_mensaje','N')	
	ds_enviados.setitem(ll_fila_aux,'tipo_aviso','E')			
	ds_enviados.setitem(ll_fila_aux,'mensaje',is_asunto)
	ds_enviados.setitem(ll_fila_aux,'texto',is_mensaje)			
	
	//texto=MidA(texto,posicion_coma+1)
	
loop

// Obtenemos la lista de destinatarios del CC
texto=isle_cc.text
posicion_coma=1
do while posicion_coma<>0 
	posicion_coma=PosA(texto,',')
//	if posicion_coma<>0 then
//		direc=trim(MidA(texto,1,posicion_coma - 1))
//	else
//		direc=trim(MidA(texto,1))
//	end if
//ICC-349. Introducido por Alexis. 29/04/2010. Tratamiento del punto y coma.
ll_pos_punto_coma=PosA(texto,';')
	
	if (posicion_coma < ll_pos_punto_coma and posicion_coma <> 0)  then
				if not f_es_vacio(trim(MidA(texto,1,posicion_coma - 1))) then
					direc=trim(MidA(texto,1,posicion_coma - 1))
				end if
				texto=MidA(texto,posicion_coma+1)
	else
		if ll_pos_punto_coma <> 0 then
			if not f_es_vacio(trim(MidA(texto,1,ll_pos_punto_coma - 1))) then	
				direc=trim(MidA(texto,1,ll_pos_punto_coma - 1))
			end if
			texto=MidA(texto,ll_pos_punto_coma+1)
		else 
			if posicion_coma <> 0 then
				if not f_es_vacio(trim(MidA(texto,1,posicion_coma - 1))) then
					direc=trim(MidA(texto,1,posicion_coma - 1))
				end if
				texto=MidA(texto,posicion_coma+1)
			else 
				direc=trim(MidA(texto,1))
			end if
		end if
	end if	
	
	ll_fila_aux=ds_enviados.insertRow(0)	
	
	ds_enviados.setitem(ll_fila_aux,'id_sms_enviados',f_siguiente_numero("SMS_ENVIADOS",10))
	ds_enviados.setitem(ll_fila_aux,'nombre','')
	ds_enviados.setitem(ll_fila_aux,'apellidos','')
	ds_enviados.setitem(ll_fila_aux,'movil_contacto','')
	ds_enviados.setitem(ll_fila_aux,'email',direc)
	
	ds_enviados.setitem(ll_fila_aux,'id_sms',"")
	ds_enviados.setitem(ll_fila_aux,'f_envio',datetime(string(today(),"dd-mm-yyyy")))
	ds_enviados.setitem(ll_fila_aux,'hora_envio',time(string(now(),"hh:mm")))	
	ds_enviados.setitem(ll_fila_aux,'envio_mensaje','N')	
	ds_enviados.setitem(ll_fila_aux,'tipo_aviso','E')			
	ds_enviados.setitem(ll_fila_aux,'mensaje',is_asunto)
	ds_enviados.setitem(ll_fila_aux,'texto',is_mensaje)			
	
	
//	texto=MidA(texto,posicion_coma+1)
loop

// Obtenemos la lista de destinatarios del CCO
texto=isle_cco.text
posicion_coma=1
do while posicion_coma<>0 
	posicion_coma=PosA(texto,',')
	//ICC-349. Introducido por Alexis. 29/04/2010. Tratamiento del punto y coma.
//	if posicion_coma<>0 then
//		direc=trim(MidA(texto,1,posicion_coma - 1))
//	else
//		direc=trim(MidA(texto,1))
//	end if
	ll_pos_punto_coma=PosA(texto,';')
	
	if (posicion_coma < ll_pos_punto_coma and posicion_coma <> 0)  then
				if not f_es_vacio(trim(MidA(texto,1,posicion_coma - 1))) then
					direc=trim(MidA(texto,1,posicion_coma - 1))
				end if
				texto=MidA(texto,posicion_coma+1)
	else
		if ll_pos_punto_coma <> 0 then
			if not f_es_vacio(trim(MidA(texto,1,ll_pos_punto_coma - 1))) then	
				direc=trim(MidA(texto,1,ll_pos_punto_coma - 1))
			end if
			texto=MidA(texto,ll_pos_punto_coma+1)
		else 
			if posicion_coma <> 0 then
				if not f_es_vacio(trim(MidA(texto,1,posicion_coma - 1))) then
					direc=trim(MidA(texto,1,posicion_coma - 1))
				end if
				texto=MidA(texto,posicion_coma+1)
			else 
				direc=trim(MidA(texto,1))
			end if
		end if
	end if	
	
	ll_fila_aux=ds_enviados.insertRow(0)	
	
	ds_enviados.setitem(ll_fila_aux,'id_sms_enviados',f_siguiente_numero("SMS_ENVIADOS",10))
	ds_enviados.setitem(ll_fila_aux,'nombre','')
	ds_enviados.setitem(ll_fila_aux,'apellidos','')
	ds_enviados.setitem(ll_fila_aux,'movil_contacto','')
	ds_enviados.setitem(ll_fila_aux,'email',direc)
	
	ds_enviados.setitem(ll_fila_aux,'id_sms',"")
	ds_enviados.setitem(ll_fila_aux,'f_envio',datetime(string(today(),"dd-mm-yyyy")))
	ds_enviados.setitem(ll_fila_aux,'hora_envio',time(string(now(),"hh:mm")))	
	ds_enviados.setitem(ll_fila_aux,'envio_mensaje','N')	
	ds_enviados.setitem(ll_fila_aux,'tipo_aviso','E')			
	ds_enviados.setitem(ll_fila_aux,'mensaje',is_asunto)
	ds_enviados.setitem(ll_fila_aux,'texto',is_mensaje)			
	
	
	//texto=MidA(texto,posicion_coma+1)
loop

res=ds_enviados.update()


return true
end event

event csd_enviar_sockets_dividido();
string ls_filename,texto,copia,lista_emails,direc
long i,posicion_coma, ll_posicion_puntoycoma, ll_diferencia_pos
st_login datos_login
n_cst_encrypt encriptacion
encriptacion=create n_cst_encrypt
n_cst_string lnv_string
string ls_limite

// Obtenemos los datos del ini
is_servidor_smtp=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","servidor_smtp", "")
is_servidor_pop=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","servidor_pop", "")
is_direccion=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","direccion", "")
is_nombre=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","nombre", "")
is_recordar=Upper(ProfileString(g_dir_aplicacion+"sica.ini","CORREO","recordar", "N"))
ls_limite=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","limite", "")
copia=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","direccion_copia", "")
if(f_es_vacio(ls_limite))then ls_limite = '10'


if is_recordar='S' then
	is_login=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","login", "")
	is_password=encriptacion.of_decrypt(ProfileString(g_dir_aplicacion+"sica.ini","CORREO","password", ""))
else
	is_login=""
	is_password=""
end if


//Aplicamos la plantilla
//if Not(f_es_vacio(plantilla)) then f_aplicar_plantilla()
if ib_plantilla then f_email_aplicar_plantilla(is_mensaje,is_asunto,is_id_fase,idw_opciones.GetItemString(1,'plantilla'))



// Establecemos los datos del servidor y del email
in_smtp.of_SetReceipt(false)
in_smtp.of_SetServer(is_servidor_smtp)
in_smtp.of_SetFrom(is_direccion,is_nombre)
in_smtp.of_SetSubject(mle_asunto.text)
in_smtp.of_SetBody(is_mensaje, ib_html)

// Establecemos el login y el password o mostramos la ventana de usuario sino se introdujo
if f_es_vacio(is_login) or f_es_vacio(is_password) then
	Open(w_email_login)
	datos_login=Message.PowerObjectParm
	if f_es_vacio(datos_login.login) or f_es_vacio(datos_login.password) then
		MessageBox("Usuario Incorrecto","No ha introducido password para el usuario "+is_login,StopSign!)
		return
	else
		Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","login", datos_login.login)
		Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","recordar", datos_login.recordar)
		if datos_login.recordar='S' then
			Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","password",  encriptacion.of_encrypt(datos_login.password))
		end if
		is_login=datos_login.login
		is_password=datos_login.password				
	end if
end if	

in_smtp.of_SetLogin(is_login,is_password)	
in_smtp.of_Reset()

if not(in_smtp.of_csd_conexion()) then
	MessageBox("Error","No se pudo establecer la conexi$$HEX1$$f300$$ENDHEX$$n con el servidor") 
	return
end if

if ib_compresion then
	this.event csd_comprimir_zip()
else
	For i = 1 To idw_adjuntos.rowcount()
		ls_filename = idw_adjuntos.GetItemString(i,'nombre_fichero')
		in_smtp.of_AddFile(ls_filename)
	Next
end if

// Obtenemos la lista de destinatarios
texto=isle_destino.text
if Not(IsNull(texto)) and (trim(texto)<>"") then
	posicion_coma=1
	ll_posicion_puntoycoma = 1
	do while (posicion_coma<>0 or ll_posicion_puntoycoma <> 0)
		posicion_coma=PosA(texto,',')
		ll_posicion_puntoycoma= PosA(texto,';')
		ll_diferencia_pos = posicion_coma - ll_posicion_puntoycoma
	
		if ll_diferencia_pos = 0 then
			//in_smtp.of_csd_AddTo_unico(trim(MidA(texto,1)))
			continue
		else 
			if ((ll_diferencia_pos > 0 and ll_posicion_puntoycoma <> 0) or ( ll_diferencia_pos < 0 and posicion_coma = 0)) then 	
				direc=trim(MidA(texto,1,ll_posicion_puntoycoma - 1))
				texto=MidA(texto,ll_posicion_puntoycoma+1)
			else
				direc=trim(MidA(texto,1,posicion_coma - 1))
				texto=MidA(texto,posicion_coma+1)
			end if
			//in_smtp.of_csd_AddTo_unico(direc)
			if in_smtp.of_csd_AddTo_limitado(direc,ls_limite)=-1 then
				if not(in_smtp.of_csd_enviar_datos()) then
					lista_emails+=direc+cr
				else
					in_smtp.of_csd_AddTo_reset()
					in_smtp.of_csd_AddTo_limitado(direc,ls_limite)
				end if
			end if
		end if	
	loop
	texto = trim(texto)
	if in_smtp.of_csd_AddTo_limitado(texto,ls_limite)=-1 then
		if not(in_smtp.of_csd_enviar_datos()) then
			lista_emails+=texto+cr
		else
			in_smtp.of_csd_AddTo_reset()
			in_smtp.of_csd_AddTo_limitado(texto,ls_limite)
			if not(in_smtp.of_csd_enviar_datos()) then
				lista_emails+=texto+cr
			end if
		end if
	else
		if not(in_smtp.of_csd_enviar_datos()) then
			lista_emails+=texto+cr
		end if
	end if
end if
in_smtp.of_csd_AddTo_reset()

//posicion_coma=1
//do while posicion_coma<>0 
//	posicion_coma=PosA(texto,',')
//	if posicion_coma<>0 then
//		direc=trim(MidA(texto,1,posicion_coma - 1))
//		in_smtp.of_csd_AddTo_unico(direc)
//	else
//		direc=trim(MidA(texto,1))
//		in_smtp.of_csd_AddTo_unico(direc)
//	end if
//	if not(in_smtp.of_csd_enviar_datos()) then
//		lista_emails+=direc+cr
//	end if
//	texto=MidA(texto,posicion_coma+1)
//loop


// Obtenemos la lista de destinatarios con copia
texto=isle_cc.text
if Not(IsNull(texto)) and (trim(texto)<>"") then
	posicion_coma=1
	ll_posicion_puntoycoma = 1
	do while (posicion_coma<>0 or ll_posicion_puntoycoma <> 0)
		posicion_coma=PosA(texto,',')
		ll_posicion_puntoycoma= PosA(texto,';')
		ll_diferencia_pos = posicion_coma - ll_posicion_puntoycoma
	
		if ll_diferencia_pos = 0 then
			//in_smtp.of_csd_Addcc_unico(trim(MidA(texto,1)))
			continue
		else 
			if ((ll_diferencia_pos > 0 and ll_posicion_puntoycoma <> 0) or ( ll_diferencia_pos < 0 and posicion_coma = 0)) then 	
				direc=trim(MidA(texto,1,ll_posicion_puntoycoma - 1))
				texto=MidA(texto,ll_posicion_puntoycoma+1)
			else
				direc=trim(MidA(texto,1,posicion_coma - 1))
				texto=MidA(texto,posicion_coma+1)
			end if
			if in_smtp.of_csd_AddTocc_limitado(direc,ls_limite)=-1 then
				if not(in_smtp.of_csd_enviar_datos()) then
					lista_emails+=direc+cr
				else
					in_smtp.of_csd_AddTocc_reset()
					in_smtp.of_csd_AddTocc_limitado(direc,ls_limite)
				end if
			end if
		end if	
	loop
	texto = trim(texto)
	if in_smtp.of_csd_AddTocc_limitado(texto,ls_limite)=-1 then
		if not(in_smtp.of_csd_enviar_datos()) then
			lista_emails+=texto+cr
		else
			in_smtp.of_csd_AddTocc_reset()
			in_smtp.of_csd_AddTocc_limitado(texto,ls_limite)
			if not(in_smtp.of_csd_enviar_datos()) then
				lista_emails+=texto+cr
			end if
		end if
	else
		if not(in_smtp.of_csd_enviar_datos()) then
			lista_emails+=texto+cr
		end if
	end if
end if
in_smtp.of_csd_AddTocc_reset()

//			in_smtp.of_csd_Addcc_unico(direc)
//		end if	
//		
//	loop
//end if

//texto=cc_email
//if Not(IsNull(texto)) and (trim(texto)<>"") then
//	posicion_coma=1
//	do while posicion_coma<>0 
//		posicion_coma=PosA(texto,',')
//		if posicion_coma<>0 then
//			direc=trim(MidA(texto,1,posicion_coma - 1))
//			in_smtp.of_csd_Addcc_unico(direc)
//		else
//			direc=trim(MidA(texto,1))
//			in_smtp.of_csd_Addcc_unico(direc)
//		end if
//		if not(in_smtp.of_csd_enviar_datos()) then
//			lista_emails+=direc+cr
//		end if		
//		texto=MidA(texto,posicion_coma+1)
//	loop
//end if

/*if not(sin_adjuntos) then
	ls_filename = ruta_base + ruta_relativa + nombre+'.pdf'
	in_smtp.of_AddFile(ls_filename)
end if*/

// Obtenemos la lista de destinatarios con copia oculta
texto=isle_cco.text
if Not(IsNull(texto)) and (trim(texto)<>"") then
	posicion_coma=1
	ll_posicion_puntoycoma = 1
	do while (posicion_coma<>0 or ll_posicion_puntoycoma <> 0)
		posicion_coma=PosA(texto,',')
		ll_posicion_puntoycoma= PosA(texto,';')
		ll_diferencia_pos = posicion_coma - ll_posicion_puntoycoma
	
		if ll_diferencia_pos = 0 then
			//in_smtp.of_csd_Addbcc_unico(trim(MidA(texto,1)))
			continue
		else 
			if ((ll_diferencia_pos > 0 and ll_posicion_puntoycoma <> 0) or ( ll_diferencia_pos < 0 and posicion_coma = 0)) then 	
				direc=trim(MidA(texto,1,ll_posicion_puntoycoma - 1))
				texto=MidA(texto,ll_posicion_puntoycoma+1)
			else
				direc=trim(MidA(texto,1,posicion_coma - 1))
				texto=MidA(texto,posicion_coma+1)
			end if
			if in_smtp.of_csd_AddTocco_limitado(direc,ls_limite)=-1 then
				if not(in_smtp.of_csd_enviar_datos()) then
					lista_emails+=direc+cr
				else
					in_smtp.of_csd_AddTocco_reset()
					in_smtp.of_csd_AddTocco_limitado(direc,ls_limite)
				end if
			end if
		end if	
	loop
	texto = trim(texto)
	if in_smtp.of_csd_AddTocco_limitado(texto,ls_limite)=-1 then
		if not(in_smtp.of_csd_enviar_datos()) then
			lista_emails+=texto+cr
		else
			in_smtp.of_csd_AddTocco_reset()
			in_smtp.of_csd_AddTocco_limitado(texto,ls_limite)
			if not(in_smtp.of_csd_enviar_datos()) then
				lista_emails+=texto+cr
			end if
		end if
	else
		if not(in_smtp.of_csd_enviar_datos()) then
			lista_emails+=texto+cr
		end if
	end if
end if
in_smtp.of_csd_AddTocco_reset()

//			in_smtp.of_csd_Addbcc_unico(direc)
//		end if	
//		
//	loop
//end if

if not f_es_vacio(copia) then
	direc = trim(copia)
	in_smtp.of_csd_Addbcc_unico(direc)
end if

in_smtp.of_csd_cerrar_conexion()

if f_es_vacio(lista_emails) then
	st_status_bar.text="El mensaje fue enviado correctamente"
	st_status_bar.textcolor=rgb(0,196,0)
	MessageBox(g_titulo, "El mensaje fue enviado correctamente")
	cb_close.triggerevent(clicked!)
else
	st_status_bar.text="No se pudo enviar el mensaje "
	st_status_bar.textcolor=rgb(255,0,0)
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al enviar los siguientes emails:"+cr+lista_emails)
end if



end event

public subroutine wf_cargar_adjuntos ();
end subroutine

public function string wf_cargar_direcciones (datastore ds_direcciones);// Funcion para cargar el campo de destinatarios "sle_destinatario" con el datastore
// que contiene la seleccion de destinatarios.

string texto,direc
long i

texto=''
for i=1 to ds_direcciones.rowcount()
	direc=ds_direcciones.GetItemString(i,'direccion')		
	if PosA(texto,direc)>0 then continue
	if i>1 then texto=texto + ', '
	texto=texto + direc
	
next

return texto
end function

event open;/* VENTANA PARA EL ENVIO DE MAILS

* Parametro entrada: Struct st_mail -> Parametros para inicializar los campos del mail con valores.
* Variables globales usadas:
	g_directorio_rtf			-> directorio de plantillas
	g_directorio_temporal	-> directorio temporal donde guardar los ficheros comprimidos para el envio
	g_dir_aplicacion			-> directorio de instalacion de la aplicacion
	g_titulo						-> titulo de la aplicacion

* Modificar f_aplicar_plantilla con las funciones de sustitucion de campos.
  SICA usa	f_sellador_campos_plantilla_aviso_visado
				f_plantillas_estructura
*/
 


st_mail parametros
long i,fila
double tamanyo
string fichero

f_centrar_ventana(this)

idw_adjuntos = tab_1.tabpage_2.dw_adjuntos
idw_opciones = tab_1.tabpage_3.dw_opciones
imle_mensaje = tab_1.tabpage_1.mle_mensaje

isle_destino=tab_2.tabpage_4.sle_destino
isle_cc=tab_2.tabpage_5.sle_cc
isle_cco=tab_2.tabpage_6.sle_cco

// Parametros pasados en la llamada a la ventana (st_mail)
parametros = Message.PowerObjectParm
isle_destino.text = parametros.direccion
isle_cc.text = parametros.cc
isle_cco.text = parametros.cco
mle_asunto.text = parametros.asunto
imle_mensaje.text = parametros.mensaje
idw_adjuntos.DataObject = parametros.dw_adjuntos
is_id_fase = parametros.id_fase


// Cargamos los adjuntos
for i=1 to upperbound(parametros.adjuntos)
	fichero=parametros.adjuntos[i]

	fila=idw_adjuntos.insertrow(0)
	idw_adjuntos.SetItem(fila,'nombre_fichero',fichero)
	tamanyo = Ceiling(gnv_fichero.of_GetFileSize(fichero) / 1024)
	idw_adjuntos.setitem(fila,'tamanyo',string(tamanyo,"#,###,##0") + ' Kb')
next

ids_destinatarios=create datastore
ids_destinatarios.DataObject='d_email_direcciones'
ids_destinatarios.SetTransObject(SQLCA)
ids_cc=create datastore
ids_cc.DataObject='d_email_direcciones'
ids_cc.SetTransObject(SQLCA)
ids_cco=create datastore
ids_cco.DataObject='d_email_direcciones'
ids_cco.SetTransObject(SQLCA)
// Recuperamos las preferencias y las opciones
this.event csd_cargar_preferencias()
f_recuperar_consulta_un_dw(idw_opciones,'w_csd_mail_send_sock','INICIO')



end event

on w_csd_mail_send_sock.create
int iCurrent
call super::create
this.st_status_bar=create st_status_bar
this.mle_asunto=create mle_asunto
this.cb_send_mail=create cb_send_mail
this.cb_close=create cb_close
this.gb_5=create gb_5
this.gb_subject=create gb_subject
this.cb_grabar=create cb_grabar
this.cb_comprimir=create cb_comprimir
this.cb_help=create cb_help
this.tab_1=create tab_1
this.tab_2=create tab_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_status_bar
this.Control[iCurrent+2]=this.mle_asunto
this.Control[iCurrent+3]=this.cb_send_mail
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.gb_5
this.Control[iCurrent+6]=this.gb_subject
this.Control[iCurrent+7]=this.cb_grabar
this.Control[iCurrent+8]=this.cb_comprimir
this.Control[iCurrent+9]=this.cb_help
this.Control[iCurrent+10]=this.tab_1
this.Control[iCurrent+11]=this.tab_2
end on

on w_csd_mail_send_sock.destroy
call super::destroy
destroy(this.st_status_bar)
destroy(this.mle_asunto)
destroy(this.cb_send_mail)
destroy(this.cb_close)
destroy(this.gb_5)
destroy(this.gb_subject)
destroy(this.cb_grabar)
destroy(this.cb_comprimir)
destroy(this.cb_help)
destroy(this.tab_1)
destroy(this.tab_2)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_csd_mail_send_sock
integer x = 1966
integer y = 1212
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_csd_mail_send_sock
integer x = 1957
integer y = 1336
integer width = 581
end type

type st_status_bar from statictext within w_csd_mail_send_sock
integer x = 114
integer y = 1832
integer width = 2286
integer height = 72
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type mle_asunto from multilineedit within w_csd_mail_send_sock
integer x = 137
integer y = 396
integer width = 2281
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
boolean autovscroll = true
end type

type cb_send_mail from commandbutton within w_csd_mail_send_sock
integer x = 850
integer y = 1964
integer width = 402
integer height = 100
integer taborder = 80
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Enviar"
end type

event clicked;idw_opciones.AcceptText()

parent.event csd_cargar_opciones()

parent.event csd_enviar()


end event

type cb_close from commandbutton within w_csd_mail_send_sock
integer x = 1289
integer y = 1964
integer width = 402
integer height = 100
integer taborder = 90
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
end type

on clicked;// Clicked script for cb_exit

Close (Parent)

end on

type gb_5 from groupbox within w_csd_mail_send_sock
integer x = 82
integer y = 1784
integer width = 2368
integer height = 156
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Estado"
end type

type gb_subject from groupbox within w_csd_mail_send_sock
integer x = 96
integer y = 336
integer width = 2354
integer height = 184
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Asunto"
end type

type cb_grabar from commandbutton within w_csd_mail_send_sock
boolean visible = false
integer x = 1925
integer y = 1464
integer width = 613
integer height = 100
integer taborder = 100
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Grabar datos por defecto"
end type

event clicked;////messagebox(g_titulo, 'Esta opci$$HEX1$$f300$$ENDHEX$$n debe grabar los datos por defecto')
//
//g_email_servidor = sle_1.text
//
//  UPDATE var_globales  
//     SET texto = :g_email_servidor  
//   WHERE var_globales.nombre = 'g_email_servidor'
//           ;
//
end event

type cb_comprimir from commandbutton within w_csd_mail_send_sock
boolean visible = false
integer x = 2117
integer y = 980
integer width = 402
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "comprimir"
end type

event clicked;//u_zip zip
//
//zip = create u_zip
//
//zip.idw_1 = dw_1
//zip.ruta_zip = g_dir_aplicacion + g_paquete_temporal + g_n_colegiado + '_' + g_prefijo_expediente + idw_fase.getitemstring(1, 'fases_n_expedi') + '_' + g_prefijo_registro + idw_fase.getitemstring(1, 'fases_n_registro') + '.zip'
//zip.event compress()
//
//destroy u_zip
end event

type cb_help from commandbutton within w_csd_mail_send_sock
boolean visible = false
integer x = 2190
integer y = 1088
integer width = 338
integer height = 100
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Help"
end type

on clicked;
//f_open_help(parent.ClassName( ))
end on

type tab_1 from tab within w_csd_mail_send_sock
integer x = 82
integer y = 540
integer width = 2368
integer height = 1232
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 74481808
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2331
integer height = 1116
long backcolor = 74481808
string text = "Mensaje"
long tabtextcolor = 33554432
long tabbackcolor = 74481808
long picturemaskcolor = 536870912
mle_mensaje mle_mensaje
end type

on tabpage_1.create
this.mle_mensaje=create mle_mensaje
this.Control[]={this.mle_mensaje}
end on

on tabpage_1.destroy
destroy(this.mle_mensaje)
end on

type mle_mensaje from multilineedit within tabpage_1
integer x = 23
integer y = 24
integer width = 2290
integer height = 1068
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
borderstyle borderstyle = stylelowered!
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2331
integer height = 1116
long backcolor = 74481808
string text = "Adjuntos"
long tabtextcolor = 33554432
long tabbackcolor = 74481808
long picturemaskcolor = 536870912
dw_adjuntos dw_adjuntos
end type

on tabpage_2.create
this.dw_adjuntos=create dw_adjuntos
this.Control[]={this.dw_adjuntos}
end on

on tabpage_2.destroy
destroy(this.dw_adjuntos)
end on

type dw_adjuntos from u_dw within tabpage_2
event csd_adjuntar ( )
event csd_quitar ( )
event csd_quitartodos ( )
integer x = 23
integer y = 24
integer width = 2290
integer height = 1068
integer taborder = 11
string dataobject = "d_email_adjuntos"
boolean ib_isupdateable = false
end type

event csd_adjuntar();//

String ls_pathname, ls_filename, ls_filter
Integer li_rc,fila,i
double tamanyo

ls_filter = "Todos los ficheros,*.*"

//li_rc = GetFileOpenName("Selecciona los ficheros a adjuntar", &
//		ls_pathname, ls_filename, "", ls_filter)
inv_file_dialog.ib_allowmultiselect = true

li_rc=inv_file_dialog.of_getopenfilename("Selecciona los ficheros a adjuntar", ls_pathname, ls_filename,"", ls_filter)

If li_rc = 1 Then
	for i=1 to UpperBound(inv_file_dialog.is_selectedfiles)
		fila=idw_adjuntos.insertrow(0)
		idw_adjuntos.SetItem(fila,'nombre_fichero',ls_pathname + inv_file_dialog.is_selectedfiles[i])
		tamanyo = Ceiling(gnv_fichero.of_GetFileSize(ls_pathname + inv_file_dialog.is_selectedfiles[i]) / 1024)
		idw_adjuntos.setitem(fila,'tamanyo',string(tamanyo,"#,###,##0") + ' Kb')
	next

End If

end event

event csd_quitar();//
idw_adjuntos.deleterow(idw_adjuntos.GetRow())
end event

event csd_quitartodos();dw_adjuntos.reset()
end event

event rbuttondown;call super::rbuttondown;long pos1,pos2

m_submenu_anexos menu


menu = create m_submenu_anexos
menu.idw_padre = this

	
if this.getrow() = 0 then 
	menu.m_adjuntar.enabled=true
	menu.m_quitar.enabled=false
	menu.m_quitartodos.enabled=false	
end if

//menu.PopMenu(xpos+5,ypos+10)
//MessageBox("TAB",string(tab_1.PointerX())+"-"+string(tab_1.PointerY()))
//MessageBox("TAB",string(idw_adjuntos.PointerX())+"-"+string(idw_adjuntos.PointerY()))
pos1=tab_1.X+idw_adjuntos.PointerX()
pos2=tab_1.Y+idw_adjuntos.PointerY()
menu.PopMenu(pos1+50, pos2+120)

end event

event constructor;call super::constructor;of_setrowselect(false)
of_setrowmanager(true)

// Multiseleccion
//this.inv_rowselect.of_SetStyle (this.inv_rowselect.EXTENDED)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2331
integer height = 1116
long backcolor = 74481808
string text = "Opciones"
long tabtextcolor = 33554432
long tabbackcolor = 74481808
long picturemaskcolor = 536870912
cb_cargar_opciones cb_cargar_opciones
cb_grabar_opciones cb_grabar_opciones
dw_opciones dw_opciones
end type

on tabpage_3.create
this.cb_cargar_opciones=create cb_cargar_opciones
this.cb_grabar_opciones=create cb_grabar_opciones
this.dw_opciones=create dw_opciones
this.Control[]={this.cb_cargar_opciones,&
this.cb_grabar_opciones,&
this.dw_opciones}
end on

on tabpage_3.destroy
destroy(this.cb_cargar_opciones)
destroy(this.cb_grabar_opciones)
destroy(this.dw_opciones)
end on

type cb_cargar_opciones from u_cb within tabpage_3
integer x = 1778
integer y = 1000
integer width = 498
integer taborder = 11
string text = "Cargar Opciones"
end type

event clicked;call super::clicked;if (messagebox(g_titulo, "Se sobrescribir$$HEX1$$e100$$ENDHEX$$n los datos por defecto. $$HEX1$$bf00$$ENDHEX$$Seguro que desea continuar?", Question!, YesNo!, 1) = 1) then
	f_recuperar_consulta_un_dw(idw_opciones,'w_csd_mail_send_sock','INICIO')
end if

end event

type cb_grabar_opciones from u_cb within tabpage_3
integer x = 1778
integer y = 884
integer width = 498
integer taborder = 11
string text = "Grabar Opciones"
end type

event clicked;call super::clicked;if (messagebox(g_titulo, "Se sobrescribir$$HEX1$$e100$$ENDHEX$$n los datos por defecto. $$HEX1$$bf00$$ENDHEX$$Seguro que desea continuar?", Question!, YesNo!, 1) = 1) then
	f_grabar_consulta_un_dw(dw_opciones,'w_csd_mail_send_sock','INICIO')
end if

end event

type dw_opciones from u_dw within tabpage_3
integer x = 23
integer y = 24
integer width = 2290
integer height = 836
integer taborder = 11
string dataobject = "d_email_opciones"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;insertrow(0)
end event

event clicked;call super::clicked;
String ls_pathname, ls_filename, ls_filter,ls_direc,destino
Integer li_rc,fila,posic
double tamanyo


choose case dwo.name
	case 'b_plantilla'
		
		ls_filter = "Ficheros de Plantillas,*.txt"
		
		gnv_fichero.of_changedirectory(g_directorio_rtf)
		
		li_rc = GetFileOpenName("Selecciona la plantilla", &
				ls_pathname, ls_filename, "", ls_filter)
		
		if li_rc = 1 then 
			posic=LastPos(ls_pathname,'\')
			ls_direc=MidA(ls_pathname,1,posic)
			destino=ls_pathname
			if upper(ls_direc)<>upper(g_directorio_rtf) then
				MessageBox(g_titulo,"Se va a copiar la plantilla al directorio de plantillas "+g_directorio_rtf)
				destino=g_directorio_rtf+ls_filename
				gnv_fichero.of_filecopy(ls_pathname, destino, FALSE)
			end if
			idw_opciones.Setitem(1,'plantilla', ls_filename)
			
		end if

end choose
end event

type tab_2 from tab within w_csd_mail_send_sock
integer x = 96
integer y = 28
integer width = 2350
integer height = 288
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 74481808
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on tab_2.create
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.Control[]={this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6}
end on

on tab_2.destroy
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

type tabpage_4 from userobject within tab_2
integer x = 18
integer y = 100
integer width = 2313
integer height = 172
long backcolor = 74481808
string text = "Destinatarios"
long tabtextcolor = 33554432
long tabbackcolor = 74481808
long picturemaskcolor = 536870912
sle_destino sle_destino
pb_1 pb_1
cb_1 cb_1
end type

on tabpage_4.create
this.sle_destino=create sle_destino
this.pb_1=create pb_1
this.cb_1=create cb_1
this.Control[]={this.sle_destino,&
this.pb_1,&
this.cb_1}
end on

on tabpage_4.destroy
destroy(this.sle_destino)
destroy(this.pb_1)
destroy(this.cb_1)
end on

type sle_destino from multilineedit within tabpage_4
integer x = 27
integer y = 20
integer width = 2030
integer height = 136
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean vscrollbar = true
boolean autovscroll = true
end type

type pb_1 from u_pb within tabpage_4
integer x = 2185
integer y = 44
integer width = 119
integer taborder = 11
string text = "."
string picturename = ".\imagenes\agenda_peq.bmp"
end type

event clicked;call super::clicked;open(w_email_agenda)
end event

type cb_1 from u_cb within tabpage_4
integer x = 2062
integer y = 44
integer width = 110
integer taborder = 11
string text = "..."
end type

event clicked;call super::clicked;OpenWithParm(w_email_destinatarios,ids_destinatarios)

ids_destinatarios= Message.PowerObjectParm

if Not(IsNull(ids_destinatarios)) then 
	isle_destino.text=wf_cargar_direcciones(ids_destinatarios)
end if
end event

type tabpage_5 from userobject within tab_2
integer x = 18
integer y = 100
integer width = 2313
integer height = 172
long backcolor = 74481808
string text = "CC"
long tabtextcolor = 33554432
long tabbackcolor = 74481808
long picturemaskcolor = 536870912
sle_cc sle_cc
pb_2 pb_2
cb_2 cb_2
end type

on tabpage_5.create
this.sle_cc=create sle_cc
this.pb_2=create pb_2
this.cb_2=create cb_2
this.Control[]={this.sle_cc,&
this.pb_2,&
this.cb_2}
end on

on tabpage_5.destroy
destroy(this.sle_cc)
destroy(this.pb_2)
destroy(this.cb_2)
end on

type sle_cc from multilineedit within tabpage_5
integer x = 27
integer y = 20
integer width = 2030
integer height = 136
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean vscrollbar = true
boolean autovscroll = true
end type

type pb_2 from u_pb within tabpage_5
integer x = 2185
integer y = 44
integer width = 119
integer taborder = 21
string text = ""
string picturename = "agenda_peq.bmp"
end type

event clicked;call super::clicked;open(w_email_agenda)
end event

type cb_2 from u_cb within tabpage_5
integer x = 2062
integer y = 44
integer width = 110
integer taborder = 30
string text = "..."
end type

event clicked;call super::clicked;OpenWithParm(w_email_destinatarios,ids_cc)


ids_cc= Message.PowerObjectParm

isle_cc.text=wf_cargar_direcciones(ids_cc)
end event

type tabpage_6 from userobject within tab_2
integer x = 18
integer y = 100
integer width = 2313
integer height = 172
long backcolor = 74481808
string text = "CCO"
long tabtextcolor = 33554432
long tabbackcolor = 74481808
long picturemaskcolor = 536870912
sle_cco sle_cco
pb_3 pb_3
cb_3 cb_3
end type

on tabpage_6.create
this.sle_cco=create sle_cco
this.pb_3=create pb_3
this.cb_3=create cb_3
this.Control[]={this.sle_cco,&
this.pb_3,&
this.cb_3}
end on

on tabpage_6.destroy
destroy(this.sle_cco)
destroy(this.pb_3)
destroy(this.cb_3)
end on

type sle_cco from multilineedit within tabpage_6
integer x = 27
integer y = 20
integer width = 2030
integer height = 136
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean vscrollbar = true
boolean autovscroll = true
end type

type pb_3 from u_pb within tabpage_6
integer x = 2185
integer y = 44
integer width = 119
integer taborder = 11
string text = ""
string picturename = "agenda_peq.bmp"
end type

event clicked;call super::clicked;open(w_email_agenda)
end event

type cb_3 from u_cb within tabpage_6
integer x = 2062
integer y = 44
integer width = 110
integer taborder = 11
string text = "..."
end type

event clicked;call super::clicked;OpenWithParm(w_email_destinatarios,ids_cco)


ids_cco= Message.PowerObjectParm

isle_cco.text=wf_cargar_direcciones(ids_cco)
end event

