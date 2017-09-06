HA$PBExportHeader$n_escritor_pdf.sru
forward
global type n_escritor_pdf from nonvisualobject
end type
end forward

global type n_escritor_pdf from nonvisualobject
end type
global n_escritor_pdf n_escritor_pdf

type prototypes

end prototypes

type variables
public:
//Tama$$HEX1$$f100$$ENDHEX$$o del sello (en cm)
double i_ancho
double i_alto 

//Posici$$HEX1$$f300$$ENDHEX$$n del sello, con 4 valores posibles :
// Top      = Arriba
// Bottom   = Abajo
// VCenter  = Centro
// Angle    = Con angulo --> No contemplado
string i_posicion = ""

//Ruta completa del fichero pdf al que vamos a estampar el sello
string i_fichero_pdf
string i_fichero_pdf_salida

double i_xo, i_yo

private:

//Coordenadas de inicio del sello
//Todas las lienas de Texto a insertar en el sello tendran posiciones relativas 
//a estas coordenadas, instanciadas con el primer Stamp-Item
double i_dx = 0.25, i_dy = 0.25
string i_justificacion = ""
string i_pos_xo, i_pos_yo

// Define el Area para estampar un "Stamp-Item" del Sello 
// Si el Sello se situa Horizontal con el Documento --> cambia el Top, relativa a i_yo.
// Sino, (hay ROTACION del Sello) y cambia Izq, relativa a i_xo
double i_lim_der, i_lim_izq, i_lim_sup, i_lim_inf 
integer i_ini = 1, i_fin = -1, i_incremento = 1

// Margenes del Documento pdf
double i_msup
double i_minf
double i_mder
double i_mizq

// N$$HEX2$$ba002000$$ENDHEX$$de Items-Stamps en el sello
integer i_nstamp = 1

// Fichero donde se escriben los "Stamps-Items" para generar el Sello
integer i_fichero_sello
string i_nombre_sello

// Rotacion del Sello = {0, 90, 180, ... GRADOS}
// me da la posicion que deben de tener los Items-Stamps
string  i_rotacion
integer i_rotacion_doc

// Margen_v, Margen_h
double i_margen_v = 0 
double i_margen_h = 0


end variables

forward prototypes
public function integer f_inserta_rectangulo (double x, double y, integer rotacion, string imagen, double alto, double ancho)
public subroutine f_margenes (string version, double m_superior, double m_inferior, double m_izq, double m_der)
public function double f_puntos_a_cm (integer puntos)
public function integer f_inserta_linea (double x, double y, integer rotacion, string imagen, double escala, string justificacion)
public function integer f_inserta_texto (double x, double y, integer rotacion, string texto, integer tamanyo, integer r, integer g, integer b, string fuente, string justificacion)
public function integer f_inserta_simbolo (double x, double y, integer rotacion, integer grosor, integer longitud, integer r, integer g, integer b, string caracter, string fuente, string justificacion)
public function integer f_inserta_imagen (double x, double y, integer rotacion, string imagen, double escala, string justificacion)
public function string f_cm_a_puntos (double cm)
public function integer f_calculo_coordenadas_iniciales (string posicion, double ancho, double alto, double margen_v, double margen_h, double x, double y, string rotacion_sello)
public function integer f_abrir_fichero_sello (string fichero_pdf)
public function integer f_estampa_sello ()
public function integer f_estampa_sello_nt ()
end prototypes

public function integer f_inserta_rectangulo (double x, double y, integer rotacion, string imagen, double alto, double ancho);

if rotacion = 0 then // Sin el sello no tiene rotacion
 f_inserta_linea(x, y,   0, imagen, ancho, "Left")
 f_inserta_linea(x, y, 270, imagen,  alto, "Left")

 f_inserta_linea(x,  abs(y - i_alto),   0, imagen, ancho, "Left")
 f_inserta_linea(x + i_ancho, y, 270, imagen,  alto, "Left")
