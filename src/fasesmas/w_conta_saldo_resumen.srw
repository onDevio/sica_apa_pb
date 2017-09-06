HA$PBExportHeader$w_conta_saldo_resumen.srw
$PBExportComments$Informaci$$HEX1$$f300$$ENDHEX$$n r$$HEX1$$e100$$ENDHEX$$pida del saldo contable
forward
global type w_conta_saldo_resumen from window
end type
type ejercicio_t from statictext within w_conta_saldo_resumen
end type
type cb_1 from commandbutton within w_conta_saldo_resumen
end type
type dw_1 from datawindow within w_conta_saldo_resumen
end type
end forward

global type w_conta_saldo_resumen from window
integer width = 2075
integer height = 1332
boolean titlebar = true
string title = "Atenci$$HEX1$$f300$$ENDHEX$$n colegiado con saldo deudor"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
event csd_calcula ( )
ejercicio_t ejercicio_t
cb_1 cb_1
dw_1 dw_1
end type
global w_conta_saldo_resumen w_conta_saldo_resumen

event csd_calcula;double saldo,total_saldo
string cuenta_arqui, id_col
long cuantos


id_col = dw_1.GetItemString(1,'id_colegiado')

select count(*) into :cuantos from conceptos_domiciliables where id_colegiado = :id_col and forma_de_pago = :g_formas_pago.domiciliacion;
if cuantos > 0 then 
	dw_1.SetItem(1, 'domiciliacion_bancaria','S')
else
	dw_1.SetItem(1, 'domiciliacion_bancaria','N')
end if

//C$$HEX1$$e100$$ENDHEX$$lculo del saldo
if g_existe_contabilidad = 'S' then
	cuenta_arqui = g_prefijo_arqui+'%'
	select sum(apuntes.debe -  apuntes.haber) into :saldo from apuntes,cuentas 
	where cuentas.cuenta = apuntes.cuenta and cuentas.id_col = :id_col and cuentas.cuenta like :cuenta_arqui using bd_ejercicio;
	if isnull(saldo) then saldo = 0
	saldo = saldo * -1
	dw_1.SetItem(1, 'cta_personal_saldo', saldo)
	if not f_es_vacio(g_prefijo_arqui_rf) and g_prefijo_arqui_rf <> g_prefijo_arqui then
		cuenta_arqui = g_prefijo_arqui_rf+'%'
		select sum(apuntes.debe -  apuntes.haber) into :saldo from apuntes,cuentas 
		where cuentas.cuenta = apuntes.cuenta and cuentas.id_col = :id_col and cuentas.cuenta like :cuenta_arqui using bd_ejercicio;
		if isnull(saldo) then saldo = 0
		saldo = saldo * -1
		dw_1.SetItem(1, 'cta_ret_saldo', saldo)
	end if
	if not f_es_vacio(g_prefijo_arqui_iva) and g_prefijo_arqui_iva <> g_prefijo_arqui and g_prefijo_arqui_iva <> g_prefijo_arqui_rf then
		cuenta_arqui = g_prefijo_arqui_iva+'%'
		select sum(apuntes.debe -  apuntes.haber) into :saldo from apuntes,cuentas 
		where cuentas.cuenta = apuntes.cuenta and cuentas.id_col = :id_col and cuentas.cuenta like :cuenta_arqui using bd_ejercicio;
		if isnull(saldo) then saldo = 0
		saldo = saldo * -1
		dw_1.SetItem(1, 'cta_iva_saldo', saldo)
	end if
end if

//C$$HEX1$$e100$$ENDHEX$$lculo de gastos
//select sum(total) into :saldo from csi_facturas_emitidas where id_persona = :id_col and tipo_persona = 'C' and pagado = 'N' and contabilizada = 'N';
//if isnull(saldo) then saldo = 0
//saldo = saldo * -1
//dw_1.SetItem(1, 'gastos', saldo)

//C$$HEX1$$e100$$ENDHEX$$lculo de honorarios
//select sum(total) into :saldo from csi_facturas_emitidas where emisor = :id_col and contabilizada = 'N';
//if isnull(saldo) then saldo = 0
//dw_1.SetItem(1, 'honorarios', saldo)
//
//C$$HEX1$$e100$$ENDHEX$$lculo de recibos
//if g_emite_recibos='N' then return
//select sum(total) into :saldo from csi_recibos where id_persona = :id_col and tipo_persona = 'C' and contabilizada = 'N';
//if isnull(saldo) then saldo = 0
//saldo = saldo * -1
//dw_1.SetItem(1, 'recibos', saldo)





end event

event open;string id_colegiado,es_sociedad
int cuantos
double ctas_saldo

this.visible = false

f_centrar_ventana(this)
dw_1.InsertRow(0)
if f_es_vacio(g_prefijo_arqui) then dw_1.setitem(1,'cta_personal_ver', 'N')
if f_es_vacio(g_prefijo_arqui_rf) then dw_1.setitem(1,'cta_ret_ver', 'N')
if f_es_vacio(g_prefijo_arqui_iva) then dw_1.setitem(1,'cta_iva_ver', 'N')

