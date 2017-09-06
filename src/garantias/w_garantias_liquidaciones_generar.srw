HA$PBExportHeader$w_garantias_liquidaciones_generar.srw
forward
global type w_garantias_liquidaciones_generar from w_response
end type
type dw_1 from u_dw within w_garantias_liquidaciones_generar
end type
type cb_cancelar from commandbutton within w_garantias_liquidaciones_generar
end type
type cb_aceptar from commandbutton within w_garantias_liquidaciones_generar
end type
type dw_liquid from u_dw within w_garantias_liquidaciones_generar
end type
end forward

global type w_garantias_liquidaciones_generar from w_response
integer width = 2903
integer height = 1204
string title = "Otros Pagos"
dw_1 dw_1
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
dw_liquid dw_liquid
end type
global w_garantias_liquidaciones_generar w_garantias_liquidaciones_generar

type variables
string i_id_liq, i_campo_anterior
st_cobros_datos_remesa i_datos_remesa


end variables

forward prototypes
public subroutine wf_generar_liquidacion ()
end prototypes

public subroutine wf_generar_liquidacion ();datetime f_nula, f_liquidacion, f_entrada
string dest, id_col, id_cli, id_factura, centro
double total, total_factura

setnull(f_nula)

dest = dw_1.getitemstring(1,'destinatario')
id_col = dw_1.getitemstring(1,'id_colegiado')
id_cli = dw_1.getitemstring(1,'id_cliente')
id_factura = dw_1.getitemstring(1,'id_factura')
total = dw_1.getitemnumber(1,'importe')
f_liquidacion = dw_1.getitemdatetime(1,'f_liquidacion')
f_entrada = dw_1.getitemdatetime(1,'f_entrada')
centro = dw_1.getitemstring(1,'centro')

dw_liquid.InsertRow(0)

i_id_liq = f_siguiente_numero('LIQUIDACIONES',10)
dw_liquid.SetItem(1,'id_liquidacion',i_id_liq)
dw_liquid.SetItem(1,'f_liquidacion',f_liquidacion)
dw_liquid.SetItem(1,'f_entrada',f_entrada)
dw_liquid.SetItem(1,'estado','P')
dw_liquid.SetItem(1,'contabilizada','N')
dw_liquid.SetItem(1,'forma_pago',dw_1.getitemstring(1,'forma_pago'))
dw_liquid.SetItem(1,'importe',total)
dw_liquid.SetItem(1,'n_documento','')
choose case dest
	case 'CO'
		dw_liquid.SetItem(1,'id_colegiado',id_col)
		dw_liquid.SetItem(1,'nombre',f_colegiado_apellido(id_col))
		dw_liquid.SetItem(1,'banco',gnv_control_cuentas_bancarias.of_obtener_iban_nombre_modulo ('COL_REMESABLE',id_col) )
	case 'CL'
		dw_liquid.SetItem(1,'id_beneficiario',id_cli)
		dw_liquid.SetItem(1,'nombre',f_dame_cliente(id_cli))
		dw_liquid.SetItem(1,'banco',gnv_control_cuentas_bancarias.of_obtener_iban_nombre_modulo ('CLIENTES',id_cli) )
	case 'OT'
		dw_liquid.SetItem(1,'nombre',dw_1.getitemstring(1,'nombre_otro'))
		dw_liquid.SetItem(1,'contrapartida',dw_1.getitemstring(1,'contrapartida'))
end choose
dw_liquid.SetItem(1,'cta_pago','')
dw_liquid.SetItem(1,'descripcion_larga',dw_1.getitemstring(1,'descripcion'))
// El campo tipo de liquidaci$$HEX1$$f300$$ENDHEX$$n diferencia entre: 1-Premaat, 2-Garant$$HEX1$$ed00$$ENDHEX$$as, 3-Otros.
dw_liquid.SetItem(1,'tipo','3')
dw_liquid.SetItem(1,'id_fase','')
dw_liquid.SetItem(1,'id_factura',id_factura)
dw_liquid.SetItem(1,'centro',centro)
dw_liquid.SetItem(1,'mensual',dw_1.getitemstring(1,'mensual'))
dw_liquid.SetItem(1,'cod_usuario', g_usuario)
dw_liquid.SetItem(1,'empresa',g_empresa) // se inserta el valor de la empresa del usuario que entr$$HEX2$$f3002000$$ENDHEX$$en la aplicaci$$HEX1$$f300$$ENDHEX$$n

// Modificado por Ricardo 04-05-10

if dw_liquid.Update()<>1 then
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

end subroutine

on w_garantias_liquidaciones_generar.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.dw_liquid=create dw_liquid
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.cb_aceptar
this.Control[iCurrent+4]=this.dw_liquid
end on

