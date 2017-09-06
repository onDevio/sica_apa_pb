HA$PBExportHeader$w_minutas_final.srw
forward
global type w_minutas_final from w_response
end type
type dw_pem_superficie from u_dw within w_minutas_final
end type
type cb_2 from commandbutton within w_minutas_final
end type
type dw_cip_musaat from u_dw within w_minutas_final
end type
type cb_3 from commandbutton within w_minutas_final
end type
type dw_1 from u_dw within w_minutas_final
end type
type dw_opciones from u_dw within w_minutas_final
end type
type dw_final_obra from u_dw within w_minutas_final
end type
type cb_1 from commandbutton within w_minutas_final
end type
type cb_siguiente from commandbutton within w_minutas_final
end type
end forward

global type w_minutas_final from w_response
integer width = 2455
integer height = 1348
string title = "Minutas Final"
boolean controlmenu = false
dw_pem_superficie dw_pem_superficie
cb_2 cb_2
dw_cip_musaat dw_cip_musaat
cb_3 cb_3
dw_1 dw_1
dw_opciones dw_opciones
dw_final_obra dw_final_obra
cb_1 cb_1
cb_siguiente cb_siguiente
end type
global w_minutas_final w_minutas_final

type variables
datawindowchild i_dwc_colegiados
w_fases_detalle i_w
datawindow idw_clientes, idw_colegiados, idw_descuentos, idw_fases_cip_tfe, idw_finales
datawindow idw_fases_datos_exp, idw_1, idw_fases_src, idw_estadistica, idw_historico
datawindow idw_informes
string i_id_col, reg, i_id_minuta, is_tipo_gestion
datastore ids_honos

end variables

forward prototypes
public subroutine wf_actualizar_minuta ()
public subroutine wf_insertar_final ()
public subroutine wf_actualizar_hon_min ()
public subroutine wf_actualizar_estadistica ()
public subroutine wf_actualizar_descuentos ()
end prototypes

public subroutine wf_actualizar_minuta ();string sn_cip, sn_musaat, sn_dv, sn_honos
double musaat = 0, cip = 0, dv = 0, honorarios = 0, cip_porc=0

// Introducimoss los valores en la minuta dependiendo de los checks
sn_honos 	= dw_cip_musaat.getitemstring(1, 'aplica_honos')
sn_cip 		= dw_cip_musaat.getitemstring(1, 'restar_cip')
sn_musaat 	= dw_cip_musaat.getitemstring(1, 'restar_musaat')
sn_dv 		= dw_cip_musaat.getitemstring(1, 'restar_dv')

honorarios 	= dw_cip_musaat.getitemnumber(1, 'honorarios')
musaat 		= dw_cip_musaat.getitemnumber(1, 'musaat')
cip 			= dw_cip_musaat.getitemnumber(1, 'cip')
dv 			= dw_cip_musaat.getitemnumber(1, 'dv')
cip_porc 		= dw_cip_musaat.getitemnumber(1, 'cip_porc_d')

// Marcamos la minuta como modificaci$$HEX1$$f300$$ENDHEX$$n para que no recalcule importes al provocar los eventos itemchanged
w_minutas_detalle.dw_minuta.setitem(1, 'tipo_minuta', '20')

// Lanzamos el itemchanged para que funcione como si se hubiera cambiado a mano
if sn_honos = 'S' and is_tipo_gestion = 'C' then
	w_minutas_detalle.dw_minuta. event itemchanged(1, w_minutas_detalle.dw_minuta.object.base_honos , string(w_minutas_detalle.dw_minuta.getitemnumber(1,'base_honos')))	
	w_minutas_detalle.dw_minuta.setitem(1, 'base_honos', honorarios)
end if
// Si no hay honorarios cambio a "Sin Gesti$$HEX1$$f300$$ENDHEX$$n de Cobro"
if ( honorarios = 0 or sn_honos <> 'S') and is_tipo_gestion = 'C' then
	w_minutas_detalle.dw_minuta.setitem(1, 'tipo_gestion', 'S')
	w_minutas_detalle.dw_minuta.event itemchanged(1, w_minutas_detalle.dw_minuta.object.tipo_gestion, 'S')
end if

if sn_cip = 'S' then 
	w_minutas_detalle.dw_minuta.event itemchanged(1, w_minutas_detalle.dw_minuta.object.base_cip, string(w_minutas_detalle.dw_minuta.getitemnumber(1,'base_cip')))	
	w_minutas_detalle.dw_minuta.setitem(1, 'base_cip', cip)
	w_minutas_detalle.dw_minuta.setitem(1, 'porc_cip', cip_porc)
end if
if sn_musaat = 'S' then
	w_minutas_detalle.dw_minuta.event itemchanged(1, w_minutas_detalle.dw_minuta.object.base_musaat, string(w_minutas_detalle.dw_minuta.getitemnumber(1,'base_musaat')))	
	w_minutas_detalle.dw_minuta.setitem(1, 'base_musaat', musaat)
end if
if sn_dv = 'S' then
	w_minutas_detalle.dw_minuta.event itemchanged(1, w_minutas_detalle.dw_minuta.object.base_dv, string(w_minutas_detalle.dw_minuta.getitemnumber(1,'base_dv')))	
	w_minutas_detalle.dw_minuta.setitem(1, 'base_dv', dv)
end if

// Modificado Paco 26/08/2005: El tipo_minuta no depende del tipo_gesti$$HEX1$$f300$$ENDHEX$$n sino del campo de admon.
// Esto es lo que hab$$HEX1$$ed00$$ENDHEX$$a antes
//// Tipo de minuta seg$$HEX1$$fa00$$ENDHEX$$n el tipo de gesti$$HEX1$$f300$$ENDHEX$$n
//if is_tipo_gestion = 'C' then
//	w_minutas_detalle.dw_minuta.setitem(1, 'tipo_minuta', '15')
//else
//	w_minutas_detalle.dw_minuta.setitem(1, 'tipo_minuta', '20')
//end if

// Esto es lo nuevo
if musaat <> 0 then
	string sl_obra_administracion
	sl_obra_administracion =  i_w.idw_fases_datos_exp.getitemstring(1, 'administracion')
//	messagebox('kk', sl_obra_administracion )
	if sl_obra_administracion = 'S' then
		// Tipo 25 --> $$HEX1$$fa00$$ENDHEX$$ltima certificaci$$HEX1$$f300$$ENDHEX$$n.
		w_minutas_detalle.dw_minuta.setitem(1, 'tipo_minuta', '25')
	else
		// Tipo 20 --> Modificado
		w_minutas_detalle.dw_minuta.setitem(1, 'tipo_minuta', '20')
	end if
else
	// Si no hay nada de MUSAAT no hacemos nada.
end if

// Grabamos
//w_minutas_detalle.dw_minuta.update()
// Metemos el n_aviso
//if w_minutas_detalle.dw_minuta.getitemstatus(1, 0, Primary!) = New! or w_minutas_detalle.dw_minuta.getitemstatus(1, 0, Primary!) = NewModified! then
//	w_minutas_detalle.dw_minuta.SetItem(1,'n_aviso',f_numera_aviso(true)) // Modificado Ricardo 2005-05-12
//	w_minutas_detalle.dw_minuta.update()
//end if

end subroutine

public subroutine wf_insertar_final ();//openwithparm(w_final_obra_minuta, i_id_minuta)
double sup_viv, sup_garage, sup_otros, num_viv, num_edif, presupuesto

