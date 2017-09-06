HA$PBExportHeader$w_municipios.srw
$PBExportComments$domicilio,cliente,fases,registrosE/S,arquitectos, expedientes, formacion
forward
global type w_municipios from w_mant_simple
end type
type dw_busqueda from u_dw within w_municipios
end type
type dw_temporal from u_dw within w_municipios
end type
end forward

global type w_municipios from w_mant_simple
integer width = 3973
integer height = 2032
string title = "Mantenimiento de Municipios"
dw_busqueda dw_busqueda
dw_temporal dw_temporal
end type
global w_municipios w_municipios

type variables
string i_sql_nuevo
end variables

on w_municipios.create
int iCurrent
call super::create
this.dw_busqueda=create dw_busqueda
this.dw_temporal=create dw_temporal
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_busqueda
this.Control[iCurrent+2]=this.dw_temporal
end on

on w_municipios.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_busqueda)
destroy(this.dw_temporal)
end on

event type integer pfc_preupdate();call super::pfc_preupdate;//string mensaje
//int fila, res, retorno=1
//long ll_pos_en_dw1[]
//
//mensaje += f_valida(dw_1,'cod_pob','NOVACIO','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo.'+cr)
//mensaje += f_valida(dw_1,'cod_pos','NOVACIO','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo Postal.'+cr)
//mensaje += f_valida(dw_1,'descripcion','NOVACIO','Debe especificar un valor en el campo Descripci$$HEX1$$f300$$ENDHEX$$n.'+cr)
//mensaje += f_valida(dw_1,'provincia','NOVACIO','Debe especificar un valor en el campo Provincia.'+cr)
//
////Andr$$HEX1$$e900$$ENDHEX$$s 9/2/05
////Ponemos en un dw las filas de la bd mas las a$$HEX1$$f100$$ENDHEX$$adidas por el usuario
//
//dw_temporal.dataobject='d_mant_poblaciones'
//dw_temporal.settransobject(sqlca)
//dw_temporal.retrieve()
//
//
////Copiamos las filas nuevas al dw_temporal
//for fila=1 to dw_1.Rowcount()
//	if dw_1.GetItemStatus( fila,0, Primary!) = NewModified! then
//		dw_1.rowscopy(fila,fila,Primary!,dw_temporal,dw_temporal.rowcount(),Primary!)
//		ll_pos_en_dw1[dw_temporal.rowcount()-1]=fila
//	END IF
//next
//
////comprobamos si hay claves primarias duplicadas (cod_pos)
//for fila=1 to dw_temporal.rowcount()
//	if dw_temporal.GetItemStatus( fila,0, Primary!) = NewModified! then
//			res = f_busca_duplicados_colum_dw (dw_temporal, 'cod_pob', fila)
//		if res>0 then
//			mensaje=mensaje+'El C$$HEX1$$f300$$ENDHEX$$digo de poblaci$$HEX1$$f300$$ENDHEX$$n de la fila:'+string(ll_pos_en_dw1[fila])+' est$$HEX2$$e1002000$$ENDHEX$$repetido. Introduzca un valor diferente'+cr
//		end if
//	end if
//next
////fin Andr$$HEX1$$e900$$ENDHEX$$s 9/2/2005
//
//if mensaje<>'' then
//	messagebox(g_titulo, mensaje, stopsign!)
//	retorno=-1
//end if
//
//return retorno
//

string mensaje
int fila, res, retorno=1
long ll_pos_en_dw1[]

//mensaje += f_valida(dw_1,'cod_pob','NOVACIO','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo.'+cr)
//mensaje += f_valida(dw_1,'cod_pos','NOVACIO','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo Postal.'+cr)
//mensaje += f_valida(dw_1,'descripcion','NOVACIO','Debe especificar un valor en el campo Descripci$$HEX1$$f300$$ENDHEX$$n.'+cr)
//mensaje += f_valida(dw_1,'provincia','NOVACIO','Debe especificar un valor en el campo Provincia.'+cr)

if mensaje<>'' then
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno

end event

event open;call super::open;dw_busqueda.insertrow(0)	
inv_resize.of_Register (dw_busqueda, "ScaletoRight")
end event

event pfc_dberror();//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_dberror
//
//	Arguments:	None
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Display the dberror that was encountered during the pfc_save process.
//
// Note: Triggered by the pfc_save when the update failed, after the appropriate
//		end transaction process (which if appropriate should include rollback process)
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
// 5.0.02 Initial version
// 6.0 	Enhanced to use dberrorattrib.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string	ls_msgparm[1]
n_cst_dberrorattrib lnv_dberrorattrib

// Get the error message.  First check on the dberrorattrib.  If not found there,
// get it from is_dberrormsg (backward compatibility code).
If IsValid(inv_dberrorattrib) Then
	If LenA(Trim(inv_dberrorattrib.is_errormsg)) > 0 Then
		ls_msgparm[1] = inv_dberrorattrib.is_errormsg
	Else
		ls_msgparm[1] = is_dberrormsg
	End If
