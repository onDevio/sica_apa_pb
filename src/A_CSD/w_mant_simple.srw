HA$PBExportHeader$w_mant_simple.srw
$PBExportComments$MADRE DE LOS MANTENIMIENTOS TABULARES SIN BUSQUEDA
forward
global type w_mant_simple from w_mant
end type
end forward

global type w_mant_simple from w_mant
integer width = 3072
string menuname = "m_manteni"
end type
global w_mant_simple w_mant_simple

event pfc_postopen;call super::pfc_postopen;dw_1.event pfc_retrieve()
ii_ayuda=50


end event

on w_mant_simple.create
call super::create
if this.MenuName = "m_manteni" then this.MenuID = create m_manteni
end on

on w_mant_simple.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_print;call super::pfc_print;return dw_1.Print()
end event

type cb_recuperar_pantalla from w_mant`cb_recuperar_pantalla within w_mant_simple
end type

type cb_guardar_pantalla from w_mant`cb_guardar_pantalla within w_mant_simple
end type

type dw_1 from w_mant`dw_1 within w_mant_simple
integer x = 18
integer width = 2866
integer taborder = 30
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;return this.Retrieve()
end event

type cb_anyadir from w_mant`cb_anyadir within w_mant_simple
integer x = 27
integer taborder = 10
end type

type cb_borrar from w_mant`cb_borrar within w_mant_simple
integer taborder = 20
end type

type cb_ayuda from w_mant`cb_ayuda within w_mant_simple
end type

