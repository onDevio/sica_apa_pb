HA$PBExportHeader$w_tipos_fases_est.srw
forward
global type w_tipos_fases_est from w_mant
end type
end forward

global type w_tipos_fases_est from w_mant
integer width = 2144
string menuname = "m_manteni"
end type
global w_tipos_fases_est w_tipos_fases_est

event pfc_postopen;call super::pfc_postopen;dw_1.event pfc_retrieve()
ii_ayuda=50
end event

on w_tipos_fases_est.create
call super::create
if this.MenuName = "m_manteni" then this.MenuID = create m_manteni
end on

on w_tipos_fases_est.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_print;call super::pfc_print;return dw_1.Print()
end event

event pfc_preupdate;call super::pfc_preupdate;string mensaje,cadenas[] 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'codigo','NOVACIO',g_idioma.of_getmsg('general.campo_codigo','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo.')+cr)
mensaje += f_valida(dw_1,'orden','NOCERO',g_idioma.of_getmsg('general.campo_fase','Debe especificar un valor en el campo Fase.')+cr)
// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'c_t_fase', fila)
			cadenas[1] = string(fila) 
			

	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type cb_recuperar_pantalla from w_mant`cb_recuperar_pantalla within w_tipos_fases_est
end type

type cb_guardar_pantalla from w_mant`cb_guardar_pantalla within w_tipos_fases_est
end type

type dw_1 from w_mant`dw_1 within w_tipos_fases_est
integer x = 18
integer width = 2034
integer taborder = 30
string dataobject = "d_mant_tipos_fases_est"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;return this.Retrieve()
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;// Solo permito que se modifique el codigo de la Nueva fila

IF GetItemStatus(currentrow,0,Primary!)=New! or GetItemStatus(currentrow,0,Primary!)=NewModified! THEN
	Object.codigo.Edit.DisplayOnly = "No"
ELSE	
	Object.codigo.Edit.DisplayOnly = "Yes"
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
codigo = dw_1.GetItemString(fila, "codigo")

// Si la fila es nueva la suprimimos
if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
	return 1

else
// Comprobamos que no hayan fases que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM fases  
   WHERE (fases.tipo_fase = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("codigo")
messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		           g_idioma.of_getmsg('general.msg_fases_tipo_fases',"Existen fases con este tipo de fase.") , Exclamation!)
		return 0
	end if
// Comprobamos que no hayan movimientos de musaat que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM musaat_movimientos  
   WHERE (musaat_movimientos.t_visado= :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("codigo")
messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		          g_idioma.of_getmsg('general.msg_mov_musaat_tipo_visado', "Existen movimientos de musaat con este tipo de visado.") , Exclamation!)
		return 0
	end if


end if

return 1 //continuamos con el borrado del registro

end event

type cb_anyadir from w_mant`cb_anyadir within w_tipos_fases_est
integer x = 27
integer taborder = 10
end type

type cb_borrar from w_mant`cb_borrar within w_tipos_fases_est
integer taborder = 20
end type

type cb_ayuda from w_mant`cb_ayuda within w_tipos_fases_est
end type
