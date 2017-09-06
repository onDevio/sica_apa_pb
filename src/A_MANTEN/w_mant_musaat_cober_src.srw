HA$PBExportHeader$w_mant_musaat_cober_src.srw
$PBExportComments$domicilio,cliente,fases,registrosE/S,arquitectos, expedientes, formacion
forward
global type w_mant_musaat_cober_src from w_mant_simple
end type
type dw_busqueda from u_dw within w_mant_musaat_cober_src
end type
type dw_temporal from u_dw within w_mant_musaat_cober_src
end type
end forward

global type w_mant_musaat_cober_src from w_mant_simple
integer x = 214
integer y = 221
integer width = 2821
integer height = 1948
string title = "Mantenimiento de Coberturas"
dw_busqueda dw_busqueda
dw_temporal dw_temporal
end type
global w_mant_musaat_cober_src w_mant_musaat_cober_src

type variables
string i_sql_nuevo
end variables

on w_mant_musaat_cober_src.create
int iCurrent
call super::create
this.dw_busqueda=create dw_busqueda
this.dw_temporal=create dw_temporal
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_busqueda
this.Control[iCurrent+2]=this.dw_temporal
end on

on w_mant_musaat_cober_src.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_busqueda)
destroy(this.dw_temporal)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje, ls_codigo,cadenas[] 
int  res, retorno=1
long fila

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

event open;call super::open;dw_busqueda.insertrow(0)	
inv_resize.of_Register (dw_busqueda, "ScaletoRight")


end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_mant_musaat_cober_src
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_mant_musaat_cober_src
end type

type dw_1 from w_mant_simple`dw_1 within w_mant_musaat_cober_src
integer x = 37
integer y = 316
integer width = 2688
integer height = 1256
string dataobject = "d_mant_musaat_src_cobertura"
boolean ib_rmbmenu = false
end type

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

type cb_anyadir from w_mant_simple`cb_anyadir within w_mant_musaat_cober_src
integer y = 1604
end type

event cb_anyadir::clicked;
long ll_filanueva

ll_filanueva=dw_1.event pfc_addrow()




end event

type cb_borrar from w_mant_simple`cb_borrar within w_mant_musaat_cober_src
integer y = 1604
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_mant_musaat_cober_src
boolean visible = false
integer y = 1604
end type

type dw_busqueda from u_dw within w_mant_musaat_cober_src
integer x = 5
integer y = 32
integer width = 2720
integer height = 280
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mant_musaat_src_cobertura_busq"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;string ls_sql_old='',ls_sql_nuevo='', ls_nombre

this.accepttext()

ls_sql_old = dw_1.describe("datawindow.table.select")
ls_sql_nuevo=ls_sql_old
//
//ls_nombre=this.getitemstring(row,'nombre')

//if not isnull(ls_nombre) and ls_nombre<>"" then
	
	f_sql('musaat_cober_src.cod_s','LIKE','cod_s',dw_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
	f_sql('musaat_cober_src.t_poliza','LIKE','t_poliza',dw_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
	f_sql('musaat_cober_src.activo','LIKE','activo',dw_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
	
//end if


dw_1.modify("datawindow.table.select= ~"" + ls_sql_nuevo + "~"")

dw_1.Retrieve()
	
// Restauramos la sql original
dw_1.modify("datawindow.table.select= ~"" + ls_sql_old + "~"")
end event

type dw_temporal from u_dw within w_mant_musaat_cober_src
boolean visible = false
integer x = 2345
integer y = 548
integer taborder = 11
boolean bringtotop = true
end type

