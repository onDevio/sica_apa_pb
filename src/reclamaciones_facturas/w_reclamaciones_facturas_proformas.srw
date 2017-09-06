HA$PBExportHeader$w_reclamaciones_facturas_proformas.srw
forward
global type w_reclamaciones_facturas_proformas from w_detalle
end type
type dw_consulta from u_dw within w_reclamaciones_facturas_proformas
end type
type tab_1 from tab within w_reclamaciones_facturas_proformas
end type
type tabpage_1 from userobject within tab_1
end type
type dw_proformas from u_dw within tabpage_1
end type
type dw_facturas from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_proformas dw_proformas
dw_facturas dw_facturas
end type
type tabpage_2 from userobject within tab_1
end type
type dw_visualizar from u_dw within tabpage_2
end type
type dw_cartas from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_visualizar dw_visualizar
dw_cartas dw_cartas
end type
type tab_1 from tab within w_reclamaciones_facturas_proformas
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_genera_cartas from commandbutton within w_reclamaciones_facturas_proformas
end type
type cb_imprimir_carta from commandbutton within w_reclamaciones_facturas_proformas
end type
type cb_actualizar from commandbutton within w_reclamaciones_facturas_proformas
end type
type cb_ocultar from commandbutton within w_reclamaciones_facturas_proformas
end type
type st_previsualizar from statictext within w_reclamaciones_facturas_proformas
end type
end forward

global type w_reclamaciones_facturas_proformas from w_detalle
integer width = 4155
integer height = 2540
string title = "Ventana de Reclamaciones"
string menuname = "m_reclamacion_facturas"
event csd_obtener_fact_prof ( )
event csd_proformas ( )
event csd_facturas ( )
event csd_genera_carta_facturas ( )
event csd_genera_carta_proforma ( )
event csd_obtener_fact_prof_agrupadas ( )
event csd_proformas_agrup ( )
event csd_facturas_agrup ( )
event csd_consulta_fact_prof ( )
dw_consulta dw_consulta
tab_1 tab_1
cb_genera_cartas cb_genera_cartas
cb_imprimir_carta cb_imprimir_carta
cb_actualizar cb_actualizar
cb_ocultar cb_ocultar
st_previsualizar st_previsualizar
end type
global w_reclamaciones_facturas_proformas w_reclamaciones_facturas_proformas

type variables
u_dw idw_consulta,idw_facturas, idw_proformas,idw_cartas,idw_visualizar
end variables

forward prototypes
public subroutine wf_imprimir_cartas ()
public function string wf_modifica_sql (string sql)
public subroutine wf_imprimir_una_carta (long row)
public subroutine wf_visualizar_una_carta (long row)
public function string wf_modifica_sql_consulta (string sql)
end prototypes

event csd_obtener_fact_prof();string proforma
dw_consulta.accepttext()

proforma=dw_consulta.getitemstring(1, 'proforma')

if proforma='S' then
	this.event csd_proformas()
elseif proforma='N' then
	this.event csd_facturas()
else
	this.event csd_proformas()
	this.event csd_facturas()
end if

end event

event csd_proformas();//facturas proformas
string sql_prof,sql_original,id_factura,tipo_persona,tipo_reclamacion,tipo_reclamacion_siguiente,tipo_reclamacion_consulta,remesada,filtro
int i,aux
int borrar[]
aux=0
sql_prof=idw_proformas.GetSQLSelect()
sql_original=sql_prof

//Modificamos la sql en funci$$HEX1$$f300$$ENDHEX$$n de los parametros de consulta
sql_prof=wf_modifica_sql(sql_prof)
	
	
idw_proformas.setRedraw(false)	
idw_proformas.Modify("DataWindow.Table.Select= ~"" + sql_prof + "~"")
idw_proformas.SetTransobject(sqlca)
idw_proformas.retrieve()

tipo_reclamacion_consulta=dw_consulta.getItemString(1,'tipo_reclamacion')
for i=1 to idw_proformas.rowcount()
	id_factura=idw_proformas.getitemstring(i,'id_factura')
	tipo_reclamacion=f_obtener_tipo_reclamacion(id_factura)
	//Aquellas facturas obtenidas cuya ultima reclamaci$$HEX1$$f300$$ENDHEX$$n no sea la de consulta, no aparecer$$HEX2$$e1002000$$ENDHEX$$en el dw
	//creamos string con estas facturas
	if not f_es_vacio(tipo_reclamacion_consulta) then
		if tipo_reclamacion<>tipo_reclamacion_consulta then
			if filtro='' then
				filtro = id_factura
			else
				filtro += ',' + id_factura
			end if
		end if
	end if
next
if filtro<>'' then
	sql_prof += " AND id_factura NOT IN ("+f_coloca_comillas(filtro)+")"
	idw_proformas.Modify("DataWindow.Table.Select= ~"" + sql_prof + "~"")
	idw_proformas.retrieve()
end if
//Rellenamos los campos para las facturas que han pasado el filtro
for i=1 to idw_proformas.rowcount()
	id_factura=idw_proformas.getitemstring(i,'id_factura')
	tipo_reclamacion=f_obtener_tipo_reclamacion(id_factura)
	tipo_persona=idw_proformas.getitemstring(i,'tipo_persona')
	remesada=f_dame_remesada_factura(id_factura)	
	tipo_reclamacion_siguiente=f_obtener_tipo_reclamacion_siguiente(tipo_reclamacion,id_factura,tipo_persona,/*remesada,*/'P')
	idw_proformas.setitem(i,'tipo_reclamacion',tipo_reclamacion)
	idw_proformas.setitem(i,'tipo_recla_siguiente_no_agrup',tipo_reclamacion_siguiente)
	if tipo_reclamacion_siguiente='NO' then
		idw_proformas.setitem(i,'generar_reclamacion','N')
	end if
	
	idw_proformas.object.tipo_reclamacion.protect=1
	
next

idw_proformas.setRedraw(true)
idw_proformas.Modify("DataWindow.Table.Select= ~"" + sql_original + "~"")
end event

event csd_facturas();//facturas
string sql,sql_original,id_factura,tipo_persona,tipo_reclamacion,tipo_reclamacion_siguiente,tipo_reclamacion_consulta,remesada,filtro
int i,aux
int borrar[]
filtro=''
sql=idw_facturas.GetSQLSelect()
sql_original=sql

//Modificamos la sql en funci$$HEX1$$f300$$ENDHEX$$n de los parametros de consulta
sql=wf_modifica_sql(sql)
		

