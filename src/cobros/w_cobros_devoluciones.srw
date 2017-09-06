HA$PBExportHeader$w_cobros_devoluciones.srw
forward
global type w_cobros_devoluciones from w_sheet
end type
type tab_1 from tab within w_cobros_devoluciones
end type
type tabpage_1 from userobject within tab_1
end type
type cb_imprimir_facturas from commandbutton within tabpage_1
end type
type dw_apuntes from u_dw within tabpage_1
end type
type dw_facturas from u_dw within tabpage_1
end type
type cb_imprimir_apuntes from commandbutton within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_imprimir_facturas cb_imprimir_facturas
dw_apuntes dw_apuntes
dw_facturas dw_facturas
cb_imprimir_apuntes cb_imprimir_apuntes
end type
type tabpage_2 from userobject within tab_1
end type
type dw_colegiados_factura_1_n from u_dw within tabpage_2
end type
type dw_colegiados_datos_factura from u_dw within tabpage_2
end type
type cb_imprimir_facturas_2 from commandbutton within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_colegiados_factura_1_n dw_colegiados_factura_1_n
dw_colegiados_datos_factura dw_colegiados_datos_factura
cb_imprimir_facturas_2 cb_imprimir_facturas_2
end type
type tabpage_3 from userobject within tab_1
end type
type cb_imprimir_incidencias from commandbutton within tabpage_3
end type
type dw_incidencias from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cb_imprimir_incidencias cb_imprimir_incidencias
dw_incidencias dw_incidencias
end type
type tab_1 from tab within w_cobros_devoluciones
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type cb_desmarcar from commandbutton within w_cobros_devoluciones
end type
type dw_cobros from u_dw within w_cobros_devoluciones
end type
type cb_grabar from commandbutton within w_cobros_devoluciones
end type
type cb_devolver from commandbutton within w_cobros_devoluciones
end type
type cb_marcar_todos from commandbutton within w_cobros_devoluciones
end type
type cb_fichero2 from commandbutton within w_cobros_devoluciones
end type
type dw_busqueda from u_dw within w_cobros_devoluciones
end type
type dw_carta_devolucion from u_dw within w_cobros_devoluciones
end type
end forward

global type w_cobros_devoluciones from w_sheet
integer x = 214
integer y = 221
integer width = 3506
integer height = 2436
string title = "Devoluciones"
string menuname = "m_cobros_devoluciones"
windowstate windowstate = maximized!
event type integer csd_comprobacion_parametros_contabilidad ( )
tab_1 tab_1
cb_desmarcar cb_desmarcar
dw_cobros dw_cobros
cb_grabar cb_grabar
cb_devolver cb_devolver
cb_marcar_todos cb_marcar_todos
cb_fichero2 cb_fichero2
dw_busqueda dw_busqueda
dw_carta_devolucion dw_carta_devolucion
end type
global w_cobros_devoluciones w_cobros_devoluciones

type variables
string is_consulta_aplicada = ''
long i_asiento
//Variables instancia para los datawindows
u_dw idw_apuntes,idw_facturas,idw_incidencias
u_dw idw_colegiados_datos_factura,idw_colegiados_factura_1_n
integer num_copias_dev


end variables

forward prototypes
public function string wf_crear_factura_devolucion (string id_factura, string tipo_persona, string id_persona, ref datastore ds_lineas)
public function string wf_comprobar_facturas_devolucion ()
public function string f_motivo_devolucion (string codigo)
public subroutine wf_imprimir_carta (string id_factura)
end prototypes

event type integer csd_comprobacion_parametros_contabilidad();string mensaje
int retorno=1,cuantos

/****************************************************************************
				Validaciones sobre variables globales. 
				LA verdad es que tengo miedo de poner esto as$$HEX1$$ed00$$ENDHEX$$, pero dios dir$$HEX1$$e100$$ENDHEX$$
****************************************************************************/
if isnull(g_num_digitos) or g_num_digitos > 10 or g_num_digitos < 6 then mensaje = mensaje + cr + "g_num_digitos"
if f_es_vacio(g_conta.cuenta_clientes_general) then mensaje = mensaje + cr + "g_conta.cuenta_clientes_general"
if f_es_vacio(g_prefijo_arqui) then mensaje = mensaje + cr + "g_prefijo_arqui"
if f_es_vacio(g_sica_diario.devoluciones) then mensaje = mensaje + cr + "g_sica_diario.devoluciones"
if f_es_vacio(g_t_asiento_apuntes_automaticos) then mensaje = mensaje + cr + "g_t_asiento_apuntes_automaticos"
if f_es_vacio(g_sica_t_doc.transferencia) then mensaje = mensaje + cr + "g_sica_t_doc.transferencia"
if f_es_vacio(g_sica_t_doc.talon) then mensaje = mensaje + cr + "g_sica_t_doc.talon"
if f_es_vacio(g_sica_t_doc.generico) then mensaje = mensaje + cr + "g_sica_t_doc.generico"
if f_es_vacio(g_centro_por_defecto) then mensaje = mensaje + cr + "g_centro_por_defecto"
if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
if f_es_vacio(g_explotacion_por_defecto) then mensaje = mensaje + cr + "g_explotacion_por_defecto"
if f_es_vacio(g_conta.cuenta_clientes_general) then mensaje = mensaje + cr + "g_conta.cuenta_clientes_general"
if f_es_vacio(g_prefijo_arqui) then mensaje = mensaje + cr + "g_prefijo_arqui"
select count(*) into :cuantos from csi_bancos where cuenta_contable = null or cuenta_contable = '';
if cuantos > 0 then Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.cuenta_indefinida',"Hay bancos sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso."),Stopsign!)
if mensaje <> '' then
	mensaje = g_idioma.of_getmsg('msg_cobros.definir_variables','Hay que definir las siguientes variables para poder contabilizar:') + cr + mensaje
	messagebox(g_titulo,mensaje,Stopsign!)
	Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.valores_defecto','De momento les pondremos valores por defecto, pero no se debe poner en marcha si se lee este mensaje!!!'),Stopsign!)
	retorno = Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.desea_continuar','$$HEX2$$bf002000$$ENDHEX$$Desea Continuar ? '),Question!, YesNo!) 
end if
	
return retorno
end event

public function string wf_crear_factura_devolucion (string id_factura, string tipo_persona, string id_persona, ref datastore ds_lineas);string id_factura_new
st_facturas datos_facturacion

// Colocamos la estructura para hacer la factura
datos_facturacion.formapago		= idw_colegiados_datos_factura.GetItemString(1,'formapago')
datos_facturacion.banco 			= idw_colegiados_datos_factura.GetItemString(1,'banco')
datos_facturacion.serie				= idw_colegiados_datos_factura.GetItemString(1,'serie')
datos_facturacion.fecha				= idw_colegiados_datos_factura.GetItemDateTime(1,'fecha')
datos_facturacion.fecha_factura	= idw_colegiados_datos_factura.GetItemDateTime(1,'fecha')
datos_facturacion.num_originales	= idw_colegiados_datos_factura.GetItemNumber(1,'n_originales')
datos_facturacion.num_copias		= idw_colegiados_datos_factura.GetItemNumber(1,'n_copias')
datos_facturacion.incluir_todos	= idw_colegiados_datos_factura.GetItemString(1,'incluir_todos')
datos_facturacion.asunto 			= 'GASTOS DEV. ' + f_dame_n_fact_de_id(id_factura)
datos_facturacion.obs 				= 'GASTOS DEV. ' + f_dame_n_fact_de_id(id_factura)
datos_facturacion.centro			= idw_colegiados_datos_factura.GetItemString(1,'centro')
datos_facturacion.proyecto			= idw_colegiados_datos_factura.GetItemString(1,'proyecto')
datos_facturacion.pagada			= idw_colegiados_datos_factura.GetItemString(1,'pagada')
datos_facturacion.tipo_factura	= g_colegio_colegiado
datos_facturacion.anulada			= 'N'
datos_facturacion.es_colegiado	= true
datos_facturacion.ds_lineas	= ds_lineas
datos_facturacion.id_receptor 		= id_persona


