HA$PBExportHeader$w_minutas_detalle_lista.srw
forward
global type w_minutas_detalle_lista from w_mant_busq
end type
type dw_detalle from u_dw within w_minutas_detalle_lista
end type
type dw_facturas from u_dw within w_minutas_detalle_lista
end type
type dw_liquidaciones from u_dw within w_minutas_detalle_lista
end type
type dw_reclamaciones from u_dw within w_minutas_detalle_lista
end type
end forward

global type w_minutas_detalle_lista from w_mant_busq
integer width = 3346
integer height = 2416
string title = "Lista de Avisos de Factura"
string menuname = "m_minuta_detalle_lista"
event csd_consulta ( )
event csd_anterior ( )
event csd_siguiente ( )
event csd_primero ( )
event csd_ultimo ( )
event csd_listados ( )
dw_detalle dw_detalle
dw_facturas dw_facturas
dw_liquidaciones dw_liquidaciones
dw_reclamaciones dw_reclamaciones
end type
global w_minutas_detalle_lista w_minutas_detalle_lista

event csd_consulta;string sql_original

sql_original = dw_1.GetSQLSelect()

g_dw_lista = dw_1

open(w_minutas_consulta)
if Message.DoubleParm = -1 then return

dw_1.Retrieve()

dw_1.SetSQLSelect(sql_original)


end event

event csd_anterior;long fila_actual,la_fila

if dw_1.rowcount() > 0 then

fila_actual = dw_1.GetRow()

if fila_actual <= 1 then
	return
end if

la_fila = fila_actual - 1

dw_1.SetRow(la_fila)
dw_1.ScrollToRow(la_fila)
end if

end event

event csd_siguiente;long fila_actual,la_fila

if dw_1.rowcount() > 0 then
	fila_actual = dw_1.GetRow()
	if fila_actual = dw_1.RowCount() then
		return
	end if
	la_fila = fila_actual + 1
	dw_1.SetRow(la_fila)
	dw_1.ScrollToRow(la_fila)
end if

end event

event csd_primero;if dw_1.rowcount() > 0 then
	dw_1.SetRow(1)
	dw_1.ScrollToRow(1)
end if

end event

event csd_ultimo;if dw_1.rowcount() > 0 then
	dw_1.SetRow(dw_1.RowCount())
	dw_1.ScrollToRow(dw_1.RowCount())
end if

end event

event csd_listados;open(w_minutas_listados)
end event

event open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  pfc_w_master
//
//	Description:
//	The ancestor to all PFC window classes
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//	6.0   Added MRU and Logical Unit of Work service code
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer li_rc

// Allow for pre and post open events to occur
This.Event pfc_preopen()
This.Post Event pfc_postopen()

// Default window title is application title
If LenA (This.title) = 0 Then
	If IsValid (gnv_app.iapp_object) Then
		This.title = gnv_app.iapp_object.DisplayName
	End If
End If

// Allow preference service to restore settings if necessary
If IsValid(inv_preference) Then
	If gnv_app.of_IsRegistryAvailable() Then
		If LenA(gnv_app.of_GetUserKey())> 0 Then 
			li_rc = inv_preference.of_Restore( &
				gnv_app.of_GetUserKey()+'\'+this.ClassName()+'\Preferences')
		ElseIf IsValid(gnv_app.inv_debug) Then				
			of_MessageBox ("pfc_master_open_preferenceregistrydebug", &
				"PowerBuilder Foundation Class Library", "The PFC User Preferences service" +&
				" has been requested but The UserRegistrykey property has not" +&
				" been Set on The application manager Object.~r~n~r~n" + &
  				"Call of_SetRegistryUserKey on The Application Manager" +&
				" to Set The property.", &
				Exclamation!, OK!, 1)
		End If
	Else
		If LenA(gnv_app.of_GetUserIniFile()) > 0 Then
			li_rc = inv_preference.of_Restore (gnv_app.of_GetUserIniFile(), This.ClassName()+' Preferences')
		ElseIf IsValid(gnv_app.inv_debug) Then		
			of_MessageBox ("pfc_master_open_preferenceinidebug", &
				"PowerBuilder Class Library", "The PFC User Preferences service" +&
				" has been requested but The UserINIFile property has not" +&
				" been Set on The application manager Object.~r~n~r~n" + &
  				"Call of_SetUserIniFile on The Application Manager" +&
				" to Set The property.", &
				Exclamation!, OK!, 1)		
		End If
	End If
End If

// Allow MRU service to restore settings if necessary
If IsValid(gnv_app.inv_mru) Then
	this.event pfc_mrurestore()
End if

// Enable the resize service
of_SetResize (true)

f_enlaza_dw(dw_1,dw_detalle,'id_minuta','id_minuta')
f_enlaza_dw(dw_1,dw_facturas,'id_minuta','id_fase')
f_enlaza_dw(dw_1,dw_liquidaciones,'id_minuta','id_fase')
f_enlaza_dw(dw_1,dw_reclamaciones,'id_minuta','id_minuta')

inv_resize.of_Register (dw_1, "ScaletoRight&Bottom")
inv_resize.of_Register (dw_detalle, "FixedToBottom&ScaleToRight")
inv_resize.of_Register (dw_facturas,"FixedToRight&Bottom")
inv_resize.of_Register (dw_liquidaciones,"FixedToBottom")

inv_resize.of_Register (dw_reclamaciones,"FixedToBottom&ScaleToRight")
postevent("csd_consulta")


end event

on w_minutas_detalle_lista.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_minuta_detalle_lista" then this.MenuID = create m_minuta_detalle_lista
this.dw_detalle=create dw_detalle
this.dw_facturas=create dw_facturas
this.dw_liquidaciones=create dw_liquidaciones
this.dw_reclamaciones=create dw_reclamaciones
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_detalle
this.Control[iCurrent+2]=this.dw_facturas
this.Control[iCurrent+3]=this.dw_liquidaciones
this.Control[iCurrent+4]=this.dw_reclamaciones
end on

on w_minutas_detalle_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_detalle)
destroy(this.dw_facturas)
destroy(this.dw_liquidaciones)
destroy(this.dw_reclamaciones)
end on

