HA$PBExportHeader$pfc_n_cn.sru
$PBExportComments$PFC Connection class
forward
global type pfc_n_cn from connection
end type
end forward

global type pfc_n_cn from connection
end type
global pfc_n_cn pfc_n_cn

forward prototypes
public function integer of_init (string as_inifile, string as_inisection)
public function integer of_init (string as_registrykey)
protected function integer of_messagebox (string as_id, string as_title, string as_text, icon ae_icon, button ae_button, integer ai_default)
end prototypes

public function integer of_init (string as_inifile, string as_inisection);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_init
//
//	Access:  		public
//
//	Arguments:
//	as_inifile		.INI file to read values from.
//	as_inisection	Section within .INI file where connect object values are.
//
//	Returns:  		integer
//						1 if no errors are encountered.
//						-1 if an error is encountered.
//
//	Description: 	Initializes connect object's properties with 
//						values from an .INI file.  Values that are not found
//						will be defaulted to an empty string.
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

//Check arguments
If IsNull(as_inifile) or IsNull(as_inisection) or &
	LenA(Trim(as_inifile))=0 or LenA(Trim(as_inisection))=0 or &
	(Not FileExists(as_inifile)) Then
	Return -1
End If

//Initialize the connect object.
this.Driver = ProfileString (as_inifile, as_inisection, 'Driver', '')
this.Application 	= ProfileString (as_inifile, as_inisection, 'Application', '')
this.Location = ProfileString (as_inifile, as_inisection, 'Location', '')
this.ConnectString = ProfileString (as_inifile, as_inisection, 'ConnectString', '')
this.UserID = ProfileString (as_inifile, as_inisection, 'UserID', '')
this.Password = ProfileString (as_inifile, as_inisection, 'Password', '')
this.Options = ProfileString (as_inifile, as_inisection, 'Options', '')
this.Trace = ProfileString (as_inifile, as_inisection, 'Trace', '')

return 1
end function

public function integer of_init (string as_registrykey);////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_init
//
//	Access:  		public
//
//	Arguments:
//	as_registrykey		The registry key path to read values from.
//
//	Returns:  		integer
//						1 if no errors are encountered.
//						-1 if an error is encountered.
//
//	Description: 	Initializes connection object's properties with 
//						values from the registry.  Values that are not found
//						will be defaulted to an empty string.
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

string	ls_driver='', ls_application=''
string	ls_location='', ls_connectstring=''
string	ls_userid='', ls_password=''
string	ls_options='', ls_trace=''
integer	li_rc

//Check arguments
If IsNull(as_registrykey) or LenA(Trim(as_registrykey))=0 Then
	Return -1
End If

//If available, get each value from the registry.
li_rc = RegistryGet (as_registrykey, 'Driver', ls_driver)
li_rc = RegistryGet (as_registrykey, 'Application', ls_application)
li_rc = RegistryGet (as_registrykey, 'Location', ls_location)
li_rc = RegistryGet (as_registrykey, 'ConnectString', ls_connectstring)
li_rc = RegistryGet (as_registrykey, 'UserID', ls_userid)
li_rc = RegistryGet (as_registrykey, 'Password', ls_password)
li_rc = RegistryGet (as_registrykey, 'Options', ls_options)
li_rc = RegistryGet (as_registrykey, 'Trace', ls_trace)

//Initialize the connect object.
this.Driver = ls_driver
this.Application 	= ls_application
this.Location = ls_location
this.ConnectString = ls_connectstring
this.UserID = ls_userid
this.Password = ls_password
this.Options = ls_options
this.Trace = ls_trace

Return 1
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

on pfc_n_cn.create
call connection::create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cn.destroy
call connection::destroy
TriggerEvent( this, "destructor" )
end on
