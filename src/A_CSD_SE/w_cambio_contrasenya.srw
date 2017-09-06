HA$PBExportHeader$w_cambio_contrasenya.srw
forward
global type w_cambio_contrasenya from window
end type
type cb_cancelar from commandbutton within w_cambio_contrasenya
end type
type cb_aceptar from commandbutton within w_cambio_contrasenya
end type
type sle_cont from singlelineedit within w_cambio_contrasenya
end type
type sle_cont_ant from singlelineedit within w_cambio_contrasenya
end type
type sle_usuario from singlelineedit within w_cambio_contrasenya
end type
type st_contrasenya from statictext within w_cambio_contrasenya
end type
type st_contrasenya_ant from statictext within w_cambio_contrasenya
end type
type st_usuario from statictext within w_cambio_contrasenya
end type
end forward

global type w_cambio_contrasenya from window
integer width = 1559
integer height = 680
boolean titlebar = true
string title = "Gesti$$HEX1$$f300$$ENDHEX$$n de Contrase$$HEX1$$f100$$ENDHEX$$as"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
sle_cont sle_cont
sle_cont_ant sle_cont_ant
sle_usuario sle_usuario
st_contrasenya st_contrasenya
st_contrasenya_ant st_contrasenya_ant
st_usuario st_usuario
end type
global w_cambio_contrasenya w_cambio_contrasenya

type variables
boolean cambiada_cont
end variables

on w_cambio_contrasenya.create
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.sle_cont=create sle_cont
this.sle_cont_ant=create sle_cont_ant
this.sle_usuario=create sle_usuario
this.st_contrasenya=create st_contrasenya
this.st_contrasenya_ant=create st_contrasenya_ant
this.st_usuario=create st_usuario
this.Control[]={this.cb_cancelar,&
this.cb_aceptar,&
this.sle_cont,&
this.sle_cont_ant,&
this.sle_usuario,&
this.st_contrasenya,&
this.st_contrasenya_ant,&
this.st_usuario}
end on

on w_cambio_contrasenya.destroy
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.sle_cont)
destroy(this.sle_cont_ant)
destroy(this.sle_usuario)
destroy(this.st_contrasenya)
destroy(this.st_contrasenya_ant)
destroy(this.st_usuario)
end on

type cb_cancelar from commandbutton within w_cambio_contrasenya
integer x = 919
integer y = 432
integer width = 338
integer height = 96
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
end type

event clicked;if cambiada_cont = False then
  halt;
end if
end event

type cb_aceptar from commandbutton within w_cambio_contrasenya
integer x = 366
integer y = 432
integer width = 338
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
end type

event clicked;date f_caducidad
string contrasenya_vieja,usuario
integer cuantos

usuario = parent.sle_usuario.text
contrasenya_vieja = parent.sle_cont_ant.text
cambiada_cont = False
select count(*)  into :cuantos from t_usuario where login=:usuario and password=:contrasenya_vieja;
if cuantos > 0 then
	if sle_cont_ant.text = sle_cont.text then
	MessageBox(g_titulo,'La contrase$$HEX1$$f100$$ENDHEX$$a debe ser distinta a la anterior.') 
  else
	update t_usuario set password =:parent.sle_cont.text where login=:usuario and password=:contrasenya_vieja;
	COMMIT;
	select fecha_caducidad into :f_caducidad from t_usuario where login=:usuario;
		if (isnull(f_caducidad) or f_caducidad < today()) then
			f_caducidad = Relativedate(today(),g_usuarios_dias)
			update t_usuario set fecha_caducidad=:f_caducidad where login=:usuario;
			COMMIT;
		end if
	MessageBox(g_titulo,'Contrase$$HEX1$$f100$$ENDHEX$$a cambiada con exito');
	cambiada_cont = True
	close(w_cambio_contrasenya)
end if
else
	MessageBox(g_titulo,'Debe especificar los parametros correctamente')
	
end if
end event

type sle_cont from singlelineedit within w_cambio_contrasenya
integer x = 530
integer y = 256
integer width = 832
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type sle_cont_ant from singlelineedit within w_cambio_contrasenya
integer x = 530
integer y = 160
integer width = 832
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type sle_usuario from singlelineedit within w_cambio_contrasenya
integer x = 530
integer y = 64
integer width = 832
integer height = 76
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_contrasenya from statictext within w_cambio_contrasenya
integer x = 41
integer y = 260
integer width = 466
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Contrase$$HEX1$$f100$$ENDHEX$$a Nueva:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_contrasenya_ant from statictext within w_cambio_contrasenya
integer x = 41
integer y = 164
integer width = 466
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Contrase$$HEX1$$f100$$ENDHEX$$a Anterior:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_usuario from statictext within w_cambio_contrasenya
integer x = 41
integer y = 68
integer width = 466
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Usuario:"
alignment alignment = right!
boolean focusrectangle = false
end type

