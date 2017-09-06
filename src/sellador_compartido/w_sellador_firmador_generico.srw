HA$PBExportHeader$w_sellador_firmador_generico.srw
forward
global type w_sellador_firmador_generico from w_response
end type
type sle_certificado from singlelineedit within w_sellador_firmador_generico
end type
type tab_1 from tab within w_sellador_firmador_generico
end type
type tabpage_5 from userobject within tab_1
end type
type dw_docs from u_dw within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_docs dw_docs
end type
type tabpage_1 from userobject within tab_1
end type
type dw_textos from u_dw within tabpage_1
end type
type dw_datos_firma from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_textos dw_textos
dw_datos_firma dw_datos_firma
end type
type tabpage_2 from userobject within tab_1
end type
type dw_certificados from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_certificados dw_certificados
end type
type tabpage_3 from userobject within tab_1
end type
type dw_configuracion_sello from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_configuracion_sello dw_configuracion_sello
end type
type tabpage_4 from userobject within tab_1
end type
type dw_incidencias from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_incidencias dw_incidencias
end type
type tab_1 from tab within w_sellador_firmador_generico
tabpage_5 tabpage_5
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
type pb_firmar from picturebutton within w_sellador_firmador_generico
end type
type pb_cerrar from picturebutton within w_sellador_firmador_generico
end type
type pb_abrir from picturebutton within w_sellador_firmador_generico
end type
type pb_vprevia from picturebutton within w_sellador_firmador_generico
end type
type gb_certificado from groupbox within w_sellador_firmador_generico
end type
end forward

global type w_sellador_firmador_generico from w_response
integer width = 3538
integer height = 1592
string title = "Firmador Generico"
event type integer csd_comprobacion_datos ( )
event csd_visa_ficheros_avanzado ( string fichero )
event csd_datos_configuracion_sello ( )
sle_certificado sle_certificado
tab_1 tab_1
pb_firmar pb_firmar
pb_cerrar pb_cerrar
pb_abrir pb_abrir
pb_vprevia pb_vprevia
gb_certificado gb_certificado
end type
global w_sellador_firmador_generico w_sellador_firmador_generico

type variables
u_dw idw_docs,idw_datos_sello,idw_certificados,idw_opciones_sello,idw_configuracion_sello,idw_incidencias
u_dw idw_textos


boolean ib_modificado=false
end variables

forward prototypes
public function integer if_localiza_fichero (string fichero)
public function integer f_incidencia (integer codigo, integer fila_documento)
public function string wf_nombre_fichero_firmado (string nombre_fichero)
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
//if idw_opciones_sello.rowcount()>0 then orden = idw_opciones_sello.getitemstring(1,'orden')

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

 
// Validaciones de Configuracion del sello
x1 = idw_configuracion_sello.GetItemDecimal(1, 'x')
y1 = idw_configuracion_sello.GetItemDecimal(1, 'y')
if idw_configuracion_sello.GetItemString(1, 'posicion') = 'L' then
 if f_es_vacio(string(x1)) or f_es_vacio(string(y1)) then mensaje += 'Debe especificar la coordenadas X e Y de la posici$$HEX1$$f300$$ENDHEX$$n libre.' +cr
end if

// Validaciones de Seguridad de Configuracion del sello
firmador = create n_firmador_pdf

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
//i_sentencia_proteger = firmador.i_cadena_proteger
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

event csd_visa_ficheros_avanzado(string fichero);//Visado de ficheros con el nuevo objeto
int firmados,fila,sellado,cantidad_firmar=0,fila_fichero,volteo,i
string fichero_entrada,fichero_salida,ruta,extension,sobreescribir, pdf, archivo_pdf
string ficheros_rojos = '',n_registro,num_doc
string ver_web_defecto,estado_certificado,generar_zip,pos_x,pos_y, pos_sello
double tamano
boolean hay_errores = false
u_analizador_pdf analizador_pdf
n_cst_color colores


u_signer lnv_sellador
string fichero_sello
int opc,FILENUMBER

lnv_sellador = create u_signer

fichero_sello = g_directorio_sellos +  fichero

//***************************************************************************/
//					Rellenamos par$$HEX1$$e100$$ENDHEX$$metros del objeto
//***************************************************************************/
lnv_sellador.i_pkcs = g_directorio_certificados

//Datos de la firma
lnv_sellador.i_nom		= idw_datos_sello.getitemstring(1,'nombre')
lnv_sellador.i_razon	= idw_datos_sello.getitemstring(1,'razon')
lnv_sellador.i_loc		= idw_datos_sello.getitemstring(1,'situacion')

