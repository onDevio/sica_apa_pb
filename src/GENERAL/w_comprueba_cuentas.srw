HA$PBExportHeader$w_comprueba_cuentas.srw
forward
global type w_comprueba_cuentas from window
end type
type st_estado from statictext within w_comprueba_cuentas
end type
type cbx_veinte from checkbox within w_comprueba_cuentas
end type
type cbx_menor20 from checkbox within w_comprueba_cuentas
end type
type cbx_cero from checkbox within w_comprueba_cuentas
end type
type cbx_cd from checkbox within w_comprueba_cuentas
end type
type cbx_db from checkbox within w_comprueba_cuentas
end type
type cb_exportar from commandbutton within w_comprueba_cuentas
end type
type dw_2 from datawindow within w_comprueba_cuentas
end type
type dw_conceptos_remesables from datawindow within w_comprueba_cuentas
end type
type cb_comprobar from commandbutton within w_comprueba_cuentas
end type
type gb_1 from groupbox within w_comprueba_cuentas
end type
end forward

global type w_comprueba_cuentas from window
integer width = 3803
integer height = 2588
boolean titlebar = true
string title = "Comprobacion de Cuentas"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_estado st_estado
cbx_veinte cbx_veinte
cbx_menor20 cbx_menor20
cbx_cero cbx_cero
cbx_cd cbx_cd
cbx_db cbx_db
cb_exportar cb_exportar
dw_2 dw_2
dw_conceptos_remesables dw_conceptos_remesables
cb_comprobar cb_comprobar
gb_1 gb_1
end type
global w_comprueba_cuentas w_comprueba_cuentas

on w_comprueba_cuentas.create
this.st_estado=create st_estado
this.cbx_veinte=create cbx_veinte
this.cbx_menor20=create cbx_menor20
this.cbx_cero=create cbx_cero
this.cbx_cd=create cbx_cd
this.cbx_db=create cbx_db
this.cb_exportar=create cb_exportar
this.dw_2=create dw_2
this.dw_conceptos_remesables=create dw_conceptos_remesables
this.cb_comprobar=create cb_comprobar
this.gb_1=create gb_1
this.Control[]={this.st_estado,&
this.cbx_veinte,&
this.cbx_menor20,&
this.cbx_cero,&
this.cbx_cd,&
this.cbx_db,&
this.cb_exportar,&
this.dw_2,&
this.dw_conceptos_remesables,&
this.cb_comprobar,&
this.gb_1}
end on

on w_comprueba_cuentas.destroy
destroy(this.st_estado)
destroy(this.cbx_veinte)
destroy(this.cbx_menor20)
destroy(this.cbx_cero)
destroy(this.cbx_cd)
destroy(this.cbx_db)
destroy(this.cb_exportar)
destroy(this.dw_2)
destroy(this.dw_conceptos_remesables)
destroy(this.cb_comprobar)
destroy(this.gb_1)
end on

event open;dw_conceptos_remesables.settransobject(SQLCA)
dw_conceptos_remesables.retrieve()
end event

type st_estado from statictext within w_comprueba_cuentas
integer x = 914
integer y = 416
integer width = 951
integer height = 128
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cbx_veinte from checkbox within w_comprueba_cuentas
integer x = 1792
integer y = 128
integer width = 521
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Digito de Control"
boolean checked = true
borderstyle borderstyle = styleraised!
end type

type cbx_menor20 from checkbox within w_comprueba_cuentas
integer x = 1243
integer y = 128
integer width = 475
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Menores de 20"
boolean checked = true
borderstyle borderstyle = styleraised!
end type

type cbx_cero from checkbox within w_comprueba_cuentas
integer x = 731
integer y = 128
integer width = 471
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nulas / Vac$$HEX1$$ed00$$ENDHEX$$as"
boolean checked = true
borderstyle borderstyle = styleraised!
end type

type cbx_cd from checkbox within w_comprueba_cuentas
integer x = 73
integer y = 224
integer width = 549
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cuentas Domic."
boolean checked = true
borderstyle borderstyle = styleraised!
end type

type cbx_db from checkbox within w_comprueba_cuentas
integer x = 73
integer y = 128
integer width = 521
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Datos Bancarios"
boolean checked = true
borderstyle borderstyle = styleraised!
end type

type cb_exportar from commandbutton within w_comprueba_cuentas
integer x = 3186
integer y = 1392
integer width = 489
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exportar Informe"
end type

event clicked;dw_2.saveas( )
end event

type dw_2 from datawindow within w_comprueba_cuentas
integer x = 23
integer y = 1552
integer width = 3721
integer height = 928
integer taborder = 20
string title = "none"
string dataobject = "d_resultados_cuenta"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_conceptos_remesables from datawindow within w_comprueba_cuentas
integer x = 23
integer y = 664
integer width = 3237
integer height = 688
integer taborder = 10
string title = "none"
string dataobject = "d_cuenta_conceptos_remesables"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_comprobar from commandbutton within w_comprueba_cuentas
integer x = 187
integer y = 1392
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Comprobar"
end type

