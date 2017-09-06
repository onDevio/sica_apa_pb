HA$PBExportHeader$pfc_w_filterextended.srw
$PBExportComments$PFC Extended Filter dialog window
forward
global type pfc_w_filterextended from w_response
end type
type cb_ok from u_cb within pfc_w_filterextended
end type
type cb_cancel from u_cb within pfc_w_filterextended
end type
type cb_verify from u_cb within pfc_w_filterextended
end type
type mle_filter from u_mle within pfc_w_filterextended
end type
type gb_2 from u_gb within pfc_w_filterextended
end type
type gb_1 from u_gb within pfc_w_filterextended
end type
type tab_1 from tab within pfc_w_filterextended
end type
type tabpg_functions from userobject within tab_1
end type
type dw_functioncategory from u_dw within tabpg_functions
end type
type dw_function from u_dw within tabpg_functions
end type
type gb_3 from u_gb within tabpg_functions
end type
type st_help from u_st within tabpg_functions
end type
type st_syntax from u_st within tabpg_functions
end type
type tabpg_columns from userobject within tab_1
end type
type dw_columns from u_dw within tabpg_columns
end type
type tabpg_operators from userobject within tab_1
end type
type lb_1 from u_lb within tabpg_operators
end type
type tabpg_values from userobject within tab_1
end type
type dw_values from u_dw within tabpg_values
end type
type cb_dlghelp from u_cb within pfc_w_filterextended
end type
type tabpg_functions from userobject within tab_1
dw_functioncategory dw_functioncategory
dw_function dw_function
gb_3 gb_3
st_help st_help
st_syntax st_syntax
end type
type tabpg_columns from userobject within tab_1
dw_columns dw_columns
end type
type tabpg_operators from userobject within tab_1
lb_1 lb_1
end type
type tabpg_values from userobject within tab_1
dw_values dw_values
end type
type tab_1 from tab within pfc_w_filterextended
tabpg_functions tabpg_functions
tabpg_columns tabpg_columns
tabpg_operators tabpg_operators
tabpg_values tabpg_values
end type
end forward

type os_column from structure
	string		s_colname
	string		s_colnamedisplay
	string		s_dbname
end type

global type pfc_w_filterextended from w_response
int X=768
int Y=404
int Width=2094
int Height=1664
boolean TitleBar=true
string Title="Filter"
long BackColor=80263328
event type integer pfc_verify ( )
cb_ok cb_ok
cb_cancel cb_cancel
cb_verify cb_verify
mle_filter mle_filter
gb_2 gb_2
gb_1 gb_1
tab_1 tab_1
cb_dlghelp cb_dlghelp
end type
global pfc_w_filterextended pfc_w_filterextended

type variables
Protected:
string		is_currentcolumn
n_cst_filterattrib	inv_filterattrib
n_cst_returnattrib	inv_return
end variables

event pfc_verify;call super::pfc_verify;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_verify
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = Filter is valid
//	-1 = Filter is not valid
//
//	Description:
//	Verifies current filter
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

integer	li_rc = 1
string		ls_testfilter
datastore	lds_test

ls_testfilter = mle_filter.text

if LenA (ls_testfilter) > 0 then
	lds_test = create datastore

	// Associate the correct dataobject to the test-filter datastore
	lds_test.dataobject = inv_filterattrib.idw_dw.dataobject

	// Test the filter
	li_rc = lds_test.SetFilter (ls_testfilter)

	destroy lds_test
end if

return li_rc
end event

event open;call super::open;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  open
//
//	Description:
//	Initialize window
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

integer	li_upper
integer	li_cnt
string	ls_filter
os_column	lstr_column[]
n_cst_string lnv_string

SetPointer (HourGlass!)
tab_1.tabpg_functions.gb_3.SetPosition (tobottom!)

inv_filterattrib = Message.PowerObjectParm

// Allow window to close without the CloseQuery checks being performed
ib_disableclosequery = true

// Start the base window service
this.of_SetBase (true)

// Center this window.
inv_base.of_Center()

