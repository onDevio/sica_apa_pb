HA$PBExportHeader$w_sellador_previsualizacion_pdf.srw
forward
global type w_sellador_previsualizacion_pdf from w_response
end type
type cb_salir from u_cb within w_sellador_previsualizacion_pdf
end type
type cb_siguiente from u_cb within w_sellador_previsualizacion_pdf
end type
type cb_anterior from u_cb within w_sellador_previsualizacion_pdf
end type
type cb_inicio from u_cb within w_sellador_previsualizacion_pdf
end type
type cb_ultima from u_cb within w_sellador_previsualizacion_pdf
end type
type cb_imprimir from u_cb within w_sellador_previsualizacion_pdf
end type
type sle_pagina_actual from u_sle within w_sellador_previsualizacion_pdf
end type
type st_2 from u_st within w_sellador_previsualizacion_pdf
end type
type st_1 from u_st within w_sellador_previsualizacion_pdf
end type
type sle_total_paginas from u_sle within w_sellador_previsualizacion_pdf
end type
type cb_rotar from u_cb within w_sellador_previsualizacion_pdf
end type
type st_zoom from u_st within w_sellador_previsualizacion_pdf
end type
type ddlb_zoom from u_ddlb within w_sellador_previsualizacion_pdf
end type
type cb_vista_previa from u_cb within w_sellador_previsualizacion_pdf
end type
type cb_buscar from u_cb within w_sellador_previsualizacion_pdf
end type
type st_fichero from u_st within w_sellador_previsualizacion_pdf
end type
type sle_nombre_fichero from u_sle within w_sellador_previsualizacion_pdf
end type
type cb_seleccionar from u_cb within w_sellador_previsualizacion_pdf
end type
type cb_copiar from u_cb within w_sellador_previsualizacion_pdf
end type
type cb_zoom_mas from u_cb within w_sellador_previsualizacion_pdf
end type
type cb_zoom_menos from u_cb within w_sellador_previsualizacion_pdf
end type
type sle_zoom from u_sle within w_sellador_previsualizacion_pdf
end type
type gb_1 from groupbox within w_sellador_previsualizacion_pdf
end type
type gb_2 from groupbox within w_sellador_previsualizacion_pdf
end type
type ole_visor_pdf from olecustomcontrol within w_sellador_previsualizacion_pdf
end type
type cb_firmas from u_cb within w_sellador_previsualizacion_pdf
end type
type dw_firmas from u_dw within w_sellador_previsualizacion_pdf
end type
type st_3 from statictext within w_sellador_previsualizacion_pdf
end type
end forward

global type w_sellador_previsualizacion_pdf from w_response
integer width = 3662
integer height = 1920
windowstate windowstate = maximized!
event csd_visualizar ( integer fila )
event csd_recalcular_barras ( )
event csd_comprobar_firmas ( integer fila )
cb_salir cb_salir
cb_siguiente cb_siguiente
cb_anterior cb_anterior
cb_inicio cb_inicio
cb_ultima cb_ultima
cb_imprimir cb_imprimir
sle_pagina_actual sle_pagina_actual
st_2 st_2
st_1 st_1
sle_total_paginas sle_total_paginas
cb_rotar cb_rotar
st_zoom st_zoom
ddlb_zoom ddlb_zoom
cb_vista_previa cb_vista_previa
cb_buscar cb_buscar
st_fichero st_fichero
sle_nombre_fichero sle_nombre_fichero
cb_seleccionar cb_seleccionar
cb_copiar cb_copiar
cb_zoom_mas cb_zoom_mas
cb_zoom_menos cb_zoom_menos
sle_zoom sle_zoom
gb_1 gb_1
gb_2 gb_2
ole_visor_pdf ole_visor_pdf
cb_firmas cb_firmas
dw_firmas dw_firmas
st_3 st_3
end type
global w_sellador_previsualizacion_pdf w_sellador_previsualizacion_pdf

type variables
// Para capturar errores del objeto ole_visor_pdf
boolean i_capturar_errores_ole = true
boolean i_error_ole = false
string i_password_pdf

