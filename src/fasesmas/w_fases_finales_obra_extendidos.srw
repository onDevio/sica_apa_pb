HA$PBExportHeader$w_fases_finales_obra_extendidos.srw
$PBExportComments$Permite sacar una serie de datos extra de las ordenes de obras
forward
global type w_fases_finales_obra_extendidos from w_response
end type
type dw_fases_finales_obra_extendidos from u_dw within w_fases_finales_obra_extendidos
end type
type cb_salir from commandbutton within w_fases_finales_obra_extendidos
end type
type cb_grabar from commandbutton within w_fases_finales_obra_extendidos
end type
end forward

global type w_fases_finales_obra_extendidos from w_response
integer width = 2505
integer height = 836
string title = "M$$HEX1$$e100$$ENDHEX$$s datos de Finales de Obra"
dw_fases_finales_obra_extendidos dw_fases_finales_obra_extendidos
cb_salir cb_salir
cb_grabar cb_grabar
end type
global w_fases_finales_obra_extendidos w_fases_finales_obra_extendidos

type variables
DataWindowChild i_dwc_arquitectos,i_dwc_dir_obra,i_dwc_constructor,i_dwc_propietario

//string i_registro
end variables

event open;f_centrar_ventana(this)

string id_final_obra
// Recogemos el parametro de entrada
id_final_obra = message.stringparm

// Colocamos el calendario en el dw
dw_fases_finales_obra_extendidos.of_SetDropDownCalendar(True)
dw_fases_finales_obra_extendidos.iuo_calendar.of_register(dw_fases_finales_obra_extendidos.iuo_calendar.DDLB)
dw_fases_finales_obra_extendidos.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_fases_finales_obra_extendidos.iuo_calendar.of_SetInitialValue(True)

// REcuperamos la linea para este final de obra
dw_fases_finales_obra_extendidos.retrieve(id_final_obra)
if dw_fases_finales_obra_extendidos.rowCount() = 0 then
	close(this)
	return
end if


end event

on w_fases_finales_obra_extendidos.create
int iCurrent
call super::create
this.dw_fases_finales_obra_extendidos=create dw_fases_finales_obra_extendidos
this.cb_salir=create cb_salir
this.cb_grabar=create cb_grabar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_fases_finales_obra_extendidos
this.Control[iCurrent+2]=this.cb_salir
this.Control[iCurrent+3]=this.cb_grabar
end on

on w_fases_finales_obra_extendidos.destroy
call super::destroy
destroy(this.dw_fases_finales_obra_extendidos)
destroy(this.cb_salir)
destroy(this.cb_grabar)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_finales_obra_extendidos
integer x = 1723
integer y = 312
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_finales_obra_extendidos
integer x = 1723
integer y = 184
end type

type dw_fases_finales_obra_extendidos from u_dw within w_fases_finales_obra_extendidos
integer x = 64
integer y = 28
integer width = 2423
integer height = 564
integer taborder = 10
string dataobject = "d_fases_finales_obra_extendidos"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event editchanged;call super::editchanged;cb_grabar.enabled=true

end event

type cb_salir from commandbutton within w_fases_finales_obra_extendidos
integer x = 1449
integer y = 612
integer width = 361
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;if dw_fases_finales_obra_extendidos.trigger event pfc_updatespending() >0 then
	// Faltan cosas por grabar
	if MessageBox(g_titulo, "Existen datos sin grabar"+cr+" $$HEX1$$bf00$$ENDHEX$$desea grabar antes de salir?", question!, yesno!, 2 ) = 1 then
		dw_fases_finales_obra_extendidos.update()
	end if
end if

close(parent)
end event

type cb_grabar from commandbutton within w_fases_finales_obra_extendidos
integer x = 1056
integer y = 612
integer width = 361
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Grabar"
end type

event clicked;dw_fases_finales_obra_extendidos.update()


end event

