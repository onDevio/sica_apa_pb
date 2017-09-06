HA$PBExportHeader$w_contadores_sica.srw
forward
global type w_contadores_sica from w_mant_simple
end type
end forward

global type w_contadores_sica from w_mant_simple
integer width = 3470
integer height = 1444
string title = "Contadores generales de la Aplicaci$$HEX1$$f300$$ENDHEX$$n"
end type
global w_contadores_sica w_contadores_sica

on w_contadores_sica.create
call super::create
end on

on w_contadores_sica.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'valor','NONULO',g_idioma.of_getmsg('general.campo_valor','Debe especificar un valor en el campo Valor.')+cr)


if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_contadores_sica
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_contadores_sica
end type

type dw_1 from w_mant_simple`dw_1 within w_contadores_sica
integer width = 3387
string dataobject = "d_contadores_sica"
boolean ib_rmbmenu = false
end type

type cb_anyadir from w_mant_simple`cb_anyadir within w_contadores_sica
boolean visible = false
end type

type cb_borrar from w_mant_simple`cb_borrar within w_contadores_sica
boolean visible = false
boolean enabled = false
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_contadores_sica
boolean visible = false
end type

