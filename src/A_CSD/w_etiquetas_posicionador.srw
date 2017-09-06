HA$PBExportHeader$w_etiquetas_posicionador.srw
forward
global type w_etiquetas_posicionador from w_response
end type
type dw_1 from u_dw within w_etiquetas_posicionador
end type
type tb_zoom from htrackbar within w_etiquetas_posicionador
end type
type cb_anyadir from commandbutton within w_etiquetas_posicionador
end type
type cb_quitar from commandbutton within w_etiquetas_posicionador
end type
type cb_cerrar from commandbutton within w_etiquetas_posicionador
end type
type cb_imprimir from commandbutton within w_etiquetas_posicionador
end type
type gb_1 from groupbox within w_etiquetas_posicionador
end type
end forward

global type w_etiquetas_posicionador from w_response
integer x = 214
integer y = 221
integer height = 2444
string title = "Posicionador de Etiquetas"
dw_1 dw_1
tb_zoom tb_zoom
cb_anyadir cb_anyadir
cb_quitar cb_quitar
cb_cerrar cb_cerrar
cb_imprimir cb_imprimir
gb_1 gb_1
end type
global w_etiquetas_posicionador w_etiquetas_posicionador

type variables
datawindow dw

end variables

on w_etiquetas_posicionador.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.tb_zoom=create tb_zoom
this.cb_anyadir=create cb_anyadir
this.cb_quitar=create cb_quitar
this.cb_cerrar=create cb_cerrar
this.cb_imprimir=create cb_imprimir
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.tb_zoom
this.Control[iCurrent+3]=this.cb_anyadir
this.Control[iCurrent+4]=this.cb_quitar
this.Control[iCurrent+5]=this.cb_cerrar
this.Control[iCurrent+6]=this.cb_imprimir
this.Control[iCurrent+7]=this.gb_1
end on

on w_etiquetas_posicionador.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.tb_zoom)
destroy(this.cb_anyadir)
destroy(this.cb_quitar)
destroy(this.cb_cerrar)
destroy(this.cb_imprimir)
destroy(this.gb_1)
end on

event open;call super::open;
dw=Message.PowerObjectParm
dw_1.DataObject=dw.dataobject

long i
integer filas,columnas,etiquetas_x_hoja
integer tmp

filas=integer(dw_1.object.datawindow.label.rows)
columnas=integer(dw_1.object.datawindow.label.columns)

etiquetas_x_hoja=filas * columnas

for i=1 to etiquetas_x_hoja
	dw_1.insertrow(0)
next
	
dw_1.Object.DataWindow.Zoom = 35

/*
if integer(dw_1.object.datawindow.print.orientation)=1 then
	tmp=this.height
	this.height=this.width
	this.width=tmp
	
	tmp=dw_1.height
	dw_1.height=dw_1.width
	dw_1.width=tmp
	
end if
*/

of_SetResize (true)
inv_resize.of_Register (cb_anyadir, "FixedtoRight")
inv_resize.of_Register (cb_quitar, "FixedtoRight")

f_centrar_ventana(this)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_etiquetas_posicionador
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_etiquetas_posicionador
end type

type dw_1 from u_dw within w_etiquetas_posicionador
integer x = 55
integer y = 44
integer width = 1975
integer height = 2100
integer taborder = 10
boolean bringtotop = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event clicked;call super::clicked;long i

if dw_1.GetItemString(row,'visible')='N' then
	for i=1 to Integer(dw.Object.DataWindow.Column.Count)
		dw_1.SetItem(row,i,dw.GetItemString(1,i))
	next
	
	dw_1.SetItem(row,'visible','S')
else
	for i=1 to Integer(dw.Object.DataWindow.Column.Count)
		dw_1.SetItem(row,i,'')
	next	
	dw_1.SetItem(row,'visible','N')		
end if
dw_1.SetRedraw(true)
//dw_1.Object.DataWindow.Zoom = 40


end event

type tb_zoom from htrackbar within w_etiquetas_posicionador
integer x = 96
integer y = 2216
integer width = 622
integer height = 128
boolean bringtotop = true
integer minposition = 10
integer maxposition = 100
integer position = 40
integer tickfrequency = 5
end type

event moved;dw_1.Object.DataWindow.Zoom = scrollpos
end event

type cb_anyadir from commandbutton within w_etiquetas_posicionador
integer x = 2048
integer y = 56
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "A$$HEX1$$f100$$ENDHEX$$adir Hoja"
end type

event clicked;integer filas,columnas,etiquetas_x_hoja
integer i

filas=integer(dw_1.object.datawindow.label.rows)
columnas=integer(dw_1.object.datawindow.label.columns)

etiquetas_x_hoja=filas * columnas

for i=1 to etiquetas_x_hoja
	dw_1.insertrow(0)
next
end event

type cb_quitar from commandbutton within w_etiquetas_posicionador
integer x = 2048
integer y = 180
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
string text = "Quitar Hoja"
end type

event clicked;integer filas,columnas,etiquetas_x_hoja
integer i

filas=integer(dw_1.object.datawindow.label.rows)
columnas=integer(dw_1.object.datawindow.label.columns)

etiquetas_x_hoja=filas * columnas

for i=etiquetas_x_hoja to 1 step -1
	dw_1.deleterow(0)
next
end event

type cb_cerrar from commandbutton within w_etiquetas_posicionador
integer x = 2062
integer y = 2216
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
string text = "Salir"
end type

event clicked;close(parent)
end event

type cb_imprimir from commandbutton within w_etiquetas_posicionador
integer x = 2048
integer y = 372
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
string text = "Imprimir"
end type

event clicked;PrintSetup()
dw_1.Object.DataWindow.Zoom = 100 
dw_1.print()

tb_zoom.position=100
end event

type gb_1 from groupbox within w_etiquetas_posicionador
integer x = 59
integer y = 2156
integer width = 695
integer height = 200
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Zoom"
end type

