HA$PBExportHeader$w_fases_creacion_fases.srw
forward
global type w_fases_creacion_fases from w_response
end type
type dw_1 from u_dw within w_fases_creacion_fases
end type
type cb_asignar from commandbutton within w_fases_creacion_fases
end type
type cb_cerrar from commandbutton within w_fases_creacion_fases
end type
type dw_datos_fase from u_dw within w_fases_creacion_fases
end type
type gb_1 from groupbox within w_fases_creacion_fases
end type
end forward

global type w_fases_creacion_fases from w_response
integer width = 2647
integer height = 1916
boolean center = true
event type string csd_opcion_contrato ( )
event type string csd_opcion_expediente_contrato ( )
event type string csd_opcion_documentos ( )
event type string csd_opcion_nulo ( )
event csd_imprimir_etiqueta ( string id,  string numero )
event type string csd_opcion_manual ( )
event type string csd_opcion_minuta ( )
dw_1 dw_1
cb_asignar cb_asignar
cb_cerrar cb_cerrar
dw_datos_fase dw_datos_fase
gb_1 gb_1
end type
global w_fases_creacion_fases w_fases_creacion_fases

type variables
st_fases_consulta ist_datos_fase
st_control_doc ist_control_doc

string i_tramite_defecto, i_cod_colegio_dest
end variables

forward prototypes
public function string wf_validar_registro (ref boolean b_crear_registro)
public function integer wf_crear_fase_estado (string id_fase, datetime fecha, string estado)
public subroutine wf_inhabilita_dw ()
public subroutine wf_rellenar_datos_salida (string n_registro, string n_expediente)
public function string wf_validar_expediente (ref boolean b_crear_expediente)
public function integer wf_crear_fase_cliente (string id_fase, string id_cliente)
public function integer wf_copiar_fase (string id_fase_origen, string id_expediente, string id_fase_destino, string n_reg, string n_exp, datetime fecha)
public subroutine wf_cargar_datos_fase (string id_fase, string opcion)
public function integer wf_crear_fase (string id_expediente, string id_fase, string n_reg, string n_exp, datetime fecha)
public function integer wf_crear_estadistica (string id_fase, string tipo_promotor)
public function integer wf_crear_fase_colegiado (string id_fase, string id_colegiado, double porcentaje, string obs)
public subroutine wf_rellenar_contrato_defecto ()
public function integer wf_crear_expediente (string id_expediente, string exp, datetime fecha)
end prototypes

event type string csd_opcion_contrato();// Evento correspondiente a la opcion AUTOMATICA -> CONTRATO
string id_fase = '-1'
string n_expediente, id_expediente, n_registro
long cant
datetime hoy

/*********************************************************************************
			VALIDACIONES
**********************************************************************************/
// Cogemos el numero de expediente indicado
n_expediente = dw_1.GetItemString(1,'n_expediente')

if f_es_vacio(n_expediente) then
	MessageBox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de Expediente')
	return id_fase
end if

// Miramos si existe el expediente
SELECT count(*) INTO :cant FROM expedientes WHERE expedientes.n_expedi = :n_expediente;
if cant =  0 then
	Messagebox(g_titulo,"El n$$HEX1$$fa00$$ENDHEX$$mero de expediente especificado no existe")
	return id_fase
end if



/*********************************************************************************
			CREACI$$HEX1$$d300$$ENDHEX$$N DEL CONTRATO EN EL EXPEDIENTE 
**********************************************************************************/
SELECT expedientes.id_expedi INTO :id_expediente FROM expedientes where expedientes.n_expedi=:n_expediente;
st_control_eventos c_evento 
c_evento.evento = 'NUMERO_REG'
f_control_eventos(c_evento)			
n_registro		= f_numera_registro(c_evento.param1) // Modificado Ricardo 2005-05-11 -> Le pasamos el formato que quiere que nos devuelva
hoy			= datetime(Today(), now())
id_fase  	= f_siguiente_numero('FASES',10) // fase nueva
// Lo metemos en una transaccion para que se ejecute todo o nada
execute immediate 'BEGIN transaction';
if wf_crear_fase(id_expediente, id_fase, n_registro, n_expediente, hoy)<0 then
	id_fase = '-1'
	rollback;
else
	commit;
end if
execute immediate 'END transaction';
/*********************************************************************************
			FIN DE LA CREACI$$HEX1$$d300$$ENDHEX$$N DEL CONTRATO EN EL EXPEDIENTE 
**********************************************************************************/

if id_fase = '-1' then
	Messagebox(g_titulo, "Se ha producido un error", stopsign!)
else
	// Imprimimos el ticket
	if g_colegio = 'COAATGU' and dw_1.getitemstring(1,'etiqueta') = 'S' then this.trigger event csd_imprimir_etiqueta(id_fase, n_registro)	
	if g_colegio = 'COAATLE' and dw_1.getitemstring(1,'etiqueta') = 'S' then this.trigger event csd_imprimir_etiqueta(id_fase, n_registro)	
	// Presentamos la salida
	wf_rellenar_datos_salida(n_registro, n_expediente)
end if




return id_fase
end event

event type string csd_opcion_expediente_contrato();// Evento correspondiente a la opcion AUTOMATICA -> EXPEDIENTE Y CONTRATO
string id_fase = '-1'
string n_expediente, id_expediente, n_registro
st_control_eventos c_evento
datetime hoy
string nif1,nif2,nif3,id_col1,id_col3,id_col2

if((g_colegio='COAATTGN' or g_colegio = 'COAATTEB' or g_colegio = 'COAATLL') and g_fase_visared.opcion_importacion='N')then
	ist_control_doc.tipo_actuacion=dw_datos_fase.GetItemString(1,'fase')
	ist_control_doc.encargo=dw_datos_fase.GetItemString(1,'descripcion')
	ist_control_doc.emplazamiento=dw_datos_fase.GetItemString(1,'tipo_via')+dw_datos_fase.GetItemString(1,'emplazamiento') + ',' 
	ist_control_doc.emplazamiento+=dw_datos_fase.GetItemString(1,'n_calle')
	if not(f_es_vacio(dw_datos_fase.GetItemString(1,'piso'))) then
		ist_control_doc.emplazamiento+=' pis '+dw_datos_fase.GetItemString(1,'piso')
	end if
	if not(f_es_vacio(dw_datos_fase.GetItemString(1,'puerta'))) then
		ist_control_doc.emplazamiento+=' porta '+dw_datos_fase.GetItemString(1,'puerta')		
	end if
	id_col1= dw_datos_fase.GetItemString(1,'id_col1')
	id_col2= dw_datos_fase.GetItemString(1,'id_col2')
	id_col3= dw_datos_fase.GetItemString(1,'id_col3')
	select nif into :nif1 from colegiados where id_colegiado=:id_col1;
	select nif into :nif2 from colegiados where id_colegiado=:id_col2;
	select nif into :nif3 from colegiados where id_colegiado=:id_col3;	
	ist_control_doc.nombre_col1=f_colegiado_apellido(id_col1)
	ist_control_doc.nombre_col2=f_colegiado_apellido(id_col2)
	ist_control_doc.nombre_col3=f_colegiado_apellido(id_col3)
	ist_control_doc.n_col1= dw_datos_fase.GetItemString(1,'n_col1')	
	ist_control_doc.n_col2= dw_datos_fase.GetItemString(1,'n_col2')
	ist_control_doc.n_col3= dw_datos_fase.GetItemString(1,'n_col3')	
	ist_control_doc.nif1= nif1
	ist_control_doc.nif2= nif2
	ist_control_doc.nif3= nif3
	if ist_control_doc.tipo_actuacion='11' or ist_control_doc.tipo_actuacion='12' or ist_control_doc.tipo_actuacion='13' or ist_control_doc.tipo_actuacion='14'  then		
		openWithParm(w_control_documentacion_tg,ist_control_doc)
		ist_control_doc=Message.PowerObjectParm
		if not(IsValid(ist_control_doc)) then return '-1'
		if ist_control_doc.no_cte<>'N' and ist_control_doc.no_cte<>'S' then return '-1'
	else
		ist_control_doc.no_cte='S'
	end if
	//dw_datos_fase.SetItem(1,'fase',ist_control_doc.tipo_actuacion)
end if

	


/*********************************************************************************
			CREACI$$HEX1$$d300$$ENDHEX$$N DEL CONTRATO Y DEL EXPEDIENTE 
**********************************************************************************/
// Obtenemos los datos necesarios para crear un contrato y un expediente nuevo
id_fase		 		= f_siguiente_numero('FASES',10)
id_expediente 		= f_siguiente_numero('EXPEDIENTES',10)
hoy					= datetime(Today(), now())
c_evento.evento 	= 'NUMERO_EXP'
f_control_eventos(c_evento)		
n_expediente 		= f_numera_expediente(c_evento.param1)// Modificado Ricardo 2005-05-11 -> SE le pasa el formato directamente
c_evento.evento 	= 'NUMERO_REG'
f_control_eventos(c_evento)			
n_registro 			= f_numera_registro(c_evento.param1) // Modificado Ricardo 2005-05-10 -> Le pasamos el formato de la numeracion
// Comenzamos una transaccion para que sea todo atomico				
execute immediate 'BEGIN transaction';

// Creamos un contrato
if wf_crear_fase(id_expediente, id_fase, n_registro, n_expediente, hoy)<0 then
	id_fase = '-1'
	rollback;
else
	// Creado el contrato, intentamos lo mismo en el expediente
	if wf_crear_expediente(id_expediente, n_expediente, hoy)<0 then
		id_fase = '-1'
		rollback;
	else
		commit;
	end if
end if
execute immediate 'END transaction';
/*********************************************************************************
			FIN DE LA CREACI$$HEX1$$d300$$ENDHEX$$N DEL CONTRATO Y DEL EXPEDIENTE 
**********************************************************************************/


if id_fase = '-1' then
	Messagebox(g_titulo, "Se ha producido un error", stopsign!)
else
	// Imprimimos el ticket
	if g_colegio = 'COAATGU' and dw_1.getitemstring(1,'etiqueta') = 'S' then this.trigger event csd_imprimir_etiqueta(id_fase, n_registro)
	if g_colegio = 'COAATLE' and dw_1.getitemstring(1,'etiqueta') = 'S' then this.trigger event csd_imprimir_etiqueta(id_fase, n_registro)	
	// Presentamos la salida
	wf_rellenar_datos_salida(n_registro, n_expediente)
end if


return id_fase
end event

event type string csd_opcion_documentos();// EVENTO A SER MODIFICADO POR PARTE DEL EQUIPO DE VISADOS! DE MOMENTO COLOCAMOS EL CODIGO ANTIGUO

return ist_datos_fase.id_fase
end event

event type string csd_opcion_nulo();// Evento correspondiente a la opcion AUTOMATICA -> NULO
string id_fase = '-1'
string n_expediente, id_expediente, n_registro
st_control_eventos c_evento
datetime hoy


/*********************************************************************************
			CREACI$$HEX1$$d300$$ENDHEX$$N DEL CONTRATO EN EL EXPEDIENTE 
**********************************************************************************/
// OBTENEMOS LOS DATOS PARA LA CREACI$$HEX1$$d300$$ENDHEX$$N SOBRE EL EXPEDIENTE NULO
n_expediente 	= g_num_expedi_nulo
id_expediente 	= g_num_expedi_nulo
id_fase 			= f_siguiente_numero('FASES',10)
c_evento.evento = 'NUMERO_REG'
f_control_eventos(c_evento)			
n_registro		= f_numera_registro(c_evento.param1) // Modificado Ricardo 2005-05-11 -> Le pasamos el formato en el que queremos que nos devuelvan los datos
hoy				= datetime(Today(), now())
				
execute immediate 'BEGIN transaction';
if wf_crear_fase(id_expediente, id_fase, n_registro, n_expediente, hoy)<0 then
	id_fase = '-1'
	rollback;
else
	commit;
end if
execute immediate 'END transaction';
/*********************************************************************************
			FIN DE LA CREACI$$HEX1$$d300$$ENDHEX$$N DEL CONTRATO Y DEL EXPEDIENTE 
**********************************************************************************/

if id_fase = '-1' then
	Messagebox(g_titulo, "Se ha producido un error", stopsign!)
else
	// Imprimimos el ticket
	if dw_1.getitemstring(1,'etiqueta') = 'S' then this.trigger event csd_imprimir_etiqueta(id_fase, n_registro)
	// Presentamos la salida
	wf_rellenar_datos_salida(n_registro, n_expediente)
end if


return id_fase
end event