else
 f_inserta_linea(x, y,   0, imagen, ancho, "Left")
 f_inserta_linea(x, y,  90, imagen,  alto, "Left")

 f_inserta_linea(x,  y + i_alto,  0, imagen, ancho, "Left")
 f_inserta_linea(x + i_ancho, y, 90, imagen,  alto, "Left")	
end if

return 1
end function

public subroutine f_margenes (string version, double m_superior, double m_inferior, double m_izq, double m_der);// Opciones de Bloque:
// especifica los Margenes superior, inferior, derecho e izquierdo sobre los que 
// se pondr$$HEX2$$e1002000$$ENDHEX$$el stamp en el documento asi como la version del StampPdf

string msup, minf, mizq, mder
integer p

// Guardamos los margenes
i_msup = m_superior
i_minf = m_inferior
i_mizq = m_izq
i_mder = m_der

msup = f_cm_a_puntos(i_msup)
if msup <> "0" then
 p = PosA(msup, ",") - 1
 msup = LeftA(msup,p)
end if

minf =f_cm_a_puntos(i_minf)
if minf <> "0" then
 p = PosA(minf, ",") - 1
 minf = LeftA(minf,p)
end if

mizq = f_cm_a_puntos(i_mizq)
if mizq <> "0" then
 p = PosA(mizq, ",") - 1
 mizq = LeftA(mizq,p)
end if

mder = f_cm_a_puntos(i_mder)
if mder <> "0" then
 p = PosA(mder, ",") - 1
 mder = LeftA(mder,p)
end if

//Options del fichero txt
fileWrite(i_fichero_sello, "#--Options--")
fileWrite(i_fichero_sello, "Begin_Options")
fileWrite(i_fichero_sello, "Version~t("+version+")")
fileWrite(i_fichero_sello, "TopMargin~t("+msup+")")
fileWrite(i_fichero_sello, "BottomMargin~t("+minf+")")
fileWrite(i_fichero_sello, "LeftMargin~t("+mizq+")")
fileWrite(i_fichero_sello, "RightMargin~t("+mder+")")
fileWrite(i_fichero_sello, "End_Options")
end subroutine

public function double f_puntos_a_cm (integer puntos);// f_puntos_cm(Entero) 
// Retorno(Double)
//
// Funcionalidad: Pasa puntos (medida del StampPdf) a centimetros.

return ((puntos*2.54001)/72)
end function

public function integer f_inserta_linea (double x, double y, integer rotacion, string imagen, double escala, string justificacion);// Entrada:
//  x: posicion relativa al punto i_xo. 
//  y: posicion relativa al punto i_yo. Si el sello esta rotado se resta a dicha i_yo
//  rotacion: si/no. dice si la imagen esta rotada
//  imagen: nombre de la imagen con extension y sin ruta
//  escala: 1 = 100%, 2 = 200%
//  juntificacion: posiciones de la imagen dentro de su area de estampado en ingles (Left, Right, Center)

// Salida:
//  * Genera un Item-Stamp de tipo imagen.
//  * Estampa una imagen en un punto relativo al area del sello
//  	en el documento a estampar y abierto previamente.



//Pasar los argumentos Color, tipo de letra, ...
string Bottom, Izq
integer p



fileWrite(i_fichero_sello, "#--Stamp Item--")
fileWrite(i_fichero_sello, "Begin_Message")
fileWrite(i_fichero_sello, "Name~t(Linea"+string(i_nstamp)+")")
i_nstamp = i_nstamp + 1;

//Todos los Items-Stamps se pondran en la hojas donde se indique en la funcion 
//de inicializacion o por defecto se estampa en todas las hojas del Documento
fileWrite(i_fichero_sello, "startPage~t("+string(i_ini)+")")
fileWrite(i_fichero_sello, "EndPage~t("+string(i_fin)+")")
fileWrite(i_fichero_sello, "PageIncrement~t("+string(i_incremento)+")")

