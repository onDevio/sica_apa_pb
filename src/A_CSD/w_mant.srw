HA$PBExportHeader$w_mant.srw
$PBExportComments$MADRE DE TODOS LOS MANTENIMIENTOS
forward
global type w_mant from w_sheet
end type
type dw_1 from u_dw within w_mant
end type
type cb_anyadir from u_cb within w_mant
end type
type cb_borrar from u_cb within w_mant
end type
type cb_ayuda from u_cb within w_mant
end type
end forward

global type w_mant from w_sheet
integer width = 2670
integer height = 1504
windowstate windowstate = maximized!
dw_1 dw_1
cb_anyadir cb_anyadir
cb_borrar cb_borrar
cb_ayuda cb_ayuda
end type
global w_mant w_mant

type variables
int ii_ayuda
end variables

on w_mant.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_anyadir=create cb_anyadir
this.cb_borrar=create cb_borrar
this.cb_ayuda=create cb_ayuda
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_anyadir
this.Control[iCurrent+3]=this.cb_borrar
this.Control[iCurrent+4]=this.cb_ayuda
end on

on w_mant.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_anyadir)
destroy(this.cb_borrar)
destroy(this.cb_ayuda)
end on

event open;call super::open;// Enable the resize service
of_SetResize (true)

// Specify how the window will be resized
inv_resize.of_Register (dw_1, "ScaletoRight&Bottom")
inv_resize.of_Register (cb_anyadir, "FixedtoBottom")
inv_resize.of_Register (cb_borrar, "FixedtoBottom")
inv_resize.of_Register (cb_ayuda, "FixedtoBottom")

//dw_1.SetFocus()
end event

event pfc_postopen;call super::pfc_postopen;// Retrieve DataWindow
//dw_1.event pfc_retrieve()
end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_mant
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_mant
end type

type dw_1 from u_dw within w_mant
integer x = 23
integer y = 40
integer width = 2583
integer height = 1152
integer taborder = 20
string dataobject = "d_actividades"
boolean hscrollbar = true
end type

event constructor;
of_SetRowManager(TRUE)
 
of_SetSort(TRUE)
 
of_SetResize(TRUE)
of_SetTransObject(SQLCA)
// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

// Enable printpreview service
of_SetPrintPreview (true)
end event

type cb_anyadir from u_cb within w_mant
string tag = "texto=general.anyadir"
integer x = 23
integer y = 1208
integer width = 283
integer taborder = 30
string text = "&A$$HEX1$$f100$$ENDHEX$$adir"
end type

event clicked;call super::clicked;dw_1.event pfc_addrow()
end event

type cb_borrar from u_cb within w_mant
string tag = "texto=general.borrar"
integer x = 320
integer y = 1208
integer taborder = 10
boolean bringtotop = true
string text = "&Borrar"
end type

event clicked;call super::clicked;dw_1.event pfc_deleterow()
end event

type cb_ayuda from u_cb within w_mant
string tag = "texto=general.ayuda"
integer x = 1349
integer y = 1208
integer taborder = 2
boolean bringtotop = true
string text = "&Ayuda"
end type

event clicked;call super::clicked;f_ayuda(ii_ayuda)
end event

event constructor;call super::constructor;this.visible = false
end event

