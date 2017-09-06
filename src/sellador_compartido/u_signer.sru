HA$PBExportHeader$u_signer.sru
forward
global type u_signer from nonvisualobject
end type
end forward

global type u_signer from nonvisualobject
end type
global u_signer u_signer

type variables
string i_pkcs
string i_clave
string i_nom
string i_razon
string i_loc
string i_sello
string i_datos
string i_cp
string i_cu
string i_certid

boolean i_noaccess
boolean i_nocopy
boolean i_noprint
boolean i_nohighres
boolean i_nomodify
boolean i_nonotes
boolean i_nofill
boolean i_noassembly

string i_o
string i_err
string i_key

string i_fichero_entrada
string i_extension_salida
string i_expediente
string i_retorno
string i_directorio_aplicacion

//***************************//

string i_cadena_firmar
string i_error

end variables

forward prototypes
public subroutine of_construye_cadena ()
public function string of_generar_password ()
public function integer of_firmar ()
public function integer of_error ()
public function string of_comprobar_encriptacion ()
end prototypes

public subroutine of_construye_cadena ();////////////////////////////////////////////////////////////////////////
//                                                                    //
//		Esta funci$$HEX1$$f300$$ENDHEX$$n captura los valores de las variables de instancia  //
//		del objeto y contruye la cadena con las opciones del signerpdf  //
//	 	                                                                //
////////////////////////////////////////////////////////////////////////

boolean lb_permisos

i_cadena_firmar =' -pkcs "' + i_pkcs+'" -clave "'+i_clave+'"'  


if not f_es_vacio(i_certid) then
	i_cadena_firmar +=' -certid "'+ i_certid +'"'
end if

if not f_es_vacio(i_nom) then
	i_cadena_firmar +=' -nom "'+ i_nom +'"'
end if

if not f_es_vacio(i_razon) then
	i_cadena_firmar +=' -razon "'+ i_razon +'"'
end if
	
if not f_es_vacio(i_loc) then
	i_cadena_firmar +=' -loc "'+ i_loc +'"'	
end if

if not f_es_vacio(i_sello) then
	i_cadena_firmar +=' -sello "'+ i_sello +'"'	
end if

if not f_es_vacio(i_datos) then
	i_cadena_firmar +=' -datos "'+ i_datos +'"'	
end if

if  i_noaccess = true then
	i_cadena_firmar +=' -noaccess '
	lb_permisos=true
end if

if i_nocopy = true then
	i_cadena_firmar +=' -nocopy '	
	lb_permisos=true	
end if

if  i_noprint = true then
	i_cadena_firmar +=' -noprint '	
	lb_permisos=true	
end if

if  i_nohighres = true then
	i_cadena_firmar +=' -nohighres '	
	lb_permisos=true	
end if

if  i_nomodify = true then
	i_cadena_firmar +=' -nomodify '	
	lb_permisos=true	
end if

if  i_nonotes = true then
	i_cadena_firmar +=' -nonotes '	
	lb_permisos=true	
end if

if  i_nofill = true then
	i_cadena_firmar +=' -nofill '	
	lb_permisos=true	
end if

if  i_noassembly = true then
	i_cadena_firmar +=' -noassembly '	
	lb_permisos=true	
end if


if not f_es_vacio(i_cp) then
	i_cadena_firmar +=' -cp "'+ i_cp +'"'		
else
	if lb_permisos then i_cadena_firmar +=' -cp "csdcsd"'		
end if

if not f_es_vacio(i_cu) then
	i_cadena_firmar +=' -cu "'+ i_cu +'"'	
end if


if not f_es_vacio(i_o) then
	i_cadena_firmar +=' -o "'+ i_o +'"'
end if

if not f_es_vacio(i_err) then
	i_cadena_firmar +=' -err "'+ i_err +'"'
end if

if not f_es_vacio(i_key) then
	i_cadena_firmar +=' -key "'+ i_key +'" '
end if

end subroutine

public function string of_generar_password ();//Correo CSDof_generar_password(string i_fichero_entrada) return string

int vec[]
int i 
double suma = 0
double tamano

