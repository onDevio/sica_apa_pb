HA$PBExportHeader$w_otros_conceptos.srw
$PBExportComments$col(otros_datos_colegiado), d_dddw_otros_conceptos_col, d_dddw_otros_conceptos_exp
forward
global type w_otros_conceptos from w_mant_simple
end type
end forward

global type w_otros_conceptos from w_mant_simple
integer width = 3515
string title = "Mantenimiento de Otros Datos"
end type
global w_otros_conceptos w_otros_conceptos

on w_otros_conceptos.create
call super::create
end on

on w_otros_conceptos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje,cadenas[] 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'codigo','NOVACIO',g_idioma.of_getmsg('general.campo_codigo','Debe especificar un valor en el campo c$$HEX1$$f300$$ENDHEX$$digo.')+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
		res = f_busca_duplicados_colum_dw (dw_1, 'codigo', fila)
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

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_otros_conceptos
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_otros_conceptos
end type

type dw_1 from w_mant_simple`dw_1 within w_otros_conceptos
integer width = 3424
integer taborder = 40
string dataobject = "d_mant_otros_conceptos"
boolean hsplitscroll = true
end type

event dw_1::pfc_predeleterow;//pfc_predeleterow()

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
codigo = dw_1.GetItemString(fila, "codigo")

// Si la fila es nueva la suprimimos
if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
	return 1

else
//// Comprobamos que no hayan colegiados que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
//	SELECT Count(*)  
//	 INTO :num_registros
//    FROM otros_datos_colegiado  
//   WHERE (otros_datos_colegiado.cod_caracteristica= :codigo) ;  
//
//	if num_registros > 0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("codigo")
//		messagebox("Suprimir", "No se puede borrar el registro. ~n" + &
//		           "Existen colegiados con este tipo de Otros Conceptos." , Exclamation!)
//		return 0
//	end if
//
end if

return 1 //continuamos con el borrado del registro

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;// Solo permito que se modifique el codigo de la Nueva fila

IF GetItemStatus(currentrow,0,Primary!)=New! or GetItemStatus(currentrow,0,Primary!)=NewModified! THEN
	Object.codigo.Edit.DisplayOnly = "No"
ELSE	
	Object.codigo.Edit.DisplayOnly = "Yes"
END IF	

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_otros_conceptos
integer taborder = 20
end type

type cb_borrar from w_mant_simple`cb_borrar within w_otros_conceptos
integer taborder = 30
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_otros_conceptos
integer taborder = 10
end type

