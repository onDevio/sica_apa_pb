HA$PBExportHeader$w_reg_es_emision_certificados.srw
forward
global type w_reg_es_emision_certificados from w_response
end type
type cb_1 from commandbutton within w_reg_es_emision_certificados
end type
type cb_2 from commandbutton within w_reg_es_emision_certificados
end type
type dw_consulta from u_dw within w_reg_es_emision_certificados
end type
type dw_lista from u_dw within w_reg_es_emision_certificados
end type
type dw_parametros from u_dw within w_reg_es_emision_certificados
end type
type cb_pdf from commandbutton within w_reg_es_emision_certificados
end type
type cb_emitir from commandbutton within w_reg_es_emision_certificados
end type
type cb_3 from commandbutton within w_reg_es_emision_certificados
end type
type cb_pedir from commandbutton within w_reg_es_emision_certificados
end type
end forward

global type w_reg_es_emision_certificados from w_response
integer width = 3712
integer height = 1956
event csd_generar_registro_entrada ( )
event csd_generar_registro_salida ( string entrada )
event type integer csd_rellenar_marcadores ( ref datastore ds_campos,  string cod_plantilla )
event csd_rellenar_plantilla ( datastore ds_campos,  string plantilla )
cb_1 cb_1
cb_2 cb_2
dw_consulta dw_consulta
dw_lista dw_lista
dw_parametros dw_parametros
cb_pdf cb_pdf
cb_emitir cb_emitir
cb_3 cb_3
cb_pedir cb_pedir
end type
global w_reg_es_emision_certificados w_reg_es_emision_certificados

type variables

st_datos_registros ist_datos
string is_plantilla, is_asistente,is_ult_consulta=""

end variables

forward prototypes
public subroutine f_anyadir_campo (ref datastore ds_campos, string campo_word, string campo_dw)
end prototypes

event csd_generar_registro_entrada();datastore ds_registro,ds_reg_anexo
long fila,res,numero
string poblacion,apellidos,id_reg
string param1,param2
string n_col,id_col,n_reg,serie
string plantilla,codigo_plantilla,asunto
// GENERACION DEL REGISTRO DE SALIDA

//El registro ya existe
if not(f_es_vacio(dw_consulta.getitemstring(1,'n_registro')))then
	n_reg =	dw_consulta.getitemstring(1,'n_registro')
	select count(*) into :numero from registro where n_registro = :n_reg;
	select asunto into :asunto from registro where n_registro = :n_reg;
	if( numero > 0 )then
		codigo_plantilla=dw_consulta.GetItemString(1,'tipo_cert')
		select descripcion into :plantilla from plantillas where codigo=:codigo_plantilla;
		if f_es_vacio(asunto) then
			asunto = codigo_plantilla
		else
			asunto = codigo_plantilla + ' - '+asunto
		end if
		update registro set asunto  = :asunto, tipo_comunicado = 'E' where n_registro = :n_reg;
		MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Petici$$HEX1$$f300$$ENDHEX$$n realizada sobre el registro de entrada "+n_reg+".")
		return
	end if
end if

ds_registro=create datastore
ds_registro.dataobject='d_registros_detalle'
ds_registro.SetTransObject(SQLCA)
fila=ds_registro.insertrow(0)

id_reg=f_siguiente_numero('REGISTROS',10)
ds_registro.SetItem(fila,'id_registro',id_reg)
ds_registro.setitem(fila, 'fecha', datetime(Today()) )
ds_registro.setitem(fila, 'fecha_grabacion', datetime(Today()) )
ds_registro.setitem(fila, 'tipo_comunicado', 'E' )
//Cambio Luis
if lower(dw_consulta.describe("f_escrito.name")) = 'f_escrito' then
	if not(f_es_vacio(string(dw_consulta.getitemdatetime(1,'f_escrito'))))then
		ds_registro.setitem(fila, 'f_escrito', dw_consulta.getitemdatetime(1,'f_escrito') )
	else
		ds_registro.setitem(fila, 'f_escrito', datetime(Today()) )
	end if
end if

codigo_plantilla=dw_consulta.GetItemString(1,'tipo_cert')
select descripcion into :plantilla from plantillas where codigo=:codigo_plantilla;

asunto = codigo_plantilla + ' - Petici$$HEX1$$f300$$ENDHEX$$n '+plantilla
//n_col=dw_consulta.GetItemString(1,'tipo_cert')
//select id_colegiado into :id_col from colegiados where n_colegiado=:n_col;
id_col=dw_consulta.GetItemString(1,'id_colegiado')
if f_es_vacio(id_col) then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","El Colegiado no existe")
	return
end if
select param1,param2 into :param1,:param2 from t_control_eventos where control='REMITENTE' and evento='REGISTRO_CAMBIO_ES';
ds_registro.setitem(fila, 'tipo_persona_o','C')
ds_registro.setitem(fila, 'id_o',id_col)
ds_registro.setitem(fila, 'codigo_o',f_colegiado_n_col(id_col))
ds_registro.setitem(fila, 'nombre_o', f_colegiado_certificados(id_col))
SELECT domicilios.cod_pob  INTO :poblacion  
FROM domicilios  WHERE domicilios.id_colegiado like :id_col   ;
ds_registro.setitem(fila,'poblacion_o',poblacion)	
ds_registro.setitem(fila, 'cp_o', f_devuelve_cod_postal(param2))
ds_registro.setitem(fila, 'asunto',asunto)
ds_registro.setitem(fila, 'cod_delegacion', g_cod_delegacion )
ds_registro.setitem(fila, 'es','E')
ds_registro.setitem(fila, 'oficial','N')

ds_registro.setitem(fila, 'tipo_persona_d','O')
ds_registro.setitem(fila,'codigo_d','')
ds_registro.setitem(fila,'nombre_d',param1)
ds_registro.setitem(fila, 'cp_d', f_devuelve_cod_postal(param2))
ds_registro.setitem(fila, 'poblacion_d', param2)


//n_reg_salida=serie+'-'+f_siguiente_numero_reg_es(serie,10)
st_control_eventos c_evento 
c_evento.evento = 'REGISTRO_ES'
f_control_eventos(c_evento)

serie='RE'
n_reg=serie+'-'+f_numera_reg_salida(c_evento.param1,serie)
ds_registro.SetItem(fila, 'n_registro',n_reg)

ds_registro.setitem(fila, 'empresa','01')
ds_registro.setitem(fila, 'serie',serie)
res=ds_registro.update()
if res>0 then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Petici$$HEX1$$f300$$ENDHEX$$n realizada.Se ha creado el registro de entrada "+n_reg+".")
else
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al realizar la petici$$HEX1$$f300$$ENDHEX$$n.",StopSign!)
end if
end event

event csd_generar_registro_salida(string entrada);datastore ds_registro,ds_reg_anexo
long fila,res
string poblacion,apellidos,id_reg
string param1,param2,asunto
string n_col,id_col,n_reg,serie,reg_entrada
datetime hoy,f_entrada

