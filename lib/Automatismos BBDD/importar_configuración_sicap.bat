@echo off
cls
Title Importación de tablas de negocio SICAP
:server
cls
Echo Nombre del servidor=
set /p server=ucp-tst-02
if "%server%"=="" set server=ucp-tst-02

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
if "%database%"=="" set database=sicap01

:ruta_base
cls
Echo Seleccione el colegio que desee importar
echo
echo 1. COAAT Alicante
echo 2. COAAT Ávila
echo 3. COAAT Bizkaia
echo 4. COAAT Burgos
echo 5. COAAT Caceres
echo 6. COAAT Cuenca
echo 7. COAAT Gipuzkoa
echo 8. COAAT Gran Canaria
echo 9. COAAT Guadalajara
echo 10. COAAT Leon
echo 11. COAAT Lleida
echo 12. COAAT Mallorca
echo 13. COAAT Murcia
echo 14. COAAT Navarra
echo 15. COAAT Rioja
echo 16. COAAT Tarragona
echo 17. COAAT Tenerife
echo 18. COAAT Terres
echo 19. COAAT Teruel
echo 20. COAAT Zaragoza
echo 21. Configuración por defecto
echo 22. Salir
 
set /p menup=Escribe el número de la opcion elegida (Sin punto): 
if %menup%==1 set ruta_base=..\src\resources\COAAT_Alicante
if %menup%==2 set ruta_base=..\src\resources\COAAT_Avila
if %menup%==3 set ruta_base=..\src\resources\COAAT_Bizkaia
if %menup%==4 set ruta_base=..\src\resources\COAAT_Burgos
if %menup%==5 set ruta_base=..\src\resources\COAAT_Caceres
if %menup%==6 set ruta_base=..\src\resources\COAAT_Cuenca
if %menup%==7 set ruta_base=..\src\resources\COAAT_Gipuzkoa
if %menup%==8 set ruta_base=..\src\resources\COAAT_Gran_Canaria
if %menup%==9 set ruta_base=..\src\resources\COAAT_Guadalajara
if %menup%==10 set ruta_base=..\src\resources\COAAT_Leon
if %menup%==11 set ruta_base=..\src\resources\COAAT_Lleida
if %menup%==12 set ruta_base=..\src\resources\COAAT_Mallorca
if %menup%==13 set ruta_base=..\src\resources\COAAT_Murcia
if %menup%==14 set ruta_base=..\src\resources\COAAT_Navarra
if %menup%==15 set ruta_base=..\src\resources\COAAT_LaRioja
if %menup%==16 set ruta_base=..\src\resources\COAAT_Tarragona
if %menup%==17 set ruta_base=..\src\resources\COAAT_Tenerife
if %menup%==18 set ruta_base=..\src\resources\COAAT_Terres
if %menup%==19 set ruta_base=..\src\resources\COAAT_Teruel
if %menup%==20 set ruta_base=..\src\resources\COAAT_Zaragoza
if %menup%==21 set ruta_base=.\src\resources\datos\
if %menup%==22 exit else goto error


if "%ruta_base%"=="" set ruta_base=.\datos\
set ruta_base=%ruta_base%\Carga_datos_BD\

rem echo %ruta_base%

echo Asegurese de eliminar las tablas antes de realizar el proceso
echo Creando script para borrar las tablas
isql -U%user% -P%password% -S %server%  -D%database% < script_drop_table.sql >> drop_table.txt
FINDSTR /v row drop_table.txt  >drop_table_2.txt
echo go >> drop_table_2.txt

isql -U%user% -P%password% -S %server%  >> log.txt -D%database% < drop_table_2.txt


echo ¿Desea continuar? (y/n) :
set /p valor=
if %valor%== n goto fin

:inicio
del drop_table_2.txt
del drop_table.txt

echo Cargando schema de base de datos
isql -U%user% -P%password% -S %server%  >> log.txt -D%database% < %ruta_base%schema.sql 

ECHO dump tran %database% with truncate_only >> indices.sql 
echo go >>indices.sql 

echo Cargando indices
isql -U%user% -P%password% -S %server%  >> log.txt -D%database% < indices.sql 


echo Realizando insert de tablas básicas
isql -U%user% -P%password% -S %server%  >> log.txt -D%database% < insert.sql 

