HA$PBExportHeader$w_mant_almacen_almacenes.srw
forward
global type w_mant_almacen_almacenes from w_mant_simple
end type
end forward

global type w_mant_almacen_almacenes from w_mant_simple
end type
global w_mant_almacen_almacenes w_mant_almacen_almacenes

event pfc_preupdate;call super::pfc_preupdate;string mensaje,cadenas[]
int fila, res, retorno=1

mensaje += f_valida(dw_1,'cod_almacen','NOVACIO',g_idioma.of_getmsg('general.campo_codigo','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo.')+cr)
mensaje += f_valida(dw_1,'descripcion','NOVACIO',g_idioma.of_getmsg('msg_entsal.especif_descripcion','Debe especificar un valor en el campo Descripci$$HEX1$$f300$$ENDHEX$$n.')+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
		res = f_busca_duplicados_colum_dw (dw_1, 'col_almacen', fila)
		cadenas[1] = string(fila)
		cadenas[2]= string(res)
		if res > 0 then mensaje += g_idioma.of_getmsg('general.repetir_filas',cadenas[],'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res)) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

on w_mant_almacen_almacenes.create
call super::create
end on

on w_mant_almacen_almacenes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_mant_almacen_almacenes
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_mant_almacen_almacenes
end type

type dw_1 from w_mant_simple`dw_1 within w_mant_almacen_almacenes
string dataobject = "d_almacen_almacenes"
end type

type cb_anyadir from w_mant_simple`cb_anyadir within w_mant_almacen_almacenes
end type

type cb_borrar from w_mant_simple`cb_borrar within w_mant_almacen_almacenes
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_mant_almacen_almacenes
end type