// GENERACION DEL REGISTRO DE SALIDA
hoy=datetime(today(),now())
// Obtenemos el id_colegiado solicitante
id_col=dw_lista.GetItemString(dw_lista.GetRow(),'id_o')
asunto = dw_lista.GetItemString(dw_lista.GetRow(),'asunto')
reg_entrada = dw_lista.GetItemString(dw_lista.GetRow(),'n_registro')
f_entrada = dw_lista.GetItemDateTime(dw_lista.GetRow(),'fecha')
n_col = f_colegiado_n_col(id_col)

ds_registro=create datastore
ds_registro.dataobject='d_registros_detalle'
ds_registro.SetTransObject(SQLCA)
fila=ds_registro.insertrow(0)

id_reg=f_siguiente_numero('REGISTROS',10)
ds_registro.SetItem(fila,'id_registro',id_reg)
ds_registro.setitem(fila, 'fecha', datetime(Today()) )
ds_registro.setitem(fila, 'fecha_grabacion', datetime(Today()) )
ds_registro.setitem(fila, 'f_escrito', datetime(Today()) )
ds_registro.setitem(fila, 'cod_delegacion', g_cod_delegacion )
ds_registro.setitem(fila, 'es','S')
ds_registro.setitem(fila, 'oficial','N')
ds_registro.setitem(fila, 'asunto',asunto)
ds_registro.setitem(fila, 'n_registro_ref',reg_entrada)
ds_registro.setitem(fila, 'tipo_comunicado', 'E' )

select param1,param2 into :param1,:param2 from t_control_eventos where control='REMITENTE' and evento='REGISTRO_CAMBIO_ES';
ds_registro.setitem(fila, 'tipo_persona_o','O')
ds_registro.setitem(fila,'codigo_o','')
ds_registro.setitem(fila,'nombre_o',param1)
ds_registro.setitem(fila, 'cp_o', f_devuelve_cod_postal(param2))
ds_registro.setitem(fila, 'poblacion_o', param2)
ds_registro.setitem(fila, 'empresa','01')
ds_registro.setitem(fila, 'tipo_persona_d','C')
ds_registro.setitem(fila, 'id_d',id_col)
ds_registro.setitem(fila, 'codigo_d',f_colegiado_n_col(id_col))
ds_registro.setitem(fila, 'nombre_d', f_colegiado_certificados(id_col))
SELECT domicilios.cod_pob  INTO :poblacion  
FROM domicilios  WHERE domicilios.id_colegiado like :id_col   ;
ds_registro.setitem(fila,'poblacion_d',poblacion)	
ds_registro.setitem(fila, 'cp_d', f_devuelve_cod_postal(param2))


serie=dw_consulta.GetItemString(1,'serie')
ist_datos.serie=serie
st_control_eventos c_evento 
c_evento.evento = 'REGISTRO_ES'
f_control_eventos(c_evento)

n_reg=serie+'-'+f_numera_reg_salida(c_evento.param1,serie)
ds_registro.SetItem(fila, 'n_registro',n_reg)

ist_datos.n_reg_entrada=reg_entrada
ist_datos.n_reg_salida=n_reg
ist_datos.f_reg_salida=hoy
ist_datos.f_reg_entrada=f_entrada
ist_datos.n_col=n_col

ds_registro.setitem(fila, 'serie',serie)
res=ds_registro.update()
if res>0 then	
	update registro set f_salida=:hoy,salida='S',n_registro_ref=:n_reg where n_registro=:reg_entrada;
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Petici$$HEX1$$f300$$ENDHEX$$n realizada.Se ha creado el registro de salida "+n_reg+".")
else
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al realizar la petici$$HEX1$$f300$$ENDHEX$$n.",StopSign!)
end if


end event

event type integer csd_rellenar_marcadores(ref datastore ds_campos, string cod_plantilla);datastore ds_lista,ds_cli
string sql,id_col_o,visados,texto,domicilio,n_consejo,orden,n_vis,d_t_act,t_act_ant,clientes='',nom='',ape='',sql_parcial
string curso,horas
datetime f_ini,f_fin
datetime f_desde,f_hasta,f_Colegiacion,f_nacimiento,f_visado,f_visado_ant
long i,fila,j
dw_parametros.AcceptText()


f_desde=dw_parametros.GetItemDateTime(1,'f_desde')
f_hasta=dw_parametros.GetItemDateTime(1,'f_hasta')
id_col_o=dw_lista.GetItemString(dw_lista.GetRow(),'id_o')

if IsNull(f_desde) then f_desde=datetime(today())
if IsNull(f_hasta) then f_hasta=datetime(today())

string n_col,tel1,nif,tipo_via,nom_via,poblacion,src_alta,escuela,folio_min,folio_es
datetime f_registro_min,f_registro_es
double prima,bonus_malus

select c.n_colegiado,c.nif,c.telefono_1,d.tipo_via,d.nom_via,p.descripcion,n_consejo,f_colegiacion,f_nacimiento,cons_escuela_final,cons_fecha_regm,cons_fecha_rege,cons_folio_m,cons_fecha_documento
into :n_col,:nif,:tel1,:tipo_via,:nom_via,:poblacion,:n_consejo,:f_colegiacion,:f_nacimiento,:escuela,:f_registro_min,:f_registro_es,:folio_min,:folio_es
from colegiados c,domicilios d,poblaciones p
where c.id_colegiado=:id_col_o and c.id_colegiado=d.id_colegiado and d.profesional='S' and d.cod_pob=p.cod_pob;

select m.src_alta,c.prima,m.src_coef_cm into :src_alta,:prima,:bonus_malus
from musaat m,musaat_cober_src c 
where m.id_col=:id_col_o and m.src_cober=c.codigo;

if src_alta='S' then
	src_alta='SI'
else
	src_alta='NO'
end if

