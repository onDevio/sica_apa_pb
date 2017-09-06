HA$PBExportHeader$w_tipos_fases.srw
$PBExportComments$cip_sobre_pem, fases, movimientos_musaat
forward
global type w_tipos_fases from w_mant_simple
end type
end forward

global type w_tipos_fases from w_mant_simple
integer width = 2153
string title = "Mantenimiento de Fases"
end type
global w_tipos_fases w_tipos_fases

on w_tipos_fases.create
call super::create
end on

on w_tipos_fases.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje,cadenas[]
int fila, res, retorno=1

mensaje += f_valida(dw_1,'c_t_fase','NOVACIO',g_idioma.of_getmsg('general.campo_codigo','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo.')+cr)
mensaje += f_valida(dw_1,'d_t_descripcion','NOVACIO',g_idioma.of_getmsg('general.campo_fase','Debe especificar un valor en el campo Fase.')+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
		res = f_busca_duplicados_colum_dw (dw_1, 'c_t_fase', fila)
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

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_tipos_fases
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_tipos_fases
end type

type dw_1 from w_mant_simple`dw_1 within w_tipos_fases
integer width = 2071
string dataobject = "d_mant_tipos_fases"
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;// Solo permito que se modifique el codigo de la Nueva fila

IF GetItemStatus(currentrow,0,Primary!)=New! or GetItemStatus(currentrow,0,Primary!)=NewModified! THEN
	Object.c_t_fase.Edit.DisplayOnly = "No"
ELSE	
	Object.c_t_fase.Edit.DisplayOnly = "Yes"
END IF	

end event

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
codigo = dw_1.GetItemString(fila, "c_t_fase")

// Si la fila es nueva la suprimimos
if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
	return 1

else
// Comprobamos que no hayan cip_sobre_pem que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM cip_sobre_pem
   WHERE (cip_sobre_pem.tipo_actuacion = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("c_t_fase")
		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		           g_idioma.of_getmsg('general.msg_cip_sobre_pem',"Existen cip_sobre_pem con este tipo de fase.") , Exclamation!)
		return 0
	end if

// Comprobamos que no hayan fases que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM fases
   WHERE (fases.fase = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("c_t_fase")
		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		          g_idioma.of_getmsg('general.msg_fases_tipo_fases', "Existen fases con este tipo de fase.") , Exclamation!)
		return 0
	end if
// Comprobamos que no hayan movimientos de musaat que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM musaat_movimientos
   WHERE (musaat_movimientos.tipo_act = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("c_t_fase")
		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		           g_idioma.of_getmsg('general.msg_mov_musaat_fase',"Existen movimientos de musaat con este tipo de fase.") , Exclamation!)
		return 0
	end if
	
end if

return 1 //continuamos con el borrado del registro

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_tipos_fases
end type

type cb_borrar from w_mant_simple`cb_borrar within w_tipos_fases
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_tipos_fases
end type

