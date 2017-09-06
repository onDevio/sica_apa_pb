HA$PBExportHeader$w_mant_series_registros.srw
forward
global type w_mant_series_registros from w_registros_tipos_comunicados
end type
end forward

global type w_mant_series_registros from w_registros_tipos_comunicados
integer x = 214
integer y = 221
integer width = 4037
integer height = 2656
string title = "Series de Registro E/S"
long backcolor = 67108864
end type
global w_mant_series_registros w_mant_series_registros

on w_mant_series_registros.create
call super::create
end on

on w_mant_series_registros.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;dw_1.SetTransObject(SQLCA)
dw_1.retrieve( )

end event

type cb_recuperar_pantalla from w_registros_tipos_comunicados`cb_recuperar_pantalla within w_mant_series_registros
end type

type cb_guardar_pantalla from w_registros_tipos_comunicados`cb_guardar_pantalla within w_mant_series_registros
end type

type dw_1 from w_registros_tipos_comunicados`dw_1 within w_mant_series_registros
integer x = 64
integer y = 36
integer width = 3904
integer height = 2428
string dataobject = "d_mant_serie_registro"
borderstyle borderstyle = StyleLowered!
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type cb_anyadir from w_registros_tipos_comunicados`cb_anyadir within w_mant_series_registros
boolean visible = false
end type

type cb_borrar from w_registros_tipos_comunicados`cb_borrar within w_mant_series_registros
boolean visible = false
end type

type cb_ayuda from w_registros_tipos_comunicados`cb_ayuda within w_mant_series_registros
boolean visible = false
end type

