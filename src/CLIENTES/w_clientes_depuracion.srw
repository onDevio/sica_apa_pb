HA$PBExportHeader$w_clientes_depuracion.srw
forward
global type w_clientes_depuracion from w_popup
end type
type cb_imprimir from commandbutton within w_clientes_depuracion
end type
type cb_actualizar from commandbutton within w_clientes_depuracion
end type
type cb_previsualizar_todos from commandbutton within w_clientes_depuracion
end type
type cb_previsualizar from commandbutton within w_clientes_depuracion
end type
type cb_listar from commandbutton within w_clientes_depuracion
end type
type cb_borrar from commandbutton within w_clientes_depuracion
end type
type dw_mostar_detalle from u_dw within w_clientes_depuracion
end type
type st_1 from statictext within w_clientes_depuracion
end type
type cb_siguiente from commandbutton within w_clientes_depuracion
end type
type cb_anterior from commandbutton within w_clientes_depuracion
end type
type dw_opcion_a_comprobar from datawindow within w_clientes_depuracion
end type
type dw_clientes_detalle from u_dw within w_clientes_depuracion
end type
type dw_listado from u_dw within w_clientes_depuracion
end type
type st_3 from statictext within w_clientes_depuracion
end type
type st_2 from statictext within w_clientes_depuracion
end type
end forward

global type w_clientes_depuracion from w_popup
integer x = 214
integer y = 221
integer width = 3621
integer height = 2380
string title = "Depuraci$$HEX1$$f300$$ENDHEX$$n Clientes"
boolean resizable = false
event csd_refrescar_cliente ( string id_cliente )
cb_imprimir cb_imprimir
cb_actualizar cb_actualizar
cb_previsualizar_todos cb_previsualizar_todos
cb_previsualizar cb_previsualizar
cb_listar cb_listar
cb_borrar cb_borrar
dw_mostar_detalle dw_mostar_detalle
st_1 st_1
cb_siguiente cb_siguiente
cb_anterior cb_anterior
dw_opcion_a_comprobar dw_opcion_a_comprobar
dw_clientes_detalle dw_clientes_detalle
dw_listado dw_listado
st_3 st_3
st_2 st_2
end type
global w_clientes_depuracion w_clientes_depuracion

type variables
boolean ib_procesar_todos = false, ib_terminado = false
end variables

forward prototypes
public subroutine wf_rellenar_registro (string id_cliente, string nif, string apellidos, string ficha, string descripcion, string descripcion2, string descripcion3, string interno, string tabla)
public subroutine wf_rellenar_listado ()
public subroutine wf_refrescar_cliente (string id_cliente)
end prototypes

event csd_refrescar_cliente(string id_cliente);wf_refrescar_cliente(id_cliente)

end event

public subroutine wf_rellenar_registro (string id_cliente, string nif, string apellidos, string ficha, string descripcion, string descripcion2, string descripcion3, string interno, string tabla);// funcion que mete un registro para el listado
long fila

fila = dw_listado.InsertRow(0)
dw_listado.setitem(fila, 'id_cliente', id_cliente)
dw_listado.setitem(fila, 'nif', nif)
dw_listado.setitem(fila, 'apellidos', apellidos)
dw_listado.setitem(fila, 'ficha', ficha)
dw_listado.setitem(fila, 'descripcion', descripcion)
dw_listado.setitem(fila, 'descripcion2', descripcion2)
dw_listado.setitem(fila, 'descripcion3', descripcion3)
dw_listado.setitem(fila, 'interno', interno)
dw_listado.setitem(fila, 'tabla', tabla)





end subroutine

public subroutine wf_rellenar_listado ();// Rellenamos el listado para el cliente actual
long row, fila
string tabla, id_cliente, nif, apellidos, descripcion,descripcion2, descripcion3, id_interno