// Tipo del Item-Stamp y Tamanyo de la fuente
fileWrite(i_fichero_sello, "Type~t(Image)")
fileWrite(i_fichero_sello, "Path~t("+imagen+")")
// Subrayado
fileWrite(i_fichero_sello, "Underlay~t(no)")
// 1 = 100%, 2 = 200%
fileWrite(i_fichero_sello, "Scale~t("+string(escala)+")")

// La linea es en Horizontal (Sin rotacion por defecto)
if rotacion = 0 then
 	
 Bottom = f_cm_a_puntos(i_yo - y)
 if Bottom <> "0" then
  p = PosA(Bottom, ",") - 1
  Bottom = LeftA(Bottom,p) 
 end if

 Izq = f_cm_a_puntos(i_xo + x)
 if Izq <> "0" then
  p = PosA(Izq, ",") - 1
  Izq = LeftA(Izq,p) 
 end if 
 
else
	
 Bottom = f_cm_a_puntos(i_yo + y)
 if Bottom <> "0" then
  p = PosA(Bottom, ",") - 1
  Bottom = LeftA(Bottom,p) 
 end if

 Izq = f_cm_a_puntos(i_xo + x)
 if Izq <> "0" then
  p = PosA(Izq, ",") - 1
  Izq = LeftA(Izq,p) 
 end if 

 fileWrite(i_fichero_sello, "Position~t(Angle)")
 fileWrite(i_fichero_sello, "Angle~t("+string(rotacion)+")")
end if



fileWrite(i_fichero_sello, "Bottom~t("+Bottom+")")
fileWrite(i_fichero_sello, "Left~t("+Izq+")")

// Justificaci$$HEX1$$f300$$ENDHEX$$n: {Left, Right, Center}
fileWrite(i_fichero_sello, "Justification~t("+justificacion+")")

// Fin
fileWrite(i_fichero_sello, "End_Message")


return 1
end function

public function integer f_inserta_texto (double x, double y, integer rotacion, string texto, integer tamanyo, integer r, integer g, integer b, string fuente, string justificacion);// Entrada:
//  x: posicion relativa al punto i_xo. 
//  y: posicion relativa al punto i_yo. Si el sello esta rotado se resta a dicha i_yo
//  rotacion: si/no. dice si la imagen esta rotada
//  texto: texto a insertar en el sello
//  tamanyo: de la fuente
//  r,g,b : enteros para generar un color
//  fuente: nombre de la fuente con extension y sin ruta
//  juntificacion: posiciones de la imagen dentro de su area de estampado en ingles (Left, Right, Center)

// Salida:
//  * Genera un Item-Stamp de tipo texto.
//  * Estampa un texto en un punto relativo al area del sello
//  	en el documento a estampar y abierto previamente.



//Pasar los argumentos Color, tipo de letra, ...
string Top, Bottom, Izq, right
integer p

if not f_es_vacio(texto) then


fileWrite(i_fichero_sello, "#--Stamp Item--")
fileWrite(i_fichero_sello, "Begin_Message")
fileWrite(i_fichero_sello, "Name~t(Text"+string(i_nstamp)+")")
i_nstamp = i_nstamp + 1;

//Todos los Items-Stamps se pondran en la hojas donde se indique en la funcion 
//de inicializacion o por defecto se estampa en todas las hojas del Documento
fileWrite(i_fichero_sello, "startPage~t("+string(i_ini)+")")
fileWrite(i_fichero_sello, "EndPage~t("+string(i_fin)+")")
fileWrite(i_fichero_sello, "PageIncrement~t("+string(i_incremento)+")")

// Tipo del Item-Stamp y Tamanyo de la fuente
fileWrite(i_fichero_sello, "Type~t(Text)")
fileWrite(i_fichero_sello, "Size~t("+string(tamanyo)+")")

