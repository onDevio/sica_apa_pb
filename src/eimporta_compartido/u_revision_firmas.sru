HA$PBExportHeader$u_revision_firmas.sru
forward
global type u_revision_firmas from nonvisualobject
end type
end forward

global type u_revision_firmas from nonvisualobject
end type
global u_revision_firmas u_revision_firmas

type variables
Public:
	string is_nombre_fichero_pdf
	string is_nombre_fichero_ini
	int ii_num_firmas, ii_num_revisiones
	string is_nombre_firma[]
	string is_razon_firma[]
	string is_localizacion[]
	
	string is_cn_certificado[]
	string is_ou_codigo_certificado[]
	string is_ou_descripcion_certificado[]
	datetime idt_fecha_firma[]
	datetime idt_fecha_desde_certificado[]
	datetime idt_fecha_hasta_certificado[]	
	string is_numero_serie[]
	boolean ib_firma_valida[]
	boolean ib_certificado_valido[]
	string is_error_firma[]  // ERRORES EN EL ANALISIS DE LOS CERTIFICADOS (VALIDEZ / INVALIDEZ)
	string i_error  // ERRORES GENERALES AL LEER EL CERTIFICADO (FIRMASPDF, ERRORES DE LECTURA DEL FICHERO..)
	boolean es_correcto=false
	integer i_retorno

	boolean ib_firma_caducada[]
	
	//Variable que indica las claves publicas sobre las que validar el PDF. Si no se especifica 
	// se validar$$HEX2$$e1002000$$ENDHEX$$sobre un almacen de claves.
	string is_claves_publicas
	
end variables

forward prototypes
public subroutine of_rellenar_datos ()
public function string of_generar_password (string fichero)
public function st_eimporta_validacion_certificado of_revisar_fichero (string fichero_pdf, boolean revisar_firma, boolean revisar_certificado)
public function string of_devolver_error (st_eimporta_validacion_certificado resultado_validacion)
public function long of_leer_certificado (boolean validar_certificados)
end prototypes

public subroutine of_rellenar_datos ();//Funcion que coge el ini y rellena las estructuras con los datos del ini generado

int i
string bloque1
string bloque2
string fecha_desde,fecha_hasta

string firma_temp, certificado_temp,fecha_firma

bloque1 = 'datos_firma_'
bloque2 = 'datos_certificado_'

ii_num_firmas = integer(profilestring(is_nombre_fichero_ini, 'general', 'num_firmas', ""))
ii_num_revisiones = integer(profilestring(is_nombre_fichero_ini, 'general', 'num_revisiones', ""))

for i = 1 to ii_num_firmas
		
	is_nombre_firma[i] = profilestring(is_nombre_fichero_ini, bloque1 + string(i), "nombre", "")
	is_razon_firma[i] = profilestring(is_nombre_fichero_ini, bloque1 + string(i), "razon", "")
	is_localizacion[i] = profilestring(is_nombre_fichero_ini, bloque1 + string(i), "localizacion", "")
	fecha_firma=profilestring(is_nombre_fichero_ini, bloque1 + string(i), "fecha", "")	
	idt_fecha_firma[i] = DateTime( Date( LeftA( fecha_firma, 10) ) , Time( RightA( fecha_firma, 8 ) ) )

	is_cn_certificado[i] = profilestring(is_nombre_fichero_ini, bloque2 + string(i), "cn", "")
	
	fecha_desde = profilestring(is_nombre_fichero_ini, bloque2 + string(i), "fecha_desde", "")
	fecha_hasta = profilestring(is_nombre_fichero_ini, bloque2 + string(i), "fecha_hasta", "")
	idt_fecha_desde_certificado[i] = DateTime( Date( LeftA( fecha_desde, 10) ) , Time( RightA( fecha_desde, 8 ) ) )
	idt_fecha_hasta_certificado[i] = DateTime( Date( LeftA( fecha_hasta, 10) ) , Time( RightA( fecha_hasta, 8 ) ) )
	
	if idt_fecha_firma[i] < idt_fecha_desde_certificado[i] or idt_fecha_firma[i] > idt_fecha_hasta_certificado[i] then
		ib_firma_caducada[i]=true
	else
		ib_firma_caducada[i]=false
	end if

	is_numero_serie[i] = profilestring(is_nombre_fichero_ini, bloque2 + string(i), "numero_serie", "")
	
	firma_temp = profilestring(is_nombre_fichero_ini, bloque2 + string(i), "firma_valida", "")
	if firma_temp = 'true' then
		ib_firma_valida[i]= true
	else
		ib_firma_valida[i] = false
	end if
	
	certificado_temp = profilestring(is_nombre_fichero_ini, bloque2 + string(i), "certificado_valido", "")
	if certificado_temp = 'true' then
		ib_certificado_valido[i] = true
	else
		ib_certificado_valido[i] = false
	end if
	
	is_error_firma[i] = profilestring(is_nombre_fichero_ini, bloque2 + string(i), "error", "")
