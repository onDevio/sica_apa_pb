HA$PBExportHeader$w_mail_send.srw
$PBExportComments$Window used to send MSMail
forward
global type w_mail_send from w_response
end type
type cb_comprimir from commandbutton within w_mail_send
end type
type cbx_comprimir from checkbox within w_mail_send
end type
type st_1 from statictext within w_mail_send
end type
type cbx_contrato from checkbox within w_mail_send
end type
type sle_1 from singlelineedit within w_mail_send
end type
type cb_help from commandbutton within w_mail_send
end type
type mle_msg from multilineedit within w_mail_send
end type
type cbx_receipt_requested from checkbox within w_mail_send
end type
type st_status_bar from statictext within w_mail_send
end type
type mle_subject from multilineedit within w_mail_send
end type
type cb_send_mail from commandbutton within w_mail_send
end type
type cb_close from commandbutton within w_mail_send
end type
type gb_5 from groupbox within w_mail_send
end type
type gb_4 from groupbox within w_mail_send
end type
type gb_subject from groupbox within w_mail_send
end type
type gb_ficheros from groupbox within w_mail_send
end type
type gb_1 from groupbox within w_mail_send
end type
type cb_grabar from commandbutton within w_mail_send
end type
type dw_1 from u_dw within w_mail_send
end type
type st_2 from statictext within w_mail_send
end type
type gb_body from groupbox within w_mail_send
end type
end forward

global type w_mail_send from w_response
integer x = 9
integer width = 2889
integer height = 2096
string title = "Enviar correo electr$$HEX1$$f300$$ENDHEX$$nico"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
cb_comprimir cb_comprimir
cbx_comprimir cbx_comprimir
st_1 st_1
cbx_contrato cbx_contrato
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
gb_1 gb_1
cb_grabar cb_grabar
dw_1 dw_1
st_2 st_2
gb_body gb_body
end type
global w_mail_send w_mail_send

type variables
string	is_dwSyntax, is_dataSyntax
u_dw idw_dirlist, idw_fase
w_sellador_detalle_base i_w

end variables

forward prototypes
public subroutine wf_logoff_mail (ref mailsession ams_mses, string as_attach_name)
end prototypes

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

event open;string id_fase,email
f_centrar_ventana(this)

long i, fila_insertada
if isvalid(g_firmador) then
	i_w=g_firmador
	idw_dirlist = i_w.idw_docs
	idw_fase = i_w.dw_fase
	// Rellenar el correo destinatario
//	sle_1.text = g_email_servidor
	// Rellenar el Asunto
	mle_subject.text = 'Documentaci$$HEX1$$f300$$ENDHEX$$n colegial'
	// Rellenar mensaje	
	mle_msg.text = 'N$$HEX2$$ba002000$$ENDHEX$$Registro: ' + idw_fase.getitemstring(1, 'fases_n_registro') + '; ' + &
	'N$$HEX2$$ba002000$$ENDHEX$$Exp: ' + idw_fase.getitemstring(1, 'fases_n_expedi') + '; ' + &
	'Fecha: ' + string(idw_fase.getitemdatetime(1, 'fases_f_entrada')) + '; ' + &
	'Emplazamiento: ' + idw_fase.getitemstring(1, 'fases_tipo_via_emplazamiento') + ' ' + idw_fase.getitemstring(1, 'compute_1') + '; ' + &
	'Fases: ' + idw_fase.getitemstring(1, 'fases_titulo')+ '; ' + &
	'Tipo de Trabajo: '+ idw_fase.getitemstring(1, 'fases_tipo_trabajo') + '; ' + &
	'Trabajo: ' + idw_fase.getitemstring(1, 'fases_trabajo') 
	id_fase=idw_fase.GetItemString(1,'id_fase')
	select c.email into :email from fases_colegiados fc,colegiados c 
		where fc.id_fase=:id_fase and fc.id_col=c.id_colegiado;
	
	sle_1.text=email
	// Rellenamos los ficheros adjuntos
	for i = 1 to idw_dirlist.rowcount()
		if idw_dirlist.isselected(i) then
			fila_insertada = dw_1.insertrow(0)
			dw_1.setitem(fila_insertada, 'nombre_fichero', idw_dirlist.getitemstring(i,'nombre_fichero'))
			dw_1.setitem(fila_insertada, 'fecha', idw_dirlist.getitemdatetime(i,'fecha'))
			dw_1.setitem(fila_insertada, 'sellado', idw_dirlist.getitemstring(i,'sellado'))
			dw_1.setitem(fila_insertada, 'fecha_sellado', idw_dirlist.getitemdatetime(i,'fecha_sellado'))
			dw_1.setitem(fila_insertada, 'ruta_fichero', idw_dirlist.getitemstring(i,'ruta_fichero'))
			
		end if
	next
