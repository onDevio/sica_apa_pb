HA$PBExportHeader$w_caja_salidas_listado.srw
forward
global type w_caja_salidas_listado from w_preview
end type
end forward

global type w_caja_salidas_listado from w_preview
windowstate windowstate = maximized!
end type
global w_caja_salidas_listado w_caja_salidas_listado

on w_caja_salidas_listado.create
call super::create
end on

on w_caja_salidas_listado.destroy
call super::destroy
end on

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


of_SetResize (true)
inv_resize.of_Register (dw_1, "ScaleToRight&Bottom")
inv_resize.of_Register (cb_1, "FixedtoBottom")
inv_resize.of_Register (cb_2, "FixedtoRight&Bottom")

st_caja_salidas datos

datos = message.powerObjectParm

choose case datos.listado
	case 'C'
		dw_1.dataobject='d_caja_salidas_list_cuadre'
	case 'M'
		dw_1.dataobject='d_caja_salidas_list_movimientos_caja'		
end choose 
dw_1.SetTransObject(SQLCA)
dw_1.Retrieve(datos.fecha,datos.centro)

if datos.listado='C' then
	Datawindowchild dwc_fact_visados,dwc_fact_no_visados,dwc_ing_ret,dwc_salidas,dwc_saldo
	
	dw_1.GetChild('dw_facturas_visados',dwc_fact_visados)
	dw_1.GetChild('dw_facturas_no_visados',dwc_fact_no_visados)
	dw_1.GetChild('dw_ingresa_retira',dwc_ing_ret)
	dw_1.GetChild('dw_salidas',dwc_salidas)
	dw_1.GetChild('dw_saldo',dwc_saldo)
	
	double ent,sal,iva,irpf
	
	ent = 0
	sal = 0
	iva = 0
	irpf = 0
	
	if dwc_fact_visados.RowCount() > 0 then
		ent += dwc_fact_visados.GetItemNumber(dwc_fact_visados.RowCount(),'totalizado_base_imponible')
		iva += dwc_fact_visados.GetItemNumber(dwc_fact_visados.RowCount(),'totalizado_iva')
		irpf += dwc_fact_visados.GetItemNumber(dwc_fact_visados.RowCount(),'totalizado_irpf')
	end if
	
	if dwc_fact_no_visados.RowCount() > 0 then
		ent += dwc_fact_no_visados.GetItemNumber(dwc_fact_no_visados.RowCount(),'totalizado_base_imponible')
		iva += dwc_fact_no_visados.GetItemNumber(dwc_fact_no_visados.RowCount(),'totalizado_iva')
		irpf += dwc_fact_no_visados.GetItemNumber(dwc_fact_no_visados.RowCount(),'totalizado_irpf')
	end if
	
	if dwc_ing_ret.RowCount() > 0 then
		ent += dwc_ing_ret.GetItemNumber(dwc_ing_ret.RowCount(),'totalizado_base_imponible')
	end if
	
	if dwc_salidas.RowCount() > 0 then
		sal += dwc_salidas.GetItemNumber(dwc_salidas.RowCount(),'totalizado_importe')
	end if
	
	dwc_saldo.InsertRow(0)
	dwc_saldo.SetItem(1,'saldo_entradas',ent)
	dwc_saldo.SetItem(1,'saldo_salidas',sal)
	dwc_saldo.SetItem(1,'saldo_iva',iva)
	dwc_saldo.SetItem(1,'saldo_irpf',irpf)
end if
end event

type cb_recuperar_pantalla from w_preview`cb_recuperar_pantalla within w_caja_salidas_listado
end type

type cb_guardar_pantalla from w_preview`cb_guardar_pantalla within w_caja_salidas_listado
end type

type dw_1 from w_preview`dw_1 within w_caja_salidas_listado
string dataobject = "d_caja_salidas_list_cuadre"
end type

type cb_1 from w_preview`cb_1 within w_caja_salidas_listado
end type

type cb_2 from w_preview`cb_2 within w_caja_salidas_listado
end type

