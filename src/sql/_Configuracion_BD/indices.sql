ALTER TABLE agrupaciones
	ADD CONSTRAINT pk_agrupaciones
	PRIMARY KEY (id_agrupacion)
GO
ALTER TABLE almacen_almacenes
	ADD CONSTRAINT almacen_almacenes_x
	PRIMARY KEY NONCLUSTERED (cod_almacen)
GO
ALTER TABLE almacen_tipos
	ADD CONSTRAINT almacen_tipos_x
	PRIMARY KEY NONCLUSTERED (tipo_almacen)
GO
ALTER TABLE almacen_visados
	ADD CONSTRAINT almacen_visados_x
	PRIMARY KEY NONCLUSTERED (id_almacen_visados)
GO
ALTER TABLE almacen
	ADD CONSTRAINT almacen_x
	PRIMARY KEY NONCLUSTERED (id_almacen)
GO
ALTER TABLE altas_bajas_situaciones
	ADD CONSTRAINT id_altas_bajas_situaciones
	PRIMARY KEY NONCLUSTERED (id_alta_baja_situ)
GO
ALTER TABLE aparatos_tecnicos_calibracion
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id_calibracion)
GO
ALTER TABLE aparatos_tecnicos_prestamos
	ADD CONSTRAINT id_prestamo
	PRIMARY KEY NONCLUSTERED (r_g)
GO
ALTER TABLE aparatos_tecnicos
	ADD CONSTRAINT aparatos_tecnicos_x
	PRIMARY KEY NONCLUSTERED (id_aparato)
GO
ALTER TABLE arquitectos
	ADD CONSTRAINT arquitectos_x
	PRIMARY KEY NONCLUSTERED (id_arquitecto)
GO
ALTER TABLE asesoria_juridica_medio
	ADD CONSTRAINT codigo_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE asesoria_juridica_procedencia
	ADD CONSTRAINT codigo_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE asesoria_juridica
	ADD CONSTRAINT id_asesoria
	PRIMARY KEY NONCLUSTERED (id_asesoria)
GO
ALTER TABLE asesoria_tipo_asuntos
	ADD CONSTRAINT codigo
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE asistente
	ADD CONSTRAINT asistente
	PRIMARY KEY NONCLUSTERED (dw, campo)
GO
ALTER TABLE bt_demandas_cursos
	ADD CONSTRAINT bt_demandas_cursos_x
	PRIMARY KEY NONCLUSTERED (id_col, curso)
GO
ALTER TABLE bt_demandas_experiencias
	ADD CONSTRAINT id_col_empresa
	PRIMARY KEY NONCLUSTERED (id_col, empresa)
GO
ALTER TABLE bt_demandas_idiomas
	ADD CONSTRAINT bt_demandas_idiomas_x
	PRIMARY KEY NONCLUSTERED (id_col, idioma)
GO
ALTER TABLE bt_demandas_tipo
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id_col, tipo_demanda)
GO
ALTER TABLE bt_demandas
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id_col)
GO
ALTER TABLE bt_idiomas
	ADD CONSTRAINT bt_idiomas_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE bt_nivel
	ADD CONSTRAINT codigo
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE bt_ofertas_asigna
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id_ofertas_asigna)
GO
ALTER TABLE bt_ofertas
	ADD CONSTRAINT bt_ofertas_x
	PRIMARY KEY NONCLUSTERED (id_oferta)
GO
ALTER TABLE bt_tipo_bolsa
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (bt_tipo_bolsa)
GO
ALTER TABLE c_geograficos
	ADD CONSTRAINT id_geografico
	PRIMARY KEY NONCLUSTERED (c_geografico)
GO
ALTER TABLE cabecera
	ADD CONSTRAINT pk_cabecera
	PRIMARY KEY NONCLUSTERED (id_registro)
GO
ALTER TABLE caja_pagos
	ADD CONSTRAINT caja_pagos_x
	PRIMARY KEY NONCLUSTERED (id_caja_pagos)
GO
ALTER TABLE caja_salidas_temp
	ADD CONSTRAINT caja_salida
	PRIMARY KEY NONCLUSTERED (id_caja_salida)
GO
ALTER TABLE caja_salidas
	ADD CONSTRAINT caja_salida
	PRIMARY KEY NONCLUSTERED (id_caja_salida)
GO
ALTER TABLE callejero
	ADD CONSTRAINT callejero_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE cargos
	ADD CONSTRAINT id_cargos
	PRIMARY KEY NONCLUSTERED (cargos)
GO
ALTER TABLE cartas
	ADD CONSTRAINT pk_cartas
	PRIMARY KEY NONCLUSTERED (id_carta)
GO
ALTER TABLE cierre
	ADD CONSTRAINT pk_cierre
	PRIMARY KEY NONCLUSTERED (id_cierre)
GO
ALTER TABLE cip_tablas
	ADD CONSTRAINT cip_tablas_copy_x
	PRIMARY KEY NONCLUSTERED (desde, hasta, tarifa)
GO
ALTER TABLE cip_tarifa
	ADD CONSTRAINT cip_tarifa_copy_x
	PRIMARY KEY NONCLUSTERED (tipo_actuacion, tipo_obra)
GO
ALTER TABLE cip_tipo_act
	ADD CONSTRAINT cip_tipo_act_x
	PRIMARY KEY NONCLUSTERED (anyo, tipo_actuacion, tipo_obra)
GO
ALTER TABLE ciudades
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (cod_ciudad)
GO
ALTER TABLE clientes_terceros
	ADD CONSTRAINT clientes_terceros_x
	PRIMARY KEY NONCLUSTERED (id)
GO
ALTER TABLE clientes
	ADD CONSTRAINT clientes
	PRIMARY KEY NONCLUSTERED (id_cliente)
GO
ALTER TABLE coaatcc_ho_tablas
	ADD CONSTRAINT cip_tablas_x
	PRIMARY KEY NONCLUSTERED (desde, hasta, tarifa, contenido)
GO
ALTER TABLE coaatcc_ho_tarifas_contenidos
	ADD CONSTRAINT pk_ho_tarifas_contenidos
	PRIMARY KEY NONCLUSTERED (cod_tarifa, cod_contenido)
GO
ALTER TABLE coaatcc_ho_tarifas
	ADD CONSTRAINT ho_tarifas_x
	PRIMARY KEY NONCLUSTERED (cod_tarifa)
GO
ALTER TABLE coaatll_dip
	ADD CONSTRAINT pk_dv
	PRIMARY KEY NONCLUSTERED (id)
GO
ALTER TABLE coaatmca_coef_b
	ADD CONSTRAINT pk_coef_b
	PRIMARY KEY (codigo)
GO
ALTER TABLE coaatmca_coef_c
	ADD CONSTRAINT pk_coef_c
	PRIMARY KEY (codigo)
GO
ALTER TABLE coaatmca_coeficientes
	ADD CONSTRAINT pk_cod
	PRIMARY KEY (codigo, f_validez_desde, f_validez_hasta)
GO
ALTER TABLE coaatmca_dv
	ADD CONSTRAINT pk_dv
	PRIMARY KEY (id)
GO
ALTER TABLE coaatmca_fases_estadisticas
	ADD CONSTRAINT pk_fases_estad
	PRIMARY KEY (id_fases_estadisticas)
GO
ALTER TABLE coaatmca_tipologia_edif
	ADD CONSTRAINT pk_tipologia
	PRIMARY KEY (codigo)
GO
ALTER TABLE coef_ipc
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (ejercicio)
GO
ALTER TABLE colegiado_cesion_datos
	ADD CONSTRAINT id_cesion_datos
	PRIMARY KEY NONCLUSTERED (id_colegiado)
GO
ALTER TABLE colegiado_inhabilitacion
	ADD CONSTRAINT id_inhabilitacion
	PRIMARY KEY NONCLUSTERED (id_inhabilitacion, id_colegiado)
GO
ALTER TABLE colegiado_titulaciones
	ADD CONSTRAINT id_titulacion
	PRIMARY KEY NONCLUSTERED (id_titulacion, id_colegiado)
GO
ALTER TABLE colegiados_autorizaciones
	ADD CONSTRAINT pk_col_auto
	PRIMARY KEY (id_col_autorizado)
GO
ALTER TABLE colegiados_baja_acredit
	ADD CONSTRAINT log_acredit
	PRIMARY KEY (id_log)
GO
ALTER TABLE colegiados_cambios_dom
	ADD CONSTRAINT pk_id_cambio_dom
	PRIMARY KEY (id_cambio_dom)
GO
ALTER TABLE colegiados_empresas
	ADD CONSTRAINT pk_coleg_empresas
	PRIMARY KEY (id_colegiado, id_empresa)
GO
ALTER TABLE colegiados_firma_digital
	ADD CONSTRAINT pk_coleg_firma_dig
	PRIMARY KEY NONCLUSTERED (id_colegiado, estado, f_estado)
GO
ALTER TABLE colegiados
	ADD CONSTRAINT id_colegiados
	PRIMARY KEY NONCLUSTERED (id_colegiado)
