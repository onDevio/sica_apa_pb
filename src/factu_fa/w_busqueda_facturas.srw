HA$PBExportHeader$w_busqueda_facturas.srw
forward
global type w_busqueda_facturas from w_busqueda
end type
type dw_3 from u_dw within w_busqueda_facturas
end type
type cb_buscar from commandbutton within w_busqueda_facturas
end type
end forward

global type w_busqueda_facturas from w_busqueda
integer width = 2990
integer height = 2008
event csd_consulta_facturas ( )
dw_3 dw_3
cb_buscar cb_buscar
end type
global w_busqueda_facturas w_busqueda_facturas

type variables
string sql
end variables

event csd_consulta_facturas();//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo,sql_principal, ls_msg, sql_aux

dw_1.Accepttext()

sql_principal = dw_1.describe("datawindow.table.select")
sql_nuevo = dw_1.describe("datawindow.table.select")

f_sql('csi_facturas_emitidas.n_fact','LIKE','n_fact',dw_3,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.tipo_factura','LIKE','tipo_factura',dw_3,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.n_col','LIKE','n_col',dw_3,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.nif','LIKE','nif',dw_3,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.fecha','>=','fecha_desde',dw_3,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.fecha','<','fecha_hasta',dw_3,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.n_fact','LIKE','n_col_honorario',dw_3,sql_nuevo,'1','')


//Empresa
if PosA(upper(sql_nuevo), "WHERE") > 0 then
	sql_aux = "and csi_facturas_emitidas.empresa ='"+g_empresa+"'"
else
	sql_aux = "WHERE csi_facturas_emitidas.empresa ='"+g_empresa+"'"
end if	

if not isnull(sql_aux) then sql_nuevo += sql_aux	

//messagebox("",sql_nuevo)

dw_1.Modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

dw_1.Retrieve()

dw_1.modify("DataWindow.Table.Select= ~"" + sql_principal + "~"")


end event

on w_busqueda_facturas.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.cb_buscar=create cb_buscar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.cb_buscar
end on

on w_busqueda_facturas.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.cb_buscar)
end on

event open;call super::open;string ls_n_colegiado

dw_3.event pfc_addrow()

if not f_es_vacio(g_facturas_n_colegiado) then dw_3.SetItem(1,'n_col',g_facturas_n_colegiado)				

dw_3.SetFocus()

end event

event pfc_updatespending;call super::pfc_updatespending;return 0
end event

type cb_recuperar_pantalla from w_busqueda`cb_recuperar_pantalla within w_busqueda_facturas
end type

type cb_guardar_pantalla from w_busqueda`cb_guardar_pantalla within w_busqueda_facturas
end type

type sle_1 from w_busqueda`sle_1 within w_busqueda_facturas
boolean visible = false
integer x = 663
integer y = 516
end type

type dw_2 from w_busqueda`dw_2 within w_busqueda_facturas
boolean visible = false
integer x = 832
integer y = 544
integer width = 1975
integer height = 92
integer taborder = 50
string dataobject = ""
end type

event dw_2::editchanged;if not f_es_vacio(data) then dw_1.Retrieve(data+'%')
end event

type st_1 from w_busqueda`st_1 within w_busqueda_facturas
end type

type st_2 from w_busqueda`st_2 within w_busqueda_facturas
string tag = ""
boolean visible = false
integer y = 552
integer width = 777
string text = ""
end type

type cb_1 from w_busqueda`cb_1 within w_busqueda_facturas
integer x = 654
integer y = 1776
integer taborder = 70
end type

event cb_1::clicked;st_busqueda_facturas  lst_datos
string  ls_pagado, ls_contabilizado

if dw_1.rowcount() > 0 then
	
	ls_pagado = dw_1.getitemstring(dw_1.getrow(),"pagado")
	ls_contabilizado = dw_1.getitemstring(dw_1.getrow(),"contabilizada")
		
	lst_datos.n_fact      = dw_1.getitemstring(dw_1.getrow(),"n_fact")
	lst_datos.nif           = dw_1.getitemstring(dw_1.getrow(),"nif")
	lst_datos.nombre    = dw_1.getitemstring(dw_1.getrow(),"nombre")
	lst_datos.base_imp = dw_1.getitemnumber(dw_1.getrow(),"csi_facturas_emitidas_base_imp")
	lst_datos.iva           = dw_1.getitemnumber(dw_1.getrow(),"csi_facturas_emitidas_iva")
	lst_datos.total         = dw_1.getitemnumber(dw_1.getrow(),"csi_facturas_emitidas_total")
	lst_datos.id_factura = dw_1.getitemstring(dw_1.getrow(),"id_factura")
	// Se quita para dar soporte a todo tipo de facturas. 
	//lst_datos.n_aviso     = dw_1.getitemstring(dw_1.getrow(),"fases_minutas_n_aviso")
	lst_datos.id_pago    = dw_1.getitemstring(dw_1.getrow(),"csi_cobros_id_pago")	
		
		
		
	if ls_pagado ='N' and ls_contabilizado ='N' then
		lst_datos.agregar_datos ='Si'
		lst_datos.solo_actualiza_tablas = false //Inserta en Csi_cobros y actualiza en csi_facturas_emitidas
		closewithreturn(parent,lst_datos)
	end if
	
		
	if ls_pagado ='S' and ls_contabilizado ='N' and f_es_vacio(g_facturas_n_colegiado) then
		if   Messagebox(g_titulo,'La Factura est$$HEX2$$e1002000$$ENDHEX$$pagada. Seguro de Agregar al Cobro Compuesto...?',Question!, YesNo!)= 1 then
			lst_datos.solo_actualiza_tablas = true //No inserta en cobros, s$$HEX1$$f300$$ENDHEX$$lo modifica y actualiza el cobro existente y la factura asociada
			lst_datos.agregar_datos ='Si'
			closewithreturn(parent,lst_datos)	
		else
			lst_datos.solo_actualiza_tablas = false
			lst_datos.agregar_datos ='No'
			closewithreturn(parent,lst_datos)
		end if
	else
		if not f_es_vacio(g_facturas_n_colegiado) 	then closewithreturn(parent,lst_datos)
	end if
	
end if

end event

type cb_2 from w_busqueda`cb_2 within w_busqueda_facturas
integer x = 1701
integer y = 1776
integer taborder = 80
boolean cancel = true
end type

