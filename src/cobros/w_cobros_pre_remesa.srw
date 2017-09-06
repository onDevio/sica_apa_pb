HA$PBExportHeader$w_cobros_pre_remesa.srw
forward
global type w_cobros_pre_remesa from w_response
end type
type st_aviso2 from statictext within w_cobros_pre_remesa
end type
type cb_3 from commandbutton within w_cobros_pre_remesa
end type
type cb_2 from commandbutton within w_cobros_pre_remesa
end type
type cb_1 from commandbutton within w_cobros_pre_remesa
end type
type cb_f19 from commandbutton within w_cobros_pre_remesa
end type
type cb_actualiza from commandbutton within w_cobros_pre_remesa
end type
type dw_datos_remesa from u_dw within w_cobros_pre_remesa
end type
type st_aviso from statictext within w_cobros_pre_remesa
end type
type dw_extracto_remesa_ncol from u_dw within w_cobros_pre_remesa
end type
type dw_apuntes_dom from u_dw within w_cobros_pre_remesa
end type
type gb_1 from groupbox within w_cobros_pre_remesa
end type
type dw_mas_datos from u_dw within w_cobros_pre_remesa
end type
type dw_domiciliaciones from u_dw within w_cobros_pre_remesa
end type
type cb_recibir_f19 from commandbutton within w_cobros_pre_remesa
end type
type dw_extracto_remesa from u_dw within w_cobros_pre_remesa
end type
type st_1 from statictext within w_cobros_pre_remesa
end type
type cb_domicilia_cobros from commandbutton within w_cobros_pre_remesa
end type
type cb_domicilia_saldos from commandbutton within w_cobros_pre_remesa
end type
end forward

global type w_cobros_pre_remesa from w_response
integer width = 4096
integer height = 2484
string title = "Generaci$$HEX1$$f300$$ENDHEX$$n de Remesa de Domiciliaciones"
event csd_generar_domiciliaciones_cobros ( integer i )
event csd_generar_f19 ( )
event csd_domicilia_cobros ( )
event csd_datos_remesa ( )
event csd_generar_domiciliaciones_saldos ( integer i )
event type integer csd_comprueba_datos ( )
st_aviso2 st_aviso2
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
cb_f19 cb_f19
cb_actualiza cb_actualiza
dw_datos_remesa dw_datos_remesa
st_aviso st_aviso
dw_extracto_remesa_ncol dw_extracto_remesa_ncol
dw_apuntes_dom dw_apuntes_dom
gb_1 gb_1
dw_mas_datos dw_mas_datos
dw_domiciliaciones dw_domiciliaciones
cb_recibir_f19 cb_recibir_f19
dw_extracto_remesa dw_extracto_remesa
st_1 st_1
cb_domicilia_cobros cb_domicilia_cobros
cb_domicilia_saldos cb_domicilia_saldos
end type
global w_cobros_pre_remesa w_cobros_pre_remesa

type variables
u_dw i_dw_lista_cobros
st_cobros_datos_remesa i_datos_remesa
datastore i_ds_domiciliaciones
string i_banco
string i_lista_no_validos
string i_n_remesa
int i_generadas=0,i_falladas=0
powerobject i_retorno
boolean i_datos_actualizados=false

//Domiciliaciones de Saldos Deudores
string in_banco
string iult_ast,i_modulo
datetime i_fecha_apuntes
double iimporte_total

boolean ib_pulsado_salir = false
end variables

forward prototypes
public subroutine wf_dame_datos_cliente (string id_cliente, ref string nom, ref string ape, ref string da, ref string pa, ref string nif)
public function integer wf_genera_f19 (st_cobros_datos_remesa datos_remesa, string formato)
end prototypes

event csd_generar_domiciliaciones_cobros(integer i);string banco,iban,ls_iban_banco_remesa,id_persona,id_factura,asunto,banco_dom,bic,n_colegi,n_fact,nombre_apellidos,id_cobro
double row,j,imp_total
string  tipo_banco, descripcion_error, anulada
boolean b_error = false
string id_fase, id_empresa, id_fase_real	
string paga_empresa,paga_externo,imprime_cta_banco_col,id_cliente_pagador

id_persona	=i_dw_lista_cobros.GetItemString(i,'id_persona')
id_factura	=i_dw_lista_cobros.GetItemString(i,'id_factura')
id_cobro		=i_dw_lista_cobros.GetItemString(i,'id_pago')

banco_dom = i_dw_lista_cobros.GetItemString(i,'banco')
n_fact = i_dw_lista_cobros.GetItemString(i,'n_fact')
if f_es_vacio(n_fact) then n_fact = ''

CHOOSE CASE i_modulo
	CASE 'CLIENTES'
		nombre_apellidos = f_dame_cliente(id_persona)
		select datos_bancarios_iban, bic into :iban, :bic from clientes where id_cliente = :id_persona;
	CASE 'COLEGIADOS'
		nombre_apellidos = f_colegiado_apellido(id_persona)
		if f_es_vacio(nombre_apellidos) then nombre_apellidos = ''
		tipo_banco = dw_datos_remesa.getitemstring(1, 'cuenta_cargo')
		choose case tipo_banco
			case 'E'
				select datos_bancarios_iban, bic into :iban, :bic from conceptos_domiciliables where id_colegiado = :id_persona and forma_de_pago = :g_formas_pago.domiciliacion and concepto = :g_conta.concepto_exp;
			case else
				select datos_bancarios_iban, bic into :iban, :bic from colegiados where id_colegiado = :id_persona;
		end choose
		
	CASE 'COBROS'
		CHOOSE CASE i_dw_lista_cobros.GetItemString(i,'csi_facturas_emitidas_tipo_persona')
			CASE 'P'
				// Cliente
				nombre_apellidos = f_dame_cliente(id_persona)
				select datos_bancarios_iban, bic into :iban, :bic from clientes where id_cliente = :id_persona;
			CASE 'C'
				// Colegiado
				nombre_apellidos = f_colegiado_apellido(id_persona)
				if f_es_vacio(nombre_apellidos) then nombre_apellidos = ''
				//select datos_bancarios into :iban from conceptos_domiciliables where id_colegiado = :id_persona and forma_de_pago = :g_formas_pago.domiciliacion;
				tipo_banco = dw_datos_remesa.getitemstring(1, 'cuenta_cargo')
				choose case tipo_banco
					case 'E'
						select datos_bancarios_iban, bic into :iban, :bic from conceptos_domiciliables where id_colegiado = :id_persona and forma_de_pago = :g_formas_pago.domiciliacion and concepto = :g_conta.concepto_exp;
												
					case else
						//SCP-815 Separamos el comportamiento de las facturas y las facturas que vienen de aviso.					
						select id_fase into :id_fase from csi_facturas_emitidas where id_factura = :id_factura;
						if not f_es_vacio(id_fase) then
							select id_fase into :id_fase_real from fases_minutas where id_minuta = :id_fase ;
							select datos_bancarios_iban, bic into :iban, :bic from colegiados where id_colegiado = :id_persona;
							if (f_minutas_paga_asalariado(id_fase)='S') then 
								select datos_bancarios_iban, bic into :iban, :bic from colegiados where id_colegiado = :id_persona;
								nombre_apellidos = f_colegiado_apellido(id_persona)
							end if
							if (f_minutas_paga_externo(id_fase)='S') then
								select clientes.datos_bancarios_iban, bic into :iban, :bic from fases_colegiados, clientes where clientes.id_cliente = fases_colegiados.id_empresa and id_fase = :id_fase_real  and id_col = :id_persona ;
							end if
						else
							select paga_empresa,paga_externo,imprime_cta_banco_col,id_cliente_pagador into :paga_empresa, :paga_externo, :imprime_cta_banco_col, :id_cliente_pagador from csi_facturas_emitidas where id_factura= :id_factura;
							//Caso general
							select datos_bancarios_iban, bic into :iban, :bic from colegiados where id_colegiado = :id_persona;
							//Casos especiales
							if (paga_empresa='S' or paga_externo='S') and imprime_cta_banco_col='N' then
								select datos_bancarios_iban, bic into :iban, :bic from clientes where clientes.id_cliente = :id_cliente_pagador;
							elseif (paga_empresa='S' or paga_externo='S') and imprime_cta_banco_col='S' then
								select datos_bancarios_iban, bic into :iban, :bic from colegiados where id_colegiado = :id_persona;
							end if
						end if
				end choose
		END CHOOSE
END CHOOSE

IF f_es_vacio(iban) then iban = ''
IF f_es_vacio(bic) then bic = ''
descripcion_error = ''

IF NOT( gnv_control_cuentas_bancarias.of_comprobar_iban(iban)) THEN 
	i_lista_no_validos= i_lista_no_validos +n_fact + '   '+ nombre_apellidos+cr
	descripcion_error += 'Cuenta no v$$HEX1$$e100$$ENDHEX$$lida para '+ nombre_apellidos+' (cuenta: '+iban+' ) '
	b_error = true
end if
bic= gnv_control_cuentas_bancarias.of_bic(iban, bic) // asigna BIC por defecto desde Bancos Maestro para IBAN, si BIC actual no es v$$HEX1$$e100$$ENDHEX$$lido
IF f_var_global_sn('SEPA_BIC_obligatorio')='S' AND NOT( gnv_control_cuentas_bancarias.of_comprobar_bic( bic)) THEN 
	i_lista_no_validos= i_lista_no_validos +n_fact + '   '+ nombre_apellidos+cr
	descripcion_error += 'BIC no v$$HEX1$$e100$$ENDHEX$$lido para '+ nombre_apellidos+' (BIC: '+bic+' ) '
	b_error = true
END IF

// Si el cobro es negativo, protestamos
if i_dw_lista_cobros.GetItemNumber(i,'importe')<0 then
	descripcion_error += 'No pueden domiciliarse facturas con importe negativo '
	b_error = true
else
	// Si la factura es una de anulacion, avisamos tambien
	select anulada into :anulada from csi_facturas_emitidas, csi_cobros where csi_facturas_emitidas.id_factura = csi_cobros.id_factura and id_pago = :id_cobro;
	if isnull(anulada) then anulada = 'N'
	if anulada = 'S' then
		descripcion_error += 'El cobro corresponde a una factura de anulaci$$HEX1$$f300$$ENDHEX$$n positiva '
		b_error = true
	end if	
end if	


// Incrementamos las domiciliaciones generadas
if not b_error then i_generadas++ else i_falladas++

//El asunto de la factura ser$$HEX2$$e1002000$$ENDHEX$$lo que vaya en el campo concepto del fichero F19
asunto = i_datos_remesa.concepto
if f_es_vacio(asunto) then 
	select asunto into :asunto from csi_facturas_emitidas where id_factura = :id_factura;
	if f_es_vacio(asunto) then asunto = 'RECIBO DOMICILIADO ' + g_colegio
end if

row=dw_domiciliaciones.InsertRow(0)
string id_domiciliacion
id_domiciliacion = f_siguiente_numero('DOMICILIACION',10) // modificado Ricardo 04-02-25
dw_domiciliaciones.SetItem(row,'id_domiciliacion',id_domiciliacion)// modificado Ricardo 04-02-25
dw_domiciliaciones.SetItem(row,'n_fact',n_fact)
if not b_error then 
	dw_domiciliaciones.SetItem(row,'activo','S') 
else
	dw_domiciliaciones.SetItem(row,'activo','N')
	dw_domiciliaciones.SetItem(row,'observaciones',descripcion_error) 
