HA$PBExportHeader$w_garantias_consulta.srw
forward
global type w_garantias_consulta from w_consulta
end type
end forward

global type w_garantias_consulta from w_consulta
integer width = 3086
integer height = 1400
string title = "Consulta de Garant$$HEX1$$cd00$$ENDHEX$$as/Fondos"
end type
global w_garantias_consulta w_garantias_consulta

on w_garantias_consulta.create
call super::create
end on

on w_garantias_consulta.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_garantias_consulta
integer x = 2994
integer y = 348
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_garantias_consulta
integer x = 2994
integer y = 220
end type

type cb_limpiar from w_consulta`cb_limpiar within w_garantias_consulta
integer x = 2990
integer y = 588
end type

type st_5 from w_consulta`st_5 within w_garantias_consulta
end type

type cb_1 from w_consulta`cb_1 within w_garantias_consulta
integer x = 553
integer y = 1184
integer height = 88
end type

event cb_1::clicked;call super::clicked;//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo, sql_1, sql_2
long pos
SetPointer(HourGlass!)
sql_nuevo = g_dw_lista.describe("datawindow.table.select")

//Modificado por Luis 18/02/2009 para la incidencia cgn-318
if not(f_es_vacio(dw_1.getitemstring(1,'n_colegiado')) and f_es_vacio(dw_1.getitemstring(1,'nombre_colegiado')) and f_es_vacio(dw_1.getitemstring(1,'apellidos_colegiado')))then
	pos = Pos(sql_nuevo,"*")
	sql_1 = Mid(sql_nuevo,1,pos - 1)
	sql_2 = Mid(sql_nuevo,pos + 1,Len(sql_nuevo))
	sql_nuevo = sql_1 + sql_2
end if
//fin modificado Luis

//De la tabla fases debemos comprobar : n_expedi,n_registro
f_sql('fases.n_expedi','LIKE','n_expediente',dw_1,sql_nuevo,'1','')
f_sql('fases.n_registro','LIKE','n_registro',dw_1,sql_nuevo,'1','')

//De la tabla colegiados
f_sql('colegiados.n_colegiado','LIKE','n_colegiado',dw_1,sql_nuevo,'1','')
f_sql('colegiados.nombre','LIKE','nombre_colegiado',dw_1,sql_nuevo,'1','')
f_sql('colegiados.apellidos','LIKE','apellidos_colegiado',dw_1,sql_nuevo,'1','')

//De la tabla clientes
f_sql('clientes.n_cliente','LIKE','n_cliente',dw_1,sql_nuevo,'1','')
f_sql('clientes.nombre','LIKE','nombre_cliente',dw_1,sql_nuevo,'1','')
f_sql('clientes.apellidos','LIKE','apellidos_cliente',dw_1,sql_nuevo,'1','')

//De la tabla garantias
f_sql('fases_garantias.importe','>=','importe_desde',dw_1,sql_nuevo,'1','')
f_sql('fases_garantias.importe','<','importe_hasta',dw_1,sql_nuevo,'1','')

f_sql('fases_garantias.f_in','>=','f_in_desde',dw_1,sql_nuevo,'1','')
f_sql('fases_garantias.f_in','<','f_in_hasta',dw_1,sql_nuevo,'1','')

f_sql('fases_garantias.f_out','>=','f_out_desde',dw_1,sql_nuevo,'1','')
f_sql('fases_garantias.f_out','<','f_out_hasta',dw_1,sql_nuevo,'1','')


g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")


Parent.event pfc_close()


end event

type cb_2 from w_consulta`cb_2 within w_garantias_consulta
integer x = 1989
integer y = 1184
integer height = 88
end type

type cb_ayuda from w_consulta`cb_ayuda within w_garantias_consulta
integer x = 2994
integer y = 520
end type

type dw_1 from w_consulta`dw_1 within w_garantias_consulta
integer x = 27
integer y = 128
integer width = 3003
integer height = 956
string dataobject = "d_garantias_consulta"
end type

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event dw_1::buttonclicked;call super::buttonclicked;string id_col,id_fase,id_cliente,nif


choose case dwo.name
case "b_busqueda_fase"
		//Buscamos las fases
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Contratos"
		g_busqueda.dw="d_lista_busqueda_fases"
		id_fase=f_busqueda_fases()  
		if NOT f_es_vacio(id_fase) then
			//Ponemos para que se visualize el valor del expediente y del registro
			this.setitem(1,'n_registro',f_dame_n_reg(id_fase))	
			this.setitem(1,'n_expediente',f_dame_exp(id_fase))	
		end if 
	
case "b_busqueda_colegiado"
	//Buscamos los colegiados
  		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()   
		if NOT f_es_vacio(id_col)  then
			this.setitem(1,'n_colegiado',f_colegiado_n_col(id_col))
			this.setitem(1,'nombre_colegiado',f_colegiado_nombre(id_col))
			this.setitem(1,'apellidos_colegiado',f_colegiado_apellidos(id_col))
		end if
case "b_busqueda_cliente"
		//Buscamos los clientes
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
		g_busqueda.dw="d_lista_busqueda_clientes"		
		id_cliente=f_busqueda_clientes(this.getitemstring(row, 'n_cliente'))
		if not(f_es_vacio(id_cliente)) then
			select nif into :nif from clientes where id_cliente = :id_cliente;
			if not(f_es_vacio(nif)) then this.setitem(row,'n_cliente',nif)
			if not(f_es_vacio(id_cliente)) then this.setitem(row,'nombre_cliente',f_dame_cliente(id_cliente))
		end if
		
END CHOOSE
end event

