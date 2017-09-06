HA$PBExportHeader$w_cobros_vencimiento.srw
forward
global type w_cobros_vencimiento from w_response
end type
type dw_1 from u_dw within w_cobros_vencimiento
end type
type dw_2 from u_dw within w_cobros_vencimiento
end type
type cb_1 from commandbutton within w_cobros_vencimiento
end type
type cb_2 from commandbutton within w_cobros_vencimiento
end type
type cb_3 from commandbutton within w_cobros_vencimiento
end type
type cb_marcar from commandbutton within w_cobros_vencimiento
end type
type cb_desmarcar from commandbutton within w_cobros_vencimiento
end type
end forward

global type w_cobros_vencimiento from w_response
integer width = 4174
integer height = 1668
string title = "Reclamaci$$HEX1$$f300$$ENDHEX$$n de deudas"
boolean controlmenu = false
dw_1 dw_1
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_marcar cb_marcar
cb_desmarcar cb_desmarcar
end type
global w_cobros_vencimiento w_cobros_vencimiento

on w_cobros_vencimiento.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_marcar=create cb_marcar
this.cb_desmarcar=create cb_desmarcar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.cb_marcar
this.Control[iCurrent+7]=this.cb_desmarcar
end on

on w_cobros_vencimiento.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_marcar)
destroy(this.cb_desmarcar)
end on

event open;f_centrar_ventana(this)

// Indicamos que queremos cambiar el idioma
if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)


dw_2.insertrow(0)
dw_2.setitem(1,'f_vencimiento',datetime(today()))
dw_2.setitem(1,'f_carta', datetime(today()))
//dw_1.retrieve(datetime(today()),'%')
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_cobros_vencimiento
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_cobros_vencimiento
string tag = "texto=cobros.guardar_pantalla"
end type

type dw_1 from u_dw within w_cobros_vencimiento
integer x = 37
integer y = 484
integer width = 4069
integer height = 956
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_cobros_venc"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;int i


choose case dwo.name
	case 'activo'
			
			for i = 1 to this.rowcount()
				if this.getitemstring(i,'n_col') = this.getitemstring(this.getrow(),'n_col') then
					if data ='S' then
						dw_1.setitem(i, 'activo', 'S')
					else
						dw_1.setitem(i, 'activo', 'N')
					end if
				end if
			next
		
		
		
end choose
end event

event constructor;call super::constructor;//this.of_SetSort(TRUE)
//this.of_SetProperty(TRUE)
//this.of_SetTransObject(SQLCA)
//
//// Column header sort
//inv_sort.of_SetColumnHeader (true)
//
//// Extended filter style
////inv_filter.of_SetStyle (1)
//
//// Set to simple sort style
//inv_sort.of_SetStyle (2)
end event

event retrievestart;call super::retrievestart;// Indicamos que queremos cambiar el idioma
if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)

end event

type dw_2 from u_dw within w_cobros_vencimiento
integer x = 37
integer y = 16
integer width = 2176
integer height = 420
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_cobros_f_vencimiento"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;

this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event itemchanged;choose case dwo.name
	case 'f_vencimiento'
			dw_2.accepttext()
			datetime fecha
			dw_2.setitem(1,'f_vencimiento',data)
			
	case	'todos'
		
end choose
	


end event

event buttonclicked;call super::buttonclicked;string id_persona,nif,id_cliente_pagador

choose case dwo.name
	case 'b1'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_persona=f_busqueda_colegiados()
		this.setitem(1,'n_colegiado',f_colegiado_n_col(id_persona))
	case 'b_nif'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Clientes de Expedientes"
		g_busqueda.dw="d_lista_busqueda_clientes"
		id_persona=f_busqueda_clientes_exp()
		if id_persona="-1" then
				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de cliente v$$HEX1$$e100$$ENDHEX$$lido.')
				this.setfocus()
				return -1
		else
			nif = f_dame_nif(id_persona)
			this.SetItem(1,'nif',nif)
			this.SetItem(1,'nombre_cliente',f_dame_cliente(id_persona))
		end if
end choose
	

end event

type cb_1 from commandbutton within w_cobros_vencimiento
string tag = "texto=cobros.buscar"
integer x = 2432
integer y = 32
integer width = 320
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Buscar"
end type

event clicked;call super::clicked;datetime fecha,f_desde,f_hasta
date f_hasta_date
string n_colegiado, alta_baja,nif
string sql,sql_original


dw_2.accepttext()
sql=dw_1.GetSQLSelect()
sql_original=sql

fecha       = dw_2.getitemdatetime(1,'f_vencimiento')
n_colegiado = dw_2.getitemstring(1,'n_colegiado')
alta_baja   = dw_2.getitemstring(1,'alta_baja')
nif = dw_2.getitemstring(1,'nif')

