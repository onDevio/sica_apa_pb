HA$PBExportHeader$w_manteni_coef_ipc.srw
forward
global type w_manteni_coef_ipc from w_mant_simple
end type
end forward

global type w_manteni_coef_ipc from w_mant_simple
integer width = 1874
string title = "Mantenimiento del Coeficiente IPC"
end type
global w_manteni_coef_ipc w_manteni_coef_ipc

on w_manteni_coef_ipc.create
call super::create
end on

on w_manteni_coef_ipc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje,cadenas[] 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'ejercicio','NOVACIO',g_idioma.of_getmsg('general.campo_ejercicio','Debe especificar un valor en el campo ejercicio (a$$HEX1$$f100$$ENDHEX$$o).')+cr)
mensaje += f_valida(dw_1,'ipc','NONULO',g_idioma.of_getmsg('general.campo_coeficiente','Debe especificar un valor en el campo Coeficiente IPC.')+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
		res = f_busca_duplicados_colum_dw (dw_1, 'ejercicio', fila)
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

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_manteni_coef_ipc
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_manteni_coef_ipc
end type

type dw_1 from w_mant_simple`dw_1 within w_manteni_coef_ipc
integer width = 1742
string dataobject = "d_manteni_coef_ipc"
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;IF GetItemStatus(currentrow,0,Primary!)=New! or GetItemStatus(currentrow,0,Primary!)=NewModified! THEN
	Object.ejercicio.Edit.DisplayOnly = "No"
ELSE	
	Object.ejercicio.Edit.DisplayOnly = "Yes"
END IF	


end event

event dw_1::pfc_predeleterow;call super::pfc_predeleterow;//pfc_predeleterow()

// return
////    0 previene el borrado
////    1 suprime el registro
////   -1 error
//
//string codigo
//long num_registros
//long fila
//
//// Si no hay filas para borrar detengo el proceso de borrado
//if dw_1.RowCount() = 0 Then return 0
//
//fila = dw_1.GetRow()
//codigo = dw_1.GetItemString(fila, "ejercio")
//
//// Si la fila es nueva la suprimimos
//if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
//   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
//	return 1
//
//else
//// Comprobamos que no hayan domicilios que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
//	SELECT Count(*)  
//	 INTO :num_registros
//    FROM  domicilios
//   WHERE (domicilios.pais = :codigo) ;  
//
//	if num_registros > 0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_pais")
//		messagebox("Suprimir", "No se puede borrar el registro. ~n" + &
//		           "Existen domicilios con este pais." , Exclamation!)
//		return 0
//	end if
//// Comprobamos que no hayan provincias que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
//	SELECT Count(*)  
//	 INTO :num_registros
//    FROM  provincias
//   WHERE (provincias.cod_pais = :codigo) ;  
//
//	if num_registros > 0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_pais")
//		messagebox("Suprimir", "No se puede borrar el registro. ~n" + &
//		           "Existen provincias con este codigo de pais." , Exclamation!)
//		return 0
//	end if
//// Comprobamos que no hayan clientes que utilicen este codigo de poblacion
//	select count(*)
//	into :num_registros
//	from clientes
//	where (clientes.pais= :codigo);
//	
//	if num_registros>0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_pais")
//		messagebox("Suprimir", "No se puede borrar el registro. ~n" + &
//		           "Existen clientes con este c$$HEX1$$f300$$ENDHEX$$digo de pais." , Exclamation!)
//		return 0
//	end if
//
//end if
//
return 1 //continuamos con el borrado del registro
//
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_manteni_coef_ipc
end type

type cb_borrar from w_mant_simple`cb_borrar within w_manteni_coef_ipc
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_manteni_coef_ipc
end type

