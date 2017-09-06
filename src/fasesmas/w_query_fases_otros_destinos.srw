HA$PBExportHeader$w_query_fases_otros_destinos.srw
forward
global type w_query_fases_otros_destinos from w_consulta
end type
end forward

global type w_query_fases_otros_destinos from w_consulta
string title = "Consulta de Integraci$$HEX1$$f300$$ENDHEX$$n Zurich"
end type
global w_query_fases_otros_destinos w_query_fases_otros_destinos

type variables

end variables

on w_query_fases_otros_destinos.create
call super::create
end on

on w_query_fases_otros_destinos.destroy
call super::destroy
end on

event open;call super::open;dw_1.SetItem(1,'mes',Month(Relativedate(Date(Today()),-30)))
dw_1.SetItem(1,'anyo',Year(Relativedate(Date(Today()),-30)))
//dw_1.SetItem(1,'destino','')
dw_1.SetItem(1,'f_creacion',Today())
end event

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_query_fases_otros_destinos
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_query_fases_otros_destinos
end type

type cb_limpiar from w_consulta`cb_limpiar within w_query_fases_otros_destinos
end type

type st_5 from w_consulta`st_5 within w_query_fases_otros_destinos
end type

type cb_1 from w_consulta`cb_1 within w_query_fases_otros_destinos
end type

event cb_1::clicked;call super::clicked;long ll_mes, ll_anyo
string ls_destino, ls_msg = ''
datetime ld_f_creacion

dw_1.AcceptText()

ll_mes = parent.dw_1.GetItemNumber(1,'mes')
ll_anyo = parent.dw_1.GetItemNumber(1,'anyo')
ls_destino = parent.dw_1.GetItemString(1,'destino')
ld_f_creacion = parent.dw_1.GetItemDatetime(1,'f_creacion')

If NOT (ll_mes > 0 ) AND NOT (ll_mes < 13 ) THEN ls_msg += 'El valor del mes debe estar entre el 1 y el 12.' +cr
If NOT (ll_anyo > 1999 ) THEN ls_msg += 'El a$$HEX1$$f100$$ENDHEX$$o debe ser posterior al 2000.'+cr
If f_es_vacio(ls_destino) THEN ls_msg += 'Debe seleccionar un colegio de destino.'+cr
if ls_destino = g_colegio then ls_msg += 'Debe seleccionar un colegio de destino distinto.'+cr
If IsNull(ld_f_creacion) THEN ls_msg += 'Debe introducirse la fecha con la que se crea el fichero de Integraci$$HEX1$$f300$$ENDHEX$$n.'+cr

IF NOT f_es_vacio(ls_msg) THEN 
	MessageBox(g_titulo,'Se han producido los siguientes errores:'+cr+ls_msg)
	RETURN 
END IF

g_st_zurich.mes = ll_mes 
g_st_zurich.anyo = ll_anyo 
g_st_zurich.src_cia = ls_destino
g_st_zurich.f_creacion = ld_f_creacion 

parent.event pfc_close()
end event

type cb_2 from w_consulta`cb_2 within w_query_fases_otros_destinos
end type

type cb_ayuda from w_consulta`cb_ayuda within w_query_fases_otros_destinos
end type

type dw_1 from w_consulta`dw_1 within w_query_fases_otros_destinos
integer x = 105
integer y = 260
integer width = 1673
integer height = 368
string dataobject = "d_query_fases_otros_destinos"
end type