// Opciones del Color del texto
fileWrite(i_fichero_sello, "ColorSpace~t(DeviceRGB)")
fileWrite(i_fichero_sello, "Red~t("+string(r)+")")
fileWrite(i_fichero_sello, "Green~t("+string(g)+")")
fileWrite(i_fichero_sello, "Blue~t("+string(b)+")")

// Opciones de la fuente 
fileWrite(i_fichero_sello, "Font~t("+fuente+")")
fileWrite(i_fichero_sello, "FontFile~t("+g_directorio_fuentes + fuente+".pfb)")

// Texto a mostrar
fileWrite(i_fichero_sello, "Text~t("+texto+")")


 Bottom = f_cm_a_puntos(i_yo + y)
 if Bottom <> "0" then
  p = PosA(Bottom, ",") - 1
  Bottom = LeftA(Bottom,p) 
 end if

 Izq = f_cm_a_puntos(i_xo + x)
 if Izq <> "0" then
  p = PosA(Izq, ",") - 1
  Izq = LeftA(Izq,p) 
 end if 

 fileWrite(i_fichero_sello, "Position~t(Angle)")
 fileWrite(i_fichero_sello, "Angle~t("+string(rotacion)+")")

 fileWrite(i_fichero_sello, "Bottom~t("+Bottom+")")
 fileWrite(i_fichero_sello, "Left~t("+Izq+")")

// Justificaci$$HEX1$$f300$$ENDHEX$$n: {Left, Right, Center}
fileWrite(i_fichero_sello, "Justification~t("+justificacion+")")

// Subrayado
fileWrite(i_fichero_sello, "Underlay~t(no)")
fileWrite(i_fichero_sello, "End_Message")

end if

return 1
end function

public function integer f_inserta_simbolo (double x, double y, integer rotacion, integer grosor, integer longitud, integer r, integer g, integer b, string caracter, string fuente, string justificacion);//Esta funcion tiene como entradas: posicion(x,y) para la serie de caracteres dentro del sello,
//rotaci$$HEX1$$f300$$ENDHEX$$n(0 o 90), grosor(1,2,3,4...), longitud aproximada(en cm), color,
//caracter(que es el caracter del cual queremos hacer la serie) y justificacion.
//Y nos imprime una linea formada por una repeticion del caracter deseado

//Pasar los argumentos Color, tipo de letra, ...
string Top, Bottom, Izq, right
integer p

integer i,numcar,tamfuente,ajuste
string cadena
double factor

//ajuste = 30

//ahora creamos la cadena de caracteres

if f_es_vacio(caracter) then caracter = ''

tamfuente = grosor * 10
factor = tamfuente * 0.0175
numcar = integer(longitud/factor)

cadena = ''
for i=1 to numcar
	cadena = cadena + caracter
next


fileWrite(i_fichero_sello, "#--Stamp Item--")
fileWrite(i_fichero_sello, "Begin_Message")
fileWrite(i_fichero_sello, "Name~t(Text"+string(i_nstamp)+")")
i_nstamp = i_nstamp + 1;

//Todos los Items-Stamps se pondran en la hojas donde se indique en la funcion 
//de inicializacion o por defecto se estampa en todas las hojas del Documento
fileWrite(i_fichero_sello, "startPage~t("+string(i_ini)+")")
fileWrite(i_fichero_sello, "EndPage~t("+string(i_fin)+")")
fileWrite(i_fichero_sello, "PageIncrement~t("+string(i_incremento)+")")

// Tipo del Item-Stamp y Tamanyo de la fuente
fileWrite(i_fichero_sello, "Type~t(Text)")
fileWrite(i_fichero_sello, "Size~t("+string(tamfuente)+")")

// Opciones del Color del texto
fileWrite(i_fichero_sello, "ColorSpace~t(DeviceRGB)")
fileWrite(i_fichero_sello, "Red~t("+string(r)+")")
fileWrite(i_fichero_sello, "Green~t("+string(g)+")")
fileWrite(i_fichero_sello, "Blue~t("+string(b)+")")