event csd_imprimir_etiqueta(string id, string numero);// EVENTO QUE REALIZA LA IMPRESION DE UN TICKET
string sl_impresora_defecto, sl_impresora_tickets_ini
string sl_descripcion_fase

if g_colegio = 'COAATTFE' or g_colegio = 'COAATGU' or g_colegio = 'COAATLE' then
	// Cogemos la impresora del ini
	sl_impresora_tickets_ini = Profilestring(gnv_app.of_GetAppInifile(),"Parametros","ImpresoraTickets","")
	if f_es_vacio(sl_impresora_tickets_ini) then	return
	//Guardamos impresora predeterminada
	sl_impresora_defecto = printgetprinter()
	//Cambiamos la impresora por defecto a la de tickets
	PrintSetPrinter(sl_impresora_tickets_ini)	

	// Imprimimos la etiqueta, con un mensaje entre 2 impresiones para que puedan cortarla
	datastore ds_impresion
	ds_impresion = create datastore
	ds_impresion.dataObject = 'd_resguardo'
	
	if g_colegio = 'COAATGU' then ds_impresion.dataObject = 'd_resguardo_gu'
	if g_colegio = 'COAATLE' then ds_impresion.dataObject = 'd_resguardo_le'
	
	//Com$$HEX1$$fa00$$ENDHEX$$n
	ds_impresion.insertrow(0)
	ds_impresion.setitem(1,'num_exp_1',numero)
	ds_impresion.setitem(1,'f_entrada',today())
	ds_impresion.setitem(1,'centro',f_dame_descripcion_delegacion())
	ds_impresion.setitem(1,'id_fase','*'+id+'*')
	
	//S$$HEX1$$f300$$ENDHEX$$lo Guadalajara
	//Cogeremos los datos de dw_datos_fase
	if g_colegio = 'COAATGU' or g_colegio = 'COAATLE' then
		string n_expedi,tipo_intervencion,colegiados, tipo_reg
		string id_col1,id_col2,id_col3
		//Obtenemos el n_expedi de la bd
		select n_expedi into :n_expedi from fases where id_fase=:id;
		tipo_intervencion=dw_datos_fase.getitemstring(1,'fase')
		tipo_reg=dw_datos_fase.getitemstring(1,'tipo_registro')
		ds_impresion.setitem(1,'n_expedi',n_expedi)
		ds_impresion.setitem(1,'tipo_intervencion',tipo_reg+"/"+tipo_intervencion)
		
		ds_impresion.setitem(1,'cliente',dw_datos_fase.getitemstring(1,'nombre_cliente'))
		
		sl_descripcion_fase=dw_datos_fase.GetItemString(1, 'descripcion')
		ds_impresion.setitem(1,'descripcion',sl_descripcion_fase)
		
		id_col1=dw_datos_fase.GetItemString(1, 'id_col1')
		id_col2=dw_datos_fase.GetItemString(1, 'id_col2')
		id_col3=dw_datos_fase.GetItemString(1, 'id_col3')
		
		if not f_es_vacio(id_col1) then
			colegiados=dw_datos_fase.getitemstring(1,'nombre_colegiado_1')+cr
		end if
		if not f_es_vacio(id_col2) then
			colegiados+=dw_datos_fase.getitemstring(1,'nombre_colegiado_2')+cr
		end if
		if not f_es_vacio(id_col3) then
			colegiados+=dw_datos_fase.getitemstring(1,'nombre_colegiado_3')
		end if
		
		ds_impresion.setitem(1,'colegiados',colegiados)
	end if
	
	ds_impresion.print()
	MessageBox(g_titulo, "Corte el ticket antes de continuar")
	ds_impresion.print()
	// Destruimos el datastore para liberar memoria
	destroy ds_impresion		
	// Restauramos la impresora por defecto
	PrintSetPrinter(sl_impresora_defecto)
end if

end event

event type string csd_opcion_manual();// Evento correspondiente a la opcion MANUAL

string id_fase = '-1'
string mensaje = ''
string anyo, n_expediente, n_registro, id_expediente
datetime hoy
boolean b_crear_expediente = false, b_crear_registro = false
st_control_eventos c_evento

/*********************************************************************************
			VALIDACIONES
**********************************************************************************/
anyo= dw_1.getitemstring(1, 'anyo')
mensaje += f_valida(dw_1, 'anyo', 'NOVACIO', "Debe indicar un a$$HEX1$$f100$$ENDHEX$$o v$$HEX1$$e100$$ENDHEX$$lido")
mensaje += f_valida(dw_1, 'n_expediente', 'NOVACIO', "Debe indicar un Expediente")
if g_colegio <> 'COAATLR' or (g_colegio = 'COAATLR' and anyo <> string(year(today()))) THEN 
	mensaje += f_valida(dw_1, 'n_registro', 'NOVACIO', "Debe indicar un Contrato")
end if
if anyo > string(year(today())) then mensaje += "El a$$HEX1$$f100$$ENDHEX$$o no puede ser posterior al actual"
if anyo < '1950' then mensaje += "No se pueden indicar a$$HEX1$$f100$$ENDHEX$$os anteriores a 1950"

if f_es_vacio(mensaje) then
	
	// Las funciones son las que se encargan de decidir si hay que crear o no
	mensaje += wf_validar_expediente(b_crear_expediente)
	if LenA(mensaje) >0 then mensaje += cr
	mensaje += wf_validar_registro(b_crear_registro)
end if

/*********************************************************************************
			CREACI$$HEX1$$d300$$ENDHEX$$N DE LO QUE CORRESPONDA (CONTRATO SOLO Y/O CONTRATO Y EXPEDIENTE)
**********************************************************************************/
if f_es_vacio(mensaje) then
	// Obtenemos los  datos que nos sean necesarios
	hoy					= datetime(Today(), now())
	n_expediente 		= dw_1.GetItemString(1, 'n_expediente')
	n_registro 			= dw_1.GetItemString(1, 'n_registro')
	if b_crear_registro then
		if f_es_vacio(n_registro) then
			c_evento.evento 	= 'NUMERO_REG'
			f_control_eventos(c_evento)			
			n_registro 			= f_numera_registro(c_evento.param1) // Modificado Ricardo 2005-05-11 -> Le pasamos a la funcion el formato que queremos que nos devuelvan
		end if
		id_fase 		= f_siguiente_numero('FASES',10)
	end if
	if b_crear_expediente then
		id_expediente 		= f_siguiente_numero('EXPEDIENTES',10)
	else
		// Obtenemos el id_expedi
		id_expediente 		= f_dame_id_exp_de_n_exp(n_expediente)
	end if
	
	// Comenzamos una transaccion para que sea todo atomico				
	execute immediate 'BEGIN transaction';
	if b_crear_expediente then
		// Creado el contrato, intentamos lo mismo en el expediente
		if wf_crear_expediente(id_expediente, n_expediente, hoy)<0 then
		id_fase = '-2'
		end if
	end if
		
	// Miramos si hemos tenido problemas al crear el expediente, no creando el registro
	if id_fase = '-2' then
		id_fase = '-1'
	else
		// Creamos un contrato
		if wf_crear_fase(id_expediente, id_fase, n_registro, n_expediente, hoy)<0 then
			id_fase = '-1'
			rollback;
		else
			commit;
		end if
	end if
	execute immediate 'END transaction';
	
	if id_fase = '-1' then
		Messagebox(g_titulo, "Se ha producido un error", stopsign!)
	else
		// Imprimimos el ticket
		if g_colegio = 'COAATGU' and dw_1.getitemstring(1,'etiqueta') = 'S' then this.trigger event csd_imprimir_etiqueta(id_fase, n_registro)		
		if g_colegio = 'COAATLE' and dw_1.getitemstring(1,'etiqueta') = 'S' then this.trigger event csd_imprimir_etiqueta(id_fase, n_registro)
		// Presentamos la salida
		wf_rellenar_datos_salida(n_registro, n_expediente)
	end if
else
	messagebox(g_titulo, mensaje, stopsign!)
end if


return id_fase
end event

event type string csd_opcion_minuta();string id_fase, n_registro, n_expediente, n_salida, id_expediente, texto
long cant
datetime hoy
boolean lb_fase_es_ip=false
string id_fase_original

id_fase = '-1'
/*********************************************************************************
			VALIDACIONES
**********************************************************************************/
// Cogemos el numero de salida indicado
n_salida = dw_1.GetItemString(1,'n_salida')

if f_es_vacio(n_salida) then
	texto = dw_1.object.n_salida_t.text
	texto = MidA(texto,1 , PosA(texto, ':') - 1) // AS$$HEX2$$ed002000$$ENDHEX$$quitamos los 2 puntos
	MessageBox(g_titulo,'Debe introducir un '+texto)
	return id_fase
end if

// Miramos si existe el expediente
CHOOSE CASE g_colegio
	CASE 'COAATGC'
		// El numero de salida va en la cabecera
		SELECT count(*) INTO :cant FROM expedientes WHERE expedientes.archivo = :n_salida;
	CASE ELSE
		// El numero de salida va por contrato (s$$HEX1$$f300$$ENDHEX$$lo los IP)
		SELECT count(distinct id_expedi) INTO :cant FROM fases WHERE fases.archivo = :n_salida and tipo_registro = 'IP' ;
END CHOOSE
if cant =  0 then
	Messagebox(g_titulo,"El n$$HEX1$$fa00$$ENDHEX$$mero de salida especificado no existe")
	return id_fase
else // Modificado David - 10/11/2005 - Si hay m$$HEX1$$e100$$ENDHEX$$s de uno que coja uno cualquiera
//	if cant = 1 then
	CHOOSE CASE g_colegio
		CASE 'COAATGC'
			// El numero de salida va en la cabecera
			SELECT expedientes.n_expedi, expedientes.id_expedi INTO :n_expediente, :id_expediente FROM expedientes where expedientes.archivo=:n_salida;
		CASE ELSE
			// El numero de salida va por contrato
			SELECT distinct id_expedi INTO :id_expediente FROM fases WHERE fases.archivo = :n_salida and tipo_registro = 'IP' ;
			SELECT expedientes.n_expedi INTO :n_expediente FROM expedientes where expedientes.id_expedi=:id_expediente ;
			// ponemos el n_salida en el dw de abajo
			dw_datos_fase.setitem(1, 'n_salida', n_salida)
			//Miramos si el tipo de registro de la fase es IP
			/*string ls_tipo_registro
			SELECT fases.tipo_registro,fases.id_fase into :ls_tipo_registro,:id_fase_original FROM fases WHERE fases.archivo=:n_salida;
			if ls_tipo_registro='IP' then//'IP' then 
				lb_fase_es_ip=true
			end if*/
			SELECT fases.id_fase into :id_fase_original FROM fases WHERE fases.archivo=:n_salida;
	END CHOOSE
//else
//	// Hay varios expedientes con ese numero :O
//	Messagebox(g_titulo,"El n$$HEX1$$fa00$$ENDHEX$$mero de salida indicado pertenece a varios expedientes. Tendr$$HEX2$$e1002000$$ENDHEX$$que asignar la minuta manualmente")
//	return id_fase
end if


/*********************************************************************************
			CREACI$$HEX1$$d300$$ENDHEX$$N DEL CONTRATO EN EL EXPEDIENTE 
**********************************************************************************/
// Obtenemos
st_control_eventos c_evento 
c_evento.evento = 'NUMERO_REG'
f_control_eventos(c_evento)			
n_registro		= f_numera_registro(c_evento.param1) // Modificado Ricardo 2005-05-11 -> Le pasamos el formato que quiere que nos devuelva
hoy			= datetime(Today(), now())
id_fase  	= f_siguiente_numero('FASES',10) // fase nueva
integer resultado_funcion
// Lo metemos en una transaccion para que se ejecute todo o nada
execute immediate 'BEGIN transaction';
/*if lb_fase_es_ip then 
	//i3464
	resultado_funcion=wf_copiar_fase(id_fase_original,id_expediente, id_fase, n_registro, n_expediente, hoy)
else
	resultado_funcion=wf_crear_fase(id_expediente, id_fase, n_registro, n_expediente, hoy)
end if*/
//wf_cargar_datos_fase(id_fase_original,'M')
resultado_funcion=wf_crear_fase(id_expediente, id_fase, n_registro, n_expediente, hoy)
if resultado_funcion<0 then 		
	id_fase = '-1'
	rollback;	
else
	commit;
end if
execute immediate 'END transaction';
/*********************************************************************************
			FIN DE LA CREACI$$HEX1$$d300$$ENDHEX$$N DEL CONTRATO EN EL EXPEDIENTE 
**********************************************************************************/
// Quitamos el n_salida de abajo
dw_datos_fase.setitem(1, 'n_salida', '')


