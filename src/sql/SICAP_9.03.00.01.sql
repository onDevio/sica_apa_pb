
IF NOT EXISTS (SELECT * FROM t_control_eventos WHERE control= 'VISIBLE_OBJETO' and evento= 'ABRIR_FASE' and param1='r_catastral')
	BEGIN
		insert t_control_eventos (control,evento,activo, param1, param2, id_control) values('VISIBLE_OBJETO','ABRIR_FASE','S', 'r_catastral', '1','TGNCATAS1')
	END
ELSE
	BEGIN
		IF NOT EXISTS (SELECT * FROM t_control_eventos WHERE control= 'VISIBLE_OBJETO' and evento= 'ABRIR_FASE' and param1='r_catastral' and activo = 'S')
			BEGIN
				update t_control_eventos set activo = 'S' where control= 'VISIBLE_OBJETO' and evento= 'ABRIR_FASE' and param1='r_catastral'
			END
	END
--
--
IF NOT EXISTS (SELECT * FROM t_control_eventos WHERE control= 'VISIBLE_OBJETO' and evento= 'ABRIR_FASE' and param1='r_catastral_t')
	BEGIN
		insert t_control_eventos (control,evento,activo, param1, param2, id_control) values('VISIBLE_OBJETO','ABRIR_FASE','S', 'r_catastral_t', '1','TGNCATAS2')
	END
ELSE
	BEGIN
		IF NOT EXISTS (SELECT * FROM t_control_eventos WHERE control= 'VISIBLE_OBJETO' and evento= 'ABRIR_FASE' and param1='r_catastral_t' and activo = 'S')
			BEGIN
				update t_control_eventos set activo = 'S' where control= 'VISIBLE_OBJETO' and evento= 'ABRIR_FASE' and param1='r_catastral_t'
			END
	END
--
--
IF EXISTS (SELECT * FROM t_control_eventos WHERE control= 'POSICION' and evento= 'ABRIR_FASE' and param1='num_coac_t' and param2='3540')
	BEGIN
		update t_control_eventos set param2 = '3553', param3='328' WHERE control= 'POSICION' and evento= 'ABRIR_FASE' and param1='num_coac_t' and param2='3540'
	END
--
--
IF EXISTS (SELECT * FROM t_control_eventos WHERE control= 'POSICION' and evento= 'ABRIR_FASE' and param1='num_coac' and param2='3867')
	BEGIN
		update t_control_eventos set param2 = '3840', param3='328' WHERE control= 'POSICION' and evento= 'ABRIR_FASE' and param1='num_coac' and param2='3867'
	END
--
--
IF EXISTS (SELECT * FROM t_control_eventos WHERE control= 'POSICION' and evento= 'ABRIR_FASE' and param1='f_vis_coac_t' and param2='3540')
	BEGIN
		update t_control_eventos set param2 = '3553', param3='404' WHERE control= 'POSICION' and evento= 'ABRIR_FASE' and param1='f_vis_coac_t' and param2='3540'
	END
--
--
IF EXISTS (SELECT * FROM t_control_eventos WHERE control= 'POSICION' and evento= 'ABRIR_FASE' and param1='f_visado_coac' and param2='3867')
	BEGIN
		update t_control_eventos set param2 = '3840', param3='404' WHERE control= 'POSICION' and evento= 'ABRIR_FASE' and param1='f_visado_coac' and param2='3867'
	END
--
go