id_cliente = dw_clientes_detalle.GetItemString(dw_clientes_detalle.getRow(), 'id_cliente')
nif =  dw_clientes_detalle.GetItemString(dw_clientes_detalle.getRow(), 'nif')
apellidos = dw_clientes_detalle.GetItemString(dw_clientes_detalle.getRow(), 'apellidos')
For row =1 TO dw_opcion_a_comprobar.RowCount()
	// Si tiene filas ese cliente es porque en algo falla, podemos rellenar los datos basicos
	tabla = dw_opcion_a_comprobar.getitemstring(row, 'tabla')
	descripcion  = ''
	descripcion2 = ''
	descripcion3 = '' 
	id_interno   = ''
	dw_mostar_detalle.visible = false
	CHOOSE CASE tabla
		CASE 'PREMAAT'
			// Lo metemos en el listado directamente
			dw_mostar_detalle.dataobject = 'd_clientes_depuracion_premaat'
			dw_mostar_detalle.settransobject (SQLCA)
			// Lo metemos en el listado directamente
			dw_mostar_detalle.settransobject (SQLCA)
			if dw_mostar_detalle.retrieve (id_cliente)>0 then
				// Colocamos estos datos en el dw del listado
				FOR fila = 1 TO dw_mostar_detalle.RowCount()
					// Cogemos los valores
					descripcion = 'N$$HEX1$$ba00$$ENDHEX$$Colegiado'
					descripcion2 = dw_mostar_detalle.GetItemString(fila, 'colegiados_n_colegiado')
					id_interno = dw_mostar_detalle.GetItemString(fila, 'id_premaat')
					wf_rellenar_registro(id_cliente, nif, apellidos, 'PREMAAT', descripcion, descripcion2, descripcion3, id_interno, tabla)
				NEXT
			end if
		CASE 'PREMAAT_BENEFICIARIO'
			dw_mostar_detalle.dataobject = 'd_clientes_depuracion_premaat_benef'
			dw_mostar_detalle.settransobject (SQLCA)
			if dw_mostar_detalle.retrieve (id_cliente)>0 then
				// Colocamos estos datos en el dw del listado
				FOR fila = 1 TO dw_mostar_detalle.RowCount()
					// Cogemos los valores
					descripcion = 'Consulta N$$HEX1$$ba00$$ENDHEX$$colegiado'
					descripcion2 = dw_mostar_detalle.GetItemString(fila, 'premaat_n_col')
					id_interno = dw_mostar_detalle.GetItemString(fila, 'id')
					wf_rellenar_registro(id_cliente, nif, apellidos, 'PREMAAT (beneficiarios)', descripcion, descripcion2, descripcion3, id_interno, tabla)
				NEXT
			end if
		CASE 'PREMAAT_LIQUIDACIONES'
			dw_mostar_detalle.dataobject = 'd_clientes_depuracion_premaat_liquid'
			dw_mostar_detalle.settransobject (SQLCA)
			if dw_mostar_detalle.retrieve (id_cliente)>0 then
				// Colocamos estos datos en el dw del listado
				FOR fila = 1 TO dw_mostar_detalle.RowCount()
					// Cogemos los valores
					descripcion = 'Estado ; Apellidos'
					descripcion2 ="Todas ; "+apellidos
					id_interno = dw_mostar_detalle.GetItemString(fila, 'id_liquidacion')
					wf_rellenar_registro(id_cliente, nif, apellidos, 'Consulta Pagos PREMAAT', descripcion, descripcion2, descripcion3, id_interno, tabla)
				NEXT
			end if
		CASE 'PRESTACIONES'
			dw_mostar_detalle.dataobject = 'd_clientes_depuracion_premaat_prestaci'
			dw_mostar_detalle.settransobject (SQLCA)
			if dw_mostar_detalle.retrieve (id_cliente)>0 then
				// Colocamos estos datos en el dw del listado
				FOR fila = 1 TO dw_mostar_detalle.RowCount()
					// Cogemos los valores
					descripcion = 'Consulta N$$HEX1$$ba00$$ENDHEX$$colegiado'
					descripcion2 = dw_mostar_detalle.GetItemString(fila, 'premaat_n_col')
					id_interno = dw_mostar_detalle.GetItemString(fila, 'id_prestaciones')
					wf_rellenar_registro(id_cliente, nif, apellidos, 'PREMAAT (prestaciones)', descripcion, descripcion2, descripcion3, id_interno, tabla)
				NEXT
			end if
		CASE 'LISTAS'
			dw_mostar_detalle.dataobject = 'd_clientes_depuracion_listas_detalle'
			dw_mostar_detalle.settransobject (SQLCA)
			if dw_mostar_detalle.retrieve (id_cliente)>0 then
				// Colocamos estos datos en el dw del listado
				FOR fila = 1 TO dw_mostar_detalle.RowCount()
					// Cogemos los valores
					descripcion = 'Nombre lista ; Propietario'
					descripcion2 = dw_mostar_detalle.GetItemString(fila, 'nombre_lista')+" ; "+dw_mostar_detalle.GetItemString(fila, 'propietario')
					id_interno = dw_mostar_detalle.GetItemString(fila, 'id_lista')
					wf_rellenar_registro(id_cliente, nif, apellidos, 'LISTAS', descripcion, descripcion2, descripcion3, id_interno, tabla)
				NEXT
			end if
		CASE 'MINUTAS'
			dw_mostar_detalle.dataobject = 'd_clientes_depuracion_fases_minutas'
			dw_mostar_detalle.settransobject (SQLCA)
			if dw_mostar_detalle.retrieve (id_cliente)>0 then
				// Colocamos estos datos en el dw del listado
				FOR fila = 1 TO dw_mostar_detalle.RowCount()
					// Cogemos los valores
					descripcion = 'N$$HEX1$$ba00$$ENDHEX$$Aviso ; N$$HEX1$$ba00$$ENDHEX$$Registro ; N$$HEX1$$ba00$$ENDHEX$$Contrato '
					descripcion2 = dw_mostar_detalle.GetItemString(fila, 'n_aviso')+" ; "+dw_mostar_detalle.GetItemString(fila, 'fases_n_registro')+" ; "+dw_mostar_detalle.GetItemString(fila, 'fases_n_expedi')
					id_interno = dw_mostar_detalle.GetItemString(fila, 'id_minuta')
					wf_rellenar_registro(id_cliente, nif, apellidos, 'AVISOS o CONTRATOS', descripcion, descripcion2, descripcion3, id_interno, tabla)
				NEXT
			end if
		CASE 'GARANTIAS'
			dw_mostar_detalle.dataobject = 'd_clientes_depuracion_garantias_lista'
			dw_mostar_detalle.settransobject (SQLCA)
			if dw_mostar_detalle.retrieve (id_cliente)>0 then
				// Colocamos estos datos en el dw del listado
				FOR fila = 1 TO dw_mostar_detalle.RowCount()
					// Cogemos los valores
					descripcion = 'N$$HEX1$$ba00$$ENDHEX$$Registro ; N$$HEX1$$ba00$$ENDHEX$$Contrato'
					descripcion2 = dw_mostar_detalle.GetItemString(fila, 'fases_n_registro')+" ; "+dw_mostar_detalle.GetItemString(fila, 'fases_n_expedi')
					id_interno = dw_mostar_detalle.GetItemString(fila, 'id_fase')
					descripcion3 = "id_colegiado = " + dw_mostar_detalle.GetItemString(fila, 'id_colegiado')+" id_cliente = " + dw_mostar_detalle.GetItemString(fila, 'id_cliente')
					wf_rellenar_registro(id_cliente, nif, apellidos, 'CONTRATOS (garantias)', descripcion, descripcion2, descripcion3, id_interno, tabla)
				NEXT
			end if
