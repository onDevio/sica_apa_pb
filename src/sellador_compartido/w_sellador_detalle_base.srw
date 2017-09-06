HA$PBExportHeader$w_sellador_detalle_base.srw
forward
global type w_sellador_detalle_base from w_csd_sheet
end type
type dw_fase from u_dw within w_sellador_detalle_base
end type
type gb_opciones from groupbox within w_sellador_detalle_base
end type
type tab_dir from tab within w_sellador_detalle_base
end type
type tabpage_tv from userobject within tab_dir
end type
type dw_docs from u_dw within tabpage_tv
end type
type tabpage_tv from userobject within tab_dir
dw_docs dw_docs
end type
type tabpage_1 from userobject within tab_dir
end type
type dw_pos_sellos from u_dw within tabpage_1
end type
type dw_opciones_sello from u_dw within tabpage_1
end type
type dw_datos_firma from u_dw within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type gb_3 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_dir
dw_pos_sellos dw_pos_sellos
dw_opciones_sello dw_opciones_sello
dw_datos_firma dw_datos_firma
gb_1 gb_1
gb_3 gb_3
end type
type tabpage_2 from userobject within tab_dir
end type
type cb_anyadir_certificado from commandbutton within tabpage_2
end type
type dw_certificados from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_dir
cb_anyadir_certificado cb_anyadir_certificado
dw_certificados dw_certificados
end type
type tabpage_3 from userobject within tab_dir
end type
type dw_configuracion_sello from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_dir
dw_configuracion_sello dw_configuracion_sello
end type
type tabpage_4 from userobject within tab_dir
end type
type dw_incidencias from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_dir
dw_incidencias dw_incidencias
end type
type tab_dir from tab within w_sellador_detalle_base
tabpage_tv tabpage_tv
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
type dw_opciones from u_dw within w_sellador_detalle_base
end type
type st_imagen_no_disponible from statictext within w_sellador_detalle_base
end type
type ole_visor_pdf from olecustomcontrol within w_sellador_detalle_base
end type
type p_minist from u_p within w_sellador_detalle_base
end type
type st_rotacion from statictext within w_sellador_detalle_base
end type
type cb_voltear_pdf from commandbutton within w_sellador_detalle_base
end type
type gb_rotacion from groupbox within w_sellador_detalle_base
end type
type sle_certificado from singlelineedit within w_sellador_detalle_base
end type
type st_estado_sellado from u_st within w_sellador_detalle_base
end type
type sle_dir from singlelineedit within w_sellador_detalle_base
end type
type gb_estado_sellado from groupbox within w_sellador_detalle_base
end type
type gb_dir from groupbox within w_sellador_detalle_base
end type
type gb_certificado from groupbox within w_sellador_detalle_base
end type
end forward

global type w_sellador_detalle_base from w_csd_sheet
integer width = 3547
integer height = 2468
string title = "Gesti$$HEX1$$f300$$ENDHEX$$n de Documentaci$$HEX1$$f300$$ENDHEX$$n Colegial"
string menuname = "m_sellador"
windowstate windowstate = maximized!
event type integer csd_comprobacion_datos ( )
event csd_visa_ficheros ( )
event type string csd_sellar_lista_ficheros ( st_sello sello )
event csd_notificar_sellado_por_email ( )
event csd_generar_zip ( string documento )
event csd_actualiza_n_documentos ( )
event csd_visa_ficheros_avanzado ( string fichero )
event csd_insertar_zip_en_lista ( )
event csd_datos_configuracion_sello ( )
event csd_coordenadas_fichero ( )
event csd_boton_refrescar ( )
event csd_boton_firmar ( )
event csd_boton_abrir ( )
event csd_boton_anyadir ( )
event csd_boton_correo ( )
event csd_boton_importar_zip ( )
event csd_boton_vista_previa ( )
event csd_enviar_otra_fase ( string id_fase )
event type string csd_sella_lista_sin_firma ( st_sello sello )
event type integer csd_comprobacion_datos_sin_firma ( )
event csd_generar_xml ( )
event csd_integridad ( )
event csd_editar ( )
event csd_generar_zip_completo ( )
dw_fase dw_fase
gb_opciones gb_opciones
tab_dir tab_dir
dw_opciones dw_opciones
st_imagen_no_disponible st_imagen_no_disponible
ole_visor_pdf ole_visor_pdf
p_minist p_minist
st_rotacion st_rotacion
cb_voltear_pdf cb_voltear_pdf
gb_rotacion gb_rotacion
sle_certificado sle_certificado
st_estado_sellado st_estado_sellado
sle_dir sle_dir
gb_estado_sellado gb_estado_sellado
gb_dir gb_dir
gb_certificado gb_certificado
end type
global w_sellador_detalle_base w_sellador_detalle_base

type prototypes
SUBROUTINE Sleep(ulong milli) LIBRARY "Kernel32.dll"

end prototypes

type variables
Long  il_Row, il_RootItem
Boolean  ib_Cancel
string i_sentencia_proteger, i_sentencia_firmar

String certificado_id
String		is_CurrDir

u_firmador inv_firmador

u_dw idw_docs, idw_datos_sello, idw_certificados
u_dw idw_opciones_sello, idw_configuracion_sello, idw_incidencias, idw_posiciones_sello


string i_id_fase


// Para capturar errores del objeto ole_visor_pdf
boolean i_capturar_errores_ole = true
boolean i_error_ole = false

// Para enviar un mail de notificaci$$HEX1$$f300$$ENDHEX$$n al colegiado tras haber sellado la documentaci$$HEX1$$f300$$ENDHEX$$n
string i_ficheros_firmados[],i_ficheros_sellados[]
string i_mensaje_notificar_sellado // Texto del mensaje que se incluye en el mail de notificaci$$HEX1$$f300$$ENDHEX$$n

//m_sellador_grabar_datos menu

boolean i_generar_xml_alfresco=false
string is_id_fichero
end variables

forward prototypes
public function string f_password ()
public function integer if_localiza_fichero (string fichero)
public function string f_nombre_fichero (string fichero)
public function string wf_ficheros_firmados ()
public function string wf_nombre_fichero_firmado (string nombre_fichero)
public subroutine f_actualiza_vista_previa (integer fila)
public function integer f_pdf_vista_previa (string fichero_pdf)
public subroutine wf_insertar_fichero (string fichero)
public subroutine wf_anyadir_menu_grabar_datos (ref m_dw am_dw, u_dw dw_padre)
public subroutine f_actualiza_num_documentos ()
public function integer f_incidencia (integer codigo, integer fila_documento)
end prototypes

event type integer csd_comprobacion_datos();//Comprueba que exista fecha de visado
datetime f_visado
string n_registro
string nombre,situacion,razon,certificado,password,extension,orden,mensaje
integer retorno
decimal x1, y1
n_firmador_pdf firmador
string nulo
boolean lbo_certificado_activo
int i

if idw_certificados.rowcount()=0 and g_sellador_certificado = '' then
	Messagebox(g_titulo,'NO se ha inclu$$HEX1$$ed00$$ENDHEX$$do ning$$HEX1$$fa00$$ENDHEX$$n certificado v$$HEX1$$e100$$ENDHEX$$lido para firmar el documento.Revise la pesta$$HEX1$$f100$$ENDHEX$$a "Certificados" o inicie Sesi$$HEX1$$f300$$ENDHEX$$n.',StopSign!)
	return (-1)
end if

	
if dw_fase.rowcount()= 0 then
	Messagebox(g_titulo,'Los datos de la Fase NO son correctos. Asegurese de que han sido actualizados.',StopSign!)
	return (-1)
end if

f_visado = dw_fase.GetItemDatetime(1,'f_visado')
n_registro = dw_fase.GetItemString(1,'fases_n_registro')

if f_es_vacio(n_registro) then
	MessageBox(g_titulo,'El N$$HEX2$$ba002000$$ENDHEX$$de Registro no est$$HEX2$$e1002000$$ENDHEX$$especificado'+cr +'Asegurese de que han sido actualizados los datos de la fase.',StopSign!)
	return (-1)
end if

if IsNull(f_visado) and g_f_abono_es_visado='N' then 
	MessageBox(g_titulo,'La Fase NO tiene fecha de Visado. NO se podr$$HEX2$$e1002000$$ENDHEX$$sellar la fase hasta que la fase est$$HEX2$$e9002000$$ENDHEX$$visada.',Information!)
	return -1
end if		

idw_certificados.sort()
orden = '0'

//Obtenemos el certificado a usar
lbo_certificado_activo = false
for i = 1 to idw_certificados.rowcount()
	if idw_certificados.getitemstring(i,'activo') = 'S' then 
		lbo_certificado_activo = true
		exit
	end if
next

//Si no hay certificado activo, avisamos y cancelamos el sellado
if lbo_certificado_activo = false then
	messagebox(g_titulo,'No se ha seleccionado ningun certificado, reviselo en la pesta$$HEX1$$f100$$ENDHEX$$a Firma/Certificados')
	return -1
end if

//Comprobamos que est$$HEX1$$e900$$ENDHEX$$n rellenos los datos obligatorios del sello
nombre = idw_datos_sello.getitemstring(1,'nombre')
situacion = idw_datos_sello.getitemstring(1,'situacion')
razon = idw_datos_sello.getitemstring(1,'razon')
if g_sellador_certificado = '' then
	certificado = g_directorio_certificados + idw_certificados.getitemstring(i,'certificado')
else
	certificado = g_directorio_certificados + g_sellador_certificado
end if
if g_sellador_password = '' then
	password = idw_certificados.getitemstring(i,'password')
else
	password = g_sellador_password 
end if	
extension = idw_datos_sello.getitemstring(1,'extension')
//sello.tipo = idw_datos_sello.getitemstring(1,'sello')
if idw_opciones_sello.rowcount()>0 then orden = idw_opciones_sello.getitemstring(1,'orden')

// Validaciones de Datos de Sello
if f_es_vacio(nombre) then mensaje += 'Debe especificar un nombre.' +cr
if f_es_vacio(situacion) then mensaje += 'Debe especificar una situaci$$HEX1$$f300$$ENDHEX$$n.' +cr
if f_es_vacio(razon) then mensaje += 'Debe especificar una raz$$HEX1$$f300$$ENDHEX$$n.' +cr
if  idw_certificados.GetItemString(i,'tipo')<>'N' then
	if not(fileexists(certificado)) then
		mensaje += 'Debe especificar un certificado v$$HEX1$$e100$$ENDHEX$$lido, puede seleccionarlo con el bot$$HEX1$$f300$$ENDHEX$$n de ayuda.' +cr		
	end if
	if f_es_vacio(password)  then mensaje += 'Debe especificar la contrase$$HEX1$$f100$$ENDHEX$$a del certificado.' +cr
end if
if f_es_vacio(password) and idw_certificados.GetItemString(i,'tipo')<>'N' then mensaje += 'Debe especificar la contrase$$HEX1$$f100$$ENDHEX$$a del certificado.' +cr
if f_es_vacio(orden) then mensaje += 'Debe especificar el orden del texto en el sello.' +cr


// Validaciones de Configuracion del sello
x1 = idw_configuracion_sello.GetItemDecimal(1, 'x')
y1 = idw_configuracion_sello.GetItemDecimal(1, 'y')
if idw_configuracion_sello.GetItemString(1, 'posicion') = 'L' then
 if f_es_vacio(string(x1)) or f_es_vacio(string(y1)) then mensaje += 'Debe especificar la coordenadas X e Y de la posici$$HEX1$$f300$$ENDHEX$$n libre.' +cr
end if

// Validaciones de Seguridad de Configuracion del sello
firmador = create n_firmador_pdf
i_sentencia_proteger = ''

if idw_configuracion_sello.getItemString(1,'encriptar') = "S" then 
 if f_es_vacio(idw_configuracion_sello.getItemString(1,'password')) or f_es_vacio(idw_configuracion_sello.getItemString(1,'password2')) then
  mensaje += "Debe especificar la contrase$$HEX1$$f100$$ENDHEX$$a de propietario" +cr
 end if
 
 if (idw_configuracion_sello.getItemString(1,'password') <> idw_configuracion_sello.getItemString(1,'password2')) then
  mensaje += "Las contrase$$HEX1$$f100$$ENDHEX$$as de propietario deben coincidir" +cr
 end if   
 
 //firmador.f_encriptar(idw_configuracion_sello.getItemString(1,'encriptar'))
 firmador.f_ownerpass(idw_configuracion_sello.getItemString(1,'password'))
 //firmador.f_password_lectura(idw_configuracion_sello.getItemString(1,'encriptar'),idw_configuracion_sello.getItemString(1,'password'))
end if	

if idw_configuracion_sello.getItemString(1,'habilitar_userpass') = "S" then
 if f_es_vacio(idw_configuracion_sello.getItemString(1,'userpass')) or f_es_vacio(idw_configuracion_sello.getItemString(1,'userpass2')) then
  mensaje += "Debe especificar la contrase$$HEX1$$f100$$ENDHEX$$a de usuario" +cr
 end if
 
 if (idw_configuracion_sello.getItemString(1,'userpass') <> idw_configuracion_sello.getItemString(1,'userpass2')) then
  mensaje += "Las contrase$$HEX1$$f100$$ENDHEX$$as de usuario deben coincidir" +cr
 end if 
 
 firmador.f_userpass(idw_configuracion_sello.getItemString(1,'habilitar_userpass'),idw_configuracion_sello.getItemString(1,'userpass'))
end if	

if not(f_es_vacio(idw_configuracion_sello.getItemString(1,'password'))) and not(f_es_vacio(idw_configuracion_sello.getItemString(1,'userpass'))) then
 if idw_configuracion_sello.getItemString(1,'password') = idw_configuracion_sello.getItemString(1,'userpass') then
  mensaje += "Las contrase$$HEX1$$f100$$ENDHEX$$a de propietario y de usuario deben de ser distintas" +cr
 end if
end if

// PROTEGER
firmador.f_nomodify(idw_configuracion_sello.getItemString(1,'nomodify'))
firmador.f_noassembly(idw_configuracion_sello.getItemString(1,'noassembly'))
firmador.f_nonotes(idw_configuracion_sello.getItemString(1,'nonotes'))
firmador.f_nofill(idw_configuracion_sello.getItemString(1,'nofill'))
firmador.f_nohighresolution(idw_configuracion_sello.getItemString(1,'nohighres'))
firmador.f_nocopy(idw_configuracion_sello.getItemString(1,'nocopy'))
firmador.f_noaccess(idw_configuracion_sello.getItemString(1,'noaccess'))
firmador.f_noprint(idw_configuracion_sello.getItemString(1,'noprint'))

// FIRMAR
//firmador.f_certificado()

// Ahora lo pasamos el string "sentencia de seguridad" a inv_firmador,
// dentro de su vble. publica i_sentencia_proteger
i_sentencia_proteger = firmador.i_cadena_proteger
//i_sentencia_firmar   = firmador.i_cadena_firmar

destroy firmador


if mensaje <> '' then
	messagebox(g_titulo, mensaje)
	retorno =  -1
else
	retorno =  1
end if


return retorno




end event

event csd_visa_ficheros();//sobrescrito,
//necesitamos incluir la posibilidad de que selle sin firmar.
//jmcg 05/01/06


//Opci$$HEX1$$f300$$ENDHEX$$n que recoge los ficheros de una lista y los firma..
string nombre,situacion,razon,certificado,password
st_sello sello
n_firmador_pdf firmador
int i
string firma_obligatoria


sello.tipo = idw_datos_sello.getitemstring(1,'sello')
sello.f_visado = idw_datos_sello.GetItemDatetime(1,'f_visado')
sello = f_rellena_lineas_sello(idw_opciones_sello,sello)

// Establece la posicion del sello en el documento y margenes
sello = f_rellena_configuracion_sello(idw_configuracion_sello, sello)

inv_firmador = create u_firmador

if idw_configuracion_sello.GetItemString(1,'firmar_documento')='N' then

	gnv_fichero.of_changedirectory(g_dir_aplicacion)
	inv_firmador.i_id_fase = i_id_fase
	
	this.event csd_sella_lista_sin_firma(sello)

else
//sellamos y firmamos
	
	
	//Obtenemos el certificado activo
	for i = 1 to idw_certificados.rowcount()
		if idw_certificados.getitemstring(i,'activo') = 'S' then exit
	next
	
	nombre = idw_datos_sello.getitemstring(1,'nombre')
	situacion = idw_datos_sello.getitemstring(1,'situacion')
	razon = idw_datos_sello.getitemstring(1,'razon')
	if g_sellador_certificado = '' then
		certificado = g_directorio_certificados + idw_certificados.getitemstring(i,'certificado')
	else
		certificado = g_directorio_certificados + g_sellador_certificado
	end if
		
	if g_sellador_password = '' then
		password = idw_certificados.getitemstring(i,'password')
	else
		password = g_sellador_password
	end if
	
	inv_firmador.i_path_certificado = certificado
	inv_firmador.i_password_certificado = password
	inv_firmador.i_nombre_firmador = nombre
	inv_firmador.i_razon = razon
	inv_firmador.i_localidad = situacion
	inv_firmador.i_id_fase = i_id_fase // g_st_sellado_visared_consulta.id_fase 
	// Pasamos la sentencia de proteccion al objeto firamdor
	inv_firmador.i_sentencia = i_sentencia_proteger
	inv_firmador.i_ownerpass = idw_configuracion_sello.GetItemString(1, 'password')
	//
	inv_firmador.f_visado = idw_datos_sello.getitemdatetime(1, 'f_visado')
	gnv_fichero.of_changedirectory(g_dir_aplicacion)
	
	this.event csd_sellar_lista_ficheros(sello)
end if



/*//Opci$$HEX1$$f300$$ENDHEX$$n que recoge los ficheros de una lista y los firma..
string nombre,situacion,razon,certificado,password
st_sello sello
n_firmador_pdf firmador
int i

inv_firmador = create u_firmador

//Obtenemos el certificado activo
for i = 1 to idw_certificados.rowcount()
	if idw_certificados.getitemstring(i,'activo') = 'S' then exit
next

nombre = idw_datos_sello.getitemstring(1,'nombre')
situacion = idw_datos_sello.getitemstring(1,'situacion')
razon = idw_datos_sello.getitemstring(1,'razon')
if g_sellador_certificado = '' then
	certificado = g_directorio_certificados + idw_certificados.getitemstring(i,'certificado')
else
	certificado = g_directorio_certificados + g_sellador_certificado
end if
	
if g_sellador_password = '' then
	password = idw_certificados.getitemstring(i,'password')
else
	password = g_sellador_password
end if

sello.tipo = idw_datos_sello.getitemstring(1,'sello')

sello = f_rellena_lineas_sello(idw_opciones_sello,sello)

// Establece la posicion del sello en el documento y margenes
sello = f_rellena_configuracion_sello(idw_configuracion_sello, sello)

inv_firmador.i_path_certificado = certificado
inv_firmador.i_password_certificado = password
inv_firmador.i_nombre_firmador = nombre
inv_firmador.i_razon = razon
inv_firmador.i_localidad = situacion
inv_firmador.i_id_fase = i_id_fase // g_st_sellado_visared_consulta.id_fase 
// Pasamos la sentencia de proteccion al objeto firamdor
inv_firmador.i_sentencia = i_sentencia_proteger
inv_firmador.i_ownerpass = idw_configuracion_sello.GetItemString(1, 'password')

gnv_fichero.of_changedirectory(g_dir_aplicacion)

this.event csd_sellar_lista_ficheros(sello)

*/



end event

event type string csd_sellar_lista_ficheros(st_sello sello);string resultado,nombre_fichero,ruta,sobreescribir,fichero_linea, anyo
string n_reg,sellado,fecha,ver_web,fichero_origen,fichero_destino,fichero_rotado,fichero_firmado
int fila,fichero_ya_firmado_linea,i,errores=0,fila_inc,volteo, cantidad
string ver_web_defecto
integer retorno
string temp
long n = 0
int cantidad_firmar = 0, firmados, aux
string ficheros_rojos = ''
int fila_zip
string nombre_zip, fichero_zip
string fichero
double tamano
string estado_certificado
boolean fallo
u_analizador_pdf analizador_pdf

analizador_pdf = create u_analizador_pdf

idw_datos_sello.Accepttext()
sobreescribir 	= idw_datos_sello.getitemstring(1,'sobreescribir')
n_reg 			= dw_fase.getitemstring(1,'fases_n_registro')
  
fila = idw_docs.GetSelectedRow(0)
sello.dw_textos_sello = idw_opciones_sello

//Borramos los ficheros erroneos anteriores
ficheros_rojos = ''

tab_dir.tabpage_4.visible = false
idw_incidencias.Reset()

/*if g_colegio = 'COAR' then
	//Abrimos la ventana de opciones del sello
	openwithparm(w_sello_check_coar,sello)
	//Recibimos el sello con las opciones
	sello = message.powerobjectparm
	if sello.check.parcelaciones = "-2" then return '-1'
	inv_firmador.i_sello_check = 
end if*/

gb_estado_sellado.visible = true
st_estado_sellado.visible = true
//Comprobamos cuantos documentos hay que firmar

for firmados = 1 to idw_docs.rowcount()
	if idw_docs.isSelected(firmados) = true then
		cantidad_firmar ++ 
	end if
next

firmados = 1

SetPointer(HourGlass!)

