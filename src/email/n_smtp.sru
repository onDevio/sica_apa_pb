HA$PBExportHeader$n_smtp.sru
$PBExportComments$Funciones de envio por smtp
forward
global type n_smtp from n_winsock
end type
type uuid from structure within n_smtp
end type
end forward

type uuid from structure
	unsignedlong		data1
	integer		data2
	integer		data3
	blob		data4
end type

global type n_smtp from n_winsock
end type

type prototypes
Function ulong CreateFile ( &
	string lpFileName, &
	ulong dwDesiredAccess, &
	ulong dwShareMode, &
	ulong lpSecurityAttributes, &
	ulong dwCreationDisposition, &
	ulong dwFlagsAndAttributes, &
	ulong hTemplateFile &
	) Library "kernel32.dll" Alias For "CreateFileA;ansi"

Function boolean CloseHandle ( &
	ulong hObject &
	) Library "kernel32.dll"

Function boolean ReadFile ( &
	ulong hFile, &
	Ref blob lpBuffer, &
	ulong nNumberOfBytesToRead, &
	Ref ulong lpNumberOfBytesRead, &
	ulong lpOverlapped &
	) Library "kernel32.dll"

Function long UuidCreate ( &
	Ref UUID pId &
	) Library "rpcrt4.dll"

Function long UuidToString ( &
	Ref UUID Uuid, &
	Ref ulong StringUuid &
	) Library "rpcrt4.dll" Alias For "UuidToStringA;ansi"

Function long RpcStringFree ( &
	Ref ulong pString &
	) Library "rpcrt4.dll" Alias For "RpcStringFreeA;ansi"

Subroutine CopyMemory ( &
	Ref string Destination, &
	ulong Source, &
	long Length &
	) Library  "kernel32.dll" Alias For "RtlMoveMemory;ansi"

Function long FindMimeFromData ( &
	ulong pBC, &
	blob pwzUrl, &
	blob pBuffer, &
	ulong cbSize, &
	ulong pwzMimeProposed, &
	ulong dwMimeFlags, &
	ref ulong ppwzMimeOut, &
	ulong dwReserved &
	) Library "urlmon.dll"

Function long SendStringMessage ( &
	long hWnd, &
	uint Msg, &
	Ref string wParam, &
	long lParam &
	) Library "user32.dll" Alias For "SendMessageA;ansi"

FUNCTION int Base64Decode ( &
	ref string source, &
	ref string result, &
	int n &
	) LIBRARY "BASE64.DLL" ALIAS FOR "Base64Decode;ansi"
	
	
FUNCTION int Base64Encode ( &
	ref string source, &
	ref string result, &
	int n &
	) LIBRARY "BASE64.DLL" ALIAS FOR "Base64Decode;ansi"
end prototypes

type variables
public:
integer ii_error  // Codificaci$$HEX1$$f300$$ENDHEX$$n de errores

Private:

Constant	String CRLF = Char(13) + Char(10)

Boolean ib_html
Boolean ib_receipt
Boolean ib_authenticate

Integer ii_port = 25
Integer ii_wevent

Long il_whandle

String is_userid
String is_passwd
String is_server
String is_subject
String is_body
String is_FromEmail
String is_FromName
String is_ToEmail[]
String is_ToEmailReset[]
String is_ToName[]
String is_CcEmail[]
String is_CcName[]
String is_BccEmail[]
String is_BccName[]
String is_AttachFile[]

Uint iui_socket


string is_base64[]={'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z', &
						  'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',  &
						  '0','1','2','3','4','5','6','7','8','9','+','/','='}

end variables

forward prototypes
public subroutine of_setport (integer ai_port)
public subroutine of_setserver (string as_server)
public subroutine of_setsubject (string as_subject)
public subroutine of_setfrom (string as_email, string as_name)
public function integer of_addcc (string as_email)
public function integer of_addto (string as_email)
public function boolean of_sendmail ()
public function integer of_addfile (string as_filename)
public subroutine of_reset ()
public subroutine of_setlogin (string as_userid, string as_passwd)
private function boolean of_auth ()
private function boolean of_sendmsg (string as_cmd)
public subroutine of_setbody (string as_body, boolean ab_html)
public subroutine of_setreceipt (boolean ab_receipt)
public subroutine of_setfrom (string as_email)
public function integer of_addto (string as_email, string as_name)
public function integer of_addcc (string as_email, string as_name)
public function integer of_addbcc (string as_email)
public function integer of_addbcc (string as_email, string as_name)
private function string of_encode64 (string as_data)
private function string of_generate_guid ()
public function string of_unicode_to_string (unsignedlong aul_ptr)
public subroutine of_setwinhandle (long al_handle, integer ai_event)
private function string of_data ()
private function string of_findmimefromdata (string as_filename, ref blob ablob_filedata)
private function boolean of_readfile (string as_filename, ref blob ablob_data)
private subroutine of_sendstatus (string as_msg)
public function string of_codificar64 (string cadena)
public function string of_int2bin (long numero)
public function long of_bin2int (string cadena_binaria)
public function string of_codificar64 (blob fichero)
public function boolean of_csd_conexion ()
public function boolean of_csd_enviar_datos ()
public function boolean of_csd_cerrar_conexion ()
public function integer of_csd_addto_unico (string as_email)
public function integer of_csd_addcc_unico (string as_email)
public function integer of_csd_addbcc_unico (string as_email)
public function integer of_csd_addto_reset ()
public function integer of_csd_addto_limitado (string as_email, string limite)
public function integer of_csd_addtocc_limitado (string as_email, string limite)
public function integer of_csd_addtocc_reset ()
public function integer of_csd_addtocco_limitado (string as_email, string limite)
public function integer of_csd_addtocco_reset ()
public subroutine of_initializeport ()
end prototypes