// Si son facturas a clientes cambiamos los datos de facturaci$$HEX1$$f300$$ENDHEX$$n
if tipo_persona = 'P' then
	datos_facturacion.tipo_factura	= g_colegio_cliente
	datos_facturacion.es_colegiado	= false
end if
// Generamos la factura
id_factura_new = f_factura(datos_facturacion)

return id_factura_new
end function

public function string wf_comprobar_facturas_devolucion ();// CREADA RICARDO 2005-03-15
// FUNCION QUE SE ENCARGA DE COMPROBAR SI TODO EST$$HEX2$$c1002000$$ENDHEX$$CORRECTO PARA LA GENERACI$$HEX1$$d300$$ENDHEX$$N DE LAS FACTURAS DE DEVOLUCION

string mensaje = ''
long i

// Aceptamos cualquier cambio realizado.
idw_colegiados_datos_factura.trigger event pfc_accepttext(true)
idw_colegiados_factura_1_n.trigger event pfc_accepttext(true)


if f_es_vacio(idw_colegiados_datos_factura.GetItemString(1,'serie')) then mensaje +='~tDebe especificar una serie para las facturas.'+cr
if isnull(idw_colegiados_datos_factura.GetItemDatetime(1,'fecha')) then mensaje +='~tDebe especificar la fecha para las facturas.'+cr
if f_es_vacio(idw_colegiados_datos_factura.GetItemString(1,'asunto')) then mensaje +='~tDebe especificar el asunto para las facturas.'+cr
if f_es_vacio(idw_colegiados_datos_factura.GetItemString(1,'centro')) then mensaje +='~tDebe especificar el centro para las facturas.'+cr
if idw_colegiados_datos_factura.GetItemString(1,'incluir_todos')='N' and f_es_vacio(idw_colegiados_datos_factura.GetItemString(1,'formapago_mensual')) then
	mensaje += '~tDebe especificar la forma de pago de las facturas que se van a emitir'+cr
end if

string formapago, banco
long n_reg
if idw_colegiados_datos_factura.GetItemString(1,'incluir_todos')='S' then
	formapago		= idw_colegiados_datos_factura.GetItemString(1,'formapago')
else
	formapago		= idw_colegiados_datos_factura.GetItemString(1,'formapago_mensual')
end if


// POR ORDEN DE PACO, ESTO NO DEBE SER OBLIGATORIO... :(
		// Con domiciliacion bancaria no se permite pagar a no
		//if formapago = 'DB' and dw_2.GetItemString(1,'pagada') = 'N' then mensaje += "Con domiciliaci$$HEX1$$f300$$ENDHEX$$n bancaria deben marcase las facturas como pagadas"
// Por este mismo criterio, hay que ponerlo si el pagado es a 'S', tanto la Forma de pago, como el banco (este ultimo comprogar si existe en la bbdd)
if idw_colegiados_datos_factura.GetItemString(1,'pagada') = 'S' then 
	banco = idw_colegiados_datos_factura.GetItemString(1,'banco')
	if f_es_vacio(banco) then 
		mensaje +='~tDebe especificar el banco para las facturas.'+cr
	else
		// Miramos si dicho banco est$$HEX2$$e1002000$$ENDHEX$$en la bbdd almacenado
		select count(*) into :n_reg from csi_bancos where codigo = :banco;
		if n_reg = 0 then
			// No existe el banco, por lo que no dejamos continuar
			mensaje =+ '~tDebe seleccionar el banco de entre los existentes.'+cr
		end if
	end if
end if

if idw_colegiados_datos_factura.GetItemString(1,'incluir_todos')='S' and f_es_vacio(idw_colegiados_datos_factura.GetItemString(1,'formapago')) then
	mensaje += '~tDebe especificar la forma de pago de las facturas que se van a emitir'+cr
end if
if idw_colegiados_factura_1_n.RowCount() = 0 then mensaje +='~tDebe especificar al menos un concepto para las facturas.'+cr
for i= 1 to idw_colegiados_factura_1_n.RowCount()
	if f_es_vacio(idw_colegiados_factura_1_n.GetItemString(i,'articulo')) then mensaje +='~tDebe especificar un valor para el Concepto.'+'  (linea '+string(i)+')'+cr
	if f_es_vacio(idw_colegiados_factura_1_n.GetItemString(i,'t_iva')) then mensaje +='~tDebe especificar un valor para el Tipo de Impuestos.'+'  (linea '+string(i)+')'+cr
	if isnull(idw_colegiados_factura_1_n.GetItemNumber(i,'total')) then mensaje +='~tDebe especificar un valor para el Total de la l$$HEX1$$ed00$$ENDHEX$$nea.'+'  (linea '+string(i)+')'+cr
	if isnull(idw_colegiados_factura_1_n.GetItemNumber(i,'subtotal')) then mensaje +='~tDebe especificar un valor para el Importe.'+'  (linea '+string(i)+')'+cr
next


if LenA(mensaje)>0 then mensaje = cr+cr+'Para las facturas de devoluci$$HEX1$$f300$$ENDHEX$$n falta configurar:'+cr+cr+mensaje


return mensaje
end function

public function string f_motivo_devolucion (string codigo);// Modificado ricardo 04-06-30
string retorno ='INDETERMINADO'

//C$$HEX1$$f300$$ENDHEX$$digos de Devoluciones de Ordenes de Adeudo
select descripcion into :retorno from devoluciones_motivos where codigo = :codigo;
if f_es_vacio(retorno) then retorno = 'INDETERMINADO'

/*
choose case codigo
        case '1'

                retorno = 'Incorriente'
        case '2'
                retorno = 'NO Domiciliado'
        case '3'
                retorno = 'Oficina Inexistente'
        case '4'
                retorno = 'NIF del deudor Desconocido'
        case '5'
                retorno = 'Por orden del cliente: error en la domiciliacion'
        case '6'
                retorno = 'Por orden del cliente: disconformidad con el importe'
        case '7'
                retorno = 'Adeudo duplicado, indebido, err$$HEX1$$f300$$ENDHEX$$neo o faltan datos'
end choose
*/

return retorno   

end function

public subroutine wf_imprimir_carta (string id_factura);// Permite imprimir una carta de reclamacion para cada recibo devuelto

//Para La Rioja se ha modificado la carta. Alexis 1/09/2009
integer i
f_logo_empresa(g_empresa ,dw_carta_devolucion, '009')
dw_carta_devolucion.retrieve(id_factura)
num_copias_dev =dw_busqueda.getitemnumber( 1, 'num_copias_carta_dev')
if dw_carta_devolucion.rowcount()>0 then
	FOR i = 1 to num_copias_dev
		dw_carta_devolucion.print()
	NEXT
end if	
end subroutine

on w_cobros_devoluciones.create
int iCurrent
call super::create
if this.MenuName = "m_cobros_devoluciones" then this.MenuID = create m_cobros_devoluciones
this.tab_1=create tab_1
this.cb_desmarcar=create cb_desmarcar
this.dw_cobros=create dw_cobros
this.cb_grabar=create cb_grabar
this.cb_devolver=create cb_devolver
this.cb_marcar_todos=create cb_marcar_todos
this.cb_fichero2=create cb_fichero2
this.dw_busqueda=create dw_busqueda
this.dw_carta_devolucion=create dw_carta_devolucion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_desmarcar
this.Control[iCurrent+3]=this.dw_cobros
this.Control[iCurrent+4]=this.cb_grabar
this.Control[iCurrent+5]=this.cb_devolver
this.Control[iCurrent+6]=this.cb_marcar_todos
this.Control[iCurrent+7]=this.cb_fichero2
this.Control[iCurrent+8]=this.dw_busqueda
this.Control[iCurrent+9]=this.dw_carta_devolucion
end on