end if
dw_domiciliaciones.SetItem(row,'fecha',i_datos_remesa.fecha)
dw_domiciliaciones.SetItem(row,'remesado','N')
dw_domiciliaciones.SetItem(row,'id_col',id_persona)
CHOOSE CASE i_modulo
	CASE 'COLEGIADOS'
		n_colegi = i_dw_lista_cobros.GetItemString(i,'n_col')
		if f_es_vacio(n_colegi) then n_colegi=''
		dw_domiciliaciones.SetItem(row,'nombre',f_colegiado_nombre_apellido(id_persona))
		dw_domiciliaciones.SetItem(row,'n_arqui',n_colegi)
		dw_domiciliaciones.SetItem(row,'n_col',n_colegi) 
		dw_domiciliaciones.SetItem(row, 'tipo_persona', 'C') // POnemos que es un colegiado
	CASE 'CLIENTES'
		n_colegi = f_dame_nif(id_persona)
		if f_es_vacio(n_colegi) then n_colegi=''
		dw_domiciliaciones.SetItem(row,'nombre',nombre_apellidos)
		dw_domiciliaciones.SetItem(row,'n_arqui',f_dame_nif(id_persona))
		dw_domiciliaciones.SetItem(row,'n_col',dw_domiciliaciones.GetItemString(row,'n_arqui') )
		dw_domiciliaciones.SetItem(row, 'tipo_persona', 'P') // POnemos que es un cliente
	CASE 'COBROS'
		dw_domiciliaciones.SetItem(row, 'tipo_persona', i_dw_lista_cobros.GetItemString(i,'csi_facturas_emitidas_tipo_persona'))
		CHOOSE CASE i_dw_lista_cobros.GetItemString(i,'csi_facturas_emitidas_tipo_persona')
			CASE 'C'
				if (f_minutas_paga_externo(id_fase)='S') then
					select id_empresa into :id_empresa from fases_colegiados where id_fase = :id_fase_real  and id_col = :id_persona ;
					n_colegi = f_dame_nif(id_empresa)
					nombre_apellidos = f_dame_cliente(id_empresa)
					if f_es_vacio(n_colegi) then n_colegi=''
					dw_domiciliaciones.SetItem(row,'nombre',nombre_apellidos)
					dw_domiciliaciones.SetItem(row,'n_arqui',f_dame_nif(id_empresa))
					dw_domiciliaciones.SetItem(row,'n_col',dw_domiciliaciones.GetItemString(row,'n_arqui') )
					dw_domiciliaciones.SetItem(row, 'tipo_persona', 'P') // Ponemos que es un cliente
					dw_domiciliaciones.SetItem(row,'id_col',id_empresa)
				else
					n_colegi = i_dw_lista_cobros.GetItemString(i,'n_col')
					if f_es_vacio(n_colegi) then n_colegi=''
					dw_domiciliaciones.SetItem(row,'nombre',f_colegiado_nombre_apellido(id_persona))
					dw_domiciliaciones.SetItem(row,'n_arqui',n_colegi)
					dw_domiciliaciones.SetItem(row,'n_col',n_colegi) 
				end if
			CASE 'P'
				n_colegi = f_dame_nif(id_persona)
				if f_es_vacio(n_colegi) then n_colegi=''
				dw_domiciliaciones.SetItem(row,'nombre',nombre_apellidos)
				dw_domiciliaciones.SetItem(row,'n_arqui',f_dame_nif(id_persona))
				dw_domiciliaciones.SetItem(row,'n_col',dw_domiciliaciones.GetItemString(row,'n_arqui') )
		END CHOOSE
END CHOOSE
dw_domiciliaciones.SetItem(row,'referencia',id_cobro)
dw_domiciliaciones.SetItem(row,'cod_devol',f_dame_nif(id_persona))
dw_domiciliaciones.SetItem(row,'importe',i_dw_lista_cobros.GetItemNumber(i,'importe'))
dw_domiciliaciones.SetItem(row,'concepto',asunto)  
dw_domiciliaciones.SetItem(row,'banco_dom',gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban( iban))
dw_domiciliaciones.SetItem(row,'iban',iban)
dw_domiciliaciones.SetItem(row,'bic',bic)
dw_domiciliaciones.SetItem(row,'cod_banco',i_datos_remesa.banco)
dw_domiciliaciones.SetItem(row,'cancelada','N')
dw_domiciliaciones.SetItem(row,'documento','')
dw_domiciliaciones.SetItem(row,'tipo','A')  //Tipo 'Aportaciones + Informes Exp.'
dw_domiciliaciones.SetItem(row,'empresa',g_empresa)


select nombre, cuenta_bancaria_iban into :banco, :ls_iban_banco_remesa from csi_bancos where codigo = :i_datos_remesa.banco;
//Rellenamos tambi$$HEX1$$e900$$ENDHEX$$n el extracto Resumen por orden de apellidos
row=dw_extracto_remesa.InsertRow(0)
dw_extracto_remesa.SetItem(row,'id_domiciliacion',id_domiciliacion)// modificado Ricardo 04-02-25
dw_extracto_remesa.SetItem(row,'fecha',i_datos_remesa.fecha)
dw_extracto_remesa.SetItem(row,'importe',i_dw_lista_cobros.GetItemNumber(i,'importe'))
dw_extracto_remesa.SetItem(row,'banco_dom',gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban( iban))
dw_extracto_remesa.SetItem(row,'iban',iban)
dw_extracto_remesa.SetItem(row,'bic',bic)
dw_extracto_remesa.SetItem(row,'n_arqui',n_colegi)
dw_extracto_remesa.SetItem(row,'colegiados_apellidos',nombre_apellidos)
dw_extracto_remesa.SetItem(row,'colegiados_nombre','')
dw_extracto_remesa.SetItem(row,'csi_bancos_nombre',banco)
dw_extracto_remesa.SetItem(row,'csi_bancos_cuenta_bancaria_iban',ls_iban_banco_remesa)
dw_extracto_remesa.SetItem(row,'n_fact',n_fact)
dw_extracto_remesa.SetItem(row,'ref_interna',i_n_remesa)

//Rellenamos tambi$$HEX1$$e900$$ENDHEX$$n el extracto Resumen por orden de colegiados
row=dw_extracto_remesa_ncol.InsertRow(0)
dw_extracto_remesa_ncol.SetItem(row,'id_domiciliacion',id_domiciliacion)// modificado Ricardo 04-02-25
dw_extracto_remesa_ncol.SetItem(row,'fecha',i_datos_remesa.fecha)
dw_extracto_remesa_ncol.SetItem(row,'importe',i_dw_lista_cobros.GetItemNumber(i,'importe'))
dw_extracto_remesa_ncol.SetItem(row,'banco_dom',gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban( iban))
dw_extracto_remesa_ncol.SetItem(row,'iban',iban)
dw_extracto_remesa_ncol.SetItem(row,'bic',bic)
dw_extracto_remesa_ncol.SetItem(row,'n_arqui',n_colegi)
dw_extracto_remesa_ncol.SetItem(row,'colegiados_apellidos',nombre_apellidos)
dw_extracto_remesa_ncol.SetItem(row,'colegiados_nombre','')
dw_extracto_remesa_ncol.SetItem(row,'csi_bancos_nombre',banco)
dw_extracto_remesa_ncol.SetItem(row,'csi_bancos_cuenta_bancaria_iban',ls_iban_banco_remesa)
//dw_extracto_remesa_ncol.SetItem(row,'n_fact',n_fact)
dw_extracto_remesa_ncol.SetItem(row,'ref_interna',i_n_remesa)

i_dw_lista_cobros.SetItem(i,'remesar','S')



end event

event csd_generar_f19();
string formato
formato = dw_datos_remesa.getitemstring(dw_datos_remesa.getRow(), 'formato_trans')
if f_es_vacio(formato) then 
        messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.formato_exportacion_fichero',"Debe indicar el formato de exportaci$$HEX1$$f300$$ENDHEX$$n del fichero"))
        return
end if
// SEG$$HEX1$$da00$$ENDHEX$$N EL TIPO DE FORMATO ELEGIDO ACTUA
st_aviso.text='Generando fichero F19'
if wf_genera_f19(i_datos_remesa, formato) < 0 then return
st_aviso.Text='Proceso Finalizado'
st_aviso.text=''

end event

event csd_domicilia_cobros();double i

this.TriggerEvent('csd_datos_remesa')
SetNull(i_retorno)
if i_datos_remesa.banco = '-1' then return
i_lista_no_validos=''

dw_domiciliaciones.Reset()
dw_extracto_remesa.Reset()
SetPointer(HourGlass!)
//Creamos las domicilicaciones a partir de los cobros existentes
for i=1 to i_dw_lista_cobros.RowCount()
	//st_aviso.Text ='Tramitando Cobros : '+ string(i) + ' de '+ string(i_dw_lista_cobros.RowCount())
	if i_dw_lista_cobros.GetItemString(i,'forma_pago')=g_formas_pago.domiciliacion and i_dw_lista_cobros.GetItemString(i,'pagado')<>'S' then
//		i_dw_lista_cobros.SetItem(i,'pagado','S')
		i_banco = i_dw_lista_cobros.GetItemString(i,'banco')
     	this.Event csd_generar_domiciliaciones_cobros(i)
		st_aviso.text = 'Generadas : '+string(i_generadas)+ ' domiciliaciones.'
		st_aviso2.text ='Falladas  : '+string(i_falladas)+ ' domiciliaciones.'
	end if
next

if i_lista_no_validos<>'' then Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.error_datos_banco_colegiados','Los datos bancarios de los siguientes colegiados no son correctos. Las facturas han sido ')&
	   +g_idioma.of_getmsg('msg_cobros.pantalla_indica_error','colocadas en pantalla indicando el motivo de error para su posible correcci$$HEX1$$f300$$ENDHEX$$n.')+cr+i_lista_no_validos)

	
	
end event

event csd_datos_remesa();
dw_datos_remesa.AcceptText()

i_datos_remesa.banco 			= dw_datos_remesa.GetItemString(1,'banco')
i_datos_remesa.codigo			= dw_datos_remesa.GetItemString(1,'codigo')
i_datos_remesa.fecha				= dw_datos_remesa.GetItemDateTime(1,'fecha')
i_datos_remesa.cuenta_banco	= dw_datos_remesa.GetItemString(1,'cuenta_banco')
i_datos_remesa.concepto			= dw_datos_remesa.GetItemString(1,'concepto')
i_datos_remesa.desglosar		= dw_datos_remesa.GetItemString(1,'desglosar')
i_datos_remesa.ordenar			= dw_datos_remesa.GetItemString(1,'ordenar')
i_datos_remesa.descripcion		= dw_datos_remesa.GetItemString(1,'descripcion')
i_datos_remesa.n_remesa			= dw_mas_datos.GetItemString(1,'n_remesa')
i_datos_remesa.formato			= dw_datos_remesa.GetItemString(1,'formato_norma')

end event

event csd_generar_domiciliaciones_saldos(integer i);string banco,iban,bic,id_col,n_col,concepto,nombre_apellidos,cta_banco,ls_iban_banco_remesa,cuenta_cargo
double row,j,imp_total,updte,importe_a_domiciliar
st_apunte datos_apunte

id_col=i_dw_lista_cobros.GetItemString(i,'cuentas_id_col')
cuenta_cargo = dw_datos_remesa.getitemstring(1, 'cuenta_cargo')

choose case cuenta_cargo
	case 'E'
		select datos_bancarios_iban, bic into :iban, :bic from conceptos_domiciliables where id_colegiado = :id_col and concepto = :g_conta.concepto_exp;
	case else
		select datos_bancarios_iban, bic into :iban, :bic from colegiados where id_colegiado = :id_col;
end choose
		
nombre_apellidos = f_colegiado_nombre_apellido(id_col)
IF f_es_vacio(iban) then iban = ''
IF f_es_vacio(bic) then bic = ''

bic= gnv_control_cuentas_bancarias.of_bic(iban, bic) // asigna BIC por defecto desde Bancos Maestro para IBAN, si BIC actual no es v$$HEX1$$e100$$ENDHEX$$lido
IF NOT( gnv_control_cuentas_bancarias.of_comprobar_iban(iban)) OR (f_var_global_sn('SEPA_BIC_obligatorio')='S' AND NOT( gnv_control_cuentas_bancarias.of_comprobar_bic(bic)) ) THEN
	i_lista_no_validos+= '   '+ nombre_apellidos+ ' (Cuenta: '+iban+', BIC: '+bic+' ) '+cr
	i_falladas++
	return
end if
i_generadas++

importe_a_domiciliar = i_dw_lista_cobros.GetItemNumber(i,'saldo')
iimporte_total = iimporte_total + importe_a_domiciliar
n_col = f_colegiado_n_col(id_col)

if f_es_vacio(i_datos_remesa.concepto) then 
	concepto = 'DOMICILIACION DE SALDO DEUDOR '+g_colegio