on w_garantias_liquidaciones_generar.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.dw_liquid)
end on

event open;string id_factura_desde_devolucion

f_centrar_ventana(this)

//Obtenemos el id factura desde la ventana de devolucion de factura
id_factura_desde_devolucion = message.stringparm

dw_1.InsertRow(0)

if not isnull(id_factura_desde_devolucion) and id_factura_desde_devolucion<>'' then
	dw_1.event csd_rellenar_datos_factura(id_factura_desde_devolucion)	
end if


dw_1.setitem(1,'f_entrada',datetime(today()))
dw_1.setitem(1,'centro',g_centro_por_defecto)


end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_garantias_liquidaciones_generar
integer x = 622
integer y = 1180
integer taborder = 30
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_garantias_liquidaciones_generar
integer x = 1106
integer y = 1180
end type

type dw_1 from u_dw within w_garantias_liquidaciones_generar
event csd_rellenar_datos_factura ( string id_factura )
event csd_transf_format_cuenta ( string nombre_columna,  long fila )
event csd_calendario ( )
integer x = 37
integer y = 32
integer width = 2843
integer height = 820
integer taborder = 20
string dataobject = "d_garantias_liquidacion_generar"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_rellenar_datos_factura(string id_factura);// Evento creado por RICARDO 04-05-11
// Simplemente si la factura cumple una serie de condiciones (no estar pagada ni tener cobros contabilizados)
// se rellena todos los datos

string n_factura, tipo_persona, id_persona, asunto, formadepago, pagado, centro
double total
datetime fecha
int n_reg

if not f_es_Vacio(id_factura) then
	//Si la factura tiene cobros contabilizados con otra forma de pago, no puede usarse el matado con liquidacion
	select count(*) into :n_reg from csi_cobros where contabilizado = 'S' and id_factura = :id_factura;
	if n_reg>0 then
		// Ya tiene alg$$HEX1$$fa00$$ENDHEX$$n cobro contabilizado por lo que no es posible tocar los cobros
		messagebox(g_titulo, "Esta factura tiene cobros contabilizados ya, por lo que no es posible casarla con una liquidaci$$HEX1$$f300$$ENDHEX$$n")
		dw_1.setitem(1, 'n_factura','')
		return
	end if
	
	SELECT n_fact, tipo_persona, id_persona, total, fecha, asunto, formadepago, pagado, centro
	into :n_factura, :tipo_persona, :id_persona, :total, :fecha, :asunto, :formadepago, :pagado, :centro from csi_facturas_emitidas where id_factura = :id_factura;
	
	if pagado = 'S' then
		// La factura est$$HEX2$$e1002000$$ENDHEX$$ya pagada por lo que no es posible elegir esa factura
		Messagebox(g_titulo, "La factura ya est$$HEX2$$e1002000$$ENDHEX$$marcada como pagada", stopsign!)
		dw_1.setitem(1, 'n_factura','')
		return
	end if
	if formadepago <> 'LI' then 
		Messagebox(g_titulo, "La factura no tiene la forma de pago de incluida en liquidaci$$HEX1$$f300$$ENDHEX$$n", stopsign!)
		return
	end if
	if total>0 then
		Messagebox(g_titulo, "La factura no tiene importe negativo", stopsign!)
		return
	end if
	
	// Colocamos los valores 
	dw_1.setitem(1, 'id_factura', id_factura)
	dw_1.setitem(1, 'n_factura', n_factura)
	dw_1.setitem(1, 'f_liquidacion', fecha)
	dw_1.setitem(1, 'importe', - total) // MODIFICADO RICARDO 04-06-28 El importe de la liquidacion debe ser el inverso al de la factura
	if tipo_persona = 'P' then
		dw_1.setitem(1, 'id_cliente', id_persona)
		dw_1.setitem(1, 'destinatario', 'CL')
	else
		dw_1.setitem(1, 'id_colegiado', id_persona)
		dw_1.setitem(1, 'destinatario', 'CO')
	end if
	// Si era talon lo cambiamos... por el resto no se toca
	if formadepago = 'TA' then dw_1.setitem(1, 'forma_pago', formadepago)
	
	// Ponemos en la descripcion que es el pago de otra factura
	dw_1.setitem(1, 'descripcion', "Pago factura "+n_factura)
	dw_1.setitem(1, 'centro', centro)
else
	dw_1.setitem(1, 'n_factura','')
end if

end event

event csd_transf_format_cuenta(string nombre_columna, long fila);// Para los campos llamados cuenta permitimos un formato de entrada 
// tipo 43.1 que lo convierte en formato valido de g_num_digitos
string ret, tipo