on w_cobros_devoluciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.cb_desmarcar)
destroy(this.dw_cobros)
destroy(this.cb_grabar)
destroy(this.cb_devolver)
destroy(this.cb_marcar_todos)
destroy(this.cb_fichero2)
destroy(this.dw_busqueda)
destroy(this.dw_carta_devolucion)
end on

event activate;call super::activate;g_w_lista   = g_lista_devoluciones


end event

event type integer pfc_save();//SOBREESCRITO...

if cb_grabar.enabled then cb_grabar.TriggerEvent(Clicked!) else return -1
return 1
end event

event open;call super::open;// Indicamos que queremos cambiar el idioma
if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)

//
idw_facturas=tab_1.tabpage_1.dw_facturas
idw_apuntes=tab_1.tabpage_1.dw_apuntes
idw_colegiados_datos_factura=tab_1.tabpage_2.dw_colegiados_datos_factura
idw_colegiados_factura_1_n=tab_1.tabpage_2.dw_colegiados_factura_1_n
idw_incidencias=tab_1.tabpage_3.dw_incidencias

of_SetResize (true)
inv_resize.of_Register (dw_busqueda, "ScaletoRight")// Modificado Ricardo 2005-03-15
inv_resize.of_Register (idw_facturas, "ScaletoRight")
inv_resize.of_Register (idw_incidencias, "ScaletoRight")
inv_resize.of_Register (idw_apuntes, "ScaletoRight&Bottom")
inv_resize.of_Register (cb_devolver, "FixedtoRight")
inv_resize.of_Register (cb_grabar, "FixedtoRight")
inv_resize.of_Register (tab_1.tabpage_1.cb_imprimir_apuntes, "FixedtoRight")
inv_resize.of_Register (idw_colegiados_datos_factura, "ScaletoRight")// Modificado Ricardo 2005-03-15
inv_resize.of_Register (idw_colegiados_factura_1_n, "ScaletoRight&Bottom")// Modificado Ricardo 2005-03-15
//
inv_resize.of_register (tab_1, "scaletoright&bottom")

// Ponemos la posible carta de reclamacion
dw_carta_devolucion.dataobject = g_devoluciones_carta_reclamacion
dw_carta_devolucion.settransobject(SQLCA)

// Modificado Ricardo 2005-04-27
if not g_contabilidad_automatica then 
	// Desmarcamos la posibilidad de generar asientos
	dw_busqueda.setitem(1, 'anular_apuntes', 'N')
	dw_busqueda.trigger event itemchanged(1, dw_busqueda.Object.anular_apuntes, 'N')
end if
// fin Modificado Ricardo 2005-04-27
end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_cobros_devoluciones
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_cobros_devoluciones
string tag = "texto=general.guardar_pantalla"
end type

type tab_1 from tab within w_cobros_devoluciones
integer x = 23
integer y = 468
integer width = 3438
integer height = 1732
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
string tag = "texto=cobros.facturas_apuntes"
integer x = 18
integer y = 100
integer width = 3401
integer height = 1616
long backcolor = 79741120
string text = "Facturas/Apuntes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_imprimir_facturas cb_imprimir_facturas
dw_apuntes dw_apuntes
dw_facturas dw_facturas
cb_imprimir_apuntes cb_imprimir_apuntes
end type

on tabpage_1.create
this.cb_imprimir_facturas=create cb_imprimir_facturas
this.dw_apuntes=create dw_apuntes
this.dw_facturas=create dw_facturas
this.cb_imprimir_apuntes=create cb_imprimir_apuntes
this.Control[]={this.cb_imprimir_facturas,&
this.dw_apuntes,&
this.dw_facturas,&
this.cb_imprimir_apuntes}
end on

on tabpage_1.destroy
destroy(this.cb_imprimir_facturas)
destroy(this.dw_apuntes)
destroy(this.dw_facturas)
destroy(this.cb_imprimir_apuntes)
end on

type cb_imprimir_facturas from commandbutton within tabpage_1
integer x = 18
integer y = 900
integer width = 448
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir &Facturas"
end type

event clicked;if idw_facturas.rowcount() > 0 then idw_facturas.print()
end event

type dw_apuntes from u_dw within tabpage_1
integer x = 14
integer y = 980
integer width = 3387
integer height = 632
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_apuntes_automaticos"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_facturas from u_dw within tabpage_1
event csd_marcar_no_modificado ( long fila,  string campo )
integer x = 14
integer y = 8
integer width = 3387
integer height = 884
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_cobros_lista_devoluciones"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_marcar_no_modificado(long fila, string campo);// Evento para que no est$$HEX2$$e9002000$$ENDHEX$$marcado como modificado

// DEcimos que este campo no ha sido modificado
/*dw_facturas.SetItemStatus(fila, campo, primary!, notmodified!)
dw_facturas.SetItemStatus(fila, 0, primary!, notmodified!)
*/
this.SetItemStatus(fila, campo, primary!, notmodified!)
this.SetItemStatus(fila, 0, primary!, notmodified!)
end event

event constructor;call super::constructor;this.of_SetSort(TRUE)
// Column header sort
inv_sort.of_SetColumnHeader (true)
// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE 'devolver'
		// lanzamos un evento para que marque el campo como no modificado
		this.post event csd_marcar_no_modificado(row, dwo.name)
		this.setitem(row,'devuelto',data)
		// lanzamos un evento para que marque el campo como no modificado
		this.post event csd_marcar_no_modificado(row, 'devuelto')
END CHOOSE

end event

type cb_imprimir_apuntes from commandbutton within tabpage_1
integer x = 2939
integer y = 900
integer width = 448
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir Apuntes"
end type

event clicked;if idw_apuntes.rowcount() > 0 then idw_apuntes.print()
end event

type tabpage_2 from userobject within tab_1
string tag = "texto=cobros.facturas_gastos"
integer x = 18
integer y = 100
integer width = 3401
integer height = 1616
long backcolor = 79741120
string text = "Facturas Gastos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_colegiados_factura_1_n dw_colegiados_factura_1_n
dw_colegiados_datos_factura dw_colegiados_datos_factura
cb_imprimir_facturas_2 cb_imprimir_facturas_2
end type

on tabpage_2.create
this.dw_colegiados_factura_1_n=create dw_colegiados_factura_1_n
this.dw_colegiados_datos_factura=create dw_colegiados_datos_factura
this.cb_imprimir_facturas_2=create cb_imprimir_facturas_2
this.Control[]={this.dw_colegiados_factura_1_n,&
this.dw_colegiados_datos_factura,&
this.cb_imprimir_facturas_2}
end on

on tabpage_2.destroy
destroy(this.dw_colegiados_factura_1_n)
destroy(this.dw_colegiados_datos_factura)
destroy(this.cb_imprimir_facturas_2)
end on

type dw_colegiados_factura_1_n from u_dw within tabpage_2
integer x = 5
integer y = 944
integer width = 3383
integer height = 668
integer taborder = 30
string dataobject = "d_colegiados_factura_1_n"
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;DataWindowChild articulos

this.GetChild("articulo",articulos)

articulos.SetTransObject(sqlca)
articulos.Retrieve(g_empresa)

this.insertrow(0)
this.resetupdate()
end event

event itemchanged;call super::itemchanged;string descripcion,t_iva, emp
double importe

