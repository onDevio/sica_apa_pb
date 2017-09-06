HA$PBExportHeader$n_esperar_proceso.sru
forward
global type n_esperar_proceso from nonvisualobject
end type
end forward

global type n_esperar_proceso from nonvisualobject
end type
global n_esperar_proceso n_esperar_proceso

type prototypes
FUNCTION ulong FindWindowA(ulong classname, String windowname) LIBRARY "user32.dll" alias for "FindWindowA;Ansi"
FUNCTION boolean PostMessageA(ulong hwndle,UINT wmsg,ulong wParam,ulong lParam) LIBRARY "user32.dll"
function ulong WaitForSingleObject (ulong handle, ulong milliseconds) library "kernel32.dll" 
function long GetWindowThreadProcessId (long hWnd, ref long lpdwProcessId) library "user32.dll"

function long OpenProcess (long dwDesiredAccess, long bInheritHandle, long dwProcessId) library "kernel32.dll"
function long  CloseHandle( long hObject ) library "kernel32.dll";

end prototypes

type variables

end variables

forward prototypes
public function integer f_esperar_proceso (string proceso)
end prototypes

public function integer f_esperar_proceso (string proceso);ulong     lul_handle
long aux,id,dev_wait,dev_open,dev_getwin
string    ls_app
CONSTANT uint WM_QUIT = 18
constant ulong INFINITE = 4294967295 

ls_app = proceso

lul_handle = FindWindowA(0, ls_app)

IF lul_handle > 0 THEN 
   dev_getwin=GetWindowThreadProcessId(lul_handle,aux)
	dev_open = OpenProcess(2035711,0,aux)
	//dev_wait = WaitForSingleObject(dev_open,INFINITE)
	// Limitamos la espera a 15 sec
	dev_wait = WaitForSingleObject(dev_open,15000)
	CloseHandle (dev_open)
	return 1
ELSE
	return -1
END IF



end function

on n_esperar_proceso.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_esperar_proceso.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

