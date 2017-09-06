HA$PBExportHeader$w_mant_formulas.srw
$PBExportComments$objetos b$$HEX1$$e100$$ENDHEX$$sicos
forward
global type w_mant_formulas from w_mant_simple
end type
end forward

global type w_mant_formulas from w_mant_simple
integer x = 214
integer y = 221
integer width = 3685
integer height = 1508
string title = "Mantenimiento de f$$HEX1$$f300$$ENDHEX$$rmulas"
windowstate windowstate = maximized!
end type
global w_mant_formulas w_mant_formulas

on w_mant_formulas.create
call super::create
end on

on w_mant_formulas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from w_mant_simple`dw_1 within w_mant_formulas
integer width = 3584
string dataobject = "d_mant_formulas"
boolean ib_rmbmenu = false
end type

event dw_1::pfc_addrow;call super::pfc_addrow;this.setitem(ancestorreturnvalue,'id_formula',f_siguiente_numero('FORMULAS',10))
this.setitem(ancestorreturnvalue,'colegio',f_colegio())
return ancestorreturnvalue
end event

event dw_1::pfc_insertrow;call super::pfc_insertrow;this.setitem(ancestorreturnvalue,'id_formula',f_siguiente_numero('FORMULAS',10))
this.setitem(ancestorreturnvalue,'colegio',f_colegio())
return ancestorreturnvalue
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_mant_formulas
end type

type cb_borrar from w_mant_simple`cb_borrar within w_mant_formulas
end type

