HA$PBExportHeader$w_lista.srw
forward
global type w_lista from w_sheet
end type
type st_1 from statictext within w_lista
end type
type dw_lista from u_dw within w_lista
end type
type cb_consulta from commandbutton within w_lista
end type
type cb_detalle from commandbutton within w_lista
end type
type cb_ayuda from commandbutton within w_lista
end type
end forward

global type w_lista from w_sheet
integer x = 59
integer y = 212
integer width = 3557
integer height = 1268
string title = "Lista Previa"
string menuname = "m_lista"
windowstate windowstate = maximized!
event csd_consulta ( )
event csd_detalle ( )
event csd_ayuda ( )
event csd_listados ( )
event csd_nuevo ( )
event csd_actualiza_dddw ( )
event csd_actualiza_listas ( )
event csd_tecla_usada pbm_dwnkey
event closequery_msgbox pbm_closequery
st_1 st_1
dw_lista dw_lista
cb_consulta cb_consulta
cb_detalle cb_detalle
cb_ayuda cb_ayuda
end type
global w_lista w_lista

type variables
string i_sql_original, i_sentencia_sql_lista
end variables

event csd_consulta;//Disparo el Evento Clicked del boton Consultar
//  cb_consulta.TriggerEvent (Clicked!)


end event

event csd_detalle;// Si el dw_lista no tiene ninguna tupla no entramos en el detalle
if dw_lista.RowCount() < 1 then return 
end event

event csd_ayuda;//Disparo el Evento Clicked del boton Ayuda
//  cb_ayuda.TriggerEvent (Clicked!)
end event

event csd_listados;//OpenSheet(g_w_listados, g_listados, w_aplic_frame, 0, original!)
end event

event csd_nuevo;//Abrimos la ventana de detalle para poder insertar uno nuevo
gb_nuevo=true
//OpenSheet(g_w_detalle, g_detalle,  w_aplic_frame, 0, original!)


end event

event csd_actualiza_dddw();// Actualizamos los dddw de la ventana
//      f_actualizar_ventana_lista(this,dw_lista)

if g_dw_lista.rowcount() <= 0 then return 
g_dw_lista.modify("datawindow.table.select= ~"" + i_sentencia_sql_lista + "~"")
dw_lista.retrieve()

//messagebox('',g_dw_lista.rowcount())
//messagebox('',i_sentencia_sql_lista)

if dw_lista.rowcount() > 0 then dw_lista.selectrow(1,true)

end event

event csd_actualiza_listas();// Actualizamos los dddw de la ventana
//      f_actualizar_ventana_lista(this,dw_lista)

if g_dw_lista.rowcount() <= 0 then return 
g_dw_lista.modify("datawindow.table.select= ~"" + i_sentencia_sql_lista + "~"")
dw_lista.retrieve()

g_dw_lista.modify("datawindow.table.select= ~"" + i_sql_original + "~"")

//messagebox('',g_dw_lista.rowcount())
//messagebox('',i_sentencia_sql_lista)

if dw_lista.rowcount() > 0 then dw_lista.selectrow(1,true)

end event

event closequery_msgbox;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  closequery_msgbox
//				$$HEX1$$ed00$$ENDHEX$$dem a closequery, pero devuelve al final el valor seleccionado
//					por el usuario en el MsgBox de confirmaci$$HEX1$$f300$$ENDHEX$$n de los cambios
//
//////////////////////////////////////////////////////////////////////////////
//
//	Description:
//	Search for unsaved datawindows prompting the user if any
//	pending updates are found.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Enhanced control on what objects are to be updated.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Constant Integer	ALLOW_CLOSE = 0
Constant Integer	PREVENT_CLOSE = 1

Integer	li_msg
Integer	li_rc
String	ls_msgparms[]
Powerobject lpo_updatearray[]
string mensaje

// Check if the CloseQuery process has been disabled
If ib_disableclosequery Then
	Return ALLOW_CLOSE
End If

// Call event to perform any pre-CloseQuery processing
If This.Event pfc_preclose ( ) <> 1 Then
	// Prevent the window from closing
	Return PREVENT_CLOSE 
End If

// Prevent validation error messages from appearing while the window is closing
// and allow others to check if the  CloseQuery process is in progress
ib_closestatus = True

// Determine the objects for which an update will be attempted.
// For the CloseQuery, the order sequence is as follows: 
//		1) Specified permananent sequence (thru of_SetUpdateObjects(...)).
//		2) None was specified, so use default window control array.
If UpperBound(ipo_updateobjects) > 0 Then
	lpo_updatearray = ipo_updateobjects
Else
	lpo_updatearray = This.Control		
End If

// Check for any pending updates
li_rc = of_UpdateChecks(lpo_updatearray)
If li_rc = 0 Then
	// Updates are NOT pending, allow the window to be closed.
	ib_closestatus = False
	Return ALLOW_CLOSE
ElseIf li_rc < 0 Then
	// There are Updates pending, but at least one data entry error was found.
	// Give the user an opportunity to close the window without saving changes
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_failsvalidation', &
					 ls_msgparms, gnv_app.iapp_object.DisplayName)
	Else
		mensaje = 	"La informaci$$HEX1$$f300$$ENDHEX$$n introducida no pasa el test de validaci$$HEX1$$f300$$ENDHEX$$n "  + &
				"y debe ser corregida antes de que se salven los cambios.~r~n~r~n" + &
				"$$HEX1$$bf00$$ENDHEX$$Desea salir sin grabar?"
		if g_usar_idioma = "S" then
			mensaje = g_idioma.of_getmsg( "pfc.test_validacion", mensaje)
		end if		
		li_msg = of_MessageBox ("", gnv_app.iapp_object.DisplayName, mensaje, exclamation!, YesNo!, 2)
	End If
	If li_msg = 1 Then
		ib_closestatus = False
		Return ALLOW_CLOSE
	End If