//Datos del certificado
opc =idw_certificados.find('activo="S"',1,idw_certificados.rowcount())
if opc >0 then
	lnv_sellador.i_clave = idw_certificados.getitemstring(opc,'password')
	lnv_sellador.i_pkcs = g_directorio_certificados+idw_certificados.getitemstring(opc,'certificado')
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

lnv_sellador.i_directorio_aplicacion = g_dir_aplicacion

//Rutas de los sellos
if idw_configuracion_sello.GetItemString(1,'posicion')<>'N' then
	lnv_sellador.i_sello		= fichero_sello
	lnv_sellador.i_datos		= g_directorio_temporal+'sello.ini' //Esto hay que hacerlo parametrizable, de momento para probar se queda fijo
	
	filenumber = FileOpen( g_directorio_temporal + 'sello.ini',LineMode!,Write!,LockWrite!,Append!)
	Fileclose(filenumber)
	Event csd_datos_configuracion_sello()	
end if


analizador_pdf = create u_analizador_pdf
analizador_pdf.i_ancho = analizador_pdf.f_puntos_a_cm(double(f_xml_elemento(fichero_sello,'<anchura>')))
analizador_pdf.i_alto  = analizador_pdf.f_puntos_a_cm(double(f_xml_elemento(fichero_sello,'<altura>')))
analizador_pdf.i_margen_v = idw_configuracion_sello.getitemnumber(1,'margen_vertical')
analizador_pdf.i_margen_h = idw_configuracion_sello.getitemnumber(1,'margen_horizontal')
analizador_pdf.i_xo = idw_configuracion_sello.getitemnumber(1,'x')
analizador_pdf.i_yo = idw_configuracion_sello.getitemnumber(1,'y')

extension = '_F'
sobreescribir 	= 'N'
//ver_web_defecto = idw_configuracion_sello.getitemstring(1,'ver_web')
//generar_zip = idw_configuracion_sello.getitemstring(1,'generar_zip')

//Ocultamos y reseteamos la pesta$$HEX1$$f100$$ENDHEX$$a de Incidencias.
tab_1.tabpage_4.visible = false
idw_incidencias.Reset()

//gb_estado_sellado.visible = true
//st_estado_sellado.visible = true

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
	archivo_pdf =  idw_docs.GetItemString(fila,'ruta_base') + ruta + pdf
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
//		f_incidencia(-1, fila)
		fila = idw_docs.GetSelectedRow(fila)
		continue
		
		f_dw_resaltar_fila(idw_docs, 'id_fichero',ficheros_rojos,colores.red)

	end if

	estado_certificado = idw_docs.getitemstring(fila,'certificado_confianza')
	ruta = idw_docs.getitemstring(fila,'ruta_base') + idw_docs.getitemstring(fila,'ruta_fichero')
	volteo = idw_docs.getitemnumber(fila,'volteo')
	volteo = volteo * 90
	analizador_pdf.i_volteo = 0
	fichero_entrada = idw_docs.getitemstring(fila,'nombre_fichero')
	fichero_salida  = wf_nombre_fichero_firmado(fichero_entrada)
	num_doc=''
//	gb_estado_sellado.text = 'Firmando documento ' + string(firmados) + ' de ' + string(cantidad_firmar)
//	st_estado_sellado.text = fichero_entrada

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
	if sellado=1 and Not(FileExists(ruta + fichero_salida)) then sellado=-100
	if sellado>0 then
		fila_fichero = if_localiza_fichero(fichero_salida)
		//Si existe la fila del fichero, entonces se modifican algunos datos

		if fila_fichero=0 then
			fila_fichero = idw_docs.insertrow(0)
			idw_docs.setitem(fila_fichero,'id_fichero', '')
			idw_docs.setitem(fila_fichero,'id_fase', '')
			idw_docs.setitem(fila_fichero,'nombre_fichero',fichero_salida)
			idw_docs.setitem(fila_fichero,'ruta_fichero', idw_docs.getitemstring(fila,'ruta_fichero'))
			idw_docs.setitem(fila_fichero,'ruta_base',idw_docs.GetItemString(fila,'ruta_base'))
			idw_docs.setitem(fila_fichero,'fecha', today())
			idw_docs.setitem(fila_fichero,'volteo',0)	
			idw_docs.setitem(fila_fichero,'sellado','S')
			idw_docs.setitem(fila_fichero,'nuevo','S')
		end if
		idw_docs.setitem(fila_fichero,'fecha_sellado',today())	
		idw_docs.setitem(fila_fichero,'n_documento',num_doc)	
		
		// Desactivamos el visible web hasta que hayamos sellado todos y generado el zip
		idw_docs.setitem(fila_fichero,'visualizar_web','N')
		
		//Ponemos el tama$$HEX1$$f100$$ENDHEX$$o (puede haber variado)
		tamano = Ceiling(gnv_fichero.of_GetFileSize(ruta+fichero_salida) / 1024)
		idw_docs.setitem(fila_fichero,'tamano',string(tamano,"#,###,##0") + ' Kb')
		idw_docs.setitem(fila_fichero,'firmado','V')		
		idw_docs.setitem(fila_fichero,'certificado_confianza','NR')
	//	idw_docs.update()
		
