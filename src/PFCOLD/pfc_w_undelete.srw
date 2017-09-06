HA$PBExportHeader$pfc_w_undelete.srw
$PBExportComments$PFC Display Delete Buffer dialog window
forward
global type pfc_w_undelete from w_response
end type
type dw_delete from u_dw within pfc_w_undelete
end type
type cb_ok from u_cb within pfc_w_undelete
end type
type cb_cancel from u_cb within pfc_w_undelete
end type
type cb_selectall from u_cb within pfc_w_undelete
end type
type cb_invertselection from u_cb within pfc_w_undelete
end type
end forward

global type pfc_w_undelete from w_response
int X=1202
int Y=634
int Width=1249
int Height=717
boolean TitleBar=true
string Title="Restore"
dw_delete dw_delete
cb_ok cb_ok
cb_cancel cb_cancel
cb_selectall cb_selectall
cb_invertselection cb_invertselection
end type
global pfc_w_undelete pfc_w_undelete

type variables
Protected:
integer	ii_dwmaxwidth = 1451
integer	ii_dwmaxheight = 1168
integer	ii_dwminwidth = 729
integer	ii_dwminheight = 564
integer	il_rc = -99
long	il_restored
u_dw	idw_parm
end variables

event open;call w_response::open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  pfc_w_undelete
//
//	Description:  Allows deleted rows to be restored to the primary buffer
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

long	ll_rowcount
long	ll_width
long	ll_height

SetPointer (hourglass!)

ib_disableclosequery = true

// Set dataobject
idw_parm = message.powerobjectparm
dw_delete.dataobject = idw_parm.dataobject
dw_delete.Reset()

// Protect columns
dw_delete.inv_rowselect.of_Modify ("protect", "1", "column", "*", true)

// Copy the rows in the delete buffer to the DW control
idw_parm.RowsCopy (1, idw_parm.DeletedCount (), delete!, dw_delete, 1, primary!)

ll_rowcount = dw_delete.RowCount()
if ll_rowcount > 0 then
	// Register controls for resize window service
	of_SetResize (true)
	inv_resize.of_Register (dw_delete, "ScaleToRight&Bottom")
	inv_resize.of_Register (cb_ok, "FixedToRight")
	inv_resize.of_Register (cb_cancel, "FixedToRight")
	inv_resize.of_Register (cb_invertselection, "FixedToRight")
	inv_resize.of_Register (cb_selectall, "FixedToRight")

	// Resize DW according to DW object passed in
	ll_width = dw_delete.inv_rowselect.of_GetWidth()
	ll_width = Min (ii_dwmaxwidth, ll_width)
	if ll_width = ii_dwmaxwidth then
		dw_delete.hscrollbar = true
	end if
	ll_width = Max (ii_dwminwidth, ll_width) 

	ll_height = dw_delete.inv_rowselect.of_GetHeight()
	ll_height = Min (ii_dwmaxheight, ll_height)
	ll_height = Max (ii_dwminheight, ll_height)

	Resize (this.width + (ll_width - dw_delete.width), this.height + (ll_height - dw_delete.height))

	cb_selectall.enabled = true
	cb_invertselection.enabled = true
else
	cb_ok.enabled = false
	cb_invertselection.enabled = false
	cb_selectall.enabled = false
end if

end event

on pfc_w_undelete.create
int iCurrent
call w_response::create
this.dw_delete=create dw_delete
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cb_selectall=create cb_selectall
this.cb_invertselection=create cb_invertselection
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_delete
this.Control[iCurrent+2]=cb_ok
this.Control[iCurrent+3]=cb_cancel
this.Control[iCurrent+4]=cb_selectall
this.Control[iCurrent+5]=cb_invertselection
end on

on pfc_w_undelete.destroy
call w_response::destroy
destroy(this.dw_delete)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cb_selectall)
destroy(this.cb_invertselection)
end on

event pfc_default;call super::pfc_default;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_default
//
//	Description:  Restore selected rows to the primary buffer
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

long	ll_selectedrow
long	ll_row
long	ll_focusrow

SetPointer (hourglass!) 

// Move selected rows from delete to primary buffer
ll_selectedrow = dw_delete.GetSelectedRow (0)
ll_row = ll_selectedrow
do while ll_selectedrow > 0 
	if idw_parm.RowsMove (ll_row, ll_row, delete!, idw_parm, idw_parm.RowCount() + 1 , primary!) = 1 then
		il_restored++
		ll_selectedrow = dw_delete.GetSelectedRow (ll_selectedrow)
		ll_row = ll_selectedrow - il_restored
	else
		exit
	end if
loop

// Scroll to first restored row
ll_focusrow = idw_parm.RowCount() - il_restored + 1
idw_parm.ScrolltoRow (ll_focusrow) 
idw_parm.SetRow (ll_focusrow)

// Return the number of rows restored
il_rc = il_restored
CloseWithReturn (this, il_rc) 

end event

event pfc_cancel;call super::pfc_cancel;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_Cancel
//
//	Arguments:  none
//
//	Returns:  none
//
//	Description:
//	Set the return code to 0 (cancel)
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

// Set the return code to mean the window was closed by a cancel operation.
il_rc = 0
CloseWithReturn (this, il_rc)
end event

event close;call super::close;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  close
//
//	Description:
//	Treat window close from control menu as cancel operation
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

// If the return code matches the default value,
// then window is currently being closed as a Cancel operation.
if il_rc=-99 then
	this.event pfc_cancel ()
end if
end event

type dw_delete from u_dw within pfc_w_undelete
int X=43
int Y=36
int Width=729
int Height=564
int TabOrder=10
end type

event constructor;call u_dw::constructor;// Extended select
of_SetRowselect (true)
inv_rowselect.of_SetStyle (2)

// DW is not updateable
of_SetUpdateable (false)

// No RMB support
ib_rmbmenu = false
end event

event clicked;call u_dw::clicked;// Enable OK button if any rows are selected
if this.GetSelectedRow (0) > 0 then
	cb_ok.enabled = true
else
	cb_ok.enabled = false
end if
end event

type cb_ok from u_cb within pfc_w_undelete
int X=822
int Y=39
int Width=374
int TabOrder=20
boolean Enabled=false
string Text="OK"
boolean Default=true
end type

event clicked;call u_cb::clicked;parent.event pfc_default()
end event

type cb_cancel from u_cb within pfc_w_undelete
int X=822
int Y=151
int Width=374
int TabOrder=30
string Text="Cancel"
end type

event clicked;call u_cb::clicked;parent.event pfc_cancel()
end event

type cb_selectall from u_cb within pfc_w_undelete
int X=822
int Y=282
int Width=374
int TabOrder=40
boolean Enabled=false
string Text="Select &All"
end type

event clicked;call u_cb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//
//	Description:  Select all rows
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

// Select all rows
dw_delete.SelectRow (0, true) 

// Enabled command buttons
if dw_delete.GetSelectedRow (0) > 0 then
	cb_ok.enabled = true
else
	cb_ok.enabled = false
end if
end event

type cb_invertselection from u_cb within pfc_w_undelete
int X=822
int Y=391
int Width=374
int TabOrder=50
boolean Enabled=false
string Text="&Invert Selection"
end type

event clicked;call u_cb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//
//	Description:  Invert row selection
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

// Invert row selections
dw_delete.inv_rowselect.of_InvertSelection()

// Enabled command buttons
if dw_delete.GetSelectedRow (0) > 0 then
	cb_ok.enabled = true
else
	cb_ok.enabled = false
end if
end event

