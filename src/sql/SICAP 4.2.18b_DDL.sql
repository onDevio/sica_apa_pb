print    'agrupaciones'
SETUSER 'dbo'
go
create table dbo.agrupaciones (
id_agrupacion	char(10)	not null,
id_colegiado	char(10)	not null,
agrupacion	char(2)	null,
f_inicio	datetime	null,
f_fin	datetime	null,
constraint pk_agrupaciones PRIMARY KEY  CLUSTERED ( id_agrupacion)
)
on 'default'
go
print   'id_agrupacion'
create unique nonclustered index id_agrupacion
on dbo.agrupaciones (id_agrupacion)
on 'default'
go

go

SETUSER
go

print    'almacen'
SETUSER 'dbo'
go
create table dbo.almacen (
id_almacen	char(10)	not null,
fecha_desde	datetime	null,
fecha_hasta	datetime	null,
num_contenedor	char(20)	null,
ub_pasillo	char(20)	null,
ub_celda	char(20)	null,
ub_profundidad	char(20)	null,
tipo_almacen	char(2)	null,
observaciones	char(255)	null,
cod_almacen	char(2)	null,
anulada	char(1)	DEFAULT  'N' null	null,
constraint almacen_x PRIMARY KEY  NONCLUSTERED ( id_almacen)
)
on 'default'
go

SETUSER
go

print    'almacen_almacenes'
SETUSER 'dbo'
go
create table dbo.almacen_almacenes (
cod_almacen	char(2)	not null,
descripcion	char(50)	not null,
constraint almacen_almacenes_x PRIMARY KEY  NONCLUSTERED ( cod_almacen)
)
on 'default'
go

SETUSER
go

print    'almacen_tipos'
SETUSER 'dbo'
go
create table dbo.almacen_tipos (
tipo_almacen	char(2)	not null,
descripcion	char(50)	null,
constraint almacen_tipos_x PRIMARY KEY  NONCLUSTERED ( tipo_almacen)
)
on 'default'
go

SETUSER
go

print    'almacen_visados'
SETUSER 'dbo'
go
create table dbo.almacen_visados (
id_almacen_visados	char(10)	not null,
id_almacen	char(10)	null,
n_visado	char(20)	null,
constraint almacen_visados_x PRIMARY KEY  NONCLUSTERED ( id_almacen_visados)
)
on 'default'
go

SETUSER
go

print    'altas_bajas_situaciones'
SETUSER 'dbo'
go
create table dbo.altas_bajas_situaciones (
id_alta_baja_situ	char(10)	not null,
id_colegiado	char(10)	not null,
codigo	char(2)	not null,
fecha	datetime	null,
observaciones	text	null,
alta	char(1)	null,
baja	char(1)	null,
situacion	char(1)	null,
campo_modificado	char(10)	null,
residente	char(1)	null,
constraint id_altas_bajas_situaciones PRIMARY KEY  NONCLUSTERED ( id_alta_baja_situ)
)
on 'default'
go

SETUSER
go

print    'aparatos_tecnicos'
SETUSER 'dbo'
go
create table dbo.aparatos_tecnicos (
id_aparato	char(10)	not null,
n_equipo	char(20)	null,
descripcion	char(255)	null,
n_serie	char(20)	null,
f_entrada	datetime	null,
observaciones	text	null,
prestable	char(1)	null,
prestado	char(1)	null,
fabricante	char(100)	null,
proveedor	char(100)	null,
rango_medida	char(100)	null,
constraint aparatos_tecnicos_x PRIMARY KEY  NONCLUSTERED ( id_aparato)
)
on 'default'
go

SETUSER
go

print    'aparatos_tecnicos_calibracion'
SETUSER 'dbo'
go
create table dbo.aparatos_tecnicos_calibracion (
id_calibracion	char(10)	not null,
id_aparato	char(10)	null,
fecha	datetime	null,
entidad	char(100)	null,
num_informe	char(30)	null,
valido	char(1)	null,
fecha_proxima_calibracion	datetime	null,
observaciones	char(255)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( id_calibracion)
)
on 'default'
go

SETUSER
go

print    'aparatos_tecnicos_prestamos'
SETUSER 'dbo'
go
create table dbo.aparatos_tecnicos_prestamos (
id_prestamo	char(10)	not null,
id_aparato	char(10)	null,
f_prestamo	datetime	null,
f_devolucion_prevista	datetime	null,
f_devolucion_real	datetime	null,
colegiado	char(15)	null,
observaciones	text	null,
constraint id_prestamo PRIMARY KEY  NONCLUSTERED ( id_prestamo)
)
on 'default'
go

SETUSER
go

print    'arquitectos'
SETUSER 'dbo'
go
create table dbo.arquitectos (
id_arquitecto	char(10)	not null,
apellidos	char(80)	null,
nombre	char(50)	null,
direccion	char(160)	null,
cp	char(6)	null,
telefono	char(30)	null,
n_arquitecto	char(15)	null,
constraint arquitectos_x PRIMARY KEY  NONCLUSTERED ( id_arquitecto)
)
on 'default'
go

SETUSER
go

print    'asesoria_juridica'
SETUSER 'dbo'
go
create table dbo.asesoria_juridica (
id_asesoria	char(10)	not null,
n_asesoria	char(10)	null,
fecha	datetime	null,
tipo_asunto	char(2)	null,
descripcion_asunto	char(255)	null,
observaciones	char(255)	null,
usuario	char(10)	null,
medio	char(3)	null,
procedencia	char(3)	null,
constraint id_asesoria PRIMARY KEY  NONCLUSTERED ( id_asesoria)
)
on 'default'
go

SETUSER
go

