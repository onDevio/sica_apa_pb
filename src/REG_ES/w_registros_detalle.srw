HA$PBExportHeader$w_registros_detalle.srw
forward
global type w_registros_detalle from w_detalle
end type
type tab_1 from tab within w_registros_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_registros_anexos from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_registros_anexos dw_registros_anexos
end type
type tab_1 from tab within w_registros_detalle
tabpage_1 tabpage_1
end type
type cb_1 from commandbutton within w_registros_detalle
end type
type cb_2 from commandbutton within w_registros_detalle
end type
type cb_3 from commandbutton within w_registros_detalle
end type
type cb_4 from commandbutton within w_registros_detalle
end type
type cb_5 from commandbutton within w_registros_detalle
end type
type cb_borrar_vinculacion from commandbutton within w_registros_detalle
end type
end forward

global type w_registros_detalle from w_detalle
integer x = 64
integer width = 3653
integer height = 2260
string title = "Ventana de Detalle Registros"
event csd_abrir_fichero_anexo ( integer file )
event csd_borrar_rem_des ( string op )
event csd_corregir_campo ( )
tab_1 tab_1
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
cb_borrar_vinculacion cb_borrar_vinculacion
end type
global w_registros_detalle w_registros_detalle

type variables
u_dw idw_registros_anexos
boolean i_ha_pasado, i_grabado
string i_id_expediente
integer i_posicion,i_linea
datawindow i_dw

end variables

forward prototypes
public function string wf_obtener_ruta_doc (string id_doc_modulo)
end prototypes

event csd_corregir_campo;i_dw.setitem(i_linea,i_posicion,'')
i_dw.setcolumn(i_posicion)
end event

public function string wf_obtener_ruta_doc (string id_doc_modulo);//
string ruta,anyo,id_registro,serie,ruta_base
string id_tipo_modulo,id_modulo,nombre
datetime fecha

