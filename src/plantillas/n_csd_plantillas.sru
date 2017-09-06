HA$PBExportHeader$n_csd_plantillas.sru
forward
global type n_csd_plantillas from nonvisualobject
end type
end forward

global type n_csd_plantillas from nonvisualobject
end type
global n_csd_plantillas n_csd_plantillas

type variables
// ************ DECLARACION DE CONSTANTES BASICAS DE MS WORD ***************************
CONSTANT INTEGER &
wdSendToNewDocument = 0, &
wdFormLetters = 0, &
wdNotAMergeDocument = -1, &
wdCatalog = 3,&
wdMergeSubType = 8   //7=Word 8=Word2000


// ************* DECLARACION DE VARIABLES	**********************************************
OleObject word
n_cst_filesrvwin32 inv_Filesrv
n_file_dialogs inv_file_dialog

string mdb, ruta_mdb, ruta_plantilla, nombre_plantilla, nombre_pdf, ruta,is_modulo_asociado, is_colegiado, is_codigo, is_registro
string UID="", PWD="", DSN="correspondencias"
string conexion='TABLE colegiados'
string sql="select * from colegiados where clave is not null"

integer avisos=0
boolean permitir_editar_plantilla, pdf, email, previsualizar=true, firmar_pdf,papel
integer copias

//MAIL
string direccion_email, asunto_email, texto_email, formato_html='N'
boolean pdf_previsualizar=false

//Datos certificado
string certificado =''  //Ruta del certificado
string password 			// Password del certificado
string nombre_cer			// Nombre del firmante
string razon				
string situacion

n_csd_impresion_formato i_impresion
end variables

forward prototypes
public function integer f_enviar_mail ()
public subroutine f_error (string codigo)
public subroutine f_firmar_pdf (string fichero_pdf)
public function integer f_word_a_pdf (string ruta_word, string ruta_pdf)
public function integer f_combinar_plantilla ()
public function integer f_conectar_word ()
public function integer f_version_word ()
public function integer f_abrir_plantilla (boolean crear)
public function integer f_combinar_plantilla_txt_y_tablas (ref datastore ds_datastore, ref datastore ds_marcador)
public function integer f_combinar_plantilla_txt ()
public subroutine f_registro_carta ()
public subroutine f_word_a_papel ()
public function integer f_combinar_plantilla_mdb ()
end prototypes

public function integer f_enviar_mail ();
//Retorno
// 	1	: Env$$HEX1$$ed00$$ENDHEX$$o CORRECTO
// 	-1	: Fallo en el establecimiento de la sesi$$HEX1$$f300$$ENDHEX$$n de correo
//		-2 : Fallo en el env$$HEX1$$ed00$$ENDHEX$$o del mensaje

string ls_Filter
mailsession lms_Session
mailmessage lm_Message
mailrecipient lm_Recipient
mailFileDescription lmf_File
mailreturncode lmc_Return
string ls_UserName,texto
ulong ll_Length
int pos,j=1
string email_relativo
integer retorno

if f_es_vacio(direccion_email) then 
	f_error('-07')	
	return -1
end if


//De momento si no existe el fichero, no se env$$HEX1$$ed00$$ENDHEX$$a el email...
if not fileexists(ruta + nombre_pdf+'.pdf') then 
	f_error('-05')
	return -1
end if

//Si queremos adjuntar archivos...
if not (f_es_vacio(nombre_pdf) or f_es_vacio(ruta)) and fileexists(ruta + nombre_pdf+'.pdf') then
	lmf_File.FileType = mailAttach!
	lmf_File.FileName = nombre_pdf+'.pdf' //ruta_base + ruta_relativa + nombre+'.pdf'
	lmf_file.PathName = ruta + nombre_pdf+'.pdf'
	lmf_file.Position = -1
	lm_Message.Attachmentfile[1] = lmf_File
end if
// Comenzamos la sesi$$HEX1$$f300$$ENDHEX$$n de correo electr$$HEX1$$f300$$ENDHEX$$nico
lms_Session = CREATE mailsession

//lmc_Return = lms_Session.mailAddress(lm_Message)

//Rellenamos el mensaje

//Si el formato de mail es con html, han de a$$HEX1$$f100$$ENDHEX$$adirse las siguientes cadenas, para que lo entienda en gestor de correo.
//(Ra$$HEX1$$fa00$$ENDHEX$$l 23/6/05) a petici$$HEX1$$f300$$ENDHEX$$n de L. Bonilla

if formato_html = 'S' then 
	lm_Message.Subject = asunto_email + '~nContent-type: text/html~nContent-Transfer-Encoding: quoted-printable~n~n<!--'
	lm_Message.NoteText = ' -->' + texto_email + ''
else
	lm_Message.NoteText = texto_email
	lm_Message.Subject = asunto_email
end if

