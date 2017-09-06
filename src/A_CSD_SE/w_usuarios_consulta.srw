HA$PBExportHeader$w_usuarios_consulta.srw
forward
global type w_usuarios_consulta from w_consulta
end type
end forward

global type w_usuarios_consulta from w_consulta
integer width = 2162
string title = "Consulta de Usuarios"
end type
global w_usuarios_consulta w_usuarios_consulta

type variables
string i_sql_nuevo
u_dw idw_general
end variables

on w_usuarios_consulta.create
call super::create
end on

on w_usuarios_consulta.destroy
call super::destroy
end on

event open;call super::open;idw_general =dw_1
end event

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_usuarios_consulta
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_usuarios_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_usuarios_consulta
end type

type st_5 from w_consulta`st_5 within w_usuarios_consulta
integer x = 18
end type

type cb_1 from w_consulta`cb_1 within w_usuarios_consulta
integer x = 448
end type

event cb_1::clicked;string ls_grupo

SetPointer(HourGlass!)
dw_1.AcceptText()
i_sql_nuevo = g_dw_lista.describe("datawindow.table.select")

ls_grupo = dw_1.getitemstring(dw_1.getrow(),"cod_grupo")

//Modificamos la sql

f_sql('t_usuario.cod_usuario','LIKE','cod_usuario',idw_general,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('nombre_usuario','LIKE','nombre_usuario',idw_general,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('login','LIKE','login',idw_general,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('n_colegiado','LIKE','n_colegiado',idw_general,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('cod_tipo_idioma','LIKE','cod_tipo_idioma',idw_general,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('t_usuario_grupos.cod_grupo','LIKE','cod_grupo',idw_general,i_sql_nuevo,g_tipo_base_datos,'')

//if not f_es_vacio(dw_1.getitemstring(1, 'cod_grupo')) then
//	if PosA(upper(i_sql_nuevo), "WHERE") > 0  then
//		i_sql_nuevo = i_sql_nuevo + " and ( t_usuario_grupos.cod_grupo = '"+ls_grupo+"')"
//	else
//		i_sql_nuevo = i_sql_nuevo + " WHERE t_usuario_grupos.cod_grupo = '"+ls_grupo+"'"
//	end if
//end if


//Si hay un valor en n_colegiado hay que alterar al join (y poner uno normal)
if not f_es_vacio(idw_general.getitemstring(1,'n_colegiado')) then
	// S$$HEX1$$f300$$ENDHEX$$lo hay que modificar el join de colegiados, el de departamentos no
  i_sql_nuevo=f_reemplaza_cadena(i_sql_nuevo,'*= colegiados','= colegiados')
end if

//Si hay un valor en grupo hay que alterar al join (y poner uno normal)
if not f_es_vacio(dw_1.getitemstring(1,'cod_grupo')) then
	// S$$HEX1$$f300$$ENDHEX$$lo hay que modificar el join de colegiados, el de departamentos no
  i_sql_nuevo=f_reemplaza_cadena(i_sql_nuevo,'*= t_usuario_grupos','= t_usuario_grupos')
end if

g_dw_lista.modify("datawindow.table.select= ~"" + i_sql_nuevo + "~"")


Parent.event pfc_close()
end event

type cb_2 from w_consulta`cb_2 within w_usuarios_consulta
integer x = 1070
end type

type cb_ayuda from w_consulta`cb_ayuda within w_usuarios_consulta
end type

type dw_1 from w_consulta`dw_1 within w_usuarios_consulta
integer x = 37
integer width = 2066
string dataobject = "d_usuarios_consulta"
end type

