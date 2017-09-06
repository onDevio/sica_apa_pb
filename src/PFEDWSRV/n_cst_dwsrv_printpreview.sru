HA$PBExportHeader$n_cst_dwsrv_printpreview.sru
$PBExportComments$Extension DataWindow  PrintPreview service
forward
global type n_cst_dwsrv_printpreview from pfc_n_cst_dwsrv_printpreview
end type
end forward

global type n_cst_dwsrv_printpreview from pfc_n_cst_dwsrv_printpreview
end type
global n_cst_dwsrv_printpreview n_cst_dwsrv_printpreview

forward prototypes
public function integer of_setscale ()
end prototypes

public function integer of_setscale ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetScale
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  integer
//	 Zoom level that the user selected
//	 0 = User cancelled from zoom dialog
//	-1 = error
//
//	Description:  Sets the zoom level of print preview
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_zoom
n_cst_zoomattrib	lnv_zoomattrib

if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	return -1
end if

lnv_zoomattrib.idw_obj = idw_requestor
lnv_zoomattrib.ii_zoom = of_GetZoom()
if lnv_zoomattrib.ii_zoom = -1 then
	return -1
end if

OpenWithParm (w_escala_impresion_dw, lnv_zoomattrib)
li_zoom = message.DoubleParm
return li_zoom
end function

on n_cst_dwsrv_printpreview.create
call super::create
end on

on n_cst_dwsrv_printpreview.destroy
call super::destroy
end on