type dw_1 from w_mant_busq`dw_1 within w_minutas_detalle_lista
integer x = 18
integer y = 16
integer width = 3255
string dataobject = "d_minutas_lista"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event dw_1::constructor;call super::constructor;of_setRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)
// Column header sort
inv_sort.of_SetColumnHeader (true)
// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

event dw_1::clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked
//
//	Description:  DataWindow clicked
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0 	Added Linkage service notification
// 6.0 	Introduced non zero return value
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

//IF IsValid (inv_linkage) THEN
//	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
//		inv_linkage.CONTINUE_ACTION Then
//		// The user or a service action prevents from going to the clicked row.
//		Return 1
//	End If
//END IF

IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 

end event

event dw_1::doubleclicked;call super::doubleclicked;long linea
st_minutas_consulta minutas_consulta

// Decimos la accion a realizar
minutas_consulta.accion = 'CONSULTA'
minutas_consulta.id_minuta = this.getitemstring(row, 'id_minuta')
minutas_consulta.id_fase = this.getitemstring(row, 'id_fase')
minutas_consulta.modulo = 'AVISOS'

// Abrimos la ventana pasandole la estructura que contiene el identificador
openwithparm(w_minutas_detalle, minutas_consulta)
end event

type cb_anyadir from w_mant_busq`cb_anyadir within w_minutas_detalle_lista
boolean visible = false
integer y = 1000
end type

type cb_borrar from w_mant_busq`cb_borrar within w_minutas_detalle_lista
boolean visible = false
integer y = 1000
end type

type cb_ayuda from w_mant_busq`cb_ayuda within w_minutas_detalle_lista
boolean visible = false
integer y = 1000
end type

type st_1 from w_mant_busq`st_1 within w_minutas_detalle_lista
boolean visible = false
integer x = 55
integer y = 32
integer width = 256
integer height = 64
string text = "N$$HEX2$$ba002000$$ENDHEX$$Aviso:"
alignment alignment = right!
end type

type st_2 from w_mant_busq`st_2 within w_minutas_detalle_lista
boolean visible = false
end type

type sle_1 from w_mant_busq`sle_1 within w_minutas_detalle_lista
boolean visible = false
integer x = 311
integer y = 28
integer height = 72
end type

type sle_2 from w_mant_busq`sle_2 within w_minutas_detalle_lista
boolean visible = false
end type

type cb_buscar from w_mant_busq`cb_buscar within w_minutas_detalle_lista
boolean visible = false
integer y = 32
boolean default = true
end type

event cb_buscar::clicked;if (sle_1.text = '') then
	messagebox("B$$HEX1$$fa00$$ENDHEX$$squeda de datos","Debe especificar al menos un par$$HEX1$$e100$$ENDHEX$$metro de b$$HEX1$$fa00$$ENDHEX$$squeda",StopSign!)
	sle_1.SetFocus()
	return
end if

string sql,sql_original

sql = dw_1.GetSQLSelect()
sql_original = sql

sql = sql + 'and n_aviso = ~"' + sle_1.text + '~"'

dw_1.SetSQLSelect(sql)
dw_1.Retrieve()

dw_1.SetSQLSelect(sql_original)

end event

type dw_detalle from u_dw within w_minutas_detalle_lista
integer x = 18
integer y = 1048
integer width = 3255
integer height = 880
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_minutas_detalle_2"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;CHOOSE CASE g_colegio
	CASE 'COAATTFE', 'COAATZ', 'COAATGU', 'COAATLE'
		this.object.t_12.text = 'Cobro a Cuenta ..............................'
END CHOOSE
end event

type dw_facturas from u_dw within w_minutas_detalle_lista
integer x = 1888
integer y = 1936
integer width = 1390
integer height = 272
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_minutas_facturas_lista"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;call super::doubleclicked;if this.getrow() < 1 then return
//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
g_facturacion_emitida_consulta.id_factura = this.getitemstring(row,'id_factura')
message.stringparm = "w_facturacion_emitida_detalle"
w_aplic_frame.postevent("csd_facturacion_emitida_detalle")


end event

type dw_liquidaciones from u_dw within w_minutas_detalle_lista
integer x = 9
integer y = 1936
integer width = 1271
integer height = 272
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_minutas_liquidaciones"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_reclamaciones from u_dw within w_minutas_detalle_lista
integer x = 1285
integer y = 1936
integer width = 594
integer height = 272
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_minutas_reclamaciones"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

