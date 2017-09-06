HA$PBExportHeader$w_musaat_cobro_mensual.srw
forward
global type w_musaat_cobro_mensual from w_response
end type
type dw_consulta from u_dw within w_musaat_cobro_mensual
end type
type cb_cobrar from commandbutton within w_musaat_cobro_mensual
end type
type cb_salir from commandbutton within w_musaat_cobro_mensual
end type
type st_proceso from statictext within w_musaat_cobro_mensual
end type
type cb_buscar from commandbutton within w_musaat_cobro_mensual
end type
type cb_listado from commandbutton within w_musaat_cobro_mensual
end type
type dw_3 from u_dw within w_musaat_cobro_mensual
end type
type cb_aumentar from commandbutton within w_musaat_cobro_mensual
end type
type cb_disminuir from commandbutton within w_musaat_cobro_mensual
end type
type sle_imprimir_copias from singlelineedit within w_musaat_cobro_mensual
end type
type st_3 from statictext within w_musaat_cobro_mensual
end type
type st_2 from statictext within w_musaat_cobro_mensual
end type
type sle_imprimir_originales from singlelineedit within w_musaat_cobro_mensual
end type
type cb_disminuir_copias from commandbutton within w_musaat_cobro_mensual
end type
type cb_aumentar_copias from commandbutton within w_musaat_cobro_mensual
end type
type dw_1 from u_dw within w_musaat_cobro_mensual
end type
type cb_domiciliaciones from commandbutton within w_musaat_cobro_mensual
end type
type dw_lista from u_dw within w_musaat_cobro_mensual
end type
type dw_pago from u_dw within w_musaat_cobro_mensual
end type
type gb_1 from groupbox within w_musaat_cobro_mensual
end type
end forward

global type w_musaat_cobro_mensual from w_response
integer x = 101
integer y = 100
integer width = 3410
integer height = 1984
event csd_calcular_musaat ( )
event csd_generar_linea_cobro_domiciliable ( string id_factura )
dw_consulta dw_consulta
cb_cobrar cb_cobrar
cb_salir cb_salir
st_proceso st_proceso
cb_buscar cb_buscar
cb_listado cb_listado
dw_3 dw_3
cb_aumentar cb_aumentar
cb_disminuir cb_disminuir
sle_imprimir_copias sle_imprimir_copias
st_3 st_3
st_2 st_2
sle_imprimir_originales sle_imprimir_originales
cb_disminuir_copias cb_disminuir_copias
cb_aumentar_copias cb_aumentar_copias
dw_1 dw_1
cb_domiciliaciones cb_domiciliaciones
dw_lista dw_lista
dw_pago dw_pago
gb_1 gb_1
end type
global w_musaat_cobro_mensual w_musaat_cobro_mensual

forward prototypes
public function double f_total_movimientos_colegiado (string id_col, string id_fase)
end prototypes

event csd_calcular_musaat();double porc_col = 0, porc_col_real = 0, suma_porc = 0, musaat = 0, i, j
datastore ds_colegiados
st_musaat_datos st_musaat_datos
string id_fase, id_col

