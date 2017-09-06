HA$PBExportHeader$w_expedientes_consulta.srw
forward
global type w_expedientes_consulta from w_consulta
end type
end forward

global type w_expedientes_consulta from w_consulta
integer x = 214
integer y = 221
integer width = 2190
integer height = 1540
string title = "Consulta de Expedientes"
end type
global w_expedientes_consulta w_expedientes_consulta

type variables
long i_tab
string i_exp,i_resultado
end variables

forward prototypes
public function string wf_trae_expediente (string as_id_cliente)
public function string wf_trae_expediente_representante (string as_representante)
public function string wf_trae_expediente_colegiado (string as_colegiado)
end prototypes

public function string wf_trae_expediente (string as_id_cliente);string ls_n_expedi
  
  SELECT fases.n_expedi  
  INTO : ls_n_expedi
    FROM fases,   
         fases_clientes  
   WHERE ( fases.id_fase = fases_clientes.id_fase ) and  
         ( ( fases_clientes.id_cliente =:as_id_cliente ) )   ;
			
			
return ls_n_expedi			
end function

public function string wf_trae_expediente_representante (string as_representante);string ls_n_expedi
  
  SELECT fases.n_expedi  
  INTO : ls_n_expedi
    FROM fases,   
         fases_clientes  
   WHERE ( fases.id_fase = fases_clientes.id_fase ) and  
         ( ( fases_clientes.id_representante =:as_representante ) )   ;
			
			
return ls_n_expedi			
end function

public function string wf_trae_expediente_colegiado (string as_colegiado);string ls_n_expedi
  
  SELECT fases.n_expedi  
  INTO : ls_n_expedi
    FROM fases,   
         fases_colegiados  
   WHERE ( fases.id_fase = fases_colegiados.id_fase ) and  
         ( ( fases_colegiados.id_col =:as_colegiado ) )   ;
			
			
return ls_n_expedi			
end function

on w_expedientes_consulta.create
call super::create
end on

on w_expedientes_consulta.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_expedientes_consulta
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_expedientes_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_expedientes_consulta
end type

type st_5 from w_consulta`st_5 within w_expedientes_consulta
integer x = 96
integer y = 16
end type

type cb_1 from w_consulta`cb_1 within w_expedientes_consulta
integer x = 357
integer y = 1336
end type

event cb_1::clicked;call super::clicked;string sql_nuevo, sql_viejo,n_expediente, ls_cliente, ls_representante, ls_colegiado

sql_nuevo = g_dw_lista.describe("datawindow.table.select")
sql_viejo=sql_nuevo
SetPointer(HourGlass!)

