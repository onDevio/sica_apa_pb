alter table t_tramite add activo char(1) null;
update t_tramite set activo= 'S';
--
declare @colegio varchar(10) 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
if @colegio = 'COAATZ'
	BEGIN
		update t_tramite set activo= 'N' where id_tramite IN ('REDOC', '0000000000', 'IICD', 'IP','VV')
	END
--
go