else 
	concepto = i_datos_remesa.concepto
end if

string id_domiciliacion 
row=dw_domiciliaciones.InsertRow(0)
id_domiciliacion = f_siguiente_numero('DOMICILIACION',10) // Modificado Ricardo 04-02-25
dw_domiciliaciones.SetItem(row,'id_domiciliacion',id_domiciliacion)// Modificado Ricardo 04-02-25
dw_domiciliaciones.SetItem(row,'fecha',i_fecha_apuntes)
dw_domiciliaciones.SetItem(row,'remesado','N')
dw_domiciliaciones.SetItem(row,'id_col',id_col)
dw_domiciliaciones.SetItem(row,'n_arqui',n_col)
dw_domiciliaciones.SetItem(row,'referencia',n_col)
dw_domiciliaciones.SetItem(row,'cod_devol',n_col)
dw_domiciliaciones.SetItem(row,'importe',importe_a_domiciliar) 
dw_domiciliaciones.SetItem(row,'banco_dom',gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban(iban))
dw_domiciliaciones.SetItem(row,'iban',iban)
dw_domiciliaciones.SetItem(row,'bic',bic)
dw_domiciliaciones.SetItem(row,'cod_banco',in_banco)
dw_domiciliaciones.SetItem(row,'concepto',concepto)  
dw_domiciliaciones.SetItem(row,'cancelada','N')
dw_domiciliaciones.SetItem(row,'documento','')  
dw_domiciliaciones.SetItem(row,'tipo','C')  
dw_domiciliaciones.SetItem(row,'n_col',n_col) 
dw_domiciliaciones.SetItem(row,'activo','S')
dw_domiciliaciones.modify("activo.protect = '1'")
dw_domiciliaciones.SetItem(row,'empresa',g_empresa)

updte= dw_domiciliaciones.Update()

select nombre,cuenta_bancaria_iban into :banco,:ls_iban_banco_remesa from csi_bancos where codigo = :i_datos_remesa.banco;
cta_banco= gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban( ls_iban_banco_remesa)
//Rellenamos tambi$$HEX1$$e900$$ENDHEX$$n el extracto Resumen por orden de apellidos
row=dw_extracto_remesa.InsertRow(0)
dw_extracto_remesa.SetItem(row,'id_domiciliacion',id_domiciliacion)// Modificado Ricardo 04-02-25
dw_extracto_remesa.SetItem(row,'fecha',i_datos_remesa.fecha)
dw_extracto_remesa.SetItem(row,'importe',i_dw_lista_cobros.GetItemNumber(i,'saldo'))
dw_extracto_remesa.SetItem(row,'banco_dom',gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban( iban))
dw_extracto_remesa.SetItem(row,'iban',iban)
dw_extracto_remesa.SetItem(row,'bic',bic)
dw_extracto_remesa.SetItem(row,'n_arqui',n_col)
dw_extracto_remesa.SetItem(row,'colegiados_apellidos',nombre_apellidos)
dw_extracto_remesa.SetItem(row,'colegiados_nombre','')
dw_extracto_remesa.SetItem(row,'csi_bancos_nombre',banco)
dw_extracto_remesa.SetItem(row,'csi_bancos_cuenta_banco',cta_banco)
dw_extracto_remesa.SetItem(row,'csi_bancos_cuenta_bancaria_iban',ls_iban_banco_remesa)
dw_extracto_remesa.SetItem(row,'ref_interna',i_n_remesa)

//Rellenamos tambi$$HEX1$$e900$$ENDHEX$$n el extracto Resumen por orden de colegiados
row=dw_extracto_remesa_ncol.InsertRow(0)
dw_extracto_remesa_ncol.SetItem(row,'id_domiciliacion',id_domiciliacion)// Modificado Ricardo 04-02-25
dw_extracto_remesa_ncol.SetItem(row,'fecha',i_datos_remesa.fecha)
dw_extracto_remesa_ncol.SetItem(row,'importe',i_dw_lista_cobros.GetItemNumber(i,'saldo'))
dw_extracto_remesa_ncol.SetItem(row,'banco_dom',gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban( iban))
dw_extracto_remesa_ncol.SetItem(row,'iban',iban)
dw_extracto_remesa_ncol.SetItem(row,'bic',bic)
dw_extracto_remesa_ncol.SetItem(row,'n_arqui',n_col)
dw_extracto_remesa_ncol.SetItem(row,'colegiados_apellidos',nombre_apellidos)
dw_extracto_remesa_ncol.SetItem(row,'colegiados_nombre','')
dw_extracto_remesa_ncol.SetItem(row,'csi_bancos_nombre',banco)
dw_extracto_remesa_ncol.SetItem(row,'csi_bancos_cuenta_banco',cta_banco)
dw_extracto_remesa_ncol.SetItem(row,'csi_bancos_cuenta_bancaria_iban',ls_iban_banco_remesa)
dw_extracto_remesa_ncol.SetItem(row,'ref_interna',i_n_remesa)

string ctabanco
select cuenta_contable into :ctabanco from csi_bancos where codigo = : i_datos_remesa.banco;
// Modificado Ricardo 04-03-18
if g_contabilidad_automatica then
	//Apuntes colegiados 
	datos_apunte.diario = g_sica_diario.domic_saldo
	datos_apunte.n_asiento = iult_ast
	datos_apunte.n_apunte = g_apunte.n_apunte
	datos_apunte.cuenta = i_dw_lista_cobros.GetItemString(i,'cuenta')
	datos_apunte.fecha = datetime(date(i_fecha_apuntes), time("00:00:00"))
	datos_apunte.t_doc = g_sica_t_doc.domic_saldo
	datos_apunte.concepto = concepto
	datos_apunte.debe = 0
	datos_apunte.haber = importe_a_domiciliar
	if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
	datos_apunte.proyecto = g_explotacion_por_defecto
	datos_apunte.n_doc = ''
	datos_apunte.centro = g_centro_por_defecto
	datos_apunte.t_asiento = g_t_asiento_apuntes_automaticos
	datos_apunte.contrapartida= ctabanco
	
	f_apunte_dw(datos_apunte,dw_apuntes_dom,'E')
end if

end event

event type integer csd_comprueba_datos();string mensaje ='', banco, iban

dw_datos_remesa.accepttext()

mensaje+= f_valida(dw_datos_remesa,'banco','NONULO',g_idioma.of_getmsg('msg_cobros.valor_campo_banco','Debe especificar un valor en el campo Banco.'))
mensaje+= f_valida(dw_datos_remesa,'fecha','NONULO',g_idioma.of_getmsg('msg_cobros.valor_campo_fecha','Debe especificar un valor en el campo Fecha.'))

banco = dw_datos_remesa.GetItemString(1,'banco')
SELECT cuenta_bancaria_iban INTO :iban FROM csi_bancos WHERE codigo = :banco AND empresa = :g_empresa ;
IF NOT(f_es_vacio(banco)) THEN 
	IF not (gnv_control_cuentas_bancarias.of_comprobar_iban(iban) ) THEN mensaje+= ('Debe tener un IBAN v$$HEX1$$e100$$ENDHEX$$lido para el Banco seleccionado.')
END IF

if mensaje<>'' then
	Messagebox(g_titulo,mensaje)
	return -1
end if

return 1
end event

public subroutine wf_dame_datos_cliente (string id_cliente, ref string nom, ref string ape, ref string da, ref string pa, ref string nif);string tipo_via, nom_via, cod_pob, cod_prov, cp

select nombre, apellidos ,tipo_via, nombre_via, cod_pob, cod_prov, nif, cp
into :nom, :ape,:tipo_via,:nom_via, :cod_pob, :cod_prov, :nif, :cp from clientes where id_cliente=:id_cliente using SQLCA;
da= f_obtener_domicilio_activo(tipo_via, nom_via)
pa= f_obtener_poblacion_activa(cod_pob, cod_prov, cp)

end subroutine

public function integer wf_genera_f19 (st_cobros_datos_remesa datos_remesa, string formato);
// MODIFICADA POR RICARDO PARA EL FORMATO DE LA RIOJA
//	FECHA MODIFICACION 04-03-02
double n,importe,tot_rem,imp_cli,retorno,i
long asiento,apunte,tot_cred,tot_reg, cuantos_recibos,copias,row
string cuenta,linea,cc,id_col,n_remesa,ls_tipo_remesa,id_cobro
string cod_pres,nom_pres,entidad,tipo,concepto1,concepto2, concepto3,promo,expdte,docto,concepto
string nom_fich, nom_fich_completo, cod_ine,cod_dev,rfcia,nom_cli,ccc_cli,conc_domi,cancelada, nom_fich_completo_XML
string desglosar,cod_ref,orden, banco, cod_banco
string direccion_colegio,poblacion_colegio, id_fase, id_minuta, n_registro, descripcion, n_expedi, t_visado, cliente, n_col
datastore ds_lineas_fichero,ds_lineas_facts
string n_factura, stotal_iva, ls_n_visado
datetime f_factura
string t_iva,conc_1,conc_2
string ssubtotal,ssubtotal_iva,scant_iva,spor,stotal
double num_linea,subtotal,subtotal_iva,cant_iva,por,total, total_iva
int fila_movimiento, fila_clientes
string nombre_banco, ctabco, ls_iban_banco_remesa, ls_iban, ls_bic
string n_colegiado
long k, originales, copias_doc
string importe_texto,id_factura
boolean lb_desglose_factura = TRUE

retorno =0

ds_lineas_facts	= create datastore	
ds_lineas_facts.dataobject = 'd_lineas_fact_emitidas'
ds_lineas_facts.SetTransObject(SQLCA)

ds_lineas_fichero	= create datastore	
ds_lineas_fichero.dataobject = 'ds_cobros_lineas_remesa'
ds_lineas_fichero.SetTransObject(SQLCA)

n_remesa = datos_remesa.n_remesa

cod_pres = f_cobros_devuelve_ncontrol(datos_remesa.banco)
if f_es_vacio(cod_pres) then cod_pres = ''
cod_pres = RightA('000000000000' + cod_pres, 12)

nom_pres=MidA(f_obtener_empresa_nombre_corto( g_empresa)+space(40),1,40)
nom_fich='RD'+string(today(),'yymmdd') +'-'+String(Now(), "hhmmss") 
cod_ine='460000000' 
tot_rem=0
tot_cred=0
tot_reg=0
cod_dev='000000'
rfcia=''
nom_cli=''
ccc_cli=''
imp_cli=0

SELECT nombre, cuenta_contable,cuenta_bancaria_iban INTO :nombre_banco,:cc,:ls_iban_banco_remesa  FROM csi_bancos WHERE codigo = :datos_remesa.banco and empresa = :g_empresa;
ctabco = gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban(ls_iban_banco_remesa)		

n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()

// Obtenemos el nombre del fichero a generar
//if (datos_remesa.formato = 'S') then  nom_fich = nom_fich + '_14'
choose case (datos_remesa.formato)
	case 'X'
		nom_fich_completo = g_directorio_temporal + nom_fich + '_14.f19'
		nom_fich = nom_fich + '_ISO20022'
		nom_fich_completo_XML = nom_fich

		if GetFileSaveName('Seleccione nombre del fichero XML',nom_fich_completo_XML,nom_fich,'.XML','Ficheros de Domiciliaciones formato XML (*.XML),*.XML') <> 1 Then
			cambia_directorio.of_changedirectory(directorio)
			destroy cambia_directorio
			return -1
		End If

	case else  
		if (datos_remesa.formato = 'S') then nom_fich = nom_fich + '_14'
		nom_fich_completo = nom_fich
		if GetFileSaveName('Seleccione nombre de fichero F19',nom_fich_completo,nom_fich,'.'+upper(g_ext_f19),'Ficheros de Domiciliaciones formato 19 (*.'+g_ext_f19+'),*.'+g_ext_f19) <> 1 Then
			cambia_directorio.of_changedirectory(directorio)
			destroy cambia_directorio
			return -1
		End If
		
end choose

