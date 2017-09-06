HA$PBExportHeader$n_csd_ftpservices.sru
forward
global type n_csd_ftpservices from nonvisualobject
end type
type os_systemtime from structure within n_csd_ftpservices
end type
end forward

type os_systemtime from structure
	unsignedinteger		wyear
	unsignedinteger		wmonth
	unsignedinteger		wdayofweek
	unsignedinteger		wday
	unsignedinteger		whour
	unsignedinteger		wminute
	unsignedinteger		wsecond
	unsignedinteger		wmilliseconds
end type

global type n_csd_ftpservices from nonvisualobject autoinstantiate
end type

type prototypes
protected:

function ulong FTPAbrirConexionServidor(string Host, uint Puerto, string Usuario, string Password, boolean ConexionPasiva) library "FTPServices.dll" alias for "FTPAbrirConexionServidor;Ansi"
function ulong FTPAbrirConexionServidorEx(string Host, uint Puerto, string Usuario, string Password, boolean ConexionPasiva, boolean Asincrono, ulong VentanaProgreso, ulong NumMensaje) library "FTPServices.dll" alias for "FTPAbrirConexionServidorEx;Ansi"
subroutine FTPCerrarConexionServidor(ulong IdConexion) library "FTPServices.dll"
function boolean FTPIniciarDescargaArchivo(ulong IdConexion, string ArchivoRemoto, string ArchivoLocal) library "FTPServices.dll" alias for "FTPIniciarDescargaArchivo;Ansi"
function boolean FTPIniciarEnvioArchivo(ulong IdConexion, string ArchivoLocal, string ArchivoRemoto) library "FTPServices.dll" alias for "FTPIniciarEnvioArchivo;Ansi"
subroutine FTPEstadoTransferenciaArchivo(ulong IdConexion, ref ulong Estado, ref string MensajeEstado, ulong TamanyoMensajeEstado, ref ulong BytesEnviados, ref ulong TotalBytes) library "FTPServices.dll" alias for "FTPEstadoTransferenciaArchivo;Ansi"
function long FTPIniciarBusquedaArchivo(ulong IdConexion, string CadenaBusqueda, ref string NombreArchivo, os_systemtime FechaModificado, ref boolean EsDirectorio) library "FTPServices.dll" alias for "FTPIniciarBusquedaArchivo;Ansi"
function long FTPContinuarBusquedaArchivo(ulong IdConexion, ref string NombreArchivo, os_systemtime FechaModificado, ref boolean EsDirectorio) library "FTPServices.dll" alias for "FTPContinuarBusquedaArchivo;Ansi"
function boolean FTPCambiarDirectorio(ulong IdConexion, string RutaDirectorio) library "FTPServices.dll" alias for "FTPCambiarDirectorio;Ansi"
function boolean FTPBorrarArchivo(ulong IdConexion, string ArchivoRemoto) library "FTPServices.dll" alias for "FTPBorrarArchivo;Ansi"

end prototypes

type variables

public:
constant long ESTADO_TRANSFERENCIA_CONECTANDO = 1
constant long ESTADO_TRANSFERENCIA_CONECTADO = 2
constant long ESTADO_TRANSFERENCIA_DESCARGANDO = 3
constant long ESTADO_TRANSFERENCIA_ENVIANDO = 4
constant long ESTADO_TRANSFERENCIA_COMPLETADO = 5
constant long ESTADO_TRANSFERENCIA_ABORTADO = 6

end variables

forward prototypes
public function boolean of_iniciardescargaarchivo (unsignedlong idconexion, string archivoremoto, string archivolocal)
public function boolean of_iniciarenvioarchivo (unsignedlong idconexion, string archivolocal, string archivoremoto)
public function long of_buscararchivos (unsignedlong idconexion, string cadenabusqueda, ref string nombres[], ref datetime fechas[], boolean directorios[])
public subroutine of_cerrarconexionservidor (unsignedlong idconexion)
protected function datetime of_convertsystemtimetopb (os_systemtime systemtime)
public function unsignedlong of_abrirconexionservidor (string host, unsignedinteger puerto, string usuario, string password, boolean conexionpasiva, boolean asincrono, window ventanaprogreso, unsignedlong nummensaje)
public subroutine of_estadotransferenciaarchivo (unsignedlong idconexion, ref unsignedlong estado, ref string mensajeestado, ref unsignedlong bytesenviados, ref unsignedlong totalbytes)
public function unsignedlong of_abrirconexionservidor (string host, unsignedinteger puerto, string usuario, string password, boolean conexionpasiva)
public function boolean of_ftpcambiardirectorio (unsignedlong idconexion, string rutadirectorio)
public function boolean of_borrararchivo (unsignedlong idconexion, string archivoremoto)
end prototypes