// Opciones de la fuente 
fileWrite(i_fichero_sello, "Font~t("+fuente+")")
fileWrite(i_fichero_sello, "FontFile~t("+g_directorio_fuentes + fuente+".pfb)")
//fileWrite(i_fichero_sello, "Font~t("+fuente+")")
//fileWrite(i_fichero_sello, "FontFile~t("+g_dir_aplicacion + "\Fuentes" + fuente+".pfb)")

//insertamos la serie de caracteres
fileWrite(i_fichero_sello, "Text~t("+cadena+")")

if rotacion = 0 then
	
 Top = f_cm_a_puntos(i_yo - y)
 if Top <> "0" then
  p = PosA(Top, ",") - 1
  Top = LeftA(Top,p) 
 end if
 	
 Bottom = f_cm_a_puntos(i_yo - (y + i_dy))
 if Bottom <> "0" then
  p = PosA(Bottom, ",") - 1
  Bottom = LeftA(Bottom,p) 
 end if

 Izq = f_cm_a_puntos(i_xo + x)
 if Izq <> "0" then
  p = PosA(Izq, ",") - 1
  Izq = LeftA(Izq,p) 
 end if

 Right = f_cm_a_puntos(i_xo + (x + i_ancho))
 if Right <> "0" then
  p = PosA(Right, ",") - 1
  Right = LeftA(Right,p) 
 end if 
 
 fileWrite(i_fichero_sello, "Top~t("+string(integer(Top)+ajuste)+")") 
 fileWrite(i_fichero_sello, "Bottom~t("+string(integer(Bottom)+ajuste)+")")
 fileWrite(i_fichero_sello, "Left~t("+Izq+")")
 fileWrite(i_fichero_sello, "Right~t("+Right+")")
 
else
	
 Bottom = f_cm_a_puntos(i_yo + y)
 if Bottom <> "0" then
  p = PosA(Bottom, ",") - 1
  Bottom = LeftA(Bottom,p) 
 end if

 Izq = f_cm_a_puntos(i_xo + x)
 if Izq <> "0" then
  p = PosA(Izq, ",") - 1
  Izq = LeftA(Izq,p) 
 end if 

 fileWrite(i_fichero_sello, "Position~t(Angle)")
 fileWrite(i_fichero_sello, "Angle~t("+string(rotacion)+")")
 fileWrite(i_fichero_sello, "Bottom~t("+string(integer(Bottom)+ajuste)+")")
 fileWrite(i_fichero_sello, "Left~t("+Izq+")")

end if

// Justificaci$$HEX1$$f300$$ENDHEX$$n: {Left, Right, Center}
fileWrite(i_fichero_sello, "Justification~t("+justificacion+")")

// Subrayado
fileWrite(i_fichero_sello, "Underlay~t(no)")
fileWrite(i_fichero_sello, "End_Message")

return 1
end function

public function integer f_inserta_imagen (double x, double y, integer rotacion, string imagen, double escala, string justificacion);// NOTA: esta funcion tiene problemas con la insercion de imagenes
// en el documento cuando este tiene rotacion

// Entrada:
//  x: posicion relativa al punto i_xo. 
//  y: posicion relativa al punto i_yo. Si el sello esta rotado se resta a dicha i_yo
//  rotacion: si/no. dice si la imagen esta rotada
//  imagen: nombre de la imagen con extension y sin ruta
//  escala: 1 = 100%, 2 = 200%
//  juntificacion: posiciones de la imagen dentro de su area de estampado en ingles (Left, Right, Center)

// Salida:
//  * Genera un Item-Stamp de tipo imagen.
//  * Estampa una imagen en un punto relativo al area del sello
//  	en el documento a estampar y abierto previamente.


