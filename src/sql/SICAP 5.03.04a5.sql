
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

if @colegio = 'COAATGU' 
begin
	//GUADALAJARA
	update csi_empresas set logo= 'facturas_emitidas_segapagu.jpg' where codigo='04' 
	update csi_fact_reclamaciones_tipos set dw='d_reclamaciones_facturas_1a_recla_gu' where dw='d_reclamaciones_facturas_1a_recla' 
	update csi_fact_reclamaciones_tipos set dw='d_reclamaciones_facturas_2a_recla_gu' where dw='d_reclamaciones_facturas_2a_recla' 
	update csi_fact_reclamaciones_tipos set dw='d_reclamaciones_facturas_3a_recla_gu' where dw='d_reclamaciones_facturas_3a_recla' 
	update csi_fact_reclamaciones_tipos set dw='d_reclamaciones_facturas_4a_recla_gu' where dw='d_reclamaciones_facturas_4a_recla' 
end

//Se actualiza la fecha de versión
update var_globales set texto='20110913', descripcion = 'versión v5.3.04a5' where nombre='g_version_minima';
