HA$PBExportHeader$w_modificar_fechas_carta.srw
forward
global type w_modificar_fechas_carta from w_response
end type
type dw_fase from u_dw within w_modificar_fechas_carta
end type
type cb_grabar from commandbutton within w_modificar_fechas_carta
end type
type cb_cancelar from commandbutton within w_modificar_fechas_carta
end type
end forward

global type w_modificar_fechas_carta from w_response
integer width = 2679
integer height = 1064
string title = "Para modificar fechas"
dw_fase dw_fase
cb_grabar cb_grabar
cb_cancelar cb_cancelar
end type
global w_modificar_fechas_carta w_modificar_fechas_carta

type variables
string is_id_fase



end variables

event open;call super::open;// Obtenemos el id_pasado

if f_es_vacio(message.stringparm) then 
	close(this)
	return
end if
is_id_fase = message.stringparm

if dw_fase.retrieve(is_id_fase) = 0 then 
	close(this)
	return
end if
f_centrar_ventana(this)

		
dw_fase.of_SetDropDownCalendar(True)
dw_fase.iuo_calendar.of_register(dw_fase.iuo_calendar.DDLB)
dw_fase.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_fase.iuo_calendar.of_SetInitialValue(True)
end event

on w_modificar_fechas_carta.create
int iCurrent
call super::create
this.dw_fase=create dw_fase
this.cb_grabar=create cb_grabar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_fase
this.Control[iCurrent+2]=this.cb_grabar
this.Control[iCurrent+3]=this.cb_cancelar
end on

on w_modificar_fechas_carta.destroy
call super::destroy
destroy(this.dw_fase)
destroy(this.cb_grabar)
destroy(this.cb_cancelar)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_modificar_fechas_carta
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_modificar_fechas_carta
end type

type dw_fase from u_dw within w_modificar_fechas_carta
integer x = 14
integer y = 12
integer width = 2537
integer height = 732
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_fases_reclamaciones_za_modif"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_grabar from commandbutton within w_modificar_fechas_carta
integer x = 718
integer y = 812
integer width = 567
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Grabar"
boolean default = true
end type

event clicked;dw_fase.update()
end event

type cb_cancelar from commandbutton within w_modificar_fechas_carta
integer x = 1467
integer y = 812
integer width = 567
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
boolean cancel = true
end type

event clicked;close(parent)
end event

