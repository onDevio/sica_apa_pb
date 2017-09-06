HA$PBExportHeader$n_file_dialogs.sru
forward
global type n_file_dialogs from nonvisualobject
end type
type st_openfilename from structure within n_file_dialogs
end type
end forward

type st_openfilename from structure
	unsignedlong		lstructsize
	unsignedlong		hwndowner
	unsignedlong		hinstance
	blob		lpstrfilter
	string		lpstrcustomfilter
	unsignedlong		nmaxcustfilter
	unsignedlong		nfilterindex
	blob		lpstrfile
	unsignedlong		nmaxfile
	blob		lpstrfiletitle
	unsignedlong		nmaxfiletitle
	string		lpstrinitialdir
	string		lpstrtitle
	unsignedlong		flags
	unsignedinteger		nfileoffset
	unsignedinteger		nfileextension
	string		lpstrdefext
	unsignedlong		lcustdata
	unsignedlong		lpfnhook
	string		lptemplatename
	unsignedlong		pvreserved
	unsignedlong		dwreserved
	unsignedlong		flagsex
end type

global type n_file_dialogs from nonvisualobject autoinstantiate
end type

type prototypes
FUNCTION boolean GetOpenFileName (ref st_openfilename lpofn) LIBRARY "comdlg32.dll" ALIAS FOR "GetOpenFileNameA;ansi"
FUNCTION boolean GetSaveFileName (ref st_openfilename lpofn) LIBRARY "comdlg32.dll" ALIAS FOR "GetSaveFileNameA;ansi"

end prototypes

type variables
private:
constant long OFN_READONLY = 1
constant long OFN_OVERWRITEPROMPT = 2
constant long OFN_HIDEREADONLY = 4
constant long OFN_NOCHANGEDIR = 8
constant long OFN_SHOWHELP = 16
constant long OFN_ENABLEHOOK = 32
constant long OFN_ENABLETEMPLATE = 64
constant long OFN_ENABLETEMPLATEHANDLE = 128
constant long OFN_NOVALIDATE = 256
constant long OFN_ALLOWMULTISELECT = 512
constant long OFN_EXTENSIONDIFFERENT = 1024
constant long OFN_PATHMUSTEXIST = 2048
constant long OFN_FILEMUSTEXIST = 4096
constant long OFN_CREATEPROMPT = 8192
constant long OFN_SHAREAWARE = 16384
constant long OFN_NOREADONLYRETURN = 32768
constant long OFN_NOTESTFILECREATE = 65536
constant long OFN_NONETWORKBUTTON = 131072
constant long OFN_NOLONGNAMES = 262144 // force no long names for 4.x modules
constant long OFN_EXPLORER = 524288 // new look commdlg
constant long OFN_NODEREFERENCELINKS = 1048576
constant long OFN_LONGNAMES = 2097152 // force long names for 3.x modules
constant long OFN_ENABLEINCLUDENOTIFY = 4194304 // send include message to callback
constant long OFN_ENABLESIZING = 8388608
constant long OFN_DONTADDTORECENT = 33554432
constant long OFN_FORCESHOWHIDDEN = 268435456 // Show All files including System and hidden files
constant long OFN_EX_NOPLACESBAR = 1

public:
// Propiedades entrada
boolean ib_overwriteprompt = true
boolean ib_nochangedir = true
boolean ib_pathmustexist = true
boolean ib_filemustexist = true
boolean ib_allowmultiselect = false
boolean ib_nodereferencelinks = false
boolean ib_dontaddtorecent = false
boolean ib_forceshowhidden = false
string is_initialdir = ""

// Propiedades salida
string is_selectedfiles[]

end variables

forward prototypes
public function integer of_getsavefilename (string title, ref string ruta, ref string archivo, string extension, string filtro)
public function integer of_getopenfilename (string title, ref string ruta, ref string archivo, string extension, string filtro)
end prototypes

public function integer of_getsavefilename (string title, ref string ruta, ref string archivo, string extension, string filtro);/* Muestra el cuadro de di$$HEX1$$e100$$ENDHEX$$logo para guardar archivo.

Par$$HEX1$$e100$$ENDHEX$$metros:

title = Titulo de la ventana.

ruta = Devuelve la ruta (sin el nombre de archivo) del archivo seleccionado.

archivo = Devuelve el nombre del archivo seleccionado.
	
extension = Extensi$$HEX1$$f300$$ENDHEX$$n por defecto que se asume para el archivo. Este par$$HEX1$$e100$$ENDHEX$$metro se
	puede omitir.
	
filtro = Lista de posibles filtros de archivos que se permiten seleccionar. El
	formato que debe tener es como el siguiente:
	
	"Archivos de texto (*.txt),*.txt,Documentos de Word (*.doc),*.doc"

Devuelve 1 si se selecci$$HEX1$$f300$$ENDHEX$$n un archivo o 0 si se cancelo la accion.

A trav$$HEX1$$e900$$ENDHEX$$s de las siguientes variables de instancia tambien se puede definir el
comportamiento de la funci$$HEX1$$f300$$ENDHEX$$n. Entre parentesis est$$HEX2$$e1002000$$ENDHEX$$el comportamiento por
defecto.

ib_overwriteprompt (true) -> Pide confirmaci$$HEX1$$f300$$ENDHEX$$n para sobreescribir si el archivo
	ya existe.
ib_nochangedir (true) -> Se restaura el directorio actual en el caso de que el
	usuario lo cambie al buscar el archivo.
ib_nodereferencelinks (false) -> Al seleccionar un archivo .lnk no se guarda en
	el destino al que apunta.
ib_dontaddtorecent (false) -> No a$$HEX1$$f100$$ENDHEX$$adir a la lista de archivos recientes. (S$$HEX1$$f300$$ENDHEX$$lo a
	partir de W2K/XP)
ib_forceshowhidden (false) -> Fuerza a que se muestren los archivos ocultos y de
	sistema. (S$$HEX1$$f300$$ENDHEX$$lo a partir de W2K/XP)
is_initialdir ("") -> Directorio en el que se inicia la apertura de archivos. Si
	se omite se usar$$HEX2$$e1002000$$ENDHEX$$el directorio actual.

*/

