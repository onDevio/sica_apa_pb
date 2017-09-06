HA$PBExportHeader$w_sellador_info_firmas.srw
forward
global type w_sellador_info_firmas from w_response
end type
type cb_1 from u_cb within w_sellador_info_firmas
end type
type st_2 from statictext within w_sellador_info_firmas
end type
type dw_visual from u_dw within w_sellador_info_firmas
end type
type dw_info_firmas from u_dw within w_sellador_info_firmas
end type
type cb_primero from commandbutton within w_sellador_info_firmas
end type
type cb_anterior from commandbutton within w_sellador_info_firmas
end type
type cb_siguiente from commandbutton within w_sellador_info_firmas
end type
type cb_ultimo from commandbutton within w_sellador_info_firmas
end type
type st_1 from statictext within w_sellador_info_firmas
end type
end forward

global type w_sellador_info_firmas from w_response
integer width = 2053
integer height = 720
event csd_cargar_firma ( integer fila )
cb_1 cb_1
st_2 st_2
dw_visual dw_visual
dw_info_firmas dw_info_firmas
cb_primero cb_primero
cb_anterior cb_anterior
cb_siguiente cb_siguiente
cb_ultimo cb_ultimo
st_1 st_1
end type
global w_sellador_info_firmas w_sellador_info_firmas

type variables
int fila_actual
end variables

event csd_cargar_firma(integer fila);dw_visual.reset()
dw_info_firmas.rowscopy(fila,fila,Primary!, dw_visual, 1, Primary!)

st_2.text = 'Firma ' + string(fila) + ' de ' + string(dw_info_firmas.rowcount())
end event

on w_sellador_info_firmas.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_2=create st_2
this.dw_visual=create dw_visual
this.dw_info_firmas=create dw_info_firmas
this.cb_primero=create cb_primero
this.cb_anterior=create cb_anterior
this.cb_siguiente=create cb_siguiente
this.cb_ultimo=create cb_ultimo
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_visual
this.Control[iCurrent+4]=this.dw_info_firmas
this.Control[iCurrent+5]=this.cb_primero
this.Control[iCurrent+6]=this.cb_anterior
this.Control[iCurrent+7]=this.cb_siguiente
this.Control[iCurrent+8]=this.cb_ultimo
this.Control[iCurrent+9]=this.st_1
end on

on w_sellador_info_firmas.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.dw_visual)
destroy(this.dw_info_firmas)
destroy(this.cb_primero)
destroy(this.cb_anterior)
destroy(this.cb_siguiente)
destroy(this.cb_ultimo)
destroy(this.st_1)
end on

event open;call super::open;string fichero_pdf
u_revision_firmas revisor
int i
int num_firmas = 0, num_revisiones

f_centrar_ventana(this)

revisor = create u_revision_firmas

fichero_pdf = message.stringparm

//Leemos los datos de la firma del fichero solicitado
revisor.is_nombre_fichero_pdf = fichero_pdf
revisor.is_nombre_fichero_ini = LeftA(fichero_pdf,LenA(fichero_pdf) - 4) + ".ini"
revisor.of_leer_certificado(false)

//Cargamos los datos en el datawindow
num_firmas = revisor.ii_num_firmas
num_revisiones = revisor.ii_num_revisiones
if revisor.i_retorno < 0 then
	st_1.VISIBLE = TRUE
	st_1.text = "Error validando las firmas del documento"
	st_2.text = '0 firmas'
end if