if id_fase = '-1' then
	Messagebox(g_titulo, "Se ha producido un error", stopsign!)
else
	// Imprimimos el ticket
	if g_colegio = 'COAATGU' and dw_1.getitemstring(1,'etiqueta') = 'S' then this.trigger event csd_imprimir_etiqueta(id_fase, n_registro)	
	if g_colegio = 'COAATLE' and dw_1.getitemstring(1,'etiqueta') = 'S' then this.trigger event csd_imprimir_etiqueta(id_fase, n_registro)
	// Presentamos la salida
	wf_rellenar_datos_salida(n_registro, n_expediente)
end if

return id_fase
end event

public function string wf_validar_registro (ref boolean b_crear_registro);// Funcion que valida el registro. Cualquier numero de registro de a$$HEX1$$f100$$ENDHEX$$os posteriores al actual puede causar replicados
//
//		comprobaciones: -> Tenemos la ventaja a$$HEX1$$f100$$ENDHEX$$adida de tener el formato que deben seguir los Contratos!
//			Si existe el registro, protesta y sale
//			Si no existe
//				PUNTO 1) Si el formato lleva el a$$HEX1$$f100$$ENDHEX$$o:
//						A)		Si es del a$$HEX1$$f100$$ENDHEX$$o actual
//							->			En la rioja se permite no poner n_registro, y lo daremos el siguiente autom$$HEX1$$e100$$ENDHEX$$ticamente
//							->			Comprobamos que el a$$HEX1$$f100$$ENDHEX$$o indicado sea el mismo que el del registro, segun el formato
//							->			Comprobamos si lleva el guion o no segun si debe de llevarlo o no
//							->			Comprobamos que el numero que tecleen no sea posterior a la numeracion autom$$HEX1$$e100$$ENDHEX$$tica y que sea un numerico
//						B) 	si no es del a$$HEX1$$f100$$ENDHEX$$o actual, permitimos que pongan lo que quieran siempre que no sea coherente con el formato del sica
//								y que coincida con algun valor que pueda darse en el futuro.
//							->			Comprobamos que el a$$HEX1$$f100$$ENDHEX$$o indicado sea el mismo que el del registro, segun el formato
//						2)	Si no lleva a$$HEX1$$f100$$ENDHEX$$o, miramos que no sea un valor posteior al correspondiente a la numeracion autom$$HEX1$$e100$$ENDHEX$$tica, si es coherente con el formato usado




string mensaje = ''
string n_registro, anyo, numero, c_reg_new, anyo_comprobar, formato, formato_match
long cant, i, enes, aes, des
boolean b_coherente
st_control_eventos c_evento

// Cogemos el numero de registro
n_registro= dw_1.getitemstring(1, 'n_registro')
anyo= dw_1.getitemstring(1, 'anyo')

select count(*) into :cant from fases where n_registro = :n_registro;

// Si no existe es cuando verificamos el formato del expediente
if cant = 0 then
	// Si el a$$HEX1$$f100$$ENDHEX$$o indicado es posterior al actual, no se permirte
	if anyo > string(year(today())) then return "El a$$HEX1$$f100$$ENDHEX$$o es porterior al actual. No se permiten crear contratos posteriores"

	// Debemos comprobar que el numero no sea posterior al valor del contador para que no se repita al 
	// usar la forma autom$$HEX1$$e100$$ENDHEX$$tica
	c_evento.evento = 'NUMERO_REG'
	f_control_eventos(c_evento)
	formato=c_evento.param1
	
	formato_match = ''
	for i=1 to LenA(formato)
		if MidA(formato, i, 1) = 'n' then enes++
		if MidA(formato, i, 1) = 'a' then aes++
		if MidA(formato, i, 1) = 'd' then des++
		// en la misma posicion tiene que haber lo mismo en el formato indicado!
		if MidA(formato, i, 1) = 'n' or MidA(formato, i, 1) = 'a' then 
			formato_match += "[0-9]" // Ponemos uno por cada digito
		else
			if MidA(formato, i, 1) = 'd' then
				formato_match += "[A-Z]"
			else
				formato_match += "[" + MidA(formato, i, 1) + "]" // Ponemos que tiene que tener ese codigo por narices
			end if
		end if
	next
	formato_match = "^" + formato_match +"$"
	
	// Comprobamos si hace match
	b_coherente =  match(n_registro,formato_match)


	
	// ...comprobamos el registro 
	if aes>0 then
		// Si el a$$HEX1$$f100$$ENDHEX$$o es actual, para la rioja permitimos que lo deje vacio
		if anyo = string(year(today())) then
			if f_es_vacio(n_registro) and g_colegio = 'COAATLR' then
				// En este caso hay que crear un registro nuevo
				b_crear_registro = true
			else
				// Vemos si sigue el formato
				if b_coherente then
					// Validamos el a$$HEX1$$f100$$ENDHEX$$o y el numero no supere el siguiente que le toca
					if RightA(anyo, aes) = MidA(n_registro, PosA(formato, 'a'), aes) then
						// Miramos que no supere el numero actual
						if g_colegio = 'COAATCC' then
							c_reg_new = f_siguiente_numero_informativo('NUM_REG_'+f_devuelve_centro(g_cod_delegacion),enes)
						else                   
							c_reg_new = f_siguiente_numero_informativo('NUM_REG',enes)
						END IF
						if long(c_reg_new)>long(MidA(n_registro, PosA(formato, 'n'), enes)) then
							// En este caso hay que crear un registro nuevo
							b_crear_registro = true
						else
							// Si es superior protestamos
							mensaje += "No se permite un n$$HEX1$$fa00$$ENDHEX$$mero de registro superior al actual"
						end if
					else
						// El a$$HEX1$$f100$$ENDHEX$$o no coincide
						mensaje += "El a$$HEX1$$f100$$ENDHEX$$o indicado y el a$$HEX1$$f100$$ENDHEX$$o del n$$HEX1$$fa00$$ENDHEX$$mero de contrato no coinciden"
					end if
				else
					// indicamos que el formato no es valido, y el que deberia tener
					mensaje += "El n$$HEX1$$fa00$$ENDHEX$$mero de contrato no sigue el siguiente patr$$HEX1$$f300$$ENDHEX$$n : "+formato +" donde 'a' son digitos del a$$HEX1$$f100$$ENDHEX$$o y 'n' de la numeraci$$HEX1$$f300$$ENDHEX$$n correspondiente"
				end if
			end if
		else
			// No es el a$$HEX1$$f100$$ENDHEX$$o actual
			// No permitimos un formato que sea coherente con el del sica
			if b_coherente then
				// No deberiamos de dejar!
				
				// Si los d$$HEX1$$ed00$$ENDHEX$$gitos del a$$HEX1$$f100$$ENDHEX$$o no coinciden protestamos
				if MidA(n_registro, PosA(formato, 'a'), aes)=RightA(anyo, aes) then
					if long(anyo)>year(today()) then
						// El a$$HEX1$$f100$$ENDHEX$$o es mayor que el actual
						mensaje += "No puede crearse un contrato de a$$HEX1$$f100$$ENDHEX$$os posteriores"
					else
						// En este caso hay que crear un registro nuevo
						b_crear_registro = true
					end if
				else
					// El a$$HEX1$$f100$$ENDHEX$$o no coincide
					mensaje += "El a$$HEX1$$f100$$ENDHEX$$o indicado y el a$$HEX1$$f100$$ENDHEX$$o del n$$HEX1$$fa00$$ENDHEX$$mero de contrato no coinciden"
				end if
			else
				// En este caso hay que crear un registro nuevo
				b_crear_registro = true
			end if
		end if
	else
		// ...si no lleva a$$HEX1$$f100$$ENDHEX$$o el n$$HEX2$$ba002000$$ENDHEX$$registro comprobamos que no se duplicar$$HEX2$$e1002000$$ENDHEX$$en el futuro
		// Vemos si el formato es coherente
		
		if b_coherente then
			// Sacamos el numero
			c_reg_new = f_siguiente_numero_informativo('NUM_REG',enes)
			// Miramos que el numero no se supere
			if long(MidA(n_registro, PosA(formato, 'n'), enes))<long(c_reg_new) then
				// En este caso hay que crear un registro nuevo
				b_crear_registro = true
			else
				// El numero es mayor o igual, no se puede crear
				mensaje += "El n$$HEX1$$fa00$$ENDHEX$$mero de contrato no puede ser mayor que el correspondiente de forma autom$$HEX1$$e100$$ENDHEX$$tica ("+string(long(c_reg_new))+")"
			end if
		else
			// indicamos que el formato no es valido, y el que deberia tener
			mensaje += "El n$$HEX1$$fa00$$ENDHEX$$mero de contrato no sigue el siguiente patr$$HEX1$$f300$$ENDHEX$$n : "+formato +" donde 'n' son los d$$HEX1$$ed00$$ENDHEX$$gitos de la numeraci$$HEX1$$f300$$ENDHEX$$n correspondiente"
		end if
	end if
else
	// Existe el contrato, por lo que damos error
	mensaje += "El n$$HEX1$$fa00$$ENDHEX$$mero de contrato ya existe"
end if

return mensaje
end function

public function integer wf_crear_fase_estado (string id_fase, datetime fecha, string estado);// Insertamos el estado correspondiente
INSERT INTO fases_estados  
	( id_fase,cod_estado,fecha,usuario )  
VALUES ( :id_fase,:estado,:fecha,:g_usuario);


return SQLCA.sqlcode
end function

public subroutine wf_inhabilita_dw ();long fila

FOR fila = 1 TO long(dw_datos_fase.Object.DataWindow.Column.Count)
	inhabilita_texto(dw_datos_fase, dw_datos_fase.Describe("#"+string(fila)+".Name"))
NEXT

end subroutine

public subroutine wf_rellenar_datos_salida (string n_registro, string n_expediente);//Rellenamos los datos de la ventana
dw_1.SetItem(1,'n_expediente_asignado',n_expediente)
dw_1.SetItem(1,'n_registro_asignado',n_registro)
cb_asignar.enabled=false
dw_1.Object.gb_asignado.Visible=true
dw_1.Object.n_expediente_asignado_t.Visible=true
dw_1.Object.n_registro_asignado_t.Visible=true
dw_1.Object.n_expediente_asignado.Visible=true
dw_1.Object.n_registro_asignado.Visible=true
dw_1.Object.b_ok.Visible=true

end subroutine

public function string wf_validar_expediente (ref boolean b_crear_expediente);// Coprobamos si el expediente existe. Cualquier numero de expediente de a$$HEX1$$f100$$ENDHEX$$os posteriores al actual puede causar replicados
// ALGORITMO SEGUIDO: -> TEnemos el formato que deben seguir los expedientes
//			PUNTO 1: SI EL EXPEDIENTE YA EXISTE... SE PERMITE CONTINUAR SIN PROBLEMAS
//			PUNTO 2: SI NO EXISTE
//					A) SE MIRA SI EL FORMATO LLEVA A$$HEX1$$d100$$ENDHEX$$O
//					B)			SE COMPRUEBA QUE EL A$$HEX1$$d100$$ENDHEX$$O COLOCADO NO SEA POSTERIOR AL ACTUAL CON EL FORMATO QUE USAMOS EN EL SICA,
//									PARA QUE NO SE GENERE ESTE EN EL FUTURO. (SI USAMOS 2 O 3 DIGITOS PARA EL A$$HEX1$$d100$$ENDHEX$$O, SE USA DE BARRERA EL A$$HEX1$$d100$$ENDHEX$$O 75 O 975, 
//									CONSIDERANDOSE DEL 1900 EN LUGAR DEL 2000. ES DECIR EL 78-00009 NO ES DEL 2078, SINO 1978
//					C) 		SI EL A$$HEX1$$d100$$ENDHEX$$O ES JUSTAMENTE EL ACTUAL, SE MIRA QUE LA NUMERACI$$HEX1$$d300$$ENDHEX$$N NO SEA POSTIOR A LA AUTOMATICA
//					c) SI NO LLEVA A$$HEX1$$d100$$ENDHEX$$O EL FORMTO SE MIRA QUE LA NUMERACION NO SEA POSTERIOR A LA AUTOMATICA					




string mensaje = '', n_expediente,c_exp_new, numero, anyo_comprobar, formato, formato_match
long cant, i, enes, aes, des
boolean b_coherente
st_control_eventos c_evento


// Cogemos el numero de expediente
n_expediente = dw_1.getitemstring(1, 'n_expediente')
// Miramos si ya existe
select count(*) into :cant from expedientes where expedientes.n_expedi = :n_expediente;

