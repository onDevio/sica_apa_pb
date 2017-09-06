HA$PBExportHeader$w_musaat_detalle_movimientos.srw
forward
global type w_musaat_detalle_movimientos from w_detalle
end type
type cb_2 from commandbutton within w_musaat_detalle_movimientos
end type
end forward

global type w_musaat_detalle_movimientos from w_detalle
integer width = 3621
integer height = 1696
string title = "Detalle de Movimientos de MUSAAT"
event csd_calcular ( )
cb_2 cb_2
end type
global w_musaat_detalle_movimientos w_musaat_detalle_movimientos

type variables
datawindowchild idwc_colegiados
end variables

forward prototypes
public function integer f_validaciones_previas ()
end prototypes

event csd_calcular();//calcular porcentaje del colegiado en la obra
string id_col,id_fase
double porcen

dw_1.accepttext()

id_col = dw_1.getitemstring(1, 'id_col')
id_fase = dw_1.GetITemString(1,'id_fase')

select porcen_a into :porcen from fases_colegiados where id_col = :id_col and id_fase = :id_fase;

if SQLCA.SQLNRows = 0 then 
	messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.no_participa_obra','El colegiado no participa en esa obra.'))
	return
end if

dw_1.SetItem(1,'porcentaje',porcen)

st_musaat_datos st_musaat_datos
//st_musaat_datos.n_visado = dw_1.getitemstring(1, 'contrato')
st_musaat_datos.id_col = id_col
st_musaat_datos.tipo_act = dw_1.getitemstring(1, 'tipo_act')
st_musaat_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_obra')
st_musaat_datos.pem = dw_1.getitemnumber(1, 'presupuesto')
st_musaat_datos.superficie = dw_1.getitemnumber(1, 'superficie')
st_musaat_datos.volumen = dw_1.getitemnumber(1, 'volumen')
st_musaat_datos.porcentaje = dw_1.getitemnumber(1, 'porcentaje')
//Cambio Jesus SCP-776
st_musaat_datos.coef_recargo = dw_1.getitemnumber(1, 'src_recargo')
st_musaat_datos.n_visado = dw_1.getitemstring(1, 'id_fase')
///*** SCP-778. Alexis. 21/12/2010. Cambio para la aceptaci$$HEX1$$f300$$ENDHEX$$n del codigo de colegio de destino
st_musaat_datos.cod_colegio = dw_1.getitemstring(1, 'cod_colegio_dest' )
st_musaat_datos.poliza_plus = dw_1.getitemstring(1, 'src_poliza_plus' )

f_musaat_calcula_prima(st_musaat_datos)

//dw_1.setitem(1, 'presupuesto_calculo', st_musaat_datos.pem)
dw_1.setitem(1, 'tabla', st_musaat_datos.tabla)
dw_1.setitem(1, 'cobertura', st_musaat_datos.cobertura)
dw_1.setitem(1, 'importe_vble', st_musaat_datos.prima_comp)
dw_1.setitem(1, 'coef_k', st_musaat_datos.coef_k)
dw_1.setitem(1, 'coef_c', st_musaat_datos.coef_c)
dw_1.setitem(1, 'coef_g', st_musaat_datos.coef_g)
dw_1.setitem(1, 'coef_sin', st_musaat_datos.coef_cm)
dw_1.setitem(1, 'coef_col', st_musaat_datos.coef_colegio)
dw_1.setitem(1, 'src_recargo', st_musaat_datos.coef_colegio)
//dw_1.setitem(1, 'formula', st_musaat_datos.formula)
end event

public function integer f_validaciones_previas ();string tipo_act, tipo_obra, tabla, n_col, t_visado, obra_oficial
double superficie, pem, volumen

n_col = dw_1.getitemstring(1, 'n_col')
tipo_act = dw_1.getitemstring(1, 'tipo_act')
tipo_obra = dw_1.getitemstring(1, 'tipo_obra')
superficie = dw_1.getitemnumber(1, 'superficie')
pem = dw_1.getitemnumber(1, 'presupuesto')
volumen = dw_1.getitemnumber(1, 'volumen')
t_visado = dw_1.getitemstring(1, 't_visado')
obra_oficial = dw_1.getitemstring(1, 'obra_oficial')

// Si no es un alta no recalculamos
if t_visado <> '1' then return -1

// Si no es obra oficial de tipo 0 $$HEX2$$f3002000$$ENDHEX$$2 no recalculamos
if obra_oficial <> '0' and obra_oficial <> '2' then return -1

if f_es_vacio(tipo_act) then
	messagebox(g_titulo, g_idioma.of_getmsg('msg_musaat.introducir_tipo_actuacion','Debe introducir un Tipo de Actuaci$$HEX1$$f300$$ENDHEX$$n'))
	return -1
