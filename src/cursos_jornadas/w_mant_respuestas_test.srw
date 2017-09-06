HA$PBExportHeader$w_mant_respuestas_test.srw
forward
global type w_mant_respuestas_test from w_mant_simple
end type
end forward

global type w_mant_respuestas_test from w_mant_simple
string title = "Mantenimiento de Respuestas de Test"
end type
global w_mant_respuestas_test w_mant_respuestas_test

on w_mant_respuestas_test.create
call super::create
end on

on w_mant_respuestas_test.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from w_mant_simple`dw_1 within w_mant_respuestas_test
string dataobject = "d_mant_respuesta_test"
end type

event dw_1::pfc_addrow;call super::pfc_addrow;this.SetItem(this.GetRow(),'id_respuesta_test',f_siguiente_numero('FORMACION_MANT_RES',10))
RETURN 1
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_mant_respuestas_test
end type

type cb_borrar from w_mant_simple`cb_borrar within w_mant_respuestas_test
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_mant_respuestas_test
end type

