declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--SCP-2010
if @colegio <> 'COAATLL'
begin
	update var_globales set texto= 'N' where nombre ='g_imprimir_talon_multiples'
end
;