f_sql('csi_facturas_emitidas.fecha','>=','f_fact_desde',dw_2,sql,'1','')
f_sql('csi_facturas_emitidas.fecha','<','f_fact_hasta',dw_2,sql,'1','')
f_sql('csi_facturas_emitidas.nif_pagador','=','nif',dw_2,sql,'1','')

dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
dw_1.SetTransobject(sqlca)

if f_es_vacio(n_colegiado) then
	n_colegiado = '%'
end if



dw_1.retrieve(fecha, n_colegiado, alta_baja,g_empresa)	
// Indicamos que queremos cambiar el idioma
if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)
end event

type cb_2 from commandbutton within w_cobros_vencimiento
string tag = "texto=general.aceptar"
integer x = 3173
integer y = 1456
integer width = 453
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
end type

event clicked;call super::clicked;int i, ll_new
string nombre, mes,  ciudad, id_col, ls_nombre_objeto
datetime m
datastore ds_reclamo

dw_2.accepttext()
ds_reclamo            = create datastore
ls_nombre_objeto = g_hoja_reclamo_recibos_impagados
IF f_es_vacio(ls_nombre_objeto) THEN ls_nombre_objeto = 'd_cobros_carta_reclamo'
ds_reclamo.dataobject = ls_nombre_objeto
ds_reclamo.settransobject(SQLCA)

if g_activa_multiempresa = 'S' then f_logo_empresa_ds(g_empresa ,ds_reclamo, '007') 

ciudad = g_col_ciudad
m = dw_2.getitemdatetime(1, 'f_carta')
	 mes =Lower(f_obtener_mes(m))
	
for i = 1 to dw_1.rowcount()

	if dw_1.getitemstring(i, 'activo') = 'S' then
		nombre = dw_1.getitemstring(i, 'nombre')
		id_col = dw_1.getitemstring(i,'id_colegiado')
		ll_new = ds_reclamo.insertrow(0)
		g_idioma.of_cambia_textos_ds(ds_reclamo)
		ds_reclamo.setitem(ll_new,'asunto', dw_1.getitemstring(i, 'asunto'))
		ds_reclamo.setitem(ll_new,'fecha', dw_2.getitemdatetime(1, 'f_carta'))
		ds_reclamo.setitem(ll_new,'n_fact', dw_1.getitemstring(i, 'n_fact'))
		ds_reclamo.setitem(ll_new,'f_factura', dw_1.getitemdatetime(i, 'fecha_fact'))
		ds_reclamo.setitem(ll_new,'importe', dw_1.getitemdecimal(i, 'importe'))
		ds_reclamo.setitem(ll_new,'f_vencimiento', dw_1.getitemdatetime(i, 'f_vencimiento'))
		ds_reclamo.setitem(ll_new,'n_col', dw_1.getitemstring(i, 'n_col') )
		ds_reclamo.setitem(ll_new,'mes',mes)
		ds_reclamo.setitem(ll_new,'ciudad',ciudad)
		ds_reclamo.setitem(ll_new,'colegiado', nombre)
		ds_reclamo.setitem(ll_new,'domicilio', f_domicilio_activo(id_col))
		ds_reclamo.setitem(ll_new,'poblacion', f_poblacion_activa(id_col))
		ds_reclamo.setitem(ll_new,'banco_defecto', g_banco_por_defecto)
		if i < dw_1.rowcount() then
			if (nombre <> dw_1.getitemstring((i+1), 'nombre')) or (dw_1.getitemstring(i, 'n_col')<>dw_1.getitemstring((i+1), 'n_col')) then
				// Indicamos que queremos cambiar el idioma
				if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(ds_reclamo)
				ds_reclamo.print()
				ds_reclamo.reset()
			end if
		else
			// Indicamos que queremos cambiar el idioma
			if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(ds_reclamo)
			ds_reclamo.print()
		end if
	end if
next



end event

type cb_3 from commandbutton within w_cobros_vencimiento
string tag = "texto=general.cancelar"
integer x = 3653
integer y = 1456
integer width = 453
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
end type

event clicked;close(parent)
end event

type cb_marcar from commandbutton within w_cobros_vencimiento
string tag = "texto=cobros.marcar_todos"
integer x = 37
integer y = 1456
integer width = 411
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Marcar todos"
end type

event clicked;int i

for i = 1 to dw_1.rowcount()
	dw_1.setitem(i, 'activo', 'S')
next
end event

type cb_desmarcar from commandbutton within w_cobros_vencimiento
string tag = "texto=cobros.desmarcar_todos"
integer x = 448
integer y = 1456
integer width = 411
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Desmarcar todos"
end type

event clicked;int i

for i = 1 to dw_1.rowcount()
	dw_1.setitem(i, 'activo', 'N')
next
end event

