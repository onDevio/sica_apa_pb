HA$PBExportHeader$w_csi_tipo_persona.srw
forward
global type w_csi_tipo_persona from w_mant_simple
end type
end forward

global type w_csi_tipo_persona from w_mant_simple
integer width = 1911
string title = "Mantenimiento de Personas Contables"
end type
global w_csi_tipo_persona w_csi_tipo_persona

on w_csi_tipo_persona.create
call super::create
end on

on w_csi_tipo_persona.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from w_mant_simple`dw_1 within w_csi_tipo_persona
integer width = 1792
string dataobject = "d_mant_csi_tipo_persona"
end type

type cb_anyadir from w_mant_simple`cb_anyadir within w_csi_tipo_persona
end type

type cb_borrar from w_mant_simple`cb_borrar within w_csi_tipo_persona
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_csi_tipo_persona
end type