if IsNull(tipo_via) then tipo_via=''
domicilio=tipo_via+' '+nom_via+' - '+poblacion
fila=dw_lista.GetRow()
for i=1 to 7
	f_anyadir_campo(ds_campos,'secretario'+string(i),f_devuelve_secretario())
	f_anyadir_campo(ds_campos,'colegiado_nombre'+string(i),dw_lista.GetItemString(fila,'nombre_o'))
	f_anyadir_campo(ds_campos,'f_reg_entrada'+string(i),string(ist_datos.f_reg_entrada,'dd/mm/yyyy'))
	f_anyadir_campo(ds_campos,'n_reg_entrada'+string(i),ist_datos.n_reg_entrada)
	f_anyadir_campo(ds_campos,'f_reg_salida'+string(i),string(ist_datos.f_reg_salida,'dd/mm/yyyy'))
	f_anyadir_campo(ds_campos,'n_reg_salida'+string(i),ist_datos.n_reg_salida)
	f_anyadir_campo(ds_campos,'fecha_letras_n'+string(i),f_fecha_en_letras(datetime(today()),'n'))
	f_anyadir_campo(ds_campos,'f_desde'+string(i),string(f_desde,'dd/mm/yyyy'))
	f_anyadir_campo(ds_campos,'f_hasta'+string(i),string(f_hasta,'dd/mm/yyyy'))
	f_anyadir_campo(ds_campos,'dni'+string(i),nif)
	f_anyadir_campo(ds_campos,'n_col'+string(i),n_col)	
	f_anyadir_campo(ds_campos,'telefono'+string(i),tel1)		
	f_anyadir_campo(ds_campos,'domicilio'+string(i),domicilio)		
	f_anyadir_campo(ds_campos,'garantia'+string(i),string(prima))		
	f_anyadir_campo(ds_campos,'src'+string(i),src_alta)	
	f_anyadir_campo(ds_campos,'siniestralidad'+string(i),string(bonus_malus))	
	f_anyadir_campo(ds_campos,'n_nacional'+string(i),n_consejo)	
	f_anyadir_campo(ds_campos,'f_colegiacion'+string(i),string(f_colegiacion,'dd/mm/yyyy'))
	f_anyadir_campo(ds_campos,'f_nacimiento'+string(i),string(f_nacimiento,'dd/mm/yyyy'))	
	
	f_anyadir_campo(ds_campos,'cons_escuela_final'+string(i),escuela)	
	f_anyadir_campo(ds_campos,'folio_min'+string(i),folio_min)	
	f_anyadir_campo(ds_campos,'folio_es'+string(i),folio_es)	
	f_anyadir_campo(ds_campos,'cons_fecha_doc'+string(i),string(f_registro_es,'dd/mm/yyyy'))	
	f_anyadir_campo(ds_campos,'cons_fecha_min'+string(i),string(f_registro_min,'dd/mm/yyyy'))		
	
next


choose case cod_plantilla
	case 'ES00000001'
		f_desde=dw_parametros.GetItemDateTime(1,'f_desde')
		f_desde=dw_parametros.GetItemDateTime(1,'f_hasta')		
		orden=dw_parametros.GetItemString(1,'orden')				
		if IsNull(f_desde) or isNull(f_hasta) then
			MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n", "Debe introducir un intervalo de fechas para emitir el certificado")
			return -1
		end if
		ds_lista=create datastore
		ds_lista.dataobject='d_fases_lista'
		ds_lista.SetTransObject(SQLCA)
		ds_cli= create datastore
		ds_cli.dataobject='d_fases_clientes'
		ds_cli.SetTransObject(SQLCA)
		sql=ds_lista.GetSQLSelect()
		if pos(upper(sql),'WHERE')>0 then
			sql+=" and fases_colegiados.id_col = '"+id_col_o+"' "
		else
			sql+=" WHERE fases_colegiados.id_col = '"+id_col_o+"' "	
		end if
		f_sql('fases.f_entrada','>=','f_desde',dw_parametros,sql,g_tipo_base_datos,'')
		f_sql('fases.f_entrada','<=','f_hasta',dw_parametros,sql,g_tipo_base_datos,'')
		//f_sql('fases.estado','like','estado',dw_parametros,sql,g_tipo_base_datos,'')
		f_sql('fases.fase','like','tipo_act',dw_parametros,sql,g_tipo_base_datos,'')
		
		sql_parcial=''
		if dw_parametros.GetItemString(1,'estado')='E' then
			sql_parcial= "fases.estado not in ('06','07')"
			if pos(upper(sql),'WHERE')>0 then
				sql+=' AND '+sql_parcial
			else
				sql+=' WHERE '+sql_parcial
			end if
		end if		
		ds_lista.SetSQLSelect(sql)		
		ds_lista.retrieve()


		if orden='F' then
			ds_lista.SetSort('fases_f_visado A')
		else		
			ds_lista.SetSort('fase A')
		end if
		
		ds_lista.Sort()

		visados=''
		
		string descrip,emplaz,id_fase,n_calle,tipo_act,estado
		double pres_seguridad,pem,sup_viv,sup_garaje,sup_otros,sup
		t_act_ant=''
		for i=1 to ds_lista.rowcount()
			clientes=''
			id_fase=ds_lista.GetItemString(i,'id_fase')
			descrip=ds_lista.GetItemString(i,'descripcion')
			tipo_via=ds_lista.GetItemString(i,'fases_tipo_via_emplazamiento')
			emplaz=ds_lista.GetItemString(i,'fases_emplazamiento')
			n_calle=ds_lista.GetItemString(i,'fases_n_calle')
			poblacion=ds_lista.GetItemString(i,'poblaciones_descripcion')
			f_visado=datetime(date(ds_lista.GetItemDateTime(i,'fases_f_visado')))
			tipo_act=ds_lista.GetItemString(i,'fase')
			estado=ds_lista.GetItemString(i,'estado')
			n_vis=ds_lista.GetItemString(i,'fases_archivo')
			select descripcion into :estado from expedientes_estado where cod_estado=:estado;
			if IsNull(tipo_via) then tipo_via='00'
			if IsNull(emplaz) then emplaz=''	
			if IsNull(poblacion) then poblacion=''
			if IsNull(n_calle) then n_calle=''
			if IsNull(pem) then pem=0
			if IsNull(pres_seguridad) then pres_seguridad=0
			if IsNull(n_vis) then n_vis=''			
			If IsNull(f_visado) then f_visado=datetime(date('1/1/1900'))
			If IsNull(descrip) then descrip=''
			
			if tipo_via<>'00' then emplaz=tipo_via+' '+emplaz
			if not(f_es_vacio(n_calle)) then emplaz+=', '+n_calle
			select d_t_descripcion into :d_t_act from t_fases where c_t_fase=:tipo_act;
			select pem,pres_seguridad,sup_viv,sup_otros,sup_garage into :pem,:pres_seguridad,:sup_viv,:sup_otros,:sup_garaje
			from fases_usos where id_fase=:id_fase;
			if IsNull(sup_viv) then sup_viv=0
			if IsNull(sup_garaje) then sup_garaje=0
			if IsNull(sup_otros) then sup_otros	=0	
			sup=sup_viv+sup_garaje+sup_otros
			
			visados+='~n'
			if orden='F' then
				if f_visado<>f_visado_ant then visados+='~nFECHA VISADO: '+string(f_visado,'dd/mm/yy')+'~n~n'
			else
				if tipo_act<>t_act_ant then visados+='~nTIPO DE INTERVENCION '+tipo_act+': '+d_t_act+'~n~n'
			end if
			

			ds_cli.retrieve(id_fase)

			for j=1 to ds_cli.rowcount()
				nom=ds_cli.GetItemString(j,'clientes_nombre')
				ape=ds_cli.GetItemString(j,'clientes_apellidos')

				if f_es_vacio(nom) then
					nom=ape
				else
					nom=nom+' '+ape
				end if
				if trim(nom)='FICTICIO' then 
					nom=''
				else
					clientes+=clientes+nom+', '
				end if

			next
			clientes=left(clientes,len(clientes) - 2)
			visados+='VISADO:'+n_vis+'~n'
			visados+='PROPIETARIO:'+clientes+'~n'			
			visados+='DESCRIPCION:'+descrip+'~n'
			visados+='EMPLAZAMIENTO:'+emplaz+' - '+poblacion+'~n'			
			visados+='PRESUPUESTO OBRA:'+string(pem,'#,##0.00$$HEX1$$ac20$$ENDHEX$$')+'~n'
			visados+='PRESUPUESTO SEGURIDAD:'+string(pres_seguridad,'#,##0.00$$HEX1$$ac20$$ENDHEX$$')+'~n'			
	
			t_act_ant=tipo_act
			f_visado_ant=datetime(date(f_visado))
		next
		f_anyadir_campo(ds_campos,'visados1',visados)
		f_anyadir_campo(ds_campos,'visados2',visados)
	case 'ES00000003','ES00000007'		
		texto=dw_parametros.GetItemString(1,'texto')
		f_anyadir_campo(ds_campos,'texto1',texto)
		f_anyadir_campo(ds_campos,'texto2',texto)		
	case 'XES00000005'
		st_certificado_fechas st_fechas
		st_fechas.colegiado_nombre = dw_lista.GetItemString(fila,'nombre_o')
		st_fechas.f_reg_entrada = string(ist_datos.f_reg_entrada,'dd/mm/yyyy')
		st_fechas.n_reg_entrada = ist_datos.n_reg_entrada
		st_fechas.n_reg_salida = ist_datos.n_reg_salida
		st_fechas.f_reg_salida = string(ist_datos.f_reg_salida,'dd/mm/yyyy')
		st_fechas.fecha_letras_n = f_fecha_en_letras(datetime(today()),'n')
		st_fechas.f_desde = string(f_desde,'dd/mm/yyyy')
		st_fechas.f_hasta = string(f_hasta,'dd/mm/yyyy')
		st_fechas.n_col = n_col
		

		OpenwithParm(w_certificado_curso_fechas, st_fechas)
	case 'ES00000005'
		f_desde=dw_parametros.GetItemDateTime(1,'f_desde')
		f_hasta=dw_parametros.GetItemDateTime(1,'f_hasta')		
		DECLARE variable CURSOR FOR  
		select distinct c.nombre,c.f_ini_curso,c.f_fin_curso,c.horas_curso from formacion_cursos c,formacion_asistentes a where c.id_curso=a.id_curso and
		(c.estado<>'02' or c.estado=null) and a.n_colegiado=:n_col and c.f_ini_curso>=:f_desde and c.f_ini_curso<=:f_hasta order by f_ini_curso;
		
		Open variable;		
		fetch variable into :curso,:f_ini,:f_fin,:horas;
		texto=''
		do while sqlca.sqlcode = 0
			if IsNull(curso) then curso=''
			If IsNull(horas) then horas='0'
			If IsNull(f_ini) then f_ini=datetime(date('1/1/1900'))
			texto+=trim(curso)+'~n'
			if IsNull(f_fin) or f_ini=f_fin then
				texto+='D$$HEX1$$ed00$$ENDHEX$$a '+string(f_ini,'dd/mm/yyyy')+'~n'
			else
				texto+='Desde '+string(f_ini,'dd/mm/yyyy')+' hasta '+string(f_fin,'dd/mm/yyyy')+'~n'
			end if				
			texto+=horas + ' horas lectivas'+'~n~n'
			fetch variable into :curso,:f_ini,:f_fin,:horas;
		loop
		if texto='' then texto='NO SE HAN ENCONTRADO CURSOS'
			
		close variable;
		f_anyadir_campo(ds_campos,'cursos1',texto)
		f_anyadir_campo(ds_campos,'cursos2',texto)
	case 'ES00000006'
		curso=dw_parametros.GetItemString(1,'curso')
		select distinct c.nombre,c.f_ini_curso,c.f_fin_curso,c.horas_curso 
		into :curso,:f_ini,:f_fin,:horas
		from formacion_cursos c,formacion_asistentes a 
		where c.id_curso=a.id_curso and a.n_colegiado=:n_col and c.codigo=:curso;
		
		for i=1 to 2
			f_anyadir_campo(ds_campos,'curso'+string(i),curso)
			f_anyadir_campo(ds_campos,'f_desde_curso'+string(i),string(f_ini,'dd/mm/yyyy'))
			f_anyadir_campo(ds_campos,'f_hasta_curso'+string(i),string(f_fin,'dd/mm/yyyy'))
			f_anyadir_campo(ds_campos,'horas_curso'+string(i),horas)
		next		