n_cst_filesrvwin32 dire
dire = create n_cst_filesrvwin32
tamano = dire.of_GetFileSize(i_fichero_entrada)
destroy dire

//1 - Transformamos la ruta del pdf en un array de int en que cada posicion es la conversion de la letra en Ascii
for i = 1 to LenA(i_fichero_entrada)
 vec[i] = AscA(MidA(i_fichero_entrada,i,1))
next

//2 - Obtenemos la suma de ese array
for i = 1 to upperbound(vec)
 suma += vec[i]
next

//3 - Multiplica el resultado por el tama$$HEX1$$f100$$ENDHEX$$o del i_fichero_entrada
suma = suma * tamano

//4 - El resultado lo pasa a hexadecimal (con las letras en mayusculas)
string  ls_hex=''
char  lch_hex[0 to 15]={'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'}
Do 
  ls_hex = lch_hex[mod (suma, 16)] + ls_hex
  suma /= 16
Loop Until truncate(suma,0) = 0

return ls_hex
end function

public function integer of_firmar ();// Antes de llamar a esta funci$$HEX1$$f300$$ENDHEX$$n se deben introducir los valores de las variables
// de instancia del objeto con las opciones del "signerpdf" que se desean utilizar

//string num_reg = 'SIGN-WINR-0024-YN8U-AYJG-0012'
integer retorno = 1
integer retorno2 = 1
string cadena_a_ejecutar, encriptar
string clave_pdf_signer,version