if isnull(g_directorio_domiciliaciones) then g_directorio_domiciliaciones = 'c:'
 entidad=mid(ctabco, 1, 8)
 
 // Ponemos el domicilio del colegio
    direccion_colegio = g_direccion_empresa
 if isnull(direccion_colegio) then direccion_colegio = ''
 direccion_colegio = LeftA(direccion_colegio+space(40),40)
 // Ponemos la poblacion del colegio
 
 poblacion_colegio = LeftA(g_pobla_colegio_carta, 5)
 if isnull(poblacion_colegio) then poblacion_colegio = ''
 if not isnull(g_col_ciudad) then poblacion_colegio += ' ' +g_col_ciudad
 if not isnull(g_col_provincia) then poblacion_colegio += ' ' +g_col_provincia
 poblacion_colegio = LeftA(poblacion_colegio+space(14),14)
 
// registro CSB de cabecera de presentador   (51->euros)
linea='5180'+cod_pres+string(today(),'ddmmyy')+space(6)+nom_pres+space(20)+entidad+space(12)+space(40)+space(14)
if datos_remesa.formato <> 'N' then linea += f_completar_con_caracteres(n_remesa,10,'D',' ') 
f_cobros_inserta_linea_fichdomi(ds_lineas_fichero,linea)
// registro CSB de cabecera de cliente ordenante  (53->euros)
linea='5380'+cod_pres+string(today(),'ddmmyy')+string(datos_remesa.fecha,'ddmmyy')+nom_pres+ctabco+space(8)+'01'+space(10)+direccion_colegio+poblacion_colegio
f_cobros_inserta_linea_fichdomi(ds_lineas_fichero,linea)
tot_reg=2
cuantos_recibos = 0

CHOOSE CASE g_colegio 
	CASE 'COAATTGN'
		dw_extracto_remesa.dataobject = 'd_cobros_listado_remesa_tg'
		dw_extracto_remesa_ncol.dataobject = 'd_cobros_listado_remesa_por_ncol_tg'
	CASE 'COAATCC' 
		dw_extracto_remesa.dataobject = 'd_cobros_listado_remesa_cc'
		dw_extracto_remesa_ncol.dataobject = 'd_cobros_listado_remesa_por_ncol_cc'
END CHOOSE

dw_extracto_remesa.reset()
dw_extracto_remesa_ncol.reset()

