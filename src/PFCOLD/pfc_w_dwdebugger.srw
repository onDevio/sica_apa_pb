HA$PBExportHeader$pfc_w_dwdebugger.srw
$PBExportComments$PFC DataWindow Debugger dialog
forward
global type pfc_w_dwdebugger from w_response
end type
type st_zoom from u_st within pfc_w_dwdebugger
end type
type dw_status from u_dw within pfc_w_dwdebugger
end type
type dw_debug from u_dw within pfc_w_dwdebugger
end type
type dw_attributes from u_dw within pfc_w_dwdebugger
end type
type rb_original from u_rb within pfc_w_dwdebugger
end type
type rb_all from u_rb within pfc_w_dwdebugger
end type
type gb_display from u_gb within pfc_w_dwdebugger
end type
type rb_deleted from u_rb within pfc_w_dwdebugger
end type
type rb_filtered from u_rb within pfc_w_dwdebugger
end type
type rb_primary from u_rb within pfc_w_dwdebugger
end type
type gb_buffer from u_gb within pfc_w_dwdebugger
end type
type cb_delete from u_cb within pfc_w_dwdebugger
end type
type cb_undelete from u_cb within pfc_w_dwdebugger
end type
type cb_close from u_cb within pfc_w_dwdebugger
end type
type em_zoom from u_em within pfc_w_dwdebugger
end type
type cb_sort from u_cb within pfc_w_dwdebugger
end type
type cb_filter from u_cb within pfc_w_dwdebugger
end type
end forward

global type pfc_w_dwdebugger from w_response
int Width=2565
int Height=1424
boolean TitleBar=true
string Title="PFC DataWindow Debugger"
long BackColor=80263581
st_zoom st_zoom
dw_status dw_status
dw_debug dw_debug
dw_attributes dw_attributes
rb_original rb_original
rb_all rb_all
gb_display gb_display
rb_deleted rb_deleted
rb_filtered rb_filtered
rb_primary rb_primary
gb_buffer gb_buffer
cb_delete cb_delete
cb_undelete cb_undelete
cb_close cb_close
em_zoom em_zoom
cb_sort cb_sort
cb_filter cb_filter
end type
global pfc_w_dwdebugger pfc_w_dwdebugger

type variables
private:
datawindow idw_remote
transaction itr_connect
string is_current_object,is_current_column
dwbuffer i_current_buffer = Primary!
long il_current_row
boolean ib_critical_section = false
n_cst_string invo_string
end variables

forward prototypes
protected function boolean of_dw_info ()
protected subroutine of_error ()
protected function boolean of_get_attributes (string as_object)
protected function boolean of_show_buffer (dwbuffer a_buff)
protected function dwitemstatus of_textitemstatus (string as_stat)
protected function string of_itemstatustext (dwitemstatus a_stat)
end prototypes

protected function boolean of_dw_info ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_dw_info
//
//	Access:  protected
//
//	Arguments : None
//
//	Returns:	Boolean ; Returns false if the idw_remote is no longer valid otherwise true
//
//	Description:  Describes the information about the current row/column
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.04 Check for a valid current column.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_row,ll_cnt
string ls_curr_col
dwitemstatus l_stat

if ib_critical_section then return true // prevent recursion

if IsNull(idw_remote) Or not isvalid(idw_remote) then 
	of_error()
	return false
end if

ll_row = dw_debug.getrow() // get the current row
if ll_row < 0 then return true

if rb_deleted.checked then of_show_buffer(delete!)
if rb_filtered.checked then of_show_buffer(filter!)

ls_curr_col =  dw_debug.getcolumnname()
if ls_curr_col  <> '' then is_current_column = ls_curr_col 
If IsNull(is_current_column) Or LenA(is_current_column) = 0 Then Return True

dw_status.object.current_col[1]= is_current_column + ' : '+idw_remote.Describe(is_current_column+".coltype")

// show the row count information
ll_cnt = idw_remote.rowcount()
dw_status.object.primary_rows[1] = ll_cnt
if rb_primary.checked then dw_status.object.current_row[1]= string(ll_row)+'/'+string(ll_cnt)
il_current_row = ll_row
ll_cnt = idw_remote.deletedcount()
dw_status.object.deleted_rows[1] = ll_cnt
if rb_deleted.checked then dw_status.object.current_row[1] = string(ll_row)+'/'+string(ll_cnt)

