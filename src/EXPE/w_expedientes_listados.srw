HA$PBExportHeader$w_expedientes_listados.srw
forward
global type w_expedientes_listados from w_listados
end type
end forward

global type w_expedientes_listados from w_listados
integer width = 3707
string title = "Listados de Expedientes"
end type
global w_expedientes_listados w_expedientes_listados

type variables
string i_exp
integer i_tab
end variables

on w_expedientes_listados.create
call super::create
end on

on w_expedientes_listados.destroy
call super::destroy
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

// Se desplaza el apuntador al primer registro
dw_listados_varios.scrolltorow(1)
dw_listados_varios.setfocus()




end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_expedientes_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_expedientes_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_expedientes_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_expedientes_listados
end type

type cb_ver from w_listados`cb_ver within w_expedientes_listados
end type

event cb_ver::clicked;call super::clicked;string sql,sql_aux, listado,exp,c1,c2

// dw_1.accepttext()
dw_listados.accepttext()
dw_1.of_setprintpreview(TRUE)

// Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado

sql=''

dw_1.of_SetTransObject(SQLCA)
sql = dw_1.describe("datawindow.table.select")

//Hacer f_sql de todos los campos de la dw_listados de forma analoga a la ventana de consulta
//f_sql('colegiados.n_colegiado','LIKE','n_colegiado',Parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('cerrado','LIKE','cerrado',Parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('f_inicio','>=','f_inicio_desde',Parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('f_inicio','<','f_inicio_hasta',Parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('f_cierre','>=','f_cierre_desde',Parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('f_cierre','<','f_cierre_hasta',Parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('trabajo','LIKE','trabajo',Parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('tipo_trabajo','LIKE','tipo_trabajo',Parent.dw_listados,sql,'1','')
f_sql('poblacion','LIKE','poblacion',Parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('emplazamiento','LIKE','emplazamiento',Parent.dw_listados,sql,g_tipo_base_datos,'')

if not f_es_vacio(dw_listados.getitemstring(1,'n_expediente')) then
	exp=dw_listados.getitemstring(1,'n_expediente')
	c1=MidA(sql,1,PosA(sql,'ORDER') - 1 )
	c2="and expedientes.n_expedi LIKE '" + i_exp + "%'" + ' ' + MidA(sql,PosA(sql,'ORDER'))
	sql=c1 + c2
	//sql=sql + "and expedientes.n_expedi LIKE '" + exp + "%'"
	//messagebox('sql_nuevo 2',sql)	
end if

dw_1.SetTransobject(sqlca)
dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
dw_1.retrieve()

// Al final:
if dw_1.rowcount() > 0 then
	dw_1.visible 		  = true
	dw_1.event pfc_printpreview()
	this.enabled        = false
	cb_zoom.enabled     = true
	cb_imprimir.enabled = true
	cb_guardar.enabled  = true
	cb_escala.enabled  = true
	cb_ordenar.enabled  = true
else
	messagebox(g_titulo,'No se han encontrados registros segun las especificaciones.')
end if

end event

type cb_salir from w_listados`cb_salir within w_expedientes_listados
end type

