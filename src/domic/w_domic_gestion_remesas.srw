HA$PBExportHeader$w_domic_gestion_remesas.srw
forward
global type w_domic_gestion_remesas from w_response
end type
type dw_busqueda from u_dw within w_domic_gestion_remesas
end type
type dw_lista_remesas from u_dw within w_domic_gestion_remesas
end type
type dw_domiciliaciones from u_dw within w_domic_gestion_remesas
end type
type cb_1 from commandbutton within w_domic_gestion_remesas
end type
type cb_2 from commandbutton within w_domic_gestion_remesas
end type
type st_texto from statictext within w_domic_gestion_remesas
end type
type dw_extracto_remesa from u_dw within w_domic_gestion_remesas
end type
type dw_extracto_remesa_ncol from u_dw within w_domic_gestion_remesas
end type
type cb_ver_apuntes from commandbutton within w_domic_gestion_remesas
end type
type gb_1 from groupbox within w_domic_gestion_remesas
end type
type dw_apuntes from u_dw within w_domic_gestion_remesas
end type
type cb_sel_todos from commandbutton within w_domic_gestion_remesas
end type
type cb_quitar_todos from commandbutton within w_domic_gestion_remesas
end type
type st_1 from statictext within w_domic_gestion_remesas
end type
end forward

global type w_domic_gestion_remesas from w_response
integer width = 4398
integer height = 2532
string title = "Gesti$$HEX1$$f300$$ENDHEX$$n de Remesas de Domiciliaciones"
dw_busqueda dw_busqueda
dw_lista_remesas dw_lista_remesas
dw_domiciliaciones dw_domiciliaciones
cb_1 cb_1
cb_2 cb_2
st_texto st_texto
dw_extracto_remesa dw_extracto_remesa
dw_extracto_remesa_ncol dw_extracto_remesa_ncol
cb_ver_apuntes cb_ver_apuntes
gb_1 gb_1
dw_apuntes dw_apuntes
cb_sel_todos cb_sel_todos
cb_quitar_todos cb_quitar_todos
st_1 st_1
end type
global w_domic_gestion_remesas w_domic_gestion_remesas

type variables
boolean i_modificado = false
end variables

forward prototypes
public subroutine wf_dame_datos_cliente (string id_cliente, ref string nom, ref string ape, ref string da, ref string pa, ref string nif)
public function integer wf_genera_f19 (st_cobros_datos_remesa datos_remesa, string formato)
end prototypes

public subroutine wf_dame_datos_cliente (string id_cliente, ref string nom, ref string ape, ref string da, ref string pa, ref string nif);string tipo_via, nom_via, cod_pob, cod_prov, cp

select nombre, apellidos ,tipo_via, nombre_via, cod_pob, cod_prov, nif, cp
into :nom, :ape,:tipo_via,:nom_via, :cod_pob, :cod_prov, :nif, :cp from clientes where id_cliente=:id_cliente using SQLCA;
da= f_obtener_domicilio_activo(tipo_via, nom_via)
pa= f_obtener_poblacion_activa(cod_pob, cod_prov, cp)

end subroutine

public function integer wf_genera_f19 (st_cobros_datos_remesa datos_remesa, string formato);// MODIFICADA POR RICARDO PARA EL FORMATO DE LA RIOJA
//	FECHA MODIFICACION 04-03-02
                                     
double n,importe,tot_rem,imp_cli,retorno,id
long asiento,apunte,tot_cred,tot_reg, cuantos_recibos,copias,row
string cuenta,linea,cc,id_col,n_remesa,ls_tipo_remesa,id_cobro,iban
string cod_pres,nom_pres,tipo,concepto1,concepto2, concepto3,promo,expdte,docto,concepto
string nom_fich, nom_fich_completo, cod_ine,cod_dev,rfcia,nom_cli,ccc_cli,conc_domi,cancelada, nom_fich_completo_XML
string desglosar,cod_ref,orden, nombre_banco, cod_banco
string direccion_colegio,poblacion_colegio, id_fase, id_minuta, n_registro, descripcion, n_expedi, t_visado, cliente, n_col
datastore ds_lineas_fichero,ds_lineas_facts
string n_factura, stotal_iva
datetime f_factura
string t_iva,conc_1,conc_2
string ssubtotal,ssubtotal_iva,scant_iva,spor,stotal
double num_linea,subtotal,subtotal_iva,cant_iva,por,total, total_iva
int fila_movimiento, fila_clientes,i
string entidad, ctabco, ls_iban_banco_remesa, ls_iban, ls_bic
string n_colegiado
boolean lb_desglose_factura = TRUE

