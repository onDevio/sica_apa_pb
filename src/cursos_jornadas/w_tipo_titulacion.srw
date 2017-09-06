HA$PBExportHeader$w_tipo_titulacion.srw
forward
global type w_tipo_titulacion from w_mant_simple
end type
end forward

global type w_tipo_titulacion from w_mant_simple
string title = "Mantenimiento de Tipo de Titulaci$$HEX1$$f300$$ENDHEX$$n"
end type
global w_tipo_titulacion w_tipo_titulacion

on w_tipo_titulacion.create
call super::create
end on

on w_tipo_titulacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'cod_titulacion','NOVACIO','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo.'+cr)
mensaje += f_valida(dw_1,'descripcion','NOVACIO','Debe especificar un valor en el campo Titulaci$$HEX1$$f300$$ENDHEX$$n.'+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'cod_titulacion', fila)
			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type dw_1 from w_mant_simple`dw_1 within w_tipo_titulacion
string dataobject = "d_tipo_titulacion"
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;// Solo permito que se modifique el codigo de la Nueva fila

IF GetItemStatus(currentrow,0,Primary!)=New! or GetItemStatus(currentrow,0,Primary!)=NewModified! THEN
	Object.cod_titulacion.Edit.DisplayOnly = "No"
ELSE	
	Object.cod_titulacion.Edit.DisplayOnly = "Yes"
END IF	

end event

event type integer dw_1::pfc_predeleterow();call super::pfc_predeleterow;string codigo
long num_registros
long fila

// Si no hay filas para borrar detengo el proceso de borrado
if dw_1.RowCount() = 0 Then return 0

fila = dw_1.GetRow()
codigo = dw_1.GetItemString(fila, "cod_titulacion")

// Si la fila es nueva la suprimimos
if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
	return 1

else
// Comprobamos que no hayan colegiados que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM  formacion_asistentes
   WHERE (formacion_asistentes.cod_titulacion  = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("cod_titulacion")
		messagebox("Suprimir", "No se puede borrar el registro. ~n" + &
		           "Existen asistentes a cursos con este tipo de titulacion." , Exclamation!)
		return 0
	end if

end if

return 1 //continuamos con el borrado del registro

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_tipo_titulacion
end type

type cb_borrar from w_mant_simple`cb_borrar within w_tipo_titulacion
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_tipo_titulacion
end type