ll_cnt = idw_remote.filteredcount()
dw_status.object.filtered_rows[1] = ll_cnt
if rb_filtered.checked then dw_status.object.current_row[1]  = string(ll_row)+'/'+string(ll_cnt)

ll_cnt = idw_remote.modifiedcount()
dw_status.object.modified_rows[1] = ll_cnt

// If we are looking at the original datawindow then show the column and row status
if rb_primary.checked then
//	ddlb_columnstatus.enabled = true
	dw_status.object.col_status.protect = 0
	if ll_row > 0 And LenA(is_current_column) > 0 then 
		l_stat = idw_remote.getitemstatus(ll_row,is_current_column,primary!)
//!!!		ddlb_columnstatus.text =of_itemstatustext(l_stat)
		dw_status.object.col_status[1] = of_itemstatustext(l_stat)
//!!!		ddlb_rowstatus.enabled = true
		dw_status.object.row_status.protect = 0
		l_stat = idw_remote.getitemstatus(ll_row,0,primary!)
//!!!		ddlb_rowstatus.text = of_itemstatustext(l_stat)
		dw_status.object.row_status[1] = of_itemstatustext(l_stat)
	else
//!!!		ddlb_columnstatus.text =''
//!!!		ddlb_rowstatus.text = ''
		dw_status.object.col_status[1] = 'NA'
		dw_status.object.row_status[1] = 'NA'
	end if
end if

return true

end function

protected subroutine of_error ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_error
//
//	Access:  protected
//
//	Arguments : None
//
//	Returns:  None
//
//	Description:  the only error that we are concerned with is an invalid idw_remote pointer
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version 
// 5.0.02 Took out SetPosition code.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

if messagebox(this.title, &
		'The DataWindow that was being debugged is no longer present.' + &
		'~r~nOK to close this debugger?',&
		question!,okcancel!,1) =  1 then 
	close(this)
end if
end subroutine

protected function boolean of_get_attributes (string as_object);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_get_attributes
//
//	Access:  protected
//
//	Arguments:	object : string;	name of the object to be described
//
//	Returns:	Boolean ; Returns false if the idw_remote is no longer valid otherwise true
//
//	Description:  display the attributes of the passed object
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
string ls_attr_list,ls_attr_rqst,ls_attr,ls_imp_str,ls_value,ls_dw_list,ls_dw_rqst,ls_visible
int li_start_posi,li_end_posi,li_rc
boolean lb_done=false

string ls_invisible_attrs = 'coltype~tdbname~tid~tinitial~tkey~tname~ttag~ttype~tupdate~tvalidation~tvalidationmsg'

if IsNull(idw_remote) Or not isvalid(idw_remote) then 
	of_error()
	return false
end if

setpointer(hourglass!)
is_current_object = as_object
if as_object = 'datawindow' then 
	dw_status.object.object_name[1] = idw_remote.dataobject
	dw_status.object.object_type[1] = 'DataWindow Object'
else
	dw_status.object.object_name[1] = as_object
	dw_status.object.object_type[1] = idw_remote.Describe(as_object+".type")
end if
ls_visible = idw_remote.Describe(as_object+".visible")

if ls_visible = '1' or as_object = 'datawindow' then
	ls_attr_list = idw_remote.Describe(as_object+".Attributes")
elseif dw_status.object.object_type[1] = 'column' then
	ls_attr_list = ls_invisible_attrs
else
	dw_attributes.reset()
	return true
end if
li_start_posi = 1
li_end_posi = 1
do 
	li_end_posi = PosA(ls_attr_list,'~t',li_start_posi)
	if li_end_posi = 0 then 
		li_end_posi = LenA(ls_attr_list) + 1
		lb_done = true
	end if
	ls_attr = MidA(ls_attr_list,li_start_posi,li_end_posi - li_start_posi)
	ls_dw_rqst = ''
	if as_object <> 'datawindow' then
		if ls_attr <> 'attributes'  then
			ls_dw_rqst = as_object+'.'+ls_attr
		end if
	else
		if ls_attr <> 'attributes' and (PosA(ls_attr,'data') = 0) and (PosA(ls_attr,'syntax') = 0) and ls_attr <> 'objects' then // do not ask for attributes again or data attributes
			ls_dw_rqst = as_object+'.'+ls_attr
		end if
	end if
	if ls_dw_rqst <> '' then
		ls_value =  idw_remote.Describe(ls_dw_rqst)
		ls_value = invo_string.of_globalreplace(ls_value,'~t',',')
		if ls_value <> '!' and ls_value <> '?' then
			ls_imp_str= ls_imp_str + ls_attr + '~t' + ls_value  +'~r~n'
		end if
	end if
	li_start_posi = li_end_posi + 1