//Rellenamos el recipiente para el destinatario adecuado
//Se le ha a$$HEX1$$f100$$ENDHEX$$adido el prefijo "SMTP:" para que no de problemas con servidores de 
//correo Exchange. De esta forma funciona sin problemas en todos los correos y servidores
lm_Recipient.RecipientType = mailTo!
pos = Pos(direccion_email,';',1)
do while pos >0 
	email_relativo = mid(direccion_email,1,pos - 1)
	direccion_email = trim(mid(direccion_email,pos+1,9999))
	pos = Pos(direccion_email,';',pos+1)
	lm_Recipient.Address ='SMTP:'+email_relativo  //destinatario   
	lm_Recipient.Name = email_relativo  //"Notificaciones de Reparos"
	lm_Message.Recipient[j] = lm_Recipient
	j++
loop

if not f_es_vacio(direccion_email) then
	lm_Recipient.Address ='SMTP:'+direccion_email  //destinatario   
	lm_Recipient.Name = direccion_email  //"Notificaciones de Reparos"
	lm_Message.Recipient[j] = lm_Recipient
end if


// LUIS 20/9/2005
// Guardamos el directorio de trabajo porque al realizar el mailLogon puede cambiar por el directorio del programa de correo
string directorio
directorio = inv_Filesrv.of_getcurrentdirectory()

lmc_Return = lms_Session.mailLogon()

// Comprobamos que la sesi$$HEX1$$f300$$ENDHEX$$n ha sido iniciada con $$HEX1$$e900$$ENDHEX$$xito
if lmc_Return <> mailReturnSuccess! then	return -2

lmc_Return = lms_Session.mailSend(lm_Message)

// Comprobamos que el mensaje ha sido enviado con $$HEX1$$e900$$ENDHEX$$xito
if lmc_return <> MailReturnSuccess! then
	retorno = -1
	f_error('-02')	
else	
	retorno = 1
	f_error('+03')	
end if

lmc_Return = lms_Session.mailLogoff()
destroy lms_Session

// LUIS 20/9/2005
// Restauramos el directorio de trabajo, como corresponde estar para que todas las imagenes sigan funcionando
inv_Filesrv.of_changedirectory(directorio)


return retorno
end function

public subroutine f_error (string codigo);string texto =''

choose case codigo
	case '+03'	
		texto = 'El mensaje ha sido enviado correctamente'
//	case '+04'
//		texto = 'Se ha generado el documento ' + nombre +'.pdf en la carpeta ' + ruta_base + ruta_relativa
	case '-01' 
		texto = 'El formato del informe especificado NO es v$$HEX1$$e100$$ENDHEX$$lido'
	case '-02' 
		texto = 'La sesi$$HEX1$$f300$$ENDHEX$$n NO ha sido iniciada correctamente'
	case '-03' 
		texto = 'Ha habido alg$$HEX1$$fa00$$ENDHEX$$n problema durante el env$$HEX1$$ed00$$ENDHEX$$o del mail'+cr+'Consulte con el administrador del sistema.'
	case '-04' 
		texto = 'Ha habido problemas a la hora de generar el pdf'
	case '-04b' 
		texto = 'NO tiene instalada la impresora de generaci$$HEX1$$f300$$ENDHEX$$n de PDF.'+cr+' Consulte con el administrador del sistema'
	case '-05' 
		texto = 'La referencia del documento NO es correcta'
	case '-06' 
		texto = 'No ha especificado una ruta v$$HEX1$$e100$$ENDHEX$$lida para generar el documento pdf o no se tiene acceso a la unidad'
	case '-07' 
		texto = 'No ha especificado ninguna direcci$$HEX1$$f300$$ENDHEX$$n de correo'
	case '-08' 
		texto = 'No ha podido crear el directorio correctamente'
	case '-09' 
		texto = 'No se ha podido firmar el fichero PDF'	
	case '-10' 
		texto = 'No se ha podido generar la entrada para la web. No existe la referencia.'			
	case '07' 
	case '08' 
		
end choose


//Si el modo de avisos no es silencioso, mostramos el aviso por ventana
if avisos > 0 then Messagebox(g_titulo,texto)
end subroutine

public subroutine f_firmar_pdf (string fichero_pdf);// Funcion para firmar PDFs. Sobreescribe el pdf original.
// NECESITA EL OBJETO u_signer DE SICA

u_signer firmador

firmador = create u_signer

firmador.i_pkcs = g_directorio_certificados+certificado
firmador.i_nom = nombre_cer
firmador.i_razon = razon
firmador.i_loc = situacion
firmador.i_clave = password
firmador.i_directorio_aplicacion = g_dir_aplicacion

firmador.i_fichero_entrada 	= fichero_pdf
firmador.i_o 						= mid(fichero_pdf,1,len(fichero_pdf) - 4)+'_signed.pdf'
firmador.i_err = g_dir_aplicacion+'error.txt'	

firmador.of_firmar()

if FileExists(firmador.i_o) then
	inv_Filesrv.of_FileRename(mid(fichero_pdf,1,len(fichero_pdf) - 4)+'_signed.pdf',fichero_pdf)
	FileDelete(fichero_pdf)