idw_facturas.setRedraw(false)
idw_facturas.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
idw_facturas.SetTransobject(sqlca)
idw_facturas.retrieve()
tipo_reclamacion_consulta=dw_consulta.getItemString(1,'tipo_reclamacion')
//Primer bucle que nos filtrar$$HEX2$$e1002000$$ENDHEX$$facturas si buscamos por ultima reclamaci$$HEX1$$f300$$ENDHEX$$n
for i=1 to idw_facturas.rowcount()
	id_factura=idw_facturas.getitemstring(i,'id_factura')
	tipo_reclamacion=f_obtener_tipo_reclamacion(id_factura)
	//Aquellas facturas obtenidas cuya ultima reclamaci$$HEX1$$f300$$ENDHEX$$n no sea la de consulta, no aparecer$$HEX2$$e1002000$$ENDHEX$$en el dw
	//creamos string con estas facturas
	if not f_es_vacio(tipo_reclamacion_consulta) then
		if tipo_reclamacion<>tipo_reclamacion_consulta then
			if filtro='' then
				filtro = id_factura
			else
				filtro += ',' + id_factura
			end if
		end if
	end if
next
if filtro<>'' then
	sql += " AND id_factura NOT IN ("+f_coloca_comillas(filtro)+")"
	idw_facturas.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
	idw_facturas.retrieve()
end if
//Rellenamos los campos para las facturas que han pasado el filtro
for i=1 to idw_facturas.rowcount()
	id_factura=idw_facturas.getitemstring(i,'id_factura')
	tipo_reclamacion=f_obtener_tipo_reclamacion(id_factura)
	tipo_persona=idw_facturas.getitemstring(i,'tipo_persona')
	remesada=f_dame_remesada_factura(id_factura)	
	tipo_reclamacion_siguiente=f_obtener_tipo_reclamacion_siguiente(tipo_reclamacion,id_factura,tipo_persona,/*remesada,*/'F')
	idw_facturas.setitem(i,'tipo_reclamacion',tipo_reclamacion)
	idw_facturas.setitem(i,'tipo_recla_siguiente_no_agrup',tipo_reclamacion_siguiente)
	if tipo_reclamacion_siguiente='NO' then
		idw_facturas.setitem(i,'generar_reclamacion','N')
	end if
	
	idw_facturas.object.tipo_reclamacion.protect=1
	
next
//for i=1 to aux
//	idw_facturas.deleterow(borrar[i])
//next
//Aplicamos el filtro al dw

idw_facturas.setRedraw(true)
idw_facturas.Modify("DataWindow.Table.Select= ~"" + sql_original + "~"")
end event

event csd_genera_carta_facturas();long fila, fila_insert
string tipo_reclamacion, id_grupo, nombre = '', nombre_ant = '-1'

if idw_facturas.RowCount()>0 then
	FOR fila = 1 TO idw_facturas.RowCount()
		if idw_facturas.getitemString(fila, 'generar_reclamacion') = 'S' then
			// Hay que generar la nueva reclamacion
			if g_tipo_notificacion='I' then
				tipo_reclamacion = idw_facturas.getitemString(fila, 'tipo_recla_siguiente_no_agrup')
			elseif g_tipo_notificacion='A' then
				tipo_reclamacion = idw_facturas.getitemString(fila, 'tipo_recla_siguiente_agrup')
			else
				tipo_reclamacion = idw_facturas.getitemString(fila, 'tipo_reclamacion_siguiente')
			end if
			
			if tipo_reclamacion='NO' then continue
			
			nombre = idw_facturas.getitemString(fila, 'nombre')
			
			if f_reclamacion_agrupada(tipo_reclamacion) then
				if nombre <> nombre_ant then
					// Generamos un nuevo numero de grupo
					id_grupo = f_siguiente_numero('RECLAM_FACT_GRUPO', 10)
					nombre_ant = nombre
				end if
			else
				id_grupo = ''
			end if
			
			// Colocamos la fila en el nuevo valor
			fila_insert = idw_cartas.insertrow(0)
			//idw_cartas.setitem(fila_insert, 'id_reclamacion_factura', f_siguiente_numero('RECLAM_FACT', 10))
			idw_cartas.setitem(fila_insert, 'id_grupo', id_grupo)
			idw_cartas.setitem(fila_insert, 'f_reclamacion', date(today()))
			idw_cartas.setitem(fila_insert, 'tipo_reclamacion', tipo_reclamacion)
			idw_cartas.setitem(fila_insert, 'id_factura', idw_facturas.getitemString(fila, 'id_factura'))
			idw_cartas.setitem(fila_insert, 'n_fact', idw_facturas.getitemString(fila, 'n_fact'))
			idw_cartas.setitem(fila_insert, 'fecha', idw_facturas.getitemDateTime(fila, 'fecha'))
			idw_cartas.setitem(fila_insert, 'nombre', idw_facturas.getitemString(fila, 'nombre'))
			idw_cartas.setitem(fila_insert, 'tipo_persona',idw_facturas.getitemString(fila, 'tipo_persona'))
		end if
	NEXT
	// Una vez generadas las facturas... vaciamos
	idw_facturas.reset()
end if

// Imprimimos las cartas
//wf_imprimir_cartas()
end event

event csd_genera_carta_proforma();long fila, fila_insert
string tipo_reclamacion, id_grupo, nombre = '', nombre_ant = '-1'