loop until lb_done

dw_attributes.setredraw(false)
dw_attributes.reset()
dw_attributes.importstring(ls_imp_str)
dw_attributes.sort()
//li_rc = dw_attributes.setfilter("value <> '?'")
//li_rc = dw_attributes.filter()

dw_attributes.setredraw(true)

return true
end function

protected function boolean of_show_buffer (dwbuffer a_buff);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_show_buffer
//
//	Access:  protected
//
//	Arguments:	a_buff : dwbuffer ; the buffer to be displayed
//
//	Returns:	Boolean ; Returns false if the idw_remote is no longer valid otherwise true
//
//	Description:  Displays the contents of the Primary,Deleted or Filtered buffer as requested
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

string ls_buff_name
long ll_row

if ib_critical_section then return true // prevent recursion

if IsNull(idw_remote) Or not isvalid(idw_remote) then 
	of_error()
	return false
end if

if i_current_buffer = a_buff then // just refresh the buffers
end if

ib_critical_section = true
dw_debug.setredraw(false)
//!!!ddlb_columnstatus.deleteitem(5)
//!!!ddlb_rowstatus.deleteitem(5)
if a_buff = primary! then
	dw_debug.reset()
	idw_remote.sharedata(dw_debug)
	cb_undelete.enabled = false
	cb_delete.enabled = true
	dw_debug.modify('datawindow.readonly = no')
else
	dw_debug.sharedataoff()
	cb_delete.enabled = false
	if rb_deleted.checked then 
		ll_row = dw_debug.getrow()
	else
		ll_row  = 0
	end if
	dw_debug.rowsdiscard(1,dw_debug.rowcount(), Primary!)
	choose case a_buff
		case delete!
			ls_buff_name = 'Deleted'
			idw_remote.rowscopy(1,idw_remote.deletedcount(), a_buff, dw_debug, 1, Primary!)
			cb_undelete.enabled = true
			if ll_row > 0 then dw_debug.scrolltorow(ll_row)
		case filter!
			ls_buff_name = 'Filtered'
			idw_remote.rowscopy(1,idw_remote.filteredcount(), a_buff, dw_debug, 1, Primary!)
			cb_undelete.enabled = false
	end choose
	dw_debug.modify('datawindow.readonly = yes')
//!!!	ddlb_columnstatus.additem(' ')
//!!!	ddlb_columnstatus.text = ' '
//!!!	ddlb_columnstatus.enabled = false
	dw_status.object.col_status[1] = ''
	dw_status.object.col_status.protect = 1 
//!!!	ddlb_rowstatus.additem(ls_buff_name)
//!!!	ddlb_rowstatus.text = ls_buff_name
//!!!	ddlb_rowstatus.enabled = false
	dw_status.object.row_status[1] = ls_buff_name
	dw_status.object.row_status.protect = 1 
end if
dw_debug.setredraw(true)
ib_critical_section = false
return true

end function

protected function dwitemstatus of_textitemstatus (string as_stat);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_textitemstatus
//
//	Access:  protected
//
//	Arguments : as_txt : string; Contains a string version of a dwitemstatus enumerated type
//
//	Returns:  dwitemstatus
//
//	Description:  Returns the dwitemstatus enumerated type equivalent of the passed string 
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

CHOOSE CASE lower(as_stat)
	CASE 'datamodified!'
		return DataModified!
	CASE 'new!'
		return New!
	CASE 'newmodified!'
		return NewModified!
	CASE 'notmodified!'
		return NotModified!
END CHOOSE
return NotModified!


end function

protected function string of_itemstatustext (dwitemstatus a_stat);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_itemstatustext
//
//	Access:  protected
//
//	Arguments : a_stat : dwitemstatus; enumerated type
//
//	Returns:  string
//
//	Description:  Returns the string equivalent of the passed dwitemstatus enumerated type
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

CHOOSE CASE a_stat
	CASE datamodified!
		return 'DataModified!'
	CASE new!
		return 'New!'
	CASE newmodified!
		return 'NewModified!'
	CASE notmodified!
		return 'NotModified!'
