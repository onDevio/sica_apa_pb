HA$PBExportHeader$w_detalle.srw
$PBExportComments$MADRE DE LAS VENTANAS DE DETALLE
forward
global type w_detalle from w_sheet
end type
type cb_nuevo from commandbutton within w_detalle
end type
type cb_ayuda from commandbutton within w_detalle
end type
type cb_grabar from commandbutton within w_detalle
end type
type cb_ant from commandbutton within w_detalle
end type
type cb_sig from commandbutton within w_detalle
end type
type dw_1 from u_dw within w_detalle
end type
end forward

shared variables

end variables

global type w_detalle from w_sheet
integer x = 59
integer y = 212
integer width = 3173
integer height = 1860
string title = "Ventana de Detalle"
string menuname = "m_detalle"
windowstate windowstate = maximized!
event type integer csd_nuevo ( )
event csd_grabar ( )
event csd_anterior ( )
event csd_siguiente ( )
event csd_ayuda ( )
event csd_primero ( )
event csd_ultimo ( )
event csd_lista ( )
event csd_borrar ( )
event csd_listados ( )
event csd_actualiza_dddw ( )
cb_nuevo cb_nuevo
cb_ayuda cb_ayuda
cb_grabar cb_grabar
cb_ant cb_ant
cb_sig cb_sig
dw_1 dw_1
end type
global w_detalle w_detalle

type variables

end variables

event type integer csd_nuevo();//VEAMOS SI SE HAN PRODUCIDO CAMBIOS EN las dws actuales
int retorno
retorno = Event closequery()
// Si ha cancelado el closequery, debemos informar a los hijos de que no prosigan sus acciones
if retorno = 1 then return -1
	
dw_1.reset()
dw_1.event pfc_addrow()
// Decimos que se puede continuar la accion en los hijos
return 1

end event

event csd_grabar;// Guardamos los cambios de la ventana
Event pfc_save()
end event

event csd_anterior();// Comprobamos que la ventana "lista previa" del m$$HEX1$$f300$$ENDHEX$$dulo est$$HEX2$$e1002000$$ENDHEX$$abierta
if not isvalid(g_dw_lista) then return
int fila_actual, la_fila

fila_actual = g_dw_lista.GetRow()

if fila_actual <= 1 then
	string mensaje
	mensaje = "No hay filas anteriores a esta"
	if g_usar_idioma = "S" then
		mensaje = g_idioma.of_getmsg( "w_detalle.no_anteriores", mensaje)
	end if
	MessageBox(g_titulo,mensaje)
	return
end if

la_fila = fila_actual - 1

g_dw_lista.SetRow(la_fila)
g_dw_lista.ScrollToRow(la_fila)

end event

event csd_siguiente();// Comprobamos que la ventana "lista previa" del m$$HEX1$$f300$$ENDHEX$$dulo est$$HEX2$$e1002000$$ENDHEX$$abierta
if not isvalid(g_dw_lista) then return
int fila_actual, la_fila

fila_actual = g_dw_lista.GetRow()

if fila_actual >= g_dw_lista.RowCount()  then
	string mensaje
	mensaje = "No hay filas posteriores a esta"
	if g_usar_idioma = "S" then
		mensaje = g_idioma.of_getmsg( "w_detalle.no_posteriores", mensaje)
	end if	
	MessageBox(g_titulo,mensaje)
	return
end if

la_fila = fila_actual + 1

g_dw_lista.SetRow(la_fila)
g_dw_lista.ScrollToRow(la_fila)
end event

event csd_ayuda;f_ayuda(10)
end event

event csd_lista;// Abrimos la venana de lista si no est$$HEX2$$e1002000$$ENDHEX$$abierta y la activamos si ya est$$HEX2$$e1002000$$ENDHEX$$abierta
// g_w_lista : variable que hace referencia a la ventana lista
// g_lista : variable que almacena el nombre de la ventana a abrir
OpenSheet(g_w_lista, g_lista, w_aplic_frame, 0, original!)
end event