end if
if f_es_vacio(tipo_obra) then
	messagebox(g_titulo, g_idioma.of_getmsg('msg_musaat.introducir_tipo_obra','Debe introducir un Tipo de Obra'))
	return -1
end if
if f_es_vacio(n_col) then
	messagebox(g_titulo, g_idioma.of_getmsg('msg_musaat.introducir_colegiado','Debe introducir un Colegiado'))
	return -1
end if
if isnull(superficie) then
	messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.introducir_superficie', 'Debe introducir la Superficie'))
	return -1	
end if

// Entramos en la tabla C
SELECT tabla
INTO :tabla
FROM musaat_coef_c
WHERE (tipoact = :tipo_act OR tipoact = '*' ) AND (tipoobra = :tipo_obra OR tipoobra = '*') AND (desde_sup <= :superficie) AND (hasta_sup >=:superficie) ;

choose case tabla
	case 'A', 'B', 'C'
		if isnull(pem) or pem = 0 then
			messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.introducir_presupuesto_ejecucion_material', 'Debe introducir el Presupuesto de Ejecuci$$HEX1$$f300$$ENDHEX$$n Material'))
			return -1		
		end if	
	case 'E'
		if isnull(volumen) or volumen = 0 then
			messagebox(g_titulo, g_idioma.of_getmsg('msg_musaat.introducir_volumen','Debe introducir el Volumen'))
			return -1					
		end if
end choose
return 0
end function

on w_musaat_detalle_movimientos.create
int iCurrent
call super::create
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
end on

on w_musaat_detalle_movimientos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_2)
end on

event activate;call super::activate;g_dw_lista  = g_dw_lista_movimientos_musaat
g_w_lista = g_lista_movimientos_musaat
g_w_detalle = g_detalle_movimientos_musaat
g_lista = 'w_ musaat_lista_movimientos'
g_detalle = 'w_musaat_detalle_movimientos'

end event

event csd_nuevo;call super::csd_nuevo;string tipo_tramite,id_fase

if AncestorReturnValue>0 then
	dw_1.SetItem(1,'id_movimiento',f_siguiente_numero('ID_MOV_MUSAAT',10))
	dw_1.SetItem(1,'fecha_calculo',DateTime(Today(),Now()))
	dw_1.SetItem(1,'f_musaat',DateTime(Today(),Now()))
	
	
end if

return AncestorReturnValue

end event

event type integer pfc_preupdate();call super::pfc_preupdate;if f_puedo_escribir(g_usuario,'0000000010')=-1 then return -1
return 1
end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_musaat_detalle_movimientos
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_musaat_detalle_movimientos
string tag = "texto=general.guardar_pantalla"
end type

type cb_nuevo from w_detalle`cb_nuevo within w_musaat_detalle_movimientos
string tag = "texto=general.nuevo"
end type

type cb_ayuda from w_detalle`cb_ayuda within w_musaat_detalle_movimientos
string tag = "texto=general.ayuda"
end type

type cb_grabar from w_detalle`cb_grabar within w_musaat_detalle_movimientos
string tag = "texto=general.grabar"
end type

type cb_ant from w_detalle`cb_ant within w_musaat_detalle_movimientos
end type

type cb_sig from w_detalle`cb_sig within w_musaat_detalle_movimientos
end type

type dw_1 from w_detalle`dw_1 within w_musaat_detalle_movimientos
event csd_cargar_dddw ( )
integer y = 0
integer width = 3552
integer height = 1372
string dataobject = "d_musaat_detalle_movimientos"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_1::csd_cargar_dddw();
if dw_1.rowcount()>0 then
	IF idwc_colegiados.Retrieve(dw_1.GetItemString(1,'id_fase'))<1 THEN
		idwc_colegiados.InsertRow(0)
	END IF
end if

idwc_colegiados.ResetUpdate()

end event

event dw_1::csd_retrieve;if f_es_vacio(g_musaat_movimientos_consulta.id_movimiento) then return
int    retorno
double i
retorno = parent.event closequery()
if retorno = 1 then return
this.retrieve(g_musaat_movimientos_consulta.id_movimiento)
g_musaat_movimientos_consulta.id_movimiento=''

end event