public subroutine of_setport (integer ai_port);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetPort
//
// PURPOSE:    This function is used to set the port the server is using.
//					The default is 25 and usually does not need to change.
//
// ARGUMENTS:  ai_port - Server port
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

ii_port = ai_port

end subroutine

public subroutine of_setserver (string as_server);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetServer
//
// PURPOSE:    This function is used to set the server name
//
// ARGUMENTS:  as_server - Server name
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

is_server = as_server

end subroutine

public subroutine of_setsubject (string as_subject);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetSubject
//
// PURPOSE:    This function is used to set the message subject.
//
// ARGUMENTS:  as_subject - Subject
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

is_subject = as_subject

end subroutine

public subroutine of_setfrom (string as_email, string as_name);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetFrom
//
// PURPOSE:    This function is used to set the sender's
//					email address and name.
//
// ARGUMENTS:  as_email - Sender's Email address
//					as_name	- Sender's Name
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

is_FromEmail = as_email
is_FromName = as_name

end subroutine

public function integer of_addcc (string as_email);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_AddCc
//
// PURPOSE:    This function is used to add a CC send to
//					email address.
//
// ARGUMENTS:  as_email - Email address
//
// RETURN:     Index to To array
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

Integer li_next

li_next = UpperBound(is_CcEmail) + 1
is_CcEmail[li_next] = as_email
is_CcName[li_next] = ""

Return li_next

end function

public function integer of_addto (string as_email);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_AddTo
//
// PURPOSE:    This function is used to add a primary send to email address.
//
// ARGUMENTS:  as_email - Email address
//
// RETURN:     Index to To array
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

Integer li_next

li_next = UpperBound(is_ToEmail) + 1
is_ToEmail[li_next] = as_email
is_ToName[li_next] = ""

Return li_next

end function

public function boolean of_sendmail ();// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SendMail
//
// PURPOSE:    This function the main process to send the email.
//
// RETURN:     True = Success, False = Failure
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant	String REPLY_READY = "220"
String ls_reply, ls_msg, ls_data
Integer li_rc, li_idx, li_max

ii_error=0
// build the data string
of_SendStatus("Building the data string")
ls_data = of_data()

// initialize Winsock
of_Startup()

of_SendStatus("Connecting to server")

// connect to server
iui_socket = of_Connect(is_server, ii_port)
If iui_socket = 0 Then 
	ii_error=-1008
	Return False
end if

// receive response
of_Recv(iui_socket, ls_reply)
If Left(ls_reply, 3) <> REPLY_READY Then
//	MessageBox("Connect Failed", ls_reply)
	ii_error=-1008
	Return False
end if

// start conversation with server
If ib_authenticate Then
	of_SendStatus("Authorizing connection")
	If Not of_auth() Then
		of_Close(iui_socket)
		Return False
	End If
Else
	ls_msg = "HELO " + of_GetHostName() + CRLF
	If Not of_SendMsg(ls_msg) Then
		of_Close(iui_socket)
		Return False
	End If
End If

of_SendStatus("Addressing the email")

// from email address
ls_msg = "MAIL FROM: <" + is_FromEmail + ">" + CRLF
If Not of_SendMsg(ls_msg) Then
	of_Close(iui_socket)
	Return False
End If

// to email address
li_max = UpperBound(is_ToEmail)
For li_idx = 1 To li_max
	ls_msg = "RCPT TO: <" + is_ToEmail[li_idx] + ">" + CRLF
	If Not of_SendMsg(ls_msg) Then
		of_Close(iui_socket)
		Return False
	End If
Next

// cc email address
li_max = UpperBound(is_CcEmail)
For li_idx = 1 To li_max
	ls_msg = "RCPT TO: <" + is_CcEmail[li_idx] + ">" + CRLF
	If Not of_SendMsg(ls_msg) Then
		of_Close(iui_socket)
		Return False
	End If