GO
ALTER TABLE colegios_matriculas
	ADD CONSTRAINT pk_colegios_matriculas
	PRIMARY KEY NONCLUSTERED (matricula)
GO
ALTER TABLE colegios
	ADD CONSTRAINT id_colegio
	PRIMARY KEY NONCLUSTERED (cod_colegio)
GO
ALTER TABLE colindantes
	ADD CONSTRAINT colindantes_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE colores
	ADD CONSTRAINT colores_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE comunidad_autonoma
	ADD CONSTRAINT comunidad_autonoma_x
	PRIMARY KEY NONCLUSTERED (id_comunidad_autonoma)
GO
ALTER TABLE conceptos_domiciliables
	ADD CONSTRAINT conceptos_domiciliables_x
	PRIMARY KEY NONCLUSTERED (id_colegiado, concepto, empresa)
GO
ALTER TABLE conceptos_remesables
	ADD CONSTRAINT conceptos_remesables_x
	PRIMARY KEY NONCLUSTERED (id_colegiado, concepto)
GO
ALTER TABLE configura_campos
	ADD CONSTRAINT pk_configura_campos
	PRIMARY KEY NONCLUSTERED (cod_comb)
GO
ALTER TABLE configura_insercion
	ADD CONSTRAINT pk_configura_insercion
	PRIMARY KEY NONCLUSTERED (tipo_act, tipo_obra, destino, cod_comb)
GO
ALTER TABLE consultas_datos
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id_consulta_datos)
GO
ALTER TABLE consultas
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id_consulta)
GO
ALTER TABLE contadores
	ADD CONSTRAINT contadores_x
	PRIMARY KEY NONCLUSTERED (contador)
GO
ALTER TABLE csd_conexion_bd
	ADD CONSTRAINT PK_id_conexion
	PRIMARY KEY NONCLUSTERED (id_conexion)
GO
ALTER TABLE csd_conf_parametro
	ADD CONSTRAINT pk_id_parametro
	PRIMARY KEY NONCLUSTERED (id_parametro)
GO
ALTER TABLE csd_doc_modulo
	ADD CONSTRAINT pk_doc_mod
	PRIMARY KEY (id_documento_modulo)
GO
ALTER TABLE csd_seg_ip_exclusion
	ADD CONSTRAINT PK_id_exclusion
	PRIMARY KEY NONCLUSTERED (id_exclusion)
GO
ALTER TABLE csd_seg_ip
	ADD CONSTRAINT PK_IP_SEG
	PRIMARY KEY NONCLUSTERED (id_seg_ip)
GO
ALTER TABLE csd_seg_tipo_idioma
	ADD CONSTRAINT pk_csd_seg_tipo_idioma
	PRIMARY KEY NONCLUSTERED (cod_tipo_idioma)
GO
ALTER TABLE csd_sms_bd_perfil
	ADD CONSTRAINT csd_sms_bd_perfil_x
	PRIMARY KEY NONCLUSTERED (id_bd_perfil)
GO
ALTER TABLE csd_sms_campanya
	ADD CONSTRAINT csd_sms_campanya_x
	PRIMARY KEY NONCLUSTERED (id_campanya)
GO
ALTER TABLE csd_sms_campos
	ADD CONSTRAINT csd_sms_campos_x
	PRIMARY KEY NONCLUSTERED (id_sms_campos)
GO
ALTER TABLE csd_sms_contactos
	ADD CONSTRAINT csd_sms_contactos_x
	PRIMARY KEY NONCLUSTERED (id_contacto)
GO
ALTER TABLE csd_sms_enviados
	ADD CONSTRAINT csd_sms_enviados_x
	PRIMARY KEY NONCLUSTERED (id_sms_enviados)
GO
ALTER TABLE csd_sms_envios
	ADD CONSTRAINT csd_sms_envios_x
	PRIMARY KEY NONCLUSTERED (id_sms_envios)
GO
ALTER TABLE csd_sms_grupos_detalle
	ADD CONSTRAINT csd_sms_grupos_detalle_x
	PRIMARY KEY NONCLUSTERED (id_grupo_detalle)
GO
ALTER TABLE csd_sms_grupos
	ADD CONSTRAINT csd_sms_grupos_x
	PRIMARY KEY NONCLUSTERED (id_grupo)
GO
ALTER TABLE csd_sms_predefinidos
	ADD CONSTRAINT csd_sms_predefinidos_x
	PRIMARY KEY NONCLUSTERED (id_sms_predifinido)
GO
ALTER TABLE csd_sms_programado
	ADD CONSTRAINT csd_sms_programado_x
	PRIMARY KEY NONCLUSTERED (id_sms_programado)
GO
ALTER TABLE csd_sms
	ADD CONSTRAINT csd_sms_x
	PRIMARY KEY NONCLUSTERED (id_sms)
GO
ALTER TABLE csi_aeat_periodo
	ADD CONSTRAINT csi_aeat_periodo_pk
	PRIMARY KEY NONCLUSTERED (cod_aeat_periodo)
GO
ALTER TABLE csi_aeat_registro_contador
	ADD CONSTRAINT pk_csi_aeat_registro_contador
	PRIMARY KEY NONCLUSTERED (id_declaracion)
GO
ALTER TABLE csi_aeat_t_libro_iva
	ADD CONSTRAINT i_pk_aeat_t_libro_iva
	PRIMARY KEY (t_libro_iva)
GO
ALTER TABLE csi_apuntes_borrados_fe
	ADD CONSTRAINT csi_apuntes_borrados_fe
	PRIMARY KEY NONCLUSTERED (id_apunte)
GO
ALTER TABLE csi_art_serv_correspo
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id)
GO
ALTER TABLE csi_articulos_servicios
	ADD CONSTRAINT csi_articulos_servicios_x
	PRIMARY KEY NONCLUSTERED (codigo, colegio, empresa)
GO
ALTER TABLE csi_articulos_servicios2
	ADD CONSTRAINT csi_articulos_servicios2_x
	PRIMARY KEY NONCLUSTERED (codigo, colegio, empresa)
GO
ALTER TABLE csi_asientos_predefinidos
	ADD CONSTRAINT primarykey
	PRIMARY KEY NONCLUSTERED (id_asiento)
GO
ALTER TABLE csi_balances_a_p_balance
	ADD CONSTRAINT csi_balances_a_p_balance_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE csi_balances_cuentas_especial
	ADD CONSTRAINT csi_balances_cuentas_especial_
	PRIMARY KEY NONCLUSTERED (cuenta, t_balance)
GO
ALTER TABLE csi_balances_etcpn_columnas
	ADD CONSTRAINT pk_csi_balances_etcpn_columnas
	PRIMARY KEY NONCLUSTERED (id_col)
GO
ALTER TABLE csi_balances_fun_especial
	ADD CONSTRAINT csi_balances_fun_especial_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE csi_balances_pyg_mes
	ADD CONSTRAINT csi_balances_pyg_mes_x
	PRIMARY KEY NONCLUSTERED (mes, cuenta, empresa, anyo)
GO
ALTER TABLE csi_balances_t_balance
	ADD CONSTRAINT csi_balances_t_balance_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE csi_balances
	ADD CONSTRAINT csi_balances_x
	PRIMARY KEY NONCLUSTERED (t_balance, a_p, linea)
GO
ALTER TABLE csi_bancos_maestro
	ADD CONSTRAINT csi_bancos_maestro_x
	PRIMARY KEY NONCLUSTERED (cod)
GO
ALTER TABLE csi_bancos
	ADD CONSTRAINT csi_bancos_copy_x
	PRIMARY KEY NONCLUSTERED (codigo, empresa)
GO
ALTER TABLE csi_centros_intragrupo
	ADD CONSTRAINT codigo
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE csi_centros
	ADD CONSTRAINT csi_centros_x
	PRIMARY KEY NONCLUSTERED (centro, empresa)
GO
ALTER TABLE csi_claves_retencion
	ADD CONSTRAINT i_csi_claves_retencion
	PRIMARY KEY NONCLUSTERED (clave, subclave)
GO
ALTER TABLE csi_cobros_multiples
	ADD CONSTRAINT id_cobro_multiple_x
	PRIMARY KEY NONCLUSTERED (id_cobro_multiple)
GO
ALTER TABLE csi_cobros
	ADD CONSTRAINT csi_pagos_x
	PRIMARY KEY NONCLUSTERED (id_pago)
GO
ALTER TABLE csi_columnas_importe
	ADD CONSTRAINT csi_columnas_importe_x
	PRIMARY KEY NONCLUSTERED (campo)
GO
ALTER TABLE csi_control_ejercicios
	ADD CONSTRAINT csi_control_ejercicios_copy_x
	PRIMARY KEY NONCLUSTERED (ejercicio, empresa)
GO
ALTER TABLE csi_datos_economicos_anyo
	ADD CONSTRAINT pk1
	PRIMARY KEY NONCLUSTERED (anyo)
GO
ALTER TABLE csi_diarios_parametrizaciones
	ADD CONSTRAINT csi_diarios_parametrizacs_x
	PRIMARY KEY NONCLUSTERED (id)
