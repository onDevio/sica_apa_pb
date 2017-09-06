HA$PBExportHeader$w_factu_e_imprimir.srw
forward
global type w_factu_e_imprimir from w_response
end type
type st_1 from statictext within w_factu_e_imprimir
end type
type dw_2 from u_dw within w_factu_e_imprimir
end type
type cb_2 from commandbutton within w_factu_e_imprimir
end type
type cb_1 from commandbutton within w_factu_e_imprimir
end type
type cb_aumentar_copias from commandbutton within w_factu_e_imprimir
end type
type cb_disminuir_copias from commandbutton within w_factu_e_imprimir
end type
type sle_imprimir_originales from singlelineedit within w_factu_e_imprimir
end type
type st_2 from statictext within w_factu_e_imprimir
end type
type st_3 from statictext within w_factu_e_imprimir
end type
type sle_imprimir_copias from singlelineedit within w_factu_e_imprimir
end type
type cb_disminuir from commandbutton within w_factu_e_imprimir
end type
type cb_aumentar from commandbutton within w_factu_e_imprimir
end type
type dw_formato_impresion from datawindow within w_factu_e_imprimir
end type
end forward

global type w_factu_e_imprimir from w_response
integer width = 1801
integer height = 856
boolean controlmenu = false
event csd_comprobar_todo_cobrado ( )
st_1 st_1
dw_2 dw_2
cb_2 cb_2
cb_1 cb_1
cb_aumentar_copias cb_aumentar_copias
cb_disminuir_copias cb_disminuir_copias
sle_imprimir_originales sle_imprimir_originales
st_2 st_2
st_3 st_3
sle_imprimir_copias sle_imprimir_copias
cb_disminuir cb_disminuir
cb_aumentar cb_aumentar
dw_formato_impresion dw_formato_impresion
end type
global w_factu_e_imprimir w_factu_e_imprimir

type variables
u_dw i_dw_minutas
string tipo_cobro,i_id_minuta
n_csd_impresion_formato i_impresion_formato
st_w_factu_e_imprimir i_st_estructura
end variables

on w_factu_e_imprimir.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_aumentar_copias=create cb_aumentar_copias
this.cb_disminuir_copias=create cb_disminuir_copias
this.sle_imprimir_originales=create sle_imprimir_originales
this.st_2=create st_2
this.st_3=create st_3
this.sle_imprimir_copias=create sle_imprimir_copias
this.cb_disminuir=create cb_disminuir
this.cb_aumentar=create cb_aumentar
this.dw_formato_impresion=create dw_formato_impresion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_aumentar_copias
this.Control[iCurrent+6]=this.cb_disminuir_copias
this.Control[iCurrent+7]=this.sle_imprimir_originales
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.sle_imprimir_copias
this.Control[iCurrent+11]=this.cb_disminuir
this.Control[iCurrent+12]=this.cb_aumentar
this.Control[iCurrent+13]=this.dw_formato_impresion
end on

on w_factu_e_imprimir.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_aumentar_copias)
destroy(this.cb_disminuir_copias)
destroy(this.sle_imprimir_originales)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_imprimir_copias)
destroy(this.cb_disminuir)
destroy(this.cb_aumentar)
destroy(this.dw_formato_impresion)
end on

event open;call super::open;i_st_estructura=Message.powerobjectparm
i_impresion_formato=i_st_estructura.impresion_formato


//i_impresion_formato=Message.powerobjectparm

//Incializamos la visibilidad de los campos seg$$HEX1$$fa00$$ENDHEX$$n los valores i_st_estructura
if i_st_estructura.varias_facturas=false then
  dw_formato_impresion.object.nombre.visible=true
  dw_formato_impresion.object.asunto_email.visible=true
  dw_formato_impresion.object.nombre_t.visible=true
  dw_formato_impresion.object.asunto_email_t.visible=true
else
	dw_formato_impresion.object.nombre.visible=false
  dw_formato_impresion.object.asunto_email.visible=false
  dw_formato_impresion.object.nombre_t.visible=false
  dw_formato_impresion.object.asunto_email_t.visible=false
end if

if i_impresion_formato.pdf='N' then
	dw_formato_impresion.object.nombre.visible=false
	dw_formato_impresion.object.nombre_t.visible=false
else
	dw_formato_impresion.object.nombre.visible=true
	dw_formato_impresion.object.nombre_t.visible=true
end if