//		CASE 'DEPOSITOS'
//			dw_mostar_detalle.dataobject = 'd_temporal_fases_depositos_depuracion'
//			dw_mostar_detalle.settransobject (SQLCA)
//			if dw_mostar_detalle.retrieve (id_cliente)>0 then
//				// Colocamos estos datos en el dw del listado
//				FOR fila = 1 TO dw_mostar_detalle.RowCount()
//					// Cogemos los valores
//					descripcion = 'N$$HEX1$$ba00$$ENDHEX$$Registro ; N$$HEX1$$ba00$$ENDHEX$$Contrato'
//					descripcion2 = dw_mostar_detalle.GetItemString(fila, 'fases_n_registro')+" ; "+dw_mostar_detalle.GetItemString(fila, 'fases_n_expedi')
//					id_interno = dw_mostar_detalle.GetItemString(fila, 'id_deposito')
//					wf_rellenar_registro(id_cliente, nif, apellidos, 'CONTRATOS (depositos)', descripcion, descripcion2, descripcion3, id_interno, tabla)
//				NEXT
//			end if
		CASE 'FACTURAS'
			dw_mostar_detalle.dataobject = 'd_clientes_depuracion_fact_emitida_lista'
			dw_mostar_detalle.settransobject (SQLCA)
			if dw_mostar_detalle.retrieve (id_cliente)>0 then
				// Colocamos estos datos en el dw del listado
				FOR fila = 1 TO dw_mostar_detalle.RowCount()
					// Cogemos los valores
					descripcion = 'N$$HEX1$$ba00$$ENDHEX$$factura'
					descripcion2 = dw_mostar_detalle.GetItemString(fila, 'n_fact')
					id_interno = dw_mostar_detalle.GetItemString(fila, 'id_factura')
					wf_rellenar_registro(id_cliente, nif, apellidos, 'FACTURAS', descripcion, descripcion2, descripcion3, id_interno, tabla)
				NEXT
			end if
		CASE 'LINEAS FACTURA'
			dw_mostar_detalle.dataobject = 'd_clientes_depuracion_fact_emitida_linea'
			dw_mostar_detalle.settransobject (SQLCA)
			// Lo metemos en el listado directamente
			dw_mostar_detalle.settransobject (SQLCA)
			if dw_mostar_detalle.retrieve (id_cliente)>0 then
				// Colocamos estos datos en el dw del listado
				FOR fila = 1 TO dw_mostar_detalle.RowCount()
					// Cogemos los valores
					descripcion = 'N$$HEX1$$ba00$$ENDHEX$$factura'
					descripcion2 = dw_mostar_detalle.GetItemString(fila, 'csi_facturas_emitidas_n_fact')
					id_interno = dw_mostar_detalle.GetItemString(fila, 'id_linea')
					wf_rellenar_registro(id_cliente, nif, apellidos, 'FACTURAS (LINEAS)', descripcion, descripcion2, descripcion3, id_interno, tabla)
				NEXT
			end if
		CASE 'COLEGIADOS'
			dw_mostar_detalle.dataobject = 'd_clientes_depuracion_colegiado_empresas'
			dw_mostar_detalle.settransobject (SQLCA)
			if dw_mostar_detalle.retrieve (id_cliente)>0 then
				// Colocamos estos datos en el dw del listado
				FOR fila = 1 TO dw_mostar_detalle.RowCount()
					// Cogemos los valores
					descripcion = 'N$$HEX1$$ba00$$ENDHEX$$Colegiado'
					descripcion2 = dw_mostar_detalle.GetItemString(fila, 'colegiados_n_colegiado')
					id_interno = dw_mostar_detalle.GetItemString(fila, 'id_colegiado')
					wf_rellenar_registro(id_cliente, nif, apellidos, 'COLEGIADOS (empresas)', descripcion, descripcion2, descripcion3, id_interno, tabla)
				NEXT
			end if
	CASE 'CONTRATOS'
			dw_mostar_detalle.dataobject = 'd_clientes_depuracion_lista_promot_contr'
			dw_mostar_detalle.settransobject (SQLCA)
			if dw_mostar_detalle.retrieve (id_cliente)>0 then
				// Colocamos estos datos en el dw del listado
				FOR fila = 1 TO dw_mostar_detalle.RowCount()
					// Cogemos los valores
					descripcion = 'N$$HEX1$$ba00$$ENDHEX$$Registro ; N$$HEX1$$ba00$$ENDHEX$$Contrato'
					descripcion2 = dw_mostar_detalle.GetItemString(fila, 'fases_n_registro')+" ; "+dw_mostar_detalle.GetItemString(fila, 'fases_n_expedi')
					id_interno = dw_mostar_detalle.GetItemString(fila, 'id_fase')
					wf_rellenar_registro(id_cliente, nif, apellidos, 'CONTRATOS', descripcion, descripcion2, descripcion3, id_interno, tabla)
				NEXT
			end if
	END CHOOSE