event csd_borrar;dw_1.Event  pfc_DeleteRow()
end event

event csd_actualiza_dddw;// Actualizamos los dddw de la ventana
	f_actualizar_ventana(this)

end event

on w_detalle.create
int iCurrent
call super::create
if this.MenuName = "m_detalle" then this.MenuID = create m_detalle
this.cb_nuevo=create cb_nuevo
this.cb_ayuda=create cb_ayuda
this.cb_grabar=create cb_grabar
this.cb_ant=create cb_ant
this.cb_sig=create cb_sig
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_nuevo
this.Control[iCurrent+2]=this.cb_ayuda
this.Control[iCurrent+3]=this.cb_grabar
this.Control[iCurrent+4]=this.cb_ant
this.Control[iCurrent+5]=this.cb_sig
this.Control[iCurrent+6]=this.dw_1
end on

on w_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_nuevo)
destroy(this.cb_ayuda)
destroy(this.cb_grabar)
destroy(this.cb_ant)
destroy(this.cb_sig)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.of_SetLinkage(TRUE)
of_SetResize (true)
inv_resize.of_Register (cb_nuevo, "FixedtoRight")
inv_resize.of_Register (cb_ayuda, "FixedtoRight")
inv_resize.of_Register (cb_ant, "FixedtoRight")
inv_resize.of_Register (cb_sig, "FixedtoRight")
inv_resize.of_Register (cb_grabar, "FixedtoRight")
inv_resize.of_Register (dw_1, "ScaletoRight")



end event

event pfc_postopen;if gb_nuevo then
	triggerevent("csd_nuevo")
	gb_nuevo=false
else
	dw_1.event csd_retrieve()
end if
end event

event activate;call super::activate;// Si se ha pinchado en nuevo en la ventana de lista creamos uno nuevo
IF gb_nuevo THEN
	This.PostEvent('csd_nuevo')
	gb_nuevo = false
ELSE
	// En caso contrario cargamos el detalle de la fila correspondiente	
	dw_1.event csd_retrieve()
END IF

end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_detalle
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_detalle
end type

type cb_nuevo from commandbutton within w_detalle
boolean visible = false
integer x = 2601
integer y = 12
integer width = 512
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Nuevo"
end type

event clicked;// Lanzamos el evento de nuevo de la ventana
Parent.Event csd_nuevo()
end event

type cb_ayuda from commandbutton within w_detalle
boolean visible = false
integer x = 2601
integer y = 288
integer width = 512
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "A&yuda"
end type

event clicked;// Lanzamos el evento de la ayuda de la ventana
Parent.TriggerEvent("csd_ayuda")
end event

type cb_grabar from commandbutton within w_detalle
boolean visible = false
integer x = 2601
integer y = 108
integer width = 512
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Grabar"
end type

event clicked;// Guardamos los cambios de la ventana
Parent.Event pfc_save()
end event

type cb_ant from commandbutton within w_detalle
boolean visible = false
integer x = 2601
integer y = 196
integer width = 242
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "<"
end type

event clicked;// Lanzamos el evento de la ventana para pasar al anterior registro
Parent.TriggerEvent("csd_anterior")
end event

type cb_sig from commandbutton within w_detalle
boolean visible = false
integer x = 2871
integer y = 196
integer width = 242
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = ">"
end type

event clicked;// Lanzamos el evento de la ventana para pasar al siguiente registro
Parent.TriggerEvent("csd_siguiente")
end event

type dw_1 from u_dw within w_detalle
event csd_retrieve ( )
event csd_enter pbm_dwnprocessenter
integer x = 18
integer y = 12
integer width = 3090
integer height = 712
integer taborder = 10
string dataobject = "d_actividades"
boolean vscrollbar = false
end type

event csd_enter;//Procesamiento de la tecla intro como tab
Post( Handle(this),256,9,0 )
Return 1

end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = False
end event

event retrieveend;call super::retrieveend;This.TriggerEvent(Rowfocuschanged!)

end event

event constructor;call super::constructor;
// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

