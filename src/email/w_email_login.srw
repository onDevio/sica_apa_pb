HA$PBExportHeader$w_email_login.srw
forward
global type w_email_login from w_response
end type
type dw_1 from u_dw within w_email_login
end type
end forward

global type w_email_login from w_response
integer width = 1765
integer height = 560
dw_1 dw_1
end type
global w_email_login w_email_login

type variables
st_login datos_login
end variables

on w_email_login.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_email_login.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;call super::open;f_centrar_ventana(this)
dw_1.insertrow(0)


end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_email_login
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_email_login
end type

type dw_1 from u_dw within w_email_login
integer x = 27
integer y = 32
integer width = 1710
integer height = 396
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_email_password"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;
choose case dwo.name
	case 'b_aceptar'
		this.acceptText()
		datos_login.login=this.GetItemString(1,'login')
		datos_login.password=this.GetItemString(1,'password')		
		datos_login.recordar=this.GetItemString(1,'recordar')		
			
end choose

CloseWithReturn(parent,datos_login)

end event

