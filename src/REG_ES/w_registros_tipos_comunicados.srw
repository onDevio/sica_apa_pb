HA$PBExportHeader$w_registros_tipos_comunicados.srw
forward
global type w_registros_tipos_comunicados from w_mant_simple
end type
end forward

global type w_registros_tipos_comunicados from w_mant_simple
integer width = 2153
string title = "Mantenimiento de Comunicados"
end type
global w_registros_tipos_comunicados w_registros_tipos_comunicados

on w_registros_tipos_comunicados.create
call super::create
end on

on w_registros_tipos_comunicados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'codigo','NOVACIO',g_idioma.of_getmsg('msg_entsal.especif_cod','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo.'+cr))
mensaje += f_valida(dw_1,'descripcion','NOVACIO',g_idioma.of_getmsg('msg_entsal.especif_descripcion','Debe especificar un valor en el campo Descripci$$HEX1$$f300$$ENDHEX$$n.'+cr))

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'c_informe', fila)
			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_registros_tipos_comunicados
string tag = "text=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_registros_tipos_comunicados
string tag = "text=general.guardar_pantalla"
end type

type dw_1 from w_mant_simple`dw_1 within w_registros_tipos_comunicados
integer width = 2071
string dataobject = "d_registros_tipos_comunicados"
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
codigo = dw_1.GetItemString(fila, "c_informe")

// Si la fila es nueva la suprimimos
if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
	return 1

else
// Comprobamos que no hayan fases de informes que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM fases_informes
   WHERE (fases_informes.tipo_informe = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("c_informe")
		messagebox(g_idioma.of_getmsg('msg_entsal.suprimir',"Suprimir"),g_idioma.of_getmsg('msg_entsal.no_borrar_reg',"No se puede borrar el registro. ~n") + & 
		g_idioma.of_getmsg('msg_entsal.fases_tipo_informe',"Existen fases de informes con este tipo de informe.") , Exclamation!)
		return 0
	end if
	
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

type cb_anyadir from w_mant_simple`cb_anyadir within w_registros_tipos_comunicados
end type

type cb_borrar from w_mant_simple`cb_borrar within w_registros_tipos_comunicados
string tag = "text=general.borrar"
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_registros_tipos_comunicados
string tag = "text=general.ayuda"
end type

