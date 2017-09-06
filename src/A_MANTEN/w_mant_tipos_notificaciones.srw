HA$PBExportHeader$w_mant_tipos_notificaciones.srw
forward
global type w_mant_tipos_notificaciones from w_mant_simple
end type
end forward

global type w_mant_tipos_notificaciones from w_mant_simple
end type
global w_mant_tipos_notificaciones w_mant_tipos_notificaciones

on w_mant_tipos_notificaciones.create
call super::create
end on

on w_mant_tipos_notificaciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_mant_tipos_notificaciones
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_mant_tipos_notificaciones
end type

type dw_1 from w_mant_simple`dw_1 within w_mant_tipos_notificaciones
integer y = 36
integer width = 2985
integer height = 1156
string dataobject = "d_mant_tipos_notificaciones"
end type

type cb_anyadir from w_mant_simple`cb_anyadir within w_mant_tipos_notificaciones
end type

type cb_borrar from w_mant_simple`cb_borrar within w_mant_tipos_notificaciones
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_mant_tipos_notificaciones
end type