GO
ALTER TABLE csi_ejercicios_abiertos
	ADD CONSTRAINT csi_ejercicios_abiertos_copy_x
	PRIMARY KEY NONCLUSTERED (ejercicio, empresa)
GO
ALTER TABLE csi_elems_inmov_grupo
	ADD CONSTRAINT pk_csi_elems_inmov_grupo
	PRIMARY KEY (cod_grupo)
GO
ALTER TABLE csi_elems_inmov_tipo_baja
	ADD CONSTRAINT pk_csi_elems_inmov_tipo_baja
	PRIMARY KEY (cod_tipo_baja)
GO
ALTER TABLE csi_elems_inmov_tipo_natura
	ADD CONSTRAINT pk_csi_elems_inmov_tipo_natura
	PRIMARY KEY (cod_tipo_natura)
GO
ALTER TABLE csi_elems_inmov_ubicacion
	ADD CONSTRAINT pk_csi_elems_inmov_ubicacion
	PRIMARY KEY (cod_ubicacion)
GO
ALTER TABLE csi_elems_inmovilizado_acum
	ADD CONSTRAINT csi_elems_inmov_acum_x
	PRIMARY KEY NONCLUSTERED (id_acum)
GO
ALTER TABLE csi_elems_inmovilizado_mensual
	ADD CONSTRAINT csi_elems_inmovilizado_x
	PRIMARY KEY NONCLUSTERED (id_elem_inmovilizado)
GO
ALTER TABLE csi_elems_inmovilizado_porcent
	ADD CONSTRAINT csi_elems_inmov_porc_x
	PRIMARY KEY NONCLUSTERED (id_porcent)
GO
ALTER TABLE csi_elems_inmovilizado
	ADD CONSTRAINT csi_elems_inmovilizado_x
	PRIMARY KEY NONCLUSTERED (id_elem_inmovilizado)
GO
ALTER TABLE csi_empresas
	ADD CONSTRAINT csi_empresas_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE csi_equiv_copia_empresa
	ADD CONSTRAINT csi_equiv_copia_empresa_x
	PRIMARY KEY NONCLUSTERED (id)
GO
ALTER TABLE csi_existencias_finales
	ADD CONSTRAINT csi_existencias_finales_x
	PRIMARY KEY NONCLUSTERED (anyo, empresa)
GO
ALTER TABLE csi_fact_reclamaciones_tipos
	ADD CONSTRAINT csi_fact_reclamaciones_tipos
	PRIMARY KEY NONCLUSTERED (tipo_reclamacion)
GO
ALTER TABLE csi_fact_reclamaciones
	ADD CONSTRAINT csi_fact_reclamaciones_x
	PRIMARY KEY NONCLUSTERED (id_reclamacion_factura)
GO
ALTER TABLE csi_facturas_emitidas
	ADD CONSTRAINT csi_facturas_emitidas
	PRIMARY KEY NONCLUSTERED (id_factura)
GO
ALTER TABLE csi_facturas_inmovilizado
	ADD CONSTRAINT csi_facturas_inmovilizado_x
	PRIMARY KEY NONCLUSTERED (id_factura)
GO
ALTER TABLE csi_facturas_recibidas
	ADD CONSTRAINT csi_facturas_recibidas_copy_x
	PRIMARY KEY NONCLUSTERED (id_factura)
GO
ALTER TABLE csi_familias
	ADD CONSTRAINT csi_familias_x
	PRIMARY KEY NONCLUSTERED (cod_familia)
GO
ALTER TABLE csi_formas_de_pago_correspo
	ADD CONSTRAINT fpago_correspo_x
	PRIMARY KEY NONCLUSTERED (id)
GO
ALTER TABLE csi_formas_de_pago
	ADD CONSTRAINT csi_formas_de_pago_x
	PRIMARY KEY NONCLUSTERED (tipo_pago)
GO
ALTER TABLE csi_formulas_asientos_prede
	ADD CONSTRAINT csi_formulas_asientos_prede_x
	PRIMARY KEY NONCLUSTERED (campo)
GO
ALTER TABLE csi_lineas_asientos_prede
	ADD CONSTRAINT csi_lineas_asientos_prede
	PRIMARY KEY NONCLUSTERED (id_linea_asiento)
GO
ALTER TABLE csi_lineas_fact_emitidas
	ADD CONSTRAINT csi_lineas_fact_emitidas
	PRIMARY KEY NONCLUSTERED (id_linea)
GO
ALTER TABLE csi_lineas_fact_rec_clasi
	ADD CONSTRAINT csi_lineas_fact_rec_clasifica_
	PRIMARY KEY NONCLUSTERED (id_linea)
GO
ALTER TABLE csi_lineas_fact_recibidas
	ADD CONSTRAINT csi_lineas_fact_recibidas_x
	PRIMARY KEY NONCLUSTERED (id_linea)
GO
ALTER TABLE csi_log_apuntes
	ADD CONSTRAINT pk_csi_log_apuntes
	PRIMARY KEY NONCLUSTERED (id_log_apuntes)
GO
ALTER TABLE csi_meses
	ADD CONSTRAINT csi_meses_x
	PRIMARY KEY NONCLUSTERED (mes)
GO
ALTER TABLE csi_npgc_tablas_modif
	ADD CONSTRAINT csi_npgc_tablas_modif_pk
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE csi_pagos
	ADD CONSTRAINT csi_pagos_copy_x
	PRIMARY KEY NONCLUSTERED (id_pago)
GO
ALTER TABLE csi_param_facturas
	ADD CONSTRAINT csi_param_factura_x
	PRIMARY KEY NONCLUSTERED (serie, empresa, anyo, campo, idioma)
GO
ALTER TABLE csi_param_sigescon
	ADD CONSTRAINT csi_param_sigescon_x
	PRIMARY KEY NONCLUSTERED (nombre)
GO
ALTER TABLE csi_proforma_a_factura
	ADD CONSTRAINT csi_proforma_a_factura
	PRIMARY KEY NONCLUSTERED (id_factura)
GO
ALTER TABLE csi_proveedores_aprobacion
	ADD CONSTRAINT csi_proveedores_aprobacion_x
	PRIMARY KEY NONCLUSTERED (id_proveedores_aprobacion)
GO
ALTER TABLE csi_proveedores_evaluacion
	ADD CONSTRAINT csi_proveedores_evaluacion_x
	PRIMARY KEY NONCLUSTERED (id_proveedores_evaluacion)
GO
ALTER TABLE csi_proveedores
	ADD CONSTRAINT csi_proveedores_copy_x
	PRIMARY KEY NONCLUSTERED (id_proveedor)
GO
ALTER TABLE csi_proyectos
	ADD CONSTRAINT csi_proyectos_copy_x
	PRIMARY KEY NONCLUSTERED (proyecto, empresa)
GO
ALTER TABLE csi_relacion_cuentas_npgc
	ADD CONSTRAINT csi_relacion_cuentas_npgc_pk
	PRIMARY KEY NONCLUSTERED (cuenta_old)
GO
ALTER TABLE csi_series
	ADD CONSTRAINT csi_series_x
	PRIMARY KEY NONCLUSTERED (serie, anyo, empresa)
GO
ALTER TABLE csi_t_aprobacion
	ADD CONSTRAINT csi_t_aprobacion_x
	PRIMARY KEY NONCLUSTERED (t_aprobacion)
GO
ALTER TABLE csi_t_asientos_predefinidos
	ADD CONSTRAINT i_t_asi_prede
	PRIMARY KEY NONCLUSTERED (tipo)
GO
ALTER TABLE csi_t_asientos
	ADD CONSTRAINT csi_t_asientos_x
	PRIMARY KEY NONCLUSTERED (t_asiento)
GO
ALTER TABLE csi_t_conciliacion
	ADD CONSTRAINT csi_t_conciliacion_x
	PRIMARY KEY NONCLUSTERED (tipo)
GO
ALTER TABLE csi_t_destinatario_347
	ADD CONSTRAINT csi_t_destinatario_347_pk
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE csi_t_documento
	ADD CONSTRAINT csi_t_documento_x
	PRIMARY KEY NONCLUSTERED (t_doc)
GO
ALTER TABLE csi_t_estado_pago
	ADD CONSTRAINT csi_t_estado_pago_x
	PRIMARY KEY NONCLUSTERED (tipo)
GO
ALTER TABLE csi_t_evaluacion
	ADD CONSTRAINT csi_t_evaluacion_x
	PRIMARY KEY NONCLUSTERED (t_evaluacion)
GO
ALTER TABLE csi_t_iva
	ADD CONSTRAINT csi_t_iva_x
	PRIMARY KEY NONCLUSTERED (t_iva)
GO
ALTER TABLE csi_tipo_presupuesto
	ADD CONSTRAINT csi_tipo_presupuesto_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE csi_traspasos_basicos
	ADD CONSTRAINT csi_traspasos_basicos_x
	PRIMARY KEY NONCLUSTERED (id_traspaso)
GO
ALTER TABLE csi_trimestres
	ADD CONSTRAINT csi_trimestres_x
	PRIMARY KEY NONCLUSTERED (id_trimestres)