do while fila>0
	yield()
	if g_interrupt then
		if MessageBox(g_titulo,"$$HEX1$$bf00$$ENDHEX$$Interrumpir el sellado?",Question!,YesNo!)=1 then
			close(w_eimporta_procesando)
			exit
		else
			g_interrupt=false
		end if
	end if	
	fallo=false
	inv_firmador.i_error = ''
	nombre_fichero = idw_docs.getitemstring(fila,'nombre_fichero')
	
	gb_estado_sellado.text = 'Firmando documento ' + string(firmados) + ' de ' + string(cantidad_firmar)
	st_estado_sellado.text = nombre_fichero
	yield()
	this.setredraw(true)
	
	firmados ++

	volteo = idw_docs.getitemnumber(fila,'volteo')
	volteo = volteo * 90
	anyo = left(idw_docs.getitemstring(fila,'ruta_fichero'),4)
	ruta = f_obtener_ruta_base(anyo) + idw_docs.getitemstring(fila,'ruta_fichero')
  	
	estado_certificado = idw_docs.getitemstring(fila,'certificado_confianza')
  
	fichero_origen = ruta + "\" + nombre_fichero
	fichero_rotado = ruta + "\" + MidA(nombre_fichero, 1 ,LenA(nombre_fichero) -4) + '_rotado' + '.PDF'	
	fichero_firmado = wf_nombre_fichero_firmado(nombre_fichero)
	fichero_destino = ruta + "\" + fichero_firmado
	 
	//Volteamos el fichero en caso de que lo haya localizado el usuario..
	IF volteo > 0 THEN 		
		analizador_pdf.f_voltea_fichero(fichero_origen,fichero_rotado,volteo)
		inv_firmador.i_nombre_fichero_entrada = fichero_rotado
		inv_firmador.i_nombre_fichero_salida = fichero_destino
		
		// of_cunyar delega en el objeto n_escritor_pdf el estampar el sello
		inv_firmador.of_cunyar(sello)		
		retorno = inv_firmador.i_retorno
		
		if f_es_vacio(inv_firmador.i_error) and retorno > 0  then
			// of_firmar y of_proteger reciven el mismo fichero de entrada, por lo que en ambas se 
			// hace la misma comprobacion de si esta o no rotado el pdf
			// NOTA: ademas of_firmar debera comprobar si se a protegido
		 if not(f_es_vacio(i_sentencia_proteger)) then  
			inv_firmador.of_proteger_nt()	 				
		 end if
   	 inv_firmador.of_firmar_nt()
		end if
		
		filedelete(fichero_rotado)  //Borramos el fichero rotado...
	ELSE
		inv_firmador.i_nombre_fichero_entrada = fichero_origen
		inv_firmador.i_nombre_fichero_salida = fichero_destino

		inv_firmador.of_cunyar(sello)
		retorno = inv_firmador.i_retorno		
		
		if f_es_vacio(inv_firmador.i_error) and retorno > 0  then
			// of_firmar y of_proteger reciven el mismo fichero de entrada, por lo que en ambas se 
			// hace la misma comprobacion de si esta o no rotado el pdf
			// NOTA: ademas of_firmar debera comprobar si se a protegido
		 if not(f_es_vacio(i_sentencia_proteger)) then  
		  inv_firmador.of_proteger_nt()
		 end if
		 inv_firmador.of_firmar_nt()
		end if		
	END IF
	if not f_es_vacio(inv_firmador.i_error) or retorno < 0 then
		fila_inc = idw_incidencias.InsertRow(0)
		//idw_incidencias.SetItem(fila_inc,'incidencia','El fichero ' + ruta+nombre_fichero+ ' NO se ha firmado correctamente')
		idw_incidencias.SetItem(fila_inc,'incidencia',inv_firmador.i_error + " " + idw_docs.getitemstring(fila,'nombre_fichero') + cr)
		errores++
		fallo=true
		//Ponemos la fila del datawindow en rojo
		if ficheros_rojos = '' then
			ficheros_rojos = "'" + idw_docs.getitemstring(fila,'id_fichero') + "'"
		else
			ficheros_rojos += ", '" + idw_docs.getitemstring(fila,'id_fichero') + "'"
		end if
		idw_docs.update()
		fila = idw_docs.GetSelectedRow(fila)
		continue
	end if
  
	if sobreescribir='N' then 
		
		//Si el registro no ha sido firmado YA se inserta un nuevo registro en la tabla
		fichero_ya_firmado_linea = 0
		for i = 1 to idw_docs.rowcount()
			fichero_linea = idw_docs.GetItemString(i,'nombre_fichero')
			if upper(fichero_linea) = upper(fichero_firmado) then
				fichero_ya_firmado_linea = i
				exit
			end if 
		next
		
		//Si no existe ya, se a$$HEX1$$f100$$ENDHEX$$ade a la base de datos
		if fichero_ya_firmado_linea = 0 then 
			idw_docs.insertrow(0)
			idw_docs.setitem(idw_docs.rowcount(),'id_fichero', f_siguiente_numero('FASES_DOCU_VISARED',10))
			idw_docs.setitem(idw_docs.rowcount(),'id_fase', i_id_fase)
			idw_docs.setitem(idw_docs.rowcount(),'nombre_fichero',fichero_firmado)
			idw_docs.setitem(idw_docs.rowcount(),'ruta_fichero', f_visared_ruta_documentos(i_id_fase,'',2))
			idw_docs.setitem(idw_docs.rowcount(),'sellado', sellado)
			idw_docs.setitem(idw_docs.rowcount(),'fecha', today())
			//Ponemos en visualizar web la opcion por defecto
			ver_web_defecto = idw_configuracion_sello.getitemstring(1,'ver_web')
			idw_docs.setitem(idw_docs.rowcount(),'visualizar_web',ver_web_defecto)	
			idw_docs.setitem(idw_docs.rowcount(),'volteo',0)	
			idw_docs.setitem(idw_docs.rowcount(),'sellado','S')
			idw_docs.setitem(idw_docs.rowcount(),'fecha_sellado',today())	
			idw_docs.setitem(idw_docs.rowcount(),'n_documento',g_st_sellado_visared_consulta.n_documento)	
			//Ponemos el tama$$HEX1$$f100$$ENDHEX$$o

			anyo = idw_docs.getitemstring(idw_docs.rowcount(),'ruta_fichero')
			fichero = f_obtener_ruta_base(anyo) + idw_docs.getitemstring(idw_docs.rowcount(),'ruta_fichero') + idw_docs.getitemstring(idw_docs.rowcount(),'nombre_fichero')
			tamano = Ceiling(gnv_fichero.of_GetFileSize(fichero) / 1024)
			idw_docs.setitem(idw_docs.rowcount(),'tamano',string(tamano,"#,###,##0") + ' Kb')
			idw_docs.setitem(idw_docs.rowcount(),'firmado','V')		
			idw_docs.setitem(idw_docs.rowcount(),'certificado_confianza',estado_certificado)					
			
			idw_docs.update()
		else
		   // Si ya estaba firmado, se modifican los datos de fecha de sellado, n$$HEX2$$ba002000$$ENDHEX$$de document y ver en web		
			idw_docs.setitem(fichero_ya_firmado_linea,'fecha_sellado',today())	
			idw_docs.setitem(fichero_ya_firmado_linea,'n_documento',g_st_sellado_visared_consulta.n_documento)	
			ver_web_defecto = idw_configuracion_sello.getitemstring(1,'ver_web')
			idw_docs.setitem(fichero_ya_firmado_linea,'visualizar_web',ver_web_defecto)
			//Ponemos el tama$$HEX1$$f100$$ENDHEX$$o (puede haber variado)
			anyo = idw_docs.getitemstring(idw_docs.rowcount(),'ruta_fichero')
			fichero = f_obtener_ruta_base(anyo) + idw_docs.getitemstring(fichero_ya_firmado_linea,'ruta_fichero') + idw_docs.getitemstring(fichero_ya_firmado_linea,'nombre_fichero')
			tamano = Ceiling(gnv_fichero.of_GetFileSize(fichero) / 1024)
			idw_docs.setitem(fichero_ya_firmado_linea,'tamano',string(tamano,"#,###,##0") + ' Kb')
			idw_docs.setitem(fichero_ya_firmado_linea,'firmado','V')		
			idw_docs.setitem(fichero_ya_firmado_linea,'certificado_confianza',estado_certificado)
			idw_docs.update()		
		end if
						
	else	//Se sobreescribe el fichero:		
		
		//Se borra el fichero original
		if not filedelete(fichero_origen) then 
			fila_inc = idw_incidencias.InsertRow(0)
			idw_incidencias.SetItem(fila_inc,'incidencia','El fichero ' + fichero_origen+ ' NO se ha firmado correctamente')
			errores++
			fallo=true
			fila = idw_docs.GetSelectedRow(fila)
			continue
		end if				
		
		//Se renombra el fichero firmado "fichero_signed" al fichero_origen
		if not gnv_fichero.of_filerename(fichero_destino, fichero_origen) = 1 then
			fila_inc = idw_incidencias.InsertRow(0)
			idw_incidencias.SetItem(fila_inc,'incidencia','El fichero ' + fichero_origen+ ' NO se ha firmado correctamente')
			errores++
			fallo=true
			fila = idw_docs.GetSelectedRow(fila)
			continue
		end if		

		//Si todo ha ido bien, comprobamos si existe en el dw.
		//idw_docs.deleterow(idw_docs.getrow())
		fichero_ya_firmado_linea=0
		for i=1 to idw_docs.rowcount()
			if upper(nombre_fichero) = upper(fichero_firmado) then
				fichero_ya_firmado_linea = i
				exit
			end if     
		next
		//Si no existe ya, se renombra a$$HEX1$$f100$$ENDHEX$$ade a la base de datos
		if fichero_ya_firmado_linea = 0 then 			
			idw_docs.setitem(fila,'nombre_fichero', nombre_fichero)
			idw_docs.setitem(fila,'sellado','S')
			idw_docs.setitem(fila,'fecha_sellado',today())	
			idw_docs.setitem(fila,'n_documento',g_st_sellado_visared_consulta.n_documento)	
			ver_web_defecto = idw_configuracion_sello.getitemstring(1,'ver_web')
			idw_docs.setitem(fila,'visualizar_web',ver_web_defecto)	
			//Ponemos el tama$$HEX1$$f100$$ENDHEX$$o
			anyo = idw_docs.getitemstring(idw_docs.rowcount(),'ruta_fichero')
			fichero = f_obtener_ruta_base(anyo) + idw_docs.getitemstring(fila,'ruta_fichero') + idw_docs.getitemstring(fila,'nombre_fichero')
			tamano = Ceiling(gnv_fichero.of_GetFileSize(fichero) / 1024)
			idw_docs.setitem(fila,'tamano',string(tamano,"#,###,##0") + ' Kb')
			idw_docs.setitem(fila,'firmado','V')
			idw_docs.setitem(fila,'certificado_confianza',estado_certificado)
			idw_docs.update()
		else
		//Si ya estaba firmado, se modifican los datos de fecha de sellado, n$$HEX2$$ba002000$$ENDHEX$$de documento	y ver en web
			idw_docs.setitem(fichero_ya_firmado_linea,'fecha_sellado',today())	
			idw_docs.setitem(fichero_ya_firmado_linea,'n_documento',g_st_sellado_visared_consulta.n_documento)	
			ver_web_defecto = idw_configuracion_sello.getitemstring(1,'ver_web')
			idw_docs.setitem(fichero_ya_firmado_linea,'visualizar_web',ver_web_defecto)
			//Ponemos el tama$$HEX1$$f100$$ENDHEX$$o (puede haber variado)
			anyo = idw_docs.getitemstring(idw_docs.rowcount(),'ruta_fichero')			
			fichero =f_obtener_ruta_base(anyo) + idw_docs.getitemstring(fichero_ya_firmado_linea,'ruta_fichero') + idw_docs.getitemstring(fichero_ya_firmado_linea,'nombre_fichero')
			tamano = Ceiling(gnv_fichero.of_GetFileSize(fichero) / 1024)
			idw_docs.setitem(fichero_ya_firmado_linea,'tamano',string(tamano,"#,###,##0") + ' Kb')
			idw_docs.setitem(fichero_ya_firmado_linea,'firmado','V')		
			idw_docs.setitem(fichero_ya_firmado_linea,'certificado_confianza',estado_certificado)
			idw_docs.update()		
		end if
	end if
	
	i_ficheros_firmados[upperbound(i_ficheros_firmados) + 1] = idw_docs.GetItemString(fila,'id_fichero')
	
	//Ya esta firmado el documento, si es correcto y esta habilitada la opcion, lo a$$HEX1$$f100$$ENDHEX$$adimos al zip
	if not(fallo) and idw_configuracion_sello.getitemstring(1,'generar_zip') = 'S' and fileexists(fichero_destino) then
		event csd_generar_zip(fichero_destino)	
	end if
	
	//Vamos a la siguiente l$$HEX1$$ed00$$ENDHEX$$nea seleccionada
	fila = idw_docs.GetSelectedRow(fila)
loop

//Hemos acabado de firmar, miramos si esta el zip, y sino lo a$$HEX1$$f100$$ENDHEX$$adimos
nombre_zip = "VISADO_" + dw_fase.getitemstring(1,'n_expedi') + "_" + dw_fase.getitemstring(1,'fases_fase') + ".zip"
fichero_zip = sle_dir.text + nombre_zip
fila_zip = idw_docs.find("nombre_fichero='" + nombre_zip + "'",1,idw_docs.rowcount())

if idw_configuracion_sello.getitemstring(1,'generar_zip')='S' then 
	if g_comfia='S' then event csd_generar_xml()
	event csd_insertar_zip_en_lista()
end if

st_estado_sellado.visible = false
gb_estado_sellado.visible = false

//close(w_eimporta_procesando)
if g_interrupt then
	f_incidencia(-99,0)
	tab_dir.tabpage_4.visible = true
	messagebox(g_titulo,'Proceso interrumpido por el usuario',StopSign!)	
	g_interrupt=false
else
	if errores = 0 then
		//	st_mensaje.text ='Proceso terminado con $$HEX1$$e900$$ENDHEX$$xito'
		f_dw_resaltar_fila(idw_docs, '','0',0)
		messagebox(g_titulo,'El / Los ficheros han sido firmados con $$HEX1$$e900$$ENDHEX$$xito',Information!)
		tab_dir.tabpage_4.visible = false
		resultado='1'
	else
		//	st_mensaje.text ='Ha habido problemas durante el proceso.Revise la lista de incidencias'
		tab_dir.tabpage_4.visible = true
		n_cst_color colores
		f_dw_resaltar_fila(idw_docs, 'id_fichero',ficheros_rojos,colores.red)
		messagebox(g_titulo,'Ha habido problemas durante el sellado de alg$$HEX1$$fa00$$ENDHEX$$n fichero. Compruebe la lista de incidencias',StopSign!)
		resultado='-1'
	end if
end if

SetPointer(Arrow!)

idw_docs.selectrow(0, false)

destroy inv_firmador
destroy analizador_pdf

return resultado


end event

event csd_notificar_sellado_por_email();long i, j, fila
string id_colegiado, mail, nombre_fichero
string texto,documentos
string mensaje,mensaje0
string array_vacio[]
string fase, n_exp
string asunto
string listadoc, texto_aviso
n_cst_string lnv_string


if upperbound(i_ficheros_firmados) = 0 then return

mensaje0 = 'A los siguientes colegiados no se les han notificado que los documentos han sido firmados por la falta de su Email:' + cr + cr	
mensaje = ''

/* Modificaci$$HEX1$$f300$$ENDHEX$$n Roberto Marco 29/03/2005 */

asunto = f_plantillas_estructura("aviso_visado.txt", "ASUNTO")
asunto = lnv_string.of_globalreplace(asunto, "~r", "") // El asunto no puede tener saltos de l$$HEX1$$ed00$$ENDHEX$$nea
asunto = lnv_string.of_globalreplace(asunto, "~n", "") // El asunto no puede tener saltos de l$$HEX1$$ed00$$ENDHEX$$nea
f_sellador_campos_plantilla_aviso_visado(asunto,i_id_fase)

texto = f_plantillas_estructura("aviso_visado.txt", "CABECERA")
if f_es_vacio(texto) then texto = "{MENSAJE}" // Con esto guardamos la compatibilidad con antiguas plantillas que no tengan la secci$$HEX1$$f300$$ENDHEX$$n de cabecera

listadoc = f_plantillas_estructura("aviso_visado.txt", "LISTA_DOCUMENTOS")

for i = 1 to upperbound(i_ficheros_firmados)
	fila = idw_docs.find("id_fichero='" + i_ficheros_firmados[i] + "'", 1, idw_docs.RowCount())
	if fila>0 then
		texto += listadoc
		nombre_fichero = idw_docs.getitemstring(fila, 'nombre_fichero')
		texto = lnv_string.of_globalreplace(texto, "{NOMBRE_DOCUMENTO}", nombre_fichero)
	end if
next

texto += f_plantillas_estructura("aviso_visado.txt", "PIE")
f_sellador_campos_plantilla_aviso_visado(texto,i_id_fase)

texto_aviso = idw_configuracion_sello.getitemstring(1, 'texto_aviso')
if isnull(texto_aviso) then texto_aviso = ''
// En el dw de opciones se guarda un mensaje que depende de la delegaci$$HEX1$$f300$$ENDHEX$$n y que puede ser modificado por el usuario
texto = lnv_string.of_globalreplace(texto, "{MENSAJE}", texto_aviso)


/* Fin Modificaci$$HEX1$$f300$$ENDHEX$$n Roberto Marco */

n_ds ds_fases_colegiados
ds_fases_colegiados = create n_ds
ds_fases_colegiados.dataobject = 'd_fases_colegiados'
ds_fases_colegiados.of_settransobject(SQLCA)
ds_fases_colegiados.retrieve(i_id_fase)

for j = 1 to ds_fases_colegiados.rowcount()
	
	id_colegiado = ds_fases_colegiados.getitemstring(j, 'id_col')
	mail = f_devuelve_mail_profesional(id_colegiado)
	
	if f_es_vacio(mail) then
		mensaje += f_colegiado(id_colegiado) + cr
	else
		f_enviar_email(asunto,texto,mail,'csd','','')
	end if

next

i_ficheros_firmados = array_vacio

if not(f_es_vacio(mensaje)) then
	messagebox(g_titulo,mensaje0+mensaje)
end if

end event

event csd_generar_zip(string documento);//Genera un fichero zip con los ficheros firmados
//En el mismo momento en que se firma un documento, este se a$$HEX1$$f100$$ENDHEX$$ade al zip
oleobject zip,files,oFile
string nombre_zip
string fichero_zip
int fila

//Creamos el zip
zip = create oleobject
zip.ConnectToNewObject("SAWZip.Archive")
//Generamos el nombre y ruta del fichero zip
nombre_zip = "VISADO_" + dw_fase.getitemstring(1,'n_expedi') + "_" + dw_fase.getitemstring(1,'fases_fase') + ".zip"
fichero_zip = sle_dir.text + nombre_zip

//Comprobamos si esta para a$$HEX1$$f100$$ENDHEX$$adirlo o crear el zip
if fileexists(fichero_zip) then
	zip.open(fichero_zip)
else
	zip.create(fichero_zip)
end if

//A$$HEX1$$f100$$ENDHEX$$adimos el fichero
Files = create oleobject
Files.ConnectToNewObject("SAWZip.Files")
Files = zip.Files

oFile = create oleobject
oFile.ConnectToNewObject("SAWZip.File")	
oFile.Name = documento
Files.Add(oFile)

//Cerramos el zip y destruimos los objetos
zip.close()

destroy zip
destroy files
destroy oFile
end event

event csd_actualiza_n_documentos();//Este evento actualiza el n$$HEX1$$fa00$$ENDHEX$$mero de documentos en el nombre de la pesta$$HEX1$$f100$$ENDHEX$$a
int cuantos

cuantos = idw_docs.rowcount()
if isnull(cuantos) then cuantos =0
tab_dir.tabpage_tv.text = 'Documentos ('+string(cuantos)+')'
end event

event csd_visa_ficheros_avanzado(string fichero);//Visado de ficheros con el nuevo objeto
int firmados,fila,sellado,cantidad_firmar=0,fila_fichero,volteo,i
string fichero_entrada,fichero_salida,ruta,extension,sobreescribir, pdf, archivo_pdf
string ficheros_rojos = '',n_registro,num_doc
string ver_web_defecto,estado_certificado,generar_zip,pos_x,pos_y, pos_sello,id_fichero
double tamano
boolean hay_errores = false
u_analizador_pdf analizador_pdf
n_cst_color colores

u_signer lnv_sellador
string fichero_sello
int opc,FILENUMBER

lnv_sellador = create u_signer

fichero_sello = g_directorio_sellos +  fichero

//***************************************************************************
//					Rellenamos par$$HEX1$$e100$$ENDHEX$$metros del objeto
//***************************************************************************
lnv_sellador.i_pkcs = g_directorio_certificados

//Datos de la firma
lnv_sellador.i_nom		= idw_datos_sello.getitemstring(1,'nombre')
lnv_sellador.i_razon	= idw_datos_sello.getitemstring(1,'razon')
lnv_sellador.i_loc		= idw_datos_sello.getitemstring(1,'situacion')

//Datos del certificado
opc =idw_certificados.find('activo="S"',1,idw_certificados.rowcount())
if opc >0 then
	lnv_sellador.i_clave = idw_certificados.getitemstring(opc,'password')	
	if  idw_certificados.getitemstring(opc,'tipo') = 'T' then
		lnv_sellador.i_pkcs=g_dir_aplicacion+idw_certificados.getitemstring(opc,'tarjeta')
	elseif idw_certificados.getitemstring(opc,'tipo') = 'N' then
		lnv_sellador.i_pkcs = 'BROWSER'
		lnv_sellador.i_clave = 'X'
		if f_es_vacio(certificado_id) then
			open(w_seleccion_certificado)
			certificado_id=Message.StringParm
			idw_certificados.SetItem(opc,'navegador',certificado_id)
			if f_es_vacio(certificado_id) then 
				f_incidencia(-15,1)
				return
			else
				lnv_sellador.i_certid = certificado_id
			end if
		else
			lnv_sellador.i_certid = certificado_id
		end if
				
	else
		lnv_sellador.i_pkcs = g_directorio_certificados+idw_certificados.getitemstring(opc,'certificado')
	end if
end if
//Datos de acceso al pdf que se generar$$HEX1$$e100$$ENDHEX$$
lnv_sellador.i_nomodify 	= (idw_configuracion_sello.getitemstring(1,'nomodify')='S')
lnv_sellador.i_noaccess 	= (idw_configuracion_sello.getitemstring(1,'noaccess')='S')
lnv_sellador.i_nocopy 		= (idw_configuracion_sello.getitemstring(1,'nocopy')='S')
lnv_sellador.i_noprint 	= (idw_configuracion_sello.getitemstring(1,'noprint')='S')
lnv_sellador.i_nohighres 	= (idw_configuracion_sello.getitemstring(1,'nohighres')='S')
lnv_sellador.i_nonotes 	= (idw_configuracion_sello.getitemstring(1,'nonotes')='S')
lnv_sellador.i_nofill 		= (idw_configuracion_sello.getitemstring(1,'nofill')='S')
lnv_sellador.i_noassembly = (idw_configuracion_sello.getitemstring(1,'noassembly')='S')

//Rutas de los sellos
lnv_sellador.i_sello		= fichero_sello
lnv_sellador.i_datos		= g_directorio_temporal+'sello.ini' //Esto hay que hacerlo parametrizable, de momento para probar se queda fijo

//Otros
lnv_sellador.i_directorio_aplicacion = g_dir_aplicacion

filenumber = FileOpen( g_directorio_temporal + 'sello.ini',LineMode!,Write!,LockWrite!,Append!)
Fileclose(filenumber)
Event csd_datos_configuracion_sello()

analizador_pdf = create u_analizador_pdf
analizador_pdf.i_ancho = analizador_pdf.f_puntos_a_cm(double(f_xml_elemento(fichero_sello,'<anchura>')))
analizador_pdf.i_alto  = analizador_pdf.f_puntos_a_cm(double(f_xml_elemento(fichero_sello,'<altura>')))
analizador_pdf.i_margen_v = idw_configuracion_sello.getitemnumber(1,'margen_vertical')
analizador_pdf.i_margen_h = idw_configuracion_sello.getitemnumber(1,'margen_horizontal')
analizador_pdf.i_xo = idw_configuracion_sello.getitemnumber(1,'x')
analizador_pdf.i_yo = idw_configuracion_sello.getitemnumber(1,'y')


extension = ''
sobreescribir 	= idw_datos_sello.getitemstring(1,'sobreescribir')
ver_web_defecto = idw_configuracion_sello.getitemstring(1,'ver_web')
generar_zip = idw_configuracion_sello.getitemstring(1,'generar_zip')
n_registro = dw_fase.getitemstring(1,'fases_n_registro')

//Ocultamos y reseteamos la pesta$$HEX1$$f100$$ENDHEX$$a de Incidencias.
tab_dir.tabpage_4.visible = false
idw_incidencias.Reset()

gb_estado_sellado.visible = true
st_estado_sellado.visible = true

//Si no se sobreescribe la extensi$$HEX1$$f300$$ENDHEX$$n tendr$$HEX2$$e1002000$$ENDHEX$$un valor...
if sobreescribir = 'N' then extension = idw_datos_sello.getitemstring(1,'extension')