retorno = 0

ds_lineas_facts	= create datastore	
ds_lineas_facts.dataobject = 'd_lineas_fact_emitidas'
ds_lineas_facts.SetTransObject(SQLCA)

ds_lineas_fichero	= create datastore	
ds_lineas_fichero.dataobject = 'ds_cobros_lineas_remesa'
ds_lineas_fichero.SetTransObject(SQLCA)

n_remesa = dw_lista_remesas.getItemString(dw_lista_remesas.getrow(),'n_remesa')

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

SELECT cuenta_contable, cuenta_bancaria_iban INTO :cc, :ls_iban_banco_remesa  FROM csi_bancos  WHERE codigo = :datos_remesa.banco and empresa = :g_empresa;
ctabco = gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban(ls_iban_banco_remesa)

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02

// Obtenemos el nombre del fichero a generar
//if(datos_remesa.formato='S') then nom_fich = nom_fich + '_14'
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
		if (datos_remesa.formato='S') then nom_fich = nom_fich + '_14'
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
linea=''
linea='5380'+cod_pres+string(today(),'ddmmyy')+string(today(),'ddmmyy')+nom_pres+ctabco+space(8)+'01'+space(10)+direccion_colegio+poblacion_colegio
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
   if dw_domiciliaciones.GetItemString(n,'activo')='N' then 
		//Le quitamos la referencia al n$$HEX2$$ba002000$$ENDHEX$$de remesa.. ya que ahora no va con esta remesa...
