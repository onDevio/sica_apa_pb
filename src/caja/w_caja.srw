HA$PBExportHeader$w_caja.srw
forward
global type w_caja from w_response
end type
type cb_salir from commandbutton within w_caja
end type
type dw_datos_contrato from u_dw within w_caja
end type
type cb_cancelar from commandbutton within w_caja
end type
type cb_grabar_pagos from commandbutton within w_caja
end type
type cb_marcar from commandbutton within w_caja
end type
type cb_desmarcar from commandbutton within w_caja
end type
type dw_caja_formapago from u_dw within w_caja
end type
type cb_cobrar from commandbutton within w_caja
end type
type dw_caja_contratos_expediente from u_dw within w_caja
end type
type dw_factura_conceptos from u_dw within w_caja
end type
type dw_listado_cuadre_caja from u_dw within w_caja
end type
type dw_caja_pagos_caja_lista from u_dw within w_caja
end type
type dw_facturas_emitidas from u_dw within w_caja
end type
type cb_buscar_facturas_emitidas from commandbutton within w_caja
end type
type dw_facturas_emitidas_busqueda from u_dw within w_caja
end type
type dw_factura_cabecera_external from u_dw within w_caja
end type
type dw_dar_salida_expediente from u_dw within w_caja
end type
type dw_avisos from u_dw within w_caja
end type
type dw_caja_pagos_caja from u_dw within w_caja
end type
type dw_busqueda_avisos from u_dw within w_caja
end type
type dw_seleccion_funcionamiento from u_dw within w_caja
end type
type dw_listado_cuadre_busqueda from u_dw within w_caja
end type
type cb_buscar_avisos from commandbutton within w_caja
end type
type dw_caja_pagos_consulta from u_dw within w_caja
end type
type cb_consultar_pagos from commandbutton within w_caja
end type
end forward

global type w_caja from w_response
integer width = 3749
integer height = 2000
boolean minbox = true
windowtype windowtype = popup!
boolean ib_disableclosequery = true
event type integer csd_preparar_ventana ( string opcion )
event csd_abrir_con_busqueda ( st_cobrar_avisos_za lst_datos_entrada )
cb_salir cb_salir
dw_datos_contrato dw_datos_contrato
cb_cancelar cb_cancelar
cb_grabar_pagos cb_grabar_pagos
cb_marcar cb_marcar
cb_desmarcar cb_desmarcar
dw_caja_formapago dw_caja_formapago
cb_cobrar cb_cobrar
dw_caja_contratos_expediente dw_caja_contratos_expediente
dw_factura_conceptos dw_factura_conceptos
dw_listado_cuadre_caja dw_listado_cuadre_caja
dw_caja_pagos_caja_lista dw_caja_pagos_caja_lista
dw_facturas_emitidas dw_facturas_emitidas
cb_buscar_facturas_emitidas cb_buscar_facturas_emitidas
dw_facturas_emitidas_busqueda dw_facturas_emitidas_busqueda
dw_factura_cabecera_external dw_factura_cabecera_external
dw_dar_salida_expediente dw_dar_salida_expediente
dw_avisos dw_avisos
dw_caja_pagos_caja dw_caja_pagos_caja
dw_busqueda_avisos dw_busqueda_avisos
dw_seleccion_funcionamiento dw_seleccion_funcionamiento
dw_listado_cuadre_busqueda dw_listado_cuadre_busqueda
cb_buscar_avisos cb_buscar_avisos
dw_caja_pagos_consulta dw_caja_pagos_consulta
cb_consultar_pagos cb_consultar_pagos
end type
global w_caja w_caja

type variables
string is_opcion_ventana = '', i_modulo
string isql_aplicado_consulta_avisos, isql_aplicado_consulta_facturas
string isql_original_avisos, isql_original_facturas

// Variables para la opcion del listado de caja
string is_banco, is_centro
datetime idt_f_desde, idt_f_hasta, idt_f_visualizada
long il_pagina_inicial, il_total_paginas


// Variable para tener el datastore del recibo de caja
datastore ids_caja_pagos_caja_recibo
// VAriable para tener el listado a exportar a excel
datastore ids_caja_exportar_excel
datawindowchild idwc_serie

//Variable que contiene la estructura que se recoje al llamar a la ventana de caja desde el detalle de un contrato
st_cobrar_avisos_za ist_datos_entrada
end variables

forward prototypes
public subroutine wf_preparar_acuse_pago_caja (string id_caja_pagos)
public subroutine wf_rellenar_pagina_exportar (string centro, string banco, datetime fecha)
public function integer wf_generar_factura ()
public subroutine wf_insertar_incidencia_contrato (string id_fase, string estado)
public subroutine wf_imprimir_etiqueta (string id, string numero)
public subroutine wf_generar_liquidacion ()
end prototypes

event type integer csd_preparar_ventana(string opcion);// Evento que prepara la ventana para realizar las acciones que sean pertinentes para dejar la ventana tal como debe estar
dwobject dwo
long n_reg

// Colocamos los valores por defecto
cb_cobrar.text = "&Cobrar"
cb_cobrar.enabled = false

// Ocultamos y vaciamos los otros dos casos
dw_factura_cabecera_external.visible = false
dw_factura_conceptos.visible = false
dw_busqueda_avisos.visible = false
dw_avisos.visible = false
dw_caja_formapago.visible = false
cb_buscar_avisos.visible = false
dw_facturas_emitidas_busqueda.visible = false
dw_facturas_emitidas.visible = false
cb_buscar_facturas_emitidas.visible = false
dw_caja_pagos_caja.visible = false
dw_datos_contrato.visible = false
dw_dar_salida_expediente.visible = false
cb_cancelar.visible = false
dw_caja_contratos_expediente.visible = false
dw_caja_pagos_caja_lista.visible = false
cb_grabar_pagos.visible = false
dw_listado_cuadre_busqueda.visible = false
dw_listado_cuadre_caja.visible = false
dw_caja_pagos_consulta.visible = false
cb_consultar_pagos.visible = false
cb_marcar.visible = false
cb_desmarcar.visible = false

dw_factura_cabecera_external.reset()
dw_factura_conceptos.reset()
dw_busqueda_avisos.reset()
dw_facturas_emitidas_busqueda.reset()
dw_facturas_emitidas.reset()
dw_caja_pagos_caja.reset()
dw_datos_contrato.reset()
dw_dar_salida_expediente.reset()
dw_listado_cuadre_busqueda.reset()
dw_listado_cuadre_caja.reset()
dw_caja_pagos_consulta.reset()
dw_caja_formapago.reset()
//dw_caja_formapago.retrieve()


CHOOSE CASE opcion
	CASE '1' 
		// SE pretende cobrar expedientes

		// Colocamos lo dejamos enabled
		cb_cobrar.enabled = true
		
		if g_colegio = 'COAATTFE' then 
			dw_busqueda_avisos.dataobject='d_caja_avisos_busqueda'
		else
			dw_busqueda_avisos.dataobject='d_caja_avisos_busqueda_n_vis'
			cb_buscar_avisos.X=3145
		end if
		dw_busqueda_avisos.height=188
		dw_busqueda_avisos.reset()
		dw_busqueda_avisos.insertrow(0) // Insertamos una linea para poder trabajar con $$HEX1$$e900$$ENDHEX$$l
		dw_busqueda_avisos.visible = true
		dw_busqueda_avisos.setfocus()
		dw_avisos.y=424
		dw_avisos.height=1316
		dw_avisos.reset()
		dw_avisos.visible = true
		cb_buscar_avisos.visible = true
		dw_caja_formapago.visible = true
		dw_caja_formapago.insertrow(0)
		
		
		// Colocamos el centro correspondiente
		dw_busqueda_avisos.setitem(1, 'centro', f_devuelve_centro(g_cod_delegacion)) // Modificado Ricardo 04-06-14
		if g_colegio = 'COAATMCA' then dw_busqueda_avisos.setitem(1, 'centro', '%') // Modificado Ricardo 04-06-14
		dw_busqueda_avisos.resetupdate() // Modificado Ricardo 04-06-14
		// Miramos si hay permitiso para tocar el centro
		SELECT count(*) into :n_reg from t_permisos where cod_aplicacion = '0000000038' and cod_usuario = :g_usuario;
		if n_reg>0 then
			dw_busqueda_avisos.modify("centro.protect = '0'")
			datawindowchild dwc_centro
			dw_busqueda_avisos.GetChild("centro", dwc_centro)
			dwc_centro.settransobject(sqlca)
			dwc_centro.retrieve()
		else
			dw_busqueda_avisos.modify("centro.protect = '1'")
		end if
		
		CHOOSE CASE g_colegio
			CASE 'COAATTFE'
				// En tenerife se cobra por contratos, as$$HEX2$$ed002000$$ENDHEX$$que colocamos el cursor en el de contratos
				dw_busqueda_avisos.setcolumn('n_registro')
		END CHOOSE
		
		cb_marcar.visible = true
		cb_desmarcar.visible = true

	CASE '2' 
		// Se pretende hacer una nueva factura

		// Colocamos la nueva etiqueta y lo dejamos enabled
		cb_cobrar.text = "Generar y &Cobrar"
		cb_cobrar.enabled = true

		dw_factura_cabecera_external.reset()
		dw_factura_conceptos.reset()
		dw_factura_conceptos.InsertRow(0)
		dw_factura_cabecera_external.InsertRow(0)
		dw_factura_cabecera_external.visible = true
		dw_factura_conceptos.visible = true
		dw_factura_cabecera_external.setfocus()
		CHOOSE CASE g_colegio
			CASE 'COAATTFE'
				// Colocamos una opcion por defecto en lo de colegio-colegiado
				dwo =  dw_factura_cabecera_external.object.tipo_factura
				dw_factura_cabecera_external.SetItem(dw_factura_cabecera_external.RowCount(), 'tipo_factura', '1')
				// La serie colocamos VARIOS
				dw_factura_cabecera_external.SetItem(dw_factura_cabecera_external.RowCount(), 'serie', 'VARIOS')
				// Colocamos en la cabecera la fecha de hoy
				dw_factura_cabecera_external.SetItem(dw_factura_cabecera_external.RowCount(), 'fecha', datetime(today(), time("00:00")))
				// Lanzamos el itemchanged
				dw_factura_cabecera_external.trigger event itemchanged(dw_factura_cabecera_external.RowCount(), dwo, '1')
				
			CASE ELSE
				// Colocamos una opcion por defecto en lo de colegio-cliente
				dwo =  dw_factura_cabecera_external.object.tipo_factura
				dw_factura_cabecera_external.SetItem(dw_factura_cabecera_external.RowCount(), 'tipo_factura', '3')
				// Lanzamos el itemchanged
				dw_factura_cabecera_external.trigger event itemchanged(dw_factura_cabecera_external.RowCount(), dwo, '3')
		END CHOOSE
		cb_marcar.visible = false
		cb_desmarcar.visible = false
		
	CASE '3'
		// Se pretende cobrar facturas pendientes

		// Colocamos lo dejamos enabled
		cb_cobrar.enabled = true
		
		dw_facturas_emitidas_busqueda.reset()
		dw_facturas_emitidas.reset()
		dw_facturas_emitidas_busqueda.insertrow(0)
		dw_facturas_emitidas_busqueda.visible = true
		dw_facturas_emitidas_busqueda.setfocus()
		dw_facturas_emitidas_busqueda.SetItem(dw_facturas_emitidas_busqueda.GetRow(),'tipo_factura','03')
		dw_facturas_emitidas_busqueda.event itemchanged(1,dw_facturas_emitidas_busqueda.object.tipo_factura,'03')
		dw_facturas_emitidas_busqueda.setitem(1, 'empresa', g_empresa)
		dw_facturas_emitidas.visible = true
		cb_buscar_facturas_emitidas.visible = true
		dw_caja_formapago.visible = true
		dw_caja_formapago.insertrow(0)

		// Colocamos el centro correspondiente
		dw_facturas_emitidas_busqueda.setitem(1, 'centro', f_devuelve_centro(g_cod_delegacion)) // Modificado Ricardo 04-06-14
		dw_facturas_emitidas_busqueda.resetupdate() // Modificado Ricardo 04-06-14
		// Miramos si hay permitiso para tocar el centro
		SELECT count(*) into :n_reg from t_permisos where cod_aplicacion = '0000000038' and cod_usuario = :g_usuario;
		if n_reg>0 then
			dw_facturas_emitidas_busqueda.modify("centro.protect = '0'")
		else
			dw_facturas_emitidas_busqueda.modify("centro.protect = '1'")
		end if
		
		//Poder filtrar por serie, que aparezca como texto 'N$$HEX2$$ba002000$$ENDHEX$$Factura' y que busque las NO proforma
		/*dw_facturas_emitidas_busqueda.Modify("serie.Visible = '1'")
		dw_facturas_emitidas_busqueda.Modify("serie_t.Visible = '1'")
		dw_facturas_emitidas_busqueda.Modify("n_factura_t.Text = 'N$$HEX2$$ba002000$$ENDHEX$$Factura:'")
		dw_facturas_emitidas_busqueda.Modify("tipo_factura_t.Text = 'Tipo Factura:'")
		dw_facturas_emitidas.Modify("n_fact_t.Text = 'N. Fact.'")
		dw_facturas_emitidas.Modify("tipos_facturas_descripcion_t.Text = 'Tipo Factura'")
		dw_facturas_emitidas.Modify("n_fact_marcadas_t.Text = 'N$$HEX2$$ba002000$$ENDHEX$$facturas marcadas:'")		
		//Quitamos los campos de N$$HEX1$$ba00$$ENDHEX$$Registro y N$$HEX1$$ba00$$ENDHEX$$expediente
		dw_facturas_emitidas_busqueda.Modify("n_registro_t.Visible = '0'")		
		dw_facturas_emitidas_busqueda.Modify("n_registro.Visible = '0'")
		dw_facturas_emitidas_busqueda.Modify("n_expediente_t.Visible = '0'")		
		dw_facturas_emitidas_busqueda.Modify("n_expediente.Visible = '0'")		*/

		cb_marcar.visible = true
		cb_desmarcar.visible = true

	CASE '4' 
		// Se pretende hacer un pago de caja
		dw_caja_pagos_caja.reset()
		dw_caja_pagos_caja.insertrow(0)
		dw_caja_pagos_consulta.insertrow(0)
		dw_caja_pagos_caja.visible = true
		if g_colegio = 'COAATTFE' then
			dw_caja_pagos_consulta.visible = true
			cb_consultar_pagos.visible = true
			dw_caja_pagos_consulta.setitem(1, 'fecha', datetime(today(), time("00:00:00")))
			dw_caja_pagos_caja.setfocus()
			
			dw_caja_pagos_caja_lista.modify("titulo_t.text = 'COBROS REALIZADOS EL DIA DE HOY'")
			// Colocamos lo dejamos enabled
			cb_cobrar.enabled = true
			dw_caja_pagos_caja_lista.visible = true
			cb_grabar_pagos.visible = true
			// Colocamos el centro correspondiente
			dw_caja_pagos_caja.setitem(1, 'centro', f_devuelve_centro(g_cod_delegacion)) // Modificado Ricardo 04-06-14
			dw_caja_pagos_caja.setitemstatus(1, 'centro', primary!, notmodified!) // Modificado Ricardo 04-06-14
			dw_caja_pagos_caja.setitemstatus(1, 0, primary!, notmodified!) // Modificado Ricardo 04-06-14
			dw_caja_pagos_caja.resetupdate() // Modificado Ricardo 04-06-14
			//Cambio Luis CTE-111
			dw_caja_pagos_caja_lista.retrieve(datetime(today()))
		
			cb_marcar.visible = false
			cb_desmarcar.visible = false
		else
			string f_entrada, sql_nuevo
			datetime fecha
			cb_consultar_pagos.text = 'Generar Liquidaci$$HEX1$$f300$$ENDHEX$$n'
			cb_consultar_pagos.X=2800
			cb_consultar_pagos.Y=500
			cb_consultar_pagos.visible = true
			dw_caja_pagos_caja.setitem(1, 'f_entrada', datetime(today()))
			dw_caja_pagos_caja.setitem(1, 'f_liquidacion', today())
			dw_caja_pagos_caja.setitem(1, 'centro', f_devuelve_centro(g_cod_delegacion))
		
			sql_nuevo = dw_caja_pagos_caja_lista.describe("datawindow.table.select")
			f_sql('premaat_liquidaciones.f_entrada','>=','f_entrada',dw_caja_pagos_caja,sql_nuevo,g_tipo_base_datos,'')
			dw_caja_pagos_caja_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
			dw_caja_pagos_caja_lista.retrieve(g_usuario)
			dw_caja_pagos_caja_lista.visible = true
		end if
				// Miramos si hay permitiso para tocar el centro
			SELECT count(*) into :n_reg from t_permisos where cod_aplicacion = '0000000038' and cod_usuario = :g_usuario;
			if n_reg>0 then
				dw_caja_pagos_caja.modify("centro.protect = '0'")
				dw_caja_pagos_caja_lista.modify("centro.protect = '0'")
			else
				dw_caja_pagos_caja.modify("centro.protect = '1'")
				dw_caja_pagos_caja_lista.modify("centro.protect = '1'")
			end if
	CASE '5'
		// Tenemos que dar salida a un expediente
		dw_dar_salida_expediente.insertrow(0)
		dw_datos_contrato.insertrow(0)
		dw_dar_salida_expediente.setitem(1,'tipo', '5')
		dw_dar_salida_expediente.visible = true
		dw_dar_salida_expediente.setfocus()
		dw_datos_contrato.visible = true
		cb_cobrar.text = '&Aceptar'
		cb_cobrar.enabled = true
		cb_cancelar.visible = true
		cb_marcar.visible = false
		cb_desmarcar.visible = false
		
	CASE '6'
		// Tenemos que sacar la carta al expediente
		dw_dar_salida_expediente.insertrow(0)
		dw_datos_contrato.insertrow(0)
		dw_dar_salida_expediente.setitem(1,'tipo', '6')
		dw_dar_salida_expediente.visible = true
		dw_dar_salida_expediente.setfocus()
		dw_datos_contrato.visible = true
		cb_cobrar.text = '&Imprimir'
		cb_cobrar.enabled = true
		cb_marcar.visible = false
		cb_desmarcar.visible = false

	CASE '7'
		
		if g_colegio = 'COAATTFE' then
			// Visualizar listado de caja
			setnull(is_centro) // Modificado Ricardo 04-06-14
			is_centro = f_devuelve_centro(g_cod_delegacion) // Modificado Ricardo 04-06-14
			setnull(is_banco)
			setnull(idt_f_desde)
			setnull(idt_f_hasta)
			setnull(idt_f_visualizada)
			dw_listado_cuadre_busqueda.insertrow(0)
			dw_listado_cuadre_busqueda.setitem(1, 'centro', f_devuelve_centro(g_cod_delegacion)) // Modificado Ricardo 04-06-14
			dw_listado_cuadre_busqueda.setitem(1, 'f_desde', datetime(today(), time("00:00")))
			dw_listado_cuadre_busqueda.setitem(1, 'f_hasta', datetime(today(), time("00:00")))
			dw_listado_cuadre_busqueda.visible = true
			dw_listado_cuadre_busqueda.setfocus()
			// Miramos si tiene permiso para poder tocar y obtener un listado para otros centros 
			SELECT count(*) into :n_reg from t_permisos where cod_aplicacion = '0000000038' and cod_usuario = :g_usuario;
			if n_reg>0 then
				dw_listado_cuadre_busqueda.modify("centro.protect = '0'")
				dw_listado_cuadre_busqueda.modify("b_borrar_centro.visible = '1'")
			else
				dw_listado_cuadre_busqueda.modify("centro.protect = '1'")
				dw_listado_cuadre_busqueda.modify("b_borrar_centro.visible = '0'")
			end if
			cb_marcar.visible = false
			cb_desmarcar.visible = false
		else
			
			dw_listado_cuadre_busqueda.insertrow(0)
			dw_listado_cuadre_busqueda.visible = true
			dw_listado_cuadre_busqueda.setitem(1,'cod_usuario', g_usuario)
			dw_listado_cuadre_busqueda.setitem(1,'centro', g_centro_por_defecto)
			dw_listado_cuadre_busqueda.setitem(1,'f_desde', today())
			dw_listado_cuadre_busqueda.setitem(1,'f_hasta', today())
			dw_listado_cuadre_caja.object.datawindow.print.preview = true
			//dw_listado_cuadre_caja.object.datawindow.print.preview.zoom = 95
			dw_listado_cuadre_caja.visible = true
			
		end if
	CASE '8' 
		// SE pretende cobrar expedientes

		// Colocamos lo dejamos enabled
		cb_cobrar.enabled = true
		dw_busqueda_avisos.dataobject='d_caja_avisos_frac_busqueda'
		dw_busqueda_avisos.height=316
		dw_busqueda_avisos.reset()
		dw_busqueda_avisos.insertrow(0) // Insertamos una linea para poder trabajar con $$HEX1$$e900$$ENDHEX$$l
		dw_busqueda_avisos.visible = true
		dw_busqueda_avisos.setfocus()
		dw_avisos.y=552
		dw_avisos.height=1188
		dw_avisos.reset()
		dw_avisos.visible = true
		cb_buscar_avisos.visible = true
		
		// Colocamos el centro correspondiente
		dw_busqueda_avisos.setitem(1, 'centro', f_devuelve_centro(g_cod_delegacion)) // Modificado Ricardo 04-06-14
		dw_busqueda_avisos.resetupdate() // Modificado Ricardo 04-06-14
		// Miramos si hay permitiso para tocar el centro
		SELECT count(*) into :n_reg from t_permisos where cod_aplicacion = '0000000038' and cod_usuario = :g_usuario;
		if n_reg>0 then
			dw_busqueda_avisos.modify("centro.protect = '0'")
		else
			dw_busqueda_avisos.modify("centro.protect = '1'")
		end if
				
		cb_marcar.visible = true
		cb_desmarcar.visible = true	
		
		dw_busqueda_avisos.SetItem(1,'fecha_h',datetime(today()))
		CASE '9'
			//messagebox('','Facturas PROFORMAAAA')
			// Se pretende cobrar facturas proforma

			// Colocamos lo dejamos enabled
			cb_cobrar.enabled = true
		
			dw_facturas_emitidas_busqueda.reset()
			dw_facturas_emitidas.reset()
			dw_facturas_emitidas_busqueda.insertrow(0)
			dw_facturas_emitidas_busqueda.SetItem(dw_facturas_emitidas_busqueda.GetRow(),'tipo_factura','03')
			dw_facturas_emitidas_busqueda.event itemchanged(1,dw_facturas_emitidas_busqueda.object.tipo_factura,'03')
			dw_facturas_emitidas_busqueda.visible = true
			dw_facturas_emitidas_busqueda.setfocus()
			dw_facturas_emitidas.visible = true
			cb_buscar_facturas_emitidas.visible = true
			dw_caja_formapago.visible = true
			dw_caja_formapago.insertrow(0)

			// Colocamos el centro correspondiente
			dw_facturas_emitidas_busqueda.setitem(1, 'centro', f_devuelve_centro(g_cod_delegacion)) // Modificado Ricardo 04-06-14
			dw_facturas_emitidas_busqueda.resetupdate() // Modificado Ricardo 04-06-14
			// Miramos si hay permitiso para tocar el centro
			SELECT count(*) into :n_reg from t_permisos where cod_aplicacion = '0000000038' and cod_usuario = :g_usuario;
			if n_reg>0 then
				dw_facturas_emitidas_busqueda.modify("centro.protect = '0'")
			else
				dw_facturas_emitidas_busqueda.modify("centro.protect = '1'")
			end if
			
			//Impedir filtrar por serie, que aparezca como texto 'N$$HEX2$$ba002000$$ENDHEX$$Proforma' y que busque las SI proforma
		/*	dw_facturas_emitidas_busqueda.Modify("serie.Visible = '0'")
			dw_facturas_emitidas_busqueda.Modify("serie_t.Visible = '0'")
			dw_facturas_emitidas_busqueda.Modify("n_factura_t.Text = 'N$$HEX2$$ba002000$$ENDHEX$$Proforma:'")
			dw_facturas_emitidas_busqueda.Modify("tipo_factura_t.Text = 'Tipo Proforma:'")
			dw_facturas_emitidas.Modify("n_fact_t.Text = 'N. Proforma'")
			dw_facturas_emitidas.Modify("tipos_facturas_descripcion_t.Text = 'Tipo Proforma'")
			dw_facturas_emitidas.Modify("n_fact_marcadas_t.Text = 'N$$HEX2$$ba002000$$ENDHEX$$proformas marcadas:'")
			//Ponemos los campos de N$$HEX1$$ba00$$ENDHEX$$Registro y N$$HEX1$$ba00$$ENDHEX$$expediente
			dw_facturas_emitidas_busqueda.Modify("n_registro_t.Visible = '1'")		
			dw_facturas_emitidas_busqueda.Modify("n_registro.Visible = '1'")
			dw_facturas_emitidas_busqueda.Modify("n_expediente_t.Visible = '1'")		
			dw_facturas_emitidas_busqueda.Modify("n_expediente.Visible = '1'")		*/

			cb_marcar.visible = true
			cb_desmarcar.visible = true
