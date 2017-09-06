HA$PBExportHeader$w_csd_mail_send.srw
$PBExportComments$Window used to send MSMail
forward
global type w_csd_mail_send from w_response
end type
type cb_comprimir from commandbutton within w_csd_mail_send
end type
type cbx_comprimir from checkbox within w_csd_mail_send
end type
type st_1 from statictext within w_csd_mail_send
end type
type sle_1 from singlelineedit within w_csd_mail_send
end type
type cb_help from commandbutton within w_csd_mail_send
end type
type mle_msg from multilineedit within w_csd_mail_send
end type
type cbx_receipt_requested from checkbox within w_csd_mail_send
end type
type st_status_bar from statictext within w_csd_mail_send
end type
type mle_subject from multilineedit within w_csd_mail_send
end type
type cb_send_mail from commandbutton within w_csd_mail_send
end type
type cb_close from commandbutton within w_csd_mail_send
end type
type gb_5 from groupbox within w_csd_mail_send
end type
type gb_4 from groupbox within w_csd_mail_send
end type
type gb_subject from groupbox within w_csd_mail_send
end type
type gb_ficheros from groupbox within w_csd_mail_send
end type
type cb_grabar from commandbutton within w_csd_mail_send
end type
type dw_1 from u_dw within w_csd_mail_send
end type
type st_2 from statictext within w_csd_mail_send
end type
type gb_body from groupbox within w_csd_mail_send
end type
end forward

global type w_csd_mail_send from w_response
integer x = 9
integer width = 2697
integer height = 2096
string title = "Enviar correo electr$$HEX1$$f300$$ENDHEX$$nico"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
event csd_enviar ( )
event csd_adjuntar ( )
cb_comprimir cb_comprimir
cbx_comprimir cbx_comprimir
st_1 st_1
sle_1 sle_1
cb_help cb_help
mle_msg mle_msg
cbx_receipt_requested cbx_receipt_requested
st_status_bar st_status_bar
mle_subject mle_subject
cb_send_mail cb_send_mail
cb_close cb_close
gb_5 gb_5
gb_4 gb_4
gb_subject gb_subject
gb_ficheros gb_ficheros
cb_grabar cb_grabar
dw_1 dw_1
st_2 st_2
gb_body gb_body
end type
global w_csd_mail_send w_csd_mail_send

type variables
string	is_dwSyntax, is_dataSyntax
u_dw idw_dirlist, idw_fase
n_cst_filesrvwin32	inv_FileSrvwin32
boolean ib_permitir_adjuntar_manualmente=false
end variables

forward prototypes
public subroutine wf_logoff_mail (ref mailsession ams_mses, string as_attach_name)
end prototypes

event csd_enviar();// Clicked script for cb_send_mail

/*******************************************************************
	Mail the definition and current contents of a DataWindow using
	MAPI facilities.
	1. Get the PSR file saved from the datawindow chosen
	2. Create a mail session object and log onto the mail system
	3. Read addressees from a file (ASCII, one per line), If desired
	4. Get address names from box If needed
	5. Resolve all names
	6. send mail, with attached .dwx file
	7. Log off from mail system
	8. Destroy the mail session object
	9. Delete the attachment (saved) file
 *******************************************************************/

mailSession				mSes
mailReturnCode			mRet
mailMessage			mMsg
mailFileDescription		mAttach
string					ls_ret, ls_syntax, ls_name, ls_open_pathname, ls_filename,nombre_fichero
string					ls_attach_name='DataWndw.psr'
int						li_index, li_nret, li_nrecipients, li_nfile
boolean 				lb_noerrors

Long i
string fichero_contrato
int fila_insertada
int retorno
integer err

/*****************************************************************
	Establish an instance of the Mail Session object, and log on
 *****************************************************************/
mSes = create mailSession

/*****************************************************************
	Note: If the mail-system user ID and password are known,
			they could be hard-coded here, as shown in the
			commented-out statement that follows.  If user ID and
			password are not supplied, it is assumed that they

			are stored in MSMAIL.INI
 *****************************************************************/