st_sellador_datos_abrir_pdf datos
end variables

event csd_visualizar(integer fila);string fichero, ruta, fichero_pdf,anyo
int tamano

//Habilitamos todos los botones, si despues falla el ocx, se deshabilitan
cb_zoom_mas.enabled = true
cb_zoom_menos.enabled = true
sle_zoom.enabled = true
ddlb_zoom.enabled = true
cb_buscar.enabled = true
cb_imprimir.enabled = true


fichero = datos.ficheros.getitemstring(fila, 'nombre_fichero')
ruta = datos.ficheros.getitemstring(fila, 'ruta_fichero')
anyo=left(ruta,4)
if datos.modulo='SELLADOR' then
	fichero_pdf = f_obtener_ruta_base(anyo) + ruta + fichero
else
	fichero_pdf = datos.ficheros.getitemstring(fila, 'ruta_base') + ruta + fichero
end if

//Comprobramos que el archivo exista y sea de extensi$$HEX1$$f300$$ENDHEX$$n pdf... sino el ocx casca
//comprobamos tb q no tenga tama$$HEX1$$f100$$ENDHEX$$o 0KB
tamano = Ceiling(gnv_fichero.of_GetFileSize(fichero_pdf) / 1024)
if isnull(fichero_pdf) or not FileExists(fichero_pdf) or upper(RightA(fichero_pdf,4)) <> '.PDF' or tamano=0 then 
	ole_visor_pdf.visible = false
	ole_visor_pdf.visible = true
	cb_zoom_mas.enabled = false
	cb_zoom_menos.enabled = false
	sle_zoom.enabled = false
	ddlb_zoom.enabled = false
	cb_buscar.enabled = false
	cb_imprimir.enabled = false
	return
end if

i_error_ole = false // Si se produce un error se pondr$$HEX2$$e1002000$$ENDHEX$$a true

ole_visor_pdf.object.loadFile(fichero_pdf)

//ole_visor_pdf.visible = true

if (i_error_ole) then
	ole_visor_pdf.visible = false
	cb_zoom_mas.enabled = false
	cb_zoom_menos.enabled = false
	sle_zoom.enabled = false
	ddlb_zoom.enabled = false
	cb_buscar.enabled = false
	cb_imprimir.enabled = false
	return
else
	sle_total_paginas.text = string(ole_visor_pdf.object.numPages)
	sle_pagina_actual.text = string(1)
	ddlb_zoom.selectitem(1)
	ddlb_zoom.event selectionchanged(1)
	sle_nombre_fichero.text = fichero
end if
end event

event csd_recalcular_barras();////Calculamos las longitudes que deben de tener las barras
//int y_ini, y_ant
//int x_ini, x_ant
//
//ole_visor_pdf.visible = false
//vsb_1.visible = false
//hsb_1.visible = false
//
////Calculo de la y
//y_ini = 0
//y_ant = 1
//
//do while y_ant <> y_ini
//	y_ant = y_ini
//	ole_visor_pdf.object.scrollBy(0,10)
//	y_ini = ole_visor_pdf.object.scrollY
//loop
//
//vsb_1.maxposition = y_ini
//ole_visor_pdf.object.scrollto(0,0)
//
////Calculo de la x
//x_ini = 0
//x_ant = 1
//
//do while x_ant <> x_ini
//	x_ant = x_ini
//	ole_visor_pdf.object.scrollBy(10,0)
//	x_ini = ole_visor_pdf.object.scrollX
//loop
//
//hsb_1.maxposition = x_ini
//ole_visor_pdf.object.scrollto(0,0)
//
//hsb_1.position = 0
//vsb_1.position = 0
//
//ole_visor_pdf.visible = true
//
//if(hsb_1.maxposition <> 0) then
//	hsb_1.visible = true
//end if
//if(vsb_1.maxposition <> 0) then
//	vsb_1.visible = true
//end if
end event