END CHOOSE
dw_facturas_emitidas_busqueda.setitem(1,'visible',g_borrar_empresa)
is_opcion_ventana = opcion

return 1

end event

event csd_abrir_con_busqueda(st_cobrar_avisos_za lst_datos_entrada);// MODIFICADO RICARDO 2005-01-13 PARA ZARAGOZA
string n_aviso, n_fase, n_expedi
boolean b_consultar = false

if isvalid(lst_datos_entrada) then
	if not f_es_vacio(lst_datos_entrada.n_aviso) then
		n_aviso = lst_datos_entrada.n_aviso
	elseif not f_es_vacio(lst_datos_entrada.id_minuta)  then
		// Averiguamos el n_fase desde bbdd
		select n_aviso into :n_aviso from fases_minutas where id_minuta = :lst_datos_entrada.id_minuta;
	end if
	dw_busqueda_avisos.setitem(1, 'n_aviso', n_aviso)
	
	if f_es_vacio(n_aviso) then
		if not f_es_vacio(lst_datos_entrada.n_fase) then
			n_fase = lst_datos_entrada.n_fase
		elseif not f_es_vacio(lst_datos_entrada.id_fase) then
			// Averiguamos el n_fase desde bbdd
			select n_registro into :n_fase from fases where id_fase = :lst_datos_entrada.id_fase;
		end if
		dw_busqueda_avisos.setitem(1, 'n_registro', n_fase)
		if f_es_vacio(n_fase) then
			if not f_es_vacio(lst_datos_entrada.n_expedi) then
				n_expedi = lst_datos_entrada.n_expedi
			elseif not f_es_vacio(lst_datos_entrada.id_expedi) then
				// Averiguamos el n_fase desde bbdd
				select n_expedi into :n_expedi from expedientes where id_expedi = :lst_datos_entrada.id_expedi;
			end if
			// La busqueda ahora se realiza sobre las proformas y no sobre los avisos
			//dw_busqueda_avisos.setitem(1, 'n_expediente', n_expedi)
			if not f_es_vacio(n_expedi) then 
				b_consultar = true
				//dw_facturas_emitidas_busqueda.InsertRow(0)
				dw_seleccion_funcionamiento.setitem(1,'opcion_funcionamiento','3')
				dw_seleccion_funcionamiento.event itemchanged(1,dw_seleccion_funcionamiento.object.opcion_funcionamiento,'3')
				dw_facturas_emitidas_busqueda.post setitem(1,'n_expediente', n_expedi)
			end if
		else
			b_consultar = true
		end if
	else
		b_consultar = true
	end if
end if

if b_consultar then
	// llamamos al de mostrar mensajes
	// La busqueda ahora se realiza sobre las proformas y no sobre los avisos
	//cb_buscar_avisos.trigger event clicked()
	cb_buscar_facturas_emitidas.post event clicked()
	cb_marcar.post event clicked()
end if 
// FIN MODIFICADO RICARDO 2005-01-13 PARA ZARAGOZA

end event

public subroutine wf_preparar_acuse_pago_caja (string id_caja_pagos);// Funcion que se encargar$$HEX2$$e1002000$$ENDHEX$$de imprimir el acuse de lo que se ha cobrado/pagado en el modulo generico de caja
/*
-----------------------------------------------------------------------------------------------------------------------------------
    HE RECIBIDO DE <Pagador> LA CANTIDAD DE <euros en letra> (<euros en n$$HEX1$$fa00$$ENDHEX$$mero>) EN CONCEPTO DE <motivo>.
 
    EN SANTA CRUZ DE TENERIFE A <fecha de emisi$$HEX1$$f300$$ENDHEX$$n>.
-----------------------------------------------------------------------------------------------------------------------------------
*/


if ids_caja_pagos_caja_recibo.retrieve(id_caja_pagos)>0 then
	ids_caja_pagos_caja_recibo.print()
end if
end subroutine

public subroutine wf_rellenar_pagina_exportar (string centro, string banco, datetime fecha);// Funcion que caza el dw de pantalla y lo rellena en el datastore a exportar a excel
datawindowchild dwc_cuadre_avisos, dwc_cuadre_facturas, dwc_cuadre_pagos
long fila, fila_insert

// Si no es valido el 
if not isvalid(ids_caja_exportar_excel) then return

// Miramos cada uno de los integrantes del composite
dw_listado_cuadre_caja.getchild('dw_cuadre_avisos', dwc_cuadre_avisos)
dw_listado_cuadre_caja.getchild('dw_cuadre_facturas', dwc_cuadre_facturas)
dw_listado_cuadre_caja.getchild('dw_cuadre_pagos', dwc_cuadre_pagos)

// Si habian lineas le ponemos una en blanco en medio
if ids_caja_exportar_excel.rowCount()>0 and (dwc_cuadre_avisos.rowCount()>0 or dwc_cuadre_facturas.rowCount()>0 or dwc_cuadre_pagos.rowCount()>0) then 
	if dwc_cuadre_avisos.rowCount()>0 then ids_caja_exportar_excel.insertrow(0)
	ids_caja_exportar_excel.insertrow(0)
end if

// Miramos si hay lineas
FOR fila = 1 TO dwc_cuadre_avisos.rowCount()
	fila_insert = ids_caja_exportar_excel.insertrow(0)
	
	// Rellenamos la linea con los datos del aviso
	ids_caja_exportar_excel.setitem(fila_insert, 'centro', centro)
	ids_caja_exportar_excel.setitem(fila_insert, 'banco', banco)
	ids_caja_exportar_excel.setitem(fila_insert, 'fecha', date(fecha))
	ids_caja_exportar_excel.setitem(fila_insert, 'forma_pago', f_dame_formapago(dwc_cuadre_avisos.getitemstring(fila, 'forma_pago')))
	ids_caja_exportar_excel.setitem(fila_insert, 'descripcion', 'CORRESPONDIENTE A AVISOS')
	ids_caja_exportar_excel.setitem(fila_insert, 'codigo', dwc_cuadre_avisos.getitemstring(fila, 'archivo'))
	ids_caja_exportar_excel.setitem(fila_insert, 'n_col', dwc_cuadre_avisos.getitemstring(fila, 'colegiados_n_colegiado'))
	ids_caja_exportar_excel.setitem(fila_insert, 'base_cip', dwc_cuadre_avisos.getitemNumber(fila, 'base_cip'))
	ids_caja_exportar_excel.setitem(fila_insert, 'iva_cip', dwc_cuadre_avisos.getitemNumber(fila, 'iva_cip'))
	ids_caja_exportar_excel.setitem(fila_insert, 'base_musaat', dwc_cuadre_avisos.getitemNumber(fila, 'base_musaat'))
	ids_caja_exportar_excel.setitem(fila_insert, 'liquidacion', dwc_cuadre_avisos.getitemNumber(fila, 'liquidacion'))
	ids_caja_exportar_excel.setitem(fila_insert, 'total', dwc_cuadre_avisos.getitemNumber(fila, 'total_aviso'))
NEXT
// Si habian lineas le ponemos una en blanco en medio
if ids_caja_exportar_excel.rowCount()>0 and dwc_cuadre_facturas.rowCount()>0 then ids_caja_exportar_excel.insertrow(0)

FOR fila = 1 TO dwc_cuadre_facturas.rowCount()
	fila_insert = ids_caja_exportar_excel.insertrow(0)
	
	// Rellenamos la linea con los datos de la factura
	ids_caja_exportar_excel.setitem(fila_insert, 'centro', centro)
	ids_caja_exportar_excel.setitem(fila_insert, 'banco', banco)
	ids_caja_exportar_excel.setitem(fila_insert, 'fecha', date(fecha))
	ids_caja_exportar_excel.setitem(fila_insert, 'forma_pago', f_dame_formapago(dwc_cuadre_facturas.getitemstring(fila, 'formadepago')))
	ids_caja_exportar_excel.setitem(fila_insert, 'descripcion', 'CORRESPONDIENTE A FACTURAS NO DE EXPEDIENTES')
	ids_caja_exportar_excel.setitem(fila_insert, 'codigo', dwc_cuadre_facturas.getitemstring(fila, 'n_fact'))
	ids_caja_exportar_excel.setitem(fila_insert, 'asunto_observaciones', dwc_cuadre_facturas.getitemstring(fila, 'asunto'))
	ids_caja_exportar_excel.setitem(fila_insert, 'base_imponible', dwc_cuadre_facturas.getitemNumber(fila, 'base_imp'))
	ids_caja_exportar_excel.setitem(fila_insert, 'iva', dwc_cuadre_facturas.getitemNumber(fila, 'iva'))
	ids_caja_exportar_excel.setitem(fila_insert, 'total', dwc_cuadre_facturas.getitemNumber(fila, 'total'))
NEXT
// Si habian lineas le ponemos una en blanco en medio
if ids_caja_exportar_excel.rowCount()>0 and dwc_cuadre_pagos.rowCount()>0 then ids_caja_exportar_excel.insertrow(0)

FOR fila = 1 TO dwc_cuadre_pagos.rowCount()
	fila_insert = ids_caja_exportar_excel.insertrow(0)
	
	// Rellenamos la linea con los datos del pago
	ids_caja_exportar_excel.setitem(fila_insert, 'centro', centro)
	ids_caja_exportar_excel.setitem(fila_insert, 'banco', banco)
	ids_caja_exportar_excel.setitem(fila_insert, 'fecha', date(fecha))
	ids_caja_exportar_excel.setitem(fila_insert, 'forma_pago', f_dame_formapago('ME'))
	ids_caja_exportar_excel.setitem(fila_insert, 'descripcion', 'CORRESPONDIENTE A PAGOS')
	ids_caja_exportar_excel.setitem(fila_insert, 'codigo', dwc_cuadre_pagos.getitemstring(fila, 'id_caja_pagos'))
	ids_caja_exportar_excel.setitem(fila_insert, 'asunto_observaciones', dwc_cuadre_pagos.getitemstring(fila, 'observaciones'))
	ids_caja_exportar_excel.setitem(fila_insert, 'total', dwc_cuadre_pagos.getitemNumber(fila, 'importe'))
NEXT

end subroutine

public function integer wf_generar_factura ();if f_puedo_escribir(g_usuario, '0000000019')= -1 then return -1 

string mensaje = ''
string serie_facturas, id_colegiado, tipo_factura, id_factura, t_iva, id_pagador, nif, nombre, domicilio, poblacion, tipo_persona, n_col
string n_inf, n_fact_unico
int retorno = 1, fila_cabecera, fila_conceptos
double uds, precio, subtotal, subtotal_dto, subtotal_iva, total, porcen_dto, total_importe, total_dto, total_iva, base_imp
st_facturas datos_facturacion


mensaje=mensaje + f_valida(dw_factura_cabecera_external,'fecha','NONULO','Debe especificar la fecha de la factura')
mensaje=mensaje + f_valida(dw_factura_cabecera_external,'tipo_factura','NOVACIO','Debe especificar el Tipo de factura')
mensaje=mensaje + f_valida(dw_factura_cabecera_external,'serie','NONULO','Debe especificar la serie de la factura')
mensaje=mensaje + f_valida(dw_factura_cabecera_external,'id_pagador','NOVACIO','Debe especificar el Pagador de la factura')
mensaje=mensaje + f_valida(dw_factura_cabecera_external,'asunto','NONULO','Debe especificar el asunto de la factura')
// Validamos en los conceptos
mensaje=mensaje + f_valida(dw_factura_conceptos,'t_iva','NOVACIO','Debe especificar el Tipo de IVA')
mensaje=mensaje + f_valida(dw_factura_conceptos,'articulo','NOVACIO','Debe especificar el Art$$HEX1$$ed00$$ENDHEX$$culo')
//mensaje=mensaje + f_valida(dw_1,'cuenta','NOVACIO','Debe especificar un valor en el campo Cuenta.')

//fin 

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
else
	// Procedemos a generar la cabecera de factura
	serie_facturas = dw_factura_cabecera_external.getitemString(1, 'serie')
	tipo_factura  = dw_factura_cabecera_external.getitemString(1, 'tipo_factura')
	
	
	//////////////////////////////////////////////
	// GENERACION LINEAS
	//////////////////////////////////////////////
	datastore ds_lineas_factura 
	ds_lineas_factura = create Datastore
	ds_lineas_factura.DataObject = 'd_fases_lineas_facturas'
	ds_lineas_factura.SetTransObject(SQLCA)

	// Recorremos las lineas para saber cuanto sube la factura
	FOR fila_conceptos = 1 TO dw_factura_conceptos.Rowcount()		
		// Calculamos los totales de la cabecera, por lo que necesitamos coger los datos de las lineas
		uds			= dw_factura_conceptos.getitemnumber(fila_conceptos,'unidades')
		precio		= dw_factura_conceptos.getitemnumber(fila_conceptos,'precio')
		t_iva			= dw_factura_conceptos.getitemstring(fila_conceptos,'t_iva')
		porcen_dto  = dw_factura_conceptos.getitemnumber(fila_conceptos,'porcent_dto')
		if isnull(porcen_dto) then porcen_dto=0
		subtotal 		= dw_factura_conceptos.getitemnumber(fila_conceptos,'subtotal')		
		subtotal_dto 	= subtotal*porcen_dto/100
		// El IVA se calcula despues de descuento
		subtotal_iva 	= f_redondea(f_aplica_t_iva(subtotal - subtotal_dto,t_iva))
		// Evitamos los nulos
		if IsNull(subtotal) then subtotal = 0
		if isnull(uds) then uds=1
		if IsNull(subtotal_dto) then subtotal_dto = 0
		if IsNull(subtotal_iva) then subtotal_iva = 0
		total_importe += subtotal
		total_dto += subtotal_dto		
		total_iva += subtotal_iva
		
		// Colocamos los datos en el datastore para que se puedan luego pasar a la funcion f_factura
		// Uso la notaci$$HEX1$$f300$$ENDHEX$$n dot por ser m$$HEX1$$e100$$ENDHEX$$s r$$HEX1$$e100$$ENDHEX$$pida en ejecucion
		ds_lineas_factura.insertrow(0)
		ds_lineas_factura.object.id_factura[fila_conceptos] = dw_factura_conceptos.object.id_factura[fila_conceptos]
		ds_lineas_factura.object.descripcion[fila_conceptos] = dw_factura_conceptos.object.descripcion[fila_conceptos]
		ds_lineas_factura.object.precio[fila_conceptos] = dw_factura_conceptos.object.precio[fila_conceptos]
		ds_lineas_factura.object.unidades[fila_conceptos] = dw_factura_conceptos.object.unidades[fila_conceptos]
		ds_lineas_factura.object.subtotal[fila_conceptos] = dw_factura_conceptos.object.subtotal[fila_conceptos]
		ds_lineas_factura.object.id_linea[fila_conceptos] = dw_factura_conceptos.object.id_linea[fila_conceptos]
		ds_lineas_factura.object.t_iva[fila_conceptos] = dw_factura_conceptos.object.t_iva[fila_conceptos]
		ds_lineas_factura.object.subtotal_iva[fila_conceptos] = dw_factura_conceptos.object.subtotal_iva[fila_conceptos]
		ds_lineas_factura.object.total[fila_conceptos] = dw_factura_conceptos.object.total[fila_conceptos]
		ds_lineas_factura.object.articulo[fila_conceptos] = dw_factura_conceptos.object.articulo[fila_conceptos]
		ds_lineas_factura.object.porcent_dto[fila_conceptos] = dw_factura_conceptos.object.porcent_dto[fila_conceptos]
		ds_lineas_factura.object.descripcion_larga[fila_conceptos] = dw_factura_conceptos.object.descripcion_larga[fila_conceptos]
		ds_lineas_factura.object.proyecto[fila_conceptos] = dw_factura_conceptos.object.proyecto[fila_conceptos]
		ds_lineas_factura.object.fecha[fila_conceptos] = dw_factura_conceptos.object.fecha[fila_conceptos]
	NEXT
	base_imp = total_importe - total_dto
	//////////////////////////////////////////////
	// FIN GENERACION LINEAS
	//////////////////////////////////////////////

	// Abrimos la ventana de cobros
	st_caja_cobros parametros
	parametros.tipo = 'FACTURA_NUEVA'
	parametros.cantidad_pagar = f_redondea(total_importe+total_iva)
	parametros.fecha_pago = dw_factura_cabecera_external.getitemDatetime(1, 'fecha')
	parametros.dw = dw_factura_cabecera_external
	openwithparm(w_caja_pagos, parametros)
	if isvalid(message.powerobjectparm) then
		parametros = message.powerobjectparm
	else
		parametros.realizado = false
	end if
	// Es que ha cancelado	
	if parametros.realizado = false then
		destroy ds_lineas_factura		
		return -1
	end if	
	if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
	
	//////////////////////////////////////////////
	// PONEMOS LOS DATOS EN LA ESTRUCTURA
	//////////////////////////////////////////////
	datos_facturacion.formapago		= parametros.forma_pago
	datos_facturacion.serie				= serie_facturas
	if g_colegio = 'COAATCC' or g_colegio = 'COAATMCA' then datos_facturacion.fecha_factura =dw_factura_cabecera_external.getitemDatetime(1, 'fecha')
	datos_facturacion.fecha				= dw_factura_cabecera_external.getitemDatetime(1, 'fecha')
	datos_facturacion.num_originales	= double(parametros.n_originales)
	datos_facturacion.num_copias		= double(parametros.n_copias)
	datos_facturacion.asunto			= dw_factura_cabecera_external.getitemString(1, 'asunto')
	datos_facturacion.obs				= dw_factura_cabecera_external.getitemString(1, 'obs')
	datos_facturacion.es_colegiado	= true
	datos_facturacion.pagada			= 'S'
	datos_facturacion.banco				= parametros.banco
	datos_facturacion.incluir_todos  = 'S'
	datos_facturacion.proyecto 		= g_explotacion_por_defecto
	datos_facturacion.impresion_formato = parametros.impresion_formato
	
	CHOOSE CASE tipo_factura 
		CASE '1'
			datos_facturacion.tipo_factura = g_colegio_colegiado
		CASE '3'
			datos_facturacion.tipo_factura = g_colegio_cliente
	END CHOOSE
	datos_facturacion.id_receptor = dw_factura_cabecera_external.getitemString(1, 'id_pagador')
	/* 		FALTA SABER QUE HACER SI LA SERIE NO ES OBLIGATORIA	*/
	/*
	if f_es_vacio(serie_facturas) then
		n_inf=f_siguiente_n_fact_emitida(tipo_factura,serie_facturas,f_colegiado_id_col(emisor),dw_factura_cabecera_external.getitemDatetime(1, 'fecha'))
		n_inf_unico=f_siguiente_numero('SERIE_UNICA',10)
	end if
	*/
	// Pasamos el datastore
	datos_facturacion.ds_lineas = ds_lineas_factura
	retorno = 1
	
	// Modificado David 13/02/2006 - Llamamos a la funci$$HEX1$$f300$$ENDHEX$$n que a$$HEX1$$f100$$ENDHEX$$adir$$HEX2$$e1002000$$ENDHEX$$una linea a la factura para la comisi$$HEX1$$f300$$ENDHEX$$n de la tarjeta
	datos_facturacion.comision_tarjeta = parametros.comision_tarjeta
	// Pasamos el objeto de impresi$$HEX1$$f300$$ENDHEX$$n
	datos_facturacion.impresion_formato = parametros.impresion_formato
	
	//////////////////////////////////////////////
	// GENERACION FACTURA
	//////////////////////////////////////////////
	if f_factura(datos_facturacion) = '-1' then retorno = -1
	//////////////////////////////////////////////
	// FIN GENERACION FACTURA
	//////////////////////////////////////////////
	
	destroy ds_lineas_factura
end if

return retorno
end function

public subroutine wf_insertar_incidencia_contrato (string id_fase, string estado);// Funci$$HEX1$$f300$$ENDHEX$$n que inserta una incidencia en el contrato indicando que se ha despachado en un estado indebido
string id_inc, codigo, obs
datetime fecha

id_inc = f_siguiente_numero('INCIDENCIAS-EXP', 10)
fecha = datetime(today())
codigo = '0001' //Avisos
obs = 'El contrato se ha despachado estando en estado ' + f_obtener_estado(estado)

INSERT INTO incidencias_fases  
	( id_incidencias, id_fase, fecha, codigo, observaciones )  
