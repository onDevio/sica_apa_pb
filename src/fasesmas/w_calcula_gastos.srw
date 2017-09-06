HA$PBExportHeader$w_calcula_gastos.srw
forward
global type w_calcula_gastos from w_response
end type
type dw_colegiados from u_dw within w_calcula_gastos
end type
type cb_2 from commandbutton within w_calcula_gastos
end type
type dw_descuentos from u_dw within w_calcula_gastos
end type
type cb_1 from commandbutton within w_calcula_gastos
end type
type gb_1 from groupbox within w_calcula_gastos
end type
type cb_impr from commandbutton within w_calcula_gastos
end type
type dw_imprimir_ficha from u_dw within w_calcula_gastos
end type
type dw_honos from u_dw within w_calcula_gastos
end type
type tab_1 from tab within w_calcula_gastos
end type
type tabpage_1 from userobject within tab_1
end type
type dw_parametros from u_dw within tabpage_1
end type
type dw_1 from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_parametros dw_parametros
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tab_1 from tab within w_calcula_gastos
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_asociados from u_dw within w_calcula_gastos
end type
type dw_resumen from u_dw within w_calcula_gastos
end type
type gb_2 from groupbox within w_calcula_gastos
end type
type gb_4 from groupbox within w_calcula_gastos
end type
type gb_3 from groupbox within w_calcula_gastos
end type
end forward

global type w_calcula_gastos from w_response
integer x = 214
integer y = 221
integer width = 2971
integer height = 2596
string title = "Simulador de Gastos"
dw_colegiados dw_colegiados
cb_2 cb_2
dw_descuentos dw_descuentos
cb_1 cb_1
gb_1 gb_1
cb_impr cb_impr
dw_imprimir_ficha dw_imprimir_ficha
dw_honos dw_honos
tab_1 tab_1
dw_asociados dw_asociados
dw_resumen dw_resumen
gb_2 gb_2
gb_4 gb_4
gb_3 gb_3
end type
global w_calcula_gastos w_calcula_gastos

type variables
DataWindowChild i_dwc_colegiados_asociados
datawindow dw_1, dw_parametros, dw_hon_min
end variables

on w_calcula_gastos.create
int iCurrent
call super::create
this.dw_colegiados=create dw_colegiados
this.cb_2=create cb_2
this.dw_descuentos=create dw_descuentos
this.cb_1=create cb_1
this.gb_1=create gb_1
this.cb_impr=create cb_impr
this.dw_imprimir_ficha=create dw_imprimir_ficha
this.dw_honos=create dw_honos
this.tab_1=create tab_1
this.dw_asociados=create dw_asociados
this.dw_resumen=create dw_resumen
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_colegiados
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_descuentos
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.cb_impr
this.Control[iCurrent+7]=this.dw_imprimir_ficha
this.Control[iCurrent+8]=this.dw_honos
this.Control[iCurrent+9]=this.tab_1
this.Control[iCurrent+10]=this.dw_asociados
this.Control[iCurrent+11]=this.dw_resumen
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_4
this.Control[iCurrent+14]=this.gb_3
end on

on w_calcula_gastos.destroy
call super::destroy
destroy(this.dw_colegiados)
destroy(this.cb_2)
destroy(this.dw_descuentos)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.cb_impr)
destroy(this.dw_imprimir_ficha)
destroy(this.dw_honos)
destroy(this.tab_1)
destroy(this.dw_asociados)
destroy(this.dw_resumen)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_3)
end on

event open;call super::open;f_centrar_ventana(this)

string  tramite_defecto

dw_1 = tab_1.tabpage_1.dw_1
dw_parametros = tab_1.tabpage_1.dw_parametros
dw_hon_min = tab_1.tabpage_2.dw_2
dw_1.dynamic event pfc_addrow()
dw_1.setitem(1, 'f_entrada', date(datetime(today())))
dw_1.setitem(1, 'f_calculo_musaat', date(datetime(today())))
dw_colegiados.event pfc_addrow()
dw_colegiados.setitem(1,'porcen_a', 100)
dw_resumen.event pfc_addrow()
dw_honos.insertrow(0)
tab_1.tabpage_1.text = 'Datos'


dw_descuentos.object.t_cliente.visible=false
dw_descuentos.object.t_6.visible=false
dw_descuentos.object.t_7.visible=false
dw_descuentos.object.t_10.visible=false
dw_descuentos.object.cuantia_cliente.visible=false
dw_descuentos.object.impuesto_cliente.visible=false
dw_descuentos.object.compute_1.visible=false
dw_descuentos.object.participa_cliente.visible=false
dw_descuentos.object.participa_colegiado.visible=false

///*** SCP.1385. Se ocultan campos para evistar scrolling. Alexis Maeso. 16/09/2011. ***///
dw_descuentos.object.t_9.visible = false
dw_descuentos.object.facturado.visible = false
///*** FIN SCP.1385. ***///

select texto into :tramite_defecto from var_globales where nombre='g_tramite_defecto';
dw_1.setitem(1,'id_tramite',tramite_defecto)
dw_1.setitem(1,'cod_colegio_dest',g_colegio)

CHOOSE CASE g_colegio
	
	CASE 'COAATGUI','COAATLL'
		// INC. 6579
		dw_honos.visible = false
		gb_3.visible = false
	CASE 'COAATLR'
		dw_parametros.dataobject = 'd_fases_usos_apas_lr'
		dw_parametros.settransobject(sqlca)
	CASE 'COAATGC'
		dw_parametros.dataobject = 'd_fases_usos_apas_gc'
		dw_parametros.settransobject(sqlca)
	CASE 'COAATBU'
		dw_parametros.dataobject = 'd_fases_usos_apas_bu'
		dw_parametros.settransobject(sqlca)
	CASE 'COAATA'
		tab_1.tabpage_1.text = 'Datos DIP/Musaat'
		dw_honos.visible = false
		gb_3.visible = false
		dw_imprimir_ficha.dataobject = 'd_fases_calculo_gastos_imprimir_al'
		dw_imprimir_ficha.settransobject(sqlca)
		dw_parametros.dataobject = 'd_fases_usos_apas_al'
		dw_parametros.settransobject(sqlca)
	CASE 'COAATZ', 'COAATCU', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATCC', 'COAATTER'
		tab_1.tabpage_2.visible = true
		gb_3.visible = false
		dw_honos.visible = false
		tab_1.tabpage_1.text = 'Datos Musaat'

		CHOOSE CASE g_colegio
			CASE 'COAATZ', 'COAATCU', 'COAATAVI', 'COAATTER'
				dw_hon_min.dataobject = 'd_calcula_gastos_honos_teor_za'
				dw_hon_min.settransobject(sqlca)
				dw_hon_min.dynamic event pfc_addrow()
				dw_imprimir_ficha.dataobject = 'd_fases_calculo_gastos_imprimir_za'
				dw_imprimir_ficha.settransobject(sqlca)
			CASE 'COAATGU'
				dw_parametros.dataobject = 'd_fases_usos_apas_gu'
				dw_parametros.settransobject(sqlca)
				dw_hon_min.dataobject = 'd_calcula_gastos_honos_teor_gu'
				dw_hon_min.settransobject(sqlca)
				dw_hon_min.dynamic event pfc_addrow()
				dw_imprimir_ficha.dataobject = 'd_fases_calculo_gastos_imprimir_gu'
				dw_imprimir_ficha.settransobject(sqlca)
			CASE 'COAATLE'
				tab_1.tabpage_1.text = 'Datos Musaat/DIP'
				tab_1.tabpage_2.text = 'Datos Honos Orientat.'
				dw_hon_min.dataobject = 'd_calcula_gastos_honos_teor_le'
				dw_hon_min.settransobject(sqlca)
				dw_hon_min.dynamic event pfc_addrow()
				dw_imprimir_ficha.dataobject = 'd_fases_calculo_gastos_imprimir_za'
				dw_imprimir_ficha.settransobject(sqlca)
			CASE 'COAATCC'
				tab_1.tabpage_2.text = 'Datos Costes Prof.'
				dw_hon_min.dataobject = 'd_calcula_gastos_honos_teor_cc'
				dw_hon_min.settransobject(sqlca)
				dw_hon_min.dynamic event pfc_addrow()
				dw_imprimir_ficha.dataobject = 'd_fases_calculo_gastos_imprimir_cc'
				dw_imprimir_ficha.settransobject(sqlca)				
		END CHOOSE

	CASE 'COAATNA'
		dw_honos.visible = false
		gb_3.visible = false
		dw_parametros.dataobject = 'd_fases_usos_apas_na'
		dw_parametros.settransobject(sqlca)
		dw_imprimir_ficha.dataobject = 'd_fases_calculo_gastos_imprimir_na'
		dw_imprimir_ficha.settransobject(sqlca)		
END CHOOSE

dw_parametros.dynamic event pfc_addrow()

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_calcula_gastos
integer x = 2903
integer y = 1808
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_calcula_gastos
integer x = 2903
integer y = 1680
integer taborder = 0
end type

type dw_colegiados from u_dw within w_calcula_gastos
integer x = 64
integer y = 892
integer width = 2816
integer height = 228
integer taborder = 20
string dataobject = "d_calculo_gastos_colegiados"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event buttonclicked;string id_colegiado,col,alta_baja,mensaje
int i
choose case dwo.name
	case 'cb_busqueda_colegiados'
	g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
	g_busqueda.dw="d_lista_busqueda_colegiados"
	
	id_colegiado=f_busqueda_colegiados()
	if f_es_vacio(id_colegiado) then return
	this.setitem(row,'id_col',id_colegiado)
	select n_colegiado into :col from colegiados where id_colegiado = :id_colegiado;
	this.setitem(row,'n_col',col)
	if this.rowcount() > 1 then
		for i=1 to this.rowcount()
			if this.getitemstring(i,'id_col')=id_colegiado and i <> row then
				MessageBox(g_titulo,'No puede haber un colegiado duplicado.')
				return -1
	//			i=this.rowcount() + 1			
	//			this.triggerevent ("csd_borrar_cod")
	//			this.postevent ("pfc_addrow")
	//		
			end if
		next
	end if
	//this.Event Trigger validar_colegiado(id_colegiado)
	mensaje=f_control_de_incidencias('C',id_colegiado)