event csd_comprobar_firmas(integer fila);string fichero_pdf, fichero, ruta,anyo
u_revision_firmas revisor
int i
int num_firmas = 0, num_revisiones
boolean firma_valida, certificados_validos

firma_valida = true

f_centrar_ventana(this)

revisor = create u_revision_firmas

fichero = datos.ficheros.getitemstring(fila, 'nombre_fichero')
ruta = datos.ficheros.getitemstring(fila, 'ruta_fichero')

anyo = left(ruta,4)
if datos.modulo='SELLADOR' then
	fichero_pdf = f_obtener_ruta_base(anyo) + ruta + fichero
else
	fichero_pdf = datos.ficheros.getitemstring(fila, 'ruta_base') + ruta + fichero
end if

certificados_validos = true

//Leemos los datos de la firma del fichero solicitado
revisor.is_nombre_fichero_pdf = fichero_pdf
revisor.is_nombre_fichero_ini = LeftA(fichero_pdf,LenA(fichero_pdf) - 4) + ".ini"
revisor.of_leer_certificado(true)

//Cargamos los datos en el datawindow
num_firmas = revisor.ii_num_firmas
num_revisiones = revisor.ii_num_revisiones

if revisor.i_retorno < 0 then
	dw_firmas.event pfc_addrow()
	st_1.VISIBLE = TRUE
	st_1.text = "Error validando las firmas del documento"
end if

for i = 1 to num_firmas
	dw_firmas.event pfc_addrow()
	dw_firmas.setitem(i,'nombre',revisor.is_nombre_firma[i])
	dw_firmas.setitem(i,'razon',revisor.is_razon_firma[i])
	dw_firmas.setitem(i,'localizacion',revisor.is_localizacion[i])
	dw_firmas.setitem(i,'cn',revisor.is_cn_certificado[i])
	dw_firmas.setitem(i,'fecha_desde',revisor.idt_fecha_desde_certificado[i])
	dw_firmas.setitem(i,'fecha_hasta',revisor.idt_fecha_hasta_certificado[i])
	//Firma valida y pertenece a la ultima revisi$$HEX1$$f300$$ENDHEX$$n
	if revisor.ib_firma_valida[i] = true and i = num_revisiones then 
		dw_firmas.setitem(i,'firma_valida','S')
	end if
	//Firma valida y hay una revision posterior
	if revisor.ib_firma_valida[i] = true and i < num_revisiones then 
		dw_firmas.setitem(i,'firma_valida','I')
	end if
	//Firma invalida
	if revisor.ib_firma_valida[i] = false then 
		dw_firmas.setitem(i,'firma_valida','N')
	end if
	if revisor.ib_certificado_valido[i] = false or revisor.is_error_firma[i] = '-2' or revisor.is_error_firma[i] = '-4' then
		certificados_validos = false
	end if
next

if num_firmas = 0 then
	dw_firmas.event pfc_addrow()
	st_1.text = cr + 'DOCUMENTO NO FIRMADO'
	st_1.VISIBLE = TRUE
end if

//Comprobamos la validez de las firmas
for i = 1 to num_firmas
	if revisor.ib_firma_valida[i] = false or revisor.is_error_firma[i] = '-3' then
		firma_valida = false
	end if
next

//Borramos el objeto
destroy revisor
end event