END CHOOSE
return 'Error'


end function

on pfc_w_dwdebugger.create
int iCurrent
call super::create
this.st_zoom=create st_zoom
this.dw_status=create dw_status
this.dw_debug=create dw_debug
this.dw_attributes=create dw_attributes
this.rb_original=create rb_original
this.rb_all=create rb_all
this.gb_display=create gb_display
this.rb_deleted=create rb_deleted
this.rb_filtered=create rb_filtered
this.rb_primary=create rb_primary
this.gb_buffer=create gb_buffer
this.cb_delete=create cb_delete
this.cb_undelete=create cb_undelete
this.cb_close=create cb_close
this.em_zoom=create em_zoom
this.cb_sort=create cb_sort
this.cb_filter=create cb_filter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_zoom
this.Control[iCurrent+2]=this.dw_status
this.Control[iCurrent+3]=this.dw_debug
this.Control[iCurrent+4]=this.dw_attributes
this.Control[iCurrent+5]=this.rb_original
this.Control[iCurrent+6]=this.rb_all
this.Control[iCurrent+7]=this.gb_display
this.Control[iCurrent+8]=this.rb_deleted
this.Control[iCurrent+9]=this.rb_filtered
this.Control[iCurrent+10]=this.rb_primary
this.Control[iCurrent+11]=this.gb_buffer
this.Control[iCurrent+12]=this.cb_delete
this.Control[iCurrent+13]=this.cb_undelete
this.Control[iCurrent+14]=this.cb_close
this.Control[iCurrent+15]=this.em_zoom
this.Control[iCurrent+16]=this.cb_sort
this.Control[iCurrent+17]=this.cb_filter
end on

on pfc_w_dwdebugger.destroy
call super::destroy
destroy(this.st_zoom)
destroy(this.dw_status)
destroy(this.dw_debug)
destroy(this.dw_attributes)
destroy(this.rb_original)
destroy(this.rb_all)
destroy(this.gb_display)
destroy(this.rb_deleted)
destroy(this.rb_filtered)
destroy(this.rb_primary)
destroy(this.gb_buffer)
destroy(this.cb_delete)
destroy(this.cb_undelete)
destroy(this.cb_close)
destroy(this.em_zoom)
destroy(this.cb_sort)
destroy(this.cb_filter)
end on

event activate;call w_response::activate;// reset the information when the debugger becomes active
of_dw_info()
end event

event open;call super::open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:	w_dw_debugger
//
//	Description:	Datawindow debugger.
//						Open example from a rbuttondown event of a datawindow control
//							str_debug parm
//							if keydown(keyshift!) and keydown(keycontrol!) and keydown(keyd!) then
//								parm.dw = this
//								parm.trans = sqlca
//								openwithparm(w_dw_debugger,parm)
//							end if
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.02 Converted to correct window type of Responce.
// 5.0.02 Took out all code in several functions/events to force Position on
//		on this window.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
s_dwdebugger l_parm

l_parm = message.powerobjectparm
idw_remote = l_parm.dw_obj
itr_connect = l_parm.tr_obj
dw_status.insertrow(0)
dw_status.of_SetUpdateable(false)
if isvalid(idw_remote) then
	rb_original.triggerevent(clicked!)
	dw_debug.event Post ue_row_info()
else
	of_error()
	return
end if
this.title = this.title + '   ('+idw_remote.dataobject+')'

rb_all.enabled = (idw_remote.describe('DataWindow.Table.Select.attribute') <> '!')

// Disable CloseQuery processing
ib_disableclosequery = True
dw_debug.of_SetUpdateable(false)
dw_attributes.of_SetUpdateable(false)

end event

event pfc_preopen;call w_response::pfc_preopen;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_pre_open
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	Handle processing that occurs before the open event.
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

//If appropriate, start the Preference service.
If gnv_app.of_IsRegistryAvailable() Then
	If LenA(gnv_app.of_GetUserKey())> 0 Then 
		of_SetPreference(True)
	End If
Else
	If LenA(gnv_app.of_GetUserIniFile()) > 0 Then
		of_SetPreference(True)
	End If
End If

end event

type st_zoom from u_st within pfc_w_dwdebugger
int X=9
int Y=1204
int Width=160
string Text="Zoom :"
Alignment Alignment=Right!
long TextColor=33554432
long BackColor=77956459
end type

