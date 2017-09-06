HA$PBExportHeader$w_comprobacion_cuentas_bancarias.srw
forward
global type w_comprobacion_cuentas_bancarias from w_response
end type
type dw_datos_cuenta from u_dw within w_comprobacion_cuentas_bancarias
end type
type st_1 from statictext within w_comprobacion_cuentas_bancarias
end type
type p_1 from picture within w_comprobacion_cuentas_bancarias
end type
type p_2 from picture within w_comprobacion_cuentas_bancarias
end type
type st_2 from statictext within w_comprobacion_cuentas_bancarias
end type
type cb_ok from commandbutton within w_comprobacion_cuentas_bancarias
end type
type cb_cancel from commandbutton within w_comprobacion_cuentas_bancarias
end type
type st_3 from statictext within w_comprobacion_cuentas_bancarias
end type
end forward

global type w_comprobacion_cuentas_bancarias from w_response
integer width = 2610
integer height = 808
dw_datos_cuenta dw_datos_cuenta
st_1 st_1
p_1 p_1
p_2 p_2
st_2 st_2
cb_ok cb_ok
cb_cancel cb_cancel
st_3 st_3
end type
global w_comprobacion_cuentas_bancarias w_comprobacion_cuentas_bancarias

type variables
 string is_colname
end variables

on w_comprobacion_cuentas_bancarias.create
int iCurrent
call super::create
this.dw_datos_cuenta=create dw_datos_cuenta
this.st_1=create st_1
this.p_1=create p_1
this.p_2=create p_2
this.st_2=create st_2
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_datos_cuenta
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.p_2
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cb_ok
this.Control[iCurrent+7]=this.cb_cancel
this.Control[iCurrent+8]=this.st_3
end on

on w_comprobacion_cuentas_bancarias.destroy
call super::destroy
destroy(this.dw_datos_cuenta)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.p_2)
destroy(this.st_2)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.st_3)
end on

event open;call super::open;string ls_cuenta, ls_pais, cuenta_inicial,ls_iban,ls_cc
int li_fila

p_2.visible = false
p_1.visible = false


ls_cuenta = message.stringparm

li_fila = dw_datos_cuenta.insertrow(0)

if not f_es_vacio(ls_cuenta) then 
	
	if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_cuenta) then 
		
		dw_datos_cuenta.setitem(li_fila, 'cc', gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_IBAN(ls_cuenta))
		ls_pais = gnv_control_cuentas_bancarias.of_obtener_cod_pais_cuenta_iban(ls_cuenta)
		dw_datos_cuenta.setitem(li_fila, 'iban', gnv_control_cuentas_bancarias.of_obtener_IBAN(ls_cuenta, ls_pais))
		dw_datos_cuenta.setitem(li_fila, 'pais', ls_pais)
		p_2.visible = false
		p_1.visible = true
		cb_ok.enabled = true
	
	else 
		cb_ok.enabled = false		
		p_2.visible = true
		
	end if	
else
	cb_ok.enabled = false	
end if

cuenta_inicial = dw_datos_cuenta.getitemstring(1,'cc')
if cuenta_inicial <> '' or not isnull(cuenta_inicial) then
	//st_2.text = cuenta_inicial	
	ls_iban = dw_datos_cuenta.getitemstring(li_fila, 'iban')
	st_2.text = gnv_control_cuentas_bancarias.of_obtener_iban_escrito( ls_iban + cuenta_inicial)
end if

dw_datos_cuenta.setFocus()
dw_datos_cuenta.setcolumn('cc')
is_colname = 'cc'


end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_comprobacion_cuentas_bancarias
integer y = 568
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_comprobacion_cuentas_bancarias
integer x = 165
integer y = 568
end type

type dw_datos_cuenta from u_dw within w_comprobacion_cuentas_bancarias
integer x = 18
integer y = 108
integer width = 2446
integer height = 164
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_comprobacion_cuentas_bancarias"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = False
end event

event itemchanged;call super::itemchanged;string ls_cuenta_completa, ls_cc, ls_iban

st_2.text = ''
p_2.visible = false
p_1.visible = false
st_3.text = ''
cb_ok.enabled = false

if  dwo.name = 'pais' then 
		
		ls_cc = dw_datos_cuenta.getitemstring(row, 'cc')

		if  not f_es_vacio(ls_cc) then 
			ls_iban = gnv_control_cuentas_bancarias.of_obtener_IBAN(ls_cc, data)
			dw_datos_cuenta.setitem( row, 'iban', ls_iban)		
			p_1.visible = true
			st_2.text = gnv_control_cuentas_bancarias.of_obtener_iban_escrito( ls_iban + ls_cc)
			cb_ok.enabled = true
		end if	
end if
end event

