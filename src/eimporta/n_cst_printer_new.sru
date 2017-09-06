HA$PBExportHeader$n_cst_printer_new.sru
$PBExportComments$PFD (corporate) layer inherited from pfc_n_cst_platformwin32
forward
global type n_cst_printer_new from pfc_n_cst_platformwin32
end type
type os_memorystatus from structure within n_cst_printer_new
end type
type os_systemdatetime from structure within n_cst_printer_new
end type
type os_shfileopstruct from structure within n_cst_printer_new
end type
type os_browseinfo from structure within n_cst_printer_new
end type
type os_notifyicondata from structure within n_cst_printer_new
end type
type os_rect from structure within n_cst_printer_new
end type
end forward

type os_memorystatus from structure
    unsignedlong ul_length
    unsignedlong ul_memoryload
    unsignedlong ul_totalphys
    unsignedlong ul_availphys
    unsignedlong ul_totalpagefile
    unsignedlong ul_availpagefile
    unsignedlong ul_totalvirtual
    unsignedlong ul_availvirtual
end type

type os_systemdatetime from structure
	unsignedinteger		wyear
	unsignedinteger		wmonth
	unsignedinteger		wdayofweek
	unsignedinteger		wday
	unsignedinteger		whour
	unsignedinteger		wminute
	unsignedinteger		wsecond
	unsignedinteger		wmillisecond
end type

type os_shfileopstruct from structure
	unsignedlong		hwnd
	unsignedlong		wfunc
	string		pfrom
	string		pto
	unsignedinteger		fflags
	boolean		banyoperationsaborted
	unsignedlong		hnamemappings
	string		lpszprogresstitle
end type

type os_browseinfo from structure
	long		hwndowner
	long		pidlroot
	string		pszdisplayname
	string		lpsztitle
	unsignedinteger		ulflags
	long		lpfn
	long		lparam
	integer		iimage
end type

type os_notifyicondata from structure
	long		cbsize
	long		hwnd
	long		uid
	long		uflags
	long		ucallbackmsg
	long		hicon
	character		sztip[64]
end type

type os_rect from structure
	long		left
	long		top
	long		right
	long		bottom
end type

global type n_cst_printer_new from pfc_n_cst_platformwin32
end type
global n_cst_printer_new n_cst_printer_new

type prototypes
// Kernel functions
Subroutine GetLocalTime(ref os_systemdatetime systimeptr) Library "kernel32.dll" alias for "GetLocalTime;Ansi"
Subroutine GetSystemTime(ref os_systemdatetime systimeptr) Library "kernel32.dll" alias for "GetSystemTime;Ansi"
Function UnsignedLong GetTickCount() Library "kernel32.dll"
Subroutine GlobalMemoryStatus (ref os_memorystatus memorystatus) Library "kernel32.dll" alias for "GlobalMemoryStatus;Ansi"
Function Boolean SetLocalTime(os_systemdatetime systimeptr) Library "kernel32.dll" alias for "SetLocalTime;Ansi"
Function Boolean SetSystemTime(os_systemdatetime systimeptr) Library "kernel32.dll" alias for "SetSystemTime;Ansi"
Function Long GetTempPathA(Long nBufferLength, ref String lpBuffer) Library "kernel32.dll" alias for "GetTempPathA;Ansi"
Function Long GetModuleFileNameA(Long Handle, ref String Name, Long stringlen) Library "kernel32.dll" alias for "GetModuleFileNameA;Ansi"
Function Integer GetLocaleInfoA(UnsignedLong locale, UnsignedLong lctype, ref String data, Integer size) Library "kernel32.dll" alias for "GetLocaleInfoA;Ansi"
Function Integer SetLocaleInfoA(UnsignedLong locale, UnsignedLong lctype, String data) Library "kernel32.dll" alias for "SetLocaleInfoA;Ansi"
Function UnsignedLong GetSystemDefaultLCID() Library "kernel32.dll"
Subroutine Sleep(UnsignedLong dwMilliseconds) Library "kernel32.dll"