type dw_status from u_dw within pfc_w_dwdebugger
int X=1573
int Y=0
int Width=960
int Height=580
int TabOrder=110
string DataObject="d_dwdebuggerstatus"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event itemchanged;call super::itemchanged;
dwitemstatus stat
integer rc

if il_current_row = 0 then return
if IsNull(idw_remote) Or not isvalid(idw_remote) then 
	of_error()
	return
end if
if isnull(dwo) then return
choose case dwo.name
	case 'row_status'
		stat = of_textitemstatus(data)
		rc = idw_remote.setitemstatus(il_current_row,0,primary!,stat)
	case 'col_status'
		stat = of_textitemstatus(data)
		idw_remote.setitemstatus(il_current_row,is_current_column,primary!,stat)
end choose
dw_debug.event post ue_row_info()

end event

type dw_debug from u_dw within pfc_w_dwdebugger
event ue_row_info ( )
int X=0
int Y=0
int Width=1550
int Height=964
int TabOrder=100
boolean HScrollBar=true
end type

event ue_row_info;call u_dw::ue_row_info;of_dw_info()
end event

event clicked;call u_dw::clicked;// get new information about what was clicked on
string curr_col
if isnull(row) then row = 0
if row <= 0 then return
this.scrolltorow(row)
this.setrow(row)
// if we are not displaying the primary buffer then we need to keep track of the 
// current column ourselves since we made the dw readonly when not displaying the primary buffer
if not rb_primary.checked then  
	if dwo.type = 'column' then is_current_column = curr_col
end if
// post to this event to give the datawindow time to set the current row and column settings
dw_debug.event post ue_row_info()


end event

event itemfocuschanged;call u_dw::itemfocuschanged;// get information about the new column
of_dw_info()
end event

event rbuttondown;// get the attributes of the object that was rbutton clicked
string ls_obj

if IsNull(idw_remote) Or not isvalid(idw_remote) then 
	of_error()
	return
end if

if IsNull(dwo) Or not isvalid(dwo) then 
	of_get_attributes('datawindow')
else
	ls_obj = dwo.name
	of_get_attributes(dwo.name)
end if
end event

event rowfocuschanged;call u_dw::rowfocuschanged;// get information about the new row
this.selectrow(0,false)
if rb_all.checked then
	if currentrow > 0 then this.selectrow(currentrow,true)
end if
end event

event rbuttonup;// overridden
end event

type dw_attributes from u_dw within pfc_w_dwdebugger
int X=1568
int Y=580
int Width=960
int Height=740
int TabOrder=90
string DataObject="d_dwdebuggerattributes"
end type

event itemerror;call u_dw::itemerror;return 1
end event

event itemchanged;// 5.0.02 Took out SetPosition code.

string 	ls_prev_value, ls_current_value, ls_prop_name
string	ls_command, ls_command_2, ls_err_msg, ls_err_msg_2
boolean 	lb_numeric, lb_yes_no

if IsNull(idw_remote) Or not isvalid(idw_remote) then 
	of_error()
	return
end if

ls_prop_name = this.object.property[row]
ls_prev_value = this.object.value[row]
lb_numeric = isnumber(ls_prev_value)
lb_yes_no = lower(ls_prev_value) = 'yes' or  lower(ls_prev_value) = 'no'
ls_current_value = this.gettext()
if lb_numeric then
	if not isnumber(ls_current_value) then
		messagebox(parent.title, &
				'Property '+ls_prop_name+' needs to be numeric. "'+ &
				ls_current_value+'" is not.')
		return 1
	end if
elseif lb_yes_no then
	ls_current_value = lower(ls_current_value)
	if ls_current_value <> 'no' and ls_current_value <> 'yes' then
		messagebox(parent.title, &
			"Property "+ls_prop_name+" needs to be either 'yes' or 'no'. '"+ &
			ls_current_value+"' is not.")
		return 1
	end if