if f_es_vacio(id_doc_modulo) then
	
	fecha=dw_1.GetItemDatetime(dw_1.GetRow(),'fecha')
	id_registro=dw_1.GetItemString(dw_1.GetRow(),'id_registro')
	anyo=string(year(date(fecha)))
	
	if IsNull(fecha) then fecha=datetime(today())
	
	ruta=g_directorio_e_s+anyo+"\"+id_registro+"\"
	if Not(DirectoryExists(g_directorio_e_s+anyo+"\")) then CreateDirectory(g_directorio_e_s+anyo+"\")
	if Not(DirectoryExists(g_directorio_e_s+anyo+"\"+id_registro+"\")) then CreateDirectory(g_directorio_e_s+anyo+"\"+id_registro+"\")
	
else
	serie=dw_1.GetItemString(dw_1.GetRow(),'serie')
	select ruta_base into :ruta_base from registro_series where codigo=:serie and (cod_delegacion=:g_cod_delegacion or cod_delegacion='%');
	select id_tipo_modulo,id_modulo,anyo,nombre_fichero
	into :id_tipo_modulo,:id_modulo,:anyo,:nombre
	from csd_doc_modulo where id_documento_modulo=:id_doc_modulo;
	
	//ruta=ruta_base+id_tipo_modulo+'\'+anyo+'\'+id_modulo+'\'
	ruta=ruta_base+anyo+'\'+id_modulo+'\'
	if Not(DirectoryExists(ruta_base+id_tipo_modulo+'\'+anyo+'\')) then CreateDirectory(ruta_base+id_tipo_modulo+'\'+id_modulo+'\')
	if Not(DirectoryExists(ruta_base+id_tipo_modulo+'\'+anyo+'\'+id_modulo+'\')) then CreateDirectory(ruta_base+id_tipo_modulo+'\'+id_modulo+'\'+anyo+'\')
		
end if

return ruta
end function

on w_registros_detalle.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_borrar_vinculacion=create cb_borrar_vinculacion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_4
this.Control[iCurrent+6]=this.cb_5
this.Control[iCurrent+7]=this.cb_borrar_vinculacion
end on

on w_registros_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_borrar_vinculacion)
end on

event w_registros_detalle::activate;call super::activate;g_dw_lista  = g_dw_lista_registros
g_w_lista   = g_lista_registros
g_w_detalle = g_detalle_registros
g_lista     = 'w_registros_lista'
g_detalle   = 'w_registros_detalle'

end event

event open;call super::open;w_fases_detalle ventana
string titulo,id_fase,exp,n_registro
idw_registros_anexos = tab_1.tabpage_1.dw_registros_anexos

//A partir de este momento, cualquier referencia a las dw esclavas dentro de la 
//ventana se hara por idw_esclava1 o idw_esclava2
//dw_1.of_setlinkage(TRUE)  Esto se hace en la Ventana Padre

f_enlaza_dw(dw_1, idw_registros_anexos, 'id_registro', 'id_registro')

//A partir de aqui se pueden introducir las funciones de cambios de tama#o y
//posicion de los controles de la ventana.

inv_resize.of_register (tab_1, "scaletoRight&Bottom")
inv_resize.of_register (idw_registros_anexos, "scaletoRight&Bottom")


// Eloy 15/04/09 CODIGO A$$HEX1$$d100$$ENDHEX$$ADIDO PARA CREAR UN REGISTRO ENLAZADO CON UNA FASE
// (LLAMADA DESDE EL DETALLE DE FASES)

if Isvalid(g_detalle_fases) then
	ventana=g_detalle_fases
	
	if ventana.reg_es_datos_fase then
		id_fase=ventana.dw_1.GetItemString(ventana.dw_1.GetRow(),'id_fase')
		ventana.reg_es_datos_fase=false
		event csd_nuevo()
		SELECT fases.n_expedi, fases.n_registro  INTO :exp, :n_registro  FROM fases   WHERE fases.id_fase = :id_fase   ;			
		dw_1.setitem(1,'n_expediente',n_registro)			
		dw_1.setitem(1,'n_expedi',id_fase)			
		
	end if
end if

//datawindowchild series
//dw_1.GetChild ('serie',series)
//series.SetFilter("registro.empresa='"+g_empresa+"'")
//series.Filter()



end event

event csd_nuevo;call super::csd_nuevo;string id_fase


If AncestorReturnValue>0 then
	id_fase=Message.stringParm
	//Introducimos en el campo clave el valor obtenido desde el contador.
	dw_1.SetItem(dw_1.GetRow(),'id_registro',f_siguiente_numero('REGISTROS',10))
	dw_1.SetItem(dw_1.GetRow(),'empresa',g_empresa)
	
	inhabilita(dw_1,'n_registro')
	
	//donde "n" es un entero que indica la longitud en caracteres del contador
	dw_1.setfocus()
	
	//Inicializacion de campos: f_alta, f_colegiacion a la fecha actual
	Dw_1.setitem(1, 'fecha', datetime(Today()) )
	Dw_1.setitem(1, 'fecha_grabacion', datetime(Today()) )
	
	Dw_1.setitem(1, 'cod_delegacion', g_cod_delegacion )
	

	if(g_colegio<>'COAATTGN' and g_colegio<>'COAATTEB' AND  g_colegio<>'COAATLL')then dw_1.SetItem(dw_1.GetRow(),'serie','RE')

	f_reg_es_filtrar_serie(dw_1,'E')
//	datawindowchild dwc_serie
//	dw_1.GetChild('serie',dwc_serie)
//
//	dwc_serie.SetFilter("(cod_delegacion = '"+g_cod_delegacion+"' or cod_delegacion = '%') and tipo='E'")
//	dwc_serie.Filter()
//	
	i_id_expediente=''
	
	if i_ha_pasado=true then 
		g_cer_reg.id_escrito=''
	end if
	if g_cer_reg.id_escrito <> '' and i_ha_pasado = false then
		dw_1.setitem(1,'f_escrito',g_cer_reg.f_intro)	
		dw_1.setitem(1,'f_vencimiento',g_cer_reg.f_vencimiento)
		dw_1.setitem(1,'asunto',g_cer_reg.descripcion)	
		i_ha_pasado=true
	end if
	
	
	st_control_eventos c_evento
	c_evento.evento = 'REGISTRO_NUEVO'
	c_evento.dw = dw_1
	if f_control_eventos(c_evento)=-1 then return -1	
	
	//idw_registros_cesion_datos_internet.Event  pfc_addrow()
	//idw_registros_cesion_datos_internet.setitemstatus(1,0,Primary!,DataModified!)
end if

return AncestorReturnValue
end event

event csd_anterior;call super::csd_anterior;if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then
	g_registros_consulta.id_registro = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'id_registro')
	dw_1.event csd_retrieve()
end if
end event

event csd_siguiente;call super::csd_siguiente;if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then
	g_registros_consulta.id_registro = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'id_registro')
	dw_1.event csd_retrieve()
end if
end event

event csd_primero;call super::csd_primero;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(1)
	g_dw_lista.scrolltorow(1)
	g_registros_consulta.id_registro = g_dw_lista.getitemstring(1,"id_registro")
	
	dw_1.event csd_retrieve()
end if
end event

event csd_ultimo;call super::csd_ultimo;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(g_dw_lista.rowcount())
	g_dw_lista.scrolltorow(g_dw_lista.rowcount())
	g_registros_consulta.id_registro = g_dw_lista.getitemstring(g_dw_lista.rowcount(),"id_registro")
	
	dw_1.event csd_retrieve()
end if
end event

event pfc_preupdate;call super::pfc_preupdate;//control de permisos
long num_digitos
st_control_eventos c_evento
if f_puedo_escribir(g_usuario, '0000000003')= -1 then return -1
string mensaje='', tipo_pers = '',serie

//Validaciones del datawindows principal (dw_1)
//---------------------------------------------
mensaje=mensaje + f_valida(dw_1,'fecha','NONULO',g_idioma.of_getmsg('msg_entsal.especif_fecha','Debe especificar un valor en el campo Fecha.'))
if dw_1.GetItemString(1, 'tipo_persona_o') <> 'O' then	mensaje=mensaje + f_valida(dw_1,'codigo_o','NOVACIO',g_idioma.of_getmsg('msg_entsal.especif_codig_orig','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo Origen.'))
mensaje=mensaje + f_valida(dw_1,'nombre_o','NOVACIO',g_idioma.of_getmsg('msg_entsal.especif_remitente','Debe especificar un valor en el campo Remitente.'))
mensaje=mensaje + f_valida(dw_1,'tipo_persona_o','NOVACIO',g_idioma.of_getmsg('msg_entsal.especif_tipo_persona','Debe especificar un valor en el campo Tipo de Persona Origen.'))
if dw_1.GetItemString(1, 'tipo_persona_d') <> 'O' then	mensaje=mensaje + f_valida(dw_1,'codigo_d','NOVACIO',g_idioma.of_getmsg('msg_entsal.especif_cod_destino','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo Destino.'))
mensaje=mensaje + f_valida(dw_1,'nombre_d','NOVACIO',g_idioma.of_getmsg('msg_entsal.especif_destinatario','Debe especificar un valor en el campo Destinatario.'))
mensaje=mensaje + f_valida(dw_1,'tipo_persona_d','NOVACIO',g_idioma.of_getmsg('msg_entsal.especif_tipo_persona_destino','Debe especificar un valor en el campo Tipo de Persona Destino.'))
 if f_reg_es_series_activadas() then mensaje=mensaje + f_valida(dw_1,'serie','NOVACIO',g_idioma.of_getmsg('msg_entsal.especif_serie','Debe especificar un valor en el campo SERIE.'))

c_evento.evento = 'REGISTRO_ES'
f_control_eventos(c_evento)

if f_es_vacio(c_evento.param1) then
	c_evento.param1='nnnnnnnnn'
end if

//Validaciones del datawindows de anexos (dw_registros_anexos)
//------------------------------------------------------------
//mensaje=mensaje + f_valida(idw_registros_anexos,'Fichero adjunto','NOVACIO','')
// mensaje=mensaje + f_valida(idw_registros_anexos,'programa','NOVACIO','Debe especificar un valor en la columna Tipo de Programa.')

mensaje=mensaje + f_valida(idw_registros_anexos,'ruta','NOVACIO',g_idioma.of_getmsg('msg_entsal.especif_ruta_anexo','Debe especificar un valor para la ruta del anexo'))

int i
int suma=0

//fin 
int retorno=1
if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
else
	//S$$HEX1$$f300$$ENDHEX$$lo si se genera el registro a partir de un escrito.
	if g_cer_reg.id_escrito <> '' then
		i_grabado=true
		// grabar en tabla 
		string uno,dos,tres
		uno=f_siguiente_numero('REGISTROS_E_S', 10)
		dos=g_cer_reg.id_escrito
		tres=dw_1.getitemstring(1,'id_registro')
		INSERT INTO escritos_e_s (id_escritos_e_s, id_escrito, id_e_s)
				VALUES (:uno, :dos, :tres) ;	
		UPDATE escritos_certificados
		SET registrado = 'S'
		WHERE id_escrito  = :dos
		USING sqlca ;
		COMMIT USING sqlca ;				
				
	end if	
	if g_reg_exp.id_fase_a <> '' and g_reg_exp.id_fase_n <> '' then //Hay anterior y cambia
	
		UPDATE fases_registros_es
		SET id_fase = :g_reg_exp.id_fase_n
		WHERE id_registro  = :g_reg_exp.id_registro
		USING sqlca ;
		COMMIT USING sqlca ;
			
	end if	
	if g_reg_exp.id_fase_a='' and g_reg_exp.id_fase_n <> '' then // no hay anterior y cambia 
		uno=f_siguiente_numero('FASES-REGISTROS', 10)
		INSERT INTO fases_registros_es (id_escrito, id_fase, id_registro)
				VALUES (:uno, :g_reg_exp.id_fase_n, :g_reg_exp.id_registro) ;		
	end if
	
end if

// Si todas las validaciones son correctas se actualiza Nro. registro. S$$HEX1$$f300$$ENDHEX$$lo si es Oficial.
string oficial, es, interno,registrobis,n_registro_bis
int opc
string contador_reg_e, contador_reg_s, contador_reg_interno
if not(f_reg_es_series_activadas()) then
	// Para MURCIA
	contador_reg_e = 'REGISTRO_ENTRADA'
	contador_reg_s = 'REGISTRO_SALIDA'
	contador_reg_interno = 'REGISTRO_ES_INTERNO'
	if g_colegio = 'COAATMU'  and dw_1.getitemstring(1,'cod_delegacion') = 'C' then
		contador_reg_e = 'REGISTRO_ENTRADA_C'
		contador_reg_s = 'REGISTRO_SALIDA_C'
		contador_reg_interno = 'REGISTRO_ES_INTER_C'
	end if
	// Comentado debido a que actualmente en Zaragoza la variable g_reg_es_series = 'S'
//	// La delegaci$$HEX1$$f300$$ENDHEX$$n 01 es el Consejo de Arag$$HEX1$$f300$$ENDHEX$$n
//	if g_colegio = 'COAATZ'  and dw_1.getitemstring(1,'cod_delegacion') = '01' then
//		contador_reg_e = 'REGISTRO_ENTRADA_C'
//		contador_reg_s = 'REGISTRO_SALIDA_C'
//		contador_reg_interno = 'REGISTRO_ES_INTER_C'
//	end if
end if

oficial = dw_1.getitemstring(dw_1.GetRow(),'oficial')
es = dw_1.getitemstring(dw_1.GetRow(),'es')
interno = dw_1.getitemstring(dw_1.GetRow(),'interno')
n_registro_bis = dw_1.getitemstring(dw_1.GetRow(),'n_registro_bis')
serie=dw_1.getitemstring(dw_1.GetRow(),'serie')

if mensaje='' and f_es_vacio(dw_1.getitemstring(dw_1.GetRow(),'n_registro')) then
	//Hacemos la comprobaci$$HEX1$$f300$$ENDHEX$$n del campo n_registro_bis
	if f_es_vacio(n_registro_bis) then
		if f_reg_es_series_activadas() then
			dw_1.SetItem(dw_1.GetRow(),'n_registro',serie+'-'+f_numera_reg_salida(c_evento.param1,serie)) //f_siguiente_numero_reg_es(serie,num_digitos))
		else
			if oficial = 'S' and interno <> 'S' then
				choose case es
					case 'E'
						 dw_1.SetItem(dw_1.GetRow(),'n_registro',f_siguiente_numero(contador_reg_e,10))
					case 'S'
						dw_1.SetItem(dw_1.GetRow(),'n_registro',f_siguiente_numero(contador_reg_s,10))
				end choose		
			else
				dw_1.SetItem(dw_1.GetRow(),'n_registro',f_siguiente_numero(contador_reg_interno,10))
			end if	
		end if
	else
		opc=messagebox(g_titulo,g_idioma.of_getmsg('msg_entsal.cumplimentar','El valor del N$$HEX2$$ba002000$$ENDHEX$$Registro se cumplimentar$$HEX2$$e1002000$$ENDHEX$$con el valor N$$HEX2$$ba002000$$ENDHEX$$Registro Bis, si no desea hacerlo el valor ser$$HEX2$$e1002000$$ENDHEX$$el par$$HEX1$$e100$$ENDHEX$$metro interno habitual.')+cr+g_idioma.of_getmsg('msg_entsal.desea_operacion','$$HEX1$$bf00$$ENDHEX$$Desea realizar esta operacion?'),Information!,YesNo!)
		if opc=1 then
			registrobis=n_registro_bis//+'/BIS'
			//Comprobamos que no existe un registro con el mismo nombre.
			if f_existe_nregistro(registrobis) then
				string cadena[]
				cadena[1]=registrobis
				//messagebox(g_titulo,'Ya existe un registro con el nombre:  '+registrobis,Stopsign!)
				messagebox(g_titulo,g_idioma.of_getmsg('msg_entsal.existe_registro',cadena),Stopsign!)
				retorno=-1
			else
				dw_1.SetItem(dw_1.GetRow(),'n_registro',registrobis)
			end if
		else
			if f_reg_es_series_activadas() then
				dw_1.SetItem(dw_1.GetRow(),'n_registro',serie+'-'+f_numera_reg_salida(c_evento.param1,serie)) //f_siguiente_numero_reg_es(serie,num_digitos))
			else			
				if oficial = 'S' and interno <> 'S' then
					choose case es
						case 'E'
							 dw_1.SetItem(dw_1.GetRow(),'n_registro',f_siguiente_numero(contador_reg_e,10))
						case 'S'
							dw_1.SetItem(dw_1.GetRow(),'n_registro',f_siguiente_numero(contador_reg_s,10))
					end choose		
				else
					dw_1.SetItem(dw_1.GetRow(),'n_registro',f_siguiente_numero(contador_reg_interno,10))
				end if	
			end if
		end if
	end if
end if

string reg_referencia,reg_ref1,reg_ref2,n_registro
datetime fecha,f_salida
// Buscamos el registro de entrada asociado y le establecemos la fecha de salida
n_registro=dw_1.GetItemString(dw_1.GetRow(),'n_registro')
reg_referencia=dw_1.GetItemString(dw_1.GetRow(),'n_registro_ref')
fecha=dw_1.GetItemDateTime(dw_1.GetRow(),'fecha')

if dw_1.GetItemString(dw_1.GetRow(),'es')='S' and not(f_es_vacio(reg_referencia)) then
	select es into :es from registro where n_registro=:reg_referencia;
	if es='E' then
		select f_salida,n_registro_ref,n_registro_bis into :f_salida,:reg_ref1,:reg_ref2 from registro where n_registro=:reg_referencia;
		if IsNull(f_salida) then  // Si no tiene fecha de salida....
			if MessageBox("Atencion!","Existe un registro de entrada asociado.$$HEX1$$bf00$$ENDHEX$$Marcar la fecha de salida en el registro de entrada?",Question!,YesNo!)=1 then
				if f_es_vacio(reg_ref1) then   // Si el campo n_registro_ref est$$HEX2$$e1002000$$ENDHEX$$vacio enlazamos la entrada con la salida por este campo
					update registro set salida='S',f_salida=:fecha,n_registro_ref=:n_registro where n_registro=:reg_referencia;
				else
					update registro set salida='S',f_salida=:fecha,n_registro_bis=:n_registro where n_registro=:reg_referencia;
				end if
			end if
		end if
	end if
end if	


return retorno

end event

event close;call super::close;if g_cer_reg.id_escrito <> '' and i_grabado=true then
	g_cer_reg.id_escrito=''	
	post messagebox(g_titulo,g_idioma.of_getmsg('msg_entsal.cambios_reg_asoc','Se han producido cambios en los Registros Asociados.') + cr + g_idioma.of_getmsg('msg_entsal.cambios_ver_cambios','Dichos cambios se veran la proxima vez que abra esta ventana.'))
end if
end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_registros_detalle
string tag = "texto=general.recuperar_pantalla"
integer x = 3561
integer y = 2024
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_registros_detalle
string tag = "texto=general.guardar_pantalla"
integer x = 3561
integer y = 1904
end type

type cb_nuevo from w_detalle`cb_nuevo within w_registros_detalle
string tag = "texto=general.nuevo"
end type

type cb_ayuda from w_detalle`cb_ayuda within w_registros_detalle
string tag = "texto=general.ayuda"
end type

type cb_grabar from w_detalle`cb_grabar within w_registros_detalle
string tag = "texto=general.grabar"
end type

type cb_ant from w_detalle`cb_ant within w_registros_detalle
end type

type cb_sig from w_detalle`cb_sig within w_registros_detalle
end type

type dw_1 from w_detalle`dw_1 within w_registros_detalle
event csd_borrar_exp ( )
event csd_borrar_rem_des ( string op )
integer x = 9
integer y = 4
integer width = 3552
integer height = 1100
string dataobject = "d_registros_detalle"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_1::csd_borrar_exp();MessageBox(g_titulo,g_idioma.of_getmsg('msg_entsal.exp_no_existe','Este expediente NO existe.'))
dw_1.setitem(1,'exp','')
dw_1.setitem(1,'n_expediente','')
dw_1.setcolumn(30)
end event

event dw_1::csd_retrieve;call super::csd_retrieve;int    retorno
string exp
double i
if g_registros_consulta.id_registro = '' or isnull(g_registros_consulta.id_registro) then return
retorno = parent.event closequery()
if retorno = 1 then return
this.retrieve(g_registros_consulta.id_registro)
g_registros_consulta.id_registro=''

if f_tengo_permiso(g_usuario,'REG_ES_MOD','E')=1 then habilita(dw_1,'n_registro',5)

//if not isnull(dw_1.getitemstring(1,'n_expediente')) then
//	i_id_expediente=dw_1.getitemstring(1,'n_expediente')
//	SELECT fases.n_expedi  INTO :exp  FROM fases   WHERE fases.id_fase = :i_id_expediente ;			
//	dw_1.setitem(1,'exp',exp)	
//end if
//g_registros_consulta.id_registro=''
//
end event

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event dw_1::itemchanged;string  nulo,tipo_exp
string nre
	st_control_eventos c_evento


// Verifica si se ha modificado la Situacion
//------------------------------------------
LONG retonno
string tipo_persona, codigo_o, codigo_d, nombre_o, nombre_d, cod_valido, poblacion, id_o, id_d,cod_postal
retonno = 0

CHOOSE CASE	dwo.name

   //Si es el tipo de persona se inicializan los campos para su reingreso
	CASE 'tipo_persona_o'
		dw_1.setitem(1,'codigo_o',"")
		dw_1.setitem(1,'id_o',"")
		dw_1.setitem(1,'nombre_o',"")
		dw_1.setitem(1,'poblacion_o','')	 		
		dw_1.setitem(1,'departamento_o',"")
	CASE 'tipo_persona_d'
		dw_1.setitem(1,'codigo_d',"")
		dw_1.setitem(1,'id_d',"")		
		dw_1.setitem(1,'nombre_d',"")
		dw_1.setitem(1,'poblacion_d','')	 			
		dw_1.setitem(1,'departamento_d',"")
		
	CASE 'codigo_o'
      codigo_o     = data
		tipo_persona = this.getitemstring(this.getrow(),'tipo_persona_o')
		dw_1.setitem(1,'id_o',"")
		dw_1.setitem(1,'nombre_o',"")
		dw_1.setitem(1,'poblacion_o','')	 		
		choose case tipo_persona
      	case 'C'
				id_o = f_busca_id_colegiado_por_codigo(codigo_o)
				nombre_o = f_colegiado_certificados(id_o)

				SELECT domicilios.cod_pob INTO :poblacion  FROM domicilios  WHERE domicilios.id_colegiado like : id_o  ;
				cod_postal=f_colegiado_cp(id_o)
				if f_es_vacio(cod_postal) or cod_postal='00000' then cod_postal=f_devuelve_cod_postal(poblacion)
				dw_1.SetItem(dw_1.GetRow(),'cp_o',cod_postal)					
			case 'U'
				nombre_o = f_usuario(codigo_o)
			case 'O'
				nombre_o = f_otras_personas(codigo_o)
		end choose
		// se comprueba si el codigo ingresado es correcto
		if f_es_vacio(nombre_o) then
			messagebox(g_titulo,g_idioma.of_getmsg('msg_entsal.cod_origen_inval',"El C$$HEX1$$f300$$ENDHEX$$digo Origen introducido no es v$$HEX1$$e100$$ENDHEX$$lido"))
			dw_1.setitem(1,'tipo_persona_o',"")
			dw_1.setitem(1,'id_o',"")
			dw_1.setitem(1,'nombre_o',"")
			dw_1.setitem(1,'poblacion_o','')	 
			dw_1.setitem(1,'tipo_persona_o',tipo_persona)
		else
			dw_1.setitem(1,'codigo_o',codigo_o)
		   dw_1.setitem(1,'nombre_o',nombre_o)
			if tipo_persona = 'C' then 
	  			dw_1.setitem(1,'id_o',f_busca_id_colegiado_por_codigo(codigo_o))
 				dw_1.setitem(1,'poblacion_o',poblacion)	 
			else 
				dw_1.setitem(1,'id_o',codigo_o)
			end if
		end if

	CASE 'codigo_d'
      codigo_d     = data
		tipo_persona = this.getitemstring(this.getrow(),'tipo_persona_d')
		dw_1.setitem(1,'id_d',"")
		dw_1.setitem(1,'nombre_d',"")
		dw_1.setitem(1,'poblacion_d','')	 		
		choose case tipo_persona
      	case 'C'
				id_d = f_busca_id_colegiado_por_codigo(codigo_d)
				nombre_d = f_colegiado_certificados(id_d)
				SELECT domicilios.cod_pob 	INTO :poblacion  	FROM domicilios  WHERE domicilios.id_colegiado like :id_d   ;
				cod_postal=f_colegiado_cp(id_d)
				if f_es_vacio(cod_postal) or cod_postal='00000' then cod_postal=f_devuelve_cod_postal(poblacion)
				dw_1.SetItem(dw_1.GetRow(),'cp_d',cod_postal)						
			case 'U'
				nombre_d = f_usuario(codigo_d)
			case 'O'
				nombre_d = f_otras_personas(codigo_d)
		end choose
		// se comprueba si el codigo ingresado es correcto
		if f_es_vacio(nombre_d) then
			messagebox(g_titulo,g_idioma.of_getmsg('msg_entsal.cod_destino_inval',"El C$$HEX1$$f300$$ENDHEX$$digo Destino introducido no es v$$HEX1$$e100$$ENDHEX$$lido"))
			
			dw_1.setitem(1,'tipo_persona_d',"")
			dw_1.setitem(1,'id_d',"")
			dw_1.setitem(1,'nombre_d',"")
			dw_1.setitem(1,'poblacion_d','')	 
			dw_1.setitem(1,'tipo_persona_d',tipo_persona)
		else
			dw_1.setitem(1,'codigo_d',codigo_d)
			dw_1.setitem(1,'nombre_d',nombre_d)
			if tipo_persona = 'C' then 
	  			dw_1.setitem(1,'id_d',f_busca_id_colegiado_por_codigo(codigo_d))
  				dw_1.setitem(1,'poblacion_d',poblacion)	 
			else 
				dw_1.setitem(1,'id_d',codigo_d)
			end if
		end if

	CASE 'nombre_o'
		dw_1.setitem(1,'codigo_o',"")
		dw_1.setitem(1,'id_o',"")		
	
	CASE 'nombre_d'
		dw_1.setitem(1,'codigo_d',"")
		dw_1.setitem(1,'id_d',"")		
	
	CASE 'n_registro'
		if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Se va a cambiar el N$$HEX1$$fa00$$ENDHEX$$mero de Registro. Esto podr$$HEX1$$ed00$$ENDHEX$$a provocar errores de numeraci$$HEX1$$f300$$ENDHEX$$n. $$HEX1$$bf00$$ENDHEX$$Est$$HEX1$$e100$$ENDHEX$$s seguro?",Question!,YesNo!)=1 then
			return 0
		else
			return 2
		end if
	
	case 'interno'
		nre = this.GetItemString(this.GetRow(),'n_registro')
		if not f_es_vacio(nre) then
			messagebox(g_titulo,g_idioma.of_getmsg('msg_entsal.no_cambia_tipo_reg','No se puede cambiar el tipo de registro cuando tiene asignado un n$$HEX1$$fa00$$ENDHEX$$mero de registro.'))
			retonno = 1
		end if
		

		c_evento.evento = 'REGISTRO_CAMBIO_ES'
		c_evento.dw = dw_1
		if f_control_eventos(c_evento)=-1 then return -1					
		
	case 'es'

	
		nre = this.GetItemString(this.GetRow(),'n_registro')
		if not f_es_vacio(nre) then
			messagebox(g_titulo,g_idioma.of_getmsg('msg_entsal.no_cambia_tipo_reg','No se puede cambiar el tipo de registro cuando tiene asignado un n$$HEX1$$fa00$$ENDHEX$$mero de registro.'))
			 return 2
		end if	

			DataWindowChild dwc_serie
			if(g_colegio<>'COAATTGN' and g_colegio<>'COAATTEB' AND g_colegio<>'COAATLL')then
				if data='E' then
					this.SetItem(row,'serie','RE')
				else
					this.SetItem(row,'serie','RS')
				end if
			end if
			this.GetChild('serie',dwc_serie)
			dwc_serie.SetFilter("(cod_delegacion = '"+g_cod_delegacion+"' or cod_delegacion = '%') and tipo='"+data+"' and empresa='"+g_empresa+"'")
			dwc_serie.Filter()
	
		
			c_evento.evento = 'REGISTRO_CAMBIO_ES'
			c_evento.dw = dw_1
			if f_control_eventos(c_evento)=-1 then return -1				
		
//	case 'n_expediente'
//		tipo_exp=f_expediente_correcto(data)
//		if tipo_exp='X' then
//			MessageBox(g_titulo,'El expediente que ha introducido no es correcto.')
//			i_posicion=getcolumn()
//			i_linea=1
//			i_dw=this
//			parent.postevent("csd_corregir_campo")
//		end if

	case 'poblacion_o'
		cod_postal=f_devuelve_cod_postal(data)
		this.setitem(1,'cp_o',cod_postal)
	case 'poblacion_d'
		cod_postal=f_devuelve_cod_postal(data)
		this.setitem(1,'cp_d',cod_postal)
//		string id_fase
//		if len(data) < 12 then
//			SELECT expedientes.id_expedi  INTO :id_fase  FROM expedientes  WHERE expedientes.n_expedi = :data   ;
//		else
//			SELECT fases.id_fase  INTO :id_fase  FROM fases  WHERE fases.n_expedi = :data   ;	
//		end if
//		if isnull(id_fase) or id_fase='' then
//			this.postevent ("csd_borrar_exp")
//		else
//			setnull(nulo)
//			if len(data) < 12 then
//				dw_1.setitem(1,'n_expedi',id_fase)
//				dw_1.setitem(1,'n_expediente',nulo)
//			else
//				dw_1.setitem(1,'n_expediente',id_fase)
//				dw_1.setitem(1,'n_expedi',nulo)
//			end if
//			g_reg_exp.id_registro=dw_1.getitemstring(1,'id_registro')
//			g_reg_exp.id_fase_a=i_id_expediente
//			g_reg_exp.id_fase_n=id_fase
//			MessageBox(g_titulo,'La grabaci$$HEX1$$f300$$ENDHEX$$n de este cambio de N$$HEX2$$ba002000$$ENDHEX$$de expediente' + cr + &
//				'afectr$$HEX2$$e1002000$$ENDHEX$$al expediente anterior y a este en sus registros E/S.')
//		end if
		
END CHOOSE

RETURN retonno

end event

event dw_1::doubleclicked;call super::doubleclicked;string texto, asunto, reg, id_reg,id_fase
long num
g_busqueda.solo_despliega_texto=False

this.AcceptText()

CHOOSE CASE dwo.name
	CASE 'texto'
		g_busqueda.titulo="Texto"
		texto = this.GetItemString(row, 'texto')
		openwithparm(w_observaciones, texto)
		if Message.Stringparm <> '-1' then
			texto = Message.Stringparm
			if not f_es_vacio(texto) then this.SetItem(row,'texto',texto)
		end if

	CASE 'asunto'
		g_busqueda.titulo="Asunto"
		asunto = this.GetItemString(1, 'asunto')
		openwithparm(w_observaciones, asunto)
		if Message.Stringparm <> '-1' then 
			asunto = Message.Stringparm
			if not f_es_vacio(asunto) then this.SetItem(1,'asunto',asunto)
		end if
		
	CASE 'n_registro_ref','n_registro_bis'
		reg=this.GetItemString(this.GetRow(),string(dwo.name))
		select id_registro into :id_reg from registro where n_registro=:reg;
		if not(f_es_vacio(id_reg)) and not(f_es_vacio(reg)) then
			g_registros_consulta.id_registro= id_reg
			this.event csd_retrieve()
		end if
	CASE 'n_expediente','compute_1'
		id_fase=dw_1.GetItemString(dw_1.GetRow(),'n_expedi')
		select count(*) into :num from fases where id_fase=:id_fase;
		if num=0 then 
			MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","No se ha encontrado el contrato")
			return
		end if
		g_fases_consulta.id_fase=id_fase
		g_fase_visared.opcion_importacion = 'N'
		message.stringparm = "w_fases_detalle"
		
		w_aplic_frame.postevent("csd_fasesdetalle")	
		
END CHOOSE
end event

event dw_1::itemerror;call super::itemerror;return 1
end event

event dw_1::retrieveend;call super::retrieveend;string exp,n_expedi,n_expediente,n_registro,serie

n_registro=dw_1.getitemstring(dw_1.GetRow(),'n_registro')
serie=left(n_registro,pos(n_registro,'-') - 1)
this.SetItem(dw_1.GetRow(),'serie',serie)
n_expedi=dw_1.getitemstring(1,'n_expedi')
n_expediente=dw_1.getitemstring(1,'n_expediente')
if not isnull(n_expedi) then
	SELECT expedientes.n_expedi INTO :exp  FROM expedientes  WHERE expedientes.id_expedi = :n_expedi ;
end if
if not isnull(n_expediente) then
	SELECT fases.n_expedi INTO :exp FROM fases  WHERE fases.id_fase = :n_expediente ; 
end if
dw_1.setitem(1,'exp',exp)

//Andr$$HEX1$$e900$$ENDHEX$$s: Inicializamos los c$$HEX1$$f300$$ENDHEX$$digos postales
this.setitem(1,'cp_o',f_devuelve_cod_postal(this.getitemstring(1,'poblacion_o')))
this.setitem(1,'cp_d',f_devuelve_cod_postal(this.getitemstring(1,'poblacion_d')))

f_reg_es_filtrar_serie(dw_1,dw_1.GetItemString(dw_1.GetRow(),'es'))

f_fecha_registro(g_colegio,dw_1,29,5)
f_resetupdate_dws(getactivesheet())
end event

event dw_1::buttonclicked;call super::buttonclicked;string pob,cod_postal,cod_provincia,id_curso,n_reg
integer res,i
string ls_cod_usuario,ls_email,ls_usuario
string id_col
st_mail parametros
string ls_cuerpo,ls_asunto,n_registro
string ruta_base,ruta_fichero,id_registro
datetime fecha

CHOOSE CASE dwo.name

	CASE 'b_poblaciones'
		//Si pulsamos el boton de  poblaciones
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(1,'poblacion_o',pob)
		
		if this.GetItemString(this.GetRow(),'tipo_persona_o')='C' then
			id_col=this.GetItemString(this.GetRow(),'id_o')
			cod_postal=f_colegiado_cp(id_col)
			if f_es_vacio(cod_postal) or cod_postal='00000' then cod_postal=f_devuelve_cod_postal(pob)
		else
			cod_postal=f_devuelve_cod_postal(pob)
		end if
		this.setitem(1,'cp_o',cod_postal)
	
  CASE 'b_poblaciones_d'
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(1,'poblacion_d',pob)
		cod_postal=f_devuelve_cod_postal(pob)
		this.setitem(1,'cp_d',cod_postal)
	CASE 'b_notificar'
		
		if dw_1.GetItemString(dw_1.Getrow(),'tipo_persona_d')<>'U' then
			MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","El destinatario debe ser algun usuario del sistema")
			return
		end if

		ls_cod_usuario=dw_1.GetItemString(dw_1.Getrow(),'codigo_d')		
		select email,nombre_usuario into :ls_email,:ls_usuario from t_usuario where cod_usuario=:ls_cod_usuario;
			
		if f_es_vacio(ls_email) then
			MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","El destinatario no tiene email")
			return
		end if
		
		
		ls_cuerpo=dw_1.GetItemString(dw_1.Getrow(),'asunto')	
		if IsNull(ls_cuerpo) then ls_cuerpo=''
		n_reg=dw_1.GetItemString(dw_1.Getrow(),'n_registro')
		fecha=dw_1.GetItemDateTime(dw_1.GetRow(),'fecha')
		if IsNull(n_reg) then n_reg=''
		
		choose case g_colegio
			case 'COAATTGN', 'COAATTEB' , 'COAATLL'
				ls_cuerpo="Remitent: "+dw_1.GetItemString(dw_1.GetRow(),'nombre_o')+"  "+cr+ls_cuerpo
				if dw_1.GetItemString(dw_1.Getrow(),'es')='E' then
					ls_asunto="Registre Entrada ["+n_reg+"] [Data Entrada: "+string(fecha,'dd/mm/yyyy')+"]"
				else
					ls_asunto="Registre Sortida ["+n_reg+"] [Data Entrada: "+string(fecha,'dd/mm/yyyy')+"]"
				end if						
							
			case else
				if dw_1.GetItemString(dw_1.Getrow(),'es')='E' then
					ls_asunto="Registro de Entrada "+n_reg
				else
					ls_asunto="Registro de Salida "+n_reg
				end if						
				
		end choose
	
		
		parametros.asunto =ls_asunto
		parametros.direccion = ls_email
		parametros.mensaje = ls_cuerpo
		parametros.permitir_adjuntar_manualmente='S'
		parametros.dw_adjuntos='d_email_adjuntos'
		ruta_base=wf_obtener_ruta_doc('')		
			for i = 1 to  idw_registros_anexos.rowcount()
				ruta_fichero=idw_registros_anexos.getitemstring(i,'ruta')
				if FileExists(ruta_base+ruta_fichero) then
					parametros.adjuntos[i]=	ruta_base+ruta_fichero
				else
					id_registro=dw_1.GetItemString(dw_1.GetRow(),'id_registro')
					parametros.adjuntos[i]=	g_directorio_e_s+"1900\"+ruta_fichero
				end if
			next		
		
		if g_sistema_mailing='O' then
			OpenWithParm(w_csd_mail_send, parametros)
		else
			OpenWithParm(w_csd_mail_send_sock, parametros)
		end if		
		
		
		
		
		/*
		datastore ds_enviados
		string ls_dw_err	,ls_sql_syntax,ls_dw_syntax
		string ls_cuerpo,ls_asunto,n_registro
		long ll_fila_aux
		ds_enviados = create datastore
		ls_sql_syntax= "  SELECT csd_sms_enviados.movil_contacto,  csd_sms_enviados.nif, csd_sms_enviados.nombre, " + &   
		" csd_sms_enviados.apellidos,  csd_sms_enviados.f_envio, csd_sms_enviados.envio, csd_sms_enviados.mensaje, " + &   
		" csd_sms_enviados.id_sms, csd_sms_enviados.id_campanya, csd_sms_enviados.id_sms_predefinido, csd_sms_enviados.envio_mensaje, " + &   
		" csd_sms_enviados.tipo_aviso, csd_sms_enviados.email, csd_sms_enviados.fecha_envio_final, csd_sms_enviados.hora_envio,  " + & 
		" csd_sms_enviados.texto, csd_sms_enviados.id_sms_enviados  FROM csd_sms_enviados    "
		
		if dw_1.GetItemString(dw_1.Getrow(),'tipo_persona_d')<>'U' then
			MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","El destinatario debe ser algun usuario del sistema")
			return
		end if

		ls_cod_usuario=dw_1.GetItemString(dw_1.Getrow(),'codigo_d')		
		select email into :ls_email from t_usuario where cod_usuario=:ls_cod_usuario;
			
		if f_es_vacio(ls_email) then
			MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","El destinatario no tiene email")
			return
		end if
	
		ls_dw_syntax = SQLCA.SyntaxFromSQL(ls_sql_syntax , "style(type=grid) ", ls_dw_err)
		ds_enviados.create(ls_dw_syntax,ls_dw_err)
		ds_enviados.settransobject(SQLCA)


		ll_fila_aux=ds_enviados.insertRow(0)
		

		ds_enviados.setitem(ll_fila_aux,'id_sms_enviados',f_siguiente_numero("SMS_ENVIADOS",10))
		ds_enviados.setitem(ll_fila_aux,'nombre',dw_1.GetItemString(dw_1.Getrow(),'nombre_d'))
		ds_enviados.setitem(ll_fila_aux,'apellidos','')
		ds_enviados.setitem(ll_fila_aux,'movil_contacto','')
		ds_enviados.setitem(ll_fila_aux,'email',ls_email)

		ds_enviados.setitem(ll_fila_aux,'id_sms',"")
		ds_enviados.setitem(ll_fila_aux,'f_envio',datetime(string(today(),"dd-mm-yyyy")))
		ds_enviados.setitem(ll_fila_aux,'hora_envio',time(string(now(),"hh:mm")))	
		ds_enviados.setitem(ll_fila_aux,'envio_mensaje','N')	
		ds_enviados.setitem(ll_fila_aux,'tipo_aviso','E')			
		ls_cuerpo=dw_1.GetItemString(dw_1.Getrow(),'asunto')	
		n_reg=dw_1.GetItemString(dw_1.Getrow(),'n_registro')
		if IsNull(n_reg) then n_reg=''
		if dw_1.GetItemString(dw_1.Getrow(),'es')='E' then
			ls_asunto="Registro de Entrada "+n_reg
		else
			ls_asunto="Registro de Salida "+n_reg
		end if		
		ds_enviados.setitem(ll_fila_aux,'mensaje',ls_asunto)
		ds_enviados.setitem(ll_fila_aux,'texto',ls_cuerpo)		
		res=ds_enviados.update()
		
		if res=-1 then
			MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Hubo un error al enviar el mensaje")
		else
			MessageBox(g_titulo,"Mensaje a$$HEX1$$f100$$ENDHEX$$adido a la cola de mensajes")
		end if
		
		
		*/
		
		
	CASE ELSE
END CHOOSE


return 1

end event

type tab_1 from tab within w_registros_detalle
event create ( )
event destroy ( )
integer x = 23
integer y = 1120
integer width = 3525
integer height = 904
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
string tag = "texto=reg_es.anexo"
integer x = 18
integer y = 100
integer width = 3488
integer height = 788
long backcolor = 79741120
string text = "Anexos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_registros_anexos dw_registros_anexos
end type

on tabpage_1.create
this.dw_registros_anexos=create dw_registros_anexos
this.Control[]={this.dw_registros_anexos}
end on

on tabpage_1.destroy
destroy(this.dw_registros_anexos)
end on

type dw_registros_anexos from u_dw within tabpage_1
event csd_abrir_fichero_anexo ( integer fila )
integer x = 18
integer y = 20
integer width = 3442
integer height = 748
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_registros_anexos"
end type

event csd_abrir_fichero_anexo(integer fila);string 	fichero, origen, registro_anexos, extension_fichero, nombre_completo
long 		cancelar

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02

// Desde este script asociamos los anexos que ven$$HEX1$$ed00$$ENDHEX$$an con el registro 

//origen=g_directorio_fotos
cancelar=getfileopenname('Selecci$$HEX1$$f300$$ENDHEX$$n del fichero de anexo', origen, fichero,"Archivos (*.BMP),*.BMP,Archivos (*.JPG),*.JPG,Archivos (*.GIF),*.GIF")

if cancelar = 1 then
	//Introducimos en el campo clave el valor obtenido desde el contador.
	registro_anexos = f_siguiente_numero('REGISTRO_ANEXOS',10)
	extension_fichero= RightA(fichero,4)
	if IsNull(registro_anexos) then registro_anexos = ''
	if IsNull(extension_fichero) then extension_fichero = ''
	
	//nombre_completo = registro_anexos + extension_fichero
		nombre_completo = fichero
	
	This.SetItem(this.getrow(),'ruta',nombre_completo)
	
	// Se copia el archivo al directorio de "E_S"
	//f_copiarfichero(origen,g_directorio_e_s+nombre_completo)
	FileCopy(origen,wf_obtener_ruta_doc('')+nombre_completo,true)

	
// else
//	this.deleterow(0)
end if

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02





end event

event pfc_insertrow;call super::pfc_insertrow;this.SetItem(this.getRow(),'id_registro_anexo',f_siguiente_numero('REGISTROS_ANEXOS',10))
// this.Post Event csd_abrir_fichero_anexo(this.getrow())
this.SetItem(this.getRow(),'id_registro',dw_1.getitemstring(1,'id_registro'))
return 1
end event

event pfc_addrow;call super::pfc_addrow;this.SetItem(this.getRow(),'id_registro_anexo',f_siguiente_numero('REGISTROS_ANEXOS',10))
// this.Post Event csd_abrir_fichero_anexo(this.getrow())
this.SetItem(this.getRow(),'id_registro',dw_1.getitemstring(1,'id_registro'))
return 1
end event

event buttonclicked;call super::buttonclicked;// Se ejecuta el evento del dialogo

st_w_escanear lst_datos_escanear
string ls_ruta_relativa_documentos,ruta_fichero,ls_nom_doc,ls_ruta_guardar

if not(f_es_vacio(this.getItemString(row,'id_documento_modulo'))) then return

choose case dwo.name
	case 'b_1'
		this.Post Event csd_abrir_fichero_anexo(this.getrow())
	case 'b_escanear'
		lst_datos_escanear.nombre_fichero=''
		lst_datos_escanear.ruta=wf_obtener_ruta_doc('') //g_directorio_e_s
			
		openWithParm(w_escaner_principal,lst_datos_escanear)
		
		ruta_fichero=Message.StringParm
		
		if f_es_vacio(ruta_fichero) then return
		ls_nom_doc=MidA(ruta_fichero,lastpos(ruta_fichero,'\') + 1,LenA(ruta_fichero))
		
//		this.setitem(row,'nombre_fichero',ls_nom_doc) 
		this.setitem(row,'ruta',ls_nom_doc)
end choose

end event

event doubleclicked;call super::doubleclicked;string fichero,ruta,id_registro
string extension_fichero
string id_doc_modulo

// Antes de lanzar la ejecuci$$HEX1$$f300$$ENDHEX$$n controlamos el n$$HEX2$$ba002000$$ENDHEX$$de filas para evitar errores
if row >0 then 
	id_doc_modulo=this.getitemstring(row,'id_documento_modulo')
	fichero=this.getitemstring(row,'ruta')
	extension_fichero= RightA(fichero,4)
	//f_abrir_fichero(g_directorio_e_s,fichero,"")
	ruta=wf_obtener_ruta_doc(id_doc_modulo)
	if FileExists(ruta+fichero) then
		f_abrir_fichero(ruta,fichero,"")
	else
		id_registro=dw_1.GetItemString(dw_1.GetRow(),'id_registro')
		f_abrir_fichero(g_directorio_e_s+"1900\",fichero,"")		
	end if

end if

end event

event pfc_predeleterow;call super::pfc_predeleterow;string fichero
if ancestorreturnvalue=1 then
	fichero=this.GetItemString(this.GetRow(),'ruta')
	Filedelete(wf_obtener_ruta_doc('')+fichero)
end if

return ancestorreturnvalue
end event

type cb_1 from commandbutton within w_registros_detalle
integer x = 736
integer y = 276
integer width = 91
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "..."
end type

event clicked;string id_persona, tipo_persona, poblacion, nombre, apellidos,cod_postal

g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida"
g_busqueda.dw="d_lista_busqueda_colegiados"
id_persona=f_busqueda_orig_dest(dw_1.GetItemString(dw_1.GetRow(),'tipo_persona_o'))        // Abre la ventana de busqueda rapida
if NOT f_es_vacio(id_persona)  then
	tipo_persona=g_certificados_busqueda.tipo_persona
//		dw_1.setitem(dw_1.getrow(),'codigo_o',id_persona)
	dw_1.setitem(1,'id_o',id_persona)
	dw_1.setitem(1,'tipo_persona_o',tipo_persona)
	choose case tipo_persona
		case 'C'
			dw_1.setitem(dw_1.getrow(),'codigo_o',f_colegiado_n_col(id_persona))
			dw_1.setitem(dw_1.getrow(),'nombre_o',f_colegiado_certificados(id_persona))
			SELECT domicilios.cod_pob  
			INTO :poblacion  
			FROM domicilios  
			WHERE domicilios.id_colegiado like :id_persona   ;
			dw_1.setitem(dw_1.getrow(),'poblacion_o',poblacion)	
			cod_postal=f_colegiado_cp(id_persona)
			if f_es_vacio(cod_postal) or cod_postal='00000' then cod_postal=f_devuelve_cod_postal(poblacion)
			dw_1.SetItem(dw_1.GetRow(),'cp_o',cod_postal)			
		case 'U'
			dw_1.setitem(dw_1.getrow(),'codigo_o',id_persona)	
			dw_1.setitem(dw_1.getrow(),'nombre_o',f_usuario(id_persona))
			dw_1.setitem(1,'departamento_o',g_certificados_busqueda.departamento)
		case 'O'
			dw_1.setitem(dw_1.getrow(),'codigo_o',id_persona)
			dw_1.setitem(dw_1.getrow(),'nombre_o',f_otras_personas(id_persona))
		case 'T'
			dw_1.setitem(dw_1.getrow(),'codigo_o',id_persona)
			select nombre into :nombre from clientes where id_cliente = :id_persona;
			select apellidos into :apellidos from clientes where id_cliente = :id_persona;
			if NOT f_es_vacio(nombre) then
				apellidos = apellidos + ", " + nombre
			end if
			dw_1.setitem(dw_1.getrow(),'nombre_o',apellidos)
			select cod_pob into :poblacion from clientes where id_cliente = :id_persona;
			dw_1.setitem(dw_1.getrow(),'poblacion_o',poblacion)
	end choose
end if
end event

type cb_2 from commandbutton within w_registros_detalle
integer x = 3410
integer y = 40
integer width = 91
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "..."
end type

event clicked;string id_registro, n_registro

g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida"
g_busqueda.dw="d_lista_busqueda_registros"
id_registro=f_busqueda_registros()
if f_es_vacio(id_registro)=false then
	SELECT registro.n_registro  
	INTO :n_registro  
	FROM registro  
	WHERE registro.id_registro like :id_registro   ;
	dw_1.setitem(1,'n_registro_ref',n_registro)
end if
end event

type cb_3 from commandbutton within w_registros_detalle
integer x = 3410
integer y = 120
integer width = 91
integer height = 72
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "..."
end type

event clicked;string id_registro, n_registro

g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida"
g_busqueda.dw="d_lista_busqueda_registros"
id_registro=f_busqueda_registros()
if f_es_vacio(id_registro)=false then
	SELECT registro.n_registro  
	INTO :n_registro  
	FROM registro  
	WHERE registro.id_registro like :id_registro   ;
	dw_1.setitem(1,'n_registro_bis',n_registro)
end if
end event

type cb_4 from commandbutton within w_registros_detalle
integer x = 3305
integer y = 808
integer width = 91
integer height = 72
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "..."
end type

event clicked;string exp, id_fase, n_registro
g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida"
g_busqueda.dw="d_lista_busqueda_fases"
id_fase=f_busqueda_fases()  
if NOT f_es_vacio(id_fase) then
	SELECT fases.n_expedi, fases.n_registro  INTO :exp, :n_registro  FROM fases   WHERE fases.id_fase = :id_fase   ;			
	dw_1.setitem(1,'n_expediente',n_registro)			
	dw_1.setitem(1,'n_expedi',id_fase)			

end if
end event

type cb_5 from commandbutton within w_registros_detalle
integer x = 2487
integer y = 276
integer width = 91
integer height = 72
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "..."
end type

event clicked;string id_persona, tipo_persona, poblacion, nombre, apellidos, cod_postal

g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida"
g_busqueda.dw="d_lista_busqueda_colegiados"
id_persona=f_busqueda_orig_dest(dw_1.GetItemString(dw_1.GetRow(),'tipo_persona_d'))        // Abre la ventana de busqueda rapida
if NOT f_es_vacio(id_persona) then
	tipo_persona=g_certificados_busqueda.tipo_persona
	//	dw_1.setitem(dw_1.getrow(),'codigo_d',id_persona)
	dw_1.setitem(dw_1.getrow(),'id_d',id_persona)
	dw_1.setitem(dw_1.getrow(),'tipo_persona_d',tipo_persona)
	choose case tipo_persona
		case 'C'
			dw_1.setitem(dw_1.getrow(),'codigo_d',f_colegiado_n_col(id_persona))
			dw_1.setitem(dw_1.getrow(),'nombre_d',f_colegiado_certificados(id_persona))
			SELECT domicilios.cod_pob  
			INTO :poblacion  
			FROM domicilios  
			WHERE domicilios.id_colegiado like :id_persona   ;
			dw_1.setitem(dw_1.getrow(),'poblacion_d',poblacion)	
			cod_postal=f_colegiado_cp(id_persona)
			if f_es_vacio(cod_postal) or cod_postal='00000' then cod_postal=f_devuelve_cod_postal(poblacion)
			dw_1.SetItem(dw_1.GetRow(),'cp_d',cod_postal)					
		case 'U'
			dw_1.setitem(dw_1.getrow(),'codigo_d',id_persona)		
			dw_1.setitem(dw_1.getrow(),'nombre_d',f_usuario(id_persona))
			dw_1.setitem(1,'departamento_d',g_certificados_busqueda.departamento)
		case 'O'
			dw_1.setitem(dw_1.getrow(),'codigo_d',id_persona)	
			dw_1.setitem(dw_1.getrow(),'nombre_d',f_otras_personas(id_persona))
		case 'T'
			dw_1.setitem(dw_1.getrow(),'codigo_d',id_persona)
			select nombre into :nombre from clientes where id_cliente = :id_persona;
			select apellidos into :apellidos from clientes where id_cliente = :id_persona;
			if NOT f_es_vacio(nombre) then
				apellidos = apellidos + ", " + nombre
			end if
			dw_1.setitem(dw_1.getrow(),'nombre_d',apellidos)
			select cod_pob into :poblacion from clientes where id_cliente = :id_persona;
			dw_1.setitem(dw_1.getrow(),'poblacion_d',poblacion)
	end choose
end if
end event

type cb_borrar_vinculacion from commandbutton within w_registros_detalle
integer x = 3397
integer y = 808
integer width = 91
integer height = 72
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "X"
end type

event clicked;dw_1.setitem(1,'n_expediente','')
dw_1.setitem(1,'n_expedi','')
end event