// Shell functions
Function Long ExtractIconA(UnsignedLong hInst, String lpszFileName, Int nIconIndex) Library "shell32.dll" alias for "ExtractIconA;Ansi" 
Function Long SHBrowseForFolder(REF os_browseinfo lpBi) Library "SHELL32.DLL" alias for "SHBrowseForFolder;Ansi"
Function Long Shell_NotifyIcon(UnsignedLong dwMessage, REF os_notifyicondata lpData) Library "shell32.dll" alias for "Shell_NotifyIcon;Ansi"
Function Long SHFileOperationA(os_shfileopstruct lpFileOp) Library "SHELL32.DLL" alias for "SHFileOperationA;Ansi"
Function Boolean SHGetPathFromIDList(UnsignedLong pidl, REF String pszBuffer) Library "Shell32.dll" alias for "SHGetPathFromIDList;Ansi"
Function Long ShellExecuteA(UnsignedLong hWnd, String Operation, String lpFile, String lpParameters, String lpDirectory, Int nShowCmd) Library "shell32.dll" alias for "ShellExecuteA;Ansi"
Function Long SHFormatDrive(UnsignedLong hWnd, UnsignedLong iDrive, UnsignedLong iCapacity, UnsignedLong iType) Library "shell32.dll"
Subroutine SHAddToRecentDocs(UnsignedInteger uFlags, String pv) Library "shell32.dll" alias for "SHAddToRecentDocs;Ansi" 

// User functions
Function Boolean GetClientRect(UnsignedLong hWnd, ref os_rect strRect) Library "user32.dll" alias for "GetClientRect;Ansi"
Function Long LoadImageA (UnsignedLong hInst, String lpszName, UnsignedInteger uType, Int a, Int b, UnsignedInteger l) Library "user32.dll" alias for "LoadImageA;Ansi"

end prototypes

type variables
Public:
// File operation types
CONSTANT UnsignedInteger FO_MOVE = 1
CONSTANT UnsignedInteger FO_COPY = 2
CONSTANT UnsignedInteger FO_DELETE = 3
CONSTANT UnsignedInteger FO_RENAME = 4

// File operation flags
CONSTANT UnsignedInteger FOF_MULTIDESTFILES = 1
CONSTANT UnsignedInteger FOF_CONFIRMMOUSE = 2
CONSTANT UnsignedInteger FOF_SILENT = 4
CONSTANT UnsignedInteger FOF_RENAMEONCOLLISION = 8
CONSTANT UnsignedInteger FOF_NOCONFIRMATION = 16
CONSTANT UnsignedInteger FOF_WANTMAPPINGHANDLE = 32
CONSTANT UnsignedInteger FOF_ALLOWUNDO = 64
CONSTANT UnsignedInteger FOF_FILESONLY = 128
CONSTANT UnsignedInteger FOF_SIMPLEPROGRESS = 256
CONSTANT UnsignedInteger FOF_NOCONFIRMMKDIR = 512
CONSTANT UnsignedInteger FOF_NOERRORUI = 1024
CONSTANT UnsignedInteger FOF_NOCOPYSECURITYATTRIBS	= 2048

// Special folder flags
CONSTANT UnsignedInteger CSIDL_DESKTOP = 0
CONSTANT UnsignedInteger CSIDL_INTERNET = 1
CONSTANT UnsignedInteger CSIDL_PROGRAMS = 2
CONSTANT UnsignedInteger CSIDL_CONTROLS = 3
CONSTANT UnsignedInteger CSIDL_PRINTERS = 4
CONSTANT UnsignedInteger CSIDL_PERSONAL = 5
CONSTANT UnsignedInteger CSIDL_FAVORITES = 6
CONSTANT UnsignedInteger CSIDL_STARTUP = 7
CONSTANT UnsignedInteger CSIDL_RECENT = 8
CONSTANT UnsignedInteger CSIDL_SENDTO = 9
CONSTANT UnsignedInteger CSIDL_BITBUCKET = 10
CONSTANT UnsignedInteger CSIDL_STARTMENU = 11
CONSTANT UnsignedInteger CSIDL_DESKTOPDIRECTORY = 16
CONSTANT UnsignedInteger CSIDL_DRIVES = 17
CONSTANT UnsignedInteger CSIDL_NETWORK = 18
CONSTANT UnsignedInteger CSIDL_NETHOOD = 19
CONSTANT UnsignedInteger CSIDL_FONTS = 20
CONSTANT UnsignedInteger CSIDL_TEMPLATES = 21
CONSTANT UnsignedInteger CSIDL_COMMON_STARTMENU = 22
CONSTANT UnsignedInteger CSIDL_COMMON_PROGRAMS = 23
CONSTANT UnsignedInteger CSIDL_COMMON_STARTUP = 24
CONSTANT UnsignedInteger CSIDL_COMMON_DESKTOPDIRECTORY = 25
CONSTANT UnsignedInteger CSIDL_APPDATA = 26
CONSTANT UnsignedInteger CSIDL_PRINTHOOD = 27
CONSTANT UnsignedInteger CSIDL_INTERNET_CACHE = 32
CONSTANT UnsignedInteger CSIDL_HISTORY = 34