VALUES 
	( :id_inc, :id_fase, :fecha, :codigo, :obs )  ;

commit;

end subroutine

public subroutine wf_imprimir_etiqueta (string id, string numero);integer iResultado

//messagebox('', numero)
Run ("python c:\sica\ticket.py " + numero)
iResultado = MessageBox(g_titulo, "$$HEX1$$bf00$$ENDHEX$$Desea otro ticket para este proyecto?", Exclamation!, OKCancel!,2)
if iResultado = 1 then
	Run ("python c:\sica\ticket.py " + numero)
end if


//// EVENTO QUE REALIZA LA IMPRESION DE UN TICKET
//
//string sl_impresora_defecto, sl_impresora_tickets_ini
//string sl_descripcion_fase
//n_cst_printer_new impresora_tickets
//
//
//// Cogemos la impresora del ini
//sl_impresora_tickets_ini = Profilestring(gnv_app.of_GetAppInifile(),"Parametros","ImpresoraTicketsSalida","")
//if f_es_vacio(sl_impresora_tickets_ini) then	return
//
//// Creamos un gestor de impresoras, para poder cambiar como por defecto la impresora del ini, guardandonos 
//// primero cual hay por defecto ahora
//impresora_tickets = create n_cst_printer_new
//sl_impresora_defecto = impresora_tickets.of_getdefaultprinter()
//impresora_tickets.of_setdefaultprinter(sl_impresora_tickets_ini)
//
//// Imprimimos la etiqueta, con un mensaje entre 2 impresiones para que puedan cortarla
//datastore ds_impresion
//ds_impresion = create datastore
//ds_impresion.dataObject = 'd_resguardo_salida'
//
//ds_impresion.insertrow(0)
//ds_impresion.setitem(1,'num_exp_1',numero)
//ds_impresion.setitem(1,'f_entrada',today())
//ds_impresion.setitem(1,'centro',f_dame_descripcion_delegacion())
//ds_impresion.setitem(1,'id_fase','*'+numero+'*')
//
//ds_impresion.print()
////MessageBox(g_titulo, "Corte el ticket antes de continuar")
//ds_impresion.print()
//
//// Restauramos la impresora por defecto
//impresora_tickets.of_setdefaultprinter(sl_impresora_defecto)
//
//destroy ds_impresion
//destroy impresora_tickets
//

end subroutine

public subroutine wf_generar_liquidacion ();datetime f_nula, f_liquidacion, f_entrada
string dest, id_col, id_cli, id_factura, centro, i_id_liq
double total, total_factura
long linea
setnull(f_nula)

dest = dw_caja_pagos_caja.getitemstring(1,'destinatario')
id_col = dw_caja_pagos_caja.getitemstring(1,'id_colegiado')
id_cli = dw_caja_pagos_caja.getitemstring(1,'id_cliente')
id_factura = dw_caja_pagos_caja.getitemstring(1,'id_factura')
total = dw_caja_pagos_caja.getitemnumber(1,'importe')
f_liquidacion = dw_caja_pagos_caja.getitemdatetime(1,'f_liquidacion')
f_entrada = dw_caja_pagos_caja.getitemdatetime(1,'f_entrada')
centro = dw_caja_pagos_caja.getitemstring(1,'centro')

linea= dw_caja_pagos_caja_lista.InsertRow(0)

i_id_liq = f_siguiente_numero('LIQUIDACIONES',10)
dw_caja_pagos_caja_lista.SetItem(linea,'id_liquidacion',i_id_liq)
dw_caja_pagos_caja_lista.SetItem(linea,'f_liquidacion',f_liquidacion)
dw_caja_pagos_caja_lista.SetItem(linea,'f_entrada',f_entrada)
dw_caja_pagos_caja_lista.SetItem(linea,'estado','P')
dw_caja_pagos_caja_lista.SetItem(linea,'contabilizada','N')
dw_caja_pagos_caja_lista.SetItem(linea,'forma_pago',dw_caja_pagos_caja.getitemstring(1,'forma_pago'))
dw_caja_pagos_caja_lista.SetItem(linea,'importe',total)
dw_caja_pagos_caja_lista.SetItem(linea,'n_documento','')

if dw_caja_pagos_caja.getitemstring(1,'forma_pago') = 'ME' then dw_caja_pagos_caja_lista.SetItem(linea,'estado','L')
choose case dest
	case 'CO'
		dw_caja_pagos_caja_lista.SetItem(linea,'id_colegiado',id_col)
		dw_caja_pagos_caja_lista.SetItem(linea,'nombre',f_colegiado_apellido(id_col))
		dw_caja_pagos_caja_lista.SetItem(linea,'banco',gnv_control_cuentas_bancarias.of_obtener_iban_nombre_modulo ('COL_REMESABLE',id_col) )
	case 'CL'
		dw_caja_pagos_caja_lista.SetItem(linea,'id_beneficiario',id_cli)
		dw_caja_pagos_caja_lista.SetItem(linea,'nombre',f_dame_cliente(id_cli))
		dw_caja_pagos_caja_lista.SetItem(linea,'banco',gnv_control_cuentas_bancarias.of_obtener_iban_nombre_modulo ('CLIENTES',id_cli) )
	case 'OT'
		dw_caja_pagos_caja_lista.SetItem(linea,'nombre',dw_caja_pagos_caja.getitemstring(1,'nombre_otro'))
		dw_caja_pagos_caja_lista.SetItem(linea,'contrapartida',dw_caja_pagos_caja.getitemstring(1,'contrapartida'))
end choose
dw_caja_pagos_caja_lista.SetItem(linea,'cta_pago','')
dw_caja_pagos_caja_lista.SetItem(linea,'descripcion_larga',dw_caja_pagos_caja.getitemstring(1,'descripcion'))
// El campo tipo de liquidaci$$HEX1$$f300$$ENDHEX$$n diferencia entre: 1-Premaat, 2-Garant$$HEX1$$ed00$$ENDHEX$$as, 3-Otros.
dw_caja_pagos_caja_lista.SetItem(linea,'tipo','3')
dw_caja_pagos_caja_lista.SetItem(linea,'id_fase','')
dw_caja_pagos_caja_lista.SetItem(linea,'id_factura',id_factura)
dw_caja_pagos_caja_lista.SetItem(linea,'centro',centro)
dw_caja_pagos_caja_lista.SetItem(linea,'mensual',dw_caja_pagos_caja.getitemstring(1,'mensual'))

dw_caja_pagos_caja_lista.SetItem(linea,'cod_usuario',g_usuario)
dw_caja_pagos_caja_lista.SetItem(linea,'empresa',g_empresa) // se inserta el valor de la empresa del usuario que entr$$HEX2$$f3002000$$ENDHEX$$en la aplicaci$$HEX1$$f300$$ENDHEX$$n

// Modificado por Ricardo 04-05-10

if dw_caja_pagos_caja_lista.Update()<>1 then
	Messagebox(g_titulo, "Error al generar la liquidaci$$HEX1$$f300$$ENDHEX$$n correspondiente", stopsign!)
else
	if not f_es_vacio(id_factura) then
		update csi_facturas_emitidas set formadepago = 'LI' where id_factura = :id_factura;
		if SQLCA.sqlcode <> 0 then Messagebox(g_titulo, "Error al actualizar la forma de pago de la factura a liquidaci$$HEX1$$f300$$ENDHEX$$n", stopsign!)
		// Hay que marcarla como pagada en el caso que cubra toda la factura
		select total into :total_factura from csi_facturas_emitidas where id_factura = :id_factura;
		
		if total_factura <0 then
			if (total - total_factura)> - 0.01 then
				// Hay que marcarla como pagada
				update csi_facturas_emitidas set pagado = 'S', f_pago = :f_liquidacion where id_factura = :id_factura;
				if SQLCA.sqlcode <> 0 then Messagebox(g_titulo, "Error al actualizar el pagado de la factura", stopsign!)
				//Debemos marcar todos los cobros no contabilizados
				update csi_cobros set pagado = 'S', f_pago = :f_liquidacion, forma_pago ='LI' where id_factura = :id_factura;
				if SQLCA.sqlcode <> 0 then Messagebox(g_titulo, "Error al actualizar los cobros", stopsign!)
			end if
		else
			if (total_factura - total)> - 0.01 then
				// Hay que marcarla como pagada
				update csi_facturas_emitidas set pagado = 'S', f_pago = :f_liquidacion where id_factura = :id_factura;
				if SQLCA.sqlcode <> 0 then Messagebox(g_titulo, "Error al actualizar el pagado de la factura", stopsign!)
				//Debemos marcar todos los cobros no contabilizados
				update csi_cobros set pagado = 'S', f_pago = :f_liquidacion, forma_pago ='LI' where id_factura = :id_factura;
				if SQLCA.sqlcode <> 0 then Messagebox(g_titulo, "Error al actualizar los cobros", stopsign!)
			end if
		end if
		
	end if
end if
// Modificado por Ricardo 04-05-10

string sql_nuevo 
sql_nuevo = dw_caja_pagos_caja_lista.describe("datawindow.table.select")
f_sql('premaat_liquidaciones.f_entrada','>=','f_entrada',dw_caja_pagos_caja,sql_nuevo,g_tipo_base_datos,'')
dw_caja_pagos_caja_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
dw_caja_pagos_caja_lista.retrieve(g_usuario)


end subroutine

on w_caja.create
int iCurrent
call super::create
this.cb_salir=create cb_salir
this.dw_datos_contrato=create dw_datos_contrato
this.cb_cancelar=create cb_cancelar
this.cb_grabar_pagos=create cb_grabar_pagos
this.cb_marcar=create cb_marcar
this.cb_desmarcar=create cb_desmarcar
this.dw_caja_formapago=create dw_caja_formapago
this.cb_cobrar=create cb_cobrar
this.dw_caja_contratos_expediente=create dw_caja_contratos_expediente
this.dw_factura_conceptos=create dw_factura_conceptos
this.dw_listado_cuadre_caja=create dw_listado_cuadre_caja
this.dw_caja_pagos_caja_lista=create dw_caja_pagos_caja_lista
this.dw_facturas_emitidas=create dw_facturas_emitidas
this.cb_buscar_facturas_emitidas=create cb_buscar_facturas_emitidas
this.dw_facturas_emitidas_busqueda=create dw_facturas_emitidas_busqueda
this.dw_factura_cabecera_external=create dw_factura_cabecera_external
this.dw_dar_salida_expediente=create dw_dar_salida_expediente
this.dw_avisos=create dw_avisos
this.dw_caja_pagos_caja=create dw_caja_pagos_caja
this.dw_busqueda_avisos=create dw_busqueda_avisos
this.dw_seleccion_funcionamiento=create dw_seleccion_funcionamiento
this.dw_listado_cuadre_busqueda=create dw_listado_cuadre_busqueda
this.cb_buscar_avisos=create cb_buscar_avisos
this.dw_caja_pagos_consulta=create dw_caja_pagos_consulta
this.cb_consultar_pagos=create cb_consultar_pagos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_salir
this.Control[iCurrent+2]=this.dw_datos_contrato
this.Control[iCurrent+3]=this.cb_cancelar
this.Control[iCurrent+4]=this.cb_grabar_pagos
this.Control[iCurrent+5]=this.cb_marcar
this.Control[iCurrent+6]=this.cb_desmarcar
this.Control[iCurrent+7]=this.dw_caja_formapago
this.Control[iCurrent+8]=this.cb_cobrar
this.Control[iCurrent+9]=this.dw_caja_contratos_expediente
this.Control[iCurrent+10]=this.dw_factura_conceptos
this.Control[iCurrent+11]=this.dw_listado_cuadre_caja
this.Control[iCurrent+12]=this.dw_caja_pagos_caja_lista
this.Control[iCurrent+13]=this.dw_facturas_emitidas
this.Control[iCurrent+14]=this.cb_buscar_facturas_emitidas
this.Control[iCurrent+15]=this.dw_facturas_emitidas_busqueda
this.Control[iCurrent+16]=this.dw_factura_cabecera_external
this.Control[iCurrent+17]=this.dw_dar_salida_expediente
this.Control[iCurrent+18]=this.dw_avisos
this.Control[iCurrent+19]=this.dw_caja_pagos_caja
this.Control[iCurrent+20]=this.dw_busqueda_avisos
this.Control[iCurrent+21]=this.dw_seleccion_funcionamiento
this.Control[iCurrent+22]=this.dw_listado_cuadre_busqueda
this.Control[iCurrent+23]=this.cb_buscar_avisos
this.Control[iCurrent+24]=this.dw_caja_pagos_consulta
this.Control[iCurrent+25]=this.cb_consultar_pagos
end on

on w_caja.destroy
call super::destroy
destroy(this.cb_salir)
destroy(this.dw_datos_contrato)
destroy(this.cb_cancelar)
destroy(this.cb_grabar_pagos)
destroy(this.cb_marcar)
destroy(this.cb_desmarcar)
destroy(this.dw_caja_formapago)
destroy(this.cb_cobrar)
destroy(this.dw_caja_contratos_expediente)
destroy(this.dw_factura_conceptos)
destroy(this.dw_listado_cuadre_caja)
destroy(this.dw_caja_pagos_caja_lista)
destroy(this.dw_facturas_emitidas)
destroy(this.cb_buscar_facturas_emitidas)
destroy(this.dw_facturas_emitidas_busqueda)
destroy(this.dw_factura_cabecera_external)
destroy(this.dw_dar_salida_expediente)
destroy(this.dw_avisos)
destroy(this.dw_caja_pagos_caja)
destroy(this.dw_busqueda_avisos)
destroy(this.dw_seleccion_funcionamiento)
destroy(this.dw_listado_cuadre_busqueda)
destroy(this.cb_buscar_avisos)
destroy(this.dw_caja_pagos_consulta)
destroy(this.cb_consultar_pagos)
end on

event key;call super::key;// Dependiendo de la tecla de funci$$HEX1$$f300$$ENDHEX$$n que se pulse debemos hacer una cosa u otra

long fila
fila = dw_seleccion_funcionamiento.GetRow()
string opciones_existentes

// Cogemos las posibles opciones que tiene este colegio
opciones_existentes = dw_seleccion_funcionamiento.describe("opcion_funcionamiento.values")+'/'

CHOOSE CASE key
	CASE keyF1!
		// Colocamos el radio button para de expedientes
		if PosA(opciones_existentes, "1/") = 0 then return // Con esta linea miramos si la opcion est$$HEX2$$e1002000$$ENDHEX$$disponible para ese colegio 
		dw_seleccion_funcionamiento.setitem(fila, 'opcion_funcionamiento', '1')
		this.post event csd_preparar_ventana('1')
	CASE keyF2!
		// Colocamos el radio button para una factura nueva
		if PosA(opciones_existentes, "2/") = 0 then return // Con esta linea miramos si la opcion est$$HEX2$$e1002000$$ENDHEX$$disponible para ese colegio 
		dw_seleccion_funcionamiento.setitem(fila, 'opcion_funcionamiento', '2')
		this.post event csd_preparar_ventana('2')
	CASE keyF3!
		// Colocamos el radio button para facturas ya emitidas
		if PosA(opciones_existentes, "3/") = 0 then return // Con esta linea miramos si la opcion est$$HEX2$$e1002000$$ENDHEX$$disponible para ese colegio 
		dw_seleccion_funcionamiento.setitem(fila, 'opcion_funcionamiento', '3')
		this.post event csd_preparar_ventana('3')
	CASE keyF4!
		// Colocamos el radio button para pagos caja
		if PosA(opciones_existentes, "4/") = 0 then return // Con esta linea miramos si la opcion est$$HEX2$$e1002000$$ENDHEX$$disponible para ese colegio 
		dw_seleccion_funcionamiento.setitem(fila, 'opcion_funcionamiento', '4')
		this.post event csd_preparar_ventana('4')
	CASE keyF5!
		// Colocamos el radio button para salida de expedientes
		if PosA(opciones_existentes, "5/") = 0 then return // Con esta linea miramos si la opcion est$$HEX2$$e1002000$$ENDHEX$$disponible para ese colegio 
		dw_seleccion_funcionamiento.setitem(fila, 'opcion_funcionamiento', '5')
		this.post event csd_preparar_ventana('5')
	CASE keyF6!
		// Colocamos el radio button para carta ayto
		if PosA(opciones_existentes, "6/") = 0 then return // Con esta linea miramos si la opcion est$$HEX2$$e1002000$$ENDHEX$$disponible para ese colegio 
		dw_seleccion_funcionamiento.setitem(fila, 'opcion_funcionamiento', '6')
		this.post event csd_preparar_ventana('6')
	CASE keyF7!
		// Colocamos el radio button para el listado de cuadre de caja
		if PosA(opciones_existentes, "7/") = 0 then return // Con esta linea miramos si la opcion est$$HEX2$$e1002000$$ENDHEX$$disponible para ese colegio 
		dw_seleccion_funcionamiento.setitem(fila, 'opcion_funcionamiento', '7')
		this.post event csd_preparar_ventana('7')
	CASE keyF9!
		// Colocamos el radio button para las proformas pendientes
		if PosA(opciones_existentes, "9/") = 0 then return // Con esta linea miramos si la opcion est$$HEX2$$e1002000$$ENDHEX$$disponible para ese colegio 
		dw_seleccion_funcionamiento.setitem(fila, 'opcion_funcionamiento', '9')
		this.post event csd_preparar_ventana('9')
END CHOOSE

end event

event open;call super::open;// Requiere que la ventana w_fases_detalle est$$HEX2$$e9002000$$ENDHEX$$cerrada, por lo que no la dejar$$HEX2$$e9002000$$ENDHEX$$abrir mientras la otra ventana est$$HEX2$$e9002000$$ENDHEX$$abierta
st_cobrar_avisos_za lst_datos_entrada

f_centrar_ventana(this)

// MODIFICADO RICARDO 2005-01-13 PARA ZARAGOZA
if isvalid(message.powerobjectparm) then
	ist_datos_entrada = message.powerobjectparm
end if

if not(f_es_vacio(message.stringparm)) then
	i_modulo=message.stringparm
end if


// De momento los nuevos modos los dejamos solo en tenerife hasta que lo pueda hacer extensible a todo
// Llamamos al control de eventos con el dw_honorarios
st_control_eventos c_evento
c_evento.evento = 'ABRIR_CAJA'
c_evento.dw = dw_seleccion_funcionamiento
if f_control_eventos(c_evento)=-1 then return

// MODIFICADO RICARDO 04-07-07
// Llamamos al control de eventos evento 'ABRIR_LISTA_FASES' (aunque tambien sirve para lo de caja)

// MODIFICADO RICARDO 04-07-07

// Colocamos una opcion por defecto, y elijo la primera
dw_seleccion_funcionamiento.setitem(dw_seleccion_funcionamiento.RowCount(), 'opcion_funcionamiento', '1')
this.post event csd_preparar_ventana('1')


ids_caja_pagos_caja_recibo = create datastore
ids_caja_pagos_caja_recibo.dataobject = 'd_caja_pagos_caja_recibo' 
ids_caja_pagos_caja_recibo.SetTransObject(SQLCA)

this.post event csd_abrir_con_busqueda(ist_datos_entrada)

end event

event pfc_close();call super::pfc_close;// Destruimos el datastore
if isvalid (ids_caja_pagos_caja_recibo) then destroy (ids_caja_pagos_caja_recibo)

end event

event pfc_postopen;call super::pfc_postopen;

// La parte de la cabecera de las facturas
// Colocamos el calendario
dw_factura_cabecera_external.of_SetDropDownCalendar(True)
dw_factura_cabecera_external.iuo_calendar.of_register(dw_factura_cabecera_external.iuo_calendar.DDLB)
dw_factura_cabecera_external.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_factura_cabecera_external.iuo_calendar.of_SetInitialValue(True)


// La parte de los pagos de caja
// Colocamos el calendario
dw_caja_pagos_caja.of_SetDropDownCalendar(True)
dw_caja_pagos_caja.iuo_calendar.of_register(dw_caja_pagos_caja.iuo_calendar.DDLB)
dw_caja_pagos_caja.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_caja_pagos_caja.iuo_calendar.of_SetInitialValue(True)

// La parte de facturas/proformas pendientes
// Colocamos el calendario
dw_facturas_emitidas_busqueda.of_SetDropDownCalendar(True)
dw_facturas_emitidas_busqueda.iuo_calendar.of_register(dw_facturas_emitidas_busqueda.iuo_calendar.DDLB)
dw_facturas_emitidas_busqueda.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_facturas_emitidas_busqueda.iuo_calendar.of_SetInitialValue(True)


// Colocamos el calendario en la lista de pagos
dw_caja_pagos_caja_lista.of_SetDropDownCalendar(True)
dw_caja_pagos_caja_lista.iuo_calendar.of_register(dw_caja_pagos_caja_lista.iuo_calendar.DDLB)
dw_caja_pagos_caja_lista.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_caja_pagos_caja_lista.iuo_calendar.of_SetInitialValue(True)

if g_colegio <> 'COAATTFE' then
	dw_listado_cuadre_busqueda.dataobject = 'd_caja_list_cuadre_busq_mca'
	dw_listado_cuadre_busqueda.settransobject(SQLCA)
	dw_listado_cuadre_caja.dataobject = 'd_caja_salidas_listado_cm'
	dw_listado_cuadre_caja.settransobject(SQLCA)
	dw_caja_pagos_caja.dataobject = 'd_caja_liquidacion_generar_mca'
	dw_caja_pagos_caja.settransobject(SQLCA)
	dw_caja_pagos_caja.insertrow(0)
	dw_caja_pagos_caja_lista.dataobject = 'd_caja_liquid_lista_caja'
	dw_caja_pagos_caja_lista.settransobject(SQLCA)
	dw_avisos.dataobject='d_caja_avisos_pendientes_mca'
	dw_avisos.settransobject(SQLCA)

	dw_caja_pagos_caja.of_SetDropDownCalendar(True)
	dw_caja_pagos_caja.iuo_calendar.of_register(dw_caja_pagos_caja.iuo_calendar.DDLB)
	dw_caja_pagos_caja.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
	dw_caja_pagos_caja.iuo_calendar.of_SetInitialValue(True)

end if
// Colocamos el calendario en Listado de cuadre de caja
dw_listado_cuadre_busqueda.of_SetDropDownCalendar(True)
dw_listado_cuadre_busqueda.iuo_calendar.of_register(dw_listado_cuadre_busqueda.iuo_calendar.DDLB)
dw_listado_cuadre_busqueda.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_listado_cuadre_busqueda.iuo_calendar.of_SetInitialValue(True)

// Colocamos el calendario
dw_caja_pagos_consulta.of_SetDropDownCalendar(True)
dw_caja_pagos_consulta.iuo_calendar.of_register(dw_caja_pagos_consulta.iuo_calendar.DDLB)
dw_caja_pagos_consulta.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_caja_pagos_consulta.iuo_calendar.of_SetInitialValue(True)