//		i_ficheros_sellados[upperbound(i_ficheros_sellados) + 1] = idw_docs.GetItemString(fila_fichero,'id_fichero')
//		i_ficheros_firmados[upperbound(i_ficheros_firmados) + 1] = idw_docs.GetItemString(fila,'id_fichero')
		//Ya esta firmado el documento, si es correcto y esta habilitada la opcion, lo a$$HEX1$$f100$$ENDHEX$$adimos al zip
		//if  generar_zip = 'S' and fileexists(ruta + fichero_salida) then event csd_generar_zip(ruta + fichero_salida)	

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


//close(w_eimporta_procesando)
this.SetMicroHelp("Sellado Finalizado")
if g_interrupt then
	f_incidencia(-99,0)
	tab_1.tabpage_4.visible = true
	messagebox(g_titulo,'Proceso interrumpido por el usuario',StopSign!)	
	g_interrupt=false
else
	if hay_errores then 
		tab_1.tabpage_4.visible = true
		f_dw_resaltar_fila(idw_docs, 'id_fichero',ficheros_rojos,colores.red)
		messagebox(g_titulo,'Ha habido problemas durante el sellado de alg$$HEX1$$fa00$$ENDHEX$$n fichero. Compruebe la lista de incidencias',StopSign!)
	else
		//f_dw_resaltar_fila(idw_docs, '','0',0)
		//tab_dir.tabpage_4.visible = false
		messagebox(g_titulo,'El / Los ficheros han sido firmados con $$HEX1$$e900$$ENDHEX$$xito',Information!)		
	end if
end if


//st_estado_sellado.visible = false
//gb_estado_sellado.visible = false

SetPointer(Arrow!)

idw_docs.selectrow(0, false)
Filedelete(g_directorio_temporal+'sello.ini')

destroy analizador_pdf


end event

event csd_datos_configuracion_sello();//Esta funci$$HEX1$$f300$$ENDHEX$$n se utiliza para el nuevo m$$HEX1$$f300$$ENDHEX$$dulo de firma "VISIBLE"
//Rellena los datos de configuraci$$HEX1$$f300$$ENDHEX$$n del sello
int i,clausula=0,t_clausula=0,col
string sello,colegiado,dir_windows,nombre_clausula
string activo,color,codigo,textoaux,texto,resto
int fin,tamtexto,tammax,diftam

//Directorios
//En las rutas sustituimos los signos '\' con '/' ya que Java toma el primero como s$$HEX1$$ed00$$ENDHEX$$mbolo de escape 
//y produce resultados err$$HEX1$$f300$$ENDHEX$$neos
dir_windows = f_variable_entorno("windir", "C:\WINDOWS")
//GetWindowsDirectory(dir_windows,100)
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','directorio_imagenes',f_reemplazar_cadena(g_directorio_imagenes,'\','/'))
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','directorio_windows',f_reemplazar_cadena(dir_windows,'\','/'))


for i=1 to 10
	texto=""
	if i<=idw_textos.rowcount() then texto=idw_textos.GetItemString(i,'clausula')
	SetProfilestring(g_directorio_temporal + 'sello.ini','CLAUSULAS','clausula_'+string(i),texto)
next

end event

public function integer if_localiza_fichero (string fichero);//Localiza si existe un fichero en la lista de los ficheros
//Devuelve: 
//		*  linea en la que se encuentra el fichero
//		*  0 : Si no encuentra ning$$HEX1$$fa00$$ENDHEX$$na l$$HEX1$$ed00$$ENDHEX$$nea
//		* <0 : Si encuentra alg$$HEX1$$fa00$$ENDHEX$$n error

int posicion = -1

posicion = idw_docs.find("nombre_fichero='"+fichero+"'",1,idw_docs.rowcount())

return posicion
end function

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