CHOOSE CASE dwo.name
	CASE 'articulo'
	 	 SELECT descripcion,importe,t_iva,empresa  
		  INTO :descripcion,:importe,:t_iva, :emp  FROM csi_articulos_servicios  WHERE codigo = :data and empresa=:g_empresa ;

		this.SetItem(row,'descripcion_larga',descripcion)	
		this.SetItem(row,'subtotal',importe)
		this.SetItem(row,'precio',importe)
		this.SetItem(row,'t_iva',t_iva)
		this.SetItem(row,'subtotal_iva',f_aplica_t_iva(importe,t_iva))
		this.SetItem(row,'total',importe + f_aplica_t_iva(importe,t_iva))
		this.setitem(row,'empresa',f_obtener_empresa_nombre_corto(emp))
	CASE 'subtotal'
		t_iva= this.GetItemString(row,'t_iva')
		if isnull(t_iva) then return 
		this.SetItem(row,'precio',double(data))		
		this.SetItem(row,'subtotal_iva',f_aplica_t_iva(double(data),t_iva))
		this.SetItem(row,'total',double(data) + f_aplica_t_iva(double(data),t_iva))
	CASE 't_iva'
		importe= this.GetItemNumber(row,'subtotal')
		if isnull(importe) then return 
		this.SetItem(row,'subtotal_iva',f_aplica_t_iva(importe,data))
		this.SetItem(row,'total',importe + f_aplica_t_iva(importe,data))
END CHOOSE		

end event

type dw_colegiados_datos_factura from u_dw within tabpage_2
integer x = 14
integer y = 12
integer width = 3383
integer height = 924
integer taborder = 30
string dataobject = "d_colegiados_datos_factura"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;// MODIFICADO RICARDO 2005-03-19
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

this.insertrow(0)
this.object.ordenar_t.visible = false
this.object.ordenar.visible = false
this.modify("incluir_todos.visible = '0'")
this.modify("ordenar.visible = '0'")
this.modify("ordenar_t.visible = '0'")
this.object.borrar_extras.visible = false
this.setitem(1, 'borrar_extras', 'N')
this.modify("t_explicacion.visible = '0'")
this.modify("gb_2.visible = '0'")
this.setitem(1, 'n_originales', 0)
this.setitem(1, 'n_copias', 0)
this.resetupdate()

// FIN MODIFICADO RICARDO 2005-03-19

end event

event itemchanged;call super::itemchanged;string n_cuenta

CHOOSE CASE dwo.name
	CASE 'banco'
		this.SetItem(1,'codigo',f_cobros_devuelve_ncontrol(data))
		select cuenta_bancaria_iban into :n_cuenta from csi_bancos where codigo= :data;
		
		n_cuenta = gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban( n_cuenta)
		
		this.SetItem(1,'cuenta_banco',n_cuenta)
	
	CASE 'formapago'
		string tipo_pago, banco
		tipo_pago = string(data)
		SELECT csi_formas_de_pago.banco_asociado  
		INTO :banco  
		FROM csi_formas_de_pago  
		WHERE csi_formas_de_pago.tipo_pago = :tipo_pago ;
		
		// Colocamos el banco
		this.setitem(row, 'banco', banco)
		
		// Al mofidificar a forma de pago domiciliacion bancaria, los cobros deben quedarse 
		// como no pagados obligatoriamente o no funciona la domiciliacion
		if data = 'DB' then this.setitem(row, 'pagada', 'N')
END CHOOSE

end event

type cb_imprimir_facturas_2 from commandbutton within tabpage_2
integer x = 14
integer y = 828
integer width = 448
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir &Facturas"
end type

event clicked;tab_1.tabpage_1.cb_imprimir_facturas.event clicked()
end event

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
string tag = "texto=cobros.incidencias"
integer x = 18
integer y = 100
integer width = 3401
integer height = 1616
long backcolor = 79741120
string text = "Incidencias"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_imprimir_incidencias cb_imprimir_incidencias
dw_incidencias dw_incidencias
end type

on tabpage_3.create
this.cb_imprimir_incidencias=create cb_imprimir_incidencias
this.dw_incidencias=create dw_incidencias
this.Control[]={this.cb_imprimir_incidencias,&
this.dw_incidencias}
end on

on tabpage_3.destroy
destroy(this.cb_imprimir_incidencias)
destroy(this.dw_incidencias)
end on

type cb_imprimir_incidencias from commandbutton within tabpage_3
string tag = "texto=cobros.imprimir_incidencias"
integer x = 5
integer y = 964
integer width = 448
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir Incidencias"
end type

event clicked;if dw_incidencias.rowcount() > 0 then dw_incidencias.print()
end event

type dw_incidencias from u_dw within tabpage_3
integer y = 28
integer width = 3392
integer height = 924
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_cobros_devoluciones_incidencias"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.object.t_nivel.visible = false
this.object.t_descripcion.visible = true
this.object.valor_descripcion.visible = true
this.object.nivel_incidencia.visible = false

end event

type cb_desmarcar from commandbutton within w_cobros_devoluciones
string tag = "texto=cobros.desmarcar_todos"
integer x = 375
integer y = 388
integer width = 398
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Desmarcar todos"
end type

event clicked;long fila

// Marcamos todas las facturas para devolver
for fila = 1 To idw_facturas.RowCount()
	idw_facturas.setitem(fila, 'devolver', 'N')

next
end event

type dw_cobros from u_dw within w_cobros_devoluciones
integer x = 2405
integer y = 1340
integer width = 274
integer height = 132
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_cobros_frecibidas"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.visible = false
end event

type cb_grabar from commandbutton within w_cobros_devoluciones
string tag = "texto=cobros.actualizar"
integer x = 2976
integer y = 120
integer width = 448
integer height = 76
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Actualizar"
end type

event clicked;boolean b_autocommit_SQLCA, b_autocommit_bd_ejercicio
datetime fecha_nula
long fila, cobro
string id_factura, sql_origen, id_factura_creada, primera_id_factura_creada, ultima_id_factura_creada
boolean b_error = false,b_generar_fact_dev
datastore ds_lineas

setnull(fecha_nula)

// Hacemos control de transacciones
b_autocommit_SQLCA = SQLCA.autocommit
b_autocommit_bd_ejercicio = bd_ejercicio.autocommit
SQLCA.autocommit = false
bd_ejercicio.autocommit = false
EXECUTE IMMEDIATE "begin trans" USING SQLCA;
EXECUTE IMMEDIATE "begin trans" USING bd_ejercicio;


b_generar_fact_dev = (dw_busqueda.GetItemString(1,'generar_fact_dev') = 'S')

//SCP-166 Verificamos que el ejercicio contable esta abierto
if NOT f_ejercicio_abierto(g_ejercicio) then
	Messagebox(g_titulo,'El ejercicio contable '+ g_ejercicio + ' no est$$HEX2$$e1002000$$ENDHEX$$abierto. No es posible realizar la devoluci$$HEX1$$f300$$ENDHEX$$n y continuar con el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n.',stopsign!)
	return
end if


// Recorremos las facturas buscando las marcadas a devolver
for fila = 1 To idw_facturas.RowCount()
	if idw_facturas.GetitemString(fila, 'devolver') =  'S' then
		// Cogemos el identificador de la factura para desmarcar los cobros
		id_factura = idw_facturas.GetItemString(fila, 'id_factura')

		if idw_facturas.GetItemString(fila, 'pagado')='S' then
			// La desmarcamos como cobrada
			idw_facturas.setitem(fila, 'pagado', 'N')
			idw_facturas.SetItem(fila,'f_pago',fecha_nula)
		end if

		// Hay que descontabilizar los cobros. Obtenemos los cobros de cada factura
		dw_cobros.Retrieve(id_factura)
		
