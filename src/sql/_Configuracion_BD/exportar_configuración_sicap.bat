@echo off
cls
Title Importación de tablas de negocio SICAP
:server
cls
Echo Nombre del servidor=
set /p server=
if "%server%"=="" set server=db-tst-04

:usuario
cls
Echo Nombre de usuario=
set /p user=sa
if "%user%"=="" set user=sa

:Password
cls
Echo password=
set /p password=
echo %password%

:database
cls
Echo database=
set /p database=
if "%database%"=="" set database=sicap_mallorca

:version
Echo se obtiene la versión de la base de datos según versión de aplicación

echo select count(*) from sysobjects where type= 'U' and name='csd_conf_parametro'  >> existe_tabla.txt 
echo go>> existe_tabla.txt
isql -U%user% -P%password% -S %server%  >> log.txt -D%database% < existe_tabla.txt >> existe_tabla1.txt
FINDSTR [0-3]  existe_tabla1.txt |FINDSTR /v row >> existe_tabla2.txt 
for /f "tokens=1" %%a in (existe_tabla2.txt ) do (set  existe=%%a)
echo El valor de %existe%

if %existe%== 0 ( goto version_minima)
if %existe%== 1 ( goto conf_parametro)

:conf_parametro
echo select valor_texto  from csd_conf_parametro  >> version.txt 
echo go >> version.txt
isql -U%user% -P%password% -S %server%  >> log.txt -D%database% < version.txt >> version_1.txt
FINDSTR [0-3]  version_1.txt |FINDSTR /v row >> version_2.txt 
for /f "tokens=1" %%a in (version_2.txt ) do (set  version=%%a)


:version_minima
echo select texto  from var_globales where nombre= 'g_version_minima'  >> version3.txt 
echo go >> version3.txt
isql -U%user% -P%password% -S %server%  >> log.txt -D%database% < version3.txt >> version_4.txt
FINDSTR [0-3]  version_4.txt |FINDSTR /v row >> version_5.txt 
for /f "tokens=1" %%a in (version_5.txt ) do (set  version=%%a)



:continua
echo Los datos son  %version%
echo ¿Desea continuar? (y/n) :
set /p valor=
if %valor%== n goto fin


:Schema
Echo se obtiene el equema de base de datos %database%
echo select  right('create table dbo.' + so1.name + '(' + '', 255 * ( abs( sign(sc1.colid - 1) - 1 ) ) )+ >> schema_sql.sql
echo sc1.name + ' ' + >> schema_sql.sql
echo st1.name + ' ' + >> schema_sql.sql
echo substring( '(' + rtrim( convert( char, sc1.length ) ) + ') ', 1,>> schema_sql.sql
echo patindex('%char', st1.name ) * 10 ) +>> schema_sql.sql
echo substring( '(' + rtrim( convert( char, sc1.prec ) ) + ', ' + rtrim( >> schema_sql.sql
echo convert( char, sc1.scale ) ) + ') ' , 1, patindex('numeric', st1.name ) * 10 ) + >> schema_sql.sql
echo substring( 'NOT NULL', ( convert( int, convert( bit,( sc1.status ^& 8 ) ) ) * 4 ) + 1, >> schema_sql.sql
echo 8 * abs(convert(bit, (sc1.status ^& 0x80)) - 1 ) ) + >> schema_sql.sql
echo right('identity ', 9 * convert(bit, (sc1.status ^& 0x80)) ) + >> schema_sql.sql
echo right(',', 5 * ( convert(int,sc2.colid) - convert(int,sc1.colid) ) ) +>> schema_sql.sql
echo right(' )' +  '' + '', 255 * abs( sign( ( convert(int,sc2.colid) - convert(int,sc1.colid) ) )>> schema_sql.sql
echo  -1 ) )>> schema_sql.sql
echo from sysobjects so1, >> schema_sql.sql
echo syscolumns sc1,>> schema_sql.sql
echo syscolumns sc2,>> schema_sql.sql
echo systypes st1 >> schema_sql.sql
echo where so1.type = 'U'>> schema_sql.sql
echo and sc1.id = so1.id>> schema_sql.sql
echo and st1.usertype = sc1.usertype>> schema_sql.sql
echo and sc2.id = sc1.id>> schema_sql.sql
echo and sc2.colid = (select max(colid) from syscolumns where id = sc1.id)>> schema_sql.sql
echo order by so1.name, sc1.colid>> schema_sql.sql
echo go >> schema_sql.sql