on w_sellador_previsualizacion_pdf.create
int iCurrent
call super::create
this.cb_salir=create cb_salir
this.cb_siguiente=create cb_siguiente
this.cb_anterior=create cb_anterior
this.cb_inicio=create cb_inicio
this.cb_ultima=create cb_ultima
this.cb_imprimir=create cb_imprimir
this.sle_pagina_actual=create sle_pagina_actual
this.st_2=create st_2
this.st_1=create st_1
this.sle_total_paginas=create sle_total_paginas
this.cb_rotar=create cb_rotar
this.st_zoom=create st_zoom
this.ddlb_zoom=create ddlb_zoom
this.cb_vista_previa=create cb_vista_previa
this.cb_buscar=create cb_buscar
this.st_fichero=create st_fichero
this.sle_nombre_fichero=create sle_nombre_fichero
this.cb_seleccionar=create cb_seleccionar
this.cb_copiar=create cb_copiar
this.cb_zoom_mas=create cb_zoom_mas
this.cb_zoom_menos=create cb_zoom_menos
this.sle_zoom=create sle_zoom
this.gb_1=create gb_1
this.gb_2=create gb_2
this.ole_visor_pdf=create ole_visor_pdf
this.cb_firmas=create cb_firmas
this.dw_firmas=create dw_firmas
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_salir
this.Control[iCurrent+2]=this.cb_siguiente
this.Control[iCurrent+3]=this.cb_anterior
this.Control[iCurrent+4]=this.cb_inicio
this.Control[iCurrent+5]=this.cb_ultima
this.Control[iCurrent+6]=this.cb_imprimir
this.Control[iCurrent+7]=this.sle_pagina_actual
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.sle_total_paginas
this.Control[iCurrent+11]=this.cb_rotar
this.Control[iCurrent+12]=this.st_zoom
this.Control[iCurrent+13]=this.ddlb_zoom
this.Control[iCurrent+14]=this.cb_vista_previa
this.Control[iCurrent+15]=this.cb_buscar
this.Control[iCurrent+16]=this.st_fichero
this.Control[iCurrent+17]=this.sle_nombre_fichero
this.Control[iCurrent+18]=this.cb_seleccionar
this.Control[iCurrent+19]=this.cb_copiar
this.Control[iCurrent+20]=this.cb_zoom_mas
this.Control[iCurrent+21]=this.cb_zoom_menos
this.Control[iCurrent+22]=this.sle_zoom
this.Control[iCurrent+23]=this.gb_1
this.Control[iCurrent+24]=this.gb_2
this.Control[iCurrent+25]=this.ole_visor_pdf
this.Control[iCurrent+26]=this.cb_firmas
this.Control[iCurrent+27]=this.dw_firmas
this.Control[iCurrent+28]=this.st_3
end on

on w_sellador_previsualizacion_pdf.destroy
call super::destroy
destroy(this.cb_salir)
destroy(this.cb_siguiente)
destroy(this.cb_anterior)
destroy(this.cb_inicio)
destroy(this.cb_ultima)
destroy(this.cb_imprimir)
destroy(this.sle_pagina_actual)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_total_paginas)
destroy(this.cb_rotar)
destroy(this.st_zoom)
destroy(this.ddlb_zoom)
destroy(this.cb_vista_previa)
destroy(this.cb_buscar)
destroy(this.st_fichero)
destroy(this.sle_nombre_fichero)
destroy(this.cb_seleccionar)
destroy(this.cb_copiar)
destroy(this.cb_zoom_mas)
destroy(this.cb_zoom_menos)
destroy(this.sle_zoom)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.ole_visor_pdf)
destroy(this.cb_firmas)
destroy(this.dw_firmas)
destroy(this.st_3)
end on

event open;call super::open;int fila

//ole_visor_pdf.object.showscrollbars = false
ole_visor_pdf.object.enableselect = false

datos = message.powerobjectparm
if f_es_vacio(datos.modulo) then datos.modulo='SELLADOR'
	
of_setresize(true)

inv_resize.of_register(sle_pagina_actual, "fixedtobottom")
inv_resize.of_register(sle_total_paginas, "fixedtobottom")

inv_resize.of_register(st_1, "fixedtobottom")
inv_resize.of_register(st_2, "fixedtobottom")

inv_resize.of_register(cb_inicio, "fixedtobottom")
inv_resize.of_register(cb_anterior, "fixedtobottom")
inv_resize.of_register(cb_siguiente, "fixedtobottom")
inv_resize.of_register(cb_ultima, "fixedtobottom")
inv_resize.of_register(cb_rotar, "FixedToRight&Bottom")
inv_resize.of_register(cb_buscar, "FixedToRight&Bottom")
inv_resize.of_register(cb_copiar, "FixedToRight&Bottom")
inv_resize.of_register(cb_seleccionar, "FixedToRight&Bottom")


