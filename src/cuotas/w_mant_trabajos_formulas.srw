HA$PBExportHeader$w_mant_trabajos_formulas.srw
$PBExportComments$objetos b$$HEX1$$e100$$ENDHEX$$sicos
forward
global type w_mant_trabajos_formulas from w_mant_simple
end type
end forward

global type w_mant_trabajos_formulas from w_mant_simple
integer width = 4366
string title = "Mantenimiento de trabajos f$$HEX1$$f300$$ENDHEX$$rmulas"
end type
global w_mant_trabajos_formulas w_mant_trabajos_formulas

on w_mant_trabajos_formulas.create
call super::create
end on

on w_mant_trabajos_formulas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from w_mant_simple`dw_1 within w_mant_trabajos_formulas
integer width = 4283
string dataobject = "d_mant_trabajos_formulas"
end type

event dw_1::pfc_insertrow;call super::pfc_insertrow;this.setitem(ancestorreturnvalue,'id_trabajos_formulas',f_siguiente_numero('TRABAJOS_FORMULAS',10))
this.setitem(ancestorreturnvalue,'colegio',f_colegio())
return ancestorreturnvalue
end event

event dw_1::pfc_addrow;call super::pfc_addrow;this.setitem(ancestorreturnvalue,'id_trabajos_formulas',f_siguiente_numero('TRABAJOS_FORMULAS',10))
this.setitem(ancestorreturnvalue,'colegio',f_colegio())
return ancestorreturnvalue
end event

event dw_1::constructor;call super::constructor;// El c$$HEX1$$f300$$ENDHEX$$digo del colegio es necesario en VISARED
datawindowchild dwc

this.getchild('tipo_trabajo', dwc)
dwc.SetTransObject(SQLCA)
dwc.retrieve(f_colegio())

this.getchild('trabajo', dwc)
dwc.SetTransObject(SQLCA)
dwc.retrieve(f_colegio())

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_mant_trabajos_formulas
end type

