HA$PBExportHeader$w_fases_detalle.srw
forward
global type w_fases_detalle from w_detalle
end type
type dw_fases_datos_exp from u_dw within w_fases_detalle
end type
type tab_1 from tab within w_fases_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_fases_promotores from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_fases_promotores dw_fases_promotores
end type
type tabpage_2 from userobject within tab_1
end type
type dw_fases_colegiados_asociados from u_dw within tabpage_2
end type
type dw_fases_colegiados from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_fases_colegiados_asociados dw_fases_colegiados_asociados
dw_fases_colegiados dw_fases_colegiados
end type
type tabpage_5 from userobject within tab_1
end type
type pb_calcular_dtos_nuevo from picturebutton within tabpage_5
end type
type pb_calcular_dtos from picturebutton within tabpage_5
end type
type dw_fases_estadistica_otros from u_dw within tabpage_5
end type
type dw_fases_estadistica from u_dw within tabpage_5
end type
type tabpage_5 from userobject within tab_1
pb_calcular_dtos_nuevo pb_calcular_dtos_nuevo
pb_calcular_dtos pb_calcular_dtos
dw_fases_estadistica_otros dw_fases_estadistica_otros
dw_fases_estadistica dw_fases_estadistica
end type
type tabpage_19 from userobject within tab_1
end type
type cip_tfe from u_dw within tabpage_19
end type
type tabpage_19 from userobject within tab_1
cip_tfe cip_tfe
end type
type tabpage_8 from userobject within tab_1
end type
type pb_recalcular_nuevo from commandbutton within tabpage_8
end type
type pb_recalcular from picturebutton within tabpage_8
end type
type dw_fases_informes from u_dw within tabpage_8
end type
type tabpage_8 from userobject within tab_1
pb_recalcular_nuevo pb_recalcular_nuevo
pb_recalcular pb_recalcular
dw_fases_informes dw_fases_informes
end type
type tabpage_13 from userobject within tab_1
end type
type pb_calculo_musaat from picturebutton within tabpage_13
end type
type cb_4 from commandbutton within tabpage_13
end type
type dw_fases_src from u_dw within tabpage_13
end type
type tabpage_13 from userobject within tab_1
pb_calculo_musaat pb_calculo_musaat
cb_4 cb_4
dw_fases_src dw_fases_src
end type
type tabpage_14 from userobject within tab_1
end type
type cb_generar_avisos from commandbutton within tabpage_14
end type
type cb_cobrar_avisos from commandbutton within tabpage_14
end type
type dw_fases_minutas from u_dw within tabpage_14
end type
type tabpage_14 from userobject within tab_1
cb_generar_avisos cb_generar_avisos
cb_cobrar_avisos cb_cobrar_avisos
dw_fases_minutas dw_fases_minutas
end type
type tabpage_4 from userobject within tab_1
end type
type dw_fases_reparos from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_fases_reparos dw_fases_reparos
end type
type tabpage_6 from userobject within tab_1
end type
type dw_reparos_nuevos from u_dw within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_reparos_nuevos dw_reparos_nuevos
end type
type tabpage_3 from userobject within tab_1
end type
type dw_fases_documentos from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_fases_documentos dw_fases_documentos
end type
type tabpage_12 from userobject within tab_1
end type
type dw_fases_estados from u_dw within tabpage_12
end type
type dw_fases_reclamaciones from u_dw within tabpage_12
end type
type tabpage_12 from userobject within tab_1
dw_fases_estados dw_fases_estados
dw_fases_reclamaciones dw_fases_reclamaciones
end type
type tabpage_9 from userobject within tab_1
end type
type dw_fases_otras_fases from u_dw within tabpage_9
end type
type tabpage_9 from userobject within tab_1
dw_fases_otras_fases dw_fases_otras_fases
end type
type tabpage_7 from userobject within tab_1
end type
type dw_fases_modificacion_datos from u_dw within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_fases_modificacion_datos dw_fases_modificacion_datos
end type
type tabpage_11 from userobject within tab_1
end type
type cb_anyadir from commandbutton within tabpage_11
end type
type dw_fases_registros from u_dw within tabpage_11
end type
type tabpage_11 from userobject within tab_1
cb_anyadir cb_anyadir
dw_fases_registros dw_fases_registros
end type
type tabpage_15 from userobject within tab_1
end type
type dw_finales_obra from u_dw within tabpage_15
end type
type tabpage_15 from userobject within tab_1
dw_finales_obra dw_finales_obra
end type
type tabpage_16 from userobject within tab_1
end type
type dw_arquitectos from u_dw within tabpage_16
end type
type tabpage_16 from userobject within tab_1
dw_arquitectos dw_arquitectos
end type
type tabpage_17 from userobject within tab_1
end type
type dw_garantias from u_dw within tabpage_17
end type
type tabpage_17 from userobject within tab_1
dw_garantias dw_garantias
end type
type tabpage_10 from userobject within tab_1
end type
type dw_incidencias from u_dw within tabpage_10
end type
type tabpage_10 from userobject within tab_1
dw_incidencias dw_incidencias
end type
type tabpage_18 from userobject within tab_1
end type
type cb_anyadir_factura_concilio from commandbutton within tabpage_18
end type
type dw_fases_pagos_facturas from u_dw within tabpage_18
end type
type dw_fases_pagos_plataforma from u_dw within tabpage_18
end type
type tabpage_18 from userobject within tab_1
cb_anyadir_factura_concilio cb_anyadir_factura_concilio
dw_fases_pagos_facturas dw_fases_pagos_facturas
dw_fases_pagos_plataforma dw_fases_pagos_plataforma
end type
type tab_1 from tab within w_fases_detalle
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_5 tabpage_5
tabpage_19 tabpage_19
tabpage_8 tabpage_8
tabpage_13 tabpage_13
tabpage_14 tabpage_14
tabpage_4 tabpage_4
tabpage_6 tabpage_6
tabpage_3 tabpage_3
tabpage_12 tabpage_12
tabpage_9 tabpage_9
tabpage_7 tabpage_7
tabpage_11 tabpage_11
tabpage_15 tabpage_15
tabpage_16 tabpage_16
tabpage_17 tabpage_17
tabpage_10 tabpage_10
tabpage_18 tabpage_18
end type
type dw_fases_botones from u_dw within w_fases_detalle
end type
type dw_2 from u_dw within w_fases_detalle
end type
type cb_1 from commandbutton within w_fases_detalle
end type
type dw_otros_datos from u_dw within w_fases_detalle
end type
end forward

global type w_fases_detalle from w_detalle
integer width = 4457
integer height = 2256
string title = "Detalle de Contratos de Expedientes"
string menuname = "m_detalle_fases"
long backcolor = 79416533
event csd_presupuesto ( )
event csd_importar_fase ( )
event csd_control_estados ( )
event csd_avisocobros ( )
event csd_visar ( )
event csd_deshabilitar_dw ( )
event csd_habilitar_dw ( )
event csd_desvisar ( )
event csd_rellenar_campos_ocultos_expediente ( )
event csd_refrescar_avisos ( )
event csd_refrescar_src ( )
event csd_cobrar_anticipo_musaat ( boolean generar,  boolean facturar )
event csd_desglose_honos ( )
event csd_importar_fase_visared ( )
event csd_visared_preupdate ( string id_fase )
event type integer csd_postupdate ( )
event type string csd_configura_datos_est ( )
event csd_facturar ( )
dw_fases_datos_exp dw_fases_datos_exp
tab_1 tab_1
dw_fases_botones dw_fases_botones
dw_2 dw_2
cb_1 cb_1
dw_otros_datos dw_otros_datos
end type
global w_fases_detalle w_fases_detalle

type variables
u_dw idw_fases_promotores, idw_fases_colegiados, idw_fases_documentos, idw_fases_reparos
u_dw idw_fases_reparos_nuevos
u_dw idw_fases_informes, idw_fases_modificacion_datos, idw_fases_datos_exp, idw_fases_otras_fases
u_dw idw_fases_estados, idw_fases_estadistica, idw_fases_registros, idw_fases_reclamaciones
u_dw idw_fases_src, idw_fases_minutas, idw_fases_colegiados_asociados, idw_fases_finales_obra
u_dw idw_fases_arquitectos, idw_fases_garantias, idw_fases_cip_tfe, idw_fases_incidencias
u_dw idw_fases_estadistica_otros, idw_fases_pagos_plataforma, idw_fases_pagos_facturas

DataWindowChild i_dwc_colegiados,i_dwc_colegiados_reparos,i_dwc_colegiados_src,i_dwc_clientes, i_dwc_colegiados_empresas
DataWindowChild i_dwc_colegiados_asociados,i_dwc_colegiados_garantias, i_dwc_clientes_garantias

string i_nif, i_campo_activo_dw_1 = 'f_entrada'
double i_porcen, i_pasa_preupdate
boolean i_nuevo
string i_tab_of, i_tab_mu, i_tab_mi, i_tab_re, i_tab_od, i_tab_es, i_tab_fo, i_tab_no

// Variable para ver si ha pasado por el retrieve end y mostrar los avisos
boolean ib_avisar_incidencias = false


integer i_cond

boolean reg_es_datos_fase=false
end variables

forward prototypes
public function boolean wf_comprueba_visado_mca ()
public function integer wf_actualizar_frontend (string id_fase)
public subroutine wf_reparte_cantidad_descuentos (integer ai_fila, double adb_cantidad, string as_t_iva, string paga_cliente)
protected function integer wf_actualizar_datos_plataforma ()
public function double wf_calcular_tarifa_articulo (string as_articulo)
end prototypes

event csd_importar_fase();st_control_eventos c_evento
// Modificado Ricardo 04-04-06
// Por orden de Paco, comenta que no deberia de dejarse importar un expediente que no sea en estado 00
if dw_1.GetItemString(1, 'estado') <>'00' then 
	Messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_importar_contrato_actual',"No puede importar un contrato en el estado actual. Debe estar en estado preasignado"), stopsign!)
	return
end if

string id_expediente, id_fase, sello, tipo, tipo_trabajo, trabajo, tipo_via_emplazamiento, destino_int, emplazamiento, titulo, n_calle, poblacion
string descripcion, tipo_gestion, modalidad, piso, puerta, autorizo, e_mail, cambio_arqui, t_iva, observaciones, archivo, celda, nr_duplicado, cobertura
string id_col, tipo_a, tipo_d, empresa, id_cliente, fase, des, tipo_fase, id_col_per, id_col_aso, id_fases_colegiados, renunciado, tipo_gest, observa
string otro_seguro, facturado, num_coac, contratista, promotor, pagador, cli_facturado, id_representante, reclamar_representante, id_propiedad
string c_geografico,situacion, id_empresa, tiene_src, src_cia, id_tramite, cod_colegio_dest
double porcen_a, porcen_d, i, porcen, cant, j, fila_insertada, porc_aut, porc_dir, coef_cm
double porcent
datetime f_visado_coac, f_entrada
datastore ds_fases_colegiados_asociados
long fila

if not i_nuevo then
	if messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_contrato_nuevo',"Puede que el contrato no sea nuevo, $$HEX1$$bf00$$ENDHEX$$Desea continuar con la importaci$$HEX1$$f300$$ENDHEX$$n?"), question!, yesno!) <> 1 then return
end if

st_fases_importacion_fase datos_importados

id_expediente = dw_1.GetItemString(1,'id_expedi')
id_fase = dw_1.GetItemString(1,'id_fase')


// Modificado David 25/01/2006 - Hay que borrar tambi$$HEX1$$e900$$ENDHEX$$n los asociados para que no d$$HEX2$$e9002000$$ENDHEX$$error y no queden en la BD
for i = idw_fases_colegiados_asociados.rowcount() to 1 step -1
	idw_fases_colegiados_asociados.deleterow(i)
next
for i = idw_fases_colegiados.rowcount() to 1 step -1
	idw_fases_colegiados.event pfc_deleterow()
next
for i = idw_fases_promotores.rowcount() to 1 step -1
	idw_fases_promotores.deleterow(i)
next
for i = idw_fases_informes.rowcount() to 1 step -1
	idw_fases_informes.deleterow(i)
next


SELECT count(*)  INTO :cant  FROM fases  WHERE fases.id_expedi = :id_expediente;

if cant=0 then return


//estructura   datos_importados.id_fase    = id de la fase de la que se va a importar
//					datos_importados.tipo_importacion = tipo de la importacion
//					datos_importados.num_fase	 = numero de la fase que se crea

//datos_importados = f_fase_datos_importacion(id_expediente)
st_fases_otras_fases st_otras_fases
st_otras_fases.id_expedi=id_expediente
st_otras_fases.id_fase=id_fase
datos_importados = f_fase_datos_importacion(st_otras_fases)

//Si hemos importado alguna fase
if datos_importados.id_fase<>'-1' then
	
	// Tomamos los datos de la fase de la que vamos a importar	 
	// SCP-1354. Se a$$HEX1$$f100$$ENDHEX$$aden tipo de tr$$HEX1$$e100$$ENDHEX$$mite y colegio destino
	SELECT fases.sello,fases.tipo_trabajo,fases.trabajo,fases.destino_int,
		fases.tipo_via_emplazamiento,fases.emplazamiento,fases.titulo,fases.n_calle, fases.piso, fases.puerta,
		fases.poblacion,fases.descripcion,fases.tipo_gestion,fases.modalidad,fases.autorizo,
		fases.e_mail,fases.cambio_arqui,fases.t_iva,fases.observaciones,fases.archivo,
		fases.celda,fases.nr_duplicado, fases.tipo_fase, fases.num_coac, fases.f_visado_coac, fases.f_entrada, fases.id_tramite, fases.cod_colegio_dest
	INTO :sello,:tipo_trabajo,:trabajo,:destino_int,:tipo_via_emplazamiento,:emplazamiento,:titulo,:n_calle, :piso, :puerta,
		:poblacion,:descripcion,:tipo_gestion,:modalidad,:autorizo,:e_mail,:cambio_arqui,
		:t_iva,:observaciones,:archivo,:celda,:nr_duplicado, :tipo_fase, :num_coac, :f_visado_coac, :f_entrada, :id_tramite, :cod_colegio_dest
	FROM fases  
	WHERE fases.id_fase = :datos_importados.id_fase;

	if(g_colegio = 'COAATTGN' or g_colegio='COAATTEB' or g_colegio = 'COAATLL') then
		int dias, n_celda
		dias = daysafter(date(f_entrada), today())
		if dias <> 0 then
			select celda into :celda from expedientes where id_expedi = :id_expediente ;
			n_celda = double(celda) + 1
			celda = string(n_celda, "00")
			dw_fases_datos_exp.setitem(1, 'celda_exp', celda)
		end if
		// CGN-294
		modalidad =  f_devuelve_centro(g_cod_delegacion)		
	end if

	//Insertamos los datos en el DW
	dw_1.SetItem(1,'tipo_fase',tipo_fase)
	dw_1.SetItem(1,'fase',datos_importados.num_fase)	
	dw_1.SetItem(1,'sello',sello)
	dw_1.SetItem(1,'tipo_trabajo',tipo_trabajo)
	dw_1.SetItem(1,'trabajo',trabajo)
	dw_1.SetItem(1,'destino_int',destino_int)	
	dw_1.SetItem(1,'tipo_via_emplazamiento',tipo_via_emplazamiento)
	dw_1.SetItem(1,'emplazamiento',emplazamiento)
	dw_1.SetItem(1,'titulo',titulo)
	dw_1.SetItem(1,'n_calle',n_calle)
	dw_1.SetItem(1,'piso',piso)
	dw_1.SetItem(1,'puerta',puerta)
	dw_1.SetItem(1,'poblacion',poblacion)
	dw_1.SetItem(1,'descripcion',datos_importados.descripcion)
	dw_1.SetItem(1,'tipo_gestion',tipo_gestion)
	dw_1.SetItem(1,'modalidad',modalidad)
	dw_1.SetItem(1,'autorizo',autorizo)
	dw_1.SetItem(1,'e_mail',e_mail)
	dw_1.SetItem(1,'cambio_arqui',cambio_arqui)
	dw_1.SetItem(1,'t_iva',t_iva)
	dw_1.SetItem(1,'observaciones',setnull(observaciones)) 
//	dw_1.SetItem(1,'archivo_fase',archivo) 
	dw_1.SetItem(1,'celda',celda)
	dw_1.SetItem(1,'nr_duplicado',nr_duplicado)
	dw_1.SetItem(1,'usuario',g_usuario)
	dw_1.setitem(1,'num_coac', num_coac)
	dw_1.setitem(1,'f_visado_coac', f_visado_coac)	
	// SCP-1354. Tipo tr$$HEX1$$e100$$ENDHEX$$mite y colegio destino
	dw_1.SetItem(1,'id_tramite',id_tramite)
	dw_1.SetItem(1,'cod_colegio_dest',cod_colegio_dest)
	
	//Obtenemos los datos de los colegiados pertenecientes a la fase importada
	datastore ds_coleg_fase
	ds_coleg_fase = create datastore
	ds_coleg_fase.dataobject = 'd_lista_colegiados_fase'
	ds_coleg_fase.settransobject(sqlca)
	ds_coleg_fase.Retrieve(datos_importados.id_fase)
	for i=1 to ds_coleg_fase.RowCount() //DW q nos da los datos de los Colegiados de esa fase
		id_col = ds_coleg_fase.GetItemString(i,'id_col')
		porcen_a = ds_coleg_fase.GetItemNumber(i,'porcen_a')
		porcen_d = ds_coleg_fase.GetItemNumber(i,'porcen_d')
		tipo_a	= ds_coleg_fase.GetItemString(i,'tipo_a')
		tipo_d 	= ds_coleg_fase.GetItemString(i,'tipo_d')
		empresa 	= ds_coleg_fase.GetItemString(i,'empresa')
		
		facturado = ds_coleg_fase.GetItemString(i,'facturado')
		renunciado = ds_coleg_fase.GetItemString(i,'renunciado')
		tipo_gest = ds_coleg_fase.GetItemString(i,'tipo_gestion')
		cobertura = ds_coleg_fase.GetItemString(i,'cobertura')
		otro_seguro = ds_coleg_fase.GetItemString(i,'otro_seguro')
		observa = ds_coleg_fase.GetItemString(i,'observa')
		porc_aut	= ds_coleg_fase.GetItemNumber(i,'porc_aut')
		porc_dir	= ds_coleg_fase.GetItemNumber(i,'porc_dir')
		coef_cm	= ds_coleg_fase.GetItemNumber(i,'coef_cm')
		c_geografico	= ds_coleg_fase.GetItemString(i,'c_geografico')		
		situacion	= ds_coleg_fase.GetItemString(i,'situacion')				
		id_empresa	= ds_coleg_fase.GetItemString(i,'id_empresa')
		tiene_src = ds_coleg_fase.GetItemString(i,'tiene_src')				
		src_cia = ds_coleg_fase.GetItemString(i,'src_cia')
		
		idw_fases_colegiados.event pfc_addrow()//InsertRow(0)
		idw_fases_colegiados.SetItem(idw_fases_colegiados.rowcount(),'id_fases_colegiados',f_siguiente_numero('ID_FASES_COLEGIADOS',10))
	//	idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'id_fase',id_fase)
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'id_col',id_col)
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'n_col',f_colegiado_n_col(id_col))
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'porcen_a',porcen_a)
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'porcen_d',porcen_d)
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'tipo_a',tipo_a)
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'tipo_d',tipo_d)	
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'empresa',empresa)
	//	idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'facturado','N')
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'facturado',facturado)
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'renunciado',renunciado)
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'tipo_gestion',tipo_gest)
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'cobertura',cobertura)
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'otro_seguro',otro_seguro)
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'observaciones',observa)
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'porc_aut',porc_aut)
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'porc_dir',porc_dir)
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'coef_cm',coef_cm)
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'c_geografico',c_geografico)
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'situacion',situacion)
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'id_empresa',id_empresa)	
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'tiene_src',tiene_src)
		idw_fases_colegiados.setitem(idw_fases_colegiados.rowcount(),'src_cia',src_cia)	

		// Si es sociedad, insertar los asociados
		if f_colegiado_tipopersona(id_col) = 'S' then
			idw_fases_colegiados_asociados.reset()
			// Obtenemos los datos de los asociados
			ds_fases_colegiados_asociados = create datastore						
			ds_fases_colegiados_asociados.dataobject = 'ds_fases_colegiados_asociados'
			ds_fases_colegiados_asociados.settransobject(sqlca)		
			
			SELECT fases_colegiados.id_fases_colegiados  
			INTO :id_fases_colegiados  
			FROM fases_colegiados  
			WHERE ( fases_colegiados.id_fase = :datos_importados.id_fase ) AND  ( fases_colegiados.id_col = :id_col )   ;	
			
			ds_fases_colegiados_asociados.retrieve( id_fases_colegiados)			
			for j=1 to ds_fases_colegiados_asociados.RowCount() //DW q nos da los datos de los Colegiados de esa fase
				id_fases_colegiados = idw_fases_colegiados.getitemstring(idw_fases_colegiados.rowcount(),'id_fases_colegiados')
				id_fase = idw_fases_colegiados.getitemstring(idw_fases_colegiados.rowcount(),'id_fase')
				id_col_aso = idw_fases_colegiados.getitemstring(idw_fases_colegiados.rowcount(),'id_col')
				id_col_per = ds_fases_colegiados_asociados.getitemstring(j, 'id_col_per')
				porcent = ds_fases_colegiados_asociados.getitemnumber(j, 'porcent')
				
				fila_insertada = idw_fases_colegiados_asociados.InsertRow(0)
				idw_fases_colegiados_asociados.setitem(fila_insertada,'id_fases_colegiados',id_fases_colegiados)
				idw_fases_colegiados_asociados.setitem(fila_insertada,'id_fase',id_fase)
				idw_fases_colegiados_asociados.setitem(fila_insertada,'id_col_aso',id_col_aso)	
				idw_fases_colegiados_asociados.setitem(fila_insertada,'id_col_per',id_col_per)
				idw_fases_colegiados_asociados.setitem(fila_insertada,'porcent',porcent)			
			next	
			idw_fases_colegiados_asociados.update()
			destroy ds_fases_colegiados_asociados
		end if
		
		c_evento.id_colegiado = id_col
		c_evento.evento = 'INCOMPATIBILIDAD'
		c_evento.dw = dw_1
		f_control_eventos(c_evento)
	next
	destroy ds_coleg_fase

	//Obtenemos los datos de los clientes de la fase
	datastore ds_cli_fase
	ds_cli_fase = create datastore
	ds_cli_fase.dataobject = 'd_lista_clientes_fase'
	ds_cli_fase.settransobject(sqlca)
	ds_cli_fase.Retrieve(datos_importados.id_fase)

	for i=1 to ds_cli_fase.RowCount()
		id_cliente = ds_cli_fase.GetItemString(i,'id_cliente')
		porcen     = ds_cli_fase.GetItemNumber(i,'porcen')
		contratista = ds_cli_fase.GetItemString(i,'contratista')
		promotor = ds_cli_fase.GetItemString(i,'promotor')
		pagador = ds_cli_fase.GetItemString(i,'pagador')
		cli_facturado = ds_cli_fase.GetItemString(i,'facturado')
		id_representante = ds_cli_fase.GetItemString(i,'id_representante')
		id_propiedad = ds_cli_fase.GetItemString(i,'id_propiedad')
		reclamar_representante = ds_cli_fase.GetItemString(i,'reclamar_representante')
		
		idw_fases_promotores.event pfc_addrow()//insertrow(0)
	//	idw_fases_promotores.setitem(idw_fases_promotores.rowcount(),'id_fase',id_fase)
		idw_fases_promotores.setitem(idw_fases_promotores.rowcount(),'id_cliente',id_cliente)
		idw_fases_promotores.setitem(idw_fases_promotores.rowcount(),'nif',f_dame_nif(id_cliente))
		idw_fases_promotores.setitem(idw_fases_promotores.rowcount(),'porcen',porcen)
		
		idw_fases_promotores.setitem(idw_fases_promotores.rowcount(),'contratista',contratista)
		idw_fases_promotores.setitem(idw_fases_promotores.rowcount(),'promotor',promotor)
		idw_fases_promotores.setitem(idw_fases_promotores.rowcount(),'pagador',pagador)
		idw_fases_promotores.setitem(idw_fases_promotores.rowcount(),'facturado',cli_facturado)
		idw_fases_promotores.setitem(idw_fases_promotores.rowcount(),'id_representante',id_representante)
		idw_fases_promotores.setitem(idw_fases_promotores.rowcount(),'reclamar_representante',reclamar_representante)
		idw_fases_promotores.setitem(idw_fases_promotores.rowcount(),'nif_representante',f_dame_nif(id_representante))
		idw_fases_promotores.setitem(idw_fases_promotores.rowcount(),'id_propiedad',id_propiedad)
		idw_fases_promotores.setitem(idw_fases_promotores.rowcount(),'nif_propiedad',f_dame_nif(id_propiedad))
	next
	destroy ds_cli_fase

	// Estadisticas -- David 12/11/2004 Versi$$HEX1$$f300$$ENDHEX$$n 3
	datastore ds_estadist
	ds_estadist = create datastore
	if g_colegio='COAATMCA' then
		ds_estadist.dataobject = 'd_fases_expedientes_estadistica_mca'
	else
		ds_estadist.dataobject = 'd_fases_expedientes_estadistica'
	end if
	ds_estadist.settransobject(sqlca)
	ds_estadist.Retrieve(datos_importados.id_fase)
	
	for i=1 to ds_estadist.rowcount()
		idw_fases_estadistica.SetItem(1,'num_viv',ds_estadist.GetItemNumber(1,'num_viv'))
		idw_fases_estadistica.SetItem(1,'sup_viv',ds_estadist.GetItemNumber(1,'sup_viv'))
		idw_fases_estadistica.SetItem(1,'sup_garage',ds_estadist.GetItemNumber(1,'sup_garage'))
		idw_fases_estadistica.SetItem(1,'sup_otros',ds_estadist.GetItemNumber(1,'sup_otros'))
		idw_fases_estadistica.SetItem(1,'sup_sob',ds_estadist.GetItemNumber(1,'sup_sob'))
		idw_fases_estadistica.SetItem(1,'sup_baj',ds_estadist.GetItemNumber(1,'sup_baj'))
		idw_fases_estadistica.SetItem(1,'plantas_sob',ds_estadist.GetItemNumber(1,'plantas_sob'))
		idw_fases_estadistica.SetItem(1,'plantas_baj',ds_estadist.GetItemNumber(1,'plantas_baj'))
		idw_fases_estadistica.SetItem(1,'pem',ds_estadist.GetItemNumber(1,'pem'))
		idw_fases_estadistica.SetItem(1,'volumen',ds_estadist.GetItemNumber(1,'volumen'))
		idw_fases_estadistica.SetItem(1,'altura',ds_estadist.GetItemNumber(1,'altura'))
		idw_fases_estadistica.SetItem(1,'num_edif',ds_estadist.GetItemNumber(1,'num_edif'))
		idw_fases_estadistica.SetItem(1,'longitud_per',ds_estadist.GetItemNumber(1,'longitud_per'))
		idw_fases_estadistica.SetItem(1,'volumen_tierras',ds_estadist.GetItemNumber(1,'volumen_tierras'))
		idw_fases_estadistica.SetItem(1,'valor_terreno',ds_estadist.GetItemNumber(1,'valor_terreno'))
		idw_fases_estadistica.SetItem(1,'valor_tasacion',ds_estadist.GetItemNumber(1,'valor_tasacion'))		
		idw_fases_estadistica.SetItem(1,'valoracion_estim',ds_estadist.GetItemNumber(1,'valoracion_estim'))
		idw_fases_estadistica.SetItem(1,'colindantes',ds_estadist.GetItemString(1,'colindantes'))
		idw_fases_estadistica.SetItem(1,'tipo_viv',ds_estadist.GetItemString(1,'tipo_viv'))
		idw_fases_estadistica.SetItem(1,'estudio_geo',ds_estadist.GetItemString(1,'estudio_geo'))
		idw_fases_estadistica.SetItem(1,'cc_externo',ds_estadist.GetItemString(1,'cc_externo'))	
		idw_fases_estadistica.SetItem(1,'niv_cont',ds_estadist.GetItemString(1,'niv_cont'))
		idw_fases_estadistica.SetItem(1,'uso',ds_estadist.GetItemString(1,'uso'))
		idw_fases_estadistica.SetItem(1,'estructura',ds_estadist.GetItemString(1,'estructura'))
		idw_fases_estadistica.SetItem(1,'t_terreno',ds_estadist.GetItemString(1,'t_terreno'))
		idw_fases_estadistica.SetItem(1,'t_medicion',ds_estadist.GetItemString(1,'t_medicion'))
		idw_fases_estadistica.SetItem(1,'replan_deslin',ds_estadist.GetItemString(1,'replan_deslin'))	
		idw_fases_estadistica.SetItem(1,'ctrl_calidad_interno',ds_estadist.GetItemString(1,'ctrl_calidad_interno'))
		idw_fases_estadistica.SetItem(1,'t_promotor',ds_estadist.GetItemString(1,'t_promotor'))
		idw_fases_estadistica.SetItem(1,'colindantes2m',ds_estadist.GetItemString(1,'colindantes2m'))
		if lower(idw_fases_estadistica.describe("tipo_reforma.name")) = 'tipo_reforma' then 
			idw_fases_estadistica.SetItem(1,'tipo_reforma',ds_estadist.GetItemString(1,'tipo_reforma'))	
		end if
		if g_colegio='COAATMCA' then idw_fases_estadistica.SetItem(1,'pres_seguridad',ds_estadist.GetItemNumber(1,'pres_seguridad'))
	next
	destroy ds_estadist
	
	if g_colegio='COAATMCA' then // ESTADISTICAS MALLORCA
	
		datastore ds_estadist_otros
		ds_estadist_otros = create datastore
		ds_estadist_otros.dataobject = 'd_fases_expedientes_estadistica_cc_mca'
		ds_estadist_otros.settransobject(sqlca)
		ds_estadist_otros.Retrieve(datos_importados.id_fase)	
		
		if ds_estadist_otros.rowcount()>0 then
			idw_fases_estadistica_otros.setitem(1,'tipologia',ds_estadist_otros.GetItemString(1,'tipologia'))
			idw_fases_estadistica_otros.setitem(1,'cc_hormigon',ds_estadist_otros.GetItemString(1,'cc_hormigon'))
			idw_fases_estadistica_otros.setitem(1,'cc_hormigon_tipo',ds_estadist_otros.GetItemString(1,'cc_hormigon_tipo'))
			idw_fases_estadistica_otros.setitem(1,'cc_acero',ds_estadist_otros.GetItemString(1,'cc_acero'))
			idw_fases_estadistica_otros.setitem(1,'cc_acero_tipo',ds_estadist_otros.GetItemString(1,'cc_acero_tipo'))			  
			idw_fases_estadistica_otros.setitem(1,'cc_forjados',ds_estadist_otros.GetItemString(1,'cc_forjados'))
			idw_fases_estadistica_otros.setitem(1,'cc_muro_carga',ds_estadist_otros.GetItemString(1,'cc_muro_carga'))			  			  
			idw_fases_estadistica_otros.setitem(1,'cc_cubiertas',ds_estadist_otros.GetItemString(1,'cc_cubiertas'))			  
			idw_fases_estadistica_otros.setitem(1,'sup_parcela',ds_estadist_otros.GetItemNumber(1,'sup_parcela'))			  			  		  
		else
			fila=idw_fases_estadistica_otros.insertrow(0)
			idw_fases_estadistica_otros.SetItem(fila,'id_fase',id_fase)
			idw_fases_estadistica_otros.SetItem(fila,'id_fases_estadisticas',f_siguiente_numero('FASES_ESTAD_OTROS',10))	
		end if
	end if
	
	//Obtenemos los datos de otros t$$HEX1$$e900$$ENDHEX$$cnicos que participen en la obra (pesta$$HEX1$$f100$$ENDHEX$$a Arquitectos)
	if g_colegio = 'COAATTEB' then
		
		datastore ds_otros_tecnicos
		ds_otros_tecnicos = create datastore
		ds_otros_tecnicos.dataobject = 'd_fases_arquitectos'
		ds_otros_tecnicos.SetTransObject(sqlca)
		ds_otros_tecnicos.Retrieve(datos_importados.id_fase)
		
		for i=1 to ds_otros_tecnicos.rowcount()
			fila=idw_fases_arquitectos.insertrow(0)
			idw_fases_arquitectos.setitem(fila,'id_fase',dw_1.GetItemString(i,'id_fase'))
			idw_fases_arquitectos.setitem(fila,'ID_FASES_ARQUITECTOS',f_siguiente_numero('ID_FASES_ARQUITECTOS',10))
			idw_fases_arquitectos.setitem(fila,'id_arqui',ds_otros_tecnicos.GetItemString(i,'id_arqui'))
			idw_fases_arquitectos.setitem(fila,'apellidos',ds_otros_tecnicos.GetItemString(i,'apellidos'))
			idw_fases_arquitectos.setitem(fila,'nombre',ds_otros_tecnicos.GetItemString(i,'nombre'))
			idw_fases_arquitectos.setitem(fila,'tipo_a',ds_otros_tecnicos.GetItemString(i,'tipo_a'))
			idw_fases_arquitectos.setitem(fila,'tipo_d',ds_otros_tecnicos.GetItemString(i,'tipo_d'))			  
			idw_fases_arquitectos.setitem(fila,'titulacion',ds_otros_tecnicos.GetItemString(i,'titulacion'))		  			  		  
		next
		
		destroy ds_otros_tecnicos
		
	end if
		
	// Datos Econ$$HEX1$$f300$$ENDHEX$$micos del Contrato
	dw_1.setitem(1,'honorarios',datos_importados.honorarios)
	
	// Para que configure en el momento el check y bot$$HEX1$$f300$$ENDHEX$$n de musaat por certificaciones
	dw_1.event csd_marcar_certificaciones()
	
	this.PostEvent('csd_control_estados')
	this.event pfc_save()
	// Para que calcule par$$HEX1$$e100$$ENDHEX$$metros y descuentos
	if g_colegio <> 'COAATTFE' and g_colegio <> 'COAATZ' and g_colegio <> 'COAATGU' and g_colegio <> 'COAATLE' and g_colegio <> 'COAATAVI'  and g_colegio <> 'COAATTER' then
		if messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_calcular_dtos_col','$$HEX1$$bf00$$ENDHEX$$Desea calcular los descuentos colegiales y de seguro ahora?'), Question!, YesNo!) = 1 then
			//SCP-1043. Se detecta en las pruebas que se debe de llamar al c$$HEX1$$e100$$ENDHEX$$lculo nuevo de gastos
			//tab_1.tabpage_5.pb_calcular_dtos.event clicked()
			tab_1.tabpage_5.pb_calcular_dtos_nuevo.event clicked()
		end if
	end if

	if g_colegio = 'COAATTFE' OR g_colegio = 'COAATLE' OR g_colegio = 'COAATTGN' or g_colegio ='COAATMCA' or g_colegio = 'COAATLL' then
		// Modificado Ricardo 04-04-06
		// Tenemos que copiar los arquitectos
		datastore ds_fases_arquitectos
		ds_fases_arquitectos = create datastore
		ds_fases_arquitectos.dataobject = 'd_fases_arquitectos'
		ds_fases_arquitectos.settransobject(SQLCA)
		ds_fases_arquitectos.retrieve(datos_importados.id_fase)
		
		long fila_insert
		FOR fila = 1 to ds_fases_arquitectos.rowCount()
			// Para cada una de las filas copiamos todos los datos que sabemos del arquitecto a excepcion de los idenfitifadores
			fila_insert = idw_fases_arquitectos.trigger event pfc_addrow()
			idw_fases_arquitectos.setitem(fila_insert, 'id_arqui', ds_fases_arquitectos.GetItemString(fila, 'id_arqui'))
			idw_fases_arquitectos.setitem(fila_insert, 'apellidos', ds_fases_arquitectos.GetItemString(fila, 'apellidos'))
			idw_fases_arquitectos.setitem(fila_insert, 'nombre', ds_fases_arquitectos.GetItemString(fila, 'nombre'))
			idw_fases_arquitectos.setitem(fila_insert, 'tipo_a', ds_fases_arquitectos.GetItemString(fila, 'tipo_a'))
			idw_fases_arquitectos.setitem(fila_insert, 'tipo_d', ds_fases_arquitectos.GetItemString(fila, 'tipo_d'))
		NEXT
		// Destruimos el datastore
		destroy ds_fases_arquitectos
		// FIN Modificado Ricardo 04-04-06
	end if
end if
string modificacion
long fila_mod
// Se actualiza la dw de modificaciones oculta
fila_mod =idw_fases_modificacion_datos.rowcount()
//idw_fases_modificacion_datos.update()

if fila_mod>0 then
	modificacion=idw_fases_modificacion_datos.getitemstring(fila_mod,'modificacion')
	 modificacion = modificacion +  ' Importaci$$HEX1$$f300$$ENDHEX$$n de contrato. '
else
 modificacion ='Importaci$$HEX1$$f300$$ENDHEX$$n de contrato'
end if


idw_fases_modificacion_datos.setitem(fila_mod,'id_colegiado',id_fase)
idw_fases_modificacion_datos.setitem(fila_mod,'modificacion',modificacion)
idw_fases_modificacion_datos.setitem(fila_mod,'fecha',datetime(today(),now()))
idw_fases_modificacion_datos.setitem(fila_mod,'usuario',g_usuario)

//g_recien_grabado_modificacion_fases=FALSE

c_evento.id_colegiado = ''
c_evento.evento = 'POST_IMPORTAR'
c_evento.dw = dw_1
f_control_eventos(c_evento)

end event

event csd_control_estados();string estado
string p_facturar,p_visar,p_desvisar,p_importar,permitir_cambios 
boolean facturar=false,visar=false,desvisar=false,importar=false
if dw_1.RowCount()=0 then return

dw_1.AcceptText()

estado = dw_1.GetItemString(dw_1.GetRow(),'estado')

select p_facturar,p_visar,p_desvisar,p_importar,permitir_cambios 
into :p_facturar,:p_visar,:p_desvisar,:p_importar,:permitir_cambios
from expedientes_estado
where cod_estado = :estado;
	
if p_facturar 	= 'S' then facturar=true
if p_visar 		= 'S' then visar =true
if p_desvisar	= 'S' then desvisar=true
if p_importar 	= 'S' then importar=true

m_detalle_fases.m_file.m_importar.enabled= importar
m_detalle_fases.m_file.m_visar.enabled= visar
m_detalle_fases.m_file.m_des-visar.enabled= desvisar
m_detalle_fases.m_file.m_avisodecobros.enabled= facturar
m_detalle_fases.m_file.m_informaci$$HEX1$$f300$$ENDHEX$$nimportes.enabled= facturar

//Si tiene activo el permiso de cambios se habilitaran los dw si no se deshabilitar$$HEX1$$e100$$ENDHEX$$n...
if permitir_cambios = 'S' then
	this.TriggerEvent('csd_habilitar_dw')
//	dw_1.SetTabOrder('f_visado',241)
//	dw_1.SetTabOrder('estado',242)
//	dw_1.SetTabOrder('f_abono',243)
else
	this.TriggerEvent('csd_deshabilitar_dw')
	dw_1.SetTabOrder('f_visado',0)
	dw_1.SetTabOrder('estado',0)
	dw_1.SetTabOrder('f_abono',0)
end if

// PARA NO MODIFICAR EL N$$HEX1$$ba00$$ENDHEX$$DE VISADO SI NO SE ES ADMINISTRADOR
if g_colegio='COAATMCA' then
	dw_1.Object.archivo_fase.edit.displayonly=true
end if

//Si el usuario es especial, se habilita edici$$HEX1$$f300$$ENDHEX$$n de estados, las dw quedan habilitadas,etc.
long cuantos
select count(*) into :cuantos from t_permisos where cod_usuario = :g_usuario and cod_aplicacion = 'E';
if cuantos = 0 then return

this.TriggerEvent('csd_habilitar_dw')

//dw_1.SetTabOrder('f_visado',241)
//dw_1.SetTabOrder('estado',242)
//dw_1.SetTabOrder('f_abono',243)

if estado>='03' and g_colegio='COAATCC' then
	 idw_fases_cip_tfe.enabled=false
else
	 idw_fases_cip_tfe.enabled=true
end if
//Cambio omnibus scp-603
//if g_colegio='COAATMCA' then
	dw_1.Object.archivo_fase.edit.displayonly=false
//end if


end event

event csd_visar();boolean subsanado= true,visar=true,reparos=false
double i,hon,por_col,j,t,por_cli,total_minuta,pem_min,pem
datetime fecha
string col,cli,estado,n_visado,numerar, ls_id_fase
st_control_eventos c_evento

// Salvamos el visado
	this.post event pfc_save()		

ls_id_fase = dw_1.GetItemString(dw_1.GetRow(),'id_fase')
	
if g_colegio = 'COAATCC' then
	st_gestor_doc lst_gestor_doc
	string tarifa
	tarifa =  idw_fases_cip_tfe.getitemstring(1, 'tarifa')

	if f_es_vacio(tarifa) then
		return
	else
		// Comprobamos el PEM
		pem_min = idw_fases_cip_tfe.GetItemNumber(idw_fases_cip_tfe.getRow(),'pem_min')
		pem =  idw_fases_estadistica.GetItemNumber( idw_fases_estadistica.GetRow(),'pem')
		if  pem_min<>0 and pem < pem_min then
			MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","El PEM no alcanza el m$$HEX1$$ed00$$ENDHEX$$nimo")
		end if

		// Abrimos la ventana del gestor documental
		lst_gestor_doc.tarifa = tarifa
		lst_gestor_doc.legalizacion = idw_fases_cip_tfe.getitemstring(1, 'legalizacion')
		lst_gestor_doc.id_fase = ls_id_fase
		openwithparm(w_gestor_documental_cc, lst_gestor_doc)
		n_visado=Message.StringParm
		
		if f_es_vacio(n_visado) then
	
			if g_vb_simple="S" then//por ley omnibus dejamos dar visto bueno sin dar num de salida ni fecha(por fonfig de db)
				//Si se puede visar, abriremos la ventana de fecha de Visado
				if visar then	
					Openwithparm(w_fases_visado,ls_id_fase)
					idw_fases_informes.retrieve(ls_id_fase)
				end if		
				
				fecha=datetime(date(LeftA(message.stringparm,10)))
				numerar=LeftA(RightA(message.stringparm,2),1)
				estado=RightA(message.stringparm,1)
	
				if estado="2" then
					c_evento.evento = 'VISAR'
					c_evento.dw = dw_1
					if f_control_eventos(c_evento)=-1 then return
					this.TriggerEvent('csd_control_estados')
				end if
				if numerar="V" then					
					c_evento.evento = 'NUMERO_SAL'
					f_control_eventos(c_evento)
					dw_1.setitem(1,'archivo_fase',f_numera_salida(c_evento.param1))	
				end if
				
			else
				return
			end if		
			
			// Salvamos el visado
			this.post event pfc_save()	
			
		else
			if n_visado = '-1' then
				//Visado cancelado. 
				return
			else
				//Ya tengo n$$HEX2$$ba002000$$ENDHEX$$de visado, no hago nada
			end if
		end if
		idw_fases_reparos_nuevos.retrieve(ls_id_fase)
		return
	end if
end if

// Debe tener el permiso correspondiente
CHOOSE CASE g_colegio
	CASE 'COAATGC'
		string permiso
		select permiso into :permiso from t_permisos where cod_usuario=:g_usuario and cod_aplicacion='GCVISADO00' and permiso='E';
		if isnull(permiso) or permiso='' then 
			Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_no_permisos_accion',"No Tiene Permiso Para Realizar Esta Acci$$HEX1$$f300$$ENDHEX$$n"), StopSign!)
			return
		end if
END CHOOSE

this.TriggerEvent('pfc_preupdate')
if i_pasa_preupdate=-1 then return

// Se informa de que existen reparos pero se deja visar
if g_visar_con_reparos='N' then
	for i=1 to idw_fases_reparos.rowcount()
		if isnull(idw_fases_reparos.getitemdatetime(i,'f_subsanacion')) then reparos=true
	next 
end if
if reparos then messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_contrato_reparos_subsa','Este contrato tiene reparos no subsanados'))

// Si existe alg$$HEX1$$fa00$$ENDHEX$$n reparo no subsanado no se subsana al visar sino que se avisar$$HEX2$$e1002000$$ENDHEX$$de que existe y no se visa
if not(subsanado) then 
	MessageBox(g_titulo, g_idioma.of_getmsg('fases.msg_contrato_reparos_subsa_exis','Debe subsanar los reparos existentes antes de visar.'), Exclamation!)
	visar=false
end if


if g_vb_simple="S" then//por ley omnibus dejamos dar visto bueno sin dar num de salida ni fecha(por fonfig de db)
//Si se puede visar, abriremos la ventana de fecha de Visado
	if visar then	
		Openwithparm(w_fases_visado,ls_id_fase)
		idw_fases_informes.retrieve(ls_id_fase)
	end if		
	fecha=datetime(date(LeftA(message.stringparm,10)))
	numerar=LeftA(RightA(message.stringparm,2),1)
	estado=RightA(message.stringparm,1)

	if estado="2" then	
		c_evento.evento = 'VISAR'
		c_evento.dw = dw_1
		if f_control_eventos(c_evento)=-1 then return
		this.TriggerEvent('csd_control_estados')
	end if
	if numerar="V" then
		if (f_es_vacio(dw_1.getitemstring(1,'archivo_fase'))) then
			c_evento.evento = 'NUMERO_SAL'
			f_control_eventos(c_evento)
			dw_1.setitem(1,'archivo_fase',f_numera_salida(c_evento.param1))	
		else
			
		end if
	end if
else
	return
end if

f_crear_movimientos_tarifa_D(ls_id_fase)

idw_fases_src.retrieve(ls_id_fase)

// Salvamos el visado
this.post event pfc_save()

end event

event csd_deshabilitar_dw();//Esto deshabilita todos los datawindow excepto minutas

idw_fases_datos_exp.enabled=false
dw_1.enabled=false
idw_fases_promotores.enabled=false
idw_fases_colegiados.enabled=false
idw_fases_colegiados_asociados.enabled=false
idw_fases_estadistica.enabled=false
idw_fases_informes.enabled=false
idw_fases_src.enabled=false
//idw_fases_minutas.enabled=false
idw_fases_reparos.enabled=false
idw_fases_documentos.enabled=false
idw_fases_reclamaciones.enabled=false
idw_fases_estados.enabled=false
idw_fases_otras_fases.enabled=false
idw_fases_registros.enabled=false
idw_fases_finales_obra.enabled=false
idw_fases_arquitectos.enabled=false
idw_fases_garantias.enabled=false
tab_1.tabpage_8.pb_recalcular.enabled = false

end event

event csd_habilitar_dw();//Esto habilita todos los datawindow 

idw_fases_datos_exp.enabled=true
dw_1.enabled=true
idw_fases_promotores.enabled=true
idw_fases_colegiados.enabled=true
idw_fases_colegiados_asociados.enabled=true
idw_fases_estadistica.enabled=true
idw_fases_informes.enabled=true
idw_fases_src.enabled=true
idw_fases_minutas.enabled=true
idw_fases_reparos.enabled=true
idw_fases_documentos.enabled=true
idw_fases_reclamaciones.enabled=true
idw_fases_estados.enabled=true
idw_fases_otras_fases.enabled=true
idw_fases_registros.enabled=true
idw_fases_finales_obra.enabled=true
idw_fases_arquitectos.enabled=true
idw_fases_garantias.enabled=true
tab_1.tabpage_8.pb_recalcular.enabled = true

end event

event csd_desvisar();datetime fecha
string mensaje,estado,id_fase
double i

estado = dw_1.GetItemString(1,'estado')

//If estado=g_fases_estados.visado or estado=g_fases_estados.verificado then
If estado=g_fases_estados.verificado then
	id_fase = dw_1.getitemstring(1,'id_fase')
//	idw_fases_estados.insertrow(1)
//	dw_1.setitem(1,'estado',g_fases_estados.registrado)
//	idw_fases_estados.setitem(1,'id_fase',id_fase)
//	idw_fases_estados.setitem(1,'estado',g_fases_estados.registrado) 
//	idw_fases_estados.setitem(1,'fecha',datetime(today()))
//	idw_fases_estados.setitem(1,'usuario',g_usuario)		
	
	setnull(fecha)
	dw_1.setitem(1,'f_visado',fecha)	
		
	//Borramos todas las retenciones pertenecientes a la fase...
	for i=1 to idw_fases_minutas.RowCount()
		idw_fases_minutas.SetItem(i,'irpf','')
		idw_fases_minutas.SetItem(i,'importe_irpf','')
	next
		
	st_control_eventos c_evento
	c_evento.evento = 'DESVISAR'
	c_evento.dw = dw_1
	if f_control_eventos(c_evento)=-1 then return
	
//	dw_1.event csd_cambio_estado()
	
	this.TriggerEvent('csd_control_estados')
		
	// Salvamos el visado
	this.post event pfc_save()		
else
	MessageBox(g_titulo,g_idioma.of_getmsg('fases.msg_estado_operacion_visar','El estado del contrato NO permite la operaci$$HEX1$$f300$$ENDHEX$$n de Desvisar.'))
end if

end event

event csd_rellenar_campos_ocultos_expediente;//Este evento t carga los datos de la fase al Expediente, por tanto el Exped. guardar$$HEX1$$e100$$ENDHEX$$
//los datos de la $$HEX1$$fa00$$ENDHEX$$ltima fase creada...

idw_fases_datos_exp.SetItem(1,'titulo',dw_1.GetItemString(1,'titulo'))
idw_fases_datos_exp.SetItem(1,'tipo_trabajo',dw_1.GetItemString(1,'tipo_trabajo'))
idw_fases_datos_exp.SetItem(1,'trabajo',dw_1.GetItemString(1,'trabajo'))
idw_fases_datos_exp.SetItem(1,'tipo_via_emplazamiento',dw_1.GetItemString(1,'tipo_via_emplazamiento'))
idw_fases_datos_exp.SetItem(1,'emplazamiento',dw_1.GetItemString(1,'emplazamiento'))
idw_fases_datos_exp.SetItem(1,'poblacion',dw_1.GetItemString(1,'poblacion'))
end event

event csd_refrescar_avisos;string id_fase
id_fase = dw_1.getitemstring(1, 'id_fase')
idw_fases_minutas.retrieve(id_fase)
end event

event csd_refrescar_src;string id_fase
id_fase = dw_1.getitemstring(1, 'id_fase')
idw_fases_src.retrieve(id_fase)
end event

event csd_cobrar_anticipo_musaat(boolean generar, boolean facturar);string id_minuta, id_fase, id_col, id_cli, n_aviso, pagador, t_iva, t_iva_honos, t_iva_desplaza, t_iva_dv, t_iva_cip
string tipo_movimiento_csd, pendiente='N', facturado='S', id_cliente_mayor_porc
double porc_iva, base_musaat, total_cliente, total_colegiado, irpf, porc_iva_honos, porc_iva_desplaza, porc_iva_dv
double porc_iva_cip, musaat, pem_certificacion, porc_col=0, porc_col_real=0, suma_porc=0, porc_cli_mayor=0, base_otros=0
datetime fecha, fecha_pago, fecha_nula
int i, j
st_musaat_datos st_musaat_datos
st_csi_articulos_servicios ist_datos_dv, ist_datos_cip


ist_datos_dv.codigo = g_codigos_conceptos.dv
f_csi_articulos_servicios(ist_datos_dv)

ist_datos_cip.codigo = g_codigos_conceptos.cip
f_csi_articulos_servicios(ist_datos_cip)

setnull(fecha_nula)
if not generar then return

// Coger el promotor de mayor %
for i = 1 to idw_fases_promotores.rowcount()
	if idw_fases_promotores.getitemnumber(i, 'porcen') > porc_cli_mayor then
		id_cliente_mayor_porc = idw_fases_promotores.getitemstring(i, 'id_cliente')
	end if
next

// Colegiados
for i = 1 to idw_fases_colegiados.rowcount()
	// Si el colegiado es funcionario no debe cobrar anticipo musaat
	if idw_fases_colegiados.getitemstring(i, 'facturado') = 'S' then continue
	
//	if not f_tiene_musaat_src(idw_fases_colegiados.getitemstring(i, 'id_col')) then continue
	suma_porc = 0
	
	id_fase =  dw_1.getitemstring(1, 'id_fase')
	st_musaat_datos.n_visado = id_fase
	st_musaat_datos.tipo_act = dw_1.getitemstring(1, 'fase')
	st_musaat_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_trabajo')
	st_musaat_datos.pem = idw_fases_estadistica.getitemnumber(1, 'pem')
	st_musaat_datos.administracion = idw_fases_datos_exp.getitemstring(1, 'administracion')
	st_musaat_datos.superficie = idw_fases_estadistica.getitemnumber(1, 'superficie')
	st_musaat_datos.volumen = idw_fases_estadistica.getitemnumber(1, 'volumen')
	st_musaat_datos.recuperar = false
	st_musaat_datos.genera_movi = FALSE
	st_musaat_datos.cobertura = 0
	// cobro del 10%
	st_musaat_datos.anticipo_10 = TRUE
	// Tipo de movimiento csd = t_visado + obra_oficial : en este caso '11'
	tipo_movimiento_csd = '11'
	st_musaat_datos.tipo_csd = tipo_movimiento_csd 
	// Suma de los % de los colegiados
	for j = 1 to idw_fases_colegiados.rowcount()
		suma_porc =  suma_porc + idw_fases_colegiados.getitemnumber(j, 'porcen_a')		
	next
	porc_col =  idw_fases_colegiados.getitemnumber(i, 'porcen_a')	
	if isnull(suma_porc) or suma_porc = 0 then exit
	porc_col_real = porc_col / suma_porc * 100	
	st_musaat_datos.porcentaje = porc_col_real
	id_col = idw_fases_colegiados.getitemstring(i, 'id_col')
	st_musaat_datos.id_col = id_col
	
	if f_colegiado_tipopersona(id_col) = 'S' then	
		f_musaat_calcula_prima_sociedad(st_musaat_datos)
		musaat = st_musaat_datos.prima_comp	
	else
		f_musaat_calcula_prima(st_musaat_datos)	
		musaat = st_musaat_datos.prima_comp		
	end if
		
	if isnull(musaat) then musaat = 0
	if musaat > 0 then
		id_minuta = f_siguiente_numero('FASES-MINUTAS',10)
		n_aviso = f_numera_aviso(true) // Modificado Ricardo 2005-05-12
		irpf = g_irpf_por_defecto
		fecha = datetime(today(), now())
		fecha_pago = fecha_nula //datetime(today(), now())
		pagador = '1'
		t_iva = g_t_iva_defecto
		porc_iva =  f_dame_porcent_iva(g_t_iva_defecto)
		base_musaat = musaat
		total_cliente = 0
		total_colegiado = musaat
		t_iva_honos = '00'
		t_iva_desplaza = '00'  
		t_iva_dv = ist_datos_dv.t_iva
		t_iva_cip = ist_datos_cip.t_iva
		porc_iva_honos = 0   
		porc_iva_desplaza = 0   
		porc_iva_dv = f_dame_porcent_iva(ist_datos_dv.t_iva)
		porc_iva_cip = f_dame_porcent_iva(ist_datos_cip.t_iva)	
		pendiente = 'S'
		facturado = 'N'
		// Paco 26/08/2005: por defecto la minuta esta pendiente y sin fecha de pago.
		//		if not facturar then
		//			fecha_pago = fecha_nula
		//			pendiente = 'S'
		//			facturado = 'N'			
		//		end if

		// Modificado Ricardo 2005-06-14
		// El presupuesto de certificacion es el 10% del total
		pem_certificacion = st_musaat_datos.pem * 10 / 100
		
		// Calculamos la bonificaci$$HEX1$$f300$$ENDHEX$$n de musaat (s$$HEX1$$f300$$ENDHEX$$lo colegiados residentes)
		if g_colegio = 'COAATLE' and LeftA(f_colegiado_residente(id_col),1) = 'R' then
			base_otros = f_redondea(base_musaat*g_porc_bonif_musaat*(-1))
		end if		
		
		INSERT INTO fases_minutas  
			( id_minuta, id_fase, id_colegiado, id_cliente, cantidad, pendiente, facturado, id_honorario, f_facturado, 
			id_factura, tipo_minuta, irpf, importe_irpf, n_aviso, fecha, fecha_pago, tipo_gestion, pagador, reclamar, 
			t_iva, porc_iva, forma_pago, aplica_honos, porc_honos, concepto_honos, base_honos, iva_honos, aplica_desplaza,
			base_desplaza, iva_desplaza, concepto_desplaza, aplica_dv, base_dv, iva_dv, aplica_cip, base_cip, iva_cip,
			aplica_musaat, base_musaat, iva_musaat, aplica_retvol, porc_retvol, base_retvol, iva_retvol, total_cliente,   
			total_colegiado, t_iva_honos, t_iva_desplaza, t_iva_dv, t_iva_cip, porc_iva_honos, porc_iva_desplaza, 
			porc_iva_dv, porc_iva_cip, anulada, banco, irpf_cliente, observaciones, base_garantia, total_aviso, 
			aplica_impresos, base_impresos, iva_impresos, porc_musaat, paga_asalariado, paga_externo, paga_dv, 
			pem_certificacion, t_minuta, urgente, base_cip_suplida, t_iva_cip_suplida, porc_iva_cip_suplida, 
			iva_cip_suplida, musaat_suplida, base_otros)
		VALUES 
			( :id_minuta, :id_fase, :id_col, :id_cliente_mayor_porc, 0, :pendiente, :facturado, null, null,
			null, :tipo_movimiento_csd, :irpf, 0, :n_aviso, :fecha, :fecha_pago, 'S', :pagador, 'S', 
			:t_iva, :porc_iva, null, 'N', 0, null, 0, 0, 'N',
			0, 0, null,  'N', 0, 0, 'N', 0, 0, 
			'S', :base_musaat, 0, 'N', 0, 0, 0, :total_cliente, 
			:total_colegiado, :t_iva_honos, :t_iva_desplaza, :t_iva_dv, :t_iva_cip, :porc_iva_honos, :porc_iva_desplaza,
			:porc_iva_dv, :porc_iva_cip, 'N', null, 'N', null, 0, :total_colegiado,
			'N', 0, 0, 10, 'N', 'N', 'P', 
			:pem_certificacion, 'I', 'N', 0, '00', 0, 
			0, 0, :base_otros)  ;
					
		COMMIT;

		if facturar then
			// Para no regularizar fuerzo el cobro obligado de MUSAAT, como la minuta lleva grabado el tipo se prrodra eliminar
			// Paco 26/08/2005 Quito los g_cobro_obligado pues no tienen ning$$HEX1$$fa00$$ENDHEX$$n efecto aqu$$HEX1$$ed00$$ENDHEX$$.
//				g_cobro_obligado = 'S'
			openwithparm(w_caja_pagos, id_minuta)
//				g_cobro_obligado = 'N'
		end if
	end if	
next

if isvalid(g_detalle_fases) then
	g_detalle_fases.postevent('csd_refrescar_avisos')
	g_detalle_fases.postevent('csd_refrescar_src')	
end if

end event

event csd_desglose_honos();string t_act

t_act = dw_1.getitemstring(1, 'fase')

if LeftA(t_act, 1) = '0' or t_act = '11' then
	dw_1.object.b_desglose.visible = true
else
	dw_1.object.b_desglose.visible = false
end if

end event

event csd_importar_fase_visared();st_control_eventos c_evento
int i, j, fila_asociado
string id_fase,colegiado,n_expedi,n_registro,n_expedi_visared_importado,n_registro_visared_importado, ref_catastral
string nombre,id_col, cod, des

if g_fase_visared.opcion_importacion <> 'S' then return

if g_datos_fase.opcion_importacion  = 'I' then
	dw_1.SetItemStatus ( 1, 0, Primary!, Datamodified!)
	return
end if

//idw_fases_promotores.DeleteRow(1)
//idw_fases_colegiados.DeleteRow(1)
 
id_fase = dw_1.GetItemString(1,'id_fase')
 
//Importamos los datos Generales de la fase
colegiado= g_fase_visared.ds_detalle_fase.GetItemString(1,'colegiado')
n_expedi= g_fase_visared.ds_detalle_fase.GetItemString(1,'n_expedi')
n_registro= g_fase_visared.ds_detalle_fase.GetItemString(1,'n_registro')
ref_catastral= g_fase_visared.ds_detalle_fase.GetItemString(1,'ref_catastral')

if not f_es_vacio(ref_catastral)  then  idw_fases_datos_exp.SetItem(idw_fases_datos_exp.getrow(),'r_catastral',ref_catastral)

//Concatenamos el num_colegiado y el num_expedi
n_expedi_visared_importado=colegiado+'-'+n_expedi
//Concatenamos el num_colegiado y el num_registro
n_registro_visared_importado=colegiado+'-'+n_registro
 
dw_1.SetItem(1,'n_expedi_visared',n_expedi_visared_importado)
dw_1.SetItem(1,'n_registro_visared',n_registro_visared_importado)
dw_1.SetItem(1,'n_consejo_fase',g_fase_visared.ds_detalle_fase.GetItemString(1,'n_consejo_fase'))
dw_1.SetItem(1,'fase',g_fase_visared.ds_detalle_fase.GetItemString(1,'tipo_actuacion'))
dw_1.SetItem(1,'tipo_trabajo',g_fase_visared.ds_detalle_fase.GetItemString(1,'tipo_obra'))
dw_1.SetItem(1,'trabajo',g_fase_visared.ds_detalle_fase.GetItemString(1,'destino'))
dw_1.SetItem(1,'destino_int',g_fase_visared.ds_detalle_fase.GetItemString(1,'destino_int'))
dw_1.SetItem(1,'descripcion',g_fase_visared.ds_detalle_fase.GetItemString(1,'titulo'))
dw_1.SetItem(1,'emplazamiento',g_fase_visared.ds_detalle_fase.GetItemString(1,'emplazamiento'))
dw_1.SetItem(1,'tipo_via_emplazamiento',g_fase_visared.ds_detalle_fase.GetItemString(1,'tipo_via_emplazamiento'))
dw_1.SetItem(1,'n_calle',g_fase_visared.ds_detalle_fase.GetItemString(1,'n_calle'))
dw_1.SetItem(1,'piso',g_fase_visared.ds_detalle_fase.GetItemString(1,'piso'))
dw_1.SetItem(1,'puerta',g_fase_visared.ds_detalle_fase.GetItemString(1,'puerta'))
dw_1.SetItem(1,'escalera',g_fase_visared.ds_detalle_fase.GetItemString(1,'escalera'))
dw_1.SetItem(1,'poblacion',g_fase_visared.ds_detalle_fase.GetItemString(1,'poblacion'))
dw_1.setItem(1,'tipo_gestion',g_fase_visared.ds_detalle_fase.GetItemString(1,'gestion_de_cobro'))
dw_1.setItem(1,'observaciones',g_fase_visared.ds_detalle_fase.GetItemString(1,'observaciones'))
dw_1.setItem(1,'mantenimiento',g_fase_visared.ds_detalle_fase.GetItemString(1,'mantenimiento'))
dw_1.setItem(1,'f_mantenimiento',g_fase_visared.ds_detalle_fase.GetItemDateTime(1,'f_mantenimiento'))
dw_1.setItem(1,'id_tramite',g_fase_visared.ds_detalle_fase.GetItemString(1,'tipo_tramite'))

long fila
dw_otros_datos.reset()
dw_otros_datos.SetTransObject(SQLCA)
fila=dw_otros_datos.insertrow(0)
dw_otros_datos.SetItem(fila,'id_fase',id_fase)
dw_otros_datos.SetItem(fila,'id_referencia_web',g_fase_visared.ds_detalle_fase.GetItemString(1,'id_referencia_web'))


// EL CAMPO n_visado NO SE TIENE QUE IMPORTAR
//dw_1.setItem(1,'archivo_fase',g_fase_visared.ds_detalle_fase.GetItemString(1,'n_visado'))

if right(g_fase_visared.fichero_importacion,11)='barcode.ini' then
	dw_1.setitem(1,'e_mail','S')
	dw_1.SetItem(1,'modalidad',g_cod_delegacion)
else
	dw_1.setitem(1,'e_mail','V')
	if g_colegio = 'COAATA' or g_colegio = 'COAATCC' then// 	 ICC-375 En caceres se pone como centro al cual esta abscrito el contrato aquel que lo procesa
		dw_1.SetItem(1,'modalidad',g_cod_delegacion)
	else
		dw_1.SetItem(1,'modalidad',g_fase_visared.ds_detalle_fase.GetItemString(1,'delegacion'))
	end if	
end if

dw_1.SetItem(1,'honorarios',g_fase_visared.ds_detalle_fase.GetItemnumber(1,'honorarios'))


string id_colegiados_asociados,c_geo,situacion

// Importaci$$HEX1$$f300$$ENDHEX$$n de colegiados
// SCP-424
for i=idw_fases_colegiados.rowcount() to 1 step -1
	idw_fases_colegiados.deleterow(i)
next
//fin  	 SCP-424
for i= 1 to g_fase_visared.ds_colegiados.rowcount()
	id_col=f_colegiado_id_col(g_fase_visared.ds_colegiados.GetItemString(i,'numero'))
	select c_geografico,situacion into :c_geo,:situacion from colegiados where id_colegiado=:id_col;
	tab_1.tabpage_2.dw_fases_colegiados.insertrow(0)
	tab_1.tabpage_2.dw_fases_colegiados.SetItem(i,'id_fase',id_fase)
	tab_1.tabpage_2.dw_fases_colegiados.SetItem(i,'id_col',id_col)
	tab_1.tabpage_2.dw_fases_colegiados.SetItem(i,'situacion',situacion)	
	tab_1.tabpage_2.dw_fases_colegiados.SetItem(i,'c_geografico',c_geo)		
	tab_1.tabpage_2.dw_fases_colegiados.SetItem(i,'n_col',g_fase_visared.ds_colegiados.GetItemString(i,'numero'))
	tab_1.tabpage_2.dw_fases_colegiados.SetItem(i,'porcen_a',g_fase_visared.ds_colegiados.GetItemNumber(i,'porcentaje'))
	tab_1.tabpage_2.dw_fases_colegiados.SetItem(i,'tipo_a',g_fase_visared.ds_colegiados.GetItemString(i,'autor'))
	tab_1.tabpage_2.dw_fases_colegiados.SetItem(i,'tipo_d',g_fase_visared.ds_colegiados.GetItemString(i,'director'))
	tab_1.tabpage_2.dw_fases_colegiados.SetItem(i,'tipo_gestion',g_fase_visared.ds_detalle_fase.GetItemString(1,'gestion_de_cobro'))
	tab_1.tabpage_2.dw_fases_colegiados.SetItem(i,'facturado',g_fase_visared.ds_colegiados.GetItemString(i,'funcionario'))
	tab_1.tabpage_2.dw_fases_colegiados.SetItem(i,'tiene_src', f_colegiado_tiene_src(id_col))
	tab_1.tabpage_2.dw_fases_colegiados.SetItem(i,'src_cia',f_colegiado_src_cia(id_col))
	
	id_colegiados_asociados = f_siguiente_numero('ID_FASES_COLEGIADOS',10)
	tab_1.tabpage_2.dw_fases_colegiados.SetItem(i,'id_fases_colegiados', id_colegiados_asociados)
	
	// Importaci$$HEX1$$f300$$ENDHEX$$n de asociados
	for j= 1 to g_fase_visared.ds_asociados.rowcount()
		if g_fase_visared.ds_asociados.GetItemString(j,'sociedad') <> g_fase_visared.ds_colegiados.GetItemString(i,'numero') then continue
		fila_asociado = tab_1.tabpage_2.dw_fases_colegiados_asociados.insertrow(0)
		tab_1.tabpage_2.dw_fases_colegiados_asociados.SetItem(fila_asociado,'id_fase',id_fase)
		tab_1.tabpage_2.dw_fases_colegiados_asociados.SetItem(fila_asociado,'id_col_per',f_colegiado_id_col(g_fase_visared.ds_asociados.GetItemString(j,'numero')))
		tab_1.tabpage_2.dw_fases_colegiados_asociados.SetItem(fila_asociado,'id_col_aso',f_colegiado_id_col(g_fase_visared.ds_asociados.GetItemString(j,'sociedad')))
		tab_1.tabpage_2.dw_fases_colegiados_asociados.SetItem(fila_asociado,'porcent',g_fase_visared.ds_asociados.GetItemNumber(j,'porcentaje'))
		tab_1.tabpage_2.dw_fases_colegiados_asociados.SetItem(fila_asociado,'id_fases_colegiados',id_colegiados_asociados)
	next	

	c_evento.id_colegiado = id_col
	c_evento.evento = 'INCOMPATIBILIDAD'
	c_evento.dw = dw_1
	f_control_eventos(c_evento)
	
next
 
// Importacion de Clientes
// 	 SCP-424
for i=idw_fases_promotores.rowcount() to 1 step -1
	idw_fases_promotores.deleterow(i)
next
// fin  	 SCP-424
for i= 1 to g_fase_visared.ds_clientes.rowcount()
	tab_1.tabpage_1.dw_fases_promotores.insertrow(0)
	tab_1.tabpage_1.dw_fases_promotores.SetItem(i,'id_fase',id_fase)
	tab_1.tabpage_1.dw_fases_promotores.SetItem(i,'id_cliente',f_cliente_id_cliente(g_fase_visared.ds_clientes.GetItemString(i,'nif')))
	tab_1.tabpage_1.dw_fases_promotores.SetItem(i,'nif',g_fase_visared.ds_clientes.GetItemString(i,'nif'))
	tab_1.tabpage_1.dw_fases_promotores.SetItem(i,'porcen',g_fase_visared.ds_clientes.GetItemNumber(i,'participacion'))
	tab_1.tabpage_1.dw_fases_promotores.SetItem(i,'promotor',g_fase_visared.ds_clientes.GetItemString(i,'promotor'))
	tab_1.tabpage_1.dw_fases_promotores.SetItem(i,'contratista',g_fase_visared.ds_clientes.GetItemString(i,'contratista'))
	tab_1.tabpage_1.dw_fases_promotores.SetItem(i,'pagador',g_fase_visared.ds_clientes.GetItemString(i,'pagador'))
	// Importaci$$HEX1$$f300$$ENDHEX$$n del representante
	if not f_es_vacio(g_fase_visared.ds_clientes.GetItemString(i,'nif_representante')) then	
		tab_1.tabpage_1.dw_fases_promotores.SetItem(i,'id_representante',f_cliente_id_cliente(g_fase_visared.ds_clientes.GetItemString(i,'nif_representante')))
		tab_1.tabpage_1.dw_fases_promotores.SetItem(i,'nif_representante',g_fase_visared.ds_clientes.GetItemString(i,'nif_representante'))
	end if
next
 
//Importamos arquitectos
for i= 1 to g_fase_visared.ds_arquitectos.rowcount()
	tab_1.tabpage_16.dw_arquitectos.insertrow(0)
	tab_1.tabpage_16.dw_arquitectos.SetItem(i,'id_fase',id_fase)
	tab_1.tabpage_16.dw_arquitectos.SetItem(i,'id_fases_arquitectos',f_siguiente_numero('ID_FASES_ARQUITECTOS',10))
	tab_1.tabpage_16.dw_arquitectos.SetItem(i,'id_arqui',g_fase_visared.ds_arquitectos.GetItemString(i,'numero'))
	tab_1.tabpage_16.dw_arquitectos.SetItem(i,'nombre',g_fase_visared.ds_arquitectos.GetItemString(i,'nombre')) 
	tab_1.tabpage_16.dw_arquitectos.SetItem(i,'apellidos',g_fase_visared.ds_arquitectos.GetItemString(i,'apellidos'))
	tab_1.tabpage_16.dw_arquitectos.SetItem(i,'tipo_a',g_fase_visared.ds_arquitectos.GetItemString(i,'autor'))
	tab_1.tabpage_16.dw_arquitectos.SetItem(i,'tipo_d',g_fase_visared.ds_arquitectos.GetItemString(i,'director'))  
	des = g_fase_visared.ds_arquitectos.getItemString(i,'titulacion')
	Select codigo into :cod from titulaciones where descripcion = :des; 
	if not f_es_vacio(cod) and not isNull(cod) then
		tab_1.tabpage_16.dw_arquitectos.SetItem(i,'titulacion',cod)
	end if
next

//Importamos Gastos
for i=1 to g_fase_visared.ds_gastos.rowcount()
	tab_1.tabpage_8.dw_fases_informes.insertrow(0)
	tab_1.tabpage_8.dw_fases_informes.SetItem(i,'id_informe',f_siguiente_numero('ID_FASES_INFORMES',10))	
	tab_1.tabpage_8.dw_fases_informes.SetItem(i,'id_fase', id_fase)	
	tab_1.tabpage_8.dw_fases_informes.setitem(i,'tipo_informe',g_fase_visared.ds_gastos.getitemString(i,'tipo_informe'))
	tab_1.tabpage_8.dw_fases_informes.setitem(i,'t_iva',g_fase_visared.ds_gastos.getitemString(i,'t_iva'))
	tab_1.tabpage_8.dw_fases_informes.setitem(i,'cuantia_colegiado',g_fase_visared.ds_gastos.getitemnumber(i,'cuantia_colegiado'))
	tab_1.tabpage_8.dw_fases_informes.setitem(i,'impuesto_colegiado',g_fase_visared.ds_gastos.getitemnumber(i,'impuesto_colegiado'))
	tab_1.tabpage_8.dw_fases_informes.setitem(i,'descripcion',g_fase_visared.ds_gastos.getitemString(i,'descripcion'))
next 

choose case g_datos_fase.opcion_importacion
	case 'E', 'F'
		//Importamos datos expediente
		dw_fases_datos_exp.SetItem(1,'administracion',g_fase_visared.ds_detalle_fase.GetItemString(1,'administracion'))

		//  dw_fases_datos_exp.SetItem(1,'pem',g_fase_visared.ds_detalle_fase.GetItemNumber(1,'pem'))
		dw_fases_datos_exp.SetItem(1,'cerrado',g_fase_visared.ds_detalle_fase.GetItemString(1,'cerrado'))
		//Importamos estadisticas
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'tipo_viv',g_fase_visared.ds_detalle_fase.GetItemString(1,'tipo_viv'))
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'estudio_geo',g_fase_visared.ds_detalle_fase.GetItemString(1,'estudio_geo'))
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'uso',g_fase_visared.ds_detalle_fase.GetItemString(1,'uso'))
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'cc_externo',g_fase_visared.ds_detalle_fase.GetItemString(1,'cc_externo'))
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'niv_cont',g_fase_visared.ds_detalle_fase.GetItemString(1,'niv_cont'))
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'colindantes',g_fase_visared.ds_detalle_fase.GetItemString(1,'colindantes'))
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'colindantes2m',g_fase_visared.ds_detalle_fase.GetItemString(1,'colindantes2m'))
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'pem',g_fase_visared.ds_detalle_fase.GetItemNumber(1,'pem'))
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'num_viv',g_fase_visared.ds_detalle_fase.GetItemNumber(1,'num_viv'))
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'n_viv_vpo',g_fase_visared.ds_detalle_fase.GetItemNumber(1,'n_viv_vpo'))
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'num_edif',g_fase_visared.ds_detalle_fase.GetItemNumber(1,'num_edif'))
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'sup_viv',g_fase_visared.ds_detalle_fase.GetItemNumber(1,'sup_viv'))
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'sup_garage',g_fase_visared.ds_detalle_fase.GetItemNumber(1,'sup_garaje'))
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'sup_otros',g_fase_visared.ds_detalle_fase.GetItemNumber(1,'sup_otros'))
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'volumen',g_fase_visared.ds_detalle_fase.GetItemNumber(1,'volumen'))
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'altura',g_fase_visared.ds_detalle_fase.GetItemNumber(1,'altura'))
		
		if lower(tab_1.tabpage_5.dw_fases_estadistica.describe("pres_seguridad.name")) = 'pres_seguridad' then tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'pres_seguridad',g_fase_visared.ds_detalle_fase.GetItemNumber(1,'pres_seguridad'))
		
	  	if g_colegio='COAATMCA' then // ESTADISTICAS MALLORCA
		//  	tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'pres_seguridad',g_fase_visared.ds_detalle_fase.GetItemNumber(1,'pres_seguridad'))			  			  		  
		  	tab_1.tabpage_5.dw_fases_estadistica_otros.setitem(1,'tipologia',g_fase_visared.ds_detalle_fase.GetItemString(1,'tipologia_edif'))
		  	tab_1.tabpage_5.dw_fases_estadistica_otros.setitem(1,'cc_hormigon',g_fase_visared.ds_detalle_fase.GetItemString(1,'cc_hormigon'))
		  	tab_1.tabpage_5.dw_fases_estadistica_otros.setitem(1,'cc_hormigon_tipo',g_fase_visared.ds_detalle_fase.GetItemString(1,'cc_hormigon_tipo'))
		  	tab_1.tabpage_5.dw_fases_estadistica_otros.setitem(1,'cc_acero',g_fase_visared.ds_detalle_fase.GetItemString(1,'cc_acero'))
		  	tab_1.tabpage_5.dw_fases_estadistica_otros.setitem(1,'cc_acero_tipo',g_fase_visared.ds_detalle_fase.GetItemString(1,'cc_acero_tipo'))			  
		  	tab_1.tabpage_5.dw_fases_estadistica_otros.setitem(1,'cc_forjados',g_fase_visared.ds_detalle_fase.GetItemString(1,'cc_forjados'))
		  	tab_1.tabpage_5.dw_fases_estadistica_otros.setitem(1,'cc_muro_carga',g_fase_visared.ds_detalle_fase.GetItemString(1,'cc_muros'))			  			  
		  	tab_1.tabpage_5.dw_fases_estadistica_otros.setitem(1,'cc_cubiertas',g_fase_visared.ds_detalle_fase.GetItemString(1,'cc_cubiertas'))			  
		  	tab_1.tabpage_5.dw_fases_estadistica_otros.setitem(1,'sup_parcela',g_fase_visared.ds_detalle_fase.GetItemNumber(1,'sup_parcela'))			  			  		  
	  		tab_1.tabpage_5.dw_fases_estadistica_otros.setitem(1,'n_visado_pe',g_fase_visared.ds_detalle_fase.GetItemString(1,'n_visado_pe'))		
			tab_1.tabpage_5.dw_fases_estadistica_otros.setitem(1,'n_visado_pb',g_fase_visared.ds_detalle_fase.GetItemString(1,'n_visado_pb'))		
			tab_1.tabpage_5.dw_fases_estadistica_otros.setitem(1,'f_visado_pe',g_fase_visared.ds_detalle_fase.GetItemDateTime(1,'f_visado_pe'))
			tab_1.tabpage_5.dw_fases_estadistica_otros.setitem(1,'f_visado_pb', g_fase_visared.ds_detalle_fase.GetItemDateTime(1,'f_visado_pb'))
			 
				  
		end if
		//Recorremos los promotores para ver cual es el de mayor participacion
		double part
		string nif, letra
		part = 0
		for i = 1 to g_fase_visared.ds_clientes.rowcount()
		if g_fase_visared.ds_clientes.GetItemString(i,'promotor') = 'S' then
			if g_fase_visared.ds_clientes.GetItemNumber(i,'participacion') >= part then
				part = g_fase_visared.ds_clientes.GetItemNumber(i,'participacion')
				nif = g_fase_visared.ds_clientes.GetItemString(i,'nif')
			end if
		end if
	  next
		//Extraemos la letra del nif
		letra = LeftA(nif,1)
		if (letra = 'A' or letra = 'B' or letra = 'C' or letra = 'D' or letra = 'E' or letra = 'F' or &
		letra = 'H' or letra = 'S' or letra = 'P' or letra = 'G' or letra = 'Q') and isnumber(MidA(nif,2,1)) then
			tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'t_promotor',letra)
		else
			letra = 'X'		
			tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'t_promotor',letra)
	  	end if
		  
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'plantas_sob',g_fase_visared.ds_detalle_fase.GetItemNumber(1,'plantas_sob'))
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'plantas_baj',g_fase_visared.ds_detalle_fase.GetItemNumber(1,'plantas_baj'))
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'sup_sob',g_fase_visared.ds_detalle_fase.GetItemNumber(1,'sup_sob'))  
		tab_1.tabpage_5.dw_fases_estadistica.setitem(1,'sup_baj',g_fase_visared.ds_detalle_fase.GetItemNumber(1,'sup_baj'))  
end choose


// FEW-91 -  Marcamos el check de MUSAAT por certificaciones si es tipo 01 o 03
dw_1.event csd_marcar_certificaciones()
if g_fase_visared.ds_detalle_fase.GetItemString(1,'tipo_obra_oficial')='01' or g_fase_visared.ds_detalle_fase.GetItemString(1,'tipo_obra_oficial')='03' then
	dw_1.SetItem(1,'aplicado_10','S')
else
	dw_1.SetItem(1,'aplicado_10','N')
end if


//Ondevio-32
// Se a$$HEX1$$f100$$ENDHEX$$ade importaci$$HEX1$$f300$$ENDHEX$$n de datos relacionados con los pagos en la plataforma.
for i=1 to g_fase_visared.ds_fases_pagos_plataforma.rowcount()
	tab_1.tabpage_18.dw_fases_pagos_plataforma.insertrow(0)
	tab_1.tabpage_18.dw_fases_pagos_plataforma.SetItem(i,'id_fase', id_fase)	
	tab_1.tabpage_18.dw_fases_pagos_plataforma.SetItem(i,'forma_pago_plataforma',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'forma_pago_plataforma'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'conciliado','N')
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'pasarela',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'pasarela'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'banco',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'banco'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'terminal',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'terminal'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'codigo_comercio',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'codigo_comercio'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'nombre_comercio',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'nombre_comercio'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'numero_pedido',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'numero_pedido'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'divisa_nombre',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'divisa_nombre'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'divisa_codigo',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'divisa_codigo'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'tipo_transaccion',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'tipo_transaccion'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'n_colegiado',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'n_colegiado'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'nombre_comercio',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'nombre_comercio'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'importe_tpv',g_fase_visared.ds_fases_pagos_plataforma.getitemnumber(i,'importe_tpv'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'importe_pago',g_fase_visared.ds_fases_pagos_plataforma.getitemnumber(i,'importe_pago'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'base_imponible',g_fase_visared.ds_fases_pagos_plataforma.getitemnumber(i,'base_imponible'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'t_iva',g_fase_visared.ds_fases_pagos_plataforma.getitemstring(i,'t_iva'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'importe_iva',g_fase_visared.ds_fases_pagos_plataforma.getitemnumber(i,'importe_iva'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'codigo_autorizacion',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'codigo_autorizacion'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'pago_seguro',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'pago_seguro'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'estado',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'estado'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'detalles_codigo',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'detalles_codigo'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'detalles_titulo',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'detalles_titulo'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'detalles_descripcion',g_fase_visared.ds_fases_pagos_plataforma.getitemString(i,'detalles_descripcion'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'fecha',g_fase_visared.ds_fases_pagos_plataforma.getitemdatetime(i,'fecha'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'fecha_importacion',g_fase_visared.ds_fases_pagos_plataforma.getitemdatetime(i,'fecha_importacion'))
	tab_1.tabpage_18.dw_fases_pagos_plataforma.setitem(i,'fecha_orden',g_fase_visared.ds_fases_pagos_plataforma.getitemdatetime(i,'fecha_orden'))
next 


c_evento.id_colegiado = ''
c_evento.evento = 'IMPORTAR_VISARED'
c_evento.dw = dw_1
if f_control_eventos(c_evento)=-1 then return

end event

event csd_visared_preupdate(string id_fase);//	//Si se ha grabado con exito y el fichero se ha importado con visared hay que modificar el nombre del zip
//	// para que no vuelva a importarse.
long i
n_cst_filesrvwin32 dire

dire = create n_cst_filesrvwin32


// Incidencia 3269. Si la fase no tiene la casilla de visared marcada salimos. A$$HEX1$$f100$$ENDHEX$$adimos esta validaci$$HEX1$$f300$$ENDHEX$$n adicional.
if dw_1.getitemstring(1,'e_mail') <> 'V' then return


if g_fase_visared.opcion_importacion <>'N' then
	if right(g_fase_visared.paquete_importacion,11)='barcode.ini' then
		dire.of_deltree(g_directorio_temporal)
		dire.of_CreateDirectory(g_directorio_temporal)		
		g_fase_visared.opcion_importacion = 'N'
		return
	end if
	
	string nif, nombre, apellidos, nombre_via, telefono, fax, id_cliente, id_cliente_tercero, id_pob, id_prov, cod_prov, cod_pais
	
	string fichero_orig,fichero_dst

	// Mover paquete al directorio de importados
	//f_visared_mover_paquete_importado(g_fase_visared.paquete_importacion)
	f_bloqueo_fichero(g_fase_visared.paquete_importacion,false)
	f_eimporta_mover_paquete_importado(g_fase_visared.paquete_importacion)
	
	//Comprobamos si existe la carpeta del a$$HEX1$$f100$$ENDHEX$$o. Si no hay que crearla...
	if not dire.of_directoryexists(g_directorio_documentos_visared + g_anyo_numeracion ) then
		dire.of_createdirectory(g_directorio_documentos_visared + g_anyo_numeracion )
	end if


	//	 Grabar en fases_documentos_visared
	datastore ds_documentos_visared
	ds_documentos_visared = create datastore
	ds_documentos_visared.dataobject = 'd_fases_documentos_visared'
	ds_documentos_visared.SetTransObject(SQLCA)
	if not isnull(g_fase_visared.ds_documentos_visared) then
		g_fase_visared.ds_documentos_visared.RowsCopy(1,g_fase_visared.ds_documentos_visared.rowcount(),Primary!,ds_documentos_visared,10,Primary!)
		for i= 1 to ds_documentos_visared.rowcount()
			ds_documentos_visared.SetItem(i,'id_fase',id_fase)
			ds_documentos_visared.SetItem(i,'ruta_fichero',f_visared_ruta_documentos(id_fase,'',2))
			ds_documentos_visared.setitem(i,'visualizar_web','N')	
		next
		ds_documentos_visared.Update()
		// Copiar ficheros PDF		
		// Crear directorio del registro si no existe	
		dire.of_createdirectory(f_visared_ruta_documentos(id_fase,'',1))
		// copiar ficheros
		for i= 1 to ds_documentos_visared.rowcount()
			fichero_orig = g_directorio_temporal + ds_documentos_visared.getitemstring(i, 'nombre_fichero')
			fichero_dst = f_visared_ruta_documentos(id_fase,ds_documentos_visared.getitemstring(i, 'nombre_fichero'),0)
			dire.of_filecopy(fichero_orig, fichero_dst)
		next
		
	end if

	
	// Destruimos los datastores
	destroy g_fase_visared.ds_detalle_fase
	destroy g_fase_visared.ds_colegiados
	destroy g_fase_visared.ds_clientes
	destroy g_fase_visared.ds_asociados
	destroy g_fase_visared.ds_arquitectos
	destroy g_fase_visared.ds_documentos_visared
	destroy ds_documentos_visared			
	
	// Borramos el directorio temporal
	dire.of_deltree(g_directorio_temporal)
	dire.of_CreateDirectory(g_directorio_temporal)
	destroy dire	
	g_fase_visared.opcion_importacion = 'N'
end if

end event

event type integer csd_postupdate();// Ver si tiene MUSAAT el Contrato
long fila_musaat
string retorno_10 = 'SS', generar_10 = 'S', facturar_10 = 'S'
boolean bl_generar_10 = true, bl_facturar_10 = true
int i
string t_visado, obra_oficial

fila_musaat = idw_fases_informes.Find("tipo_informe = '" + g_codigos_conceptos.musaat_variable + "'",0,idw_fases_informes.RowCount())
if fila_musaat <= 0 Then 
//	Messagebox(g_titulo, 'No est$$HEX2$$e1002000$$ENDHEX$$calculado el descuento de MUSAAT')		
	g_recien_grabado_modificacion_fases=TRUE
	return 1
end if
// Se debe comprobar antes si existe un movimiento de musaat de tipo 1.1
for i = 1 to idw_fases_src.rowcount()
	t_visado = idw_fases_src.getitemstring(i, 't_visado')
	obra_oficial = idw_fases_src.getitemstring(i, 'obra_oficial')	
	if t_visado = '1' and obra_oficial = '1' then
		bl_generar_10 = false
	end if
next

// ----  Si no hay movimiento inicial y se cobra por certificaciones y se cobra el 10% al inicio entonces....
if dw_1.getitemstring(1, 'aplicado_10') = 'S' and bl_generar_10 and g_obra_admin_cgc_aplica_10 = 'S'  then
	open(w_musaat_10)
	retorno_10 = message.stringparm
	generar_10 = LeftA(retorno_10, 1)
	facturar_10 = RightA(retorno_10, 1)
	bl_generar_10 = (generar_10 = 'S')
	bl_facturar_10 = (facturar_10 = 'S')	
//		if Messagebox(g_titulo, 'Esta obra es Oficial, $$HEX1$$bf00$$ENDHEX$$Desea Emitir la factura del 10% anticipado a MUSAAT?', Question!, YesNo!) = 1 then
	this.event csd_cobrar_anticipo_musaat(bl_generar_10, bl_facturar_10)
	
	// Si no se genera el mov del 10% se quita el check de musaat por certificaciones para que cobre el 100%
	if generar_10 = 'N' then dw_1.setitem(1, 'aplicado_10', 'N')
	dw_1.update()
	
//		end if
end if

g_recien_grabado_modificacion_fases=TRUE
i_nuevo = FALSE
return 1

end event

event type string csd_configura_datos_est();string tipo_act, tipo_obra, destino, cod_comb, campo, mens = '', mens2 = '', tipo
int i, col

dw_1.accepttext()

tipo_act = dw_1.getitemstring(1,'fase')
tipo_obra = dw_1.getitemstring(1,'tipo_trabajo')
destino = dw_1.getitemstring(1,'trabajo')

if not f_es_vacio(tipo_act) and not f_es_vacio(tipo_obra) and not f_es_vacio(destino) then
	// Seleccionamos la combinacion de campos seg$$HEX1$$fa00$$ENDHEX$$n el tipo act, el tipo obra y el destino
	SELECT configura_insercion.cod_comb
	INTO :cod_comb
	FROM configura_insercion
	WHERE ( :tipo_act like configura_insercion.tipo_act or configura_insercion.tipo_act = '%' ) and
			( :tipo_obra like configura_insercion.tipo_obra or configura_insercion.tipo_obra = '%' ) and
			( :destino like configura_insercion.destino or configura_insercion.destino = '%' )  ;

	datastore ds_conf
	ds_conf = create datastore						
	ds_conf.dataobject = 'ds_configura_campos'
	ds_conf.settransobject(sqlca)		
	ds_conf.retrieve(cod_comb)
	
	if ds_conf.rowcount()<1 then return ''
	
	// Recorremos todas las columnas de la tabla
	col = integer(ds_conf.Object.DataWindow.Column.Count)
	for i = 1 to col
		campo = ds_conf.Describe("#"+string(i)+".Name")
		// Si para la columna el valor es 'A' se avisa que deber$$HEX1$$ed00$$ENDHEX$$a introducir un valor en dicho campo
		if ds_conf.getitemstring(1, campo) = 'A' then
			tipo = idw_fases_estadistica.Describe(campo+".ColType")
			CHOOSE CASE upper(LeftA(tipo ,2))
				CASE 'CH' 
					if f_es_vacio(idw_fases_estadistica.getitemstring(1, campo)) then 
						if mens <> '' then mens += ', ' + campo
						if mens = '' then mens = campo
					end if
				CASE ELSE
					if f_es_vacio(string(idw_fases_estadistica.getitemnumber(1, campo))) or idw_fases_estadistica.getitemnumber(1, campo) = 0 then
						if mens <> '' then mens += ', ' + campo
						if mens = '' then mens = campo						
					end if
			END CHOOSE
		end if
		// Si para la columna el valor es 'O' se obliga a introducir un valor en dicho campo
		if ds_conf.getitemstring(1, campo) = 'O' then
			tipo = idw_fases_estadistica.Describe(campo+".ColType")
			CHOOSE CASE upper(LeftA(tipo ,2))
				CASE 'CH' 
					if f_es_vacio(idw_fases_estadistica.getitemstring(1, campo)) then mens2 += g_idioma.of_getmsg('fases.msg_valor_campo','Debe especificar un valor en el campo ') + campo + g_idioma.of_getmsg('fases.msg_ficha_estadistica',' en la ficha de Estad$$HEX1$$ed00$$ENDHEX$$stica.') + cr
				CASE ELSE
					if f_es_vacio(string(idw_fases_estadistica.getitemnumber(1, campo))) or idw_fases_estadistica.getitemnumber(1, campo) = 0 then mens2 +=  g_idioma.of_getmsg('fases.msg_valor_campo','Debe especificar un valor en el campo ') + campo + g_idioma.of_getmsg('fases.msg_ficha_estadistica',' en la ficha de Estad$$HEX1$$ed00$$ENDHEX$$stica.') + cr
			END CHOOSE
		end if
	next
	destroy ds_conf
end if

// Mostramos el mensaje de aviso
if mens <> '' then messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_ficha_estadistica_comp',"Deber$$HEX1$$ed00$$ENDHEX$$a rellenar el/los siguiente/s campo/s en la ficha de Estad$$HEX1$$ed00$$ENDHEX$$stica: ") + cr + mens, information!)

// Devolvemos al preupdate el mensaje
if mens2 <>'' then 
	return mens2
else
	return ''
end if

end event

event csd_facturar();// SCP-647 Alta Evento
integer retorno
st_control_eventos c_evento
string param
int li_contador
boolean lb_hay_inactivos



// Diferenciamos Factura/Proforma
param = Message.StringParm

retorno = this.event closequery()
if retorno = 1 then return

// 29/10/10 Se desactiva el control existente del tipo de gesti$$HEX1$$f300$$ENDHEX$$n (comprueba si debe haber honorarios, y si los hay)
//if dw_1.Event csd_control_gestion_cobro() < 0 then return

/* SCP-647 En SICAP el campo modalidad aloja otros datos. P.ej. BD sicap_mallorca, las sedes.
c_evento.evento = 'PRE_FACTURAR'
//Enviamos el par$$HEX1$$e100$$ENDHEX$$metro modalidad por si est$$HEX2$$e1002000$$ENDHEX$$en Asesor$$HEX1$$ed00$$ENDHEX$$a Jur$$HEX1$$ed00$$ENDHEX$$dica
c_evento.param1 = 'modalidad'
c_evento.param2 = dw_1.GetItemString(1,'modalidad')
c_evento.dw = dw_1
f_control_eventos(c_evento)*/
// SCP-647 Diferenciamos Factura/Proforma 
//dw_1.TriggerEvent('csd_facturar')

///***SCP-1055. Alexis. 02/03/2011. Antes de env$$HEX1$$ed00$$ENDHEX$$ar a facturar se avisa de que hay art$$HEX1$$ed00$$ENDHEX$$culos sin facturar no activos. ***///
lb_hay_inactivos = false
for li_contador = 1 to idw_fases_informes.rowcount()
	if ((idw_fases_informes.getitemstring(li_contador,'facturado') = 'N') and f_articulo_activo(idw_fases_informes.getitemstring(li_contador,'tipo_informe'), '%') = false)  then
		lb_hay_inactivos = true
	end if	
	
next

if lb_hay_inactivos = true then
	messagebox(g_titulo, "Se dispone a facturar algunos articulos inactivos", Exclamation!, OK!)
end if

///*** Se recoge el valor de vuelta para ver si actualizamos los checks de facturado. ***///
retorno = dw_1.Trigger Event csd_facturar(param)


//Actualizamos los valores de fases_informes
// Se verifica si se ha pagado todo, para setear al campo facturado = 'S'

if retorno = 1 then

	double total_fact, total_articulo
	long i
	
	for i= 1 to idw_fases_informes.rowcount()
		
		 if idw_fases_informes.getitemstring(i, 'facturado') = 'S' then continue
		 
		 if idw_fases_informes.getitemnumber(i, 'cuantia_colegiado')= 0 and idw_fases_informes.getitemnumber(i, 'cuantia_cliente') = 0 then continue
		 
		 total_fact = f_total_facturado_concepto(dw_1.getitemstring(1,'id_fase'), idw_fases_informes.getitemstring(i,'tipo_informe'), '%', '%', '%')
			total_articulo = idw_fases_informes.getitemnumber(i, 'cuantia_colegiado') +idw_fases_informes.getitemnumber(i, 'cuantia_cliente')
		 
		 if total_articulo = total_fact then idw_fases_informes.setitem(i,'facturado','S')
		 
		 idw_fases_informes.update()
	next
end if

end event

public function boolean wf_comprueba_visado_mca ();string id_expedi, t_act, archivo, id_fase2, id_fase, n_visado
datetime f_visado

id_expedi=dw_1.GetItemString(dw_1.GetRow(),'id_expedi')			
t_act=dw_1.GetItemString(dw_1.GetRow(),'fase')
f_visado=dw_1.GetItemDateTime(dw_1.GetRow(),'f_visado')
n_visado = dw_1.GetItemString(dw_1.GetRow(),'archivo_fase')

//if left(t_act,1)='1' then
//	select archivo,id_fase into :archivo,:id_fase2 from fases 
//	where id_expedi=:id_expedi and id_fase<>:id_fase and fase like '0%'  order by f_visado desc;				
//	texto="coordinaci$$HEX1$$f300$$ENDHEX$$n"
//end if
if left(t_act,1)='0' then
	select archivo,id_fase into :archivo,:id_fase2 from fases 
	where id_expedi=:id_expedi and id_fase<>:id_fase and fase like '1%'  and archivo=:n_visado order by f_visado desc;				
	
end if


if not f_es_vacio(archivo) then
	return true
else
	return false
end if

end function

public function integer wf_actualizar_frontend (string id_fase);// LLAMADA AL WEBSERVICE DE ACTUALIZACION 
string n_registro,n_exp,n_visado,n_referencia,existe_few
datetime f_entrada,f_visado,f_abono
int res

select id_referencia_web into :n_referencia from fases_otros_datos where id_fase=:id_fase;

if f_es_vacio(n_referencia) then
	res=-102  // Referencia vacia
else
	n_csd_frontend_ws uo_frontend
	uo_frontend=create n_csd_frontend_ws
	res=uo_frontend.of_crear_conexion()
	if res>=0 then
		
		n_exp=dw_fases_datos_exp.GetItemString(dw_fases_datos_exp.GetRow(),'n_expedi')
		n_registro=dw_1.GetItemString(dw_1.GetRow(),'n_registro')
		n_visado=dw_1.GetItemString(dw_1.GetRow(),'archivo_fase')
		f_entrada=dw_1.GetItemDatetime(dw_1.GetRow(),'f_entrada')
		f_visado=dw_1.GetItemDatetime(dw_1.GetRow(),'f_visado')
		f_abono=dw_1.GetItemDatetime(dw_1.GetRow(),'f_abono')
		
		res=uo_frontend.of_actualizar_todo(n_referencia,n_registro,n_exp,n_visado,f_entrada,f_visado,f_abono)
	end if
	destroy uo_frontend
end if

if res=-1 then
	MessageBox("No se pudo actualizar frontend", "Referencia de contrato no encontrada")
elseif res=-99 then
	MessageBox("No se pudo actualizar frontend", "Error en la actualizaci$$HEX1$$f300$$ENDHEX$$n del contrato")	
elseif res=-101 then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","No se pudo conectar al webservice de actualizaci$$HEX1$$f300$$ENDHEX$$n. Comprobar que la url sea correcta y el servicio est$$HEX2$$e9002000$$ENDHEX$$activo")
else 
	// No mostramos mensaje si es -100,-102 o correcto
	//MessageBox("OK", "Actualizacion correcta")	
end if

return res
// FIN LLAMADA AL WEBSERVICE
end function

public subroutine wf_reparte_cantidad_descuentos (integer ai_fila, double adb_cantidad, string as_t_iva, string paga_cliente);
double ldb_cuantia_colegiado, ldb_cuantia_cliente

ldb_cuantia_cliente = idw_fases_informes.GetItemNumber(ai_fila,'cuantia_cliente')
ldb_cuantia_colegiado = idw_fases_informes.GetItemNumber(ai_fila,'cuantia_colegiado')
///*** SCP-884. Alexis. 03/03/2011. Creado para rellenar los descuentos ***///
if isnull(ldb_cuantia_colegiado) then ldb_cuantia_colegiado = 0
if isnull(ldb_cuantia_cliente) then ldb_cuantia_cliente = 0

idw_fases_informes.setitem(ai_fila, 't_iva', as_t_iva )

if paga_cliente = 'S' then
	idw_fases_informes.setitem(ai_fila, 'cuantia_cliente', adb_cantidad )
	idw_fases_informes.setitem(ai_fila, 'impuesto_cliente', f_aplica_t_iva(adb_cantidad, as_t_iva ))
	idw_fases_informes.setitem(ai_fila, 'participa_cliente', 'S')
	idw_fases_informes.setitem(ai_fila, 'participa_colegiado', 'N')
else

	if (ldb_cuantia_colegiado = ldb_cuantia_cliente) then 
		if (ldb_cuantia_cliente = 0) then
			idw_fases_informes.setitem(ai_fila, 'cuantia_colegiado', adb_cantidad )
			idw_fases_informes.setitem(ai_fila, 'impuesto_colegiado', f_aplica_t_iva(adb_cantidad, as_t_iva ))
			idw_fases_informes.setitem(ai_fila, 'participa_colegiado', 'S')
			idw_fases_informes.setitem(ai_fila, 'participa_cliente', 'N')
		else
			idw_fases_informes.setitem(ai_fila, 'cuantia_colegiado', f_redondea(adb_cantidad/2) )
			idw_fases_informes.setitem(ai_fila, 'impuesto_colegiado', f_aplica_t_iva(adb_cantidad, as_t_iva ))
			idw_fases_informes.setitem(ai_fila, 'participa_colegiado', 'S')
			idw_fases_informes.setitem(ai_fila, 'cuantia_cliente', adb_cantidad - f_redondea(adb_cantidad/2) )
			idw_fases_informes.setitem(ai_fila, 'impuesto_cliente', f_aplica_t_iva((adb_cantidad - f_redondea(adb_cantidad/2)), as_t_iva ))
			idw_fases_informes.setitem(ai_fila, 'participa_cliente', 'S')
		end if
		
	else 
		if (ldb_cuantia_colegiado = 0) then
			idw_fases_informes.setitem(ai_fila, 'cuantia_cliente', adb_cantidad )
			idw_fases_informes.setitem(ai_fila, 'impuesto_cliente', f_aplica_t_iva(adb_cantidad, as_t_iva ))
			idw_fases_informes.setitem(ai_fila, 'participa_cliente', 'S')
			idw_fases_informes.setitem(ai_fila, 'participa_colegiado', 'N')
		else
				idw_fases_informes.setitem(ai_fila, 'cuantia_colegiado', adb_cantidad )
				idw_fases_informes.setitem(ai_fila, 'impuesto_colegiado', f_aplica_t_iva(adb_cantidad, as_t_iva ))
				idw_fases_informes.setitem(ai_fila, 'participa_colegiado', 'S')
				idw_fases_informes.setitem(ai_fila, 'cuantia_cliente', 0 )
				idw_fases_informes.setitem(ai_fila, 'impuesto_cliente', 0 )
				idw_fases_informes.setitem(ai_fila, 'participa_cliente', 'N')
					
		end if
	end if	
end if
		

end subroutine

protected function integer wf_actualizar_datos_plataforma ();// LLAMADA AL WEBSERVICE DE ACTUALIZACION 
string n_registro,n_exp,n_visado,n_referencia,existe_few, id_visado, ls_id_fase, ls_tipo_visado
datetime f_entrada,f_visado,f_abono
int res

//	numexpedienterequest l_st_request

ls_tipo_visado = dw_1.getitemstring( dw_1.getrow(),'e_mail')

// Si no proviene de visared o plataforma, no es necesario actualizar nada
if (ls_tipo_visado <> 'V') then return -100

ls_id_fase = dw_1.getitemstring( dw_1.getrow(),'id_fase')

select id_referencia_web into :n_referencia from fases_otros_datos where id_fase=:ls_id_fase;

if f_es_vacio(n_referencia) then return -102  // Referencia vacia

//n_ws_plataforma_consumer uo_consumer
//uo_consumer=create n_ws_plataforma_consumer
//res=uo_consumer.of_crear_conexion()
//
//if res>=0 then
//		
//	l_st_request.numeroexpediente=dw_fases_datos_exp.GetItemString(dw_fases_datos_exp.GetRow(),'n_expedi')
//	l_st_request.numeroregistro=dw_1.GetItemString(dw_1.GetRow(),'n_registro')
//	l_st_request.numerovisado=dw_1.GetItemString(dw_1.GetRow(),'archivo_fase')
//	l_st_request.fechavisado=dw_1.GetItemDatetime(dw_1.GetRow(),'f_visado')
//	l_st_request.fechafinobra=dw_fases_datos_exp.getitemdatetime(dw_fases_datos_exp.Getrow(), 'f_cierre')
//	l_st_request.idsolicitud=RightA(n_referencia, LenA(n_referencia)  - 6)
//	l_st_request.codigocolegio = g_cod_colegio
//	
//	//f_entrada=dw_1.GetItemDatetime(dw_1.GetRow(),'f_entrada')
//	//f_abono=dw_1.GetItemDatetime(dw_1.GetRow(),'f_abono')
//	
//	//res=uo_frontend.of_actualizar_todo(n_referencia,n_registro,n_exp,n_visado,f_entrada,f_visado,f_abono)
//	res = uo_consumer.of_update_projects_data(l_st_request)
//end if
//
//destroy uo_consumer
//

n_runandwait runandwait
runandwait = create n_runandwait
runandwait.of_SetPriority(runandwait.HIGH_PRIORITY_CLASS)
runandwait.of_SetCurrentDirectory(g_dir_aplicacion)
runandwait.of_SetWindow("minimize")

res = runandwait.of_runandwait('sica_port_service.exe ' + n_referencia)

return res
// FIN LLAMADA AL WEBSERVICE
end function

public function double wf_calcular_tarifa_articulo (string as_articulo);n_ws_calculo_gastos l_n_ws
integer res 
n_cst_string	lnv_string

l_n_ws = create n_ws_calculo_gastos
res = l_n_ws.of_crear_conexion( )

if res < 0 then 
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al conectar con el servicio de calculo de gastos" + CR + "Comunique al administrador los problemas detectados")
	return 0
end if 

calculaterequest lst_calc_request
keyvalue l_keyvalue[]

double sup_garaje,sup_otros,sup_viv, volumen, pem, total_informe
int num_viviendas, li_cantidad_articulos, li_i, ret, i
string visared, obra_oficial, t_tramite, id_informe, ls_key, ls_value
st_csi_articulos_servicios st_csi_articulos_servicios

sup_viv = idw_fases_estadistica.getitemnumber(1, 'sup_viv')
sup_otros= idw_fases_estadistica.getitemnumber(1, 'sup_otros')
sup_garaje=idw_fases_estadistica.getitemnumber(1, 'sup_garage')
volumen = idw_fases_estadistica.getitemnumber(1, 'volumen')
num_viviendas = idw_fases_estadistica.getitemnumber(1, 'num_viv')
pem = idw_fases_estadistica.getitemnumber(1, 'pem')
if IsNull(sup_viv) then sup_viv=0
if IsNull(sup_otros) then sup_otros=0	
if IsNull(sup_garaje) then sup_garaje=0	
if IsNull(volumen) then volumen=0	
if IsNull(num_viviendas) then num_viviendas=1
if IsNull(pem) then pem=0

visared = dw_1.GetItemString(dw_1.GetRow(),'e_mail')
obra_oficial = idw_fases_datos_exp.GetItemString(idw_fases_datos_exp.GetRow(),'administracion')
if f_es_vacio(obra_oficial) then obra_oficial = 'N'
t_tramite = dw_1.GetItemString(dw_1.GetRow(),'id_tramite')

lst_calc_request.colegio = g_cod_colegio

if obra_oficial = 'N' then 
	lst_calc_request.obra_oficial = false
else 	
	lst_calc_request.obra_oficial = true
end if 	

//lst_calc_request.obra_oficialspecified = true

if visared = 'V' then 
	lst_calc_request.visared = true
else 
	lst_calc_request.visared = false
end if 

//lst_calc_request.visaredspecified= true
lst_calc_request.pem = pem
lst_calc_request.superficie = sup_viv+sup_otros+sup_garaje
//lst_calc_request.superficiespecified= true
lst_calc_request.tipo_intervencion = dw_1.GetItemString(dw_1.GetRow(),'fase')
lst_calc_request.tipo_obra = dw_1.GetItemString(dw_1.GetRow(),'tipo_trabajo')
lst_calc_request.tramite = t_tramite
lst_calc_request.num_viv = num_viviendas
//lst_calc_request.num_participantesspecified= true
lst_calc_request.volumen = volumen
//lst_calc_request.volumenspecified= true
lst_calc_request.num_participantes = idw_fases_colegiados.rowcount()
//lst_calc_request.num_participantesspecified = true

//Forced in that moment. 
lst_calc_request.porcentaje = 100
//lst_calc_request.porcentajespecified = true

lst_calc_request.tipo_solicitud = 'NUEVO'

string ls_visared_tramites
ls_visared_tramites = visared
IF visared = 'V' THEN 
	ls_visared_tramites = 'S'
// Otros : 'S' => sin equivalencia, debe ser distinto a 'S', 'N'
elseif visared = 'S' THEN 	
	ls_visared_tramites = 'O'
end if

//datastore informes
//
//informes = create datastore
//informes.dataobject = 'd_fases_informes_x_tramite'
//informes.SetTransObject(SQLCA)
//informes.Retrieve (ls_visared_tramites, t_tramite, g_colegio)
//
//for i=1 to informes.RowCount()
//	id_informe = informes.GetItemString(i, 'id_informe');
	
if f_valida_articulo_activo(as_articulo, g_empresa) = 0 then return 0
	
lst_calc_request.articulo	= as_articulo

	//total_informe=uo_calculo_gastos.of_calcular_importe_total()
l_keyvalue = l_n_ws.of_calcular_gastos(lst_calc_request)
	
li_cantidad_articulos = UpperBound(l_keyvalue)
	
For li_i = 1 To li_cantidad_articulos
	ls_key = l_keyvalue[li_i].key
	ls_value = l_keyvalue[li_i].value
	ls_value = lnv_string.of_GlobalReplace (ls_value, ".", "," ) 

	//if ls _key = id_informe then 
	if lower(ls_key) = 'tarifa' then 
		if isnumber(ls_value) then 
			total_informe= double(ls_value)
		else 
			total_informe=0
		end if	
	end if 	
		
next	
	
destroy(l_n_ws)
return total_informe	

end function

on w_fases_detalle.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_detalle_fases" then this.MenuID = create m_detalle_fases
this.dw_fases_datos_exp=create dw_fases_datos_exp
this.tab_1=create tab_1
this.dw_fases_botones=create dw_fases_botones
this.dw_2=create dw_2
this.cb_1=create cb_1
this.dw_otros_datos=create dw_otros_datos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_fases_datos_exp
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.dw_fases_botones
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_otros_datos
end on

on w_fases_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_fases_datos_exp)
destroy(this.tab_1)
destroy(this.dw_fases_botones)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.dw_otros_datos)
end on

event open;call super::open;st_control_eventos c_evento

i_cond = 1
i_nuevo = FALSE
g_recien_grabado_modificacion_fases=TRUE

// Asocio dw de instancia a los dws de las pesta$$HEX1$$f100$$ENDHEX$$as
idw_fases_promotores 			= tab_1.tabpage_1.dw_fases_promotores
idw_fases_colegiados 			= tab_1.tabpage_2.dw_fases_colegiados
idw_fases_colegiados_asociados= tab_1.tabpage_2.dw_fases_colegiados_asociados
idw_fases_documentos 			= tab_1.tabpage_3.dw_fases_documentos
idw_fases_reparos 				= tab_1.tabpage_4.dw_fases_reparos
idw_fases_informes				= tab_1.tabpage_8.dw_fases_informes  
idw_fases_modificacion_datos	= tab_1.tabpage_7.dw_fases_modificacion_datos
idw_fases_datos_exp				= dw_fases_datos_exp
idw_fases_estados					= tab_1.tabpage_12.dw_fases_estados
idw_fases_otras_fases			= tab_1.tabpage_9.dw_fases_otras_fases
idw_fases_estadistica			= tab_1.tabpage_5.dw_fases_estadistica
idw_fases_estadistica_otros= tab_1.tabpage_5.dw_fases_estadistica_otros
idw_fases_registros				= tab_1.tabpage_11.dw_fases_registros
idw_fases_reclamaciones			= tab_1.tabpage_12.dw_fases_reclamaciones
idw_fases_src						= tab_1.tabpage_13.dw_fases_src
idw_fases_minutas					= tab_1.tabpage_14.dw_fases_minutas
idw_fases_finales_obra			= tab_1.tabpage_15.dw_finales_obra
idw_fases_arquitectos			= tab_1.tabpage_16.dw_arquitectos
idw_fases_garantias				= tab_1.tabpage_17.dw_garantias
idw_fases_cip_tfe 				= tab_1.tabpage_19.cip_tfe
idw_fases_reparos_nuevos = tab_1.tabpage_6.dw_reparos_nuevos
//2/7/2008 Modificacion introducida por Javi Medina
idw_fases_incidencias = tab_1.tabpage_10.dw_incidencias
idw_fases_pagos_plataforma = tab_1.tabpage_18.dw_fases_pagos_plataforma
idw_fases_pagos_facturas = tab_1.tabpage_18.dw_fases_pagos_facturas

// Enlazamos los DW esclavos con el DW principal
f_enlaza_dw(dw_1, idw_fases_datos_exp, 'id_expedi', 'id_expedi')
f_enlaza_dw(dw_1, idw_fases_promotores, 'id_fase', 'id_fase')
f_enlaza_dw(dw_1, idw_fases_colegiados, 'id_fase', 'id_fase')	
f_enlaza_dw(dw_1, idw_fases_estadistica, 'id_fase', 'id_fase')
f_enlaza_dw(dw_1, idw_fases_registros, 'id_fase', 'n_expedi')
f_enlaza_dw(idw_fases_colegiados, idw_fases_colegiados_asociados, 'id_fases_colegiados', 'id_fases_colegiados')	
// se quita el f_enlaza porque tenemos 2 retrieval's args. //f_enlaza_dw(dw_1, idw_fases_modificacion_datos, 'id_fase', 'id_fase')
f_enlaza_dw(dw_1, idw_fases_documentos, 'id_fase', 'id_fase')
f_enlaza_dw(dw_1, idw_fases_estados, 'id_fase', 'id_fase')
f_enlaza_dw(dw_1, idw_fases_informes, 'id_fase', 'id_fase')
f_enlaza_dw(dw_1, idw_fases_reclamaciones, 'id_fase', 'id_fase')
f_enlaza_dw(dw_1, idw_fases_minutas, 'id_fase', 'id_fase')
f_enlaza_dw(dw_1, idw_fases_reparos, 'id_fase', 'id_fase')
f_enlaza_dw(dw_1, idw_fases_reparos_nuevos, 'id_fase', 'id_fase')
f_enlaza_dw(dw_1, idw_fases_src, 'id_fase', 'id_fase')
f_enlaza_dw(dw_1, idw_fases_finales_obra,'id_fase','id_fase')
f_enlaza_dw(dw_1, idw_fases_arquitectos,'id_fase','id_fase')
f_enlaza_dw(dw_1, idw_fases_garantias,'id_fase','id_fase')
//2/7/2008 Modificacion introducida por Javi Medina
f_enlaza_dw(dw_1, idw_fases_incidencias,'id_fase','id_fase')
f_enlaza_dw(dw_1, idw_fases_pagos_plataforma,'id_fase','id_fase')
f_enlaza_dw(idw_fases_pagos_plataforma, idw_fases_pagos_facturas, 'id_fases_pagos_plataforma', 'id_fases_pagos_plataforma')

//A partir de aqui se pueden introducir las funciones de cambios de tama#o y
//posicion de los controles de la ventana.
//Primero de los tabs
inv_resize.of_register (tab_1, "scaletoright&bottom")
g_dw_fases_minutas=idw_fases_minutas
g_dw_fases_colegiados=idw_fases_colegiados
g_dw_fases_clientes=idw_fases_promotores
g_dw_fases_estados = idw_fases_estados
g_dw1 =dw_1

//Luego de los DW
inv_resize.of_register (idw_fases_promotores, "scaletoright&bottom")
inv_resize.of_register (idw_fases_informes, "scaletoright&bottom")
inv_resize.of_register (idw_fases_otras_fases, "scaletoright&bottom")
inv_resize.of_register (idw_fases_estadistica, "scaletoright&bottom")
inv_resize.of_register (idw_fases_documentos, "scaletoright&bottom")
inv_resize.of_register (idw_fases_registros, "scaletoright&bottom")
inv_resize.of_register (idw_fases_reclamaciones, "scaletobottom")
inv_resize.of_register (idw_fases_estados, "scaletobottom")
inv_resize.of_register (idw_fases_minutas, "scaletoright&bottom")
inv_resize.of_register (idw_fases_cip_tfe, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_13.pb_calculo_musaat, "fixedtoright")
inv_resize.of_register (tab_1.tabpage_8.pb_recalcular, "fixedtoright")
inv_resize.of_register (tab_1.tabpage_5.pb_calcular_dtos, "fixedtoright")
inv_resize.of_register (tab_1.tabpage_5.pb_calcular_dtos_nuevo, "fixedtoright")
inv_resize.of_register (idw_fases_finales_obra, "scaletoright&bottom")
inv_resize.of_register (idw_fases_arquitectos, "scaletoright&bottom")
inv_resize.of_register (idw_fases_colegiados, "scaletobottom")
inv_resize.of_register (idw_fases_colegiados_asociados, "scaletoright&bottom")
inv_resize.of_register (idw_fases_src, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_4.dw_fases_reparos, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_17.dw_garantias, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_14.cb_cobrar_avisos, "fixedtobottom")
inv_resize.of_register (tab_1.tabpage_14.cb_generar_avisos, "fixedtobottom")
inv_resize.of_register (tab_1.tabpage_11.cb_anyadir, "fixedtobottom")
inv_resize.of_register (idw_fases_reparos_nuevos, "scaletoright&bottom")
//2/7/2008 Modificacion introducida por Javi Medina
inv_resize.of_register (idw_fases_incidencias, "scaletoright&bottom")

inv_resize.of_register (idw_fases_pagos_plataforma, "scaletoright&bottom")
inv_resize.of_register (idw_fases_pagos_facturas, "FixedToRight&ScaleToBottom")
inv_resize.of_register (tab_1.tabpage_18.cb_anyadir_factura_concilio, "FixedToRight")

if idw_fases_estadistica.RowCount() = 0 then 
	idw_fases_estadistica.insertrow(0)
	
end if	


// Llamamos al control de eventos evento 'ABRIR_FASE'
c_evento.evento = 'ABRIR_FASE'
c_evento.dw = dw_1
if f_control_eventos(c_evento)=-1 then return

c_evento.evento = 'ABRIR_FASE'
c_evento.dw = dw_fases_datos_exp
if f_control_eventos(c_evento)=-1 then return

this.PostEvent('csd_control_estados')

if g_colegio = 'COAATA' or g_colegio = 'COAATTFE' or g_colegio = 'COAATCU' or g_colegio = 'COAATZ' or g_colegio = 'COAATGU' or g_colegio = 'COAATAVI' or g_colegio = 'COAATCC' or g_colegio = 'COAATTER' then
	if isvalid(tab_1.tabpage_5.pb_calcular_dtos) then tab_1.tabpage_5.pb_calcular_dtos.visible = false
end if

if g_colegio = 'COAATCC' then
	tab_1.tabpage_14.cb_generar_avisos.visible=true
else
	tab_1.tabpage_14.cb_generar_avisos.visible=false	
end if

SetMicroHelp("F4 - B$$HEX1$$fa00$$ENDHEX$$squeda de calles")

//Andr$$HEX1$$e900$$ENDHEX$$s 8/6/2005
//Comprobamos que g_directorio_documentos_fases tenga una '\' al final.
//La variable se usa en esta ventana
int li_longitud

li_longitud=LenA(g_directorio_documentos_fases)

if MidA(g_directorio_documentos_fases,li_longitud,1)<>'\' then
	g_directorio_documentos_fases+='\'
end if

// CBU-42
dw_1.Object.DataWindow.ShowBackColorOnXP = "yes"
dw_fases_botones.Object.DataWindow.ShowBackColorOnXP = "yes"


end event

event pfc_preupdate;call super::pfc_preupdate;string t_reparo,col,t_rep,id_col,id_fase,fase,id_expedi,fichero_zip,fichero_zip2,ls_tip,ls_to,sl_destino, ls_tipo_reg, n_consejo_fase
double suma_colA,suma_colD,suma_prom,suma_col,num_viv
integer i,repetidos,encontrados
datetime hoy
boolean hacer
string t_actuacion, t_obra, uso, ret_incomp, tipo_via, cod, i_tramite_defecto

if f_puedo_escribir(g_usuario, '0000000007')= -1 then return -1

id_fase = dw_1.GetItemString(1,'id_fase')
string mensaje=''

dw_1.AcceptText()
idw_fases_datos_exp.Accepttext()

hoy = datetime(Today())
	
// Comprobamos que hemos rellenado todos los campos obligatorios.

//De Fases...
select texto into :i_tramite_defecto from var_globales where nombre='g_tipo_tramite_novacio';
if i_tramite_defecto = 'S' then
	mensaje+= f_valida(dw_1,'id_tramite','NOVACIO', g_idioma.of_getmsg('fases.id_tramite', 'Debe especificar un valor en el campo Tipo Tramite.'))
end if 

n_consejo_fase = dw_1.GetItemString(dw_1.GetRow(),'n_consejo_fase')
if not f_es_vacio ( n_consejo_fase ) then
	n_consejo_fase = trim (n_consejo_fase)
	if Len(n_consejo_fase) <> 12 then
		mensaje += 'El campo N$$HEX2$$ba002000$$ENDHEX$$consejo debe tener 12 caracteres' 
		mensaje += cr
	end if
end if
	

mensaje+= f_valida(dw_1,'fase','NOVACIO',g_idioma.of_getmsg('fases.msg_valor_tipo_actuacion','Debe especificar un valor en el campo Tipo de Actuaci$$HEX1$$f300$$ENDHEX$$n.'))
//mensaje+= f_valida(dw_1,'tipo_fase','NOVACIO','Debe especificar un valor en el campo Tipo de contrato MUSAAT')
mensaje+= f_valida(dw_1,'f_entrada','NONULO',g_idioma.of_getmsg('fases.msg_valor_f_entrada','Debe especificar un valor en el campo Fecha de Entrada.'))
mensaje+= f_valida(dw_1,'tipo_trabajo','NOVACIO',g_idioma.of_getmsg('fases.msg_valor_tipo_obra','Debe especificar un valor en el campo Tipo de Obra.'))
mensaje+= f_valida(dw_1,'trabajo','NOVACIO',g_idioma.of_getmsg('fases.msg_valor_destino_uso_obra','Debe especificar un valor en el campo Destino o Uso de la Obra.'))
mensaje+= f_valida(dw_1,'tipo_via_emplazamiento','NOVACIO','Debe especificar un valor en el campo Emplazamiento Tipo de V$$HEX1$$ed00$$ENDHEX$$a.')
mensaje+= f_valida(dw_1,'emplazamiento','NOVACIO',g_idioma.of_getmsg('fases.msg_valor_emplazamiento','Debe especificar un valor en el campo Emplazamiento.'))
mensaje+= f_valida(dw_1,'poblacion','NOVACIO',g_idioma.of_getmsg('general.campo_poblacion','Debe especificar un valor en el campo Poblaci$$HEX1$$f300$$ENDHEX$$n.'))
mensaje+= f_valida(dw_1,'tipo_gestion','NONULO',g_idioma.of_getmsg('fases.msg_camp_tipo_gestion','Debe especificar un valor en el campo Tipo de Gesti$$HEX1$$f300$$ENDHEX$$n.'))
mensaje+= f_valida(dw_1,'compute_2','NOVACIO',g_idioma.of_getmsg('fases.msg_camp_pobalcion','La poblaci$$HEX1$$f300$$ENDHEX$$n es incorrecta, no existe, debe darla de alta en Poblaciones.'))

if not f_es_vacio(mensaje) then mensaje += cr


// Rdelafuente 14/09/2011

//

tipo_via = dw_1.GetItemString(1,'tipo_via_emplazamiento')
SELECT tipos_via.cod_tipo_via INTO :cod FROM tipos_via WHERE tipos_via.cod_tipo_via = :tipo_via ;
if f_es_vacio(cod) then mensaje+= 'El tipo de via del emplazamiento no existe.'


//mensaje += f_comprobar_incidencias_visared('F')

// Incompatibilidades para aparejadores
t_actuacion = dw_1.getitemstring(1, 'fase')
t_obra = dw_1.getitemstring(1, 'tipo_trabajo')
uso = dw_1.getitemstring(1, 'trabajo')
ret_incomp = f_hay_incompatibilidad(t_actuacion, t_obra, uso, true)
choose case ret_incomp
	case 'PROHIBIDO'
//		mensaje+= cr+'Esta combinaci$$HEX1$$f300$$ENDHEX$$n de tipo de actuaci$$HEX1$$f300$$ENDHEX$$n-tipo de obra-uso de obra es incompatible'
	case 'AVISO'
		// Se deja seguir
end choose

// MUSAAT
double superficie
string tabla

SELECT tabla
INTO :tabla
FROM musaat_coef_c
WHERE (tipoact = :t_actuacion OR tipoact = '*') AND (tipoobra = :t_obra OR tipoobra = '*') ;

if f_es_vacio(tabla) then
	messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_combinacion_musaat','Esta combinacion tipo act-tipo obra no la recoge MUSAAT'))
end if

// MOPU
string cod_pob, pob_mopu

cod_pob = dw_1.GetItemString(1,'poblacion')

If not f_es_vacio(cod_pob)  and f_es_vacio(f_valida(dw_1,'compute_2','NOVACIO',g_idioma.of_getmsg('fases.msg_camp_pobalcion','La poblaci$$HEX1$$f300$$ENDHEX$$n es incorrecta, no existe, debe darla de alta en Poblaciones.'))) then
	SELECT poblaciones.pob_mopu  
	INTO :pob_mopu  
	FROM poblaciones  
	WHERE poblaciones.cod_pob = :cod_pob   ;
	
	if f_es_vacio(pob_mopu) then
		messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_pob_mopu','Esta poblacion no tiene c$$HEX1$$f300$$ENDHEX$$digo de MOPU'))
	end if
end if



// Estadistica
mensaje += this.event csd_configura_datos_est()
if f_es_vacio(string(idw_fases_estadistica.getitemnumber(1,'sup_viv'))) then mensaje += cr + g_idioma.of_getmsg('fases.msg_campo_sup_viv','Debe especificar un valor en el campo Superficie Viviendas.')
if f_es_vacio(string(idw_fases_estadistica.getitemnumber(1,'sup_garage'))) then mensaje += cr + g_idioma.of_getmsg('fases.msg_campo_sup_garage','Debe especificar un valor en el campo Superficie Garaje.')
if f_es_vacio(string(idw_fases_estadistica.getitemnumber(1,'sup_otros'))) then mensaje += cr +g_idioma.of_getmsg('fases.msg_campo_sup_otros','Debe especificar un valor en el campo Superficie Otros.')

//Colegiados
if idw_fases_colegiados.RowCount()=1 then
	if f_es_vacio(idw_fases_colegiados.getitemstring(1,'id_col')) then 
		mensaje+= cr +g_idioma.of_getmsg('fases.msg_col_f1','El n$$HEX1$$fa00$$ENDHEX$$mero de Colegiado no es v$$HEX1$$e100$$ENDHEX$$lido o no esta dado de alta (fila 1)')	
	end if
end if
// Asociaciones
// Comprobar que los asociaciados se han grabado ya
int ret
datastore ds_fases_colegiados_asociados
ds_fases_colegiados_asociados = create datastore
ds_fases_colegiados_asociados.dataobject = 'ds_fases_colegiados_asociados'
ds_fases_colegiados_asociados.settransobject(sqlca)		
for i = 1 to idw_fases_colegiados.rowcount()
	// Si estoy introduciendo $$HEX1$$e900$$ENDHEX$$ste y tiene asociados que suman 100 entonces paso al siguiente
	if i = idw_fases_colegiados.getrow() and idw_fases_colegiados_asociados.rowcount() > 0 then 
		if idw_fases_colegiados_asociados.getitemnumber(idw_fases_colegiados_asociados.rowcount(), 'suma_porc') = 100 then
			continue
		else
			mensaje+= cr +g_idioma.of_getmsg('fases.msg_numero_col_fila','El n$$HEX1$$fa00$$ENDHEX$$mero de Colegiado de la fila ') + string(i) + g_idioma.of_getmsg('fases.msg_asociados_porcentaje',' es una sociedad, debe introducir los asociados y sus porcentajes sumar 100'	)		
		end if
	end if
	// Si es sociedad
	if f_colegiado_tipopersona(idw_fases_colegiados.getitemstring(i,'id_col')) = 'S' then
		ret = ds_fases_colegiados_asociados.retrieve( idw_fases_colegiados.getitemstring(i,'id_fases_colegiados')) 
		if ds_fases_colegiados_asociados.rowcount() <= 0 then
			mensaje+= cr +g_idioma.of_getmsg('fases.msg_numero_col_fila','El n$$HEX1$$fa00$$ENDHEX$$mero de Colegiado de la fila ') + string(i) + g_idioma.of_getmsg('fases.msg_asociados',' es una sociedad, debe introducir los asociados y sus porcentajes sumar 100')
		end if
	end if
next
destroy ds_fases_colegiados_asociados
for i=1 to idw_fases_colegiados.rowcount()
	suma_col = suma_col + idw_fases_colegiados.GetItemNumber(i,'porcen_a')
//	if (idw_fases_colegiados.getitemstring(i,'tipo_a')='N') and (idw_fases_colegiados.getitemstring(i,'tipo_d')='N') then
//		mensaje+= cr +'Indicar tipo de colegiado: Autor o Director.'	
//	end if
next
suma_cola=0
suma_cold=0
for i=1 to idw_fases_colegiados.rowcount()
//	if idw_fases_colegiados.getitemstring(i,'tipo_a')='S' then
		suma_colA = suma_colA + idw_fases_colegiados.getitemnumber(i,'porcen_a')
//	else
//		suma_colD = suma_colD + idw_fases_colegiados.getitemnumber(i,'porcen_a')
//	end if	
	g_suma_porcentajes_col = suma_colA + suma_colD
next
if suma_colA + suma_colD = 0 then
	mensaje+= cr +g_idioma.of_getmsg('fases.msg_col_participacion','Debe haber al menos un colegiado con participaci$$HEX1$$f300$$ENDHEX$$n superior a 0.')
end if

//if g_suma_porcentajes_col > 100 then
//	mensaje+= cr +'La participaci$$HEX1$$f300$$ENDHEX$$n de los colegiados es mayor de 100.'
//end if

// RICARDO 04-04-26
//if i_datos_importacion.opcion_importacion ='N' then 
        //Clientes
        suma_prom=0
//      if idw_fases_promotores.RowCount()=1 then
//              if f_es_vacio(idw_fases_promotores.getitemstring(1,'id_cliente')) then 
//                      mensaje+= cr +'Debe indicar el nif de cliente, o no existe ning$$HEX1$$fa00$$ENDHEX$$n cliente con ese NIF.' 
//              end if  
//      end if
//end if
mensaje+= f_valida(idw_fases_promotores,'id_cliente','NOVACIO',g_idioma.of_getmsg('fases.msg_nif_cliente','Debe indicar el nif de cliente, o no existe ning$$HEX1$$fa00$$ENDHEX$$n cliente con ese NIF.'))
// FIN RICARDO 04-04-26  





for i=1 to idw_fases_promotores.rowcount()
	if idw_fases_promotores.GetItemString(i,'pagador')='S' then
		suma_prom = suma_prom + idw_fases_promotores.getitemnumber(i,'porcen')
	end if
	g_suma_porcentajes_cli = suma_prom
next
if suma_prom = 0 then
	mensaje+= cr +g_idioma.of_getmsg('fases.msg_pagador_participacion','Debe haber al menos un cliente PAGADOR en la fase con una participaci$$HEX1$$f300$$ENDHEX$$n mayor que 0.')
end if

//Validaci$$HEX1$$f300$$ENDHEX$$n MINUTAS
string id_cli
boolean existe_col=false, existe_cli=false
int j, aviso=0
if idw_fases_minutas.RowCount()>0 then
	// Avisamos si existe alg$$HEX1$$fa00$$ENDHEX$$n aviso pendiente con un colegiado o cliente que no est$$HEX2$$e1002000$$ENDHEX$$en el contrato
	for i=1 to idw_fases_minutas.RowCount()
		if idw_fases_minutas.getitemstring(i, 'pendiente') = 'N' then continue
		id_cli = idw_fases_minutas.getitemstring(i, 'id_cliente')
		id_col = idw_fases_minutas.getitemstring(i, 'id_colegiado')
		existe_col = false
		existe_cli = false
		for j=1 to idw_fases_colegiados.rowcount()
			if idw_fases_colegiados.getitemstring(j, 'id_col') = id_col then existe_col = true
		next
		for j=1 to idw_fases_promotores.rowcount()
			if idw_fases_promotores.getitemstring(j, 'id_cliente') = id_cli then existe_cli = true
		next
		if existe_col=false or existe_cli=false then aviso += 1
	next
	if aviso>0 then
		messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_factura_colegiado','Existe al menos un aviso de factura asignado a un colegiado y/o cliente no vinculado al contrato'))
	end if
end if

//Comprobamos datos no nulos en todas las filas
mensaje+= f_valida(idw_fases_reparos,'f_emision','NONULO',g_idioma.of_getmsg('fases.msg_campo_f_emision','Debe especificar un valor en el campo Fecha de emisi$$HEX1$$f300$$ENDHEX$$n de la tabla de Reparos.'))
mensaje+= f_valida(idw_fases_reparos,'id_col','NOVACIO',g_idioma.of_getmsg('fases.msg_campo_id_col','Debe especificar un valor en el campo Colegiado de la tabla de Reparos.'))
mensaje+= f_valida(idw_fases_reparos,'tipo_reparo','NOVACIO',g_idioma.of_getmsg('fases.msg_campo_raparo','Debe especificar un valor en el campo Reparo de la tabla de Reparos.'))
mensaje+= f_valida(idw_fases_reparos,'tipo','NOVACIO',g_idioma.of_getmsg('fases.msg_campo_tipo','Debe especificar un valor en el campo Tipo de la tabla de Reparos.'))

// Comprobamos que no existen reparos repetidos
if idw_fases_reparos.RowCount()>0 then
	id_col = idw_fases_reparos.GetItemString(idw_fases_reparos.getrow(),'id_col')
	t_reparo = idw_fases_reparos.GetItemString(idw_fases_reparos.getrow(),'tipo_reparo')
	
	//Control de fecha de emisi$$HEX1$$f300$$ENDHEX$$n y subsanaci$$HEX1$$f300$$ENDHEX$$n reparos
	for i=1 to idw_fases_reparos.RowCount()  
		if date(idw_fases_reparos.getitemdatetime(i,'f_emision')) < date(dw_1.getitemdatetime(1,'f_entrada')) and & 
			idw_fases_reparos.getitemstring(i,'tipo') <> g_codigo_reparos_otros_doc  then
			mensaje+= cr +'La fecha de entrada ha de ser menor o igual que la fecha de emision del reparo'
		end if    
		if date(idw_fases_reparos.getitemdatetime(i,'f_subsanacion')) < date(dw_1.getitemdatetime(1,'f_entrada')) and & 
			idw_fases_reparos.getitemstring(i,'tipo') <> g_codigo_reparos_otros_doc then
			mensaje+= cr +'La fecha de entrada ha de ser menor o igual que la fecha de subsanaci$$HEX1$$f300$$ENDHEX$$n del reparo'
		end if
		if date(idw_fases_reparos.getitemdatetime(i,'f_subsanacion')) < date(idw_fases_reparos.getitemdatetime(i,'f_emision')) then
			mensaje+= cr +'La fecha de emision del reparo ha de ser menor o igual que la fecha de subsanaci$$HEX1$$f300$$ENDHEX$$n del reparo'
		end if
	next
//	if not(f_es_vacio(id_col)) and not(f_es_vacio(t_reparo)) then
//		for i=1 to idw_fases_reparos.rowCount() 
//			col = idw_fases_reparos.GetItemString(i,'id_col')
//			t_rep = idw_fases_reparos.GetItemString(i,'tipo_reparo')
//			if id_col=col and t_reparo=t_rep then
//				repetidos++
//			end if
//		next
//	end if
//	if repetidos>1 then
//		mensaje+=cr + 'Existen 2 o m$$HEX1$$e100$$ENDHEX$$s reparos con las mismas caracter$$HEX1$$ed00$$ENDHEX$$sticas.'
//	end if
end if

//Informes
if idw_fases_informes.RowCount()>0 then
	mensaje+= f_valida(idw_fases_informes,'tipo_informe','NOVACIO',g_idioma.of_getmsg('fases.msg_campo_dtos','Debe especificar un valor en el campo Tipo de Descuento de la tabla de Descuentos.'))
end if

//SRC
if idw_fases_src.RowCount()>0 then
	mensaje+= f_valida(idw_fases_src,'id_col','NOVACIO',g_idioma.of_getmsg('fases.msg_campo_col_src','Debe especificar el Colegiado para el SRC.'))
end if

// Finales
if idw_fases_finales_obra.RowCount()>0 then
	mensaje+= f_valida(idw_fases_finales_obra,'f_intro','NONULO',g_idioma.of_getmsg('fases.msg_campo_fecha_intro_ficha_fin_obra','Debe especificar la Fecha de Introducci$$HEX1$$f300$$ENDHEX$$n en la Ficha Finales de Obra.'))
end if

//Otros Docs
if idw_fases_documentos.RowCount()>0 then
	mensaje+= f_valida(idw_fases_documentos,'tipo','NOVACIO',g_idioma.of_getmsg('fases.msg_campo_tipo_doc_otros','Debe especificar el Tipo de Documento en la Ficha Otros Docs.'))
	mensaje+= f_valida(idw_fases_documentos,'f_entrada','NONULO',g_idioma.of_getmsg('fases.msg_campo_fecha_entrada_otros','Debe especificar la Fecha de Entrada del Documento en la Ficha Otros Docs.'))
end if

//Incidencias
if idw_fases_incidencias.RowCount()>0 then
	mensaje+= f_valida(idw_fases_incidencias,'codigo','NOVACIO','Debe especificar el Tipo en la Ficha Notas.')
	mensaje+= f_valida(idw_fases_incidencias,'observaciones','NOVACIO','Debe especificar la Descripci$$HEX1$$f300$$ENDHEX$$n en la Ficha Notas.')
	mensaje+= f_valida(idw_fases_incidencias,'fecha','NONULO','Debe especificar la Fecha en la Ficha Notas.')
end if

// CIP - COAATTFE
if g_colegio = 'COAATTFE' then
	mensaje+= f_valida(idw_fases_cip_tfe,'tipo','NOVACIO','Debe especificar un valor en el campo Tipo de la ficha de CIP.')
	mensaje+= f_valida(idw_fases_cip_tfe,'ambito','NOVACIO','Debe especificar un valor en el campo $$HEX1$$c100$$ENDHEX$$mbito de la ficha de CIP.')
end if

// Modificado RICARDO 2004-11-18
// FASES-ESTADISTICAS
// Validamos que nos pongan el tipo de promotor para poder grabar
// Modificado David 24/02/2005
// En Gran Canaria que solo les obligue cuando el contrato est$$HEX2$$e1002000$$ENDHEX$$visado
if g_colegio = 'COAATGC' then
	if dw_1.getitemstring(1, 'estado') = g_fases_estados.verificado then 
		mensaje += f_valida(idw_fases_estadistica, 't_promotor', 'NOVACIO', g_idioma.of_getmsg('fases.msg_valor_promotor_estadisticas','Debe especificar el tipo de promotor en la ficha de estad$$HEX1$$ed00$$ENDHEX$$sticas'))
	end if
else
	mensaje += f_valida(idw_fases_estadistica, 't_promotor', 'NOVACIO', g_idioma.of_getmsg('fases.msg_valor_promotor_estadisticas','Debe especificar el tipo de promotor en la ficha de estad$$HEX1$$ed00$$ENDHEX$$sticas'))	
end if

// fin Modificado RICARDO 2004-11-18

//N$$HEX1$$fa00$$ENDHEX$$mero de viviendas para combinaci$$HEX1$$f300$$ENDHEX$$n de tipo de actuaci$$HEX1$$f300$$ENDHEX$$n, tipo obra y destino (modificado por Luis)
ls_tip = dw_1.getitemstring(1,'fase')
ls_to = dw_1.getitemstring(1,'tipo_trabajo')
sl_destino = dw_1.getitemstring(1,'trabajo')
ls_tipo_reg = dw_1.getitemstring(1, 'tipo_registro')
num_viv = idw_fases_estadistica.getitemnumber(1,'num_viv')
if isnull(num_viv) then num_viv = 0
if((ls_tip = '11' or ls_tip = '12' or ls_tip = '13' or ls_tip = '14' or ls_tip = '15' or ls_tip = '16' or ls_tip = '17') and (ls_to = '11'  or ls_to = '12' or ls_to = '13') and (sl_destino = '11' or sl_destino = '12' or sl_destino = '13' or sl_destino = '14'))then
	///*** Modificado para Alicante. CAL-248. Alexis. 23-03-2010 ****////
	if not (g_colegio = 'COAATA' and ls_tipo_reg = 'MO' and ls_tip = '14') then
		if(num_viv = 0)then
			MessageBox(g_titulo,'El n$$HEX1$$fa00$$ENDHEX$$mero de viviendas no puede ser cero para esta combinaci$$HEX1$$f300$$ENDHEX$$n de tipo de actuaci$$HEX1$$f300$$ENDHEX$$n, tipo de obra y destino.')
		end if
	end if	
end if
if((ls_tip = '11' or ls_tip = '12' or ls_tip = '13' or ls_tip = '14' or ls_tip = '15' or ls_tip = '16' or ls_tip = '17') and (ls_to = '11'  or ls_to = '12' or ls_to = '13') and &
(sl_destino <> '11' and sl_destino <> '12' and sl_destino <> '13' and sl_destino <> '14' and sl_destino <> '21' and sl_destino <> '22' and sl_destino <> '31' and sl_destino <> '32' and sl_destino <> '33' and sl_destino <> '34' and sl_destino <> '35' and sl_destino <> '36' and sl_destino <> '37' and sl_destino <> '38' and sl_destino <> '39' and sl_destino <> '41' and sl_destino <> '42' and sl_destino <> '43' and sl_destino <> '51' and sl_destino <> '52' and sl_destino <> '53' and sl_destino <> '54' and sl_destino <> '55' and sl_destino <> '61' and sl_destino <> '62'))then
		MessageBox(g_titulo,'El destino de la obra no puede tener este valor para esta combinaci$$HEX1$$f300$$ENDHEX$$n de tipo de actuaci$$HEX1$$f300$$ENDHEX$$n y tipo de obra.')
end if
//fin modificado Luis
//  Fin controles...........................................................



this.PostEvent('csd_control_estados')
postevent('csd_desglose_honos')

int retorno=1
if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
else
	st_control_eventos c_evento
	int cevento
	//Llamamos al Control de Eventos...
	c_evento.id_colegiado = idw_fases_colegiados.GetItemString(1,'id_col')
	c_evento.evento = 'GRABAR_FASE'
	c_evento.dw = dw_1
	cevento = f_control_eventos(c_evento)
	if cevento = -1 then return cevento
	// Incidencia 3269. Pon$$HEX1$$ed00$$ENDHEX$$a <> 'N' y lo restringimos a$$HEX1$$fa00$$ENDHEX$$n m$$HEX1$$e100$$ENDHEX$$s poniendo = 'S' pues en ocasiones queda vac$$HEX1$$ed00$$ENDHEX$$a la variable global.
	if g_fase_visared.opcion_importacion = 'S' then this.event csd_visared_preupdate(id_fase)

	// Asignamos el usuario a la tabla fases
	if f_es_vacio(dw_1.GetItemString(1,'usuario')) then dw_1.SetItem(1,'usuario',g_usuario)

	// Muestra el pem en el detalle de expedientes
	idw_fases_datos_exp.object.pem.text = string(idw_fases_estadistica.getitemnumber(1, 'pem'), "#,##0.00")
		
	this.TriggerEvent('csd_rellenar_campos_ocultos_expediente')
		
	//Borramos las l$$HEX1$$ed00$$ENDHEX$$neas de Colegiados y clientes q no tengan valor
	hacer=true
	do while hacer
		hacer=false
		for i=1 to idw_fases_colegiados.RowCount()
			if f_es_vacio(idw_fases_colegiados.getitemstring(i,'id_col')) then 
				idw_fases_colegiados.DeleteRow(i)
			hacer=true
			end if
		next
	loop
		
	hacer=true
	do while hacer
		hacer=false
		for i=1 to idw_fases_promotores.RowCount()
			if f_es_vacio(idw_fases_promotores.getitemstring(i,'id_cliente')) then 
				idw_fases_promotores.DeleteRow(i)
			hacer=true
			end if
		next
	loop
	tab_1.event csd_poner_titulo()
end if
i_pasa_preupdate = retorno	
return retorno

end event

event activate;call super::activate;g_dw_lista  = g_dw_lista_fases
g_w_lista   = g_lista_fases
g_w_detalle = g_detalle_fases 
g_lista     = 'w_fases_lista'
g_detalle   = 'w_fases_detalle'

end event

event csd_anterior();call super::csd_anterior;// Comprobamos que la ventana "lista previa" del m$$HEX1$$f300$$ENDHEX$$dulo est$$HEX2$$e1002000$$ENDHEX$$abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then
	g_fases_consulta.id_fase = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'id_fase')
	dw_1.event csd_retrieve()
end if

this.PostEvent('csd_control_estados')
end event

event csd_siguiente();call super::csd_siguiente;// Comprobamos que la ventana "lista previa" del m$$HEX1$$f300$$ENDHEX$$dulo est$$HEX2$$e1002000$$ENDHEX$$abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then
	g_fases_consulta.id_fase = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'id_fase')
	dw_1.event csd_retrieve()
end if
this.PostEvent('csd_control_estados')
end event

event csd_primero;call super::csd_primero;if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(1)
	g_dw_lista.scrolltorow(1)
	g_fases_consulta.id_fase = g_dw_lista.getitemstring(1,"id_fase")
	dw_1.event csd_retrieve()
end if
this.TriggerEvent('csd_control_estados')




end event

event csd_ultimo;call super::csd_ultimo;if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(g_dw_lista.rowcount())
	g_dw_lista.scrolltorow(g_dw_lista.rowcount())
	g_fases_consulta.id_fase = g_dw_lista.getitemstring(g_dw_lista.rowcount(),"id_fase")
	dw_1.event csd_retrieve()
end if
this.TriggerEvent('csd_control_estados')
end event

event csd_nuevo;////!!!SOBREESCRITO
st_fases_consulta datos_fase
g_recien_grabado_modificacion_fases = TRUE
i_nuevo = TRUE

//VEAMOS SI SE HAN PRODUCIDO CAMBIOS EN las dws actuales
int retorno
retorno = Event closequery()
if retorno = 1 then return -1
g_fase_visared.opcion_importacion = 'N'

if dw_1.rowcount() > 0 then
	if not f_es_vacio(dw_1.getitemstring(1, 'id_expedi')) then
		datos_fase.id_expedi  = dw_1.getitemstring(1, 'id_expedi')
	end if
end if

if f_es_vacio(datos_fase.id_expedi ) then
	datos_fase.opcion_importacion = 'E'
else
	datos_fase.opcion_importacion = 'F'
end if
OpenWithParm(w_fases_creacion_fases,datos_fase)
dw_1.event csd_retrieve()       



g_fases_consulta.id_expedi = ''

This.PostEvent('csd_control_estados')

dw_1.event csd_marcar_certificaciones()
// real decreto

// Decimos que no se ha pasado por el retrieveend
ib_avisar_incidencias = true

///*** SCP-778. El desplegable colegio destino debe indicar el colegio en el que se trabaja por defecto. Alexis. 21/12/2010 ***///
dw_1.setitem(dw_1.getrow(), 'cod_colegio_dest', g_cod_colegio)

return 1
end event

event pfc_postupdate;call super::pfc_postupdate;// Ver si tiene MUSAAT el Contrato
long fila_musaat
string retorno_10 = 'SS', generar_10 = 'S', facturar_10 = 'S', id_fase
boolean bl_generar_10 = true, bl_facturar_10 = true
int i,res
string t_visado, obra_oficial, n_referencia

if dw_otros_datos.rowcount()>0 then
	dw_otros_datos.update()
end if

id_fase = dw_1.GetItemString(dw_1.GetRow(),'id_fase')

if g_pruebas = false then 
	select id_referencia_web into :n_referencia from fases_otros_datos where id_fase=:id_fase;

	if leftA(n_referencia, 6) = "PLATA-" then 
		//Actualizaci$$HEX1$$f300$$ENDHEX$$n de datos en la plataforma
		wf_actualizar_datos_plataforma()
	else
		// LLAMADA AL WEBSERVICE DE ACTUALIZACION 
		wf_actualizar_frontend(id_fase)
		// FIN LLAMADA AL WEBSERVICE
	end if
end if


//SCP-2406
res = f_crear_movimiento_cfo(id_fase)
if (res = 1) then idw_fases_src.retrieve(id_fase)

fila_musaat = idw_fases_informes.Find("tipo_informe = '" + g_codigos_conceptos.musaat_variable + "'",0,idw_fases_informes.RowCount())
if fila_musaat <= 0 Then 
//	Messagebox(g_titulo, 'No est$$HEX2$$e1002000$$ENDHEX$$calculado el descuento de MUSAAT')		
	g_recien_grabado_modificacion_fases=TRUE
	return 1
end if

IF isnull(idw_fases_estadistica.getitemstring(1, 'colindantes2m')) then idw_fases_estadistica.setitem(1, 'colindantes2m', 'N')
// Se debe comprobar antes si existe un movimiento de musaat de tipo 1.1
for i = 1 to idw_fases_src.rowcount()
	t_visado = idw_fases_src.getitemstring(i, 't_visado')
	obra_oficial = idw_fases_src.getitemstring(i, 'obra_oficial')	
	if t_visado = '1' and obra_oficial = '1' then
		bl_generar_10 = false
	end if
next
// Se comprueba que existe al menos un colegiado no funcionario y que tiene musaat
boolean hay = false
string func, id_col
for i=1 to idw_fases_colegiados.rowcount()
	func = idw_fases_colegiados.getitemstring(i,'facturado')
	if f_tiene_musaat_src(idw_fases_colegiados.getitemstring(i, 'id_col')) and func = 'N' then hay = true
next
// Modificado David - 26/01/2006 - Si no actualizamos esta variable da el mensaje de que el contrato no est$$HEX2$$e1002000$$ENDHEX$$
// grabado al intentar crear un aviso
if not hay then
	g_recien_grabado_modificacion_fases=TRUE
	return 1
end if

// ----  Si no hay movimiento inicial y se cobra por certificaciones y se cobra el 10% al inicio entonces....
if dw_1.getitemstring(1, 'aplicado_10') = 'S' and bl_generar_10 and g_obra_admin_cgc_aplica_10 = 'S'  then
	open(w_musaat_10)
	retorno_10 = message.stringparm
	generar_10 = LeftA(retorno_10, 1)
	facturar_10 = RightA(retorno_10, 1)
	bl_generar_10 = (generar_10 = 'S')
	bl_facturar_10 = (facturar_10 = 'S')	
//		if Messagebox(g_titulo, 'Esta obra es Oficial, $$HEX1$$bf00$$ENDHEX$$Desea Emitir la factura del 10% anticipado a MUSAAT?', Question!, YesNo!) = 1 then
	this.event csd_cobrar_anticipo_musaat(bl_generar_10, bl_facturar_10)
	
	// Si no se genera el mov del 10% se quita el check de musaat por certificaciones para que cobre el 100%
	if generar_10 = 'N' then dw_1.setitem(1, 'aplicado_10', 'N')
	dw_1.update()
	
//		end if
end if

g_recien_grabado_modificacion_fases=TRUE
i_nuevo = FALSE
return 1
end event

event close;call super::close;if isvalid(w_descuentos_colegiado) then
	close(w_descuentos_colegiado)
end if

if g_colegio = 'COAATTFE' then
	FileDelete("encip.txt")
end if
end event

event type integer pfc_preclose();call super::pfc_preclose;// si no est$$HEX2$$e1002000$$ENDHEX$$abierta la pop up la cerramos
if isvalid(w_fases_mostrar_finales_acciones) then close(w_fases_mostrar_finales_acciones)

return AncestorReturnVAlue


end event

event pfc_close;call super::pfc_close;if FileExists(g_fase_visared.paquete_importacion)  then
	f_bloqueo_fichero(g_fase_visared.paquete_importacion,false)
end if

end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_fases_detalle
integer x = 315
integer y = 2148
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_fases_detalle
integer x = 315
integer y = 2044
end type

type cb_nuevo from w_detalle`cb_nuevo within w_fases_detalle
integer x = 3872
integer y = 636
integer taborder = 130
end type

type cb_ayuda from w_detalle`cb_ayuda within w_fases_detalle
integer x = 3872
integer y = 912
integer taborder = 170
end type

type cb_grabar from w_detalle`cb_grabar within w_fases_detalle
integer x = 3872
integer y = 732
integer taborder = 140
end type

type cb_ant from w_detalle`cb_ant within w_fases_detalle
integer x = 3872
integer y = 820
integer taborder = 150
end type

type cb_sig from w_detalle`cb_sig within w_fases_detalle
integer x = 4142
integer y = 820
integer taborder = 160
end type

type dw_1 from w_detalle`dw_1 within w_fases_detalle
event csd_modificacion_datos ( string idfase,  u_dw dw,  string nombre_dw,  string campo,  long row )
event csd_fases_otras_fases ( )
event csd_recupera_posicion ( string campo )
event csd_insertar_lineas_nuevas ( )
event csd_habilitar_certificaciones ( )
event csd_marcar_certificaciones ( )
event csd_inserta_boton ( string etiqueta,  string evento )
event csd_envio ( )
event csd_cambio_estado ( )
event csd_abonar ( string tipo )
event csd_cobrar_musaat ( )
event csd_garantias_pendientes ( )
event csd_musaat_funcionario ( )
event csd_tabs ( )
event csd_configura_insercion ( )
event csd_comprobar_avisos_incidencias ( string evento )
event csd_configura_color_opciones ( )
event csd_registros_vinculados ( )
event csd_retrieve_exp ( )
event csd_obra_replicada ( )
event csd_cobrar_gastos ( )
event csd_reparos_pendientes ( )
event csd_hoja_ayto ( )
event csd_alta_musaat ( )
event csd_comprobar_incidencias_col_cli ( string tipo )
event csd_comprobar_nvisado ( )
event csd_aviso_no_musaat_colectivo ( )
event type integer csd_facturar ( string param )
integer x = 37
integer y = 128
integer width = 4352
integer height = 896
integer taborder = 20
string dataobject = "d_fases_detalle"
boolean minbox = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_1::csd_modificacion_datos(string idfase, u_dw dw, string nombre_dw, string campo, long row);// Actualiza los datos modificados en la tabla "modificaciones"
// ------------------------------------------------------------
string  fase, modificacion, data, tipo
integer fila

// Le quitamos el n$$HEX2$$ba002000$$ENDHEX$$de filas al nombre del tab que lo lleve
if PosA(nombre_dw, '(') > 0 then nombre_dw = LeftA(nombre_dw, PosA(nombre_dw, '(')-2)

// Se devuelve un valor campo de la DW segun sea el tipo de dato
tipo=dw.Describe(campo+".ColType")
if tipo='!' then return // Define un tipo constanste

data=''
CHOOSE CASE upper(LeftA(tipo ,2))
	CASE 'CH' // Tipo 'String'
		data=dw.getitemstring(row,campo)
	CASE 'DA' // Tipo 'DateTime'
		data=string(dw.getitemdatetime(row,campo),'dd/mm/yyyy')
	CASE ELSE // queda 'Number'
      data=string(dw.getitemnumber(row,campo))
END CHOOSE

if f_es_vacio(data) then data=''   // return

// David 13/03/2006 - Excepci$$HEX1$$f300$$ENDHEX$$n: Para Guadalajara, cuando se modifica el campo del texto de un reparo que obtenga 
// el valor anterior de la BD para que no coja el texto inicial que no ha introducido el usuario
if g_colegio = 'COAATGU' and nombre_dw = 'REPAROS' and campo = 'texto' then
	string id_reparo, texto
	id_reparo = dw.getitemstring(row,'id_reparo')
	SELECT fases_reparos.texto  INTO :texto FROM fases_reparos WHERE fases_reparos.id_reparo = :id_reparo  ;
	if isnull(texto) then texto = ''
	data = texto
end if


//se a$$HEX1$$f100$$ENDHEX$$ade un registro a modificaci$$HEX1$$f300$$ENDHEX$$n de datos
if g_recien_grabado_modificacion_fases=TRUE then
	idw_fases_modificacion_datos.triggerevent("pfc_addrow")
end if

//Debido a que hay una DW que no es de Fases se coloca el tipo_modulo al que pertenece
//if nombre_dw = Upper('dw_fases_datos_exp') then
//	idw_fases_modificacion_datos.triggerevent("pfc_addrow")
//   idw_fases_modificacion_datos.setitem(idw_fases_modificacion_datos.rowcount(),'tipo_modulo','02')
//end if
//David - 22/11/2004 : Para que se muestren los cambios desde esta ventana

fila        =idw_fases_modificacion_datos.rowcount()
fase        =idfase
if fila>0 then
	modificacion=idw_fases_modificacion_datos.getitemstring(fila,'modificacion')
end if
// se concatenan las modificaciones con la anterior
if isnull(modificacion) then modificacion = ''
if LeftA(nombre_dw,6) = 'MUSAAT' or LeftA(nombre_dw,7) = 'DETALLE' or LeftA(nombre_dw,7) = 'EXPEDIE' then
	modificacion = modificacion + nombre_dw + ' ' + campo + '=' + data + '; '	
else
	modificacion = modificacion + nombre_dw + ' (' + string(row) + ') ' + campo + '=' + data + '; '
end if

// Se actualiza la dw de modificaciones oculta
idw_fases_modificacion_datos.setitem(fila,'id_colegiado',fase)
idw_fases_modificacion_datos.setitem(fila,'modificacion',modificacion)
idw_fases_modificacion_datos.setitem(fila,'fecha',datetime(today(),now()))
idw_fases_modificacion_datos.setitem(fila,'usuario',g_usuario)

if  i_nuevo then
	idw_fases_modificacion_datos.triggerevent("pfc_addrow")
	fila   =idw_fases_modificacion_datos.rowcount()
	fase =idfase
	idw_fases_modificacion_datos.setitem(fila,'id_colegiado',fase)
	idw_fases_modificacion_datos.setitem(fila,'modificacion','CREACION CONTRATO   ')
	idw_fases_modificacion_datos.setitem(fila,'fecha',datetime(today(),now()))
	idw_fases_modificacion_datos.setitem(fila,'usuario',g_usuario)
end if

g_recien_grabado_modificacion_fases=FALSE



this.TriggerEvent('csd_control_estados')

end event

event dw_1::csd_fases_otras_fases;idw_fases_otras_fases.retrieve(dw_1.getitemstring(1,'id_expedi'),dw_1.getitemstring(1,'id_fase'))
end event

event dw_1::csd_recupera_posicion(string campo);dw_1.setcolumn(campo)
		
end event

event dw_1::csd_insertar_lineas_nuevas();string estado

estado = this.GetItemString(1,'estado')
// Si el estado es preasignado entonces rellenamos las filas vac$$HEX1$$ed00$$ENDHEX$$as autom$$HEX1$$e100$$ENDHEX$$ticamente
if estado = g_fases_estados.preasignado then
	if idw_fases_colegiados.RowCount()=0 then
		idw_fases_colegiados.Event pfc_addrow()
	end if
	if idw_fases_promotores.RowCount()=0 then
		idw_fases_promotores.Event pfc_addrow()
	end if
	if idw_fases_estadistica.RowCount()=0 then
		idw_fases_estadistica.Event pfc_addrow()
	end if	
	if g_colegio = 'COAATTFE' or g_colegio = 'COAATCU' or g_colegio = 'COAATZ' or g_colegio = 'COAATGU' or g_colegio = 'COAATLE' or g_colegio = 'COAATAVI' or g_colegio = 'COAATTER' then
		if idw_fases_cip_tfe.RowCount()=0 then
			idw_fases_cip_tfe.Event pfc_addrow()
		end if
	end if
end if

end event

event dw_1::csd_habilitar_certificaciones();// Si no es O.O. o es seguridad no se debe poder cobrar por certificaciones
if dw_fases_datos_exp.rowcount()>0 then
	
if dw_fases_datos_exp.getitemstring(1, 'administracion') <> 'S' or LeftA(this.getitemstring(1,'fase'), 1) = '0' then
	this.object.aplicado_10.visible = false
	this.object.b_musaat.visible = false
	return
else
	this.object.aplicado_10.visible = true
end if

if g_obra_admin_cgc_aplica_10 = 'N' then
	this.object.b_musaat.visible = false
else
	this.object.b_musaat.visible = true
end if
end if
end event

event dw_1::csd_marcar_certificaciones();// Si no es O.O. o es seguridad no se debe poder cobrar por certificaciones
if dw_fases_datos_exp.getitemstring(1, 'administracion') <> 'S' or LeftA(this.getitemstring(1,'fase'), 1) = '0' then
	this.setitem(1, 'aplicado_10', 'N')
	this.object.aplicado_10.visible = false
	this.object.b_musaat.visible = false
	return
else
	this.object.aplicado_10.visible = true
end if

if g_obra_admin_cgc_aplica_10 = 'N' then
	this.object.b_musaat.visible = false
else
	this.object.b_musaat.visible = true
end if

if g_obra_admin_cgc = 'N' and  this.getitemstring(1, 'tipo_gestion') = 'C' then
		this.setitem(1, 'aplicado_10', 'N')	
		return
end if

if g_obra_admin_sgc = 'N' and  this.getitemstring(1, 'tipo_gestion') = 'P' then
		this.setitem(1, 'aplicado_10', 'N')	
		return
end if

if g_obra_admin_cgc = 'S' and  this.getitemstring(1, 'tipo_gestion') = 'C' then
		this.setitem(1, 'aplicado_10', 'S')	
		return
end if

if g_obra_admin_sgc = 'S' and  this.getitemstring(1, 'tipo_gestion') = 'P' then
		this.setitem(1, 'aplicado_10', 'S')	
		return
end if

end event

event dw_1::csd_inserta_boton;int fila

//Si en la botonera tiene lineas es que ya las hemos introducido anteriormente
//por tanto no hace falta volverlas a introducir

fila = dw_fases_botones.InsertRow(0)
dw_fases_botones.SetItem(fila,'evento',evento)
dw_fases_botones.SetItem(fila,'etiqueta',etiqueta)
dw_fases_botones.height=dw_fases_botones.height + 84
end event

event dw_1::csd_envio();openwithparm(w_envios, dw_1.getitemstring(1, 'id_fase'))// Modificado Ricardo 2004-08-13

end event

event dw_1::csd_cambio_estado();string nuevo_estado
datetime fecha

nuevo_estado = dw_1.GetItemString(1,'estado')
fecha = datetime(Today(), now())
//A$$HEX1$$f100$$ENDHEX$$adimos l$$HEX1$$ed00$$ENDHEX$$nea al hist$$HEX1$$f300$$ENDHEX$$rico de estados
idw_fases_estados.InsertRow(1)
//idw_fases_estados.SetItem(1,'id_fase_estado',f_siguiente_numero('FASES_ESTADOS',10))
idw_fases_estados.setitem(1,'id_fase',dw_1.getitemstring(1,'id_fase'))
idw_fases_estados.setitem(1,'estado',nuevo_estado) 
idw_fases_estados.setitem(1,'fecha',fecha)
idw_fases_estados.setitem(1,'usuario',g_usuario)	

idw_fases_estados.update()
end event

event dw_1::csd_abonar(string tipo);st_control_eventos c_evento

if tipo = "AP" then
	c_evento.evento = 'ABONAR_PARCIAL'
	c_evento.dw = dw_1
	if f_control_eventos(c_evento)=-1 then return
end if

if tipo = "AT" then
	c_evento.evento = 'ABONAR_TOTAL'
	c_evento.dw = dw_1
	if f_control_eventos(c_evento)=-1 then return
	
	this.setitem(1,'f_abono',datetime(today(),now()))
end if

CHOOSE CASE g_colegio
	CASE 'COAATTFE'
		if f_es_vacio(dw_1.getitemstring(1, 'archivo_fase')) then
			c_evento.evento = 'NUMERO_SAL'
			f_control_eventos(c_evento)
		//comentado ley omnibus scp-606
	//		dw_1.setitem(1, 'archivo_fase', f_numera_salida(c_evento.param1)) // Modificado Ricardo 2005-05-11 -> SE le pasa el formato directamente
		end if
	CASE 'COAATGC'
		if f_es_vacio(dw_fases_datos_exp.getitemstring(1, 'archivo_exp')) then
			c_evento.evento = 'NUMERO_SAL'
			f_control_eventos(c_evento)
	//comentado ley omnibus scp-606
//			dw_fases_datos_exp.setitem(1, 'archivo_exp',	f_numera_salida(c_evento.param1)) // Modificado Ricardo 2005-05-11 -> SE le pasa el formato directamente
		end if
END CHOOSE

this.update()
dw_fases_datos_exp.update()

//event csd_cambio_estado()

end event

event dw_1::csd_cobrar_musaat();int existe, i, hay
boolean cobrar = true
string id_expedi, id_col, id_fase, descuento
double importe

// NO debe aparecer la ventana de cobrar musaat cuando:
// 1 - Es obra administracion
if dw_fases_datos_exp.getitemstring(1, 'administracion')='S' then cobrar = false
// 2 - Si es un tipo de intervenci$$HEX1$$f300$$ENDHEX$$n de calidad y ya existe una direcci$$HEX1$$f300$$ENDHEX$$n en el expediente
id_expedi = this.getitemstring(1, 'id_expedi')
SELECT count(*) INTO :existe FROM fases WHERE ( fases.id_expedi = :id_expedi ) AND ( fases.fase like '1%' ) ;
if LeftA(this.getitemstring(1, 'fase'), 1) = '3' and existe > 0 then cobrar = false
// 3 - Si ya se ha visado anteriormente y se ha cobrado a el/los colegiado/s
hay = 0
id_fase = this.getitemstring(1, 'id_fase')
for i = 1 to idw_fases_colegiados.rowcount()
	id_col = idw_fases_colegiados.getitemstring(i, 'id_col')
	if f_tiene_movi_musaat(id_fase, id_col, false) and f_total_movi_musaat_col (id_fase, id_col) > 1 then 
		hay += 0
	else
		hay += 1
	end if
next
// 4 - Si en descuentos musaat = 0 o no aparece la linea
hay = 0
for i = 1 to idw_fases_informes.rowcount()
	descuento = idw_fases_informes.getitemstring(i, 'tipo_informe')
	importe = idw_fases_informes.getitemnumber(i, 'cuantia_colegiado')
	if descuento = g_codigos_conceptos.musaat_variable and importe > 0 then 
		hay += 1
	else
		hay += 0
	end if
next
if hay = 0 then cobrar = false

//if cobrar then open(w_cobrar_musaat)
if cobrar then open(w_fases_cobrar_gastos)

end event

event dw_1::csd_garantias_pendientes;idw_fases_garantias.postevent('csd_garantias_pendientes')
end event

event dw_1::csd_musaat_funcionario();int i
boolean hay = false
string t_visado, obra_oficial

// Si hay colegiados funcionarios y es obra administracion se generan "movimientos musaat funcionarios"
for i=1 to idw_fases_colegiados.rowcount()
	if idw_fases_colegiados.getitemstring(i, 'facturado') = 'S' then hay = true
next

// Se debe comprobar antes si existe un movimiento de musaat de tipo 1.4
for i = 1 to idw_fases_src.rowcount()
	t_visado = idw_fases_src.getitemstring(i, 't_visado')
	obra_oficial = idw_fases_src.getitemstring(i, 'obra_oficial')	
	if t_visado = '1' and obra_oficial = '4' then
		hay = false
	end if
next

if hay and idw_fases_datos_exp.getitemstring(1, 'administracion') = 'S' then open(w_musaat_funcionario)




end event

event dw_1::csd_tabs();if PosA(tab_1.tabpage_9.text, '(') = 0 then i_tab_of = tab_1.tabpage_9.text
if PosA(tab_1.tabpage_13.text, '(') = 0 then i_tab_mu = tab_1.tabpage_13.text
if PosA(tab_1.tabpage_14.text, '(') = 0 then i_tab_mi = tab_1.tabpage_14.text
if PosA(tab_1.tabpage_4.text, '(') = 0 then i_tab_re = tab_1.tabpage_4.text
if PosA(tab_1.tabpage_3.text, '(') = 0 then i_tab_od = tab_1.tabpage_3.text
if PosA(tab_1.tabpage_11.text, '(') = 0 then i_tab_es = tab_1.tabpage_11.text
if PosA(tab_1.tabpage_15.text, '(') = 0 then i_tab_fo = tab_1.tabpage_15.text
if PosA(tab_1.tabpage_10.text, '(') = 0 then i_tab_no = tab_1.tabpage_10.text

end event

event dw_1::csd_configura_insercion();string tipo_act, tipo_obra, destino, cod_comb, campo
int i, col

dw_1.accepttext()

tipo_act = this.getitemstring(1,'fase')
tipo_obra = this.getitemstring(1,'tipo_trabajo')
destino = this.getitemstring(1,'trabajo')

long cuantos
select count(configura_insercion.cod_comb) 
into :cuantos
from configura_insercion;

if cuantos <= 0 then return 

if not f_es_vacio(tipo_act) and not f_es_vacio(tipo_obra) and not f_es_vacio(destino) then
	// Seleccionamos la combinacion de campos seg$$HEX1$$fa00$$ENDHEX$$n el tipo act, el tipo obra y el destino
	SELECT configura_insercion.cod_comb
	INTO :cod_comb
	FROM configura_insercion
	WHERE ( :tipo_act like configura_insercion.tipo_act or configura_insercion.tipo_act = '%' ) and
			( :tipo_obra like configura_insercion.tipo_obra or configura_insercion.tipo_obra = '%' ) and
			( :destino like configura_insercion.destino or configura_insercion.destino = '%' )  ;

	datastore ds_conf
	ds_conf = create datastore						
	ds_conf.dataobject = 'ds_configura_campos'
	ds_conf.settransobject(sqlca)		
	ds_conf.retrieve(cod_comb)
	// Si no est$$HEX2$$e1002000$$ENDHEX$$esa combinaci$$HEX1$$f300$$ENDHEX$$n lo dejamos todo accesible
	if ds_conf.rowcount() <= 0 then 
		col = integer(idw_fases_estadistica.Object.DataWindow.Column.Count)
		for i = 1 to col
			campo = idw_fases_estadistica.Describe("#"+string(i)+".Name")
			idw_fases_estadistica.modify(campo+".protect = 0")
			idw_fases_estadistica.modify(campo+".background.color = " + string(f_color_blanco()))			
		next
	end if
	if ds_conf.rowcount() <= 0 then 
		destroy ds_conf
		return
	end if
	// Recorremos todas las columnas de la tabla
	col = integer(ds_conf.Object.DataWindow.Column.Count)
	for i = 1 to col
		campo = ds_conf.Describe("#"+string(i)+".Name")
		// Si para la columna el valor es 'N' se deshabilita el campo
		if ds_conf.getitemstring(1, campo) = 'N' then
			idw_fases_estadistica.modify(campo+".protect = 1")
			idw_fases_estadistica.modify(campo+".background.color = " + string(f_color_windows_buttonface()))
		else
			idw_fases_estadistica.modify(campo+".protect = 0")
			idw_fases_estadistica.modify(campo+".background.color = " + string(f_color_blanco()))
		end if
	next
	destroy ds_conf
end if

end event

event dw_1::csd_comprobar_avisos_incidencias(string evento);// Evento que se utiliza desde el cotrol de eventos para comprobar si hay incidencias marcadas con el check de avisar
// Si hay incidencias de este tipo, se nos indica en evento el nombre que debe pasarse para lanzar la ventana de incidencias

long cuantos
string id_fase

// Cogemos el identificador del contrato
id_fase=dw_1.getitemstring(1,'id_fase')

// Contamos si hay incidencias con el check de avisar marcado
SELECT count(*)
 into :cuantos
 FROM incidencias_fases, incidencias_expedientes
WHERE incidencias_fases.codigo = incidencias_expedientes.codigo and
                incidencias_expedientes.aviso = 'S' and
                incidencias_fases.id_fase = :id_fase;

// Si hay incidencias lanzamos el evento indicado para que abra la ventana
if cuantos>0 then
        // LAnzamos el evento
        dw_fases_botones. postevent (evento)
end if

end event

event dw_1::csd_configura_color_opciones();// Si tiene incidencias de contrato sale en naranja sino
// Si el expediente tiene incidencias ponemos el bot$$HEX1$$f300$$ENDHEX$$n de opciones
// de color rojo y si tiene expedientes relacionados de color verde
string exp, fase

exp = this.GetItemString(1, 'id_expedi')
fase = this.GetItemString(1, 'id_fase')

if f_comprueba_incidencias(4, dw_1) then
	dw_1.object.b_opciones.Background.color=f_color_naranja()
else
	if f_comprueba_incidencias(3, dw_fases_datos_exp) then
		dw_1.object.b_opciones.Background.color=f_color_rojo()
	else
		if f_comprueba_exped_relacionados(exp) then
			dw_1.object.b_opciones.Background.color=f_color_verde_oscuro()
		else
			dw_1.object.b_opciones.Background.color=f_color_windows_buttonface()
		end if
	end if
end if

// Ahora adem$$HEX1$$e100$$ENDHEX$$s del color del bot$$HEX1$$f300$$ENDHEX$$n de opciones
// Vamos a colorear el bot$$HEX1$$f300$$ENDHEX$$n de incidencias o exped. relac seg$$HEX1$$fa00$$ENDHEX$$n corresponda
int linea_i, linea_e, linea_c, linea_r

linea_i = dw_fases_botones.find("evento =  '"+"csd_incidencias"+"'",1,dw_fases_botones.rowCount())
linea_e = dw_fases_botones.find("evento =  '"+"csd_antecedentes"+"'",1,dw_fases_botones.rowCount())
linea_c = dw_fases_botones.find("evento =  '"+"csd_incidencias_fases"+"'",1,dw_fases_botones.rowCount())
linea_r = dw_fases_botones.find("evento =  '"+"csd_regularizacion"+"'",1,dw_fases_botones.rowCount())

if f_comprueba_incidencias(3, dw_fases_datos_exp) then
	dw_fases_botones.setitem(linea_i, 'color', 255)
else
	dw_fases_botones.setitem(linea_i, 'color', f_color_windows_buttonface())
end if
if f_comprueba_exped_relacionados(exp) then
	dw_fases_botones.setitem(linea_e, 'color', 5940570)
else
	dw_fases_botones.setitem(linea_e, 'color', f_color_windows_buttonface())	
end if
if f_comprueba_incidencias(4, dw_1) then
	dw_fases_botones.setitem(linea_c, 'color', 2978303)
else
	dw_fases_botones.setitem(linea_c, 'color', f_color_windows_buttonface())
end if
if f_comprueba_regularizacion(fase) then
	dw_fases_botones.setitem(linea_r, 'color', 11206655)
else
	dw_fases_botones.setitem(linea_r, 'color', f_color_windows_buttonface())	
end if

end event

event dw_1::csd_registros_vinculados();if idw_fases_registros.rowcount() <= 0 then return

messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_valor_contrato_vinculados','Este contrato tiene registros vinculados'))

end event

event dw_1::csd_retrieve_exp();// Provisional
dw_fases_datos_exp.retrieve(this.getitemstring(1, 'id_expedi'))
end event

event dw_1::csd_obra_replicada();// Permite detectar si existen obras iguales en cuanto a promotor, presupuesto y tipo de actuacion
// CREADO POR RICARDO 04-06-24
// 
//              Requiere que est$$HEX2$$e9002000$$ENDHEX$$guardado en BBDD para que funcione perfectamente

string sql_nuevo, lista_promotores = '', id_cliente, fase, id_fase, lista_num_reg
double pem
long fila, fila_proceso, fila_promotor, cuantos_promotores = 0
datastore ds_fases_comprobar_replicas
boolean b_encontrado = false
string emplazamiento,n_calle,puerta

// obtenemos un listado de id_clientes que sean promotores
FOR fila = 1 TO idw_fases_promotores.rowcount()
	if idw_fases_promotores.getitemstring(fila, 'promotor') = 'S' then
		id_cliente = idw_fases_promotores.getitemstring(fila, 'id_cliente')
		if not f_es_vacio(id_cliente) then  
			if LenA(lista_promotores)>0 then lista_promotores += ", "
			lista_promotores += "'"+id_cliente+"'"
			cuantos_promotores++
		end if
	end if
NEXT

if LenA(lista_promotores)>0 then 
	// Si hay promotores... pillamos el resto de valores y comprobamos
	pem = idw_fases_estadistica.getitemNumber(idw_fases_estadistica.GetRow(), 'pem')
	fase = dw_1.getitemString(dw_1.GetRow(), 'fase')
	id_fase = dw_1.getitemString(dw_1.GetRow(), 'id_fase')
	emplazamiento = dw_1.getitemString(dw_1.GetRow(), 'emplazamiento')	
	n_calle = dw_1.GetItemString(dw_1.GetRow(),'n_calle')
	puerta = dw_1.GetItemString(dw_1.GetRow(),'puerta')
	// Creamos el datastore
	ds_fases_comprobar_replicas = create datastore
	ds_fases_comprobar_replicas.dataobject = 'd_fases_comprobar_replicas'
	ds_fases_comprobar_replicas.settransobject(SQLCA)
	
	// Realizamos la consulta
	sql_nuevo = ds_fases_comprobar_replicas.describe("datawindow.table.select")     
	sql_nuevo += " and fases.id_fase <> '"+id_fase+"'"
	sql_nuevo += " and fases.fase = '"+fase+"'"
	if(g_colegio='COAATTGN' or g_colegio='COAATTEB' or g_colegio ='COAATMCA' or g_colegio ='COAATLL' )then
		if not isnull(emplazamiento) then sql_nuevo += " and fases.emplazamiento = '"+emplazamiento+"'"
		if not isnull(n_calle) then sql_nuevo += " and fases.n_calle = '"+n_calle+"'"		
		if not isnull(puerta) then sql_nuevo += " and fases.puerta = '"+puerta+"'"		
	end if
	
	
	sql_nuevo += " and fases_clientes.promotor = 'S' and fases_clientes.id_cliente in ("+lista_promotores+") "
	ds_fases_comprobar_replicas.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
	ds_fases_comprobar_replicas.retrieve(pem)
	
	// Bucle
	FOR fila_proceso = 1 to ds_fases_comprobar_replicas.RowCount()
		// Fila proceso
		id_fase = ds_fases_comprobar_replicas.Getitemstring(fila_proceso, 'id_fase')
		// Aplicamos un filtro
		ds_fases_comprobar_replicas.setfilter("id_fase ='"+id_fase+"'")
		ds_fases_comprobar_replicas.filter()
		if ds_fases_comprobar_replicas.RowCount() = cuantos_promotores then
			// Mismo numero de promotores... a ver los id's... grrr
			FOR fila = 1 TO idw_fases_promotores.rowcount()
				if idw_fases_promotores.getitemstring(fila, 'promotor') = 'S' then
					id_cliente = idw_fases_promotores.getitemstring(fila, 'id_cliente')
					b_encontrado = false
					FOR fila_promotor = 1 to ds_fases_comprobar_replicas.RowCount()
						if id_cliente =  ds_fases_comprobar_replicas.getitemstring(fila_promotor, 'id_cliente') then
							b_encontrado = true
							exit
						end if
					NEXT
					// si no ha encontrado un cliente concreto salimos del bucle, contratos distintos
					if not b_encontrado then exit
				end if
				if not b_encontrado then exit
			NEXT
			if b_encontrado then
				// ES que son iguales, apuntamos el numero para mostrarlo luego
				if LenA(lista_num_reg)>0 then lista_num_reg = lista_num_reg+cr
				lista_num_reg += ds_fases_comprobar_replicas.getitemstring(fila_promotor, 'n_registro')
			end if 
		end if
                
		// Nos saltamos los que ya hemos mirado
		fila_proceso += ds_fases_comprobar_replicas.RowCount()
		// Quitamos el filtro
		ds_fases_comprobar_replicas.setfilter("")
		ds_fases_comprobar_replicas.filter()
	NEXT
        
	// Destruimos el datastore
	destroy ds_fases_comprobar_replicas
	
	if LenA(lista_num_reg)>0 then 
		if(g_colegio='COAATTGN' or g_colegio='COAATTEB' or g_colegio ='COAATMCA' or g_colegio= 'COAATLL')then
		Messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_contrato_coincide_presupuesto',"Este contrato coincide en presupuesto, tipo de actuaci$$HEX1$$f300$$ENDHEX$$n, promotores y emplazamiento con la siguiente lista de contratos : ")+cr+lista_num_reg)						
		else
			Messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_contrato_coincide_presupuesto',"Este contrato coincide en presupuesto, tipo de actuaci$$HEX1$$f300$$ENDHEX$$n y promotores con la siguiente lista de contratos : ")+cr+lista_num_reg)
		end if

	end if  
end if



end event

event dw_1::csd_cobrar_gastos();open(w_fases_cobrar_gastos)
end event

event dw_1::csd_reparos_pendientes();idw_fases_reparos.postevent('csd_reparos_pendientes')
end event

event dw_1::csd_hoja_ayto();// INC. 8758 Oficio COAATGC

// S$$HEX1$$f300$$ENDHEX$$lo para estos tipos de actuaci$$HEX1$$f300$$ENDHEX$$n
string tipo_act
tipo_act = this.getitemstring(1, 'fase')
if tipo_act<>'01' and tipo_act<>'02' and tipo_act<>'03' and tipo_act<>'11' and tipo_act<>'14' then return

// Abrimos la ventana de la previsualizaci$$HEX1$$f300$$ENDHEX$$n del oficio
open(w_preview_oficio)

end event

event dw_1::csd_alta_musaat();int i, j
double importe_musaat
string id_fase, tipo_movimiento_csd, id_col
st_musaat_datos st_musaat_datos

if g_colegio = 'COAATTER' then
	st_control_eventos c_evento
	if f_es_vacio(this.getitemstring(1,'archivo_fase')) then
		c_evento.evento = 'NUMERO_SAL'
		f_control_eventos(c_evento)
		this.setitem(1,'archivo_fase',f_numera_salida(c_evento.param1))
	end if
end if
// Generamos el movimiento de alta para cada colegiado
for i = 1 to idw_fases_colegiados.rowcount()
	id_fase =  dw_1.getitemstring(1, 'id_fase')
	st_musaat_datos.n_visado = id_fase
	st_musaat_datos.recuperar = true
	st_musaat_datos.genera_movi = true

	id_col = idw_fases_colegiados.getitemstring(i, 'id_col')
	st_musaat_datos.id_col = id_col
	st_musaat_datos.cobertura = 0 // ICT-65	
	//Luis ICT-177
	if(idw_fases_colegiados.getitemstring(i, 'facturado') = 'S' and g_colegio = 'COAATTER') then
		st_musaat_datos.genera_movi = false
	end if
	//fin cambio
	if idw_fases_datos_exp.getitemstring(1, 'administracion') = 'N' then
		st_musaat_datos.tipo_csd = '10'
	else
		st_musaat_datos.tipo_csd = '12'
	end if
	
	if f_colegiado_tipopersona(id_col) = 'S' then	
		f_musaat_calcula_prima_sociedad(st_musaat_datos)
		importe_musaat = st_musaat_datos.prima_comp	
	else
		f_musaat_calcula_prima(st_musaat_datos)	
		importe_musaat = st_musaat_datos.prima_comp		
	end if
		
	if isnull(importe_musaat) then importe_musaat = 0
next

idw_fases_src.retrieve(id_fase)

end event

event dw_1::csd_comprobar_incidencias_col_cli(string tipo);long i

if tipo='P' then
	for i=1 to idw_fases_promotores.rowcount()
		f_control_de_incidencias('P',idw_fases_promotores.GetItemString(i,'id_cliente'))
	next
else	
	for i=1 to idw_fases_colegiados.rowcount()
		f_control_de_incidencias('C',idw_fases_colegiados.GetItemString(i,'id_col'))
	next
end if
end event

event dw_1::csd_comprobar_nvisado();//COAM-30
// FUNCION QUE COMPRUEBA SI EXISTE UNA ACTUACION DE COORDINACION O DIRECCION
// PARA UTILIZAR EL MISMO NUMERO DE VISADO 
string id_fase,id_fase2,t_act,id_expedi,archivo,archivo2,texto,tramite
st_control_eventos c_evento
datetime f_visado

id_fase=dw_1.GetItemString(dw_1.GetRow(),'id_fase')
id_expedi=dw_1.GetItemString(dw_1.GetRow(),'id_expedi')			
t_act=dw_1.GetItemString(dw_1.GetRow(),'fase')
f_visado=dw_1.GetItemDateTime(dw_1.GetRow(),'f_visado')
if left(t_act,1)='1' then
	select archivo,id_fase into :archivo,:id_fase2 from fases 
	where id_expedi=:id_expedi and id_fase<>:id_fase and fase like '0%'  order by f_visado desc;				
	texto="coordinaci$$HEX1$$f300$$ENDHEX$$n"
end if
if left(t_act,1)='0' then
	select archivo,id_fase into :archivo,:id_fase2 from fases 
	where id_expedi=:id_expedi and id_fase<>:id_fase and fase like '1%'  order by f_visado desc;				
	texto="direcci$$HEX1$$f300$$ENDHEX$$n"
end if
tramite= this.getitemstring(1, 'id_tramite')
if  tramite <> 'REDAP' then
	if not f_es_vacio(archivo) then
		if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ya existe una intervenci$$HEX1$$f300$$ENDHEX$$n de "+texto+" visada. $$HEX1$$bf00$$ENDHEX$$Desea traer ese mismo n$$HEX1$$fa00$$ENDHEX$$mero de visado?",Question!,YesNo!)=1 then
			dw_1.SetItem(dw_1.GetRow(),'archivo_fase',archivo)
		end if	
	end if

if f_es_vacio(dw_1.GetItemString(dw_1.GetRow(),'archivo_fase')) then
	c_evento.evento = 'NUMERO_SAL'
	f_control_eventos(c_evento)
	//if dw_1.GetItemString(dw_1.GetRow(),'id_tramite')="0000000009" or dw_1.GetItemString(dw_1.GetRow(),'id_tramite')="0000000008"  then 
	//archivo2=f_numera_salida(c_evento.param1)
	//dw_1.SetItem(dw_1.GetRow(),'archivo_fase',archivo2)
	//end if
	// Si hay una fase  sin n$$HEX2$$ba002000$$ENDHEX$$de visado, preguntamos para copiarlo
	if not(f_es_vacio(id_fase2)) and f_es_vacio(archivo) then
		if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","$$HEX1$$bf00$$ENDHEX$$Desea visar la intervenci$$HEX1$$f300$$ENDHEX$$n de "+texto+" con el mismo n$$HEX1$$fa00$$ENDHEX$$mero de visado?",Question!,YesNo!)=1 then
			update fases set archivo=:archivo2,estado='03',f_visado=:f_visado where id_fase=:id_fase2;	
		end if	

	end if
end if
end if
end event

event dw_1::csd_aviso_no_musaat_colectivo();int i
string id_colegiado, mensaje, nom_col
for i=1 to idw_fases_colegiados.RowCount()
	id_colegiado = idw_fases_colegiados.GetItemString(i,'id_col')
	nom_col = idw_fases_colegiados.GetItemString(i,'n_col')
	if f_colegiado_tipopersona(id_colegiado) = 'P' then
		choose case f_tipo_alta_src(id_colegiado)
			case 'S'
					if not(f_tiene_musaat_src(id_colegiado)) then 
						mensaje = mensaje + 'MUSAAT :' + CR + '     ' + 'El colegiado ' + nom_col + ' no tiene SRC de MUSAAT.' + cr + cr
					else
						if(f_fecha_baja_musaat_src(id_colegiado))then
							mensaje = mensaje + 'MUSAAT :' + CR + '     ' + 'El colegiado ' + nom_col + ' ha sobrepasado la fecha de baja SRC de MUSAAT.' + cr + cr
						end if
					end if
			case 'O'
				mensaje = mensaje + 'SRC :' + CR + '     ' + 'El colegiado ' + nom_col + ' tiene SRC distinta de MUSAAT.' + cr + cr
			case else
				mensaje = mensaje + 'SRC :' + CR + '     ' + 'El colegiado ' + nom_col + ' no tiene SRC.' + cr + cr
		end choose
	end if
	string t_poliza
	select src_t_poliza into :t_poliza from musaat where id_col = :id_colegiado;
	if t_poliza = '02' then mensaje = mensaje + 'SRC :' + CR + '     ' + 'El colegiado ' + nom_col + ' tiene p$$HEX1$$f300$$ENDHEX$$liza colectiva.' + cr + cr
next

if mensaje <> '' then Messagebox(g_titulo,mensaje,Exclamation!)	
end event

event type integer dw_1::csd_facturar(string param);// SCP-647 Alta inicial evento
st_fases_consulta datos_fase
st_control_eventos c_evento
string id_fase, visared
boolean gastos

SetPointer(HourGlass!)
id_fase = dw_1.GetItemString(1,'id_fase')

datos_fase.id_fase = dw_1.GetItemString(1,'id_fase')
datos_fase.tipo_gestion = dw_1.GetItemString(1,'tipo_gestion')
datos_fase.proforma = param
datos_fase.tipo_tramite = dw_1.GetItemString(1,'id_tramite')


OpenWithParm(w_factufase_facturar,datos_fase)

datos_fase = Message.PowerObjectParm

idw_fases_minutas.SetRedraw(FALSE)
//idw_fases_liquidaciones.SetRedraw(FALSE)
idw_fases_colegiados.SetRedraw(FALSE)
idw_fases_promotores.SetRedraw(FALSE)
idw_fases_src.SetRedraw(FALSE)
idw_fases_pagos_plataforma.SetRedraw(FALSE)
idw_fases_pagos_facturas.SetRedraw(FALSE)

idw_fases_minutas.Retrieve(id_fase)
//idw_fases_liquidaciones.Retrieve(id_fase)
idw_fases_colegiados.Retrieve(id_fase)
idw_fases_promotores.Retrieve(id_fase)
idw_fases_src.retrieve(id_fase)
idw_fases_pagos_plataforma.retrieve(id_fase)
tab_1.event csd_poner_titulo()

/* SCP-647 c_evento.estado = datos_fase.estado
c_evento.evento = 'POST_FACTURAR'
c_evento.dw = dw_1
f_control_eventos(c_evento)*/

idw_fases_minutas.SetRedraw(TRUE)
idw_fases_colegiados.SetRedraw(TRUE)
idw_fases_promotores.SetRedraw(TRUE)
idw_fases_src.SetRedraw(TRUE)
idw_fases_pagos_plataforma.SetRedraw(TRUE)
idw_fases_pagos_facturas.SetRedraw(TRUE)

parent.Event pfc_save()

SetPointer(Arrow!)

///*** SCP-1126. Cuando factura correctamente no devuelve una estructura correcta a datos_fase. Devolver$$HEX2$$e1002000$$ENDHEX$$1 ***///
///*** Cuando se pulsa a salir devuelve una estructura a datos_fase y devolver$$HEX2$$e1002000$$ENDHEX$$-1 para no actualizar los checks de facturado ***///
if isvalid(datos_fase) then return -1

return 1

end event

event dw_1::csd_retrieve;call super::csd_retrieve;int    retorno
double i

if g_fases_consulta.id_fase = '' or isnull(g_fases_consulta.id_fase) then return
retorno = parent.event closequery()
if retorno = 1 then return

this.retrieve(g_fases_consulta.id_fase)

g_id_fase=g_fases_consulta.id_fase
g_fases_consulta.id_fase=''

parent.postevent('csd_desglose_honos')
this.PostEvent('csd_control_estados')
this.PostEvent('csd_tabs')
tab_1.post event csd_poner_titulo()

event csd_configura_color_opciones()
event csd_configura_insercion()

// Quitado por Paco 10/02/2006
// Como no lo hace por si mismo, le forzamos
//idw_fases_reclamaciones.PostEvent('csd_enlaza')

end event

event dw_1::buttonclicked;call super::buttonclicked;int i
string pob,sello,id_fase, ls_anterior

id_fase=dw_1.GetItemString(dw_1.GetRow(),'id_fase')

CHOOSE CASE dwo.name

	CASE 'bb_poblacion'
		st_busqueda_poblaciones lst_busq_pob
		lst_busq_pob.cod_provincia =  '000' + g_cod_prov_colegio
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		ls_anterior = g_bloqueo_fases
		g_bloqueo_fases = 'S'
		openwithparm(w_busqueda_poblaciones,lst_busq_pob)
		g_bloqueo_fases = ls_anterior
		pob = Message.StringParm
		if f_es_vacio(pob) then return
		this.SetItem(1,'poblacion',pob)

	CASE 'b_musaat'
		string t_visado, obra_oficial
		boolean bl_generar_10 = true, bl_facturar_10 = true
		string retorno_10, generar_10, facturar_10
		if Messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_generar_aviso_10','$$HEX1$$bf00$$ENDHEX$$Desea generar un aviso del  10% de MUSAAT?'), Question!, YesNo!) <> 1 then return		
		// Se debe comprobar antes si existe un movimiento de musaat de tipo 1.1
		for i = 1 to idw_fases_src.rowcount()
			t_visado = idw_fases_src.getitemstring(i, 't_visado')
			obra_oficial = idw_fases_src.getitemstring(i, 'obra_oficial')	
			if t_visado = '1' and obra_oficial = '1' then
				bl_generar_10 = false
			end if
		next
		// ----
		if not bl_generar_10 then
			if Messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_generar_aviso_10','Ya existen movimientos del 10% de MUSAAT, $$HEX1$$bf00$$ENDHEX$$Desea Continuar?'), Question!, YesNo!) <> 1 then return
		end if
		open(w_musaat_10)
		retorno_10 = message.stringparm
		generar_10 = LeftA(retorno_10, 1)
		facturar_10 = RightA(retorno_10, 1)
		bl_generar_10 = (generar_10 = 'S')
		bl_facturar_10 = (facturar_10 = 'S')	
		parent.event csd_cobrar_anticipo_musaat(bl_generar_10, bl_facturar_10)
		// Si no se genera el mov del 10% se quita el check de musaat por certificaciones para que cobre el 100%
		if generar_10 = 'N' then dw_1.setitem(1, 'aplicado_10', 'N')
		dw_1.update()

	CASE 'b_opciones'
		if dw_fases_botones.visible then
			dw_fases_botones.visible=false
			this.object.b_opciones.Text = 'Opciones >>'
		else
			dw_fases_botones.visible=true
			this.object.b_opciones.Text = 'Opciones <<'
		end if
	
	// Modificado Ricardo 04-03-22
	CASE 'b_salida_fase'
		long n_reg
		// MODIFICADO RICARDO 04-07-06
		CHOOSE CASE g_colegio
			CASE 'COAATTFE', 'COAATZ'
				// Se necesita tener un permiso especial para poder tocar este campo
//				select count(*) into :n_reg from t_permisos where cod_usuario = :g_usuario and cod_aplicacion = 'TFE0000036' and permiso = 'E' ;
				select count(*) into :n_reg from t_permisos where cod_usuario = :g_usuario and ((cod_aplicacion = 'TFE0000036' and permiso = 'E') or cod_aplicacion = 'E');
				if n_reg<1 then 
					post Messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_permisos_suficientes',"No tiene permisos suficientes para modificar este valor"), stopsign!)
					return 2
				end if
		END CHOOSE
		// FIN MODIFICADO RICARDO 04-07-06		
		st_control_eventos c_evento
		if f_es_vacio(this.getitemstring(1,'archivo_fase')) then
			c_evento.evento = 'NUMERO_SAL'
			f_control_eventos(c_evento)
			this.setitem(1,'archivo_fase',f_numera_salida(c_evento.param1))// Modificado Ricardo 2005-05-11 -> SE le pasa el formato directamente
		end if
	// FIN Modificado Ricardo 04-03-22              		

	CASE 'b_teor'
		openwithparm(w_honos_teoricos,'')
		
	CASE 'b_desglose'
		openwithparm(w_desglose_honos,'')
	case 'b_localizar'
		OpenWithParm(w_fases_emplazamiento_url,id_fase)
		
	//Modif 4/09/07 Inc.8252
	case 'b_rev_honorarios'
		
		
		if i_cond = 1 then
			this.Object.honorarios_iva.visible=true 
			this.Object.t_rev_honorarios.visible=true
			this.Object.b_rev_honorarios.text = '-'
			i_cond = 0
		else
			this.Object.honorarios_iva.visible= false
			this.Object.t_rev_honorarios.visible=false
			this.Object.b_rev_honorarios.text = '+'
			i_cond = 1
		end if
	//Fin Inc. 8252
		
END CHOOSE

this.TriggerEvent('csd_control_estados')

end event

event dw_1::doubleclicked;call super::doubleclicked;string obser,data_item

CHOOSE CASE dwo.name
//	CASE 'f_entrada'
//		messagebox(g_titulo, "Fecha y Hora Entrada: " + string(dw_1.getitemdatetime(1,'f_entrada'), "dd/mm/yyyy  hh:mm"))
//		
//	CASE 'f_visado'
//		messagebox(g_titulo, "Fecha y Hora Visado: " + string(dw_1.getitemdatetime(1,'f_visado'), "dd/mm/yyyy  hh:mm"))		
		
	CASE 'cb_incidencias'
		g_incidencias.id=dw_1.getitemstring(1,'id_expedi')
		open(w_incidencias_exp)
		if message.stringparm='S' then
			dw_1.object.cb_incidencias.Background.color=f_color_rojo()
		else
			dw_1.object.cb_incidencias.Background.color=f_color_windows_buttonface()
		end if	
	
	CASE 'observaciones'
		g_busqueda.titulo="Observaciones"
		obser    =this.GetItemString(row, 'observaciones')
		data_item=this.getitemstring(row, 'observaciones') // para control modificaciones
		openwithparm(w_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
			if not isnull(obser) then
//			   if data_item<>obser then dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, "DETALLE", 'observaciones', row)
				if data_item<>obser then dw_1.trigger event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, 'DETALLE', 'observaciones', row)
				dw_1.SetItem(row,'observaciones',obser)
			end if 	
		end if
END CHOOSE

this.TriggerEvent('csd_control_estados')

end event

event dw_1::retrieveend;call super::retrieveend;string estado

SetPointer(Hourglass!)

idw_fases_modificacion_datos.Retrieve(this.GetItemString(1,'id_fase'), '03')

// Modificado por David 15-03-2004
if f_es_vacio(this.getitemstring(1, 'paga_gastos_cliente')) then
	//Colocamos un valor por defecto
	this.SetItem(1, 'paga_gastos_cliente', 'N')
	this.update()
end if
// FIN Modificado por David 15-03-2004

//Cambio Luis CRI-161 y CMU-119
	if(f_es_vacio(this.getitemstring(1,'mantenimiento')))then
		this.setitem(1,'mantenimiento','N')
	end if
//fin cambio

// Modificado por David 29-03-2004
CHOOSE CASE g_colegio 
	CASE 'COAATLR'
		if f_puede_llevar_control_calidad(this.getitemstring(1,'fase')) = 'S' then
			// Hacemos visible el check
			idw_fases_estadistica.object.ctrl_calidad_interno.visible = TRUE
		else
			// Quitamos la visualizaci$$HEX1$$f300$$ENDHEX$$n del check y desmarcamos el valor
			idw_fases_estadistica.object.ctrl_calidad_interno.visible = false
		end if

		// modificado ricardo 04-07-01
		IF f_es_vacio(this.getitemstring(1, 'modalidad')) then
			// Solo est$$HEX2$$e1002000$$ENDHEX$$vacio cuando se crea desde el mostrador
			this.SetItem(1, 'modalidad', f_devuelve_centro(g_cod_delegacion))
			// Grabamos
			this.update()
		end if 
		//Cambio Luis CRI-161
//		if(f_es_vacio(this.getitemstring(1,'mantenimiento')))then
//			this.setitem(1,'mantenimiento','N')
//		end if
		//fin cambio
	CASE 'COAATZ'
		// modificado ricardo 04-07-01
		IF f_es_vacio(this.getitemstring(1, 'modalidad')) then
			// Solo est$$HEX2$$e1002000$$ENDHEX$$vacio cuando se crea desde el mostrador
			this.SetItem(1, 'modalidad', f_devuelve_centro(g_cod_delegacion))
			// Grabamos
			this.update()
		end if 
END CHOOSE
// Fin Modificado por David 29-03-2004

// Modificado por RICARDO 2004-12-16
if f_es_vacio(this.getitemstring(1, 'tipo_registro')) then
	//Colocamos un valor por defecto
	this.SetItem(1, 'tipo_registro', g_fases_inicio.tipo_registro)
	this.update()
end if
// Modificado por RICARDO 2004-12-16

parent.PostEvent('csd_control_estados')
this.postevent('csd_fases_otras_fases')
this.postevent('csd_insertar_lineas_nuevas')
this.postevent('csd_habilitar_certificaciones')

if g_fase_visared.opcion_importacion ='S' then
	parent.PostEvent('csd_importar_fase_visared')
end if

// Llamamos al control de eventos evento 'RECUPERAR_FASE'
if ib_avisar_incidencias then
	st_control_eventos c_evento
	c_evento.evento = 'RECUPERAR_FASE'
	c_evento.dw = dw_1
	if f_control_eventos(c_evento)=-1 then return
	ib_avisar_incidencias = false
end if

// Muestra el pem en el detalle de expedientes
if idw_fases_estadistica.rowcount() > 0 then idw_fases_datos_exp.object.pem.text = string(idw_fases_estadistica.getitemnumber(1, 'pem'), "#,##0.00")

//Cambio Luis CRI-109
if(f_es_vacio(dw_1.getitemstring(1,'nr_duplicado')))then
	dw_1.setitem(1,'nr_duplicado','N')
end if
//fin cambio

SetPointer(Arrow!)

end event

event dw_1::pfc_preupdate;this.TriggerEvent('csd_control_estados')
return 1
end event

event dw_1::itemchanged;call super::itemchanged;string id_expedi,id_fase,cod,des,destipo
boolean sw, recalcular = false
double encontrados, pto, porc, honos
string t_actuacion, t_obra, uso, tipo_act, ls_anterior
int n_reg 
long i

cod='***'
choose case dwo.name
	case 'estado'
		parent.PostEvent('csd_control_estados')
	case 'id_fase'
		id_expedi=this.GetItemString(1,'id_expedi')
		idw_fases_otras_fases.Retrieve(id_expedi,data)
	case 'tipo_trabajo'
		SELECT tipos_trabajos.c_t_trabajo INTO :cod FROM tipos_trabajos WHERE tipos_trabajos.c_t_trabajo = :data;
		sw=true
		// Incompatibilidades           
		t_obra = data
		t_actuacion = this.getitemstring(1, 'fase')
		uso = this.getitemstring(1, 'trabajo')
		f_hay_incompatibilidad(t_actuacion, t_obra, uso, true)
		event csd_configura_insercion()


		// Si est$$HEX2$$e1002000$$ENDHEX$$la pesta$$HEX1$$f100$$ENDHEX$$a de finales de obra, refrescamos la pop-up
		st_control_eventos c_evento
		if tab_1.control[tab_1.selectedtab].classname() = 'tabpage_15' then
			// Llamamos al control de eventos evento 'FASES_TAB'
			c_evento.evento = 'FASES_TAB'
			c_evento.dw = idw_fases_finales_obra
			if f_control_eventos(c_evento)=-1 then return
		end if          

	case 'trabajo'  
		SELECT trabajos.c_trabajo INTO :cod FROM trabajos WHERE trabajos.c_trabajo = :data ;
		sw=true
		// Incompatibilidades           
		uso = data              
		t_obra = this.getitemstring(1, 'tipo_trabajo')
		t_actuacion = this.getitemstring(1, 'fase')
		f_hay_incompatibilidad(t_actuacion, t_obra, uso, true)
		event csd_configura_insercion()

		// Si est$$HEX2$$e1002000$$ENDHEX$$la pesta$$HEX1$$f100$$ENDHEX$$a de finales de obra, refrescamos la pop-up
		if tab_1.control[tab_1.selectedtab].classname() = 'tabpage_15' then
			// Llamamos al control de eventos evento 'FASES_TAB'
			c_evento.evento = 'FASES_TAB'
			c_evento.dw = idw_fases_finales_obra
			if f_control_eventos(c_evento)=-1 then return
		end if          

	case 'tipo_via_emplazamiento'
		SELECT tipos_via.cod_tipo_via INTO :cod FROM tipos_via WHERE tipos_via.cod_tipo_via = :data ;
		sw=true
	case 'poblacion'
//		SELECT poblaciones.cod_pob INTO :cod FROM poblaciones WHERE poblaciones.cod_pob = :data ;
		string pob, prov
		long num_pob
		pob = data + '%'
		prov = '000' + g_cod_prov_colegio + '%'
		SELECT count(*) INTO :num_pob FROM poblaciones WHERE poblaciones.cod_pos like :pob and provincia like :prov  ;
		if num_pob > 1 then
			st_busqueda_poblaciones lst_busq_pob
			lst_busq_pob.cod_postal = data		
			g_busqueda.titulo='Poblaciones'
			g_busqueda.dw='d_poblaciones_lista_busqueda'
			ls_anterior = g_bloqueo_fases
			g_bloqueo_fases = 'S'
			openwithparm(w_busqueda_poblaciones,lst_busq_pob)
			g_bloqueo_fases = ls_anterior
			cod = Message.StringParm
			if f_es_vacio(cod) then return
			this.post setitem(1, 'poblacion', cod)
		else	
			SELECT poblaciones.cod_pob INTO :cod FROM poblaciones WHERE poblaciones.cod_pos like :pob and provincia like :prov  ;
			if not f_es_vacio(cod) then
				if cod <> '***' then this.post setitem(1, 'poblacion', cod)
			end if
	//		if cod = '***' then
	//				openwithparm(w_poblaciones_creacion, data)
	//				if message.stringparm <> '-1' then cod = data
	//		end if
			sw=true
		end if
			
	case 'tipo_gestion'
		SELECT t_gestion.descripcion INTO :cod FROM t_gestion
   	WHERE t_gestion.cod_gestion = :data;
		sw=true         
		if data = 'C' then idw_fases_colegiados.triggerevent("csd_cambiar_tipos_gestion_a_cgc")
		if data = 'P' then idw_fases_colegiados.triggerevent("csd_cambiar_tipos_gestion_a_sgc")
		
		if idw_fases_colegiados.rowcount() > 0 then Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_tipo_fes_col','Se ha cambiado el tipo de gesti$$HEX1$$f300$$ENDHEX$$n de los colegiados'))
		
		this.post event csd_marcar_certificaciones()

		// if data = 'P' then
		// 	messagebox(g_titulo, 'El colegiado desea pagar directamente los gastos, Saldr$$HEX2$$e1002000$$ENDHEX$$un impreso que debe firmar')
		//    parent.triggerevent('csd_recibi_sin_gestion')
		// end if
	CASE 'fase'
		this.post event csd_marcar_certificaciones()
		id_expedi = this.GetItemString(row,'id_expedi')
		id_fase= this.GetItemString(row,'id_fase')
		//Buscamos si existen m$$HEX1$$e100$$ENDHEX$$s fases con el mismo numero
		SELECT count(*)  INTO :encontrados  FROM fases  
						  WHERE ( fases.fase = :data ) AND ( fases.id_expedi = :id_expedi ) AND (fases.id_fase<>:id_fase);
		if encontrados>0 then 
			Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_fase_exp','ATENCION !!! Esta fase YA existe dentro de este expediente.'))
		end if
		select t_fases.d_t_descripcion into :des from t_fases where t_fases.c_t_fase= :data;
		this.setitem(1,'titulo',des)
		// Incompatibilidades
		uso = this.getitemstring(1, 'trabajo')          
		t_obra = this.getitemstring(1, 'tipo_trabajo')
		t_actuacion = data      
		f_hay_incompatibilidad(t_actuacion, t_obra, uso, true)
		event csd_configura_insercion()
		if(g_colegio = 'COAATTGN' or g_colegio='COAATTEB' or g_colegio='COAATLL')then
			tipo_act = this.getitemstring(1,'fase')
			if((Mid(tipo_act,1,1) = '1')) then
				for i = 1 to idw_fases_finales_obra.rowcount()
					if(idw_fases_finales_obra.getitemstring(1,'total_parcial') = 'T' OR idw_fases_finales_obra.getitemstring(1,'total_parcial') = 'V')then
						this.setitem(1,'estado', '62')
					end if
				next
			end if
			if((Mid(tipo_act,1,1) = '3')) then
				for i = 1 to idw_fases_finales_obra.rowcount()
					if(idw_fases_finales_obra.getitemstring(1,'total_parcial') = 'T' OR idw_fases_finales_obra.getitemstring(1,'total_parcial') = 'V')then
						this.setitem(1,'estado', '66')
					end if
				next
			end if
		end if	
		
		// MODIFICADO RICARDO 04-02-17
		CHOOSE CASE g_colegio
			CASE 'COAATLR'
				if f_puede_llevar_control_calidad(data) = 'S' then
					// Hacemos visible el check
					idw_fases_estadistica.object.ctrl_calidad_interno.visible = TRUE
				else
					// Quitamos la visualizaci$$HEX1$$f300$$ENDHEX$$n del check y desmarcamos el valor
					idw_fases_estadistica.object.ctrl_calidad_interno.visible = false
					idw_fases_estadistica.setitem(1, 'ctrl_calidad_interno', 'N')
				end if
			CASE 'COAATTFE'
				// Lo dejamos siempre visible, luego no lo tocamos			
			CASE ELSE
				// Para todos los dem$$HEX1$$e100$$ENDHEX$$s lo ocultamos siempre
				idw_fases_estadistica.object.ctrl_calidad_interno.visible = false
		END CHOOSE
		// MODIFICADO RICARDO 04-02-17
	case 'tipo_fase'
		select tipo_fases.descripcion into :destipo from tipo_fases where tipo_fases.codigo = :data;
		des=dw_1.getitemstring(1,'titulo')
		des=des + '  ( ' + destipo + ' )'
		dw_1.setitem(1,'titulo',des)
	
	CASE 'archivo_fase'
		// MODIFICADO RICARDO 04-06-11
		CHOOSE CASE g_colegio
			CASE 'COAATTFE', 'COAATZ', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATA', 'COAATTER', 'COAATMCA'
				// Se necesita tener un permiso especial para poder tocar este campo
				//select count(*) into :n_reg from t_permisos where cod_usuario = :g_usuario and ((cod_aplicacion = 'TFE0000036' and permiso = 'E') or cod_aplicacion = 'E');
				//if n_reg<1 then 
				// cambiada la funcion para que tenga en cuenta los grupos 1/2/2010
				if f_tengo_permiso(g_usuario,'TFE0000036','E')=-1 then
					post Messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_permisos',"No tiene permisos suficientes para modificar este valor"), stopsign!)
					return 2
				end if
		END CHOOSE
		// FIN MODIFICADO RICARDO 04-06-11

	CASE 'f_abono'
		// MODIFICADO RICARDO 04-06-11
		CHOOSE CASE g_colegio
			CASE 'COAATTFE', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATA', 'COAATTER'
				// Se necesita tener un permiso especial para poder tocar este campo
				//select count(*) into :n_reg from t_permisos where cod_usuario = :g_usuario and ((cod_aplicacion = 'TFE0000037' and permiso = 'E') or cod_aplicacion = 'E');
			//	if n_reg<1 then
			// cambiada la funcion para que tenga en cuenta los grupos 1/2/2010
				if f_tengo_permiso(g_usuario,'TFE0000037','E')=-1 then
					post Messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_permisos',"No tiene permisos suficientes para modificar este valor"), stopsign!)
					return 2
				end if
			END CHOOSE
		// FIN MODIFICADO RICARDO 04-06-11

	CASE 'porc_honorarios'
		porc = double(data)
		honos = this.getitemnumber(1,'honorarios')
		pto = idw_fases_estadistica.getitemnumber(1,'pem')
		if honos <> 0 then
			if messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_mod_hono',"$$HEX1$$bf00$$ENDHEX$$Desea modificar los honorarios existentes?"), question!, yesno!) <> 1 then return 2
		end if
		honos = f_redondea(pto * porc /100)
		this.setitem(1, 'honorarios', honos)
		
	CASE 't_descr'
		this.setitem(1, 'descripcion', data)
		
END CHOOSE

if cod='***' and sw=true then
	post MessageBox(g_titulo,'El c$$HEX1$$f300$$ENDHEX$$digo del ' + string(dwo.name) + ' no existe.')
	this.post event csd_recupera_posicion(string(dwo.name))
	return 2
end if

// Modificacion de Datos
dw_1.trigger event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, 'DETALLE', dwo.name, row)

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;// carga datawindowchild de asociados nada m$$HEX1$$e100$$ENDHEX$$s cambiar de contrato
if idw_fases_colegiados.rowcount() > 0 then idw_fases_colegiados.event rowfocuschanged(1)

end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;CHOOSE CASE dwo.name
	case 'presupuesto', 'honorarios','honorarios_iva'
		this.SelectText(1, LenA(string(double(this.GetText()),"###,###,###.00")))
	case 'porc_honorarios'
		this.SelectText(1, LenA(string(double(this.GetText()),"#0.0000")))
	case 'emplazamiento'
		SetMicroHelp ("F4 - B$$HEX1$$fa00$$ENDHEX$$squeda de Calles")		
	case 'n_calle'
		SetMicroHelp ("N$$HEX1$$fa00$$ENDHEX$$mero de Calle")
	case 'piso'
		SetMicroHelp ("N$$HEX1$$fa00$$ENDHEX$$mero de Piso")
	case 'puerta'
		SetMicroHelp ("N$$HEX1$$fa00$$ENDHEX$$mero de Puerta")		
END CHOOSE

// Hacemos que tras el campo de VISARED pasemos al dw de clientes de forma autom$$HEX1$$e100$$ENDHEX$$tica
if i_campo_activo_dw_1 = 'e_mail' then
	parent.tab_1.post selecttab(1)
	idw_fases_promotores.setfocus()
	idw_fases_promotores.setcolumn('nif') 
end if

i_campo_activo_dw_1 = dwo.name

end event

event dw_1::retrievestart;call super::retrievestart;// Decimos que no se ha pasado por el retrieveend
ib_avisar_incidencias = true

end event

event dw_1::csd_tecla;call super::csd_tecla;if key = keyF4! and this.getcolumnname() = 'emplazamiento' then
	st_busqueda_calles_llamada lst_llamada
	st_busqueda_calles_retorno lst_retorno
	 
	g_busqueda.titulo='B$$HEX1$$fa00$$ENDHEX$$squeda de calles'
	g_busqueda.dw='d_calles_busqueda'
	 
	// Si le pasamos un codigo de provincia en lst_llamada s$$HEX1$$f300$$ENDHEX$$lo se pueden buscar calles de esa provincia
	if not f_es_vacio(g_cod_prov_colegio) then lst_llamada.cod_provincia = '000' + g_cod_prov_colegio
	 
	openwithparm(w_busqueda_calles,lst_llamada)
	 
	lst_retorno=Message.Powerobjectparm
	 
	// Antes de mostrar los resultados hay que comprobar que los campos no sean vacios 
	if not isvalid(lst_retorno) then
		return
	else
		this.setitem(1, 'poblacion', lst_retorno.cod_poblacion)
		this.setitem(1, 'emplazamiento', lst_retorno.calle)
	end if
end if

end event

event dw_1::constructor;call super::constructor;if g_colegio = 'COAATA' then this.object.modalidad.tabsequence = 0
end event

type dw_fases_datos_exp from u_dw within w_fases_detalle
integer x = 37
integer y = 32
integer width = 4357
integer height = 100
integer taborder = 10
string dataobject = "d_fases_datos_exp"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)


end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
choose case dwo.name
	case 'administracion'
		dw_1.post event csd_marcar_certificaciones()
end choose
				
dw_1.event csd_modificacion_datos(dw_1.getitemstring(dw_1.getrow(),'id_fase'), this, 'EXPEDIENTE', dwo.name, row)
end event

event retrievestart;call super::retrievestart;if g_permitir_expedi_sin_numero = 'S' then
	this.object.blanco.visible = true
else
	this.object.blanco.visible = false	
end if
end event

event buttonclicked;call super::buttonclicked;st_control_eventos c_evento

CHOOSE CASE dwo.name
	CASE 'b_salida'
		if f_es_vacio(this.getitemstring(1,'archivo_exp')) then
			c_evento.evento = 'NUMERO_SAL'
			f_control_eventos(c_evento)
			this.setitem(1,'archivo_exp',f_numera_salida(c_evento.param1))// Modificado Ricardo 2005-05-11 -> SE le pasa el formato directamente
		end if
	
		if this.getitemstring(1,'n_expedi') = '000000000' and g_colegio = 'COAATGC' then
			c_evento.evento = 'NUMERO_EXP'
			f_control_eventos(c_evento)
			this.setitem(1,'n_expedi',f_numera_expediente(c_evento.param1))// Modificado Ricardo 2005-05-11 -> SE le pasa el formato directamente
		end if

	CASE 'b_exped'
		CHOOSE CASE g_colegio
			CASE 'COAATGC'
				if this.getitemstring(1,'n_expedi') = '000000000' then
					c_evento.evento = 'NUMERO_EXP'
					f_control_eventos(c_evento)
					this.setitem(1,'n_expedi',f_numera_expediente(c_evento.param1))// Modificado Ricardo 2005-05-11 -> SE le pasa el formato directamente
				end if

			CASE 'COAATTFE'
				// Cambio de registro
				if this.getitemstring(1,'n_expedi') = g_num_expedi_nulo then
					f_fases_cambio_registro(dw_1.getitemstring(1,"id_fase"))
					g_fases_consulta.id_fase = dw_1.getitemstring(1,"id_fase")
					// Si ha grabado algo no preguntamos
					ib_disableclosequery = true
					dw_1.event csd_retrieve()
					ib_disableclosequery = false
					return 
				end if
		END CHOOSE                                
END CHOOSE

parent.event pfc_save()

end event

event doubleclicked;call super::doubleclicked;string ls_id_expedi,ls_n_expedi

if (dwo.name='n_expedi') then
	//g_expedientes_consulta.id_expediente = dw_lista.getitemstring(dw_lista.getrow(),'id_expedi')
	ls_n_expedi=dw_fases_datos_exp.getitemstring(1,'n_expedi')
	select id_expedi into :ls_id_expedi from expedientes where n_expedi=:ls_n_expedi;
	g_expedientes_consulta.id_expediente =ls_id_expedi
	message.stringparm = "w_expedientes_detalle"
	w_aplic_frame.postevent("csd_expedientesdetalle")
end if

end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = False
end event

type tab_1 from tab within w_fases_detalle
event control_estados_tabs ( )
event csd_nombre_pestanyas ( string nombre )
event csd_poner_titulo ( )
string tag = "texto=general.notas"
integer x = 23
integer y = 1028
integer width = 4393
integer height = 1028
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79416533
boolean multiline = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_5 tabpage_5
tabpage_19 tabpage_19
tabpage_8 tabpage_8
tabpage_13 tabpage_13
tabpage_14 tabpage_14
tabpage_4 tabpage_4
tabpage_6 tabpage_6
tabpage_3 tabpage_3
tabpage_12 tabpage_12
tabpage_9 tabpage_9
tabpage_7 tabpage_7
tabpage_11 tabpage_11
tabpage_15 tabpage_15
tabpage_16 tabpage_16
tabpage_17 tabpage_17
tabpage_10 tabpage_10
tabpage_18 tabpage_18
end type

event control_estados_tabs;Parent.TriggerEvent('csd_control_estados')
end event

event csd_poner_titulo();if i_tab_of <> '' then tabpage_9.text = i_tab_of + ' (' + string(idw_fases_otras_fases.rowcount()) + ')'
if i_tab_mu <> '' then tabpage_13.text = i_tab_mu + ' (' + string(idw_fases_src.rowcount()) + ')'
if i_tab_mi <> '' then tabpage_14.text = i_tab_mi + ' (' + string(idw_fases_minutas.rowcount()) + ')'
if i_tab_od <> '' then tabpage_3.text = i_tab_od + ' (' + string(idw_fases_documentos.rowcount()) + ')'
if i_tab_es <> '' then tabpage_11.text = i_tab_es + ' (' + string(idw_fases_registros.rowcount()) + ')'
if i_tab_fo <> '' then tabpage_15.text = i_tab_fo + ' (' + string(idw_fases_finales_obra.rowcount()) + ')'
if i_tab_no <> '' then tabpage_10.text = i_tab_no + ' (' + string(idw_fases_incidencias.rowcount()) + ')'


// PACO 8/8/2006
int i
double dl_reparos_no_subsanados = 0
datetime f_subsanacion

for i = 1 to idw_fases_reparos.rowcount()
	f_subsanacion = idw_fases_reparos.getitemdatetime(i, 'f_subsanacion')
	if not isnull(f_subsanacion) then dl_reparos_no_subsanados++
next

//if i_tab_re <> '' then tabpage_4.text = i_tab_re + ' (' + string(dl_reparos_no_subsanados) + '/' + string(idw_fases_reparos.rowcount()) + ')'

// David 14/12/2006 - INC. 6420
if i_tab_re <> '' then tabpage_4.text = i_tab_re + ' (' + string(idw_fases_reparos.rowcount()) + '/' + string(dl_reparos_no_subsanados) + ')'
end event

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_5=create tabpage_5
this.tabpage_19=create tabpage_19
this.tabpage_8=create tabpage_8
this.tabpage_13=create tabpage_13
this.tabpage_14=create tabpage_14
this.tabpage_4=create tabpage_4
this.tabpage_6=create tabpage_6
this.tabpage_3=create tabpage_3
this.tabpage_12=create tabpage_12
this.tabpage_9=create tabpage_9
this.tabpage_7=create tabpage_7
this.tabpage_11=create tabpage_11
this.tabpage_15=create tabpage_15
this.tabpage_16=create tabpage_16
this.tabpage_17=create tabpage_17
this.tabpage_10=create tabpage_10
this.tabpage_18=create tabpage_18
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_5,&
this.tabpage_19,&
this.tabpage_8,&
this.tabpage_13,&
this.tabpage_14,&
this.tabpage_4,&
this.tabpage_6,&
this.tabpage_3,&
this.tabpage_12,&
this.tabpage_9,&
this.tabpage_7,&
this.tabpage_11,&
this.tabpage_15,&
this.tabpage_16,&
this.tabpage_17,&
this.tabpage_10,&
this.tabpage_18}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_5)
destroy(this.tabpage_19)
destroy(this.tabpage_8)
destroy(this.tabpage_13)
destroy(this.tabpage_14)
destroy(this.tabpage_4)
destroy(this.tabpage_6)
destroy(this.tabpage_3)
destroy(this.tabpage_12)
destroy(this.tabpage_9)
destroy(this.tabpage_7)
destroy(this.tabpage_11)
destroy(this.tabpage_15)
destroy(this.tabpage_16)
destroy(this.tabpage_17)
destroy(this.tabpage_10)
destroy(this.tabpage_18)
end on

event selectionchanging;// Cuando se visualicen los finales de obra hay que ver el control de eventos por si hay acciones asociadas
st_control_eventos c_evento

// COAATGUI: Se hace en el itemchanged
if g_colegio <> 'COAATGUI' then
	if tab_1.control[newindex].classname() = 'tabpage_15' then
		// Llamamos al control de eventos evento 'FASES_TAB'
		c_evento.evento = 'FASES_TAB'
		c_evento.dw = idw_fases_finales_obra
		if f_control_eventos(c_evento)=-1 then return
	end if
end if

//COAATTFE: Se crea un fichero al entrar en la pesta$$HEX1$$f100$$ENDHEX$$a de CIP
// Est$$HEX2$$e1002000$$ENDHEX$$relacionado con el filedelete del close de la ventana
// Hacerlo con el control de eventos
if g_colegio = 'COAATTFE' then
	if tab_1.control[newindex].classname() = 'tabpage_19' then
		integer li_Fichero_cip
		li_Fichero_cip = FileOpen("c:\encip.txt", LineMode!, Write!)
		filewrite(li_Fichero_cip, 'CIP')
		fileclose(li_Fichero_cip)
	else
		FileDelete("c:\encip.txt")
	end if
end if

end event

type tabpage_1 from userobject within tab_1
string tag = "texto=general.clientes"
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "Clientes"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom076!"
long picturemaskcolor = 12632256
dw_fases_promotores dw_fases_promotores
end type

on tabpage_1.create
this.dw_fases_promotores=create dw_fases_promotores
this.Control[]={this.dw_fases_promotores}
end on

on tabpage_1.destroy
destroy(this.dw_fases_promotores)
end on

type dw_fases_promotores from u_dw within tabpage_1
event csd_poner_pagador ( )
event calcular_suma_porcentaje ( )
event csd_borrar_cod ( )
event csd_porcentajes ( )
event csd_abrir_busqueda_cliente ( )
event csd_control_nif ( string nif )
event type integer csd_calcular_nif ( string nif )
event csd_oculta_tab ( )
event csd_nombre_pestanyas ( string nombre )
event csd_abrir_busqueda_representante ( )
integer x = 18
integer y = 20
integer width = 4315
integer height = 784
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_fases_promotores"
boolean hscrollbar = true
end type

event csd_poner_pagador;this.setitem(this.getrow(),'pagador','S')
end event

event calcular_suma_porcentaje;double i,suma=0

for i=1 to this.rowCount()
	if this.GetItemString(i,'pagador')='S' then
		suma = suma + this.GetItemNumber(i,'porcen')
	end if
next
g_suma_porcentajes_cli = suma

//this.SetItem(this.RowCount(),'total_porcen',suma)
end event

event csd_borrar_cod;this.deleterow(0)
end event

event csd_porcentajes();double porcen_introducido, porcen_limite, porcen_restante
long i

porcen_limite = 100
porcen_introducido = 0


FOR i=1 TO this.RowCount()
	porcen_introducido = porcen_introducido + this.GetItemNumber(i,'porcen')
NEXT


if porcen_introducido > 100 then
	Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_porcentaje_mayor_100',"El porcentaje total es superior a 100. Rectif$$HEX1$$ed00$$ENDHEX$$quelo o se har$$HEX2$$e1002000$$ENDHEX$$el reparto proporcionalmente."), Exclamation!)
	return
end if

//La siguiente l$$HEX1$$ed00$$ENDHEX$$nea es por si ponen varios arquitectos a partes iguales

if porcen_introducido < 4 then porcen_limite = porcen_introducido

porcen_restante = porcen_limite - porcen_introducido

if porcen_restante = 0 then return

//A$$HEX1$$f100$$ENDHEX$$adimos el porcentaje restante:
this.event pfc_addrow()
this.SetItem(this.RowCount(),'porcen',porcen_restante)
this.SetRow(this.RowCount())
this.SetColumn('nif')


end event

event csd_abrir_busqueda_cliente;string id_persona,nif

g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
g_busqueda.dw="d_lista_busqueda_clientes"		
id_persona=f_busqueda_clientes(i_nif)

if not(f_es_vacio(id_persona)) then 
	select nif into :nif from clientes where id_cliente = :id_persona;
end if
if not(f_es_vacio(nif)) then this.setitem(this.Getrow(),'nif',nif)
if not(f_es_vacio(id_persona)) then this.setitem(this.Getrow(),'id_cliente',id_persona)
end event

event csd_control_nif(string nif);//int num_clientes, i
//string mensaje, id_cli
//double suma_porcentajes_cli
//st_ficha_cliente datos_cliente
//
//if i_nif_correcto <> 1 then return
//select count(*) into :num_clientes from clientes where nif=:nif;
//if num_clientes > 0 then  
//	if num_clientes = 1 then
//		i_nif=''
//		this.setitem(this.getrow() ,'id_cliente',f_cliente_id_cliente(nif))
//	else
//		i_nif=nif
//
//		this.triggerevent ("csd_abrir_busqueda_cliente")
//	end if
//	this.setitem(this.getrow() ,'porcen',100)
//	for i=1 to this.rowcount()
//		if i<>this.getrow() and this.getitemstring(i,'cliente') = this.getitemstring(this.getrow() ,'cliente') then
//			MessageBox(g_titulo,'No puede haber un cliente duplicado.')
//			i=this.rowcount() + 1
//			this.triggerevent ("csd_borrar_cod")
//			this.postevent ("pfc_addrow")					
//		end if
//	next 
//	mensaje=f_control_de_incidencias('P',f_cliente_id_cliente(nif))
//else
//	if MessageBox(g_titulo,'Este cliente NO existe, $$HEX1$$bf00$$ENDHEX$$Desea darlo de alta?',Question!,YesNo!,1)=1 then
//		//Aqui va el c$$HEX1$$f300$$ENDHEX$$digo q abre la ventana 
//		datos_cliente.nif=nif
//		OpenWithParm(w_fases_ficha_cliente,datos_cliente)
//		id_cli = Message.StringParm
//		this.SetItem(this.getrow(),'id_cliente',id_cli)
//	end if
//end if
//suma_porcentajes_cli=0
//for i=1 to this.rowcount()
//	if i<>this.getrow() then suma_porcentajes_cli=suma_porcentajes_cli + this.getitemnumber(1,'porcen')
//next
//this.setitem(this.getrow() ,'porcen',100 - suma_porcentajes_cli)
end event

event csd_oculta_tab;int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event csd_nombre_pestanyas;parent.text=nombre
end event

event csd_abrir_busqueda_representante();string id_persona,nif

g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
g_busqueda.dw="d_lista_busqueda_clientes"		
id_persona=f_busqueda_clientes(i_nif)

if not(f_es_vacio(id_persona)) then 
	select nif into :nif from clientes where id_cliente = :id_persona;
end if
if not(f_es_vacio(nif)) then this.setitem(this.Getrow(),'nif_representante',nif)
if not(f_es_vacio(id_persona)) then this.setitem(this.Getrow(),'id_representante',id_persona)
end event

event buttonclicked;call super::buttonclicked;string id_persona,nif
double cant, suma_porcentajes_cli = 0
st_ficha_cliente datos_cliente
int i

CHOOSE CASE dwo.name
	CASE 'b_auto'
		if g_colegio = 'COAATZ' then return // Modificado David 01/03/2006 - INC. 4646
		string nif_auto
		nif_auto = f_siguiente_nif_auto()
		this.setitem(row, 'nif', nif_auto)
		this.event itemchanged(row, this.object.nif, nif_auto)
		
	CASE 'b_add_rep'
		if g_colegio = 'COAATZ' then return // Modificado David 01/03/2006 - INC. 4646		
		string nif_repre
		nif_repre = f_siguiente_nif_repre()
		this.setitem(row, 'nif_representante', nif_repre)
		this.event itemchanged(row, this.object.nif_representante, nif_repre)
		
	CASE 'b_auto_prop'
		if g_colegio = 'COAATZ' then return // Modificado David 01/03/2006 - INC. 4646		
		string nif_prop
		nif_prop = f_siguiente_nif_auto()
		this.setitem(row, 'nif_propiedad', nif_prop)
		this.event itemchanged(row, this.object.nif_propiedad, nif_prop)
	
	CASE 'b_clientes'
		g_busqueda.titulo=g_idioma.of_getmsg('colegiados.busqueda_rapido_cli',"B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes")
		g_busqueda.dw="d_lista_busqueda_clientes"		
		id_persona=f_busqueda_clientes(this.getitemstring(row, 'nif'))
		if not(f_es_vacio(id_persona)) then
			select nif into :nif from clientes where id_cliente = :id_persona;
			if not(f_es_vacio(nif)) then this.setitem(row,'nif',nif)
			if not(f_es_vacio(id_persona)) then this.setitem(row,'id_cliente',id_persona)
			for i=1 to this.rowcount()
				if i<>this.getrow() then suma_porcentajes_cli=suma_porcentajes_cli + this.getitemnumber(1,'porcen')
			next
			this.setitem(this.getrow() ,'porcen',100 - suma_porcentajes_cli)			
			event itemchanged(row,this.object.nif,nif)
		end if
		
	CASE 'b_representante'
		g_busqueda.titulo=g_idioma.of_getmsg('colegiados.busqueda_rapido_rep',"B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de representantes")
		g_busqueda.dw="d_lista_busqueda_terceros"
		id_persona=f_busqueda_terceros(g_terceros_codigos.representantes)
//		g_busqueda.dw="d_lista_busqueda_clientes"
//		id_persona=f_busqueda_clientes(this.getitemstring(row, 'nif_representante'))
		if not(f_es_vacio(id_persona)) then
			select nif into :nif from clientes where id_cliente = :id_persona;
			if not(f_es_vacio(nif)) then this.setitem(row,'nif_representante',nif)
			if not(f_es_vacio(id_persona)) then this.setitem(row,'id_representante',id_persona)
		end if

	CASE 'b_propiedad'
		g_busqueda.titulo=g_idioma.of_getmsg('colegiados.busqueda_rapido_cli',"B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes")
		g_busqueda.dw="d_lista_busqueda_clientes"
		id_persona=f_busqueda_clientes(this.getitemstring(row, 'nif_propiedad'))
		if not(f_es_vacio(id_persona)) then
			select nif into :nif from clientes where id_cliente = :id_persona;
			if not(f_es_vacio(nif)) then this.setitem(row,'nif_propiedad',nif)
			if not(f_es_vacio(id_persona)) then this.setitem(row,'id_propiedad',id_persona)
		end if	

	CASE 'b_informe'
		id_persona=this.GetItemString(row,'id_cliente')
		select count(*) into :cant from clientes where clientes.id_cliente=:id_persona;
		if cant >0 then
			if not(f_es_vacio(id_persona)) then
				datos_cliente.id_cliente = id_persona
				datos_cliente.tipo_tercero = g_terceros_codigos.codigo_cliente
				OpenWithParm(w_fases_ficha_cliente,datos_cliente)
			end if
		else	
			MessageBox(g_titulo,g_idioma.of_getmsg('fases.msg_cli_no_existe','El cliente NO existe.'))
		end if
	
	CASE 'b_informe_r'
		id_persona=this.GetItemString(row,'id_representante')
		select count(*) into :cant from clientes where clientes.id_cliente=:id_persona;
		if cant >0 then
			if not(f_es_vacio(id_persona)) then
				datos_cliente.id_cliente= id_persona
				datos_cliente.tipo_tercero = g_terceros_codigos.representantes
				OpenWithParm(w_fases_ficha_cliente,datos_cliente)
			end if
		else	
			MessageBox(g_titulo,g_idioma.of_getmsg('fases.msg_rep_no_existe','El representante NO existe.'))
		end if
		
	CASE 'b_informe_prop'
		id_persona=this.GetItemString(row,'id_propiedad')
		select count(*) into :cant from clientes where clientes.id_cliente=:id_persona;
		if cant >0 then
			if not(f_es_vacio(id_persona)) then
				datos_cliente.id_cliente= id_persona
				datos_cliente.tipo_tercero = g_terceros_codigos.codigo_cliente
				OpenWithParm(w_fases_ficha_cliente,datos_cliente)
			end if
		else	
			MessageBox(g_titulo,g_idioma.of_getmsg('fases.msg_prop_no_existe','La propiedad NO existe.'))
		end if		
END CHOOSE

end event

event itemchanged;call super::itemchanged;int num_clientes, i, retorno
string id, fase, id_cli, mensaje, nif
double total_hon, suma_porcentajes_cli
boolean valido, encontrado
st_ficha_cliente datos_cliente

// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, Upper(Parent.text), dwo.name, row)

choose case dwo.name
	case 'porcen'
		i_porcen=getitemnumber(this.getrow(),'porcen')
		this.PostEvent('comprobar_porcentajes')
		this.PostEvent('csd_porcentajes')
		
	case 'pagador'
		mensaje=''
		id_cli=this.getitemstring(this.getrow(),'id_cliente')
		
		for i=1 to idw_fases_minutas.RowCount()
			if idw_fases_minutas.GetItemString(i,'id_cliente')=id_cli then
				encontrado =true
			end if
		next
		if encontrado then MessageBox(g_titulo,g_idioma.of_getmsg('fases.msg_cli_avisos_asig','El Cliente tiene Avisos Asignados.'))
		if data='N' and encontrado then
			this.PostEvent('csd_poner_pagador')
		end if		
		this.PostEvent('calcular_suma_porcentajes')
		
	case 'nif'
		string nif_formateado
		u_csd_nif uo_nif
		
		// Guardamos el nif en una variable de instancia porque la usa el evento de b$$HEX1$$fa00$$ENDHEX$$squeda de clientes
		nif = data
			
		/*if uo_nif.of_obtener_tipo_doc(nif)='DESCONOCIDO' then
			MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","El formato del NIF no es correcto. Compruebe que no tenga caracteres invalidos y que tenga la longitud correcta.")
		end if
		*/
		if RightA(nif, 1) = '*' then
			i_nif=left(nif,len(nif) - 1)
			//nif_formateado = uo_nif.of_formatear_nif(i_nif)			
			nif_formateado = uo_nif.of_comprobar_documento(i_nif,'')			
			if nif<>nif_formateado then 
				this.post setitem(1,'nif', nif_formateado)
				nif=nif_formateado
			end if			
			
			//nif = f_calculo_nif(nif)
			//if nif = '-1' then return -1
		else
			//nif_formateado = uo_nif.of_formatear_nif(nif)			
			nif_formateado = uo_nif.of_comprobar_documento(nif,'')
//		elseif RightA(nif,1) >= 'A' and RightA(nif,1) <= 'Z' then
//			if not f_comprobar_nif(nif) then
//				messagebox(g_titulo, g_idioma.of_getmsg('msg_cliente.letra_nif','La letra del NIF no es correcta'))
//				//return -1
//			end if
		end if

		select count(*) into :num_clientes from clientes where nif=:nif;
		if num_clientes > 0 then  
			if num_clientes = 1 then
				this.setitem(this.getrow() ,'id_cliente',f_cliente_id_cliente(nif))
			else
				this.triggerevent ("csd_abrir_busqueda_cliente")
			end if
			this.setitem(this.getrow() ,'porcen',100)
			for i=1 to this.rowcount()
				if i<>this.getrow() and this.getitemstring(i,'id_cliente') = this.getitemstring(this.getrow() ,'id_cliente') then
					MessageBox(g_titulo,g_idioma.of_getmsg('fases.msg_cli_duplicado','No puede haber un cliente duplicado.'))
					i=this.rowcount() + 1
					this.triggerevent ("csd_borrar_cod")
					this.postevent ("pfc_addrow")					
				end if
			next 
			mensaje=f_control_de_incidencias('P',f_cliente_id_cliente(nif))
		else
			if MessageBox(g_titulo,g_idioma.of_getmsg('fases.msg_cli_no_exist','Este cliente NO existe, $$HEX1$$bf00$$ENDHEX$$Desea darlo de alta?'),Question!,YesNo!,1)=1 then
				//Aqui va el c$$HEX1$$f300$$ENDHEX$$digo q abre la ventana 
				datos_cliente.nif=nif
				datos_cliente.tipo_tercero = g_terceros_codigos.codigo_cliente
				OpenWithParm(w_fases_ficha_cliente,datos_cliente)
				id_cli = Message.StringParm
				this.SetItem(this.getrow(),'id_cliente',id_cli)
			end if
		end if
		suma_porcentajes_cli=0
		for i=1 to this.rowcount()
			if i<>this.getrow() then suma_porcentajes_cli=suma_porcentajes_cli + this.getitemnumber(1,'porcen')
		next
		this.setitem(this.getrow() ,'porcen',100 - suma_porcentajes_cli)
		if nif <> '-1' then this.post setitem(this.getrow(),'nif', nif)
		
	
		//Cambiamos el Tipo de Promotor en estad$$HEX1$$ed00$$ENDHEX$$sticas seg$$HEX1$$fa00$$ENDHEX$$n el NIF del primer cliente
		//Cambio Luis SCP-238
		string ls_tipo_promotor,ls_nuevo_tp, ls_nif
		this.accepttext( )
		ls_nif = trim(this.GetItemString(1,'nif')) 
		if row<>1 then return 0
		if((LenA(ls_nif) <> 9) or (match(ls_nif,'^[A-Za-z]') and match(ls_nif,'[A-Za-z]$')))then
			MessageBox(g_titulo,'Debido al formato del NIF, el tipo de promotor se debe introducir de forma manual')
		else
			if LeftA(nif,4)='AUTO' then 
				ls_nuevo_tp='X'
			elseif match(nif,'^[A-Za-z]') then 
				ls_nuevo_tp=LeftA(nif,1)
			else 
				ls_nuevo_tp='X'
			end if
			ls_tipo_promotor=idw_fases_estadistica.getitemstring(1,'t_promotor')
			if not f_es_vacio(ls_tipo_promotor) then 
				if(ls_tipo_promotor <> ls_nuevo_tp)then
					idw_fases_estadistica.setitem(1,'t_promotor',ls_nuevo_tp)	
					MessageBox(g_titulo, 'El tipo de promotor no es el correcto para el NIF especificado. Se sustituye por el que le corresponde.')
				end if
			else 
				idw_fases_estadistica.setitem(1,'t_promotor',ls_nuevo_tp)
			end if
		end if
		//fin cambio
		
		
		/*
		// Guardamos el nif en una variable de instancia porque la usa el evento de b$$HEX1$$fa00$$ENDHEX$$squeda de clientes
		i_nif = data
		// SCP-99
//		// El NIF / CIF tiene que ser de 9
//		if LenA(data) <> 9 then
//			messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_nif_9','El NIF/CIF tiene que ser de 9 posiciones.'))
//			//return -1
//		end if
		nif = data
		if RightA(nif, 1) = '*' then
			nif = f_calculo_nif(nif)
			if nif = '-1' then return -1
		elseif RightA(nif,1) >= 'A' and RightA(nif,1) <= 'Z' then
			if not f_comprobar_nif(nif) then
				messagebox(g_titulo, g_idioma.of_getmsg('msg_cliente.letra_nif','La letra del NIF no es correcta'))
				//return -1
			end if
		end if

		select count(*) into :num_clientes from clientes where nif=:nif;
		if num_clientes > 0 then  
			if num_clientes = 1 then
				this.setitem(this.getrow() ,'id_cliente',f_cliente_id_cliente(nif))
			else
				this.triggerevent ("csd_abrir_busqueda_cliente")
			end if
			this.setitem(this.getrow() ,'porcen',100)
			for i=1 to this.rowcount()
				if i<>this.getrow() and this.getitemstring(i,'id_cliente') = this.getitemstring(this.getrow() ,'id_cliente') then
					MessageBox(g_titulo,g_idioma.of_getmsg('fases.msg_cli_duplicado','No puede haber un cliente duplicado.'))
					i=this.rowcount() + 1
					this.triggerevent ("csd_borrar_cod")
					this.postevent ("pfc_addrow")					
				end if
			next 
			mensaje=f_control_de_incidencias('P',f_cliente_id_cliente(nif))
		else
			if MessageBox(g_titulo,g_idioma.of_getmsg('fases.msg_cli_no_exist','Este cliente NO existe, $$HEX1$$bf00$$ENDHEX$$Desea darlo de alta?'),Question!,YesNo!,1)=1 then
				//Aqui va el c$$HEX1$$f300$$ENDHEX$$digo q abre la ventana 
				datos_cliente.nif=nif
				datos_cliente.tipo_tercero = g_terceros_codigos.codigo_cliente
				OpenWithParm(w_fases_ficha_cliente,datos_cliente)
				id_cli = Message.StringParm
				this.SetItem(this.getrow(),'id_cliente',id_cli)
			end if
		end if
		suma_porcentajes_cli=0
		for i=1 to this.rowcount()
			if i<>this.getrow() then suma_porcentajes_cli=suma_porcentajes_cli + this.getitemnumber(1,'porcen')
		next
		this.setitem(this.getrow() ,'porcen',100 - suma_porcentajes_cli)
		if nif <> '-1' then this.post setitem(this.getrow(),'nif', nif)
		
		//Andr$$HEX1$$e900$$ENDHEX$$s 17/6/2005
		//Cambiamos el Tipo de Promotor en estad$$HEX1$$ed00$$ENDHEX$$sticas seg$$HEX1$$fa00$$ENDHEX$$n el NIF del primer cliente
		string ls_tipo_promotor,ls_nuevo_tp

		if row<>1 then return 0
		ls_tipo_promotor=idw_fases_estadistica.getitemstring(1,'t_promotor')
				
		if not f_es_vacio(ls_tipo_promotor) then return 0
		
		if LeftA(nif,4)='AUTO' then 
			ls_nuevo_tp='X'
		elseif match(nif,'^[A-Za-z]') then 
			ls_nuevo_tp=LeftA(nif,1)
		else 
			ls_nuevo_tp='X'
		end if
		
	idw_fases_estadistica.setitem(1,'t_promotor',ls_nuevo_tp)
*/	
	case 'nif_representante'
		// Si est$$HEX2$$e1002000$$ENDHEX$$borrando el nif, no miramos nada, simplemente dejamos el id del representante vacio
		if f_es_vacio(data) then
			nif  = ''
			this.SetItem(this.getrow(),'id_representante','')
		else
			// Guardamos el nif en una variable de instancia porque la usa el evento de b$$HEX1$$fa00$$ENDHEX$$squeda de clientes
			i_nif = data
			// SCP-99
//			// El NIF / CIF tiene que ser de 9
//			if LenA(data) <> 9 then
//				messagebox(g_titulo, 'El NIF/CIF tiene que ser de 9 posiciones.')
//				return -1
//			end if
			nif = data
			if RightA(nif, 1) = '*' then
				nif = f_calculo_nif(nif)
				if nif = '-1' then return -1
			elseif RightA(nif,1) >= 'A' and RightA(nif,1) <= 'Z' then
				if not f_comprobar_nif(nif) then
					messagebox(g_titulo, g_idioma.of_getmsg('msg_cliente.letra_nif','La letra del NIF no es correcto'))
					return -1
				end if
			end if
	
			select count(*) into :num_clientes from clientes where nif=:nif;
			if num_clientes > 0 then  
				if num_clientes = 1 then
					this.setitem(this.getrow() ,'id_representante',f_cliente_id_cliente(nif))
				else
					this.triggerevent ("csd_abrir_busqueda_representante")				
				end if
				mensaje=f_control_de_incidencias('P',f_cliente_id_cliente(nif))
			else
				if MessageBox(g_titulo,g_idioma.of_getmsg('fases.msg_rep_no_existe_alta','Este representante NO existe, $$HEX1$$bf00$$ENDHEX$$Desea darlo de alta?'),Question!,YesNo!,1)=1 then
					//Aqui va el c$$HEX1$$f300$$ENDHEX$$digo q abre la ventana 
					datos_cliente.nif=nif
					datos_cliente.tipo_tercero = g_terceros_codigos.representantes
					OpenWithParm(w_fases_ficha_cliente,datos_cliente)
					id_cli = Message.StringParm
					this.SetItem(this.getrow(),'id_representante',id_cli)
				end if
			end if
		end if
		if nif <> '-1' then this.post setitem(this.getrow(),'nif_representante', nif)

	case 'nif_propiedad'
		// Si est$$HEX2$$e1002000$$ENDHEX$$borrando el nif, no miramos nada, simplemente dejamos el id de la propiedad vac$$HEX1$$ed00$$ENDHEX$$o
		if f_es_vacio(data) then
			nif  = ''
			this.SetItem(this.getrow(),'id_representante','')
		else
			// Guardamos el nif en una variable de instancia porque la usa el evento de b$$HEX1$$fa00$$ENDHEX$$squeda de clientes
			i_nif = data
			// SCP-99			
//			// El NIF / CIF tiene que ser de 9
//			if LenA(data) <> 9 then
//				messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_nif_9','El NIF/CIF tiene que ser de 9 posiciones.'))
//				return -1
//			end if
			nif = data
			if RightA(nif, 1) = '*' then
				nif = f_calculo_nif(nif)
				if nif = '-1' then return -1
			elseif RightA(nif,1) >= 'A' and RightA(nif,1) <= 'Z' then
				if not f_comprobar_nif(nif) then
					messagebox(g_titulo, g_idioma.of_getmsg('msg_cliente.letra_nif','La letra del NIF no es correcto'))
					return -1
				end if
			end if
	
			select count(*) into :num_clientes from clientes where nif=:nif;
			if num_clientes > 0 then  
				if num_clientes = 1 then
					this.setitem(this.getrow() ,'id_propiedad',f_cliente_id_cliente(nif))
				else
					this.triggerevent ("csd_abrir_busqueda_representante")
				end if
				mensaje=f_control_de_incidencias('P',f_cliente_id_cliente(nif))
			else
				if MessageBox(g_titulo,g_idioma.of_getmsg('fases.msg_prop_no_existe_pregunta','Esta propiedad NO existe, $$HEX1$$bf00$$ENDHEX$$Desea darla de alta?'),Question!,YesNo!,1)=1 then
					//Aqui va el c$$HEX1$$f300$$ENDHEX$$digo q abre la ventana 
					datos_cliente.nif=nif
					datos_cliente.tipo_tercero = g_terceros_codigos.codigo_cliente
					OpenWithParm(w_fases_ficha_cliente,datos_cliente)
					id_cli = Message.StringParm
					this.SetItem(this.getrow(),'id_propiedad',id_cli)
				end if
			end if
		end if
		if nif <> '-1' then this.post setitem(this.getrow(),'nif_propiedad', nif)
end choose

end event

event retrieveend;call super::retrieveend;string id_cliente, id_representante, id_propiedad
double i

for i=1 to rowcount
	id_cliente = this.GetItemString(i,'id_cliente')
	this.SetItem(i,'nif',f_dame_nif(id_cliente))
	id_representante = this.GetItemString(i,'id_representante')
	this.SetItem(i,'nif_representante',f_dame_nif(id_representante))
	id_propiedad = this.GetItemString(i,'id_propiedad')
	this.SetItem(i,'nif_propiedad',f_dame_nif(id_propiedad))	
next
this.resetupdate()
end event

event pfc_predeleterow;call super::pfc_predeleterow;//Tema referente a minutas...

return 1

string id_cli,mensaje
boolean encontrado=false
int i

mensaje=''
id_cli=this.getitemstring(this.getrow(),'id_cliente')

for i=1 to idw_fases_minutas.RowCount()
	if idw_fases_minutas.GetItemString(i,'id_cliente')=id_cli then
		encontrado =true
	end if
next

if encontrado then
	MessageBox(g_titulo,g_idioma.of_getmsg('fases.msg_cli_avisos_asig_borrar','El Cliente NO se puede borrar ya que tiene Avisos Asignados.'))
	return -1
end if
//this.TriggerEvent('comprobar_porcentajes')
return 1

end event

event pfc_preupdate;call super::pfc_preupdate;double i,suma_por=0

for i=1 to this.RowCount()
	suma_por = suma_por +	this.GetItemNumber(i,'porcen')	
next

g_suma_porcentajes_cli = suma_por

return 1

end event

event itemfocuschanged;call super::itemfocuschanged;choose case dwo.name
	case 'porcen'
		this.SelectText(1, LenA(string(double(this.GetText()),"##0.00")))
end choose
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'FASES_CLIENTES'
c_evento.dw = dw_fases_promotores
if f_control_eventos(c_evento)=-1 then return

end event

event key;call super::key;if  keydown(keycontrol!) and keydown(KeyRightArrow!) and  not keydown(KeyShift!)then 
	tab_1. post selecttab(2)
	idw_fases_colegiados. post setfocus()
	idw_fases_colegiados. post setcolumn('n_col')
	idw_fases_colegiados.post SelectText(1, LenA(idw_fases_colegiados.GetText()))
end if

end event

type tabpage_2 from userobject within tab_1
string tag = "texto=colegiados.colegiados"
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "Colegiados"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Move!"
long picturemaskcolor = 12632256
dw_fases_colegiados_asociados dw_fases_colegiados_asociados
dw_fases_colegiados dw_fases_colegiados
end type

on tabpage_2.create
this.dw_fases_colegiados_asociados=create dw_fases_colegiados_asociados
this.dw_fases_colegiados=create dw_fases_colegiados
this.Control[]={this.dw_fases_colegiados_asociados,&
this.dw_fases_colegiados}
end on

on tabpage_2.destroy
destroy(this.dw_fases_colegiados_asociados)
destroy(this.dw_fases_colegiados)
end on

type dw_fases_colegiados_asociados from u_dw within tabpage_2
event csd_retrieve ( long currentrow )
event csd_dddw_retrieve ( )
integer x = 3630
integer y = 20
integer width = 704
integer height = 784
integer taborder = 11
string dataobject = "d_fases_colegiados_asociados"
end type

event csd_dddw_retrieve;int filas
if idw_fases_colegiados.getrow() <= 0 then return
if f_colegiado_tipopersona(idw_fases_colegiados.getitemstring(idw_fases_colegiados.getrow(), 'id_col')) = 'S' then
	this.visible = true
	if i_dwc_colegiados_asociados.rowcount() <= 0 then i_dwc_colegiados_asociados.insertrow(0)
	i_dwc_colegiados_asociados.retrieve(idw_fases_colegiados.getitemstring(idw_fases_colegiados.getrow(), 'id_col'))
	if i_dwc_colegiados_asociados.rowcount() <= 0 then i_dwc_colegiados_asociados.insertrow(0)
	i_dwc_colegiados_asociados.filter()
else
	this.visible = false	
end if
end event

event constructor;call super::constructor;this.getchild('id_col_per',i_dwc_colegiados_asociados)

i_dwc_colegiados_asociados.settransobject(sqlca)
i_dwc_colegiados_asociados.InsertRow (0)
end event

event pfc_addrow;call super::pfc_addrow;// Si no hay filas en el desplegable condicional colocamos una

IF i_dwc_colegiados_asociados.RowCount()<1 THEN i_dwc_colegiados_asociados.InsertRow(0)
this.setitem(ancestorreturnvalue, 'id_fase', dw_1.getitemstring(1, 'id_fase'))
this.setitem(ancestorreturnvalue, 'id_col_aso', idw_fases_colegiados.getitemstring(idw_fases_colegiados.getrow(), 'id_col'))

return ancestorreturnvalue
end event

event pfc_insertrow;call super::pfc_insertrow;// Si no hay filas en el desplegable condicional colocamos una
IF i_dwc_colegiados_asociados.RowCount()<1 THEN i_dwc_colegiados_asociados.InsertRow(0)
this.setitem(ancestorreturnvalue, 'id_fase', dw_1.getitemstring(1, 'id_fase'))
this.setitem(ancestorreturnvalue, 'id_col_aso', idw_fases_colegiados.getitemstring(idw_fases_colegiados.getrow(), 'id_col'))

return ancestorreturnvalue
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;// Si no hay filas en el desplegable condicional colocamos una
IF i_dwc_colegiados_asociados.RowCount()<1 THEN i_dwc_colegiados_asociados.InsertRow(0)

return AncestorReturnValue
end event

event retrieveend;call super::retrieveend;i_dwc_colegiados_asociados.insertrow(0)



end event

event pfc_predeleterow;call super::pfc_predeleterow;if this.rowcount() = 1 then 
	messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_sociedad_socio','Una Sociedad debe tener al menos un socio'))
	return 0
end if
return 1
end event

event rowfocuschanged;call super::rowfocuschanged;event csd_dddw_retrieve()

end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, 'COLEG. ASOC.', dwo.name, row)
end event

type dw_fases_colegiados from u_dw within tabpage_2
event csd_borrar_cod ( )
event csd_borrar_empresa ( )
event csd_porcentajes ( )
event type boolean csd_validar_colegiado ( string id_col )
event csd_oculta_tab ( )
event csd_nombre_pestanyas ( string nombre )
event csd_cambiar_tipos_gestion_a_cgc ( )
event csd_cambiar_tipos_gestion_a_sgc ( )
event csd_imprimir_carta_notienemusaat ( string id_colegiado )
integer x = 18
integer y = 20
integer width = 3598
integer height = 784
integer taborder = 11
string dataobject = "d_fases_colegiados"
end type

event csd_borrar_cod;this.deleterow(0)
end event

event csd_borrar_empresa;this.setitem(this.getrow(),'empresa','N')
end event

event csd_porcentajes();double porcen_introducido, porcen_limite, porcen_restante
long i

porcen_limite = 100
porcen_introducido = 0


FOR i=1 TO this.RowCount()
	porcen_introducido = porcen_introducido + this.GetItemNumber(i,'porcen_a')
NEXT


if porcen_introducido > 100 then
	Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_porcentaje_mayor_100',"El porcentaje total es superior a 100. Rectif$$HEX1$$ed00$$ENDHEX$$quelo o se har$$HEX2$$e1002000$$ENDHEX$$el reparto proporcionalmente."), Exclamation!)
	return
end if

//La siguiente l$$HEX1$$ed00$$ENDHEX$$nea es por si ponen varios arquitectos a partes iguales
if porcen_introducido < 4 then porcen_limite = porcen_introducido

porcen_restante = porcen_limite - porcen_introducido

if porcen_restante = 0 then return

//A$$HEX1$$f100$$ENDHEX$$adimos el porcentaje restante:
this.event pfc_addrow()
this.SetItem(this.RowCount(),'porcen_a',porcen_restante)
this.SetRow(this.RowCount())
this.SetColumn('n_col')


end event

event csd_validar_colegiado;//string alta_baja,mensaje,tipo_in,mensaje2,col, cod_pob
//int num
//boolean incidencias=false
//datetime hoy,fdesde,fhasta
//
//mensaje = 'Este colegiado no se puede agregar: '+cr
// DECLARE incompatibilidades CURSOR FOR  
//  SELECT incompatibilidades.fecha_inicio,incompatibilidades.fecha_fin,  t_incompatibilidad.descripcion, incompatibilidades.cod_pob
//    FROM incompatibilidades, t_incompatibilidad  WHERE  incompatibilidades.incompatibilidad = 'S'  AND  
//        incompatibilidades.fecha_inicio <= :hoy AND   incompatibilidades.fecha_fin >= :hoy AND
//	 incompatibilidades.id_colegiado = :id_col AND  incompatibilidades.tipo_incompatibilidad = t_incompatibilidad.cod_incompatibilidad;
//
//hoy=datetime(today(),now())
//open incompatibilidades;
//fetch incompatibilidades into :fdesde, :fhasta, :tipo_in, :cod_pob;
//do while SQLCA.SQLcode = 0
//	mensaje2 += cr + 'Desde el  ' + string(fdesde,'dd/mm/yyyy') + ' hasta el ' + string(fhasta,'dd/mm/yyyy') + ' : '  + tipo_in + ' en ' + f_dame_poblacion(cod_pob)
//	fetch incompatibilidades into :fdesde, :fhasta, :tipo_in, :cod_pob;	
//loop
//close incompatibilidades;
//if len(mensaje2 ) > 0 then 
//	incidencias=true
//	mensaje=mensaje + cr + '- Tiene incompatibilidades:' + mensaje2
//end if
//
//if incidencias then
//	MessageBox(g_titulo,mensaje)
//end if
//
return true
//
end event

event csd_oculta_tab;int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event csd_nombre_pestanyas;parent.text=nombre
end event

event csd_cambiar_tipos_gestion_a_cgc;int i
for i=1 to this.rowcount()
	this.setitem(i, 'tipo_gestion', 'C')
next

end event

event csd_cambiar_tipos_gestion_a_sgc;int i
for i=1 to this.rowcount()
	this.setitem(i, 'tipo_gestion', 'P')
next

end event

event csd_imprimir_carta_notienemusaat(string id_colegiado);// Evento que imprime la carta para los colegiados que tienen seguro con otra aseguradora que no sea MUSAAT

datastore ds_carta
long fila
string n_col,nombre,app,companyia,tipo_actuacion,desc_actuacion
string id_fase,tipo_trabajo,trabajo,trabajo_int

ds_carta=create datastore
ds_carta.dataobject='d_carta_notienemusaat_tgn'

ChangeDirectory(g_dir_aplicacion)

id_fase=dw_1.GetItemString(dw_1.GetRow(),'id_fase')
select n_colegiado,nombre,apellidos into :n_col,:nombre,:app from colegiados where id_colegiado=:id_colegiado;
select nom_s into :companyia from musaat m,musaat_cias_aseguradoras c where m.id_col=:id_colegiado and m.src_cia=c.cod_s;


select tf.d_t_descripcion,tt.d_t_trabajo,t.d_trabajo,d.descripcion
into :desc_actuacion,:tipo_trabajo,:trabajo,:trabajo_int 
from fases f,t_fases tf,tipos_trabajos tt,trabajos t,t_destinos d
where f.id_fase=:id_fase and tf.c_t_fase=f.fase and f.tipo_trabajo=tt.c_t_trabajo and f.trabajo=t.c_trabajo and f.destino_int=d.codigo;


if not(f_es_vacio(nombre)) then app=nombre+' '+app

	

fila=ds_carta.insertrow(0)
ds_carta.SetItem(fila,'n_col',n_col)
ds_carta.SetItem(fila,'nombre',app)
ds_carta.SetItem(fila,'intervencion',desc_actuacion+'-'+tipo_trabajo+'-'+trabajo+'-'+trabajo_int)
ds_carta.SetItem(fila,'companyia',companyia)
ds_carta.print()


end event

event buttonclicked;st_control_eventos c_evento
string id_colegiado,col,alta_baja,cobertura
int i
double suma_porcentajes_col,cant, coef_cm
any mensaje
string situacion,c_geografico

choose case dwo.name
	case 'cb_busqueda_colegiados'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		
		id_colegiado=f_busqueda_colegiados()
		if f_es_vacio(id_colegiado) then return
		this.setitem(row,'id_col',id_colegiado)
		select n_colegiado,situacion,c_geografico into :col,:situacion,:c_geografico from colegiados where id_colegiado = :id_colegiado;
		this.setitem(row,'n_col',col)
//		this.setitem(row,'observaciones',string(mensaje))
		this.setitem(row,'observaciones','')
		this.setitem(row,'c_geografico',c_geografico)
		this.setitem(row,'situacion',situacion)		
		
		for i = idw_fases_colegiados_asociados.rowcount() to 1 step -1
			idw_fases_colegiados_asociados.deleterow(i)
		next
		idw_fases_colegiados_asociados.update()								
		if f_colegiado_tipopersona(id_colegiado) = 'S' then	
			
			idw_fases_colegiados_asociados.visible = true
			datastore ds_colegiados_asociados
			ds_colegiados_asociados = create datastore
			// Modificado David 28/02/2006 - Obtenemos el porcentaje real, quitando los posibles asociados no colegiados
			ds_colegiados_asociados.dataobject = 'ds_colegiados_personas' //'d_colegiados_personas'
			ds_colegiados_asociados.settransobject(sqlca)								
			ds_colegiados_asociados.retrieve(id_colegiado)
			idw_fases_colegiados.setredraw(false)
			for i = 1 to ds_colegiados_asociados.rowcount()
				idw_fases_colegiados_asociados.event pfc_addrow()
				// Modificado David 28/02/2006 - Obtenemos el porcentaje real, quitando los posibles asociados no colegiados
				idw_fases_colegiados_asociados.setitem(i, 'porcent', ds_colegiados_asociados.getitemnumber(i, 'porc_col_real')) //'porcent'))
				//Luis CAL-242
				if(g_colegio = 'COAATA')then
					idw_fases_colegiados_asociados.setitem(i, 'porcent',0)
				end if
				//fin cambio
				idw_fases_colegiados_asociados.setitem(i, 'id_col_per', ds_colegiados_asociados.getitemstring(i, 'id_col_per'))

				// Para que se haga por cada colegiado de la sociedad INC. 6762
				c_evento.id_colegiado = ds_colegiados_asociados.getitemstring(i, 'id_col_per')
				c_evento.evento = 'FASES_COLEGIADOS_NCO'
				c_evento.dw = this 
				mensaje=f_control_eventos(c_evento)
			next
			idw_fases_colegiados.setredraw(true)
			destroy ds_colegiados_asociados			
		else
			idw_fases_colegiados_asociados.visible = false
			
			c_evento.id_colegiado = id_colegiado
			c_evento.evento = 'FASES_COLEGIADOS_NCO'
			c_evento.dw = this 
			mensaje=f_control_eventos(c_evento)
		end if		
		
		SELECT musaat.src_cober, musaat.src_coef_cm INTO :cobertura, :coef_cm FROM musaat WHERE musaat.id_col = :id_colegiado ;
		if not isnull(cobertura) then this.setitem(row,'cobertura',cobertura)
		if not isnull(coef_cm) then this.setitem(row,'coef_cm',coef_cm)

		this.setitem(row,'tiene_src', f_colegiado_tiene_src(id_colegiado))
		this.setitem(row,'src_cia', f_colegiado_src_cia(id_colegiado))

	case 'b_ficha_col'
		id_colegiado=this.GetItemString(row,'id_col')
		select count(*) into :cant from colegiados where colegiados.id_colegiado=:id_colegiado;
		if cant >0 then
			if not(f_es_vacio(id_colegiado)) then
				//datos_colegiado.id_colegiado= id_colegiado
				OpenWithParm(w_fases_ficha_colegiado,id_colegiado)
			end if
		else	
			MessageBox(g_titulo,g_idioma.of_getmsg('msg_musaat.colegiado_no_existe','El colegiado NO existe.'))
		end if
	case 'b_borra_empresa'
		this.setitem(row, 'id_empresa', '')
	case else
end choose

end event

event getfocus;call super::getfocus;selecttextall()
end event

event itemchanged;st_control_eventos c_evento
int    i
string alta_baja,id,empresa,id_col,id_fase,cobertura
double suma=0,total_hon,por,suma_porcentajes_col, coef_cm
boolean valido
any mensaje
string c_geografico,situacion

// Modificacion de Datos
//dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, 'DETALLE', dwo.name, row)
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, Upper(Parent.text), dwo.name, row)

choose case dwo.name
	case 'n_col'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_col',f_colegiado_id_col(data))
		
		// Las observaciones se ponen con el control de eventos
		//	if double(mensaje) <> 1 then
		//		this.setitem(row,'observaciones',string(mensaje))
		//	end if
		select situacion,c_geografico into :situacion,:c_geografico from colegiados where id_colegiado = :id_col;	
		this.setitem(row,'observaciones','')
		this.setitem(row,'c_geografico',c_geografico)
		this.setitem(row,'situacion',situacion)				
		// Si es asociaci$$HEX1$$f300$$ENDHEX$$n
		// Borro para que no quede basura en la bd
		for i = idw_fases_colegiados_asociados.rowcount() to 1 step -1
			idw_fases_colegiados_asociados.deleterow(i)
		next
		idw_fases_colegiados_asociados.update()
		
		if f_colegiado_tipopersona(f_colegiado_id_col(data)) = 'S' then	
			idw_fases_colegiados_asociados.visible = true
			datastore ds_colegiados_asociados
			ds_colegiados_asociados = create datastore						
			// Modificado David 28/02/2006 - Obtenemos el porcentaje real, quitando los posibles asociados no colegiados
			ds_colegiados_asociados.dataobject = 'ds_colegiados_personas' //'d_colegiados_personas'
			ds_colegiados_asociados.settransobject(sqlca)								
			ds_colegiados_asociados.retrieve(f_colegiado_id_col(data))
			idw_fases_colegiados.setredraw(false)
			
			for i = 1 to ds_colegiados_asociados.rowcount()
				idw_fases_colegiados_asociados.event pfc_addrow()
				// Modificado David 28/02/2006 - Obtenemos el porcentaje real, quitando los posibles asociados no colegiados
				idw_fases_colegiados_asociados.setitem(i, 'porcent', ds_colegiados_asociados.getitemnumber(i, 'porc_col_real')) //'porcent'))
				//Luis CAL-242
				if(g_colegio = 'COAATA')then
					idw_fases_colegiados_asociados.setitem(i, 'porcent',0)
				end if
				//fin cambio
				idw_fases_colegiados_asociados.setitem(i, 'id_col_per', ds_colegiados_asociados.getitemstring(i, 'id_col_per'))
				
				// Para que se haga por cada colegiado de la sociedad INC. 6762
				c_evento.id_colegiado = ds_colegiados_asociados.getitemstring(i, 'id_col_per')
				c_evento.evento = 'FASES_COLEGIADOS_NCO'
				c_evento.dw = this 
				mensaje=f_control_eventos(c_evento)
			next
			idw_fases_colegiados.setredraw(true)
			destroy ds_colegiados_asociados			
		else
			idw_fases_colegiados_asociados.visible = false
			
			c_evento.id_colegiado = id_col
			c_evento.evento = 'FASES_COLEGIADOS_NCO'
			c_evento.dw = this 
			mensaje=f_control_eventos(c_evento)
		end if
		
		SELECT musaat.src_cober, musaat.src_coef_cm INTO :cobertura, :coef_cm FROM musaat WHERE musaat.id_col = :id_col ;
		if not isnull(cobertura) then this.setitem(row,'cobertura',cobertura)
		if not isnull(coef_cm) then this.setitem(row,'coef_cm',coef_cm)
				
		this.setitem(row,'tiene_src', f_colegiado_tiene_src(id_col))
		this.setitem(row,'src_cia', f_colegiado_src_cia(id_col))
		
	case 'porcen_a'
		i_porcen=getitemnumber(this.getrow(),'porcen_a')
		this.postevent("csd_porcentajes")
//		if g_suma_porcentajes_col > 100 then
//			messagebox(g_titulo,'La participaci$$HEX1$$f300$$ENDHEX$$n de los colegiados es mayor de 100.')
//		end if
	// funcionario
	case 'facturado'
		if data = 'S' then
			messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_marcar_col_funcionario','$$HEX3$$a100a100a100$$ENDHEX$$Atenci$$HEX1$$f300$$ENDHEX$$n!!! : Marcar este colegiado como funcionario supondr$$HEX2$$e1002000$$ENDHEX$$que no se le cobrar$$HEX2$$e1002000$$ENDHEX$$MUSAAT en obras oficiales'))
		end if
	case 'renunciado'
		// Para Caceres evitamos que se pueda cambiar el check manualmente sin pasar por la ventana de seleccion
		if g_colegio='COAATCC' then return 2
	case else
end choose
end event

event pfc_predeleterow;call super::pfc_predeleterow;string id_col,mensaje,mensaje_ini
boolean encontrado=false
int i

mensaje=''
mensaje_ini = g_idioma.of_getmsg('fases.msg_borrar_colegiado','El Colegiado NO se puede borrar :')

id_col=this.getitemstring(this.getrow(),'id_col')
mensaje=f_fases_borro_colegiado(id_col,idw_fases_src,idw_fases_reparos)


for i=1 to idw_fases_minutas.RowCount()
	if idw_fases_minutas.GetItemString(i,'id_colegiado')=id_col then
		encontrado =true
	end if
next
if encontrado then mensaje = mensaje + cr + g_idioma.of_getmsg('fases.msg_avisos_asignados','- Tiene Avisos Asignados.')
encontrado = false

for i=1 to idw_fases_reparos.RowCount()
	if idw_fases_reparos.GetItemString(i,'id_col')=id_col then
		encontrado=true
	end if
next
//if encontrado then mensaje = mensaje + cr + '- Tiene Reparos Emitidos.'
encontrado = false

for i=1 to idw_fases_src.RowCount()
	if idw_fases_src.GetItemString(i,'id_col')=id_col then
		encontrado=true
	end if
next
if encontrado then mensaje = mensaje + cr + g_idioma.of_getmsg('fases.msg_tiene_musaat','- Tiene Musaat.')

if mensaje <> '' then
	MessageBox(g_titulo,mensaje_ini + mensaje)
	return -1
else
	// Si es asociaci$$HEX1$$f300$$ENDHEX$$n
	// Borro para que no quede basura en la bd
	for i = idw_fases_colegiados_asociados.rowcount() to 1 step -1
		idw_fases_colegiados_asociados.deleterow(i)
	next
	idw_fases_colegiados_asociados.update()								
end if
this.TriggerEvent('comprobar_porcentajes')
return 1

end event

event dw_fases_colegiados::pfc_preupdate;call super::pfc_preupdate;string id_col
double suma_por=0,i

if this.RowCount()>0 then
	id_col=this.GetItemString(this.GetRow(),'id_col')

	for i=1 to this.RowCount()
		suma_por= suma_por+this.GetItemNumber(i,'porcen_a')	
	next
	
	g_suma_porcentajes_col = suma_por

this.Event Trigger csd_validar_colegiado(id_col)
end if
return 1
end event

event retrieveend;call super::retrieveend;int i

// Si el estado es distinto de '00' se realizan las acciones, sino significa que la fase es 'Preasignada' con lo cual esta vac$$HEX1$$ed00$$ENDHEX$$a
if this.rowcount() > 0 then
	for i=1 to this.rowcount() 
		this.setitem(i,'n_col',f_colegiado_n_col(this.getitemstring(i,'id_col')))
	next
	this.resetupdate()

	if dw_1.GetItemString(dw_1.GetRow(),'estado')<>g_fases_estados.preasignado then
		idw_fases_colegiados.TriggerEvent('comprobar_porcentajes')
		If i_dwc_colegiados_empresas.Retrieve(this.GetItemString(1,'id_col'))<1 THEN i_dwc_colegiados_empresas.insertrow(0)
	end if	

end if
end event

event rowfocuschanged;call super::rowfocuschanged;tab_1.tabpage_2.dw_fases_colegiados_asociados.post event csd_dddw_retrieve()
if isvalid(w_descuentos_colegiado)  then
	w_descuentos_colegiado.triggerevent('csd_cargar_datos')
end if


end event

event rowfocuschanging;call super::rowfocuschanging;if idw_fases_colegiados_asociados.event pfc_updatespending() = 1  then
	if messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_datos_asociados','Los datos de los asociados han cambiado, $$HEX1$$bf00$$ENDHEX$$Desea guardarlos?'), Question!, YesNo!) = 1 then
		this.update()
		idw_fases_colegiados_asociados.update()
	end if
end if
end event

event pfc_addrow;call super::pfc_addrow;this.SetItem(ancestorreturnvalue,'id_fases_colegiados',f_siguiente_numero('ID_FASES_COLEGIADOS',10))
this.SetItem(ancestorreturnvalue,'tipo_gestion',dw_1.getitemstring(1,'tipo_gestion'))
return ancestorreturnvalue
end event

event pfc_insertrow;call super::pfc_insertrow;this.SetItem(ancestorreturnvalue,'id_fases_colegiados',f_siguiente_numero('ID_FASES_COLEGIADOS',10))
this.SetItem(ancestorreturnvalue,'tipo_gestion',dw_1.getitemstring(1,'tipo_gestion'))
return ancestorreturnvalue
end event

event itemfocuschanged;call super::itemfocuschanged;choose case dwo.name
	case 'porcen_a'
		this.SelectText(1, LenA(string(double(this.GetText()),"##0.00")))
end choose
end event

event doubleclicked;st_fases_colegiados datos
string obser,data_item
long filas,retorno

if row <= 0 then return

choose case dwo.name
	case 'observaciones'
		g_busqueda.titulo="Observaciones"
		obser    =this.GetItemString(row, 'observaciones')
		data_item=this.getitemstring(row, 'observaciones') // para control modificaciones
		openwithparm(w_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
			if not isnull(obser) then 
//			   if data_item<>obser then dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, "DETALLE", 'observaciones', row)
				THIS.SetItem(row,'observaciones',obser)
			end if 	
		end if
	case else
		// SCP-2048
		if this.Event pfc_updatespending() > 0 then 
			MessageBox(g_titulo,'Hay cambios pendientes. Debe grabar antes de continuar.')
			return
		end if

		datos.porcen_a = this.GetItemNumber(row,'porc_aut')
		datos.porcen_b = this.GetItemNumber(row,'porcen_d')
		datos.porcen_gastos = this.GetItemNumber(row,'porcen_a') //porcentaje sobre el que se calculan las facturas
		datos.autor = this.GetItemString(row,'tipo_a')
		datos.director = this.GetItemString(row,'tipo_d')
		datos.empresa = this.GetItemString(row,'empresa')
		datos.cobertura = this.GetItemString(row,'cobertura')
		datos.observaciones = this.GetItemString(row,'observaciones')
		datos.facturado = this.GetItemString(row,'facturado')
		datos.id_col = this.GetItemString(row,'id_col')
		datos.renunciado = this.GetItemString(row,'renunciado')
		datos.tipo_gestion = this.GetItemString(row,'tipo_gestion')
		datos.otro_seguro = this.GetItemString(row,'otro_seguro')
		datos.coef_cm = this.GetItemNumber(row,'coef_cm')
		datos.situacion = this.GetItemString(row,'situacion')
		datos.c_geografico =  this.GetItemString(row,'c_geografico')		
		datos.id_empresa =  this.GetItemString(row,'id_empresa')			
		datos.id_fase =  this.GetItemString(row,'id_fase')	
		select count(*) INTO :filas FROM fases_colegiados WHERE ( fases_colegiados.id_fase = :datos.id_fase ) AND ( fases_colegiados.id_col = :datos.id_col );    
		
		if(filas > 0)then
			OpenWithParm(w_fases_colegiados_extenso,datos)
		else
			Messagebox(g_titulo, 'El colegiado no est$$HEX2$$e1002000$$ENDHEX$$asociado al contrato.')
			return
		end if
		datos = Message.PowerObjectParm
		if datos.modificado = true then
			this.SetItem(row,'porc_aut',datos.porcen_a)
			this.SetItem(row,'porcen_d',datos.porcen_b)
			this.SetItem(row,'porcen_a',datos.porcen_gastos)
			this.SetItem(row,'tipo_a',datos.autor)
			this.SetItem(row,'tipo_d',datos.director)
			this.SetItem(row,'empresa',datos.empresa)
			this.SetItem(row,'facturado',datos.facturado)			
			this.SetItem(row,'cobertura',datos.cobertura)
			this.SetItem(row,'observaciones',datos.observaciones)
			this.SetItem(row,'renunciado',datos.renunciado)
			this.SetItem(row,'tipo_gestion',datos.tipo_gestion)
			this.SetItem(row,'otro_seguro',datos.otro_seguro)
			this.SetItem(row,'coef_cm',datos.coef_cm)
			//this.SetItem(row,'c_geografico',datos.c_geografico)
			//this.SetItem(row,'situacion',datos.situacion)			
			this.SetItem(row,'id_empresa',datos.id_empresa)					
		end if		
end choose

end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'FASES_COLEGIADOS'
c_evento.dw = dw_fases_colegiados
if f_control_eventos(c_evento)=-1 then return


this.GetChild('id_empresa',i_dwc_colegiados_empresas)

i_dwc_colegiados_empresas.settransobject(sqlca)
i_dwc_colegiados_empresas.InsertRow (0)
end event

event key;call super::key;if  keydown(keycontrol!) and keydown(KeyRightArrow!) and  not keydown(KeyShift!) then 
	tab_1. post selecttab(3)
	idw_fases_estadistica. post setfocus()
	idw_fases_estadistica. post setcolumn('tipo_viv')
	idw_fases_estadistica.post SelectText(1, LenA(idw_fases_estadistica.GetText()))
end if
if  keydown(keycontrol!) and keydown(KeyLeftArrow!)  and  not keydown(KeyShift!) then 
	tab_1. post selecttab(1)
	idw_fases_promotores. post setfocus()
	idw_fases_promotores. post setcolumn('nif')
	idw_fases_promotores.post SelectText(1, LenA(idw_fases_promotores.GetText()))	
end if
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;// Si no hay filas en el desplegable condicional colocamos una
IF i_dwc_colegiados_empresas.RowCount()<1 THEN i_dwc_colegiados_empresas.InsertRow(0)

return AncestorReturnValue

end event

event clicked;call super::clicked;choose case dwo.name 
	case 'id_empresa'
		If i_dwc_colegiados_empresas.Retrieve(this.GetItemString(row,'id_col')) <1 THEN i_dwc_colegiados_empresas.insertrow(0)
	case 'renunciado'
		if g_colegio='COAATCC' then
			openWithParm(w_fases_renuncia_selec,this.GetItemString(row,'renunciado'))
			if not(f_es_vacio(Message.StringParm)) then
				this.SetItem(row,'renunciado',Message.StringParm)
			end if
		end if
end choose

end event

type tabpage_5 from userobject within tab_1
string tag = "texto=menu.estadisticas"
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "Estad$$HEX1$$ed00$$ENDHEX$$stica"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Graph!"
long picturemaskcolor = 12632256
pb_calcular_dtos_nuevo pb_calcular_dtos_nuevo
pb_calcular_dtos pb_calcular_dtos
dw_fases_estadistica_otros dw_fases_estadistica_otros
dw_fases_estadistica dw_fases_estadistica
end type

on tabpage_5.create
this.pb_calcular_dtos_nuevo=create pb_calcular_dtos_nuevo
this.pb_calcular_dtos=create pb_calcular_dtos
this.dw_fases_estadistica_otros=create dw_fases_estadistica_otros
this.dw_fases_estadistica=create dw_fases_estadistica
this.Control[]={this.pb_calcular_dtos_nuevo,&
this.pb_calcular_dtos,&
this.dw_fases_estadistica_otros,&
this.dw_fases_estadistica}
end on

on tabpage_5.destroy
destroy(this.pb_calcular_dtos_nuevo)
destroy(this.pb_calcular_dtos)
destroy(this.dw_fases_estadistica_otros)
destroy(this.dw_fases_estadistica)
end on

type pb_calcular_dtos_nuevo from picturebutton within tabpage_5
integer x = 3794
integer y = 208
integer width = 535
integer height = 148
integer taborder = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Calcular Dtos. Real Decreto"
boolean originalsize = true
vtextalign vtextalign = multiline!
end type

event clicked;st_control_eventos c_evento	
int i

if g_colegio = 'COAATCC' then 
	
	for i = 1 to idw_fases_colegiados.rowcount()
		c_evento.evento = 'FASES_COLEGIADOS_NCO'
		c_evento.dw = idw_fases_colegiados
		c_evento.id_colegiado = idw_fases_colegiados.getitemstring(i, 'id_col')	
		f_control_eventos(c_evento)
	next
end if

g_detalle_fases.event pfc_save()
tab_1.tabpage_8.pb_recalcular_nuevo.triggerevent(clicked!)

// Pedimos grabar
g_detalle_fases.event pfc_save()


end event

type pb_calcular_dtos from picturebutton within tabpage_5
integer x = 3794
integer y = 48
integer width = 535
integer height = 148
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Calcular Dtos. Anteriores a Decreto"
boolean originalsize = true
vtextalign vtextalign = multiline!
end type

event clicked;g_detalle_fases.event pfc_save()
tab_1.tabpage_8.pb_recalcular.triggerevent(clicked!)

// Pedimos grabar
g_detalle_fases.event pfc_save()

end event

type dw_fases_estadistica_otros from u_dw within tabpage_5
event csd_enlaza ( )
boolean visible = false
integer x = 2354
integer y = 192
integer width = 2565
integer height = 532
integer taborder = 11
string dataobject = "d_fases_expedientes_estadistica_cc_mca"
boolean vscrollbar = false
boolean border = false
end type

event csd_enlaza();string id_fase
long fila

f_enlaza_dw(dw_1,idw_fases_estadistica_otros,'id_fase','id_fase')
id_fase=dw_1.GetItemString(1,'id_fase')
if this.Retrieve(id_fase)=0 then
	fila=this.insertrow(0)
	this.SetItem(fila,'id_fase',id_fase)
	this.SetItem(fila,'id_fases_estadisticas',f_siguiente_numero('FASES_ESTAD_OTROS',10))
end if
this.visible = true

end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'FASES_ESTAD_OTROS'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return


this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event retrieveend;call super::retrieveend;long fila
long i,cont = 0, linea
string incidencia, expedi
datetime fecha

if rowcount()=0 then
	fila=this.insertrow(0)
	this.SetItem(fila,'id_fase',dw_1.GetItemString(dw_1.GetRow(),'id_fase'))
	this.SetItem(fila,'id_fases_estadisticas',f_siguiente_numero('FASES_ESTAD_OTROS',10))
end if

if(g_colegio = 'COAATMCA')then
	this.accepttext()
	incidencia=f_siguiente_numero('INCIDENCIAS-EXP', 10)
	expedi=dw_1.getitemstring(1,'id_expedi')
	fecha=datetime(today(), time('00:00:00'))
	if(this.getitemdatetime(1,'f_visado_pb') > datetime(date('29/09/2006'), time('00:00:00')) or this.getitemdatetime(1,'f_visado_pe') > datetime(date('29/09/2006'), time('00:00:00')))then
		select count(*) into :cont from incidencias_exp where exp = :expedi and codigo = '01';			
		if(cont = 0)then
			INSERT INTO incidencias_exp
			VALUES (:incidencia,:expedi,:fecha,'01',"Final obra CTE");
		end if
		cont = 0
	end if
end if
end event

type dw_fases_estadistica from u_dw within tabpage_5
event csd_oculta_tab ( )
event csd_nombre_pestanyas ( string nombre )
integer x = 18
integer y = 20
integer width = 4315
integer height = 784
integer taborder = 70
string dataobject = "d_fases_expedientes_estadistica"
boolean ib_rmbmenu = false
end type

event csd_oculta_tab;int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event csd_nombre_pestanyas;parent.text=nombre
end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(dw_1.getitemstring(1,'id_fase'), this, Upper(Parent.text), dwo.name, row)

double pto, porc, honos
boolean recalcular = false

choose case dwo.name
	case 'pem'
		// Si el % no es visible no se hace nada
		if dw_1.object.porc_honorarios.visible = '0' then return
		
		pto = double(data)
		porc = dw_1.getitemnumber(1, 'porc_honorarios')
		if isnull(porc) then porc = 0
		honos = dw_1.getitemnumber(1, 'honorarios')
		if isnull(honos) then honos = 0
	//	if porc <> 0 and honos <> 0 then
		if porc > 0 then
			if messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_recalcula_honorarios','Desea recalcular los honorarios del contrato en funci$$HEX1$$f300$$ENDHEX$$n del porcentaje'), Question!, YesNo!) = 1 then
				honos = f_redondea(pto * porc /100)
				recalcular = true
			end if
		end if
	//	end if
		if porc <> 0 and honos = 0 then recalcular = true
		if recalcular then dw_1.setitem(1, 'honorarios', honos)
		
		st_control_eventos c_evento
		c_evento.evento = 'ITEMCHANGED'
		c_evento.dw = this
		c_evento.param1 = dwo.name
		c_evento.param2 = string(data)
		if f_control_eventos(c_evento)=-1 then return
end choose

end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
if this.rowcount() > 0 then 
	am_dw.m_table.m_addrow.enabled = false
else
	am_dw.m_table.m_addrow.enabled = true
end if
am_dw.m_table.m_delete.enabled = true
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'FASES_ESTADISTICA'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return




// Modificado Ricardo 04-02-17
// Para todos los dem$$HEX1$$e100$$ENDHEX$$s lo ocultamos siempre
this.object.ctrl_calidad_interno.visible = false
// FIN Modificado Ricardo 04-02-17

// Modificado David 10-03-2004
//if g_colegio = 'COAATTFE' then 
//	this.object.ctrl_calidad_interno.visible = true
//	// Modificado Ricardo 04-04-06
//	// Quieren cambiar los nombres de los check
////	this.object.cc_externo.text = "Control de Calidad Interno:"
////	this.object.ctrl_calidad_interno.text = "Control de Calidad Externo:"
//	// FIN Modificado Ricardo 04-04-06
//end if

end event

event retrieveend;call super::retrieveend;if this.rowcount() = 0 and g_colegio = 'COAATTFE' then trigger event pfc_addrow()

// Modificado por Ricardo 04-02-16
if rowcount > 0 then
	if f_es_vacio(this.getitemstring(rowcount, 'ctrl_calidad_interno')) then
		//Colocamos un valor por defecto
		this.SetItem(rowcount, 'ctrl_calidad_interno', 'N')
		this.update()
	end if
end if
// FIN Modificado por Ricardo 04-02-16


end event

event pfc_addrow;call super::pfc_addrow;this.setitem(1, 'id_uso', f_siguiente_numero('FASES_USOS', 10))

return 1
end event

event pfc_insertrow;call super::pfc_insertrow;this.setitem(1, 'id_uso', f_siguiente_numero('FASES_USOS', 10))

return 1
end event

event key;call super::key;
if  keydown(keycontrol!) and keydown(KeyLeftArrow!) and  not keydown(KeyShift!)  then 
	tab_1. post selecttab(2)
	idw_fases_colegiados. post setfocus()
	idw_fases_colegiados. post setcolumn('n_col')
	idw_fases_colegiados.post SelectText(1, LenA(idw_fases_colegiados.GetText()))		
end if
// Permitimos el borrado del campo de 'tipo de promotor' con la tecla suprimir
string sl_cadena_nula
setnull(sl_cadena_nula)
if  keydown(keydelete!) then
	if this.getcolumnname() = 't_promotor' then this.setitem(1,'t_promotor', sl_cadena_nula)
end if
end event

event itemfocuschanged;call super::itemfocuschanged;CHOOSE CASE lower(dwo.name)
	case 'presupuesto', 'pem'
		this.SelectText(1, LenA(string(double(this.GetText()),"###,###,###.00")))
END CHOOSE
end event

type tabpage_19 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "CIP"
long tabtextcolor = 8388608
long tabbackcolor = 79416533
string picturename = "Compute!"
long picturemaskcolor = 12632256
cip_tfe cip_tfe
end type

on tabpage_19.create
this.cip_tfe=create cip_tfe
this.Control[]={this.cip_tfe}
end on

on tabpage_19.destroy
destroy(this.cip_tfe)
end on

type cip_tfe from u_dw within tabpage_19
event csd_oculta_tab ( )
event csd_enlaza ( )
event csd_nombre_pestanyas ( string nombre )
integer x = 18
integer y = 20
integer width = 4315
integer height = 784
integer taborder = 11
string dataobject = "d_fases_cip_tfe"
end type

event csd_oculta_tab();int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event csd_enlaza();f_enlaza_dw(dw_1,cip_tfe,'id_fase','id_fase')
this.Retrieve(dw_1.GetItemString(1,'id_fase'))
this.visible = true

end event

event csd_nombre_pestanyas(string nombre);parent.text=nombre
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'FASES_CIP'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

end event

event buttonclicked;call super::buttonclicked;string med, obr, legalizacion,tarif
double pem_min, coef_a, coef_b, coef_c
st_calculo_honorarios st_hon
datastore ds_honos
		
idw_fases_estadistica.AcceptText()
st_hon.id_fase = dw_1.getitemstring(1, 'id_fase')

CHOOSE CASE dwo.name
	CASE 'b_calc_honos'
		CHOOSE CASE g_colegio
			CASE 'COAATCU'
				openwithparm(w_calculo_honorarios, st_hon)
				ds_honos = Message.PowerObjectParm
				if isvalid(ds_honos) then f_configura_parametros_fases_honos_cu (ds_honos.getitemstring(1,'tarifa'), this, ds_honos, 'F')
				
			CASE 'COAATZ', 'COAATTER'
				st_hon.presupuesto = idw_fases_estadistica.getitemnumber(1, 'pem')
				st_hon.superficie = idw_fases_estadistica.getitemnumber(1, 'sup_total')
				st_hon.altura = idw_fases_estadistica.getitemnumber(1, 'altura')
				st_hon.volumen = idw_fases_estadistica.getitemnumber(1, 'volumen')
				
				med = idw_fases_estadistica.getitemstring(1, 'colindantes')
				obr = dw_1.getitemstring(1, 'tipo_trabajo')
				st_hon.medianeras = f_coef_tipologia_medianeras(med, obr, st_hon.volumen)
				// Par$$HEX1$$e100$$ENDHEX$$metros del pem m$$HEX1$$ed00$$ENDHEX$$nimo
				SELECT fases_cip_tfe.pem_min, fases_cip_tfe.coef_a, fases_cip_tfe.coef_b, fases_cip_tfe.coef_c  
				INTO :pem_min, :coef_a, :coef_b, :coef_c
				FROM fases_cip_tfe  
				HAVING ( fases_cip_tfe.id_fase = :st_hon.id_fase )   ;
				
				st_hon.pem_min = pem_min
				st_hon.coef_a = coef_a
				st_hon.coef_b = coef_b
				st_hon.coef_c = coef_c
				openwithparm(w_calculo_honorarios_za, st_hon)
				
				ds_honos = Message.PowerObjectParm
			
				if isvalid(ds_honos) then
					tarif=ds_honos.getitemstring(1,'tarifa')
					f_configura_parametros_fases_honos_za (tarif, this, ds_honos, 'F')
				end if				
			CASE 'COAATGU'
				st_hon.presupuesto = idw_fases_estadistica.getitemnumber(1, 'pem')
				st_hon.superficie = idw_fases_estadistica.getitemnumber(1, 'sup_total')
				st_hon.admon = dw_fases_datos_exp.getitemstring(1, 'administracion')
				st_hon.fecha = dw_1.GetItemdatetime(1,'f_entrada')
				openwithparm(w_calculo_gastos_honorarios_gu, st_hon)
				ds_honos = Message.PowerObjectParm
				if isvalid(ds_honos) then f_configura_parametros_fases_honos_gu (ds_honos.getitemstring(1,'tarifa'), this, ds_honos, 'F')
				
			CASE 'COAATLE'
				st_hon.presupuesto = idw_fases_estadistica.getitemnumber(1, 'pem')
				st_hon.superficie = idw_fases_estadistica.getitemnumber(1, 'sup_total')
				st_hon.altura = idw_fases_estadistica.getitemnumber(1, 'altura')
				st_hon.volumen = idw_fases_estadistica.getitemnumber(1, 'volumen')
				med = idw_fases_estadistica.getitemstring(1, 'colindantes')
				obr = dw_1.getitemstring(1, 'tipo_trabajo')
				st_hon.medianeras = f_coef_tipologia_medianeras(med, obr, st_hon.volumen)
				openwithparm(w_calculo_honorarios_le, st_hon)
				ds_honos = Message.PowerObjectParm
				if isvalid(ds_honos) then f_configura_parametros_fases_honos_le (ds_honos.getitemstring(1,'tarifa'), this, ds_honos, 'F')

			CASE 'COAATAVI'
				st_hon.presupuesto = idw_fases_estadistica.getitemnumber(1, 'pem')
				st_hon.superficie = idw_fases_estadistica.getitemnumber(1, 'sup_total')
				st_hon.altura = idw_fases_estadistica.getitemnumber(1, 'altura')
				st_hon.volumen = idw_fases_estadistica.getitemnumber(1, 'volumen')

				med = idw_fases_estadistica.getitemstring(1, 'colindantes')
				obr = dw_1.getitemstring(1, 'tipo_trabajo')
				st_hon.medianeras = f_coef_tipologia_medianeras(med, obr, st_hon.volumen)
				// Par$$HEX1$$e100$$ENDHEX$$metros del pem m$$HEX1$$ed00$$ENDHEX$$nimo
				SELECT fases_cip_tfe.pem_min, fases_cip_tfe.coef_a, fases_cip_tfe.coef_b, fases_cip_tfe.coef_c  
				INTO :pem_min, :coef_a, :coef_b, :coef_c
				FROM fases_cip_tfe  
				HAVING ( fases_cip_tfe.id_fase = :st_hon.id_fase )   ;
				
				st_hon.pem_min = pem_min
				st_hon.coef_a = coef_a
				st_hon.coef_b = coef_b
				st_hon.coef_c = coef_c
				openwithparm(w_calculo_honorarios_avi, st_hon)
				
				ds_honos = Message.PowerObjectParm
				if isvalid(ds_honos) then f_configura_parametros_fases_honos_avi (ds_honos.getitemstring(1,'tarifa'), this, ds_honos, 'F')

			CASE 'COAATCC'
				st_hon.presupuesto = idw_fases_estadistica.getitemnumber(1, 'pem')
				st_hon.superficie = idw_fases_estadistica.getitemnumber(1, 'sup_total')
				st_hon.altura = idw_fases_estadistica.getitemnumber(1, 'altura')
				st_hon.volumen = idw_fases_estadistica.getitemnumber(1, 'volumen')
			
				med = idw_fases_estadistica.getitemstring(1, 'colindantes')
				obr = dw_1.getitemstring(1, 'tipo_trabajo')
				st_hon.medianeras = f_coef_tipologia_medianeras(med, obr, st_hon.volumen)
				// Par$$HEX1$$e100$$ENDHEX$$metros del pem m$$HEX1$$ed00$$ENDHEX$$nimo
				SELECT fases_cip_tfe.pem_min, fases_cip_tfe.coef_a, fases_cip_tfe.coef_b, fases_cip_tfe.coef_c, fases_cip_tfe.legalizacion
				INTO :pem_min, :coef_a, :coef_b, :coef_c, :legalizacion
				FROM fases_cip_tfe  
				HAVING ( fases_cip_tfe.id_fase = :st_hon.id_fase )   ;
				
				st_hon.legalizacion = legalizacion
				st_hon.pem_min = pem_min
				st_hon.coef_a = coef_a
				st_hon.coef_b = coef_b
				st_hon.coef_c = coef_c
				openwithparm(w_calculo_honorarios_cc, st_hon)
				
				ds_honos = Message.PowerObjectParm
				if isvalid(ds_honos) then 
					f_configura_parametros_fases_honos_cc (ds_honos.getitemstring(1,'tarifa'), this, ds_honos, 'F')
					this.SetItem(row,'legalizacion',ds_honos.GetItemSTring(1,'legalizacion'))
				end if


//			CASE 'COAATGC'
//				st_hon.presupuesto = idw_fases_estadistica.getitemnumber(1, 'pem')
//				st_hon.superficie = idw_fases_estadistica.getitemnumber(1, 'sup_total')
//				openwithparm(w_calculo_gastos_honorarios_gc, st_hon)
//				ds_honos = Message.PowerObjectParm
//				if isvalid(ds_honos) then f_configura_parametros_fases_honos_gc (ds_honos.getitemstring(1,'tarifa'), this, ds_honos, 'F')
		END CHOOSE
	
	CASE ELSE
		tab_1.tabpage_5.pb_calcular_dtos.triggerevent(clicked!)
END CHOOSE

end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, Upper(Parent.text), dwo.name, row)
end event

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;// Activamos la opci$$HEX1$$f300$$ENDHEX$$n de a$$HEX1$$f100$$ENDHEX$$adir s$$HEX1$$f300$$ENDHEX$$lo cuando no hay l$$HEX1$$ed00$$ENDHEX$$neas
// para casos especiales como contratos antiguos
am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_delete.enabled = False
if this.rowcount() > 0 then am_dw.m_table.m_addrow.enabled = False

end event

event retrieveend;call super::retrieveend;if this.RowCount()=0 then Event pfc_addrow()

end event

type tabpage_8 from userobject within tab_1
string tag = "texto=general.descuentos"
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "Descuentos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom092!"
long picturemaskcolor = 12632256
pb_recalcular_nuevo pb_recalcular_nuevo
pb_recalcular pb_recalcular
dw_fases_informes dw_fases_informes
end type

on tabpage_8.create
this.pb_recalcular_nuevo=create pb_recalcular_nuevo
this.pb_recalcular=create pb_recalcular
this.dw_fases_informes=create dw_fases_informes
this.Control[]={this.pb_recalcular_nuevo,&
this.pb_recalcular,&
this.dw_fases_informes}
end on

on tabpage_8.destroy
destroy(this.pb_recalcular_nuevo)
destroy(this.pb_recalcular)
destroy(this.dw_fases_informes)
end on

type pb_recalcular_nuevo from commandbutton within tabpage_8
boolean visible = false
integer x = 3278
integer y = 200
integer width = 457
integer height = 92
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Calcular Dtos 2011"
end type

event clicked;if idw_fases_estadistica.rowcount() < 1 then
	messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_parametros_calculo','Introduzca los par$$HEX1$$e100$$ENDHEX$$metros de C$$HEX1$$e100$$ENDHEX$$lculo'))	
	return -1
end if

idw_fases_estadistica.AcceptText()
tab_1.selecttab(5)

if f_var_global('g_utilizar_ws_calc_gastos') =  'N' then 

if g_colegio='COAATA' then
	idw_fases_informes.postevent('csd_calcular_descuentos')	
else
	idw_fases_informes.postevent('csd_calcular_tarifas_omnibus')
end if

else // Se emplea servicio de calculo de gastos. 
	idw_fases_informes.postevent('calcular_tarifas_ws')
end if 	


end event

type pb_recalcular from picturebutton within tabpage_8
boolean visible = false
integer x = 3278
integer y = 52
integer width = 251
integer height = 140
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Calcular Dtos"
boolean originalsize = true
vtextalign vtextalign = multiline!
end type

event clicked;if idw_fases_estadistica.rowcount() < 1 then
	messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_parametros_calculo','Introduzca los par$$HEX1$$e100$$ENDHEX$$metros de C$$HEX1$$e100$$ENDHEX$$lculo'))	
	return -1
end if

idw_fases_estadistica.AcceptText()
tab_1.selecttab(5)
idw_fases_informes.postevent('csd_calcular_descuentos')

end event

type dw_fases_informes from u_dw within tabpage_8
event csd_enter pbm_dwnprocessenter
event csd_calcular_descuentos ( )
event csd_oculta_tab ( )
event csd_nombre_pestanyas ( string nombre )
event csd_enlaza ( )
event csd_calcular_descuentos_terres ( )
event csd_calcular_descuentos_nuevo ( )
event csd_recalcula_descuentos ( )
event csd_bloquea_opt_cliente ( )
event csd_calcular_tarifas_omnibus ( )
event csd_calcular_musaat ( )
event calcular_tarifas_ws ( )
integer x = 18
integer y = 20
integer width = 4315
integer height = 784
integer taborder = 11
string dataobject = "d_fases_informes"
boolean hscrollbar = true
boolean livescroll = false
end type

event csd_enter;//Procesamiento de la tecla intro como tab
Post( Handle(this),256,9,0 )
Return 1

end event

event csd_calcular_descuentos();//Calculo de descuentos de COAAT-ALICANTE
double cip = 0, dv = 0, musaat = 0, cip_incrementar = 0, dv_incrementar = 0
st_cip_datos st_cip_datos
st_csi_articulos_servicios st_csi_articulos_servicios
st_dv_datos st_dv_datos
st_musaat_datos st_musaat_datos
double i,j
int fila_insertada
string id_col, id_asociado
int ret

// CIP
st_cip_datos.tipo_act = dw_1.getitemstring(1, 'fase')
st_cip_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_trabajo')
st_cip_datos.destino = dw_1.getitemstring(1, 'trabajo')
st_cip_datos.superficie = idw_fases_estadistica.getitemnumber(1, 'superficie')
st_cip_datos.pem = idw_fases_estadistica.getitemnumber(1, 'pem')
st_cip_datos.t_terreno = idw_fases_estadistica.GetItemString(1,'t_terreno')
st_cip_datos.admon = dw_fases_datos_exp.getitemstring(1, 'administracion')
st_cip_datos.volumen = idw_fases_estadistica.GetItemNumber(1,'volumen')
st_cip_datos.altura = idw_fases_estadistica.GetItemNumber(1,'altura')
st_cip_datos.colindantes = idw_fases_estadistica.GetItemString(1,'colindantes')
st_cip_datos.tipo_gestion = dw_1.GetItemString(1,'tipo_gestion')	
st_cip_datos.fecha = dw_1.GetItemdatetime(1,'f_entrada')
st_cip_datos.long_per = idw_fases_estadistica.getitemnumber(1, 'longitud_per')	
st_cip_datos.vol_tierras = idw_fases_estadistica.getitemnumber(1, 'volumen_tierras')	
st_cip_datos.valor_terreno = idw_fases_estadistica.getitemnumber(1, 'valor_terreno')	
st_cip_datos.valor_tasacion = idw_fases_estadistica.getitemnumber(1, 'valor_tasacion')
st_cip_datos.valoracion_estim = idw_fases_estadistica.getitemnumber(1, 'valoracion_estim')
st_cip_datos.estructura = idw_fases_estadistica.GetItemString(1,'estructura')
st_cip_datos.t_medicion = idw_fases_estadistica.GetItemString(1,'t_medicion')
st_cip_datos.replan_deslin = idw_fases_estadistica.GetItemString(1,'replan_deslin')
st_cip_datos.visared = dw_1.GetItemString(1,'e_mail') // modificado Ricardo 2004-12-30
st_cip_datos.vol_edif = idw_fases_estadistica.GetItemnumber(1,'volumen')
st_cip_datos.tipo_registro = dw_1.GetItemString(1,'tipo_registro')
st_cip_datos.id_fase = dw_1.getitemstring(1, 'id_fase')
st_cip_datos.id_expedi = dw_fases_datos_exp.getitemstring(1, 'id_expedi')
st_cip_datos.destino_i = dw_1.getitemstring(1, 'destino_int')
st_cip_datos.sup_viviendas = idw_fases_estadistica.getitemnumber(1, 'sup_viv')
st_cip_datos.sup_otros = idw_fases_estadistica.getitemnumber(1, 'sup_garage')+idw_fases_estadistica.getitemnumber(1, 'sup_otros')
st_cip_datos.num_viv = idw_fases_estadistica.getitemnumber(1, 'num_viv')
st_cip_datos.tipo_tramite = dw_1.getitemstring(1, 'id_tramite')
if lower(idw_fases_estadistica.describe("tipo_reforma.name"))	= 'tipo_reforma' then st_cip_datos.tipo_reforma = idw_fases_estadistica.getitemString(1, 'tipo_reforma')

// el 100%
st_cip_datos.porcentaje = 100 
//Cambio Luis CGU-308
long k
double suma_porcentajes
for k = 1 to idw_fases_colegiados.rowcount()
	suma_porcentajes +=  idw_fases_colegiados.getitemnumber(k, 'porcen_a')	
next
//fin cambio
// En algunos colegios se calcula en la ventana de honorarios

f_calcular_cip(st_cip_datos)
cip = st_cip_datos.cip
cip = cip*suma_porcentajes/100

if isnull(cip) then cip = 0

string ctrl_calidad_interno, fase
fase = dw_1.getitemString(1, 'fase')
ctrl_calidad_interno = idw_fases_estadistica.GetItemString(1,'ctrl_calidad_interno')
if f_es_vacio(ctrl_calidad_interno) then ctrl_calidad_interno = 'N'
ctrl_calidad_interno = 'N'

// Inserto fila

///*** CAL-341. Cambios para poder introducir nuevo concepto para REDAP
string ls_codigo_concepto_CIP
if dw_1.getitemstring(1, 'id_tramite') = 'REDAP' or dw_1.getitemstring(1, 'id_tramite') = 'REDOC' then
	ls_codigo_concepto_CIP = g_codigos_conceptos.REDAP
else 
	ls_codigo_concepto_CIP = g_codigos_conceptos.cip
end if	

if cip > 0 then
	//Comprobar si ya se ha calculado el CIP anteriormente
	long fila_cip
	double cip_ant
	
	fila_cip = this.Find("tipo_informe = '" + ls_codigo_concepto_CIP + "'",0,this.RowCount())
	if fila_cip > 0 Then //ya se ha calculado la cip, preguntar si recalcular
		cip_ant = this.GetItemNumber(fila_cip,'cuantia_colegiado')
		if cip_ant = cip then 
			ret = 0
		else
			ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_csi_articulo_descripcion(ls_codigo_concepto_CIP, '01')+ '?',Question!,YesNo!)
		end if
		if ret = 1 Then
			fila_insertada = fila_cip
		Else
			fila_insertada = 0
		End If
	Else
		fila_insertada = this.event pfc_addrow()
	End if
	if fila_insertada > 0 then
		///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
		this.setredraw(false)	
		this.setitem(fila_insertada, 'tipo_informe', ls_codigo_concepto_CIP)
		this.setitem(fila_insertada, 'empresa', '01')
		this.setredraw(true)
		// cojo los datos del concepto	
		st_csi_articulos_servicios.codigo = ls_codigo_concepto_CIP	
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		this.setitem(fila_insertada, 'cuantia_colegiado', cip )
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(cip, st_csi_articulos_servicios.t_iva ))	
	end if	
else // Si la tarifa no existe inserta una linea de cip con valor 0	
	fila_cip = this.Find("tipo_informe = '" + ls_codigo_concepto_CIP + "'",0,this.RowCount())
	if fila_cip = 0 Then
		///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
		this.setredraw(false)
		fila_insertada = this.event pfc_addrow()
		//this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.cip)
		this.setitem(fila_insertada, 'tipo_informe', ls_codigo_concepto_CIP)
		this.setitem(fila_insertada, 'empresa', '01')
		this.setredraw(true)
		//st_csi_articulos_servicios.codigo = g_codigos_conceptos.cip
		st_csi_articulos_servicios.codigo = ls_codigo_concepto_CIP
		st_csi_articulos_servicios.empresa = '01'
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		this.setitem(fila_insertada, 'cuantia_colegiado', 0)
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(cip, st_csi_articulos_servicios.t_iva ))
		this.setitem(fila_insertada, 'participa_colegiado', 'S')
		this.setitem(fila_insertada, 'participa_cliente', 'N')			
		this.setitem(fila_insertada, 'cuantia_cliente',0)
		this.setitem(fila_insertada, 'impuesto_cliente', 0)		
				
	end if
end if

//DV
long m
double porcen_col
st_dv_datos.id_fase = dw_1.getitemstring(1, 'id_fase')
st_dv_datos.tipoact = dw_1.getitemstring(1, 'fase')
st_dv_datos.tipoobra = dw_1.getitemstring(1, 'tipo_trabajo')
st_dv_datos.pem = idw_fases_estadistica.getitemnumber(1, 'pem')
st_dv_datos.administracion = ( idw_fases_datos_exp.getitemstring(1, 'administracion') = 'S')
//st_dv_datos.porcentaje = 100 // Todos los DV
//Cambio Luis CGU-308
for m = 1 to idw_fases_colegiados.rowcount()
	porcen_col +=  idw_fases_colegiados.getitemnumber(m, 'porcen_a')	
next
st_dv_datos.porcentaje = porcen_col
//fin cambio
st_dv_datos.id_expediente = dw_1.getitemstring(1, 'id_expedi')
st_dv_datos.fecha = dw_1.GetItemdatetime(1,'f_entrada')
st_dv_datos.superficie = idw_fases_estadistica.getitemnumber(1, 'superficie')
st_dv_datos.visared = dw_1.GetItemString(1,'e_mail') // modificado Ricardo 2004-12-30

f_calcular_dv(st_dv_datos)
dv = st_dv_datos.dv
if isnull(dv) then dv = 0

if dv > 0 then
	//Comprobar si ya se ha calculado los DV anteriormente
	long fila_dv
	double dv_ant
	fila_dv = this.Find("tipo_informe = '" + g_codigos_conceptos.dv + "'",0,this.RowCount())
	if fila_dv > 0 Then //ya se ha calculado el cip, preguntar si recalcular
		dv_ant = this.GetItemNumber(fila_dv,'cuantia_colegiado')
		if dv = dv_ant then
			ret = 0
		else
			ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_csi_articulo_descripcion(g_codigos_conceptos.dv, '01')+ '?',Question!,YesNo!)
		end if
		if ret = 1 Then
			fila_insertada = fila_dv
		Else
			fila_insertada = 0
		End If
	Else
		fila_insertada = this.event pfc_addrow()
	End if

	if fila_insertada > 0 then
		///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
		this.setredraw(false)
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.dv)
		this.setitem(fila_insertada, 'empresa', '01')
		this.setredraw(true)
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.dv
		st_csi_articulos_servicios.empresa = '01'
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		this.setitem(fila_insertada, 'cuantia_colegiado', dv )
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(dv, st_csi_articulos_servicios.t_iva ))
		this.setitem(fila_insertada, 'participa_colegiado', 'S')
		this.setitem(fila_insertada, 'participa_cliente', 'N')			
		this.setitem(fila_insertada, 'cuantia_cliente',0)
		this.setitem(fila_insertada, 'impuesto_cliente', 0)		
		
	end if
end if

// MUSAAT
double porc_col = 0, porc_col_real = 0, suma_porc = 0

// Suma de la Musaat de todos los colegiados
st_musaat_datos.n_visado = dw_1.getitemstring(1, 'id_fase')
st_musaat_datos.tipo_act = dw_1.getitemstring(1, 'fase')
st_musaat_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_trabajo')
st_musaat_datos.pem = idw_fases_estadistica.getitemnumber(1, 'pem')
st_musaat_datos.administracion = idw_fases_datos_exp.getitemstring(1, 'administracion')
st_musaat_datos.superficie = idw_fases_estadistica.getitemnumber(1, 'superficie')
st_musaat_datos.volumen = idw_fases_estadistica.getitemnumber(1, 'volumen')
st_musaat_datos.colindantes2m = idw_fases_estadistica.getitemstring(1, 'colindantes2m')
st_musaat_datos.cod_colegio = dw_1.getitemstring(dw_1.getrow(), 'cod_colegio_dest' )

// Suma de los % de los colegiados
for j = 1 to idw_fases_colegiados.rowcount()
	suma_porc +=  idw_fases_colegiados.getitemnumber(j, 'porcen_a')	
next

//Cambio Luis CGU-308
if(idw_fases_colegiados.rowcount() = 1)then
	suma_porc = 100
end if
//fin cambio

for i = 1 to idw_fases_colegiados.rowcount()
	porc_col =  idw_fases_colegiados.getitemnumber(i, 'porcen_a')	
	if isnull(suma_porc) or suma_porc = 0 then exit
	porc_col_real = porc_col / suma_porc * 100	
	st_musaat_datos.porcentaje = porc_col_real
	id_col = idw_fases_colegiados.getitemstring(i, 'id_col')
	st_musaat_datos.id_col = id_col
	st_musaat_datos.cobertura = 0
	st_musaat_datos.doble_condicion =idw_fases_colegiados.getitemstring(i, 'doble_condicion')	
	st_musaat_datos.int_forzosa =idw_fases_colegiados.getitemstring(i, 'int_forzosa')
	
	// Le pasamos en la estructura si el colegiado es funcionario
	st_musaat_datos.funcionario = idw_fases_colegiados.getitemstring(i, 'facturado')	
	if f_colegiado_tipopersona(id_col) = 'S' then	
		f_musaat_calcula_prima_sociedad(st_musaat_datos)
		musaat += st_musaat_datos.prima_comp	
	else
		f_musaat_calcula_prima(st_musaat_datos)	
		musaat += st_musaat_datos.prima_comp
	end if
next
if isnull(musaat) then musaat = 0

if musaat > 0 then
	//Comprobar si ya se ha calculado los DV anteriormente
	long fila_musaat
	double musaat_ant
	///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
	fila_musaat = this.Find("tipo_informe = '" + g_codigos_conceptos.musaat_variable + "' and empresa = '"+ g_cod_empresa_aseguradora +"'",0,this.RowCount())
	if fila_musaat > 0 Then //ya se ha calculado MUSAAT, preguntar si recalcular en el caso de que haya cambiado
		musaat_ant = this.GetItemNumber(fila_musaat,'cuantia_colegiado')
		if musaat = musaat_ant Then
			ret = 0
		else
			ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_csi_articulo_descripcion(g_codigos_conceptos.musaat_variable, g_cod_empresa_aseguradora)+ '?',Question!,YesNo!)
		end if
		if ret = 1 Then
			fila_insertada = fila_musaat
		Else
			fila_insertada = 0
		End If
	Else
		fila_insertada = this.event pfc_addrow()
	End if

	if fila_insertada > 0 then
		///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
		this.setredraw(false)
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.musaat_variable)
		this.setitem(fila_insertada, 'empresa', g_cod_empresa_aseguradora)
		this.setredraw(true)
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.musaat_variable
		st_csi_articulos_servicios.empresa = g_cod_empresa_aseguradora
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		this.setitem(fila_insertada, 'cuantia_colegiado', musaat )
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(musaat, st_csi_articulos_servicios.t_iva ))
		this.setitem(fila_insertada, 'participa_colegiado', 'S')
		this.setitem(fila_insertada, 'participa_cliente', 'N')			
		this.setitem(fila_insertada, 'cuantia_cliente',0)
		this.setitem(fila_insertada, 'impuesto_cliente', 0)		
	end if
end if

// DESCUENTO DE VISARED		
// Insertamos la linea si corresponde
if cip > 0 and dw_1.GetItemString(1,'e_mail')<>'V' then
	long fila_descuento
	fila_insertada = 0
	fila_descuento = this.Find("tipo_informe = '" + g_codigos_conceptos.dto_visared + "'",1,this.RowCount())
	
	st_csi_articulos_servicios.codigo = g_codigos_conceptos.dto_visared
	st_csi_articulos_servicios.empresa = '01'
	
	if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
		st_csi_articulos_servicios.t_iva = g_t_iva_defecto
	end if
	st_csi_articulos_servicios.importe = cip*0.25
	if fila_descuento > 0 Then
		this.setitem(fila_descuento, 't_iva', st_csi_articulos_servicios.t_iva)
		this.setitem(fila_descuento, 'cuantia_colegiado', st_csi_articulos_servicios.importe)
		this.setitem(fila_descuento, 'impuesto_colegiado',f_aplica_t_iva(st_csi_articulos_servicios.importe, st_csi_articulos_servicios.t_iva))
		this.setitem(fila_insertada, 'participa_colegiado', 'S')				
		this.setitem(fila_insertada, 'participa_cliente', 'N')				
		this.setitem(fila_insertada, 'cuantia_cliente',0)
		this.setitem(fila_insertada, 'impuesto_cliente', 0)

	
	else
		///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
		this.setredraw(false)
		fila_insertada = this.event pfc_addrow()
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.dto_visared)
		this.setitem(fila_insertada, 'empresa', '01')
		this.setredraw(true)
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva)
		this.setitem(fila_insertada, 'cuantia_colegiado',st_csi_articulos_servicios.importe)
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(st_csi_articulos_servicios.importe, st_csi_articulos_servicios.t_iva))
		this.setitem(fila_insertada, 'participa_colegiado', 'S')
		this.setitem(fila_insertada, 'participa_cliente', 'N')			
		this.setitem(fila_insertada, 'cuantia_cliente',0)
		this.setitem(fila_insertada, 'impuesto_cliente', 0)
		
	end if
end if




// Modificado David - 22/02/2005
// Es necesario que grabe para que ponga bien el estado
// al generar avisos con la ventana de cobrar gastos
this.update()

st_control_eventos c_evento
c_evento.evento = 'CALCULAR_GASTOS'
//c_evento.dw = dw_fases_informes
// DAVID 28/07/04 - Cambiamos el evento de dw para que se puede utilizar con el evento VISAR
c_evento.dw = dw_1
if f_control_eventos(c_evento)=-1 then return

this.postevent ("csd_bloquea_opt_cliente")
end event

event csd_oculta_tab;int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event csd_nombre_pestanyas;parent.text=nombre
end event

event csd_enlaza();f_enlaza_dw(dw_1,dw_fases_informes,'id_fase','id_fase')
this.Retrieve(dw_1.GetItemString(1,'id_fase'))
this.visible = true

end event

event csd_calcular_descuentos_terres();// TERRES CALCULA EL MINIMO DESPUES DEL PORCENTAJE DE PARTICIPACI$$HEX1$$d300$$ENDHEX$$N
// ESTO PROVOCA QUE NO SE PUEDAN OBTENER LAS CANTIDADES PROPORCIONALMENTE SINO
// QUE SE TIENEN QUE CALCULAR PARA CADA COLEGIADO INDEPENDIENTEMENTE
string ctrl_calidad_interno, fase
double cip = 0, dv = 0, musaat = 0, cip_incrementar = 0, dv_incrementar = 0,cip_parcial = 0
st_cip_datos st_cip_datos
st_csi_articulos_servicios st_csi_articulos_servicios
st_dv_datos st_dv_datos
st_musaat_datos st_musaat_datos
double i,j
int fila_insertada
string id_col, id_asociado
int ret

// CIP
st_cip_datos.tipo_act = dw_1.getitemstring(1, 'fase')
st_cip_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_trabajo')
st_cip_datos.destino = dw_1.getitemstring(1, 'trabajo')
st_cip_datos.superficie = idw_fases_estadistica.getitemnumber(1, 'superficie')
st_cip_datos.pem = idw_fases_estadistica.getitemnumber(1, 'pem')
st_cip_datos.t_terreno = idw_fases_estadistica.GetItemString(1,'t_terreno')
st_cip_datos.admon = dw_fases_datos_exp.getitemstring(1, 'administracion')
st_cip_datos.volumen = idw_fases_estadistica.GetItemNumber(1,'volumen')
st_cip_datos.altura = idw_fases_estadistica.GetItemNumber(1,'altura')
st_cip_datos.colindantes = idw_fases_estadistica.GetItemString(1,'colindantes')
st_cip_datos.tipo_gestion = dw_1.GetItemString(1,'tipo_gestion')	
st_cip_datos.fecha = dw_1.GetItemdatetime(1,'f_entrada')
st_cip_datos.long_per = idw_fases_estadistica.getitemnumber(1, 'longitud_per')	
st_cip_datos.vol_tierras = idw_fases_estadistica.getitemnumber(1, 'volumen_tierras')	
st_cip_datos.valor_terreno = idw_fases_estadistica.getitemnumber(1, 'valor_terreno')	
st_cip_datos.valor_tasacion = idw_fases_estadistica.getitemnumber(1, 'valor_tasacion')
st_cip_datos.valoracion_estim = idw_fases_estadistica.getitemnumber(1, 'valoracion_estim')
st_cip_datos.estructura = idw_fases_estadistica.GetItemString(1,'estructura')
st_cip_datos.t_medicion = idw_fases_estadistica.GetItemString(1,'t_medicion')
st_cip_datos.replan_deslin = idw_fases_estadistica.GetItemString(1,'replan_deslin')
st_cip_datos.visared = dw_1.GetItemString(1,'e_mail') // modificado Ricardo 2004-12-30
st_cip_datos.vol_edif = idw_fases_estadistica.GetItemnumber(1,'volumen')
st_cip_datos.tipo_registro = dw_1.GetItemString(1,'tipo_registro')
st_cip_datos.id_fase = dw_1.getitemstring(1, 'id_fase')
st_cip_datos.id_expedi = dw_fases_datos_exp.getitemstring(1, 'id_expedi')
st_cip_datos.destino_i = dw_1.getitemstring(1, 'destino_int')
st_cip_datos.sup_viviendas = idw_fases_estadistica.getitemnumber(1, 'sup_viv')
st_cip_datos.sup_otros = idw_fases_estadistica.getitemnumber(1, 'sup_garage')+idw_fases_estadistica.getitemnumber(1, 'sup_otros')
st_cip_datos.num_viv = idw_fases_estadistica.getitemnumber(1, 'num_viv')
if lower(idw_fases_estadistica.describe("tipo_reforma.name"))	= 'tipo_reforma' then st_cip_datos.tipo_reforma = idw_fases_estadistica.getitemString(1, 'tipo_reforma')

for i = 1 to idw_fases_colegiados.rowcount()
	st_cip_datos.porcentaje = idw_fases_colegiados.GetItemNumber(i,'porcen_a')
	st_cip_datos.funcionario = idw_fases_colegiados.getitemstring(i, 'facturado')	
	f_calcular_cip(st_cip_datos)
	cip_parcial = st_cip_datos.cip
	if isnull(cip_parcial) then cip_parcial = 0
	cip+=cip_parcial
next
fase = dw_1.getitemString(1, 'fase')
ctrl_calidad_interno = 'N'

// Inserto fila
if cip > 0 then
	//Comprobar si ya se ha calculado el CIP anteriormente
	long fila_cip
	double cip_ant
	fila_cip = this.Find("tipo_informe = '" + g_codigos_conceptos.cip + "'",0,this.RowCount())
	if fila_cip > 0 Then //ya se ha calculado la cip, preguntar si recalcular
		cip_ant = this.GetItemNumber(fila_cip,'cuantia_colegiado')
		if cip_ant = cip then 
			ret = 0
		else
//			ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_devuelve_desc_concepto(g_codigos_conceptos.cip)+ '?',Question!,YesNo!)
			ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_csi_articulo_descripcion(g_codigos_conceptos.cip, '01')+ '?',Question!,YesNo!)
		end if
		if ret = 1 Then
			fila_insertada = fila_cip
		Else
			fila_insertada = 0
		End If
	Else
		fila_insertada = this.event pfc_addrow()
	End if
	if fila_insertada > 0 then
		///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
		this.setredraw(false)
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.cip)
		this.setitem(fila_insertada, 'empresa', '01')
		this.setredraw(true)
		// cojo los datos del concepto
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.cip
		st_csi_articulos_servicios.empresa = '01'
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		this.setitem(fila_insertada, 'cuantia_colegiado', cip )
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(cip, st_csi_articulos_servicios.t_iva ))
		// Se guarda la formula sustituida Agregado el 09/09/08
		if(g_colegio = 'COAATTGN' or g_colegio='COAATTEB' OR g_colegio='COAATLL')then this.setitem(fila_insertada, 'formula_sustituida', st_cip_datos.desarrollo )
	end if

else // Si la tarifa no existe inserta una linea de cip con valor 0
	fila_cip = this.Find("tipo_informe = '" + g_codigos_conceptos.cip + "'",0,this.RowCount())
	if fila_cip = 0 Then
		///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
		this.setredraw(false)
		fila_insertada = this.event pfc_addrow()
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.cip)
		this.setitem(fila_insertada, 'empresa', '01')
		this.setredraw(true)
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.cip
		st_csi_articulos_servicios.empresa = '01'
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		this.setitem(fila_insertada, 'cuantia_colegiado', 0)
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(cip, st_csi_articulos_servicios.t_iva ))

	end if
end if

/*
//DV
st_dv_datos.id_fase = dw_1.getitemstring(1, 'id_fase')
st_dv_datos.tipoact = dw_1.getitemstring(1, 'fase')
st_dv_datos.tipoobra = dw_1.getitemstring(1, 'tipo_trabajo')
st_dv_datos.pem = idw_fases_estadistica.getitemnumber(1, 'pem')
st_dv_datos.administracion = ( idw_fases_datos_exp.getitemstring(1, 'administracion') = 'S')
st_dv_datos.id_expediente = dw_1.getitemstring(1, 'id_expedi')
st_dv_datos.fecha = dw_1.GetItemdatetime(1,'f_entrada')
st_dv_datos.superficie = idw_fases_estadistica.getitemnumber(1, 'superficie')
st_dv_datos.visared = dw_1.GetItemString(1,'e_mail') // modificado Ricardo 2004-12-30

for i = 1 to idw_fases_colegiados.rowcount()
	st_dv_datos.porcentaje = idw_fases_colegiados.GetItemNumber(i,'porcen_a')
	f_calcular_dv(st_dv_datos)
	dv = st_dv_datos.dv
	if isnull(dv) then dv = 0
	
	if dv > 0 then
		//Comprobar si ya se ha calculado los DV anteriormente
		long fila_dv
		double dv_ant
		fila_dv = this.Find("tipo_informe = '" + g_codigos_conceptos.dv + "'",0,this.RowCount())
		if fila_dv > 0 Then //ya se ha calculado el cip, preguntar si recalcular
			dv_ant = this.GetItemNumber(fila_dv,'cuantia_colegiado')
			if dv = dv_ant then
				ret = 0
			else
				ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_devuelve_desc_concepto(g_codigos_conceptos.dv)+ '?',Question!,YesNo!)
			end if
			if ret = 1 Then
				fila_insertada = fila_dv
			Else
				fila_insertada = 0
			End If
		Else
			fila_insertada = this.event pfc_addrow()
		End if
	
		if fila_insertada > 0 then
			this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.dv)
			st_csi_articulos_servicios.codigo = g_codigos_conceptos.dv
			if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
				st_csi_articulos_servicios.t_iva = g_t_iva_defecto
			end if
			this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
			this.setitem(fila_insertada, 'cuantia_colegiado', dv )
			this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(dv, st_csi_articulos_servicios.t_iva ))
	
		end if
	end if
next
*/
// MUSAAT
double porc_col = 0, porc_col_real = 0, suma_porc = 0

// Suma de la Musaat de todos los colegiados
st_musaat_datos.n_visado = dw_1.getitemstring(1, 'id_fase')
st_musaat_datos.tipo_act = dw_1.getitemstring(1, 'fase')
st_musaat_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_trabajo')
st_musaat_datos.pem = idw_fases_estadistica.getitemnumber(1, 'pem')
st_musaat_datos.administracion = idw_fases_datos_exp.getitemstring(1, 'administracion')
st_musaat_datos.superficie = idw_fases_estadistica.getitemnumber(1, 'superficie')
st_musaat_datos.volumen = idw_fases_estadistica.getitemnumber(1, 'volumen')
st_musaat_datos.colindantes2m = idw_fases_estadistica.getitemstring(1, 'colindantes2m')
st_musaat_datos.cod_colegio = dw_1.getitemstring(dw_1.getrow(), 'cod_colegio_dest' )

// Suma de los % de los colegiados
for j = 1 to idw_fases_colegiados.rowcount()
	suma_porc +=  idw_fases_colegiados.getitemnumber(j, 'porcen_a')	
next
//Cambio Luis ICTL-207
if(idw_fases_colegiados.rowcount() = 1)then
	suma_porc = 100
end if
//fin cambio
for i = 1 to idw_fases_colegiados.rowcount()
	porc_col =  idw_fases_colegiados.getitemnumber(i, 'porcen_a')	
	if isnull(suma_porc) or suma_porc = 0 then exit
	porc_col_real = porc_col / suma_porc * 100	
	st_musaat_datos.porcentaje = porc_col_real
	id_col = idw_fases_colegiados.getitemstring(i, 'id_col')
	st_musaat_datos.id_col = id_col
	st_musaat_datos.cobertura = 0
	//SCP-256 Cambios 2010
	st_musaat_datos.doble_condicion =idw_fases_colegiados.getitemstring(i, 'doble_condicion')	
	st_musaat_datos.int_forzosa =idw_fases_colegiados.getitemstring(i, 'int_forzosa')	
	// Le pasamos en la estructura si el colegiado es funcionario
	st_musaat_datos.funcionario = idw_fases_colegiados.getitemstring(i, 'facturado')	
	if f_colegiado_tipopersona(id_col) = 'S' then	
		f_musaat_calcula_prima_sociedad(st_musaat_datos)
		musaat += st_musaat_datos.prima_comp	
	else
		f_musaat_calcula_prima(st_musaat_datos)	
		musaat += st_musaat_datos.prima_comp
	end if
next
if isnull(musaat) then musaat = 0

if musaat > 0 then
	//Comprobar si ya se ha calculado los DV anteriormente
	long fila_musaat
	double musaat_ant
	///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
	fila_musaat = this.Find("tipo_informe = '" + g_codigos_conceptos.musaat_variable + "' and empresa = '"+ g_cod_empresa_aseguradora +"'",0,this.RowCount())
	if fila_musaat > 0 Then //ya se ha calculado MUSAAT, preguntar si recalcular en el caso de que haya cambiado
		musaat_ant = this.GetItemNumber(fila_musaat,'cuantia_colegiado')
		if musaat = musaat_ant Then
			ret = 0
		else
			//ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_devuelve_desc_concepto(g_codigos_conceptos.musaat_variable)+ '?',Question!,YesNo!)
			ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_csi_articulo_descripcion(g_codigos_conceptos.musaat_variable, g_cod_empresa_aseguradora)+ '?',Question!,YesNo!)
		end if
		if ret = 1 Then
			fila_insertada = fila_musaat
		Else
			fila_insertada = 0
		End If
	Else
		fila_insertada = this.event pfc_addrow()
	End if

	if fila_insertada > 0 then
		///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
		this.setredraw(false)
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.musaat_variable)
		this.setitem(fila_insertada, 'empresa', g_cod_empresa_aseguradora)
		this.setredraw(true)
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.musaat_variable
		st_csi_articulos_servicios.empresa = '01'
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		this.setitem(fila_insertada, 'cuantia_colegiado', musaat )
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(musaat, st_csi_articulos_servicios.t_iva ))
		// Se guarda la formula sustituida Agregado el 09/09/08
		this.setitem(fila_insertada, 'formula_sustituida', st_musaat_datos.desarrollo )
	end if
end if

// Modificado David - 22/02/2005
// Es necesario que grabe para que ponga bien el estado
// al generar avisos con la ventana de cobrar gastos
this.update()

st_control_eventos c_evento
c_evento.evento = 'CALCULAR_GASTOS'
//c_evento.dw = dw_fases_informes
// DAVID 28/07/04 - Cambiamos el evento de dw para que se puede utilizar con el evento VISAR
c_evento.dw = dw_1
if f_control_eventos(c_evento)=-1 then return

this.postevent ("csd_bloquea_opt_cliente")

end event

event csd_calcular_descuentos_nuevo();
double cip = 0, dv = 0, musaat = 0, cip_incrementar = 0, dv_incrementar = 0,cip_parcial = 0, pem_seg = 0
st_cip_datos st_cip_datos
st_csi_articulos_servicios st_csi_articulos_servicios
st_dv_datos st_dv_datos
st_musaat_datos st_musaat_datos
double i,j,porcen, ldb_cuantia_calc
int fila_insertada,res
string id_col, id_asociado, fase
int ret
string obra_oficial
double sup_garaje,sup_otros,sup_viv


// Creaci$$HEX1$$f300$$ENDHEX$$n y Conexi$$HEX1$$f300$$ENDHEX$$n del objeto de c$$HEX1$$e100$$ENDHEX$$lculo
n_calculo_gastos_gen uo_calculo_gastos
uo_calculo_gastos=create n_calculo_gastos_gen
res=uo_calculo_gastos.of_conectar_transaccion(sqlca.DBMS,sqlca.database,sqlca.LogID,sqlca.LogPass,sqlca.servername,sqlca.userid,sqlca.dbpass,sqlca.lock,sqlca.dbparm,'TRUE')

if res<0 then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al conectar a la base de datos")
end if

if lower(idw_fases_estadistica.describe("pres_seguridad.name"))	= 'pres_seguridad' then pem_seg = idw_fases_estadistica.getitemnumber(1, 'pres_seguridad')
if isnull(pem_seg) then pem_seg = 0

// Inicializaci$$HEX1$$f300$$ENDHEX$$n del objeto de c$$HEX1$$e100$$ENDHEX$$lculo
obra_oficial=dw_fases_datos_exp.getitemstring(1, 'administracion')
uo_calculo_gastos.of_set_string('colegio',g_colegio)		
uo_calculo_gastos.of_set_string('tipo_gestion',dw_1.GetItemString(1,'tipo_gestion'))
uo_calculo_gastos.of_set_fecha('f_entrada',dw_1.GetItemdatetime(1,'f_entrada'))
uo_calculo_gastos.of_set_string('admon',obra_oficial)	
uo_calculo_gastos.of_set_string('tipo_act', dw_1.getitemstring(1, 'fase'))		
uo_calculo_gastos.of_set_string('tipo_obra',dw_1.getitemstring(1, 'tipo_trabajo'))
uo_calculo_gastos.of_set_string('destino',dw_1.getitemstring(1, 'trabajo'))
uo_calculo_gastos.of_set_double('volumen', idw_fases_estadistica.GetItemnumber(1,'volumen'))
uo_calculo_gastos.of_set_double('vol_edif', idw_fases_estadistica.GetItemnumber(1,'volumen'))		
uo_calculo_gastos.of_set_double('altura',idw_fases_estadistica.GetItemnumber(1,'altura'))						
sup_viv = idw_fases_estadistica.getitemnumber(1, 'sup_viv')
if IsNull(sup_viv) then sup_viv=0
sup_otros= idw_fases_estadistica.getitemnumber(1, 'sup_otros')
if IsNull(sup_otros) then sup_otros=0
sup_garaje=idw_fases_estadistica.getitemnumber(1, 'sup_garage')		
if IsNull(sup_garaje) then sup_garaje=0		
uo_calculo_gastos.of_set_double('sup_viviendas',sup_viv)							
uo_calculo_gastos.of_set_double('sup_otros',sup_otros + sup_garaje)
uo_calculo_gastos.of_set_double('superficie',sup_viv+sup_otros+sup_garaje)				
uo_calculo_gastos.of_set_double('pem',idw_fases_estadistica.getitemnumber(1, 'pem'))			
uo_calculo_gastos.of_set_double('pem_seg', pem_seg)	
uo_calculo_gastos.of_set_double('num_viv',idw_fases_estadistica.getitemnumber(1, 'num_viv'))	
uo_calculo_gastos.of_set_string('colindantes',idw_fases_estadistica.GetItemString(1,'colindantes'))
uo_calculo_gastos.of_set_string('t_terreno',idw_fases_estadistica.GetItemString(1,'t_terreno'))
uo_calculo_gastos.of_set_double('vol_tierras',idw_fases_estadistica.GetItemNumber(1,'volumen_tierras'))		
uo_calculo_gastos.of_set_double('long_per',idw_fases_estadistica.GetItemNumber(1,'longitud_per'))
uo_calculo_gastos.of_set_double('valor_terreno',idw_fases_estadistica.getitemnumber(1, 'valor_terreno'))
uo_calculo_gastos.of_set_double('valor_tasacion',idw_fases_estadistica.getitemnumber(1, 'valor_tasacion'))
uo_calculo_gastos.of_set_double('valor_estim',idw_fases_estadistica.getitemnumber(1, 'valoracion_estim'))
uo_calculo_gastos.of_set_string('estructura',idw_fases_estadistica.GetItemString(1,'estructura'))
uo_calculo_gastos.of_set_string('t_medicion',idw_fases_estadistica.GetItemString(1,'t_medicion'))
uo_calculo_gastos.of_set_string('replanteo',idw_fases_estadistica.GetItemString(1,'replan_deslin'))		
uo_calculo_gastos.of_set_string('visared',dw_1.GetItemString(1,'e_mail'))
if idw_fases_estadistica_otros.visible then
	if lower( idw_fases_estadistica_otros.describe("tipologia.name")) = 'tipologia'  then uo_calculo_gastos.of_set_string('tipologia',idw_fases_estadistica_otros.GetItemString(1,'tipologia'))
end if

//if lower( dw_1.describe("tipo_reforma.name")) = 'tipo_reforma'  then uo_calculo_gastos.tipo_reforma =dw_1.getitemString(1, 'tipo_reforma')
if lower( dw_1.describe("destino_int.name")) = 'otros_destinos'  then 	uo_calculo_gastos.of_set_string('destino_int',dw_1.getitemString(1, 'destino_int'))
if lower( dw_1.describe("cc_externo.name")) = 'cc_externo'  then 	uo_calculo_gastos.of_set_string('cc_externo',idw_fases_estadistica.GetItemString(1,'cc_externo'))


for i = 1 to idw_fases_colegiados.rowcount()
	porcen = idw_fases_colegiados.GetItemNumber(i,'porcen_a')
	uo_calculo_gastos.of_set_string('funcionario',idw_fases_colegiados.getitemString(1, 'facturado'))
	uo_calculo_gastos.of_set_double('porcentaje',porcen)
	uo_calculo_gastos.of_calcular_dip()
	uo_calculo_gastos.of_calcular_dv()
	
	cip += uo_calculo_gastos.of_get_double('dip')
	if g_colegio = 'COAATMCA' then
		if not wf_comprueba_visado_mca() then		dv = uo_calculo_gastos.of_get_double('dv')
	else
		dv += uo_calculo_gastos.of_get_double('dv')
	end if
	
next

// Ya aplica el porcentaje en la funci$$HEX1$$f300$$ENDHEX$$n de c$$HEX1$$e100$$ENDHEX$$lculo tanto en TGN como en TEB
//cip = st_cip_datos.cip * porcen/100
//	
if isnull(cip) then cip = 0
if isnull(dv) then dv = 0
fase = dw_1.getitemString(1, 'fase')

//**************
// INSERTAR LA FILA DEL CIP
//**************
if cip > 0 then
	//Comprobar si ya se ha calculado el CIP anteriormente
	long fila_cip
	double cip_ant
	fila_cip = this.Find("tipo_informe = '" + g_codigos_conceptos.cip + "'",0,this.RowCount())
	if fila_cip > 0 Then //ya se ha calculado la cip, preguntar si recalcular
		///*** SCP-884. Se comprueba la suma de la cuantia de colegiado y cliente. Alexis. 03/03/2011 ***///
		cip_ant = this.GetItemNumber(fila_cip,'cuantia_colegiado') + this.GetItemNumber(fila_cip,'cuantia_cliente')
		if cip_ant = cip then 
			ret = 0
		else
//			ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_devuelve_desc_concepto(g_codigos_conceptos.cip)+ '?',Question!,YesNo!)
			ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_csi_articulo_descripcion(g_codigos_conceptos.cip, '01')+ '?',Question!,YesNo!)
		end if
		if ret = 1 Then
			fila_insertada = fila_cip
		Else
			fila_insertada = 0
		End If
	Else
		fila_insertada = this.event pfc_addrow()
	End if
	if fila_insertada > 0 then
		///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
		this.setredraw(false)
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.cip)
		this.setitem(fila_insertada, 'empresa', 01)
		this.setredraw(true)
		// cojo los datos del concepto
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.cip
		st_csi_articulos_servicios.empresa = '01'
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		///*** SCP-884. Alexis. 03/03/2011. Se inserta los descuentos mediante funci$$HEX1$$f300$$ENDHEX$$n. ***///
		wf_reparte_cantidad_descuentos(fila_insertada, cip , st_csi_articulos_servicios.t_iva, 'N')
		
//		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
//		
//		this.setitem(fila_insertada, 'cuantia_colegiado', cip )
//		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(cip, st_csi_articulos_servicios.t_iva ))
//		this.setitem(fila_insertada, 'cuantia_cliente', 0 )
//		this.setitem(fila_insertada, 'impuesto_cliente', 0)
		
		// Se guarda la formula sustituida Agregado el 13/10/08
		this.setitem(fila_insertada, 'formula_sustituida', uo_calculo_gastos.of_get_string('dip_formula_desarrollo'))
	end if

else // Si la tarifa no existe inserta una linea de cip con valor 0
	fila_cip = this.Find("tipo_informe = '" + g_codigos_conceptos.cip + "'",0,this.RowCount())
	if fila_cip = 0 Then
		///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
		this.setredraw(false)
		fila_insertada = this.event pfc_addrow()
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.cip)
		this.setitem(fila_insertada, 'empresa', '01')
		this.setredraw(true)
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.cip
		st_csi_articulos_servicios.empresa = '01'
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		this.setitem(fila_insertada, 'cuantia_colegiado', 0)
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(cip, st_csi_articulos_servicios.t_iva ))

	end if
end if


//**************
// COAATMCA: TARIFA DE MANTENIMIENTO
//**************

string t_act
boolean mant=false
st_calculo_dip st_mant
string formula_mant='',formula_desarrollo_mant=''
double tarifa_manten, porc_mant
string codigo_manten='43'

t_act=dw_1.getitemstring(1, 'fase')

if left(t_act,1)='1' and dw_1.getitemString(1, 'mantenimiento')='S' then
	st_mant.pem=idw_fases_estadistica.getitemnumber(1, 'pem')
	st_mant.superficie=sup_viv+sup_otros+sup_garaje
	st_mant.fecha=dw_1.GetItemdatetime(1,'f_entrada')
	st_mant.admon=obra_oficial
	f_calcular_tarifa_manten_coaatmca(st_mant)
	tarifa_manten=st_mant.cip	
	for j = 1 to idw_fases_colegiados.rowcount()
		porc_mant +=  idw_fases_colegiados.getitemnumber(j, 'porcen_a')	
	next

	
	tarifa_manten = tarifa_manten * porc_mant / 100
	if tarifa_manten>0 then
		//Comprobar si ya se ha calculado la cuota anteriormente
		long fila_mant
		double mant_ant
		
		fila_mant = this.Find("tipo_informe = '"+codigo_manten+"'",0,this.RowCount())
		if fila_mant > 0 Then //ya se ha calculado la mant, preguntar si recalcular
			mant_ant = this.GetItemNumber(fila_mant,'cuantia_colegiado') + this.GetItemNumber(fila_mant,'cuantia_cliente')
			if mant_ant = tarifa_manten then 
				ret = 0
			else
//				ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_devuelve_desc_concepto('43')+ '?',Question!,YesNo!)
			ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_csi_articulo_descripcion(codigo_manten, '01')+ '?',Question!,YesNo!)
			end if
			if ret = 1 Then
				fila_insertada = fila_mant
			Else
				fila_insertada = 0
			End If
		Else
			fila_insertada = this.event pfc_addrow()
		End if
		
		if fila_insertada > 0 then
			///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
			this.setredraw(false)
			this.setitem(fila_insertada, 'tipo_informe', codigo_manten)
			this.setitem(fila_insertada, 'empresa', '01')
			this.setredraw(true)
			// cojo los datos del concepto
			st_csi_articulos_servicios.codigo = codigo_manten
			st_csi_articulos_servicios.empresa = '01'
			if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
				st_csi_articulos_servicios.t_iva = g_t_iva_defecto
			end if
			
			///*** SCP-884. Alexis. 03/03/2011. Se inserta los descuentos mediante funci$$HEX1$$f300$$ENDHEX$$n. ***///
			wf_reparte_cantidad_descuentos(fila_insertada, tarifa_manten , st_csi_articulos_servicios.t_iva, 'N')
			
//			this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
//			this.setitem(fila_insertada, 'cuantia_colegiado', tarifa_manten )
//			this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(tarifa_manten, st_csi_articulos_servicios.t_iva ))
			// Se guarda la formula sustituida Agregado el 13/10/08
			this.setitem(fila_insertada, 'formula_sustituida', uo_calculo_gastos.of_get_string('dip_formula_desarrollo'))
		end if
		
	else // Si la tarifa no existe inserta una linea de cip con valor 0
		fila_mant = this.Find("tipo_informe = '"+codigo_manten+"'",0,this.RowCount())
		if fila_mant = 0 Then
			///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
			this.setredraw(FALSE)
			fila_insertada = this.event pfc_addrow()
			this.setitem(fila_insertada, 'tipo_informe', codigo_manten)
			this.setitem(fila_insertada, 'empresa', '01')
			this.setredraw(true)
			st_csi_articulos_servicios.codigo = codigo_manten
			st_csi_articulos_servicios.empresa = '01'
			if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
				st_csi_articulos_servicios.t_iva = g_t_iva_defecto
			end if
			this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
			this.setitem(fila_insertada, 'cuantia_colegiado', 0)
			this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(0, st_csi_articulos_servicios.t_iva ))
	
		end if
	
	end if			
end if




//**************
// INSERTAR LA FILA DEL DV
//**************
if dv > 0 then
	//Comprobar si ya se ha calculado los DV anteriormente
	long fila_dv
	double dv_ant
	fila_dv = this.Find("tipo_informe = '" + g_codigos_conceptos.dv + "'",0,this.RowCount())
		if fila_dv > 0 Then //ya se ha calculado el cip, preguntar si recalcular
			dv_ant = this.GetItemNumber(fila_dv,'cuantia_colegiado') + this.GetItemNumber(fila_dv,'cuantia_cliente')
			if dv = dv_ant then
				ret = 0
			else
//				ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_devuelve_desc_concepto(g_codigos_conceptos.dv)+ '?',Question!,YesNo!)
				ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_csi_articulo_descripcion(g_codigos_conceptos.dv, '01')+ '?',Question!,YesNo!)
			end if
			if ret = 1 Then
				fila_insertada = fila_dv
			Else
				fila_insertada = 0
			End If
		Else
			fila_insertada = this.event pfc_addrow()
		End if

	if fila_insertada > 0 then
		///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
		this.setredraw(false)
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.dv)
		this.setitem(fila_insertada, 'empresa', '01')
		this.setredraw(true)
		
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.dv
		st_csi_articulos_servicios.empresa = '01'
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		///*** SCP-884. Alexis. 03/03/2011. Se inserta los descuentos mediante funci$$HEX1$$f300$$ENDHEX$$n. ***///
		wf_reparte_cantidad_descuentos(fila_insertada, dv , st_csi_articulos_servicios.t_iva, 'N')
//		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
//		this.setitem(fila_insertada, 'cuantia_colegiado', dv )
//		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(dv, st_csi_articulos_servicios.t_iva ))


	end if
else // Si la tarifa no existe inserta una linea de cip con valor 0
	fila_dv = this.Find("tipo_informe = '" + g_codigos_conceptos.dv + "'",0,this.RowCount())
	if fila_dv = 0 Then
		///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
		this.setredraw(false)
		fila_insertada = this.event pfc_addrow()
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.dv)
		this.setitem(fila_insertada, 'empresa', '01')
		this.setredraw(true)
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.dv
		st_csi_articulos_servicios.empresa = '01'
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		this.setitem(fila_insertada, 'cuantia_colegiado', 0)
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(dv, st_csi_articulos_servicios.t_iva ))

	end if	
end if



// ************  EL CALCULO DE MUSAAT SE MANTIENE EL ANTIGUO ************ //


// MUSAAT
double porc_col = 0, porc_col_real = 0, suma_porc = 0

// Suma de la Musaat de todos los colegiados
st_musaat_datos.n_visado = dw_1.getitemstring(1, 'id_fase')
st_musaat_datos.tipo_act = dw_1.getitemstring(1, 'fase')
st_musaat_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_trabajo')
st_musaat_datos.pem = idw_fases_estadistica.getitemnumber(1, 'pem')
st_musaat_datos.administracion = idw_fases_datos_exp.getitemstring(1, 'administracion')
st_musaat_datos.superficie = idw_fases_estadistica.getitemnumber(1, 'superficie')
st_musaat_datos.volumen = idw_fases_estadistica.getitemnumber(1, 'volumen')
st_musaat_datos.colindantes2m = idw_fases_estadistica.getitemstring(1, 'colindantes2m')
st_musaat_datos.cod_colegio = dw_1.getitemstring(dw_1.getrow(), 'cod_colegio_dest' )
// Suma de los % de los colegiados
for j = 1 to idw_fases_colegiados.rowcount()
	suma_porc +=  idw_fases_colegiados.getitemnumber(j, 'porcen_a')	
next

//Cambio Luis CGU-308
if(idw_fases_colegiados.rowcount() = 1)then
	suma_porc = 100
end if

for i = 1 to idw_fases_colegiados.rowcount()
	porc_col =  idw_fases_colegiados.getitemnumber(i, 'porcen_a')	
	if isnull(suma_porc) or suma_porc = 0 then exit
	porc_col_real = porc_col / suma_porc * 100	
	st_musaat_datos.porcentaje = porc_col_real
	id_col = idw_fases_colegiados.getitemstring(i, 'id_col')
	st_musaat_datos.id_col = id_col
	st_musaat_datos.cobertura = 0
	// Musaat 2010 agregan doble condicion a la cobertura
	st_musaat_datos.doble_condicion =idw_fases_colegiados.getitemstring(i, 'doble_condicion')	
	st_musaat_datos.int_forzosa =idw_fases_colegiados.getitemstring(i, 'int_forzosa')	
	// Le pasamos en la estructura si el colegiado es funcionario
	st_musaat_datos.funcionario = idw_fases_colegiados.getitemstring(i, 'facturado')	
	if f_colegiado_tipopersona(id_col) = 'S' then	
		f_musaat_calcula_prima_sociedad(st_musaat_datos)
		musaat += st_musaat_datos.prima_comp	
	else
		f_musaat_calcula_prima(st_musaat_datos)	
		musaat += st_musaat_datos.prima_comp
	end if
next
if isnull(musaat) then musaat = 0

if musaat > 0 then
	//Comprobar si ya se ha calculado los DV anteriormente
	long fila_musaat
	double musaat_ant
	///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
	fila_musaat = this.Find("tipo_informe = '" + g_codigos_conceptos.musaat_variable + "' and empresa = '"+ g_cod_empresa_aseguradora +"'",0,this.RowCount())
	if fila_musaat > 0 Then //ya se ha calculado MUSAAT, preguntar si recalcular en el caso de que haya cambiado
		musaat_ant = this.GetItemNumber(fila_musaat,'cuantia_colegiado')
		if musaat = musaat_ant Then
			ret = 0
		else
//			ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_devuelve_desc_concepto(g_codigos_conceptos.musaat_variable)+ '?',Question!,YesNo!)
			ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_csi_articulo_descripcion(g_codigos_conceptos.musaat_variable, g_cod_empresa_aseguradora)+ '?',Question!,YesNo!)
		end if
		if ret = 1 Then
			fila_insertada = fila_musaat
		Else
			fila_insertada = 0
		End If
	Else
		fila_insertada = this.event pfc_addrow()
	End if

	if fila_insertada > 0 then
		///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
		this.setredraw(false)
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.musaat_variable)
		this.setitem(fila_insertada, 'empresa', g_cod_empresa_aseguradora)
		this.setredraw(true)
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.musaat_variable
		st_csi_articulos_servicios.empresa = g_cod_empresa_aseguradora
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		this.setitem(fila_insertada, 'cuantia_colegiado', musaat )
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(musaat, st_csi_articulos_servicios.t_iva ))
		// Se guarda la formula sustituida Agregado el 09/09/08
		this.setitem(fila_insertada, 'formula_sustituida', st_musaat_datos.desarrollo )
	end if
end if

//Modificado Jesus 22-02-2010 CGU-353 No quieren cobrar el libro de $$HEX1$$f300$$ENDHEX$$rdenes en proyectos (codificacion 12).

// LIBROS DE $$HEX1$$d300$$ENDHEX$$RDENES E INCIDENCIAS
if g_colegio = 'COAATGU' then	// SOLO PARA EL COLEGIO DE GUADALAJARA
	if dw_1.GetItemString(1,'fase') <> '12' then // SOLO PARA TIPOS DE ACTUACI$$HEX1$$d300$$ENDHEX$$N DISTINTO DE 'PROYECTO'
		string libro = '', contenido = ''
		if left(idw_fases_cip_tfe.getitemstring(1, 'tarifa'),1) = 'A' and idw_fases_cip_tfe.getitemstring(1, 'epigrafe') <> 'R' then libro = g_codigos_conceptos.libro_ordenes
		contenido = idw_fases_cip_tfe.getitemstring(1, 'epigrafe')
		if contenido = '442' or contenido = '443' or contenido = '444' then libro = g_codigos_conceptos.libro_incidencias
		
		// Insertamos la linea si corresponde
		if libro <> '' then
			long fila_libros
			fila_insertada = 0
			fila_libros = this.Find("tipo_informe = '" + libro + "'",1,this.RowCount())
			if fila_libros = 0 Then
				///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
				this.setredraw(false)
				fila_insertada = this.event pfc_addrow()
				this.setitem(fila_insertada, 'tipo_informe', libro)
				this.setitem(fila_insertada, 'empresa', '01')
				this.setredraw(true)
				st_csi_articulos_servicios.codigo = libro
				st_csi_articulos_servicios.empresa = '01'
				if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
					st_csi_articulos_servicios.t_iva = g_t_iva_defecto
				end if
				
				this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva)
				this.setitem(fila_insertada, 'cuantia_colegiado', st_csi_articulos_servicios.importe)
				this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(st_csi_articulos_servicios.importe, st_csi_articulos_servicios.t_iva))
			end if
		end if
	end if
end if



// Modificado David 10-03-04 - A$$HEX1$$f100$$ENDHEX$$adir la linea solo para CGC
if dw_1.GetItemString(1,'tipo_gestion') = 'C' then
	// Modificado Ricardo 04-02-10
	CHOOSE CASE g_colegio
		CASE 'COAATLR', 'COAATTFE', 'COAATB'//, 'COAATZ'
			// Colocamos un nuevo descuento para los desplazamientos
			long fila_desplazamientos
			fila_insertada = 0
			fila_desplazamientos = this.Find("tipo_informe = '" + g_codigos_conceptos.desplazamientos + "'",1,this.RowCount())
			if fila_desplazamientos = 0 Then //
				///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
				this.setredraw(false)
				fila_insertada = this.event pfc_addrow()
				this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.desplazamientos)
				this.setitem(fila_insertada, 'empresa', '01')
				this.setredraw(true)
				st_csi_articulos_servicios.codigo = g_codigos_conceptos.desplazamientos
				st_csi_articulos_servicios.empresa = '01'				
				if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
					st_csi_articulos_servicios.t_iva = g_t_iva_defecto
				end if
				this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
				this.setitem(fila_insertada, 'cuantia_colegiado', 0 )
				this.setitem(fila_insertada, 'impuesto_colegiado', 0)
			end if
	END CHOOSE
	// Modificado Ricardo 04-02-10
end if

// EVENTOS POSTERIORES AL CALCULO
st_control_eventos c_evento
c_evento.evento = 'CALCULAR_GASTOS'
c_evento.dw = dw_1
if f_control_eventos(c_evento)=-1 then return

this.postevent ("csd_bloquea_opt_cliente")

end event

event csd_recalcula_descuentos();string participa_cliente,participa_colegiado
double partes=0,cuantia_cliente,cuantia_colegiado,cant,impuesto_cliente,impuesto_colegiado,imp


participa_cliente 	= this.GetItemString(this.GetRow(),'participa_cliente')
participa_colegiado	= this.GetItemString(this.GetRow(),'participa_colegiado')

cuantia_cliente 	= this.GetItemNumber(this.GetRow(),'cuantia_cliente')
cuantia_colegiado	= this.GetItemNumber(this.GetRow(),'cuantia_colegiado')
impuesto_cliente 	= this.GetItemNumber(this.GetRow(),'impuesto_cliente')
impuesto_colegiado	= this.GetItemNumber(this.GetRow(),'impuesto_colegiado')

if IsNull(cuantia_cliente) then cuantia_cliente=0
if IsNull(cuantia_colegiado) then cuantia_colegiado=0
if IsNull(impuesto_cliente) then impuesto_cliente=0
if IsNull(impuesto_colegiado) then impuesto_colegiado=0


cant = cuantia_cliente + cuantia_colegiado
imp  = impuesto_cliente +  impuesto_colegiado

if participa_cliente='S' then partes++
if participa_colegiado='S' then partes++

cant = f_redondea(cant/partes)
imp  = f_redondea(imp/partes)

if participa_cliente		='S' then 
	this.SetItem(this.GetRow(),'cuantia_cliente',cant)
	this.SetItem(this.GetRow(),'impuesto_cliente',imp)

else
	this.SetItem(this.GetRow(),'cuantia_cliente',0)
	this.SetItem(this.GetRow(),'impuesto_cliente',0)
end if

if participa_colegiado	='S' then 
	this.SetItem(this.GetRow(),'cuantia_colegiado',cant)
	this.SetItem(this.GetRow(),'impuesto_colegiado',imp)
else
	this.SetItem(this.GetRow(),'cuantia_colegiado',0)
	this.SetItem(this.GetRow(),'impuesto_colegiado',0)
end if
end event

event csd_bloquea_opt_cliente();int li_i
string ls_codigo_articulo

for li_i =1 to this.rowcount()
	
	ls_codigo_articulo = this.getitemstring(li_i, 'tipo_informe') 
	if ls_codigo_articulo = g_codigos_conceptos.musaat_variable then
			this.setitem(li_i, 'compute_0015', 'S')
			//this.setitem(li_i, 'participa_cliente', 'N')
			//this.setitem( li_i, 'participa_colegiado', 'S')
			this.SetItemStatus(li_i, "compute_0015", Primary!, NotModified!)
	end if 
	
next 	


end event

event csd_calcular_tarifas_omnibus();double cip = 0, dv = 0, musaat = 0, cip_incrementar = 0, dv_incrementar = 0,cip_parcial = 0, pem_seg = 0
st_cip_datos st_cip_datos
st_csi_articulos_servicios st_csi_articulos_servicios
st_dv_datos st_dv_datos
st_musaat_datos st_musaat_datos
double i,j,porcen
int fila_insertada,res
string id_col, id_asociado, fase, t_tramite, visared
int ret
string obra_oficial, ls_muestra_articulos_a_cero
double sup_garaje,sup_otros,sup_viv

string t_visado,id_informe
double total,total_informe

// Creaci$$HEX1$$f300$$ENDHEX$$n y Conexi$$HEX1$$f300$$ENDHEX$$n del objeto de c$$HEX1$$e100$$ENDHEX$$lculo
n_csd_calculo_gastos uo_calculo_gastos
uo_calculo_gastos=create n_csd_calculo_gastos
res=uo_calculo_gastos.of_conectar_transaccion(sqlca.DBMS,sqlca.database,sqlca.LogID,sqlca.LogPass,sqlca.servername,sqlca.userid,sqlca.dbpass,sqlca.lock,sqlca.dbparm,'TRUE')

if res<0 then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al conectar a la base de datos")
end if

select sn into :ls_muestra_articulos_a_cero from var_globales where nombre = 'g_muestra_articulos_a_cero';

sup_viv = idw_fases_estadistica.getitemnumber(1, 'sup_viv')
sup_otros= idw_fases_estadistica.getitemnumber(1, 'sup_otros')
sup_garaje=idw_fases_estadistica.getitemnumber(1, 'sup_garage')
if IsNull(sup_viv) then sup_viv=0
if IsNull(sup_otros) then sup_otros=0	
if IsNull(sup_garaje) then sup_garaje=0	

// Inicializaci$$HEX1$$f300$$ENDHEX$$n del objeto de c$$HEX1$$e100$$ENDHEX$$lculo

// ******************** ************************
// ATENCION BORRAR ESTO PARA PRODUCCION
	//g_colegio=dw_1.GetItemString(dw_1.GetRow(),'cod_colegio_dest')
// *************************************************
visared = dw_1.GetItemString(dw_1.GetRow(),'e_mail')
obra_oficial = idw_fases_datos_exp.GetItemString(idw_fases_datos_exp.GetRow(),'administracion')
if f_es_vacio(obra_oficial) then obra_oficial = 'N'
uo_calculo_gastos.of_set_string('id_fase',dw_1.GetItemString(dw_1.GetRow(),'id_fase'))		
uo_calculo_gastos.of_set_string('colegio',g_colegio)		
uo_calculo_gastos.of_set_string('visared',visared)
uo_calculo_gastos.of_set_string('obra_oficial', obra_oficial)
uo_calculo_gastos.of_set_string('tipo_gestion',dw_1.GetItemString(dw_1.GetRow(),'tipo_gestion'))		
uo_calculo_gastos.of_set_string('tipo_act',dw_1.GetItemString(dw_1.GetRow(),'fase'))		
uo_calculo_gastos.of_set_string('tipo_obra',dw_1.GetItemString(dw_1.GetRow(),'tipo_trabajo'))		
uo_calculo_gastos.of_set_double('superficie',sup_viv+sup_otros+sup_garaje)				
uo_calculo_gastos.of_set_double('pem',idw_fases_estadistica.getitemnumber(1, 'pem'))

choose case g_colegio
	case 'COAATLL', 'COAATAVI'
		uo_calculo_gastos.of_set_double('otro_rango',idw_fases_estadistica.getitemnumber(1, 'volumen'))
	case else
		uo_calculo_gastos.of_set_double('otro_rango',idw_fases_estadistica.getitemnumber(1, 'num_viv'))
end choose		

t_tramite=dw_1.GetItemString(dw_1.GetRow(),'id_tramite')
// SCP-1920
string ls_visared_tramites
ls_visared_tramites = visared
// S$$HEX1$$ed00$$ENDHEX$$: 'V' => 'S'
IF visared = 'V' THEN 
	ls_visared_tramites = 'S'
// Otros : 'S' => sin equivalencia, debe ser distinto a 'S', 'N'
elseif visared = 'S' THEN 	
	ls_visared_tramites = 'O'
end if

//SCP-1076. Se cambia el cursor por un datastore porque el cursor falla
datastore informes

informes = create datastore
informes.dataobject = 'd_fases_informes_x_tramite'
informes.SetTransObject(SQLCA)
informes.Retrieve (ls_visared_tramites, t_tramite, g_colegio)

//do while true
for i=1 to informes.RowCount()
	id_informe = informes.GetItemString(i, 'id_informe');
	//if sqlca.sqlcode <> 0 then exit
	uo_calculo_gastos.of_set_string('informe',id_informe)
	total_informe=uo_calculo_gastos.of_calcular_importe_total()
	
	if f_valida_articulo_activo(id_informe, g_empresa) = 0 then continue
	//**************
	// INSERTAR LA FILA EN GASTOS
	//**************
	if total_informe <> 0 then
		//Comprobar si ya se ha calculado anteriormente
		long fila
		double valor_ant
		fila = this.Find("tipo_informe = '" + id_informe + "'",0,this.RowCount())
		if fila > 0 Then //ya se ha calculado la cip, preguntar si recalcular
			valor_ant = this.GetItemNumber(fila,'cuantia_colegiado') + this.GetItemNumber(fila,'cuantia_cliente')
			if valor_ant = total_informe then 
				ret = 0
			else
//				ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_devuelve_desc_concepto(id_informe)+ '?',Question!,YesNo!)
			ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_csi_articulo_descripcion(id_informe, '01')+ '?',Question!,YesNo!)
			end if
			if ret = 1 Then
				fila_insertada = fila
			Else
				fila_insertada = 0
			End If
		Else
			fila_insertada = this.event pfc_addrow()
		End if
		if fila_insertada > 0 then
			///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
			this.setredraw(false)
			this.setitem(fila_insertada, 'tipo_informe', id_informe)
			this.setitem(fila_insertada, 'empresa', '01')
			this.setredraw(true)
			// cojo los datos del concepto
			st_csi_articulos_servicios.codigo =id_informe
			st_csi_articulos_servicios.empresa = '01'			
			if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
				st_csi_articulos_servicios.t_iva = g_t_iva_defecto
			end if
			
			string soloCliente
			
			soloCliente = dw_1.getItemString(dw_1.GetRow(),'paga_gastos_cliente')
	
			///*** SCP-884. Alexis. 03/03/2011. Se inserta los descuentos mediante funci$$HEX1$$f300$$ENDHEX$$n. ***///
			wf_reparte_cantidad_descuentos(fila_insertada, total_informe , st_csi_articulos_servicios.t_iva, soloCliente)


		end if
	
	else // Si la tarifa no existe inserta una linea de cip con valor 0
		if (ls_muestra_articulos_a_cero = 'S') then 
			fila = this.Find("tipo_informe = '" + id_informe+ "'",0,this.RowCount())
			if fila = 0 Then
				///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
				this.setredraw(false)
				fila_insertada = this.event pfc_addrow()
				this.setitem(fila_insertada, 'tipo_informe', id_informe)
				this.setitem(fila_insertada, 'empresa', '01')
				this.setredraw(true)
				st_csi_articulos_servicios.codigo = id_informe
				st_csi_articulos_servicios.empresa = '01'			
				if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
					st_csi_articulos_servicios.t_iva = g_t_iva_defecto
				end if
				this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
				if this.GetItemString(fila_insertada,'participa_cliente')='S' then
					
				else
					this.setitem(fila_insertada, 'cuantia_colegiado', 0)
					this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(total_informe, st_csi_articulos_servicios.t_iva ))
				end if	
			end if
		end if	
	end if
	
	//i=i+1
//loop
next

//close tarifas_coef;

event csd_calcular_musaat()


// Es necesario que grabe para que ponga bien el estado
this.update()

st_control_eventos c_evento
c_evento.evento = 'CALCULAR_GASTOS'
//c_evento.dw = dw_fases_informes
// DAVID 28/07/04 - Cambiamos el evento de dw para que se puede utilizar con el evento VISAR
c_evento.dw = dw_1
if f_control_eventos(c_evento)=-1 then return

this.postevent ("csd_bloquea_opt_cliente")





end event

event csd_calcular_musaat();// MUSAAT

double  musaat = 0
st_csi_articulos_servicios st_csi_articulos_servicios
st_musaat_datos st_musaat_datos
double i,j
int fila_insertada
string id_col, id_asociado, ls_facturado
int ret

double porc_col = 0, porc_col_real = 0, suma_porc = 0

// Suma de la Musaat de todos los colegiados
st_musaat_datos.n_visado = dw_1.getitemstring(1, 'id_fase')
st_musaat_datos.tipo_act = dw_1.getitemstring(1, 'fase')
st_musaat_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_trabajo')
st_musaat_datos.pem = idw_fases_estadistica.getitemnumber(1, 'pem')
st_musaat_datos.administracion = idw_fases_datos_exp.getitemstring(1, 'administracion')
st_musaat_datos.superficie = idw_fases_estadistica.getitemnumber(1, 'superficie')
st_musaat_datos.volumen = idw_fases_estadistica.getitemnumber(1, 'volumen')
st_musaat_datos.colindantes2m = idw_fases_estadistica.getitemstring(1, 'colindantes2m')
st_musaat_datos.cod_colegio = dw_1.getitemstring(dw_1.getrow(), 'cod_colegio_dest' )

// Suma de los % de los colegiados
for j = 1 to idw_fases_colegiados.rowcount()
	suma_porc +=  idw_fases_colegiados.getitemnumber(j, 'porcen_a')	
next

//Cambio Luis CGU-308
if(idw_fases_colegiados.rowcount() = 1)then
	suma_porc = 100
end if
//fin cambio

for i = 1 to idw_fases_colegiados.rowcount()
	porc_col =  idw_fases_colegiados.getitemnumber(i, 'porcen_a')	
	if isnull(suma_porc) or suma_porc = 0 then exit
	porc_col_real = porc_col / suma_porc * 100	
	st_musaat_datos.porcentaje = porc_col_real
	id_col = idw_fases_colegiados.getitemstring(i, 'id_col')
	st_musaat_datos.id_col = id_col
	st_musaat_datos.cobertura = 0
	st_musaat_datos.doble_condicion =idw_fases_colegiados.getitemstring(i, 'doble_condicion')	
	st_musaat_datos.int_forzosa =idw_fases_colegiados.getitemstring(i, 'int_forzosa')	
	// Le pasamos en la estructura si el colegiado es funcionario
	st_musaat_datos.funcionario = idw_fases_colegiados.getitemstring(i, 'facturado')	
	if f_colegiado_tipopersona(id_col) = 'S' then	
		f_musaat_calcula_prima_sociedad(st_musaat_datos)
		musaat += st_musaat_datos.prima_comp	
	else
		f_musaat_calcula_prima(st_musaat_datos)	
		musaat += st_musaat_datos.prima_comp
	end if
next
if isnull(musaat) then musaat = 0

fila_insertada = 0

long fila_musaat
fila_musaat = this.Find("tipo_informe = '" + g_codigos_conceptos.musaat_variable + "' and empresa = '"+ g_cod_empresa_aseguradora +"'",0,this.RowCount())

if musaat > 0 then
	//Comprobar si ya se ha calculado los DV anteriormente

	double musaat_ant
	///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
	
	if fila_musaat > 0 Then //ya se ha calculado MUSAAT, preguntar si recalcular en el caso de que haya cambiado
		musaat_ant = this.GetItemNumber(fila_musaat,'cuantia_colegiado')
		if musaat = musaat_ant Then
			ret = 0
		else
//			ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_devuelve_desc_concepto(g_codigos_conceptos.musaat_variable)+ '?',Question!,YesNo!)
			ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_csi_articulo_descripcion(g_codigos_conceptos.musaat_variable, g_cod_empresa_aseguradora)+ '?',Question!,YesNo!)
			
		end if
		if ret = 1 Then
			fila_insertada = fila_musaat
		Else
			fila_insertada = 0
		End If
	Else
		fila_insertada = this.event pfc_addrow()
	End if
	
end if

if fila_musaat > 0 then 
	ls_facturado = this.getitemstring(fila_musaat, 'facturado')
else
	ls_facturado = 'N'
end if 	

if (musaat = 0 and g_musaat_aplica_calculo_pc_2015 = 'S' and fila_musaat > 0 and (ls_facturado <> 'S'))  then 
	ret = Messagebox(g_titulo,"La cuantia a facturar para la prima complementaria durante el a$$HEX1$$f100$$ENDHEX$$o 2015 es 0." + CR + "$$HEX1$$bf00$$ENDHEX$$Desea continuar modificando la cantidad actual?",Question!,YesNo!)
	
	if ret = 1 Then
			fila_insertada = fila_musaat
	end if		
end if 

if fila_insertada > 0 then
		///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
		this.setredraw(false)
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.musaat_variable)
		this.setitem(fila_insertada, 'empresa', g_cod_empresa_aseguradora)
		this.setredraw(true)
		
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.musaat_variable
		st_csi_articulos_servicios.empresa = g_cod_empresa_aseguradora
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		this.setitem(fila_insertada, 'cuantia_colegiado', musaat )
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(musaat, st_csi_articulos_servicios.t_iva ))
		// Se guarda la formula sustituida Agregado el 09/09/08
		if(g_colegio = 'COAATTGN' or g_colegio='COAATTEB' OR g_colegio='COAATLL')then this.setitem(fila_insertada, 'formula_sustituida', st_musaat_datos.desarrollo )
	end if

end event

event calcular_tarifas_ws();n_ws_calculo_gastos l_n_ws
integer res 
n_cst_string	lnv_string


l_n_ws = create n_ws_calculo_gastos
res = l_n_ws.of_crear_conexion( )

if res < 0 then 
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al conectar con el servicio de calculo de gastos" + CR + "Comunique al administrador los problemas detectados")
	return
end if 

calculaterequest lst_calc_request
keyvalue l_keyvalue[]

double sup_garaje,sup_otros,sup_viv, volumen, pem, total_informe
int num_viviendas, li_cantidad_articulos, li_i, ret, i
string ls_muestra_articulos_a_cero, visared, obra_oficial, t_tramite, id_informe, ls_key, ls_value, soloCliente
st_csi_articulos_servicios st_csi_articulos_servicios

select sn into :ls_muestra_articulos_a_cero from var_globales where nombre = 'g_muestra_articulos_a_cero';

sup_viv = idw_fases_estadistica.getitemnumber(1, 'sup_viv')
sup_otros= idw_fases_estadistica.getitemnumber(1, 'sup_otros')
sup_garaje=idw_fases_estadistica.getitemnumber(1, 'sup_garage')
volumen = idw_fases_estadistica.getitemnumber(1, 'volumen')
num_viviendas = idw_fases_estadistica.getitemnumber(1, 'num_viv')
pem = idw_fases_estadistica.getitemnumber(1, 'pem')
if IsNull(sup_viv) then sup_viv=0
if IsNull(sup_otros) then sup_otros=0	
if IsNull(sup_garaje) then sup_garaje=0	
if IsNull(volumen) then volumen=0	
if IsNull(num_viviendas) then num_viviendas=1
if IsNull(pem) then pem=0

visared = dw_1.GetItemString(dw_1.GetRow(),'e_mail')
obra_oficial = idw_fases_datos_exp.GetItemString(idw_fases_datos_exp.GetRow(),'administracion')
if f_es_vacio(obra_oficial) then obra_oficial = 'N'
t_tramite = dw_1.GetItemString(dw_1.GetRow(),'id_tramite')

lst_calc_request.colegio = g_cod_colegio

if obra_oficial = 'N' then 
	lst_calc_request.obra_oficial = false
else 	
	lst_calc_request.obra_oficial = true
end if 	

//lst_calc_request.obra_oficialspecified = true

if visared = 'V' then 
	lst_calc_request.visared = true
else 
	lst_calc_request.visared = false
end if 

//lst_calc_request.visaredspecified= true
lst_calc_request.pem = pem
lst_calc_request.superficie = sup_viv+sup_otros+sup_garaje
//lst_calc_request.superficiespecified= true
lst_calc_request.tipo_intervencion = dw_1.GetItemString(dw_1.GetRow(),'fase')
lst_calc_request.tipo_obra = dw_1.GetItemString(dw_1.GetRow(),'tipo_trabajo')
lst_calc_request.tramite = t_tramite
lst_calc_request.num_viv = num_viviendas
//lst_calc_request.num_participantesspecified= true
lst_calc_request.volumen = volumen
//lst_calc_request.volumenspecified= true
lst_calc_request.num_participantes = idw_fases_colegiados.rowcount()
//lst_calc_request.num_participantesspecified = true

//Forced in that moment. 
lst_calc_request.porcentaje = 100
//lst_calc_request.porcentajespecified = true

lst_calc_request.tipo_solicitud = 'NUEVO'

string ls_visared_tramites
ls_visared_tramites = visared
IF visared = 'V' THEN 
	ls_visared_tramites = 'S'
// Otros : 'S' => sin equivalencia, debe ser distinto a 'S', 'N'
elseif visared = 'S' THEN 	
	ls_visared_tramites = 'O'
end if

datastore informes

informes = create datastore
informes.dataobject = 'd_fases_informes_x_tramite'
informes.SetTransObject(SQLCA)
informes.Retrieve (ls_visared_tramites, t_tramite, g_colegio)

for i=1 to informes.RowCount()
	id_informe = informes.GetItemString(i, 'id_informe');
	
	if f_valida_articulo_activo(id_informe, g_empresa) = 0 then continue
	
	lst_calc_request.articulo	= id_informe

	//total_informe=uo_calculo_gastos.of_calcular_importe_total()
	l_keyvalue = l_n_ws.of_calcular_gastos(lst_calc_request)
	
	li_cantidad_articulos = UpperBound(l_keyvalue)
	
	For li_i = 1 To li_cantidad_articulos
		ls_key = l_keyvalue[li_i].key
		ls_value = l_keyvalue[li_i].value
		ls_value = lnv_string.of_GlobalReplace (ls_value, ".", "," ) 

		//if ls _key = id_informe then 
		if lower(ls_key) = 'tarifa' then 
			if isnumber(ls_value) then 
				total_informe= double(ls_value)
			else 
				total_informe=0
			end if	
		
			//**************
			// INSERTAR LA FILA EN GASTOS
			//**************
			if total_informe <> 0 then
				//Comprobar si ya se ha calculado anteriormente
				long fila, fila_insertada
				double valor_ant
				
				fila = this.Find("tipo_informe = '" + id_informe + "'",0,this.RowCount())
				if fila > 0 Then //ya se ha calculado la cip, preguntar si recalcular
					valor_ant = this.GetItemNumber(fila,'cuantia_colegiado') + this.GetItemNumber(fila,'cuantia_cliente')
					if valor_ant = total_informe then 
						ret = 0
					else
						ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_csi_articulo_descripcion(id_informe, '01')+ '?',Question!,YesNo!)
					end if
					if ret = 1 Then
						fila_insertada = fila
					Else
						fila_insertada = 0
					End If
				Else
					fila_insertada = this.event pfc_addrow()
				End if
				if fila_insertada > 0 then
					///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
					this.setredraw(false)
					this.setitem(fila_insertada, 'tipo_informe', id_informe)
					this.setitem(fila_insertada, 'empresa', '01')
					this.setredraw(true)
					// cojo los datos del concepto
					st_csi_articulos_servicios.codigo =id_informe
					st_csi_articulos_servicios.empresa = '01'			
					if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
						st_csi_articulos_servicios.t_iva = g_t_iva_defecto
					end if
					
					 soloCliente = dw_1.getItemString(dw_1.GetRow(),'paga_gastos_cliente')
			
					///*** SCP-884. Alexis. 03/03/2011. Se inserta los descuentos mediante funci$$HEX1$$f300$$ENDHEX$$n. ***///
					wf_reparte_cantidad_descuentos(fila_insertada, total_informe , st_csi_articulos_servicios.t_iva, soloCliente)
		
		
				end if
			
			else // Si la tarifa no existe inserta una linea de cip con valor 0
				fila = this.Find("tipo_informe = '" + id_informe+ "'",0,this.RowCount())
				if (ls_muestra_articulos_a_cero = 'S') or fila > 0 then 
					
					if fila = 0 Then
						///*** SCP-1126. Se cambia la comparaci$$HEX1$$f300$$ENDHEX$$n para conseguir que el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado sea el de la empresa correcta.***///
						this.setredraw(false)
						fila_insertada = this.event pfc_addrow()
						this.setitem(fila_insertada, 'tipo_informe', id_informe)
						this.setitem(fila_insertada, 'empresa', '01')
						this.setredraw(true)
						st_csi_articulos_servicios.codigo = id_informe
						st_csi_articulos_servicios.empresa = '01'			
						if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
							st_csi_articulos_servicios.t_iva = g_t_iva_defecto
						end if
						this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
						if this.GetItemString(fila_insertada,'participa_cliente')='S' then
							
						else
							this.setitem(fila_insertada, 'cuantia_colegiado', 0)
							this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(total_informe, st_csi_articulos_servicios.t_iva ))
						end if	
					else
						ret = Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_recalcular','$$HEX1$$bf00$$ENDHEX$$Desea recalcular ')+ f_csi_articulo_descripcion(id_informe, '01')+ '?',Question!,YesNo!)
						if ret = 1 then 
							this.setredraw(false)
							this.setitem(fila, 'tipo_informe', id_informe)
							this.setitem(fila, 'empresa', '01')
							this.setredraw(true)
							// cojo los datos del concepto
							st_csi_articulos_servicios.codigo =id_informe
							st_csi_articulos_servicios.empresa = '01'			
							if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
								st_csi_articulos_servicios.t_iva = g_t_iva_defecto
							end if
							
							soloCliente = dw_1.getItemString(dw_1.GetRow(),'paga_gastos_cliente')
					
							///*** SCP-884. Alexis. 03/03/2011. Se inserta los descuentos mediante funci$$HEX1$$f300$$ENDHEX$$n. ***///
							wf_reparte_cantidad_descuentos(fila, total_informe , st_csi_articulos_servicios.t_iva, soloCliente)
							
						end if 	
					end if
				end if	
			end if

		end if 	
	next	

next	
	
	
	







return 
end event

event itemchanged;call super::itemchanged;integer i
double porcen, ld_importe, ld_importe_colegiado_linea, ld_importe_cliente_linea, ld_importe_linea
string t_iva, ls_t_iva_linea, obra_oficial
boolean lb_modifica_precios

// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, Upper(Parent.text), dwo.name, row)

t_iva=this.getitemstring(row,'t_iva')
SELECT csi_t_iva.porcent INTO :porcen  FROM csi_t_iva WHERE csi_t_iva.t_iva = :t_iva ;

choose case dwo.name
	case 'tipo_informe'
		
		///*** SCP-1126. Alexis. 07/03/2011. Se asigna empresa a fases_informes***///
		this.setitem(row, 'empresa', f_obtener_empresa_articulo(data))
				
		SELECT csi_articulos_servicios.t_iva, csi_articulos_servicios.importe  INTO :t_iva, :ld_importe  FROM csi_articulos_servicios  
	   WHERE ( csi_articulos_servicios.codigo = :data ) AND ( csi_articulos_servicios.colegio = :g_colegio ) ; 
		this.setitem(row,'t_iva',t_iva)	
		
		if (this.getitemstring(row, 'facturado') = 'S') then
			if (MessageBox(g_titulo, 'El descuento ya ha sido facturado.'+cr+'$$HEX1$$bf00$$ENDHEX$$Desea modificar de todos modos el descuento?',  Exclamation!, YesNo!, 2)) = 2 then
				return 2
			end if
		end if 
		
		if data = g_codigos_conceptos.musaat_variable then
			this.setitem(row, 'compute_0015', 'S')
			this.setitem( row, 'participa_cliente', 'N')
			this.setitem( row, 'participa_colegiado', 'S')
			this.PostEvent('csd_recalcula_descuentos')
			return 0
		end if 
		
		
		ld_importe_colegiado_linea = this.getitemnumber(row, 'cuantia_colegiado')
		ld_importe_cliente_linea = this.getitemnumber(row, 'cuantia_cliente')

		if isnull(ld_importe_colegiado_linea) then
			ld_importe_colegiado_linea = 0
		end if
		if isnull(ld_importe_cliente_linea) then
			ld_importe_cliente_linea = 0
		end if
		
		lb_modifica_precios = false
		ls_t_iva_linea =  this.getitemstring(row, 't_iva')
		ld_importe_linea = ld_importe_colegiado_linea + ld_importe_cliente_linea  
		
		// Calculamos el importe del concepto con el calculo de gastos
		double sup_viv,sup_otros,sup_garaje,total_informe
		long res
		string t_tramite
		
		if f_var_global('g_utilizar_ws_calc_gastos') =  'N' then 
		
			n_csd_calculo_gastos uo_calculo_gastos
			uo_calculo_gastos=create n_csd_calculo_gastos
			res=uo_calculo_gastos.of_conectar_transaccion(sqlca.DBMS,sqlca.database,sqlca.LogID,sqlca.LogPass,sqlca.servername,sqlca.userid,sqlca.dbpass,sqlca.lock,sqlca.dbparm,'TRUE')
		
			if res<0 then
				MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al conectar a la base de datos")
			end if
		
			obra_oficial = idw_fases_datos_exp.GetItemString(idw_fases_datos_exp.GetRow(),'administracion')
			sup_viv = idw_fases_estadistica.getitemnumber(1, 'sup_viv')
			sup_otros= idw_fases_estadistica.getitemnumber(1, 'sup_otros')
			sup_garaje=idw_fases_estadistica.getitemnumber(1, 'sup_garage')
			if IsNull(sup_viv) then sup_viv=0
			if IsNull(sup_otros) then sup_otros=0	
			if IsNull(sup_garaje) then sup_garaje=0	
			if f_es_vacio(obra_oficial) then obra_oficial = 'N'
			
			// Inicializaci$$HEX1$$f300$$ENDHEX$$n del objeto de c$$HEX1$$e100$$ENDHEX$$lculo
			uo_calculo_gastos.of_set_string('colegio',g_colegio)		
			uo_calculo_gastos.of_set_string('obra_oficial', obra_oficial)
			uo_calculo_gastos.of_set_string('visared',dw_1.GetItemString(dw_1.GetRow(),'e_mail'))		
			uo_calculo_gastos.of_set_string('tipo_gestion',dw_1.GetItemString(dw_1.GetRow(),'tipo_gestion'))		
			uo_calculo_gastos.of_set_string('tipo_act',dw_1.GetItemString(dw_1.GetRow(),'fase'))	
			uo_calculo_gastos.of_set_string('tipo_obra',dw_1.GetItemString(dw_1.GetRow(),'tipo_trabajo'))	
			uo_calculo_gastos.of_set_double('superficie',sup_viv+sup_otros+sup_garaje)				
			uo_calculo_gastos.of_set_double('pem',idw_fases_estadistica.getitemnumber(1, 'pem'))	
			uo_calculo_gastos.of_set_string('informe',data)	// Informe seleccionado
			t_tramite=dw_1.GetItemString(dw_1.GetRow(),'id_tramite')
			
			choose case g_colegio
				case 'COAATLL', 'COAATAVI'
					uo_calculo_gastos.of_set_double('otro_rango',idw_fases_estadistica.getitemnumber(1, 'volumen'))
				case else
					uo_calculo_gastos.of_set_double('otro_rango',idw_fases_estadistica.getitemnumber(1, 'num_viv'))
			end choose
		
			ld_importe=uo_calculo_gastos.of_calcular_importe_total()
		else 
			//ld_importe= idw_fases_informes.triggerevent( 'calcular_tarifa_articulo')
			ld_importe = wf_calcular_tarifa_articulo(data)
		end if 	
		
		if ld_importe_linea <> 0 then
			if (ld_importe <> ld_importe_linea ) or (ls_t_iva_linea <> t_iva) then
				if (MessageBox(g_titulo, 'El importe o el tipo de iva del descuento seleccionado ha variado en comparaci$$HEX1$$f300$$ENDHEX$$n a los actuales datos disponibles  .'+cr+'$$HEX1$$bf00$$ENDHEX$$Desea actualizar los datos?',  Exclamation!, YesNo!, 2)) = 1 then
					lb_modifica_precios = true	  					
				end if
			end if 
		else
			lb_modifica_precios = true
		end if
		
		if lb_modifica_precios then
			this.setitem(row, 'cuantia_colegiado', ld_importe)
			this.setitem(row, 'cuantia_cliente', 0)
			this.setitem(row, 't_iva', t_iva)
			
			if ( ld_importe_cliente_linea = 0) then
				this.setitem(row, 'compute_0015', 'N')
				this.setitem( row, 'participa_cliente', 'N')
				this.setitem( row, 'participa_colegiado', 'S')
			else 
				this.setitem( row, 'participa_cliente', 'S')
				if ld_importe_colegiado_linea = 0 then
					this.setitem( row, 'participa_colegiado', 'N')
				else 
					this.setitem( row, 'participa_colegiado', 'S')
				end if
			end if
			
			idw_fases_informes.event itemchanged(row, idw_fases_informes.object.t_iva, t_iva)
			
			this.PostEvent('csd_recalcula_descuentos')			
		end if
		
	case 't_iva'
		SELECT csi_t_iva.porcent INTO :porcen  FROM csi_t_iva WHERE csi_t_iva.t_iva = :data ;
      	this.setitem(row, 'impuesto_cliente',f_redondea(this.getitemnumber(row,'cuantia_cliente')*porcen/100))    
		this.setitem(row, 'impuesto_colegiado',f_redondea(this.getitemnumber(row,'cuantia_colegiado')*porcen/100))  
	case 'cuantia_cliente'
		this.setitem(row, 'impuesto_cliente',f_redondea(double(data)*porcen/100))   
	case 'cuantia_colegiado'	
		this.setitem(row, 'impuesto_colegiado',f_redondea(double(data)*porcen/100))  
	//SCP-670. Alexis. 29/10/2010. Se a$$HEX1$$f100$$ENDHEX$$aden nuevos checks que deber$$HEX1$$e100$$ENDHEX$$n cambiar la funcionalidad de la ventana
	case 'participa_cliente'
		string ls_participa_colegiado
		
		ls_participa_colegiado = this.GetItemString(row,'participa_colegiado')
	
		if data='N' and (f_es_vacio(ls_participa_colegiado) or ls_participa_colegiado='N') then
			return 2
		else
			this.PostEvent('csd_recalcula_descuentos')
		end if
	case 'participa_colegiado'
		string ls_participa_cliente
		ls_participa_cliente = this.GetItemString(row,'participa_cliente')
		
		if data='N' and (f_es_vacio(ls_participa_cliente) or ls_participa_cliente = 'N') then
			return 2
		else
			this.PostEvent('csd_recalcula_descuentos')
		end if
	
	
end choose
	
end event

event pfc_addrow;call super::pfc_addrow;integer i
this.SetItem(this.GetRow(),'id_informe',f_siguiente_numero('FASES-INFORMES',10))
this.SetItem(this.GetRow(),'t_iva',dw_1.getitemstring(1,'t_iva'))
this.SetItem(this.GetRow(),'participa_colegiado','S')
for i=1 to this.rowcount()
	if i<>this.getrow() and isnull(this.getitemstring(i,'tipo_informe')) then
		MessageBox(g_titulo,g_idioma.of_getmsg('fases.msg_tipo_informe','Debe seleccionar un tipo de informe.'))
		i=this.rowcount()+1
		this.postevent ("pfc_deleterow")
	end if
next

return ancestorreturnvalue
end event

event pfc_insertrow;call super::pfc_insertrow;integer i
this.SetItem(this.GetRow(),'id_informe',f_siguiente_numero('FASES-INFORMES',10))
this.SetItem(this.GetRow(),'t_iva',dw_1.getitemstring(1,'t_iva'))
for i=1 to this.rowcount()
	if i<>this.getrow() and isnull(this.getitemstring(i,'tipo_informe')) then
		MessageBox(g_titulo,g_idioma.of_getmsg('fases.msg_tipo_informe','Debe seleccionar un tipo de informe.'))
		i=this.rowcount()+1
		this.postevent ("pfc_deleterow")
	end if
next

return ancestorreturnvalue
end event

event itemfocuschanged;call super::itemfocuschanged;choose case dwo.name
	case 'cuantia_colegiado'
		this.SelectText(1, LenA(string(double(this.GetText()),"###,###.00")))
end choose
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'FASES_DESCUENTOS'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

end event

event pfc_prermbmenu;call super::pfc_prermbmenu;//Cambio ley omnibus scp-603
am_dw.m_table.m_insert.enabled =true
am_dw.m_table.m_addrow.enabled = true
am_dw.m_table.m_delete.enabled =false
end event

event buttonclicked;call super::buttonclicked;st_csi_articulos_servicios lst_csi_articulos_servicios
double porcen, ld_importe, ld_importe_linea,    sup_viv,sup_otros,sup_garaje,total_informe
string ls_t_iva_linea, t_iva, t_tramite, obra_oficial
boolean lb_modifica_precios
long res


choose case dwo.name
	case 'b_desglose'
		if idw_fases_colegiados.rowcount() <= 0 then return
		if isvalid(w_descuentos_colegiado) then
			w_descuentos_colegiado.triggerevent('csd_cargar_datos')
		end if
		openwithparm(w_descuentos_colegiado, g_detalle_fases, g_detalle_fases)
		
	case 'b_desglose_ant'		
		if idw_fases_colegiados.rowcount() <= 0 then return
		if isvalid(w_descuentos_colegiado) then
			w_descuentos_colegiado_old.triggerevent('csd_cargar_datos')
		end if
		openwithparm(w_descuentos_colegiado_old, g_detalle_fases, g_detalle_fases)
		
	case 'b_informes'
		open(w_contabil_articulos_busqueda)
		lst_csi_articulos_servicios = Message.powerobjectparm
		t_iva = lst_csi_articulos_servicios.t_iva
		if isvalid(lst_csi_articulos_servicios) then
			
			if lst_csi_articulos_servicios.codigo <> '-1' then
				this.setitem(row, 'tipo_informe', lst_csi_articulos_servicios.codigo)
				this.setitem(row, 'empresa', lst_csi_articulos_servicios.empresa)
				this.setitem(row, 't_iva', t_iva )
				
				if f_var_global('g_utilizar_ws_calc_gastos') =  'N' then 
					
					// Calculamos el importe del concepto con el calculo de gastos
					n_csd_calculo_gastos uo_calculo_gastos
					uo_calculo_gastos=create n_csd_calculo_gastos
					res=uo_calculo_gastos.of_conectar_transaccion(sqlca.DBMS,sqlca.database,sqlca.LogID,sqlca.LogPass,sqlca.servername,sqlca.userid,sqlca.dbpass,sqlca.lock,sqlca.dbparm,'TRUE')
				
					if res<0 then
						MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al conectar a la base de datos")
					end if
	
					obra_oficial = idw_fases_datos_exp.GetItemString(idw_fases_datos_exp.GetRow(),'administracion')
					sup_viv = idw_fases_estadistica.getitemnumber(1, 'sup_viv')
					sup_otros= idw_fases_estadistica.getitemnumber(1, 'sup_otros')
					sup_garaje=idw_fases_estadistica.getitemnumber(1, 'sup_garage')
					if IsNull(sup_viv) then sup_viv=0
					if IsNull(sup_otros) then sup_otros=0	
					if IsNull(sup_garaje) then sup_garaje=0	
					if f_es_vacio(obra_oficial) then obra_oficial = 'N'
					
					// Inicializaci$$HEX1$$f300$$ENDHEX$$n del objeto de c$$HEX1$$e100$$ENDHEX$$lculo
					uo_calculo_gastos.of_set_string('colegio',g_colegio)
					uo_calculo_gastos.of_set_string('obra_oficial', obra_oficial)
					uo_calculo_gastos.of_set_string('visared',dw_1.GetItemString(dw_1.GetRow(),'e_mail'))		
					uo_calculo_gastos.of_set_string('tipo_gestion',dw_1.GetItemString(dw_1.GetRow(),'tipo_gestion'))		
					uo_calculo_gastos.of_set_string('tipo_act',dw_1.GetItemString(dw_1.GetRow(),'fase'))	
					uo_calculo_gastos.of_set_string('tipo_obra',dw_1.GetItemString(dw_1.GetRow(),'tipo_trabajo'))	
					uo_calculo_gastos.of_set_double('superficie',sup_viv+sup_otros+sup_garaje)				
					uo_calculo_gastos.of_set_double('pem',idw_fases_estadistica.getitemnumber(1, 'pem'))	
					uo_calculo_gastos.of_set_string('informe', lst_csi_articulos_servicios.codigo)	// Informe seleccionado
					t_tramite=dw_1.GetItemString(dw_1.GetRow(),'id_tramite')
					
					choose case g_colegio
						case 'COAATLL', 'COAATAVI'
							uo_calculo_gastos.of_set_double('otro_rango',idw_fases_estadistica.getitemnumber(1, 'volumen'))
						case else
							uo_calculo_gastos.of_set_double('otro_rango',idw_fases_estadistica.getitemnumber(1, 'num_viv'))
					end choose
					
					ld_importe=uo_calculo_gastos.of_calcular_importe_total()
				else 
					//ld_importe= idw_fases_informes.triggerevent( 'calcular_tarifa_articulo')
					ld_importe = wf_calcular_tarifa_articulo(lst_csi_articulos_servicios.codigo)
				end if 
				
				
				
				if ld_importe <>0 then
					this.setitem(row, 'cuantia_colegiado', ld_importe)
					this.setitem(row, 'cuantia_cliente', 0)
					
					SELECT csi_t_iva.porcent INTO :porcen  FROM csi_t_iva WHERE csi_t_iva.t_iva = : lst_csi_articulos_servicios.t_iva ;
					this.setitem(row, 'impuesto_colegiado',f_redondea(double(ld_importe)*porcen/100))  
					
													
				else
					this.setitem(row, 'cuantia_colegiado', lst_csi_articulos_servicios.importe)
					
					SELECT csi_t_iva.porcent INTO :porcen  FROM csi_t_iva WHERE csi_t_iva.t_iva = : lst_csi_articulos_servicios.t_iva ;
					this.setitem(row, 'impuesto_colegiado',f_redondea(double(lst_csi_articulos_servicios.importe)*porcen/100))  
				
						
				end if
			end if
			destroy uo_calculo_gastos
		end if	
		
		
	case 'b_delete'
		this.setrow(row)
		this.postevent("pfc_deleterow")
		
end choose
end event

event retrieveend;call super::retrieveend;//int li_i
//string ls_codigo_articulo
//
//for li_i =1 to this.rowcount()
//	
//	ls_codigo_articulo = this.getitemstring(li_i, 'tipo_informe') 
//	if ls_codigo_articulo = g_codigos_conceptos.musaat_variable then
//			this.setitem(li_i, 'compute_0015', 'S')
//			//this.setitem(li_i, 'participa_cliente', 'N')
//			//this.setitem( li_i, 'participa_colegiado', 'S')
//			this.SetItemStatus(li_i, "compute_0015", Primary!, NotModified!)
//	end if 
//	
//next 	

this.postevent ("csd_bloquea_opt_cliente")

return 1
end event

event pfc_predeleterow;call super::pfc_predeleterow;if this.getitemstring(this.getrow(), 'facturado') = 'S' then
	
	if messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Se pretende eliminar un descuento que ha sido facturado.'+cr+'$$HEX1$$bf00$$ENDHEX$$Desea eliminar el descuento de todos modos?',Exclamation!,YesNo!, 2) = 1 then
		return 1
	else
		return -1
	end if	
	
end if	
end event

type tabpage_13 from userobject within tab_1
string tag = "texto=general.musaat"
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "SRC"
long tabtextcolor = 8388608
long tabbackcolor = 79416533
string picturename = "Custom046!"
long picturemaskcolor = 12632256
pb_calculo_musaat pb_calculo_musaat
cb_4 cb_4
dw_fases_src dw_fases_src
end type

on tabpage_13.create
this.pb_calculo_musaat=create pb_calculo_musaat
this.cb_4=create cb_4
this.dw_fases_src=create dw_fases_src
this.Control[]={this.pb_calculo_musaat,&
this.cb_4,&
this.dw_fases_src}
end on

on tabpage_13.destroy
destroy(this.pb_calculo_musaat)
destroy(this.cb_4)
destroy(this.dw_fases_src)
end on

type pb_calculo_musaat from picturebutton within tabpage_13
integer x = 4046
integer y = 20
integer width = 288
integer height = 148
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Mostrar Calculo"
boolean originalsize = true
vtextalign vtextalign = multiline!
end type

event clicked;if dw_fases_src.rowcount() <= 0 then return
//openwithparm(w_musaat_calculo, 'RECALCULO'+dw_1.getitemstring(1,'n_registro'))
open(w_musaat_calculo)
w_musaat_calculo.dw_1.setitem(1, 'contrato', dw_1.getitemstring(1,'n_registro'))
w_musaat_calculo.dw_1.setitem(1, 'colegiado', idw_fases_src.getitemstring(idw_fases_src.getrow(),'n_col'))
w_musaat_calculo.dw_1.setitem(1, 'id_col', idw_fases_src.getitemstring(idw_fases_src.getrow(),'id_col'))
//w_musaat_calculo.dw_1.event itemchanged(1, w_musaat_calculo.dw_1.object.contrato, dw_1.getitemstring(1,'n_registro'))
w_musaat_calculo.dw_2.setitem(1, 'porcentaje', idw_fases_src.getitemnumber(idw_fases_src.getrow(),'porcentaje'))
w_musaat_calculo.dw_2.setitem(1, 'tipo_actuacion', idw_fases_src.getitemstring(idw_fases_src.getrow(),'tipo_act'))
w_musaat_calculo.dw_2.setitem(1, 'tipo_obra', idw_fases_src.getitemstring(idw_fases_src.getrow(),'tipo_obra'))
w_musaat_calculo.dw_2.setitem(1, 'pem', idw_fases_src.getitemnumber(idw_fases_src.getrow(),'presupuesto'))
w_musaat_calculo.dw_2.setitem(1, 'superficie', idw_fases_src.getitemnumber(idw_fases_src.getrow(),'superficie'))
w_musaat_calculo.dw_2.setitem(1, 'volumen', idw_fases_src.getitemnumber(idw_fases_src.getrow(),'volumen'))
w_musaat_calculo.dw_2.setitem(1, 'cobertura', idw_fases_src.getitemnumber(idw_fases_src.getrow(),'cobertura'))
w_musaat_calculo.dw_2.setitem(1, 'coef_cm', idw_fases_src.getitemnumber(idw_fases_src.getrow(),'coef_sin'))
//Luis CTE-124
if lower(idw_fases_estadistica.describe("colindantes.name"))= 'colindantes' then 
	w_musaat_calculo.dw_2.setitem(1, 'colindantes', idw_fases_estadistica.getitemstring(1,'colindantes'))
end if
if lower(idw_fases_src.describe("colindantes2m.name"))= 'colindantes2m' then 
	w_musaat_calculo.dw_2.setitem(1, 'colindantes2m', idw_fases_src.getitemstring(idw_fases_src.getrow(),'colindantes2m'))
end if
//fin cambio
//SCP-805
w_musaat_calculo.dw_2.setitem(1, 'colegio_dest', dw_1.getitemstring(1,'cod_colegio_dest'))
w_musaat_calculo.cb_calcular.triggerevent(clicked!)

end event

type cb_4 from commandbutton within tabpage_13
boolean visible = false
integer x = 3397
integer y = 252
integer width = 155
integer height = 76
integer taborder = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Verificar"
end type

event clicked;integer i
for i=1 to idw_fases_src.rowcount()
	idw_fases_src.setitem(i,'estado','V')
next
end event

type dw_fases_src from u_dw within tabpage_13
event csd_oculta_tab ( )
event csd_nombre_pestanyas ( string nombre )
event csd_enlaza ( )
integer x = 18
integer y = 20
integer width = 3982
integer height = 784
integer taborder = 11
string dataobject = "d_musaat_movimientos_contrato"
boolean hscrollbar = true
boolean livescroll = false
end type

event csd_oculta_tab;int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event csd_nombre_pestanyas;parent.text=nombre
end event

event csd_enlaza();f_enlaza_dw(dw_1,dw_fases_src,'id_fase','id_fase')
this.Retrieve(dw_1.GetItemString(1,'id_fase'))
this.visible = true

end event

event constructor;call super::constructor;this.of_setrowselect(true)

st_control_eventos c_evento
c_evento.evento = 'FASES_SRC'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return


this.GetChild('id_col',i_dwc_colegiados_src)
i_dwc_colegiados_src.settransobject(sqlca)
i_dwc_colegiados_src.InsertRow (0)

//this.object.n_contrato.visible = false
//this.object.tipo_act.visible = false
//this.object.tipo_obra.visible = false
//this.object.destino.visible = false
//this.object.presupuesto.visible = false
//this.object.superficie.visible = false
//this.object.volumen.visible = false
//this.object.importe_pendiente.visible = false
//this.object.importe_cobrado.visible = false

end event

event clicked;call super::clicked;string id_fase
id_fase = dw_1.getitemstring(1,'id_fase')
choose case dwo.name
	case 'id_col'
		f_verificar_colegiados_no_grabados(id_fase,idw_fases_colegiados,i_dwc_colegiados_src)
	case else
end choose
end event

event itemchanged;call super::itemchanged;//string id_col
//integer i
//
//// Modificacion de Datos
//dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, Upper(Parent.text), dwo.name, row)
//
//choose case dwo.name
//	case 'id_col'
//		id_col=data
//		for i=1 to this.rowcount()
//			if i<>row and id_col=this.getitemstring(i,'id_col') then
//				MessageBox(g_titulo,'No puede haber un colegiado duplicado.')
//				i=this.rowcount() + 1
//				this.deleterow(0)
//				this.postevent ("pfc_addrow")				
//			end if
//		next
//end choose
end event

event type long pfc_addrow();//IF i_dwc_colegiados_src.RowCount()<1 THEN i_dwc_colegiados_src.InsertRow(0)
//this.setitem(this.getrow(),'id_fase',dw_1.getitemstring(1,'id_fase'))


// Sobreescrito
openwithparm(w_fases_detalle_musaat, 'NUEVO')
this.retrieve(dw_1.getitemstring(1,'id_fase'))
return 1

end event

event pfc_insertrow;call super::pfc_insertrow;IF i_dwc_colegiados_src.RowCount()<1 THEN i_dwc_colegiados_src.InsertRow(0)
this.setitem(this.getrow(),'id_fase',dw_1.getitemstring(1,'id_fase'))
return 1
end event

event retrieveend;call super::retrieveend;if g_fases_estado <> g_fases_estados.preasignado then
	IF i_dwc_colegiados_src.Retrieve(dw_1.GetItemString(1,'id_fase'))<1 THEN
		i_dwc_colegiados_src.InsertRow(0)
	END IF
end if
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;// Si no hay filas en el desplegable condicional colocamos una
IF i_dwc_colegiados_src.RowCount()<1 THEN i_dwc_colegiados_src.InsertRow(0)

return 1 //AncestorReturnValue

end event

event doubleclicked;// Sobreescrito

string obser
CHOOSE CASE dwo.name
CASE 'observaciones'
		g_busqueda.titulo="Observaciones"
		obser    =this.GetItemString(row, 'observaciones')
//		data_item=this.getitemstring(row, 'observaciones') // para control modificaciones
		openwithparm(w_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
			if not isnull(obser) then 
//			   if data_item<>obser then dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, "DETALLE", 'observaciones', row)
				this.SetItem(row,'observaciones',obser)
			end if 	
		end if
	case else // Abrimos el detalle del musaat
		if row>0 then
			openwithparm(w_fases_detalle_musaat,this.getitemstring(row,'id_movimiento'))
			setpointer(arrow!)
			this.retrieve(dw_1.getitemstring(1,'id_fase'))
			idw_fases_modificacion_datos.update()
		end if
END CHOOSE
end event

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;m_dw.m_table.m_insert.enabled = False
end event

type tabpage_14 from userobject within tab_1
string tag = "texto=general.minutas"
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "Minutas"
long tabtextcolor = 8388608
long tabbackcolor = 79416533
string picturename = "Compile!"
long picturemaskcolor = 12632256
cb_generar_avisos cb_generar_avisos
cb_cobrar_avisos cb_cobrar_avisos
dw_fases_minutas dw_fases_minutas
end type

on tabpage_14.create
this.cb_generar_avisos=create cb_generar_avisos
this.cb_cobrar_avisos=create cb_cobrar_avisos
this.dw_fases_minutas=create dw_fases_minutas
this.Control[]={this.cb_generar_avisos,&
this.cb_cobrar_avisos,&
this.dw_fases_minutas}
end on

on tabpage_14.destroy
destroy(this.cb_generar_avisos)
destroy(this.cb_cobrar_avisos)
destroy(this.dw_fases_minutas)
end on

type cb_generar_avisos from commandbutton within tabpage_14
event csd_generar_aviso_musaat ( )
event csd_generar_aviso_cip ( )
event type double csd_dame_porc_col ( string id_col )
boolean visible = false
integer x = 562
integer y = 696
integer width = 494
integer height = 104
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Avisos Obra Oficial"
end type

event csd_generar_aviso_musaat();string id_minuta, id_fase, id_col, id_cli, n_aviso, pagador, t_iva, t_iva_honos, t_iva_desplaza, t_iva_dv, t_iva_cip
string tipo_movimiento_csd, pendiente='N', facturado='S', id_cliente_mayor_porc
double porc_iva, base_musaat, total_cliente, total_colegiado, irpf, porc_iva_honos, porc_iva_desplaza, porc_iva_dv
double porc_iva_cip, musaat, pem_certificacion, porc_col=0, porc_col_real=0, suma_porc=0, porc_cli_mayor=0, base_otros=0
datetime fecha, fecha_pago, fecha_nula
int i, j
st_musaat_datos st_musaat_datos
st_musaat_datos_movimiento st_musaat_datos_mov

st_csi_articulos_servicios ist_datos_dv, ist_datos_cip


ist_datos_dv.codigo = g_codigos_conceptos.dv
f_csi_articulos_servicios(ist_datos_dv)

ist_datos_cip.codigo = g_codigos_conceptos.cip
f_csi_articulos_servicios(ist_datos_cip)

setnull(fecha_nula)


// Coger el promotor de mayor %
for i = 1 to idw_fases_promotores.rowcount()
	if idw_fases_promotores.getitemnumber(i, 'porcen') > porc_cli_mayor then
		id_cliente_mayor_porc = idw_fases_promotores.getitemstring(i, 'id_cliente')
	end if
next

// Colegiados
for i = 1 to idw_fases_colegiados.rowcount()
	id_fase =  dw_1.getitemstring(1, 'id_fase')
	id_col = idw_fases_colegiados.getitemstring(i, 'id_col')

	
	
//	if not f_tiene_musaat_src(idw_fases_colegiados.getitemstring(i, 'id_col')) then continue
	suma_porc = 0
	
	st_musaat_datos.id_col = id_col	
	st_musaat_datos.n_visado = id_fase
	st_musaat_datos.tipo_act = dw_1.getitemstring(1, 'fase')
	st_musaat_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_trabajo')
	st_musaat_datos.pem = idw_fases_estadistica.getitemnumber(1, 'pem')
	st_musaat_datos.administracion = idw_fases_datos_exp.getitemstring(1, 'administracion')
	st_musaat_datos.superficie = idw_fases_estadistica.getitemnumber(1, 'superficie')
	st_musaat_datos.volumen = idw_fases_estadistica.getitemnumber(1, 'volumen')
	st_musaat_datos.recuperar = false
	
	// Si es funcionario
	if idw_fases_colegiados.getitemstring(i, 'facturado') = 'S' then
		st_musaat_datos.genera_movi = TRUE
		tipo_movimiento_csd = '14'		
	else
		st_musaat_datos.genera_movi = FALSE
		tipo_movimiento_csd = '12'
	end if
	st_musaat_datos.cobertura = 0
	// cobro del 10%
	st_musaat_datos.anticipo_10 = FALSE
	st_musaat_datos.tipo_csd = tipo_movimiento_csd 
	// Suma de los % de los colegiados
	for j = 1 to idw_fases_colegiados.rowcount()
		suma_porc =  suma_porc + idw_fases_colegiados.getitemnumber(j, 'porcen_a')		
	next
	porc_col =  idw_fases_colegiados.getitemnumber(i, 'porcen_a')	
	if isnull(suma_porc) or suma_porc = 0 then exit
	porc_col_real = porc_col / suma_porc * 100	
	st_musaat_datos.porcentaje = porc_col_real

	
	if f_colegiado_tipopersona(id_col) = 'S' then	
		f_musaat_calcula_prima_sociedad(st_musaat_datos)
		musaat = st_musaat_datos.prima_comp	
	else
		f_musaat_calcula_prima(st_musaat_datos)	
		musaat = st_musaat_datos.prima_comp		
	end if
	
	///*** ICC-320. Se comprueba si el total de mussat a cobrar iba a ser superior a 300 euros, en ese caso, se cobrar$$HEX2$$e1002000$$ENDHEX$$unicamente un 10% del total. Alexis. 23/07/2010 ***///
	if musaat > 300 and g_colegio= 'COAATCC' and  idw_fases_colegiados.getitemstring(i, 'facturado') <> 'S' then 
		tipo_movimiento_csd = '11'
		st_musaat_datos.tipo_csd = tipo_movimiento_csd
		//No hace falta el marcado por certificaciones del contrato
		//dw_1.setitem( 1, 'aplicado_10', 'S')
		
		// Se obtiene de nuevo los datos. 
		if f_colegiado_tipopersona(id_col) = 'S' then	
			f_musaat_calcula_prima_sociedad(st_musaat_datos)
			musaat = st_musaat_datos.prima_comp	
		else
			f_musaat_calcula_prima(st_musaat_datos)	
			musaat = st_musaat_datos.prima_comp		
		end if
	end if
	
	// Si el colegiado es funcionario no debe cobrar anticipo musaat
	if idw_fases_colegiados.getitemstring(i, 'facturado') = 'S' then continue
	
	// ICC-320 y ICC-313
	// Si el importe de musaat <= 300 se cobra el 100%; sino se cobra el 10%
	if isnull(musaat) then musaat = 0
	if musaat > 0 then
		id_minuta = f_siguiente_numero('FASES-MINUTAS',10)
		n_aviso = f_numera_aviso(true) // Modificado Ricardo 2005-05-12
		irpf = g_irpf_por_defecto
		fecha = datetime(today(), now())
		fecha_pago = fecha_nula //datetime(today(), now())
		pagador = '1'
		t_iva = g_t_iva_defecto
		porc_iva =  f_dame_porcent_iva(g_t_iva_defecto)
		
		base_musaat = musaat
		total_cliente = 0
		total_colegiado = musaat
		t_iva_honos = '00'
		t_iva_desplaza = '00'  
		t_iva_dv = ist_datos_dv.t_iva
		t_iva_cip = ist_datos_cip.t_iva
		porc_iva_honos = 0   
		porc_iva_desplaza = 0   
		porc_iva_dv = f_dame_porcent_iva(ist_datos_dv.t_iva)
		porc_iva_cip = f_dame_porcent_iva(ist_datos_cip.t_iva)	
		pendiente = 'S'
		facturado = 'N'
		// Paco 26/08/2005: por defecto la minuta esta pendiente y sin fecha de pago.
		//		if not facturar then
		//			fecha_pago = fecha_nula
		//			pendiente = 'S'
		//			facturado = 'N'			
		//		end if

		// Modificado Ricardo 2005-06-14
		// El presupuesto de certificacion es el 10% del total
		pem_certificacion = st_musaat_datos.pem * 10 / 100
		
		// Calculamos la bonificaci$$HEX1$$f300$$ENDHEX$$n de musaat (s$$HEX1$$f300$$ENDHEX$$lo colegiados residentes)
		if g_colegio = 'COAATLE' and LeftA(f_colegiado_residente(id_col),1) = 'R' then
			base_otros = f_redondea(base_musaat*g_porc_bonif_musaat*(-1))
		end if		
		
	//	if base_musaat <= 300 then 
			
		INSERT INTO fases_minutas  
			( id_minuta, id_fase, id_colegiado, id_cliente, cantidad, pendiente, facturado, id_honorario, f_facturado, 
			id_factura, tipo_minuta, irpf, importe_irpf, n_aviso, fecha, fecha_pago, tipo_gestion, pagador, reclamar, 
			t_iva, porc_iva, forma_pago, aplica_honos, porc_honos, concepto_honos, base_honos, iva_honos, aplica_desplaza,
			base_desplaza, iva_desplaza, concepto_desplaza, aplica_dv, base_dv, iva_dv, aplica_cip, base_cip, iva_cip,
			aplica_musaat, base_musaat, iva_musaat, aplica_retvol, porc_retvol, base_retvol, iva_retvol, total_cliente,   
			total_colegiado, t_iva_honos, t_iva_desplaza, t_iva_dv, t_iva_cip, porc_iva_honos, porc_iva_desplaza, 
			porc_iva_dv, porc_iva_cip, anulada, banco, irpf_cliente, observaciones, base_garantia, total_aviso, 
			aplica_impresos, base_impresos, iva_impresos, porc_musaat, paga_asalariado, paga_externo, paga_dv, 
			pem_certificacion, t_minuta, urgente, base_cip_suplida, t_iva_cip_suplida, porc_iva_cip_suplida, 
			iva_cip_suplida, musaat_suplida, base_otros)
		VALUES 
			( :id_minuta, :id_fase, :id_col, :id_cliente_mayor_porc, 0, :pendiente, :facturado, null, null,
			null, :tipo_movimiento_csd, :irpf, 0, :n_aviso, :fecha, :fecha_pago, 'S', :pagador, 'S', 
			:t_iva, :porc_iva, null, 'N', 0, null, 0, 0, 'N',
			0, 0, null,  'N', 0, 0, 'N', 0, 0, 
			'S', :base_musaat, 0, 'N', 0, 0, 0, :total_cliente, 
			:total_colegiado, :t_iva_honos, :t_iva_desplaza, :t_iva_dv, :t_iva_cip, :porc_iva_honos, :porc_iva_desplaza,
			:porc_iva_dv, :porc_iva_cip, 'N', null, 'N', null, 0, :total_colegiado,
			'N', 0, 0, 10, 'N', 'N', 'P', 
			:pem_certificacion, 'I', 'N', 0, '00', 0, 
			0, 0, :base_otros)  ;
					
		COMMIT;

		//if Message then
			// Para no regularizar fuerzo el cobro obligado de MUSAAT, como la minuta lleva grabado el tipo se prrodra eliminar
			// Paco 26/08/2005 Quito los g_cobro_obligado pues no tienen ning$$HEX1$$fa00$$ENDHEX$$n efecto aqu$$HEX1$$ed00$$ENDHEX$$.
//				g_cobro_obligado = 'S'
		//	openwithparm(w_caja_pagos, id_minuta)
//				g_cobro_obligado = 'N'
		//end if
	end if	
next


end event

event csd_generar_aviso_cip();string id_minuta, id_fase, id_col, id_cli, n_aviso, pagador, t_iva, t_iva_honos, t_iva_desplaza, t_iva_dv, t_iva_cip, c_geografico
string tipo_movimiento_csd, pendiente='N', facturado='S', id_cliente_mayor_porc
double porc_iva, base_musaat, total_cliente, total_colegiado, irpf, porc_iva_honos, porc_iva_desplaza, porc_iva_dv
double porc_iva_cip, musaat, pem_certificacion, porc_col=0, porc_col_real=0, suma_porc=0, porc_cli_mayor=0, base_otros=0
datetime fecha, fecha_pago, fecha_nula
double cip,cip_totales,total_cip,base_cip,iva_cip,total_iva_cip
int i, j
st_musaat_datos st_musaat_datos
st_csi_articulos_servicios ist_datos_dv, ist_datos_cip

date hoy
datetime fecha_primera,fecha_segunda
integer mes,anyo
hoy=today()
mes=month(hoy)
anyo=year(hoy)
mes+=6
if mes>12 then
	mes -= 12
	anyo ++
end if

fecha_primera=datetime(date(string(day(hoy))+'/'+string(mes)+'/'+string(anyo)))
fecha_segunda=datetime(date(string(day(hoy))+'/'+string(month(hoy))+'/'+string((year(hoy)+1))))

anyo ++


ist_datos_dv.codigo = g_codigos_conceptos.dv

select t_iva into :t_iva_dv from csi_articulos_servicios where codigo=:g_codigos_conceptos.dv;
select t_iva into :t_iva_cip from csi_articulos_servicios where codigo=:g_codigos_conceptos.cip;
porc_iva_dv = f_dame_porcent_iva(t_iva_dv)
porc_iva_cip = f_dame_porcent_iva(t_iva_cip)	

setnull(fecha_nula)

// ICC-320 y ICC-313
id_fase=dw_1.GetItemString(dw_1.GetRow(),'id_fase')

// Coger el promotor de mayor %
for i = 1 to idw_fases_promotores.rowcount()
	if idw_fases_promotores.getitemnumber(i, 'porcen') > porc_cli_mayor then
		id_cliente_mayor_porc = idw_fases_promotores.getitemstring(i, 'id_cliente')
	end if
next
cip_totales = f_cip_contrato_dw( idw_fases_informes)
// Colegiados
for i = 1 to idw_fases_colegiados.rowcount()
	
	id_col = idw_fases_colegiados.getitemstring(i, 'id_col')
	c_geografico = f_colegiado_residente(id_col)
	// Si el colegiado es acreditado se cobra el 100% del cip y sin el 10% de descuento
	
	porc_col_real=event csd_dame_porc_col(id_col)
	total_cip = max((cip_totales * porc_col_real) - f_total_avisado_cip_colegiado(id_fase, id_col) , 0)	
	total_iva_cip=total_cip * porc_iva_cip / 100	
	if isnull(total_cip) then totaL_cip = 0
	
	if total_cip > 0 then
		id_minuta = f_siguiente_numero('FASES-MINUTAS',10)
		n_aviso = f_numera_aviso(true) // Modificado Ricardo 2005-05-12
		total_cliente = 0
		pagador = '1'
		t_iva_honos = '00'
		t_iva_desplaza = '00'  
		porc_iva_honos = 0   
		porc_iva_desplaza = 0  
		t_iva = g_t_iva_defecto
		porc_iva =  f_dame_porcent_iva(g_t_iva_defecto)
		irpf = g_irpf_por_defecto
		pendiente = 'S'
		facturado = 'N'
		
		//Si el colegiado es acreditado o el cip no supera los 50 euros se cobra el 100% del Cip
		if c_geografico = 'H' or total_cip <=50 then 
			fecha = datetime(relativedate(today(),180))
			fecha_pago = datetime(today(), now())
			base_cip = f_redondea(total_cip)
			iva_cip=f_redondea(total_iva_cip)
			
			// Modificado Ricardo 2005-06-14
			// El presupuesto de certificacion es el 10% del total
			pem_certificacion = st_musaat_datos.pem * 10 / 100
			total_colegiado = base_cip +iva_cip
			
			INSERT INTO fases_minutas  
				( id_minuta, id_fase, id_colegiado, id_cliente, cantidad, pendiente, facturado, id_honorario, f_facturado, 
				id_factura, tipo_minuta, irpf, importe_irpf, n_aviso, fecha, fecha_pago, tipo_gestion, pagador, reclamar, 
				t_iva, porc_iva, forma_pago, aplica_honos, porc_honos, concepto_honos, base_honos, iva_honos, aplica_desplaza,
				base_desplaza, iva_desplaza, concepto_desplaza, aplica_dv, base_dv, iva_dv, aplica_cip, base_cip, iva_cip,
				aplica_musaat, base_musaat, iva_musaat, aplica_retvol, porc_retvol, base_retvol, iva_retvol, total_cliente,   
				total_colegiado, t_iva_honos, t_iva_desplaza, t_iva_dv, t_iva_cip, porc_iva_honos, porc_iva_desplaza, 
				porc_iva_dv, porc_iva_cip, anulada, banco, irpf_cliente, observaciones, base_garantia, total_aviso, 
				aplica_impresos, base_impresos, iva_impresos, porc_musaat, paga_asalariado, paga_externo, paga_dv, 
				pem_certificacion, t_minuta, urgente, base_cip_suplida, t_iva_cip_suplida, porc_iva_cip_suplida, 
				iva_cip_suplida, musaat_suplida, base_otros)
			VALUES 
				( :id_minuta, :id_fase, :id_col, :id_cliente_mayor_porc, 0, :pendiente, :facturado, null, null,
				null, :tipo_movimiento_csd, :irpf, 0, :n_aviso, :fecha, :fecha_pago, 'S', :pagador, 'S', 
				:t_iva, :porc_iva, null, 'N', 0, null, 0, 0, 'N',
				0, 0, null,  'N', 0, 0, 'S', :base_cip, :iva_cip, 
				'N', 0, 0, 'N', 0, 0, 0, :total_cliente, 
				:total_colegiado, :t_iva_honos, :t_iva_desplaza, :t_iva_dv, :t_iva_cip, :porc_iva_honos, :porc_iva_desplaza,
				:porc_iva_dv, :porc_iva_cip, 'N', null, 'N', null, 0, :total_colegiado,
				'N', 0, 0, 10, 'N', 'N', 'P', 
				:pem_certificacion, 'I', 'N', 0, '00', 0, 
				0, 0, :base_otros)  ;
		else
			
			//fecha = datetime(relativedate(today(),180))
			fecha = fecha_primera
			fecha_pago = fecha_nula //datetime(today(), now())
			base_cip = f_redondea(total_cip / 2)
			
			iva_cip=f_redondea(total_iva_cip/2)
			// Paco 26/08/2005: por defecto la minuta esta pendiente y sin fecha de pago.
			//		if not facturar then
			//			fecha_pago = fecha_nula
			//			pendiente = 'S'
			//			facturado = 'N'			
			//		end if
	
			// Modificado Ricardo 2005-06-14
			// El presupuesto de certificacion es el 10% del total
			pem_certificacion = st_musaat_datos.pem * 10 / 100
			total_colegiado = base_cip +iva_cip
			
			INSERT INTO fases_minutas  
				( id_minuta, id_fase, id_colegiado, id_cliente, cantidad, pendiente, facturado, id_honorario, f_facturado, 
				id_factura, tipo_minuta, irpf, importe_irpf, n_aviso, fecha, fecha_pago, tipo_gestion, pagador, reclamar, 
				t_iva, porc_iva, forma_pago, aplica_honos, porc_honos, concepto_honos, base_honos, iva_honos, aplica_desplaza,
				base_desplaza, iva_desplaza, concepto_desplaza, aplica_dv, base_dv, iva_dv, aplica_cip, base_cip, iva_cip,
				aplica_musaat, base_musaat, iva_musaat, aplica_retvol, porc_retvol, base_retvol, iva_retvol, total_cliente,   
				total_colegiado, t_iva_honos, t_iva_desplaza, t_iva_dv, t_iva_cip, porc_iva_honos, porc_iva_desplaza, 
				porc_iva_dv, porc_iva_cip, anulada, banco, irpf_cliente, observaciones, base_garantia, total_aviso, 
				aplica_impresos, base_impresos, iva_impresos, porc_musaat, paga_asalariado, paga_externo, paga_dv, 
				pem_certificacion, t_minuta, urgente, base_cip_suplida, t_iva_cip_suplida, porc_iva_cip_suplida, 
				iva_cip_suplida, musaat_suplida, base_otros)
			VALUES 
				( :id_minuta, :id_fase, :id_col, :id_cliente_mayor_porc, 0, :pendiente, :facturado, null, null,
				null, :tipo_movimiento_csd, :irpf, 0, :n_aviso, :fecha, :fecha_pago, 'S', :pagador, 'S', 
				:t_iva, :porc_iva, null, 'N', 0, null, 0, 0, 'N',
				0, 0, null,  'N', 0, 0, 'S', :base_cip, :iva_cip, 
				'N', 0, 0, 'N', 0, 0, 0, :total_cliente, 
				:total_colegiado, :t_iva_honos, :t_iva_desplaza, :t_iva_dv, :t_iva_cip, :porc_iva_honos, :porc_iva_desplaza,
				:porc_iva_dv, :porc_iva_cip, 'N', null, 'N', null, 0, :total_colegiado,
				'N', 0, 0, 10, 'N', 'N', 'P', 
				:pem_certificacion, 'I', 'N', 0, '00', 0, 
				0, 0, :base_otros)  ;
	
			id_minuta = f_siguiente_numero('FASES-MINUTAS',10)
			n_aviso = f_numera_aviso(true) // Modificado Ricardo 2005-05-12
			//fecha = datetime(relativedate(today(),360))
			fecha = fecha_segunda		
			iva_cip=total_iva_cip - iva_cip
			base_cip=total_cip - base_cip
			total_colegiado= base_cip + iva_cip
			
			INSERT INTO fases_minutas  
				( id_minuta, id_fase, id_colegiado, id_cliente, cantidad, pendiente, facturado, id_honorario, f_facturado, 
				id_factura, tipo_minuta, irpf, importe_irpf, n_aviso, fecha, fecha_pago, tipo_gestion, pagador, reclamar, 
				t_iva, porc_iva, forma_pago, aplica_honos, porc_honos, concepto_honos, base_honos, iva_honos, aplica_desplaza,
				base_desplaza, iva_desplaza, concepto_desplaza, aplica_dv, base_dv, iva_dv, aplica_cip, base_cip, iva_cip,
				aplica_musaat, base_musaat, iva_musaat, aplica_retvol, porc_retvol, base_retvol, iva_retvol, total_cliente,   
				total_colegiado, t_iva_honos, t_iva_desplaza, t_iva_dv, t_iva_cip, porc_iva_honos, porc_iva_desplaza, 
				porc_iva_dv, porc_iva_cip, anulada, banco, irpf_cliente, observaciones, base_garantia, total_aviso, 
				aplica_impresos, base_impresos, iva_impresos, porc_musaat, paga_asalariado, paga_externo, paga_dv, 
				pem_certificacion, t_minuta, urgente, base_cip_suplida, t_iva_cip_suplida, porc_iva_cip_suplida, 
				iva_cip_suplida, musaat_suplida, base_otros)
			VALUES 
				( :id_minuta, :id_fase, :id_col, :id_cliente_mayor_porc, 0, :pendiente, :facturado, null, null,
				null, :tipo_movimiento_csd, :irpf, 0, :n_aviso, :fecha, :fecha_pago, 'S', :pagador, 'S', 
				:t_iva, :porc_iva, null, 'N', 0, null, 0, 0, 'N',
				0, 0, null,  'N', 0, 0, 'S', :base_cip, :iva_cip, 
				'N', 0, 0, 'N', 0, 0, 0, :total_cliente, 
				:total_colegiado, :t_iva_honos, :t_iva_desplaza, :t_iva_dv, :t_iva_cip, :porc_iva_honos, :porc_iva_desplaza,
				:porc_iva_dv, :porc_iva_cip, 'N', null, 'N', null, 0, :total_colegiado,
				'N', 0, 0, 10, 'N', 'N', 'P', 
				:pem_certificacion, 'I', 'N', 0, '00', 0, 
				0, 0, :base_otros)  ;					
			COMMIT;
	
			//if Message then
				// Para no regularizar fuerzo el cobro obligado de MUSAAT, como la minuta lleva grabado el tipo se prrodra eliminar
				// Paco 26/08/2005 Quito los g_cobro_obligado pues no tienen ning$$HEX1$$fa00$$ENDHEX$$n efecto aqu$$HEX1$$ed00$$ENDHEX$$.
	//				g_cobro_obligado = 'S'
			//	openwithparm(w_caja_pagos, id_minuta)
	//				g_cobro_obligado = 'N'
			//end if
		end if
	end if	
next

if isvalid(g_detalle_fases) then
	g_detalle_fases.postevent('csd_refrescar_avisos')
	g_detalle_fases.postevent('csd_refrescar_src')	
end if

end event

event type double csd_dame_porc_col(string id_col);integer fila_colegiado,i
double porc_col = 0, suma_porc_col = 0, porc_col_real = 0

// % colegiado
fila_colegiado = idw_fases_colegiados.find("id_col = '" + id_col+"'", 1, idw_fases_colegiados.rowcount())
if fila_colegiado <= 0 then 
	messagebox(g_titulo, 'No se encuentra el % del colegiado')
	return -1
end if
porc_col = idw_fases_colegiados.getitemnumber(fila_colegiado, 'porcen_a')
// MODIFICADO PACO 05/05/2004
for i = 1 to idw_fases_colegiados.rowcount()
	/*if idw_colegiados.getitemstring(i, 'renunciado') <>  'S' then*/ 
	suma_porc_col += idw_fases_colegiados.getitemnumber(i, 'porcen_a')
next
if suma_porc_col = 0 or isnull(suma_porc_col) then suma_porc_col = 1
porc_col_real = porc_col / suma_porc_col

return porc_col_real
end event

event clicked;if dw_fases_datos_exp.GetItemString(dw_fases_datos_exp.GetRow(),'administracion')='N' then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","El expediente no es de una obra oficial")
	return
end if

if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Se van a generar los avisos de para obra oficial. $$HEX1$$bf00$$ENDHEX$$Desea continuar?",Question!,YesNo!)=1 then
	event csd_generar_aviso_musaat()
	event csd_generar_aviso_cip()	
	
	if isvalid(g_detalle_fases) then
		g_detalle_fases.postevent('csd_refrescar_avisos')
		g_detalle_fases.postevent('csd_refrescar_src')	
	end if

end if
	
end event

type cb_cobrar_avisos from commandbutton within tabpage_14
boolean visible = false
integer x = 14
integer y = 696
integer width = 526
integer height = 104
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cobrar Conjuntamente"
end type

event clicked;// CREADO RICARDO 2005-01-13 -> Abrimos la ventana con el numero de expediente

// MODIFICADO RICARDO 05-02-09
// Obligamos a grabar primero, sino al cobrar la minuta pide grabar
long retorno
string mensaje
// Pedimos grabar
retorno = g_detalle_fases.trigger event pfc_save()
if retorno <0 then mensaje += g_idioma.of_getmsg('fases.msg_crear_avisos_guardado',"No es posible crear avisos si el contrato no est$$HEX2$$e1002000$$ENDHEX$$previamente grabado ")

if mensaje<>'' then
	Messagebox(g_titulo,mensaje)
	return -1
end if
// MODIFICADO RICARDO 05-02-09



st_cobrar_avisos_za lsd_datos

lsd_datos.n_expedi = dw_fases_datos_exp.getitemString(1, 'n_expedi')
openwithparm(w_caja, lsd_datos)

end event

event constructor;call super::constructor;if g_colegio = 'COAATZ' or g_colegio = 'COAATGU' or g_colegio = 'COAATB' or g_colegio = 'COAATLE' or &
	g_colegio = 'COAATAVI' or g_colegio = 'COAATGC' or g_colegio = 'COAATA' or g_colegio = 'COAATNA' or  g_colegio = 'COAATTGN'  or  & 
	g_colegio = 'COAATCC'  or  g_colegio = 'COAATTEB' or g_colegio = 'COAATTEB' or g_colegio = 'COAATLR'  or g_colegio ='COAATMCA' or g_colegio ='COAATLL' then
	visible = true
end if

end event

type dw_fases_minutas from u_dw within tabpage_14
event controlar_integridad_minutas ( )
event csd_oculta_tab ( )
event csd_nombre_pestanyas ( string nombre )
event csd_enlaza ( )
integer x = 18
integer y = 20
integer width = 4315
integer height = 672
integer taborder = 11
string dataobject = "d_fases_minutas"
boolean hscrollbar = true
end type

event csd_oculta_tab;int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event csd_nombre_pestanyas;parent.text=nombre
end event

event csd_enlaza();f_enlaza_dw(dw_1,dw_fases_minutas,'id_fase','id_fase')
this.Retrieve(dw_1.GetItemString(1,'id_fase'))
this.visible = true

end event

event constructor;call super::constructor;// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

st_control_eventos c_evento

c_evento.evento = 'FASES_MINUTAS'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

/// Preparamos el dddw de colegiados de la fase (hacemos un insertrow 
//		pq tiene retrieval argument )
this.of_setrowselect(true)

// Permitimos la modificaci$$HEX1$$f300$$ENDHEX$$n de los campos de reclamaci$$HEX1$$f300$$ENDHEX$$n del aviso (INC. 4897)
long n_reg
// Se necesita tener un permiso especial para poder tocar estos campos
select count(*) into :n_reg from t_permisos where cod_usuario = :g_usuario and cod_aplicacion = 'ZGZ0000026' ;
if n_reg < 1 then return
// Habilitamos los campos
this.object.tipo_reclamacion.tabsequence = 10
this.object.f_reclamacion.tabsequence = 20

end event

event pfc_addrow;call super::pfc_addrow;//// Si no hay filas en el desplegable condicional colocamos una
//IF i_dwc_colegiados.RowCount()<1 THEN i_dwc_colegiados.InsertRow(0)
//IF i_dwc_clientes.RowCount()<1 THEN i_dwc_clientes.InsertRow(0)
//
//this.SetItem(this.GetRow(),'id_minuta',f_siguiente_numero('FASES-MINUTAS',10))
//this.SetItem(this.GetRow(),'n_aviso',f_quita_ceros(f_siguiente_numero('N_AVISO',10)))
//
//return 1

return 0
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;string id_fase,mensaje=''

id_fase = dw_1.GetItemString(1,'id_fase')

if idw_fases_promotores.rowcount() > 0 then
	g_suma_porcentajes_cli= idw_fases_promotores.getitemnumber(idw_fases_promotores.rowcount(),'suma')
else
	g_suma_porcentajes_cli=0
end if
if idw_fases_colegiados.rowcount() > 0 then
	g_suma_porcentajes_col = idw_fases_colegiados.getitemnumber(idw_fases_colegiados.rowcount(),'suma_porcentaje_a')
else
	g_suma_porcentajes_col=0
end if

if g_suma_porcentajes_cli=0 then
	mensaje+= cr + g_idioma.of_getmsg('fases.msg_cli_activos_contrato','No existen Clientes Activos para este contrato')
end if
if g_suma_porcentajes_col=0 then
	mensaje+= cr  + g_idioma.of_getmsg('fases.msg_col_activos_contrato','No existen Colegiados para este contrato')
end if
//if dw_1.GetItemString(dw_1.GetRow(),'estado') < g_fases_estados.verificado or dw_1.GetItemString(dw_1.GetRow(),'estado') >= g_fases_estados.retirado then
//	mensaje+= cr  + 'El estado del contrato es : ' + f_obtener_estado(dw_1.GetItemString(dw_1.GetRow(),'estado')) +'.'+cr + 'No se pueden crear avisos.'
//end if
if g_recien_grabado_modificacion_fases = FALSE then
	mensaje+= cr  + 'El contrato no est$$HEX2$$e1002000$$ENDHEX$$grabado o ha cambiado alg$$HEX1$$fa00$$ENDHEX$$n dato, debe grabarlo antes de generar avisos'
end if

// Modificado Ricardo 04-10-13
CHOOSE CASE g_colegio
	CASE 'COAATLR', 'COAATGU'//, 'COAATLE'
		if f_fase_puede_cobrarse_aviso_estado(dw_1.GetItemString(1,'estado'), false)=0 then 
			mensaje += cr + g_idioma.of_getmsg('fases.msg_con_estado_avisos',"El contrato est$$HEX2$$e1002000$$ENDHEX$$en un estado en el que no se permite crear avisos")
		end if
END CHOOSE
// FIN Modificado Ricardo 04-10-13

//Andr$$HEX1$$e900$$ENDHEX$$s 30/09/2005
//En guadalajara s$$HEX1$$f300$$ENDHEX$$lo dejamos crear minutas si el tipo de registro es IP
if g_colegio='COAATGU' and dw_1.getitemstring(dw_1.getrow(),'tipo_registro') = 'MI' then
	mensaje+= cr + 'El tipo de registro actual no permite a$$HEX1$$f100$$ENDHEX$$adir minutas' 
end if

// MODIFICADO RICARDO 05-02-09
// Obligamos a grabar primero, sino al cobrar la minuta pide grabar
if mensaje= '' then
	long retorno
	// Pedimos grabar
	retorno = g_detalle_fases.trigger event pfc_save()
	if retorno <0 then mensaje += cr + g_idioma.of_getmsg('fases.msg_crear_avisos_guardado',"No es posible crear avisos si el contrato no est$$HEX2$$e1002000$$ENDHEX$$previamente grabado ")
	// MODIFICADO RICARDO 05-02-09
end if

if mensaje<>'' then
	Messagebox(g_titulo,mensaje)
	return -1
end if

// Si no hay filas en el desplegable condicional colocamos una
IF i_dwc_colegiados.RowCount()<1 THEN i_dwc_colegiados.InsertRow(0)
IF i_dwc_clientes.RowCount()<1 THEN i_dwc_clientes.InsertRow(0)

// Abrirmos ventana
st_minutas_consulta minutas_consulta
minutas_consulta.accion = 'NUEVA'
minutas_consulta.id_fase = id_fase
openwithparm(w_minutas_detalle, minutas_consulta)
return 0

end event

event retrieveend;call super::retrieveend;if g_fases_estado<>g_fases_estados.preasignado then
	
//IF i_dwc_colegiados.Retrieve(dw_1.GetItemString(1,'id_fase'))<1 THEN
//	i_dwc_colegiados.InsertRow(0)
//END IF
//IF i_dwc_clientes.Retrieve(dw_1.GetItemString(1,'id_fase'))<1 THEN
//	i_dwc_clientes.InsertRow(0)
//END IF

i_dwc_colegiados.ResetUpdate()
i_dwc_clientes.ResetUpdate()
end if

end event

event itemfocuschanged;call super::itemfocuschanged;if idw_fases_promotores.rowcount() > 0 then
	g_suma_porcentajes_cli= idw_fases_promotores.getitemnumber(idw_fases_promotores.rowcount(),'suma')
else
	g_suma_porcentajes_cli=0
end if		
if idw_fases_colegiados.rowcount() > 0 then
	g_suma_porcentajes_col= idw_fases_colegiados.getitemnumber(idw_fases_colegiados.rowcount(),'suma_porcentaje_a')
else
	g_suma_porcentajes_col=0
end if	
end event

event clicked;call super::clicked;string id_fase
if row < 1 then return
id_fase = dw_1.getitemstring(1,'id_fase')

choose case dwo.name
	case 'id_colegiado'
		f_verificar_colegiados_no_grabados(id_fase,idw_fases_colegiados,i_dwc_colegiados)
	case 'id_cliente'
		f_verifica_clientes_no_grabados(id_fase,idw_fases_promotores,i_dwc_clientes)	
	case else
end choose
end event

event doubleclicked;call super::doubleclicked;if row < 1 then return

st_minutas_consulta minutas_consulta
minutas_consulta.accion = 'CONSULTA'
minutas_consulta.id_minuta = this.getitemstring(row, 'id_minuta')
openwithparm(w_minutas_detalle, minutas_consulta)

end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_delete.enabled = False
end event

event buttonclicked;call super::buttonclicked;string ret

if this.getitemstring(row, 'pendiente' ) = 'S' then
	messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_aviso_pdte_cobro','Este aviso est$$HEX2$$e1002000$$ENDHEX$$pendiente de pago'))
	openwithparm(w_minutas_anula, this.getitemstring(row, 'id_minuta') + 'PENDIENTE')
	return
elseif this.getitemstring(row, 'anulada' ) = 'S' then
	messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_aviso_anulado','Este aviso est$$HEX2$$e1002000$$ENDHEX$$anulado')	)
	openwithparm(w_minutas_anula, this.getitemstring(row, 'id_minuta') + 'ANULADO')	
	return
end if

openwithparm(w_minutas_anula, this.getitemstring(row, 'id_minuta'))

ret = message.stringparm
if ret <> 'CANCELAR' then
	st_control_eventos c_evento
	c_evento.evento = 'ANULAR_MINUTA'
	c_evento.dw = dw_1
	if f_control_eventos(c_evento)=-1 then return

//	dw_1.event csd_cambio_estado()

	this.TriggerEvent('csd_control_estados')
end if

event csd_refrescar_avisos()
event csd_refrescar_src()
end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, Upper(Parent.text), dwo.name, row)

end event

type tabpage_4 from userobject within tab_1
event pedir_grabar ( )
string tag = "MODULO VIEJO"
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "Reparos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Exclamation!"
long picturemaskcolor = 12632256
dw_fases_reparos dw_fases_reparos
end type

event pedir_grabar;Parent.TriggerEvent('pedir_grabar')
end event

on tabpage_4.create
this.dw_fases_reparos=create dw_fases_reparos
this.Control[]={this.dw_fases_reparos}
end on

on tabpage_4.destroy
destroy(this.dw_fases_reparos)
end on

type dw_fases_reparos from u_dw within tabpage_4
event comprueba_repetidos ( )
event csd_oculta_tab ( )
event csd_nombre_pestanyas ( string nombre )
event csd_enlaza ( )
event csd_anyadir_reparo ( )
event csd_anyadir_todos_colegiados ( )
event csd_notificar_por_carta ( )
event csd_notificar_por_email ( )
event csd_subsanar_reparo ( integer fila )
event csd_subsanar_todos_reparos ( )
event csd_reparos_pendientes ( )
event csd_notificar_por_sms ( )
integer x = 18
integer y = 20
integer width = 4315
integer height = 784
integer taborder = 21
string dataobject = "d_fases_reparos"
end type

event comprueba_repetidos();string id_col,t_reparo
string col,t_rep
int i,repetidos=0 

id_col = idw_fases_reparos.GetItemString(idw_fases_reparos.getrow(),'id_col')
t_reparo = idw_fases_reparos.GetItemString(idw_fases_reparos.getrow(),'tipo_reparo')

if not(f_es_vacio(id_col)) and not(f_es_vacio(t_reparo)) then
	for i=1 to idw_fases_reparos.rowCount() 
      col = idw_fases_reparos.GetItemString(i,'id_col')
      t_rep = idw_fases_reparos.GetItemString(i,'tipo_reparo')
		if id_col=col and t_reparo=t_rep then
			repetidos++
		end if
	next
end if

if repetidos>1 then
	messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_reparos_caract','Existen 2 o m$$HEX1$$e100$$ENDHEX$$s reparos con las mismas caracter$$HEX1$$ed00$$ENDHEX$$sticas.'))
end if



end event

event csd_oculta_tab;int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event csd_nombre_pestanyas;parent.text=nombre
end event

event csd_enlaza();f_enlaza_dw(dw_1,dw_fases_reparos,'id_fase','id_fase')
this.Retrieve(dw_1.GetItemString(1,'id_fase'))
this.visible = true

end event

event csd_anyadir_reparo();int indice
string id_fase,estado

if f_puedo_escribir(g_usuario,'0000000017')=1 then
	id_fase=dw_1.getitemstring(1,'id_fase')
	indice = dw_fases_reparos.RowCount()
	estado = dw_1.GetItemString(dw_1.GetRow(),'estado')
	
	//A$$HEX1$$f100$$ENDHEX$$adimos 1 linea al d_dddw_colegiados
	i_dwc_colegiados.InsertRow(0)
	
//	if estado=g_fases_estados.registrado or estado=g_fases_estados.retenido then
		dw_fases_reparos.InsertRow(indice+1)
		dw_fases_reparos.SetItem(indice+1,'id_fase',id_fase)
		dw_fases_reparos.SetItem(indice+1,'id_reparo',f_siguiente_numero('REPAROS',10))
		dw_fases_reparos.SetItem(indice+1,'f_emision',datetime(Today(), now()))
		dw_fases_reparos.SetItem(indice+1,'usuario',g_usuario)
		f_verificar_colegiados_no_grabados(id_fase,idw_fases_colegiados,i_dwc_colegiados)
//		if estado <> g_fases_estados.retenido then 
//			st_control_eventos c_evento
//			c_evento.evento = 'INSERTAR_REPAROS'
//			c_evento.dw = dw_1
//			if f_control_eventos(c_evento)=-1 then return
//			
//			dw_1.event csd_cambio_estado()
//			idw_fases_estados.insertrow(1) 
//			idw_fases_estados.setitem(1,'id_fase',id_fase)
//			idw_fases_estados.setitem(1,'estado',g_fases_estados.retenido)
//			idw_fases_estados.setitem(1,'fecha',today())
//			idw_fases_estados.setitem(1,'usuario',g_usuario)
//			dw_1.setitem(1,'estado',g_fases_estados.retenido)	
		end if
//	else
//		MessageBox(g_titulo,'No se pueden insertar reparos en el estado actual.')
//	end if
//end if
end event

event csd_anyadir_todos_colegiados();int indice,i,j,col_insertados
string usuario,fase,col_fase,col_reparo,col,t_reparo,texto,tipo_reparo,tipo
boolean existe_reparo=false

datastore ds_coleg_fases
ds_coleg_fases = create datastore
ds_coleg_fases.dataobject = 'd_reparos_colegiados_por_fases'
ds_coleg_fases.settransobject(sqlca)		

if f_puedo_escribir(g_usuario,'0000000017')=1 then
	fase = dw_1.GetItemString(dw_1.GetRow(),'id_fase')
	if dw_fases_reparos.rowcount() > 0 then
		t_reparo=dw_fases_reparos.GetItemString(dw_fases_reparos.GetRow(),'tipo_reparo')
		tipo=dw_fases_reparos.GetItemString(dw_fases_reparos.GetRow(),'tipo')
	end if
		
	col_insertados=ds_coleg_fases.retrieve(fase,col,t_reparo)
	indice = dw_fases_reparos.RowCount()
	
	if indice>0 then
		texto=dw_fases_reparos.GetItemString(dw_fases_reparos.GetRow(),'texto')
	end if
	
	//Comprobamos que haya alg$$HEX1$$fa00$$ENDHEX$$n colegiado para insertar
	if col_insertados >0 then
		for i=1 to col_insertados 
			existe_reparo=false
			col_fase =ds_coleg_fases.GetItemString(i,'id_col')
			//Comprobamos que el colegiado no exista en el DW de reparos
			if idw_fases_reparos.RowCount()>0 then
				for j=1 to idw_fases_reparos.RowCount()
					col_reparo = idw_fases_reparos.GetItemString(j,'id_col')
					tipo = idw_fases_reparos.GetItemString(j,'tipo')
					tipo_reparo = idw_fases_reparos.GetItemString(j,'tipo_reparo')
					if col_reparo = col_fase and tipo_reparo= t_reparo then
						existe_reparo=true
					end if
				next	
			end if 
			IF not(existe_reparo) then
				dw_fases_reparos.InsertRow(indice+1)
				dw_fases_reparos.SetItem(indice+1,'id_fase',fase)
				dw_fases_reparos.SetItem(indice+1,'id_col',ds_coleg_fases.GetItemString(i,'id_col'))
				dw_fases_reparos.SetItem(indice+1,'id_reparo',f_siguiente_numero('REPAROS',10))
				dw_fases_reparos.SetItem(indice+1,'f_emision',datetime(Today()))
				dw_fases_reparos.SetItem(indice+1,'tipo',tipo)
				dw_fases_reparos.SetItem(indice+1,'tipo_reparo',t_reparo)
				dw_fases_reparos.SetItem(indice+1,'texto',texto)
				dw_fases_reparos.SetItem(indice+1,'usuario',g_usuario)
				indice++
			end if
		next
	end if
end if

destroy ds_coleg_fases

//string estado
//estado = dw_1.GetItemString(dw_1.GetRow(),'estado')
//if estado <> g_fases_estados.retenido then 
//	st_control_eventos c_evento
//	c_evento.evento = 'INSERTAR_REPAROS'
//	c_evento.dw = dw_1
//	if f_control_eventos(c_evento)=-1 then return
//			
//	dw_1.event csd_cambio_estado()
//end if

end event

event csd_notificar_por_carta();int n, i, j
string id_col, notificacion, fase, id_exp, trabajo, emplazamiento, n_exp, n_calle
string clientes, colegiados, n_regfase
datetime f_subsanacion

if f_puedo_escribir(g_usuario,'0000000017')=1 then
	// modificado Ricardo 03/12/12
	// Hay que obligar a grabar primero
	long grabado_correctamente 
	grabado_correctamente = g_detalle_fases.trigger event pfc_save()
	if not(grabado_correctamente=1 or grabado_correctamente=0) then return
	// FIN modificado Ricardo 03/12/12

	fase = dw_1.GetItemString(dw_1.GetRow(),'id_fase')
	if dw_fases_reparos.RowCount()>0 then
		//Ponemos todos los reparos "no subsanados" como NO notificados, para poder notificarlos
		//todas las veces que queramos
		for n = 1 to dw_fases_reparos.RowCount()
			if isnull(dw_fases_reparos.GetItemDatetime(n,'f_subsanacion')) then
				dw_fases_reparos.SetItem(n,'notificado','N')
			end if
		next
		
		for n = 1 to dw_fases_reparos.RowCount()
			notificacion=dw_fases_reparos.GetItemString(n,'notificado')
			id_exp=f_fases_id_expedi(fase)
			trabajo = f_dame_desc_tipo_obra(dw_1.getitemstring(1, 'tipo_trabajo')) + ' / ' + dw_1.getitemstring(1, 'descripcion')//f_devuelve_trabajo(id_exp)
			n_calle = dw_1.getitemstring(1, 'n_calle')
			if isnull(n_calle) then n_calle = ''
			emplazamiento = f_devuelve_emplazamiento(id_exp) + ' ' + n_calle + ' - ' + dw_1.getitemstring(1, 'compute_2')
			f_subsanacion = dw_fases_reparos.GetItemDatetime(n,'f_subsanacion')
			if notificacion<>'S' and isnull(f_subsanacion) then
				id_col = dw_fases_reparos.GetItemString(n,'id_col')
				n_regfase = f_dame_n_reg(fase)//+' / '+f_dame_exp(fase)
				n_exp = f_dame_exp(fase)
				clientes = ''
				colegiados = ''
				for j=1 to idw_fases_promotores.RowCount()
					clientes = clientes + idw_fases_promotores.GetItemString(j,'cliente')+cr
				next
				
				for j=1 to idw_fases_colegiados.RowCount()
					colegiados = colegiados + f_colegiado(idw_fases_colegiados.GetItemString(j,'id_col'))+cr
				next
				
				if idw_fases_reparos.ModifiedCount()>0 then
					Parent.TriggerEvent('pedir_grabar')
				end if

				datastore ds_notificacion
				ds_notificacion = create datastore						
				ds_notificacion.dataobject = g_carta_reparos
				ds_notificacion.settransobject(sqlca)		
				ds_notificacion.retrieve(id_col,fase)
				for i=1 to ds_notificacion.rowcount()
					ds_notificacion.SetItem(i,'n_regfase',n_regfase)
					ds_notificacion.SetItem(i,'trabajo',trabajo)
					ds_notificacion.SetItem(i,'emplazamiento',emplazamiento)
					ds_notificacion.SetItem(i,'clientes',clientes)
					ds_notificacion.SetItem(i,'colegiados',colegiados)
					if lower(ds_notificacion.describe("n_exp.name")) = 'n_exp' then ds_notificacion.setitem(1, 'n_exp', n_exp)
				next
				ds_notificacion.Print()
				if g_colegio = 'COAATGU' then ds_notificacion.Print()
				destroy ds_notificacion
								
				for i = 1 to dw_fases_reparos.RowCount()
					if dw_fases_reparos.GetItemString(i,'id_col')=id_col and isnull(dw_fases_reparos.GetItemDatetime(i,'f_subsanacion')) then
						dw_fases_reparos.SetItem(i,'notificado','S')
					end if
				next
			end if
		next
	end if
end if

end event

event csd_notificar_por_email();string colegiado,mail,texto,nmail,fase,t_reparo
datetime f_subsanacion
string mensaje0, ls_id_cliente, ls_emplazamiento, ls_nombre, ls_clientes 
long ll_cuantos
string mensaje=''
int i,j, k

mensaje0 = g_idioma.of_getmsg('fases.msg_reparos_notificados_mail','Los siguientes reparos no han sido notificados por falta de Email de sus colegiados : ')+ cr+cr
if f_puedo_escribir(g_usuario,'0000000017')=1 then
	fase = dw_1.GetItemString(dw_1.GetRow(),'id_fase')
	
	if dw_fases_reparos.RowCount()>0 then
	j=0
		for i = 1 to dw_fases_reparos.RowCount()
			if isnull(dw_fases_reparos.GetItemDatetime(i,'f_subsanacion')) then
				dw_fases_reparos.SetItem(i,'email','N')
			end if
		next
		
		for i=1 to dw_fases_reparos.RowCount() 
			nmail=dw_fases_reparos.GetItemString(i,'email')
			f_subsanacion=dw_fases_reparos.GetItemDateTime(i,'f_subsanacion')
			t_reparo=dw_fases_reparos.GetItemString(i,'tipo_reparo')
			if nmail<>'S' and isnull(f_subsanacion) then
				colegiado = dw_fases_reparos.GetItemString(i,'id_col')
				texto = g_idioma.of_getmsg('fases.msg_querido_amigo','Estimado compa$$HEX1$$f100$$ENDHEX$$ero :')+cr+cr+g_idioma.of_getmsg('fases.msg_relacion_expediente','En relaci$$HEX1$$f300$$ENDHEX$$n al expediente ')+f_dame_n_reg(fase)+' / '+f_dame_exp(fase)+g_idioma.of_getmsg('fases.msg_observado_reparos',', se han observado los siguientes REPAROS : ')+cr+cr
				//Modificaci$$HEX1$$f300$$ENDHEX$$n realizada por Luis para la incidencia CRI-57 15/01/2009
				if(g_colegio = 'COAATLR')then
					datastore ds_fases_promotores
					ds_fases_promotores = create datastore
					ds_fases_promotores.dataobject = 'd_fases_promotores'
					ds_fases_promotores.SetTransObject(SQLCA)
					ds_fases_promotores.retrieve(fase)
					
					ll_cuantos = ds_fases_promotores.rowcount()
					for k = 1 to ll_cuantos
						ls_id_cliente = ds_fases_promotores.getitemstring(k,"id_cliente")
						ls_nombre = f_dame_cliente(ls_id_cliente)
						ls_clientes = ls_clientes+', '+ls_nombre
					next
					select emplazamiento into :ls_emplazamiento from fases where id_fase=:fase;  
					texto = 'Estimado compa$$HEX1$$f100$$ENDHEX$$ero :'+cr+cr+'En relaci$$HEX1$$f300$$ENDHEX$$n al expediente '+f_dame_n_reg(fase)+' / '+f_dame_exp(fase)+', con promotor/es '+ls_clientes+' y situaci$$HEX1$$f300$$ENDHEX$$n en '+ls_emplazamiento+', se han observado los siguientes REPAROS : '+cr+cr
				end if
				//fin modificado Luis
				for j=1 to dw_fases_reparos.RowCount()
					if dw_fases_reparos.GetItemString(j,'id_fase')=fase and dw_fases_reparos.GetItemString(j,'id_col')=colegiado and isnull(dw_fases_reparos.GetItemDatetime(j,'f_subsanacion'))then
						texto = texto + f_devuelve_tipo_reparo(dw_fases_reparos.GetItemString(j,'tipo_reparo')) + ' :'+cr
						if not isnull(dw_fases_reparos.GetItemString(j,'texto')) then texto = texto + dw_fases_reparos.GetItemString(j,'texto')+cr+cr
//						dw_fases_reparos.SetItem(j,'email','S')
					end if
				next
				mail = f_devuelve_mail(colegiado)
				
				if not(f_es_vacio(mail)) then
					f_enviar_email('Notificaciones de Reparos',texto,mail,'csd','','')
					dw_fases_reparos.SetItem(i,'email','S')
					j++
				else
					mensaje = mensaje + f_colegiado(colegiado)+'  '+f_devuelve_tipo_reparo(t_reparo)+cr
				end if
			end if
		next
		if not(f_es_vacio(mensaje)) then
			messagebox(g_titulo,mensaje0+mensaje)
		end if
	end if
end if

end event

event csd_subsanar_reparo(integer fila);if f_puedo_escribir(g_usuario,'0000000017')=1 then
	if dw_fases_reparos.RowCount()>0 then
		if isnull(dw_fases_reparos.GetItemDatetime(fila,'f_subsanacion')) then
				dw_fases_reparos.SetItem(fila,'f_subsanacion',datetime(Today()))
			else
				messagebox(G_TITULO,g_idioma.of_getmsg('fases.msg_reparo_sub','El reparo ya ha sido subsanado con anterioridad.'))
		end if
	end if
end if

// Si el tipo de reparo es OT no hay que hacer cambio de estado
if this.getitemstring(fila, 'tipo') = g_codigo_reparos_otros_doc then return

// Se comprueba si est$$HEX1$$e100$$ENDHEX$$n todos subsanados
int n
string todos = 'S'
if f_puedo_escribir(g_usuario,'0000000017')=1 then
	for n = 1 to dw_fases_reparos.RowCount()
		if isnull(dw_fases_reparos.GetItemDateTime(n,'f_subsanacion')) then todos = 'N'
	next
	if todos = 'S' then
		st_control_eventos c_evento
		c_evento.evento = 'BORRAR_REPAROS'
		c_evento.dw = dw_1
		if f_control_eventos(c_evento)=-1 then return
	end if
end if

end event

event csd_subsanar_todos_reparos();int n
boolean cambio=false

if f_puedo_escribir(g_usuario,'0000000017')<>1 then return

for n = 1 to dw_fases_reparos.RowCount()
	if isnull(dw_fases_reparos.GetItemDateTime(n,'f_subsanacion')) then
		dw_fases_reparos.SetItem(n,'f_subsanacion',datetime(Today()))
		// Si el tipo de reparo es OT no hay que hacer cambio de estado
		if this.getitemstring(n, 'tipo') = g_codigo_reparos_otros_doc then cambio = true		
		// Insertamos el cambio s$$HEX1$$f300$$ENDHEX$$lo una vez
		if not cambio then
			st_control_eventos c_evento
			c_evento.evento = 'BORRAR_REPAROS'
			c_evento.dw = dw_1
			if f_control_eventos(c_evento)=-1 then return
			cambio = true
		end if
	end if
next

end event

event csd_reparos_pendientes();int i
int reparos_pendientes = 0

if this.rowcount() <= 0 then return

for i = 1 to this.rowcount()
	if isnull(this.getitemdatetime(i, 'f_subsanacion')) then reparos_pendientes ++
next

if reparos_pendientes > 0 then
	messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_con_reparos_pdtes_sub','Este contrato tiene reparo/s pendiente/s de subsanar'), information!)
end if

end event

event csd_notificar_por_sms();string texto_sms,id_col,movil
n_csd_impresion_formato impresion

if this.rowcount()>0 then
	id_col=idw_fases_reparos.GetItemString(idw_fases_reparos.GetRow(),'id_col')
	texto_sms='Inc.'+dw_1.GetItemString(dw_1.GetRow(),'n_expedi')+"."+idw_fases_reparos.GetItemString(idw_fases_reparos.GetRow(),'texto')
	select telefono_3 into :movil from colegiados where id_colegiado=:id_col;
end if



impresion=create n_csd_impresion_formato
impresion.envio_simple=true
impresion.generar_pdf=false
impresion.avisos=1
impresion.sms='S'
impresion.texto_sms=texto_sms
impresion.moviles=movil


if impresion.f_opciones_impresion()<>1 then return
impresion.f_impresion()
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'FASES_REPAROS'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

/// Preparamos el dddw de colegiados de la fase (hacemos un insertrow 
//		pq tiene retrieval argument )
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

this.GetChild('id_col',i_dwc_colegiados_reparos)

i_dwc_colegiados_reparos.settransobject(sqlca)
i_dwc_colegiados_reparos.InsertRow (0)


//Datawindowchild dddw_cole
//
//integer rtncode
//rtncode = this.GetChild('id_col', dddw_cole)
//dddw_cole.InsertRow(0)
end event

event clicked;call super::clicked;string id_fase
id_fase = dw_1.getitemstring(1,'id_fase')
choose case dwo.name
	case 'id_col'
		f_verificar_colegiados_no_grabados(id_fase,idw_fases_colegiados,i_dwc_colegiados_reparos)
	case else
end choose
end event

event doubleclicked;call super::doubleclicked;string tex, data_item
CHOOSE CASE dwo.name
CASE 'texto'
		g_busqueda.titulo="Texto del Reparo"
		tex      =this.GetItemString(row, 'texto')
		data_item=this.getitemstring(row, 'texto') // para control modificaciones
		openwithparm(w_observaciones, tex)
		if Message.Stringparm <> '-1' then
			tex = Message.Stringparm
			if not isnull(tex) then 
				if data_item<>tex then dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, Upper(Parent.text), 'texto', row)
				dw_fases_reparos.SetItem(row,'texto',tex)
			end if
		end if
END CHOOSE
end event

event itemchanged;call super::itemchanged;string tipo, col,texto,observa,id_fase,cod, estado

// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, Upper(Parent.text), dwo.name, row)

tipo = idw_fases_reparos.GetItemString(row,'tipo_reparo')
col = idw_fases_reparos.GetItemString(row,'id_col')

CHOOSE CASE dwo.name
	case 'tipo_reparo'
		SELECT t_reparos_fases.observaciones   INTO :texto  FROM t_reparos_fases  
			WHERE t_reparos_fases.codigo = :data   ;
		if not isnull(texto) then
			 this.setitem(row,'texto',observa+ ' ' + texto)
		else
			 this.setitem(row,'texto','')
		end if
		idw_fases_reparos.PostEvent('comprueba_repetidos')
		setnull(cod)
		SELECT t_reparos_fases.codigo   INTO :cod  FROM t_reparos_fases  
			WHERE t_reparos_fases.codigo = :data   ;
		if isnull(cod) then messagebox("ERROR",g_idioma.of_getmsg('fases.msg_codigo_inexistente',"El c$$HEX1$$f300$$ENDHEX$$digo no existe"),StopSign!)
//	case 'id_col'
//		idw_fases_reparos.PostEvent('comprueba_repetidos')
	case 'tipo'
		this.post setitem(row, 'tipo_reparo', '')
		estado = dw_1.GetItemString(dw_1.GetRow(),'estado')
		if data = g_codigo_reparos_otros_doc then 
			return
		else
			if (estado = g_fases_estados.retenido or estado = g_fases_estados.registrado) then
				if estado = g_fases_estados.registrado then
					if messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_reparo_mod_estado_con','Este tipo de reparo modifica el estado actual del contrato, $$HEX1$$bf00$$ENDHEX$$Desea continuar?'), Question!,YesNo!) <> 1 then return 2
				end if		

				st_control_eventos c_evento
				c_evento.evento = 'INSERTAR_REPAROS'
				c_evento.dw = dw_1
				if f_control_eventos(c_evento)=-1 then return
				
	//			dw_1.event csd_cambio_estado() ya que lo hace el control de eventos
			else
				MessageBox(g_titulo,g_idioma.of_getmsg('fases.msg_reparo_estado_actual','No se pueden insertar reparos en el estado actual.'))
				return 2
			end if
		end if
end choose

end event

event type long pfc_addrow();call super::pfc_addrow;////Se ingresa en el campo clave de la DW el valor obtenido desde el contador
////donde "n" es un entero que indica la longitud en caracteres del contador
//string usuario,estado,fase_actual
//
//
//// Si no hay filas en el desplegable condicional colocamos una
//IF i_dwc_colegiados_reparos.RowCount()<1 THEN i_dwc_colegiados_reparos.InsertRow(0)
//
//
//
//estado = dw_1.GetItemString(1,'estado')
//fase_actual = dw_1.GetItemString(1,'id_fase')
//
//if estado=g_fases_estados.registrado or estado=g_fases_estados.retenido then
//	/// a$$HEX1$$f100$$ENDHEX$$adimos al dddw de colegiados de la fase
//	//i_dwc_colegiados.InsertRow(0)
//	
//	this.setitem(this.getrow(), 'id_reparo', f_siguiente_numero('FASES_REPAROS', 10))
//	this.setitem(this.getrow(),'usuario',g_usuario)
//	this.setitem(this.getrow(),'f_emision',datetime(today()))
//	//f_verificar_colegiados_no_grabados(fase_actual,idw_fases_colegiados,i_dwc_colegiados)
//
//	//Rellenamos el DW del hist$$HEX1$$f300$$ENDHEX$$rico de estados
//	if estado<>g_fases_estados.retenido then 
//		idw_fases_estados.insertrow(1)
//		idw_fases_estados.setitem(1,'id_fase',fase_actual)
//		idw_fases_estados.setitem(1,'estado',g_fases_estados.retenido)
//		idw_fases_estados.setitem(1,'fecha',today())
//		idw_fases_estados.setitem(1,'usuario',g_usuario)
//		dw_1.setitem(1,'estado',g_fases_estados.retenido)	
//	end if
//		
//	return 1
//else
//	Messagebox(g_titulo,'No se pueden a$$HEX1$$f100$$ENDHEX$$adir reparos en el estado actual.')
//	// No a$$HEX1$$f100$$ENDHEX$$ade filas
//	return 0
//end if
return ancestorreturnvalue
end event

event pfc_deleterow;call super::pfc_deleterow;integer i

if this.RowCount() = 0 then
	Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_estado_anterior','La fase pasar$$HEX2$$e1002000$$ENDHEX$$a estar en el estado anterior - Registrado (en an$$HEX1$$e100$$ENDHEX$$lisis)'))
	//Dejamos la fase en an$$HEX1$$e100$$ENDHEX$$lisis
//	idw_fases_estados.insertrow(1)
//	idw_fases_estados.setitem(1,'id_fase',dw_1.GetItemString(1,'id_fase'))
//	idw_fases_estados.setitem(1,'estado',g_fases_estados.registrado)
//	idw_fases_estados.setitem(1,'fecha',today())
//	idw_fases_estados.setitem(1,'usuario',g_usuario)
//	dw_1.setitem(1,'estado',g_fases_estados.registrado)	
	st_control_eventos c_evento
	c_evento.evento = 'BORRAR_REPAROS'
	c_evento.dw = dw_1
	if f_control_eventos(c_evento)=-1 then return -1

//	dw_1.event csd_cambio_estado()
end if

return 1
end event

event type long pfc_insertrow();call super::pfc_insertrow;////Se ingresa en el campo clave de la DW el valor obtenido desde el contador
////donde "n" es un entero que indica la longitud en caracteres del contador
//string usuario,estado,fase_actual
//
//
//// Si no hay filas en el desplegable condicional colocamos una
//IF i_dwc_colegiados_reparos.RowCount()<1 THEN i_dwc_colegiados_reparos.InsertRow(0)
//
//
//
//estado = dw_1.GetItemString(1,'estado')
//fase_actual = dw_1.GetItemString(1,'id_fase')
//
//if estado=g_fases_estados.registrado or estado=g_fases_estados.retenido then
//	/// a$$HEX1$$f100$$ENDHEX$$adimos al dddw de colegiados de la fase
//	//i_dwc_colegiados.InsertRow (0)
//
//	this.setitem(this.getrow(), 'id_reparo', f_siguiente_numero('FASES_REPAROS', 10))
//	this.setitem(this.getrow(),'usuario',g_usuario)
//	this.setitem(this.getrow(),'f_emision',datetime(today()))
//	//f_verificar_colegiados_no_grabados(fase_actual,idw_fases_colegiados,i_dwc_colegiados)
//	
//	if estado<>g_fases_estados.retenido then 
//		int num
//		num =  idw_fases_estados.insertrow(1)
//		idw_fases_estados.setitem(1,'id_fase',fase_actual)
//		idw_fases_estados.setitem(1,'estado',g_fases_estados.retenido)
//		idw_fases_estados.setitem(1,'fecha',today())
//		idw_fases_estados.setitem(1,'usuario',g_usuario)
//		dw_1.setitem(1,'estado',g_fases_estados.retenido)	
//		Parent.TriggerEvent('control_estados_tabs')
//	end if
//
//	return 1
//else
//	Messagebox(g_titulo,'No se pueden a$$HEX1$$f100$$ENDHEX$$adir reparos en el estado actual.')
//	// No a$$HEX1$$f100$$ENDHEX$$ade filas
//	return 0
//end if
//
return ancestorreturnvalue
end event

event pfc_predeleterow;call super::pfc_predeleterow;string notificado,email, telfax
int retonno=1

if this.Rowcount()>0 then
	notificado = this.GetitemString(this.getRow(),'notificado')
	email = this.GetitemString(this.getRow(),'email')
	telfax = this.GetitemString(this.getRow(),'telfax')
	
	if notificado='S' or email='S' or telfax = 'S' then
		messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_borrar_reparo_notificado','No se puede borrar un reparo que ha sido notificado.'))
		retonno=0	
	end if
end if

return retonno

end event

event retrieveend;call super::retrieveend;//Si la fase es 'Prenumerada' no se recupera nada (pa q no pete...)

if g_fases_estado <>g_fases_estados.preasignado then
	If i_dwc_colegiados_reparos.Retrieve(dw_1.GetItemString(1,'id_fase'))<1 THEN
		i_dwc_colegiados_reparos.insertrow(0)
	END IF
end if
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;// Si no hay filas en el desplegable condicional colocamos una
IF i_dwc_colegiados_reparos.RowCount()<1 THEN i_dwc_colegiados_reparos.InsertRow(0)

return AncestorReturnValue

end event

event itemfocuschanged;call super::itemfocuschanged;choose case dwo.name
	case 'tipo_reparo'
		if this.getitemstring(row,'tipo') <> '' then	
			DataWindowChild tipo_reparo
			this.GetChild('tipo_reparo', tipo_reparo)	
			tipo_reparo.setfilter("tipo like'" + this.getitemstring(row,'tipo') + "'")		
			tipo_reparo.filter()
		end if
	case 'tipo'
//		this.setitem(row, 'tipo_reparo', '')
	case else
end choose

end event

event pfc_prermbmenu;call super::pfc_prermbmenu;m_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False

end event

event rbuttonup;// SOBREESCRITO

//////////////////////////////////////////////////////////////////////////////
//
//	Event:  rbuttonup
//
//	Description:  Popup menu
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Added DataWindow Property to the popup menu.
// 6.0 	Added check for the new RowManager.of_GetRestoreRow() switch.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

boolean		lb_frame
boolean		lb_val
boolean		lb_readonly
integer		li_tabsequence
long			ll_getrow
string		ls_editstyle
string		ls_val
string		ls_protect
string		ls_colname
string		ls_currcolname
window		lw_parent
window		lw_frame
window		lw_sheet
window		lw_childparent
m_fases_reparos lm_dw
n_cst_conversion	lnv_conversion

// Determine if RMB popup menu should occur
if not ib_rmbmenu or IsNull (dwo) then
	return 1
end if

// No RMB support for OLE objects and graphs
if dwo.type = "ole" or dwo.type = "tableblob" or dwo.type = "graph" then
	return 1
end if

// No RMB support for print preview mode
if this.object.datawindow.print.preview = "yes" then
	return 1
end if

// Determine parent window for PointerX, PointerY offset
this.of_GetParentWindow (lw_parent)
if IsValid (lw_parent) then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	do while IsValid (lw_frame)
		if lw_frame.windowtype = mdi! or lw_frame.windowtype = mdihelp! then
			lb_frame = true
			exit
		else
			lw_frame = lw_frame.ParentWindow()
		end if
	loop
	
	if lb_frame then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		if lw_parent.windowtype = child! then
			lw_parent = lw_frame
		else
			lw_sheet = lw_frame.GetFirstSheet()
			if IsValid (lw_sheet) then
				do
					// Use frame reference for popup menu if the parentwindow is a sheet
					if lw_sheet = lw_parent then
						lw_parent = lw_frame
						exit
					end if
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				loop until IsNull(lw_sheet) Or not IsValid (lw_sheet)
			end if
		end if
	else
		// SDI application.  All windows except for child windows will use the parent
		// window of the control as the reference point for the popmenu
		if lw_parent.windowtype = child! then
			lw_childparent = lw_parent.ParentWindow()
			if IsValid (lw_childparent) then
				lw_parent = lw_childparent
			end if
		end if
	end if
else
	return 1
end if

// Create popup menu
lm_dw = create m_fases_reparos
lm_dw.of_SetParent (this)

//////////////////////////////////////////////////////////////////////////////
// Main popup menu operations
//////////////////////////////////////////////////////////////////////////////
ll_getrow = this.GetRow()

ls_val = this.object.datawindow.readonly
lb_readonly = lnv_conversion.of_Boolean (ls_val)

choose case dwo.type
	case "datawindow", "column", "compute", "text", "report", &
		"bitmap", "line", "ellipse", "rectangle", "roundrectangle"

		// Row operations based on readonly status
		lm_dw.m_table.m_insert.enabled = not lb_readonly
		lm_dw.m_table.m_addrow.enabled = not lb_readonly
		lm_dw.m_table.m_delete.enabled = not lb_readonly

		// Menu item enablement for current row
		if not lb_readonly then
			if ll_getrow > 0 then
				lm_dw.m_table.m_delete.enabled = true
				lm_dw.m_table.m_insert.enabled = true
			else
				lm_dw.m_table.m_delete.enabled = false
				lm_dw.m_table.m_insert.enabled = false
			end if
		end if
	case else
		lm_dw.m_table.m_insert.enabled = false
		lm_dw.m_table.m_delete.enabled = false
		lm_dw.m_table.m_addrow.enabled = false
end choose

// Get column properties
ls_currcolname = this.GetColumnName()
if dwo.type = "column" then
	ls_editstyle = dwo.edit.style
	ls_colname = dwo.name
	ls_protect = dwo.protect
	ls_val = dwo.tabsequence
	if IsNumber (ls_val) then
		li_tabsequence = Integer (ls_val)
	end if
end if

//////////////////////////////////////////////////////////////////////////////
// Transfer operations.  Only enable for editable column edit styles
//////////////////////////////////////////////////////////////////////////////
lm_dw.m_table.m_copy.enabled = false
lm_dw.m_table.m_cut.enabled = false
lm_dw.m_table.m_paste.enabled = false
lm_dw.m_table.m_selectall.enabled = false

if dwo.type = "column" and not lb_readonly then
	if dwo.bitmapname = "no" and ls_editstyle <> "checkbox" and ls_editstyle <> "radiobuttons" then

		if LenA (this.SelectedText()) > 0 and ll_getrow = row and ls_currcolname = ls_colname then

			// Copy
			lm_dw.m_table.m_copy.enabled = true

			// Cut
			if li_tabsequence > 0 and ls_protect = "0" then
				choose case ls_editstyle
					case "edit"
						ls_val = dwo.edit.displayonly
						lm_dw.m_table.m_cut.enabled = not lnv_conversion.of_Boolean (ls_val)
					case "editmask"
						ls_val = dwo.editmask.readonly
						lm_dw.m_table.m_cut.enabled = not lnv_conversion.of_Boolean (ls_val)
					case "ddlb"
						ls_val = dwo.ddlb.allowedit
						lm_dw.m_table.m_cut.enabled = lnv_conversion.of_Boolean (ls_val)
					case "dddw"
						ls_val = dwo.dddw.allowedit
						lm_dw.m_table.m_cut.enabled = lnv_conversion.of_Boolean (ls_val)
				end choose
			end if
		end if
			
		if li_tabsequence > 0 and ls_protect = "0" then
			// Paste
			if LenA (ClipBoard()) > 0 then
				choose case ls_editstyle
					case "edit"
						ls_val = dwo.edit.displayonly
						lm_dw.m_table.m_paste.enabled = not lnv_conversion.of_Boolean (ls_val)
					case "editmask"
						ls_val = dwo.editmask.readonly
						lm_dw.m_table.m_paste.enabled= not lnv_conversion.of_Boolean (ls_val)
					case "ddlb"
						ls_val = dwo.ddlb.allowedit
						lm_dw.m_table.m_paste.enabled = lnv_conversion.of_Boolean (ls_val)
					case "dddw"
						ls_val = dwo.dddw.allowedit
						lm_dw.m_table.m_paste.enabled = lnv_conversion.of_Boolean (ls_val)
				end choose
			end if

			// Select All
			if LenA (this.GetText()) > 0 and ll_getrow = row and ls_currcolname = ls_colname then
				choose case ls_editstyle
					case "ddlb"
						ls_val = dwo.ddlb.allowedit
						lm_dw.m_table.m_selectall.enabled = lnv_conversion.of_Boolean (ls_val)
					case "dddw"
						ls_val = dwo.dddw.allowedit
						lm_dw.m_table.m_selectall.enabled = lnv_conversion.of_Boolean (ls_val)
					case else
						lm_dw.m_table.m_selectall.enabled = true
				end choose
			end if
		end if

	end if
end if

//////////////////////////////////////////////////////////////////////////////
// Services
//////////////////////////////////////////////////////////////////////////////
// Row Manager
if IsValid (inv_rowmanager) then
	// Undelete capability
	if inv_rowmanager.of_IsRestoreRow() then
		lm_dw.m_table.m_restorerow.visible = true
		if this.DeletedCount() > 0 and not lb_readonly then
			lm_dw.m_table.m_restorerow.enabled = true
		else
			lm_dw.m_table.m_restorerow.enabled = false
		end if
	end if
else
	lm_dw.m_table.m_restorerow.visible = false
	lm_dw.m_table.m_restorerow.enabled = false
end if

// QueryMode
// Default to false
lm_dw.m_table.m_operators.visible = false
lm_dw.m_table.m_operators.enabled = false
lm_dw.m_table.m_values.visible = false
lm_dw.m_table.m_values.enabled = false
lm_dw.m_table.m_dash12.visible = false

if IsValid (inv_querymode) then
	if inv_querymode.of_GetEnabled() then
		// Do not allow undelete while in querymode
		lm_dw.m_table.m_restorerow.visible = false
		lm_dw.m_table.m_restorerow.enabled = false		

		// Default visible to true if in querymode
		lm_dw.m_table.m_values.visible = true
		lm_dw.m_table.m_operators.visible = true
		lm_dw.m_table.m_dash12.visible = true

		if dwo.type = "column" and not lb_readonly then
			if dwo.bitmapname = "no" and ls_editstyle <> "checkbox" and ls_editstyle <> "radiobuttons" then
				if li_tabsequence > 0 and ls_protect = "0" then				
					choose case ls_editstyle
						case "edit"
							ls_val = dwo.edit.displayonly
							lb_val = not lnv_conversion.of_Boolean (ls_val)
						case "editmask"
							ls_val = dwo.editmask.readonly
							lb_val = not lnv_conversion.of_Boolean (ls_val)
						case "ddlb"
							ls_val = dwo.ddlb.allowedit
							lb_val = lnv_conversion.of_Boolean (ls_val)
						case "dddw"
							ls_val = dwo.dddw.allowedit
							lb_val = lnv_conversion.of_Boolean (ls_val)
					end choose

					// Enablement based on column				
					lm_dw.m_table.m_values.enabled = lb_val
					lm_dw.m_table.m_operators.enabled = lb_val
				end if
			end if
		end if
	end if
end if

// DataWindow properties.
If IsValid(inv_property) Then
	If inv_property.of_IsPropertyOpen() = False Then
		lm_dw.m_table.m_debug.visible = True
		lm_dw.m_table.m_debug.enabled = True
	End If
//ElseIf IsValid(snv_property) Then
//	If snv_property.of_IsPropertyOpen() = False Then
//		lm_dw.m_table.m_debug.visible = True
//		lm_dw.m_table.m_debug.enabled = True
//	End If
End If	

// Allow for any other changes to the popup menu before it opens
this.event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
if IsValid (inv_rowselect) then
	inv_rowselect.event pfc_rbuttonup (xpos, ypos, row, dwo)
end if

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)
destroy lm_dw

return 1

end event

type tabpage_6 from userobject within tab_1
string tag = "texto=menu.reparos"
boolean visible = false
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "Reparos"
long tabtextcolor = 8388608
long tabbackcolor = 79416533
string picturename = "Warning!"
long picturemaskcolor = 12632256
dw_reparos_nuevos dw_reparos_nuevos
end type

on tabpage_6.create
this.dw_reparos_nuevos=create dw_reparos_nuevos
this.Control[]={this.dw_reparos_nuevos}
end on

on tabpage_6.destroy
destroy(this.dw_reparos_nuevos)
end on

type dw_reparos_nuevos from u_dw within tabpage_6
event csd_oculta_tab ( )
integer x = 18
integer y = 20
integer width = 4315
integer height = 784
integer taborder = 11
string dataobject = "d_reparos_nuevo_lista"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_oculta_tab();int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event doubleclicked;call super::doubleclicked;string tex, data_item

if row>0 then
	openWithParm(w_reparos_nuevo_detalle,this.GetItemString(row,'id_reparo_ficha'))
end if

/*
CHOOSE CASE dwo.name
CASE 'observaciones'
		g_busqueda.titulo="Texto del Reparo"
		tex      =this.GetItemString(row, 'observaciones')
		data_item=this.getitemstring(row, 'observaciones') // para control modificaciones
		openwithparm(w_observaciones, tex)
		if Message.Stringparm <> '-1' then
			tex = Message.Stringparm
			if not isnull(tex) then 
				if data_item<>tex then dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, Upper(Parent.text), 'observaciones', row)
				this.SetItem(row,'observaciones',tex)
			end if
		end if
END CHOOSE
*/
end event

event retrieveend;call super::retrieveend;DataWindowChild dwc_colegiados_reparos
//
//this.GetChild('id_colegiado',dwc_colegiados_reparos)
//
//
//dwc_colegiados_reparos.retrieve(dw_1.GetItemString(dw_1.GetRow(),'id_fase'))

// Si la fase es PREASIGNADA no se recupera nada para que no pete
datawindowchild dwc_colegiados

if g_fases_estado <>g_fases_estados.preasignado then
	If dwc_colegiados_reparos.Retrieve(dw_1.GetItemString(1,'id_fase'))<1 THEN
		dwc_colegiados_reparos.insertrow(0)
	END IF
end if

this.GetChild('id_colegiado',dwc_colegiados_reparos)

dwc_colegiados_reparos.settransobject(sqlca)
//dwc_colegiados_reparos.insertrow(0)

dwc_colegiados_reparos.retrieve(dw_1.GetItemString(dw_1.GetRow(),'id_fase'))
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'FASES_REPAROS_NEW'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return


 
 
end event

type tabpage_3 from userobject within tab_1
string tag = "general.altres_docs"
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "Otros Docs"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Group!"
long picturemaskcolor = 12632256
dw_fases_documentos dw_fases_documentos
end type

on tabpage_3.create
this.dw_fases_documentos=create dw_fases_documentos
this.Control[]={this.dw_fases_documentos}
end on

on tabpage_3.destroy
destroy(this.dw_fases_documentos)
end on

type dw_fases_documentos from u_dw within tabpage_3
event csd_oculta_tab ( )
event csd_nombre_pestanyas ( string nombre )
event csd_enlaza ( )
event csd_documentos_retirados ( )
integer x = 18
integer y = 20
integer width = 4315
integer height = 784
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_fases_documentos"
boolean hscrollbar = true
end type

event csd_oculta_tab;int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event csd_nombre_pestanyas;parent.text=nombre
end event

event csd_enlaza();f_enlaza_dw(dw_1,dw_fases_documentos,'id_fase','id_fase')
this.Retrieve(dw_1.GetItemString(1,'id_fase'))
this.visible = true

end event

event csd_documentos_retirados();// En COAATGC se cambia el estado si est$$HEX1$$e100$$ENDHEX$$n todos retirados
int n
string todos = 'S'

for n = 1 to this.RowCount()
	if isnull(this.GetItemDateTime(n,'f_retira')) then todos = 'N'
next

if todos = 'S' then
	st_control_eventos c_evento
	c_evento.evento = 'RETIRADOS_DOCUMENTOS'
	c_evento.dw = dw_1
	if f_control_eventos(c_evento)=-1 then return
end if

end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

st_control_eventos c_evento

c_evento.evento = 'FASES_OTROS_DOC'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, Upper(Parent.text), dwo.name, row)

choose case dwo.name
	case 'tipo'
		// En COAATGC se cambia el estado al a$$HEX1$$f100$$ENDHEX$$adir un documento
		st_control_eventos c_evento
		c_evento.evento = 'INSERTAR_DOCUMENTOS'
		c_evento.dw = dw_1
		if f_control_eventos(c_evento)=-1 then return

//		string cod
//		setnull(cod)
//		SELECT t_documentos.c_t_documentos   INTO :cod  FROM t_documentos
//			WHERE t_documentos.c_t_documentos = :data   ;
//		if isnull(cod) then 
//			messagebox("ERROR","El Tipo no existe",StopSign!)	
//		end if
//		elseif data = g_codigo_libro_incidencias then
//			if f_es_vacio(this.getitemstring(row,'n_reg')) then
//				this.setitem(row, 'n_reg', f_siguiente_numero('LIBROS_INCIDENCIAS',10))
//			end if
//		elseif data = g_codigo_libro_ordenes then
//			if f_es_vacio(this.getitemstring(row,'n_reg')) then
//				this.setitem(row, 'n_reg', f_siguiente_numero('LIBROS_ORDENES',10))				
//			end if			
//		end if


///*** SCP-669. Alexis. Si a$$HEX1$$f100$$ENDHEX$$adimos un documento facturable a$$HEX1$$f100$$ENDHEX$$adiremos una nueva entrada en los descuentos. 
		// En caso de ya tuviera una entrada a$$HEX1$$f100$$ENDHEX$$adida preguntaremos si quiere modificar el contenido. 
		st_csi_articulos_servicios lst_cas
		long ll_fila
		int li_return
		if f_es_facturable_t_doc(data) then
			if f_es_vacio(this.getitemstring(row, 'id_informe')) then

				if (MessageBox(g_titulo, 'El tipo de documento indicado es facturable.'+cr+'$$HEX1$$bf00$$ENDHEX$$Desea a$$HEX1$$f100$$ENDHEX$$adir el descuento correspondiente?',  Exclamation!, YesNo!, 2)) = 1 then
				
					
					select t_articulo into :lst_cas.codigo from t_documentos where c_t_documentos = :data;
					
					li_return = f_csi_articulos_servicios (lst_cas)
					
					if li_return = -1 then
						messagebox('ERROR', 'No se a$$HEX1$$f100$$ENDHEX$$adir$$HEX2$$e1002000$$ENDHEX$$un descuento debido a que el tipo de documento indicado no dispone de un art$$HEX1$$ed00$$ENDHEX$$culo asociado.'+cr+' Compruebe que el tipo de documento seleccionado.',StopSign!)
						return -1 
					end if
					
					ll_fila = idw_fases_informes.event pfc_addrow()
					idw_fases_informes.setitem(ll_fila, 'tipo_informe', lst_cas.codigo)
					idw_fases_informes.setitem(ll_fila, 't_iva', lst_cas.t_iva)
					idw_fases_informes.setitem(ll_fila, 'cuantia_colegiado', lst_cas.importe)
					idw_fases_informes.setitem(ll_fila, 'cuantia_cliente', 0)
					idw_fases_informes.setitem(ll_fila, 'participa_colegiado', 'S')
					idw_fases_informes.setitem(ll_fila, 'participa_cliente', 'N')
					
					idw_fases_informes.event itemchanged(ll_fila, idw_fases_informes.object.t_iva, lst_cas.t_iva)
					this.setitem(this.getrow(), 'id_informe', idw_fases_informes.getitemstring(ll_fila, 'id_informe'))
				end if
							
			else 
				if (MessageBox(g_titulo, 'El tipo de documento indicado es facturable y dispone de un descuento asociado al documento.'+cr+'$$HEX1$$bf00$$ENDHEX$$Desea modificar el descuento correspondiente?',  Exclamation!, YesNo!, 2)) = 1 then
					select t_articulo into :lst_cas.codigo from t_documentos where c_t_documentos = :data;
					
					li_return = f_csi_articulos_servicios (lst_cas)
					
					if li_return = -1 then
						messagebox('ERROR', 'No se a$$HEX1$$f100$$ENDHEX$$adir$$HEX2$$e1002000$$ENDHEX$$un descuento debido a que el tipo de documento indicado no dispone de un art$$HEX1$$ed00$$ENDHEX$$culo asociado.'+cr+' Compruebe que el tipo de documento seleccionado.',StopSign!)
						return -1 
					end if
					
					ll_fila = idw_fases_informes.find(" id_informe = '" + this.getitemstring(row, 'id_informe') +"'", 1, idw_fases_informes.rowcount()) 
					
					string ls_participa_colegiado, ls_participa_cliente
					ls_participa_colegiado = 	idw_fases_informes.getitemstring(ll_fila, 'participa_colegiado')
					ls_participa_cliente = 	idw_fases_informes.getitemstring(ll_fila, 'participa_cliente')
					
					if ls_participa_colegiado = 'S' or ( ls_participa_colegiado <> 'S' and ls_participa_cliente <> 'S')  then 
						idw_fases_informes.setitem(ll_fila, 'tipo_informe', lst_cas.codigo)
						idw_fases_informes.setitem(ll_fila, 't_iva', lst_cas.t_iva)
						idw_fases_informes.setitem(ll_fila, 'cuantia_colegiado', lst_cas.importe)
						idw_fases_informes.setitem(ll_fila, 'cuantia_cliente', 0)
						idw_fases_informes.setitem(ll_fila, 'participa_colegiado', 'S')
												
						idw_fases_informes.event itemchanged(ll_fila, idw_fases_informes.object.t_iva, lst_cas.t_iva)
						idw_fases_informes.setrow(ll_fila)
						idw_fases_informes.postevent ("csd_recalcula_descuentos")
					else 
						if ls_participa_cliente = 'S' then 
							idw_fases_informes.setitem(ll_fila, 'tipo_informe', lst_cas.codigo)
							idw_fases_informes.setitem(ll_fila, 't_iva', lst_cas.t_iva)
							idw_fases_informes.setitem(ll_fila, 'cuantia_colegiado', 0)
							idw_fases_informes.setitem(ll_fila, 'cuantia_cliente', lst_cas.importe)
							//idw_fases_informes.setitem(ll_fila, 'participa_cliente', 'S')
																					
							idw_fases_informes.event itemchanged(ll_fila, idw_fases_informes.object.t_iva, lst_cas.t_iva)
							idw_fases_informes.setrow(ll_fila)
							idw_fases_informes.postevent ("csd_recalcula_descuentos")
						end if
					end if	
				end if	
			end if
		end if	
			
	CASE 'f_retira'
		post event csd_documentos_retirados()

end choose


end event

event pfc_addrow;call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.getrow(), 'id_docu', f_siguiente_numero('FASES_DOCUMENTOS', 10))
//donde "n" es un entero que indica la longitud en caracteres del contador

this.setitem(this.getrow(), 'f_entrada', datetime(today()))

return 1

end event

event pfc_insertrow;call super::pfc_insertrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.getrow(), 'id_docu', f_siguiente_numero('FASES_DOCUMENTOS', 10))
//donde "n" es un entero que indica la longitud en caracteres del contador

this.setitem(this.getrow(), 'f_entrada', datetime(today()))

return 1

end event

event buttonclicked;call super::buttonclicked;string cod
int i
st_w_escanear lst_datos_escanear
string ls_ruta_relativa_documentos,ruta_fichero
string ls_ruta_doc,ls_nom_doc,ls_ruta_guardar,ls_ruta_dest,tipo_numeracion
int li_valor
n_file_dialogs lnv_file_dialog
boolean lb_existe
datastore ds_caratula_documento

ls_ruta_relativa_documentos=g_anyo_numeracion+'\'+dw_1.getitemstring(dw_1.getrow(),'n_registro')		
ls_ruta_guardar=g_directorio_documentos_fases+ls_ruta_relativa_documentos+"\"

choose case dwo.name
	case 'b_1' // Abre la ventana de detalle
		this.accepttext()
		g_st_fases_libro.id_docu=this.getitemstring(row,'id_docu')
		g_st_fases_libro.id_fase=dw_1.getitemstring(1,'id_fase')
		g_st_fases_libro.tipo=this.getitemstring(row,'tipo')
		g_st_fases_libro.registro=dw_1.getitemstring(1,'n_registro')
		g_st_fases_libro.n_libro=this.getitemstring(row,'n_reg')
		g_st_fases_libro.fecha=this.getitemdatetime(row,'f_entrada')
		g_st_fases_libro.fecha_ret=this.getitemdatetime(row,'f_retira')
		g_st_fases_libro.visado=dw_1.getitemstring(1,'archivo_fase')
		g_st_fases_libro.n_col = idw_fases_colegiados.rowcount()
		for i=1 to idw_fases_colegiados.rowcount()
			g_st_fases_libro.colegiado[i] = idw_fases_colegiados.getitemstring(i,'id_col')
		next
		
		openwithparm(w_fases_libros,g_st_fases_libro)
	case 'b_2' // genera el n$$HEX2$$ba002000$$ENDHEX$$de registro
		this.accepttext()
		select texto into :tipo_numeracion  from var_globales where nombre='g_tipo_num_doc';
		if f_es_vacio(this.getitemstring(row,'n_reg')) then
			choose case tipo_numeracion
				case 'TIPO_DOCUMENTO'
					if this.getitemstring(row,'tipo')=g_codigo_libro_incidencias then
						this.setitem(row, 'n_reg', f_siguiente_numero('LIBROS_INCIDENCIAS',10))
					elseif this.getitemstring(row,'tipo') = g_codigo_libro_ordenes then
						this.setitem(row, 'n_reg', f_siguiente_numero('LIBROS_ORDENES',10))				
					end if
				case 'FASE'
					if this.getitemstring(row,'tipo')=g_codigo_libro_incidencias then
						this.setitem(row, 'n_reg', f_siguiente_numero('LIBROS_INCIDENCIAS',10) + f_delegacion_siglas(g_cod_delegacion) )
					elseif this.getitemstring(row,'tipo') = g_codigo_libro_ordenes then
						this.setitem(row, 'n_reg', f_siguiente_numero('LIBROS_ORDENES',10) + f_delegacion_siglas(g_cod_delegacion))
					else 
						this.setitem(row, 'n_reg', f_siguiente_numero('CERTIFICADOS_CC',10) + f_delegacion_siglas(g_cod_delegacion))
					end if
				case else //GENERAL
						this.setitem(row, 'n_reg', f_siguiente_numero('NUM_DOC_ANEXOS',10))		
			end choose
			//Falta lanzar la impresi$$HEX1$$f300$$ENDHEX$$n de la caratula
				this.update( )
	end if
	
	///*** SCP-1660. Se consulta la variable para comprobar si es necesaria la impresi$$HEX1$$f300$$ENDHEX$$n del documento. Alexis. 19/09/2011 ***///
	if f_imprimir_doc_registro() = 'S' then 
		if not f_es_vacio(this.getitemstring(row, 'n_reg' )) then
			ds_caratula_documento = CREATE DATASTORE
			ds_caratula_documento.DATAOBJECT = 'd_fases_caratula_doc'
			ds_caratula_documento.setTransObject(SQLCA)
			ds_caratula_documento.retrieve(this.getitemstring(row, 'id_docu'))
			ds_caratula_documento.print()
		end if 
	end if
	
	case 'b_3' // abre mantenimiento de documentos
		open(w_tipos_documentos)
	


	case 'b_escanear'
		lst_datos_escanear.nombre_fichero=''
		lst_datos_escanear.ruta=ls_ruta_guardar
			
		openWithParm(w_escaner_principal,lst_datos_escanear)
		
		ruta_fichero=Message.StringParm
		
		if f_es_vacio(ruta_fichero) then return
		ls_nom_doc=MidA(ruta_fichero,lastpos(ruta_fichero,'\') + 1,LenA(ruta_fichero))
		
		this.setitem(row,'nombre_fichero',ls_nom_doc) 
		this.setitem(row,'ruta_fichero',ls_ruta_relativa_documentos)
		
	case 'b_seleccionar_fichero'

				
		//Comprobamos que existe g_directorio_documentos_fases+g_anyo_numeracion ya que sino, no podemos crear
		//un directorio por debajo de este
		
		lb_existe=gnv_fichero.of_directoryexists(g_directorio_documentos_fases+g_anyo_numeracion)
		
		if not lb_existe then
			li_valor=gnv_fichero.of_createdirectory(g_directorio_documentos_fases+g_anyo_numeracion)
		end if
		
		if li_valor=-1 then 
			Messagebox('Error',g_idioma.of_getmsg('fases.msg_error_crear_dir','Error al crear el directorio donde se copiar$$HEX1$$e100$$ENDHEX$$n los documentos asociados a este contrato.')&
			+cr+g_idioma.of_getmsg('fases.msg_asegurar_dir','Aseg$$HEX1$$fa00$$ENDHEX$$rese de que el directorio ')+g_directorio_documentos_fases+g_idioma.of_getmsg('general.existe',' existe.'),StopSign!)
			return
	   end if
		//Seleccionamos el fichero y lo copiamos al directorio adecuado
		//S$$HEX1$$f300$$ENDHEX$$lo permitimos seleccionar un fichero
		lnv_file_dialog.ib_allowmultiselect = false

		li_valor = lnv_file_dialog.of_getopenfilename(g_idioma.of_getmsg('fases.msg_sel_doc',"Seleccionar Documento"), ls_ruta_doc, ls_nom_doc,"", "Todos los archivos,*.*,")
		if li_valor = 1 then
			//creamos el directorio y copiamos el fichero
			ls_ruta_dest=ls_ruta_guardar+ls_nom_doc
			gnv_fichero.of_createdirectory(ls_ruta_guardar)
			gnv_fichero.of_filecopy(ls_ruta_doc + "\" + ls_nom_doc, ls_ruta_dest, FALSE)
			//guardamos el nombre del fichero
			this.setitem(row,'nombre_fichero',ls_nom_doc) 
			this.setitem(row,'ruta_fichero',ls_ruta_relativa_documentos)
		end if 
	case else
end choose
end event

event doubleclicked;call super::doubleclicked;string ls_doc, ls_documento, ls_ruta, ls_nombre_fichero, ls_ruta_relativa
int pos_anterior_barra=0, pos_barra

ls_ruta_relativa=this.GetItemString(row,'ruta_fichero')
ls_nombre_fichero=this.GetItemString(row,'nombre_fichero')
ls_doc=g_directorio_documentos_fases+ls_ruta_relativa+"\"+ls_nombre_fichero

if f_es_vacio(ls_nombre_fichero) then return

//Buscamos la posicion donde se encuentra la $$HEX1$$fa00$$ENDHEX$$ltima barra
pos_barra = PosA(ls_doc,'\',1)	
DO UNTIL  pos_anterior_barra >= LenA(ls_doc)
	ls_documento = MidA(ls_doc,pos_anterior_barra+1,(pos_barra - pos_anterior_barra)-1)
	pos_anterior_barra = pos_barra
	pos_barra = PosA(ls_doc,'\',pos_anterior_barra + 1)
	if pos_barra = 0 then 
		ls_documento = MidA(ls_doc,pos_anterior_barra+1,LenA(ls_doc))		
		exit
	end if
LOOP

//Sacamos el nombre del documento
ls_documento=MidA(ls_doc,pos_anterior_barra+1)
ls_ruta=LeftA(ls_doc,pos_anterior_barra)

//Abrimos el fichero con su programa asociado en Windows
f_abrir_fichero(ls_ruta,ls_documento,"")

end event

event pfc_predeleterow;call super::pfc_predeleterow;int li_resultado
boolean lb_borrado
string ls_fichero

if f_es_vacio(this.getitemstring(this.getrow(),'ruta_fichero')) then return 1

li_resultado=messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Se borrar$$HEX2$$e1002000$$ENDHEX$$del disco el fichero seleccionado de la lista.'+cr+'$$HEX1$$bf00$$ENDHEX$$Desea continuar?',Exclamation!,YesNo!)
if li_resultado=2 then return 0


ls_fichero = g_directorio_documentos_fases + this.getitemstring(this.getrow(),'ruta_fichero') +'\' +this.getitemstring(this.getrow(),'nombre_fichero')


lb_borrado=filedelete(ls_fichero)

//Si se ha borrado o no exist$$HEX1$$ed00$$ENDHEX$$a...
if fileexists(ls_fichero)=false then lb_borrado=true

if lb_borrado=false then 
	//Notificamos al usuario que no se ha podido borrar el fichero y abortamos el borrado de la fila del dw
   MessageBox('Error',g_idioma.of_getmsg('fases.msg_borrar_fichero','No se ha podido borrar el fichero: ')+ls_fichero+cr+g_idioma.of_getmsg('fases.msg_fichero:usado_aplicacion','Compruebe que el fichero no lo est$$HEX2$$e1002000$$ENDHEX$$utilizando alguna aplicaci$$HEX1$$f300$$ENDHEX$$n.') ,StopSign!)
	return 0
end if

return 1
end event

event clicked;call super::clicked;
		DataWindowChild dropdowntipos
		this.getchild('tipo',dropdowntipos)
    	     dropdowntipos.SetTransobject(sqlca)
          dropdowntipos.retrieve()
end event

type tabpage_12 from userobject within tab_1
string tag = "texto=general.reclamaciones_estados"
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "Reclamaciones/Estados"
long tabtextcolor = 8388608
long tabbackcolor = 79416533
string picturename = "AddWatch!"
long picturemaskcolor = 12632256
dw_fases_estados dw_fases_estados
dw_fases_reclamaciones dw_fases_reclamaciones
end type

on tabpage_12.create
this.dw_fases_estados=create dw_fases_estados
this.dw_fases_reclamaciones=create dw_fases_reclamaciones
this.Control[]={this.dw_fases_estados,&
this.dw_fases_reclamaciones}
end on

on tabpage_12.destroy
destroy(this.dw_fases_estados)
destroy(this.dw_fases_reclamaciones)
end on

type dw_fases_estados from u_dw within tabpage_12
event csd_enlaza ( )
integer x = 1883
integer y = 20
integer width = 1879
integer height = 784
integer taborder = 11
string dataobject = "d_fases_estados"
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event csd_enlaza();f_enlaza_dw(dw_1,dw_fases_estados,'id_fase','id_fase')
this.Retrieve(dw_1.GetItemString(1,'id_fase'))
this.visible = true

end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = False
end event

type dw_fases_reclamaciones from u_dw within tabpage_12
event csd_oculta_tab ( )
event csd_nombre_pestanyas ( string nombre )
event csd_enlaza ( )
integer x = 18
integer y = 20
integer width = 1838
integer height = 784
integer taborder = 21
string dataobject = "d_fases_reclamaciones"
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_oculta_tab;int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event csd_nombre_pestanyas;parent.text=nombre
end event

event csd_enlaza();f_enlaza_dw(dw_1,dw_fases_reclamaciones,'id_fase','id_fase')
this.Retrieve(dw_1.GetItemString(1,'id_fase'))
this.visible = true

end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = False
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'FASES_NOTIFICACIONES'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

end event

event doubleclicked;call super::doubleclicked;if this.dataobject = 'd_fases_reclamaciones' then return
if this.rowcount() < 1 then return
if dw_1.rowcount() < 1 then return
openwithparm(w_modificar_fechas_carta, dw_1.getitemstring(1, 'id_fase'))
end event

type tabpage_9 from userobject within tab_1
string tag = "texto=general.otras_fases"
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "Otras Fases"
long tabtextcolor = 8388608
long tabbackcolor = 79416533
string picturename = "Where!"
long picturemaskcolor = 12632256
dw_fases_otras_fases dw_fases_otras_fases
end type

on tabpage_9.create
this.dw_fases_otras_fases=create dw_fases_otras_fases
this.Control[]={this.dw_fases_otras_fases}
end on

on tabpage_9.destroy
destroy(this.dw_fases_otras_fases)
end on

type dw_fases_otras_fases from u_dw within tabpage_9
event csd_oculta_tab ( )
event csd_nombre_pestanyas ( string nombre )
integer x = 18
integer y = 20
integer width = 4315
integer height = 784
integer taborder = 11
string dataobject = "d_fases_otras_fases_tab"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_oculta_tab;int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event csd_nombre_pestanyas;parent.text=nombre
end event

event doubleclicked;call super::doubleclicked;string id_fase
//string fase
//int net

//*************************************
// Comentado Paco 26/08/2005
//*************************************
//if dw_1.ModifiedCount() + dw_1.DeletedCount() > 0 then
//	if MessageBox(g_titulo, '$$HEX1$$bf00$$ENDHEX$$Desea grabar los cambios?', Question!,YesNo!) = 1 then
//		dw_1.Update()
//	else
//		return
//	end if
//end if
//if idw_fases_promotores.ModifiedCount() + idw_fases_promotores.DeletedCount() > 0 then
//	if MessageBox(g_titulo, '$$HEX1$$bf00$$ENDHEX$$Desea grabar los cambios?', Question!,YesNo!) = 1 then
//		idw_fases_promotores.Update()
//	else
//		return
//	end if
//end if
//if idw_fases_colegiados.ModifiedCount() + idw_fases_colegiados.DeletedCount() > 0 then
//	if MessageBox(g_titulo, '$$HEX1$$bf00$$ENDHEX$$Desea grabar los cambios?', Question!,YesNo!) = 1 then
//		idw_fases_colegiados.Update()
//	else
//		return
//	end if
//end if
//if idw_fases_documentos.ModifiedCount() + idw_fases_documentos.DeletedCount() > 0 then
//	if MessageBox(g_titulo, '$$HEX1$$bf00$$ENDHEX$$Desea grabar los cambios?', Question!,YesNo!) = 1 then
//		idw_fases_documentos.Update()
//	else
//		return
//	end if
//end if
//if idw_fases_reparos.ModifiedCount() + idw_fases_reparos.DeletedCount() > 0 then
//	if MessageBox(g_titulo, '$$HEX1$$bf00$$ENDHEX$$Desea grabar los cambios?', Question!,YesNo!) = 1 then
//		idw_fases_reparos.Update()
//	else
//		return
//	end if
//end if
//if idw_fases_informes.ModifiedCount() + idw_fases_informes.DeletedCount() > 0 then
//	if MessageBox(g_titulo, '$$HEX1$$bf00$$ENDHEX$$Desea grabar los cambios?', Question!,YesNo!) = 1 then
//		idw_fases_informes.Update()
//	else
//		return
//	end if
//end if
//if idw_fases_estadistica.ModifiedCount() + idw_fases_estadistica.DeletedCount() > 0 then
//	if MessageBox(g_titulo, '$$HEX1$$bf00$$ENDHEX$$Desea grabar los cambios?', Question!,YesNo!) = 1 then
//		idw_fases_estadistica.Update()
//	else
//		return
//	end if
//end if
//*************************************
// Fin comentado Paco 26/08/2005
//*************************************
if row > 0 then
	g_fase_visared.opcion_importacion  = 'N'
	id_fase=idw_fases_otras_fases.getitemstring(row,'id_fase')
	g_fases_consulta.id_fase=id_fase
	dw_1.event csd_retrieve()
end if

end event

event retrieveend;call super::retrieveend;this.resetupdate()
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'FASES_OTRAS_FASES'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

this.of_setrowselect(true)
end event

type tabpage_7 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79741120
string text = "Hist$$HEX1$$f300$$ENDHEX$$ricos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_fases_modificacion_datos dw_fases_modificacion_datos
end type

on tabpage_7.create
this.dw_fases_modificacion_datos=create dw_fases_modificacion_datos
this.Control[]={this.dw_fases_modificacion_datos}
end on

on tabpage_7.destroy
destroy(this.dw_fases_modificacion_datos)
end on

type dw_fases_modificacion_datos from u_dw within tabpage_7
integer x = 9
integer y = 28
integer width = 3369
integer height = 644
integer taborder = 11
string dataobject = "d_historico"
end type

event pfc_addrow;call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.rowcount(), 'id_modificacion', f_siguiente_numero('MODIFICACIONES', 10))
this.setitem(this.rowcount(), 'id_colegiado', dw_1.GetItemString(1,'id_fase') )

this.setitem(this.rowcount(), 'tipo_modulo', '03')
//donde "n" es un entero que indica la longitud en caracteres del contador
return ancestorreturnvalue
end event

event pfc_insertrow;call super::pfc_insertrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.rowcount(), 'id_modificacion', f_siguiente_numero('MODIFICACIONES', 10))
this.setitem(this.rowcount(), 'id_colegiado', dw_1.GetItemString(1,'id_fase') )
this.setitem(this.rowcount(), 'tipo_modulo', '03')
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

type tabpage_11 from userobject within tab_1
string tag = "texto=fases.reg_es"
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "Registros E/S"
long tabtextcolor = 8388608
long tabbackcolor = 79416533
string picturename = "Custom039!"
long picturemaskcolor = 12632256
cb_anyadir cb_anyadir
dw_fases_registros dw_fases_registros
end type

on tabpage_11.create
this.cb_anyadir=create cb_anyadir
this.dw_fases_registros=create dw_fases_registros
this.Control[]={this.cb_anyadir,&
this.dw_fases_registros}
end on

on tabpage_11.destroy
destroy(this.cb_anyadir)
destroy(this.dw_fases_registros)
end on

type cb_anyadir from commandbutton within tabpage_11
integer x = 32
integer y = 696
integer width = 375
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "A$$HEX1$$f100$$ENDHEX$$adir Registro"
end type

event clicked;reg_es_datos_fase=true

opensheet(g_detalle_registros, 'w_registros_detalle', g_detalle_fases, 0, original!)
end event

type dw_fases_registros from u_dw within tabpage_11
event csd_oculta_tab ( )
event csd_nombre_pestanyas ( string nombre )
integer x = 18
integer y = 20
integer width = 4315
integer height = 656
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_fases_registros_es"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_oculta_tab;int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event csd_nombre_pestanyas;parent.text=nombre
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'FASES_REGISTROS'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

this.of_setrowselect(true)
end event

event doubleclicked;call super::doubleclicked;if row < 1 then return

g_dw_lista_facturacion_emitida = this
g_registros_consulta.id_registro = this.getitemstring(row,'id_registro')
message.stringparm = "w_registros_detalle"
w_aplic_frame.event csd_registrosdetalle()

end event

type tabpage_15 from userobject within tab_1
string tag = "menu.finales_obra"
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "Finales de Obra"
long tabtextcolor = 8388608
long tabbackcolor = 79416533
string picturename = "Custom038!"
long picturemaskcolor = 12632256
dw_finales_obra dw_finales_obra
end type

on tabpage_15.create
this.dw_finales_obra=create dw_finales_obra
this.Control[]={this.dw_finales_obra}
end on

on tabpage_15.destroy
destroy(this.dw_finales_obra)
end on

type dw_finales_obra from u_dw within tabpage_15
event csd_buscar_total ( )
event csd_rellena_final_obra ( integer fila )
event csd_oculta_tab ( )
event csd_nombre_pestanyas ( string nombre )
event csd_descripcion ( )
event csd_enlaza ( )
event csd_retirar ( )
event csd_mostrar_acciones ( )
integer x = 18
integer y = 20
integer width = 4315
integer height = 784
integer taborder = 11
string dataobject = "d_fases_finales_obra"
boolean hscrollbar = true
end type

event csd_buscar_total();int i
boolean encontrado
datetime nulo
setnull(nulo)

encontrado=false
this.accepttext()
for i=1 to this.rowcount()
	if this.getitemstring(i,'total_parcial')='T' or this.getitemstring(i,'total_parcial')='V' then
		encontrado=true
		if(g_colegio <> 'COAATTGN' and g_colegio <> 'COAATTEB' and g_colegio <> 'COAATMCA' AND g_colegio<>'COAATLL') then
			idw_fases_datos_exp.setitem(1,'cerrado','S')
		end if
		// No debe machacar la fecha si ya la hubiera
		datetime f_cierre
		f_cierre = idw_fases_datos_exp.getitemdatetime(1,'f_cierre')
		if isnull(f_cierre) then idw_fases_datos_exp.setitem(1,'f_cierre',this.getitemdatetime(i,'fecha'))
		setpointer(hourglass!)
		st_control_eventos c_evento
		c_evento.evento = 'FINAL_OBRA_TOTAL'
		c_evento.dw = this
		if f_control_eventos(c_evento)=-1 then return
	end if
next
//if encontrado=false then
//	idw_fases_datos_exp.setitem(1,'cerrado','N')
//	idw_fases_datos_exp.setitem(1,'f_cierre', nulo)		
//end if
end event

event csd_rellena_final_obra(integer fila);double sup_viv_res = 0, sup_garage_res = 0, sup_otros_res = 0, num_viv_res = 0, num_edif_res = 0, presupuesto_res = 0
int i
double sup_viv_exp = 0, sup_garage_exp = 0, sup_otros_exp = 0, num_viv_exp = 0, num_edif_exp = 0, presupuesto_exp = 0

setitem(GetRow(),'id_fases_final',f_siguiente_numero('FINALES_OBRA',10))

for i = 1 to rowcount()
	if i = fila then continue
	sup_viv_res += getitemnumber(i, 'sup_viv') 
	sup_garage_res += getitemnumber(i, 'sup_garage')
	sup_otros_res += getitemnumber(i, 'sup_otros')
	num_viv_res += getitemnumber(i, 'num_viv')
	num_edif_res += getitemnumber(i, 'num_edif')
	presupuesto_res += getitemnumber(i, 'presupuesto')
next
if isnull(sup_viv_res) then sup_viv_res = 0
if isnull(sup_garage_res) then sup_garage_res = 0	
if isnull(sup_otros_res) then sup_otros_res = 0		
if isnull(num_viv_res) then num_viv_res = 0			
if isnull(num_edif_res) then num_edif_res = 0		
if isnull(presupuesto_res) then presupuesto_res = 0		

sup_viv_exp = idw_fases_estadistica.getitemnumber(1,'sup_viv')
sup_garage_exp = idw_fases_estadistica.getitemnumber(1,'sup_garage')
sup_otros_exp = idw_fases_estadistica.getitemnumber(1,'sup_otros')
num_viv_exp = idw_fases_estadistica.getitemnumber(1,'num_viv')
num_edif_exp = idw_fases_estadistica.getitemnumber(1,'num_edif')
presupuesto_exp = idw_fases_estadistica.getitemnumber(1,'pem')

if isnull(sup_viv_exp) then sup_viv_exp = 0
if isnull(sup_garage_exp) then sup_garage_exp = 0	
if isnull(sup_otros_exp) then sup_otros_exp = 0		
if isnull(num_viv_exp) then num_viv_exp = 0			
if isnull(num_edif_exp) then num_edif_exp = 0		
if isnull(presupuesto_exp) then presupuesto_exp = 0		


//setitem(GetRow(),'fecha',datetime(today()))
setitem(GetRow(),'f_intro',datetime(today()))
setitem(GetRow(),'sup_viv', max(sup_viv_exp - sup_viv_res, 0))
setitem(GetRow(),'sup_garage', max(sup_garage_exp - sup_garage_res, 0))
setitem(GetRow(),'sup_otros',max(sup_otros_exp - sup_otros_res, 0))
setitem(GetRow(),'num_viv',max(num_viv_exp  - num_viv_res, 0))
setitem(GetRow(),'num_edif',max(num_edif_exp  - num_edif_res, 0))
//setitem(GetRow(),'total_parcial',)
setitem(GetRow(),'presupuesto',max(presupuesto_exp - presupuesto_res, 0))

end event

event csd_oculta_tab;int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event csd_nombre_pestanyas;parent.text=nombre
end event

event csd_descripcion();this.setitem(getrow(), 'descripcion', dw_1.getitemstring(1, 'descripcion'))
end event

event csd_enlaza();f_enlaza_dw(dw_1,dw_finales_obra,'id_fase','id_fase')
this.Retrieve(dw_1.GetItemString(1,'id_fase'))
this.visible = true

end event

event csd_retirar();// ********** Comprobar si han pagado todos los gastos ************

string id_fase
double dv_total=0, cip_total=0, dv_cobrado=0, cip_cobrado=0, musaat_cobrado=0
double dv_pend=0, cip_pend=0, musaat_pend=0, musaat_total=0

id_fase = dw_1.getitemstring(1, 'id_fase')
	
//DV
dv_total = f_dv_contrato_dw(idw_fases_informes)
dv_cobrado = f_total_cobrado_dv_contrato(id_fase)
dv_pend = dv_total - dv_cobrado

//CIP
cip_total = f_cip_contrato_dw(idw_fases_informes)
cip_cobrado = f_total_cobrado_cip_contrato(id_fase)
cip_pend = cip_total - cip_cobrado

//MUSAAT
musaat_total = f_musaat_contrato_dw(idw_fases_informes)
musaat_cobrado = f_total_cobrado_musaat_contrato(id_fase)
musaat_pend = musaat_total - musaat_cobrado
	
if dv_pend > 0 or cip_pend > 0 or musaat_pend > 0 then 
	messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_abonado_gastos_con','No se han abonado todos los gastos del contrato'), exclamation!)
end if

end event

event csd_mostrar_acciones();// Evento lanzado por el control de eventos al seleccionar el tab de finales de obra
// Lo que debemos mostrar es una pop-up donde le pasaremos los valores del tipo de obra y del destino
st_finales_acciones finales_acciones
long n_reg

// Cogemos los valores de los campos tipo trabajo y trabajo. En el caso de ser vacio mostrar$$HEX2$$e1002000$$ENDHEX$$un %
finales_acciones.tipo_trabajo = f_consulta(dw_1, 'fase') 
finales_acciones.trabajo = f_consulta(dw_1, 'tipo_trabajo')

// De momento no permitimos abrir la ventana si no han indicado un tipo de trabajo y trabajo, pero quiz$$HEX2$$e1002000$$ENDHEX$$en el futuro 
// pueda cambiar esto
if finales_acciones.tipo_trabajo = '%' or finales_acciones.trabajo = '%' then 
	Messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_tipo_actuacion_tipo_obra',"Debe indicar primero el tipo de actuaci$$HEX1$$f300$$ENDHEX$$n y el tipo de obra para poder informar de las acciones a realizar"), exclamation!)
	return
end if
SELECT count(*) into :n_reg  
FROM fases_finales_acciones_realiza  
WHERE ( tipo_trabajo like :finales_acciones.tipo_trabajo or tipo_trabajo = '%' ) AND
		( trabajo like :finales_acciones.trabajo or trabajo = '%' )    ;

if n_reg>0 then
	// si no est$$HEX2$$e1002000$$ENDHEX$$abierta la llamamos
	open(w_fases_mostrar_finales_acciones)
	// Llamamos al evento que carga los valroes
	w_fases_mostrar_finales_acciones.post event  csd_cargar_valores(finales_acciones)
	// Para que ponga en las observaciones las acciones del final de obra	
	if g_colegio = 'COAATGUI' then
		string descripcion, observ
		
		SELECT descripcion into :descripcion
		FROM fases_finales_acciones_realiza  
		WHERE ( tipo_trabajo like :finales_acciones.tipo_trabajo or tipo_trabajo = '%' ) AND
				( trabajo like :finales_acciones.trabajo or trabajo = '%' )    ;
		
		observ = dw_1.getitemstring(1, 'observaciones')
		if isnull(observ) then observ = ''
		if PosA(observ, descripcion) = 0 then dw_1.setitem(1, 'observaciones',  + observ + ' ' + descripcion)
	end if	
end if

end event

event pfc_addrow;call super::pfc_addrow;string tipo_act
this.trigger event csd_rellena_final_obra(ancestorReturnValue)

int i
for i=1 to idw_fases_colegiados.rowcount()
	st_control_eventos c_evento
	c_evento.evento = 'INSERTAR_FINAL'
	c_evento.dw = this
	c_evento.id_colegiado = idw_fases_colegiados.getitemstring(i, 'id_col')
	if f_control_eventos(c_evento)=-1 then return -1
next
if(g_colegio = 'COAATTGN' or g_colegio = 'COAATTEB' OR g_colegio='COAATLL')then
	tipo_act = dw_1.getitemstring(1,'fase')
	if((Mid(tipo_act,1,1) = '1')) then
		if(this.getitemstring(getrow(),'total_parcial') = 'T' OR this.getitemstring(getrow(),'total_parcial') = 'V')then
			dw_1.setitem(1,'estado', '62')
		end if
	end if
	if((Mid(tipo_act,1,1) = '3')) then
		if(this.getitemstring(getrow(),'total_parcial') = 'T' OR this.getitemstring(getrow(),'total_parcial') = 'V')then
			dw_1.setitem(1,'estado', '66')
		end if
	end if
end if

return ancestorReturnValue
end event

event type long pfc_insertrow();call super::pfc_insertrow;this.trigger event csd_rellena_final_obra(ancestorreturnvalue)

int i
for i=1 to idw_fases_colegiados.rowcount()
	st_control_eventos c_evento
	c_evento.evento = 'INSERTAR_FINAL'
	c_evento.dw = this
	c_evento.id_colegiado = idw_fases_colegiados.getitemstring(i, 'id_col')
	if f_control_eventos(c_evento)=-1 then return -1
next

return ancestorReturnValue
end event

event constructor;call super::constructor;// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

st_control_eventos c_evento

c_evento.evento = 'FASES_FINALES'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return	
	

if this.object.web_t.visible<>'1' then
	this.object.t_2.x = integer(this.object.t_2.x) - 123
	this.object.num_final.x = integer(this.object.num_final.x) - 132
	this.object.b_2.x =integer( this.object.b_2.x)- 123
	this.object.b_extendidos.x = integer(this.object.b_extendidos.x)-123
end if

// ESte bot$$HEX1$$f300$$ENDHEX$$n es visible para la rioja
if g_colegio = 'COAATLR' then
	this.object.b_extendidos.visible = true
end if

end event

event itemchanged;call super::itemchanged;string tipo_act
// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, Upper(Parent.text), dwo.name, row)

choose case dwo.name
	case 'total_parcial', 'fecha'
		this.postevent ("csd_buscar_total")
	case 'presupuesto'
		// COAATGUI: Se avisa de que hay que regularizar si el presupuesto final supera
		// en un 30% el presupuesto inicial.
		if g_colegio = 'COAATGUI' then
			double pres_ant, pres_nue
			this.accepttext()
			pres_ant = idw_fases_estadistica.getitemnumber(1, 'pem')
			pres_nue = this.getitemnumber(this.rowcount(), 'pem_total')
			if pres_nue > (pres_ant + (pres_ant * 0.2)) then
				// Llamamos al control de eventos evento 'FASES_TAB'
				st_control_eventos c_evento
				c_evento.evento = 'FASES_TAB'
				c_evento.dw = idw_fases_finales_obra
				if f_control_eventos(c_evento)=-1 then return
			end if
		end if
end choose
this.accepttext( )
if g_colegio = 'COAATMCA' then 
	if this.getitemstring(getrow(),'total_parcial') = 'T' then
			dw_1.setitem(1,'estado', '07')
		end if
end if
if g_colegio = 'COAATTGN' OR g_colegio='COAATLL' then
	tipo_act = dw_1.getitemstring(1,'fase')
	if((Mid(tipo_act,1,1) = '1')) then
		if(this.getitemstring(getrow(),'total_parcial') = 'T' OR this.getitemstring(getrow(),'total_parcial') = 'V')then
			dw_1.setitem(1,'estado', '62')
		end if
	end if
	if((Mid(tipo_act,1,1) = '3')) then
		if(this.getitemstring(getrow(),'total_parcial') = 'T' OR this.getitemstring(getrow(),'total_parcial') = 'V')then
			dw_1.setitem(1,'estado', '66')
		end if
	end if
end if

end event

event buttonclicked;call super::buttonclicked;string cod
                
choose case dwo.name
	case 'b_2'
		this.accepttext()
		if f_es_vacio(this.getitemstring(row,'num_final')) then
				this.setitem(row, 'num_final', f_siguiente_numero('NUM_FINALES_OBRA',10))
		end if
	CASE 'b_extendidos'
		// obligamos a que la linea est$$HEX2$$e9002000$$ENDHEX$$grabada en la bbdd
		string id_fases_final
		long n_reg
		id_fases_final = this.getitemString(row, 'id_fases_final')
		SELECT count(*) into :n_reg from fases_finales where id_fases_final = :id_fases_final;
						  
		if n_reg <1 then
			MessageBox(g_titulo, g_idioma.of_getmsg('fases.msg_datos_extendidos_fin_obra',"No puede definirse los datos extendidos del final de obra si no se graba con antelaci$$HEX1$$f300$$ENDHEX$$n la l$$HEX1$$ed00$$ENDHEX$$nea del final de obra correspondiente"), exclamation!) 
			return
		end if
		openwithparm(w_fases_finales_obra_extendidos, id_fases_final) 
end choose

end event

event pfc_preinsertrow;call super::pfc_preinsertrow;st_control_doc lst_control_doc


if ((g_colegio='COAATTGN' or g_colegio = 'COAATTEB' or g_colegio='COAATLL' ) and dw_1.GetItemString(dw_1.GetRow(),'nr_duplicado')='N')then
	if dw_1.GetItemString(dw_1.GetRow(),'tipo_trabajo')='11' then
		lst_control_doc.modulo='CFO_OBRA_NUEVA'	
	else
		lst_control_doc.modulo='CFO'
	end if
	openWithParm(w_control_documentacion_tg,lst_control_doc)
	lst_control_doc=Message.PowerObjectParm
	if not(IsValid(lst_control_doc)) then return PREVENT_ACTION
	if lst_control_doc.no_cte<>'N' and lst_control_doc.no_cte<>'S' then return PREVENT_ACTION
	
end if





end event

event itemerror;call super::itemerror;//return 3
end event

type tabpage_16 from userobject within tab_1
string tag = "texto=menu.arquitectos"
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "Arquitectos"
long tabtextcolor = 8388608
long tabbackcolor = 79416533
string picturename = "Custom041!"
long picturemaskcolor = 12632256
dw_arquitectos dw_arquitectos
end type

on tabpage_16.create
this.dw_arquitectos=create dw_arquitectos
this.Control[]={this.dw_arquitectos}
end on

on tabpage_16.destroy
destroy(this.dw_arquitectos)
end on

type dw_arquitectos from u_dw within tabpage_16
event csd_oculta_tab ( )
event csd_nombre_pestanyas ( string nombre )
event csd_enlaza ( )
integer x = 18
integer y = 20
integer width = 4315
integer height = 784
integer taborder = 11
string dataobject = "d_fases_arquitectos"
end type

event csd_oculta_tab;int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event csd_nombre_pestanyas;parent.text=nombre
end event

event csd_enlaza();f_enlaza_dw(dw_1,dw_arquitectos,'id_fase','id_fase')
this.Retrieve(dw_1.GetItemString(1,'id_fase'))
this.visible = true

end event

event buttonclicked;call super::buttonclicked;string id
choose case dwo.name
	case 'b_buscar'
		open(w_busqueda_arquitectos)
		id = message.stringparm
		if not f_es_vacio(id) then
			this.setitem(row, 'id_arqui', id)
			this.setitem(row, 'nombre', f_arquitectos_nombre(id))
			this.setitem(row, 'apellidos', f_arquitectos_apellidos(id))
		end if
end choose

end event

event pfc_addrow;call super::pfc_addrow;setitem(GetRow(),'ID_FASES_ARQUITECTOS',f_siguiente_numero('ID_FASES_ARQUITECTOS',10))

return ancestorReturnValue
end event

event pfc_insertrow;call super::pfc_insertrow;setitem(GetRow(),'ID_FASES_ARQUITECTOS',f_siguiente_numero('ID_FASES_ARQUITECTOS',10))

return ancestorReturnValue
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'FASES_ARQUITECTOS'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, Upper(Parent.text), dwo.name, row)
end event

type tabpage_17 from userobject within tab_1
string tag = "texto=menu.garantia"
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "Garant$$HEX1$$ed00$$ENDHEX$$as"
long tabtextcolor = 8388608
long tabbackcolor = 79416533
string picturename = "Compute5!"
long picturemaskcolor = 12632256
dw_garantias dw_garantias
end type

on tabpage_17.create
this.dw_garantias=create dw_garantias
this.Control[]={this.dw_garantias}
end on

on tabpage_17.destroy
destroy(this.dw_garantias)
end on

type dw_garantias from u_dw within tabpage_17
event csd_garantias_pendientes ( )
event csd_oculta_tab ( )
event csd_nombre_pestanyas ( string nombre )
event csd_comprueba_colegiados ( )
event csd_comprueba_clientes ( )
event csd_enlaza ( )
integer x = 18
integer y = 20
integer width = 4315
integer height = 784
integer taborder = 11
string dataobject = "d_fases_garantias"
end type

event csd_garantias_pendientes();int i
int garantias_pendientes = 0
string coletilla
if this.rowcount() <= 0 then return

for i = 1 to this.rowcount()
	if isnull(this.getitemdatetime(i, 'f_out')) then garantias_pendientes ++
next
if garantias_pendientes = 1 then 
	coletilla = ' garant$$HEX1$$ed00$$ENDHEX$$a pendiente'
else
	coletilla = ' garant$$HEX1$$ed00$$ENDHEX$$as pendientes'	
end if

if garantias_pendientes > 0 then
	messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_contrato_tiene','Este contrato tiene ') + string(garantias_pendientes) + coletilla)
end if
end event

event csd_oculta_tab;int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event csd_nombre_pestanyas;parent.text=nombre
end event

event csd_comprueba_colegiados();int cuantos
string id_fase, id_colegiado

id_fase=dw_1.getitemstring(1,'id_fase')
id_colegiado=this.getitemstring(this.getrow(),'id_colegiado')


select count(*) into :cuantos from fases_colegiados where id_fase=:id_fase and id_col=:id_colegiado;
if isnull(cuantos) or cuantos=0 then
	Messagebox(g_titulo,g_idioma.of_getmsg('fases.col_pertenece_contrato','Este colegiado no pertenece a este contrato.'))
end if

end event

event csd_comprueba_clientes();int cuantos
string id_fase, id_cliente

id_fase=dw_1.getitemstring(1,'id_fase')
id_cliente=this.getitemstring(this.getrow(),'id_cliente')


select count(*) into :cuantos from fases_clientes where id_fase=:id_fase and id_cliente=:id_cliente;
if isnull(cuantos) or cuantos=0 then
	Messagebox(g_titulo,g_idioma.of_getmsg('fases.col_pertenece_contrato','Este cliente no pertenece a este contrato.'))
end if
end event

event csd_enlaza();f_enlaza_dw(dw_1,dw_garantias,'id_fase','id_fase')
this.Retrieve(dw_1.GetItemString(1,'id_fase'))
this.visible = true

end event

event buttonclicked;string id_persona, id_colegiado, nif_cli
CHOOSE CASE dwo.name
	CASE 'b_cli'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
		g_busqueda.dw="d_lista_busqueda_clientes"		
		//id_persona=f_busqueda_clientes(this.getitemstring(row, 'clientes_nif'))
		id_persona=f_busqueda_clientes('')
		nif_cli = f_dame_nif(id_persona)
		if not(f_es_vacio(id_persona)) then
			if not(f_es_vacio(id_persona)) then
				this.setitem(row,'id_cliente',id_persona)
				this.triggerevent ('csd_comprueba_clientes')
			end if
		end if
		
	CASE 'b_col'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		
		id_colegiado=f_busqueda_colegiados()
		if f_es_vacio(id_colegiado) then return
		this.setitem(row,'id_colegiado',id_colegiado)
		this.triggerevent ('csd_comprueba_colegiados')
		
END CHOOSE


end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

st_control_eventos c_evento

c_evento.evento = 'FASES_GARANTIA'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

//this.GetChild('id_col',i_dwc_colegiados_garantias)
//this.GetChild('id_cliente',i_dwc_clientes_garantias)
//i_dwc_colegiados_garantias.settransobject(sqlca)
//i_dwc_colegiados_garantias.InsertRow (0)
//i_dwc_clientes_garantias.settransobject(sqlca)
//i_dwc_clientes_garantias.InsertRow (0)
end event

event pfc_addrow;call super::pfc_addrow;// Si no hay filas en el desplegable condicional colocamos una
IF i_dwc_colegiados_garantias.RowCount()<1 THEN i_dwc_colegiados_garantias.InsertRow(0)
IF i_dwc_clientes_garantias.RowCount()<1 THEN i_dwc_clientes_garantias.InsertRow(0)

return 1
end event

event pfc_insertrow;call super::pfc_insertrow;// Si no hay filas en el desplegable condicional colocamos una
IF i_dwc_colegiados_garantias.RowCount()<1 THEN i_dwc_colegiados_garantias.InsertRow(0)
IF i_dwc_clientes_garantias.RowCount()<1 THEN i_dwc_clientes_garantias.InsertRow(0)
return 1
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;// Si no hay filas en el desplegable condicional colocamos una
IF i_dwc_colegiados_garantias.RowCount()<1 THEN i_dwc_colegiados_garantias.InsertRow(0)
IF i_dwc_clientes_garantias.RowCount()<1 THEN i_dwc_clientes_garantias.InsertRow(0)

return 1

end event

event retrieveend;call super::retrieveend;If i_dwc_colegiados_garantias.Retrieve(dw_1.GetItemString(1,'id_fase'))<1 THEN i_dwc_colegiados_garantias.insertrow(0)
If i_dwc_clientes_garantias.Retrieve(dw_1.GetItemString(1,'id_fase'))<1 THEN i_dwc_clientes_garantias.insertrow(0)
end event

event clicked;//string id_fase
//id_fase = dw_1.getitemstring(1,'id_fase')
//choose case dwo.name
//	case 'id_col'
//		f_verificar_colegiados_no_grabados(id_fase,idw_fases_colegiados,i_dwc_colegiados_garantias)
//	case 'id_cliente'
//		f_verifica_clientes_no_grabados(id_fase,idw_fases_promotores,i_dwc_clientes_garantias)		
//	case else
//end choose
end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, Upper(Parent.text), dwo.name, row)
end event

type tabpage_10 from userobject within tab_1
string tag = "texto=general.notas"
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "Notas"
long tabtextcolor = 8388608
long tabbackcolor = 79416533
string picturename = "Report5!"
long picturemaskcolor = 12632256
dw_incidencias dw_incidencias
end type

on tabpage_10.create
this.dw_incidencias=create dw_incidencias
this.Control[]={this.dw_incidencias}
end on

on tabpage_10.destroy
destroy(this.dw_incidencias)
end on

type dw_incidencias from u_dw within tabpage_10
event csd_enlaza ( )
integer x = 18
integer y = 20
integer width = 4315
integer height = 784
integer taborder = 11
string dataobject = "d_fases_incidencias"
end type

event csd_enlaza();//2/7/2008 Modificacion introducida por Javi Medina
f_enlaza_dw(dw_1,dw_incidencias,'id_fase','id_fase')
this.Retrieve(dw_1.GetItemString(1,'id_fase'))
this.visible = true
end event

event constructor;call super::constructor;
// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event pfc_addrow;call super::pfc_addrow;//Aqui insertaremos el id de incidenci y el de fase cuando a$$HEX1$$f100$$ENDHEX$$adamos una nueva fila
long num_fila

num_fila = this.getrow( )
this.setitem(num_fila,"id_fase",dw_1.getitemstring(1,"id_fase"))
this.setitem(num_fila,'id_incidencias',f_siguiente_numero('INCIDENCIAS-EXP', 10))
this.setitem(num_fila,'usuario',g_usuario)
this.setitem(num_fila,'fecha',date(today()))

return num_fila
end event

event pfc_insertrow;call super::pfc_insertrow;//Aqui insertaremos el id de incidenci y el de fase cuando a$$HEX1$$f100$$ENDHEX$$adamos una nueva fila
long num_fila

num_fila = this.getrow( )
this.setitem(num_fila,"id_fase",dw_1.getitemstring(1,"id_fase"))
this.setitem(num_fila,'id_incidencias',f_siguiente_numero('INCIDENCIAS-EXP', 10))
this.setitem(num_fila,'usuario',g_usuario)
this.setitem(num_fila,'fecha',date(today()))

return num_fila
end event

type tabpage_18 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 208
integer width = 4357
integer height = 804
long backcolor = 79416533
string text = "Pagos Plataforma"
long tabtextcolor = 33554432
long tabbackcolor = 79416533
string picturename = "Custom048!"
long picturemaskcolor = 536870912
cb_anyadir_factura_concilio cb_anyadir_factura_concilio
dw_fases_pagos_facturas dw_fases_pagos_facturas
dw_fases_pagos_plataforma dw_fases_pagos_plataforma
end type

on tabpage_18.create
this.cb_anyadir_factura_concilio=create cb_anyadir_factura_concilio
this.dw_fases_pagos_facturas=create dw_fases_pagos_facturas
this.dw_fases_pagos_plataforma=create dw_fases_pagos_plataforma
this.Control[]={this.cb_anyadir_factura_concilio,&
this.dw_fases_pagos_facturas,&
this.dw_fases_pagos_plataforma}
end on

on tabpage_18.destroy
destroy(this.cb_anyadir_factura_concilio)
destroy(this.dw_fases_pagos_facturas)
destroy(this.dw_fases_pagos_plataforma)
end on

type cb_anyadir_factura_concilio from commandbutton within tabpage_18
string tag = "text=fases.afegir_factura"
integer x = 2953
integer y = 24
integer width = 375
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "A$$HEX1$$f100$$ENDHEX$$adir Factura"
end type

event clicked;idw_fases_pagos_plataforma.accepttext( )

if idw_fases_pagos_plataforma.rowcount() < 1 then
	messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_falta_datos_pagos','No hay registrados pagos para poder conciliar facturas.'), stopsign!)
	return -1
end if 	



int row
st_busqueda_facturas lst_busqueda_facturas
string ls_n_colegiado

g_facturas_n_colegiado = idw_fases_pagos_plataforma.getitemstring(idw_fases_pagos_plataforma.getrow(), 'n_colegiado')

g_busqueda.dw= "d_busqueda_facturas_lista"
open(w_busqueda_facturas)

setnull(g_facturas_n_colegiado)
lst_busqueda_facturas = message.powerobjectparm

if isValid (lst_busqueda_facturas) then
	row = idw_fases_pagos_facturas.triggerevent('pfc_addrow')

	idw_fases_pagos_facturas.setitem( row, 'id_factura', lst_busqueda_facturas.id_factura )
	idw_fases_pagos_facturas.setitem( row, 'n_fact', lst_busqueda_facturas.n_fact )
	idw_fases_pagos_facturas.setitem( row, 'total', lst_busqueda_facturas.total )
	
	if  (idw_fases_pagos_plataforma.getitemnumber(idw_fases_pagos_plataforma.getrow(), 'importe_pago') = lst_busqueda_facturas.total) then 
		idw_fases_pagos_plataforma.setitem(idw_fases_pagos_plataforma.getrow(),'conciliado', 'S')
	end if
end if



end event

type dw_fases_pagos_facturas from u_dw within tabpage_18
event csd_enlaza ( )
event aa_row_focus_parent_changed ( )
integer x = 2953
integer y = 136
integer width = 1385
integer height = 668
integer taborder = 10
string dataobject = "d_fases_pagos_facturas"
boolean ib_rmbmenu = false
end type

event aa_row_focus_parent_changed();if idw_fases_pagos_plataforma.getrow() <= 0 then return

this.visible = false

this.retrieve(idw_fases_pagos_plataforma.getitemdecimal(idw_fases_pagos_plataforma.getrow(), 'id_fases_pagos_plataforma'))

this.visible = true

end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'FASES_PAGO_PLATAFORM'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return


// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)


end event

event pfc_addrow;call super::pfc_addrow;// Si no hay filas en el desplegable condicional colocamos una

IF idw_fases_pagos_plataforma.RowCount()>0 THEN idw_fases_pagos_facturas.InsertRow(0)

this.setitem(ancestorreturnvalue, 'id_fases_pagos_plataforma', idw_fases_pagos_plataforma.getitemnumber(idw_fases_pagos_plataforma.getrow(), 'id_fases_pagos_plataforma'))
this.setitem(ancestorreturnvalue, 'n_col', idw_fases_pagos_plataforma.getitemstring(idw_fases_pagos_plataforma.getrow(), 'n_colegiado'))

return ancestorreturnvalue
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = false
am_dw.m_table.m_delete.enabled = false
end event

event buttonclicked;call super::buttonclicked;CHOOSE CASE dwo.name
	CASE 'b_eliminar'
		this.setrow(row)
		this.postevent("pfc_deleterow")
END CHOOSE		
end event

type dw_fases_pagos_plataforma from u_dw within tabpage_18
event csd_enlaza ( )
event unselectfields ( integer currentrow )
event recalcula_total ( )
event csd_oculta_tab ( )
integer x = 9
integer y = 20
integer width = 2917
integer height = 784
integer taborder = 10
string dataobject = "d_fases_pagos_plataforma"
boolean ib_rmbmenu = false
end type

event csd_enlaza();f_enlaza_dw(dw_1,dw_fases_pagos_plataforma,'id_fase','id_fase')
this.Retrieve(dw_1.GetItemString(1,'id_fase'))
this.visible = true
end event

event unselectfields(integer currentrow);//int i
//
//for i =1 to this.rowcount()
//	if i = currentRow then 
//		this.setitem( i, 'seleccionado', 'S')
//		
//	else 	
//		this.setitem( i, 'seleccionado', 'N')		
//	end if	
//next	
end event

event recalcula_total();double base_imponible,  total_iva
long row

row = message.longparm

base_imponible = this.getitemnumber( row, 'base_imponible')

total_iva = f_aplica_t_iva(base_imponible, this.getitemstring( row, 't_iva') )

this.setitem( row, 'importe_iva', total_iva )
this.setitem( row, 'importe_pago', total_iva + base_imponible)

end event

event csd_oculta_tab();int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'FASES_PAGO_PLATAFORM'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return


// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)


end event

event rowfocuschanged;call super::rowfocuschanged;
tab_1.tabpage_18.dw_fases_pagos_facturas.post event aa_row_focus_parent_changed()


end event

event buttonclicked;call super::buttonclicked;openwithparm(w_fases_pagos_tpv, idw_fases_pagos_plataforma.getitemdecimal(row, 'id_fases_pagos_plataforma')) 
end event

event rowfocuschanging;call super::rowfocuschanging;if idw_fases_pagos_facturas.event pfc_updatespending() = 1  then
	if messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_datos_pagos','Los datos de las facturas conciliadas han cambiado, $$HEX1$$bf00$$ENDHEX$$Desea guardarlos?'), Question!, YesNo!) = 1 then
		this.update()
		idw_fases_pagos_facturas.update()
	end if
end if
end event

event pfc_predeleterow;call super::pfc_predeleterow;int i

for i = idw_fases_pagos_facturas.rowcount() to 1 step -1
		idw_fases_pagos_facturas.deleterow(i)
next
	idw_fases_pagos_facturas.update()								
	
return 1
end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'base_imponible', 't_iva'
		this.postevent("recalcula_total", 0, row)
	case 'importe_iva'
		this.accepttext()
		this.setitem( row, 'importe_pago', this.getitemnumber( row, 'base_imponible') + double(data) )
end choose
end event

type dw_fases_botones from u_dw within w_fases_detalle
event csd_incidencias ( )
event csd_imprimir ( )
event csd_historico ( )
event csd_facturacion ( )
event csd_devolver ( )
event csd_avisos_detalle ( )
event csd_hoja_ayto ( )
event csd_recibi_sin_gestion ( )
event csd_info_economica ( )
event csd_ultimo_numero_minuta ( )
event csd_regularizacion ( )
event csd_visared ( )
event csd_prov_fondos ( )
event csd_liquidaciones ( )
event csd_antecedentes ( )
event csd_facturar_docs ( )
event csd_avisos_detalle_gc ( )
event csd_carta_rioja ( )
event csd_incidencias_fases ( )
event csd_renuncia ( )
event csd_imprimir_expedientes ( )
event csd_info_economica_tfe ( )
event csd_carta_colegiado ( )
event csd_carta_propiedad ( )
event csd_reclamaciones ( )
event csd_etiqueta ( )
event csd_honorarios_obra ( )
event csd_netfocus ( )
event csd_renuncias_lista ( )
event csd_desglose_dip ( )
event csd_etiquetas_visado ( )
event csd_retirada_documentacion ( )
event csd_retorn_arres ( )
event csd_insp_ayto ( )
event csd_actualizar_frontend ( )
event csd_hoja_csys ( )
event csd_plantillas ( )
boolean visible = false
integer x = 2245
integer y = 432
integer width = 421
integer height = 36
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_fases_botones"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = styleraised!
boolean ib_isupdateable = false
end type

event csd_incidencias();g_incidencias.id=dw_1.getitemstring(1,'id_expedi')
open(w_incidencias_exp)

dw_1.event csd_configura_color_opciones()
end event

event csd_imprimir();int retorno
retorno = Event closequery()
if retorno = 1 then return

datastore ds_fase_impr
ds_fase_impr = create datastore		
// Modificado Ricardo 04-07-08
CHOOSE CASE g_colegio
	CASE 'COAATTFE'
		ds_fase_impr.dataobject = 'd_fases_impresion_detalle_tfe'
	CASE 'COAATA'
		ds_fase_impr.dataobject = 'd_fases_impresion_detalle_al'		
	CASE 'COAATMCA'
     		ds_fase_impr.dataobject = 'd_fases_impresion_detalle_mca'

	CASE ELSE
		ds_fase_impr.dataobject = 'd_fases_impresion_detalle'
END CHOOSE
// Modificado Ricardo 04-07-08
ds_fase_impr.settransobject(sqlca)		
ds_fase_impr.retrieve(dw_1.GetItemString(1,'id_fase'))
ds_fase_impr.Print()
destroy ds_fase_impr

end event

event csd_historico();openwithparm(w_historico, dw_1.getitemstring(1,'id_fase')+"03")
end event

event csd_facturacion();string id_fase

id_fase=dw_1.GetItemString(1,'id_fase')

g_facturacion_emitida_consulta.id_factura = ''

OpenWithParm(w_fases_lista_emisiones,id_fase)

//g_dw_lista_facturacion_emitida = 'd_factufa_lista_emisiones'
if not f_es_vacio(g_facturacion_emitida_consulta.id_factura) then
	message.stringparm = "w_facturacion_emitida_detalle"
	w_aplic_frame.post event csd_facturacion_emitida_detalle()
end if	


end event

event csd_devolver();string ret

open(w_minutas_devolucion)

ret = message.stringparm
if ret <> 'CANCELAR' then
	st_control_eventos c_evento
	c_evento.evento = 'DEVOLVER'
	c_evento.dw = dw_1
	if f_control_eventos(c_evento)=-1 then return
	
//	dw_1.event csd_cambio_estado()

	this.TriggerEvent('csd_control_estados')
end if

	

end event

event csd_avisos_detalle;string id_expedi 
id_expedi = dw_fases_datos_exp.getitemstring(1, 'id_expedi')

OPenWithParm(w_avisos_pendientes, id_expedi)
end event

event csd_hoja_ayto();string tipo_carta
integer retorno


retorno = parent.event closequery()
if retorno = 1 then return

tipo_carta = ''

if g_colegio = 'COAATTFE' then
	tipo_carta = 'ALCALDE'
end if	


f_rellenar_hoja_ayto(dw_1.getitemString(1, 'id_fase'), tipo_carta, 1)

end event

event csd_recibi_sin_gestion();string n_colegiado, nombre_colegiado
datastore ds_recibi_sin_gestion

if g_colegio <> 'COAATCU' then
	messagebox(g_titulo, g_idioma.of_getmsg('fases.col_pagar_directamente_gastos','El colegiado desea pagar directamente los gastos, Saldr$$HEX2$$e1002000$$ENDHEX$$un impreso que debe firmar'))
		
	ds_recibi_sin_gestion = CREATE DATASTORE
	ds_recibi_sin_gestion.DATAOBJECT = 'dw_recibi_singestion'
	
	ds_recibi_sin_gestion.insertrow(0)
	ds_recibi_sin_gestion.setitem(1, 'descripcion', dw_1.getitemstring(1, 'descripcion'))
	ds_recibi_sin_gestion.setitem(1, 'cliente', f_fases_promotores_fase(dw_1.getitemstring(1, 'id_fase')))
	ds_recibi_sin_gestion.setitem(1, 'emplazamiento', dw_1.getitemstring(1, 'emplazamiento'))
	ds_recibi_sin_gestion.setitem(1, 'n_contrato', dw_1.getitemstring(1, 'n_registro'))
	
	ds_recibi_sin_gestion.print()
	
	destroy ds_recibi_sin_gestion
else
	open(w_recibi_singestion_colegiado_cu)
	
	if message.stringparm = 'CANCELAR' then //si no devuelve el colegiado no imprimimos
		return
	else //hemos seleccionado un colegiado
		ds_recibi_sin_gestion = CREATE DATASTORE
		ds_recibi_sin_gestion.DATAOBJECT = 'dw_recibi_singestion_cu'
		
		n_colegiado = message.stringparm //cogemos el n$$HEX2$$ba002000$$ENDHEX$$de colegiado
		nombre_colegiado = f_colegiado_apellido(n_colegiado) //y su nombre
		
		ds_recibi_sin_gestion.insertrow(0)
		ds_recibi_sin_gestion.setitem(1, 'descripcion', dw_1.getitemstring(1, 'descripcion'))
		ds_recibi_sin_gestion.setitem(1, 'cliente', f_fases_promotores_fase(dw_1.getitemstring(1, 'id_fase')))
		ds_recibi_sin_gestion.setitem(1, 'emplazamiento', dw_1.getitemstring(1, 'emplazamiento'))
		ds_recibi_sin_gestion.setitem(1, 'n_contrato', dw_1.getitemstring(1, 'n_registro'))
		ds_recibi_sin_gestion.setitem(1, 'n_expedi', dw_1.getitemstring(1, 'n_expedi'))
		ds_recibi_sin_gestion.setitem(1, 'n_colegiado', n_colegiado)
		ds_recibi_sin_gestion.setitem(1, 'colegiado', nombre_colegiado)
		
		ds_recibi_sin_gestion.print()
	
		destroy ds_recibi_sin_gestion
	end if
end if

end event

event csd_info_economica();if idw_fases_colegiados.getrow() <= 0 then return

openwithparm(w_descuentos_colegiado, g_detalle_fases, g_detalle_fases)

//idw_fases_colegiados.triggerevent('csd_ver_descuentos')

end event

event csd_ultimo_numero_minuta;open(w_fases_ultimo_numero_minuta)
end event

event csd_regularizacion();integer retorno
string ret

retorno = event closequery()
if retorno = 1 then return

// Modificado David - 17/02/2005
// No importa si el expediente esta cerrado
//if idw_fases_datos_exp.GetItemString(idw_fases_datos_exp.GetRow(),'cerrado')='S' then
	// Modificardo Ricardo 31-10-03
	// Si no tiene descuentos no se puede regularizar porque no tiene sentido
	IF (idw_fases_informes.RowCount() = 0 and g_colegio <> 'COAATMCA')then
		messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_exp_dtos_regul',"El expediente no tiene descuentos por lo que no tiene sentido la regularizaci$$HEX1$$f300$$ENDHEX$$n"))
	else
		openwithparm(w_contratos_regularizacion, dw_1.getitemstring(1, 'id_expedi'))
		ret = message.stringparm
		if ret <> 'CANCELAR' then
			st_control_eventos c_evento
			c_evento.evento = 'REGULARIZAR'
			c_evento.dw = dw_1
			if f_control_eventos(c_evento)=-1 then return
		
//			dw_1.event csd_cambio_estado()
	
			this.TriggerEvent('csd_control_estados')
		end if
	end if
	// FIN Modificardo Ricardo 31-10-03
//else
//	messagebox(g_titulo, "El expediente no est$$HEX2$$e1002000$$ENDHEX$$cerrado")
//end if
dw_1.event csd_configura_color_opciones()
end event

event csd_visared();string id_fase
int retorno

if event closequery() = 1 then return

id_fase = dw_1.GetItemString(1,'id_fase')
OpenSheetWithParm(g_firmador,id_fase,"w_sellador",w_aplic_frame,0,original!)

end event

event csd_prov_fondos;openwithparm(w_provision_fondos, dw_1.getitemstring(1, 'id_fase'))


end event

event csd_liquidaciones();st_w_fases_liquidaciones datos

datos.id_fase=dw_1.getitemstring(1, 'id_fase')
datos.id_expedi=dw_1.getitemstring(1, 'id_expedi')
openwithparm(w_fases_liquidaciones, datos)

end event

event csd_antecedentes();string id_expedi

id_expedi = dw_fases_datos_exp.getitemstring(1, 'id_expedi')
openwithparm(w_fases_expedientes_relacionados, id_expedi)

dw_1.event csd_configura_color_opciones()

// Modificado Ricardo 04-06-11
// Pedido por tenerife al hacer un dobleclick en un expediente hay que ir a $$HEX1$$e900$$ENDHEX$$l.No se puede hacer desde aquella 
// ventana por ser una response (al cerrarse devuelve el control a esta ventana)
string id_expedi_devuelto
id_expedi_devuelto = message.stringparm
if not f_es_vacio(id_expedi_devuelto) then
	//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
	SetPointer(HourGlass!)
	g_expedientes_consulta.id_expediente = id_expedi_devuelto
	message.stringparm = "w_expedientes_detalle"
	w_aplic_frame.postevent("csd_expedientesdetalle")
end if
// FIN Modificado Ricardo 04-06-11

end event

event csd_facturar_docs();openwithparm(w_facturar_documentos, dw_1.getitemstring(1, 'id_fase'))
//A$$HEX1$$f100$$ENDHEX$$adido Jesus 29/12/2009 CGC-137
if (g_colegio = 'COAATGC') then
	tab_1.tabpage_3.dw_fases_documentos.event csd_documentos_retirados()
end if

end event

event csd_avisos_detalle_gc();string id_expedi 
id_expedi = dw_fases_datos_exp.getitemstring(1, 'id_expedi')

OPenWithParm(w_avisos_pendientes_gc, id_expedi)
end event

event csd_carta_rioja();string id_cliente, sl_total_clientes, id_col, id_fases_col, id_fase
int i, j, k
double importe
datastore ds_cols_soc

datastore ds_imprime_hoja
ds_imprime_hoja = create datastore
ds_imprime_hoja.dataobject = 'd_carta_visado_lr'		
ds_imprime_hoja.settransobject(sqlca)
ds_imprime_hoja.insertrow(0)

// Clientes
for i = 1 to idw_fases_promotores.rowcount()
	id_cliente = idw_fases_promotores.getitemstring(i,"id_cliente")
	if i = 1 then
		sl_total_clientes = f_dame_cliente ( id_cliente )
	else
		sl_total_clientes = sl_total_clientes + "~n~r" + f_dame_cliente ( id_cliente )
	end if
next

id_fase = dw_1.getitemstring(1, 'id_fase')
ds_imprime_hoja.setitem(1,"cliente",sl_total_clientes) 
//ds_imprime_hoja.setitem(1,"n_expedi",dw_fases_datos_exp.getitemstring(1,"n_expedi") )
ds_imprime_hoja.setitem(1,"n_expedi", 'EXP: ' + f_dame_exp(id_fase) + ' - Contrato: ' + f_dame_n_reg(id_fase))
ds_imprime_hoja.setitem(1,"descripcion",dw_1.getitemstring(1,"descripcion"))
ds_imprime_hoja.setitem(1,"emplazamiento",f_dame_direccion_contrato(id_fase))
ds_imprime_hoja.setitem(1,"cliente",f_fases_clientes_fase(id_fase))
ds_imprime_hoja.setitem(1,"tipo_gestion",dw_1.getitemstring(1,"tipo_gestion"))

// Se imprime una carta por colegiado
for i = 1 to idw_fases_colegiados.rowcount()
	id_col = idw_fases_colegiados.getitemstring(i,"id_col")
	id_fases_col = idw_fases_colegiados.getitemstring(i, 'id_fases_colegiados')
	if f_colegiado_tipopersona(id_col) <> 'S' then
		ds_imprime_hoja.setitem(1,"id_col",  id_col)
		// Importe
		for k = 1 to idw_fases_minutas.rowcount()
			if idw_fases_minutas.getitemstring(k, 'pendiente') = 'S' and idw_fases_minutas.getitemstring(k, 'id_colegiado') = id_col then
				importe = idw_fases_minutas.getitemnumber(k, 'total_a_pagar')
			end if
		next
		ds_imprime_hoja.setitem(1,"importe",importe)
		ds_imprime_hoja.print()
	else
		ds_cols_soc = create datastore
		ds_cols_soc.dataobject = 'ds_fases_colegiados_asociados'
		ds_cols_soc.settransobject(sqlca)
		ds_cols_soc.retrieve(id_fases_col)
		
		for j = 1 to ds_cols_soc.rowcount()
			ds_imprime_hoja.setitem(1,"id_col",  ds_cols_soc.getitemstring(j, 'id_col_per'))
			ds_imprime_hoja.print()
		next
		destroy ds_cols_soc
	end if
next

destroy ds_imprime_hoja

end event

event csd_incidencias_fases();// evento para lanzar las incidencias de un contrato
g_incidencias.id=dw_1.getitemstring(1,'id_fase')
open(w_incidencias_fases)
dw_1.event csd_configura_color_opciones()

end event

event csd_renuncia();string sl_total_colegiados, sl_total_autores, nom_aut, id_fase, id_colegiado
string id_col, nucol, ls_nombre, nombre_colegiado, st_tipo_obra, colegiado
string id_fases_col, ls_col_soc, sl_total_clientes, obser, sl_des_tipo_obra
string sl_tipo_obra, sl_uso_obra, sl_des_uso_obra, sl_tipo_act, sl_des_tipo_act 
string sl_num_contrato, sl_f_visado, t_via, nom_via, numero, cp, pobla, des_via
string empl, bloque, esc, planta, puerta, sl_parrafo, ls_fecha, ejemplar
double viviendas, dl_sup_vivienda, dl_sub_garajes, dl_sup_otros
datetime f_fecha, f_visado, ldtt_hoy, f_entrada
date ldt_hoy
integer result, cuantos, i,j 
string dia_hora
st_renuncias_impresion st_datos
datastore ds_imprime_hoja

ds_imprime_hoja = create datastore
n_csd_impresion_formato impresion_formato

id_fase= dw_1.GetItemString(dw_1.GetRow(),'id_fase')

// Ponemos por defecto las opciones de impresi$$HEX1$$f300$$ENDHEX$$n de documentos
// En este caso para la impresi$$HEX1$$f300$$ENDHEX$$n individual cuando se abre la ventana

impresion_formato = create n_csd_impresion_formato
//Datos de copias en papel
impresion_formato.papel = g_formato_impresion.papel
impresion_formato.copias 					= 1
impresion_formato.impresora_pag_desde 	= 1
impresion_formato.impresora_intervalo 	= 'T'
impresion_formato.impresora_intercalar 	= false

//Datos de copias en email
impresion_formato.email = g_formato_impresion.email	
impresion_formato.asunto_email = 'Renuncia Exp. '+dw_fases_datos_exp.GetItemString(dw_fases_datos_exp.GetRow(),'n_expedi')
impresion_formato.texto_email 	= ''
impresion_formato.direccion_email 	= ''
//impresion_formato.direccion_email = f_devuelve_mail(i_id_col)

//Datos de copias en pdf
impresion_formato.visualizar_web 		= 'N'
impresion_formato.pdf = g_formato_impresion.pdf
impresion_formato.pdf_previsualizar 	= false	//No se muestra una previsualizaci$$HEX1$$f300$$ENDHEX$$n del pdf

//General
impresion_formato.destino 			= 'C'
impresion_formato.referencia 		= id_fase
impresion_formato.avisos 			= 0 		
impresion_formato.modo_creacion	= 2		//Avisamos si ya existe
impresion_formato.masivo = false
//	impresion_formato.id_receptor=i_id_col
//impresion_formato.generar_registro=g_formato_impresion.generar_registro
impresion_formato.generar_registro='S'
impresion_formato.tipo_receptor='C'
impresion_formato.serie='RENUNCIA'
//impresion_formato.ruta_relativa 		= g_ejercicio+'\'+idw_resumen.GetItemString(1,'n_colegiado')  // Ya no sirve
impresion_formato.ruta_automatica=true

dia_hora=string(datetime(today(),now()),'YYYYMMDD_HHMMSS')
f_entrada=dw_1.GetItemDateTime(dw_1.GetRow(),'f_entrada')	
impresion_formato.ruta_base	  = g_directorio_documentos_visared
impresion_formato.ruta_relativa1=''
impresion_formato.ruta_relativa2=string(year(date(f_entrada)))
impresion_formato.ruta_relativa3=dw_1.GetItemString(dw_1.GetRow(),'n_registro')
impresion_formato.ruta_relativa4='renuncias'
impresion_formato.nombre = 'RENUNCIA_'+dia_hora


choose case g_colegio
	case 'COAATGU','COAATLE','COAATTEB','COAATGC','COAATLL'
		openwithparm(w_renuncias_impresos, this)
		return
	case 'COAATMCA'
		openwithparm(w_renuncias_impresos_mca, id_fase)
		return		
	case 'COAATCC'

		st_datos.id_fase=id_fase
		st_datos.fecha=datetime(today())
		st_datos.f_renuncia=datetime(today())	
//		result = messagebox('Renuncia', g_idioma.of_getmsg('fases.imp_renuncia','$$HEX1$$bf00$$ENDHEX$$Desea imprimir la renuncia?'), Question!, OKCancel!)
//		IF result = 1 THEN //ok
		
			if impresion_formato.f_opciones_impresion()>0 then	
				
				// COLEGIADOS
				st_datos.tipo_destinatario='C'
				ds_imprime_hoja.dataobject = 'd_carta_renuncia_colegiado_cc'

				for i=1 to idw_fases_colegiados.rowcount()
					ds_imprime_hoja.reset()
					ds_imprime_hoja.insertrow(0)
					st_datos.ds_renuncia=ds_imprime_hoja		
					
					st_datos.id_colegiado=idw_fases_colegiados.GetItemSTring(i,'id_col')			
					st_datos.destinatario=st_datos.id_colegiado
					f_rellenar_renuncia(st_datos)
					impresion_formato.dw=ds_imprime_hoja
					impresion_formato.tipo_receptor='C'
					impresion_formato.nombre='RENUNCIA_COLEGIADO_'+idw_fases_colegiados.GetItemString(i,'n_col')+'_'+dia_hora
					impresion_formato.asunto_registro='CARTA RENUNCIA COLEGIADO'
					impresion_formato.id_receptor= st_datos.destinatario
					impresion_formato.expediente = dw_1.GetItemString(dw_1.GetRow(),'n_registro')
					impresion_formato.n_expedi = id_fase
					impresion_formato.f_impresion()		
					// PROMOTORES
					st_datos.tipo_destinatario='P'
					ds_imprime_hoja.dataobject = 'd_carta_renuncia_promotor_cc'
	
					for j=1 to idw_fases_promotores.rowcount()
						ds_imprime_hoja.reset()
						ds_imprime_hoja.insertrow(0)
						st_datos.ds_renuncia=ds_imprime_hoja		
	
						st_datos.destinatario=idw_fases_promotores.GetItemSTring(j,'id_cliente')				
						f_rellenar_renuncia(st_datos)
						impresion_formato.dw=ds_imprime_hoja
						impresion_formato.tipo_receptor='T'
						impresion_formato.nombre='RENUNCIA_CLIENTE_'+idw_fases_promotores.GetItemString(j,'nif')+'_'+dia_hora
						impresion_formato.asunto_registro='CARTA RENUNCIA CLIENTE'
						impresion_formato.id_receptor= st_datos.destinatario
						impresion_formato.expediente = dw_1.GetItemString(dw_1.GetRow(),'n_registro')
						impresion_formato.n_expedi= id_fase
						impresion_formato.f_impresion()					
					next
					
					// AYUNTAMIENTO
					st_datos.tipo_destinatario='A'
					ds_imprime_hoja.dataobject = 'd_carta_renuncia_ayuntamiento_cc'
	
					ds_imprime_hoja.reset()
					ds_imprime_hoja.insertrow(0)
					st_datos.ds_renuncia=ds_imprime_hoja		
	
					st_datos.destinatario=''		
					f_rellenar_renuncia(st_datos)
					impresion_formato.dw=ds_imprime_hoja
					impresion_formato.tipo_receptor='O'
					impresion_formato.nombre='RENUNCIA_AYTO_'+dia_hora
					impresion_formato.asunto_registro='CARTA RENUNCIA AYUNTAMIENTO'
					impresion_formato.receptor= st_datos.destinatario
					impresion_formato.expediente = dw_1.GetItemString(dw_1.GetRow(),'n_registro')
					impresion_formato.n_expedi= id_fase
					impresion_formato.f_impresion()					
					
					// CESLA
					st_datos.tipo_destinatario='CESLA'
					ds_imprime_hoja.dataobject = 'd_carta_renuncia_cesla_cc'
	
					ds_imprime_hoja.reset()
					ds_imprime_hoja.insertrow(0)
					st_datos.ds_renuncia=ds_imprime_hoja		
	
					st_datos.destinatario=''		
					f_rellenar_renuncia(st_datos)
					impresion_formato.dw=ds_imprime_hoja
					impresion_formato.tipo_receptor='O'
					impresion_formato.nombre='RENUNCIA_CESLA_'+dia_hora
					impresion_formato.asunto_registro='CARTA RENUNCIA CESLA'
					impresion_formato.receptor= st_datos.destinatario
					impresion_formato.expediente = dw_1.GetItemString(dw_1.GetRow(),'n_registro')
					impresion_formato.n_expedi= id_fase
					impresion_formato.f_impresion()							
				next
						
			end if
//		END IF
		return
end choose


choose case g_colegio
	case 'COAATTFE'
		ds_imprime_hoja.dataobject = 'dw_alcalde_renuncia_tfe'
		
		//Modificado JESUS 19/11/09
		//Coger de la variable global 
		string pie_de_pagina
		SELECT texto INTO :pie_de_pagina
		FROM var_globales
		WHERE nombre='g_direccion_poblacion_cartas';
		
		ds_imprime_hoja.settransobject(sqlca)
		ds_imprime_hoja.insertrow(0)
		ds_imprime_hoja.SetItem(1,'pie_pagina_t',pie_de_pagina)
		
	case else		
		ds_imprime_hoja.dataobject = 'dw_alcalde_renuncia_cu'
		
		ds_imprime_hoja.settransobject(sqlca)
		ds_imprime_hoja.insertrow(0)
end choose


// obtener los colegiados ----------------------------------------------------------------
cuantos = idw_fases_colegiados.rowcount()
for i=1 to cuantos
	id_col = idw_fases_colegiados.getitemstring(i,"id_col")
	nucol = idw_fases_colegiados.getitemstring(i,"n_col")
	ls_nombre = f_colegiado_apellido( id_col )

	nombre_colegiado = nucol + ' ' + ls_nombre
	if not isNull(nombre_colegiado) then
		nombre_colegiado = nombre_colegiado + space(50 - LenA(nombre_colegiado))
		if LenA(nombre_colegiado) > 50 then nombre_colegiado = MidA(nombre_colegiado,1,50)
	else
		nombre_colegiado = space(50)
	end if	   
	colegiado = nombre_colegiado 
	
	if i = 1 then  // Mejorar
			sl_total_colegiados = colegiado
			sl_total_autores = nom_aut
		else
			if g_colegio = 'COAATGUI' then 
				sl_total_colegiados = sl_total_colegiados + cr + cr + colegiado
			else
				sl_total_colegiados = sl_total_colegiados + "~n~r" + colegiado
			end if
			sl_total_autores = sl_total_autores + nom_aut
		end if
next

for i = 1 to cuantos
	id_col = idw_fases_colegiados.getitemstring(i,"id_col")
	nucol = idw_fases_colegiados.getitemstring(i,"n_col")
	ls_nombre = f_colegiado_apellido( id_col )
	id_fases_col = idw_fases_colegiados.getitemstring(i, 'id_fases_colegiados')
	if LeftA(nucol, 1) = 'S' then 
//		id_col = idw_fases_colegiados_asociados.getitemstring(i,"id_col_aso")
//		nucol = f_colegiado_n_col (id_col)
//		ds_imprime_hoja.setitem(1,"sociedad", ls_nombre + ' :')
		int cols
		
		datastore ds_cols_soc
		ds_cols_soc = create datastore
		ds_cols_soc.dataobject = 'ds_fases_colegiados_asociados'
		ds_cols_soc.settransobject(sqlca)
		ds_cols_soc.retrieve(id_fases_col)
		
		for cols = 1 to ds_cols_soc.rowcount()
			id_col = ds_cols_soc.getitemstring(cols,"id_col_per")
			ls_col_soc += 'D./D$$HEX1$$aa00$$ENDHEX$$.  ' + f_colegiado_apellido( id_col ) + '   ( ' + ls_nombre + ' ) ' + cr
		next
		ds_imprime_hoja.setitem(1,"colegiados_soc", ls_col_soc)
		destroy ds_cols_soc
	end if
next


// obtener los clientes ----------------------------------------------------------------	   
cuantos = idw_fases_promotores.rowcount()
for i = 1 to cuantos
	string id_cliente
	id_cliente = idw_fases_promotores.getitemstring(i,"id_cliente")
	nucol = idw_fases_promotores.getitemstring(i,"nif")
   //	nif = idw_fases_clientes.getitemstring(i,"nifrep")
	ls_nombre = f_dame_cliente ( id_cliente )
	nombre_colegiado = nucol + ' ' + ls_nombre
	if not isNull(nombre_colegiado) then
		nombre_colegiado = nombre_colegiado + space(70 - LenA(nombre_colegiado))
		if LenA(nombre_colegiado) > 35 then nombre_colegiado = MidA(nombre_colegiado,1,70)
	else
		nombre_colegiado = space(50)
	end if	   
	colegiado = nombre_colegiado
	if i = 1 then
		sl_total_clientes = colegiado
	else
		sl_total_clientes = sl_total_clientes + "~n~r" + colegiado
	end if
next

// tipos  ------------------------------------------------------------------------
obser = dw_1.getitemstring(1, 'descripcion')
if isnull(obser) then obser=''

st_tipo_obra = dw_1.getitemstring(1,"tipo_trabajo")
sl_des_tipo_obra = f_dame_desc_tipo_obra(st_tipo_obra)
if isnull(sl_des_tipo_obra) then sl_des_tipo_obra=''

sl_uso_obra = dw_1.getitemstring(1,"trabajo")
sl_des_uso_obra = f_dame_desc_destino_obra(sl_uso_obra)
if isnull(sl_des_uso_obra) then sl_des_uso_obra=''

sl_tipo_act = dw_1.getitemstring(1,"fase")
sl_des_tipo_act = f_dame_desc_tipo_actuacion(sl_tipo_act)
if isnull(sl_des_tipo_act) then sl_des_tipo_act=''

// numero de viviendas	----------------------------------------------------------------
viviendas = idw_fases_estadistica.getitemnumber(1,"num_viv")
if isnull(viviendas) then viviendas=0


// superficie de viviendas -------------------------------------------------------------
dl_sup_vivienda = idw_fases_estadistica.getitemnumber(1,"sup_viv")
if isnull(dl_sup_vivienda) then dl_sup_vivienda=0


// superficie otras viviendas ----------------------------------------------------------
dl_sup_otros = idw_fases_estadistica.getitemnumber(1,"sup_otros")
if isnull(dl_sup_otros) then dl_sup_otros=0


// superficie de garages ---------------------------------------------------------------
dl_sub_garajes = idw_fases_estadistica.getitemnumber(1,"sup_garage")
if isnull(dl_sub_garajes) then dl_sub_garajes=0


// numero de contrato ------------------------------------------------------------------
sl_num_contrato = dw_fases_datos_exp.getitemstring(1,"n_expedi") 
sl_des_uso_obra = dw_1.getitemstring(1,"n_registro")
if isnull(sl_num_contrato) then sl_num_contrato=''


// fecha de visado ----------------------------------------------------------------
f_visado = dw_1.getitemdatetime(1,"f_visado")
sl_f_visado=string( f_visado,"dd/mm/yyyy")
if isnull(sl_f_visado) then sl_f_visado=''


// emplazamiento   ----------------------------------------------------------------
t_via = dw_1.getitemstring(1,"tipo_via_emplazamiento")
nom_via = dw_1.getitemstring(1,"emplazamiento")
numero = dw_1.getitemstring(1,"n_calle")
cp = dw_1.getitemstring(1,"poblacion")
pobla = f_poblacion_descripcion(cp)
des_via = f_dame_desc_tipo_via(t_via)

if isnull(des_via) then des_via = " "
if isnull(nom_via) then nom_via = " "
if isnull(numero) then numero = " "
if isnull(bloque) then bloque = " "
if isnull(esc) then esc = " " 
if isnull(planta) then planta = " "
if isnull(puerta) then puerta = " "
if isnull(cp) then cp = " "
if isnull(pobla) then pobla = " "

empl = trim(des_via) + " " + trim(nom_via) + " " + trim(numero) + " " + trim(bloque) + " " + trim(esc) &
+ " " + trim(planta) + " " + trim(puerta) + " " + trim(pobla)

ldtt_hoy =datetime(today(),now())
ldt_hoy  = today()
ls_fecha = Upper( g_col_ciudad + ', ' + string(day(ldt_hoy)) + ' de ' + lower(f_obtener_mes (ldtt_hoy)) + ' de ' + string(year(ldt_hoy)))

sl_parrafo=''


//asignacion de campos -----------------------------------------------------------------
ds_imprime_hoja.setitem(1,"colegiado",sl_total_colegiados)
ds_imprime_hoja.setitem(1,"cliente",sl_total_clientes)
ds_imprime_hoja.setitem(1,"tipo_obra",sl_des_tipo_obra)
ds_imprime_hoja.setitem(1,"uso_obra",sl_des_uso_obra)
ds_imprime_hoja.setitem(1,"tipo_actuacion",sl_des_tipo_act)
ds_imprime_hoja.setitem(1,"num_viviendas",string(viviendas,'#,##0'))
ds_imprime_hoja.setitem(1,"sup_vivienda",string(dl_sup_vivienda,'#,##0.00'))
ds_imprime_hoja.setitem(1,"otros_usos", string(dl_sup_otros,'#,##0.00'))
ds_imprime_hoja.setitem(1,"sub_garajes",string(dl_sub_garajes,'#,##0.00'))
ds_imprime_hoja.setitem(1,"n_contrato",sl_num_contrato)
ds_imprime_hoja.setitem(1,"fecha_visado",sl_f_visado)
ds_imprime_hoja.setitem(1,"emplazamiento",empl)
ds_imprime_hoja.setitem(1,"descripcion",obser)
ds_imprime_hoja.setitem(1,"alcalde",pobla)
ds_imprime_hoja.setitem(1,"fecha",ls_fecha)
ds_imprime_hoja.setitem(1,"cp",cp)

//impresion de la renuncia, 3 copias
result = messagebox('Renuncia', g_idioma.of_getmsg('fases.imp_renuncia','$$HEX1$$bf00$$ENDHEX$$Desea imprimir la renuncia?'), Question!, OKCancel!)
IF result = 1 THEN //ok

	if impresion_formato.f_opciones_impresion()>0 then	

		impresion_formato.dw=ds_imprime_hoja
		impresion_formato.nombre='RENUNCIA_AYTO_'+dia_hora
		impresion_formato.f_impresion()
		ds_imprime_hoja.object.ejemplar.text='Colegiado'
		impresion_formato.nombre='RENUNCIA_COLEGIADO_'+dia_hora
		impresion_formato.dw=ds_imprime_hoja
		impresion_formato.f_impresion()
		ds_imprime_hoja.object.ejemplar.text='Colegio'
		impresion_formato.nombre='RENUNCIA_COLEGIO_'+dia_hora
		impresion_formato.dw=ds_imprime_hoja
		impresion_formato.f_impresion()

	end if
	

ELSE //cancel

END IF

destroy ds_imprime_hoja

end event

event csd_imprimir_expedientes();st_expediente expediente
double CIP
double musaat_total
string emplazamiento,emplazamiento_acum, iva
string descripcion
int i

emplazamiento = dw_1.getitemstring(1,'tipo_via_emplazamiento')

if not(isnull(emplazamiento)) or emplazamiento <> '' then
	select descripcion into :emplazamiento_acum from tipos_via
	where cod_tipo_via = :emplazamiento;
end if

emplazamiento = dw_1.getitemstring(1,'emplazamiento')
if not(isnull(emplazamiento)) or emplazamiento <> '' then
	emplazamiento_acum = emplazamiento_acum + ' ' + emplazamiento
end if
emplazamiento = dw_1.getitemstring(1,'n_calle')
if not(isnull(emplazamiento)) or emplazamiento <> '' then
	emplazamiento_acum = emplazamiento_acum + ' ' + emplazamiento
end if
emplazamiento = dw_1.getitemstring(1,'poblacion')
if not(isnull(emplazamiento)) or emplazamiento <> '' then
	emplazamiento_acum = emplazamiento_acum + '~r' + emplazamiento
end if
emplazamiento = dw_1.getitemstring(1,'compute_2')
if not(isnull(emplazamiento)) or emplazamiento <> '' then
	emplazamiento_acum = emplazamiento_acum + ' ' + emplazamiento
end if

expediente.id_fase = dw_1.getitemstring(1,'id_fase')

expediente.num_reg = dw_1.getitemstring(1,'n_registro')
expediente.tipo_trabajo = dw_1.getitemstring(1,'tipo_trabajo')
expediente.tipo_actuacion = dw_1.getitemstring(1,'fase')
expediente.trabajo = dw_1.getitemstring(1,'trabajo')
expediente.num_exp = dw_fases_datos_exp.getitemstring(1,'n_expedi')
expediente.descripcion = dw_1.getitemstring(1,'descripcion')
expediente.emplazamiento = emplazamiento_acum
expediente.observaciones = dw_1.getitemstring(1,'observaciones')

// Preparacion de los datos economicos
expediente.honorarios = dw_1.getitemnumber(1,'honorarios')
expediente.cip =  f_cip_contrato_dw(idw_fases_informes)

for i = 1 to idw_fases_informes.rowcount()
	if idw_fases_informes.getitemstring(i, 'tipo_informe') = '05' then
		expediente.iva = f_dame_porcent_iva (  idw_fases_informes.getitemstring(i, 't_iva') )
	end if
	if idw_fases_informes.getitemstring(i, 'tipo_informe') = '12' then
		expediente.musaat_total = idw_fases_informes.getitemnumber(i, 'cuantia_colegiado')
	end if
next

// Preparamos la musaat
if idw_fases_estadistica.rowcount() > 0 then
	expediente.n_visado = dw_1.getitemstring(1, 'id_fase')
	expediente.tipo_act = dw_1.getitemstring(1, 'fase')
	expediente.tipo_obra = dw_1.getitemstring(1, 'tipo_trabajo')
	expediente.pem = idw_fases_estadistica.getitemnumber(1, 'pem')
	expediente.administracion = idw_fases_datos_exp.getitemstring(1, 'administracion')
	expediente.superficie = idw_fases_estadistica.getitemnumber(1, 'superficie')
	expediente.volumen = idw_fases_estadistica.getitemnumber(1, 'volumen')
end if

openwithparm(w_expediente_impresiones,expediente)

end event

event csd_info_economica_tfe();openwithparm(w_descuentos_fase_tfe, dw_1.getitemstring(1,'id_fase'), g_detalle_fases)
end event

event csd_carta_colegiado();// Evento que rellena la carta de comunicaci$$HEX1$$f300$$ENDHEX$$n de inicio de obra al colegiado (Zaragoza)
string sl_cliente, sl_fecha, pobla, sl_colegiado, sl_f_inicio='', id_col, n_col, apell
string nomb, nif, daf, paf, descripcion, id_cliente, t_via, nomvia, numero, des_via, emplazamiento, cp
long i
datetime ldtt_hoy, f_inicio
date ldt_hoy

// Fecha inicio de las obras
f_inicio = idw_fases_datos_exp.getitemdatetime(1,"f_inicio")
sl_f_inicio=string( f_inicio,"dd/mm/yyyy")
if isnull(sl_f_inicio) then sl_f_inicio=''

if sl_f_inicio = '' then
	messagebox(g_titulo, g_idioma.of_getmsg('fases.f_inicio_obra',"No existe fecha de inicio de la obra"), stopsign!)
	return
end if


datastore ds_imprime_hoja
ds_imprime_hoja = create datastore
ds_imprime_hoja.dataobject = 'd_oficio_col_za'
ds_imprime_hoja.settransobject(sqlca)
ds_imprime_hoja.insertrow(0)

// Sacamos una carta para cada colegiado
for i = 1 to idw_fases_colegiados.rowcount()
	if i>1 then ds_imprime_hoja.insertrow(0)
	sl_colegiado = ''
	id_col = idw_fases_colegiados.getitemstring(i,"id_col")

	select n_colegiado,apellidos,nombre,nif,domicilio_activo,poblacion_activa 
	into :n_col, :apell, :nomb, :nif, :daf, :paf
	from colegiados where id_colegiado=:id_col;
		
	if f_es_vacio(nomb) then sl_colegiado = apell + cr else sl_colegiado = nomb + ' ' + apell + cr
	if not f_es_vacio(daf) then sl_colegiado += daf + cr
	if not f_es_vacio(paf) then sl_colegiado += paf
	ds_imprime_hoja.setitem(i,"colegiado",sl_colegiado)
next

// Vamos a coger el primer cliente del contrato por ahora
id_cliente = idw_fases_promotores.getitemstring(1,"id_cliente")
sl_cliente = f_dame_cliente(id_cliente)

// Otros datos del contrato
t_via = dw_1.getitemstring(1,"tipo_via_emplazamiento")
nomvia = dw_1.getitemstring(1,"emplazamiento")
numero = dw_1.getitemstring(1,"n_calle")
cp = dw_1.getitemstring(1,"poblacion")
descripcion = dw_1.getitemstring(1, 'descripcion')
pobla = f_poblacion_descripcion(cp)
des_via = f_dame_desc_tipo_via(t_via)

if isnull(des_via) then des_via = ""
if isnull(nomvia) then nomvia = ""
if isnull(numero) then numero = ""
if isnull(cp) then cp = ""
if isnull(pobla) then pobla = ""
if isnull(descripcion) then descripcion = ""

emplazamiento = trim(des_via) + " " + trim(nomvia) + " " + trim(numero)

// Fecha de hoy
ldtt_hoy =datetime(today(),now())
ldt_hoy  = today()
sl_fecha = g_col_ciudad + ', ' + string(day(ldt_hoy)) + ' de ' + lower(f_obtener_mes (ldtt_hoy)) + ' de ' + string(year(ldt_hoy))

for i=1 to ds_imprime_hoja.rowcount()
	ds_imprime_hoja.setitem(i,"emplazamiento",emplazamiento)  
	ds_imprime_hoja.setitem(i,"descripcion",descripcion)
	ds_imprime_hoja.setitem(i,"fecha",sl_fecha)
	ds_imprime_hoja.setitem(i,"localidad",pobla)
	ds_imprime_hoja.setitem(i,"f_inicio",sl_f_inicio)
	ds_imprime_hoja.setitem(i,"cliente",sl_cliente)
next

ds_imprime_hoja.print()
ds_imprime_hoja.print()

destroy ds_imprime_hoja

end event

event csd_carta_propiedad();// Evento que abre la ventana para la generaci$$HEX1$$f300$$ENDHEX$$n de cartas a la propiedad (Zaragoza)
open(w_carta_propiedad)
end event

event csd_reclamaciones();if g_colegio = 'COAATZ' or g_colegio =  'COAATGU' or g_colegio = 'COAATLE' or g_colegio = 'COAATAVI' or g_colegio='COAATNA' or g_colegio='COAATCC' or g_colegio='COAATTER' then
	opensheet(g_lista_reclamaciones, 'w_fases_reclamaciones_nuevo', w_aplic_frame, 0, original!)
else
	opensheet(g_lista_reclamaciones, 'w_fases_reclamaciones', w_aplic_frame, 0, original!)
end if

end event

event csd_etiqueta();// Evento para reimprimir etiquetas
// Se ha copiado el c$$HEX1$$f300$$ENDHEX$$digo del evento de la ventana de creaci$$HEX1$$f300$$ENDHEX$$n de fases,
// aunque aqu$$HEX2$$ed002000$$ENDHEX$$cogemos los datos de la ventana de detalle
// David 06/10/2005

string sl_impresora_defecto, sl_impresora_tickets_ini

if g_colegio = 'COAATTFE' or g_colegio = 'COAATGU' or g_colegio = 'COAATLE' then
	// Cogemos la impresora del ini
	sl_impresora_tickets_ini = Profilestring(gnv_app.of_GetAppInifile(),"Parametros","ImpresoraTickets","")
	if f_es_vacio(sl_impresora_tickets_ini) then	return
	//Guardamos impresora predeterminada
	sl_impresora_defecto = printgetprinter()
	
	//Cambiamos la impresora por defecto a la de tickets
	PrintSetPrinter(sl_impresora_tickets_ini)
	
	// Imprimimos la etiqueta, con un mensaje entre 2 impresiones para que puedan cortarla
	datastore ds_impresion
	ds_impresion = create datastore
	ds_impresion.dataObject = 'd_resguardo'
	
	if g_colegio = 'COAATGU' then ds_impresion.dataObject = 'd_resguardo_gu'
	if g_colegio = 'COAATLE' then ds_impresion.dataObject = 'd_resguardo_le'
	
	//Com$$HEX1$$fa00$$ENDHEX$$n
	ds_impresion.insertrow(0)
	ds_impresion.setitem(1,'num_exp_1',dw_1.getitemstring(1,'n_registro'))
	ds_impresion.setitem(1,'f_entrada',dw_1.getitemdatetime(1,'f_entrada'))
	ds_impresion.setitem(1,'centro',f_dame_descripcion_delegacion())
	ds_impresion.setitem(1,'id_fase','*'+dw_1.getitemstring(1,'id_fase')+'*')
	
	//S$$HEX1$$f300$$ENDHEX$$lo Guadalajara
	if g_colegio = 'COAATGU' then
		ds_impresion.setitem(1,'n_expedi',idw_fases_datos_exp.getitemstring(1,'n_expedi'))
		ds_impresion.setitem(1,'tipo_intervencion',dw_1.getitemstring(1,'tipo_registro')+"/"+dw_1.getitemstring(1,'fase'))
		ds_impresion.setitem(1,'cliente',idw_fases_promotores.getitemstring(1,'cliente'))

		string colegiados
		int i		
		for i = 1 to idw_fases_colegiados.rowcount()
			colegiados=idw_fases_colegiados.getitemstring(i,'compute_1')+cr
		next

		ds_impresion.setitem(1,'colegiados',colegiados)
	end if
	
	ds_impresion.print()
	MessageBox(g_titulo, g_idioma.of_getmsg('fases.corte_tiquet',"Corte el ticket antes de continuar"))
	ds_impresion.print()
	// Destruimos el datastore para liberar memoria
	destroy ds_impresion
	// Restauramos la impresora por defecto
	PrintSetPrinter(sl_impresora_defecto)
end if

end event

event csd_honorarios_obra();if idw_fases_colegiados.getrow() <= 0 then return

//if isvalid(w_fases_honorarios_resumen) then
//	w_fases_honorarios_resumen.triggerevent('csd_cargar_datos')
//end if

openwithparm(w_fases_honorarios_resumen, g_detalle_fases, g_detalle_fases)


end event

event csd_netfocus();int valor

n_csd_netfocus netfocus
netfocus = create n_csd_netfocus

valor=netfocus.abrir_dvt()
netfocus.cargar_datos(valor, dw_1,dw_fases_datos_exp,idw_fases_promotores,idw_fases_estadistica, idw_fases_colegiados, idw_fases_arquitectos)

end event

event csd_renuncias_lista();st_w_fases_liquidaciones datos

datos.id_fase=dw_1.getitemstring(1, 'id_fase')
datos.id_expedi=dw_1.getitemstring(1, 'id_expedi')
openwithparm(w_fases_renuncias, datos)

end event

event csd_desglose_dip();string id_fase

id_fase=dw_1.GetItemString(dw_1.GetRow(),'id_fase')

if idw_fases_informes.Find("tipo_informe='"+g_codigos_conceptos.cip+"'",1,idw_fases_informes.rowcount()) <1 then 
	MessageBox("Atencion", g_idioma.of_getmsg('fases.fase_dip',"La fase no tiene DIP"))
	return
end if
openWithParm(w_desglose_dip,id_fase)

end event

event csd_etiquetas_visado();string id_fase

id_fase=dw_1.GetItemString(dw_1.GetRow(),'id_fase')

openWithParm(w_etiquetas_visado_tg,id_fase)
end event

event csd_retirada_documentacion();//retirada documentacion
string expediente
expediente = dw_1.getitemstring(1,'id_expedi')
openwithparm(w_retirada_documentacion, expediente)
end event

event csd_retorn_arres();string id_fase, descripcion, poblacion, cliente, colegiado, direccion, fecha, lugar_fecha, id_cliente
string texto_ayto, dest_ayto1, texto_prop, dom_prop, pob_prop, dest_trab1, texto_trab, dest_trab2, t_act
string dest_trab3, dest_ayto2, dest_ayto3, cod_pob, col_dom, col_pob, n_visado, encargo, ape_arq, nom_arq
string arquitecto, parrafo2, n_col, domicilio_activo, poblacion_activa, texto_arres

int i

datastore ds_impresion
ds_impresion = create datastore
ds_impresion.dataObject = 'd_carta_retorn_arres_teb'
ds_impresion.insertrow(0)

// Recuperamos Datos del detalle de fases
id_fase		= dw_1.GetItemString(1,'id_fase')
descripcion	= dw_1.getItemstring(1,'descripcion')
cod_pob		= dw_1.GetItemString(1,'poblacion')
id_cliente	= idw_fases_promotores.GetItemString(1,'id_cliente')
t_act			= dw_1.GetItemString(1,'fase')

for i = 1 to idw_fases_colegiados.rowcount()
	colegiado = idw_fases_colegiados.GetItemString(i,'id_col')
next

col_dom = f_domicilio_activo(colegiado)
col_pob = f_poblacion_activa(colegiado)
n_col = f_colegiado_n_col(colegiado)
colegiado = f_colegiado_nombre_apellido(colegiado)
cliente = f_dame_cliente(id_cliente)
poblacion = f_poblacion_descripcion(cod_pob)
direccion = f_dame_direccion_contrato(id_fase)
fecha = lower(f_fecha_en_letras(datetime(today()), 'n'))
lugar_fecha = g_col_ciudad + ", " + fecha
dom_prop = f_dame_domicilio(id_cliente)
pob_prop = f_retorna_poblacion(id_cliente)
n_visado = f_fases_n_salida(id_fase)
if isnull(n_visado) then n_visado = ''
if isnull(descripcion) then descripcion = ''


encargo = f_dame_desc_tipo_actuacion(t_act)

// Carta Retorn Arres
texto_arres = "El sotasignat " + colegiado + ", col.legiat n$$HEX1$$fa00$$ENDHEX$$m. "+n_col+" amb domicili professional "+col_dom+", a la localitat de "+col_pob+"."+cr+cr+cr+cr+"EXPOSO:"+cr+cr+"Que donat que ha desaparegut el promotor "+cliente+". De l$$HEX1$$b400$$ENDHEX$$expedient de visat n$$HEX1$$fa00$$ENDHEX$$m. "+n_visado+" consistent en "+descripcion+" situat a "+direccion+"."
if lower(ds_impresion.describe("texto_arres.name"))	= 'texto_arres' 	then ds_impresion.setitem(1, 'texto_arres', texto_arres)
if lower(ds_impresion.describe("lugar_fecha.name"))= 'lugar_fecha'	then ds_impresion.setitem(1, 'lugar_fecha', lugar_fecha)

ds_impresion.print()
end event

event csd_insp_ayto();string id_fase, descripcion, poblacion, cliente, colegiado, direccion, fecha, lugar_fecha, id_cliente
string texto_ayto, dest_ayto1, texto_prop, dom_prop, pob_prop, dest_trab1, texto_trab, dest_trab2, t_act
string dest_trab3, dest_ayto2, dest_ayto3, cod_pob, col_dom, col_pob, n_visado, encargo, ape_arq, nom_arq
string arquitecto, parrafo2, n_col, domicilio_activo, poblacion_activa, texto_arres

//int i

datastore ds_impresion
ds_impresion = create datastore
ds_impresion.dataObject = 'd_insp_ayuntament_teb'
ds_impresion.insertrow(0)

// Recuperamos Datos del detalle de fases
id_fase		= dw_1.GetItemString(1,'id_fase')
descripcion	= dw_1.getItemstring(1,'descripcion')
cod_pob		= dw_1.GetItemString(1,'poblacion')
id_cliente	= idw_fases_promotores.GetItemString(1,'id_cliente')
t_act			= dw_1.GetItemString(1,'fase')

//for i = 1 to idw_fases_colegiados.rowcount()
//	colegiado = idw_fases_colegiados.GetItemString(i,'id_col')
//next

//col_dom = f_domicilio_activo(colegiado)
//col_pob = f_poblacion_activa(colegiado)
//n_col = f_colegiado_n_col(colegiado)
//colegiado = f_colegiado_nombre_apellido(colegiado)
cliente = f_dame_cliente(id_cliente)
poblacion = f_poblacion_descripcion(cod_pob)
direccion = f_dame_direccion_contrato(id_fase)
fecha = lower(f_fecha_en_letras(datetime(today()), 'n'))
lugar_fecha = g_col_ciudad + ", " + fecha
dom_prop = f_dame_domicilio(id_cliente)
pob_prop = f_retorna_poblacion(id_cliente)
n_visado = f_fases_n_salida(id_fase)
if isnull(n_visado) then n_visado = ''
if isnull(descripcion) then descripcion = ''


//encargo = f_dame_desc_tipo_actuacion(t_act)

// Carta Insp. Ayuntamiento
if lower(ds_impresion.describe("cliente.name"))= 'cliente' then ds_impresion.setitem(1, 'cliente', cliente)
if lower(ds_impresion.describe("lugar_fecha.name"))= 'lugar_fecha'	then ds_impresion.setitem(1, 'lugar_fecha', lugar_fecha)
if lower(ds_impresion.describe("descripcion.name"))= 'descripcion' then ds_impresion.setitem(1, 'descripcion', descripcion)
if lower(ds_impresion.describe("direccion.name"))= 'direccion'	then ds_impresion.setitem(1, 'direccion', direccion)
if lower(ds_impresion.describe("poblacion.name"))= 'poblacion'	then ds_impresion.setitem(1, 'poblacion', poblacion)


ds_impresion.print()
end event

event csd_actualizar_frontend();string id_fase
integer res
id_fase = dw_1.GetItemString(dw_1.GetRow(),'id_fase')

res=wf_actualizar_frontend(id_fase)

if res=-100 then
	MessageBox("Error", "La direcci$$HEX1$$f300$$ENDHEX$$n del webservice no est$$HEX2$$e1002000$$ENDHEX$$bien configurada en la BD. (Variable-> g_few_soap_url)")	
elseif res>=0 then
	MessageBox("OK", "Actualizaci$$HEX1$$f300$$ENDHEX$$n de Frontend correcta")	
end if


//Actualizaci$$HEX1$$f300$$ENDHEX$$n de datos en la plataforma
wf_actualizar_datos_plataforma()

end event

event csd_hoja_csys();///*** Impresi$$HEX1$$f300$$ENDHEX$$n de la hoja de coordinaci$$HEX1$$f300$$ENDHEX$$n de seguridad y salud ***///
///***       Inicialmente solicitado por $$HEX1$$c100$$ENDHEX$$vila. CAV-155. SCP-718       ***///
///***                                  Alexis. 25/11/2010                                 ***///


///*** Se uitliza la misma funci$$HEX1$$f300$$ENDHEX$$n que es utilizada para imprimir cartas de ayto. con la salvedad que le ***///
///***  pasamos el tipo de carta HCSYS y en la funci$$HEX1$$f300$$ENDHEX$$n f_rellenar_hoja_ayto se comprobar$$HEX2$$e1002000$$ENDHEX$$el dato. En  ***///
///*** la funci$$HEX1$$f300$$ENDHEX$$n particular de $$HEX1$$c100$$ENDHEX$$vila tambi$$HEX1$$e900$$ENDHEX$$n se ver$$HEX2$$e1002000$$ENDHEX$$afectada para que recoja el datawindow adecuado ***///

f_rellenar_hoja_ayto(dw_1.getitemString(1, 'id_fase'), 'HCSYS', 1)
end event

event csd_plantillas();// **********************************		DECLARACION DE VARIABLES		*************************** 
//int i, j
datastore ds_fase
//double insertadas
string id_fase, codigo, ruta,email, n_col, tipo_persona, circulares_mail
st_retorno_seleccion retorno
n_csd_plantillas uo_plantillas
n_csd_impresion_formato uo_impresion

id_fase = dw_1.GetItemString(1,'id_fase')
uo_impresion= create n_csd_impresion_formato

// **********************************		SELECCIONAMOS LA PLANTILLA 		***************************
//Abrimos la ventana de selecci$$HEX1$$f300$$ENDHEX$$n de plantillas
st_plantillas_seleccion datos_plantillas
datos_plantillas.modulo='FASES'
// Asignamos datos por defecto antes de seleccionar la plantilla, para no tener que estar recalcul$$HEX1$$e100$$ENDHEX$$ndolos por defecto cada vez que se cambie la plantilla seleccionada
IF idw_fases_colegiados.RowCount() > 0 THEN
	datos_plantillas.n_col1= f_colegiado_n_col (idw_fases_colegiados.GetItemString(1,'id_col')  )
END IF
IF idw_fases_promotores.RowCount() > 0 THEN
	datos_plantillas.cif_prom1= f_dame_nif (idw_fases_promotores.GetItemString(1,'id_cliente')  )
END IF

datos_plantillas.mostrar_cbx_editar_plantilla=false
uo_impresion.masivo=false

OpenwithParm(w_plantillas_seleccion,datos_plantillas)
retorno = Message.powerobjectparm
if retorno.ruta = '-1' then return

uo_impresion.nombre = left(retorno.ruta, len(retorno.ruta) - 4) + '_'+string(today(),'yyyymmdd')
uo_impresion.masivo_cambiar_nombre=true
uo_impresion.masivo_cambiar_asunto=true
uo_impresion.papel = 'N'
uo_impresion.pdf = 'S'
uo_impresion.sms = 'X'
uo_impresion.ruta_automatica=false
uo_impresion.destino='F'
uo_impresion.referencia=id_fase
uo_impresion.pdf_previsualizar=true
uo_impresion.visualizar_web='N'
uo_impresion.serie='RS'
uo_impresion.generar_registro='X' 

retorno.ruta = g_directorio_rtf + retorno.ruta

if not fileexists(retorno.ruta) then
	messagebox(g_titulo_aplicacion,g_idioma.of_getmsg('colegiados.plantilla','La plantilla seleccionada no existe'))
	return	
end if

if uo_impresion.f_opciones_impresion()=-1 then return

//Creamos el datastore de Colegiados para las plantillas de colegiados
ds_fase = create datastore
ds_fase.dataobject = 'd_plantillas_fases'

// Creamos el objeto de plantillas y rellenamos sus parametros
uo_plantillas=create n_csd_plantillas
uo_plantillas.ruta_plantilla = retorno.ruta
uo_plantillas.mdb='plantillas.txt'
uo_plantillas.ruta_mdb=g_directorio_rtf+'plantillas.txt'
uo_plantillas.i_impresion = uo_impresion
setpointer(hourglass!)

// ********		RELLENAMOS EL DATASTORE CON LOS DATOS DE LOS COLEGIADOS   ********
	f_fases_rellena_estructura(id_fase,ds_fase,retorno)
	
// **********************************		COMBINAMOS CON WORD			***************************
if ds_fase.rowcount() > 0 then
	uo_plantillas.nombre_plantilla = f_obtiene_nombre_plantilla(retorno.codigo)
	uo_plantillas.is_modulo_asociado = retorno.modulo
	uo_plantillas.is_colegiado = ds_fase.GetItemString(1,'n_col1')
	uo_plantillas.is_codigo = retorno.codigo
	uo_plantillas.f_combinar_plantilla()
else
	messagebox(g_titulo,g_idioma.of_getmsg('colegiados.fallo_captura', "Imposible generar los documentos por un fallo en la captura de datos"))
end if
	
//Destruimos los datastores, el objeto ole y desconectamos.
destroy ds_fase

setpointer(arrow!)
end event

event clicked;string evento

if isnull(row) or row= 0 then return

evento = this.GetItemString(row,'evento')

this.TriggerEvent(evento)

this.visible=false
dw_1.object.b_opciones.Text = 'Opciones >>'
end event

type dw_2 from u_dw within w_fases_detalle
boolean visible = false
integer x = 3227
integer y = 432
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_apuntes_automaticos"
end type

event constructor;call super::constructor;this.SetTransObject(bd_ejercicio)
end event

type cb_1 from commandbutton within w_fases_detalle
boolean visible = false
integer x = 3598
integer y = 492
integer width = 402
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;n_csd_frontend_ws uo_frontend
uo_frontend=create n_csd_frontend_ws
uo_frontend.of_actualizar_n_registro('FEW61','1')
end event

type dw_otros_datos from u_dw within w_fases_detalle
boolean visible = false
integer x = 3607
integer y = 628
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_fases_otros_datos"
end type