mRet = mSes.mailLogon ( mailNewSession! )
ls_ret = f_mail_error_to_string ( mRet, 'Logon:', FALSE )
st_status_bar.text = ' Logon: ' + ls_ret
//messagebox(g_titulo, st_status_bar.text)
If mRet <> mailReturnSuccess! Then
	MessageBox ("Conexi$$HEX1$$f300$$ENDHEX$$n", 'C$$HEX1$$f300$$ENDHEX$$digo de retorno no satisfactorio' )
	wf_logoff_mail(mSes, ls_attach_name)
	return
End If

SetPointer(HourGlass!)

/*****************************************************************
	Copy user's subject to the mail message.
	Set return receipt flag If needed.
	Build an Attachment structure, and assign it to the mail message.
 *****************************************************************/
mMsg.Subject	= mle_subject.text

If cbx_receipt_requested.checked Then
	mMsg.ReceiptRequested = true
End If

mMsg.notetext = mle_msg.text +"~n~r "

mAttach.FileType = mailAttach!
mAttach.PathName = ls_attach_name
mAttach.FileName = ls_attach_name
// Note: In MS Mail version 3.0b, Position=-1 puts attachment at
//  the beginning of the message.
// This will place the attachment at the End of the text of the message
mAttach.Position = LenA(mMsg.notetext) - 1		