end choose

end event

event itemchanged;call super::itemchanged;st_control_eventos c_evento
int    i
string alta_baja,id,empresa,id_col,id_fase,mensaje,cobertura
double suma=0,total_hon,por,suma_porcentajes_col,i_porcen
boolean valido

choose case dwo.name
	case 'n_col'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_col',f_colegiado_id_col(data))
//		c_evento.id_colegiado = f_colegiado_id_col(data)
//		c_evento.evento = 'FASES_COLEGIADOS'
//		c_evento.dw = this 
//		f_control_eventos(c_evento)	
		
		// Si es asociaci$$HEX1$$f300$$ENDHEX$$n
		// Borro para que no quede basura en la bd
			
		for i = dw_asociados.rowcount() to 1 step -1
			dw_asociados.deleterow(i)
		next
		if f_colegiado_tipopersona(f_colegiado_id_col(data)) = 'S' then	
//			dw_asociados.visible = true
			datastore ds_colegiados_asociados
			ds_colegiados_asociados = create datastore						
			// Modificado David 28/02/2006 - Obtenemos el porcentaje real, quitando los posibles asociados no colegiados
			ds_colegiados_asociados.dataobject = 'ds_colegiados_personas' //'d_colegiados_personas'
			ds_colegiados_asociados.settransobject(sqlca)								
			ds_colegiados_asociados.retrieve(f_colegiado_id_col(data))
			dw_colegiados.setredraw(false)
			for i = 1 to ds_colegiados_asociados.rowcount()
				dw_asociados.event pfc_addrow()
				// Modificado David 28/02/2006 - Obtenemos el porcentaje real, quitando los posibles asociados no colegiados
				dw_asociados.setitem(i, 'porcent', ds_colegiados_asociados.getitemnumber(i, 'porc_col_real')) //'porcent'))
				dw_asociados.setitem(i, 'id_col_per', ds_colegiados_asociados.getitemstring(i, 'id_col_per'))								
			next
			dw_asociados.setredraw(true)
			dw_colegiados.setredraw(true)
			destroy ds_colegiados_asociados			
		else
			dw_asociados.visible = false
		end if
			
		SELECT musaat.src_cober INTO :cobertura FROM musaat WHERE musaat.id_col = :id_col ;
		if not isnull(cobertura) then this.setitem(row,'cobertura',cobertura)

	
	case 'porcen_a'
		i_porcen=getitemnumber(this.getrow(),'porcen_a')
		this.postevent("csd_porcentajes")
		//this.PostEvent('comprobar_porcentajes')
	//	this.PostEvent('comprueba_integridad_minutas')
		if g_suma_porcentajes_col > 100 then
			messagebox(g_titulo,'La participaci$$HEX1$$f300$$ENDHEX$$n de los colegiados es mayor de 100.')
		end if
	case else
end choose


end event

event pfc_prermbmenu;call super::pfc_prermbmenu;if this.rowcount()>0 Then
	am_dw.m_table.m_insert.enabled = False
	am_dw.m_table.m_addrow.enabled = False
End if

end event

type cb_2 from commandbutton within w_calcula_gastos
integer x = 2016
integer y = 2388
integer width = 480
integer height = 96
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
boolean cancel = true
end type

event clicked;close(parent)

end event

type dw_descuentos from u_dw within w_calcula_gastos
event csd_calcular_descuentos ( )
event csd_calcular_descuentos_pbd ( )
event csd_calcular_descuento_omnibus ( )
integer x = 64
integer y = 1192
integer width = 2816
integer height = 448
integer taborder = 30
string dataobject = "d_fases_informes"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_calcular_descuentos();Setpointer(HourGlass!)
double cip = 0, dv = 0, musaat = 0, cip_incrementar = 0, dv_incrementar = 0
st_cip_datos st_cip_datos
st_csi_articulos_servicios st_csi_articulos_servicios
st_dv_datos st_dv_datos
st_musaat_datos st_musaat_datos
double i,j, porcen
int fila_insertada
string id_col, id_asociado
int ret

// CIP
// cargo la estructura
st_cip_datos.tipo_act = dw_1.getitemstring(1, 'fase')
st_cip_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_trabajo')
st_cip_datos.superficie = dw_parametros.getitemnumber(1, 'superficie')
st_cip_datos.pem = dw_parametros.getitemnumber(1, 'pem')
st_cip_datos.t_terreno = dw_parametros.GetItemString(1,'t_terreno')
st_cip_datos.admon = dw_1.getitemstring(1, 'administracion')
st_cip_datos.volumen = dw_parametros.GetItemNumber(1,'volumen')
st_cip_datos.altura = dw_parametros.GetItemNumber(1,'altura')
st_cip_datos.colindantes = dw_parametros.GetItemString(1,'colindantes')
st_cip_datos.tipo_gestion = dw_1.GetItemString(1,'tipo_gestion')
st_cip_datos.fecha = dw_1.GetItemdatetime(1,'f_entrada')
st_cip_datos.long_per = dw_parametros.GetItemNumber(1,'longitud_per')
st_cip_datos.vol_tierras = dw_parametros.GetItemNumber(1,'volumen_tierras')
st_cip_datos.valor_terreno = dw_parametros.getitemnumber(1, 'valor_terreno')	
st_cip_datos.valor_tasacion = dw_parametros.getitemnumber(1, 'valor_tasacion')
st_cip_datos.valoracion_estim = dw_parametros.getitemnumber(1, 'valoracion_estim')
st_cip_datos.estructura = dw_parametros.GetItemString(1,'estructura')
st_cip_datos.t_medicion = dw_parametros.GetItemString(1,'t_medicion')
st_cip_datos.replan_deslin = dw_parametros.GetItemString(1,'replan_deslin')
st_cip_datos.vol_edif = dw_parametros.GetItemnumber(1,'volumen')
st_cip_datos.tipo_tramite=dw_1.GetItemString(dw_1.GetRow(),'id_tramite')

st_cip_datos.modulo = 'G'
if g_colegio = 'COAATA' then st_cip_datos.ctrl_calidad = dw_parametros.GetItemString(1,'ctrl_calidad_interno')

// MODIFICACIONES RICARDO 2004-12-30
CHOOSE CASE g_colegio
	CASE 'COAATLR', 'COAATNA','COAATA'
		st_cip_datos.visared = dw_parametros.GetItemString(1,'visared')
	CASE 'COAATBU'
		st_cip_datos.tipologia_edif = dw_parametros.GetItemString(1,'tipo_edif')
END CHOOSE
// FIN MODIFICACIONES RICARDO 2004-12-30

porcen = dw_colegiados.GetItemNumber(1,'porcen_a')
// el 100%
st_cip_datos.porcentaje = 100

// Pasamos los datos de los honos minimos a la funci$$HEX1$$f300$$ENDHEX$$n de cip
if g_colegio = 'COAATCU' or g_colegio =  'COAATZ'  or g_colegio =  'COAATAVI' or g_colegio =  'COAATCC' or g_colegio =  'COAATTER'  then
	st_cip_datos.tarifa = dw_hon_min.getitemstring(1, 'tarifa')	
	st_cip_datos.hon_teor =  dw_hon_min.getitemnumber(1, 'importe_ho')	
	//Luis ICT-151
	if(g_colegio = 'COAATTER')then
		st_cip_datos.contenido = dw_hon_min.getitemstring(1, 'epigrafe')	
	end if
	//fin cambio
end if

// En algunos colegios se calcula en la ventana de honorarios
if g_colegio = 'COAATGU' then
	st_cip_datos.cip = dw_hon_min.getitemnumber(1, 'importe_cip')	
else
	f_calcular_cip(st_cip_datos)
end if
if g_colegio = 'COAATTFE' then st_cip_datos.cip = 0
cip = st_cip_datos.cip * porcen/100
if isnull(cip) then cip = 0

// Solo para el colegio de la rioja
string ctrl_calidad_interno, fase
fase = dw_1.getitemString(1, 'fase')
if g_colegio = 'COAATLR' then ctrl_calidad_interno = dw_parametros.GetItemString(1,'ctrl_calidad_interno')
if f_es_vacio(ctrl_calidad_interno) then ctrl_calidad_interno = 'N'
CHOOSE CASE g_colegio
	CASE 'COAATLR'
		if not f_puede_llevar_control_calidad(fase) = 'S' then
			ctrl_calidad_interno = 'N'
		end if
	CASE ELSE
		ctrl_calidad_interno = 'N'
END CHOOSE
CHOOSE CASE g_colegio
	CASE 'COAATLR'
		if ctrl_calidad_interno = 'S' then
			st_cip_datos.tipo_act = g_codigo_tipo_actuacion_control_calidad
			f_calcular_cip(st_cip_datos)
			cip_incrementar = st_cip_datos.cip
			if isnull(cip_incrementar) then cip_incrementar = 0
			cip += cip_incrementar
		end if
END CHOOSE

