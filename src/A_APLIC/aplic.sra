HA$PBExportHeader$aplic.sra
$PBExportComments$Generated Application Object
forward
global type aplic from application
end type
global n_tr sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
// Aplicaci$$HEX1$$f300$$ENDHEX$$n Manager
n_cst_aplic_appmanager gnv_app

n_tr bd_ejercicio
n_tr g_perfil_externo
datetime g_fecha_sms

// Apunte
st_apunte g_apunte

// T$$HEX1$$ed00$$ENDHEX$$tulo de la Aplicaci$$HEX1$$f300$$ENDHEX$$n
String g_titulo 

// Icono de la aplicacion
String g_icono
String g_debug = '0'

// Objeto para el manejo de ficheros
n_cst_filesrvwin32 gnv_fichero
u_csd_sql gnv_sql

//Objeto Cambio IVA Julio 2010
n_csd_ivajulio2010 gnv_ivajulio2010

//Objeto Validaciones Bancarias
n_csd_control_cuentas_bancarias gnv_control_cuentas_bancarias

// T$$HEX1$$ed00$$ENDHEX$$tulos de los listados
String g_etiquetas_listados, g_parametros_listados
int g_num_params_listados
String g_titulo_listados_superior, g_titulo_listados_inferior

string g_presidente, g_tesorero, g_secretario, g_gerente

// Usuario
string g_usuario,g_usuarios_usar_ges_con
integer g_usuarios_dias,g_usuarios_fallos
string g_idioma_defecto

//Colegio
string g_colegio, g_titulo_aplicacion, g_col_provincia, g_colegio_n_provincial
string g_colegio_n_subprovincias, g_col_ciudad, g_col_telefono, g_col_nif, g_col_fax

// Datos Colegio para cartas
string g_nombre_colegio_carta, g_direc_colegio_carta, g_pobla_colegio_carta, g_email_colegio_carta



// Musaat
double g_col_coef_musaat, g_musaat_coef_poliza_plus, g_musaat_recargo_prima
string g_col_codigo_musaat, g_obra_admin_sgc, g_obra_admin_cgc, g_musaat_aplica_calculo_pc_2015
string g_obra_admin_cgc_aplica_10, g_musaat_tabla_desc_activa, g_musaat_verifica_prima_aviso
double g_aplica_musaat_dcto, g_musaat_coef_colindantes2m, g_musaat_factor_doble_condicion 
datastore gds_musaat_movimientos_a_facturar

// CIP
double g_porc_cip_defecto, g_porc_cip_sgc, g_porc_cip_admon

// C$$HEX1$$f300$$ENDHEX$$digos terceros
st_terceros_codigos g_terceros_codigos

//Delegacion
string g_cod_delegacion

// Moneda Ejercicio
string moneda_ejercicio

// A$$HEX1$$f100$$ENDHEX$$o Ejercicio
string g_ejercicio

// Empresa
string g_empresa
//A$$HEX1$$f100$$ENDHEX$$adir el logo y web de la empresa en la carta de notificaci$$HEX1$$f300$$ENDHEX$$n
string g_logo_empresa, g_telefono_empresa,g_fax_empresa
string g_web_empresa
string g_email_empresa

// Multiempresa
string g_activa_multiempresa
string g_clientes_utiliza_multiempresa

//Parametrizaci$$HEX1$$f300$$ENDHEX$$n de facturas
string g_facts_colegio_colegiado

// Directorio
string g_directorio, g_directorio_fotos, g_directorio_rtf, g_directorio_e_s
string g_directorio_actas, g_directorio_generados, g_directorio_docs_expedi
string g_directorio_docs_fases, g_directorio_imagenes, g_dir_aplicacion
string g_ruta_acrobat_reader, g_ruta_word, g_ruta_email, g_ruta_imagenes
string g_directorio_documentos_fases, g_directorio_documentos_plantillas

// Base de datos
string g_tipo_base_datos='1'

// Textos en los botones
boolean g_textos_en_botones

// Mostrar boton de Cabecera/Pie de p$$HEX1$$e100$$ENDHEX$$gina
boolean g_piedepagina

// Mostrar nombre variable o espacios al combinar un documento RTF
boolean g_combino_vble_rtf

// Control de modificaciones colegiados
boolean g_recien_grabado_modificacion
boolean g_recien_grabado_situacion

// Control de modificaciones expedientes
boolean g_recien_grabado_modificacion_exped

// Control de modificaciones fases
boolean g_recien_grabado_modificacion_fases

// Variables para los m$$HEX1$$f300$$ENDHEX$$dulos
w_sheet g_w_lista, g_w_detalle
u_dw g_dw_lista
string  g_lista, g_detalle
boolean gb_nuevo=False

// B$$HEX1$$fa00$$ENDHEX$$squeda
st_busqueda g_busqueda