GO
ALTER TABLE cuentas_pyme
	ADD CONSTRAINT CUENTA_X
	PRIMARY KEY NONCLUSTERED (cuenta)
GO
ALTER TABLE cuentas
	ADD CONSTRAINT CUENTA_X
	PRIMARY KEY NONCLUSTERED (cuenta)
GO
ALTER TABLE cursos_ferias
	ADD CONSTRAINT x_cf
	PRIMARY KEY NONCLUSTERED (id_cf)
GO
ALTER TABLE cursos_general
	ADD CONSTRAINT p_k
	PRIMARY KEY NONCLUSTERED (colegiado)
GO
ALTER TABLE delegaciones
	ADD CONSTRAINT delegaciones
	PRIMARY KEY NONCLUSTERED (cod_delegacion)
GO
ALTER TABLE demarcaciones
	ADD CONSTRAINT id_demarcacion
	PRIMARY KEY NONCLUSTERED (cod_demarcacion)
GO
ALTER TABLE departamentos
	ADD CONSTRAINT id_departamento
	PRIMARY KEY NONCLUSTERED (cod_departamento)
GO
ALTER TABLE desc_gui_coefs
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (desde_fecha, hasta_fecha)
GO
ALTER TABLE desc_gui_pem
	ADD CONSTRAINT desc_gui_pem_x
	PRIMARY KEY NONCLUSTERED (anyo, pem_desde, pem_hasta)
GO
ALTER TABLE desc_gui_tipo_act
	ADD CONSTRAINT desc_gui_tipo_act_x
	PRIMARY KEY NONCLUSTERED (anyo, tipo_actuacion, tipo_obra)
GO
ALTER TABLE descuentos_visared
	ADD CONSTRAINT descuentos_visared_x
	PRIMARY KEY NONCLUSTERED (tipo_actuacion, tipo_obra)
GO
ALTER TABLE devoluciones_motivos
	ADD CONSTRAINT devoluciones_motivos_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE domiciliaciones_formatos
	ADD CONSTRAINT domiciliaciones_formatos_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE domiciliaciones
	ADD CONSTRAINT domiciliaciones_x
	PRIMARY KEY NONCLUSTERED (id_domiciliacion)
GO
ALTER TABLE domicilios
	ADD CONSTRAINT id_domicilio
	PRIMARY KEY NONCLUSTERED (id_domicilio)
GO
ALTER TABLE dv_sobre_pem
	ADD CONSTRAINT dv_sobre_pem_x
	PRIMARY KEY NONCLUSTERED (pem_desde, pem_hasta, importe)
GO
ALTER TABLE dv_tipo_act
	ADD CONSTRAINT dv_tipo_act_x
	PRIMARY KEY NONCLUSTERED (anyo, tipo_actuacion, tipo_obra)
GO
ALTER TABLE equivalencias
	ADD CONSTRAINT id
	PRIMARY KEY NONCLUSTERED (grupo, nombre_anterior)
GO
ALTER TABLE escuela
	ADD CONSTRAINT pk_codigo
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE est_tipo_act_tipo_obra_f
	ADD CONSTRAINT est_tipo_act_tipo_obra_f
	PRIMARY KEY NONCLUSTERED (tipo_act)
GO
ALTER TABLE est_tipo_act
	ADD CONSTRAINT est_tipo_act_copy_x
	PRIMARY KEY NONCLUSTERED (tipo_act)
GO
ALTER TABLE est_tipo_obra
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (tipo_obra)
GO
ALTER TABLE exp_rel
	ADD CONSTRAINT n_reg
	PRIMARY KEY (n_registro)
GO
ALTER TABLE expedientes_documentos
	ADD CONSTRAINT id_docu
	PRIMARY KEY NONCLUSTERED (id_expedi, id_docu)
GO
ALTER TABLE expedientes_estado
	ADD CONSTRAINT cod_estado
	PRIMARY KEY NONCLUSTERED (cod_estado)
GO
ALTER TABLE expedientes_relacionados
	ADD CONSTRAINT pk_exped_relac
	PRIMARY KEY NONCLUSTERED (id_expedi_relac, id_expedi)
GO
ALTER TABLE expedientes
	ADD CONSTRAINT expedientes_copy_x
	PRIMARY KEY NONCLUSTERED (id_expedi)
GO
ALTER TABLE facturas_a_borrar
	ADD CONSTRAINT pk
	PRIMARY KEY (id_factura)
GO
ALTER TABLE fases_admin_jud_tipos_rec
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE fases_administrativa_jud_col
	ADD CONSTRAINT id_admin_col
	PRIMARY KEY NONCLUSTERED (id_administracion, id_colegiado)
GO
ALTER TABLE fases_administrativa_judicial
	ADD CONSTRAINT id_administracion
	PRIMARY KEY NONCLUSTERED (id_administracion)
GO
ALTER TABLE fases_arquitectos
	ADD CONSTRAINT fases_arquitectos_x
	PRIMARY KEY NONCLUSTERED (id_fases_arquitectos)
GO
ALTER TABLE fases_cip_tfe
	ADD CONSTRAINT fases_cip_tfe
	PRIMARY KEY NONCLUSTERED (tipo, ambito, id_fase)
GO
ALTER TABLE fases_clientes
	ADD CONSTRAINT pk_fases_clientes
	PRIMARY KEY NONCLUSTERED (id_fase, id_cliente)
GO
ALTER TABLE fases_clientes2
	ADD CONSTRAINT pk_fases_clientes2
	PRIMARY KEY NONCLUSTERED (id_fase, id_cliente)
GO
ALTER TABLE fases_clientes3
	ADD CONSTRAINT pk_fases_clientes3
	PRIMARY KEY NONCLUSTERED (id_fase, id_cliente)
GO
ALTER TABLE fases_clientes4
	ADD CONSTRAINT pk_fases_clientes4
	PRIMARY KEY NONCLUSTERED (id_fase, id_cliente)
GO
ALTER TABLE fases_colegiados_asociados
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id_col_per, id_fases_colegiados)
GO
ALTER TABLE fases_colegiados
	ADD CONSTRAINT fases_colegiados_x
	PRIMARY KEY NONCLUSTERED (id_fases_colegiados)
GO
ALTER TABLE fases_contratistas
	ADD CONSTRAINT fases_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE fases_documentos_visared
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id_fichero)
GO
ALTER TABLE fases_documentos
	ADD CONSTRAINT documentos
	PRIMARY KEY NONCLUSTERED (id_docu)
GO
ALTER TABLE fases_estados
	ADD CONSTRAINT estados
	PRIMARY KEY NONCLUSTERED (id_fase, fecha)
GO
ALTER TABLE fases_fact_tmp
	ADD CONSTRAINT pk_id
	PRIMARY KEY (id_fase)
GO
ALTER TABLE fases_fact_tmp2
	ADD CONSTRAINT pk_id
	PRIMARY KEY (id_fase)
GO
ALTER TABLE fases_finales_acciones_realiza
	ADD CONSTRAINT fases_finales_accion_realiza_x
	PRIMARY KEY NONCLUSTERED (id_accion)
GO
ALTER TABLE fases_finales
	ADD CONSTRAINT primarykey
	PRIMARY KEY NONCLUSTERED (id_fases_final)
GO
ALTER TABLE fases_garantias
	ADD CONSTRAINT fases_garantias_x
	PRIMARY KEY NONCLUSTERED (id_fase, id_colegiado, id_cliente)
GO
ALTER TABLE fases_honos_cip
	ADD CONSTRAINT pk_fases_honos_cip
	PRIMARY KEY NONCLUSTERED (id_fase)
GO
ALTER TABLE fases_honos_orientativos
	ADD CONSTRAINT pk_fases_honos_orientat
	PRIMARY KEY NONCLUSTERED (id_fase)
GO
ALTER TABLE fases_incompatibilidades
	ADD CONSTRAINT fases_incompatibilidades_x
	PRIMARY KEY NONCLUSTERED (t_actuacion, t_obra, uso)
GO
ALTER TABLE fases_informes
	ADD CONSTRAINT fases_informes
	PRIMARY KEY NONCLUSTERED (id_fase, id_informe, tipo_informe)
GO
ALTER TABLE fases_informes2
	ADD CONSTRAINT fases_informes
	PRIMARY KEY NONCLUSTERED (id_fase, id_informe)
GO
ALTER TABLE fases_liquidaciones
	ADD CONSTRAINT pk_fases_liquidaciones
	PRIMARY KEY NONCLUSTERED (id_liquidacion)
GO
ALTER TABLE fases_minutas_cartas_grupos
	ADD CONSTRAINT pk_ref
	PRIMARY KEY (id_referencia_carta, id_referencia_fase)
GO
ALTER TABLE fases_minutas_cartas_hist
	ADD CONSTRAINT id_x
	PRIMARY KEY NONCLUSTERED (id)
GO
ALTER TABLE fases_minutas_cartas
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id_carta)
GO
ALTER TABLE fases_minutas
	ADD CONSTRAINT fases_minutas
	PRIMARY KEY NONCLUSTERED (id_minuta)
GO
ALTER TABLE fases_otros_datos
	ADD CONSTRAINT pk_otros_datos
	PRIMARY KEY NONCLUSTERED (id_fase)
