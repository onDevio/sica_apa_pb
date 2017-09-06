HA$PBExportHeader$n_winsock.sru
$PBExportComments$Winsock functions
forward
global type n_winsock from nonvisualobject
end type
type wsadata from structure within n_winsock
end type
type hostent from structure within n_winsock
end type
type sockaddr from structure within n_winsock
end type
end forward

type wsadata from structure
	unsignedinteger		wversion
	unsignedinteger		whighversion
	character		szdescription[257]
	character		szsystemstatus[129]
	unsignedinteger		imaxsockets
	unsignedinteger		imaxudpdg
	string		lpvenderinfo
end type

type hostent from structure
	unsignedlong		h_name
	unsignedlong		h_aliases
	integer		h_addrtype
	integer		h_length
	unsignedlong		h_addr_list
end type

type sockaddr from structure
	integer		sin_family
	unsignedinteger		sin_port
	blob{4}		sin_addr
	blob{8}		sin_zero
end type

global type n_winsock from nonvisualobject autoinstantiate
end type

type prototypes
Subroutine CopyMemoryIP ( &
	Ref structure Destination, &
	ulong Source, &
	long Length &
	) Library  "kernel32.dll" Alias For "RtlMoveMemory;ansi"

Subroutine CopyMemoryIP ( &
	Ref blob Destination, &
	ulong Source, &
	long Length &
	) Library  "kernel32.dll" Alias For "RtlMoveMemory;ansi"

Subroutine CopyMemoryIP ( &
	Ref ulong Destination, &
	ulong Source, &
	long Length &
	) Library  "kernel32.dll" Alias For "RtlMoveMemory;ansi"

Function ulong FormatMessage( &
	ulong dwFlags, &
	ulong lpSource, &
	ulong dwMessageId, &
	ulong dwLanguageId, &
	Ref string lpBuffer, &
	ulong nSize, &
	ulong Arguments &
	) Library "kernel32.dll" Alias For "FormatMessageA;ansi"

Function long WNetGetUser ( &
	string lpname, &
	Ref string lpusername, &
	Ref long buflen &
	) Library "mpr.dll" Alias For "WNetGetUserA;ansi"

Function uint accept ( &
	uint socket, &
	sockaddr addr, &
	Ref integer addrlen &
	) Library "ws2_32.dll" alias for "accept;ansi"

Function integer bind ( &
	uint socket, &
	sockaddr name, &
	integer namelen &
	)  Library "ws2_32.dll"

Function integer closesocket ( &
	uint socket &
	) Library "ws2_32.dll"

Function ulong gethostbyname ( &
	string name &
	) Library "ws2_32.dll" Alias For "gethostbyname;ansi"

Function integer gethostname ( &
	Ref string name, &
	integer namelen &
	) Library "ws2_32.dll" Alias For "gethostname;ansi"

Function integer getsockopt ( &
	uint socket, &
	long level, &
	long optname, &
	ref long optval, &
	ref long optlen &
	) Library "ws2_32.dll"  

Function integer htons ( &
	integer hostshort &
	) Library "ws2_32.dll"  

Function integer listen ( &
	uint socket, &
	integer backlog &
	) Library "ws2_32.dll"  

Function integer recv ( &
	uint socket, &
	Ref blob buf, &
	integer len, &
	int flags &
	) Library "ws2_32.dll" 

Function integer send ( &
	uint socket, &
	Ref blob buf, &
	integer len, &
	integer flags &
	) Library "ws2_32.dll"  

Function uint socket ( &
	int af, &
	int ttype, &
	int protocol &
	) Library "ws2_32.dll"  

Function integer wsconnect ( &
	uint socket, &
	sockaddr name, &
	integer namelen &
	) Library "ws2_32.dll" Alias For "connect;ansi"

Function integer WSACleanup ( &
	) Library "ws2_32.dll"

Function integer WSAGetLastError ( &
	) Library "ws2_32.dll"  

Function integer WSAStartup ( &
	long wVersionRequested, &
	Ref wsadata lpWSAData &
	) Library "ws2_32.dll" Alias For "WSAStartup;ansi"

