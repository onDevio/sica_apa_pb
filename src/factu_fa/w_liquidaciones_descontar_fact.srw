HA$PBExportHeader$w_liquidaciones_descontar_fact.srw
forward
global type w_liquidaciones_descontar_fact from w_response
end type
type cb_actualiza from commandbutton within w_liquidaciones_descontar_fact
end type
type cb_cerrar from commandbutton within w_liquidaciones_descontar_fact
end type
type st_1 from statictext within w_liquidaciones_descontar_fact
end type
type cb_previzualiza from commandbutton within w_liquidaciones_descontar_fact
end type
type cb_imprimir from commandbutton within w_liquidaciones_descontar_fact
end type
type dw_1 from u_dw within w_liquidaciones_descontar_fact
end type
type dw_listado from u_dw within w_liquidaciones_descontar_fact
end type
end forward

global type w_liquidaciones_descontar_fact from w_response
integer x = 23
integer width = 3584
integer height = 2220
string title = "Descontar Facturas  de Liquidaciones"
event csd_liquidar_facturas ( )
cb_actualiza cb_actualiza
cb_cerrar cb_cerrar
st_1 st_1
cb_previzualiza cb_previzualiza
cb_imprimir cb_imprimir
dw_1 dw_1
dw_listado dw_listado
end type
global w_liquidaciones_descontar_fact w_liquidaciones_descontar_fact

type variables
st_facturas i_datos_fase
end variables

forward prototypes
public subroutine wf_descontar_facturas (string id_colegiado, string id_factura)
end prototypes

event csd_liquidar_facturas();// Evento : csd_liquidar_facturas
//
int i,j, ll_retrieve, ll_new
string id_liquidacion, id_colegiado
double ld_importe_liquidacion, ld_total_fact, ld_cobro_pendiente
datastore ds_liquidaciones, ds_cobros

//
//dw_listado.retrieve()
// Contiene las liquidaciones de los colegiados
ds_liquidaciones =  create datastore
ds_liquidaciones.dataobject= 'd_liquidacion_pend_lista'
ds_liquidaciones.SetTransObject(SQLCA)
ll_retrieve = ds_liquidaciones.retrieve()

// Contiene los cobros de las facturas
ds_cobros	=  create datastore
ds_cobros.dataobject= 'd_cobros_frecibidas'
ds_cobros.SetTransObject(SQLCA)
SetPointer(Hourglass!)

