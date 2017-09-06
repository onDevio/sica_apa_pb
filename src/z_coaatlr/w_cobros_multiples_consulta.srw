HA$PBExportHeader$w_cobros_multiples_consulta.srw
forward
global type w_cobros_multiples_consulta from w_consulta
end type
end forward

global type w_cobros_multiples_consulta from w_consulta
integer width = 1879
integer height = 1520
string title = "Consulta de Cobros M$$HEX1$$fa00$$ENDHEX$$ltiples"
end type
global w_cobros_multiples_consulta w_cobros_multiples_consulta

on w_cobros_multiples_consulta.create
call super::create
end on

on w_cobros_multiples_consulta.destroy
call super::destroy
end on

event open;call super::open;f_centrar_ventana(this)
end event

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_cobros_multiples_consulta
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_cobros_multiples_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_cobros_multiples_consulta
end type

type st_5 from w_consulta`st_5 within w_cobros_multiples_consulta
end type

type cb_1 from w_consulta`cb_1 within w_cobros_multiples_consulta
integer x = 242
integer y = 1316
end type

event cb_1::clicked;call super::clicked;string sql_nuevo, sql_expedientes

dw_1.accepttext()

// Cogemos la SQL de la ventana
sql_nuevo = g_dw_lista.describe("datawindow.table.select")

// Realizamos la consulta
f_sql('csi_cobros_multiples.id_cobro_multiple','LIKE','id_cobro_multiple',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_cobros_multiples.forma_pago','LIKE','forma_pago',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_cobros_multiples.banco','LIKE','banco',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_cobros_multiples.importe','>=','importe_desde',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_cobros_multiples.importe','<=','importe_hasta',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_cobros_multiples.fecha','>=','fecha_desde',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_cobros_multiples.fecha','<','fecha_hasta',dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_cobros_multiples.contabilizado','LIKE','contabilizado',dw_1,sql_nuevo,g_tipo_base_datos,'')
if dw_1.GetItemString(1, 'contabilizado') = 'S' then
	f_sql('csi_cobros_multiples.f_contabilizado','>=','fecha_contabilizado_desde',dw_1,sql_nuevo,g_tipo_base_datos,'')
	f_sql('csi_cobros_multiples.f_contabilizado','<','fecha_contabilizado_hasta',dw_1,sql_nuevo,g_tipo_base_datos,'')
end if
// Nota-> El tipo de pagador solo es usado para saber que ventana de busqueda hay que lanzar, no para la consulta
f_sql('csi_cobros_multiples.pagador','=','pagador',dw_1,sql_nuevo,g_tipo_base_datos,'')

// Consultas realizadas sobre las facturas
sql_expedientes = ' WHERE '
f_sql('expedientes.n_expedi','LIKE','n_expediente',dw_1,sql_expedientes,g_tipo_base_datos,'')
f_sql('fases.n_registro','LIKE','n_registro',dw_1,sql_expedientes,g_tipo_base_datos,'')
f_sql('fases_minutas.n_aviso','LIKE','n_aviso',dw_1,sql_expedientes,g_tipo_base_datos,'')
f_sql('csi_facturas_emitidas.n_fact','LIKE','n_factura',dw_1,sql_expedientes,g_tipo_base_datos,'')
if sql_expedientes<>' WHERE ' then
	// Miramos si tiene where 
	if PosA(sql_nuevo, "WHERE")>0 then
		sql_nuevo += " AND "
	ELSE
		sql_nuevo += " WHERE "
	end if
	sql_nuevo += " csi_cobros_multiples.id_cobro_multiple in ("
	sql_nuevo += " SELECT distinct csi_cobros.id_cobro_multiple "
	sql_nuevo += " 		from csi_cobros, csi_facturas_emitidas, fases_minutas, fases, expedientes "
	sql_nuevo += " 		where csi_cobros.id_factura = csi_facturas_emitidas.id_factura and "
	sql_nuevo += " 				csi_facturas_emitidas.id_fase = fases_minutas.id_minuta and "
	sql_nuevo += " 				fases_minutas.id_fase = fases.id_fase and "
	sql_nuevo += " 				fases.id_expedi = expedientes.id_expedi "
	// -> Hay que quitar el where colocado
	sql_nuevo += MidA(sql_expedientes, 7 ,LenA(sql_expedientes))
	sql_nuevo += " )"
end if

if g_debug = '1' then  Messagebox(g_titulo, sql_nuevo)


// Colocamos la nueva sql
g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
Parent.event pfc_close()
end event

type cb_2 from w_consulta`cb_2 within w_cobros_multiples_consulta
integer x = 864
integer y = 1316
end type

type cb_ayuda from w_consulta`cb_ayuda within w_cobros_multiples_consulta
end type

type dw_1 from w_consulta`dw_1 within w_cobros_multiples_consulta
integer width = 1705
integer height = 1108
string dataobject = "d_cobros_multiples_consulta"
end type

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event dw_1::buttonclicked;call super::buttonclicked;// Buscamos la persona que se pretenda colocar como pagador

string id_persona
CHOOSE CASE dwo.name
	CASE 'b_buscar_colegiado'
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
			g_busqueda.dw="d_lista_busqueda_colegiados"
			id_persona=f_busqueda_colegiados()
			//Comprobamos que el colegiado existe
			if id_persona="-1" then
				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
				this.setfocus()
				return -1
			else
				this.SetItem(1,'pagador',f_colegiado_apellido(id_persona))				
			end if

	CASE 'b_buscar_cliente'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Clientes de Expedientes"
		g_busqueda.dw="d_lista_busqueda_clientes"
		id_persona=f_busqueda_clientes_exp()
	
		if id_persona="-1" then
			messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de cliente v$$HEX1$$e100$$ENDHEX$$lido.')
			this.setfocus()
			return -1
		else
			this.SetItem(1,'pagador',f_dame_cliente(id_persona))				
		end if
		
END CHOOSE

end event

event dw_1::itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE 'tipo_pagador'
		// Cuando cambia el tipo de factura se vaciar$$HEX2$$e1002000$$ENDHEX$$el campo del nombre y del id
		this.SetItem(row, 'pagador', '')
		CHOOSE CASE string(data)
			CASE '1'
				this.object.b_buscar_colegiado.visible = true
				this.object.b_buscar_cliente.visible = false
			CASE '3'
				this.object.b_buscar_colegiado.visible = false
				this.object.b_buscar_cliente.visible = true
		END CHOOSE
END CHOOSE
end event