echo ¿Desea continuar? (y/n) :
set /p valor=
if %valor%== n goto fin


echo Ruta base %ruta_base%
echo bcp de tablas
:in

bcp %database%..almacen_almacenes in %ruta_base%almacen_almacenes.txt -c -e error.txt -e error.txt -b10  -U%user% -P%password% -S %server% >> log.txt  
bcp %database%..almacen_tipos in %ruta_base%almacen_tipos.txt -c -e almacen_tipos_error.txt -b10  -U%user% -P%password% -S %server% >> log.txt 
bcp %database%..asesoria_juridica_medio in %ruta_base%asesoria_juridica_medio.txt -c -e error.txt -b10  -U%user% -P%password% -S %server% >> log.txt
bcp %database%..asesoria_juridica_procedencia in %ruta_base%asesoria_juridica_procedencia.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..asesoria_tipo_asuntos in %ruta_base%asesoria_tipo_asuntos.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..bt_idiomas in %ruta_base%bt_idiomas.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..bt_nivel in %ruta_base%bt_nivel.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..bt_tipo_bolsa in %ruta_base%bt_tipo_bolsa.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..bt_demandas_tipo in %ruta_base%bt_demandas_tipo.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
echo bt_demandas_tipo >>log.txt
bcp %database%..c_geograficos in %ruta_base%c_geograficos.txt -c -e c_geograficos_error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cabecera in %ruta_base%cabecera.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..callejero in %ruta_base%callejero.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cargos in %ruta_base%cargos.txt -c -e cargos_error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cartas in %ruta_base%cartas.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cierre in %ruta_base%cierre.txt -c -e cierre_error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cip_tablas in %ruta_base%cip_tablas.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cip_tarifa in %ruta_base%cip_tarifa.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cip_tipo_act in %ruta_base%cip_tipo_act.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..ciudades in %ruta_base%ciudades.txt -c -e ciudades_error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coaatll_dip in %ruta_base%coaatll_dip.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coef_ipc in %ruta_base%coef_ipc.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
echo Tarifas COAATMallorca >>log.txt
bcp %database%..coaatmca_coef_b in %ruta_base%coaatmca_coef_b.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coaatmca_coef_c in %ruta_base%coaatmca_coef_c.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coaatmca_coeficientes in %ruta_base%coaatmca_coeficientes.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coaatmca_dv in %ruta_base%coaatmca_dv.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coaatmca_tipologia_edif in %ruta_base%coaatmca_tipologia_edif.txt -c -e error.txt -b10 -U%user% -P%password% -S %server% >> log.txt
echo Tarifas COAATCC >>log.txt
bcp %database%..coaatcc_ho_tablas in %ruta_base%coaatcc_ho_tablas.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coaatcc_ho_tarifas in %ruta_base%coaatcc_ho_tarifas.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..coaatcc_ho_tarifas_contenidos in %ruta_base%coaatcc_ho_tarifas_contenidos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
echo colegios
echo colegios >>log.txt
bcp %database%..colegios in %ruta_base%colegios.txt -c -e colegios_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..colegios_matriculas in %ruta_base%colegios_matriculas.txt -c -e error.txt -U%user% -P%password% -S%server% >> log.txt
bcp %database%..colindantes in %ruta_base%colindantes.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..colores in %ruta_base%colores.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..comunidad_autonoma in %ruta_base%comunidad_autonoma.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..configura_campos in %ruta_base%configura_campos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..configura_insercion in %ruta_base%configura_insercion.txt -c -e error.txt -U%user% -P%password% -S%server% >> log.txt
bcp %database%..consultas in %ruta_base%consultas.txt -c -e consultas_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..consultas_datos in %ruta_base%consultas_datos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..contadores in %ruta_base%contadores.txt -c -e contadores_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_conexion_bd in %ruta_base%csd_conexion_bd.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_doc_modulo in %ruta_base%csd_doc_modulo.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
echo csd_doc_modulo >>log.txt
bcp %database%..csd_seg_ip in %ruta_base%csd_seg_ip.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_seg_ip_exclusion in %ruta_base%csd_seg_ip_exclusion.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_seg_tipo_idioma in %ruta_base%csd_seg_tipo_idioma.txt -c -e error.txt -U%user% -P%password% -S%server% >> log.txt
bcp %database%..csd_sms in %ruta_base%csd_sms.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_sms_bd_perfil in %ruta_base%csd_sms_bd_perfil.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_sms_campanya in %ruta_base%csd_sms_campanya.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_sms_campos in %ruta_base%csd_sms_campos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_sms_grupos in %ruta_base%csd_sms_grupos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_sms_grupos_detalle in %ruta_base%csd_sms_grupos_detalle.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_sms_predefinidos in %ruta_base%csd_sms_predefinidos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csd_sms_programado in %ruta_base%csd_sms_programado.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_aeat_periodo in %ruta_base%csi_aeat_periodo.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_aeat_registro_contador in %ruta_base%csi_aeat_registro_contador.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_aeat_t_libro_iva in %ruta_base%csi_aeat_t_libro_iva.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_art_serv_correspo in %ruta_base%csi_art_serv_correspo.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_articulos_servicios in %ruta_base%csi_articulos_servicios.txt -c -e csi_articulos_servicios_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_asientos_predefinidos in %ruta_base%csi_asientos_predefinidos.txt -c -e csi_articulos_servicios_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_balances in %ruta_base%csi_balances.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_balances_a_p_balance in %ruta_base%csi_balances_a_p_balance.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_balances_cuentas_especial in %ruta_base%csi_balances_cuentas_especial.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_balances_etcpn_columnas in %ruta_base%csi_balances_etcpn_columnas.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_balances_fun_especial in %ruta_base%csi_balances_fun_especial.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_balances_pyg_mes in %ruta_base%csi_balances_pyg_mes.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_balances_t_balance in %ruta_base%csi_balances_t_balance.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_bancos in %ruta_base%csi_bancos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_bancos_maestro in %ruta_base%csi_bancos_maestro.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_centros in %ruta_base%csi_centros.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_centros_intragrupo in %ruta_base%csi_centros_intragrupo.txt -c -e csi_centros_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_claves_retencion in %ruta_base%csi_claves_retencion.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_columnas_importe in %ruta_base%csi_columnas_importe.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_control_ejercicios in %ruta_base%csi_control_ejercicios.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_datos_economicos_anyo in %ruta_base%csi_datos_economicos_anyo.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_diarios_parametrizaciones in %ruta_base%csi_diarios_parametrizaciones.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_ejercicios_abiertos in %ruta_base%csi_ejercicios_abiertos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_elems_inmov_grupo in %ruta_base%csi_elems_inmov_grupo.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_elems_inmov_tipo_baja in %ruta_base%csi_elems_inmov_tipo_baja.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_elems_inmov_tipo_natura in %ruta_base%csi_elems_inmov_tipo_natura.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_elems_inmov_ubicacion in %ruta_base%csi_elems_inmov_ubicacion.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_empresas in %ruta_base%csi_empresas.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_equiv_copia_empresa in %ruta_base%csi_equiv_copia_empresa.txt -c -e csi_empresas_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_fact_reclamaciones_tipos in %ruta_base%csi_fact_reclamaciones_tipos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_familias in %ruta_base%csi_familias.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_formas_de_pago in %ruta_base%csi_formas_de_pago.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_formas_de_pago_correspo in %ruta_base%csi_formas_de_pago_correspo.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_formulas_asientos_prede in %ruta_base%csi_formulas_asientos_prede.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_lineas_asientos_prede in %ruta_base%csi_lineas_asientos_prede.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_meses in %ruta_base%csi_meses.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_npgc_tablas_modif in %ruta_base%csi_npgc_tablas_modif.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_param_facturas in %ruta_base%csi_param_facturas.txt -c -e csi_param_facturas_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_param_sigescon in %ruta_base%csi_param_sigescon.txt -c -e csi_param_sigescon_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_prorrata_empresa in %ruta_base%csi_prorrata_empresa.txt -c -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_proyectos in %ruta_base%csi_proyectos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_relacion_cuentas_npgc in %ruta_base%csi_relacion_cuentas_npgc.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_series in %ruta_base%csi_series.txt -c -e csi_series_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_aprobacion in %ruta_base%csi_t_aprobacion.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_asientos in %ruta_base%csi_t_asientos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_asientos_predefinidos in %ruta_base%csi_t_asientos_predefinidos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_conciliacion in %ruta_base%csi_t_conciliacion.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_destinatario_347 in %ruta_base%csi_t_destinatario_347.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_documento in %ruta_base%csi_t_documento.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_estado_pago in %ruta_base%csi_t_estado_pago.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_evaluacion in %ruta_base%csi_t_evaluacion.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_t_iva in %ruta_base%csi_t_iva.txt -c -e csi_t_iva_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_tipo_presupuesto in %ruta_base%csi_tipo_presupuesto.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..csi_trimestres in %ruta_base%csi_trimestres.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cuentas in %ruta_base%cuentas.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..cuentas_pyme in %ruta_base%cuentas_pyme.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..delegaciones in %ruta_base%delegaciones.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..demarcaciones in %ruta_base%demarcaciones.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..departamentos in %ruta_base%departamentos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..desc_gui_coefs in %ruta_base%desc_gui_coefs.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..desc_gui_pem in %ruta_base%desc_gui_pem.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..desc_gui_tipo_act in %ruta_base%desc_gui_tipo_act.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..descuentos_visared in %ruta_base%descuentos_visared.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..devoluciones_motivos in %ruta_base%devoluciones_motivos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..domiciliaciones_formatos in %ruta_base%domiciliaciones_formatos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..dv_sobre_pem in %ruta_base%dv_sobre_pem.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..dv_tipo_act in %ruta_base%dv_tipo_act.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..equivalencias in %ruta_base%equivalencias.txt -c -e equivalencias_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..escuela in %ruta_base%escuela.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..est_tipo_act in %ruta_base%est_tipo_act.txt -c -e est_tipo_act_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..est_tipo_act_tipo_obra_f in %ruta_base%est_tipo_act_tipo_obra_f.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..est_tipo_obra in %ruta_base%est_tipo_obra.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..expedientes_estado in %ruta_base%expedientes_estado.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt

