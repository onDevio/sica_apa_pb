declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

-- SCP-2335, CAV-467
if @colegio = 'COAATAVI'
begin
	insert INTO tarifas_tipo_act  (id_tarifa, tipo_act,tipo_obra,sup_desde, pem_desde,otro_desde,colegio)
	VALUES ('tipoact78','78','%',-1,-1,-1,'COAATAVI')
	INSERT INTO tarifas_importes (id,id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) 
	select '78'+id_informe,'tipoact78', id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente from tarifas_importes where id_tarifa = '0000001417'
end 
;