//		update csi_cobros set n_remesa = '', pagado = 'N' where id_pago =:id_cobro; // Modificado Ricardo 04-02-26
		continue
	end if
	cuantos_recibos++
	imp_cli		=dw_domiciliaciones.GetItemNumber(n,'importe')
	tot_rem		=tot_rem+imp_cli
	ccc_cli		=f_completar_con_caracteres( dw_domiciliaciones.GetItemString(n,'banco_dom'), 20,'D',' ')
	ls_iban		=dw_domiciliaciones.GetItemString(n,'iban')
	ls_bic			=dw_domiciliaciones.GetItemString(n,'bic')
	rfcia			=dw_domiciliaciones.GetItemString(n,'referencia')
	tipo			=dw_domiciliaciones.GetItemString(n,'tipo')
	docto			=trim(dw_domiciliaciones.GetItemString(n,'documento'))
	conc_domi	=dw_domiciliaciones.GetItemString(n,'concepto')
	id_col			=dw_domiciliaciones.GetItemString(n,'id_col')
	
	// Si el importe es 0 no debe generar la linea
	if imp_cli = 0 then continue
		
	//Ponemos el n$$HEX2$$ba002000$$ENDHEX$$de remesa en cada cobro
	if not(f_es_vacio(id_cobro)) then 
		update csi_cobros set n_remesa = :n_remesa where id_pago = :id_cobro;
	end if
	
	string nom, ape, da, pa, cp, nif
	CHOOSE CASE dw_domiciliaciones.GetItemString(n,'tipo_persona')
		CASE 'P'
			wf_dame_datos_cliente(id_col, nom, ape, da, pa, nif)
			n_col = nif
			
			// David 23/12/2005: Cuando es un tercero hay que coger su nif
			cod_ref=f_completar_con_caracteres(n_col,12,'I','0')
		CASE ELSE
			//Andr$$HEX1$$e900$$ENDHEX$$s 11/10/2005: Ahora gastamos el n_colegiado para el campo cod_ref
			//	cod_ref = f_completar_con_caracteres(rfcia,12,'D',' ')	
			n_colegiado=f_colegiado_n_col(id_col)
			cod_ref=f_completar_con_caracteres(n_colegiado,12,'I','0')
			
			// cogemos los datos del cliente que sean necesarios para meterlos en la domiciliacion
			select nombre, apellidos ,domicilio_activo,poblacion_activa, nif, n_colegiado into :nom, :ape,:da,:pa,:nif,:n_col from colegiados where id_colegiado=:id_col using SQLCA;
	END CHOOSE

	if isnull(nom) then nom = ''
	if isnull(da) then da=''
	if isnull(pa) then pa=''
	if isnull(nif) then nif=''
	
	promo = nif+' '+ape + ' ' + nom
	promo=f_cobros_reemplaza_cadena(promo,',',' ')
	cp = MidA(pa,1,5)
	if f_es_vacio(cp) then cp=''
	// Quito el codigo postal de la poblacion activa que no me gusta
	pa = MidA(pa, 7, LenA(pa))
	
	//Rellenamos el 1er Registro Individual Obligatorio 
	nom_cli=MidA(f_transforma_cadena_win_dos(f_cobros_reemplaza_cadena(promo,',',' '))+space(40),1,40)
	//registro CSB de individuales + opcional   (56->euros) 
	string importe_texto,id_factura
	importe_texto = RightA('0000000000000'+trim(string(round(imp_cli * 100,0))),10)
	
	concepto = dw_domiciliaciones.getitemstring(n,'concepto')
	
	if f_es_vacio(concepto) then 
		conc_domi = 'DOM.'+MidA(conc_domi,1,18)
	else 
		conc_domi = concepto
	end if
	concepto1 = f_completar_con_caracteres(conc_domi,40,'D',' ')
	
	SELECT tipo INTO :ls_tipo_remesa from remesas where n_remesa = :n_remesa AND empresa = :g_empresa ; 
	IF upper(ls_tipo_remesa) = 'S' THEN 	lb_desglose_factura = FALSE // Domiciliaci$$HEX1$$f300$$ENDHEX$$n Saldos Deudores

	linea='5680'+cod_pres+cod_ref+nom_cli+ccc_cli+importe_texto+cod_dev+f_completar_con_caracteres(id_cobro,10,'D',' ') +concepto1+string(today(),'ddmmyy')+space(2) 
	if datos_remesa.formato <> 'N' then linea += f_completar_con_caracteres(ls_iban,34,'D',' ') + f_completar_con_caracteres(ls_bic,11,'D',' ') + f_completar_con_caracteres( f_concepto_sepa_ampliado_norma19 (lb_desglose_factura, formato, id_cobro) ,100,'D',' ')
	f_cobros_inserta_linea_fichdomi(ds_lineas_fichero,linea)
	tot_cred=tot_cred+1
	tot_reg=tot_reg+1
	
	CHOOSE CASE formato
		CASE 'SIN', 'SN' // Las l$$HEX1$$ed00$$ENDHEX$$neas que estaban aqu$$HEX2$$ed002000$$ENDHEX$$eran comunes, y se han factorizado dej$$HEX1$$e100$$ENDHEX$$ndolas antes de entrar
		
		CASE 'PREMAAT', 'SRCFIJA', 'SD'
			num_linea = 1
			// Obtenemos fecha y numero de factura
			select csi_facturas_emitidas.n_fact, csi_facturas_emitidas.fecha
			into :n_factura, :f_factura from csi_cobros, csi_facturas_emitidas
			where csi_cobros.id_factura = csi_facturas_emitidas.id_factura and id_pago = :id_cobro;
			
			//Colocamos la fecha y el numero de fatura
			conc_1   = LeftA('N$$HEX2$$ba002000$$ENDHEX$$de Documento = '+n_factura+space(40),40)
			concepto = LeftA('Fecha Documento = '+string(f_factura, "dd mm yyyy")+space(40),40)
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
				
				// Ponemos el numero de contrato y de expediente
				concepto = 'N$$HEX1$$ba00$$ENDHEX$$Contrato/N$$HEX1$$ba00$$ENDHEX$$Exp : '+n_registro+'   ' +n_expedi
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
			conc_1   = LeftA('N$$HEX2$$ba002000$$ENDHEX$$de Factura = '+n_factura+space(40),40)
			concepto = LeftA('Fecha Factura = '+string(f_factura, "dd mm yyyy")+space(40),40)

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
	dw_extracto_remesa.SetItem(row,'fecha',dw_lista_remesas.getItemDatetime(dw_lista_remesas.GetRow(),'fecha'))
	dw_extracto_remesa.SetItem(row,'importe',dw_domiciliaciones.GetItemNumber(n,'importe'))
	dw_extracto_remesa.SetItem(row,'banco_dom',dw_domiciliaciones.GetItemString(n,'banco_dom'))
	dw_extracto_remesa.SetItem(row,'iban',dw_domiciliaciones.GetItemString(n,'iban'))
	dw_extracto_remesa.SetItem(row,'bic',dw_domiciliaciones.GetItemString(n,'bic'))
	dw_extracto_remesa.SetItem(row,'n_arqui',dw_domiciliaciones.GetItemString(n,'n_arqui'))
	CHOOSE CASE dw_domiciliaciones.GetItemString(n,'tipo_persona')
		CASE 'P'
			dw_extracto_remesa.SetItem(row,'colegiados_apellidos',dw_domiciliaciones.GetItemString(n,'nombre'))
		CASE ELSE
			dw_extracto_remesa.SetItem(row,'colegiados_apellidos',f_colegiado_apellido(id_col))//f_colegiado_nombre_apellido(id_col))
	END CHOOSE
	dw_extracto_remesa.SetItem(row,'colegiados_nombre','')
	dw_extracto_remesa.SetItem(row,'n_fact',dw_domiciliaciones.GetItemString(n,'n_fact'))

	// MODIF PACO 6/4/2005. Para que muestre la cuenta bancario en el p$$HEX1$$e100$$ENDHEX$$rrafo.
	dw_extracto_remesa.SetItem(row,'csi_bancos_nombre', nombre_banco)
	dw_extracto_remesa.SetItem(row,'csi_bancos_entidad',mid(ctabco, 1,4))
	dw_extracto_remesa.SetItem(row,'csi_bancos_sucursal',mid(ctabco, 5,4))
	dw_extracto_remesa.SetItem(row,'csi_bancos_cod_seg',mid(ctabco, 9,2))
	dw_extracto_remesa.SetItem(row,'csi_bancos_cuenta_banco',mid(ctabco, 11,10))
	dw_extracto_remesa.SetItem(row,'csi_bancos_cuenta_bancaria_iban',ls_iban_banco_remesa)
	dw_extracto_remesa.SetItem(row,'ref_interna',dw_lista_remesas.getItemString(dw_lista_remesas.GetRow(),'n_remesa'))
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
	Messagebox(g_titulo,'N$$HEX2$$ba002000$$ENDHEX$$Remesa : '+n_remesa+cr+'Procesados '+string(cuantos_recibos) + ' recibos: ' + string(tot_rem,'#,##0.00') + ' euros.',Information!)
   MessageBox('ATENCI$$HEX1$$d300$$ENDHEX$$N','Actualizaci$$HEX1$$f300$$ENDHEX$$n con $$HEX1$$e900$$ENDHEX$$xito.'+CharA(10)+CharA(13)+'Recuerde mandar al banco el fichero '+nom_fich)
   retorno=1	
   commit;