Next

// bcc email address
li_max = UpperBound(is_BccEmail)
For li_idx = 1 To li_max
	ls_msg = "RCPT TO: <" + is_BccEmail[li_idx] + ">" + CRLF
	If Not of_SendMsg(ls_msg) Then
		of_Close(iui_socket)
		Return False
	End If
Next

of_SendStatus("Sending the data")

// data header
ls_msg = "DATA" + CRLF
If Not of_SendMsg(ls_msg) Then
	of_Close(iui_socket)
	Return False
End If

// send data
If Not of_SendMsg(ls_data) Then
	of_Close(iui_socket)
	Return False
End If

of_SendStatus("Disconnecting from server")

// quit the session
ls_msg = "QUIT" + CRLF
li_rc = of_Send(iui_socket, ls_msg)
If li_rc < 1 Then
	of_Close(iui_socket)
	Return False
End If

// receive response
of_Recv(iui_socket, ls_reply)

// close the socket
of_Close(iui_socket)

of_SendStatus("Send email complete")

Return True

end function

public function integer of_addfile (string as_filename);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_AddFile
//
// PURPOSE:    This function is used to add an attachment.
//
// ARGUMENTS:  as_filename - Filename
//
// RETURN:     Index to attachment array
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

Integer li_next

li_next = UpperBound(is_AttachFile) + 1

is_AttachFile[li_next] = as_filename

Return li_next

end function

public subroutine of_reset ();// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_Reset
//
// PURPOSE:    This function is used to reset all the arrays.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

String ls_empty[]

is_ToEmail = ls_empty
is_ToName = ls_empty
is_CcEmail = ls_empty
is_CcName = ls_empty
is_BccEmail = ls_empty
is_BccName = ls_empty
is_AttachFile = ls_empty

end subroutine

public subroutine of_setlogin (string as_userid, string as_passwd);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetLogin
//
// PURPOSE:    This function is used to set the userid and password when the
//					SMTP server requires authentication.
//
// ARGUMENTS:  as_userid - Server userid
//					as_passwd - Server password
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

is_userid = as_userid
is_passwd = as_passwd
ib_authenticate = True

end subroutine

private function boolean of_auth ();// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_Auth
//
// PURPOSE:    This function is used to send Userid/Password to SMTP server.
//					It is called by of_SendMail when of_SetLogin has been called.
//
// RETURN:     True = Success, False = Failure
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant	Integer REPLY_OK = 250
Constant	Integer REPLY_AUTH = 334
Constant	Integer REPLY_AUTHOK = 235
String ls_msg, ls_reply, ls_userid, ls_passwd
Integer li_rc, li_response

// encode userid/password in Base-64
// REMODIFICADO POR ELOY 11/6/09
// En algunos casos no llega a funcionar del todo bien la funcion de codificacion que programe. Volvemos a usar
// la de crypt.dll
// MODIFICADO POR ELOY 3/5/07
// Usamos las funciones creadas especificas que no usan la libreria crypt32.dll
string ls_userid2,ls_passwd2
//ls_userid2 = of_Encode64(is_userid)
//ls_passwd2 = of_Encode64(is_passwd)
//ls_userid = of_codificar64(is_userid)+'~n'
//ls_passwd =of_codificar64(is_passwd)+'~n'
ls_userid = of_Encode64(is_userid)
ls_passwd = of_Encode64(is_passwd)

// start conversation with server
ls_msg = "EHLO " + of_GetHostName() + CRLF
li_rc = of_Send(iui_socket, ls_msg)
If li_rc < 1 Then
//	MessageBox("Command Failed", ls_msg)
	ii_error= -1000
	Return False
End If
sleep(3)

// receive response
of_Recv(iui_socket, ls_reply)
li_response = Integer(Left(ls_reply,3))
If li_response <> REPLY_OK Then
//	MessageBox("Command Failed", &
//		ls_msg + "~r~n" + ls_reply)
	ii_error= -1001
	Return False
End If

// request login
ls_msg = "AUTH LOGIN" + CRLF
li_rc = of_Send(iui_socket, ls_msg)
If li_rc < 1 Then
//	MessageBox("Command Failed", ls_msg)
	ii_error= -1002
	Return False
End If

// receive response
of_Recv(iui_socket, ls_reply)
li_response = Integer(Left(ls_reply,3))
If li_response <> REPLY_AUTH Then
//	MessageBox("Command Failed", &
//		ls_msg + "~r~n" + ls_reply)
	ii_error= -1003
	Return False
End If

// return userid
ls_msg = ls_userid
li_rc = of_Send(iui_socket, ls_msg)
If li_rc < 1 Then
//	MessageBox("Command Failed", ls_msg)
	ii_error= -1004
	Return False
End If