// Otras variables globales
string cr='~r~n'
string tabulador='~t'

string g_preasignar_principio
string g_niveles_visible

double g_fa // Coeficiente Fsuba
double g_CA
double g_CP

//st_informes g_informes //preinformes
string g_nif_cliente    //Se utiliza para cuando el Nif no existe, abrir el Detalle Cliente
double g_suma_porcentajes_col,g_suma_porcentajes_cli
string g_art_honorarios, g_art_aportaciones, g_art_src // para no mostrarlo en la ventana de c$$HEX1$$e100$$ENDHEX$$lculo de informes
string g_permitir_expedi_sin_numero
string g_visar_con_reparos // Permite o no permite el que se vise una fase que tenga reparos pendientes.
u_dw g_dw_fases_minutas,g_dw_fases_estados,g_dw_fases_colegiados,g_dw_fases_clientes, g_dw_lista2
string g_fases_estado
string g_t_iva_defecto
statictext g_st  //Para actualizar el contador de registros de lista de fases
string g_id_fase
double g_tasa_minima
string g_asignar_n_visado//controla si se activar$$HEX2$$e1002000$$ENDHEX$$el chech de asignar n$$HEX2$$ba002000$$ENDHEX$$visado en la ventana del Visto Bueno

// VARIABLES GLOBALES DE PARAMETRIZACION
//..referentes a facturas
//string g_facts_colegio_cliente, g_facts_colegio_colegiado
//string g_informe_factura
string g_modo_liquidaciones
//..referentes a notificaciones
string g_notif_texto1,g_notif_texto2,g_notif_texto3
//..referentes a transferencias
/*string g_directorio_domiciliaciones*/
string g_informe_talon
string g_localidad_empresa 
//..referentes a la aplicacion
string g_existe_contabilidad
//..referentes a contabilidad
string g_t_doc_src_sica,g_t_doc_recibos_sica
st_conta g_conta
string g_diario_domiciliaciones
boolean g_colegiados_cta_iva = false, g_colegiados_cta_retvol = false
string g_cambiar_signo_apuntes_importe_negativo
string g_aplica_pem_seg
//=======================
//Calculo de iva fact
string g_calculo_iva_fact

// M$$HEX1$$f300$$ENDHEX$$dulo cobros
w_sheet g_lista_cobros
u_dw g_dw_lista_cobros

// M$$HEX1$$f300$$ENDHEX$$dulo seguridad
w_sheet g_detalle_usuarios, g_lista_usuarios
u_dw g_dw_lista_usuarios
st_usuarios_consulta g_usuarios_consulta

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de colegiados
w_sheet g_lista_colegiados, g_detalle_colegiados
u_dw    g_dw_lista_colegiados
st_colegiados_consulta     g_colegiados_consulta

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de libros
w_sheet g_lista_libros, g_detalle_libros
u_dw    g_dw_lista_libros
st_libro_busqueda  g_libros_consulta
//w_libros_consulta g_w_libros_consulta

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de actas
string g_cod_actas  
w_sheet g_lista_actas, g_detalle_actas
u_dw    g_dw_lista_actas
//st_actas_consulta g_actas_consulta

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de listas
w_sheet g_lista_listas, g_detalle_listas
u_dw    g_dw_lista_listas
st_listas_consulta g_listas_consulta

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de certificados
w_sheet g_lista_certificados, g_detalle_certificados
u_dw    g_dw_lista_certificados
//st_certificados_consulta g_certificados_consulta
st_certificados_busqueda g_certificados_busqueda
st_certificados_registos g_cer_reg
string g_ruta_rtf
st_certificados_paso_param g_rtf_paso_param

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de registros
w_sheet g_lista_registros, g_detalle_registros, g_detalle_listados
u_dw    g_dw_lista_registros
st_registros_consulta g_registros_consulta
st_registros_expedientes g_reg_exp
string g_f_registro_es  //Para el control de la fecha de registro.

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de clientes
w_sheet g_lista_clientes, g_detalle_clientes
u_dw    g_dw_lista_clientes
st_clientes_consulta g_clientes_consulta

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de circulares
string g_cod_circulares
w_sheet g_lista_circulares, g_detalle_circulares
u_dw    g_dw_lista_circulares
//st_circulares_consulta g_circulares_consulta

// Variables del m$$HEX1$$f300$$ENDHEX$$dulo de bolsa de trabajo
w_sheet g_lista_bolsa_trabajo, g_detalle_bolsa_trabajo
u_dw    g_dw_lista_bolsa_trabajo
//st_bolsa_trabajo_consulta g_bolsa_trabajo_consulta

//Variables m$$HEX1$$f300$$ENDHEX$$dulo de Expedientes
w_sheet g_lista_expedientes, g_detalle_expedientes
u_dw    g_dw_lista_expedientes
st_expedientes_consulta g_expedientes_consulta
//st_expedientes_busqueda g_expedientes_busqueda