NEXT

end subroutine

public subroutine wf_refrescar_cliente (string id_cliente);string mensaje = ''
long n_reg, fila, fila2


st_1.visible = true
setpointer(hourglass!)

dw_clientes_detalle.retrieve(id_cliente)
dw_opcion_a_comprobar.reset()
dw_mostar_detalle.visible = false


// COMPROBACIONES PARA PREMAAT
select count(*) into :n_reg from premaat where id_heredero = :id_cliente;
if n_reg>0 then 
	mensaje += "El tercero est$$HEX2$$e1002000$$ENDHEX$$como heredero en PREMAAT"+cr
	fila2 = dw_opcion_a_comprobar.insertRow(0)
	dw_opcion_a_comprobar.SetItem(fila2, 'tabla', 'PREMAAT')
	dw_opcion_a_comprobar.SetItem(fila2, 'cuantos', n_reg)
end if
select count(*) into :n_reg from premaat_beneficiarios where id_heredero = :id_cliente;
if n_reg>0 then 
	mensaje += "El tercero est$$HEX2$$e1002000$$ENDHEX$$como beneficiario en PREMAAT"+cr
	fila2 = dw_opcion_a_comprobar.insertRow(0)
	dw_opcion_a_comprobar.SetItem(fila2, 'tabla', 'PREMAAT_BENEFICIARIO')
	dw_opcion_a_comprobar.SetItem(fila2, 'cuantos', n_reg)
end if
select count(*) into :n_reg from premaat_liquidaciones where id_beneficiario = :id_cliente;
if n_reg>0 then 
	mensaje += "El tercero est$$HEX2$$e1002000$$ENDHEX$$en las liquidaciones de PREMAAT"+cr
	fila2 = dw_opcion_a_comprobar.insertRow(0)
	dw_opcion_a_comprobar.SetItem(fila2, 'tabla', 'PREMAAT_LIQUIDACIONES')
	dw_opcion_a_comprobar.SetItem(fila2, 'cuantos', n_reg)
end if
select count(*) into :n_reg from premaat_prestaciones where id_persona = :id_cliente and tipo_persona = 'B';
if n_reg>0 then 
	mensaje += "El tercero est$$HEX2$$e1002000$$ENDHEX$$en las liquidaciones de PREMAAT"+cr
	fila2 = dw_opcion_a_comprobar.insertRow(0)
	dw_opcion_a_comprobar.SetItem(fila2, 'tabla', 'PRESTACIONES')
	dw_opcion_a_comprobar.SetItem(fila2, 'cuantos', n_reg)
end if

// COMPROBACIONES PARA LISTAS
select count(*) into :n_reg from listas_miembros where id_cliente = :id_cliente;
if n_reg>0 then 
	mensaje += "El tercero est$$HEX2$$e1002000$$ENDHEX$$en las listas"+cr
	fila2 = dw_opcion_a_comprobar.insertRow(0)
	dw_opcion_a_comprobar.SetItem(fila2, 'tabla', 'LISTAS')
	dw_opcion_a_comprobar.SetItem(fila2, 'cuantos', n_reg)