// receive response
of_Recv(iui_socket, ls_reply)
li_response = Integer(Left(ls_reply,3))
If li_response <> REPLY_AUTH Then
//	MessageBox("Command Failed", &
//		ls_msg + "~r~n" + ls_reply)
	ii_error= -1005
	Return False
End If

// return password
ls_msg = ls_passwd
li_rc = of_Send(iui_socket, ls_msg)
If li_rc < 1 Then
//	MessageBox("Command Failed", ls_msg)
	ii_error= -1006	
	Return False
End If

// receive response
of_Recv(iui_socket, ls_reply)
li_response = Integer(Left(ls_reply,3))
If li_response <> REPLY_AUTHOK Then
//	MessageBox("Command Failed", &
//		ls_msg + "~r~n" + ls_reply)
	ii_error= -1007
	Return False
End If

Return True

end function

private function boolean of_sendmsg (string as_cmd);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SendMsg
//
// PURPOSE:    This function is used by other functions to send a message and
//					receive any reply.
//
// ARGUMENTS:  as_cmd - SMTP command to be sent
//
// RETURN:     True = Success, False = Failure
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant	Integer REPLY_READY = 220
Constant	Integer REPLY_OK = 250
Constant	Integer REPLY_START = 354
String ls_reply, ls_command, ls_msg
Integer li_rc
Long ll_totbytes, ll_length

ll_length = Len(as_cmd)

do while ll_totbytes < ll_length
	// grab a piece of data
	ls_command = Mid(as_cmd, ll_totbytes + 1, MAX_SEND_BUFFER)
	ll_totbytes += Len(ls_command)
	// send the piece of data
	li_rc = of_Send(iui_socket, ls_command)
	If li_rc < 1 Then Return False
	// update status
	If ll_length > MAX_SEND_BUFFER Then
		ls_msg  = "Send data "
		ls_msg += String((ll_totbytes/ll_length) * 100, "#0")
		ls_msg += "% complete"
		of_SendStatus(ls_msg)
	End If
loop

// receive response
of_Recv(iui_socket, ls_reply)

choose case Integer(Left(ls_reply, 3))
	case REPLY_OK, REPLY_READY, REPLY_START
		Return True
	case else
//		MessageBox("Command Failed", &
//			as_cmd + "~r~n~r~n" + ls_reply)
		Return False
end choose

Return True

end function

public subroutine of_setbody (string as_body, boolean ab_html);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetBody
//
// PURPOSE:    This function is used to set the contents of the message body.
//
// ARGUMENTS:  as_cmd  - SMTP command to be sent
//					ab_html - The text contains HTML
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

is_body = as_body
ib_html = ab_html

end subroutine

public subroutine of_setreceipt (boolean ab_receipt);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetReceipt
//
// PURPOSE:    This function is used to set whether return receipt is requested.
//
// ARGUMENTS:  ab_receipt - True/False
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/30/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

ib_receipt = ab_receipt

end subroutine

public subroutine of_setfrom (string as_email);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetFrom
//
// PURPOSE:    This function is used to set the sender's
//					email address.
//
// ARGUMENTS:  as_email - Sender's Email address
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/30/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

is_FromEmail = as_email
is_FromName = ""

end subroutine

public function integer of_addto (string as_email, string as_name);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_AddTo
//
// PURPOSE:    This function is used to add a primary send to
//					email address and name.
//
// ARGUMENTS:  as_email - Email address
//					as_name	- Recipient name
//
// RETURN:     Index to To array
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/30/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

Integer li_next

li_next = UpperBound(is_ToEmail) + 1
is_ToEmail[li_next] = as_email
is_ToName[li_next] = as_name

Return li_next

end function

public function integer of_addcc (string as_email, string as_name);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_AddCc
//
// PURPOSE:    This function is used to add a CC send to
//					email address and name.
//
// ARGUMENTS:  as_email - Email address
//					as_name	- Recipient name
//
// RETURN:     Index to To array
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/30/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

Integer li_next

li_next = UpperBound(is_CcEmail) + 1
is_CcEmail[li_next] = as_email
is_CcName[li_next] = as_name

Return li_next

end function

public function integer of_addbcc (string as_email);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_AddBcc
//
// PURPOSE:    This function is used to add a Blind CC send to
//					email address.
//
// ARGUMENTS:  as_email - Email address
//
// RETURN:     Index to To array
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

Integer li_next

li_next = UpperBound(is_BccEmail) + 1
is_BccEmail[li_next] = as_email
is_BccName[li_next] = ""

Return li_next

end function

public function integer of_addbcc (string as_email, string as_name);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_AddBcc
//
// PURPOSE:    This function is used to add a Blind CC send to
//					email address and name.
//
// ARGUMENTS:  as_email - Email address
//					as_name	- Recipient name
//
// RETURN:     Index to To array
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/30/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

Integer li_next

li_next = UpperBound(is_BccEmail) + 1
is_BccEmail[li_next] = as_email
is_BccName[li_next] = as_name

