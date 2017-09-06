HA$PBExportHeader$w_facturas_ene_feb_cu.srw
forward
global type w_facturas_ene_feb_cu from w_response
end type
type dw_1 from u_dw within w_facturas_ene_feb_cu
end type
type dw_2 from u_dw within w_facturas_ene_feb_cu
end type
type cb_1 from commandbutton within w_facturas_ene_feb_cu
end type
type dw_3 from u_dw within w_facturas_ene_feb_cu
end type
type cb_2 from commandbutton within w_facturas_ene_feb_cu
end type
type dw_4 from u_dw within w_facturas_ene_feb_cu
end type
end forward

global type w_facturas_ene_feb_cu from w_response
integer x = 214
integer y = 221
integer width = 3488
integer height = 2376
dw_1 dw_1
dw_2 dw_2
cb_1 cb_1
dw_3 dw_3
cb_2 cb_2
dw_4 dw_4
end type
global w_facturas_ene_feb_cu w_facturas_ene_feb_cu

on w_facturas_ene_feb_cu.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_1=create cb_1
this.dw_3=create dw_3
this.cb_2=create cb_2
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.dw_4
end on

on w_facturas_ene_feb_cu.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.cb_2)
destroy(this.dw_4)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_facturas_ene_feb_cu
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_facturas_ene_feb_cu
end type

type dw_1 from u_dw within w_facturas_ene_feb_cu
integer x = 37
integer y = 32
integer width = 3374
integer height = 372
integer taborder = 10
boolean bringtotop = true
string dataobject = "ds_fases_minutas_sgc_cu"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_2 from u_dw within w_facturas_ene_feb_cu
integer x = 37
integer y = 848
integer width = 3406
integer height = 620
integer taborder = 10
boolean bringtotop = true
string dataobject = "ds_csi_facturas_emitidas_sgc_cu"
boolean hscrollbar = true
end type

type cb_1 from commandbutton within w_facturas_ene_feb_cu
integer x = 594
integer y = 2152
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SGC"
end type

event clicked;long i, fila, lin

dw_1.retrieve()