sup_viv = dw_final_obra.getitemnumber(1, 'sup_viv')
sup_garage = dw_final_obra.getitemnumber(1, 'sup_garage')
sup_otros = dw_final_obra.getitemnumber(1, 'sup_otros')
num_viv = dw_final_obra.getitemnumber(1, 'num_viv')
num_edif = dw_final_obra.getitemnumber(1, 'num_edif')
presupuesto = dw_final_obra.getitemnumber(1, 'presupuesto')

if isnull(sup_viv) then sup_viv = 0
if isnull(sup_garage) then sup_garage = 0
if isnull(sup_otros) then sup_otros = 0
if isnull(num_viv) then num_viv = 0
if isnull(num_edif) then num_edif = 0
if isnull(presupuesto) then presupuesto = 0

// Si todo es 0 o nulo no grabamos ning$$HEX1$$fa00$$ENDHEX$$n final de obra e impedimos que nos solicite el grabado del dw al cerrar la ventana.
if sup_viv = 0 and sup_garage = 0 and sup_otros = 0 and num_viv = 0 and num_edif = 0 and presupuesto = 0 then 
	dw_final_obra.resetupdate()
	return
end if

// Grabamos el final
int i
i = dw_final_obra.update()
if i <> 1 then return

// Refrescamos el tab de finales
idw_finales.retrieve(g_id_fase)

idw_finales.dynamic event csd_buscar_total()

end subroutine

public subroutine wf_actualizar_hon_min ();double pem_min, coef_a, coef_b, coef_c
st_calculo_honorarios st_hon
datastore ds_honos

st_hon.id_fase = g_id_fase
st_hon.presupuesto = dw_pem_superficie.getitemnumber(1, 'pem2')
st_hon.superficie = dw_pem_superficie.getitemnumber(1, 'sup2')
st_hon.modo_oculto = 'S'

CHOOSE CASE g_colegio
	CASE 'COAATGU'
		st_hon.admon = idw_fases_datos_exp.getitemstring(1, 'administracion')
		st_hon.fecha = idw_1.GetItemdatetime(1,'f_entrada')
		openwithparm(w_calculo_gastos_honorarios_gu, st_hon)
		ds_honos = Message.PowerObjectParm
		if isvalid(ds_honos) then f_configura_parametros_fases_honos_gu (ds_honos.getitemstring(1,'tarifa'), idw_fases_cip_tfe, ds_honos, 'F')		
		
	CASE 'COAATLE'
		string med, obr
		st_hon.altura = idw_estadistica.getitemnumber(1, 'altura')
		st_hon.volumen = idw_estadistica.getitemnumber(1, 'volumen')
		med = idw_estadistica.getitemstring(1, 'colindantes')
		obr = idw_1.getitemstring(1, 'tipo_trabajo')
		st_hon.medianeras = f_coef_tipologia_medianeras(med, obr, st_hon.volumen)
		
		openwithparm(w_calculo_honorarios_le, st_hon)

		ds_honos = Message.PowerObjectParm
		if isvalid(ds_honos) then f_configura_parametros_fases_honos_le (ds_honos.getitemstring(1,'tarifa'), idw_fases_cip_tfe, ds_honos, 'F')

	CASE 'COAATAVI'
		openwithparm(w_calculo_honorarios_avi, st_hon)
			
		ds_honos = Message.PowerObjectParm
		if isvalid(ds_honos) then f_configura_parametros_fases_honos_avi (ds_honos.getitemstring(1,'tarifa'), idw_fases_cip_tfe, ds_honos, 'G')

END CHOOSE

idw_fases_cip_tfe.update()

end subroutine

public subroutine wf_actualizar_estadistica ();double pem2, sup, sup_ant, pem1

pem1 		= dw_pem_superficie.getitemnumber(1, 'pem1')
pem2 		= dw_pem_superficie.getitemnumber(1, 'pem2')
sup 		= dw_pem_superficie.getitemnumber(1, 'sup2')
sup_ant 	= dw_pem_superficie.getitemnumber(1, 'sup1')

// Superficie
if sup <> sup_ant then 
	openwithparm(w_superficie, dw_pem_superficie.getitemnumber(1, 'sup2'))

	idw_estadistica.event itemchanged(1, idw_estadistica.object.sup_viv, string(idw_estadistica.getitemnumber(1,'sup_viv')))
	idw_estadistica.event itemchanged(1, idw_estadistica.object.sup_garage, string(idw_estadistica.getitemnumber(1,'sup_garage')))
	idw_estadistica.event itemchanged(1, idw_estadistica.object.sup_otros, string(idw_estadistica.getitemnumber(1,'sup_otros')))
	idw_estadistica.event itemchanged(1, idw_estadistica.object.sup_sob, string(idw_estadistica.getitemnumber(1,'sup_sob')))
	idw_estadistica.event itemchanged(1, idw_estadistica.object.sup_baj, string(idw_estadistica.getitemnumber(1,'sup_baj')))

	idw_estadistica.setitem(1, 'sup_viv', g_st_datos_superficie.sup_viv)
	idw_estadistica.setitem(1, 'sup_garage', g_st_datos_superficie.sup_gar)
	idw_estadistica.setitem(1, 'sup_otros', g_st_datos_superficie.sup_otros)
	idw_estadistica.setitem(1, 'sup_sob', g_st_datos_superficie.sup_sob)
	idw_estadistica.setitem(1, 'sup_baj', g_st_datos_superficie.sup_baj)	
end if

if pem1 <> pem2 then
	// Presupuesto
	idw_estadistica.event itemchanged(1, idw_estadistica.object.pem, string(idw_estadistica.getitemnumber(1,'pem')))
	idw_estadistica.setitem(1, 'pem', pem2)
end if

// Actualizamos los dw
idw_estadistica.update()
idw_historico.update()

end subroutine

public subroutine wf_actualizar_descuentos ();double cip = 0, dv = 0, musaat = 0, i, j
st_cip_datos st_cip_datos
st_csi_articulos_servicios st_csi_articulos_servicios
st_musaat_datos st_musaat_datos
st_dv_datos st_dv_datos
int fila_insertada, ret
string id_col, id_asociado

// CIP
// En algunos colegios se calcula en la ventana de honorarios
if g_colegio = 'COAATTFE' or g_colegio = 'COAATGU' then
	cip = idw_fases_cip_tfe.getitemnumber(1, 'importe_cip')
else
	st_cip_datos.tipo_act = idw_1.getitemstring(1, 'fase')
	st_cip_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
	st_cip_datos.admon = i_w.idw_fases_datos_exp.getitemstring(1, 'administracion')
	st_cip_datos.volumen = i_w.idw_fases_estadistica.getitemnumber(1, 'volumen')
	st_cip_datos.superficie = dw_pem_superficie.getitemnumber(1, 'sup2')
	st_cip_datos.pem = dw_pem_superficie.getitemnumber(1, 'pem2')
	st_cip_datos.id_fase = idw_1.getitemstring(1, 'id_fase')
	st_cip_datos.porcentaje = 100
	
	// Pasamos los datos de los honos minimos a la funci$$HEX1$$f300$$ENDHEX$$n de cip
	if g_colegio =  'COAATAVI' then
		st_cip_datos.tarifa = idw_fases_cip_tfe.getitemstring(1, 'tarifa')
		st_cip_datos.hon_teor =  idw_fases_cip_tfe.getitemnumber(1, 'importe_ho')	
	end if

	f_calcular_cip(st_cip_datos)
	cip = st_cip_datos.cip
