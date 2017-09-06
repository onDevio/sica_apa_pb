HA$PBExportHeader$w_factufa_facturas_sin_liquidar.srw
forward
global type w_factufa_facturas_sin_liquidar from w_response
end type
type dw_liquidacion from u_dw within w_factufa_facturas_sin_liquidar
end type
type cb_actualizar from commandbutton within w_factufa_facturas_sin_liquidar
end type
type cb_cerrar from commandbutton within w_factufa_facturas_sin_liquidar
end type
type cb_liquidar from commandbutton within w_factufa_facturas_sin_liquidar
end type
type dw_lista_facturas from u_dw within w_factufa_facturas_sin_liquidar
end type
type st_1 from statictext within w_factufa_facturas_sin_liquidar
end type
type gb_2 from groupbox within w_factufa_facturas_sin_liquidar
end type
end forward

global type w_factufa_facturas_sin_liquidar from w_response
integer width = 4032
integer height = 1848
string title = "Descontar Facturas de Liquidaci$$HEX1$$f300$$ENDHEX$$n"
boolean controlmenu = false
event type integer csd_recalcular_liquidacion ( )
dw_liquidacion dw_liquidacion
cb_actualizar cb_actualizar
cb_cerrar cb_cerrar
cb_liquidar cb_liquidar
dw_lista_facturas dw_lista_facturas
st_1 st_1
gb_2 gb_2
end type
global w_factufa_facturas_sin_liquidar w_factufa_facturas_sin_liquidar

type variables
st_facturas i_datos_fase
end variables

event type integer csd_recalcular_liquidacion();int linea
double deuda = 0,neto, importe
string id_liquidacion,liq_nula,id_factura,id_col,formapago

dw_lista_facturas.accepttext()

linea = Message.WordParm

id_liquidacion = dw_liquidacion.GetItemString(1,'id_liquidacion')
deuda = dw_liquidacion.getitemnumber(1,'deuda_facturas')
neto = dw_liquidacion.GetItemnumber(1,'importe')
if isnull(deuda) then deuda = 0

if dw_lista_facturas.GetItemString(linea,'incluir')='S' then 
	deuda = deuda + dw_lista_facturas.GetItemNumber(linea,'total')
	neto = neto - dw_lista_facturas.GetItemNumber(linea,'total')
else
	deuda = deuda - dw_lista_facturas.GetItemNumber(linea,'total')
	neto = neto + dw_lista_facturas.GetItemNumber(linea,'total')
end if


//neto = dw_liquidacion.getitemnumber(1,'importe_suma') - dw_liquidacion.getitemnumber(1,'importe_resta') - deuda



//select importe into :importe from fases_liquidaciones where id_liquidacion = :id_liquidacion ;
//neto = f_redondea ( importe - deuda )

//if neto<0 then
//	MessageBox(g_titulo,'El importe de la liquidacion NO puede ser negativo. Modifique la liquidaci$$HEX1$$f300$$ENDHEX$$n')
//	return -1
//end if
//
dw_liquidacion.SetItem(1,'deuda_facturas',deuda)
dw_liquidacion.SetItem(1,'importe',neto)
return 1

end event

on w_factufa_facturas_sin_liquidar.create
int iCurrent
call super::create
this.dw_liquidacion=create dw_liquidacion
this.cb_actualizar=create cb_actualizar
this.cb_cerrar=create cb_cerrar
this.cb_liquidar=create cb_liquidar
this.dw_lista_facturas=create dw_lista_facturas
this.st_1=create st_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_liquidacion
this.Control[iCurrent+2]=this.cb_actualizar
this.Control[iCurrent+3]=this.cb_cerrar
this.Control[iCurrent+4]=this.cb_liquidar
this.Control[iCurrent+5]=this.dw_lista_facturas
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.gb_2
end on

on w_factufa_facturas_sin_liquidar.destroy
call super::destroy
destroy(this.dw_liquidacion)
destroy(this.cb_actualizar)
destroy(this.cb_cerrar)
destroy(this.cb_liquidar)
destroy(this.dw_lista_facturas)
destroy(this.st_1)
destroy(this.gb_2)
end on

event open;call super::open;int i
string estado, ls_id_minuta


i_datos_fase = Message.PowerObjectParm

f_centrar_ventana(this)

//dw_liq_pendientes.Retrieve(i_datos_fase.id_receptor)

if not(f_es_vacio(i_datos_fase.id_liquidacion)) then
	dw_liquidacion.Retrieve(i_datos_fase.id_liquidacion)