for i = 1 to ds_liquidaciones.rowcount()
	yield()
	id_liquidacion 				= ds_liquidaciones.GetItemString(i,'id_liquidacion')
	ld_importe_liquidacion 	= ds_liquidaciones.getitemdecimal(i, 'importe')
	id_colegiado 				= ds_liquidaciones.GetItemString(i,'id_colegiado')
	
	dw_1.setfilter("colegiados_id_colegiado = '"+id_colegiado +"'")
	dw_1.filter()
	for j= 1 to dw_1.rowcount()
		if dw_1.getitemstring(j, 'incluir') = 'N' then continue
		ld_total_fact = dw_1.getitemdecimal(j, 'csi_facturas_emitidas_total')
		if ld_importe_liquidacion >=  ld_total_fact then
			ds_cobros.retrieve(dw_1.getitemstring(j, 'id_factura'))
			
			// CASO EN DONDE EL IMPORTE DE LA LIQUIDACI$$HEX1$$d300$$ENDHEX$$N PAGA LA FACTURA
			ll_new = dw_listado.insertrow(0)
			dw_listado.SetItem(ll_new,'formadepago',g_formas_pago.liquidacion)
			dw_listado.SetItem(ll_new,'asunto','Factura inclu$$HEX1$$ed00$$ENDHEX$$da en la liquidaci$$HEX1$$f300$$ENDHEX$$n : ' + id_liquidacion)
			dw_listado.setitem(ll_new, 'importe', ld_importe_liquidacion)
			//SE ACTUALIZA EL IMPORTE DE LA LIQUIDACI$$HEX1$$d300$$ENDHEX$$N
			ld_importe_liquidacion = ld_importe_liquidacion - ld_total_fact
			
			dw_listado.setitem(ll_new, 'importe_neto', ld_importe_liquidacion) // Importe a descontar
			
			//SE ACTUALIZA EL COBRO DE LA FACTURA
			ds_cobros.setitem(1,'forma_pago', g_formas_pago.liquidacion)
			ds_cobros.setitem(1,'pagado', 'S')
			ds_cobros.setitem(1,'f_pago', datetime(Today()))
			
			dw_listado.SetItem(ll_new,'csi_facturas_emitidas_total',ld_total_fact)
			dw_listado.SetItem(ll_new,'n_fact', dw_1.getitemstring(j, 'csi_facturas_emitidas_n_fact'))
			dw_listado.SetItem(ll_new,'csi_facturas_emitidas_id_fase', dw_1.getitemstring(j, 'csi_facturas_emitidas_id_fase'))
			dw_listado.SetItem(ll_new,'base_imp',dw_1.getitemdecimal(j, 'csi_facturas_emitidas_base_imp'))
			dw_listado.SetItem(ll_new,'iva',dw_1.getitemdecimal(j, 'csi_facturas_emitidas_iva'))
			dw_listado.SetItem(ll_new,'colegiados_apellidos',dw_1.getitemstring(j, 'colegiados_apellidos'))
			dw_listado.SetItem(ll_new,'colegiados_nombre',dw_1.getitemstring(j, 'colegiados_nombre'))
			dw_listado.SetItem(ll_new,'colegiados_id_colegiado',dw_1.getitemstring(j, 'colegiados_id_colegiado'))
			dw_listado.SetItem(ll_new,'csi_facturas_emitidas_fecha',dw_1.getitemdatetime(j, 'csi_facturas_emitidas_fecha'))
			dw_listado.SetItem(ll_new,'id_liquidacion',id_liquidacion)
			dw_listado.SetItem(ll_new,'f_pago',datetime(Today()))
			dw_listado.SetItem(ll_new,'pagado','S')
			
		else 
			j = dw_1.rowcount()
			continue
			// SE COMENTO PARA HACER SOLO PAGOS COMPLETOS
			// SI HAY ALGO DE LA LIQUIDACI$$HEX1$$d300$$ENDHEX$$N DEBE SER UN PAGO PARCIAL DE LA FACTURA Y OTRO PENDIENTE
		//	ld_cobro_pendiente = ld_total_fact -ld_importe_liquidacion
//			ld_importe_liquidacion = 0
//			dw_1.SetItem(i,'formadepago',g_formas_pago.fraccionada)
//			dw_1.SetItem(i,'asunto','Factura inclu$$HEX1$$ed00$$ENDHEX$$da en la liquidaci$$HEX1$$f300$$ENDHEX$$n : ' + id_liquidacion)
			// SE INSERTA COBRO POR EL RESTANTE PENDIENTE DE LA FACTURA Y SE ACTUALIZA EL COBRO 
			     
		end if
		dw_listado.SetItemStatus(ll_new,0,Primary!, NotModified!)
	next
	ds_liquidaciones.setitem(i, 'importe', ld_importe_liquidacion)
	
	dw_1.setfilter("")
	dw_1.filter()
	
	for j=1 to dw_1.RowCount()
		dw_1.SetItemStatus(j,0,Primary!, NotModified!)
	next
next



//ds_liquidaciones.update()
//ds_cobros.update()
//dw_1.update()
//dw_listado.setfilter("pagado = '" +'S' +"'" )
//dw_listado.filter()

destroy ds_liquidaciones
destroy ds_cobros





end event

public subroutine wf_descontar_facturas (string id_colegiado, string id_factura);int i,j, ll_retrieve
string id_liquidacion
double ld_importe_liquidacion, ld_total_fact, ld_cobro_pendiente
datastore ds_liquidaciones, ds_cobros

// Contiene las liquidaciones de los colegiados
ds_liquidaciones =  create datastore
ds_liquidaciones.dataobject= 'd_factufa_liquidaciones_pendientes'
ds_liquidaciones.SetTransObject(SQLCA)
ll_retrieve = ds_liquidaciones.retrieve(id_colegiado)

// Contiene los cobros de las facturas
ds_cobros	=  create datastore
ds_cobros.dataobject= 'd_cobros_frecibidas'
ds_cobros.SetTransObject(SQLCA)

