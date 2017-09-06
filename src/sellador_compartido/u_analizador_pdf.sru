HA$PBExportHeader$u_analizador_pdf.sru
forward
global type u_analizador_pdf from nonvisualobject
end type
end forward

shared variables

end variables

global type u_analizador_pdf from nonvisualobject
end type
global u_analizador_pdf u_analizador_pdf

type prototypes
Function integer IDocPageRotate(UnsignedLong handle) library "pdprep32.dll"
Function unsignedlong IDocOpen(ref string fichero,ref long herror) library "pdprep32.dll" alias for "IDocOpen;Ansi"
Function unsignedlong PDocGetInputHandle(unsignedlong handle) library "pdprep32.dll"
Function unsignedlong PDocNew(string nombre_fichero, long ancho,long alto,ref long herror) library "pdprep32.dll" alias for "PDocNew;Ansi"
subroutine PDocInputOpen(unsignedlong handle,ref string fichero) library "pdprep32.dll" alias for "PDocInputOpen;Ansi"
subroutine IDocPageBox(unsignedlong fichero,ref real x,ref real y,ref real ancho,ref real alto) library "pdprep32.dll"
subroutine IDocMediaBox(unsignedlong fichero,  ref real x,  ref real y, ref real ancho,  ref real alto) library "pdprep32.dll"
subroutine IDocAcquirePage(unsignedlong fichero,  long pagina ) library "pdprep32.dll"
subroutine IDocClose(unsignedlong fichero) library "pdprep32.dll"
subroutine PDocSetInputRotate(unsignedlong fichero,integer rotacion) library "pdprep32.dll" //alias for '_PDocSetInputRotate@8'
subroutine PDocPageRotate(unsignedlong fichero,integer rotacion) library "pdprep32.dll" 
subroutine PDocInputCopyAll(unsignedlong handle) library "pdprep32.dll"
//subroutine PDocClearInputRotate(unsignedlong fichero) library "pdprep32.dll"

Function integer IDocNumPages(UnsignedLong nombre_fichero) library "pdprep32.dll"
end prototypes

type variables
double i_ancho,i_alto,i_margen_h,i_margen_v // Todos estos valores deben estar en cm
double i_xo,i_yo,i_volteo  //Coordenadas de retorno
end variables

forward prototypes
public function integer f_numero_paginas (string fichero)
public function integer f_voltea_fichero (string fichero_entrada, string fichero_salida, integer rotacion)
public function long f_ancho_pagina (string fichero)
public function double f_calcula_rotacion (string fichero)
public function double f_puntos_a_cm (double puntos)
public function double f_cm_a_puntos (decimal cm)
public subroutine f_limites_pagina (string fichero, ref double xmin, ref double ymin, ref double xmax, ref double ymax)
public function long f_alto_pagina (string fichero)
public function integer f_coordenadas (string fichero, string posicion)
end prototypes

public function integer f_numero_paginas (string fichero);unsignedlong hand
long h_error 
integer n_pag=0

hand = IDocOpen(fichero,h_error)
n_pag = IDocNumPages(hand)


IDocClose(hand)
return n_pag


end function

public function integer f_voltea_fichero (string fichero_entrada, string fichero_salida, integer rotacion);//****************************************
// Funci$$HEX1$$f300$$ENDHEX$$n  : f_calcula_rotacion( string fichero)
// Entrada  : Ruta completa del fichero en formato pdf
// Salida   : $$HEX1$$c100$$ENDHEX$$ngulo de Rotaci$$HEX1$$f300$$ENDHEX$$n del documento pdf (en grados)

//
//unsignedlong hand_entrada,hand_salida
//long h_error,ancho
//integer rota
//
//
//hand_salida = f_crea_fichero(fichero_salida,0,0)//Creamos el fichero de salida
//PDocInputOpen(hand_salida,fichero_entrada)
//PDocSetInputRotate(hand_salida,rotacion)			//Rotamos el documento
//PDocInputCopyAll(hand_salida)
////rota = IDocPageRotate(hand_salida)
////messagebox('rota',rota)
//IDocClose(hand_salida)							//CERRAMOS el documento
//return 1

//Parametros iniciales
int retorno

n_runandwait runandwait
runandwait = create n_runandwait
runandwait.of_SetPriority(runandwait.HIGH_PRIORITY_CLASS)
runandwait.of_SetCurrentDirectory(g_dir_aplicacion)
runandwait.of_SetWindow("minimize")

