HA$PBExportHeader$w_escaner_brillo_contraste.srw
forward
global type w_escaner_brillo_contraste from w_response
end type
type cb_aceptar from u_cb within w_escaner_brillo_contraste
end type
type cb_cancelar from u_cb within w_escaner_brillo_contraste
end type
type brillo from htrackbar within w_escaner_brillo_contraste
end type
type st_1 from statictext within w_escaner_brillo_contraste
end type
type cb_previsualizar from u_cb within w_escaner_brillo_contraste
end type
type st_2 from statictext within w_escaner_brillo_contraste
end type
type contraste from htrackbar within w_escaner_brillo_contraste
end type
type cb_reset from u_cb within w_escaner_brillo_contraste
end type
end forward

global type w_escaner_brillo_contraste from w_response
integer x = 214
integer y = 221
integer width = 2226
integer height = 816
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
brillo brillo
st_1 st_1
cb_previsualizar cb_previsualizar
st_2 st_2
contraste contraste
cb_reset cb_reset
end type
global w_escaner_brillo_contraste w_escaner_brillo_contraste

type variables
st_valores st_old_brillo_contraste,st_new_brillo_contraste
end variables

on w_escaner_brillo_contraste.create
int iCurrent
call super::create
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
this.brillo=create brillo
this.st_1=create st_1
this.cb_previsualizar=create cb_previsualizar
this.st_2=create st_2
this.contraste=create contraste
this.cb_reset=create cb_reset
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_aceptar
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.brillo
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_previsualizar
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.contraste
this.Control[iCurrent+8]=this.cb_reset
end on

on w_escaner_brillo_contraste.destroy
call super::destroy
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
destroy(this.brillo)
destroy(this.st_1)
destroy(this.cb_previsualizar)
destroy(this.st_2)
destroy(this.contraste)
destroy(this.cb_reset)
end on

event open;call super::open;st_old_brillo_contraste= Message.PowerObjectParm

// Actualizamos la barra con los valores de la imagen
brillo.position=st_old_brillo_contraste.brillo*100
contraste.position=st_old_brillo_contraste.contraste*100

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_escaner_brillo_contraste
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_escaner_brillo_contraste
end type

type cb_aceptar from u_cb within w_escaner_brillo_contraste
integer x = 658
integer y = 548
integer taborder = 10
boolean bringtotop = true
string text = "Aceptar"
end type

event clicked;call super::clicked;
//Devolvemos a la imagen los valores de la barra
st_new_brillo_contraste.brillo=brillo.position/100
st_new_brillo_contraste.contraste=contraste.position/100


CloseWithReturn(parent,st_new_brillo_contraste)
end event

type cb_cancelar from u_cb within w_escaner_brillo_contraste
integer x = 1042
integer y = 548
integer taborder = 10
boolean bringtotop = true
string text = "Cancelar"
end type

event clicked;call super::clicked;st_old_brillo_contraste.ventana_escaneado.oTWAIN.object.brightness=st_old_brillo_contraste.brillo
st_old_brillo_contraste.ventana_escaneado.oTWAIN.object.contrast=st_old_brillo_contraste.contraste


Close(parent)
end event

type brillo from htrackbar within w_escaner_brillo_contraste
integer x = 517
integer y = 96
integer width = 1541
integer height = 136
boolean bringtotop = true
integer minposition = -100
integer maxposition = 100
integer tickfrequency = 5
end type

type st_1 from statictext within w_escaner_brillo_contraste
integer x = 110
integer y = 136
integer width = 343
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!

fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "BRILLO:"
boolean focusrectangle = false
end type

type cb_previsualizar from u_cb within w_escaner_brillo_contraste
integer x = 1659
integer y = 472
integer taborder = 20
boolean bringtotop = true
string text = "Previsualizar"
end type

event clicked;call super::clicked;// Establecemos los valores de la barra en la imagen para previsualizar

st_old_brillo_contraste.ventana_escaneado.oTWAIN.object.brightness=brillo.position/100
st_old_brillo_contraste.ventana_escaneado.oTWAIN.object.contrast=contraste.position/100


end event

type st_2 from statictext within w_escaner_brillo_contraste
integer x = 110
integer y = 364
integer width = 343
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "CONTRASTE:"
boolean focusrectangle = false
end type

type contraste from htrackbar within w_escaner_brillo_contraste
integer x = 517
integer y = 324
integer width = 1541
integer height = 136
boolean bringtotop = true
integer maxposition = 400
integer position = 100
integer tickfrequency = 10
end type

type cb_reset from u_cb within w_escaner_brillo_contraste
integer x = 1659
integer y = 580
integer taborder = 10
boolean bringtotop = true
string text = "Resetear"
end type

event clicked;call super::clicked;// Establecemos los valores de la barra en la imagen para previsualizar

st_old_brillo_contraste.ventana_escaneado.oTWAIN.object.brightness=0
st_old_brillo_contraste.ventana_escaneado.oTWAIN.object.contrast=1

brillo.position=0
contraste.position=100
end event

