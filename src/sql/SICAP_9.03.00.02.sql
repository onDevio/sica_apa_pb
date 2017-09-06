
if EXISTS (SELECT * FROM sysobjects where sysobjects.type = 'U' AND sysobjects.name = 'messages_ca' )

	BEGIN
		insert messages_ca (tag, traduccion, modulo, nombre) values('fases.escalera','escala','fases', 'escalera')
	END
--
go