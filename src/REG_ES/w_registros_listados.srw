HA$PBExportHeader$w_registros_listados.srw
forward
global type w_registros_listados from w_listados
end type
end forward

global type w_registros_listados from w_listados
string title = "Listados del Registro E/S"
end type
global w_registros_listados w_registros_listados

on w_registros_listados.create
call super::create
end on

on w_registros_listados.destroy
call super::destroy
end on

event open;call super::open;
dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

// Se desplaza el apuntador al primer registro
dw_listados_varios.scrolltorow(1)
dw_listados_varios.setfocus()

// Le quitamos el foco al campo E/S, se seleccionar$$HEX2$$e1002000$$ENDHEX$$en f(tipo de listado)
//dw_listados.SetTabOrder('es_listados',0)




end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_registros_listados
string tag = "text=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_registros_listados
string tag = "text=general.guardar_pantalla"
end type

type cb_limpiar from w_listados`cb_limpiar within w_registros_listados
string tag = "text=general.limpiar_consulta"
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_registros_listados
integer x = 2327
end type

type cb_ver from w_listados`cb_ver within w_registros_listados
end type

event cb_ver::clicked;call super::clicked;string sql, listado,descripcion

// dw_1.accepttext()
dw_listados.accepttext()
dw_1.of_setprintpreview(TRUE)

// Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado

dw_1.of_SetTransObject(SQLCA)
sql = dw_1.describe("datawindow.table.select")

// Se asigna el titulo del informe con la descripcion
descripcion=dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'descripcion')
dw_1.object.st_titulo_listado.text = descripcion

//if (descripcion='Registros de Entrada por Fecha de Vencimiento' or descripcion='Registros de Salida por Fecha de Vencimiento') then
//   dw_listados.SetItem(1,'cumplimentado','N')
//end if

