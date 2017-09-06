HA$PBExportHeader$uo_csd_barra_progreso.sru
forward
global type uo_csd_barra_progreso from userobject
end type
type porcentaje from statictext within uo_csd_barra_progreso
end type
type cuadro_azul from statictext within uo_csd_barra_progreso
end type
type etiqueta from statictext within uo_csd_barra_progreso
end type
end forward

global type uo_csd_barra_progreso from userobject
string tag = "barra de progreso"
integer width = 2757
integer height = 304
long backcolor = 67108864
string text = "barra de progreso"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
porcentaje porcentaje
cuadro_azul cuadro_azul
etiqueta etiqueta
end type
global uo_csd_barra_progreso uo_csd_barra_progreso

type variables
long il_ancho_cuadro_azul, il_max, il_min
string mensaje
end variables

forward prototypes
public subroutine mostrar_barra (boolean b_visible)
public subroutine texto_etiqueta (string texto, double color)
public subroutine parametrizar (long maximo)
public subroutine incrementar (long avance)
end prototypes

public subroutine mostrar_barra (boolean b_visible);//////////////////////////////////////////////////////
//                                                  //
//    Muestra u oculta la barra de progreso         //
//                                                  //
//////////////////////////////////////////////////////


this.visible=b_visible
end subroutine

public subroutine texto_etiqueta (string texto, double color);//////////////////////////////////////////////////////
//                                                  //
//    Esta funci$$HEX1$$f300$$ENDHEX$$n nos permite cambiar el texto y   //
//    el color de la etiqueta.                      //
//                                                  //
//    color debe ser el color en el mismo formato   //
//    que nos devuelve la funci$$HEX1$$f300$$ENDHEX$$n rgb.              //
//                                                  //
//    Si en el color o en el string ponemos un -1   //
//    no modificaremos ese parametro.               //
//                                                  //
//////////////////////////////////////////////////////

if texto <> '-1' then etiqueta.text=texto
if color <> -1 then etiqueta.textcolor=color
end subroutine

public subroutine parametrizar (long maximo);//////////////////////////////////////////////////////
//                                                  //
//    Inicializa las variables necesarias para el   //
//    funcionamiento de la barra.                   //
//                                                  //
//    La variable maximo nos indica el valor maximo //
//    de las iteracciones que van a ser necesarias  //
//                                                  //
//////////////////////////////////////////////////////


il_max=maximo
il_min = 0
il_ancho_cuadro_azul=this.Width
cuadro_azul.Width=0
end subroutine

public subroutine incrementar (long avance);//////////////////////////////////////////////////////
//                                                  //
//    Esta funci$$HEX1$$f300$$ENDHEX$$n incrementa el valor del ancho    //
//    de la barra, el incremento es total, es decir //
//    lo que se le pasa es el nuevo valor de anchura//
//    de la barra, no lo que se incrementa          //
//                                                  //
//////////////////////////////////////////////////////
   
	
	
	Long intervalo

	
	intervalo = il_max - il_min

// Comprobamos que (Max - Min) no sea "0"
   if intervalo = 0 then intervalo = 1
	

// Incrementamos la anchura del cuadro azul
	cuadro_azul.Width= Long(avance * (il_ancho_cuadro_azul/intervalo))
	
// Actualizamos Porcentaje
	//choose case g_idioma
	//	case 'E'
			porcentaje.Text = String(Truncate(100 * avance/intervalo,0))+'% ' + g_idioma.of_getmsg( "barra_progreso.proesado", "procesado")
	//	case 'I'
	//		porcentaje.Text = String(Truncate(100 * avance/intervalo,0))+'% processed'
	//	case else
	//		porcentaje.Text = String(Truncate(100 * avance/intervalo,0))+'% procesado'
	//end choose
end subroutine

on uo_csd_barra_progreso.create
this.porcentaje=create porcentaje
this.cuadro_azul=create cuadro_azul
this.etiqueta=create etiqueta
this.Control[]={this.porcentaje,&
this.cuadro_azul,&
this.etiqueta}
end on

on uo_csd_barra_progreso.destroy
destroy(this.porcentaje)
destroy(this.cuadro_azul)
destroy(this.etiqueta)
end on

event constructor;etiqueta.backcolor  = 31315402
porcentaje.backcolor = 31315402
end event

type porcentaje from statictext within uo_csd_barra_progreso
string tag = "0%"
integer y = 168
integer width = 1152
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 79741120
string text = "0%"
boolean focusrectangle = false
end type

type cuadro_azul from statictext within uo_csd_barra_progreso
integer y = 80
integer width = 2432
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 8388608
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type etiqueta from statictext within uo_csd_barra_progreso
string tag = "ooooooo"
integer y = 4
integer width = 2427
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "ooooooo"
boolean focusrectangle = false
end type