// Inserto fila
if cip > 0 then
	//Comprobar si ya se ha calculado el CIP anteriormente
	long fila_cip
	double cip_ant
	fila_cip = this.Find("tipo_informe = '" + g_codigos_conceptos.cip + "'",0,this.RowCount())
	if fila_cip > 0 Then //ya se ha calculado la cip, preguntar si recalcular
		cip_ant = this.GetItemNumber(fila_cip,'cuantia_colegiado')
		if cip_ant = cip then 
			ret = 0
		else
			ret = Messagebox(g_titulo,'$$HEX1$$bf00$$ENDHEX$$Desea recalcular '+ f_devuelve_desc_concepto(g_codigos_conceptos.cip)+ '?',Question!,YesNo!)
		end if
		if ret = 1 Then
			fila_insertada = fila_cip
		Else
			fila_insertada = 0
		End If
	Else
		fila_insertada = this.event pfc_addrow()
	End if
	if fila_insertada > 0 then
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.cip)
		// cojo los datos del concepto
		//nach
		this.setitem(fila_insertada, 'empresa', '01')
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.cip
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		this.setitem(fila_insertada, 'cuantia_colegiado', cip )
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(cip, st_csi_articulos_servicios.t_iva ))
	end if
end if


//DV
st_dv_datos.tipoact = dw_1.getitemstring(1, 'fase')
st_dv_datos.tipoobra = dw_1.getitemstring(1, 'tipo_trabajo')
st_dv_datos.pem = dw_parametros.getitemnumber(1, 'pem')
st_dv_datos.administracion = ( dw_1.getitemstring(1, 'administracion') = 'S')
st_dv_datos.porcentaje = 100 // Todos los DV
st_dv_datos.id_expediente = dw_1.getitemstring(1, 'id_expedi')
st_dv_datos.fecha = dw_1.GetItemdatetime(1,'f_entrada')
st_dv_datos.superficie = dw_parametros.getitemnumber(1, 'superficie')
// MODIFICACIONES RICARDO 2004-12-30
CHOOSE CASE g_colegio
	CASE 'COAATLR', 'COAATNA'
		st_dv_datos.visared = dw_parametros.GetItemString(1,'visared')
END CHOOSE
// FIN MODIFICACIONES RICARDO 2004-12-30

if g_colegio = 'COAATCU' or g_colegio = 'COAATZ'  or g_colegio =  'COAATAVI' or g_colegio =  'COAATTER'  then 
	st_dv_datos.hon_teor =  dw_hon_min.getitemnumber(1, 'importe_ho')
end if

if g_colegio = 'COAATGU' then
	st_dv_datos.tarifa = dw_hon_min.getitemstring(1, 'tarifa')
	st_dv_datos.contenido = dw_hon_min.getitemstring(1, 'epigrafe')
	st_dv_datos.pres_seguridad = dw_parametros.getitemnumber(1, 'pres_seguridad')
end if

f_calcular_dv(st_dv_datos)
dv = st_dv_datos.dv * porcen/100
if isnull(dv) then dv = 0

// Solo para el colegio de la rioja
CHOOSE CASE g_colegio
	CASE 'COAATLR'
		if ctrl_calidad_interno = 'S' then
			st_dv_datos.tipoact = g_codigo_tipo_actuacion_control_calidad
			f_calcular_dv(st_dv_datos)
			dv_incrementar = st_dv_datos.dv
			if isnull(dv_incrementar) then dv_incrementar = 0
			dv += dv_incrementar
		end if
END CHOOSE

if dv > 0 then
	//Comprobar si ya se ha calculado los DV anteriormente
	long fila_dv
	double dv_ant
	fila_dv = this.Find("tipo_informe = '" + g_codigos_conceptos.dv + "'",0,this.RowCount())
	if fila_dv > 0 Then //ya se ha calculado el cip, preguntar si recalcular
		dv_ant = this.GetItemNumber(fila_dv,'cuantia_colegiado')
		if dv = dv_ant then
			ret = 0
		else
			ret = Messagebox(g_titulo,'$$HEX1$$bf00$$ENDHEX$$Desea recalcular '+ f_devuelve_desc_concepto(g_codigos_conceptos.dv)+ '?',Question!,YesNo!)
		end if
		if ret = 1 Then
			fila_insertada = fila_dv
		Else
			fila_insertada = 0
		End If
	Else
		fila_insertada = this.event pfc_addrow()
	End if

	if fila_insertada > 0 then
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.dv)
		this.setitem(fila_insertada, 'empresa', '01')
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.dv
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		this.setitem(fila_insertada, 'cuantia_colegiado', dv )
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(dv, st_csi_articulos_servicios.t_iva ))
	end if
end if


// MUSAAT
double porc_col = 0, porc_col_real = 0, suma_porc = 0
// Suma de la Musaat de todos los colegiado
// Si es una asociaci$$HEX1$$f300$$ENDHEX$$n, de todos los asociados
st_musaat_datos.n_visado = dw_1.getitemstring(1, 'id_fase')
st_musaat_datos.tipo_act = dw_1.getitemstring(1, 'fase')
st_musaat_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_trabajo')
st_musaat_datos.f_calculo = dw_1.getitemdatetime(1, 'f_calculo_musaat')
st_musaat_datos.pem = dw_parametros.getitemnumber(1, 'pem')
st_musaat_datos.administracion = dw_1.getitemstring(1, 'administracion')
st_musaat_datos.superficie = dw_parametros.getitemnumber(1, 'superficie')
st_musaat_datos.volumen = dw_parametros.getitemnumber(1, 'volumen')
st_musaat_datos.colindantes2m = dw_parametros.getitemstring(1, 'colindantes2m')
st_musaat_datos.cod_colegio = dw_1.getitemstring(1, 'cod_colegio_dest')

if dw_parametros.getitemnumber(1, 'volumen') =  0 then st_musaat_datos.volumen = dw_parametros.getitemnumber(1, 'volumen_tierras')
st_musaat_datos.recuperar = false
// Suma de los % de los colegiados
for j = 1 to dw_colegiados.rowcount()
	suma_porc +=  dw_colegiados.getitemnumber(j, 'porcen_a')	
next
for i = 1 to dw_colegiados.rowcount()
	porc_col =  dw_colegiados.getitemnumber(i, 'porcen_a')	

	st_musaat_datos.porcentaje = porc_col
	id_col = dw_colegiados.getitemstring(i, 'id_col')
	st_musaat_datos.funcionario = dw_colegiados.getitemString(i, 'facturado')
	st_musaat_datos.id_col = id_col
	if f_colegiado_tipopersona(id_col) = 'S' then	
		f_musaat_calcula_prima_sociedad(st_musaat_datos)
		musaat += st_musaat_datos.prima_comp	
	else
		f_musaat_calcula_prima(st_musaat_datos)	
		musaat += st_musaat_datos.prima_comp		
	end if
next
if g_colegio = 'COAATA' then
	if dw_parametros.GetItemString(1,'ctrl_calidad_interno')='S' then musaat = 0
end if
if isnull(musaat) then musaat = 0
if musaat > 0 then
	//Comprobar si ya se ha calculado los DV anteriormente
	long fila_musaat
	double musaat_ant
	fila_musaat = this.Find("tipo_informe = '" + g_codigos_conceptos.musaat_variable + "'",0,this.RowCount())
	if fila_musaat > 0 Then //ya se ha calculado MUSAAT, preguntar si recalcular en el caso de que haya cambiado
		musaat_ant = this.GetItemNumber(fila_musaat,'cuantia_colegiado')
		if musaat = musaat_ant Then
			ret = 0
		else
			ret = Messagebox(g_titulo,'$$HEX1$$bf00$$ENDHEX$$Desea recalcular '+ f_devuelve_desc_concepto(g_codigos_conceptos.musaat_variable)+ '?',Question!,YesNo!)
		end if
		if ret = 1 Then
			fila_insertada = fila_musaat
		Else
			fila_insertada = 0
		End If
	Else
		fila_insertada = this.event pfc_addrow()
	End if

	if fila_insertada > 0 then
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.musaat_variable)
			this.setitem(fila_insertada, 'empresa', g_cod_empresa_aseguradora)
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.musaat_variable
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		this.setitem(fila_insertada, 'cuantia_colegiado', musaat )
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(musaat, st_csi_articulos_servicios.t_iva ))
	end if
end if

// LIBROS DE $$HEX1$$d300$$ENDHEX$$RDENES E INCIDENCIAS
if g_colegio = 'COAATGU' then	// SOLO PARA EL COLEGIO DE GUADALAJARA
	string libro = '', contenido = ''
	if left(dw_hon_min.getitemstring(1, 'tarifa'),1) = 'A' and dw_hon_min.getitemstring(1, 'epigrafe') <> 'R' then libro = g_codigos_conceptos.libro_ordenes
	contenido = dw_hon_min.getitemstring(1, 'epigrafe')
	if contenido = '442' or contenido = '443' or contenido = '444' then libro = g_codigos_conceptos.libro_incidencias
	
	// Insertamos la linea si corresponde
	if libro <> '' then
		long fila_libros
		fila_insertada = 0
		fila_libros = this.Find("tipo_informe = '" + libro + "'",1,this.RowCount())
		if fila_libros = 0 Then
			fila_insertada = this.event pfc_addrow()
			this.setitem(fila_insertada, 'tipo_informe', libro)
			st_csi_articulos_servicios.codigo = libro
			if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
				st_csi_articulos_servicios.t_iva = g_t_iva_defecto
			end if
			this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva)
			this.setitem(fila_insertada, 'cuantia_colegiado', st_csi_articulos_servicios.importe)
			this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(st_csi_articulos_servicios.importe, st_csi_articulos_servicios.t_iva))
		end if
	end if
end if