if i_modulo='AVISOS' then
	dw_seleccion_funcionamiento.SetItem(1,'opcion_funcionamiento','8')
	dw_seleccion_funcionamiento.event itemchanged(1,dw_seleccion_funcionamiento.object.opcion_funcionamiento,'8')
	cb_buscar_avisos.post event clicked()
end if



end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_caja
integer taborder = 130
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_caja
end type

type cb_salir from commandbutton within w_caja
integer x = 3063
integer y = 1764
integer width = 567
integer height = 88
integer taborder = 260
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;// Cerraremos la ventana si se puede

int retorno

retorno = parent.trigger event closequery() // No deberiamos tener nada que ver con el closequery en esta ventana
if retorno = 1 then return

// Destruimos el datastore
if isvalid (ids_caja_pagos_caja_recibo) then destroy (ids_caja_pagos_caja_recibo)

// Cerramos la ventana
close(parent)


end event

type dw_datos_contrato from u_dw within w_caja
boolean visible = false
integer x = 105
integer y = 1084
integer width = 2917
integer height = 624
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_caja_datos_contrato"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event key;call super::key;// LLamamos al key de la ventana
parent.trigger event key(key, keyflags)

end event

event csd_tecla;call super::csd_tecla;parent.event key (key, keyflags)
end event

type cb_cancelar from commandbutton within w_caja
boolean visible = false
integer x = 1984
integer y = 1764
integer width = 567
integer height = 88
integer taborder = 240
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
end type

event clicked;dw_dar_salida_expediente.reset()
dw_dar_salida_expediente.insertrow(0)
dw_datos_contrato.reset()
dw_datos_contrato.insertrow(0)
end event

type cb_grabar_pagos from commandbutton within w_caja
integer x = 2222
integer y = 1764
integer width = 567
integer height = 88
integer taborder = 250
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Actualizar &Pagos Modif."
end type

event clicked;// Simplemente hacemos las mismas validaciones que para los otros cobros
//:O
long fila
double importe
string mensaje = ''

// Es para pagos de la caja... Solo impediremos que el importe sea 0
FOR fila = 1 TO dw_caja_pagos_caja_lista.RowCount()
	importe = dw_caja_pagos_caja_lista.GetitemNumber(fila, 'importe')
	if isnull(importe) or importe = 0 then mensaje += "Debe indicar un importe valido (fila "+string(fila)+")"+cr
NEXT
mensaje += f_valida(dw_caja_pagos_caja_lista, 'fecha', 'NONULO', "Debe indicar una fecha v$$HEX1$$e100$$ENDHEX$$lida")
if not f_es_vacio(mensaje) then
	Messagebox(g_titulo, mensaje, stopsign!)
	return
end if
	
// Grabamos el dw
if dw_caja_pagos_caja_lista.update()>0 then Messagebox(g_titulo, "Actualizados los pagos de Caja")

	
end event

type cb_marcar from commandbutton within w_caja
boolean visible = false
integer x = 18
integer y = 1764
integer width = 411
integer height = 88
integer taborder = 210
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Marcar Todo"
end type

event clicked;int i

CHOOSE CASE is_opcion_ventana
	CASE '1' ,'8'
		for i = 1 to dw_avisos.rowcount()
			dw_avisos.setitem(i, 'procesar', 'S')
		next
				
	CASE '3', '9'
		for i = 1 to dw_facturas_emitidas.rowcount()
			dw_facturas_emitidas.setitem(i, 'procesar', 'S')
		next
END CHOOSE

end event

type cb_desmarcar from commandbutton within w_caja
boolean visible = false
integer x = 430
integer y = 1764
integer width = 434
integer height = 88
integer taborder = 220
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Desmarcar Todo"
end type

event clicked;int i

CHOOSE CASE is_opcion_ventana
	CASE '1','8'
		for i = 1 to dw_avisos.rowcount()
			dw_avisos.setitem(i, 'procesar', 'N')
		next
				
	CASE '3', '9'
		for i = 1 to dw_facturas_emitidas.rowcount()
			dw_facturas_emitidas.setitem(i, 'procesar', 'N')
		next
END CHOOSE

end event

type dw_caja_formapago from u_dw within w_caja
boolean visible = false
integer x = 1925
integer y = 1756
integer width = 1115
integer height = 108
integer taborder = 11
boolean bringtotop = true
string dataobject = "ds_caja_formapago"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.visible = false
datawindowchild dwc_forma_pago
// Capturamos el desplegable
this.getchild ('formapago', dwc_forma_pago)
dwc_forma_pago.settransobject (SQLCA)
dwc_forma_pago.setfilter("tipo_pago <>'CM'")
dwc_forma_pago.filter()

end event

type cb_cobrar from commandbutton within w_caja
integer x = 1317
integer y = 1768
integer width = 567
integer height = 88
integer taborder = 230
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cobrar"
end type

event clicked;string mensaje='', nombre_pagador='', pagador='', id_persona='', tipo_factura='', id_factura, n_talon, susceptible
string id_fase, n_salida, id_fase_ant, mensajes_salida='', unico_n_salida, n_salida_primero='', id_minuta
string id_factura_ultima_generada, id_factura_ultima_generada_despues, orden_apunte, ls_tipo_actuacion, n_salida_ant
boolean b_multiples_pagadores = false, b_abrir_ventana = false, b_marcado_alguno = false, b_desmarcados = false
long fila, fila_cobros
double total_por_pagar, importe
int respuesta_imprimir, copias
datetime fecha_pago
st_caja_cobros parametros

dw_facturas_emitidas.AcceptText()

//majid 
long l_fila_seleccionada 

l_fila_seleccionada = dw_facturas_emitidas.getrow()
//parametros.empresa= dw_facturas_emitidas.getitemstring(l_fila_seleccionada, 'csi_facturas_emitidas_empresa' )

if( dw_facturas_emitidas.RowCount()>0) then 
       parametros.empresa= dw_facturas_emitidas.getitemstring(l_fila_seleccionada, 'csi_facturas_emitidas_empresa' )
else 
	   parametros.empresa= g_empresa
end if 




//SCP-853 - Se desactiva el bot$$HEX1$$f300$$ENDHEX$$n y en cada return se vuelve a activar, incluido al final
this.Enabled = false

CHOOSE CASE is_opcion_ventana
	CASE '1'
		// Caso de estar haciendo un cobro de facturas de expedientes
		/* MODIFICADO RICARDO 04-03-01
			Se ha solicitado que se puedan pagar facturas de varios clientes a la vez :O
			Avisamos pero dejamos continuar
		*/
			
		// Miraremos si hay m$$HEX1$$e100$$ENDHEX$$s de un pagador marcado
		FOR fila = 1 TO dw_avisos.RowCount()
			// Modificado Ricardo 2005-04-11
			if dw_avisos.GetItemString(fila, 'procesar') = 'S' then
				if f_fase_puede_cobrarse_aviso_estado(dw_avisos.GetItemString(fila, 'estado'), false)<1 then
					// tenemos que desmarcar este aviso
					dw_avisos.SetItem(fila, 'procesar', 'N')
					b_desmarcados = true
				end if
			end if
			// Modificado Ricardo 2005-04-11
			
			if dw_avisos.GetItemString(fila, 'procesar') = 'S' then
				b_marcado_alguno = true
				// Solo en este caso miramos el pagador
				// Al pulsar procesar se marcar$$HEX1$$e100$$ENDHEX$$n todos los correspondientes al pagador
				if f_es_vacio(nombre_pagador) and f_es_vacio(pagador) then
					nombre_pagador = dw_avisos.getitemString(fila, 'nombre_pagador')
					pagador = dw_avisos.getitemString(fila, 'pagador')
				else
					if nombre_pagador <> dw_avisos.getitemString(fila, 'nombre_pagador') or pagador <> dw_avisos.getitemString(fila, 'pagador') then
						b_multiples_pagadores = true
						exit
					end if
				end if
			end if
		NEXT
		
		if b_desmarcados then 
			Messagebox(g_titulo, 'Algunos avisos han sido desmarcados por estar en un estado en que no se permite cobrar')
		end if
		
		if not b_marcado_alguno then
			MessageBox(g_titulo, "Ning$$HEX1$$fa00$$ENDHEX$$n aviso ha sido marcado", stopsign!)
			this.Enabled = true
			return
		end if
		
		if b_multiples_pagadores then
			if Messagebox(g_titulo, "Hay m$$HEX1$$e100$$ENDHEX$$s de un pagador marcado"+cr+"$$HEX1$$bf00$$ENDHEX$$Desea continuar de todos modos?", question!, yesno!, 2)= 2 then
				this.Enabled = true 
				return
			end if
		end if

		// Vamos a mirar si alguna de las minutas marcadas, la de gastos supera los honorarios
		mensaje = ''
		FOR fila = 1 TO dw_avisos.RowCount()
			if dw_avisos.GetItemString(fila, 'procesar') = 'S' then
				
				if dw_avisos.GetItemString(fila,'tipo_gestion') = 'C' then
					if dw_avisos.GetItemNumber(fila,'total_cliente') < dw_avisos.GetItemNumber(fila,'total_colegiado') then
						// En Zaragoza cuando no hay honorarios y si hay gastos no debe aparecer el mensaje
						if not((g_colegio='COAATZ' or g_colegio='COAATGU') and dw_avisos.getitemnumber(fila, 'base_honos')=0 and dw_avisos.GetItemNumber(fila,'total_colegiado')>0) then
							mensaje += cr + 'N$$HEX2$$ba002000$$ENDHEX$$AVISO '+dw_avisos.GetItemString(fila,'n_aviso')+': El total de la Factura de Gastos (' + string(dw_avisos.GetItemNumber(fila,'total_colegiado'), "#,##0.00")+') supera al total de la Factura de Honorarios (' + string(dw_avisos.GetItemNumber(fila,'total_cliente'), "#,##0.00") +')'
						end if
					end if
				end if
			end if
		NEXT
		if LenA(mensaje)>0 then
			mensaje += cr + cr +'Si sigue con el proceso de cobro la diferencia se cargar$$HEX2$$e1002000$$ENDHEX$$contablemente en la(s) cuenta(s) de colegiado(s) que podr$$HEX1$$e100$$ENDHEX$$(n) quedar deudora(s)'
			mensaje += cr + cr +'$$HEX1$$bf00$$ENDHEX$$Desea continuar de todas formas?'
			if messagebox(g_titulo, mensaje, question!, yesno!, 2)=2 then 
				this.Enabled = true 
				return
			end if
		end if

		if dw_avisos.RowCount()>0  then 
			id_factura_ultima_generada = f_siguiente_numero_informativo("FACTUEMI", 10)
			// Si llegamos aqu$$HEX2$$ed002000$$ENDHEX$$podemos seguir el procesado
			parametros.tipo = 'AVISOS'
			parametros.dw = dw_avisos
			if g_usa_cobros_multiples = 'N' then
				openwithparm(w_caja_pagos, parametros) // -->LLamada que se realizaba antiguamente
				// Obtenemos los datos de vuelta
				if isvalid(message.powerobjectparm) then
					parametros = message.powerobjectparm
				else
					parametros.realizado = false
				end if
				if parametros.realizado = false then
					// Ha cancelado
					setnull(parametros.realizado)
					this.Enabled = true 
					return
				else
					// vaciasos por si acaso
					setnull(parametros.realizado)
					// MODIFICADO RICARDO 04-03-23
					// Deberiamos de dar numero de salida a cada uno de los documentos marcados!
					CHOOSE CASE g_colegio
						CASE 'COAATTFE'
							unico_n_salida = dw_busqueda_avisos.getitemString(1, 'unico_n_salida')
							if MessageBox(g_titulo, "$$HEX1$$bf00$$ENDHEX$$Desea dar numero de salida a cada uno de los contratos cobrados?", question!, yesno!, 1)=1 then
								// Si quiere dar salida, luego realizamos la accion correspondiente.
								n_salida_ant = '-1'
								FOR fila = 1 TO dw_avisos.RowCount()
									if dw_avisos.GetItemString(fila, 'procesar') = 'S' then
										if unico_n_salida = 'N' then n_salida_primero = ''
										id_fase = dw_avisos.GetItemString(fila, 'id_fase')
										select archivo into :n_salida from fases where id_fase = :id_fase;
										if f_es_vacio(n_salida) then
											if f_es_vacio(n_salida_primero) then
												st_control_eventos c_evento
												c_evento.evento = 'NUMERO_SAL'
												f_control_eventos(c_evento)
												n_salida = f_numera_salida(c_evento.param1)// Modificado Ricardo 2005-05-11 -> SE le pasa el formato directamente
												n_salida_primero = n_salida
											else
												// Si solo quieren un numero para todos, ponemos el primero que hemos asignado
												n_salida = n_salida_primero 
											end if
											// Realizamos el update del numero de salida
											update fases set archivo = :n_salida where id_fase = :id_fase;
										end if
										if n_salida <> n_salida_ant then // INC. 6719 Para que no saque m$$HEX1$$e100$$ENDHEX$$s de una misma etiqueta
											mensajes_salida += "CONTRATO = " + f_dame_n_reg(id_fase) + "         N Salida = " +n_salida + cr
											wf_imprimir_etiqueta(id_fase, n_salida)
										else
//											if b_multiples_pagadores then wf_imprimir_etiqueta(id_fase, n_salida)
										end if
										n_salida_ant = n_salida
									end if
								NEXT
								// Aseguramos los cambios realizados
								commit;
								// Miramos si hay que imprimir algo
								if parametros.tipo_carta_imprimir<>'NINGUNA' and parametros.copias > 0 then
									// Para hacer lo otro tambien hay que ordenar por idde fase
									dw_avisos.setredraw( false )
									dw_avisos.setsort("id_fase")
									dw_avisos.sort()
									id_fase_ant = '-1'
									FOR fila = 1 TO dw_avisos.RowCount()
										if dw_avisos.GetItemString(fila, 'procesar') = 'S' then
											// Quiere que imprimamos alguna carta (hay que tener en cuenta de solo intentar imprimir una por contrato diferente)
											id_fase = dw_avisos.GetItemString(fila, 'id_fase')
											if id_fase<>id_fase_ant then
												// Miramos si tenia un tipo de fase susceptible de imprimir
