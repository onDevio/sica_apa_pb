//SCP-2426
alter table devoluciones_motivos add codigo_sepa varchar(11) null;
//
//SCP-2429
alter table csi_empresas add iban varchar (34) null;
alter table csi_empresas add bic varchar (11) null; 