for fila = 1 to idw_docs.rowcount()
	if idw_docs.isSelected(fila) = true then
		cantidad_firmar ++ 
	end if
next
//Cambiamos el puntero (reloj)
SetPointer(Hourglass!)

fila = idw_docs.GetSelectedRow(0)
firmados = 1

//Abrimos el fichero con los datos del sello
//Actualizamos el valor de la posici$$HEX1$$f300$$ENDHEX$$n
pos_sello = idw_configuracion_sello.GetItemString(1,'posicion')
if pos_sello<>'L' then
	pos_x = f_decimal_punto(analizador_pdf.f_cm_a_puntos(idw_configuracion_sello.GetItemNumber(1,'margen_vertical')))
	pos_y = f_decimal_punto(analizador_pdf.f_cm_a_puntos(idw_configuracion_sello.GetItemNumber(1,'margen_horizontal')))
else
	pos_x = f_decimal_punto(analizador_pdf.f_cm_a_puntos(idw_configuracion_sello.GetItemNumber(1,'x')))
	pos_y = f_decimal_punto(analizador_pdf.f_cm_a_puntos(idw_configuracion_sello.GetItemNumber(1,'y')))		
end if

do while fila > 0
	yield()
	if g_interrupt then
		if MessageBox(g_titulo,"$$HEX1$$bf00$$ENDHEX$$Interrumpir el sellado?",Question!,YesNo!)=1 then
			close(w_eimporta_procesando)
			exit
		else
			g_interrupt=false
		end if
	end if
	//Comprobamos q el fichero no tenga <0KB
	ruta = idw_docs.GetItemString(fila,'ruta_fichero')
	pdf = idw_docs.GetItemString(fila,'nombre_fichero')
	string anyo
	anyo = left(ruta,4)
	archivo_pdf = f_obtener_ruta_base(anyo) + ruta + pdf
	this.SetMicroHelp("Firmando "+string(firmados)+"/"+string(cantidad_firmar)+" - "+archivo_pdf )
	//si tiene tama$$HEX1$$f100$$ENDHEX$$o 0, mostramos incidencia
	tamano = Ceiling(gnv_fichero.of_GetFileSize(archivo_pdf) / 1024)
	
	if tamano=0 then 
		hay_errores = true
		if ficheros_rojos = '' then
			ficheros_rojos = "'" + idw_docs.getitemstring(fila,'id_fichero') + "'"
		else
			ficheros_rojos += ", '" + idw_docs.getitemstring(fila,'id_fichero') + "'"
		end if
		f_incidencia(-1, fila)
		fila = idw_docs.GetSelectedRow(fila)
		continue
		
		f_dw_resaltar_fila(idw_docs, 'id_fichero',ficheros_rojos,colores.red)

	end if
	
	estado_certificado = idw_docs.getitemstring(fila,'certificado_confianza')
	anyo = left(idw_docs.getitemstring(fila,'ruta_fichero'),4)
	ruta = f_obtener_ruta_base(anyo) + idw_docs.getitemstring(fila,'ruta_fichero')
	volteo = idw_docs.getitemnumber(fila,'volteo')
	volteo = volteo * 90
	analizador_pdf.i_volteo = 0
	fichero_entrada = idw_docs.getitemstring(fila,'nombre_fichero')
	fichero_salida  = wf_nombre_fichero_firmado(fichero_entrada)
	num_doc=f_ps_generar_sig_num_doc_visared(i_id_fase,n_registro)
	gb_estado_sellado.text = 'Firmando documento ' + string(firmados) + ' de ' + string(cantidad_firmar)
	st_estado_sellado.text = fichero_entrada

	//Calculamos las coordenadas de inicio del sello
	//Rellenamos el nombre del fichero de entrada y su correspondiente fichero de salida
	lnv_sellador.i_fichero_entrada 	= ruta + fichero_entrada
	lnv_sellador.i_o 						= ruta + fichero_salida
	lnv_sellador.i_err = g_dir_aplicacion+'error.txt'	
	
	//Si est$$HEX2$$e1002000$$ENDHEX$$rotado,tenemos que generar un fichero rotado
	IF volteo > 0 THEN 		
		fichero_salida  = MidA(fichero_entrada,1,LenA(fichero_entrada)-4)+extension+'_rotado.pdf'
		analizador_pdf.f_voltea_fichero(ruta+fichero_entrada,ruta+fichero_salida,volteo)
		fichero_entrada = fichero_salida
		lnv_sellador.i_fichero_entrada 	= ruta + fichero_entrada
		lnv_sellador.i_o 						= ''
	end if
	//analizador_pdf.f_coordenadas(ruta+fichero_entrada,idw_configuracion_sello.getitemstring(1,'posicion'))
	this.setredraw(true)
	firmados++	

	//pos_x = f_decimal_punto(analizador_pdf.f_cm_a_puntos(analizador_pdf.i_xo))
	//pos_y = f_decimal_punto(analizador_pdf.f_cm_a_puntos(analizador_pdf.i_yo))
	SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','x',pos_x)
	SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','y',pos_y)
	SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','margen',idw_configuracion_sello.GetItemString(1,'posicion'))	
	SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','referencia',num_doc)

	//FIRMAMOS
	sellado = lnv_sellador.of_firmar()
	if sellado=1 and Not(FileExists(sle_dir.text + fichero_salida)) then sellado=-100
	if sellado>0 then
		fila_fichero = if_localiza_fichero(fichero_salida)
		//Si existe la fila del fichero, entonces se modifican algunos datos
		if fila_fichero=0 then
			fila_fichero = idw_docs.insertrow(0)
			id_fichero=f_siguiente_numero('FASES_DOCU_VISARED',10)
			idw_docs.setitem(fila_fichero,'id_fichero',id_fichero)
			idw_docs.setitem(fila_fichero,'id_fase', i_id_fase)
			idw_docs.setitem(fila_fichero,'nombre_fichero',fichero_salida)
			idw_docs.setitem(fila_fichero,'ruta_fichero', idw_docs.getitemstring(fila,'ruta_fichero'))
			idw_docs.setitem(fila_fichero,'tipo_documento', idw_docs.getitemstring(fila,'tipo_documento'))			
			idw_docs.setitem(fila_fichero,'fecha', today())
			idw_docs.setitem(fila_fichero,'volteo',0)	
			idw_docs.setitem(fila_fichero,'sellado','S')
		else
			id_fichero= idw_docs.getitemstring(fila_fichero,'id_fichero')
		end if
		idw_docs.setitem(fila_fichero,'fecha_sellado',today())	
		idw_docs.setitem(fila_fichero,'n_documento',num_doc)	
		
		// Desactivamos el visible web hasta que hayamos sellado todos y generado el zip
		idw_docs.setitem(fila_fichero,'visualizar_web','N')
		
		//Ponemos el tama$$HEX1$$f100$$ENDHEX$$o (puede haber variado)
		tamano = Ceiling(gnv_fichero.of_GetFileSize(ruta+fichero_salida) / 1024)
		idw_docs.setitem(fila_fichero,'tamano',string(tamano,"#,###,##0") + ' Kb')
		idw_docs.setitem(fila_fichero,'firmado','V')		
		idw_docs.setitem(fila_fichero,'certificado_confianza',estado_certificado)
		idw_docs.update()
		
		i_ficheros_sellados[upperbound(i_ficheros_sellados) + 1] = idw_docs.GetItemString(fila_fichero,'id_fichero')
		i_ficheros_firmados[upperbound(i_ficheros_firmados) + 1] = idw_docs.GetItemString(fila,'id_fichero')
		//Ya esta firmado el documento, si es correcto y esta habilitada la opcion, lo a$$HEX1$$f100$$ENDHEX$$adimos al zip
		//if  generar_zip = 'S' and fileexists(ruta + fichero_salida) then event csd_generar_zip(ruta + fichero_salida)	
		if g_colegio='COAATTGN'  then
			is_id_fichero=id_fichero
			i_generar_xml_alfresco=true
		end if
	else  //Si no existe, se crea entero
			//Marcamos el fichero como "rojo"
			hay_errores = true
			if ficheros_rojos = '' then
				ficheros_rojos = "'" + idw_docs.getitemstring(fila,'id_fichero') + "'"
			else
				ficheros_rojos += ", '" + idw_docs.getitemstring(fila,'id_fichero') + "'"
			end if
			//Programar aqu$$HEX2$$ed002000$$ENDHEX$$la gesti$$HEX1$$f300$$ENDHEX$$n de incidencias.. de momento muestra el error
			f_incidencia(sellado,fila)
						
	end if 
	
	fila = idw_docs.GetSelectedRow(fila)
loop

if generar_zip='S' then 
	if g_comfia='S' and hay_errores=false then 
		this.SetMicroHelp("Generando XML" )
		event csd_generar_xml()
	end if
	this.SetMicroHelp("Generando ZIP" )
	if fileexists(ruta + fichero_salida) then event csd_generar_zip_completo()	
	event csd_insertar_zip_en_lista()
end if

// Despues de generar el ZIP ponemos los ficheros sellados a visibles web
if ver_web_defecto='S' then
	for i=1 to idw_docs.rowcount()
		if idw_docs.GetitemString(i,'sellado')='S' then
			idw_docs.SetItem(i,'visualizar_web','S')
		end if
	next
end if

//close(w_eimporta_procesando)
this.SetMicroHelp("Sellado Finalizado")
if g_interrupt then
	f_incidencia(-99,0)
	tab_dir.tabpage_4.visible = true
	messagebox(g_titulo,'Proceso interrumpido por el usuario',StopSign!)	
	g_interrupt=false
else
	if hay_errores then 
		tab_dir.tabpage_4.visible = true
		f_dw_resaltar_fila(idw_docs, 'id_fichero',ficheros_rojos,colores.red)
		messagebox(g_titulo,'Ha habido problemas durante el sellado de alg$$HEX1$$fa00$$ENDHEX$$n fichero. Compruebe la lista de incidencias',StopSign!)
	else
		//f_dw_resaltar_fila(idw_docs, '','0',0)
		//tab_dir.tabpage_4.visible = false
		messagebox(g_titulo,'El / Los ficheros han sido firmados con $$HEX1$$e900$$ENDHEX$$xito',Information!)		
	end if
end if


st_estado_sellado.visible = false
gb_estado_sellado.visible = false

SetPointer(Arrow!)

idw_docs.selectrow(0, false)
Filedelete(g_directorio_temporal+'sello.ini')

destroy analizador_pdf


end event

event csd_insertar_zip_en_lista();//Inserta el fichero zip en la lista de documentos
string nombre_zip,fichero_zip,fichero,num_doc,ruta_rel
int fila_zip
double tamano

nombre_zip = "VISADO_" + dw_fase.getitemstring(1,'n_expedi') + "_" + dw_fase.getitemstring(1,'fases_fase') + ".zip"
fichero_zip = sle_dir.text + nombre_zip
fila_zip = idw_docs.find("nombre_fichero='" + nombre_zip + "'",1,idw_docs.rowcount())

if fileexists(fichero_zip) and fila_zip <= 0 then
	//Como es un nuevo fichero y no ha habido error, lo a$$HEX1$$f100$$ENDHEX$$adimos a los documentos de la fase
	fila_zip = idw_docs.event pfc_addrow()
	num_doc=f_ps_generar_sig_num_doc_visared(i_id_fase,dw_fase.GetItemString(1,'fases_n_registro'))

	idw_docs.setitem(fila_zip, 'id_fichero', f_siguiente_numero('FASES_DOCU_VISARED', 10))
	idw_docs.setitem(fila_zip, 'id_fase', i_id_fase)
	idw_docs.setitem(fila_zip, 'nombre_fichero', nombre_zip)
	idw_docs.setitem(fila_zip, 'ruta_fichero',f_visared_ruta_documentos(i_id_fase,'',2))
	idw_docs.setitem(fila_zip, 'sellado', 'N')
	idw_docs.setitem(fila_zip, 'fecha', today())
	idw_docs.setitem(fila_zip, 'n_documento', num_doc)
	idw_docs.setitem(fila_zip,'visualizar_web', idw_configuracion_sello.getitemstring(1,'ver_web'))	
end if

ruta_rel=f_visared_ruta_documentos(i_id_fase,'',2)
fichero = f_obtener_ruta_base(left(ruta_rel,4)) + ruta_rel + nombre_zip
tamano = Ceiling(gnv_fichero.of_GetFileSize(fichero) / 1024)
idw_docs.setitem(fila_zip,'tamano',string(tamano,"#,###,##0") + ' Kb')
idw_docs.setitem(fila_zip,'firmado','Z')
idw_docs.setitem(fila_zip,'certificado_confianza','ZZ')
idw_docs.update()

end event

event csd_datos_configuracion_sello();//Esta funci$$HEX1$$f300$$ENDHEX$$n se utiliza para el nuevo m$$HEX1$$f300$$ENDHEX$$dulo de firma "VISIBLE"
//Rellena los datos de configuraci$$HEX1$$f300$$ENDHEX$$n del sello
int i,clausula=0,t_clausula=0,col
string sello,colegiado,dir_windows,nombre_clausula
string activo,color,codigo,textoaux,texto,resto
int fin,tamtexto,tammax,diftam
datastore ds_fase_colegiados

ds_fase_colegiados = create datastore
ds_fase_colegiados.dataobject ='d_fases_colegiados'
ds_fase_colegiados.settransobject(SQLCA)

ds_fase_colegiados.retrieve(i_id_fase)


//Calculamos la posicion del sello


//Datos de la fase
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','n_expediente',f_parseado_simbolos_xml(dw_fase.getitemstring(1,'n_expedi')))
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','fase',f_parseado_simbolos_xml(dw_fase.getitemstring(1,'fases_fase')))
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','n_registro',f_parseado_simbolos_xml(dw_fase.getitemstring(1,'fases_n_registro')))
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','titulo',f_parseado_simbolos_xml(dw_fase.getitemstring(1,'fases_titulo')))
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','f_visado',string(idw_datos_sello.getitemdatetime(1,'f_visado'),'dd/mm/yy'))
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','f_entrada',string(dw_fase.getitemdatetime(1,'fases_f_entrada'),'dd/mm/yy'))
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','f_abono',string(dw_fase.getitemdatetime(1,'fases_f_abono'),'dd/mm/yy'))
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','f_hoy',string(today(),'dd/mm/yy'))
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','descripcion_obra',f_parseado_simbolos_xml(dw_fase.getitemstring(1,'fases_titulo')))
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','emplazamiento',f_parseado_simbolos_xml(dw_fase.getitemstring(1,'compute_1')))
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','tipo_via',f_parseado_simbolos_xml(dw_fase.getitemstring(1,'fases_tipo_via_emplazamiento')))


if not isnull(dw_fase.getitemstring(1,'fases_archivo')) then
	SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','archivo',f_parseado_simbolos_xml(dw_fase.getitemstring(1,'fases_archivo')))
else
	SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','archivo','')
end if


//Directorios
//En las rutas sustituimos los signos '\' con '/' ya que Java toma el primero como s$$HEX1$$ed00$$ENDHEX$$mbolo de escape 
//y produce resultados err$$HEX1$$f300$$ENDHEX$$neos
dir_windows = f_variable_entorno("windir", "C:\WINDOWS")
//GetWindowsDirectory(dir_windows,100)
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','directorio_imagenes',f_reemplazar_cadena(g_directorio_imagenes,'\','/'))
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','directorio_windows',f_reemplazar_cadena(dir_windows,'\','/'))
//Tipo de sello
sello = idw_datos_sello.getitemstring(1,'sello') 
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
for i=1 to idw_opciones_sello.rowcount() //este for recorre los textos
	activo = idw_opciones_sello.getitemstring(i,'activo')
	if activo ='N' then continue
	texto = ''
	color=idw_opciones_sello.getitemstring(i,'color')
	codigo=idw_opciones_sello.getitemstring(i,'codigo')
	textoaux = idw_opciones_sello.getitemstring(i,'texto')
	nombre_clausula = idw_opciones_sello.getitemstring(i,'nombre')
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


destroy ds_fase_colegiados
end event

event csd_boton_refrescar();idw_docs.retrieve(i_id_fase)

end event

event csd_boton_firmar();//tab_dir.tabpage_tv.dw_docs.event csd_firmar()
tab_dir.tabpage_tv.dw_docs.postevent("csd_firmar")
open(w_eimporta_procesando)
end event

event csd_boton_abrir();tab_dir.tabpage_tv.dw_docs.event csd_abrir()
end event

event csd_boton_anyadir();tab_dir.tabpage_tv.dw_docs.event csd_anyadir()

end event

event csd_boton_correo();tab_dir.tabpage_tv.dw_docs.event csd_enviar("email")
end event

event csd_boton_importar_zip();openwithparm(w_sellador_importar_documentos, i_id_fase)

event csd_boton_refrescar()
end event

event csd_boton_vista_previa();st_sellador_datos_abrir_pdf datos
int fila

if idw_docs.getselectedrow(0)=0 then
	messagebox(g_titulo, "Debe seleccionar al menos un fichero para previsualizar.")
	return
end if
datos.fila_seleccionada = idw_docs.getrow()

datos.ficheros = idw_docs

openwithparm(w_sellador_previsualizacion_mini,datos)

fila = message.doubleparm

if fila <> -1 and fila <> 0 then
	datos.fila_seleccionada = fila

	openwithparm(w_sellador_previsualizacion_pdf,datos)
end if
end event

event csd_enviar_otra_fase(string id_fase);//tenemos que copiar el fichero al directorio de la fase correspondiente, borrarlo de la 

long fila,cuantos
string nueva_ruta,ruta_vieja,nombre_fichero, prefijo,ext,coletilla, nombre_fichero_nuevo,destino,ruta_base_nueva
boolean existe
int punto

n_cst_filesrvwin32 dire

dire = create n_cst_filesrvwin32

select count(*) into :cuantos from fases where id_fase = :id_fase;
if cuantos = 0 then return

select ruta_fichero into :nueva_ruta
from fases_documentos_visared
where id_fase=:id_fase;

fila = idw_docs.GetSelectedRow(0)

if f_es_vacio(nueva_ruta) then
//	nueva_ruta=f_visared_ruta_documentos(i_id_fase,'',2)
	nueva_ruta=f_visared_ruta_documentos(id_fase,'',2)
end if

if right(nueva_ruta,1)<>'\' then nueva_ruta+='\'

ruta_base_nueva=f_obtener_ruta_base(left(nueva_ruta,4))
if not dire.of_directoryexists( ruta_base_nueva + nueva_ruta ) then 		
	dire.of_createdirectory( ruta_base_nueva + nueva_ruta )
end if

do while fila>0
	
	ruta_vieja=idw_docs.getitemstring(fila,'ruta_fichero')
	nombre_fichero=idw_docs.getitemstring(fila,'nombre_fichero')
	
	//si ya existe el fichero, lo renombramos
	//existe=fileexists(sle_dir.text+nombre_fichero)
	destino=ruta_base_nueva+nueva_ruta+nombre_fichero
	existe=fileexists(destino)
	if existe then
		//buscamos el ultimo punto
		punto = PosA(nombre_fichero,'.',LenA(nombre_fichero)-4)
		ext = trim(MidA(nombre_fichero,punto,4))
		coletilla = '_copia'
		prefijo = MidA(nombre_fichero,1,punto -1)
		nombre_fichero_nuevo = prefijo+coletilla+ext
		//lo movemos a la otra fase
		dire.of_filerename( f_obtener_ruta_base(left(ruta_vieja,4)) + ruta_vieja + nombre_fichero, ruta_base_nueva + nueva_ruta + nombre_fichero_nuevo)	
		idw_docs.setitem(fila,'nombre_fichero',nombre_fichero_nuevo)
	else
		if dire.of_filerename(  f_obtener_ruta_base(left(ruta_vieja,4)) + ruta_vieja + nombre_fichero, ruta_base_nueva + nueva_ruta + nombre_fichero)=-1	 then
			MessageBoX("Atenci$$HEX1$$f300$$ENDHEX$$n","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al mover el fichero. Quiz$$HEX1$$e100$$ENDHEX$$s el fichero est$$HEX2$$e9002000$$ENDHEX$$en uso")
			return
		end if
			
	end if
			
	idw_docs.setitem(fila,'ruta_fichero',nueva_ruta)
	idw_docs.setitem(fila,'id_fase',id_fase)
	fila = idw_docs.GetSelectedRow(fila)
loop

idw_docs.update()
end event

event type string csd_sella_lista_sin_firma(st_sello sello);/*este evento es igual a csd_sellar_lista_ficheros salvo que se ha omitido la firma digital de ficheros*/
/*jmcg 05/01/06*/



string resultado,nombre_fichero,ruta,sobreescribir,fichero_linea
string n_reg,sellado,fecha,ver_web,fichero_origen,fichero_destino,fichero_rotado,fichero_firmado
int fila,fichero_ya_firmado_linea,i,errores=0,fila_inc,volteo, cantidad
string ver_web_defecto
integer retorno
string temp
long n = 0
int cantidad_firmar = 0, firmados, aux
string ficheros_rojos = ''
int fila_zip
string nombre_zip, fichero_zip
string fichero,ruta_fichero
double tamano
string estado_certificado
u_analizador_pdf analizador_pdf

analizador_pdf = create u_analizador_pdf

idw_datos_sello.Accepttext()
sobreescribir 	= idw_datos_sello.getitemstring(1,'sobreescribir')
n_reg 			= dw_fase.getitemstring(1,'fases_n_registro')
  
fila = idw_docs.GetSelectedRow(0)
sello.dw_textos_sello = idw_opciones_sello

//Borramos los ficheros erroneos anteriores
ficheros_rojos = ''

tab_dir.tabpage_4.visible = false
idw_incidencias.Reset()

gb_estado_sellado.visible = true
st_estado_sellado.visible = true
//Comprobamos cuantos documentos hay que firmar

for firmados = 1 to idw_docs.rowcount()
	if idw_docs.isSelected(firmados) = true then
		cantidad_firmar ++ 
	end if
next

firmados = 1

SetPointer(HourGlass!)

