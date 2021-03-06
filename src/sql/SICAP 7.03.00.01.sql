//SCP-2426
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('A1', 'Número de cuenta incorrecto (IBAN no válido)', 'AC01');
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('A4', 'Cuenta cancelada', 'AC04'); 
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('A6', 'Cuenta bloqueada y/o cuenta bloqueada por el deudor para Adeudos Directos', 'AC06');
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('A3', 'Cuenta no admite Adeudos Directos', 'AG01'); 
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('A2', 'Código de operación incorrecto', 'AG02');
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('A7', 'Saldo insuficiente', 'AM04'); 
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('A5', 'Operación duplicada', 'AM05');
Insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('B1', 'Titular de la cuenta de cargo no coincide con el deudor', 'BE01');
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('B5', 'Identificador del acreedor incorrecto', 'BE05'); 
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('F1', 'Formato no válido', 'FF01');
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('F5', 'Tipo de adeudo incorrecto', 'FF05'); 
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('M1', 'Mandato no válido o inexistente', 'MD01');
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('M2', 'Faltan datos del mandato o son incorrectos', 'MD02'); 
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('M6', 'Operación autorizada no conforme', 'MD06'); 
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('M7', 'Deudor fallecido', 'MD07');
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('M4', 'Razón no especificada por el cliente (orden del deudor)', 'MS02'); 
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('M3', 'Razón no especificada por la entidad del deudor', 'MS03');
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('RC', 'Mandato no válido o inexistente', 'RC01');
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('R1', 'Faltan datos del mandato o son incorrectos', 'RR01'); 
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('R2', 'Operación autorizada no conforme', 'RR02'); 
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('R3', 'Deudor fallecido', 'RR03');
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('R4', 'Razón no especificada por el cliente (orden del deudor)', 'RR04'); 
insert into devoluciones_motivos (codigo, descripcion, codigo_sepa) values('S1', 'Razón no especificada por la entidad del deudor', 'SL01'); 
//
//SCP-2429
update csi_empresas set iban = (select csi_bancos.cuenta_bancaria_iban from csi_bancos where right(ltrim(csi_bancos.cuenta_bancaria_iban), char_length(ltrim(csi_bancos.cuenta_bancaria_iban)) -4 ) = ltrim(csi_empresas.cuenta_bancaria) and csi_bancos.empresa = csi_empresas.codigo);
update csi_empresas set bic = (select csi_bancos.bic from csi_bancos where ltrim(csi_bancos.cuenta_bancaria_iban)=ltrim(csi_empresas.iban) and csi_bancos.empresa = csi_empresas.codigo);
// SCP-2440
Insert into var_globales (nombre, sn, descripcion) values ('g_sepa_habilitado', '', 'Variable que habilita la generación de ficheros SEPA');
