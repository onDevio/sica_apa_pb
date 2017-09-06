HA$PBExportHeader$w_preferencias_sistema.srw
forward
global type w_preferencias_sistema from w_consulta
end type
end forward

global type w_preferencias_sistema from w_consulta
integer width = 2674
string title = "Configuraci$$HEX1$$f300$$ENDHEX$$n a nivel de sistema"
end type
global w_preferencias_sistema w_preferencias_sistema

on w_preferencias_sistema.create
call super::create
end on

on w_preferencias_sistema.destroy
call super::destroy
end on

event open;call super::open;
f_centrar_ventana(this)

dw_1.SetItem(1,'g_fa', g_fa)

dw_1.SetItem(1,'g_porc_cip_defecto', g_porc_cip_defecto)
dw_1.SetItem(1,'g_porc_cip_admon', g_porc_cip_admon)
dw_1.SetItem(1,'g_porc_cip_sgc',g_porc_cip_sgc)

dw_1.SetItem(1,'g_t_iva_defecto', g_t_iva_defecto)
dw_1.SetItem(1,'g_col_coef_musaat', g_col_coef_musaat)
dw_1.SetItem(1,'g_irpf_por_defecto', g_irpf_por_defecto)

end event

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_preferencias_sistema
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_preferencias_sistema
end type

type cb_limpiar from w_consulta`cb_limpiar within w_preferencias_sistema
end type

type st_5 from w_consulta`st_5 within w_preferencias_sistema
integer width = 1330
string text = "Introduzca las preferencias de funcionamiento de su Sistema:"
end type

type cb_1 from w_consulta`cb_1 within w_preferencias_sistema
integer x = 1467
end type

event cb_1::clicked;call super::clicked;g_fa = dw_1.GetItemNumber(1,'g_fa')
g_porc_cip_defecto = dw_1.GetItemNumber(1,'g_porc_cip_defecto')
g_porc_cip_admon=dw_1.GetItemNumber(1,'g_porc_cip_admon')
g_porc_cip_sgc=dw_1.GetItemNumber(1,'g_porc_cip_sgc')

g_t_iva_defecto=dw_1.getitemstring(1,'g_t_iva_defecto')
g_col_coef_musaat=dw_1.getitemnumber(1,'g_col_coef_musaat')
g_irpf_por_defecto=dw_1.getitemnumber(1,'g_irpf_por_defecto')


//Actualizamos en la bd


//Cuidado: 'Fa' parece que se llama 'g_fa' en otras bases de datos
//programado usando sicalr -->Andr$$HEX1$$e900$$ENDHEX$$s 19/1/05
update var_globales set numero = :g_fa where nombre = 'Fa';
update var_globales set numero = :g_porc_cip_admon where nombre = 'g_porc_cip_admon';
update var_globales set numero = :g_porc_cip_defecto where nombre = 'g_porc_cip_defecto';
update var_globales set numero = :g_porc_cip_sgc where nombre = 'g_porc_cip_sgc';
update var_globales set texto = :g_t_iva_defecto where nombre = 'g_t_iva_defecto';
update var_globales set numero = :g_col_coef_musaat where nombre = 'g_col_coef_musaat';
update var_globales set numero = :g_irpf_por_defecto where nombre = 'g_irpf_por_defecto';

COMMIT;

close(parent)
end event

type cb_2 from w_consulta`cb_2 within w_preferencias_sistema
integer x = 2089
end type

type cb_ayuda from w_consulta`cb_ayuda within w_preferencias_sistema
end type

type dw_1 from w_consulta`dw_1 within w_preferencias_sistema
integer width = 2487
integer height = 540
string dataobject = "d_preferencias_sistema"
boolean border = true
end type