// C$$HEX1$$e100$$ENDHEX$$lculo de la MUSAAT para todos los contratos
for i=1 to dw_1.rowcount()
	musaat = 0 // Vaciamos el valor del contrato anterior
	id_fase = dw_1.getitemstring(i, 'id_fase')
	
	// Pasando el id_fase y poniendo a true la variable recuperar en la funci$$HEX1$$f300$$ENDHEX$$n de
	// calcular la prima ya recupera todos los datos necesarios para el c$$HEX1$$e100$$ENDHEX$$lculo
	st_musaat_datos.n_visado = id_fase
	st_musaat_datos.recuperar = true

	// Datastore para recuperar los colegiados del contrato
	ds_colegiados = create datastore
	ds_colegiados.dataobject = 'd_fases_colegiados'
	ds_colegiados.settransobject(sqlca)
	ds_colegiados.retrieve(id_fase)

	// Se calcula la MUSAAT del contrato que es la suma de la musaat de los colegiados
	for j = 1 to ds_colegiados.rowcount()
		id_col = ds_colegiados.getitemstring(j, 'id_col')
		st_musaat_datos.id_col = id_col
		// Ponemos a 0 estas dos variables para que recupere los valores en la funci$$HEX1$$f300$$ENDHEX$$n
		st_musaat_datos.cobertura = 0
		st_musaat_datos.porcentaje = 0
		// Le pasamos en la estructura si el colegiado es funcionario
		st_musaat_datos.funcionario = ds_colegiados.getitemstring(j, 'facturado')
		// Vaciamos el mensaje para cada llamada a la funci$$HEX1$$f300$$ENDHEX$$n
		st_musaat_datos.mensaje = ''
		// La funci$$HEX1$$f300$$ENDHEX$$n de calcular es diferente si es sociedad o no
		if f_colegiado_tipopersona(id_col) = 'S' then
			f_musaat_calcula_prima_sociedad(st_musaat_datos)
			// Ponemos a 0 la prima para que no coja un valor anterior si ha dado alg$$HEX1$$fa00$$ENDHEX$$n mensaje de errror
			if st_musaat_datos.mensaje <> '' then st_musaat_datos.prima_comp = 0
			musaat += st_musaat_datos.prima_comp
		else
			f_musaat_calcula_prima(st_musaat_datos)
			// Ponemos a 0 la prima para que no coja un valor anterior si ha dado alg$$HEX1$$fa00$$ENDHEX$$n mensaje de errror			
			if st_musaat_datos.mensaje <> '' then st_musaat_datos.prima_comp = 0
			musaat += st_musaat_datos.prima_comp
		end if
	next
	if isnull(musaat) then musaat = 0
	dw_1.setitem(i, 'musaat', musaat)
	
	destroy ds_colegiados
next

end event

event csd_generar_linea_cobro_domiciliable(string id_factura);string id_pago, forma_pago, pagado, n_talon, banco, cuenta, centro, proyecto, cta_presupuestaria
string contabilizado, cuenta_gastos, n_remesa,n_fact,id_persona,n_col 
datetime f_pago, f_vencimiento, f_contabilizado
double importe, importe_gastos
int fila

SELECT id_pago,id_factura,forma_pago,importe,f_pago,pagado,f_vencimiento,n_talon,banco,cuenta,centro,proyecto,
		 cta_presupuestaria,contabilizado,f_contabilizado,importe_gastos,cuenta_gastos,n_remesa  
INTO :id_pago,:id_factura,:forma_pago,:importe,:f_pago,:pagado,:f_vencimiento,:n_talon,:banco,:cuenta,:centro,
	  :proyecto,:cta_presupuestaria,:contabilizado,:f_contabilizado,:importe_gastos,
	  :cuenta_gastos,:n_remesa  
FROM csi_cobros where id_factura = :id_factura;
	 
select n_fact,id_persona,n_col into :n_fact,:id_persona,:n_col from csi_facturas_emitidas where id_factura=:id_factura;
//Insertamos una linea en el dw externo para luego emitir domiciliaciones en caso de que se desee...
fila = dw_lista.InsertRow(0)

dw_lista.SetItem(fila,'id_pago',id_pago)
dw_lista.SetItem(fila,'n_fact',n_fact)
dw_lista.SetItem(fila,'id_persona',id_persona)
dw_lista.SetItem(fila,'id_factura',id_factura)
dw_lista.SetItem(fila,'forma_pago',forma_pago)
dw_lista.SetItem(fila,'importe',importe)
dw_lista.SetItem(fila,'f_pago',f_pago)
dw_lista.SetItem(fila,'pagado',pagado)
dw_lista.SetItem(fila,'f_vencimiento',f_vencimiento)
dw_lista.SetItem(fila,'n_talon',n_talon)
dw_lista.SetItem(fila,'banco',banco)
dw_lista.SetItem(fila,'cuenta',cuenta)
dw_lista.SetItem(fila,'centro',centro)
dw_lista.SetItem(fila,'proyecto',proyecto)
dw_lista.SetItem(fila,'contabilizado',contabilizado)
dw_lista.SetItem(fila,'f_contabilizado',f_contabilizado)
dw_lista.SetItem(fila,'importe_gastos',importe)
dw_lista.SetItem(fila,'cuenta_gastos',cuenta_gastos)
dw_lista.SetItem(fila,'n_remesa',n_remesa)
dw_lista.SetItem(fila,'n_col',n_col)