// Si no existe es cuando verificamos el formato del expediente
if cant = 0 then
	// Miramos el formato que deberia tener actualmente el numero
	c_evento.evento = 'NUMERO_EXP'
	f_control_eventos(c_evento)
	formato = c_evento.param1
	
	formato_match = ''
	for i=1 to LenA(formato)
		if MidA(formato, i, 1) = 'n' then enes++
		if MidA(formato, i, 1) = 'a' then aes++
		if MidA(formato, i, 1) = 'd' then des++
		// en la misma posicion tiene que haber lo mismo en el formato indicado!
		if MidA(formato, i, 1) = 'n' or MidA(formato, i, 1) = 'a' then 
			formato_match += "[0-9]" // Ponemos uno por cada digito
		else
			if MidA(formato, i, 1) = 'd' then
				formato_match += "[A-Z]"
			else
				formato_match += "[" + MidA(formato, i, 1) + "]" // Ponemos que tiene que tener ese codigo por narices
			end if
		end if
	next
	formato_match = "^" + formato_match +"$"
	
	// Comprobamos si hace match
	b_coherente =  match(n_expediente,formato_match)
	
	
	if aes>0 then
		// miramos que el a$$HEX1$$f100$$ENDHEX$$o del expediente no sea posterior al actual. Se usa una barrera de 
		if aes < 4 then 
			if MidA(n_expediente, PosA(formato, 'a'), aes)>RightA('1960', aes) then anyo_comprobar = '1999' else anyo_comprobar = string(year(today()))
		else
			anyo_comprobar = string(year(today()))							
		end if
		
		if b_coherente then
			// Miraremos que el a$$HEX1$$f100$$ENDHEX$$o no sea posterior al actual, y si es igual, que la numeracion no sea posterior
			if LeftA(anyo_comprobar, 4 - aes)+MidA(n_expediente, PosA(formato, 'a'), aes) > anyo_comprobar then
				// No dejamos crear, por ser de a$$HEX1$$f100$$ENDHEX$$os posteriores
				mensaje += "El a$$HEX1$$f100$$ENDHEX$$o del expediente no puede ser mayor que el actual (A$$HEX1$$f100$$ENDHEX$$o indicado : "+LeftA(anyo_comprobar, 4 - aes)+MidA(n_expediente, PosA(formato, 'a'), aes)+")"
				
			elseif LeftA(anyo_comprobar, 4 - aes)+MidA(n_expediente, PosA(formato, 'a'), aes) = string(year(today())) then
				// Miramos si sobrepasa el actual
				// Sacamos el numero
				if g_colegio = 'COAATCC' then
					c_exp_new = f_siguiente_numero_informativo('NUM_EXP_'+f_devuelve_centro(g_cod_delegacion),enes)
				else 
					c_exp_new = f_siguiente_numero_informativo('NUM_EXP',enes)
				end if
				if long(MidA(n_expediente, PosA(formato, 'n'), enes))>=long(c_exp_new) then
					// El numero es mayor o igual, no se puede crear
					mensaje += "El n$$HEX1$$fa00$$ENDHEX$$mero de expediente no puede ser mayor que el correspondiente de forma autom$$HEX1$$e100$$ENDHEX$$tica ("+string(long(c_exp_new))+")"
				else
					// En este caso hay que crear un expediente nuevo
					b_crear_expediente = true
				end if
			else
				// En este caso hay que crear un expediente nuevo
				b_crear_expediente = true
			end if
		else
			// No es un formato coherente... que ponga lo que quiera
			// En este caso hay que crear un expediente nuevo
			b_crear_expediente = true
		end if
	else
		// No lleva el a$$HEX1$$f100$$ENDHEX$$o, por lo que miramos si es un formato coherente. Si no lo es, se deja poner
		if b_coherente then
			// Sacamos el numero
			c_exp_new = f_siguiente_numero_informativo('NUM_EXP',enes)
			// Miramos que el numero no se supere
			if long(MidA(n_expediente, PosA(formato, 'n'), enes))<long(c_exp_new) then
				// En este caso hay que crear un expediente nuevo
				b_crear_expediente = true
			else
				// El numero es mayor o igual, no se puede crear
				mensaje += "El n$$HEX1$$fa00$$ENDHEX$$mero de expediente no puede ser mayor que el correspondiente de forma autom$$HEX1$$e100$$ENDHEX$$tica ("+string(long(c_exp_new))+")"
			end if
			
		else
			// indicamos que el formato no es valido, y el que deberia tener
			mensaje += "El n$$HEX1$$fa00$$ENDHEX$$mero de expediente no sigue el siguiente patr$$HEX1$$f300$$ENDHEX$$n : "+formato +" donde 'n' son los d$$HEX1$$ed00$$ENDHEX$$gitos de la numeraci$$HEX1$$f300$$ENDHEX$$n correspondiente"
		end if
	end if
end if

return mensaje
end function

public function integer wf_crear_fase_cliente (string id_fase, string id_cliente);// RICARDO 2005-05-18
// NUEVA FUNCION QUE SE ENCARGA DE CARGAR UN CLIENTE EN LA FASE CORRESPONDIENTE

INSERT INTO fases_clientes  
         ( id_cliente, porcen, id_fase, contratista, promotor, pagador, facturado, id_representante, reclamar_representante )  
  VALUES ( :id_cliente, 100, :id_fase, 'N', 'S', 'S', 'N', null, 'N' )  ;

return SQLCA.sqlcode

end function

public function integer wf_copiar_fase (string id_fase_origen, string id_expediente, string id_fase_destino, string n_reg, string n_exp, datetime fecha);//Andr$$HEX1$$e900$$ENDHEX$$s 14/09/2005:Creada para la incidencia 3464
//Coge los datos principales, colegiados, clientes y estad$$HEX1$$ed00$$ENDHEX$$sticas de una fase y crea otra con esos datos 
//Si hay alg$$HEX1$$fa00$$ENDHEX$$n dato en dw_datos_fase utiliza $$HEX1$$e900$$ENDHEX$$ste en vez de su hom$$HEX1$$f300$$ENDHEX$$logo en la fase original
//Par$$HEX1$$e100$$ENDHEX$$metros:
//id_fase_origen --> el id_fase de la fase de donde queremos copiar
//id_expediente ---> el id_expediente de la fase que vamos a crear
//id_fase_destino -> el id_fase de la fase que vamos a crear
//n_reg------------> el n_registro de la fase que vamos a crear
//n_exp------------> el n_expedi de la fase que vamos a crear
//fecha------------> fecha de entrada que se le asignar$$HEX2$$e1002000$$ENDHEX$$al contrato en caso de que este campo en dw_datos_fase est$$HEX2$$e9002000$$ENDHEX$$vac$$HEX1$$ed00$$ENDHEX$$o 

//Las variables prefijadas por dw_ contendr$$HEX1$$e100$$ENDHEX$$n los valores de dw_datos_fase
string dw_tipo_registro,dw_tipo_actuacion,dw_tipo_via,dw_emplazamiento,dw_n_calle,dw_descripcion, dw_piso, dw_puerta
string dw_titulo, dw_obs,dw_id_col1, dw_id_col2,dw_id_col3,dw_obs_col1,dw_obs_col2,dw_obs_col3			
string dw_id_cliente,dw_nif_cliente,dw_nombre_cliente,dw_n_salida,dw_estado
datetime dw_f_entrada

//Variables con los datos definitivos de la fase (SELECT)
string sello, tipo_trabajo,trabajo, tipo_via_emplazamiento,emplazamiento, titulo, n_calle, piso, puerta
string poblacion, descripcion, tipo_gestion, modalidad, autorizo,e_mail, cambio_arqui, t_iva
string observaciones, archivo, celda, nr_duplicado, tipo_fase,num_coac
datetime f_visado_coac

//Variables con los datos definitivos de la fase (datos de dw_datos_fase/par$$HEX1$$e100$$ENDHEX$$metros)
string tipo_registro, estado, id_expedi, id_fase, n_registro, n_expedi, fase
datetime f_entrada

//Leemos los datos de dw_datos_fase
dw_tipo_registro		= dw_datos_fase.GetItemString(1, 'tipo_registro')
dw_tipo_actuacion	= dw_datos_fase.GetItemString(1, 'fase')
//$$HEX1$$bf00$$ENDHEX$$tipo_obra				= dw_datos_fase.GetItemString(1, 'tipo_obra')
//$$HEX1$$bf00$$ENDHEX$$destino				= dw_datos_fase.GetItemString(1, 'destino')
dw_tipo_via				= dw_datos_fase.GetItemString(1, 'tipo_via')
dw_emplazamiento 	= dw_datos_fase.GetItemString(1, 'emplazamiento')
dw_n_calle		 		= dw_datos_fase.GetItemString(1, 'n_calle')
dw_piso			 		= dw_datos_fase.GetItemString(1, 'piso')
dw_puerta		 		= dw_datos_fase.GetItemString(1, 'puerta')
dw_f_entrada			= dw_datos_fase.GetItemDateTime(1, 'f_entrada')
//$$HEX1$$bf00$$ENDHEX$$La descripcion hay que guardarla en fases.titulo o fases.descripcion?
//dw_titulo 			= dw_datos_fase.GetItemString(1, 'descripcion')
dw_descripcion		= dw_datos_fase.GetItemString(1, 'descripcion')
//$$HEX1$$bf00$$ENDHEX$$poblacion		= dw_datos_fase.GetItemString(1, 'poblacion')
dw_obs 				= dw_datos_fase.GetItemString(1, 'obs')
dw_id_col1			= dw_datos_fase.GetItemString(1, 'id_col1')
dw_id_col2			= dw_datos_fase.GetItemString(1, 'id_col2')
dw_id_col3			= dw_datos_fase.GetItemString(1, 'id_col3')
dw_obs_col1			= dw_datos_fase.GetItemString(1, 'obs_col1')
dw_obs_col2			= dw_datos_fase.GetItemString(1, 'obs_col2')
dw_obs_col3			= dw_datos_fase.GetItemString(1, 'obs_col3')
dw_id_cliente		= dw_datos_fase.GetItemString(1, 'id_cliente')
dw_nif_cliente		= dw_datos_fase.GetItemString(1, 'nif_cliente')
dw_nombre_cliente	= dw_datos_fase.GetItemString(1, 'nombre_cliente')
dw_n_salida			= dw_datos_fase.GetItemString(1, 'n_salida') 
dw_estado			= dw_datos_fase.GetItemString(1, 'estado')
//$$HEX1$$bf00$$ENDHEX$$tipo_promotor  = dw_datos_fase.GetItemString(1, 'tipo_promotor')	
	
	
SELECT fases.sello,fases.tipo_trabajo,fases.trabajo,
		fases.tipo_via_emplazamiento,fases.emplazamiento,fases.titulo,fases.n_calle,fases.piso, fases.puerta,
		fases.poblacion,fases.descripcion,fases.tipo_gestion,fases.modalidad,fases.autorizo,
		fases.e_mail,fases.cambio_arqui,fases.t_iva,fases.observaciones,fases.archivo,
		fases.celda,fases.nr_duplicado, fases.tipo_fase, fases.num_coac, fases.f_visado_coac,fases.id_tramite, fases.cod_colegio_dest
INTO :sello,:tipo_trabajo,:trabajo,:tipo_via_emplazamiento,:emplazamiento,:titulo,:n_calle, :piso, :puerta,
		:poblacion,:descripcion,:tipo_gestion,:modalidad,:autorizo,:e_mail,:cambio_arqui,
		:t_iva,:observaciones,:archivo,:celda,:nr_duplicado, :tipo_fase, :num_coac, :f_visado_coac,:i_tramite_defecto, :i_cod_colegio_dest
FROM fases  
WHERE fases.id_fase = :id_fase_origen    ;

//Si los datos cogidos de dw_datos_fase no son nulos sobreescribimos las variables que tienen los datos
//de la fase origen 
	//Valores que se cogen directamente de los de dw_datos_fase
tipo_registro=dw_tipo_registro
estado=dw_estado
fase=dw_tipo_actuacion
if isnull(dw_f_entrada) then dw_f_entrada = fecha
f_entrada=dw_f_entrada
	//Valores que se cogen directamente de los par$$HEX1$$e100$$ENDHEX$$metros de entrada
id_expedi=id_expediente
id_fase=id_fase_destino
n_registro= n_reg
n_expedi= n_exp
	//Valores que se cogen preferentemente de dw_datos_fase