retorno = runandwait.of_runandwait('Pdfrotator.exe "' + fichero_entrada + '" "' + fichero_salida + '" ' + string(rotacion))

return retorno
end function

public function long f_ancho_pagina (string fichero);//************ ESTA FUNCION ESTA OBSOLETA *******************//
//**** CON EL NUEVO SELLADOR SE EMPLEA f_limites_pagina  ****//





//****************************************
// Funci$$HEX1$$f300$$ENDHEX$$n  : f_ancho_pagina( string fichero)
// Entrada  : Ruta completa del fichero en formato pdf
// Salida   : Ancho de la primera p$$HEX1$$e100$$ENDHEX$$gina en formato pdf

//integer rotacion
//unsignedlong hand
//long h_error,n_pag
//real x,y,ancho,alto
//
//hand = IDocOpen(fichero,h_error)
//IDocAcquirePage(hand, 1)
//IDocPageBox(hand,x,y,ancho,alto)
//
//IDocClose(hand)							//CERRAMOS el documento
//return ancho
//

double tamano[]
oleobject obj
obj = create oleobject
obj.ConnectToNewObject("XpdfWrapper.XpdfWrapperControl")

if fileExists(fichero) then
	tamano = obj.getpdfsize(fichero)
else
//	messagebox(g_titulo,'Imposible encontrar el fichero')
	tamano[1] = 0
end if

destroy obj

return tamano[1]
end function

public function double f_calcula_rotacion (string fichero);//****************************************
// Funci$$HEX1$$f300$$ENDHEX$$n  : f_calcula_rotacion( string fichero)
// Entrada  : Ruta completa del fichero en formato pdf
// Salida   : $$HEX1$$c100$$ENDHEX$$ngulo de Rotaci$$HEX1$$f300$$ENDHEX$$n del documento pdf (en grados)


//integer rotacion
//unsignedlong hand
//long h_error,n_pag
//
//hand = IDocOpen(fichero,h_error)		//Abrimos el Documento 
//IDocAcquirePage(hand, 1)				//Nos situamos en la primera p$$HEX1$$e100$$ENDHEX$$gina
//rotacion = IDocPageRotate(hand)		//Comprobamos su rotaci$$HEX1$$f300$$ENDHEX$$n
//
//
//IDocClose(hand)							//CERRAMOS el documento
//return rotacion

double rotacion
oleobject obj
obj = create oleobject
obj.ConnectToNewObject("XpdfWrapper.XpdfWrapperControl")


if fileExists(fichero) then
	rotacion = obj.getpdfrotation(fichero)
else
//	messagebox(g_titulo,'Imposible encontrar el fichero')
	rotacion = 0
end if

destroy obj

return rotacion





end function

public function double f_puntos_a_cm (double puntos);// Transforma puntos (medida del signerPDF que equivale 1 pulgada / 72) en centimetros
return puntos / 72.0 * 2.54

end function

public function double f_cm_a_puntos (decimal cm);// Transforma centimetros en puntos (medida del signerPDF que equivale 1 pulgada / 72)
return cm * 72.0 / 2.54

end function

public subroutine f_limites_pagina (string fichero, ref double xmin, ref double ymin, ref double xmax, ref double ymax);// Devuelve el tama$$HEX1$$f100$$ENDHEX$$o de p$$HEX1$$e100$$ENDHEX$$gina de un PDF en cm.

double tamano[]
n_oo_captura_errores obj

obj = create n_oo_captura_errores
obj.ConnectToNewObject("XpdfWrapper.XpdfWrapperControl")
obj.of_capturar_errores(true)

tamano = obj.getpdfbounds(fichero)

if obj.i_resultcode <> 0 then
	// Ha habido algon error al analizar el PDF
	setnull(xmin)
	setnull(ymin)
	setnull(xmax)
	setnull(ymax)
else
	xmin = f_puntos_a_cm(tamano[1])
	ymin = f_puntos_a_cm(tamano[2])
	xmax = f_puntos_a_cm(tamano[3])
	ymax = f_puntos_a_cm(tamano[4])
end if

destroy obj

end subroutine

public function long f_alto_pagina (string fichero);//************ ESTA FUNCION ESTA OBSOLETA *******************//
//**** CON EL NUEVO SELLADOR SE EMPLEA f_limites_pagina  ****//