//Variables m$$HEX1$$f300$$ENDHEX$$dulo de Fases
w_sheet g_lista_fases, g_detalle_fases
u_dw    g_dw_lista_fases,g_dw_fases_informes,g_dw1, g_dw_impresos
st_fases_consulta       g_fases_consulta
st_fases_busqueda       g_fases_busqueda
st_formas_pago g_formas_pago
st_fases_inicio			g_fases_inicio

string g_contratos_preasignados

// Estructura global para conceptos
st_codigos_conceptos g_codigos_conceptos

//Modulo de SRC
w_sheet g_lista_src, g_detalle_src
u_dw    g_dw_lista_src
//st_src_consulta g_src

//Variables m$$HEX1$$f300$$ENDHEX$$dulo de Reparos 
w_sheet g_lista_reparos
u_dw    g_dw_lista_reparos
st_fases_tipo_reparo g_fases_tipo_reparo
st_incidencias g_incidencias

//Variables m$$HEX1$$f300$$ENDHEX$$dulo de Facturaci$$HEX1$$f300$$ENDHEX$$n_emitida
w_sheet g_lista_facturacion_emitida, g_detalle_facturacion_emitida
u_dw    g_dw_lista_facturacion_emitida
st_facturacion_emitida_consulta g_facturacion_emitida_consulta
st_facturacion_emitida_importes g_facturacion_emitida_importes
string g_factu_e_reclamacion // CArta de reclamacion de las facturas
string g_facturas_negativas_serie
string g_serie_proforma
string g_facturas_n_colegiado // Se utiliza en la b$$HEX1$$fa00$$ENDHEX$$squeda de facturas 

//Variables Facturaci$$HEX1$$f300$$ENDHEX$$n (tipos de factura)
String g_colegio_colegiado, g_colegio_cliente, g_colegio_general, g_colegiado_cliente

//lineas de factura
string g_centro_por_defecto,g_explotacion_por_defecto
String g_t_iva_por_defecto, g_t_iva_00, g_t_iva_04, g_t_iva_07, g_t_iva_16, g_t_iva_exento

// Vbles. procedentes de Facturas
string g_etiqueta_empresa, g_nombre_empresa, g_cif_empresa 
string g_direccion_empresa, g_num_cuenta_colegio, g_entidad_deudora_remesas 
string g_directorio_domiciliaciones, g_directorio_transferencias  
string g_nombre_fichero_transferencias, g_diario_f_emitidas 
string g_t_doc_transferencia, g_t_doc_talon, g_t_doc_prov_pago
string g_t_doc_prov_irpf, g_t_doc_prov_dto, g_t_doc_prov_total 
string g_t_doc_prov_gastos, g_t_doc_prov_iva, g_t_doc_f_emitidas 
string g_t_doc_f_emitidas_icaro, g_t_doc_irpf, g_diario_f_recibidas 
string g_t_asiento_apuntes_automaticos, g_t_asiento_pago
string g_prefijo_clientes, g_prefijo_proveedores
int g_num_digitos, g_num_digitos_presup

// Banco y Forma pago
string g_banco_por_defecto, g_forma_pago_por_defecto

//IRPF
double g_irpf_por_defecto

// Serie por defecto para facturas emitidas desde FASES
string g_serie_fases

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de cursos de formacion
w_sheet g_lista_cursos_form, g_detalle_cursos_form
u_dw    g_dw_lista_cursos_form
st_cursos_form_consulta     g_cursos_form_consulta
string g_id_curso, g_borrar_mover
integer g_n_plazas,g_n_plazas_libres,g_n_lista_espera,g_n_res
boolean g_boton

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de ponentes, en formacion
w_sheet g_lista_ponentes, g_detalle_ponentes
u_dw    g_dw_lista_ponentes
//st_cursos_ponentes_consulta     g_ponentes_consulta

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de organizadores, en formacion
w_sheet g_lista_organizadores,g_detalle_organizadores
u_dw    g_dw_lista_organizadores
//st_cursos_organizadores_consulta     g_organizadores_consulta

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de asistentes, en formacion
w_sheet g_lista_asistentes, g_detalle_asistentes
u_dw    g_dw_lista_asistentes
st_asistentes_consulta     g_asistentes_consulta
//st_cursos_asistentes_consulta     g_asistentes_consulta

// Variables m$$HEX1$$f300$$ENDHEX$$dulo control de asistencia, en formacion
w_sheet g_lista_ctrlasistencia, g_detalle_ctrlasistencia
u_dw    g_dw_lista_ctrlasistencia
st_ctrlasistencias_consulta     g_ctrlasistencia_consulta
//st_cursos_ctrlasistencias_consulta     g_ctrlasistencia_consulta