bcp %database%..fases_admin_jud_tipos_rec in %ruta_base%fases_admin_jud_tipos_rec.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..fases_finales_acciones_realiza in %ruta_base%fases_finales_acciones_realiza.txt -c -e fases_finales_acciones_realiza_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..fases_incompatibilidades in %ruta_base%fases_incompatibilidades.txt -c -e fases_incompatibilidades_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..fases_renuncias_desglose in %ruta_base%fases_renuncias_desglose.txt -c -e fases_renuncias_desglose_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..fases_minutas_cartas in %ruta_base%fases_minutas_cartas.txt -c -e fases_minutas_cartas_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..fases_minutas_cartas_grupos in %ruta_base%fases_minutas_cartas_grupos.txt -c -e fases_minutas_cartas_grupos_error.txt -U%user% -P%password% -S %server% >> log.txt
echo fases_minutas_cartas >>log.txt

bcp %database%..formacion_areas_materias in %ruta_base%formacion_areas_materias.txt -c -e formacion_areas_materias_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..formacion_estados in %ruta_base%formacion_estados.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..formacion_mant_test in %ruta_base%formacion_mant_test.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..formacion_subtipo_conv in %ruta_base%formacion_subtipo_conv.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..formacion_test in %ruta_base%formacion_test.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..formacion_titulacion in %ruta_base%formacion_titulacion.txt -c -e formacion_titulacion_error.txt -U%user% -P%password% -S %server% >> log.txt