inv_resize.of_register(cb_vista_previa, "FixedToRight&Bottom")
inv_resize.of_register(cb_salir, "FixedToRight&Bottom")
inv_resize.of_register(cb_imprimir, "FixedToRight&Bottom")
//inv_resize.of_register(vsb_1, "FixedToRight")
//inv_resize.of_register(hsb_1, "FixedToBottom")
inv_resize.of_register(gb_1, "FixedToRight&Bottom")
inv_resize.of_register(gb_2, "FixedToBottom")
inv_resize.of_register(cb_firmas, "FixedToRight&Bottom")
inv_resize.of_register(st_3, "FixedToRight&Bottom")
inv_resize.of_register(dw_firmas, "FixedToRight&Bottom")
//inv_resize.of_register(r_1, "scaletoright&bottom")

inv_resize.of_register(ole_visor_pdf, "scaletoright&bottom" )

fila = datos.fila_seleccionada

this.event csd_visualizar(fila)
if g_activar_revision_firmas = 'S' then
	this.event csd_comprobar_firmas(fila)
end if

ole_visor_pdf.setfocus()
end event

event close;call super::close;ole_visor_pdf.Object.CloseFile()
end event

event pfc_postopen;call super::pfc_postopen;//Redimensionamos las barras
//vsb_1.height = r_1.height
//hsb_1.width = r_1.width

this.event csd_recalcular_barras()
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_sellador_previsualizacion_pdf
integer x = 590
integer y = 1192
integer width = 549
integer taborder = 20
string text = "Recuperar pantalla"
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_sellador_previsualizacion_pdf
integer x = 873
integer y = 1140
integer width = 489
string text = "Guardar pantalla"
end type

type cb_salir from u_cb within w_sellador_previsualizacion_pdf
integer x = 3264
integer y = 1736
integer width = 311
integer height = 72
integer taborder = 11
boolean bringtotop = true
string text = "&Salir"
boolean cancel = true
end type

event clicked;call super::clicked;close(parent)
end event

type cb_siguiente from u_cb within w_sellador_previsualizacion_pdf
integer x = 741
integer y = 1736
integer width = 82
integer height = 72
integer taborder = 10
boolean bringtotop = true
integer weight = 700
string text = ">>"
end type

event clicked;call super::clicked;ole_visor_pdf.object.gotoNextPage
sle_pagina_actual.text = string(ole_visor_pdf.object.currentPage)
//parent.event csd_recalcular_barras()
ole_visor_pdf.setfocus()
end event

type cb_anterior from u_cb within w_sellador_previsualizacion_pdf
integer x = 658
integer y = 1736
integer width = 82
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string text = "<<"
end type

event clicked;call super::clicked;ole_visor_pdf.object.gotoPreviousPage
sle_pagina_actual.text = string(ole_visor_pdf.object.currentPage)
//parent.event csd_recalcular_barras()
ole_visor_pdf.setfocus()
end event

type cb_inicio from u_cb within w_sellador_previsualizacion_pdf
integer x = 576
integer y = 1736
integer width = 82
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer weight = 700
string text = "|<"
end type

event clicked;call super::clicked;ole_visor_pdf.object.gotoFirstPage
sle_pagina_actual.text = string(ole_visor_pdf.object.currentPage)
//parent.event csd_recalcular_barras()
ole_visor_pdf.setfocus()
end event

type cb_ultima from u_cb within w_sellador_previsualizacion_pdf
integer x = 823
integer y = 1736
integer width = 82
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer weight = 700
string text = ">|"
end type

event clicked;call super::clicked;ole_visor_pdf.object.gotoLastPage
sle_pagina_actual.text = string(ole_visor_pdf.object.currentPage)
//parent.event csd_recalcular_barras()
ole_visor_pdf.setfocus()
end event

type cb_imprimir from u_cb within w_sellador_previsualizacion_pdf
integer x = 2345
integer y = 1736
integer width = 283
integer height = 72
integer taborder = 20
boolean bringtotop = true
string text = "&Imprimir"
end type