dw_1.setfilter("colegiados_id_colegiado = '"+id_colegiado +"'")
dw_1.filter()
for i = 1 to ds_liquidaciones.rowcount()
	id_liquidacion 				= ds_liquidaciones.GetItemString(i,'id_liquidacion')
	ld_importe_liquidacion 	= ds_liquidaciones.getitemdecimal(i, 'importe')
	
	for j= 1 to dw_1.rowcount()
		
		ld_total_fact = dw_1.getitemdecimal(j, 'csi_facturas_emitidas_total')
		if ld_importe_liquidacion >=  ld_total_fact then
			ds_cobros.retrieve(dw_1.getitemstring(j, 'id_factura'))
			// CASO EN DONDE EL IMPORTE DE LA LIQUIDACI$$HEX1$$d300$$ENDHEX$$N PAGA LA FACTURA
			dw_1.SetItem(i,'formadepago',g_formas_pago.liquidacion)
			dw_1.SetItem(i,'asunto','Factura inclu$$HEX1$$ed00$$ENDHEX$$da en la liquidaci$$HEX1$$f300$$ENDHEX$$n : ' + id_liquidacion)
			//SE ACTUALIZA EL IMPORTE DE LA LIQUIDACI$$HEX1$$d300$$ENDHEX$$N
			ld_importe_liquidacion = ld_importe_liquidacion - ld_total_fact
			//SE ACTUALIZA EL COBRO DE LA FACTURA
			ds_cobros.setitem(1,'forma_pago', g_formas_pago.liquidacion)
			ds_cobros.setitem(1,'pagado', 'S')
			ds_cobros.setitem(1,'f_pago', datetime(Today()))
			dw_1.SetItem(i,'id_liquidacion',id_liquidacion)
			dw_1.SetItem(i,'f_pago',datetime(Today()))
			dw_1.SetItem(i,'pagado','S')
			
		else 
			j = dw_1.rowcount()
			continue
			// SE COMENTO PARA HACER SOLO PAGOS COMPLETOS
			// SI HAY ALGO DE LA LIQUIDACI$$HEX1$$d300$$ENDHEX$$N DEBE SER UN PAGO PARCIAL DE LA FACTURA Y OTRO PENDIENTE
		//	ld_cobro_pendiente = ld_total_fact -ld_importe_liquidacion
//			ld_importe_liquidacion = 0
//			dw_1.SetItem(i,'formadepago',g_formas_pago.fraccionada)
//			dw_1.SetItem(i,'asunto','Factura inclu$$HEX1$$ed00$$ENDHEX$$da en la liquidaci$$HEX1$$f300$$ENDHEX$$n : ' + id_liquidacion)
			// SE INSERTA COBRO POR EL RESTANTE PENDIENTE DE LA FACTURA Y SE ACTUALIZA EL COBRO 
			     
		end if
		
	next
	ds_liquidaciones.setitem(i, 'importe', ld_importe_liquidacion)
next
dw_1.setfilter(" ")
dw_1.filter()

//ds_liquidaciones.update()
//ds_cobros.update()
//dw_1.update()

destroy ds_liquidaciones
destroy ds_cobros




end subroutine

on w_liquidaciones_descontar_fact.create
int iCurrent
call super::create
this.cb_actualiza=create cb_actualiza
this.cb_cerrar=create cb_cerrar
this.st_1=create st_1
this.cb_previzualiza=create cb_previzualiza
this.cb_imprimir=create cb_imprimir
this.dw_1=create dw_1
this.dw_listado=create dw_listado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_actualiza
this.Control[iCurrent+2]=this.cb_cerrar
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_previzualiza
this.Control[iCurrent+5]=this.cb_imprimir
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.dw_listado
end on

on w_liquidaciones_descontar_fact.destroy
call super::destroy
destroy(this.cb_actualiza)
destroy(this.cb_cerrar)
destroy(this.st_1)
destroy(this.cb_previzualiza)
destroy(this.cb_imprimir)
destroy(this.dw_1)
destroy(this.dw_listado)
end on

event open;call super::open;int i
string estado

i_datos_fase = Message.PowerObjectParm

f_centrar_ventana(this)

dw_1.retrieve()
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_liquidaciones_descontar_fact
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_liquidaciones_descontar_fact
end type