// Enviamos ficheros de dw_1
if ib_permitir_adjuntar_manualmente then
	for i = 1 to dw_1.rowcount()
		nombre_fichero=dw_1.getitemstring(i, 'nombre_fichero')
		mAttach.PathName =nombre_fichero
		mAttach.FileName = mid(nombre_fichero,lastpos(nombre_fichero,'\')+1)
		mMsg.AttachmentFile[i] = mAttach
	next				
else
	for i = 1 to dw_1.rowcount()
		mAttach.PathName =  f_obtener_ruta_base(left(dw_1.getitemstring(i, 'ruta_fichero'),4)) + dw_1.getitemstring(i, 'ruta_fichero') +  dw_1.getitemstring(i, 'nombre_fichero')
		mAttach.FileName = dw_1.getitemstring(i, 'nombre_fichero')
		mMsg.AttachmentFile[i] = mAttach
	next		
end if

/*****************************************************************
	Comprobacion del destinatario
 *****************************************************************/
if f_es_vacio(sle_1.text) then
	messagebox(g_titulo, 'Introduzca el destinatario')
	return
end if
mMsg.Recipient[1].Name = sle_1.text



/*****************************************************************
	Resolve recipient addresses, which may be only partially
	supplied, to get the complete address for each one.

	Loop in this until the names are all resovled with no
	errors. The message will not be sent If errors are in
	the user name.

	The user can cancel out of resolving names which
	will cancel the entire send mail process
 *****************************************************************/
SetPointer(HourGlass!)

Do 
	lb_noerrors = True
	li_nrecipients = UpperBound( mMsg.Recipient )
	For li_index = 1 To li_nrecipients
		mRet = mSes.mailResolveRecipient(mMsg.Recipient[li_index].Name)
		If mRet <> mailReturnSuccess! Then lb_noerrors = False
		ls_ret = f_mail_error_to_string ( mRet, 'Resolver destinatario:', FALSE )
		st_status_bar.text = ' Resolver destinatario (' + mMsg.Recipient[li_index].Name + '): ' + ls_ret
//				messagebox(g_titulo, st_status_bar.text)
	Next
	If Not lb_noerrors Then
		Messagebox(g_titulo,"Error en la resoluci$$HEX1$$f300$$ENDHEX$$n de nombre(s)~n~r"+&
		"Los nombre(s) no subrayado(s) no tiene(n) resoluci$$HEX1$$f300$$ENDHEX$$n.~n~n~rPor favor corr$$HEX1$$ed00$$ENDHEX$$jalo o cancele"&
		,Exclamation!)
		mRet = mSes.mailAddress(mMsg)
		If mRet = mailReturnUserAbort! Then 
			st_status_bar.text = "El usuario cancel$$HEX2$$f3002000$$ENDHEX$$el env$$HEX1$$ed00$$ENDHEX$$o"
//					messagebox(g_titulo, st_status_bar.text)
			wf_logoff_mail(mSes, ls_attach_name)
			Return
		End If
		wf_logoff_mail(mSes, ls_attach_name)
	End If
Loop Until lb_noerrors

/*****************************************************************
	Now, send the mail message, including the attachment
 *****************************************************************/
If UpperBound ( mMsg.Recipient ) < 1 Then 
	messagebox (g_titulo,"El correo debe incluir al menos un receptor",Exclamation!)
	wf_logoff_mail(mSes, ls_attach_name)
	return
End If
mRet = mSes.mailsend ( mMsg )
ls_ret = f_mail_error_to_string ( mRet, 'Env$$HEX1$$ed00$$ENDHEX$$o del correo:', FALSE )
st_status_bar.text = ' Env$$HEX1$$ed00$$ENDHEX$$o del correo: ' + ls_ret
wf_logoff_mail(mSes, ls_attach_name)
end event

public subroutine wf_logoff_mail (ref mailsession ams_mses, string as_attach_name);string 	ls_ret	
mailreturncode mRet

/*****************************************************************
	Log off from the mail system
 *****************************************************************/
mRet = ams_mSes.mailLogoff ( )
ls_ret = f_mail_error_to_string ( mRet, 'Logoff:', FALSE )
st_status_bar.text = ' Desconexi$$HEX1$$f300$$ENDHEX$$n: ' + ls_ret

If mRet <> mailReturnSuccess! Then
	MessageBox ("Desconexi$$HEX1$$f300$$ENDHEX$$n de correo", 'C$$HEX1$$f300$$ENDHEX$$digo de retorno no satisfactorio' )
	return
End If

/*****************************************************************
	Finally, destroy the mail session object created earlier.
	Also, delete the temporary attachment file.
 *****************************************************************/
destroy ams_mses


FileDelete ( as_attach_name )
end subroutine

event open;f_centrar_ventana(this)
inv_FileSrvwin32 = create n_cst_filesrvwin32

st_mail parametros
long i,fila
double tamanyo
string fichero

parametros = Message.PowerObjectParm

sle_1.text = parametros.direccion
mle_subject.text = parametros.asunto
mle_msg.text = parametros.mensaje

dw_1.DataObject = parametros.dw_adjuntos

if parametros.permitir_adjuntar_manualmente='S' then
	ib_permitir_adjuntar_manualmente=true
	// Cargamos los adjuntos
	for i=1 to upperbound(parametros.adjuntos)
		fichero=parametros.adjuntos[i]
	
		fila=dw_1.insertrow(0)
		dw_1.SetItem(fila,'nombre_fichero',fichero)
		tamanyo = Ceiling(gnv_fichero.of_GetFileSize(fichero) / 1024)
		dw_1.setitem(fila,'tamanyo',string(tamanyo,"#,###,##0") + ' Kb')
	next	
	
end if


dw_1.SetTransObject(SQLCA)

cbx_comprimir.enabled=false

end event

on w_csd_mail_send.create
int iCurrent
call super::create
this.cb_comprimir=create cb_comprimir
this.cbx_comprimir=create cbx_comprimir
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_help=create cb_help
this.mle_msg=create mle_msg
this.cbx_receipt_requested=create cbx_receipt_requested
this.st_status_bar=create st_status_bar
this.mle_subject=create mle_subject
this.cb_send_mail=create cb_send_mail
this.cb_close=create cb_close
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_subject=create gb_subject
this.gb_ficheros=create gb_ficheros
this.cb_grabar=create cb_grabar
this.dw_1=create dw_1
this.st_2=create st_2
this.gb_body=create gb_body
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_comprimir
this.Control[iCurrent+2]=this.cbx_comprimir
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_1
this.Control[iCurrent+5]=this.cb_help
this.Control[iCurrent+6]=this.mle_msg
this.Control[iCurrent+7]=this.cbx_receipt_requested
this.Control[iCurrent+8]=this.st_status_bar
this.Control[iCurrent+9]=this.mle_subject
this.Control[iCurrent+10]=this.cb_send_mail
this.Control[iCurrent+11]=this.cb_close
this.Control[iCurrent+12]=this.gb_5
this.Control[iCurrent+13]=this.gb_4
this.Control[iCurrent+14]=this.gb_subject
this.Control[iCurrent+15]=this.gb_ficheros
this.Control[iCurrent+16]=this.cb_grabar
this.Control[iCurrent+17]=this.dw_1
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.gb_body
end on

on w_csd_mail_send.destroy
call super::destroy
destroy(this.cb_comprimir)
destroy(this.cbx_comprimir)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_help)
destroy(this.mle_msg)
destroy(this.cbx_receipt_requested)
destroy(this.st_status_bar)
destroy(this.mle_subject)
destroy(this.cb_send_mail)
destroy(this.cb_close)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_subject)
destroy(this.gb_ficheros)
destroy(this.cb_grabar)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.gb_body)
end on

