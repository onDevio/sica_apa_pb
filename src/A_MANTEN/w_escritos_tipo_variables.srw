HA$PBExportHeader$w_escritos_tipo_variables.srw
forward
global type w_escritos_tipo_variables from w_mant_simple
end type
end forward

global type w_escritos_tipo_variables from w_mant_simple
integer width = 2825
string title = "Mantenimiento de Variables de Tipos de Escritos"
end type
global w_escritos_tipo_variables w_escritos_tipo_variables

on w_escritos_tipo_variables.create
call super::create
end on

on w_escritos_tipo_variables.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'etiquetas','NOVACIO',g_idioma.of_getmsg('general.campo_variable','Debe especificar un valor en el campo Variable.')+cr)
mensaje += f_valida(dw_1,'descripcion','NOVACIO',g_idioma.of_getmsg('general.msg_entsal.especif_descripcion','Debe especificar un valor en el campo Descripci$$HEX1$$f300$$ENDHEX$$n.')+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'etiquetas', fila)
			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_escritos_tipo_variables
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_escritos_tipo_variables
end type

type dw_1 from w_mant_simple`dw_1 within w_escritos_tipo_variables
integer width = 2711
string dataobject = "d_mant_escritos_tipo_variables"
end type

type cb_anyadir from w_mant_simple`cb_anyadir within w_escritos_tipo_variables
end type

type cb_borrar from w_mant_simple`cb_borrar within w_escritos_tipo_variables
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_escritos_tipo_variables
end type

