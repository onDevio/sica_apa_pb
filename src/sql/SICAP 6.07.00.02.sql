-- SCP-2335
UPDATE t_fases SET calculo_pc_si_perito = 'S'
UPDATE t_fases SET calculo_pc_si_perito = 'N' WHERE c_t_fase IN ('72','76','77','78')
;