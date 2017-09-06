HA$PBExportHeader$w_tipos_orientaciones_profesionales.srw
$PBExportComments$col
forward
global type w_tipos_orientaciones_profesionales from w_mant_simple
end type
end forward

global type w_tipos_orientaciones_profesionales from w_mant_simple
integer width = 2117
string title = "Mantenimiento de Tipos de Orientaciones Profesionales"
end type
global w_tipos_orientaciones_profesionales w_tipos_orientaciones_profesionales

on w_tipos_orientaciones_profesionales.create
call super::create
end on

on w_tipos_orientaciones_profesionales.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje,cadenas[] 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'cod_orientacion_profesional','NOVACIO',g_idioma.of_getmsg('general.campo_codigo','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo.')+cr)
mensaje += f_valida(dw_1,'descripcion','NOVACIO',g_idioma.of_getmsg('general.campo_orientacion_profesional','Debe especificar un valor en el campo Orientacion Profesional.')+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
		res = f_busca_duplicados_colum_dw (dw_1, 'cod_orientacion_profesional', fila)
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

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_tipos_orientaciones_profesionales
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_tipos_orientaciones_profesionales
end type

type dw_1 from w_mant_simple`dw_1 within w_tipos_orientaciones_profesionales
integer width = 2021
string dataobject = "d_mant_tipos_orientaciones_profesionales"
end type

event dw_1::pfc_addrow;call super::pfc_addrow;//string orient_profesionales
//orient_profesionales=f_siguiente_numero('ORIEN_PROFESIONALES',2)//Obtengo el siguiente c$$HEX1$$f300$$ENDHEX$$digo de orientaci$$HEX1$$f300$$ENDHEX$$n profesional
//this.setitem(this.getrow(),'cod_orientacion',orient_profesionales)//Lo muestro en el campo de codigo
return 1
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
codigo = dw_1.GetItemString(fila, "cod_orientacion_profesional")

// Si la fila es nueva la suprimimos
if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
	return 1

else
// Comprobamos que no hayan colegiados que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM orientaciones_profesionales  
   WHERE (orientaciones_profesionales.orientacion_profesional = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("cod_orientacion_profesional")
		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		          g_idioma.of_getmsg('general.msg_col_orientacion_profesional',"Existen colegiados con este tipo de orientacion Profesional.") , Exclamation!)
		return 0
	end if
//comprobamos que no hayan bolsas de trabajo con este tipo de orientacion profesional
	select count(*)
	into :num_registros
	from bolsa_oferta
	where bolsa_oferta.orientacion_profesional1 = :codigo or bolsa_oferta.orientacion_profesional2 = :codigo;
	
	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("cod_orientacion_profesional")
        messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		           g_idioma.of_getmsg('general.msg_bolsa_tipo_orientacion_profesional',"Existen bolsas de trabajo con este tipo de orientacion Profesional.") , Exclamation!)
		return 0
	end if
	
	

end if

return 1 //continuamos con el borrado del registro

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;// Solo permito que se modifique el codigo de la Nueva fila

IF GetItemStatus(currentrow,0,Primary!)=New! or GetItemStatus(currentrow,0,Primary!)=NewModified! THEN
	Object.cod_orientacion_profesional.Edit.DisplayOnly = "No"
ELSE	
	Object.cod_orientacion_profesional.Edit.DisplayOnly = "Yes"
END IF	

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_tipos_orientaciones_profesionales
end type

type cb_borrar from w_mant_simple`cb_borrar within w_tipos_orientaciones_profesionales
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_tipos_orientaciones_profesionales
end type

