-- ONDEVIO-34
--
ALTER TABLE fases_pagos_plataforma add t_iva char(2) null;
ALTER TABLE fases_pagos_plataforma add base_imponible double precision null;
ALTER TABLE fases_pagos_plataforma add importe_iva double precision null;
--
ALTER TABLE csi_t_iva add codigo_tipo_efactura char(2) null;
--
update csi_t_iva set codigo_tipo_efactura = '01' where descripcion like '%IVA%';
update csi_t_iva set codigo_tipo_efactura = '02' where descripcion like '%IPSI%';
update csi_t_iva set codigo_tipo_efactura = '03' where descripcion like '%IGIC%';
update csi_t_iva set codigo_tipo_efactura = '05' where codigo_tipo_efactura is null;
