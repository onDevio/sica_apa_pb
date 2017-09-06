HA$PBExportHeader$w_mant_tarifas_coeficientes.srw
forward
global type w_mant_tarifas_coeficientes from w_mant_simple
end type
type st_1 from statictext within w_mant_tarifas_coeficientes
end type
end forward

global type w_mant_tarifas_coeficientes from w_mant_simple
integer x = 214
integer y = 221
integer width = 4169
integer height = 1524
string title = "Mantenimiento de Coeficientes"
st_1 st_1
end type
global w_mant_tarifas_coeficientes w_mant_tarifas_coeficientes

on w_mant_tarifas_coeficientes.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_mant_tarifas_coeficientes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
end on

event open;call super::open;dw_1.SetTransObject(SQLCA)

inv_resize.of_register (st_1, "FixedtoBottom")
end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_mant_tarifas_coeficientes
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_mant_tarifas_coeficientes
end type

type dw_1 from w_mant_simple`dw_1 within w_mant_tarifas_coeficientes
integer width = 3922
integer height = 788
string dataobject = "d_mant_tarifas_coeficientes"
end type

event dw_1::pfc_addrow;call super::pfc_addrow;this.SetItem(ancestorreturnvalue,'id', f_siguiente_numero('id_tarifas_coef', 10))
this.SetItem(ancestorreturnvalue,'colegio',g_colegio)

return ancestorreturnvalue
end event

event dw_1::pfc_insertrow;call super::pfc_insertrow;this.SetItem(ancestorreturnvalue,'id', f_siguiente_numero('id_tarifas_coef', 10))
this.SetItem(ancestorreturnvalue,'colegio',g_colegio)

return ancestorreturnvalue
end event

event dw_1::itemchanged;call super::itemchanged;if (dwo.name ='tipo_coef' and data = 'D') then
	MessageBox(g_titulo, "El sistema unicamente aplicar$$HEX2$$e1002000$$ENDHEX$$descuentos para las variable 'obra_oficial' y/o 'visared' ")
end if
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_mant_tarifas_coeficientes
end type

type cb_borrar from w_mant_simple`cb_borrar within w_mant_tarifas_coeficientes
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_mant_tarifas_coeficientes
boolean visible = false
end type

type st_1 from statictext within w_mant_tarifas_coeficientes
integer x = 727
integer y = 1228
integer width = 3209
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "Las variable en las f$$HEX1$$f300$$ENDHEX$$rmulas deber$$HEX1$$e100$$ENDHEX$$n ir entre corchetes."
boolean border = true
boolean focusrectangle = false
end type

