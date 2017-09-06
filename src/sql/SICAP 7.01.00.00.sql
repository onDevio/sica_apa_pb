//SCP-2391
CREATE TABLE colegiados_recc (id_recc numeric(10,0) identity NOT NULL, id_colegiado char(10) NOT NULL, aplica_recc char(1) DEFAULT 'N' NULL, f_inicio datetime NULL, f_fin datetime NULL)
ALTER TABLE colegiados_recc add constraint colegiados_recc_pk primary key nonclustered (id_recc)
GO