else
   MessageBox('ATENCI$$HEX1$$d300$$ENDHEX$$N ERROR','Ha ocurrido alg$$HEX1$$fa00$$ENDHEX$$n fallo al actualizar. Avise al Dpto. de Inform$$HEX1$$e100$$ENDHEX$$tica.',Exclamation!)
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
for i=1 to f_var_global_numero('numero_impresos_listados_domiciliaciones')
	dw_extracto_remesa.Print()
next

SetPointer(Arrow!)

destroy ds_lineas_fichero
destroy ds_lineas_facts
//destroy dw_domiciliaciones

return retorno
end function

event open;dw_busqueda.InsertRow(0)

gnv_control_cuentas_bancarias.of_sepa_habilitado (dw_busqueda)
end event

on w_domic_gestion_remesas.create
int iCurrent
call super::create
this.dw_busqueda=create dw_busqueda
this.dw_lista_remesas=create dw_lista_remesas
this.dw_domiciliaciones=create dw_domiciliaciones
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_texto=create st_texto
this.dw_extracto_remesa=create dw_extracto_remesa
this.dw_extracto_remesa_ncol=create dw_extracto_remesa_ncol
this.cb_ver_apuntes=create cb_ver_apuntes
this.gb_1=create gb_1
this.dw_apuntes=create dw_apuntes
this.cb_sel_todos=create cb_sel_todos
this.cb_quitar_todos=create cb_quitar_todos
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_busqueda
this.Control[iCurrent+2]=this.dw_lista_remesas
this.Control[iCurrent+3]=this.dw_domiciliaciones
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.st_texto
this.Control[iCurrent+7]=this.dw_extracto_remesa
this.Control[iCurrent+8]=this.dw_extracto_remesa_ncol
this.Control[iCurrent+9]=this.cb_ver_apuntes
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.dw_apuntes
this.Control[iCurrent+12]=this.cb_sel_todos
this.Control[iCurrent+13]=this.cb_quitar_todos
this.Control[iCurrent+14]=this.st_1
end on