st_openfilename ofn
blob{10000} buff_filter
blob{40000} buff_file
blob{1000} buff_filetitle
string array_filtro[]
n_cst_string lnv_string
string arc, archivos[]
long i, pos

ofn.lStructSize = 76 //Tama$$HEX1$$f100$$ENDHEX$$o de st_openfilename (no contamos los 3 ultimos campos a$$HEX1$$f100$$ENDHEX$$adidos a apartir de win 2000 porque no los vamos a usar)
ofn.hwndOwner = 0
ofn.hInstance = 0

lnv_string.of_ParseToArray(filtro, ',', array_filtro)
pos = 1
for i = 1 to UpperBound(array_filtro)
	pos = BlobEdit(buff_filter, pos, array_filtro[i])
next
BlobEdit(buff_filter, pos, "")
ofn.lpstrFilter = buff_filter


SetNull(ofn.lpstrCustomFilter)
ofn.nMaxCustFilter = 0
ofn.nFilterIndex = 0

BlobEdit(buff_file, 1, archivo)
ofn.lpstrFile = buff_file
ofn.nMaxFile = 40000

ofn.lpstrFileTitle = buff_filetitle
ofn.nMaxFileTitle = 1000

if is_initialdir = "" then
	SetNull(ofn.lpstrInitialDir)
else
	ofn.lpstrInitialDir = is_initialdir
end if

ofn.lpstrTitle = title

ofn.Flags = OFN_EXPLORER + OFN_HIDEREADONLY
if ib_overwriteprompt then ofn.Flags += OFN_OVERWRITEPROMPT
if ib_nochangedir then ofn.Flags += OFN_NOCHANGEDIR
if ib_nodereferencelinks then ofn.Flags += OFN_NODEREFERENCELINKS
if ib_dontaddtorecent then ofn.Flags += OFN_DONTADDTORECENT
if ib_forceshowhidden then ofn.Flags += OFN_FORCESHOWHIDDEN


ofn.nFileOffset = 0 
ofn.nFileExtension = 0

if extension = "" then
	SetNull(ofn.lpstrDefExt)
else
	ofn.lpstrDefExt = extension
end if

ofn.lCustData = 0
ofn.lpfnHook = 0
SetNull(ofn.lpTemplateName)
ofn.pvReserved = 0
ofn.dwReserved = 0
ofn.FlagsEx = 0

if not GetSaveFileName(ofn) then return 0

ruta = string(BlobMid(ofn.lpstrFile, 1))
ruta = left(ruta, ofn.nFileOffset)
if right(ruta,1) <> "\" then ruta += "\"
archivo = string(ofn.lpstrFileTitle)

return 1

end function

