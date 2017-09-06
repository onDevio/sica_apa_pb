--SCP-2554
-- Borramos todas las entradas de grupos de premaat
delete equivalencias WHERE grupo = 'VU_TIPO_REGIMEN' and nombre_nuevo = 'PREM'
GO	
-- insertamos las entradas para los diferentes grupos de premaat disponibles.
insert into equivalencias (grupo, nombre_anterior, descripcion, nombre_nuevo) select 'VU_TIPO_REGIMEN', premaat_grupo.codigo, premaat_grupo.descripcion, 'PREM' from premaat_grupo
GO
--
-- SCP-2549
INSERT INTO var_globales (nombre, sn, texto, descripcion) VALUES ('g_musaat_aplica_calculo_pc_2015','S','S','Flag para activar el Criterio de PC de MUSAAT vigente a partir de 2015')
GO
--
-- SCP-2556
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
if @colegio= 'COAATA'
begin
insert into var_globales (nombre,numero,descripcion) values ('g_cip_minimo_direccion_visados', 19.65 ,'Mínimo DIP para direcciones de visados CAL-634')
update var_globales set numero = 13.03, texto = 'Antes 14,48' where nombre = 'g_minimo_cip_REDAP'
update var_globales set numero = 18.61, texto = 'Antes 20,69' where nombre = 'g_cip_minimo'
end 
GO