// Display original filter in the filter mle.
ls_filter = inv_filterattrib.is_filter
If PosA(ls_filter, "~~~~'") > 0 And  PosA(ls_filter, "~~~~~~'") = 0 Then
	ls_filter = lnv_string.of_GlobalReplace(ls_filter, "~~~~'", "~~'")	
End If
mle_filter.text = ls_filter
mle_filter.SelectText (1, LenA (mle_filter.text))
mle_filter.SetFocus() 

// Display initial function categories
if tab_1.tabpg_functions.dw_functioncategory.RowCount() > 0 then
	tab_1.tabpg_functions.dw_functioncategory.SetRow (1)
	tab_1.tabpg_functions.dw_functioncategory.event rowfocuschanged (1)
	tab_1.tabpg_functions.dw_functioncategory.SelectRow (1, true)
end if

// Populate columns tabpage
li_upper = UpperBound (inv_filterattrib.is_columns)
for li_cnt = 1 to li_upper
	lstr_column[li_cnt].s_colname = inv_filterattrib.is_columns[li_cnt]
	lstr_column[li_cnt].s_colnamedisplay = inv_filterattrib.is_colnamedisplay[li_cnt]
	lstr_column[li_cnt].s_dbname = inv_filterattrib.is_dbnames[li_cnt]
next
tab_1.tabpg_columns.dw_columns.object.data = lstr_column
if tab_1.tabpg_columns.dw_columns.RowCount() > 0 then
	tab_1.tabpg_columns.dw_columns.SetRow (1)
	tab_1.tabpg_columns.dw_columns.event rowfocuschanged (1)
	tab_1.tabpg_columns.dw_columns.SelectRow (1, true)
end if
end event

on pfc_w_filterextended.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cb_verify=create cb_verify
this.mle_filter=create mle_filter
this.gb_2=create gb_2
this.gb_1=create gb_1
this.tab_1=create tab_1
this.cb_dlghelp=create cb_dlghelp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_verify
this.Control[iCurrent+4]=this.mle_filter
this.Control[iCurrent+5]=this.gb_2
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.tab_1
this.Control[iCurrent+8]=this.cb_dlghelp
end on

on pfc_w_filterextended.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cb_verify)
destroy(this.mle_filter)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.tab_1)
destroy(this.cb_dlghelp)
end on

event close;call super::close;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  close
//
//	Description:
//	Check for cancel operation
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
// then window is currently being closed as a cancel operation.
if inv_return.ii_rc=-99 then
	this.event pfc_cancel ()
end if
end event

event pfc_cancel;call super::pfc_cancel;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_Cancel
//
//	Description:
//	Set to the appropriate return code and close the dialog.
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
inv_return.ii_rc = 0

// Clear the sort string.
inv_return.is_rs = ""

// Close the window.
CloseWithReturn (this, inv_return)
end event

event pfc_default;call super::pfc_default;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_default
//
//	Description:
//	Construct the new filter string
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

// Verify that filter is valid
if this.event pfc_verify() = -1 then
	of_MessageBox ("pfc_filterextended_modifyfilter", "Filter", &
		"Filter is not valid.  Please modify the filter using the available " + &
		"functions, columns, operators, and values.  The Verify button may be "+&
		"used to determine if the filter is valid.", &
		Information!, OK!, 1)
	return
end if

// Set the return code to mean succesful operation
inv_return.ii_rc = 1

// Set the new filter string
inv_return.is_rs = mle_filter.text

// Close the window.
CloseWithReturn (this, inv_return)

end event

type cb_ok from u_cb within pfc_w_filterextended
int X=914
int Y=1444
int TabOrder=40
string Text="OK"
boolean Default=true
end type

event clicked;call u_cb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			Clicked!
//
//	Description:  	Perform the OK window process.
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

Parent.Event pfc_default()

end event

type cb_cancel from u_cb within pfc_w_filterextended
int X=1294
int Y=1444
int TabOrder=50
string Text="Cancel"
boolean Cancel=true
end type

event clicked;call u_cb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			Clicked!
//
//	Description:  	Perform the window Cancel operation.
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