//Pasar los argumentos Color, tipo de letra, ...
string Bottom, Izq, aux, texto_escala
integer p,pos_coma

fileWrite(i_fichero_sello, "#--Stamp Item--")
fileWrite(i_fichero_sello, "Begin_Message")
fileWrite(i_fichero_sello, "Name~t(Imagen"+string(i_nstamp)+")")
i_nstamp = i_nstamp + 1;

//Todos los Items-Stamps se pondran en la hojas donde se indique en la funcion 
//de inicializacion o por defecto se estampa en todas las hojas del Documento
fileWrite(i_fichero_sello, "startPage~t("+string(i_ini)+")")
fileWrite(i_fichero_sello, "EndPage~t("+string(i_fin)+")")
fileWrite(i_fichero_sello, "PageIncrement~t("+string(i_incremento)+")")

// Tipo del Item-Stamp y Tamanyo de la fuente
fileWrite(i_fichero_sello, "Type~t(Image)")
fileWrite(i_fichero_sello, "Path~t("+ g_directorio_imagenes+ imagen + ")")
// Subrayado
fileWrite(i_fichero_sello, "Underlay~t(no)")

// 1 = 100%, 2 = 200%
//este replace se hace por el problema de la coma
texto_escala = string(escala)
pos_coma = PosA(texto_escala,',',1)
if pos_coma >0 then
	texto_escala = ReplaceA(texto_escala,pos_coma, 1, "." )
end if
fileWrite(i_fichero_sello, "Scale~t("+texto_escala+")")

// La linea es en Horizontal (Sin rotacion por defecto)
Izq = f_cm_a_puntos(i_xo + x)
if Izq <> "0" then
 p = PosA(Izq, ",") - 1
 Izq = LeftA(Izq,p) 
end if 	


 Bottom = f_cm_a_puntos(i_yo + y)
 if Bottom <> "0" then
   p = PosA(Bottom, ",") - 1
   Bottom = LeftA(Bottom,p) 
 end if  
 

 fileWrite(i_fichero_sello, "Position~t(Angle)")
 fileWrite(i_fichero_sello, "Angle~t("+string(rotacion)+")") 

//Esto es un parche mientras no arreglen la versi$$HEX1$$f300$$ENDHEX$$n de Stamppdf la panda de Appligent
//if i_rotacion_doc> 0 then
//	aux = izq
//	izq = bottom
//	bottom = aux
//end if

fileWrite(i_fichero_sello, "Bottom~t("+Bottom+")")
fileWrite(i_fichero_sello, "Left~t("+Izq+")")

// Justificaci$$HEX1$$f300$$ENDHEX$$n: {Left, Right, Center}
fileWrite(i_fichero_sello, "Justification~t("+justificacion+")")

// Fin
fileWrite(i_fichero_sello, "End_Message")


return 1

end function

public function string f_cm_a_puntos (double cm);// Retorno(string) : transforma centrimetros en puntos (medida del StampPdf).  

int retorno
retorno = truncate((cm * 720)/ 25.4001,0)
return string(round(retorno,0))+',00'
end function

public function integer f_calculo_coordenadas_iniciales (string posicion, double ancho, double alto, double margen_v, double margen_h, double x, double y, string rotacion_sello);// Est$$HEX2$$e1002000$$ENDHEX$$funci$$HEX1$$f300$$ENDHEX$$n calcula las coordenadas iniciales (i_xo, i_yo) a partir de donde empezaremos
// a colocar el sello. Para calcularlo tiene en cuenta :
//		- El tama$$HEX1$$f100$$ENDHEX$$o del fichero pdf
//		- El tama$$HEX1$$f100$$ENDHEX$$o del sello : ancho, alto
//		- La posici$$HEX1$$f300$$ENDHEX$$n donde queramos colocar el sello {Sup. Izq.| Sup. Der. | Inf. Izq. | Inf. Der. | Libre}
//		 		si la posicion es libre (i_xo = x , i_yo = y)
// 	- Los margenes Vertical y Horizontal : margen_v, margen_h
// 	- Si se ha rotado el sello y/o el documento