for i=1 to dw_1.rowcount()
	fila = dw_2.insertrow(0)
	dw_2.setitem(fila, 'n_fact', dw_1.getitemstring(i, 'n_aviso'))
	dw_2.setitem(fila, 'fecha', dw_1.getitemdatetime(i, 'fecha'))
	dw_2.setitem(fila, 'n_col', dw_1.getitemstring(i, 'id_colegiado'))
	string id_cli, id_fase, id_col
	id_col = dw_1.getitemstring(i, 'id_colegiado')
	id_cli = dw_1.getitemstring(i, 'id_cliente')	
	id_fase = dw_1.getitemstring(i, 'id_fase')	
	dw_2.setitem(fila, 'nif', f_devuelve_nif(id_col))
	dw_2.setitem(fila, 'nombre', f_colegiado_apellido(id_col))
	dw_2.setitem(fila, 'domicilio', f_domicilio_fiscal(id_col))
	dw_2.setitem(fila, 'poblacion', f_poblacion_fiscal(id_col))
	dw_2.setitem(fila, 'proyecto', '00000')
	dw_2.setitem(fila, 'cuenta', 'X')	
	dw_2.setitem(fila, 'tipo_persona', 'C')
	dw_2.setitem(fila, 'contado', 'N')	
	dw_2.setitem(fila, 'pagado', 'S')
	double base, iva
	base = dw_1.getitemnumber(i, 'base_dv')+dw_1.getitemnumber(i, 'base_cip')+dw_1.getitemnumber(i, 'base_musaat')+dw_1.getitemnumber(i, 'base_impresos')+dw_1.getitemnumber(i, 'base_otros')
	iva = dw_1.getitemnumber(i, 'iva_dv')+dw_1.getitemnumber(i, 'iva_cip')+dw_1.getitemnumber(i, 'iva_musaat')+dw_1.getitemnumber(i, 'iva_impresos')+dw_1.getitemnumber(i, 'iva_otros')
	dw_2.setitem(fila, 'base_imp', base)
	dw_2.setitem(fila, 'iva', iva)
	dw_2.setitem(fila, 'txt_desc', '')	
	dw_2.setitem(fila, 'descuento', 0)
	dw_2.setitem(fila, 'total', base+iva)	
	dw_2.setitem(fila, 'subtotal', base)		
	dw_2.setitem(fila, 'f_pago', dw_1.getitemdatetime(i, 'fecha_pago'))
	dw_2.setitem(fila, 'emitida', 'S')
	dw_2.setitem(fila, 'reimpresa', 'N')	
	dw_2.setitem(fila, 'formadepago', '')
	dw_2.setitem(fila, 'contabilizada', 'N')	
	dw_2.setitem(fila, 'f_conta', '')
	dw_2.setitem(fila, 'conta_pago', 'N')
	dw_2.setitem(fila, 'f_conta_pago', '')	
	dw_2.setitem(fila, 'notas', '')
	dw_2.setitem(fila, 'asunto', f_dame_exp(id_fase)+ ', ' + f_dame_cliente(id_cli))	
	dw_2.setitem(fila, 'obs', '')	
	dw_2.setitem(fila, 'id_factura', 'ID' + '000' + string(i))
	dw_2.setitem(fila, 'centro', '00')
	dw_2.setitem(fila, 'banco', '')	
	dw_2.setitem(fila, 'id_persona', dw_1.getitemstring(i, 'id_colegiado'))
	dw_2.setitem(fila, 't_iva', '')	
	dw_2.setitem(fila, 'moneda', 'E')		
	dw_2.setitem(fila, 'tipo_reten', 0)		
	dw_2.setitem(fila, 'cuenta_reten', '')		
	dw_2.setitem(fila, 'importe_reten', 0)		
	dw_2.setitem(fila, 'tipo_factura', '03')		
	dw_2.setitem(fila, 'emisor', '')		
	dw_2.setitem(fila, 'id_fase', dw_1.getitemstring(i, 'id_minuta'))			
	dw_2.setitem(fila, 'usuario', '')			
	dw_2.setitem(fila, 'id_ingreso', '')			
	dw_2.setitem(fila, 'n_fact_unico', '')			
	dw_2.setitem(fila, 'id_liquidacion', '')			
	dw_2.setitem(fila, 'anulada', 'N')			
	dw_2.setitem(fila, 'abonada', '')				
	dw_2.setitem(fila, 'irpf_colegio', 0)				
	dw_2.setitem(fila, 'id_minuta', '')				
	dw_2.setitem(fila, 'empresa', '01')				
	dw_2.setitem(fila, 'visared', '%')
	// LINEAS
	if dw_1.getitemnumber(i, 'base_dv')>0 then
		lin = dw_3.insertrow(0)
		dw_3.setitem(lin, 'id_factura', 'ID' + '000' + string(i))
		dw_3.setitem(lin, 'id_linea', 'ID' + '000' + string(lin))		
		dw_3.setitem(lin, 'descripcion', f_devuelve_desc_concepto('02'))
		dw_3.setitem(lin, 'precio', dw_1.getitemnumber(i, 'base_dv'))
		dw_3.setitem(lin, 'unidades', 1)
		dw_3.setitem(lin, 'subtotal', dw_1.getitemnumber(i, 'base_dv'))		
		dw_3.setitem(lin, 'articulo', '02')				
		dw_3.setitem(lin, 't_iva', dw_1.getitemstring(i, 't_iva_dv'))		
		dw_3.setitem(lin, 'subtotal_iva', dw_1.getitemnumber(i, 'iva_dv'))						
		dw_3.setitem(lin, 'total', dw_1.getitemnumber(i, 'base_dv') + dw_1.getitemnumber(i, 'iva_dv'))								
		dw_3.setitem(lin, 'porcent_dto', 0)										
		dw_3.setitem(lin, 'importe_dto', 0)										
		dw_3.setitem(lin, 'centro', 'X')
		dw_3.setitem(lin, 'proyecto', '00000')												
		dw_3.setitem(lin, 'id_fase', dw_1.getitemstring(i, 'id_minuta'))
		dw_3.setitem(lin, 'fecha', dw_1.getitemdatetime(i, 'fecha'))
		dw_3.setitem(lin, 'descripcion_larga', f_devuelve_desc_concepto('02'))		
	end if	
	if dw_1.getitemnumber(i, 'base_cip')>0 then
		lin = dw_3.insertrow(0)
		dw_3.setitem(lin, 'id_factura', 'ID' + '000' + string(i))
		dw_3.setitem(lin, 'id_linea', 'ID' + '000' + string(lin))		
		dw_3.setitem(lin, 'descripcion', f_devuelve_desc_concepto('07'))
		dw_3.setitem(lin, 'precio', dw_1.getitemnumber(i, 'base_cip'))
		dw_3.setitem(lin, 'unidades', 1)
		dw_3.setitem(lin, 'subtotal', dw_1.getitemnumber(i, 'base_cip'))		
		dw_3.setitem(lin, 'articulo', '07')				
		dw_3.setitem(lin, 't_iva', dw_1.getitemstring(i, 't_iva_cip'))		
		dw_3.setitem(lin, 'subtotal_iva', dw_1.getitemnumber(i, 'iva_cip'))						
		dw_3.setitem(lin, 'total', dw_1.getitemnumber(i, 'base_cip') + dw_1.getitemnumber(i, 'iva_cip'))
		dw_3.setitem(lin, 'porcent_dto', 0)										
		dw_3.setitem(lin, 'importe_dto', 0)										
		dw_3.setitem(lin, 'centro', 'X')
		dw_3.setitem(lin, 'proyecto', '00000')												
		dw_3.setitem(lin, 'id_fase', dw_1.getitemstring(i, 'id_minuta'))
		dw_3.setitem(lin, 'fecha', dw_1.getitemdatetime(i, 'fecha'))
		dw_3.setitem(lin, 'descripcion_larga', f_devuelve_desc_concepto('07'))				
	end if
	if dw_1.getitemnumber(i, 'base_musaat')>0 then
		lin = dw_3.insertrow(0)
		dw_3.setitem(lin, 'id_factura', 'ID' + '000' + string(i))
		dw_3.setitem(lin, 'id_linea', 'ID' + '000' + string(lin))		
		dw_3.setitem(lin, 'descripcion', f_devuelve_desc_concepto('12'))
		dw_3.setitem(lin, 'precio', dw_1.getitemnumber(i, 'base_musaat'))
		dw_3.setitem(lin, 'unidades', 1)
		dw_3.setitem(lin, 'subtotal', dw_1.getitemnumber(i, 'base_musaat'))		
		dw_3.setitem(lin, 'articulo', '12')				
		dw_3.setitem(lin, 't_iva', '00')		
		dw_3.setitem(lin, 'subtotal_iva', dw_1.getitemnumber(i, 'iva_musaat'))						
		dw_3.setitem(lin, 'total', dw_1.getitemnumber(i, 'base_musaat') + dw_1.getitemnumber(i, 'iva_musaat'))
		dw_3.setitem(lin, 'porcent_dto', 0)										
		dw_3.setitem(lin, 'importe_dto', 0)										
		dw_3.setitem(lin, 'centro', 'X')
		dw_3.setitem(lin, 'proyecto', '00000')												
		dw_3.setitem(lin, 'id_fase', dw_1.getitemstring(i, 'id_minuta'))
		dw_3.setitem(lin, 'fecha', dw_1.getitemdatetime(i, 'fecha'))
		dw_3.setitem(lin, 'descripcion_larga', f_devuelve_desc_concepto('12'))						
	end if
	if dw_1.getitemnumber(i, 'base_impresos')>0 then
		lin = dw_3.insertrow(0)
		dw_3.setitem(lin, 'id_factura', 'ID' + '000' + string(i))
		dw_3.setitem(lin, 'id_linea', 'ID' + '000' + string(lin))		
		dw_3.setitem(lin, 'descripcion', f_devuelve_desc_concepto('18'))
		dw_3.setitem(lin, 'precio', dw_1.getitemnumber(i, 'base_impresos'))
		dw_3.setitem(lin, 'unidades', 1)
		dw_3.setitem(lin, 'subtotal', dw_1.getitemnumber(i, 'base_impresos'))		
		dw_3.setitem(lin, 'articulo', '18')	
		dw_3.setitem(lin, 't_iva', dw_1.getitemstring(i, 't_iva_impresos'))		
		dw_3.setitem(lin, 'subtotal_iva', dw_1.getitemnumber(i, 'iva_impresos'))						
		dw_3.setitem(lin, 'total', dw_1.getitemnumber(i, 'base_impresos') + dw_1.getitemnumber(i, 'iva_impresos'))
		dw_3.setitem(lin, 'porcent_dto', 0)										
		dw_3.setitem(lin, 'importe_dto', 0)										
		dw_3.setitem(lin, 'centro', 'X')
		dw_3.setitem(lin, 'proyecto', '00000')												
		dw_3.setitem(lin, 'id_fase', dw_1.getitemstring(i, 'id_minuta'))
		dw_3.setitem(lin, 'fecha', dw_1.getitemdatetime(i, 'fecha'))
		dw_3.setitem(lin, 'descripcion_larga', f_devuelve_desc_concepto('18'))
	end if
	if dw_1.getitemnumber(i, 'base_otros')	>0 then
		lin = dw_3.insertrow(0)
		dw_3.setitem(lin, 'id_factura', 'ID' + '000' + string(i))
		dw_3.setitem(lin, 'id_linea', 'ID' + '000' + string(lin))		
		dw_3.setitem(lin, 'descripcion', f_devuelve_desc_concepto('LI'))
		dw_3.setitem(lin, 'precio', dw_1.getitemnumber(i, 'base_otros'))
		dw_3.setitem(lin, 'unidades', 1)
		dw_3.setitem(lin, 'subtotal', dw_1.getitemnumber(i, 'base_otros'))		
		dw_3.setitem(lin, 'articulo', 'LI')	
		dw_3.setitem(lin, 't_iva', dw_1.getitemstring(i, 't_iva_otros'))		
		dw_3.setitem(lin, 'subtotal_iva', dw_1.getitemnumber(i, 'iva_otros'))						
		dw_3.setitem(lin, 'total', dw_1.getitemnumber(i, 'base_otros') + dw_1.getitemnumber(i, 'iva_otros'))
		dw_3.setitem(lin, 'porcent_dto', 0)										
		dw_3.setitem(lin, 'importe_dto', 0)										
		dw_3.setitem(lin, 'centro', 'X')
		dw_3.setitem(lin, 'proyecto', '00000')												
		dw_3.setitem(lin, 'id_fase', dw_1.getitemstring(i, 'id_minuta'))
		dw_3.setitem(lin, 'fecha', dw_1.getitemdatetime(i, 'fecha'))
		dw_3.setitem(lin, 'descripcion_larga', f_devuelve_desc_concepto('LI'))		
	end if
