// SCP-2310
insert into var_globales (nombre, texto, descripcion, modificable) values ("g_valor_extension_docs_sellados", "_signed", "sufijo que se añadirá automáticamente a los documentos firmados.", "S");
insert into var_globales (nombre, texto, descripcion, modificable) values ("g_nombre_consulta_datos_sello_imp", "INICIO", "Indica el referente en la tabla de consultas para obtener la firma por defecto en la impresión de facturas", "N");
// SCP-2312
alter table fases_documentos_visared add id_factura varchar(10) null;
// SCP-2366
UPDATE csi_facturas_emitidas SET firmado = 'N' WHERE fecha < '20050101' AND (firmado is null OR firmado = '');
UPDATE csi_facturas_emitidas SET firmado = 'N' WHERE fecha >= '20050101' AND (firmado is null OR firmado = '');
// SCP-2327
create table consultas_datos_aux (id_consulta_datos numeric identity not null, datawindow varchar(100) null, columna double precision null, valor_double double precision null, 
valor_string varchar(100) null, valor_datetime datetime null, fila double precision null, id_consulta varchar(10) null) ;
alter table consultas_datos_aux add constraint pk primary key nonclustered (id_consulta_datos) ;
