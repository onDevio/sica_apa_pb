HA$PBExportHeader$w_desglose_dip.srw
forward
global type w_desglose_dip from w_response
end type
type dw_1 from u_dw within w_desglose_dip
end type
type cb_cerrar from commandbutton within w_desglose_dip
end type
type cb_fraccionar from commandbutton within w_desglose_dip
end type
end forward

global type w_desglose_dip from w_response
integer width = 2126
dw_1 dw_1
cb_cerrar cb_cerrar
cb_fraccionar cb_fraccionar
end type
global w_desglose_dip w_desglose_dip

type variables
string is_id_fase
w_fases_detalle ventana
end variables

on w_desglose_dip.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_cerrar=create cb_cerrar
this.cb_fraccionar=create cb_fraccionar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_cerrar
this.Control[iCurrent+3]=this.cb_fraccionar
end on

on w_desglose_dip.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_cerrar)
destroy(this.cb_fraccionar)
end on

event open;call super::open;//string is_id_fase
long linea,i
double dip_base, porcen_iva,porcen_col,dip_col


ventana=g_detalle_fases

is_id_fase=Message.StringParm


linea=ventana.idw_fases_informes.Find("tipo_informe='"+g_codigos_conceptos.cip+"'",1,ventana.idw_fases_informes.rowcount())
dip_base=ventana.idw_fases_informes.GetItemNumber(linea,'cuantia_colegiado')
porcen_iva=f_dame_porcent_iva (ventana.idw_fases_informes.GetItemString(linea,'t_iva'))


dw_1.retrieve(is_id_fase)

for i=1 to dw_1.rowcount()		
	porcen_col=dw_1.GetItemNumber(i,'porcen_a')
	dip_col=dip_base*porcen_col/100
	dw_1.SetItem(i,'dip_base',dip_col)
	dw_1.SetItem(i,'dip_iva',dip_col*porcen_iva/100)	
	if dip_col <= 100 or f_dip_desglosado(is_id_fase,dw_1.GetItemString(i,'id_col'))=0 then
		dw_1.SetItem(i,'procesar','N')
	end if
next


end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_desglose_dip
integer x = 1929
integer y = 1292
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_desglose_dip
integer x = 1422
integer y = 1292
end type

type dw_1 from u_dw within w_desglose_dip
integer x = 32
integer y = 28
integer width = 2062
integer height = 1132
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_desglose_dip"
boolean border = false
boolean ib_isupdateable = false
end type

event buttonclicked;call super::buttonclicked;string id_minuta,n_aviso,id_cliente,forma_pago,id_col,banco
double irpf,porcen,iva_cip
datetime fecha
string pagador,t_iva
double porc_iva,total_cliente,total_aviso
double base_col,iva_col,total_col
double cantidad_restante,cantidad_aviso

irpf = g_irpf_por_defecto
fecha = datetime(today())
pagador = '1'
t_iva = g_t_iva_defecto
porc_iva =  f_dame_porcent_iva(g_t_iva_defecto)
forma_pago='FR' // FRACCIONADO
//base_musaat = musaat
total_cliente = 0

select id_cliente,max(porcen)  into :id_cliente,:porcen from fases_clientes where id_fase=:is_id_fase;

id_col=dw_1.GetItemString(row,'id_col')
base_col=dw_1.GetItemNumber(row,'dip_base')
iva_col=dw_1.GetItemNumber(row,'dip_iva')
total_col=dw_1.GetItemNumber(row,'total')
cantidad_restante=base_col
cantidad_aviso=100

banco=g_banco_por_defecto
do
	id_minuta = f_siguiente_numero('FASES-MINUTAS',10)
	n_aviso = f_numera_aviso(true) // Modificado Ricardo 2005-05-12
	iva_cip=f_redondea(cantidad_aviso*0.16)
	total_aviso=cantidad_aviso+iva_cip

	
	INSERT INTO fases_minutas  
		( id_minuta, id_fase, id_colegiado, id_cliente, cantidad, pendiente, facturado, id_honorario,   
		  f_facturado, id_factura, tipo_minuta, irpf, importe_irpf, n_aviso, fecha, fecha_pago,   
		  tipo_gestion, pagador, reclamar, t_iva, porc_iva, forma_pago, aplica_honos, porc_honos,   
		  concepto_honos, base_honos, iva_honos, aplica_desplaza, base_desplaza, iva_desplaza,   
		  concepto_desplaza, aplica_dv, base_dv, iva_dv, aplica_cip, base_cip, iva_cip, aplica_musaat,   
		  base_musaat, iva_musaat, aplica_retvol, porc_retvol, base_retvol, iva_retvol, total_cliente,   
		  total_colegiado, t_iva_honos, t_iva_desplaza, t_iva_dv, t_iva_cip, porc_iva_honos,   
		  porc_iva_desplaza, porc_iva_dv, porc_iva_cip, anulada, banco, irpf_cliente, observaciones,
		  base_garantia, total_aviso, aplica_impresos, t_iva_impresos, porc_iva_impresos, base_impresos,
		  iva_impresos, paga_asalariado, paga_externo, paga_dv, t_minuta, urgente,
		  base_cip_suplida, t_iva_cip_suplida, porc_iva_cip_suplida, iva_cip_suplida, musaat_suplida)
	VALUES 
		( :id_minuta, :is_id_fase, :id_col, :id_cliente, null, 'S', 'N', null, 
			null, null, '00', :irpf, 0, :n_aviso, :fecha, null,   
		  'S', :pagador, 'S', :t_iva, :porc_iva, :forma_pago, 'N', 0, 
		  null, 0, 0, 'N',  0, 0,   
		  null, 'N', 0, 0, 'S', :cantidad_aviso, :iva_cip, 'N',   
		  0, 0, 'N', 0, 0, 0, :total_cliente,   
		  :total_aviso, '16','00', '16', '16', null,   
		  0, 16 ,16, 'N', :banco, 'N', null,
		  0, :cantidad_aviso, 'N', '00', 0, 0,
		  0, 'N', 'N', 'C', 'P', 'N',
		  0,null,0,0,0)  ;
	
	COMMIT;
	
	fecha=datetime(RelativeDate(date(fecha),90))

	cantidad_restante=cantidad_restante - 100
	if cantidad_restante<100 then	cantidad_aviso=cantidad_restante
loop while cantidad_restante>0

ventana.idw_fases_minutas.retrieve(is_id_fase)


end event

type cb_cerrar from commandbutton within w_desglose_dip
integer x = 750
integer y = 1252
integer width = 347
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cerrar"
end type

event clicked;Close(parent)
end event

type cb_fraccionar from commandbutton within w_desglose_dip
integer x = 155
integer y = 1252
integer width = 535
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Pago Fraccionado"
end type

event clicked;long i

for i=1 to dw_1.rowcount()
	if dw_1.GetITemString(i,'procesar')='S' then
		dw_1.event buttonclicked(i,0,dw_1.object.b_fraccionar)
		dw_1.SetITem(i,'procesar','N')
	end if
next

MessageBox("Proceso Finalizado","Se han generado todos los avisos para los colegiados seleccionados.")
end event