print    'asesoria_juridica_medio'
SETUSER 'dbo'
go
create table dbo.asesoria_juridica_medio (
codigo	char(3)	not null,
descripcion	char(60)	null,
constraint codigo_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go

print    'asesoria_juridica_procedencia'
SETUSER 'dbo'
go
create table dbo.asesoria_juridica_procedencia (
codigo	char(3)	not null,
descripcion	char(60)	null,
constraint codigo_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'asesoria_tipo_asuntos'
SETUSER 'dbo'
go
create table dbo.asesoria_tipo_asuntos (
codigo	char(2)	not null,
descripcion	char(255)	null,
constraint codigo PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'asistente'
SETUSER 'dbo'
go
create table dbo.asistente (
dw	char(150)	not null,
campo	char(100)	not null,
titulo	char(255)	null,
ayuda	char(255)	null,
constraint asistente PRIMARY KEY  NONCLUSTERED ( dw,campo)
)
on 'default'
go

SETUSER
go

print    'bt_demandas'
SETUSER 'dbo'
go
create table dbo.bt_demandas (
id_col	char(10)	not null,
f_inicio	datetime	null,
observaciones	char(255)	null,
f_fin	datetime	null,
situacion_laboral	char(2)	null,
tipo_solicitud	char(2)	null,
carnet	char(1)	null,
coche	char(1)	null,
viajar	char(1)	null,
otros	char(255)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( id_col)
)
on 'default'
go

SETUSER
go
print    'bt_demandas_cursos'
SETUSER 'dbo'
go
create table dbo.bt_demandas_cursos (
id_col	char(10)	not null,
curso	char(240)	not null,
ano	int	not null,
constraint bt_demandas_cursos_x PRIMARY KEY  NONCLUSTERED ( id_col,curso)
)
on 'default'
go

SETUSER
go
print    'bt_demandas_experiencias'
SETUSER 'dbo'
go
create table dbo.bt_demandas_experiencias (
id_col	char(10)	not null,
empresa	char(240)	not null,
ano	char(4)	null,
constraint id_col_empresa PRIMARY KEY  NONCLUSTERED ( id_col,empresa)
)
on 'default'
go

SETUSER
go
print    'bt_demandas_idiomas'
SETUSER 'dbo'
go
create table dbo.bt_demandas_idiomas (
id_col	char(10)	not null,
idioma	char(2)	not null,
nivel	char(2)	null,
constraint bt_demandas_idiomas_x PRIMARY KEY  NONCLUSTERED ( id_col,idioma)
)
on 'default'
go

SETUSER
go
print    'bt_demandas_tipo'
SETUSER 'dbo'
go
create table dbo.bt_demandas_tipo (
id_col	char(10)	not null,
tipo_demanda	char(2)	not null,
constraint pk PRIMARY KEY  NONCLUSTERED ( id_col,tipo_demanda)
)
on 'default'
go

SETUSER
go

print    'bt_idiomas'
SETUSER 'dbo'
go
create table dbo.bt_idiomas (
codigo	char(2)	not null,
descripcion	char(255)	null,
constraint bt_idiomas_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'bt_nivel'
SETUSER 'dbo'
go
create table dbo.bt_nivel (
codigo	char(2)	not null,
descripcion	char(255)	null,
constraint codigo PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'bt_ofertas'
SETUSER 'dbo'
go
create table dbo.bt_ofertas (
id_oferta	char(10)	not null,
n_oferta	char(10)	null,
f_oferta	datetime	null,
tipo_bolsa	char(2)	null,
id_ofertante	char(10)	null,
tipo_act	char(3)	null,
tipo_obra	char(3)	null,
descripcion_larga	nvarchar(255)	null,
condiciones	char(255)	null,
f_fin	datetime	null,
tipo_trabajo	char(255)	null,
constraint bt_ofertas_x PRIMARY KEY  NONCLUSTERED ( id_oferta)
)
on 'default'
go

SETUSER
go
print    'bt_ofertas_asigna'
SETUSER 'dbo'
go
create table dbo.bt_ofertas_asigna (
id_ofertas_asigna	char(10)	not null,
id_oferta	char(10)	null,
id_colegiado	char(10)	null,
realiza_trabajo	char(1)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( id_ofertas_asigna)
)
on 'default'
go

SETUSER
go
print    'bt_tipo_bolsa'
SETUSER 'dbo'
go
create table dbo.bt_tipo_bolsa (
bt_tipo_bolsa	char(2)	not null,
descripcion	char(50)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( bt_tipo_bolsa)
)
on 'default'
go

SETUSER
go

print    'c_geograficos'
SETUSER 'dbo'
go
create table dbo.c_geograficos (
c_geografico	char(5)	not null,
descripcion	char(60)	not null,
constraint id_geografico PRIMARY KEY  NONCLUSTERED ( c_geografico)
)
on 'default'
go

SETUSER
go
print    'cabecera'
SETUSER 'dbo'
go
create table dbo.cabecera (
id_registro	char(10)	not null,
banco	char(4)	not null,
oficina	char(4)	not null,
cuenta	char(20)	null,
f_ini	datetime	not null,
f_fin	datetime	not null,
dh	char(1)	not null,
saldo_inicial	char(15)	not null,
nom_abre	char(26)	not null,
constraint pk_cabecera PRIMARY KEY  NONCLUSTERED ( id_registro)
)
on 'default'
go

SETUSER
go
print    'caja_salidas'
SETUSER 'dbo'
go
create table dbo.caja_salidas (
id_caja_salida	char(10)	not null,
fecha	datetime	null,
centro	char(10)	null,
concepto	char(100)	null,
importe	float	null,
banco	char(10)	null,
tipo	char(1)	null,
id_usuario	char(10)	null,
id_colegiado	char(10)	null,
remesa	char(2)	null,
constraint caja_salida PRIMARY KEY  NONCLUSTERED ( id_caja_salida)
)
on 'default'
go

SETUSER
go
print    'callejero'
SETUSER 'dbo'
go
create table dbo.callejero (
codigo	char(10)	not null,
calle	char(255)	null,
cod_pos	char(6)	null,
cod_pob	char(6)	null,
provincia	char(5)	null,
n_impar_desde	int	null,
n_impar_hasta	int	null,
n_par_desde	int	null,
n_par_hasta	int	null,
cod_ciudad	char(4)	null,
constraint callejero_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'cargos'
SETUSER 'dbo'
go
create table dbo.cargos (
cargos	char(2)	not null,
descripcion	char(60)	not null,
nombre	char(100)	null,
constraint id_cargos PRIMARY KEY  NONCLUSTERED ( cargos)
)
on 'default'
go

SETUSER
go
print    'cartas'
SETUSER 'dbo'
go
create table dbo.cartas (
id_carta	char(10)	not null,
tipo	char(2)	not null,
fecha	datetime	not null,
modulo_asociado	char(20)	null,
id_referencia	char(10)	not null,
cod_usuario	char(10)	null,
plantilla	char(10)	null,
n_registro	char(20)	null,
nombre_fichero	char(100)	null,
ruta_fichero	char(255)	null,
visible_web	char(1)	null,
constraint pk_cartas PRIMARY KEY  NONCLUSTERED ( id_carta)
)
on 'default'
go

SETUSER
go

print    'cierre'
SETUSER 'dbo'
go
create table dbo.cierre (
id_registro	char(10)	not null,
id_cierre	char(10)	not null,
cuenta	char(10)	not null,
n_apuntes_debe	real	not null,
importe_debe	char(15)	not null,
n_apuntes_haber	real	not null,
importe_haber	char(15)	not null,
dh	char(1)	not null,
importe_saldo_final	char(15)	not null,
constraint pk_cierre PRIMARY KEY  NONCLUSTERED ( id_cierre)
)
on 'default'
go

SETUSER
go
print    'cip_tablas'
SETUSER 'dbo'
go
create table dbo.cip_tablas (
desde	float	not null,
hasta	float	not null,
coef	float	not null,
limite	char(1)	not null,
tarifa	char(4)	not null,
constraint cip_tablas_x PRIMARY KEY  NONCLUSTERED ( desde,hasta,tarifa)
)
on 'default'
go

SETUSER
go
print    'cip_tarifa'
SETUSER 'dbo'
go
create table dbo.cip_tarifa (
tipo_actuacion	char(2)	not null,
tipo_obra	char(2)	not null,
coef_aux	float	null,
tarifa	char(4)	null,
minimo	float	null,
duda	char(1)	null,
constraint cip_tarifa_x PRIMARY KEY  NONCLUSTERED ( tipo_actuacion,tipo_obra)
)
on 'default'
go

SETUSER
go
print    'cip_tipo_act'
SETUSER 'dbo'
go
create table dbo.cip_tipo_act (
anyo	char(4)	not null,
tipo_actuacion	char(2)	not null,
tipo_obra	char(2)	not null,
coef_k	float(43)	not null,
coef_c	float(43)	null,
constraint cip_tipo_act_x PRIMARY KEY  NONCLUSTERED ( anyo,tipo_actuacion,tipo_obra)
)
on 'default'
go

SETUSER
go
print    'ciudades'
SETUSER 'dbo'
go
create table dbo.ciudades (
cod_ciudad	char(4)	not null,
descripcion	char(60)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( cod_ciudad)
)
on 'default'
go

SETUSER
go

print    'clientes'
SETUSER 'dbo'
go
create table dbo.clientes (
id_cliente	char(10)	not null,
n_cliente	char(15)	null,
apellidos	char(80)	null,
nombre	char(50)	null,
nif	char(15)	null,
tipo_persona	char(2)	null,
sexo	char(1)	null,
observaciones	text	null,
email	char(100)	null,
url	char(100)	null,
tipo_via	char(2)	null,
nombre_via	char(100)	null,
cod_pob	char(6)	null,
cod_prov	char(5)	null,
pais	char(10)	null,
cp	char(6)	null,
telefono	char(30)	null,
fax	char(30)	null,
modificador	char(50)	null,
cuenta_bancaria	char(20)	null,
cuenta_contable	char(10)	null,
irpf	char(1)	null,
visible_web	char(1)	null,
empresa	char(2)	null,
autoriza_datos	char(1)	DEFAULT  'N' null	null,
constraint clientes PRIMARY KEY  NONCLUSTERED ( id_cliente )
)
on 'default'
go
print   'apellidos'
create nonclustered index apellidos
on dbo.clientes (apellidos)
on 'default'
go

print   'nif'
create nonclustered index nif
on dbo.clientes (nif)
on 'default'
go

print   'nombre'
create nonclustered index nombre
on dbo.clientes (nombre)
on 'default'
go

go

SETUSER
go
print    'clientes_terceros'
SETUSER 'dbo'
go
create table dbo.clientes_terceros (
id	char(10)	not null,
id_cliente	char(10)	not null,
c_tercero	char(2)	not null,
constraint clientes_terceros_x PRIMARY KEY  NONCLUSTERED ( id)
)
on 'default'
go
print   'c_tercero'
create nonclustered index c_tercero
on dbo.clientes_terceros (c_tercero)
on 'default'
go

print   'id_cliente'
create nonclustered index id_cliente
on dbo.clientes_terceros (id_cliente)
on 'default'
go

go

SETUSER
go

print    'coaatcc_gestor_doc_tarifa'
SETUSER 'dbo'
go
create table dbo.coaatcc_gestor_doc_tarifa (
idTipoContratoDocumento	char(10)	not null,
idTipoContrato	char(10)	null,
idDocumento	char(10)	null,
requerido	char(1)	null,
activo	char(1)	null,
constraint coaatcc_gestor_doc_tarifa_x PRIMARY KEY  NONCLUSTERED ( idTipoContratoDocumento)
)
on 'default'
go

SETUSER
go
print    'coaatcc_gestor_documental'
SETUSER 'dbo'
go
create table dbo.coaatcc_gestor_documental (
idDocumento	char(10)	not null,
idDocumentoPadre	char(10)	null,
idClaseDocumento	char(1)	null,
descripcion	char(255)	null,
iniciales	char(10)	null,
activo	char(1)	null,
fichero	char(1)	null,
recursivo	char(1)	null,
requiereOriginal	char(1)	null,
requiereVT	char(1)	null,
requiereVA	char(1)	null,
VE	char(1)	null,
legalizacion	char(1)	null,
constraint coaatcc_gestor_documental_x PRIMARY KEY  NONCLUSTERED ( idDocumento)
)
on 'default'
go

SETUSER
go
print    'coaatcc_ho_tablas'
SETUSER 'dbo'
go
create table dbo.coaatcc_ho_tablas (
desde	float	not null,
hasta	float	not null,
coef	float	not null,
limite	char(1)	not null,
tarifa	char(10)	not null,
contenido	char(4)	not null,
constraint cip_tablas_x PRIMARY KEY  NONCLUSTERED ( desde,hasta,tarifa,contenido)
)
on 'default'
go

SETUSER
go
print    'coaatcc_ho_tarifas'
SETUSER 'dbo'
go
create table dbo.coaatcc_ho_tarifas (
cod_tarifa	char(10)	not null,
descripcion	char(255)	null,
formula	char(255)	null,
param1	char(100)	null,
param2	char(100)	null,
param3	char(100)	null,
param4	char(100)	null,
param5	char(100)	null,
formula_cip	char(255)	null,
constraint ho_tarifas_x PRIMARY KEY  NONCLUSTERED ( cod_tarifa)
)
on 'default'
go

SETUSER
go
print    'coaatcc_ho_tarifas_contenidos'
SETUSER 'dbo'
go
create table dbo.coaatcc_ho_tarifas_contenidos (
cod_tarifa	char(10)	not null,
cod_contenido	char(10)	not null,
minimo	float	null,
coef	float	null,
minimo_cip	float	null,
constraint pk_ho_tarifas_contenidos PRIMARY KEY  NONCLUSTERED ( cod_tarifa,cod_contenido)
)
on 'default'
go

SETUSER
go

print    'coaattg_coef_urb'
SETUSER 'dbo'
go
create table dbo.coaattg_coef_urb (
id	char(10)	not null,
pres_desde	float	null,
pres_hasta	float	null,
ku	float	null,
dim	float	null,
constraint pk_coef PRIMARY KEY  NONCLUSTERED ( id)
)
on 'default'
go

SETUSER
go
print    'coaattg_derribos'
SETUSER 'dbo'
go
create table dbo.coaattg_derribos (
id	char(10)	not null,
tipo_obra	char(3)	null,
destino	char(3)	null,
volumen_inf	float	null,
volumen_sup	float	null,
valor	float	not null,
constraint pk_id PRIMARY KEY  NONCLUSTERED ( id)
)
on 'default'
go

SETUSER
go
print    'coaattg_instalaciones'
SETUSER 'dbo'
go
create table dbo.coaattg_instalaciones (
id	char(10)	not null,
tipo_obra	char(3)	not null,
rango_inf	float	not null,
rango_sup	float	not null,
valor	float	not null,
constraint pk_id PRIMARY KEY  NONCLUSTERED ( id)
)
on 'default'
go

SETUSER
go

print    'coaattg_K'
SETUSER 'dbo'
go
create table dbo.coaattg_K (
id	char(10)	not null,
rango_inf	float	null,
rango_sup	float	null,
valor	float	null,
constraint pk_id PRIMARY KEY  NONCLUSTERED ( id)
)
on 'default'
go

SETUSER
go
print    'coaattg_pm2'
SETUSER 'dbo'
go
create table dbo.coaattg_pm2 (
id	char(10)	not null,
destino	char(3)	not null,
rango_inf	float	not null,
rango_sup	float	not null,
valor	float	not null,
constraint pk_pm2 PRIMARY KEY  NONCLUSTERED ( id)
)
on 'default'
go

SETUSER
go
print    'coaattg_re'
SETUSER 'dbo'
go
create table dbo.coaattg_re (
id	char(10)	not null,
rango_inf	float	not null,
rango_sup	float	not null,
limite	float	not null,
valor	float	not null,
valor_limite	float	null,
constraint pk_re PRIMARY KEY  NONCLUSTERED ( id)
)
on 'default'
go

SETUSER
go
print    'coaattg_ti'
SETUSER 'dbo'
go
create table dbo.coaattg_ti (
id	char(10)	not null,
t_fase	char(3)	null,
coef_ti	float	null,
minimo	float	null,
maximo	float	null,
constraint pk_ti PRIMARY KEY  NONCLUSTERED ( id)
)
on 'default'
go

SETUSER
go
print    'coaattg_to'
SETUSER 'dbo'
go
create table dbo.coaattg_to (
id	char(10)	not null,
tipo_obra	char(3)	not null,
tipo_reforma	char(1)	not null,
valor	float	null,
constraint pk_coef PRIMARY KEY  NONCLUSTERED ( id)
)
on 'default'
go

SETUSER
go

print    'coef_ipc'
SETUSER 'dbo'
go
create table dbo.coef_ipc (
ejercicio	char(4)	not null,
ipc	float	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( ejercicio)
)
on 'default'
go

SETUSER
go
print    'colegiado_cesion_datos'
SETUSER 'dbo'
go
create table dbo.colegiado_cesion_datos (
id_colegiado	char(10)	not null,
c_telefono_prof	char(1)	null,
c_telefono_part	char(1)	null,
c_movil_1	char(1)	null,
c_movil_2	char(1)	null,
c_fax	char(1)	null,
c_email	char(1)	null,
c_url	char(1)	null,
constraint id_cesion_datos PRIMARY KEY  NONCLUSTERED ( id_colegiado)
)
on 'default'
go

SETUSER
go
print    'colegiado_inhabilitacion'
SETUSER 'dbo'
go
create table dbo.colegiado_inhabilitacion (
id_inhabilitacion	char(10)	not null,
id_colegiado	char(10)	not null,
cod_origen	char(3)	null,
cod_tipo	char(10)	null,
fecha_inicio	datetime	null,
fecha_fin	datetime	null,
descripcion	char(255)	null,
constraint id_inhabilitacion PRIMARY KEY  NONCLUSTERED ( id_inhabilitacion,id_colegiado)
)
on 'default'
go

SETUSER
go
print    'colegiado_titulaciones'
SETUSER 'dbo'
go
create table dbo.colegiado_titulaciones (
id_titulacion	char(10)	not null,
id_colegiado	char(10)	not null,
cod_titulacion	char(3)	null,
cod_escuela	char(10)	null,
anyo_terminacion	char(4)	null,
constraint id_titulacion PRIMARY KEY  NONCLUSTERED ( id_titulacion,id_colegiado)
)
on 'default'
go

SETUSER
go

print    'colegiados'
SETUSER 'dbo'
go
create table dbo.colegiados (
id_colegiado	char(10)	not null,
n_colegiado	char(15)	not null,
apellidos	char(80)	not null,
nombre	char(50)	null,
nif	char(15)	null,
tipo_persona	char(2)	null,
colegio	char(2)	null,
demarcacion	char(2)	null,
delegacion	char(2)	null,
c_geografico	char(5)	null,
cod_situacion_profesional	char(2)	null,
cod_demarcacion	char(2)	null,
t_alta	char(2)	null,
t_baja	char(2)	null,
f_alta	datetime	null,
f_baja	datetime	null,
f_colegiacion	datetime	null,
f_titulacion	datetime	null,
f_nacimiento	datetime	null,
sexo	char(1)	null,
tratamiento	char(60)	null,
alta_baja	char(1)	null,
situacion	char(2)	null,
observaciones	text	null,
aviso	text	null,
per_todos_datos	char(1)	null,
per_comer_notel	char(1)	null,
per_comer_sitel	char(1)	null,
email	char(100)	null,
url	char(100)	null,
recibir_c_postales	char(1)	null,
ultima_factura	int	null,
iva_igic	float	null,
irpf	float	null,
ret_voluntaria	float	null,
periodo_transf_ret	char(1)	null,
domicilio_activo	char(160)	null,
poblacion_activa	char(120)	null,
n_consejo	char(15)	null,
domicilio_activo_fiscal	char(160)	null,
poblacion_activa_fiscal	char(120)	null,
telefono_activo	char(30)	null,
nombre_empresa	char(120)	null,
nif_empresa	char(15)	null,
domicilio_empresa	char(160)	null,
poblacion_empresa	char(120)	null,
trabaja_para_empresa	char(1)	null,
cuenta_bancaria	char(20)	null,
cons_otros_colegios	char(60)	null,
cons_tipo_titulacion	char(1)	null,
cons_escuela_final	char(60)	null,
cons_pais_titulo	char(3)	null,
cons_documento_titulo	char(40)	null,
cons_fecha_documento	datetime	null,
cons_denominacion_titulo	char(60)	null,
cons_tipo_permiso	char(60)	null,
cons_ambito_permiso	char(60)	null,
cons_regimen_laboral	char(60)	null,
cons_fecha_caducidad	datetime	null,
cons_observaciones	char(255)	null,
cons_lugar_nacimiento	char(60)	null,
cons_nacionalidad	char(3)	null,
cons_circunst_habilitacion	char(1)	null,
n_recibo	char(10)	null,
f_ultima_fact	datetime	null,
f_situacion	datetime	null,
n_hermandad	char(20)	null,
recibir_c_email	char(1)	null,
todos_servicios	char(1)	null,
traspaso_iva	char(2)	null,
id_empresa	char(10)	null,
telefono_1	char(30)	null,
telefono_2	char(30)	null,
telefono_3	char(30)	null,
telefono_4	char(30)	null,
telefono_5	char(30)	null,
cuenta_domic	char(20)	null,
banco_domic	char(10)	null,
cons_fecha_rege	datetime	null,
cons_folio_e	char(8)	null,
cons_fecha_regm	datetime	null,
cons_folio_m	char(8)	null,
cons_tit_resg	char(1)	null,
n_acreditado	char(15)	null,
cons_procedencia	char(60)	null,
embargo_hacienda	char(1)	null,
recibir_c_sms	char(1)	null,
recibir_c_web	char(1)	null,
visible_web	char(1)	null,
ultima_factura_rectif	int	null,
domicilio_web	char(1)	null,
ejerciente	char(1)	null,
publicidad	char(1)	null,
telefono_web	char(30)	null,
activo_cp	char(1)	null,
cuenta_bancaria_personal	char(20)	null,
cuenta_contable	char(10)	null,
email_profesional	char(100)	null,
constraint id_colegiados PRIMARY KEY  NONCLUSTERED ( id_colegiado)
)
on 'default'
go
print   'i_app'
create nonclustered index i_app
on dbo.colegiados (apellidos)
on 'default'
go

print   'i_ncol'
create nonclustered index i_ncol
on dbo.colegiados (n_colegiado)
on 'default'
go

print   'i_nif'
create nonclustered index i_nif
on dbo.colegiados (nif)
on 'default'
go

go

SETUSER
go
print    'colegiados_anexos'
SETUSER 'dbo'
go
create table dbo.colegiados_anexos (
id_colegiado_anexo	char(10)	not null,
id_colegiado	char(10)	not null,
ruta	char(255)	not null
)
on 'default'
go

SETUSER
go
print    'colegiados_autorizaciones'
SETUSER 'dbo'
go
create table dbo.colegiados_autorizaciones (
id_col_autorizado	char(10)	not null,
id_colegiado	char(10)	not null,
nombre	char(255)	null,
nif	char(15)	null,
constraint pk_col_auto PRIMARY KEY  CLUSTERED ( id_col_autorizado)
)
on 'default'
go

SETUSER
go
print    'colegiados_b'
SETUSER 'dbo'
go
create table dbo.colegiados_b (
id_colegiado	char(10)	not null,
n_colegiado	char(15)	not null,
apellidos	char(80)	not null,
nombre	char(50)	null,
nif	char(15)	null,
tipo_persona	char(2)	null,
colegio	char(2)	null,
demarcacion	char(2)	null,
delegacion	char(2)	null,
c_geografico	char(5)	null,
cod_situacion_profesional	char(2)	null,
cod_demarcacion	char(2)	null,
t_alta	char(2)	null,
t_baja	char(2)	null,
f_alta	datetime	null,
f_baja	datetime	null,
f_colegiacion	datetime	null,
f_titulacion	datetime	null,
f_nacimiento	datetime	null,
sexo	char(1)	null,
tratamiento	char(60)	null,
alta_baja	char(1)	null,
situacion	char(2)	null,
observaciones	text	null,
aviso	text	null,
per_todos_datos	char(1)	null,
per_comer_notel	char(1)	null,
per_comer_sitel	char(1)	null,
email	char(100)	null,
url	char(100)	null,
recibir_c_postales	char(1)	null,
ultima_factura	int	null,
iva_igic	float	null,
irpf	float	null,
ret_voluntaria	float	null,
periodo_transf_ret	char(1)	null,
domicilio_activo	char(160)	null,
poblacion_activa	char(120)	null,
n_consejo	char(15)	null,
domicilio_activo_fiscal	char(160)	null,
poblacion_activa_fiscal	char(120)	null,
telefono_activo	char(30)	null,
nombre_empresa	char(120)	null,
nif_empresa	char(15)	null,
domicilio_empresa	char(160)	null,
poblacion_empresa	char(120)	null,
trabaja_para_empresa	char(1)	null,
cuenta_bancaria	char(20)	null,
cons_otros_colegios	char(60)	null,
cons_tipo_titulacion	char(1)	null,
cons_escuela_final	char(60)	null,
cons_pais_titulo	char(3)	null,
cons_documento_titulo	char(40)	null,
cons_fecha_documento	datetime	null,
cons_denominacion_titulo	char(60)	null,
cons_tipo_permiso	char(60)	null,
cons_ambito_permiso	char(60)	null,
cons_regimen_laboral	char(60)	null,
cons_fecha_caducidad	datetime	null,
cons_observaciones	char(255)	null,
cons_lugar_nacimiento	char(60)	null,
cons_nacionalidad	char(3)	null,
cons_circunst_habilitacion	char(1)	null,
n_recibo	char(10)	null,
f_ultima_fact	datetime	null,
f_situacion	datetime	null,
n_hermandad	char(20)	null,
recibir_c_email	char(1)	null,
todos_servicios	char(1)	null,
traspaso_iva	char(2)	null,
id_empresa	char(10)	null,
telefono_1	char(30)	null,
telefono_2	char(30)	null,
telefono_3	char(30)	null,
telefono_4	char(30)	null,
telefono_5	char(30)	null,
cuenta_domic	char(20)	null,
banco_domic	char(10)	null,
cons_fecha_rege	datetime	null,
cons_folio_e	char(8)	null,
cons_fecha_regm	datetime	null,
cons_folio_m	char(8)	null,
cons_tit_resg	char(1)	null,
n_acreditado	char(15)	null,
cons_procedencia	char(60)	null,
embargo_hacienda	char(1)	null,
recibir_c_sms	char(1)	null,
recibir_c_web	char(1)	null,
visible_web	char(1)	null,
ultima_factura_rectif	int	null,
domicilio_web	char(1)	null,
ejerciente	char(1)	null,
publicidad	char(1)	null,
telefono_web	char(30)	null,
activo_cp	char(1)	null,
cuenta_bancaria_personal	char(20)	null,
constraint colegiados_x PRIMARY KEY  NONCLUSTERED ( id_colegiado)
)
on 'default'
go

SETUSER
go

print    'colegiados_baja_acredit'
SETUSER 'dbo'
go
create table dbo.colegiados_baja_acredit (
id_log	char(10)	not null,
id_colegiado	char(10)	null,
f_alta	datetime	null,
f_baja	datetime	null,
constraint log_acredit PRIMARY KEY  CLUSTERED ( id_log)
)
on 'default'
go

SETUSER
go
print    'colegiados_cambios_dom'
SETUSER 'dbo'
go
create table dbo.colegiados_cambios_dom (
id_cambio_dom	char(10)	not null,
id_colegiado	char(10)	not null,
fiscal	char(1)	not null,
domicilio_antiguo	char(160)	null,
poblacion_antigua	char(120)	null,
domicilio_nuevo	char(160)	null,
poblacion_nueva	char(120)	null,
usuario	char(10)	null,
fecha	datetime	null,
constraint pk_id_cambio_dom PRIMARY KEY  CLUSTERED ( id_cambio_dom)
)
on 'default'
go

SETUSER
go
print    'colegiados_empresas'
SETUSER 'dbo'
go
create table dbo.colegiados_empresas (
id_colegiado	char(10)	not null,
id_empresa	char(10)	not null,
constraint pk_coleg_empresas PRIMARY KEY  CLUSTERED ( id_colegiado,id_empresa)
)
on 'default'
go

SETUSER
go
print    'colegiados_firma_digital'
SETUSER 'dbo'
go
create table dbo.colegiados_firma_digital (
id_colegiado	char(10)	not null,
estado	char(2)	not null,
f_estado	datetime	not null,
constraint pk_coleg_firma_dig PRIMARY KEY  NONCLUSTERED ( id_colegiado,estado,f_estado)
)
on 'default'
go

SETUSER
go

print    'colegios'
SETUSER 'dbo'
go
create table dbo.colegios (
cod_colegio	char(2)	not null,
descripcion	char(60)	not null,
cod_consejo	varchar(2)	null,
constraint id_colegio PRIMARY KEY  NONCLUSTERED ( cod_colegio)
)
on 'default'
go

SETUSER
go
print    'colegios_matriculas'
SETUSER 'dbo'
go
create table dbo.colegios_matriculas (
matricula	char(2)	not null,
colegio	char(30)	null,
constraint pk_colegios_matriculas PRIMARY KEY  NONCLUSTERED ( matricula)
)
on 'default'
go

SETUSER
go
print    'colindantes'
SETUSER 'dbo'
go
create table dbo.colindantes (
codigo	char(2)	not null,
descripcion	char(30)	null,
constraint colindantes_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'colores'
SETUSER 'dbo'
go
create table dbo.colores (
codigo	char(5)	not null,
descripcion	char(50)	null,
rgb	float	null,
hexadecimal	char(50)	not null,
constraint colores_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go

print    'comunidad_autonoma'
SETUSER 'dbo'
go
create table dbo.comunidad_autonoma (
id_comunidad_autonoma	char(10)	not null,
descripcion	char(80)	null,
cod_pais	char(5)	null,
constraint comunidad_autonoma_x PRIMARY KEY  NONCLUSTERED ( id_comunidad_autonoma)
)
on 'default'
go

SETUSER
go
print    'conceptos_domiciliables'
SETUSER 'dbo'
go
create table dbo.conceptos_domiciliables (
id_colegiado	char(10)	not null,
concepto	char(10)	not null,
forma_de_pago	char(2)	null,
datos_bancarios	char(20)	null,
nombre_banco	char(50)	null,
importe	float	null,
es_extra	char(1)	null,
ips	float	null,
ccs	float	null,
f_inicio	datetime	null,
f_fin	datetime	null,
periodicidad	char(2)	null,
constraint conceptos_domiciliables_x PRIMARY KEY  NONCLUSTERED ( id_colegiado,concepto)
)
on 'default'
go

SETUSER
go
print    'conceptos_remesables'
SETUSER 'dbo'
go
create table dbo.conceptos_remesables (
id_colegiado	char(10)	not null,
concepto	char(10)	not null,
forma_de_pago	char(2)	null,
datos_bancarios	char(20)	null,
nombre_banco	char(150)	null,
domicilio_banco	char(60)	null,
poblacion_banco	char(60)	null,
constraint conceptos_remesables_x PRIMARY KEY  NONCLUSTERED ( id_colegiado,concepto)
)
on 'default'
go

SETUSER
go
print    'configura_campos'
SETUSER 'dbo'
go
create table dbo.configura_campos (
cod_comb	char(5)	not null,
tipo_viv	char(1)	null,
num_edif	char(1)	null,
num_viv	char(1)	null,
sup_viv	char(1)	null,
sup_garage	char(1)	null,
sup_otros	char(1)	null,
pem	char(1)	null,
plantas_sob	char(1)	null,
sup_sob	char(1)	null,
plantas_baj	char(1)	null,
sup_baj	char(1)	null,
altura	char(1)	null,
colindantes	char(1)	null,
uso	char(1)	null,
estudio_geo	char(1)	null,
cc_externo	char(1)	null,
niv_cont	char(1)	null,
volumen	char(1)	null,
longitud_per	char(1)	null,
volumen_tierras	char(1)	null,
estructura	char(1)	null,
t_terreno	char(1)	null,
t_medicion	char(1)	null,
replan_deslin	char(1)	null,
valor_terreno	float	null,
valor_tasacion	float	null,
valoracion_estim	float	null,
sup_total	char(1)	null,
constraint pk_configura_campos PRIMARY KEY  NONCLUSTERED ( cod_comb)
)
on 'default'
go

SETUSER
go
print    'configura_insercion'
SETUSER 'dbo'
go
create table dbo.configura_insercion (
tipo_act	char(3)	not null,
tipo_obra	char(3)	not null,
destino	char(3)	not null,
cod_comb	char(5)	not null,
constraint pk_configura_insercion PRIMARY KEY  NONCLUSTERED ( tipo_act,tipo_obra,destino,cod_comb)
)
on 'default'
go

SETUSER
go

print    'consultas'
SETUSER 'dbo'
go
create table dbo.consultas (
id_consulta	char(10)	not null,
ventana	char(100)	null,
descripcion	char(100)	null,
fecha	datetime	null,
usuario	char(100)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( id_consulta)
)
on 'default'
go

SETUSER
go
print    'consultas_datos'
SETUSER 'dbo'
go
create table dbo.consultas_datos (
id_consulta_datos	char(10)	not null,
datawindow	char(100)	null,
columna	float	null,
valor_double	float	null,
valor_string	char(100)	null,
valor_datetime	datetime	null,
fila	float	null,
id_consulta	char(10)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( id_consulta_datos)
)
on 'default'
go

SETUSER
go
print    'contadores'
SETUSER 'dbo'
go
create table dbo.contadores (
contador	char(20)	not null,
valor	float	not null,
descripcion	char(100)	null,
orden	char(5)	null,
modificable	char(1)	null,
empresa	char(2)	null,
constraint contadores_x PRIMARY KEY  NONCLUSTERED ( contador)
)
on 'default'
go

SETUSER
go
print    'cp_csi_empresas'
SETUSER 'dbo'
go
create table dbo.cp_csi_empresas (
codigo	char(5)	not null,
nombre	char(150)	null,
nif	char(15)	null,
direccion	char(60)	null,
poblacion	char(30)	null,
codigo_postal	char(5)	null,
provincia	char(2)	null,
telefono	char(20)	null,
fax	char(20)	null,
inscripcion	char(100)	null,
cuenta_bancaria	char(20)	null,
numeracion	float	null,
facturacion	char(1)	null,
nombre_corto	char(30)	null,
prefijo_factura	char(2)	null,
logo	char(60)	null,
centro	char(3)	null,
proyecto	char(5)	null,
es_colegio	char(1)	null,
etiqueta_superior_listados	char(15)	null,
pendiente_devengar_fe	char(1)	null,
pendiente_devengar_fr	char(1)	null,
coste	char(1)	null,
direccion_corta	char(36)	null,
imagen_fondo	char(100)	null,
constraint empresas_x PRIMARY KEY  CLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'csd_conexion_bd'
SETUSER 'dbo'
go
create table dbo.csd_conexion_bd (
id_conexion	varchar(10)	not null,
dbms	varchar(200)	null,
db	varchar(200)	null,
logid	varchar(200)	null,
logpassword	varchar(200)	null,
servername	varchar(200)	null,
autocommit	varchar(10)	null,
dbparm	varchar(200)	null,
charset	varchar(200)	null,
descripcion	varchar(200)	null,
constraint PK_id_conexion PRIMARY KEY  NONCLUSTERED ( id_conexion)
)
on 'default'
go

SETUSER
go
alter table consultas_datos 
add constraint fk_consulta_reference_consulta foreign key (id_consulta) references consultas(id_consulta)
go

print    'csd_doc_modulo'
SETUSER 'dbo'
go
create table dbo.csd_doc_modulo (
id_documento_modulo	varchar(20)	not null,
id_tipo_modulo	varchar(20)	null,
id_modulo	varchar(20)	null,
f_activacion	datetime	null,
f_caducidad	datetime	null,
version	varchar(20)	null,
anyo	varchar(4)	null,
nombre_fichero	varchar(255)	null,
descripcion	varchar(255)	null,
autor	varchar(100)	null,
id_usuario	varchar(20)	null,
visible_web	varchar(1)	null,
cod_tipo_documento_archivo	varchar(2)	null,
cod_tipo_documento_celda	varchar(2)	null,
cod_tipo_documento	varchar(2)	null,
ubicacion	varchar(100)	null,
tamanyo	float	null,
constraint pk_doc_mod PRIMARY KEY  CLUSTERED ( id_documento_modulo)
)
on 'default'
go

SETUSER
go
print    'csd_seg_ip'
SETUSER 'dbo'
go
create table dbo.csd_seg_ip (
id_seg_ip	char(10)	not null,
id_usuario	char(10)	null,
tipo_ip	varchar(2)	null,
ip_fija	varchar(20)	null,
ip_rango_a	varchar(20)	null,
ip_rango_b	varchar(20)	null,
constraint PK_IP_SEG PRIMARY KEY  NONCLUSTERED ( id_seg_ip)
)
on 'default'
go

SETUSER
go
print    'csd_seg_ip_exclusion'
SETUSER 'dbo'
go
create table dbo.csd_seg_ip_exclusion (
id_exclusion	varchar(10)	not null,
ip_fija	varchar(20)	null,
ip_rango_a	varchar(20)	null,
ip_rango_b	varchar(20)	null,
constraint PK_id_exclusion PRIMARY KEY  NONCLUSTERED ( id_exclusion)
)
on 'default'
go

SETUSER
go
print    'csd_seg_tipo_idioma'
SETUSER 'dbo'
go
create table dbo.csd_seg_tipo_idioma (
cod_tipo_idioma	varchar(2)	not null,
descripcion	varchar(100)	null,
constraint pk_csd_seg_tipo_idioma PRIMARY KEY  NONCLUSTERED ( cod_tipo_idioma)
)
on 'default'
go

SETUSER
go
print    'csd_sms'
SETUSER 'dbo'
go
create table dbo.csd_sms (
id_sms	varchar(10)	not null,
id_contacto	varchar(10)	null,
id_grupo	varchar(10)	null,
descripcion	varchar(255)	null,
remitente	varchar(50)	null,
fecha_envio	datetime	null,
mensaje	varchar(255)	null,
t_sms	char(1)	null,
pie_mensaje	varchar(100)	null,
resultado_envio	char(1)	null,
programado	char(1)	null,
id_sms_predefinido	char(10)	null,
id_sms_programado	char(10)	null,
id_campanya	varchar(20)	null,
movil_contacto	char(100)	null,
email_remitente	char(100)	null,
fecha_alta	datetime	null,
texto	text	null,
constraint csd_sms_x PRIMARY KEY  NONCLUSTERED ( id_sms)
)
on 'default'
go

SETUSER
go
print    'csd_sms_bd_perfil'
SETUSER 'dbo'
go
create table dbo.csd_sms_bd_perfil (
id_bd_perfil	char(10)	not null,
dbms	char(100)	null,
bdname	char(50)	null,
servername	char(50)	null,
logid	char(50)	null,
logpass	char(50)	null,
userid	char(50)	null,
dbpass	char(50)	null,
dbparm	char(100)	null,
autocommit	char(1)	null,
prompt	char(20)	null,
constraint csd_sms_bd_perfil_x PRIMARY KEY  NONCLUSTERED ( id_bd_perfil)
)
on 'default'
go

SETUSER
go

print    'csd_sms_campanya'
SETUSER 'dbo'
go
create table dbo.csd_sms_campanya (
id_campanya	char(10)	not null,
descripcion	varchar(150)	null,
id_programado	char(10)	null,
id_sms_predefinido	char(10)	null,
f_creacion	datetime	null,
us_creacion	varchar(50)	null,
activo	char(1)	null,
t_aviso	char(1)	null,
constraint csd_sms_campanya_x PRIMARY KEY  NONCLUSTERED ( id_campanya)
)
on 'default'
go

SETUSER
go
print    'csd_sms_campos'
SETUSER 'dbo'
go
create table dbo.csd_sms_campos (
id_sms_campos	char(10)	not null,
nombre	char(150)	null,
constraint csd_sms_campos_x PRIMARY KEY  NONCLUSTERED ( id_sms_campos)
)
on 'default'
go

SETUSER
go
print    'csd_sms_contactos'
SETUSER 'dbo'
go
create table dbo.csd_sms_contactos (
id_contacto	varchar(20)	not null,
nif	char(15)	null,
nombre	char(60)	null,
apellidos	char(100)	null,
movil_contacto	char(15)	null,
genero	char(1)	null,
direccion_domicilio	char(150)	null,
email	char(30)	null,
f_nacimiento	datetime	null,
cod_tipo_tercero	varchar(20)	null,
id_modulo	varchar(20)	null,
id_colegiado	char(10)	null,
tipo_persona	char(1)	null,
constraint csd_sms_contactos_x PRIMARY KEY  NONCLUSTERED ( id_contacto)
)
on 'default'
go

SETUSER
go
print    'csd_sms_enviados'
SETUSER 'dbo'
go
create table dbo.csd_sms_enviados (
id_sms_enviados	char(10)	not null,
movil_contacto	varchar(15)	null,
nif	varchar(60)	null,
nombre	varchar(60)	null,
apellidos	varchar(100)	null,
f_envio	datetime	null,
envio	char(15)	null,
mensaje	char(160)	null,
id_sms	varchar(10)	null,
id_campanya	varchar(10)	null,
id_sms_predefinido	varchar(10)	null,
envio_mensaje	char(1)	null,
tipo_aviso	char(1)	null,
email	char(60)	null,
fecha_envio_final	datetime	null,
hora_envio	datetime	null,
texto	text	null,
constraint csd_sms_enviados_x PRIMARY KEY  NONCLUSTERED ( id_sms_enviados)
)
on 'default'
go

SETUSER
go
print    'csd_sms_envios'
SETUSER 'dbo'
go
create table dbo.csd_sms_envios (
id_sms_envios	char(10)	not null,
id_sms	char(10)	null,
id_contacto	char(10)	null,
id_grupo	char(10)	null,
id_campanya	char(10)	null,
constraint csd_sms_envios_x PRIMARY KEY  NONCLUSTERED ( id_sms_envios)
)
on 'default'
go

SETUSER
go
print    'csd_sms_grupos'
SETUSER 'dbo'
go
create table dbo.csd_sms_grupos (
id_grupo	char(10)	not null,
t_grupo	char(1)	null,
nombre_grupo	char(150)	null,
activo	char(1)	null,
id_bd_perfil	char(10)	null,
id_campanya	char(10)	null,
constraint csd_sms_grupos_x PRIMARY KEY  NONCLUSTERED ( id_grupo)
)
on 'default'
go

SETUSER
go

print    'csd_sms_grupos_detalle'
SETUSER 'dbo'
go
create table dbo.csd_sms_grupos_detalle (
id_grupo_detalle	char(10)	not null,
id_grupo	char(10)	null,
id_contacto	char(10)	null,
sql	text	null,
constraint csd_sms_grupos_detalle_x PRIMARY KEY  NONCLUSTERED ( id_grupo_detalle)
)
on 'default'
go

SETUSER
go
print    'csd_sms_predefinidos'
SETUSER 'dbo'
go
create table dbo.csd_sms_predefinidos (
id_sms_predifinido	char(10)	not null,
nombre	varchar(100)	null,
mensaje	char(160)	null,
constraint csd_sms_predefinidos_x PRIMARY KEY  NONCLUSTERED ( id_sms_predifinido)
)
on 'default'
go

SETUSER
go
print    'csd_sms_programado'
SETUSER 'dbo'
go
create table dbo.csd_sms_programado (
id_sms_programado	char(10)	not null,
id_sms_campanya	char(10)	null,
id_sms	char(10)	null,
hora	char(1)	null,
h_inicio	datetime	null,
h_fin	datetime	null,
frecuencia	char(1)	null,
dia	char(2)	null,
mes	char(2)	null,
anyo	char(4)	null,
lun	char(1)	null,
mar	char(1)	null,
mie	char(1)	null,
jue	char(1)	null,
vie	char(1)	null,
sab	char(1)	null,
dom	char(1)	null,
intervalo	char(1)	null,
int_comienzo	datetime	null,
repeticion	float	null,
int_fin	datetime	null,
diario	char(1)	null,
mesual	char(1)	null,
frec	char(1)	null,
tipo	char(1)	null,
mes1	char(2)	null,
constraint csd_sms_programado_x PRIMARY KEY  NONCLUSTERED ( id_sms_programado)
)
on 'default'
go

SETUSER
go
print    'csi_aeat_periodo'
SETUSER 'dbo'
go
create table dbo.csi_aeat_periodo (
cod_aeat_periodo	varchar(2)	not null,
descripcion	varchar(100)	null,
constraint csi_aeat_periodo_pk PRIMARY KEY  NONCLUSTERED ( cod_aeat_periodo)
)
on 'default'
go

SETUSER
go
print    'csi_aeat_t_libro_iva'
SETUSER 'dbo'
go
create table dbo.csi_aeat_t_libro_iva (
t_libro_iva	varchar(2)	not null,
descripcion	varchar(100)	null,
constraint i_pk_aeat_t_libro_iva PRIMARY KEY  CLUSTERED ( t_libro_iva)
)
on 'default'
go

SETUSER
go
print    'csi_art_serv_correspo'
SETUSER 'dbo'
go
create table dbo.csi_art_serv_correspo (
id	char(10)	not null,
articulo_externo	char(100)	null,
desc_articulo_externo	char(100)	null,
codigo_articulo	char(10)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( id)
)
on 'default'
go

SETUSER
go

print    'csi_articulos_servicios'
SETUSER 'dbo'
go
create table dbo.csi_articulos_servicios (
codigo	char(10)	not null,
descripcion	text	null,
familia	char(2)	null,
cuenta	char(10)	null,
cta_presupuestaria	char(10)	null,
exp	char(1)	null,
general	char(1)	null,
importe	float	null,
activo	char(1)	null,
es_informe	char(1)	null,
impuesto	float	null,
orden	int	null,
colegio	char(10)	not null,
t_iva	char(2)	null,
honorario	char(1)	null,
impreso	char(15)	null,
en_ficha_colegiado	char(1)	null,
concepto_conta	char(60)	null,
suplido	char(1)	null,
grupo_gastos	char(60)	null,
ing_gas	char(1)	null,
incluir_347	char(1)	null,
tiene_irpf	char(1)	null,
empresa	char(2)	null,
cta_gasto	char(10)	null,
constraint csi_articulos_servicios_x PRIMARY KEY  NONCLUSTERED ( codigo,colegio)
)
on 'default'
go
print   'codigo'
create unique nonclustered index codigo
on dbo.csi_articulos_servicios (codigo)
on 'default'
go

go

SETUSER
go
print    'csi_asientos_predefinidos'
SETUSER 'dbo'
go
create table dbo.csi_asientos_predefinidos (
id_asiento	char(10)	not null,
cod_asiento	char(3)	null,
tipo	char(2)	null,
titulo	char(255)	null,
empresa	char(2)	null,
constraint primarykey PRIMARY KEY  NONCLUSTERED ( id_asiento)
)
on 'default'
go

SETUSER
go
print    'csi_balances'
SETUSER 'dbo'
go
create table dbo.csi_balances (
t_balance	char(3)	not null,
a_p	char(1)	not null,
linea	char(5)	not null,
cuentas	char(150)	null,
descripcion	char(100)	null,
negrita	char(1)	null,
flag_suma_lineas	char(1)	null,
orden	int	null,
num_bloque	int	null,
indentacion	int	null,
flag_procesar	char(1)	null,
constraint csi_balances_x PRIMARY KEY  NONCLUSTERED ( t_balance,a_p,linea)
)
on 'default'
go

SETUSER
go
print    'csi_balances_a_p_balance'
SETUSER 'dbo'
go
create table dbo.csi_balances_a_p_balance (
codigo	char(3)	not null,
descripcion	char(40)	null,
constraint csi_balances_a_p_balance_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'csi_balances_cuentas_especial'
SETUSER 'dbo'
go
create table dbo.csi_balances_cuentas_especial (
cuenta	char(10)	not null,
t_balance	char(3)	not null,
t_funcion	char(4)	null,
constraint csi_balances_cuentas_especial_ PRIMARY KEY  NONCLUSTERED ( cuenta,t_balance)
)
on 'default'
go

SETUSER
go
print    'csi_balances_fun_especial'
SETUSER 'dbo'
go
create table dbo.csi_balances_fun_especial (
codigo	char(4)	not null,
descripcion	char(140)	null,
constraint csi_balances_fun_especial_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go

print    'csi_balances_pyg_mes'
SETUSER 'dbo'
go
create table dbo.csi_balances_pyg_mes (
mes	char(2)	not null,
cuenta	char(10)	not null,
saldo	float	null,
fecha	datetime	null,
empresa	char(2)	not null,
anyo	char(4)	not null,
constraint csi_balances_pyg_mes_x PRIMARY KEY  NONCLUSTERED ( mes,cuenta,empresa,anyo)
)
on 'default'
go

SETUSER
go
print    'csi_balances_t_balance'
SETUSER 'dbo'
go
create table dbo.csi_balances_t_balance (
codigo	char(3)	not null,
descripcion	char(40)	null,
balance08	varchar(1)	null,
constraint csi_balances_t_balance_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'csi_bancos'
SETUSER 'dbo'
go
create table dbo.csi_bancos (
codigo	char(10)	not null,
nombre	char(40)	null,
cuenta_contable	char(10)	not null,
entidad	char(4)	null,
sucursal	char(4)	null,
cod_seg	char(2)	null,
cuenta_banco	char(10)	null,
cod_presentador	char(12)	null,
empresa	char(2)	not null,
cuenta_efecto	char(10)	null,
domicilio	char(30)	null,
localidad	char(30)	null,
cp	char(5)	null,
pais	char(15)	null,
cif	char(15)	null,
sufijo_csb19	char(12)	null,
telefono	char(30)	null,
fax	char(30)	null,
observaciones	varchar(255)	null,
contacto	varchar(100)	null,
cuenta_efecto_cobros	char(10)	null,
limite_concedido	float	null,
constraint csi_bancos_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'csi_bancos_maestro'
SETUSER 'dbo'
go
create table dbo.csi_bancos_maestro (
cod	char(10)	not null,
descripcion	char(60)	null,
constraint csi_bancos_maestro_x PRIMARY KEY  NONCLUSTERED ( cod)
)
on 'default'
go

SETUSER
go
print    'csi_centros'
SETUSER 'dbo'
go
create table dbo.csi_centros (
centro	char(3)	not null,
empresa	char(2)	not null,
descripcion	char(40)	null,
constraint csi_centros_x PRIMARY KEY  NONCLUSTERED ( centro,empresa)
)
on 'default'
go

SETUSER
go
print    'csi_claves_retencion'
SETUSER 'dbo'
go
create table dbo.csi_claves_retencion (
clave	char(1)	not null,
subclave	char(2)	not null,
descripcion	char(255)	null,
porcent_reten	float	null,
seleccionable	char(1)	null,
constraint i_csi_claves_retencion PRIMARY KEY  NONCLUSTERED ( clave,subclave)
)
on 'default'
go

SETUSER
go

print    'csi_cobros'
SETUSER 'dbo'
go
create table dbo.csi_cobros (
id_pago	char(10)	not null,
id_factura	char(10)	null,
forma_pago	char(2)	null,
importe	float	null,
f_pago	datetime	null,
pagado	char(1)	null,
f_vencimiento	datetime	null,
n_talon	char(15)	null,
banco	char(10)	null,
cuenta	char(10)	null,
centro	char(10)	null,
proyecto	char(10)	null,
cta_presupuestaria	char(10)	null,
verificado	char(10)	null,
f_verificado	datetime	null,
contabilizado	char(1)	null,
f_contabilizado	datetime	null,
importe_gastos	float	null,
cuenta_gastos	char(10)	null,
n_remesa	char(10)	null,
devuelto	char(1)	null,
id_cobro_multiple	char(10)	null,
devolucion_motivo	char(2)	null,
n_plazo	char(10)	null,
cod_usuario	char(10)	null,
empresa	char(2)	null,
constraint csi_pagos_x PRIMARY KEY  NONCLUSTERED ( id_pago)
)
on 'default'
go
print   'f_pago_x'
create nonclustered index f_pago_x
on dbo.csi_cobros (f_pago)
on 'default'
go

print   'id_factura_x'
create nonclustered index id_factura_x
on dbo.csi_cobros (id_factura)
on 'default'
go

go

SETUSER
go
print    'csi_cobros_multiples'
SETUSER 'dbo'
go
create table dbo.csi_cobros_multiples (
id_cobro_multiple	char(10)	not null,
forma_pago	char(2)	null,
banco	char(10)	null,
importe	float	null,
fecha	datetime	null,
pagador	char(100)	null,
expediente	char(100)	null,
contabilizado	char(1)	null,
f_contabilizado	datetime	null,
n_talon	char(15)	null,
cod_usuario	char(10)	null,
centro	char(10)	null,
diferencia	float	null,
id_pagador	char(10)	null,
tipo_pagador	char(1)	null,
lista_fact	char(150)	null,
empresa	char(2)	null,
constraint id_cobro_multiple_x PRIMARY KEY  NONCLUSTERED ( id_cobro_multiple)
)
on 'default'
go

SETUSER
go
print    'csi_columnas_importe'
SETUSER 'dbo'
go
create table dbo.csi_columnas_importe (
campo	char(50)	not null,
constraint csi_columnas_importe_x PRIMARY KEY  NONCLUSTERED ( campo)
)
on 'default'
go

SETUSER
go
print    'csi_control_ejercicios'
SETUSER 'dbo'
go
create table dbo.csi_control_ejercicios (
ejercicio	char(4)	not null,
empresa	char(2)	not null,
constraint csi_control_ejercicios_x PRIMARY KEY  NONCLUSTERED ( ejercicio,empresa)
)
on 'default'
go

SETUSER
go
print    'csi_datos_economicos_anyo'
SETUSER 'dbo'
go
create table dbo.csi_datos_economicos_anyo (
anyo	char(4)	not null,
tipo_interes	float	null,
porcent_reten	float	null,
ipc	float	null,
constraint pk1 PRIMARY KEY  NONCLUSTERED ( anyo)
)
on 'default'
go

SETUSER
go
print    'csi_diarios_parametrizaciones'
SETUSER 'dbo'
go
create table dbo.csi_diarios_parametrizaciones (
id	char(10)	not null,
empresa	char(2)	null,
diario	char(3)	null,
centro	char(3)	null,
proyecto	char(5)	null,
constraint csi_diarios_parametrizacs_x PRIMARY KEY  NONCLUSTERED ( id)
)
on 'default'
go

SETUSER
go

print    'csi_ejercicios_abiertos'
SETUSER 'dbo'
go
create table dbo.csi_ejercicios_abiertos (
ejercicio	char(4)	not null,
empresa	char(2)	not null,
fecha_limite	datetime	null,
sincronizacion_pgc_ant	char(1)	null,
sincronizacion_pgc_post	char(1)	null,
constraint csi_ejercicios_abiertos_x PRIMARY KEY  NONCLUSTERED ( ejercicio,empresa)
)
on 'default'
go

SETUSER
go
print    'csi_elems_inmovilizado'
SETUSER 'dbo'
go
create table dbo.csi_elems_inmovilizado (
id_elem_inmovilizado	char(10)	not null,
coste	float	null,
f_adquisicion	datetime	null,
amortizado_anterior	float	null,
total_amortizado	float	null,
concepto	char(120)	null,
n_fact	char(15)	null,
cuenta_inmovilizado	char(10)	null,
cuenta_amortizacion	char(10)	null,
cuenta_dotacion	char(10)	null,
porcentaje	float	null,
anyo_ult_amortizacion	char(4)	null,
f_baja	datetime	null,
moneda	char(1)	null,
amortizado	char(1)	null,
num	int	null,
empresa	char(2)	null,
n_fact_prov	char(10)	null,
id_factura	char(10)	null,
sujeto_ric	char(1)	null,
f_aux_dotacion	datetime	null,
f_fin_ric	datetime	null,
centro	char(3)	null,
edificio	char(5)	null,
planta	char(5)	null,
habitacion	char(5)	null,
etiquetado	char(1)	null,
n_elem_inmovilizado	char(10)	null,
nombre_proveedor	char(40)	null,
constraint csi_elems_inmovilizado_x PRIMARY KEY  NONCLUSTERED ( id_elem_inmovilizado)
)
on 'default'
go

SETUSER
go
print    'csi_elems_inmovilizado_acum'
SETUSER 'dbo'
go
create table dbo.csi_elems_inmovilizado_acum (
id_acum	char(10)	not null,
id_elem	char(10)	null,
importe	float	null,
anyo	char(4)	null,
mes	char(2)	null,
constraint csi_elems_inmov_acum_x PRIMARY KEY  NONCLUSTERED ( id_acum)
)
on 'default'
go

SETUSER
go
print    'csi_elems_inmovilizado_mensual'
SETUSER 'dbo'
go
create table dbo.csi_elems_inmovilizado_mensual (
id_elem_inmovilizado	char(10)	not null,
coste	float	null,
f_adquisicion	datetime	null,
amortizado_anterior	float	null,
total_amortizado	float	null,
concepto	char(120)	null,
n_fact	char(15)	null,
n_fact_prov	char(15)	null,
cuenta_inmovilizado	char(10)	null,
cuenta_amortizacion	char(10)	null,
cuenta_dotacion	char(10)	null,
porcentaje	float	null,
anyo_ult_amortizacion	char(4)	null,
f_baja	datetime	null,
moneda	char(1)	null,
amortizado	char(1)	null,
num	int	null,
empresa	char(2)	null,
mes_ult_amortizacion	char(2)	null,
id_factura	char(10)	null,
sujeto_ric	char(1)	null,
f_aux_dotacion	datetime	null,
f_fin_ric	datetime	null,
centro	char(3)	null,
edificio	char(5)	null,
planta	char(5)	null,
habitacion	char(5)	null,
etiquetado	char(1)	null,
n_elem_inmovilizado	char(10)	null,
nombre_proveedor	char(40)	null,
constraint csi_elems_inmovilizado_x PRIMARY KEY  NONCLUSTERED ( id_elem_inmovilizado)
)
on 'default'
go

SETUSER
go
print    'csi_elems_inmovilizado_porcent'
SETUSER 'dbo'
go
create table dbo.csi_elems_inmovilizado_porcent (
id_porcent	char(10)	not null,
id_elem	char(10)	null,
porcent	float	null,
anyo	char(4)	null,
mes	char(2)	null,
constraint csi_elems_inmov_porc_x PRIMARY KEY  NONCLUSTERED ( id_porcent)
)
on 'default'
go

SETUSER
go
print    'csi_empresas'
SETUSER 'dbo'
go
create table dbo.csi_empresas (
codigo	varchar(5)	not null,
nombre	varchar(150)	null,
nif	varchar(15)	null,
direccion	varchar(60)	null,
poblacion	varchar(30)	null,
codigo_postal	varchar(5)	null,
provincia	varchar(2)	null,
telefono	varchar(20)	null,
fax	varchar(20)	null,
inscripcion	varchar(100)	null,
cuenta_bancaria	varchar(20)	null,
numeracion	float	null,
facturacion	varchar(1)	null,
nombre_corto	varchar(30)	null,
prefijo_factura	varchar(2)	null,
logo	varchar(60)	null,
centro	varchar(3)	null,
proyecto	varchar(5)	null,
es_colegio	varchar(1)	null,
etiqueta_superior_listados	varchar(15)	null,
pendiente_devengar_fe	varchar(1)	null,
pendiente_devengar_fr	varchar(1)	null,
coste	varchar(1)	null,
direccion_corta	varchar(36)	null,
imagen_fondo	varchar(100)	null,
devolucion_mensual	varchar(1)	null,
banco_defecto	char(10)	null,
constraint empresas_x PRIMARY KEY  CLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go

print    'csi_equiv_copia_empresa'
SETUSER 'dbo'
go
create table dbo.csi_equiv_copia_empresa (
id	char(10)	not null,
id_origen	char(10)	null,
id_destino	char(10)	null,
empresa_origen	char(2)	null,
empresa_destino	char(2)	null,
ambito	char(2)	null,
constraint csi_equiv_copia_empresa_x PRIMARY KEY  NONCLUSTERED ( id)
)
on 'default'
go
print   'i_equiv_copia'
create nonclustered index i_equiv_copia
on dbo.csi_equiv_copia_empresa (id_origen, empresa_destino, ambito)
on 'default'
go

go

SETUSER
go
print    'csi_existencias_finales'
SETUSER 'dbo'
go
create table dbo.csi_existencias_finales (
anyo	char(4)	not null,
empresa	char(2)	not null,
valor	float	null,
constraint csi_existencias_finales_x PRIMARY KEY  NONCLUSTERED ( anyo,empresa)
)
on 'default'
go

SETUSER
go
print    'csi_fact_reclamaciones'
SETUSER 'dbo'
go
create table dbo.csi_fact_reclamaciones (
id_reclamacion_factura	char(10)	not null,
id_factura	char(10)	null,
id_grupo	char(10)	null,
f_reclamacion	datetime	null,
tipo_reclamacion	char(2)	null,
constraint csi_fact_reclamaciones_x PRIMARY KEY  NONCLUSTERED ( id_reclamacion_factura)
)
on 'default'
go

SETUSER
go
print    'csi_fact_reclamaciones_tipos'
SETUSER 'dbo'
go
create table dbo.csi_fact_reclamaciones_tipos (
tipo_reclamacion	char(2)	not null,
descripcion	char(60)	null,
tipo_persona	char(1)	null,
remesada	char(1)	null,
agrupar	char(1)	null,
codigo_siguiente	char(2)	null,
orden	char(2)	null,
dw	char(150)	null,
constraint csi_fact_reclamaciones_tipos_x PRIMARY KEY  NONCLUSTERED ( tipo_reclamacion)
)
on 'default'
go

SETUSER
go
print    'csi_facturas_emitidas'
SETUSER 'dbo'
go
create table dbo.csi_facturas_emitidas (
n_fact	char(15)	null,
fecha	datetime	not null,
n_col	char(15)	null,
nif	char(15)	null,
nombre	char(40)	null,
domicilio	char(40)	null,
poblacion	char(40)	null,
proyecto	char(10)	null,
cuenta	char(10)	null,
tipo_persona	char(1)	null,
contado	char(1)	null,
pagado	char(1)	null,
base_imp	float	null,
iva	float	null,
txt_desc	char(20)	null,
descuento	float	null,
total	float	null,
subtotal	float	null,
f_pago	datetime	null,
emitida	char(1)	null,
reimpresa	char(1)	null,
formadepago	char(2)	null,
contabilizada	char(1)	null,
f_conta	datetime	null,
conta_pago	char(1)	null,
f_conta_pago	datetime	null,
notas	char(40)	null,
asunto	char(200)	null,
obs	char(200)	null,
id_factura	char(15)	not null,
csi_centro	char(3)	null,
centro	char(10)	null,
banco	char(10)	null,
id_persona	char(10)	null,
t_iva	char(2)	null,
moneda	char(1)	null,
tipo_reten	float	null,
cuenta_reten	char(10)	null,
importe_reten	float	null,
tipo_factura	char(2)	null,
emisor	char(15)	null,
id_fase	char(10)	null,
usuario	char(10)	null,
id_ingreso	char(10)	null,
n_fact_unico	char(20)	null,
id_liquidacion	char(10)	null,
anulada	char(1)	null,
abonada	char(1)	null,
irpf_colegio	float	null,
id_minuta	char(10)	null,
empresa	char(2)	null,
codigo	char(2)	null,
visared	char(1)	null,
id_cliente_pagador	char(10)	null,
nif_pagador	char(15)	null,
nombre_pagador	char(40)	null,
domicilio_pagador	char(40)	null,
poblacion_pagador	char(40)	null,
orden_apunte	char(10)	null,
observaciones_text	text	null,
solo_pagos	char(1)	null,
otro_pagador	char(1)	null,
reclamar	char(1)	null,
domicilio_largo	char(100)	null,
domicilio_pagador_largo	char(100)	null,
exportado_a_pdf	char(1)	null,
firmado	varchar(1)	null,
email_emisor	char(255)	null,
constraint csi_facturas_emitidas PRIMARY KEY  NONCLUSTERED ( id_factura )
)
on 'default'
go
print   'fecha_x'
create nonclustered index fecha_x
on dbo.csi_facturas_emitidas (fecha)
on 'default'
go

print   'id_fase'
create nonclustered index id_fase
on dbo.csi_facturas_emitidas (id_fase)
on 'default'
go

print   'id_liquidacion_x'
create nonclustered index id_liquidacion_x
on dbo.csi_facturas_emitidas (id_liquidacion)
on 'default'
go

print   'id_minuta'
create nonclustered index id_minuta
on dbo.csi_facturas_emitidas (id_minuta)
on 'default'
go

print   'pagado'
create nonclustered index pagado
on dbo.csi_facturas_emitidas (pagado)
on 'default'
go

go

SETUSER
go
print    'csi_facturas_inmovilizado'
SETUSER 'dbo'
go
create table dbo.csi_facturas_inmovilizado (
id_factura	char(10)	not null,
total_amortizado	float	null,
amortizado	char(1)	null,
descripcion	char(60)	null,
baja	char(1)	null,
constraint csi_facturas_inmovilizado_x PRIMARY KEY  NONCLUSTERED ( id_factura)
)
on 'default'
go

SETUSER
go

print    'csi_facturas_recibidas'
SETUSER 'dbo'
go
create table dbo.csi_facturas_recibidas (
id_factura	char(10)	not null,
n_fact	char(15)	not null,
fecha	datetime	not null,
id_prov	char(10)	null,
nombre	char(40)	null,
domicilio	char(40)	null,
poblacion	char(40)	null,
centro	char(10)	null,
grupo	char(10)	null,
cuenta	char(10)	null,
banco	char(10)	null,
contrapartida	char(10)	null,
pagado	char(1)	null,
f_pago	datetime	null,
contabilizado	char(1)	null,
f_conta	datetime	null,
formadepago	char(30)	null,
importe	float	null,
tipo_iva	float	null,
total	float	null,
notas	char(40)	null,
visto_bueno	char(1)	null,
f_vbueno	datetime	null,
n_emision	char(15)	null,
f_emision	datetime	null,
entidad	char(4)	null,
sucursal	char(4)	null,
cod	char(2)	null,
cuenta_prov	char(10)	null,
n_arqui	char(5)	null,
tipo_reten	float	null,
n_fact_prov	char(15)	null,
inmovilizado	char(1)	null,
t_iva	char(2)	null,
moneda	char(1)	null,
f_venc	datetime	null,
cuenta_reten	char(10)	null,
importe_iva	float	null,
importe_irpf	float	null,
empresa	char(2)	null,
f_introd	datetime	null,
importe_rg	float	null,
cuemta_rg	char(10)	null,
numeracion_general	char(1)	null,
solo_pagos	char(1)	null,
id_predefinido	char(10)	null,
cuenta_gastos	char(10)	null,
obs	text	null,
base_sujeta_irpf	float	null,
provisional	char(1)	null,
nif	varchar(15)	null,
porcent_reten_adic	float	null,
cuenta_reten_adic	char(10)	null,
importe_reten_adic	float	null,
clave_ret	varchar(3)	null,
f_operacion	datetime	null,
t_libro_iva	varchar(2)	null,
constraint csi_facturas_recibidas_x PRIMARY KEY  NONCLUSTERED ( id_factura)
)
on 'default'
go

SETUSER
go
print    'csi_familias'
SETUSER 'dbo'
go
create table dbo.csi_familias (
cod_familia	char(2)	not null,
descripcion	char(60)	null,
cuenta	char(10)	null,
cta_presupuestaria	char(10)	null,
orden	int	null,
constraint csi_familias_x PRIMARY KEY  NONCLUSTERED ( cod_familia)
)
on 'default'
go

SETUSER
go
print    'csi_formas_de_pago'
SETUSER 'dbo'
go
create table dbo.csi_formas_de_pago (
tipo_pago	nvarchar(2)	not null,
descripcion	nvarchar(60)	null,
tipo	nvarchar(1)	null,
cuenta	nvarchar(10)	null,
contado	char(1)	null,
n_vencimientos	float	null,
dias_primer_vencimiento	float	null,
dias_entre_vencimiento	float	null,
hay_ingreso	char(1)	null,
efecto	char(1)	null,
porcent_primero	float	null,
porcent_resto	float	null,
descripcion_breve	char(20)	null,
banco_asociado	char(10)	null,
fp_extra	char(1)	null,
prefijo_cuenta_contable_banco	char(4)	null,
declara_metalico_347	char(1)	null,
constraint csi_formas_de_pago_x PRIMARY KEY  NONCLUSTERED ( tipo_pago)
)
on 'default'
go

SETUSER
go
print    'csi_formas_de_pago_correspo'
SETUSER 'dbo'
go
create table dbo.csi_formas_de_pago_correspo (
id	nvarchar(10)	not null,
forma_pago_externa	nvarchar(100)	null,
tipo_pago	nvarchar(2)	null,
constraint fpago_correspo_x PRIMARY KEY  NONCLUSTERED ( id)
)
on 'default'
go

SETUSER
go
print    'csi_formulas_asientos_prede'
SETUSER 'dbo'
go
create table dbo.csi_formulas_asientos_prede (
campo	char(255)	not null,
descripcion	char(255)	null,
constraint csi_formulas_asientos_prede_x PRIMARY KEY  NONCLUSTERED ( campo)
)
on 'default'
go

SETUSER
go
print    'csi_lineas_asientos_prede'
SETUSER 'dbo'
go
create table dbo.csi_lineas_asientos_prede (
id_linea_asiento	char(10)	not null,
cod_asiento	char(3)	null,
nombre	char(255)	null,
formula	char(1)	null,
valor	char(255)	null,
id_asiento	char(10)	null,
numero_fila	char(5)	null,
constraint csi_lineas_asientos_prede PRIMARY KEY  NONCLUSTERED ( id_linea_asiento )
)
on 'default'
go

SETUSER
go

print    'csi_lineas_fact_emitidas'
SETUSER 'dbo'
go
create table dbo.csi_lineas_fact_emitidas (
id_factura	char(10)	null,
id_linea	char(10)	not null,
colegio	char(10)	null,
descripcion	char(40)	null,
precio	float	null,
unidades	float	null,
subtotal	float	null,
articulo	char(10)	null,
t_iva	char(2)	null,
subtotal_iva	float	null,
total	float	null,
porcent_dto	float	null,
importe_dto	float	null,
cuenta	char(10)	null,
centro	char(10)	null,
proyecto	char(10)	null,
cta_presupuestaria	char(10)	null,
id_persona	char(10)	null,
tipo_persona	char(1)	null,
id_fase	char(10)	null,
fecha	datetime	null,
id_recibo	char(10)	null,
descripcion_larga	char(255)	null,
porcent_irpf	float	null,
importe_irpf	float	null,
aplica_irpf_colegio	char(1)	null,
constraint csi_lineas_fact_emitidas PRIMARY KEY  NONCLUSTERED ( id_linea )
)
on 'default'
go
print   'id_factura_x'
create nonclustered index id_factura_x
on dbo.csi_lineas_fact_emitidas (id_factura)
on 'default'
go

go

SETUSER
go
print    'csi_lineas_fact_rec_clasi'
SETUSER 'dbo'
go
create table dbo.csi_lineas_fact_rec_clasi (
id_factura	char(10)	null,
id_linea	char(10)	not null,
subtotal	float	null,
subtotal_iva	float	null,
cuenta	char(10)	null,
centro	char(10)	null,
proyecto	char(10)	null,
cta_presupuestaria	char(10)	null,
t_iva	char(10)	null,
total	float	null,
tipo_clasifica	char(2)	null,
inmovilizado	char(1)	null,
pendiente_devengar	char(1)	null,
concepto_contable	char(150)	null,
coste	char(1)	null,
constraint csi_lineas_fact_rec_clasifica_ PRIMARY KEY  NONCLUSTERED ( id_linea)
)
on 'default'
go

SETUSER
go
print    'csi_lineas_fact_recibidas'
SETUSER 'dbo'
go
create table dbo.csi_lineas_fact_recibidas (
id_factura	char(10)	null,
id_linea	char(10)	not null,
descripcion	char(40)	null,
precio	float	null,
unidades	float	null,
subtotal	float	null,
articulo	char(10)	null,
t_iva	char(2)	null,
subtotal_iva	float	null,
total	float	null,
porcent_dto	float	null,
importe_dto	float	null,
cuenta	char(10)	null,
centro	char(10)	null,
proyecto	char(10)	null,
cta_presupuestaria	char(10)	null,
inmovilizado	char(1)	null,
pendiente_devengar	char(1)	null,
deducible	char(1)	null,
incluir_347	char(1)	null,
constraint csi_lineas_fact_recibidas_x PRIMARY KEY  NONCLUSTERED ( id_linea)
)
on 'default'
go

SETUSER
go
print    'csi_meses'
SETUSER 'dbo'
go
create table dbo.csi_meses (
mes	char(2)	not null,
descripcion	char(15)	null,
constraint csi_meses_x PRIMARY KEY  NONCLUSTERED ( mes)
)
on 'default'
go

SETUSER
go
print    'csi_npgc_tablas_modif'
SETUSER 'dbo'
go
create table dbo.csi_npgc_tablas_modif (
codigo	varchar(5)	not null,
nombre_tabla	varchar(30)	null,
campo1	varchar(30)	null,
campo2	varchar(30)	null,
campo3	varchar(30)	null,
campo4	varchar(30)	null,
campo5	varchar(30)	null,
campo6	varchar(30)	null,
campo7	varchar(30)	null,
key1	varchar(30)	null,
key2	varchar(30)	null,
key3	varchar(30)	null,
key4	varchar(30)	null,
key5	varchar(30)	null,
activo	varchar(1)	null,
transaccion	varchar(10)	null,
constraint csi_npgc_tablas_modif_pk PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'csi_pagos'
SETUSER 'dbo'
go
create table dbo.csi_pagos (
id_pago	char(10)	not null,
id_factura	char(10)	null,
forma_pago	char(2)	null,
importe	float	null,
f_pago	datetime	null,
pagado	char(1)	null,
f_vencimiento	datetime	null,
n_talon	char(15)	null,
banco	char(10)	null,
cuenta	char(10)	null,
centro	char(10)	null,
proyecto	char(10)	null,
cta_presupuestaria	char(10)	null,
verificado	char(10)	null,
f_verificado	datetime	null,
contabilizado	char(1)	null,
f_contabilizado	datetime	null,
importe_gastos	float	null,
cuenta_gastos	char(10)	null,
estado	char(2)	null,
descripcion	char(255)	null,
efecto	char(1)	null,
n_efecto	char(15)	null,
otro_numero	char(15)	null,
emitido	char(1)	null,
f_emitido	datetime	null,
n_remesa	char(10)	null,
constraint csi_pagos_x PRIMARY KEY  NONCLUSTERED ( id_pago)
)
on 'default'
go

SETUSER
go

print    'csi_param_sigescon'
SETUSER 'dbo'
go
create table dbo.csi_param_sigescon (
nombre	char(40)	not null,
valor_numerico	float	null,
valor_texto	char(200)	null,
valor_fecha	datetime	null,
descripcion	char(255)	null,
constraint csi_param_sigescon_x PRIMARY KEY  NONCLUSTERED ( nombre)
)
on 'default'
go

SETUSER
go
print    'csi_proveedores'
SETUSER 'dbo'
go
create table dbo.csi_proveedores (
id_proveedor	char(10)	not null,
codigo	char(4)	null,
nombre	char(40)	null,
domicilio	char(40)	null,
codigo_postal	char(5)	null,
poblacion	char(20)	null,
telefono	char(9)	null,
fax	char(9)	null,
iva	int	null,
cuenta_contable	char(10)	null,
cuenta_gastos	char(10)	null,
observaciones	char(50)	null,
entidad	char(4)	null,
sucursal	char(4)	null,
control	char(2)	null,
cuenta_banco	char(10)	null,
empresa	char(2)	null,
cuenta_retencion	char(10)	null,
porcent_reten	float	null,
formadepago	char(2)	null,
email	varchar(100)	null,
http	varchar(100)	null,
banco	char(10)	null,
t_iva	char(2)	null,
cif	varchar(15)	null,
clave_ret	char(3)	null,
referencia	char(20)	null,
contacto	char(100)	null,
cod_pais	char(10)	null,
activo	char(1)	null,
puntuacion	float	null,
cod_grupo	char(2)	null,
telefono2	char(20)	null,
f_aprobacion	datetime	null,
c_personalidad	char(2)	null,
porcent_reten_adic	float	null,
cuenta_reten_adic	char(10)	null,
constraint csi_proveedores_x PRIMARY KEY  NONCLUSTERED ( id_proveedor)
)
on 'default'
go

SETUSER
go
print    'csi_proveedores_aprobacion'
SETUSER 'dbo'
go
create table dbo.csi_proveedores_aprobacion (
id_proveedores_aprobacion	char(10)	not null,
id_proveedor	char(10)	null,
t_aprobacion	char(2)	null,
f_desde	datetime	null,
f_hasta	datetime	null,
activo	char(1)	null,
obs	char(255)	null,
constraint csi_proveedores_aprobacion_x PRIMARY KEY  NONCLUSTERED ( id_proveedores_aprobacion)
)
on 'default'
go

SETUSER
go
print    'csi_proveedores_evaluacion'
SETUSER 'dbo'
go
create table dbo.csi_proveedores_evaluacion (
id_proveedores_evaluacion	char(10)	not null,
id_proveedor	char(10)	null,
t_evaluacion	char(2)	null,
f_desde	datetime	null,
f_hasta	datetime	null,
nombre_documento	char(255)	null,
n_pedido	char(20)	null,
ok	char(1)	null,
n_incidencia	char(20)	null,
obs	char(255)	null,
constraint csi_proveedores_evaluacion_x PRIMARY KEY  NONCLUSTERED ( id_proveedores_evaluacion)
)
on 'default'
go

SETUSER
go
print    'csi_proyectos'
SETUSER 'dbo'
go
create table dbo.csi_proyectos (
proyecto	char(5)	not null,
descripcion	char(40)	null,
empresa	char(2)	not null,
activo	char(1)	null,
constraint csi_proyectos_x PRIMARY KEY  NONCLUSTERED ( proyecto,empresa)
)
on 'default'
go

SETUSER
go
print    'csi_relacion_cuentas_npgc'
SETUSER 'dbo'
go
create table dbo.csi_relacion_cuentas_npgc (
cuenta_old	varchar(10)	not null,
cuenta_new	varchar(10)	null,
activa	varchar(1)	null,
conta	varchar(1)	null,
constraint csi_relacion_cuentas_npgc_pk PRIMARY KEY  NONCLUSTERED ( cuenta_old)
)
on 'default'
go

SETUSER
go

print    'csi_series'
SETUSER 'dbo'
go
create table dbo.csi_series (
serie	char(10)	not null,
usuarios	char(255)	null,
cod_apli	char(4)	null,
empresa	char(2)	not null,
contador	float	null,
descripcion	char(60)	null,
recib	char(1)	null,
anyo	char(4)	not null,
dataobject	char(100)	null,
tipo	char(1)	null,
constraint csi_series_x PRIMARY KEY  NONCLUSTERED ( serie,anyo,empresa)
)
on 'default'
go

SETUSER
go
print    'csi_t_aprobacion'
SETUSER 'dbo'
go
create table dbo.csi_t_aprobacion (
t_aprobacion	char(2)	not null,
descripcion	char(100)	null,
constraint csi_t_aprobacion_x PRIMARY KEY  NONCLUSTERED ( t_aprobacion)
)
on 'default'
go

SETUSER
go
print    'csi_t_asientos'
SETUSER 'dbo'
go
create table dbo.csi_t_asientos (
t_asiento	char(3)	not null,
descripcion	char(40)	null,
constraint csi_t_asientos_x PRIMARY KEY  NONCLUSTERED ( t_asiento)
)
on 'default'
go

SETUSER
go
print    'csi_t_asientos_predefinidos'
SETUSER 'dbo'
go
create table dbo.csi_t_asientos_predefinidos (
tipo	char(2)	not null,
descripcion	char(60)	null,
constraint i_t_asi_prede PRIMARY KEY  NONCLUSTERED ( tipo)
)
on 'default'
go

SETUSER
go
print    'csi_t_conciliacion'
SETUSER 'dbo'
go
create table dbo.csi_t_conciliacion (
tipo	char(2)	not null,
descripcion	char(40)	null,
constraint csi_t_conciliacion_x PRIMARY KEY  NONCLUSTERED ( tipo)
)
on 'default'
go

SETUSER
go
print    'csi_t_destinatario_347'
SETUSER 'dbo'
go
create table dbo.csi_t_destinatario_347 (
codigo	char(3)	not null,
descripcion	char(60)	not null,
constraint csi_t_destinatario_347_pk PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go

print    'csi_t_documento'
SETUSER 'dbo'
go
create table dbo.csi_t_documento (
t_doc	char(2)	not null,
descripcion	char(40)	null,
constraint csi_t_documento_x PRIMARY KEY  NONCLUSTERED ( t_doc)
)
on 'default'
go

SETUSER
go
print    'csi_t_estado_pago'
SETUSER 'dbo'
go
create table dbo.csi_t_estado_pago (
tipo	char(2)	not null,
descripcion	char(40)	null,
constraint csi_t_estado_pago_x PRIMARY KEY  NONCLUSTERED ( tipo)
)
on 'default'
go

SETUSER
go
print    'csi_t_evaluacion'
SETUSER 'dbo'
go
create table dbo.csi_t_evaluacion (
t_evaluacion	char(2)	not null,
descripcion	char(100)	null,
constraint csi_t_evaluacion_x PRIMARY KEY  NONCLUSTERED ( t_evaluacion)
)
on 'default'
go

SETUSER
go
print    'csi_t_iva'
SETUSER 'dbo'
go
create table dbo.csi_t_iva (
t_iva	char(2)	not null,
descripcion	char(40)	null,
porcent	float	null,
id_cuenta_repercutido	char(10)	null,
porcent_re	float	null,
id_cuenta_re	nvarchar(10)	null,
id_cuenta_soportado	char(10)	null,
id_cuenta_inmovilizado	char(10)	null,
iva_incluido	char(1)	null,
valido_empresa	char(1)	null,
t_iva_asociado	char(2)	null,
cuenta_repercutido_no_deven	char(10)	null,
cuenta_soportado_no_deven	char(10)	null,
cuenta_repercutido_no_deduc	char(10)	null,
cuenta_soportado_no_deduc	char(10)	null,
exento	char(1)	null,
constraint csi_t_iva_x PRIMARY KEY  NONCLUSTERED ( t_iva)
)
on 'default'
go

SETUSER
go
print    'csi_tipo_presupuesto'
SETUSER 'dbo'
go
create table dbo.csi_tipo_presupuesto (
codigo	char(3)	not null,
descripcion	char(60)	null,
tipo_partida	char(1)	null,
constraint csi_tipo_presupuesto_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'csi_traspasos_basicos'
SETUSER 'dbo'
go
create table dbo.csi_traspasos_basicos (
id_traspaso	char(10)	not null,
tipo	char(2)	null,
fecha	datetime	null,
numero	char(10)	null,
id_colegiado	char(10)	null,
forma_pago	char(2)	null,
banco	char(10)	null,
importe	float	null,
n_talon	char(10)	null,
descripcion	char(255)	null,
centro	char(3)	null,
usuario	char(10)	null,
eliminar	char(1)	null,
constraint csi_traspasos_basicos_x PRIMARY KEY  NONCLUSTERED ( id_traspaso)
)
on 'default'
go

SETUSER
go

print    'csi_trimestres'
SETUSER 'dbo'
go
create table dbo.csi_trimestres (
id_trimestres	nvarchar(1)	not null,
descripcion	nvarchar(15)	null,
constraint csi_trimestres_x PRIMARY KEY  NONCLUSTERED ( id_trimestres)
)
on 'default'
go

SETUSER
go
print    'cuentas_pyme'
SETUSER 'dbo'
go
create table dbo.cuentas_pyme (
cuenta	nvarchar(10)	not null,
titulo	varchar(50)	null,
resumen	nvarchar(15)	null,
final	varchar(1)	null,
empresa	varchar(1)	null,
debe	float	null,
haber	float	null,
saldo	float	null,
presupuesto	float	null,
id_col	nvarchar(10)	null,
s1	float	null,
s2	float	null,
s3	float	null,
ica	float	null,
otros	float	null,
constraint CUENTA_X PRIMARY KEY  NONCLUSTERED ( cuenta)
)
on 'default'
go
print   'i_id_col'
create nonclustered index i_id_col
on dbo.cuentas_pyme (id_col)
on 'default'
go

print   'i_titulo'
create nonclustered index i_titulo
on dbo.cuentas_pyme (titulo)
on 'default'
go

go

SETUSER
go
print    'delegaciones'
SETUSER 'dbo'
go
create table dbo.delegaciones (
cod_delegacion	char(2)	not null,
descripcion	char(60)	not null,
contador_exp	char(5)	null,
contador_registro	char(10)	null,
fecha_registro	datetime	null,
contador_recibos	char(10)	null,
empresa	char(2)	null,
direccion	char(150)	null,
diario	varchar(10)	null,
proyecto	char(5)	null,
centro	char(5)	null,
constraint delegaciones PRIMARY KEY  NONCLUSTERED ( cod_delegacion )
)
on 'default'
go

SETUSER
go
print    'demarcaciones'
SETUSER 'dbo'
go
create table dbo.demarcaciones (
cod_demarcacion	char(2)	not null,
descripcion	char(60)	not null,
constraint id_demarcacion PRIMARY KEY  NONCLUSTERED ( cod_demarcacion)
)
on 'default'
go

SETUSER
go
print    'departamentos'
SETUSER 'dbo'
go
create table dbo.departamentos (
cod_departamento	char(2)	not null,
descripcion	char(60)	not null,
constraint id_departamento PRIMARY KEY  NONCLUSTERED ( cod_departamento)
)
on 'default'
go

SETUSER
go
print    'desc_gui_coefs'
SETUSER 'dbo'
go
create table dbo.desc_gui_coefs (
desde_fecha	datetime	not null,
hasta_fecha	datetime	not null,
coef_a	float	not null,
coef_p	float	not null,
coef_p_dv	float	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( desde_fecha,hasta_fecha)
)
on 'default'
go

SETUSER
go

print    'desc_gui_pem'
SETUSER 'dbo'
go
create table dbo.desc_gui_pem (
anyo	char(4)	not null,
pem_desde	float(43)	not null,
pem_hasta	float(43)	not null,
coef_c	float(43)	not null,
constraint desc_gui_pem_x PRIMARY KEY  NONCLUSTERED ( anyo,pem_desde,pem_hasta)
)
on 'default'
go

SETUSER
go
print    'desc_gui_tipo_act'
SETUSER 'dbo'
go
create table dbo.desc_gui_tipo_act (
anyo	char(4)	not null,
tipo_actuacion	char(2)	not null,
tipo_obra	char(2)	not null,
coef_k	float(43)	not null,
constraint desc_gui_tipo_act_x PRIMARY KEY  NONCLUSTERED ( anyo,tipo_actuacion,tipo_obra)
)
on 'default'
go

SETUSER
go
print    'descuentos_visared'
SETUSER 'dbo'
go
create table dbo.descuentos_visared (
tipo_actuacion	char(2)	not null,
tipo_obra	char(2)	not null,
descuento	float	null,
constraint descuentos_visared_x PRIMARY KEY  NONCLUSTERED ( tipo_actuacion,tipo_obra)
)
on 'default'
go

SETUSER
go
print    'devoluciones_motivos'
SETUSER 'dbo'
go
create table dbo.devoluciones_motivos (
codigo	char(2)	not null,
descripcion	char(150)	null,
constraint devoluciones_motivos_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'domiciliaciones'
SETUSER 'dbo'
go
create table dbo.domiciliaciones (
id_domiciliacion	char(10)	not null,
fecha	datetime	null,
remesado	char(1)	null,
id_col	char(10)	null,
importe	float	null,
banco_dom	char(23)	null,
referencia	char(10)	null,
cancelada	char(1)	null,
tipo	char(1)	null,
documento	char(12)	null,
cod_devol	char(6)	null,
ref_interna	char(10)	null,
concepto	char(40)	null,
n_arqui	char(15)	null,
cod_banco	char(10)	null,
tipo_persona	char(1)	null,
forma_pago	char(2)	null,
empresa	char(2)	null,
constraint domiciliaciones_x PRIMARY KEY  NONCLUSTERED ( id_domiciliacion)
)
on 'default'
go
print   'id_col'
create nonclustered index id_col
on dbo.domiciliaciones (id_col)
on 'default'
go

print   'ref_interna'
create nonclustered index ref_interna
on dbo.domiciliaciones (ref_interna)
on 'default'
go

go

SETUSER
go
print    'domiciliaciones_formatos'
SETUSER 'dbo'
go
create table dbo.domiciliaciones_formatos (
codigo	char(2)	not null,
descripcion	char(60)	null,
constraint domiciliaciones_formatos_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go

print    'domicilios'
SETUSER 'dbo'
go
create table dbo.domicilios (
id_domicilio	char(10)	not null,
id_colegiado	char(10)	not null,
tipo_via	char(2)	null,
nom_via	char(100)	null,
cod_pob	char(6)	null,
cod_prov	char(5)	null,
cp	char(6)	null,
pais	char(10)	null,
tel	char(30)	null,
movil	char(30)	null,
fax	char(30)	null,
tipo_domicilio	char(2)	null,
comercial	char(1)	null,
fiscal	char(1)	null,
particular	char(1)	null,
profesional	char(1)	null,
temp_pobla	char(255)	null,
constraint id_domicilio PRIMARY KEY  NONCLUSTERED ( id_domicilio)
)
on 'default'
go

SETUSER
go
print    'dv_sobre_pem'
SETUSER 'dbo'
go
create table dbo.dv_sobre_pem (
pem_desde	float	not null,
pem_hasta	float	not null,
importe	float	not null,
constraint dv_sobre_pem_x PRIMARY KEY  NONCLUSTERED ( pem_desde,pem_hasta,importe)
)
on 'default'
go

SETUSER
go
print    'dv_tipo_act'
SETUSER 'dbo'
go
create table dbo.dv_tipo_act (
anyo	char(4)	not null,
tipo_actuacion	char(2)	not null,
tipo_obra	char(2)	not null,
coef_k	float(43)	not null,
constraint dv_tipo_act_x PRIMARY KEY  NONCLUSTERED ( anyo,tipo_actuacion,tipo_obra)
)
on 'default'
go

SETUSER
go
print    'ecoaat_certificado0'
SETUSER 'dbo'
go
create table dbo.ecoaat_certificado0 (
CERT_idCertificado	int	not null,
CERT_idEstadoCertificado	int	null,
CERT_idContrato	int	null,
CERT_idDelegacion	int	not null,
CERT_idTipoCertificado	int	null,
CERT_numCertificado	int	null,
CERT_fechaCertificado	datetime	null,
CERT_fechaEntrada	datetime	null,
CERT_fechaVisado	datetime	null,
CERT_fechaCobro	datetime	null,
CERT_fechaFinalObra	datetime	null,
CERT_observaciones	text	null,
CERT_fecha	datetime	null,
CERT_idFormaPagoPropietario	int	null,
CERT_idCuentaPropietario	int	null,
CERT_idFormaPagoPorColegiado	int	null,
CERT_idFormaPagoDVPorColegiado	int	null,
CERT_idCuentaPorColegiado	int	null,
CERT_idFormaPagoPorHabilitado	int	null,
CERT_idFormaPagoDVPorHab	int	null,
CERT_idCuentaPorHabilitado	int	null,
CERT_CIP	decimal(12, 2)	null,
CERT_seguro	decimal(12, 2)	null,
CERT_seguroIndependiente	char(1)	null,
CERT_idIVA	int	null,
CERT_DV	decimal(12, 2)	null,
CERT_numCopias	int	null,
CERT_libroOrdenes	char(1)	null,
CERT_libroIncidencias	char(1)	null,
CERT_numLibroIncidencias	int	null,
CERT_importeLibro	decimal(12, 2)	null,
CERT_devolucionPlanSeguridad	char(1)	null,
CERT_cbConsejo	varchar(12)	null,
constraint cert_idcertificado PRIMARY KEY  CLUSTERED ( CERT_idCertificado,CERT_idDelegacion)
)
on 'default'
go
print   'CERT_fecha'
create nonclustered index CERT_fecha
on dbo.ecoaat_certificado0 (CERT_fecha)
on 'default'
go

print   'CERT_fechaCobro'
create nonclustered index CERT_fechaCobro
on dbo.ecoaat_certificado0 (CERT_fechaCobro)
on 'default'
go

print   'CERT_fechaVisado'
create nonclustered index CERT_fechaVisado
on dbo.ecoaat_certificado0 (CERT_fechaVisado)
on 'default'
go

print   'CERT_idContrato'
create nonclustered index CERT_idContrato
on dbo.ecoaat_certificado0 (CERT_idContrato)
on 'default'
go

print   'CERT_idDelegacion'
create nonclustered index CERT_idDelegacion
on dbo.ecoaat_certificado0 (CERT_idDelegacion)
on 'default'
go

print   'CERT_idEstadoCertificado'
create nonclustered index CERT_idEstadoCertificado
on dbo.ecoaat_certificado0 (CERT_idEstadoCertificado)
on 'default'
go

print   'CERT_idTipoCertificado'
create nonclustered index CERT_idTipoCertificado
on dbo.ecoaat_certificado0 (CERT_idTipoCertificado)
on 'default'
go

print   'CERT_numCertificado'
create nonclustered index CERT_numCertificado
on dbo.ecoaat_certificado0 (CERT_numCertificado)
on 'default'
go

go

SETUSER
go
print    'equivalencias'
SETUSER 'dbo'
go
create table dbo.equivalencias (
GRUPO	char(10)	not null,
nombre_anterior	char(30)	not null,
nombre_nuevo	char(30)	not null,
constraint id PRIMARY KEY  NONCLUSTERED ( GRUPO,nombre_anterior)
)
on 'default'
go

SETUSER
go
print    'escuela'
SETUSER 'dbo'
go
create table dbo.escuela (
codigo	char(10)	not null,
descripcion	char(255)	null,
constraint pk_codigo PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go

print    'est_tipo_act'
SETUSER 'dbo'
go
create table dbo.est_tipo_act (
familia	char(2)	not null,
tipo_act	char(3)	not null,
texto_codigos	char(50)	null,
constraint est_tipo_act_x PRIMARY KEY  NONCLUSTERED ( tipo_act)
)
on 'default'
go

SETUSER
go
print    'est_tipo_act_tipo_obra_f'
SETUSER 'dbo'
go
create table dbo.est_tipo_act_tipo_obra_f (
tipo_act	char(3)	not null,
tipo_obra_familia	char(2)	not null,
texto_codigos	char(50)	null,
constraint est_tipo_act_tipo_obra_f PRIMARY KEY  NONCLUSTERED ( tipo_act, tipo_obra_familia)
)
on 'default'
go

SETUSER
go
print    'est_tipo_obra'
SETUSER 'dbo'
go
create table dbo.est_tipo_obra (
familia	char(2)	not null,
tipo_obra	char(3)	not null,
texto_codigos	char(50)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( tipo_obra)
)
on 'default'
go

SETUSER
go
print    'etiquetas_visado'
SETUSER 'dbo'
go
create table dbo.etiquetas_visado (
id_etiqueta	char(10)	not null,
id_expedi	char(10)	not null,
hoja_encargo	char(2)	null,
id_fase	char(10)	null,
tipo_etiqueta	char(10)	null,
num_etiquetas	int	null,
constraint pk_et PRIMARY KEY  NONCLUSTERED ( id_etiqueta)
)
on 'default'
go

SETUSER
go
print    'expedientes'
SETUSER 'dbo'
go
create table dbo.expedientes (
id_expedi	char(10)	not null,
n_expedi	char(14)	null,
titulo	char(255)	null,
f_inicio	datetime	null,
cerrado	char(1)	null,
f_cierre	datetime	null,
ult_fase	char(3)	null,
tipo_trabajo	char(3)	null,
trabajo	char(3)	null,
tipo_via_emplazamiento	char(2)	null,
emplazamiento	char(255)	null,
poblacion	char(6)	null,
f_contrato	datetime	null,
anulado	char(1)	null,
n_exp_blanco	char(1)	null,
r_catastral	char(20)	null,
archivo	char(60)	null,
celda	char(5)	null,
n_calle	char(30)	null,
f_inicio_obra	datetime	null,
f_final_obra	datetime	null,
num_viv	float	null,
sup_viv	float	null,
sup_garage	float	null,
sup_otros	float	null,
sup_sob	float	null,
sup_baj	float	null,
plantas_sob	float	null,
plantas_baj	float	null,
pem	float	null,
volumen	float	null,
altura	float	null,
administracion	char(1)	null,
colindantes	char(2)	null,
tipo_viv	char(2)	null,
num_edif	float	null,
estudio_geo	char(1)	null,
cc_externo	char(1)	null,
niv_cont	char(2)	null,
observaciones	char(255)	null,
uso	char(2)	null,
longitud_per	float	null,
volumen_tierras	float	null,
estructura	char(1)	null,
t_terreno	char(1)	null,
t_medicion	char(1)	null,
replan_deslin	char(1)	null,
valor_terreno	float	null,
valor_tasacion	float	null,
valoracion_estim	float	null,
ctrl_calidad_interno	char(1)	null,
constraint expedientes_x PRIMARY KEY  NONCLUSTERED ( id_expedi)
)
on 'default'
go
print   'n_expedi'
create nonclustered index n_expedi
on dbo.expedientes (n_expedi)
on 'default'
go

go

SETUSER
go
print    'expedientes_documentos'
SETUSER 'dbo'
go
create table dbo.expedientes_documentos (
id_expedi	char(10)	not null,
id_docu	char(10)	not null,
f_entrada	datetime	not null,
titulo	char(255)	null,
tipo	char(2)	null,
constraint id_docu PRIMARY KEY  NONCLUSTERED ( id_expedi,id_docu)
)
on 'default'
go
print   'id_expedi'
create nonclustered index id_expedi
on dbo.expedientes_documentos (id_expedi)
on 'default'
go

go

SETUSER
go

print    'expedientes_estado'
SETUSER 'dbo'
go
create table dbo.expedientes_estado (
cod_estado	char(2)	not null,
descripcion	char(60)	not null,
p_importar	char(1)	null,
p_visar	char(1)	null,
p_desvisar	char(1)	null,
p_facturar	char(1)	null,
permitir_cambios	char(1)	null,
constraint cod_estado PRIMARY KEY  NONCLUSTERED ( cod_estado)
)
on 'default'
go

SETUSER
go
print    'expedientes_relacionados'
SETUSER 'dbo'
go
create table dbo.expedientes_relacionados (
id_expedi_relac	char(10)	not null,
id_expedi	char(10)	not null,
observaciones	char(255)	null,
constraint pk_exped_relac PRIMARY KEY  NONCLUSTERED ( id_expedi_relac,id_expedi)
)
on 'default'
go
print   'id_expedi'
create nonclustered index id_expedi
on dbo.expedientes_relacionados (id_expedi)
on 'default'
go

go

SETUSER
go
print    'fases'
SETUSER 'dbo'
go
create table dbo.fases (
id_expedi	char(10)	null,
id_fase	char(10)	not null,
n_registro	char(11)	null,
n_expedi	char(14)	null,
f_entrada	datetime	null,
titulo	char(255)	null,
tipo_gestion	char(2)	null,
descripcion	text	null,
f_visado	datetime	null,
f_abono	datetime	null,
estado	char(2)	null,
archivo	char(60)	null,
celda	char(5)	null,
modalidad	char(2)	null,
sello	char(10)	null,
r_catastral	char(20)	null,
e_mail	char(1)	null,
cambio_arqui	char(1)	null,
autorizo	char(1)	null,
observaciones	text	null,
honorarios	float	null,
t_iva	char(2)	null,
fase	char(3)	null,
honorarios_iva	float	null,
nr_duplicado	char(1)	null,
tipo_fase	char(3)	null,
tipo_trabajo	char(3)	null,
trabajo	char(3)	null,
tipo_via_emplazamiento	char(2)	null,
emplazamiento	char(255)	null,
n_calle	char(30)	null,
poblacion	char(6)	null,
n_copias	char(10)	not null,
usuario	char(10)	null,
aplicado_10	char(1)	null,
n_registro_visared	char(15)	null,
n_expedi_visared	char(15)	null,
porc_honorarios	float	null,
paga_gastos_cliente	char(1)	null,
num_coac	char(15)	null,
f_visado_coac	datetime	null,
fa	float	null,
tipo_registro	char(3)	null,
n_contrato_ant	char(20)	null,
n_consejo_fase	char(20)	null,
destino_int	char(3)	null,
piso	char(10)	null,
puerta	char(10)	null,
mantenimiento	char(1)	null,
f_mantenimiento	datetime	null,
constraint fases_x PRIMARY KEY  NONCLUSTERED ( id_fase)
)
on 'default'
go

SETUSER
go
print    'fases_admin_jud_tipos_rec'
SETUSER 'dbo'
go
create table dbo.fases_admin_jud_tipos_rec (
codigo	char(10)	not null,
descripcion	char(60)	not null,
constraint pk PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'fases_administrativa_jud_col'
SETUSER 'dbo'
go
create table dbo.fases_administrativa_jud_col (
id_administracion	char(10)	not null,
id_colegiado	char(10)	not null,
src_n_poliza	char(10)	null,
constraint id_admin_col PRIMARY KEY  NONCLUSTERED ( id_administracion,id_colegiado)
)
on 'default'
go

SETUSER
go
print    'fases_administrativa_judicial'
SETUSER 'dbo'
go
create table dbo.fases_administrativa_judicial (
id_administracion	char(10)	not null,
n_interno	char(10)	null,
n_musaat	char(10)	null,
fecha	datetime	null,
fecha_cierre	datetime	null,
asunto	char(255)	null,
autos	char(255)	null,
abogado	char(255)	null,
procurador	char(255)	null,
tipo_reclamacion	char(2)	null,
observaciones	char(255)	null,
juzgado	char(255)	null,
constraint id_administracion PRIMARY KEY  NONCLUSTERED ( id_administracion)
)
on 'default'
go

SETUSER
go

print    'fases_arquitectos'
SETUSER 'dbo'
go
create table dbo.fases_arquitectos (
id_fases_arquitectos	char(10)	not null,
id_fase	char(10)	null,
id_arqui	char(10)	null,
apellidos	char(80)	null,
nombre	char(50)	null,
tipo_a	char(1)	null,
tipo_d	char(1)	null,
titulacion	char(2)	null,
constraint fases_arquitectos_x PRIMARY KEY  NONCLUSTERED ( id_fases_arquitectos)
)
on 'default'
go
print   'id_arqui'
create nonclustered index id_arqui
on dbo.fases_arquitectos (id_arqui)
on 'default'
go

print   'id_fase'
create nonclustered index id_fase
on dbo.fases_arquitectos (id_fase)
on 'default'
go

go

SETUSER
go
print    'fases_cip_tfe'
SETUSER 'dbo'
go
create table dbo.fases_cip_tfe (
tipo	char(2)	not null,
ambito	char(2)	not null,
id_fase	char(10)	not null,
campo_a	char(1)	null,
coef_a	float	null,
campo_b	char(1)	null,
coef_b	float	null,
campo_c	char(1)	null,
coef_c	float	null,
coef_s	float	null,
coef_d	float	null,
ambito_s	char(2)	null,
tipo2	char(2)	null,
tipo3	char(2)	null,
ambito3	char(2)	null,
es_colaboracion	char(1)	null,
aplica35	char(1)	null,
formula_cip	char(255)	null,
desarrollo_cip	char(255)	null,
importe_cip	float	null,
tipo_promotor	char(2)	null,
tarifa	char(15)	null,
epigrafe	char(10)	null,
p1	float	null,
p2	float	null,
p3	float	null,
p4	float	null,
p5	float	null,
formula_ho	char(255)	null,
desarrollo_ho	char(255)	null,
importe_ho	float	null,
pem_min	float	null,
legalizacion	char(1)	null,
constraint fases_cip_tfe PRIMARY KEY  NONCLUSTERED ( tipo, ambito, id_fase )
)
on 'default'
go

SETUSER
go
print    'fases_clientes'
SETUSER 'dbo'
go
create table dbo.fases_clientes (
id_fase	char(10)	not null,
id_cliente	char(10)	not null,
porcen	float	not null,
total_irpf	float	null,
contratista	char(1)	null,
promotor	char(1)	null,
pagador	char(1)	null,
facturado	char(1)	null,
id_representante	char(10)	null,
reclamar_representante	char(1)	null,
id_propiedad	char(10)	null,
constraint pk_fases_clientes PRIMARY KEY  NONCLUSTERED ( id_fase,id_cliente)
)
on 'default'
go
print   'id_cliente'
create nonclustered index id_cliente
on dbo.fases_clientes (id_cliente)
on 'default'
go

print   'id_fase'
create nonclustered index id_fase
on dbo.fases_clientes (id_fase)
on 'default'
go

print   'id_representante'
create nonclustered index id_representante
on dbo.fases_clientes (id_representante)
on 'default'
go

go

SETUSER
go
print    'fases_colegiados'
SETUSER 'dbo'
go
create table dbo.fases_colegiados (
id_fase	char(10)	not null,
id_col	char(10)	not null,
porcen_a	float(43)	null,
porcen_d	float(43)	null,
tipo_a	char(1)	null,
tipo_d	char(1)	null,
empresa	char(1)	null,
facturado	char(1)	null,
id_fases_colegiados	char(10)	not null,
renunciado	char(1)	null,
tipo_gestion	char(1)	null,
observa	text	null,
cobertura	char(3)	null,
porc_aut	float(43)	null,
porc_dir	float(43)	null,
otro_seguro	char(40)	null,
coef_cm	float	null,
temporal	char(2)	null,
id_empresa	char(10)	null,
c_geografico	char(5)	null,
situacion	char(2)	null,
doble_condicion	char(1)	DEFAULT  'N' 	null,
int_forzosa	char(1)	DEFAULT  'N' 	null,
reposicion	char(1)	DEFAULT  'N' null	null,
porc_renuncia	float	null,
constraint fases_colegiados_x PRIMARY KEY  NONCLUSTERED ( id_fases_colegiados)
)
on 'default'
go
print   'id_col'
create nonclustered index id_col
on dbo.fases_colegiados (id_col)
on 'default'
go

print   'id_fase'
create nonclustered index id_fase
on dbo.fases_colegiados (id_fase)
on 'default'
go

go

SETUSER
go
print    'fases_colegiados_asociados'
SETUSER 'dbo'
go
create table dbo.fases_colegiados_asociados (
id_fase	char(10)	not null,
id_col_per	char(10)	not null,
id_col_aso	char(10)	not null,
porcent	float	null,
id_fases_colegiados	char(10)	not null,
constraint pk PRIMARY KEY  NONCLUSTERED ( id_col_per,id_fases_colegiados)
)
on 'default'
go
print   'id_col_aso'
create nonclustered index id_col_aso
on dbo.fases_colegiados_asociados (id_col_aso)
on 'default'
go

print   'id_col_per'
create nonclustered index id_col_per
on dbo.fases_colegiados_asociados (id_col_per)
on 'default'
go

print   'id_fase'
create nonclustered index id_fase
on dbo.fases_colegiados_asociados (id_fase)
on 'default'
go

print   'id_fases_colegiados'
create nonclustered index id_fases_colegiados
on dbo.fases_colegiados_asociados (id_fases_colegiados)
on 'default'
go

go

SETUSER
go
print    'fases_documentos'
SETUSER 'dbo'
go
create table dbo.fases_documentos (
id_fase	char(10)	not null,
id_docu	char(10)	not null,
f_entrada	datetime	not null,
titulo	char(255)	null,
tipo	char(2)	null,
n_reg	char(10)	null,
f_retira	datetime	null,
nombre_fichero	char(100)	null,
ruta_fichero	char(255)	null,
constraint documentos PRIMARY KEY  NONCLUSTERED ( id_docu)
)
on 'default'
go

SETUSER
go

print    'fases_documentos_visared'
SETUSER 'dbo'
go
create table dbo.fases_documentos_visared (
id_fichero	char(10)	not null,
id_fase	char(10)	null,
nombre_fichero	char(100)	null,
ruta_fichero	char(255)	null,
sellado	char(1)	null,
info_adicional	char(255)	null,
fecha	datetime	null,
fecha_sellado	datetime	null,
n_documento	char(20)	null,
visualizar_web	char(1)	null,
tamano	char(20)	null,
firmado	char(1)	null,
certificado_confianza	char(2)	null,
tipo_documento	char(2)	null,
f_entrega	datetime	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( id_fichero)
)
on 'default'
go
print   'id_fase'
create nonclustered index id_fase
on dbo.fases_documentos_visared (id_fase)
on 'default'
go

go

SETUSER
go
print    'fases_estados'
SETUSER 'dbo'
go
create table dbo.fases_estados (
id_fase	char(10)	not null,
cod_estado	char(2)	not null,
fecha	datetime	not null,
usuario	char(100)	not null,
constraint estados PRIMARY KEY  NONCLUSTERED ( id_fase,fecha)
)
on 'default'
go
print   'id_fase'
create nonclustered index id_fase
on dbo.fases_estados (id_fase)
on 'default'
go

go

SETUSER
go
print    'fases_finales'
SETUSER 'dbo'
go
create table dbo.fases_finales (
id_fases_final	char(10)	not null,
fecha	datetime	null,
descripcion	char(255)	null,
num_viv	int	null,
total_parcial	char(1)	null,
presupuesto	float	null,
id_fase	char(10)	null,
sup_viv	float	null,
sup_otros	float	null,
sup_garage	float	null,
num_edif	float	null,
copias	float	null,
num_final	char(10)	null,
f_intro	datetime	null,
id_minuta	char(10)	null,
web	char(1)	DEFAULT  'N' null	null,
f_visado	datetime	null,
f_retirado	datetime	null,
constraint primarykey PRIMARY KEY  NONCLUSTERED ( id_fases_final)
)
on 'default'
go
print   'id_fase'
create nonclustered index id_fase
on dbo.fases_finales (id_fase)
on 'default'
go

go

SETUSER
go
print    'fases_finales_acciones_realiza'
SETUSER 'dbo'
go
create table dbo.fases_finales_acciones_realiza (
id_accion	char(10)	not null,
tipo_trabajo	char(3)	null,
trabajo	char(3)	null,
accion	char(60)	null,
descripcion	text	null,
constraint fases_finales_accion_realiza_x PRIMARY KEY  NONCLUSTERED ( id_accion)
)
on 'default'
go

SETUSER
go
print    'fases_garantias'
SETUSER 'dbo'
go
create table dbo.fases_garantias (
id_fase	char(10)	not null,
id_colegiado	char(10)	not null,
id_cliente	char(10)	not null,
f_in	datetime	null,
f_out	datetime	null,
importe	float	null,
destinatario	char(2)	null,
constraint fases_garantias_x PRIMARY KEY  NONCLUSTERED ( id_fase,id_colegiado,id_cliente)
)
on 'default'
go
print   'id_cliente'
create nonclustered index id_cliente
on dbo.fases_garantias (id_cliente)
on 'default'
go

print   'id_colegiado'
create nonclustered index id_colegiado
on dbo.fases_garantias (id_colegiado)
on 'default'
go

print   'id_fase'
create nonclustered index id_fase
on dbo.fases_garantias (id_fase)
on 'default'
go

go

SETUSER
go
print    'fases_honos_cip'
SETUSER 'dbo'
go
create table dbo.fases_honos_cip (
id_fase	char(10)	not null,
tarifa	char(10)	null,
epigrafe	char(10)	null,
formula_cip	char(255)	null,
desarrollo_cip	char(255)	null,
importe_cip	float	null,
p1	float	null,
p2	float	null,
p3	float	null,
p4	float	null,
p5	float	null,
formula_hon	char(255)	null,
desarrollo_hon	char(255)	null,
importe_hon	float	null,
importe_hon_min	float	null,
constraint pk_fases_honos_cip PRIMARY KEY  NONCLUSTERED ( id_fase)
)
on 'default'
go

SETUSER
go

print    'fases_honos_orientativos'
SETUSER 'dbo'
go
create table dbo.fases_honos_orientativos (
id_fase	char(10)	not null,
tarifa	char(10)	null,
epigrafe	char(10)	null,
p1	float	null,
p2	float	null,
p3	float	null,
p4	float	null,
p5	float	null,
formula_ho	char(255)	null,
desarrollo_ho	char(255)	null,
importe_ho	float	null,
pem_min	float	null,
coef_a	float	null,
coef_b	float	null,
coef_c	float	null,
constraint pk_fases_honos_orientat PRIMARY KEY  NONCLUSTERED ( id_fase)
)
on 'default'
go

SETUSER
go
print    'fases_incompatibilidades'
SETUSER 'dbo'
go
create table dbo.fases_incompatibilidades (
t_actuacion	char(3)	not null,
t_obra	char(3)	not null,
uso	char(3)	not null,
tipo_incomp	char(1)	not null,
constraint fases_incompatibilidades_x PRIMARY KEY  NONCLUSTERED ( t_actuacion,t_obra,uso)
)
on 'default'
go

SETUSER
go
print    'fases_informes'
SETUSER 'dbo'
go
create table dbo.fases_informes (
id_fase	char(10)	not null,
id_informe	char(10)	not null,
tipo_informe	char(10)	not null,
cuantia_cliente	float	null,
cuantia_colegiado	float	null,
descripcion	text	null,
impuesto_cliente	float	null,
impuesto_colegiado	float	null,
t_iva	char(2)	null,
fecha_emision	datetime	null,
facturado	char(1)	null,
impreso	char(255)	null,
formula_sustituida	char(150)	null,
constraint fases_informes PRIMARY KEY  NONCLUSTERED ( id_fase, id_informe )
)
on 'default'
go
print   'id_fase'
create nonclustered index id_fase
on dbo.fases_informes (id_fase)
on 'default'
go

go

SETUSER
go
print    'fases_liquidaciones'
SETUSER 'dbo'
go
create table dbo.fases_liquidaciones (
id_liquidacion	char(10)	not null,
id_fase	char(10)	null,
f_liquidacion	datetime	null,
estado	char(1)	null,
contabilizada	char(1)	null,
forma_pago	char(2)	null,
banco	char(10)	null,
importe_suma	float	null,
importe_resta	float	null,
importe	float	null,
n_documento	char(20)	null,
id_colegiado	char(10)	null,
saldo_deudor	float	null,
deuda_facturas	float	null,
cod_delegacion	char(2)	null,
f_entrada	datetime	null,
tipo	char(1)	null,
concepto	char(60)	null,
observaciones	char(255)	null,
id_minuta	char(10)	null,
constraint pk_fases_liquidaciones PRIMARY KEY  NONCLUSTERED ( id_liquidacion)
)
on 'default'
go
print   'i_fases_liquidaciones'
create nonclustered index i_fases_liquidaciones
on dbo.fases_liquidaciones (id_liquidacion)
on 'default'
go

print   'id_colegiado'
create nonclustered index id_colegiado
on dbo.fases_liquidaciones (id_colegiado)
on 'default'
go

print   'id_colegiado_x'
create nonclustered index id_colegiado_x
on dbo.fases_liquidaciones (id_colegiado)
on 'default'
go

print   'id_fase'
create nonclustered index id_fase
on dbo.fases_liquidaciones (id_fase)
on 'default'
go

print   'idx_estado'
create nonclustered index idx_estado
on dbo.fases_liquidaciones (estado)
on 'default'
go

go

SETUSER
go
print    'fases_minutas'
SETUSER 'dbo'
go
create table dbo.fases_minutas (
id_minuta	char(10)	not null,
id_fase	char(10)	null,
id_colegiado	char(10)	null,
id_cliente	char(10)	null,
cantidad	float	null,
pendiente	char(1)	null,
facturado	char(1)	null,
id_honorario	char(10)	null,
f_facturado	datetime	null,
id_factura	char(10)	null,
tipo_minuta	char(10)	null,
irpf	float	null,
importe_irpf	float	null,
n_aviso	char(10)	null,
fecha	datetime	null,
fecha_pago	datetime	null,
tipo_gestion	char(1)	null,
pagador	char(1)	null,
reclamar	char(1)	null,
t_iva	char(2)	null,
porc_iva	float	null,
forma_pago	char(2)	null,
aplica_honos	char(1)	null,
porc_honos	float	null,
concepto_honos	char(50)	null,
base_honos	float	null,
iva_honos	float	null,
aplica_desplaza	char(1)	null,
base_desplaza	float	null,
iva_desplaza	float	null,
concepto_desplaza	char(50)	null,
aplica_dv	char(1)	null,
base_dv	float	null,
iva_dv	float	null,
aplica_cip	char(1)	null,
base_cip	float	null,
iva_cip	float	null,
aplica_musaat	char(1)	null,
base_musaat	float	null,
iva_musaat	float	null,
aplica_retvol	char(1)	null,
porc_retvol	float	null,
base_retvol	float	null,
iva_retvol	float	null,
total_cliente	float	null,
total_colegiado	float	null,
t_iva_honos	char(2)	null,
t_iva_desplaza	char(2)	null,
t_iva_dv	char(2)	null,
t_iva_cip	char(2)	null,
porc_iva_honos	float	null,
porc_iva_desplaza	float	null,
porc_iva_dv	float	null,
porc_iva_cip	float	null,
anulada	char(1)	null,
banco	char(10)	null,
irpf_cliente	char(1)	null,
observaciones	char(255)	null,
base_garantia	float	null,
total_aviso	float	null,
f_reclamacion	datetime	null,
tipo_reclamacion	char(2)	null,
aplica_impresos	char(1)	null,
base_impresos	float	null,
iva_impresos	float	null,
t_iva_impresos	char(2)	null,
porc_iva_impresos	float	null,
base_otros	float	null,
iva_otros	float	null,
t_iva_otros	char(2)	null,
porc_iva_otros	float	null,
concepto_otros	char(50)	null,
n_contrato_ant	char(20)	null,
porc_musaat	float	null,
paga_asalariado	char(1)	null,
paga_dv	char(1)	null,
paga_externo	char(1)	null,
cobro_a_cuenta	float	null,
t_minuta	char(1)	null,
urgente	char(1)	null,
pem_certificacion	float	null,
base_cip_suplida	float	null,
t_iva_cip_suplida	char(2)	null,
porc_iva_cip_suplida	float	null,
iva_cip_suplida	float	null,
musaat_suplida	float	null,
porc_cip	float	null,
constraint fases_minutas PRIMARY KEY  NONCLUSTERED ( id_minuta )
)
on 'default'
go
print   'id_cliente'
create nonclustered index id_cliente
on dbo.fases_minutas (id_cliente)
on 'default'
go

print   'id_colegiado'
create nonclustered index id_colegiado
on dbo.fases_minutas (id_colegiado)
on 'default'
go

print   'id_fase'
create nonclustered index id_fase
on dbo.fases_minutas (id_fase)
on 'default'
go

go

SETUSER
go
print    'fases_minutas_cartas'
SETUSER 'dbo'
go
create table dbo.fases_minutas_cartas (
id_carta	char(10)	not null,
id_remesas_reclamaciones	char(10)	null,
id_referencia	char(10)	null,
tipo_reclamacion	char(1)	null,
f_reclamacion	datetime	null,
manual	char(1)	null,
f_ultima_reclamacion	datetime	null,
n_registro	char(10)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( id_carta)
)
on 'default'
go

SETUSER
go

print    'fases_minutas_cartas_grupos'
SETUSER 'dbo'
go
create table dbo.fases_minutas_cartas_grupos (
id_referencia_carta	char(10)	not null,
id_referencia_fase	char(10)	not null,
constraint pk_ref PRIMARY KEY  CLUSTERED ( id_referencia_carta,id_referencia_fase)
)
on 'default'
go

SETUSER
go
print    'fases_minutas_cartas_hist'
SETUSER 'dbo'
go
create table dbo.fases_minutas_cartas_hist (
id	char(10)	not null,
id_carta	char(10)	null,
id_minuta	char(10)	null,
constraint id_x PRIMARY KEY  NONCLUSTERED ( id)
)
on 'default'
go

SETUSER
go
print    'fases_otros_datos'
SETUSER 'dbo'
go
create table dbo.fases_otros_datos (
id_fase	char(10)	not null,
emplazamiento_url	char(255)	null,
constraint pk_otros_datos PRIMARY KEY  NONCLUSTERED ( id_fase)
)
on 'default'
go

SETUSER
go
print    'fases_reclamaciones'
SETUSER 'dbo'
go
create table dbo.fases_reclamaciones (
id_minuta	char(10)	not null,
tipo_reclamacion	char(1)	not null,
f_reclamacion	datetime	not null,
manual	char(1)	null,
id_remesas_reclamaciones	char(10)	null,
constraint id_tr_x PRIMARY KEY  NONCLUSTERED ( id_minuta,tipo_reclamacion,f_reclamacion)
)
on 'default'
go
print   'id_minuta'
create nonclustered index id_minuta
on dbo.fases_reclamaciones (id_minuta)
on 'default'
go

print   'id_remesas_reclamaciones'
create nonclustered index id_remesas_reclamaciones
on dbo.fases_reclamaciones (id_remesas_reclamaciones)
on 'default'
go

go

SETUSER
go
print    'fases_registros_es'
SETUSER 'dbo'
go
create table dbo.fases_registros_es (
id_escrito	char(10)	not null,
id_fase	char(10)	not null,
id_registro	char(10)	not null,
constraint registros_es PRIMARY KEY  NONCLUSTERED ( id_escrito)
)
on 'default'
go
print   'id_fase'
create nonclustered index id_fase
on dbo.fases_registros_es (id_fase)
on 'default'
go

print   'id_registro'
create nonclustered index id_registro
on dbo.fases_registros_es (id_registro)
on 'default'
go

go

SETUSER
go
print    'fases_renuncias'
SETUSER 'dbo'
go
create table dbo.fases_renuncias (
id_fase	char(10)	not null,
id_renuncia	char(10)	not null,
cliente_colegiado	char(2)	null,
id_colegiado	char(10)	null,
id_cliente	char(10)	null,
presupuesto	float	null,
porc_renuncia	float	null,
tipo_visado	char(1)	null,
tipo_oo	char(1)	null,
observ	char(255)	null,
n_contrato_ant	char(10)	null,
decenal	char(1)	null,
restar_cip	char(1)	null,
restar_musaat	char(1)	null,
restar_dv	char(1)	null,
total_cip	float	null,
total_musaat	float	null,
total_dv	float	null,
pagado_cip	float	null,
pagado_musaat	float	null,
pagado_dv	float	null,
realizado_cip	float	null,
realizado_musaat	float	null,
realizado_dv	float	null,
cip	float	null,
musaat	float	null,
dv	float	null,
fecha	datetime	null,
devol_proy	char(1)	null,
web	char(1)	DEFAULT  'N' null	null,
porc_obra_ejecutada	float	null,
porc_participacion_sobre_ejec	float	null,
porc_obra_pendiente	float	null,
porc_renuncia_sobre_pendiente	float	null,
porc_participacion_sobre_pte	float	null,
porc_final_sobre_total_obra	float	null,
usuario	char(10)	null,
f_modificacion	datetime	null,
n_renuncia	char(10)	null,
constraint pk_fases_renuncias PRIMARY KEY  CLUSTERED ( id_fase,id_renuncia)
)
on 'default'
go

SETUSER
go

print    'fases_renuncias_desglose'
SETUSER 'dbo'
go
create table dbo.fases_renuncias_desglose (
tipo_act	char(2)	not null,
proyecto	char(2)	not null,
porc_proy_musaat	float	not null,
porc_proy_cip	float	not null,
direccion	char(2)	not null,
porc_dir_musaat	float	not null,
porc_dir_cip	float	not null,
cod_tarifa	char(10)	null
)
on 'default'
go

SETUSER
go
print    'fases_reparos'
SETUSER 'dbo'
go
create table dbo.fases_reparos (
id_fase	char(10)	not null,
id_reparo	char(10)	not null,
tipo_reparo	char(10)	null,
f_emision	datetime	null,
f_subsanacion	datetime	null,
texto	text	null,
notificado	char(1)	null,
usuario	char(10)	null,
id_col	char(10)	null,
email	char(1)	null,
tipo	char(2)	null,
telfax	char(1)	null,
anulado	char(1)	null
)
on 'default'
go

SETUSER
go
print    'fases_reparos_2'
SETUSER 'dbo'
go
create table dbo.fases_reparos_2 (
id_fase	char(10)	not null,
id_reparo	char(10)	not null,
tipo_reparo	char(3)	null,
f_emision	datetime	null,
f_subsanacion	datetime	null,
texto	text	null,
notificado	char(1)	null,
usuario	char(10)	null,
id_col	char(10)	null,
email	char(1)	null,
tipo	char(2)	null,
telfax	char(1)	null,
anulado	char(1)	null
)
on 'default'
go

SETUSER
go
print    'fases_reposiciones'
SETUSER 'dbo'
go
create table dbo.fases_reposiciones (
id_reposicion	char(10)	not null,
id_fases_colegiado	char(10)	not null,
n_reposicion	char(15)	null,
id_renuncia	char(10)	null,
f_reposicion	datetime	null,
porcentaje	float	null,
constraint pk_id_rep PRIMARY KEY  CLUSTERED ( id_reposicion)
)
on 'default'
go

SETUSER
go
print    'fases_siniestros'
SETUSER 'dbo'
go
create table dbo.fases_siniestros (
id_siniestro	char(10)	not null,
id_fase	char(10)	null,
n_interno	char(10)	null,
n_musaat	char(10)	null,
fecha	datetime	null,
tipo_danyos	char(2)	null,
danyos	char(255)	null,
tipo_estado_obra	char(2)	null,
estado_obra	char(255)	null,
importe_danyos	float	null,
fecha_siniestro	datetime	null,
autos	char(255)	null,
juzgado	char(255)	null,
constructor	char(255)	null,
tipo_reclamacion	char(2)	null,
observaciones	text	null,
estimacion	char(2)	null,
procurador	char(255)	null,
fecha_cierre	datetime	null,
persona_contacto	char(130)	null,
telefono_contacto	char(30)	null,
tipo_via_contacto	char(2)	null,
emplazamiento_contacto	char(100)	null,
numero_contacto	char(30)	null,
poblacion_contacto	char(6)	null,
codigo_postal_contacto	char(6)	null,
provincia_contacto	char(5)	null,
f_comunicado_musaat	datetime	null,
damnificados	char(2)	null,
td_accidente_laboral	char(1)	null,
td_desprendimiento_tierras	char(1)	null,
td_danyos_per_ajena_obras	char(1)	null,
td_humedades	char(1)	null,
td_danyos_instalaciones	char(1)	null,
td_otros	char(1)	null,
td_otros_des	char(255)	null,
td_fallos_suelo	char(1)	null,
td_danyos_colindantes	char(1)	null,
td_danyos_cosas_ajenas_obra	char(1)	null,
td_revestimientos_fachada	char(1)	null,
td_danyos_estructurales	char(1)	null,
td_danyos_alicatados	char(1)	null,
td_danyos_solados	char(1)	null,
cd_error_dis_proy	char(1)	null,
cd_defectos_cimentacion	char(1)	null,
cd_excavacion_excesiva	char(1)	null,
cd_otras	char(1)	null,
cd_otras_des	char(255)	null,
cd_error_calculo_estructural	char(1)	null,
cd_mala_ejecucion	char(1)	null,
cd_mal_uso	char(1)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( id_siniestro)
)
on 'default'
go
print   'id_fase'
create nonclustered index id_fase
on dbo.fases_siniestros (id_fase)
on 'default'
go

go

SETUSER
go
print    'fases_siniestros_coles'
SETUSER 'dbo'
go
create table dbo.fases_siniestros_coles (
id_siniestro	char(10)	not null,
id_colegiado	char(10)	not null,
src_n_poliza	char(10)	null,
src_cober	char(3)	null,
reclamacion_colegiado	char(1)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( id_siniestro,id_colegiado)
)
on 'default'
go
print   'id_colegiado'
create nonclustered index id_colegiado
on dbo.fases_siniestros_coles (id_colegiado)
on 'default'
go

go

SETUSER
go

print    'fases_siniestros_incidencias'
SETUSER 'dbo'
go
create table dbo.fases_siniestros_incidencias (
id_incidencia	char(10)	not null,
id_siniestro	char(10)	null,
fecha_incidencia	datetime	null,
descripcion	text	null,
constraint pk_fases_sini_inci PRIMARY KEY  NONCLUSTERED ( id_incidencia)
)
on 'default'
go
print   'id_siniestro'
create unique nonclustered index id_siniestro
on dbo.fases_siniestros_incidencias (id_siniestro)
on 'default'
go

go

SETUSER
go
print    'fases_siniestros_tecnicos'
SETUSER 'dbo'
go
create table dbo.fases_siniestros_tecnicos (
id_fase_siniestro_tecnico	char(10)	not null,
id_siniestro	char(10)	null,
nombre_tecnico	char(130)	null,
titulacion	char(150)	null,
intervencion_trabajos	char(150)	null,
constraint fases_siniestros_tecnicos PRIMARY KEY  NONCLUSTERED ( id_fase_siniestro_tecnico )
)
on 'default'
go
print   'id_siniestro'
create nonclustered index id_siniestro
on dbo.fases_siniestros_tecnicos (id_siniestro)
on 'default'
go

go

SETUSER
go
print    'fases_usos'
SETUSER 'dbo'
go
create table dbo.fases_usos (
id_uso	char(10)	not null,
id_fase	char(10)	not null,
trabajo	char(4)	null,
superficie	float	null,
tasa_m2	float	null,
t_fase	float	null,
aportacion	float	null,
precio_m2	float	null,
base_aplicacion	float	null,
n_viv_vpo	float	null,
n_viv_libres	float	null,
pem	float	null,
presupuesto	float	null,
altura	float	null,
volumen	float	null,
colindantes	char(2)	null,
t_terreno	char(2)	null,
longitud_per	float	null,
volumen_tierras	float	null,
estructura	char(1)	null,
t_medicion	char(1)	null,
replan_deslin	char(1)	null,
valor_terreno	float	null,
valor_tasacion	float	null,
valoracion_estim	float	null,
num_viv	float	null,
sup_viv	float	null,
sup_garage	float	null,
sup_otros	float	null,
sup_sob	float	null,
sup_baj	float	null,
plantas_sob	float	null,
plantas_baj	float	null,
tipo_viv	char(2)	null,
num_edif	float	null,
estudio_geo	char(1)	null,
cc_externo	char(1)	null,
niv_cont	char(2)	null,
uso	char(2)	null,
ctrl_calidad_interno	char(1)	null,
pem_musaat	float	null,
t_promotor	char(2)	null,
pres_seguridad	float	null,
tipo_reforma	char(1)	null,
colindantes2m	char(1)	null,
constraint fases_usos PRIMARY KEY  NONCLUSTERED ( id_uso )
)
on 'default'
go
print   'id_fase'
create nonclustered index id_fase
on dbo.fases_usos (id_fase)
on 'default'
go

go

SETUSER
go
print    'fases_usos_tarifa'
SETUSER 'dbo'
go
create table dbo.fases_usos_tarifa (
id_fase	char(10)	not null,
cod_uso	char(10)	not null,
superficie	float	not null,
constraint pk_id PRIMARY KEY  CLUSTERED ( id_fase,cod_uso)
)
on 'default'
go

SETUSER
go
print    'fotos_firmas_colegiados'
SETUSER 'dbo'
go
create table dbo.fotos_firmas_colegiados (
id_foto_firma	char(10)	not null,
id_colegiado	char(10)	not null,
tipo	char(1)	null,
ruta	char(255)	null,
activa	char(1)	null,
constraint id_foto_firma_x PRIMARY KEY  NONCLUSTERED ( id_foto_firma)
)
on 'default'
go
print   'id_colegiado_x'
create nonclustered index id_colegiado_x
on dbo.fotos_firmas_colegiados (id_colegiado)
on 'default'
go

go

SETUSER
go
print    'gcw_archivo'
SETUSER 'dbo'
go
create table dbo.gcw_archivo (
id_archivo	nvarchar(20)	not null,
nombre	nvarchar(255)	null,
id_tipo_archivo	nvarchar(5)	null,
tamanyo	float	null,
comentario	nvarchar(255)	null,
id_registro	nvarchar(20)	null,
activo	nvarchar(1)	null,
constraint pk_id_archivo PRIMARY KEY  NONCLUSTERED ( id_archivo)
)
on 'default'
go

SETUSER
go

print    'gcw_aviso'
SETUSER 'dbo'
go
create table dbo.gcw_aviso (
id_registro	varchar(20)	not null,
id_usuario	varchar(20)	not null,
constraint pk_gcw_preferencias PRIMARY KEY  NONCLUSTERED ( id_registro,id_usuario)
)
on 'default'
go

SETUSER
go
print    'gcw_colegio'
SETUSER 'dbo'
go
create table dbo.gcw_colegio (
id_colegio	varchar(20)	not null,
nombre	varchar(100)	null,
constraint pk_id_colegio PRIMARY KEY  NONCLUSTERED ( id_colegio)
)
on 'default'
go

SETUSER
go
print    'gcw_modulo'
SETUSER 'dbo'
go
create table dbo.gcw_modulo (
id_modulo	varchar(20)	not null,
nombre	varchar(100)	null,
descripcion	text	null,
orden	float	null,
es_aviso	varchar(1)	null,
rss	varchar(1)	null,
activo	varchar(1)	null,
plantilla	varchar(1)	null,
url	varchar(150)	null,
constraint pk_id_modulo PRIMARY KEY  NONCLUSTERED ( id_modulo)
)
on 'default'
go

SETUSER
go
print    'gcw_perfil'
SETUSER 'dbo'
go
create table dbo.gcw_perfil (
id_perfil	char(20)	not null,
codigo	varchar(3)	not null,
descripcion	varchar(150)	not null,
activo	varchar(1)	null,
constraint pk_id_perfil PRIMARY KEY  NONCLUSTERED ( id_perfil)
)
on 'default'
go

SETUSER
go
print    'gcw_preferencia'
SETUSER 'dbo'
go
create table dbo.gcw_preferencia (
id_modulo	varchar(20)	not null,
id_usuario	varchar(20)	not null,
constraint pk_gcw_preferencias PRIMARY KEY  NONCLUSTERED ( id_modulo,id_usuario)
)
on 'default'
go

SETUSER
go
print    'gcw_registro'
SETUSER 'dbo'
go
create table dbo.gcw_registro (
id_registro	varchar(20)	not null,
tipo_registro	varchar(20)	null,
id_modulo	varchar(20)	null,
id_usuario	varchar(20)	null,
fecha_intro	datetime	null,
id_registro_padre	varchar(20)	null,
titulo	varchar(255)	null,
resumen	varchar(255)	null,
texto	text	null,
imagen	varchar(255)	null,
hiperenlace	varchar(255)	null,
hiperenlace_texto	varchar(255)	null,
orden	int	null,
fecha_caducidad	datetime	null,
num_accesos	int	null,
disponible	varchar(1)	null,
novedad	varchar(1)	null,
activo	varchar(1)	null,
constraint pk_id_registro PRIMARY KEY  NONCLUSTERED ( id_registro)
)
on 'default'
go

SETUSER
go

print    'gcw_registro_perfil'
SETUSER 'dbo'
go
create table dbo.gcw_registro_perfil (
id_registro	varchar(20)	not null,
id_perfil	varchar(20)	not null,
constraint pk_id_registro_perfil PRIMARY KEY  NONCLUSTERED ( id_registro,id_perfil)
)
on 'default'
go

SETUSER
go
print    'gcw_tipo_archivo'
SETUSER 'dbo'
go
create table dbo.gcw_tipo_archivo (
id_tipo_archivo	varchar(20)	not null,
nombre	varchar(100)	null,
ruta	varchar(255)	null,
constraint pk_id_tipo_archivo PRIMARY KEY  NONCLUSTERED ( id_tipo_archivo)
)
on 'default'
go

SETUSER
go
print    'gcw_usuario'
SETUSER 'dbo'
go
create table dbo.gcw_usuario (
id_usuario	varchar(20)	not null,
id_colegio	varchar(20)	null,
id_tercero	varchar(20)	null,
nombre	varchar(100)	null,
login	varchar(100)	null,
password	varchar(20)	null,
administrador	varchar(1)	null,
accesos	int	null,
constraint pk_gcw_usuarios PRIMARY KEY  NONCLUSTERED ( id_usuario)
)
on 'default'
go

SETUSER
go
print    'gcw_usuario_perfil'
SETUSER 'dbo'
go
create table dbo.gcw_usuario_perfil (
id_usuario	char(10)	not null,
id_perfil	char(10)	not null,
constraint pk_id_usuario_perfil PRIMARY KEY  NONCLUSTERED ( id_usuario,id_perfil)
)
on 'default'
go

SETUSER
go
print    'grupos'
SETUSER 'dbo'
go
create table dbo.grupos (
grupos	char(1)	not null,
descripcion	char(40)	null,
constraint grupos_x PRIMARY KEY  NONCLUSTERED ( grupos)
)
on 'default'
go

SETUSER
go
print    'ho_contenidos'
SETUSER 'dbo'
go
create table dbo.ho_contenidos (
cod_contenido	char(10)	not null,
descripcion	char(255)	null,
constraint pk_ho_contenidos PRIMARY KEY  NONCLUSTERED ( cod_contenido)
)
on 'default'
go

SETUSER
go

print    'ho_parametros'
SETUSER 'dbo'
go
create table dbo.ho_parametros (
id_parametro	char(10)	not null,
cod_param	char(10)	not null,
descripcion	char(255)	not null,
valor	float	not null,
constraint pk_ho_parametros PRIMARY KEY  NONCLUSTERED ( id_parametro)
)
on 'default'
go

SETUSER
go
print    'ho_tablas'
SETUSER 'dbo'
go
create table dbo.ho_tablas (
desde	float	not null,
hasta	float	not null,
coef	float	not null,
limite	char(1)	not null,
tarifa	char(10)	not null,
contenido	char(4)	not null,
constraint cip_tablas_x PRIMARY KEY  NONCLUSTERED ( desde,hasta,tarifa,contenido)
)
on 'default'
go

SETUSER
go
print    'ho_tarifas'
SETUSER 'dbo'
go
create table dbo.ho_tarifas (
cod_tarifa	char(10)	not null,
descripcion	char(255)	null,
formula	char(255)	null,
param1	char(100)	null,
param2	char(100)	null,
param3	char(100)	null,
param4	char(100)	null,
param5	char(100)	null,
formula_cip	char(255)	null,
constraint ho_tarifas_x PRIMARY KEY  NONCLUSTERED ( cod_tarifa)
)
on 'default'
go

SETUSER
go
print    'ho_tarifas_contenidos'
SETUSER 'dbo'
go
create table dbo.ho_tarifas_contenidos (
cod_tarifa	char(10)	not null,
cod_contenido	char(10)	not null,
minimo	float	null,
coef	float	null,
minimo_cip	float	null,
constraint pk_ho_tarifas_contenidos PRIMARY KEY  NONCLUSTERED ( cod_tarifa,cod_contenido)
)
on 'default'
go

SETUSER
go



print    'hon_tablas'
SETUSER 'dbo'
go
create table dbo.hon_tablas (
desde	float	not null,
hasta	float	not null,
coef	float	not null,
limite	char(1)	not null,
tarifa	char(4)	not null,
contenido	char(4)	not null,
caso_limite	float	null,
constraint cip_tablas_x PRIMARY KEY  NONCLUSTERED ( desde,hasta,tarifa,contenido)
)
on 'default'
go

SETUSER
go
print    'honos_tablas_gui'
SETUSER 'dbo'
go
create table dbo.honos_tablas_gui (
desde	float	not null,
hasta	float	not null,
coef	float	null,
limite	char(1)	null,
tarifa	char(4)	not null,
desde_altura	float	not null,
hasta_altura	float	not null,
coef_aux	float	null,
constraint pk_honos_tablas_gui PRIMARY KEY  NONCLUSTERED ( desde,hasta,tarifa,desde_altura,hasta_altura)
)
on 'default'
go

SETUSER
go
print    'honos_tarifa_gui'
SETUSER 'dbo'
go
create table dbo.honos_tarifa_gui (
tipo_actuacion	char(2)	not null,
tipo_obra	char(2)	not null,
coef_aux	float	null,
tarifa	char(4)	null,
minimo	float	null,
modulaje	char(255)	null,
constraint honos_tarifa_x PRIMARY KEY  NONCLUSTERED ( tipo_actuacion,tipo_obra)
)
on 'default'
go

SETUSER
go
print    'incidencias'
SETUSER 'dbo'
go
create table dbo.incidencias (
id_incidencias	char(10)	not null,
id_colegiado	char(10)	null,
tipo	char(1)	not null,
id	char(10)	not null,
fecha	datetime	not null,
texto	text	not null,
constraint incidencias PRIMARY KEY  NONCLUSTERED ( id_incidencias )
)
on 'default'
go

SETUSER
go
print    'incidencias_exp'
SETUSER 'dbo'
go
create table dbo.incidencias_exp (
id_incidencias	char(10)	not null,
exp	char(12)	not null,
fecha	datetime	not null,
codigo	char(10)	not null,
observaciones	text	null,
constraint incidencias PRIMARY KEY  NONCLUSTERED ( id_incidencias)
)
on 'default'
go
print   'exp'
create nonclustered index exp
on dbo.incidencias_exp (exp)
on 'default'
go

go

SETUSER
go
print    'incidencias_expedientes'
SETUSER 'dbo'
go
create table dbo.incidencias_expedientes (
codigo	char(10)	not null,
descripcion	text	not null,
tipo_familia	char(10)	null,
aviso	char(1)	null,
constraint codigo PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
alter table incidencias 
add constraint fk_incidenc_reference_colegiad foreign key (id_colegiado) references colegiados(id_colegiado)
go

print    'incidencias_familias'
SETUSER 'dbo'
go
create table dbo.incidencias_familias (
codigo	char(10)	not null,
descripcion	text	not null,
constraint incidencias_familias PRIMARY KEY  NONCLUSTERED ( codigo )
)
on 'default'
go

SETUSER
go
print    'incidencias_fases'
SETUSER 'dbo'
go
create table dbo.incidencias_fases (
id_incidencias	char(10)	not null,
id_fase	char(10)	not null,
fecha	datetime	not null,
codigo	char(10)	not null,
observaciones	text	null,
usuario	char(10)	null,
constraint incidencias_fases PRIMARY KEY  NONCLUSTERED ( id_incidencias )
)
on 'default'
go
print   'id_fase'
create nonclustered index id_fase
on dbo.incidencias_fases (id_fase)
on 'default'
go

go

SETUSER
go
print    'incompatibilidades'
SETUSER 'dbo'
go
create table dbo.incompatibilidades (
id_incompatibilidad	char(10)	not null,
id_colegiado	char(10)	not null,
tipo_situacion	char(2)	null,
fecha_inicio	datetime	null,
fecha_fin	datetime	null,
incompatibilidad	char(1)	null,
tipo_incompatibilidad	char(2)	null,
organismo	char(40)	null,
cod_pob	char(6)	null,
observaciones	text	null,
constraint id_incompatibilidad PRIMARY KEY  NONCLUSTERED ( id_incompatibilidad)
)
on 'default'
go

SETUSER
go
print    'jg_asistentes'
SETUSER 'dbo'
go
create table dbo.jg_asistentes (
id_asistente	char(10)	not null,
cargo	char(2)	null,
nombre	char(255)	null,
horas	float	null,
dietas	float	null,
kilometraje	float	null,
gastos	float	null,
id_reunion	char(10)	null,
constraint id_asistente PRIMARY KEY  NONCLUSTERED ( id_asistente)
)
on 'default'
go

SETUSER
go
print    'jg_reuniones'
SETUSER 'dbo'
go
create table dbo.jg_reuniones (
id_reunion	char(10)	not null,
tipo	char(1)	null,
fecha	datetime	null,
lugar	char(255)	null,
tema	char(255)	null,
constraint jg_reuniones_x PRIMARY KEY  NONCLUSTERED ( id_reunion)
)
on 'default'
go

SETUSER
go
print    'libro_incidencias'
SETUSER 'dbo'
go
create table dbo.libro_incidencias (
id_docu	char(10)	not null,
obra	char(255)	null,
emplazamiento	char(255)	null,
propietario	char(10)	null,
arquitecto	char(50)	null,
coordinador	char(255)	null,
direccion	char(255)	null,
autor_estudio_seguridad	char(255)	null,
autor_plan_seguridad	char(255)	null,
coordinador_seguridad	char(255)	null,
contratista	char(255)	null,
colegio	char(2)	null,
supervision_proyecto	char(255)	null,
promotor	char(255)	null,
autor_proyecto	char(255)	null,
colegio_profesional	char(255)	null,
municipio	char(50)	null,
n_visado	char(60)	null,
fecha_entrega	datetime	null,
constraint documento PRIMARY KEY  NONCLUSTERED ( id_docu)
)
on 'default'
go

SETUSER
go

print    'libro_ordenes'
SETUSER 'dbo'
go
create table dbo.libro_ordenes (
id_docu	char(10)	not null,
obra	char(255)	null,
director_obra	char(10)	null,
arquitecto	char(10)	null,
constructor	char(255)	null,
propietario	char(10)	null,
emplazamiento	char(255)	null,
director_obra_texto	char(255)	null,
arquitecto_texto	char(255)	null,
propietario_texto	char(255)	null,
constraint libro_ordenes PRIMARY KEY  NONCLUSTERED ( id_docu )
)
on 'default'
go



SETUSER
go
print    'libros_ubicaciones'
SETUSER 'dbo'
go
create table dbo.libros_ubicaciones (
codigo	char(2)	not null,
ubicacion	char(50)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'listados'
SETUSER 'dbo'
go
create table dbo.listados (
descripcion	char(100)	not null,
dw	char(100)	not null,
ventana	char(50)	not null,
orden	char(2)	null,
activo	char(1)	null,
constraint i_listados PRIMARY KEY  NONCLUSTERED ( descripcion,dw,ventana)
)
on 'default'
go

SETUSER
go
print    'listas_colegiados'
SETUSER 'dbo'
go
create table dbo.listas_colegiados (
id_lista	char(10)	not null,
propietario	char(10)	not null,
nombre_lista	char(100)	null,
fecha_creacion	datetime	null,
activa	char(1)	null,
princ_fecha	char(40)	null,
princ_sn	char(40)	null,
princ_num	char(40)	null,
obs	char(40)	null,
f2	char(40)	null,
sn2	char(40)	null,
textocorto2	char(40)	null,
num2	char(40)	null,
compartida	char(1)	null,
constraint id_lista PRIMARY KEY  NONCLUSTERED ( id_lista)
)
on 'default'
go

SETUSER
go
print    'listas_miembros'
SETUSER 'dbo'
go
create table dbo.listas_miembros (
id_lista	char(10)	not null,
id_lista_miembro	char(10)	not null,
princ_fecha	datetime	null,
princ_sn	char(1)	null,
princ_num	float	null,
obs	text	null,
f2	datetime	null,
sn2	char(1)	null,
textocorto2	char(60)	null,
num2	float	null,
id_cliente	char(10)	not null,
constraint listas_miembros_x PRIMARY KEY  NONCLUSTERED ( id_lista,id_lista_miembro,id_cliente)
)
on 'default'
go

SETUSER
go

print    'menu'
SETUSER 'dbo'
go
create table dbo.menu (
codigo	char(10)	not null,
descripcion	char(50)	null,
objeto	char(255)	null,
visible	char(1)	null,
enabled	char(1)	null,
ventana	char(50)	null,
activo	char(1)	null,
constraint pk_menu PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'meses'
SETUSER 'dbo'
go
create table dbo.meses (
cod_mes	char(2)	not null,
nombre	char(15)	not null,
f_desde	datetime	not null,
f_hasta	datetime	not null,
constraint PK_MES PRIMARY KEY  CLUSTERED ( cod_mes)
)
on 'default'
go

SETUSER
go
print    'messages'
SETUSER 'dbo'
go
create table dbo.messages (
msgid	char(40)	not null,
msgtitle	char(255)	null,
msgtext	char(255)	null,
msgicon	char(12)	null,
msgbutton	char(17)	null,
msgdefaultbutton	int	null,
msgseverity	int	null,
msgprint	char(1)	null,
msguserinput	char(1)	null,
constraint messages_x PRIMARY KEY  NONCLUSTERED ( msgid)
)
on 'default'
go

SETUSER
go
print    'messages_ca'
SETUSER 'dbo'
go
create table dbo.messages_ca (
tag	varchar(250)	not null,
traduccion	varchar(250)	not null,
modulo	varchar(250)	not null,
nombre	varchar(250)	not null,
constraint PK_TAG PRIMARY KEY  NONCLUSTERED ( tag)
)
on 'default'
go

SETUSER
go

print    'modalidades'
SETUSER 'dbo'
go
create table dbo.modalidades (
cod_modalidad	char(2)	not null,
descripcion	char(60)	not null,
constraint cod_modalidad PRIMARY KEY  NONCLUSTERED ( cod_modalidad)
)
on 'default'
go

SETUSER
go
print    'modificaciones'
SETUSER 'dbo'
go
create table dbo.modificaciones (
id_modificacion	char(10)	not null,
id_aplicacion	char(10)	null,
modificacion	text	null,
usuario	char(50)	null,
fecha	datetime	null,
id_colegiado	char(10)	null,
tipo_modulo	char(2)	null,
constraint id_modificacion PRIMARY KEY  NONCLUSTERED ( id_modificacion)
)
on 'default'
go

SETUSER
go

print    'movimientos'
SETUSER 'dbo'
go
create table dbo.movimientos (
id_registro	char(10)	not null,
id_movimiento	char(20)	not null,
banco	char(4)	null,
oficina	char(4)	not null,
f_operacion	datetime	not null,
f_valor	datetime	not null,
concepto_comun	char(2)	not null,
concepto_operacion	char(3)	not null,
dh	char(1)	not null,
importe_movimiento	char(15)	not null,
c_c_obra	char(5)	not null,
ref_2	char(16)	null,
dc	char(1)	null,
anulado	char(1)	null,
id_movimiento_padre	char(20)	null,
contabilizado	char(1)	null,
n_contabilizacion	char(10)	null,
concepto_auxiliar	varchar(57)	null,
constraint movimientos_x PRIMARY KEY  NONCLUSTERED ( id_movimiento)
)
on 'default'
go

SETUSER
go
print    'municipios'
SETUSER 'dbo'
go
create table dbo.municipios (
provincia	char(5)	not null,
cod_muni	char(3)	not null,
descripcion	char(100)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( provincia,cod_muni)
)
on 'default'
go

SETUSER
go
print    'musaat'
SETUSER 'dbo'
go
create table dbo.musaat (
id_musaat	char(10)	not null,
id_col	char(10)	null,
n_mutualista	char(10)	null,
src_n_poliza	char(10)	null,
src_franqui	float	null,
src_franimp	float	null,
src_boni	float	null,
src_bonimp	float	null,
src_estado	char(2)	null,
src_t_poliza	char(2)	null,
src_importe_bonus	float	null,
src_coef_cm	float	null,
src_importe	float	null,
src_f_alta	datetime	null,
src_f_baja	datetime	null,
src_cober	char(3)	null,
src_cober_f_alta	datetime	null,
src_cober_f_baja	datetime	null,
accidentes_n_poliza	char(10)	null,
accidentes_asistencia	char(2)	null,
accidentes_importe	float	null,
accidentes_f_alta	datetime	null,
accidentes_f_baja	datetime	null,
accidentes_cober_f_alta	datetime	null,
accidentes_cober_f_baja	datetime	null,
accidentes_cober_muerte	float	null,
accidentes_cober_invalidez	int	null,
tasadores_n_poliza	char(10)	null,
tasadores_importe	float	null,
tasadores_f_alta	datetime	null,
tasadores_f_baja	datetime	null,
tasadores_cober	char(3)	null,
tasadores_cober_f_alta	datetime	null,
tasadores_cober_f_baja	datetime	null,
src_alta	char(1)	null,
accidentes_alta	char(1)	null,
tasadores_alta	char(1)	null,
accidentes_cia	char(2)	null,
accidentes_cober_invalidez2	float	null,
peritos_alta	char(1)	null,
peritos_n_poliza	char(10)	null,
peritos_importe	float	null,
peritos_f_alta	datetime	null,
peritos_f_baja	datetime	null,
peritos_cober	char(3)	null,
peritos_cober_f_alta	datetime	null,
peritos_cober_f_baja	datetime	null,
src_forma_pago	char(2)	null,
otros	char(255)	null,
src_cia	char(2)	null,
peritos_cia	char(2)	null,
tasadores_cia	char(2)	null,
src_prefijo	char(2)	null,
exceso	char(1)	null,
exceso_cobertura	char(3)	null,
exceso_n_poliza	char(10)	null,
exceso_f_efecto	datetime	null,
exceso_cober	float	null,
f_actividad_prof	datetime	null,
constraint musaat_x PRIMARY KEY  NONCLUSTERED ( id_musaat)
)
on 'default'
go
print   'id_col'
create nonclustered index id_col
on dbo.musaat (id_col)
on 'default'
go

go

SETUSER
go
print    'musaat_asistencia'
SETUSER 'dbo'
go
create table dbo.musaat_asistencia (
codigo	char(2)	not null,
descripcion	char(50)	null,
constraint musaat_asistencia_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'musaat_cias_aseguradoras'
SETUSER 'dbo'
go
create table dbo.musaat_cias_aseguradoras (
cod_s	nvarchar(2)	null,
nom_s	nvarchar(25)	null
)
on 'default'
go
print   'pk'
create unique nonclustered index pk
on dbo.musaat_cias_aseguradoras (cod_s)
on 'default'
go

go

SETUSER
go
print    'musaat_cober_exceso'
SETUSER 'dbo'
go
create table dbo.musaat_cober_exceso (
codigo	char(3)	not null,
prima	float	null,
constraint musaat_cober_exceso_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go

print    'musaat_cober_peritos'
SETUSER 'dbo'
go
create table dbo.musaat_cober_peritos (
codigo	char(3)	not null,
prima	float	null,
constraint musaat_cober_tasadores_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'musaat_cober_src'
SETUSER 'dbo'
go
create table dbo.musaat_cober_src (
codigo	char(3)	not null,
prima	float	null,
t_poliza	char(2)	null,
activo	char(1)	null,
cod_s	nvarchar(2)	null,
constraint musaat_cober_src_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'musaat_cober_tasadores'
SETUSER 'dbo'
go
create table dbo.musaat_cober_tasadores (
codigo	char(3)	not null,
prima	float	null,
constraint musaat_cober_tasadores_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'musaat_coef_c'
SETUSER 'dbo'
go
create table dbo.musaat_coef_c (
tipoact	char(3)	not null,
tipoobra	char(3)	not null,
coef	float(43)	not null,
tabla	char(10)	not null,
desde_sup	float(43)	null,
hasta_sup	float(43)	null,
f_desde	datetime	not null,
f_hasta	datetime	not null,
constraint musaat_coef_c_x PRIMARY KEY  NONCLUSTERED ( tipoact,tipoobra,coef,tabla,f_desde,f_hasta)
)
on 'default'
go

SETUSER
go
print    'musaat_coef_col'
SETUSER 'dbo'
go
create table dbo.musaat_coef_col (
coef	float	not null,
f_desde	datetime	not null,
f_hasta	datetime	not null,
constraint pk_musaat_coef_col PRIMARY KEY  NONCLUSTERED ( coef,f_desde,f_hasta)
)
on 'default'
go

SETUSER
go
print    'musaat_coef_g'
SETUSER 'dbo'
go
create table dbo.musaat_coef_g (
cobertura	float(43)	not null,
coef	float(43)	not null,
f_desde	datetime	not null,
f_hasta	datetime	not null,
constraint musaat_coef_g_x PRIMARY KEY  NONCLUSTERED ( cobertura,coef,f_desde,f_hasta)
)
on 'default'
go

SETUSER
go

print    'musaat_coef_k'
SETUSER 'dbo'
go
create table dbo.musaat_coef_k (
desde	float(43)	not null,
hasta	float(43)	not null,
coef	float(43)	not null,
tabla	char(10)	not null,
desde_pesetas	float(43)	null,
hasta_pesetas	float(43)	null,
f_desde	datetime	not null,
f_hasta	datetime	not null,
constraint musaat_coef_k_x PRIMARY KEY  NONCLUSTERED ( desde,hasta,coef,tabla,f_desde,f_hasta)
)
on 'default'
go

SETUSER
go
print    'musaat_desc_porc_part'
SETUSER 'dbo'
go
create table dbo.musaat_desc_porc_part (
desde	float	not null,
hasta	float	not null,
descuento	float	not null,
f_desde	datetime	not null,
f_hasta	datetime	not null,
constraint musaat_desc_porc_part_x PRIMARY KEY  NONCLUSTERED ( desde,hasta,descuento,f_desde,f_hasta)
)
on 'default'
go

SETUSER
go
print    'musaat_histo_cober_src'
SETUSER 'dbo'
go
create table dbo.musaat_histo_cober_src (
id_cobertura	char(10)	not null,
id_colegiado	char(10)	not null,
codigo	char(3)	null,
fecha	datetime	null,
observaciones	text	null,
src_coef_cm	float	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( id_cobertura)
)
on 'default'
go
print   'id_colegiado'
create nonclustered index id_colegiado
on dbo.musaat_histo_cober_src (id_colegiado)
on 'default'
go

go

SETUSER
go
print    'musaat_movimientos'
SETUSER 'dbo'
go
create table dbo.musaat_movimientos (
id_movimiento	char(10)	not null,
id_fase	char(10)	null,
id_col	char(10)	null,
n_contrato	char(10)	null,
n_col	char(15)	null,
honorarios	float	null,
importe_cobrado	float	null,
fecha_calculo	datetime	null,
importe_pendiente	float	null,
fecha_notificacion	datetime	null,
id_factura	char(10)	null,
tabla	char(10)	null,
coef_k	float	null,
coef_c	float	null,
coef_g	float	null,
presupuesto	float	null,
importe_vble	float	null,
superficie	float	null,
cobertura	float	null,
tipo_act	char(3)	null,
tipo_obra	char(3)	null,
volumen	float	null,
altura	float	null,
t_visado	char(1)	null,
coef_sin	float	null,
destino	char(2)	null,
nif_pagador	char(15)	null,
coef_col	float	null,
prefijo	char(3)	null,
num_pol	char(10)	null,
num_mut	char(10)	null,
seguridad	char(3)	null,
obra_oficial	char(1)	null,
porcentaje	float	null,
n_contrato_ant	char(10)	null,
pagador	char(1)	null,
id_minuta	char(10)	null,
aplica_10	char(1)	null,
anulado	char(1)	null,
tipo_csd	char(2)	null,
f_musaat	datetime	null,
decenal	char(1)	null,
observaciones	char(60)	null,
colindantes2m	char(1)	DEFAULT  'N' 	null,
doble_condicion	char(1)	DEFAULT  'N' 	null,
int_forzosa	char(1)	DEFAULT  'N' null	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( id_movimiento)
)
on 'default'
go
print   'fecha_calculo'
create nonclustered index fecha_calculo
on dbo.musaat_movimientos (fecha_calculo)
on 'default'
go

print   'id_col'
create nonclustered index id_col
on dbo.musaat_movimientos (id_col)
on 'default'
go

print   'id_fase'
create nonclustered index id_fase
on dbo.musaat_movimientos (id_fase)
on 'default'
go

print   'id_minuta'
create nonclustered index id_minuta
on dbo.musaat_movimientos (id_minuta)
on 'default'
go

go

SETUSER
go
print    'musaat_src_estado'
SETUSER 'dbo'
go
create table dbo.musaat_src_estado (
codigo	char(2)	not null,
descripcion	char(30)	null,
constraint musaat_src_estado_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go

print    'musaat_src_t_poliza'
SETUSER 'dbo'
go
create table dbo.musaat_src_t_poliza (
codigo	char(2)	not null,
descripcion	char(30)	null,
constraint musaat_src_t_poliza_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'musaat_tarifa_e'
SETUSER 'dbo'
go
create table dbo.musaat_tarifa_e (
volumen_desde	float(43)	not null,
volumen_hasta	float(43)	not null,
importe_base	float(43)	null,
f_desde	datetime	not null,
f_hasta	datetime	not null,
constraint musaat_tarifa_e_x PRIMARY KEY  NONCLUSTERED ( volumen_desde,volumen_hasta,f_desde,f_hasta)
)
on 'default'
go

SETUSER
go
print    'musaat_tarifas'
SETUSER 'dbo'
go
create table dbo.musaat_tarifas (
tarifa	char(3)	not null,
minimo	float(43)	not null,
f_desde	datetime	not null,
f_hasta	datetime	not null,
constraint musaat_tarifas_x PRIMARY KEY  NONCLUSTERED ( tarifa,minimo,f_desde,f_hasta)
)
on 'default'
go

SETUSER
go
print    'musaat_tipo_visado'
SETUSER 'dbo'
go
create table dbo.musaat_tipo_visado (
tipo_visado	char(1)	not null,
descripcion	char(60)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( tipo_visado)
)
on 'default'
go

SETUSER
go
print    'musaat_tipologia'
SETUSER 'dbo'
go
create table dbo.musaat_tipologia (
tipo_csd	char(2)	not null,
t_visado	char(1)	not null,
obra_admin	char(1)	not null,
descripcion	char(100)	not null,
constraint pk PRIMARY KEY  NONCLUSTERED ( tipo_csd)
)
on 'default'
go

SETUSER
go
print    'musaat_tipos_oo'
SETUSER 'dbo'
go
create table dbo.musaat_tipos_oo (
tipo_oo	char(1)	not null,
descripcion	char(60)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( tipo_oo)
)
on 'default'
go

SETUSER
go

print    'notificaciones'
SETUSER 'dbo'
go
create table dbo.notificaciones (
nombre	char(100)	not null,
dataobject	char(100)	null,
tipo_destinatario	char(2)	null,
codigo	char(2)	not null,
sig_carta	char(2)	null,
pagador	char(1)	null,
es_primera	char(1)	null,
ciclo	float	null,
tipo_gestion	char(1)	null,
tiene_detalle	char(1)	null,
comunicado	char(50)	null,
estado_fase_asociado	char(2)	null,
tipo_minuta	char(1)	null,
constraint notificaciones PRIMARY KEY  NONCLUSTERED ( )
)
on 'default'
go

SETUSER
go
print    'orientaciones_profesionales'
SETUSER 'dbo'
go
create table dbo.orientaciones_profesionales (
id_colegiado	char(10)	not null,
id_orientaciones	char(10)	not null,
orientacion_profesional	char(2)	not null,
descripcion	char(60)	null,
constraint id_orientaciones PRIMARY KEY  NONCLUSTERED ( id_orientaciones)
)
on 'default'
go

SETUSER
go
print    'origen_inhabilitacion'
SETUSER 'dbo'
go
create table dbo.origen_inhabilitacion (
codigo	char(2)	not null,
descripcion	char(150)	null,
constraint pk_origen_inhabilitacion PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'otras_personas'
SETUSER 'dbo'
go
create table dbo.otras_personas (
codigo	char(6)	not null,
nombre	char(100)	not null,
cargo	char(2)	not null,
constraint id_otras_personas PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'otros_conceptos'
SETUSER 'dbo'
go
create table dbo.otros_conceptos (
codigo	char(2)	not null,
tipo	char(1)	null,
modulo	char(1)	null,
colegio	char(2)	null,
descripcion	char(60)	null,
constraint id_codigo PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'otros_datos_colegiado'
SETUSER 'dbo'
go
create table dbo.otros_datos_colegiado (
cod_caracteristica	char(2)	not null,
id_colegiado	char(10)	not null,
numero	float	null,
s_n	char(1)	null,
texto	text	null,
fecha	datetime	null,
constraint id_otros_datos_colegiado PRIMARY KEY  NONCLUSTERED ( cod_caracteristica,id_colegiado)
)
on 'default'
go

SETUSER
go

print    'paises'
SETUSER 'dbo'
go
create table dbo.paises (
cod_pais	char(10)	not null,
nombre	char(50)	not null,
cod_iso	char(5)	null,
constraint paises_x PRIMARY KEY  NONCLUSTERED ( cod_pais)
)
on 'default'
go

SETUSER
go

print    'personalidad_juridica'
SETUSER 'dbo'
go
create table dbo.personalidad_juridica (
c_personalidad	char(2)	not null,
d_personalidad	char(60)	null,
constraint cp_personalidad PRIMARY KEY  NONCLUSTERED ( c_personalidad)
)
on 'default'
go

SETUSER
go
print    'personas_asociadas'
SETUSER 'dbo'
go
create table dbo.personas_asociadas (
id_linea	char(10)	not null,
id_cabecera	char(10)	null,
tipo_modulo	char(1)	null,
nombre	char(100)	null,
telefono	char(30)	null,
fax	char(30)	null,
movil	char(30)	null,
email	char(30)	null,
tipo_cargo	char(2)	null,
obs	char(255)	null,
constraint pk_id_linea PRIMARY KEY  NONCLUSTERED ( id_linea)
)
on 'default'
go

SETUSER
go
print    'plantillas'
SETUSER 'dbo'
go
create table dbo.plantillas (
codigo	char(10)	not null,
descripcion	char(150)	null,
ruta	char(150)	null,
modulo	char(100)	null,
individual	char(2)	null,
constraint plantillas_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'plantillas_campos'
SETUSER 'dbo'
go
create table dbo.plantillas_campos (
modulo	char(100)	not null,
campo_formulario	char(100)	not null,
campo_interno	char(100)	not null
)
on 'default'
go
print   'plantillas_campos_x'
create unique nonclustered index plantillas_campos_x
on dbo.plantillas_campos (modulo, campo_formulario)
on 'default'
go

go

SETUSER
go
print    'plantillas_campos_extra'
SETUSER 'dbo'
go
create table dbo.plantillas_campos_extra (
cod_plant	char(10)	not null,
campo_formulario	char(100)	not null,
nombre_etiqueta	char(100)	not null,
constraint pk PRIMARY KEY  NONCLUSTERED ( cod_plant,campo_formulario)
)
on 'default'
go

SETUSER
go
print    'poblaciones'
SETUSER 'dbo'
go
create table dbo.poblaciones (
cod_pob	char(6)	not null,
cod_pos	char(6)	not null,
descripcion	char(60)	not null,
provincia	char(5)	not null,
pob_mopu	char(6)	null,
pobla_migra	char(50)	null,
cod_bueno	char(6)	null,
tipo	char(1)	null,
cp_asociado	char(6)	null,
zona	char(3)	null,
constraint poblaciones PRIMARY KEY  NONCLUSTERED ( cod_pob )
)
on 'default'
go
print   'cod_pos'
create nonclustered index cod_pos
on dbo.poblaciones (cod_pos)
on 'default'
go

print   'descripcion'
create nonclustered index descripcion
on dbo.poblaciones (descripcion)
on 'default'
go

go

SETUSER
go

print    'poblaciones_zonas'
SETUSER 'dbo'
go
create table dbo.poblaciones_zonas (
codigo	char(3)	not null,
descripcion	char(50)	not null,
constraint pk_pobla_zonas PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'premaat'
SETUSER 'dbo'
go
create table dbo.premaat (
id_premaat	char(10)	not null,
id_col	char(15)	not null,
n_col	char(15)	null,
n_mutualista	char(10)	null,
nif	char(15)	null,
tipo_mutualista	char(2)	null,
tipo_prestacion	char(2)	null,
situacion	char(2)	null,
importe_cobrar	float	null,
importe_pagar	float	null,
n_conyuges	float	null,
n_hijos	float	null,
f_pasivo	datetime	null,
grupo	char(2)	null,
f_alta	datetime	null,
grupo_comple1	char(1)	null,
importe_pagar_comple1	float	null,
id_heredero	char(10)	null,
f_alta_comple1	datetime	null,
grupo_comple2	char(1)	null,
importe_pagar_comple2	float	null,
f_alta_comple2	datetime	null,
f_baja	datetime	null,
forma_pago	char(2)	null,
forma_cobro	char(2)	null,
alta	char(1)	null,
modulo_ahorro	char(1)	null,
observaciones	text	null,
constraint premaat_x PRIMARY KEY  NONCLUSTERED ( id_premaat)
)
on 'default'
go

SETUSER
go
print    'premaat_beneficiarios'
SETUSER 'dbo'
go
create table dbo.premaat_beneficiarios (
id	char(10)	not null,
id_col	char(15)	null,
n_mutualista	char(10)	null,
nif	char(10)	null,
tipo_mutualista	char(2)	null,
tipo_prestacion	char(2)	null,
situacion	char(2)	null,
importe_cobrar	float	null,
parentesco	char(2)	null,
f_alta	datetime	null,
alta	char(1)	null,
id_heredero	char(10)	null,
forma_pago	char(2)	null,
constraint premaat_beneficiarios_x PRIMARY KEY  NONCLUSTERED ( id)
)
on 'default'
go
print   'id_col'
create nonclustered index id_col
on dbo.premaat_beneficiarios (id_col)
on 'default'
go

print   'id_heredero'
create nonclustered index id_heredero
on dbo.premaat_beneficiarios (id_heredero)
on 'default'
go

go

SETUSER
go
print    'premaat_grupo'
SETUSER 'dbo'
go
create table dbo.premaat_grupo (
codigo	char(2)	not null,
descripcion	char(30)	null,
constraint premaat_grupo_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'premaat_historico'
SETUSER 'dbo'
go
create table dbo.premaat_historico (
id_modificacion	char(10)	not null,
id_premaat	char(10)	not null,
fecha	datetime	null,
tipo	char(1)	null,
usuario	char(10)	null,
constraint pk_id_mod PRIMARY KEY  CLUSTERED ( id_modificacion)
)
on 'default'
go

SETUSER
go
print    'premaat_liquidaciones'
SETUSER 'dbo'
go
create table dbo.premaat_liquidaciones (
id_liquidacion	char(10)	not null,
f_liquidacion	datetime	null,
estado	char(1)	null,
contabilizada	char(1)	null,
forma_pago	char(2)	null,
banco	char(20)	null,
importe	float	null,
n_documento	char(20)	null,
id_colegiado	char(10)	null,
id_beneficiario	char(10)	null,
nombre	char(200)	null,
cta_pago	char(10)	null,
descripcion_larga	char(100)	null,
tipo	char(1)	null,
id_fase	char(10)	null,
id_factura	char(15)	null,
centro	char(2)	null,
contrapartida	char(10)	null,
mensual	char(1)	null,
f_entrada	datetime	null,
empresa	char(2)	null,
cod_usuario	char(10)	null,
constraint premaat_liquidaciones_x PRIMARY KEY  NONCLUSTERED ( id_liquidacion)
)
on 'default'
go
print   'id_beneficiario'
create nonclustered index id_beneficiario
on dbo.premaat_liquidaciones (id_beneficiario)
on 'default'
go

print   'id_colegiado'
create nonclustered index id_colegiado
on dbo.premaat_liquidaciones (id_colegiado)
on 'default'
go

go

SETUSER
go

print    'premaat_parentesco'
SETUSER 'dbo'
go
create table dbo.premaat_parentesco (
codigo	char(2)	not null,
descripcion	char(20)	null,
constraint premaat_parentesco_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'premaat_prestaciones'
SETUSER 'dbo'
go
create table dbo.premaat_prestaciones (
id_prestaciones	char(10)	not null,
id_premaat	char(10)	null,
tipo_persona	char(1)	null,
id_persona	char(15)	null,
tipo_prestacion	char(2)	null,
importe	float	null,
forma_pago	char(2)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( id_prestaciones)
)
on 'default'
go
print   'id_persona'
create nonclustered index id_persona
on dbo.premaat_prestaciones (id_persona)
on 'default'
go

print   'id_premaat'
create nonclustered index id_premaat
on dbo.premaat_prestaciones (id_premaat)
on 'default'
go

go

SETUSER
go
print    'premaat_situacion'
SETUSER 'dbo'
go
create table dbo.premaat_situacion (
codigo	char(2)	not null,
descripcion	char(30)	null,
constraint premaat_situacion_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'premaat_tablas'
SETUSER 'dbo'
go
create table dbo.premaat_tablas (
anyo	char(4)	not null,
basico	float	null,
hombre_2000	float	null,
mujer_2000	float	null,
ahorro_2000	float	null,
comple_1	float	null,
constraint pk_premaat_tablas PRIMARY KEY  NONCLUSTERED ( anyo)
)
on 'default'
go

SETUSER
go
print    'premaat_tipo_mut'
SETUSER 'dbo'
go
create table dbo.premaat_tipo_mut (
codigo	char(2)	not null,
descripcion	char(30)	null,
constraint premaat_tipo_mut_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'premaat_tipo_pres'
SETUSER 'dbo'
go
create table dbo.premaat_tipo_pres (
codigo	char(2)	not null,
descripcion	char(30)	null,
es_extra	char(1)	null,
constraint premaat_tipo_pres_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go

print    'prestamos'
SETUSER 'dbo'
go
create table dbo.prestamos (
id_prestamo	char(10)	not null,
id_libro	char(10)	not null,
f_prestamo	datetime	null,
f_devolucion_prevista	datetime	null,
f_devolucion_real	datetime	null,
observaciones	text	null,
id_aparato	char(10)	null,
constraint id_prestamo PRIMARY KEY  NONCLUSTERED ( id_prestamo)
)
on 'default'
go

SETUSER
go
print    'provincias'
SETUSER 'dbo'
go
create table dbo.provincias (
cod_provincia	char(5)	not null,
cod_pais	char(5)	not null,
nombre	char(50)	not null,
id_comunidad_autonoma	char(10)	null,
constraint provincias_x PRIMARY KEY  NONCLUSTERED ( cod_provincia)
)
on 'default'
go

SETUSER
go
print    'reg_apdir'
SETUSER 'dbo'
go
create table dbo.reg_apdir (
dicod	int	not null,
dides	char(40)	null,
dipob	int	null,
dipoi	float	null,
constraint reg_apdir_x PRIMARY KEY  NONCLUSTERED ( dicod)
)
on 'default'
go

SETUSER
go
print    'registro'
SETUSER 'dbo'
go
create table dbo.registro (
id_registro	char(10)	not null,
n_registro	char(20)	null,
n_registro_ref	char(20)	null,
oficial	char(1)	null,
fecha	datetime	null,
es	char(1)	null,
interno	char(1)	null,
codigo_o	char(15)	null,
nombre_o	char(100)	null,
departamento_o	char(2)	null,
tipo_persona_o	char(1)	null,
codigo_d	char(15)	null,
nombre_d	char(100)	null,
departamento_d	char(2)	null,
tipo_persona_d	char(1)	null,
asunto	text	null,
n_expediente	char(20)	null,
texto	text	null,
marca	char(1)	null,
usuario	char(10)	null,
fecha_grabacion	datetime	null,
transporte	char(2)	null,
cumplimentado	char(1)	null,
id_o	char(10)	null,
id_d	char(10)	null,
f_escrito	datetime	null,
poblacion_o	char(6)	null,
poblacion_d	char(6)	null,
f_vencimiento	datetime	null,
n_registro_bis	char(20)	null,
celda	char(5)	null,
archivo	char(60)	null,
n_expedi	char(10)	null,
cod_delegacion	char(2)	null,
tipo_comunicado	char(2)	null,
acuse	char(1)	null,
salida	char(1)	null,
f_salida	datetime	null,
serie	char(10)	null,
empresa	char(2)	null,
constraint registro PRIMARY KEY  NONCLUSTERED ( id_registro )
)
on 'default'
go
print   'reg_fecha'
create nonclustered index reg_fecha
on dbo.registro (fecha)
on 'default'
go

print   'reg_n_registro'
create nonclustered index reg_n_registro
on dbo.registro (n_registro)
on 'default'
go

go

SETUSER
go
print    'registro_almacenes'
SETUSER 'dbo'
go
create table dbo.registro_almacenes (
registro	char(60)	not null,
constraint pk PRIMARY KEY  NONCLUSTERED ( registro)
)
on 'default'
go

SETUSER
go

print    'registro_anexos'
SETUSER 'dbo'
go
create table dbo.registro_anexos (
id_registro_anexo	char(10)	not null,
id_registro	char(10)	not null,
ruta	char(255)	null,
programa	char(25)	null,
id_documento_modulo	char(20)	null,
constraint registro_a PRIMARY KEY  NONCLUSTERED ( id_registro_anexo)
)
on 'default'
go
print   'id_registro'
create nonclustered index id_registro
on dbo.registro_anexos (id_registro)
on 'default'
go

go

SETUSER
go
print    'registro_series'
SETUSER 'dbo'
go
create table dbo.registro_series (
codigo	char(10)	not null,
descripcion	char(100)	null,
cod_delegacion	char(2)	not null,
contador	float	null,
tipo	char(1)	null,
ruta_base	char(255)	null,
tiene_anyo	char(1)	null,
tiene_carpeta_final	char(1)	null,
impresora	char(100)	null,
bandeja	char(2)	DEFAULT  '0' 	null,
cod_aplicacion	char(10)	null,
ruta_virtual	char(255)	null,
empresa	char(2)	not null,
constraint pk_serie PRIMARY KEY  NONCLUSTERED ( codigo,cod_delegacion,empresa)
)
on 'default'
go

SETUSER
go
print    'registro_t_comunicado'
SETUSER 'dbo'
go
create table dbo.registro_t_comunicado (
codigo	char(2)	not null,
descripcion	char(255)	null,
constraint pk_registro_t_comunicado PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'regsoc'
SETUSER 'dbo'
go
create table dbo.regsoc (
id_regsoc	char(20)	not null,
num_reg_colegio	varchar(10)	null,
num_reg_mercantil	varchar(10)	null,
id_colegiado_sociedad	char(10)	null,
razon_social	varchar(255)	null,
cod_forma_juridica	char(3)	null,
cif	varchar(15)	null,
direccion	varchar(100)	null,
cod_pob	char(6)	null,
cod_prov	char(5)	null,
cp	char(6)	null,
poblacion_descripcion	varchar(100)	null,
telefono	varchar(30)	null,
fax	varchar(30)	null,
mail	varchar(100)	null,
web	varchar(100)	null,
const_notario	varchar(200)	null,
const_lugar	varchar(100)	null,
const_fecha	datetime	null,
const_protocolo	varchar(10)	null,
adap_notario	varchar(200)	null,
adap_lugar	varchar(100)	null,
adap_fecha	datetime	null,
adap_protocolo	varchar(10)	null,
multidisciplinar	char(1)	DEFAULT  'N' 	null,
cod_reg_mercantil	char(3)	null,
fecha_salida_registro	datetime	null,
fecha_llegada_colegio	datetime	null,
fecha_junta	datetime	null,
fecha_inscripcion	datetime	null,
fecha_duracion	datetime	null,
fecha_baja	datetime	null,
tomo	varchar(10)	null,
libro	varchar(10)	null,
folio	varchar(10)	null,
hoja_numero	varchar(10)	null,
inscripcion	varchar(10)	null,
observaciones	varchar(255)	null,
acreditado	char(1)	DEFAULT  'N' 	null,
indefinida	char(1)	null,
organo_admon	varchar(255)	null,
indefinido	char(1)	null,
constraint pk_regsoc PRIMARY KEY  CLUSTERED ( id_regsoc)
)
on 'default'
go

SETUSER
go
print    'regsoc_actividades'
SETUSER 'dbo'
go
create table dbo.regsoc_actividades (
id_regsoc_actividad	char(10)	not null,
id_regsoc	char(10)	null,
descripcion	varchar(255)	null,
constraint regsoc_actividades_x PRIMARY KEY  NONCLUSTERED ( id_regsoc_actividad)
)
on 'default'
go

SETUSER
go
print    'regsoc_agenda'
SETUSER 'dbo'
go
create table dbo.regsoc_agenda (
id_regsoc_agenda	char(10)	not null,
id_regsoc	char(10)	null,
fecha	datetime	null,
cod_tipo_entrada_agenda	char(5)	null,
descripcion	varchar(255)	null,
constraint id_regsoc_agenda PRIMARY KEY  NONCLUSTERED ( id_regsoc_agenda)
)
on 'default'
go

SETUSER
go

print    'regsoc_sancion'
SETUSER 'dbo'
go
create table dbo.regsoc_sancion (
id_reg_soc_sancion	char(10)	not null,
id_regsoc	char(10)	null,
fecha	datetime	null,
cod_tipo_sancion	char(3)	null,
descripcion	varchar(255)	null,
constraint id_regsoc_sancion PRIMARY KEY  NONCLUSTERED ( id_reg_soc_sancion)
)
on 'default'
go

SETUSER
go
print    'regsoc_tipo_entrada_agenda'
SETUSER 'dbo'
go
create table dbo.regsoc_tipo_entrada_agenda (
cod_tipo_entrada_agenda	char(3)	not null,
descripcion	varchar(100)	null,
constraint cod_tipo_entrada_agenda PRIMARY KEY  NONCLUSTERED ( cod_tipo_entrada_agenda)
)
on 'default'
go

SETUSER
go
print    'regsoc_tipo_forma_juridica'
SETUSER 'dbo'
go
create table dbo.regsoc_tipo_forma_juridica (
cod_forma_juridica	char(3)	not null,
descripcion	varchar(100)	null,
constraint regsoc_forma_juridica_x PRIMARY KEY  NONCLUSTERED ( cod_forma_juridica)
)
on 'default'
go

SETUSER
go
print    'regsoc_tipo_registro_mercantil'
SETUSER 'dbo'
go
create table dbo.regsoc_tipo_registro_mercantil (
cod_reg_mercantil	char(3)	not null,
descripcion	varchar(100)	null,
direccion	varchar(100)	null,
cod_pob	char(6)	null,
cod_prov	char(5)	null,
cp	varchar(6)	null,
telefono	varchar(30)	null,
fax	varchar(30)	null,
mail	varchar(100)	null,
web	varchar(100)	null,
constraint resoc_registro_mercantil_x PRIMARY KEY  NONCLUSTERED ( cod_reg_mercantil)
)
on 'default'
go

SETUSER
go
print    'regsoc_tipo_sancion'
SETUSER 'dbo'
go
create table dbo.regsoc_tipo_sancion (
cod_tipo_sancion	char(3)	not null,
descripcion	varchar(100)	null,
constraint cod_tipo_sancion PRIMARY KEY  NONCLUSTERED ( cod_tipo_sancion)
)
on 'default'
go

SETUSER
go
print    'remesa_confirming'
SETUSER 'dbo'
go
create table dbo.remesa_confirming (
id_remesa	varchar(10)	not null,
banco	varchar(10)	null,
concepto	varchar(50)	null,
codigo	varchar(10)	null,
fecha	datetime	null,
fecha_venc	datetime	null,
agrupar_apuntes	varchar(1)	null,
constraint pk_id_remesa PRIMARY KEY  NONCLUSTERED ( id_remesa)
)
on 'default'
go

SETUSER
go

print    'remesas'
SETUSER 'dbo'
go
create table dbo.remesas (
n_remesa	char(10)	not null,
fecha	datetime	null,
descripcion	char(100)	null,
tipo	char(1)	null,
anulada	char(1)	null,
banco	char(10)	null,
n_fact_desde	char(15)	null,
n_fact_hasta	char(15)	null,
cod_usuario	char(10)	null,
referencia_tpv	char(40)	null,
empresa	char(2)	not null,
constraint n_remesa PRIMARY KEY  NONCLUSTERED ( n_remesa,empresa)
)
on 'default'
go

SETUSER
go
print    'remesas_reclamaciones'
SETUSER 'dbo'
go
create table dbo.remesas_reclamaciones (
id_remesas_reclamaciones	char(10)	not null,
n_remesa	char(10)	null,
fecha	datetime	null,
tipo_reclamacion	char(2)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( id_remesas_reclamaciones)
)
on 'default'
go

SETUSER
go
print    'reparos_ficha'
SETUSER 'dbo'
go
create table dbo.reparos_ficha (
id_reparo_ficha	char(10)	not null,
n_ficha	char(10)	null,
fecha	datetime	not null,
f_subsanacion	datetime	null,
apto	char(1)	null,
sms	char(1)	null,
email	char(1)	null,
web	char(1)	null,
carta	char(1)	null,
anulado	char(1)	null,
id_usuario	char(10)	null,
id_colegiado	char(10)	null,
id_fase	char(10)	null,
f_envio	datetime	null,
notificado	char(1)	null,
constraint id_reparo_ficha PRIMARY KEY  NONCLUSTERED ( id_reparo_ficha)
)
on 'default'
go

SETUSER
go
print    'reparos_ficha_linea'
SETUSER 'dbo'
go
create table dbo.reparos_ficha_linea (
id_reparo_linea	char(10)	not null,
id_reparo_ficha	char(10)	not null,
codigo_reparo	char(10)	null,
f_subsanacion	datetime	null,
subsanado	char(1)	null,
texto	text	null,
observaciones	text	null,
orden	int	null,
constraint id_reparo_linea PRIMARY KEY  NONCLUSTERED ( id_reparo_linea)
)
on 'default'
go

SETUSER
go
print    'reparos_ficha_linea_2'
SETUSER 'dbo'
go
create table dbo.reparos_ficha_linea_2 (
id_reparo_linea	char(10)	not null,
id_reparo_ficha	char(10)	not null,
codigo_reparo	char(3)	null,
f_subsanacion	datetime	null,
subsanado	char(1)	null,
texto	text	null,
observaciones	text	null
)
on 'default'
go

SETUSER
go
print    'retirada_documentacion'
SETUSER 'dbo'
go
create table dbo.retirada_documentacion (
id_retirada	char(10)	not null,
id_expedi	char(10)	not null,
entregado_a	char(50)	null,
f_retirada	datetime	null,
usuario	char(10)	null,
observaciones	char(255)	null
)
on 'default'
go

SETUSER
go

print    'sini_damnificados'
SETUSER 'dbo'
go
create table dbo.sini_damnificados (
codigo	char(2)	not null,
descripcion	char(255)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'sini_estimacion_economica'
SETUSER 'dbo'
go
create table dbo.sini_estimacion_economica (
codigo	char(2)	not null,
descripcion	char(255)	null,
constraint codigo_sini_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'sini_tipo_danyos'
SETUSER 'dbo'
go
create table dbo.sini_tipo_danyos (
codigo	char(2)	not null,
descripcion	char(255)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'sini_tipo_estado_obra'
SETUSER 'dbo'
go
create table dbo.sini_tipo_estado_obra (
codigo	char(2)	not null,
descripcion	char(255)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'sini_tipo_reclamacion'
SETUSER 'dbo'
go
create table dbo.sini_tipo_reclamacion (
codigo	char(3)	not null,
descripcion	char(255)	not null,
grupo	char(2)	not null,
constraint pk_sini_tipo_reclamacion PRIMARY KEY  CLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'sociedades'
SETUSER 'dbo'
go
create table dbo.sociedades (
id_regsoc_socio	char(10)	not null,
id_regsoc	nvarchar(20)	null,
id_col_per	char(10)	null,
id_col_soc	char(10)	null,
id_cli_per	char(10)	null,
porcent	float	null,
nombre	char(255)	null,
nif	char(20)	null,
f_inicio	datetime	null,
f_final	datetime	null,
administrador	char(1)	null,
alta	char(1)	null,
capital_social	float	null,
porc_capital_social	float	null,
cod_colegio	nvarchar(255)	null,
num_colegio_adscripcion	nvarchar(15)	null,
tipo	char(1)	null,
apellidos	nvarchar(255)	null,
poblacion_descripcion	nvarchar(100)	null,
cod_pob	nvarchar(6)	null,
cod_prov	nvarchar(5)	null,
cp	nvarchar(6)	null,
telefono	nvarchar(30)	null,
fax	nvarchar(30)	null,
colegio_procedencia	nvarchar(255)	null,
id_actividad	nvarchar(10)	null,
num_colegiado	nvarchar(15)	null,
direccion	nvarchar(255)	null,
representante	char(1)	null,
constraint sociedades_x PRIMARY KEY  NONCLUSTERED ( id_regsoc_socio)
)
on 'default'
go

SETUSER
go

print    't_agrupaciones'
SETUSER 'dbo'
go
create table dbo.t_agrupaciones (
cod_agrupacion	char(2)	not null,
descripcion	char(60)	not null,
constraint id_agrupacion PRIMARY KEY  NONCLUSTERED ( cod_agrupacion)
)
on 'default'
go

SETUSER
go
print    't_altas_bajas_situaciones'
SETUSER 'dbo'
go
create table dbo.t_altas_bajas_situaciones (
codigo	char(2)	not null,
alta	char(1)	not null,
baja	char(1)	not null,
situacion	char(1)	not null,
descripcion	char(60)	not null,
residente	char(1)	null,
constraint id_altas_bajas_situaciones PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    't_aplicacion'
SETUSER 'dbo'
go
create table dbo.t_aplicacion (
cod_aplicacion	char(10)	not null,
nombre	char(50)	not null,
constraint t_aplicacion_x PRIMARY KEY  NONCLUSTERED ( cod_aplicacion)
)
on 'default'
go

SETUSER
go
print    't_control_eventos'
SETUSER 'dbo'
go
create table dbo.t_control_eventos (
control	char(20)	null,
evento	char(20)	null,
activo	char(1)	null,
param1	char(50)	null,
param2	char(50)	null,
id_control	char(10)	not null,
orden	char(2)	null,
param3	char(50)	null,
mensaje	char(255)	null,
constraint t_control_eventos PRIMARY KEY  NONCLUSTERED ( id_control )
)
on 'default'
go

SETUSER
go
print    't_descripcion_fases'
SETUSER 'dbo'
go
create table dbo.t_descripcion_fases (
id_descripcion	char(50)	not null,
constraint t_descripcion_fases PRIMARY KEY  NONCLUSTERED ( id_descripcion )
)
on 'default'
go

SETUSER
go

print    't_destinos'
SETUSER 'dbo'
go
create table dbo.t_destinos (
codigo	char(3)	not null,
descripcion	char(60)	null,
constraint t_destinos_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    't_documentos'
SETUSER 'dbo'
go
create table dbo.t_documentos (
c_t_documentos	char(2)	not null,
d_t_documentos	char(60)	null,
expedi	char(1)	null,
fase	char(1)	null,
visared	char(1)	null,
colegiados	char(1)	DEFAULT  'S' null	null,
constraint id_documento PRIMARY KEY  NONCLUSTERED ( c_t_documentos)
)
on 'default'
go

SETUSER
go
print    't_domicilios'
SETUSER 'dbo'
go
create table dbo.t_domicilios (
cod_domicilio	char(2)	not null,
descripcion	char(60)	not null,
constraint id_domicilio PRIMARY KEY  NONCLUSTERED ( cod_domicilio)
)
on 'default'
go

SETUSER
go
print    't_fases'
SETUSER 'dbo'
go
create table dbo.t_fases (
c_t_fase	char(3)	not null,
d_t_descripcion	char(60)	not null,
explicacion	char(255)	null,
grupo	char(1)	null,
susceptible_ctrl_calidad	char(1)	null,
constraint c_t_fase PRIMARY KEY  NONCLUSTERED ( c_t_fase)
)
on 'default'
go

SETUSER
go
print    't_fases_finales'
SETUSER 'dbo'
go
create table dbo.t_fases_finales (
codigo	char(1)	not null,
descripcion	varchar(60)	null,
constraint pk_codigo PRIMARY KEY  CLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go

print    't_gestion'
SETUSER 'dbo'
go
create table dbo.t_gestion (
cod_gestion	char(2)	not null,
descripcion	char(60)	not null,
constraint cod_gestion PRIMARY KEY  NONCLUSTERED ( cod_gestion)
)
on 'default'
go

SETUSER
go
print    't_grupo'
SETUSER 'dbo'
go
create table dbo.t_grupo (
cod_grupo	char(10)	not null,
nombre	varchar(150)	not null,
constraint pk_t_grupo PRIMARY KEY  NONCLUSTERED ( cod_grupo)
)
on 'default'
go

SETUSER
go
print    't_grupo_permisos'
SETUSER 'dbo'
go
create table dbo.t_grupo_permisos (
cod_grupo	char(10)	not null,
cod_aplicacion	char(10)	not null,
permiso	char(1)	null,
constraint pk_grupo_permisos PRIMARY KEY  NONCLUSTERED ( cod_grupo,cod_aplicacion)
)
on 'default'
go

SETUSER
go
print    't_impresoras'
SETUSER 'dbo'
go
create table dbo.t_impresoras (
codigo	char(2)	not null,
cod_delegacion	char(2)	not null,
impresora	char(255)	null,
bandeja	char(2)	null,
constraint pk_impresora PRIMARY KEY  CLUSTERED ( codigo,cod_delegacion)
)
on 'default'
go

SETUSER
go
print    't_incompatibilidad'
SETUSER 'dbo'
go
create table dbo.t_incompatibilidad (
cod_incompatibilidad	char(2)	not null,
descripcion	char(60)	not null,
registro	char(1)	null,
visado	char(1)	null,
salida	char(1)	null,
paraliza	char(1)	null,
constraint t_incompatibilidad_x PRIMARY KEY  NONCLUSTERED ( cod_incompatibilidad)
)
on 'default'
go

SETUSER
go
print    't_informes'
SETUSER 'dbo'
go
create table dbo.t_informes (
c_informe	char(2)	not null,
d_informe	char(255)	not null,
cuantia	float	null,
constraint t_informes PRIMARY KEY  NONCLUSTERED ( c_informe )
)
on 'default'
go

SETUSER
go
alter table t_grupo_permisos 
add constraint fk_t_grupo__reference_t_aplica foreign key (cod_aplicacion) references t_aplicacion(cod_aplicacion)
alter table t_grupo_permisos 
add constraint fk_t_grupo__reference_t_grupo foreign key (cod_grupo) references t_grupo(cod_grupo)
go

print    't_mensaje'
SETUSER 'dbo'
go
create table dbo.t_mensaje (
id_mensaje	char(10)	not null,
destino	char(10)	null,
mensaje	text	null,
codigo_origen	char(10)	null,
s_o_c	char(1)	null,
fecha	datetime	null,
asunto	char(60)	null,
leido	char(1)	null,
f_lectura	datetime	null,
borrado_orig	char(1)	null,
borrado_dst	char(1)	null,
constraint t_mensaje_x PRIMARY KEY  NONCLUSTERED ( id_mensaje)
)
on 'default'
go

SETUSER
go
print    't_orientaciones_profesionales'
SETUSER 'dbo'
go
create table dbo.t_orientaciones_profesionales (
cod_orientacion_profesional	char(2)	not null,
descripcion	char(60)	not null,
constraint id_orientacion_profesional PRIMARY KEY  NONCLUSTERED ( cod_orientacion_profesional)
)
on 'default'
go

SETUSER
go
print    't_permisos'
SETUSER 'dbo'
go
create table dbo.t_permisos (
cod_usuario	char(10)	not null,
cod_aplicacion	char(10)	not null,
permiso	char(1)	not null,
constraint t_permisos_x PRIMARY KEY  NONCLUSTERED ( cod_usuario,cod_aplicacion)
)
on 'default'
go

SETUSER
go
print    't_preguntas'
SETUSER 'dbo'
go
create table dbo.t_preguntas (
cod_pregunta	char(2)	not null,
pregunta	char(100)	null,
constraint pk_t_preguntas PRIMARY KEY  NONCLUSTERED ( cod_pregunta)
)
on 'default'
go

SETUSER
go
print    't_promotor'
SETUSER 'dbo'
go
create table dbo.t_promotor (
t_promotor	char(2)	not null,
descripcion	char(100)	null,
grupo	char(2)	null,
constraint t_promotor_x PRIMARY KEY  NONCLUSTERED ( t_promotor)
)
on 'default'
go

SETUSER
go
print    't_promotor_grupos'
SETUSER 'dbo'
go
create table dbo.t_promotor_grupos (
codigo	char(2)	not null,
descripcion	char(100)	null,
constraint codigo PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go

print    't_reparos_fases'
SETUSER 'dbo'
go
create table dbo.t_reparos_fases (
codigo	char(10)	not null,
descripcion	char(255)	not null,
observaciones	text	null,
impreso	char(15)	null,
tipo	char(10)	not null,
nivel_sup	char(10)	null,
orden	float	null,
constraint pk_codigo PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go
print   'i_nivel_sup'
create nonclustered index i_nivel_sup
on dbo.t_reparos_fases (nivel_sup)
on 'default'
go

SETUSER
go
print    't_sello'
SETUSER 'dbo'
go
create table dbo.t_sello (
codigo	char(10)	not null,
descripcion	char(60)	not null,
fichero	char(150)	null,
constraint cod_sello PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    't_sello_posiciones'
SETUSER 'dbo'
go
create table dbo.t_sello_posiciones (
id_posicion	char(10)	not null,
sello	char(10)	null,
nombre	char(50)	null,
posicion	char(2)	null,
x	float	null,
y	float	null,
margen_vertical	float	null,
margen_horizontal	float	null,
defecto	char(1)	null,
constraint pk_t_sello_posiciones PRIMARY KEY  CLUSTERED ( id_posicion)
)
on 'default'
go

SETUSER
go
print    't_sello_textos'
SETUSER 'dbo'
go
create table dbo.t_sello_textos (
id_texto	char(10)	not null,
nombre	char(50)	not null,
texto	char(255)	null,
color	char(50)	null,
activo	char(1)	null,
orden	char(3)	null,
codigo	char(10)	null,
sello	char(10)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( id_texto)
)
on 'default'
go

SETUSER
go

print    't_situaciones_profesionales'
SETUSER 'dbo'
go
create table dbo.t_situaciones_profesionales (
cod_situacion_profesional	char(2)	not null,
descripcion	char(60)	not null,
constraint id_situacion PRIMARY KEY  NONCLUSTERED ( cod_situacion_profesional)
)
on 'default'
go

SETUSER
go
print    't_tercero'
SETUSER 'dbo'
go
create table dbo.t_tercero (
codigo	char(2)	not null,
descripcion	char(60)	null,
constraint tperso_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    't_transporte_comunicados'
SETUSER 'dbo'
go
create table dbo.t_transporte_comunicados (
cod_transporte_comunicados	char(2)	not null,
descripcion	char(60)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( cod_transporte_comunicados)
)
on 'default'
go

SETUSER
go
print    't_traspaso_iva'
SETUSER 'dbo'
go
create table dbo.t_traspaso_iva (
codigo	char(2)	not null,
descripcion	text	null,
constraint t_traspaso_iva_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    't_usos'
SETUSER 'dbo'
go
create table dbo.t_usos (
cod_uso	char(2)	not null,
descripcion	char(200)	null,
familia	char(100)	null,
coef	float	null,
constraint pk_t_usos PRIMARY KEY  NONCLUSTERED ( cod_uso)
)
on 'default'
go

SETUSER
go

print    't_usuario'
SETUSER 'dbo'
go
create table dbo.t_usuario (
cod_usuario	char(10)	not null,
nombre_usuario	char(92)	null,
password	char(10)	not null,
login	char(20)	not null,
departamento	char(2)	null,
id_col	char(10)	null,
webmaster	char(1)	null,
email	char(100)	null,
fecha_caducidad	datetime	null,
n_fallos	int	null,
cod_tipo_idioma	varchar(2)	null,
constraint t_usuario_x PRIMARY KEY  NONCLUSTERED ( cod_usuario)
)
on 'default'
go

SETUSER
go
print    't_usuario_grupos'
SETUSER 'dbo'
go
create table dbo.t_usuario_grupos (
cod_usuario	char(10)	not null,
cod_grupo	char(10)	not null,
constraint pk_grupos PRIMARY KEY  NONCLUSTERED ( cod_usuario,cod_grupo)
)
on 'default'
go

SETUSER
go
print    'tasas_murcia'
SETUSER 'dbo'
go
create table dbo.tasas_murcia (
tipoact	char(2)	not null,
tipoobra	char(2)	not null,
importe	float	not null,
constraint tasas_murcia_x PRIMARY KEY  NONCLUSTERED ( tipoact,tipoobra)
)
on 'default'
go

SETUSER
go
print    'tipo_act_familia'
SETUSER 'dbo'
go
create table dbo.tipo_act_familia (
codigo	char(2)	not null,
descripcion	char(100)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'tipo_cargo'
SETUSER 'dbo'
go
create table dbo.tipo_cargo (
codigo	char(2)	not null,
descripcion	char(100)	null,
activo	char(1)	null,
constraint pk_codigo PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
alter table t_usuario_grupos 
add constraint fk_t_usuari_reference_t_usuari foreign key (cod_usuario) references t_usuario(cod_usuario)
alter table t_usuario_grupos 
add constraint fk_t_usuari_reference_t_grupo foreign key (cod_grupo) references t_grupo(cod_grupo)
go

print    'tipo_fases'
SETUSER 'dbo'
go
create table dbo.tipo_fases (
codigo	char(2)	not null,
descripcion	text	null,
constraint tipo_fases PRIMARY KEY  NONCLUSTERED ( codigo )
)
on 'default'
go

SETUSER
go
print    'tipo_inhabilitacion'
SETUSER 'dbo'
go
create table dbo.tipo_inhabilitacion (
codigo	char(2)	not null,
descripcion	char(150)	null,
constraint pk_tipo_inhabilitacion PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'tipo_registro'
SETUSER 'dbo'
go
create table dbo.tipo_registro (
codigo	char(3)	not null,
descripcion	char(60)	null,
constraint tipo_registro_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'tipos_facturas'
SETUSER 'dbo'
go
create table dbo.tipos_facturas (
codigo	char(2)	not null,
descripcion	char(60)	null,
plantilla	char(60)	null,
plantilla_adicional	char(60)	null,
tipo	char(1)	null,
dataobject	char(255)	null,
impresora	char(2)	null,
constraint pk_tipos_facturas PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'tipos_honorarios'
SETUSER 'dbo'
go
create table dbo.tipos_honorarios (
codigo	char(3)	not null,
descripcion	char(50)	null,
constraint pk PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go

print    'tipos_trabajos'
SETUSER 'dbo'
go
create table dbo.tipos_trabajos (
c_t_trabajo	char(3)	not null,
d_t_trabajo	char(60)	null,
constraint tipo_trabajos_x PRIMARY KEY  NONCLUSTERED ( c_t_trabajo)
)
on 'default'
go

SETUSER
go
print    'tipos_via'
SETUSER 'dbo'
go
create table dbo.tipos_via (
cod_tipo_via	char(2)	not null,
descripcion	char(60)	null,
constraint tipos_via_x PRIMARY KEY  NONCLUSTERED ( cod_tipo_via)
)
on 'default'
go

SETUSER
go
print    'titulaciones'
SETUSER 'dbo'
go
create table dbo.titulaciones (
codigo	varchar(2)	not null,
descripcion	varchar(100)	not null,
constraint titulaciones_x PRIMARY KEY  NONCLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go
print    'tmp_csd_fr_linea'
SETUSER 'dbo'
go
create table dbo.tmp_csd_fr_linea (
id_linea	varchar(10)	not null,
total	float	null,
constraint pk_tmp_csd_fr_linea PRIMARY KEY  CLUSTERED ( id_linea)
)
on 'default'
go

SETUSER
go
print    'tmp_sgc_140'
SETUSER 'dbo'
go
create table dbo.tmp_sgc_140 (
codigo	varchar(5)	not null,
nombre	varchar(150)	null,
nif	varchar(15)	null,
direccion	varchar(60)	null,
poblacion	varchar(30)	null,
codigo_postal	varchar(5)	null,
provincia	varchar(2)	null,
telefono	varchar(20)	null,
fax	varchar(20)	null,
inscripcion	varchar(100)	null,
cuenta_bancaria	varchar(20)	null,
numeracion	float	null,
facturacion	varchar(1)	null,
nombre_corto	varchar(30)	null,
prefijo_factura	varchar(2)	null,
logo	varchar(60)	null,
centro	varchar(3)	null,
proyecto	varchar(5)	null,
es_colegio	varchar(1)	null,
etiqueta_superior_listados	varchar(15)	null,
pendiente_devengar_fe	varchar(1)	null,
pendiente_devengar_fr	varchar(1)	null,
coste	varchar(1)	null,
direccion_corta	varchar(36)	null,
imagen_fondo	varchar(100)	null,
constraint tmp_empresas_x PRIMARY KEY  CLUSTERED ( codigo)
)
on 'default'
go

SETUSER
go

print    'trabajos'
SETUSER 'dbo'
go
create table dbo.trabajos (
c_trabajo	char(3)	not null,
d_trabajo	char(60)	null,
constraint trabajos_x PRIMARY KEY  NONCLUSTERED ( c_trabajo)
)
on 'default'
go

SETUSER
go
print    'tratamientos'
SETUSER 'dbo'
go
create table dbo.tratamientos (
descripcion	char(60)	not null,
constraint descripcion PRIMARY KEY  NONCLUSTERED ( descripcion)
)
on 'default'
go

SETUSER
go
print    'var_globales'
SETUSER 'dbo'
go
create table dbo.var_globales (
nombre	char(50)	not null,
numero	float	null,
sn	char(1)	null,
texto	char(255)	null,
fecha	datetime	null,
descripcion	text	null,
ambito	char(255)	null,
modificable	char(1)	null,
constraint var_globales_x PRIMARY KEY  NONCLUSTERED ( nombre)
)
on 'default'
go

SETUSER
go

print    'libros'
SETUSER 'dbo'
go
create table dbo.libros (
id_libro	char(10)	not null,
n_registro	char(20)	null,
f_entrada	datetime	null,
titulo	char(255)	null,
autor	char(255)	null,
CDU	char(50)	null,
materias	char(255)	null,
ISBN	char(60)	null,
edicion	char(100)	null,
anyo_publicacion	int	null,
editorial	char(100)	null,
resumen	text	null,
prestado	char(1)	null,
coleccion	char(255)	null,
tipo_libro	text	null,
prestable	char(1)	null,
numero	char(20)	null,
ubicacion	char(1)	null,
precio	float	null,
tipo	char(3)	null,
precio_no_colegiado	float	null,
periodicidad	char(100)	null,
imagen	char(100)	null,
url	char(255)	null,
texto_url	char(100)	null,
ruta_imagen	char(100)	null,
constraint libros_x PRIMARY KEY  NONCLUSTERED ( id_libro)
)
on 'default'
go

SETUSER
go
