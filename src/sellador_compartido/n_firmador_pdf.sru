HA$PBExportHeader$n_firmador_pdf.sru
$PBExportComments$version nueva de Juanmi
forward
global type n_firmador_pdf from nonvisualobject
end type
end forward

global type n_firmador_pdf from nonvisualobject
end type
global n_firmador_pdf n_firmador_pdf

type variables

//datos entrada
string i_fichero_entrada
string i_fichero_salida

//datos internos
string i_cadena_firmar = ""
string i_cadena_proteger = ""
end variables

forward prototypes
public subroutine f_longitud_firma (long longitud)
public subroutine f_certificado (string keypath, string keypass, string campo, string name, string reason, string location)
public function integer f_encriptar (string encriptar)
public subroutine f_firmar ()
public subroutine f_noaccess (string access)
public subroutine f_noassembly (string assembly)
public subroutine f_nocopy (string copy)
public subroutine f_nofill (string fill)
public subroutine f_nohighresolution (string highres)
public subroutine f_nomodify (string modify)
public subroutine f_nonotes (string notes)
public subroutine f_noprint (string print)
public subroutine f_ownerpass (string password)
public subroutine f_password_lectura (string poner, string password)
public subroutine f_userpass (string poner, string password)
public subroutine f_borrar_cadena ()
end prototypes

public subroutine f_longitud_firma (long longitud);////////////////////////////////
/*										*/
/*										*/
/*		esta  funci$$HEX1$$f300$$ENDHEX$$n mete		*/
/*		la longitud de firma		*/
/*		del archivo					*/
/*										*/
/*		Entrada:						*/
/*		 	LONGITUD					*/
/*			Se confia en la		*/
/*			aplicaci$$HEX1$$f300$$ENDHEX$$n para 		*/
/*			introduzca el 			*/
/*			valor correcto			*/	
/*			asi en futuras			*/	
/*			versiones ser$$HEX4$$e100090009000900$$ENDHEX$$*/
/*			igualmente valido		*/
/*										*/
/*		Juan Miguel Cebell$$HEX1$$e100$$ENDHEX$$n 	*/
/*				26-02-2004			*/
/*										*/
/*										*/
////////////////////////////////

i_cadena_firmar += ' -keylength ' + string(longitud)


end subroutine

public subroutine f_certificado (string keypath, string keypass, string campo, string name, string reason, string location);
//////////////////////////////
/*

Mete los datos del certificado digital

*/
//////////////////////////////

i_cadena_firmar +=' -sign -keypath "' + keypath+'" -keypass "'+keypass+'"'  
if not f_es_vacio(campo) then
	i_cadena_firmar +=' -f "' +campo+'"'
end if

if not f_es_vacio(name) then
	i_cadena_firmar +=' -name "'+ name +'"'
end if

if not f_es_vacio(reason) then
	i_cadena_firmar +=' -reason "'+ reason +'"'
end if
	
if not f_es_vacio(location) then
	i_cadena_firmar +=' -location "'+ location +'"'	
end if

end subroutine

public function integer f_encriptar (string encriptar);////////////////////////////////
/*										*/
/*										*/
/*		esta  funci$$HEX1$$f300$$ENDHEX$$n decide 	*/
/*		si cifrar o descrifar	*/
/*		un archivo					*/
/*										*/
/*		Entrada 						*/
/*			encriptar				*/
/*				'S' -> cifrar		*/
/*				'N' -> descrifar	*/
/*				otro -> error		*/
/*										*/	
/*										*/
/*		Juan Miguel Cebell$$HEX1$$e100$$ENDHEX$$n 	*/
/*				26-02-2004			*/
/*										*/
/*										*/
////////////////////////////////



CHOOSE CASE encriptar
	CASE 'S'
		i_cadena_proteger += ' -encrypt '
	CASE 'N'
		i_cadena_proteger += ' -remove '
	CASE ELSE
END CHOOSE
RETURN 1
end function

public subroutine f_firmar ();string sentencia = ''
int fichero_bat, li_FileNum, i, lineas_error

if not f_es_vacio(i_fichero_salida) then
	sentencia = ' -o ' + i_fichero_salida
end if

sentencia += ' -l \log.txt ' + i_cadena_firmar + ' ' + i_fichero_entrada
string cadena_a_ejecutar

cadena_a_ejecutar = "secursign.bat " +sentencia 
// Creamos fichero temporal de sincronizaci$$HEX1$$f300$$ENDHEX$$n con el batch
li_FileNum = FileOpen( "cadena_sec.txt", LineMode!, Write!, LockWrite!, Replace! )
FileWrite(li_FileNum, cadena_a_ejecutar)
FileClose(li_FileNum)