bcp %database%..gcw_archivo in %ruta_base%gcw_archivo.txt -c -e gcw_archivo_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_aviso in %ruta_base%gcw_aviso.txt -c -e gcw_aviso_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_colegio in %ruta_base%gcw_colegio.txt -c -e gcw_colegio_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_idioma_eti in %ruta_base%gcw_idioma_eti.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_modulo in %ruta_base%gcw_modulo.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_parametro in %ruta_base%gcw_parametro.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_perfil in %ruta_base%gcw_perfil.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_preferencia in %ruta_base%gcw_preferencia.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_registro in %ruta_base%gcw_registro.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_registro_perfil in %ruta_base%gcw_registro_perfil.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_tipo_archivo in %ruta_base%gcw_tipo_archivo.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_usuario in %ruta_base%gcw_usuario.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..gcw_usuario_perfil in %ruta_base%gcw_usuario_perfil.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt

echo gcw_usuario_perfil 

bcp %database%..grupos in %ruta_base%grupos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..ho_contenidos in %ruta_base%ho_contenidos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..ho_parametros in %ruta_base%ho_parametros.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..ho_tablas in %ruta_base%ho_tablas.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..ho_tarifas in %ruta_base%ho_tarifas.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..ho_tarifas_contenidos in %ruta_base%ho_tarifas_contenidos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..hon_tablas in %ruta_base%hon_tablas.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..honos_tablas_gui in %ruta_base%honos_tablas_gui.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..ivajulio2010 in %ruta_base%ivajulio2010.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
echo ivajulio2010 >>log.txt
bcp %database%..incidencias_expedientes in %ruta_base%incidencias_expedientes.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..incidencias_familias in %ruta_base%incidencias_familias.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..libros_ubicaciones in %ruta_base%libros_ubicaciones.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..listados in %ruta_base%listados.txt -c -e listados_error.txt -U%user% -P%password% -S %server% >> log.txt
echo menu
bcp %database%..menu in %ruta_base%menu.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..meses in %ruta_base%meses.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..messages in %ruta_base%messages.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..messages_ca in %ruta_base%messages_ca.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..modalidades in %ruta_base%modalidades.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..municipios in %ruta_base%municipios.txt -c -e municipios_error.txt -U%user% -P%password% -S %server% >> log.txt