Parent.Event pfc_Cancel ()

end event

type cb_verify from u_cb within pfc_w_filterextended
int X=1637
int Y=96
int TabOrder=20
string Text="&Verify"
boolean Cancel=true
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//
//	Description:
//	Verifies that current filter is valid
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

integer	li_rc

li_rc = parent.event pfc_verify()
if li_rc = 1 then
	of_MessageBox ("pfc_filterextended_validverify", "Filter", "Filter is valid", &
		Information!, OK!, 1)
else
	of_MessageBox ("pfc_filterextended_failedverify", "Filter", "Filter is not valid", &
		Information!, OK!, 1)	
end if
end event

type mle_filter from u_mle within pfc_w_filterextended
int X=82
int Y=96
int Width=1518
int Height=244
int TabOrder=10
boolean HideSelection=false
int Accelerator=102
long TextColor=33554687
long BackColor=1086381248
end type

type gb_2 from u_gb within pfc_w_filterextended
int X=27
int Y=428
int Width=1998
int Height=992
int TabOrder=0
string Text="Build filter with"
end type

type gb_1 from u_gb within pfc_w_filterextended
int X=27
int Y=16
int Width=1998
int Height=368
int TabOrder=0
string Text="&Filter expression"
end type

type tab_1 from tab within pfc_w_filterextended
int X=69
int Y=508
int Width=1902
int Height=884
int TabOrder=30
boolean BringToTop=true
boolean ShowPicture=false
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpg_functions tabpg_functions
tabpg_columns tabpg_columns
tabpg_operators tabpg_operators
tabpg_values tabpg_values
end type

on tab_1.create
this.tabpg_functions=create tabpg_functions
this.tabpg_columns=create tabpg_columns
this.tabpg_operators=create tabpg_operators
this.tabpg_values=create tabpg_values
this.Control[]={this.tabpg_functions,&
this.tabpg_columns,&
this.tabpg_operators,&
this.tabpg_values}
end on

on tab_1.destroy
destroy(this.tabpg_functions)
destroy(this.tabpg_columns)
destroy(this.tabpg_operators)
destroy(this.tabpg_values)
end on

event selectionchanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  selectionchanged
//
//	Description:
//	Populate values DW for current column
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.03	Radiobutton and checkbox edit styles should only display data values
//	5.0.03	Do not display dropdown arrows, spin controls
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

constant string	WHITE = "16777215"
boolean	lb_radiobuttons
integer	li_selectedrow
long		ll_pos
long		ll_temp
long		ll_editstyle
long		ll_start
long		ll_end
long		ll_height
long		ll_column
string		ls_col
string		ls_presentation
string		ls_syntax
string		ls_errbuffer
string		ls_dbname
string		ls_table
string		ls_sql
string		ls_editstyle
string		ls_replacesyntax
n_cst_string	lnv_string

// Check for values tabpage
if newindex <> 4 then
	return
end if	

// Check for valid trans object before values can be populated
if not IsValid (inv_filterattrib.idw_dw.itr_object) or IsNull (inv_filterattrib.idw_dw.itr_object) then
	return
end if
if not inv_filterattrib.idw_dw.itr_object.of_IsConnected() then
	return
end if