Function integer WSAAsyncSelect ( &
	uint socket, &
	long hWnd, &
	integer wMsg, &
	integer lEvent &
	) Library "ws2_32.dll"  

Function boolean CryptBinaryToString ( &
	Blob pbBinary, &
	ulong cbBinary, &
	ulong dwFlags, &
	Ref string pszString, &
	Ref ulong pcchString &
	) Library "crypt32.dll" Alias For "CryptBinaryToStringA;ansi"

Function boolean CryptStringToBinary ( &
	string pszString, &
	ulong cchString, &
	ulong dwFlags, &
	Ref blob pbBinary, &
	Ref ulong pcbBinary, &
	Ref ulong pdwSkip, &
	Ref ulong pdwFlags &
	) Library "crypt32.dll" Alias For "CryptStringToBinaryA;ansi"

end prototypes

type variables
Private:
wsadata istr_wsadata
Boolean ib_initialized
Boolean ib_send_unicode = True
Boolean ib_recv_unicode = True

Public:
Constant Integer MAX_RECV_BUFFER = 32766
Constant Integer MAX_SEND_BUFFER = 8192

end variables

forward prototypes
public function string of_geterrormsg (unsignedlong aul_error)
public function string of_getdescription ()
public function string of_gethostname ()
public function unsignedinteger of_accept (unsignedinteger aui_socket)
public function integer of_close (ref unsignedinteger aui_socket)
public function string of_getuserid ()
public function integer of_startup ()
public function string of_getlasterror ()
public function unsignedinteger of_listen (integer ai_port, long al_handle, integer ai_event)
public function integer of_cleanup ()
public function string of_encode64 (blob ablob_data)
public function blob of_decode64 (string as_encoded)
public function integer of_send (unsignedinteger aui_socket, blob ablob_data)
public function integer of_send (unsignedinteger aui_socket, string as_data)
public function integer of_recv (unsignedinteger aui_socket, ref string as_data)
public function integer of_recv (unsignedinteger aui_socket, ref blob ablob_data)
public subroutine of_setunicode (boolean ab_send, boolean ab_recv)
public function long of_getsockopt_long (unsignedinteger aui_socket, string as_optname)
public function unsignedinteger of_connect (string as_hostname, integer ai_port)
end prototypes

public function string of_geterrormsg (unsignedlong aul_error);// -----------------------------------------------------------------------------
// SCRIPT:     n_winsock.of_GetErrorMsg
//
// PURPOSE:    This function returns the error message that goes
//					with the error code from GetLastError.
//
// ARGUMENTS:  aul_error - Error code from GetLastError
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 08/12/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant ULong FORMAT_MESSAGE_FROM_SYSTEM = 4096
Constant ULong LANG_NEUTRAL = 0
String ls_buffer
ULong lul_rtn

ls_buffer = Space(200)

lul_rtn = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0, &
				aul_error, LANG_NEUTRAL, ls_buffer, 200, 0)

Return Trim(ls_buffer)

end function

public function string of_getdescription ();// -----------------------------------------------------------------------------
// SCRIPT:     n_winsock.of_GetDescription
//
// PURPOSE:    This function returns the winsock description.
//
// RETURN:     String containing a description of the
//					winsock library.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 08/12/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------

Blob lblob_desc

Return istr_wsadata.szDescription

end function

public function string of_gethostname ();// -----------------------------------------------------------------------------
// FUNCTION:	n_winsock.of_GetHostName
//
// PURPOSE:		This function retrieves the standard host name
//					for the local computer.
//
// RETURN:		Host name
//
// DATE			PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------	--------		-----------------------------------------------------
// 08/12/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------

String ls_hostname, ls_errmsg
Integer li_rc, li_namelen

li_namelen = 32
ls_hostname = Space(li_namelen)

li_rc = gethostname(ls_hostname, li_namelen)
If li_rc <> 0 Then
	ls_errmsg = of_GetLastError()
//	MessageBox(	"Winsock Error in of_GetHostName", &
//					ls_errmsg, StopSign!)
End If

