HA$PBExportHeader$w_saldo_cuenta_bancaria_colegiado.srw
forward
global type w_saldo_cuenta_bancaria_colegiado from w_response
end type
type dw_consulta from u_dw within w_saldo_cuenta_bancaria_colegiado
end type
type cb_3 from commandbutton within w_saldo_cuenta_bancaria_colegiado
end type
type cb_1 from commandbutton within w_saldo_cuenta_bancaria_colegiado
end type
type cb_2 from commandbutton within w_saldo_cuenta_bancaria_colegiado
end type
type dw_extracto from u_dw within w_saldo_cuenta_bancaria_colegiado
end type
type dw_facturas from u_dw within w_saldo_cuenta_bancaria_colegiado
end type
type st_1 from statictext within w_saldo_cuenta_bancaria_colegiado
end type
type st_saldo from statictext within w_saldo_cuenta_bancaria_colegiado
end type
type st_2 from statictext within w_saldo_cuenta_bancaria_colegiado
end type
type st_3 from statictext within w_saldo_cuenta_bancaria_colegiado
end type
type cb_impr from commandbutton within w_saldo_cuenta_bancaria_colegiado
end type
end forward

global type w_saldo_cuenta_bancaria_colegiado from w_response
integer width = 3273
integer height = 2336
string title = "Saldo Cuenta Bancaria Colegiado"
boolean minbox = true
windowtype windowtype = popup!
boolean ib_disableclosequery = true
dw_consulta dw_consulta
cb_3 cb_3
cb_1 cb_1
cb_2 cb_2
dw_extracto dw_extracto
dw_facturas dw_facturas
st_1 st_1
st_saldo st_saldo
st_2 st_2
st_3 st_3
cb_impr cb_impr
end type
global w_saldo_cuenta_bancaria_colegiado w_saldo_cuenta_bancaria_colegiado

type variables
string i_col, i_cuenta, i_formapago, i_contab
datetime i_desde, i_hasta
double i_saldo=0

end variables

on w_saldo_cuenta_bancaria_colegiado.create
int iCurrent
call super::create
this.dw_consulta=create dw_consulta
this.cb_3=create cb_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_extracto=create dw_extracto
this.dw_facturas=create dw_facturas
this.st_1=create st_1
this.st_saldo=create st_saldo
this.st_2=create st_2
this.st_3=create st_3
this.cb_impr=create cb_impr
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_consulta
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_extracto
this.Control[iCurrent+6]=this.dw_facturas
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_saldo
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.cb_impr
end on

on w_saldo_cuenta_bancaria_colegiado.destroy
call super::destroy
destroy(this.dw_consulta)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_extracto)
destroy(this.dw_facturas)
destroy(this.st_1)
destroy(this.st_saldo)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_impr)
end on

event open;call super::open;st_saldo_cuenta_bancaria_colegiado lst_datos_entrada

f_centrar_ventana(this)

dw_consulta.insertrow(0)
dw_extracto.SetTransObject(bd_ejercicio)
dw_facturas.SetTransObject(SQLCA)

if isvalid(message.powerobjectparm) then
	lst_datos_entrada = message.powerobjectparm
	dw_consulta.setitem(1, 'id_colegiado', lst_datos_entrada.id_colegiado)
	dw_consulta.setitem(1, 'n_col', f_colegiado_n_col(lst_datos_entrada.id_colegiado))
	dw_consulta.setitem(1, 'f_desde', lst_datos_entrada.f_desde)
	dw_consulta.setitem(1, 'f_hasta', lst_datos_entrada.f_hasta)
	cb_3.event clicked()
else
	dw_consulta.setitem(1, 'f_desde', datetime(date('01/01/'+g_ejercicio),time('00:00')))
	dw_consulta.setitem(1, 'f_hasta', datetime(Today()))
end if

end event

event pfc_postopen();call super::pfc_postopen;dw_consulta.of_SetDropDownCalendar(True)
dw_consulta.iuo_calendar.of_register(dw_consulta.iuo_calendar.DDLB)
dw_consulta.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_consulta.iuo_calendar.of_SetInitialValue(True)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_saldo_cuenta_bancaria_colegiado
integer x = 2427
integer y = 1824
integer taborder = 30
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_saldo_cuenta_bancaria_colegiado
integer x = 2427
integer y = 1696
end type

type dw_consulta from u_dw within w_saldo_cuenta_bancaria_colegiado
integer x = 37
integer y = 32
integer width = 2423
integer height = 360
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_saldo_cuenta_bancaria_col_consulta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;string id_col

CHOOSE CASE dwo.name
	CASE 'b_busqueda_colegiados'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()
		//Comprobamos que el colegiado existe
		if id_col="-1" then
			messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
			this.setfocus()
			return -1
		else
			this.SetItem(1,'id_colegiado',id_col)
			this.SetItem(1,'n_col',f_colegiado_n_col(id_col))		
			this.SetItem(1,'activo_cp',f_busca_activo_cp( id_col ))
		end if
END CHOOSE

end event

event itemchanged;call super::itemchanged;string id_col

CHOOSE CASE dwo.name
	CASE 'n_col'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_colegiado', id_col)
		this.SetItem(row,'activo_cp',f_busca_activo_cp( id_col ))
		parent.cb_3.triggerevent(clicked!)
END CHOOSE

end event

type cb_3 from commandbutton within w_saldo_cuenta_bancaria_colegiado
integer x = 2290
integer y = 84
integer width = 261
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Saldo"
end type

event clicked;string mensaje=''
double extracto=0, facturas=0