// Populate values based on current column
li_selectedrow = this.tabpg_columns.dw_columns.GetSelectedRow (0)
if li_selectedrow > 0 then
	ls_col = this.tabpg_columns.dw_columns.object.columnname[li_selectedrow]
	if ls_col <> is_currentcolumn then
		// Table and column
		ls_dbname = this.tabpg_columns.dw_columns.object.db_name[li_selectedrow]
		ll_pos = PosA (ls_dbname, ".")
		ls_table = LeftA (ls_dbname, ll_pos - 1)
		if ls_table = "" or ls_dbname = "" then
			this.tabpg_values.dw_values.dataobject = ""
			is_currentcolumn = ""
			return
		end if

		// SQL
		ls_sql = "select distinct " + ls_dbname + " from " + ls_table

		// Default presentation
		ls_presentation = "DataWindow (color=" + WHITE + ") " + &
			"Column (background.mode=1 border=0 color=0 edit.displayonly='yes' edit.focusrectangle='no' " + &
			"font.face='MS Sans Serif' font.height='-8' font.weight=400 font.family=2 font.pitch=2 font.charset=0) " + &
			"Text (alignment=0 border=0 color=0 background.mode=1 " + &
			"font.face='MS Sans Serif' font.height='-8' font.weight=400 font.family=2 font.pitch=2 font.charset=0) " + &
			"Style (Header_Bottom_Margin=0 Header_Top_Margin=0 Report='yes')"

		// Build syntax from sql and create DW
		ls_syntax = inv_filterattrib.idw_dw.itr_object.SyntaxFromSQL (ls_sql, ls_presentation, ls_errbuffer)

		// Do not allow checkbox and radiobuttons edit styles (replace with edit editstyle)
		ls_replacesyntax = " edit.limit=0 edit.autoselect=no edit.autohscroll=yes edit.autovscroll=no edit.focusrectangle=no "
		ll_editstyle = PosA (ls_syntax, "checkbox.on=")
		if ll_editstyle = 0 then
			ll_editstyle = PosA (ls_syntax, "radiobuttons.columns=")
			lb_radiobuttons = true
		end if
		if ll_editstyle > 0 then
			ll_temp = PosA (ls_syntax, "width=")
			if ll_temp > 0 then
				// For radiobuttons - first modify the height of the column
				if lb_radiobuttons then
					ll_height = lnv_string.of_LastPos (ls_syntax, "height", ll_temp)
					if ll_height > 0 then
						ls_syntax = LeftA (ls_syntax, ll_height - 1) + ' height="61" ' + MidA (ls_syntax, ll_temp)
						// Now modify the detail height
						ll_height = PosA (ls_syntax, "detail(height=")
						ll_column = PosA (ls_syntax, "column", ll_height)
						if ll_height > 0 and ll_column > 0 then
							ls_syntax = LeftA (ls_syntax, ll_height - 1) + ' detail(height=75) ' + MidA (ls_syntax, ll_column)
						end if
						ll_temp = PosA (ls_syntax, "width=")
					end if
				end if

				// Now change radiobutton & checkbox edit styles to edit edit styles
				ll_temp = PosA (ls_syntax, " ", ll_temp)
				if ll_temp > 0 then
					ll_start = ll_temp - 1
					ll_temp = PosA (ls_syntax, "alignment=", ll_start)
					if ll_temp > 0 then
						ll_end = ll_temp - 1
						ls_syntax = LeftA (ls_syntax, ll_start) + ls_replacesyntax + MidA (ls_syntax, ll_end)
					end if
				end if
			end if
		end if
		
		if LenA (ls_syntax) > 0 then
			if this.tabpg_values.dw_values.Create (ls_syntax, ls_errbuffer) = 1 then
				
				ls_editstyle = this.tabpg_values.dw_values.Describe ("#1.edit.style")

				// DDDW & DDLB edit styles should not always display arrow for dropdown
				if ls_editstyle = "dddw" or ls_editstyle = "ddlb" then
					this.tabpg_values.dw_values.Modify ("#1." + ls_editstyle + ".UseAsBorder=no")
				end if
				
				// Editmasks should not show spin control
				if ls_editstyle = "editmask" then
					this.tabpg_values.dw_values.Modify ("#1.editmask.spin=no")
				end if
				
				this.tabpg_values.dw_values.SetSort ("#1 A")
				this.tabpg_values.dw_values.Modify ("#1.protect=1")
				this.tabpg_values.dw_values.SetTransObject (inv_filterattrib.idw_dw.itr_object)
				this.tabpg_values.dw_values.Retrieve()
				is_currentcolumn = ls_col
			end if
		else
			this.tabpg_values.dw_values.dataobject = ""
			is_currentcolumn = ""
		end if
	end if
else
	this.tabpg_values.dw_values.dataobject = ""
	is_currentcolumn = ""
end if