public function integer of_getopenfilename (string title, ref string ruta, ref string archivo, string extension, string filtro);/* Muestra el cuadro de di$$HEX1$$e100$$ENDHEX$$logo de apertura de archivos.

Par$$HEX1$$e100$$ENDHEX$$metros:

title = Titulo de la ventana.

ruta = Devuelve la ruta (sin el nombre de archivo) del archivo seleccionado.

archivo = Devuelve el nombre del archivo seleccionado. Si ib_allowmultiselect es
        true este campo se dejar$$HEX2$$e1002000$$ENDHEX$$vacio y el nombre de los archivos seleccionados se
        pondr$$HEX2$$e1002000$$ENDHEX$$en is_selectedfiles.
        
extension = Extensi$$HEX1$$f300$$ENDHEX$$n por defecto que se  asume para el archivo. Este par$$HEX1$$e100$$ENDHEX$$metro se
        puede omitir.
        
filtro = Lista de posibles filtros de archivos que se permiten seleccionar. El
        formato que debe tener es como el siguiente:
        
        "Archivos de texto (*.txt),*.txt,Documentos de Word (*.doc),*.doc"

Devuelve 1 si se selecci$$HEX1$$f300$$ENDHEX$$n un archivo o 0 si se cancelo la apertura.

A trav$$HEX1$$e900$$ENDHEX$$s de las siguientes variables de instancia tambien se puede definir el
comportamiento de la funci$$HEX1$$f300$$ENDHEX$$n. Entre parentesis est$$HEX2$$e1002000$$ENDHEX$$el comportamiento por
defecto.

ib_nochangedir (true) -> Se restaura el directorio actual en el caso de que el
        usuario lo cambie al buscar el archivo.
ib_pathmustexist (true) -> Se exige que la ruta del archivo especificado exista.
ib_filemustexist (true) -> Se exige que el archivo especificado exista.
ib_allowmultiselect (false) -> Poder seleccionar m$$HEX1$$e100$$ENDHEX$$s de un archivo.
ib_nodereferencelinks (false) -> Al seleccionar un archivo .lnk no se devuelve el
        destino al que apunta.
ib_dontaddtorecent (false) -> No a$$HEX1$$f100$$ENDHEX$$adir a la lista de archivos recientes. (S$$HEX1$$f300$$ENDHEX$$lo a
        partir de W2K/XP)
ib_forceshowhidden (false) -> Fuerza a que se muestren los archivos ocultos y de
        sistema. (S$$HEX1$$f300$$ENDHEX$$lo a partir de W2K/XP)
is_initialdir ("") -> Directorio en el que se inicia la apertura de archivos. Si
        se omite se usar$$HEX2$$e1002000$$ENDHEX$$el directorio actual.

is_selectedfiles -> En este array se devuelve la lista de los nombres de los
        archivos seleccionados si ib_allowmultiselect es true.

*/

st_openfilename ofn
blob{10000} buff_filter
blob{40000} buff_file
blob{1000} buff_filetitle
string array_filtro[]
n_cst_string lnv_string
string arc, archivos[]
long i, pos

ofn.lStructSize = 76 //Tama$$HEX1$$f100$$ENDHEX$$o de st_openfilename (no contamos los 3 ultimos campos a$$HEX1$$f100$$ENDHEX$$adidos a apartir de win 2000 porque no los vamos a usar)
ofn.hwndOwner = 0
ofn.hInstance = 0

lnv_string.of_ParseToArray(filtro, ',', array_filtro)
pos = 1
for i = 1 to UpperBound(array_filtro)
        pos = BlobEdit(buff_filter, pos, array_filtro[i],EncodingANSI!)
next
BlobEdit(buff_filter, pos, "",EncodingANSI!)
ofn.lpstrFilter = buff_filter


SetNull(ofn.lpstrCustomFilter)
ofn.nMaxCustFilter = 0
ofn.nFilterIndex = 0

BlobEdit(buff_file, 1, archivo,EncodingANSI!)
ofn.lpstrFile = buff_file
ofn.nMaxFile = 40000

ofn.lpstrFileTitle = buff_filetitle
ofn.nMaxFileTitle = 1000

if is_initialdir = "" then
        SetNull(ofn.lpstrInitialDir)
else
        ofn.lpstrInitialDir = is_initialdir
end if

ofn.lpstrTitle = title

ofn.Flags = OFN_EXPLORER + OFN_HIDEREADONLY
if ib_nochangedir then ofn.Flags += OFN_NOCHANGEDIR
if ib_pathmustexist then ofn.Flags += OFN_PATHMUSTEXIST
if ib_filemustexist then ofn.Flags += OFN_FILEMUSTEXIST
if ib_allowmultiselect then ofn.Flags += OFN_ALLOWMULTISELECT
if ib_nodereferencelinks then ofn.Flags += OFN_NODEREFERENCELINKS
if ib_dontaddtorecent then ofn.Flags += OFN_DONTADDTORECENT
if ib_forceshowhidden then ofn.Flags += OFN_FORCESHOWHIDDEN


ofn.nFileOffset = 0 
ofn.nFileExtension = 0

if extension = "" then
        SetNull(ofn.lpstrDefExt)
else
        ofn.lpstrDefExt = extension
end if

ofn.lCustData = 0
ofn.lpfnHook = 0
SetNull(ofn.lpTemplateName)
ofn.pvReserved = 0
ofn.dwReserved = 0
ofn.FlagsEx = 0

if not GetOpenFileName(ofn) then return 0

//ruta = FromAnsi(BlobMid(ofn.lpstrFile, 1))
ruta = String(BlobMid(ofn.lpstrFile, 1),EncodingANSI!)
ruta = left(ruta, ofn.nFileOffset)
if right(ruta,1) <> "\" then ruta += "\"

if ib_allowmultiselect then
        archivo = ""
        i = 1
        pos = ofn.nFileOffset + 1
        do
                //arc = FromAnsi(BlobMid(ofn.lpstrFile, pos))
					 arc = String(BlobMid(ofn.lpstrFile, pos),EncodingANSI!)
                if arc <> "" then
                        archivos[i] = arc
                        pos += len(arc) + 1
                        i = i + 1
                end if
        loop while arc <> ""
        is_selectedfiles = archivos
else
        archivo = string(ofn.lpstrFileTitle,EncodingANSI!)
end if

return 1
end function

on n_file_dialogs.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_file_dialogs.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

