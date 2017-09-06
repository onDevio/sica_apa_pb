HA$PBExportHeader$w_desc_gui_coefs.srw
forward
global type w_desc_gui_coefs from w_mant_simple
end type
end forward

global type w_desc_gui_coefs from w_mant_simple
integer x = 214
integer y = 221
integer width = 2030
integer height = 1552
string title = "Mantenimiento de Coef. A y P"
end type
global w_desc_gui_coefs w_desc_gui_coefs

on w_desc_gui_coefs.create
call super::create
end on

on w_desc_gui_coefs.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from w_mant_simple`dw_1 within w_desc_gui_coefs
integer x = 37
integer y = 32
integer width = 1897
string dataobject = "d_desc_gui_coefs"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type cb_anyadir from w_mant_simple`cb_anyadir within w_desc_gui_coefs
integer x = 37
boolean enabled = false
end type

type cb_borrar from w_mant_simple`cb_borrar within w_desc_gui_coefs
integer x = 329
boolean enabled = false
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_desc_gui_coefs
integer x = 1358
end type