// DESCUENTO DE VISARED
if g_colegio = 'COAATA' then	// SOLO PARA EL COLEGIO DE ALICANTE
		
		// Insertamos la linea si corresponde
		if cip > 0 and dw_parametros.GetItemString(1,'visared')<>'V' then
			long fila_descuento
			fila_insertada = 0
			fila_descuento = this.Find("tipo_informe = '" + g_codigos_conceptos.dto_visared + "'",1,this.RowCount())
			
			st_csi_articulos_servicios.codigo = g_codigos_conceptos.dto_visared
			
			if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
				st_csi_articulos_servicios.t_iva = g_t_iva_defecto
			end if
			st_csi_articulos_servicios.importe = cip*0.25
			if fila_descuento > 0 Then
				this.setitem(fila_descuento, 't_iva', st_csi_articulos_servicios.t_iva)
				this.setitem(fila_descuento, 'cuantia_colegiado', st_csi_articulos_servicios.importe)
				this.setitem(fila_descuento, 'impuesto_colegiado', f_aplica_t_iva(st_csi_articulos_servicios.importe, st_csi_articulos_servicios.t_iva))
				this.setitem(fila_insertada, 'participa_colegiado', 'S')				
				this.setitem(fila_insertada, 'participa_cliente', 'N')				
				this.setitem(fila_insertada, 'cuantia_cliente',0)
				this.setitem(fila_insertada, 'impuesto_cliente', 0)

			
			else
				this.setredraw(false)
				fila_insertada = this.event pfc_addrow()
				this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.dto_visared)
				this.setitem(fila_insertada, 'empresa', '01')
				this.setredraw(true)
				this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva)
				this.setitem(fila_insertada, 'cuantia_colegiado', st_csi_articulos_servicios.importe)
				this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(st_csi_articulos_servicios.importe, st_csi_articulos_servicios.t_iva))
				this.setitem(fila_insertada, 'participa_colegiado', 'S')
				this.setitem(fila_insertada, 'participa_cliente', 'N')			
				this.setitem(fila_insertada, 'cuantia_cliente',0)
				this.setitem(fila_insertada, 'impuesto_cliente', 0)
				
			end if
		end if

end if



// Mostramos la formula y el desarrollo aplicados en el calculo de musaat
if st_musaat_datos.formula <> '' then st_musaat_datos.formula = 'MUSAAT = ' + st_musaat_datos.formula
if st_musaat_datos.desarrollo <> '' then st_musaat_datos.desarrollo = 'MUSAAT = ' + st_musaat_datos.desarrollo
dw_resumen.setitem(1, 'formula', st_musaat_datos.formula + cr +  st_cip_datos.formula + cr +  st_dv_datos.formula)
dw_resumen.setitem(1, 'desarrollo', st_musaat_datos.desarrollo + cr +  st_cip_datos.desarrollo + cr + +  st_dv_datos.desarrollo)

end event

event csd_calcular_descuentos_pbd();Setpointer(HourGlass!)
double cip = 0, dv = 0, musaat = 0, cip_incrementar = 0, dv_incrementar = 0
st_csi_articulos_servicios st_csi_articulos_servicios
st_dv_datos st_dv_datos
st_musaat_datos st_musaat_datos
double i,j, porcen
int fila_insertada
string id_col, id_asociado
int ret,res

string formula_desarrollo_mussat="",formula_mussat=""
string formula_desarrollo_cip="",formula_cip=""
string formula_desarrollo_dv="",formula_dv=""

n_calculo_gastos_gen uo_calculo_gastos
uo_calculo_gastos=create n_calculo_gastos_gen

string obra_oficial
double sup_garaje,sup_otros,sup_viv

res=uo_calculo_gastos.of_conectar_transaccion(sqlca.DBMS,sqlca.database,sqlca.LogID,sqlca.LogPass,sqlca.servername,sqlca.userid,sqlca.dbpass,sqlca.lock,sqlca.dbparm,'TRUE')

if res<0 then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al conectar a la base de datos")
end if


//**************
// CIP
//**************
// cargo la estructura
//uo_calculo_gastos.of_set_double('coef_colegio_musaat',double(gnv_parametros.of_getparametro("g_coef_colegio_musaat",gst_csdlogon.colegio)))
//uo_calculo_gastos.of_set_double('porc_cip_admon',double(gnv_parametros.of_getparametro("g_porc_cip_admon",gst_csdlogon.colegio)))
//uo_calculo_gastos.of_set_double('porc_cip_defecto',double(gnv_parametros.of_getparametro("g_porc_cip_defecto",gst_csdlogon.colegio)))
//uo_calculo_gastos.of_set_double('porc_cip_sgc',double(gnv_parametros.of_getparametro("g_porc_cip_sgc",gst_csdlogon.colegio)))
//uo_calculo_gastos.of_set_double('dto_visared_cip',double(gnv_parametros.of_getparametro("dto_visared_cip",gst_csdlogon.colegio)))
//uo_calculo_gastos.of_set_double('dto_visared_dv',double(gnv_parametros.of_getparametro("dto_visared_dv",gst_csdlogon.colegio)))
//uo_calculo_gastos.of_set_double('porc_dv_defecto',double(gnv_parametros.of_getparametro("g_porc_dv_defecto",gst_csdlogon.colegio)))
//uo_calculo_gastos.of_set_double('g_fa',double(gnv_parametros.of_getparametro("g_fa",gst_csdlogon.colegio)))
//uo_calculo_gastos.of_set_double('g_ca',double(gnv_parametros.of_getparametro("g_ca",gst_csdlogon.colegio)))
//uo_calculo_gastos.of_set_double('g_cc',double(gnv_parametros.of_getparametro("g_cc",gst_csdlogon.colegio)))
//uo_calculo_gastos.of_set_double('g_cip_coef_g',double(gnv_parametros.of_getparametro("g_cip_coef_g",gst_csdlogon.colegio)))
	uo_calculo_gastos.of_set_string('colegio',g_colegio)	
	

		obra_oficial=dw_1.getitemstring(1, 'administracion')
		uo_calculo_gastos.of_set_string('tipo_gestion',dw_1.GetItemString(1,'tipo_gestion'))
		uo_calculo_gastos.of_set_fecha('f_entrada',dw_1.GetItemdatetime(1,'f_entrada'))

		uo_calculo_gastos.of_set_string('admon',obra_oficial)	
		uo_calculo_gastos.of_set_string('tipo_act', dw_1.getitemstring(1, 'fase'))		
		uo_calculo_gastos.of_set_string('tipo_obra',dw_1.getitemstring(1, 'tipo_trabajo'))
		uo_calculo_gastos.of_set_string('destino',dw_1.getitemstring(1, 'trabajo'))
		uo_calculo_gastos.of_set_double('volumen', dw_parametros.GetItemnumber(1,'volumen'))
		uo_calculo_gastos.of_set_double('vol_edif', dw_parametros.GetItemnumber(1,'volumen'))		
		uo_calculo_gastos.of_set_double('altura',dw_parametros.GetItemnumber(1,'altura'))						
		uo_calculo_gastos.of_set_double('superficie',dw_parametros.getitemnumber(1, 'superficie'))				
		uo_calculo_gastos.of_set_double('pem',dw_parametros.getitemnumber(1, 'pem'))
						
		/*
		uo_calculo_gastos.of_set_string('colindantes',dw_cabecera.GetItemString(1,'colindantes'))
		uo_calculo_gastos.of_set_string('t_terreno',dw_cabecera.GetItemString(1,'tipo_terreno'))
		uo_calculo_gastos.of_set_double('vol_tierras',dw_cabecera.GetItemNumber(1,'volumen_edificacion'))		
		uo_calculo_gastos.of_set_double('long_per',dw_cabecera.GetItemNumber(1,'longitud_perimetro'))
		uo_calculo_gastos.of_set_double('valor_terreno',dw_cabecera.getitemnumber(1, 'valor_terreno'))
		uo_calculo_gastos.of_set_double('valor_tasacion',dw_cabecera.getitemnumber(1, 'valor_tasacion'))
		uo_calculo_gastos.of_set_double('valor_estim',dw_cabecera.getitemnumber(1, 'valoracion_estimativa'))
		uo_calculo_gastos.of_set_string('estructura',dw_cabecera.GetItemString(1,'afecta_estructura'))
		uo_calculo_gastos.of_set_string('t_medicion',dw_cabecera.GetItemString(1,'tipo_medicion'))
		uo_calculo_gastos.of_set_string('replanteo',dw_cabecera.GetItemString(1,'replanteo'))
		uo_calculo_gastos.of_set_string('tipologia',dw_cabecera.GetItemString(1,'tipologia_edif'))
		if dw_fases_hon.rowcount()>0 then
			uo_calculo_gastos.of_set_string('tarifa',dw_fases_hon.GetItemString(1,'tarifa'))
			uo_calculo_gastos.of_set_string('contenido',dw_fases_hon.GetItemString(1,'epigrafe'))
		else
			uo_calculo_gastos.of_set_string('tarifa','@')
			uo_calculo_gastos.of_set_string('contenido','@')			
		end if
	*/
		//if lower( dw_1.describe("tipo_reforma.name")) = 'tipo_reforma'  then uo_calculo_gastos.tipo_reforma =dw_1.getitemString(1, 'tipo_reforma')
		if lower(dw_parametros.describe("num_viv.name")) = 'num_viv'  then 	uo_calculo_gastos.of_set_double('num_viv',dw_parametros.getitemnumber(1, 'num_viv'))	
		if lower(dw_parametros.describe("destino_int.name")) = 'otros_destinos'  then 	uo_calculo_gastos.of_set_string('destino_int',dw_parametros.getitemString(1, 'destino_int'))
		//if lower( dw_cabecera.describe("hon_teor.name")) = 'hon_teor'  then 	uo_calculo_gastos.of_set_double('honorarios',dw_cabecera.GetItemNumber(1,'hon_teor'))
		if lower( dw_parametros.describe("visared.name")) = 'visared'  then 	uo_calculo_gastos.of_set_string('visared',dw_parametros.GetItemString(1,'visared'))
		if lower( dw_parametros.describe("cc_externo.name")) = 'cc_externo'  then 	uo_calculo_gastos.of_set_string('cc_externo',dw_parametros.GetItemString(1,'cc_externo'))
		if lower( dw_parametros.describe("funcionario.name")) = 'funcionario' then uo_calculo_gastos.of_set_string('cc_externo',dw_parametros.getitemString(1, 'funcionario'))


	if f_es_vacio(dw_1.getitemstring(1, 'fase')) then return

	
	
	
	porcen = dw_colegiados.GetItemNumber(1,'porcen_a')
	//st_cip_datos.modulo = 'G'
	
	uo_calculo_gastos.of_set_double('porcentaje',porcen)
	uo_calculo_gastos.of_calcular_dip()
	uo_calculo_gastos.of_calcular_dv()

	
	cip = uo_calculo_gastos.of_get_double('dip')
	dv = uo_calculo_gastos.of_get_double('dv')
	// Ya aplica el porcentaje en la funci$$HEX1$$f300$$ENDHEX$$n de c$$HEX1$$e100$$ENDHEX$$lculo tanto en TGN como en TEB
	
	if uo_calculo_gastos.of_get_string('porc_col_aplicado_dip')<>'S' then
		cip = cip * porcen/100
	end if
	
	if isnull(cip) then cip = 0
	if isnull(dv) then dv = 0
	// Solo para el colegio de la rioja
	string ctrl_calidad_interno

		
	ctrl_calidad_interno = 'N'
	
	fila_insertada = this.event pfc_addrow()
	if fila_insertada > 0 then
		
	//	this.setitem(fila_insertada, 'tipo_actuacion', dw_1.getitemstring(1, 'fase'))
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.cip)
		// cojo los datos del concepto
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.cip
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		this.setitem(fila_insertada, 'cuantia_colegiado', cip )
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(cip, st_csi_articulos_servicios.t_iva ))

		formula_cip += 'DIP = ' +uo_calculo_gastos.of_get_string('dip_formula') +'~n'
		formula_desarrollo_cip += 'DIP = '+ uo_calculo_gastos.of_get_string('dip_formula_desarrollo') +'~n'	

	end if
	
	if dv>0 then
		fila_insertada = this.event pfc_addrow()
		if fila_insertada > 0 then
			
			//this.setitem(fila_insertada, 'tipo_actuacion', dw_1.getitemstring(1, 'fase'))
			this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.dv)
			// cojo los datos del concepto
			st_csi_articulos_servicios.codigo = g_codigos_conceptos.dv
			if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
				st_csi_articulos_servicios.t_iva = g_t_iva_defecto
			end if
			this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
			this.setitem(fila_insertada, 'cuantia_colegiado', dv )
			this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(dv, st_csi_articulos_servicios.t_iva ))
	
			formula_dv += 'DV ('+string(i)+') = ' +uo_calculo_gastos.of_get_string('dv_formula') +'~n'
			formula_desarrollo_dv += 'DV ('+string(i)+') = '+ uo_calculo_gastos.of_get_string('dv_formula_desarrollo') +'~n'	
	
		end if		
	end if
	