event clicked;/*************************************************
Autor: Juli$$HEX1$$e100$$ENDHEX$$n Melero
Desde aqu$$HEX2$$ed002000$$ENDHEX$$se puede comprobar las cuentas de 
los colegiados, seg$$HEX1$$fa00$$ENDHEX$$n los criterios si son correctas 
o no. 
Pueden ser : Nulas, Menos de 20 d$$HEX1$$ed00$$ENDHEX$$gitos
y comprobar el d$$HEX1$$ed00$$ENDHEX$$gito de control.

*************************************************/



string cuenta, dc, b_nula,b_menor,b_digito,d_nula,d_menor,d_digito
long i,fila
boolean inserta_b,inserta_d


st_estado.text = "Espere porfavor..."


// LIMPIAMOS EL INFORME ANTES DE INSERTAR

dw_2.clear( )
dw_2.reset( )

parent.pointer = 'HourGlass!'


for i = 1 to dw_conceptos_remesables.rowcount()
	
// INICIALIZAMOS POR CADA REGISTRO
      inserta_b =false
      inserta_d =false
	b_nula = 'N'
	b_menor ='N'
	b_digito ='N'
	d_nula = 'N'
	d_menor = 'N'
	d_digito ='N'
	
	
	// DATOS BANCARIOS
	
	if cbx_db.checked = True then
	cuenta = dw_conceptos_remesables.getitemstring(i, 'conceptos_remesables_datos_bancarios_iban')
	cuenta = gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban(cuenta)
      inserta_b = false
	
	if cbx_cero.checked = true then
		if LenA(cuenta)  = 0 or trim(cuenta) = '' or isnull(cuenta) then
		  b_nula = 'S'
             inserta_b = true
		end if
	end if
	if cbx_menor20.checked = true then
      	if LenA(cuenta) < 20 and LenA(cuenta) > 0 then
             b_menor = 'S'
             inserta_b = true
		end if
				
	end if
	if cbx_veinte.checked = true then
		if LenA(cuenta) = 20 then
			dc = f_digito_control_cuenta_bancaria(MidA(cuenta,1,4),MidA(cuenta,5,4),MidA(cuenta,11,10))
			if dc <> MidA(cuenta,9,2) then 
                    b_digito = 'S'
                    inserta_b = true						  
			end if
		end if
	end if
end if

if  inserta_b = true then
	fila = dw_2.insertrow(0)
	dw_2.setitem(fila,'cuenta',cuenta)
	dw_2.setitem(fila,'n_col',dw_conceptos_remesables.getitemstring(i,'colegiados_n_colegiado'))
	dw_2.setitem(fila,'nombre',dw_conceptos_remesables.getitemstring(i,'compute_1'))						
	dw_2.setitem(fila,'nula',b_nula)
	dw_2.setitem(fila,'menos_veinte',b_menor)
	dw_2.setitem(fila,'digito',b_digito)
	dw_2.setitem(fila,'tipo',"Bancarios")
end if

// CUENTA DOMIC

if cbx_cd.checked = true then
	cuenta = dw_conceptos_remesables.getitemstring(i, 'colegiados_datos_bancarios_iban')
	cuenta = gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban(cuenta)
	if cbx_veinte.checked = true then
	if LenA(cuenta) = 20 then
		dc = f_digito_control_cuenta_bancaria(MidA(cuenta,1,4),MidA(cuenta,5,4),MidA(cuenta,11,10))
		if dc <> MidA(cuenta,9,2) then
                 d_digito = 'S'
                 inserta_d = true					  
		end if 
	end if	
end if
	if cbx_cero.checked = true then
		if LenA(cuenta)  = 0 or trim(cuenta) = '' or isnull(cuenta) then
			d_nula = 'S'
                 inserta_d = true					  			
		end if
	end if

	if cbx_menor20.checked = true then
      	if LenA(cuenta) < 20 and LenA(cuenta) > 0 then
                  d_menor = 'S'
                 inserta_d = true					  						
		end if
				
	end if


end if
if  inserta_d = true then
	fila = dw_2.insertrow(0)
	dw_2.setitem(fila,'cuenta',cuenta)
	dw_2.setitem(fila,'n_col',dw_conceptos_remesables.getitemstring(i,'colegiados_n_colegiado'))
	dw_2.setitem(fila,'nombre',dw_conceptos_remesables.getitemstring(i,'compute_1'))						
	dw_2.setitem(fila,'nula',d_nula)
	dw_2.setitem(fila,'menos_veinte',d_menor)
	dw_2.setitem(fila,'digito',d_digito)
	dw_2.setitem(fila,'tipo',"Domic.")
end if
next

st_estado.text = ""
parent.pointer = 'Arrow!'
end event

type gb_1 from groupbox within w_comprueba_cuentas
integer x = 37
integer y = 32
integer width = 3218
integer height = 608
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Opciones"
borderstyle borderstyle = styleraised!
end type