public function boolean of_iniciardescargaarchivo (unsignedlong idconexion, string archivoremoto, string archivolocal);/*
Realiza la descarga de un archivo del servidor FTP.

* Par$$HEX1$$e100$$ENDHEX$$metros:

IdConexion: Identificador de la conexi$$HEX1$$f300$$ENDHEX$$n abierta con el servidor FTP.

ArchivoRemoto: Ruta completa o relativa del archivo dentro del servidor FTP.

ArchivoLocal: Ruta completa o relativa donde se guardar$$HEX2$$e1002000$$ENDHEX$$el archivo descargado.

* Devuelve:

Para una conexi$$HEX1$$f300$$ENDHEX$$n abierta en modo s$$HEX1$$ed00$$ENDHEX$$ncrono devuelve TRUE si se complet$$HEX2$$f3002000$$ENDHEX$$la descarga con $$HEX1$$e900$$ENDHEX$$xito. Para el
funcionamiento en modo as$$HEX1$$ed00$$ENDHEX$$ncrono devuelve TRUE si se inici$$HEX2$$f3002000$$ENDHEX$$la descarga. Devuelve FALSE si se produce alg$$HEX1$$fa00$$ENDHEX$$n
fallo.

* Notas:

Si el archivo local existe ser$$HEX2$$e1002000$$ENDHEX$$sobrescrito.
*/

return FTPIniciarDescargaArchivo(IdConexion, ArchivoRemoto, ArchivoLocal)


end function

public function boolean of_iniciarenvioarchivo (unsignedlong idconexion, string archivolocal, string archivoremoto);/*
Sube un archivo a un servidor FTP.

* Par$$HEX1$$e100$$ENDHEX$$metros:

IdConexion: Identificador de la conexi$$HEX1$$f300$$ENDHEX$$n abierta con el servidor FTP.

ArchivoLocal: Ruta completa o relativa del archivo a enviar.

ArchivoRemoto: Ruta completa o relativa del archivo donde se guardar$$HEX2$$e1002000$$ENDHEX$$el archivo dentro del servidor FTP.

* Devuelve:

Para una conexi$$HEX1$$f300$$ENDHEX$$n abierta en modo s$$HEX1$$ed00$$ENDHEX$$ncrono devuelve TRUE si se complet$$HEX2$$f3002000$$ENDHEX$$el env$$HEX1$$ed00$$ENDHEX$$o con $$HEX1$$e900$$ENDHEX$$xito. Para el
funcionamiento en modo as$$HEX1$$ed00$$ENDHEX$$ncrono devuelve TRUE si se inici$$HEX2$$f3002000$$ENDHEX$$el env$$HEX1$$ed00$$ENDHEX$$o. Devuelve FALSE si se produce alg$$HEX1$$fa00$$ENDHEX$$n
fallo.

* Notas:

Si el archivo remoto existe, normalmente ser$$HEX2$$e1002000$$ENDHEX$$sobrescrito, aunque depende de la configuraci$$HEX1$$f300$$ENDHEX$$n del servidor
FTP.
*/

return FTPIniciarEnvioArchivo(IdConexion, ArchivoLocal, ArchivoRemoto)

end function

public function long of_buscararchivos (unsignedlong idconexion, string cadenabusqueda, ref string nombres[], ref datetime fechas[], boolean directorios[]);/* Obtiene un listado de archivos de un directorio del FTP.

* Par$$HEX1$$e100$$ENDHEX$$metros:

IdConexion: Identificador de la conexi$$HEX1$$f300$$ENDHEX$$n abierta con el servidor FTP.

CadenaBusqueda: Cadena con la ruta y el nombre de archivo a buscar. El nombre puede contener caracteres
	comod$$HEX1$$ed00$$ENDHEX$$n.

Nombres: Se devuelve un array con la lista de los nombres encontrados.

Fechas: Se devuelve un array con la fecha de modificaci$$HEX1$$f300$$ENDHEX$$n correspondiente a cada nombre de archivo.

Directorios: Se devuelve un array indicando para cada archivo si se trata de un directorio o no.

* Devuelve:

El n$$HEX1$$fa00$$ENDHEX$$mero total de archivos encontrados o 0 si no se encontr$$HEX2$$f3002000$$ENDHEX$$ninguno. En caso de producirse algun error
el valor devuelto ser$$HEX2$$e1002000$$ENDHEX$$menor de 0.

* Notas:

La b$$HEX1$$fa00$$ENDHEX$$squeda se har$$HEX2$$e1002000$$ENDHEX$$en modo s$$HEX1$$ed00$$ENDHEX$$ncrono aunque se haya abierto la conexi$$HEX1$$f300$$ENDHEX$$n con el servidor FTP en modo as$$HEX1$$ed00$$ENDHEX$$ncrono.
*/


