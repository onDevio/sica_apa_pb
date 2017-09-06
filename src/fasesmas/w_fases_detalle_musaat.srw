HA$PBExportHeader$w_fases_detalle_musaat.srw
forward
global type w_fases_detalle_musaat from w_response
end type
type dw_1 from u_dw within w_fases_detalle_musaat
end type
type cb_1 from commandbutton within w_fases_detalle_musaat
end type
type cb_2 from commandbutton within w_fases_detalle_musaat
end type
end forward

global type w_fases_detalle_musaat from w_response
integer x = 214
integer y = 221
integer width = 3781
integer height = 1644
boolean controlmenu = false
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_fases_detalle_musaat w_fases_detalle_musaat

type variables
datawindowchild i_dwc_colegiados
w_fases_detalle i_w
datawindow idw_clientes, idw_colegiados, idw_descuentos
datawindow idw_fases_datos_exp, idw_1, idw_fases_src, idw_estadistica


end variables

forward prototypes
public function integer f_validaciones_previas ()
end prototypes

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
	messagebox(g_titulo, 'Debe introducir un Tipo de Actuaci$$HEX1$$f300$$ENDHEX$$n')
	return -1
end if
if f_es_vacio(tipo_obra) then
	messagebox(g_titulo, 'Debe introducir un Tipo de Obra')
	return -1
end if
if f_es_vacio(n_col) then
	messagebox(g_titulo, 'Debe introducir un Colegiado')
	return -1
end if
if isnull(superficie) then
	messagebox(g_titulo, 'Debe introducir la Superficie')
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
			messagebox(g_titulo, 'Debe introducir el Presupuesto de Ejecuci$$HEX1$$f300$$ENDHEX$$n Material')
			return -1		
		end if	
	case 'E'
		if isnull(volumen) or volumen = 0 then
			messagebox(g_titulo, 'Debe introducir el Volumen')
			return -1					
		end if
end choose
return 0
end function

on w_fases_detalle_musaat.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_fases_detalle_musaat.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;string movimiento, nif_promotor, nom_promotor, tipo_tramite,id_fase

f_centrar_ventana(this)

movimiento = message.stringparm

i_w = g_detalle_fases
idw_1 = i_w.dw_1
idw_fases_src = i_w.idw_fases_src


if movimiento = 'NUEVO' then
	dw_1.insertrow(0)
	dw_1.SetItem(1,'id_movimiento',f_siguiente_numero('ID_MOV_MUSAAT',10))
	dw_1.SetItem(1,'fecha_calculo',DateTime(Today(),Now()))
	dw_1.SetItem(1,'f_musaat',DateTime(Today(),Now()))
	dw_1.SetItem(1,'n_contrato',idw_1.getitemstring(1, 'n_registro'))
	
	double honos,presup,sup,vol,altura
	string t_act,t_obra,destino,exp, n_reg, id, cod_colegio_dest
	
	n_reg = idw_1.getitemstring(1, 'n_registro')
	id_fase=idw_1.getitemstring(1, 'id_fase')
	select id_fase,fase,tipo_trabajo,trabajo,id_expedi , cod_colegio_dest, id_tramite
	into :id,:t_act,:t_obra,:destino,:exp, :cod_colegio_dest,  :tipo_tramite
	from fases 
	where id_fase=:id_fase;
	//where n_registro = :n_reg;
	
	
	dw_1.setItem(1,'id_fase',id)
	dw_1.setitem(1,'tipo_act',t_act)
	dw_1.setitem(1,'tipo_obra',t_obra)
	dw_1.setitem(1,'destino',destino)
	dw_1.setitem(1, 'cod_colegio_dest', cod_colegio_dest)
			
	select honorarios 
	into :honos 
	from fases
	where id_fase = :id;
	
	dw_1.setitem(1,'honorarios',honos)
			
	select pem,sup_viv+sup_garage+sup_otros,volumen,altura 
	into :presup,:sup,:vol,:altura 
	from fases_usos 
	where id_fase = :id;
	
	dw_1.setItem(1,'presupuesto',presup)
	dw_1.setitem(1,'superficie',sup)
	dw_1.setItem(1,'volumen',vol)
	dw_1.setItem(1,'altura',altura)
	
	//SCP-891
	nif_promotor    = f_devuelve_nif_promotor(id)
	nom_promotor = f_devuelve_nom_promotor(id)
	dw_1.setItem(1,'nif_promotor',nif_promotor)
	dw_1.setItem(1,'nom_promotor',nom_promotor)
	dw_1.setItem(1,'obra_iniciada','N')
	dw_1.setItem(1,'src_poliza_plus','N')
	
	
	if tipo_tramite = 'MUSAAT' then
		dw_1.SetItem(1,'src_recargo',g_musaat_recargo_prima)
	
	else
		dw_1.SetItem(1,'src_recargo',1.00)
	
	end if
	
	dw_1.event csd_cargar_dddw()
else
	dw_1.retrieve(movimiento)
end if

//Luis CZA-152
if f_es_vacio(dw_1.getitemstring(1,'colindantes2m')) then dw_1.setitem(1,'colindantes2m','N')
if f_es_vacio(dw_1.getitemstring(1,'doble_condicion')) then dw_1.setitem(1,'doble_condicion','N')
if f_es_vacio(dw_1.getitemstring(1,'int_forzosa')) then dw_1.setitem(1,'int_forzosa','N')
if f_es_vacio(dw_1.getitemstring(1,'decenal')) then dw_1.setitem(1,'decenal','N')
//fin cambio