end choose

return 0
end event

event csd_rellenar_plantilla(datastore ds_campos, string plantilla);oleobject word
boolean proteccion
integer handle
long i,fila
string ruta_fichero
string asunto, ruta_reg_es,id_reg_salida,id_doc_modulo
datastore ds_reg_anexo,ds_doc_modulo
double tamanyo

//Creamos y conectamos el control word
try
	word = CREATE oleobject
	handle = word.ConnectToNewObject("word.application")
Catch (Throwable ProcessError)
	MessageBox("Error al crear el objeto Word","No se pudo crear el objeto Word. Compruebe que tenga instalado el Office 2000 o superior.",StopSign!)
	return
end try


ruta_fichero=g_directorio_rtf+plantilla
	
try
	word.Documents.Open(ruta_fichero)
	word.Application.Visible = True 
Catch (Throwable ProcessError1)
	MessageBox("Error al abrir el documento","No se encontr$$HEX2$$f3002000$$ENDHEX$$la plantilla word seleccionada.",StopSign!)
	return 
end try

try
//Hacemos la copia del fichero
   //word.ActiveDocument.SaveAs(g_directorio_temporal+plantilla)
	is_plantilla=plantilla	
catch (Throwable ProcessError2)
	MessageBox("Error al guardar el documento","No se pudo guardar el documento en "+g_directorio_temporal+plantilla,StopSign!)
	return 
end try

proteccion = false
If word.ActiveDocument.ProtectionType <> -1 Then
	proteccion = true
	word.ActiveDocument.Unprotect 
End If

string campo_word,campo_dw
long k,tam_bloque
string texto


