declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

if @colegio= 'COAATTEB'
begin
	//SÓLO TERRES
	//SCP-1735
	update clientes set empresa = '01' where empresa is null or empresa = ''
end

if @colegio= 'COAATGUI'
begin
	//SOLO GUIPUZCUA
	insert csi_param_facturas(serie,empresa, anyo, idioma, campo, texto ) values('%', '01', '%', '%', 'pie_pag_1', 'Paseo Arbol de Gernika, 21 accesorio - 20006 DONOSTIA-SAN SEBASTIAN, Tel:943471616-943461431 Fax:943455776')
	insert csi_param_facturas(serie,empresa, anyo, idioma, campo, texto ) values('%', '01', '%', '%', 'pie_pag_2', 'CIF: Q2075002B')
	insert csi_param_facturas(serie,empresa, anyo, idioma, campo, texto ) values('%', '01', '%', '%', 'pie_pag_3', 'email: colegio@coaatg.org internet: http://www.coaatg.org')

	insert csi_param_facturas(serie,empresa, anyo, idioma, campo, texto ) values('%', '02', '%', '%', 'pie_pag_1', 'Paseo Arbol de Gernika, 21 accesorio - 20006 DONOSTIA-SAN SEBASTIAN, Tel:943471616-943461431 Fax:943455776')
	insert csi_param_facturas(serie,empresa, anyo, idioma, campo, texto ) values('%', '02', '%', '%', 'pie_pag_2', 'CIF:  B75031898')
	insert csi_param_facturas(serie,empresa, anyo, idioma, campo, texto ) values('%', '02', '%', '%', 'pie_pag_3', 'email: acatie@coaatg.org')
end

//TODOS. SCP-879
insert into var_globales(nombre, texto, descripcion) values ('g_tipo_tramite_novacio','N','Elegir asignar un valor por defecto al tipo de tramite')
if @colegio= 'COAATBU'
begin
	//SOLO BURGOS O TODO COLEGIO QUE LO SOLICITE VER INCIDENCIA SCP-879
	update var_globales set texto = 'S' where nombre = 'g_tipo_tramite_novacio'
end 

//SCP-1691 PARA TODOS 27/09/2011
Insert into var_globales (nombre, sn, descripcion) VALUES ('g_asignar_n_visado','S','Activa el check del asignar nº visado del la ventana de Visto Bueno')
if @colegio= 'COAATTFE'
begin
	//PARA TENERIFE 27/09/2011
	UPDATE var_globales SET sn = 'N' WHERE nombre = 'g_asignar_n_visado'
end 

if @colegio= 'COAATLR'
begin
	//RIOJA SOLO: SCP-1637
	update var_globales set texto='d_cobros_reclam_facturas_devolucion_lr' where nombre='g_devoluciones_carta_reclamacion'
end

//Se actualiza la fecha de versión
update var_globales set texto='20111024', descripcion = 'versión v5.3.05' where nombre='g_version_minima'
;