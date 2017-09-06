HA$PBExportHeader$w_tipos_descripciones_fases.srw
$PBExportComments$fases_minutas, fases_honorarios
forward
global type w_tipos_descripciones_fases from w_mant_simple
end type
end forward

global type w_tipos_descripciones_fases from w_mant_simple
integer width = 1989
string title = "Mantenimiento de Tipos de Honorarios"
end type
global w_tipos_descripciones_fases w_tipos_descripciones_fases

on w_tipos_descripciones_fases.create
call super::create
end on

on w_tipos_descripciones_fases.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'id_descripcion','NOVACIO','Debe especificar un valor en el campo Descripci$$HEX1$$f300$$ENDHEX$$n.'+cr)


// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'id_descripcion', fila)
			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type dw_1 from w_mant_simple`dw_1 within w_tipos_descripciones_fases
integer width = 1893
string dataobject = "d_tipos_descripciones_fases"
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;// Solo permito que se modifique el codigo de la Nueva fila

IF GetItemStatus(currentrow,0,Primary!)=New! or GetItemStatus(currentrow,0,Primary!)=NewModified! THEN
	Object.id_descripcion.Edit.DisplayOnly = "No"
ELSE	
	Object.id_descripcion.Edit.DisplayOnly = "Yes"
END IF
end event

event type integer dw_1::pfc_predeleterow();////pfc_predeleterow()
//
//// return
////    0 previene el borrado
////    1 suprime el registro
////   -1 error
//
//string codigo, descripcion
//long num_registros
//long fila
//
//// Si no hay filas para borrar detengo el proceso de borrado
//if dw_1.RowCount() = 0 Then return 0
//
//fila = dw_1.GetRow()
//descripcion = dw_1.GetItemString(fila, "id_descripcion")
//
//// Si la fila es nueva la suprimimos
//if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
//   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
//	return 1
//else
//	// Comprobamos que no hayan fases que utilicen esta descripci$$HEX1$$f300$$ENDHEX$$n
//	SELECT Count(*)
//	INTO :num_registros
//	FROM fases
//	WHERE (fases_minutas.concepto_honos = :descripcion) ;  
//
//	if num_registros > 0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("id_descripcion")
//		messagebox("Suprimir", "No se puede borrar el registro. ~n" + &
//		           "Existen fases con esta descripci$$HEX1$$f300$$ENDHEX$$n." , Exclamation!)
//		return 0
//	end if
//end if
//
return 1 //continuamos con el borrado del registro
//
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_tipos_descripciones_fases
end type

type cb_borrar from w_mant_simple`cb_borrar within w_tipos_descripciones_fases
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_tipos_descripciones_fases
end type

