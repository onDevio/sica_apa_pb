//Ondevio-60 - caatlleida-6
update colegiados set moroso = 'N';

declare @colegio varchar(10) 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
if @colegio = 'COAATTGN' 
BEGIN
	Update colegiados set moroso = 'S' where id_colegiado in (select id_colegiado from otros_datos_colegiado where cod_caracteristica = 'Z4')
END
--
if @colegio = 'COAATLL' or @colegio = 'COAATTGN' or @colegio = 'COAATTEB'  
BEGIN
	INSERT INTO messages_ca (tag, traduccion, modulo, nombre) VALUES ('colegiados.moroso','Morós','colegiados','moroso')
	INSERT INTO messages_ca (tag, traduccion, modulo, nombre) VALUES ('colegiados.morosidad','Morositat','colegiados','morosidad')
	INSERT INTO messages_ca (tag, traduccion, modulo, nombre) VALUES ('factura_e.colegiado_moroso','El col·legiat seleccionat es morós','factura_e','El colegiado seleccionado es moroso')
	update messages_ca set traduccion = 'Embargament Hisenda' where tag ='colegiados.embargo_hacienda'
END

go


