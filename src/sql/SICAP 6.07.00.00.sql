-- SCP-2305
update listados set descripcion = 'Listado del SRC' where dw = 'd_musaat_listado_src'

declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

-- SCP-1963, 2284 Rioja
if @colegio = 'COAATLR'
begin
	INSERT INTO csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) VALUES ('PROFOR','%','%','%','sin_validez_legal','PRESUPUESTO. CARECE DE VALIDEZ LEGAL')
	UPDATE csi_articulos_servicios SET suplido = 'S' WHERE familia = '02'
	UPDATE csi_series SET recib = 'S' WHERE serie = 'RIPC'
	INSERT INTO csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) SELECT serie, empresa, anyo, '%', 'identifica_mediacion','Agente de Seguro por mediación MUSAAT - V28865855' FROM csi_series WHERE recib = 'S' AND ((empresa = '01' AND serie IN ('MU')) OR (empresa = '02' AND serie IN ('RIPC','RIPF')))
	INSERT INTO csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) SELECT serie, empresa, anyo, '%', 'sin_validez_legal','RECIBO' FROM csi_series WHERE recib = 'S'
	INSERT INTO csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) SELECT serie, empresa, anyo, '%', 'identifica_mediacion','Agente de Seguro por mediación' FROM csi_series WHERE recib = 'S' AND serie = 'RECTIR'
	INSERT INTO csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) SELECT serie, empresa, anyo, '%', 'identifica_mediacion','Agente de Seguro por mediación ZURICH - W0072130H' FROM csi_series WHERE recib = 'S' AND serie = 'RIPZ'
	INSERT INTO csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) SELECT serie, empresa, anyo, '%', 'identifica_mediacion','Agente de Seguro por mediación MUSAAT - V28865855' FROM csi_series WHERE recib = 'S' AND ((empresa = '01' AND serie IN ('MU')) OR (empresa = '02' AND serie IN ('RIPC','RIPF')))
	INSERT INTO csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) SELECT serie, empresa, anyo, '%', 'identifica_mediacion','Agente de Seguro por mediación PREMAAT - G28618536' FROM csi_series WHERE recib = 'S' AND ((empresa = '01' AND serie IN ('PREMAA')) OR (empresa = '02' AND serie IN ('RIPM')))
end 
-- SCP-2300 Todos: Diferenciación Receptor Registro E/S
INSERT INTO var_globales (nombre,texto,descripcion) VALUES ('g_reg_es_nombre_defecto','12','2 posics, Pos.1: empresa 01, Pos.2:empresa <> 01: 1 indica valor por defecto en BD, 2 nombre empresa.')
;