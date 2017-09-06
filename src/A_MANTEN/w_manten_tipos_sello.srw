HA$PBExportHeader$w_manten_tipos_sello.srw
forward
global type w_manten_tipos_sello from w_mant_simple
end type
end forward

global type w_manten_tipos_sello from w_mant_simple
end type
global w_manten_tipos_sello w_manten_tipos_sello

on w_manten_tipos_sello.create
call super::create
end on

on w_manten_tipos_sello.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_manten_tipos_sello
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_manten_tipos_sello
end type

type dw_1 from w_mant_simple`dw_1 within w_manten_tipos_sello
string dataobject = "d_manten_tipos_sello"
end type

type cb_anyadir from w_mant_simple`cb_anyadir within w_manten_tipos_sello
end type

type cb_borrar from w_mant_simple`cb_borrar within w_manten_tipos_sello
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_manten_tipos_sello
end type