else
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al firmar el fichero",StopSign!)
end if
end subroutine

public function integer f_word_a_pdf (string ruta_word, string ruta_pdf);//Convierte un archivo de Word en un pdf
//Utilizando la impresora Docuprinter...

//Retorno :		1   	Transformaci$$HEX1$$f300$$ENDHEX$$n Satisfactoria
//				  -1 		El fichero NO existe
//				  -2		NO se tiene instalado correctamente el m$$HEX1$$f300$$ENDHEX$$dulo de conversi$$HEX1$$f300$$ENDHEX$$n a pdf (Docuprinter)	

string impresora2,version
int ret=0,ret_dis,retorno 
long es

//Descriptor del control
long handle
	
//Si el fichero no existe devolvemos el error -1
if not FileExists(ruta_word) then return -1
// Si el directorio no existe lo creamos
if not FileExists(ruta_pdf) then inv_Filesrv.of_Createdirectory(ruta_pdf)

// Modificamos la impresora por defecto de Word y le ponemos la docuprinter
string ls_impresora_defecto

ls_impresora_defecto = Word.Application.ActivePrinter

Word.Application.ActivePrinter = 'docuprinter'


//Obtenemos la ruta donde est$$HEX2$$e1002000$$ENDHEX$$instalada la impresora Docuprinter
RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","ProductVersion", RegString!, version)
// Establecer parametros de Neevia
if version='LT 5.x' then
	ret += RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","Option_SaveAs_Visible", ReguLong!,  0)
	ret += RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","FileMask", RegString!,  nombre_pdf+'.pdf')
	ret +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputPath", RegString!,ruta_pdf)
	ret +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputFile", RegString!, nombre_pdf)
	ret +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputType", ReguLong!, 1)
	if pdf_previsualizar then
		ret +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","View", ReguLong!, 1)
	else
		ret +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","View", ReguLong!, 0)		
	end if
else
	ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","UseMask", ReguLong!, 1) 
	ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","FileMask", RegString!, nombre_pdf +'.pdf')
	ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","PDFOutputPath", RegString!,ruta_pdf)
	ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputFile", RegString!, nombre_pdf+'.pdf')
	ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputType", ReguLong!, 1)
end if



////Creamos y conectamos el control word
//word = CREATE oleobject
//
//handle = word.ConnectToNewObject("word.application")
//
////Abrimos el documento pero sin visualizarlo
//word.Documents.Open(ruta_word)
//word.Application.Visible = False
//
//if ret <> 5 then
//	messagebox(g_titulo, 'No tiene instalado el m$$HEX1$$f300$$ENDHEX$$dulo de conversi$$HEX1$$f300$$ENDHEX$$n a PDF')
//	//devolvemos el valor predeterminado.
//	impresora.of_setdefaultprinter(impresora2)	
//	// Desconectamos
//	word.DisconnectObject()
//	//destruimos el control
//	Destroy word
//	return -2
//end if

word.ActiveDocument.PrintOut()  

/*DO UNTIL fileexists(ruta_pdf+nombre_pdf + '.PDF') //OR i_salir 
	SetPointer(Hourglass!)
	Yield()
LOOP
*/

//Esperamos hasta que se cree el archivo
OpenWithParm(w_espera_pdf,ruta_pdf + nombre_pdf+ '.PDF')
retorno = Message.DoubleParm

if not(fileexists(ruta_pdf + nombre_pdf+ '.PDF')) then	
	MessageBox("ERROR","Error al generar el PDF")
end if

Word.Application.ActivePrinter = ls_impresora_defecto

retorno = Message.DoubleParm

ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","UseMask", ReguLong!,0) 
ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","FileMask", RegString!, '')
ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","PDFOutputPath", RegString!,'C:\')
ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputFile", RegString!, '')
ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputType", ReguLong!, 1)

IF retorno = -1 THEN return -1

return 1

end function

public function integer f_combinar_plantilla ();// **********************************		COMBINACION TXT<->DOC		***************************
// Abre una conexion con el word y mediante el MailMerge, realiza una combinacion de correspondencia con un txt
// Todos los parametors de rutas de plantillas,conexion,sql y ruta del mdb se pasan por var. instancia
// Devuelve-> -1: Error conexion con Word				  

boolean version_ok
integer version,li_rc
long ll_i
string ls_escala



// CONECTAMOS CON WORD
li_rc=f_conectar_word()
if li_rc<0 then return li_rc

version=f_version_word()

//MessageBox("",string(version))
word.Documents.open(ruta_plantilla)

		
word.ActiveDocument.MailMerge.MainDocumentType = wdFormLetters 	

version_ok=true

if version > 11 then 
	word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
	FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE, wdMergeSubType)  
else 
	//Segun la version usamos una instruccion OpenDataSource
	choose case version