do while fila>0
	inv_firmador.i_error = ''
	nombre_fichero = idw_docs.getitemstring(fila,'nombre_fichero')
	
	gb_estado_sellado.text = 'Firmando documento ' + string(firmados) + ' de ' + string(cantidad_firmar)
	st_estado_sellado.text = nombre_fichero
	yield()
	this.setredraw(true)
	
	firmados ++

	volteo = idw_docs.getitemnumber(fila,'volteo')
	volteo = volteo * 90
	
	ruta_fichero = idw_docs.getitemstring(fila,'ruta_fichero')
	
	string anyo
	anyo = left(idw_docs.getitemstring(fila,'ruta_fichero'),4)
	ruta = f_obtener_ruta_base(anyo) + idw_docs.getitemstring(fila,'ruta_fichero')
  	
	estado_certificado = idw_docs.getitemstring(fila,'certificado_confianza')
  
	fichero_origen = ruta + "\" + nombre_fichero
	fichero_rotado = ruta + "\" + MidA(nombre_fichero, 1 ,LenA(nombre_fichero) -4) + '_rotado' + '.PDF'	
	fichero_firmado = wf_nombre_fichero_firmado(nombre_fichero)
	fichero_destino = ruta + "\" + fichero_firmado
	 
	//Volteamos el fichero en caso de que lo haya localizado el usuario..
	IF volteo > 0 THEN 		
		analizador_pdf.f_voltea_fichero(fichero_origen,fichero_rotado,volteo)
		inv_firmador.i_nombre_fichero_entrada = fichero_rotado
		inv_firmador.i_nombre_fichero_salida = fichero_destino
		
		// of_cunyar delega en el objeto n_escritor_pdf el estampar el sello
		inv_firmador.of_cunyar(sello)		
		retorno = inv_firmador.i_retorno
		
		if f_es_vacio(inv_firmador.i_error) and retorno > 0  then
			// of_firmar y of_proteger reciven el mismo fichero de entrada, por lo que en ambas se 
			// hace la misma comprobacion de si esta o no rotado el pdf
			// NOTA: ademas of_firmar debera comprobar si se a protegido
		 if not(f_es_vacio(i_sentencia_proteger)) then  
			inv_firmador.of_proteger_nt()	 				
		 end if
  // 	 inv_firmador.of_firmar_nt()
		end if
		
		filedelete(fichero_rotado)  //Borramos el fichero rotado...
	ELSE
		inv_firmador.i_nombre_fichero_entrada = fichero_origen
		inv_firmador.i_nombre_fichero_salida = fichero_destino

		inv_firmador.of_cunyar(sello)
		retorno = inv_firmador.i_retorno		
		
		if f_es_vacio(inv_firmador.i_error) and retorno > 0  then
			// of_firmar y of_proteger reciven el mismo fichero de entrada, por lo que en ambas se 
			// hace la misma comprobacion de si esta o no rotado el pdf
			// NOTA: ademas of_firmar debera comprobar si se a protegido
		 if not(f_es_vacio(i_sentencia_proteger)) then  
		  inv_firmador.of_proteger_nt()
		 end if
//		 inv_firmador.of_firmar_nt()
		end if		
	END IF
	if not f_es_vacio(inv_firmador.i_error) or retorno < 0 then
		fila_inc = idw_incidencias.InsertRow(0)
		//idw_incidencias.SetItem(fila_inc,'incidencia','El fichero ' + ruta+nombre_fichero+ ' NO se ha firmado correctamente')
		idw_incidencias.SetItem(fila_inc,'incidencia',inv_firmador.i_error + " " + idw_docs.getitemstring(fila,'nombre_fichero') + cr)
		errores++
		//Ponemos la fila del datawindow en rojo
		if ficheros_rojos = '' then
			ficheros_rojos = "'" + idw_docs.getitemstring(fila,'id_fichero') + "'"
		else
			ficheros_rojos += ", '" + idw_docs.getitemstring(fila,'id_fichero') + "'"
		end if
		idw_docs.update()
		fila = idw_docs.GetSelectedRow(fila)
		continue
	end if
  
	if sobreescribir='N' then 
		
		//Si el registro no ha sido firmado YA se inserta un nuevo registro en la tabla
		fichero_ya_firmado_linea = 0
		for i = 1 to idw_docs.rowcount()
			fichero_linea = idw_docs.GetItemString(i,'nombre_fichero')
			if upper(fichero_linea) = upper(fichero_firmado) then
				fichero_ya_firmado_linea = i
				exit
			end if 
		next
		
		//Si no existe ya, se a$$HEX1$$f100$$ENDHEX$$ade a la base de datos
		if fichero_ya_firmado_linea = 0 then 
			idw_docs.insertrow(0)
			idw_docs.setitem(idw_docs.rowcount(),'id_fichero', f_siguiente_numero('FASES_DOCU_VISARED',10))
			idw_docs.setitem(idw_docs.rowcount(),'id_fase', i_id_fase)
			idw_docs.setitem(idw_docs.rowcount(),'nombre_fichero',fichero_firmado)
			idw_docs.setitem(idw_docs.rowcount(),'ruta_fichero', ruta_fichero ) //f_visared_ruta_documentos(i_id_fase,'',2))
			idw_docs.setitem(idw_docs.rowcount(),'sellado', sellado)
			idw_docs.setitem(idw_docs.rowcount(),'fecha', today())
			//Ponemos en visualizar web la opcion por defecto
			ver_web_defecto = idw_configuracion_sello.getitemstring(1,'ver_web')
			idw_docs.setitem(idw_docs.rowcount(),'visualizar_web',ver_web_defecto)	
			idw_docs.setitem(idw_docs.rowcount(),'volteo',0)	
			idw_docs.setitem(idw_docs.rowcount(),'sellado','S')
			idw_docs.setitem(idw_docs.rowcount(),'fecha_sellado',today())	
			idw_docs.setitem(idw_docs.rowcount(),'n_documento',g_st_sellado_visared_consulta.n_documento)	
			//Ponemos el tama$$HEX1$$f100$$ENDHEX$$o
			anyo = left(idw_docs.getitemstring(idw_docs.rowcount(),'ruta_fichero'),4)
			fichero = f_obtener_ruta_base(anyo) + idw_docs.getitemstring(idw_docs.rowcount(),'ruta_fichero') + idw_docs.getitemstring(idw_docs.rowcount(),'nombre_fichero')
			tamano = Ceiling(gnv_fichero.of_GetFileSize(fichero) / 1024)
			idw_docs.setitem(idw_docs.rowcount(),'tamano',string(tamano,"#,###,##0") + ' Kb')
			idw_docs.setitem(idw_docs.rowcount(),'firmado','V')		
			idw_docs.setitem(idw_docs.rowcount(),'certificado_confianza',estado_certificado)					
			
			idw_docs.update()
		else
		   // Si ya estaba firmado, se modifican los datos de fecha de sellado, n$$HEX2$$ba002000$$ENDHEX$$de document y ver en web		
			idw_docs.setitem(fichero_ya_firmado_linea,'fecha_sellado',today())	
			idw_docs.setitem(fichero_ya_firmado_linea,'n_documento',g_st_sellado_visared_consulta.n_documento)	
			ver_web_defecto = idw_configuracion_sello.getitemstring(1,'ver_web')
			idw_docs.setitem(fichero_ya_firmado_linea,'visualizar_web',ver_web_defecto)
			//Ponemos el tama$$HEX1$$f100$$ENDHEX$$o (puede haber variado)
			anyo = 		idw_docs.getitemstring(fichero_ya_firmado_linea,'ruta_fichero')
			fichero = f_obtener_ruta_base(anyo) + idw_docs.getitemstring(fichero_ya_firmado_linea,'ruta_fichero') + idw_docs.getitemstring(fichero_ya_firmado_linea,'nombre_fichero')
			tamano = Ceiling(gnv_fichero.of_GetFileSize(fichero) / 1024)
			idw_docs.setitem(fichero_ya_firmado_linea,'tamano',string(tamano,"#,###,##0") + ' Kb')
			idw_docs.setitem(fichero_ya_firmado_linea,'firmado','V')		
			idw_docs.setitem(fichero_ya_firmado_linea,'certificado_confianza',estado_certificado)
			idw_docs.update()		
		end if
						
	else	//Se sobreescribe el fichero:		
		
		//Se borra el fichero original
		if not filedelete(fichero_origen) then 
			fila_inc = idw_incidencias.InsertRow(0)
			idw_incidencias.SetItem(fila_inc,'incidencia','El fichero ' + fichero_origen+ ' NO se ha firmado correctamente')
			errores++
			fila = idw_docs.GetSelectedRow(fila)
			continue
		end if				
		
		//Se renombra el fichero firmado "fichero_signed" al fichero_origen
		if not gnv_fichero.of_filerename(fichero_destino, fichero_origen) = 1 then
			fila_inc = idw_incidencias.InsertRow(0)
			idw_incidencias.SetItem(fila_inc,'incidencia','El fichero ' + fichero_origen+ ' NO se ha firmado correctamente')
			errores++
			fila = idw_docs.GetSelectedRow(fila)
			continue
		end if		

		//Si todo ha ido bien, comprobamos si existe en el dw.
		//idw_docs.deleterow(idw_docs.getrow())
		fichero_ya_firmado_linea=0
		for i=1 to idw_docs.rowcount()
			if upper(nombre_fichero) = upper(fichero_firmado) then
				fichero_ya_firmado_linea = i
				exit
			end if     
		next
		//Si no existe ya, se renombra a$$HEX1$$f100$$ENDHEX$$ade a la base de datos
		if fichero_ya_firmado_linea = 0 then 			
			idw_docs.setitem(fila,'nombre_fichero', nombre_fichero)
			idw_docs.setitem(fila,'sellado','S')
			idw_docs.setitem(fila,'fecha_sellado',today())	
			idw_docs.setitem(fila,'n_documento',g_st_sellado_visared_consulta.n_documento)	
			ver_web_defecto = idw_configuracion_sello.getitemstring(1,'ver_web')
			idw_docs.setitem(fila,'visualizar_web',ver_web_defecto)	
			//Ponemos el tama$$HEX1$$f100$$ENDHEX$$o
			anyo = left( idw_docs.getitemstring(fila,'ruta_fichero'),4)
			fichero =f_obtener_ruta_base(anyo) + idw_docs.getitemstring(fila,'ruta_fichero') + idw_docs.getitemstring(fila,'nombre_fichero')
			tamano = Ceiling(gnv_fichero.of_GetFileSize(fichero) / 1024)
			idw_docs.setitem(fila,'tamano',string(tamano,"#,###,##0") + ' Kb')
			idw_docs.setitem(fila,'firmado','V')
			idw_docs.setitem(fila,'certificado_confianza',estado_certificado)
			idw_docs.update()
		else
		//Si ya estaba firmado, se modifican los datos de fecha de sellado, n$$HEX2$$ba002000$$ENDHEX$$de documento	y ver en web
			idw_docs.setitem(fichero_ya_firmado_linea,'fecha_sellado',today())	
			idw_docs.setitem(fichero_ya_firmado_linea,'n_documento',g_st_sellado_visared_consulta.n_documento)	
			ver_web_defecto = idw_configuracion_sello.getitemstring(1,'ver_web')
			idw_docs.setitem(fichero_ya_firmado_linea,'visualizar_web',ver_web_defecto)
			//Ponemos el tama$$HEX1$$f100$$ENDHEX$$o (puede haber variado)
			anyo = left(idw_docs.getitemstring(fichero_ya_firmado_linea,'ruta_fichero'),4)
			fichero = f_obtener_ruta_base(anyo) + idw_docs.getitemstring(fichero_ya_firmado_linea,'ruta_fichero') + idw_docs.getitemstring(fichero_ya_firmado_linea,'nombre_fichero')
			tamano = Ceiling(gnv_fichero.of_GetFileSize(fichero) / 1024)
			idw_docs.setitem(fichero_ya_firmado_linea,'tamano',string(tamano,"#,###,##0") + ' Kb')
			idw_docs.setitem(fichero_ya_firmado_linea,'firmado','V')		
			idw_docs.setitem(fichero_ya_firmado_linea,'certificado_confianza',estado_certificado)
			idw_docs.update()		
		end if
	end if
	
	i_ficheros_firmados[upperbound(i_ficheros_firmados) + 1] = idw_docs.GetItemString(fila,'id_fichero')
	
	//Ya esta firmado el documento, si es correcto y esta habilitada la opcion, lo a$$HEX1$$f100$$ENDHEX$$adimos al zip
	if errores = 0 and idw_configuracion_sello.getitemstring(1,'generar_zip') = 'S' and fileexists(fichero_destino) then
		event csd_generar_zip(fichero_destino)	
	end if
	
	//Vamos a la siguiente l$$HEX1$$ed00$$ENDHEX$$nea seleccionada
	fila = idw_docs.GetSelectedRow(fila)
loop

//Hemos acabado de firmar, miramos si esta el zip, y sino lo a$$HEX1$$f100$$ENDHEX$$adimos
nombre_zip = "VISADO_" + dw_fase.getitemstring(1,'n_expedi') + "_" + dw_fase.getitemstring(1,'fases_fase') + ".zip"
fichero_zip = sle_dir.text + nombre_zip
fila_zip = idw_docs.find("nombre_fichero='" + nombre_zip + "'",1,idw_docs.rowcount())

if idw_configuracion_sello.getitemstring(1,'generar_zip') = 'S' then

	if fileexists(fichero_zip) and fila_zip <= 0 then
		//Como es un nuevo fichero y no ha habido error, lo a$$HEX1$$f100$$ENDHEX$$adimos a los documentos de la fase
		fila = idw_docs.event pfc_addrow()
		idw_docs.setitem(fila, 'id_fichero', f_siguiente_numero('FASES_DOCU_VISARED', 10))
		idw_docs.setitem(fila, 'id_fase', i_id_fase)
		idw_docs.setitem(fila, 'nombre_fichero', nombre_zip)
		idw_docs.setitem(fila, 'ruta_fichero',ruta_fichero )//f_visared_ruta_documentos(i_id_fase,'',2))
		idw_docs.setitem(fila, 'sellado', 'N')
		idw_docs.setitem(fila, 'fecha', today())
		idw_docs.setitem(fila,'visualizar_web', idw_configuracion_sello.getitemstring(1,'ver_web'))	
		anyo = left(idw_docs.getitemstring(fila,'ruta_fichero'),4)
		fichero = f_obtener_ruta_base(anyo) + idw_docs.getitemstring(fila,'ruta_fichero') + idw_docs.getitemstring(fila,'nombre_fichero')
		tamano = Ceiling(gnv_fichero.of_GetFileSize(fichero) / 1024)
		idw_docs.setitem(fila,'tamano',string(tamano,"#,###,##0") + ' Kb')
		idw_docs.setitem(fila,'firmado','Z')
		idw_docs.setitem(fila,'certificado_confianza','ZZ')
		idw_docs.update()
	elseif fila_zip > 0 then
		anyo = left(idw_docs.getitemstring(fila_zip,'ruta_fichero'),4)
		fichero = f_obtener_ruta_base(anyo) + idw_docs.getitemstring(fila_zip,'ruta_fichero') + idw_docs.getitemstring(fila_zip,'nombre_fichero')
		tamano = Ceiling(gnv_fichero.of_GetFileSize(fichero) / 1024)
		idw_docs.setitem(fila_zip,'tamano',string(tamano,"#,###,##0") + ' Kb')
		idw_docs.setitem(fila_zip,'firmado','Z')
		idw_docs.setitem(fila_zip,'certificado_confianza','ZZ')
		idw_docs.update()
	end if
end if

st_estado_sellado.visible = false
gb_estado_sellado.visible = false

if errores = 0 then
	//	st_mensaje.text ='Proceso terminado con $$HEX1$$e900$$ENDHEX$$xito'
	f_dw_resaltar_fila(idw_docs, '','0',0)
	messagebox(g_titulo,'El / Los ficheros han sido firmados con $$HEX1$$e900$$ENDHEX$$xito',Information!)
	tab_dir.tabpage_4.visible = false
	resultado='1'
else
	//	st_mensaje.text ='Ha habido problemas durante el proceso.Revise la lista de incidencias'
	tab_dir.tabpage_4.visible = true
	n_cst_color colores
	f_dw_resaltar_fila(idw_docs, 'id_fichero',ficheros_rojos,colores.red)
	messagebox(g_titulo,'Ha habido problemas durante el sellado de alg$$HEX1$$fa00$$ENDHEX$$n fichero. Compruebe la lista de incidencias',StopSign!)
	resultado='-1'
end if

SetPointer(Arrow!)

idw_docs.selectrow(0, false)

destroy inv_firmador
destroy analizador_pdf

return resultado


end event

event type integer csd_comprobacion_datos_sin_firma();//Comprueba que exista fecha de visado
datetime f_visado
string n_registro
string nombre,situacion,razon,certificado,password,extension,orden,mensaje
integer retorno
decimal x1, y1
n_firmador_pdf firmador
string nulo
boolean lbo_certificado_activo
int i

if idw_certificados.rowcount()=0 and g_sellador_certificado = '' then
	Messagebox(g_titulo,'NO se ha inclu$$HEX1$$ed00$$ENDHEX$$do ning$$HEX1$$fa00$$ENDHEX$$n certificado v$$HEX1$$e100$$ENDHEX$$lido para firmar el documento.Revise la pesta$$HEX1$$f100$$ENDHEX$$a "Certificados" o inicie Sesi$$HEX1$$f300$$ENDHEX$$n.',StopSign!)
	return (-1)
end if

	
if dw_fase.rowcount()= 0 then
	Messagebox(g_titulo,'Los datos de la Fase NO son correctos. Asegurese de que han sido actualizados.',StopSign!)
	return (-1)
end if

f_visado = dw_fase.GetItemDatetime(1,'f_visado')
n_registro = dw_fase.GetItemString(1,'fases_n_registro')

if f_es_vacio(n_registro) then
	MessageBox(g_titulo,'El N$$HEX2$$ba002000$$ENDHEX$$de Registro no est$$HEX2$$e1002000$$ENDHEX$$especificado'+cr +'Asegurese de que han sido actualizados los datos de la fase.',StopSign!)
	return (-1)
end if

if isnull(f_visado) then 
	MessageBox(g_titulo,'La Fase NO tiene fecha de Visado. NO se podr$$HEX2$$e1002000$$ENDHEX$$sellar la fase hasta que la fase est$$HEX2$$e9002000$$ENDHEX$$visada.',Information!)
	return -1
end if		

idw_certificados.sort()
orden = '0'

//Obtenemos el certificado a usar
lbo_certificado_activo = false
for i = 1 to idw_certificados.rowcount()
	if idw_certificados.getitemstring(i,'activo') = 'S' then 
		lbo_certificado_activo = true
		exit
	end if
next

//si la firma es obligatoria, debemos comprobar q exista
if idw_configuracion_sello.GetItemString(1,'firmar_documento')='N' then

else


	//Si no hay certificado activo, avisamos y cancelamos el sellado
	if lbo_certificado_activo = false then
		messagebox(g_titulo,'No se ha seleccionado ningun certificado, reviselo en la pesta$$HEX1$$f100$$ENDHEX$$a Firma/Certificados')
		return -1
	end if


	//Comprobamos que est$$HEX1$$e900$$ENDHEX$$n rellenos los datos obligatorios del sello
	nombre = idw_datos_sello.getitemstring(1,'nombre')
	situacion = idw_datos_sello.getitemstring(1,'situacion')
	razon = idw_datos_sello.getitemstring(1,'razon')
	if g_sellador_certificado = '' then
		certificado = g_directorio_certificados + idw_certificados.getitemstring(i,'certificado')
	else
		certificado = g_directorio_certificados + g_sellador_certificado
	end if
	if g_sellador_password = '' then
		password = idw_certificados.getitemstring(i,'password')
	else
		password = g_sellador_password 
	end if	

	
	
	// Validaciones de Datos de Sello
	if f_es_vacio(nombre) then mensaje += 'Debe especificar un nombre.' +cr
	if f_es_vacio(situacion) then mensaje += 'Debe especificar una situaci$$HEX1$$f300$$ENDHEX$$n.' +cr
	if f_es_vacio(razon) then mensaje += 'Debe especificar una raz$$HEX1$$f300$$ENDHEX$$n.' +cr
	if f_es_vacio(certificado) then mensaje += 'Debe especificar un certificado.' +cr
	if not(fileexists(certificado)) then
		mensaje += 'Debe especificar un certificado v$$HEX1$$e100$$ENDHEX$$lido, puede seleccionarlo con el bot$$HEX1$$f300$$ENDHEX$$n de ayuda.' +cr		
	end if
	if f_es_vacio(password) then mensaje += 'Debe especificar la contrase$$HEX1$$f100$$ENDHEX$$a del certificado.' +cr
	if f_es_vacio(orden) then mensaje += 'Debe especificar el orden del texto en el sello.' +cr
end if

if idw_opciones_sello.rowcount()>0 then orden = idw_opciones_sello.getitemstring(1,'orden')
extension = idw_datos_sello.getitemstring(1,'extension')
//sello.tipo = idw_datos_sello.getitemstring(1,'sello')

// Validaciones de Configuracion del sello
x1 = idw_configuracion_sello.GetItemDecimal(1, 'x')
y1 = idw_configuracion_sello.GetItemDecimal(1, 'y')
if idw_configuracion_sello.GetItemString(1, 'posicion') = 'L' then
 if f_es_vacio(string(x1)) or f_es_vacio(string(y1)) then mensaje += 'Debe especificar la coordenadas X e Y de la posici$$HEX1$$f300$$ENDHEX$$n libre.' +cr
end if

// Validaciones de Seguridad de Configuracion del sello
firmador = create n_firmador_pdf
i_sentencia_proteger = ''

if idw_configuracion_sello.getItemString(1,'encriptar') = "S" then 
 if f_es_vacio(idw_configuracion_sello.getItemString(1,'password')) or f_es_vacio(idw_configuracion_sello.getItemString(1,'password2')) then
  mensaje += "Debe especificar la contrase$$HEX1$$f100$$ENDHEX$$a de propietario" +cr
 end if
 
 if (idw_configuracion_sello.getItemString(1,'password') <> idw_configuracion_sello.getItemString(1,'password2')) then
  mensaje += "Las contrase$$HEX1$$f100$$ENDHEX$$as de propietario deben coincidir" +cr
 end if   
 
 //firmador.f_encriptar(idw_configuracion_sello.getItemString(1,'encriptar'))
 firmador.f_ownerpass(idw_configuracion_sello.getItemString(1,'password'))
 //firmador.f_password_lectura(idw_configuracion_sello.getItemString(1,'encriptar'),idw_configuracion_sello.getItemString(1,'password'))
end if	

if idw_configuracion_sello.getItemString(1,'habilitar_userpass') = "S" then
 if f_es_vacio(idw_configuracion_sello.getItemString(1,'userpass')) or f_es_vacio(idw_configuracion_sello.getItemString(1,'userpass2')) then
  mensaje += "Debe especificar la contrase$$HEX1$$f100$$ENDHEX$$a de usuario" +cr
 end if
 
 if (idw_configuracion_sello.getItemString(1,'userpass') <> idw_configuracion_sello.getItemString(1,'userpass2')) then
  mensaje += "Las contrase$$HEX1$$f100$$ENDHEX$$as de usuario deben coincidir" +cr
 end if 
 
 firmador.f_userpass(idw_configuracion_sello.getItemString(1,'habilitar_userpass'),idw_configuracion_sello.getItemString(1,'userpass'))
end if	

if not(f_es_vacio(idw_configuracion_sello.getItemString(1,'password'))) and not(f_es_vacio(idw_configuracion_sello.getItemString(1,'userpass'))) then
 if idw_configuracion_sello.getItemString(1,'password') = idw_configuracion_sello.getItemString(1,'userpass') then
  mensaje += "Las contrase$$HEX1$$f100$$ENDHEX$$a de propietario y de usuario deben de ser distintas" +cr
 end if
end if

// PROTEGER
firmador.f_nomodify(idw_configuracion_sello.getItemString(1,'nomodify'))
firmador.f_noassembly(idw_configuracion_sello.getItemString(1,'noassembly'))
firmador.f_nonotes(idw_configuracion_sello.getItemString(1,'nonotes'))
firmador.f_nofill(idw_configuracion_sello.getItemString(1,'nofill'))
firmador.f_nohighresolution(idw_configuracion_sello.getItemString(1,'nohighres'))
firmador.f_nocopy(idw_configuracion_sello.getItemString(1,'nocopy'))
firmador.f_noaccess(idw_configuracion_sello.getItemString(1,'noaccess'))
firmador.f_noprint(idw_configuracion_sello.getItemString(1,'noprint'))

// FIRMAR
//firmador.f_certificado()