next  

dw_2.update()
dw_3.update()

end event

type dw_3 from u_dw within w_facturas_ene_feb_cu
integer x = 37
integer y = 1492
integer width = 3406
integer height = 620
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_csi_lineas_facturas_emitidas_cu"
boolean hscrollbar = true
end type

type cb_2 from commandbutton within w_facturas_ene_feb_cu
integer x = 1952
integer y = 2144
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CGC"
end type

event clicked;long i, fila, lin

dw_4.retrieve()

for i=1 to dw_4.rowcount()
	// HON
	fila = dw_2.insertrow(0)
	dw_2.setitem(fila, 'n_fact', dw_4.getitemstring(i, 'n_aviso')+'1')
	dw_2.setitem(fila, 'fecha', dw_4.getitemdatetime(i, 'fecha'))
	string id_cli, id_fase, id_col
	id_cli = dw_4.getitemstring(i, 'id_cliente')	
	dw_2.setitem(fila, 'n_col', f_dame_nif(id_cli))
	id_col = dw_4.getitemstring(i, 'id_colegiado')
	id_fase = dw_4.getitemstring(i, 'id_fase')	
	dw_2.setitem(fila, 'nif', f_dame_nif(id_cli))
	dw_2.setitem(fila, 'nombre', f_dame_cliente_nom_ape(id_cli))
	dw_2.setitem(fila, 'domicilio', f_dame_domicilio(id_cli))
	dw_2.setitem(fila, 'poblacion', f_retorna_poblacion(id_cli))
	dw_2.setitem(fila, 'proyecto', '00000')
	dw_2.setitem(fila, 'cuenta', 'X')	
	dw_2.setitem(fila, 'tipo_persona', 'P')
	dw_2.setitem(fila, 'contado', 'N')	
	dw_2.setitem(fila, 'pagado', 'S')
	double base, iva
	base = dw_4.getitemnumber(i, 'base_honos')
	iva = dw_4.getitemnumber(i, 'iva_honos')
	dw_2.setitem(fila, 'base_imp', base)
	dw_2.setitem(fila, 'iva', iva)
	dw_2.setitem(fila, 'txt_desc', '')	
	dw_2.setitem(fila, 'descuento', 0)
	dw_2.setitem(fila, 'total', base+iva)	
	dw_2.setitem(fila, 'subtotal', base)		
	dw_2.setitem(fila, 'f_pago', dw_4.getitemdatetime(i, 'fecha_pago'))
	dw_2.setitem(fila, 'emitida', 'S')
	dw_2.setitem(fila, 'reimpresa', 'N')	
	dw_2.setitem(fila, 'formadepago', '')
	dw_2.setitem(fila, 'contabilizada', 'N')	
	dw_2.setitem(fila, 'f_conta', '')
	dw_2.setitem(fila, 'conta_pago', 'N')
	dw_2.setitem(fila, 'f_conta_pago', '')	
	dw_2.setitem(fila, 'notas', '')
	dw_2.setitem(fila, 'asunto', f_dame_exp(id_fase)+ ', ' + f_dame_cliente(id_cli))	
	dw_2.setitem(fila, 'obs', '')	
	dw_2.setitem(fila, 'id_factura', 'ID' + '111' + string(i))
	dw_2.setitem(fila, 'centro', '00')
	dw_2.setitem(fila, 'banco', '')	
	dw_2.setitem(fila, 'id_persona', dw_4.getitemstring(i, 'id_cliente'))
	dw_2.setitem(fila, 't_iva', '')	
	dw_2.setitem(fila, 'moneda', 'E')		
	dw_2.setitem(fila, 'tipo_reten', 0)		
	dw_2.setitem(fila, 'cuenta_reten', '')		
	dw_2.setitem(fila, 'importe_reten', 0)		
	dw_2.setitem(fila, 'tipo_factura', '04')		
	dw_2.setitem(fila, 'emisor', dw_4.getitemstring(i, 'id_colegiado'))		
	dw_2.setitem(fila, 'id_fase', dw_4.getitemstring(i, 'id_minuta'))			
	dw_2.setitem(fila, 'usuario', '')			
	dw_2.setitem(fila, 'id_ingreso', '')			
	dw_2.setitem(fila, 'n_fact_unico', '')			
	dw_2.setitem(fila, 'id_liquidacion', '')			
	dw_2.setitem(fila, 'anulada', 'N')			
	dw_2.setitem(fila, 'abonada', '')				
	dw_2.setitem(fila, 'irpf_colegio', 0)				
	dw_2.setitem(fila, 'id_minuta', '')				
	dw_2.setitem(fila, 'empresa', '01')				
	dw_2.setitem(fila, 'visared', '%')
	
	// LINEA HONOS
	if dw_4.getitemnumber(i, 'base_honos')>0 then
		lin = dw_3.insertrow(0)
		dw_3.setitem(lin, 'id_factura', 'ID' + '111' + string(i))
		dw_3.setitem(lin, 'id_linea', 'ID' + '111' + string(lin))		
		dw_3.setitem(lin, 'descripcion', f_devuelve_desc_concepto('15'))
		dw_3.setitem(lin, 'precio', dw_4.getitemnumber(i, 'base_honos'))
		dw_3.setitem(lin, 'unidades', 1)
		dw_3.setitem(lin, 'subtotal', dw_4.getitemnumber(i, 'base_honos'))		
		dw_3.setitem(lin, 'articulo', '15')				
		dw_3.setitem(lin, 't_iva', dw_4.getitemstring(i, 't_iva_honos'))		
		dw_3.setitem(lin, 'subtotal_iva', dw_4.getitemnumber(i, 'iva_honos'))						
		dw_3.setitem(lin, 'total', dw_4.getitemnumber(i, 'base_honos') + dw_4.getitemnumber(i, 'iva_honos'))
		dw_3.setitem(lin, 'porcent_dto', 0)										
		dw_3.setitem(lin, 'importe_dto', 0)										
		dw_3.setitem(lin, 'centro', 'X')
		dw_3.setitem(lin, 'proyecto', '00000')												
		dw_3.setitem(lin, 'id_fase', dw_4.getitemstring(i, 'id_minuta'))
		dw_3.setitem(lin, 'fecha', dw_4.getitemdatetime(i, 'fecha'))
		dw_3.setitem(lin, 'descripcion_larga', f_devuelve_desc_concepto('15'))		
		dw_3.setitem(lin, 'id_persona', dw_4.getitemstring(i, 'id_colegiado'))		
	end if		
	
	// GAS
	fila = dw_2.insertrow(0)
	dw_2.setitem(fila, 'n_fact', dw_4.getitemstring(i, 'n_aviso')+'2')
	dw_2.setitem(fila, 'fecha', dw_4.getitemdatetime(i, 'fecha'))
	dw_2.setitem(fila, 'n_col', dw_4.getitemstring(i, 'id_colegiado'))
	id_col = dw_4.getitemstring(i, 'id_colegiado')
	id_cli = dw_4.getitemstring(i, 'id_cliente')	
	id_fase = dw_4.getitemstring(i, 'id_fase')	
	dw_2.setitem(fila, 'nif', f_devuelve_nif(id_col))
	dw_2.setitem(fila, 'nombre', f_colegiado_apellido(id_col))
	dw_2.setitem(fila, 'domicilio', f_domicilio_fiscal(id_col))
	dw_2.setitem(fila, 'poblacion', f_poblacion_fiscal(id_col))
	dw_2.setitem(fila, 'proyecto', '00000')
	dw_2.setitem(fila, 'cuenta', 'X')	
	dw_2.setitem(fila, 'tipo_persona', 'C')
	dw_2.setitem(fila, 'contado', 'N')	
	dw_2.setitem(fila, 'pagado', 'S')
	base = dw_4.getitemnumber(i, 'base_dv')+dw_4.getitemnumber(i, 'base_cip')+dw_4.getitemnumber(i, 'base_musaat')+dw_4.getitemnumber(i, 'base_impresos')+dw_4.getitemnumber(i, 'base_otros')
	iva = dw_4.getitemnumber(i, 'iva_dv')+dw_4.getitemnumber(i, 'iva_cip')+dw_4.getitemnumber(i, 'iva_musaat')+dw_4.getitemnumber(i, 'iva_impresos')+dw_4.getitemnumber(i, 'iva_otros')
	dw_2.setitem(fila, 'base_imp', base)
	dw_2.setitem(fila, 'iva', iva)
	dw_2.setitem(fila, 'txt_desc', '')	
	dw_2.setitem(fila, 'descuento', 0)
	dw_2.setitem(fila, 'total', base+iva)	
	dw_2.setitem(fila, 'subtotal', base)		
	dw_2.setitem(fila, 'f_pago', dw_4.getitemdatetime(i, 'fecha_pago'))
	dw_2.setitem(fila, 'emitida', 'S')
	dw_2.setitem(fila, 'reimpresa', 'N')	
	dw_2.setitem(fila, 'formadepago', '')
	dw_2.setitem(fila, 'contabilizada', 'N')	
	dw_2.setitem(fila, 'f_conta', '')
	dw_2.setitem(fila, 'conta_pago', 'N')
	dw_2.setitem(fila, 'f_conta_pago', '')	
	dw_2.setitem(fila, 'notas', '')
	dw_2.setitem(fila, 'asunto', f_dame_exp(id_fase)+ ', ' + f_dame_cliente(id_cli))	
	dw_2.setitem(fila, 'obs', '')	
	dw_2.setitem(fila, 'id_factura', 'ID' + '222' + string(i))
	dw_2.setitem(fila, 'centro', '00')
	dw_2.setitem(fila, 'banco', '')	
	dw_2.setitem(fila, 'id_persona', dw_4.getitemstring(i, 'id_colegiado'))
	dw_2.setitem(fila, 't_iva', '')	
	dw_2.setitem(fila, 'moneda', 'E')		
	dw_2.setitem(fila, 'tipo_reten', 0)		
	dw_2.setitem(fila, 'cuenta_reten', '')		
	dw_2.setitem(fila, 'importe_reten', 0)		
	dw_2.setitem(fila, 'tipo_factura', '03')		
	dw_2.setitem(fila, 'emisor', '')		
	dw_2.setitem(fila, 'id_fase', dw_4.getitemstring(i, 'id_minuta'))			
	dw_2.setitem(fila, 'usuario', '')			
	dw_2.setitem(fila, 'id_ingreso', '')			
	dw_2.setitem(fila, 'n_fact_unico', '')			
	dw_2.setitem(fila, 'id_liquidacion', '')			
	dw_2.setitem(fila, 'anulada', 'N')			
	dw_2.setitem(fila, 'abonada', '')				
	dw_2.setitem(fila, 'irpf_colegio', 0)				
	dw_2.setitem(fila, 'id_minuta', '')				
	dw_2.setitem(fila, 'empresa', '01')				
	dw_2.setitem(fila, 'visared', '%')	
	// LINEAS
	if dw_4.getitemnumber(i, 'base_dv')>0 then
		lin = dw_3.insertrow(0)
		dw_3.setitem(lin, 'id_factura', 'ID' + '222' + string(i))
		dw_3.setitem(lin, 'id_linea', 'ID' + '222' + string(lin))		
		dw_3.setitem(lin, 'descripcion', f_devuelve_desc_concepto('02'))
		dw_3.setitem(lin, 'precio', dw_4.getitemnumber(i, 'base_dv'))
		dw_3.setitem(lin, 'unidades', 1)
		dw_3.setitem(lin, 'subtotal', dw_4.getitemnumber(i, 'base_dv'))		
		dw_3.setitem(lin, 'articulo', '02')				
		dw_3.setitem(lin, 't_iva', dw_4.getitemstring(i, 't_iva_dv'))		
		dw_3.setitem(lin, 'subtotal_iva', dw_4.getitemnumber(i, 'iva_dv'))						
		dw_3.setitem(lin, 'total', dw_4.getitemnumber(i, 'base_dv') + dw_4.getitemnumber(i, 'iva_dv'))								
		dw_3.setitem(lin, 'porcent_dto', 0)										
		dw_3.setitem(lin, 'importe_dto', 0)										
		dw_3.setitem(lin, 'centro', 'X')
		dw_3.setitem(lin, 'proyecto', '00000')												
		dw_3.setitem(lin, 'id_fase', dw_4.getitemstring(i, 'id_minuta'))
		dw_3.setitem(lin, 'fecha', dw_4.getitemdatetime(i, 'fecha'))
		dw_3.setitem(lin, 'descripcion_larga', f_devuelve_desc_concepto('02'))		
	end if	
	if dw_4.getitemnumber(i, 'base_cip')>0 then
		lin = dw_3.insertrow(0)
		dw_3.setitem(lin, 'id_factura', 'ID' + '222' + string(i))
		dw_3.setitem(lin, 'id_linea', 'ID' + '222' + string(lin))				
		dw_3.setitem(lin, 'descripcion', f_devuelve_desc_concepto('05'))
		dw_3.setitem(lin, 'precio', dw_4.getitemnumber(i, 'base_cip'))
		dw_3.setitem(lin, 'unidades', 1)
		dw_3.setitem(lin, 'subtotal', dw_4.getitemnumber(i, 'base_cip'))		
		dw_3.setitem(lin, 'articulo', '05')				
		dw_3.setitem(lin, 't_iva', dw_4.getitemstring(i, 't_iva_cip'))		
		dw_3.setitem(lin, 'subtotal_iva', dw_4.getitemnumber(i, 'iva_cip'))						
		dw_3.setitem(lin, 'total', dw_4.getitemnumber(i, 'base_cip') + dw_4.getitemnumber(i, 'iva_cip'))
		dw_3.setitem(lin, 'porcent_dto', 0)										
		dw_3.setitem(lin, 'importe_dto', 0)										
		dw_3.setitem(lin, 'centro', 'X')
		dw_3.setitem(lin, 'proyecto', '00000')												
		dw_3.setitem(lin, 'id_fase', dw_4.getitemstring(i, 'id_minuta'))
		dw_3.setitem(lin, 'fecha', dw_4.getitemdatetime(i, 'fecha'))
		dw_3.setitem(lin, 'descripcion_larga', f_devuelve_desc_concepto('05'))				
	end if
	if dw_4.getitemnumber(i, 'base_musaat')>0 then
		lin = dw_3.insertrow(0)
		dw_3.setitem(lin, 'id_factura', 'ID' + '222' + string(i))
		dw_3.setitem(lin, 'id_linea', 'ID' + '222' + string(lin))		
		dw_3.setitem(lin, 'descripcion', f_devuelve_desc_concepto('12'))
		dw_3.setitem(lin, 'precio', dw_4.getitemnumber(i, 'base_musaat'))
		dw_3.setitem(lin, 'unidades', 1)
		dw_3.setitem(lin, 'subtotal', dw_4.getitemnumber(i, 'base_musaat'))		
		dw_3.setitem(lin, 'articulo', '12')				
		dw_3.setitem(lin, 't_iva', '00')		
		dw_3.setitem(lin, 'subtotal_iva', dw_4.getitemnumber(i, 'iva_musaat'))						
		dw_3.setitem(lin, 'total', dw_4.getitemnumber(i, 'base_musaat') + dw_4.getitemnumber(i, 'iva_musaat'))
		dw_3.setitem(lin, 'porcent_dto', 0)										
		dw_3.setitem(lin, 'importe_dto', 0)										
		dw_3.setitem(lin, 'centro', 'X')
		dw_3.setitem(lin, 'proyecto', '00000')												
		dw_3.setitem(lin, 'id_fase', dw_4.getitemstring(i, 'id_minuta'))
		dw_3.setitem(lin, 'fecha', dw_4.getitemdatetime(i, 'fecha'))
		dw_3.setitem(lin, 'descripcion_larga', f_devuelve_desc_concepto('12'))						
	end if
	if dw_4.getitemnumber(i, 'base_impresos')>0 then
		lin = dw_3.insertrow(0)
		dw_3.setitem(lin, 'id_factura', 'ID' + '222' + string(i))
		dw_3.setitem(lin, 'id_linea', 'ID' + '222' + string(lin))		
		dw_3.setitem(lin, 'descripcion', f_devuelve_desc_concepto('18'))
		dw_3.setitem(lin, 'precio', dw_4.getitemnumber(i, 'base_impresos'))
		dw_3.setitem(lin, 'unidades', 1)
		dw_3.setitem(lin, 'subtotal', dw_4.getitemnumber(i, 'base_impresos'))		
		dw_3.setitem(lin, 'articulo', '18')	
		dw_3.setitem(lin, 't_iva', dw_4.getitemstring(i, 't_iva_impresos'))		
		dw_3.setitem(lin, 'subtotal_iva', dw_4.getitemnumber(i, 'iva_impresos'))						
		dw_3.setitem(lin, 'total', dw_4.getitemnumber(i, 'base_impresos') + dw_4.getitemnumber(i, 'iva_impresos'))
		dw_3.setitem(lin, 'porcent_dto', 0)										
		dw_3.setitem(lin, 'importe_dto', 0)										
		dw_3.setitem(lin, 'centro', 'X')
		dw_3.setitem(lin, 'proyecto', '00000')												
		dw_3.setitem(lin, 'id_fase', dw_4.getitemstring(i, 'id_minuta'))
		dw_3.setitem(lin, 'fecha', dw_4.getitemdatetime(i, 'fecha'))
		dw_3.setitem(lin, 'descripcion_larga', f_devuelve_desc_concepto('18'))
	end if
	if dw_4.getitemnumber(i, 'base_otros')	>0 then
		lin = dw_3.insertrow(0)
		dw_3.setitem(lin, 'id_factura', 'ID' + '222' + string(i))
		dw_3.setitem(lin, 'id_linea', 'ID' + '222' + string(lin))				
		dw_3.setitem(lin, 'descripcion', f_devuelve_desc_concepto('LI'))
		dw_3.setitem(lin, 'precio', dw_4.getitemnumber(i, 'base_otros'))
		dw_3.setitem(lin, 'unidades', 1)
		dw_3.setitem(lin, 'subtotal', dw_4.getitemnumber(i, 'base_otros'))		
		dw_3.setitem(lin, 'articulo', 'LI')	
		dw_3.setitem(lin, 't_iva', dw_4.getitemstring(i, 't_iva_otros'))		
		dw_3.setitem(lin, 'subtotal_iva', dw_4.getitemnumber(i, 'iva_otros'))						
		dw_3.setitem(lin, 'total', dw_4.getitemnumber(i, 'base_otros') + dw_4.getitemnumber(i, 'iva_otros'))
		dw_3.setitem(lin, 'porcent_dto', 0)										
		dw_3.setitem(lin, 'importe_dto', 0)										
		dw_3.setitem(lin, 'centro', 'X')
		dw_3.setitem(lin, 'proyecto', '00000')												
		dw_3.setitem(lin, 'id_fase', dw_4.getitemstring(i, 'id_minuta'))
		dw_3.setitem(lin, 'fecha', dw_4.getitemdatetime(i, 'fecha'))
		dw_3.setitem(lin, 'descripcion_larga', f_devuelve_desc_concepto('LI'))		
	end if
next  

dw_2.update()
dw_3.update()

end event

type dw_4 from u_dw within w_facturas_ene_feb_cu
integer x = 37
integer y = 440
integer width = 3374
integer height = 372
integer taborder = 10
boolean bringtotop = true
string dataobject = "ds_fases_minutas_cgc_cu"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