isql -U%user% -P%password% -S %server%  >> log.txt -D%database% < schema_sql.sql >> schema_sql_2.sql
:: Se reconstruye el fichero
FINDSTR [2-n]  schema_sql_2.sql |FINDSTR /v row >> %version%.sql
echo go >> %version%.sql

echo ¿Desea continuar? (y/n) :
set /p valor=
if %valor%== n goto fin

:: Borrado de ficheros
del schema_sql_2.sql
del schema_sql.sql
del version_2.txt
del version_1.txt
del version.txt

:sp_configure
Echo se obtiene el fichero de configuracion de la bd sp_configure
echo sp_configure  >> sp_configure.txt 
echo go >> sp_configure.txt
isql -U%user% -P%password% -S %server%  >> log.txt  < sp_configure.txt >> sp_configure.txt

:ruta_base
cls
Echo Nombre del ruta_base=
set /p ruta_base=.\datos
if "%ruta_base%"=="" set ruta_base=".\datos"
set ruta_base=%ruta_base%\

Echo se procede a obtener los bcp

:out
bcp %database%..almacen_almacenes out %ruta_base%almacen_almacenes.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..almacen_tipos out %ruta_base%almacen_tipos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..asesoria_juridica_medio out %ruta_base%asesoria_juridica_medio.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..asesoria_juridica_procedencia out %ruta_base%asesoria_juridica_procedencia.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..asesoria_tipo_asuntos out %ruta_base%asesoria_tipo_asuntos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..bt_idiomas out %ruta_base%bt_idiomas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..bt_nivel out %ruta_base%bt_nivel.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..bt_tipo_bolsa out %ruta_base%bt_tipo_bolsa.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..bt_demandas_tipo out %ruta_base%bt_demandas_tipo.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..c_geograficos out %ruta_base%c_geograficos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cabecera out %ruta_base%cabecera.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..callejero out %ruta_base%callejero.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cargos out %ruta_base%cargos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cartas out %ruta_base%cartas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cierre out %ruta_base%cierre.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cip_tablas out %ruta_base%cip_tablas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cip_tarifa out %ruta_base%cip_tarifa.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cip_tipo_act out %ruta_base%cip_tipo_act.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..ciudades out %ruta_base%ciudades.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coaatll_dip out %ruta_base%coaatll_dip.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coaatmca_coef_b out %ruta_base%coaatmca_coef_b.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coaatmca_coef_c out %ruta_base%coaatmca_coef_c.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coaatmca_coeficientes out %ruta_base%coaatmca_coeficientes.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coaatmca_dv out %ruta_base%coaatmca_dv.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coaatmca_tipologia_edif out %ruta_base%coaatmca_tipologia_edif.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coaatcc_ho_tablas out %ruta_base%coaatcc_ho_tablas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coaatcc_ho_tarifas out %ruta_base%coaatcc_ho_tarifas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coaatcc_ho_tarifas_contenidos out %ruta_base%coaatcc_ho_tarifas_contenidos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coef_ipc out %ruta_base%coef_ipc.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..colegios out %ruta_base%colegios.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..colegios_matriculas out %ruta_base%colegios_matriculas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..colindantes out %ruta_base%colindantes.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..colores out %ruta_base%colores.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..comunidad_autonoma out %ruta_base%comunidad_autonoma.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_doc_modulo out %ruta_base%csd_doc_modulo.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..configura_campos out %ruta_base%configura_campos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..configura_insercion out %ruta_base%configura_insercion.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..consultas out %ruta_base%consultas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..consultas_datos out %ruta_base%consultas_datos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..contadores out %ruta_base%contadores.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_conexion_bd out %ruta_base%csd_conexion_bd.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_seg_ip out %ruta_base%csd_seg_ip.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_seg_ip_exclusion out %ruta_base%csd_seg_ip_exclusion.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_seg_tipo_idioma out %ruta_base%csd_seg_tipo_idioma.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_sms out %ruta_base%csd_sms.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_sms_bd_perfil out %ruta_base%csd_sms_bd_perfil.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_sms_campanya out %ruta_base%csd_sms_campanya.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_sms_campos out %ruta_base%csd_sms_campos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_sms_grupos out %ruta_base%csd_sms_grupos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_sms_grupos_detalle out %ruta_base%csd_sms_grupos_detalle.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_sms_predefinidos out %ruta_base%csd_sms_predefinidos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_sms_programado out %ruta_base%csd_sms_programado.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_aeat_periodo out %ruta_base%csi_aeat_periodo.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_aeat_registro_contador out %ruta_base%csi_aeat_registro_contador.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_aeat_t_libro_iva out %ruta_base%csi_aeat_t_libro_iva.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_art_serv_correspo out %ruta_base%csi_art_serv_correspo.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_articulos_servicios out %ruta_base%csi_articulos_servicios.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_asientos_predefinidos out %ruta_base%csi_asientos_predefinidos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_balances out %ruta_base%csi_balances.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_balances_a_p_balance out %ruta_base%csi_balances_a_p_balance.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_balances_cuentas_especial out %ruta_base%csi_balances_cuentas_especial.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_balances_etcpn_columnas out %ruta_base%csi_balances_etcpn_columnas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_balances_fun_especial out %ruta_base%csi_balances_fun_especial.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_balances_pyg_mes out %ruta_base%csi_balances_pyg_mes.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_balances_t_balance out %ruta_base%csi_balances_t_balance.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_bancos out %ruta_base%csi_bancos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_bancos_maestro out %ruta_base%csi_bancos_maestro.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_centros out %ruta_base%csi_centros.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_centros_intragrupo out %ruta_base%csi_centros_intragrupo.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_claves_retencion out %ruta_base%csi_claves_retencion.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_columnas_importe out %ruta_base%csi_columnas_importe.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_control_ejercicios out %ruta_base%csi_control_ejercicios.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_datos_economicos_anyo out %ruta_base%csi_datos_economicos_anyo.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_diarios_parametrizaciones out %ruta_base%csi_diarios_parametrizaciones.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_ejercicios_abiertos out %ruta_base%csi_ejercicios_abiertos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_elems_inmov_grupo out %ruta_base%csi_elems_inmov_grupo.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_elems_inmov_tipo_baja out %ruta_base%csi_elems_inmov_tipo_baja.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_elems_inmov_tipo_natura out %ruta_base%csi_elems_inmov_tipo_natura.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_elems_inmov_ubicacion out %ruta_base%csi_elems_inmov_ubicacion.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_empresas out %ruta_base%csi_empresas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_empresas_logos out %ruta_base%csi_empresas_logos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_equiv_copia_empresa out %ruta_base%csi_equiv_copia_empresa.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_fact_reclamaciones_tipos out %ruta_base%csi_fact_reclamaciones_tipos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_familias out %ruta_base%csi_familias.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_formas_de_pago out %ruta_base%csi_formas_de_pago.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_formas_de_pago_correspo out %ruta_base%csi_formas_de_pago_correspo.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_formulas_asientos_prede out %ruta_base%csi_formulas_asientos_prede.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_lineas_asientos_prede out %ruta_base%csi_lineas_asientos_prede.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_meses out %ruta_base%csi_meses.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_npgc_tablas_modif out %ruta_base%csi_npgc_tablas_modif.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_param_facturas out %ruta_base%csi_param_facturas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_param_sigescon out %ruta_base%csi_param_sigescon.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_prorrata_empresa out %ruta_base%csi_prorrata_empresa.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_proyectos out %ruta_base%csi_proyectos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_relacion_cuentas_npgc out %ruta_base%csi_relacion_cuentas_npgc.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_series out %ruta_base%csi_series.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_aprobacion out %ruta_base%csi_t_aprobacion.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_asientos out %ruta_base%csi_t_asientos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_asientos_predefinidos out %ruta_base%csi_t_asientos_predefinidos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_conciliacion out %ruta_base%csi_t_conciliacion.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_destinatario_347 out %ruta_base%csi_t_destinatario_347.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_documento out %ruta_base%csi_t_documento.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_estado_pago out %ruta_base%csi_t_estado_pago.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_evaluacion out %ruta_base%csi_t_evaluacion.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_iva out %ruta_base%csi_t_iva.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_tipo_presupuesto out %ruta_base%csi_tipo_presupuesto.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_trimestres out %ruta_base%csi_trimestres.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cuentas out %ruta_base%cuentas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cuentas_pyme out %ruta_base%cuentas_pyme.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..delegaciones out %ruta_base%delegaciones.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..demarcaciones out %ruta_base%demarcaciones.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..departamentos out %ruta_base%departamentos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..desc_gui_coefs out %ruta_base%desc_gui_coefs.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..desc_gui_pem out %ruta_base%desc_gui_pem.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..desc_gui_tipo_act out %ruta_base%desc_gui_tipo_act.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..descuentos_visared out %ruta_base%descuentos_visared.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..devoluciones_motivos out %ruta_base%devoluciones_motivos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..domiciliaciones_formatos out %ruta_base%domiciliaciones_formatos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..dv_sobre_pem out %ruta_base%dv_sobre_pem.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..dv_tipo_act out %ruta_base%dv_tipo_act.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..equivalencias out %ruta_base%equivalencias.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..escuela out %ruta_base%escuela.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..est_tipo_act out %ruta_base%est_tipo_act.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..est_tipo_act_tipo_obra_f out %ruta_base%est_tipo_act_tipo_obra_f.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..est_tipo_obra out %ruta_base%est_tipo_obra.txt -c -U%user% -P%password% -S %server% >> log.txt