//	for i=1 to dw_liq_pendientes.rowcount()
//		if dw_liq_pendientes.GetItemString(i,'id_liquidacion')=i_datos_fase.id_liquidacion then 
//			dw_liq_pendientes.SetRow(i)
//			dw_liq_pendientes.SetFocus()
//		end if
//	next
	ls_id_minuta = dw_liquidacion.GetItemString(1,'id_fase')
	i_datos_fase.id_minuta = f_minutas_id_fase (ls_id_minuta)
else
//	dw_liq_pendientes.SetRow(1)	
//	dw_liquidacion.Retrieve(dw_liq_pendientes.GetItemString(1,'id_liquidacion'))
//	i_datos_fase.id_liquidacion = dw_liq_pendientes.GetItemString(1,'id_liquidacion')
//	ls_id_minuta = dw_liquidacion.GetItemString(1,'id_fase')
//	i_datos_fase.id_fase = ls_id_minuta
//	i_datos_fase.id_minuta = f_minutas_id_fase (ls_id_minuta)
closewithreturn(this, -1)
end if

dw_lista_facturas.Retrieve(i_datos_fase.id_receptor, i_datos_fase.id_minuta, i_datos_fase.id_fase )

estado = dw_liquidacion.GetItemString(1,'estado')

//for i = 1 to dw_lista_facturas.rowcount()
//	if dw_lista_facturas.GetItemString(i,'id_liquidacion')= i_datos_fase.id_liquidacion then
//			dw_lista_facturas.SetItem(i,'incluir','S')
//			dw_lista_facturas.ResetUpdate()
//	end if
//next

//Si la liquidaci$$HEX1$$f300$$ENDHEX$$n no est$$HEX2$$e1002000$$ENDHEX$$pendiente NO se puede modificar porque ya ha sido liquidada
//o est$$HEX2$$e1002000$$ENDHEX$$anulada
if estado<>'P' then
	cb_liquidar.enabled = false
	dw_lista_facturas.enabled=false
	cb_actualizar.enabled=false
else
	cb_liquidar.enabled = true
end if

end event

event pfc_preupdate;call super::pfc_preupdate;if dw_liquidacion.GetItemNumber(1,'importe')<0 then
	MessageBox(g_titulo,'La liquidaci$$HEX1$$f300$$ENDHEX$$n es negativa. No se guardar$$HEX1$$e100$$ENDHEX$$n los cambios')
	return -1
end if
return 1

end event

event pfc_save;call super::pfc_save;cb_actualizar.event clicked()
return 1
end event

event close;// No recoge el master para evitar que compruebe si se han de guardar datos. 

return 1
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_factufa_facturas_sin_liquidar
integer x = 3323
integer y = 2024
integer width = 73
integer height = 56
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_factufa_facturas_sin_liquidar
integer x = 3310
integer y = 1708
integer width = 82
integer height = 52
end type

type dw_liquidacion from u_dw within w_factufa_facturas_sin_liquidar
integer width = 3877
integer height = 320
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_factufa_liquidacion"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;//choose case dwo.name
//	case 'estado'
//		if data<>'P' then
//			dw_lista_facturas.enabled=false
//			cb_actualizar.enabled=false
//		else
//			dw_lista_facturas.enabled=true
//			cb_actualizar.enabled=true
//		end if
//end choose
end event

type cb_actualizar from commandbutton within w_factufa_facturas_sin_liquidar
integer x = 1879
integer y = 1664
integer width = 402
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Actualizar"
end type

event clicked;int i,linea,dw,j, li_result_prof_to_fact
double deuda = 0,importe_resta = 0 ,importe_suma=0,neto, ld_deuda_facturas, ld_deuda_antigua, ld_total_antiguo
string id_liquidacion,liq_nula,id_factura,id_col,formapago, ls_banco, ls_proforma, ls_id_minuta
datetime f_nula,hoy
boolean lb_fallo_proformas = false
st_datos_facturas_proforma st_datos
n_csd_facturacion_proformas luo_facturacion_proforma

luo_facturacion_proforma  = create n_csd_facturacion_proformas

hoy = datetime(Today())
id_liquidacion = dw_liquidacion.GetItemString(1,'id_liquidacion')
neto = dw_liquidacion.getitemnumber(1,'importe')
ld_deuda_facturas = dw_liquidacion.GetItemnumber(1,'deuda_facturas')
if isnull(ld_deuda_facturas) then 
	ld_deuda_facturas = 0
end if