//****************************************
// Funci$$HEX1$$f300$$ENDHEX$$n  : f_ancho_pagina( string fichero)
// Entrada  : Ruta completa del fichero en formato pdf
// Salida   : Ancho de la primera p$$HEX1$$e100$$ENDHEX$$gina en formato pdf
//
//integer rotacion
//unsignedlong hand
//long h_error,n_pag
//real x,y,ancho,alto
//
//hand = IDocOpen(fichero,h_error)
//IDocAcquirePage(hand, 1)
//IDocPageBox(hand,x,y,ancho,alto)
//
//IDocClose(hand)							//CERRAMOS el documento
//return alto

double tamano[]
oleobject obj
obj = create oleobject
obj.ConnectToNewObject("XpdfWrapper.XpdfWrapperControl")

if fileExists(fichero) then
	tamano = obj.getpdfsize(fichero)
else
//	messagebox(g_titulo,'Imposible encontrar el fichero')
	tamano[2] = 0
end if

destroy obj

return tamano[2]
end function

public function integer f_coordenadas (string fichero, string posicion);// Est$$HEX2$$e1002000$$ENDHEX$$funci$$HEX1$$f300$$ENDHEX$$n calcula las coordenadas iniciales (i_xo, i_yo) a partir de donde empezaremos
// a colocar el sello. Para calcularlo tiene en cuenta :
//		- El tama$$HEX1$$f100$$ENDHEX$$o del fichero pdf
//		- El tama$$HEX1$$f100$$ENDHEX$$o del sello : ancho, alto
//		- La posici$$HEX1$$f300$$ENDHEX$$n donde queramos colocar el sello {Sup. Izq.| Sup. Der. | Inf. Izq. | Inf. Der. | Libre}
//		 		si la posicion es libre (i_xo = x , i_yo = y)
// 	- Los margenes Vertical y Horizontal : margen_v, margen_h
// 	- Si se ha rotado el sello y/o el documento

// Retorno(Entero) : -1: No se han calculado la coordenadas inicialies de estampado del sello
//							 1: coordenadas calculadas correctamente

int rotacion
double xmin,ymin,xmax,ymax,aux,rotacion_doc
int retorno = 1
double ret[]
 

// Obtenemos la posici$$HEX1$$f300$$ENDHEX$$n de la p$$HEX1$$e100$$ENDHEX$$gina visible
f_limites_pagina( fichero, xmin, ymin, xmax, ymax )
//messagebox('','xmin = '+string(xmin)+' ymin = '+string(ymin)+' xmax = '+string(xmax)+' ymax = '+string(ymax))
// Rotacion 
rotacion_doc = f_calcula_rotacion(fichero)


// Rotacion = Cociente de la division
rotacion_doc = Mod(rotacion_doc,180)

if rotacion_doc > 0 then // REVISAR: ESTO NO VALE SI EL PDF ESTA RECORTADO Y ROTADO
	aux = xmax
	xmax = ymax
	ymax = aux
	aux = xmin
	xmin = ymin
	ymin = aux
end if

if mod(i_volteo,180)>0 then // REVISAR: ESTO NO VALE SI EL PDF ESTA RECORTADO Y ROTADO
	aux = xmax
	xmax = ymax
	ymax = aux
	aux = xmin
	xmin = ymin
	ymin = aux
end if


// posicion = {SI,SD,II, ID, L}
// vemos si la 2$$HEX2$$ba002000$$ENDHEX$$letra de posicion es Izq o Der 
CHOOSE CASE RightA(posicion,1)
	CASE "D" //Izquierda
		//i_xo = (xmax - xmin) - (i_margen_v + i_ancho) // Comentado por Eloy 7/4/06
		i_xo = xmax - (i_margen_v + i_ancho)
	CASE "I" //Derecha
		i_xo = xmin + i_margen_v
END CHOOSE
 
 // vemos si la 1$$HEX2$$ba002000$$ENDHEX$$letra de posicion es Arriba o Abajo
CHOOSE CASE LeftA(posicion,1)
	CASE "S"   //Superior
		i_yo = ymax - (i_margen_h +  i_alto)
	CASE "I"  //Inferior
		i_yo = ymin + i_margen_h
END CHOOSE

if isnull(i_xo) or isnull(i_yo) then retorno = -1

//messagebox('Coordenadas','x: ' + string(i_xo) + '  y: ' + string(i_yo))
return retorno


end function

on u_analizador_pdf.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_analizador_pdf.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;double i_x,i_y
end event