bcp %database%..musaat_asistencia in %ruta_base%musaat_asistencia.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_cias_aseguradoras in %ruta_base%musaat_cias_aseguradoras.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_cober_exceso in %ruta_base%musaat_cober_exceso.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_cober_peritos in %ruta_base%musaat_cober_peritos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_cober_src in %ruta_base%musaat_cober_src.txt -c -e usaat_cober_src_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_cober_tasadores in %ruta_base%musaat_cober_tasadores.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_coef_c in %ruta_base%musaat_coef_c.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_coef_col in %ruta_base%musaat_coef_col.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_coef_g in %ruta_base%musaat_coef_g.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_coef_k in %ruta_base%musaat_coef_k.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_desc_porc_part in %ruta_base%musaat_desc_porc_part.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_src_estado in %ruta_base%musaat_src_estado.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_src_t_poliza in %ruta_base%musaat_src_t_poliza.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_tarifa_e in %ruta_base%musaat_tarifa_e.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_tarifas in %ruta_base%musaat_tarifas.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_tipo_visado in %ruta_base%musaat_tipo_visado.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_tipologia in %ruta_base%musaat_tipologia.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..musaat_tipos_oo in %ruta_base%musaat_tipos_oo.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt

bcp %database%..notificaciones in %ruta_base%notificaciones.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..origen_inhabilitacion in %ruta_base%origen_inhabilitacion.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..otros_conceptos in %ruta_base%otros_conceptos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..paises in %ruta_base%paises.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..personalidad_juridica in %ruta_base%personalidad_juridica.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..plantillas in %ruta_base%plantillas.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..plantillas_campos in %ruta_base%plantillas_campos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..plantillas_campos_extra in %ruta_base%plantillas_campos_extra.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..poblaciones in %ruta_base%poblaciones.txt -c -e poblaciones_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..poblaciones_zonas in %ruta_base%poblaciones_zonas.txt -c -e poblaciones_zonas_error.txt -U%user% -P%password% -S %server% >> log.txt
echo poblaciones_zonas
echo poblaciones_zonas >>log.txt
bcp %database%..premaat_grupo in %ruta_base%premaat_grupo.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..premaat_parentesco in %ruta_base%premaat_parentesco.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..premaat_situacion in %ruta_base%premaat_situacion.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..premaat_tablas in %ruta_base%premaat_tablas.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..premaat_tipo_mut in %ruta_base%premaat_tipo_mut.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..premaat_tipo_pres in %ruta_base%premaat_tipo_pres.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..provincias in %ruta_base%provincias.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
echo registro_series >>log.txt
bcp %database%..registro_series in %ruta_base%registro_series.txt -c -e registro_series_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..registro_t_comunicado in %ruta_base%registro_t_comunicado.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..regsoc_tipo_entrada_agenda in %ruta_base%regsoc_tipo_entrada_agenda.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..regsoc_tipo_forma_juridica in %ruta_base%regsoc_tipo_forma_juridica.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..regsoc_tipo_registro_mercantil in %ruta_base%regsoc_tipo_registro_mercantil.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..regsoc_tipo_sancion in %ruta_base%regsoc_tipo_sancion.txt -c -e error.txt -U%user% -P%password% -S%server% >> log.txt
bcp %database%..sini_damnificados in %ruta_base%sini_damnificados.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..sini_estimacion_economica in %ruta_base%sini_estimacion_economica.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..sini_tipo_danyos in %ruta_base%sini_tipo_danyos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..sini_tipo_estado_obra in %ruta_base%sini_tipo_estado_obra.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..sini_tipo_reclamacion in %ruta_base%sini_tipo_reclamacion.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_agrupaciones in %ruta_base%t_agrupaciones.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_altas_bajas_situaciones in %ruta_base%t_altas_bajas_situaciones.txt -c -e t_altas_bajas_situaciones_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_aplicacion in %ruta_base%t_aplicacion.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_control_eventos in %ruta_base%t_control_eventos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_descripcion_fases in %ruta_base%t_descripcion_fases.txt -c -e error.txt -U%user% -P%password% -S%server% >> log.txt
bcp %database%..t_destinos in %ruta_base%t_destinos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_documentos in %ruta_base%t_documentos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_domicilios in %ruta_base%t_domicilios.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_fases in %ruta_base%t_fases.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_fases_finales in %ruta_base%t_fases_finales.txt -c -e t_fases_finales_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_gestion in %ruta_base%t_gestion.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_grupo in %ruta_base%t_grupo.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_grupo_permisos in %ruta_base%t_grupo_permisos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_incompatibilidad in %ruta_base%t_incompatibilidad.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_informes in %ruta_base%t_informes.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_laboratorio in %ruta_base%t_laboratorio.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_orientaciones_profesionales in %ruta_base%t_orientaciones_profesionales.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_preguntas in %ruta_base%t_preguntas.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_promotor in %ruta_base%t_promotor.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_promotor_grupos in %ruta_base%t_promotor_grupos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_reparos_fases in %ruta_base%t_reparos_fases.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_sello in %ruta_base%t_sello.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_sello_posiciones in %ruta_base%t_sello_posiciones.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_sello_textos in %ruta_base%t_sello_textos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_situaciones_profesionales in %ruta_base%t_situaciones_profesionales.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_tercero in %ruta_base%t_tercero.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_tramite in %ruta_base%t_tramite.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_transporte_comunicados in %ruta_base%t_transporte_comunicados.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_traspaso_iva in %ruta_base%t_traspaso_iva.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_usos in %ruta_base%t_usos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..t_usuario_grupos in %ruta_base%t_usuario_grupos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tarifas_coeficientes in %ruta_base%tarifas_coeficientes.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tarifas_importes in %ruta_base%tarifas_importes.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tarifas_informes_x_tramite in %ruta_base%tarifas_informes_x_tramite.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tarifas_superficie in %ruta_base%tarifas_superficie.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tarifas_tipo_act in %ruta_base%tarifas_tipo_act.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tarifas_tipo_obra in %ruta_base%tarifas_tipo_obra.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
echo tipo_act_familia
echo tipo_act_familia >> log.txt
bcp %database%..tipo_act_familia in %ruta_base%tipo_act_familia.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tipo_cargo in %ruta_base%tipo_cargo.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tipo_fases in %ruta_base%tipo_fases.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tipo_inhabilitacion in %ruta_base%tipo_inhabilitacion.txt -c -e error.txt -U%user% -P%password% -S%server% >> log.txt
bcp %database%..tipo_registro in %ruta_base%tipo_registro.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
echo tipo_registro >> log.txt
bcp %database%..tipos_envio_visared in %ruta_base%tipos_envio_visared.txt -c -e error.txt -U%user% -P%password% -S%server% >> log.txt
bcp %database%..tipos_facturas in %ruta_base%tipos_facturas.txt -c -e tipos_facturas_error.txt -U%user% -P%password% -S %server% >> log.txt
echo tipos_facturas >> log.txt
bcp %database%..tipos_honorarios in %ruta_base%tipos_honorarios.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tipos_trabajos in %ruta_base%tipos_trabajos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tipos_via in %ruta_base%tipos_via.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..titulaciones in %ruta_base%titulaciones.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..trabajos in %ruta_base%trabajos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..tratamientos in %ruta_base%tratamientos.txt -c -e error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..var_globales in %ruta_base%var_globales.txt -c -e var_globales_error.txt -U%user% -P%password% -S %server% >> log.txt
echo web_ayuda >> log.txt
bcp %database%..web_ayuda in %ruta_base%web_ayuda.txt -c -e web_ayuda_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..web_colegiados in %ruta_base%web_colegiados.txt -c -e web_colegiados_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..web_estilos in %ruta_base%web_estilos.txt -c -e web_estilos_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..web_paginas in %ruta_base%web_paginas.txt -c -e web_paginas_error.txt -U%user% -P%password% -S %server% >> log.txt
bcp %database%..web_plantillas in %ruta_base%web_plantillas.txt -c -e web_plantillas_error.txt -U%user% -P%password% -S %server% >> log.txt
echo carga completada