if idw_proformas.RowCount()>0 then
	FOR fila = 1 TO idw_proformas.RowCount()
		
		if idw_proformas.getitemString(fila, 'generar_reclamacion') = 'S' then
			// Hay que generar la nueva reclamacion
			if g_tipo_notificacion='I' then
				tipo_reclamacion = idw_proformas.getitemString(fila, 'tipo_recla_siguiente_no_agrup')
			elseif g_tipo_notificacion='A' then
				tipo_reclamacion = idw_proformas.getitemString(fila, 'tipo_recla_siguiente_agrup')
			else
				tipo_reclamacion = idw_proformas.getitemString(fila, 'tipo_reclamacion_siguiente')
			end if
			
			if tipo_reclamacion='NO' then continue
			
			nombre = idw_proformas.getitemString(fila, 'nombre')
			// Colocamos la fila en el nuevo valor
			fila_insert = idw_cartas.insertrow(0)
			if f_reclamacion_agrupada(tipo_reclamacion) then
				if nombre <> nombre_ant then
					// Generamos un nuevo numero de grupo
					id_grupo = f_siguiente_numero('RECLAM_FACT_GRUPO', 10)
					nombre_ant = nombre
				end if
				idw_cartas.setitem(fila_insert, 'id_grupo', id_grupo)
			else
				idw_cartas.setitem(fila_insert, 'id_grupo', '')
				//id_grupo = ''
			end if
			
			
			
			//idw_cartas.setitem(fila_insert, 'id_reclamacion_factura', f_siguiente_numero('RECLAM_FACT', 10))
			//idw_cartas.setitem(fila_insert, 'id_grupo', id_grupo)
			idw_cartas.setitem(fila_insert, 'f_reclamacion', date(today()))
			idw_cartas.setitem(fila_insert, 'tipo_reclamacion', tipo_reclamacion)
			idw_cartas.setitem(fila_insert, 'id_factura', idw_proformas.getitemString(fila, 'id_factura'))
			idw_cartas.setitem(fila_insert, 'n_fact', idw_proformas.getitemString(fila, 'n_fact'))
			idw_cartas.setitem(fila_insert, 'fecha', idw_proformas.getitemDateTime(fila, 'fecha'))
			idw_cartas.setitem(fila_insert, 'nombre', idw_proformas.getitemString(fila, 'nombre'))
			idw_cartas.setitem(fila_insert, 'tipo_persona',idw_proformas.getitemString(fila, 'tipo_persona'))
		end if
	NEXT
	// Una vez generadas las facturas... vaciamos
	idw_proformas.reset()
end if

// Imprimimos las cartas
//wf_imprimir_cartas()
end event

event csd_obtener_fact_prof_agrupadas();string proforma
dw_consulta.accepttext()

proforma=dw_consulta.getitemstring(1, 'proforma')

if proforma='S' then
	this.event csd_proformas_agrup()
elseif proforma='N' then
	this.event csd_facturas_agrup()
else
	this.event csd_proformas_agrup()
	this.event csd_facturas_agrup()
end if

end event

event csd_proformas_agrup();//facturas proformas agrupadas
string sql_prof,sql_original,id_factura,tipo_persona,tipo_reclamacion,tipo_reclamacion_siguiente,remesada,nombre
int i

sql_prof=idw_proformas.GetSQLSelect()
sql_original=sql_prof

//Modificamos la sql en funci$$HEX1$$f300$$ENDHEX$$n de los parametros de consulta
sql_prof=wf_modifica_sql(sql_prof)
	
	
	
idw_proformas.Modify("DataWindow.Table.Select= ~"" + sql_prof + "~"")

idw_proformas.SetTransobject(sqlca)

idw_proformas.retrieve()
idw_proformas.sort()

for i=1 to idw_proformas.rowcount()	
	id_factura=idw_proformas.getitemstring(i,'id_factura')
	tipo_persona=idw_proformas.getitemstring(i,'tipo_persona')
	remesada=f_dame_remesada_factura(id_factura)
	tipo_reclamacion=f_obtener_tipo_agrupada(tipo_persona,remesada,'P')
	idw_proformas.setitem(i,'tipo_reclamacion',tipo_reclamacion)
	idw_proformas.setitem(i,'tipo_recla_siguiente_agrup',tipo_reclamacion)
	idw_proformas.object.tipo_reclamacion.protect=1
next

idw_proformas.Modify("DataWindow.Table.Select= ~"" + sql_original + "~"")
end event

event csd_facturas_agrup();//facturas agrupadas
string sql_prof,sql_original,id_factura,tipo_persona,tipo_reclamacion,tipo_reclamacion_siguiente,remesada,nombre
int i

sql_prof=idw_facturas.GetSQLSelect()
sql_original=sql_prof

//Modificamos la sql en funci$$HEX1$$f300$$ENDHEX$$n de los parametros de consulta
sql_prof=wf_modifica_sql(sql_prof)
	
	
	
idw_facturas.Modify("DataWindow.Table.Select= ~"" + sql_prof + "~"")

idw_facturas.SetTransobject(sqlca)

idw_facturas.retrieve()
idw_facturas.sort()

for i=1 to idw_facturas.rowcount()	
	id_factura=idw_facturas.getitemstring(i,'id_factura')
	tipo_persona=idw_facturas.getitemstring(i,'tipo_persona')
	remesada=f_dame_remesada_factura(id_factura)
	tipo_reclamacion=f_obtener_tipo_agrupada(tipo_persona,remesada,'P')
	idw_facturas.setitem(i,'tipo_reclamacion',tipo_reclamacion)
	idw_facturas.setitem(i,'tipo_recla_siguiente_agrup',tipo_reclamacion)
	idw_facturas.object.tipo_reclamacion.protect=1
next

idw_facturas.Modify("DataWindow.Table.Select= ~"" + sql_original + "~"")
end event

event csd_consulta_fact_prof();string sql,sql_original,id_factura,tipo_persona,tipo_reclamacion,tipo_reclamacion_siguiente,remesada
int i

sql=idw_cartas.GetSQLSelect()
sql_original=sql
//A$$HEX1$$f100$$ENDHEX$$diamos consulta por 'proforma'
f_sql('csi_facturas_emitidas.proforma','LIKE','proforma',dw_consulta,sql,'1','')
//Modificamos la sql en funci$$HEX1$$f300$$ENDHEX$$n de los parametros de consulta
sql=wf_modifica_sql_consulta(sql)
idw_cartas.Modify("DataWindow.Table.Select= ~"" + sql + "~"")

idw_cartas.retrieve()	

//Activamos la opci$$HEX1$$f300$$ENDHEX$$n de imprimir
if idw_cartas.rowcount() > 0 then
	cb_imprimir_carta.enabled=true
end if

idw_cartas.Modify("DataWindow.Table.Select= ~"" + sql_original + "~"")
end event

public subroutine wf_imprimir_cartas ();long copias, fila, k
string tipo_reclamacion, id_grupo, id_factura, dw, lista_ids, sql,logo

// Preguntamos las copias que se quieren imprimir
openwithparm(w_n_copias, 'RECLAMACION')
if not isnumber(Message.StringParm) then return
copias = long(Message.StringParm)
// fin  copias