for n=1 to dw_domiciliaciones.RowCount()
	dw_domiciliaciones.SetItem(n,'remesado','N')	
	id_cobro 	=dw_domiciliaciones.GetItemString(n,'referencia')  //En el campo referencia guardamos el id_cobro
    if dw_domiciliaciones.GetItemString(n,'activo')='N' then continue
	cuantos_recibos++
	imp_cli		=f_redondea(dw_domiciliaciones.GetItemNumber(n,'importe'))
	tot_rem		=tot_rem+imp_cli
	ccc_cli		=f_completar_con_caracteres( dw_domiciliaciones.GetItemString(n,'banco_dom'), 20,'D',' ')
	ls_iban		=dw_domiciliaciones.GetItemString(n,'iban')
	ls_bic			=dw_domiciliaciones.GetItemString(n,'bic')
	rfcia			=dw_domiciliaciones.GetItemString(n,'referencia')
	tipo			=dw_domiciliaciones.GetItemString(n,'tipo')
	docto			=trim(dw_domiciliaciones.GetItemString(n,'documento'))
	conc_domi	=dw_domiciliaciones.GetItemString(n,'concepto')
	id_col		=dw_domiciliaciones.GetItemString(n,'id_col')
	
	// Si el importe es 0 no debe generar la linea
	if imp_cli = 0 then continue
	//Ponemos el n$$HEX2$$ba002000$$ENDHEX$$de remesa en cada cobro
	if not(f_es_vacio(id_cobro)) then
		update csi_cobros set n_remesa = :n_remesa where id_pago = :id_cobro;
	end if
	
	string nom, ape,da,pa,cp, nif
	CHOOSE CASE (dw_domiciliaciones.GetItemString(n,'tipo_persona'))
		CASE 'P'
			wf_dame_datos_cliente(id_col, nom, ape, da, pa, nif)
			n_col = nif
			cod_ref=f_completar_con_caracteres(n_col,12,'I','0')
		CASE ELSE
			n_colegiado=f_colegiado_n_col(id_col)
			cod_ref=f_completar_con_caracteres(n_colegiado,12,'I','0')
			select nombre, apellidos ,domicilio_activo,poblacion_activa, nif, n_colegiado into :nom, :ape,:da,:pa,:nif, :n_col from colegiados where id_colegiado=:id_col using SQLCA;
	END CHOOSE

	if isnull(nom) then nom = ''
	if isnull(da) then da=''
	if isnull(pa) then pa=''
	if isnull(nif) then nif=''
	
	promo = nif + ' ' + ape + ' ' + nom
	promo=f_cobros_reemplaza_cadena(promo,',',' ')
	cp = MidA(pa,1,5)
	if f_es_vacio(cp) then cp=''
	// Quito el codigo postal de la poblacion activa que no me gusta
	pa = MidA(pa, 7, LenA(pa))
	//Rellenamos el 1er Registro Individual Obligatorio 
	nom_cli=MidA(f_transforma_cadena_win_dos(f_cobros_reemplaza_cadena(promo,',',' '))+space(40),1,40)
	importe_texto = RightA('0000000000000'+trim(string(round(imp_cli * 100,0))),10)
	concepto = dw_domiciliaciones.getitemstring(n,'concepto')
	
	if f_es_vacio(concepto) then 
		conc_domi = 'DOM.'+MidA(conc_domi,1,18)
	else 
		conc_domi = concepto
	end if
	concepto1 = f_completar_con_caracteres(conc_domi,40,'D',' ')
	
	SELECT tipo INTO :ls_tipo_remesa from remesas where n_remesa = :n_remesa  AND empresa = :g_empresa ; 
	IF upper(ls_tipo_remesa) = 'S' THEN 	lb_desglose_factura = FALSE // Domiciliaci$$HEX1$$f300$$ENDHEX$$n Saldos Deudores

	linea='5680'+cod_pres+cod_ref+nom_cli+ccc_cli+importe_texto+cod_dev+f_completar_con_caracteres(id_cobro,10,'D',' ')+concepto1+string(today(),'ddmmyy')+space(2) 
	if datos_remesa.formato <> 'N' then linea += f_completar_con_caracteres(ls_iban,34,'D',' ') + f_completar_con_caracteres(ls_bic,11,'D',' ') + &
																f_completar_con_caracteres( f_concepto_sepa_ampliado_norma19 (lb_desglose_factura, formato, id_cobro) ,100,'D',' ')
	f_cobros_inserta_linea_fichdomi(ds_lineas_fichero,linea)
	tot_cred=tot_cred+1
	tot_reg=tot_reg+1
			
	CHOOSE CASE formato
		CASE 'SIN', 'SN' 	// Las l$$HEX1$$ed00$$ENDHEX$$neas que estaban aqu$$HEX2$$ed002000$$ENDHEX$$eran comunes, y se han factorizado dej$$HEX1$$e100$$ENDHEX$$ndolas antes de entrar

		CASE 'PREMAAT', 'SRCFIJA', 'SD'
			// inicializamos la linea a crear
			num_linea= 1
			// Obtenemos fecha y numero de factura
			select csi_facturas_emitidas.n_fact, csi_facturas_emitidas.fecha
			into :n_factura, :f_factura from csi_cobros, csi_facturas_emitidas
			where csi_cobros.id_factura = csi_facturas_emitidas.id_factura and id_pago = :id_cobro;
			
			//Colocamos la fecha y el numero de fatura
			conc_1   = LeftA('N$$HEX2$$ba002000$$ENDHEX$$de Factura = '+n_factura+space(40),40)
			if string(f_factura, 'd/m/yyyy') = '1/1/1900' then
				concepto = LeftA('Fecha Factura = '+space(40),40)
			else
				concepto = LeftA('Fecha Factura = '+string(f_factura, "dd mm yyyy")+space(40),40)
			end if
			conc_2 = ' '
			conc_2 = f_completar_con_caracteres(conc_2,40,'D',' ')
			// Linea por el numero de factura
			linea='568'+string(num_linea)+cod_pres+cod_ref+conc_1+concepto+conc_2+space(14)
			f_cobros_inserta_linea_fichdomi(ds_lineas_fichero,linea)
			tot_reg=tot_reg+1
			num_linea++
			
		CASE 'SRCVAR', 'EX'
			// Hay que indicar una serie de campos adicionales en el formato de la factura

			// OJO::: EST$$HEX1$$c100$$ENDHEX$$N LAS VARIABLES INVERTIDAS A PROPOSITO YA QUE EN CSI_FACTURAS_EMITIDAS SE ALMACENAN AMBOS IDENTIFICADORES
			//        AL REV$$HEX1$$c900$$ENDHEX$$S
			select csi_facturas_emitidas.id_factura, csi_facturas_emitidas.n_fact, csi_facturas_emitidas.fecha, csi_facturas_emitidas.id_fase, csi_facturas_emitidas.id_minuta 
			into :id_factura, :n_factura, :f_factura, :id_minuta, :id_fase from csi_cobros, csi_facturas_emitidas
			where csi_cobros.id_factura = csi_facturas_emitidas.id_factura and id_pago = :id_cobro;
			
			// Si el id_minuta es vacio es porque est$$HEX2$$e1002000$$ENDHEX$$asociada directamente al contrato
			if not f_es_vacio(id_minuta) then 
				select id_fase into :id_fase from fases_minutas where id_minuta = :id_minuta;
			end if
			
			// inicializamos la linea a crear
			num_linea= 1
			
			// Creamos un ds para obtener los datos del contrato
			datastore ds_datos_contrato_remesa
			ds_datos_contrato_remesa = create datastore
			ds_datos_contrato_remesa.dataobject = 'd_fases_datos_para_remesa'
			ds_datos_contrato_remesa.settransobject(SQLCA)
			if ds_datos_contrato_remesa.retrieve(id_fase)>0 then
				// Seguro que hay al menos una linea, sino mal lo tenemos. Pillamos los valores genericos de la primera linea
				n_expedi = ds_datos_contrato_remesa.getitemstring(1, 'n_expedi')
				if isnull(n_expedi) then n_expedi = '' // Teoricamente se debe rellenar siempre, pero la experiencia en LR me dice que no es cierto
				n_registro = ds_datos_contrato_remesa.getitemstring(1, 'n_registro')
				descripcion = ds_datos_contrato_remesa.getitemstring(1, 'descripcion')
				if isnull(descripcion) then descripcion = ''
				
				///* Modificado por Alexis. ICC-341. 23/4/2010. Se modifica para que a$$HEX1$$f100$$ENDHEX$$ada en el fichero el numero de visado en lugar del n$$HEX1$$fa00$$ENDHEX$$mero de contrato y expediente*///
				ls_n_visado = ds_datos_contrato_remesa.getitemstring(1, 'fases_archivo')
				
				if g_colegio = 'COAATCC' then 
					concepto = 'N$$HEX1$$ba00$$ENDHEX$$Visado: '+ ls_n_visado
				else
				// Ponemos el numero de contrato y de expediente
					concepto = 'N$$HEX1$$ba00$$ENDHEX$$Contrato/N$$HEX1$$ba00$$ENDHEX$$Exp : '+n_registro+'   ' +n_expedi
				end if	
				///*Fin modificado ICC-431. 23/04/2010 *///
				
				// completamos con espacios el resto de hueco
				concepto = f_completar_con_caracteres(concepto,40,'D',' ')
				conc_1 = 'Descripcion : '
				// quitamos lo que ocupa 'Descripcion : '
				if LenA(descripcion) >(40 - LenA(conc_1)) then
					conc_1 += MidA(descripcion, 1, (40 - LenA(conc_1)))
				else
					conc_1 += descripcion 
					// completamos con espacios el resto de hueco
					conc_1 = f_completar_con_caracteres(conc_1,40,'D',' ')
				end if
				
				// Colocamos el tipo de prima variable que se factura
				select t_visado into :t_visado from musaat_movimientos, csi_lineas_fact_emitidas where 
				musaat_movimientos.id_factura = csi_lineas_fact_emitidas.id_linea and csi_lineas_fact_emitidas.id_factura = :id_factura;
				
				CHOOSE CASE t_visado
					CASE '1'
						conc_2 = 'TIPO DE PRIMA SRC : Alta' 
					CASE '2'
						conc_2 = 'TIPO DE PRIMA SRC : Modificacion' 
					CASE '6'
						conc_2 = 'TIPO DE PRIMA SRC : Renuncia o Anulacion' 
					CASE ELSE
						// No se sabe el tipo de prima
						conc_2 = ' TIPO DE PRIMA SRC : DESCONOCIDA '
				END CHOOSE
				conc_2 = f_completar_con_caracteres(conc_2,40,'D',' ')
				
				// Insertamos la linea en el fichero
				linea='568'+string(num_linea)+cod_pres+cod_ref+concepto+conc_1+conc_2+space(14)
				f_cobros_inserta_linea_fichdomi(ds_lineas_fichero,linea)
				tot_reg=tot_reg+1
				num_linea++
				
				// Colocamos ahora los clientes del contrato
				concepto1=''
				concepto2=''
				concepto3=''
				// Creamos un datastore
				datastore ds_fases_promotores
				ds_fases_promotores = create datastore
				ds_fases_promotores.dataobject = 'd_fases_promotores'
				ds_fases_promotores.SetTransObject(SQLCA)
				ds_fases_promotores.retrieve(id_fase)
				FOR fila_clientes = 1 TO ds_fases_promotores.RowCount()
					// Cogemos el nombre del cliente
					cliente = ds_fases_promotores.GetItemString(fila_clientes, 'cliente')
					cliente = f_completar_con_caracteres(cliente,40,'D',' ')
					// Lo colocamos en el campo correspondiente
					if f_es_Vacio(concepto1) then 
						concepto1 = cliente
					elseif f_es_Vacio(concepto2) then 
						concepto2 = cliente
					elseif f_es_Vacio(concepto3) then 
						concepto3 = cliente
					end if
					
					if concepto3<>'' then
						// Ponemos las descripciones de los conceptos
						linea='568'+string(num_linea)+cod_pres+cod_ref+concepto1+concepto2+concepto3+space(14)
						f_cobros_inserta_linea_fichdomi(ds_lineas_fichero,linea)
						tot_reg=tot_reg+1
						num_linea++
						
						// Vaciamos los 3 conceptos otra vez
						concepto1 = ''
						concepto2 = ''
						concepto3 = ''
						
						// Si ya hemos llegado a la 4 fila salimos
						if num_linea = 4 then exit
					end if
				NEXT
				// Destruimos el datastore
				destroy ds_fases_promotores
				// Si no hemos llegado a la ultima pero hay algo en el concepto1 colocamos la linea que falta
				if num_linea < 4 and not f_es_vacio(concepto1) then
					concepto2 = f_completar_con_caracteres(concepto2,40,'D',' ') // Completamos por si no est$$HEX2$$e1002000$$ENDHEX$$rellenado
					concepto3 = f_completar_con_caracteres(concepto3,40,'D',' ') // Completamos por si no est$$HEX2$$e1002000$$ENDHEX$$rellenado
					
					// Insertamos la linea en el fichero
					linea='568'+string(num_linea)+cod_pres+cod_ref+concepto1+concepto2+concepto3+space(14)
					f_cobros_inserta_linea_fichdomi(ds_lineas_fichero,linea)
					tot_reg=tot_reg+1
					num_linea++
				end if
			else
				// Colocamos que no sabemos nada de nada
				concepto1 = 'N$$HEX1$$ba00$$ENDHEX$$Contrato/N$$HEX1$$ba00$$ENDHEX$$Exp : Desconocido '
				///* ICC-341. ALexis el 23/04/2010. *///
				if g_colegio = 'COAATCC' then concepto1 = 'N$$HEX1$$ba00$$ENDHEX$$Visado: Desconocido '
				///* Fin ICC-341. *///
				concepto1 = f_completar_con_caracteres(concepto1,40,'D',' ')
				concepto2 = ' '
				concepto2 = f_completar_con_caracteres(concepto2,40,'D',' ')
				concepto3 = ' TIPO DE PRIMA SRC : DESCONOCIDA '
				concepto3 = f_completar_con_caracteres(concepto3,40,'D',' ')
				
				// Ponemos las descripciones de los conceptos
				linea='568'+string(num_linea)+cod_pres+cod_ref+concepto1+concepto2+concepto3+space(14)
				f_cobros_inserta_linea_fichdomi(ds_lineas_fichero,linea)
				tot_reg=tot_reg+1
				num_linea++
			end if
			// Destruimos el datastore
			destroy ds_datos_contrato_remesa
			
			//Rellenamos el pen-$$HEX1$$fa00$$ENDHEX$$ltimo Registro Individual (Opcional) 
			conc_1   = LeftA('N$$HEX2$$ba002000$$ENDHEX$$de Factura = '+n_factura+space(40),40)
			concepto = LeftA('Fecha Factura = '+string(f_factura, "dd mm yyyy")+space(40),40)
			conc_2 = ' '
			conc_2 = f_completar_con_caracteres(conc_2,40,'D',' ')
			// Linea por el numero de factura
			linea='568'+string(num_linea)+cod_pres+cod_ref+conc_1+concepto+conc_2+space(14)
			f_cobros_inserta_linea_fichdomi(ds_lineas_fichero,linea)
			tot_reg=tot_reg+1
			num_linea++
			
		CASE ELSE
			// Desglosar conceptos,tenemos que recorrer todos los conceptos que tiene la factura en cuesti$$HEX1$$f300$$ENDHEX$$n...
			select id_factura into :id_factura from csi_cobros where id_pago = :id_cobro;
			ds_lineas_facts.Retrieve(id_factura)
			num_linea = 1
				total        = 0
				subtotal     = 0
				subtotal_iva = 0 
				concepto1=''
				concepto2=''
				concepto3=''
				for i=1 to ds_lineas_facts.RowCount()
					total += 		ds_lineas_facts.GetItemNumber(i,'total')
					subtotal+= 		ds_lineas_facts.GetItemNumber(i,'subtotal')
					subtotal_iva+= ds_lineas_facts.GetItemNumber(i,'subtotal_iva')
					concepto = ds_lineas_facts.GetItemString(i,'descripcion_larga')
					
					// Modificaci$$HEX1$$f300$$ENDHEX$$n para COAATTGN para que cuando se desglose aparezca el importe de cada concepto
					stotal = string(ds_lineas_facts.GetItemNumber(i,'total'),'##0.00')
	
					//El fichero solo permite 2 lineas para el desglose de t$$HEX1$$e900$$ENDHEX$$rminos
					if num_linea>2 then continue
					if LenA(concepto)>40 then
						concepto = MidA(concepto + '   ' + stotal ,1,40)
					else
						concepto = MidA(concepto + '   ' + stotal + FillA(' ',40),1,40)
					end if 	
	
					// Lo colocamos en el campo correspondiente
					if f_es_Vacio(concepto1) then 
						concepto1 = concepto
					elseif f_es_Vacio(concepto2) then 
						concepto2 = concepto
					elseif f_es_Vacio(concepto3) then 
						concepto3 = concepto
					end if
	
					// Aprovecho 2 lineas para poner 6 conceptos...
					if i<7 then
						if concepto3<>'' then
							// Ponemos las descripciones de los conceptos
							linea='568'+string(num_linea)+cod_pres+cod_ref+concepto1+concepto2+concepto3+space(14)
							f_cobros_inserta_linea_fichdomi(ds_lineas_fichero,linea)
							tot_reg=tot_reg+1
							num_linea++
							
							// Vaciamos los 3 conceptos otra vez
							concepto1 = ''
							concepto2 = ''
							concepto3 = ''
							
							if num_linea = 3 then exit
						end if
					end if
				next
				// Si no hemos llegado a insertar los 2, faltar$$HEX2$$e1002000$$ENDHEX$$poner la ultima linea
				if num_linea < 3 and not f_es_vacio(concepto1) then
					concepto2 = f_completar_con_caracteres(concepto2,40,'D',' ')
					concepto3 = f_completar_con_caracteres(concepto3,40,'D',' ')
						
					// Ponemos las descripciones de los conceptos
					linea='568'+string(num_linea)+cod_pres+cod_ref+concepto1+concepto2+concepto3+space(14)
					f_cobros_inserta_linea_fichdomi(ds_lineas_fichero,linea)
					tot_reg=tot_reg+1
					num_linea++
					
					// Vaciamos los 3 conceptos otra vez
					concepto1 = ''
					concepto2 = ''
					concepto3 = ''
				end if
				
			// Seleccionamos lo que nos haga falta de la fatura
			select n_fact, fecha, iva into :n_factura, :f_factura, :total_iva from csi_facturas_emitidas where id_factura = :id_factura;
			stotal_iva = string(total_iva,'#####0.00')
			stotal_iva =f_cobros_reemplaza_cadena(stotal_iva,',','.')
			
			//Rellenamos el pen-$$HEX1$$fa00$$ENDHEX$$ltimo Registro Individual (Opcional) 
			conc_1   = LeftA('N$$HEX2$$ba002000$$ENDHEX$$de Documento = '+n_factura+space(40),40)
			concepto = LeftA('Fecha Documento = '+string(f_factura, "dd mm yyyy")+space(40),40)
			conc_2 = ' '
			conc_2 = f_completar_con_caracteres(conc_2,40,'D',' ')
			// Linea por el numero de factura
			linea='568'+string(num_linea)+cod_pres+cod_ref+conc_1+concepto+conc_2+space(14)
			f_cobros_inserta_linea_fichdomi(ds_lineas_fichero,linea)
			tot_reg=tot_reg+1
			num_linea++
	END CHOOSE
	//Rellenamos el $$HEX1$$fa00$$ENDHEX$$ltimo Registro Individual (Opcional) 
	da = LeftA(f_completar_con_caracteres(da,40,'D',' '),40)
	pa = LeftA(f_completar_con_caracteres(pa,35,'D',' '),35)
	cp = LeftA(f_completar_con_caracteres(cp,5,'D',' '),5)
	da = da+pa+cp
	da= f_cobros_reemplaza_cadena(da,',',' ')
	linea='5686'+cod_pres+cod_ref+nom_cli+da+space(14)
	f_cobros_inserta_linea_fichdomi(ds_lineas_fichero,linea)
	tot_reg=tot_reg+1
	num_linea++

	
	
	dw_domiciliaciones.SetItem(n,'remesado','S')
	//Metemos en el campo 'ref_interna' de la tabla domiciliaciones el N$$HEX2$$ba002000$$ENDHEX$$de Remesa
	dw_domiciliaciones.SetItem(n,'ref_interna',n_remesa)
	
	//Rellenamos tambi$$HEX1$$e900$$ENDHEX$$n el extracto Resumen
	row=dw_extracto_remesa.InsertRow(0)
	dw_extracto_remesa.SetItem(row,'fecha',dw_domiciliaciones.getItemDatetime(dw_domiciliaciones.GetRow(),'fecha'))
	dw_extracto_remesa.SetItem(row,'importe',dw_domiciliaciones.GetItemNumber(n,'importe'))
	dw_extracto_remesa.SetItem(row,'banco_dom',dw_domiciliaciones.GetItemString(n,'banco_dom'))
	dw_extracto_remesa.SetItem(row,'iban',dw_domiciliaciones.GetItemString(n,'iban'))
	dw_extracto_remesa.SetItem(row,'bic',dw_domiciliaciones.GetItemString(n,'bic'))
	dw_extracto_remesa.SetItem(row,'n_arqui',dw_domiciliaciones.GetItemString(n,'n_arqui'))
	CHOOSE CASE (dw_domiciliaciones.GetItemString(n,'tipo_persona'))
		CASE 'P'
			dw_extracto_remesa.SetItem(row,'colegiados_apellidos',dw_domiciliaciones.GetItemString(n,'nombre'))
		CASE ELSE
			dw_extracto_remesa.SetItem(row,'colegiados_apellidos',f_colegiado_apellido(id_col))//f_colegiado_nombre_apellido(id_col))
	END CHOOSE
	dw_extracto_remesa.SetItem(row,'colegiados_nombre','')
	dw_extracto_remesa.SetItem(row,'n_fact',dw_domiciliaciones.GetItemString(n,'n_fact'))