//		// Filtramos para coger solo los domiciliados (INC. 5365)
//		dw_cobros.SetFilter("forma_pago = '"+ g_formas_pago.domiciliacion +" '")
//		dw_cobros.filter()

		// Filtramos para coger solo ese cobro (INC. 6209)
		dw_cobros.SetFilter("id_pago = '"+ idw_facturas.GetItemString(fila, 'id_cobro') +" '")
		dw_cobros.filter()
		
		for cobro=1 to dw_cobros.RowCount()
			// Si el cobro estaba pagado generamos desmarcamos el pagado y quitamos la fecha de pago
			if dw_cobros.getitemstring(cobro,'pagado')='S' then
				// Marcamos el cobro como devuelto
				dw_cobros.setitem(cobro, 'devuelto', 'S')
				dw_cobros.setitem(cobro, 'devolucion_motivo', idw_facturas.GetItemString(fila, 'devolucion_motivo'))
				// Lo desmarcamos como cobrado
				dw_cobros.setitem(cobro, 'pagado', 'N')
				dw_cobros.SetItem(cobro,'f_pago',fecha_nula)
				
				// Si adicionalmente el cobro est$$HEX2$$e1002000$$ENDHEX$$contabilizado, ya tendremos los apuntes en el dw aparte, solo hace falta
				// desmarca el contabilizado y la fecha de contabilizaci$$HEX1$$f300$$ENDHEX$$n
				if dw_cobros.GetItemString(cobro,'contabilizado') = 'S' then
					dw_cobros.SetItem(cobro,'contabilizado', 'N')
					dw_cobros.SetItem(cobro,'f_contabilizado', fecha_nula)
				end if
			end if		
		next	
		
		// MODIFICADO RICARDO 2005-03-15
		if b_generar_fact_dev then
			// Tenemos que generar la factura de devolucion
			if not isvalid(ds_lineas) then
				ds_lineas = create datastore
				ds_lineas.dataobject = idw_colegiados_factura_1_n.dataobject
				ds_lineas.object.data = idw_colegiados_factura_1_n.object.data
			end if
			id_factura_creada = wf_crear_factura_devolucion(id_factura, idw_facturas.GetItemString(fila, 'tipo_persona'), idw_facturas.GetItemString(fila, 'id_persona'),ds_lineas)	
			if  id_factura_creada<>'-1' and primera_id_factura_creada = ''   then primera_id_factura_creada = id_factura_creada	
			if  id_factura_creada<>'-1' then ultima_id_factura_creada = id_factura_creada
		end if
		// FIN MODIFICADO RICARDO 2005-03-15
		
		// Intentamos grabar los cambios en los cobros
		if dw_cobros.update()<>1 then b_error = true
		// Si ha habido un error salimos del bucle
		if b_error then exit
	end if
next

// MODIFICADO RICARDO 2005-03-15
// Destruimos el datastore si est$$HEX2$$e1002000$$ENDHEX$$creado 
if isvalid(ds_lineas) then destroy ds_lineas



// Grabamos el de apuntes
if not b_error then 
	if idw_apuntes.update()<>1 then b_error = true
end if

// Grabamos las cabeceras
if not b_error then 
	if idw_facturas.update()<>1 then b_error = true
end if



if b_error then
	Messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.error_contraapuntes',"Se ha producido un error al intentar generar los contraapuntes de los cobros")+cr+g_idioma.of_getmsg('msg_cobros.repita_proceso',"Repita el proceso nuevamente, volviendo a realizar la consulta"), stopsign!)
	// Hacemos un rollback
	Execute Immediate "ROLLBACK transaction" USING SQLCA;
	Execute Immediate "ROLLBACK transaction" USING bd_ejercicio;
	// Volvemos a colocar los autocomit
	SQLCA.autocommit = b_autocommit_SQLCA
	bd_ejercicio.autocommit = b_autocommit_bd_ejercicio
	return
else
	// Hacemos un commit
	Execute Immediate "COMMIT transaction" USING SQLCA;
	Execute Immediate "COMMIT transaction" USING bd_ejercicio;
	// Cerramos la transaccion	
	EXECUTE IMMEDIATE "end trans" USING SQLCA;
	EXECUTE IMMEDIATE "end trans" USING bd_ejercicio;
	// Volvemos a colocar los autocomit
	SQLCA.autocommit = b_autocommit_SQLCA
	bd_ejercicio.autocommit = b_autocommit_bd_ejercicio
	
	
	// Cogemos la SQL para modificarla y nos la guardamos para restaurarla a posteriori
	sql_origen = idw_facturas.describe("datawindow.table.select")
	// Aplicamos la nueva sql 
	idw_facturas.modify("datawindow.table.select= ~"" + is_consulta_aplicada + "~"")
	// retriveamos y dependiendo de si hay valor o no hacemos
	if idw_facturas.Retrieve()>0 then
		cb_marcar_todos.enabled = true
		cb_devolver.enabled = true
	else
		cb_marcar_todos.enabled = false
		cb_devolver.enabled = false
	end if
	// Se restablece la propiedad select para una nueva consulta
	idw_facturas.modify("datawindow.table.select= ~"" + sql_origen + "~"")
	
	if b_generar_fact_dev then
		MessageBox(g_titulo, g_idioma.of_getmsg('msg_cobros.proceso_exito','El proceso se ha realizado con $$HEX1$$e900$$ENDHEX$$xito. ')+cr+&
					+ g_idioma.of_getmsg('msg_cobros.facturas_creadas','Rango de facturas creadas: ') + f_dame_n_fact_de_id(primera_id_factura_creada) + ' - '  +&
					+ f_dame_n_fact_de_id(ultima_id_factura_creada), Information!)
	else
		Messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.proceso_exito',"El proceso se ha realizado con $$HEX1$$e900$$ENDHEX$$xito"))
	end if
	
end if

//Actualizamos el n$$HEX2$$ba002000$$ENDHEX$$de Asiento en Contabilidad
f_actualiza_numero_bd_ejercicio(g_sica_diario.devoluciones,i_asiento)
setnull(i_asiento)

// Volvemos a ocultar los apuntes generados
idw_apuntes.reset()


// Deshabilitamos los botones
cb_grabar.enabled = false

idw_colegiados_datos_factura.enabled=true
idw_colegiados_factura_1_n.enabled=true
end event

type cb_devolver from commandbutton within w_cobros_devoluciones
string tag = "texto=cobros.devolver_facturas"
integer x = 2976
integer y = 36
integer width = 448
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Devolver Facturas"
end type

event clicked;// Bot$$HEX1$$f300$$ENDHEX$$n que se encargar$$HEX2$$e1002000$$ENDHEX$$de realizar las tareas que tenga que hacer para dejar los cobros despagados, 
// las facturas despagadas y 

long fila, cobro
boolean b_hay_facturas_marcadas = false, b_error = false, b_imprimir_cartas,b_generar_fact_dev
string id_factura, sql_origen = ''
datetime fecha_nula
// Variables para la generaci$$HEX1$$f300$$ENDHEX$$n del asiento
long cuantos
datetime fecha, fecha_contraapunte
double importe,acumulado
string mensaje = '', n_factura, proyecto, ctabanco,cuenta,banco_contraapunte
string multiasiento,anular_cobros,anular_apuntes


i_asiento = -1
// VAciamos los posibles apuntes que hubiesen
idw_apuntes.reset()

if idw_facturas.rowcount()= 0 then return

// VAciamos la fecha
setnull(fecha_nula)

// Marcamos todas las facturas para devolver
for fila = 1 To idw_facturas.RowCount()
	if idw_facturas.GetitemString(fila, 'devolver') =  'S' then
		b_hay_facturas_marcadas = true
		exit
	end if
next