for i=1 to ds_campos.rowcount()
	campo_word=ds_campos.GetItemString(i,'campo_word')	
	campo_dw=ds_campos.GetItemString(i,'campo_dw')	
	if IsNull(campo_dw) then campo_dw=''

	try
		if not word.ActiveDocument.Bookmarks.Exists(campo_word) then continue

		//Si se quiere hacer por Marcadores necesitamos las 2 l$$HEX1$$ed00$$ENDHEX$$neas siguientes
		word.Selection.Goto(True,0,0,campo_word)
		// ESCRIBIMOS EL TEXTO EN EL MARCADOR. 
		k=1
		tam_bloque=5000
		do
			texto=mid(campo_dw,k,tam_bloque)
			word.selection.TypeText(texto)
			k+=tam_bloque		
		loop while k<len(campo_dw)
	catch (Throwable ProcessError4)		
		continue
	end try

	//Si queremos hacerlo por sustituci$$HEX1$$f300$$ENDHEX$$n de cadenas... necesitamos la l$$HEX1$$ed00$$ENDHEX$$nea siguiente
	//	word.Selection.find.Execute(documento_etiqueta,False,False,False,False,False,True,1,False,texto,2)
next		

try
	//Guardamos todos los cambios
	if proteccion = true then
		word.ActiveDocument.Protect(2)
	end if
	 
catch (Throwable ProcessError3)
	MessageBox("Error al rellenar el formulario","No se pudo rellenar los marcadores. Compruebe que no se haya cerrado el word antes de su finalizacion",StopSign!)
	return 
end try	 

//Guardamos el documento word en la ruta del registro
ruta_reg_es = cb_pdf.event csd_obtener_ruta_pdf(ist_datos.n_reg_salida)
word.ActiveDocument.SaveAs(ruta_reg_es+plantilla)

// Desconectamos
word.DisconnectObject()

//destruimos el control
Destroy word

//Insertamos el documento en la pesta$$HEX1$$f100$$ENDHEX$$a anexos del regsitro de salida
id_doc_modulo = f_siguiente_numero('ID_DOC_MODULO',20)
select id_registro into :id_reg_salida from registro where n_registro=:ist_datos.n_reg_salida;
ds_reg_anexo=create datastore
ds_reg_anexo.dataobject='d_registros_anexos'
ds_reg_anexo.SetTransObject(SQLCA)
fila=ds_reg_anexo.insertrow(0)

ds_reg_anexo.SetItem(fila,'id_registro_anexo',f_siguiente_numero('REGISTROS_ANEXOS',10))
ds_reg_anexo.SetItem(fila,'id_registro',id_reg_salida)
ds_reg_anexo.SetItem(fila,'ruta',plantilla)	
ds_reg_anexo.SetItem(fila,'id_documento_modulo',id_doc_modulo)	
ds_reg_anexo.update()	

ds_doc_modulo=create datastore
ds_doc_modulo.dataobject='d_csd_doc_modulo'
ds_doc_modulo.SetTransObject(SQLCA)
fila=ds_doc_modulo.insertrow(0)

ds_doc_modulo.SetItem(fila,'id_documento_modulo',id_doc_modulo)
ds_doc_modulo.SetItem(fila,'id_tipo_modulo','REG_ES')
ds_doc_modulo.SetItem(fila,'id_modulo',id_reg_salida)
ds_doc_modulo.SetItem(fila,'f_activacion',datetime(today(),now()))
ds_doc_modulo.SetItem(fila,'anyo',string(year(today())))
ds_doc_modulo.SetItem(fila,'nombre_fichero',plantilla)
ds_doc_modulo.SetItem(fila,'id_usuario',g_usuario)
ds_doc_modulo.SetItem(fila,'visible_web','S')
//ds_doc_modulo.SetItem(fila,'tamanyo',tamanyo)
ds_doc_modulo.update()




end event

public subroutine f_anyadir_campo (ref datastore ds_campos, string campo_word, string campo_dw);long fila

fila=ds_campos.insertrow(0)
ds_campos.SetItem(fila,'campo_word',campo_word)
ds_campos.SetItem(fila,'campo_dw',campo_dw)

end subroutine

on w_reg_es_emision_certificados.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_consulta=create dw_consulta
this.dw_lista=create dw_lista
this.dw_parametros=create dw_parametros
this.cb_pdf=create cb_pdf
this.cb_emitir=create cb_emitir
this.cb_3=create cb_3
this.cb_pedir=create cb_pedir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_consulta
this.Control[iCurrent+4]=this.dw_lista
this.Control[iCurrent+5]=this.dw_parametros
this.Control[iCurrent+6]=this.cb_pdf
this.Control[iCurrent+7]=this.cb_emitir
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.cb_pedir
end on

on w_reg_es_emision_certificados.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_consulta)
destroy(this.dw_lista)
destroy(this.dw_parametros)
destroy(this.cb_pdf)
destroy(this.cb_emitir)
destroy(this.cb_3)
destroy(this.cb_pedir)
end on

event open;call super::open;dw_parametros.insertrow(0)

if right(g_directorio_rtf,1)<>'\' then g_directorio_rtf+='\'

datawindowchild dwc_serie
dw_consulta.GetChild('serie',dwc_serie)
dwc_serie.SetFilter("empresa = '"+g_empresa+"'")
dwc_serie.filter()		



end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_reg_es_emision_certificados
integer y = 1540
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_reg_es_emision_certificados
integer y = 1248
end type

type cb_1 from commandbutton within w_reg_es_emision_certificados
integer x = 18
integer y = 28
integer width = 343
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Petici$$HEX1$$f300$$ENDHEX$$n >> "
end type

event clicked;DataWindowChild dwc_plantilla
dw_consulta.visible=true
dw_consulta.reset()
dw_consulta.dataobject='d_reg_es_peticion_certificado'
dw_consulta.GetChild('tipo_cert',dwc_plantilla)
dwc_plantilla.SetTransObject(SQLCA)
dwc_plantilla.retrieve('REG_ES')
dw_consulta.insertrow(0)
dw_lista.visible=false
cb_pedir.visible=true
cb_emitir.visible=false

dw_consulta.of_SetDropDownCalendar(True)
dw_consulta.iuo_calendar.of_register(dw_consulta.iuo_calendar.DDLB)
dw_consulta.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_consulta.iuo_calendar.of_SetInitialValue(True)

end event

type cb_2 from commandbutton within w_reg_es_emision_certificados
integer x = 18
integer y = 152
integer width = 343
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Emisi$$HEX1$$f300$$ENDHEX$$n >>"
end type

event clicked;
	dw_consulta.visible=true
	dw_consulta.reset()
	dw_consulta.dataobject='d_reg_es_emision_certificado'
	dw_consulta.SetTRansObject(SQLCA)
	
	
	dw_consulta.of_SetDropDownCalendar(True)
	dw_consulta.iuo_calendar.of_register(dw_consulta.iuo_calendar.DDLB)
	dw_consulta.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
	dw_consulta.iuo_calendar.of_SetInitialValue(True)

	
	dw_consulta.insertrow(0)
	dw_lista.visible=true
	dw_lista.dataobject='d_reg_es_emision_certificado_lista'
	dw_lista.SetTRansObject(SQLCA)
	//dw_lista.retrieve()

	cb_pedir.visible=false
	cb_emitir.visible=true

end event