// Shell browsing flags
CONSTANT UnsignedInteger BIF_RETURNONLYFSDIRS = 1
CONSTANT UnsignedInteger BIF_DONTGOBELOWDOMAIN = 2
CONSTANT UnsignedInteger BIF_STATUSTEXT = 4
CONSTANT UnsignedInteger BIF_RETURNFSANCESTORS = 8
CONSTANT UnsignedInteger BIF_BROWSEFORCOMPUTER = 4096
CONSTANT UnsignedInteger BIF_BROWSEFORPRINTER = 8192

// Recent documents flags
CONSTANT UnsignedInteger SHARD_PATH = 2

// System tray flags
CONSTANT UnsignedInteger NIF_MESSAGE = 1
CONSTANT UnsignedInteger NIF_ICON = 2
CONSTANT UnsignedInteger NIF_TIP = 4
CONSTANT UnsignedInteger NIM_ADD = 0
CONSTANT UnsignedInteger NIM_MODIFY = 1
CONSTANT UnsignedInteger NIM_DELETE = 2

CONSTANT UnsignedInteger WM_MOUSEMOVE = 512
CONSTANT UnsignedInteger WM_LBUTTONDOWN = 513
CONSTANT UnsignedInteger WM_LBUTTONUP = 514
CONSTANT UnsignedInteger WM_LBUTTONDBLCLK = 515
CONSTANT UnsignedInteger WM_RBUTTONDOWN = 516
CONSTANT UnsignedInteger WM_RBUTTONUP = 517
CONSTANT UnsignedInteger WM_RBUTTONDBLCLK = 518
CONSTANT UnsignedInteger WM_USER = 1024

// Window state flags
CONSTANT UnsignedInteger SW_HIDE = 0
CONSTANT UnsignedInteger SW_NORMAL = 1
CONSTANT UnsignedInteger SW_SHOWMINIMIZED = 2
CONSTANT UnsignedInteger SW_MAXIMIZE = 3
CONSTANT UnsignedInteger SW_SHOWNOACTIVATE = 4
CONSTANT UnsignedInteger SW_SHOW = 5
CONSTANT UnsignedInteger SW_MINIMIZE = 6
CONSTANT UnsignedInteger SW_SHOWMINNOACTIVE = 7
CONSTANT UnsignedInteger SW_SHOWNA = 8
CONSTANT UnsignedInteger SW_RESTORE = 9
CONSTANT UnsignedInteger SW_SHOWDEFAULT = 10

end variables

forward prototypes
public function string of_getdefaultprinter ()
public function string of_getprinterdriver (string as_printer)
public function string of_getprinterport (string as_printer)
public function integer of_setdefaultprinter (string as_printer)
public function long of_getfonts (ref string as_fontname[])
public function string of_browseforprinter (string as_title, ref window aw_requestor)
public function long of_getprinters (ref string as_printer[])
end prototypes

