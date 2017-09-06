HA$PBExportHeader$n_runandwait.sru
forward
global type n_runandwait from nonvisualobject
end type
type os_process_information from structure within n_runandwait
end type
type os_startupinfo from structure within n_runandwait
end type
end forward

type os_process_information from structure
	unsignedlong		ul_process
	unsignedlong		ul_thread
	unsignedlong		ul_processid
	unsignedlong		ul_threadid
end type

type os_startupinfo from structure
	unsignedlong		ul_cb
	string		s_reserved
	string		s_desktop
	string		s_title
	unsignedlong		ul_x
	unsignedlong		ul_y
	unsignedlong		ul_xsize
	unsignedlong		ul_ysize
	unsignedlong		ul_xcountchars
	unsignedlong		ul_ycountchars
	unsignedlong		ul_fillattribute
	unsignedlong		ul_flags
	unsignedinteger		ui_showwindow
	unsignedinteger		ui_reserved2
	unsignedinteger		l_reserved2
	unsignedlong		ul_stdinput
	unsignedlong		ul_stdoutput
	unsignedlong		ul_stderror
end type

global type n_runandwait from nonvisualobject
end type
global n_runandwait n_runandwait

type prototypes
function ulong WaitForSingleObject (ulong handle, ulong milliseconds) library "kernel32.dll" 

function boolean CreateProcess(ulong applicationname, string commandline, &
  ulong processattributes, & 
  ulong threadattributes, & 
  boolean inherithandles, ulong creationflags, & 
  ulong environment, string currentdirectory, & 
  ref os_startupinfo startupinfo, & 
  ref os_process_information processinformation) & 
  library "kernel32.dll" alias for "CreateProcessA;Ansi" 

function boolean CloseHandle (ulong object) library "kernel32.dll" 
function ulong GetLastError () library "kernel32.dll" 
function boolean TerminateProcess (ulong handle, uint exitcode) library "kernel32.dll" 
end prototypes

type variables
public:

// Para la funcion sincrona RunAndWait
constant ulong INFINITE = 4294967295 
constant ulong NORMAL_PRIORITY_CLASS = 32 
constant ulong IDLE_PRIORITY_CLASS = 64 
constant ulong HIGH_PRIORITY_CLASS = 128 
constant ulong REALTIME_PRIORITY_CLASS = 256 
ulong iul_timeout = INFINITE 

private:

// Para la funcion sincrona RunAndWait
constant ulong STARTF_USESHOWWINDOW = 1 
constant ulong STARTF_USESIZE = 2 
constant ulong STARTF_USEPOSITION = 4 
constant uint SW_HIDE = 0 
constant uint SW_NORMAL = 1 
constant uint SW_MAXIMIZE = 3 
constant uint SW_MINIMIZE = 6 

constant ulong WAIT_FAILED = 4294967295 
constant ulong WAIT_TIMEOUT = 258 

constant double LOG_2 = Log (2) 

os_startupinfo istr_startupinfo 

ulong iul_creationflags = NORMAL_PRIORITY_CLASS 


string is_directory 


end variables

forward prototypes
public function integer of_setcurrentdirectory (string as_directory)
public function integer of_setpriority (unsignedlong aul_priority)
public function integer of_setwindow (string as_windowstate)
public function boolean of_isenabled (unsignedlong aul_feature)
public function integer of_runandwait (string as_command)
end prototypes

public function integer of_setcurrentdirectory (string as_directory);// Integer of_SetCurrentDirectory ( string as_directory ). 
if LenA (as_directory) = 0 then 
  SetNull (as_directory) 
end if 

this.is_directory = as_directory 

Return 1 

end function

public function integer of_setpriority (unsignedlong aul_priority);// Integer of_SetPriority ( ulong aul_priority ). 
if IsNull (aul_priority) then Return -1 

if aul_priority <> NORMAL_PRIORITY_CLASS and & 
  aul_priority <> REALTIME_PRIORITY_CLASS and & 
  aul_priority <> HIGH_PRIORITY_CLASS and & 
  aul_priority <> IDLE_PRIORITY_CLASS then & 
  Return -1 

this.iul_CreationFlags = aul_priority 

Return 1 
end function

public function integer of_setwindow (string as_windowstate);// Integer of_SetWindow ( string as_windowstate ). 
integer li_return = 1 

if not this.of_IsEnabled & 
  (STARTF_USESHOWWINDOW) then 
  this.istr_startupinfo.ul_flags += & 
    STARTF_USESHOWWINDOW 
end if 

choose case lower (as_WindowState) 
  case "off" 
    this.istr_startupinfo.ul_flags -= & 
      STARTF_USESHOWWINDOW 
  case "normal" 
    this.istr_startupinfo.ui_ShowWindow = & 
      SW_NORMAL 
  case "maximize" 
    this.istr_startupinfo.ui_ShowWindow = & 
      SW_MAXIMIZE 
  case "minimize" 
    this.istr_startupinfo.ui_ShowWindow = & 
      SW_MINIMIZE 
  case "hide" 
    this.istr_startupinfo.ui_ShowWindow = SW_HIDE 
  case else 
    li_return = -1 
end choose 
Return li_return 

end function

public function boolean of_isenabled (unsignedlong aul_feature);// Boolean of_IsEnabled ( ulong aul_feature ). 
if Int (Mod (this.istr_startupinfo.ul_flags / & 
  (2 ^ (Log (aul_feature) / LOG_2)), 2)) > 0 then 
  Return true 
else 
  Return false 
end if 
end function

public function integer of_runandwait (string as_command);// Integer of_RunAndWait (string as_command readonly). 
os_process_information lstr_proc 
boolean lb_rc 
integer li_return = -1 
ulong lul_rc 
ulong lul_null 

SetNull (lul_null) 

// Set size of structure. There are 13 long and & 
// 2 integer values, plus three strings. 

this.istr_StartupInfo.ul_cb = & 
  (13 * 4) + (2 * 2) + & 
  LenA (this.istr_StartupInfo.s_reserved) + & 
  LenA (this.istr_StartupInfo.s_desktop) + & 
  LenA (this.istr_StartupInfo.s_title) 

lb_rc = CreateProcess (lul_null, & 
  as_command, lul_null, lul_null, true, & 
  this.iul_CreationFlags, lul_null, & 
  this.is_directory, & 
  this.istr_StartupInfo, lstr_proc) 

if lb_rc then 
  lul_rc = WaitForSingleObject & 
    (lstr_proc.ul_process, this.iul_timeout) 

  choose case lul_rc 
    case WAIT_TIMEOUT 
      TerminateProcess (lstr_proc.ul_process, 0) 

    case WAIT_FAILED 
      lul_rc = GetLastError () 
      MessageBox ("Fallo: En espera", lul_rc) 
  end choose 
else 
  lul_rc = GetLastError () 
  MessageBox ("Ha fallado el proceso: ",as_command+' ('+string(lul_rc)+')') 
end if 

lb_rc = CloseHandle (lstr_proc.ul_process) 
   
if lb_rc then 
  li_return = 1 
end if 

Return li_return 

end function

on n_runandwait.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_runandwait.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// Initialize unused values according to SDK  
// help file 

SetNull (this.istr_startupinfo.s_reserved) 
SetNull (this.istr_startupinfo.s_title) 
SetNull (this.istr_startupinfo.l_reserved2) 

this.istr_startupinfo.ui_reserved2 = 0 

// Initialize instance variables 

SetNull (this.is_directory) 

end event