//		case 15 //Office 2013
//			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
//			FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE) 		
//		case 14 //Office 2010
//			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
//			FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE) 		
//		case 12 //Office 2007
//			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
//			FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE) 		
		case 11 //Office 2003
			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
			FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE) 
		case 10 //Office XP (2002)
			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
			FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE,8)
		case 9 //Office 2000
			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
			FALSE,TRUE,FALSE,"","",FALSE,"","","","") 
		case else //Otros...
			MessageBox(g_titulo,"Su versi$$HEX1$$f300$$ENDHEX$$n de Word no soporta la combinaci$$HEX1$$f300$$ENDHEX$$n de correspondencia")
			word.Quit(0)
			version_ok=false
	end choose
end if 

ruta=i_impresion.ruta_base+i_impresion.ruta_relativa
nombre_pdf = i_impresion.nombre
pdf_previsualizar = i_impresion.pdf_previsualizar

// Si la version era correcta se ejecuta el MailMerge
if version_ok then
	
	/****/
	word.ActiveDocument.MailMerge.Destination = wdSendToNewDocument 
	word.ActiveDocument.MailMerge.Execute	

	// La parte de NO previsualizacion no esta activa
	// SIEMPRE previsualiza si no es PDF
	if not(previsualizar) then
		word.ActiveDocument.PrintOut(False)
		
		if i_impresion.pdf='S' then
			nombre_plantilla=i_impresion.nombre + '.doc'
			word.ActiveDocument.saveas(g_directorio_temporal+nombre_plantilla)
			//Cerramos la plantilla sin rellenar		
			this.f_word_a_pdf(g_directorio_temporal+nombre_plantilla,ruta)
			if i_impresion.papel='S' then f_word_a_papel()
			if i_impresion.firmar_pdf='S' then f_firmar_pdf(ruta+nombre_pdf+'.pdf')	
			if i_impresion.email='S' then f_enviar_mail()
		end if

		word.Documents.Close(0)	
		word.Quit(0)
	else
	
		if i_impresion.pdf='S' then
			//Si el usuario quiere editar la plantilla no la imprimimos autom$$HEX1$$e100$$ENDHEX$$ticamente
			//word.Application.Activate()			
			nombre_plantilla=i_impresion.nombre+'.doc' 
			word.ActiveDocument.saveas(g_directorio_temporal+nombre_plantilla)
			//Cerramos la plantilla sin rellenar		
			this.f_word_a_pdf(g_directorio_temporal+nombre_plantilla,ruta)
			if i_impresion.papel='S' then f_word_a_papel()
			word.Documents.Close(0)
			word.Quit(0)
			if i_impresion.firmar_pdf='S' then f_firmar_pdf(ruta+nombre_pdf+'.pdf')
			if i_impresion.email='S' then f_enviar_mail()
			
		else
			//Si el usuario quiere editar la plantilla no la imprimimos autom$$HEX1$$e100$$ENDHEX$$ticamente
			// Se hace un try para evitar mayores problemas. Alexis. 9/12/2009
			try
				word.Visible=true
				word.Application.Activate()
				f_registro_carta()
			catch(Throwable e)
				messagebox(g_titulo, 'Word no est$$HEX2$$e1002000$$ENDHEX$$funcionando correctamente. Cierre los procesos Winword que est$$HEX1$$e100$$ENDHEX$$n abiertos y compruebe que la plantilla no se ha bloqueado', stopsign!)
			Finally
				word.Documents.Item(2).Close(0) 
			end try
		end if

	end if
end if
 


word.DisconnectObject()
destroy word

return 0
end function

public function integer f_conectar_word ();// **********************************		CONEXI$$HEX1$$d300$$ENDHEX$$N CON MS WORD			***************************
//Creamos el objeto Ole para manipular los datos del word

integer li_rc

word = create OleObject

li_rc = word.connecttonewobject("word.application")
if li_rc < 0 then
	messagebox(g_titulo, 'No es posible conectar con MS Word, es posible que no lo tenga instalado',StopSign!)
	return -1
end if 

If Not(FileExists(ruta_mdb)) then
	messagebox(g_titulo, 'No se encuentra la base de datos '+mdb+': '+ruta_mdb,StopSign!)
	return -2
end if

return 0
end function

public function integer f_version_word ();//OBTIENE LA VERSION DE WORD CONSULTANDO EL REGISTRO

string version,build
string lista[],lista2[]
integer retorno
long i,j
boolean encontrado
int li_version

// Se puede intentar averiguar la version en el registro
//retorno = RegistryKeys("HKEY_CURRENT_USER\Software\Microsoft\Office",lista)
//encontrado=false
//for i=1 to UpperBound(lista)
//	RegistryKeys("HKEY_CURRENT_USER\Software\Microsoft\Office\"+lista[i],lista2)
//	for j=1 to UpperBound(lista2)
//		if lista2[j]='Word' then 
//			version=lista[i]
//			encontrado=true
//			exit
//		end if
//	next
//	if encontrado then exit
//next

// Otra opcion es preguntarle a Word directamente la version
version=string(word.version)  
build=string(word.build)

li_version = integer(left(version, 2))