end if

end event

on w_mail_send.create
int iCurrent
call super::create
this.cb_comprimir=create cb_comprimir
this.cbx_comprimir=create cbx_comprimir
this.st_1=create st_1
this.cbx_contrato=create cbx_contrato
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
this.gb_1=create gb_1
this.cb_grabar=create cb_grabar
this.dw_1=create dw_1
this.st_2=create st_2
this.gb_body=create gb_body
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_comprimir
this.Control[iCurrent+2]=this.cbx_comprimir
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cbx_contrato
this.Control[iCurrent+5]=this.sle_1
this.Control[iCurrent+6]=this.cb_help
this.Control[iCurrent+7]=this.mle_msg
this.Control[iCurrent+8]=this.cbx_receipt_requested
this.Control[iCurrent+9]=this.st_status_bar
this.Control[iCurrent+10]=this.mle_subject
this.Control[iCurrent+11]=this.cb_send_mail
this.Control[iCurrent+12]=this.cb_close
this.Control[iCurrent+13]=this.gb_5
this.Control[iCurrent+14]=this.gb_4
this.Control[iCurrent+15]=this.gb_subject
this.Control[iCurrent+16]=this.gb_ficheros
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.cb_grabar
this.Control[iCurrent+19]=this.dw_1
this.Control[iCurrent+20]=this.st_2
this.Control[iCurrent+21]=this.gb_body
end on

on w_mail_send.destroy
call super::destroy
destroy(this.cb_comprimir)
destroy(this.cbx_comprimir)
destroy(this.st_1)
destroy(this.cbx_contrato)
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
destroy(this.gb_1)
destroy(this.cb_grabar)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.gb_body)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_mail_send
integer x = 590
integer y = 956
integer width = 549
integer taborder = 20
string text = "Recuperar pantalla"
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_mail_send
integer x = 590
integer y = 960
integer width = 489
string text = "Guardar pantalla"
end type

type cb_comprimir from commandbutton within w_mail_send
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

type cbx_comprimir from checkbox within w_mail_send
boolean visible = false
integer x = 2089
integer y = 1488
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

type st_1 from statictext within w_mail_send
integer x = 1019
integer y = 1488
integer width = 1477
integer height = 64
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

type cbx_contrato from checkbox within w_mail_send
boolean visible = false
integer x = 274
integer y = 1488
integer width = 750
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
string text = "Adjuntar datos del contrato"
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

type sle_1 from singlelineedit within w_mail_send
integer x = 558
integer y = 56
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

type cb_help from commandbutton within w_mail_send
boolean visible = false
integer x = 41
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

type mle_msg from multilineedit within w_mail_send
integer x = 261
integer y = 408
integer width = 2281
integer height = 172
integer taborder = 50
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
boolean vscrollbar = true
end type

type cbx_receipt_requested from checkbox within w_mail_send
boolean visible = false
integer x = 2994
integer y = 884
integer width = 759
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

type st_status_bar from statictext within w_mail_send
integer x = 293
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

type mle_subject from multilineedit within w_mail_send
integer x = 256
integer y = 244
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

type cb_send_mail from commandbutton within w_mail_send
integer x = 901
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

event clicked;// Clicked script for cb_send_mail

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
string					ls_ret, ls_syntax, ls_name, ls_open_pathname, ls_filename
string					ls_attach_name='DataWndw.psr'
int						li_index, li_nret, li_nrecipients, li_nfile
boolean 				lb_noerrors

Long i
string fichero_contrato
int fila_insertada
int retorno
integer err

/*****************************************************************
	Make sure user has chosen at least one addressing option.
 *****************************************************************/
/*
If NOT cbx_file.checked AND NOT cbx_address_live.checked AND NOT cbx_manual.checked Then

	MessageBox (g_titulo, &
					"Por favor seleccione al menos una opci$$HEX1$$f300$$ENDHEX$$n en direcci$$HEX1$$f300$$ENDHEX$$n", &
					Exclamation!)
	wf_logoff_mail(mSes, ls_attach_name)
	return
End If*/
//// ************
//// COMPROBAR QUE EXISTE EL FICHERO DE EXPORTACI$$HEX1$$d300$$ENDHEX$$N
//// *************
//if cbx_contrato.checked then
//	fichero_contrato = g_prefijo_expediente + idw_fase.getitemstring(1, 'fases_n_expedi') + '_' + g_prefijo_registro + idw_fase.getitemstring(1, 'fases_n_registro') + '.ini'
//	if not(fileexists(g_directorio_contratos + fichero_contrato)) then
//		messagebox(g_titulo, 'No se encuentra el fichero de exportaci$$HEX1$$f300$$ENDHEX$$n '+ fichero_contrato + '.' + cr + &
//		'Puede exportarlo desde la ventana del contrato de n$$HEX1$$fa00$$ENDHEX$$mero de registro: ' + idw_fase.getitemstring(1, 'fases_n_registro') )
//		return
//	end if
//end if

