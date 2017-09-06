HA$PBExportHeader$n_cst_aplic_appmanager.sru
forward
global type n_cst_aplic_appmanager from n_cst_appmanager
end type
end forward

global type n_cst_aplic_appmanager from n_cst_appmanager
event log_message ( string as_cebecera,  string as_message )
end type
global n_cst_aplic_appmanager n_cst_aplic_appmanager

type variables
// T$$HEX1$$ed00$$ENDHEX$$tulo de la aplicaci$$HEX1$$f300$$ENDHEX$$n

String Is_Title

n_cst_debug inv_logger
end variables

forward prototypes
public function integer of_setlogger (boolean ab_switch)
public subroutine of_logmessage (integer as_tipo_log, string as_titulo, string as_message)
end prototypes

event log_message(string as_cebecera, string as_message);If isvalid(gnv_app.inv_debug) Then
	gnv_app.inv_debug.inv_sqlspy.of_sqlsyntax( as_cebecera ,as_message, false)
end if 	
end event

public function integer of_setlogger (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetLogger
//
//	Access:  		public
//
//	Arguments:
//	ab_switch		True - start (create) the service,
//						False - stop (destroy) the service
//
//	Returns:  		Integer
//						 1 - Successful operation.
//						 0 - No action taken.
//						-1 - An error was encountered.
//						
//	Description:  	Starts or stops the Debug Service.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

//Check arguments
If IsNull(ab_switch) Then
	Return -1
End If

IF ab_Switch THEN
	IF IsNull(inv_logger) Or Not IsValid (inv_logger) THEN
		inv_logger = CREATE n_cst_debug
		Return 1
	END IF
ELSE
	IF IsValid (inv_logger) THEN
		DESTROY inv_logger
		Return 1
	END IF	
END IF

Return 0
end function

public subroutine of_logmessage (integer as_tipo_log, string as_titulo, string as_message);//##################################################################################################
// Function: of_logmessage
//
// Parametres:
// - as_tipo_log: 1 = Error 
// - as_titulo: title, module...
// - as_message: Message to log
//##################################################################################################

string ls_mensaje

If isvalid(gnv_app.inv_logger) Then
	choose case as_tipo_log
		case 1		
			ls_mensaje = "ERROR: SICA_logger "+ g_colegio +" - user: "+ g_usuario +". "+ as_titulo +". "+ as_message + CR
			gnv_app.inv_logger.inv_sqlspy.of_sqlsyntax( as_titulo, ls_mensaje, false)
		case else
			ls_mensaje = "SICA_logger "+ g_colegio +" - user: "+ g_usuario +". "+ as_titulo+". "+ as_message + CR
			gnv_app.inv_logger.inv_sqlspy.of_sqlsyntax( as_titulo, ls_mensaje, false)
	end choose		
end if 
end subroutine

on n_cst_aplic_appmanager.create
call super::create
end on

on n_cst_aplic_appmanager.destroy
call super::destroy
end on

event constructor;call super::constructor;////////////////////////////////////////////////////////////////////////
// Evento Constructor
// El siguiente codigo configura el entorno de ejecucion de la aplicaci$$HEX1$$f300$$ENDHEX$$n
//  
// Nota: Las Lineas que empiezan por //@@@ son las lineas que se deben
//       de modificar, el resto se mantendran igual
//
////////////////////////////////////////////////////////////////////////

//Nombre del fichero de configuracion .INI asociado a la aplicacion
 this.of_SetAppIniFile ("sica.ini")

//Nombre del fichero de ayuda .HLP asociado a la aplicacion
 this.of_SetHelpFile ("sica.hlp")

//Logotipo asociado a la aplicaci$$HEX1$$f300$$ENDHEX$$n
 this.of_SetLogo ("logosica.jpg")

//Empresa Desarrolladora (nosotros)
this.of_SetCopyright("             ")
this.of_setversion  ("     SICAP 9.09.00   29/05/2017")

end event

event pfc_open;call super::pfc_open;////////////////////////////////////////////////////////////////////////
// Evento Open
//
// Ultima Revisi$$HEX1$$f300$$ENDHEX$$n 13/05/1999
////////////////////////////////////////////////////////////////////////
//
// El siguiente codigo, abre la ventana principal de la aplicacion
//  
// Nota: Las Lineas que empiezan por //@@@ son las lineas que se deben
//       de modificar, el resto se mantendran igual
//
////////////////////////////////////////////////////////////////////////

//Declaracion de Variables
String ls_inifile,mensaje, ls_log_file
string params[]
int li_result
  
//Me conecto con la Base de datos General//////

// Recupero el nombre del fichero .INI
   ls_inifile = gnv_app.of_GetAppInifile()



// Inicio los valores necesarios para la conexi$$HEX1$$f300$$ENDHEX$$n
   If SQLCA.of_init(ls_inifile,"Database") = -1 then
		//Database es el nombre de la secci$$HEX1$$f300$$ENDHEX$$n de base de datos en "conta.ini"
      // MessageBox(g_titulo, "La conexi$$HEX1$$f300$$ENDHEX$$n ha fallado con el fichero "+ ls_inifile,StopSign!)
		mensaje = "La conexi$$HEX1$$f300$$ENDHEX$$n ha fallado con el fichero "+ ls_inifile + CR + SQLCA.SQLErrText
		if g_usar_idioma = "S" then
			params[1] = ls_inifile
			params[2] = SQLCA.SQLErrText
			mensaje = "La conexi$$HEX1$$f300$$ENDHEX$$n ha fallado con el fichero %s"+ CR + '%s'
			mensaje = g_idioma.of_getmsg( "general.error_conexion_bd",params, mensaje)
		end if
		 MessageBox(g_titulo, mensaje ,StopSign!)		 
		 Halt
   end if
// Efectuo la conexi$$HEX1$$f300$$ENDHEX$$n
   IF sqlca.of_connect() = -1 then
      //MessageBox(g_titulo, "La conexi$$HEX1$$f300$$ENDHEX$$n con la Base de Datos ha fallado ",StopSign!)	
		mensaje = "La conexi$$HEX1$$f300$$ENDHEX$$n ha fallado con el fichero "+ ls_inifile + CR + SQLCA.SQLErrText
		if g_usar_idioma = "S" then
			params[1] = ls_inifile
			params[2] = SQLCA.SQLErrText
			mensaje = "La conexi$$HEX1$$f300$$ENDHEX$$n ha fallado con el fichero %s"+ CR + '%s'
			mensaje = g_idioma.of_getmsg( "general.error_conexion_bd",params, mensaje)
		end if
		 MessageBox(g_titulo, mensaje ,StopSign!)		 	   
		 Halt
   end if	 

// Inicializa vbles. leyendo de
//				la tabla var_globales
//				del INI			
	f_inicializar_var_globales()
	
	//////////////////// Control activaci$$HEX1$$f300$$ENDHEX$$n logSQLs //////////////////// 
string ls_deb
ls_deb=ProfileString(ls_inifile,'Aplicacion','ModoDebug','0')

if ls_deb='1' then
	// Activar el servicio de debug
	gnv_app.of_SetDebug(TRUE)
	
	// Activar el esp$$HEX1$$ed00$$ENDHEX$$a de SQLs
	gnv_app.inv_debug.of_SetSQLSpy(TRUE)
	// Especificar que la ventana de SQLs estar$$HEX2$$e1002000$$ENDHEX$$siempre en plano superior
	gnv_app.inv_debug.inv_sqlspy.of_SetAlwaysOnTop(TRUE)
	// Abrir la ventana para visualizar las consultas a la base de datos		
	gnv_app.inv_debug.inv_sqlspy.of_OpenSQLSpy(TRUE)
	/// Especificar el fichero log d$$HEX1$$f300$$ENDHEX$$nde se grabar$$HEX1$$e100$$ENDHEX$$n las consultas a la base de datos
	gnv_app.inv_debug.inv_sqlspy.of_SetLogFile ('c:\sica_log.txt')
else 
	// Si no estamos en modo debug, es decir, estamos en producci$$HEX1$$f300$$ENDHEX$$n, comprobamos si tenemos una ruta configurada para el fichero de log.
	ls_log_file = ProfileString(ls_inifile,'configuracion','Ruta_fichero_logs','')
	
	if not f_es_vacio(ls_log_file) then 
		// Activar el servicio de debug
		li_result = gnv_app.of_SetLogger(TRUE)
		if li_result = 1 then 
			gnv_app.inv_logger.of_SetSQLSpy(TRUE)
			/// Especificar el fichero log d$$HEX1$$f300$$ENDHEX$$nde se grabar$$HEX1$$e100$$ENDHEX$$n las consultas a la base de datos
			gnv_app.inv_logger.inv_sqlspy.of_SetLogFile (ls_log_file)
		end if 	
	end if 
	
end if

////////////////////// Fin activaci$$HEX1$$f300$$ENDHEX$$n logSQLs//////////////////// 
	
	
// Inicializa vbles. leyendo de la tabla asociada al programa de Contabilidad
//						(tabla csi_param_sigescon)
	f_obtener_datos_parametrizacion()

//Multiempresa
if g_activa_multiempresa = 'S' then
	f_obtener_datos_empresa()
end if
iapp_object.DisplayName = g_titulo_aplicacion

//Utiliza Idioma
string idioma
g_usar_idioma = ProfileString(ls_inifile, "Idiomas", "Traduccion", "N")
g_idioma = create u_csd_idiomas
gnv_string = create u_csd_string

if g_usar_idioma = "S" then
	idioma = ProfileString(ls_inifile, "Idiomas", "Idioma", "ca")
	g_idioma.ib_bd = TRUE
	g_idioma.of_setdataobject( 'd_idiomas_aux_idiomas')
	g_idioma.of_setidioma( idioma)	
end if


//if(right(lower(sqlca.database),3) = 'pru') then g_pruebas = true
// g_titulo es una variable global de tipo string.
// Se utilizar$$HEX2$$e1002000$$ENDHEX$$en todas las llamadas a messagebox()
g_titulo = g_titulo_aplicacion	



//if g_pruebas then g_titulo += ' ' + '[PRUEBAS]'

//string texto_copyright, coaat
//select texto into :coaat from var_globales where nombre='COLEGIO'; 
//texto_copyright = "     CSD S.A." + cr + cr + "  " + "Licencia N$$HEX1$$ba00$$ENDHEX$$: 2007-455-S-" + coaat
//this.of_SetCopyright(texto_copyright)

//Abrimos la ventana Inicial de la aplicacion
if f_logon() = 0 then OPEN(w_aplic_frame)



end event

event pfc_logon;call super::pfc_logon;//////////////////////////////////////////////////////////////////////////
//// Evento PFC_LOGON
////
//// Ultima Revisi$$HEX1$$f300$$ENDHEX$$n 13/05/1999
//////////////////////////////////////////////////////////////////////////
////
//// El siguiente codigo efectua la conexion a la base de datos y comprueba
//// El Usuario y el Password introducido
////
//// Los valores que devuelve este evento son:
////  
////   1 .- Si la conexi$$HEX1$$f300$$ENDHEX$$n con la base de datos se ha producido con exito 
////  -1 .- Si se ha producido un error en la conexi$$HEX1$$f300$$ENDHEX$$n con la base de datos
////  
//////////////////////////////////////////////////////////////////////////
//
//
//
//Integer li_return
//String ls_inifile
//
//// Cambiamos el puntero del mouse
//   SetPointer(HourGlass!)
//
//// Recupero el nombre del fichero .INI
//   ls_inifile = gnv_app.of_GetAppInifile()
//
//// Inicio los valores necesarios para la conexi$$HEX1$$f300$$ENDHEX$$n
//   If SQLCA.of_init(ls_inifile,"Database") = -1 then
//		//Database es el nombre de la secci$$HEX1$$f300$$ENDHEX$$n de base de datos en "conta.ini"
//       MessageBox(g_titulo, "La conexi$$HEX1$$f300$$ENDHEX$$n a fallado con el fichero "+ ls_inifile,StopSign!)
//		 return -1
//   end if
//
//// Recupero el login y el password para hacer la conexi$$HEX1$$f300$$ENDHEX$$n 
//   sqlca.LogID = as_userid
//   sqlca.LogPass = as_password
//	
//// Efectuo la conexi$$HEX1$$f300$$ENDHEX$$n
//   IF sqlca.of_connect() = -1 then
//	   return -1
//   else
//	   gnv_app.of_setuserId(as_userid)
	   return 1
//   end if	 
//	
end event

event pfc_close;call super::pfc_close;// Borramos el directorio temporal creado
if not f_es_vacio(g_directorio_temporal) then
	n_cst_filesrvwin32 dire
	dire = create n_cst_filesrvwin32
	dire.of_deltree(g_directorio_temporal)
	destroy dire
	g_directorio_temporal = ""
end if
end event