// Variables m$$HEX1$$f300$$ENDHEX$$dulo BANCAJA, en formacion
w_sheet g_lista_bancaja, g_detalle_bancaja
u_dw    g_dw_lista_bancaja
//st_bancaja_consulta     g_bancaja_consulta

// Vbles Estado MODULO FASES
st_fases_estados g_fases_estados

// Modulo de PREMAAT
st_premaat_consulta g_premaat_consulta
u_dw g_dw_lista_premaat
w_sheet g_lista_premaat, g_detalle_premaat, g_premaat_calculo_cuotas, g_premaat_sabana
string g_calcular_cuota_alta_premaat='N'

// Modulo de MUSAAT
st_musaat_consulta g_musaat_consulta
u_dw g_dw_lista_musaat
w_sheet g_lista_musaat, g_detalle_musaat, g_musaat_calculo_recibos, g_musaat_situacion_asegurados
w_sheet g_musaat_recalculo_minutas
string g_serie_musaat

// Modulo de Movimiento MUSAAT
st_musaat_movimientos_consulta g_musaat_movimientos_consulta
u_dw g_dw_lista_movimientos_musaat
w_sheet g_lista_movimientos_musaat, g_detalle_movimientos_musaat

// M$$HEX1$$f300$$ENDHEX$$dulo de Minutas
string g_aplica_irpf_en_desplaza, g_aplica_irpf_en_garantia, g_cip_cgc_toda

// Obliga a cobrar pasando a la ventana de cobro un id_minuta
string g_cobro_obligado = 'N'

// ID de la minuta que se est$$HEX2$$e1002000$$ENDHEX$$modificando
string g_id_minuta_actual = ''
double g_desvio_moneda = 0

// Modulo de Reclamaciones de minutas
w_sheet g_lista_reclamaciones
u_dw g_dw_lista_reclamaciones
string g_abogado_colegio,g_estilo_carta

// Vbles Traspasos
//st_prefijos_cuentas_contables g_prefijos_cuentas_contables
string g_prefijo_arqui, g_prefijo_arqui_iva, g_prefijo_arqui_rf, g_prefijo_arqui_pendientes, g_prefijo_arqui_gasto
string g_cuenta_pago_prestaciones, g_cuenta_puente_descuadre, g_concepto_descuadre_caja, g_t_doc_descuadre

//Variables modulo Liquidaciones
w_sheet g_lista_liquidaciones, g_detalle_liquidaciones
u_dw    g_dw_lista_liquidaciones
string g_liquidacion_incluir_saldo_deudor, g_liquidar_facturas_pendientes
string g_hoja_liquidacion , g_hoja_liquidacion_manual, g_id_liquidacion, g_serie_liquidaciones
string g_nombre_empresa_csb, g_direccion_empresa_csb, g_consulta_actual_liquidaciones

// Variables de liquidaciones de PREMAAT
w_sheet g_lista_premaat_liquid
u_dw    g_dw_lista_premaat_liquid
string g_informe_talon_premaat, g_forma_pago_premaat, g_serie_premaat

//Variables modulo Apuntes
w_sheet g_lista_apuntes
u_dw    g_dw_lista_apuntes

// Variable para saber si estoy en pruebas
boolean g_pruebas = FALSE

// Libros
string g_codigo_libro_incidencias , g_codigo_libro_ordenes
st_fases_libros g_st_fases_libro

// Garantia
string g_forma_devolucion_garantia

// Modulo de Mensajeria
st_mensajes_consulta g_mensajes_consulta
st_mensajes_insercion g_mensajes_insercion
u_dw g_dw_lista_mensajes
w_sheet g_mensajes_enviados, g_mensajes_recibidos, g_mensajes_detalle

// Saldo deudor
string g_comprobar_saldo_deudor_col = 'N'

// Modulo VISARED
string g_directorio_temporal, g_directorio_importacion
string g_directorio_documentos_visared, g_directorio_importados
string g_directorio_defecto_otras_carpetas
//boolean g_recien_importado=false

// M$$HEX1$$f300$$ENDHEX$$dulo SELLADOR
w_sheet g_lista_sellado_visared, g_detalle_sellado_visared
u_dw    g_dw_lista_sellado_visared
st_sellado_visared g_st_sellado_visared_consulta
string g_directorio_certificados, g_directorio_im$$HEX1$$e100$$ENDHEX$$genes, g_directorio_acrobat
string g_prefijo_expediente = 'EXP', g_prefijo_registro = 'REG'
st_visared_importacion g_fase_visared
environment ge_environment
window g_firmador
//string g_directorio_pdf 
//string g_email_servidor = 'pacov@csd-systems.com'
//string g_paquete_temporal = 'temporal.zip'
//string g_n_colegiado
//string g_directorio_contratos
string g_revisar_firmas, g_directorio_firmas, g_revisar_certificados
string g_activar_revision_firmas = 'N' // Lo dejamos desactivado temporalmente hasta que se determine la forma correcta de activarlo
string g_directorio_sellos
string g_incorporar_zip_exp