string nombre
os_systemtime fecha
boolean directorio
string nombres_archivos[]
datetime fechas_archivos[]
boolean directorio_archivos[]
long result
long num_archivos

nombre = space(260) // Reservamos espacio para el buffer (MAX_PATH son 260 caracteres)


result = FTPIniciarBusquedaArchivo(idconexion, cadenabusqueda, nombre, fecha, directorio)
if result < 0 then return result

num_archivos = 0
do while result > 0
	num_archivos++
	nombres_archivos[num_archivos] = nombre
	fechas_archivos[num_archivos] = of_convertsystemtimetopb(fecha)
	directorio_archivos[num_archivos] = directorio
	
	FTPContinuarBusquedaArchivo(idconexion, nombre, fecha, directorio)
	if result < 0 then return result
loop

nombres = nombres_archivos
fechas = fechas_archivos

return num_archivos

end function

public subroutine of_cerrarconexionservidor (unsignedlong idconexion);/*
Termina una conexi$$HEX1$$f300$$ENDHEX$$n abierta con FTPAbrirConexionServidor. Si alguna operaci$$HEX1$$f300$$ENDHEX$$n en progreso se aborta.

* Par$$HEX1$$e100$$ENDHEX$$metros:

IdConexion: Identificador de la conexi$$HEX1$$f300$$ENDHEX$$n abierta con el servidor FTP.

* Notas:

Una vez cerrada una conexi$$HEX1$$f300$$ENDHEX$$n el identificador de conexi$$HEX1$$f300$$ENDHEX$$n ya no es v$$HEX1$$e100$$ENDHEX$$lido y no debe ser utilizado con
ninguna funci$$HEX1$$f300$$ENDHEX$$n, ni si quiera FTPEstadoTransferenciaArchivo.
*/

FTPCerrarConexionServidor(IdConexion)

end subroutine

protected function datetime of_convertsystemtimetopb (os_systemtime systemtime);/* Convierte una estructura SYSTEMTIME del API de Windows a un datetime de PowerBuilder. */

date pb_date
time pb_time

// C$$HEX1$$f300$$ENDHEX$$digo extraido de n_cst_filesrvwin32.of_convertfiledatetimetopb
pb_date = Date(systemtime.wYear, systemtime.wMonth, systemtime.wDay)
pb_time = Time(String(systemtime.wHour) + ":" + String(systemTime.wMinute) + ":" + String(systemTime.wSecond) + ":" + String(systemTime.wMilliseconds))

return datetime(pb_date, pb_time)

end function

