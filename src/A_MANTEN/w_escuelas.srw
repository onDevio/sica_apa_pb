HA$PBExportHeader$w_escuelas.srw
$PBExportComments$domicilio,cliente,fases,registrosE/S,arquitectos, expedientes, formacion
forward
global type w_escuelas from w_mant_simple
end type
end forward

global type w_escuelas from w_mant_simple
integer width = 2455
string title = "Mantenimiento de Escuelas"
end type
global w_escuelas w_escuelas

on w_escuelas.create
call super::create
end on

on w_escuelas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje,cadenas[] 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'codigo','NOVACIO',g_idioma.of_getmsg('general.campo_codigo','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo.')+cr)
mensaje += f_valida(dw_1,'descripcion','NOVACIO',g_idioma.of_getmsg('colegiados.campo_pais','Debe especificar un valor en el campo Descripcio$$HEX1$$f300$$ENDHEX$$n.')+cr)
//mensaje += f_valida(dw_1,'nombre','NOVACIO',g_idioma.of_getmsg('general.campo_provincia','Debe especificar un valor en el campo Provincia.')+cr)
//
// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
//For fila = 1 to dw_1.RowCount() 
//	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
//		res = f_busca_duplicados_colum_dw (dw_1, 'cod_provincia', fila)
//		cadenas[1] = string(fila) 
//		cadenas[2]= string(res)
//		if res > 0 then mensaje += g_idioma.of_getmsg('general.repetir_filas',cadenas[],'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res)) + cr
//	END IF
//next
//
if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_escuelas
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_escuelas
end type

type dw_1 from w_mant_simple`dw_1 within w_escuelas
integer width = 2331
string dataobject = "d_mant_escuelas"
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;// Solo permito que se modifique el codigo de la Nueva fila

//IF GetItemStatus(currentrow,0,Primary!)=New! or GetItemStatus(currentrow,0,Primary!)=NewModified! THEN
//	Object.cod_provincia.Edit.DisplayOnly = "No"
//ELSE	
//	Object.cod_provincia.Edit.DisplayOnly = "Yes"
//END IF	
//
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
codigo = dw_1.GetItemString(fila, "codigo")

// Si la fila es nueva la suprimimos
if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
	return 1

else
//// Comprobamos que no hayan colegiados que utilicen este c$$HEX1$$f300$$ENDHEX$$digo

SELECT Count(*)
INTO :num_registros 
FROM colegiados  
WHERE (colegiados.cons_escuela_final = :codigo)   ;

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("codigo")
		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		           g_idioma.of_getmsg('general.msg_dom_col_cod_prov',"Existen colegiados con esa escuela.") , Exclamation!)
		return 0
	end if

//	SELECT Count(*)  
//	INTO :num_registros
//	FROM domicilios  
//	WHERE (domicilios.cod_prov = :codigo) ;  
//
//	if num_registros > 0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_provincia")
//		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
//		           g_idioma.of_getmsg('general.msg_dom_col_cod_prov',"Existen domicilios de colegiados con este codigo de provincia.") , Exclamation!)
//		return 0
//	end if
//// Comprobamos que no hayan clientes que utilicen este codigo de provincia
//	select count(*)
//	into :num_registros
//	from clientes
//	where (clientes.cod_prov= :codigo);
//	
//	if num_registros>0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_provincia")
//		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
//		           g_idioma.of_getmsg('general.msg_cli_cod_prov',"Existen clientes con este c$$HEX1$$f300$$ENDHEX$$digo de provincia.") , Exclamation!)
//		return 0
//	end if
//	
//	// Comprobamos que no hayan poblaciones que utilicen este codigo de provincia
//	select count(*)
//	into :num_registros
//	from poblaciones
//	where (poblaciones.provincia= :codigo);
//	
//	if num_registros>0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_provincia")
//		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
//		           "Existen poblaciones con este c$$HEX1$$f300$$ENDHEX$$digo de provincia." , Exclamation!)
//		return 0
//	end if
//	// Comprobamos que no hayan asistentes a  cursos de formacion que utilicen este codigo de provincia
//	select count(*)
//	into :num_registros
//	from formacion_asistentes
//	where (formacion_asistentes.provincia= :codigo);
//	
//	if num_registros>0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_provincia")
//		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
//		          g_idioma.of_getmsg('general.msg_asistents_cursos_cod_poblacion', "Existen asistentes de los cursos de formaci$$HEX1$$f300$$ENDHEX$$n con este c$$HEX1$$f300$$ENDHEX$$digo de provincia.") , Exclamation!)
//		return 0
//	end if
//
//	// Comprobamos que no hayan cursos de formacion que utilicen este codigo de provincia
//	select count(*)
//	into :num_registros
//	from formacion_cursos
//	where (formacion_cursos.provincia= :codigo);
//	
//	if num_registros>0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_provincia")
//		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
//		           g_idioma.of_getmsg('general.msg_cursos_cod_poblacion',"Existen cursos de formaci$$HEX1$$f300$$ENDHEX$$n con este c$$HEX1$$f300$$ENDHEX$$digo de provincia.") , Exclamation!)
//		return 0
//	end if
//	
//		// Comprobamos que no hayan organizadores de los cursos formacion que utilicen este codigo de provincia
//	select count(*)
//	into :num_registros
//	from formacion_organizadores
//	where (formacion_organizadores.provincia= :codigo);
//	
//	if num_registros>0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_provincia")
//		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
//		           g_idioma.of_getmsg('general.msg_org_cursos_cod_poblacion',"Existen organizadores de los cursos de formaci$$HEX1$$f300$$ENDHEX$$n con este c$$HEX1$$f300$$ENDHEX$$digo de provincia.") , Exclamation!)
//		return 0
//	end if
//// Comprobamos que no hayan ponentes de los cursos formacion que utilicen este codigo de provincia
//	select count(*)
//	into :num_registros
//	from formacion_ponentes
//	where (formacion_ponentes.provincia= :codigo) or (formacion_ponentes.provincia2= :codigo);
//	
//	if num_registros>0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_provincia")
//		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
//		           g_idioma.of_getmsg('general.msg_ponentes_cursos_cod_poblacion',"Existen ponentes de los cursos de formaci$$HEX1$$f300$$ENDHEX$$n con este c$$HEX1$$f300$$ENDHEX$$digo de provincia.") , Exclamation!)
//		return 0
//	end if
//
end if

return 1 //continuamos con el borrado del registro

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_escuelas
end type

type cb_borrar from w_mant_simple`cb_borrar within w_escuelas
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_escuelas
end type