on w_domic_gestion_remesas.destroy
call super::destroy
destroy(this.dw_busqueda)
destroy(this.dw_lista_remesas)
destroy(this.dw_domiciliaciones)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_texto)
destroy(this.dw_extracto_remesa)
destroy(this.dw_extracto_remesa_ncol)
destroy(this.cb_ver_apuntes)
destroy(this.gb_1)
destroy(this.dw_apuntes)
destroy(this.cb_sel_todos)
destroy(this.cb_quitar_todos)
destroy(this.st_1)
end on

event csd_recuperar_consulta;call super::csd_recuperar_consulta;gnv_control_cuentas_bancarias.of_sepa_habilitado (dw_busqueda)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_domic_gestion_remesas
integer x = 2551
integer y = 2408
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_domic_gestion_remesas
integer x = 2011
integer y = 2404
end type

type dw_busqueda from u_dw within w_domic_gestion_remesas
event csd_formatea_n_remesa ( string dato )
integer x = 37
integer y = 28
integer width = 1495
integer height = 676
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_domic_busqueda_remesa"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_formatea_n_remesa;string n_remesa_formateado
n_remesa_formateado = f_rellenar_ceros_campo(dato, 10)
if n_remesa_formateado <> dato then
	this.setitem(1, 'n_remesa', n_remesa_formateado)
end if
end event

event buttonclicked;call super::buttonclicked;string sql_nuevo,sql_old
string n_remesa

SetPointer(HourGlass!)
this.AcceptText()
dw_domiciliaciones.Reset()
sql_nuevo = dw_lista_remesas.describe("datawindow.table.select")
sql_old = sql_nuevo
n_remesa = this.GetitemString(1,'n_remesa')
if not f_es_vacio(n_remesa) then 
	n_remesa = f_completar_con_caracteres(n_remesa,10,'I','0')
	this.SetItem(1,'n_remesa',n_remesa)
end if

f_sql('remesas.n_remesa','LIKE','n_remesa',this,sql_nuevo,'1','')
f_sql('remesas.fecha','>=','f_desde',this,sql_nuevo,'1','')
f_sql('remesas.fecha','<=','f_hasta',this,sql_nuevo,'1','')


dw_lista_remesas.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
dw_lista_remesas.Retrieve(g_empresa)
// Hacemos que se carguen los datos de la remesa actual
if dw_lista_remesas.rowcount() = 0 then return
dw_lista_remesas.trigger event csd_recuperar_remesa()
dw_lista_remesas.modify("datawindow.table.select= ~"" + sql_old + "~"")
end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

//// MODIFICADO RICARDO 04-03-03
//// SOLO VISUALIZAMOS EL FORMATO PARA EL COLEGIO DE LA RIOJA
//CHOOSE CASE g_colegio
//	CASE 'COAATLR'
//		this.object.formato_trans_t.visible = true
//		this.object.formato_trans.visible = true
//END CHOOSE
//// FIN MODIFICADO RICARDO 04-03-03
//
end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'n_remesa'
			this.post event csd_formatea_n_remesa(data)