if not f_es_vacio(dw_tipo_via) then tipo_via_emplazamiento=dw_tipo_via
if not f_es_vacio(dw_emplazamiento) then emplazamiento=dw_emplazamiento
if not f_es_vacio(dw_n_calle) then n_calle=dw_n_calle
if not f_es_vacio(dw_piso) then piso=dw_piso
if not f_es_vacio(dw_puerta) then puerta=dw_puerta
//if not f_es_vacio(dw_titulo) then titulo=dw_titulo
if not f_es_vacio(dw_descripcion) then descripcion=dw_descripcion
if not f_es_vacio(dw_obs) then observaciones=dw_obs
if not f_es_vacio(dw_n_salida) then archivo=dw_n_salida

//Insertamos el contrato
if SQLCA.sqlcode=0 then
INSERT INTO fases
         ( id_expedi,id_fase,n_registro,n_expedi,f_entrada,titulo,tipo_gestion,descripcion,f_visado,f_abono,
			  estado,archivo,celda,modalidad,sello,r_catastral,e_mail,cambio_arqui,autorizo,observaciones,
			  honorarios,t_iva,fase,honorarios_iva,nr_duplicado,tipo_fase,tipo_trabajo,trabajo,tipo_via_emplazamiento,emplazamiento,
			  poblacion,n_calle,n_copias,usuario,aplicado_10,fa, tipo_registro, piso, puerta,id_tramite, cod_colegio_dest )
  VALUES ( :id_expedi,:id_fase,:n_registro,:n_expedi,:f_entrada,:titulo,:tipo_gestion,:descripcion,null,null,
  			  :estado,:archivo,:celda,:modalidad,null,null,:e_mail,:cambio_arqui,:autorizo,:observaciones,
			  null,:t_iva,:fase,null,:nr_duplicado,:tipo_fase,:tipo_trabajo,:trabajo,:tipo_via_emplazamiento,:emplazamiento,
			  :poblacion,:n_calle,'0',:g_usuario,'N',:g_fa, :tipo_registro, :piso, :puerta,:i_tramite_defecto, :i_cod_colegio_dest);
end if

if SQLCA.sqlcode=0 then
	//Creamos un estado
	wf_crear_fase_estado(id_fase, f_entrada, estado)
end if

//Obtenemos los datos de colegiados
datastore ds_coleg_fase
integer i, n_colegiados=0
string id_col, obs_col
string id_col_temp, obs_col_temp


if not f_es_vacio(dw_id_col1) or not f_es_vacio(dw_id_col2) or not f_es_vacio(dw_id_col3) then
	//Vamos a coger los colegiados de dw_datos_fase
	double porcentaje, hay
	porcentaje = 100
	hay = 0
	if not f_es_vacio(dw_id_col1) then hay++
	if not f_es_vacio(dw_id_col2) then hay++
	if not f_es_vacio(dw_id_col3) then hay++
	if hay <> 0 then porcentaje = porcentaje / hay else porcentaje = 0
	
	if SQLCA.sqlcode=0 then
		// LLamamos a la funcion que crea los colegiados. Como est$$HEX2$$e1002000$$ENDHEX$$tambien ejecuta una select, el valor devuelto por esta funcion
		// sera directamente el de fases si se ha podido crear el colegiado
		if not f_es_vacio(dw_id_col1) then wf_crear_fase_colegiado(id_fase_destino, dw_id_col1, porcentaje, dw_obs_col1)
	end if
	if SQLCA.sqlcode=0 then
		// LLamamos a la funcion que crea los colegiados. Como est$$HEX2$$e1002000$$ENDHEX$$tambien ejecuta una select, el valor devuelto por esta funcion
		// sera directamente el de fases si se ha podido crear el colegiado
		if not f_es_vacio(dw_id_col2) then wf_crear_fase_colegiado(id_fase_destino, dw_id_col2, porcentaje, dw_obs_col2)
	end if

	if SQLCA.sqlcode=0 then
		// LLamamos a la funcion que crea los colegiados. Como est$$HEX2$$e1002000$$ENDHEX$$tambien ejecuta una select, el valor devuelto por esta funcion
		// sera directamente el de fases si se ha podido crear el colegiado
		if not f_es_vacio(dw_id_col3) then wf_crear_fase_colegiado(id_fase_destino, dw_id_col3, porcentaje, dw_obs_col3)
	end if
else 
	//Cogemos los colegiados de la fase origen
	ds_coleg_fase = create datastore
	ds_coleg_fase.dataobject = 'd_lista_colegiados_fase'
	ds_coleg_fase.settransobject(sqlca)
	if SQLCA.sqlcode=0 then ds_coleg_fase.Retrieve(id_fase_origen)

	for i=1 to ds_coleg_fase.RowCount()
		id_col=ds_coleg_fase.getitemstring(i,'id_col')
		porcentaje=ds_coleg_fase.getitemnumber(i,'porcen_a')
		obs_col=ds_coleg_fase.getitemstring(i,'observa')
	 	if SQLCA.sqlcode=0 then
			wf_crear_fase_colegiado(id_fase_destino, id_col, porcentaje, obs_col)
		end if
	next
	
	destroy ds_coleg_fase
end if

//Procesamos los clientes
string id_cliente
if not f_es_vacio(dw_id_cliente) then
	if SQLCA.sqlcode=0 then wf_crear_fase_cliente(id_fase_destino, dw_id_cliente)
else
   datastore ds_cli_fase
	ds_cli_fase = create datastore
	ds_cli_fase.dataobject = 'd_lista_clientes_fase'
	ds_cli_fase.settransobject(sqlca)
 	if SQLCA.sqlcode=0 then ds_cli_fase.Retrieve(id_fase_origen)
	
	for i=1 to ds_cli_fase.rowcount()
		id_cliente=ds_cli_fase.getitemstring(i,'id_cliente')
  		if SQLCA.sqlcode=0 then wf_crear_fase_cliente(id_fase_destino, id_cliente)
	next
	
	destroy ds_cli_fase
end if

//Copiamos las estadisticas
string id_uso
double num_viv,sup_viv,sup_garage,sup_otros,sup_sob,sup_baj,plantas_sob,plantas_baj,pem,volumen
double altura,num_edif,longitud_per,volumen_tierras,valor_terreno,valor_tasacion,valoracion_estim
string colindantes, colindantes2m, tipo_viv,estudio_geo,cc_externo,niv_cont,uso,estructura,t_terreno,t_medicion
string replan_deslin,ctrl_calidad_interno,t_promotor

id_uso = f_siguiente_numero('FASES_USOS', 10)

datastore ds_estadist
ds_estadist = create datastore
ds_estadist.dataobject = 'd_fases_expedientes_estadistica'
ds_estadist.settransobject(sqlca)
if SQLCA.sqlcode=0 then ds_estadist.Retrieve(id_fase_origen)

num_viv=ds_estadist.GetItemNumber(1,'num_viv')//
sup_viv=ds_estadist.GetItemNumber(1,'sup_viv')//
sup_garage=ds_estadist.GetItemNumber(1,'sup_garage')//
sup_otros=ds_estadist.GetItemNumber(1,'sup_otros')//
sup_sob=ds_estadist.GetItemNumber(1,'sup_sob')//
sup_baj=ds_estadist.GetItemNumber(1,'sup_baj')//
plantas_sob=ds_estadist.GetItemNumber(1,'plantas_sob')//
plantas_baj=ds_estadist.GetItemNumber(1,'plantas_baj')//
pem=ds_estadist.GetItemNumber(1,'pem')//
volumen=ds_estadist.GetItemNumber(1,'volumen')//
altura=ds_estadist.GetItemNumber(1,'altura')//
num_edif=ds_estadist.GetItemNumber(1,'num_edif')//
longitud_per=ds_estadist.GetItemNumber(1,'longitud_per')//
volumen_tierras=ds_estadist.GetItemNumber(1,'volumen_tierras')//
valor_terreno=ds_estadist.GetItemNumber(1,'valor_terreno')//
valor_tasacion=ds_estadist.GetItemNumber(1,'valor_tasacion')//
valoracion_estim=ds_estadist.GetItemNumber(1,'valoracion_estim')//
colindantes=ds_estadist.GetItemString(1,'colindantes')//
colindantes2m=ds_estadist.GetItemString(1,'colindantes2m')//
tipo_viv=ds_estadist.GetItemString(1,'tipo_viv')//
estudio_geo=ds_estadist.GetItemString(1,'estudio_geo')//
cc_externo=ds_estadist.GetItemString(1,'cc_externo')//
niv_cont=ds_estadist.GetItemString(1,'niv_cont')//
uso=ds_estadist.GetItemString(1,'uso')//
estructura=ds_estadist.GetItemString(1,'estructura')//
t_terreno=ds_estadist.GetItemString(1,'t_terreno')//
t_medicion=ds_estadist.GetItemString(1,'t_medicion')//
replan_deslin=ds_estadist.GetItemString(1,'replan_deslin')//
ctrl_calidad_interno=ds_estadist.GetItemString(1,'ctrl_calidad_interno')//
t_promotor=ds_estadist.GetItemString(1,'t_promotor')//

if SQLCA.sqlcode=0 then 
INSERT INTO fases_usos (
         id_uso,id_fase,num_viv,sup_viv,sup_garage,sup_otros,sup_sob,sup_baj,plantas_sob,plantas_baj,
			tipo_viv,num_edif,pem,volumen,altura,colindantes,colindantes2m, t_terreno,estudio_geo,cc_externo,niv_cont,longitud_per,
			volumen_tierras,estructura,t_medicion,replan_deslin,valor_terreno,valor_tasacion,valoracion_estim,
			uso,ctrl_calidad_interno,t_promotor)
	VALUES ( :id_uso,:id_fase_destino,:num_viv,:sup_viv,:sup_garage,:sup_otros,:sup_sob,:sup_baj,:plantas_sob,:plantas_baj,
				:tipo_viv,:num_edif,:pem,:volumen,:altura,:colindantes,:colindantes2m, :t_terreno,:estudio_geo,:cc_externo,:niv_cont,:longitud_per,
				:volumen_tierras,:estructura,:t_medicion,:replan_deslin,:valor_terreno,:valor_tasacion,:valoracion_estim,
				:uso,:ctrl_calidad_interno,:t_promotor )  ;
end if
				
destroy ds_estadist

return SQLCA.sqlcode
end function

public subroutine wf_cargar_datos_fase (string id_fase, string opcion);//wf_cargar_datos_fase
//Carga los datos de una fase en dw_datos_fase
//Par$$HEX1$$e100$$ENDHEX$$metros
//id_fase: Fase a cargar
//opcion: Opci$$HEX1$$f300$$ENDHEX$$n de creaci$$HEX1$$f300$$ENDHEX$$n de fase seleccionada (Registro en expediente existente, minuta...)

int i
string ls_tipo_actuacion,ls_tipo_via,ls_emplazamiento,ls_n_calle,ls_descripcion, ls_piso, ls_puerta
string ls_id_col[],ls_n_col[]
string ls_observaciones,ls_nif_cliente,ls_nombre_cliente,ls_id_cliente
datastore ds_colegiados
datastore ds_cliente

select fase,tipo_via_emplazamiento,emplazamiento,n_calle,observaciones,titulo, piso, puerta into
:ls_tipo_actuacion,:ls_tipo_via,:ls_emplazamiento,:ls_n_calle,:ls_observaciones,:ls_descripcion, :ls_piso, :ls_puerta from
fases where id_fase=:id_fase;

//Obtenemos datos de los colegiados
ds_colegiados= create datastore
ds_colegiados.dataobject='d_fases_colegiados'
ds_colegiados.settransobject(SQLCA)
ds_colegiados.retrieve(id_fase)

for i=1 to min(ds_colegiados.rowcount(),3)
	ls_id_col[i]=ds_colegiados.getitemstring(i,'id_col')
	ls_n_col[i]=f_colegiado_n_col(ls_id_col[i])
next

destroy ds_colegiados

//Obtenemos datos del cliente

ds_cliente= create datastore
ds_cliente.dataobject='d_fases_promotores'
ds_cliente.settransobject(SQLCA)
ds_cliente.retrieve(id_fase)

if ds_cliente.rowcount()>0 then
	ls_id_cliente=ds_cliente.getitemstring(1,'id_cliente')
	//ls_nif_cliente=ds_cliente.getitemstring(1,'nif')
	ls_nif_cliente=f_dame_nif(ls_id_cliente)
	ls_nombre_cliente=ds_cliente.getitemstring(1,'cliente')
end if

destroy ds_cliente

//Copiamos los datos a dw_datos_fase
if opcion='M' then
	dw_datos_fase.setitem(1,'fase',ls_tipo_actuacion)
end if

