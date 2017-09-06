HA$PBExportHeader$w_actualizacion_ivajulio2010.srw
forward
global type w_actualizacion_ivajulio2010 from window
end type
type st_2 from statictext within w_actualizacion_ivajulio2010
end type
type dw_suceso from datawindow within w_actualizacion_ivajulio2010
end type
type cb_1 from commandbutton within w_actualizacion_ivajulio2010
end type
type st_1 from statictext within w_actualizacion_ivajulio2010
end type
end forward

global type w_actualizacion_ivajulio2010 from window
integer x = 215
integer y = 220
integer width = 2354
integer height = 1432
boolean titlebar = true
string title = "Actualizaci$$HEX1$$f300$$ENDHEX$$n IVA 2010"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
st_2 st_2
dw_suceso dw_suceso
cb_1 cb_1
st_1 st_1
end type
global w_actualizacion_ivajulio2010 w_actualizacion_ivajulio2010

on w_actualizacion_ivajulio2010.create
this.st_2=create st_2
this.dw_suceso=create dw_suceso
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={this.st_2,&
this.dw_suceso,&
this.cb_1,&
this.st_1}
end on

on w_actualizacion_ivajulio2010.destroy
destroy(this.st_2)
destroy(this.dw_suceso)
destroy(this.cb_1)
destroy(this.st_1)
end on

event open;integer retorno=1
int continuar=1
int i
string descripcion,bd_error


//Creamos tabla de control
EXECUTE IMMEDIATE 'CREATE TABLE ivajulio2010 (estado varchar(1) NOT NULL)' ;

if SQLCA.sqlcode=-1 then 
	continuar=-1
	descripcion="["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n de la tabla de control de actualizaci$$HEX1$$f300$$ENDHEX$$n."
	bd_error="Error:"+SQLCA.sqlerrtext
	i= dw_suceso.InsertRow(0)
	dw_suceso.setitem(i,'descripcion',descripcion)
	dw_suceso.setitem(i,'error',bd_error)

end if

if continuar=1 then
	//st_3.text="Actualizando campos Fecha Inicio y Fecha Fin de validez"
	retorno=gnv_ivajulio2010.of_bd_actualizar_tipos_iva_validez(dw_suceso)
	if retorno=-1 then 
		continuar=-1
	else
		descripcion = 'CORRECTO Actualizaci$$HEX1$$f300$$ENDHEX$$n de los nuevos campos del matenimiento de IVA.'
		i= dw_suceso.InsertRow(0)
		dw_suceso.setitem(i,'descripcion',descripcion)
		dw_suceso.setitem(i,'error_visible','N')
	end if
end if

if continuar=1 then
	//st_3.text="Actualizando nuevos tipos de IVA"
	retorno=gnv_ivajulio2010.of_bd_insertar_tipos_iva(dw_suceso)
	if retorno=-1 then 
		continuar=-1
	else 
		descripcion = 'CORRECTO Actualizaci$$HEX1$$f300$$ENDHEX$$n de los nuevos tipos de IVA.'
		i= dw_suceso.InsertRow(0)
		dw_suceso.setitem(i,'descripcion',descripcion)
		dw_suceso.setitem(i,'error_visible','N')
	end if
end if

if continuar=1 then
	//st_3.text="Actualizando el tipo de IVA por defecto"
	retorno=gnv_ivajulio2010.of_bd_actualizar_tipos_iva_defecto(dw_suceso)
	if retorno=-1 then 
		continuar=-1
	else 
		descripcion = 'CORRECTO Actualizaci$$HEX1$$f300$$ENDHEX$$n del tipo de IVA por defecto'
		i= dw_suceso.InsertRow(0)
		dw_suceso.setitem(i,'descripcion',descripcion)
		dw_suceso.setitem(i,'error_visible','N')
	end if
end if

if continuar=1 then
	//st_3.text="Actualizando tipos de IVA en articulos"
	retorno=gnv_ivajulio2010.of_bd_actualizar_articulos(dw_suceso)
	if retorno=-1 then 
		continuar=-1
	else 
		descripcion = 'CORRECTO Actualizaci$$HEX1$$f300$$ENDHEX$$n del campo tipo de IVA en articulos.'
		i= dw_suceso.InsertRow(0)
		dw_suceso.setitem(i,'descripcion',descripcion)
		dw_suceso.setitem(i,'error_visible','N')
	end if