end choose
end event

type dw_lista_remesas from u_dw within w_domic_gestion_remesas
event csd_recuperar_remesa ( )
integer x = 1678
integer y = 96
integer width = 1851
integer height = 792
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_domic_lista_remesas"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event csd_recuperar_remesa();
string n_remesa, tipo_dom, id_col, nombre_col
datastore d_cobros_domiciliaciones
long currentrow
double i
d_cobros_domiciliaciones = create datastore
d_cobros_domiciliaciones.dataobject = 'd_cobros_domiciliaciones'
d_cobros_domiciliaciones.settransobject(sqlca)

// Cogemos la fila actual
currentrow = this.getrow()

n_remesa = this.getitemstring(currentrow,'n_remesa')
tipo_dom = this.getitemstring(currentrow,'tipo')
d_cobros_domiciliaciones.retrieve(n_remesa)
dw_domiciliaciones.retrieve(n_remesa)
dw_apuntes.retrieve(n_remesa)

// Si la domiciliaci$$HEX1$$f300$$ENDHEX$$n es de cobros
if tipo_dom <> 'S' then
	// Este if es por precauci$$HEX1$$f300$$ENDHEX$$n
	if d_cobros_domiciliaciones.rowcount() <> dw_domiciliaciones.rowcount() then return
	for i = 1 to d_cobros_domiciliaciones.rowcount()
		if d_cobros_domiciliaciones.getitemstring(i, 'id_domiciliacion') = dw_domiciliaciones.getitemstring(i, 'id_domiciliacion') then
			dw_domiciliaciones.setitem(i, 'n_fact', d_cobros_domiciliaciones.getitemstring(i, 'n_fact') )
			dw_domiciliaciones.setitem(i, 'nombre', d_cobros_domiciliaciones.getitemstring(i, 'nombre') )
		end if
	next
else
// Si es de saldos deudores	
	for i = 1 to dw_domiciliaciones.rowcount()
		id_col = dw_domiciliaciones.getitemstring(i, 'id_col')
		nombre_col = f_colegiado_apellido(id_col)
		dw_domiciliaciones.setitem(i, 'nombre', nombre_col)
	next
end if

dw_domiciliaciones.resetupdate()
end event

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
end event

event rowfocuschanged;call super::rowfocuschanged;if this.rowcount() = 0 then return
this.setrow(currentrow)
// Recuperamos la remesa
this.trigger event csd_recuperar_remesa()
end event

type dw_domiciliaciones from u_dw within w_domic_gestion_remesas
integer x = 37
integer y = 944
integer width = 4334
integer height = 1356
integer taborder = 11
boolean bringtotop = true
string title = "Gesti$$HEX1$$f300$$ENDHEX$$n de Remesas"
string dataobject = "d_domic_datos_remesa"
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)
this.of_SetTransObject(SQLCA)
end event

event retrieveend;call super::retrieveend;int i
for i=1 to rowcount
	this.SetItem(i,'activo','S')
next

st_texto.text = string(rowcount)+' domiciliaciones'

end event

event itemchanged;call super::itemchanged;//El campo 'remesar' es un compute que no implica cambios en la BDA
if dwo.name <>'remesar' then i_modificado=true
end event

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_insert.visible = false
am_dw.m_table.m_addrow.visible = false

end event

event type integer pfc_predeleterow();call super::pfc_predeleterow;// Quiere borrar la factura de la remesa
string n_fact, id_cobro,contabilizado, id_factura
datetime f_nulo
setnull(f_nulo)