if i_impresion_formato.email='N' then
	dw_formato_impresion.object.asunto_email.visible=false
   dw_formato_impresion.object.asunto_email_t.visible=false
	dw_formato_impresion.object.direccion_email.visible=false
	dw_formato_impresion.object.direccion_email_t.visible=false
else
	dw_formato_impresion.object.asunto_email.visible=true
   dw_formato_impresion.object.asunto_email_t.visible=true
	dw_formato_impresion.object.direccion_email.visible=true
	dw_formato_impresion.object.direccion_email_t.visible=true
end if

f_centrar_ventana(this)
dw_formato_impresion.insertrow(0)
//Inicializamos datos
dw_formato_impresion.setitem(1,'pdf',i_impresion_formato.pdf)
dw_formato_impresion.setitem(1,'papel',i_impresion_formato.papel)
dw_formato_impresion.setitem(1,'email',i_impresion_formato.email)
dw_formato_impresion.setitem(1,'nombre',i_impresion_formato.nombre)
dw_formato_impresion.setitem(1,'direccion_email',i_impresion_formato.direccion_email)
dw_formato_impresion.setitem(1,'asunto_email',i_impresion_formato.asunto_email)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_factu_e_imprimir
integer taborder = 80
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_factu_e_imprimir
integer taborder = 20
end type

type st_1 from statictext within w_factu_e_imprimir
integer x = 37
integer y = 32
integer width = 1042
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione las opciones de impresi$$HEX1$$f300$$ENDHEX$$n deseadas"
boolean focusrectangle = false
end type

type dw_2 from u_dw within w_factu_e_imprimir
boolean visible = false
integer x = 1280
integer y = 304
integer width = 987
integer height = 352
integer taborder = 90
string dataobject = "d_factu_minutas_detalle"
boolean hscrollbar = true
boolean resizable = true
boolean ib_rmbmenu = false
end type

type cb_2 from commandbutton within w_factu_e_imprimir
integer x = 1024
integer y = 584
integer width = 402
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
boolean cancel = true
end type

event clicked;closewithreturn(parent, 'CANCELAR')

end event

type cb_1 from commandbutton within w_factu_e_imprimir
integer x = 334
integer y = 584
integer width = 402
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
boolean default = true
end type

event clicked;string sl_originales, sl_copias
integer copias


dw_formato_impresion.accepttext()
dw_formato_impresion.Event csd_opciones_impresion()
copias=dw_formato_impresion.getitemnumber(1,'copias')
closewithreturn(parent,string(copias))

end event

type cb_aumentar_copias from commandbutton within w_factu_e_imprimir
boolean visible = false
integer x = 640
integer y = 216
integer width = 64
integer height = 44
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "+"
end type

event clicked;if sle_imprimir_originales.text < '98' then
	sle_imprimir_originales.text= string(integer(sle_imprimir_originales.text) + 1 , '00')
end if
end event

type cb_disminuir_copias from commandbutton within w_factu_e_imprimir
boolean visible = false
integer x = 640
integer y = 264
integer width = 64
integer height = 44
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "-"
end type

event clicked;if sle_imprimir_originales.text > '00' then
	sle_imprimir_originales.text= string(integer(sle_imprimir_originales.text) - 1 , '00')
end if
end event

type sle_imprimir_originales from singlelineedit within w_factu_e_imprimir
boolean visible = false
integer x = 526
integer y = 220
integer width = 105
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "01"
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

event losefocus;this.text= string(integer(this.text) , '00')

end event

type st_2 from statictext within w_factu_e_imprimir
boolean visible = false
integer x = 219
integer y = 236
integer width = 311
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$ba002000$$ENDHEX$$Originales :"
boolean focusrectangle = false
end type

type st_3 from statictext within w_factu_e_imprimir
boolean visible = false
integer x = 805
integer y = 236
integer width = 270
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$ba002000$$ENDHEX$$Copias :"
boolean focusrectangle = false
end type

type sle_imprimir_copias from singlelineedit within w_factu_e_imprimir
boolean visible = false
integer x = 1074
integer y = 220
integer width = 105
integer height = 84
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "01"
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

event losefocus;this.text= string(integer(this.text) , '00')

end event

type cb_disminuir from commandbutton within w_factu_e_imprimir
boolean visible = false
integer x = 1184
integer y = 264
integer width = 64
integer height = 44
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "-"
end type

event clicked;if sle_imprimir_copias.text > '00' then
	sle_imprimir_copias.text= string(integer(sle_imprimir_copias.text) - 1 , '00')
end if
end event

type cb_aumentar from commandbutton within w_factu_e_imprimir
boolean visible = false
integer x = 1184
integer y = 216
integer width = 64
integer height = 44
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "+"
end type