:updater
echo Se configura el updater

echo master..sp_dboption %database%, "ddl in tran", true  >> updater.txt
echo go >>updater.txt
echo CHECKPOINT >>updater.txt
echo go >>updater.txt
isql -U%user% -P%password% -S %server%  >> log.txt -D%database% < updater.txt

echo ¿Desea continuar? (y/n) :
set /p valor=
if %valor%== n goto fin
echo comprobamos si existe la tabla 

echo IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'csd_conf_parametro')>> create_updater.txt
echo BEGIN>> create_updater.txt
echo Se crea la tabla de  csd_conf_parametro utilizada por el updater
echo CREATE TABLE csd_conf_parametro ( id_parametro varchar(45) NOT NULL, codigo varchar(45) NULL, id_empresa varchar(45) NULL,cod_tipo_producto varchar(45) NULL, id_tipo_modulo varchar(45) NULL,cod_tipo_configuracion varchar(45) NULL, id_aplicacion varchar(45) NULL,descripcion varchar(45) NULL, valor_texto varchar(45) NULL,valor_numerico varchar(45) NULL,valor_fecha datetime NULL) >> create_updater.txt
echo ALTER TABLE csd_conf_parametro add constraint pk_id_parametro primary key nonclustered (id_parametro) >> create_updater.txt
echo END >> create_updater.txt
echo go >> create_updater.txt

