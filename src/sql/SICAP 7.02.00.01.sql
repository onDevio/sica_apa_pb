//SCP-2402

alter table csi_bancos add cuenta_bancaria_iban varchar(34) null;
alter table csi_bancos add bic varchar(11) null; 