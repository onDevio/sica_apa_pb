HA$PBExportHeader$w_descuentos_colegiado.srw
forward
global type w_descuentos_colegiado from w_popup
end type
type dw_descuentos from u_dw within w_descuentos_colegiado
end type
type cb_imprimir from commandbutton within w_descuentos_colegiado
end type
end forward

global type w_descuentos_colegiado from w_popup
integer x = 214
integer y = 221
integer width = 3232
integer height = 1784
string title = "Descuentos Colegiado"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event csd_cargar_datos ( )
dw_descuentos dw_descuentos
cb_imprimir cb_imprimir
end type
global w_descuentos_colegiado w_descuentos_colegiado

type variables
w_fases_detalle  i_w
long fila_colegiado
end variables

event csd_cargar_datos();string n_col, n_expedi, t_actuacion, id_col, id_fase
int i,j, fila,k

string ls_descuento,ls_id_fase,ls_empresa
double ld_base,ld_base_colegiado,ld_por_colegiado,ld_facturado,ld_proforma,ld_facturado_cobrado

st_musaat_datos st_musaat_datos

dw_descuentos.setredraw( false)
setpointer(hourglass!)

ls_id_fase=i_w.dw_1.getItemString(i_w.dw_1.getrow(),'id_fase')

For j = 1 to i_w.idw_fases_colegiados.rowcount()
	
	for k=1 to i_w.idw_fases_informes.rowcount()
		fila=dw_descuentos.insertrow(0)
		
		//El id_col es util para mostrar el nombre del colegiado y para agrupar sus conceptos
		id_col = i_w.idw_fases_colegiados.getitemstring(j, 'id_col')
		dw_descuentos.setItem(fila,'colegiado',id_col)
		
		ls_descuento=i_w.idw_fases_informes.getItemString(k,'tipo_informe')
		dw_descuentos.setItem(fila,'descuento',ls_descuento)
		ls_empresa=i_w.idw_fases_informes.getItemString(k,'empresa')
		dw_descuentos.setItem(fila,'empresa',ls_empresa)
		if ls_descuento <>  g_codigos_conceptos.musaat_variable then
			//Base
			//Obtenemos % participaci$$HEX1$$f300$$ENDHEX$$n
			ld_por_colegiado=i_w.idw_fases_colegiados.getitemnumber(j, 'porcen_a')
	
			ld_base= i_w.idw_fases_informes.getitemnumber(k, 'cuantia_colegiado')
			ld_base_colegiado=ld_base *( ld_por_colegiado/100)
			ld_base_colegiado=f_redondea(ld_base_colegiado)
			dw_descuentos.setItem(fila,'base',ld_base_colegiado)
		else
			st_musaat_datos = f_musaat_tipo_movimiento_facturar(ls_id_fase,id_col,0)
			
			// C$$HEX1$$e100$$ENDHEX$$lculo prima Musaat
			st_musaat_datos.n_visado = ls_id_fase
			st_musaat_datos.id_col = id_col
			st_musaat_datos.id_minuta = ''
			st_musaat_datos.recuperar = TRUE
			st_musaat_datos.genera_movi = FALSE
			
			 if st_musaat_datos.tipo_csd= '23' or st_musaat_datos.tipo_csd= '25' then
				st_musaat_datos.tipo_csd= '10'				
			end if
			
			if f_colegiado_tipopersona(id_col) = 'S' then
				f_musaat_calcula_prima_sociedad(st_musaat_datos)			
			else
				f_musaat_calcula_prima(st_musaat_datos)
			end if
			
			ld_base= st_musaat_datos.prima_comp

			ld_base_colegiado = f_redondea(ld_base)
			dw_descuentos.setItem(fila,'base',ld_base_colegiado)
		end if
					
		//Proformas/avisos
		ld_proforma = f_total_facturado_concepto(ls_id_fase, ls_descuento,g_colegio_colegiado, id_col, 'S')
		dw_descuentos.setItem(fila,'proforma',ld_proforma)
		
		//Facturado
		ld_facturado = f_total_facturado_concepto(ls_id_fase, ls_descuento,g_colegio_colegiado, id_col, 'N')
		dw_descuentos.setItem(fila,'facturado',ld_facturado)
		
		//Facturado cobrado
		ld_facturado_cobrado = f_total_fact_cobrado_concepto(ls_id_fase, ls_descuento,g_colegio_colegiado, id_col)
		dw_descuentos.setItem(fila,'fact_cobrado',ld_facturado_cobrado)
	
				
	next	

Next
if i_w.idw_fases_colegiados.rowcount()>1 then
	//Rellenamos los totales
	for k=1 to i_w.idw_fases_informes.rowcount()
			
			fila=dw_descuentos.insertrow(0)
			
			//A$$HEX1$$f100$$ENDHEX$$adimos total en el campo colegiado para diferenciarlo en el dw y que agrupe los totales
			dw_descuentos.setItem(fila,'colegiado','total')
			
			ls_descuento=i_w.idw_fases_informes.getItemString(k,'tipo_informe')
			
			dw_descuentos.setItem(fila,'descuento',ls_descuento)
			ls_empresa=i_w.idw_fases_informes.getItemString(k,'empresa')
			dw_descuentos.setItem(fila,'empresa',ls_empresa)
			//Base
			ld_base= i_w.idw_fases_informes.getitemnumber(k, 'cuantia_colegiado')
			dw_descuentos.setItem(fila,'base',ld_base)
		
			//Utilizamos las mismas funciones pero pasandole % en el campo id_colegiado, de esta forma obtiene todo lo facturado.
			//Proformas/avisos
			ld_proforma = f_total_facturado_concepto(ls_id_fase, ls_descuento,g_colegio_colegiado, '%', 'S')
			dw_descuentos.setItem(fila,'proforma',ld_proforma)
			
			//Facturado
			ld_facturado = f_total_facturado_concepto(ls_id_fase, ls_descuento,g_colegio_colegiado, '%', 'N')
			dw_descuentos.setItem(fila,'facturado',ld_facturado)
			
			//Facturado cobrado
			ld_facturado_cobrado = f_total_fact_cobrado_concepto(ls_id_fase, ls_descuento,g_colegio_colegiado, '%')
			dw_descuentos.setItem(fila,'fact_cobrado',ld_facturado_cobrado)
					
	next	
end if
	
dw_descuentos.sort()
dw_descuentos.groupCalc()
dw_descuentos.setredraw( true)
end event

on w_descuentos_colegiado.create
int iCurrent
call super::create
this.dw_descuentos=create dw_descuentos
this.cb_imprimir=create cb_imprimir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_descuentos
this.Control[iCurrent+2]=this.cb_imprimir
end on

on w_descuentos_colegiado.destroy
call super::destroy
destroy(this.dw_descuentos)
destroy(this.cb_imprimir)
end on

event open;call super::open;i_w = message.powerobjectparm

if i_w.idw_fases_colegiados.rowcount() <= 0 then return

this.triggerevent('csd_cargar_datos')


end event

event pfc_preopen;call super::pfc_preopen;f_centrar_ventana(this)
end event

type dw_descuentos from u_dw within w_descuentos_colegiado
integer x = 37
integer y = 40
integer width = 3131
integer height = 1500
integer taborder = 0
string dataobject = "d_descuentos_colegiado"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;//
long i

for i=1 to dw_descuentos.rowcount()
	
	
	
next
end event

type cb_imprimir from commandbutton within w_descuentos_colegiado
integer x = 2816
integer y = 1568
integer width = 334
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
end type

event clicked;dw_descuentos.print()
end event