//Obtenemos los datos de "Control"
//Obtenemos el dato que nos indica si hay que hacer un asiento (S) por cobro
// o se hace todo en un $$HEX1$$fa00$$ENDHEX$$nico asiento (N)
dw_busqueda.accepttext ()
multiasiento = f_formatea_nulo(dw_busqueda.GetItemString(1,'multiasiento'),'N')
anular_cobros = f_formatea_nulo(dw_busqueda.GetItemString(1,'anular_cobros'),'N')
anular_apuntes = f_formatea_nulo(dw_busqueda.GetItemString(1,'anular_apuntes'),'N')
fecha_contraapunte = dw_busqueda.GetItemDateTime(1,'fecha_devolucion')
banco_contraapunte = dw_busqueda.GetItemString(1,'banco')
b_imprimir_cartas = (dw_busqueda.GetItemString(1,'generar_carta') = 'S')
b_generar_fact_dev = (dw_busqueda.GetItemString(1,'generar_fact_dev') = 'S')


// Si no hay facturas marcadas nos salimos comentandolo
if not b_hay_facturas_marcadas then
	MessageBox(g_titulo,g_idioma.of_getmsg('msg_cobros.no_marcada_fact', "NO se ha marcado ninguna factura para devolver."), exclamation!)
	return
end if

// Modificado Ricardo 2005-04-27
//Si hay contabilidad.. ha de hacer la comprobaci$$HEX1$$f300$$ENDHEX$$n de variables globales...
if anular_apuntes='S' and g_contabilidad_automatica then 
	mensaje = ''
	if isnull(fecha_contraapunte) then mensaje = g_idioma.of_getmsg('msg_cobros.fecha_contraapuntes',"Debe indicar la fecha en la que se generar$$HEX1$$e100$$ENDHEX$$n los contraapuntes")+cr
	if isnull(banco_contraapunte) then mensaje += g_idioma.of_getmsg('msg_cobros.banco_contraapuntes',"Debe indicar el banco contra el que se generar$$HEX1$$e100$$ENDHEX$$n los contraapuntes")
	if b_generar_fact_dev then mensaje += wf_comprobar_facturas_devolucion()
	if not f_es_vacio(mensaje) then
		MessageBox(g_titulo, mensaje, stopsign!)
		return
	end if
	if parent.Event csd_comprobacion_parametros_contabilidad()=2  then return
	mensaje = ''
	
	// Modificado Ricardo 2005-04-27
	// miramos que la fecha indicada para los apuntes de devolucion est$$HEX1$$e900$$ENDHEX$$n dentro del ejercicio contable
	if string(year(date(fecha_contraapunte)))<>g_ejercicio then 
		MessageBox(g_titulo, g_idioma.of_getmsg('msg_cobros.fecha_contraapuntes_ejercicio',"La fecha de los contraapuntes no pertenece al ejercicio actual. El proceso de devoluci$$HEX1$$f300$$ENDHEX$$n ha sido cancelado."), stopsign!)
		return
	end if
	// fin Modificado Ricardo 2005-04-27
end if


// Colocamos el settrans para los apuntes que se hagan
idw_apuntes.SetTransObject(bd_ejercicio)


acumulado=0
//Cogemos la Cta. del Banco de la Cuenta Contable del Banco que seleccionamos para la remesa
SELECT cuenta_contable INTO :ctabanco FROM csi_bancos WHERE codigo = :banco_contraapunte  and empresa=:g_empresa ;
for fila = 1 To idw_facturas.RowCount()
	if idw_facturas.GetitemString(fila, 'devolver') =  'N' then continue
	if anular_cobros = 'S' then	
		idw_facturas.SetItem(fila,'pagado','N')
		idw_facturas.SetItem(fila,'f_pago',fecha_nula)
	end if
	// Marcamos la factura como procesada (basta colocar un valor QUE no sea 0 en color para que la marque en gris)
	idw_facturas.setitem(fila, 'color', 1)
	

			
	// Cogemos el identificador de la factura para desmarcar los cobros
	id_factura = idw_facturas.GetItemString(fila, 'id_factura')
	n_factura  = idw_facturas.GetItemString(fila,'n_fact')
	// Hay que descontabilizar los cobros. Obtenemos los cobros de cada factura
	dw_cobros.Retrieve(id_factura)
	
//	// Filtramos para coger solo los domiciliados (INC. 5365)
//	dw_cobros.SetFilter("forma_pago = '"+ g_formas_pago.domiciliacion +" '")
//	dw_cobros.filter()
	
	// Filtramos para coger solo ese cobro (INC. 6209)
	dw_cobros.SetFilter("id_pago = '"+ idw_facturas.GetItemString(fila, 'id_cobro') +" '")
	dw_cobros.filter()
	
	// Imprimimos la carta para esta
	if b_imprimir_cartas then wf_imprimir_carta(id_factura)
	
	for cobro=1 to dw_cobros.RowCount()
		//////////////////////////////////////////////////////////////////////////
		// Codigo copiado del evento csd_contabilizar_cobros de la ventana de facturaci$$HEX1$$f300$$ENDHEX$$n emitida detalle
		//////////////////////////////////////////////////////////////////////////
		//Si hay que anular el cobro, se deja impagado...
		if anular_cobros = 'S' then	
			idw_facturas.SetItem(fila,'pagado','N')
			idw_facturas.SetItem(fila,'f_pago',fecha_nula)
		end if
		//Si no hay que generar apuntes... pasamos del resto del c$$HEX1$$f300$$ENDHEX$$digo del bucle
		if anular_apuntes ='N' then continue				
		
		//Si NO est$$HEX2$$e1002000$$ENDHEX$$contabilizado el cobro.. no tiene sentido generar contra-apuntes
		if dw_cobros.GetItemString(cobro,'contabilizado') <> 'S' then continue
		
		// Cogemos un numero de asiento
		if i_asiento=-1 then 
			i_asiento = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.devoluciones,7))
			if isnull(i_asiento) then i_asiento = 0
			g_apunte.n_apunte = '00000'
		else
			if multiasiento ='S' then 
				i_asiento++
				g_apunte.n_apunte = '00000'
			end if
		end if
		
	// Tomamos los datos que nos sean necesarios para generar el asiento
		fecha = dw_cobros.GetItemDateTime(cobro,'f_pago') // Si en alg$$HEX1$$fa00$$ENDHEX$$n momento la f_pago se vacia por la funci$$HEX1$$f300$$ENDHEX$$n f_dev_pasar_cobros_a_impagado esto no funcionar$$HEX2$$e1002000$$ENDHEX$$A fecha de 7/10/03 no lo hace (Comprobado Ricardo)
		importe = dw_cobros.GetItemNumber(cobro,'importe')
		proyecto = dw_cobros.GetItemString(cobro,'proyecto')
		
		// Evitamos los nulos
		if f_es_vacio(n_factura) then n_factura = ''
		if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
		if f_es_vacio(proyecto) then proyecto = g_explotacion_por_defecto


		/****************************************************************************
								Rellenamos DATOS GENERALES DE G_APUNTE
		****************************************************************************/
//				asiento++
		g_apunte.n_asiento = RightA('0000000' + trim(string(i_asiento)),7)