event clicked;call super::clicked;ole_visor_pdf.object.printWithDialog

//Para que no se quede en blanco el trozo sobreescrito por la ventana de impresion, forzamos el redibujado
ole_visor_pdf.visible = false
ole_visor_pdf.visible = true
end event

type sle_pagina_actual from u_sle within w_sellador_previsualizacion_pdf
integer x = 215
integer y = 1744
integer width = 128
integer height = 64
integer taborder = 11
fontcharset fontcharset = ansi!
boolean border = false
boolean righttoleft = true
end type

event modified;call super::modified;int pagina

pagina = integer(this.text)

ole_visor_pdf.object.currentPage = pagina

//parent.event csd_recalcular_barras()
end event

type st_2 from u_st within w_sellador_previsualizacion_pdf
integer x = 50
integer y = 1744
integer width = 197
long backcolor = 15780518
string text = "P$$HEX1$$e100$$ENDHEX$$gina"
end type

type st_1 from u_st within w_sellador_previsualizacion_pdf
integer x = 352
integer y = 1744
integer width = 96
boolean bringtotop = true
long backcolor = 15780518
string text = "de"
end type

type sle_total_paginas from u_sle within w_sellador_previsualizacion_pdf
integer x = 448
integer y = 1744
integer width = 110
integer height = 64
integer taborder = 21
boolean bringtotop = true
long backcolor = 15780518
boolean border = false
boolean displayonly = true
end type

type cb_rotar from u_cb within w_sellador_previsualizacion_pdf
integer x = 1495
integer y = 1736
integer width = 283
integer height = 72
integer taborder = 20
boolean bringtotop = true
string text = "&Rotar"
end type

event clicked;call super::clicked;int rotacion

rotacion = ole_visor_pdf.object.rotate

rotacion = rotacion + 90

if (rotacion <> 360) then
	ole_visor_pdf.object.rotate = rotacion
else
	ole_visor_pdf.object.rotate = 0
end if

//parent.event csd_recalcular_barras()

ole_visor_pdf.setfocus()
end event

type st_zoom from u_st within w_sellador_previsualizacion_pdf
integer x = 46
integer y = 40
integer width = 146
boolean bringtotop = true
long backcolor = 80269524
string text = "Zoom:"
end type

type ddlb_zoom from u_ddlb within w_sellador_previsualizacion_pdf
integer x = 215
integer y = 36
integer width = 530
integer height = 464
integer taborder = 11
boolean bringtotop = true
boolean sorted = false
integer limit = 4
string item[] = {"Ajustar p$$HEX1$$e100$$ENDHEX$$gina","50%","75%","100%","200%","   "}
end type

event selectionchanged;call super::selectionchanged;int tamano

choose case index
	case 1
		ole_visor_pdf.object.zoom = ole_visor_pdf.object.zoomWidth
		sle_zoom.text = ''
	case 2
		ole_visor_pdf.object.zoom = 50
		sle_zoom.text = ''
	case 3
		ole_visor_pdf.object.zoom = 75
		sle_zoom.text = ''
	case 4
		ole_visor_pdf.object.zoom = 100
		sle_zoom.text = ''
	case 5
		ole_visor_pdf.object.zoom = 200
		sle_zoom.text = ''
end choose

//parent.event csd_recalcular_barras()


ole_visor_pdf.setfocus()
	
end event

type cb_vista_previa from u_cb within w_sellador_previsualizacion_pdf
integer x = 1778
integer y = 1736
integer width = 283
integer height = 72
integer taborder = 40
boolean bringtotop = true
string text = "&Vista Previa"
end type

event clicked;call super::clicked;int fila_nueva
string fichero, ruta, fichero_pdf

openwithparm(w_sellador_previsualizacion_mini,datos)

fila_nueva = message.DoubleParm