type cb_actualiza from commandbutton within w_liquidaciones_descontar_fact
integer x = 2263
integer y = 2020
integer width = 402
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Actualizar"
end type

event clicked;// Llama al el evento liquidar facturas
//Parent.TriggerEvent("csd_liquidar_facturas")

end event

type cb_cerrar from commandbutton within w_liquidaciones_descontar_fact
integer x = 3131
integer y = 2020
integer width = 402
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
boolean cancel = true
boolean default = true
end type

event clicked;Close(parent)
end event

type st_1 from statictext within w_liquidaciones_descontar_fact
integer x = 55
integer y = 2052
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 255
boolean focusrectangle = false
end type

type cb_previzualiza from commandbutton within w_liquidaciones_descontar_fact
integer x = 1829
integer y = 2020
integer width = 402
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Previsualizar"
end type

event clicked;
if dw_1.rowcount() = 1 and dw_1.getitemdecimal(1, 'importe_neto') < 0 then 
	messagebox(g_titulo, "El importe de la liquidaci$$HEX1$$f300$$ENDHEX$$n no es suficiente para descontar la factura") 
else
	Parent.TriggerEvent("csd_liquidar_facturas")
	if dw_listado.rowcount() <=0 then
		messagebox(g_titulo, "El importe de la liquidaci$$HEX1$$f300$$ENDHEX$$n no es suficiente para descontar la factura")
	else
		dw_listado.visible = true
		cb_imprimir.enabled = true
		cb_actualiza.enabled = true
	end if
end if
end event

type cb_imprimir from commandbutton within w_liquidaciones_descontar_fact
integer x = 2697
integer y = 2020
integer width = 402
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Imprimir"
end type

event clicked;long i,ll_job
n_csd_impresion_formato uo_impresion
string id_fase
datetime f_entrada
	string n_reg
	
if dw_listado.rowcount()<= 0 then return

setpointer(hourglass!)
//dw_listado.reset()


ll_job=printopen()

uo_impresion=create n_csd_impresion_formato
uo_impresion.copias=1
uo_impresion.generar_registro=g_formato_impresion.generar_registro
uo_impresion.tipo_receptor='C'
uo_impresion.serie='LIQUID'

uo_impresion.visualizar_web = 'N'
uo_impresion.email = 'N'
uo_impresion.pdf= 'N'
uo_impresion.papel='S'
uo_impresion.masivo=true
uo_impresion.ruta_automatica=true
uo_impresion.ll_printjob=ll_job
if uo_impresion.f_opciones_impresion()<=0 then return




//Usamos, en su lugar, un trabajo de impresi$$HEX1$$f300$$ENDHEX$$n

//	id_fase=dw_lista.GetItemString(i,'id_fase')
//n_reg=''
	//select n_registro,f_entrada into :n_reg,:f_entrada from fases where id_fase=:id_fase;
	uo_impresion.dw=dw_listado
//	uo_impresion.id_receptor=''//dw_lista.GetItemString(i,'id_colegiado')
//	uo_impresion.ruta_relativa2=string(year(date(f_entrada)))
//	uo_impresion.ruta_relativa3=n_reg
//	uo_impresion.asunto_email="Liquidaci$$HEX1$$f300$$ENDHEX$$n "+dw_lista.GetItemString(i,'id_liquidacion')
//	uo_impresion.nombre="Liquidacion_"+dw_lista.GetItemString(i,'id_liquidacion')
	uo_impresion.f_impresion()




//dw_informe.sort()
printclose(ll_job)
setpointer(arrow!)
end event

type dw_1 from u_dw within w_liquidaciones_descontar_fact
integer x = 23
integer y = 56
integer width = 3493
integer height = 1960
integer taborder = 10
string dataobject = "d_descontar_facturas"
boolean ib_isupdateable = false
end type

event retrieveend;call super::retrieveend;st_1.text = string(this.RowCount()) + ' registros.'
end event

type dw_listado from u_dw within w_liquidaciones_descontar_fact
integer x = 23
integer y = 60
integer width = 3493
integer height = 1956
integer taborder = 11
string dataobject = "d_listado_desc_fact_pte"
end type

event doubleclicked;call super::doubleclicked;this.visible = false
this.reset()
end event