GO
ALTER TABLE fases_reclamaciones
	ADD CONSTRAINT id_tr_x
	PRIMARY KEY NONCLUSTERED (id_minuta, tipo_reclamacion, f_reclamacion)
GO
ALTER TABLE fases_registros_es
	ADD CONSTRAINT registros_es
	PRIMARY KEY NONCLUSTERED (id_escrito)
GO
ALTER TABLE fases_renuncias
	ADD CONSTRAINT pk_fases_renuncias
	PRIMARY KEY (id_fase, id_renuncia)
GO
ALTER TABLE fases_reposiciones
	ADD CONSTRAINT pk_id_rep
	PRIMARY KEY (id_reposicion)
GO
ALTER TABLE fases_siniestros_coles
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id_siniestro, id_colegiado)
GO
ALTER TABLE fases_siniestros_incidencias
	ADD CONSTRAINT pk_fases_sini_inci
	PRIMARY KEY NONCLUSTERED (id_incidencia)
GO
ALTER TABLE fases_siniestros_tecnicos
	ADD CONSTRAINT fases_siniestros_tecnicos
	PRIMARY KEY NONCLUSTERED (id_fase_siniestro_tecnico)
GO
ALTER TABLE fases_siniestros
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id_siniestro)
GO
ALTER TABLE fases_usos_tarifa
	ADD CONSTRAINT pk_id
	PRIMARY KEY NONCLUSTERED (id_fase, cod_uso)
GO
ALTER TABLE fases_usos
	ADD CONSTRAINT fases_usos
	PRIMARY KEY NONCLUSTERED (id_uso, id_fase)
GO
ALTER TABLE fases
	ADD CONSTRAINT fases_x
	PRIMARY KEY NONCLUSTERED (id_fase)
GO
ALTER TABLE formacion_areas_materias_curso
	ADD CONSTRAINT curso_area_materia_x
	PRIMARY KEY NONCLUSTERED (id_curso, codigo)
GO
ALTER TABLE formacion_areas_materias
	ADD CONSTRAINT codigo_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE formacion_asist_fecha
	ADD CONSTRAINT formacion_asist_fecha_x
	PRIMARY KEY NONCLUSTERED (id_asistencia_fecha)
GO
ALTER TABLE formacion_asistentes_test
	ADD CONSTRAINT formacion_asistentes_test_x
	PRIMARY KEY NONCLUSTERED (id_encuesta)
GO
ALTER TABLE formacion_asistentes
	ADD CONSTRAINT formacion_asistentes_copy_x
	PRIMARY KEY NONCLUSTERED (id_asistente)
GO
ALTER TABLE formacion_campos_encuesta
	ADD CONSTRAINT formacion_campos_encuesta
	PRIMARY KEY NONCLUSTERED (id_campo)
GO
ALTER TABLE formacion_costes
	ADD CONSTRAINT formacion_costes_x
	PRIMARY KEY NONCLUSTERED (id_coste)
GO
ALTER TABLE formacion_ctrl_asistencia
	ADD CONSTRAINT formacion_ctrl_asistencia_x
	PRIMARY KEY NONCLUSTERED (id_asistencia)
GO
ALTER TABLE formacion_cursos
	ADD CONSTRAINT formacion_cursos_x
	PRIMARY KEY NONCLUSTERED (id_curso)
GO
ALTER TABLE formacion_dirigido_a
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE formacion_documentacion
	ADD CONSTRAINT formacion_documentacion_x
	PRIMARY KEY NONCLUSTERED (id_documento)
GO
ALTER TABLE formacion_encuesta
	ADD CONSTRAINT formacion_encuesta_x
	PRIMARY KEY NONCLUSTERED (id_pregunta)
GO
ALTER TABLE formacion_estadisticas
	ADD CONSTRAINT formacion_estadisticas_x
	PRIMARY KEY NONCLUSTERED (id_estadistica)
GO
ALTER TABLE formacion_estados
	ADD CONSTRAINT pk_formacion_estados
	PRIMARY KEY NONCLUSTERED (cod_estado)
GO
ALTER TABLE formacion_fechas
	ADD CONSTRAINT formacion_fechas_x
	PRIMARY KEY NONCLUSTERED (id_curso_fechas)
GO
ALTER TABLE formacion_formapago
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (cod_fp)
GO
ALTER TABLE formacion_importe
	ADD CONSTRAINT formacion_importe_x
	PRIMARY KEY NONCLUSTERED (id_importe)
GO
ALTER TABLE formacion_mant_preguntas
	ADD CONSTRAINT codigo
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE formacion_mant_test
	ADD CONSTRAINT formacion_mant_test_x
	PRIMARY KEY NONCLUSTERED (id_respuesta_test)
GO
ALTER TABLE formacion_materias_curso
	ADD CONSTRAINT curso_area_materia_x
	PRIMARY KEY NONCLUSTERED (id_cursos_materias)
GO
ALTER TABLE formacion_organizadores_curso
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id_organizador_curso)
GO
ALTER TABLE formacion_organizadores
	ADD CONSTRAINT formacion_organizadores_x
	PRIMARY KEY NONCLUSTERED (id_organizador)
GO
ALTER TABLE formacion_ponente_curso
	ADD CONSTRAINT formacion_ponente_curso_x
	PRIMARY KEY NONCLUSTERED (id_curso_ponente)
GO
ALTER TABLE formacion_ponentes
	ADD CONSTRAINT formacion_ponentes_x
	PRIMARY KEY NONCLUSTERED (id_ponente)
GO
ALTER TABLE formacion_preinscrito
	ADD CONSTRAINT formacion_preinscrito
	PRIMARY KEY NONCLUSTERED (id_preinscrito)
GO
ALTER TABLE formacion_programa
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id_formacion_programa)
GO
ALTER TABLE formacion_subtipo_conv
	ADD CONSTRAINT cod_subtipo
	PRIMARY KEY NONCLUSTERED (cod_subtipo)
GO
ALTER TABLE formacion_tipo_asistente
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE formacion_tipo_conv_clasi
	ADD CONSTRAINT cod_clasificacion
	PRIMARY KEY NONCLUSTERED (cod_clasificacion)
GO
ALTER TABLE formacion_tipo_conv
	ADD CONSTRAINT cod_tipo
	PRIMARY KEY NONCLUSTERED (cod_tipo)
GO
ALTER TABLE formacion_tipos_documentos
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE formacion_titulacion
	ADD CONSTRAINT cod_titulacion
	PRIMARY KEY NONCLUSTERED (cod_titulacion)
GO
ALTER TABLE formacion_valoracion
	ADD CONSTRAINT formacion_valoracion
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE fotos_firmas_colegiados
	ADD CONSTRAINT id_foto_firma_x
	PRIMARY KEY NONCLUSTERED (id_foto_firma)
GO
ALTER TABLE gcw_archivo
	ADD CONSTRAINT pk_id_archivo
	PRIMARY KEY NONCLUSTERED (id_archivo)
GO
ALTER TABLE gcw_aviso
	ADD CONSTRAINT pk_gcw_preferencias
	PRIMARY KEY NONCLUSTERED (id_registro, id_usuario)
GO
ALTER TABLE gcw_colegio
	ADD CONSTRAINT pk_id_colegio
	PRIMARY KEY NONCLUSTERED (id_colegio)
GO
ALTER TABLE gcw_modulo
	ADD CONSTRAINT pk_id_modulo
	PRIMARY KEY NONCLUSTERED (id_modulo)
GO
ALTER TABLE gcw_perfil
	ADD CONSTRAINT pk_id_perfil
	PRIMARY KEY NONCLUSTERED (id_perfil)
GO
ALTER TABLE gcw_preferencia
	ADD CONSTRAINT pk_gcw_preferencias
	PRIMARY KEY NONCLUSTERED (id_modulo, id_usuario)
GO
ALTER TABLE gcw_registro_perfil
	ADD CONSTRAINT pk_id_registro_perfil
	PRIMARY KEY NONCLUSTERED (id_registro, id_perfil)
GO
ALTER TABLE gcw_registro
	ADD CONSTRAINT pk_id_registro
	PRIMARY KEY NONCLUSTERED (id_registro)
GO
ALTER TABLE gcw_tipo_archivo
	ADD CONSTRAINT pk_id_tipo_archivo
	PRIMARY KEY NONCLUSTERED (id_tipo_archivo)
GO
ALTER TABLE gcw_usuario_perfil
	ADD CONSTRAINT pk_id_usuario_perfil
	PRIMARY KEY NONCLUSTERED (id_usuario, id_perfil)
GO
ALTER TABLE gcw_usuario
	ADD CONSTRAINT pk_gcw_usuarios
	PRIMARY KEY NONCLUSTERED (id_usuario)
GO
ALTER TABLE grupos
	ADD CONSTRAINT grupos_x
	PRIMARY KEY NONCLUSTERED (grupos)
GO
ALTER TABLE ho_contenidos
	ADD CONSTRAINT pk_ho_contenidos
	PRIMARY KEY NONCLUSTERED (cod_contenido)