//				g_apunte.n_apunte = '00000'
		g_apunte.n_doc = n_factura
		g_apunte.fecha = datetime(date(fecha_contraapunte), time("00:00:00")) // Modificado Ricardo 04-03-17
		g_apunte.t_asiento = g_t_asiento_apuntes_automaticos
		g_apunte.id_interno = id_factura
		g_apunte.diario = g_sica_diario.devoluciones
		g_apunte.proyecto = proyecto
		g_apunte.centro = dw_cobros.GetItemString(cobro,'centro')
		g_apunte.cta_presupuestaria = dw_cobros.GetItemString(cobro,'cta_presupuestaria')	
		// Seg$$HEX1$$fa00$$ENDHEX$$n la forma de pago pondremos un tipo de documento u otro
		choose case dw_cobros.GetItemString(cobro,'forma_pago')
			case g_formas_pago.transferencia
				g_apunte.t_doc = g_sica_t_doc.transferencia
			case g_formas_pago.talon
				g_apunte.t_doc = g_sica_t_doc.talon
			case else
				g_apunte.t_doc = g_sica_t_doc.generico
		end choose
		
		//Seg$$HEX1$$fa00$$ENDHEX$$n el tipo de persona seleccionamos la cuenta de Cliente o Colegiado
		choose case idw_facturas.GetItemString(fila,'tipo_factura')
			CASE '03'//g_colegio_colegiado
				cuenta = f_dame_cuenta_col(idw_facturas.GetItemString(fila,'id_persona'),'G')	// Gastos
			CASE '02'
				cuenta = f_clientes_cuenta_contable(idw_facturas.GetItemString(fila,'id_persona'))
			case '04'
				cuenta = f_dame_cuenta_col(idw_facturas.GetItemString(fila,'id_persona'),'P') // personal / honorarios
		end choose
		
		/****************************************************************************
								Generamos el apunte propiamente dicho
		****************************************************************************/
		if multiasiento ='S' then 
			// Abono a Banco
			g_apunte.concepto = LeftA('Dev. Pago Fact N$$HEX2$$ba002000$$ENDHEX$$'+n_factura,57)
			g_apunte.cuenta = ctabanco
			g_apunte.debe = 0
			g_apunte.haber = importe
			g_apunte.contrapartida = cuenta
			f_apunte_dw(g_apunte,idw_apuntes,'E')	
		else
			acumulado += importe
		end if
		// Cargo a la Cuenta del colegiado
		g_apunte.concepto = LeftA('Dev. Pago Fact N$$HEX2$$ba002000$$ENDHEX$$'+n_factura,57)
		g_apunte.cuenta = cuenta
		g_apunte.debe = importe
		g_apunte.haber = 0
		g_apunte.contrapartida = ctabanco		
		f_apunte_dw(g_apunte,idw_apuntes,'E')	
	next
next
if multiasiento ='N' and anular_apuntes ='S' then
	// Abono a Banco
	g_apunte.concepto = LeftA('Dev. Pago Facts. ',57)
	g_apunte.cuenta = ctabanco
	g_apunte.debe = 0
	g_apunte.haber = acumulado
	f_apunte_dw(g_apunte,idw_apuntes,'E')	
end if
// redibujamos el dw para que salgan los colores
idw_facturas.setredraw(true)
// Visualizamos los apuntes realizados para que los vea el usuario, recalculando los grupos primeramente
if idw_apuntes.RowCount()>0 then
	idw_apuntes.groupcalc()
	// Habilitamos el bot$$HEX1$$f300$$ENDHEX$$n de grabado
	cb_grabar.enabled = true	
else
//	if MessageBox(g_titulo, "De las facturas marcadas a devolver no hay ninguna contabilizada o no ha marcado generar contraapuntes"+cr+"$$HEX1$$bf00$$ENDHEX$$Desea continuar con el proceso de devoluci$$HEX1$$f300$$ENDHEX$$n?", question!, yesno!, 2)=1 then 
//		// Lanzamos el otro evento directamente
//		cb_grabar.post event clicked()
//	else
//	end if
	// INC. 9616 Esta ejecutando el c$$HEX1$$f300$$ENDHEX$$digo del bot$$HEX1$$f300$$ENDHEX$$n grabar (actualizando el n_asiento a -1) cuando no ha generado apuntes
	// porque el cobro no ten$$HEX1$$ed00$$ENDHEX$$a forma de pago domiciliaci$$HEX1$$f300$$ENDHEX$$n bancaria.
	//MessageBox(g_titulo,g_idioma.of_getmsg('msg_cobros.fact_no_contab', "De las facturas marcadas a devolver no hay ninguna contabilizada, no est$$HEX1$$e100$$ENDHEX$$n domiciliadas o no ha marcado generar contraapuntes"))
	///*ICC-308. Se a$$HEX1$$f100$$ENDHEX$$ade Caceres. Alexis. 16-02/2010*///
	if g_colegio ='COAATTFE' or g_colegio='COAATMCA' or g_colegio = 'COAATCC'  then  
		cb_grabar.enabled = true	
		//MessageBox(g_titulo,g_idioma.of_getmsg('msg_cobros.fact_no_contab', "De las facturas marcadas a devolver no hay ninguna contabilizada, no est$$HEX1$$e100$$ENDHEX$$n domiciliadas o no ha marcado generar contraapuntes"))
	else
		MessageBox(g_titulo,g_idioma.of_getmsg('msg_cobros.fact_no_contab', "De las facturas marcadas a devolver no hay ninguna contabilizada, no est$$HEX1$$e100$$ENDHEX$$n domiciliadas o no ha marcado generar contraapuntes"))
	end if
end if
// Deshabilitamos este bot$$HEX1$$f300$$ENDHEX$$n
cb_devolver.enabled = false
cb_marcar_todos.enabled = false
//cb_config_fact.enabled = false
//Ahora ya no podemos cambiar las facturas de gastos
idw_colegiados_datos_factura.enabled=false
idw_colegiados_factura_1_n.enabled=false

end event

type cb_marcar_todos from commandbutton within w_cobros_devoluciones
string tag = "texto=cobros.marcar_todos"
integer x = 27
integer y = 388
integer width = 347
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Marcar todos"
end type

event clicked;long fila

// Marcamos todas las facturas para devolver
for fila = 1 To idw_facturas.RowCount()
	idw_facturas.setitem(fila, 'devolver', 'S')
next

end event

type cb_fichero2 from commandbutton within w_cobros_devoluciones
string tag = "texto=cobros.buscar_marcar_fichero"
integer x = 773
integer y = 388
integer width = 667
integer height = 76
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Buscar/Marcar desde &Fichero"
end type

event clicked;long i, devol
string fichero, ruta, id_factu, id_cobro, n_fact, n_colegiado, colegiado,motivo
string destinatario,mensaje, lista_id_cobros, sql_nuevo, sql_origen, sql_union
datetime fecha
real total, nro_fact_fich, nro_fact, total_fich
int num_fich, num_fact,fila,fila_inc, respuesta

//Si no hay facturas seleccionadas.. tal como venga el fichero hay que buscar las facturas en bbdd
if idw_facturas.rowcount() = 0 then 
	respuesta = 1
else
	// Si hay facturas, preguntamos si las facturas que no est$$HEX1$$e900$$ENDHEX$$n en pantalla las recuperamos de la bbdd primero
	respuesta = Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.cargar_fact_fichero',  "$$HEX1$$bf00$$ENDHEX$$Desea cargar las facturas del fichero que no est$$HEX1$$e900$$ENDHEX$$n en la consulta actual?"), question!, yesno!, 2)
end if

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02
devol = getfileopenname('Selecci$$HEX1$$f300$$ENDHEX$$n del Fichero de Devoluciones Bancarias', ruta, fichero)

idw_incidencias.Reset()
//st_incidencias.visible = false

datastore ds_devol
ds_devol = create datastore	
ds_devol.dataobject = 'ds_cobros_facturas_devueltas'
ds_devol.SetTransObject(SQLCA)

if devol <=0 then return

f_cobros_devoluciones_bancarias(fichero, ds_devol)


