HA$PBExportHeader$w_csd_logon.srw
forward
global type w_csd_logon from window
end type
type cbx_pruebas from checkbox within w_csd_logon
end type
type st_5 from statictext within w_csd_logon
end type
type dw_1 from u_dw within w_csd_logon
end type
type sle_a$$HEX1$$f100$$ENDHEX$$o from singlelineedit within w_csd_logon
end type
type st_4 from statictext within w_csd_logon
end type
type sle_login from singlelineedit within w_csd_logon
end type
type cb_2 from commandbutton within w_csd_logon
end type
type cb_1 from commandbutton within w_csd_logon
end type
type st_3 from statictext within w_csd_logon
end type
type st_2 from statictext within w_csd_logon
end type
type sle_password from singlelineedit within w_csd_logon
end type
type st_1 from statictext within w_csd_logon
end type
type p_logotipo from picture within w_csd_logon
end type
end forward

global type w_csd_logon from window
integer x = 823
integer y = 360
integer width = 2373
integer height = 772
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
cbx_pruebas cbx_pruebas
st_5 st_5
dw_1 dw_1
sle_a$$HEX1$$f100$$ENDHEX$$o sle_a$$HEX1$$f100$$ENDHEX$$o
st_4 st_4
sle_login sle_login
cb_2 cb_2
cb_1 cb_1
st_3 st_3
st_2 st_2
sle_password sle_password
st_1 st_1
p_logotipo p_logotipo
end type
global w_csd_logon w_csd_logon

type variables



end variables

on w_csd_logon.create
this.cbx_pruebas=create cbx_pruebas
this.st_5=create st_5
this.dw_1=create dw_1
this.sle_a$$HEX1$$f100$$ENDHEX$$o=create sle_a$$HEX1$$f100$$ENDHEX$$o
this.st_4=create st_4
this.sle_login=create sle_login
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_3=create st_3
this.st_2=create st_2
this.sle_password=create sle_password
this.st_1=create st_1
this.p_logotipo=create p_logotipo
this.Control[]={this.cbx_pruebas,&
this.st_5,&
this.dw_1,&
this.sle_a$$HEX1$$f100$$ENDHEX$$o,&
this.st_4,&
this.sle_login,&
this.cb_2,&
this.cb_1,&
this.st_3,&
this.st_2,&
this.sle_password,&
this.st_1,&
this.p_logotipo}
end on

on w_csd_logon.destroy
destroy(this.cbx_pruebas)
destroy(this.st_5)
destroy(this.dw_1)
destroy(this.sle_a$$HEX1$$f100$$ENDHEX$$o)
destroy(this.st_4)
destroy(this.sle_login)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_password)
destroy(this.st_1)
destroy(this.p_logotipo)
end on

event close;string   ls_idioma
integer l_n_fallos,l_existe_usu,l_usuario 
date f_caducidad

l_n_fallos = 0
g_usuario=' '

select cod_usuario into :g_usuario from t_usuario where login=:sle_login.text and password=:sle_password.text;
select count(*) into :l_existe_usu from t_usuario where login=:sle_login.text and password=:sle_password.text;
select count(*) into :l_usuario from t_usuario where login=:sle_login.text;

if sle_login.text <> '' then
	f_preferencia_idioma_usuario(sle_login.text,ls_idioma)
	if ls_idioma <> '' or not isnull(ls_idioma) then // si tiene idioma asignado en el mantenimiento de usuario, ese es el idioma a tomar
		g_idioma.of_setidioma( ls_idioma)
	else
		g_idioma.of_setidioma( g_idioma_defecto)// si no tiene valor se asigna el valor de la variable global de idioma
	end if
end if

IF Message.DoubleParm = -1 then 	
	closewithreturn(this,-2)