event dw_1::itemchanged;call super::itemchanged;string id
CHOOSE CASE dwo.name
	CASE 'n_contrato'
		double honos,presup,sup,vol,altura
		string t_act,t_obra,destino,exp, tipo_tramite
		select id_fase,fase,tipo_trabajo,trabajo,id_expedi, id_tramite into :id,:t_act,:t_obra,:destino,:exp
		from fases where n_registro = :data;
		if not(f_es_vacio(id)) Then
			this.setItem(row,'id_fase',id)
			this.setitem(row,'tipo_act',t_act)
			this.setitem(row,'tipo_obra',t_obra)
			this.setitem(row,'destino',destino)
			
			select honorarios into :honos from fases where id_fase = :id;
			this.setitem(row,'honorarios',honos)
			
			select pem,sup_viv+sup_garage+sup_otros,volumen,altura into :presup,:sup,:vol,:altura from fases_usos where id_fase = :id;
			this.setItem(row,'presupuesto',presup)
			this.setitem(row,'superficie',sup)
			this.setItem(row,'volumen',vol)
			this.setItem(row,'altura',altura)
		
			if tipo_tramite = 'MUSAAT' then
					dw_1.SetItem(1,'src_recargo',g_musaat_recargo_prima)
				
				else
					dw_1.SetItem(1,'src_recargo',1.00)
				
			end if
			this.event csd_cargar_dddw()
			if not(f_es_vacio(this.getItemString(1,'id_col'))) then event csd_calcular()
			
			if idwc_colegiados.Retrieve(id)<1 then
				idwc_colegiados.insertrow(0)
			end if
		Else
			Messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.no_existe_contrato','No existe el contrato.'))
			return 2
		End If
//	CASE 'n_col'
//		string pol,mut,nif
//		select id_colegiado,nif into :id,:nif from colegiados where n_colegiado = :data;
//
//		if not(f_es_vacio(id)) Then
//			this.setItem(row,'id_col',id)
//			this.setItem(row,'nif_pagador',nif)
//			select n_mutualista,src_n_poliza into :mut,:pol
//			from musaat where id_col = :id;
//			if SQLCA.SQLNRows = 0 then 
//				messagebox(g_titulo,'El colegiado no es de MUSAAT.')
//				return 2
//			else
//				this.setItem(row,'num_pol',pol)
//				this.setItem(row,'num_mut',mut)
//				if not(f_es_vacio(this.getItemString(1,'id_fase'))) then event csd_calcular()
//			end if
//		else
//			Messagebox(g_titulo,'No existe el colegiado.')
//			return 2
//		end if
	CASE 'id_col'
		string pol,mut,nif,n_col
		
		select nif, n_colegiado into :nif,:n_col from colegiados where id_colegiado = :data;
		
		this.setItem(row,'n_col',n_col)
		this.setItem(row,'nif_pagador',nif)
		
		select n_mutualista,src_n_poliza into :mut,:pol
		from musaat where id_col = :data;
		
		if SQLCA.SQLNRows = 0 then 
			messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.colegiado_no_musaat','El colegiado no es de MUSAAT.'))
			return 2
		else
			this.setItem(row,'num_pol',pol)
			this.setItem(row,'num_mut',mut)
			if not(f_es_vacio(this.getItemString(1,'id_fase'))) then event csd_calcular()
		end if
END CHOOSE

end event

event dw_1::buttonclicked;string id_colegiado
double cuantos
choose case dwo.name
//	case 'b_colegiado'
//		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
//		g_busqueda.dw="d_lista_busqueda_colegiados"
//
//		id_colegiado=f_busqueda_colegiados()
//
//		if not f_es_vacio(id_colegiado) then 
//			this.setitem(row,'id_col',id_colegiado)
//			string pol,mut,n_col
//			select n_colegiado into :n_col from colegiados where id_colegiado = :id_colegiado;
//			select n_mutualista,src_n_poliza into :mut,:pol
//			from musaat where id_col = :id_colegiado;
//			if SQLCA.SQLNRows = 0 then 
//				messagebox(g_titulo,'El colegiado no es de MUSAAT.')
//			else
//				select count(*) into :cuantos from fases_colegiados where id_col = :id_colegiado;
//				if cuantos <= 0 then
//					messagebox(g_titulo,'El colegiado no pertenece a este contrato.')
//				else
//					this.setItem(row,'num_pol',pol)
//					this.setItem(row,'num_mut',mut)
//					this.setItem(row,'n_col',n_col)
//					if not(f_es_vacio(this.getItemString(1,'id_fase'))) then event csd_calcular()
//				end if
//			end if
//		end if
		
	CASE 'b_contrato'
		string id_fase,t_act,t_obra,destino,n_contrato,exp, tipo_tramite
		double honos,presup,sup,vol,altura
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida"
		g_busqueda.dw="d_lista_busqueda_fases"
		id_fase=f_busqueda_fases()  
		select fase,tipo_trabajo,trabajo,n_registro,id_expedi, id_tramite into :t_act,:t_obra,:destino,:n_contrato,:exp, :tipo_tramite
		from fases where id_fase = :id_fase;
		
		
		if tipo_tramite = 'MUSAAT' then
			dw_1.SetItem(row,'src_recargo',g_musaat_recargo_prima)
		else
			dw_1.SetItem(row,'src_recargo',1.00)
				
		end if

		this.setItem(row,'id_fase',id_fase)
		this.setitem(row,'n_contrato',n_contrato)
		this.setitem(row,'tipo_act',t_act)
		this.setitem(row,'tipo_obra',t_obra)
		this.setitem(row,'destino',destino)
		
		select honorarios into :honos from fases where id_fase = :id_fase;
		this.setitem(row,'honorarios',honos)
		
		select pem,sup_viv+sup_garage+sup_otros,volumen,altura into :presup,:sup,:vol,:altura from fases_usos where id_fase = :id_fase;
		this.setItem(row,'presupuesto',presup)
		this.setitem(row,'superficie',sup)
		this.setItem(row,'volumen',vol)
		this.setItem(row,'altura',altura)
		
		this.event csd_cargar_dddw()
		if not(f_es_vacio(this.getItemString(1,'id_col'))) then event csd_calcular()