public function unsignedlong of_abrirconexionservidor (string host, unsignedinteger puerto, string usuario, string password, boolean conexionpasiva, boolean asincrono, window ventanaprogreso, unsignedlong nummensaje);/*
Establece una conexi$$HEX1$$f300$$ENDHEX$$n con un servidor FTP para poder realizar operaciones de descarga y env$$HEX1$$ed00$$ENDHEX$$o de archivos.

* Par$$HEX1$$e100$$ENDHEX$$metros:

Host: Nombre o direcci$$HEX1$$f300$$ENDHEX$$n IP del servidor de FTP al que conectar.

Puerto: N$$HEX1$$fa00$$ENDHEX$$mero del puerto en que el servidor FTP est$$HEX2$$e1002000$$ENDHEX$$escuchando. Normalmente es el 21.

Usuario: Nombre de usuario con el que iniciar sesi$$HEX1$$f300$$ENDHEX$$n en el servidor de FTP.

Password: Contrase$$HEX1$$f100$$ENDHEX$$a del usuario con el que se inicia sesi$$HEX1$$f300$$ENDHEX$$n.

ConexionPasiva: Indica si la conexi$$HEX1$$f300$$ENDHEX$$n que se realice con el servidor ha de ser pasiva o no. Con una
	conexi$$HEX1$$f300$$ENDHEX$$n pasiva, para las conexiones de datos el servidor escucha en un determinado puerto y espera la
	conexi$$HEX1$$f300$$ENDHEX$$n por parte del cliente. En una conexi$$HEX1$$f300$$ENDHEX$$n no pasiva es el cliente quien escucha y espera que se
	conecte	el servidor. Dependiendo de la configuraci$$HEX1$$f300$$ENDHEX$$n de red y de si existen firewalls entre servidor y
	cliente, puede que sea necesario emplear conexiones pasivas o no. Normalmente las conexiones pasivas son
	m$$HEX1$$e100$$ENDHEX$$s confiables ya que no exigen que el cliente tenga que poder aceptar conexiones entrantes por parte
	del servidor.

Asincrono: Si es TRUE se emplear$$HEX2$$e1002000$$ENDHEX$$un modelo as$$HEX1$$ed00$$ENDHEX$$ncrono para las trasnferencias. El modelo as$$HEX1$$ed00$$ENDHEX$$ncrono permite
	que las transferencias se hagan en segundo plano mientras la ejecuci$$HEX1$$f300$$ENDHEX$$n del programa contin$$HEX1$$fa00$$ENDHEX$$a. Con el
	modelo s$$HEX1$$ed00$$ENDHEX$$ncrono las llamadas a las funciones no retornan hasta que no se ha llevado a cabo la
	operaci$$HEX1$$f300$$ENDHEX$$n deseada (o ha fallado), mientras que con el modelo as$$HEX1$$ed00$$ENDHEX$$ncrono la funci$$HEX1$$f300$$ENDHEX$$n retorna lo antes
	posible y la operaci$$HEX1$$f300$$ENDHEX$$n en cuesti$$HEX1$$f300$$ENDHEX$$n contin$$HEX1$$fa00$$ENDHEX$$a realiz$$HEX1$$e100$$ENDHEX$$ndose en segundo plano. Es posible saber cuando ha
	acabado la operaci$$HEX1$$f300$$ENDHEX$$n consult$$HEX1$$e100$$ENDHEX$$ndolo con la funci$$HEX1$$f300$$ENDHEX$$n FTPEstadoTransferenciaArchivo. Tambi$$HEX1$$e900$$ENDHEX$$n es posible
	hacer que el sistema env$$HEX1$$ed00$$ENDHEX$$e mensajes a una ventana informando sobre el estado de la operaci$$HEX1$$f300$$ENDHEX$$n.

VentanaProgreso: Si se especifica el manipulador de una ventana, se enviar$$HEX1$$e100$$ENDHEX$$n mensajes dicha ventana
	informando sobre el estado de la operaci$$HEX1$$f300$$ENDHEX$$n en progreso. Los mensajes de estado pueden emplearse tanto
	si el modo de funcionamiento es as$$HEX1$$ed00$$ENDHEX$$ncrono o no. Este par$$HEX1$$e100$$ENDHEX$$metro puede ser NULL.

NumMensaje: Para capturar el mensaje de estado la ventana de progreso debe tener definido un evento cuyo
	Event ID que sea pbm_custom01 o pbm_custom02, etc. NumMensaje es el valor del evento custom (1 para
	pbm_custom01, 2 para pbm_custom02, etc.)

* Devuelve:

Devuelve el identificador de la conexi$$HEX1$$f300$$ENDHEX$$n creada si se pudo realizar la conexi$$HEX1$$f300$$ENDHEX$$n o 0 si fall$$HEX1$$f300$$ENDHEX$$. El
identificador de la conexi$$HEX1$$f300$$ENDHEX$$n es necesario para posteriores llamadas a otras funciones que operen sobre esa
conexi$$HEX1$$f300$$ENDHEX$$n.

* Notas:

Una vez se haya terminado de usar la conexi$$HEX1$$f300$$ENDHEX$$n, esta debe ser cerrada con FTPCerrarConexionServidor.

Los mensajes que se env$$HEX1$$ed00$$ENDHEX$$an a la ventana de progreso contendr$$HEX1$$e100$$ENDHEX$$n en el par$$HEX1$$e100$$ENDHEX$$metro WPARAM el IdConexion al que
se refiere el cambio de estado producido. T$$HEX1$$ed00$$ENDHEX$$picamente se emplear$$HEX2$$e1002000$$ENDHEX$$el IdConexion para llamar
FTPEstadoTransferenciaArchivo y obtener m$$HEX1$$e100$$ENDHEX$$s informaci$$HEX1$$f300$$ENDHEX$$n sobre el estado actual de la operaci$$HEX1$$f300$$ENDHEX$$n en progreso.
Cuando se env$$HEX1$$ed00$$ENDHEX$$a un mensaje a la ventana de progreso, se espera a que el mensaje sea procesado para
continuar con el proceso de transferencia. Esto implica que las acciones llevadas a cabo por la ventana al
procesar los mensajes deben ser breves para que no se produzca un timeout en la transferencia.
*/