end event

type tabpg_functions from userobject within tab_1
int X=18
int Y=100
int Width=1865
int Height=768
long BackColor=79741120
string Text="Functions"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_functioncategory dw_functioncategory
dw_function dw_function
gb_3 gb_3
st_help st_help
st_syntax st_syntax
end type

on tabpg_functions.create
this.dw_functioncategory=create dw_functioncategory
this.dw_function=create dw_function
this.gb_3=create gb_3
this.st_help=create st_help
this.st_syntax=create st_syntax
this.Control[]={this.dw_functioncategory,&
this.dw_function,&
this.gb_3,&
this.st_help,&
this.st_syntax}
end on

on tabpg_functions.destroy
destroy(this.dw_functioncategory)
destroy(this.dw_function)
destroy(this.gb_3)
destroy(this.st_help)
destroy(this.st_syntax)
end on

type dw_functioncategory from u_dw within tabpg_functions
int X=18
int Y=28
int Width=654
int Height=408
int TabOrder=2
string DataObject="d_dwfunctioncategory"
boolean VScrollBar=false
boolean LiveScroll=false
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  constructor
//
//	Description:
//	Initialize control
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

of_SetRowSelect (true)
ib_rmbmenu = false
end event

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  rowfocuschanged
//
//	Description:
//	Filter functions to the correct category
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

string	ls_category

if currentrow > 0 then
	inv_rowselect.of_RowSelect (currentrow)

	ls_category = GetItemString (currentrow, "category")
	dw_function.SetFilter ("category = '" + ls_category + "'")
	dw_function.Filter()
	if dw_function.RowCount() > 0 then
		dw_function.SetRow (1)
		dw_function.event rowfocuschanged (1)
	end if
end if
end event

type dw_function from u_dw within tabpg_functions
int X=713
int Y=28
int Width=1115
int Height=412
int TabOrder=2
string DataObject="d_dwfunction"
end type

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  rowfocuschanged
//
//	Description:
//	Update syntax and help for the current function
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

string	ls_syntax
string	ls_help

if currentrow > 0 then
	inv_rowselect.of_RowSelect (currentrow)

	ls_syntax = this.GetItemString (currentrow, "syntax")
	ls_help = this.GetItemString (currentrow, "help")

	st_syntax.text = ls_syntax
	st_help.text = ls_help
end if
end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  constructor
//
//	Description:
//	Initialize control
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

of_SetRowSelect (true)
ib_rmbmenu = false
end event

event doubleclicked;call super::doubleclicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  doubleclicked
//
//	Description:
//	Pastes the clicked function syntax into the filter expression
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

integer	li_position
long		ll_pos
long		ll_pos2
string		ls_syntax

if row > 0 then
	ls_syntax = this.object.syntax[row]
	li_position = mle_filter.Position()
	mle_filter.ReplaceText (ls_syntax)

	// Select expression between parenthesis
	if li_position > 0 then
		ll_pos = PosA (mle_filter.text, "(", li_position)
		if ll_pos > 0 then
			ll_pos2 = PosA (mle_filter.text, ")", li_position)
			if ll_pos2 > 0 then
				mle_filter.SelectText (ll_pos + 1, ll_pos2 - ll_pos - 1)
			end if
		end if
	end if	
end if
end event

type gb_3 from u_gb within tabpg_functions
int X=18
int Y=448
int Width=1815
int Height=308
int TabOrder=2
string Text="Syntax"
end type

type st_help from u_st within tabpg_functions
int X=46
int Y=584
int Width=1765
int Height=156
boolean BringToTop=true
end type

type st_syntax from u_st within tabpg_functions
int X=46
int Y=508
int Width=1765
long BackColor=79741120
int Weight=700
end type

type tabpg_columns from userobject within tab_1
int X=18
int Y=100
int Width=1865
int Height=768
long BackColor=79741120
string Text="Columns"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_columns dw_columns
end type

on tabpg_columns.create
this.dw_columns=create dw_columns
this.Control[]={this.dw_columns}
end on