//	cod_banco = dw_domiciliaciones.getItemString(dw_domiciliaciones.GetRow(),'banco_dom')
//	select nombre into :banco from csi_bancos where codigo = :cod_banco;
	dw_extracto_remesa.SetItem(row,'csi_bancos_entidad',mid(ctabco, 1, 4))
	dw_extracto_remesa.SetItem(row,'csi_bancos_sucursal',mid(ctabco, 5, 4))
	dw_extracto_remesa.SetItem(row,'csi_bancos_cod_seg',mid(ctabco, 9, 2))
	dw_extracto_remesa.SetItem(row,'csi_bancos_cuenta_banco',mid(ctabco, 11, 10))
	dw_extracto_remesa.SetItem(row,'csi_bancos_nombre', nombre_banco)
	dw_extracto_remesa.SetItem(row,'csi_bancos_cuenta_bancaria_iban',ls_iban_banco_remesa)
	dw_extracto_remesa.SetItem(row,'ref_interna',n_remesa)
next
    
// registro CSB de total de cliente ordenante
importe_texto = RightA('0000000000000'+trim(string(round(tot_rem  * 100,0))),10)
linea='5880'+cod_pres+space(12)+space(40)+space(20)+importe_texto+space(6)+string(tot_cred,'0000000000')+string(tot_reg,'0000000000')+space(20)+space(18)
f_cobros_inserta_linea_fichdomi(ds_lineas_fichero,linea)
// registro CSB de total general
linea='5980'+cod_pres+space(12)+space(40)+'0001'+space(16)+importe_texto+space(6)+string(tot_cred,'0000000000')+string(tot_reg+2,'0000000000')+space(20)+space(18)
f_cobros_inserta_linea_fichdomi(ds_lineas_fichero,linea)
n=ds_lineas_fichero.RowCount()

ds_lineas_fichero.SaveAs(nom_fich_completo,Text!,FALSE)

uo_migrar_a_norma_19_14 luo_migrar_a_norma_19_14
luo_migrar_a_norma_19_14 = create uo_migrar_a_norma_19_14 

if (datos_remesa.formato <> 'N' ) then luo_migrar_a_norma_19_14.wf_migrar_fichero( nom_fich_completo, nom_fich_completo)
destroy luo_migrar_a_norma_19_14

if (datos_remesa.formato = 'X' ) then
	n_sepa_ws_consumption uo_sepa
	uo_sepa=create n_sepa_ws_consumption
	
	retorno= uo_sepa.of_get_adeudo_file( nom_fich_completo, nom_fich_completo_XML)
	destroy uo_sepa
	
end if	

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02

if retorno < 0 then 
	SetPointer(Arrow!)
	return retorno
end if	

//Actualizar fichero de remesa a estado de remesado='P'
if dw_domiciliaciones.Update()<>-1 then
	string cadena[], cadenas[]
	cadena[1]=n_remesa
	cadena[2]=string(cuantos_recibos)
	cadena[3]=string(tot_rem,'#,##0.00')
	cadena[4]=nom_fich
	
   Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.n_remesa_procesado_recibos',cadena,'N$$HEX2$$ba002000$$ENDHEX$$Remesa : '+n_remesa+cr+'Procesados '+string(cuantos_recibos) + ' recibos: ' + string(tot_rem,'#,##0.00') + ' euros.')+cr+ &
															g_idioma.of_getmsg('msg_cobros.exito_mandar_banco','Recuerde mandar al banco el fichero ')+nom_fich,Information!)
   retorno=1	
   commit;
else
   MessageBox('ATENCI$$HEX1$$d300$$ENDHEX$$N ERROR',g_idioma.of_getmsg('msg_cobros.error_actualizar_dep_inform','Ha ocurrido alg$$HEX1$$fa00$$ENDHEX$$n fallo al actualizar. Avise al Dpto. de Inform$$HEX1$$e100$$ENDHEX$$tica.'),Exclamation!)
   Rollback;
   retorno=-1
end if

///   scp-1692
if g_activa_multiempresa = 'S' then
	f_logo_empresa(g_empresa ,dw_extracto_remesa, '003')
end if	
////////////


dw_extracto_remesa.setsort("colegiados_apellidos")
dw_extracto_remesa.sort()
//Cambio realizado por Luis para la incidencia cgn-250 14/01/2009
dw_mas_datos.accepttext( )
//Copias originales
if(f_es_vacio(string(dw_mas_datos.getitemnumber(1,'originales'))))then
	originales = 0
else
	originales = dw_mas_datos.getitemnumber(1,'originales')
end if
for k = 1 to originales
	dw_extracto_remesa.Print()
next
//fin modificado Luis
// MODIF PACO 6/5/2005: Lo dejo siempre para que imprima 2 copias
//Cambio realizado por Luis para la incidencia cgn-250 14/01/2009
//Copias del documento
if(f_es_vacio(string(dw_mas_datos.getitemnumber(1,'copias'))))then
	copias_doc = 0
else
	copias_doc = dw_mas_datos.getitemnumber(1,'copias')
//	dw_extracto_remesa.Object.t_mensaje.Visible = 1
end if
for k = 1 to copias_doc
	if g_colegio <> 'COAATGUI' then dw_extracto_remesa.Print()
next
//dw_extracto_remesa.Object.t_mensaje.Visible = 0
//fin modificado Luis

SetPointer(Arrow!)

destroy ds_lineas_fichero
destroy ds_lineas_facts
//destroy dw_domiciliaciones

return retorno
end function

event open;double n_remesa
st_cobros_datos_pre_remesa parametros
f_centrar_ventana(this)

// Indicamos que queremos cambiar el idioma
if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)

//Recogemos los par$$HEX1$$e100$$ENDHEX$$metros de la ventana llamante
parametros = Message.PowerObjectParm
i_dw_lista_cobros = parametros.dw_lista
i_fecha_apuntes = parametros.fecha_apuntes
i_modulo = parametros.modulo		//M$$HEX1$$f300$$ENDHEX$$dulo llamante  : 'SALDOS','COBROS','COLEGIADOS'


// Activamos el control calendario para los campos de tipo fecha
dw_datos_remesa.of_SetDropDownCalendar(True)
dw_datos_remesa.iuo_calendar.of_register(dw_datos_remesa.iuo_calendar.DDLB)
dw_datos_remesa.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_datos_remesa.iuo_calendar.of_SetInitialValue(True)

//Cambios Multiempresa
//Yexaira 10/02/2010

//i_n_remesa = f_siguiente_numero('N_REMESA', 10)
select valor into :n_remesa from contadores where contador = 'N_REMESA';
n_remesa++
i_n_remesa = string(n_remesa)
i_n_remesa = f_completar_con_caracteres(i_n_remesa,10,'I','0')

dw_mas_datos.InsertRow(1)
dw_datos_remesa.InsertRow(1)
dw_datos_remesa.setitem(1, 'fecha', datetime(today(),now()))

dw_mas_datos.SetItem(1,'n_remesa',i_n_remesa)
cb_actualiza.enabled=false
cb_f19.enabled=false
//M$$HEX1$$f300$$ENDHEX$$dulo llamante  : 'SALDOS','COBROS','COLEGIADOS','CLIENTES'
if i_modulo = 'COBROS' or i_modulo ='COLEGIADOS' or i_modulo ='CLIENTES' then
	cb_domicilia_cobros.visible=true
	cb_domicilia_saldos.visible=false
else
	cb_domicilia_cobros.visible=false
	cb_domicilia_saldos.visible=true
end if

//  MODIFICADO RICARDO 04-05-04
CHOOSE CASE i_modulo
	CASE 'COBROS'
		// Colocamos la forma de pago, el banco y la fecha si tienen valor
		if not f_Es_vacio(parametros.banco) then dw_datos_remesa.setitem(1, 'banco', parametros.banco)
		if not isnull(parametros.fecha) and (date(parametros.fecha)>date("01/01/1950")) then dw_datos_remesa.setitem(1, 'fecha', parametros.fecha)
	CASE 'SALDOS'
		// Modificado ricardo 2005-04-27
		// Si la fecha de entrada no pertenece al ejercicio actual, no dejamos continuar
		if string(year(date(i_fecha_apuntes)))<>g_ejercicio and g_contabilidad_automatica = true then
			Messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.fecha_apuntes_no_ejercicio',"La fecha de los apuntes que se generar$$HEX1$$e100$$ENDHEX$$n no pertenece al ejercicio abierto. El proceso ha sido cancelado"), stopsign!)
			cb_domicilia_saldos.enabled=false
			close(this)
			return
		end if
		// fin Modificado ricardo 2005-04-27
END CHOOSE
//  MODIFICADO RICARDO 04-05-04

DataWindowChild dwc_banco
dw_datos_remesa.GetChild("banco", dwc_banco)
dwc_banco.SetTransObject(SQLCA)
dwc_banco.Retrieve(g_empresa)

gnv_control_cuentas_bancarias.of_sepa_habilitado (dw_datos_remesa)

end event

on w_cobros_pre_remesa.create
int iCurrent
call super::create
this.st_aviso2=create st_aviso2
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_f19=create cb_f19
this.cb_actualiza=create cb_actualiza
this.dw_datos_remesa=create dw_datos_remesa
this.st_aviso=create st_aviso
this.dw_extracto_remesa_ncol=create dw_extracto_remesa_ncol
this.dw_apuntes_dom=create dw_apuntes_dom
this.gb_1=create gb_1
this.dw_mas_datos=create dw_mas_datos
this.dw_domiciliaciones=create dw_domiciliaciones
this.cb_recibir_f19=create cb_recibir_f19
this.dw_extracto_remesa=create dw_extracto_remesa
this.st_1=create st_1
this.cb_domicilia_cobros=create cb_domicilia_cobros
this.cb_domicilia_saldos=create cb_domicilia_saldos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_aviso2
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_f19
this.Control[iCurrent+6]=this.cb_actualiza
this.Control[iCurrent+7]=this.dw_datos_remesa
this.Control[iCurrent+8]=this.st_aviso
this.Control[iCurrent+9]=this.dw_extracto_remesa_ncol
this.Control[iCurrent+10]=this.dw_apuntes_dom
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.dw_mas_datos
this.Control[iCurrent+13]=this.dw_domiciliaciones
this.Control[iCurrent+14]=this.cb_recibir_f19
this.Control[iCurrent+15]=this.dw_extracto_remesa
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.cb_domicilia_cobros
this.Control[iCurrent+18]=this.cb_domicilia_saldos
end on

on w_cobros_pre_remesa.destroy
call super::destroy
destroy(this.st_aviso2)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_f19)
destroy(this.cb_actualiza)
destroy(this.dw_datos_remesa)
destroy(this.st_aviso)
destroy(this.dw_extracto_remesa_ncol)
destroy(this.dw_apuntes_dom)
destroy(this.gb_1)
destroy(this.dw_mas_datos)
destroy(this.dw_domiciliaciones)
destroy(this.cb_recibir_f19)
destroy(this.dw_extracto_remesa)
destroy(this.st_1)
destroy(this.cb_domicilia_cobros)
destroy(this.cb_domicilia_saldos)
end on

event type integer pfc_preclose();call super::pfc_preclose;if not ib_pulsado_salir then
	// No dejamos cerrar a menos que sea pulsando salir
	cb_1.trigger event clicked()
	return -1
else
	return 1
end if
end event

event csd_recuperar_consulta;call super::csd_recuperar_consulta;gnv_control_cuentas_bancarias.of_sepa_habilitado (dw_datos_remesa)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_cobros_pre_remesa
string tag = "texto=general.recuperar_pantalla"
integer y = 1368
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_cobros_pre_remesa
string tag = "texto=general.guardar_pantalla"
integer y = 1240
end type

type st_aviso2 from statictext within w_cobros_pre_remesa
integer x = 1870
integer y = 2324
integer width = 1422
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_cobros_pre_remesa
string tag = "texto=cobros.quitar_todos"
integer x = 471
integer y = 2272
integer width = 361
integer height = 68
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Quitar Todos"
end type

event clicked;int i

for i= 1 to dw_domiciliaciones.rowcount()
	dw_domiciliaciones.SetItem(i,'activo','N')
next
end event

