HA$PBExportHeader$w_registros_consulta.srw
forward
global type w_registros_consulta from w_consulta
end type
end forward

global type w_registros_consulta from w_consulta
integer x = 214
integer y = 221
integer width = 2272
integer height = 1728
string title = "Consulta de Registros"
end type
global w_registros_consulta w_registros_consulta

on w_registros_consulta.create
call super::create
end on

on w_registros_consulta.destroy
call super::destroy
end on

event open;call super::open;datetime f_ini
f_ini = datetime(date('01/01/' + string(year(today()))))
dw_1.setitem(1, 'fecha_desde', f_ini)
datawindowchild dwc_serie
dw_1.GetChild('serie',dwc_serie)
f_reg_es_filtrar_serie(dw_1,'%')


if g_colegio='COAATCC' then dw_1.SetItem(1,'autocompletar','S')
	
end event

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_registros_consulta
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_registros_consulta
string tag = "texto=general.guardar_pantalla"
end type

type cb_limpiar from w_consulta`cb_limpiar within w_registros_consulta
string tag = "texto=general.limpiar_consulta"
end type

type st_5 from w_consulta`st_5 within w_registros_consulta
string tag = "general.texto_consulta"
end type

type cb_1 from w_consulta`cb_1 within w_registros_consulta
integer x = 526
integer y = 1508
end type

event cb_1::clicked;call super::clicked;string sql_nuevo,sql

sql_nuevo = g_dw_lista.describe("datawindow.table.select")

f_sql('registro.n_registro','LIKE','n_registro',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('registro.n_registro_bis','LIKE','n_registro_bis',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('registro.fecha','>=','fecha_desde',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('registro.fecha','<','fecha_hasta',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('asunto','LIKE','asunto',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('nombre_o','LIKE','origen',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('nombre_d','LIKE','destino',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('oficial','LIKE','oficial',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('es','LIKE','es',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('interno','LIKE','interno',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('marca','LIKE','marcado',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('cumplimentado','LIKE','cumplimentado',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('f_escrito','>=','f_escrito_desde',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('f_escrito','<','f_escrito_hasta',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('f_vencimiento','>=','f_venc_desde',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('f_vencimiento','<','f_venc_hasta',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('cod_delegacion','=','cod_delegacion',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('tipo_comunicado','=','tipo_comunicado',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('acuse','LIKE','acuse',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')

if pos(upper(sql_nuevo),'WHERE')>0 then
		sql_nuevo+=" and empresa ='"+g_empresa+"'"
else
	sql_nuevo+=" WHERE empresa ='"+g_empresa+"'"
end if
	
sql=sql_nuevo
if f_es_superusuario()='-1' then
	if pos(upper(sql),'WHERE')>0 then
		sql=" and serie in (select codigo from registro_series where cod_aplicacion='%' or cod_aplicacion in (select cod_aplicacion from t_permisos where cod_usuario='"+g_usuario+"'))"
	else
		sql=" WHERE serie in (select codigo from registro_series where cod_aplicacion='%' or cod_aplicacion in (select cod_aplicacion from t_permisos where cod_usuario='"+g_usuario+"'))"		
	end if
	sql_nuevo+=sql	
end if

//MessagebOX("DEBUG",sql_nuevo)
g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
Parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_registros_consulta
integer x = 1115
integer y = 1508
end type

type cb_ayuda from w_consulta`cb_ayuda within w_registros_consulta
string tag = "texto=general.ayuda"
integer x = 1440
integer y = 1280
end type

type dw_1 from w_consulta`dw_1 within w_registros_consulta
event csd_completar_nreg ( string n_reg,  string campo )
integer x = 64
integer width = 2149
integer height = 1340
string dataobject = "d_registros_consulta"
end type

event dw_1::csd_completar_nreg(string n_reg, string campo);long posic,num_digitos
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

event dw_1::itemchanged;call super::itemchanged;string tipo,campo

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
			if dw_1.GetItemString(1,'autocompletar')='S'  then this.post event csd_completar_nreg(data,campo) //setitem(1,campo,f_rellenar_nreg(data))
end choose
end event

