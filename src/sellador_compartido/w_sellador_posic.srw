HA$PBExportHeader$w_sellador_posic.srw
forward
global type w_sellador_posic from w_response
end type
type ole_visor_pdf from olecustomcontrol within w_sellador_posic
end type
type cb_obtener from u_cb within w_sellador_posic
end type
type cb_cancelar from u_cb within w_sellador_posic
end type
type st_1 from statictext within w_sellador_posic
end type
type st_2 from statictext within w_sellador_posic
end type
type st_3 from statictext within w_sellador_posic
end type
end forward

global type w_sellador_posic from w_response
integer width = 1728
integer height = 2048
string title = "Posicionamiento Libre del Sello"
ole_visor_pdf ole_visor_pdf
cb_obtener cb_obtener
cb_cancelar cb_cancelar
st_1 st_1
st_2 st_2
st_3 st_3
end type
global w_sellador_posic w_sellador_posic

type variables
string is_nombre_pdf
long il_nueva_rotacion

end variables

on w_sellador_posic.create
int iCurrent
call super::create
this.ole_visor_pdf=create ole_visor_pdf
this.cb_obtener=create cb_obtener
this.cb_cancelar=create cb_cancelar
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_visor_pdf
this.Control[iCurrent+2]=this.cb_obtener
this.Control[iCurrent+3]=this.cb_cancelar
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
end on

on w_sellador_posic.destroy
call super::destroy
destroy(this.ole_visor_pdf)
destroy(this.cb_obtener)
destroy(this.cb_cancelar)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
end on

event open;call super::open;string cadena,rotacion

f_centrar_ventana(this)
cadena=Message.StringParm

// Obtenemos el nombre del PDF
is_nombre_pdf=LeftA(cadena,PosA(cadena,'::') - 1)

// Obtenemos la rotaci$$HEX1$$f300$$ENDHEX$$n que se ha aplicado en la ventana anterior
rotacion=MidA(cadena,PosA(cadena,'::') + 2)
il_nueva_rotacion=long(LeftA(rotacion,LenA(rotacion) - 1))

// Cargamos el fichero y rotamos la vista en caso de que se haya aplicado rotaci$$HEX1$$f300$$ENDHEX$$n en w_sellador_compartido
ole_visor_pdf.object.loadFile(is_nombre_pdf)
if il_nueva_rotacion<>0 then ole_visor_pdf.Object.rotate = il_nueva_rotacion

of_SetResize (true)
inv_resize.of_Register (cb_obtener, "FixedToBottom")
inv_resize.of_Register (cb_cancelar, "FixedToBottom")

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_sellador_posic
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_sellador_posic
end type

type ole_visor_pdf from olecustomcontrol within w_sellador_posic
integer x = 18
integer y = 396
integer width = 1659
integer height = 1380
integer taborder = 170
boolean bringtotop = true
long backcolor = 16777215
boolean focusrectangle = false
string binarykey = "w_sellador_posic.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type cb_obtener from u_cb within w_sellador_posic
integer x = 430
integer y = 1820
integer taborder = 11
boolean bringtotop = true
string text = "Obtener"
end type

event clicked;call super::clicked;double x0,x1,y0,y1,pagina
double x0_cm,x1_cm,y0_cm,y1_cm
boolean selec
long alto,ancho,rotacion

u_analizador_pdf coord
st_sello posiciones

coord=create u_analizador_pdf

rotacion=ole_visor_pdf.object.GetPageRotation(1)

rotacion=rotacion+il_nueva_rotacion

x0=ole_visor_pdf.object.getCurrentSelectionx0
x1=ole_visor_pdf.object.getCurrentSelectionx1
y0=ole_visor_pdf.object.getCurrentSelectiony0
y1=ole_visor_pdf.object.getCurrentSelectiony1

x0_cm=coord.f_puntos_a_cm(x0)
y0_cm=coord.f_puntos_a_cm(y0)
x1_cm=coord.f_puntos_a_cm(x1)
y1_cm=coord.f_puntos_a_cm(y1)	

//MessageBox("ROTA="+string(rotacion)+"  x0="+string(x0)+ "  y0="+string(y0),"x1="+string(x1)+"  y1="+string(y1))

if rotacion=0 or rotacion=360 then
	posiciones.x=x0_cm
	posiciones.y=y1_cm
elseif rotacion=90 then
	posiciones.x=x1_cm
	posiciones.y=y0_cm
elseif rotacion=270 then
	posiciones.x=x1_cm
	posiciones.y=y0_cm
elseif rotacion=180 then
	posiciones.x=x0_cm
	posiciones.y=y1_cm
end if

//MessageBox("x="+string(coord.f_cm_a_puntos(posiciones.x)),"y="+string(coord.f_cm_a_puntos(posiciones.y)))
CloseWithReturn(parent,posiciones)
end event

type cb_cancelar from u_cb within w_sellador_posic
integer x = 818
integer y = 1820
integer taborder = 21
boolean bringtotop = true
string text = "Cancelar"
end type

event clicked;call super::clicked;Close(parent)
end event

type st_1 from statictext within w_sellador_posic
integer x = 37
integer y = 24
integer width = 1632
integer height = 108
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione la regi$$HEX1$$f300$$ENDHEX$$n donde quiere situar el sello pulsando sobre la previsualizaci$$HEX1$$f300$$ENDHEX$$n y creando una caja de selecci$$HEX1$$f300$$ENDHEX$$n."
boolean focusrectangle = false
end type

type st_2 from statictext within w_sellador_posic
integer x = 32
integer y = 244
integer width = 1632
integer height = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Se posicionar$$HEX2$$e1002000$$ENDHEX$$el sello con respecto a la esquina inferior izquierda de la caja de selecci$$HEX1$$f300$$ENDHEX$$n."
boolean focusrectangle = false
end type

type st_3 from statictext within w_sellador_posic
integer x = 37
integer y = 172
integer width = 261
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 128
long backcolor = 67108864
string text = "NOTA"
boolean focusrectangle = false
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
00w_sellador_posic.bin 
2800000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000300000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000002fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000300000000000000000000000000000000000000000000000000000000865b45b001c8277300000004000000800000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe000000000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a0000000200000001000000042aeb64d946322e252b856ab0ee4b09b900000000865b45b001c82773865b45b001c82773000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000048000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffff
22ffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000b29300000048000800034757f20b000000200065005f00740078006e00650078007400002584000800034757f20affffffe00065005f00740078006e006500790074000023a80035003a003a00340033003100000020007700730074005f00780065006f00740073005f006c0065006f006c006d005f006e0061006500740069006e0073002e00770072002800200029007800280020003800310031003400200029003300310030002f002f0039003000320036003000310020003a0032003900330035003a0020003800730000005f007700650073006c006c006400610072006f0070005f006500720069007600750073006c0061007a006900630061006f0069005f006e00640070002e00660072007300200077007800280020002900320028003700370037003700200029003300310030002f002f0039003000320036003000310020003a0032003900330035003a0020003900730000005f007700650073006c006c006400610072006f0070005f006500720069007600750073006c0061007a006900630061006f0069005f006e0069006d0069006e0073002e0077007200280020002900780028002000330036003200320029003000310020002f0033003900300032002f0030003000200036003200310034003a003a003000310030000000200000000700000009000000080000000c0000000a0000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10w_sellador_posic.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