event itemfocuschanged;call super::itemfocuschanged;string ls_cuenta_completa, ls_cc, ls_iban, ls_pais, ls_pais_from_iban

st_2.text = ''
st_3.text = ''
p_2.visible = false
p_1.visible = false
cb_ok.enabled = false

		ls_pais = dw_datos_cuenta.getitemstring(row, 'pais')
		ls_cc = dw_datos_cuenta.getitemstring(row, 'cc')
		ls_iban = dw_datos_cuenta.getitemstring(row, 'iban')

choose case is_colname
	case 'iban'

		if not f_es_vacio(ls_iban) then 
		
			ls_cuenta_completa =  ls_iban + ls_cc
			
			if ls_pais = MidA(ls_iban, 1, 2) then 
				if not f_es_vacio(ls_cc) then 
					if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban, ls_cc) then 
						p_2.visible = false
						p_1.visible = true
						cb_ok.enabled = true
						st_2.text = gnv_control_cuentas_bancarias.of_obtener_iban_escrito( ls_cuenta_completa )
					else
						p_2.visible = true
						p_1.visible = false
						st_3.text = gnv_control_cuentas_bancarias.of_mostrar_descripcion_error()
					end if 	
				end if 
			else	
				st_3.text = "El pais seleccionado no coincide con el pais del n$$HEX1$$fa00$$ENDHEX$$mero IBAN. Corr$$HEX1$$ed00$$ENDHEX$$jalo"
				p_2.visible = true
				p_1.visible = false
			end if
		else
			if not f_es_vacio(ls_cc) then
				if ls_pais = 'ES'  then
				if not (gnv_control_cuentas_bancarias.of_comprobar_dc_es(ls_cc)) then 
					st_3.text = gnv_control_cuentas_bancarias.of_mostrar_descripcion_error()
					p_2.visible = true
					p_1.visible = false
					is_colname = dwo.name
					return
				end if
			end if
			
				ls_iban = gnv_control_cuentas_bancarias.of_obtener_iban(ls_cc, ls_pais)
				dw_datos_cuenta.setitem(row, 'iban', ls_iban)
				st_2.text = gnv_control_cuentas_bancarias.of_obtener_iban_escrito( ls_iban + ls_cc )
				p_2.visible = false
				p_1.visible = true
				cb_ok.enabled = true
			end if
		end if
				
	case 	'cc'
		
		if f_es_vacio(ls_iban) then 
			if ls_pais = 'ES'  then
				if not (gnv_control_cuentas_bancarias.of_comprobar_dc_es(ls_cc)) then 
					st_3.text = gnv_control_cuentas_bancarias.of_mostrar_descripcion_error()
					p_2.visible = true
					p_1.visible = false
					is_colname = dwo.name
					return
				end if
			end if
			
			ls_iban = gnv_control_cuentas_bancarias.of_obtener_iban(ls_cc, ls_pais)
			dw_datos_cuenta.setitem(row, 'iban', ls_iban)
			st_2.text = gnv_control_cuentas_bancarias.of_obtener_iban_escrito( ls_iban + ls_cc )
			p_2.visible = false
			p_1.visible = true	
			cb_ok.enabled = true
		else
			ls_cuenta_completa =  ls_iban + ls_cc
			if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban, ls_cc) then 
					p_2.visible = false
					p_1.visible = true
					cb_ok.enabled = true
					st_2.text = gnv_control_cuentas_bancarias.of_obtener_iban_escrito( ls_cuenta_completa )
				else
					p_2.visible = true
					p_1.visible = false
					st_3.text = gnv_control_cuentas_bancarias.of_mostrar_descripcion_error()
			end if 
		end if
		
end choose

is_colname = dwo.name
end event

event losefocus;call super::losefocus;string ls_cuenta_completa, ls_cc, ls_iban, ls_pais, ls_pais_from_iban



		ls_pais = dw_datos_cuenta.getitemstring(dw_datos_cuenta.getrow(), 'pais')
		ls_cc = dw_datos_cuenta.getitemstring(dw_datos_cuenta.getrow(), 'cc')
		ls_iban = dw_datos_cuenta.getitemstring(dw_datos_cuenta.getrow(), 'iban')