type dw_consulta from u_dw within w_reg_es_emision_certificados
boolean visible = false
integer x = 393
integer y = 28
integer width = 3273
integer height = 616
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_reg_es_emision_certificado"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event buttonclicked;call super::buttonclicked;string sql,sql_copia,id_col, id_reg, id_coleg, n_col, n_registro
datetime f_escrito
choose case dwo.name
	case 'b_buscar'
		this.accepttext()
		sql=dw_lista.GetSQLSelect()
		sql_copia=sql
		f_sql('registro.n_registro','LIKE','n_registro',dw_consulta,sql,g_tipo_base_datos,'')
		f_sql('registro.fecha','>=','fecha_desde',dw_consulta,sql,g_tipo_base_datos,'')
		f_sql('registro.fecha','<=','fecha_hasta',dw_consulta,sql,g_tipo_base_datos,'')
		f_sql('registro.salida','=','salida',dw_consulta,sql,g_tipo_base_datos,'')
		dw_lista.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
		dw_lista.SetTransobject(sqlca)
		//dw_lista.SetSQLSelect(sql)
		dw_lista.retrieve()
		is_ult_consulta=sql
		dw_lista.SetSQLSelect(sql_copia)		
case 'b_colegiado'
	  	g_busqueda.titulo=g_idioma.of_getmsg('colegiados.busqueda_rapido_col',"B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados")
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()   
		if NOT f_es_vacio(id_col)  then
			this.SetItem(1,'id_colegiado',id_col)
			this.setitem(1,'n_col',f_colegiado_n_col(id_col))
		end if
case 'b_registro'
	  	g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Registros"
		g_busqueda.dw="d_lista_busqueda_registros"
		g_busqueda.param1='E'
		id_reg=f_busqueda_registros()   
		g_busqueda.param1=''
		if NOT f_es_vacio(id_reg)  then
			select n_registro,id_o,codigo_o, f_escrito into :n_registro,:id_coleg,:n_col,:f_escrito from registro where id_registro = :id_reg;
			this.SetItem(1,'n_registro',n_registro)
			this.SetItem(1,'id_colegiado',id_coleg)
			this.setitem(1,'n_col',n_col)
			this.setitem(1,'f_escrito',f_escrito)
		end if
end choose

end event

event itemchanged;call super::itemchanged;string id_col,n_col

choose case dwo.name
	case 'n_col'
		n_col=data
		if f_es_vacio(n_col) then
			this.SetItem(1,'id_colegiado','')
			return 0
		end if
		if g_colegio='COAATMCA' then
			if len(n_col)>=2 then
				if IsNumber(left(n_col,2)) then
					n_col='PM'+right('00000'+n_col,5)
				end if
			else
				n_col='PM'+right('00000'+n_col,5)
			end if
		end if
		select id_colegiado into :id_col from colegiados where n_colegiado=:n_col;
		this.SetItem(1,'id_colegiado',id_col)
		this.post SetItem(1,'n_col',n_col)
end choose
end event

type dw_lista from u_dw within w_reg_es_emision_certificados
boolean visible = false
integer x = 393
integer y = 692
integer width = 3273
integer height = 1016
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_reg_es_emision_certificado_lista"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)
this.of_SetTransObject(SQLCA)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

event rowfocuschanged;call super::rowfocuschanged;string asunto
string cod_plantilla, n_col, n_registro
DataWindowChild dwc_curso

asunto=dw_lista.GetItemString(currentrow,'asunto')
cod_plantilla=mid(asunto,1,pos(asunto,'-') - 2)

dw_parametros.visible=false
dw_parametros.object.f_desde.visible=false
dw_parametros.object.f_hasta.visible=false	
dw_parametros.object.t_desde.visible=false
dw_parametros.object.t_hasta.visible=false
dw_parametros.object.curso.visible=false
dw_parametros.object.curso_t.visible=false
dw_parametros.object.texto.visible=false
dw_parametros.object.texto_t.visible=false
dw_parametros.object.tipo_act.visible=false
dw_parametros.object.estado.visible=false			
dw_parametros.object.t_tipo_act.visible=false	
dw_parametros.object.t_estado.visible=false	
dw_parametros.object.orden.visible=false	
dw_parametros.object.t_orden.visible=false	
choose case cod_plantilla
	case 'ES00000001'
		dw_parametros.visible=true
		dw_parametros.object.f_desde.visible=true
		dw_parametros.object.f_hasta.visible=true		
		dw_parametros.object.t_desde.visible=true
		dw_parametros.object.t_hasta.visible=true
		dw_parametros.object.tipo_act.visible=true	
		dw_parametros.object.estado.visible=true			
		dw_parametros.object.t_tipo_act.visible=true	
		dw_parametros.object.t_estado.visible=true			
		dw_parametros.object.orden.visible=true	
		dw_parametros.object.t_orden.visible=true			
	case 'ES00000005'
		dw_parametros.visible=true
		dw_parametros.object.f_desde.visible=true
		dw_parametros.object.f_hasta.visible=true		
		dw_parametros.object.t_desde.visible=true
		dw_parametros.object.t_hasta.visible=true

	case 'ES00000003'
		dw_parametros.visible=true
		dw_parametros.object.texto.visible=true
		dw_parametros.object.texto_t.visible=true		
		dw_parametros.object.texto_t.text='Colegio:'
	case 'ES00000007'
		dw_parametros.visible=true
		dw_parametros.object.texto.visible=true
		dw_parametros.object.texto_t.visible=true	
		dw_parametros.object.texto_t.text='Texto:'
	case 'ES00000006'
		dw_parametros.visible=true
		dw_parametros.object.curso.visible=true
		dw_parametros.object.curso_t.visible=true		
		n_registro = dw_lista.getitemstring(getrow(),'n_registro')
		select codigo_o into :n_col from registro where n_registro = :n_registro;
		dw_parametros.GetChild('curso',dwc_curso)
		dwc_curso.SetTransObject(SQLCA)
		dwc_curso.retrieve(n_col)
		
	case else 

end choose


end event

event doubleclicked;call super::doubleclicked;if row>0 then CloseWithReturn(parent,dw_lista.GetItemString(row,'id_registro'))
end event

type dw_parametros from u_dw within w_reg_es_emision_certificados
boolean visible = false
integer x = 1824
integer y = 48
integer width = 1559
integer height = 544
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_reg_es_campos_emision_parametros"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

type cb_pdf from commandbutton within w_reg_es_emision_certificados
event type string csd_obtener_ruta_pdf ( string n_registro )
integer x = 896
integer y = 1720
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Generar PDF"
end type