//**************
// MUSAAT
//**************


double porc_col = 0, porc_col_real = 0, suma_porc = 0
// Suma de la Musaat de todos los colegiado
// Si es una asociaci$$HEX1$$f300$$ENDHEX$$n, de todos los asociados
st_musaat_datos.n_visado = dw_1.getitemstring(1, 'id_fase')
st_musaat_datos.tipo_act = dw_1.getitemstring(1, 'fase')
st_musaat_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_trabajo')
st_musaat_datos.f_calculo = dw_1.getitemdatetime(1, 'f_calculo_musaat')
st_musaat_datos.pem = dw_parametros.getitemnumber(1, 'pem')
st_musaat_datos.administracion = dw_1.getitemstring(1, 'administracion')
st_musaat_datos.superficie = dw_parametros.getitemnumber(1, 'superficie')
st_musaat_datos.volumen = dw_parametros.getitemnumber(1, 'volumen')
st_musaat_datos.colindantes2m = dw_parametros.getitemstring(1, 'colindantes2m')


st_musaat_datos.recuperar = false

if f_es_vacio(st_musaat_datos.tipo_act) then return

// Suma de los % de los colegiados
/*for j = 1 to dw_colegiados.rowcount()
	suma_porc +=  dw_colegiados.getitemnumber(j, 'porcen_a')	
next*/
suma_porc =  dw_colegiados.getitemnumber(1, 'porcen_a')	

//for i = 1 to dw_colegiados.rowcount()
	//porc_col =  dw_colegiados.getitemnumber(i, 'porcen_a')	
	porc_col =  dw_colegiados.getitemnumber(1, 'porcen_a')	
	id_col = dw_colegiados.getitemstring(1, 'id_col')
//	if isnull(suma_porc) or suma_porc = 0 then exit
//	porc_col_real = porc_col / suma_porc * 100	
	st_musaat_datos.porcentaje = porc_col
	//id_col = dw_colegiados.getitemstring(i, 'id_col')
	st_musaat_datos.id_col = id_col
	if f_colegiado_tipopersona(id_col) = 'S' then	
		f_musaat_calcula_prima_sociedad(st_musaat_datos)
		musaat = st_musaat_datos.prima_comp	
	else
		f_musaat_calcula_prima(st_musaat_datos)	
		musaat = st_musaat_datos.prima_comp		
	end if
//next
if isnull(musaat) then musaat = 0

/*
// El control de calidad (31,32,33) no paga prima complementaria si el colegiado realiza la direcci$$HEX1$$f300$$ENDHEX$$n(11,13,14,16,17)
string fase1, fase2, fase3	
if LeftA(st_musaat_datos.tipo_act,1) = '3' then 
	fase1=dw_1.getitemstring(1, 'fase_1')
	fase2=dw_1.getitemstring(1, 'fase_2')
	fase3=dw_1.getitemstring(1, 'fase_3')
	IF fase1 = '11' or fase1='13' or fase1='14' or fase1='16' or fase1= '17' or fase2 = '11' or fase2='13' or fase2='14' or fase2='16' or fase2= '17' or &
		+ fase3 = '11' or fase3='13' or fase3='14' or fase3='16' or fase3= '17' then musaat = 0
end if
*/

if musaat > 0 then
	//Comprobar si ya se ha calculado los DV anteriormente
	long fila_musaat
	double musaat_ant
	
	fila_insertada = this.event pfc_addrow()
	if fila_insertada > 0 then
		//this.setitem(fila_insertada, 'tipo_actuacion', st_musaat_datos.tipo_act)
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.musaat_variable)
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.musaat_variable
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		this.setitem(fila_insertada, 'cuantia_colegiado', musaat )
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(musaat, st_csi_articulos_servicios.t_iva ))
		
		formula_mussat += 'MUSAAT = ' + st_musaat_datos.formula + '~n'
		formula_desarrollo_mussat += 'MUSAAT = ' + st_musaat_datos.desarrollo +'~n'
	end if
end if
dw_resumen.setitem(1, 'formula', 'MUSAAT = ' + st_musaat_datos.formula + '~n' +  'DIP = ' + uo_calculo_gastos.of_get_string('dip_formula') + '~n' )
dw_resumen.setitem(1, 'desarrollo', 'MUSAAT = ' + st_musaat_datos.desarrollo + '~n' + 'DIP = ' + uo_calculo_gastos.of_get_string('dip_formula_desarrollo') +'~n'	)		


// Mostramos la formula y el desarrollo aplicados en el calculo de musaat
dw_resumen.setitem(1, 'formula', formula_cip + formula_dv +formula_mussat + '~n'  )
dw_resumen.setitem(1, 'desarrollo', formula_desarrollo_cip  + formula_desarrollo_dv  + formula_desarrollo_mussat + '~n' )				

this.Sort()
this.GroupCalc()

end event

event csd_calcular_descuento_omnibus();Setpointer(HourGlass!)
double cip = 0, dv = 0, musaat = 0, cip_incrementar = 0, dv_incrementar = 0
st_csi_articulos_servicios st_csi_articulos_servicios
double i,j, porcen
int fila_insertada,ind
string id_col, id_asociado, ls_muestra_articulos_a_cero, visared
int ret
double sup_viv,sup_otros,sup_garaje,importe_base

string formula_actual="",desarrollo_actual
long res
string t_act,t_tramite,id_informe, tramite_defecto
double total_informe
n_csd_calculo_gastos uo_calculo_gastos

select texto into :tramite_defecto from var_globales where nombre='g_tramite_defecto';

select sn into :ls_muestra_articulos_a_cero from var_globales where nombre = 'g_muestra_articulos_a_cero';

t_tramite=dw_1.GetItemString(dw_1.GetRow(),'id_tramite')
visared = dw_1.GetItemString(dw_1.GetRow(),'e_mail')


uo_calculo_gastos=create n_csd_calculo_gastos
res=uo_calculo_gastos.of_conectar_transaccion(sqlca.DBMS,sqlca.database,sqlca.LogID,sqlca.LogPass,sqlca.servername,sqlca.userid,sqlca.dbpass,sqlca.lock,sqlca.dbparm,'TRUE')

if res<0 then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al conectar a la base de datos")
end if
	
	uo_calculo_gastos.of_set_string('tipo_obra',dw_1.GetItemString(dw_1.GetRow(),'tipo_trabajo'))		
	//uo_calculo_gastos.of_set_string('colegio', dw_1.GetItemString(dw_1.GetRow(),'cod_colegio_dest'))		
	uo_calculo_gastos.of_set_string('colegio', g_colegio)		
	uo_calculo_gastos.of_set_string('visared',visared)		
	uo_calculo_gastos.of_set_string('tipo_gestion',dw_1.GetItemString(dw_1.GetRow(),'tipo_gestion'))		
	uo_calculo_gastos.of_set_double('superficie',dw_parametros.getitemnumber(1,'superficie')	)			
	uo_calculo_gastos.of_set_double('pem',dw_parametros.getitemnumber(1, 'pem'))	
	choose case g_colegio
		case 'COAATLL', 'COAATAVI', 'COAATA'
			uo_calculo_gastos.of_set_double('otro_rango',dw_parametros.getitemnumber(1, 'volumen'))
		case else
			uo_calculo_gastos.of_set_double('otro_rango',dw_parametros.getitemnumber(1, 'num_viv'))
	end choose		

	t_act=dw_1.GetItemString(dw_1.GetRow(),'fase')
	if f_es_vacio(t_act) then return
	uo_calculo_gastos.of_set_string('tipo_act',t_act)		

	