event close;call super::close;destroy inv_FileSrvwin32 
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_csd_mail_send
integer x = 1385
integer y = 956
integer width = 549
integer taborder = 20
string text = "Recuperar pantalla"
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_csd_mail_send
integer x = 768
integer y = 960
integer width = 489
string text = "Guardar pantalla"
end type

type cb_comprimir from commandbutton within w_csd_mail_send
boolean visible = false
integer x = 37
integer y = 1764
integer width = 402
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "comprimir"
end type

event clicked;//u_zip zip
//
//zip = create u_zip
//
//zip.idw_1 = dw_1
//zip.ruta_zip = g_dir_aplicacion + g_paquete_temporal + g_n_colegiado + '_' + g_prefijo_expediente + idw_fase.getitemstring(1, 'fases_n_expedi') + '_' + g_prefijo_registro + idw_fase.getitemstring(1, 'fases_n_registro') + '.zip'
//zip.event compress()
//
//destroy u_zip
end event

type cbx_comprimir from checkbox within w_csd_mail_send
boolean visible = false
integer x = 1755
integer y = 1916
integer width = 453
integer height = 64
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Comprimir datos"
end type

event clicked;//string fichero = ''
//if this.checked then
//	fichero = g_prefijo_expediente + idw_fase.getitemstring(1, 'fases_n_expedi') + '_' + g_prefijo_registro + idw_fase.getitemstring(1, 'fases_n_registro') + '.ini'
//	st_1.text = fichero
//	if not(fileexists(g_directorio_contratos + fichero)) then
//		messagebox(g_titulo, 'No se encuentra el fichero de exportaci$$HEX1$$f300$$ENDHEX$$n '+ fichero + '.' + cr + &
//		'Puede exportarlo desde la ventana del contrato de n$$HEX1$$fa00$$ENDHEX$$mero de registro: ' + idw_fase.getitemstring(1, 'fases_n_registro') )
//	end if
//else
//	st_1.text = ''
//	this.checked = false
//end if
end event

type st_1 from statictext within w_csd_mail_send
integer x = 517
integer y = 1776
integer width = 1179
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 74481808
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_csd_mail_send
integer x = 503
integer y = 36
integer width = 1979
integer height = 80
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
borderstyle borderstyle = stylelowered!
end type

type cb_help from commandbutton within w_csd_mail_send
boolean visible = false
integer x = 32
integer y = 1660
integer width = 338
integer height = 100
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Help"
end type

on clicked;
//f_open_help(parent.ClassName( ))
end on

type mle_msg from multilineedit within w_csd_mail_send
integer x = 210
integer y = 388
integer width = 2281
integer height = 604
integer taborder = 50
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
boolean vscrollbar = true
end type

type cbx_receipt_requested from checkbox within w_csd_mail_send
boolean visible = false
integer x = 1746
integer y = 1864
integer width = 919
integer height = 72
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Pedir confirmaci$$HEX1$$f300$$ENDHEX$$n al receptor"
end type

type st_status_bar from statictext within w_csd_mail_send
integer x = 242
integer y = 1672
integer width = 2194
integer height = 72
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
boolean focusrectangle = false
end type

type mle_subject from multilineedit within w_csd_mail_send
integer x = 206
integer y = 188
integer width = 2281
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
boolean autovscroll = true
end type

type cb_send_mail from commandbutton within w_csd_mail_send
integer x = 832
integer y = 1832
integer width = 402
integer height = 100
integer taborder = 80
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Enviar"
end type

event clicked;parent.event csd_enviar()

messagebox(g_titulo, 'Los datos se enviaron con $$HEX1$$e900$$ENDHEX$$xito')
cb_close.triggerevent(clicked!)
end event

