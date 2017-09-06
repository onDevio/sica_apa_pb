HA$PBExportHeader$w_visared_observaciones.srw
forward
global type w_visared_observaciones from w_response
end type
type mle_observaciones from multilineedit within w_visared_observaciones
end type
type cb_1 from commandbutton within w_visared_observaciones
end type
type cb_2 from commandbutton within w_visared_observaciones
end type
end forward

global type w_visared_observaciones from w_response
integer height = 1488
string title = "Observaciones"
mle_observaciones mle_observaciones
cb_1 cb_1
cb_2 cb_2
end type
global w_visared_observaciones w_visared_observaciones

type variables
string fichero_zip
end variables

forward prototypes
public function string wf_leer_fichero (string ruta, string seccion)
end prototypes

public function string wf_leer_fichero (string ruta, string seccion);/* Devuelve el contenido de un archivo de texto. Si el archivo esta dividido en secciones
de tipo INI [nombre_seccion] y se especifica un nombre de secci$$HEX1$$f300$$ENDHEX$$n se devolver$$HEX2$$e1002000$$ENDHEX$$s$$HEX1$$f300$$ENDHEX$$lo el
contenido de esa secci$$HEX1$$f300$$ENDHEX$$n.
En caso de error devuelve nulo.
*/

integer file_num,num_filas
string linea
boolean leer
string texto


file_num = FileOpen(ruta, LineMode!, Read!)
if file_num<0 then
	setnull(texto)
	return texto
end if


texto = ""

if f_es_vacio(seccion) then
	
	do while FileRead(file_num,linea) >= 0
		texto += linea+ cr
	loop
	
else
	
	leer = false
	do while FileRead(file_num,linea) >= 0
		if LeftA(trim(linea), 1) = "[" and RightA(trim(linea), 1) = "]" then
			if leer then exit
			leer = trim(linea) = "[" + seccion + "]"
		elseif leer then
			num_filas++
			texto += linea +cr
			if num_filas=1 then texto=mid(texto,pos(texto,'=')+1)
		end if
	loop
	
end if

FileClose(file_num)

return texto

end function

on w_visared_observaciones.create
int iCurrent
call super::create
this.mle_observaciones=create mle_observaciones
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_observaciones
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_visared_observaciones.destroy
call super::destroy
destroy(this.mle_observaciones)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;fichero_zip=Message.StringParm
//mle_observaciones.text=ProfileString(g_directorio_temporal+'observaciones.txt','OBSERVACIONES','texto','')
mle_observaciones.text=wf_leer_fichero(g_directorio_temporal+'observaciones.txt','OBSERVACIONES')


end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_visared_observaciones
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_visared_observaciones
end type

type mle_observaciones from multilineedit within w_visared_observaciones
integer x = 27
integer y = 28
integer width = 2414
integer height = 1164
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_visared_observaciones
integer x = 709
integer y = 1240
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
end type

event clicked;integer li_FileNum,retorno
n_oo_captura_errores zip
oleobject oFile,Files

zip=create n_oo_captura_errores

li_FileNum = FileOpen(g_directorio_temporal+'observaciones.txt',LineMode!,Write!,LockReadWrite!,Replace!)
FileClose(li_FileNum)


SetProfileString(g_directorio_temporal+'observaciones.txt','OBSERVACIONES','texto',mle_observaciones.text)

retorno = zip.ConnectToNewObject("SAWZip.Archive")
if retorno < 0 then
	Messagebox(g_titulo, "No se puede acceder a la librer$$HEX1$$ed00$$ENDHEX$$a de manipulaci$$HEX1$$f300$$ENDHEX$$n de zips (SAWZip). Deber$$HEX2$$e1002000$$ENDHEX$$reinstalar la aplicaci$$HEX1$$f300$$ENDHEX$$n.")
	return
end if	

zip.of_capturar_errores(true) // Evita que la aplicaci$$HEX1$$f300$$ENDHEX$$n pete si el zip est$$HEX2$$e1002000$$ENDHEX$$corrupto
f_bloqueo_fichero(fichero_zip,false)
zip.Open(fichero_zip) 
if zip.i_resultcode <> 0 then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Error al abrir el zip. Es posible que el archivo est$$HEX2$$e9002000$$ENDHEX$$da$$HEX1$$f100$$ENDHEX$$ado.")
	return
end if

zip.of_capturar_errores(false)	


//A$$HEX1$$f100$$ENDHEX$$adimos el fichero
Files = create oleobject
Files.ConnectToNewObject("SAWZip.Files")
Files = zip.Files

oFile = create oleobject
oFile.ConnectToNewObject("SAWZip.File")	
oFile.Name = g_directorio_temporal+'observaciones.txt'
Files.Add(oFile)
zip.close()

destroy zip
f_bloqueo_fichero(fichero_zip,true)

Close(parent)
end event

type cb_2 from commandbutton within w_visared_observaciones
integer x = 1189
integer y = 1240
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
end type

event clicked;	
Close(parent)
end event

