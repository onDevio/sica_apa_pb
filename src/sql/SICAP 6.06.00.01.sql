declare @serie char(10)
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--SCP-2026
-- Pendiente: Añadir nueva tabla
begin
	if @colegio = 'COAATGU'	
	begin
	        UPDATE csi_series SET dataobject = 'd_premaat_factura_cuotas_generico' WHERE serie = 'MT' AND empresa = '04' AND anyo = 'XX'
		UPDATE csi_series SET dataobject = 'd_premaat_factura_cuotas_generico' WHERE serie = 'MT' AND empresa = '04' AND anyo = '2012' 
		UPDATE csi_series SET dataobject = 'd_premaat_factura_cuotas_generico' WHERE serie = 'MT' AND empresa = '04' AND anyo = '2013'
	////
		select @serie = 'MT%'
	end
//
if @colegio = 'COAATB' or @colegio = 'COAATLL' or @colegio = 'COAATMCA' or @colegio = 'COAATTG' 
	begin
		select @serie = 'MT%'
	end  
//
if @colegio = 'COAATAVI' or @colegio = 'COAATCC' or @colegio = 'COAATLE' or @colegio = 'COAATGUI'
	begin
		select @serie = 'PREMAA%'
	end
//
if @colegio = 'COAATA'
	begin
		select @serie = 'P-%'
	end
//
if @colegio = 'COAATZ' or @colegio = 'COAATTEB'
	begin
		select @serie = 'PREM%'
	end
//
if @colegio = 'COAATMU'
	begin
		select @serie = 'MUTUA%'
	end
//
if @colegio = 'COAATNA'
	begin
		select @serie = 'NAPM%'
	end
//
if @colegio = 'COAATLR'
	begin
		select @serie = 'RIPM%'
	end
//
//
insert into csi_lineas_fact_emi_premaat (id_linea, ips, ccs) select distinct csi_lineas_fact_emitidas.id_linea, conceptos_domiciliables.ips, conceptos_domiciliables.ccs from csi_lineas_fact_emitidas, csi_facturas_emitidas, conceptos_domiciliables where csi_lineas_fact_emitidas.id_factura = csi_facturas_emitidas.id_factura and ( csi_lineas_fact_emitidas.articulo = conceptos_domiciliables.concepto ) and conceptos_domiciliables.empresa = csi_facturas_emitidas.empresa and conceptos_domiciliables.id_colegiado = csi_facturas_emitidas.id_persona and csi_facturas_emitidas.n_fact like @serie and csi_facturas_emitidas.fecha > '20130101'
//	
end 
//
// SCP-2267
if (@colegio = 'COAATTGN' or @colegio = 'COAATMU')
   begin
       INSERT INTO var_globales (nombre, texto, descripcion) VALUES ('g_companyia_src.zurich','01','Código para la compañía de Seguros Zurich')
   end 
else 
   begin 
       if (@colegio = 'COAATTFE' or @colegio = 'COAATA' or @colegio = 'COAATLR')
           begin
               INSERT INTO var_globales (nombre, texto, descripcion) VALUES ('g_companyia_src.zurich','09','Código para la compañía de Seguros Zurich')
           end
       else
           begin 
               if (@colegio = 'COAATMCA')
                  begin
                      INSERT INTO var_globales (nombre, texto, descripcion) VALUES ('g_companyia_src.zurich','07','Código para la compañía de Seguros Zurich')
                  end
               else
                  begin 
                      if (@colegio = 'COAATNA')
                         begin
                             INSERT INTO var_globales (nombre, texto, descripcion) VALUES ('g_companyia_src.zurich','16','Código para la compañía de Seguros Zurich')
                         end
                      else
                         begin
                             INSERT INTO var_globales (nombre, texto, descripcion) VALUES ('g_companyia_src.zurich','ZU','Código para la compañía de Seguros Zurich')
                             if (@colegio <> 'COAATLL' and @colegio <> 'COAATGUI')
                                begin 
                                    insert into musaat_cias_aseguradoras (cod_s, nom_s) values('ZU', 'ZURICH')
                                end 
                         end 
                 end      
          end
   end
//
if (@colegio = 'COAATTGN' or @colegio = 'COAATLL' or @colegio = 'COAATTEB')
   begin
	insert into messages_ca (tag, traduccion, modulo, nombre) values ('colegiados.seguros_rc_musaat','Segur de Responsabilitat Civil (S.R.C.) MUSAAT','colegiados', 'seguros_rc_musaat')
	insert into messages_ca (tag, traduccion, modulo, nombre) values ('colegiados.seguros_rc_otros','Altres Segurs de Responsabilitat Civil (S.R.C.)','colegiados', 'seguros_rc_otros')
	insert into messages_ca (tag, traduccion, modulo, nombre) values ('musaat.n_certificado','Nº Certificat','musaat', 'n_certificado')
	insert into messages_ca (tag, traduccion, modulo, nombre) values ('musaat.tramo','Tram','musaat', 'tramo')
	insert into messages_ca (tag, traduccion, modulo, nombre) values ('musaat.moroso','Morós','musaat', 'moroso')
	insert into messages_ca (tag, traduccion, modulo, nombre) values ('musaat.n_siniestros_anuales',"Nº de Sinistres durant l'any",'musaat', 'n_siniestros_anuales')
   end 
;
update src_colegiado set src_cober= '2500000' where src_cia in (select texto from var_globales where nombre = 'g_companyia_src.zurich');