public function string wf_nombre_fichero_firmado (string nombre_fichero);string ls_extension
integer max_long_nombre_fichero

ls_extension = idw_datos_sello.getitemstring(1,'extension')

// Longitud m$$HEX1$$e100$$ENDHEX$$xima que puede tener el nombre de fichero para poder guardarlo en la base de datos
// Cuando un nombre exceda este l$$HEX1$$ed00$$ENDHEX$$mite se truncar$$HEX1$$e100$$ENDHEX$$
max_long_nombre_fichero = f_tamanyo_columna(idw_docs, 'nombre_fichero') - LenA(ls_extension) - 4

return LeftA(nombre_fichero, min(LenA(nombre_fichero) - 4, max_long_nombre_fichero)) + ls_extension + '.PDF'	

end function

on w_sellador_firmador_generico.create
int iCurrent
call super::create
this.sle_certificado=create sle_certificado
this.tab_1=create tab_1
this.pb_firmar=create pb_firmar
this.pb_cerrar=create pb_cerrar
this.pb_abrir=create pb_abrir
this.pb_vprevia=create pb_vprevia
this.gb_certificado=create gb_certificado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_certificado
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.pb_firmar
this.Control[iCurrent+4]=this.pb_cerrar
this.Control[iCurrent+5]=this.pb_abrir
this.Control[iCurrent+6]=this.pb_vprevia
this.Control[iCurrent+7]=this.gb_certificado
end on

on w_sellador_firmador_generico.destroy
call super::destroy
destroy(this.sle_certificado)
destroy(this.tab_1)
destroy(this.pb_firmar)
destroy(this.pb_cerrar)
destroy(this.pb_abrir)
destroy(this.pb_vprevia)
destroy(this.gb_certificado)
end on

event open;call super::open;integer i

idw_docs = tab_1.tabpage_5.dw_docs
idw_datos_sello = tab_1.tabpage_1.dw_datos_firma
idw_textos = tab_1.tabpage_1.dw_textos
//idw_opciones_sello = tab_1.tabpage_1.dw_opciones_sello
//dw_posiciones_sello = tab_1.tabpage_1.dw_pos_sellos
idw_certificados = tab_1.tabpage_2.dw_certificados
idw_configuracion_sello = tab_1.tabpage_3.dw_configuracion_sello
idw_incidencias = tab_1.tabpage_4.dw_incidencias

datastore ds_docs

ds_docs=Message.PowerObjectParm

ds_docs.RowsCopy(ds_docs.GetRow(), ds_docs.RowCount(), Primary!, idw_docs, 1, Primary!)

for i=1 to idw_docs.rowcount()
	idw_docs.SetItem(i,'nuevo','N')
next

idw_configuracion_sello.insertrow(0)
idw_datos_sello.insertrow(0)
idw_textos.event pfc_addrow()

ChangeDirectory(g_dir_aplicacion)
end event

event pfc_postopen;call super::pfc_postopen;int fila, i
double tamano
string fichero

f_recuperar_consulta_ventana(this, this.classname(), 'INICIO')



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

for i = 1 to idw_docs.rowcount()
	if idw_docs.getitemstring(i,'tamano') = '' or isnull (idw_docs.getitemstring(i,'tamano')) or idw_docs.getitemstring(i,'tamano') = '0 Kb' then
		fichero = idw_docs.getitemstring(i,'ruta_base') + idw_docs.getitemstring(i,'ruta_fichero') + idw_docs.getitemstring(i,'nombre_fichero')
		tamano = Ceiling(gnv_fichero.of_GetFileSize(fichero) / 1024)
		idw_docs.setitem(i,'tamano',string(tamano,"#,###,##0") + ' Kb')
	end if
next

string id_perfil

select id_perfil into :id_perfil from t_usuario where cod_usuario=:g_usuario;

if not(f_es_vacio(id_perfil)) then
	idw_datos_sello.SetItem(1,'perfil',id_perfil)
	tab_1.tabpage_1.dw_datos_firma.event itemchanged(1,idw_datos_sello.object.perfil,id_perfil)
end if


end event

event closequery;call super::closequery;datastore ds_docs

ds_docs=create datastore
ds_docs.dataobject='d_sellador_documentos_firmas_gen'
idw_docs.RowsCopy(idw_docs.GetRow(), idw_docs.RowCount(), Primary!, ds_docs, 1, Primary!)

Message.PowerObjectParm=ds_docs
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_sellador_firmador_generico
integer x = 2126
integer y = 1764
integer width = 549
integer taborder = 20
string text = "Recuperar pantalla"
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_sellador_firmador_generico
integer x = 1509
integer y = 1740
integer width = 489
string text = "Guardar pantalla"
end type