if(fila_nueva <> -1) and (fila_nueva <> 0) then
	ole_visor_pdf.object.closefile()

	ole_visor_pdf.object.zoom = ole_visor_pdf.object.zoomWidth

	parent.event csd_visualizar(fila_nueva)
	parent.event csd_comprobar_firmas(fila_nueva)
	sle_zoom.text = ''
	ddlb_zoom.selectitem(1)
	
	parent.event csd_recalcular_barras()
	
end if

end event

type cb_buscar from u_cb within w_sellador_previsualizacion_pdf
integer x = 2062
integer y = 1736
integer width = 283
integer height = 72
integer taborder = 40
boolean bringtotop = true
string text = "&Buscar"
end type

event clicked;call super::clicked;open (w_sellador_busqueda_pdf)
end event

type st_fichero from u_st within w_sellador_previsualizacion_pdf
integer x = 1271
integer y = 40
integer width = 430
boolean bringtotop = true
long backcolor = 80269524
string text = "Nombre del fichero:"
end type

type sle_nombre_fichero from u_sle within w_sellador_previsualizacion_pdf
integer x = 1719
integer y = 40
integer width = 1984
integer height = 64
integer taborder = 21
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 80269524
boolean border = false
end type

type cb_seleccionar from u_cb within w_sellador_previsualizacion_pdf
integer x = 2629
integer y = 1736
integer width = 283
integer height = 72
integer taborder = 50
boolean bringtotop = true
string text = "Selec."
end type

event clicked;call super::clicked;if this.text = 'Selec.' then
	ole_visor_pdf.object.enableselect = true
	this.text = 'Deselec.'
	cb_copiar.visible = true	
else
	ole_visor_pdf.object.enableselect = false
	ole_visor_pdf.object.deleteAllRegions()	
	this.text = 'Selec.'
	cb_copiar.visible = false
end if
end event

type cb_copiar from u_cb within w_sellador_previsualizacion_pdf
boolean visible = false
integer x = 2912
integer y = 1736
integer width = 283
integer height = 72
integer taborder = 10
boolean bringtotop = true
string text = "Copiar"
end type

event clicked;call super::clicked;ole_visor_pdf.object.copySelection()
end event

type cb_zoom_mas from u_cb within w_sellador_previsualizacion_pdf
integer x = 1065
integer y = 32
integer width = 96
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
string text = "+"
end type

event clicked;call super::clicked;long zoom
int posicion

zoom = ole_visor_pdf.object.zoompercent

zoom = zoom + 10

choose case zoom
		case 50
			ddlb_zoom.selectitem(2)
			sle_zoom.text = ''
		case 75
			ddlb_zoom.selectitem(3)
			sle_zoom.text = ''
		case 100
			ddlb_zoom.selectitem(4)		
			sle_zoom.text = ''
		case 200
			ddlb_zoom.selectitem(5)
			sle_zoom.text = ''
		case else
			ddlb_zoom.selectitem(6)
			sle_zoom.text = string(zoom) + '%'
end choose

ole_visor_pdf.object.zoom = zoom

//parent.event csd_recalcular_barras()
end event

type cb_zoom_menos from u_cb within w_sellador_previsualizacion_pdf
integer x = 763
integer y = 32
integer width = 96
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
string text = "-"
end type

event clicked;call super::clicked;long zoom
int posicion

zoom = ole_visor_pdf.object.zoompercent

zoom = zoom - 10

if zoom < 10 then
	zoom = 10
end if

choose case zoom
		case 50
			ddlb_zoom.selectitem(2)
			sle_zoom.text = ''
		case 75
			ddlb_zoom.selectitem(3)
			sle_zoom.text = ''
		case 100
			ddlb_zoom.selectitem(4)		
			sle_zoom.text = ''
		case 200
			ddlb_zoom.selectitem(5)
			sle_zoom.text = ''
		case else
			ddlb_zoom.selectitem(6)
			sle_zoom.text = string(zoom) + '%'
end choose

ole_visor_pdf.object.zoom = zoom

//parent.event csd_recalcular_barras()
end event

type sle_zoom from u_sle within w_sellador_previsualizacion_pdf
integer x = 855
integer y = 32
integer width = 210
integer height = 88
integer taborder = 21
boolean bringtotop = true
boolean righttoleft = true
end type