// Resumen econ$$HEX1$$f300$$ENDHEX$$mico
w_sheet g_resumen_economico

// Domiciliaciones r$$HEX1$$e100$$ENDHEX$$pida
w_sheet g_domiciliaciones_rapida

// Regularizaci$$HEX1$$f300$$ENDHEX$$n contratos
st_datos_superficie g_st_datos_superficie

// M$$HEX1$$f300$$ENDHEX$$dulo Correspondencia, plantillas
w_sheet g_lista_plantillas, g_detalle_plantillas
u_dw    g_dw_lista_plantillas

string g_contabiliza_liquidacion_auto

// MOPU
w_sheet g_fomento

// Reparos
string g_carta_reparos, g_codigo_reparos_otros_doc

// Procesos de contabilizacion
w_sheet g_proceso_contabilizacion

// Extensiones Ficheros
string g_ext_f19, g_ext_csb34

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de siniestros
w_sheet g_lista_siniestros, g_detalle_siniestros
u_dw    g_dw_lista_siniestros
st_siniestros_consulta g_siniestros_consulta

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de demandas
w_sheet g_lista_demandas, g_detalle_demandas
u_dw    g_dw_lista_demandas
st_demandas_consulta g_demandas_consulta
double g_importe_ncol,g_importe_col
string g_cursos_control_asistentes

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de ofertas
w_sheet g_lista_ofertas, g_detalle_ofertas
u_dw    g_dw_lista_ofertas
st_ofertas_consulta g_ofertas_consulta

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de junta de gobierno, reuniones
w_sheet g_lista_jgreuniones, g_detalle_jgreuniones
u_dw    g_dw_lista_jgreuniones
st_jgreuniones_consulta g_jgreuniones_consulta
double g_jg_precio_hora,g_jg_precio_dieta
double g_jg_horas_ordinarias,g_jg_horas_extraordinarias

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de via administrativa judicial
w_sheet g_lista_ad_judicial, g_detalle_ad_judicial
u_dw    g_dw_lista_ad_judicial
st_ad_judicial_consulta g_ad_judicial_consulta

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de asesor$$HEX1$$ed00$$ENDHEX$$a jur$$HEX1$$ed00$$ENDHEX$$dica
w_sheet g_lista_as_juridica, g_detalle_as_juridica
u_dw    g_dw_lista_as_juridica
st_as_juridica_consulta g_as_juridica_consulta

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de finales de obra
w_sheet g_lista_final_obra, g_detalle_final_obra
u_dw    g_dw_lista_final_obra
st_final_obra_consulta g_final_obra_consulta

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de garantias
w_sheet g_lista_garantias, g_detalle_garantias, g_garantias_liquidaciones
u_dw    g_dw_lista_garantias
st_garantias_consulta g_garantias_consulta
string g_informe_talon_garantias

// CIP GC
double g_cc, g_cc_rs

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de ingresa_retira
w_sheet g_lista_ing_ret
u_dw g_dw_lista_ing_ret
string g_ing_ret_ingresa, g_ing_ret_retira, g_ing_ret_talon

// C$$HEX1$$e100$$ENDHEX$$lculo de cuota m$$HEX1$$ed00$$ENDHEX$$nima
w_sheet g_calculo_cuota_min

// Variable m$$HEX1$$f300$$ENDHEX$$dulo de devoluciones
w_sheet g_lista_devoluciones
string g_devoluciones_carta_reclamacion

// Variable m$$HEX1$$f300$$ENDHEX$$dulo de consejo
w_sheet g_visados_consejo

// Variable m$$HEX1$$f300$$ENDHEX$$dulo de arte cemento
w_sheet g_arte_cemento

// Variable m$$HEX1$$f300$$ENDHEX$$dulo de cobro mensual de musaat
w_sheet g_cobro_mensual_musaat

// Variable que almacena lo que ha devuelto la funci$$HEX1$$f300$$ENDHEX$$n f_factura
// Para que cuando se llama a la funci$$HEX1$$f300$$ENDHEX$$n f_factura desde otra funci$$HEX1$$f300$$ENDHEX$$n
// se pueda saber que es lo que devolvi$$HEX1$$f300$$ENDHEX$$.
// Se utiliza en el cobro mensual de musaat (COAATLR) para generar las domiciliaciones
string g_return_f_factura

// Cobros M$$HEX1$$fa00$$ENDHEX$$ltiples
string g_usa_cobros_multiples
w_sheet g_lista_cobros_multiples
u_dw g_dw_lista_cobros_multiples
string g_cobros_multiples_cuenta_puente