next

end subroutine

public function string of_generar_password (string fichero);int vec[]
int i
double suma = 0
double tamano

n_cst_filesrvwin32 dire
dire = create n_cst_filesrvwin32
tamano = dire.of_GetFileSize(fichero)
destroy dire

//1 - Transformamos la ruta del pdf en un array de int en que cada posicion es la conversion de la letra en Ascii
for i = 1 to LenA(fichero)
	vec[i] = AscA(MidA(fichero,i,1))
next

//2 - Obtenemos la suma de ese array
for i = 1 to upperbound(vec)
	suma += vec[i]
next

//3 - Multiplica el resultado por el tama$$HEX1$$f100$$ENDHEX$$o del fichero
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

public function st_eimporta_validacion_certificado of_revisar_fichero (string fichero_pdf, boolean revisar_firma, boolean revisar_certificado);int i,j,k
int num_firmas, num_revisiones
string firmantes
boolean firma_valida
boolean certificados_validos = true,certificado_caducado=false
st_eimporta_validacion_certificado  st_cert

firma_valida = true


/*

ERRORES

0 = FIRMA VALIDA
1 = FIRMA INVALIDA
2 = FIRMA CADUCADO
3 = CERTIFICADO NO ENCONTRADO
4 = CERTIFICADO INVALIDO
5 = CERTIFICADO INVALIDO

*/

if not(revisar_firma) then
	st_cert.firma_valida='D'
	st_cert.certificado_valido='D'
else
	if upper(right(fichero_pdf,3))='PDF' then
		//Comprobamos las firmas
		is_nombre_fichero_pdf = fichero_pdf
		is_nombre_fichero_ini =  left(fichero_pdf,len(fichero_pdf) - 4) + ".ini"
		
		of_leer_certificado(true)
	
		firmantes = ''
		st_cert.num_firmas = ii_num_firmas
		num_revisiones = ii_num_revisiones
		
		//A$$HEX1$$f100$$ENDHEX$$adimos los firmantes y comprobamos la validez de todas las firmas
		for j = 1 to st_cert.num_firmas
	
			st_cert.error_firma[j] = 0
			
			if firmantes = '' then
				firmantes = is_cn_certificado[j]
			else
				firmantes += cr + is_cn_certificado[j]			
			end if
			
			if ib_firma_valida[j] = false or is_error_firma[j] = '-3' then
				firma_valida = false
				st_cert.error_firma[j] = 1			
			end if		
			
			if ib_firma_caducada[j] = true then 
				certificado_caducado = true
				st_cert.error_firma[j] = 2
				continue
			end if		
				
			if ib_certificado_valido[j] = false then
				certificados_validos = false
				st_cert.error_firma[j] = 3
			end if
			
			if  is_error_firma[j] = '-2' then
				certificados_validos = false
				st_cert.error_firma[j] = 4			
			end if
			
			if  is_error_firma[j] = '-4' then 
				certificados_validos = false
				st_cert.error_firma[j] = 5				
			end if			
	
		next
				
			
		//Segun la combinacion, el estado del documento varia
		// N - No firmado
		if st_cert.num_firmas = 0 then st_cert.firma_valida='N'
	
		// V - Firmado la ultima firma Valida (es la que engloba todo el documento)
		if st_cert.num_firmas > 0 and firma_valida = true and st_cert.num_firmas = num_revisiones then  st_cert.firma_valida='V'  
	
		// F - Firmado pero la ultima firma Valida no es valida
		if st_cert.num_firmas > 0 and (firma_valida = false or st_cert.num_firmas <> num_revisiones) then  st_cert.firma_valida='F'   
	
		// E - Error validando la firma
		if st_cert.num_firmas < 0 then 
			st_cert.firma_valida='E'  // ERRROR
			st_cert.num_firmas = 0
		end if	
		
		//Segun el certificado, lo guardamos.
		if certificados_validos = true then
			st_cert.certificado_valido='CV'
		end if
		
		if certificado_caducado=true or certificados_validos = false or st_cert.num_firmas = 0 then
				st_cert.certificado_valido='NV'
		end if
		
		if not(revisar_certificado) then st_cert.certificado_valido='D'
	else
		st_cert.firma_valida='Z'
		st_cert.certificado_valido='ZZ'
		ii_num_firmas = -1
	end if
end if

st_cert.firmantes=firmantes

return st_cert
end function

public function string of_devolver_error (st_eimporta_validacion_certificado resultado_validacion);string mensaje,cert
long i


if i_error="-9" then
	mensaje="No se encuentra el FirmasPDF"