end if
if isnull(cip) then cip = 0

// Inserto fila
if cip > 0 then
	//Comprobar si ya se ha calculado el CIP anteriormente
	long fila_cip
	double cip_ant
	fila_cip = idw_descuentos.Find("tipo_informe = '" + g_codigos_conceptos.cip + "'",0,idw_descuentos.RowCount())
	if fila_cip > 0 Then
		fila_insertada = fila_cip
	Else
		fila_insertada = idw_descuentos.dynamic event pfc_addrow()
	End if
	if fila_insertada > 0 then
		idw_descuentos.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.cip)
		// cojo los datos del concepto
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.cip
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		idw_descuentos.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		idw_descuentos.event itemchanged(fila_insertada, idw_descuentos.object.cuantia_colegiado, string(idw_descuentos.getitemnumber(fila_insertada,'cuantia_colegiado')))
		idw_descuentos.setitem(fila_insertada, 'cuantia_colegiado', cip )		
		idw_descuentos.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(cip, st_csi_articulos_servicios.t_iva ))
	end if
end if


// MUSAAT
double porc_col = 0, porc_col_real = 0, suma_porc = 0

// Suma de la Musaat de todos los colegiado
// Si es una asociaci$$HEX1$$f300$$ENDHEX$$n, de todos los asociados
st_musaat_datos.n_visado = idw_1.getitemstring(1, 'id_fase')
st_musaat_datos.tipo_act = idw_1.getitemstring(1, 'fase')
st_musaat_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
st_musaat_datos.pem = dw_pem_superficie.getitemnumber(1, 'pem2')
st_musaat_datos.administracion = idw_fases_datos_exp.getitemstring(1, 'administracion')
st_musaat_datos.superficie = dw_pem_superficie.getitemnumber(1, 'sup2')
st_musaat_datos.volumen = idw_estadistica.getitemnumber(1, 'volumen')

// Suma de los % de los colegiados
for j = 1 to idw_colegiados.rowcount()
	suma_porc +=  idw_colegiados.getitemnumber(j, 'porcen_a')	
next

for i = 1 to idw_colegiados.rowcount()
	porc_col =  idw_colegiados.getitemnumber(i, 'porcen_a')	
	if isnull(suma_porc) or suma_porc = 0 then exit
	porc_col_real = porc_col / suma_porc * 100	
	st_musaat_datos.porcentaje = porc_col_real
	id_col = idw_colegiados.getitemstring(i, 'id_col')
	st_musaat_datos.id_col = id_col
	st_musaat_datos.cobertura = 0
	
	if f_colegiado_tipopersona(id_col) = 'S' then	
		f_musaat_calcula_prima_sociedad(st_musaat_datos)
		musaat += st_musaat_datos.prima_comp	
	else
		f_musaat_calcula_prima(st_musaat_datos)	
		musaat += st_musaat_datos.prima_comp
	end if
next
if isnull(musaat) then musaat = 0

if musaat > 0 then
	//Comprobar si ya se ha calculado los DV anteriormente
	long fila_musaat
	double musaat_ant
	fila_musaat = idw_descuentos.Find("tipo_informe = '" + g_codigos_conceptos.musaat_variable + "'",0,idw_descuentos.RowCount())
	if fila_musaat > 0 Then
		fila_insertada = fila_musaat
	Else
		fila_insertada = idw_descuentos.dynamic event pfc_addrow()
	End if

	if fila_insertada > 0 then
		idw_descuentos.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.musaat_variable)
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.musaat_variable
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		idw_descuentos.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		idw_descuentos.event itemchanged(fila_insertada, idw_descuentos.object.cuantia_colegiado, string(idw_descuentos.getitemnumber(fila_insertada,'cuantia_colegiado')))
		idw_descuentos.setitem(fila_insertada, 'cuantia_colegiado', musaat )
		idw_descuentos.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(musaat, st_csi_articulos_servicios.t_iva ))
	end if
end if

//DV
if idw_fases_cip_tfe.rowcount()>0 then
	st_dv_datos.tarifa = idw_fases_cip_tfe.getitemstring(1, 'tarifa')
	st_dv_datos.contenido = idw_fases_cip_tfe.getitemstring(1, 'epigrafe')
	//st_dv_datos.pres_seguridad = idw_estadistica.getitemnumber(1, 'pres_seguridad')
	// En COAATLE no existe este campo
	if lower(idw_estadistica.describe("pres_seguridad.name")) = 'pres_seguridad' then idw_estadistica.getitemnumber(1, 'pres_seguridad')
	st_dv_datos.porcentaje = 100
	
	f_calcular_dv(st_dv_datos)
	dv = st_dv_datos.dv
	if isnull(dv) then dv = 0
end if

if dv > 0 then
	//Comprobar si ya se ha calculado los DV anteriormente
	long fila_dv
	double dv_ant
	fila_dv = idw_descuentos.Find("tipo_informe = '" + g_codigos_conceptos.dv + "'",0,idw_descuentos.RowCount())
	if fila_dv > 0 Then
		fila_insertada = fila_dv
	Else
		fila_insertada = idw_descuentos.dynamic event pfc_addrow()
	End if

	if fila_insertada > 0 then
		idw_descuentos.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.dv)
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.dv
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		idw_descuentos.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		idw_descuentos.setitem(fila_insertada, 'cuantia_colegiado', dv )
		idw_descuentos.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(dv, st_csi_articulos_servicios.t_iva ))
	end if
end if

// Grabamos los cambios
idw_descuentos.update()
idw_historico.update()

end subroutine

on w_minutas_final.create
int iCurrent
call super::create
this.dw_pem_superficie=create dw_pem_superficie
this.cb_2=create cb_2
this.dw_cip_musaat=create dw_cip_musaat
this.cb_3=create cb_3
this.dw_1=create dw_1
this.dw_opciones=create dw_opciones
this.dw_final_obra=create dw_final_obra
this.cb_1=create cb_1
this.cb_siguiente=create cb_siguiente
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pem_superficie
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_cip_musaat
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.dw_opciones
this.Control[iCurrent+7]=this.dw_final_obra
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.cb_siguiente
end on

on w_minutas_final.destroy
call super::destroy
destroy(this.dw_pem_superficie)
destroy(this.cb_2)
destroy(this.dw_cip_musaat)
destroy(this.cb_3)
destroy(this.dw_1)
destroy(this.dw_opciones)
destroy(this.dw_final_obra)
destroy(this.cb_1)
destroy(this.cb_siguiente)
end on

event open;call super::open;f_centrar_ventana(this)

i_id_col = message.stringparm
// Obtenemos el id_minuta
i_id_minuta = w_minutas_detalle.dw_minuta.getitemstring(1, 'id_minuta')

dw_pem_superficie.insertrow(0)
dw_cip_musaat.insertrow(0)
dw_1.insertrow(0)
dw_opciones.insertrow(0)

i_w = g_detalle_fases
idw_1 = i_w.dw_1
idw_clientes 			= i_w.idw_fases_promotores
idw_colegiados 		= i_w.idw_fases_colegiados
idw_descuentos 		= i_w.idw_fases_informes
idw_fases_datos_exp 	= i_w.dw_fases_datos_exp
idw_fases_src 			= i_w.idw_fases_src
idw_estadistica 		= i_w.idw_fases_estadistica
idw_historico 			= i_w.idw_fases_modificacion_datos
idw_fases_cip_tfe 	= i_w.idw_fases_cip_tfe
idw_finales 			= i_w.idw_fases_finales_obra
idw_informes			= i_w.idw_fases_informes