type dw_listados from w_listados`dw_listados within w_expedientes_listados
event csd_borrar_codigos ( )
integer height = 1184
string dataobject = "d_expedientes_consulta"
end type

event dw_listados::csd_borrar_codigos;dw_listados.setitem(1,message.stringparm,'')
setcolumn(i_tab)
end event

event dw_listados::csd_oculta;//string  dwactual, descactual
//integer nro_opcion
//
//dwactual  = dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'dw')
//descactual= dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'descripcion')
//nro_opcion= dw_listados_varios.getrow()
//
//// Se oculta la opcion del tipo de registro por presentar la de Listados
////dw_listados.object.es.visible				= false
////dw_listados.object.es_listados.visible	= True
//
//// aqui va el campo por donde se filtrara
//// this.object.departamento.visible   = (pos("d_listado_1 d_listado_2", lower(dwactual)) > 1)
//// this.object.departamento_t.visible =this.object.departamento.visible
//
//CHOOSE CASE nro_opcion
//	CASE 1,2
//		dw_listados.object.n_colegiado.visible      				= true
//		dw_listados.object.n_colegiado_t.visible      			= true		
//		dw_listados.object.tipo_persona.visible    				= true
//		dw_listados.object.apellido_nombresociedad.visible 	= true
//		dw_listados.object.apellido_nombresociedad_t.visible 	= true
//		dw_listados.object.nombre.visible    	    				= true
//		dw_listados.object.nombre_t.visible    	    			= true
//		dw_listados.object.n_consejo.visible      	   		= true
//		dw_listados.object.n_consejo_t.visible       	  		= true
//		dw_listados.object.nif_cif.visible     				   = true
//		dw_listados.object.nif_cif_t.visible  	   			   = true
//		dw_listados.object.situacion.visible   	   	      = true
//		dw_listados.object.situacion_t.visible    	  	      = true
//		dw_listados.object.codigo_geografico.visible 	      = true
//		dw_listados.object.codigo_geografico_t.visible  	   = true
//		dw_listados.object.colegio_territorial.visible     	= true
//		dw_listados.object.colegio_territorial_t.visible	   = true
//		dw_listados.object.delegacion.visible       				= true
//		dw_listados.object.delegacion_t.visible  		     		= true		
//		dw_listados.object.lista_colegiados.visible  	      = true
//		dw_listados.object.lista_colegiados_t.visible   	   = true
//		dw_listados.object.f_colegiacion_desde.visible     	= true		
//		dw_listados.object.f_colegiacion_hasta.visible		   = true
//		dw_listados.object.f_colegiacion_t.visible    			= true
//		dw_listados.object.f_alta_desde.visible      	 		= true		
//		dw_listados.object.f_alta_hasta.visible      	 		= true
//		dw_listados.object.f_alta_t.visible       				= true
//		dw_listados.object.f_baja_desde.visible   				= true
//		dw_listados.object.f_baja_hasta.visible	   			= true
//		dw_listados.object.f_baja_t.visible   						= true
//		dw_listados.object.f_titulacion_desde.visible	 		= true		
//		dw_listados.object.f_titulacion_hasta.visible 			= true
//		dw_listados.object.f_titulacion_t.visible 				= true
//		dw_listados.object.f_nacimiento_desde.visible	 		= true		
//		dw_listados.object.f_nacimiento_hasta.visible 			= true
//		dw_listados.object.f_nacimiento_t.visible 				= true
//		dw_listados.object.f_desde_t.visible 						= true
//		dw_listados.object.f_hasta_t.visible 						= true
////	CASE else
////		dw_listados.object.n_colegiado.visible      				= false
////		dw_listados.object.n_colegiado_t.visible      			= false		
////		dw_listados.object.tipo_persona.visible    				= false
////		dw_listados.object.apellido_nombresociedad.visible 	= false
////		dw_listados.object.apellido_nombresociedad_t.visible 	= false
////		dw_listados.object.nombre.visible    	    				= false
////		dw_listados.object.nombre_t.visible    	    			= false
////		dw_listados.object.n_consejo.visible      	   		= false
////		dw_listados.object.n_consejo_t.visible       	  		= false
////		dw_listados.object.nif_cif.visible     				   = false
////		dw_listados.object.nif_cif_t.visible  	   			   = false
////		dw_listados.object.situacion.visible   	   	      = false
////		dw_listados.object.situacion_t.visible    	  	      = false
////		dw_listados.object.codigo_geografico.visible 	      = false
////		dw_listados.object.codigo_geografico_t.visible  	   = false
////		dw_listados.object.colegio_territorial.visible     	= false
////		dw_listados.object.colegio_territorial_t.visible	   = false
////		dw_listados.object.delegacion.visible       				= false
////		dw_listados.object.delegacion_t.visible  		     		= false		
////		dw_listados.object.lista_colegiados.visible  	      = false
////		dw_listados.object.lista_colegiados_t.visible   	   = false
////		dw_listados.object.f_colegiacion_desde.visible     	= false		
////		dw_listados.object.f_colegiacion_hasta.visible		   = false
////		dw_listados.object.f_colegiacion_t.visible    			= false
////		dw_listados.object.f_alta_desde.visible      	 		= false		
////		dw_listados.object.f_alta_hasta.visible      	 		= false
////		dw_listados.object.f_alta_t.visible       				= false
////		dw_listados.object.f_baja_desde.visible   				= false
////		dw_listados.object.f_baja_hasta.visible	   			= false
////		dw_listados.object.f_baja_t.visible   						= false
////		dw_listados.object.f_titulacion_desde.visible	 		= false		
////		dw_listados.object.f_titulacion_hasta.visible 			= false
////		dw_listados.object.f_titulacion_t.visible 				= false
////		dw_listados.object.f_nacimiento_desde.visible	 		= false		
////		dw_listados.object.f_nacimiento_hasta.visible 			= false
////		dw_listados.object.f_nacimiento_t.visible 				= false
////		dw_listados.object.f_desde_t.visible 						= false
////		dw_listados.object.f_hasta_t.visible 						= false
//end choose
end event

event dw_listados::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
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

event dw_listados::itemchanged;call super::itemchanged;integer i
string cod
cod='***'
choose case dwo.name
	case 'n_expediente'
		i_exp=''
		for i=1 to LenA(data)
			if MidA(data,i,1) <> ' ' then
				i_exp=i_exp + MidA(data,i,1)
				if LenA(i_exp) = 2 then i_exp=i_exp + '-'
			else
				i= LenA(data) + 1
			end if
		next
	case 'tipo_trabajo'
		SELECT tipos_trabajos.c_t_trabajo INTO :cod FROM tipos_trabajos WHERE tipos_trabajos.c_t_trabajo = :data;
		i_tab=getcolumn()
	case 'trabajo'	
		SELECT trabajos.c_trabajo INTO :cod FROM trabajos WHERE trabajos.c_trabajo = :data ;
		i_tab=getcolumn()
	case 'poblacion'
		SELECT poblaciones.cod_pob INTO :cod FROM poblaciones WHERE poblaciones.cod_pob = :data ;
		i_tab=getcolumn()
end choose

if cod<>'***' and not isnull(cod) then
	MessageBox(g_titulo,'Este c$$HEX1$$f300$$ENDHEX$$digo no existe.')
	message.stringparm=string(dwo.name)
	postevent ("csd_borrar_codigos")
end if
end event

type cb_imprimir from w_listados`cb_imprimir within w_expedientes_listados
end type

type cb_zoom from w_listados`cb_zoom within w_expedientes_listados
end type

type cb_esp from w_listados`cb_esp within w_expedientes_listados
end type

type cb_guardar from w_listados`cb_guardar within w_expedientes_listados
end type

type cb_escala from w_listados`cb_escala within w_expedientes_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_expedientes_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_expedientes_listados
end type

type dw_1 from w_listados`dw_1 within w_expedientes_listados
integer height = 1460
end type

