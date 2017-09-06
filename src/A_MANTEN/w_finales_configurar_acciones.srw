HA$PBExportHeader$w_finales_configurar_acciones.srw
$PBExportComments$fases-> Permite configurar lo que se mostrar$$HEX2$$e1002000$$ENDHEX$$en la pop up cuando se modifique un final de obra
forward
global type w_finales_configurar_acciones from w_mant_simple
end type
end forward

global type w_finales_configurar_acciones from w_mant_simple
integer width = 3022
integer height = 1516
string title = "Mantenimiento de Acciones a Realizar con los Finales de Obra"
end type
global w_finales_configurar_acciones w_finales_configurar_acciones

on w_finales_configurar_acciones.create
call super::create
end on

on w_finales_configurar_acciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'tipo_trabajo','NOVACIO','Debe especificar un valor para el tipo de obra.'+cr)
mensaje += f_valida(dw_1,'Trabajo','NOVACIO','Debe especificar un valor para el Destino.'+cr)


if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type dw_1 from w_mant_simple`dw_1 within w_finales_configurar_acciones
integer x = 37
integer y = 32
integer width = 2930
string dataobject = "d_mant_finales_configurar_acciones"
end type

event dw_1::doubleclicked;call super::doubleclicked;string descripcion
CHOOSE CASE dwo.name
	CASE 'descripcion'
		g_busqueda.titulo="Descripci$$HEX1$$f300$$ENDHEX$$n Acci$$HEX1$$f300$$ENDHEX$$n a Realizar"
		descripcion = this.GetItemString(row, 'descripcion')
		openwithparm(w_observaciones, descripcion)
		if Message.Stringparm <> '-1' then
			descripcion = Message.Stringparm
			if not isnull(descripcion) then 
				dw_1.SetItem(row,'descripcion',descripcion)
			end if 	
		end if
END CHOOSE

end event

event type long dw_1::pfc_addrow();call super::pfc_addrow;if AncestorReturnValue >0 then
	this.setitem(AncestorReturnValue, 'id_accion', f_siguiente_numero ('ACCION', 10))
end if

return AncestorReturnValue
end event

event type long dw_1::pfc_insertrow();call super::pfc_insertrow;if AncestorReturnValue >0 then
	this.setitem(AncestorReturnValue, 'id_accion', f_siguiente_numero ('ACCION', 10))
end if

return AncestorReturnValue
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_finales_configurar_acciones
integer x = 37
integer y = 1224
end type

type cb_borrar from w_mant_simple`cb_borrar within w_finales_configurar_acciones
integer x = 329
integer y = 1224
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_finales_configurar_acciones
end type