////Hacer f_sql de todos los campos de la dw_listados de forma analoga a la ventana de consulta
f_sql('registro.n_registro','LIKE','n_registro',Parent.dw_listados,sql,g_tipo_base_datos,'N. Registro')
f_sql('registro.fecha','>=','fecha_desde',Parent.dw_listados,sql,g_tipo_base_datos,'Fecha desde')
f_sql('registro.fecha','<','fecha_hasta',Parent.dw_listados,sql,g_tipo_base_datos,'Fecha hasta')
f_sql('registro.f_escrito','>=','f_escrito_desde',Parent.dw_listados,sql,g_tipo_base_datos,'Fecha Escrito desde')
f_sql('registro.f_escrito','<','f_escrito_hasta',Parent.dw_listados,sql,g_tipo_base_datos,'Fecha Escrito hasta')
f_sql('registro.f_vencimiento','>=','f_venc_desde',Parent.dw_listados,sql,g_tipo_base_datos,'Fecha Vencimiento desde')
f_sql('registro.f_vencimiento','<','f_venc_hasta',Parent.dw_listados,sql,g_tipo_base_datos,'Fecha Vencimiento hasta')
f_sql('registro.asunto','LIKE','asunto',Parent.dw_listados,sql,g_tipo_base_datos,'Asunto')
f_sql('registro.nombre_o','LIKE','origen',Parent.dw_listados,sql,g_tipo_base_datos,'Origen')
f_sql('registro.nombre_d','LIKE','destino',Parent.dw_listados,sql,g_tipo_base_datos,'Destino')
f_sql('registro.oficial','LIKE','oficial',Parent.dw_listados,sql,g_tipo_base_datos,'Oficial')
f_sql('registro.es','LIKE','es_listados',Parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('registro.interno','LIKE','interno',Parent.dw_listados,sql,g_tipo_base_datos,f_campos_et_e_s('interno'))
f_sql('registro.marca','LIKE','marcado',Parent.dw_listados,sql,g_tipo_base_datos,'Marcado')
f_sql('registro.cumplimentado','LIKE','cumplimentado',Parent.dw_listados,sql,g_tipo_base_datos,'Cumplimentado')
f_sql('registro.cod_delegacion','=','cod_delegacion',Parent.dw_listados,sql,g_tipo_base_datos,'Delegaci$$HEX1$$f300$$ENDHEX$$n')
f_sql('registro.tipo_comunicado','=','tipo_comunicado',Parent.dw_listados,sql,g_tipo_base_datos,'Tipo Comunicado')
f_sql('registro.acuse','=','acuse',Parent.dw_listados,sql,g_tipo_base_datos,'Acuse de Recibo')

if pos(upper(sql),'WHERE')>0 then
	sql+=" and registro.empresa ='"+g_empresa+"'"
else
	sql+=" WHERE registro.empresa ='"+g_empresa+"'"
end if


if f_es_superusuario()='-1' then
	if pos(upper(sql),'WHERE')>0 then
		sql+=" and serie in (select codigo from registro_series where cod_aplicacion='%' or cod_aplicacion in (select cod_aplicacion from t_permisos where cod_usuario='"+g_usuario+"'))"
	else
		sql+=" WHERE serie in (select codigo from registro_series where cod_aplicacion='%' or cod_aplicacion in (select cod_aplicacion from t_permisos where cod_usuario='"+g_usuario+"'))"		
	end if
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
	messagebox(g_titulo,g_idioma.of_getmsg('msg_entsal.no_encont_regs','No se han encontrado registros segun las especificaciones.'))
end if

end event

type cb_salir from w_listados`cb_salir within w_registros_listados
string tag = "text=general.salir"
end type

type dw_listados from w_listados`dw_listados within w_registros_listados
event csd_completar_nreg ( string n_reg,  string campo )
integer width = 2153
integer height = 1260
string dataobject = "d_registros_consulta"
end type

event dw_listados::csd_completar_nreg(string n_reg, string campo);long posic,num_digitos
string reg,formato

double i, aes, enes, des
string cont, anyo, numero, deleg
st_control_eventos c_evento

c_evento.evento = 'REGISTRO_ES'
f_control_eventos(c_evento)
formato=c_evento.param1

posic=pos(n_reg,'-')
reg=n_reg
if posic>0 then
	reg=mid(n_reg,posic + 1)
end if


if f_es_vacio(formato) then
	num_digitos=10
	this.SetItem(1,campo,mid(n_reg,1,posic)+right('0000000000'+reg,num_digitos))
else
	
	// FORMATO : Contiene el formato a seguir... Se marcan con 'a' el a$$HEX1$$f100$$ENDHEX$$o y la numeracion con 'n'
	//		Ej: aaaa-nnnnn -> 4 para el a$$HEX1$$f100$$ENDHEX$$o, 5 para el numero, con un guion
	
	cont = c_evento.param1
	
	if PosA(formato, 'n')>0 then
		// la numeracion
		// Contamos las enes que hay
		for i=1 to LenA(formato)
			if MidA(formato, i, 1) = 'n' then enes++
		next
	
		// Y lo reemplazamos en el formato
		cont = ReplaceA(cont,PosA(formato, 'n'),enes,right('0000000000'+reg,enes))
	end if
	
	if PosA(formato, 'a')>0 then
		// Lleva el a$$HEX1$$f100$$ENDHEX$$o
		// Contamos las aes que hay
		for i=1 to LenA(formato)
			if MidA(formato, i, 1) = 'a' then aes++
		next
		// Construimos el a$$HEX1$$f100$$ENDHEX$$o como quieren
		anyo = RightA(string(year(today())),aes)
		// Y lo reemplazamos en el formato
		cont = ReplaceA(cont,PosA(formato, 'a'),aes,anyo)
	end if
	
	if PosA(formato, 'd')>0 then
		// Lleva la delegaci$$HEX1$$f300$$ENDHEX$$n
		// Contamos las des que hay
		for i=1 to LenA(formato)
			if MidA(formato, i, 1) = 'd' then des++
		next
		// Construimos la delegaci$$HEX1$$f300$$ENDHEX$$n como quieren
		deleg = f_delegacion_siglas(g_cod_delegacion)
		if isnull(deleg) then deleg = ''
		// Y lo reemplazamos en el formato
		cont = ReplaceA(cont,PosA(formato, 'd'),des,deleg)
	end if
end if
this.SetItem(1,campo,mid(n_reg,1,posic)+cont)		


end event

event dw_listados::csd_oculta();call super::csd_oculta;string  dwactual, descactual
integer nro_opcion

dwactual  = dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'dw')
descactual= dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'descripcion')
//nro_opcion= dw_listados_varios.getrow()

// Se oculta la opcion del tipo de registro del dw de consulta  por presentar la de Listados
dw_listados.object.es.visible				= false // la de consulta
dw_listados.object.es_listados.visible	= True // la de listados

// aqui va el campo por donde se filtrara
// this.object.departamento.visible   = (pos("d_listado_1 d_listado_2", lower(dwactual)) > 1)
// this.object.departamento_t.visible = this.object.departamento.visible

CHOOSE CASE dwactual
	CASE 'd_listado_registros_e','d_listado_registros_s'
		dw_listados.object.n_registro.visible      = true
		dw_listados.object.n_registro_t.visible    = true
		dw_listados.object.origen.visible          = true
		dw_listados.object.origen_t.visible        = true
		dw_listados.object.destino.visible         = true
		dw_listados.object.destino_t.visible       = true
		dw_listados.object.asunto.visible          = true
		dw_listados.object.asunto_t.visible        = true
		dw_listados.object.oficial.visible         = true
		dw_listados.object.oficial_t.visible       = true		
		dw_listados.object.interno.visible         = true
		dw_listados.object.interno_t.visible       = true		