event type string csd_obtener_ruta_pdf(string n_registro);string id_registro,anyo,ruta
datetime fecha
string ruta_base,id_tipo_modulo,id_modulo,nombre

	select ruta_base into :ruta_base from registro_series where codigo=:ist_datos.serie and (cod_delegacion=:g_cod_delegacion or cod_delegacion='%');
	select id_registro,fecha into :id_modulo,:fecha from registro where n_registro=:n_registro;
	anyo=string(year(date(fecha)))
		
	//ruta=ruta_base+id_tipo_modulo+'\'+anyo+'\'+id_modulo+'\'
	ruta=ruta_base+anyo+'\'+id_modulo+'\'
	if Not(DirectoryExists(ruta_base+id_tipo_modulo+'\'+anyo+'\')) then CreateDirectory(ruta_base+id_tipo_modulo+'\'+anyo+'\')
	if Not(DirectoryExists(ruta_base+id_tipo_modulo+'\'+anyo+'\'+id_modulo+'\')) then CreateDirectory(ruta_base+id_tipo_modulo+'\'+anyo+'\'+id_modulo+'\')


return ruta
end event

event clicked;n_csd_impresion_formato uo_impresion
datastore ds_reg_anexo
oleobject word
string impresora2,version,ruta_reg_es,id_registro
int ret=0,ret_dis,retorno,fila,res
long es
long handle	
string ruta_fichero,nombre_pdf,ruta_pdf,id_reg_salida

// Modificamos la impresora por defecto de Word y le ponemos la docuprinter
string ls_impresora_defecto

uo_impresion = create n_csd_impresion_formato


//Creamos y conectamos el control word
try
	word = CREATE oleobject
	handle = word.ConnectToNewObject("word.application")
Catch (Throwable ProcessError)
	MessageBox("Error al crear el objeto Word","No se pudo crear el objeto Word. Compruebe que tenga instalado el Office 2000 o superior.",StopSign!)
	return
end try


// Inicializacion nombre y ruta de ficheros
nombre_pdf = ist_datos.n_col+'_carta_salida'
ruta_fichero=g_directorio_temporal+'carta_salida.doc'
ruta_reg_es = event csd_obtener_ruta_pdf(ist_datos.n_reg_salida)
ruta_pdf = ruta_reg_es

select id_registro into :id_registro from registro where n_registro=:ist_datos.n_reg_salida;

try
	word.Documents.Open(ruta_fichero)
	word.Application.Visible = True 
Catch (Throwable ProcessError1)
	MessageBox("Error al abrir el documento","No se encontr$$HEX2$$f3002000$$ENDHEX$$la plantilla word seleccionada.",StopSign!)
	return 
end try


/***************************************/
/****** IMPRIMIMOS LA CARTA DE SALIDA *******/
/***************************************/
ls_impresora_defecto = Word.Application.ActivePrinter
Word.Application.ActivePrinter = 'docuprinter'

//Obtenemos la ruta donde est$$HEX2$$e1002000$$ENDHEX$$instalada la impresora Docuprinter
RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","ProductVersion", RegString!, version)
// Establecer parametros de Neevia
if version='LT 5.x' then
	ret += RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","Option_SaveAs_Visible", ReguLong!,  0)
	ret += RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","FileMask", RegString!,  nombre_pdf+'.pdf')
	ret +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputPath", RegString!,ruta_pdf)
	ret +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputFile", RegString!, nombre_pdf)
	ret +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputType", ReguLong!, 1)
	ret +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","View", ReguLong!, 0)		

else
	ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","UseMask", ReguLong!, 1) 
	ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","FileMask", RegString!, nombre_pdf +'.pdf')
	ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","PDFOutputPath", RegString!,ruta_pdf)
	ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputFile", RegString!, nombre_pdf+'.pdf')
	ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputType", ReguLong!, 1)
end if


word.ActiveDocument.PrintOut()  

//Esperamos hasta que se cree el archivo
OpenWithParm(w_espera_pdf,ruta_pdf + nombre_pdf+ '.PDF')
retorno = Message.DoubleParm

if not(fileexists(ruta_pdf + nombre_pdf+ '.PDF')) then	
	MessageBox("ERROR","Error al generar el PDF")
else
	uo_impresion.ist_doc_modulo.id_tipo_modulo='REG_ES'
	uo_impresion.ist_doc_modulo.id_modulo=id_registro
	uo_impresion.ist_doc_modulo.anyo=string(year(date(ist_datos.f_reg_salida)))
	uo_impresion.nombre=nombre_pdf
	uo_impresion.visualizar_web='S'
	uo_impresion.ist_doc_modulo.tamanyo= Ceiling(gnv_fichero.of_GetFileSize(ruta_pdf + nombre_pdf+ '.PDF') / 1024)	
	
	uo_impresion.f_generar_entrada_doc_modulo()
end if



// **** A$$HEX1$$d100$$ENDHEX$$ADIMOS EL DOCUMENTO A LA PESTA$$HEX1$$d100$$ENDHEX$$A DEL REGISTRO ****/
select id_registro into :id_reg_salida from registro where n_registro=:ist_datos.n_reg_salida;
ds_reg_anexo=create datastore
ds_reg_anexo.dataobject='d_registros_anexos'
ds_reg_anexo.SetTransObject(SQLCA)
fila=ds_reg_anexo.insertrow(0)

ds_reg_anexo.SetItem(fila,'id_registro_anexo',f_siguiente_numero('REGISTROS_ANEXOS',10))
ds_reg_anexo.SetItem(fila,'id_registro',id_reg_salida)
ds_reg_anexo.SetItem(fila,'ruta',nombre_pdf+'.pdf')	
ds_reg_anexo.SetItem(fila,'id_documento_modulo',uo_impresion.id_doc_modulo)	
res=ds_reg_anexo.update()	



/********************************************/
/****** IMPRIMIMOS EL DOCUMENTO PLANTILLA *******/
/*******************************************/

nombre_pdf =  ist_datos.n_col+'_'+left(is_plantilla,pos(is_plantilla,'.') - 1)
ruta_fichero=g_directorio_temporal+is_plantilla
ruta_pdf = ruta_reg_es
try
	word.Documents.Open(ruta_fichero)
	word.Application.Visible = True 
Catch (Throwable ProcessError2)
	MessageBox("Error al abrir el documento","No se encontr$$HEX2$$f3002000$$ENDHEX$$la plantilla word seleccionada.",StopSign!)
	return 
end try



ls_impresora_defecto = Word.Application.ActivePrinter
Word.Application.ActivePrinter = 'docuprinter'

//Obtenemos la ruta donde est$$HEX2$$e1002000$$ENDHEX$$instalada la impresora Docuprinter
RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","ProductVersion", RegString!, version)
// Establecer parametros de Neevia
if version='LT 5.x' then
	ret += RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","Option_SaveAs_Visible", ReguLong!,  0)
	ret += RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","FileMask", RegString!,  nombre_pdf+'.pdf')
	ret +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputPath", RegString!,ruta_pdf)
	ret +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputFile", RegString!, nombre_pdf)
	ret +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputType", ReguLong!, 1)
	ret +=RegistrySet( "HKEY_CURRENT_USER\SOFTWARE\NEEVIA\Neevia docuPrinter","View", ReguLong!, 0)		
else
	ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","UseMask", ReguLong!, 1) 
	ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","FileMask", RegString!, nombre_pdf +'.pdf')
	ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","PDFOutputPath", RegString!,ruta_pdf)
	ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputFile", RegString!, nombre_pdf+'.pdf')
	ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputType", ReguLong!, 1)
end if

word.ActiveDocument.PrintOut()  

//Esperamos hasta que se cree el archivo
OpenWithParm(w_espera_pdf,ruta_pdf + nombre_pdf+ '.PDF')
retorno = Message.DoubleParm

if not(fileexists(ruta_pdf + nombre_pdf+ '.PDF')) then	
	MessageBox("ERROR","Error al generar el PDF")
else
	uo_impresion.ist_doc_modulo.id_tipo_modulo='REG_ES'
	uo_impresion.ist_doc_modulo.id_modulo=id_registro
	uo_impresion.ist_doc_modulo.anyo=string(year(date(ist_datos.f_reg_salida)))
	uo_impresion.nombre=nombre_pdf
	uo_impresion.visualizar_web='S'
	uo_impresion.ist_doc_modulo.tamanyo= Ceiling(gnv_fichero.of_GetFileSize(ruta_pdf + nombre_pdf+ '.PDF') / 1024)	
	
	uo_impresion.f_generar_entrada_doc_modulo()	
end if


// **** A$$HEX1$$d100$$ENDHEX$$ADIMOS EL DOCUMENTO A LA PESTA$$HEX1$$d100$$ENDHEX$$A DEL REGISTRO ****/
select id_registro into :id_reg_salida from registro where n_registro=:ist_datos.n_reg_salida;
ds_reg_anexo=create datastore
ds_reg_anexo.dataobject='d_registros_anexos'
ds_reg_anexo.SetTransObject(SQLCA)
fila=ds_reg_anexo.insertrow(0)

ds_reg_anexo.SetItem(fila,'id_registro_anexo',f_siguiente_numero('REGISTROS_ANEXOS',10))
ds_reg_anexo.SetItem(fila,'id_registro',id_reg_salida)
ds_reg_anexo.SetItem(fila,'ruta',nombre_pdf+'.pdf')	
ds_reg_anexo.SetItem(fila,'id_documento_modulo',uo_impresion.id_doc_modulo)	
res=ds_reg_anexo.update()	


Word.Application.ActivePrinter = ls_impresora_defecto

retorno = Message.DoubleParm

ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","UseMask", ReguLong!,0) 
ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","FileMask", RegString!, '')
ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","PDFOutputPath", RegString!,'C:\')
ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputFile", RegString!, '')
ret += RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\NEEVIA\Neevia docuPrinter","OutputType", ReguLong!, 1)

IF retorno = -1 THEN return -1


//word.Documents.Item(1).Close(0) 
//word.Documents.Item(1).Close(0) 
word.Documents.Close(0)
word.Quit(0)
word.DisconnectObject()
destroy word

return 1

end event

type cb_emitir from commandbutton within w_reg_es_emision_certificados
boolean visible = false
integer x = 434
integer y = 1720
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Emitir"
end type

event clicked;string plantilla,asunto,cod_plantilla,sql
datetime f_salida
integer res
long num_row

datastore ds_campos
ds_campos=create datastore
ds_campos.dataobject='d_reg_es_campos_plantilla'


if dw_lista.rowcount()<=0 then
	MessageBox("Atencion!", "No existen peticiones de certificados en la lista")
	return
end if



asunto=dw_lista.GetItemString(dw_lista.GetRow(),'asunto')
cod_plantilla= mid(asunto,1,pos(asunto,'-') - 2)
select ruta into :plantilla from plantillas where codigo=:cod_plantilla;



if dw_lista.GetItemString(dw_lista.GetRow(),'salida')='S' then
	if MessageBox("Atencion","Ya se genero un registro de salida. $$HEX1$$bf00$$ENDHEX$$Desea generar uno nuevo? Si elige que no, se volvera a imprimir el documento",Question!,YesNo!)=1 then
		event csd_generar_registro_salida(dw_lista.GetItemString(dw_lista.GetRow(),'n_registro'))
	else
		ist_datos.serie=dw_consulta.GetItemString(1,'serie')
		ist_datos.n_reg_entrada=dw_lista.GetItemString(dw_lista.GetRow(),'n_registro')
		ist_datos.n_reg_salida=dw_lista.GetItemString(dw_lista.GetRow(),'n_registro_ref')
		ist_datos.f_reg_salida=dw_lista.GetItemDateTime(dw_lista.GetRow(),'f_salida')
		ist_datos.f_reg_entrada=dw_lista.GetItemDateTime(dw_lista.GetRow(),'fecha')
		ist_datos.n_col=dw_lista.GetItemString(dw_lista.GetRow(),'codigo_o')			
	end if

else
		event csd_generar_registro_salida(dw_lista.GetItemString(dw_lista.GetRow(),'n_registro'))	
end if

res=event csd_rellenar_marcadores(ds_campos,cod_plantilla)
if res<0 then return

//if(g_colegio = 'COAATMCA' and cod_plantilla <> 'ES00000005' )then   //and cod_plantilla <> 'ES00000001'
event csd_rellenar_plantilla(ds_campos,'carta_salida.doc')
if cod_plantilla='ES00000001' and dw_parametros.GetItemString(1,'estado')='E' then
	plantilla='Certificado_obras_en_curso_por_colegiado.doc'
end if
event csd_rellenar_plantilla(ds_campos,plantilla)
//end if

cb_pdf.enabled=true
sql=dw_lista.GetSQLSelect()
dw_lista.SetSQLSelect(is_ult_consulta)
num_row=dw_lista.GetRow()
dw_lista.retrieve()
dw_lista.SetSQLSelect(sql)
dw_lista.SetRow(num_row)
dw_lista.ScrollToRow(num_row)

end event

type cb_3 from commandbutton within w_reg_es_emision_certificados
integer x = 3301
integer y = 1752
integer width = 361
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Borrar Campos"
end type

event clicked;datetime f_nula

SetNull(f_nula)
dw_parametros.SetItem(1,'curso','')
dw_parametros.SetItem(1,'texto','')
dw_parametros.SetItem(1,'f_desde',f_nula)
dw_parametros.SetItem(1,'f_hasta',f_nula)

end event

type cb_pedir from commandbutton within w_reg_es_emision_certificados
boolean visible = false
integer x = 434
integer y = 1720
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Pedir"
end type

event clicked;dw_consulta.AcceptText()

if f_es_vacio(dw_consulta.GetItemString(1,'tipo_cert')) then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Tiene que seleccionar un certificado")
	return
end if

if f_es_vacio(dw_consulta.GetItemString(1,'id_colegiado'))and  f_es_vacio(dw_consulta.GetItemString(1,'n_registro')) then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Debe seleccionar un colegiado o un registro de entrada")
	return
end if	

event csd_generar_registro_entrada()
end event

