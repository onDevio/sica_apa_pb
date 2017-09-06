HA$PBExportHeader$w_control_eventos.srw
forward
global type w_control_eventos from w_mant_simple
end type
end forward

global type w_control_eventos from w_mant_simple
integer width = 3538
string title = "Control de Eventos"
end type
global w_control_eventos w_control_eventos

on w_control_eventos.create
call super::create
end on

on w_control_eventos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from w_mant_simple`dw_1 within w_control_eventos
integer x = 37
integer y = 32
integer width = 3410
integer height = 1124
string dataobject = "d_control_eventos"
end type

event dw_1::pfc_addrow;call super::pfc_addrow;this.SetItem(this.GetRow(),'id_control',f_siguiente_numero('CONTROL_EVENTOS',10))
RETURN 1
end event

event dw_1::pfc_insertrow;call super::pfc_insertrow;this.SetItem(this.GetRow(),'id_control',f_siguiente_numero('CONTROL_EVENTOS',10))
RETURN 1
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_control_eventos
integer x = 37
end type

type cb_borrar from w_mant_simple`cb_borrar within w_control_eventos
integer x = 329
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_control_eventos
end type