on tabpg_columns.destroy
destroy(this.dw_columns)
end on

type dw_columns from u_dw within tabpg_columns
int X=32
int Y=56
int Width=896
int Height=684
int TabOrder=2
string DataObject="d_columnnames"
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  constructor
//
//	Description:
//	Initialize control
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

of_SetRowSelect (true)
ib_rmbmenu = false
end event

event doubleclicked;call super::doubleclicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  doubleclicked
//
//	Description:
//	Pastes the clicked columnname into the filter expression
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

string	ls_colname

if row > 0 then
	ls_colname = this.object.columnname[row]
	mle_filter.ReplaceText (ls_colname)
end if
end event

type tabpg_operators from userobject within tab_1
int X=18
int Y=100
int Width=1865
int Height=768
long BackColor=79741120
string Text="Operators"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
lb_1 lb_1
end type

on tabpg_operators.create
this.lb_1=create lb_1
this.Control[]={this.lb_1}
end on

on tabpg_operators.destroy
destroy(this.lb_1)
end on

type lb_1 from u_lb within tabpg_operators
int X=32
int Y=52
int Width=521
int Height=692
int TabOrder=2
string Item[]={"=",&
"<",&
">",&
"<=",&
">=",&
"and",&
"or",&
"not",&
"(",&
")"}
end type

event doubleclicked;call super::doubleclicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  doubleclicked
//
//	Description:
//	Pastes the clicked operator into the filter expression
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

string	ls_selecteditem

ls_selecteditem = this.SelectedItem()
mle_filter.ReplaceText (" " + ls_selecteditem + " ")

end event

type tabpg_values from userobject within tab_1
int X=18
int Y=100
int Width=1865
int Height=768
long BackColor=79741120
string Text="Values"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_values dw_values
end type

on tabpg_values.create
this.dw_values=create dw_values
this.Control[]={this.dw_values}
end on

on tabpg_values.destroy
destroy(this.dw_values)
end on

type dw_values from u_dw within tabpg_values
int X=32
int Y=56
int Width=896
int Height=684
int TabOrder=2
end type

event doubleclicked;call super::doubleclicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  doubleclicked
//
//	Description:
//	Pastes the clicked columnname into the filter expression
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.03 Corrected to check/build for all column types.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

any		la_val
string	ls_value
string	ls_coltype
string	ls_expression
n_cst_string lnv_string

if row > 0 then
	// Get the column type.
	ls_coltype = LeftA(this.Describe ( "#1.ColType" ), 5)
	
	// Get the value.
	la_val = inv_rowselect.of_GetItemAny (row, 1)
	ls_value = String (la_val)

	// Determine the correct expression.
	Choose Case ls_coltype
		// CHARACTER DATATYPE		
		Case "char("	
			If PosA(ls_value, '~~~"') =0 And PosA(ls_value, "~~~'") =0 Then
				// No special characters found.
				If PosA(ls_value, "'") >0 Then
					// Replace single quotes with special chars single quotes.
					ls_value = lnv_string.of_GlobalReplace(ls_value, "'", "~~~'")				
				End If
			End If
			ls_expression = "'" + ls_value + "'"
	
		// DATE DATATYPE	
		Case "date"
			ls_expression = "Date('" + ls_value  + "')" 

		// DATETIME DATATYPE
		Case "datet"				
			ls_expression = "DateTime('" + ls_value + "')" 

		// TIME DATATYPE
		Case "time", "times"		
			ls_expression = "Time('" + ls_value + "')" 
	
		// NUMBER
		Case 	Else
			ls_expression = ls_value
	End Choose	
	
	mle_filter.ReplaceText (ls_expression)
end if


end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  constructor
//
//	Description:
//	Initialize control
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

of_SetRowSelect (true)
ib_rmbmenu = false
end event

type cb_dlghelp from u_cb within pfc_w_filterextended
int X=1673
int Y=1444
int TabOrder=60
string Text="&Help"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	clicked
//
//	Description:
//	Display PFC dialog help
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

showHelp ("pfcdlg.hlp", topic!, 100)
end event