// Creamos el datastore
datastore ds
ds = create datastore
FOR fila = 1 TO idw_cartas.RowCount()
	
	// Hay que generar la nueva reclamacion
	tipo_reclamacion = idw_cartas.getitemString(fila, 'tipo_reclamacion')
	// Colocamos el dw asociado al tipo de reclamacion en el datastore a imprimir
	dw = f_dame_dw_asociado_tipo_reclamacion(tipo_reclamacion)
	if f_es_vacio(dw) then return
	ds.dataobject = dw
		
	f_logo_empresa_ds(g_empresa ,ds, '006')
	
	
	ds.settransobject (SQLCA)
	logo="'.\imagenes\" + g_logo_empresa + "'"
	ds.modify("p_logo.FileName=" + logo)
	
	
	

	
	// Seg$$HEX1$$fa00$$ENDHEX$$n sea agrupada o sin agrupar hacemos una cosa u otra
	if f_reclamacion_agrupada(tipo_reclamacion) then
		id_factura = idw_cartas.getitemString(fila, 'id_factura')
		id_grupo = idw_cartas.getitemString(fila, 'id_grupo')
		ds.retrieve(id_factura)
		// Las recorremos para imprimirlas
		for k = 1 to copias
			if ds.rowcount()>0 then ds.print()
		next
		// Agregamos todas las facturas del grupo para imprimir el listado
		lista_ids = "'"+id_factura+"'"
		// Nos tenemos que saltar todas las facturas de este grupo
		DO WHILE fila<idw_cartas.RowCount() 
			if f_es_vacio(idw_cartas.getitemString(fila+1, 'id_grupo')) then exit
			if id_grupo<>idw_cartas.getitemString(fila+1, 'id_grupo') then
				// Salimos del bucle
				exit
			else
				// Pasamos todas las que sean de este grupo
				if LenA(lista_ids)>0 then lista_ids += ", "
				id_factura = idw_cartas.getitemString(fila+1, 'id_factura')
				lista_ids += "'"+id_factura+"'"
				fila++
			end if
		LOOP
		// Cambiamos al listado de facturas e imprimimos este
		ds.dataobject = 'd_reclamaciones_facturas_agrup_facts'
		ds.settransobject (SQLCA)
		sql = ds.describe("datawindow.table.select")
		// Anyadimos la condicion de las facturas
		sql += " AND csi_facturas_emitidas.id_factura in ("+lista_ids+")"
		ds.modify("datawindow.table.select= ~"" + sql + "~"")
		ds.retrieve()
		for k = 1 to copias
			if ds.rowcount()>0 then ds.print()
		next
	else
		id_factura = idw_cartas.getitemString(fila, 'id_factura')
		ds.retrieve(id_factura)
		// Las recorremos para imprimirlas
		for k = 1 to copias
			if ds.rowcount()>0 then ds.print()
		next
	end if
	

	
	// Si nos hemos pasado de rango salimos
	if fila>idw_cartas.RowCount() then exit
NEXT
// Destruimos el datastore
destroy ds
end subroutine

public function string wf_modifica_sql (string sql);
string sql_aux,id_expedi,id_fase,dato
date dato_fecha

dw_consulta.accepttext()
		
f_sql('csi_facturas_emitidas.n_fact','LIKE','n_fact',dw_consulta,sql,'1','')
f_sql('csi_facturas_emitidas.fecha','>=','f_fact_prof_desde',dw_consulta,sql,'1','')
f_sql('csi_facturas_emitidas.fecha','<','f_fact_prof_hasta',dw_consulta,sql,'1','')
f_sql('csi_facturas_emitidas.n_col','=','n_col',dw_consulta,sql,'1','')
f_sql('csi_facturas_emitidas.nif','=','nif',dw_consulta,sql,'1','')



		
////expediente		
if not ( f_es_vacio(dw_consulta.getitemstring(1, 'n_exp'))) then
	id_expedi=f_dame_id_exp_de_n_exp(dw_consulta.getitemstring(1, 'n_exp'))
	
	sql_aux= "and (csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM expedientes, fases, fases_minutas WHERE expedientes.id_expedi = fases.id_expedi and fases_minutas.id_fase = fases.id_fase and expedientes.id_expedi='"+id_expedi+"') "
	sql_aux = sql_aux +" or csi_facturas_emitidas.id_minuta IN (SELECT id_fase FROM expedientes, fases WHERE expedientes.id_expedi = fases.id_expedi and expedientes.id_expedi='"+id_expedi+"'))"
	
	if not isnull(sql_aux) then sql += sql_aux		
end if
//
////registro
if not ( f_es_vacio(dw_consulta.getitemstring(1, 'n_reg'))) then
	id_fase=f_dame_id_fase_de_n_reg(dw_consulta.getitemstring(1, 'n_reg'))
	
	sql_aux = "and (csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM fases, fases_minutas WHERE fases_minutas.id_fase = fases.id_fase and fases.id_fase ='"+id_fase+"')"
	sql_aux = sql_aux + " or csi_facturas_emitidas.id_minuta IN (SELECT id_fase FROM fases WHERE fases.id_fase='"+id_fase+"'))"
	
	if not isnull(sql_aux) then sql += sql_aux	
end if

////fecha_carta
dato = string(date(dw_consulta.getitemdatetime(1, 'f_carta_desde')),"YYYYMMDD")
if not (f_es_vacio(dato)) then	
	sql_aux = "and (csi_facturas_emitidas.id_factura IN (SELECT id_factura FROM csi_fact_reclamaciones WHERE  f_reclamacion >='"+dato+"'))"
	if not isnull(sql_aux) then sql += sql_aux	
end if

dato_fecha =date(dw_consulta.getitemdatetime(1, 'f_carta_desde'))
dato_fecha = relativedate(dato_fecha, 1)
dato=string(dato_fecha,"YYYYMMDD")
if not (f_es_vacio(dato)) then
	
	sql_aux = "and (csi_facturas_emitidas.id_factura IN (SELECT id_factura FROM csi_fact_reclamaciones WHERE  csi_fact_reclamaciones.f_reclamacion <'"+dato+"'))"
	if not isnull(sql_aux) then sql += sql_aux	
end if
//tipo_reclamacion
if not (f_es_vacio(dw_consulta.getitemstring(1, 'tipo_reclamacion'))) then
	
	sql_aux = "and (csi_facturas_emitidas.id_factura IN (SELECT id_factura FROM csi_fact_reclamaciones WHERE  csi_fact_reclamaciones.tipo_reclamacion ='"+dw_consulta.getitemstring(1, 'tipo_reclamacion')+"'))"
	if not isnull(sql_aux) then sql += sql_aux	
end if

return sql
end function

public subroutine wf_imprimir_una_carta (long row);long copias, k
string tipo_reclamacion, id_grupo, id_factura, dw, lista_ids, sql,logo

// Preguntamos las copias que se quieren imprimir
openwithparm(w_n_copias, 'RECLAMACION')
if not isnumber(Message.StringParm) then return
copias = long(Message.StringParm)
// fin  copias


