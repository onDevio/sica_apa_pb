HA$PBExportHeader$w_tipos_escritos.srw
$PBExportComments$escritos_tipo, certificados
forward
global type w_tipos_escritos from w_mant_simple
end type
end forward

global type w_tipos_escritos from w_mant_simple
integer width = 3589
string title = "Mantenimiento de Tipos de Escritos"
end type
global w_tipos_escritos w_tipos_escritos

on w_tipos_escritos.create
call super::create
end on

on w_tipos_escritos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_tipos_escritos
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_tipos_escritos
end type

type dw_1 from w_mant_simple`dw_1 within w_tipos_escritos
integer width = 3497
string dataobject = "d_mant_tipos_escritos"
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;// Solo permito que se modifique el codigo de la Nueva fila

IF GetItemStatus(currentrow,0,Primary!)=New! or GetItemStatus(currentrow,0,Primary!)=NewModified! THEN
	Object.cod_t_escrito.Edit.DisplayOnly = "No"
ELSE	
	Object.cod_t_escrito.Edit.DisplayOnly = "Yes"
END IF	

end event

event dw_1::pfc_predeleterow;call super::pfc_predeleterow;//pfc_predeleterow()

// return
//    0 previene el borrado
//    1 suprime el registro
//   -1 error

string codigo
long num_registros
long fila

// Si no hay filas para borrar detengo el proceso de borrado
if dw_1.RowCount() = 0 Then return 0

fila = dw_1.GetRow()
codigo = dw_1.GetItemString(fila, "cod_t_escrito")

// Si la fila es nueva la suprimimos
if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
	return 1

else
	
	// Comprobamos que no hayan certificados que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM escritos_certificados  
   WHERE (escritos_certificados.tipo = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("cod_t_escrito")
		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		           g_idioma.of_getmsg('general.msg_cetificados_tiop_escrito',"Existen certificados con este tipo de escrito.") , Exclamation!)
		return 0
	end if
// Comprobamos que no hayan tipos de escritos que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM escritos_tipo  
   WHERE (escritos_tipo.cod_tipo_escrito = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("cod_t_escrito")
		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		           g_idioma.of_getmsg('general.msg_escritos_tiop_escrito',"Existen escritos con este tipo de escrito.") , Exclamation!)
		return 0
	end if



end if

return 1 //continuamos con el borrado del registro

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_tipos_escritos
end type

type cb_borrar from w_mant_simple`cb_borrar within w_tipos_escritos
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_tipos_escritos
end type