//	DECLARE tarifas_coef cursor for SELECT id_informe
//			  FROM tarifas_informes_x_tramite WHERE tipo_tramite=:t_tramite and colegio=:g_colegio;
//	open tarifas_coef; 
//	i=0 

string ls_visared_tramites
	ls_visared_tramites = visared
	// S$$HEX1$$ed00$$ENDHEX$$: 'V' => 'S'
	IF visared = 'V' THEN 
		ls_visared_tramites = 'S'
	// Otros : 'S' => sin equivalencia, debe ser distinto a 'S', 'N'
	elseif visared = 'S' THEN 	
		ls_visared_tramites = 'O'
	end if
	
	datastore informes

	informes = create datastore
	informes.dataobject = 'd_fases_informes_x_tramite'
	informes.SetTransObject(SQLCA)
	informes.Retrieve (ls_visared_tramites, t_tramite, g_colegio)

	for i=1 to informes.RowCount()

//	do while true
//		fetch tarifas_coef into :id_informe;
//		if sqlca.sqlcode <> 0 then exit
//		uo_calculo_gastos.of_set_string('informe',id_informe)
		
//		string t 
//		t = uo_calculo_gastos.f_obtener_tarifa()
//		total_informe=uo_calculo_gastos.of_calcular_importe_total()
//		importe_base = uo_calculo_gastos.f_calcular_importe_base()

		id_informe = informes.GetItemString(i, 'id_informe');
		//if sqlca.sqlcode <> 0 then exit
		uo_calculo_gastos.of_set_string('informe',id_informe)
		total_informe=uo_calculo_gastos.of_calcular_importe_total()
		importe_base = uo_calculo_gastos.f_calcular_importe_base()
	
		if f_valida_articulo_activo(id_informe, g_empresa) = 0 then continue
			
		
		//**************
		// INSERTAR LA FILA EN GASTOS
		//**************
		if total_informe > 0 then
			//Comprobar si ya se ha calculado anteriormente
			long fila
			double valor_ant
			fila_insertada=this.insertrow(0)
			this.setitem(fila_insertada, 'tipo_informe', id_informe)
			this.setitem(fila_insertada, 'empresa', g_empresa)

			st_csi_articulos_servicios.codigo =id_informe
			if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
				st_csi_articulos_servicios.t_iva = g_t_iva_defecto
			end if
			this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
			if dw_colegiados.GetItemnumber(dw_colegiados.GetRow(),'porcen_a') <100 then
				total_informe = total_informe * (dw_colegiados.GetItemnumber(dw_colegiados.GetRow(),'porcen_a')/100)
				
				//SCP-1542 Solo aplica a tarragona
				if total_informe <  importe_base and g_colegio = 'COAATTGN' then total_informe = importe_base
					
			end if
			this.setitem(fila_insertada, 'cuantia_colegiado',total_informe  )
			this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(total_informe, st_csi_articulos_servicios.t_iva ))
		
		else // Si la tarifa no existe inserta una linea de cip con valor 0
			if (ls_muestra_articulos_a_cero = 'S') then 
				fila = this.Find("tipo_informe = '" + id_informe+ "'",0,this.RowCount())
				if fila = 0 Then
					fila_insertada = this.event pfc_addrow()
					this.setitem(fila_insertada, 'tipo_informe', id_informe)
					st_csi_articulos_servicios.codigo = id_informe
					if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
						st_csi_articulos_servicios.t_iva = g_t_iva_defecto
					end if
					this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
					this.setitem(fila_insertada, 'cuantia_colegiado', 0)
					this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(total_informe, st_csi_articulos_servicios.t_iva ))
			
				end if
			end if
		end if
		
		
		formula_actual=dw_resumen.GetItemSTring(1,'formula')
		desarrollo_actual=dw_resumen.GetItemSTring(1,'desarrollo')
		
		if IsNull(formula_actual) then 
			formula_actual=""
		else
			formula_actual+='~n'
		end if
		
		if IsNull(desarrollo_actual) then 
			desarrollo_actual=""
		else
			desarrollo_actual+='~n'
		end if
		
		formula_actual +=id_informe+'  = '+uo_calculo_gastos.of_get_string('formula')
		desarrollo_actual +=id_informe+' = '+uo_calculo_gastos.of_get_string('desarrollo')	
		
		dw_resumen.SetItem(1,'formula',formula_actual)
		dw_resumen.SetItem(1,'desarrollo',desarrollo_actual)		
	next
	//loop
	//close tarifas_coef;
	
	destroy informes
	destroy uo_calculo_gastos
//next


end event

event constructor;call super::constructor;this.object.t_4.visible = false
this.object.descripcion.visible = false
end event

event itemchanged;call super::itemchanged;integer i
double porcen
string t_iva

t_iva=this.getitemstring(row,'t_iva')
SELECT csi_t_iva.porcent INTO :porcen  FROM csi_t_iva WHERE csi_t_iva.t_iva = :t_iva ;

choose case dwo.name
	
	case 't_iva'
		SELECT csi_t_iva.porcent INTO :porcen  FROM csi_t_iva WHERE csi_t_iva.t_iva = :data ;
      this.setitem(row, 'impuesto_cliente',f_redondea(this.getitemnumber(row,'cuantia_cliente')*porcen/100))    
		this.setitem(row, 'impuesto_colegiado',f_redondea(this.getitemnumber(row,'cuantia_colegiado')*porcen/100))  

	case 'cuantia_colegiado'	
		this.setitem(row, 'impuesto_colegiado',f_redondea(double(data)*porcen/100))  
end choose
	
end event

type cb_1 from commandbutton within w_calcula_gastos
integer x = 41
integer y = 2388
integer width = 498
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Calcular &Gastos"
end type

event clicked;dw_colegiados.AcceptText()
dw_parametros.AcceptText()
dw_1.AcceptText()
Setpointer(HourGlass!)
dw_descuentos.Reset()
if g_colegio='COAATLL' then
	dw_descuentos.event csd_calcular_descuentos_pbd()	
else
	dw_descuentos.event csd_calcular_descuentos()
	dw_descuentos.event csd_calcular_descuento_omnibus()
end if
if dw_honos.visible = true then dw_honos.event csd_calcula_honos_teo()

end event

type gb_1 from groupbox within w_calcula_gastos
integer x = 37
integer width = 2875
integer height = 1144
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type cb_impr from commandbutton within w_calcula_gastos
integer x = 658
integer y = 2388
integer width = 480
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
end type

event clicked;dw_1.accepttext()
dw_parametros.accepttext()
dw_colegiados.accepttext()
dw_imprimir_ficha.reset()

string n_col, tipo_act, tipo_obra, destino_obra, id_col
n_col = dw_colegiados.getitemstring(1,'n_col')
id_col = dw_colegiados.getitemstring(1,'id_col')
tipo_act = dw_1.getitemstring(1,'fase')
tipo_obra = dw_1.getitemstring(1,'tipo_trabajo')