// Validaciones
dw_consulta.accepttext()
mensaje += f_valida(dw_consulta,'f_desde','NONULO','Debe especificar un valor en el campo Fecha Desde.')
mensaje += f_valida(dw_consulta,'f_hasta','NONULO','Debe especificar un valor en el campo Fecha Hasta.')
mensaje += f_valida(dw_consulta,'id_colegiado','NOVACIO','Debe especificar un valor en el campo Colegiado.')

if mensaje <> '' then
	messagebox(g_titulo, mensaje, stopsign!)
	return 
end if

i_col = dw_consulta.getitemstring(1,'id_colegiado')
i_desde = datetime(date(dw_consulta.getitemdatetime(1,'f_desde')), time('00:00:00'))
i_hasta = datetime(date(dw_consulta.getitemdatetime(1,'f_hasta')), time('23:59:59'))

// Recuperamos el extracto de la cuenta bancaria del colegiado
i_cuenta = f_dame_cuenta_col(i_col, g_formas_pago.cuenta_personal)
dw_extracto.retrieve(i_col, i_cuenta, i_desde, i_hasta)

// Saldo anterior
boolean calcular_saldo_anterior = true
double debe_anterior, haber_anterior
if month(date(i_desde)) = 1 and day(date(i_desde)) = 1 then calcular_saldo_anterior = false
if dw_extracto.RowCount() > 0 and calcular_saldo_anterior then
	SELECT sum(apuntes.debe), sum(apuntes.haber) INTO :debe_anterior, :haber_anterior
	FROM cuentas, apuntes
	WHERE (cuentas.cuenta = apuntes.cuenta) AND (cuentas.cuenta like :i_cuenta) 
			AND (cuentas.id_col = :i_col) AND (apuntes.fecha < :i_desde) USING bd_ejercicio;
	dw_extracto.InsertRow(1)
	dw_extracto.SetItem(1,'apuntes_concepto','Saldo anterior...')
	dw_extracto.SetItem(1,'apuntes_debe',debe_anterior)
	dw_extracto.SetItem(1,'apuntes_haber',haber_anterior)
end if


// Recuperamos las facturas con forma pago cuenta personal y no contabilizadas
i_formapago = g_formas_pago.cuenta_personal
i_contab = 'N'

dw_facturas.retrieve(i_col, i_desde, i_hasta, i_formapago, i_contab)


// Obtenemos los totales y el saldo final
if dw_extracto.rowcount()> 0 then extracto = dw_extracto.getitemnumber(dw_extracto.rowcount(), 'compute_5')
if dw_facturas.rowcount()> 0 then facturas = dw_facturas.getitemnumber(dw_facturas.rowcount(), 'compute_1')

i_saldo = extracto + facturas


// Mostramos el resultado
if i_saldo < 0 then
	st_saldo.textcolor = f_color_rojo()
else
	st_saldo.textcolor = f_color_azul()
end if
st_saldo.text = string(i_saldo, "#,##0.00")

end event

type cb_1 from commandbutton within w_saldo_cuenta_bancaria_colegiado
integer x = 2213
integer y = 608
integer width = 256
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Listado"
end type

type cb_2 from commandbutton within w_saldo_cuenta_bancaria_colegiado
integer x = 2194
integer y = 688
integer width = 256
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generar"
end type

type dw_extracto from u_dw within w_saldo_cuenta_bancaria_colegiado
integer x = 37
integer y = 480
integer width = 3154
integer height = 708
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_saldo_cuenta_bancaria_col_extracto"
boolean hscrollbar = true
boolean ib_rmbmenu = false
end type

type dw_facturas from u_dw within w_saldo_cuenta_bancaria_colegiado
integer x = 37
integer y = 1288
integer width = 3154
integer height = 708
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_saldo_cuenta_bancaria_col_facturas"
boolean hscrollbar = true
boolean ib_rmbmenu = false
end type

type st_1 from statictext within w_saldo_cuenta_bancaria_colegiado
integer x = 1783
integer y = 2040
integer width = 535
integer height = 100
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Saldo Final:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_saldo from statictext within w_saldo_cuenta_bancaria_colegiado
integer x = 2345
integer y = 2032
integer width = 571
integer height = 112
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_saldo_cuenta_bancaria_colegiado
integer x = 37
integer y = 1224
integer width = 827
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Facturas Pendientes:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_saldo_cuenta_bancaria_colegiado
integer x = 37
integer y = 416
integer width = 658
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Apuntes Cuenta:"
boolean focusrectangle = false
end type

type cb_impr from commandbutton within w_saldo_cuenta_bancaria_colegiado
integer x = 2555
integer y = 84
integer width = 261
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
end type

event clicked;datawindowchild dwc_extracto, dwc_facturas
datastore ds_impr

ds_impr = create datastore
ds_impr.dataobject = 'd_saldo_cuenta_bancaria_col_impreso'
ds_impr.settransobject(sqlca)

ds_impr.getchild('dw_apuntes', dwc_extracto)
ds_impr.getchild('dw_facturas', dwc_facturas)

dw_extracto.rowscopy(1, dw_extracto.rowcount(), Primary!, dwc_extracto, 1, Primary!)
dw_facturas.rowscopy(1, dw_facturas.rowcount(), Primary!, dwc_facturas, 1, Primary!)

ds_impr.object.colegiado.text = f_colegiado_n_col(i_col) + ' ' + f_colegiado_apellido (i_col)
ds_impr.object.saldo.text = 'Saldo Final: ' + string(i_saldo, "#,##0.00")
ds_impr.print()

end event

