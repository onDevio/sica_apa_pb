-- SCP-2335
declare @aux int
select @aux = count(*) from musaat_coef_c where tipoact = '78'
if @aux = 0
begin
	INSERT INTO musaat_coef_c (tipoact,tipoobra,coef,tabla,desde_sup,hasta_sup,f_desde,f_hasta) VALUES ('78','*',0,'F',-1,9999999,'19000101','20500101')
end
select @aux = count(*) from t_fases where c_t_fase = '78'
if @aux = 0
begin
	INSERT INTO t_fases (c_t_fase,d_t_descripcion,grupo) VALUES ('78','CERTIFICADO EFICIENCIA ENERGETICA','4')
end
ALTER TABLE t_fases ADD calculo_pc_si_perito char(1) DEFAULT 'S' null
;