// Retorno(Entero) : -1: No se han calculado la coordenadas inicialies de estampado del sello
//							 1: coordenadas calculadas correctamente

u_analizador_pdf inv_analizador_pdf
int rotacion
double ancho_doc,alto_doc,aux
int retorno = 1
double ret[]

// Margen para el sello (margen x = margen y)
i_margen_v = margen_v
i_margen_h = margen_h

// ancho y alto del sello
i_ancho = ancho
i_alto = alto

inv_analizador_pdf = create u_analizador_pdf

// Coordenada X
ancho_doc	   = inv_analizador_pdf.f_ancho_pagina(i_fichero_pdf)
// Coordenada Y
alto_doc		   = inv_analizador_pdf.f_alto_pagina(i_fichero_pdf)
// Rotacion 
i_rotacion_doc = inv_analizador_pdf.f_calcula_rotacion(i_fichero_pdf)

//ret = w_sellador.ole_calculo_pdf.object.getPdfSize(i_fichero_pdf)
//ancho_doc = ret[1]
//alto_doc = ret[2]
//i_rotacion_doc = w_sellador.ole_calculo_pdf.object.getPdfrotation(i_fichero_pdf)

// Rotacion = Cociente de la division
i_rotacion_doc = Mod(i_rotacion_doc,180)

if i_rotacion_doc > 0 then
	aux = ancho_doc
	ancho_doc = alto_doc
	alto_doc = aux
end if

if rotacion_sello = "S" then
 aux = i_ancho
 i_ancho = i_alto
 i_alto = aux
end if

ancho_doc = f_puntos_a_cm(ancho_doc)
alto_doc = f_puntos_a_cm(alto_doc)

// posicion = {SI,SD,II, ID, L}
// vemos si la 2$$HEX2$$ba002000$$ENDHEX$$letra de posicion es Izq o Der 
CHOOSE CASE RightA(posicion,1)
	CASE "D" //Izquierda
		i_xo = ancho_doc - (i_margen_v + i_ancho)	
	CASE "I" //Derecha
		i_xo = i_margen_v
	CASE ELSE //Libre
		i_xo = x
END CHOOSE
 
 // vemos si la 1$$HEX2$$ba002000$$ENDHEX$$letra de posicion es Arriba o Abajo
CHOOSE CASE LeftA(posicion,1)
	CASE "S"   //Superior
		i_yo = alto_doc - (i_margen_h +  i_alto)
	CASE "I"  //Inferior
		i_yo = i_margen_h		
	CASE ELSE  //Libre
		i_yo = y	
END CHOOSE

if isnull(i_xo) or isnull(i_yo) then retorno = -1
destroy inv_analizador_pdf

//messagebox('Coordenadas','x: ' + string(i_xo) + '  y: ' + string(i_yo))
return retorno 
end function

public function integer f_abrir_fichero_sello (string fichero_pdf);//Funci$$HEX1$$f300$$ENDHEX$$n que abre el fichero del sello y almacena su referencia en una
//variable de instancia para que est$$HEX2$$e9002000$$ENDHEX$$visible desde todas las funciones del objeto
//ya que varias funciones escribir$$HEX1$$e100$$ENDHEX$$n en este fichero.

//f_abrir_fichero_sello(fichero_pdf)
// Entrada: fichero a estampar el cu$$HEX1$$f100$$ENDHEX$$o
// 
//Retorno(Entero) :  N$$HEX2$$ba002000$$ENDHEX$$de referencia al fichero reci$$HEX1$$e900$$ENDHEX$$n abierto donde ir poniendo los Items-Stamps
//							-1 Si el fichero no se ha abierto correctamente

//este es el fichero donde se estampa el sello
i_fichero_pdf = fichero_pdf