type sle_certificado from singlelineedit within w_sellador_firmador_generico
integer x = 101
integer y = 92
integer width = 2130
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 77643992
string text = "SESION NO INICIADA"
boolean border = false
boolean displayonly = true
end type

type tab_1 from tab within w_sellador_firmador_generico
integer x = 41
integer y = 444
integer width = 3447
integer height = 1012
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_5 tabpage_5
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_5=create tabpage_5
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_5,&
this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_5)
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3410
integer height = 884
long backcolor = 79741120
string text = "Documentos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "ToDoList!"
long picturemaskcolor = 536870912
dw_docs dw_docs
end type

on tabpage_5.create
this.dw_docs=create dw_docs
this.Control[]={this.dw_docs}
end on

on tabpage_5.destroy
destroy(this.dw_docs)
end on

type dw_docs from u_dw within tabpage_5
event csd_firmar ( )
event csd_abrir ( )
event csd_boton_firmar ( )
event csd_borrar ( )
event csd_revisar_firmas ( )
event csd_selectall ( )
event csd_invertselection ( )
event csd_boton_vista_previa ( )
integer x = 18
integer y = 28
integer width = 3328
integer height = 828
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_sellador_documentos_firmas_gen"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event csd_firmar();string sello, fichero
string array_vacio[]


idw_datos_sello.accepttext()

if of_accepttext(true) < 0 then return



// Obtenemos el nombre del fichero xml del sello avanzado. Si no se ha especificado ninguno se usa el sello antiguo
sello = idw_datos_sello.getitemstring(1,'sello')

//Obligamos a q pongan algun sello
if f_es_vacio(sello) and idw_configuracion_sello.GetItemString(1,'posicion')<>'N' then
	close(w_eimporta_procesando)	
	messagebox(g_titulo, 'Debe seleccionar alg$$HEX1$$fa00$$ENDHEX$$n sello para firmar.')
	return
end if

if not f_es_vacio(sello) then
	select fichero into :fichero from t_sello where codigo = :sello;
end if

// Comprobamos  que se han seleccionado documentos, certificados y los datos del sello
if event csd_comprobacion_datos() = -1 then 
	close(w_eimporta_procesando)
	return
end if

//** SELLO NUEVO (SIGNERPDF) **//

event csd_visa_ficheros_avanzado(fichero)




close(w_eimporta_procesando)
end event

event csd_abrir();string fichero,ruta, activo
double fila_seleccionada = 0
string extension

// Abriremos todos los seleccionados
//activo = dw_opciones.getitemstring(1,'desactivar_ocx')

DO
	fila_seleccionada = this.getselectedrow(fila_seleccionada)
	if fila_seleccionada > 0 then
		fichero = this.getitemstring(fila_seleccionada, 'nombre_fichero')
		ruta = this.getitemstring(fila_seleccionada, 'ruta_base') + this.getitemstring(fila_seleccionada, 'ruta_fichero')
		//Comprobamos el tipo de fichero
		extension = UPPER(RightA(fichero,4))
		if not fileexists(ruta + fichero) then
			messagebox(g_titulo, 'Fichero no encontrado')
			continue
		end if
		f_abrir_fichero(ruta, fichero, "")
	end if
LOOP UNTIL fila_seleccionada <= 0
end event

event csd_boton_firmar();//tab_dir.tabpage_tv.dw_docs.event csd_firmar()
this.postevent("csd_firmar")
open(w_eimporta_procesando)
end event

event csd_borrar();string ruta

if this.GetITemString(this.GetRow(),'nuevo')<>'S' then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!", "Solamente puede borrar los documentos acabados de generar. Para borrar otros documentos hagalo desde la ventana origen")
	return
else
	ruta=this.GetItemString(this.GetRow(),'ruta_base')+this.GetItemString(this.GetRow(),'ruta_fichero')+this.GetItemString(this.GetRow(),'nombre_fichero')	
	FileDelete(ruta)
	this.deleterow(this.GetRow())
end if
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

//revisor.is_claves_publicas=f_obtener_claves_publicas(dw_fase.GetItemSTring(dw_Fase.GetRow(),'id_fase'))

do while fila_seleccionada <> 0 
	//Revisamos la firma del documento
	fichero_pdf = this.getitemstring(fila_seleccionada,'ruta_base') + this.getitemstring(fila_seleccionada,'ruta_fichero') + this.getitemstring(fila_seleccionada,'nombre_fichero')
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

