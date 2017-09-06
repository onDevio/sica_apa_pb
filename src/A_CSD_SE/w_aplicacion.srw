HA$PBExportHeader$w_aplicacion.srw
forward
global type w_aplicacion from w_mant_simple
end type
end forward

global type w_aplicacion from w_mant_simple
integer x = 214
integer y = 221
integer width = 2185
end type
global w_aplicacion w_aplicacion

on w_aplicacion.create
call super::create
end on

on w_aplicacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event type integer pfc_preupdate();call super::pfc_preupdate;if f_puedo_escribir(g_usuario,'0000000021')=-1 then return -1
return 1

end event

type dw_1 from w_mant_simple`dw_1 within w_aplicacion
integer x = 37
integer y = 32
integer width = 2053
string dataobject = "d_aplicacion"
end type

event dw_1::pfc_addrow;call super::pfc_addrow;dw_1.setitem(THIS.GETROW(),'cod_aplicacion',f_siguiente_numero('APLICACION',10)) 
return 1
end event

event dw_1::pfc_insertrow;call super::pfc_insertrow;dw_1.setitem(THIS.GETROW(),'cod_aplicacion',f_siguiente_numero('APLICACION',10)) 
return 1
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_aplicacion
integer x = 37
end type

type cb_borrar from w_mant_simple`cb_borrar within w_aplicacion
integer x = 329
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_aplicacion
end type

