IF NOT EXISTS (SELECT * FROM trabajos WHERE c_trabajo='91')
	BEGIN
		insert into trabajos (c_trabajo, d_trabajo) values ('91', 'OTROS DESTINOS')
	END
--
--
IF NOT EXISTS (SELECT * FROM tipos_trabajos WHERE c_t_trabajo='99')
	BEGIN
		insert tipos_trabajos (c_t_trabajo,d_t_trabajo) values('99','Varios')
	END
--
go