// COMPROBAR QUE HAY ALGO PARA ENVIAR
if (dw_1.rowcount() <= 0) then 
	if not cbx_contrato.checked then
		if messagebox(g_titulo,"No va a mandar ning$$HEX1$$fa00$$ENDHEX$$n documento,$$HEX1$$bf00$$ENDHEX$$Desea Continuar?", Question!, YesNo!)  <> 1 then
			return
		end if
	end if
end if
//// COMPROBAR QUE EXISTE EL REPOSITORIO TEMPORAL DE ENVIOS, SINO CREARLO
//string repositorio
//repositorio = g_dir_aplicacion + g_paquete_temporal
//repositorio = mid(repositorio, 1, len(repositorio) -1)
//
//if not fileexists(repositorio) then
////	messagebox(g_titulo,'Creaci$$HEX1$$f300$$ENDHEX$$n del repositorio de env$$HEX1$$ed00$$ENDHEX$$os')
//	retorno = gnv_fichero.of_CreateDirectory(repositorio )
//	if retorno < 0 then
//		messagebox(g_titulo,'Falta la carpeta :' + g_dir_aplicacion + g_paquete_temporal)
//		return
//	end if
//end if


// FIN VALIDACIONES 

/*****************************************************************
	Obtain the syntax of the DataWindow definition and contents,
	and write it in a ".dwx" transport file (in ASCII)
 *****************************************************************/

//dw_1.saveas(ls_attach_name,PSReport!,True)

//This is another way of sending the datawindow contents. ie breaking the 
//syntax and data up and mailing them together. 
//The PSR file is the prefered method now.
//is_dwsyntax = dw_1.Describe ( 'datawindow.syntax' )
//is_datasyntax = dw_1.Describe ( 'datawindow.syntax.data' )
//ls_syntax = is_dwsyntax + '~r' + is_datasyntax
//
//li_nfile = FileOpen  ( ls_attach_name, StreamMode!, Write!, LockReadWrite!, Replace! )
//If li_nfile < 0 Then
//	MessageBox ( "send Mail", &
//				"Unable to open file to save DataWindow attachment", &
//				 StopSign! )
//	wf_logoff_mail(mSes, ls_attach_name)
//	return
//End If
//li_nret = FileWrite ( li_nfile, ls_syntax )
//FileClose ( li_nfile )

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
//mMsg.AttachmentFile[1] = mAttach

//if cbx_contrato.checked then
////	dw_1.setredraw(false)
//	fila_insertada = dw_1.insertrow(0)
//	dw_1.setitem(fila_insertada, 'nombre_fichero', fichero_contrato)		
//	dw_1.setitem(fila_insertada, 'ruta_fichero', g_directorio_contratos + fichero_contrato)
//end if

// Adjuntamos los ficheros correspondientes
//if cbx_comprimir.checked then
//	
//	cb_comprimir.trigger event clicked()	
//	mAttach.PathName = g_dir_aplicacion + g_paquete_temporal + g_n_colegiado + '_' + g_prefijo_expediente + idw_fase.getitemstring(1, 'fases_n_expedi') + '_' + g_prefijo_registro + idw_fase.getitemstring(1, 'fases_n_registro') + '.zip'
//	mAttach.FileName = /*g_n_colegiado + '_' + */g_prefijo_expediente + idw_fase.getitemstring(1, 'fases_n_expedi') + '_' + g_prefijo_registro + idw_fase.getitemstring(1, 'fases_n_registro') + '.zip'
//	mMsg.AttachmentFile[1] = mAttach
//	
//else
	// Enviamos ficheros de dw_1
	for i = 1 to dw_1.rowcount()
		string anyo
		anyo = left(dw_1.getitemstring(i, 'ruta_fichero'),4)
		mAttach.PathName =f_obtener_ruta_base(anyo) + dw_1.getitemstring(i, 'ruta_fichero') +  dw_1.getitemstring(i, 'nombre_fichero')
		mAttach.FileName = dw_1.getitemstring(i, 'nombre_fichero')
		mMsg.AttachmentFile[i] = mAttach
	next		