GO
ALTER TABLE ho_parametros
	ADD CONSTRAINT pk_ho_parametros
	PRIMARY KEY NONCLUSTERED (id_parametro)
GO
ALTER TABLE ho_tablas
	ADD CONSTRAINT cip_tablas_x
	PRIMARY KEY NONCLUSTERED (desde, hasta, tarifa, contenido)
GO
ALTER TABLE ho_tarifas_contenidos
	ADD CONSTRAINT pk_ho_tarifas_contenidos
	PRIMARY KEY NONCLUSTERED (cod_tarifa, cod_contenido)
GO
ALTER TABLE ho_tarifas
	ADD CONSTRAINT ho_tarifas_x
	PRIMARY KEY NONCLUSTERED (cod_tarifa)
GO
ALTER TABLE hon_tablas
	ADD CONSTRAINT cip_tablas_x
	PRIMARY KEY NONCLUSTERED (desde, hasta, tarifa, contenido)
GO
ALTER TABLE honos_tablas_gui
	ADD CONSTRAINT pk_honos_tablas_gui
	PRIMARY KEY NONCLUSTERED (desde, hasta, tarifa, desde_altura, hasta_altura)
GO
ALTER TABLE honos_tarifa_gui
	ADD CONSTRAINT honos_tarifa_x
	PRIMARY KEY NONCLUSTERED (tipo_actuacion, tipo_obra)
GO
ALTER TABLE incidencias_exp
	ADD CONSTRAINT incidencias
	PRIMARY KEY NONCLUSTERED (id_incidencias, exp, fecha, codigo)
GO
ALTER TABLE incidencias_expedientes
	ADD CONSTRAINT codigo
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE incidencias_familias
	ADD CONSTRAINT incidencias_familias
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE incidencias_fases
	ADD CONSTRAINT incidencias_fases
	PRIMARY KEY NONCLUSTERED (id_incidencias, id_fase, fecha, codigo)
GO
ALTER TABLE incidencias
	ADD CONSTRAINT incidencias
	PRIMARY KEY NONCLUSTERED (id_incidencias)
GO
ALTER TABLE incompatibilidades
	ADD CONSTRAINT id_incompatibilidad
	PRIMARY KEY NONCLUSTERED (id_incompatibilidad)
GO
ALTER TABLE jg_asistentes
	ADD CONSTRAINT id_asistente
	PRIMARY KEY NONCLUSTERED (id_asistente)
GO
ALTER TABLE jg_reuniones
	ADD CONSTRAINT jg_reuniones_x
	PRIMARY KEY NONCLUSTERED (id_reunion)
GO
ALTER TABLE libro_incidencias
	ADD CONSTRAINT documento
	PRIMARY KEY NONCLUSTERED (id_docu)
GO
ALTER TABLE libro_ordenes
	ADD CONSTRAINT libro_ordenes
	PRIMARY KEY NONCLUSTERED (id_docu)
GO
ALTER TABLE libros_ubicaciones
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE libros
	ADD CONSTRAINT libros_copy_x
	PRIMARY KEY NONCLUSTERED (id_libro)
GO
ALTER TABLE listados_aux
	ADD CONSTRAINT listados_x
	PRIMARY KEY NONCLUSTERED (dw, ventana)
GO
ALTER TABLE listados_real
	ADD CONSTRAINT listados_x
	PRIMARY KEY NONCLUSTERED (descripcion, dw, ventana)
GO
ALTER TABLE listados
	ADD CONSTRAINT listados_x
	PRIMARY KEY NONCLUSTERED (dw, ventana, descripcion)
GO
ALTER TABLE listas_colegiados
	ADD CONSTRAINT id_lista
	PRIMARY KEY NONCLUSTERED (id_lista)
GO
ALTER TABLE listas_miembros
	ADD CONSTRAINT listas_miembros_x
	PRIMARY KEY NONCLUSTERED (id_lista, id_lista_miembro, id_cliente)
GO
ALTER TABLE menu
	ADD CONSTRAINT pk_menu
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE meses
	ADD CONSTRAINT PK_MES
	PRIMARY KEY (cod_mes)
GO
ALTER TABLE messages_ca
	ADD CONSTRAINT PK_TAG
	PRIMARY KEY (tag)
GO
ALTER TABLE messages
	ADD CONSTRAINT messages_x
	PRIMARY KEY NONCLUSTERED (msgid)
GO
ALTER TABLE minutas_nuevas
	ADD CONSTRAINT minutas_nuevas_x
	PRIMARY KEY NONCLUSTERED (id_minuta)
GO
ALTER TABLE modalidades
	ADD CONSTRAINT cod_modalidad
	PRIMARY KEY NONCLUSTERED (cod_modalidad)
GO
ALTER TABLE modificaciones
	ADD CONSTRAINT id_modificacion
	PRIMARY KEY NONCLUSTERED (id_modificacion)
GO
ALTER TABLE movimientos
	ADD CONSTRAINT movimientos_x
	PRIMARY KEY NONCLUSTERED (id_movimiento)
GO
ALTER TABLE municipios
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (provincia, cod_muni)
GO
ALTER TABLE musaat_asistencia
	ADD CONSTRAINT musaat_asistencia_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE musaat_cober_exceso
	ADD CONSTRAINT musaat_cober_exceso_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE musaat_cober_peritos
	ADD CONSTRAINT musaat_cober_tasadores_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE musaat_cober_src
	ADD CONSTRAINT musaat_cober_src_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE musaat_cober_tasadores
	ADD CONSTRAINT musaat_cober_tasadores_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE musaat_coef_c
	ADD CONSTRAINT musaat_coef_c_x
	PRIMARY KEY NONCLUSTERED (tipoact, tipoobra, coef, tabla, f_desde, f_hasta)
GO
ALTER TABLE musaat_coef_col
	ADD CONSTRAINT pk_musaat_coef_col
	PRIMARY KEY NONCLUSTERED (coef, f_desde, f_hasta)
GO
ALTER TABLE musaat_coef_g
	ADD CONSTRAINT musaat_coef_g_x
	PRIMARY KEY NONCLUSTERED (cobertura, coef, f_desde, f_hasta)
GO
ALTER TABLE musaat_coef_k
	ADD CONSTRAINT musaat_coef_k_x
	PRIMARY KEY NONCLUSTERED (desde, hasta, coef, tabla, f_desde, f_hasta)
GO
ALTER TABLE musaat_desc_porc_part
	ADD CONSTRAINT musaat_desc_porc_part_x
	PRIMARY KEY NONCLUSTERED (desde, hasta, descuento, f_desde, f_hasta)
GO
ALTER TABLE musaat_histo_cober_src
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id_cobertura)
GO
ALTER TABLE musaat_movimientos
	ADD CONSTRAINT musaat_movimientos
	PRIMARY KEY NONCLUSTERED (id_movimiento)
GO
ALTER TABLE musaat_params_linea_fe
	ADD CONSTRAINT musaat_params_linea_fe
	PRIMARY KEY NONCLUSTERED (id_musaat)
GO
ALTER TABLE musaat_src_estado
	ADD CONSTRAINT musaat_src_estado_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE musaat_src_t_poliza
	ADD CONSTRAINT musaat_src_t_poliza_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE musaat_tarifa_e
	ADD CONSTRAINT musaat_tarifa_e_x
	PRIMARY KEY NONCLUSTERED (volumen_desde, volumen_hasta, f_desde, f_hasta)
GO
ALTER TABLE musaat_tarifas
	ADD CONSTRAINT musaat_tarifas_x
	PRIMARY KEY NONCLUSTERED (tarifa, minimo, f_desde, f_hasta)
GO
ALTER TABLE musaat_tipo_visado
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (tipo_visado)
GO
ALTER TABLE musaat_tipologia
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (tipo_csd)
GO
ALTER TABLE musaat_tipos_oo
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (tipo_oo)
GO
ALTER TABLE musaat
	ADD CONSTRAINT musaat_copy_x
	PRIMARY KEY NONCLUSTERED (id_musaat)
GO
ALTER TABLE notificaciones
	ADD CONSTRAINT notificaciones
	PRIMARY KEY NONCLUSTERED (nombre)
GO
ALTER TABLE orientaciones_profesionales
	ADD CONSTRAINT id_orientaciones
	PRIMARY KEY NONCLUSTERED (id_orientaciones)
GO
ALTER TABLE origen_inhabilitacion
	ADD CONSTRAINT pk_origen_inhabilitacion
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE otras_personas
	ADD CONSTRAINT id_otras_personas
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE otros_conceptos
	ADD CONSTRAINT id_codigo
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE otros_datos_colegiado
	ADD CONSTRAINT id_otros_datos_colegiado
	PRIMARY KEY NONCLUSTERED (cod_caracteristica, id_colegiado)
GO
ALTER TABLE paises
	ADD CONSTRAINT paises_x
	PRIMARY KEY NONCLUSTERED (cod_pais)
GO
ALTER TABLE personalidad_juridica
	ADD CONSTRAINT cp_personalidad
	PRIMARY KEY NONCLUSTERED (c_personalidad)