if i_w.idw_fases_estadistica.rowcount() > 0 then
	dw_pem_superficie.setitem(1, 'pem1', i_w.idw_fases_estadistica.getitemnumber(1, 'pem'))
	dw_pem_superficie.setitem(1, 'sup1', i_w.idw_fases_estadistica.getitemnumber(1, 'sup_total'))
	dw_pem_superficie.setitem(1, 'pem2', i_w.idw_fases_estadistica.getitemnumber(1, 'pem'))
	dw_pem_superficie.setitem(1, 'sup2', i_w.idw_fases_estadistica.getitemnumber(1, 'sup_total'))
else
	dw_pem_superficie.setitem(1, 'pem1', 0)
	dw_pem_superficie.setitem(1, 'sup1', 0)
end if

// Miramos el tipo de gestion para saber como debemos comportarnos
if f_tipo_gestion_colegiado(i_w.dw_1.GetitemString(1, 'id_fase'), i_id_col) = 'P' then
	is_tipo_gestion = 'S'
else
	is_tipo_gestion = 'C'
end if

dw_cip_musaat.trigger event csd_configura_tipo_gestion()
dw_cip_musaat.post event csd_rellenar_cip_musaat_contrato(g_id_fase)

if g_colegio = 'COAATAVI' then
	string tarifa
	select tarifa into :tarifa from fases_cip_tfe where id_fase = :g_id_fase ;
	if tarifa <> "" then cb_2.post event clicked()
else
	if(g_colegio <> 'COAATTGN' and g_colegio <> 'COAATTEB' AND g_colegio<>'COAATLL')then	cb_2.post event clicked()
end if

// Llamamos al control de eventos
st_control_eventos c_evento
c_evento.evento = 'W_MINUTAS_FINAL'
c_evento.dw = dw_cip_musaat
if f_control_eventos(c_evento)=-1 then return

end event

event pfc_postopen();call super::pfc_postopen;dw_1.of_SetDropDownCalendar(True)
dw_1.iuo_calendar.of_register(dw_1.iuo_calendar.DDLB)
dw_1.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_1.iuo_calendar.of_SetInitialValue(True)

dw_final_obra.of_SetDropDownCalendar(True)
dw_final_obra.iuo_calendar.of_register(dw_final_obra.iuo_calendar.DDLB)
dw_final_obra.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_final_obra.iuo_calendar.of_SetInitialValue(True)

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_minutas_final
integer x = 2533
integer y = 1796
integer width = 46
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_minutas_final
integer x = 2464
integer y = 1792
integer width = 46
integer taborder = 0
end type

type dw_pem_superficie from u_dw within w_minutas_final
integer x = 174
integer y = 32
integer width = 2112
integer height = 328
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_datos_pem_superficie"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;// Sobreescrito
end event

event itemfocuschanged;call super::itemfocuschanged;choose case dwo.name
	case 'pem1', 'pem2','sup1', 'sup2'
		this.SelectText(1, LenA(string(double(this.GetText()),"###,###,##0.00")))		
end choose

end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE 'pem1', 'sup1'
		// LANZAMOS EL EVENTO QUE HACE EL RECALCULO DE TODO
		dw_cip_musaat.post event csd_rellenar_cip_musaat_contrato(g_id_fase)
		if g_colegio <> 'COAATAVI' then cb_2.post event clicked()
		dw_1.setitem(1, 'avi_fact', 'A')
END CHOOSE

end event

type cb_2 from commandbutton within w_minutas_final
integer x = 1929
integer y = 252
integer width = 402
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Calcular"
end type

event clicked;string id_col, id_fase, tarifa
double cip, total_musaat = 0, porc_col = 0, suma_porc = 0, porc_col_real = 0, pem_nueva, sup_nueva, dv, pem_min, coef_a, coef_b, coef_c, honos
int i, retorno, fila_colegiado
st_calculo_honorarios st_hon_or
st_musaat_datos st_musaat_datos
st_cip_datos st_cip_datos
st_dv_datos st_dv_datos
st_honteor_datos st_hon

id_col = i_id_col
id_fase = g_id_fase

// Validaciones
if f_es_vacio(id_col) or f_es_vacio(id_fase) then return

dw_pem_superficie.accepttext()
pem_nueva = dw_pem_superficie.getitemnumber(1, 'pem2')
sup_nueva = dw_pem_superficie.getitemnumber(1, 'sup2')
if f_es_vacio(string(pem_nueva)) or f_es_vacio(string(sup_nueva)) then 
	messagebox(g_titulo, 'Debe introducir los nuevos valores para el PEM y la Superficie')
	return
end if

// Buscamos al colegiado en la lista
for i = 1 to i_w.idw_fases_colegiados.rowcount()
	if i_w.idw_fases_colegiados.getitemstring(i, 'id_col') = id_col then
		fila_colegiado = i
		exit
	end if
next

// Obtenemos el % del porcentaje
porc_col = i_w.idw_fases_colegiados.getitemnumber(fila_colegiado, 'porcen_a')
for i = 1 to i_w.idw_fases_colegiados.rowcount()
	suma_porc += i_w.idw_fases_colegiados.getitemnumber(i, 'porcen_a')
next
porc_col_real = porc_col / suma_porc


// Musaat Nueva
if i_w.idw_fases_estadistica.rowcount() > 0 then
	st_musaat_datos.n_visado = idw_1.getitemstring(1, 'id_fase')
	st_musaat_datos.id_col = id_col
	st_musaat_datos.tipo_act = idw_1.getitemstring(1, 'fase')
	st_musaat_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
	st_musaat_datos.pem = pem_nueva
	st_musaat_datos.administracion = i_w.idw_fases_datos_exp.getitemstring(1, 'administracion')
	st_musaat_datos.superficie = sup_nueva
	st_musaat_datos.volumen = i_w.idw_fases_estadistica.getitemnumber(1, 'volumen')
	st_musaat_datos.colindantes2m = i_w.idw_fases_estadistica.getitemstring(1, 'colindantes2m')
	st_musaat_datos.porcentaje = porc_col_real * 100
	
	datetime fecha
	double variac_pem, variac_sup
	fecha = f_musaat_fecha_visado_movimiento (id_fase)
	variac_pem = abs(dw_pem_superficie.getitemnumber(1, 'porc_pem'))
	variac_sup = abs(dw_pem_superficie.getitemnumber(1, 'porc_sup'))	
	
	if g_musaat_tabla_desc_activa = 'S' then 
		// Nuevas normas MUSAAT 2009. En regularizaciones superiores a 20% de visados anteriores a 2009 no se aplica tabla de descuentos
		if fecha<datetime(date('01/01/2009'), time('00:00:00')) and fecha<>datetime(date('01/01/1900'), time('00:00:00')) and (variac_pem > 20 or variac_sup > 20) and porc_col_real <> 1 then
			st_musaat_datos.no_aplicar_tabla_desc = true
			messagebox(g_titulo, "No se va a aplicar la tabla de descuentos de Musaat.", information!)
		end if
		
		//	//SCP-193 Para devoluciones anteriores al 4/08/09 con prima negativa debe realizarse con recargo inicial 0.3%
		date f_aux1
		f_aux1 = date(f_musaat_fecha_visado_movimiento( idw_1.getitemstring(1, 'id_fase')))
		if f_aux1< date('4/8/2009')   and (dw_pem_superficie.getitemdecimal(1, 'porc_pem')<0 or dw_pem_superficie.getitemdecimal(1, 'porc_sup')<0) then
			st_musaat_datos.no_aplicar_tarifa_coef_g =true
		else
			st_musaat_datos.no_aplicar_tarifa_coef_g =false
		end if
		// fin scp-193
	else
		
		// Se hacen las validaciones para variaciones de visados con fecha>= '01-01-09' al '12-21-09'
		if fecha>= datetime(date('01/01/2009'), time('00:00:00')) and fecha <datetime(date('01/01/2010'), time('00:00:00')) and (variac_pem >= 20 or variac_sup >= 20) and porc_col_real <> 1 then
		
			tarifa = f_musaat_tipo_tarifa(idw_1.getitemstring(1, 'fase'), sup_nueva, idw_1.getitemstring(1, 'tipo_trabajo') ) 
			choose case tarifa 
				case 'A', 'B', 'C'
					if (variac_pem>= 20) or (variac_pem>= 20 and  variac_sup >= 20) then st_musaat_datos.pem = pem_nueva - dw_pem_superficie.getitemnumber(1, 'pem1')
					if variac_sup >= 20 and tarifa = 'A' then st_musaat_datos.coef_k = f_musaat_dame_coef_k_mov(id_fase, id_col)
						
			end choose
					
		end if
		
	end if
	

	if f_colegiado_tipopersona(id_col) = 'S' then
		retorno = f_musaat_calcula_prima_sociedad(st_musaat_datos)			
	else
		retorno = f_musaat_calcula_prima(st_musaat_datos)
	end if			
	total_musaat = st_musaat_datos.prima_comp
	total_musaat = f_redondea(total_musaat)