//choose case version
//	case "15.0"
//		return 14  //Microsoft Office 2013
//	case "14.0"
//		return 14  //Microsoft Office 2010
//	case "12.0"
//		return 12  // Microsoft Office 2007 (Vista)
//	case "11.0"
//		return 11  // Microsoft Office 2003
//	case "10.0"
//		return 10  // Microsoft Office XP
//	case "9.0" 
//		return 9  // Microsoft Office 2000
//	case "8.0"
//		return 8  // Microsoft Office 97
//	case "7.0"
//		return 7  // Microsoft Office 95
//end choose

if (li_version > 7) then return li_version

return 6 // Word 6 o anteriores


end function

public function integer f_abrir_plantilla (boolean crear);// **********************************		ABRIR PLANTILLA		***************************
// Abre una plantilla, pasada en la variable de instancia ruta_plantilla
// Entrada: crear (true->Si no existe, creamos la plantilla, 
//						 false->Si no existe devuelve error)
// Devuelve 1 si existia, 2 si no existia, -1 si no se creo la plantilla

integer version,retorno
boolean version_ok

//Creamos el objeto Ole para manipular los datos del word
word = create OleObject
word.connecttonewobject("word.application")
if (fileExists(ruta_plantilla)) then 
	word.Documents.open(ruta_plantilla)
	word.application.visible = true
	retorno=1
else
	if not(crear) then
		MessageBox(g_titulo,'La plantilla NO existe',StopSign!)
		word.application.visible = true
		word.DisconnectObject()
		destroy word
		return -1
	end if
	word.Documents.Add()
	version=f_version_word()
	version_ok=true	
	
	if version > 11 then 
		word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
		FALSE,FALSE,FALSE,"","",FALSE,"","",conexion,sql,"",TRUE, wdMergeSubType)  
	else 
	
		choose case version
	//		case 15
	//			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
	//			FALSE,FALSE,FALSE,"","",FALSE,"","",conexion,sql,"",TRUE) 
	//		case 14
	//			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
	//			FALSE,FALSE,FALSE,"","",FALSE,"","",conexion,sql,"",TRUE) 
	//		case 12
	//			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
	//			FALSE,FALSE,FALSE,"","",FALSE,"","",conexion,sql,"",TRUE) 			
			case 11
				word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
				FALSE,FALSE,FALSE,"","",FALSE,"","",conexion,sql,"",TRUE) 
			case 10
				word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
				FALSE,FALSE,FALSE,"","",FALSE,"","",conexion,sql,"",TRUE,8) 			
			case 9
				word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
				FALSE,FALSE,FALSE,"","",FALSE,"","",conexion,sql) 
			case else
				MessageBox(g_titulo,"Su versi$$HEX1$$f300$$ENDHEX$$n de Word no soporta la combinaci$$HEX1$$f300$$ENDHEX$$n de correspondencia")
				word.Quit(0)
				version_ok=false
		end choose
	end if
	
	word.ActiveDocument.saveas(ruta_plantilla)	
	retorno=2


end if

word.application.visible = true
word.DisconnectObject()
destroy word

return retorno
end function

public function integer f_combinar_plantilla_txt_y_tablas (ref datastore ds_datastore, ref datastore ds_marcador);// **********************************		COMBINACION TXT<->DOC	Y tablas	***************************
// Abre una conexion con el word y mediante el MailMerge, realiza una combinacion de correspondencia con un txt
// Todos los parametors de rutas de plantillas,conexion,sql y ruta del mdb se pasan por var. instancia
// Combina el uso de campos mergefield y marcadores.
// Devuelve-> -1: Error conexion con Word			
// Se pasa los valores mediante datastore . 
// ds_datastore : Contiene los datos que se van a mostrar en la tabla
// ds_marcador  : Contiene el nombre de los marcadores y campos. Los datos que se quieren mostrar siempre deben ser string. 
// Se debe rellenar en la tabla plantillas_campo el campo_interno ='marcador' y el campo_formulario = nombre del marcador
// El nombre del marcador y el nombre del registro que se va a mostrar deben ser iguales

boolean version_ok
integer version,li_rc
long ll_i, ll_j
string ls_escala, ls_marcador


// CONECTAMOS CON WORD
li_rc=f_conectar_word()
if li_rc<0 then return li_rc

version=f_version_word()
word.Documents.open(ruta_plantilla)

// Se construye los datos en la tabla de la plantilla
word.selection.typeparagraph()

// Se posiciona en cada marcador
for ll_j = 1 to ds_marcador.rowcount()
	//Se recorre el datastore para obtener los datos del registro a mostrar
	for ll_i = 1 to ds_datastore.rowcount()
       //Busca el nombre del marcador en la tabla plantillas_campos
		 ls_marcador = ds_marcador.getitemstring(ll_j, "campo")
		 // Se posiciona en el marcador con el nombre obtenido en ls_marcador en la plantilla
		 word.ActiveDocument.Bookmarks.item(ls_marcador).select
		 // Busca el campo que tiene el mismo nombre del marcador
		 ls_escala = ds_datastore.getitemstring(ll_i, ls_marcador)
		 // Inserta los datos en la tabla
		 word.selection.typetext(ls_escala)
		 if ll_i <> 1 then
			//Salto de l$$HEX1$$ed00$$ENDHEX$$nea
			 word.Selection.typetext("~n~n") 
		 end if
	next