// Creamos el datastore
datastore ds
ds = create datastore
	// Hay que generar la nueva reclamacion
	tipo_reclamacion = idw_cartas.getitemString(row, 'tipo_reclamacion')
	// Colocamos el dw asociado al tipo de reclamacion en el datastore a imprimir
	dw = f_dame_dw_asociado_tipo_reclamacion(tipo_reclamacion)
	if f_es_vacio(dw) then return
	ds.dataobject = dw
	ds.settransobject (SQLCA)
	logo="'.\imagenes\" + g_logo_empresa + "'"
	ds.modify("p_logo.FileName=" + logo)
	
	f_logo_empresa_ds(g_empresa ,ds, '006')
	
	// Seg$$HEX1$$fa00$$ENDHEX$$n sea agrupada o sin agrupar hacemos una cosa u otra
	if f_reclamacion_agrupada(tipo_reclamacion) then
		id_factura = idw_cartas.getitemString(row, 'id_factura')
		id_grupo = idw_cartas.getitemString(row, 'id_grupo')
		ds.retrieve(id_factura)
		// Las recorremos para imprimirlas
		for k = 1 to copias
			if ds.rowcount()>0 then ds.print()
		next
		// Agregamos todas las facturas del grupo para imprimir el listado
		lista_ids = "'"+id_factura+"'"
		// Nos tenemos que saltar todas las facturas de este grupo
		DO WHILE row<idw_cartas.RowCount() 
			if f_es_vacio(idw_cartas.getitemString(row+1, 'id_grupo')) then exit
			if id_grupo<>idw_cartas.getitemString(row+1, 'id_grupo') then
				// Salimos del bucle
				exit
			else
				// Pasamos todas las que sean de este grupo
				if LenA(lista_ids)>0 then lista_ids += ", "
				id_factura = idw_cartas.getitemString(row+1, 'id_factura')
				lista_ids += "'"+id_factura+"'"
				row++
			end if
		LOOP
		// Cambiamos al listado de facturas e imprimimos este
		ds.dataobject = 'd_reclamaciones_facturas_agrup_facts'
		ds.settransobject (SQLCA)
		sql = ds.describe("datawindow.table.select")
		// Anyadimos la condicion de las facturas
		sql += " AND csi_facturas_emitidas.id_factura in ("+lista_ids+")"
		ds.modify("datawindow.table.select= ~"" + sql + "~"")
		ds.retrieve()
		for k = 1 to copias
			if ds.rowcount()>0 then ds.print()
		next
	else
		id_factura = idw_cartas.getitemString(row, 'id_factura')
		ds.retrieve(id_factura)
		// Las recorremos para imprimirlas
		for k = 1 to copias
			if ds.rowcount()>0 then ds.print()
		next
	end if

	
	// Si nos hemos pasado de rango salimos
	//if row>idw_cartas.RowCount() then exit
// Destruimos el datastore
destroy ds
end subroutine

public subroutine wf_visualizar_una_carta (long row);long copias, k
string tipo_reclamacion, id_grupo, id_factura, dw, lista_ids, sql
datawindowchild dw_ch
string logo
// Preguntamos las copias que se quieren imprimir
//openwithparm(w_n_copias, 'RECLAMACION')
//if not isnumber(Message.StringParm) then return
//copias = long(Message.StringParm)
// fin  copias


// Creamos el datastore
datastore ds
ds = create datastore
	
	// Hay que generar la nueva reclamacion
	tipo_reclamacion = idw_cartas.getitemString(row, 'tipo_reclamacion')
	
	// Colocamos el dw asociado al tipo de reclamacion en el datastore a imprimir
	dw = f_dame_dw_asociado_tipo_reclamacion(tipo_reclamacion)
	

	
	if f_es_vacio(dw) then return
	idw_visualizar.dataobject = dw
	idw_visualizar.settransobject (SQLCA)

	
	// Seg$$HEX1$$fa00$$ENDHEX$$n sea agrupada o sin agrupar hacemos una cosa u otra
	if f_reclamacion_agrupada(tipo_reclamacion) then
		ds.dataobject='d_reclamaciones_agrupadas'
		ds.settransobject (SQLCA)
		string ls_prueba
	ls_prueba = ds.object.dw_detalle.dataobject
	
	
		id_factura = idw_cartas.getitemString(row, 'id_factura')
		id_grupo = idw_cartas.getitemString(row, 'id_grupo')
		//Modificamos el report con el dw asociado a la agrupaci$$HEX1$$f300$$ENDHEX$$n
		ds.object.dw_aviso.dataobject=dw
		//idw_visualizar.Modify("dw_aviso.DataObject="+ dw)
		//idw_visualizar.retrieve(id_factura)
		ds.retrieve(id_factura)
//		// Las recorremos para imprimirlas
//		for k = 1 to copias
//			if ds.rowcount()>0 then ds.print()
//		next
		// Agregamos todas las facturas del grupo para imprimir el listado
		lista_ids = "'"+id_factura+"'"
		// Nos tenemos que saltar todas las facturas de este grupo
		DO WHILE row<idw_cartas.RowCount() 
			if f_es_vacio(idw_cartas.getitemString(row+1, 'id_grupo')) then exit
			if id_grupo<>idw_cartas.getitemString(row+1, 'id_grupo') then
				// Salimos del bucle
				exit
			else
				// Pasamos todas las que sean de este grupo
				if LenA(lista_ids)>0 then lista_ids += ", "
				id_factura = idw_cartas.getitemString(row+1, 'id_factura')
				lista_ids += "'"+id_factura+"'"
				row++
			end if
		LOOP
		// Cambiamos al listado de facturas e imprimimos este
		//ds.dataobject = 'd_reclamaciones_facturas_agrup_facts'	
		//ds.object.dw_detalle.dataobject = 'd_reclamaciones_facturas_agrup_facts'
		
//		ds.settransobject (SQLCA)
		ds.getchild('dw_detalle',dw_ch)
		//sql = ds.describe("datawindow.table.select")
		sql=dw_ch.describe("datawindow.table.select")
		
		// Anyadimos la condicion de las facturas
		sql += " AND csi_facturas_emitidas.id_factura in ("+lista_ids+")"		
		//ds.modify("datawindow.table.select= ~"" + sql + "~"")
		dw_ch.modify("datawindow.table.select= ~"" + sql + "~"")
		
		sql=dw_ch.describe("datawindow.table.select")
		//ds.retrieve()
		idw_visualizar.dataobject=ds.dataobject
		