else
 if g_usuarios_usar_ges_con = 'S' then
	if /*g_usuario=' ' or*/ sle_login.text='' then 
		closewithreturn(this,-1)
	else 		
		select n_fallos into :l_n_fallos from t_usuario where login=:sle_login.text;
		if isnull(l_n_fallos) then l_n_fallos = 0
			
		if l_n_fallos >=g_usuarios_fallos then 
		 messagebox(g_titulo,'USUARIO BLOQUEADO. Contacte con el administrador.')
				closewithreturn(this,-1)
		end if	
		if l_usuario = 1 and g_usuario = ' ' and l_n_fallos < g_usuarios_fallos then
			//Nos ha devuelto un usuario inexistente, por lo que sumamos a fallos
			select n_fallos into :l_n_fallos from t_usuario where login=:sle_login.text;
			l_n_fallos += 1
			update t_usuario set n_fallos=:l_n_fallos where  login=:sle_login.text;
			COMMIT;
			MessageBox(g_titulo,"Clave Incorrecta. Intentos " + string(l_n_fallos) + " de " + string(g_usuarios_fallos))
			if l_n_fallos >= 3 then 
				messagebox(g_titulo,'Se ha superado el n$$HEX1$$fa00$$ENDHEX$$mero de intentos. Contacte con el administrador.')
				closewithreturn(this,-1)
			end if
		end if
		
		// Comprobamos que la fecha de caducidad de la contrase$$HEX1$$f100$$ENDHEX$$a sea mayor que la actual
		select fecha_caducidad into :f_caducidad from t_usuario where login=:sle_login.text and password=:sle_password.text;
		if (isnull(f_caducidad) and g_usuario <> ' ' ) then
			f_caducidad = Relativedate(today(),g_usuarios_dias)
			
			update t_usuario set fecha_caducidad=:f_caducidad where  login=:sle_login.text and password=:sle_password.text;
			COMMIT;
		end if
		if (date(f_caducidad) < today() and g_usuario <> ' ') then
			//Cambiamos la contrase$$HEX1$$f100$$ENDHEX$$a
			Messagebox(g_titulo,'Se ha superado la fecha de caducidad de su contrase$$HEX1$$f100$$ENDHEX$$a, se proceder$$HEX2$$e1002000$$ENDHEX$$a la modificaci$$HEX1$$f300$$ENDHEX$$n de esta.')
			open(w_cambio_contrasenya)
   	 	end if
			// Ponemos los fallos a 0 en la BD
			if l_existe_usu = 1 and l_n_fallos < g_usuarios_fallos  then
				update t_usuario set n_fallos=0 where  login=:sle_login.text;
				COMMIT;
				closewithreturn(this,0)
			else
				closewithreturn(this,-1)
			end if
	end if
else
	

	IF Message.DoubleParm = -1 then 	
		closewithreturn(this,-2)
	else
		if g_usuario=' ' or sle_login.text='' then 
			closewithreturn(this,-1)
		else 
			closewithreturn(this,0)
		end if
	end if

end if
end if
end event

event open;String ls_inifile

ls_inifile = gnv_app.of_GetAppInifile()

//  If SQLCA.of_init(ls_inifile,"Database") = -1 then
//		//Database es el nombre de la secci$$HEX1$$f300$$ENDHEX$$n de base de datos en "conta.ini"
//      // MessageBox(g_titulo, "La conexi$$HEX1$$f300$$ENDHEX$$n ha fallado con el fichero "+ ls_inifile,StopSign!)
//		 MessageBox(g_titulo, "La conexi$$HEX1$$f300$$ENDHEX$$n ha fallado con el fichero "+ ls_inifile &
//		 	+ CR + bd_ejercicio.SQLErrText,StopSign!)		 
//		 Halt
//   end if
//
title=g_titulo
p_logotipo.PictureName =  gnv_app.of_GetLogo()
sle_a$$HEX1$$f100$$ENDHEX$$o.text=g_ejercicio
//dw_1.settransobject(sqlca)
dw_1.insertrow(0)
dw_1.setitem(1,'empresa',g_empresa)
//gnv_app.of_Splash (1)

//cb_1.postevent (clicked!)


// Comprobamos que se est$$HEX2$$e1002000$$ENDHEX$$ejecutando la $$HEX1$$fa00$$ENDHEX$$ltima versi$$HEX1$$f300$$ENDHEX$$n
string version_act
version_act = RightA(gnv_app.of_getversion(),10)
version_act = string(date(version_act), "yyyymmdd")

if g_version_minima > version_act then 
	Messagebox(g_titulo, "La versi$$HEX1$$f300$$ENDHEX$$n del programa no est$$HEX2$$e1002000$$ENDHEX$$actualizada."+CR+&
	"Consulte con el Dpto. de Informatica para obtener la nueva versi$$HEX1$$f300$$ENDHEX$$n.")
	cb_2.triggerevent(clicked!)
end if


end event

type cbx_pruebas from checkbox within w_csd_logon
integer x = 800
integer y = 568
integer width = 727
integer height = 64
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Conexi$$HEX1$$f300$$ENDHEX$$n a la BD de pruebas:"
boolean lefttext = true
end type

type st_5 from statictext within w_csd_logon
integer x = 530
integer y = 460
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Empresa:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_csd_logon
integer x = 805
integer y = 444
integer width = 1509
integer height = 76
integer taborder = 40
string dataobject = "d_empresa"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