int i, fila
for i=1 to dw_descuentos.rowcount()

	fila = dw_imprimir_ficha.insertrow(0)
	
	dw_imprimir_ficha.setitem(fila,'colegiado',n_col + ' - ' + f_colegiado_nombre_apellido(id_col))
	dw_imprimir_ficha.setitem(fila,'participacion',dw_colegiados.getitemnumber(1, 'porcen_a'))
	
	dw_imprimir_ficha.setitem(fila,'tipoact',tipo_act + ' - ' + f_dame_desc_tipo_actuacion(tipo_act))
	dw_imprimir_ficha.setitem(fila,'tipoobra',tipo_obra  + ' - ' + f_dame_desc_tipo_obra(tipo_obra) )
	dw_imprimir_ficha.setitem(fila,'tipo_gestion', dw_1.getitemstring(1,'tipo_gestion'))
	dw_imprimir_ficha.setitem(fila,'administracion',dw_1.getitemstring(1,'administracion'))
	dw_imprimir_ficha.setitem(fila,'f_entrada',dw_1.getitemdatetime(1,'f_entrada'))
	dw_imprimir_ficha.setitem(fila,'f_calculo',dw_1.getitemdatetime(1,'f_calculo_musaat'))	
	
	dw_imprimir_ficha.setitem(fila,'superficie',dw_parametros.getitemnumber(1,'superficie'))
	dw_imprimir_ficha.setitem(fila,'volumen',dw_parametros.getitemnumber(1,'volumen'))
	dw_imprimir_ficha.setitem(fila,'altura',dw_parametros.getitemnumber(1,'altura'))
	dw_imprimir_ficha.setitem(fila,'colindantes',dw_parametros.getitemstring(1,'colindantes'))
	dw_imprimir_ficha.setitem(fila,'t_terreno',dw_parametros.getitemstring(1,'t_terreno'))
	dw_imprimir_ficha.setitem(fila,'presupuesto', dw_parametros.getitemnumber(1,'pem'))
	
	dw_imprimir_ficha.setitem(fila,'cobertura',f_musaat_dame_cobertura_src(id_col))
	dw_imprimir_ficha.setitem(fila,'bonusmalus',f_musaat_dame_coef_cm(id_col))
	
	dw_imprimir_ficha.setitem(fila,'tipo_desc',dw_descuentos.getitemstring(i,'tipo_informe'))
	dw_imprimir_ficha.setitem(fila,'iva',dw_descuentos.getitemstring(i,'t_iva'))
	dw_imprimir_ficha.setitem(fila,'base',dw_descuentos.getitemnumber(i,'cuantia_colegiado'))
	dw_imprimir_ficha.setitem(fila,'impuesto',dw_descuentos.getitemnumber(i,'impuesto_colegiado'))
	
	// MODIF PACO 12/1/2005 : el informe de Zaragoza tiene m$$HEX1$$e100$$ENDHEX$$s campos a rellenar (los de los honorarios)
	if g_colegio = 'COAATZ' or g_colegio = 'COAATCU' or g_colegio = 'COAATGU' or g_colegio = 'COAATLE' or g_colegio = 'COAATCC' or g_colegio =  'COAATTER'  then
		dw_imprimir_ficha.setitem(fila,'tarifa',dw_hon_min.getitemstring(1,'tarifa'))
		dw_imprimir_ficha.setitem(fila,'epigrafe',dw_hon_min.getitemstring(1,'epigrafe'))
		dw_imprimir_ficha.setitem(fila,'p1',dw_hon_min.getitemnumber(1,'p1'))
		dw_imprimir_ficha.setitem(fila,'p2',dw_hon_min.getitemnumber(1,'p2'))
		dw_imprimir_ficha.setitem(fila,'p3',dw_hon_min.getitemnumber(1,'p3'))
		dw_imprimir_ficha.setitem(fila,'p4',dw_hon_min.getitemnumber(1,'p4'))
		dw_imprimir_ficha.setitem(fila,'p5',dw_hon_min.getitemnumber(1,'p5'))
		dw_imprimir_ficha.setitem(fila,'formula_musaat',dw_resumen.getitemstring(1,'formula'))
		dw_imprimir_ficha.setitem(fila,'desarrollo_musaat',dw_resumen.getitemstring(1,'desarrollo'))		
	else
		dw_imprimir_ficha.setitem(fila,'hon_teor',dw_honos.getitemnumber(1,'honos_teor'))
	end if
	if g_colegio = 'COAATZ' or g_colegio = 'COAATLE'  or g_colegio = 'COAATCC' or g_colegio =  'COAATTER'  then
		dw_imprimir_ficha.setitem(fila,'formula_ho',dw_hon_min.getitemstring(1,'formula_ho'))
		dw_imprimir_ficha.setitem(fila,'desarrollo_ho',dw_hon_min.getitemstring(1,'desarrollo_ho'))
		dw_imprimir_ficha.setitem(fila,'importe_ho',dw_hon_min.getitemnumber(1,'importe_ho'))
		dw_imprimir_ficha.setitem(fila,'pem_min',dw_hon_min.getitemnumber(1,'pem_min'))
	end if		
	if g_colegio = 'COAATGU' then
		dw_imprimir_ficha.setitem(fila,'formula_ho',dw_hon_min.getitemstring(1,'formula_hon'))
		dw_imprimir_ficha.setitem(fila,'desarrollo_ho',dw_hon_min.getitemstring(1,'desarrollo_hon'))
		dw_imprimir_ficha.setitem(fila,'importe_ho',dw_hon_min.getitemnumber(1,'importe_hon'))
		dw_imprimir_ficha.setitem(fila,'hon_min',dw_hon_min.getitemnumber(1,'importe_hon_min'))		
		dw_imprimir_ficha.setitem(fila,'formula_cip',dw_hon_min.getitemstring(1,'formula_cip'))
		dw_imprimir_ficha.setitem(fila,'desarrollo_cip',dw_hon_min.getitemstring(1,'desarrollo_cip'))
		dw_imprimir_ficha.setitem(fila,'importe_cip',dw_hon_min.getitemnumber(1,'importe_cip'))
	end if
	if g_colegio = 'COAATNA' then
		dw_imprimir_ficha.setitem(fila,'formula',dw_resumen.getitemstring(1,'formula'))
		dw_imprimir_ficha.setitem(fila,'desarrollo',dw_resumen.getitemstring(1,'desarrollo'))
	end if
next

if dw_imprimir_ficha.rowcount()>0 then dw_imprimir_ficha.print()

end event

type dw_imprimir_ficha from u_dw within w_calcula_gastos
boolean visible = false
integer x = 2629
integer y = 2236
integer width = 302
integer height = 248
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_fases_calculo_gastos_imprimir"
boolean hscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event doubleclicked;call super::doubleclicked;this.visible = false
end event

type dw_honos from u_dw within w_calcula_gastos
event csd_calcula_honos_teo ( )
integer x = 759
integer y = 2212
integer width = 1595
integer height = 92
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_calcula_gastos_honos_teor"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_calcula_honos_teo();st_cip_datos st_cip_datos
double hon_teor = 0

// cargo la estructura
st_cip_datos.tipo_act 			= dw_1.getitemstring(1, 'fase')
st_cip_datos.tipo_obra 			= dw_1.getitemstring(1, 'tipo_trabajo')
st_cip_datos.superficie 		= dw_parametros.getitemnumber(1, 'superficie')
st_cip_datos.pem 					= dw_parametros.getitemnumber(1, 'pem')
st_cip_datos.admon 				= dw_1.getitemstring(1, 'administracion')
st_cip_datos.volumen 			= dw_parametros.GetItemNumber(1,'volumen')
st_cip_datos.altura 				= dw_parametros.GetItemNumber(1,'altura')
st_cip_datos.colindantes 		= dw_parametros.GetItemString(1,'colindantes')
st_cip_datos.tipo_gestion 		= dw_1.GetItemString(1,'tipo_gestion')
st_cip_datos.long_per 			= dw_parametros.GetItemNumber(1,'longitud_per')
st_cip_datos.vol_tierras 		= dw_parametros.GetItemNumber(1,'volumen_tierras')
st_cip_datos.valor_terreno 	= dw_parametros.getitemnumber(1, 'valor_terreno')	
st_cip_datos.valor_tasacion 	= dw_parametros.getitemnumber(1, 'valor_tasacion')
st_cip_datos.valoracion_estim = dw_parametros.getitemnumber(1, 'valoracion_estim')
st_cip_datos.estructura 		= dw_parametros.GetItemString(1,'estructura')
st_cip_datos.t_medicion 		= dw_parametros.GetItemString(1,'t_medicion')
st_cip_datos.replan_deslin 	= dw_parametros.GetItemString(1,'replan_deslin')
st_cip_datos.t_terreno 			= dw_parametros.GetItemString(1,'t_terreno')
st_cip_datos.vol_edif 			= dw_parametros.GetItemnumber(1,'volumen')

CHOOSE CASE g_colegio
	CASE 'COAATBU'
		st_cip_datos.tipologia_edif = dw_parametros.GetItemString(1,'tipo_edif')
END CHOOSE

st_cip_datos.porcentaje = 100 
f_calcular_hon_teor(st_cip_datos)
hon_teor = st_cip_datos.hon_teor
if isnull(hon_teor) then hon_teor = 0

this.setitem(1, 'honos_teor', hon_teor)

end event

type tab_1 from tab within w_calcula_gastos
event create ( )
event destroy ( )
integer x = 73
integer y = 32
integer width = 2816
integer height = 864
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
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
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2779
integer height = 748
long backcolor = 79741120
string text = "Datos Musaat"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_parametros dw_parametros
dw_1 dw_1
end type

on tabpage_1.create
this.dw_parametros=create dw_parametros
this.dw_1=create dw_1
this.Control[]={this.dw_parametros,&
this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_parametros)
destroy(this.dw_1)
end on

type dw_parametros from u_dw within tabpage_1
integer y = 384
integer width = 2779
integer height = 356
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_fases_usos_apas"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_1 from u_dw within tabpage_1
integer y = 4
integer width = 2222
integer height = 372
integer taborder = 10
string dataobject = "d_fases_calculo_gastos"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

type tabpage_2 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 2779
integer height = 748
long backcolor = 79741120
string text = "Datos DV/DIP"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from u_dw within tabpage_2
integer width = 2798
integer height = 684
integer taborder = 21
string dataobject = "d_calcula_gastos_honos_teor_za"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;st_calculo_honorarios st_hon
datastore ds_honos

				
st_hon.tarifa = dw_2.getitemstring(1, 'tarifa')
st_hon.contenido = dw_2.getitemstring(1, 'epigrafe')
st_hon.p1 = dw_2.getitemnumber(1, 'p1')
st_hon.p2 = dw_2.getitemnumber(1, 'p2')
st_hon.p3 = dw_2.getitemnumber(1, 'p3')
st_hon.p4 = dw_2.getitemnumber(1, 'p4')
st_hon.p5 = dw_2.getitemnumber(1, 'p5')

if g_colegio = 'COAATCU' or g_colegio = 'COAATZ' or g_colegio='COAATTER' or g_colegio = 'COAATLE'or g_colegio = 'COAATAVI' or g_colegio =  'COAATCC' then
	st_hon.formula = dw_2.getitemstring(1, 'formula_ho')
	st_hon.desarrollo = dw_2.getitemstring(1, 'desarrollo_ho')
	st_hon.importe = dw_2.getitemnumber(1, 'importe_ho')
else
	st_hon.formula = dw_2.getitemstring(1, 'formula_hon')
	st_hon.desarrollo = dw_2.getitemstring(1, 'desarrollo_hon')
	st_hon.importe = dw_2.getitemnumber(1, 'importe_hon')
	st_hon.formula_cip = dw_2.getitemstring(1, 'formula_cip')
	st_hon.desarrollo_cip = dw_2.getitemstring(1, 'desarrollo_cip')
	st_hon.importe_cip = dw_2.getitemnumber(1, 'importe_cip')
	st_hon.importe_hon_min = dw_2.getitemnumber(1, 'importe_hon_min')
end if