//Le quitamos la extension al fichero

i_nombre_sello = "sello_" + f_obtener_nombre_sello()

i_fichero_sello = fileopen(i_nombre_sello + ".txt", lineMode!,Write!)

return i_fichero_sello
end function

public function integer f_estampa_sello ();// Funci$$HEX1$$f300$$ENDHEX$$n para Windows 95/98 que estampa el sello que hemos escrito en el fichero sello.txt
// en el fichero pdf que hemos dado como entrada.

//Retorno (entero) : -1 : Error al ejecutar el fichero de ejecuci$$HEX1$$f300$$ENDHEX$$n por lotes
//							 1 : Ejecucion correcta


int li_FileNum
int fichero_bat,retorno = 1
string cadena_cunyo

//Cerramos el fichero txt. Ya que no se va a escribir nada m$$HEX1$$e100$$ENDHEX$$s sobre $$HEX1$$e900$$ENDHEX$$l.
FileClose(i_fichero_sello)

//Construimos la cadena para pasarsela al fichero bat
cadena_cunyo =' "./' + i_nombre_sello + '.txt" ' + '"'+i_fichero_pdf+'"' +''

//Parametros iniciales
n_runandwait runandwait
runandwait = create n_runandwait
runandwait.of_SetPriority(runandwait.HIGH_PRIORITY_CLASS)
runandwait.of_SetCurrentDirectory(g_dir_aplicacion)
runandwait.of_SetWindow("minimize")

retorno = runandwait.of_runandwait("stamppdf.exe -o ~"" + i_fichero_pdf_salida + '"' + cadena_cunyo)

//-----Fin sello
// Borramos los ficheros generados de sello
filedelete(i_nombre_sello + ".txt")
filedelete("log.txt")

return retorno
end function

public function integer f_estampa_sello_nt ();// Funci$$HEX1$$f300$$ENDHEX$$n para Windows 2000/XP que estampa el sello que hemos escrito en el fichero sello.txt
// en el fichero pdf que hemos dado como entrada.

// NOTA: utiliza la funcion "of_runandwait" de las API de WIndows para esperar al proceso hijo que genera
//       previa a esta funcion hay que declarar las 3 funciones que se pueden observar
//				of_SetPriority(HIGH_PRIORITY_CLASS)      --> prioridad del proceso hijo
//				of_SetCurrentDirectory(g_dir_aplicacion) --> directorio 
//				of_SetWindow("minimize")					  --> modo en que se ejecutara el proceso hijo


//Retorno (entero) : -1 : Error al ejecutar el fichero de ejecuci$$HEX1$$f300$$ENDHEX$$n por lotes
//							 1 : Ejecucion correcta

int li_FileNum
int fichero_bat,retorno = 1
string cadena_cunyo, temp

//Cerramos el fichero txt. Ya que no se va a escribir nada m$$HEX1$$e100$$ENDHEX$$s sobre $$HEX1$$e900$$ENDHEX$$l.
FileClose(i_fichero_sello)

//Construimos la cadena para pasarsela al fichero bat
cadena_cunyo =' "./' + i_nombre_sello + '.txt" ' + '"'+i_fichero_pdf+'"' +''

//Parametros iniciales
n_runandwait runandwait
runandwait = create n_runandwait
runandwait.of_SetPriority(runandwait.HIGH_PRIORITY_CLASS)
runandwait.of_SetCurrentDirectory(g_dir_aplicacion)
runandwait.of_SetWindow("minimize")

retorno = runandwait.of_runandwait("stamppdf.bat -o ~"" + i_fichero_pdf_salida + '"' + cadena_cunyo)

//-----Fin sello
//// Borramos los ficheros generados de sello
filedelete(i_nombre_sello + ".txt")
//filedelete("log.txt")
//filedelete("stamppdf.err")

return retorno
end function

on n_escritor_pdf.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_escritor_pdf.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

