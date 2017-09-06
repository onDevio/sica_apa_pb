HA$PBExportHeader$w_tipos_reparos.srw
$PBExportComments$fases_reparos
forward
global type w_tipos_reparos from w_mant_simple
end type
end forward

global type w_tipos_reparos from w_mant_simple
integer width = 3168
string title = "Mantenimiento de Reparos"
end type
global w_tipos_reparos w_tipos_reparos

type variables
integer i_fila
end variables

on w_tipos_reparos.create
call super::create
end on

on w_tipos_reparos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preupdate;string mensaje,cadenas[] 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'codigo','NOVACIO',g_idioma.of_getmsg('general.campo_reapro','Debe especificar un valor en el campo c$$HEX1$$f300$$ENDHEX$$digo de reparo.')+cr)
mensaje += f_valida(dw_1,'descripcion','NOVACIO',g_idioma.of_getmsg('general.campo_descripcion','Debe especificar un valor en el campo Descripci$$HEX1$$f300$$ENDHEX$$n.')+cr)
mensaje += f_valida(dw_1,'tipo','NOVACIO',g_idioma.of_getmsg('general.campo_tipo','Debe especificar un valor en el campo Tipo.')+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'codigo', fila)
			if res > 0 then
				cadenas[1] = string(fila) 
                  cadenas[2]= string(res)
				if dw_1.getitemstring(fila,'tipo') = dw_1.getitemstring(res,'tipo') then mensaje +=g_idioma.of_getmsg('general.repetir_filas',cadenas[],'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res)) + cr
			end if
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_tipos_reparos
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_tipos_reparos
end type

type dw_1 from w_mant_simple`dw_1 within w_tipos_reparos
integer width = 3067
string dataobject = "d_mant_reparos"
end type

event dw_1::pfc_preupdate;call super::pfc_preupdate;//string mensaje 
//int fila, res, retorno=1
//
//mensaje += f_valida(dw_1,'cargos','NOVACIO','Debe especificar un valor en el campo c$$HEX1$$f300$$ENDHEX$$digo de cargo.')
//mensaje += f_valida(dw_1,'descripcion','NOVACIO','Debe especificar un valor en el campo Cargo.')
//
//// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
//// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
//For fila = 1 to dw_1.RowCount() 
//	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
//			res = f_busca_duplicados_colum_dw (dw_1, 'cargo', fila)
//			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
//	END IF
//next
//
//if mensaje<>'' then 
//	messagebox(g_titulo, mensaje, stopsign!)
//	retorno=-1
//end if
//


// MODIFICADO RICARDO 17/11/03
string mensaje, cadenas[]
int fila, res, retorno=1

mensaje += f_valida(dw_1,'codigo','NOVACIO',g_idioma.of_getmsg('general.campo_codigo','Debe especificar un valor para el c$$HEX1$$f300$$ENDHEX$$digo.'))
mensaje += f_valida(dw_1,'descripcion','NOVACIO',g_idioma.of_getmsg('general.campo_descripcion','Debe especificar la descripcion.'))

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'codigo', fila)
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

event dw_1::doubleclicked;call super::doubleclicked;string obser, data_item

CHOOSE CASE dwo.name
	CASE 'observaciones'
		g_busqueda.titulo="Observaciones"
		obser    =this.GetItemString(row, 'observaciones')
		openwithparm(w_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
			if not isnull(obser) then 
				dw_1.SetItem(row,'observaciones',obser)
			end if
		end if
END CHOOSE
end event

event dw_1::buttonclicked;string ruta,fichero
long cancelar

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02

cancelar=getfileopenname('Selecci$$HEX1$$f300$$ENDHEX$$n del fichero',ruta, fichero,"Archivos (*.RTF),*.RTF")
if cancelar = 1 then
	this.setitem(row,'impreso',fichero)
end if
// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02

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
// Comprobamos que no hayan colegiados que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM fases_reparos
   WHERE (fases_reparos.tipo_reparo = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("codigo")
		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		           g_idioma.of_getmsg('msg_fases_reparo_tipo_reparo',"Existen fases de reparo con este tipo de reparo." ), Exclamation!)
		return 0
	end if

end if

return 1 //continuamos con el borrado del registro

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_tipos_reparos
end type

type cb_borrar from w_mant_simple`cb_borrar within w_tipos_reparos
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_tipos_reparos
boolean visible = false
end type