end choose
end event

event dw_1::constructor;call super::constructor;this.getchild('id_col',idwc_colegiados)
idwc_colegiados.settransobject(sqlca)
idwc_colegiados.InsertRow (0)
end event

event dw_1::retrieveend;call super::retrieveend;this.post event csd_cargar_dddw()

//Luis CAL-259
if f_es_vacio(dw_1.getitemstring(1,'colindantes2m')) then dw_1.setitem(1,'colindantes2m','N')
if f_es_vacio(dw_1.getitemstring(1,'doble_condicion')) then dw_1.setitem(1,'doble_condicion','N')
if f_es_vacio(dw_1.getitemstring(1,'int_forzosa')) then dw_1.setitem(1,'int_forzosa','N')
if f_es_vacio(dw_1.getitemstring(1,'decenal')) then dw_1.setitem(1,'decenal','N')
//fin cambio
end event

event dw_1::doubleclicked;call super::doubleclicked;string obser

CHOOSE CASE dwo.name
	CASE 't_observaciones'
		g_busqueda.titulo="Observaciones"
		obser    =this.GetItemString(row, 'observaciones')
		openwithparm(w_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
			dw_1.SetItem(row,'observaciones',obser)
		end if
END CHOOSE

end event

type cb_2 from commandbutton within w_musaat_detalle_movimientos
string tag = "texto=general.recalcular"
integer x = 3113
integer y = 1384
integer width = 402
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Recalcular"
end type

event clicked;string n_visado
int retorno
dw_1.accepttext()
if f_validaciones_previas() <> 0 then return

st_musaat_datos st_musaat_datos
//st_musaat_datos.n_visado = dw_1.getitemstring(1, 'contrato')
st_musaat_datos.id_col = dw_1.getitemstring(1, 'id_col')
st_musaat_datos.tipo_act = dw_1.getitemstring(1, 'tipo_act')
st_musaat_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_obra')
st_musaat_datos.pem = dw_1.getitemnumber(1, 'presupuesto')
st_musaat_datos.superficie = dw_1.getitemnumber(1, 'superficie')
st_musaat_datos.volumen = dw_1.getitemnumber(1, 'volumen')
st_musaat_datos.porcentaje = dw_1.getitemnumber(1, 'porcentaje')
//Cambio Jesus SCP-776
st_musaat_datos.coef_recargo = dw_1.getitemnumber(1, 'src_recargo')
st_musaat_datos.n_visado = dw_1.getitemstring(1, 'id_fase')
///*** SCP-778. Alexis. 21/12/2010. Cambio para la aceptaci$$HEX1$$f300$$ENDHEX$$n del codigo de colegio de destino
st_musaat_datos.cod_colegio = dw_1.getitemstring(1, 'cod_colegio_dest' )
st_musaat_datos.poliza_plus = dw_1.getitemstring(1, 'src_poliza_plus' )


f_musaat_calcula_prima(st_musaat_datos)

//dw_1.setitem(1, 'presupuesto_calculo', st_musaat_datos.pem)
dw_1.setitem(1, 'tabla', st_musaat_datos.tabla)
dw_1.setitem(1, 'cobertura', st_musaat_datos.cobertura)
dw_1.setitem(1, 'importe_vble', st_musaat_datos.prima_comp)
dw_1.setitem(1, 'coef_k', st_musaat_datos.coef_k)
dw_1.setitem(1, 'coef_c', st_musaat_datos.coef_c)
dw_1.setitem(1, 'coef_g', st_musaat_datos.coef_g)
dw_1.setitem(1, 'coef_sin', st_musaat_datos.coef_cm)
//Cambio Jesus SCP-776
dw_1.setitem(1, 'src_recargo', st_musaat_datos.coef_recargo)
//dw_1.setitem(1, 'formula', st_musaat_datos.formula)

end event

