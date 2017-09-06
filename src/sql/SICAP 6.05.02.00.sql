declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
if @colegio = 'COAATTGN'
	begin
		insert into var_globales (nombre, sn, modificable) values('g_sellador_backup_externo', 'S', 'S')
	end 
else
	begin
		insert into var_globales (nombre, sn, modificable) values('g_sellador_backup_externo', 'N', 'S')
	end
GO