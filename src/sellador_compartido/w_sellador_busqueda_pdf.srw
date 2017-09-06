HA$PBExportHeader$w_sellador_busqueda_pdf.srw
forward
global type w_sellador_busqueda_pdf from w_response
end type
type sle_buscar from u_sle within w_sellador_busqueda_pdf
end type
type st_zoom from u_st within w_sellador_busqueda_pdf
end type
type cb_buscar from u_cb within w_sellador_busqueda_pdf
end type
type cb_cancelar from u_cb within w_sellador_busqueda_pdf
end type
end forward

global type w_sellador_busqueda_pdf from w_response
integer width = 1216
integer height = 428
string title = "Buscar"
sle_buscar sle_buscar
st_zoom st_zoom
cb_buscar cb_buscar
cb_cancelar cb_cancelar
end type
global w_sellador_busqueda_pdf w_sellador_busqueda_pdf

type variables
double x0_ini, x1_ini
double y0_ini, y1_ini

end variables

on w_sellador_busqueda_pdf.create
int iCurrent
call super::create
this.sle_buscar=create sle_buscar
this.st_zoom=create st_zoom
this.cb_buscar=create cb_buscar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_buscar
this.Control[iCurrent+2]=this.st_zoom
this.Control[iCurrent+3]=this.cb_buscar
this.Control[iCurrent+4]=this.cb_cancelar
end on

on w_sellador_busqueda_pdf.destroy
call super::destroy
destroy(this.sle_buscar)
destroy(this.st_zoom)
destroy(this.cb_buscar)
destroy(this.cb_cancelar)
end on

event open;call super::open;f_centrar_ventana(this)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_sellador_busqueda_pdf
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_sellador_busqueda_pdf
end type

type sle_buscar from u_sle within w_sellador_busqueda_pdf
integer x = 503
integer y = 52
integer width = 649
integer height = 80
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
end type

event modified;call super::modified;w_sellador_previsualizacion_pdf.ole_visor_pdf.object.deleteAllRegions()
x0_ini = 0
x1_ini = 0
y0_ini = 0
y1_ini = 0
end event

event getfocus;call super::getfocus;cb_buscar.text = 'Buscar'
end event

type st_zoom from u_st within w_sellador_busqueda_pdf
integer x = 46
integer y = 64
integer width = 402
boolean bringtotop = true
long backcolor = 80269524
string text = "Texto a buscar:"
end type

type cb_buscar from u_cb within w_sellador_busqueda_pdf
integer x = 279
integer y = 184
integer width = 315
integer height = 112
integer taborder = 50
boolean bringtotop = true
string text = "Buscar"
boolean default = true
end type

event clicked;call super::clicked;double x0,x1, y0,y1

w_sellador_previsualizacion_pdf.ole_visor_pdf.object.find(sle_buscar.text)

x0 = w_sellador_previsualizacion_pdf.ole_visor_pdf.object.getCurrentSelectionX0
x1 = w_sellador_previsualizacion_pdf.ole_visor_pdf.object.getCurrentSelectionX1
y0 = w_sellador_previsualizacion_pdf.ole_visor_pdf.object.getCurrentSelectiony0
y1 = w_sellador_previsualizacion_pdf.ole_visor_pdf.object.getCurrentSelectiony1

if(x0 = 0) and (x1 = 0) and (y0 = 0) and (y1 = 0) then
	messagebox('Texto no encontrado','No se encontr$$HEX2$$f3002000$$ENDHEX$$"' + sle_buscar.text + '" en el texto')
else
	w_sellador_previsualizacion_pdf.sle_pagina_actual.text = string(w_sellador_previsualizacion_pdf.ole_visor_pdf.object.currentPage)
	this.text = 'Siguiente'
end if

if (x0_ini = 0) and (x1_ini = 0) and (y0_ini = 0) and (y1_ini = 0) then
	x0_ini = x0
	x1_ini = x1
	y0_ini = y0
	y1_ini = y1
else
	if (x0_ini = x0) and (x1_ini = x1) and (y0_ini = y0) and (y1_ini = y1) then
		messagebox('Buscar','No se encuentran m$$HEX1$$e100$$ENDHEX$$s ocurrencias')		
		this.text = 'Buscar'
	end if
end if



end event

type cb_cancelar from u_cb within w_sellador_busqueda_pdf
integer x = 622
integer y = 184
integer width = 315
integer height = 112
integer taborder = 60
boolean bringtotop = true
string text = "Cancelar"
boolean cancel = true
end type

event clicked;call super::clicked;w_sellador_previsualizacion_pdf.ole_visor_pdf.object.deleteAllRegions()
w_sellador_previsualizacion_pdf.ole_visor_pdf.visible = false
w_sellador_previsualizacion_pdf.ole_visor_pdf.visible = true

close(parent)
end event