//												Messagebox('','Tipo de fase:'+dw_avisos.getitemstring(fila, 'fase'))
												//En f_caja_tipo_carta_imprimir determinamos el tipo de carta a imprimir 
												//seg$$HEX1$$fa00$$ENDHEX$$n el tipo de actuaci$$HEX1$$f300$$ENDHEX$$n de la fase (se mira en t_fases)
												susceptible = f_caja_tipo_carta_imprimir(dw_avisos.getitemstring(fila, 'tipo_registro'), dw_avisos.getitemstring(fila, 'fase'), '', false)
												if long(MidA(susceptible, 1, PosA(susceptible,"#") - 1 ))>= 0 then
													// Llamamos a la funcion que lo hace todo
													f_rellenar_hoja_ayto(id_fase, parametros.tipo_carta_imprimir, parametros.copias)
												end if
												// actualizamos el id_fase_ant
												id_fase_ant = id_fase
											end if
										end if
									NEXT
									// Volvemos a sortear el dw de avisos
									dw_avisos.setsort("nombre_pagador ASC, n_aviso ASC")
									dw_avisos.sort()
									dw_avisos.setredraw( true )
								end if
								// Mostramos el mensaje de los numeros de salida que se han generado
								Messagebox(g_titulo, mensajes_salida, exclamation!)
							end if
					END CHOOSE
					// FIN MODIFICADO RICARDO 04-03-23
				end if
			else
				parametros.pagador = nombre_pagador
				parametros.tipo_pagador = pagador
				parametros.formapago_cobro = dw_caja_formapago.getitemstring(dw_caja_formapago.getrow(),'formapago')
				choose case pagador
					case '1'
						parametros.id_pagador  = dw_avisos.GetItemstring(dw_avisos.getrow(),'id_colegiado')
					case '2'// Empresa
						string id_col, id_empresa
						id_col = dw_avisos.GetItemstring(dw_avisos.getrow(),'id_colegiado')
						//id_fase = dw_avisos.GetItemstring(dw_avisos.getrow(),'id_fase')
						select id_empresa into :id_empresa 
						from fases_colegiados where id_col = :id_col and id_fase = :id_fase ;	
						parametros.id_pagador  =id_empresa
					case '3'
						parametros.id_pagador  = dw_avisos.GetItemstring(dw_avisos.getrow(),'id_cliente')
				end choose
				openwithparm(w_caja_pagos_multiples, parametros) // Ricardo 03-12-15
				// Obtenemos los datos de vuelta
				if isvalid(message.powerobjectparm) then
					parametros = message.powerobjectparm
				else
					parametros.realizado = false
				end if
				if parametros.realizado = false then
					// Ha cancelado
					setnull(parametros.realizado)
					this.Enabled = true
					return
				else
					// vaciamos por si acaso
					setnull(parametros.realizado)
				end if
			end if
			CHOOSE CASE g_colegio
				CASE 'COAATTFE'
					// Aqu$$HEX2$$ed002000$$ENDHEX$$prefieren que vaciemos la caja
					parent.trigger event csd_preparar_ventana(is_opcion_ventana)
				CASE 'COAATZ', 'COAATLR', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATA', 'COAATTER'
					// HAY QUE BUSCAR TODAS LAS FACTURAS CREADAS Y MARCARLAS COMO PAGADAS AHORA MISMO
					// PONIENDO A TODAS EL MISMO NUMERO PARA QUE SE PUEDA PASAR A CONTABILIDAD
					id_factura_ultima_generada_despues = f_siguiente_numero_informativo("FACTUEMI", 10)
					FOR fila = 1 TO dw_avisos.RowCount()
						if dw_avisos.GetItemString(fila, 'procesar') = 'S' then
							// Pillamos el siguiente numerito de cobros juntos
							if f_es_vacio(orden_apunte) then orden_apunte = f_siguiente_numero('ORDEN_APUNTE', 10)
							// Para cada minuta, ponemos el numero en las facturas generadas
							id_minuta = dw_avisos.GetItemString(fila, 'id_minuta')
							// Hacemos el update
							update csi_facturas_emitidas set orden_apunte = :orden_apunte where id_fase = :id_minuta and id_factura between :id_factura_ultima_generada and :id_factura_ultima_generada_despues ;
						end if
					NEXT
					// confirmamos todos los updates
					commit;
			END CHOOSE
			if isvalid(g_detalle_fases) then
				g_detalle_fases.postevent('csd_refrescar_avisos')
				g_detalle_fases.postevent('csd_refrescar_src')	
			end if
			// Refrescamos la lista
			dw_avisos.modify("datawindow.table.select= ~"" + isql_aplicado_consulta_avisos + "~"")
			dw_avisos.retrieve()
		end if
		
	CASE '2'
		dw_factura_cabecera_external.trigger event pfc_accepttext(true)
		dw_factura_conceptos.trigger event pfc_accepttext(true)
		// Creando una nueva factura, y si se ha generado, dejamos la ventana para una nueva
		if wf_generar_factura() = 1 then parent.post event csd_preparar_ventana('2')
	
		
	CASE '3', '9' 
		//Cobrar facturas pendientes (3) o proformas pendientes (9). 
		//Utilizar$$HEX1$$e100$$ENDHEX$$n el mismo proceso, salvo que, en el caso de las proforma, se convertiran primero a facturas.
		id_persona = ''
		tipo_factura = ''
		// Caso de las liquidaciones de facturas emitidas
		/* MODIFICADO RICARDO 04-03-01
			Se ha solicitado que se puedan pagar facturas de varios clientes a la vez :O
			Avisamos pero dejamos continuar
		*/
		// Miraremos si hay m$$HEX1$$e100$$ENDHEX$$s de un pagador marcado
		FOR fila = 1 TO dw_facturas_emitidas.RowCount()
			if dw_facturas_emitidas.GetItemString(fila, 'procesar') = 'S' then
				b_marcado_alguno = true
				// Solo en este caso miramos el pagador
				// Al pulsar procesar se marcar$$HEX1$$e100$$ENDHEX$$n todos los correspondientes al pagador
				if f_es_vacio(id_persona) and f_es_vacio(tipo_factura) then
					id_persona = dw_facturas_emitidas.getitemString(fila, 'id_persona')
					tipo_factura = dw_facturas_emitidas.getitemString(fila, 'tipo_factura')
				else
					if id_persona <> dw_facturas_emitidas.getitemString(fila, 'id_persona') or &
						tipo_factura <> dw_facturas_emitidas.getitemString(fila, 'tipo_factura') then
						b_multiples_pagadores = true
						exit
					end if
				end if
			end if
		NEXT
		
		if not b_marcado_alguno then
			MessageBox(g_titulo, "Debe marcar alguna factura para poder cobrarla", stopsign!)
			this.Enabled = true 
			return
		end if
		
		if b_multiples_pagadores then
			if Messagebox(g_titulo, "Hay m$$HEX1$$e100$$ENDHEX$$s de un pagador marcado"+cr+"$$HEX1$$bf00$$ENDHEX$$Desea continuar?", question!, yesno!, 2)=2 then
				this.Enabled = true 
				return	
			end if
		end if
		
		// Si llegamos aqu$$HEX2$$ed002000$$ENDHEX$$podemos seguir el proceso
		// Simplemente debemos sacar la ventana de cobrar facturas
		st_liquidacion st_liq
		st_liq.concepto=''
		st_liq.id_col=id_persona
		st_liq.tipo='3'
		st_liq.tipo_factura=tipo_factura
		if dw_facturas_emitidas.RowCount() > 0 then
			parametros.tipo = 'COBROS_FACTURAS'
			parametros.cantidad_pagar = dw_facturas_emitidas.GetItemNumber(1, 'total_por_pagar_marcadas')
			setnull(parametros.realizado) // Modificado Ricardo 04-05-17	
			
			//SCP-650 Se modifica la llamada a la ventana w_caja_pagos_multiples en vez de w_caja_pagos
			//openwithparm(w_caja_pagos, parametros)
			parametros.dw = dw_facturas_emitidas
			if dw_facturas_emitidas.RowCount() > 0 then 
				fila = dw_facturas_emitidas.Find("procesar='S'",1,dw_facturas_emitidas.RowCount())
				if fila > 0 then parametros.pagador = dw_facturas_emitidas.GetItemString(fila, 'nombre')
			end if
			parametros.formapago_cobro = dw_caja_formapago.GetItemString(1, 'formapago')
			parametros.st_liq = st_liq
			openwithparm(w_caja_pagos_multiples, parametros)
			
		
			
			//Si se abre la caja desde el detalle de un contrato, la cerramos para evitar confusiones
			if isvalid(ist_datos_entrada) and not f_es_vacio(ist_datos_entrada.n_expedi) then
				cb_salir.event clicked()
			else
				// Volvemos a colocar la cosulta aplicada y volvemos a hacerla
				dw_facturas_emitidas.modify("datawindow.table.select= ~"" + isql_aplicado_consulta_facturas + "~"")
				dw_facturas_emitidas.retrieve()
			end if
		end if
		
	CASE '4'
		// CREADO POR RICARDO 04-03-22
		dw_caja_pagos_caja.accepttext()
		// Es para pagos de la caja... Solo impediremos que el importe sea 0
		mensaje = ''
		importe = dw_caja_pagos_caja.GetitemNumber(1, 'importe')
		if isnull(importe) or importe = 0 then mensaje += "Debe indicar un importe valido"
		mensaje += f_valida(dw_caja_pagos_caja, 'fecha', 'NONULO', "Debe indicar una fecha v$$HEX1$$e100$$ENDHEX$$lida")
		if mensaje<>'' then
			Messagebox(g_titulo, mensaje, stopsign!)
			this.Enabled = true 
			return
		end if
		// Ponemos un nuevo id si no tiene valor
		if f_es_vacio(dw_caja_pagos_caja.GetItemString(1, 'id_caja_pagos')) then dw_caja_pagos_caja.setitem(1, 'id_caja_pagos', f_siguiente_numero('caja_pagos', 10))

		// Grabamos el dw
		dw_caja_pagos_caja.update()
		
		// Por peticion de Cayetano se quiere imprimir un informecito de lo que ha ocurrido
		wf_preparar_acuse_pago_caja(dw_caja_pagos_caja.getitemstring(1, 'id_caja_pagos'))
		
		// Volvemos a preparar la ventana para otro cobro
		parent.post event csd_preparar_ventana('4')		
		
	CASE '5'
		// Dar salida a un expediente
		dw_dar_salida_expediente.accepttext()
		id_fase = dw_dar_salida_expediente.getitemString(1, 'id_fase')
		if f_es_vacio(id_fase) then mensaje += 'Debe indicar un contrato para darle salida.' + cr
		n_salida = dw_dar_salida_expediente.getitemString(1, 'archivo_fase')
		if f_es_vacio(n_salida) then mensaje += 'Debe generar el numero de salida primero.'
		if not f_es_vacio(mensaje) then
			messagebox(g_titulo, mensaje, stopsign!)
			this.Enabled = true
			return
		end if
		// INC. 8742
		string estado, n_expedi
		estado = dw_datos_contrato.getitemstring(1, 'fases_estado')
		select n_expedi into :n_expedi from fases where id_fase = :id_fase ;
		if estado = g_fases_estados.preasignado OR n_expedi = f_numero_expediente_basura() then 
			this.Enabled = true 
			return		
		end if
		
		if dw_datos_contrato.Rowcount()=1 then 
			if f_es_vacio(dw_datos_contrato.GetitemString(1, 'fases_archivo')) then
				if f_fases_cambia_estado_fase_segun_pagado(id_fase, 'CAJA')='-1' then
					Messagebox(g_titulo, "Error al actualizar el estado del contrato", stopsign!)
					this.Enabled = true 
					return
				end if
				// Modificado David 06/03/2006 INC. 4619
				
				estado = dw_datos_contrato.getitemstring(1, 'fases_estado')
				if estado <> g_fases_estados.verificado then
					wf_insertar_incidencia_contrato(id_fase, estado)
				end if
				// hacemos el update
				UPDATE fases SET archivo = :n_salida WHERE fases.id_fase = :id_fase ;// Modificado Ricardo 04-07-06
				// Aseguramos los cambios realizados
				commit;
				wf_imprimir_etiqueta(id_fase, n_salida)
			end if
		end if

		// Volvemos a preparar la ventana para otro despacho
		parent.post event csd_preparar_ventana('5')

	CASE '6'
		// CREADO POR RICARDO 04-03-22
		// Crear carta al ayuntamiento
		// Funci$$HEX1$$f300$$ENDHEX$$n externa completamente
		dw_dar_salida_expediente.accepttext()
		id_fase = dw_dar_salida_expediente.getitemString(1, 'id_fase')
		if f_es_vacio(id_fase) then mensaje += 'Debe indicar un contrato para imprimir la carta'
		if mensaje<>'' then
			messageBox(g_titulo, mensaje, stopsign!)
			this.Enabled = true
			return
		end if
		copias = dw_dar_salida_expediente.getitemNumber(1, 'copias')
		if copias > 0 then
			//Andr$$HEX1$$e900$$ENDHEX$$s 28/07/2005: Para Tenerife la funci$$HEX1$$f300$$ENDHEX$$n (f_rellenar_hoja_ayto) se ha modificado 
			// para que s$$HEX1$$f300$$ENDHEX$$lo imprima las cartas de ayto
			//(independientemente del valor que se le pase en tipo_carta)
			//A$$HEX1$$fa00$$ENDHEX$$n as$$HEX3$$ed002000e900$$ENDHEX$$stas se han de imprimir s$$HEX1$$f300$$ENDHEX$$lo en ciertos casos. Comprobamos aqu$$HEX2$$ed002000$$ENDHEX$$que se cumplan
			//las condiciones.
			boolean lb_imprimir=true
			if g_colegio='COAATTFE' then
				select fase into :ls_tipo_actuacion from fases where id_fase=:id_fase;
				if ls_tipo_actuacion <>'11' and ls_tipo_actuacion <>'13' and ls_tipo_actuacion <>'14'&
				   and ls_tipo_actuacion <>'16' and ls_tipo_actuacion <>'17' then
					lb_imprimir=false
				end if
			end if
			// Llamamos a la funcion que lo hace todo
			if lb_imprimir then
				f_rellenar_hoja_ayto(id_fase, dw_dar_salida_expediente.getitemString(1, 'tipo_carta_imprimir'), copias)
			end if
		end if
		
	CASE '8'
			
		// Miraremos si hay m$$HEX1$$e100$$ENDHEX$$s de un pagador marcado
		FOR fila = 1 TO dw_avisos.RowCount()
			// Modificado Ricardo 2005-04-11
			if dw_avisos.GetItemString(fila, 'procesar') = 'S' then
				if f_fase_puede_cobrarse_aviso_estado(dw_avisos.GetItemString(fila, 'estado'), false)<1 then
					// tenemos que desmarcar este aviso
					dw_avisos.SetItem(fila, 'procesar', 'N')
					b_desmarcados = true
				end if
				// Modificado Ricardo 2005-04-11
			
				b_marcado_alguno = true
				// Solo en este caso miramos el pagador
				// Al pulsar procesar se marcar$$HEX1$$e100$$ENDHEX$$n todos los correspondientes al pagador
				if f_es_vacio(nombre_pagador) and f_es_vacio(pagador) then
					nombre_pagador = dw_avisos.getitemString(fila, 'nombre_pagador')
					pagador = dw_avisos.getitemString(fila, 'pagador')
				else
					if nombre_pagador <> dw_avisos.getitemString(fila, 'nombre_pagador') or pagador <> dw_avisos.getitemString(fila, 'pagador') then
						b_multiples_pagadores = true
						exit
					end if
				end if
			end if
		NEXT
		
		if b_desmarcados then 
			Messagebox(g_titulo, 'Algunos avisos han sido desmarcados por estar en un estado en que no se permite cobrar')
		end if
		
		if not b_marcado_alguno then
			MessageBox(g_titulo, "Ning$$HEX1$$fa00$$ENDHEX$$n aviso ha sido marcado", stopsign!)
			this.Enabled = true 
			return
		end if
		
		if b_multiples_pagadores then
			if Messagebox(g_titulo, "Hay m$$HEX1$$e100$$ENDHEX$$s de un pagador marcado"+cr+"$$HEX1$$bf00$$ENDHEX$$Desea continuar de todos modos?", question!, yesno!, 2)= 2 then
				this.Enabled = true 
				return
			end if
		end if

		if LenA(mensaje)>0 then
			mensaje += cr + cr +'Si sigue con el proceso de cobro la diferencia se cargar$$HEX2$$e1002000$$ENDHEX$$contablemente en la(s) cuenta(s) de colegiado(s) que podr$$HEX1$$e100$$ENDHEX$$(n) quedar deudora(s)'
			mensaje += cr + cr +'$$HEX1$$bf00$$ENDHEX$$Desea continuar de todas formas?'
			if messagebox(g_titulo, mensaje, question!, yesno!, 2)=2 then 
				this.Enabled = true 
				return
			end if
		end if

		if dw_avisos.RowCount()>0  then 
			id_factura_ultima_generada = f_siguiente_numero_informativo("FACTUEMI", 10)
			// Si llegamos aqu$$HEX2$$ed002000$$ENDHEX$$podemos seguir el procesado
			parametros.tipo = 'AVISOS'
			parametros.dw = dw_avisos
			if g_usa_cobros_multiples = 'N' then
				openwithparm(w_caja_pagos, parametros) // -->LLamada que se realizaba antiguamente
				// Obtenemos los datos de vuelta
				if isvalid(message.powerobjectparm) then
					parametros = message.powerobjectparm
				else
					parametros.realizado = false
				end if
				if parametros.realizado = false then
					// Ha cancelado
					setnull(parametros.realizado)
					this.Enabled = true
					return
				else
					// vaciasos por si acaso
					setnull(parametros.realizado)
				end if
			else
				parametros.pagador = nombre_pagador
				openwithparm(w_caja_pagos_multiples, parametros) // Ricardo 03-12-15
				// Obtenemos los datos de vuelta
				if isvalid(message.powerobjectparm) then
					parametros = message.powerobjectparm
				else
					parametros.realizado = false
				end if
				if parametros.realizado = false then
					// Ha cancelado
					setnull(parametros.realizado)
					this.Enabled = true 
					return
				else
					// vaciamos por si acaso
					setnull(parametros.realizado)
				end if
			end if
			CHOOSE CASE g_colegio
				CASE 'COAATTFE'
					// Aqu$$HEX2$$ed002000$$ENDHEX$$prefieren que vaciemos la caja
					parent.trigger event csd_preparar_ventana(is_opcion_ventana)
				CASE 'COAATZ', 'COAATLR', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATA', 'COAATTER'
					// HAY QUE BUSCAR TODAS LAS FACTURAS CREADAS Y MARCARLAS COMO PAGADAS AHORA MISMO
					// PONIENDO A TODAS EL MISMO NUMERO PARA QUE SE PUEDA PASAR A CONTABILIDAD
					id_factura_ultima_generada_despues = f_siguiente_numero_informativo("FACTUEMI", 10)
					FOR fila = 1 TO dw_avisos.RowCount()
						if dw_avisos.GetItemString(fila, 'procesar') = 'S' then
							// Pillamos el siguiente numerito de cobros juntos
							if f_es_vacio(orden_apunte) then orden_apunte = f_siguiente_numero('ORDEN_APUNTE', 10)
							// Para cada minuta, ponemos el numero en las facturas generadas
							id_minuta = dw_avisos.GetItemString(fila, 'id_minuta')
							// Hacemos el update
							update csi_facturas_emitidas set orden_apunte = :orden_apunte where id_fase = :id_minuta and id_factura between :id_factura_ultima_generada and :id_factura_ultima_generada_despues ;
						end if
					NEXT
					// confirmamos todos los updates
					commit;
			END CHOOSE
			if isvalid(g_detalle_fases) then
				g_detalle_fases.postevent('csd_refrescar_avisos')
				g_detalle_fases.postevent('csd_refrescar_src')	
			end if
			// Refrescamos la lista
			dw_avisos.modify("datawindow.table.select= ~"" + isql_aplicado_consulta_avisos + "~"")
			dw_avisos.retrieve()
		end if		
END CHOOSE

//SCP-853 Se vuelve a activar el bot$$HEX1$$f300$$ENDHEX$$n.
if isvalid(this) then this.Enabled = true

// Si est$$HEX2$$e1002000$$ENDHEX$$la ventana de fases abierta, hacemos el refrescado
if isvalid(g_dw1) then g_fases_consulta.id_fase = g_dw1.getitemstring(1, 'id_fase')
if isvalid(g_dw1) then g_dw1.dynamic Trigger Event csd_retrieve()
// Provisional (para que muestre el n$$HEX2$$ba002000$$ENDHEX$$salida)
if isvalid(g_dw1) then g_dw1.dynamic Trigger Event csd_retrieve_exp()




//
end event

type dw_caja_contratos_expediente from u_dw within w_caja
boolean visible = false
integer x = 137
integer y = 672
integer width = 2848
integer height = 404
integer taborder = 190
string dataobject = "d_caja_contratos_expediente"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;string id_fase
CHOOSE CASE dwo.name
	CASE 'seleccionado'
		// Colocamos los datos
		id_fase = this.getitemString(row, 'id_fase')
		// Colocamos los datos
		dw_dar_salida_expediente.trigger event csd_recuperar_fase(id_fase)
		this.visible = false
END CHOOSE
			
end event

event key;call super::key;// LLamamos al key de la ventana
parent.trigger event key(key, keyflags)

end event

event csd_tecla;call super::csd_tecla;parent.event key (key, keyflags)
end event

type dw_factura_conceptos from u_dw within w_caja
event csd_recalcular_importe ( )
event csd_rellenar_linea_concepto ( )
boolean visible = false
integer x = 9
integer y = 680
integer width = 3643
integer height = 1060
integer taborder = 160
string dataobject = "d_caja_factura_datos"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_isupdateable = false
end type

event csd_recalcular_importe();long i
double uds, precio, porcen_dto, subtotal,subtotal_dto, subtotal_iva, total
string t_iva

if this.RowCount() =  0 then return
	
	
//if message.stringparm <> 'subtotal' then this.setitem(this.getrow(),'subtotal', precio * unidades)
	
For i= 1 to this.rowcount()
	uds			= this.getitemnumber(i,'unidades')
	precio		= this.getitemnumber(i,'precio')
	this.SetItem(i,'subtotal',uds*precio)
	t_iva			= this.getitemstring(i,'t_iva')
	porcen_dto    = this.getitemnumber(i,'porcent_dto')
	if isnull(porcen_dto) then porcen_dto=0
	subtotal 		= this.getitemnumber(i,'subtotal')		
	subtotal_dto 	= subtotal*porcen_dto/100
	// El IVA se calcula despues de descuento
	subtotal_iva 	= f_redondea(f_aplica_t_iva(subtotal - subtotal_dto,t_iva))
	// Evitamos los nulos
	if IsNull(subtotal) then subtotal = 0
	if isnull(uds) then uds=1
	if IsNull(subtotal_dto) then subtotal_dto = 0
	if IsNull(subtotal_iva) then subtotal_iva = 0
	this.SetItem(i,'subtotal_iva',subtotal_iva)
	this.SetItem(i,'importe_dto',subtotal_dto)
	total = subtotal - subtotal_dto + subtotal_iva
	this.SetItem(i, 'total', f_redondea(total))
Next
end event

event csd_rellenar_linea_concepto();string t_iva,codigo,descripcion
double subtotal,importe_iva

codigo = this.GetitemString(this.GetRow(),'articulo')

SELECT t_iva,importe,descripcion  
 INTO :t_iva,:subtotal,:descripcion
 FROM csi_articulos_servicios  
WHERE csi_articulos_servicios.codigo = :codigo and csi_articulos_servicios.colegio = :g_colegio and empresa=:g_empresa;
	
this.SetItem(this.GetRow(),'descripcion',descripcion)
this.SetItem(this.GetRow(),'descripcion_larga',descripcion)
//if this.getitemnumber(this.getrow(), 'precio') = 0 then this.SetItem(this.GetRow(),'precio',subtotal)
//if this.getitemnumber(this.getrow(), 'subtotal') = 0 then this.SetItem(this.GetRow(),'subtotal',subtotal)
//if this.getitemnumber(this.getrow(), 'unidades') = 0 then this.SetItem(this.GetRow(),'unidades',1)
//if this.getitemnumber(this.getrow(), 'porcent_dto') = 0 then this.SetItem(this.GetRow(),'porcent_dto',0)
//if this.getitemnumber(this.getrow(), 'importe_dto') = 0 then this.SetItem(this.GetRow(),'importe_dto',0)
this.SetItem(this.GetRow(),'precio',subtotal)
this.SetItem(this.GetRow(),'subtotal',subtotal)
this.SetItem(this.GetRow(),'unidades',1)
this.SetItem(this.GetRow(),'porcent_dto',0)
this.SetItem(this.GetRow(),'importe_dto',0)
this.SetItem(this.GetRow(),'t_iva',t_iva)


this.SetItem(this.GetRow(),'subtotal_iva',f_redondea(f_aplica_t_iva(subtotal,t_iva)))



// Modificado Ricardo 04-07-08
// Solo para el colegio de tenerife
CHOOSE CASE g_colegio
	CASE 'COAATTFE'
		// Solo para el primer concepto
		if this.getrow() = 1 then
			// Hacemos que se ponga en la cabecera tambien el valor de la descripcion del concepto
			if f_es_vacio(dw_factura_cabecera_external.getitemstring(1, 'asunto')) then
				dw_factura_cabecera_external.setitem(1, 'asunto', descripcion)
			end if
		end if
END CHOOSE
// FIN Modificado Ricardo 04-07-08


	
this.Post Event csd_recalcular_importe()
end event

event constructor;call super::constructor;this.visible = false
end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name 
	CASE 'precio', 'importe_dto', 'subtotal','subtotal_iva','t_iva','porcent_dto','unidades'   //,'subtotal_iva' ,'unidades', 'precio', 't_iva', 'porcent_dto' 
		message.stringparm= string(dwo.name)
		// LLamamos al evento que recalcular$$HEX2$$e1002000$$ENDHEX$$todo
		this.post event csd_recalcular_importe()

	CASE 'articulo'
		// Llamamos al evento que colocar$$HEX2$$e1002000$$ENDHEX$$los datos
		This.Post Event  csd_rellenar_linea_concepto()
END CHOOSE
end event

event itemfocuschanged;call super::itemfocuschanged;choose case dwo.name
	case 'unidades'
		this.SelectText(1, LenA(string(double(this.GetText()),"##0.00")))
	case 'porcent_dto'
		this.SelectText(1, LenA(string(double(this.GetText()),"##0.00")))
	case 'precio', 'subtotal', 'importe_dto', 'subtotal_iva'
		this.SelectText(1, LenA(string(double(this.GetText()),"###,###,##0.00")))		
end choose
end event

event type integer pfc_updatespending();call super::pfc_updatespending;// Decimos que no hay nada por grabar
return 0
end event

event key;call super::key;// LLamamos al key de la ventana
parent.trigger event key(key, keyflags)

end event

event csd_tecla;call super::csd_tecla;parent.event key (key, keyflags)
end event

type dw_listado_cuadre_caja from u_dw within w_caja
event type long csd_retrivear ( string centro,  string banco,  datetime fecha,  boolean b_rellenar_excel )
boolean visible = false
integer x = 18
integer y = 676
integer width = 3611
integer height = 1060
integer taborder = 30
string dataobject = "d_caja_list_cuadre_composite"
boolean hscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event type long csd_retrivear(string centro, string banco, datetime fecha, boolean b_rellenar_excel);// Evento que se encarga de dejar el dw completamente guay para la FP seleccionada y para la fecha elegida
// Modifica las variables de instancia
string banco_desc, centro_desc, id_fact, id_minuta
boolean b_visualizar = false, b_Avisos = false, b_facturas=false,b_pagos = false
datetime fecha_nula
double totalizado_avisos = 0, totalizado_facturas = 0, totalizado_importe = 0, total_report, base_ct, iva_ct
long n_paginas, i
datawindowchild dwc_cuadre_avisos, dwc_cuadre_facturas,dwc_cuadre_pagos
setnull(fecha_nula)

// Retriveamos
///SCP-1244. Alexis. Se filtra por empresa en caso de que el dataobject se d_caja_salidas_listado_cm
if dw_listado_cuadre_caja.dataobject = 'd_caja_salidas_listado_cm' then 
	dw_listado_cuadre_caja.retrieve(fecha, datetime(relativedate(date(fecha), 1), time("00:00")), centro, g_usuario, g_empresa)
else
	dw_listado_cuadre_caja.retrieve(centro, banco, fecha, datetime(relativedate(date(fecha), 1), time("00:00")))
end if 

// Miramos cada uno de los integrantes del composite
dw_listado_cuadre_caja.getchild('dw_cuadre_avisos', dwc_cuadre_avisos)
dw_listado_cuadre_caja.getchild('dw_cuadre_facturas', dwc_cuadre_facturas)
dw_listado_cuadre_caja.getchild('dw_cuadre_pagos', dwc_cuadre_pagos)

// Aplicamos el filtro para que seg$$HEX1$$fa00$$ENDHEX$$n la delegaci$$HEX1$$f300$$ENDHEX$$n coja una caja u otra
if g_cod_delegacion = 'P' then
	dwc_cuadre_pagos.setfilter("banco = '08'")
else
	dwc_cuadre_pagos.setfilter("banco = '01'")
end if
dwc_cuadre_pagos.filter()

// Miramos si hay lineas
if dwc_cuadre_avisos.rowCount()>0 then 
	b_avisos = true
	b_visualizar = true
end if
if dwc_cuadre_facturas.rowCount()>0 then 
	b_facturas = true
	b_visualizar = true
end if
if dwc_cuadre_pagos.rowCount()>0 then 
	b_pagos = true
	b_visualizar = true
end if

// Averiguamos otras cosas como la descripcion del banco, etc, etc
banco_desc = f_dame_desc_banco(banco,g_empresa)
dw_listado_cuadre_caja.Modify("banco_t.text = '"+banco_desc+"'")
select descripcion into :centro_desc from delegaciones where centro = :centro;
dw_listado_cuadre_caja.Modify("centro_t.text = '"+centro_desc+"'")

