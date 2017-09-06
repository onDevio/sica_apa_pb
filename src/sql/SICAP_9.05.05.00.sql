-- ONDEVIO-38
--
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
if @colegio <> 'COAATTGN'
	begin
		update csi_formas_de_pago set tipo_pago = 'PV'	where tipo_pago = 'TP' 	
	end
else 
	begin
		insert into csi_formas_de_pago (tipo_pago, descripcion, tipo, cuenta, contado, n_vencimientos, dias_primer_vencimiento, dias_entre_vencimiento, hay_ingreso, efecto, porcent_primero, porcent_resto, descripcion_breve, banco_asociado, fp_extra, declara_metalico_347, t_medio_cobro_pago ) (select 'PV', 'ABONADO POR TPV' , tipo, cuenta, contado, n_vencimientos, dias_primer_vencimiento, dias_entre_vencimiento, hay_ingreso, efecto, porcent_primero, porcent_resto, 'ABONADO TPV', banco_asociado, fp_extra, declara_metalico_347, t_medio_cobro_pago from csi_formas_de_pago where tipo_pago = 'TR')
	end 

-- Unico colegio con posibles registros
if @colegio = 'COAATMU'
	begin 
		update fases_pagos_plataforma set forma_pago_plataforma = 'PV' where forma_pago_plataforma = 'TP'	
		update csi_facturas_emitidas set formadepago = 'PV'	where formadepago= 'TP'
		update csi_cobros set forma_pago = 'PV'	where forma_pago= 'TP'
	end 		
go