HA$PBExportHeader$w_colegios.srw
$PBExportComments$col
forward
global type w_colegios from w_mant_simple
end type
end forward

global type w_colegios from w_mant_simple
integer x = 214
integer y = 221
integer width = 2793
string title = "Mantenimiento de Colegios"
end type
global w_colegios w_colegios

on w_colegios.create
call super::create
end on

on w_colegios.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preupdate;string mensaje,cadenas[]
int fila, res, retorno=1

mensaje += f_valida(dw_1,'cod_colegio','NOVACIO',g_idioma.of_getmsg('general.campo_codigo','Debe especificar un valor en el campo c$$HEX1$$f300$$ENDHEX$$digo.')+cr)
mensaje += f_valida(dw_1,'descripcion','NOVACIO',g_idioma.of_getmsg('general.campo_colegio','Debe especificar un valor en el campo Colegio.')+cr)


// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'cod_colegio', fila)
			cadenas[1]=string(fila)
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

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_colegios
integer x = 507
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_colegios
integer x = 507
end type

type dw_1 from w_mant_simple`dw_1 within w_colegios
integer x = 0
integer y = 32
integer width = 2743
string dataobject = "d_mant_colegios"
boolean hscrollbar = false
end type

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
codigo = dw_1.GetItemString(fila, "cod_colegio")

// Si la fila es nueva la suprimimos
if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
	return 1

else
// Comprobamos que no hayan colegiados que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM colegiados  
   WHERE (colegiados.colegio = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("cod_colegio")
		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		           g_idioma.of_getmsg('msg_codigo_colegio',"Existen colegiados con este c$$HEX1$$f300$$ENDHEX$$digo de Colegio.") , Exclamation!)
		return 0
	end if

end if

return 1 //continuamos con el borrado del registro

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;// Solo permito que se modifique el codigo de la Nueva fila

IF GetItemStatus(currentrow,0,Primary!)=New! or GetItemStatus(currentrow,0,Primary!)=NewModified! THEN
	Object.cod_colegio.Edit.DisplayOnly = "No"
ELSE	
	Object.cod_colegio.Edit.DisplayOnly = "Yes"
END IF	

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_colegios
integer x = 503
end type

type cb_borrar from w_mant_simple`cb_borrar within w_colegios
integer x = 795
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_colegios
integer x = 1824
end type