// Variable m$$HEX1$$f300$$ENDHEX$$dulo de actualizaci$$HEX1$$f300$$ENDHEX$$n masiva de conceptos domiciliables
w_sheet g_conceptos_domiciliables_lr

// Colegiado Comodin
string g_colegiado_comodin

// Carta Autoliquidacion
string g_informe_autoliquidacion

// Regularizaci$$HEX1$$f300$$ENDHEX$$n de Musaat
string g_no_regulariza_tres_meses

// Visared
string g_anyo_numeracion

//Contabilidad
string g_numeracion_unica_asientos, g_asiento_unico_cc
string g_digito_colegio_pro, g_aplica_concepto_ti

// COAATTFE
string g_musaat_colegiado
string g_fases_serie_musaat
string g_num_expedi_nulo

// Par$$HEX1$$e100$$ENDHEX$$metro para facturar Musaat aparte
string g_facturar_musaat_pc_serie_aparte

// COAATLR
string g_cobro_mensual_musaat_lr
string g_codigo_tipo_actuacion_control_calidad
// Para la contabilizacion automatica
boolean g_contabilidad_automatica
string g_cuenta_irpf_cliente_generica
string g_contabilidad_conjunta

// IRPF e IVA por colegio
string g_colegio_retiene_irpf, g_colegio_retiene_iva

// Visared
string g_directorio_fuentes 

// Musaat
string g_no_regulariza_nunca

// Version
string g_version_minima // Formato: yyyymmdd

// Vbles Traspasos
st_apuntes_tipos_doc g_sica_t_doc
st_apuntes_diarios g_sica_diario

// Sellador
string g_sellador_certificado, g_sellador_password

// Variable para acumular consultas
string g_consulta_actual 

// Visared
st_fases_consulta g_datos_fase
w_sheet gw_importacion_expedientes
boolean g_visared_activo

// Parametros consulta en listados
string g_ultima_consulta

// Variables para el modulo de reclamaciones de facturas emitidas
w_sheet g_detalle_reclamaciones
st_reclamaciones_facturas g_reclamaciones_facturas

// DV
double g_porc_dv_defecto

// Variable para el c$$HEX1$$f300$$ENDHEX$$digo del colegio
string g_cod_colegio

// Para la forma de pago PA
string g_cuenta_puente_pendiente_abono_hon, g_cuenta_puente_pendiente_abono_dv

// Asistente
st_asistente g_asistente

// Importacion de facturas
w_sheet g_importacion_facturas

// Extorno
w_sheet g_extorno

// Directorios para actualizaciones
string g_directorio_actualizaciones, g_directorio_temporales

// FTP 
boolean g_no_actualizar
string g_ftp_actualizaciones, g_puerto_actualizaciones
string g_login_actualizaciones, g_password_actualizaciones
string g_version, g_dir_actualizaciones

// Los ponemos como variables globales para pas$$HEX1$$e100$$ENDHEX$$rselos a la ventana de impresi$$HEX1$$f300$$ENDHEX$$n
u_csd_dw g_dw_capitulos, g_dw_variables

string g_firma_obligatoria
//st_cursos_dias g_st_cursos_dias

string g_sistema_mailing='N'

// Porcentaje Bonificaci$$HEX1$$f300$$ENDHEX$$n Musaat
double g_porc_bonif_musaat

// Coef. G para DIP
double g_dip_coef_g

//Vble que coge la f_abono como f_visado para sellar
string g_f_abono_es_visado 

//Vble para poder interrumpir el proceso de sellado y de importacion
boolean g_interrupt

// Verificador
string g_verificador_autonomo = 'N'

// Agrupar Actuaciones en Regularizaci$$HEX1$$f300$$ENDHEX$$n
string g_regularizacion_agrupar_act = 'N'

// Indica que si se calcula el porcentaje en base al importe nuevo
string g_regulariza_cip_porc_nuevo

// Variables m$$HEX1$$f300$$ENDHEX$$dulo de aparatos t$$HEX1$$e900$$ENDHEX$$cnicos
w_sheet g_lista_aparatos_tecnicos, g_detalle_aparatos_tecnicos
u_dw    g_dw_lista_aparatos_tecnicos
st_aparatos_tecnicos_consulta  g_aparatos_tecnicos_consulta

string g_comfia

// Variable para el c$$HEX1$$f300$$ENDHEX$$digo de provincia del colegio
string g_cod_prov_colegio 

integer g_temporizador=600

// Porcentaje Bonificaci$$HEX1$$f300$$ENDHEX$$n Premaat
double g_porc_bonif_premaat

// Directorio para documentos de calidad
string g_directorio_calidad

