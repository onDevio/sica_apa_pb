HA$PBExportHeader$w_musaat_consulta_movimientos.srw
forward
global type w_musaat_consulta_movimientos from w_consulta
end type
end forward

global type w_musaat_consulta_movimientos from w_consulta
integer x = 214
integer y = 221
integer width = 1797
integer height = 1872
string title = "Consulta de Movimientos de MUSAAT"
end type
global w_musaat_consulta_movimientos w_musaat_consulta_movimientos

on w_musaat_consulta_movimientos.create
call super::create
end on

on w_musaat_consulta_movimientos.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_musaat_consulta_movimientos
integer x = 1902
integer y = 1204
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_musaat_consulta_movimientos
integer x = 1902
integer y = 1024
end type

type cb_limpiar from w_consulta`cb_limpiar within w_musaat_consulta_movimientos
integer x = 1902
integer y = 808
end type

type st_5 from w_consulta`st_5 within w_musaat_consulta_movimientos
string tag = "texto=musaat.introducir_param_consulta_aceptar"
integer x = 37
end type

type cb_1 from w_consulta`cb_1 within w_musaat_consulta_movimientos
integer x = 329
integer y = 1628
integer height = 88
fontcharset fontcharset = ansi!
end type

event cb_1::clicked;call super::clicked;string sql_nuevo, sql_copia, sql_aux
//Recuperamos le select del datawindow de lista
sql_nuevo = g_dw_lista.describe("datawindow.table.select")
sql_copia = sql_nuevo
f_sql('fases.n_expedi', 'LIKE', 'n_exp', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat_movimientos.n_col', 'LIKE', 'n_col', Parent.dw_1,sql_nuevo, '1', '')
f_sql('fases_minutas.n_aviso', '>=', 'n_aviso', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat_movimientos.fecha_calculo', '>=', 'f_calculo_desde', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat_movimientos.fecha_calculo', '<', 'f_calculo_hasta', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat_movimientos.fecha_notificacion', '>=', 'f_notific_desde', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat_movimientos.fecha_notificacion', '<', 'f_notific_hasta', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat_movimientos.importe_vble', '>=', 'importe_desde', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat_movimientos.importe_vble', '<=', 'importe_hasta', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat_movimientos.t_visado', '=', 't_visado', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat_movimientos.obra_oficial', 'LIKE', 'obra_oficial', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat_movimientos.aplica_10', 'LIKE', 'aplicado_10', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat_movimientos.anulado', 'LIKE', 'anulado', Parent.dw_1,sql_nuevo, '1', '')
f_sql('fases.modalidad', 'LIKE', 'modalidad', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat_movimientos.decenal', 'LIKE', 'decenal', Parent.dw_1,sql_nuevo, '1', '')
f_sql('fases.archivo', 'LIKE', 'n_visado', Parent.dw_1,sql_nuevo, '1', '')

//SCP-891
f_sql('musaat_movimientos.obra_iniciada', 'LIKE', 'obra_iniciada', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat_movimientos.f_renuncia', '>=', 'f_renuncia_desde', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat_movimientos.f_renuncia', '<', 'f_renuncia_hasta', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat_movimientos.f_extorno', '>=', 'f_extorno_desde', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat_movimientos.f_extorno', '<', 'f_extorno_hasta', Parent.dw_1,sql_nuevo, '1', '')
f_sql('fases.n_registro', 'LIKE', 'n_registro', Parent.dw_1,sql_nuevo, '1', '')

////Todos los colegiados que tengan el concepto domiciliable elegido
//if pos(upper(sql_nuevo), "WHERE") > 0 then
//	sql_aux = "and musaat_movimientos.id_fase IN (SELECT id_fase FROM fases WHERE modalidad='"+dw_1.getitemstring(1,'modalidad')+"')"
//else
//	sql_aux = "WHERE musaat_movimientos.id_fase IN (SELECT id_fase FROM fases WHERE modalidad='"+dw_1.getitemstring(1,'modalidad')+"')"
//end if	
//if not isnull(sql_nuevo) then sql_nuevo += sql_aux


//messagebox('kk', sql_nuevo)
if sql_nuevo=sql_copia then 
	MessageBox(g_titulo,g_idioma.of_getmsg('msg_musaat.especificar_param_busqueda','Ha de especificar al menos un par$$HEX1$$e100$$ENDHEX$$metro de b$$HEX1$$fa00$$ENDHEX$$squeda'))
else
	g_dw_lista.modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

	Parent.event pfc_close()
end if
end event

type cb_2 from w_consulta`cb_2 within w_musaat_consulta_movimientos
integer x = 951
integer y = 1628
integer height = 88
end type

type cb_ayuda from w_consulta`cb_ayuda within w_musaat_consulta_movimientos
integer x = 1902
integer y = 952
end type

type dw_1 from w_consulta`dw_1 within w_musaat_consulta_movimientos
integer x = 37
integer y = 96
integer width = 1646
integer height = 1504
string dataobject = "d_musaat_movimientos_consulta"
end type