dw_datos_fase.setitem(1,'descripcion',ls_descripcion)
dw_datos_fase.setitem(1,'tipo_via',ls_tipo_via)
dw_datos_fase.setitem(1,'emplazamiento',ls_emplazamiento)
dw_datos_fase.setitem(1,'n_calle',ls_n_calle)
dw_datos_fase.setitem(1,'piso',ls_piso)
dw_datos_fase.setitem(1,'puerta',ls_puerta)
dw_datos_fase.setitem(1,'obs',ls_observaciones)

//for i=1 to min(ds_colegiados.rowcount(),3)
for i=1 to upperbound(ls_id_col)
	if not f_es_vacio(ls_id_col[i]) then
		dw_datos_fase.setitem(1,'id_col'+string(i),ls_id_col[i])
		dw_datos_fase.setitem(1,'n_col'+string(i),ls_n_col[i])
	end if
next

if not f_es_vacio(ls_nif_cliente) then
	dw_datos_fase.setitem(1,'id_cliente',ls_id_cliente)
	dw_datos_fase.setitem(1,'nif_cliente',ls_nif_cliente)
	dw_datos_fase.setitem(1,'nombre_cliente',ls_nombre_cliente)
end if



end subroutine

public function integer wf_crear_fase (string id_expediente, string id_fase, string n_reg, string n_exp, datetime fecha);string centro, celda
double porcentaje, hay
 
// Cogemos el centro de la delegacion
centro = f_devuelve_centro(g_cod_delegacion) 

// En este colegio se utiliza este campo para el n$$HEX1$$fa00$$ENDHEX$$mero de hoja de encargo
if(g_colegio = 'COAATTGN' or g_colegio = 'COAATTEB' or g_colegio = 'COAATLL')then celda = '01'

if g_contratos_preasignados = 'N' then
	// Modificado Ricardo 2005-05-23
	
	
	string tipo_registro, tipo_actuacion,emplazamiento, titulo, obs, id_col1, id_col2,id_cliente,nif_cliente, nombre_cliente, id_tramite
	string n_salida, estado, tipo_obra, destino, tipo_via, poblacion, tipo_promotor, obs_col1, obs_col2, id_col3, obs_col3, n_calle, piso, puerta
	datetime f_entrada
	
	tipo_registro 	= dw_datos_fase.GetItemString(1, 'tipo_registro')
	tipo_actuacion	= dw_datos_fase.GetItemString(1, 'fase')
	tipo_obra		= dw_datos_fase.GetItemString(1, 'tipo_obra')
	destino			= dw_datos_fase.GetItemString(1, 'destino')
	tipo_via			= dw_datos_fase.GetItemString(1, 'tipo_via')
	emplazamiento 	= dw_datos_fase.GetItemString(1, 'emplazamiento')
	n_calle		 	= dw_datos_fase.GetItemString(1, 'n_calle')	
	piso		 		= dw_datos_fase.GetItemString(1, 'piso')	
	puerta		 	= dw_datos_fase.GetItemString(1, 'puerta')		
	f_entrada		= dw_datos_fase.GetItemDateTime(1, 'f_entrada'); if isnull(f_entrada) then f_entrada = fecha
	titulo 				= dw_datos_fase.GetItemString(1, 'descripcion'); if isnull(titulo) then titulo = ''
	poblacion		= dw_datos_fase.GetItemString(1, 'poblacion')
	obs 				= dw_datos_fase.GetItemString(1, 'obs');if isnull(obs) then obs = ''
	id_col1			= dw_datos_fase.GetItemString(1, 'id_col1')
	id_col2			= dw_datos_fase.GetItemString(1, 'id_col2')
	id_col3			= dw_datos_fase.GetItemString(1, 'id_col3')
	obs_col1			= dw_datos_fase.GetItemString(1, 'obs_col1')
	obs_col2			= dw_datos_fase.GetItemString(1, 'obs_col2')
	obs_col3			= dw_datos_fase.GetItemString(1, 'obs_col3')	
	id_cliente		= dw_datos_fase.GetItemString(1, 'id_cliente')
	nif_cliente		= dw_datos_fase.GetItemString(1, 'nif_cliente')
	nombre_cliente	= dw_datos_fase.GetItemString(1, 'nombre_cliente')
	n_salida			= dw_datos_fase.GetItemString(1, 'n_salida'); if f_es_vacio(n_salida) then setnull(n_salida)
	estado			= dw_datos_fase.GetItemString(1, 'estado')
	tipo_promotor  = dw_datos_fase.GetItemString(1, 'tipo_promotor')
    id_tramite  = dw_datos_fase.GetItemString(1, 'id_tramite')

	
	// Si es vacio el id_cliente es que no lo hemos encontrado en la bbdd o que hay varios. PEgamos el nif, si existe y el
	// nombre en las observaciones
	if f_es_vacio (id_cliente) then
		if not f_es_vacio(nif_cliente) or not f_es_vacio(nombre_cliente) then obs = obs + cr + ' Propiedad : '
		if not f_es_vacio(nif_cliente) then obs = obs + ' [ '+nif_cliente + ' ] '
		if not f_es_vacio(nombre_cliente) then obs = obs + ' '+nombre_cliente
	end if
	//Andr$$HEX1$$e900$$ENDHEX$$s 29/9/05 Si el id_cliente no es v$$HEX1$$e100$$ENDHEX$$lido ponemos el del cliente por defecto
	if f_es_vacio(id_cliente) then id_cliente=g_fases_inicio.id_cliente

	
	// I2865 : Paco 23/8/2005: Calculamos el tipo de promotor a partir del NIF  
  	if not f_es_vacio(nif_cliente) and f_es_vacio(tipo_promotor) then	
		if LeftA(nif_cliente,4)='AUTO' then 
			tipo_promotor='X'
		elseif match(nif_cliente,'^[A-Za-z]') then 
			tipo_promotor=LeftA(nif_cliente,1)
		else 
			tipo_promotor='X'
		end if
	end if

	// Insertamos el contrato correspondiente
	 INSERT INTO fases  
         ( id_expedi,id_fase,n_registro,n_expedi,f_entrada,titulo,tipo_gestion,descripcion,f_visado,f_abono,
		  estado,archivo,celda,modalidad,sello,r_catastral,e_mail,cambio_arqui,autorizo,observaciones,
		  honorarios,t_iva,fase,honorarios_iva,nr_duplicado,tipo_fase,tipo_trabajo,trabajo,tipo_via_emplazamiento,emplazamiento,
		  poblacion,n_calle,n_copias,usuario,aplicado_10,fa, tipo_registro, piso, puerta, mantenimiento,id_tramite, cod_colegio_dest )  
	VALUES ( :id_expediente,:id_fase,:n_reg,:n_exp,:f_entrada,null,'P',:titulo,null,null,
  		  :estado,:n_salida,:celda,:centro,null,null,'N','N','N',:obs,
		  null,:g_t_iva_defecto,:tipo_actuacion,null,:ist_control_doc.no_cte,'01',:tipo_obra,:destino,:tipo_via,:emplazamiento,
		  :poblacion,:n_calle,'0',:g_usuario,'N',:g_fa, :tipo_registro, :piso, :puerta, 'N',:id_tramite, :i_cod_colegio_dest);
			  
	fecha = f_entrada			  

else
	n_salida			= dw_datos_fase.GetItemString(1, 'n_salida'); if f_es_vacio(n_salida) then setnull(n_salida)
	estado 			= g_fases_estados.preasignado

  	INSERT INTO fases  
         ( id_expedi,id_fase,n_registro,n_expedi,f_entrada,titulo,tipo_gestion,descripcion,   
           f_visado,f_abono,estado,archivo,celda,modalidad,sello,r_catastral,e_mail,cambio_arqui,   
           autorizo,observaciones,honorarios,t_iva,fase,honorarios_iva,nr_duplicado,   
           tipo_fase,tipo_trabajo,trabajo,tipo_via_emplazamiento,emplazamiento,poblacion,   
           n_calle,n_copias, usuario,aplicado_10,fa, tipo_registro, piso, puerta, mantenimiento,id_tramite, cod_colegio_dest )  
  	VALUES ( :id_expediente,:id_fase,:n_reg,:n_exp,:fecha,null,'P',null,
  		null,null,:estado,:n_salida,:celda,null,null,null,'N','N',
		'N',null,null,:g_t_iva_defecto,null,null,:ist_control_doc.no_cte,
		'01',null,null,null,null,null,null,'0', :g_usuario, 'N', :g_fa, :g_fases_inicio.tipo_registro, :piso, :puerta, 'N',:i_tramite_defecto, :i_cod_colegio_dest);
end if

if SQLCA.sqlcode=0 then
	// LLamamos a la funcion que crea el estado. Como est$$HEX2$$e1002000$$ENDHEX$$tambien ejecuta una select, el valor devuelto por esta funcion
	// sera directamente el de fases estados si las dos son correctas
	wf_crear_fase_estado(id_fase, fecha, estado)
end if

// Calculamos el porcentaje para los colegiados introducidos
porcentaje = 100
hay = 0
if not f_es_vacio(id_col1) then hay++
if not f_es_vacio(id_col2) then hay++
if not f_es_vacio(id_col3) then hay++
if hay <> 0 then porcentaje = porcentaje / hay else porcentaje = 0


if SQLCA.sqlcode=0 then
	// LLamamos a la funcion que crea los colegiados. Como est$$HEX2$$e1002000$$ENDHEX$$tambien ejecuta una select, el valor devuelto por esta funcion
	// sera directamente el de fases si se ha podido crear el colegiado
	if not f_es_vacio(id_col1) then wf_crear_fase_colegiado(id_fase, id_col1, porcentaje, obs_col1)
end if
if SQLCA.sqlcode=0 then
	// LLamamos a la funcion que crea los colegiados. Como est$$HEX2$$e1002000$$ENDHEX$$tambien ejecuta una select, el valor devuelto por esta funcion
	// sera directamente el de fases si se ha podido crear el colegiado
	if not f_es_vacio(id_col2) then wf_crear_fase_colegiado(id_fase, id_col2, porcentaje, obs_col2)
end if

if SQLCA.sqlcode=0 then
	// LLamamos a la funcion que crea los colegiados. Como est$$HEX2$$e1002000$$ENDHEX$$tambien ejecuta una select, el valor devuelto por esta funcion
	// sera directamente el de fases si se ha podido crear el colegiado
	if not f_es_vacio(id_col3) then wf_crear_fase_colegiado(id_fase, id_col3, porcentaje, obs_col3)
end if

if SQLCA.sqlcode=0 then
	// LLamamos a la funcion que crea el cliente. Como est$$HEX2$$e1002000$$ENDHEX$$tambien ejecuta una select, el valor devuelto por esta funcion
	// sera directamente el de fases si se ha podido crear el cliente 
	if dw_datos_fase.GetItemString(1, 'fase')='79' then id_cliente=g_fases_inicio.id_cliente
	if not f_es_vacio(id_cliente) then wf_crear_fase_cliente(id_fase, id_cliente)
end if

if SQLCA.sqlcode = 0 then 
//	if not f_es_vacio(tipo_promotor) then 
		wf_crear_estadistica(id_fase, tipo_promotor)
end if


return SQLCA.sqlcode
end function

public function integer wf_crear_estadistica (string id_fase, string tipo_promotor);// RICARDO 2005-05-23
// NUEVA FUNCION QUE SE ENCARGA DE CREAR LAS ESTADISTICAS


string id_uso

id_uso = f_siguiente_numero('FASES_USOS', 10)

  INSERT INTO fases_usos (
         id_uso,id_fase,sup_viv,sup_garage,sup_otros,sup_sob,sup_baj,plantas_sob,plantas_baj,pem,volumen,  
         altura,estudio_geo,cc_externo,niv_cont,longitud_per,volumen_tierras,ctrl_calidad_interno,t_promotor,
			estructura, replan_deslin, colindantes2m)
	VALUES ( :id_uso,:id_fase,0,0,0,0,0,0,0,0,0,
				0,'N','N','NT',0,0,'N',:tipo_promotor,
				'N', 'N', 'N')  ;

return SQLCA.sqlcode

end function

public function integer wf_crear_fase_colegiado (string id_fase, string id_colegiado, double porcentaje, string obs);// RICARDO 2005-05-18
// NUEVA FUNCION QUE SE ENCARGA DE CARGAR UN COLEGIADO EN LA FASE CORRESPONDIENTE

string id_fases_colegiados, id_col_per, situacion, c_geografico, tipo_alta_src, tiene_src, src_cia = ''
double porc
long i



id_fases_colegiados = f_siguiente_numero('ID_FASES_COLEGIADOS',10)

select situacion, c_geografico into :situacion,:c_geografico from colegiados where id_colegiado = :id_colegiado;