end if
dw_cip_musaat.setitem(1, 'musaat_nueva', total_musaat)


CHOOSE CASE g_colegio
	CASE 'COAATAVI'
		datastore ds_honos
		// HONORARIOS ORIENTATIVOS
		st_hon_or.id_fase = g_id_fase
		st_hon_or.presupuesto = dw_pem_superficie.getitemnumber(1, 'pem2')
		st_hon_or.superficie = dw_pem_superficie.getitemnumber(1, 'sup2')
		
		select tarifa into :tarifa from fases_cip_tfe where id_fase = :g_id_fase ;
		if not f_es_vacio(tarifa) then	st_hon_or.modo_oculto = 'S'
	
		// Par$$HEX1$$e100$$ENDHEX$$metros del pem m$$HEX1$$ed00$$ENDHEX$$nimo
		SELECT fases_cip_tfe.pem_min, fases_cip_tfe.coef_a, fases_cip_tfe.coef_b, fases_cip_tfe.coef_c  
		INTO :pem_min, :coef_a, :coef_b, :coef_c
		FROM fases_cip_tfe  
		HAVING ( fases_cip_tfe.id_fase = :st_hon_or.id_fase )   ;
			
		st_hon_or.pem_min = pem_min
		st_hon_or.coef_a = coef_a
		st_hon_or.coef_b = coef_b
		st_hon_or.coef_c = coef_c
		openwithparm(w_calculo_honorarios_avi, st_hon_or)
			
		ds_honos = Message.PowerObjectParm
		//	if isvalid(ds_honos) then f_configura_parametros_fases_honos_avi (ds_honos.getitemstring(1,'tarifa'), idw_fases_cip_tfe, ds_honos, 'G')
		if isvalid(ds_honos) then honos =  ds_honos.getitemnumber(1, 'importe')
		
		// CIP
		st_cip_datos.admon = i_w.idw_fases_datos_exp.getitemstring(1, 'administracion')
		//	st_cip_datos.tipo_gestion = idw_1.GetItemString(1,'tipo_gestion')
		st_cip_datos.hon_teor = honos  //idw_fases_cip_tfe.getitemnumber(1, 'importe_ho')	
		f_calcular_cip(st_cip_datos)
		cip = st_cip_datos.cip * porc_col/100
		if isnull(cip) then cip = 0
		dw_cip_musaat.setitem(1, 'cip_nueva', f_redondea(cip))
		
		//	// DV
		//	st_dv_datos.administracion = ( i_w.idw_fases_datos_exp.getitemstring(1, 'administracion') = 'S')
		//	st_dv_datos.hon_teor =  idw_fases_cip_tfe.getitemnumber(1, 'importe_ho')
		//	f_calcular_dv(st_dv_datos)
		//	dv = st_dv_datos.dv
		//	if isnull(dv) then dv = 0	
		//	dw_cip_musaat.setitem(1, 'dv_nueva', f_redondea(dv))
		
	CASE 'COAATGU'
		// CIP Nueva
		st_hon.tarifa = idw_fases_cip_tfe.getitemstring(1, 'tarifa')
		st_hon.contenido = idw_fases_cip_tfe.getitemstring(1, 'epigrafe')
		st_hon.admon = idw_fases_datos_exp.getitemstring(1, 'administracion')
		st_hon.presupuesto = dw_pem_superficie.getitemnumber(1, 'pem2')
		st_hon.superficie = dw_pem_superficie.getitemnumber(1, 'sup2')		
		f_calcular_cip_gu(st_hon)
		cip = st_hon.importe * porc_col/100		
		dw_cip_musaat.setitem(1, 'cip_nueva', f_redondea(cip))
		// Honorarios
		f_calcular_honteor_gu(st_hon)
		
		CASE 'COAATCC'
			// Se calcula los honorarios teoricos
			st_hon.tarifa = idw_fases_cip_tfe.getitemstring(1, 'tarifa')
			st_hon.contenido = idw_fases_cip_tfe.getitemstring(1, 'epigrafe')
			st_hon.admon = idw_fases_datos_exp.getitemstring(1, 'administracion')
			st_hon.presupuesto = dw_pem_superficie.getitemnumber(1, 'pem2')
			st_hon.superficie = dw_pem_superficie.getitemnumber(1, 'sup2')		
			st_hon.ca = g_ca
			f_calcular_honteor_cc(st_hon)
			
			st_cip_datos.hon_teor =st_hon.importe
			st_cip_datos.porcentaje = 100
			f_calcular_cip(st_cip_datos)
			cip = st_cip_datos.cip * porc_col/100
			dw_cip_musaat.setitem(1, 'cip_nueva', f_redondea(cip))
			
	CASE 'COAATLE'
		// CIP Nueva
		st_hon.tarifa = idw_fases_cip_tfe.getitemstring(1, 'tarifa')
		st_hon.contenido = idw_fases_cip_tfe.getitemstring(1, 'epigrafe')
		st_hon.admon = idw_fases_datos_exp.getitemstring(1, 'administracion')
		st_hon.presupuesto = dw_pem_superficie.getitemnumber(1, 'pem2')
		st_hon.superficie = dw_pem_superficie.getitemnumber(1, 'sup2')		

		st_cip_datos.tipo_act = idw_1.getitemstring(1, 'fase')
		st_cip_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
		st_cip_datos.admon = i_w.idw_fases_datos_exp.getitemstring(1, 'administracion')
		st_cip_datos.volumen = i_w.idw_fases_estadistica.getitemnumber(1, 'volumen')
		st_cip_datos.superficie = sup_nueva
		st_cip_datos.pem = pem_nueva
		st_cip_datos.id_fase = idw_1.getitemstring(1, 'id_fase')
		st_cip_datos.porcentaje = 100
		f_calcular_cip(st_cip_datos)
		cip = st_cip_datos.cip * porc_col/100		
		dw_cip_musaat.setitem(1, 'cip_nueva', f_redondea(cip))

		// Honorarios
		f_calcular_honteor_gu(st_hon)
		st_hon.importe = 0
		
	CASE 'COAATA'
		st_cip_datos.tipo_act = idw_1.getitemstring(1, 'fase')
		st_cip_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
		st_cip_datos.admon = i_w.idw_fases_datos_exp.getitemstring(1, 'administracion')
		st_cip_datos.volumen = i_w.idw_fases_estadistica.getitemnumber(1, 'volumen')
		st_cip_datos.superficie = sup_nueva
		st_cip_datos.pem = pem_nueva
		st_cip_datos.id_fase = idw_1.getitemstring(1, 'id_fase')
		st_cip_datos.porcentaje = 100
		f_calcular_cip(st_cip_datos)
		cip = st_cip_datos.cip * porc_col/100
		dw_cip_musaat.setitem(1, 'cip_nueva', f_redondea(cip))
		// Honorarios
		f_calcular_honteor_gu(st_hon)

	CASE 'COAATNA'
		// No recalculan DIP
		
		
	CASE 'COAATTGN', 'COAATTEB', 'COAATLL'
		st_cip_datos.tipo_act = idw_1.getitemstring(1, 'fase')
		st_cip_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
		st_cip_datos.destino_i = idw_1.getitemString(1, 'destino_int')
		st_cip_datos.tipo_reforma =  i_w.idw_fases_estadistica.getitemString(1, 'tipo_reforma')		
		st_cip_datos.volumen = i_w.idw_fases_estadistica.getitemnumber(1, 'volumen')
		st_cip_datos.num_viv =  i_w.idw_fases_estadistica.getitemnumber(1, 'num_viv')	
		st_cip_datos.pem = pem_nueva
		st_cip_datos.id_fase = idw_1.getitemstring(1, 'id_fase')
		st_cip_datos.porcentaje = 100
		
		// Se necesita saber el desglose de las superficies para los c$$HEX1$$e100$$ENDHEX$$lculos
		double sup, sup_ant

		sup 		= dw_pem_superficie.getitemnumber(1, 'sup2')
		sup_ant 	= dw_pem_superficie.getitemnumber(1, 'sup1')

		openwithparm(w_superficie, dw_pem_superficie.getitemnumber(1, 'sup2'))

		st_cip_datos.sup_viviendas =  g_st_datos_superficie.sup_viv //i_w.idw_fases_estadistica.getitemnumber(1, 'sup_viv')	
		st_cip_datos.sup_otros =   g_st_datos_superficie.sup_gar + g_st_datos_superficie.sup_otros //i_w.idw_fases_estadistica.getitemnumber(1, 'sup_otros') +  i_w.idw_fases_estadistica.getitemnumber(1, 'sup_garage')				
		st_cip_datos.superficie = sup

		f_calcular_cip(st_cip_datos)
		cip = st_cip_datos.cip * porc_col/100
		dw_cip_musaat.setitem(1, 'cip_nueva', f_redondea(cip))
		