select importe into :ld_total_antiguo
from fases_liquidaciones where id_liquidacion = :id_liquidacion;

if neto<0 then
	MessageBox(g_titulo,'El importe de la liquidacion NO puede ser negativo. Modifique la liquidaci$$HEX1$$f300$$ENDHEX$$n')
	return -1
end if

ld_deuda_antigua = f_liquidacion_total_facturas_deducidas(id_liquidacion)

if isnull(ld_deuda_antigua) then 
	ld_deuda_antigua = 0
end if

for i= 1 to dw_lista_facturas.rowcount()
	if dw_lista_facturas.GetItemString(i,'incluir')='N' then continue
	
	deuda = deuda + dw_lista_facturas.GetItemnumber(i,'total')
	
	id_factura = dw_lista_facturas.GetItemString(i,'id_factura')
	//ld_deuda_facturas = ld_deuda_facturas + dw_lista_facturas.GetItemnumber(i,'total')
		
	///***SCP-663. Alexis. Se facturan las proformas***///
	SELECT csi_formas_de_pago.banco_asociado  
	INTO :ls_banco  
	FROM csi_formas_de_pago  
	WHERE csi_formas_de_pago.tipo_pago = :g_formas_pago.cargo ;
	
	 ls_proforma = dw_lista_facturas.GetItemString(i,'proforma')
	 if ls_proforma = 'S' then
		st_datos.lista_id_factura = id_factura
		st_datos.banco = ls_banco
		st_datos.fecha_facturacion = datetime(today())
		st_datos.fecha_pago = datetime(today())
		st_datos.forma_pago = g_formas_pago.cargo
		st_datos.pagado = 'S'
		st_datos.cobros_a_cero = 'N'
		st_datos.id_liquidacion = id_liquidacion
		luo_facturacion_proforma.of_init(st_datos)
		li_result_prof_to_fact = luo_facturacion_proforma.wf_factura( )
		
		if li_result_prof_to_fact < 1 then
			lb_fallo_proformas = true
			deuda = deuda - dw_lista_facturas.GetItemnumber(i,'total')
			ld_deuda_facturas = ld_deuda_facturas - dw_lista_facturas.GetItemnumber(i,'total')
			dw_liquidacion.setitem(1, 'deuda_facturas', ld_deuda_facturas)
			neto = neto + dw_lista_facturas.GetItemnumber(i,'total')
			dw_liquidacion.setitem(1, 'importe', neto)
		end if
		
	else
	//SCP-405
		//dw_lista_facturas.SetItem(i,'formadepago',g_formas_pago.liquidacion)
		dw_lista_facturas.SetItem(i,'formadepago',g_formas_pago.cargo)
		//Fin SCP-405
		dw_lista_facturas.SetItem(i,'asunto','Factura inclu$$HEX1$$ed00$$ENDHEX$$da en la liquidaci$$HEX1$$f300$$ENDHEX$$n : ' + id_liquidacion)
		dw_lista_facturas.SetItem(i,'id_liquidacion',id_liquidacion)
		dw_lista_facturas.SetItem(i,'f_pago',datetime(Today()))
		dw_lista_facturas.SetItem(i,'pagado','S')
		update csi_cobros
		//SCP-405
		//set forma_pago = :g_formas_pago.liquidacion, pagado = 'S', f_pago = :hoy  
		set forma_pago = :g_formas_pago.cargo, pagado = 'S', f_pago = :hoy 
		//Fin SCP-405
		where id_factura = :id_factura ;
	end if
next

if lb_fallo_proformas = true then
	messagebox (g_titulo, "Alguna de las proformas seleccionadas no pudieron transformarse en facturas." + CR+ "No han sido a$$HEX1$$f100$$ENDHEX$$adidas a la liquidaci$$HEX1$$f300$$ENDHEX$$n", Exclamation!, OK!)
end if	

//deuda = deuda + ld_deuda_antigua

if round(deuda + ld_deuda_antigua,2) <> round(ld_deuda_facturas,2) then
	if (messagebox(g_titulo, "El total de la deuda de las facturas asciende a: " + string(deuda + ld_deuda_antigua) + " euros."+ CR +"$$HEX1$$bf00$$ENDHEX$$Desea actualizar el total de la deuda por facturas a$$HEX1$$f100$$ENDHEX$$adidas?", Exclamation!, YesNo!, 2) = 1) then
		dw_liquidacion.setItem(1,'deuda_facturas', deuda + ld_deuda_antigua)
		ld_total_antiguo = ld_total_antiguo - deuda
		dw_liquidacion.setItem(1,'importe', ld_total_antiguo)
	end if	