//		for k = 1 to copias
//			if ds.rowcount()>0 then ds.print()
//		next
	else
		id_factura = idw_cartas.getitemString(row, 'id_factura')
		idw_visualizar.retrieve(id_factura)
		//ds.retrieve(id_factura)
		// Las recorremos para imprimirlas
		
	end if
//Modificamos el logo de la carta en funci$$HEX1$$f300$$ENDHEX$$n de la empresa
logo="'.\imagenes\" + g_logo_empresa + "'"
idw_visualizar.modify("p_logo.FileName=" + logo) 

f_logo_empresa(g_empresa ,idw_visualizar, '006')

idw_visualizar.visible=true
//idw_visualizar.of_SetPrintPreview(TRUE)
//idw_visualizar.event pfc_printpreview()
cb_ocultar.visible=true
	
	// Si nos hemos pasado de rango salimos
	//if row>idw_cartas.RowCount() then exit
// Destruimos el datastore
destroy ds
end subroutine

public function string wf_modifica_sql_consulta (string sql);string sql_aux,id_expedi,id_fase,dato
date dato_fecha

dw_consulta.accepttext()
f_sql('csi_facturas_emitidas.proforma','LIKE','proforma',dw_consulta,sql,'1','')		
f_sql('csi_facturas_emitidas.n_fact','LIKE','n_fact',dw_consulta,sql,'1','')
f_sql('csi_facturas_emitidas.fecha','>=','f_fact_prof_desde',dw_consulta,sql,'1','')
f_sql('csi_facturas_emitidas.fecha','<','f_fact_prof_hasta',dw_consulta,sql,'1','')
f_sql('csi_facturas_emitidas.n_col','=','n_col',dw_consulta,sql,'1','')
f_sql('csi_facturas_emitidas.nif','=','nif',dw_consulta,sql,'1','')
f_sql('csi_fact_reclamaciones.f_reclamacion','>=','f_carta_desde',dw_consulta,sql,'1','')
f_sql('csi_fact_reclamaciones.f_reclamacion','<','f_carta_hasta',dw_consulta,sql,'1','')


		
////expediente		
if not ( f_es_vacio(dw_consulta.getitemstring(1, 'n_exp'))) then
	id_expedi=f_dame_id_exp_de_n_exp(dw_consulta.getitemstring(1, 'n_exp'))
	
	sql_aux= "and (csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM expedientes, fases, fases_minutas WHERE expedientes.id_expedi = fases.id_expedi and fases_minutas.id_fase = fases.id_fase and expedientes.id_expedi='"+id_expedi+"') "
	sql_aux = sql_aux +" or csi_facturas_emitidas.id_minuta IN (SELECT id_fase FROM expedientes, fases WHERE expedientes.id_expedi = fases.id_expedi and expedientes.id_expedi='"+id_expedi+"'))"
	
	if not isnull(sql_aux) then sql += sql_aux		
end if
//
////registro
if not ( f_es_vacio(dw_consulta.getitemstring(1, 'n_reg'))) then
	id_fase=f_dame_id_fase_de_n_reg(dw_consulta.getitemstring(1, 'n_reg'))
	
	sql_aux = "and (csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM fases, fases_minutas WHERE fases_minutas.id_fase = fases.id_fase and fases.id_fase ='"+id_fase+"')"
	sql_aux = sql_aux + " or csi_facturas_emitidas.id_minuta IN (SELECT id_fase FROM fases WHERE fases.id_fase='"+id_fase+"'))"
	
	if not isnull(sql_aux) then sql += sql_aux	
end if
//tipo_reclamacion
if not (f_es_vacio(dw_consulta.getitemstring(1, 'tipo_reclamacion'))) then
	
	sql_aux = "and  (csi_fact_reclamaciones.tipo_reclamacion ='"+dw_consulta.getitemstring(1, 'tipo_reclamacion')+"')"
	if not isnull(sql_aux) then sql += sql_aux	
end if

return sql
end function

on w_reclamaciones_facturas_proformas.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_reclamacion_facturas" then this.MenuID = create m_reclamacion_facturas
this.dw_consulta=create dw_consulta
this.tab_1=create tab_1
this.cb_genera_cartas=create cb_genera_cartas
this.cb_imprimir_carta=create cb_imprimir_carta
this.cb_actualizar=create cb_actualizar
this.cb_ocultar=create cb_ocultar
this.st_previsualizar=create st_previsualizar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_consulta
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.cb_genera_cartas
this.Control[iCurrent+4]=this.cb_imprimir_carta
this.Control[iCurrent+5]=this.cb_actualizar
this.Control[iCurrent+6]=this.cb_ocultar
this.Control[iCurrent+7]=this.st_previsualizar
end on

on w_reclamaciones_facturas_proformas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_consulta)
destroy(this.tab_1)
destroy(this.cb_genera_cartas)
destroy(this.cb_imprimir_carta)
destroy(this.cb_actualizar)
destroy(this.cb_ocultar)
destroy(this.st_previsualizar)
end on

event open;call super::open;idw_facturas 	= tab_1.tabpage_1.dw_facturas
idw_proformas = tab_1.tabpage_1.dw_proformas
idw_cartas = tab_1.tabpage_2.dw_cartas
idw_visualizar = tab_1.tabpage_2.dw_visualizar
inv_resize.of_Register(tab_1,"ScaletoRight&Bottom")
inv_resize.of_Register (idw_cartas, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_visualizar, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_facturas, "ScaletoRight")
inv_resize.of_Register (idw_proformas, "ScaletoRight")
inv_resize.of_Register(cb_genera_cartas,"FixedtoBottom")
inv_resize.of_Register(cb_imprimir_carta,"FixedtoBottom")
inv_resize.of_Register(cb_actualizar,"FixedtoBottom")
inv_resize.of_Register(cb_ocultar,"FixedtoBottom")
inv_resize.of_Register (dw_consulta, "ScaletoRight")




dw_consulta.insertrow(0)

// Nos guardamos la sql original
//isql_original = dw_facturas.describe("datawindow.table.select")

end event

event type integer csd_nuevo();// Sobreescrito
return -1

end event

event pfc_postopen;call super::pfc_postopen;long k,j

long tab_height

k=104


//Pondremos los dw con el mismo tama$$HEX1$$f100$$ENDHEX$$o y acupando todo el tab
tab_height=tab_1.height - k - 20
tab_height = tab_height / 2

idw_proformas.height=tab_height

tab_height=tab_height + 1 
idw_facturas.Y=tab_height
idw_facturas.height=tab_height
end event