double  cta_personal_saldo , cta_ret_saldo , cta_iva_saldo , gastos , honorarios, recibos

id_colegiado = Message.StringParm

//Si tiene par$$HEX1$$e100$$ENDHEX$$metro de entrada es que lo estamos llamando desde otro m$$HEX1$$f300$$ENDHEX$$dulo pas$$HEX1$$e100$$ENDHEX$$ndole el par$$HEX1$$e100$$ENDHEX$$metro
//del colegiado
if not(f_es_vacio(id_colegiado)) then
	select count(*) into :cuantos from sociedades where id_col_per =:id_colegiado;
	if cuantos >0 then es_sociedad='S'
	dw_1.SetItem(1,'es_sociedad',es_sociedad)	
	dw_1.SetItem(1,'id_colegiado', id_colegiado)
	dw_1.SetItem(1,'n_colegiado', f_colegiado_n_col(id_colegiado))
 	 
	This.TriggerEvent('csd_calcula')
	cta_personal_saldo = dw_1.GetItemNumber(1,'cta_personal_saldo')
	cta_ret_saldo = dw_1.GetItemNumber(1,'cta_ret_saldo')
	cta_iva_saldo = dw_1.GetItemNumber(1,'cta_iva_saldo')
	gastos = dw_1.GetItemNumber(1,'gastos')
	honorarios = dw_1.GetItemNumber(1,'honorarios')
	recibos = dw_1.GetItemNumber(1,'recibos')


	
	SetPointer(Arrow!)
end if

double total_saldo

ctas_saldo =   /*(-1) * */ (cta_personal_saldo + cta_ret_saldo + cta_iva_saldo)
total_saldo =  cta_personal_saldo + cta_ret_saldo + cta_iva_saldo + gastos + honorarios + recibos

dw_1.SetItem(1,'cta_personal_txt','Saldo en cuenta personal:')
dw_1.SetItem(1,'cta_ret_txt','Saldo en cuenta de retenciones:')
dw_1.SetItem(1,'cta_iva_txt','Saldo en cuenta de IVA:')


// Modificado Ricardo 2005-05-09
// Veamos si estamos en un a$$HEX1$$f100$$ENDHEX$$o correcto
ejercicio_t.visible = (f_ejercicio_ya_abierto(g_ejercicio)<0)
// Modificado Ricardo 2005-05-09


if f_redondea(ctas_saldo) < 0 then
	this.visible = true
else
	close(this)
end if
//if not(f_es_vacio(Message.StringParm)) and total_saldo>=0 then close(this)
end event

on w_conta_saldo_resumen.create
this.ejercicio_t=create ejercicio_t
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.ejercicio_t,&
this.cb_1,&
this.dw_1}
end on

on w_conta_saldo_resumen.destroy
destroy(this.ejercicio_t)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type ejercicio_t from statictext within w_conta_saldo_resumen
boolean visible = false
integer x = 96
integer y = 96
integer width = 1833
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
string text = "Informaci$$HEX1$$f300$$ENDHEX$$n no v$$HEX1$$e100$$ENDHEX$$lida por estar en un ejercicio no abierto"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_conta_saldo_resumen
integer x = 736
integer y = 1064
integer width = 512
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
boolean cancel = true
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_conta_saldo_resumen
integer x = 96
integer y = 236
integer width = 1833
integer height = 716
integer taborder = 10
string title = "none"
string dataobject = "d_conta_saldo_resumen"
boolean border = false
boolean livescroll = true
end type

event itemchanged;double cuantos
string id_colegiado,es_sociedad='N'

if dwo.name = 'n_colegiado' then 
	SetPointer(HourGlass!)
	select count(*) into :cuantos from colegiados where n_colegiado = :data;	
	if cuantos=0 then 
		Messagebox(g_titulo,'El colegiado especificado no existe',StopSign!)
		return
	end if		
	id_colegiado = f_colegiado_id_col(data)
	select count(*) into :cuantos from sociedades where id_col_per =:id_colegiado;
	if cuantos >0 then es_sociedad='S'
	this.SetItem(1,'es_sociedad',es_sociedad)	
	this.SetItem(1,'id_colegiado', id_colegiado)
	Parent.PostEvent('csd_calcula')
	SetPointer(Arrow!)
end if

end event

event buttonclicked;string id_col,es_sociedad='N'
int cuantos

if dwo.name = 'b_busq' then
 	g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
	g_busqueda.dw="d_lista_busqueda_colegiados"
	id_col=f_busqueda_colegiados()   
	if NOT f_es_vacio(id_col)  then
		this.setitem(1,'n_colegiado',f_colegiado_n_col(id_col))
		this.setitem(1,'id_colegiado',id_col)
		select count(*) into :cuantos from sociedades where id_col_per =:id_col;
		if cuantos >0 then es_sociedad='S'
		this.SetItem(1,'es_sociedad',es_sociedad)	
		
		
	end if
end if
Parent.PostEvent('csd_calcula')
end event

