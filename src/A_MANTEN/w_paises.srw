HA$PBExportHeader$w_paises.srw
$PBExportComments$domicilio,provincia,cliente
forward
global type w_paises from w_mant_simple
end type
end forward

global type w_paises from w_mant_simple
integer width = 1874
string title = "Mantenimiento de Pa$$HEX1$$ed00$$ENDHEX$$ses"
end type
global w_paises w_paises

on w_paises.create
call super::create
end on

on w_paises.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje,cadenas[] 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'cod_pais','NOVACIO',g_idioma.of_getmsg('general.campo_codigo','Debe especificar un valor en el campo c$$HEX1$$f300$$ENDHEX$$digo.')+cr)
mensaje += f_valida(dw_1,'nombre','NOVACIO',g_idioma.of_getmsg('colegiados.campo_pais_nombre','Debe especificar un valor en el campo Nombre del Pa$$HEX1$$ed00$$ENDHEX$$s.')+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
		res = f_busca_duplicados_colum_dw (dw_1, 'cod_pais', fila)
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

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_paises
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_paises
end type

type dw_1 from w_mant_simple`dw_1 within w_paises
integer width = 1742
string dataobject = "d_mant_paises"
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;IF GetItemStatus(currentrow,0,Primary!)=New! or GetItemStatus(currentrow,0,Primary!)=NewModified! THEN
	Object.cod_pais.Edit.DisplayOnly = "No"
ELSE	
	Object.cod_pais.Edit.DisplayOnly = "Yes"
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
codigo = dw_1.GetItemString(fila, "cod_pais")

// Si la fila es nueva la suprimimos
if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
	return 1

else
// Comprobamos que no hayan domicilios que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM  domicilios
   WHERE (domicilios.pais = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("cod_pais")
		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		           g_idioma.of_getmsg('colegiados.msg_pais_dom',"Existen domicilios con este pais.") , Exclamation!)
		return 0
	end if
// Comprobamos que no hayan provincias que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM  provincias
   WHERE (provincias.cod_pais = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("cod_pais")
		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		           g_idioma.of_getmsg('colegiados.msg_pais_prov',"Existen provincias con este codigo de pais.") , Exclamation!)
		return 0
	end if
// Comprobamos que no hayan clientes que utilicen este codigo de poblacion
	select count(*)
	into :num_registros
	from clientes
	where (clientes.pais= :codigo);
	
	if num_registros>0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("cod_pais")
		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		           g_idioma.of_getmsg('colegiados.msg_pais_cli',"Existen clientes con este c$$HEX1$$f300$$ENDHEX$$digo de pais.") , Exclamation!)
		return 0
	end if

end if

return 1 //continuamos con el borrado del registro

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_paises
end type

type cb_borrar from w_mant_simple`cb_borrar within w_paises
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_paises
end type

