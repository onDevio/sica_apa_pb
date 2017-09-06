HA$PBExportHeader$n_csd_impresion_formato.sru
forward
global type n_csd_impresion_formato from nonvisualobject
end type
end forward

global type n_csd_impresion_formato from nonvisualobject
end type
global n_csd_impresion_formato n_csd_impresion_formato

type variables
//General
boolean masivo=false		// Indica si es un proceso masivo (nombre del pdf y direccion destino dinamica)




powerobject dw				//Datawindow/Datastore que se va a imprimir
int avisos=0				//Avisos : Indica si se van a mostrar mensajes con los resultados o errores
								//		0: Modo silencioso : No hay avisos (utilizar en procesos de impresi$$HEX1$$f300$$ENDHEX$$n masivos)
								//		1: Modo con avisos : Se generan avisos del resultado de la operaci$$HEX1$$f300$$ENDHEX$$n
								

//Datos de copias en papel
string  papel ='N'			//Indica si se genera copia en papel  (S=SI,N=No,X=Desactivado y No)
integer copias=2				//N$$HEX2$$ba002000$$ENDHEX$$de originales que se imprimen
integer copias2=0				//N$$HEX2$$ba002000$$ENDHEX$$de copias que se imprimen
string  impresora			//Impresora en caso de que no sea la "por defecto"
string  impresora_intervalo = 'T'	//Intervalo de impresion (Todo, P$$HEX1$$e100$$ENDHEX$$ginas,selecci$$HEX1$$f300$$ENDHEX$$n)
integer impresora_pag_desde = 1  //P$$HEX1$$e100$$ENDHEX$$gina desde para imprimir
integer impresora_pag_hasta 		//P$$HEX1$$e100$$ENDHEX$$gina hasta, para imprimir
boolean impresora_intercalar =false //Intercalar p$$HEX1$$e100$$ENDHEX$$ginas en impresion
string impresora_bandeja	// Indica la bandeja de alimentaci$$HEX1$$f300$$ENDHEX$$n en caso que no sea la "por defecto"

//Datos del pdf
string pdf  ='N'				//Indica si se genera copia en pdf	(S=SI,N=No,X=Desactivado y No)	 
boolean ruta_automatica //Utilizacion de la nueva ruta calculada a partir de las 3 rutas relativas
string nombre				//Nombre SIN extensi$$HEX1$$f300$$ENDHEX$$n que se le da al pdf
string ruta_base			//Ruta raiz
string ruta_relativa		//Ruta espec$$HEX1$$ed00$$ENDHEX$$fica a partir de la ruta raiz
string ruta_relativa1 	// ID_MODULO_GRUPO
string ruta_relativa2	// A$$HEX1$$d100$$ENDHEX$$O
string ruta_relativa3 	// ID_MODULO
string ruta_relativa4 	// carpeta (ej. economicos)
string firmar_pdf = 'N' //Indica si hay que firmar el PDF
boolean pdf_previsualizar =false //Indica si se quiere previsualizar el pdf generado
string pdf_es_original='S'
long ll_printjob=-1
string tipo_doc	//Tipo de Documento (entrada web)
int modo_creacion	= 0		//modo_creacion : Indica el modo en que se crear$$HEX2$$e1002000$$ENDHEX$$el fichero
								//		0: Si el fichero ya existe, se sustituye
								//		1: Si el fichero ya existe, NO se crea
								//		otro: Si el fichero ya existe, dar$$HEX2$$e1002000$$ENDHEX$$la elecci$$HEX1$$f300$$ENDHEX$$n al usuario

string destino	='F'		//F:Documentos de fases
								//C:Documentos de colegiados
								
string referencia,referencia2		//Id. de colegiado o fase seg$$HEX1$$fa00$$ENDHEX$$n corresponda por el par$$HEX1$$e100$$ENDHEX$$metro "destino"
												// La referencia2 puede usarse como un id secundario (id_notificacion o id_reparo)
string is_ruta_registro_docuprinter = "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter"												

// Datos SMS
string moviles
string texto_sms
string sms='N'   //(S=SI,N=No,X=Desactivado y No)

//Datos certificado
string certificado =''  //Ruta del certificado
string password 			// Password del certificado
string nombre_cer			// Nombre del firmante
string razon				
string situacion



//Datos de copias en mail
string email ='N'			//Indica si se env$$HEX1$$ed00$$ENDHEX$$a copia por mail  (S=SI,N=No,X=Desactivado y No)
string direccion_email	//Indica la direci$$HEX1$$f300$$ENDHEX$$n
string cc_email,cco_email
string asunto_email		//Indica el asunto del mail
string nombre_adjunto_email	//Nombre del fichero adjunto
string texto_email		//Texto que ir$$HEX2$$e1002000$$ENDHEX$$en el cuerpo del mail
string visualizar_web='S'//Indica si se crear$$HEX2$$e1002000$$ENDHEX$$entrada en la tabla web
string formato_html='N'	//Indica si el mail va con contenido html
string plantilla					// Plantilla que coger$$HEX2$$e1002000$$ENDHEX$$para el texto de envio y el asunto
string adjuntos[]		
boolean sin_adjuntos=false // Mandar los emails sin adjuntos
boolean masivo_cambiar_nombre=false // Permite Cambiar el nombre de los PDFs generados
boolean masivo_cambiar_asunto=false // Permite Cambiar el asunto de los emails enviados
boolean envio_simple=false
boolean generar_pdf=true


// REGISTRO SALIDA
string n_reg_salida=''   // N$$HEX2$$ba002000$$ENDHEX$$de registro. En caso de que nuevo_reg_salida sea 'N' se le puede pasar un n$$HEX2$$ba002000$$ENDHEX$$manual
string nuevo_reg_salida='S'  // S=Genera un nuevo registro de salida, N=Utiliza el campo n_registro_salida para darle valor al campo
string generar_doc_modulo='S'
string generar_registro='X' // Generar registro de salida	X=NO GENERAR (OPCION OCULTA)
											//											N=NO GENERAR (OPCION MOSTRADA)
											//											S=GENERAR REGISTRO (OPCION MOSTRADA)
string serie	='RS'				// Serie para el registro de salida (Defecto=Registro General de Salida)
string id_receptor			// ID Receptor 
string receptor				// Nombre del receptor
string tipo_receptor='C'		// Tipo receptor
string asunto_registro		// Asunto
string expediente			// Numero registro
string n_expedi			// ID_FASE
boolean cambiar_serie=true // Permitir cambiar serie
string id_doc_modulo
boolean ver_adjuntos=false

private string referencia_web 
private string id_registro
private datastore ds		//datastore que surje de la transformaci$$HEX1$$f300$$ENDHEX$$n del anterior a datastore
private datawindow idw	//datawindow que surje de la transformaci$$HEX1$$f300$$ENDHEX$$n del anterior a datastore
private int retorno		//retorno de los distintos procesos...
private int tipo_estructura=0 //0 : Ninguna
									 //1 : Datawindow
									 //2 : Datastore
private datastore ids_documentos_web
private int i_impresion_pdf,i_impresion_impresora

string duplicado='N' //Para indicar en la factura pdf que no es original

// Configuracion cuenta correo
private string is_servidor_smtp,is_servidor_pop
private string is_direccion,is_nombre,is_login,is_password,is_recordar,is_limite


st_doc_modulo ist_doc_modulo

//martin 
string id_factura
string documento_sellado
string enviar_email_clientes = 'N'
//string tipo_factura
//fin martin



// VARIABLES GLOBALES A DECLARAR
/*
string g_directorio_temporal  // f_impresion (IMPRESION GENERAL)
string g_directorio_certificados  // f_firmar_pdf  (FIRMA DIGITAL)
string g_colegio,g_directorio_documentos_visared  // f_firmar_pdf,f_ruta_documentos  /FIRMA DIGITAL Y OBTENCION DE DIRECTORIOS)
string g_directorio_rtf //f_aplicar_plantilla,f_obtener_estructura_plantillas   (PLANTILLAS)
string g_empresa, g_nombre_empresa, g_direccion_empresa, g_localidad_empresa // f_obtener_parametro_plantilla (PLANTILLAS)

string g_sistema_mailing // f_impresion (ENVIO DE EMAILS)
*/

// Variables relacionadas con el sellado de documentos. 
st_configuracion_sello ist_configuracion_sello
string is_aplica_sellado, is_fichero_log_errores
u_firmador inv_firmador
boolean ib_hay_errores_sellado

end variables
forward prototypes
private subroutine f_error (string codigo)
public function integer f_crear_directorio ()
public function integer f_generar_entrada_web ()
public function integer f_papel ()
public function integer f_mail ()
public function integer f_pdf_alternativa ()
public function integer f_impresion ()
private function integer f_convertir_estructura (powerobject o_dw)
public function integer f_opciones_impresion ()
public function integer f_pdf ()
public subroutine f_firmar_pdf (string fichero_pdf)
public subroutine f_obtener_parametro_plantilla (ref string texto)
public function string f_obtener_estructura_plantilla (string archivo, string seccion)
public subroutine f_aplicar_plantilla ()
public subroutine f_mail_sockets ()
public function integer f_ruta_otras_facturas ()
public function integer f_generar_registro_salida ()
public function integer f_generar_entrada_doc_modulo ()
public subroutine f_sms ()
public subroutine f_mail_gae ()
public subroutine f_mail_sockets_dividido ()
public function integer f_incluir_anexo_registro_salida ()
public function integer f_rellena_email_con_id_factura (string id_fact)
public function string f_ruta_facturas_fases ()
public subroutine wf_rellenar_datos_sellado ()
public subroutine wf_sellado_con_fichero (string fichero_sello, string fichero_pdf)
public subroutine wf_rellenar_sentencia_proteger (ref n_firmador_pdf firmador)
public subroutine wf_sellado_sin_fichero (string fichero_pdf)
public function st_sello wf_rellena_lineas_sello (datastore dw_2, st_sello sello)
public function st_sello wf_rellena_configuracion_sello (datastore as_dw, st_sello sello)
public function string wf_mensaje_error_sellado (integer codigo, string fichero)
public function string f_obtener_referencia_web ()
public function boolean wf_vincular_factura_a_fase ()
end prototypes

private subroutine f_error (string codigo);string texto =''

//Si no hay especificado modo de avisos, por defecto ponemos modo silencioso
if isnull(avisos) then avisos = 0

choose case codigo
	case '+03'	
		texto = 'El mensaje ha sido enviado correctamente'
	case '+04'
		texto = 'Se ha generado el documento ' + nombre +'.pdf en la carpeta ' + ruta_base + ruta_relativa
		if g_usar_idioma = "S" then
			string params[]
			params[1] = nombre
			params[2] = ruta_base + ruta_relativa
			texto = g_idioma.of_getmsg( 'n_csd_impresion.+04', params, texto)
		end if
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
		texto = 'No ha especificado ninguna direcci$$HEX1$$f300$$ENDHEX$$n de correo o el destinatario no tiene ninguna predefinida'
	case '-08' 
		texto = 'No ha podido crear el directorio correctamente'
	case '-09' 
		texto = 'No se ha podido firmar el fichero PDF'	
	case '-10' 
		texto = 'No se ha podido generar la entrada para la web. No existe la referencia.'			
	case '-11'
		texto = 'No se ha especificado ningun nombre de fichero'			
	case '-12'
		texto = 'No se ha podido a$$HEX1$$f100$$ENDHEX$$adir el mensaje a la cola de mensajes.'		
	case '-13'
		texto = 'No se pudo conectar al servidor de correo'
	case '-14'
		texto = 'Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al desconectarse del servidor de correo'		
	case '-1008'
		texto = 'Ocurri$$HEX2$$f3002000$$ENDHEX$$un error durante el proceso de establecimiento de conexi$$HEX1$$f300$$ENDHEX$$n al servidor de correo. Compruebe los par$$HEX1$$e100$$ENDHEX$$metros de conexi$$HEX1$$f300$$ENDHEX$$n'
	case '07' 
		
	case '08' 
		
end choose

if g_usar_idioma = "S" and codigo <> "+04" then
	texto = g_idioma.of_getmsg( "n_csd_impresion."+codigo, texto)
end if


//Si el modo de avisos no es silencioso, mostramos el aviso por ventana
if avisos > 0 then Messagebox(g_titulo,texto)
	
end subroutine

public function integer f_crear_directorio ();//Crea la ruta si no existe..
int posic = 1
string ruta,ruta_parcial
n_cst_filesrvwin32 directorio

retorno = 1
if RightA(ruta_base,1) <>'\' then ruta_base = ruta_base+'\'
if RightA(ruta_relativa,1) <>'\' and not f_es_vacio(ruta_relativa) then ruta_relativa = ruta_relativa+'\'
ruta = ruta_base+ruta_relativa