end if	

//dw_liquidacion.setitem(1, 'deuda_facturas', ld_deuda_facturas)

dw_lista_facturas.Update()
dw_liquidacion.Update()

//dw_lista_facturas.Retrieve(i_datos_fase.id_receptor, i_datos_fase.id_minuta, i_datos_fase.id_fase )
Close(parent)


end event

type cb_cerrar from commandbutton within w_factufa_facturas_sin_liquidar
integer x = 2729
integer y = 1664
integer width = 402
integer height = 80
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
boolean cancel = true
end type

event clicked;Close(parent)
end event

type cb_liquidar from commandbutton within w_factufa_facturas_sin_liquidar
boolean visible = false
integer x = 2304
integer y = 1664
integer width = 402
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Liquidar"
end type

event clicked;//int i
//if dw_liquidacion.GetItemString(1,'estado') <> 'P' then return
//if dw_liquidacion.GetItemNumber(1,'importe')<0 then
//	MessageBox(g_titulo,'La liquidaci$$HEX1$$f300$$ENDHEX$$n es negativa y no puede ser Liquidada')
//	return
//end if
//
//dw_liquidacion.SetItem(1,'estado','L')
//dw_liquidacion.SetItem(1,'f_liquidacion',datetime(Today()))
//
//
////Si las facturas no est$$HEX1$$e100$$ENDHEX$$n pagadas... las pondremos como pagadas...
////Y si no tienen la id_liquidacion... se la colocamos....
//for i= 1 to dw_lista_facturas.rowcount()
//	if dw_lista_facturas.GetItemString(i,'incluir')<>'S' then continue
//	if dw_lista_facturas.GetItemString(i,'pagado')='N' then
//		dw_lista_facturas.SetItem(i,'pagado','S')
//		dw_lista_facturas.SetItem(i,'f_pago',datetime(Today()))
//		dw_lista_facturas.SetItem(i,'id_liquidacion',dw_liquidacion.GetItemString(1,'id_liquidacion'))
//	end if
//next
//
end event

type dw_lista_facturas from u_dw within w_factufa_facturas_sin_liquidar
integer x = 73
integer y = 384
integer width = 3694
integer height = 1120
integer taborder = 20
string title = "Gestion de Liquidaciones"
string dataobject = "d_factufa_facturas_liquidacion"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;parent.PostEvent('csd_recalcular_liquidacion',row,1)

end event

event retrieveend;call super::retrieveend;int li_i
double ld_total, ld_deuda_facturas, ld_total_deuda_ant//, ld_total_deudas

ld_total  = dw_liquidacion.getitemnumber(1,'importe')
ld_total_deuda_ant = dw_liquidacion.getitemnumber(1,'deuda_facturas')

if isnull(ld_total_deuda_ant) then ld_total_deuda_ant = 0

//ld_total_deudas = 0

for li_i =1 to this.rowcount() 
	if this.getitemnumber(li_i, 'compute_2') = 1 then
		ld_deuda_facturas = this.getitemnumber(li_i, 'total')
		if ld_total - ld_deuda_facturas > 0 then
			ld_total_deuda_ant = ld_total_deuda_ant + ld_deuda_facturas
			//ld_total_deudas = ld_total_deudas + ld_deuda_facturas
			ld_total = ld_total - ld_deuda_facturas
			this.setitem(li_i, 'incluir', 'S')
			//dw_liquidacion.setitem(1, 'deuda_facturas', ld_deuda_facturas + dw_liquidacion.getitemnumber(1, 'deuda_facturas'))
		
		end if
	end if	
next

dw_liquidacion.setitem(1, 'importe', ld_total)
dw_liquidacion.setitem(1, 'deuda_facturas', ld_total_deuda_ant )

this.SetSort("compute_1 A, incluir D, total D")
this.sort()
end event

type st_1 from statictext within w_factufa_facturas_sin_liquidar
integer x = 110
integer y = 1568
integer width = 2318
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "La facturas proforma ser$$HEX1$$e100$$ENDHEX$$n pasadas autom$$HEX1$$e100$$ENDHEX$$ticamente a facturas definitivas con su inclusi$$HEX1$$f300$$ENDHEX$$n a la liquidaci$$HEX1$$f300$$ENDHEX$$n"
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_factufa_facturas_sin_liquidar
integer y = 320
integer width = 3840
integer height = 1216
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Facturas Pendientes"
end type

