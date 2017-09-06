HA$PBExportHeader$w_listados.srw
$PBExportComments$MADRE DE LAS VENTANAS DE LISTADOS
forward
global type w_listados from w_response
end type
type cb_limpiar from commandbutton within w_listados
end type
type dw_listados_varios from datawindow within w_listados
end type
type cb_ver from commandbutton within w_listados
end type
type cb_salir from commandbutton within w_listados
end type
type dw_listados from u_dw within w_listados
end type
type cb_imprimir from commandbutton within w_listados
end type
type cb_zoom from commandbutton within w_listados
end type
type cb_esp from commandbutton within w_listados
end type
type cb_guardar from commandbutton within w_listados
end type
type cb_escala from commandbutton within w_listados
end type
type cb_ordenar from commandbutton within w_listados
end type
type dw_listados_titulo from u_dw within w_listados
end type
type dw_1 from u_dw within w_listados
end type
end forward

global type w_listados from w_response
integer x = 9
integer y = 312
integer width = 3685
integer height = 1772
string title = "LISTADOS"
windowstate windowstate = maximized!
cb_limpiar cb_limpiar
dw_listados_varios dw_listados_varios
cb_ver cb_ver
cb_salir cb_salir
dw_listados dw_listados
cb_imprimir cb_imprimir
cb_zoom cb_zoom
cb_esp cb_esp
cb_guardar cb_guardar
cb_escala cb_escala
cb_ordenar cb_ordenar
dw_listados_titulo dw_listados_titulo
dw_1 dw_1
end type
global w_listados w_listados

on w_listados.create
int iCurrent
call super::create
this.cb_limpiar=create cb_limpiar
this.dw_listados_varios=create dw_listados_varios
this.cb_ver=create cb_ver
this.cb_salir=create cb_salir
this.dw_listados=create dw_listados
this.cb_imprimir=create cb_imprimir
this.cb_zoom=create cb_zoom
this.cb_esp=create cb_esp
this.cb_guardar=create cb_guardar
this.cb_escala=create cb_escala
this.cb_ordenar=create cb_ordenar
this.dw_listados_titulo=create dw_listados_titulo
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_limpiar
this.Control[iCurrent+2]=this.dw_listados_varios
this.Control[iCurrent+3]=this.cb_ver
this.Control[iCurrent+4]=this.cb_salir
this.Control[iCurrent+5]=this.dw_listados
this.Control[iCurrent+6]=this.cb_imprimir
this.Control[iCurrent+7]=this.cb_zoom
this.Control[iCurrent+8]=this.cb_esp
this.Control[iCurrent+9]=this.cb_guardar
this.Control[iCurrent+10]=this.cb_escala
this.Control[iCurrent+11]=this.cb_ordenar
this.Control[iCurrent+12]=this.dw_listados_titulo
this.Control[iCurrent+13]=this.dw_1
end on

on w_listados.destroy
call super::destroy
destroy(this.cb_limpiar)
destroy(this.dw_listados_varios)
destroy(this.cb_ver)
destroy(this.cb_salir)
destroy(this.dw_listados)
destroy(this.cb_imprimir)
destroy(this.cb_zoom)
destroy(this.cb_esp)
destroy(this.cb_guardar)
destroy(this.cb_escala)
destroy(this.cb_ordenar)
destroy(this.dw_listados_titulo)
destroy(this.dw_1)
end on

event open;call super::open;dw_listados.event pfc_addrow()
dw_listados_titulo.event pfc_addrow()
dw_listados_titulo.visible = true

//A poner en w_modulo_listados
//dw_listados_varios.SetTrans(sqlca)
//dw_listados_varios.retrieve(this.classname())
//dw_listados_varios.SetRow(1)

dw_listados.PostEvent("csd_oculta")

of_SetResize (true)
inv_resize.of_Register (cb_ver, "FixedtoTop")
inv_resize.of_Register (cb_salir, "FixedtoTop")
inv_resize.of_Register (cb_imprimir, "FixedtoTop")
inv_resize.of_Register (cb_guardar, "FixedtoTop")
inv_resize.of_Register (cb_zoom, "FixedtoTop")
inv_resize.of_Register (cb_esp, "FixedtoTop")
inv_resize.of_Register (dw_listados_titulo, "FixedtoBottom")
inv_resize.of_Register (dw_1, "ScaletoRight&Bottom")

if g_usar_idioma = "S" then
	this.title = g_idioma.of_getmsg( "Listados", "LISTADOS" )
end if
end event

event pfc_preclose;dw_listados.ResetUpdate()
return 1
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_listados
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_listados
end type

type cb_limpiar from commandbutton within w_listados
boolean visible = false
integer x = 777
integer y = 1348
integer width = 539
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Limpiar Consulta"
end type

event clicked;// borraremos los datos que tenga la consulta
parent.dw_listados.deleterow(0)
parent.dw_listados.event pfc_addrow()

end event

type dw_listados_varios from datawindow within w_listados
integer x = 2432
integer y = 216
integer width = 1202
integer height = 1096
integer taborder = 20
string title = "none"
string dataobject = "d_listados_varios"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;dw_listados.triggerEvent("csd_oculta")

end event

event doubleclicked;parent.cb_ver.triggerevent(clicked!)
end event

type cb_ver from commandbutton within w_listados
event csd_titulo ( )
string tag = "texto=general.visualizar"
integer x = 37
integer y = 28
integer width = 366
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Visualizar"
end type

event csd_titulo();// Cambiamos el titulo del listado si el usuario ha introducido algo
dw_listados_titulo.accepttext()
if not f_es_vacio(dw_listados_titulo.getitemstring(1, 'titulo')) then
	if lower(dw_1.describe("st_titulo_listado.name")) = 'st_titulo_listado' then
		dw_1.object.st_titulo_listado.text = dw_listados_titulo.getitemstring(1, 'titulo')
	end if