tiene_src = f_colegiado_tiene_src(id_colegiado)
src_cia =  f_colegiado_src_cia(id_colegiado)
	
INSERT INTO fases_colegiados  
         ( id_fase,id_col,porcen_a,porcen_d,tipo_a,tipo_d,empresa,facturado,id_fases_colegiados,renunciado,tipo_gestion,
			  observa,cobertura,porc_aut,porc_dir,otro_seguro,coef_cm, c_geografico, situacion, tiene_src, src_cia)  
  VALUES ( :id_fase,:id_colegiado,:porcentaje,0,'N','S','N','N',:id_fases_colegiados,'N','P',   
           :obs,null,null,null,null,null, :c_geografico,:situacion,:tiene_src,:src_cia )  ;


if SQLCA.sqlcode=0 then
	// Miramos si el colegiado es una sociedad y hacemos lo que corresponde con las sociedades...grrr
	if f_colegiado_tipopersona(id_colegiado) = 'S' then	
		
			datastore ds_colegiados_asociados
			ds_colegiados_asociados = create datastore						
			// Modificado David 28/02/2006 - Obtenemos el porcentaje real, quitando los posibles asociados no colegiados
			ds_colegiados_asociados.dataobject = 'ds_colegiados_personas' //'d_colegiados_personas'
			ds_colegiados_asociados.settransobject(sqlca)								
			ds_colegiados_asociados.retrieve(id_colegiado)
			for i = 1 to ds_colegiados_asociados.rowcount()
				id_col_per = ds_colegiados_asociados.getitemstring(i, 'id_col_per')
				// Modificado David 28/02/2006 - Obtenemos el porcentaje real, quitando los posibles asociados no colegiados
				porc = ds_colegiados_asociados.getitemnumber(i, 'porc_col_real') //'porcent'))
				INSERT into fases_colegiados_asociados 
						 (id_fase, id_col_per, id_col_aso, porcent, id_fases_colegiados)
			   VALUES (:id_fase, :id_col_per, :id_colegiado, :porc, :id_fases_colegiados);
				
				if SQLCA.sqlcode<>0 then
					exit // Salimos del bucle... Como el unico codigo que hay es destruir el ds y devolver el ultimo SQLCA.sqlcode... devolver$$HEX2$$e1002000$$ENDHEX$$error que es lo que toca
				end if
			next
			destroy ds_colegiados_asociados			
		
	end if
end if



return SQLCA.sqlcode
end function

public subroutine wf_rellenar_contrato_defecto ();string id_col
long n_reg

// Modificado Ricardo 2005-05-13
if f_es_vacio(g_fases_inicio.estado) then g_fases_inicio.estado = g_fases_estados.preasignado
// Hacemos que se rellene el dw de pantalla
dw_datos_fase.reset()
dw_datos_fase.insertrow(0)

// Modificado David 28/12/2005
// En minutas ponemos el estado inicial a 'Registrado' (c$$HEX1$$f300$$ENDHEX$$digo 01) y el tipo registro a minuta
if dw_1.getitemstring(1, 'opcion') = 'M' then
	dw_datos_fase.setitem(1, 'estado','01')
	dw_datos_fase.setitem(1, 'tipo_registro', 'MI')
else
	dw_datos_fase.setitem(1, 'estado', g_fases_inicio.estado)
	dw_datos_fase.setitem(1, 'tipo_registro', g_fases_inicio.tipo_registro)
end if

dw_datos_fase.setitem(1, 'fase', g_fases_inicio.tipo_act)
dw_datos_fase.setitem(1, 'tipo_obra', g_fases_inicio.tipo_obra)
dw_datos_fase.setitem(1, 'destino', g_fases_inicio.destino)
dw_datos_fase.setitem(1, 'tipo_via', g_fases_inicio.tipo_via)
dw_datos_fase.setitem(1, 'emplazamiento', g_fases_inicio.emplaz)
dw_datos_fase.setitem(1, 'f_entrada', Today())
dw_datos_fase.setitem(1, 'poblacion', g_fases_inicio.poblacion)
//Andr$$HEX1$$e900$$ENDHEX$$s: 8/8/2005
// El tipo de promotor se determina autom$$HEX1$$e100$$ENDHEX$$ticamente a partir del NIF del (primer) cliente
//dw_datos_fase.setitem(1, 'tipo_promotor', g_fases_inicio.tipo_promotor)
// Si existe ponemos el id_colegiado, sino nada 
id_col = f_colegiado_id_col(g_fases_inicio.colegiado)
if not f_es_vacio(id_col) then
	dw_datos_fase.setitem(1, 'n_col1', g_fases_inicio.colegiado)
	dw_datos_fase.setitem(1, 'id_col1', id_col)
end if
// Si existe ponemos el id_cliente, sino nada
dw_datos_fase.setitem(1, 'id_cliente', g_fases_inicio.id_cliente)
dw_datos_fase.setitem(1, 'nif_cliente', f_dame_nif(g_fases_inicio.id_cliente))
dw_datos_fase.setitem(1, 'nombre_cliente', f_dame_cliente(g_fases_inicio.id_cliente))
// FIN Modificado Ricardo 2005-05-13
dw_datos_fase.setitem(1, 'id_tramite', i_tramite_defecto)

end subroutine

public function integer wf_crear_expediente (string id_expediente, string exp, datetime fecha);if g_colegio = 'COAATZ' or g_colegio = 'COAATLE' then
	datetime f_nula
	setnull(f_nula)
	fecha = f_nula
end if

// En este colegio se utiliza este campo para el n$$HEX1$$fa00$$ENDHEX$$mero de hoja de encargo
string celda
if(g_colegio = 'COAATTGN' or g_colegio = 'COAATTEB' or g_colegio = 'COAATLL')then celda = '01'


// Hacemos la insercion en expedientes
INSERT INTO expedientes  
	( id_expedi, n_expedi, titulo, f_inicio, cerrado, f_cierre, ult_fase, tipo_trabajo, trabajo, tipo_via_emplazamiento,
	emplazamiento, poblacion, f_contrato, anulado, n_exp_blanco, r_catastral, archivo, celda, n_calle, sup_garage, sup_otros,
	pem, plantas_sob, sup_sob, plantas_baj, sup_baj, altura, estudio_geo, cc_externo, niv_cont, volumen, sup_viv,
	administracion, longitud_per, volumen_tierras, estructura, replan_deslin, valor_terreno, valor_tasacion, valoracion_estim )  
VALUES 
	( :id_expediente, :exp, null, :fecha, 'N', null, null, null, null, null,
	null, null, null, null, 'N', null, null, :celda, null, 0, 0,
	0, 0, 0, 0, 0, 0, 'N', 'N', 'NT', 0, 0, 
	'N', 0, 0, 'N', 'N', 0, 0, 0);


return SQLCA.sqlcode

end function

on w_fases_creacion_fases.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_asignar=create cb_asignar
this.cb_cerrar=create cb_cerrar
this.dw_datos_fase=create dw_datos_fase
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_asignar
this.Control[iCurrent+3]=this.cb_cerrar
this.Control[iCurrent+4]=this.dw_datos_fase
this.Control[iCurrent+5]=this.gb_1
end on

on w_fases_creacion_fases.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_asignar)
destroy(this.cb_cerrar)
destroy(this.dw_datos_fase)
destroy(this.gb_1)
end on

event open;call super::open;if f_es_vacio(g_contratos_preasignados) then g_contratos_preasignados = 'N'


// Cogemos los parametros que nos pasan
ist_datos_fase = message.PowerObjectParm

select texto into :i_tramite_defecto from var_globales where nombre='g_tramite_defecto';
//if f_es_vacio(i_tramite_defecto) then i_tramite_defecto="REDAP"

select texto into :i_cod_colegio_dest from var_globales where nombre='g_cod_colegio';

// Llamamos al control de eventos con el dw_1 para que coloque las opciones (si es necesario)
st_control_eventos c_evento
c_evento.evento = 'ABRIR_CREACION_FASES'
c_evento.dw = dw_1
if f_control_eventos(c_evento)=-1 then return

choose case ist_datos_fase.opcion_importacion
	case 'F'
		// Fase nueva
			dw_1.SetItem(1,'n_expediente',f_dame_numero_expedi( ist_datos_fase.id_expedi))
	case 'E'
		// Fase y exp nuevos
		ist_datos_fase.id_expedi=''
	case 'I'
		// solo documentos nuevos
		dw_1.SetItem(1,'n_expediente',f_dame_numero_expedi( ist_datos_fase.id_expedi))		
end choose
// Lanzamos el itemchanged
dw_1.SetItem(1,'opcion',ist_datos_fase.opcion_importacion)
dw_1.Trigger event Itemchanged(1,dw_1.object.opcion,ist_datos_fase.opcion_importacion)


// Lo de imprimir etiqueta ahora va por el ini
dw_1.setitem(dw_1.getrow(), 'etiqueta', ProfileString(gnv_app.of_GetAppInifile(), "Parametros", "ImpresionPreasignacion","N")   )
dw_1.setitem(dw_1.getrow(), 'introducir_ahora', ProfileString(gnv_app.of_GetAppInifile(), "Parametros", "PreasignacionIntroducirAhora","S")   )

// Modificado Ricardo 2005-04-28
// Independientemente del ini, si venimos desde visared, hay que marcar el check
if g_fase_visared.opcion_importacion = 'S' then
	dw_1.setitem(dw_1.getrow(), 'introducir_ahora','S')
end if
// FIN Modificado Ricardo 2005-04-28

// Modificado David 13/03/2006 - En Guadalajara si no es de visared desmarcamos (INC. 4707)
if g_colegio = 'COAATGU' and g_fase_visared.opcion_importacion <> 'S' then
	dw_1.setitem(dw_1.getrow(), 'introducir_ahora','N')
end if

wf_rellenar_contrato_defecto() // Modificado Ricardo 2005-05-13
if g_contratos_preasignados <> 'N' then	wf_inhabilita_dw()// Modificado Ricardo 2005-05-18

// Llamamos al control de eventos evento 'ABRIR_CREA_FASE'
c_evento.evento = 'ABRIR_CREA_FASE'
c_evento.dw = dw_1
if f_control_eventos(c_evento)=-1 then return


// centramos esta ventana
f_centrar_ventana(this)





end event

event pfc_postopen();call super::pfc_postopen;// Colocamos el calendario
dw_datos_fase.of_SetDropDownCalendar(True)
dw_datos_fase.iuo_calendar.of_register(dw_datos_fase.iuo_calendar.DDLB)
dw_datos_fase.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_datos_fase.iuo_calendar.of_SetInitialValue(True)

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_creacion_fases
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_creacion_fases
end type

type dw_1 from u_dw within w_fases_creacion_fases
event csd_colocar_opciones ( string opciones,  string columnas )
integer x = 37
integer y = 32
integer width = 2565
integer height = 688
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_fases_datos_creacion"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_colocar_opciones(string opciones, string columnas);dw_1.modify("opcion.values = '"+opciones+"'")
dw_1.modify("opcion.RadioButtons.Columns= "+columnas)

end event

event constructor;call super::constructor;dw_1.InsertRow(0)
end event

event buttonclicked;call super::buttonclicked;CHOOSE CASE dwo.name 
	CASE 'b_ok'
		// Cuando pulsen el bot$$HEX1$$f300$$ENDHEX$$n volvemos a dejarlo todo como al principio
		cb_asignar.enabled=true
		dw_1.Object.gb_asignado.Visible=false
		dw_1.Object.n_expediente_asignado_t.Visible=false
		dw_1.Object.n_registro_asignado_t.Visible=false
		dw_1.Object.n_expediente_asignado.Visible=false
		dw_1.Object.n_registro_asignado.Visible=false
		dw_1.Object.b_ok.Visible=false
		
		// Hacemos que se rellene el contrato por defecto
		wf_rellenar_contrato_defecto()
END CHOOSE

end event

event itemchanged;call super::itemchanged;//
string ls_id_fase_origen,ls_id_expediente
long cant