end if



// COMPROBACIONES PARA FASES
select count(*) into :n_reg from fases_clientes where id_cliente = :id_cliente;
if n_reg>0 then 
	mensaje += "El tercero est$$HEX2$$e1002000$$ENDHEX$$en los contratos"+cr
	fila2 = dw_opcion_a_comprobar.insertRow(0)
	dw_opcion_a_comprobar.SetItem(fila2, 'tabla', 'CONTRATOS')
	dw_opcion_a_comprobar.SetItem(fila2, 'cuantos', n_reg)
end if
select count(*) into :n_reg from fases_minutas where id_cliente = :id_cliente;
if n_reg>0 then 
	mensaje += "El tercero est$$HEX2$$e1002000$$ENDHEX$$en las minutas"+cr
	fila2 = dw_opcion_a_comprobar.insertRow(0)
	dw_opcion_a_comprobar.SetItem(fila2, 'tabla', 'MINUTAS')
	dw_opcion_a_comprobar.SetItem(fila2, 'cuantos', n_reg)
end if
select count(*) into :n_reg from fases_garantias where id_cliente = :id_cliente;
if n_reg>0 then 
	mensaje += "El tercero est$$HEX2$$e1002000$$ENDHEX$$en las garantias"+cr
	fila2 = dw_opcion_a_comprobar.insertRow(0)
	dw_opcion_a_comprobar.SetItem(fila2, 'tabla', 'GARANTIAS')
	dw_opcion_a_comprobar.SetItem(fila2, 'cuantos', n_reg)
end if

//select count(*) into :n_reg from fases_depositos where id_cliente = :id_cliente;
//if n_reg>0 then 
//	mensaje += "El tercero est$$HEX2$$e1002000$$ENDHEX$$en los depositos"+cr
//	fila2 = dw_opcion_a_comprobar.insertRow(0)
//	dw_opcion_a_comprobar.SetItem(fila2, 'tabla', 'DEPOSITOS')
//	dw_opcion_a_comprobar.SetItem(fila2, 'cuantos', n_reg)
//end if

// COMPROBACIONES PARA FACTURAS
select count(*) into :n_reg from csi_facturas_emitidas where id_persona = :id_cliente and tipo_persona = 'P';
if n_reg>0 then 
	mensaje += "El tercero est$$HEX2$$e1002000$$ENDHEX$$en las facturas"+cr
	fila2 = dw_opcion_a_comprobar.insertRow(0)
	dw_opcion_a_comprobar.SetItem(fila2, 'tabla', 'FACTURAS')
	dw_opcion_a_comprobar.SetItem(fila2, 'cuantos', n_reg)
end if
	
select count(*) into :n_reg from csi_lineas_fact_emitidas where id_persona = :id_cliente;
if n_reg>0 then 
	mensaje += "El tercero est$$HEX2$$e1002000$$ENDHEX$$en las lineas de factura ?"+cr
	fila2 = dw_opcion_a_comprobar.insertRow(0)
	dw_opcion_a_comprobar.SetItem(fila2, 'tabla', 'LINEAS FACTURA')
	dw_opcion_a_comprobar.SetItem(fila2, 'cuantos', n_reg)
end if
	

// COMPROBACIONES PARA COLEGIADOS
select count(*) into :n_reg from colegiados where id_empresa = :id_cliente;
if n_reg>0 then 
	mensaje += "El tercero est$$HEX2$$e1002000$$ENDHEX$$las empresas de colegiados"+cr

	fila2 = dw_opcion_a_comprobar.insertRow(0)
	dw_opcion_a_comprobar.SetItem(fila2, 'tabla', 'COLEGIADOS')
	dw_opcion_a_comprobar.SetItem(fila2, 'cuantos', n_reg)
end if


st_1.visible = false

setpointer(arrow!)
end subroutine

on w_clientes_depuracion.create
int iCurrent
call super::create
this.cb_imprimir=create cb_imprimir
this.cb_actualizar=create cb_actualizar
this.cb_previsualizar_todos=create cb_previsualizar_todos
this.cb_previsualizar=create cb_previsualizar
this.cb_listar=create cb_listar
this.cb_borrar=create cb_borrar
this.dw_mostar_detalle=create dw_mostar_detalle
this.st_1=create st_1
this.cb_siguiente=create cb_siguiente
this.cb_anterior=create cb_anterior
this.dw_opcion_a_comprobar=create dw_opcion_a_comprobar
this.dw_clientes_detalle=create dw_clientes_detalle
this.dw_listado=create dw_listado
this.st_3=create st_3
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_imprimir
this.Control[iCurrent+2]=this.cb_actualizar
this.Control[iCurrent+3]=this.cb_previsualizar_todos
this.Control[iCurrent+4]=this.cb_previsualizar
this.Control[iCurrent+5]=this.cb_listar
this.Control[iCurrent+6]=this.cb_borrar
this.Control[iCurrent+7]=this.dw_mostar_detalle
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.cb_siguiente
this.Control[iCurrent+10]=this.cb_anterior
this.Control[iCurrent+11]=this.dw_opcion_a_comprobar
this.Control[iCurrent+12]=this.dw_clientes_detalle
this.Control[iCurrent+13]=this.dw_listado
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.st_2
end on