Else
	ls_msgparm[1] = is_dberrormsg
End If

// Display the error message (it was suppressed until after the end transaction process).
If IsValid(gnv_app.inv_error) Then
	gnv_app.inv_error.of_Message ('pfc_dwdberror', ls_msgparm, &
				gnv_app.iapp_object.DisplayName)
Else
	string ls_mensaje_error
	//Andr$$HEX1$$e900$$ENDHEX$$s: Determinamos el tipo de error seg$$HEX1$$fa00$$ENDHEX$$n el sqldbcode
	choose case inv_dberrorattrib.il_sqldbcode
		CASE 2601
			ls_mensaje_error='El campo c$$HEX1$$f300$$ENDHEX$$digo de poblaci$$HEX1$$f300$$ENDHEX$$n de la fila '+string(inv_dberrorattrib.il_row)+' est$$HEX2$$e1002000$$ENDHEX$$repetido. Introduzca otro valor.'
		case else
			ls_mensaje_error='Alg$$HEX1$$fa00$$ENDHEX$$n campo de la fila '+string(inv_dberrorattrib.il_row)+' est$$HEX2$$e1002000$$ENDHEX$$vac$$HEX1$$ed00$$ENDHEX$$o. Introduzca un valor.'
	end choose
	of_Messagebox ('pfc_master_dwdberror', gnv_app.iapp_object.DisplayName, &
		ls_mensaje_error, StopSign!, Ok!, 1)

End If

// Clear the error message variable.
of_SetDBErrorMsg(lnv_dberrorattrib)

end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_municipios
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_municipios
end type