type cb_2 from commandbutton within w_cobros_pre_remesa
string tag = "texto=cobros.a$$HEX1$$f100$$ENDHEX$$adir_todos"
integer x = 78
integer y = 2272
integer width = 361
integer height = 68
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "A$$HEX1$$f100$$ENDHEX$$adir Todos"
end type

event clicked;int i

for i= 1 to dw_domiciliaciones.rowcount()
	dw_domiciliaciones.SetItem(i,'activo','S')
next

end event

type cb_1 from commandbutton within w_cobros_pre_remesa
string tag = "texto=cobros.salir"
integer x = 2958
integer y = 880
integer width = 581
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;if i_datos_actualizados=false then
	// Modificado Ricardo 04/02/26
	IF dw_domiciliaciones.RowCount()>0 then
		// Modificado Ricardo 04/02/26
		IF dw_domiciliaciones.GetItemNumber(1, 'n_marcado')>0 then
			If Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.datos_no_actualizados','Los datos no han sido actualizados.')+cr+g_idioma.of_getmsg('msg_cobros.desea_actualizarlos','$$HEX1$$bf00$$ENDHEX$$Desea actualizarlos?'),Information!,YesNo!)=1 then
				cb_actualiza.Event Clicked()
			else
				i_dw_lista_cobros.resetupdate()
				dw_domiciliaciones.resetupdate()
				dw_apuntes_dom.resetupdate()
			end if
		else
			// Si no hay lineas marcadas no tiene porque grabar nada
			// Modificado Ricardo 04/02/26
			i_dw_lista_cobros.resetupdate()
			dw_domiciliaciones.resetupdate()
			dw_apuntes_dom.resetupdate()
		end if
	else
		// Si no hay lineas no tiene porque grabar nada
		// Modificado Ricardo 04/02/26
		i_dw_lista_cobros.resetupdate()
		dw_domiciliaciones.resetupdate()
		dw_apuntes_dom.resetupdate()
	end if
end if

// Modificado Ricardo 04-05-05
// Indicamos que estamos saliendo
ib_pulsado_salir = true

if i_datos_actualizados then
	Closewithreturn(parent, dw_mas_datos.GetItemString(1,'n_remesa'))
else
	Closewithreturn(parent, '-1')
end if

end event

type cb_f19 from commandbutton within w_cobros_pre_remesa
string tag = "texto=cobros.generar_f19"
integer x = 2373
integer y = 880
integer width = 581
integer height = 76
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generar &F19"
end type

event clicked;st_aviso.text='Generando fichero F19'
parent.TriggerEvent('csd_datos_remesa')
parent.TriggerEvent('csd_generar_f19')
st_aviso.text = 'Fichero Generado...'

end event

type cb_actualiza from commandbutton within w_cobros_pre_remesa
string tag = "texto=cobros.actualizar_datos"
integer x = 1787
integer y = 880
integer width = 581
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Actualizar Datos"
end type

event clicked;double contador,i,mal, importe_cobros, importe_factura
string n_remesa,id_cobro, primera_fact, ultima_fact, tipo_dom, n_remesa_old, nulo, id_factura, mensaje
int retorno = 0
datetime fecha_nula
long fila_domic

setnull(nulo)

//EVITAMOS QUE GRABE SIN QUE HAYAN LINEAS
if dw_domiciliaciones.rowcount() <= 0 then return
//EVITAMOS QUE GRABE SI EL NUMERO DE LINEAS MARCADAS ES 0
IF dw_domiciliaciones.GetItemNumber(1, 'n_marcado')<=0 then return

n_remesa= dw_mas_datos.GetItemString(1,'n_remesa')
contador = double(n_remesa)

// Evitamos que el n$$HEX2$$ba002000$$ENDHEX$$remesa ya haya sido utilizado (INC. 2898)
double ld_n_remesa
string ls_n_remesa
select valor into :ld_n_remesa from contadores where contador = 'N_REMESA';
ld_n_remesa++
ls_n_remesa = string(ld_n_remesa)
ls_n_remesa = f_completar_con_caracteres(ls_n_remesa,10,'I','0')

if ls_n_remesa <> n_remesa then
	messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.cambia_remesa_actualizar',"El n$$HEX1$$fa00$$ENDHEX$$mero de remesa ha cambiado y se actualizar$$HEX1$$e100$$ENDHEX$$")) // Avisamos al usuario
	dw_mas_datos.SetItem(1,'n_remesa',ls_n_remesa) // Actualizamos en la ventana
	n_remesa = ls_n_remesa // Actualizamos las variables
	contador = double(n_remesa)
	i_n_remesa = ls_n_remesa
end if


st_aviso.text = 'Actualizando datos...'
st_aviso2.text = ''

// Modificado DAVID - 29/04/2004
// Para evitar que se grabe las domiciliaciones sin el n$$HEX2$$ba002000$$ENDHEX$$remesa
for i=1 to dw_domiciliaciones.RowCount()
	if dw_domiciliaciones.GetItemString(i,'activo')='N' then continue
	dw_domiciliaciones.SetItem(i,'ref_interna',i_n_remesa) 
next

dw_domiciliaciones.update()
if dw_apuntes_dom.rowcount()>0 then 
	retorno += dw_apuntes_dom.Update()
	if retorno < 0 then messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.error_generando_apuntes','Error generando los apuntes'))
	f_actualiza_numero_bd_ejercicio (g_sica_diario.domic_saldo, long(iult_ast) )
end if

//Si lo hacemos desde el m$$HEX1$$f300$$ENDHEX$$dulo de cobros el dw es 'SQL'
if i_modulo = 'COBROS' then
	for i=1 to i_dw_lista_cobros.rowcount()
		if i_dw_lista_cobros.GetItemString(i,'remesar')<>'S' then 
			// si es de la misma remesa lo desmarcamos
			if i_dw_lista_cobros.GetItemString(i,'n_remesa') = n_remesa then
				i_dw_lista_cobros.SetItem(i,'pagado','N')
				i_dw_lista_cobros.SetItem(i,'n_remesa',nulo)
			end if
		else
			// Modifciado Ricardo 2005-06-22
			// OJO. solo hay que hacer lo que viene detr$$HEX1$$e100$$ENDHEX$$s en el caso de que la factura est$$HEX2$$e9002000$$ENDHEX$$incluida en esta remesa. 
			// ESto es un efecto colateral de colocar las que fallan en la domiciliacion tambien en pantalla
			id_cobro = i_dw_lista_cobros.GetItemString(i,'id_pago')
			fila_domic = dw_domiciliaciones.find("referencia = '"+id_cobro+"'",1 , dw_domiciliaciones.RowCount())
			if dw_domiciliaciones.GetItemString(fila_domic, 'activo')= 'S' then
				i_dw_lista_cobros.SetItem(i,'pagado','S')
				i_dw_lista_cobros.SetItem(i,'f_pago',i_datos_remesa.fecha)
				i_dw_lista_cobros.SetItem(i,'n_remesa',n_remesa)
				// Modificado Ricardo 04-05-21
				// Siempre machacamos el banco para evitar problemas luego de contabilidad
				i_dw_lista_cobros.SetItem(i,'banco',i_datos_remesa.banco)
				// FIN Modificado Ricardo 04-05-21
			end if
			// FIN Modificado Ricardo 2005-06-22
		end if
	next            
	i_dw_lista_cobros.update()
        
	// MODIFICADO RICARDO 04-05-10
	//      deberiamos marcar el pagado de las cabeceras de las facturas en el caso que el cobro complete el total de la factura
	for i=1 to i_dw_lista_cobros.rowcount()
		if i_dw_lista_cobros.GetItemString(i,'remesar')='S' and i_dw_lista_cobros.GetItemString(i,'pagado') = 'S' THEN
			id_factura = i_dw_lista_cobros.GetItemString(i,'id_factura')
			// Cogemos la suma de los importes de los cobros de esa factura
			select sum(importe) into :importe_cobros from csi_cobros where id_factura = :id_factura and pagado = 'S';
			if isnull(importe_cobros) then importe_cobros = 0
			// Vemos el total de la factura
			select total into :importe_factura from csi_facturas_emitidas where id_factura = :id_factura;
			if abs(importe_factura - importe_cobros)<0.5 then
				// Marcaremos la factura como pagada y grabaremos
				update csi_facturas_emitidas set pagado = 'S', f_pago = :i_datos_remesa.fecha where id_factura = :id_factura;
				IF SQLCA.sqlcode<>0 then 
					mensaje += g_idioma.of_getmsg('msg_cobros.error_actualizar_factura',"Error al intentar actualizar la factura ")+i_dw_lista_cobros.GetItemString(i,'n_fact')+cr
				end if
			end if
		end if
	next            
	if mensaje<>'' then
		messagebox(g_titulo, mensaje+cr+g_idioma.of_getmsg('msg_cobros.revisar_facturas',"Deber$$HEX1$$ed00$$ENDHEX$$a revisar estas facturas para ver el estado en que han quedado"))
	end if
	// FIN MODIFICADO RICARDO 04-05-10
end if

if i_modulo ='COLEGIADOS' or i_modulo = 'CLIENTES' then
	for i=1 to i_dw_lista_cobros.rowcount()
		if i_dw_lista_cobros.GetItemString(i,'remesar')<>'S' then 
			// si es de la misma remesa lo desmarcamos
			id_cobro = i_dw_lista_cobros.GetItemString(i,'id_pago')
			select n_remesa into :n_remesa_old from csi_cobros where id_pago=:id_cobro;
			if n_remesa_old = n_remesa then 
				update csi_cobros set pagado='N',n_remesa='' where id_pago=:id_cobro;
			end if
		else
			id_cobro = i_dw_lista_cobros.GetItemString(i,'id_pago')
			// Modifciado Ricardo 2005-06-22
			// OJO. solo hay que hacer lo que viene detr$$HEX1$$e100$$ENDHEX$$s en el caso de que la factura est$$HEX2$$e9002000$$ENDHEX$$incluida en esta remesa. 
			// ESto es un efecto colateral de colocar las que fallan en la domiciliacion tambien en pantalla
			fila_domic = dw_domiciliaciones.find("referencia = '"+id_cobro+"'",1 , dw_domiciliaciones.RowCount())
			if dw_domiciliaciones.GetItemString(fila_domic, 'activo')= 'S' then
				// MODIFICADO RICARDO 04-05-21                  
				update csi_cobros set pagado='S',f_pago=:i_datos_remesa.fecha,n_remesa=:n_remesa, banco =:i_datos_remesa.banco where id_pago=:id_cobro;
				// MODIFICADO RICARDO 04-05-10
				//      deberiamos marcar el pagado de las cabeceras de las facturas en el caso que el cobro complete el total de la factura
				id_factura = i_dw_lista_cobros.GetItemString(i,'id_factura')
				// Cogemos la suma de los importes de los cobros de esa factura
				select sum(importe) into :importe_cobros from csi_cobros where id_factura = :id_factura and pagado = 'S';
				if isnull(importe_cobros) then importe_cobros = 0
				// Vemos el total de la factura
				select total into :importe_factura from csi_facturas_emitidas where id_factura = :id_factura;
				if abs(importe_factura - importe_cobros)<0.5 then
					// Marcaremos la factura como pagada y grabaremos
					update csi_facturas_emitidas set pagado = 'S', f_pago = :i_datos_remesa.fecha, banco =:i_datos_remesa.banco where id_factura = :id_factura;
					IF SQLCA.sqlcode<>0 then 
						mensaje += g_idioma.of_getmsg('msg_cobros.error_actualizar_factura',"Error al intentar actualizar la factura ")+i_dw_lista_cobros.GetItemString(i,'n_fact')+cr
					end if
				end if
				// Fin Modificado Ricardo 2005-06-22
			end if
		end if
	next
	// MODIFICADO RICARDO 04-05-10
	if mensaje<>'' then
		messagebox(g_titulo, mensaje+cr+g_idioma.of_getmsg('msg_cobros.revisar_facturas',"Deber$$HEX1$$ed00$$ENDHEX$$a revisar estas facturas para ver el estado en que han quedado"))
	end if
	// FIN MODIFICADO RICARDO 04-05-10
end if