on w_clientes_depuracion.destroy
call super::destroy
destroy(this.cb_imprimir)
destroy(this.cb_actualizar)
destroy(this.cb_previsualizar_todos)
destroy(this.cb_previsualizar)
destroy(this.cb_listar)
destroy(this.cb_borrar)
destroy(this.dw_mostar_detalle)
destroy(this.st_1)
destroy(this.cb_siguiente)
destroy(this.cb_anterior)
destroy(this.dw_opcion_a_comprobar)
destroy(this.dw_clientes_detalle)
destroy(this.dw_listado)
destroy(this.st_3)
destroy(this.st_2)
end on

event open;call super::open;// Cambiamos el idioma de ventana
if g_usar_idioma ='S' then g_idioma.of_cambia_textos( this)
end event

type cb_imprimir from commandbutton within w_clientes_depuracion
string tag = "texto=general.imprimir_listado"
integer x = 2546
integer y = 2132
integer width = 512
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir Listado"
end type

event clicked;if dw_listado.visible = true then dw_listado.print()

end event

type cb_actualizar from commandbutton within w_clientes_depuracion
string tag = "texto=general.actualizar"
integer x = 512
integer y = 2132
integer width = 402
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Actualizar"
end type

event clicked;string id_cliente

id_cliente = dw_clientes_detalle.getitemstring(1, 'id_cliente')
parent.trigger event csd_refrescar_cliente(id_cliente)

end event

type cb_previsualizar_todos from commandbutton within w_clientes_depuracion
string tag = "texto=clientes.previsualizar_listado_clientes"
integer x = 1609
integer y = 2132
integer width = 846
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Previsualizar Listado &Todos Clientes"
end type

event clicked;// ESte proceso es lento

If messagebox(g_titulo, g_idioma.of_getmsg('msg_cliente.obtener_listado_coleg',"$$HEX1$$bf00$$ENDHEX$$Desea obtener un listado para todos los colegiados de la lista?") +cr+ g_idioma.of_getmsg('msg_cliente.proceso_lento',"Es un proceso lento"), question!, yesno!, 2)=2 then return
//If messagebox(g_titulo, "$$HEX1$$bf00$$ENDHEX$$Desea obtener un listado para todos los colegiados de la lista?"+cr+"Es un proceso lento", question!, yesno!, 2)=2 then return

ib_procesar_todos = true
ib_terminado = false
//nos vamos al primero
// Comprobamos que la ventana "lista previa" del m$$HEX1$$f300$$ENDHEX$$dulo est$$HEX2$$e1002000$$ENDHEX$$abierta
if not isvalid(g_dw_lista) then return
int fila_actual, la_fila
string id_cliente

la_fila = 1
g_dw_lista.SetRow(la_fila)
g_dw_lista.ScrollToRow(la_fila)
id_cliente = g_dw_lista.getitemstring(la_fila, 'clientes_id_cliente')
wf_refrescar_cliente ( id_cliente ) 

this.setredraw(false)
dw_listado.reset()
// PAra cada uno de ellos procesamos
DO UNTIL false
	wf_rellenar_listado()
	fila_actual = fila_actual + 1
	if ib_procesar_todos and fila_actual > g_dw_lista.RowCount() then 
		exit
	else
		g_dw_lista.SetRow(fila_actual)
		g_dw_lista.ScrollToRow(fila_actual)
		if not isvalid(g_dw_lista) then return
		id_cliente = g_dw_lista.getitemstring(fila_actual, 'clientes_id_cliente')
		wf_refrescar_cliente ( id_cliente) 
		st_3.text = "Fila = " + string(fila_actual)		 
	end if
LOOP
this.setredraw(true)
dw_listado.sort()
dw_listado.groupcalc()
dw_listado.visible = true
st_3.visible = false

end event

type cb_previsualizar from commandbutton within w_clientes_depuracion
string tag = "texto=general.previsualizar_listado"
integer x = 1006
integer y = 2132
integer width = 512
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Previsualizar &Listado"
end type

event clicked;dw_listado.reset()
wf_rellenar_listado()
if dw_listado.RowCount()>0 then dw_listado.visible = true

end event

type cb_listar from commandbutton within w_clientes_depuracion
string tag = "texto=general.listar_a_fichero"
integer x = 3145
integer y = 2132
integer width = 402
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Listar a &Fichero"
end type

event clicked;if dw_listado.visible = false then return
if dw_listado.RowCount()>0 then
	dw_listado.saveas()