end event

public function double f_total_movimientos_colegiado (string id_col, string id_fase);int i
double total_src = 0

SELECT sum ( importe_vble)  
INTO :total_src  
FROM musaat_movimientos  
WHERE ( musaat_movimientos.id_fase = :id_fase ) AND  
      ( musaat_movimientos.id_col = :id_col )   ;

return total_src
	
end function

on w_musaat_cobro_mensual.create
int iCurrent
call super::create
this.dw_consulta=create dw_consulta
this.cb_cobrar=create cb_cobrar
this.cb_salir=create cb_salir
this.st_proceso=create st_proceso
this.cb_buscar=create cb_buscar
this.cb_listado=create cb_listado
this.dw_3=create dw_3
this.cb_aumentar=create cb_aumentar
this.cb_disminuir=create cb_disminuir
this.sle_imprimir_copias=create sle_imprimir_copias
this.st_3=create st_3
this.st_2=create st_2
this.sle_imprimir_originales=create sle_imprimir_originales
this.cb_disminuir_copias=create cb_disminuir_copias
this.cb_aumentar_copias=create cb_aumentar_copias
this.dw_1=create dw_1
this.cb_domiciliaciones=create cb_domiciliaciones
this.dw_lista=create dw_lista
this.dw_pago=create dw_pago
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_consulta
this.Control[iCurrent+2]=this.cb_cobrar
this.Control[iCurrent+3]=this.cb_salir
this.Control[iCurrent+4]=this.st_proceso
this.Control[iCurrent+5]=this.cb_buscar
this.Control[iCurrent+6]=this.cb_listado
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.cb_aumentar
this.Control[iCurrent+9]=this.cb_disminuir
this.Control[iCurrent+10]=this.sle_imprimir_copias
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.sle_imprimir_originales
this.Control[iCurrent+14]=this.cb_disminuir_copias
this.Control[iCurrent+15]=this.cb_aumentar_copias
this.Control[iCurrent+16]=this.dw_1
this.Control[iCurrent+17]=this.cb_domiciliaciones
this.Control[iCurrent+18]=this.dw_lista
this.Control[iCurrent+19]=this.dw_pago
this.Control[iCurrent+20]=this.gb_1
end on

on w_musaat_cobro_mensual.destroy
call super::destroy
destroy(this.dw_consulta)
destroy(this.cb_cobrar)
destroy(this.cb_salir)
destroy(this.st_proceso)
destroy(this.cb_buscar)
destroy(this.cb_listado)
destroy(this.dw_3)
destroy(this.cb_aumentar)
destroy(this.cb_disminuir)
destroy(this.sle_imprimir_copias)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_imprimir_originales)
destroy(this.cb_disminuir_copias)
destroy(this.cb_aumentar_copias)
destroy(this.dw_1)
destroy(this.cb_domiciliaciones)
destroy(this.dw_lista)
destroy(this.dw_pago)
destroy(this.gb_1)
end on

event open;call super::open;f_centrar_ventana(this)

dw_consulta.insertrow(0)
dw_pago.insertrow(0)

dw_pago.SetItem(1,'fecha_pago',DateTime(Today(),Now()))

g_cobro_mensual_musaat_lr = 'S'
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_musaat_cobro_mensual
integer x = 2126
integer y = 1364
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_musaat_cobro_mensual
integer x = 2135
integer y = 1232
integer taborder = 0
end type

type dw_consulta from u_dw within w_musaat_cobro_mensual
integer x = 18
integer y = 32
integer width = 1458
integer height = 420
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_musaat_cobro_mensual_consulta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

type cb_cobrar from commandbutton within w_musaat_cobro_mensual
integer x = 512
integer y = 1756
integer width = 421
integer height = 100
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generar &Facturas"
end type