CHOOSE CASE dwo.name
	CASE 'opcion'
		CHOOSE CASE data
			CASE 'E' 
				// En este caso, inhabilitamos el expediente
				inhabilita_texto(dw_1,'n_expediente')
				// Ocultamos el texto del n_salida
				this.object.n_salida.visible = false
				this.object.n_salida_t.visible = false
				this.setitem(row, 'n_salida', '')
				dw_datos_fase.setitem(1, 'tipo_registro', g_fases_inicio.tipo_registro)
				dw_datos_fase.setitem(1,'estado','00')
			CASE 'F'
				// Si es con una fase, habilitamos el texto para que puedan colocar el expediente
				habilita_texto(dw_1,'n_expediente',30)
				// Ocultamos el texto del n_salida
				this.object.n_salida.visible = false
				this.object.n_salida_t.visible = false
				this.setitem(row, 'n_salida', '')
				dw_datos_fase.setitem(1, 'tipo_registro', g_fases_inicio.tipo_registro)
				dw_datos_fase.setitem(1,'estado','00')
			CASE 'M'
				// En este caso, inhabilitamos el expediente
				inhabilita_texto(dw_1,'n_expediente')
				dw_datos_fase.setitem(1, 'tipo_registro', 'MI')
				//Ponemos el estado inicial a 'Registrado' (c$$HEX1$$f300$$ENDHEX$$digo 01)
				dw_datos_fase.setitem(1,'estado','01')
				// Si es con una minuta, visualizamos el texto para que puedan colocar el n_salida
				this.object.n_salida.visible = true
				this.object.n_salida_t.visible = true
			CASE ELSE
				// En el resto de casos, inhabilitamos el expediente
				inhabilita_texto(dw_1,'n_expediente')
				// Ocultamos el texto del n_salida
				this.object.n_salida.visible = false
				this.object.n_salida_t.visible = false
				this.setitem(row, 'n_salida', '')
				dw_datos_fase.setitem(1, 'tipo_registro', g_fases_inicio.tipo_registro)
				dw_datos_fase.setitem(1,'estado','00')
		END CHOOSE
	CASE 'tipo_numeracion'
		CHOOSE CASE data
			CASE 'M' // Numeracion manual... el texto del expediente editable
				habilita_texto(dw_1,'n_expediente',30)
			CASE ELSE
				// Depende del campo de opcion
				this.post event itemchanged(row, this.object.opcion, this.GetItemString(row, 'opcion'))
		END CHOOSE
	case 'n_expediente'
		if this.getitemstring(row,'opcion')='F' then
	   	SELECT expedientes.id_expedi INTO :ls_id_expediente FROM expedientes where expedientes.n_expedi=:data;
   		//Cargamos los datos de una fase del expediente que nos pasan
   		datastore ds_fases_expediente
   		ds_fases_expediente=create datastore
   		ds_fases_expediente.dataobject='d_expedientes_fases'
   		ds_fases_expediente.settransobject(sqlca)
   		ds_fases_expediente.retrieve(ls_id_expediente)
			if ds_fases_expediente.rowcount()>0 then
   			ls_id_fase_origen=ds_fases_expediente.getitemstring(1,'id_fase')
	   		wf_cargar_datos_fase(ls_id_fase_origen,'F')
			end if
			destroy ds_fases_expediente
		end if
	case 'n_salida'
		if this.getitemstring(row,'opcion')='M' then
    		if not f_es_vacio(data) then
      		CHOOSE CASE g_colegio
	     		CASE 'COAATGC'
		   		// El numero de salida va en la cabecera
		   		SELECT count(*) INTO :cant FROM expedientes WHERE expedientes.archivo = :data;
	     		CASE ELSE
		  		// El numero de salida va por contrato
		  		SELECT count(distinct id_expedi) INTO :cant FROM fases WHERE fases.archivo = :data;
      		END CHOOSE
      		if cant=1 then
        		//Revisar el caso 'COAATGC'
        			SELECT fases.id_fase into :ls_id_fase_origen FROM fases WHERE fases.archivo=:data;
        			wf_cargar_datos_fase(ls_id_fase_origen,'M')
      		end if
    		end if
  		end if
END CHOOSE
end event

type cb_asignar from commandbutton within w_fases_creacion_fases
integer x = 800
integer y = 1680
integer width = 402
integer height = 116
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Asignar"
boolean default = true
end type

event clicked;string intro, id_fase


this.enabled=true
dw_1.AcceptText()
dw_datos_fase.AcceptText()

CHOOSE CASE dw_1.GetItemString(1,'tipo_numeracion')
	CASE 'A' // Automatica
		CHOOSE CASE dw_1.GetItemString(1,'opcion')
			CASE 'E' // Expediente y contrato nuevo
				id_fase = parent.trigger event csd_opcion_expediente_contrato()
			CASE 'F' // Solo contrato
				id_fase = parent.trigger event csd_opcion_contrato()
			CASE 'I' // Solo documentos
				id_fase = parent.trigger event csd_opcion_documentos()
			CASE 'N' // Preasignar al nulo
				id_fase = parent.trigger event csd_opcion_nulo()
			CASE 'M' // Preasignar minutas
				id_fase = parent.trigger event csd_opcion_minuta()
		END CHOOSE
	CASE 'M' // Manual
		id_fase = parent.trigger event csd_opcion_manual()
END CHOOSE
// Si no nos devuelven un id_fase, salimos de este evento
if id_fase = '-1' then 
	return
end if

//Si introducimos los datos de la fase ahora 
intro=dw_1.GetItemString(1,'introducir_ahora')
if intro ='N' or f_es_vacio(intro)  then return
// Colocamos los datos correspondientes y abrimos
g_fases_consulta.id_fase = id_fase

Close(Parent)	
opensheet(g_detalle_fases, 'w_fases_detalle', w_aplic_frame, 0, original!)
end event

type cb_cerrar from commandbutton within w_fases_creacion_fases
integer x = 1367
integer y = 1680
integer width = 402
integer height = 116
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
end type

event clicked;Close(parent)
end event

type dw_datos_fase from u_dw within w_fases_creacion_fases
integer x = 37
integer y = 800
integer width = 2523
integer height = 832
integer taborder = 11
string dataobject = "d_fases_datos_creacion_datos_fase"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;string id_col, nif,id_cliente
long num_clientes
st_control_eventos c_evento
any mensaje

CHOOSE CASE dwo.name
	CASE 'n_col1'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_col1',id_col)
		if f_es_vacio(id_col) or id_col = '-1' then 
			post messagebox(g_titulo, "El colegiado indicado no existe")
			return 2
		end if
		c_evento.id_colegiado = id_col
		c_evento.evento = 'FASES_COLEGIADOS_NCO'
		c_evento.dw = this 
		mensaje=f_control_eventos(c_evento)
		// Ponemos lo que haya puesto el control de eventos
		this.setitem(row, 'obs_col1', this.getitemstring(row, 'observaciones'))
		this.setitem(row, 'observaciones', '')
		
		
	CASE 'n_col2'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_col2',id_col)
		if f_es_vacio(id_col) or id_col = '-1' then 
			post messagebox(g_titulo, "El colegiado indicado no existe")
			return 2
		end if
		
		c_evento.id_colegiado = id_col
		c_evento.evento = 'FASES_COLEGIADOS_NCO'
		c_evento.dw = this 
		mensaje=f_control_eventos(c_evento)
		// Ponemos lo que haya puesto el control de eventos
		this.setitem(row, 'obs_col2', this.getitemstring(row, 'observaciones'))
		this.setitem(row, 'observaciones', '')		

	CASE 'n_col3'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_col3',id_col)
		if f_es_vacio(id_col) or id_col = '-1' then 
			post messagebox(g_titulo, "El colegiado indicado no existe")
			return 2
		end if
		c_evento.id_colegiado = id_col
		c_evento.evento = 'FASES_COLEGIADOS_NCO'
		c_evento.dw = this 
		mensaje=f_control_eventos(c_evento)
		// Ponemos lo que haya puesto el control de eventos
		this.setitem(row, 'obs_col3', this.getitemstring(row, 'observaciones'))
		this.setitem(row, 'observaciones', '')
		
	CASE 'nif_cliente'
		// SCP-99
//		// El NIF / CIF tiene que ser de 9
//		if LenA(data) <> 9 then
//			messagebox(g_titulo, 'El NIF/CIF tiene que ser de 9 posiciones.')
//			this.setitem(row ,'id_cliente','')
//			return -1
//		end if
		nif = data
		if RightA(nif, 1) = '*' then
			nif = f_calculo_nif(nif)
			if nif = '-1' then return -1
			this.post setitem(row ,'nif_cliente',nif)
		elseif RightA(nif,1) >= 'A' and RightA(nif,1) <= 'Z' then
			if not f_comprobar_nif(nif) then
				messagebox(g_titulo, 'La letra del NIF no es correcto')
				this.setitem(row ,'id_cliente','')
				return -1
			end if
		end if

		select count(*) into :num_clientes from clientes where nif=:nif;
		if num_clientes > 0 then  
			if num_clientes = 1 then
				id_cliente = f_cliente_id_cliente(nif)
				this.setitem(row ,'id_cliente',id_cliente)
				this.setitem(row ,'nombre_cliente',f_dame_cliente(id_cliente))
			else
				post Messagebox(g_titulo, "Existe m$$HEX1$$e100$$ENDHEX$$s de un cliente con ese NIF", stopsign!)
				this.setitem(row ,'id_cliente','')
			end if
		else
			post Messagebox(g_titulo, "No existe el NIF del cliente")
			this.setitem(row ,'id_cliente','')
			return -1
		end if
END CHOOSE

end event

event buttonclicked;call super::buttonclicked;string id_colegiado
any mensaje
string pob, ls_anterior
st_control_eventos c_evento

choose case dwo.name
	case 'cb_busq_col1'
		// C$$HEX1$$f300$$ENDHEX$$digo c$$HEX1$$f300$$ENDHEX$$mun para los tres botones
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"

		id_colegiado=f_busqueda_colegiados()
		if f_es_vacio(id_colegiado) then return
		// 
		this.setitem(row,'id_col1',id_colegiado)
		// C$$HEX1$$f300$$ENDHEX$$digo c$$HEX1$$f300$$ENDHEX$$mun para los tres botones
		this.setitem(row,'n_col1',f_colegiado_n_col(id_colegiado))
		c_evento.id_colegiado = id_colegiado
		c_evento.evento = 'FASES_COLEGIADOS_NCO'
		c_evento.dw = this 
		mensaje=f_control_eventos(c_evento)
		//
		this.setitem(row, 'obs_col1', this.getitemstring(row, 'observaciones'))
		this.setitem(row, 'observaciones', '')
		
	case 'cb_busq_col2'
		// C$$HEX1$$f300$$ENDHEX$$digo c$$HEX1$$f300$$ENDHEX$$mun para los tres botones
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"

		id_colegiado=f_busqueda_colegiados()
		if f_es_vacio(id_colegiado) then return
		// 
		this.setitem(row,'id_col2',id_colegiado)
		// C$$HEX1$$f300$$ENDHEX$$digo c$$HEX1$$f300$$ENDHEX$$mun para los tres botones
		this.setitem(row,'n_col2',f_colegiado_n_col(id_colegiado))
		c_evento.id_colegiado = id_colegiado
		c_evento.evento = 'FASES_COLEGIADOS_NCO'
		c_evento.dw = this 
		mensaje=f_control_eventos(c_evento)
		//
		this.setitem(row, 'obs_col2', this.getitemstring(row, 'observaciones'))
		this.setitem(row, 'observaciones', '')
	case 'cb_busq_col3'
		// C$$HEX1$$f300$$ENDHEX$$digo c$$HEX1$$f300$$ENDHEX$$mun para los tres botones
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"

		id_colegiado=f_busqueda_colegiados()
		if f_es_vacio(id_colegiado) then return
		// 
		this.setitem(row,'id_col3',id_colegiado)
		// C$$HEX1$$f300$$ENDHEX$$digo c$$HEX1$$f300$$ENDHEX$$mun para los tres botones
		this.setitem(row,'n_col3',f_colegiado_n_col(id_colegiado))
		c_evento.id_colegiado = id_colegiado
		c_evento.evento = 'FASES_COLEGIADOS_NCO'
		c_evento.dw = this 
		mensaje=f_control_eventos(c_evento)
		//
		this.setitem(row, 'obs_col3', this.getitemstring(row, 'observaciones'))
		this.setitem(row, 'observaciones', '')
	case 'cb_pob'
		st_busqueda_poblaciones lst_busq_pob
		lst_busq_pob.cod_provincia =  '000' + g_cod_prov_colegio
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		ls_anterior = g_bloqueo_fases
		g_bloqueo_fases = 'S'
		openwithparm(w_busqueda_poblaciones,lst_busq_pob)
		g_bloqueo_fases = ls_anterior
		pob = Message.StringParm
		if f_es_vacio(pob) then return
		this.SetItem(1,'poblacion',pob)
end choose
		
end event

type gb_1 from groupbox within w_fases_creacion_fases
integer x = 37
integer y = 736
integer width = 2560
integer height = 928
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
string text = "Datos Contrato: "
end type