// Ahora lo pasamos el string "sentencia de seguridad" a inv_firmador,
// dentro de su vble. publica i_sentencia_proteger
i_sentencia_proteger = firmador.i_cadena_proteger
//i_sentencia_firmar   = firmador.i_cadena_firmar

destroy firmador


if mensaje <> '' then
	messagebox(g_titulo, mensaje)
	retorno =  -1
else
	retorno =  1
end if


return retorno


end event

event csd_generar_xml();integer li_fichero
long i,j,linea
double tamano
string linea_xml
string fila,tab,id_fase,n_col,id,porcen,nombre,apellidos,nif,ls_fichero,ver_web_defecto
string ruta_fichero,nombre_fic_zip
string d_trabajo,cod_tipo_trabajo,cod_fase,tipo_fase,trabajo,cod_trabajo,cod_tipo_via,tipo_via
string campos[14]={"n_expediente","n_registro","f_entrada","f_visado","f_abono","titulo",&
"t_fase","t_trabajo","trabajo","tipo_via_emplazamiento","emplazamiento","poblacion",&
"c_postal","provincia"}
string campos2[3]={"etiqueta","codigo","valor"}
string etiquetas[14]={"N$$HEX2$$ba002000$$ENDHEX$$Expediente","N$$HEX2$$ba002000$$ENDHEX$$Registro","Fecha Entrada","Fecha Visado",&
"Fecha Abono","T$$HEX1$$ed00$$ENDHEX$$tulo","Tipo Fase","Tipo Trabajo","Trabajo","Tipo V$$HEX1$$ed00$$ENDHEX$$a","Emplazamiento",&
"Poblaci$$HEX1$$f300$$ENDHEX$$n","C$$HEX1$$f300$$ENDHEX$$digo Postal","Provincia"}
string codigos[14],valores[14]
datastore ds_colegiados,ds_clientes
n_cst_encrypt lnv_encriptado
datetime f_abono

lnv_encriptado=create n_cst_encrypt

cod_fase=dw_fase.GetItemString(1,"fases_fase")
cod_tipo_trabajo=dw_fase.GetItemString(1,"fases_tipo_trabajo")
cod_trabajo=dw_fase.GetItemString(1,"fases_trabajo")
cod_tipo_via=dw_fase.GetItemString(1,"fases_tipo_via_emplazamiento")
id_fase=dw_fase.GetItemString(1,"id_fase")

ds_colegiados=create datastore
ds_colegiados.DataObject='d_fases_colegiados'
ds_colegiados.SetTransObject(SQLCA)
ds_colegiados.retrieve(id_fase)

ds_clientes=create datastore
ds_clientes.DataObject='d_fases_promotores'
ds_clientes.SetTransObject(SQLCA)
ds_clientes.retrieve(id_fase)

select d_t_descripcion into :tipo_fase from t_fases where c_t_fase=:cod_fase;
select d_t_trabajo into :d_trabajo from tipos_trabajos where c_t_trabajo=:cod_tipo_trabajo;
select d_trabajo into :trabajo from trabajos where c_trabajo=:cod_trabajo;
select descripcion into :tipo_via from tipos_via where cod_tipo_via=:cod_tipo_via;

f_abono=dw_fase.GetItemDateTime(1,"fases_f_abono")
if IsNull(f_abono) then f_abono=datetime('01/01/1900')

valores[1]=dw_fase.GetItemString(1,"fases_n_expedi")+"-"+dw_fase.GetItemString(1,"fases_fase")
valores[2]=dw_fase.GetItemString(1,"fases_n_registro")
valores[3]=string(date(dw_fase.GetItemDateTime(1,"fases_f_entrada")))
valores[4]=string(date(dw_fase.GetItemDateTime(1,"f_visado")))
valores[5]=string(date(f_abono))
valores[6]=dw_fase.GetItemString(1,"fases_titulo")
valores[7]=tipo_fase
valores[8]=d_trabajo
valores[9]=trabajo
valores[10]=tipo_via
valores[11]=dw_fase.GetItemString(1,"fases_emplazamiento")
valores[12]=dw_fase.GetItemString(1,"poblaciones_descripcion")
valores[13]=dw_fase.GetItemString(1,"poblaciones_cod_pos")
valores[14]=dw_fase.GetItemString(1,"provincias_nombre")

codigos[7]=cod_fase
codigos[8]=cod_tipo_trabajo
codigos[9]=cod_trabajo
codigos[10]=cod_tipo_via
codigos[12]=dw_fase.GetItemString(1,"poblaciones_cod_pob")
codigos[14]=dw_fase.GetItemString(1,"provincias_cod_provincia")

for i=1 to UpperBound(valores)
	if IsNull(valores[i]) then valores[i]=''
	if IsNull(codigos[i]) then codigos[i]=''		
next

ls_fichero="fase.xml"
li_fichero=FileOpen(sle_dir.text + ls_fichero,LineMode!,Write!,LockWrite!,Replace!)

linea_xml='<?xml version="1.0" encoding="ISO-8859-1" standalone="no"?>'
FileWrite(li_fichero,lnv_encriptado.of_encrypt(linea_xml))
//FileWrite(li_fichero,linea_xml)
linea_xml="<paquete>"

		
// DATOS DE LA FASE
linea_xml += "<fase>"
for i=1 to UpperBound(campos)

	linea_xml +="<"+campos[i]+">"
		
	for j=1 to UpperBound(campos2)		
		fila="<"+campos2[j]+">"
		choose case j
			case 1
				fila=fila+etiquetas[i]
			case 2
				fila=fila+codigos[i]				
			case 3
				fila=fila+f_parseado_simbolos_xml(valores[i])
		end choose
		fila=fila+"</"+campos2[j]+">"		
		linea_xml += fila
	next
	
	linea_xml += "</"+campos[i]+">"
next
linea_xml += "</fase>"
// COLEGIADOS DE LA FASE
linea_xml += "<colegiados>"


for i=1	to ds_colegiados.rowcount()
	n_col=ds_colegiados.GetItemString(i,"n_colegiado")	
	id=ds_colegiados.GetItemString(i,"id_col")	
	select nombre,apellidos,nif into :nombre,:apellidos,:nif from colegiados where id_colegiado=:id;
	
	
	if f_es_vacio(nombre) then 
		nombre=apellidos
	else
		nombre=apellidos+', '+nombre
	end if
	
	linea_xml += '<colegiado id="'+string(i)+'">'
	
	linea_xml += "<n_colegiado>"
	linea_xml += "<etiqueta>N$$HEX2$$ba002000$$ENDHEX$$Colegiado</etiqueta>"	
	linea_xml += "<valor>"+n_col+"</valor>"
	linea_xml += "</n_colegiado>"
	 
	linea_xml += "<nombre>"
	linea_xml += "<etiqueta>Nombre</etiqueta>"
	linea_xml += "<valor>"+f_parseado_simbolos_xml(nombre)+"</valor>"
	linea_xml += "</nombre>"
	
	linea_xml += "<nif>"
	linea_xml += "<etiqueta>NIF</etiqueta>"	
	linea_xml += "<valor>"+nif+"</valor>"
	linea_xml += "</nif>"
	
	linea_xml += "<porcentaje>"
	linea_xml += "<etiqueta>Porcentaje</etiqueta>"
	linea_xml += "<valor>"+string(ds_colegiados.GetItemNumber(i,"porcen_a"))+"</valor>"
	linea_xml += "</porcentaje>"		
	
	linea_xml += "</colegiado>"
next
	
linea_xml += "</colegiados>"

// CLIENTES DE LA FASE
linea_xml +="<clientes>"

for i=1	to ds_clientes.rowcount()	
	id=ds_clientes.GetItemString(i,"id_cliente")	
	select nombre,apellidos,nif into :nombre,:apellidos,:nif from clientes where id_cliente=:id;
		
	if f_es_vacio(nombre) then 
		nombre=apellidos
	else
		nombre=apellidos+', '+nombre
	end if
	
	linea_xml += '<cliente id="'+string(i)+'">'
	
	linea_xml += "<nombre>"
	linea_xml += "<etiqueta>Nombre</etiqueta>"	
	linea_xml += "<valor>"+f_parseado_simbolos_xml(nombre)+"</valor>"
	linea_xml += "</nombre>"

	linea_xml += "<nif>"
	linea_xml += "<etiqueta>NIF</etiqueta>"	
	linea_xml += "<valor>"+nif+"</valor>"
	linea_xml += "</nif>"
	
	linea_xml += "<porcentaje>"
	linea_xml += "<etiqueta>Porcentaje</etiqueta>"	
	linea_xml += +"<valor>"+string(ds_clientes.GetItemNumber(i,"porcen"))+"</valor>"
	linea_xml += "</porcentaje>"	
	linea_xml += "</cliente>"
next

linea_xml += "</clientes>"

// FICHEROS GENERADOS
linea_xml += tab+"<ficheros>"


//Genera un fichero zip con los ficheros firmados
//En el mismo momento en que se firma un documento, este se a$$HEX1$$f100$$ENDHEX$$ade al zip
oleobject zip,files,oFile
string nombre_zip
string fichero_zip


//Creamos el zip
zip = create oleobject
zip.ConnectToNewObject("SAWZip.Archive")
//Generamos el nombre y ruta del fichero zip
nombre_zip = "VISADO_" + dw_fase.getitemstring(1,'n_expedi') + "_" + dw_fase.getitemstring(1,'fases_fase') + ".zip"
fichero_zip = sle_dir.text + nombre_zip

//Comprobamos si esta para a$$HEX1$$f100$$ENDHEX$$adirlo o crear el zip
if fileexists(fichero_zip) then
	zip.open(fichero_zip)

	for i=0 to zip.files.count - 1
		nombre_fic_zip=zip.files[i].name
		if RightA(nombre_fic_zip,3)='xml' then continue //Ignoramos el fichero xml
		linea_xml += "<fichero>"
		linea_xml += "<path>"+nombre_fic_zip+"</path>"
		linea=idw_docs.find("nombre_fichero='" + nombre_fic_zip+"'",1,idw_docs.rowcount())
		linea_xml += "<n_referencia>"+idw_docs.GetItemString(linea,'n_documento')+"</n_referencia>"
		linea_xml += "</fichero>"
	next
	//Cerramos el zip y destruimos los objetos
	zip.close()

	destroy zip

end if

/*
for i=1 to idw_docs.rowcount()
	if idw_docs.GetItemString(i,'sellado')='N' then continue
	linea_xml += tab+"<fichero>")
	linea_xml += tab+tabulador+"<fichero>"+idw_docs.GetItemString(i,'nombre_fichero')+"</fichero>")
	linea_xml += tab+tabulador+"<n_referencia>"+idw_docs.GetItemString(i,'n_documento')+"</n_referencia>")	
	linea_xml += tab+"</fichero>"
next
*/

tab=tabulador
linea_xml += "</ficheros>"

linea_xml += "</paquete>"
FileWrite(li_fichero,lnv_encriptado.of_encrypt(linea_xml))
//FileWrite(li_fichero,linea_xml)
FileClose(li_fichero)

//wf_insertar_fichero(ls_fichero)

if FileExists(sle_dir.text + ls_fichero) then event csd_generar_zip(sle_dir.text + ls_fichero)

FileDelete(sle_dir.text + ls_fichero)










end event

event csd_integridad();string id_fase

id_fase=dw_fase.GetItemString(1,'id_fase')
OpenWithParm(w_sellador_integridad_detalle,id_fase)

idw_docs.retrieve(id_fase)
end event

event csd_editar();tab_dir.tabpage_tv.dw_docs.event csd_editar()

end event

event csd_generar_zip_completo();//Genera un fichero zip con los ficheros firmados
//En el mismo momento en que se firma un documento, este se a$$HEX1$$f100$$ENDHEX$$ade al zip
oleobject zip,files,oFile
string nombre_zip,ruta_fichero
string fichero_zip
int fila,i

//Creamos el zip
zip = create oleobject
zip.ConnectToNewObject("SAWZip.Archive")
//Generamos el nombre y ruta del fichero zip
nombre_zip = "VISADO_" + dw_fase.getitemstring(1,'n_expedi') + "_" + dw_fase.getitemstring(1,'fases_fase') + ".zip"
fichero_zip = sle_dir.text + nombre_zip

//Comprobamos si esta para a$$HEX1$$f100$$ENDHEX$$adirlo o crear el zip
if fileexists(fichero_zip) then
	zip.open(fichero_zip)
else
	zip.create(fichero_zip)
end if

//A$$HEX1$$f100$$ENDHEX$$adimos el fichero
Files = create oleobject
Files.ConnectToNewObject("SAWZip.Files")
Files = zip.Files

for i=1 to UpperBound(i_ficheros_sellados)
	fila = idw_docs.find("id_fichero='" + i_ficheros_sellados[i] + "'", 1, idw_docs.RowCount())
	if fila>0 then
		string anyo
		anyo = left( idw_docs.getitemstring(fila,'ruta_fichero'),4)
		ruta_fichero = f_obtener_ruta_base(anyo) + idw_docs.getitemstring(fila,'ruta_fichero')+idw_docs.getitemstring(fila, 'nombre_fichero')
	end if
	oFile = create oleobject
	oFile.ConnectToNewObject("SAWZip.File")	
	oFile.Name = ruta_fichero
	Files.Add(oFile)

next

//Cerramos el zip y destruimos los objetos
zip.close()

destroy zip
destroy files
destroy oFile
end event

public function string f_password ();//Creamos un password aleatorio


int i,numero
string password = '',mascara

Randomize(0)
mascara = 'CCNNNNCC'

for i= 1 to LenA(mascara)
	if MidA(mascara,i,1) = 'C' then
		numero = Rand(25)
		numero = 65 + numero
		password = password + CharA(numero)
	else
		numero = Rand(9)
		password = password + string(numero)
	end if
next


return password
end function

public function integer if_localiza_fichero (string fichero);//Localiza si existe un fichero en la lista de los ficheros
//Devuelve: 
//		*  linea en la que se encuentra el fichero
//		*  0 : Si no encuentra ning$$HEX1$$fa00$$ENDHEX$$na l$$HEX1$$ed00$$ENDHEX$$nea
//		* <0 : Si encuentra alg$$HEX1$$fa00$$ENDHEX$$n error

int posicion = -1

posicion = idw_docs.find("nombre_fichero='"+fichero+"'",1,idw_docs.rowcount())

return posicion
end function

public function string f_nombre_fichero (string fichero);//Busca si existe el fichero_destino que se para como par$$HEX1$$e100$$ENDHEX$$metro, si es as$$HEX2$$ed002000$$ENDHEX$$devuelve
//el nuevo nombre disponible con la coletilla _copia1,copia2...
int contador=0,punto,posic
string prefijo,ext,coletilla

//Para no sobreescribir el fichero_destino, si el fichero_destino ya existe se crea otro con la coletilla '_copia1','_copia2'...
do while idw_docs.Find("nombre_fichero='"+fichero+"'",1,idw_docs.rowcount())>0
	contador++
	posic = PosA(fichero,'_copia',1)
	punto = PosA(fichero,'.',1)
	
	ext = trim(MidA(fichero,punto,4))
	
	if posic = 0 then 
		coletilla = '_copia1'
		prefijo = MidA(fichero,1,punto -1)
	else
		coletilla = '_copia'+string(contador)
		prefijo = MidA(fichero,1,posic -1)
	end if

	fichero = prefijo+coletilla+ext
loop 

return fichero
end function

public function string wf_ficheros_firmados ();//Recorre el dw de ficheros y a$$HEX1$$f100$$ENDHEX$$ade el id_fases_documento al retorno de aquellos 
//que han sido firmados
string ls_retorno
string ls_id_fases_documento
int i,j
string ls_nombre, ls_nombre_firma, ls_nombre_aux

ls_retorno = ''

for i = 1 to idw_docs.rowcount()
	//Cogemos el nombre
	ls_nombre = idw_docs.getitemstring(i,'nombre_fichero')
	//Le a$$HEX1$$f100$$ENDHEX$$adimos la extension de la firma
	ls_nombre_firma = wf_nombre_fichero_firmado(ls_nombre)
	//Buscamos ese nombre en el resto del datawindows
	for j = 1 to idw_docs.rowcount()
		ls_nombre_aux = idw_docs.getitemstring(j,'nombre_fichero')
		//Si lo encontramos lo a$$HEX1$$f100$$ENDHEX$$adimos a la lista
		if upper(ls_nombre_firma) = upper(ls_nombre_aux) then
			ls_id_fases_documento = idw_docs.getitemstring(i,'id_fichero')
			if ls_retorno = '' then
				ls_retorno = "'" + ls_id_fases_documento + "'"
			else
				ls_retorno += ",'" + ls_id_fases_documento + "'"
			end if
		end if
	next
next

return ls_retorno
end function

public function string wf_nombre_fichero_firmado (string nombre_fichero);string ls_extension
integer max_long_nombre_fichero

ls_extension = idw_datos_sello.getitemstring(1,'extension')

// Longitud m$$HEX1$$e100$$ENDHEX$$xima que puede tener el nombre de fichero para poder guardarlo en la base de datos
// Cuando un nombre exceda este l$$HEX1$$ed00$$ENDHEX$$mite se truncar$$HEX1$$e100$$ENDHEX$$
max_long_nombre_fichero = f_tamanyo_columna(idw_docs, 'nombre_fichero') - LenA(ls_extension) - 4

return LeftA(nombre_fichero, min(LenA(nombre_fichero) - 4, max_long_nombre_fichero)) + ls_extension + '.PDF'	

end function

public subroutine f_actualiza_vista_previa (integer fila);string nombre_archivo_pdf,ruta,fichero
int rotacion


if fila=0 then 
	st_imagen_no_disponible.visible = true
	ole_visor_pdf.visible = false
	gb_rotacion.visible = false
	st_rotacion.visible = false
	cb_voltear_pdf.visible = false
	ole_visor_pdf.object.closeFile()
	return
end if
int rotacion_ant
rotacion_ant = integer(LeftA(st_rotacion.text, LenA(st_rotacion.text) - 1) )

if rotacion_ant <> 0 then
	ole_visor_pdf.Object.rotate = 0  //Restablecemos la rotaci$$HEX1$$f300$$ENDHEX$$n a 0
end if
ruta = idw_docs.GetItemString(fila,'ruta_fichero')
fichero = idw_docs.GetItemString(fila,'nombre_fichero')
rotacion = idw_docs.GetItemNumber(fila,'volteo')
if isnull(rotacion) then rotacion = 0
st_rotacion.text = string(rotacion*90)+'$$HEX1$$ba00$$ENDHEX$$'

nombre_archivo_pdf = f_obtener_ruta_base(left(ruta,4)) + ruta + fichero
//Comprobamos que existe el fichero antes de seguir
//if not FileExists(nombre_archivo_pdf) or pos(nombre_archivo_pdf,'_VISADO') > 0 or upper(right(nombre_archivo_pdf,4)) <> '.PDF' or f_es_vacio(nombre_archivo_pdf) then 
//	st_imagen_no_disponible.visible = true
//	ole_visor_pdf.visible = false
//else

	f_pdf_vista_previa(nombre_archivo_pdf)
//end if


end subroutine

public function integer f_pdf_vista_previa (string fichero_pdf);//Comprobamos que existe el fichero antes de seguir
int vueltas, tamano

if dw_opciones.GetItemString(dw_opciones.GetRow(), 'desactivar_vista_previa') = 'S' then return 1

//Comprobramos que el archivo exista y sea de extensi$$HEX1$$f300$$ENDHEX$$n pdf... sino el ocx casca
//comprobamos tb q no tenga tama$$HEX1$$f100$$ENDHEX$$o 0KB
tamano = Ceiling(gnv_fichero.of_GetFileSize(fichero_pdf) / 1024)
if isnull(fichero_pdf) or not FileExists(fichero_pdf) or upper(RightA(fichero_pdf,4)) <> '.PDF' or tamano=0 then 
	st_imagen_no_disponible.visible = true
	ole_visor_pdf.visible = false
	return -1 
end if

i_error_ole = false // Si se produce un error se pondr$$HEX2$$e1002000$$ENDHEX$$a true

ole_visor_pdf.object.loadFile(fichero_pdf)

if (i_error_ole) then
	st_imagen_no_disponible.visible = true
	ole_visor_pdf.visible = false
	return -1
end if

vueltas = idw_docs.GetItemNumber(idw_docs.GetRow(),'volteo')

// para ver primera p$$HEX1$$e100$$ENDHEX$$gina completa
vueltas = vueltas * 90 
if vueltas > 0 then ole_visor_pdf.object.rotate = vueltas
//ole_visor_pdf.object.zoom = ole_visor_pdf.object.zoomPage 

ole_visor_pdf.enabled = false

st_imagen_no_disponible.visible = false
ole_visor_pdf.visible = true
gb_rotacion.visible = true
st_rotacion.visible = true
cb_voltear_pdf.visible = true


return 1
end function

public subroutine wf_insertar_fichero (string fichero);string ver_web_defecto,ruta_fichero
double tamano
long linea

ver_web_defecto = idw_configuracion_sello.getitemstring(1,'ver_web')

linea=idw_docs.find("nombre_fichero='" + fichero+"'",1,idw_docs.rowcount())
if linea<=0 then
	linea = idw_docs.insertrow(0)
	idw_docs.setitem(linea, 'id_fichero', f_siguiente_numero('FASES_DOCU_VISARED', 10))
	idw_docs.setitem(linea, 'id_fase', i_id_fase)
	idw_docs.setitem(linea, 'nombre_fichero', fichero)
	idw_docs.setitem(linea, 'ruta_fichero',f_visared_ruta_documentos(i_id_fase,'',2))
end if	

idw_docs.setitem(linea, 'sellado', 'N')
idw_docs.setitem(linea, 'fecha', today())	
idw_docs.setitem(linea, 'visualizar_web', ver_web_defecto)

//Ponemos el tama$$HEX1$$f100$$ENDHEX$$o
string anyo
anyo =left(idw_docs.getitemstring(linea,'ruta_fichero'),4)
ruta_fichero = f_obtener_ruta_base(anyo) + idw_docs.getitemstring(linea,'ruta_fichero') + idw_docs.getitemstring(linea,'nombre_fichero')
tamano = Ceiling(gnv_fichero.of_GetFileSize(ruta_fichero) / 1024)
idw_docs.setitem(linea,'tamano',string(tamano,"#,###,##0") + ' Kb')



	
idw_docs.setitem(linea, 'firmado', '')
	

end subroutine

public subroutine wf_anyadir_menu_grabar_datos (ref m_dw am_dw, u_dw dw_padre);

long submenus, i

// Menu personalizado con la opci$$HEX1$$f300$$ENDHEX$$n de grabar los datos por defecto
m_sellador_grabar_datos menu
menu = create m_sellador_grabar_datos
menu.idw_padre = dw_padre

// Copiamos las entradas de nuestro menu a las del dw
submenus = upperbound(am_dw.m_table.item)
for i = 1 to upperbound(menu.Item)
	submenus++
	am_dw.m_table.Item[submenus] = menu.Item[i]
next


end subroutine

public subroutine f_actualiza_num_documentos ();//Esta funci$$HEX1$$f300$$ENDHEX$$n actualiza el n$$HEX1$$fa00$$ENDHEX$$mero de documentos en el nombre de la pesta$$HEX1$$f100$$ENDHEX$$a
int cuantos