//this.update()

if idw_incidencias.rowcount() > 0 then
	tab_1.tabpage_4.visible = true
	messagebox(g_titulo, 'Se han detectado problemas con algunas firmas o certificados')
else
	tab_1.tabpage_4.visible = false
	messagebox(g_titulo, 'Revisi$$HEX1$$f300$$ENDHEX$$n de firmas finalizada')
end if


end event

event csd_selectall();int i
for i = 1 to rowcount()
	selectrow(i, true)
next
end event

event csd_invertselection();long	ll_max
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

event csd_boton_vista_previa();st_sellador_datos_abrir_pdf datos
datos.fila_seleccionada = dw_docs.getrow()
datos.ficheros = dw_docs
datos.modulo = 'GENERICO'
openwithparm(w_sellador_previsualizacion_pdf,datos)

end event

event constructor;call super::constructor;of_setrowselect(true)
of_setrowmanager(true)
// Orden
of_setsort(true)
inv_sort.of_SetColumnHeader (true)
inv_sort.of_SetStyle (2)
// Multiseleccion
this.inv_rowselect.of_SetStyle (this.inv_rowselect.EXTENDED)
end event

event doubleclicked;call super::doubleclicked;string texto

choose case dwo.name
	case 'info_adicional' 

		texto = this.getitemstring(row,'info_adicional')
		openwithparm(w_observaciones,texto)
		texto = Message.Stringparm
		if texto <> '-1' then
			this.setitem(row,'info_adicional',texto)
			this.update()
		end if
	case 'imagen'
		this.event csd_boton_vista_previa()
	case else
		this.event csd_abrir()
end choose
end event

event rbuttondown;call super::rbuttondown;m_sellador_docs menu
m_sellador_docs_sinlineas menu_sinlineas


if this.getrow() < 0 then 
	return
elseif this.getrow() = 0 then 
	menu_sinlineas = create m_sellador_docs_sinlineas
	menu_sinlineas.idw_padre = this		
	menu_sinlineas.PopMenu(w_sellador_firmador_generico.PointerX() + 5, w_sellador_firmador_generico.PointerY() + 10)	
	destroy menu_sinlineas	
else
	menu = create m_sellador_docs
	menu.idw_padre = this		
	menu.m_enviar.visible=false
	menu.m_-0.visible=false	
	menu.m_-1.visible=false	
	menu.m_-2.visible=false		
	menu.m_editar.visible=false
	menu.m_anyadir.visible=false	
	menu.m_verwebtodos.visible=false		
	menu.m_verwebninguno.visible=false			
	menu.PopMenu(w_sellador_firmador_generico.PointerX() + 5, w_sellador_firmador_generico.PointerY() + 10)
	destroy menu
end if





end event

event buttonclicked;call super::buttonclicked;string fichero

choose case dwo.name
	case 'b_firmas'
		//Abrimos la ventana con los datos de las firmas del documento
		fichero = this.getitemstring(row,'ruta_base') + this.getitemstring(row,'ruta_fichero') + this.getitemstring(row,'nombre_fichero')
		openwithparm(w_sellador_info_firmas, fichero)
end choose

end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3410
integer height = 884
long backcolor = 79741120
string text = "Datos Sellos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "UpdateReturn!"
long picturemaskcolor = 536870912
dw_textos dw_textos
dw_datos_firma dw_datos_firma
end type

on tabpage_1.create
this.dw_textos=create dw_textos
this.dw_datos_firma=create dw_datos_firma
this.Control[]={this.dw_textos,&
this.dw_datos_firma}
end on

on tabpage_1.destroy
destroy(this.dw_textos)
destroy(this.dw_datos_firma)
end on

type dw_textos from u_dw within tabpage_1
event csd_grabar_datos ( )
integer x = 1989
integer y = 4
integer width = 1399
integer height = 832
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_sellador_textos_manuales"
boolean border = false
boolean ib_isupdateable = false
end type

event csd_grabar_datos();
if messagebox(g_titulo, "Se sobrescribir$$HEX1$$e100$$ENDHEX$$n los datos por defecto. $$HEX1$$bf00$$ENDHEX$$Seguro que desea continuar?", Question!, YesNo!, 1) = 1 then
	f_grabar_consulta_un_dw(this,tab_1.getparent().classname(),'INICIO')
end if
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = false
end event

event pfc_addrow;call super::pfc_addrow;integer numero,numfilas


numfilas=this.rowcount()
if numfilas>1 then	numero=this.GetItemNumber(numfilas - 1,'numero') 