end if

end event

event clicked;g_etiquetas_listados = ''
g_parametros_listados = ''
g_num_params_listados = 0

// Tenemos que hacerlo cuando est$$HEX2$$e9002000$$ENDHEX$$visible
post event csd_titulo()
// Indicamos que queremos cambiar el idioma
//string sql
//
//dw_listados.Accepttext()
//dw_1.of_SetPrintPreview(TRUE)
//
////Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
//listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
//dw_1.dataobject = listado


//dw_1.of_settransobject(sqlca)
//sql = dw_1.describe("Datawindow.Table.Select")
//
////Hacer f_sql de todos los campos de la dw_listados
//
//dw_1.SetTransobject(sqlca)
//dw_1.Modify('Datawindow.table.Select"'+sql+'"')
//dw_1.retrieve()
//
////Al final:
//if dw_1.RowCount() > 0 then
//	dw_1.visible = true
//	this.enabled = false
//	cb_zoom.enabled = true
//	cb_imprimir.enabled = true
//	cb_guardar.enabled = true
//else
//	messagebox(g_titulo,'No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.')
//end if	
//	
//


end event

type cb_salir from commandbutton within w_listados
string tag = "texto=general.salir"
integer x = 3259
integer y = 28
integer width = 375
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;if dw_1.visible then
	dw_1.visible = false
	dw_1.Reset()
	cb_zoom.enabled = false
	cb_escala.enabled = false
	cb_imprimir.enabled = false
	cb_guardar.enabled = false
	cb_ver.enabled = true
	//
	cb_ordenar.enabled=false
	dw_listados.SetFocus()
else
	close(parent)
end if
end event

type dw_listados from u_dw within w_listados
event csd_oculta ( )
integer x = 37
integer y = 216
integer width = 2039
integer height = 1096
integer taborder = 10
string dataobject = "d_listados"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event csd_oculta;// Para que si hay campos que ten$$HEX1$$ed00$$ENDHEX$$an valores y que se ocultan para un tipo de listado no aparezcan
//		en el listado, borraremos los datos que tenga la consulta
//parent.dw_listados.deleterow(0)
//parent.dw_listados.event pfc_addrow()

if dw_listados_varios.RowCount() = 0 then return


end event

event constructor;call super::constructor;// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = False
end event

type cb_imprimir from commandbutton within w_listados
string tag = "texto=general.imprimir"
integer x = 1609
integer y = 28
integer width = 375
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Imprimir"
end type

event clicked;//dw_1.Print()
//f_opciones_impresion(dw_1)
string titulo
n_csd_impresion_formato uo_impresion
uo_impresion=create n_csd_impresion_formato

dw_1.AcceptText()
titulo=dw_listados_titulo.getitemstring(1, 'titulo')
if f_es_vacio(titulo) then 
	uo_impresion.nombre='LISTADO'
	titulo=''
else
	uo_impresion.nombre=titulo
end if
uo_impresion.copias=1
uo_impresion.generar_registro='X'

uo_impresion.asunto_email='LISTADO '+titulo
uo_impresion.asunto_registro='LISTADO '+titulo
//uo_impresion.receptor='AYUNTAMIENTO DE '+pobla

uo_impresion.serie='LISTADOS'
uo_impresion.dw=dw_1
uo_impresion.visualizar_web = 'N'
uo_impresion.email = 'N'
uo_impresion.pdf= 'X'
uo_impresion.papel='S'
uo_impresion.sms='X'
uo_impresion.ruta_automatica=true
uo_impresion.ruta_relativa1=''
uo_impresion.ruta_relativa2=string(year(today()))
uo_impresion.ruta_relativa3=''
if uo_impresion.f_opciones_impresion()>0 then uo_impresion.f_impresion()
end event

type cb_zoom from commandbutton within w_listados
string tag = "texto=general.zoom"
integer x = 430
integer y = 28
integer width = 375
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Zoom"
end type

event clicked;dw_1.Event pfc_zoom()
end event

type cb_esp from commandbutton within w_listados
string tag = "texto=general.especificar_imp"
integer x = 2002
integer y = 28
integer width = 704
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Especificar Impresora"
end type

event clicked;PrintSetup()
end event

type cb_guardar from commandbutton within w_listados
string tag = "texto=general.guardar_como"
integer x = 2725
integer y = 28
integer width = 517
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Guardar como..."
end type

event clicked;dw_1.Saveas()
end event

type cb_escala from commandbutton within w_listados
string tag = "texto=general.escala"
integer x = 823
integer y = 28
integer width = 375
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Escala"
end type

event clicked;dw_1.Event pfc_scale()
end event

type cb_ordenar from commandbutton within w_listados
string tag = "texto=general.ordenar"
integer x = 1216
integer y = 28
integer width = 375
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Ordenar"
end type

event clicked;dw_1.event csd_elegirOrdenacion()
end event

type dw_listados_titulo from u_dw within w_listados
boolean visible = false
integer x = 27
integer y = 1432
integer width = 3397
integer height = 172
integer taborder = 20
string dataobject = "d_listados_titulo"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_1 from u_dw within w_listados
event csd_elegirordenacion ( )
boolean visible = false
integer x = 37
integer y = 160
integer width = 3598
integer height = 1444
integer taborder = 20
boolean bringtotop = true
boolean hscrollbar = true
end type

event csd_elegirordenacion();this.event pfc_sortDlg()
// Indicamos que queremos cambiar el idioma

end event

event constructor;call super::constructor;of_SetPrintPreview(TRUE)
of_setSort(true)
inv_sort.of_SetColumnHeader (true)
this.inv_sort.of_SetStyle(this.inv_sort.DRAGDROP)


end event