//Comprobamos que exista maquina virtual
registryget("HKEY_LOCAL_MACHINE\Software\Javasoft\Java Runtime Environment\","CurrentVersion", version)
if version = '' or isnull(version) or version < '1.4' then
	retorno = -200
	return retorno
end if

//signerPDF [opciones] ficheroPDF --> el fichero pdf es el i_fichero_entrada

// *** C$$HEX1$$f300$$ENDHEX$$digo para la version de distribucion (con clave de seguridad) del pdf signer ***//
i_key = of_generar_password()
// ************************************************************ //

of_construye_cadena()
encriptar = of_comprobar_encriptacion()

//Combinaci$$HEX1$$f300$$ENDHEX$$n de encriptaci$$HEX1$$f300$$ENDHEX$$n incorrecta
IF encriptar = '-1' THEN return -91
if i_fichero_entrada = '' then return -92 

//El signerpdf debe incluirse en el directorio de la aplicacion
cadena_a_ejecutar = '"'+ i_directorio_aplicacion + 'signerPDF.exe' + '"' + i_cadena_firmar +  '"' + i_fichero_entrada + '"'
n_runandwait runandwait
runandwait = create n_runandwait
runandwait.of_SetPriority(runandwait.HIGH_PRIORITY_CLASS)
runandwait.of_SetCurrentDirectory(g_dir_aplicacion)
if pos(cadena_a_ejecutar,'BROWSER')>0 then
	runandwait.of_SetWindow("normal") //"minimize" para que muestre la ventana de msdos
	runandwait.of_SetWindow("off") //"minimize" para que muestre la ventana de msdos
else
	runandwait.of_SetWindow("hide") //"minimize" para que muestre la ventana de msdos
end if

retorno = runandwait.of_runandwait(cadena_a_ejecutar)
clipboard(cadena_a_ejecutar)

if Not(FileExists(i_o)) then 
	cadena_a_ejecutar = '"'+ i_directorio_aplicacion + 'signerPDF_sin_trailer.exe' + '"' + i_cadena_firmar +  '"' + i_fichero_entrada + '"'
	retorno2 = runandwait.of_runandwait(cadena_a_ejecutar)
end if 	

//Error en la ejecucion del archivo signerpdf.exe
if retorno <> 1 then return -93
//if retorno2 <> 1 then return -93

retorno = of_error()

return retorno
end function

public function integer of_error ();//Comprueba el lerror que ha mostrado la ejecuci$$HEX1$$f300$$ENDHEX$$n y q se encuentra en el fichero indicado en el
//parametro i_err
int retorno,file
string lerror


lerror = '1' //Sin lerror

if fileexists(i_err) then
	file = FileOpen(i_err,LineMode!)
	FileRead(file,lerror)
	//Cogemos a partir del caracter 8 ya que el formato es "codigo=-5'
	//La funci$$HEX1$$f300$$ENDHEX$$n devolver$$HEX2$$e1002000$$ENDHEX$$-1,-2,-3...,-9,-10...
	lerror = MidA(lerror,8)
	FileClose(file)
end if

retorno = integer(lerror)
filedelete(i_err)
return retorno 
end function

public function string of_comprobar_encriptacion ();// Esta funci$$HEX1$$f300$$ENDHEX$$n comprueba que la combinaci$$HEX1$$f300$$ENDHEX$$n de los par$$HEX1$$e100$$ENDHEX$$metros de encriptaci$$HEX1$$f300$$ENDHEX$$n es correcta
// Las combinaciones posibles son las siguientes : 

// -noaccess
// -nocopy
// -noprint
// -nohighres
// -nomodify
// -nomodify, noassembly
// -nomodify, noassembly, nonotes
// -nomodify, nofill, nonotes
// -nomodify, nofill, nonotes, noassembly
string retorno = '1'

/*
IF (i_noaccess = false and i_nocopy = false and i_noprint = false and i_nohighres = false &
	and i_nomodify = false and i_nonotes = false and i_nofill = false and i_noassembly = false) THEN 
ELSEIF i_noaccess = true and i_nocopy = false and i_noprint = false and i_nohighres = false &
   and i_nomodify = false and i_nonotes = false and i_nofill = false and i_noassembly = false THEN 
ELSEIF i_noaccess = false and i_nocopy = true and i_noprint = false and i_nohighres = false & 
   and i_nomodify = false and i_nonotes = false and i_nofill = false and i_noassembly = false THEN 
ELSEIF i_noaccess = false and i_nocopy = false and i_noprint = true and i_nohighres = false & 
   and i_nomodify = false and i_nonotes = false and i_nofill = false and i_noassembly = false THEN 
ELSEIF i_noaccess = false and i_nocopy = false and i_noprint = false and i_nohighres = true & 
   and i_nomodify = false and i_nonotes = false and i_nofill = false and i_noassembly = false THEN 
ELSEIF i_noaccess = false and i_nocopy = false and i_noprint = false and i_nohighres = false & 
	and i_nomodify = true and i_nonotes = false and i_nofill = false and i_noassembly = false THEN 
ELSEIF i_noaccess = false and i_nocopy = false and i_noprint = false and i_nohighres = false & 
   and i_nomodify = true and i_nonotes = false and i_nofill = false and i_noassembly = true THEN 
ELSEIF i_noaccess = false and i_nocopy = false and i_noprint = false and i_nohighres = false & 
   and i_nomodify = true and i_nonotes = true and i_nofill = false and i_noassembly = true THEN 
ELSEIF i_noaccess = false and i_nocopy = false and i_noprint = false and i_nohighres = false & 
   and i_nomodify = true and i_nonotes = true and i_nofill = true and i_noassembly = false THEN 
ELSEIF i_noaccess = false and i_nocopy = false and i_noprint = false and i_nohighres = false & 
   and i_nomodify = true and i_nonotes = true and i_nofill = true and i_noassembly = true THEN 
ELSEIF i_noaccess = false and i_nocopy = true and i_noprint = false and i_nohighres = false & 
   and i_nomodify = true and i_nonotes = true and i_nofill = false and i_noassembly = true THEN 

ELSE 
	retorno = '-1'
END IF
*/

return retorno
end function

on u_signer.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_signer.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// Inicializacion variables por defecto
i_noaccess = false
i_nocopy = false
i_noprint =  false 
i_nohighres = false
i_nomodify = false
i_nonotes = false
i_nofill = false
i_noassembly = false

i_fichero_entrada = ''
i_retorno = '-1'

// Este es el directorio pa la aplicacion de Rescat
i_directorio_aplicacion = g_dir_aplicacion



end event