public function string of_getdefaultprinter ();//////////////////////////////////////////////////////////////////////////////
//
// Function:     of_GetDefaultPrinter
//
// Access:       Public
//
// Arguments:    None
//
// Returns:      String.  The default printer (null if not supported).
//
// Description:  Returns the default printer. 
//
//////////////////////////////////////////////////////////////////////////////
//
// Revision History
//
//	Version
//	1.0 Initial version
//
//////////////////////////////////////////////////////////////////////////////

Environment lenv_environment
String ls_printer

GetEnvironment(lenv_environment)

CHOOSE CASE lenv_environment.OSType
	CASE Windows!
		RegistryGet('HKEY_LOCAL_MACHINE\Config\0001\System\CurrentControlSet\Control\Print\Printers', 'default', ls_printer)
	CASE WindowsNT!
		RegistryGet('HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows', 'Device', ls_printer)
		ls_printer = LeftA(ls_printer, PosA(ls_printer, ',') - 1)
	CASE ELSE
		SetNull(ls_printer)
END CHOOSE

RETURN ls_printer

end function

public function string of_getprinterdriver (string as_printer);//////////////////////////////////////////////////////////////////////////////
//
// Function:     of_GetPrinterDriver
//
// Access:       Public
//
// Arguments:    as_printer
//
// Returns:      String.  The printer driver (null if not supported).
//
// Description:  Returns the printer driver.
//
//////////////////////////////////////////////////////////////////////////////
//
// Revision History
//
//	Version
//	1.0 Initial version
//
//////////////////////////////////////////////////////////////////////////////

Environment lenv_environment
String ls_driver

GetEnvironment(lenv_environment)