if AncestorReturnValue>0 then 
	n_fact 	= dw_domiciliaciones.GetItemString(dw_domiciliaciones.getrow(),'n_fact')
	id_cobro 	=dw_domiciliaciones.GetItemString(dw_domiciliaciones.getrow(),'referencia')  //En el campo referencia guardamos el id_cobro
	select contabilizado into :contabilizado from csi_cobros where id_pago = :id_cobro;
	if contabilizado = 'S' then
		Messagebox(g_titulo, "El cobro de la factura "+n_fact+" ya est$$HEX2$$e1002000$$ENDHEX$$contabilizado, por lo que no puede desremesarse", stopsign!)
		return 0
	end if
	if Messagebox(g_titulo, "$$HEX1$$bf00$$ENDHEX$$Desea eliminar la factura "+n_fact+" de la remesa? "+cr+"Borrarla de la remesa implica dejarla como impagada", question!, yesno!, 2) = 2 then 
		return 0 
	else
		// Hemos de quitar el numero de remesa del cobro, quitar el pagado y volver a dejar todo tal como est$$HEX2$$e1002000$$ENDHEX$$ahora (los check de activo)
		//Le quitamos la referencia al n$$HEX2$$ba002000$$ENDHEX$$de remesa.. ya que ahora no va con esta remesa...
		update csi_cobros set n_remesa = '', pagado = 'N', f_pago =:f_nulo where id_pago =:id_cobro; // Modificado Ricardo 04-02-26
		// Deberiamos desmarcar la cabecera
		select id_factura into :id_factura from csi_cobros where id_pago = :id_cobro;
		if not f_es_vacio(id_factura) then
			update csi_facturas_emitidas set pagado = 'N', f_pago = :f_nulo where id_factura = :id_factura;
		end if
		// Confirmamos el grabado
		commit;
	end if
	
end if
return AncestorReturnValue

/*
for n=1 to dw_domiciliaciones.RowCount()
	dw_domiciliaciones.SetItem(n,'remesado','N')	
	id_cobro 	=dw_domiciliaciones.GetItemString(n,'referencia')  //En el campo referencia guardamos el id_cobro
   if dw_domiciliaciones.GetItemString(n,'activo')='N' then 
		// PARA GUIPUZCOA SACAN FICHEROS PARCIALES DE LAS REMESAS, LUEGO NO SE PUEDEN QUITAR 
//		//Le quitamos la referencia al n$$HEX2$$ba002000$$ENDHEX$$de remesa.. ya que ahora no va con esta remesa...
//		update csi_cobros set n_remesa = '', pagado = 'N' where id_pago =:id_cobro; // Modificado Ricardo 04-02-26
		continue
	end if

*/
end event

event type integer pfc_deleterow();call super::pfc_deleterow;if AncestorReturnValue>0 then
	this.update()
	// Hacemos que se carguen los datos de la remesa actual
	dw_lista_remesas.post event csd_recuperar_remesa()
end if
return AncestorReturnValue

end event

type cb_1 from commandbutton within w_domic_gestion_remesas
integer x = 1262
integer y = 2328
integer width = 379
integer height = 100
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Anular Remesa"
end type

event clicked;int i
string id_cobro,n_remesa

if dw_lista_remesas.Rowcount()=0 then return

n_remesa = dw_lista_remesas.GetItemString(dw_lista_remesas.GetRow(),'n_remesa')
if Messagebox(g_titulo,'Se va a proceder a anular la remesa '+ n_remesa + cr+ '$$HEX1$$bf00$$ENDHEX$$Desea continuar?',Question!,YesNo!) = 2 then return
SetPointer(Hourglass!)
for i = 1 to dw_domiciliaciones.rowcount()
	id_cobro = dw_domiciliaciones.GetItemString(i,'referencia')
	update csi_cobros set n_remesa = '',f_pago=null,pagado='N' where id_pago = :id_cobro;
next
commit;
dw_lista_remesas.SetItem(dw_lista_remesas.GetRow(),'anulada','S')

SetPointer(Arrow!)
end event

type cb_2 from commandbutton within w_domic_gestion_remesas
integer x = 873
integer y = 2328
integer width = 379
integer height = 100
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Fichero F19"
end type

event clicked;st_cobros_datos_remesa datos_remesa
string formato

