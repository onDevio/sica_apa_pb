-- SCP-2465 
--
-- Alta Tabla csi_traspasos_basicos, los que aún no lo tienen
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO' 
if @colegio = 'COAATAVI' OR @colegio ='COAATGUI' OR @colegio = 'COAATLE' OR @colegio = 'COAATMU' OR @colegio = 'COAATZ'  
begin
	create table csi_traspasos_basicos (id_traspaso char(10) not null, tipo char(2) null, fecha datetime null, numero char(10) null, id_colegiado char(10) null, forma_pago char(2) null, banco char(10) null, importe double precision null, n_talon char(10) null, descripcion char(255) null, centro char(3) null, usuario char(10) null, eliminar char(1) null, empresa char(5) null)
	alter table csi_traspasos_basicos add constraint csi_traspasos_basicos_x primary key nonclustered (id_traspaso) 
end
;
-- Alta Campos Adicionales
alter table fases_liquidaciones add iban varchar(34) null;
alter table fases_liquidaciones add bic varchar(11) null;
alter table premaat_liquidaciones add iban varchar(34) null;
alter table premaat_liquidaciones add bic varchar(11) null;
-- SQL sólo aplicable en algunos esquemas de BD
alter table csi_traspasos_basicos add iban varchar(34) null;
alter table csi_traspasos_basicos add bic varchar(11) null;
--
-- CSDBANC-5
Insert into var_globales (nombre, sn, descripcion) values ('SEPA_BIC_obligatorio', 'S', 'Variable para controlar que se valide el BIC en la generación de ficheros bancarios'); 
-- CSDBANC-8
Insert into var_globales (nombre, sn, descripcion) values ('g_sepa_add_new_line_at_the_end', 'S', 'Variable que añade un retorno de carro al final de los ficheros SEPA'); 
-- CSDBANC-9 
Insert into var_globales (nombre, sn, descripcion) values ('g_sepa_aplica_cor1', 'S', 'Variable que indica que se debe aplicar el formato COR1 en los adeudos bancarios'); 