type sle_a$$HEX1$$f100$$ENDHEX$$o from singlelineedit within w_csd_logon
integer x = 805
integer y = 348
integer width = 146
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_csd_logon
integer x = 530
integer y = 360
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Ejercicio:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_login from singlelineedit within w_csd_logon
integer x = 805
integer y = 160
integer width = 1019
integer height = 76
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = lower!
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_csd_logon
integer x = 1975
integer y = 268
integer width = 338
integer height = 96
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;closewithreturn(parent,-1)

end event

type cb_1 from commandbutton within w_csd_logon
integer x = 1975
integer y = 152
integer width = 338
integer height = 96
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;string ls_inifile, ls_empresa
bd_ejercicio = CREATE n_tr
g_ejercicio=sle_a$$HEX1$$f100$$ENDHEX$$o.text
if cbx_pruebas.checked THEN 
	ls_inifile ='bd_pruebas.ini'
	gnv_app.of_SetAppIniFile(ls_inifile)  
else 
	ls_inifile = gnv_app.of_GetAppInifile()
end if

	dw_1.AcceptText()
	g_empresa = dw_1.GetItemString(1,'empresa')   
	ls_empresa = g_empresa
	//Multiempresa
	if g_activa_multiempresa = 'S' then
		f_obtener_datos_empresa()
	end if	
	
//if f_control_ejercicios(g_ejercicio) = 1 then
	if cbx_pruebas.checked THEN 
	else
		SetProfileString(ls_inifile,"Database_ejer","Database ","conta" + g_ejercicio + g_empresa ) 
	end if
 
	SetProfileString(ls_inifile,"Empresa_Activa","Ejercicio", g_ejercicio  )   


	If bd_ejercicio.of_init(ls_inifile,"Database_ejer") = -1 then
		MessageBox(g_titulo, "La conexi$$HEX1$$f300$$ENDHEX$$n ha fallado con el fichero "+ ls_inifile &
		+ CR + bd_ejercicio.SQLErrText,StopSign!)
	end if

	if cbx_pruebas.checked THEN
		IF IsValid(sqlca) then sqlca.of_Disconnect();
		f_conectar_a_bd ('sqlca', 'PRUEBAS')
		f_conectar_a_bd('bd_ejercicio','PRUEBAS')
		g_pruebas = true
		
		//g_titulo_aplicacion += ' ' + '[PRUEBAS]'		
		f_inicializar_var_globales()
		///***SCP-1126. En f_inicializar_var_globales se carga de nuevo g_empresa por eso se recarga de nuevo
		g_empresa = ls_empresa
		f_obtener_datos_parametrizacion()
		
		if g_activa_multiempresa = 'S' then
			f_obtener_datos_empresa()
		end if
		
		g_titulo = g_titulo_aplicacion

	else
		f_conectar_a_bd('bd_ejercicio','NORMAL')
	end if
	select moneda into :moneda_ejercicio from moneda using bd_ejercicio ;
	
	//Conectar objeto cambio IVA
	gnv_ivajulio2010.of_init ('SICAP', 'ES',g_colegio,g_empresa) 
	gnv_control_cuentas_bancarias.of_init ('SICAP', 'ES',g_colegio,g_empresa) 
	
	if cbx_pruebas.checked THEN 
		gnv_ivajulio2010.is_pruebas = 'S'
	end if
	
	close(parent) 
	
	if g_ejercicio <> string(year(today())) then
		messagebox(g_titulo, 'Atenci$$HEX1$$f300$$ENDHEX$$n: ' + cr + &
		'El ejercicio contable seleccionado ('+g_ejercicio+') difiere del a$$HEX1$$f100$$ENDHEX$$o de su reloj local ('+string(year(today())) + ')'  + cr + &
		'Los procesos contables se realizar$$HEX1$$e100$$ENDHEX$$n sobre la base de datos del ejercicio ' +g_ejercicio+', los procesos administrativos sobre el reloj local cuya fecha es '+ string(today()))
	//	close(parent) 
	end if

//end if



end event

type st_3 from statictext within w_csd_logon
integer x = 530
integer y = 252
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Password:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_csd_logon
integer x = 526
integer y = 160
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Login:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_password from singlelineedit within w_csd_logon
integer x = 805
integer y = 252
integer width = 1019
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
textcase textcase = lower!
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_csd_logon
integer x = 526
integer y = 36
integer width = 1806
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Introduzca su Login, Password, el a$$HEX1$$f100$$ENDHEX$$o del ejercicio y la empresa :"
boolean focusrectangle = false
end type

type p_logotipo from picture within w_csd_logon
integer x = 18
integer y = 88
integer width = 462
integer height = 396
boolean focusrectangle = false
end type