Return li_next

end function

private function string of_encode64 (string as_data);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_Encode64
//
// PURPOSE:    This function converts string to blob and
//					calls ancestor function.
//
// ARGUMENTS:  as_data - String containing data
//
// RETURN:     String containing encoded data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

Return of_Encode64(Blob(as_data, EncodingANSI!))
end function

private function string of_generate_guid ();// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_Generate_GUID
//
// PURPOSE:    This function is used to generate a GUID.
//
// RETURN:     GUID string
//
// DATE        PROG/ID          DESCRIPTION OF CHANGE / REASON
// ----------  --------         -----------------------------------------------------
// 01/19/2006   RolandS         Initial coding
// -----------------------------------------------------------------------------

UUID lstr_UUID
Constant Long RPC_S_OK = 0
Constant Long SZ_UUID_LEN = 36
ULong lul_ptrUuid
String ls_Uuid

lstr_UUID.Data4 = Blob(Space(8), EncodingANSI!)
If UuidCreate(lstr_UUID) = RPC_S_OK Then
	If UuidToString(lstr_UUID, lul_ptrUuid) = RPC_S_OK Then
		ls_Uuid = Space(SZ_UUID_LEN)
		CopyMemory(ls_Uuid, lul_ptrUuid, SZ_UUID_LEN)
		RpcStringFree(lul_ptrUuid)
		ls_Uuid = Upper(ls_Uuid)
	End If
End If

Return ls_Uuid

end function

public function string of_unicode_to_string (unsignedlong aul_ptr);// get a string from a pointer to a unicode string

Char lc_byte
Integer li_loop
String ls_string

lc_byte = String(aul_ptr, "address")
DO WHILE Asc(lc_byte) > 0
	ls_string += String(lc_byte)
	li_loop = li_loop + 2
	lc_byte = String(aul_ptr + li_loop, "address")
LOOP

Return ls_string

end function

public subroutine of_setwinhandle (long al_handle, integer ai_event);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetWinHandle
//
// PURPOSE:    This function is used to set the window handle. If a
//					window handle has been set, status messages are sent
//					to the specified event.
//
// ARGUMENTS:  il_whandle	- Window handle
//					ii_wevent	- Event number
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

il_whandle = al_handle
ii_wevent  = ai_event

end subroutine

private function string of_data ();// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_Data
//
// PURPOSE:    This function is used to build the DATA portion of the message.
//					It is called by of_SendMail.
//
// RETURN:     A string containing the data to send.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

String ls_data, ls_boundary, ls_filename, ls_encoded, ls_type
Blob lblb_data
Integer li_idx, li_max
Environment le_env

GetEnvironment(le_env)

If is_FromName = "" Then
	ls_data += 'From: <' + is_FromEmail + '>' + CRLF
Else
	ls_data += 'From: ' + is_FromName
	ls_data += ' <' + is_FromEmail + '>' + CRLF
End If

If ib_receipt Then
	If is_FromName = "" Then
		ls_data += 'Disposition-Notification-To: <'
		ls_data += is_FromEmail + '>' + CRLF
	Else
		ls_data += 'Disposition-Notification-To: ' + is_FromName
		ls_data += ' <' + is_FromEmail + '>' + CRLF
	End If
End If

ls_data += 'User-Agent: TopWiz PowerBuilder '
ls_data += String(le_env.PBMajorRevision) + '.'
ls_data += String(le_env.PBMinorRevision) + ' '
ls_data += 'SMTP Object' + CRLF

ls_data += 'X-Accept-Language: en-us, en' + CRLF

ls_data += 'MIME-Version: 1.0' + CRLF

li_max = UpperBound(is_ToEmail)
For li_idx = 1 To li_max
	If is_ToName[li_idx] = "" Then
		ls_data += 'To: <' + is_ToEmail[li_idx] + '>' + CRLF
	Else
		ls_data += 'To: ' + is_ToName[li_idx]
		ls_data += ' <' + is_ToEmail[li_idx] + '>' + CRLF
	End If
Next

li_max = UpperBound(is_CcEmail)
For li_idx = 1 To li_max
	If is_CcName[li_idx] = "" Then
		ls_data += 'Cc: <' + is_CcEmail[li_idx] + '>' + CRLF
	Else
		ls_data += 'Cc: ' + is_CcName[li_idx]
		ls_data += ' <' + is_CcEmail[li_idx] + '>' + CRLF
	End If
Next

ls_data += 'Reply-To: <' + is_FromEmail + '>' + CRLF

ls_data += "Subject: " + is_subject + CRLF

// now the actual content of the email

li_max = UpperBound(is_attachfile)