//		dw_listados.object.marcado.visible         = true
//		dw_listados.object.marcado_t.visible       = true		
		dw_listados.object.cumplimentado.visible   = true
		dw_listados.object.cumplimentado_t.visible = true		
		// Se coloca al tipo de registro (es) en funci$$HEX1$$f300$$ENDHEX$$n del tipo de listado
		if dwactual = 'd_listado_registros_e' then 
			setitem(1,'es_listados','E')
		elseif dwactual = 'd_listado_registros_s' then
			setitem(1,'es_listados','S')
		end if
	CASE else
		dw_listados.object.n_registro.visible      = false
		dw_listados.object.n_registro_t.visible    = false
		//dw_listados.object.es_listados.visible		 = False
		dw_listados.object.origen.visible          = False
		dw_listados.object.origen_t.visible        = false
		dw_listados.object.destino.visible         = false
		dw_listados.object.destino_t.visible       = false
		dw_listados.object.asunto.visible          = false
		dw_listados.object.asunto_t.visible        = false
		dw_listados.object.oficial.visible         = false
		dw_listados.object.oficial_t.visible       = false		
		dw_listados.object.interno.visible         = false
		dw_listados.object.interno_t.visible       = false		
//		dw_listados.object.marcado.visible         = false
//		dw_listados.object.marcado_t.visible       = false		
		dw_listados.object.cumplimentado.visible   = false
		dw_listados.object.cumplimentado_t.visible = false
		// Se coloca al tipo de registro (es) = '%' para que traiga todos los registros
		//setitem(1,'es_listados','%')
		// Se coloca al tipo de registro (es) en funci$$HEX1$$f300$$ENDHEX$$n del tipo de listado
		if dwactual = 'd_listado_registros_fecha_e' or dwactual = 'd_listado_registros_fecha_venc_e' then 
			setitem(1,'es_listados','E')
		elseif dwactual = 'd_listado_registros_fecha_s' or dwactual = 'd_listado_registros_fecha_venc_s' then
			setitem(1,'es_listados','S')
		end if
end choose
end event

event dw_listados::constructor;call super::constructor;//this.of_SetDropDownCalendar(True)
//this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
//this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
//this.iuo_calendar.of_SetInitialValue(True)

end event

event dw_listados::itemchanged;call super::itemchanged;string tipo,campo

datawindowchild dwc_serie
dw_1.GetChild('serie',dwc_serie)


choose case dwo.name
	case 'serie'
		
		tipo=dwc_serie.GetItemString(dwc_serie.GetRow(),'tipo')
		this.SetItem(1,'n_registro',data+'-')
		this.SetItem(1,'es',tipo)
		f_reg_es_filtrar_serie(dw_1,tipo)
		//dwc_serie.SetFilter("(cod_delegacion=	'"+g_cod_delegacion+"' or cod_delegacion='%') and tipo='"+tipo+"'")
		//dwc_serie.filter()		
	case 'es'
		dw_1.SetItem(1,'serie','')
		dw_1.SetItem(1,'n_registro','')	
		f_reg_es_filtrar_serie(dw_1,data)
		/*if data='%' then
			dwc_serie.SetFilter("(cod_delegacion=	'"+g_cod_delegacion+"'or cod_delegacion='%')")
		else
			dwc_serie.SetFilter("(cod_delegacion=	'"+g_cod_delegacion+"' or cod_delegacion='%') and tipo='"+data+"'")
		end if
			dwc_serie.filter()*/
		case 'n_registro','n_registro_bis'
			campo=dwo.name
			if this.GetItemString(1,'autocompletar')='S'  then this.post event csd_completar_nreg(data,campo) //setitem(1,campo,f_rellenar_nreg(data))
end choose
end event

type cb_imprimir from w_listados`cb_imprimir within w_registros_listados
end type

type cb_zoom from w_listados`cb_zoom within w_registros_listados
end type

type cb_esp from w_listados`cb_esp within w_registros_listados
string tag = "text=general.especificar_imp"
end type

type cb_guardar from w_listados`cb_guardar within w_registros_listados
string tag = "text=general.guardar_como"
end type

type cb_escala from w_listados`cb_escala within w_registros_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_registros_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_registros_listados
end type

type dw_1 from w_listados`dw_1 within w_registros_listados
integer width = 3593
integer height = 1440
end type

event dw_1::constructor;call super::constructor;//this.of_SetDropDownCalendar(True)
//this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
//this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
//this.iuo_calendar.of_SetInitialValue(True)
end event

event dw_1::retrievestart;call super::retrievestart;// Indicamos que queremos cambiar el idioma
if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)
end event