if b_visualizar then
//	dw_listado_cuadre_caja.Modify("paginas_t.text = '"+'P$$HEX1$$e100$$ENDHEX$$gina: ' + pagina + ' de ' + paginas.Count()+"'")

	// Colocamos el totalizado total del report
	// Accedemos al totalizado de los avisos
	if b_avisos then
		dw_listado_cuadre_caja.GetChild('dw_cuadre_avisos',dwc_cuadre_avisos)
		
		// INC. 5304 Incluimos en el listado las comisiones de las tarjetas
		for i=1 to dwc_cuadre_avisos.rowcount()
			id_minuta = dwc_cuadre_avisos.getitemstring(i,'id_minuta')
			
			SELECT SUM(csi_lineas_fact_emitidas.subtotal), SUM(csi_lineas_fact_emitidas.subtotal_iva)
			INTO :base_ct, :iva_ct
			FROM csi_facturas_emitidas, csi_lineas_fact_emitidas  
			WHERE ( csi_facturas_emitidas.id_factura = csi_lineas_fact_emitidas.id_factura ) and  
					( ( csi_facturas_emitidas.id_fase = :id_minuta ) AND  
					( csi_lineas_fact_emitidas.articulo = :g_codigos_conceptos.comision_tarjeta )  )   ;
			
			if isnull(base_ct) then base_ct = 0
			if isnull(iva_ct) then iva_ct = 0
			dwc_cuadre_avisos.setitem(i,'base_ct', base_ct)
			dwc_cuadre_avisos.setitem(i,'iva_ct', iva_ct)
		next
		dwc_cuadre_avisos.groupcalc()
		
		totalizado_avisos = dwc_cuadre_avisos.getitemnumber(1,'totalizado_total')
	end if
	
	// Accedemos al totalizado de las facturas
	if b_facturas then
		dw_listado_cuadre_caja.GetChild('dw_cuadre_facturas',dwc_cuadre_facturas)
		
		// INC. 5304 Incluimos en el listado las comisiones de las tarjetas
		for i=1 to dwc_cuadre_facturas.rowcount()
			id_fact = dwc_cuadre_facturas.getitemstring(i,'id_factura')
			
			SELECT SUM(csi_lineas_fact_emitidas.subtotal)
			INTO :base_ct
			FROM csi_lineas_fact_emitidas  
			WHERE ( csi_lineas_fact_emitidas.id_factura = :id_fact ) AND  
					( csi_lineas_fact_emitidas.articulo = :g_codigos_conceptos.comision_tarjeta )    ;
			
			if isnull(base_ct) then base_ct = 0
			dwc_cuadre_facturas.setitem(i,'base_ct', base_ct)
		next
		dwc_cuadre_facturas.groupcalc()
		
		totalizado_facturas = dwc_cuadre_facturas.getitemnumber(1,'totalizado_total')		
	end if

	// Accedemos al totalizado de los cobros
	if b_pagos then
		dw_listado_cuadre_caja.GetChild('dw_cuadre_pagos',dwc_cuadre_pagos)
		totalizado_importe = dwc_cuadre_pagos.getitemnumber(1,'totalizado_importe')
	end if
	
	total_report = totalizado_avisos + totalizado_facturas + totalizado_importe
//	Messagebox('', string(totalizado_avisos)+' + '+string(totalizado_facturas)+' + '+string(totalizado_importe)+' = '+ string(total_report))
	dw_listado_cuadre_caja.Modify("suma_total.text = '"+string(total_report, "###,###,##0.00")+"'")
	
	// Dejamos el zoom a 92 que queda bien en pantalla
	dw_listado_cuadre_caja.object.datawindow.print.preview.zoom = 92
	
	dw_listado_cuadre_caja.visible = true
	n_paginas = dw_listado_cuadre_caja.getitemnumber(1, 'n_paginas')
else
	dw_listado_cuadre_caja.visible = false
	n_paginas = 0
end if

if date(idt_f_desde) <> date(idt_f_hasta) then
	if date(fecha) > date(idt_f_desde) then 
		dw_listado_cuadre_busqueda.modify ( "b_dia_anterior.visible = '1'")
	else
		dw_listado_cuadre_busqueda.modify ( "b_dia_anterior.visible = '0'")
	end if
	if date(fecha) < date(idt_f_hasta) then 
		dw_listado_cuadre_busqueda.modify ( "b_dia_siguiente.visible = '1'")
	else
		dw_listado_cuadre_busqueda.modify ( "b_dia_siguiente.visible = '0'")
	end if
end if
if not isnull (banco) and not isnull(fecha) then
	dw_listado_cuadre_busqueda.setitem(1, 'banco_visualizado',banco)
	dw_listado_cuadre_busqueda.setitem(1, 'fecha_visualizada',fecha)
else
	dw_listado_cuadre_busqueda.setitem(1, 'banco_visualizado','')
	dw_listado_cuadre_busqueda.setitem(1, 'fecha_visualizada',fecha_nula)
end if
if not isnull(centro) or centro<>'%' then
	dw_listado_cuadre_busqueda.setitem(1, 'centro_visualizado',centro)
else
	dw_listado_cuadre_busqueda.setitem(1, 'centro_visualizado','')
end if


if b_rellenar_excel then wf_rellenar_pagina_exportar(centro_desc, banco_desc, fecha)

return n_paginas

end event

event key;call super::key;// LLamamos al key de la ventana
parent.trigger event key(key, keyflags)


end event

event csd_tecla;call super::csd_tecla;parent.event key (key, keyflags)
end event

type dw_caja_pagos_caja_lista from u_dw within w_caja
boolean visible = false
integer x = 5
integer y = 628
integer width = 3630
integer height = 1080
integer taborder = 20
string dataobject = "d_caja_pagos_caja_lista"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;
// Aplicamos un filtro para que solo puedan ver los pagos de este centro
dw_caja_pagos_caja_lista.setfilter("centro = '"+f_devuelve_centro(g_cod_delegacion)+"'") // Modificado Ricardo 04-06-14
dw_caja_pagos_caja_lista.filter()


end event

event key;call super::key;// LLamamos al key de la ventana
parent.trigger event key(key, keyflags)

end event

event doubleclicked;call super::doubleclicked;string obser

CHOOSE CASE dwo.name
	CASE 'observaciones'
		g_busqueda.titulo="Observaciones"
		obser    =this.GetItemString(row, 'observaciones')
		openwithparm(w_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
			if not isnull(obser) then	this.SetItem(row,'observaciones',obser)
		end if
END CHOOSE

end event

event itemchanged;call super::itemchanged;string tipo_persona, id_col, nif, id_persona
st_ficha_cliente datos_cliente
long num_clientes

CHOOSE CASE dwo.name
	CASE 'tipo_persona'
		// Al cambiar el tipo de persona lo borramos todo lo de los datos del entregado
		this.setitem(row, 'id_persona', '')
		this.setitem(row, 'n_coleg_dni', '')
		this.setitem(row, 'nombre', '')
	CASE 'n_coleg_dni'
		tipo_persona = this.getitemstring(row, 'tipo_persona')
		CHOOSE CASE tipo_persona
			CASE 'P'
				// ES un cliente
				if f_es_vacio(data) then
					this.setitem(row, 'id_persona', '')
					this.SetItem(row,'nombre','')
					return
				end if
				// SCP-99
//				// El NIF / CIF tiene que ser de 9
//				if LenA(data) <> 9 then
//					messagebox(g_titulo, 'El NIF/CIF tiene que ser de 9 posiciones.')
//					return -1
//				end if
				nif = data
				if RightA(nif, 1) = '*' then
					nif = f_calculo_nif(nif)
					if nif = '-1' then return -1
				elseif RightA(nif,1) >= 'A' and RightA(nif,1) <= 'Z' then
					if not f_comprobar_nif(nif) then
						messagebox(g_titulo, 'La letra del NIF no es correcto')
						return -1
					end if
				end if
		
				select count(*) into :num_clientes from clientes where nif=:nif;
				if num_clientes > 0 then  
					if num_clientes = 1 then
						// obtenemos el id_cliente y calculamos todos los datos
						id_persona = f_cliente_id_cliente(nif)
					else
						g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
						g_busqueda.dw="d_lista_busqueda_clientes_cta_contable"               
						id_persona=f_busqueda_clientes(nif)
					end if
				else
					// No existe el cliente
					if MessageBox(g_titulo,'Este cliente NO existe, $$HEX1$$bf00$$ENDHEX$$Desea darlo de alta?',Question!,YesNo!,1)=1 then
						//Aqui va el c$$HEX1$$f300$$ENDHEX$$digo q abre la ventana 
						datos_cliente.nif=nif
						datos_cliente.tipo_tercero = g_terceros_codigos.codigo_cliente
						OpenWithParm(w_fases_ficha_cliente,datos_cliente)
						id_persona = Message.StringParm
					end if
				end if
				if nif <> '-1' then 
					this.setitem(row, 'id_persona', id_persona)
					this.SetItem(row,'nombre',LeftA(f_dame_cliente(id_persona), 40))
					this.post setitem(row, 'n_coleg_dni', nif)
				end if
			CASE 'C'
				// ES un colegiado
				id_col=f_colegiado_id_col(data)
				if f_es_vacio(id_col) then
					this.setitem(row, 'id_persona', '')
					this.SetItem(row,'nombre','')
				else
					this.setitem(row, 'id_persona', id_col)
					this.SetItem(row,'nombre',LeftA(f_colegiado_apellido(id_col), 40))
				end if
		END CHOOSE
END CHOOSE

end event

event buttonclicked;call super::buttonclicked;string tipo_persona, id_persona, nif

CHOOSE CASE dwo.name
	CASE 'b_buscar'
		// Tenemos que buscar y poner los datos
		tipo_persona = this.getitemstring(row, 'tipo_persona')
		CHOOSE CASE tipo_persona
			CASE 'P'
				// ES un cliente
				g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
				g_busqueda.dw="d_lista_busqueda_clientes_cta_contable"		
				id_persona=f_busqueda_clientes('')
				if id_persona="-1" then
					messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de cliente v$$HEX1$$e100$$ENDHEX$$lido.')
					return -1
				else
					this.SetItem(row,'id_persona',id_persona)
					select nif into :nif from clientes where id_cliente = :id_persona;
					this.SetItem(row,'n_coleg_dni',nif)
					this.SetItem(row,'nombre',LeftA(f_dame_cliente(id_persona), 40))
				end if
			CASE 'C'
				// Es un colegiado
				g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
				g_busqueda.dw="d_lista_busqueda_colegiados"

				id_persona=f_busqueda_colegiados()
				//Comprobamos que el colegiado existe
				if id_persona="-1" then
					messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
					this.setfocus()
					return -1
				else
					this.SetItem(row,'id_persona',id_persona)
					this.SetItem(row,'nombre',LeftA(f_colegiado_apellido(id_persona),40))
					this.SetItem(row,'n_coleg_dni',f_colegiado_n_col(id_persona))
				end if
		END CHOOSE
	CASE 'b_imprimir'
		// Por peticion de Cayetano se quiere imprimir un informecito de lo que ha ocurrido, de lo que est$$HEX2$$e1002000$$ENDHEX$$GRABADO
		wf_preparar_acuse_pago_caja(this.getitemstring(row, 'id_caja_pagos'))
END  CHOOSE

end event

event csd_tecla;call super::csd_tecla;parent.event key (key, keyflags)
end event

type dw_facturas_emitidas from u_dw within w_caja
boolean visible = false
integer x = 9
integer y = 588
integer width = 3707
integer height = 1152
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_caja_factura_emitida_facturas"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.visible = false

// POnemos el gestor de lineas para que salga el azul al pinchar
this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)

// Cogemos la sql del dw
isql_original_facturas = dw_facturas_emitidas.describe("datawindow.table.select")


this.of_SetSort(TRUE)
inv_sort.of_SetColumnHeader (true)

end event

event retrieveend;call super::retrieveend;string id_factura
double importe_pagado, importe_pagar, importe_total
long fila

// REstauramos la sql
dw_facturas_emitidas.modify("datawindow.table.select= ~"" + isql_original_facturas + "~"")

FOR fila = 1 to dw_facturas_emitidas.Rowcount()
	// Ahora es cuando miramos lo que se ha pagado por cada factura
	id_factura = dw_facturas_emitidas.GetItemString(fila, 'id_factura')
	importe_total = dw_facturas_emitidas.GetItemNumber(fila, 'total')
	
	// Obtenemos lo que se ha pagado ya
	SELECT sum(csi_cobros.importe)   
	into :importe_pagado
	 FROM csi_cobros  
	WHERE csi_cobros.id_factura = :id_factura and pagado = 'S'   ;
	
	// Y ahora es cuando colocamos los valores
	if isnull(importe_pagado) then importe_pagado = 0
	
	// Hacemos la resta y colocamos le resultado
	importe_pagar = importe_total - importe_pagado
	dw_facturas_emitidas.SetItem(fila, 'total_por_pagar', importe_pagar)
NEXT
this.setredraw(true)
end event

event itemchanged;call super::itemchanged;string pagador
long fila

// Modificado David 10/02/2006 - Solicitan que no se haga esto (INC. 4144)
if g_colegio = 'COAATTFE' then return

CHOOSE CASE dwo.name
	CASE 'procesar'
		if string(data) = 'S' then
			setpointer(hourglass!)
			if dw_facturas_emitidas.getitemString(row, 'desmarcado_manual') = 'S' then
				// Est$$HEX2$$e1002000$$ENDHEX$$volviendo a marcar una que hab$$HEX1$$ed00$$ENDHEX$$a desmarcado
				dw_facturas_emitidas.Setitem(row, 'desmarcado_manual', 'N')
			else
				// Al pulsar procesar se marcar$$HEX1$$e100$$ENDHEX$$n todos los correspondientes al pagador
				pagador = dw_facturas_emitidas.getitemString(row, 'nombre')
	
				FOR fila = 1 TO dw_facturas_emitidas.RowCount()
					if fila<>row then
						if pagador = dw_facturas_emitidas.getitemString(fila, 'nombre') and dw_facturas_emitidas.getitemString(fila, 'desmarcado_manual') = 'N' then
							// Marcamos la linea para procesarla, siempre y cuando no hubiese sido desmarcada de forma manual
							dw_facturas_emitidas.Setitem(fila, 'procesar', 'S')
						end if
					end if
				NEXT
			end if
			setpointer(arrow!)
		else
			// EStamos en el caso en que est$$HEX2$$e1002000$$ENDHEX$$desmarcando, por lo que indicamos que la desmarca de forma manual			
			dw_facturas_emitidas.Setitem(row, 'desmarcado_manual', 'S')
		end if
		
END CHOOSE
end event

event type integer pfc_updatespending();call super::pfc_updatespending;return 0
end event

event retrievestart;call super::retrievestart;this.setredraw(false)
end event

event key;call super::key;// LLamamos al key de la ventana
parent.trigger event key(key, keyflags)

end event

event csd_tecla;call super::csd_tecla;parent.event key (key, keyflags)
end event

type cb_buscar_facturas_emitidas from commandbutton within w_caja
boolean visible = false
integer x = 3182
integer y = 480
integer width = 439
integer height = 96
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "&Buscar"
end type

event clicked;//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo, n_expediente, n_registro

// Aceptamos el texto que ponga
dw_facturas_emitidas_busqueda.trigger event pfc_accepttext(true)

// Pillamos la SQL
sql_nuevo = dw_facturas_emitidas.describe("datawindow.table.select")