end if
ls_command = is_current_object+'.'+ls_prop_name+' = '+ls_current_value
ls_err_msg = idw_remote.modify(ls_command)
if LenA(ls_err_msg) > 0 then 
	// got an error, if it is not a numeric or yes/no value lets try it with quotes
	ls_command_2 = is_current_object+'.'+ls_prop_name+' = "'+ls_current_value + '"'
	ls_err_msg_2 = idw_remote.modify(ls_command_2)
	if LenA(ls_err_msg_2) > 0 then 
		// OK, that did not work either so lets give them the original error message
		messagebox(parent.title, &
			'The change to property '+ls_prop_name+' failed. The command '+ &
			ls_command+' produced the following error message:~r~n'+ls_err_msg)
		return 1
	end if
	ls_command = ls_command_2
end if

if rb_original.checked then 
	ls_err_msg = dw_debug.modify(ls_command)
	if LenA(ls_err_msg) > 0 then
		messagebox(parent.title, &
			'The change to property '+ls_prop_name+' failed. The command '+ &
			ls_command+' produced the following error message:~r~n'+ls_err_msg)
		return 1
	end if
end if

end event

type rb_original from u_rb within pfc_w_dwdebugger
int X=41
int Y=1044
int Width=352
int Height=52
string Text="&Original"
boolean Checked=true
long TextColor=33554432
long BackColor=77956459
end type

event clicked;call super::clicked;string ls_error

if IsNull(idw_remote) Or not isvalid(idw_remote) then 
	of_error()
	return
end if


dw_debug.sharedataoff()
dw_debug.create(idw_remote.describe('datawindow.syntax'),ls_error)
if LenA(ls_error) > 0 then
	messagebox(parent.title,ls_error)
	return
end if
idw_remote.sharedata(dw_debug)
em_zoom.text = '100'

if rb_deleted.checked then rb_deleted.postevent(clicked!)
if rb_filtered.checked then rb_filtered.postevent(clicked!)
dw_debug.event post ue_row_info()

end event

type rb_all from u_rb within pfc_w_dwdebugger
int X=41
int Y=1104
int Width=352
int Height=52
string Text="&All Columns"
long TextColor=33554432
long BackColor=77956459
end type

event clicked;call super::clicked;string ls_sql_syntax,ls_error,ls_dw_syntax
string ls_color = "67108864"
integer li_rc
if IsNull(idw_remote) Or not isvalid(idw_remote) then 
	of_error()
	return
end if

setpointer(hourglass!)
ls_sql_syntax = idw_remote.describe('DataWindow.Table.Select.attribute')

ls_dw_syntax = itr_connect.SyntaxFromSQL(ls_sql_syntax, "Style(Type= Grid ) DataWindow(Color="+ls_color+" )",ls_error)
if LenA(ls_error) > 0 then
	messagebox(parent.title,ls_error)
	return
end if

dw_debug.sharedataoff()
dw_debug.create(ls_dw_syntax,ls_error)
if LenA(ls_error) > 0 then
	messagebox(parent.title,ls_error)
	return
end if
ls_error = dw_debug.Modify(&
"create compute(band=Detail" + &
" color='0' alignment='0' border='0'" + &
" x='1' y='4' height='57' width='307' format='[general]'" + &
" expression='if (isRowNew(), if (IsRowModified(), ~"newmodified!~", ~"new!~"), if (IsRowModified(), ~"datamodified!~", ~"notmodified!~"))' font.face='MS San Serif'" + &
" font.height='-8' font.weight='400' font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='"+ls_color+"')")
if LenA(ls_error) > 0 then
	messagebox(parent.title,ls_error)
	return
end if

ls_error = dw_debug.Modify(&
"Create text(band=header " + &
"text=~"Row~r~nStatus~" x=~"1~" y=~"4~" height=~"113~" width=~"307~" " + &
"font.face=~"MS San Serif~" font.height=~"-8~" font.weight=~"700~" font.charset=~"0~" font.pitch=~"2~" font.family=~"2~" " + &
"font.underline=~"0~" font.italic=~"0~" border=~"0~" color=~"0~" background.mode=~"1~" background.color=~""+ls_color+"~" alignment=~"2~")")
if LenA(ls_error) > 0 then
	messagebox(parent.title,ls_error)
	return
end if


//dw_debug.object.datawindow.readonly = 'yes'
li_rc = idw_remote.sharedata(dw_debug)
if li_rc = -1 then
	messagebox(parent.title,"Sharedata failed while attempting to show data in 'All Columns' format. One possible reasons for the error is that there is a mismatch between column types. In 4.0 all numeric columns were of type 'number', in 5.0 they may be of type 'long', 'ulong' or 'real'. When the 'All' datawindow is created it uses 5.0 syntax, therefore there may be a mismatch. Make sure that your existing datawindow has benn rebuilt under 5.0")
