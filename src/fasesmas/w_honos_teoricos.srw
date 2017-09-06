HA$PBExportHeader$w_honos_teoricos.srw
forward
global type w_honos_teoricos from w_response
end type
type cb_2 from commandbutton within w_honos_teoricos
end type
type cb_1 from commandbutton within w_honos_teoricos
end type
type dw_1 from u_dw within w_honos_teoricos
end type
end forward

global type w_honos_teoricos from w_response
integer width = 1614
integer height = 840
string title = "Honorarios te$$HEX1$$f300$$ENDHEX$$ricos"
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_honos_teoricos w_honos_teoricos

type variables
w_fases_detalle  i_w
end variables

on w_honos_teoricos.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_honos_teoricos.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;i_w = g_detalle_fases

double hon_teor = 0
st_cip_datos st_cip_datos

f_centrar_ventana(this)

dw_1.insertrow(0)
// cargo la estructura
//st_cip_datos.id_fase = dw_1.getitemstring(1, 'id_fase')
st_cip_datos.tipo_act = i_w.dw_1.getitemstring(1, 'fase')
st_cip_datos.tipo_obra = i_w.dw_1.getitemstring(1, 'tipo_trabajo')
st_cip_datos.superficie = i_w.idw_fases_estadistica.getitemnumber(1, 'sup_total')
st_cip_datos.pem = i_w.idw_fases_estadistica.getitemnumber(1, 'pem')
st_cip_datos.admon = i_w.dw_fases_datos_exp.getitemstring(1, 'administracion')
st_cip_datos.volumen = i_w.idw_fases_estadistica.GetItemNumber(1,'volumen')
st_cip_datos.altura = i_w.idw_fases_estadistica.GetItemNumber(1,'altura')
st_cip_datos.colindantes = i_w.idw_fases_estadistica.GetItemString(1,'colindantes')
st_cip_datos.tipo_gestion = i_w.dw_1.GetItemString(1,'tipo_gestion')
//// el 100%
st_cip_datos.porcentaje = 100 
//// calculo
f_calcular_hon_teor(st_cip_datos)
hon_teor = st_cip_datos.hon_teor
if isnull(hon_teor) then hon_teor = 0

dw_1.setitem(1, 'honos_teor', hon_teor)

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_honos_teoricos
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_honos_teoricos
end type

type cb_2 from commandbutton within w_honos_teoricos
integer x = 1033
integer y = 572
integer width = 398
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_honos_teoricos
integer x = 82
integer y = 572
integer width = 663
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar:devolver valor"
boolean default = true
end type

event clicked;double honos_teor

honos_teor = dw_1.getitemnumber(1, 'honos_teor')

i_w.dw_1.setitem(1, 'honorarios', honos_teor)

close(parent)
end event

type dw_1 from u_dw within w_honos_teoricos
integer x = 37
integer y = 32
integer width = 1522
integer height = 504
integer taborder = 10
string dataobject = "d_honos_teor"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

