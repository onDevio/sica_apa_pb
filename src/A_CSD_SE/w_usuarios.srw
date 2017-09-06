HA$PBExportHeader$w_usuarios.srw
forward
global type w_usuarios from w_mant_simple
end type
end forward

global type w_usuarios from w_mant_simple
integer width = 2597
integer height = 1444
string menuname = ""
end type
global w_usuarios w_usuarios

on w_usuarios.create
call super::create
end on

on w_usuarios.destroy
call super::destroy
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'n_colegiado', fila)
			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type dw_1 from w_mant_simple`dw_1 within w_usuarios
integer x = 37
integer y = 32
integer width = 2491
integer taborder = 40
string dataobject = "d_usuario"
end type

event dw_1::pfc_addrow;call super::pfc_addrow;dw_1.setitem(THIS.GETROW(),'cod_usuario',f_siguiente_numero('USUARIO',10)) 
return 1
end event

event dw_1::pfc_insertrow;call super::pfc_insertrow;dw_1.setitem(THIS.GETROW(),'cod_usuario',f_siguiente_numero('USUARIO',10)) 
return 1
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_usuarios
integer x = 37
integer taborder = 20
end type

type cb_borrar from w_mant_simple`cb_borrar within w_usuarios
integer x = 329
integer taborder = 30
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_usuarios
integer taborder = 10
end type

