HA$PBExportHeader$w_busqueda_clientes.srw
forward
global type w_busqueda_clientes from w_busqueda
end type
type dw_3 from u_dw within w_busqueda_clientes
end type
end forward

global type w_busqueda_clientes from w_busqueda
integer width = 2985
integer height = 2008
dw_3 dw_3
end type
global w_busqueda_clientes w_busqueda_clientes

type variables
string sql
end variables

on w_busqueda_clientes.create
int iCurrent
call super::create
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
end on

on w_busqueda_clientes.destroy
call super::destroy
destroy(this.dw_3)
end on

event open;call super::open;string nif

nif=message.stringparm
if nif <> '' then
	dw_3.setitem(1,'nif',nif)
	dw_3.triggerevent ("buttonclicked")
end if

sql = dw_1.describe("datawindow.table.select")

dw_3.SetFocus()
//dw_1.retrieve('%')
end event

event pfc_updatespending;call super::pfc_updatespending;return 0
end event

type cb_recuperar_pantalla from w_busqueda`cb_recuperar_pantalla within w_busqueda_clientes
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_busqueda`cb_guardar_pantalla within w_busqueda_clientes
string tag = "texto=general.guardar_pantalla"
end type

type sle_1 from w_busqueda`sle_1 within w_busqueda_clientes
end type

type dw_2 from w_busqueda`dw_2 within w_busqueda_clientes
integer x = 832
integer y = 544
integer width = 1975
integer height = 92
integer taborder = 50
end type

event dw_2::editchanged;string sql_old, sql_nuevo


sql_old = dw_1.describe("datawindow.table.select")
sql_nuevo = sql_old

if g_activa_multiempresa='S' and g_clientes_utiliza_multiempresa='S' then
	sql_nuevo += " AND clientes.empresa = '" + g_empresa + "'"
	dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
end if
if not f_es_vacio(data) then dw_1.Retrieve(data+'%')

dw_1.modify("datawindow.table.select= ~"" + sql_old + "~"")
end event

type st_1 from w_busqueda`st_1 within w_busqueda_clientes
string tag = "texto=clientes.paramtero_completo"
end type

type st_2 from w_busqueda`st_2 within w_busqueda_clientes
string tag = "texto=clientes.apell_soc_activo_teclear:"
integer y = 544
integer width = 777
integer height = 64
string text = "Apellido/Sociedad activo al teclear:"
end type

type cb_1 from w_busqueda`cb_1 within w_busqueda_clientes
integer y = 1776
integer width = 594
integer taborder = 70
end type

event cb_1::clicked;if dw_1.Rowcount() < 1 then
	//Lanzamos el Btn. Buscar si ha puesto valor en alguno de los campos de consulta
	dw_3.AcceptText()
	IF NOT f_es_vacio(dw_3.GetItemString(1,'nif')) OR &
		NOT f_es_vacio(dw_3.GetItemString(1,'apellido_nombresociedad')) OR &
		NOT f_es_vacio(dw_3.GetItemString(1,'nombre')) THEN 
				dw_3.TriggerEvent("buttonclicked")
	END IF
	
	// Si no ha encontrado ninguno, cerramos la ventana
	if dw_1.Rowcount() < 1 then
			parent.event pfc_close()
			return
	end if
	
end if
closewithreturn(parent,dw_1.GetItemString(dw_1.GetRow(),4))
end event

type cb_2 from w_busqueda`cb_2 within w_busqueda_clientes
integer y = 1776
integer taborder = 80
boolean default = true
end type

type dw_1 from w_busqueda`dw_1 within w_busqueda_clientes
integer x = 37
integer y = 676
integer width = 2894
integer height = 1040
integer taborder = 60
end type

event dw_1::constructor;call super::constructor;// Column header sort
inv_sort.of_SetColumnHeader (true)
// Set to simple sort style
inv_sort.of_SetStyle (2)
end event

event dw_1::pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_debug.enabled = False

end event

type dw_3 from u_dw within w_busqueda_clientes
integer x = 14
integer width = 2853
integer height = 464
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_clientes_consulta_busqueda"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;string sql_old = '', sql_nuevo = '', activa

this.accepttext()
sql_old = dw_1.describe("datawindow.table.select")
if sql_old='' then sql_old = dw_1.describe("datawindow.table.select")
sql_nuevo = sql_old
	
f_sql('nif','LIKE INSIDE','nif',dw_3,sql_nuevo,g_tipo_base_datos,'')
f_sql('apellidos','LIKE INSIDE','apellido_nombresociedad',dw_3,sql_nuevo,g_tipo_base_datos,'')
f_sql('nombre','LIKE INSIDE','nombre',dw_3,sql_nuevo,g_tipo_base_datos,'')

if not f_es_vacio(dw_3.getitemstring(1, 't_tercero')) then
	sql_nuevo = f_sql_join(sql_nuevo, {'( clientes.id_cliente = clientes_terceros.id_cliente )'})
	f_sql('clientes_terceros.c_tercero','LIKE','t_tercero',dw_3,sql_nuevo,g_tipo_base_datos,'')
end if

if g_activa_multiempresa='S' and g_clientes_utiliza_multiempresa='S' then
	sql_nuevo += " AND clientes.empresa = '" + g_empresa + "'"
end if

dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
	
dw_2.setitem(1,1,'')
	
dw_1.Retrieve('%')
	
// Restauramos la sql original
dw_1.modify("datawindow.table.select= ~"" + sql_old + "~"")

end event

event constructor;call super::constructor;this.insertrow(0)
end event

event itemchanged;call super::itemchanged;//this.event buttonclicked(1,1,this.object.b_1)
end event

