HA$PBExportHeader$w_mant_sellos_posiciones.srw
forward
global type w_mant_sellos_posiciones from w_mant_simple
end type
end forward

global type w_mant_sellos_posiciones from w_mant_simple
integer x = 214
integer y = 221
integer width = 3163
end type
global w_mant_sellos_posiciones w_mant_sellos_posiciones

on w_mant_sellos_posiciones.create
call super::create
end on

on w_mant_sellos_posiciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_mant_sellos_posiciones
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_mant_sellos_posiciones
end type

type dw_1 from w_mant_simple`dw_1 within w_mant_sellos_posiciones
integer width = 3086
string dataobject = "d_mant_sello_posiciones"
end type

event dw_1::itemchanged;call super::itemchanged;long i
string sello,sello_bucle


choose case dwo.name
	case 'defecto'
		if data='S' then
			sello=this.GetItemString(row,'sello')
			for i=1 to dw_1.rowcount()
				sello_bucle=dw_1.GetItemString(i,'sello')
				if sello=sello_bucle and dw_1.GetItemString(i,'defecto')='S' and i<>row then 
					return 1
				end if
			next
		end if
		
end choose
end event

event dw_1::itemerror;call super::itemerror;return 1
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_mant_sellos_posiciones
end type

type cb_borrar from w_mant_simple`cb_borrar within w_mant_sellos_posiciones
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_mant_sellos_posiciones
end type