if dw_domiciliaciones.rowcount()=0 then return
datos_remesa.banco = dw_lista_remesas.getItemString(dw_lista_remesas.GetRow(),'banco')
formato = dw_busqueda.getitemstring(dw_busqueda.getRow(), 'formato_trans')
if f_es_vacio(formato) then 
        messagebox(g_titulo, "Debe indicar el formato de exportaci$$HEX1$$f300$$ENDHEX$$n del fichero")
        return
end if

datos_remesa.formato = dw_busqueda.getitemstring(dw_busqueda.getrow(), 'formato_norma')

// SEG$$HEX1$$da00$$ENDHEX$$N EL TIPO DE FORMATO ELEGIDO ACTUA
wf_genera_f19(datos_remesa, formato)

end event

type st_texto from statictext within w_domic_gestion_remesas
integer x = 2706
integer y = 2332
integer width = 745
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_extracto_remesa from u_dw within w_domic_gestion_remesas
boolean visible = false
integer x = 1783
integer y = 2316
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_cobros_listado_remesa"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_extracto_remesa_ncol from u_dw within w_domic_gestion_remesas
boolean visible = false
integer x = 2139
integer y = 2328
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_cobros_listado_remesa_por_ncol"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type cb_ver_apuntes from commandbutton within w_domic_gestion_remesas
integer x = 1655
integer y = 2328
integer width = 443
integer height = 100
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Visualizar Apuntes"
end type

event clicked;if not dw_apuntes.visible then
	cb_1.enabled = false
	cb_2.enabled = false
	dw_apuntes.visible = true
	dw_domiciliaciones.enabled = false
	dw_domiciliaciones.visible = false
	cb_ver_apuntes.text = '&Ocultar Apuntes'
else	
	cb_1.enabled = true
	cb_2.enabled = true
	dw_apuntes.visible = false
	dw_domiciliaciones.enabled = true
	dw_domiciliaciones.visible = true
	cb_ver_apuntes.text = '&Visualizar Apuntes'
end if	
	
	
end event

type gb_1 from groupbox within w_domic_gestion_remesas
integer x = 1664
integer y = 32
integer width = 1888
integer height = 876
integer taborder = 21
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_apuntes from u_dw within w_domic_gestion_remesas
boolean visible = false
integer x = 37
integer y = 944
integer width = 3392
integer height = 1356
integer taborder = 11
string dataobject = "d_apuntes_automaticos_fe"
boolean hscrollbar = true
end type

event constructor;call super::constructor;// Hacemos el filtrado por lo que diga la variable para las remesas
this.SetTransObject(bd_ejercicio)

string valor, filtro
filtro = "(diario = '"+g_sica_diario.remesas+"')"
filtro += "and (t_doc = '"+g_sica_t_doc.remesas+"')"
this.setfilter(filtro)

// Visualizamos unicamente los cobros de la remesa correspondiente
if not f_es_vacio(filtro) then 
	this.setfilter(filtro)
else
	this.setfilter("id_apunte = '-1'")
end if

end event

type cb_sel_todos from commandbutton within w_domic_gestion_remesas
integer x = 37
integer y = 2328
integer width = 389
integer height = 100
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Selecc. Todas"
end type

event clicked;long fila

FOR fila = 1 TO dw_domiciliaciones.RowCount()
	dw_domiciliaciones.SetItem(fila, 'activo', 'S')
NEXT
end event

type cb_quitar_todos from commandbutton within w_domic_gestion_remesas
integer x = 425
integer y = 2328
integer width = 389
integer height = 100
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Quitar Todas"
end type

event clicked;long fila

FOR fila = 1 TO dw_domiciliaciones.RowCount()
	dw_domiciliaciones.SetItem(fila, 'activo', 'N')
NEXT
end event

type st_1 from statictext within w_domic_gestion_remesas
integer x = 46
integer y = 732
integer width = 1472
integer height = 176
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
string text = "En el fichero a generar s$$HEX1$$f300$$ENDHEX$$lo aparecer$$HEX1$$e100$$ENDHEX$$n las facturas marcadas, pero todas ellas pertenecen a la remesa. Para borrarla seleccionar la misma, pulsar bot$$HEX1$$f300$$ENDHEX$$n derecho y borrar"
boolean border = true
boolean focusrectangle = false
end type