Return ls_hostname

end function

public function unsignedinteger of_accept (unsignedinteger aui_socket);// -----------------------------------------------------------------------------
// SCRIPT:     n_winsock.of_Accept
//
// PURPOSE:    This function permits an incoming connection
//					attempt on a socket.
//
// ARGUMENTS:  aui_socket - Open socket
//
// RETURN:     >0 = Success
//					-1 = Error
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 08/12/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant Integer MAXGETSOCKADDRSTRUCT = 16
Integer li_socket, li_length
sockaddr lstr_sockaddr
String ls_errmsg

li_length = MAXGETSOCKADDRSTRUCT

li_socket = accept(aui_socket, lstr_sockaddr, li_length)
If li_socket < 1 Then
	ls_errmsg = of_GetLastError()
//	MessageBox(	"Winsock Error in of_Accept", &
//					ls_errmsg, StopSign!)
	Return -1
End If

Return li_socket

end function

public function integer of_close (ref unsignedinteger aui_socket);// -----------------------------------------------------------------------------
// SCRIPT:     n_winsock.of_Close
//
// PURPOSE:    This function closes an open socket.
//
// ARGUMENTS:  aui_socket - Open socket
//
// RETURN:      0 = Success
//					-1 = Error
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 08/12/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------

Integer li_rc
String ls_errmsg

li_rc = closesocket(aui_socket)
If li_rc = 0 Then
	aui_socket = 0
Else
	ls_errmsg = of_GetLastError()
//	MessageBox(	"Winsock Error in of_Close", &
//					ls_errmsg, StopSign!)
	Return -1
End If

Return 0

end function

public function string of_getuserid ();// -----------------------------------------------------------------------------
// FUNCTION:	n_winsock.of_GetUserid
//
// PURPOSE:		This function retrieves the userid used to establish
//					the current network connection.
//
// RETURN:		The userid or empty string if error occurred.
//
// DATE			PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------	--------		-----------------------------------------------------
// 08/12/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------

String ls_userid, ls_errmsg
Long ll_result, ll_buflen

ll_buflen = 32
ls_userid = Space(ll_buflen)

ll_result = WNetGetUser("", ls_userid, ll_buflen)
If ll_result <> 0 Then
	ls_errmsg = of_GetErrorMsg(ll_result)
//	MessageBox(	"Network Error in of_GetUserid", &
//					ls_errmsg, StopSign!)
End If

Return ls_userid

end function

public function integer of_startup ();// -----------------------------------------------------------------------------
// SCRIPT:     n_winsock.of_Startup
//
// PURPOSE:    This function initiates use of the socket library.
//
// RETURN:      0 = Success
//					-1 = Error
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 08/12/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------

Integer li_rc
String ls_errmsg

If Not ib_initialized Then
	li_rc = wsastartup(257, istr_wsadata)
	If li_rc = 0 Then
		ib_initialized = True
	Else
		ls_errmsg = of_GetErrorMsg(li_rc)
//		MessageBox("Winsock Error in of_Startup: ", &
//				ls_errmsg, StopSign!)
		Return -1
	End If
End If

Return 0

end function

public function string of_getlasterror ();// -----------------------------------------------------------------------------
// FUNCTION:	n_winsock.of_GetLastError
//
// PURPOSE:		This function returns the message text for
//					the most recent Winsock error.
//
// RETURN:		Counter value
//
// DATE			PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------	--------		-----------------------------------------------------
// 08/12/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------

ULong lul_error
String ls_errmsg

lul_error = WSAGetLastError()

If lul_error = 0 Then
	ls_errmsg = "An unknown error has occurred!"
Else
	ls_errmsg = of_GetErrorMsg(lul_error)
End If

Return ls_errmsg

end function