event pfc_preupdate;call super::pfc_preupdate;int i 
//cb_actualizar.enabled=false
for i=1 to idw_cartas.rowcount()
	idw_cartas.setitem(i, 'id_reclamacion_factura', f_siguiente_numero('RECLAM_FACT', 10))
next
return 1
//idw_cartas.update()

end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_reclamaciones_facturas_proformas
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_reclamaciones_facturas_proformas
end type

type cb_nuevo from w_detalle`cb_nuevo within w_reclamaciones_facturas_proformas
end type

type cb_ayuda from w_detalle`cb_ayuda within w_reclamaciones_facturas_proformas
end type

type cb_grabar from w_detalle`cb_grabar within w_reclamaciones_facturas_proformas
end type

type cb_ant from w_detalle`cb_ant within w_reclamaciones_facturas_proformas
end type

type cb_sig from w_detalle`cb_sig within w_reclamaciones_facturas_proformas
end type

type dw_1 from w_detalle`dw_1 within w_reclamaciones_facturas_proformas
boolean visible = false
integer x = 119
integer y = 724
integer width = 3104
integer height = 856
string dataobject = "d_reclamaciones_facturas_generacion"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event dw_1::csd_retrieve;call super::csd_retrieve;/*if f_es_vacio(g_reclamaciones_facturas.consulta) then return


// Tenemos la consulta en la variable global, solo tenemos que sacar el where
long pos, pos_nueva
string consulta, sql_nuevo, sql_original

pos = PosA(g_reclamaciones_facturas.consulta, "WHERE")
if ib_consulta_ventana then pos = 1

// Sacamos la parte del where
if pos >0 then
	if not ib_consulta_ventana then
		consulta = MidA(g_reclamaciones_facturas.consulta, pos, LenA(g_reclamaciones_facturas.consulta))
		// Concatenamos esta consulta a nuestro dw
		// 	 SCP-601
		pos = PosA(g_reclamaciones_facturas.consulta, "FROM")
		consulta="id_factura in (Select id_factura "+MidA(g_reclamaciones_facturas.consulta, pos, LenA(g_reclamaciones_facturas.consulta))+")"
	
		//
		sql_nuevo = dw_facturas.describe("datawindow.table.select")
		pos_nueva = PosA(sql_nuevo, "WHERE")
		if pos>0 then
			sql_nuevo = sql_nuevo+" and "+consulta
		else
			sql_nuevo = sql_nuevo+" where "+consulta
		end if
		
		//Andres: $$HEX1$$bf00$$ENDHEX$$Este es un buen sitio para a$$HEX1$$f100$$ENDHEX$$adir mi condicion?
		//..and where csi_facturas_emitidas.total>0
		dw_facturas.setredraw(false)	
		//Colocamos la nueva SQL

		dw_facturas.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
	end if
	// Retriveamos
	dw_facturas.retrieve()
	// Restauramos la SQL
	dw_facturas.modify("datawindow.table.select= ~"" + isql_original + "~"")
	
	long fila
	string id_factura, tipo_persona, remesada, tipo_reclamacion

	if dw_facturas.rowcount()<1 then 
		dw_facturas.setredraw(true)	
		return
	end if

	FOR fila = 1 TO dw_facturas.rowcount()
		id_factura = dw_facturas.getitemstring(fila, 'id_factura')
		tipo_persona = dw_facturas.getitemstring(fila, 'tipo_persona')
		remesada = f_dame_remesada_factura(id_factura)
		
		tipo_reclamacion = f_dame_reclamacion_siguiente(id_factura, tipo_persona, remesada)
		
		// Colocamos el tipo de 
		dw_facturas.setitem(fila, 'tipo_reclamacion', tipo_reclamacion)
		if tipo_reclamacion = 'NO' then dw_facturas.setitem(fila, 'generar_reclamacion', 'N')
		// Evitamos que casque luego... si no tiene valor le quitamos el check de generar reclamacion
		if f_es_vacio(tipo_reclamacion) then dw_facturas.setitem(fila, 'generar_reclamacion', 'N')
	NEXT
	//dw_facturas.sort()
	// Volvemos a permitir el redibujado
	dw_facturas.setredraw(true)	
	dw_1.reset()
end if



g_reclamaciones_facturas.consulta = ''*/
end event

type dw_consulta from u_dw within w_reclamaciones_facturas_proformas
integer x = 37
integer y = 20
integer width = 3561
integer height = 564
integer taborder = 30
string title = "none"
string dataobject = "d_reclamaciones_consulta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event buttonclicked;call super::buttonclicked;string id_colegiado,col,id_persona,nif,agrupar
datawindowchild dwc_cartas_facturas
datawindowchild dwc_cartas_proforma

CHOOSE CASE dwo.name
	CASE	'b_nif'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Clientes de Expedientes"
		g_busqueda.dw="d_lista_busqueda_clientes"
		id_persona=f_busqueda_clientes_exp()
		if id_persona="-1" then
				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de cliente v$$HEX1$$e100$$ENDHEX$$lido.')
				this.setfocus()
				return -1
		else
			nif = f_dame_nif(id_persona)
			this.SetItem(1,'nif',nif)
			this.SetItem(1,'nombre_clie',f_dame_cliente(id_persona))
		end if
	CASE 'b_col'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		
		id_colegiado=f_busqueda_colegiados()
		this.setitem(1,'n_col',f_colegiado_n_col(id_colegiado))
		this.setitem(1,'nombre_col',f_colegiado_apellido( id_colegiado ))

	CASE 'b_buscar'
		//En una nueva busqueda reseteamos todos los objetos
		st_previsualizar.visible=false	
		idw_visualizar.visible=false
		cb_ocultar.visible=false
		cb_actualizar.enabled=false
		cb_imprimir_carta.enabled=false
		idw_cartas.reset()
		idw_facturas.reset()
		idw_proformas.reset()
		//Distinci$$HEX1$$f300$$ENDHEX$$n si la b$$HEX1$$fa00$$ENDHEX$$squeda es para generar nuevas cartas o para consultar
		if this.getitemstring(1,'cons_gen')='G' then
			tab_1.selecttab("tabpage_1")
			cb_genera_cartas.enabled=true
			if g_tipo_notificacion='I' then
				//Modificamos el desplegable de notificaciones
				idw_proformas.object.tipo_recla_siguiente_no_agrup.visible=true
				idw_facturas.object.tipo_recla_siguiente_no_agrup.visible=true	
				parent.event csd_obtener_fact_prof()
			elseif g_tipo_notificacion='A' then
				//Modificamos el desplegable de notificaciones
				idw_proformas.object.tipo_recla_siguiente_agrup.visible=true
				idw_facturas.object.tipo_recla_siguiente_agrup.visible=true
				parent.event csd_obtener_fact_prof_agrupadas()
			end if
		else
			
			cb_genera_cartas.enabled=false
			idw_cartas.reset()
			idw_facturas.reset()
			idw_proformas.reset()
			parent.event csd_consulta_fact_prof()
			if g_tipo_notificacion='A' then
				st_previsualizar.visible=true
				idw_cartas.object.b_visualizar.visible=false
			end if
			tab_1.selecttab("tabpage_2")
		end if
			