// Recuperamos el primer y el $$HEX1$$fa00$$ENDHEX$$ltimo n$$HEX2$$ba002000$$ENDHEX$$de factura de la remesa, ordenando por n$$HEX2$$ba002000$$ENDHEX$$factura el dw y seleccionando
// la primera y la $$HEX1$$fa00$$ENDHEX$$ltima. Por $$HEX1$$fa00$$ENDHEX$$ltimo dejamos el dw con la ordenacion que ten$$HEX1$$ed00$$ENDHEX$$a.
dw_domiciliaciones.setredraw(false)
dw_domiciliaciones.setsort('n_fact')
dw_domiciliaciones.sort()
primera_fact = dw_domiciliaciones.getitemstring(1, 'n_fact')
ultima_fact = dw_domiciliaciones.getitemstring(dw_domiciliaciones.rowcount(), 'n_fact')
dw_domiciliaciones.setsort('')
dw_domiciliaciones.sort()
dw_domiciliaciones.setredraw(true)

choose case upper(i_modulo)
	case 'COBROS'
		tipo_dom = 'C'
	case 'COLEGIADOS'
		tipo_dom = 'G'
	case 'CLIENTES'
		tipo_dom = 'P'
	case else
		tipo_dom = 'S'
end choose

//Insertamos la remesa en la tabla remesas
INSERT INTO remesas( n_remesa,fecha,descripcion,tipo,anulada,banco,n_fact_desde, n_fact_hasta,empresa )  
  VALUES ( :n_remesa,:i_datos_remesa.fecha,:i_datos_remesa.concepto,:tipo_dom,'N',:i_datos_remesa.banco,:primera_fact,:ultima_fact , :g_empresa);
COMMIT;

cb_f19.enabled=true
cb_domicilia_cobros.enabled=false
cb_domicilia_saldos.enabled=false
this.enabled=false
st_aviso.text = 'Datos Actualizados..'
update contadores set valor=:contador where contador = 'N_REMESA';
COMMIT;
i_datos_actualizados=true

end event

type dw_datos_remesa from u_dw within w_cobros_pre_remesa
integer x = 1266
integer y = 68
integer width = 2231
integer height = 708
integer taborder = 10
string dataobject = "d_cobros_datos_remesa"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;string n_cuenta

CHOOSE CASE dwo.name
	CASE 'banco'
		this.SetItem(1,'codigo',f_cobros_devuelve_ncontrol(data))
		select cuenta_bancaria_iban into :n_cuenta from csi_bancos where codigo= :data;
		
		n_cuenta = gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban(n_cuenta)
		
		this.SetItem(1,'cuenta_banco',n_cuenta)
END CHOOSE
end event

event constructor;call super::constructor;//// MODIFICADO RICARDO 04-03-03
//// SOLO VISUALIZAMOS EL FORMATO PARA EL COLEGIO DE LA RIOJA
//CHOOSE CASE g_colegio
//	CASE 'COAATLR'
//		this.object.formato_trans_t.visible = true
//		this.object.formato_trans.visible = true
//END CHOOSE
//// FIN MODIFICADO RICARDO 04-03-03

end event

type st_aviso from statictext within w_cobros_pre_remesa
integer x = 1870
integer y = 2256
integer width = 1422
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_extracto_remesa_ncol from u_dw within w_cobros_pre_remesa
boolean visible = false
integer x = 347
integer y = 1068
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_cobros_listado_remesa_por_ncol"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type dw_apuntes_dom from u_dw within w_cobros_pre_remesa
boolean visible = false
integer x = 3442
integer y = 1756
integer width = 274
integer height = 192
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_apuntes_traspasos"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.settransobject(bd_ejercicio)
end event

type gb_1 from groupbox within w_cobros_pre_remesa
string tag = "texto=cobros.datos_remesa"
integer x = 1239
integer y = 8
integer width = 2286
integer height = 820
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Datos Remesa"
end type

type dw_mas_datos from u_dw within w_cobros_pre_remesa
event csd_formatea_n_remesa ( string dato )
integer x = 18
integer y = 4
integer width = 1166
integer height = 868
integer taborder = 20
string dataobject = "d_cobros_mas_datos_remesa"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_formatea_n_remesa(string dato);string n_remesa_formateado
n_remesa_formateado = f_rellenar_ceros_campo(dato, 10)
if n_remesa_formateado <> dato then
	dw_mas_datos.setitem(1, 'n_remesa', n_remesa_formateado)
end if
end event

event buttonclicked;int copias,i
string orden

orden = dw_datos_remesa.GetItemString(1,'ordenar')
copias = dw_mas_datos.getItemNumber(1,'num_copias')

if dw_mas_datos.GetItemString(1,'tipo_informe')='D' then
	for i= 1 to copias
		dw_domiciliaciones.Print()
	next
else
	dw_extracto_remesa.Object.t_mensaje.visible=true
	dw_extracto_remesa.Object.compute_10.visible=false
	dw_extracto_remesa.Sort()
	dw_extracto_remesa_ncol.Object.t_mensaje.visible=true
	dw_extracto_remesa_ncol.Object.compute_10.visible=false
	dw_extracto_remesa_ncol.Sort()
	for i = 1 to copias
		if orden='A' then 
			dw_extracto_remesa.Print()
		else
			dw_extracto_remesa_ncol.Print()
		end if
	next
	dw_extracto_remesa.Object.t_mensaje.visible=false
	dw_extracto_remesa.Object.compute_10.visible=true
	dw_extracto_remesa_ncol.Object.t_mensaje.visible=false
	dw_extracto_remesa_ncol.Object.compute_10.visible=true
end if

end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'n_remesa'
			this.post event csd_formatea_n_remesa(data)
end choose
end event

type dw_domiciliaciones from u_dw within w_cobros_pre_remesa
integer x = 5
integer y = 960
integer width = 4055
integer height = 1296
integer taborder = 10
string dataobject = "d_cobros_domiciliaciones"
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)
this.of_SetTransObject(SQLCA)

// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)
end event

event itemchanged;call super::itemchanged;// MODIFICADO RICARDO 04-02-26
string id_cobro
long fila_actualizar



// Si modifican cualquier cosa deben actualizar antes los datos, sin dejar que generen el fichero f_19 si es que lo habian habilitado ya
cb_f19.enabled = false
cb_actualiza.enabled = true

CHOOSE CASE dwo.name
	CASE 'activo'
		if i_modulo = 'COBROS' or i_modulo ='COLEGIADOS'then
			// Al marcar el activo debemos marcar el remesar del correspondiente en la ventana de lista para que 
			// vuelva a ser procesado ya que en el actualizar datos se desmarca cuando no se marca el activo para que 
			// no se coloquen los correspondientes campos
			id_cobro = this.getitemstring(row, 'referencia')
			fila_actualizar = i_dw_lista_cobros.find("id_pago = '"+id_cobro + "'",1 , i_dw_lista_cobros.RowCount())
			// Si la encontramos (deberia ser lo habitual)
			if fila_actualizar>0 then
				// Colocamos el remesar como el activo
				i_dw_lista_cobros.SetItem(fila_actualizar,'remesar', string(data))
			end if
		end if
END CHOOSE
end event

type cb_recibir_f19 from commandbutton within w_cobros_pre_remesa
string tag = "texto=cobros.recibir_f19"
boolean visible = false
integer x = 1024
integer y = 2296
integer width = 361
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recibir F19"
end type

event clicked;//open(w_dev_devoluciones_bancarias)
end event

type dw_extracto_remesa from u_dw within w_cobros_pre_remesa
boolean visible = false
integer y = 964
integer width = 3511
integer height = 1296
integer taborder = 20
string title = "Datos Remesa"
string dataobject = "d_cobros_listado_remesa"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type st_1 from statictext within w_cobros_pre_remesa
string tag = "texto=cobros.incluir_remesa_cobros"
integer x = 14
integer y = 888
integer width = 1152
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean italic = true
long textcolor = 8388608
long backcolor = 67108864
string text = "S$$HEX1$$f300$$ENDHEX$$lo se incluir$$HEX1$$e100$$ENDHEX$$n en la remesa los cobros marcados."
boolean border = true
boolean focusrectangle = false
end type

type cb_domicilia_cobros from commandbutton within w_cobros_pre_remesa
string tag = "texto=cobros.generar_domiciliaciones"
integer x = 1202
integer y = 880
integer width = 581
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Generar Domiciliaciones "
end type

event clicked;
int datos

dw_datos_remesa.AcceptText()
datos = parent.Event csd_comprueba_datos()
if datos=-1 then return

dw_domiciliaciones.Reset()
//Modificado Ricardo 04-05-07
//reseteamos tambien las variables de instancia que indican las cantidadades de facturas
i_generadas = 0
i_falladas = 0
//FIN Modificado Ricardo 04-05-07
dw_extracto_remesa.Reset()
dw_extracto_remesa_ncol.reset()
parent.TriggerEvent('csd_domicilia_cobros')
cb_actualiza.enabled=true
i_datos_actualizados=false

end event

type cb_domicilia_saldos from commandbutton within w_cobros_pre_remesa
string tag = "texto=cobros.generar_domiciliaciones"
integer x = 1202
integer y = 880
integer width = 581
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Generar Domiciliaciones "
end type

event clicked;double i
datetime fecha_conta
string id_col
st_apunte datos_apunte
int mal,datos

if f_puedo_escribir(g_usuario,'0000000031')=-1 then return -1

datos = parent.Event csd_comprueba_datos()

if datos=-1 then return

dw_domiciliaciones.reset()
dw_extracto_remesa.reset()
dw_extracto_remesa_ncol.reset()
dw_apuntes_dom.reset()
//Modificado Ricardo 04-05-07
//reseteamos tambien las variables de instancia que indican las cantidadades de facturas
i_generadas = 0
i_falladas = 0
//FIN Modificado Ricardo 04-05-07

parent.TriggerEvent('csd_datos_remesa')
if isnull(i_datos_remesa.banco) then return
SetPointer(HourGlass!)
//IF f_es_vacio(g_sica_diario.domic_saldo) then g_sica_diario.domic_saldo=g_diario_generados_sica

iult_ast = f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.domic_saldo,7)
iimporte_total = 0
g_apunte.n_apunte = '00000'

fecha_conta = i_fecha_apuntes
dw_apuntes_dom.reset()

for i=1 to i_dw_lista_cobros.RowCount()
	if i_dw_lista_cobros.GetItemString(i,'procesar') = 'S' then
		id_col=i_dw_lista_cobros.GetItemString(i,'cuentas_id_col')
			 
			in_banco= i_datos_remesa.banco
		  	Parent.Event csd_generar_domiciliaciones_saldos(i)
			st_aviso.text = 'Generadas : '+string(i_generadas)+ ' domiciliaciones.'
			st_aviso2.text ='Falladas  : '+string(i_falladas)+ ' domiciliaciones.'
//		end if
	end if		
next
if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)

// MODIFICADO RICARDO 04-03-18
IF g_contabilidad_automatica then
	string cuenta2
	select cuenta_contable into :cuenta2 from csi_bancos where codigo = : i_datos_remesa.banco;
	//Apunte banco
	datos_apunte.diario = g_sica_diario.domic_saldo
	datos_apunte.n_asiento = iult_ast
	datos_apunte.n_apunte = g_apunte.n_apunte
	datos_apunte.cuenta = cuenta2
	datos_apunte.fecha = datetime(date(fecha_conta), time("00:00:00"))
	datos_apunte.t_doc = g_sica_t_doc.domic_saldo
	datos_apunte.concepto = 'DOMICILIACION DE SALDO DEUDOR'
	datos_apunte.debe = iimporte_total
	datos_apunte.haber = 0
	datos_apunte.proyecto = g_explotacion_por_defecto
	datos_apunte.n_doc = ''
	datos_apunte.centro = g_centro_por_defecto
	datos_apunte.t_asiento = g_t_asiento_apuntes_automaticos
	
	f_apunte_dw(datos_apunte,dw_apuntes_dom,'E')

	if i_generadas > 0 then Messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.asiento_numero','Proceso finalizado, $$HEX1$$fa00$$ENDHEX$$ltimo asiento generado n$$HEX1$$fa00$$ENDHEX$$mero : ') + string(iult_ast))
end if

cb_actualiza.enabled=true
i_datos_actualizados=false

end event