//end if


/*****************************************************************
	Si mandamos fichero de exportaci$$HEX1$$f300$$ENDHEX$$n del contrato
 *****************************************************************/
//If cbx_contrato.checked Then
//	mAttach.PathName = g_directorio_contratos + st_1.text
//	mAttach.FileName = st_1.text
//	mMsg.AttachmentFile[dw_1.rowcount() + 1] = mAttach
//End If

/*
/*****************************************************************
	If user requested "addresses-from-a-file," open that file and
	read the address list.
 *****************************************************************/
If cbx_file.checked Then
	li_nret = GetFileOpenName ("Direcciones", ls_open_pathname, &
								ls_filename,"adr", &
		"Ficheros de texto de direcciones (*.adr),*.adr,Todos los ficheros (*.*),*.*")
	If li_nret < 1 Then return
	li_nfile = FileOpen ( ls_open_pathname )
	If li_nfile < 0 Then
		MessageBox ( g_titulo, "Imposible abrir el fichero" &
						+ ls_open_pathname, StopSign! )
		wf_logoff_mail(mSes, ls_attach_name)
		return
	End If

	li_nrecipients = 0
	do while FileRead ( li_nfile, ls_name ) > 0
		li_nrecipients = li_nrecipients + 1
		mMsg.Recipient[li_nrecipients].Name = ls_name
	loop
	FileClose ( li_nfile )
	// A$$HEX1$$f100$$ENDHEX$$adido por Roberto Marco 22/03/2005
	// Restauramos el directorio base de la aplicaci$$HEX1$$f300$$ENDHEX$$n
	err=f_cambiar_directorio_activo(g_dir_aplicacion)
End If



/*****************************************************************
	If user requested "address-from-Post-Office," call the
	mail system's Address function
 *****************************************************************/
If cbx_address_live.checked Then
	mRet = mSes.mailAddress ( mMsg )
	If mRet = mailReturnUserAbort! Then 
		st_status_bar.text = "El usuario cancel$$HEX2$$f3002000$$ENDHEX$$la operaci$$HEX1$$f300$$ENDHEX$$n"
//		messagebox(g_titulo, st_status_bar.text)
		wf_logoff_mail(mSes, ls_attach_name)
		Return
	End If
	ls_ret = f_mail_error_to_string ( mRet, 'Direcci$$HEX1$$f300$$ENDHEX$$n de correo:', FALSE )
	st_status_bar.text = ' Direcci$$HEX1$$f300$$ENDHEX$$n de correo: ' + ls_ret
//			messagebox(g_titulo, st_status_bar.text)
End If

*/
/*****************************************************************
	Si marcamos la opci$$HEX1$$f300$$ENDHEX$$n manual
 *****************************************************************/
//If cbx_manual.checked Then
	if f_es_vacio(sle_1.text) then
		messagebox(g_titulo, 'Introduzca el destinatario')
		return
	end if
	mMsg.Recipient[1].Name = sle_1.text
//End If



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

messagebox(g_titulo, 'Los datos se enviaron con $$HEX1$$e900$$ENDHEX$$xito')
cb_close.triggerevent(clicked!)
end event

type cb_close from commandbutton within w_mail_send
integer x = 1367
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

type gb_5 from groupbox within w_mail_send
integer x = 215
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

type gb_4 from groupbox within w_mail_send
boolean visible = false
integer x = 2962
integer y = 808
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

type gb_subject from groupbox within w_mail_send
integer x = 215
integer y = 184
integer width = 2354
integer height = 164
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Asunto"
end type

type gb_ficheros from groupbox within w_mail_send
integer x = 215
integer y = 348
integer width = 2354
integer height = 264
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Mensaje"
end type

type gb_1 from groupbox within w_mail_send
integer x = 215
integer y = 4
integer width = 2354
integer height = 168
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Direcci$$HEX1$$f300$$ENDHEX$$n"
end type

type cb_grabar from commandbutton within w_mail_send
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

type dw_1 from u_dw within w_mail_send
integer x = 261
integer y = 704
integer width = 2281
integer height = 756
integer taborder = 50
string dataobject = "d_sellador_documentos"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;//this.object.p_1.filename = g_directorio_imagenes + 'pdf_3.gif'
end event

type st_2 from statictext within w_mail_send
integer x = 261
integer y = 72
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

type gb_body from groupbox within w_mail_send
integer x = 215
integer y = 636
integer width = 2354
integer height = 948
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Documentos"
end type