// attachment header
If li_max > 0 Then
	ls_boundary = of_generate_guid()
	ls_data += 'Content-Type: multipart/mixed;' + CRLF
	ls_data += ' boundary="' + ls_boundary + '"' + CRLF
	ls_data += CRLF
	ls_data += 'This is a multi-part message in MIME format.' + CRLF
	ls_data += '--' + ls_boundary + CRLF
End If

// text or html section
If ib_html Then
	ls_data += 'Content-Type: text/html; charset=ISO-8859-1;format=flowed' + CRLF
Else
	ls_data += 'Content-Type: text/plain; charset=ISO-8859-1;format=flowed' + CRLF
End If
ls_data += 'Content-Transfer-Encoding: 7bit' + CRLF + CRLF
ls_data += is_body + CRLF

// add attachments
For li_idx = 1 To li_max
	If this.of_readfile(is_attachfile[li_idx], lblb_data) Then
		ls_data += CRLF + '--' + ls_boundary + CRLF
		ls_filename = Mid(is_attachfile[li_idx], &
							LastPos(is_attachfile[li_idx], "\") + 1)
		ls_type = this.of_FindMimeFromData(is_attachfile[li_idx], lblb_data)
		If Lower(Left(ls_type, 4)) = "text" Then
			ls_data += 'Content-Type: ' + ls_type + ';' + CRLF
			ls_data += ' name="' + ls_filename + '"' + CRLF
			ls_data += 'Content-Transfer-Encoding: 7bit' + CRLF
			ls_data += 'Content-Disposition: inline;' + CRLF
			ls_data += ' filename="' + ls_filename + '"' + CRLF
			ls_data += CRLF + String(lblb_data, EncodingANSI!)
		Else
			ls_data += 'Content-Type: ' + ls_type + ';' + CRLF
			ls_data += ' name="' + ls_filename + '"' + CRLF
			ls_data += 'Content-Transfer-Encoding: base64' + CRLF
			ls_data += 'Content-Disposition: inline;' + CRLF
			ls_data += ' filename="' + ls_filename + '"' + CRLF
			string prueba

			ls_encoded = this.of_encode64(lblb_data)
//			ls_encoded = this.of_codificar64(lblb_data)
			ls_data += CRLF + ls_encoded
		End If
	End If
Next

// if attachments, add end boundary
If li_max > 0 Then
	ls_data += '--' + ls_boundary + '--'
End If

// final double CRLF
ls_data += CRLF + '.' + CRLF

Return ls_data

end function

private function string of_findmimefromdata (string as_filename, ref blob ablob_filedata);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_FindMimeFromData
//
// PURPOSE:    This function is determines the file MIME type.
//
// ARGUMENTS:  as_filename - Filename
//					ablob_data	- By ref blob of the file contents
//
// RETURN:     MIME Type
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/05/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

String ls_mimetype
Blob lblob_filename
Long ll_rtn
ULong lul_ptr

//lblob_filename = ToUnicode(as_filename)
lblob_filename = Blob(as_filename)

ll_rtn = FindMimeFromData(0, lblob_filename, ablob_filedata, &
				Len(ablob_filedata), 0, 0, lul_ptr, 0)

If ll_rtn = 0 Then
	ls_mimetype = of_unicode_to_string(lul_ptr)
Else
//	MessageBox("of_FindMimeFromData", &
//			"Error " + String(ll_rtn))
End If

Return ls_mimetype

end function

private function boolean of_readfile (string as_filename, ref blob ablob_data);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_ReadFile
//
// PURPOSE:    This function is used to read an attachment from disk to a blob.
//
// ARGUMENTS:  as_filename - Filename
//					ablob_data	- By ref blob to receive the file contents
//
// RETURN:     True = Success, False = Failure
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

// constants for CreateFile API function
Constant ULong INVALID_HANDLE_VALUE = -1
Constant ULong GENERIC_READ     = 2147483648
Constant ULong GENERIC_WRITE    = 1073741824
Constant ULong FILE_SHARE_READ  = 1
Constant ULong FILE_SHARE_WRITE = 2
Constant ULong CREATE_NEW			= 1
Constant ULong CREATE_ALWAYS		= 2
Constant ULong OPEN_EXISTING		= 3
Constant ULong OPEN_ALWAYS			= 4
Constant ULong TRUNCATE_EXISTING = 5

ULong lul_file, lul_bytes, lul_length
Blob lblob_filedata
Boolean lb_result

// get file length
lul_length = FileLength(as_filename)

// open file for read
lul_file = CreateFile(as_filename, GENERIC_READ, &
					FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0)
If lul_file = INVALID_HANDLE_VALUE Then
	Return False
End If

// read the entire file contents in one shot
lblob_filedata = Blob(Space(lul_length), EncodingANSI!)
lb_result = ReadFile(lul_file, lblob_filedata, &
					lul_length, lul_bytes, 0)
ablob_data = BlobMid(lblob_filedata, 1, lul_length)

// close the file
CloseHandle(lul_file)

Return lb_result

end function

private subroutine of_sendstatus (string as_msg);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SendStatus
//
// PURPOSE:    This function is used to send a message to the
//					parent window.
//
// ARGUMENTS:  as_msg - The message being sent
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/30/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

Long ll_rtn

If il_whandle = 0 Or &
	ii_wevent = 0 Then
	Return
End If

ll_rtn = SendStringMessage(il_whandle, &
				ii_wevent, as_msg, 0)

end subroutine

public function string of_codificar64 (string cadena);// FUNCION PARA CONVERTIR UNA CADENA EN BASE64

char x
long entero,relleno
long caracter,i,j
string binario,res

for i=1 to len(cadena)
	caracter=AscA(mid(cadena,i,1))
	binario+=of_int2bin(caracter)
next

// Se rellenan con ceros para coger grupos de 6 en 6
relleno=mod(len(binario),6)
if relleno>0 then
	for i=1 to 6 - relleno
		binario+='0'
	next
end if

for i=1 to len(binario) step 6
	entero=of_bin2int(mid(binario,i,6))
	x=is_base64[entero+1]
	res+=string(x)
next

// La cadena tiene que tener una longitud que sea multiplo de 4 (24 bits), sino, se rellena con paddings ( simbolo = )
relleno=mod(len(res),4)
if relleno>0 then
	for i=1 to 4 - relleno
		res+='='
	next
end if
return res
end function

public function string of_int2bin (long numero);long num,entero,resto
string res

num=numero

do
entero=truncate(num/2,0)
resto=mod(num,2)

res=string(resto)+res
num=entero
loop while entero >= 2
res=string(entero)+res

return right('00000000'+res,8)
end function

public function long of_bin2int (string cadena_binaria);long res,n,i
string bit
n=len(cadena_binaria)
for i=1 to n

	bit=mid(cadena_binaria,i,1)
	if bit='1' then
		res+=2^(n -i)
	end if
next

return res
	
end function

public function string of_codificar64 (blob fichero);// FUNCION PARA CONVERTIR UNA CADENA EN BASE64

char x
long entero,relleno,punt
long caracter,i,j
string binario,res
string cadena=""
byte car

punt=1

for i=1 to len(fichero)
	if i>1 then 
		entero=of_bin2int(mid(binario,punt,6))
		x=is_base64[entero+1]
		res+=string(x)	
		punt+=6
	end if
	Getbyte(fichero,i,car)
	binario+=of_int2bin(long(car))
next

// Se rellenan con ceros para coger grupos de 6 en 6
relleno=mod(len(binario),6)
if relleno>0 then
	for i=1 to 6 - relleno
		binario+='0'
	next
end if

for i=punt to len(binario) step 6
	entero=of_bin2int(mid(binario,i,6))
	x=is_base64[entero+1]
	res+=string(x)
next


// La cadena tiene que tener una longitud que sea multiplo de 4 (24 bits), sino, se rellena con paddings ( simbolo = )
relleno=mod(len(res),4)
if relleno>0 then
	for i=1 to 4 - relleno
		res+='='
	next
end if
return res
end function

public function boolean of_csd_conexion ();// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SendMail
//
// PURPOSE:    This function the main process to send the email.
//
// RETURN:     True = Success, False = Failure
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant	String REPLY_READY = "220"
String ls_reply, ls_msg, ls_data
Integer li_rc, li_idx, li_max

//// build the data string
//of_SendStatus("Building the data string")
//ls_data = of_data()

// initialize Winsock
of_Startup()

of_SendStatus("Connecting to server")

// connect to server
iui_socket = of_Connect(is_server, ii_port)
If iui_socket = 0 Then Return False

// receive response
of_Recv(iui_socket, ls_reply)
If Left(ls_reply, 3) <> REPLY_READY Then
//	MessageBox("Connect Failed", ls_reply)
	Return False
End If

// start conversation with server
If ib_authenticate Then
	of_SendStatus("Authorizing connection")
	If Not of_auth() Then
		of_Close(iui_socket)
		Return False
	End If
Else
	ls_msg = "HELO " + of_GetHostName() + CRLF
	If Not of_SendMsg(ls_msg) Then
		of_Close(iui_socket)
		Return False
	End If
End If

Return True

end function

public function boolean of_csd_enviar_datos ();Constant	String REPLY_READY = "220"
String ls_reply, ls_msg, ls_data
Integer li_rc, li_idx, li_max

// build the data string
of_SendStatus("Building the data string")
ls_data = of_data()

of_SendStatus("Addressing the email")

// from email address
ls_msg = "MAIL FROM: <" + is_FromEmail + ">" + CRLF
If Not of_SendMsg(ls_msg) Then
	of_Close(iui_socket)
	Return False
End If

// to email address
li_max = UpperBound(is_ToEmail)
For li_idx = 1 To li_max
	ls_msg = "RCPT TO: <" + is_ToEmail[li_idx] + ">" + CRLF
	If Not of_SendMsg(ls_msg) Then
		of_Close(iui_socket)
		Return False
	End If
Next

// cc email address
li_max = UpperBound(is_CcEmail)
For li_idx = 1 To li_max
	ls_msg = "RCPT TO: <" + is_CcEmail[li_idx] + ">" + CRLF
	If Not of_SendMsg(ls_msg) Then
		of_Close(iui_socket)
		Return False
	End If
Next

// bcc email address
li_max = UpperBound(is_BccEmail)
For li_idx = 1 To li_max
	ls_msg = "RCPT TO: <" + is_BccEmail[li_idx] + ">" + CRLF
	If Not of_SendMsg(ls_msg) Then
		of_Close(iui_socket)
		Return False
	End If
Next

of_SendStatus("Sending the data")

// data header
ls_msg = "DATA" + CRLF
If Not of_SendMsg(ls_msg) Then
	of_Close(iui_socket)
	Return False
End If

// send data
If Not of_SendMsg(ls_data) Then
	of_Close(iui_socket)
	Return False
End If

return true
end function

public function boolean of_csd_cerrar_conexion ();string ls_msg,ls_reply
integer li_rc

of_SendStatus("Disconnecting from server")

// quit the session
ls_msg = "QUIT" + CRLF
li_rc = of_Send(iui_socket, ls_msg)
If li_rc < 1 Then
	of_Close(iui_socket)
	Return False
End If

// receive response
of_Recv(iui_socket, ls_reply)

// close the socket
of_Close(iui_socket)

of_SendStatus("Send email complete")

Return True
end function

public function integer of_csd_addto_unico (string as_email);
Integer li_next

li_next = UpperBound(is_ToEmail)
if li_next=0 then li_next=1
is_ToEmail[li_next] = as_email
is_ToName[li_next] = ""

Return li_next

end function

public function integer of_csd_addcc_unico (string as_email);Integer li_next

li_next = UpperBound(is_CcEmail)
if li_next=0 then li_next=1
is_CcEmail[li_next] = as_email
is_CcName[li_next] = ""

Return li_next

end function

public function integer of_csd_addbcc_unico (string as_email);Integer li_next

li_next = UpperBound(is_BccEmail)
if li_next=0 then li_next=1
is_BccEmail[li_next] = as_email
is_BccName[li_next] = ""

Return li_next
end function

public function integer of_csd_addto_reset ();long capacidad,i

capacidad = UpperBound(is_ToEmail)

for i = 1 to capacidad
	setNull( is_ToEmail[i] ) 
next

is_ToEmail[] = is_ToEmailReset[]

return 1
end function

public function integer of_csd_addto_limitado (string as_email, string limite);Integer li_next, limit

limit = integer(limite)

li_next = UpperBound(is_ToEmail) + 1
if( li_next <= limit )then
	if li_next=0 then li_next=1
	is_ToEmail[li_next] = as_email
	is_ToName[li_next] = ""
	
	Return li_next
else 
	Return -1	
end if
end function

public function integer of_csd_addtocc_limitado (string as_email, string limite);Integer li_next, limit

limit = integer(limite)

li_next = UpperBound(is_CcEmail) + 1
if( li_next <= limit )then
	if li_next=0 then li_next=1
	is_CcEmail[li_next] = as_email
	is_CcName[li_next] = ""
	
	Return li_next
else 
	Return -1	
end if
end function

public function integer of_csd_addtocc_reset ();long capacidad,i

capacidad = UpperBound(is_CcEmail)

for i = 1 to capacidad
	setNull( is_CcEmail[i] ) 
next

is_CcEmail[] = is_ToEmailReset[]

return 1
end function

public function integer of_csd_addtocco_limitado (string as_email, string limite);Integer li_next, limit

limit = integer(limite)

li_next = UpperBound(is_BccEmail) + 1
if( li_next <= limit )then
	if li_next=0 then li_next=1
	is_BccEmail[li_next] = as_email
	is_BccName[li_next] = ""
	
	Return li_next
else 
	Return -1	
end if
end function

public function integer of_csd_addtocco_reset ();long capacidad,i

capacidad = UpperBound(is_BccEmail)

for i = 1 to capacidad
	setNull( is_BccEmail[i] ) 
next

is_BccEmail[] = is_ToEmailReset[]

return 1
end function

public subroutine of_initializeport ();ii_port = integer(ProfileString(g_dir_aplicacion+"sica.ini","CORREO","puerto_servidor_smtp", "25"))
end subroutine

on n_smtp.create
call super::create
end on

on n_smtp.destroy
call super::destroy
end on

event constructor;call super::constructor;// SMTP is Ansi
of_SetUnicode(False, False)
of_initializePort()
end event

