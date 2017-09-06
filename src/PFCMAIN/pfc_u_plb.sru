HA$PBExportHeader$pfc_u_plb.sru
$PBExportComments$PFC PictureListBox class
forward
global type pfc_u_plb from picturelistbox
end type
end forward

global type pfc_u_plb from picturelistbox
int Width=347
int Height=248
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string PictureName[]={"Custom039!"}
long PictureMaskColor=553648127
event type integer pfc_selectall ( )
event type integer pfc_invertselection ( )
end type
global pfc_u_plb pfc_u_plb

forward prototypes
public function integer of_getparentwindow (ref window aw_parent)
public function integer of_getselected (ref n_cst_itemattrib anv_itemattrib[])
protected function integer of_messagebox (string as_id, string as_title, string as_text, icon ae_icon, button ae_button, integer ai_default)
end prototypes

event pfc_selectall;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_selecteall
//
//	(Arguments:		None)
//
//	(Returns:  		Integer
//						The number of selected rows.
//						0 - If this is not a valid operation.)
//
//	Description:	Select all the rows.
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

integer 	li_totalitems
long		ll_item

//Only a valid operation when MuliSelect is set to True.
If this.MultiSelect Then
	li_totalitems = this.TotalItems()
	//Loop through all items
	For ll_item = 1 to li_totalitems
		this.SetState(ll_item, True)
	Next
	//Number of selected items
	Return li_totalitems
End If

//Not a valid operation
Return 0
end event

event pfc_invertselection;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_invertselection
//
//	(Arguments:		None)
//
//	(Returns:  		Integer
//						The number of selected rows.
//						0 - If this is not a valid operation.)
//
//	Description:	Invert the rows.
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

integer 	li_totalitems
long		ll_item

//Only a valid operation when MuliSelect is set to True.
If this.MultiSelect Then
	li_totalitems = this.TotalItems()
	//Loop through all items - Inverting each item
	For ll_item = 1 to li_totalitems
		this.SetState(ll_item, (Not this.State(ll_item)=1) )
	Next
	//Number of selected items
	Return this.TotalSelected()
End If

//Not a valid operation
Return 0
end event

public function integer of_getparentwindow (ref window aw_parent);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetParentWindow
//
//	Access:  public
//
//	Arguments:
//	aw_parent   The Parent window for this object (passed by reference).
//	   If a parent window is not found, aw_parent is NULL
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:	 Calculates the parent window of a window object
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

powerobject	lpo_parent

lpo_parent = this.GetParent()

// Loop getting the parent of the object until it is of type window!
do while IsValid (lpo_parent) 
	if lpo_parent.TypeOf() <> window! then
		lpo_parent = lpo_parent.GetParent()
	else
		exit
	end if
loop

if IsNull(lpo_parent) Or not IsValid (lpo_parent) then
	setnull(aw_parent)	
	return -1
end If

aw_parent = lpo_parent
return 1

end function

public function integer of_getselected (ref n_cst_itemattrib anv_itemattrib[]);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetSelected
//
//	Access:  		public
//
//	Arguments:		
//	anv_itemattrib[]	NonVisual with an Index and a Text variable.
//
//	Returns:  		Integer
//						The number of selected entries.
//						0 - If this is not a valid operation.
//
//	Description:  	Populate the passed nonvisual object with all the selected
//						entries from this control.
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

integer 	li_totalitems
long		ll_item
integer	li_cnt=0

//Only a valid operation when MuliSelect is set to True.
If this.MultiSelect Then
	li_totalitems = this.TotalItems()
	//Loop through all items 
	For ll_item = 1 to li_totalitems
		If this.State(ll_item)=1 Then
			//Put this item into the NonVisual.
			li_cnt++
			anv_itemattrib[li_cnt].ii_index = ll_item
			anv_itemattrib[li_cnt].is_itemtext = this.Text(ll_item)
		End If
	Next
	//Number of selected items that were added.
	Return li_cnt
End If

//Not a valid operation
Return 0

end function

protected function integer of_messagebox (string as_id, string as_title, string as_text, icon ae_icon, button ae_button, integer ai_default);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_MessageBox
//
//	Access:  			protected
//
//	Arguments:
//	as_id			An ID for the Message.
//	as_title  	Text for title bar
//	as_text		Text for the actual message.
//	ae_icon 		The icon you want to display on the MessageBox.
//	ae_button	Set of CommandButtons you want to display on the MessageBox.
//	ai_default  The default button.
//
//	Returns:  integer
//	Return value of the MessageBox.
//
//	Description:
//	Display a PowerScript MessageBox.  
//	Allow PFC MessageBoxes to be manipulated prior to their actual display.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Return MessageBox(as_title, as_text, ae_icon, ae_button, ai_default)
end function

event getfocus;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			getfocus
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	If appropriate, notify the parent window that this
//						control got focus.
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

window 	lw_parent

//Check for microhelp requirements.
If gnv_app.of_GetMicrohelp() Then
	//Notify the parent.
	of_GetParentWindow(lw_parent)
	If IsValid(lw_parent) Then
		lw_parent.Dynamic Event pfc_ControlGotFocus (this)
	End If
End If

end event

