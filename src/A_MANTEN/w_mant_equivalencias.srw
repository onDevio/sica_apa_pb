HA$PBExportHeader$w_mant_equivalencias.srw
$PBExportComments$domicilio,cliente,fases,registrosE/S,arquitectos, expedientes, formacion
forward
global type w_mant_equivalencias from w_mant_simple
end type
type dw_busqueda from u_dw within w_mant_equivalencias
end type
type dw_temporal from u_dw within w_mant_equivalencias
end type
end forward

global type w_mant_equivalencias from w_mant_simple
integer width = 3909
integer height = 1948
string title = "Mantenimiento de Equivalencias VU-AT"
dw_busqueda dw_busqueda
dw_temporal dw_temporal
end type
global w_mant_equivalencias w_mant_equivalencias

type variables
string i_sql_nuevo
end variables

on w_mant_equivalencias.create
int iCurrent
call super::create
this.dw_busqueda=create dw_busqueda
this.dw_temporal=create dw_temporal
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_busqueda
this.Control[iCurrent+2]=this.dw_temporal
end on

on w_mant_equivalencias.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_busqueda)
destroy(this.dw_temporal)
end on

event open;call super::open;dw_busqueda.insertrow(0)	
inv_resize.of_Register (dw_busqueda, "ScaletoRight")


end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_mant_equivalencias
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_mant_equivalencias
end type

type dw_1 from w_mant_simple`dw_1 within w_mant_equivalencias
integer x = 37
integer y = 348
integer width = 3776
integer height = 1244
string dataobject = "d_mant_equivalencias"
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

type cb_anyadir from w_mant_simple`cb_anyadir within w_mant_equivalencias
integer y = 1604
end type

event cb_anyadir::clicked;
long ll_filanueva

ll_filanueva=dw_1.event pfc_addrow()




end event

type cb_borrar from w_mant_simple`cb_borrar within w_mant_equivalencias
integer y = 1604
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_mant_equivalencias
integer y = 1604
end type

type dw_busqueda from u_dw within w_mant_equivalencias
integer x = 37
integer y = 32
integer width = 2235
integer height = 308
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_equivalencias_busqueda"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;string ls_sql_old='',ls_sql_nuevo='', ls_descripcion, ls_grupo

this.accepttext()

ls_sql_old = dw_1.describe("datawindow.table.select")
ls_sql_nuevo=ls_sql_old

ls_descripcion=this.getitemstring(row,'nombre')
ls_grupo = this.getitemstring(row,"grupo")

if not isnull(ls_descripcion) and ls_descripcion<>"" then

	f_sql('equivalencias.descripcion','LIKE','nombre',dw_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
	
end if

if not isnull(ls_grupo) and ls_grupo<>"" then

	f_sql('equivalencias.grupo','LIKE','grupo',dw_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
	
end if

dw_1.modify("datawindow.table.select= ~"" + ls_sql_nuevo + "~"")

dw_1.Retrieve()
	
// Restauramos la sql original
dw_1.modify("datawindow.table.select= ~"" + ls_sql_old + "~"")
end event

event clicked;call super::clicked;datawindowchild   ldwc_grupo


if dwo.name = "grupo" then
	this.getchild("grupo", ldwc_grupo)
	ldwc_grupo.settransobject(sqlca)
	ldwc_grupo.retrieve()
end if
end event

type dw_temporal from u_dw within w_mant_equivalencias
boolean visible = false
integer x = 2345
integer y = 548
integer taborder = 11
boolean bringtotop = true
end type