GO
ALTER TABLE personas_asociadas
	ADD CONSTRAINT pk_id_linea
	PRIMARY KEY NONCLUSTERED (id_linea)
GO
ALTER TABLE plantillas_campos_extra
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (cod_plant, campo_formulario)
GO
ALTER TABLE plantillas
	ADD CONSTRAINT plantillas_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE poblaciones_zonas
	ADD CONSTRAINT pk_pobla_zonas
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE poblaciones
	ADD CONSTRAINT poblaciones
	PRIMARY KEY NONCLUSTERED (cod_pob, cod_pos)
GO
ALTER TABLE premaat_beneficiarios
	ADD CONSTRAINT premaat_beneficiarios_x
	PRIMARY KEY NONCLUSTERED (id)
GO
ALTER TABLE premaat_grupo
	ADD CONSTRAINT premaat_grupo_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE premaat_historico
	ADD CONSTRAINT pk_id_mod
	PRIMARY KEY (id_modificacion)
GO
ALTER TABLE premaat_liquidaciones
	ADD CONSTRAINT premaat_liquidaciones_x
	PRIMARY KEY NONCLUSTERED (id_liquidacion)
GO
ALTER TABLE premaat_parentesco
	ADD CONSTRAINT premaat_parentesco_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE premaat_prestaciones
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id_prestaciones)
GO
ALTER TABLE premaat_situacion
	ADD CONSTRAINT premaat_situacion_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE premaat_tablas
	ADD CONSTRAINT pk_premaat_tablas
	PRIMARY KEY NONCLUSTERED (anyo)
GO
ALTER TABLE premaat_tipo_mut
	ADD CONSTRAINT premaat_tipo_mut_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE premaat_tipo_pres
	ADD CONSTRAINT premaat_tipo_pres_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE premaat
	ADD CONSTRAINT premaat_x
	PRIMARY KEY NONCLUSTERED (id_premaat)
GO
ALTER TABLE prestamos
	ADD CONSTRAINT id_prestamo
	PRIMARY KEY NONCLUSTERED (id_prestamo)
GO
ALTER TABLE provincias
	ADD CONSTRAINT provincias_x
	PRIMARY KEY NONCLUSTERED (cod_provincia)
GO
ALTER TABLE reg_apdir
	ADD CONSTRAINT reg_apdir_x
	PRIMARY KEY NONCLUSTERED (dicod)
GO
ALTER TABLE registro_almacenes
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (registro)
GO
ALTER TABLE registro_anexos
	ADD CONSTRAINT registro_a
	PRIMARY KEY NONCLUSTERED (id_registro_anexo)
GO
ALTER TABLE registro_series
	ADD CONSTRAINT pk_serie
	PRIMARY KEY NONCLUSTERED (codigo, empresa, cod_delegacion)
GO
ALTER TABLE registro_series2
	ADD CONSTRAINT pk_serie
	PRIMARY KEY NONCLUSTERED (codigo, cod_delegacion)
GO
ALTER TABLE registro_t_comunicado
	ADD CONSTRAINT pk_registro_t_comunicado
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE registro
	ADD CONSTRAINT registro
	PRIMARY KEY NONCLUSTERED (id_registro)
GO
ALTER TABLE regsoc_actividades
	ADD CONSTRAINT regsoc_actividades_x
	PRIMARY KEY NONCLUSTERED (id_regsoc_actividad)
GO
ALTER TABLE regsoc_agenda
	ADD CONSTRAINT id_regsoc_agenda
	PRIMARY KEY NONCLUSTERED (id_regsoc_agenda)
GO
ALTER TABLE regsoc_sancion
	ADD CONSTRAINT id_regsoc_sancion
	PRIMARY KEY NONCLUSTERED (id_reg_soc_sancion)
GO
ALTER TABLE regsoc_tipo_entrada_agenda
	ADD CONSTRAINT cod_tipo_entrada_agenda
	PRIMARY KEY NONCLUSTERED (cod_tipo_entrada_agenda)
GO
ALTER TABLE regsoc_tipo_forma_juridica
	ADD CONSTRAINT regsoc_forma_juridica_x
	PRIMARY KEY NONCLUSTERED (cod_forma_juridica)
GO
ALTER TABLE regsoc_tipo_registro_mercantil
	ADD CONSTRAINT resoc_registro_mercantil_x
	PRIMARY KEY NONCLUSTERED (cod_reg_mercantil)
GO
ALTER TABLE regsoc_tipo_sancion
	ADD CONSTRAINT cod_tipo_sancion
	PRIMARY KEY NONCLUSTERED (cod_tipo_sancion)
GO
ALTER TABLE regsoc
	ADD CONSTRAINT pk_regsoc
	PRIMARY KEY NONCLUSTERED (id_regsoc)
GO
ALTER TABLE remesa_confirming
	ADD CONSTRAINT pk_id_remesa
	PRIMARY KEY NONCLUSTERED (id_remesa)
GO
ALTER TABLE remesas_reclamaciones
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id_remesas_reclamaciones)
GO
ALTER TABLE remesas
	ADD CONSTRAINT n_remesa
	PRIMARY KEY NONCLUSTERED (n_remesa, empresa)
GO
ALTER TABLE remesas2
	ADD CONSTRAINT n_remesa
	PRIMARY KEY NONCLUSTERED (n_remesa)
GO
ALTER TABLE reparos_ficha_linea
	ADD CONSTRAINT id_reparo_linea
	PRIMARY KEY NONCLUSTERED (id_reparo_linea)
GO
ALTER TABLE reparos_ficha
	ADD CONSTRAINT id_reparo_ficha
	PRIMARY KEY NONCLUSTERED (id_reparo_ficha)
GO
ALTER TABLE rpc
	ADD CONSTRAINT pk_nvisado
	PRIMARY KEY (n_visado)
GO
ALTER TABLE sini_damnificados
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE sini_estimacion_economica
	ADD CONSTRAINT codigo_sini_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE sini_tipo_danyos
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE sini_tipo_estado_obra
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE sini_tipo_reclamacion
	ADD CONSTRAINT pk_sini_tipo_reclamacion
	PRIMARY KEY (codigo)
GO
ALTER TABLE sociedades
	ADD CONSTRAINT sociedades_x
	PRIMARY KEY NONCLUSTERED (id_regsoc_socio)
GO
ALTER TABLE t_agrupaciones
	ADD CONSTRAINT id_agrupacion
	PRIMARY KEY NONCLUSTERED (cod_agrupacion)
GO
ALTER TABLE t_altas_bajas_situaciones
	ADD CONSTRAINT id_altas_bajas_situaciones
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE t_aplicacion
	ADD CONSTRAINT t_aplicacion_x
	PRIMARY KEY NONCLUSTERED (cod_aplicacion)
GO
ALTER TABLE t_control_eventos
	ADD CONSTRAINT t_control_eventos_x
	PRIMARY KEY NONCLUSTERED (id_control)
GO
ALTER TABLE t_descripcion_fases
	ADD CONSTRAINT t_descripcion_fases
	PRIMARY KEY NONCLUSTERED (id_descripcion)
GO
ALTER TABLE t_destinos
	ADD CONSTRAINT t_destinos_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE t_documentos
	ADD CONSTRAINT id_documento
	PRIMARY KEY NONCLUSTERED (c_t_documentos)
GO
ALTER TABLE t_domicilios
	ADD CONSTRAINT id_domicilio
	PRIMARY KEY NONCLUSTERED (cod_domicilio)
GO
ALTER TABLE t_fases_finales
	ADD CONSTRAINT pk_codigo
	PRIMARY KEY (codigo)
GO
ALTER TABLE t_fases
	ADD CONSTRAINT c_t_fase
	PRIMARY KEY NONCLUSTERED (c_t_fase)
GO
ALTER TABLE t_gestion
	ADD CONSTRAINT cod_gestion
	PRIMARY KEY NONCLUSTERED (cod_gestion)
GO
ALTER TABLE t_grupo_permisos
	ADD CONSTRAINT pk_grupo_permisos
	PRIMARY KEY NONCLUSTERED (cod_grupo, cod_aplicacion)
GO
ALTER TABLE t_grupo
	ADD CONSTRAINT pk_t_grupo
	PRIMARY KEY NONCLUSTERED (cod_grupo)
GO
ALTER TABLE t_incompatibilidad
	ADD CONSTRAINT t_incompatibilidad_x
	PRIMARY KEY NONCLUSTERED (cod_incompatibilidad)
GO
ALTER TABLE t_informes
	ADD CONSTRAINT t_informes
	PRIMARY KEY NONCLUSTERED (c_informe)
GO
ALTER TABLE t_laboratorio
	ADD CONSTRAINT pk_laboratorio
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE t_mensaje
	ADD CONSTRAINT t_mensaje_x
	PRIMARY KEY NONCLUSTERED (id_mensaje)
GO
ALTER TABLE t_orientaciones_profesionales
	ADD CONSTRAINT id_orientacion_profesional
	PRIMARY KEY NONCLUSTERED (cod_orientacion_profesional)
GO
ALTER TABLE t_permisos
	ADD CONSTRAINT t_permisos_x
	PRIMARY KEY NONCLUSTERED (cod_usuario, cod_aplicacion)