// Listados liquidaciones (honorarios y otros pagos)
string g_listado_liquid_honos, g_listado_liquid_otros_pagos, g_listado_talones_otros_pagos

// Traspaso Saldos Musaat
w_sheet g_traspaso_saldos_musaat

// Variable para cobrar la cip en proporci$$HEX1$$f300$$ENDHEX$$n a la musaat en las obras oficiales
string g_obra_admin_cip_sobre_src

//Variable para almacenar los campos subsanados del importador
st_eimporta_campos_subsanados  g_campos_subsanados

// Variable para el prefijo de la cuenta bancaria de los colegiados en Alicante
string g_prefijo_cuenta_bancaria_col, g_digito_cta_colegiado, g_digito_cta_sociedades_col

string g_directorio_verificacion

//Variables modula Salidas Caja
w_sheet g_lista_caja_salidas
u_dw g_dw_lista_caja_salidas

//Variables modulo Almacen
w_sheet g_lista_almacen
u_dw g_dw_lista_almacen
w_sheet g_detalle_almacen
string g_almacen_consulta

// Directorio informes econ$$HEX1$$f300$$ENDHEX$$micos y carpeta facturas no de fases
string g_directorio_informes_economicos, g_directorio_otras_facturas

// N$$HEX1$$fa00$$ENDHEX$$mero m$$HEX1$$e100$$ENDHEX$$ximo de a$$HEX1$$f100$$ENDHEX$$os para la consulta de reclamaciones de avisos de factura
integer g_anyos_reclam_avisos

// Directorio para curr$$HEX1$$ed00$$ENDHEX$$culums (bolsa trabajo)
string g_directorio_bt

// Aviso paquetes nuevos
string g_aviso_paquetes_nuevos

// Porcentaje descuento para DV en contratos visared
double g_porc_dv_descuento_visared

// Variables m$$HEX1$$f300$$ENDHEX$$dulo regsoc
w_sheet g_lista_regsoc, g_detalle_regsoc
u_dw    g_dw_lista_regsoc
string g_regsoc_consulta
string g_modo_funcionamiento,g_directorio_ficheros

//  Comprobar al abrir la aplicacion si existen cuotas colegiales para colegiados mayores de 65 a$$HEX1$$f100$$ENDHEX$$os
string g_comprobar_mas_65

// Variables globales para la seleccion del formato de impresi$$HEX1$$f300$$ENDHEX$$n
st_csd_seleccion_formato_impresion g_formato_impresion,g_formato_impresion_visared
string g_enviar_email_facturacion_clientes

// Porcentaje gastos por gesti$$HEX1$$f300$$ENDHEX$$n de cobro de minutas
double g_porc_gastos_minutas

// Variable que indica si el Registro E/S usa el sistema de series
string g_reg_es_series='N'

// Variable para comprobar el vencimiento de los avisos (pago fraccionado) al iniciar la aplicaci$$HEX1$$f300$$ENDHEX$$n
string g_comprobar_vencimiento_avisos='N'

//Javi 10/07/2008
w_sheet g_lista_articulo

// Variable que indica el cierre del expediente cuando se cobra una minuta final
string g_cerrar_exp_minuta_final

// Directorio para los anexos de colegiados
string g_directorio_colegiados_anexos

// Idioma
u_csd_idiomas g_idioma
u_csd_string gnv_string
string g_usar_idioma
string g_ventana_traduccion

// Prefijo para los numeros de colegiados de las sociedades
string g_prefijo_sociedades
// Numero de cifras de los numeros de colegiados
long g_cifras_n_colegiado

// Variable para indicar si tenemos activa la aplicacion de envio de sms
string g_envio_sms='N'

// Coeficiente Ca a nivel informativo para el c$$HEX1$$e100$$ENDHEX$$lculo de honorarios orientativos
double g_ca_info

//Variables para el bloqueo de poblaciones
string g_bloqueo_fases
string g_bloqueo_zonas 
string g_bloqueo_poblacion

string g_impresion_docuprinter='S'


// Borrar conceptos baja colegiado
string g_borrar_conceptos_facturables

//Activa funcionalidad de revisas que colegiado tiene email al enviar los resumenes eco.
string g_imprime_resumen_sin_email


// VARIABLE PARA DESACTIVAR EL N$$HEX2$$ba002000$$ENDHEX$$DE FACTURA AUTOMATICO
string g_n_fact_automatico='S'


//Variable que marca el tipo de identificador enviado a MUSAAT para identificar los contratos:
//1 envia solo el numero de registro
//2 envia n$$HEX1$$fa00$$ENDHEX$$mero de registro y si tiene visado y el visado es anterior al 01/10/2010 manda tambien el visado
//3 manda una numeraci$$HEX1$$f300$$ENDHEX$$n en funci$$HEX1$$f300$$ENDHEX$$n del numero de expediente y el tipo de actuaci$$HEX1$$f300$$ENDHEX$$n
//4 envia n$$HEX1$$fa00$$ENDHEX$$mero de registro con una R delante y si tiene visado y el visado es anterior al 01/10/2010 manda tambien el visado
//5 envia el numero de visado formateado con las formas anteriores al 1 de octubre de 2010 ley omnibus
string g_tipo_ident_fichero="1"