directorio = create n_cst_filesrvwin32  
posic = PosA(ruta,'\',1)
do while posic>0
	ruta_parcial = MidA(ruta,1,posic - 1)
	retorno = directorio.of_createdirectory(ruta_parcial)
	posic = PosA(ruta,'\',posic+1)
loop

if not directorio.of_directoryexists(ruta) then 
	retorno = -1
else
	retorno = 1
end if
destroy directorio 
return retorno
end function

public function integer f_generar_entrada_web ();//Esta funci$$HEX1$$f300$$ENDHEX$$n inserta el documento pdf en la ruta especificada
//Esta funci$$HEX1$$f300$$ENDHEX$$n s$$HEX1$$f300$$ENDHEX$$lo se ejecutar$$HEX2$$e1002000$$ENDHEX$$cuando est$$HEX2$$e9002000$$ENDHEX$$activa la opci$$HEX1$$f300$$ENDHEX$$n pdf
string ruta_relativa_doc
int fila
//Si la factura no est$$HEX2$$e1002000$$ENDHEX$$asociada a un expediente que no muestre el mensaje de no visible en web
//Luis CGI-98
if(destino = 'TO')then return -1
//fin cambio	

if f_es_vacio(referencia_web) then referencia_web =  f_obtener_referencia_web()

if f_es_vacio(referencia_web) then
	f_error('-10')
	return -1
end if


if f_es_vacio(documento_sellado) then documento_sellado = 'N'

//Insertamos el pdf en la tabla fases_documentos_visared para que se puedan ver desde el sellador..
ids_documentos_web.retrieve(referencia_web)
fila=ids_documentos_web.find("nombre_fichero='" + nombre+".pdf'",1,ids_documentos_web.rowcount())

if fila>0 then
	
	ids_documentos_web.setitem(fila, 'sellado', documento_sellado)
		
	ids_documentos_web.setitem(fila, 'fecha', today())
	ids_documentos_web.setitem(fila, 'tipo_documento',tipo_doc)	
	ids_documentos_web.setitem(fila, 'visualizar_web', 'S')
else
	fila = ids_documentos_web.InsertRow(0)
	ids_documentos_web.setitem(fila, 'id_fichero', f_siguiente_numero('FASES_DOCU_VISARED', 10))
	ids_documentos_web.setitem(fila, 'id_fase', referencia_web)
	ids_documentos_web.setitem(fila, 'nombre_fichero',nombre+'.pdf')
	ids_documentos_web.setitem(fila, 'ruta_fichero',ruta_relativa)
	ids_documentos_web.setitem(fila, 'tipo_documento',tipo_doc)		
	ids_documentos_web.setitem(fila, 'fecha', today())
	ids_documentos_web.setitem(fila, 'visualizar_web', 'S')	
	ids_documentos_web.setitem(fila, 'sellado', documento_sellado)
	
	if (f_var_global_sn("g_visualizar_facturas_sin_firma_en_web") = 'N') then 
		ids_documentos_web.setitem(fila, 'visualizar_web', documento_sellado)
	end if
	
	ids_documentos_web.update()
end if

if not f_es_vacio(id_factura) then ids_documentos_web.setitem(fila, 'id_factura', id_factura)

return 1
end function

public function integer f_papel ();string impresora2
long i

//Imprimimos en papel
if (papel = 'S') then
	if copias < 0 then copias = 1
	
	//Las opciones de intercalar solo sirve para datawindows..
	if TypeOf(dw) = Datawindow! then
		//ds.object.datawindow.print.collate = impresora_intercalar
	end if

	if impresora_intervalo = 'P' then
		if tipo_estructura = 1 then idw.object.datawindow.print.page.range = string(impresora_pag_desde) + "-" + string(impresora_pag_hasta)
		if tipo_estructura = 2 then ds.object.datawindow.print.page.range = string(impresora_pag_desde) + "-" + string(impresora_pag_hasta)
	end if
	
	if not f_es_vacio(impresora) then
		// guardamos impresora predeterminada
		impresora2 =printgetprinter()
		// la cambiamos a la impresora por defecto
		PrintSetPrinter(impresora)
	end if
	
	// Usar printopen en vez de directamente dw.print() soluciona algunos problemas
	
	//Creamos el nombre si as$$HEX2$$ed002000$$ENDHEX$$procede
	


	for i = 1 to copias
		if tipo_estructura = 1 then 
			if idw.describe("n_reg_salida.name")= "n_reg_salida" then	idw.SetItem(1,'n_reg_salida',n_reg_salida)
			if idw.describe("reg_salida.name")= "reg_salida" then idw.SetItem(1,'reg_salida',n_reg_salida)				
			if idw.describe("copia.name")= "copia" then	idw.object.copia.text = 'ORIGINAL'
			//Introducido para adaptar la factura de la rioja. Alexis 1/9/2009
			if idw.describe("duplicado.name")= "duplicado" then idw.SetItem(1,'duplicado','N')
			if ll_printjob=-1 then
				idw.Modify("DataWindow.Print.Paper.Source = '"+impresora_bandeja+"'")
				idw.print()	
				
			else
				PrintDataWindow(ll_printjob,idw)
			end if
		end if
		if tipo_estructura = 2 then 
			if ds.describe("n_reg_salida.name")= "n_reg_salida" then	ds.SetItem(1,'n_reg_salida',n_reg_salida)			
			if ds.describe("reg_salida.name")= "reg_salida" then ds.SetItem(1,'reg_salida',n_reg_salida)				
			if ds.describe("copia.name")= "copia" then 	ds.object.copia.text = 'ORIGINAL'
			//Introducido para adaptar la factura de la rioja. Alexis 1/9/2009
			if ds.describe("duplicado.name")= "duplicado" then ds.SetItem(1,'duplicado','N')
			if ll_printjob=-1 then
				ds.Modify("DataWindow.Print.Paper.Source = '"+impresora_bandeja+"'")
				ds.print()	
			else
				PrintDataWindow(ll_printjob,ds)
			end if
		end if
	next
	
	for i = 1 to copias2
		if tipo_estructura = 1 then 
			if idw.describe("n_reg_salida.name")= "n_reg_salida" then	idw.SetItem(1,'n_reg_salida',n_reg_salida)
			if idw.describe("reg_salida.name")= "reg_salida" then idw.SetItem(1,'reg_salida',n_reg_salida)	
			if idw.describe("copia.name")= "copia" then	idw.object.copia.text = 'COPIA'
			//Introducido para adaptar la factura de la rioja. Alexis 1/9/2009
			if idw.describe("duplicado.name")= "duplicado" then idw.SetItem(1,'duplicado','S')
			if ll_printjob=-1 then
				idw.Modify("DataWindow.Print.Paper.Source = '"+impresora_bandeja+"'")
				idw.print()	
			else
				PrintDataWindow(ll_printjob,idw)
			end if
		end if
		if tipo_estructura = 2 then 
			if ds.describe("n_reg_salida.name")= "n_reg_salida" then	ds.SetItem(1,'n_reg_salida',n_reg_salida)				
			if ds.describe("reg_salida.name")= "reg_salida" then ds.SetItem(1,'reg_salida',n_reg_salida)				
			if ds.describe("copia.name")= "copia" then ds.object.copia.text = 'COPIA'
			//Introducido para adaptar la factura de la rioja. Alexis 1/9/2009
			if ds.describe("duplicado.name")= "duplicado" then ds.SetItem(1,'duplicado','S')
			if ll_printjob=-1 then
				ds.Modify("DataWindow.Print.Paper.Source = '"+impresora_bandeja+"'")
				ds.print()	
			else
				PrintDataWindow(ll_printjob,ds)
			end if
		end if
	next	
	
	// restauramos la impresora predeterminada
	if not f_es_vacio(impresora) then PrintSetPrinter(impresora2)
end if

return 1

end function

public function integer f_mail ();
//Retorno
// 	1	: Env$$HEX1$$ed00$$ENDHEX$$o CORRECTO
// 	-1	: Fallo en el establecimiento de la sesi$$HEX1$$f300$$ENDHEX$$n de correo
//	-2 : Fallo en el env$$HEX1$$ed00$$ENDHEX$$o del mensaje

string ls_Filter, ls_copia
mailsession lms_Session
mailmessage lm_Message
mailrecipient lm_Recipient
mailFileDescription lmf_File
mailreturncode lmc_Return
string ls_UserName,texto
ulong ll_Length
int pos,j=1, li_posB, li_dif_pos
string email_relativo
int i,z

if f_es_vacio(direccion_email) then
	f_error('-07')
	return -1
end if

if Not(f_es_vacio(plantilla)) then f_aplicar_plantilla()

ls_copia=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","direccion_copia", "")

//De momento si no existe el fichero, no se env$$HEX1$$ed00$$ENDHEX$$a el email...
//if not fileexists(ruta_base + ruta_relativa + nombre+'.pdf') then return -1
//Si queremos adjuntar archivos...
if not(sin_adjuntos) then
	i=1
	if not (f_es_vacio(nombre) or f_es_vacio(ruta_base + ruta_relativa)) and fileexists(ruta_base + ruta_relativa + nombre+'.pdf') then
		lmf_File.FileType = mailAttach!
		lmf_File.FileName = nombre+'.pdf' //ruta_base + ruta_relativa + nombre+'.pdf'
		lmf_file.PathName = ruta_base + ruta_relativa + nombre+'.pdf'
		lmf_file.Position = -1
		lm_Message.Attachmentfile[i] = lmf_File
		i++
	elseif not (f_es_vacio(nombre_adjunto_email) or f_es_vacio(ruta_base + ruta_relativa)) and fileexists(ruta_base + ruta_relativa + nombre_adjunto_email) then
		lmf_File.FileType = mailAttach!
		lmf_File.FileName = nombre_adjunto_email
		lmf_file.PathName = ruta_base + ruta_relativa + nombre_adjunto_email
		lmf_file.Position = -1
		lm_Message.Attachmentfile[i] = lmf_File
		i++
	end if
	for z=1 to UpperBound(adjuntos)
		lmf_File.FileType = mailAttach!
		lmf_File.FileName = mid(adjuntos[z],lastpos(adjuntos[z],'\')+1)
		lmf_file.PathName = adjuntos[z]
		lmf_file.Position = -1
		lm_Message.Attachmentfile[i] = lmf_File		
		
		i++
	next
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
pos = PosA(direccion_email,';',1)
li_posB = PosA(direccion_email,',',1)
do while (pos > 0 or li_posB > 0)
	li_dif_pos = pos - li_posB
	if ((li_posB > 1 and li_dif_pos > 0) or (pos = 0 and li_dif_pos < 0)) then
		email_relativo = MidA(direccion_email,1,li_posB - 1)
		direccion_email = trim(MidA(direccion_email,li_posB+1,9999))
		//li_posB = PosA(direccion_email,',',li_posB+1)
		li_posB = PosA(direccion_email,',',1)
		pos = PosA(direccion_email,';',1)
	else
		email_relativo = MidA(direccion_email,1,pos - 1)
		direccion_email = trim(MidA(direccion_email,pos+1,9999))
		//pos = PosA(direccion_email,';',pos+1)
		li_posB = PosA(direccion_email,',',1)
		pos = PosA(direccion_email,';',1)
	end  if	
		
	lm_Recipient.Address ='SMTP:'+email_relativo  //destinatario   
	lm_Recipient.Name = email_relativo  //"Notificaciones de Reparos"
	lm_Message.Recipient[j] = lm_Recipient
	j++
loop

if not f_es_vacio(direccion_email) then
	lm_Recipient.Address ='SMTP:'+direccion_email  //destinatario   
	lm_Recipient.Name = direccion_email  //"Notificaciones de Reparos"
	lm_Message.Recipient[j] = lm_Recipient
	j++
end if

lm_Recipient.RecipientType = mailCC!
pos = PosA(cc_email,';',1)
li_posB = PosA(cc_email,',',1)
do while (pos > 0 or li_posB > 0)
	li_dif_pos = pos - li_posB
	if ((li_posB > 1 and li_dif_pos > 0) or (pos = 0 and li_dif_pos < 0)) then
		email_relativo = MidA(cc_email,1,li_posB - 1)
		cc_email = trim(MidA(cc_email,li_posB+1,9999))
		li_posB = PosA(cc_email,',',1)
		pos = PosA(cc_email,';',1)
	else
		email_relativo = MidA(cc_email,1,pos - 1)
		cc_email = trim(MidA(direccion_email,pos+1,9999))
		pos = PosA(cc_email,';',1)
		li_posB = PosA(cc_email,',',1)
	end if
	
//	email_relativo = MidA(cc_email,1,pos - 1)
//	cc_email = trim(MidA(direccion_email,pos+1,9999))
//	pos = PosA(cc_email,';',pos+1)
	lm_Recipient.Address ='SMTP:'+email_relativo  //destinatario   
	lm_Recipient.Name = email_relativo  //"Notificaciones de Reparos"
	lm_Message.Recipient[j] = lm_Recipient
	j++
loop

if not f_es_vacio(cc_email) then
	lm_Recipient.Address ='SMTP:'+cc_email  //destinatario   
	lm_Recipient.Name = cc_email  //"Notificaciones de Reparos"
	lm_Message.Recipient[j] = lm_Recipient
	j++	
end if

lm_Recipient.RecipientType = mailBCC!
pos = PosA(cco_email,';',1)
li_posB = PosA(cco_email,',',1)
do while (pos > 0 or li_posB > 0)
	li_dif_pos = pos - li_posB
	if ((li_posB > 1 and li_dif_pos > 0) or (pos = 0 and li_dif_pos < 0)) then
		email_relativo = MidA(cco_email,1,li_posB - 1)
		cco_email = trim(MidA(cco_email,li_posB+1,9999))
		//li_posB = PosA(cco_email,',',li_posB+1)
		li_posB = PosA(cco_email,',',1)
		pos = PosA(cco_email,';',1)
	else 	
		email_relativo = MidA(cco_email,1,pos - 1)
		cco_email = trim(MidA(cco_email,pos+1,9999))
		//pos = PosA(cco_email,';',pos+1)
		li_posB = PosA(cco_email,',',1)
		pos = PosA(cco_email,';',1)
	end if 	
//	email_relativo = MidA(cco_email,1,pos - 1)
//	cco_email = trim(MidA(cco_email,pos+1,9999))
//	pos = PosA(cco_email,';',pos+1)
	lm_Recipient.Address ='SMTP:'+email_relativo  //destinatario   
	lm_Recipient.Name = email_relativo  //"Notificaciones de Reparos"
	lm_Message.Recipient[j] = lm_Recipient
	j++
loop

if not f_es_vacio(cco_email) then
	lm_Recipient.Address ='SMTP:'+cco_email  //destinatario   
	lm_Recipient.Name = cco_email  //"Notificaciones de Reparos"
	lm_Message.Recipient[j] = lm_Recipient
	j++
end if

if not f_es_vacio(ls_copia ) then
	lm_Recipient.Address ='SMTP:'+trim(ls_copia)  //destinatario   
	lm_Recipient.Name = trim(ls_copia)  //"Notificaciones de Reparos"
	lm_Message.Recipient[j] = lm_Recipient
end if


// LUIS 20/9/2005
// Guardamos el directorio de trabajo porque al realizar el mailLogon puede cambiar por el directorio del programa de correo
string directorio
directorio = gnv_fichero.of_getcurrentdirectory()

lmc_Return = lms_Session.mailLogon()

// Comprobamos que la sesi$$HEX1$$f300$$ENDHEX$$n ha sido iniciada con $$HEX1$$e900$$ENDHEX$$xito
if lmc_Return <> mailReturnSuccess! then
	f_error('-02')
	retorno = -2
	return retorno
end if

lmc_Return = lms_Session.mailSend(lm_Message)

// Comprobamos que el mensaje ha sido enviado con $$HEX1$$e900$$ENDHEX$$xito
if lmc_return <> MailReturnSuccess! then
	f_error('-03')
	retorno = -1
else
	f_error('+03')
	retorno = 1
end if

lmc_Return = lms_Session.mailLogoff()
destroy lms_Session

// LUIS 20/9/2005
// Restauramos el directorio de trabajo, como corresponde estar para que todas las imagenes sigan funcionando
gnv_fichero.of_changedirectory(directorio)


return retorno


end function

public function integer f_pdf_alternativa ();//Imprime un datawindow a pdf
//Par$$HEX1$$e100$$ENDHEX$$metros:
	//	dw: datawindow que se va a imprimir
	//	ruta_pdf: ruta_pdf donde se crear$$HEX2$$e1002000$$ENDHEX$$el nombre
	// nombre: nombre del nombre (SIN EXTENSI$$HEX1$$d300$$ENDHEX$$N)
	// modo_creacion : Indica el modo en que se crear$$HEX2$$e1002000$$ENDHEX$$el nombre
	//		0: Si el nombre ya existe, se sustituye
	//		1: Si el nombre ya existe, NO se crea
	//		otro: Si el nombre ya existe, dar$$HEX2$$e1002000$$ENDHEX$$la elecci$$HEX1$$f300$$ENDHEX$$n al usuario
	// avisos : Indica si se van a mostrar mensajes con los resultados o errores
	//		0: Modo silencioso : No hay avisos (utilizar en procesos de impresi$$HEX1$$f300$$ENDHEX$$n masivos)
	//		1: Modo con avisos : Se generan avisos del resultado de la operaci$$HEX1$$f300$$ENDHEX$$n
//Retorno	
//		 1 : Generaci$$HEX1$$f300$$ENDHEX$$n CORRECTA
//		-1 : No se ha generado el nombre, puesto que ya existe
// 	-2	: No est$$HEX2$$e1002000$$ENDHEX$$instalado el m$$HEX1$$f300$$ENDHEX$$dulo de conversi$$HEX1$$f300$$ENDHEX$$n a PDF (Docuprinter)


string ruta_docuprinter='', ruta_total
int ret=0, resp
boolean existe_nombre, creacion_nombre = true
retorno=1

ruta_total = ruta_base + ruta_relativa
if f_es_vacio(ruta_total)  then
	f_error('-06')
	return -1
end if

if f_crear_directorio()<0 then 
	f_error('-06')
	return -1
end if

//Obtenemos la ruta donde est$$HEX2$$e1002000$$ENDHEX$$instalada la impresora Docuprinter
resp = RegistryGet( is_ruta_registro_docuprinter,"Path", RegString!, ruta_docuprinter)
if resp<0 or f_es_vacio(ruta_docuprinter) then
	f_error('-04b')
	return retorno
end if

// Establecer par$$HEX1$$e100$$ENDHEX$$metros Neevia
ret += RegistrySet(is_ruta_registro_docuprinter,"UseMask", ReguLong!, 1) 
ret += RegistrySet(is_ruta_registro_docuprinter,"FileMask", RegString!, nombre + '.PDF')
ret += RegistrySet(is_ruta_registro_docuprinter,"PDFOutputPath", RegString!, ruta_total)
ret += RegistrySet(is_ruta_registro_docuprinter,"OutputFile", RegString!, nombre + '.PDF')
ret += RegistrySet(is_ruta_registro_docuprinter,"OutputType", ReguLong!, 1)
if ret <> 5 then
	messagebox(g_titulo, 'No tiene instalado el m$$HEX1$$f300$$ENDHEX$$dulo de conversi$$HEX1$$f300$$ENDHEX$$n a PDF')
end if

existe_nombre = fileexists(ruta_base + ruta_relativa + nombre + '.PDF')

//Si el nombre existe.. actuamos en funci$$HEX1$$f300$$ENDHEX$$n del par$$HEX1$$e100$$ENDHEX$$metro modo de creaci$$HEX1$$f300$$ENDHEX$$n
if existe_nombre then
	choose case modo_creacion
		case 0   //Lo borramos.. para generarlo posteriormente
			FileDelete(ruta_base + ruta_relativa + nombre + '.PDF')  
		case 1	  //No generamos ning$$HEX1$$fa00$$ENDHEX$$n nombre
			creacion_nombre = false
		case else  //El usuario decide si sustituye el nombre existente
			resp = messagebox(g_titulo,"El nombre ya existe, $$HEX1$$bf00$$ENDHEX$$desea continuar?",Question!,YesNo!)
			if(resp = 1) then
				FileDelete(ruta_base + ruta_relativa + nombre + '.PDF')
			else
				creacion_nombre = false
			end if
	end choose
end if

printsetup()

string impr_act
if tipo_estructura = 1 then impr_act = idw.Describe("DataWindow.Printer")
if tipo_estructura = 2 then impr_act = ds.Describe("DataWindow.Printer")

if lower(LeftA(impr_act,11)) <> 'docuprinter' then
	messagebox(g_titulo, "Debe seleccionar la impresora docuprinter")
	return -1
end if

//Creamos el nombre si as$$HEX2$$ed002000$$ENDHEX$$procede
if creacion_nombre then
	if tipo_estructura = 1 then idw.print()
	if tipo_estructura = 2 then ds.print()
end if

time t1, t2
long secs=0

t1 = now()
secondsafter(t2, t1)

//	Esperamos hasta que se cree el archivo PDF (*.pdf)
setpointer(hourglass!)
	do while not fileexists(ruta_total+nombre+'.pdf') and secs < 15
		t2 = now()
		secs = secondsafter(t1, t2)
	loop
//	fichero.of_filerename(ruta_docuprinter+'pdf.pdf',ruta_total+nombre+'.pdf')
setpointer(arrow!)
if secs >= 15 then
	f_error('-04')
else
	f_error('+04')
	filedelete(ruta_docuprinter +'pdf.ps')
	
	if pdf_previsualizar then f_abrir_fichero(ruta_total,nombre+'.pdf', "")
end if

//devolvemos el valor predeterminado del registro...
RegistrySet(is_ruta_registro_docuprinter,"UseMask", ReguLong!, 0) 
RegistrySet(is_ruta_registro_docuprinter,"FileMask", RegString!, '')
RegistrySet(is_ruta_registro_docuprinter,"PDFOutputPath", RegString!,'')
RegistrySet(is_ruta_registro_docuprinter,"OutputFile", RegString!, '')
RegistrySet(is_ruta_registro_docuprinter,"OutputType", ReguLong!,0)

printsetup()

return retorno

end function

public function integer f_impresion ();//Esta funci$$HEX1$$f300$$ENDHEX$$n realiza el proceso de impresi$$HEX1$$f300$$ENDHEX$$n completo en funci$$HEX1$$f300$$ENDHEX$$n de los par$$HEX1$$e100$$ENDHEX$$metros
//del objeto
string ruta_base_anterior,ruta_relativa_anterior
st_reg_es_series_rutas st_rutas

//Convertimos a datastore cualquier formato de entrada (datawindow/datawindowchild/datastore)
if IsValid(dw) then f_convertir_estructura(dw) 
if retorno = -1 then return -1

//Nos cercioramos de que las rutas acaben en "\"
if f_es_vacio(ruta_base) then 
	ruta_base=''
else
	if RightA(trim(ruta_base),1)<>'\' then ruta_base = ruta_base+'\'
end if

if f_es_vacio(ruta_relativa) then 
	ruta_relativa =''
else
	if RightA(trim(ruta_relativa),1)<>'\' then ruta_relativa = ruta_relativa+'\'
end if

//Si son impresiones de fases, las rutas de los documentos ser$$HEX1$$e100$$ENDHEX$$n computadas...
choose case destino
	case 'T', 'F'
		f_ruta_facturas_fases()	
	case 'TO'
		f_ruta_otras_facturas()
	case 'C'
		if wf_vincular_factura_a_fase() then 
			f_ruta_facturas_fases()	
		else
			f_ruta_otras_facturas()
		end if	
			
end choose

if ruta_automatica then
		st_rutas.serie=serie	
		st_rutas.ruta_relativa1=ruta_relativa1
		st_rutas.ruta_relativa2=ruta_relativa2
		st_rutas.ruta_relativa3=ruta_relativa3
		st_rutas.ruta_relativa4=ruta_relativa4		
		ruta_base=f_reg_es_obtener_ruta_serie(st_rutas,0)
		ruta_relativa=f_reg_es_obtener_ruta_serie(st_rutas,2)
end if

if (pdf='S' or email='S' or papel='S' or sms='S') and generar_registro='S' then f_generar_registro_salida()		
		
//Imprimimos en papel, si la configuraci$$HEX1$$f300$$ENDHEX$$n lo requiere
gnv_fichero.of_changedirectory(g_dir_aplicacion)
if papel='S' then f_papel()

//Imprimimos en pdf, si la configuraci$$HEX1$$f300$$ENDHEX$$n lo requiere, y lo dejamos accesible en web
//si tambi$$HEX1$$e900$$ENDHEX$$n se requiere
gnv_fichero.of_changedirectory(g_dir_aplicacion)
if pdf='S' then
	//if g_colegio = 'COAATGUI' then
	//	retorno = f_pdf_alternativa()
	//else
		retorno = f_pdf()
	//end if
	if visualizar_web ='S' then f_generar_entrada_web()
	if generar_doc_modulo='S' then f_generar_entrada_doc_modulo()
	f_incluir_anexo_registro_salida()
	if retorno <0 then return -1
end if

//Enviamos en mail, si la configuraci$$HEX1$$f300$$ENDHEX$$n lo requiere
gnv_fichero.of_changedirectory(g_dir_aplicacion)
if email='S' or (enviar_email_clientes ='S' and (f_obtener_codigo_tipo_factura(id_factura) = g_colegiado_cliente or f_obtener_codigo_tipo_factura(id_factura) = g_colegio_cliente) and not (f_es_vacio(direccion_email))) then 

	if f_es_vacio(texto_email) and not (f_es_vacio(asunto_email))	then 
		texto_email = asunto_email
	end if	
	
		
	if pdf='S' or not(generar_pdf) then //Si pdf='S' el pdf ya est$$HEX2$$e1002000$$ENDHEX$$generado, por tanto solo enviamos
		if g_sistema_mailing='O' then
			f_mail()
		elseif g_sistema_mailing='G' then
			f_mail_gae()
		else
			f_mail_sockets()
		end if
	else
		avisos = 0 
		//El pdf no est$$HEX2$$e1002000$$ENDHEX$$generado, lo generamos en el directorio temporal y lo enviamos
		ruta_base_anterior = ruta_base 
		ruta_relativa_anterior = ruta_relativa
		ruta_base = g_directorio_temporal
		ruta_relativa =''
		//if g_colegio = 'COAATGUI' then
		//	if f_pdf_alternativa()<0 then return -1
		//else
		// if f_pdf()<0 then return -1
		//end if
	
		// SI NO TIENE ADJUNTOS NO GENERAMOS EL PDF
		if not(f_es_vacio(nombre) or sin_adjuntos) then
			if f_pdf()<0 then return -1
		end if		
		
		if g_sistema_mailing='O' then
			f_mail()
		elseif g_sistema_mailing='G' then
			f_mail_gae()			
		else
			f_mail_sockets()
		end if
		filedelete(ruta_base + ruta_relativa +nombre+'.pdf')
		ruta_base = ruta_base_anterior  //Devolvemos a ruta su valor inicial
		ruta_relativa = ruta_relativa_anterior
	end if
end if

if sms='S' then f_sms()




	
gnv_fichero.of_changedirectory(g_dir_aplicacion)
return 1
end function

private function integer f_convertir_estructura (powerobject o_dw);/* Siendo o_dw un objecto del tipo DataWindow, DataStore,
DataWindowChild (o heredado de los mismos) devuleve un datastore
que contiene los mismos datos. La relaci$$HEX1$$f300$$ENDHEX$$n entre o_dw y el
datastore devuelto se establece mediante sharedata por lo que
cualquier cambio se haga al datastore devuleto tambi$$HEX1$$e900$$ENDHEX$$n afecta a
o_dw.
Esta funci$$HEX1$$f300$$ENDHEX$$n es $$HEX1$$fa00$$ENDHEX$$til para hacer funciones que tengan argumentos
que puedan ser indistintamente un datawindow o un datastore. */
retorno=1

If IsValid(o_dw) then
	IF IsNull(o_dw) THEN
		SetNull(ds)
		f_error('-01')
		RETURN -1
	END IF   
end if


ds = create n_ds

CHOOSE CASE TypeOf( o_dw )
   CASE DataWindow!
		idw = o_dw
  		tipo_estructura = 1
	CASE DataStore! // No devolvemos o_dw directamente porque no tiene porque ser del tipo n_ds
      ds = o_dw
		tipo_estructura = 2
	CASE ELSE
		tipo_estructura = 0
		f_error('-01')
		retorno = -1
END CHOOSE

return retorno
end function

public function integer f_opciones_impresion ();//Muestra la ventana de opciones,para que el usuario eliga
st_csd_seleccion_formato_impresion opciones

opciones.ast_configuracion_sello.dw_certificados = create datastore
opciones.ast_configuracion_sello.dw_certificados.dataobject = 'd_sellador_certificados'
opciones.ast_configuracion_sello.dw_configuracion_sello = create datastore
opciones.ast_configuracion_sello.dw_configuracion_sello.dataobject = 'd_configuracion_sello'
opciones.ast_configuracion_sello.dw_datos_firma = create datastore
opciones.ast_configuracion_sello.dw_datos_firma.dataobject = 'd_datos_firmador'
opciones.ast_configuracion_sello.dw_opciones_sello = create datastore
opciones.ast_configuracion_sello.dw_opciones_sello.dataobject = 'd_textos_sellos'
opciones.ast_configuracion_sello.dw_pos_sellos = create datastore
opciones.ast_configuracion_sello.dw_pos_sellos.dataobject = 'd_posiciones_sellos'


integer retorn = -1

if IsValid(dw) then
	f_convertir_estructura(dw) 
	if tipo_estructura = 1 then
		impresora_pag_hasta =  long ( idw.describe("evaluate('pagecount()',1)"))
	else
		impresora_pag_hasta =  long ( ds.describe("evaluate('pagecount()',1)")) 
	end if
end if

opciones.envio_simple = envio_simple
opciones.sin_adjuntos = sin_adjuntos
opciones.masivo_cambiar_nombre = masivo_cambiar_nombre
opciones.masivo_cambiar_asunto = masivo_cambiar_asunto
opciones.masivo = masivo
opciones.nombre = nombre
opciones.pdf = pdf
opciones.papel = papel
opciones.copias = copias
opciones.copias2 = copias2
opciones.impresora = impresora
opciones.email = email
opciones.direccion_email = direccion_email
opciones.cc_email = cc_email
opciones.cco_email = cco_email
opciones.asunto_email = asunto_email
opciones.plantilla	= plantilla
opciones.nombre_adjunto_email = nombre_adjunto_email
opciones.texto_email = texto_email
opciones.visualizar_web = visualizar_web
opciones.impresora_intervalo = impresora_intervalo
opciones.impresora_pagina_desde = impresora_pag_desde
opciones.impresora_pagina_hasta = impresora_pag_hasta
opciones.impresora_intercalar = impresora_intercalar
opciones.pdf_previsualizar = pdf_previsualizar
opciones.destino	= destino
opciones.duplicado	= duplicado
opciones.html	= formato_html
opciones.generar_registro = generar_registro
opciones.serie = serie
opciones.ruta_automatica = ruta_automatica
opciones.texto_sms = texto_sms
opciones.moviles = moviles
opciones.sms = sms
opciones.n_registro_salida = n_reg_salida
opciones.nuevo_reg_salida = nuevo_reg_salida
opciones.ver_adjuntos = ver_adjuntos

//select tipo_factura into :tipo_factura from csi_facturas_emitidas where id_factura = :id_factura;

//Si es una fase, formateamos las rutas de directorios
choose case destino
	case 'T'
		f_ruta_facturas_fases()	
	case 'TO'
		f_ruta_otras_facturas()				
end choose
opciones.ruta_base = ruta_base
opciones.ruta_relativa = ruta_relativa
opciones.ruta_relativa1 = ruta_relativa1
opciones.ruta_relativa2 = ruta_relativa2
opciones.ruta_relativa3 = ruta_relativa3
opciones.ruta_relativa4 = ruta_relativa4
opciones.cambiar_serie = cambiar_serie
opciones.enviar_email_clientes = enviar_email_clientes

g_formato_impresion = opciones

openwithparm(w_csd_impresion_formatos1,opciones)

if isvalid(message.powerobjectparm) then
	opciones	= message.powerobjectparm 
	pdf 					= opciones.pdf
	papel 				= opciones.papel
	copias 				= opciones.copias
	copias2 				= opciones.copias2	
	impresora 			= opciones.impresora 
	email 				= opciones.email

	IF NOT(masivo) THEN
		nombre 			= opciones.nombre
		ruta_base 			= opciones.ruta_base
		ruta_relativa		= opciones.ruta_relativa
		direccion_email 	= opciones.direccion_email
		asunto_email 	= opciones.asunto_email
		plantilla 				= opciones.plantilla	
		nombre_adjunto_email = opciones.nombre_adjunto_email
		
	END IF
	
	texto_email 		= opciones.texto_email
	cc_email 	= opciones.cc_email
	cco_email 	= opciones.cco_email	
	visualizar_web 	= opciones.visualizar_web
	sin_adjuntos		= opciones.sin_adjuntos	
	impresora_intervalo = opciones.impresora_intervalo 
	impresora_pag_desde = opciones.impresora_pagina_desde
	impresora_pag_hasta = opciones.impresora_pagina_hasta
	impresora_intercalar = opciones.impresora_intercalar
	pdf_previsualizar = opciones.pdf_previsualizar
	destino 				= opciones.destino
	duplicado			= opciones.duplicado
	firmar_pdf 			= opciones.firmar_pdf
	certificado			= opciones.certificado
	password			= opciones.password
	nombre_cer		= opciones.nombre_cer
	razon					= opciones.razon
	situacion			= opciones.situacion
	formato_html		= opciones.html	
	generar_registro = opciones.generar_registro
	serie					= opciones.serie
	texto_sms			= opciones.texto_sms
	moviles				= opciones.moviles
	sms					= opciones.sms
	n_reg_salida = opciones.n_registro_salida
	nuevo_reg_salida  = opciones.nuevo_reg_salida
	adjuntos				= opciones.adjuntos
	enviar_email_clientes = opciones.enviar_email_clientes
	
	ist_configuracion_sello = opciones.ast_configuracion_sello
	is_aplica_sellado = opciones.aplica_sellado
	
//	filenumber = FileOpen( g_directorio_temporal + 'sello.ini',LineMode!,Write!,LockWrite!,Append!)
//	Fileclose(filenumber)
//
//	if (is_aplica_sellado = 'S' and not isnull(opciones.ast_configuracion_sello)) then
//		wf_rellenar_datos_sellado()
//	end if 
	
	retorn = 1
	
	
end if
return retorn
end function

public function integer f_pdf ();//Imprime un datawindow a pdf
//Par$$HEX1$$e100$$ENDHEX$$metros:
	//	dw: datawindow que se va a imprimir
	//	ruta_pdf: ruta_pdf donde se crear$$HEX2$$e1002000$$ENDHEX$$el nombre
	// nombre: nombre del nombre (SIN EXTENSI$$HEX1$$d300$$ENDHEX$$N)
	// modo_creacion : Indica el modo en que se crear$$HEX2$$e1002000$$ENDHEX$$el nombre
	//		0: Si el nombre ya existe, se sustituye
	//		1: Si el nombre ya existe, NO se crea
	//		otro: Si el nombre ya existe, dar$$HEX2$$e1002000$$ENDHEX$$la elecci$$HEX1$$f300$$ENDHEX$$n al usuario
	// avisos : Indica si se van a mostrar mensajes con los resultados o errores
	//		0: Modo silencioso : No hay avisos (utilizar en procesos de impresi$$HEX1$$f300$$ENDHEX$$n masivos)
	//		1: Modo con avisos : Se generan avisos del resultado de la operaci$$HEX1$$f300$$ENDHEX$$n
//Retorno	
	//		 1 : Generaci$$HEX1$$f300$$ENDHEX$$n CORRECTA
	//		-1 : No se ha generado el nombre, puesto que ya existe
	// 		-2	: No est$$HEX2$$e1002000$$ENDHEX$$instalado el m$$HEX1$$f300$$ENDHEX$$dulo de conversi$$HEX1$$f300$$ENDHEX$$n a PDF (Docuprinter)

// 27/02/2008: Modificada David, para que el cambio de impresora funcione para la version de power 10.5 (inspirada en sica arq)

boolean existe_nombre, creacion_nombre=true
string ruta_total, ls_impresora_defecto, version, fichero
long resp, rtn
n_cst_string cadena

documento_sellado = 'N'

retorno=1

if f_es_vacio(nombre)  then
	f_error('-11')
	return -1
end if

ruta_total = ruta_base + ruta_relativa
if f_es_vacio(ruta_total)  then
	f_error('-06')
	return -1
end if

if f_crear_directorio()<0 then 
	f_error('-06')
	return -1
end if



nombre=cadena.of_globalreplace(nombre,'\','')
nombre=cadena.of_globalreplace(nombre,'/','')

fichero = ruta_base + ruta_relativa + nombre + '.PDF'

existe_nombre = fileexists(fichero)

//Si el nombre existe.. actuamos en funci$$HEX1$$f300$$ENDHEX$$n del par$$HEX1$$e100$$ENDHEX$$metro modo de creaci$$HEX1$$f300$$ENDHEX$$n
if existe_nombre then
	choose case modo_creacion
		case 0   //Lo borramos.. para generarlo posteriormente
			FileDelete(fichero)  
			if  not f_es_vacio(id_factura) then f_actualizar_campo_firmado (id_factura, 'N')
		case 1	  //No generamos ning$$HEX1$$fa00$$ENDHEX$$n nombre
			creacion_nombre = false
		case else  //El usuario decide si sustituye el nombre existente
			resp = messagebox(g_titulo,"El nombre ya existe, $$HEX1$$bf00$$ENDHEX$$desea continuar?",Question!,YesNo!)
			if(resp = 1) then
				FileDelete(fichero)
				if not f_es_vacio(id_factura) then f_actualizar_campo_firmado (id_factura, 'N')
			else
				creacion_nombre = false
			end if
	end choose
end if

//Creamos el nombre si as$$HEX2$$ed002000$$ENDHEX$$procede

if tipo_estructura = 1 then
	if idw.describe("n_reg_salida.name")= "n_reg_salida" then	idw.SetItem(1,'n_reg_salida',n_reg_salida)	
	if idw.describe("reg_salida.name")= "reg_salida" then idw.SetItem(1,'reg_salida',n_reg_salida)	
	if idw.describe("copia.name")= "copia"  then 
		if duplicado = 'N'  then
			idw.object.copia.text = 'COPIA'
		else
			idw.object.copia.text = 'ORIGINAL'
		end if
		//idw.print()
	else
		//idw.print()
	end if
end if

if tipo_estructura = 2  then
	if ds.describe("n_reg_salida.name")= "n_reg_salida" then	ds.SetItem(1,'n_reg_salida',n_reg_salida)
	if ds.describe("reg_salida.name")= "reg_salida" then ds.SetItem(1,'reg_salida',n_reg_salida)	
	if ds.describe("copia.name")= "copia"  then 
		if duplicado = 'N'  then
			ds.object.copia.text = 'COPIA'
		else
			ds.object.copia.text = 'ORIGINAL'
		end if
		//ds.print()
	else
		//ds.print()
	end if
end if



if g_impresion_docuprinter='N' then
	// IMPRESION SIN DOCUPRINTER
	if tipo_estructura = 1 then idw.SaveAs(fichero, PDF!, false) 
	if tipo_estructura = 2 then ds.SaveAs(fichero, PDF!, false) 
else
	// IMPRESION CON DOCUPRINTER
	//Guardamos impresora predeterminada
	ls_impresora_defecto = printgetprinter()
		
	//Cambiamos a la impresora por defecto a la docuprinter
	PrintSetPrinter('docuprinter')
	
	
	//Obtenemos la ruta donde est$$HEX2$$e1002000$$ENDHEX$$instalada la impresora Docuprinter
	RegistryGet( is_ruta_registro_docuprinter,"ProductVersion", RegString!, version)
	
	// Establecer parametros de Neevia
	if version='LT 5.x' then
		rtn += RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","Option_SaveAs_Visible", ReguLong!,  0)
		rtn += RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","FileMask", RegString!,  nombre+'.pdf')
		rtn +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputPath", RegString!,ruta_total)
		rtn +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputFile", RegString!, nombre)
		rtn +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputType", ReguLong!, 1)	
	else
		rtn += RegistrySet(is_ruta_registro_docuprinter,"UseMask", ReguLong!, 1) 
		rtn += RegistrySet(is_ruta_registro_docuprinter,"FileMask", RegString!,  nombre+'.pdf')
		rtn +=RegistrySet(is_ruta_registro_docuprinter,"PDFOutputPath", RegString!,ruta_total)
		rtn +=RegistrySet(is_ruta_registro_docuprinter,"OutputFile", RegString!, nombre+'.pdf')
		rtn +=RegistrySet(is_ruta_registro_docuprinter,"OutputType", ReguLong!, 1)
	end if
	
	if rtn <> 5 then
		messagebox(g_titulo, 'No tiene instalado el m$$HEX1$$f300$$ENDHEX$$dulo de conversi$$HEX1$$f300$$ENDHEX$$n a PDF')
		return -2
	end if

	if tipo_estructura=1 then idw.print()
	if tipo_estructura=2 then ds.print()

	//Esperamos hasta que se cree el archivo
	OpenWithParm(w_espera_pdf, fichero)
	
		retorno = Message.DoubleParm
	
	//Devolvemos el valor predeterminado de la impresora y del registro...
	if version='LT 5.x' then
		rtn += RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","Option_SaveAs_Visible", ReguLong!, 1)
		rtn += RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","FileMask", RegString!,  "")
		rtn +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputPath", RegString!,'C:\')
		rtn +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputFile", RegString!, '')
		rtn +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputType", ReguLong!, 1)	
	else
		rtn += RegistrySet(is_ruta_registro_docuprinter,"UseMask", ReguLong!,0) 
		rtn += RegistrySet(is_ruta_registro_docuprinter,"FileMask", RegString!, '')
		rtn += RegistrySet(is_ruta_registro_docuprinter,"PDFOutputPath", RegString!,'C:\')
		rtn += RegistrySet(is_ruta_registro_docuprinter,"OutputFile", RegString!, '')
		rtn += RegistrySet(is_ruta_registro_docuprinter,"OutputType", ReguLong!, 1)
	end if
	
	PrintSetPrinter(ls_impresora_defecto)
end if    // FIN DE IMPRESION CON DOCUPRINTER





// FIRMA DE PDF
ist_doc_modulo.nombre_fichero=nombre

ist_doc_modulo.tamanyo = Ceiling(gnv_fichero.of_GetFileSize(fichero) / 1024)
if firmar_pdf='S' then f_firmar_pdf(fichero)


// ABRIR FICHERO SI PROCEDE
if fileexists(ruta_base + ruta_relativa + nombre + '.PDF') then	
	f_error('+04')
	if pdf_previsualizar then f_abrir_fichero(ruta_total,nombre+'.pdf', "")
else
	f_error('-04')
end if


return retorno

end function

public subroutine f_firmar_pdf (string fichero_pdf);if (is_aplica_sellado <> 'S') then 

	u_signer firmador
	int existe
	string nombre_ext
	
	
	firmador = create u_signer
	
	firmador.i_pkcs = g_directorio_certificados+certificado
	firmador.i_nom = nombre_cer
	firmador.i_razon = razon
	firmador.i_loc = situacion
	firmador.i_clave = password
	firmador.i_directorio_aplicacion = g_dir_aplicacion
	
	firmador.i_fichero_entrada 	= fichero_pdf
	firmador.i_o = MidA(fichero_pdf,1,LenA(fichero_pdf) - 4)+g_valor_extension_docs_sellados+ '.pdf'
	firmador.i_err = g_dir_aplicacion+'error.txt'	
	
	firmador.of_firmar()
	
	if FileExists (firmador.i_o) then 
		
		if(destino = 'T') then
		
			nombre_ext = nombre + '.pdf' 
		
			SELECT count(id_fichero)  
			INTO :existe  
			FROM fases_documentos_visared  
			WHERE id_fase = :referencia_web AND nombre_fichero = :nombre_ext AND ruta_fichero = :ruta_relativa ;
		
			if (existe = 0) then FileDelete(fichero_pdf)
			
		
		else
			FileDelete(fichero_pdf)
		end if
		
		f_actualizar_campo_firmado (id_factura, 'S')
		nombre = nombre + g_valor_extension_docs_sellados
		documento_sellado = 'S'
		
	end if
else
	
	string fichero, sello
	
	sello =  ist_configuracion_sello.dw_datos_firma.getitemstring( 1, 'sello')

	
	if not f_es_vacio(sello) then
		select fichero into :fichero from t_sello where codigo = :sello;
	end if
	
	if f_es_vacio(fichero) then
	
		wf_sellado_sin_fichero(fichero_pdf)
		
	else

		wf_sellado_con_fichero(fichero, fichero_pdf)
			
	end if
end if

end subroutine

public subroutine f_obtener_parametro_plantilla (ref string texto);n_cst_string lnv_string

string n_registro, fase, descripcion, s_f_visado, telefono, ls_n_aviso, ls_cliente_nombre, ls_cliente_apellidos
string ls_emplazamiento, ls_tipo_emplazamiento, ls_poblacion, ls_tipo_trabajo, ls_actuacion_desc
datetime f_visado

SELECT n_registro,
		 fase,
		 descripcion,
		 f_visado
  INTO :n_registro,
		 :fase,
		 :descripcion,
		 :f_visado
  FROM fases WHERE id_fase = :referencia ;

// Especial para las minutas
if not f_es_vacio(referencia2) then
	
	select c.nombre, c.apellidos, fm.n_aviso
	into :ls_cliente_nombre, :ls_cliente_apellidos, :ls_n_aviso
	from clientes c, fases_minutas fm
	where fm.id_cliente = c.id_cliente
	and fm.id_minuta = :referencia2;
	if not f_es_vacio(ls_cliente_nombre) and not f_es_vacio(ls_cliente_apellidos) then
		ls_cliente_nombre = ls_cliente_nombre +' '+ ls_cliente_apellidos
	else 
		if f_es_vacio(ls_cliente_nombre)then
			ls_cliente_nombre = ls_cliente_apellidos
		end if
	end if	
	texto = lnv_string.of_globalreplace(texto, "{NOMBRE_CLIENTE}", ls_cliente_nombre)
	texto = lnv_string.of_globalreplace(texto, "{N_AVISO}", ls_n_aviso)
	
end if

//emplazamineto, poblacion, descripci$$HEX1$$f300$$ENDHEX$$n actuaci$$HEX1$$f300$$ENDHEX$$n, tipo_trabajo

select f.emplazamiento, tv.descripcion, p.descripcion, d_t_trabajo, tf.d_t_descripcion
into :ls_emplazamiento, :ls_tipo_emplazamiento, :ls_poblacion, :ls_tipo_trabajo,  :ls_actuacion_desc
from tipos_via tv, fases f, poblaciones p, tipos_trabajos tt, t_fases tf
where p.cod_pob = f.poblacion
and tv.cod_tipo_via = f.tipo_via_emplazamiento
and tt.c_t_trabajo = f.tipo_trabajo
and tf.c_t_fase = f.fase
and f.id_fase = :referencia ;


if f_es_vacio(descripcion) then descripcion = ''

s_f_visado = string(f_visado, "dd/mm/yyyy")
if f_es_vacio(s_f_visado) then s_f_visado = ''

SELECT telefono INTO :telefono FROM csi_empresas WHERE codigo=:g_empresa;
if f_es_vacio(telefono) then telefono=''

texto = lnv_string.of_globalreplace(texto, "{N_EXPEDI}", f_dame_exp(referencia) )
texto = lnv_string.of_globalreplace(texto, "{FASE}", fase )
texto = lnv_string.of_globalreplace(texto, "{N_REGISTRO}", n_registro )
texto = lnv_string.of_globalreplace(texto, "{DESC_FASE}", descripcion )
texto = lnv_string.of_globalreplace(texto, "{F_VISADO}", s_f_visado)
texto = lnv_string.of_globalreplace(texto, "{NOMBRE_COLEGIO}", g_nombre_empresa)
texto = lnv_string.of_globalreplace(texto, "{DIREC_COLEGIO}", g_direccion_empresa)
texto = lnv_string.of_globalreplace(texto, "{POBLACION_COLEGIO}", g_localidad_empresa)
texto = lnv_string.of_globalreplace(texto, "{TELEF_COLEGIO}", telefono)
texto = lnv_string.of_globalreplace(texto, "{FECHA_HOY}", string(today(), "dd/mm/yyyy"))
texto = lnv_string.of_globalreplace(texto, "{EMPLAZAMIENTO}", ls_tipo_emplazamiento +' '+ ls_emplazamiento )
texto = lnv_string.of_globalreplace(texto, "{POBLACION}", ls_poblacion)
texto = lnv_string.of_globalreplace(texto, "{TIPO_ACTUACION}",  ls_actuacion_desc )
texto = lnv_string.of_globalreplace(texto, "{TIPO_TRABAJO}", ls_tipo_trabajo)


// Otros c$$HEX1$$f300$$ENDHEX$$digos reservados: {NOMBRE_DOCUMENTO}, {MENSAJE}

end subroutine

public function string f_obtener_estructura_plantilla (string archivo, string seccion);/* Devuelve el contenido de un archivo de texto. Si el archivo esta dividido en secciones
de tipo INI [nombre_seccion] y se especifica un nombre de secci$$HEX1$$f300$$ENDHEX$$n se devolver$$HEX2$$e1002000$$ENDHEX$$s$$HEX1$$f300$$ENDHEX$$lo el
contenido de esa secci$$HEX1$$f300$$ENDHEX$$n.
En caso de error devuelve nulo.
*/

string ruta
integer file_num
string linea
boolean leer
string texto


ruta = g_directorio_rtf + archivo
file_num = FileOpen(ruta, LineMode!, Read!)
if file_num<0 then
	messagebox(g_titulo,"No se pudo abrir el fichero ~"" + ruta + "~"")
	setnull(texto)
	return texto
end if


texto = ""

if f_es_vacio(seccion) then
	
	do while FileRead(file_num,linea) >= 0
		texto += linea + cr
	loop
	
else
	
	leer = false
	do while FileRead(file_num,linea) >= 0
		if LeftA(trim(linea), 1) = "[" and RightA(trim(linea), 1) = "]" then
			if leer then exit
			leer = trim(linea) = "[" + seccion + "]"
		elseif leer then
			texto += linea + cr
		end if
	loop
	
end if

FileClose(file_num)

return texto

end function

public subroutine f_aplicar_plantilla ();// Funci$$HEX1$$f300$$ENDHEX$$n que sustituye el asunto y el texto del mensaje por el de la plantilla correspondiente
// (SOLO en caso de que exista)
string asunto,texto
n_cst_string lnv_string

if Not(fileExists(g_directorio_rtf+plantilla)) then return

asunto = f_obtener_estructura_plantilla(plantilla, "ASUNTO")
asunto = lnv_string.of_globalreplace(asunto, "~r", "") // El asunto no puede tener saltos de l$$HEX1$$ed00$$ENDHEX$$nea
asunto = lnv_string.of_globalreplace(asunto, "~n", "") // El asunto no puede tener saltos de l$$HEX1$$ed00$$ENDHEX$$nea
f_obtener_parametro_plantilla(asunto)

texto = f_obtener_estructura_plantilla(plantilla, "CABECERA")
texto += f_obtener_estructura_plantilla(plantilla, "PIE")
f_obtener_parametro_plantilla(texto)

// Sustituimos el texto escrito manualmente dentro de la plantilla (SOLO SI LA PLANTILLA TIENE EL CAMPO {MENSAJE}
texto=lnv_string.of_globalreplace(texto, "{MENSAJE}", texto_email)
asunto_email=asunto
texto_email=texto




end subroutine

public subroutine f_mail_sockets ();boolean lb_html
string ls_filename,texto,copia,dividir_email, direc
long i,posicion_coma, ll_posicion_puntoycoma, ll_diferencia_pos
st_login datos_login
n_cst_encrypt encriptacion
encriptacion=create n_cst_encrypt
n_cst_string lnv_string
n_smtp ln_smtp

// Obtenemos los datos del ini
dividir_email=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","partir_envio_masivo", "N")
if dividir_email='S' then
	f_mail_sockets_dividido()
	return
end if

is_servidor_smtp=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","servidor_smtp", "")
is_servidor_pop=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","servidor_pop", "")
is_direccion=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","direccion", "")
is_nombre=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","nombre", "")
is_recordar=Upper(ProfileString(g_dir_aplicacion+"sica.ini","CORREO","recordar", "N"))
copia=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","direccion_copia", "")


if is_recordar='S' then
	is_login=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","login", "")
	is_password=encriptacion.of_decrypt(ProfileString(g_dir_aplicacion+"sica.ini","CORREO","password", ""))
else
	is_login=""
	is_password=""
end if

//Aplicamos la plantilla
if Not(f_es_vacio(plantilla)) then f_aplicar_plantilla()
if formato_html='S' then lb_html=true

// Establecemos los datos del servidor y del email
ln_smtp.of_SetReceipt(false)
ln_smtp.of_SetServer(is_servidor_smtp)
ln_smtp.of_SetFrom(is_direccion,is_nombre)
ln_smtp.of_SetSubject(asunto_email)
ln_smtp.of_SetBody(texto_email, lb_html)

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

ln_smtp.of_SetLogin(is_login,is_password)	
ln_smtp.of_Reset()


// Obtenemos la lista de destinatarios
texto=direccion_email
posicion_coma=1
ll_posicion_puntoycoma = 1
do while (posicion_coma<>0 or ll_posicion_puntoycoma <> 0)
	posicion_coma=PosA(texto,',')
	ll_posicion_puntoycoma= PosA(texto,';')
	ll_diferencia_pos = posicion_coma - ll_posicion_puntoycoma
//	if posicion_coma<>0 then
//		ln_smtp.of_AddTo(trim(MidA(texto,1,posicion_coma - 1)))
//	else
//		ln_smtp.of_AddTo(trim(MidA(texto,1)))
//	end if
//	texto=MidA(texto,posicion_coma+1)
	if ll_diferencia_pos = 0 then
		if not (f_es_vacio(trim(texto))) then 
			ln_smtp.of_AddTo(trim(MidA(texto,1)))
		end if	
	else 
		if ((ll_diferencia_pos > 0 and ll_posicion_puntoycoma <> 0) or ( ll_diferencia_pos < 0 and posicion_coma = 0)) then 	
			ln_smtp.of_AddTo(trim(MidA(texto,1,ll_posicion_puntoycoma - 1)))
			texto=MidA(texto,ll_posicion_puntoycoma+1)
		else
			ln_smtp.of_AddTo(trim(MidA(texto,1,posicion_coma - 1)))
			texto=MidA(texto,posicion_coma+1)
		end if
	end if	
loop


// Obtenemos la lista de destinatarios con copia
texto=cc_email
if Not(IsNull(texto)) and (trim(texto)<>"") then
	posicion_coma=1
	ll_posicion_puntoycoma = 1
	do while (posicion_coma<>0 or ll_posicion_puntoycoma <> 0)
		posicion_coma=PosA(texto,',')
		ll_posicion_puntoycoma= PosA(texto,';')
		ll_diferencia_pos = posicion_coma - ll_posicion_puntoycoma
	
		if ll_diferencia_pos = 0 then
			if not (f_es_vacio(trim(texto))) then 
				ln_smtp.of_Addcc(trim(MidA(texto,1)))
			end if 	
		else 
			if ((ll_diferencia_pos > 0 and ll_posicion_puntoycoma <> 0) or ( ll_diferencia_pos < 0 and posicion_coma = 0)) then 	
				ln_smtp.of_Addcc(trim(MidA(texto,1,ll_posicion_puntoycoma - 1)))
				texto=MidA(texto,ll_posicion_puntoycoma+1)
			else
				ln_smtp.of_Addcc(trim(MidA(texto,1,posicion_coma - 1)))
				texto=MidA(texto,posicion_coma+1)
			end if
		end if	
	loop
end if


// Obtenemos la lista de destinatarios con copia oculta
texto=cco_email
if Not(IsNull(texto)) and (trim(texto)<>"") then
	posicion_coma=1
	ll_posicion_puntoycoma = 1
	do while (posicion_coma<>0 or ll_posicion_puntoycoma <> 0)
		posicion_coma=PosA(texto,',')
		ll_posicion_puntoycoma= PosA(texto,';')
		ll_diferencia_pos = posicion_coma - ll_posicion_puntoycoma
	
		if ll_diferencia_pos = 0 then
			if not (f_es_vacio(trim(texto))) then 
				ln_smtp.of_AddBcc(trim(MidA(texto,1)))
			end if	
		else 
			if ((ll_diferencia_pos > 0 and ll_posicion_puntoycoma <> 0) or ( ll_diferencia_pos < 0 and posicion_coma = 0)) then 	
				ln_smtp.of_Addbcc(trim(MidA(texto,1,ll_posicion_puntoycoma - 1)))
				texto=MidA(texto,ll_posicion_puntoycoma+1)
			else
				ln_smtp.of_Addbcc(trim(MidA(texto,1,posicion_coma - 1)))
				texto=MidA(texto,posicion_coma+1)
			end if
		end if	
	loop
end if

if not f_es_vacio(copia) then
	direc = trim(copia)
	ln_smtp.of_AddBcc(direc)
end if

if not(sin_adjuntos) then
	ls_filename = ruta_base + ruta_relativa + nombre+'.pdf'
	ln_smtp.of_AddFile(ls_filename)
	
	for i=1 to upperbound(adjuntos)
		ln_smtp.of_AddFile(adjuntos[i])
	next
	
end if


// Enviar el mensaje
if ln_smtp.of_SendMail() then
	f_error('+03')
//	MessageBox(g_titulo, "El mensaje fue enviado correctamente")
else
	f_error('-03')
//	MessageBox(g_titulo, "No se pudo enviar el mensaje",Exclamation!)
end if

end subroutine

public function integer f_ruta_otras_facturas ();datetime f_factura
string n_col, anyo_f_factura, tipo_factura, ls_id_persona

select fecha, tipo_factura, id_persona into :f_factura, :tipo_factura, :ls_id_persona from csi_facturas_emitidas where id_factura =:id_factura;

anyo_f_factura = string(year(date(f_factura)))

if tipo_factura = g_colegio_cliente then
	
	ruta_base = g_directorio_facturas_a_cliente
	ruta_relativa = anyo_f_factura + '\'
	
else
		
	if f_es_vacio(id_factura) then ls_id_persona = referencia

	IF f_es_vacio(ls_id_persona) then return -1
	
	select n_colegiado into :n_col from colegiados where id_colegiado = :ls_id_persona;
	
	ruta_base = g_directorio_documentos_visared
	ruta_relativa= anyo_f_factura +'\'+n_col+'\'+g_directorio_otras_facturas+'\'
	
end if

return 1

end function

public function integer f_generar_registro_salida ();datastore ds_registro,ds_reg_anexo
long fila,res
string poblacion,apellidos,id_reg
string param1,param2

// GENERACION DEL REGISTRO DE SALIDA
if nuevo_reg_salida='S' then
	ds_registro=create datastore
	ds_registro.dataobject='d_registros_detalle'
	ds_registro.SetTransObject(SQLCA)
	fila=ds_registro.insertrow(0)
	
	id_reg=f_siguiente_numero('REGISTROS',10)
	ds_registro.SetItem(fila,'id_registro',id_reg)
	ds_registro.setitem(fila, 'fecha', datetime(Today()) )
	ds_registro.setitem(fila, 'fecha_grabacion', datetime(Today()) )
	
	
	select param1,param2 into :param1,:param2 from t_control_eventos where control='REMITENTE' and evento='REGISTRO_CAMBIO_ES';
	ds_registro.setitem(fila, 'tipo_persona_o','O')
	ds_registro.setitem(fila, 'nombre_o', param1)
	ds_registro.setitem(fila, 'poblacion_o', param2)
	ds_registro.setitem(fila, 'cp_o', f_devuelve_cod_postal(param2))
	ds_registro.setitem(fila, 'asunto',asunto_registro)
	ds_registro.setitem(fila, 'cod_delegacion', g_cod_delegacion )
	ds_registro.setitem(fila, 'id_d',id_receptor)
	ds_registro.setitem(fila, 'tipo_persona_d',tipo_receptor)
	ds_registro.setitem(fila, 'es','S')
	ds_registro.setitem(fila, 'oficial','N')
	ds_registro.setitem(fila, 'n_expediente',expediente)
	ds_registro.setitem(fila, 'n_expedi',n_expedi)
	ds_registro.setitem(fila, 'empresa',g_empresa)
	
	//n_reg_salida=serie+'-'+f_siguiente_numero_reg_es(serie,10)
	
	st_control_eventos c_evento 
	c_evento.evento = 'REGISTRO_ES'
	f_control_eventos(c_evento)
	n_reg_salida=serie+'-'+f_numera_reg_salida(c_evento.param1,serie)
	
	
	ds_registro.SetItem(fila, 'n_registro',n_reg_salida)
	
		choose case tipo_receptor
			case 'C'
				ds_registro.setitem(fila,'codigo_d',f_colegiado_n_col(id_receptor))
				ds_registro.setitem(fila,'nombre_d',f_colegiado_certificados(id_receptor))
				SELECT domicilios.cod_pob  
				INTO :poblacion  
				FROM domicilios  
				WHERE domicilios.id_colegiado like :id_receptor   ;
				ds_registro.setitem(fila,'poblacion_d',poblacion)	
			case 'U'
				ds_registro.setitem(fila,'codigo_d',id_receptor)		
				ds_registro.setitem(fila,'nombre_d',f_usuario(id_receptor))
				ds_registro.setitem(1,'departamento_d',g_certificados_busqueda.departamento)
			case 'O'
				if f_es_vacio(id_receptor) then
					ds_registro.setitem(fila,'nombre_d',receptor)
				else
					ds_registro.setitem(fila,'codigo_d',id_receptor)	
					ds_registro.setitem(fila,'nombre_d',f_otras_personas(id_receptor))
				end if
			case 'T'
				ds_registro.setitem(fila,'codigo_d',id_receptor)
				select nombre into :nombre from clientes where id_cliente = :id_receptor;
				select apellidos into :apellidos from clientes where id_cliente = :id_receptor;
				if NOT f_es_vacio(nombre) then
					apellidos = apellidos + ", " + nombre
				end if
				ds_registro.setitem(fila,'nombre_d',apellidos)
				select cod_pob into :poblacion from clientes where id_cliente = :id_receptor;
				ds_registro.setitem(fila,'poblacion_d',poblacion)
		end choose
	
	res=ds_registro.update()
	if res>0 then
		id_registro=id_reg
	else
		id_registro=''
	end if
end if

/*
// COMENTADO POR ELOY. Se ha sacado a una funcion (f_incluir_anexo_registro_salida) ya que aqui todavia no se tiene el id_doc_modulo
	if generar_doc_modulo='S' and pdf='S' and res>0 then
		ds_reg_anexo=create datastore
		ds_reg_anexo.dataobject='d_registros_anexos'
		ds_reg_anexo.SetTransObject(SQLCA)
		fila=ds_reg_anexo.insertrow(0)
		
		ds_reg_anexo.SetItem(fila,'id_registro_anexo',f_siguiente_numero('REGISTROS_ANEXOS',10))
		ds_reg_anexo.SetItem(fila,'id_registro',id_reg)
		ds_reg_anexo.SetItem(fila,'ruta',nombre+'.pdf')	
		ds_reg_anexo.SetItem(fila,'id_documento_modulo',id_doc_modulo)	
		res=ds_reg_anexo.update()	
	end if	

else
	if generar_doc_modulo='S' and pdf='S' then
		select id_registro into :id_reg from registro where n_registro=:n_reg_salida;
		if not(f_es_vacio(id_reg)) then
			ds_reg_anexo=create datastore
			ds_reg_anexo.dataobject='d_registros_anexos'
			ds_reg_anexo.SetTransObject(SQLCA)
			fila=ds_reg_anexo.insertrow(0)
			
			ds_reg_anexo.SetItem(fila,'id_registro_anexo',f_siguiente_numero('REGISTROS_ANEXOS',10))
			ds_reg_anexo.SetItem(fila,'id_registro',id_reg)
			ds_reg_anexo.SetItem(fila,'ruta',nombre+'.pdf')	
			ds_reg_anexo.SetItem(fila,'id_documento_modulo',id_doc_modulo)	
			res=ds_reg_anexo.update()				
		end if
	end if

*/
return 1
end function

public function integer f_generar_entrada_doc_modulo ();//
datastore ds_doc_modulo
long fila,res
string id,id_tipo_modulo,id_modulo,anyo,nombre_ext
datetime ahora

ahora=datetime(today(),now())

ds_doc_modulo=create datastore
ds_doc_modulo.dataobject='d_csd_doc_modulo'
ds_doc_modulo.SetTransObject(SQLCA)

fila=ds_doc_modulo.insertrow(0)

//if f_es_vacio(ist_doc_modulo.id_tipo_modulo) then ist_doc_modulo.id_tipo_modulo
anyo=ist_doc_modulo.anyo
id_modulo=ist_doc_modulo.id_modulo
id_tipo_modulo=ist_doc_modulo.id_tipo_modulo
if f_es_vacio(id_tipo_modulo) then id_tipo_modulo=ruta_relativa1
if f_es_vacio(anyo) then anyo=ruta_relativa2
if f_es_vacio(id_modulo) then id_modulo=ruta_relativa3

nombre_ext=nombre+'.pdf'
select id_documento_modulo into :id from csd_doc_modulo where id_tipo_modulo=:id_tipo_modulo and 
id_modulo=:id_modulo and anyo=:anyo and nombre_fichero=:nombre_ext;

if f_es_vacio(id) then
	
	id=f_siguiente_numero('ID_DOC_MODULO',20)
	ds_doc_modulo.SetItem(fila,'id_documento_modulo',id)
	ds_doc_modulo.SetItem(fila,'id_tipo_modulo',id_tipo_modulo)
	ds_doc_modulo.SetItem(fila,'id_modulo',id_modulo)
	ds_doc_modulo.SetItem(fila,'anyo',anyo)
	ds_doc_modulo.SetItem(fila,'nombre_fichero',nombre+".pdf")
	ds_doc_modulo.SetItem(fila,'descripcion',ist_doc_modulo.descripcion)
	ds_doc_modulo.SetItem(fila,'f_activacion',ahora)
	ds_doc_modulo.SetItem(fila,'id_usuario',g_usuario)
	ds_doc_modulo.SetItem(fila,'visible_web',visualizar_web)
	ds_doc_modulo.SetItem(fila,'cod_tipo_documento',ist_doc_modulo.cod_tipo_documento)
	ds_doc_modulo.SetItem(fila,'tamanyo',ist_doc_modulo.tamanyo)
	ds_doc_modulo.SetItem(fila,'ubicacion',ist_doc_modulo.ubicacion)
	
	res=ds_doc_modulo.update()
else
	update csd_doc_modulo set f_activacion=:ahora where id_documento_modulo=:id;
end if

if res<0 then 
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Error al insertar el fichero en la tabla csd_doc_modulo")
else
	id_doc_modulo=id
end if
return res

end function

public subroutine f_sms ();string ls_dw_err	,ls_sql_syntax,ls_dw_syntax
string num_movil,movil[],id,mensaje
long i,posicion_coma, ll_fila_aux, res
datastore ds_enviados
integer num_sms_ok,num
integer num_sms_err

ds_enviados=create datastore 
ds_enviados.dataobject='d_email_enviados'
ds_enviados.SetTransObject(SQLCA)

//ls_sql_syntax= "  SELECT csd_sms_enviados.movil_contacto,  csd_sms_enviados.nif, csd_sms_enviados.nombre, " + &   
//" csd_sms_enviados.apellidos,  csd_sms_enviados.f_envio, csd_sms_enviados.envio, csd_sms_enviados.mensaje, " + &   
//" csd_sms_enviados.id_sms, csd_sms_enviados.id_campanya, csd_sms_enviados.id_sms_predefinido, csd_sms_enviados.envio_mensaje, " + &   
//" csd_sms_enviados.tipo_aviso, csd_sms_enviados.email, csd_sms_enviados.fecha_envio_final, csd_sms_enviados.hora_envio,  " + & 
//" csd_sms_enviados.texto, csd_sms_enviados.id_sms_enviados  FROM csd_sms_enviados    "

if f_es_vacio(texto_sms) or f_es_vacio(moviles) then
	return
end if				

//ls_dw_syntax = SQLCA.SyntaxFromSQL(ls_sql_syntax , "style(type=grid) ", ls_dw_err)
//ds_enviados.create(ls_dw_syntax,ls_dw_err)
//ds_enviados.settransobject(SQLCA)


num_movil=moviles
i=1
do
	
	posicion_coma=pos(num_movil,',')
	if posicion_coma>0 then
		movil[i]=trim(mid(num_movil,1,posicion_coma - 1))
		num_movil=mid(num_movil,posicion_coma+1)
		i++
	end if
		
loop while posicion_coma>0
movil[i]=trim(num_movil)


for i=1 to upperbound(movil)
	
	select count(*) into :num from csd_sms_enviados where movil_contacto = :movil[i] and envio_mensaje='N';
	if num>0 then
		if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","El n$$HEX1$$fa00$$ENDHEX$$mero "+string(movil[i])+" tiene "+string(num)+" mensajes pendientes de env$$HEX1$$ed00$$ENDHEX$$o. $$HEX1$$bf00$$ENDHEX$$Desea enviar el mensaje igualmente?",Question!,YesNo!)<>1 then
			continue
		end if
	end if
	ll_fila_aux=ds_enviados.insertRow(0)
	id=f_siguiente_numero("SMS_ENVIADOS",10)
	ds_enviados.setitem(ll_fila_aux,'id_sms_enviados',id)
	ds_enviados.setitem(ll_fila_aux,'nombre','')
	ds_enviados.setitem(ll_fila_aux,'apellidos','')
	ds_enviados.setitem(ll_fila_aux,'movil_contacto',movil[i])	
	ds_enviados.setitem(ll_fila_aux,'email','')
	ds_enviados.setitem(ll_fila_aux,'id_sms',"")
	ds_enviados.setitem(ll_fila_aux,'f_envio',datetime(string(today(),"dd-mm-yyyy")))
	ds_enviados.setitem(ll_fila_aux,'hora_envio',time(string(now(),"hh:mm")))	
	ds_enviados.setitem(ll_fila_aux,'envio_mensaje','N')	
	ds_enviados.setitem(ll_fila_aux,'tipo_aviso','S')			
	ds_enviados.setitem(ll_fila_aux,'mensaje',texto_sms)
	ds_enviados.setitem(ll_fila_aux,'texto','')	
	res=ds_enviados.update()
	
	if res=-1 then
		num_sms_err++
	else
		num_sms_ok++
	end if	
next

if num_sms_err>0 then mensaje=string(num_sms_err) + " mensajes no se pudieron a$$HEX1$$f100$$ENDHEX$$adir a la cola"
if num_sms_ok>0 then mensaje=string(num_sms_ok) + " mensajes se a$$HEX1$$f100$$ENDHEX$$adieron correctamente a la cola"
	
if not(f_es_vacio(mensaje)) then MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n",mensaje)
		

end subroutine

public subroutine f_mail_gae ();string texto,direc
long posicion_coma
datastore ds_enviados
string ls_dw_err	,ls_sql_syntax,ls_dw_syntax
string ls_cuerpo,ls_asunto,n_registro
long ll_fila_aux,res
ds_enviados = create datastore

ds_enviados.dataobject='d_email_enviados'
ds_enviados.SetTransObject(SQLCA)

//ls_sql_syntax= "  SELECT csd_sms_enviados.movil_contacto,  csd_sms_enviados.nif, csd_sms_enviados.nombre, " + &   
//" csd_sms_enviados.apellidos,  csd_sms_enviados.f_envio, csd_sms_enviados.envio, csd_sms_enviados.mensaje, " + &   
//" csd_sms_enviados.id_sms, csd_sms_enviados.id_campanya, csd_sms_enviados.id_sms_predefinido, csd_sms_enviados.envio_mensaje, " + &   
//" csd_sms_enviados.tipo_aviso, csd_sms_enviados.email, csd_sms_enviados.fecha_envio_final, csd_sms_enviados.hora_envio,  " + & 
//" csd_sms_enviados.texto, csd_sms_enviados.id_sms_enviados  FROM csd_sms_enviados    "


	
if f_es_vacio(direccion_email) then
	f_error("-07")
	return
end if


//ls_dw_syntax = SQLCA.SyntaxFromSQL(ls_sql_syntax , "style(type=grid) ", ls_dw_err)
//ds_enviados.create(ls_dw_syntax,ls_dw_err)
//ds_enviados.settransobject(SQLCA)

// Obtenemos la lista de destinatarios
texto=direccion_email
posicion_coma=1
do while posicion_coma<>0 
	posicion_coma=PosA(texto,',')
	if posicion_coma<>0 then
		direc=trim(MidA(texto,1,posicion_coma - 1))
	else
		direc=trim(MidA(texto,1))
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
	ds_enviados.setitem(ll_fila_aux,'mensaje',asunto_email)
	ds_enviados.setitem(ll_fila_aux,'texto',texto_email)			
	
	
	texto=MidA(texto,posicion_coma+1)
loop



res=ds_enviados.update()

if res=-1 then
	f_error("-12")
else
	f_error("+03")	
end if
		

return 
end subroutine

public subroutine f_mail_sockets_dividido ();boolean lb_html
string ls_filename,texto,copia,lista_emails,direc
long i,posicion_coma, ll_posicion_puntoycoma, ll_diferencia_pos
st_login datos_login
n_cst_encrypt encriptacion
encriptacion=create n_cst_encrypt
n_cst_string lnv_string
n_smtp ln_smtp

// Obtenemos los datos del ini
is_servidor_smtp=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","servidor_smtp", "")
is_servidor_pop=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","servidor_pop", "")
is_direccion=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","direccion", "")
is_nombre=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","nombre", "")
is_recordar=Upper(ProfileString(g_dir_aplicacion+"sica.ini","CORREO","recordar", "N"))
is_limite=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","limite", "")
copia=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","direccion_copia", "")
if(f_es_vacio(is_limite))then is_limite = '10'


if is_recordar='S' then
	is_login=ProfileString(g_dir_aplicacion+"sica.ini","CORREO","login", "")
	is_password=encriptacion.of_decrypt(ProfileString(g_dir_aplicacion+"sica.ini","CORREO","password", ""))
else
	is_login=""
	is_password=""
end if

//Aplicamos la plantilla
if Not(f_es_vacio(plantilla)) then f_aplicar_plantilla()
if formato_html='S' then lb_html=true

// Establecemos los datos del servidor y del email
ln_smtp.of_SetReceipt(false)
ln_smtp.of_SetServer(is_servidor_smtp)
ln_smtp.of_SetFrom(is_direccion,is_nombre)
ln_smtp.of_SetSubject(asunto_email)
ln_smtp.of_SetBody(texto_email, lb_html)

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

ln_smtp.of_SetLogin(is_login,is_password)	
ln_smtp.of_Reset()

if not(ln_smtp.of_csd_conexion()) then
	f_error('-13')
	return
end if


if not(sin_adjuntos) then
	ls_filename = ruta_base + ruta_relativa + nombre+'.pdf'
	ln_smtp.of_AddFile(ls_filename)
	
	for i=1 to upperbound(adjuntos)
		ln_smtp.of_AddFile(adjuntos[i])
	next	
end if


// Obtenemos la lista de destinatarios
texto=direccion_email
if Not(IsNull(texto)) and (trim(texto)<>"") then
	posicion_coma=1
	ll_posicion_puntoycoma = 1
	do while (posicion_coma<>0 or ll_posicion_puntoycoma <> 0)
		posicion_coma=PosA(texto,',')
		ll_posicion_puntoycoma= PosA(texto,';')
		ll_diferencia_pos = posicion_coma - ll_posicion_puntoycoma
	
		if ll_diferencia_pos = 0 then
			//ln_smtp.of_csd_AddTo_unico(trim(MidA(texto,1)))
			continue
		else 
			if ((ll_diferencia_pos > 0 and ll_posicion_puntoycoma <> 0) or ( ll_diferencia_pos < 0 and posicion_coma = 0)) then 	
				direc=trim(MidA(texto,1,ll_posicion_puntoycoma - 1))
				texto=MidA(texto,ll_posicion_puntoycoma+1)
			else
				direc=trim(MidA(texto,1,posicion_coma - 1))
				texto=MidA(texto,posicion_coma+1)
			end if
			//ln_smtp.of_csd_AddTo_unico(direc)
			if ln_smtp.of_csd_AddTo_limitado(direc,is_limite)=-1 then
				if not(ln_smtp.of_csd_enviar_datos()) then
					lista_emails+=direc+cr
				else
					ln_smtp.of_csd_AddTo_reset()
					ln_smtp.of_csd_AddTo_limitado(direc,is_limite)
				end if
			end if
		end if	
	loop
	texto = trim(texto)
	if ln_smtp.of_csd_AddTo_limitado(texto,is_limite)=-1 then
		if not(ln_smtp.of_csd_enviar_datos()) then
			lista_emails+=texto+cr
		else
			ln_smtp.of_csd_AddTo_reset()
			ln_smtp.of_csd_AddTo_limitado(texto,is_limite)
			if not(ln_smtp.of_csd_enviar_datos()) then
				lista_emails+=texto+cr
			end if
		end if
	else
		if not(ln_smtp.of_csd_enviar_datos()) then
			lista_emails+=texto+cr
		end if
	end if
end if
ln_smtp.of_csd_AddTo_reset()

//posicion_coma=1
//do while posicion_coma<>0 
//	posicion_coma=PosA(texto,',')
//	if posicion_coma<>0 then
//		direc=trim(MidA(texto,1,posicion_coma - 1))
//		ln_smtp.of_csd_AddTo_unico(direc)
//	else
//		direc=trim(MidA(texto,1))
//		ln_smtp.of_csd_AddTo_unico(direc)
//	end if
//	if not(ln_smtp.of_csd_enviar_datos()) then
//		lista_emails+=direc+cr
//	end if
//	texto=MidA(texto,posicion_coma+1)
//loop


// Obtenemos la lista de destinatarios con copia
texto=cc_email
if Not(IsNull(texto)) and (trim(texto)<>"") then
	posicion_coma=1
	ll_posicion_puntoycoma = 1
	do while (posicion_coma<>0 or ll_posicion_puntoycoma <> 0)
		posicion_coma=PosA(texto,',')
		ll_posicion_puntoycoma= PosA(texto,';')
		ll_diferencia_pos = posicion_coma - ll_posicion_puntoycoma
	
		if ll_diferencia_pos = 0 then
			//ln_smtp.of_csd_Addcc_unico(trim(MidA(texto,1)))
			continue
		else 
			if ((ll_diferencia_pos > 0 and ll_posicion_puntoycoma <> 0) or ( ll_diferencia_pos < 0 and posicion_coma = 0)) then 	
				direc=trim(MidA(texto,1,ll_posicion_puntoycoma - 1))
				texto=MidA(texto,ll_posicion_puntoycoma+1)
			else
				direc=trim(MidA(texto,1,posicion_coma - 1))
				texto=MidA(texto,posicion_coma+1)
			end if
			if ln_smtp.of_csd_AddTocc_limitado(direc,is_limite)=-1 then
				if not(ln_smtp.of_csd_enviar_datos()) then
					lista_emails+=direc+cr
				else
					ln_smtp.of_csd_AddTocc_reset()
					ln_smtp.of_csd_AddTocc_limitado(direc,is_limite)
				end if
			end if
		end if	
	loop
	texto = trim(texto)
	if ln_smtp.of_csd_AddTocc_limitado(texto,is_limite)=-1 then
		if not(ln_smtp.of_csd_enviar_datos()) then
			lista_emails+=texto+cr
		else
			ln_smtp.of_csd_AddTocc_reset()
			ln_smtp.of_csd_AddTocc_limitado(texto,is_limite)
			if not(ln_smtp.of_csd_enviar_datos()) then
				lista_emails+=texto+cr
			end if
		end if
	else
		if not(ln_smtp.of_csd_enviar_datos()) then
			lista_emails+=texto+cr
		end if
	end if
end if
ln_smtp.of_csd_AddTocc_reset()

//			ln_smtp.of_csd_Addcc_unico(direc)
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
//			ln_smtp.of_csd_Addcc_unico(direc)
//		else
//			direc=trim(MidA(texto,1))
//			ln_smtp.of_csd_Addcc_unico(direc)
//		end if
//		if not(ln_smtp.of_csd_enviar_datos()) then
//			lista_emails+=direc+cr
//		end if		
//		texto=MidA(texto,posicion_coma+1)
//	loop
//end if



// Obtenemos la lista de destinatarios con copia oculta
texto=cco_email
if Not(IsNull(texto)) and (trim(texto)<>"") then
	posicion_coma=1
	ll_posicion_puntoycoma = 1
	do while (posicion_coma<>0 or ll_posicion_puntoycoma <> 0)
		posicion_coma=PosA(texto,',')
		ll_posicion_puntoycoma= PosA(texto,';')
		ll_diferencia_pos = posicion_coma - ll_posicion_puntoycoma
	
		if ll_diferencia_pos = 0 then
			//ln_smtp.of_csd_Addbcc_unico(trim(MidA(texto,1)))
			continue
		else 
			if ((ll_diferencia_pos > 0 and ll_posicion_puntoycoma <> 0) or ( ll_diferencia_pos < 0 and posicion_coma = 0)) then 	
				direc=trim(MidA(texto,1,ll_posicion_puntoycoma - 1))
				texto=MidA(texto,ll_posicion_puntoycoma+1)
			else
				direc=trim(MidA(texto,1,posicion_coma - 1))
				texto=MidA(texto,posicion_coma+1)
			end if
			if ln_smtp.of_csd_AddTocco_limitado(direc,is_limite)=-1 then
				if not(ln_smtp.of_csd_enviar_datos()) then
					lista_emails+=direc+cr
				else
					ln_smtp.of_csd_AddTocco_reset()
					ln_smtp.of_csd_AddTocco_limitado(direc,is_limite)
				end if
			end if
		end if	
	loop
	texto = trim(texto)
	if ln_smtp.of_csd_AddTocco_limitado(texto,is_limite)=-1 then
		if not(ln_smtp.of_csd_enviar_datos()) then
			lista_emails+=texto+cr
		else
			ln_smtp.of_csd_AddTocco_reset()
			ln_smtp.of_csd_AddTocco_limitado(texto,is_limite)
			if not(ln_smtp.of_csd_enviar_datos()) then
				lista_emails+=texto+cr
			end if
		end if
	else
		if not(ln_smtp.of_csd_enviar_datos()) then
			lista_emails+=texto+cr
		end if
	end if
end if
ln_smtp.of_csd_AddTocco_reset()

//			ln_smtp.of_csd_Addbcc_unico(direc)
//		end if	
//		
//	loop
//end if

if not f_es_vacio(copia) then
	direc = trim(copia)
	ln_smtp.of_csd_Addbcc_unico(direc)
end if



// Cerrar Conexion
if ln_smtp.of_csd_cerrar_conexion() then
	f_error('+03')
//	MessageBox(g_titulo, "El mensaje fue enviado correctamente")
else
	f_error('-14')
//	MessageBox(g_titulo, "No se pudo enviar el mensaje",Exclamation!)
end if

if not(f_es_vacio(lista_emails)) then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al enviar los siguientes emails:"+cr+lista_emails)
end if

end subroutine

public function integer f_incluir_anexo_registro_salida ();datastore ds_reg_anexo
long fila
integer res
string nombre_ext,id_anexo=''


if f_es_vacio(id_registro) then
	// Si no se ha generado un nuevo registro, comprobamos que se le haya pasado un n_registro
	if f_es_vacio(n_reg_salida) then return -2
	select id_registro into :id_registro from registro where n_registro=:n_reg_salida;
	if f_es_vacio(id_registro) then return -2
end if

nombre_ext=nombre+'.pdf'


// Comprobamos si existe el fichero
select id_registro_anexo into :id_anexo from registro_anexos where id_registro=:id_registro and ruta=:nombre_ext;

// Si no existe se adjunta al registro
if f_es_vacio(id_anexo) then 
	ds_reg_anexo=create datastore
	ds_reg_anexo.dataobject='d_registros_anexos'
	ds_reg_anexo.SetTransObject(SQLCA)
	fila=ds_reg_anexo.insertrow(0)
	
	ds_reg_anexo.SetItem(fila,'id_registro_anexo',f_siguiente_numero('REGISTROS_ANEXOS',10))
	ds_reg_anexo.SetItem(fila,'id_registro',id_registro)
	ds_reg_anexo.SetItem(fila,'ruta',nombre+'.pdf')	
	ds_reg_anexo.SetItem(fila,'id_documento_modulo',id_doc_modulo)	
	res=ds_reg_anexo.update()	
else
	update registro_anexos set id_documento_modulo=:id_doc_modulo where id_registro_anexo=:id_anexo;	
end if

return res

end function

public function integer f_rellena_email_con_id_factura (string id_fact);return 1
end function

public function string f_ruta_facturas_fases ();string retorn, ls_n_registro,a$$HEX1$$f100$$ENDHEX$$o, id_fase_real,colegiado,ruta_factura
datetime f_entrada,f_factura
date fecha
string ruta_tmp
boolean 	facturadeexpediente


if not(f_es_vacio(referencia))  then  // Id_minuta
	select fases.n_registro, fases.id_fase, fases.f_entrada into :ls_n_registro, :id_fase_real, :f_entrada from fases, fases_minutas
	where fases_minutas.id_minuta = :referencia and fases_minutas.id_fase = fases.id_fase;
else // id_fase
	select n_registro, id_fase, fases.f_entrada into :ls_n_registro, :id_fase_real, :f_entrada from fases where id_fase=:referencia2;
end if

referencia_web=id_fase_real
ruta_factura=ls_n_registro

ruta_base = g_directorio_documentos_visared
ruta_relativa = string(year(date(f_entrada)))+'\'+ruta_factura+'\'

return ''

end function

public subroutine wf_rellenar_datos_sellado ();int i,clausula=0,t_clausula=0,col
string sello,colegiado,dir_windows,nombre_clausula
string activo,color,codigo,textoaux,texto,resto, ls_id_fase_real
int fin,tamtexto,tammax,diftam
datastore ds_fase

SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','archivo','')
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','tipo_via', '')
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','emplazamiento','')
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','descripcion_obra','')
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','f_abono','')
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','f_entrada','')
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','titulo','')
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','n_registro','')
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','n_expediente','')
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','fase','')

if (destino = 'T') then

	ds_fase = create datastore
	ds_fase.dataobject ='d_sellador_datosexp'
	ds_fase.settransobject(SQLCA)
		
	if not f_es_vacio(referencia2) then 	
		ds_fase.retrieve(referencia2)
	else
		select fases.id_fase into :ls_id_fase_real from fases, fases_minutas
		where fases_minutas.id_minuta = :referencia and	 fases_minutas.id_fase = fases.id_fase;
		
		ds_fase.retrieve(ls_id_fase_real)
	end if	
		
	////Datos de la fase
	SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','n_expediente',f_parseado_simbolos_xml(ds_fase.getitemstring(1,'n_expedi')))
	SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','fase',f_parseado_simbolos_xml(ds_fase.getitemstring(1,'fases_fase')))
	SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','n_registro',f_parseado_simbolos_xml(ds_fase.getitemstring(1,'fases_n_registro')))
	SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','titulo',f_parseado_simbolos_xml(ds_fase.getitemstring(1,'fases_titulo')))

	SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','f_entrada',string(ds_fase.getitemdatetime(1,'fases_f_entrada'),'dd/mm/yy'))
	SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','f_abono',string(ds_fase.getitemdatetime(1,'fases_f_abono'),'dd/mm/yy'))
	SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','descripcion_obra',f_parseado_simbolos_xml(ds_fase.getitemstring(1,'fases_titulo')))
	SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','emplazamiento',f_parseado_simbolos_xml(ds_fase.getitemstring(1,'compute_1')))
	SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','tipo_via',f_parseado_simbolos_xml(ds_fase.getitemstring(1,'fases_tipo_via_emplazamiento')))

	if not isnull(ds_fase.getitemstring(1,'fases_archivo')) then
		SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','archivo',f_parseado_simbolos_xml(ds_fase.getitemstring(1,'fases_archivo')))
	end if

end if	

//	SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','f_visado',string(idw_datos_sello.getitemdatetime(1,'f_visado'),'dd/mm/yy'))
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','f_visado',string(ist_configuracion_sello.dw_datos_firma.getitemdatetime(1,'f_visado'),'dd/mm/yy'))
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','f_hoy',string(today(),'dd/mm/yy'))	


//Directorios
//En las rutas sustituimos los signos '\' con '/' ya que Java toma el primero como s$$HEX1$$ed00$$ENDHEX$$mbolo de escape 
//y produce resultados err$$HEX1$$f300$$ENDHEX$$neos
dir_windows = f_variable_entorno("windir", "C:\WINDOWS")
//GetWindowsDirectory(dir_windows,100)
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','directorio_imagenes',f_reemplazar_cadena(g_directorio_imagenes,'\','/'))
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','directorio_windows',f_reemplazar_cadena(dir_windows,'\','/'))

//Tipo de sello
sello = ist_configuracion_sello.dw_datos_firma.getitemstring( 1, 'sello')

select descripcion into :sello from t_sello where codigo =:sello;
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','tipo_sello',sello)

// CODIGO COLEGIADOS
//Inicializamos colegiados
SetProfilestring(g_directorio_temporal + 'sello.ini','COLEGIADOS','colegiado_1','')
SetProfilestring(g_directorio_temporal + 'sello.ini','COLEGIADOS','colegiado_2','')
SetProfilestring(g_directorio_temporal + 'sello.ini','COLEGIADOS','colegiado_3','')
SetProfilestring(g_directorio_temporal + 'sello.ini','COLEGIADOS','colegiado_4','')

SetProfilestring(g_directorio_temporal + 'sello.ini','CLIENTES','cliente_1','')
SetProfilestring(g_directorio_temporal + 'sello.ini','CLIENTES','cliente_2','')

//Inicializamos textos del sello
SetProfilestring(g_directorio_temporal + 'sello.ini','CLAUSULAS','clausula_1','')
SetProfilestring(g_directorio_temporal + 'sello.ini','CLAUSULAS','clausula_2','')
SetProfilestring(g_directorio_temporal + 'sello.ini','CLAUSULAS','clausula_3','')
SetProfilestring(g_directorio_temporal + 'sello.ini','CLAUSULAS','clausula_4','')
SetProfilestring(g_directorio_temporal + 'sello.ini','CLAUSULAS','clausula_5','')
SetProfilestring(g_directorio_temporal + 'sello.ini','CLAUSULAS','clausula_6','')
SetProfilestring(g_directorio_temporal + 'sello.ini','CLAUSULAS','clausula_7','')
SetProfilestring(g_directorio_temporal + 'sello.ini','CLAUSULAS','clausula_8','')
SetProfilestring(g_directorio_temporal + 'sello.ini','CLAUSULAS','clausula_9','')
SetProfilestring(g_directorio_temporal + 'sello.ini','CLAUSULAS','clausula_10','')

//C$$HEX1$$e100$$ENDHEX$$lculamos los textos del sello
for i=1 to ist_configuracion_sello.dw_opciones_sello.rowcount() //este for recorre los textos
	activo = ist_configuracion_sello.dw_opciones_sello.getitemstring(i,'activo')
	if activo ='N' then continue
	texto = ''
	color=ist_configuracion_sello.dw_opciones_sello.getitemstring(i,'color')
	codigo=ist_configuracion_sello.dw_opciones_sello.getitemstring(i,'codigo')
	textoaux = ist_configuracion_sello.dw_opciones_sello.getitemstring(i,'texto')
	nombre_clausula = ist_configuracion_sello.dw_opciones_sello.getitemstring(i,'nombre')
	if f_es_vacio(nombre_clausula) then nombre_clausula = ''
	
	fin=0
	t_clausula++
	SetProfilestring(g_directorio_temporal + 'sello.ini','TIPO_CLAUSULAS','tclausula_'+string(t_clausula),nombre_clausula)
	do while fin=0 //este while recorre las lineas de cada texto
		clausula++
		tamtexto=LenA(textoaux)
		tammax=PosA(textoaux,"#")-1
		diftam=tamtexto - tammax
		if tammax<>-1 then
			//el texto se va a dividir
			texto=MidA(textoaux,0,tammax)
			resto=MidA(textoaux,tammax+4,diftam)
			textoaux=resto
		else
			fin=1
			texto=MidA(textoaux,0,tamtexto)
		end if
		if f_es_vacio(texto) then texto = ''
	   SetProfilestring(g_directorio_temporal + 'sello.ini','CLAUSULAS','clausula_'+string(clausula),f_parseado_simbolos_xml(texto))
	loop
	
next


destroy ds_fase	
end subroutine

public subroutine wf_sellado_con_fichero (string fichero_sello, string fichero_pdf);///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//********** funci$$HEX1$$f300$$ENDHEX$$n que se encarga de firmar documentoscon un sello que no tiene asociado fichero xml **********//
//****************** Formato de sellado de documentos utilizado por los aparejadores. ********************//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 

int i, opc, filenumber, sellado 
string extension, sobreescribir, n_registro, num_doc, pos_x, pos_y, pos_sello, ruta_sello,ls_id_fase_real, ls_mensaje_error
double tamano
u_analizador_pdf analizador_pdf

//Cambiamos el puntero (reloj)
SetPointer(Hourglass!)

u_signer lnv_sellador
lnv_sellador = create u_signer

ruta_sello = g_directorio_sellos +  fichero_sello

if (destino = 'T') then
	if not(f_es_vacio(referencia)) then 
		select fases.n_registro, fases.id_fase into :n_registro, :ls_id_fase_real from fases, fases_minutas
		where fases_minutas.id_minuta = :referencia and	fases_minutas.id_fase = fases.id_fase;
	else
		ls_id_fase_real = referencia2
		n_registro = f_dame_n_reg(ls_id_fase_real)
	end if
end if


//***************************************************************************
//					Rellenamos par$$HEX1$$e100$$ENDHEX$$metros del objeto
//***************************************************************************
lnv_sellador.i_pkcs = g_directorio_certificados

//Datos de la firma
lnv_sellador.i_nom		= nombre_cer //idw_datos_sello.getitemstring(1,'nombre')
lnv_sellador.i_razon	= razon
lnv_sellador.i_loc		= situacion

//Datos del certificado
opc = ist_configuracion_sello.dw_certificados.find('activo="S"',1,ist_configuracion_sello.dw_certificados.rowcount())  //idw_certificados.find('activo="S"',1,idw_certificados.rowcount())
if opc >0 then
	lnv_sellador.i_clave = password	
	if  ist_configuracion_sello.dw_certificados.getitemstring(opc,'tipo') = 'T' then
		lnv_sellador.i_pkcs=g_dir_aplicacion+ist_configuracion_sello.dw_certificados.getitemstring(opc,'tarjeta')
	elseif ist_configuracion_sello.dw_certificados.getitemstring(opc,'tipo') = 'N' then
		lnv_sellador.i_pkcs = 'BROWSER'
		lnv_sellador.i_clave = 'X'
		if f_es_vacio(certificado) then
			open(w_seleccion_certificado)
			certificado=Message.StringParm
			ist_configuracion_sello.dw_certificados.SetItem(opc,'navegador',certificado)
			if f_es_vacio(certificado) then 
				return
			else
				lnv_sellador.i_certid = certificado
			end if
		else
			lnv_sellador.i_certid = certificado
		end if
				
	else
		lnv_sellador.i_pkcs = g_directorio_certificados+ist_configuracion_sello.dw_certificados.getitemstring(opc,'certificado')
	end if
end if
//Datos de acceso al pdf que se generar$$HEX1$$e100$$ENDHEX$$
lnv_sellador.i_nomodify 	= (ist_configuracion_sello.dw_configuracion_sello.getitemstring(1,'nomodify')='S')
lnv_sellador.i_noaccess 	= (ist_configuracion_sello.dw_configuracion_sello.getitemstring(1,'noaccess')='S')
lnv_sellador.i_nocopy 	= (ist_configuracion_sello.dw_configuracion_sello.getitemstring(1,'nocopy')='S')
lnv_sellador.i_noprint 	= (ist_configuracion_sello.dw_configuracion_sello.getitemstring(1,'noprint')='S')
lnv_sellador.i_nohighres 	= (ist_configuracion_sello.dw_configuracion_sello.getitemstring(1,'nohighres')='S')
lnv_sellador.i_nonotes 	= (ist_configuracion_sello.dw_configuracion_sello.getitemstring(1,'nonotes')='S')
lnv_sellador.i_nofill 		= (ist_configuracion_sello.dw_configuracion_sello.getitemstring(1,'nofill')='S')
lnv_sellador.i_noassembly = (ist_configuracion_sello.dw_configuracion_sello.getitemstring(1,'noassembly')='S')

//Rutas de los sellos
lnv_sellador.i_sello		= ruta_sello
lnv_sellador.i_datos		= g_directorio_temporal+'sello.ini' //Esto hay que hacerlo parametrizable, de momento para probar se queda fijo

//Otros
lnv_sellador.i_directorio_aplicacion = g_dir_aplicacion

filenumber = FileOpen( g_directorio_temporal + 'sello.ini',LineMode!,Write!,LockWrite!,Append!)
Fileclose(filenumber)

wf_rellenar_datos_sellado()

analizador_pdf = create u_analizador_pdf
analizador_pdf.i_ancho = analizador_pdf.f_puntos_a_cm(double(f_xml_elemento(ruta_sello,'<anchura>')))
analizador_pdf.i_alto  = analizador_pdf.f_puntos_a_cm(double(f_xml_elemento(ruta_sello,'<altura>')))
analizador_pdf.i_margen_v = ist_configuracion_sello.dw_configuracion_sello.getitemnumber(1,'margen_vertical')
analizador_pdf.i_margen_h = ist_configuracion_sello.dw_configuracion_sello.getitemnumber(1,'margen_horizontal')
analizador_pdf.i_xo = ist_configuracion_sello.dw_configuracion_sello.getitemnumber(1,'x')
analizador_pdf.i_yo = ist_configuracion_sello.dw_configuracion_sello.getitemnumber(1,'y')

extension = ''
extension = ist_configuracion_sello.dw_datos_firma.getitemstring(1,'extension')


//Abrimos el fichero con los datos del sello
//Actualizamos el valor de la posici$$HEX1$$f300$$ENDHEX$$n
pos_sello = ist_configuracion_sello.dw_configuracion_sello.GetItemString(1,'posicion')
if pos_sello<>'L' then
	pos_x = f_decimal_punto(analizador_pdf.f_cm_a_puntos(ist_configuracion_sello.dw_configuracion_sello.GetItemNumber(1,'margen_vertical')))
	pos_y = f_decimal_punto(analizador_pdf.f_cm_a_puntos(ist_configuracion_sello.dw_configuracion_sello.GetItemNumber(1,'margen_horizontal')))
else
	pos_x = f_decimal_punto(analizador_pdf.f_cm_a_puntos(ist_configuracion_sello.dw_configuracion_sello.GetItemNumber(1,'x')))
	pos_y = f_decimal_punto(analizador_pdf.f_cm_a_puntos(ist_configuracion_sello.dw_configuracion_sello.GetItemNumber(1,'y')))		
end if

analizador_pdf.i_volteo = 0
	
//Calculamos las coordenadas de inicio del sello
//Rellenamos el nombre del fichero de entrada y su correspondiente fichero de salida

lnv_sellador.i_fichero_entrada 	=  fichero_pdf
lnv_sellador.i_o	= MidA(fichero_pdf,1,LenA(fichero_pdf) - 4) + extension + '.pdf'
lnv_sellador.i_err = g_dir_aplicacion+'error.txt'	
	

SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','x',pos_x)
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','y',pos_y)
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','margen',ist_configuracion_sello.dw_configuracion_sello.GetItemString(1,'posicion'))	

if (destino = 'T') then 
	num_doc=f_ps_generar_sig_num_doc_visared(ls_id_fase_real, n_registro)
	SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','referencia', num_doc)
end if	

//FIRMAMOS
sellado = lnv_sellador.of_firmar()
if sellado=1 and Not(FileExists(lnv_sellador.i_o)) then sellado=-100
if sellado<0  then
	
	ls_mensaje_error = wf_mensaje_error_sellado(sellado, fichero_pdf)
	
	ib_hay_errores_sellado = true
	
	if not(masivo) then 
		messagebox(g_titulo, ls_mensaje_error,StopSign!)
	else 
				
		if not (f_es_vacio(is_fichero_log_errores)) then 
		
			filenumber = FileOpen(is_fichero_log_errores, StreamMode!, Write!, LockWrite!, Append!)
			
			If filenumber > 0 Then
				FileWrite (filenumber, "Factura "+ f_dame_n_fact_de_id(id_factura) +": " + ls_mensaje_error + cr)	
				FileClose (filenumber)
			End If
		end if	
	end if	

	
end if 
	

SetPointer(Arrow!)

Filedelete(g_directorio_temporal+'sello.ini')

destroy analizador_pdf
end subroutine

public subroutine wf_rellenar_sentencia_proteger (ref n_firmador_pdf firmador);
// PROTEGER
firmador.f_nomodify(ist_configuracion_sello.dw_configuracion_sello.getItemString(1,'nomodify'))
firmador.f_noassembly(ist_configuracion_sello.dw_configuracion_sello.getItemString(1,'noassembly'))
firmador.f_nonotes(ist_configuracion_sello.dw_configuracion_sello.getItemString(1,'nonotes'))
firmador.f_nofill(ist_configuracion_sello.dw_configuracion_sello.getItemString(1,'nofill'))
firmador.f_nohighresolution(ist_configuracion_sello.dw_configuracion_sello.getItemString(1,'nohighres'))
firmador.f_nocopy(ist_configuracion_sello.dw_configuracion_sello.getItemString(1,'nocopy'))
firmador.f_noaccess(ist_configuracion_sello.dw_configuracion_sello.getItemString(1,'noaccess'))
firmador.f_noprint(ist_configuracion_sello.dw_configuracion_sello.getItemString(1,'noprint'))


end subroutine

public subroutine wf_sellado_sin_fichero (string fichero_pdf);//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//********** funci$$HEX1$$f300$$ENDHEX$$n que se encarga de firmar documentoscon un sello que no tiene asociado fichero xml *********//
//******************* Formato de sellado de documentos utilizado por los arquitectos. ********************//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

st_sello sello
n_firmador_pdf firmador
int i, errores, filenumber
string firma_obligatoria, extension, n_reg, ls_id_fase_real

sello.tipo = ist_configuracion_sello.dw_datos_firma.getitemstring(1,'sello')
sello.f_visado = ist_configuracion_sello.dw_datos_firma.GetItemDatetime(1,'f_visado')
sello = wf_rellena_lineas_sello(ist_configuracion_sello.dw_opciones_sello,sello)

// Establece la posicion del sello en el documento y margenes
sello = wf_rellena_configuracion_sello(ist_configuracion_sello.dw_configuracion_sello, sello)

inv_firmador = create u_firmador

	if g_sellador_certificado <> '' then
		certificado = g_directorio_certificados + g_sellador_certificado
	end if
		
	if g_sellador_password <> '' then
		password = g_sellador_password
	end if
	
	inv_firmador.i_path_certificado = certificado
	inv_firmador.i_password_certificado = password
	inv_firmador.i_nombre_firmador = nombre_cer
	inv_firmador.i_razon = razon
	inv_firmador.i_localidad = situacion
	
	if (destino = 'T') then 
		
		if not(f_es_vacio(referencia)) then 
			select fases.n_registro, fases.id_fase into :n_reg, :ls_id_fase_real from fases, fases_minutas
			where fases_minutas.id_minuta = :referencia and	fases_minutas.id_fase = fases.id_fase;

			inv_firmador.i_id_fase = ls_id_fase_real // g_st_sellado_visared_consulta.id_fase 
		else
			n_reg = f_dame_n_reg(referencia2)
			inv_firmador.i_id_fase = referencia2 
		end if
	
	end if	
	// Pasamos la sentencia de proteccion al objeto firamdor
	inv_firmador.i_sentencia = ist_configuracion_sello.sentencia_proteger
	//wf_rellenar_sentencia_proteger(inv_firmador)	
	inv_firmador.i_ownerpass = ist_configuracion_sello.dw_configuracion_sello.GetItemString(1, 'password')
	//
	inv_firmador.f_visado = ist_configuracion_sello.dw_datos_firma.getitemdatetime(1, 'f_visado')
	gnv_fichero.of_changedirectory(g_dir_aplicacion)
	
	u_analizador_pdf analizador_pdf

	analizador_pdf = create u_analizador_pdf

	extension = ''
	extension = ist_configuracion_sello.dw_datos_firma.getitemstring(1,'extension')
	
	inv_firmador.i_nombre_fichero_entrada = fichero_pdf
	inv_firmador.i_nombre_fichero_salida = MidA(fichero_pdf,1,LenA(fichero_pdf) - 4) + extension + '.pdf'
	
	inv_firmador.of_cunyar(sello)
	retorno = inv_firmador.i_retorno		
	
	if f_es_vacio(inv_firmador.i_error) and retorno > 0  then
			// of_firmar y of_proteger reciven el mismo fichero de entrada, por lo que en ambas se hace la misma comprobacion de si esta o no rotado el pdf
			// NOTA: ademas of_firmar debera comprobar si se a protegido
		 if not(f_es_vacio(ist_configuracion_sello.sentencia_proteger)) then  
		  inv_firmador.of_proteger_nt()
		 end if
		 inv_firmador.of_firmar_nt()
	end if	

	if ((not (f_es_vacio(inv_firmador.i_error))) or (retorno < 0)) then
		
		ib_hay_errores_sellado = true
		
		if not (masivo) then 
			messagebox(g_titulo,inv_firmador.i_error + " " + fichero_pdf + cr  ,StopSign!)
		
		else
			
			if not (f_es_vacio(is_fichero_log_errores)) then 
		
			filenumber = FileOpen(is_fichero_log_errores, StreamMode!, Write!, LockWrite!, Append!)
			
			If filenumber > 0 Then
				FileWrite (filenumber, "Factura "+ f_dame_n_fact_de_id(id_factura) +": " + inv_firmador.i_error + " " + fichero_pdf + cr)	
				FileClose (filenumber)
			End If
		end if	
			
		end if	
	else 
		f_actualizar_campo_firmado (id_factura, 'S')
	end if 	
	
	destroy inv_firmador
	destroy analizador_pdf
	

	
//end if
end subroutine

public function st_sello wf_rellena_lineas_sello (datastore dw_2, st_sello sello);//////////////////////////////////////
//////////////////////////////////////
//Esta funcion divide las lineas de texto 
//cuando se llega a una marca especial 
//definida por ### en la base de datos
//////////////////////////////////////
//////////////////////////////////////

int i,j,k,tammax,tamtexto,num,contador,l,fin,diftam
string color,activo,texto,textoaux,resto,codigo

contador=1
//Rellenamos las lineas de texto
for i=1 to dw_2.rowcount()
	activo = dw_2.getitemstring(i,'activo')
	if activo ='N' then continue
	color=dw_2.getitemstring(i,'color')
	codigo=dw_2.getitemstring(i,'codigo')
	//texto = dw_2.getitemstring(i,'texto')
	textoaux = dw_2.getitemstring(i,'texto')
	fin=0
	do while fin=0 
		tamtexto=LenA(textoaux)
		tammax=PosA(textoaux,"#")-1
		diftam=tamtexto - tammax
		//num=int(tamtexto/tammax)
		if tammax<>-1 then
			//messagebox(g_titulo,"El texto "+string(i) + " no cabe en una linea y se va a dividir.")
			texto=MidA(textoaux,0,tammax)
			resto=MidA(textoaux,tammax+4,diftam)
			textoaux=resto
		else
			fin=1
			texto=MidA(textoaux,0,tamtexto)
		end if
	choose case contador
		case 1
			sello.texto1 = texto
			sello.color1=color
			sello.codigo1=codigo
			contador++
		case 2
			sello.texto2 = texto
			sello.color2=color
			sello.codigo2=codigo
			contador++
		case 3
			sello.texto3 = texto
			sello.color3=color
			sello.codigo3=codigo
			contador++
		case 4
			sello.texto4 = texto
			sello.color4=color
			sello.codigo4=codigo
			contador++
		case 5
			sello.texto5 = texto
			sello.color5=color
			sello.codigo5=codigo
			contador++
	end choose
	loop
next




return sello
end function

public function st_sello wf_rellena_configuracion_sello (datastore as_dw, st_sello sello);// Establecemos los parametros de configuracion avanzada del sello: 
//  - posicion en el documento (pdf, doc, ...)
//  - margen 
//  - posicion libre, en el caso de no escoger entre SI, SD, ID, II 

sello.posicion = as_dw.GetItemString(1, 'posicion')

if sello.posicion = "L" then 
 sello.x = as_dw.GetItemDecimal(1, 'x')
 sello.y = as_dw.GetItemDecimal(1, 'y')
else
 as_dw.SetItem(1,'x',"")
 as_dw.SetItem(1,'y',"")
end if

sello.margen_v = as_dw.GetItemDecimal(1, 'margen_vertical')
sello.margen_h = as_dw.GetItemDecimal(1, 'margen_horizontal')

return sello
end function

public function string wf_mensaje_error_sellado (integer codigo, string fichero);string incidencia

choose case codigo
	case -1
		incidencia = 'Error al cargar el fichero "'+fichero+'". Puede que no se encuentre el fichero o que est$$HEX2$$e9002000$$ENDHEX$$defectuoso.'
	case -2
		incidencia = 'Error al abrir el certificado de firma '
	case -3,-6
		incidencia = 'Error al firmar con el certificado activo'
	case -4
		incidencia = 'Error al cerrar el certificado de firma '
	case -5
		incidencia = 'Error al cargar el certificado de firma. Compruebe que la contrase$$HEX1$$f100$$ENDHEX$$a del certificado es correcta. '
	case -7
		incidencia = 'Error al guardar el fichero. Compruebe que tiene permisos y que el disco no este protegido contra escritura.'
	case -8
		incidencia = 'Error al encriptar el fichero pdf'
	case -9
		incidencia = 'Error al sellar el fichero pdf'
	case -12
		incidencia = 'Error. El certificado del colegio que ha seleccionado est$$HEX2$$e1002000$$ENDHEX$$caducada.'		
	case -13
		incidencia = 'Error. El certificado del colegio que ha seleccionado todav$$HEX1$$ed00$$ENDHEX$$a no est$$HEX2$$e1002000$$ENDHEX$$vigente'
	case -15
		incidencia = 'Error. Debe seleccionar un certificado del navegador o bien seleccionar otro tipo de certificado en la pesta$$HEX1$$f100$$ENDHEX$$a CERTIFICADOS'				
	case -91
		incidencia = 'Ha seleccionado una combinaci$$HEX1$$f300$$ENDHEX$$n de encriptaci$$HEX1$$f300$$ENDHEX$$n incorrecta.'+cr+'Revise permisos en la pesta$$HEX1$$f100$$ENDHEX$$a de Opciones Avanzadas'
	case -92
		incidencia = 'El fichero de entrada NO es correcto'
	case -93
		incidencia = 'No se encontro el fichero firmasPDF/signerPDF. Compruebe que la ruta de la aplicaci$$HEX1$$f300$$ENDHEX$$n es correcta en el sica.ini'
	case -94
		incidencia = 'FirmasPDF no genero el archivo de intercambio. No se pueden verificar las firmas.'
	case -95
		incidencia = 'El PDF est$$HEX2$$e1002000$$ENDHEX$$encriptado. No se pudo obtener los datos de los certificados.'	
	case -99
		incidencia = 'Proceso interrumpido por el usuario.'
	case -100
		incidencia = 'Error al sellar '+fichero+'. SignerPDF no pudo procesar el archivo'
	case -200
		incidencia = 'Imposible firmar documento. Se necesita la Maquina Virtual de Java 1.4 o superior'

end choose

if f_es_vacio(incidencia) then 
	incidencia = 'Ha habido problemas durante el sellado del fichero ' + fichero + cr + '. No se ha podido determinar el error'
end if	

return incidencia

end function

public function string f_obtener_referencia_web ();string id_fase_real

if not(f_es_vacio(referencia))  then  // ID_FASE
	select  fases.id_fase into :id_fase_real from fases, fases_minutas where fases_minutas.id_minuta = :referencia and fases_minutas.id_fase = fases.id_fase;
else // ID_MINUTA
	select id_fase into :id_fase_real from fases where id_fase=:referencia2;
end if
if not f_es_vacio(id_fase_real) then referencia_web=id_fase_real

Return id_fase_real
end function

public function boolean wf_vincular_factura_a_fase ();if f_es_vacio(id_factura) then return false

string ls_id_fase, ls_id_minuta

// Comprobamos si dispone de id_fase (Que se guarda en el campo id_minuta)
select id_minuta into :ls_id_fase
from csi_facturas_emitidas 
where id_factura = :id_factura;

if not f_es_vacio(ls_id_fase) then 
	referencia2 = ls_id_fase
	return true
end if	

// Comprobamos si dispone de id_minuta (Que se guarda en el campo id_fase)
select id_fase into :ls_id_minuta
from csi_facturas_emitidas 
where id_factura = :id_factura;

if not f_es_vacio(ls_id_minuta) then 
	referencia = ls_id_minuta
	return true
end if

return false
end function

on n_csd_impresion_formato.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_csd_impresion_formato.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;string impresora2,ruta_docuprinter
int ret,resp

ids_documentos_web = create datastore
ids_documentos_web.dataobject = 'd_sellador_documentos'
ids_documentos_web.SetTransObject(SQLCA)

resp = RegistryGet( is_ruta_registro_docuprinter,"Path", RegString!, ruta_docuprinter)
if f_es_vacio(ruta_docuprinter) then is_ruta_registro_docuprinter = "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Neevia\Neevia docuPrinter"
 	
//Establecer parametros de Neevia
ret += RegistrySet( is_ruta_registro_docuprinter,"UseMask", ReguLong!, 1) 
ret += RegistrySet( is_ruta_registro_docuprinter,"FileMask", RegString!, pdf +'.pdf')
ret += RegistrySet( is_ruta_registro_docuprinter,"PDFOutputPath", RegString!,ruta_docuprinter)
ret += RegistrySet( is_ruta_registro_docuprinter,"OutputFile", RegString!, pdf+'.pdf')
ret += RegistrySet( is_ruta_registro_docuprinter,"OutputType", ReguLong!, 1)


if ret <> 6 then
	return -1  //No tiene instalado el m$$HEX1$$f300$$ENDHEX$$dulo de conversi$$HEX1$$f300$$ENDHEX$$n a PDF
end if

ib_hay_errores_sellado = false


end event

event destructor;int ret

ret += RegistrySet(is_ruta_registro_docuprinter,"UseMask", ReguLong!, 0) 
ret += RegistrySet(is_ruta_registro_docuprinter,"FileMask", RegString!, '')
ret += RegistrySet(is_ruta_registro_docuprinter,"PDFOutputPath", RegString!,'')
ret += RegistrySet(is_ruta_registro_docuprinter,"OutputFile", RegString!, '')
ret += RegistrySet(is_ruta_registro_docuprinter,"OutputType", ReguLong!,0)

destroy(ids_documentos_web)
end event