for i = 1 to num_firmas
	dw_info_firmas.event pfc_addrow()
	dw_info_firmas.setitem(i,'nombre',revisor.is_nombre_firma[i])
	dw_info_firmas.setitem(i,'razon',revisor.is_razon_firma[i])
	dw_info_firmas.setitem(i,'localizacion',revisor.is_localizacion[i])
	dw_info_firmas.setitem(i,'cn',revisor.is_cn_certificado[i])
	dw_info_firmas.setitem(i,'fecha_desde',revisor.idt_fecha_desde_certificado[i])
	dw_info_firmas.setitem(i,'fecha_hasta',revisor.idt_fecha_hasta_certificado[i])
	// Casos posibles para las firmas
	//Firma valida y pertenece a la ultima revisi$$HEX1$$f300$$ENDHEX$$n
	if revisor.ib_firma_valida[i] = true and i = num_revisiones then 
		dw_info_firmas.setitem(i,'firma_valida','S')
	end if
	//Firma valida y hay una revision posterior
	if revisor.ib_firma_valida[i] = true and i < num_revisiones then 
		dw_info_firmas.setitem(i,'firma_valida','I')
	end if
	//Firma invalida
	if revisor.ib_firma_valida[i] = false then 
		dw_info_firmas.setitem(i,'firma_valida','N')
	end if
next

if num_firmas = 0 then
	st_1.text = cr + 'DOCUMENTO NO FIRMADO'
	st_1.VISIBLE = TRUE
	st_2.text = '0 firmas'
end if

if num_firmas > 0 then
	fila_actual = 1
	event csd_cargar_firma(1)
end if

//Borramos el objeto
destroy revisor

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_sellador_info_firmas
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_sellador_info_firmas
end type

type cb_1 from u_cb within w_sellador_info_firmas
integer x = 1659
integer y = 512
integer taborder = 11
boolean bringtotop = true
string text = "Cerrar"
end type

event clicked;call super::clicked;close(parent)
end event

type st_2 from statictext within w_sellador_info_firmas
integer x = 37
integer y = 508
integer width = 329
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 1090519039
long backcolor = 255
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_visual from u_dw within w_sellador_info_firmas
integer x = 50
integer y = 28
integer width = 1952
integer height = 464
integer taborder = 10
string dataobject = "d_sellador_datos_firmas"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.object.p_firma_valida.Filename = g_directorio_imagenes + "v.gif"
this.object.p_firma_no_valida.Filename = g_directorio_imagenes + "x.gif"
this.object.p_advertencia.Filename = g_directorio_imagenes + "adver.gif"

end event

type dw_info_firmas from u_dw within w_sellador_info_firmas
boolean visible = false
integer x = 37
integer y = 28
integer width = 2039
integer height = 780
integer taborder = 10
string dataobject = "d_sellador_datos_firmas"
boolean border = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type cb_primero from commandbutton within w_sellador_info_firmas
integer x = 384
integer y = 504
integer width = 91
integer height = 72
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "|<"
end type

event clicked;if dw_info_firmas.rowcount() > 0 then
	fila_actual = 1
	event csd_cargar_firma(1)
end if
end event

type cb_anterior from commandbutton within w_sellador_info_firmas
integer x = 475
integer y = 504
integer width = 91
integer height = 72
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "<"
end type

event clicked;if dw_info_firmas.rowcount() > 0 then
	fila_actual = fila_actual - 1
	if fila_actual < 1 then 
		fila_actual = 1
	end if
	event csd_cargar_firma(fila_actual)
end if
end event

type cb_siguiente from commandbutton within w_sellador_info_firmas
integer x = 567
integer y = 504
integer width = 91
integer height = 72
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = ">"
end type

event clicked;if dw_info_firmas.rowcount() > 0 then
	fila_actual = fila_actual + 1
	if fila_actual > dw_info_firmas.rowcount() then 
		fila_actual = dw_info_firmas.rowcount()
	end if
	event csd_cargar_firma(fila_actual)
end if
end event

type cb_ultimo from commandbutton within w_sellador_info_firmas
integer x = 658
integer y = 504
integer width = 91
integer height = 72
integer taborder = 41
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = ">|"
end type

event clicked;if dw_info_firmas.rowcount() > 0 then
	fila_actual = dw_info_firmas.rowcount()
	event csd_cargar_firma(dw_info_firmas.rowcount())
end if
end event

type st_1 from statictext within w_sellador_info_firmas
boolean visible = false
integer x = 46
integer y = 48
integer width = 1925
integer height = 380
integer textsize = -15
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 80269524
string text = "DOCUMENTO NO FIRMADO"
alignment alignment = center!
boolean focusrectangle = false
end type