public function unsignedinteger of_listen (integer ai_port, long al_handle, integer ai_event);// -----------------------------------------------------------------------------
// SCRIPT:     n_winsock.of_Listen
//
// PURPOSE:    This function opens a socket and Listens.
//
// ARGUMENTS:  ai_port	 - Port number
//					al_handle - Handle of object to receive messages
//					ai_event  - pbm_customxx event to receive messages
//
// RETURN:      0 = Error
//					>0 = Success
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 08/12/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant Integer WM_USER = 1024
Constant Integer AF_INET = 2
Constant Integer SOCK_STREAM = 1
Constant Integer MAXGETSOCKADDRSTRUCT = 16
Constant Integer FD_ACCEPT = 8
hostent lstr_hostent
sockaddr lstr_sockaddr
String ls_errmsg, ls_hostname
UInt lui_socket
ULong lul_ptr, lul_ipaddr

// get information about host
ls_hostname = of_GetHostname()
lul_ptr = gethostbyname(ls_hostname)

If lul_ptr > 0 Then
	CopyMemoryIp(lstr_hostent, lul_ptr, MAXGETSOCKADDRSTRUCT)
	CopyMemoryIp(lul_ipaddr, lstr_hostent.h_Addr_List, lstr_hostent.h_Length)
	CopyMemoryIp(lstr_sockaddr.sin_addr, lul_ipaddr, lstr_hostent.h_Length)
	lstr_sockaddr.sin_family = AF_INET
	lstr_sockaddr.sin_port = htons(ai_port)
	lui_socket = socket(AF_INET, SOCK_STREAM, 0)
	If bind(lui_socket, lstr_sockaddr, MAXGETSOCKADDRSTRUCT) = -1 Then
		ls_errmsg = of_GetLastError()
//		MessageBox(	"Winsock Error in of_Listen", &
//						ls_errmsg, StopSign!)
		lui_socket = 0
	Else
		If WSAASyncSelect(lui_socket, al_handle, WM_USER + (ai_event - 1), FD_ACCEPT) = -1 Then
			ls_errmsg = of_GetLastError()
//			MessageBox(	"Winsock Error in of_Listen", &
//							ls_errmsg, StopSign!)
			lui_socket = 0
		Else
			If listen(lui_socket, 10) = -1 Then
				ls_errmsg = of_GetLastError()
//				MessageBox(	"Winsock Error in of_Listen", &
//								ls_errmsg, StopSign!)
				lui_socket = 0
			End If
		End If
	End If
Else
	ls_errmsg = of_GetLastError()
//	MessageBox(	"Winsock Error in of_Listen", &
//					ls_errmsg, StopSign!)
	lui_socket = 0
End If

Return lui_socket

end function

public function integer of_cleanup ();// -----------------------------------------------------------------------------
// SCRIPT:     n_winsock.of_Cleanup
//
// PURPOSE:    This function terminates use of the socket library.
//
// RETURN:      0 = Success
//					-1 = Error
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 08/12/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------

Integer li_rc
String ls_errmsg

If ib_initialized Then
	li_rc = wsacleanup()
	If li_rc = 0 Then
		ib_initialized = False
	Else
		ls_errmsg = of_GetLastError()
//		MessageBox(	"Winsock Error in of_Cleanup", &
//						ls_errmsg, StopSign!)
		Return -1
	End If
End If

Return 0

end function

public function string of_encode64 (blob ablob_data);// -----------------------------------------------------------------------------
// SCRIPT:     n_winsock.of_Encode64
//
// PURPOSE:    This function converts binary data to a Base64 encoded string.
//
//					Note: Requires Windows XP or Server 2003
//
// ARGUMENTS:  ablob_data - Blob containing data
//
// RETURN:     String containing encoded data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant ULong CRYPT_STRING_BASE64 = 1
String ls_encoded
ULong lul_len, lul_buflen
Boolean lb_rtn

lul_len = Len(ablob_data)

lul_buflen = lul_len * 2

ls_encoded = Space(lul_buflen)

lb_rtn = CryptBinaryToString(ablob_data, &
				lul_len, CRYPT_STRING_BASE64, &
				ls_encoded, lul_buflen)
If Not lb_rtn Then ls_encoded = ""

Return ls_encoded

end function