CHOOSE CASE lenv_environment.OSType
	CASE Windows!
		RegistryGet('HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Print\Printers\' + as_printer, 'Printer Driver', ls_driver)
	CASE WindowsNT!
		RegistryGet('HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Devices', as_printer, ls_driver)
	CASE ELSE
		SetNull(ls_driver)
END CHOOSE

RETURN ls_driver

end function

public function string of_getprinterport (string as_printer);//////////////////////////////////////////////////////////////////////////////
//
// Function:     of_GetPrinterPort
//
// Access:       Public
//
// Arguments:    as_printer
//
// Returns:      String.  The printer port (null if not supported).
//
// Description:  Returns the printer port.
//
//////////////////////////////////////////////////////////////////////////////
//
// Revision History
//
//	Version
//	1.0 Initial version
//
//////////////////////////////////////////////////////////////////////////////

Environment lenv_environment
String ls_port

GetEnvironment(lenv_environment)

CHOOSE CASE lenv_environment.OSType
	CASE Windows!
		RegistryGet('HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Print\Printers\' + as_printer, 'Port', ls_port)
	CASE WindowsNT!
		ls_port = ''
	CASE ELSE
		SetNull(ls_port)
END CHOOSE

RETURN ls_port

end function

public function integer of_setdefaultprinter (string as_printer);//////////////////////////////////////////////////////////////////////////////
//
// Function:     of_SetDefaultPrinter
//
// Access:       Public
//
// Arguments:    as_printer
//
// Returns:      Integer.  Success or Failure
//
// Description:  Sets the default printer.
//
//////////////////////////////////////////////////////////////////////////////
//
// Revision History
//
//	Version
//	1.0 Initial version
//
//////////////////////////////////////////////////////////////////////////////

Environment lenv_environment

GetEnvironment(lenv_environment)

CHOOSE CASE lenv_environment.OSType
	CASE Windows!
		IF RegistrySet('HKEY_LOCAL_MACHINE\Config\0001\System\CurrentControlSet\Control\Print\Printers', 'default', as_printer) = -1 THEN RETURN FAILURE
		IF SetProfileString(This.of_GetWindowsDirectory() + '\win.ini', 'Windows', 'device', as_printer + ',' + This.of_GetPrinterDriver(as_printer) + ',' + This.of_GetPrinterPort(as_printer)) = -1 THEN RETURN FAILURE
		RETURN SUCCESS
	CASE WindowsNT!
		IF RegistrySet('HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows', 'Device', as_printer + ',' + This.of_GetPrinterDriver(as_printer)) = -1 THEN RETURN FAILURE
		RETURN SUCCESS
	CASE ELSE
		RETURN FAILURE
END CHOOSE

RETURN FAILURE

end function

public function long of_getfonts (ref string as_fontname[]);//////////////////////////////////////////////////////////////////////////////
//
// Function:     of_GetFonts
//
// Access:       Public
//
// Arguments:    as_fontname[] - (ref) the font name array
//
// Returns:      Long.  Then number of installed fonts
//
// Description:  Returns the installed fonts.
//
//////////////////////////////////////////////////////////////////////////////
//
// Revision History
//
//	Version
//	1.0 Initial version
//
//////////////////////////////////////////////////////////////////////////////

String ls_key
Environment lenv_current

GetEnvironment(lenv_current)
IF lenv_current.OSType = WindowsNT! THEN
	ls_key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts'
ELSE
	ls_key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Fonts'
END IF

IF RegistryValues(ls_key, as_fontname) < 0 THEN RETURN -1
RETURN UpperBound(as_fontname)

end function

public function string of_browseforprinter (string as_title, ref window aw_requestor);//////////////////////////////////////////////////////////////////////////////
//
// Function:     of_BrowseForPrinter
//
// Access:       Public
//
// Arguments:    as_title     - text to display in browse dialog
//               aw_requestor - the requesting window
//
// Returns:      String.  The selected printer name if successful, or a NULL
//               string if an error occurrs.
//
// Description:  Displays the shell printer browse dialog box and enables the
//               user to select a specific printer by name.
//
//////////////////////////////////////////////////////////////////////////////
//
// Revision History
//
//	Version
//	1.0 Initial version
//
//////////////////////////////////////////////////////////////////////////////

os_BrowseInfo lstr_bi
String  ls_null, ls_name, ls_title, ls_path, ls_printer
Long    ll_pidl, ll_null
Integer li_image

SetNull(ls_null)
SetNull(ll_Null)
ls_name = Space(256)
ls_title = as_title + CharA(0)

lstr_bi.hWndOwner      = Handle(aw_requestor)
lstr_bi.pidlRoot       = ll_Null
lstr_bi.pszDisplayName = ls_name
lstr_bi.lpszTitle      = ls_title
lstr_bi.ulFlags        = BIF_BROWSEFORPRINTER
lstr_bi.lpfn           = ll_null
lstr_bi.lParam         = ll_null
lstr_bi.iImage         = li_image

ll_pidl = SHBrowseForFolder(lstr_bi)
IF ll_pidl > 0 THEN
	ls_path = Space(256)
	IF SHGetPathFromIDList(ll_pidl, ls_path) THEN
		ls_printer = ls_path + lstr_bi.pszDisplayName
		RETURN ls_printer
	END IF
END IF

RETURN ls_null

end function

public function long of_getprinters (ref string as_printer[]);//////////////////////////////////////////////////////////////////////////////
//
// Function:     of_GetPrinters
//
// Access:       Public
//
// Arguments:    as_printer[] by reference
//
// Returns:      Long.  The number of printers (-1 if error, or not supported)
//
// Description:  Returns the printers.
//
//////////////////////////////////////////////////////////////////////////////
//
// Revision History
//
//	Version
//	1.0 Initial version
//
//////////////////////////////////////////////////////////////////////////////

Environment lenv_environment
String ls_printer[]

GetEnvironment(lenv_environment)

CHOOSE CASE lenv_environment.OSType
	CASE Windows!
		// Modificaci$$HEX1$$f300$$ENDHEX$$n Paco : pon$$HEX1$$ed00$$ENDHEX$$a registryvalues , lo he cambiado por registrykeys
		IF RegistryKeys('HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Print\Printers\', ls_printer) = -1 THEN RETURN -1
	CASE WindowsNT!
		IF RegistryValues('HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Devices', ls_printer) = -1 THEN RETURN -1
	CASE ELSE
		RETURN -1
END CHOOSE

as_printer = ls_printer
RETURN UpperBound(as_printer)

end function

on n_cst_printer_new.create
call super::create
end on

on n_cst_printer_new.destroy
call super::destroy
end on