dw_1.SetItemStatus(1, "colindantes2m", Primary!, NotModified!)
dw_1.SetItemStatus(1, "doble_condicion", Primary!, NotModified!)
dw_1.SetItemStatus(1, "int_forzosa", Primary!, NotModified!)
dw_1.SetItemStatus(1, "decenal", Primary!, NotModified!)
end event

event pfc_postopen();call super::pfc_postopen;dw_1.of_SetDropDownCalendar(True)
dw_1.iuo_calendar.of_register(dw_1.iuo_calendar.DDLB)
dw_1.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_1.iuo_calendar.of_SetInitialValue(True)

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_detalle_musaat
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_detalle_musaat
end type

type dw_1 from u_dw within w_fases_detalle_musaat
event csd_retrieve ( )
event csd_cargar_dddw ( )
integer x = 14
integer y = 32
integer width = 3712
integer height = 1376
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_musaat_detalle_movimientos"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event csd_cargar_dddw();
if dw_1.rowcount()>0 then
	IF i_dwc_colegiados.Retrieve(dw_1.GetItemString(1,'id_fase'))<1 THEN
		i_dwc_colegiados.InsertRow(0)
	END IF
end if

i_dwc_colegiados.ResetUpdate()

end event

event constructor;call super::constructor;this.GetChild('id_col',i_dwc_colegiados)
i_dwc_colegiados.settransobject(sqlca)
i_dwc_colegiados.InsertRow (0)

end event

event retrieveend;call super::retrieveend;this.post event csd_cargar_dddw()
end event

event itemchanged;call super::itemchanged;string pol,mut,nif,id, id_fase, n_col
double porc

// Modificacion de Datos
idw_1.dynamic event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_fase'), this, 'MUSAAT ' + '['+string(idw_fases_src.getrow())+'] ', dwo.name, row)


CHOOSE CASE dwo.name
//	CASE 'n_col'
//		
//		select id_colegiado,nif into :id,:nif from colegiados where n_colegiado = :data;
//
//		if not(f_es_vacio(id)) Then
//			
//			this.setItem(1,'id_col',id)
//			this.setItem(1,'nif_pagador',nif)
//			id_fase = this.getItemString(1,'id_fase')
//			
//			select porcen_a into :porc from fases_colegiados where id_fase = :id_fase and id_col = :id ; 
//			
//			this.setitem(1,'porcentaje',porc)
//			
//			select n_mutualista,src_n_poliza into :mut,:pol	from musaat where id_col = :id;
//			
//			if SQLCA.SQLNRows = 0 then 
//				messagebox(g_titulo,'El colegiado no es de MUSAAT.')
//				return 2
//			else
//				this.setItem(1,'num_pol',pol)
//				this.setItem(1,'num_mut',mut)
//				if not(f_es_vacio(id_fase)) then cb_2.triggerevent(clicked!)
//			end if
//		else
//			Messagebox(g_titulo,'No existe el colegiado.')
//			return 2
//		end if
		
	CASE 'id_col'
		select nif, n_colegiado into :nif,:n_col from colegiados where id_colegiado = :data;
		
		this.setItem(row,'n_col',n_col)
		this.setItem(row,'nif_pagador',nif)
		id_fase = this.getItemString(1,'id_fase')
		
		select porcen_a into :porc from fases_colegiados where id_fase = :id_fase and id_col = :data ;
		
		this.setitem(1,'porcentaje',porc)
		
		select n_mutualista,src_n_poliza into :mut,:pol from musaat where id_col = :data;
		
		if SQLCA.SQLNRows = 0 then 
			messagebox(g_titulo,'El colegiado no es de MUSAAT.')
			return 2
		else
			this.setItem(row,'num_pol',pol)
			this.setItem(row,'num_mut',mut)
			if not(f_es_vacio(id_fase)) then cb_2.triggerevent(clicked!)
		end if
	CASE 't_visado'
		if data = '3' then 
			this.setItem(row,'obra_oficial', '0')
		else
			setnull(mut)
			this.setItem(row,'fecha_cfo', mut)
		end if	
END CHOOSE

end event

event doubleclicked;call super::doubleclicked;string obser

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

type cb_1 from commandbutton within w_fases_detalle_musaat
integer x = 3314
integer y = 1400
integer width = 402
integer height = 112
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

event clicked;close(parent)
end event

type cb_2 from commandbutton within w_fases_detalle_musaat
integer x = 2889
integer y = 1400
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
//Cambio Luis CGU-401,CTE-125
st_musaat_datos.colindantes2m = dw_1.getitemstring(1, 'colindantes2m')
st_musaat_datos.doble_condicion = dw_1.getitemstring(1, 'doble_condicion')
st_musaat_datos.int_forzosa = dw_1.getitemstring(1, 'int_forzosa')
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
//Cambio Luis CGU-401,CTE-125
dw_1.setitem(1, 'colindantes2m', st_musaat_datos.colindantes2m)
dw_1.setitem(1, 'doble_condicion', st_musaat_datos.doble_condicion)
dw_1.setitem(1, 'int_forzosa', st_musaat_datos.int_forzosa)
//Cambio Jesus SCP-776
dw_1.setitem(1, 'src_recargo', st_musaat_datos.coef_recargo)
//dw_1.setitem(1, 'formula', st_musaat_datos.formula)

end event