f_sql('csi_facturas_emitidas.n_fact','LIKE','n_factura',dw_facturas_emitidas_busqueda,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_facturas_emitidas.tipo_factura','LIKE','tipo_factura',dw_facturas_emitidas_busqueda,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_facturas_emitidas.id_persona','=','id_pagador',dw_facturas_emitidas_busqueda,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_facturas_emitidas.centro','=','centro',dw_facturas_emitidas_busqueda,sql_nuevo,g_tipo_base_datos,'')
//Se a$$HEX1$$f100$$ENDHEX$$aden las proforma, asi como las fechas y la serie
//f_sql('csi_facturas_emitidas.proforma','=','proforma',dw_facturas_emitidas_busqueda,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_facturas_emitidas.fecha','>=','f_desde',dw_facturas_emitidas_busqueda,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_facturas_emitidas.fecha','<','f_hasta',dw_facturas_emitidas_busqueda,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_facturas_emitidas.n_fact','LIKE','serie',dw_facturas_emitidas_busqueda,sql_nuevo,g_tipo_base_datos,'')
//A$$HEX1$$f100$$ENDHEX$$adimos las tablas necesarias con el f_sql_join y luego a$$HEX1$$f100$$ENDHEX$$adimos las condiciones en el WHERE
f_sql('csi_facturas_emitidas.proforma','LIKE','proformas',dw_facturas_emitidas_busqueda,sql_nuevo,g_tipo_base_datos,'')
//sql_nuevo = f_sql_join(sql_nuevo,{'expedientes.id_expedi = fases.id_expedi', 'fases.id_fase = csi_facturas_emitidas.id_minuta'})
n_expediente = dw_facturas_emitidas_busqueda.GetItemString(1,'n_expediente')
n_registro = dw_facturas_emitidas_busqueda.GetItemString(1,'n_registro')

if NOT f_es_vacio(n_expediente) then
	//Busco por n_expediente
	sql_nuevo += "AND (csi_facturas_emitidas.id_minuta IN (SELECT id_fase FROM fases WHERE id_expedi IN (SELECT id_expedi FROM expedientes WHERE n_expedi='"+n_expediente+"')) OR "+&
	"csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM fases_minutas WHERE id_fase IN (SELECT id_fase FROM fases WHERE id_expedi IN (SELECT id_expedi FROM expedientes WHERE n_expedi='"+n_expediente+"' ))))"
	//f_sql('expedientes.n_expedi','LIKE','n_expediente',dw_facturas_emitidas_busqueda,sql_nuevo,g_tipo_base_datos,'')
end if

if NOT f_es_vacio(n_registro) then
	//Busco por n_registro
	sql_nuevo += "AND (csi_facturas_emitidas.id_minuta IN (SELECT id_fase FROM fases WHERE n_registro='"+n_registro+"') OR "+&
	"csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM fases_minutas WHERE id_fase IN (SELECT id_fase FROM fases WHERE n_registro='"+n_registro+"')))"
	//f_sql('fases.n_registro','LIKE','n_registro',dw_facturas_emitidas_busqueda,sql_nuevo,g_tipo_base_datos,'')
end if


f_sql('csi_facturas_emitidas.empresa','LIKE','empresa',dw_facturas_emitidas_busqueda,sql_nuevo,g_tipo_base_datos,'')

// Me guardo la consulta para poder volver a hacerla
isql_aplicado_consulta_facturas = sql_nuevo
// Modificamos la SQL
dw_facturas_emitidas.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
dw_facturas_emitidas.retrieve()





end event

event constructor;this.visible = false
end event

type dw_facturas_emitidas_busqueda from u_dw within w_caja
boolean visible = false
integer x = 9
integer y = 228
integer width = 3707
integer height = 368
integer taborder = 110
string dataobject = "d_caja_factura_emitida_cabecera"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event buttonclicked;// Buscamos la persona que se pretenda colocar como pagador

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
				this.SetItem(1,'id_pagador',id_persona)
				this.SetItem(1,'nombre_pagador',  f_colegiado_apellido(id_persona))	
					
			end if

	CASE 'b_buscar_cliente'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Clientes de Expedientes"
		g_busqueda.dw="d_lista_busqueda_clientes_cta_contable"
		id_persona=f_busqueda_clientes_exp()
	
		if id_persona="-1" then
			messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de cliente v$$HEX1$$e100$$ENDHEX$$lido.')
			this.setfocus()
			return -1
		else
			this.SetItem(1,'id_pagador',id_persona)
			this.SetItem(1,'nombre_pagador',f_dame_cliente(id_persona))				
		end if
		
	CASE 'b_delete'
		string ls_null 
		setnull(ls_null)
		this.setitem(row, 'empresa', ls_null )



END CHOOSE

end event

event itemchanged;call super::itemchanged;string id_col
datawindowchild dwc_centro
this.getchild ('centro', dwc_centro)

CHOOSE CASE dwo.name
	CASE 'tipo_factura'
		// Cuando cambia el tipo de factura se vaciar$$HEX2$$e1002000$$ENDHEX$$el campo del nombre y del id
		this.SetItem(row, 'id_pagador', '')
		this.SetItem(row, 'nombre_pagador', '')
		CHOOSE CASE string(data)
			CASE '03'
				this.object.b_buscar_colegiado.visible = true
				this.object.n_colegiado.visible = true
				this.object.b_buscar_cliente.visible = false
			CASE '02'
				this.object.b_buscar_colegiado.visible = false
				this.object.n_colegiado.visible = false
				this.object.b_buscar_cliente.visible = true
			CASE '%'
				this.object.b_buscar_colegiado.visible = false
				this.object.n_colegiado.visible = false
				this.object.b_buscar_cliente.visible = false
		END CHOOSE
		
	// MODIFICADO RICARDO 04-06-07
	CASE 'n_colegiado'
		// A partir del numero de colegiado averiguamos el id del colegiado
			id_col=f_colegiado_id_col(data)
			this.setitem(row, 'id_pagador', id_col)
			this.SetItem(1,'nombre_pagador',f_colegiado_apellido(id_col))				
	// FIN MODIFICADO RICARDO 04-06-07
	
	case 'empresa'
		//scp-1058
			
			dwc_centro.settransobject (SQLCA)
			dwc_centro.retrieve(data)
			///*** SCP-1635. Se hace que el centro coincida seg$$HEX1$$fa00$$ENDHEX$$n la configuraci$$HEX1$$f300$$ENDHEX$$n tal y como se carga en el evento csd_preparar_ventana. Alexis. 19/09/2011 ***///			
			//this.setitem(row,'centro', '')
			dw_facturas_emitidas_busqueda.setitem(row, 'centro', f_devuelve_centro(g_cod_delegacion))
			
			idwc_serie.retrieve(data)


END CHOOSE
end event

event constructor;call super::constructor;this.visible = false

//Modificado Jesus 11/02/2010 cte-129 
//Quieren el campo n_colegiado con 10 caracteres
if (g_colegio='COAATTFE') then
this.Modify("n_colegiado.Edit.Limit='10'")
end if

datawindowchild dwc_centro, dwc_serie
// Capturamos el desplegable
this.getchild ('centro', dwc_centro)
dwc_centro.settransobject (SQLCA)
dwc_centro.retrieve(g_empresa)


this.getchild ('serie', idwc_serie)
idwc_serie.settransobject (SQLCA)
idwc_serie.retrieve(g_empresa)
end event

event key;call super::key;// LLamamos al key de la ventana
parent.trigger event key(key, keyflags)

end event

event csd_tecla;call super::csd_tecla;parent.event key (key, keyflags)
end event

type dw_factura_cabecera_external from u_dw within w_caja
event csd_comprobar_estado_colegiado ( string id_col )
boolean visible = false
integer x = 347
integer y = 248
integer width = 2697
integer height = 440
integer taborder = 100
string dataobject = "d_caja_factura_cabecera"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_comprobar_estado_colegiado(string id_col);// Miramos el estado del colegiado
string respuesta = ''
select alta_baja into :respuesta from colegiados where id_colegiado = :id_col;
if respuesta = 'N' then 
	MessageBox(g_titulo, 'El colegiado est$$HEX2$$e1002000$$ENDHEX$$de baja.', exclamation!)
elseif f_es_vacio(respuesta) then
	MessageBox(g_titulo, 'El colegiado no existe.', exclamation!)
end if

end event

event buttonclicked;call super::buttonclicked;// Buscamos la persona que se pretenda colocar como pagador

string id_persona
CHOOSE CASE dwo.name
	CASE 'b_buscar_colegiado'
			g_busqueda.titulo = "B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
			g_busqueda.dw = "d_lista_busqueda_colegiados"
			id_persona = f_busqueda_colegiados()
			//Comprobamos que el colegiado existe
			if id_persona = "-1" then
				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
				this.setfocus()
				return -1
			else
				this.SetItem(1,'id_pagador',id_persona)
				this.SetItem(1,'nombre_pagador',f_colegiado_apellido(id_persona))			
				this.setitem(1,'n_colegiado' , f_colegiado_n_col(id_persona))
				this.trigger event csd_comprobar_estado_colegiado(id_persona)
			end if

	CASE 'b_buscar_cliente'
		g_busqueda.titulo = "B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Clientes de Expedientes"
		g_busqueda.dw = "d_lista_busqueda_clientes_cta_contable"
		id_persona = f_busqueda_clientes_exp()
	
		if id_persona = "-1" then
			messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de cliente v$$HEX1$$e100$$ENDHEX$$lido.')
			this.setfocus()
			return -1
		else
			this.SetItem(1,'id_pagador',id_persona)
			this.SetItem(1,'nombre_pagador',f_dame_cliente(id_persona))	
			this.SetItem(1,'n_colegiado',f_dame_nif(id_persona))				
		end if		
END CHOOSE

end event

event constructor;call super::constructor;this.visible = false


end event

event itemchanged;call super::itemchanged;string id_col
long n_reg
datetime ldtm_null
setnull(ldtm_null)
st_ficha_cliente datos_cliente

CHOOSE CASE dwo.name
	CASE 'tipo_factura'
		// Cuando cambia el tipo de factura se vaciar$$HEX2$$e1002000$$ENDHEX$$el campo del nombre y del id
		this.SetItem(row, 'id_pagador', '')
		this.SetItem(row, 'nombre_pagador', '')
		CHOOSE CASE string(data)
			CASE '1'
				this.object.b_buscar_colegiado.visible = true
				this.object.n_colegiado.visible = true
				this.object.b_buscar_cliente.visible = false
				this.SetItem(1,'fecha',ldtm_null)					
			CASE '3'
				this.object.b_buscar_colegiado.visible = false
				this.object.n_colegiado.visible = true
				this.object.b_buscar_cliente.visible = true
				this.SetItem(1,'fecha',today())				
		END CHOOSE
	CASE 'n_colegiado'
		if dw_factura_cabecera_external.GetItemString(row,'tipo_factura') = '1' then
		// A partir del numero de colegiado averiguamos el id del colegiado
			id_col=  f_colegiado_id_col(data)
			this.setitem(row, 'id_pagador', id_col)
			this.SetItem(1,'nombre_pagador',f_colegiado_apellido(id_col))				
			this.trigger event csd_comprobar_estado_colegiado(id_col)
		elseif dw_factura_cabecera_external.GetItemString(row,'tipo_factura') = '3' then
			//COAM-178 
			string nif_formateado,nif,i_nif,mensaje,id_cli
			long num_clientes,i,suma_porcentajes_cli
			u_csd_nif uo_nif
		
			// Guardamos el nif en una variable de instancia porque la usa el evento de b$$HEX1$$fa00$$ENDHEX$$squeda de clientes
			nif = data
			
			if RightA(nif, 1) = '*' then
				i_nif = left(nif,len(nif) - 1)
				nif_formateado = uo_nif.of_comprobar_documento(i_nif,'')			
				if nif <> nif_formateado then 
					this.post setitem(this.getrow(),'n_colegiado', nif_formateado)
					nif = nif_formateado
				end if			
			else
				nif_formateado = uo_nif.of_comprobar_documento(nif,'')
			end if

		select count(*) into :num_clientes from clientes where nif = :nif ;
		if num_clientes > 0 then  
			if num_clientes = 1 then
				this.setitem(row, 'id_pagador', f_cliente_id_cliente(nif))
				this.SetItem(this.getrow(),'nombre_pagador',f_dame_cliente(f_cliente_id_cliente(nif)))	
			end if

		else
			if MessageBox(g_titulo,g_idioma.of_getmsg('fases.msg_cli_no_exist','Este cliente NO existe, $$HEX1$$bf00$$ENDHEX$$Desea darlo de alta?'),Question!,YesNo!,1)=1 then
				//Aqui va el c$$HEX1$$f300$$ENDHEX$$digo q abre la ventana 
				datos_cliente.nif = nif
				datos_cliente.tipo_tercero = g_terceros_codigos.codigo_cliente
				OpenWithParm(w_fases_ficha_cliente,datos_cliente)
				id_cli = Message.StringParm
				this.setitem(row, 'id_pagador', id_cli)
				this.SetItem(this.getrow(),'nombre_pagador',f_dame_cliente(id_cli))	
			end if
		end if
	end if
			
	CASE 'serie'
		// Hay que comprobar que la serie est$$HEX2$$e9002000$$ENDHEX$$dentro de las series existentes
		if not f_es_vacio(data) then
			select count(*) into :n_reg from csi_series where serie = :data;
			if n_reg < 1 then 
				post messagebox(g_titulo, "Debe indicar una serie de las existentes", stopsign!)
				return 2
			end if
		end if	
END CHOOSE
end event

event key;call super::key;// LLamamos al key de la ventana
parent.trigger event key(key, keyflags)

end event

event csd_tecla;call super::csd_tecla;parent.event key (key, keyflags)
end event

type dw_dar_salida_expediente from u_dw within w_caja
event csd_recuperar_fase ( string id_fase )
boolean visible = false
integer x = 480
integer y = 344
integer width = 2734
integer height = 320
integer taborder = 180
string dataobject = "d_caja_salida_expedientes"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_recuperar_fase(string id_fase);// Colocamos los datos
if dw_datos_contrato.retrieve(id_fase) = 1 then
	dw_dar_salida_expediente.setitem(1,'id_fase',id_fase)
	dw_dar_salida_expediente.setitem(1, 'n_expedi',dw_datos_contrato.GetitemString(1, 'n_expedi'))
	dw_dar_salida_expediente.setitem(1, 'n_reg',dw_datos_contrato.GetitemString(1, 'fases_n_registro'))
	// Miramos si ya tiene numero de salida, por lo que lo traemos directamente
	dw_dar_salida_expediente.setitem(1, 'archivo_fase',dw_datos_contrato.GetitemString(1, 'fases_archivo'))
	
	//dw_dar_salida_expediente.setitem(1, 'n_expedi',f_dame_exp(id_fase))
	//dw_dar_salida_expediente.setitem(1, 'n_reg',f_dame_n_reg(id_fase))
	dw_dar_salida_expediente.setcolumn("tab")
end if




end event

event buttonclicked;call super::buttonclicked;string exp, id_fase, n_registro, estado, n_expedi
			
CHOOSE CASE dwo.name
	CASE 'b_buscar_contrato'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida"
		g_busqueda.dw="d_lista_busqueda_fases"
		id_fase=f_busqueda_fases()  
		
		// Colocamos los datos
		dw_dar_salida_expediente.trigger event csd_recuperar_fase(id_fase)

	CASE 'b_borrar'
		this.setredraw(false)
		this.reset()
		this.insertrow(0)
		dw_datos_contrato.insertrow(0)
		dw_dar_salida_expediente.setitem(1,'tipo', is_opcion_ventana)
		this.setredraw(true)
		
	CASE 'b_salida'
		id_fase = this.getitemString(row, 'id_fase')
		if f_es_vacio(id_fase) then
			MessageBox(g_titulo, "Debe indicar primero el contrato concreto", stopsign!)
			return
		else
			// INC. 8742
			estado = dw_datos_contrato.getitemstring(1, 'fases_estado')
			select n_expedi into :n_expedi from fases where id_fase = :id_fase ;
			if estado = g_fases_estados.preasignado OR n_expedi = f_numero_expediente_basura() then 
				MessageBox(g_titulo, "El contrato est$$HEX2$$e1002000$$ENDHEX$$en un estado en que no se permite despachar", stopsign!)
				return
			end if
			st_control_eventos c_evento
			if f_es_vacio(this.getitemstring(1,'archivo_fase')) then
				c_evento.evento = 'NUMERO_SAL'
				f_control_eventos(c_evento)
				this.setitem(1,'archivo_fase',f_numera_salida(c_evento.param1))
			end if
		end if
		
	CASE 'b_ver_contrato'
		id_fase = this.getitemString(row, 'id_fase')
		if f_es_vacio(id_fase) then
			MessageBox(g_titulo, "Debe indicar primero el contrato concreto", stopsign!)
			return
		else
			// Abrimos la ventana de deltalle
			//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
			g_fases_consulta.id_fase = this.getitemstring(row,'id_fase')
			message.stringparm = "w_fases_detalle"
			SetPointer(Hourglass!)
			w_aplic_frame.postevent("csd_fasesdetalle")
		end if
		
	CASE 'b_imprimir'
		// Simplemente llamamos al bot$$HEX1$$f300$$ENDHEX$$n de cobrar
		cb_cobrar.trigger event clicked()

END CHOOSE

end event

event itemchanged;call super::itemchanged;string id_fase, id_exp
CHOOSE CASE dwo.name
	CASE 'n_expedi'
		if not f_es_Vacio(data) then
			id_exp = f_dame_id_exp_de_n_exp(data)
			if dw_caja_contratos_expediente.retrieve(id_exp) = 1 then
				// Colocamos los datos
				id_fase = dw_caja_contratos_expediente.getitemString(1, 'id_fase')
				// Colocamos los datos
				dw_dar_salida_expediente.trigger event csd_recuperar_fase(id_fase)
				dw_caja_contratos_expediente.visible = false
			else
				dw_caja_contratos_expediente.visible = true
			end if
			
		end if
		
		
	CASE 'n_reg'
		if not f_es_vacio(data) then
			id_fase = f_dame_id_fase_de_n_reg(data)
			// Colocamos los datos
			dw_dar_salida_expediente.trigger event csd_recuperar_fase(id_fase)
		end if

	CASE 'copias'
		// No dejamos borrar
		if isnull(data) then return 2
		// No dejamos poner negativos
		if long(data)<0 then return 2
			
		
END CHOOSE
end event

event key;call super::key;// LLamamos al key de la ventana
parent.trigger event key(key, keyflags)

end event

event csd_tecla;call super::csd_tecla;parent.event key (key, keyflags)
end event

type dw_avisos from u_dw within w_caja
event csd_abrir_ventana_minuta ( long row )
boolean visible = false
integer x = 9
integer y = 424
integer width = 3666
integer height = 1316
integer taborder = 70
string dataobject = "d_caja_avisos_pendientes"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_abrir_ventana_minuta(long row);long linea
st_minutas_consulta minutas_consulta

// Decimos la accion a realizar
minutas_consulta.accion = 'CONSULTA'
minutas_consulta.id_minuta = this.getitemstring(row, 'id_minuta')
minutas_consulta.id_fase = this.getitemstring(row, 'id_fase')
minutas_consulta.modulo = 'CAJA'

// Abrimos la ventana pasandole la estructura que contiene el identificador
openwithparm(w_minutas_detalle, minutas_consulta)
// Recogemos el par$$HEX1$$e100$$ENDHEX$$metro de retorno de la ventana
minutas_consulta = message.powerobjectparm
if minutas_consulta.actualizado = 'S' then
	// Refrescamos la lista
	dw_avisos.modify("datawindow.table.select= ~"" + isql_aplicado_consulta_avisos + "~"")
	dw_avisos.retrieve()
	linea = dw_avisos.find("id_minuta = '"+minutas_consulta.id_minuta+"'",1,dw_avisos.rowCount())
	dw_avisos.scrolltorow(linea)
	dw_avisos.setrow(linea)
end if



end event

event itemchanged;call super::itemchanged;string pagador
long fila


CHOOSE CASE dwo.name
	CASE 'procesar'
		if string(data) = 'S' then
			setpointer(hourglass!)
			if dw_avisos.getitemString(row, 'desmarcado_manual') = 'S' then
				// Est$$HEX2$$e1002000$$ENDHEX$$volviendo a marcar una que hab$$HEX1$$ed00$$ENDHEX$$a desmarcado
				dw_avisos.Setitem(row, 'desmarcado_manual', 'N')
			else
				// Al pulsar procesar se marcar$$HEX1$$e100$$ENDHEX$$n todos los correspondientes al pagador
				pagador = dw_avisos.getitemString(row, 'nombre_pagador')
	
				FOR fila = 1 TO dw_avisos.RowCount()
					if fila<>row then
						if pagador = dw_avisos.getitemString(fila, 'nombre_pagador') and dw_avisos.getitemString(fila, 'desmarcado_manual') = 'N' then
							// Marcamos la linea para procesarla, siempre y cuando no hubiese sido desmarcada de forma manual
							dw_avisos.Setitem(fila, 'procesar', 'S')
						end if
					end if
				NEXT
			end if
			setpointer(arrow!)
		else
			// EStamos en el caso en que est$$HEX2$$e1002000$$ENDHEX$$desmarcando, por lo que indicamos que la desmarca de forma manual			
			dw_avisos.Setitem(row, 'desmarcado_manual', 'S')
		end if
		
END CHOOSE
end event

event constructor;call super::constructor;this.visible = false

// POnemos el gestor de lineas para que salga el azul al pinchar
this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)


// Cogemos la sql del dw
isql_original_avisos = dw_avisos.describe("datawindow.table.select")



end event

event retrieveend;call super::retrieveend;// REstauramos la sql
dw_avisos.modify("datawindow.table.select= ~"" + isql_original_avisos + "~"")
end event

event key;call super::key;// LLamamos al key de la ventana
parent.trigger event key(key, keyflags)

end event

event buttonclicked;call super::buttonclicked;CHOOSE CASE dwo.name
	CASE 'b_ver_contrato'
		// Abrimos la ventana de deltalle
		//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
		g_fases_consulta.id_fase = this.getitemstring(row,'id_fase')
		message.stringparm = "w_fases_detalle"
		SetPointer(Hourglass!)
		w_aplic_frame.postevent("csd_fasesdetalle")
	//	post close(parent)
	CASE 'b_ver_aviso'
		if row < 1 then return
		setpointer(hourglass!)
		this.post event csd_abrir_ventana_minuta(row)
END CHOOSE
end event

event csd_tecla;call super::csd_tecla;parent.event key (key, keyflags)
end event

type dw_caja_pagos_caja from u_dw within w_caja
event csd_colocar_nif ( integer fila,  string nif )
boolean visible = false
integer x = 73
integer y = 256
integer width = 3621
integer height = 320
integer taborder = 170
string dataobject = "d_caja_pagos_caja"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_colocar_nif(integer fila, string nif);this.setitem(fila,'n_coleg_dni', nif)
end event

event buttonclicked;call super::buttonclicked;string tipo_persona, id_persona, nif

CHOOSE CASE dwo.name
	CASE 'b_dar_id'
		// Ponemos un nuevo id si no tiene valor
		if f_es_vacio(dw_caja_pagos_caja.GetItemString(1, 'id_caja_pagos')) then dw_caja_pagos_caja.setitem(1, 'id_caja_pagos', f_siguiente_numero('caja_pagos', 10))
	CASE 'b_buscar'
		// Tenemos que buscar y poner los datos
		tipo_persona = this.getitemstring(row, 'tipo_persona')
		CHOOSE CASE tipo_persona
			CASE 'P'
				// ES un cliente
				g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
				g_busqueda.dw="d_lista_busqueda_clientes_cta_contable"		
				id_persona=f_busqueda_clientes('')
				if id_persona="-1" then
					messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de cliente v$$HEX1$$e100$$ENDHEX$$lido.')
					return -1
				else
					this.SetItem(row,'id_persona',id_persona)
					select nif into :nif from clientes where id_cliente = :id_persona;
					this.SetItem(row,'n_coleg_dni',nif)
					this.SetItem(row,'nombre',LeftA(f_dame_cliente(id_persona), 40))
				end if
			CASE 'C'
				// Es un colegiado
				g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
				g_busqueda.dw="d_lista_busqueda_colegiados"
				id_persona=f_busqueda_colegiados()
				//Comprobamos que el colegiado existe
				if id_persona="-1" then
					messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
					this.setfocus()
					return -1
				else
					this.SetItem(row,'id_persona',id_persona)
					this.SetItem(row,'nombre',LeftA(f_colegiado_apellido(id_persona),40))
					this.SetItem(row,'n_coleg_dni',f_colegiado_n_col(id_persona))
				end if
		END CHOOSE
	CASE 'b_colegiados'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_persona=f_busqueda_colegiados()
		if not f_es_vacio(id_persona) then 
			this.SetItem(1,'id_colegiado',id_persona)
			this.SetItem(1,'id_cliente','')
		end if
		
	CASE 'b_clientes'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
		g_busqueda.dw="d_lista_busqueda_clientes"		
		id_persona=f_busqueda_clientes('')
		if not f_es_vacio(id_persona) then 
			this.SetItem(1,'id_cliente',id_persona)
			this.SetItem(1,'id_colegiado','')
		end if
	
//	CASE 'b_seleccionar_factura'
//		string id_factura, n_fact
//		open(w_busqueda_facturacion_emitida)
//		id_factura = message.stringparm
//		n_fact= f_dame_n_fact_de_id(id_factura)
//		this.SetItem(1,'n_factura',n_fact)
//		
END  CHOOSE

end event

event key;call super::key;// LLamamos al key de la ventana
parent.trigger event key(key, keyflags)

end event

event itemchanged;call super::itemchanged;string tipo_persona, id_col, nif, id_persona
st_ficha_cliente datos_cliente
long num_clientes

CHOOSE CASE dwo.name
	CASE 'tipo_persona'
		// Al cambiar el tipo de persona lo borramos todo lo de los datos del entregado
		this.setitem(row, 'id_persona', '')
		this.setitem(row, 'n_coleg_dni', '')
		this.setitem(row, 'nombre', '')
	CASE 'n_coleg_dni'
		tipo_persona = this.getitemstring(row, 'tipo_persona')
		CHOOSE CASE tipo_persona
			CASE 'P'
				// ES un cliente
				if f_es_vacio(data) then
					this.setitem(row, 'id_persona', '')
					this.SetItem(row,'nombre','')
					return
				end if
				// SCP-99
//				// El NIF / CIF tiene que ser de 9
//				if LenA(data) <> 9 then
//					messagebox(g_titulo, 'El NIF/CIF tiene que ser de 9 posiciones.')
//					return -1
//				end if
				nif = data
				if RightA(nif, 1) = '*' then
					nif = f_calculo_nif(nif)
					if nif = '-1' then return -1
				elseif RightA(nif,1) >= 'A' and RightA(nif,1) <= 'Z' then
					if not f_comprobar_nif(nif) then
						messagebox(g_titulo, 'La letra del NIF no es correcto')
						return -1
					end if
				end if
		
				select count(*) into :num_clientes from clientes where nif=:nif;
				if num_clientes > 0 then  
					if num_clientes = 1 then
						// obtenemos el id_cliente y calculamos todos los datos
						id_persona = f_cliente_id_cliente(nif)
					else
						g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
						g_busqueda.dw="d_lista_busqueda_clientes_cta_contable"               
						id_persona=f_busqueda_clientes(nif)
					end if
				else
					// No existe el cliente
					if MessageBox(g_titulo,'Este cliente NO existe, $$HEX1$$bf00$$ENDHEX$$Desea darlo de alta?',Question!,YesNo!,1)=1 then
						//Aqui va el c$$HEX1$$f300$$ENDHEX$$digo q abre la ventana 
						datos_cliente.nif=nif
						datos_cliente.tipo_tercero = g_terceros_codigos.codigo_cliente
						OpenWithParm(w_fases_ficha_cliente,datos_cliente)
						id_persona = Message.StringParm
					end if
				end if
				if nif <> '-1' then 
					this.setitem(row, 'id_persona', id_persona)
					this.SetItem(row,'nombre',LeftA(f_dame_cliente(id_persona), 40))
					this.post event csd_colocar_nif(row, nif)
				end if
			CASE 'C'
				// ES un colegiado
				id_col=f_colegiado_id_col(data)
				if f_es_vacio(id_col) then
					this.setitem(row, 'id_persona', '')
					this.SetItem(row,'nombre','')
				else
					this.setitem(row, 'id_persona', id_col)
					this.SetItem(row,'nombre',LeftA(f_colegiado_apellido(id_col), 40))
				end if
		END CHOOSE
		
			CASE 'n_factura'
				string id_factura
		// Permitimos que al colocar un numero de factura rellene el resto de datos
		// Cuando coloquen el id de la factura, rellenamos o vaciamos al menos el id
		if not f_es_vacio(data) then
			// Averiguamos el id_factura a partir del numero de la misma
			SELECT csi_facturas_emitidas.id_factura INTO :id_factura FROM csi_facturas_emitidas  WHERE csi_facturas_emitidas.n_fact = :data;			
			//this.post event csd_rellenar_datos_factura(id_factura)
		else
			this.setitem(row, 'id_factura','')
		end if
		
	CASE 'destinatario'
		if data = 'OT' then this.setitem(1, 'forma_pago', 'TA')

	CASE 'n_col'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_colegiado', f_colegiado_id_col(data))
END CHOOSE

end event

event csd_tecla;call super::csd_tecla;parent.event key (key, keyflags)
end event

type dw_busqueda_avisos from u_dw within w_caja
boolean visible = false
integer x = 55
integer y = 228
integer width = 3579
integer height = 188
integer taborder = 80
string dataobject = "d_caja_avisos_busqueda"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.visible = false
end event

event key;call super::key;// LLamamos al key de la ventana
parent.trigger event key(key, keyflags)

end event

event itemchanged;call super::itemchanged;string id_col

CHOOSE CASE dwo.name
	CASE 'unico_n_salida'
		// No hacemos nada
	CASE 'n_col'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_col', id_col)		
	CASE ELSE
		// Lanzamos al evento del bot$$HEX1$$f300$$ENDHEX$$n
		cb_buscar_avisos.trigger event clicked()
END CHOOSE

end event

event buttonclicked;call super::buttonclicked;string id_col

CHOOSE CASE dwo.name
	CASE 'b_1'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()
		//Comprobamos que el colegiado existe
		if id_col="-1" then
			messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
			this.setfocus()
			return -1
		else
			this.SetItem(1,'id_col',id_col)
			this.SetItem(1,'n_col',f_colegiado_n_col(id_col))				
		end if
END CHOOSE

end event

event csd_tecla;call super::csd_tecla;parent.event key (key, keyflags)
end event