END CHOOSE

dw_cip_musaat.setitem(1, 'honorarios_nueva', f_redondea(st_hon.importe * porc_col_real))
dw_cip_musaat.setitem(1, 'cip', f_redondea(dw_cip_musaat.getitemnumber(1, 'cip_nueva') - dw_cip_musaat.getitemnumber(1, 'cip_pagada')))
if fecha>= datetime(date('01/01/2009'), time('00:00:00')) and fecha <datetime(date('01/01/2010'), time('00:00:00')) and (variac_pem >= 20 or variac_sup >= 20) and porc_col_real <> 1 then
	if tarifa = 'A' or tarifa = 'B' or tarifa = 'C' then
		dw_cip_musaat.setitem(1, 'musaat', dw_cip_musaat.getitemnumber(1, 'musaat_nueva') )
	else
		dw_cip_musaat.setitem(1, 'musaat', dw_cip_musaat.getitemnumber(1, 'musaat_nueva') - dw_cip_musaat.getitemnumber(1, 'musaat_pagada'))
	end if
else
	dw_cip_musaat.setitem(1, 'musaat',f_redondea(dw_cip_musaat.getitemnumber(1, 'musaat_nueva') - dw_cip_musaat.getitemnumber(1, 'musaat_pagada')))
end if
//dw_cip_musaat.setitem(1, 'musaat', f_redondea(dw_cip_musaat.getitemnumber(1, 'musaat_nueva') - dw_cip_musaat.getitemnumber(1, 'musaat_pagada')))
dw_cip_musaat.setitem(1, 'dv', f_redondea(dw_cip_musaat.getitemnumber(1, 'dv_nueva') - dw_cip_musaat.getitemnumber(1, 'dv_pagada')))
dw_cip_musaat.setitem(1, 'honorarios', f_redondea(dw_cip_musaat.getitemnumber(1, 'honorarios_nueva') - dw_cip_musaat.getitemnumber(1, 'honorarios_pagada')))

if dw_cip_musaat.getitemnumber(1, 'honorarios') <= 0 then dw_cip_musaat.setitem(1,'aplica_honos','N') else dw_cip_musaat.setitem(1,'aplica_honos','S')
if dw_cip_musaat.getitemnumber(1, 'cip') <= 0 then dw_cip_musaat.setitem(1,'restar_cip','N') else dw_cip_musaat.setitem(1,'restar_cip','S')
if dw_cip_musaat.getitemnumber(1, 'musaat') <= 0 then dw_cip_musaat.setitem(1,'restar_musaat','N') else dw_cip_musaat.setitem(1,'restar_musaat','S')
if dw_cip_musaat.getitemnumber(1, 'dv') <= 0 then dw_cip_musaat.setitem(1,'restar_dv','N') else dw_cip_musaat.setitem(1,'restar_dv','S')


dw_cip_musaat.setitem(1, 'cip_porc_d', 100)
dw_cip_musaat.setitem(1, 'musaat_porc_d', 100)
dw_cip_musaat.setitem(1, 'dv_porc_d', 100)

// Cuando el aumento de presupuesto sea menor al 20% que no incluya musaat
if g_colegio = 'COAATGU' then
	if dw_pem_superficie.getitemnumber(1, 'porc_pem') < 20 then
		dw_cip_musaat.setitem(1,'restar_musaat','N')
	else
		dw_cip_musaat.setitem(1,'restar_musaat','S')
	end if
end if

end event

type dw_cip_musaat from u_dw within w_minutas_final
event csd_configura_tipo_gestion ( )
event csd_rellenar_cip_musaat_contrato ( string id_fase )
integer x = 59
integer y = 384
integer width = 2267
integer height = 404
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_minutas_final_datos_nuevo"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_configura_tipo_gestion();this.setredraw(false)

CHOOSE CASE is_tipo_gestion
	CASE 'C'
		// Con gesti$$HEX1$$d300$$ENDHEX$$n de cobro
		this.object.aplica_honos.visible = true
		this.object.honorarios_t.visible = true
		this.object.honorarios.visible = true
		this.object.honorarios_total.visible = true
		this.object.honorarios_nueva.visible = true
		this.object.honorarios_pagada.visible = true
		this.object.compute_1.visible = true
		this.object.honos_porc_d.visible = true
	CASE 'S'
		// Sin gesti$$HEX1$$d300$$ENDHEX$$n de cobro
		this.object.aplica_honos.visible = false
		this.object.honorarios_t.visible = false
		this.object.honorarios.visible = false
		this.object.honorarios_total.visible = false
		this.object.honorarios_nueva.visible = false
		this.object.honorarios_pagada.visible = false
		this.object.compute_1.visible = false
		this.object.honos_porc_d.visible = false
