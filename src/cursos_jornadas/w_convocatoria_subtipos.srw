HA$PBExportHeader$w_convocatoria_subtipos.srw
forward
global type w_convocatoria_subtipos from w_mant_simple
end type
end forward

global type w_convocatoria_subtipos from w_mant_simple
integer x = 214
integer y = 221
string title = "Mantenimiento de Subtipos de Convocatorias"
end type
global w_convocatoria_subtipos w_convocatoria_subtipos

on w_convocatoria_subtipos.create
call super::create
end on

on w_convocatoria_subtipos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'cod_subtipo','NOVACIO','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo.'+cr)
mensaje += f_valida(dw_1,'descripcion','NOVACIO','Debe especificar una descripcion.'+cr)
mensaje += f_valida(dw_1,'cod_tipo','NOVACIO','Debe especificar un valor en la convocatoria.'+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'cod_subtipo', fila)
			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type dw_1 from w_mant_simple`dw_1 within w_convocatoria_subtipos
integer x = 23
integer y = 36
string dataobject = "d_subtipo_convocatoria"
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;// Solo permito que se modifique el codigo de la Nueva fila

IF GetItemStatus(currentrow,0,Primary!)=New! or GetItemStatus(currentrow,0,Primary!)=NewModified! THEN
	Object.cod_subtipo.Edit.DisplayOnly = "No"
ELSE	
	Object.cod_subtipo.Edit.DisplayOnly = "Yes"
END IF	

end event

event type integer dw_1::pfc_predeleterow();call super::pfc_predeleterow;string codigo
long num_registros
long fila

// Si no hay filas para borrar detengo el proceso de borrado
if dw_1.RowCount() = 0 Then return 0

fila = dw_1.GetRow()
codigo = dw_1.GetItemString(fila, "cod_subtipo")

// Si la fila es nueva la suprimimos
if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
	return 1

else
// Comprobamos que no hayan colegiados que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM formacion_cursos  
   WHERE (formacion_cursos.subtipo_convocatoria = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("cod_subtipo")
		messagebox("Suprimir", "No se puede borrar el registro. ~n" + &
		           "Existen cursos con este sutipo de convocatoria." , Exclamation!)
		return 0
	end if

end if

return 1 //continuamos con el borrado del registro

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_convocatoria_subtipos
end type

type cb_borrar from w_mant_simple`cb_borrar within w_convocatoria_subtipos
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_convocatoria_subtipos
end type