tipo=this.Describe(nombre_columna+".ColType")
CHOOSE CASE upper(LeftA(tipo ,2))
	CASE 'CH' 
		if nombre_columna = 'contrapartida' then
			ret=f_convertir_cuenta_abrev(this,fila,nombre_columna)
			if ret<>'' then
				this.setitem(fila, 'contrapartida', ret)
			end if
		end if
END CHOOSE

end event

event csd_calendario();this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event buttonclicked;call super::buttonclicked;string id_factura, tipo_persona, id_persona, asunto, formadepago, n_factura
double total
datetime fecha

CHOOSE CASE dwo.name
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
	
	CASE 'b_seleccionar_factura'
		/*
		open(w_busqueda_facturacion_emitida)
		id_factura = message.stringparm
		this.trigger event csd_rellenar_datos_factura(id_factura)
		*/
		
	CASE 'b_borrar_factura'
		dw_1.setitem(1, 'id_factura', '')
		dw_1.setitem(1, 'n_factura', '')
END CHOOSE

end event

event itemchanged;call super::itemchanged;string id_factura, id_col

CHOOSE CASE dwo.name
	CASE 'n_factura'
		// Permitimos que al colocar un numero de factura rellene el resto de datos
		// Cuando coloquen el id de la factura, rellenamos o vaciamos al menos el id
		if not f_es_vacio(data) then
			// Averiguamos el id_factura a partir del numero de la misma
			SELECT csi_facturas_emitidas.id_factura INTO :id_factura FROM csi_facturas_emitidas  WHERE csi_facturas_emitidas.n_fact = :data and empresa=:g_empresa;			
			this.post event csd_rellenar_datos_factura(id_factura)
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

event itemfocuschanged;call super::itemfocuschanged;// Paso como parametro el campo anterior que ten$$HEX1$$ed00$$ENDHEX$$a el foco 
if f_es_vacio(i_campo_anterior) then i_campo_anterior  = dwo.name
this.event csd_transf_format_cuenta(i_campo_anterior,row)

// Actualizo la vble. que lleva el control de cual era el campo anterior
i_campo_anterior = dwo.name

end event

event constructor;call super::constructor;post event csd_calendario()
end event

type cb_cancelar from commandbutton within w_garantias_liquidaciones_generar
integer x = 1527
integer y = 944
integer width = 507
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;Close(parent)




end event

type cb_aceptar from commandbutton within w_garantias_liquidaciones_generar
integer x = 695
integer y = 944
integer width = 507
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Generar Liquidaci$$HEX1$$f300$$ENDHEX$$n"
boolean default = true
end type

event clicked;string mensaje, mensaje_cuenta

dw_1.trigger event pfc_accepttext(true)

if f_es_vacio(dw_1.getitemstring(1,'descripcion')) then mensaje += 'Debe introducir la Descripci$$HEX1$$f300$$ENDHEX$$n.' + cr
if f_es_vacio(dw_1.getitemstring(1,'nombre')) and dw_1.getitemstring(1,'destinatario')<>'OT' then mensaje += 'Debe introducir el Destinatario.' + cr
if f_es_vacio(dw_1.getitemstring(1,'nombre_otro')) and dw_1.getitemstring(1,'destinatario')='OT' then mensaje += 'Debe introducir el Destinatario.' + cr
//if isnull(dw_1.getitemdatetime(1,'f_liquidacion')) then mensaje += 'Debe introducir la Fecha de Liquidaci$$HEX1$$f300$$ENDHEX$$n.' + cr
if isnull(dw_1.getitemdatetime(1,'f_entrada')) then mensaje += 'Debe introducir la Fecha de Entrada.' + cr
//if f_es_vacio(string(dw_1.getitemnumber(1,'importe'))) then mensaje += 'Debe introducir el Importe.' + cr
if f_es_vacio(string(dw_1.getitemnumber(1,'importe'))) then
        mensaje += 'Debe introducir el Importe.' + cr
elseif dw_1.getitemnumber(1,'importe') = 0 then 
        mensaje += 'El importe no puede ser cero.' + cr
end if

// Se valida la cuenta de contrapartida de "otro"
if dw_1.getitemstring(1,'destinatario')='OT' then mensaje_cuenta += f_validar_cuenta_mensaje(dw_1.getitemstring(1,'contrapartida'), 1,'')
if not f_es_vacio(mensaje_cuenta) then	mensaje += mensaje_cuenta



if mensaje <> '' then
	messagebox(g_titulo, mensaje, stopsign!)
	return
end if

wf_generar_liquidacion()

messagebox(g_titulo, 'Proceso finalizado.')

Close(parent)

end event

type dw_liquid from u_dw within w_garantias_liquidaciones_generar
boolean visible = false
integer x = 2386
integer y = 400
integer width = 233
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_premaat_liquid_lista"
end type