this.SetItem(AncestorReturnValue,'numero',numero+1)

return AncestorReturnValue
end event

type dw_datos_firma from u_dw within tabpage_1
event csd_grabar_datos ( )
event csd_cargar_perfil ( )
integer x = 32
integer y = 64
integer width = 2222
integer height = 796
integer taborder = 11
string dataobject = "d_datos_firmador_gen"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
end type

event csd_grabar_datos();
if messagebox(g_titulo, "Se sobrescribir$$HEX1$$e100$$ENDHEX$$n los datos por defecto. $$HEX1$$bf00$$ENDHEX$$Seguro que desea continuar?", Question!, YesNo!, 1) = 1 then
	f_grabar_consulta_un_dw(this,tab_1.getparent().classname(),'INICIO')
end if
end event

event csd_cargar_perfil();string posi,posicion
double mvert,mhoriz,posx,posy
string perfil
integer i,fila
datawindowChild dwc_perfil

perfil=idw_datos_sello.GetItemString(idw_datos_sello.GetRow(),'perfil')

idw_datos_sello.GetChild('perfil',dwc_perfil)

idw_datos_sello.SetItem(1,'nombre',dwc_perfil.GetItemString(dwc_perfil.GetRow(),'nombre'))
idw_datos_sello.SetItem(1,'situacion',dwc_perfil.GetItemString(dwc_perfil.GetRow(),'situacion'))
idw_datos_sello.SetItem(1,'razon',dwc_perfil.GetItemString(dwc_perfil.GetRow(),'razon'))
idw_datos_sello.SetItem(1,'sello',dwc_perfil.GetItemString(dwc_perfil.GetRow(),'sello'))

for i=1 to idw_certificados.rowcount()
	idw_certificados.SetItem(1,'activo','N')
next
fila=idw_certificados.insertrow(0)
idw_Certificados.SetItem(fila,'certificado',dwc_perfil.GetItemString(dwc_perfil.GetRow(),'certificado'))
idw_Certificados.SetItem(fila,'password',dwc_perfil.GetItemString(dwc_perfil.GetRow(),'password'))
idw_Certificados.SetItem(fila,'activo','S')
idw_configuracion_sello.SetItem(1,'posicion',dwc_perfil.GetItemString(dwc_perfil.GetRow(),'posicion'))
idw_configuracion_sello.SetItem(1,'x',dwc_perfil.GetItemNumber(dwc_perfil.GetRow(),'x'))	
idw_configuracion_sello.SetItem(1,'y',dwc_perfil.GetItemNumber(dwc_perfil.GetRow(),'y'))	
idw_configuracion_sello.SetItem(1,'margen_vertical',dwc_perfil.GetItemNumber(dwc_perfil.GetRow(),'margen_vertical'))		
idw_configuracion_sello.SetItem(1,'margen_horizontal',dwc_perfil.GetItemNumber(dwc_perfil.GetRow(),'margen_horizontal'))		

idw_configuracion_sello.SetItem(1,'nomodify',dwc_perfil.GetItemString(dwc_perfil.GetRow(),'nomodify'))
idw_configuracion_sello.SetItem(1,'noaccess',dwc_perfil.GetItemString(dwc_perfil.GetRow(),'noaccess'))	
idw_configuracion_sello.SetItem(1,'nocopy',dwc_perfil.GetItemString(dwc_perfil.GetRow(),'nocopy'))	
idw_configuracion_sello.SetItem(1,'noprint',dwc_perfil.GetItemString(dwc_perfil.GetRow(),'noprint'))		
idw_configuracion_sello.SetItem(1,'nohighres',dwc_perfil.GetItemString(dwc_perfil.GetRow(),'nohighres'))		
idw_configuracion_sello.SetItem(1,'nonotes',dwc_perfil.GetItemString(dwc_perfil.GetRow(),'nonotes'))		
idw_configuracion_sello.SetItem(1,'nofill',dwc_perfil.GetItemString(dwc_perfil.GetRow(),'nofill'))		
idw_configuracion_sello.SetItem(1,'noassembly',dwc_perfil.GetItemString(dwc_perfil.GetRow(),'noassembly'))		





end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'perfil'
		event csd_cargar_perfil()
end choose
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3410
integer height = 884
long backcolor = 79741120
string text = "Certificados"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = ".\Imagenes\certificado.gif"
long picturemaskcolor = 536870912
dw_certificados dw_certificados
end type

on tabpage_2.create
this.dw_certificados=create dw_certificados
this.Control[]={this.dw_certificados}
end on