event modified;call super::modified;int zoom
string s_zoom

s_zoom = sle_zoom.text

if ( RightA(s_zoom, 1) = '%' ) then
	s_zoom = LeftA(s_zoom,LenA(s_zoom) - 1)
end if

zoom = integer(s_zoom)

if (zoom > 1000) then 
	zoom = 1000
end if

if (zoom <> 0) then
	ole_visor_pdf.object.zoom = zoom

	this.text = string(zoom) + '%'

	choose case zoom
		case 50
			ddlb_zoom.selectitem(2)
			this.text = ''
		case 75
			ddlb_zoom.selectitem(3)
			this.text = ''
		case 100
			ddlb_zoom.selectitem(4)		
			this.text = ''
		case 200
			ddlb_zoom.selectitem(5)
			this.text = ''
		case else
			ddlb_zoom.selectitem(6)
	end choose
else
	ole_visor_pdf.object.zoom = ole_visor_pdf.object.zoomWidth
	this.text = ''
	ddlb_zoom.selectitem(1)	
end if

ole_visor_pdf.setfocus()
end event

type gb_1 from groupbox within w_sellador_previsualizacion_pdf
integer x = 1179
integer y = 1688
integer width = 2437
integer height = 148
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12639424
end type

type gb_2 from groupbox within w_sellador_previsualizacion_pdf
integer x = 23
integer y = 1688
integer width = 951
integer height = 148
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
end type

type ole_visor_pdf from olecustomcontrol within w_sellador_previsualizacion_pdf
integer x = 37
integer y = 128
integer width = 3584
integer height = 1536
integer taborder = 51
boolean border = false
long backcolor = 80269524
boolean focusrectangle = false
string binarykey = "w_sellador_previsualizacion_pdf.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type cb_firmas from u_cb within w_sellador_previsualizacion_pdf
integer x = 1211
integer y = 1736
integer width = 283
integer height = 72
integer taborder = 21
boolean bringtotop = true
string text = "Firmas"
end type

event clicked;call super::clicked;if dw_firmas.visible = true then 
	dw_firmas.visible = false
	st_3.visible = false
	this.text = 'Firmas'
else
	dw_firmas.visible = true
	if st_3.text <> '' then
		st_3.visible = true
	end if
	this.text = 'Ocultar'
end if
end event

event constructor;call super::constructor;if g_activar_revision_firmas = 'N' then
	this.visible = false
	gb_1.width = 2162
	gb_1.x = 1454
end if
end event

type dw_firmas from u_dw within w_sellador_previsualizacion_pdf
boolean visible = false
integer x = 1509
integer y = 900
integer width = 2030
integer height = 764
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_sellador_datos_firmas"
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.object.p_firma_valida.Filename = g_directorio_imagenes + "v.gif"
this.object.p_firma_no_valida.Filename = g_directorio_imagenes + "x.gif"
end event

type st_3 from statictext within w_sellador_previsualizacion_pdf
boolean visible = false
integer x = 1513
integer y = 1292
integer width = 1929
integer height = 368
boolean bringtotop = true
integer textsize = -15
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 80269524
alignment alignment = center!
boolean focusrectangle = false
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
03w_sellador_previsualizacion_pdf.bin 
2B00000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000300000000000000000000000000000000000000000000000000000000b7036cc001c9b11e00000003000001000000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe000000000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000004800000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a0000000200000001000000042aeb64d946322e252b856ab0ee4b09b900000000b7036cc001c9b11eb7036cc001c9b11e00000000000000000000000000000001fffffffe00000003fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000b29300000048000800034757f20b000000200065005f00740078006e00650078007400005107000800034757f20affffffe00065005f00740078006e006500790074000027b0000000000000000000050016ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000b29300000048000800034757f20b000000200065005f00740078006e00650078007400005107000800034757f20affffffe00065005f00740078006e006500790074000027b0000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000200000048000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
13w_sellador_previsualizacion_pdf.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