if (run(cadena_a_ejecutar,Minimized! ) = 1) then
end if


end subroutine

public subroutine f_noaccess (string access);//////////////////////////////////////
/*												*/
/*												*/
/*		esta  funci$$HEX1$$f300$$ENDHEX$$n mete la 			*/
/*		opci$$HEX1$$f300$$ENDHEX$$n '-noaccess'				*/
/*		(no permite opciones 			*/
/*		accesibilidad a					*/
/*		discapacitados)					*/
/*												*/
/*		Entradas:							*/
/*			access							*/
/*				'S' -> se pone				*/
/*				'N' -> no se pone			*/
/*												*/
/*		Juan Miguel Cebell$$HEX1$$e100$$ENDHEX$$n		 		*/
/*				26-02-2004					*/
/*												*/
/*												*/
//////////////////////////////////////


if access='S' then
	i_cadena_proteger += ' -noaccess '
end if


end subroutine

public subroutine f_noassembly (string assembly);//////////////////////////////////////
/*												*/
/*												*/
/*		esta  funci$$HEX1$$f300$$ENDHEX$$n mete la 			*/
/*		opci$$HEX1$$f300$$ENDHEX$$n '-noassembly'				*/
/*		(no permite el 					*/
/*		'document assembly')				*/
/*												*/
/*		Entradas:							*/
/*			highres							*/
/*				'S' -> se pone				*/
/*				'N' -> no se pone			*/
/*												*/
/*		Juan Miguel Cebell$$HEX1$$e100$$ENDHEX$$n		 		*/
/*				26-02-2004					*/
/*												*/
/*												*/
//////////////////////////////////////


if assembly='S' then
	i_cadena_proteger += ' -noassembly '
end if


end subroutine

public subroutine f_nocopy (string copy);//////////////////////////////////////
/*												*/
/*												*/
/*		esta  funci$$HEX1$$f300$$ENDHEX$$n mete la 			*/
/*		opci$$HEX1$$f300$$ENDHEX$$n '-nocopy'					*/
/*		(no copiar texto o gr$$HEX1$$e100$$ENDHEX$$ficos)	*/
/*												*/
/*		Entradas:							*/
/*			copy								*/
/*				'S' -> se pone				*/
/*				'N' -> no se pone			*/
/*												*/
/*		Juan Miguel Cebell$$HEX1$$e100$$ENDHEX$$n		 		*/
/*				26-02-2004					*/
/*												*/
/*												*/
//////////////////////////////////////

if copy='S' then
	i_cadena_proteger += ' -nocopy '
end if



end subroutine

public subroutine f_nofill (string fill);//////////////////////////////////////
/*												*/
/*												*/
/*		esta  funci$$HEX1$$f300$$ENDHEX$$n mete la 			*/
/*		opci$$HEX1$$f300$$ENDHEX$$n '-nofill'					*/
/*		(no permite rellenar los 		*/
/*		campos de formularios)			*/
/*												*/
/*		Entradas:							*/
/*			highres							*/
/*				'S' -> se pone				*/
/*				'N' -> no se pone			*/
/*												*/
/*		Juan Miguel Cebell$$HEX1$$e100$$ENDHEX$$n		 		*/
/*				26-02-2004					*/
/*												*/
/*												*/
//////////////////////////////////////


if fill='S' then
	i_cadena_proteger += ' -nofill '
end if
end subroutine

public subroutine f_nohighresolution (string highres);//////////////////////////////////////
/*												*/
/*												*/
/*		esta  funci$$HEX1$$f300$$ENDHEX$$n mete la 			*/
/*		opci$$HEX1$$f300$$ENDHEX$$n '-nohighres'				*/
/*		(no permite imprimir	a			*/
/*		altra resoluci$$HEX1$$f300$$ENDHEX$$n)					*/
/*												*/
/*		Entradas:							*/
/*			highres							*/
/*				'S' -> se pone				*/
/*				'N' -> no se pone			*/
/*												*/
/*		Juan Miguel Cebell$$HEX1$$e100$$ENDHEX$$n		 		*/
/*				26-02-2004					*/
/*												*/
/*												*/
//////////////////////////////////////

if highres='S' then
	i_cadena_proteger += ' -nohighres '
end if


end subroutine