Else
	// Changes are pending, prompt the user to determine if they should be saved
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_savechanges',  &
					ls_msgparms, gnv_app.iapp_object.DisplayName)		
	Else
		mensaje = "$$HEX1$$bf00$$ENDHEX$$Desea grabar los cambios?"
		if g_usar_idioma = "S" then
			mensaje = g_idioma.of_getmsg( "pfc.closequery_savechanges", mensaje)
		end if
		
		li_msg = of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, mensaje, exclamation!, YesNoCancel!, 1)
	End If
	Choose Case li_msg
		Case 1
			// YES - Update
			// If the update fails, prevent the window from closing
			If This.Event pfc_save() >= 1 Then
				// Successful update, allow the window to be closed
				ib_closestatus = False
//				Return ALLOW_CLOSE
			End If
		Case 2
			// NO - Allow the window to be closed without saving changes
			ib_closestatus = False
			//Return ALLOW_CLOSE
		Case 3
			// CANCEL -  Prevent the window from closing
	End Choose
End If
// Prevent the window from closing
ib_closestatus = False
//Return PREVENT_CLOSE

Return li_msg
end event

on w_lista.create
int iCurrent
call super::create
if this.MenuName = "m_lista" then this.MenuID = create m_lista
this.st_1=create st_1
this.dw_lista=create dw_lista
this.cb_consulta=create cb_consulta
this.cb_detalle=create cb_detalle
this.cb_ayuda=create cb_ayuda
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_lista
this.Control[iCurrent+3]=this.cb_consulta
this.Control[iCurrent+4]=this.cb_detalle
this.Control[iCurrent+5]=this.cb_ayuda
end on

on w_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.dw_lista)
destroy(this.cb_consulta)
destroy(this.cb_detalle)
destroy(this.cb_ayuda)
end on

event open;call super::open;i_sql_original = dw_lista.Describe("Datawindow.Table.Select")
of_SetResize (true)
inv_resize.of_Register (st_1, "FixedtoBottom")
inv_resize.of_Register (dw_lista, "ScaletoRight&Bottom")
inv_resize.of_Register (cb_consulta, "FixedtoBottom")
inv_resize.of_Register (cb_detalle, "FixedtoBottom")
inv_resize.of_Register (cb_ayuda, "FixedtoBottom")




end event

event pfc_postopen;//cb_consulta.PostEvent(Clicked!)
TriggerEvent('csd_consulta')


end event

event key;// Si se pulsa intro lanzamos la edici$$HEX1$$f300$$ENDHEX$$n de la fila seleccionada en la datawindow
if key=KeyEnter! and dw_lista.rowcount() > 0 then this.event csd_detalle()

end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_lista
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_lista
end type

type st_1 from statictext within w_lista
integer x = 23
integer y = 1012
integer width = 402
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 255
boolean focusrectangle = false
end type

type dw_lista from u_dw within w_lista
event csd_retrieve ( )
event csd_enter pbm_dwnprocessenter
event csd_tecla_usada pbm_dwnkey
integer x = 23
integer y = 36
integer width = 3456
integer height = 968
integer taborder = 40
string dataobject = "d_actividades"
end type

event csd_retrieve();// Se asigna a variable que se utilizara para actualizar la lista (desde menu)
i_sentencia_sql_lista = dw_lista.describe("datawindow.table.select")

// Codigo original de w_lista
This.Retrieve()
This.modify("DataWindow.Table.Select= ~"" + i_sql_original + "~"")

end event

event csd_enter;//Procesamiento de la tecla intro como tab
Post( Handle(this),256,9,0 )
Return 1

end event

event csd_tecla_usada;//choose case (key)
//	case keyF5!
//		messagebox(' es la tecla buscada ',' ')
//end choose
end event

event retrieveend;call super::retrieveend;//cb_detalle.enabled = (this.Rowcount() > 0)
string registros
registros = 'registros'
if g_usar_idioma = "S" then
	registros = g_idioma.of_getmsg( "lista.registros", "registros" )
end if

ST_1.text = string(this.RowCount()) + ' ' + registros + '.'

end event

event doubleclicked;if rowcount() >0 then  Parent.TriggerEvent('csd_detalle')
	
//		cb_detalle.TriggerEvent(Clicked!)
end event

event constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)
this.of_SetTransObject(SQLCA)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

// Enable printpreview service
of_SetPrintPreview (true)
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = False
am_dw.m_table.m_debug.visible = False
am_dw.m_table.m_debug.enabled = False



end event

type cb_consulta from commandbutton within w_lista
boolean visible = false
integer x = 23
integer y = 956
integer width = 512
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Consultar "
end type

event clicked;// Llamamos al  evento "csd_consulta" de la ventana
Parent.TriggerEvent('csd_consulta')
end event

type cb_detalle from commandbutton within w_lista
boolean visible = false
integer x = 562
integer y = 956
integer width = 512
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Detalle "
end type

event clicked;//g_consulta_.clave_unica = dw_lista.GetItemString(dw_lista.GetRow(),'clave_unica')
//message.stringparm = "w_detalle"
//w_frame.PostEvent("csd_abreproyecto")

// Llamamos al  evento "csd_consulta" de la ventana
Parent.TriggerEvent('csd_detalle')

end event

type cb_ayuda from commandbutton within w_lista
boolean visible = false
integer x = 1751
integer y = 956
integer width = 517
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Ayuda"
end type

event clicked;f_ayuda(40)
end event

