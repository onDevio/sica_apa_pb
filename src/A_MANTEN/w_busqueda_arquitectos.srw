HA$PBExportHeader$w_busqueda_arquitectos.srw
forward
global type w_busqueda_arquitectos from w_response
end type
type cb_3 from commandbutton within w_busqueda_arquitectos
end type
type cb_devolver from commandbutton within w_busqueda_arquitectos
end type
type dw_1 from u_dw within w_busqueda_arquitectos
end type
type cb_1 from commandbutton within w_busqueda_arquitectos
end type
type dw_busqueda from u_dw within w_busqueda_arquitectos
end type
end forward

global type w_busqueda_arquitectos from w_response
integer width = 2199
integer height = 1396
boolean ib_isupdateable = false
cb_3 cb_3
cb_devolver cb_devolver
dw_1 dw_1
cb_1 cb_1
dw_busqueda dw_busqueda
end type
global w_busqueda_arquitectos w_busqueda_arquitectos

on w_busqueda_arquitectos.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_devolver=create cb_devolver
this.dw_1=create dw_1
this.cb_1=create cb_1
this.dw_busqueda=create dw_busqueda
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_devolver
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_busqueda
end on

on w_busqueda_arquitectos.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_devolver)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.dw_busqueda)
end on

event open;call super::open;dw_busqueda.insertrow(0)
f_centrar_ventana(this)


end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_busqueda_arquitectos
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_busqueda_arquitectos
end type

type cb_3 from commandbutton within w_busqueda_arquitectos
string tag = "texto=general.cancelar"
integer x = 1157
integer y = 1192
integer width = 402
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
end type

event clicked;close(parent)
end event

type cb_devolver from commandbutton within w_busqueda_arquitectos
string tag = "texto=general.aceptar"
integer x = 443
integer y = 1192
integer width = 571
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar : Devolver valor"
end type

event clicked;closewithreturn(parent, (dw_1.getitemstring(dw_1.getrow(), 'id_arquitecto')))
end event

type dw_1 from u_dw within w_busqueda_arquitectos
integer x = 14
integer y = 232
integer width = 2135
integer height = 936
integer taborder = 30
string dataobject = "d_arquitectos_busqueda"
boolean hscrollbar = true
end type

event dw_1::pfc_insertrow;call super::pfc_insertrow;STRING ID
id = f_siguiente_numero('ID_ARQUITECTOS', 10)
dw_1.setitem(ancestorreturnvalue, 'id_arquitecto', id)
return ancestorreturnvalue
end event

event dw_1::pfc_addrow;call super::pfc_addrow;STRING ID
id = f_siguiente_numero('ID_ARQUITECTOS', 10)
dw_1.setitem(ancestorreturnvalue, 'id_arquitecto', id)
return ancestorreturnvalue
end event

event doubleclicked;call super::doubleclicked;cb_devolver.triggerevent(clicked!)
end event

event constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)
this.of_SetTransObject(SQLCA)

// Column header sort
inv_sort.of_SetColumnHeader (true)

// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_debug.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_delete.enabled = False
end event

type cb_1 from commandbutton within w_busqueda_arquitectos
string tag = "texto=general.buscar"
integer x = 1865
integer y = 28
integer width = 293
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Buscar"
end type

event clicked;string sql_old = '', sql_nuevo = '', activa

dw_busqueda.accepttext()

sql_old = dw_1.describe("datawindow.table.select")
sql_nuevo = sql_old

f_sql('apellidos','LIKE','apellidos',dw_busqueda,sql_nuevo,g_tipo_base_datos,'')
f_sql('nombre','LIKE','nombre',dw_busqueda,sql_nuevo,g_tipo_base_datos,'')
//f_sql('tipo_persona','LIKE','tipo_persona',Parent.dw_3,sql_nuevo,'1','')

dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")

//dw_busqueda.setitem(1,1,'')
//dw_busqueda.setitem(1,2,'')

dw_1.Retrieve()//'%')

// Restauramos la sql original
dw_1.modify("datawindow.table.select= ~"" + sql_old + "~"")

end event

type dw_busqueda from u_dw within w_busqueda_arquitectos
integer y = 24
integer width = 1865
integer height = 184
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mant_arquitectos_busqueda"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