public subroutine f_nomodify (string modify);///////////////////////////////////
/*											*/
/*											*/
/*		esta  funci$$HEX1$$f300$$ENDHEX$$n mete la 		*/
/*		opci$$HEX1$$f300$$ENDHEX$$n '-nomodify'			*/	
/*		(no modifcar)					*/
/*											*/
/*		Entradas:						*/
/*			modify						*/
/*				'S' -> se pone			*/
/*				'N' -> no se pone		*/
/*											*/
/*		Juan Miguel Cebell$$HEX1$$e100$$ENDHEX$$n	 		*/
/*				26-02-2004				*/
/*											*/
/*											*/
///////////////////////////////////


if modify='S' then
	i_cadena_proteger += ' -nomodify '
end if


end subroutine

public subroutine f_nonotes (string notes);///////////////////////////////////
/*											*/
/*											*/
/*		esta  funci$$HEX1$$f300$$ENDHEX$$n mete la 		*/
/*		opci$$HEX1$$f300$$ENDHEX$$n '-nonotes				*/	
/*		(no poner anotaciones)		*/
/*											*/
/*		Entradas:						*/
/*			notes							*/
/*				'S' -> se pone			*/
/*				'N' -> no se pone		*/
/*											*/
/*		Juan Miguel Cebell$$HEX1$$e100$$ENDHEX$$n	 		*/
/*				26-02-2004				*/
/*											*/
/*											*/
///////////////////////////////////


if notes='S' then
	i_cadena_proteger += ' -nonotes '
end if


end subroutine

public subroutine f_noprint (string print);///////////////////////////////////
/*											*/
/*											*/
/*		esta  funci$$HEX1$$f300$$ENDHEX$$n mete la 		*/
/*		opci$$HEX1$$f300$$ENDHEX$$n '-noprint'				*/	
/*		(no se puede imprimir)		*/
/*											*/
/*		Entradas:						*/
/*			print							*/
/*				'S' -> se pone			*/
/*				'N' -> no se pone		*/
/*											*/
/*		Juan Miguel Cebell$$HEX1$$e100$$ENDHEX$$n	 		*/
/*				26-02-2004				*/
/*											*/
/*											*/
///////////////////////////////////


if print='S' then
	i_cadena_proteger += ' -noprint '
end if


end subroutine

public subroutine f_ownerpass (string password);///////////////////////////////////
/*											*/
/*				REQUERIDA				*/
/*											*/
/*		esta  funci$$HEX1$$f300$$ENDHEX$$n mete el 		*/
/*		password de propietario		*/
/*		del archivo de salida		*/	
/*											*/
/*		Entradas:						*/
/*			poner							*/
/*				'S' -> necesario		*/
/*				'N' -> no necesaio	*/
/*			password						*/
/*				cadena de password	*/	
/*											*/
/*		Juan Miguel Cebell$$HEX1$$e100$$ENDHEX$$n	 		*/
/*				26-02-2004				*/
/*											*/
/*											*/
///////////////////////////////////


i_cadena_proteger += ' -ownerpass ' + password


end subroutine

public subroutine f_password_lectura (string poner, string password);///////////////////////////////////
/*											*/
/*											*/
/*		esta  funci$$HEX1$$f300$$ENDHEX$$n mete el 		*/
/*		password para poder			*/
/*		abrir el archivo de			*/	
/*		entrada							*/
/*											*/
/*		Entradas:						*/
/*			poner							*/
/*				'S' -> necesario		*/
/*				'N' -> no necesaio	*/
/*			password						*/
/*				cadena de password	*/	
/*											*/
/*		Juan Miguel Cebell$$HEX1$$e100$$ENDHEX$$n	 		*/
/*				26-02-2004				*/
/*											*/
/*											*/
///////////////////////////////////

if poner='S' then
	i_cadena_proteger += ' -d ' + password
end if

end subroutine

public subroutine f_userpass (string poner, string password);///////////////////////////////////
/*											*/
/*											*/
/*		esta  funci$$HEX1$$f300$$ENDHEX$$n mete el 		*/
/*		password de usuario			*/
/*		del archivo de salida		*/	
/*											*/
/*		Entradas:						*/
/*			poner							*/
/*				'S' -> necesario		*/
/*				'N' -> no necesaio	*/
/*			password						*/
/*				cadena de password	*/	
/*											*/
/*		Juan Miguel Cebell$$HEX1$$e100$$ENDHEX$$n	 		*/
/*				26-02-2004				*/
/*											*/
/*											*/
///////////////////////////////////

if poner='S' then
	i_cadena_proteger += ' -userpass ' + password
end if

end subroutine

public subroutine f_borrar_cadena ();i_cadena_firmar=''
end subroutine

on n_firmador_pdf.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_firmador_pdf.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

