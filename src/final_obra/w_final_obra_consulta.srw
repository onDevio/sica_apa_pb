HA$PBExportHeader$w_final_obra_consulta.srw
forward
global type w_final_obra_consulta from w_consulta
end type
end forward

global type w_final_obra_consulta from w_consulta
integer width = 1810
integer height = 1480
string title = "Consulta Finales Obra"
end type
global w_final_obra_consulta w_final_obra_consulta

on w_final_obra_consulta.create
call super::create
end on

on w_final_obra_consulta.destroy
call super::destroy
end on

event open;call super::open;// Llamamos al control de eventos con el idw_renuncias
st_control_eventos c_evento
c_evento.evento = 'ABRIR_FINAL_OBRA'
c_evento.dw = dw_1
if f_control_eventos(c_evento)=-1 then return
end event

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_final_obra_consulta
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_final_obra_consulta
string tag = "texto=general.pantalla"
end type

type cb_limpiar from w_consulta`cb_limpiar within w_final_obra_consulta
string tag = "texto=general.limpiar_consulta"
integer x = 1317
end type

type st_5 from w_consulta`st_5 within w_final_obra_consulta
string tag = "texto=final_obra.introduzca_param_consulta_aceptar"
end type

type cb_1 from w_consulta`cb_1 within w_final_obra_consulta
integer x = 334
integer y = 1244
integer height = 88
end type

event cb_1::clicked;call super::clicked;//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo
SetPointer(HourGlass!)
sql_nuevo = g_dw_lista.describe("datawindow.table.select")

//De la tabla fases debemos comprobar : n_expedi,n_registro
f_sql('fases.n_expedi','LIKE','n_expedi',dw_1,sql_nuevo,'1','')
f_sql('fases.n_registro','LIKE','n_registro',dw_1,sql_nuevo,'1','')
f_sql('fases.archivo','LIKE','archivo',dw_1,sql_nuevo,'1','')

//De la tabla fases_finales debemos comprobar los parametros de la consulta
f_sql('fases_finales.total_parcial','LIKE','total_parcial',dw_1,sql_nuevo,'1','')

f_sql('fases_finales.fecha','>=','fecha_desde',dw_1,sql_nuevo,'1','')
f_sql('fases_finales.fecha','<','fecha_hasta',dw_1,sql_nuevo,'1','')

f_sql('fases_finales.presupuesto','>=','presupuesto_desde',dw_1,sql_nuevo,'1','')
f_sql('fases_finales.presupuesto','<','presupuesto_hasta',dw_1,sql_nuevo,'1','')

f_sql('fases_finales.num_viv','=','num_viv',dw_1,sql_nuevo,'1','')
f_sql('fases_finales.num_edif','=','num_edif',dw_1,sql_nuevo,'1','')

f_sql('fases_finales.sup_viv','=','sup_viv',dw_1,sql_nuevo,'1','')
f_sql('fases_finales.sup_otros','=','sup_otros',dw_1,sql_nuevo,'1','')

f_sql('fases_finales.sup_garage','=','sup_garage',dw_1,sql_nuevo,'1','')
f_sql('fases_finales.descripcion','LIKE','descripcion',dw_1,sql_nuevo,'1','')

f_sql('fases_finales.f_intro','>=','f_intro_desde',dw_1,sql_nuevo,'1','')
f_sql('fases_finales.f_intro','<','f_intro_hasta',dw_1,sql_nuevo,'1','')

if g_colegio='COAATMCA' then
	f_sql('fases_finales.f_visado','>=','f_visado_d',dw_1,sql_nuevo,'1','')
	f_sql('fases_finales.f_visado','<','f_visado_h',dw_1,sql_nuevo,'1','')
else
	f_sql('fases.f_visado','>=','f_visado_d',dw_1,sql_nuevo,'1','')
	f_sql('fases.f_visado','<','f_visado_h',dw_1,sql_nuevo,'1','')
end if		


g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")

Parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_final_obra_consulta
integer x = 955
integer y = 1244
integer height = 88
end type

type cb_ayuda from w_consulta`cb_ayuda within w_final_obra_consulta
string tag = "texto=general.ayuda"
end type

type dw_1 from w_consulta`dw_1 within w_final_obra_consulta
integer x = 37
integer y = 124
integer width = 1755
integer height = 1036
string dataobject = "d_final_obra_consulta"
end type

event dw_1::buttonclicked;call super::buttonclicked;string id_fase, ls_n_visado, pob,ls_poblacion

CHOOSE CASE dwo.name
	case 'b_busqueda_fase'
		//Buscamos las fases
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida"
		g_busqueda.dw="d_lista_busqueda_fases"
		id_fase=f_busqueda_fases()  
		if NOT f_es_vacio(id_fase) then
			//Ponemos para que se visualize el valor del expediente, del registro y del visado
			this.setitem(1,'n_registro',f_dame_n_reg(id_fase))	
			this.setitem(1,'n_expedi',f_dame_exp(id_fase))	
			ls_n_visado = f_dame_n_visado(id_fase)
			this.setitem(1,'archivo',ls_n_visado)	
		end if 
		
	CASE 'b_poblacion'
		
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		ls_poblacion = f_poblacion_descripcion_contrato( pob )
		this.SetItem(row,'poblacion',ls_poblacion)

END CHOOSE



end event

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