elseif i_error="-5" then
	mensaje="La m$$HEX1$$e100$$ENDHEX$$quina virtual no est$$HEX2$$e1002000$$ENDHEX$$instalada. Requiere el jre 1.4.2 o superior"
else
	for i=1 to ii_num_firmas
		cert= is_cn_certificado[i]
		if f_es_vacio(cert) then cert= is_nombre_firma[i]
		choose case 	resultado_validacion.error_firma[i]
			case 1
				mensaje+="Firma inv$$HEX1$$e100$$ENDHEX$$lida:"+cert+'~n'
			case 2
				mensaje+="Certificado Caducado:"+ is_cn_certificado[i]+'~n'
			case 3
				mensaje+="No se encuentra la Clave Pub.:"+ is_cn_certificado[i]+'~n'
			case 4
				mensaje+="Certificado Inv$$HEX1$$e100$$ENDHEX$$lido:"+ is_cn_certificado[i]+'~n'
			case 5
				mensaje+="Error en la validaci$$HEX1$$f300$$ENDHEX$$n del certificado. Comprobar dl repositorio de claves p$$HEX1$$fa00$$ENDHEX$$blicas "+ is_cn_certificado[i]+'~n'
		end choose
	next
	if ii_num_firmas=0 then mensaje= "El fichero no est$$HEX2$$e1002000$$ENDHEX$$firmado"+'~n'
	if ii_num_firmas=-1 then mensaje="El fichero no es un pdf"+'~n'
end if

//if f_es_vacio(mensaje) then mensaje="La revisi$$HEX1$$f300$$ENDHEX$$n de firmas fue correcta"


return mensaje



end function

public function long of_leer_certificado (boolean validar_certificados);//Abrimos el fichero, cargamos todos los datos
//Devuelve:
//	 1 : CORRECTO
// -1 : PDF encriptado
// -2 : Error al obtener el certificado
// -3 : Error al validar firma
// -4 : Error al validar certificado
// -5 : Maquina virtual no encontrada
// -9 : Error desconocido

string sentencia
int retorno
string version
string password

i_error = ''

//Comprobamos que exista maquina virtual
registryget("HKEY_LOCAL_MACHINE\Software\Javasoft\Java Runtime Environment\","CurrentVersion", version)

if version = '' or isnull(version) or version < '1.4' then
	i_error = 'Imposible validar firmas, necesita la MV de Java 1.4 o superior' + cr
	//Borramos el fichero ini
	filedelete(is_nombre_fichero_ini)
	i_error="-5"
	return 0
end if

//Lanzar el lector de firmas a ejecucion
n_runandwait runandwait
runandwait = create n_runandwait
runandwait.of_SetPriority(runandwait.HIGH_PRIORITY_CLASS)
runandwait.of_SetCurrentDirectory(g_dir_aplicacion)
//runandwait.of_SetWindow("minimize")
runandwait.of_SetWindow("hide")

sentencia = ' -ini "' + is_nombre_fichero_ini + '"'

if validar_certificados = true then
	sentencia += ' -p7b ' + g_directorio_firmas
	if not(f_es_vacio(is_claves_publicas)) then sentencia += ' -nokeystore -claves '+is_claves_publicas
end if

sentencia += ' "' + is_nombre_fichero_pdf + '"'

sentencia = lower(sentencia)

//Ponemos el passsword
password = of_generar_password(lower(is_nombre_fichero_pdf))
sentencia = '-key ' + password + sentencia

if fileexists(g_dir_aplicacion + 'firmasPDF.exe') then
	retorno = runandwait.of_runandwait(g_dir_aplicacion + 'firmasPDF.exe ' + sentencia)
	clipboard(g_dir_aplicacion + 'firmasPDF.exe ' + sentencia)
else
	i_error = 'Error, FirmasPdf no encontrado' + cr
	//Borramos el fichero ini
	filedelete(is_nombre_fichero_ini)
	i_error="-9"
	return 0
end if

if retorno <> 1 then
	i_error += 'Error en la obtencion de los datos de la firma' + cr
	//Borramos el fichero ini
	filedelete(is_nombre_fichero_ini)
	i_error="-2"
	return 0
end if

if (fileexists(is_nombre_fichero_ini) = false) then
	i_error += 'Error en la lectura de los datos de la firma' + cr
	i_error="-2"
	return 0
end if

//Procesamos los datos y rellenamos los vectores
of_rellenar_datos()

if ii_num_firmas = -1 then
	i_error += 'Error, el documento ' + is_nombre_fichero_pdf + ' esta encriptado' + cr
	i_retorno = ii_num_firmas
	i_error="-1"
	return 0
end if
	
//Borramos el fichero ini
if g_debug<>'1' then filedelete(is_nombre_fichero_ini)

return 0


end function

on u_revision_firmas.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_revision_firmas.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