long hWnd

if isnull(VentanaProgreso) then
	hWnd = 0
else
	hWnd = handle(VentanaProgreso)
end if

return FTPAbrirConexionServidorEx(Host, Puerto, Usuario, Password, ConexionPasiva, Asincrono, hWnd, NumMensaje - 1)

end function

public subroutine of_estadotransferenciaarchivo (unsignedlong idconexion, ref unsignedlong estado, ref string mensajeestado, ref unsignedlong bytesenviados, ref unsignedlong totalbytes);/*
Informa del estado actual de una transferencia.

* Par$$HEX1$$e100$$ENDHEX$$metros:

IdConexion: Identificador de la conexi$$HEX1$$f300$$ENDHEX$$n abierta con el servidor FTP.

Estado: Puntero a un DWORD donde se almacenar$$HEX2$$e1002000$$ENDHEX$$el estado actual de la transferencia. Los posibles estados
	son:

	- ESTADO_TRANSFERENCIA_CONECTANDO -> Se ha iniciado el proceso de conexi$$HEX1$$f300$$ENDHEX$$n con el servidor.
	- ESTADO_TRANSFERENCIA_CONECTADO -> Ha terminado el proceso de conexi$$HEX1$$f300$$ENDHEX$$n con el servidor. A partir de
		este estado se pueden invocar nuevas transferencias de env$$HEX1$$ed00$$ENDHEX$$o o descarga.
	- ESTADO_TRANSFERENCIA_DESCARGANDO -> Hay un proceso de descarga de un archivo en progreso. Mientras una
		descarga est$$HEX2$$e1002000$$ENDHEX$$en progreso no es posible realizar otras descargas o env$$HEX1$$ed00$$ENDHEX$$os.
	- ESTADO_TRANSFERENCIA_ENVIANDO -> Hay un proceso de env$$HEX1$$ed00$$ENDHEX$$o de un archivo en progreso. Mientras un env$$HEX1$$ed00$$ENDHEX$$o
		est$$HEX2$$e1002000$$ENDHEX$$en progreso no es posible realizar otros env$$HEX1$$ed00$$ENDHEX$$os o descargas.
	- ESTADO_TRANSFERENCIA_COMPLETADO -> El proceso de descarga o de env$$HEX1$$ed00$$ENDHEX$$o ha terminado con $$HEX1$$e900$$ENDHEX$$xito. A partir de
		este estado se pueden invocar nuevas transferencias de env$$HEX1$$ed00$$ENDHEX$$o o descarga.
	- ESTADO_TRANSFERENCIA_ABORTADO -> El proceso de conexi$$HEX1$$f300$$ENDHEX$$n o de descarga o de env$$HEX1$$ed00$$ENDHEX$$o ha fallado por alg$$HEX1$$fa00$$ENDHEX$$n
		motivo. El fallo suele deberse a alg$$HEX1$$fa00$$ENDHEX$$n problema con la conexi$$HEX1$$f300$$ENDHEX$$n con el servidor, por lo que en
		general no es posible realizar otras descargas o env$$HEX1$$ed00$$ENDHEX$$os a partir de este estado.

MensajeEstado: Puntero a un cadena de caracteres donde se guardar$$HEX2$$e1002000$$ENDHEX$$un mensaje descriptivo del estado actual.

BytesEnviados: Puntero a un ULONG donde se almacenar$$HEX2$$e1002000$$ENDHEX$$la cantidad de bytes enviados hasta el momento en el
	proceso de descarga o env$$HEX1$$ed00$$ENDHEX$$o de un archivo.

TotalBytes: Puntero a un ULONG donde se almacenar$$HEX2$$e1002000$$ENDHEX$$la cantidad total de bytes a enviar o recinir, es decir,
	el tama$$HEX1$$f100$$ENDHEX$$o del archivo.
*/

MensajeEstado = space(2000) // Reservamos espacio para el buffer

FTPEstadoTransferenciaArchivo(IdConexion, Estado, MensajeEstado, LenA(MensajeEstado), BytesEnviados, TotalBytes)

end subroutine