choose case is_colname
	case 'iban'

		st_3.text = ''
		st_2.text = ''
		p_2.visible = false
		p_1.visible = false
		
		ls_cuenta_completa =  ls_iban + ls_cc

		if not f_es_vacio(ls_iban) then 
			if ls_pais = MidA(ls_iban, 1, 2) then 
				if not f_es_vacio(ls_cc) then 
					if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban, ls_cc) then 
						p_2.visible = false
						p_1.visible = true
						cb_ok.enabled = true
						st_2.text = gnv_control_cuentas_bancarias.of_obtener_iban_escrito( ls_cuenta_completa )
					else
						cb_ok.enabled = false
						p_2.visible = true
						p_1.visible = false
						st_3.text = gnv_control_cuentas_bancarias.of_mostrar_descripcion_error()
					end if 	
				end if 
			else	
				st_3.text = "El pais seleccionado no coincide con el pais del n$$HEX1$$fa00$$ENDHEX$$mero IBAN. Corr$$HEX1$$ed00$$ENDHEX$$jalo"
				p_2.visible = true
				p_1.visible = false
				cb_ok.enabled = false
			end if
		else
			if not f_es_vacio(ls_cc) then
				if ls_pais = 'ES'  then
				if not (gnv_control_cuentas_bancarias.of_comprobar_dc_es(ls_cc)) then 
					st_3.text = gnv_control_cuentas_bancarias.of_mostrar_descripcion_error()
					p_2.visible = true
					p_1.visible = false
					cb_ok.enabled = false
					return
				end if
			end if
			
				ls_iban = gnv_control_cuentas_bancarias.of_obtener_iban(ls_cc, ls_pais)
				dw_datos_cuenta.setitem(dw_datos_cuenta.getrow(), 'iban', ls_iban)
				st_2.text = gnv_control_cuentas_bancarias.of_obtener_iban_escrito( ls_iban + ls_cc )
				p_2.visible = false
				p_1.visible = true
				cb_ok.enabled = true
			end if
		end if				
		
	case 	'cc'

		st_3.text = ''
		st_2.text = ''
		p_2.visible = false
		p_1.visible = false
		
		
		if f_es_vacio(ls_iban) then 
			if ls_pais = 'ES'  then
				if not (gnv_control_cuentas_bancarias.of_comprobar_dc_es(ls_cc)) then 
					st_3.text = gnv_control_cuentas_bancarias.of_mostrar_descripcion_error()
					p_2.visible = true
					p_1.visible = false
					cb_ok.enabled = false
//					is_colname = dwo.name
					return
				end if
			end if
			
			ls_iban = gnv_control_cuentas_bancarias.of_obtener_iban(ls_cc, ls_pais)
			dw_datos_cuenta.setitem(dw_datos_cuenta.getrow(), 'iban', ls_iban )
			st_2.text = gnv_control_cuentas_bancarias.of_obtener_iban_escrito( ls_iban + ls_cc)
			
			p_2.visible = false
			p_1.visible = true
			cb_ok.enabled = true	
		else
			ls_cuenta_completa =  ls_iban + ls_cc
			if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban, ls_cc) then 
					p_2.visible = false
					p_1.visible = true
					cb_ok.enabled = true
					st_2.text = gnv_control_cuentas_bancarias.of_obtener_iban_escrito( ls_cuenta_completa )
				else
					p_2.visible = true
					p_1.visible = false
					cb_ok.enabled = false
					st_3.text = gnv_control_cuentas_bancarias.of_mostrar_descripcion_error()
			end if 
		end if

end choose

//is_colname = dwo.name
end event

type st_1 from statictext within w_comprobacion_cuentas_bancarias
integer x = 416
integer y = 304
integer width = 603
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Formato IBAN escrito:"
boolean focusrectangle = false
end type

type p_1 from picture within w_comprobacion_cuentas_bancarias
boolean visible = false
integer x = 2482
integer y = 184
integer width = 73
integer height = 76
boolean bringtotop = true
string picturename = ".\imagenes\update.bmp"
boolean focusrectangle = false
end type

type p_2 from picture within w_comprobacion_cuentas_bancarias
boolean visible = false
integer x = 2482
integer y = 184
integer width = 73
integer height = 76
boolean bringtotop = true
string picturename = ".\imagenes\fn2568.bmp"
boolean focusrectangle = false
end type

type st_2 from statictext within w_comprobacion_cuentas_bancarias
integer x = 1042
integer y = 300
integer width = 1422
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_comprobacion_cuentas_bancarias
integer x = 1307
integer y = 564
integer width = 562
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar: Devolver Valor"
boolean default = true
end type

event clicked;string ls_cuenta

ls_cuenta = gnv_control_cuentas_bancarias.of_eliminar_caracteres_no_validos(dw_datos_cuenta.getitemstring(dw_datos_cuenta.getrow(), 'iban') + dw_datos_cuenta.getitemstring(dw_datos_cuenta.getrow(), 'cc'))

closewithreturn(parent,ls_cuenta)
end event

type cb_cancel from commandbutton within w_comprobacion_cuentas_bancarias
integer x = 1920
integer y = 564
integer width = 549
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = " Cancelar"
boolean cancel = true
end type

event clicked;closewithreturn(parent,'')
end event

type st_3 from statictext within w_comprobacion_cuentas_bancarias
integer x = 46
integer y = 416
integer width = 2409
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

