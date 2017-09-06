HA$PBExportHeader$w_callejero.srw
$PBExportComments$domicilio,cliente,fases,registrosE/S,arquitectos, expedientes, formacion
forward
global type w_callejero from w_mant_simple
end type
type dw_busqueda from u_dw within w_callejero
end type
type dw_temporal from u_dw within w_callejero
end type
end forward

global type w_callejero from w_mant_simple
integer width = 3909
integer height = 1948
string title = "Mantenimiento del Callejero"
dw_busqueda dw_busqueda
dw_temporal dw_temporal
end type
global w_callejero w_callejero

type variables
string i_sql_nuevo
end variables

on w_callejero.create
int iCurrent
call super::create
this.dw_busqueda=create dw_busqueda
this.dw_temporal=create dw_temporal
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_busqueda
this.Control[iCurrent+2]=this.dw_temporal
end on

on w_callejero.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_busqueda)
destroy(this.dw_temporal)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje
int fila, res, retorno=1
long ll_pos_en_dw1[]

mensaje += f_valida(dw_1,'cod_pob','NOVACIO',g_idioma.of_getmsg('general.campo_poblacion','Debe especificar un valor en el campo Poblaci$$HEX1$$f300$$ENDHEX$$n.')+cr)
mensaje += f_valida(dw_1,'cod_pos','NOVACIO',g_idioma.of_getmsg('general.campo_codigo_postal','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo Postal.')+cr)
mensaje += f_valida(dw_1,'calle','NOVACIO',g_idioma.of_getmsg('general.campo_calle','Debe especificar un valor en el campo Calle.')+cr)
mensaje += f_valida(dw_1,'provincia','NOVACIO',g_idioma.of_getmsg('general.campo_provincia','Debe especificar un valor en el campo Provincia.')+cr)

//Andr$$HEX1$$e900$$ENDHEX$$s : Asignamos clave primaria a las filas nuevas
string ls_codigomax

select max(codigo) into :ls_codigomax from callejero;

ls_codigomax=string(long(ls_codigomax)+1)

for fila=1 to dw_1.Rowcount()
	if dw_1.GetItemStatus( fila,0, Primary!) = NewModified! then
		dw_1.setitem(fila,'codigo',ls_codigomax)
		ls_codigomax=string(long(ls_codigomax)+1)
	END IF
next
//fin : Asignamos clave primaria a las filas nuevas

if mensaje<>'' then
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno

end event

event open;call super::open;dw_busqueda.insertrow(0)	
inv_resize.of_Register (dw_busqueda, "ScaletoRight")


end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_callejero
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_callejero
end type