END CHOOSE

this.setredraw(true)

// No se regularizan los DV
if g_colegio = 'COAATZ' or g_colegio = 'COAATGU' or g_colegio = 'COAATLE' or g_colegio = 'COAATAVI' or g_colegio = 'COAATTGN' or g_colegio = 'COAATTEB' or g_colegio = 'COAATTER' OR g_colegio='COAATLL' then 
	this.setitem(1, 'restar_dv', 'N')
end if

end event

event csd_rellenar_cip_musaat_contrato(string id_fase);string id_col
long retorno
double porc_col = 0, porc_col_real = 0, suma_porc = 0
double total_cip = 0, total_musaat = 0, total_dv = 0, total_hon = 0
double pagado_cip = 0, pagado_musaat = 0, pagado_dv = 0, pagado_hon = 0
st_musaat_datos st_musaat_datos

// Recuperamos los datos de entrada
id_col = i_id_col
id_fase = g_id_fase
// Validaciones
if f_es_vacio(id_col) or f_es_vacio(id_fase) then return

// Obtenemos el % del porcentaje
select porcen_a into :porc_col from fases_colegiados where id_fase = :id_fase and id_col = :id_col;
select sum(porcen_a) into :suma_porc from fases_colegiados where id_fase = :id_fase;

porc_col_real = porc_col / suma_porc

// Prima Total (actual)
if i_w.idw_fases_estadistica.rowcount() > 0 then
	string tipo_act, tipo_trabajo, administracion
	double volumen
	
	select fase, fases.tipo_trabajo, administracion, volumen 
	into :tipo_act, :tipo_trabajo, :administracion, :volumen
	from expedientes, fases 
	where expedientes.id_expedi = fases.id_expedi and fases.id_fase = :id_fase;
	st_musaat_datos.n_visado = id_fase
	st_musaat_datos.id_col = id_col
	st_musaat_datos.tipo_act = tipo_act
	st_musaat_datos.tipo_obra = tipo_trabajo
	st_musaat_datos.pem = dw_pem_superficie.GetItemNumber(1, 'pem1')
	st_musaat_datos.administracion = administracion
	st_musaat_datos.superficie = dw_pem_superficie.GetItemNumber(1, 'sup1')
	st_musaat_datos.volumen = volumen
	st_musaat_datos.porcentaje =porc_col_real * 100
	if f_colegiado_tipopersona(id_col) = 'S' then
		retorno = f_musaat_calcula_prima_sociedad(st_musaat_datos)			
	else
		retorno = f_musaat_calcula_prima(st_musaat_datos)
	end if			
	total_musaat = st_musaat_datos.prima_comp
	total_musaat = f_redondea(total_musaat)
end if
this.setitem(1, 'musaat_total', total_musaat)

// CIP Total (actual)
total_cip = f_cip_contrato_dw(idw_informes)
total_cip = f_redondea(total_cip * porc_col_real)
total_cip = f_redondea(total_cip)
this.setitem(1, 'cip_total', total_cip)

// DV total (actual)
total_dv = f_dv_contrato_dw(idw_informes)
total_dv = f_redondea(total_dv * porc_col_real)
total_dv = f_redondea(total_dv)
this.setitem(1, 'dv_total', total_dv)

// Honorarios (actual)
total_hon = idw_1.getitemnumber(1, 'honorarios')
total_hon = f_redondea(total_hon * porc_col_real)
total_hon = f_redondea(total_hon)
this.setitem(1, 'honorarios_total', total_hon)

// Pagado
string id_expedi
id_expedi = idw_1.getitemstring(1, 'id_expedi')
pagado_cip = f_total_cobrado_cip_colegiado(id_fase, id_col)
pagado_musaat = f_total_cobrado_musaat_colegiado(id_fase, id_col)
pagado_dv = f_total_cobrado_dv_colegiado(id_fase, id_col)
pagado_hon = f_total_cobrado_honos_colegiado(id_fase, id_col)

this.setitem(1, 'cip_pagada', pagado_cip)
this.setitem(1, 'musaat_pagada', pagado_musaat)
this.setitem(1, 'dv_pagada', pagado_dv)
this.setitem(1, 'honorarios_pagada', pagado_hon)

this.setitem(1, 'cip', this.getitemnumber(1, 'cip_nueva') - this.getitemnumber(1, 'cip_pagada'))
this.setitem(1, 'musaat', this.getitemnumber(1, 'musaat_nueva') - this.getitemnumber(1, 'musaat_pagada'))
this.setitem(1, 'dv', this.getitemnumber(1, 'dv_nueva') - this.getitemnumber(1, 'dv_pagada'))
this.setitem(1, 'honorarios', this.getitemnumber(1, 'honorarios_nueva') - this.getitemnumber(1, 'honorarios_pagada'))


// Actualizamos porcentajes de diferencia
this.setitem(1, 'cip_porc_d',100 )
this.setitem(1, 'musaat_porc_d', 100)
this.setitem(1, 'dv_porc_d', 100)
end event

event doubleclicked;// Sobreescrito
end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE 'restar_cip'
		if data = 'N' then this.setitem(1,'cip',0)
	CASE 'restar_musaat'
		if data = 'N' then this.setitem(1,'musaat',0)
	CASE 'restar_dv'
		if data = 'N' then this.setitem(1,'dv',0)
	CASE 'aplica_honos'
		if data = 'N' then this.setitem(1,'honorarios',0)
	CASE 'honorarios_nueva'
		this.setitem(1, 'honorarios', double(data) - this.getitemnumber(1, 'honorarios_pagada'))
		
	case 'cip'
		// Si se modifica se debe recalcular el porcentaje
		// Actualizamos porcentajes de diferencia
		double cip_dif 
		cip_dif = double(data)
		this.setitem(1, 'cip_porc_d', (cip_dif / this.getitemnumber(1, 'cip')))
		
	case 'cip_porc_d'	
		
		this.setitem(1, 'cip', (this.getitemnumber(1, 'cip')*double(data)) /100)
		
	case 'musaat'
		
		this.setitem(1, 'musaat_porc_d', (double(data) / this.getitemnumber(1, 'musaat')) *100)
	case 'dv'	
		this.setitem(1, 'dv_porc_d', (double(data) / this.getitemnumber(1, 'dv'))*100)
END CHOOSE


end event

event itemfocuschanged;call super::itemfocuschanged;choose case dwo.name
	case 'cip', 'musaat', 'dv', 'desplaza', 'honorarios'
		this.SelectText(1, LenA(string(double(this.GetText()),"###,###,##0.00")))
	case 'porc_honorarios'
		this.SelectText(1, LenA(string(double(this.GetText()),"##0.00")))		
end choose

end event

type cb_3 from commandbutton within w_minutas_final
integer x = 1819
integer y = 1088
integer width = 402
integer height = 112
integer taborder = 180
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;// Descartamos los cambios
dw_final_obra.SetItemStatus(1, 0, Primary!, NotModified!)

closewithreturn(parent, 'CANCELAR')

end event

type dw_1 from u_dw within w_minutas_final
boolean visible = false
integer x = 2117
integer y = 28
integer width = 375
integer height = 268
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_musaat_pagado_avi_fact"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;double pagado_musaat
string id_col, id_fase