next
word.selection.typeparagraph()

word.ActiveDocument.MailMerge.MainDocumentType = wdFormLetters 	

version_ok=true

if version > 11 then 
	word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
	FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE, wdMergeSubType)  
else 
	//Segun la version usamos una instruccion OpenDataSource
	choose case version
//		case 15 //Office 2013
//			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
//			FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE) 
//		case 14 //Office 2010
//			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
//			FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE) 
//		case 12 //Office 2007
//			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
//			FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE) 		
		case 11 //Office 2003
			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
			FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE) 
		case 10 //Office XP (2002)
			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
			FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE,8)
		case 9 //Office 2000
			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
			FALSE,TRUE,FALSE,"","",FALSE,"","","","") 
		case else //Otros...
			MessageBox(g_titulo,"Su versi$$HEX1$$f300$$ENDHEX$$n de Word no soporta la combinaci$$HEX1$$f300$$ENDHEX$$n de correspondencia")
			word.Quit(0)
			version_ok=false
	end choose
end if
// Si la version era correcta se ejecuta el MailMerge
if version_ok then
	/****/
	word.ActiveDocument.MailMerge.Destination = wdSendToNewDocument 
	word.ActiveDocument.MailMerge.Execute	
	

	// La parte de NO previsualizacion no esta activa
	// SIEMPRE previsualiza si no es PDF
	if not(previsualizar) then
		
		
		word.ActiveDocument.PrintOut(False)
		
		if pdf then
			nombre_plantilla=mid(ruta_plantilla,lastpos(ruta_plantilla,'\')+1)
			word.ActiveDocument.saveas(g_directorio_temporal+nombre_plantilla)
			//Cerramos la plantilla sin rellenar		
			this.f_word_a_pdf(g_directorio_temporal+nombre_plantilla,ruta)
			if firmar_pdf then f_firmar_pdf(ruta+nombre_pdf+'.pdf')	
			if email then f_enviar_mail()
		end if

		word.Documents.Close(0)	
		word.Quit(0)
	else
	
		if pdf then
			//Si el usuario quiere editar la plantilla no la imprimimos autom$$HEX1$$e100$$ENDHEX$$ticamente
			word.Application.Activate()			
			nombre_plantilla=mid(ruta_plantilla,lastpos(ruta_plantilla,'\')+1)
			word.ActiveDocument.saveas(g_directorio_temporal+nombre_plantilla)
			//Cerramos la plantilla sin rellenar		
			this.f_word_a_pdf(g_directorio_temporal+nombre_plantilla,ruta)
			word.Documents.Close(0)
			word.Quit(0)
			if firmar_pdf then f_firmar_pdf(ruta+nombre_pdf+'.pdf')
			if email then f_enviar_mail()
			
		else
			//Si el usuario quiere editar la plantilla no la imprimimos autom$$HEX1$$e100$$ENDHEX$$ticamente
			word.Visible=true
			word.Application.Activate()			
			word.Documents.Item(2).Close(0)
		end if

	end if
end if



word.DisconnectObject()
destroy word

return 0
end function

public function integer f_combinar_plantilla_txt ();// **********************************		COMBINACION TXT<->DOC		***************************
// Abre una conexion con el word y mediante el MailMerge, realiza una combinacion de correspondencia con un txt
// Todos los parametors de rutas de plantillas,conexion,sql y ruta del mdb se pasan por var. instancia
// Devuelve-> -1: Error conexion con Word				  

boolean version_ok
integer version,li_rc
long ll_i
string ls_escala



// CONECTAMOS CON WORD
li_rc=f_conectar_word()
if li_rc<0 then return li_rc

version=f_version_word()

//MessageBox("",string(version))
word.Documents.open(ruta_plantilla)

		
word.ActiveDocument.MailMerge.MainDocumentType = wdFormLetters 	

version_ok=true
if version > 11 then 
	word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
	FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE, wdMergeSubType)  
else 
	//Segun la version usamos una instruccion OpenDataSource
	choose case version
	//	case 15 //Office 2013
	//		word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
	//		FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE) 	
	//	case 14 //Office 2010
	//		word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
	//		FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE) 	
	//	case 12 //Office 2007
	//		word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
	//		FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE) 		
		case 11 //Office 2003
			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
			FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE) 
		case 10 //Office XP (2002)
			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
			FALSE,TRUE,FALSE,"","",FALSE,"","","","","",TRUE,8)
		case 9 //Office 2000
			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
			FALSE,TRUE,FALSE,"","",FALSE,"","","","") 
		case else //Otros...
			MessageBox(g_titulo,"Su versi$$HEX1$$f300$$ENDHEX$$n de Word no soporta la combinaci$$HEX1$$f300$$ENDHEX$$n de correspondencia")
			word.Quit(0)
			version_ok=false
	end choose