on tabpage_2.destroy
destroy(this.dw_certificados)
end on

type dw_certificados from u_dw within tabpage_2
event csd_grabar_datos ( )
integer x = 27
integer y = 24
integer width = 3319
integer height = 756
integer taborder = 11
string dataobject = "d_sellador_certificados"
boolean border = false
boolean ib_isupdateable = false
end type

event csd_grabar_datos();if messagebox(g_titulo, "Se sobrescribir$$HEX1$$e100$$ENDHEX$$n los datos por defecto. $$HEX1$$bf00$$ENDHEX$$Seguro que desea continuar?", Question!, YesNo!, 1) = 1 then
	f_grabar_consulta_un_dw(this,tab_1.getparent().classname(),'INICIO')
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

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3410
integer height = 884
long backcolor = 79741120
string text = "Opciones Avanzadas"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
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
event csd_grabar_datos ( )
integer x = 23
integer y = 20
integer width = 3360
integer height = 840
integer taborder = 20
string dataobject = "d_configuracion_sello_gen"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
end type

event csd_grabar_datos();if messagebox(g_titulo, "Se sobrescribir$$HEX1$$e100$$ENDHEX$$n los datos por defecto. $$HEX1$$bf00$$ENDHEX$$Seguro que desea continuar?", Question!, YesNo!, 1) = 1 then
	f_grabar_consulta_un_dw(this,tab_1.getparent().classname(),'INICIO')
end if
end event

event buttonclicked;call super::buttonclicked;string texto, ls_fichero_pdf,cadena
st_sello posiciones
long currentrow

choose case dwo.name
	case 'b_obtener'
		currentrow = idw_docs.getrow()		
		if currentrow <= 0 then return
		ls_fichero_pdf =idw_docs.getitemstring(currentrow,'ruta_base') + idw_docs.getitemstring(currentrow,'ruta_fichero') + "\" + idw_docs.getitemstring(currentrow,'nombre_fichero')
		
		if Not(FileExists(ls_fichero_pdf)) then
			MessageBox("Fichero No encontrado","No se ha encontrado el fichero "+ls_fichero_pdf )
			return
		end if
		
		// Se pasa como parametro una cadena con el nombre del fichero y la rotacion, separados por '::'
		// De esta forma evitamos tener que hacer un struct para dos campos
		cadena=ls_fichero_pdf+'::'+'0$$HEX1$$ba00$$ENDHEX$$'
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

type tabpage_4 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 3410
integer height = 884
long backcolor = 79741120
string text = "Incidencias"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
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
integer x = 18
integer y = 28
integer width = 3337
integer height = 840
integer taborder = 11
string dataobject = "d_sellador_incidencias"
boolean ib_isupdateable = false
end type

type pb_firmar from picturebutton within w_sellador_firmador_generico
integer x = 105
integer y = 228
integer width = 279
integer height = 164
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Imagenes\bt_firmar.bmp"
alignment htextalign = left!
end type

event clicked;tab_1.tabpage_5.dw_docs.event csd_boton_firmar()

end event

type pb_cerrar from picturebutton within w_sellador_firmador_generico
integer x = 1038
integer y = 228
integer width = 279
integer height = 164
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Imagenes\bt_cerrar.bmp"
alignment htextalign = left!
end type

event clicked;/*datastore ds_docs

ds_docs=create datastore
ds_docs.dataobject='d_sellador_documentos_firmas_gen'
idw_docs.RowsCopy(idw_docs.GetRow(), idw_docs.RowCount(), Primary!, ds_docs, 1, Primary!)

CloseWithReturn(parent,ds_docs)*/

// EL rellenado del datastore del return se hace en el closequery
Close(parent)
end event

type pb_abrir from picturebutton within w_sellador_firmador_generico
integer x = 416
integer y = 228
integer width = 279
integer height = 164
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Imagenes\bt_abrir.bmp"
alignment htextalign = left!
end type

event clicked;tab_1.tabpage_5.dw_docs.event csd_abrir()

end event

type pb_vprevia from picturebutton within w_sellador_firmador_generico
integer x = 727
integer y = 228
integer width = 279
integer height = 164
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Imagenes\bt_previa.bmp"
alignment htextalign = left!
end type

event clicked;tab_1.tabpage_5.dw_docs.event csd_boton_vista_previa()

end event

type gb_certificado from groupbox within w_sellador_firmador_generico
integer x = 46
integer y = 24
integer width = 2226
integer height = 168
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 77643992
string text = "Certificado de Sesi$$HEX1$$f300$$ENDHEX$$n"
end type

