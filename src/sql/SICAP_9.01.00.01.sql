declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
-- Actualización de las cartas de reclamación de avisos
--
if @colegio='COAATAVI' 
begin 
     insert into var_globales (nombre, texto, modificable) values('g_sepa_ISO20022_habilitado',"N1ARANJ2O", 'N')
end 
--
if @colegio='COAATLR'
begin 
     insert into var_globales (nombre, texto, modificable) values('g_sepa_ISO20022_habilitado',"1NCLUS1T3", 'N')
end
--
if @colegio='COAATMU'
begin 
     insert into var_globales (nombre, texto, modificable) values('g_sepa_ISO20022_habilitado',"PAS5TE", 'N')
end
--
if @colegio='COAATTEB'
begin 
     insert into var_globales (nombre, texto, modificable) values('g_sepa_ISO20022_habilitado',"CONGELA2", 'N')
end
--
if @colegio='COAATTER'
begin 
     insert into var_globales (nombre, texto, modificable) values('g_sepa_ISO20022_habilitado',"SOLEAD2", 'N')
end  
--
if @colegio='COAATTGN'
begin 
     insert into var_globales (nombre, texto, modificable) values('g_sepa_ISO20022_habilitado',"PLAY3R0", 'N')
end 
--
if @colegio='COAATZ'
begin 
     insert into var_globales (nombre, texto, modificable) values('g_sepa_ISO20022_habilitado',"PLAYD0", 'N')
end 
--
if @colegio='COAATLL'
begin 
     insert into var_globales (nombre, texto, modificable) values('g_sepa_ISO20022_habilitado',"AL3ATORIO", 'N')
end 

go