if respuesta = 1 then
	lista_id_cobros = ''
	// hay que procurar que salgan todas las facturas que encontremos en el diskete
	for i = 1 to ds_devol.rowcount()
		id_cobro = ds_devol.getitemstring(i, 'id_cobro')
		if LenA(lista_id_cobros)>0 then lista_id_cobros += ', '
		lista_id_cobros += "'"+id_cobro+"'" 
	next
	// Cogemos la sql original del dw y le ponemos la condicion que queremos
	sql_origen = idw_facturas.describe("datawindow.table.select")
	sql_nuevo = sql_origen
	sql_nuevo += " and csi_cobros.id_pago in ("+lista_id_cobros+")"
	// Si ya habia una consulta previa, mantenemos dicha consulta
	if LenA(is_consulta_aplicada)>0 then
		sql_nuevo = is_consulta_aplicada + ' UNION ' +sql_nuevo
	end if
	// Colocamos la consulta
	idw_facturas.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
	// Nos almacenamos la consulta para volver a hacerlo
	is_consulta_aplicada = sql_nuevo
	
	// retriveamos y dependiendo de si hay valor o no hacemos
	if idw_facturas.Retrieve()>0 then
		cb_devolver.enabled = true
	else
		cb_marcar_todos.enabled = false
	end if
	// Se restablece la propiedad select para una nueva consulta
	idw_facturas.modify("datawindow.table.select= ~"" + sql_origen + "~"")
end if

for i = 1 to ds_devol.rowcount()
	// A partir del cobro buscaremos la factura para desmarcarla
	id_cobro = ds_devol.getitemstring(i, 'id_cobro')
	motivo = f_motivo_devolucion(ds_devol.getitemstring(i, 'motivo'))
	fila = idw_facturas.Find("id_cobro='"+id_cobro+"'",1,idw_facturas.rowcount())
	if fila>0 then //Ha encontrado la fila del cobro y le pone los par$$HEX1$$e100$$ENDHEX$$metros a devolver...
		idw_facturas.SetItem(fila,'devolver','S')
	//	idw_facturas.SetItem(i,'color',2) //Ponemos los autom$$HEX1$$e100$$ENDHEX$$ticos de otro color
		idw_facturas.setitem(fila,'motivo',motivo)
		idw_facturas.setitem(fila,'devolucion_motivo',ds_devol.getitemstring(i, 'motivo'))
		idw_facturas.setitem(fila,'devuelto','S')
	else
		select F.n_fact,F.nombre into :n_fact,:destinatario from csi_facturas_emitidas F,csi_cobros C where
			C.id_factura = F.id_factura and C.id_pago = :id_cobro;
		fila_inc = idw_incidencias.InsertRow(0)
		mensaje = 'NO encontrada la factura '+n_fact

		idw_incidencias.SetItem(fila_inc,'incidencia',mensaje)
		idw_incidencias.SetItem(fila_inc,'valor_descripcion',destinatario)
	end if
next

if idw_incidencias.rowcount()>0 then
	//Si hay incidencias las mostramos
	Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.incidencias_marcar_fichero',"Ha habido incidencias al marcar desde fichero"),Exclamation!)
	tab_1.selectTab(3)
	//st_incidencias.visible = true
	//st_incidencias.TriggerEvent(Clicked!)
end if

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02

end event

type dw_busqueda from u_dw within w_cobros_devoluciones
event csd_formatea_n_remesa ( string dato )
integer y = 8
integer width = 2949
integer height = 488
integer taborder = 10
string dataobject = "d_cobros_devoluciones_busqueda_remesa"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_formatea_n_remesa(string dato);string n_remesa_formateado
n_remesa_formateado = f_rellenar_ceros_campo(dato, 10)
if n_remesa_formateado <> dato then
	this.setitem(1, 'n_remesa', n_remesa_formateado)
end if
end event

event constructor;call super::constructor;// Colocamos una linea para que se pueda hacer algo
this.insertrow(0)

//Se activa el Drop Down para el Calendar
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event buttonclicked;call super::buttonclicked;string  sql_nuevo = '', sql_origen = '', remesa

CHOOSE CASE dwo.name
	CASE 'b_buscar'
		// Aceptamos lo ultimo que hayan escrito
		dw_busqueda.accepttext()
		
		idw_incidencias.reset()
		idw_apuntes.reset()
		
		// Cogemos la SQL para modificarla y nos la guardamos para restaurarla a posteriori
		sql_nuevo = idw_facturas.describe("datawindow.table.select")
		sql_origen= sql_nuevo
		// Aplicamos la consulta
		f_sql('remesas.n_remesa','LIKE','n_remesa',dw_busqueda,sql_nuevo,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','LIKE','n_factura',dw_busqueda,sql_nuevo,g_tipo_base_datos,'')
		f_sql('csi_cobros.id_pago','=','ref_bancaria',dw_busqueda,sql_nuevo,g_tipo_base_datos,'')
		f_sql('remesas.fecha','>=','f_desde',dw_busqueda,sql_nuevo,g_tipo_base_datos,'')
		f_sql('remesas.fecha','<=','f_hasta',dw_busqueda,sql_nuevo,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.total','>=','importe_factura_desde',dw_busqueda,sql_nuevo,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.total','<=','importe_factura_hasta',dw_busqueda,sql_nuevo,g_tipo_base_datos,'')
		if (PosA(upper(sql_nuevo), "WHERE") > 0) then
			sql_nuevo += "AND csi_cobros.empresa='"+g_empresa+"'"
		else
			sql_nuevo += " WHERE csi_cobros.empresa='"+g_empresa+"'"
		end if
		
		// Aplicamos la nueva sql 
		//messagebox('',sql_nuevo)
		idw_facturas.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
		// Nos almacenamos la consulta para volver a hacerlo
		is_consulta_aplicada = sql_nuevo
		// retriveamos y dependiendo de si hay valor o no hacemos
		if idw_facturas.Retrieve()>0 then
			cb_marcar_todos.enabled = true
		else
			cb_marcar_todos.enabled = false
		end if
		// Se restablece la propiedad select para una nueva consulta
		idw_facturas.modify("datawindow.table.select= ~"" + sql_origen + "~"")
		
		// Ahora que hay consulta permitimos marcar el devolver
		if idw_facturas.RowCount()>0 then
			cb_devolver.enabled = true
			cb_marcar_todos.enabled = true
		end if
		
		idw_colegiados_datos_factura.enabled=true
		idw_colegiados_factura_1_n.enabled=true
		
		cb_grabar.enabled = false

	CASE 'b_remesa'
		g_busqueda.titulo = 'B$$HEX1$$fa00$$ENDHEX$$squeda de remesas de cobros'
		g_busqueda.dw = 'd_lista_busqueda_remesas_cobros'		
		open(w_busqueda_remesas_cobros)
		remesa = message.stringparm
		this.setitem(1, 'n_remesa', remesa)

END CHOOSE

end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'anular_apuntes'
		// Modificado Ricardo 2005-04-28
		// Si no tienen contabilidad automatica, no tiene sentido
		if not g_contabilidad_automatica then return 2
		
		
		if data ='S' then
			idw_apuntes.visible = true
		else
			idw_apuntes.visible = false
		end if
	CASE 'generar_fact_dev'
		if cb_grabar.enabled = true then return 2
		/*
		if data = 'S' then
			cb_config_fact.enabled = true
			cb_config_fact.visible = true
		else
			if idw_colegiados_datos_factura.visible = true then cb_config_fact.trigger event clicked()
			cb_config_fact.enabled = false
			cb_config_fact.visible = false
		end if*/
	case 'n_remesa'
			this.post event csd_formatea_n_remesa(data)		
end choose
end event

type dw_carta_devolucion from u_dw within w_cobros_devoluciones
boolean visible = false
integer x = 3003
integer y = 232
integer width = 421
integer height = 216
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_cobros_reclam_facturas_devolucion"
boolean hscrollbar = true
end type