public function unsignedlong of_abrirconexionservidor (string host, unsignedinteger puerto, string usuario, string password, boolean conexionpasiva);/*
Establece una conexi$$HEX1$$f300$$ENDHEX$$n con un servidor FTP para poder realizar operaciones de descarga y env$$HEX1$$ed00$$ENDHEX$$o de archivos.

* Par$$HEX1$$e100$$ENDHEX$$metros:

Host: Nombre o direcci$$HEX1$$f300$$ENDHEX$$n IP del servidor de FTP al que conectar.

Puerto: N$$HEX1$$fa00$$ENDHEX$$mero del puerto en que el servidor FTP est$$HEX2$$e1002000$$ENDHEX$$escuchando. Normalmente es el 21.

Usuario: Nombre de usuario con el que iniciar sesi$$HEX1$$f300$$ENDHEX$$n en el servidor de FTP.

Password: Contrase$$HEX1$$f100$$ENDHEX$$a del usuario con el que se inicia sesi$$HEX1$$f300$$ENDHEX$$n.

ConexionPasiva: Indica si la conexi$$HEX1$$f300$$ENDHEX$$n que se realice con el servidor ha de ser pasiva o no. Con una
	conexi$$HEX1$$f300$$ENDHEX$$n pasiva, para las conexiones de datos el servidor escucha en un determinado puerto y espera la
	conexi$$HEX1$$f300$$ENDHEX$$n por parte del cliente. En una conexi$$HEX1$$f300$$ENDHEX$$n no pasiva es el cliente quien escucha y espera que se
	conecte	el servidor. Dependiendo de la configuraci$$HEX1$$f300$$ENDHEX$$n de red y de si existen firewalls entre servidor y
	cliente, puede que sea necesario emplear conexiones pasivas o no. Normalmente las conexiones pasivas son
	m$$HEX1$$e100$$ENDHEX$$s confiables ya que no exigen que el cliente tenga que poder aceptar conexiones entrantes por parte
	del servidor.

* Devuelve:

Devuelve el identificador de la conexi$$HEX1$$f300$$ENDHEX$$n creada si se pudo realizar la conexi$$HEX1$$f300$$ENDHEX$$n o 0 si fall$$HEX1$$f300$$ENDHEX$$. El
identificador de la conexi$$HEX1$$f300$$ENDHEX$$n es necesario para posteriores llamadas a otras funciones que operen sobre esa
conexi$$HEX1$$f300$$ENDHEX$$n.

* Notas:

Una vez se haya terminado de usar la conexi$$HEX1$$f300$$ENDHEX$$n, esta debe ser cerrada con FTPCerrarConexionServidor.
*/

return FTPAbrirConexionServidor(Host, Puerto, Usuario, Password, ConexionPasiva);

end function

public function boolean of_ftpcambiardirectorio (unsignedlong idconexion, string rutadirectorio);/*
Cambia el directorio de trabajo de la sesi$$HEX1$$f300$$ENDHEX$$n FTP.

* Par$$HEX1$$e100$$ENDHEX$$metros:

IdConexion: Identificador de la conexi$$HEX1$$f300$$ENDHEX$$n abierta con el servidor FTP.

RutaDirectorio: Ruta completa o relativa del nuevo directorio de trabajo.

* Devuelve:

Devuelve si la operaci$$HEX1$$f300$$ENDHEX$$n tuvo $$HEX1$$e900$$ENDHEX$$xito o no.

* Notas:

Esta funci$$HEX1$$f300$$ENDHEX$$n no es compatible con las conexiones en modo as$$HEX1$$ed00$$ENDHEX$$ncrono.
*/
return FTPCambiarDirectorio(IdConexion, RutaDirectorio)

end function

public function boolean of_borrararchivo (unsignedlong idconexion, string archivoremoto);/*
Borra un archivo del servidor FTP.

* Par$$HEX1$$e100$$ENDHEX$$metros:

IdConexion: Identificador de la conexi$$HEX1$$f300$$ENDHEX$$n abierta con el servidor FTP.

ArchivoRemoto: Ruta completa o relativa del archivo que se va a borrar dentro del servidor FTP.

* Devuelve:

Devuelve si la operaci$$HEX1$$f300$$ENDHEX$$n tuvo $$HEX1$$e900$$ENDHEX$$xito o no.

* Notas:

Esta funci$$HEX1$$f300$$ENDHEX$$n no es compatible con las conexiones en modo as$$HEX1$$ed00$$ENDHEX$$ncrono.
*/

return FTPBorrarArchivo(IdConexion, ArchivoRemoto)

end function

on n_csd_ftpservices.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_csd_ftpservices.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