event clicked;// *** Este proceso genera los avisos de musaat correspondientes para los contratos recuperados
// *** A la vez se cobran los avisos, con lo que se generan las facturas, los movimientos de musaat
// *** y se realiza el paso previa para poder domiciliar las facturas.

string mensaje, id_col, id_fase, id_cliente_mayor_porc, primer_id_factura= '' , ultimo_id_factura = ''
double musaat = 0, total_musaat = 0, porc_cli_mayor = 0, fact_gen = 0
int i, j, retorno
st_musaat_datos st_musaat_datos
datastore ds_colegiados, ds_clientes

setpointer(hourglass!)

dw_pago.accepttext()

st_proceso.text = 'Validando entrada ...'
mensaje = mensaje + f_valida(dw_pago,'fecha_pago','NONULO','Debe especificar la fecha de pago.')
mensaje = mensaje + f_valida(dw_pago,'forma_pago','NONULO','Debe especificar la forma de pago.')
mensaje = mensaje + f_valida(dw_pago,'banco','NONULO','Debe especificar el banco.')
//mensaje = mensaje + f_valida(dw_pago,'asunto','NONULO','Debe especificar el concepto.')

if mensaje<>'' Then
	Messagebox(g_titulo,mensaje,StopSign!)
	st_proceso.text = ''
	return
end if

// Se procede a procesar los contratos recuperados
for i=1 to dw_1.rowcount()
	st_proceso.text = 'Procesando ' + string(i) + ' de ' + string(dw_1.rowcount()) + '. Facturas generadas: ' + string(fact_gen)
	// Si se ha desmarcado no se procesa
	if dw_1.getitemstring(i, 'procesar')='N' then continue
	musaat = 0 // Vaciamos el valor del contrato anterior
	id_fase = dw_1.getitemstring(i, 'id_fase')
	g_id_fase = id_fase // Damos valor a esta variable para el insert de la funci$$HEX1$$f300$$ENDHEX$$n
	
	// Pasando el id_fase y poniendo a true la variable recuperar en la funci$$HEX1$$f300$$ENDHEX$$n de
	// calcular la prima ya recupera todos los datos necesarios para el c$$HEX1$$e100$$ENDHEX$$lculo
	st_musaat_datos.n_visado = id_fase
	st_musaat_datos.recuperar = true

	// Datastore para recuperar los colegiados del contrato
	ds_colegiados = create datastore
	ds_colegiados.dataobject = 'd_fases_colegiados'
	ds_colegiados.settransobject(sqlca)
	ds_colegiados.retrieve(id_fase)

	// Datastore para recuperar los clientes del contrato para coger el promotor de mayor % para el aviso
	ds_clientes = create datastore
	ds_clientes.dataobject = 'd_fases_promotores'
	ds_clientes.settransobject(sqlca)
	ds_clientes.retrieve(id_fase)
	
	for j = 1 to ds_clientes.rowcount()
		if ds_clientes.getitemnumber(j, 'porcen') > porc_cli_mayor then
			id_cliente_mayor_porc = ds_clientes.getitemstring(j, 'id_cliente')
		end if
	next
	
	// Se procesan los colegiados del contrato
	for j = 1 to ds_colegiados.rowcount()
		id_col = ds_colegiados.getitemstring(j, 'id_col')
		st_musaat_datos.id_col = id_col
		// Ponemos a 0 estas dos variables para que recupere los valores en la funci$$HEX1$$f300$$ENDHEX$$n
		st_musaat_datos.cobertura = 0
		st_musaat_datos.porcentaje = 0
		// Le pasamos en la estructura si el colegiado es funcionario
		st_musaat_datos.funcionario = ds_colegiados.getitemstring(j, 'facturado')
		// Vaciamos el mensaje para cada llamada a la funci$$HEX1$$f300$$ENDHEX$$n
		st_musaat_datos.mensaje = ''
		// La funci$$HEX1$$f300$$ENDHEX$$n de calcular es diferente si es sociedad o no
		if f_colegiado_tipopersona(id_col) = 'S' then
			f_musaat_calcula_prima_sociedad(st_musaat_datos)
			// Ponemos a 0 la prima para que no coja un valor anterior si ha dado alg$$HEX1$$fa00$$ENDHEX$$n mensaje de errror
			if st_musaat_datos.mensaje <> '' then st_musaat_datos.prima_comp = 0
		else
			f_musaat_calcula_prima(st_musaat_datos)
			// Ponemos a 0 la prima para que no coja un valor anterior si ha dado alg$$HEX1$$fa00$$ENDHEX$$n mensaje de errror			
			if st_musaat_datos.mensaje <> '' then st_musaat_datos.prima_comp = 0
		end if
		musaat = st_musaat_datos.prima_comp
		// Si hay mas de un movimiento y suman mas de 1 euro no se hace nada
		if f_tiene_movi_musaat(id_fase, id_col, false) and (f_total_movimientos_colegiado(id_col, id_fase) > 1) then musaat = 0
		if musaat > 0 then // Generar avisos y facturas
			g_return_f_factura = '' // Vaciamos el posible id de la factura anterior
			// Llamamos a la funci$$HEX1$$f300$$ENDHEX$$n que genera los avisos con las variables de facturaci$$HEX1$$f300$$ENDHEX$$n a true pq siempre se factura
			f_cobrar_musaat_contrato(st_proceso, dw_pago, id_col, 0, musaat, dw_3, true, & 
			Integer(sle_imprimir_originales.text), Integer(sle_imprimir_copias.text), true, id_cliente_mayor_porc)
			// Si se ha creado una factura obtenemos el id para generar los cobros domiciliables
			if not f_es_vacio(g_return_f_factura) then
				if g_return_f_factura <> '-1' then 
					parent.Event csd_generar_linea_cobro_domiciliable(g_return_f_factura)
					if primer_id_factura = '' then primer_id_factura = g_return_f_factura
					ultimo_id_factura = g_return_f_factura
					fact_gen ++
				end if
			end if
		end if
	next
	destroy ds_colegiados
	destroy ds_clientes