choose case dwo.name
	case 'avi_fact'
		id_col = i_id_col 
		id_fase = g_id_fase 
		if data = 'A' then
			dw_cip_musaat.setitem(1, 'musaat_pagada', f_total_cobrado_musaat_colegiado(id_fase, id_col))
		else
			dw_cip_musaat.setitem(1, 'musaat_pagada', f_total_cobrado_musaat_colegiado_fact(id_fase, id_col))
		end if
		dw_cip_musaat.setitem(1, 'musaat', dw_cip_musaat.getitemnumber(1, 'musaat_nueva') - dw_cip_musaat.getitemnumber(1, 'musaat_pagada'))
end choose
		
end event

type dw_opciones from u_dw within w_minutas_final
integer x = 142
integer y = 792
integer width = 1051
integer height = 460
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_minutas_final_opciones"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_final_obra from u_dw within w_minutas_final
event csd_retrieve ( )
boolean visible = false
integer x = 27
integer y = 48
integer width = 2395
integer height = 804
integer taborder = 20
string dataobject = "d_minutas_final_obra"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long pfc_insertrow();call super::pfc_insertrow;double sup_viv, sup_gar, sup_otr, num_viv, num_edi, pem

//Rellenamos los campos que queremos poner por defecto
this.Setitem(1,'id_fases_final',f_siguiente_numero('FINALES_OBRA',10))
this.SetItem(1,'fecha',today())
this.SetItem(1,'f_intro',today())

//sup_viv 	= idw_estadistica.getitemnumber(1, 'sup_viv')
//sup_gar 	= idw_estadistica.getitemnumber(1, 'sup_garage')
//sup_otr 	= idw_estadistica.getitemnumber(1, 'sup_otros')
//num_viv 	= idw_estadistica.getitemnumber(1, 'num_viv')
//num_edi 	= idw_estadistica.getitemnumber(1, 'num_edif')
//pem 		= idw_estadistica.getitemnumber(1, 'pem')
//
//if isnull(sup_viv) then sup_viv = 0
//if isnull(sup_gar) then sup_gar = 0
//if isnull(sup_otr) then sup_otr = 0
//if isnull(num_viv) then num_viv = 0
//if isnull(num_edi) then num_edi = 0
//if isnull(pem) then pem = 0

//// Obtenemos las superficies y el pem
//this.setitem(1,'sup_viv', sup_viv)
//this.setitem(1,'sup_garage', sup_gar)
//this.setitem(1,'sup_otros', sup_otr)
//this.setitem(1,'num_viv', num_viv)
//this.setitem(1,'num_edif', num_edi)
//this.setitem(1,'presupuesto', pem)

// Tenemos que grabar la fase y la minuta
this.setitem(1,'id_fase', g_id_fase)
this.setitem(1,'id_minuta', i_id_minuta)

return 1

end event

type cb_1 from commandbutton within w_minutas_final
boolean visible = false
integer x = 1303
integer y = 1088
integer width = 402
integer height = 112
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Regularizar"
end type

event clicked;// Acciones a realizar
if dw_opciones.getitemstring(1, 'estadistica') = 'S' then wf_actualizar_estadistica()
if dw_opciones.getitemstring(1, 'honosmin') = 'S' then wf_actualizar_hon_min()
if dw_opciones.getitemstring(1, 'descuentos') = 'S' then wf_actualizar_descuentos()
if dw_opciones.getitemstring(1, 'minuta') = 'S' then wf_actualizar_minuta()
if dw_opciones.getitemstring(1, 'finalobra') = 'S' then wf_insertar_final()
g_recien_grabado_modificacion_fases = TRUE
close(parent)
post messagebox(g_titulo, "Proceso Finalizado")

end event

type cb_siguiente from commandbutton within w_minutas_final
integer x = 1303
integer y = 1088
integer width = 402
integer height = 112
integer taborder = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Siguiente"
end type

event clicked;string sn_cip, sn_musaat, sn_dv, sn_honos
double musaat = 0, cip = 0, dv = 0, honorarios = 0, pem_nueva, sup_nueva

// Validaciones
dw_pem_superficie.accepttext()
dw_cip_musaat.accepttext()

// Ver si se han introducido datos
pem_nueva = dw_pem_superficie.getitemnumber(1, 'pem2')
sup_nueva = dw_pem_superficie.getitemnumber(1, 'sup2')
if f_es_vacio(string(pem_nueva)) or f_es_vacio(string(sup_nueva)) then
	messagebox(g_titulo, 'Debe introducir los nuevos valores para el PEM y la Superficie')
	return
end if

//// Si los valores son 0 o no hay ning$$HEX1$$fa00$$ENDHEX$$n check marcado no se hace nada
//sn_honos 	= dw_cip_musaat.getitemstring(1, 'aplica_honos')
//sn_cip 		= dw_cip_musaat.getitemstring(1, 'restar_cip')
//sn_musaat 	= dw_cip_musaat.getitemstring(1, 'restar_musaat')
//sn_dv 		= dw_cip_musaat.getitemstring(1, 'restar_dv')
//
//honorarios 	= dw_cip_musaat.getitemnumber(1, 'honorarios')
//musaat 		= dw_cip_musaat.getitemnumber(1, 'musaat')
//cip 			= dw_cip_musaat.getitemnumber(1, 'cip')
//dv 			= dw_cip_musaat.getitemnumber(1, 'dv')
//
//// Si no est$$HEX1$$e100$$ENDHEX$$n los checks marcados o los valores son 0
//if sn_honos	= 'N'	then honorarios = 0
//if sn_cip = 'N' then cip = 0
//if sn_musaat = 'N' then musaat = 0
//if sn_dv = 'N'	then dv = 0
//
//if isnull(musaat) then musaat = 0
//if isnull(cip) then cip = 0
//if isnull(dv) then dv = 0
//if isnull(honorarios) then honorarios = 0
//
//if (honorarios = 0 and cip = 0 and musaat = 0 and dv = 0 and honorarios = 0) then return
//// Fin Validaciones

boolean bl_nuevo_final_obra = false
// Si se va a introducir final obra...
if dw_opciones.getitemstring(1, 'finalobra') = 'S' then
	// Si ya hay un final para esta minuta recuperamos los datos, si no introducimos uno
	dw_final_obra.retrieve(i_id_minuta)
	if dw_final_obra.rowcount() = 0 then 
		bl_nuevo_final_obra = true
		dw_final_obra.event pfc_insertrow()
	end if
	dw_final_obra.visible = true
	dw_opciones.visible = false
	cb_1.visible = true
	this.visible = false
	// Paco 26/08/2005 rellenamos los datos del final de obra por defecto.
	if bl_nuevo_final_obra then
		dw_final_obra.setitem(1,'presupuesto',dw_pem_superficie.getitemnumber(1, 'pem2'))
		dw_final_obra.setitem(1,'sup_viv',i_w.idw_fases_estadistica.getitemnumber(1, 'sup_viv'))
		dw_final_obra.setitem(1,'sup_garage',i_w.idw_fases_estadistica.getitemnumber(1, 'sup_garage'))
		dw_final_obra.setitem(1,'sup_otros',i_w.idw_fases_estadistica.getitemnumber(1, 'sup_otros'))
		dw_final_obra.setitem(1,'num_viv',i_w.idw_fases_estadistica.getitemnumber(1, 'num_viv'))
		dw_final_obra.setitem(1,'num_edif',i_w.idw_fases_estadistica.getitemnumber(1, 'num_edif'))
	end if
else
	cb_1.triggerevent(clicked!)	
end if

end event

