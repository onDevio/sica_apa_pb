HA$PBExportHeader$w_clientes_lista.srw
forward
global type w_clientes_lista from w_lista
end type
type cb_depurar_clientes from commandbutton within w_clientes_lista
end type
type dw_tipo_tercero from u_dw within w_clientes_lista
end type
end forward

global type w_clientes_lista from w_lista
integer width = 3547
integer height = 1588
string title = "Lista Previa de Terceros"
string menuname = "m_lista_clientes"
event csd_genera_facturas_personal ( )
cb_depurar_clientes cb_depurar_clientes
dw_tipo_tercero dw_tipo_tercero
end type
global w_clientes_lista w_clientes_lista

event csd_genera_facturas_personal;openwithparm(w_colegiados_factura_n, 'CLI')
end event

on w_clientes_lista.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_lista_clientes" then this.MenuID = create m_lista_clientes
this.cb_depurar_clientes=create cb_depurar_clientes
this.dw_tipo_tercero=create dw_tipo_tercero
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_depurar_clientes
this.Control[iCurrent+2]=this.dw_tipo_tercero
end on

on w_clientes_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_depurar_clientes)
destroy(this.dw_tipo_tercero)
end on

event activate;call super::activate;g_dw_lista  = dw_lista
g_w_lista   = g_lista_clientes
g_w_detalle = g_detalle_clientes
g_lista     = 'w_clientes_lista'
g_detalle   = 'w_clientes_detalle'
cb_depurar_clientes.visible = TRUE
end event

event csd_consulta;call super::csd_consulta;//Abrimos la ventana de consulta
open(w_clientes_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()
end event

event csd_nuevo;call super::csd_nuevo;opensheet(g_detalle_clientes, g_detalle, w_aplic_frame, 0, original!)
end event

event pfc_postopen;call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_clientes = dw_lista
end event

event csd_detalle;call super::csd_detalle;if dw_lista.getrow() < 1 then return
SetPointer(HourGlass!)
//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
g_clientes_consulta.id_cliente = dw_lista.getitemstring(dw_lista.getrow(),'clientes_id_cliente')
message.stringparm = "w_clientes_detalle"
w_aplic_frame.postevent("csd_clientesdetalle")

end event

event csd_listados;call super::csd_listados;open(w_clientes_listados)
end event

event open;call super::open;inv_resize.of_Register (cb_depurar_clientes, "FixedtoRight&Bottom")
inv_resize.of_register (dw_tipo_tercero,"FixedtoBottom")

end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_clientes_lista
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_clientes_lista
string tag = "texto=general.guardar_pantalla"
end type

type st_1 from w_lista`st_1 within w_clientes_lista
integer x = 37
integer y = 1276
end type

type dw_lista from w_lista`dw_lista within w_clientes_lista
integer x = 37
integer y = 32
integer width = 3447
integer height = 1104
string dataobject = "d_clientes_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_lista::retrieveend;call super::retrieveend;SetPointer(Arrow!)
this.PostEvent(Rowfocuschanged!)
end event

event dw_lista::rowfocuschanged;call super::rowfocuschanged;if this.rowcount() = 0 then return
dw_tipo_tercero.retrieve(dw_lista.getitemstring(dw_lista.getrow(),'clientes_id_cliente'))

end event

event dw_lista::csd_retrieve;string  sql_original, sql_nuevo

dw_tipo_tercero.reset()

// Se asigna a variable que se utilizara para actualizar la lista (desde menu)
sql_original = dw_lista.describe("datawindow.table.select")

//sql_original += " and empresa = '" +  g_empresa + "'"

// Codigo original de w_lista
///*** Modificado por Alexis porque no respetaba las sql_originales y manten$$HEX1$$ed00$$ENDHEX$$a los filtros. A parte
// no se pod$$HEX1$$ed00$$ENDHEX$$a actualizar el listado. CGI-162. 29/03/2010 ******/// 
i_sentencia_sql_lista = sql_original
dw_lista.modify("DataWindow.Table.Select= ~"" + sql_original + "~"")
dw_lista.Retrieve()
This.modify("DataWindow.Table.Select= ~"" + i_sql_original + "~"")
end event

type cb_consulta from w_lista`cb_consulta within w_clientes_lista
string tag = "texto=general.consultar"
end type

type cb_detalle from w_lista`cb_detalle within w_clientes_lista
string tag = "texto=general.detalle"
end type

type cb_ayuda from w_lista`cb_ayuda within w_clientes_lista
string tag = "texto=general.ayuda"
end type

type cb_depurar_clientes from commandbutton within w_clientes_lista
string tag = "texto=general.depurar"
integer x = 3141
integer y = 1256
integer width = 343
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Depurar"
end type

event clicked;string id_cliente
long la_fila

if g_dw_lista.rowcount()=0 then return 

open(w_clientes_depuracion)

id_cliente = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'clientes_id_cliente')
w_clientes_depuracion.dynamic trigger event csd_refrescar_cliente(id_cliente)


//// Lo mandamos al primer registro
//// Comprobamos que la ventana "lista previa" del m$$HEX1$$f300$$ENDHEX$$dulo est$$HEX2$$e1002000$$ENDHEX$$abierta
//la_fila = 1
//g_dw_lista.SetRow(la_fila)
//g_dw_lista.ScrollToRow(la_fila)
//id_cliente = g_dw_lista.getitemstring(la_fila, 'clientes_id_cliente')
//w_clientes_depuracion.dynamic trigger event csd_refrescar_cliente(id_cliente)
end event

event constructor;CHOOSE CASE g_colegio 
	CASE 'COAATLR', 'COAATTFE', 'COAATZ', 'COAATGU', 'COAATGC', 'COAATLE', 'COAATAVI'
		this.visible = true
	CASE else
		this.visible = false
END CHOOSE

end event

type dw_tipo_tercero from u_dw within w_clientes_lista
integer x = 517
integer y = 1152
integer width = 1321
integer height = 200
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_clientes_lista_t_terceros"
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

