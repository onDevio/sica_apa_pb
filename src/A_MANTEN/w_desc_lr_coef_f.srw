HA$PBExportHeader$w_desc_lr_coef_f.srw
forward
global type w_desc_lr_coef_f from w_mant_simple
end type
end forward

global type w_desc_lr_coef_f from w_mant_simple
integer x = 214
integer y = 221
integer width = 2030
integer height = 1552
string title = "Mantenimiento de Coef. F"
end type
global w_desc_lr_coef_f w_desc_lr_coef_f

on w_desc_lr_coef_f.create
call super::create
end on

on w_desc_lr_coef_f.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from w_mant_simple`dw_1 within w_desc_lr_coef_f
integer x = 37
integer y = 32
integer width = 1897
string dataobject = "d_desc_lr_coef_f"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type cb_anyadir from w_mant_simple`cb_anyadir within w_desc_lr_coef_f
integer x = 37
boolean enabled = false
end type

type cb_borrar from w_mant_simple`cb_borrar within w_desc_lr_coef_f
integer x = 329
boolean enabled = false
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_desc_lr_coef_f
integer x = 1358
end type