end if
end event

type cb_borrar from commandbutton within w_clientes_depuracion
string tag = "texto=general.borrar"
integer x = 23
integer y = 2132
integer width = 402
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Borrar"
end type

event clicked;string id_cliente

id_cliente = dw_clientes_detalle.getitemString(dw_clientes_detalle.getRow(), 'id_cliente')
parent.trigger event csd_refrescar_cliente(id_cliente)

if dw_opcion_a_comprobar.RowCount()>0 then
	Messagebox(g_titulo, g_idioma.of_getmsg('msg_cliente.no_borrar_cliente', "Imposible borrar el cliente hasta que no exista ocurrencia alguna del mismo"), stopsign!)
	return
end if

// Borramos si no da errores
delete from clientes_terceros where id_cliente = :id_cliente;
delete from clientes where id_cliente = :id_cliente;
commit;

cb_siguiente.trigger event clicked()
end event

type dw_mostar_detalle from u_dw within w_clientes_depuracion
boolean visible = false
integer x = 23
integer y = 864
integer width = 3525
integer height = 1244
integer taborder = 50
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;CHOOSE CASE dwo.name
	CASE 'b_ver_contrato'
		// Abrimos la ventana de detalle
		// Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
		g_fases_consulta.id_fase = this.getitemstring(row,'id_fase')
		message.stringparm = "w_fases_detalle"
		SetPointer(Hourglass!)
		w_aplic_frame.postevent("csd_fasesdetalle")
		post close(parent)
	CASE 'b_ver_aviso'
		if row < 1 then return
		setpointer(hourglass!)

		long linea
		st_minutas_consulta minutas_consulta
		// Decimos la accion a realizar
		minutas_consulta.accion = 'CONSULTA'
		minutas_consulta.id_minuta = this.getitemstring(row, 'id_minuta')
		minutas_consulta.id_fase = this.getitemstring(row, 'id_fase')
		minutas_consulta.modulo = 'CAJA' // Para que puedan modificarlo
		
		// Abrimos la ventana pasandole la estructura que contiene el identificador
		openwithparm(w_minutas_detalle, minutas_consulta)
		// Recogemos el par$$HEX1$$e100$$ENDHEX$$metro de retorno de la ventana
		minutas_consulta = message.powerobjectparm
		if minutas_consulta.actualizado = 'S' then
			// Refrescamos
			parent.event csd_refrescar_cliente(dw_clientes_detalle.getitemstring(1,'id_cliente'))
		end if
	CASE 'b_ver_premaat'
		g_premaat_consulta.id_premaat = this.GetItemString(row, 'id_premaat')
		Message.StringParm = "w_premaat_detalle"
		w_aplic_frame.Post Event csd_premaat_detalle()
	CASE 'b_ver_factura'
		g_facturacion_emitida_consulta.id_factura = this.getitemstring(row,'id_factura')
		message.stringparm = "w_facturacion_emitida_detalle"
		w_aplic_frame.event csd_facturacion_emitida_detalle()
	CASE 'b_ver_lista'
		g_listas_consulta.id_lista = this.getitemstring(row,'id_lista')
		message.stringparm = "w_listas_detalle"
		w_aplic_frame.postevent("csd_listas_detalle")
	CASE 'b_ver_colegiado'
		g_colegiados_consulta.id_colegiado = this.GetItemString(row, 'id_colegiado')
		Message.StringParm = "w_colegiados_detalle"
		w_aplic_frame.Post Event csd_colegiadosdetalle()
END CHOOSE

end event

type st_1 from statictext within w_clientes_depuracion
string tag = "texto=clientes.recuperando_info"
integer x = 946
integer y = 24
integer width = 1486
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
string text = "RECUPERANDO INFORMACI$$HEX1$$d300$$ENDHEX$$N"
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;st_1.visible = false
end event

type cb_siguiente from commandbutton within w_clientes_depuracion
integer x = 2469
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;// Comprobamos que la ventana "lista previa" del m$$HEX1$$f300$$ENDHEX$$dulo est$$HEX2$$e1002000$$ENDHEX$$abierta
if not isvalid(g_dw_lista) then return
long fila_actual, la_fila

fila_actual = g_dw_lista.GetRow()

if fila_actual >= g_dw_lista.RowCount() and not ib_procesar_todos  then
	MessageBox(g_titulo,g_idioma.of_getmsg('msg_cliente.filas_posteriores', "No hay filas posteriores a esta"))
	return
end if
if ib_procesar_todos and fila_actual >= g_dw_lista.RowCount() then ib_terminado = true

la_fila = fila_actual + 1

g_dw_lista.SetRow(la_fila)
g_dw_lista.ScrollToRow(la_fila)

if not isvalid(g_dw_lista) then return
string id_cliente
if g_dw_lista.rowcount() > 0 then
	id_cliente = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'clientes_id_cliente')
	parent.trigger event csd_refrescar_cliente(id_cliente)