cuantos = idw_docs.rowcount()
if isnull(cuantos) then cuantos =0
tab_dir.tabpage_tv.text = 'Documentos ('+string(cuantos)+')'
end subroutine

public function integer f_incidencia (integer codigo, integer fila_documento);//Incorpora una incidencia seg$$HEX1$$fa00$$ENDHEX$$n el c$$HEX1$$f300$$ENDHEX$$digo introducido..
string fichero='',incidencia
int fila_inc

if not isnull(fila_documento) and fila_documento>0 then fichero = idw_docs.getitemstring(fila_documento,'nombre_fichero')

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

fila_inc = idw_incidencias.InsertRow(0)
idw_incidencias.SetItem(fila_inc,'incidencia',incidencia)
return 1
end function

on w_sellador_detalle_base.create
int iCurrent
call super::create
if this.MenuName = "m_sellador" then this.MenuID = create m_sellador
this.dw_fase=create dw_fase
this.gb_opciones=create gb_opciones
this.tab_dir=create tab_dir
this.dw_opciones=create dw_opciones
this.st_imagen_no_disponible=create st_imagen_no_disponible
this.ole_visor_pdf=create ole_visor_pdf
this.p_minist=create p_minist
this.st_rotacion=create st_rotacion
this.cb_voltear_pdf=create cb_voltear_pdf
this.gb_rotacion=create gb_rotacion
this.sle_certificado=create sle_certificado
this.st_estado_sellado=create st_estado_sellado
this.sle_dir=create sle_dir
this.gb_estado_sellado=create gb_estado_sellado
this.gb_dir=create gb_dir
this.gb_certificado=create gb_certificado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_fase
this.Control[iCurrent+2]=this.gb_opciones
this.Control[iCurrent+3]=this.tab_dir
this.Control[iCurrent+4]=this.dw_opciones
this.Control[iCurrent+5]=this.st_imagen_no_disponible
this.Control[iCurrent+6]=this.ole_visor_pdf
this.Control[iCurrent+7]=this.p_minist
this.Control[iCurrent+8]=this.st_rotacion
this.Control[iCurrent+9]=this.cb_voltear_pdf
this.Control[iCurrent+10]=this.gb_rotacion
this.Control[iCurrent+11]=this.sle_certificado
this.Control[iCurrent+12]=this.st_estado_sellado
this.Control[iCurrent+13]=this.sle_dir
this.Control[iCurrent+14]=this.gb_estado_sellado
this.Control[iCurrent+15]=this.gb_dir
this.Control[iCurrent+16]=this.gb_certificado
end on

on w_sellador_detalle_base.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_fase)
destroy(this.gb_opciones)
destroy(this.tab_dir)
destroy(this.dw_opciones)
destroy(this.st_imagen_no_disponible)
destroy(this.ole_visor_pdf)
destroy(this.p_minist)
destroy(this.st_rotacion)
destroy(this.cb_voltear_pdf)
destroy(this.gb_rotacion)
destroy(this.sle_certificado)
destroy(this.st_estado_sellado)
destroy(this.sle_dir)
destroy(this.gb_estado_sellado)
destroy(this.gb_dir)
destroy(this.gb_certificado)
end on

event open;call super::open;f_centrar_ventana(this)

//menu = create m_sellador_grabar_datos


i_id_fase = message.stringparm

idw_docs = tab_dir.tabpage_tv.dw_docs
idw_datos_sello = tab_dir.tabpage_1.dw_datos_firma
idw_opciones_sello = tab_dir.tabpage_1.dw_opciones_sello
idw_posiciones_sello = tab_dir.tabpage_1.dw_pos_sellos
idw_certificados = tab_dir.tabpage_2.dw_certificados
idw_configuracion_sello = tab_dir.tabpage_3.dw_configuracion_sello
idw_incidencias = tab_dir.tabpage_4.dw_incidencias


//Si tenemos la revision de firmas activa ponemos un dw, sino ponemos el otro
if g_activar_revision_firmas = 'N' then
	idw_docs.dataobject = 'd_sellador_documentos'
	idw_docs.settrans(sqlca)
end if

if g_colegio='COAATGUI' then
	idw_configuracion_sello.Object.firmar_documento.visible=true
	idw_configuracion_sello.Object.t_11.visible=true
else
	idw_configuracion_sello.Object.firmar_documento.visible=false
	idw_configuracion_sello.Object.t_11.visible=false
end if


dw_opciones.insertrow(0)
idw_configuracion_sello.insertrow(0)


dw_fase.retrieve(i_id_fase)

of_SetResize (true)
inv_resize.of_Register (dw_fase, "FixedToBottom")
inv_resize.of_Register (tab_dir, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_docs, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_datos_sello, "ScaletoBottom")
//inv_resize.of_Register (tab_dir.tabpage_1.gb_1, "ScaletoRight&Bottom")
//inv_resize.of_Register (idw_opciones_sello, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_certificados, "ScaletoRight&Bottom")
inv_resize.of_Register (tab_dir.tabpage_2.cb_anyadir_certificado, "FixedToBottom")
inv_resize.of_Register (idw_configuracion_sello, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_incidencias, "ScaletoRight&Bottom")
inv_resize.of_Register (gb_opciones, "FixedToRight")
inv_resize.of_Register (dw_opciones, "FixedToRight")
inv_resize.of_Register (gb_certificado, "ScaleToRight")
inv_resize.of_Register (sle_certificado, "ScaleToRight")
inv_resize.of_Register (gb_dir, "ScaleToRight")
inv_resize.of_Register (sle_dir, "ScaleToRight")
inv_resize.of_Register (gb_estado_sellado, "ScaleToRight")
inv_resize.of_Register (st_estado_sellado, "ScaleToRight")
inv_resize.of_Register (p_minist, "FixedToBottom")
inv_resize.of_Register (ole_visor_pdf, "FixedToBottom&ScaleToRight")
inv_resize.of_Register (st_imagen_no_disponible, "FixedToBottom&ScaleToRight")
inv_resize.of_Register (gb_rotacion, "FixedToBottom")
inv_resize.of_Register (st_rotacion, "FixedToBottom")
inv_resize.of_Register (cb_voltear_pdf, "FixedToBottom")



string n_reg, carpeta
boolean hay_docs

n_reg = f_dame_n_reg(i_id_fase)
//carpeta = g_directorio_pdf + 'REG' + n_reg
//Comprobamos si existe la carpeta del a$$HEX1$$f100$$ENDHEX$$o. Si no hay que crearla...

if not gnv_fichero.of_directoryexists(f_obtener_ruta_base(g_anyo_numeracion) + g_anyo_numeracion ) then
	gnv_fichero.of_createdirectory(f_obtener_ruta_base(g_anyo_numeracion) + g_anyo_numeracion )
end if

carpeta = f_visared_ruta_documentos(i_id_fase,'',1)
 
sle_dir.text = carpeta
is_CurrDir = carpeta

i_error_ole = false // Si se produce un error se pondr$$HEX2$$e1002000$$ENDHEX$$a true

end event

event close;call super::close;//Cerramos el fichero que tenga seleccionado el visor
//Si no lo deja abierto...

i_error_ole = false // Si se produce un error se pondr$$HEX2$$e1002000$$ENDHEX$$a true

if dw_opciones.getitemstring(1,'desactivar_vista_previa') = 'N' then
	ole_visor_pdf.Object.CloseFile()
end if


end event

event pfc_postopen;call super::pfc_postopen;string codigo_sello
int fila, i
double tamano
string fichero

f_recuperar_consulta_ventana(this, this.classname(), 'INICIO')



codigo_sello=idw_datos_sello.getitemstring(1,'sello')


if codigo_sello<>"" then
	idw_opciones_sello.retrieve(codigo_sello)
	idw_opciones_sello.sort()
	idw_posiciones_sello.retrieve(codigo_sello)
	idw_posiciones_sello.sort()	
end if

// Metemos el texto de notificaci$$HEX1$$f300$$ENDHEX$$n de visado en dw_opciones donde podr$$HEX2$$e1002000$$ENDHEX$$ser modificado a trav$$HEX1$$e900$$ENDHEX$$s de w_observaciones
if fileexists(g_directorio_rtf + "aviso_visado.txt") then
	string seccion
	if g_usuario = "COSTERA" or g_usuario = "SAFOR" then // El texto depende de la delegaci$$HEX1$$f300$$ENDHEX$$n
		seccion = "MENSAJE_" + g_usuario
	else
		seccion = "MENSAJE_GENERAL"
	end if
	i_mensaje_notificar_sellado = f_plantillas_estructura("aviso_visado.txt", seccion)
end if


if (g_sellador_certificado <> '' and g_sellador_password <> '') then
	sle_certificado.text = g_sellador_certificado
	fila = idw_certificados.event pfc_insertrow()
	idw_certificados.setitem(fila,'certificado',g_sellador_certificado)
	idw_certificados.setitem(fila,'password',g_sellador_password)
	for i = 1 to idw_certificados.rowcount()
		idw_certificados.setitem(i,'activo','N')
	next
	idw_certificados.setitem(fila,'activo','S')
else
	sle_certificado.text = 'Sin sesi$$HEX1$$f300$$ENDHEX$$n iniciada'
end if

//Comprobamos que el objeto ocx este registrado
oleobject obj_test
int retorno_test

obj_test = CREATE OLEObject
retorno_test = obj_test.connecttonewobject( "XpdfWrapper.XpdfWrapperControl")
destroy obj_test

if retorno_test < 0 then
	messagebox(g_titulo, "El visor de pdf's no est$$HEX2$$e1002000$$ENDHEX$$registrado correctamente, se deshabilitar$$HEX2$$e1002000$$ENDHEX$$la vista previa y la firma")
	dw_opciones.setitem(1,'desactivar_vista_previa','S')
   dw_opciones.setitem(1,'desactivar_ocx','S')
	dw_opciones.object.desactivar_vista_previa.visible = false
	dw_opciones.object.desactivar_ocx.visible = false
	st_imagen_no_disponible.visible = true
	ole_visor_pdf.visible = false
	gb_rotacion.visible = false
	st_rotacion.visible = false
	cb_voltear_pdf.visible = false
	m_sellador.m_file.m_vistaprevia.enabled = false
	m_sellador.m_file.m_firmar.enabled = false
	dw_opciones.accepttext()
else
	ole_visor_pdf.object.showscrollbars = false
	ole_visor_pdf.object.zoom = ole_visor_pdf.object.zoomPage
end if

idw_docs.retrieve(i_id_fase)

for i = 1 to idw_docs.rowcount()
	if idw_docs.getitemstring(i,'tamano') = '' or isnull (idw_docs.getitemstring(i,'tamano')) or idw_docs.getitemstring(i,'tamano') = '0 Kb' then
		string anyo
		anyo = left( idw_docs.getitemstring(i,'ruta_fichero'),4)
		fichero =f_obtener_ruta_base(anyo) + idw_docs.getitemstring(i,'ruta_fichero') + idw_docs.getitemstring(i,'nombre_fichero')
		tamano = Ceiling(gnv_fichero.of_GetFileSize(fichero) / 1024)
		idw_docs.setitem(i,'tamano',string(tamano,"#,###,##0") + ' Kb')
	end if
next
idw_docs.update()

idw_datos_sello.of_SetDropDownCalendar(True)
idw_datos_sello.iuo_calendar.of_register(idw_datos_sello.iuo_calendar.DDLB)
idw_datos_sello.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
idw_datos_sello.iuo_calendar.of_SetInitialValue(True)


end event

event pfc_preclose;call super::pfc_preclose;
idw_docs.update() // Por si se ha modificado el check de Ver en Web

return AncestorReturnValue

end event

type cb_recuperar_pantalla from w_csd_sheet`cb_recuperar_pantalla within w_sellador_detalle_base
end type

type cb_guardar_pantalla from w_csd_sheet`cb_guardar_pantalla within w_sellador_detalle_base
end type

type dw_fase from u_dw within w_sellador_detalle_base
integer x = 41
integer y = 1408
integer width = 2272
integer height = 436
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_sellador_datosexp"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = styleshadowbox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event retrieveend;call super::retrieveend;if rowcount>0 then
	idw_datos_sello.setitem(1,'f_visado',this.getitemdatetime(1,'f_visado'))
end if
end event

type gb_opciones from groupbox within w_sellador_detalle_base
integer x = 2272
integer y = 24
integer width = 1193
integer height = 344
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 77643992
string text = "Opciones"
end type

type tab_dir from tab within w_sellador_detalle_base
event create ( )
event destroy ( )
integer x = 18
integer y = 380
integer width = 3456
integer height = 996
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77643992
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_tv tabpage_tv
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_dir.create
this.tabpage_tv=create tabpage_tv
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_tv,&
this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_dir.destroy
destroy(this.tabpage_tv)
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

event constructor;tab_dir.tabpage_2.picturename = g_directorio_imagenes + '\certificado.gif'
end event

type tabpage_tv from userobject within tab_dir
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3419
integer height = 868
long backcolor = 74481808
string text = "Documentos"
long tabtextcolor = 8388608
long tabbackcolor = 74481808
string picturename = "ToDoList!"
long picturemaskcolor = 12632256
dw_docs dw_docs
end type

on tabpage_tv.create
this.dw_docs=create dw_docs
this.Control[]={this.dw_docs}
end on

on tabpage_tv.destroy
destroy(this.dw_docs)
end on

type dw_docs from u_dw within tabpage_tv
event csd_abrir ( )
event csd_enviar ( string tipo )
event csd_invertselection ( )
event csd_selectall ( )
event csd_anyadir ( )
event csd_borrar ( )
event csd_vista_previa ( )
event csd_seleccionar_web_todos ( )
event csd_seleccionar_web_ninguno ( )
event csd_revisar_firmas ( )
event csd_firmar ( )
event csd_editar ( )
integer x = 5
integer y = 4
integer width = 3387
integer height = 848
integer taborder = 30
string dataobject = "d_sellador_documentos_firmas"
boolean hscrollbar = true
boolean ib_rmbmenu = false
end type

event csd_abrir();string fichero,ruta, activo,ruta_base
double fila_seleccionada = 0
string extension

// Abriremos todos los seleccionados
activo = dw_opciones.getitemstring(1,'desactivar_ocx')


DO
	fila_seleccionada = this.getselectedrow(fila_seleccionada)
	if fila_seleccionada > 0 then
		fichero = this.getitemstring(fila_seleccionada, 'nombre_fichero')
		ruta = this.getitemstring(fila_seleccionada, 'ruta_fichero')
		ruta_base=f_obtener_ruta_base(left(ruta,4))
		//Comprobamos el tipo de fichero
		extension = UPPER(RightA(fichero,4))
		if not fileexists(ruta_base+ ruta + fichero) then
			messagebox(g_titulo, 'Fichero no encontrado')
			continue
		end if
		choose case extension
			case '.PDF'
				if activo = 'S' then
					f_abrir_fichero(ruta_base+ ruta, fichero, "")
				else
					this.event csd_vista_previa()
				end if
			case else
				f_abrir_fichero(ruta_base+ ruta, fichero, "")
		end choose
	end if
LOOP UNTIL fila_seleccionada <= 0
end event

event csd_enviar(string tipo);
nca_folderbrowse lnca_bff
string ls_A, fichero,ruta,id_fase,fase,n_expediente,email,anyo
integer i, retorno = 0,j
boolean b_error = false
double fila_seleccionada = 0
st_mail parametros
// Generar el paquete en un directorio temporal

//Cerramos el visor para que no bloquee los ficheros
ole_visor_pdf.Object.CloseFile()

// Realizar el envio
choose case upper(tipo)
	case 'EMAIL', 'MAIL', 'CORREO'
		if g_sistema_mailing='O' then  // Sistema de envio por mail antiguo (Usa el Outlook)
			open(w_mail_send)   
		else		// Sistema de envio de mails usando sockets
			parametros.asunto='Documentaci$$HEX1$$f300$$ENDHEX$$n Colegial'
			parametros.mensaje = 'N$$HEX2$$ba002000$$ENDHEX$$Registro: ' + dw_fase.getitemstring(1, 'fases_n_registro') + '; ' + &
	'N$$HEX2$$ba002000$$ENDHEX$$Exp: ' + dw_fase.getitemstring(1, 'fases_n_expedi') + '; ' + &
	'Fecha: ' + string(dw_fase.getitemdatetime(1, 'fases_f_entrada')) + '; ' + &
	'Emplazamiento: ' + dw_fase.getitemstring(1, 'fases_tipo_via_emplazamiento') + ' ' + dw_fase.getitemstring(1, 'compute_1') + '; ' + &
	'Fases: ' + dw_fase.getitemstring(1, 'fases_titulo')+ '; ' + &
	'Tipo de Trabajo: '+ dw_fase.getitemstring(1, 'fases_tipo_trabajo') + '; ' + &
	'Trabajo: ' + dw_fase.getitemstring(1, 'fases_trabajo')
	
		select c.email into :email from fases_colegiados fc,colegiados c 
		where fc.id_fase=:i_id_fase and fc.id_col=c.id_colegiado;
		parametros.direccion=email
			parametros.dw_adjuntos='d_email_adjuntos'
			j=0
			for i = 1 to idw_docs.rowcount()
				if idw_docs.isselected(i) then
					j++
					anyo = left(idw_docs.getitemstring(i,'ruta_fichero'),4)
					parametros.adjuntos[j]=	f_obtener_ruta_base(anyo)+idw_docs.getitemstring(i,'ruta_fichero')+idw_docs.getitemstring(i,'nombre_fichero')				
				end if
			next
			parametros.id_fase=i_id_fase
			OpenWithParm(w_csd_mail_send_sock,parametros)
			
		end if
	case 'FTP'
//		messagebox(g_titulo, 'Esta opci$$HEX1$$f300$$ENDHEX$$n debe crear un paquete de env$$HEX1$$ed00$$ENDHEX$$o y enviarlo por FTP a un servidor')		
//		open(w_ftp_put)
//		openwithparm(w_file_transfer, 'put')
	case 'MIPC', 'LOCAL'
		ls_A = lnca_BFF.BrowseForFolder( g_firmador, 'Seleccione el destino' )
		if f_es_vacio(ls_A) then return
		// Abriremos todos los seleccionados
		DO
			fila_seleccionada = this.getselectedrow(fila_seleccionada)
			if fila_seleccionada > 0 then
				fichero = this.getitemstring(fila_seleccionada, 'nombre_fichero')		
				ruta = this.getitemstring(fila_seleccionada, 'ruta_fichero')		
				if RightA(ls_a, 1) <> '\' then ls_A += '\'
				
				retorno = gnv_fichero.of_filecopy(f_obtener_ruta_base(left(ruta,4))+ruta + fichero, ls_A  +  fichero, FALSE)				
				if retorno < 0 then
					b_error = true
				end if
			end if
			
		LOOP UNTIL fila_seleccionada <= 0		
		
		if b_error = true then
			messagebox(g_titulo, 'Hubo errores en la copia')
		else
			messagebox(g_titulo, 'La copia se realiz$$HEX2$$f3002000$$ENDHEX$$con $$HEX1$$e900$$ENDHEX$$xito')			
		end if
//		messagebox(g_titulo, 'Esta opci$$HEX1$$f300$$ENDHEX$$n debe crear un paquete de env$$HEX1$$ed00$$ENDHEX$$o y copiarlo en ' + ls_A)
	case 'OTRAFASE'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Fases"
		g_busqueda.dw="d_lista_busqueda_fases"
		id_fase=f_busqueda_fases()
		select e.n_expedi,f.fase into :n_expediente,:fase from fases f,expedientes e 
		where f.id_fase=:id_fase and f.id_expedi=e.id_expedi;
		if not f_es_vacio(id_fase) then
			if MessageBox(g_titulo,"Se van a enviar los ficheros seleccionados a la fase "+n_expediente+"-"+fase+". $$HEX1$$bf00$$ENDHEX$$Estas seguro?",Question!,YesNo!)=1 then
				event csd_enviar_otra_fase(id_fase)
				event csd_boton_refrescar()
			end if
		end if
	
end choose

f_actualiza_vista_previa(this.getrow())

// Borrar el paquete temporal
end event

event csd_invertselection;long	ll_max
long	ll_i

// Get the row count.
ll_max = this.RowCount ( ) 

// Prevent flickering and improve performance.
this.SetReDraw ( FALSE ) 

// Invert row by row.
FOR ll_i = 1 to ll_max
	this.SelectRow ( ll_i, NOT (this.IsSelected(ll_i)) ) 
NEXT 

// Prevent flickering and improve performance.
this.SetReDraw ( TRUE ) 

end event

event csd_selectall;int i
for i = 1 to rowcount()
	selectrow(i, true)
next
end event

event csd_anyadir();string ruta_doc, nom_doc, ruta_dest, n_reg, ver_web_defecto
int valor, fila
int i,j,k
string fichero,fichero_destino
double tamano
u_revision_firmas revisor
int num_firmas,punto,contador=0
boolean firma_valida, certificados_validos
string estado
n_file_dialogs lnv_file_dialog

idw_docs.setredraw(false)
revisor = create u_revision_firmas

n_reg = f_dame_n_reg(i_id_fase)

//Permitimos que se puedan seleccionar varios ficheros
lnv_file_dialog.ib_allowmultiselect = true

valor = lnv_file_dialog.of_getopenfilename("Seleccionar Documento", ruta_doc, nom_doc,"", "Todos los archivos,*.*,")

n_cst_filesrvwin32 dire
dire = create n_cst_filesrvwin32