end if

if continuar=1 then
	//st_3.text="Actualizando tipos de IVA en clientes y proveedores"
	retorno=gnv_ivajulio2010.of_bd_actualizar_clientes_proveedores(dw_suceso)
	if retorno=-1 then 
		continuar=-1
	else 
		descripcion = 'CORRECTO Actualizaci$$HEX1$$f300$$ENDHEX$$n del campo tipo de IVA en clientes/proveedores.'
		i= dw_suceso.InsertRow(0)
		dw_suceso.setitem(i,'descripcion',descripcion)
		dw_suceso.setitem(i,'error_visible','N')
	end if
end if

if continuar=1 then
	retorno=gnv_ivajulio2010.of_bd_actualizar_predefinidos(dw_suceso)
	if retorno=-1 then 
		continuar=-1
	else 
		descripcion = 'CORRECTO Actualizaci$$HEX1$$f300$$ENDHEX$$n del campo tipo de IVA en asientos predefinidos.'
		i= dw_suceso.InsertRow(0)
		dw_suceso.setitem(i,'descripcion',descripcion)
		dw_suceso.setitem(i,'error_visible','N')
	end if
end if

if continuar=1 then
	//st_3.text="Actualizando cuentas contables para los nuevos tipos de IVA"
	retorno=gnv_ivajulio2010.of_bd_actualizar_cuentas(dw_suceso)
	if retorno=-1 then 
		continuar=-1
	else 
		descripcion = 'CORRECTO Actualizaci$$HEX1$$f300$$ENDHEX$$n de las cuentas contables'
		i= dw_suceso.InsertRow(0)
		dw_suceso.setitem(i,'descripcion',descripcion)
		dw_suceso.setitem(i,'error_visible','N')
	end if
end if
//st_3.text=''
//A$$HEX1$$f100$$ENDHEX$$adimos valor a la tabla de control confirmando que la actualizaci$$HEX1$$f300$$ENDHEX$$n ha terminado correctamente
st_2.visible=true
if continuar=1 then
	INSERT INTO ivajulio2010 (estado) VALUES ('F');
	st_2.text = 'La actualizaci$$HEX1$$f300$$ENDHEX$$n a los nuevos tipos de IVA julio 2010 finaliz$$HEX2$$f3002000$$ENDHEX$$correctamente'
//	i= dw_suceso.InsertRow(0)
//	dw_suceso.setitem(i,'descripcion',descripcion)
//	dw_suceso.setitem(i,'error_visible','N')
else
	st_2.TextColor=RGB(255,0,0)
	st_2.text = 'FALLO en la actualizaci$$HEX1$$f300$$ENDHEX$$n a los nuevos tipos de IVA julio 2010'
//	i= dw_suceso.InsertRow(0)
//	dw_suceso.setitem(i,'descripcion',descripcion)
//	dw_suceso.setitem(i,'error_visible','N')
end if


end event

type st_2 from statictext within w_actualizacion_ivajulio2010
integer x = 73
integer y = 1056
integer width = 1792
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 8388608
long backcolor = 67108864
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_suceso from datawindow within w_actualizacion_ivajulio2010
integer x = 69
integer y = 164
integer width = 2167
integer height = 864
integer taborder = 10
string title = "none"
string dataobject = "d_suceso_ivajulio2010"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_actualizacion_ivajulio2010
integer x = 1934
integer y = 1120
integer width = 352
integer height = 132
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Salir"
end type

event clicked;int valido
valido=gnv_ivajulio2010.of_actualizacion_correcta('N')
if valido=-1 then HALT

close(parent)
end event

type st_1 from statictext within w_actualizacion_ivajulio2010
integer x = 315
integer y = 40
integer width = 1330
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 8388608
long backcolor = 67108864
string text = "Actualizaciones IVA 2010"
alignment alignment = center!
boolean focusrectangle = false
end type