//if g_colegio = 'COAATGC' then
//	st_hon.formula_cip = dw_2.getitemstring(1, 'formula_cip')
//	st_hon.desarrollo_cip = dw_2.getitemstring(1, 'desarrollo_cip')
//	st_hon.importe_cip = dw_2.getitemnumber(1, 'importe_cip')
//end if

// Para todos, para que coja el presupuesto y superficie si ya se ha introducido				
st_hon.presupuesto = dw_parametros.getitemnumber(1, 'pem')
st_hon.superficie = dw_parametros.getitemnumber(1, 'superficie')
				
CHOOSE CASE dwo.name
	CASE 'b_calc_honos'
		CHOOSE CASE g_colegio
			CASE 'COAATCU'
				openwithparm(w_calculo_honorarios, st_hon)
				ds_honos = Message.PowerObjectParm
				if isvalid(ds_honos) then f_configura_parametros_fases_honos_cu (ds_honos.getitemstring(1,'tarifa'), this, ds_honos, 'G')
				
			CASE 'COAATZ', 'COAATTER'
				st_hon.presupuesto = dw_parametros.getitemnumber(1, 'pem')
				st_hon.superficie = dw_parametros.getitemnumber(1, 'superficie')
				st_hon.altura = dw_parametros.getitemnumber(1, 'altura')
				st_hon.volumen = dw_parametros.getitemnumber(1, 'volumen')
				string med, obr
				med = dw_parametros.getitemstring(1, 'colindantes')
				obr = dw_1.getitemstring(1, 'tipo_trabajo')
				st_hon.medianeras = f_coef_tipologia_medianeras(med, obr, st_hon.volumen)
		
				st_hon.pem_min = dw_2.getitemnumber(1, 'pem_min')
				// Par$$HEX1$$e100$$ENDHEX$$metros del pem m$$HEX1$$ed00$$ENDHEX$$nimo
				st_hon.coef_a = dw_2.getitemnumber(1, 'coef_a')
				st_hon.coef_b = dw_2.getitemnumber(1, 'coef_b')
				st_hon.coef_c = dw_2.getitemnumber(1, 'coef_c')				
				openwithparm(w_calculo_honorarios_za, st_hon)
				ds_honos = Message.PowerObjectParm
				if isvalid(ds_honos) then f_configura_parametros_fases_honos_za(ds_honos.getitemstring(1,'tarifa'), this, ds_honos, 'G')
				
			CASE 'COAATGU'
				st_hon.admon = dw_1.getitemstring(1, 'administracion')
				st_hon.fecha = dw_1.GetItemdatetime(1,'f_entrada')
				openwithparm(w_calculo_gastos_honorarios_gu, st_hon)
				ds_honos = Message.PowerObjectParm
				if isvalid(ds_honos) then f_configura_parametros_fases_honos_gu (ds_honos.getitemstring(1,'tarifa'), this, ds_honos, 'G')
				
			CASE 'COAATLE'
				st_hon.admon = dw_1.getitemstring(1, 'administracion')
				st_hon.fecha = dw_1.GetItemdatetime(1,'f_entrada')
				openwithparm(w_calculo_honorarios_le, st_hon)
				ds_honos = Message.PowerObjectParm
				if isvalid(ds_honos) then f_configura_parametros_fases_honos_le (ds_honos.getitemstring(1,'tarifa'), this, ds_honos, 'G')
				
			CASE 'COAATAVI'
				st_hon.presupuesto = dw_parametros.getitemnumber(1, 'pem')
				st_hon.superficie = dw_parametros.getitemnumber(1, 'superficie')
				st_hon.altura = dw_parametros.getitemnumber(1, 'altura')
				st_hon.volumen = dw_parametros.getitemnumber(1, 'volumen')

				med = dw_parametros.getitemstring(1, 'colindantes')
				obr = dw_1.getitemstring(1, 'tipo_trabajo')
				st_hon.medianeras = f_coef_tipologia_medianeras(med, obr, st_hon.volumen)
		
				st_hon.pem_min = dw_2.getitemnumber(1, 'pem_min')
				// Par$$HEX1$$e100$$ENDHEX$$metros del pem m$$HEX1$$ed00$$ENDHEX$$nimo
				st_hon.coef_a = dw_2.getitemnumber(1, 'coef_a')
				st_hon.coef_b = dw_2.getitemnumber(1, 'coef_b')
				st_hon.coef_c = dw_2.getitemnumber(1, 'coef_c')
				openwithparm(w_calculo_honorarios_avi, st_hon)
				ds_honos = Message.PowerObjectParm
				if isvalid(ds_honos) then f_configura_parametros_fases_honos_avi (ds_honos.getitemstring(1,'tarifa'), this, ds_honos, 'G')
				
			CASE 'COAATCC'
				st_hon.presupuesto = dw_parametros.getitemnumber(1, 'pem')
				st_hon.superficie = dw_parametros.getitemnumber(1, 'superficie')
				st_hon.altura = dw_parametros.getitemnumber(1, 'altura')
				st_hon.volumen = dw_parametros.getitemnumber(1, 'volumen')
				st_hon.ca = g_ca_info

				med = dw_parametros.getitemstring(1, 'colindantes')
				obr = dw_1.getitemstring(1, 'tipo_trabajo')
				st_hon.medianeras = f_coef_tipologia_medianeras(med, obr, st_hon.volumen)
		
				st_hon.pem_min = dw_2.getitemnumber(1, 'pem_min')
				// Par$$HEX1$$e100$$ENDHEX$$metros del pem m$$HEX1$$ed00$$ENDHEX$$nimo
				st_hon.coef_a = dw_2.getitemnumber(1, 'coef_a')
				st_hon.coef_b = dw_2.getitemnumber(1, 'coef_b')
				st_hon.coef_c = dw_2.getitemnumber(1, 'coef_c')
				openwithparm(w_calculo_honorarios_cc, st_hon)
				ds_honos = Message.PowerObjectParm
				if isvalid(ds_honos) then f_configura_parametros_fases_honos_cc (ds_honos.getitemstring(1,'tarifa'), this, ds_honos, 'G')								
//			CASE 'COAATGC'
//				openwithparm(w_calculo_gastos_honorarios_gc, st_hon)
//				ds_honos = Message.PowerObjectParm
//				if isvalid(ds_honos) then f_configura_parametros_fases_honos_gc (ds_honos.getitemstring(1,'tarifa'), this, ds_honos, 'G')
		END CHOOSE
END CHOOSE

end event

type dw_asociados from u_dw within w_calcula_gastos
boolean visible = false
integer x = 2574
integer y = 744
integer width = 1431
integer height = 384
integer taborder = 0
string dataobject = "d_fases_colegiados_asociados"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event pfc_addrow;call super::pfc_addrow;this.setitem(this.getrow(), 'id_col_aso', dw_colegiados.getitemstring(dw_colegiados.getrow(), 'id_col'))
this.setitem(this.getrow(), 'id_fase', dw_colegiados.getitemstring(dw_colegiados.getrow(), 'id_fase'))

return 1
end event

event constructor;this.getchild('id_col_per',i_dwc_colegiados_asociados)

i_dwc_colegiados_asociados.settransobject(sqlca)
i_dwc_colegiados_asociados.InsertRow (0)
end event

type dw_resumen from u_dw within w_calcula_gastos
event csd_calcula_honos_teo ( )
integer x = 123
integer y = 1696
integer width = 2743
integer height = 476
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_calcula_gastos_musaat"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_calcula_honos_teo();//st_cip_datos st_cip_datos
//double hon_teor = 0
//
//this.insertrow(0)
//// cargo la estructura
//st_cip_datos.tipo_act = dw_1.getitemstring(1, 'fase')
//st_cip_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_trabajo')
//st_cip_datos.superficie = dw_parametros.getitemnumber(1, 'superficie')
//st_cip_datos.pem = dw_parametros.getitemnumber(1, 'pem')
//st_cip_datos.admon = dw_1.getitemstring(1, 'administracion')
//st_cip_datos.volumen = dw_parametros.GetItemNumber(1,'volumen')
//st_cip_datos.altura = dw_parametros.GetItemNumber(1,'altura')
//st_cip_datos.colindantes = dw_parametros.GetItemString(1,'colindantes')
//st_cip_datos.tipo_gestion = dw_1.GetItemString(1,'tipo_gestion')
//
//st_cip_datos.long_per = dw_parametros.GetItemNumber(1,'longitud_per')
//st_cip_datos.vol_tierras = dw_parametros.GetItemNumber(1,'volumen_tierras')
//st_cip_datos.valor_terreno = dw_parametros.getitemnumber(1, 'valor_terreno')	
//st_cip_datos.valor_tasacion = dw_parametros.getitemnumber(1, 'valor_tasacion')
//st_cip_datos.valoracion_estim = dw_parametros.getitemnumber(1, 'valoracion_estim')
//st_cip_datos.estructura = dw_parametros.GetItemString(1,'estructura')
//st_cip_datos.t_medicion = dw_parametros.GetItemString(1,'t_medicion')
//st_cip_datos.replan_deslin = dw_parametros.GetItemString(1,'replan_deslin')
//st_cip_datos.t_terreno = dw_parametros.GetItemString(1,'t_terreno')
//
////// el 100%
//st_cip_datos.porcentaje = 100 
////// calculo
//f_calcular_hon_teor(st_cip_datos)
//hon_teor = st_cip_datos.hon_teor
//if isnull(hon_teor) then hon_teor = 0
//
//this.setitem(1, 'honos_teor', hon_teor)
//
end event

type gb_2 from groupbox within w_calcula_gastos
integer x = 37
integer y = 1152
integer width = 2875
integer height = 508
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_4 from groupbox within w_calcula_gastos
integer x = 37
integer y = 1652
integer width = 2875
integer height = 536
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_3 from groupbox within w_calcula_gastos
integer x = 37
integer y = 2180
integer width = 2875
integer height = 144
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