type cb_close from commandbutton within w_csd_mail_send
integer x = 1298
integer y = 1832
integer width = 402
integer height = 100
integer taborder = 90
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
end type

on clicked;// Clicked script for cb_exit

Close (Parent)

end on

type gb_5 from groupbox within w_csd_mail_send
integer x = 165
integer y = 1612
integer width = 2354
integer height = 156
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Estado"
end type

type gb_4 from groupbox within w_csd_mail_send
boolean visible = false
integer x = 1714
integer y = 1788
integer width = 1056
integer height = 204
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Verificar recepci$$HEX1$$f300$$ENDHEX$$n del e-mail"
end type

type gb_subject from groupbox within w_csd_mail_send
integer x = 165
integer y = 128
integer width = 2354
integer height = 164
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Asunto"
end type

type gb_ficheros from groupbox within w_csd_mail_send
integer x = 165
integer y = 320
integer width = 2354
integer height = 708
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Mensaje"
end type

type cb_grabar from commandbutton within w_csd_mail_send
boolean visible = false
integer x = 37
integer y = 1864
integer width = 613
integer height = 100
integer taborder = 100
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Grabar datos por defecto"
end type

event clicked;////messagebox(g_titulo, 'Esta opci$$HEX1$$f300$$ENDHEX$$n debe grabar los datos por defecto')
//
//g_email_servidor = sle_1.text
//
//  UPDATE var_globales  
//     SET texto = :g_email_servidor  
//   WHERE var_globales.nombre = 'g_email_servidor'
//           ;
//
end event

type dw_1 from u_dw within w_csd_mail_send
event csd_adjuntar ( )
event csd_quitar ( )
event csd_quitartodos ( )
integer x = 210
integer y = 1136
integer width = 2281
integer height = 412
integer taborder = 50
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_adjuntar();n_file_dialogs lnv_file_dialog
String ls_pathname, ls_filename, ls_filter
Integer li_rc,fila,i
double tamanyo

ls_filter = "Todos los ficheros,*.*"

//li_rc = GetFileOpenName("Selecciona los ficheros a adjuntar", &
//		ls_pathname, ls_filename, "", ls_filter)
lnv_file_dialog.ib_allowmultiselect = true

li_rc=lnv_file_dialog.of_getopenfilename("Selecciona los ficheros a adjuntar", ls_pathname, ls_filename,"", ls_filter)

If li_rc = 1 Then
	for i=1 to UpperBound(lnv_file_dialog.is_selectedfiles)
		fila=dw_1.insertrow(0)
		dw_1.SetItem(fila,'nombre_fichero',ls_pathname + lnv_file_dialog.is_selectedfiles[i])
		tamanyo = Ceiling(gnv_fichero.of_GetFileSize(ls_pathname + lnv_file_dialog.is_selectedfiles[i]) / 1024)
		dw_1.setitem(fila,'tamanyo',string(tamanyo,"#,###,##0") + ' Kb')
	next

End If

end event

event csd_quitar();dw_1.deleterow(0)
end event

event csd_quitartodos();dw_1.reset()
end event

event constructor;call super::constructor;//this.object.p_1.filename = g_directorio_imagenes + 'pdf_3.gif'
end event

event rbuttonup;call super::rbuttonup;m_submenu_anexos menu

menu = create m_submenu_anexos
menu.idw_padre = this


menu.m_quitar.enabled=false
menu.m_quitartodos.enabled=false	
menu.m_adjuntar.enabled=ib_permitir_adjuntar_manualmente
if this.rowcount()>0 and ib_permitir_adjuntar_manualmente then 
	menu.m_quitar.enabled=true
	menu.m_quitartodos.enabled=true
end if



menu.PopMenu(parent.PointerX() + 5, parent.PointerY() + 10)

end event

type st_2 from statictext within w_csd_mail_send
integer x = 206
integer y = 52
integer width = 247
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Direcci$$HEX1$$f300$$ENDHEX$$n:"
boolean focusrectangle = false
end type

type gb_body from groupbox within w_csd_mail_send
integer x = 165
integer y = 1064
integer width = 2354
integer height = 520
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Documentos"
end type

