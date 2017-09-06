HA$PBExportHeader$w_regsoc_manteni_tipo_for_jur.srw
forward
global type w_regsoc_manteni_tipo_for_jur from w_mant_simple
end type
end forward

global type w_regsoc_manteni_tipo_for_jur from w_mant_simple
integer height = 1536
string title = "Mantenimiento de Tipos de Formas Jur$$HEX1$$ed00$$ENDHEX$$dicas"
end type
global w_regsoc_manteni_tipo_for_jur w_regsoc_manteni_tipo_for_jur

on w_regsoc_manteni_tipo_for_jur.create
call super::create
end on

on w_regsoc_manteni_tipo_for_jur.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_dberror;//
end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_regsoc_manteni_tipo_for_jur
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_regsoc_manteni_tipo_for_jur
end type

type dw_1 from w_mant_simple`dw_1 within w_regsoc_manteni_tipo_for_jur
string dataobject = "d_regsoc_manteni_tipo_for_jur"
end type

event dw_1::pfc_preupdate;call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'cod_forma_juridica','NOVACIO','Debe especificar un valor en el campo c$$HEX1$$f300$$ENDHEX$$digo.'+cr)
mensaje += f_valida(dw_1,'descripcion','NOVACIO','Debe especificar un valor en el campo descripci$$HEX1$$f300$$ENDHEX$$n.'+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'cod_forma_juridica', fila)
			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_regsoc_manteni_tipo_for_jur
end type

type cb_borrar from w_mant_simple`cb_borrar within w_regsoc_manteni_tipo_for_jur
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_regsoc_manteni_tipo_for_jur
end type