//Variable que indica si se da fecha de visado al dar el visto bueno o no en una fase
string g_vb_simple="S"
//Variable para el control de las notificaciones de facturas
string g_tipo_notificacion
string g_periodo_notificacion

//SCP-901. Alexis. 25/01/2011. Variable para parametrizar el concepto de facturas en contabilizacion
string g_conta_concepto_solo_n_registros

///*** SCP-873. Alexis. 26/01/2011. Se crea la variable g_es_colegio para diferenciar la empresa del colegio. ***///
string g_es_colegio 

//Variable que marca si al generar facturas se pone numero de visado,fecha visado y cambia estado
//0 No se realiza
//1 Se realiza independientemente del tipo de tramite
//2 Se realiza de manera que solo visa para los tipos de tramite validos

string g_visar_al_facturar="0"

string g_titulo_anyo_ejer = "N"

///*** SCP-1126. Alexis. Se crea var global que guarde el c$$HEX1$$f300$$ENDHEX$$digo de la empresa aseguradora. 08/03/2011 ***///
string g_cod_empresa_aseguradora

//Borrar empresa
string g_borrar_empresa='N'

//Imprimir varios talones
string g_imprimir_talon_multiples='N'

///*** SCP-1092. Alexis. Se dinamiza el n$$HEX2$$ba002000$$ENDHEX$$de referencia en las hojas de liquidaci$$HEX1$$f300$$ENDHEX$$n. 24/03/2011***///
string g_hoja_liq_referencia

string g_hoja_reclamo_recibos_impagados // SCP-2058 

string g_conta_cobros_ejercicio_noactual //scp-2123

string g_fact_ocultar_original_copia // SCP-2253

string g_companyia_src_zurich // SCP-2277

string g_valor_extension_docs_sellados 

double g_numero_impresos_listados_domiciliaciones

st_zurich g_st_zurich 
w_sheet g_zurich_lista_integracion_contratos, g_zurich_lista_integracion_asegurados

string g_directorio_facturas_a_cliente
end variables

global type aplic from application
string appname = "aplic"
end type
global aplic aplic

type prototypes
function long GetEnvironmentVariable(string lpName, ref string lpBuffer, long nSize) library "kernel32.dll" alias for "GetEnvironmentVariableA;Ansi"
function long ShellExecute (uint ihwnd,string lpszOp,string lpszFile,string lpszParams, string lpszDir,int wShowCmd ) LIBRARY "Shell32.dll" ALIAS FOR "ShellExecuteA;Ansi" 
function long OpenAs_RunDLL(uint ihwnd , uint ihwnd2 , string lpszFile, int wShowCmd ) LIBRARY 'shell32.dll' ALIAS FOR 'OpenAs_RunDLLA;Ansi';
Function Long GetTempPath(Long nBufferLength, ref String lpBuffer) Library "kernel32.dll" Alias For "GetTempPathA;Ansi"
Function Long CopyFile(String lpExistingFileName, String lpNewFileName, Long bFailIfExists) Library "kernel32" Alias For "CopyFileA;Ansi" 
FUNCTION boolean SetFileAttributesA(string lpFileName, unsignedlong dwFileAttributes) LIBRARY "Kernel32.DLL" alias for "SetFileAttributesA;Ansi"
FUNCTION long GetFileAttributesA(string lpFileName) LIBRARY "Kernel32.DLL" alias for "GetFileAttributesA;Ansi"
end prototypes

on aplic.create
appname="aplic"
message=create message
sqlca=create n_tr
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on aplic.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;this.ToolbarPopMenuText="Izquierda,Arriba,Abajo,Derecha,Flotante,Mostrar Texto,Mostrar Ayudas"

gnv_fichero = CREATE n_cst_filesrvwin32
gnv_sql = CREATE u_csd_sql

gnv_ivajulio2010=create n_csd_ivajulio2010 
gnv_control_cuentas_bancarias=create n_csd_control_cuentas_bancarias

gnv_app= CREATE n_cst_aplic_appmanager 
gnv_app.Event pfc_Open(commandline) 





end event

event close;gnv_app.Event pfc_Close() 
destroy(gnv_app) 
destroy(gnv_fichero)
destroy(gnv_sql)
destroy (gnv_ivajulio2010)
destroy(gnv_control_cuentas_bancarias)
end event

event systemerror;//gnv_app.Event pfc_SystemError()
open(w_system_error)
end event

