HA$PBExportHeader$w_asesoria_tipos_asuntos_mant.srw
forward
global type w_asesoria_tipos_asuntos_mant from w_mant_simple
end type
end forward

global type w_asesoria_tipos_asuntos_mant from w_mant_simple
string tag = "Mantenimiento de Tipo Asuntos"
integer width = 2976
integer height = 1552
string title = "Mantenimiento de Tipo Asuntos"
end type
global w_asesoria_tipos_asuntos_mant w_asesoria_tipos_asuntos_mant

on w_asesoria_tipos_asuntos_mant.create
call super::create
end on

on w_asesoria_tipos_asuntos_mant.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'codigo','NOVACIO','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo.'+cr)
mensaje += f_valida(dw_1,'descripcion','NOVACIO','Debe especificar un valor en el campo Descripci$$HEX1$$f300$$ENDHEX$$n.'+cr)

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

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_asesoria_tipos_asuntos_mant
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_asesoria_tipos_asuntos_mant
end type

type dw_1 from w_mant_simple`dw_1 within w_asesoria_tipos_asuntos_mant
integer x = 37
integer y = 32
integer width = 2821
string title = "Mantenimiento de Tipo Asuntos"
string dataobject = "d_asesoria_tipos_asuntos_mant"
end type

event type integer dw_1::pfc_predeleterow();call super::pfc_predeleterow;string codigo
long num_registros, num_registros_new
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
// Comprobamos que no hayan colegiados asignados que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM  asesoria_juridica
   WHERE (asesoria_juridica.tipo_asunto  = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("codigo")
		messagebox("Suprimir", "No se puede borrar el registro. ~n" + &
		           "Existen Asuntos asociadoa a alguna asesoria judicial." , Exclamation!)
		return 0
	end if

end if

return 1 //continuamos con el borrado del registro

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_asesoria_tipos_asuntos_mant
integer x = 37
end type

type cb_borrar from w_mant_simple`cb_borrar within w_asesoria_tipos_asuntos_mant
integer x = 329
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_asesoria_tipos_asuntos_mant
integer x = 1358
end type