event clicked;if sle_imprimir_copias.text < '98' then
	sle_imprimir_copias.text= string(integer(sle_imprimir_copias.text) + 1 , '00')
end if
end event

type dw_formato_impresion from datawindow within w_factu_e_imprimir
event csd_opciones_impresion ( )
integer x = 37
integer y = 128
integer width = 1687
integer height = 388
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_factu_formato_impresion"
boolean border = false
boolean livescroll = true
end type

event csd_opciones_impresion();//Datos de copias en papel
i_impresion_formato.papel	= GetItemstring(1, "papel")
i_impresion_formato.copias = GetItemnumber(1, "originales")
//Datos de copias en email
i_impresion_formato.direccion_email=GetItemstring(1, "direccion_email")
i_impresion_formato.email 			= GetItemstring(1, "email")
i_impresion_formato.asunto_email = GetItemstring(1, "asunto_email")

if f_es_vacio(i_impresion_formato.asunto_email) then
	i_impresion_formato.asunto_email = 'Informaci$$HEX1$$f300$$ENDHEX$$n de facturas '
end if

i_impresion_formato.texto_email = ''

//Datos de copias en pdf
i_impresion_formato.visualizar_web 	= 'N'
i_impresion_formato.pdf = GetItemstring(1, "pdf") 
i_impresion_formato.nombre=getitemstring(1,'nombre')

if f_es_vacio(i_impresion_formato.nombre) then i_impresion_formato.nombre = 'Facturas'

i_impresion_formato.ruta_base 			= g_directorio_documentos_visared
// Si le pasamos una concreta que no la modifique
if f_es_vacio(i_impresion_formato.ruta_relativa) then i_impresion_formato.ruta_relativa	= ''
i_impresion_formato.pdf_previsualizar 	= false	//No se muestra una previsualizaci$$HEX1$$f300$$ENDHEX$$n del pdf

//General
i_impresion_formato.destino 			= 'C'
i_impresion_formato.referencia 		= ''
//i_impresion_formato.dw =
//S$$HEX1$$f300$$ENDHEX$$lo avisaremos si no se imprimen varias facturas de golpe
if i_st_estructura.varias_facturas=true then
	i_impresion_formato.avisos 			= 0		
else													
	i_impresion_formato.avisos 			= 1
end if
i_impresion_formato.modo_creacion	= 0		//Si el fichero ya existe, se sustituye

// INC. 8045 Se genera la factura en pdf como duplicado
i_impresion_formato.duplicado = 'N'
if GetItemnumber(1, "originales") = 0 and GetItemnumber(1, "copias") = 1 and (GetItemstring(1, "email") = 'S' or GetItemstring(1, "pdf") = 'S') then
	i_impresion_formato.duplicado = 'S'
	i_impresion_formato.copias = 1
end if

end event

event itemchanged;
//Necesitamos el valor de i_st_estructura.varias_facturas para determinar la visibilida de los campos
//por lo que no podemos controlar esta con una expresi$$HEX1$$f300$$ENDHEX$$n en la propiedad .visible

choose case dwo.name
  case 'pdf'
	//Si vamos a imprimir varias facturas no modificamos la visibilidad de los campos
	if i_st_estructura.varias_facturas=false then
		if data='S' then
			dw_formato_impresion.object.nombre.visible=true
		   dw_formato_impresion.object.nombre_t.visible=true
		else
			dw_formato_impresion.object.nombre.visible=false
		   dw_formato_impresion.object.nombre_t.visible=false
		end if
	end if
  case 'email'
	if i_st_estructura.varias_facturas=false then
		if data='S' then
			dw_formato_impresion.object.asunto_email.visible=true
         dw_formato_impresion.object.asunto_email_t.visible=true
			dw_formato_impresion.object.direccion_email.visible=true
			dw_formato_impresion.object.direccion_email_t.visible=true
		else
			dw_formato_impresion.object.asunto_email.visible=false
         dw_formato_impresion.object.asunto_email_t.visible=false
			dw_formato_impresion.object.direccion_email.visible=false
			dw_formato_impresion.object.direccion_email_t.visible=false
		end if
	else
		if data='S' then
			dw_formato_impresion.object.direccion_email.visible=true
			dw_formato_impresion.object.direccion_email_t.visible=true
		else
			dw_formato_impresion.object.direccion_email.visible=false
			dw_formato_impresion.object.direccion_email_t.visible=false
		end if
	end if
end choose

end event

