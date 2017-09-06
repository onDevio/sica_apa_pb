HA$PBExportHeader$w_tipo_bolsa.srw
forward
global type w_tipo_bolsa from w_mant_simple
end type
end forward

global type w_tipo_bolsa from w_mant_simple
integer width = 2217
string title = "Mantenimiento de Tipo de Bolsa"
end type
global w_tipo_bolsa w_tipo_bolsa

on w_tipo_bolsa.create
call super::create
end on

on w_tipo_bolsa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'bt_tipo_bolsa','NOVACIO','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo.'+cr)
mensaje += f_valida(dw_1,'descripcion','NOVACIO','Debe especificar un valor en el campo Descripci$$HEX1$$f300$$ENDHEX$$n.'+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'bt_tipo_bolsa', fila)
			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type dw_1 from w_mant_simple`dw_1 within w_tipo_bolsa
integer width = 2057
string dataobject = "d_mant_tipo_bolsa"
end type

event type integer dw_1::pfc_predeleterow();call super::pfc_predeleterow;string codigo
long num_registros, num_registros_new
long fila

// Si no hay filas para borrar detengo el proceso de borrado
if dw_1.RowCount() = 0 Then return 0

fila = dw_1.GetRow()
codigo = dw_1.GetItemString(fila, "bt_tipo_bolsa")

// Si la fila es nueva la suprimimos
if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
	return 1

else
// Comprobamos que no hayan colegiados asignados que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM  bt_demandas_tipo
   WHERE (bt_demandas_tipo.tipo_demanda  = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("bt_tipo_bolsa")
		messagebox("Suprimir", "No se puede borrar el registro. ~n" + &
		           "Existen colegiados asignados a este tipo de bolsa." , Exclamation!)
		return 0
	end if
// Comprobamos que no hayan colegiados asignados que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros_new
    FROM  bt_ofertas
   WHERE (bt_ofertas.tipo_bolsa  = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("bt_tipo_bolsa")
		messagebox("Suprimir", "No se puede borrar el registro. ~n" + &
		           "Existen colegiados asignados a este tipo de bolsa." , Exclamation!)
		return 0
	end if

end if

return 1 //continuamos con el borrado del registro

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_tipo_bolsa
end type

type cb_borrar from w_mant_simple`cb_borrar within w_tipo_bolsa
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_tipo_bolsa
end type