GO
ALTER TABLE t_preguntas
	ADD CONSTRAINT pk_t_preguntas
	PRIMARY KEY NONCLUSTERED (cod_pregunta)
GO
ALTER TABLE t_promotor_grupos
	ADD CONSTRAINT codigo
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE t_promotor
	ADD CONSTRAINT t_promotor_x
	PRIMARY KEY NONCLUSTERED (t_promotor)
GO
ALTER TABLE t_reparos_fases
	ADD CONSTRAINT pk_codigo
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE t_sello_posiciones
	ADD CONSTRAINT pk_t_sello_posiciones
	PRIMARY KEY (id_posicion)
GO
ALTER TABLE t_sello_textos
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (id_texto)
GO
ALTER TABLE t_sello
	ADD CONSTRAINT cod_sello
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE t_situaciones_profesionales
	ADD CONSTRAINT id_situacion
	PRIMARY KEY NONCLUSTERED (cod_situacion_profesional)
GO
ALTER TABLE t_tercero
	ADD CONSTRAINT tperso_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE t_tramite
	ADD CONSTRAINT pk_id_tramite
	PRIMARY KEY (id_tramite)
GO
ALTER TABLE t_transporte_comunicados
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (cod_transporte_comunicados)
GO
ALTER TABLE t_traspaso_iva
	ADD CONSTRAINT t_traspaso_iva_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE t_usos
	ADD CONSTRAINT pk_t_usos
	PRIMARY KEY NONCLUSTERED (cod_uso)
GO
ALTER TABLE t_usuario_grupos
	ADD CONSTRAINT pk_grupos
	PRIMARY KEY NONCLUSTERED (cod_usuario, cod_grupo)
GO
ALTER TABLE t_usuario
	ADD CONSTRAINT t_usuario_x
	PRIMARY KEY NONCLUSTERED (cod_usuario)
GO
ALTER TABLE tarifas_coeficientes
	ADD CONSTRAINT pk_t_coef
	PRIMARY KEY NONCLUSTERED (id)
GO
ALTER TABLE tarifas_importes
	ADD CONSTRAINT pk_id_tarifa_informe
	PRIMARY KEY NONCLUSTERED (id)
GO
ALTER TABLE tarifas_informes_x_tramite
	ADD CONSTRAINT pk
	PRIMARY KEY (id)
GO
ALTER TABLE tarifas_superficie
	ADD CONSTRAINT pk_sup
	PRIMARY KEY (id)
GO
ALTER TABLE tarifas_tipo_act
	ADD CONSTRAINT pl
	PRIMARY KEY (id_tarifa)
GO
ALTER TABLE tarifas_tipo_obra
	ADD CONSTRAINT pk_tipo_obra
	PRIMARY KEY (id)
GO
ALTER TABLE testupdater
	ADD CONSTRAINT testupdater_x
	PRIMARY KEY NONCLUSTERED (id_testupdater)
GO
ALTER TABLE tipo_act_familia
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE tipo_cargo
	ADD CONSTRAINT pk_codigo
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE tipo_fases
	ADD CONSTRAINT tipo_fases
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE tipo_inhabilitacion
	ADD CONSTRAINT pk_tipo_inhabilitacion
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE tipo_registro
	ADD CONSTRAINT tipo_registro_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE tipos_envio_visared
	ADD CONSTRAINT id_tipo_envio_x
	PRIMARY KEY (id_tipo_envio)
GO
ALTER TABLE tipos_facturas
	ADD CONSTRAINT pk_tipos_facturas
	PRIMARY KEY (codigo)
GO
ALTER TABLE tipos_honorarios
	ADD CONSTRAINT pk
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE tipos_trabajos
	ADD CONSTRAINT tipo_trabajos_x
	PRIMARY KEY NONCLUSTERED (c_t_trabajo)
GO
ALTER TABLE tipos_via
	ADD CONSTRAINT tipos_via_x
	PRIMARY KEY NONCLUSTERED (cod_tipo_via)
GO
ALTER TABLE titulaciones
	ADD CONSTRAINT titulaciones_x
	PRIMARY KEY NONCLUSTERED (codigo)
GO
ALTER TABLE tmp_csd_fr_linea
	ADD CONSTRAINT pk_tmp_csd_fr_linea
	PRIMARY KEY (id_linea)
GO
ALTER TABLE tmp_sgc_140
	ADD CONSTRAINT tmp_empresas_x
	PRIMARY KEY (codigo)
GO
ALTER TABLE trabajos
	ADD CONSTRAINT trabajos_x
	PRIMARY KEY NONCLUSTERED (c_trabajo)
GO
ALTER TABLE tratamientos
	ADD CONSTRAINT descripcion
	PRIMARY KEY NONCLUSTERED (descripcion)
GO
ALTER TABLE var_globales
	ADD CONSTRAINT var_globales_copy_x
	PRIMARY KEY NONCLUSTERED (nombre)
GO
ALTER TABLE web_colegiados
	ADD CONSTRAINT PK_id_web
	PRIMARY KEY NONCLUSTERED (id_web)
GO
ALTER TABLE web_estilos
	ADD CONSTRAINT web_estilos_x
	PRIMARY KEY NONCLUSTERED (id_estilo)
GO
ALTER TABLE web_paginas
	ADD CONSTRAINT web_paginas_x
	PRIMARY KEY NONCLUSTERED (id_pagina)
GO
ALTER TABLE web_plantillas
	ADD CONSTRAINT web_plantillas_x
	PRIMARY KEY NONCLUSTERED (id_plantilla)
go  
CREATE VIEW expedi_pto_seg (id_expedi,n_expedi,fase,pres_seguridad,id_fase,n_registro) AS SELECT fases.id_expedi, 
 fases.n_expedi, 
 fases.fase, 
 fases_usos.pres_seguridad, 
 fases.id_fase, 
 fases.n_registro 
 FROM fases, 
 fases_usos 
 WHERE ( fases.id_fase = fases_usos.id_fase ) and 
 ( ( fases.fase like '1%' ) ) 
go
CREATE VIEW fases_seg_pres (fase,id_fase,pres_seguridad) AS SELECT fases.fase, 
 fases.id_fase, 
 expedi_pto_seg.pres_seguridad 
 FROM fases, 
 expedi_pto_seg 
 WHERE ( fases.id_expedi = expedi_pto_seg.id_expedi ) and 
 ( ( expedi_pto_seg.pres_seguridad > 0 ) AND 
 ( fases.fase not like '1%' ) ) 
go
CREATE VIEW regsoc_socio (id_regsoc_socio,id_colegiado_sociedad,id_colegiado,nombre,cif,fecha_alta,fecha_baja,administrador,id_cliente,alta_baja,capital_social,porc_capital_social,cod_colegio,num_col_colegio_adscripcion,tipo,apellidos,poblacion_descripcion,cod_pob,cod_prov,cp,telefono,fax,colegio_procedencia,id_actividad,num_colegiado,direccion,representante,id_regsoc,porcent) AS SELECT id_regsoc_socio, id_col_soc, id_col_per, nombre, nif, f_inicio, f_final, administrador, id_cli_per, alta,
capital_social, porc_capital_social, cod_colegio, num_colegio_adscripcion, tipo, apellidos, poblacion_descripcion, 
cod_pob, cod_prov, cp, telefono, fax, colegio_procedencia, id_actividad, num_colegiado, direccion, representante,
id_regsoc, porcent
FROM sociedades 
go
CREATE VIEW vwCliente (id,nombre,apellidos,nif,f_nacimiento,email,sexto,tipo_via,nom_via,cp,cod_pob,tel,movil) AS select id_cliente as id, nombre, apellidos, nif, '' as f_nacimiento, email, sexo, tipo_via, nombre_via as nom_via, cp, cod_pob, telefono as te, '' as movill from clientes
go
CREATE VIEW vwColegiado (id,nombre,apellidos,nif,f_nacimiento,email,sexto,tipo_via,nom_via,cp,cod_pob,tel,movil) AS select colegiados.id_colegiado as id, nombre, apellidos, nif, f_nacimiento, email,
sexo, tipo_via, nom_via,cp, cod_pob,tel, movil from colegiados, domicilios where colegiados.id_colegiado = domicilios.id_colegiado 
go

dump tran sicap02 with truncate_only  
go  
dump tran sicap02 with truncate_only  
go  
dump tran sicap02 with truncate_only  
go  
dump tran sicap02 with truncate_only  
go  
dump tran sicap02 with truncate_only  
go  
dump tran sicap02 with truncate_only  
go  
dump tran sicap02 with truncate_only  
go  
dump tran sicap02 with truncate_only  
go  
dump tran sicap02 with truncate_only  
go  
dump tran sicap02 with truncate_only  
go  
dump tran sicap03 with truncate_only  
go  
dump tran sicap03 with truncate_only  
go  
dump tran sicap03 with truncate_only  
go  
dump tran sicap03 with truncate_only  
go  
dump tran sicap03 with truncate_only  
go  
dump tran sicap03 with truncate_only  
go  
dump tran sicap03 with truncate_only  
go  