next

st_proceso.text = 'Proceso Finalizado'  + '. Facturas emitidas: ' + string(fact_gen)
MessageBox(g_titulo, 'Proceso finalizado. '+string(fact_gen)+ ' facturas.' + cr +&
				+ 'Rango de facturas emitidas: ' + f_dame_n_fact_de_id(primer_id_factura) + ' - '  +&
				+ f_dame_n_fact_de_id(ultimo_id_factura), Information!)

cb_domiciliaciones.enabled = true
this.enabled = false

end event

type cb_salir from commandbutton within w_musaat_cobro_mensual
integer x = 2926
integer y = 1756
integer width = 421
integer height = 100
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
boolean cancel = true
end type

event clicked;g_cobro_mensual_musaat_lr = 'N'
close(parent)
end event

type st_proceso from statictext within w_musaat_cobro_mensual
integer x = 37
integer y = 1652
integer width = 1189
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_buscar from commandbutton within w_musaat_cobro_mensual
integer x = 37
integer y = 468
integer width = 421
integer height = 100
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

event clicked;string mensaje='', sql_nuevo, sql_orig
datetime f_desde, f_hasta

SetPointer(HourGlass!)
sql_nuevo = dw_1.describe("datawindow.table.select")
sql_orig = sql_nuevo
dw_consulta.accepttext()
dw_1.reset()