bcp %database%..expedientes_estado out %ruta_base%expedientes_estado.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..fases_admin_jud_tipos_rec out %ruta_base%fases_admin_jud_tipos_rec.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..fases_finales_acciones_realiza out %ruta_base%fases_finales_acciones_realiza.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..fases_incompatibilidades out %ruta_base%fases_incompatibilidades.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..fases_renuncias_desglose out %ruta_base%fases_renuncias_desglose.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..fases_minutas_cartas out %ruta_base%fases_minutas_cartas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..fases_minutas_cartas_grupos out %ruta_base%fases_minutas_cartas_grupos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..formacion_areas_materias out %ruta_base%formacion_areas_materias.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..formacion_estados out %ruta_base%formacion_estados.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..formacion_mant_test out %ruta_base%formacion_mant_test.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..formacion_subtipo_conv out %ruta_base%formacion_subtipo_conv.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..formacion_test out %ruta_base%formacion_test.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..formacion_titulacion out %ruta_base%formacion_titulacion.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_archivo out %ruta_base%gcw_archivo.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_aviso out %ruta_base%gcw_aviso.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_colegio out %ruta_base%gcw_colegio.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_idioma_eti out %ruta_base%gcw_idioma_eti.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_modulo out %ruta_base%gcw_modulo.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_parametro out %ruta_base%gcw_parametro.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_perfil out %ruta_base%gcw_perfil.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_preferencia out %ruta_base%gcw_preferencia.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_registro out %ruta_base%gcw_registro.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_registro_perfil out %ruta_base%gcw_registro_perfil.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_tipo_archivo out %ruta_base%gcw_tipo_archivo.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_usuario out %ruta_base%gcw_usuario.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_usuario_perfil out %ruta_base%gcw_usuario_perfil.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..grupos out %ruta_base%grupos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..ho_contenidos out %ruta_base%ho_contenidos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..ho_parametros out %ruta_base%ho_parametros.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..ho_tablas out %ruta_base%ho_tablas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..ho_tarifas out %ruta_base%ho_tarifas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..ho_tarifas_contenidos out %ruta_base%ho_tarifas_contenidos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..hon_tablas out %ruta_base%hon_tablas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..honos_tablas_gui out %ruta_base%honos_tablas_gui.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..honos_tarifa_gui out %ruta_base%honos_tarifa_gui.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..incidencias_expedientes out %ruta_base%incidencias_expedientes.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..incidencias_familias out %ruta_base%incidencias_familias.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..ivajulio2010 out %ruta_base%ivajulio2010.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..libros_ubicaciones out %ruta_base%libros_ubicaciones.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..listados out %ruta_base%listados.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..menu out %ruta_base%menu.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..meses out %ruta_base%meses.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..messages out %ruta_base%messages.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..messages_ca out %ruta_base%messages_ca.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..modalidades out %ruta_base%modalidades.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..municipios out %ruta_base%municipios.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_asistencia out %ruta_base%musaat_asistencia.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_cias_aseguradoras out %ruta_base%musaat_cias_aseguradoras.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_cober_exceso out %ruta_base%musaat_cober_exceso.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_cober_peritos out %ruta_base%musaat_cober_peritos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_cober_src out %ruta_base%musaat_cober_src.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_cober_tasadores out %ruta_base%musaat_cober_tasadores.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_coef_c out %ruta_base%musaat_coef_c.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_coef_col out %ruta_base%musaat_coef_col.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_coef_g out %ruta_base%musaat_coef_g.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_coef_k out %ruta_base%musaat_coef_k.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_desc_porc_part out %ruta_base%musaat_desc_porc_part.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_src_estado out %ruta_base%musaat_src_estado.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_src_t_poliza out %ruta_base%musaat_src_t_poliza.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_tarifa_e out %ruta_base%musaat_tarifa_e.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_tarifas out %ruta_base%musaat_tarifas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_tipo_visado out %ruta_base%musaat_tipo_visado.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_tipologia out %ruta_base%musaat_tipologia.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_tipos_oo out %ruta_base%musaat_tipos_oo.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..notificaciones out %ruta_base%notificaciones.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..origen_inhabilitacion out %ruta_base%origen_inhabilitacion.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..otros_conceptos out %ruta_base%otros_conceptos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..paises out %ruta_base%paises.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..personalidad_juridica out %ruta_base%personalidad_juridica.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..plantillas out %ruta_base%plantillas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..plantillas_campos out %ruta_base%plantillas_campos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..plantillas_campos_extra out %ruta_base%plantillas_campos_extra.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..poblaciones out %ruta_base%poblaciones.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..poblaciones_zonas out %ruta_base%poblaciones_zonas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..premaat_grupo out %ruta_base%premaat_grupo.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..premaat_parentesco out %ruta_base%premaat_parentesco.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..premaat_situacion out %ruta_base%premaat_situacion.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..premaat_tablas out %ruta_base%premaat_tablas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..premaat_tipo_mut out %ruta_base%premaat_tipo_mut.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..premaat_tipo_pres out %ruta_base%premaat_tipo_pres.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..provincias out %ruta_base%provincias.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..registro_series out %ruta_base%registro_series.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..registro_t_comunicado out %ruta_base%registro_t_comunicado.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..regsoc_tipo_entrada_agenda out %ruta_base%regsoc_tipo_entrada_agenda.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..regsoc_tipo_forma_juridica out %ruta_base%regsoc_tipo_forma_juridica.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..regsoc_tipo_registro_mercantil out %ruta_base%regsoc_tipo_registro_mercantil.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..regsoc_tipo_sancion out %ruta_base%regsoc_tipo_sancion.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..sini_damnificados out %ruta_base%sini_damnificados.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..sini_estimacion_economica out %ruta_base%sini_estimacion_economica.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..sini_tipo_danyos out %ruta_base%sini_tipo_danyos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..sini_tipo_estado_obra out %ruta_base%sini_tipo_estado_obra.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..sini_tipo_reclamacion out %ruta_base%sini_tipo_reclamacion.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_agrupaciones out %ruta_base%t_agrupaciones.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_altas_bajas_situaciones out %ruta_base%t_altas_bajas_situaciones.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_aplicacion out %ruta_base%t_aplicacion.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_control_eventos out %ruta_base%t_control_eventos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_descripcion_fases out %ruta_base%t_descripcion_fases.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_destinos out %ruta_base%t_destinos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_documentos out %ruta_base%t_documentos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_domicilios out %ruta_base%t_domicilios.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_fases out %ruta_base%t_fases.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_fases_finales out %ruta_base%t_fases_finales.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_gestion out %ruta_base%t_gestion.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_grupo out %ruta_base%t_grupo.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_grupo_permisos out %ruta_base%t_grupo_permisos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_incompatibilidad out %ruta_base%t_incompatibilidad.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_informes out %ruta_base%t_informes.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_laboratorio out %ruta_base%t_laboratorio.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_mensaje out %ruta_base%t_mensaje.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_orientaciones_profesionales out %ruta_base%t_orientaciones_profesionales.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_permisos out %ruta_base%t_permisos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_preguntas out %ruta_base%t_preguntas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_promotor out %ruta_base%t_promotor.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_promotor_grupos out %ruta_base%t_promotor_grupos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_reparos_fases out %ruta_base%t_reparos_fases.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_sello out %ruta_base%t_sello.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_sello_posiciones out %ruta_base%t_sello_posiciones.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_sello_textos out %ruta_base%t_sello_textos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_situaciones_profesionales out %ruta_base%t_situaciones_profesionales.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_tercero out %ruta_base%t_tercero.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_tramite out %ruta_base%t_tramite.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_transporte_comunicados out %ruta_base%t_transporte_comunicados.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_traspaso_iva out %ruta_base%t_traspaso_iva.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_usos out %ruta_base%t_usos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_usuario out %ruta_base%t_usuario.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_usuario_grupos out %ruta_base%t_usuario_grupos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tarifas_coeficientes out %ruta_base%tarifas_coeficientes.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tarifas_importes out %ruta_base%tarifas_importes.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tarifas_informes_x_tramite out %ruta_base%tarifas_informes_x_tramite.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tarifas_superficie out %ruta_base%tarifas_superficie.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tarifas_tipo_act out %ruta_base%tarifas_tipo_act.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tarifas_tipo_obra out %ruta_base%tarifas_tipo_obra.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tipo_act_familia out %ruta_base%tipo_act_familia.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tipo_cargo out %ruta_base%tipo_cargo.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tipo_fases out %ruta_base%tipo_fases.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tipo_inhabilitacion out %ruta_base%tipo_inhabilitacion.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tipo_registro out %ruta_base%tipo_registro.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tipos_envio_visared out %ruta_base%tipos_envio_visared.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tipos_facturas out %ruta_base%tipos_facturas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tipos_honorarios out %ruta_base%tipos_honorarios.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tipos_trabajos out %ruta_base%tipos_trabajos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tipos_via out %ruta_base%tipos_via.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..titulaciones out %ruta_base%titulaciones.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..trabajos out %ruta_base%trabajos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tratamientos out %ruta_base%tratamientos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..var_globales out %ruta_base%var_globales.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..web_ayuda out %ruta_base%web_ayuda.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..web_colegiados out %ruta_base%web_colegiados.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..web_estilos out %ruta_base%web_estilos.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..web_paginas out %ruta_base%web_paginas.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..web_plantillas out %ruta_base%web_plantillas.txt -c -U%user% -P%password% -S %server% >> log.txt

:fin
echo fin, pulse una tecla
pause > nul