event cb_2::clicked;//No hereda
close(w_busqueda_facturas)


end event

type dw_1 from w_busqueda`dw_1 within w_busqueda_facturas
integer x = 18
integer y = 368
integer width = 2944
integer height = 1348
integer taborder = 60
string dataobject = "d_busqueda_facturas_lista"
boolean livescroll = false
end type

event dw_1::constructor;call super::constructor;// Column header sort
inv_sort.of_SetColumnHeader (true)
// Set to simple sort style
inv_sort.of_SetStyle (2)
end event

event dw_1::pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_debug.enabled = False
end event

event dw_1::doubleclicked;//No hereda

end event

type dw_3 from u_dw within w_busqueda_facturas
integer x = 14
integer width = 2949
integer height = 336
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_busqueda_facturas"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;this.accepttext()
string id_persona,cuenta
// C$$HEX1$$f300$$ENDHEX$$digo a ejecutar cuando se pincha sobre el btn de B$$HEX1$$fa00$$ENDHEX$$squeda asociado a la persona a la que
//  se le ha emitido la factura

CHOOSE CASE dwo.name
	CASE 'b_busqueda_colegiados'
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
			g_busqueda.dw="d_lista_busqueda_colegiados"
			id_persona=f_busqueda_colegiados()
			//Comprobamos que el colegiado existe
			if id_persona="-1" then
				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
				this.setfocus()
				return -1
			else
				//this.SetItem(1,'id_persona',id_persona)
				if this.getitemstring(1,'tipo_factura') ='04' then
					this.SetItem(1,'n_col_honorario',f_colegiado_n_col(id_persona))				
				else
					this.SetItem(1,'n_col',f_colegiado_n_col(id_persona))				
				end if
			end if

		CASE 'b_busqueda_clientes_exp'
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Clientes de Expedientes"
			g_busqueda.dw="d_lista_busqueda_clientes"
			id_persona=f_busqueda_clientes_exp()
		
			if id_persona="-1" then
				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de cliente v$$HEX1$$e100$$ENDHEX$$lido.')
				this.setfocus()
				return -1
			else
				//this.SetItem(1,'id_persona',id_persona)
				this.SetItem(1,'nif',f_dame_nif(id_persona))				
			end if
			
		CASE 'b_busqueda_clientes_csi'
//			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Clientes Generales"
//			g_busqueda.dw="d_lista_busqueda_clientes_csi"
//			id_persona=f_busqueda_clientes_csi()
//
//			if id_persona="-1" then
//				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de cliente v$$HEX1$$e100$$ENDHEX$$lido.')
//				this.setfocus()
//				return -1
//			else
//				this.SetItem(1,'id_persona',id_persona)
//				this.SetItem(1,'n_col',f_csi_dame_codigo(id_persona))				
//			end if
end choose

RETURN 1

end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event itemchanged;call super::itemchanged;string ls_null
setnull(ls_null)
CHOOSE CASE dwo.name
	CASE 'tipo_factura'
		
		CHOOSE CASE data
				CASE '03'
					this.object.b_busqueda_clientes_csi.visible = false
					this.object.b_busqueda_colegiados.visible = true
					this.object.n_col.visible = true
					this.object.n_col_honorario.visible = false
					this.setitem(1,'n_col_honorario', ls_null)
				CASE '02'
					this.object.b_busqueda_clientes_csi.visible = false
					this.object.b_busqueda_colegiados.visible = false
					this.object.n_col.visible = true
					this.object.n_col_honorario.visible = false
					this.setitem(1,'n_col_honorario', ls_null)
				CASE '04'
					this.object.b_busqueda_clientes_csi.visible = false
					this.object.b_busqueda_colegiados.visible = true
					this.object.n_col.visible = false
					this.object.n_col_honorario.visible = true
					this.setitem(1,'n_col', ls_null)
				CASE ELSE
					this.object.b_busqueda_clientes_csi.visible = false
					this.object.b_busqueda_colegiados.visible = true
					this.object.n_col_honorario.visible = false
					this.object.n_col.visible = true
			END CHOOSE
			
	CASE 'serie'
		this.SetItem(1,'n_fact','')
		this.SetItem(1,'n_fact_desde','')
		this.SetItem(1,'n_fact_hasta','')		
		//En este caso ponemos en el n_factura el nombre de la serie
		if LeftA(data,6) <> 'COLEGI' then
			this.SetItem(1,'n_fact',data)
		else
			this.SetItem(1,'n_fact_desde',FillA('0',15))
			this.SetItem(1,'n_fact_hasta',FillA('9',15))
		end if

	CASE 'n_fact'
		
		
		
		
		
		
		

END CHOOSE

end event

type cb_buscar from commandbutton within w_busqueda_facturas
integer x = 2542
integer y = 216
integer width = 343
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

event clicked;parent.TriggerEvent('csd_consulta_facturas')
end event

