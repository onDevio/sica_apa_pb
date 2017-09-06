HA$PBExportHeader$w_estadisticas_tipos_act_tipos_obra_f.srw
forward
global type w_estadisticas_tipos_act_tipos_obra_f from w_mant_simple
end type
end forward

global type w_estadisticas_tipos_act_tipos_obra_f from w_mant_simple
integer width = 2542
string title = "Mantenimiento de Estad$$HEX1$$ed00$$ENDHEX$$sticas de Tipos Act. + Tipos Obra Familia"
end type
global w_estadisticas_tipos_act_tipos_obra_f w_estadisticas_tipos_act_tipos_obra_f

on w_estadisticas_tipos_act_tipos_obra_f.create
call super::create
end on

on w_estadisticas_tipos_act_tipos_obra_f.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'familia','NOVACIO',g_idioma.of_getmsg('general.campo_codigo','Debe especificar un valor en el campo c$$HEX1$$f300$$ENDHEX$$digo.')+cr)
mensaje += f_valida(dw_1,'tipo_obra_familia','NOVACIO',g_idioma.of_getmsg('general.campo_codigo','Debe especificar un valor en el campo c$$HEX1$$f300$$ENDHEX$$digo.')+cr)
mensaje += f_valida(dw_1,'texto_codigos','NOVACIO',g_idioma.of_getmsg('general.msg_exsite_departamento','Debe especificar un valor en el campo Departamento.')+cr)

//// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
//// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
//For fila = 1 to dw_1.RowCount() 
//	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
//			res = f_busca_duplicados_colum_dw (dw_1, 'codigo', fila)
//			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
//	END IF
//next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_estadisticas_tipos_act_tipos_obra_f
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_estadisticas_tipos_act_tipos_obra_f
end type

type dw_1 from w_mant_simple`dw_1 within w_estadisticas_tipos_act_tipos_obra_f
integer x = 37
integer y = 32
integer width = 2418
string dataobject = "d_mant_est_tipo_act_tipo_obra_f"
end type

type cb_anyadir from w_mant_simple`cb_anyadir within w_estadisticas_tipos_act_tipos_obra_f
integer x = 37
end type

type cb_borrar from w_mant_simple`cb_borrar within w_estadisticas_tipos_act_tipos_obra_f
integer x = 329
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_estadisticas_tipos_act_tipos_obra_f
integer x = 1358
end type