end if 

// Si la version era correcta se ejecuta el MailMerge
if version_ok then
	
	/****/
	word.ActiveDocument.MailMerge.Destination = wdSendToNewDocument 
	word.ActiveDocument.MailMerge.Execute	

	// La parte de NO previsualizacion no esta activa
	// SIEMPRE previsualiza si no es PDF
	if not(previsualizar) then
		word.ActiveDocument.PrintOut(False)
		
		if pdf then
			nombre_plantilla=mid(ruta_plantilla,lastpos(ruta_plantilla,'\')+1)
			word.ActiveDocument.saveas(g_directorio_temporal+nombre_plantilla)
			//Cerramos la plantilla sin rellenar		
			this.f_word_a_pdf(g_directorio_temporal+nombre_plantilla,ruta)
			if papel then f_word_a_papel()
			if firmar_pdf then f_firmar_pdf(ruta+nombre_pdf+'.pdf')	
			if email then f_enviar_mail()
		end if

		word.Documents.Close(0)	
		word.Quit(0)
	else
	
		if pdf then
			//Si el usuario quiere editar la plantilla no la imprimimos autom$$HEX1$$e100$$ENDHEX$$ticamente
			//word.Application.Activate()			
			nombre_plantilla=mid(ruta_plantilla,lastpos(ruta_plantilla,'\')+1)
			word.ActiveDocument.saveas(g_directorio_temporal+nombre_plantilla)
			//Cerramos la plantilla sin rellenar		
			this.f_word_a_pdf(g_directorio_temporal+nombre_plantilla,ruta)
			if papel then f_word_a_papel()
			word.Documents.Close(0)
			word.Quit(0)
			if firmar_pdf then f_firmar_pdf(ruta+nombre_pdf+'.pdf')
			if email then f_enviar_mail()
			
		else
			
			//Si el usuario quiere editar la plantilla no la imprimimos autom$$HEX1$$e100$$ENDHEX$$ticamente
			word.Visible=true
			word.Application.Activate()
			f_registro_carta()
			word.Documents.Item(2).Close(0) 
		end if

	end if
end if
 


word.DisconnectObject()
destroy word

return 0
end function

public subroutine f_registro_carta ();// Registra la plantilla llena con los datos del colegiado en la 
// tabla cartas

if is_modulo_asociado <> 'COLEGIADOS' then return


string  ls_ruta, ls_ruta_dest,ls_fecha, ls_fichero, ls_ruta_relativa, id_col
boolean lb_existe
int     li_valor,li_result
date    ld_fecha
string  ls_id_carta, ls_id_referencia, n_registro



ld_fecha = today()

ls_fecha = string(ld_fecha,'ddmmyyyy')

ls_id_carta      = f_siguiente_numero('ID_CARTA',10)
n_registro     = string(is_registro)

//string(g_directorio_documentos_plantillas)+string(year(ld_fecha))+'\'+is_colegiado+'\'
ls_ruta = string(g_directorio_documentos_plantillas)+string(year(ld_fecha))
ls_ruta_relativa = string(year(ld_fecha))+'\'+is_colegiado+'\'
lb_existe=inv_filesrv.of_directoryexists(ls_ruta)

//Si no existe el directorio lo crea
if not lb_existe then
	li_valor=inv_filesrv.of_createdirectory(ls_ruta)
	if li_valor = 1 then
		ls_ruta += '\'+is_colegiado+'\'
		lb_existe=inv_filesrv.of_directoryexists(ls_ruta)
		if not lb_existe then
			li_valor=inv_filesrv.of_createdirectory(ls_ruta)
		end if
	end if
else
	ls_ruta += '\'+is_colegiado+'\'
	lb_existe=inv_filesrv.of_directoryexists(ls_ruta)
		if not lb_existe then
			li_valor=inv_filesrv.of_createdirectory(ls_ruta)
		end if
end if

if li_valor = 1 then
	inv_filesrv.of_createdirectory(ls_ruta) 
else	
end if


//se obtiene solo el contador
n_registro = mid(n_registro, 6,20)
//se compone el nombre del fichero
ls_fichero = string(n_registro) +'_'+ls_fecha+'.doc'
ls_fichero = string (ls_fichero)
		

ls_ruta_dest=string(ls_ruta+'\'+ls_fichero)
//ls_ruta_dest = ls_ruta+ls_fichero
//messagebox("",ls_ruta_dest)
word.ActiveDocument.saveas(ls_ruta_dest)

id_col = f_colegiado_id_col(is_colegiado)

INSERT INTO cartas 
VALUES (:ls_id_carta, '', :ld_fecha, :is_modulo_asociado, :id_col, :g_usuario, :is_codigo, :is_registro, :ls_fichero, :ls_ruta_relativa,'N')
using sqlca;

IF SQLCA.SQLCode = -1 THEN
	rollback;
	MessageBox(g_titulo, "Error al guardar el documento")
ELSE
	commit;
END IF

//if pdf then
//	this.f_word_a_pdf(ls_ruta_dest,ruta)
//			//word.Documents.Close(0)
//			//word.Quit(0)
//			if firmar_pdf then f_firmar_pdf(ruta+nombre_pdf+'.pdf')
//			if email then f_enviar_mail()
//end if
end subroutine

public subroutine f_word_a_papel ();integer i
// Imprime el Word
for i=1 to copias
	word.ActiveDocument.PrintOut()  
next

end subroutine

public function integer f_combinar_plantilla_mdb ();// **********************************		COMBINACION MDB<->DOC		***************************
// Abre una conexion con el word y mediante el MailMerge, realiza una combinacion de correspondencia con un mdb
// Todos los parametors de rutas de plantillas,conexion,sql y ruta del mdb se pasan por var. instancia
// Devuelve-> -1: Error conexion con Word
//				  -2: No se encuentra el .mdb

boolean version_ok
integer version,li_rc

// CONECTAMOS CON WORD
li_rc=f_conectar_word()
if li_rc<0 then return li_rc

version=f_version_word()

//MessageBox("",string(version))
word.Documents.open(ruta_plantilla)
word.ActiveDocument.MailMerge.MainDocumentType = wdFormLetters 	

version_ok=true
if version > 11 then 
	word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
	FALSE,TRUE,FALSE,"","",FALSE,"","",conexion,sql,"",TRUE, wdMergeSubType)  
else 
	//Segun la version usamos una instruccion OpenDataSource
	choose case version
	//	case 15 //Office 2013
	//		word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
	//		FALSE,TRUE,FALSE,"","",FALSE,"","",conexion,sql,"",TRUE)			
	//	case 14 //Office 2010
	//		word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
	//		FALSE,TRUE,FALSE,"","",FALSE,"","",conexion,sql,"",TRUE)		
	//	case 12 //Office 2007
	//		word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
	//		FALSE,TRUE,FALSE,"","",FALSE,"","",conexion,sql,"",TRUE)		
		case 11 //Office 2003
			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
			FALSE,TRUE,FALSE,"","",FALSE,"","",conexion,sql,"",TRUE) 
		case 10 //Office XP (2002)
			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
			FALSE,TRUE,FALSE,"","",FALSE,"","",conexion,sql,"",TRUE,8)
		case 9 //Office 2000
			word.ActiveDocument.MailMerge.OpenDataSource(ruta_mdb,0,FALSE, &
			FALSE,TRUE,FALSE,"","",FALSE,"","",conexion,sql) 
		case else //Otros...
			MessageBox(g_titulo,"Su versi$$HEX1$$f300$$ENDHEX$$n de Word no soporta la combinaci$$HEX1$$f300$$ENDHEX$$n de correspondencia")
			word.Quit(0)
			version_ok=false
	end choose
end if 

// Si la version era correcta se ejecuta el MailMerge
if version_ok then
	word.ActiveDocument.MailMerge.Destination = wdSendToNewDocument 
	word.ActiveDocument.MailMerge.Execute	
	
	// La parte de NO previsualizacion no esta activa
	// SIEMPRE previsualiza si no es PDF
	if not(previsualizar) then
		word.ActiveDocument.PrintOut(False)
		
		if pdf then
			nombre_plantilla=mid(ruta_plantilla,lastpos(ruta_plantilla,'\')+1)
			word.ActiveDocument.saveas(g_directorio_temporal+nombre_plantilla)
			//Cerramos la plantilla sin rellenar		
			this.f_word_a_pdf(g_directorio_temporal+nombre_plantilla,ruta)
			if firmar_pdf then f_firmar_pdf(ruta+nombre_pdf+'.pdf')	
			if email then f_enviar_mail()
		end if

		word.Documents.Close(0)	
		word.Quit(0)
	else
	
		if pdf then
			//Si el usuario quiere editar la plantilla no la imprimimos autom$$HEX1$$e100$$ENDHEX$$ticamente
			word.Application.Activate()			
			nombre_plantilla=mid(ruta_plantilla,lastpos(ruta_plantilla,'\')+1)
			word.ActiveDocument.saveas(g_directorio_temporal+nombre_plantilla)
			//Cerramos la plantilla sin rellenar		
			this.f_word_a_pdf(g_directorio_temporal+nombre_plantilla,ruta)
			word.Documents.Close(0)
			word.Quit(0)
			if firmar_pdf then f_firmar_pdf(ruta+nombre_pdf+'.pdf')
			if email then f_enviar_mail()
			
		else
			//Si el usuario quiere editar la plantilla no la imprimimos autom$$HEX1$$e100$$ENDHEX$$ticamente
			word.Visible=true
			word.Application.Activate()			
			word.Documents.Item(2).Close(0)
		end if

	end if
end if



word.DisconnectObject()
destroy word

return 0
end function

on n_csd_plantillas.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_csd_plantillas.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;


inv_Filesrv = create n_cst_filesrvwin32
end event