end choose
end event

event itemchanged;call super::itemchanged;choose case dwo.name
		case 'cons_gen'
			idw_cartas.reset()
			idw_facturas.reset()
			idw_proformas.reset()
			if data='C' then
				dw_consulta.object.gb_1.text='Consulta de Cartas'
				tab_1.tabpage_1.visible=false
				tab_1.tabpage_2.text='Hist$$HEX1$$f300$$ENDHEX$$tico de Cartas Generadas'
				tab_1.selecttab("tabpage_2")
				cb_genera_cartas.enabled=false
			else
				dw_consulta.object.gb_1.text='Generaci$$HEX1$$f300$$ENDHEX$$n de Cartas'	
				tab_1.tabpage_2.text='Cartas Generadas'
				tab_1.tabpage_1.visible=true
				tab_1.selecttab("tabpage_1")
			end if
		case 'n_col'
			if f_es_vacio(data) then this.setitem(1,'nombre_col','')
		case 'nif'
			if f_es_vacio(data) then this.setitem(1,'nombre_clie','')
	end choose
end event

type tab_1 from tab within w_reclamaciones_facturas_proformas
integer x = 14
integer y = 600
integer width = 4082
integer height = 1564
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4046
integer height = 1448
long backcolor = 79741120
string text = "Registros a procesar"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_proformas dw_proformas
dw_facturas dw_facturas
end type

on tabpage_1.create
this.dw_proformas=create dw_proformas
this.dw_facturas=create dw_facturas
this.Control[]={this.dw_proformas,&
this.dw_facturas}
end on

on tabpage_1.destroy
destroy(this.dw_proformas)
destroy(this.dw_facturas)
end on

type dw_proformas from u_dw within tabpage_1
integer x = 9
integer y = 4
integer width = 3977
integer height = 724
integer taborder = 10
string title = "none"
string dataobject = "d_reclamaciones_proformas"
boolean ib_isupdateable = false
end type

type dw_facturas from u_dw within tabpage_1
integer x = 5
integer y = 744
integer width = 3982
integer height = 704
integer taborder = 10
string title = "none"
string dataobject = "d_reclamaciones_facturas"
boolean ib_isupdateable = false
end type

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4046
integer height = 1448
long backcolor = 79741120
string text = "Cartas Generadas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_visualizar dw_visualizar
dw_cartas dw_cartas
end type

on tabpage_2.create
this.dw_visualizar=create dw_visualizar
this.dw_cartas=create dw_cartas
this.Control[]={this.dw_visualizar,&
this.dw_cartas}
end on

on tabpage_2.destroy
destroy(this.dw_visualizar)
destroy(this.dw_cartas)
end on

type dw_visualizar from u_dw within tabpage_2
boolean visible = false
integer x = 5
integer width = 3982
integer height = 1436
integer taborder = 11
string dataobject = "d_reclamaciones_agrupadas"
end type

event constructor;call super::constructor;of_SetPrintPreview(TRUE)
of_setSort(true)
inv_sort.of_SetColumnHeader (true)
this.inv_sort.of_SetStyle(this.inv_sort.DRAGDROP)
end event

type dw_cartas from u_dw within tabpage_2
integer width = 3991
integer height = 1420
integer taborder = 10
string title = "none"
string dataobject = "d_reclamaciones_fact_prof_lista"
end type

event buttonclicked;call super::buttonclicked;CHOOSE CASE dwo.name
	case 'b_imprimir'
		wf_imprimir_una_carta(row)
	case 'b_visualizar'
		wf_visualizar_una_carta(row)
		
		
end choose
end event

event constructor;call super::constructor;if g_tipo_notificacion='A' then
	this.dataobject='d_reclamacion_fact_prof_lista_agr'
end if
this.SetTransobject(sqlca)
end event

type cb_genera_cartas from commandbutton within w_reclamaciones_facturas_proformas
integer x = 137
integer y = 2192
integer width = 594
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "Generar Cartas"
end type

event clicked;int i
string grupo,grupo_ant
grupo_ant=''
idw_cartas.reset()
event csd_genera_carta_proforma()
event csd_genera_carta_facturas()
if idw_cartas.rowcount() > 0 then
	if g_tipo_notificacion='A' then
		st_previsualizar.visible=true
		idw_cartas.object.b_visualizar.visible=false
	end if
	//idw_cartas.SetRedraw(false)
	idw_cartas.sort()
	idw_cartas.GroupCalc()	
	cb_genera_cartas.enabled=false
	cb_actualizar.enabled=true
	cb_imprimir_carta.enabled=true	
	idw_cartas.SetRedraw(true)
	tab_1.selecttab("tabpage_2")
end if
	
end event

type cb_imprimir_carta from commandbutton within w_reclamaciones_facturas_proformas
integer x = 1509
integer y = 2192
integer width = 594
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "Imprimir Cartas"
end type

event clicked;wf_imprimir_cartas()
end event

type cb_actualizar from commandbutton within w_reclamaciones_facturas_proformas
integer x = 814
integer y = 2192
integer width = 594
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
boolean enabled = false
string text = "Actualizar Cartas"
end type

event clicked;int i 
cb_actualizar.enabled=false
for i=1 to idw_cartas.rowcount()
	idw_cartas.setitem(i, 'id_reclamacion_factura', f_siguiente_numero('RECLAM_FACT', 10))
next
idw_cartas.update()

end event

type cb_ocultar from commandbutton within w_reclamaciones_facturas_proformas
boolean visible = false
integer x = 2853
integer y = 2192
integer width = 549
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Ocultar Vista Previa"
end type

event clicked;idw_visualizar.visible=false
this.visible=false

end event

type st_previsualizar from statictext within w_reclamaciones_facturas_proformas
boolean visible = false
integer x = 1394
integer y = 596
integer width = 2112
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
string text = "Para previsualizar las cartas deber$$HEX2$$e1002000$$ENDHEX$$imprimirla en PDF"
alignment alignment = center!
boolean focusrectangle = false
end type