type dw_1 from w_mant_simple`dw_1 within w_municipios
integer x = 37
integer y = 456
integer width = 3863
integer height = 1224
string dataobject = "d_mant_municipios"
boolean ib_rmbmenu = false
end type

event dw_1::itemchanged;call super::itemchanged;//choose case dwo.name
//	case 'cod_pos'
//		this.setitem(row, 'cod_pob', data)
//end choose
end event

event dw_1::pfc_predeleterow;//// return
////    0 previene el borrado
////    1 suprime el registro
////   -1 error
//
//string codigo
//long num_registros
//long fila
//
//// Si no hay filas para borrar detengo el proceso de borrado
//if dw_1.RowCount() = 0 Then return 0
//
//fila = dw_1.GetRow()
//codigo = dw_1.GetItemString(fila, "cod_pob")
//
//// Si la fila es nueva la suprimimos
//if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
//   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
//	return 1
//
//else
//// Comprobamos que no hayan fases que utilicen este c$$HEX1$$f300$$ENDHEX$$digo de poblacion
//	SELECT Count(*)  
//	 INTO :num_registros
//    FROM fases  
//   WHERE (fases.poblacion = :codigo) ;  
//
//	if num_registros > 0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_pob")
//		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
//		           g_idioma.of_getmsg('colegiados.msg_fases_cod_poblacion',"Existen fases con este c$$HEX1$$f300$$ENDHEX$$digo de poblacion.") , Exclamation!)
//		return 0
//	end if
//// Comprobamos que no hayan domicilios que utilicen este codigo de poblacion
//	select count(*)
//	into :num_registros
//	from domicilios
//	where (domicilios.cod_pob= :codigo);
//	
//	if num_registros>0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_pob")
//		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
//		            g_idioma.of_getmsg('colegiados.campo_codigo_poblacion',"Existen domicilios con este c$$HEX1$$f300$$ENDHEX$$digo de poblacion.") , Exclamation!)
//		return 0
//	end if
//// Comprobamos que no hayan clientes que utilicen este codigo de poblacion
//	select count(*)
//	into :num_registros
//	from clientes
//	where (clientes.cod_pob= :codigo);
//	
//	if num_registros>0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_pob")
//		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
//		           g_idioma.of_getmsg('colegiados.msg_clientes_cod_poblacion',"Existen clientes con este c$$HEX1$$f300$$ENDHEX$$digo de poblacion.") , Exclamation!)
//		return 0
//	end if
//
//// Comprobamos que no hayan arquitectos que utilicen este codigo de poblacion
//	select count(*)
//	into :num_registros
//	from arquitectos
//	where (arquitectos.cp= :codigo);
//	
//	if num_registros>0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_pob")
//		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
//		           g_idioma.of_getmsg('colegiados.msg_arquitectos_cod_poblacion',"Existen arquitectos con este c$$HEX1$$f300$$ENDHEX$$digo de poblacion.") , Exclamation!)
//		return 0
//	end if
//	
//// Comprobamos que no hayan registros que utilicen este codigo de poblacion
//	select count(*)
//	into :num_registros
//	from registro
//	where (registro.poblacion_o= :codigo) or (registro.poblacion_d= :codigo);
//	
//	if num_registros>0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_pob")
//		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
//		           g_idioma.of_getmsg('general.msg_registros_cod_poblacion',"Existen registros con este c$$HEX1$$f300$$ENDHEX$$digo de poblacion.") , Exclamation!)
//		return 0
//	end if
//// Comprobamos que no hayan expedientes que utilicen este codigo de poblacion
//	select count(*)
//	into :num_registros
//	from expedientes
//	where (expedientes.poblacion= :codigo);
//	
//	if num_registros>0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_pob")
//		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
//		           g_idioma.of_getmsg('general.msg_registros_exp_cod_poblacion',"Existen expedientes con este c$$HEX1$$f300$$ENDHEX$$digo de poblacion.") , Exclamation!)
//		return 0
//	end if
//
//// Comprobamos que no hayan asistente a cursos de formaci$$HEX1$$f300$$ENDHEX$$n que utilicen este codigo de poblacion
//	select count(*)
//	into :num_registros
//	from formacion_asistentes
//	where (formacion_asistentes.poblacion= :codigo);
//	
//	if num_registros>0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_pob")
//		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
//		          g_idioma.of_getmsg('general.msg_asistentes_cursos_cod_poblacion', "Existen asistentes a cursos con este c$$HEX1$$f300$$ENDHEX$$digo de poblacion.") , Exclamation!)
//		return 0
//	end if
//// Comprobamos que no hayan ponentes de los cursos de formacion que utilicen este codigo de poblacion
//	select count(*)
//	into :num_registros
//	from formacion_ponentes
//	where (formacion_ponentes.poblacion= :codigo) or (formacion_ponentes.poblacion2= :codigo);
//	
//	if num_registros>0 then
//		dw_1.ScrollToRow(fila)
//		dw_1.SetColumn("cod_pob")
//		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
//		           g_idioma.of_getmsg('general.msg_ponentes_cursos_cod_poblacion',"Existen ponentes de los cursos de formaci$$HEX1$$f300$$ENDHEX$$n con este c$$HEX1$$f300$$ENDHEX$$digo de poblacion.") , Exclamation!)
//		return 0
//	end if
//
//
//end if

return 1 //continuamos con el borrado del registro

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;//IF GetItemStatus(currentrow,0,Primary!)=New! or GetItemStatus(currentrow,0,Primary!)=NewModified! THEN
//	Object.cod_pob.Edit.DisplayOnly = "No"
//	Object.cod_pos.Edit.DisplayOnly = "No"
//ELSE    
//	Object.cod_pob.Edit.DisplayOnly = "Yes"
//	Object.cod_pos.Edit.DisplayOnly = "Yes"
//END IF  
//
end event

event dw_1::retrieveend;call super::retrieveend;// Modificado por ricardo 28/10/03

// PArece ser que cuando se crean las poblaciones desde la ventana response no pone el codigo de poblacion con lo cual aqu$$HEX1$$ed00$$ENDHEX$$
// falla por la validacion del preupdate. Y eso produce que no se puedan a$$HEX1$$f100$$ENDHEX$$adir aqu$$HEX2$$ed002000$$ENDHEX$$poblaciones
//long fila
//FOR fila =1 to rowcount
//	if f_es_Vacio(this.GetItemString(fila, 'cod_muni')) then
//		this.setitem(fila, 'cod_muni', this.GetItemString(fila, 'cod_pos'))
//	end if
//NEXT

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_municipios
integer x = 37
integer y = 1704
end type

type cb_borrar from w_mant_simple`cb_borrar within w_municipios
integer x = 329
integer y = 1704
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_municipios
integer x = 1358
integer y = 1704
end type

type dw_busqueda from u_dw within w_municipios
integer x = 37
integer y = 32
integer width = 2542
integer height = 404
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_municipios_busqueda"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;string sql_inicial
choose case dwo.name
	case 'cb_buscar'
		SetPointer(HourGlass!)
		dw_busqueda.AcceptText()
		i_sql_nuevo = dw_1.describe("datawindow.table.select")
		sql_inicial = i_sql_nuevo
		
		f_sql('municipios.provincia','LIKE','provincia',dw_busqueda,i_sql_nuevo,'1','')
		f_sql('municipios.cod_muni','LIKE','cod_muni',dw_busqueda,i_sql_nuevo,'1','')
		f_sql('municipios.descripcion','LIKE','descripcion',dw_busqueda,i_sql_nuevo,'1','')

		dw_1.modify("datawindow.table.select= ~"" + i_sql_nuevo + "~"")
		dw_1.retrieve()
		dw_1.modify("datawindow.table.select= ~"" + sql_inicial + "~"")
end choose

end event

type dw_temporal from u_dw within w_municipios
boolean visible = false
integer x = 2345
integer y = 548
integer taborder = 11
boolean bringtotop = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

