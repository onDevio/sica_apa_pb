HA$PBExportHeader$w_formas_pago.srw
$PBExportComments$facturas_emitidas, recibos
forward
global type w_formas_pago from w_mant_simple
end type
end forward

global type w_formas_pago from w_mant_simple
integer x = 214
integer y = 221
integer width = 3726
string title = "Mantenimiento de Formas de Pago"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_formas_pago w_formas_pago

on w_formas_pago.create
call super::create
end on

on w_formas_pago.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'tipo_pago','NOVACIO','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo.'+cr)
mensaje += f_valida(dw_1,'tipo','NOVACIO','Debe especificar un valor en el campo Tipo.'+cr)
mensaje += f_valida(dw_1,'cuenta','NOVACIO','Debe especificar un valor en el campo Cuenta.'+cr)
mensaje += f_valida(dw_1,'contado','NOVACIO','Debe especificar un valor en el campo Contado.'+cr)
//mensaje += f_valida(dw_1,'n_vencimientos','NOCERO','Debe especificar un valor en el campo N$$HEX2$$ba002000$$ENDHEX$$de V.'+cr)
//mensaje += f_valida(dw_1,'dias_primer_vencimiento','NOCERO','Debe especificar un valor en el campo Primero.'+cr)
//mensaje += f_valida(dw_1,'dias_entre_vencimiento','NOCERO','Debe especificar un valor en el campo D$$HEX1$$ed00$$ENDHEX$$as entre V.'+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'cod_forma_de_pago', fila)
			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_formas_pago
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_formas_pago
end type

type dw_1 from w_mant_simple`dw_1 within w_formas_pago
integer width = 3671
string dataobject = "d_mant_formas_pago"
end type

event dw_1::pfc_addrow;call super::pfc_addrow;//string forma_pago
//forma_pago=f_siguiente_numero('FORMAS_DE_PAGO',2)//Obtengo el siguiente c$$HEX1$$f300$$ENDHEX$$digo de forma de pago disponible
//this.setitem(this.getrow(),'cod_forma_de_pago',forma_pago)//Lo muestro en el campo de codigo
return 1
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;// Solo permito que se modifique el codigo de la Nueva fila

IF GetItemStatus(currentrow,0,Primary!)=New! or GetItemStatus(currentrow,0,Primary!)=NewModified! THEN
	Object.tipo_pago.Edit.DisplayOnly = "No"
ELSE	
	Object.tipo_pago.Edit.DisplayOnly = "Yes"
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
codigo = dw_1.GetItemString(fila, "tipo_pago")

// Si la fila es nueva la suprimimos
if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
	return 1

else
// Comprobamos que no hayan facturas emitidas que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM csi_facturas_emitidas
   WHERE (csi_facturas_emitidas.formadepago = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("tipo_pago")
	messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		           g_idioma.of_getmsg('general.existen_facturas_emi',"Existen facturas emitidas con este tipo de Forma de Pago.") , Exclamation!)
		return 0
	end if
// Comprobamos que no hayan recibos que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM csi_recibos
   WHERE (csi_recibos.formadepago = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("tipo_pago")
		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		           g_idioma.of_getmsg('general.existen_recibos_emi',"Existen recibos con este tipo de Forma de Pago.") , Exclamation!)
		return 0
	end if


end if

return 1 //continuamos con el borrado del registro

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_formas_pago
end type

type cb_borrar from w_mant_simple`cb_borrar within w_formas_pago
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_formas_pago
end type