if valor = 1 then
	// Aqui se crea el directorio del registro y se copia el fichero
	gnv_fichero.of_createdirectory(is_currdir)
	//Recorremos el vector de nombres de ficheros seleccionados (todos de la misma ruta)

	for i = 1 to UpperBound(lnv_file_dialog.is_selectedfiles)
		
		firma_valida = true
		certificados_validos = true
		fichero_destino=lnv_file_dialog.is_selectedfiles[i]
		
		if Not(f_parsea_fichero(fichero_destino)) then
			MessageBox("Caracteres NO validos",fichero_destino+" contiene caracteres no validos",StopSign!)
			continue	
		end if
		
		//Para no sobreescribir el fichero, si el fichero ya existe se crea otro con la coletilla '_copia1','_copia2'...
		fichero_destino = f_nombre_fichero(fichero_destino)
			
		ruta_dest =  f_visared_ruta_documentos(i_id_fase,fichero_destino,0)
		gnv_fichero.of_filecopy(ruta_doc + "\" + lnv_file_dialog.is_selectedfiles[i], ruta_dest)
	
		fila = idw_docs.insertrow(0)
		idw_docs.setitem(fila, 'id_fichero', f_siguiente_numero('FASES_DOCU_VISARED', 10))
		idw_docs.setitem(fila, 'id_fase', i_id_fase)
		idw_docs.setitem(fila, 'nombre_fichero', fichero_destino)
		idw_docs.setitem(fila, 'ruta_fichero',f_visared_ruta_documentos(i_id_fase,'',2))
		idw_docs.setitem(fila, 'sellado', 'N')
		idw_docs.setitem(fila, 'fecha', today())
		ver_web_defecto = idw_configuracion_sello.getitemstring(1,'ver_web')
		idw_docs.setitem(fila,'visualizar_web', ver_web_defecto)	
		
		//Ponemos el tama$$HEX1$$f100$$ENDHEX$$o
		string anyo
		anyo = left(idw_docs.getitemstring(fila,'ruta_fichero'),4)
		fichero = f_obtener_ruta_base(anyo) + idw_docs.getitemstring(fila,'ruta_fichero') + idw_docs.getitemstring(fila,'nombre_fichero')
		tamano = Ceiling(dire.of_GetFileSize(fichero) / 1024)
		idw_docs.setitem(fila,'tamano',string(tamano,"#,###,##0") + ' Kb')

		//Si esta activa la verificacion de firmas, la hacemos, sino la ponemos a NO 
		if g_revisar_firmas = 'S' then
			//Leemos los datos de la firma del fichero solicitado
			revisor.is_nombre_fichero_pdf = fichero
			revisor.is_nombre_fichero_ini = LeftA(fichero,LenA(fichero) - 4) + ".ini"
			if g_revisar_certificados = 'S' then
				revisor.of_leer_certificado(true)
			else
				revisor.of_leer_certificado(false)
			end if

			//Cargamos los datos en el datawindow
			num_firmas = revisor.ii_num_firmas

			//Comprobamos la validez de las firmas
			for k = 1 to num_firmas
				if revisor.ib_firma_valida[k] = false or revisor.is_error_firma[k] = '-3' then
					firma_valida = false
				end if
			next

			for j = 1 to num_firmas
				if revisor.ib_certificado_valido[j] = false or revisor.is_error_firma[j] = '-2' or revisor.is_error_firma[j] = '-4'  then 
					certificados_validos = false
				end if
			next
		
			if num_firmas > 0 and firma_valida = true then
				estado = 'V'
			end if
		
			if num_firmas > 0 and firma_valida = false then
				estado = 'F'
			end if
		
			if num_firmas < 0 then
				estado = 'E'
			end if
		
			if num_firmas = 0 then
				estado = 'N'
			end if
			
			if certificados_validos = true and num_firmas > 0 then
				idw_docs.setitem(fila,'certificado_confianza','CV')
			else
				idw_docs.setitem(fila,'certificado_confianza','NV')		
			end if
			
			//Si no se revisa, los ponemos como no revisados
			if g_revisar_certificados = 'N' then
				idw_docs.setitem(fila,'certificado_confianza','NR')
			end if
			
			idw_docs.setitem(fila,'firmado',estado)
		else
			idw_docs.setitem(fila,'firmado','R')
			idw_docs.setitem(fila,'certificado_confianza','NR')
		end if
		
		idw_docs.update()
		idw_docs.retrieve(i_id_fase)
	next
end if
idw_docs.setredraw(true)
destroy dire
destroy revisor
end event

event csd_borrar();string fichero, mensaje = ''
boolean SI=true,borrar_zip=false,borrar_ficheros_del_zip=false
int lin,i,fila_zip
string nombre_zip, fichero_zip, nombre_fichero,nombre_fic_zip
double tamano
oleobject zip,files,oFile

if messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','El siguiente proceso borrar$$HEX2$$e1002000$$ENDHEX$$el/los fichero seleccionados de la lista.'+cr+'$$HEX1$$bf00$$ENDHEX$$Desea continuar?',Question!,YesNo!)=2 then return
lin = this.getrow()

//Cerramos el visor, pq si no bloquea el pdf y no lo podemos borrar
if dw_opciones.getitemstring(1,'desactivar_vista_previa') = 'N' then
	ole_visor_pdf.Object.CloseFile()
end if

lin = this.GetSelectedRow(0)

//Creamos el objeto zip
zip = create oleobject
zip.ConnectToNewObject("SAWZip.Archive")
nombre_zip = "VISADO_" + dw_fase.getitemstring(1,'n_expedi') + "_" + dw_fase.getitemstring(1,'fases_fase') + ".zip"
fichero_zip = sle_dir.text + nombre_zip

//Si existe el zip y NO est$$HEX2$$e1002000$$ENDHEX$$seleccionado para el borrado preguntamos si lo borramos.
if fileexists(fichero_zip) then	
	fila_zip = idw_docs.find("nombre_fichero='" + nombre_zip + "'",1,idw_docs.rowcount())
	if not(idw_docs.IsSelected(fila_zip)) then
		if MessageBox(g_titulo,"$$HEX1$$bf00$$ENDHEX$$Desea borrar los ficheros de dentro del .zip?",Question!,YesNo!)=1 then
			borrar_ficheros_del_zip=true
		end if
	end if	
end if



do while lin>0
	string anyo
	anyo = left(this.getitemstring(lin,'ruta_fichero'),4)
	fichero = f_obtener_ruta_base(anyo) + this.getitemstring(lin,'ruta_fichero') + this.getitemstring(lin,'nombre_fichero')
	nombre_fichero = this.getitemstring(lin,'nombre_fichero')
	//Borramos fisicamente el fichero
	filedelete(fichero)
	this.SetItem(lin,'borrar','S')
	lin = this.GetSelectedRow(lin)					
	
	//si esta el documento en el zip, lo borramos de ahi tambien
	if borrar_ficheros_del_zip and FileExists(fichero_zip) then
		zip.open(fichero_zip)
		fila_zip = idw_docs.find("nombre_fichero='" + nombre_zip + "'",1,idw_docs.rowcount())
		for i=0 to zip.files.count - 1
			nombre_fic_zip=zip.files[i].name
			if nombre_fic_zip=nombre_fichero then
				// Borramos y actualizamos el tama$$HEX1$$f100$$ENDHEX$$o del zip
				zip.files.remove(i)				
				tamano = Ceiling(gnv_fichero.of_GetFileSize(fichero_zip) / 1024)				
				idw_docs.setitem(fila_zip,'tamano',string(tamano,"#,###,##0") + ' Kb')
				// Si no quedan ficheros, generamos una marca para borrar el zip y quitarlo de
				// la lista cuando destruyamos el objeto
				if zip.files.count=0 then borrar_zip=true					

				exit
			end if			
		next			
		zip.close()		
	end if	
loop

destroy zip

if borrar_zip then 
	fila_zip = idw_docs.find("nombre_fichero='" + nombre_zip + "'",1,idw_docs.rowcount())
	filedelete(fichero_zip)
	this.deleterow(fila_zip)
	this.update()	
end if
	

for i = 1 to this.rowcount()
	if this.GetItemString(i,'borrar')='S' and (FileExists(fichero) = false) then 
		this.deleterow(i)
		i=0		
	end if
next

// Comprobamos que realmente se halla borrado, pues puede que este abierto en el Acrobat Reader
for i = 1 to this.rowcount()
 if this.GetItemString(i,'borrar')='S' and (FileExists(fichero) = true) then
	mensaje += 'El fichero ' + this.getitemstring(i,'nombre_fichero') + ' est$$HEX2$$e1002000$$ENDHEX$$siendo utilizado por otro proceso. Imposible borrar.' + cr
 end if
next


if not f_es_vacio(mensaje) then messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n', mensaje, Exclamation!)

this.update()


//Restauramos el visor
f_actualiza_num_documentos()
if dw_opciones.getitemstring(1,'desactivar_vista_previa') = 'N' then
	f_actualiza_vista_previa(this.getrow())
end if
end event

event csd_vista_previa();st_sellador_datos_abrir_pdf datos

datos.fila_seleccionada = dw_docs.getrow()

datos.ficheros = dw_docs

openwithparm(w_sellador_previsualizacion_pdf,datos)
end event

event csd_seleccionar_web_todos();int fila_seleccionada

fila_seleccionada = this.getselectedrow(0)

do while fila_seleccionada <> 0 
	this.setitem(fila_seleccionada,'visualizar_web','S')
	fila_seleccionada = this.getselectedrow(fila_seleccionada)
loop
end event

event csd_seleccionar_web_ninguno();int fila_seleccionada

fila_seleccionada = this.getselectedrow(0)

do while fila_seleccionada <> 0 
	this.setitem(fila_seleccionada,'visualizar_web','N')
	fila_seleccionada = this.getselectedrow(fila_seleccionada)
loop
end event

event csd_revisar_firmas();st_eimporta_validacion_certificado lst_validacion
u_revision_firmas revisor
int fila_seleccionada
string fichero_pdf
int num_firmas, num_revisiones
int fila_inc




fila_seleccionada = this.getselectedrow(0)
idw_incidencias.reset()
f_cambiar_directorio_activo(g_dir_aplicacion)

revisor = create u_revision_firmas	

revisor.is_claves_publicas=f_obtener_claves_publicas(dw_fase.GetItemSTring(dw_Fase.GetRow(),'id_fase'))

do while fila_seleccionada <> 0 

	//Revisamos la firma del documento
	string anyo
	anyo=left(idw_docs.getitemstring(fila_seleccionada,'ruta_fichero'),4)
	fichero_pdf = f_obtener_ruta_base(anyo) + idw_docs.getitemstring(fila_seleccionada,'ruta_fichero') + idw_docs.getitemstring(fila_seleccionada,'nombre_fichero')

	lst_validacion=revisor.of_revisar_fichero(fichero_pdf,true,true)

	this.setitem(fila_seleccionada,'firmado',lst_validacion.firma_valida)
	this.setitem(fila_seleccionada,'certificado_confianza',lst_validacion.certificado_valido)

//st_5.text=revisor.of_devolver_error(lst_validacion)
	if lst_validacion.firma_valida<>'V' or lst_validacion.certificado_valido<>'CV' then
		fila_inc = idw_incidencias.InsertRow(0)
		idw_incidencias.SetItem(fila_inc,'incidencia', idw_docs.getitemstring(fila_seleccionada,'nombre_fichero')+cr+revisor.of_devolver_error(lst_validacion))
	end if
	
	fila_seleccionada = this.getselectedrow(fila_seleccionada)

loop

this.update()

if idw_incidencias.rowcount() > 0 then
	tab_dir.tabpage_4.visible = true
	messagebox(g_titulo, 'Se han detectado problemas con algunas firmas o certificados')
else
	tab_dir.tabpage_4.visible = false
	messagebox(g_titulo, 'Revisi$$HEX1$$f300$$ENDHEX$$n de firmas finalizada')
end if





/*

int fila_seleccionada
u_revision_firmas revisor
string fichero_pdf
int num_firmas, num_revisiones
int fila_inc
boolean firma_valida = true, certificados_validos = true
string estado
int i,res

fila_seleccionada = this.getselectedrow(0)
idw_incidencias.reset()
f_cambiar_directorio_activo(g_dir_aplicacion)

revisor = create u_revision_firmas	

revisor.is_claves_publicas=f_obtener_claves_publicas(dw_fase.GetItemSTring(dw_Fase.GetRow(),'id_fase'))

do while fila_seleccionada <> 0 
	//Inicializamos
	firma_valida = true
	certificados_validos = true
	num_firmas = 0
	num_revisiones = 0
	
	
	//Revisamos la firma del documento
	string anyo
	anyo=left(idw_docs.getitemstring(fila_seleccionada,'ruta_fichero'),4)
	fichero_pdf = f_obtener_ruta_documentos(anyo) + idw_docs.getitemstring(fila_seleccionada,'ruta_fichero') + idw_docs.getitemstring(fila_seleccionada,'nombre_fichero')
	
	if upper(RightA(fichero_pdf,3))='PDF' then	
		//Leemos los datos de la firma del fichero solicitado
		revisor.is_nombre_fichero_pdf = fichero_pdf
		revisor.is_nombre_fichero_ini = LeftA(fichero_pdf,LenA(fichero_pdf) - 4) + ".ini"
		res=revisor.of_leer_certificado(true)
		
		if res<0 then	
			f_incidencia(res,fila_seleccionada)
			fila_seleccionada = this.getselectedrow(fila_seleccionada)
			continue
		end if
		
		num_firmas = revisor.ii_num_firmas
		num_revisiones = revisor.ii_num_revisiones

		//Cargamos los datos en el datawindow
		//Si es un documento firmado por el SICA, solo se tiene en cuenta la ultima firma
		if idw_docs.getitemstring(fila_seleccionada,'sellado') = 'S' and num_firmas > 0 then 
			if revisor.ib_firma_valida[num_firmas] = true then
				this.setitem(fila_seleccionada,'firmado','V')
			end if
		else
			for i = 1 to num_firmas
				if revisor.ib_firma_valida[i] = false or revisor.is_error_firma[i] = '-3' then
					firma_valida = false
					fila_inc = idw_incidencias.InsertRow(0)
					idw_incidencias.SetItem(fila_inc,'incidencia','Error ' + revisor.is_error_firma[i] + ' en la firma del fichero ' + idw_docs.getitemstring(fila_seleccionada,'nombre_fichero') + cr)				
					this.setitem(fila_seleccionada,'firmado','E')
				elseif revisor.ib_firma_caducada[i] = true then
					firma_valida = false
					fila_inc = idw_incidencias.InsertRow(0)
					idw_incidencias.SetItem(fila_inc,'incidencia','El PDF '+idw_docs.getitemstring(fila_seleccionada,'nombre_fichero')+' fue firmado por un certificado caducado ('+revisor.is_cn_certificado[i] + ')' + cr)						
				end if	
				
			next
		
			if num_firmas > 0 and firma_valida = true and num_firmas = num_revisiones then
				estado = 'V'
			end if
		
			if num_firmas > 0 and firma_valida = false then
				estado = 'F'
			end if
			
			if num_firmas > 0 and firma_valida = true and num_firmas <> num_revisiones then
				estado = 'F'
			end if
		
			if num_firmas < 0 then
				estado = 'E'
			end if
		
			if num_firmas = 0 then
				fila_inc = idw_incidencias.InsertRow(0)
				idw_incidencias.SetItem(fila_inc,'incidencia','Error. El fichero no est$$HEX2$$e1002000$$ENDHEX$$firmado' + cr)
				estado = 'N'
			end if
				
			this.setitem(fila_seleccionada,'firmado',estado)
		end if
		
		//Revisamos los certificados
		for i = 1 to num_firmas
			
			
			if revisor.ib_certificado_valido[i] = false or revisor.is_error_firma[i] = '-2' or revisor.is_error_firma[i] = '-4' then 
				certificados_validos = false
				fila_inc = idw_incidencias.InsertRow(0)
//				idw_incidencias.SetItem(fila_inc,'incidencia','Error ' + revisor.is_error_firma[i] + ' en el certificado del fichero ' + idw_docs.getitemstring(fila_seleccionada,'nombre_fichero') + cr)
				idw_incidencias.SetItem(fila_inc,'incidencia','Error en la clave publica de '+revisor.is_cn_certificado[i] + ' ('+ idw_docs.getitemstring(fila_seleccionada,'nombre_fichero') + ')' + cr)				
			elseif revisor.ib_firma_caducada[i] = true then
				certificados_validos = false
			end if
		next
		
		if num_firmas > 0 and certificados_validos = true then
			this.setitem(fila_seleccionada,'certificado_confianza','CV')
		else
			this.setitem(fila_seleccionada,'certificado_confianza','NV')		
		end if	
		
	else
		//Ponemos codigos que no quiren decir nada para que no aparezca el simbolo
		this.setitem(fila_seleccionada,'firmado','Z')
		this.setitem(fila_seleccionada,'certificado_confianza','ZZ')
	end if
	
	fila_seleccionada = this.getselectedrow(fila_seleccionada)
	
loop

//Borramos el objeto
destroy revisor

this.update()

if idw_incidencias.rowcount() > 0 then
	tab_dir.tabpage_4.visible = true
	messagebox(g_titulo, 'Se han detectado problemas con algunas firmas o certificados')
else
	tab_dir.tabpage_4.visible = false
	messagebox(g_titulo, 'Revisi$$HEX1$$f300$$ENDHEX$$n de firmas finalizada')
end if


*/
end event

event csd_firmar();string sello, fichero
string array_vacio[]


idw_datos_sello.accepttext()

if of_accepttext(true) < 0 then return

if this.getselectedrow(0) <= 0 then 
	close(w_eimporta_procesando)	
	messagebox(g_titulo, 'Debe seleccionar ficheros para firmarlos.' + cr + 'Utilice el rat$$HEX1$$f300$$ENDHEX$$n y las teclas Shift y Ctrl para una selecci$$HEX1$$f300$$ENDHEX$$n m$$HEX1$$fa00$$ENDHEX$$ltiple.')
	return
end if

// Guardaremos en i_ficheros_firmados el id de los documentos que se han firmado
i_ficheros_firmados = array_vacio
i_ficheros_sellados = array_vacio
// Comprobamos  que se han seleccionado documentos, certificados y los datos del sello
//if event csd_comprobacion_datos() = -1 then return

//Cerramos el fichero del visor.. porque si no lo bloquea y no podemos
//leerlo con las funciones del objeto de ficheros de las pfc's..
ole_visor_pdf.Object.CloseFile()

// Obtenemos el nombre del fichero xml del sello avanzado. Si no se ha especificado ninguno se usa el sello antiguo
sello = idw_datos_sello.getitemstring(1,'sello')

//Obligamos a q pongan algun sello
if f_es_vacio(sello) then
	close(w_eimporta_procesando)	
	messagebox(g_titulo, 'Debe seleccionar alg$$HEX1$$fa00$$ENDHEX$$n sello para firmar.')
	return
end if

if not f_es_vacio(sello) then
	select fichero into :fichero from t_sello where codigo = :sello;
end if

if f_es_vacio(fichero) then
	
	//** SELLO ANTIGUO (STAMPPDF) **//
	
	if idw_configuracion_sello.GetItemString(1,'firmar_documento')='S' then
		if event csd_comprobacion_datos() = -1 then 
			close(w_eimporta_procesando)
			return
		end if
	else	
		if event csd_comprobacion_datos_sin_firma() = -1 then 
			close(w_eimporta_procesando)
			return		
		end if
	end if 
	
	event csd_visa_ficheros()
	
else
	// Comprobamos  que se han seleccionado documentos, certificados y los datos del sello
	if event csd_comprobacion_datos() = -1 then 
		close(w_eimporta_procesando)
		return
	end if

	//** SELLO NUEVO (SIGNERPDF) **//
	
	event csd_visa_ficheros_avanzado(fichero)

	
end if



//Procesos a realizar posteriormente al sellado de todos los ficheros...
f_actualiza_vista_previa(this.getrow())
f_actualiza_num_documentos()

if idw_configuracion_sello.GetItemString(1, 'notificar_sellado_por_email') = 'S' then
	event csd_notificar_sellado_por_email()
end if

close(w_eimporta_procesando)
end event

event csd_editar();integer li_rc
string nombre,ruta,anyo

OpenWithParm(w_sellador_cambio_nombre,idw_docs.GetItemString(idw_docs.GetRow(),'nombre_fichero'))
nombre=Message.StringParm

if nombre<>'-1' then 
	anyo = left(idw_docs.GetItemString(idw_docs.GetRow(),'ruta_fichero'),4)
	ruta=f_obtener_ruta_base(anyo)+idw_docs.GetItemString(idw_docs.GetRow(),'ruta_fichero')
	ole_visor_pdf.Object.CloseFile()
	if MessageBox(g_titulo,"$$HEX1$$bf00$$ENDHEX$$Desea cambiar el nombre del fichero del disco duro?",Question!,YesNo!)=1 then
		li_rc=gnv_fichero.of_filerename(ruta+idw_docs.GetItemString(idw_docs.GetRow(),'nombre_fichero'),ruta+nombre)		
	end if
	
	if li_rc=-1 then
		MessageBox(g_titulo,"Ocurrio un error al cambiar de nombre el archivo. El archivo puede no existir o estar en uso.",StopSign!)
	else 
		idw_docs.SetItem(idw_docs.GetRow(),'nombre_fichero',nombre)
		idw_docs.update()
	end if
	
end if



end event

event constructor;call super::constructor;of_setrowselect(true)
of_setrowmanager(true)
// Orden
of_setsort(true)
inv_sort.of_SetColumnHeader (true)
inv_sort.of_SetStyle (2)
// Multiseleccion
this.inv_rowselect.of_SetStyle (this.inv_rowselect.EXTENDED)

//Ponemos las imagenes del datawindows
this.object.p_1.Filename = g_directorio_imagenes + "v.gif"
this.object.p_2.Filename = g_directorio_imagenes + "x.gif"
this.object.p_3.Filename = g_directorio_imagenes + "i.gif"
this.object.p_4.Filename = g_directorio_imagenes + "v.gif"
this.object.p_5.Filename = g_directorio_imagenes + "x.gif"
this.object.p_6.Filename = g_directorio_imagenes + "i.gif"

end event

event rbuttonup;call super::rbuttonup;m_sellador_docs menu
m_sellador_docs_sinlineas menu_sinlineas


if this.getrow() < 0 then 
	return
elseif this.getrow() = 0 then 
	menu_sinlineas = create m_sellador_docs_sinlineas
	menu_sinlineas.idw_padre = this		
	menu_sinlineas.PopMenu(w_aplic_frame.PointerX() + 5, w_aplic_frame.PointerY() + 10)	
	destroy menu_sinlineas	
else
	menu = create m_sellador_docs
	menu.idw_padre = this		
	menu.PopMenu(w_aplic_frame.PointerX() + 5, w_aplic_frame.PointerY() + 10)
	destroy menu
end if





end event

event doubleclicked;call super::doubleclicked;string texto

if dwo.name = 'info_adicional' then
	texto = this.getitemstring(row,'info_adicional')
	openwithparm(w_observaciones,texto)
	texto = Message.Stringparm
	if texto <> '-1' then
		this.setitem(row,'info_adicional',texto)
		this.update()
	end if
else
	this.event csd_abrir()
end if
end event

event rowfocuschanged;call super::rowfocuschanged;f_actualiza_vista_previa(currentrow)
return 1
end event

event retrieveend;call super::retrieveend;//Mostramos la vista previa del primer
DataWindowChild dwc_tipo_doc
if rowcount()=0 then return
idw_docs.GetChild('tipo_documento',dwc_tipo_doc)	
/*
dwc_tipo_doc.SetTransObject(SQLCA)
dwc_tipo_doc.retrieve()*/
dwc_tipo_doc.SetFilter("visared='S'")
dwc_tipo_doc.Filter()


this.SetRow(1)
f_actualiza_num_documentos()
f_actualiza_vista_previa(1)


end event

event key;call super::key;/*if key = KeyDelete! then
	this.event csd_borrar()
end if

if key = KeyEnd! then
	this.ScrollToRow(this.rowcount())
	this.SetRow(this.rowcount())
end if

if key = KeyHome! then
	this.ScrollToRow(1)
	this.SetRow(1)
end if*/
end event

event buttonclicked;call super::buttonclicked;string fichero

choose case dwo.name
	case 'b_firmas'
		//Abrimos la ventana con los datos de las firmas del documento
		string anyo
		anyo = left(this.getitemstring(row,'ruta_fichero'),4)
		fichero = f_obtener_ruta_base(anyo) + this.getitemstring(row,'ruta_fichero') + this.getitemstring(row,'nombre_fichero')
		openwithparm(w_sellador_info_firmas, fichero)
	case 'b_backup'
		string is_fichero
		long is_error_copia
		is_fichero = this.GetItemString(row,'id_fichero')
		if not f_es_vacio(is_fichero) then
			is_error_copia = f_generar_xml_tg(i_id_fase,is_fichero)
			if is_error_copia >= 0 then
				MessageBox(g_titulo,"Proceso finalizado correctamente")
				i_generar_xml_alfresco=false
			elseif is_error_copia = -1 then
				MessageBox(g_titulo,"No se tienen permisos sobre el directorio de backup. Consulte con su administrador del sistema.")
			else
				MessageBox(g_titulo,"Ha ocurrido un error al generar los ficheros de Backup.")
			end if
		end if	
end choose

end event

type tabpage_1 from userobject within tab_dir
integer x = 18
integer y = 112
integer width = 3419
integer height = 868
long backcolor = 77643992
string text = "Datos Sello"
long tabtextcolor = 8388608
long tabbackcolor = 77643992
string picturename = "UpdateReturn!"
long picturemaskcolor = 536870912
dw_pos_sellos dw_pos_sellos
dw_opciones_sello dw_opciones_sello
dw_datos_firma dw_datos_firma
gb_1 gb_1
gb_3 gb_3
end type

on tabpage_1.create
this.dw_pos_sellos=create dw_pos_sellos
this.dw_opciones_sello=create dw_opciones_sello
this.dw_datos_firma=create dw_datos_firma
this.gb_1=create gb_1
this.gb_3=create gb_3
this.Control[]={this.dw_pos_sellos,&
this.dw_opciones_sello,&
this.dw_datos_firma,&
this.gb_1,&
this.gb_3}
end on

on tabpage_1.destroy
destroy(this.dw_pos_sellos)
destroy(this.dw_opciones_sello)
destroy(this.dw_datos_firma)
destroy(this.gb_1)
destroy(this.gb_3)
end on

type dw_pos_sellos from u_dw within tabpage_1
integer x = 3479
integer y = 80
integer width = 1061
integer height = 716
integer taborder = 11
string dataobject = "d_posiciones_sellos"
boolean border = false
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;//cuando se seleccione 1posicion se tienen q poner los valores en el dwconfiguracion_sello
double posx, posy, mv, mh
string activo, pos

//activo =  this.getitemstring(row, 'activo')
if data='S' then 
	pos = this.getitemstring(row, 'posicion')
	posx = this.getitemnumber(row, 'x')
	posy = this.getitemnumber(row, 'y')
	mv = this.getitemnumber(row, 'margen_vertical')
	mh = this.getitemnumber(row, 'margen_horizontal')
	idw_configuracion_sello.setitem(1, 'posicion', pos)
	idw_configuracion_sello.setitem(1, 'x', posx)
	idw_configuracion_sello.setitem(1, 'y', posy)
	idw_configuracion_sello.setitem(1, 'margen_vertical', mv)
	idw_configuracion_sello.setitem(1, 'margen_horizontal', mh)
end if


end event

event retrieveend;call super::retrieveend;long i

if  rowcount <= 0 then			 						
	this.visible = false
	gb_3.visible = false
end if

for i=1 to rowcount
	if this.GetItemString(i,'defecto')='S' then
		this.SetItem(i,'activo','S')
		this.event itemchanged(i,this.Object.activo,'S')
		exit
	end if
next
end event

type dw_opciones_sello from u_dw within tabpage_1
integer x = 2053
integer y = 92
integer width = 1376
integer height = 716
integer taborder = 21
string dataobject = "d_textos_sellos"
boolean border = false
borderstyle borderstyle = styleshadowbox!
boolean ib_isupdateable = false
end type

event buttonclicked;call super::buttonclicked;string obser

g_busqueda.titulo="Texto Clausula"
obser    =this.GetItemString(row, 'texto')
openwithparm(w_observaciones, obser)
if Message.Stringparm <> '-1' then
	obser = Message.Stringparm
	if not isnull(obser) then 
		this.SetItem(row,'texto',obser)
	end if 	
end if
end event

event retrieveend;call super::retrieveend;if  rowcount > 0 then			 						
	this.sort()
else
	this.visible = false
	gb_1.visible = false
end if
end event

type dw_datos_firma from u_dw within tabpage_1
event csd_grabar_datos ( )
integer x = 23
integer y = 28
integer width = 1984
integer height = 820
integer taborder = 11
string dataobject = "d_datos_firmador"
boolean hscrollbar = true
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event csd_grabar_datos();datetime f_visado, f_nula

if messagebox(g_titulo, "Se sobrescribir$$HEX1$$e100$$ENDHEX$$n los datos por defecto. $$HEX1$$bf00$$ENDHEX$$Seguro que desea continuar?", Question!, YesNo!, 1) = 1 then
	f_visado = idw_datos_sello.getitemdatetime(1,'f_visado')
	if not isnull(f_visado) then
		messagebox(g_titulo,'Atenci$$HEX1$$f300$$ENDHEX$$n, la fecha de visado NO se grabar$$HEX2$$e1002000$$ENDHEX$$como dato por defecto.',Information!)
		setnull(f_nula)
		idw_datos_sello.setitem(1,'f_visado',f_nula)
	end if
	f_grabar_consulta_un_dw(this,tab_dir.getparent().classname(),'INICIO')
	idw_datos_sello.setitem(1,'f_visado',f_visado)
end if
end event

event constructor;call super::constructor;this.insertRow(0)

end event

event itemchanged;call super::itemchanged;string codigo_sello

choose case dwo.name
	case 'sello'
		//tenemos q tener en cuenta ahora los 2gb y sus dws
		codigo_sello=data	
		gb_1.visible = true
		gb_3.visible = true
		dw_opciones_sello.visible = true
		dw_pos_sellos.visible = true		
	
		dw_opciones_sello.retrieve(codigo_sello)	
		dw_pos_sellos.retrieve(codigo_sello)


end choose

end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_dash11.visible = False
am_dw.m_table.m_insert.visible = False
am_dw.m_table.m_addrow.visible = False
am_dw.m_table.m_delete.visible = False

wf_anyadir_menu_grabar_datos(am_dw, this)

end event

type gb_1 from groupbox within tabpage_1
integer x = 2043
integer y = 28
integer width = 1403
integer height = 800
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 77643992
string text = "Textos"
end type

type gb_3 from groupbox within tabpage_1
integer x = 3465
integer y = 28
integer width = 1088
integer height = 800
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 77643992
string text = "Posiciones"
end type

type tabpage_2 from userobject within tab_dir
integer x = 18
integer y = 112
integer width = 3419
integer height = 868
long backcolor = 77643992
string text = "Certificados"
long tabtextcolor = 8388608
long tabbackcolor = 77643992
string picturename = ".\Imagenes\certificado.gif"
long picturemaskcolor = 536870912
cb_anyadir_certificado cb_anyadir_certificado
dw_certificados dw_certificados
end type

on tabpage_2.create
this.cb_anyadir_certificado=create cb_anyadir_certificado
this.dw_certificados=create dw_certificados
this.Control[]={this.cb_anyadir_certificado,&
this.dw_certificados}
end on

on tabpage_2.destroy
destroy(this.cb_anyadir_certificado)
destroy(this.dw_certificados)
end on

type cb_anyadir_certificado from commandbutton within tabpage_2
integer x = 32
integer y = 752
integer width = 425
integer height = 92
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "A$$HEX1$$f100$$ENDHEX$$adir Certificado"
end type

event clicked;int fila, i
string certificado

//openwithparm(w_certificados, dw_certificados.getitemstring(1,'certificado'))
open(w_certificados)
certificado = message.stringparm
if certificado = '' then return
fila=dw_certificados.insertRow(0)
dw_certificados.setitem(fila,'certificado', certificado)
for i = 1 to idw_certificados.rowcount()
	idw_certificados.setitem(i,'activo','N')
next
idw_certificados.setitem(fila,'activo', 'S')

end event

type dw_certificados from u_dw within tabpage_2
event csd_grabar_datos ( )
integer x = 23
integer y = 28
integer width = 3387
integer height = 712
integer taborder = 11
string dataobject = "d_sellador_certificados"
boolean hscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event csd_grabar_datos();if messagebox(g_titulo, "Se sobrescribir$$HEX1$$e100$$ENDHEX$$n los datos por defecto. $$HEX1$$bf00$$ENDHEX$$Seguro que desea continuar?", Question!, YesNo!, 1) = 1 then
	f_grabar_consulta_un_dw(this,tab_dir.getparent().classname(),'INICIO')
end if
end event

event buttonclicked;call super::buttonclicked;string certificado
int i

choose case dwo.name
	case 'b_cert'
		openwithparm(w_certificados, this.getitemstring(row,'certificado'))
		certificado = message.stringparm
		if certificado = '' then return
		this.setitem(row,'certificado', certificado)
		for i = 1 to idw_certificados.rowcount()
			idw_certificados.setitem(i,'activo','N')
		next
		this.setitem(row,'activo', 'S')
end choose
end event

event itemchanged;call super::itemchanged;int i

//Siempre debe de haber por lo menos uno activo
choose case dwo.name
	case 'activo'
		for i = 1 to this.rowcount()
			if row <> i then 
				this.setitem(i,'activo','N')
			else
				this.post setitem(i,'activo','S')
			end if
		next
	case 'tipo'
		if data='N' then
			open(w_seleccion_certificado)
			certificado_id=Message.StringParm
			if f_es_vacio(certificado_id) then return 2
			idw_certificados.SetItem(row,'navegador',certificado_id)
		end if
end choose
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;wf_anyadir_menu_grabar_datos(am_dw, this)
end event

type tabpage_3 from userobject within tab_dir
integer x = 18
integer y = 112
integer width = 3419
integer height = 868
long backcolor = 77643992
string text = "Opciones Avanzadas"
long tabtextcolor = 8388608
long tabbackcolor = 77643992
string picturename = "Properties!"
long picturemaskcolor = 536870912
dw_configuracion_sello dw_configuracion_sello
end type

on tabpage_3.create
this.dw_configuracion_sello=create dw_configuracion_sello
this.Control[]={this.dw_configuracion_sello}
end on

on tabpage_3.destroy
destroy(this.dw_configuracion_sello)
end on

type dw_configuracion_sello from u_dw within tabpage_3
event csd_permisos ( )
event csd_actualizar_encriptar ( )
event csd_grabar_datos ( )
integer x = 23
integer y = 28
integer width = 3387
integer height = 820
integer taborder = 11
string dataobject = "d_configuracion_sello"
boolean hscrollbar = true
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event csd_actualizar_encriptar();string modificacion,acceso,copia,impresion,impresion_ar,comentarios,relleno,ensamblaje
boolean contrase$$HEX1$$f100$$ENDHEX$$a
string password_pdf

modificacion = getitemstring(1,'nomodify')
acceso = getitemstring(1,'noaccess')
copia = getitemstring(1,'nocopy')
impresion = getitemstring(1,'noprint')
impresion_ar = getitemstring(1,'nohighres')
comentarios = getitemstring(1,'nonotes')
relleno = getitemstring(1,'nofill')
ensamblaje = getitemstring(1,'noassembly')

contrase$$HEX1$$f100$$ENDHEX$$a = modificacion = 'S' or acceso = 'S' or copia ='S' or impresion = 'S' or impresion_ar ='S' or comentarios = 'S' or relleno = 'S' or ensamblaje = 'S'

if contrase$$HEX1$$f100$$ENDHEX$$a then
	setitem(1,'encriptar','S')
	password_pdf = f_password()
	setitem(1,'password',password_pdf)
	setitem(1,'password2',password_pdf)
else
	setitem(1,'encriptar','N')
	setitem(1,'password','')
	setitem(1,'password2','')
end if

end event

event csd_grabar_datos();if messagebox(g_titulo, "Se sobrescribir$$HEX1$$e100$$ENDHEX$$n los datos por defecto. $$HEX1$$bf00$$ENDHEX$$Seguro que desea continuar?", Question!, YesNo!, 1) = 1 then
	f_grabar_consulta_un_dw(this,tab_dir.getparent().classname(),'INICIO')
end if
end event

event clicked;call super::clicked;idw_configuracion_sello.AcceptText()


end event

event itemerror;call super::itemerror;return 3
end event

event itemchanged;call super::itemchanged;string nulo
decimal nula


setnull(nulo)
setnull(nula)



choose case dwo.name
	case 'nomodify', 'noaccess', 'nocopy', 'noprint', 'nohighres', 'nonotes', 'nofill', 'noassembly'
		
		this.post event csd_actualizar_encriptar()
		
	case 'encriptar'
		if data = "N" then 
		 idw_configuracion_sello.SetItem(1,'password', nulo)
		 idw_configuracion_sello.SetItem(1,'password2', nulo) 
		 
		 idw_configuracion_sello.SetItem(1,'userpass', nulo)
		 idw_configuracion_sello.SetItem(1,'userpass2', nulo) 
		 
		 idw_configuracion_sello.SetItem(1,'nomodify', "N") 
		 idw_configuracion_sello.SetItem(1,'noassembly', "N") 
		 idw_configuracion_sello.SetItem(1,'nonotes', "N") 
		 idw_configuracion_sello.SetItem(1,'nofill', "N") 
		 idw_configuracion_sello.SetItem(1,'nohighres', "N") 
		 idw_configuracion_sello.SetItem(1,'nocopy', "N")  
		 idw_configuracion_sello.SetItem(1,'noaccess', "N") 
		 idw_configuracion_sello.SetItem(1,'noprint', "N") 
		 idw_configuracion_sello.SetItem(1,'habilitar_userpass', "N") 
		end if	
	case 'habilitar_userpass'
		if data = "N" then 
		 idw_configuracion_sello.SetItem(1,'userpass', nulo)
		 idw_configuracion_sello.SetItem(1,'userpass2', nulo) 
		end if
	case 'posicion'
		if data = "L" then
			idw_configuracion_sello.object.gb_margen.text='Coordenadas'			
		else
			idw_configuracion_sello.object.gb_margen.text='M$$HEX1$$e100$$ENDHEX$$rgenes'
			idw_configuracion_sello.SetItem(1,'x', nula)
			idw_configuracion_sello.SetItem(1,'y', nula)
		end if
end choose

end event

event buttonclicked;call super::buttonclicked;string texto, ls_fichero_pdf,cadena
st_sello posiciones
long currentrow

choose case dwo.name
	case 'b_texto'
		g_busqueda.titulo="Texto del aviso"
		texto = this.GetItemString(row, 'texto_aviso')
		openwithparm(w_observaciones, texto)
		if Message.Stringparm <> '-1' then
			texto = Message.Stringparm
			if not isnull(texto) then 
				this.SetItem(row,'texto_aviso',texto)
			end if
		end if
	case 'b_obtener'
		currentrow = idw_docs.getrow()		
		if currentrow <= 0 then return
		string anyo
		anyo = left( idw_docs.getitemstring(currentrow,'ruta_fichero'),4)
		ls_fichero_pdf = f_obtener_ruta_base(anyo) + idw_docs.getitemstring(currentrow,'ruta_fichero') + "\" + idw_docs.getitemstring(currentrow,'nombre_fichero')
		
		if Not(FileExists(ls_fichero_pdf)) then
			MessageBox("Fichero No encontrado","No se ha encontrado el fichero "+ls_fichero_pdf )
			return
		end if
		
		// Se pasa como parametro una cadena con el nombre del fichero y la rotacion, separados por '::'
		// De esta forma evitamos tener que hacer un struct para dos campos
		cadena=ls_fichero_pdf+'::'+st_rotacion.text
		openWithParm(w_sellador_posic,cadena) //ls_fichero_pdf)
		posiciones=Message.PowerObjectParm
		if IsValid(posiciones) then
			if Not(IsNull(posiciones)) then
				idw_configuracion_sello.SetItem(1,'x', posiciones.x)
				idw_configuracion_sello.SetItem(1,'y', posiciones.y)
			end if
		end if

end choose

end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_dash11.visible = False
am_dw.m_table.m_insert.visible = False
am_dw.m_table.m_addrow.visible = False
am_dw.m_table.m_delete.visible = False

wf_anyadir_menu_grabar_datos(am_dw, this)

end event

type tabpage_4 from userobject within tab_dir
boolean visible = false
integer x = 18
integer y = 112
integer width = 3419
integer height = 868
long backcolor = 77643992
string text = "Incidencias"
long tabtextcolor = 8388608
long tabbackcolor = 77643992
string picturename = "Watcom!"
long picturemaskcolor = 536870912
dw_incidencias dw_incidencias
end type

on tabpage_4.create
this.dw_incidencias=create dw_incidencias
this.Control[]={this.dw_incidencias}
end on

on tabpage_4.destroy
destroy(this.dw_incidencias)
end on

type dw_incidencias from u_dw within tabpage_4
integer x = 23
integer y = 28
integer width = 3387
integer height = 820
integer taborder = 11
string dataobject = "d_sellador_incidencias"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type dw_opciones from u_dw within w_sellador_detalle_base
event csd_grabar_datos ( )
integer x = 2286
integer y = 72
integer width = 1161
integer height = 276
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_sellador_opciones"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
end type

event csd_grabar_datos;if messagebox(g_titulo, "Se sobrescribir$$HEX1$$e100$$ENDHEX$$n los datos por defecto. $$HEX1$$bf00$$ENDHEX$$Seguro que desea continuar?", Question!, YesNo!, 1) = 1 then
	f_grabar_consulta_un_dw(this,parent.classname(),'INICIO')
end if
end event

event itemchanged;call super::itemchanged;string ls_firmados

i_error_ole = false // Si se produce un error se pondr$$HEX2$$e1002000$$ENDHEX$$a true

choose case dwo.name
	case 'ver_documentos'
		choose case data
			case 'T' // Todos
				idw_docs.setfilter("")
				idw_docs.filter()
			case 'F' // S$$HEX1$$f300$$ENDHEX$$lo documentos FIRMADOS
				idw_docs.setfilter(" sellado = 'S' ")
				idw_docs.filter()	
			case 'S' // S$$HEX1$$f300$$ENDHEX$$lo documentos SIN FIRMAR
				idw_docs.setfilter(" sellado = 'N' ")
				idw_docs.filter()		
			case 'P' // S$$HEX1$$f300$$ENDHEX$$lo documentos POR FIRMAR
				//Conseguimos los ficheros ya firmados
				idw_docs.setfilter("")
				idw_docs.filter()
				ls_firmados = 	wf_ficheros_firmados() // Lista de ficheros firmados que no est$$HEX1$$e100$$ENDHEX$$n filtrados
				if ls_firmados <> '' then
					idw_docs.setfilter(" id_fichero NOT IN (" + ls_firmados + ") AND sellado = 'N' ")
					idw_docs.filter()	
				end if
			case 'D' // S$$HEX1$$f300$$ENDHEX$$lo documentos
				idw_docs.setfilter("upper(right(nombre_fichero, 4)) = '.PDF'")
				idw_docs.filter()
		end choose

	case 'desactivar_vista_previa'
		if data = 'S' then 
			ole_visor_pdf.Object.CloseFile()
			cb_voltear_pdf.visible = false
		else
			cb_voltear_pdf.visible = true
		end if		
end choose
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_dash11.visible = False
am_dw.m_table.m_insert.visible = False
am_dw.m_table.m_addrow.visible = False
am_dw.m_table.m_delete.visible = False

wf_anyadir_menu_grabar_datos(am_dw, this)
end event

type st_imagen_no_disponible from statictext within w_sellador_detalle_base
boolean visible = false
integer x = 2373
integer y = 1404
integer width = 1097
integer height = 840
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Imagen NO Disponible"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type ole_visor_pdf from olecustomcontrol within w_sellador_detalle_base
integer x = 2373
integer y = 1404
integer width = 1317
integer height = 768
integer taborder = 160
boolean bringtotop = true
borderstyle borderstyle = styleshadowbox!
long backcolor = 16777215
boolean focusrectangle = false
string binarykey = "w_sellador_detalle_base.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type p_minist from u_p within w_sellador_detalle_base
integer x = 41
integer y = 2052
integer width = 1669
integer height = 200
string picturename = "IMAGENES\logo_hor_pq.gif"
end type

event constructor;call super::constructor;this.picturename= g_directorio_imagenes + 'logo_hor_pq.gif'

if not fileexists(g_directorio_imagenes + 'logo_hor_pq.gif') then this.visible = false
end event

type st_rotacion from statictext within w_sellador_detalle_base
integer x = 1975
integer y = 1964
integer width = 315
integer height = 156
integer textsize = -26
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_voltear_pdf from commandbutton within w_sellador_detalle_base
integer x = 1975
integer y = 2132
integer width = 315
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Voltear"
end type

event clicked;integer vueltas = 0,orientacion
string ruta,nombre_fichero,nuevo_fichero

//Obtenemos el n$$HEX2$$ba002000$$ENDHEX$$de vueltas que tenemos activada al fichero
vueltas = idw_docs.GetItemNumber(idw_docs.GetRow(),'volteo')

if ole_visor_pdf.visible = false then return -1
if idw_docs.rowcount()=0 then return -1

vueltas++
vueltas = mod(vueltas,4)
orientacion = 90 * vueltas

st_rotacion.text = string(orientacion)+'$$HEX1$$ba00$$ENDHEX$$'
ole_visor_pdf.Object.rotate = orientacion

idw_docs.SetItem(idw_docs.GetRow(),'volteo',vueltas)

end event

type gb_rotacion from groupbox within w_sellador_detalle_base
integer x = 1925
integer y = 1908
integer width = 416
integer height = 344
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Rotaci$$HEX1$$f300$$ENDHEX$$n"
end type

type sle_certificado from singlelineedit within w_sellador_detalle_base
integer x = 73
integer y = 92
integer width = 2130
integer height = 72
integer taborder = 120
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 77643992
boolean border = false
boolean displayonly = true
end type

type st_estado_sellado from u_st within w_sellador_detalle_base
boolean visible = false
integer x = 69
integer y = 276
integer width = 2130
integer height = 72
integer weight = 700
long textcolor = 255
string text = "Firmando documento:"
end type

type sle_dir from singlelineedit within w_sellador_detalle_base
integer x = 73
integer y = 268
integer width = 2130
integer height = 72
integer taborder = 130
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 77643992
boolean border = false
boolean displayonly = true
end type

type gb_estado_sellado from groupbox within w_sellador_detalle_base
boolean visible = false
integer x = 18
integer y = 200
integer width = 2226
integer height = 168
integer taborder = 150
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 77643992
string text = "Firmando Documento"
end type

type gb_dir from groupbox within w_sellador_detalle_base
integer x = 18
integer y = 200
integer width = 2226
integer height = 168
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 77643992
string text = "Ruta de los documentos PDF"
end type

type gb_certificado from groupbox within w_sellador_detalle_base
integer x = 18
integer y = 24
integer width = 2226
integer height = 168
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 77643992
string text = "Certificado de Sesi$$HEX1$$f300$$ENDHEX$$n"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
07w_sellador_detalle_base.bin 
2300000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000003000000000000000000000000000000000000000000000000000000005107d8d001d1746600000003000001000000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe000000000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000004800000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a0000000200000001000000042aeb64d946322e252b856ab0ee4b09b90000000051058ee001d1746651058ee001d1746600000000000000000000000000000001fffffffe00000003fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
22ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000b29300000048000800034757f20b000000200065005f00740078006e00650078007400001dc4000800034757f20affffffe00065005f00740078006e006500790074000013d8007000790073006f00290020002000200065007200750074006e007200200073006f006c0067006e005b002000620070005f006d0062006c0000b29300000048000800034757f20b000000200065005f00740078006e00650078007400001dc4000800034757f20affffffe00065005f00740078006e006500790074000013d8006f005f00650070005d006e006f0000006800740072006500280020007500200073006e006700690065006e006c0064006e006f002000670070007700720061006d00610020002c006f006c0067006e006c002000610070006100720020006d002000290072002000740065007200750073006e006c0020006e006f002000670070005b006d0062006f005f00680074007200650000005d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000200000048000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17w_sellador_detalle_base.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