isql -U%user% -P%password% -S %server%  >> log.txt -D%database% < create_updater.txt

echo ¿Desea continuar? (y/n) :
set /p valor=
if %valor%== n goto fin

echo Introduzca la versión que utilizará el updater de referencia para los script ejemplo '5.3.2.3': 
set /p version_u=
if "%version_u%"=="" set version_u='5.3.2.3'

echo INSERT INTO csd_conf_parametro (id_parametro, codigo, valor_texto, descripcion) VALUES ('g_from_version', 'g_from_version',%version_u%,'Versión en que se encuentra la base de datos para el control de actualizaciones') >> insert_updater.txt
echo go >> insert_updater.txt
isql -U%user% -P%password% -S %server%  >> log.txt -D%database% < insert_updater.txt

echo ¿Desea continuar? (y/n) :
set /p valor=
if %valor%== n goto fin

echo Indique la ruta del csd_updater ejemplo D:\Csd_updater\  ruta: 
set /p ruta_updater=


echo Indique la ruta_sql ejemplo (D:\SICAP_SVN\trunk\src\sql):
set /p ruta_sql=
if "%ruta_sql%"=="" set user= D:\SICAP_SVN\trunk\src\sql

echo %ruta_updater%CSD.ConsoleUpdater.exe %ruta_sql% 1 %server% 5000 sa '' %database%
echo ¿Desea continuar? (y/n) Para ejecutar el csd_updater :
set /p valor=
if %valor%== n goto fin

start %ruta_updater%CSD.ConsoleUpdater.exe %ruta_sql% 1 %server% 5000 sa '' %database%
start  c:\temp\log.txt
echo Proceso finalizado

:fin
del updater.txt
del insert_updater.txt
del create_updater.txt
pause > nul

:error
echo Se produjo un error