HA$PBExportHeader$w_mant_sello_textos.srw
forward
global type w_mant_sello_textos from w_mant_simple
end type
end forward

global type w_mant_sello_textos from w_mant_simple
string title = "Mantenimiento sello texto"
end type
global w_mant_sello_textos w_mant_sello_textos

on w_mant_sello_textos.create
call super::create
end on

on w_mant_sello_textos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_mant_sello_textos
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_mant_sello_textos
end type

type dw_1 from w_mant_simple`dw_1 within w_mant_sello_textos
string dataobject = "d_mant_sello_texto"
end type

event dw_1::pfc_addrow;call super::pfc_addrow;this.setitem(GetRow(),'id_texto',f_siguiente_numero('ID_SELLO_TEXTO',10))

return ancestorReturnValue
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_mant_sello_textos
end type

type cb_borrar from w_mant_simple`cb_borrar within w_mant_sello_textos
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_mant_sello_textos
end type

