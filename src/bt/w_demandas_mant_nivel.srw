HA$PBExportHeader$w_demandas_mant_nivel.srw
forward
global type w_demandas_mant_nivel from w_mant_simple
end type
end forward

global type w_demandas_mant_nivel from w_mant_simple
integer width = 2007
string title = "Mantenimiento de Nivel de Idiomas"
end type
global w_demandas_mant_nivel w_demandas_mant_nivel

on w_demandas_mant_nivel.create
call super::create
end on

on w_demandas_mant_nivel.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'codigo','NOVACIO','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo.'+cr)
mensaje += f_valida(dw_1,'descripcion','NOVACIO','Debe especificar un valor en el campo de Descripci$$HEX1$$f300$$ENDHEX$$n.'+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'codigo', fila)
			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type dw_1 from w_mant_simple`dw_1 within w_demandas_mant_nivel
integer width = 1893
string dataobject = "d_demandas_mant_nivel"
end type

event type integer dw_1::pfc_predeleterow();call super::pfc_predeleterow;string codigo
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
// Comprobamos que no hayan siniestros que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM  bt_demandas_idiomas
   WHERE (bt_demandas_idiomas.nivel = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("codigo")
		messagebox("Suprimir", "No se puede borrar el registro. ~n" + &
		           "Existen Idiomas que tienen asociados estos niveles." , Exclamation!)
		return 0
	end if

end if

return 1 //continuamos con el borrado del registro

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;IF GetItemStatus(currentrow,0,Primary!)=New! or GetItemStatus(currentrow,0,Primary!)=NewModified! THEN
	Object.codigo.Edit.DisplayOnly = "No"
ELSE	
	Object.codigo.Edit.DisplayOnly = "Yes"
END IF	

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_demandas_mant_nivel
end type

type cb_borrar from w_mant_simple`cb_borrar within w_demandas_mant_nivel
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_demandas_mant_nivel
end type