public function blob of_decode64 (string as_encoded);// -----------------------------------------------------------------------------
// SCRIPT:     n_winsock.of_Decode64
//
// PURPOSE:    This function converts a Base64 encoded string to binary.
//
//					Note: Requires Windows XP or Server 2003
//
// ARGUMENTS:  as_encoded - String containing encoded data
//
// RETURN:     Blob containing decoded data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant ULong CRYPT_STRING_BASE64 = 1
Blob lblob_data
ULong lul_len, lul_buflen, lul_skip, lul_pflags
Boolean lb_rtn

lul_len = Len(as_encoded)
lul_buflen = lul_len
lblob_data = Blob(Space(lul_len), EncodingANSI!)

lb_rtn = CryptStringToBinary(as_encoded, &
					lul_len, CRYPT_STRING_BASE64, lblob_data, &
					lul_buflen, lul_skip, lul_pflags)

Return BlobMid(lblob_data, 1, lul_buflen)

end function

public function integer of_send (unsignedinteger aui_socket, blob ablob_data);// -----------------------------------------------------------------------------
// SCRIPT:     n_winsock.of_Send
//
// PURPOSE:    This function sends data on a connected socket.
//
// ARGUMENTS:  aui_socket	- Open socket
//					ablob_data	- Data to send
//
// RETURN:     Number of bytes successfully sent
//					-1 if an error occurred
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 08/12/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------

Integer li_rc
String ls_errmsg

li_rc = send(aui_socket, ablob_data, Len(ablob_data), 0)
If li_rc = -1 Then
	ls_errmsg = of_GetLastError()
//	MessageBox(	"Winsock Error in of_Send", &
//					ls_errmsg, StopSign!)
End If

Return li_rc

end function

public function integer of_send (unsignedinteger aui_socket, string as_data);// -----------------------------------------------------------------------------
// SCRIPT:     n_winsock.of_Send
//
// PURPOSE:    This function sends data on a connected socket.
//
// ARGUMENTS:  aui_socket	- Open socket
//					as_data		- Data to send
//
// RETURN:     Number of bytes successfully sent
//					-1 if an error occurred
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 08/12/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------

Blob lblb_data
String ls_errmsg

If ib_send_unicode Then
	//lblb_data = ToUnicode(as_data)
	lblb_data = Blob(as_data)
Else
	lblb_data = Blob(as_data, EncodingANSI!)
End If

Return of_Send(aui_socket, lblb_data)

end function

public function integer of_recv (unsignedinteger aui_socket, ref string as_data);// -----------------------------------------------------------------------------
// SCRIPT:     n_winsock.of_Recv
//
// PURPOSE:    This function receives data from a connected socket.
//
// ARGUMENTS:  aui_socket	- Open socket
//					as_data		- By ref string
//
// RETURN:     Length of the returned data
//					-1 if an error occurred
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 08/12/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------
Blob lblob_data
Integer li_rc
String ls_errmsg

li_rc = of_Recv(aui_socket, lblob_data)
If li_rc = -1 Then
	SetNull(as_data)
Else
	If ib_recv_unicode Then
		//as_data = FromUnicode(lblob_data)
		as_data = String(lblob_data)
	Else
		as_data = String(lblob_data, EncodingANSI!)
	End If
End If

Return li_rc

end function

public function integer of_recv (unsignedinteger aui_socket, ref blob ablob_data);// -----------------------------------------------------------------------------
// SCRIPT:     n_winsock.of_Recv
//
// PURPOSE:    This function receives data from a connected socket.
//
// ARGUMENTS:  aui_socket	- Open socket
//					ablob_data	- By ref blob
//
// RETURN:     Length of the returned data
//					-1 if an error occurred
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 08/12/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------

Integer li_bytes
String ls_errmsg

ablob_data = Blob(Space(MAX_RECV_BUFFER), EncodingANSI!)

li_bytes = recv(aui_socket, ablob_data, MAX_RECV_BUFFER, 0)
If li_bytes = -1 Then
	ls_errmsg = of_GetLastError()
//	MessageBox(	"Winsock Error in of_Recv", &
//					ls_errmsg, StopSign!)
Else
	ablob_data = BlobMid(ablob_data, 1, li_bytes)
