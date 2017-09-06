declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
-- ActualizaciÃ³n de las cartas de reclamaciÃ³n de avisos
--
if @colegio='COAATAVI' 
begin 
    Update contadores set valor = 0 where contador = 'N_AVISO'
end 
--
if @colegio='COAATLR'
begin 
   Update contadores set valor = 0 where contador = 'N_AVISO'
   Update registro_series set contador = 0  where codigo in ('RE','RS')
end
--
if @colegio='COAATTER'
begin 
   Update contadores set valor = 0 where contador = 'N_REMESA'
end  
--
if @colegio='COAATMU'
begin 
   Update registro_series set contador = 0  where codigo in ('RE','RS')
end
--
if @colegio='COAATLL'
begin 
   Update registro_series set contador = 0  where codigo = 'DISCQ'
end 

go