end if

dw_listado.visible = false
end event

type cb_anterior from commandbutton within w_clientes_depuracion
integer x = 430
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<"
end type

event clicked;// Comprobamos que la ventana "lista previa" del m$$HEX1$$f300$$ENDHEX$$dulo est$$HEX2$$e1002000$$ENDHEX$$abierta
if not isvalid(g_dw_lista) then return
long fila_actual, la_fila

fila_actual = g_dw_lista.GetRow()

if fila_actual <= 1 then
	MessageBox(g_titulo,g_idioma.of_getmsg('msg_cliente.filas_anteriores', "No hay filas anteriores a esta"))
	return
end if

la_fila = fila_actual - 1

g_dw_lista.SetRow(la_fila)
g_dw_lista.ScrollToRow(la_fila)

if not isvalid(g_dw_lista) then return
string id_cliente
if g_dw_lista.rowcount() > 0 then
	id_cliente = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'clientes_id_cliente')
	parent.trigger event csd_refrescar_cliente(id_cliente)
end if

dw_listado.visible = false
end event

type dw_opcion_a_comprobar from datawindow within w_clientes_depuracion
integer x = 23
integer y = 504
integer width = 3529
integer height = 344
integer taborder = 40
string title = "none"
string dataobject = "d_clientes_depuracion_problemas"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event doubleclicked;string tabla, id_cliente

if row <= 0 or row > this.rowCount() then return


tabla = this.getitemstring(row, 'tabla')
id_cliente = dw_clientes_detalle.GetItemString(dw_clientes_detalle.getRow(), 'id_cliente')

dw_mostar_detalle.visible = false
CHOOSE CASE tabla
	CASE 'PREMAAT'
		// No deberia de salir nunca
		Messagebox(g_titulo, g_idioma.of_getmsg('msg_cliente.proveedor_cliente_premaat', "Informen al proveedor que existe el cliente en la ficha de premaat cabecera"))
		return
	CASE 'PREMAAT_BENEFICIARIO'
		dw_mostar_detalle.dataobject = 'd_clientes_depuracion_premaat_benef'
	CASE 'PREMAAT_LIQUIDACIONES'
		dw_mostar_detalle.dataobject = 'd_clientes_depuracion_premaat_liquid'
	CASE 'PRESTACIONES'
		dw_mostar_detalle.dataobject = 'd_clientes_depuracion_premaat_prestaci'
	CASE 'LISTAS'
		dw_mostar_detalle.dataobject = 'd_clientes_depuracion_listas_detalle'
	CASE 'MINUTAS'
		dw_mostar_detalle.dataobject = 'd_clientes_depuracion_fases_minutas'
	CASE 'GARANTIAS'
		dw_mostar_detalle.dataobject = 'd_clientes_depuracion_garantias_lista'
//	CASE 'DEPOSITOS'
//		dw_mostar_detalle.dataobject = 'd_temporal_fases_depositos_depuracion'
	CASE 'FACTURAS'
		dw_mostar_detalle.dataobject = 'd_clientes_depuracion_fact_emitida_lista'
	CASE 'LINEAS FACTURA'
		// No deberia de salir nunca
		Messagebox(g_titulo, g_idioma.of_getmsg('msg_cliente.proveedor_cliente_factura', "Informen al proveedor que existe el cliente en la ficha de lineas de factura"))
		return
	CASE 'COLEGIADOS'
		dw_mostar_detalle.dataobject = 'd_clientes_depuracion_colegiado_empresas'
	CASE 'CONTRATOS'
		dw_mostar_detalle.dataobject = 'd_clientes_depuracion_lista_promot_contr'
	CASE ELSE
		return
END CHOOSE

dw_mostar_detalle.settransobject (SQLCA)
if dw_mostar_detalle.retrieve (id_cliente)>0 then
	dw_mostar_detalle.visible = true
end if
end event

type dw_clientes_detalle from u_dw within w_clientes_depuracion
integer x = 23
integer y = 128
integer width = 3529
integer height = 364
integer taborder = 30
string dataobject = "d_clientes_depuracion"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_listado from u_dw within w_clientes_depuracion
boolean visible = false
integer x = 23
integer y = 504
integer width = 3529
integer height = 1608
integer taborder = 60
string dataobject = "d_clientes_listado_depuracion"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.visible = false
end event

event doubleclicked;call super::doubleclicked;this.visible = false
end event

type st_3 from statictext within w_clientes_depuracion
integer x = 2944
integer y = 8
integer width = 571
integer height = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_clientes_depuracion
string tag = "texto=clientes.cambios_ventana_no_grabar"
integer x = 946
integer y = 24
integer width = 1486
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Los cambios realizados en esta ventana no se grabar$$HEX1$$e100$$ENDHEX$$n"
boolean focusrectangle = false
end type

