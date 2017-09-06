--SCP-2274

declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
-- Actualizaci√≥n de las cartas de reclamaci√≥n de avisos
if @colegio= 'COAATLR' 
	begin 
		insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) 
		values('carta', '01', '%', '%', 'info_cc_banco_devol', "Abonar en el n∫ de cuenta del colegio ES19 2038 7498 6968 0000 0724")
		
		insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) 
		values('carta', '02', '%', '%', 'info_cc_banco_devol', "Abonar en el n∫ de cuenta de Narial Segu ES83 2038 7498 6160 0000 6432")
	end 
go