end if	
em_zoom.text = '100'
if rb_deleted.checked then rb_deleted.postevent(clicked!)
if rb_filtered.checked then rb_filtered.postevent(clicked!)
dw_debug.event post ue_row_info()


end event

type gb_display from u_gb within pfc_w_dwdebugger
int X=5
int Y=980
int Width=416
int Height=204
int TabOrder=80
string Text="&Display Format"
long BackColor=77956459
end type

type rb_deleted from u_rb within pfc_w_dwdebugger
int X=489
int Y=1100
int Width=270
int Height=52
string Text="D&eleted"
long TextColor=33554432
long BackColor=77956459
end type

event clicked;call u_rb::clicked;if not of_show_buffer(delete!) then return
of_dw_info()
end event

type rb_filtered from u_rb within pfc_w_dwdebugger
int X=489
int Y=1156
int Width=270
int Height=52
string Text="&Filtered"
long TextColor=33554432
long BackColor=77956459
end type

event clicked;call u_rb::clicked;if not of_show_buffer(filter!) then return
of_dw_info()
end event

type rb_primary from u_rb within pfc_w_dwdebugger
int X=489
int Y=1040
int Width=270
int Height=52
string Text="&Primary"
boolean Checked=true
long TextColor=33554432
long BackColor=77956459
end type

event clicked;call u_rb::clicked;if not of_show_buffer(primary!) then return
of_dw_info()


end event

type gb_buffer from u_gb within pfc_w_dwdebugger
int X=457
int Y=980
int Width=320
int Height=260
int TabOrder=70
string Text="&Buffer"
long BackColor=77956459
end type

type cb_delete from u_cb within pfc_w_dwdebugger
int X=837
int Y=992
int Width=297
int Height=80
int TabOrder=60
string Text="&Delete"
end type

event clicked;call u_cb::clicked;idw_remote.deleterow(il_current_row)
of_dw_info()
end event

type cb_undelete from u_cb within pfc_w_dwdebugger
int X=837
int Y=1092
int Width=297
int Height=80
int TabOrder=50
boolean Enabled=false
string Text="&UnDelete"
end type

event clicked;call super::clicked;long ll_row

if IsNull(idw_remote) Or not isvalid(idw_remote) then 
	of_error()
	return
end if
ll_row = dw_debug.getrow()
if ll_row <= 0 then return
idw_remote.RowsMove(ll_row, ll_row, delete!, idw_remote , 1, Primary!)
rb_deleted.triggerevent(clicked!)
of_dw_info()
if dw_debug.rowcount() = 0 then this.enabled = false

end event

type cb_close from u_cb within pfc_w_dwdebugger
int X=1184
int Y=992
int Width=297
int Height=80
int TabOrder=40
string Text="Close"
end type

event clicked;call u_cb::clicked;close(parent)
end event

type em_zoom from u_em within pfc_w_dwdebugger
event changed pbm_enchange
int X=192
int Y=1196
int TabOrder=30
string Mask="###"
boolean Spin=true
string DisplayData="$$HEX1$$c400$$ENDHEX$$"
double Increment=10
string MinMax="10~~200"
string Text="100"
long TextColor=33554432
long BackColor=1090519039
end type

event changed;call u_em::changed;dw_debug.object.datawindow.zoom = this.text
end event

type cb_sort from u_cb within pfc_w_dwdebugger
int X=1184
int Y=1092
int Width=297
int Height=80
int TabOrder=20
string Text="&Sort"
end type

event clicked;call super::clicked;// 5.0.02 Took out SetPosition code.

string ls_null
setnull(ls_null)

Parent.Enabled = False
idw_remote.setsort(ls_null)
idw_remote.sort()
Parent.Enabled = True
Parent.SetFocus()

of_dw_info()
end event

type cb_filter from u_cb within pfc_w_dwdebugger
int X=837
int Y=1188
int Width=297
int Height=80
int TabOrder=10
string Text="&Filter"
end type

event clicked;call super::clicked;// 5.0.02 Took out SetPosition code.

string ls_null
setnull(ls_null)

Parent.Enabled = False
idw_remote.setfilter(ls_null)
idw_remote.filter()
Parent.Enabled = True
Parent.SetFocus()

of_dw_info()
end event