type dw_1 from w_mant_simple`dw_1 within w_callejero
integer x = 37
integer y = 660
integer width = 3776
integer height = 912
string dataobject = "d_mant_callejero"
boolean ib_rmbmenu = false
end type

event dw_1::itemchanged;call super::itemchanged;string pob, cod

choose case dwo.name
	case 'cod_pos'
		pob = data + '%'

		SELECT poblaciones.cod_pob INTO :cod FROM poblaciones WHERE poblaciones.cod_pos like :pob ; //and tipo in ('F', 'M');

		if not f_es_vacio(cod) then
			this.post setitem(row, 'cod_pob', cod)
			this.post setitem(row, 'provincia', f_devuelve_cod_provincia(cod))
			this.post setitem(row, 'cod_pos', f_devuelve_cod_postal(cod))
		end if
end choose

end event

event dw_1::pfc_predeleterow;// return
//    0 previene el borrado
//    1 suprime el registro
//   -1 error

//Andr$$HEX1$$e900$$ENDHEX$$s: Borrado. Me parece que no hay que hacer ninguna comprobaci$$HEX1$$f300$$ENDHEX$$n antes de borrar una calle del callejero
//Si hay que comprobar algo siempre se puede copiar el proceso de w_poblaciones

// Si no hay filas para borrar detengo el proceso de borrado
if dw_1.RowCount() = 0 Then return 0


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

event dw_1::retrieveend;call super::retrieveend;//// Modificado por ricardo 28/10/03
//
//// PArece ser que cuando se crean las poblaciones desde la ventana response no pone el codigo de poblacion con lo cual aqu$$HEX1$$ed00$$ENDHEX$$
//// falla por la validacion del preupdate. Y eso produce que no se puedan a$$HEX1$$f100$$ENDHEX$$adir aqu$$HEX2$$ed002000$$ENDHEX$$poblaciones
//long fila
//FOR fila =1 to rowcount
//	if f_es_Vacio(this.GetItemString(fila, 'cod_pob')) then
//		this.setitem(fila, 'cod_pob', this.GetItemString(fila, 'cod_pos'))
//	end if
//NEXT
//
end event

event dw_1::buttonclicked;call super::buttonclicked;string cod_pob,cod_provincia
CHOOSE CASE dwo.name
	CASE 'b_poblacion'
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		cod_pob=f_busqueda_poblaciones()
		if f_es_vacio(cod_pob) then return
		this.SetItem(row,'cod_pob',cod_pob)
		this.setitem(row,'provincia',f_devuelve_cod_provincia(cod_pob))
		this.setitem(row,'cod_pos', f_devuelve_cod_postal(cod_pob))
END CHOOSE

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_callejero
integer y = 1604
end type

event cb_anyadir::clicked;//Andr$$HEX1$$e900$$ENDHEX$$s: No extendemos el script del antecesor

//Inicializamos la cp del dw_1 

string ls_codigomax
long ll_filanueva

ll_filanueva=dw_1.event pfc_addrow()

/*select max(codigo) into :ls_codigomax from callejero;

ls_codigomax=string(long(ls_codigomax)+1)

dw_1.setitem(ll_filanueva,'codigo',ls_codigomax)

*/
end event

type cb_borrar from w_mant_simple`cb_borrar within w_callejero
integer y = 1604
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_callejero
integer y = 1604
end type

type dw_busqueda from u_dw within w_callejero
integer x = 37
integer y = 32
integer width = 2235
integer height = 548
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_calles_consulta_busqueda"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;string ls_sql_old='',ls_sql_nuevo=''
integer li_numero_calle,li_resto

this.accepttext()

ls_sql_old = dw_1.describe("datawindow.table.select")
ls_sql_nuevo=ls_sql_old

//li_numero_calle=integer(this.getitemstring(row,'numero'))
li_numero_calle=this.getitemnumber(row,'numero')

if not isnull(li_numero_calle) and li_numero_calle<>0 then

	li_resto=mod(li_numero_calle,2)

	//si el n$$HEX1$$fa00$$ENDHEX$$mero es impar...
	if li_resto=1 then
		f_sql('n_impar_desde','<=','numero',dw_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
		f_sql('n_impar_hasta','>=','numero',dw_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
	else //el n$$HEX1$$fa00$$ENDHEX$$mero es par
		f_sql('n_par_desde','<=','numero',dw_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
		f_sql('n_par_hasta','>=','numero',dw_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
	end if
	
end if

f_sql('callejero.provincia','LIKE','provincia',dw_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
f_sql('calle','LIKE','calle',dw_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
//f_sql('poblaciones.descripcion','LIKE','poblacion',dw_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
f_sql('cod_ciudad','LIKE','ciudad',dw_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
f_sql('callejero.cod_pos','LIKE','cp',dw_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')


dw_1.modify("datawindow.table.select= ~"" + ls_sql_nuevo + "~"")

//mmm, tal vez seria mejor modficar el datawindow (d_calles_busqueda)
dw_1.Retrieve('%','%')
	
// Restauramos la sql original
dw_1.modify("datawindow.table.select= ~"" + ls_sql_old + "~"")
end event

type dw_temporal from u_dw within w_callejero
boolean visible = false
integer x = 2345
integer y = 548
integer taborder = 11
boolean bringtotop = true
end type