dw_1.AcceptText ( ) 
if i_resultado<>'mal' then
	i_resultado='ok'
	i_exp=dw_1.getitemstring(1,'n_expediente')
	if i_exp='0' then i_exp=''

	//f_sql('n_expedi','LIKE','n_expediente',dw_1,sql_nuevo,g_tipo_base_datos,'')
	f_sql('expedientes.cerrado','LIKE','cerrado',dw_1,sql_nuevo,g_tipo_base_datos,'')
	f_sql('expedientes.f_inicio','>=','f_inicio_desde',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
	f_sql('expedientes.f_inicio','<','f_inicio_hasta',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
	f_sql('expedientes.f_cierre','>=','f_cierre_desde',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
	f_sql('expedientes.f_cierre','<','f_cierre_hasta',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
	f_sql('fases.trabajo','LIKE','trabajo',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
	f_sql('fases.tipo_trabajo','LIKE','tipo_trabajo',Parent.dw_1,sql_nuevo,'1','')
	f_sql('fases.poblacion','LIKE','poblacion',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
	f_sql('fases.emplazamiento','LIKE INSIDE','emplazamiento',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
	f_sql('expedientes.archivo','LIKE','archivo',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
	f_sql('expedientes.celda','LIKE','celda',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')

	//busca el expediente del cliente o representante o colegiado de manera adicional, esto debido al join con la tabla fases
	ls_cliente =dw_1.getitemstring(1,'id_cliente')
	if ls_cliente <> ''  then
		if  i_exp ='' OR isnull(i_exp) then
			i_exp = wf_trae_expediente(ls_cliente)
		end if
	end if
	
	
	ls_representante =dw_1.getitemstring(1,'id_representante')
	if ls_representante <> ''  then
		if  i_exp ='' OR isnull(i_exp) then
			i_exp = wf_trae_expediente_representante(ls_representante)
		end if
	end if
	
	ls_colegiado =dw_1.getitemstring(1,'id_colegiado')
	if ls_colegiado <> ''  then
		if  i_exp ='' OR isnull(i_exp) then
			i_exp = wf_trae_expediente_colegiado(ls_colegiado)
		end if
	end if
	
	f_sql('fases_colegiados.id_col','LIKE','id_colegiado',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')  // El LIKE no funciona bien en COAATLR
	f_sql('fases_clientes.id_cliente','LIKE','id_cliente',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'') 
	f_sql('fases_clientes.id_representante','LIKE','id_representante',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')

	
	// Se prepara el formato del Nro. Registro
	if not f_es_vacio(i_exp) then
		if PosA(upper(sql_nuevo), "WHERE") > 0 then
			sql_nuevo = sql_nuevo + "and expedientes.n_expedi LIKE '" + i_exp + "%'"
		else	
			sql_nuevo = sql_nuevo + "WHERE expedientes.n_expedi LIKE '" + i_exp + "%'"
		end if	
	end if
	
//	messagebox("",sql_nuevo)

	if sql_nuevo=sql_viejo then
		MessageBox(g_titulo,'Debe especificar al menos un par$$HEX1$$e100$$ENDHEX$$metro de b$$HEX1$$fa00$$ENDHEX$$squeda')
		return
	end if
	
	g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
	Parent.event pfc_close()
else
	messageBox(g_titulo,'El n$$HEX1$$fa00$$ENDHEX$$mero de expediente introducido es incorrecto, rectifiquelo')
	return 2
	sql_nuevo=''
end if

// Para restablecer el valor inicial en DW
// dw_3.setitem(1,'n_expediente','')	

end event

type cb_2 from w_consulta`cb_2 within w_expedientes_consulta
integer x = 1179
integer y = 1336
end type

type cb_ayuda from w_consulta`cb_ayuda within w_expedientes_consulta
integer x = 1330
integer y = 1196
end type

type dw_1 from w_consulta`dw_1 within w_expedientes_consulta
event csd_borrar_codigos ( )
integer x = 78
integer y = 124
integer width = 1915
integer height = 1184
string dataobject = "d_expedientes_consulta"
end type

event dw_1::csd_borrar_codigos;dw_1.setitem(1,message.stringparm,'')
setcolumn(i_tab)
end event

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)


this.setformat('f_inicio_desde','dd/mm/yyyy')
this.setformat('f_cierre_desde','dd/mm/yyyy')
this.setformat('f_contrato_desde','dd/mm/yyyy')

this.setformat('f_inicio_hasta','dd/mm/yyyy')
this.setformat('f_cierre_hasta','dd/mm/yyyy')
this.setformat('f_contrato_hasta','dd/mm/yyyy')

end event

event dw_1::itemerror;call super::itemerror;// messagebox(g_titulo,'La informaci$$HEX1$$f300$$ENDHEX$$n introducida en alg$$HEX1$$fa00$$ENDHEX$$n par$$HEX1$$e100$$ENDHEX$$metro es incorrecta')
return 1
end event

event dw_1::itemchanged;call super::itemchanged;integer i
boolean sw
string cod
cod='***'
sw=false
i_tab=getcolumn()
choose case dwo.name
	case 'n_expediente'
		i_exp=data
		if i_exp='0' then
			i_exp=''
			i_resultado='mal'
		else
			i_resultado='ok'
		end if
	case 'tipo_trabajo'
		SELECT tipos_trabajos.c_t_trabajo INTO :cod FROM tipos_trabajos WHERE tipos_trabajos.c_t_trabajo = :data;
		sw=true
	case 'trabajo'	
		SELECT trabajos.c_trabajo INTO :cod FROM trabajos WHERE trabajos.c_trabajo = :data ;
		sw=true
	case 'poblacion'
		SELECT poblaciones.cod_pob INTO :cod FROM poblaciones WHERE poblaciones.cod_pob = :data ;
		sw=true
end choose

if cod='***' and sw=true then
	MessageBox(g_titulo,'Este c$$HEX1$$f300$$ENDHEX$$digo no existe. No se tendr$$HEX2$$e1002000$$ENDHEX$$en cuenta en la consulta.')
	message.stringparm=string(dwo.name)
	postevent ("csd_borrar_codigos")
end if
end event

event dw_1::buttonclicked;string id_col, id_cliente, id_representante
string pob, ls_anterior

CHOOSE CASE dwo.name
	CASE 'bb_poblacion'
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(1,'poblacion',pob)
		

	case "b_busca_colegiado"
  		g_busqueda.titulo=g_idioma.of_getmsg('colegiados.busqueda_rapido_col',"B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados")
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()   
		if f_es_vacio(id_col)  then 
			return
		else
			this.setitem(1,'n_colegiado',f_colegiado_n_col(id_col))
			this.setitem(1,'nombre_colegiado',(f_colegiado_apellidos(id_col) + ' ' + f_colegiado_nombre(id_col)) )
			this.setitem(1,'id_colegiado',id_col )
			
		end if

	case "b_busca_cliente"
		g_busqueda.titulo=g_idioma.of_getmsg('colegiados.busqueda_rapido_cli',"B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes")
		g_busqueda.dw="d_lista_busqueda_clientes"
		id_cliente=f_busqueda_clientes("")
		if NOT f_es_vacio(id_cliente)  then
			this.setitem(1,'nif_promotor',f_dame_nif(id_cliente))
			this.setitem(1,'nombre_promotor',f_dame_cliente_nom_ape(id_cliente))
			// Vaciamos cualquier cosa que haya puesta en el representante
			this.setitem(1,'nif_representante','')
			this.setitem(1,'nombre_representante','')
			this.setitem(1,'id_cliente',id_cliente )
		end if
		
	case "b_busca_representante"
			g_busqueda.titulo=g_idioma.of_getmsg('colegiados.busqueda_rapido_cli',"B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes")
			g_busqueda.dw="d_lista_busqueda_clientes"
			id_representante=f_busqueda_terceros(g_terceros_codigos.representantes)
			if NOT f_es_vacio(id_representante)  then
				this.setitem(1,'nif_representante',f_dame_nif(id_representante))
				this.setitem(1,'nombre_representante',f_dame_cliente_nom_ape(id_representante))
				this.setitem(1,'id_representante',id_representante )
			end if

END CHOOSE

end event