End If

Return li_bytes

end function

public subroutine of_setunicode (boolean ab_send, boolean ab_recv);// -----------------------------------------------------------------------------
// SCRIPT:     n_winsock.of_SetUnicode
//
// PURPOSE:    This function sets Unicode data option.
//
// ARGUMENTS:  ab_send - of_Send Unicode setting
//					ab_recv - of_Recv Unicode setting
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/06/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

ib_send_unicode = ab_send
ib_recv_unicode = ab_recv



end subroutine

public function long of_getsockopt_long (unsignedinteger aui_socket, string as_optname);// -----------------------------------------------------------------------------
// SCRIPT:     n_winsock.of_GetSockOpt_Long
//
// PURPOSE:    This function returns options that use long datatype.
//
// ARGUMENTS:  aui_socket	- Open socket
//					as_optname	- Option name
//
// RETURN:		Buffer size
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 02/03/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant Long SOL_SOCKET = 65535
Long ll_buflen, ll_optname, ll_optvalue
String ls_errmsg
Integer li_rc

ll_buflen = 4

choose case Upper(as_optname)
	case "SO_ERROR"
		ll_optname = 4103
	case "SO_RCVBUF"
		ll_optname = 4098
	case "SO_SNDBUF"
		ll_optname = 4097
	case "SO_TYPE"
		ll_optname = 4104
	case else
		ls_errmsg = "Invalid Option Provided: " + as_optname
//		MessageBox(	"Winsock Error in of_GetSockOpt", &
//						ls_errmsg, StopSign!)
end choose

// get option value
li_rc = getsockopt(aui_socket, SOL_SOCKET, &
				ll_optname, ll_optvalue, ll_buflen)
If li_rc = -1 Then
	ls_errmsg = of_GetLastError()
//	MessageBox(	"Winsock Error in of_GetSockOpt", &
//					ls_errmsg, StopSign!)
End If

Return ll_optvalue

end function

public function unsignedinteger of_connect (string as_hostname, integer ai_port);// -----------------------------------------------------------------------------
// SCRIPT:     n_winsock.of_Connect
//
// PURPOSE:    This function opens a socket for SEND and RECV.
//
// ARGUMENTS:  as_hostname - Hostname
//					ai_port		- Port
//
// RETURN:      0 = Error
//					>0 = Success
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 08/12/2004	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant Integer AF_INET = 2
Constant Integer SOCK_STREAM = 1
Constant Integer MAXGETSOCKADDRSTRUCT = 16
hostent lstr_hostent
sockaddr lstr_sockaddr
String ls_errmsg
UInt lui_socket
ULong lul_ptr, lul_ipaddr

// get information about host
lul_ptr = gethostbyname(as_hostname)

If lul_ptr > 0 Then
	CopyMemoryIp(lstr_hostent, lul_ptr, MAXGETSOCKADDRSTRUCT)
	CopyMemoryIp(lul_ipaddr, lstr_hostent.h_Addr_List, lstr_hostent.h_Length)
	CopyMemoryIp(lstr_sockaddr.sin_addr, lul_ipaddr, lstr_hostent.h_Length)
	lstr_sockaddr.sin_family = AF_INET
	lstr_sockaddr.sin_port = htons(ai_port)
	lui_socket = socket(AF_INET, SOCK_STREAM, 0)
	If wsconnect(lui_socket, lstr_sockaddr, MAXGETSOCKADDRSTRUCT) = -1 Then
		ls_errmsg = of_GetLastError()
//		MessageBox(	"Error en la funcion of_Connect del Socket", &
//						ls_errmsg, StopSign!)
		lui_socket = 0
	End if
Else
	ls_errmsg = of_GetLastError()
//	MessageBox(	"Error en la funcion of_Connect del Socket", &
//					ls_errmsg, StopSign!)
	lui_socket = 0
End If

Return lui_socket

end function

on n_winsock.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_winsock.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// sockets not initialized
ib_initialized = False

end event

event destructor;// perform cleanup
of_Cleanup()

end event