type dw_seleccion_funcionamiento from u_dw within w_caja
event csd_colocar_opciones ( string opciones,  string columnas )
integer y = 16
integer width = 3639
integer height = 228
integer taborder = 60
string dataobject = "d_caja_seleccion_funcionamiento"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_colocar_opciones(string opciones, string columnas);dw_seleccion_funcionamiento.modify("opcion_funcionamiento.values = '"+opciones+"'")
dw_seleccion_funcionamiento.modify("opcion_funcionamiento.RadioButtons.Columns= "+columnas)

end event

event constructor;call super::constructor;// Insertamos una linea para que se pueda trabajar
this.insertRow(0)
end event

event key;call super::key;// LLamamos al key de la ventana
parent.trigger event key(key, keyflags)

end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE 'opcion_funcionamiento'
		// Lanzamos a la ventana con el radiobutton pulsado
		parent.post event csd_preparar_ventana(data)
END CHOOSE		
		
		

end event

event csd_tecla;call super::csd_tecla;parent.event key (key, keyflags)
end event

type dw_listado_cuadre_busqueda from u_dw within w_caja
event csd_fijar_variables ( boolean b_retrivear )
event csd_imprimir_periodo ( boolean b_exportar )
event csd_exportar_excel ( string opcion )
boolean visible = false
integer x = 18
integer y = 288
integer width = 3639
integer height = 380
integer taborder = 200
string dataobject = "d_caja_list_cuadre_busqueda"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_fijar_variables(boolean b_retrivear);// Evento que se encarga de tener actuazlizadas las variables de instancia de la consulta
if not f_Es_vacio(this.getitemString(1, 'centro')) then is_centro = this.getitemString(1, 'centro') else is_centro = '%'
if not f_Es_vacio(this.getitemString(1, 'banco')) then is_banco = this.getitemString(1, 'banco')
if not isnull(this.getitemDatetime(1, 'f_desde')) then idt_f_desde = this.getitemDatetime(1, 'f_desde')
if not isnull(this.getitemDatetime(1, 'f_hasta')) then idt_f_hasta = this.getitemDatetime(1, 'f_hasta')

if b_retrivear then
	// Si la fecha de visualizaci$$HEX1$$f300$$ENDHEX$$n est$$HEX2$$e0002000$$ENDHEX$$fuera del periodo, la quitamos y ponemos la fecha desde
	if date(idt_f_visualizada)<date(idt_f_desde) or date(idt_f_visualizada)>date(idt_f_hasta) then idt_f_visualizada = idt_f_desde
	
	// Lanzamos el evento que dejar$$HEX2$$e1002000$$ENDHEX$$el listado visible y preparado
	dw_listado_cuadre_caja.post event csd_Retrivear(is_centro, is_banco, idt_f_visualizada, FALSE )/*El ultimo parametro es si se quiere exportar a excel*/
end if	



end event

event csd_imprimir_periodo(boolean b_exportar);string mensaje, banco, centro
long n_dias, fila_banco, fila_centros, n_reg
int i
datetime f_fecha_bucle
datawindowchild dwc_bancos, dwc_centros
int pagina_inicial = 0 , paginas_totales = 0, n_paginas
boolean b_iterar_centros = false

// impedimos que se redibuje el dw
//dw_listado_cuadre_caja.setredraw(false)
parent.setredraw ( false ) 


// Lanzamos el evento que fija las variables de la consulta
this.trigger event csd_fijar_variables(false)
idt_f_visualizada = idt_f_desde
n_dias = daysafter(date(idt_f_desde), date(idt_f_hasta)) + 1
if n_dias>0 then
	
	// Miramos si tiene permiso para poder tocar y obtener un listado para otros centros 
	SELECT count(*) into :n_reg from t_permisos where cod_aplicacion = '0000000038' and cod_usuario = :g_usuario;
	if n_reg>0 then
		b_iterar_centros = (messagebox(g_titulo, "$$HEX1$$bf00$$ENDHEX$$Desea obtener el listado para todos los centros?", question!, yesno!, 2)=1)
	end if
	
	
	// Cogemos el desplegable de bancos
	dw_listado_cuadre_busqueda.getchild('banco' , dwc_bancos)
	dwc_bancos.settransobject(SQLCA)
	dw_listado_cuadre_busqueda.getchild('centro' , dwc_centros)
	dwc_centros.settransobject(SQLCA)
	
	
	// BUCLE CHORRA PARA CALCULAR EL NUMERO DE PAGINAS QUE DEBEN APARECER EN TOTAL
	for fila_centros = 1 TO dwc_centros.RowCount()
		centro = dwc_centros.getitemstring(fila_centros, 'centro')
		// Si no querian por centro, ponemos el seleccionado
		if not b_iterar_centros then centro = is_centro
		f_fecha_bucle = idt_f_desde
		DO WHILE date(f_fecha_bucle) <= date(idt_f_hasta)
			// Hacemos un buclecillo por banco
			FOR fila_banco = 1 TO dwc_bancos.RowCount()
				// Para cada forma de pago, procesamos el listado
				banco = dwc_bancos.GetitemString(fila_banco, 'codigo')
				// Lanzamos el evento que dejar$$HEX2$$e1002000$$ENDHEX$$el listado visible y preparado
				paginas_totales += dw_listado_cuadre_caja.trigger event csd_Retrivear(centro, banco, f_fecha_bucle, FALSE)
			NEXT
			// Pasamos al siguiente dia
			f_fecha_bucle = datetime(relativedate(date(f_fecha_bucle),1),time("00:00:00"))
		LOOP
		// Si no querian por centro, salimos del bucle de centros
		if not b_iterar_centros then exit
	NEXT
	
	// Colocamos la configuracion inicial
	pagina_inicial = 0
	dw_listado_cuadre_caja.modify("page_1.visible = '0'")
	dw_listado_cuadre_caja.modify("page_print_total.visible = '1'")
	dw_listado_cuadre_caja.modify("paginas_totales.Expression='"+string(paginas_totales)+"'")
	
	// Hacemos un bucle para que por cada dia del periodo indicado mande a imprimir todas y cada una de las posibles 
	// formas de pago existentes
	for fila_centros = 1 TO dwc_centros.RowCount()
		centro = dwc_centros.getitemstring(fila_centros, 'centro')
		// Si no querian por centro, ponemos el seleccionado
		if not b_iterar_centros then centro = is_centro
		
		f_fecha_bucle = idt_f_desde
		DO WHILE date(f_fecha_bucle) <= date(idt_f_hasta)
			// Hacemos un buclecillo por forma de pago
			FOR fila_banco = 1 TO dwc_bancos.RowCount()
				dw_listado_cuadre_caja.modify("pag_inicial.Expression='"+string(pagina_inicial)+"'")
				// Para cada forma de pago, procesamos el listado
				banco = dwc_bancos.GetitemString(fila_banco, 'codigo')
				// Lanzamos el evento que dejar$$HEX2$$e1002000$$ENDHEX$$el listado visible y preparado
				n_paginas = dw_listado_cuadre_caja.trigger event csd_Retrivear(centro, banco, f_fecha_bucle,b_exportar)
				if n_paginas >0 then
					// Cuando ha acabado el evento de retrivear, lanzamos a la impresora cada forma de pago
					if not b_exportar then dw_listado_cuadre_caja.print()
					pagina_inicial += n_paginas
				end if
			NEXT
			// Pasamos al siguiente dia
			f_fecha_bucle = datetime(relativedate(date(f_fecha_bucle),1),time("00:00:00"))
		LOOP
		
		// Si no querian por centro, salimos del bucle de centros
		if not b_iterar_centros then exit
	next
	// Dejamos lo que habia
	dw_listado_cuadre_caja.modify("page_1.visible = '1'")
	dw_listado_cuadre_caja.modify("page_print_total.visible = '0'")

	parent.setredraw ( true ) 
	dw_listado_cuadre_caja.setredraw(true)
else
	messageBox(g_titulo, "Rango de fechas no v$$HEX1$$e100$$ENDHEX$$lido", stopsign!)
	parent.setredraw ( true ) 
	dw_listado_cuadre_caja.setredraw(true)

	return
end if
end event

event csd_exportar_excel(string opcion);// Evento que se encarga de exportar a excel. Para ello se rellena un dw external que ser$$HEX2$$e1002000$$ENDHEX$$el que se guarde 


// Paso 1 : Creamos el datastore que ser$$HEX2$$e1002000$$ENDHEX$$necesario para la exportacion, solo si no est$$HEX2$$e1002000$$ENDHEX$$creado ya
if not isvalid(ids_caja_exportar_excel) then
	ids_caja_exportar_excel = create datastore
	ids_caja_exportar_excel.dataobject = 'd_caja_list_caja_exportar_excel'
end if

//Lo vaciamos por si tenia algo (solo estar$$HEX2$$e1002000$$ENDHEX$$vacio la primera vez que se cree)
ids_caja_exportar_excel.reset()



// SEG$$HEX1$$da00$$ENDHEX$$N EL BOT$$HEX1$$d300$$ENDHEX$$N PULSADO GNERAREMOS PARA TODO O SOLO PARA LO QUE HAY EN PANTALLA
CHOOSE CASE OPCION
	CASE 'VISUALIZADO'
		 	if dw_listado_cuadre_caja.visible = true then 
				// Podemos llamar a este evento para que refresque o directamente a la funcion que copia
				// Lanzamos el evento que dejar$$HEX2$$e1002000$$ENDHEX$$el listado visible y preparado
//				dw_listado_cuadre_caja.trigger event csd_Retrivear(is_centro, is_banco, idt_f_visualizada, TRUE) /*El ultimo parametro indica si es exportable a excel*/
				
				string banco_desc, centro_desc
				banco_desc = f_dame_desc_banco(is_banco,g_empresa)
				dw_listado_cuadre_caja.Modify("banco_t.text = '"+banco_desc+"'")
				select descripcion into :centro_desc from delegaciones where centro = :is_centro;
				dw_listado_cuadre_caja.Modify("centro_t.text = '"+centro_desc+"'")
				wf_rellenar_pagina_exportar(centro_desc, banco_desc, idt_f_visualizada)
			end if
	CASE 'TODO'
			string centro, banco
			datetime fecha
			centro = is_centro
			banco = is_banco
			fecha = idt_f_visualizada
			this.trigger event csd_imprimir_periodo(TRUE) /*El parametro indica si es exportable a excel*/
			// Volvemos a dejar el listado de pantalla como estaba
			dw_listado_cuadre_caja.trigger event csd_Retrivear(centro, banco, fecha, FALSE)
	CASE ELSE
		return
END CHOOSE



// Paso ultimo... Destruimos el datastore
if isvalid(ids_caja_exportar_excel) then 
	// Nos apuntamos el directorio actual para no tener problemas con las imagenes
	n_cst_filesrvwin32 cambia_directorio
	string directorio, nom_fich
	cambia_directorio = create n_cst_filesrvwin32
	directorio = cambia_directorio.of_getcurrentdirectory()
	If GetFileSaveName('Seleccione el nombre del fichero a generar',nom_fich,nom_fich,'.XLS','Ficheros de EXCEL (*.XLS),*.XLS') <> 1 Then	
		// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
		cambia_directorio.of_changedirectory(directorio)
		destroy cambia_directorio
		return 
	End If
	cambia_directorio.of_changedirectory(directorio)
	destroy cambia_directorio

	
	ids_caja_exportar_excel.saveas(nom_fich,  excel!, true)
	Messagebox(g_titulo, "Generado el fichero "+cr+nom_fich)
	// guardamos el datastore e exportamos
	destroy ids_caja_exportar_excel
end if

end event

event buttonclicked;call super::buttonclicked;string mensaje, centro
datetime f_hasta, f_desde


CHOOSE CASE dwo.name
	CASE 'b_borrar_centro'
		// Borramos el centro seleccionado
		this.setitem(row, 'centro', '')
	CASE 'b_borrar_banco'
		// Borramos el banco seleccionado
		this.setitem(row, 'banco', '')
	CASE 'b_visualizar'
		if g_colegio = 'COAATTFE' then
			// Es necesario que est$$HEX2$$e9002000$$ENDHEX$$todo colocado, forma de pago, fecha desde, fecha_hasta
			this.accepttext()
			mensaje = ''
			mensaje += f_valida(dw_listado_cuadre_busqueda, 'centro', 'NOVACIO', "Debe indicar un centro")
			mensaje += f_valida(dw_listado_cuadre_busqueda, 'banco', 'NOVACIO', "Debe indicar un banco")
			mensaje += f_valida(dw_listado_cuadre_busqueda, 'f_desde', 'NONULO', "Debe indicar una fecha desde")
			mensaje += f_valida(dw_listado_cuadre_busqueda, 'f_hasta', 'NONULO', "Debe indicar una fecha hasta")
			if not f_es_vacio(mensaje) then
				messageBox(g_titulo, mensaje, stopsign!)
				return
			else
				// Lanzamos el evento que fija las variables de la consulta
				this.trigger event csd_fijar_variables(false)
				idt_f_visualizada = idt_f_desde
				// Lanzamos el evento que dejar$$HEX2$$e1002000$$ENDHEX$$el listado visible y preparado
				dw_listado_cuadre_caja.trigger event csd_Retrivear(is_centro, is_banco, idt_f_visualizada, FALSE) /*El ultimo parametro indica si es exportable a excel*/
				
			end if
		else
			///*** SCP-1244. Alexis. 11/04/2011. Cambios para adaptar el listado a la empresa. ***///
			dw_listado_cuadre_busqueda.accepttext()
			centro = dw_listado_cuadre_busqueda.getitemstring(1,'centro')
			if f_es_vacio(centro) then 
				centro = '%'
			end if
			f_desde = dw_listado_cuadre_busqueda.getitemdatetime(1,'f_desde')
			f_hasta = dw_listado_cuadre_busqueda.getitemdatetime(1,'f_hasta')	
//			dw_listado_cuadre_caja.BorderStyle = StyleLowered!
//			dw_listado_cuadre_caja.object.datawindow.print.preview.zoom = 75
//			dw_listado_cuadre_caja.visible = true
			dw_listado_cuadre_caja.retrieve(f_desde, f_hasta, centro, g_usuario, g_empresa)
			
			
			
			
			
		end if
	CASE 'b_imprimir_visualizado'
		// Simplemente mandamos el dw de abajo a imprimir
		if dw_listado_cuadre_caja.visible = true then 
			// Por orden de andres, imprimimos 3 veces
			dw_listado_cuadre_caja.print()
			dw_listado_cuadre_caja.print()
			dw_listado_cuadre_caja.print()
		end if
	CASE 'b_imprimir'
		// Imprimimos todo, por lo que puede ser larga la cosa
		// Es necesario que est$$HEX2$$e9002000$$ENDHEX$$todo colocado fecha desde, fecha_hasta
		this.accepttext()
		mensaje = ''
		mensaje += f_valida(dw_listado_cuadre_busqueda, 'f_desde', 'NONULO', "Debe indicar una fecha desde")
		mensaje += f_valida(dw_listado_cuadre_busqueda, 'f_hasta', 'NONULO', "Debe indicar una fecha hasta")
		if not f_es_vacio(mensaje) then
			messageBox(g_titulo, mensaje, stopsign!)
			return
		else
			// Lanzamos el evento que se encargar$$HEX2$$e1002000$$ENDHEX$$de hacer el periodo
			if g_colegio = 'COAATTFE' then
				this.trigger event csd_imprimir_periodo(FALSE) // El valor del par$$HEX1$$e100$$ENDHEX$$metro es si es exportable a excel
			else
				dw_listado_cuadre_caja.print()
			end if
		end if
		
	CASE 'b_especificar_impresora'
		// Permitirmos la seleccion de la impresora
		PrintSetup()
	CASE 'b_dia_anterior'
		// Pasamos al siguiente dia en visualizaci$$HEX1$$f300$$ENDHEX$$n manteniendo la forma de pago
		idt_f_visualizada = datetime(relativedate(date(idt_f_visualizada), -1),time("00:00"))
		// Lanzamos el evento que dejar$$HEX2$$e1002000$$ENDHEX$$el listado visible y preparado
		dw_listado_cuadre_caja.trigger event csd_Retrivear(is_centro, is_banco, idt_f_visualizada, FALSE) /*El ultimo parametro indica si es exportable a excel*/

	CASE 'b_dia_siguiente'
		// Pasamos al siguiente dia en visualizaci$$HEX1$$f300$$ENDHEX$$n manteniendo la forma de pago
		idt_f_visualizada = datetime(relativedate(date(idt_f_visualizada), 1),time("00:00"))
		// Lanzamos el evento que dejar$$HEX2$$e1002000$$ENDHEX$$el listado visible y preparado
		dw_listado_cuadre_caja.trigger event csd_Retrivear(is_centro, is_banco, idt_f_visualizada, FALSE) /*El ultimo parametro indica si es exportable a excel*/


	CASE 'b_exportar'
		// llamamos al evento que exporta solo lo visualizado
		this.trigger event csd_exportar_excel('VISUALIZADO')
	CASE 'b_exportar_todo'
		// LLamamos al evento que lo exporta
		this.trigger event csd_exportar_excel('TODO')

END CHOOSE		
end event

event itemchanged;call super::itemchanged;// Lanzamos al evento que modifica las variables
if g_colegio = 'COAATTFE' then this.post event csd_fijar_variables(true)

end event

event constructor;call super::constructor;if g_debug = '1' then
	this.object.b_exportar.visible = true
	this.object.b_exportar_todo.visible = true
end if


end event

event key;call super::key;// LLamamos al key de la ventana
parent.trigger event key(key, keyflags)

end event

event csd_tecla;call super::csd_tecla;parent.event key (key, keyflags)
end event

type cb_buscar_avisos from commandbutton within w_caja
boolean visible = false
integer x = 2674
integer y = 284
integer width = 402
integer height = 92
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Buscar"
end type

event clicked;//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo

// Aceptamos el texto que ponga
dw_busqueda_avisos.trigger event pfc_accepttext(true)

//CHOOSE CASE g_colegio
//	CASE 'COAATTFE'
//		mensaje += f_valida(dw_busqueda_avisos, 'n_expediente', )
//END CHOOSE

// Pillamos la SQL
sql_nuevo = dw_avisos.describe("datawindow.table.select")
isql_original_avisos = sql_nuevo

f_sql('expedientes.n_expedi','LIKE','n_expediente',dw_busqueda_avisos,sql_nuevo,g_tipo_base_datos,'')
f_sql('fases.n_registro','LIKE','n_registro',dw_busqueda_avisos,sql_nuevo,g_tipo_base_datos,'')
f_sql('fases_minutas.n_aviso','LIKE','n_aviso',dw_busqueda_avisos,sql_nuevo,g_tipo_base_datos,'')
f_sql('fases_minutas.id_colegiado','LIKE','id_col',dw_busqueda_avisos,sql_nuevo,g_tipo_base_datos,'')
if g_colegio<>'COAATTFE' then  
	f_sql('fases.archivo','LIKE','n_visado',dw_busqueda_avisos,sql_nuevo,g_tipo_base_datos,'')	
end if
if dw_busqueda_avisos.dataobject='d_caja_avisos_frac_busqueda' then
	f_sql('fases_minutas.forma_pago','LIKE','formapago',dw_busqueda_avisos,sql_nuevo,g_tipo_base_datos,'')
	f_sql('fases_minutas.fecha','<=','fecha_h',dw_busqueda_avisos,sql_nuevo,g_tipo_base_datos,'')
else
	// Parametrizado para GC  CGC-96
	if g_colegio<>'COAATGC' then f_sql('fases.modalidad','LIKE','centro',dw_busqueda_avisos,sql_nuevo,g_tipo_base_datos,'%')	
	
end if

// Modificamos la SQL
dw_avisos.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")

//messagebox("sql_nuevo", sql_nuevo)
dw_avisos.retrieve()
isql_aplicado_consulta_avisos = sql_nuevo



end event

event constructor;this.visible = false
end event

type dw_caja_pagos_consulta from u_dw within w_caja
boolean visible = false
integer x = 2862
integer y = 284
integer width = 754
integer height = 312
integer taborder = 40
string dataobject = "d_caja_pagos_consulta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_tecla;call super::csd_tecla;parent.event key (key, keyflags)
end event

type cb_consultar_pagos from commandbutton within w_caja
boolean visible = false
integer x = 2962
integer y = 456
integer width = 613
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Consultar"
end type

event clicked;// Consultamos por lo de la fecha que hayan colocado
datetime fecha
string mensaje, mensaje_cuenta
if g_colegio <> 'COAATTFE' then
	
	

dw_caja_pagos_caja.trigger event pfc_accepttext(true)

if f_es_vacio(dw_caja_pagos_caja.getitemstring(1,'descripcion')) then mensaje += 'Debe introducir la Descripci$$HEX1$$f300$$ENDHEX$$n.' + cr
if f_es_vacio(dw_caja_pagos_caja.getitemstring(1,'nombre')) and dw_caja_pagos_caja.getitemstring(1,'destinatario')<>'OT' then mensaje += 'Debe introducir el Destinatario.' + cr
if f_es_vacio(dw_caja_pagos_caja.getitemstring(1,'nombre_otro')) and dw_caja_pagos_caja.getitemstring(1,'destinatario')='OT' then mensaje += 'Debe introducir el Destinatario.' + cr
if isnull(dw_caja_pagos_caja.getitemdatetime(1,'f_entrada')) then mensaje += 'Debe introducir la Fecha de Entrada.' + cr
if f_es_vacio(string(dw_caja_pagos_caja.getitemnumber(1,'importe'))) then
        mensaje += 'Debe introducir el Importe.' + cr
elseif dw_caja_pagos_caja.getitemnumber(1,'importe') = 0 then 
        mensaje += 'El importe no puede ser cero.' + cr
end if

// Se valida la cuenta de contrapartida de "otro"
if dw_caja_pagos_caja.getitemstring(1,'destinatario')='OT' then mensaje_cuenta += f_validar_cuenta_mensaje(dw_caja_pagos_caja.getitemstring(1,'contrapartida'), 1,'')
if not f_es_vacio(mensaje_cuenta) then	mensaje += mensaje_cuenta


if mensaje <> '' then
	messagebox(g_titulo, mensaje, stopsign!)
	return
end if

wf_generar_liquidacion()

messagebox(g_titulo, 'Proceso finalizado.')

else
	
	dw_caja_pagos_consulta.trigger event pfc_accepttext(true)
	fecha = dw_caja_pagos_consulta.getitemdatetime(dw_caja_pagos_consulta.getrow(), 'fecha')
	dw_caja_pagos_caja_lista.retrieve(fecha)
	if date(fecha) <> today() then
		dw_caja_pagos_caja_lista.modify("titulo_t.text = 'COBROS REALIZADOS EL DIA "+string(date(fecha), "dd/mm/yyyy")+"'")
	else
		dw_caja_pagos_caja_lista.modify("titulo_t.text = 'COBROS REALIZADOS EL DIA DE HOY'")
	end if
end if
end event

