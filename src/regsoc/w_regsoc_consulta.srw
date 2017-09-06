HA$PBExportHeader$w_regsoc_consulta.srw
forward
global type w_regsoc_consulta from w_consulta
end type
end forward

global type w_regsoc_consulta from w_consulta
integer width = 2848
integer height = 1936
string title = "Consulta Registro Sociedades"
end type
global w_regsoc_consulta w_regsoc_consulta

on w_regsoc_consulta.create
call super::create
end on

on w_regsoc_consulta.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_regsoc_consulta
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_regsoc_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_regsoc_consulta
end type

type st_5 from w_consulta`st_5 within w_regsoc_consulta
end type

type cb_1 from w_consulta`cb_1 within w_regsoc_consulta
integer y = 1716
integer weight = 700
fontcharset fontcharset = ansi!
end type

event cb_1::clicked;call super::clicked;string sql_nuevo

sql_nuevo = g_dw_lista.describe("datawindow.table.select")
string apellidos,nombre,cif,colegio,n_colegiado,razon,cif_sociedad
cif_sociedad=dw_1.getitemstring(1,'cif')
razon=dw_1.getitemstring(1,'razon')
apellidos=dw_1.getitemstring(1,'apellidos')
nombre=dw_1.getitemstring(1,'nombre')
cif=dw_1.getitemstring(1,'cif_socio')
colegio=dw_1.getitemstring(1,'colegio')
n_colegiado=dw_1.getitemstring(1,'num_colegiado')
// RYC 2008
// REALIZAMOS LAS CONSULTAS
f_sql('multidisciplinar','LIKE','multidisciplinar',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('acreditado','LIKE','acreditado',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('num_reg_colegio','LIKE','n_reg_colegio',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('num_reg_mercantil','LIKE','n_reg_mercantil',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('cod_forma_juridica','LIKE','cod_forma_juridica',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('cod_reg_mercantil','LIKE','cod_reg_mercantil',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
if g_modo_funcionamiento<>'1' then    ////////NO ENLAZADO
	f_sql('cif','LIKE','cif',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
	f_sql('razon_social','LIKE','razon',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
else
	if not f_es_vacio(cif_sociedad) then		
				if PosA(sql_nuevo,'WHERE')<=0 then
					sql_nuevo=sql_nuevo + " WHERE regsoc.id_colegiado_sociedad IN ( select id_colegiado from colegiados where  nif like '%" + cif_sociedad + "%') "
				else
				  sql_nuevo=sql_nuevo + " AND regsoc.id_colegiado_sociedad IN ( select id_colegiado from colegiados where  nif like '%" + cif_sociedad + "%')"
		      end if	
			end if
			if not f_es_vacio(razon) then
				//messagebox('fdsfs',sql_nuevo)
				if PosA(sql_nuevo,'WHERE')<=0 then
					sql_nuevo=sql_nuevo + " WHERE regsoc.id_colegiado_sociedad IN ( select id_colegiado from colegiados where  apellidos like '%" + razon + "%') "
				else
				  sql_nuevo=sql_nuevo + " AND regsoc.id_colegiado_sociedad IN ( select id_colegiado from colegiados where  apellidos like '%" + razon + "%')"
		      end if	
			end if
end if
// RYC 2008
// REALIZAMOS LAS CONSULTAS (FECHAS)
f_sql('fecha_salida_registro','>=','f_desde_com_d_reg',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha_salida_registro','<','f_hasta_com_d_reg',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha_baja','>=','f_desde_com_reg',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha_baja','<','f_hasta_com_reg',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha_llegada_colegio','>=','f_desde_rec_col',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha_llegada_colegio','<','f_hasta_rec_col',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha_junta','>=','f_desde_junta',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha_junta','<','f_hasta_junta',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha_inscripcion','>=','f_desde_ins_reg',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha_inscripcion','<','f_hasta_ins_reg',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
//messagebox('sql',sql_nuevo)
// Socios

if g_modo_funcionamiento<>'1' then    ////////NO ENLAZADO
			if not f_es_vacio(apellidos) then
				//messagebox('fdsfs',sql_nuevo)
				if PosA(sql_nuevo,'WHERE')<=0 then
					sql_nuevo=sql_nuevo + " WHERE regsoc.id_regsoc IN ( select id_regsoc from regsoc_socio where apellidos like '%" + apellidos + "%')"
				else
				  sql_nuevo=sql_nuevo + " AND regsoc.id_regsoc IN ( select id_regsoc from regsoc_socio where apellidos like '%" + apellidos + "%')"
			 end if
			end if
			if not f_es_vacio(nombre) then
				//messagebox('fdsfs',sql_nuevo)
				if PosA(sql_nuevo,'WHERE')<=0 then
					sql_nuevo=sql_nuevo + " WHERE regsoc.id_regsoc IN ( select id_regsoc from regsoc_socio where nombre like '%" + nombre + "%')"
				else
				  sql_nuevo=sql_nuevo + " AND regsoc.id_regsoc IN ( select id_regsoc from regsoc_socio where nombre like '%" + nombre + "%')"
			 end if
			end if
			if not f_es_vacio(cif) then
				//messagebox('fdsfs',sql_nuevo)
				if PosA(sql_nuevo,'WHERE')<=0 then
					sql_nuevo=sql_nuevo + " WHERE regsoc.id_regsoc IN ( select id_regsoc from regsoc_socio where cif like '" + cif + "%')"
				else
				  sql_nuevo=sql_nuevo + " AND regsoc.id_regsoc IN ( select id_regsoc from regsoc_socio where cif like '" + cif + "%')"
			 end if
			end if
			if not f_es_vacio(colegio) then
				//messagebox('fdsfs',sql_nuevo)
				if PosA(sql_nuevo,'WHERE')<=0 then
					sql_nuevo=sql_nuevo + " WHERE regsoc.id_regsoc IN ( select id_regsoc from regsoc_socio where colegio_procedencia like '%" + colegio + "%')"
				else
				  sql_nuevo=sql_nuevo + " AND regsoc.id_regsoc IN ( select id_regsoc from regsoc_socio where colegio_procedencia like '%" + colegio + "%')"
			 end if
			end if
			if not f_es_vacio(n_colegiado) then
				//messagebox('fdsfs',sql_nuevo)
				if PosA(sql_nuevo,'WHERE')<=0 then
					sql_nuevo=sql_nuevo + " WHERE regsoc.id_regsoc IN ( select id_regsoc from regsoc_socio where num_colegiado like '" + n_colegiado + "%')"
				else
				  sql_nuevo=sql_nuevo + " AND regsoc.id_regsoc IN ( select id_regsoc from regsoc_socio where num_colegiado like '" + n_colegiado + "%')"
			 end if
			end if
else                             //////// ENLAZADO
			if not f_es_vacio(apellidos) then
				
				if PosA(sql_nuevo,'WHERE')<=0 then
					sql_nuevo=sql_nuevo + " WHERE regsoc.id_colegiado_sociedad IN ( select id_colegiado_sociedad from regsoc_socio where id_colegiado in (select id_colegiado from colegiados where apellidos like '%" + apellidos + "%')) or (id_colegiado_sociedad in ( select id_colegiado_sociedad from regsoc_socio where id_cliente in (select id_cliente from clientes where apellidos like '%" + apellidos + "%')))"
				else
				  sql_nuevo=sql_nuevo + " AND (regsoc.id_colegiado_sociedad IN ( select id_colegiado_sociedad from regsoc_socio where id_colegiado in (select id_colegiado from colegiados where apellidos like '%" + apellidos + "%'))) or (id_colegiado_sociedad in ( select id_colegiado_sociedad from regsoc_socio where id_cliente in (select id_cliente from clientes where apellidos like '%" + apellidos + "%')))"
		      end if	
			end if
			if not f_es_vacio(nombre) then
				//messagebox('fdsfs',sql_nuevo)
				if PosA(sql_nuevo,'WHERE')<=0 then
					sql_nuevo=sql_nuevo + " WHERE regsoc.id_colegiado_sociedad IN ( select id_colegiado_sociedad from regsoc_socio where id_colegiado in (select id_colegiado from colegiados where nombre like '%" + nombre + "%')) or (id_colegiado_sociedad in ( select id_colegiado_sociedad from regsoc_socio where id_cliente in (select id_cliente from clientes where nombre like '%" + nombre + "%')))"
				else
				  sql_nuevo=sql_nuevo + " AND (regsoc.id_colegiado_sociedad IN ( select id_colegiado_sociedad from regsoc_socio where id_colegiado in (select id_colegiado from colegiados where nombre like '%" + nombre + "%'))) or (id_colegiado_sociedad in ( select id_colegiado_sociedad from regsoc_socio where id_cliente in (select id_cliente from clientes where nombre like '%" + nombre + "%')))"
		      end if	
			end if
			if not f_es_vacio(cif) then
				//messagebox('fdsfs',sql_nuevo)
				if PosA(sql_nuevo,'WHERE')<=0 then
					sql_nuevo=sql_nuevo + " WHERE regsoc.id_colegiado_sociedad IN ( select id_colegiado_sociedad from regsoc_socio where id_colegiado in (select id_colegiado from colegiados where nif like '%" + cif + "%')) or (id_colegiado_sociedad in ( select id_colegiado_sociedad from regsoc_socio where id_cliente in (select id_cliente from clientes where nif like '%" + cif + "%')))"
				else
				  sql_nuevo=sql_nuevo + " AND (regsoc.id_colegiado_sociedad IN ( select id_colegiado_sociedad from regsoc_socio where id_colegiado in (select id_colegiado from colegiados where nif like '%" + cif + "%'))) or (id_colegiado_sociedad in ( select id_colegiado_sociedad from regsoc_socio where id_cliente in (select id_cliente from clientes where nif like '%" + cif + "%')))"
		      end if	
			end if
			if not f_es_vacio(colegio) then
				//messagebox('fdsfs',sql_nuevo)
//				if pos(sql_nuevo,'WHERE')<=0 then
//					sql_nuevo=sql_nuevo + " WHERE regsoc.id_regsoc IN ( select id_regsoc from regsoc_socio where colegio_procedencia like '%" + colegio + "%')"
//				else
//				  sql_nuevo=sql_nuevo + " AND regsoc.id_regsoc IN ( select id_regsoc from regsoc_socio where colegio_procedencia like '%" + colegio + "%')"
//				end if
			end if
			if not f_es_vacio(n_colegiado) then
				//messagebox('fdsfs',sql_nuevo)
				if PosA(sql_nuevo,'WHERE')<=0 then
					sql_nuevo=sql_nuevo + " WHERE regsoc.id_colegiado_sociedad IN ( select id_colegiado_sociedad from regsoc_socio where id_colegiado in (select id_colegiado from colegiados where n_colegiado like '%" + n_colegiado + "%')) or (id_colegiado_sociedad in ( select id_colegiado_sociedad from regsoc_socio where id_cliente in (select id_cliente from clientes where n_cliente like '%" + n_colegiado + "%')))"
				else
				  sql_nuevo=sql_nuevo + " AND (regsoc.id_colegiado_sociedad IN ( select id_colegiado_sociedad from regsoc_socio where id_colegiado in (select id_colegiado from colegiados where n_colegiado like '%" + n_colegiado + "%'))) or (id_colegiado_sociedad in ( select id_colegiado_sociedad from regsoc_socio where id_cliente in (select id_cliente from clientes where n_cliente like '%" + n_colegiado + "%')))"
		      end if	
			end if	
	
end if



g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
Parent.event pfc_close()
end event

type cb_2 from w_consulta`cb_2 within w_regsoc_consulta
integer y = 1716
end type

type cb_ayuda from w_consulta`cb_ayuda within w_regsoc_consulta
integer y = 1716
end type

type dw_1 from w_consulta`dw_1 within w_regsoc_consulta
integer width = 2615
integer height = 1576
string dataobject = "d_regsoc_consulta"
boolean ib_isupdateable = false
end type