f_sql('fases.f_visado','>=','f_desde',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('fases.f_visado','<','f_hasta',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('expedientes.n_expedi','>=','exp_desde',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('expedientes.n_expedi','<=','exp_hasta',dw_consulta,sql_nuevo,g_tipo_base_datos,'')


if sql_nuevo=sql_orig then 
	MessageBox(g_titulo,'Ha de especificar al menos un par$$HEX1$$e100$$ENDHEX$$metro de b$$HEX1$$fa00$$ENDHEX$$squeda')
	return
end if


dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")

st_proceso.text = 'Recuperando Contratos...'
dw_1.retrieve()

dw_1.modify("datawindow.table.select= ~"" + sql_orig + "~"")

// Llamamos al evento que calcular$$HEX2$$e1002000$$ENDHEX$$la MUSAAT para los contratos recuperados
st_proceso.text = 'Calculando Musaat...'
parent.event csd_calcular_musaat()
st_proceso.text = ''

end event

type cb_listado from commandbutton within w_musaat_cobro_mensual
integer x = 37
integer y = 1756
integer width = 421
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Listado"
end type

event clicked;st_proceso.text = 'Imprimiendo listado...'
if dw_1.rowcount() > 0 then dw_1.print()
st_proceso.text = ''

end event

type dw_3 from u_dw within w_musaat_cobro_mensual
boolean visible = false
integer x = 1938
integer y = 736
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_factu_minutas_detalle"
end type

type cb_aumentar from commandbutton within w_musaat_cobro_mensual
integer x = 3255
integer y = 124
integer width = 64
integer height = 44
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "+"
end type

event clicked;if sle_imprimir_originales.text < '98' then
	sle_imprimir_originales.text= string(integer(sle_imprimir_originales.text) + 1 , '00')
end if
end event

type cb_disminuir from commandbutton within w_musaat_cobro_mensual
integer x = 3255
integer y = 172
integer width = 64
integer height = 44
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "-"
end type

event clicked;if sle_imprimir_originales.text > '00' then
	sle_imprimir_originales.text= string(integer(sle_imprimir_originales.text) - 1 , '00')
end if
end event

type sle_imprimir_copias from singlelineedit within w_musaat_cobro_mensual
integer x = 3136
integer y = 248
integer width = 105
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "01"
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

event losefocus;this.text= string(integer(this.text) , '00')

end event

type st_3 from statictext within w_musaat_cobro_mensual
integer x = 2802
integer y = 264
integer width = 311
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$ba002000$$ENDHEX$$Copias :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_musaat_cobro_mensual
integer x = 2802
integer y = 136
integer width = 311
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$ba002000$$ENDHEX$$Originales :"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_imprimir_originales from singlelineedit within w_musaat_cobro_mensual
integer x = 3136
integer y = 128
integer width = 105
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "01"
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

event losefocus;this.text= string(integer(this.text) , '00')

end event

type cb_disminuir_copias from commandbutton within w_musaat_cobro_mensual
integer x = 3255
integer y = 292
integer width = 64
integer height = 44
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "-"
end type

event clicked;if sle_imprimir_copias.text > '00' then
	sle_imprimir_copias.text= string(integer(sle_imprimir_copias.text) - 1 , '00')
end if
end event

type cb_aumentar_copias from commandbutton within w_musaat_cobro_mensual
integer x = 3255
integer y = 244
integer width = 64
integer height = 44
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "+"
end type

event clicked;if sle_imprimir_copias.text < '98' then
	sle_imprimir_copias.text= string(integer(sle_imprimir_copias.text) + 1 , '00')
end if
end event

type dw_1 from u_dw within w_musaat_cobro_mensual
integer x = 37
integer y = 608
integer width = 3310
integer height = 1008
integer taborder = 0
string dataobject = "d_musaat_cobro_mensual_lista_contratos"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;//this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)
// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

type cb_domiciliaciones from commandbutton within w_musaat_cobro_mensual
integer x = 987
integer y = 1756
integer width = 594
integer height = 100
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Generar &Domiciliaciones"
end type

event clicked;st_cobros_datos_pre_remesa datos

datos.dw_lista = dw_lista
datos.modulo='COLEGIADOS'

OpenWithParm(w_cobros_pre_remesa,datos)
end event

type dw_lista from u_dw within w_musaat_cobro_mensual
boolean visible = false
integer x = 2336
integer y = 736
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_colegiados_lista_cobros_domiciliables"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type dw_pago from u_dw within w_musaat_cobro_mensual
integer x = 1509
integer y = 76
integer width = 1289
integer height = 332
integer taborder = 30
string dataobject = "d_pago_facturas"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

this.object.asunto_t.visible = false
this.object.asunto.visible = false
end event

type gb_1 from groupbox within w_musaat_cobro_mensual
integer x = 1499
integer y = 32
integer width = 1870
integer height = 392
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Datos Factura"
borderstyle borderstyle = stylelowered!
end type

