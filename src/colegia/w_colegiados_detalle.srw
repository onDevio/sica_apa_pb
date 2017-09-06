HA$PBExportHeader$w_colegiados_detalle.srw
forward
global type w_colegiados_detalle from w_detalle
end type
type tab_1 from tab within w_colegiados_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_colegiados_domicilios from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_colegiados_domicilios dw_colegiados_domicilios
end type
type tabpage_19 from userobject within tab_1
end type
type dw_colegiados_telefonos from u_dw within tabpage_19
end type
type tabpage_19 from userobject within tab_1
dw_colegiados_telefonos dw_colegiados_telefonos
end type
type tabpage_6 from userobject within tab_1
end type
type dw_colegiados_sociedades from u_dw within tabpage_6
end type
type dw_colegiados_personas from u_dw within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_colegiados_sociedades dw_colegiados_sociedades
dw_colegiados_personas dw_colegiados_personas
end type
type tabpage_10 from userobject within tab_1
end type
type st_2 from statictext within tabpage_10
end type
type st_1 from statictext within tabpage_10
end type
type p_firma_colegiado from picture within tabpage_10
end type
type dw_fotos_firmas from u_dw within tabpage_10
end type
type p_foto_colegiado from picture within tabpage_10
end type
type tabpage_10 from userobject within tab_1
st_2 st_2
st_1 st_1
p_firma_colegiado p_firma_colegiado
dw_fotos_firmas dw_fotos_firmas
p_foto_colegiado p_foto_colegiado
end type
type tabpage_25 from userobject within tab_1
end type
type dw_anexos from u_dw within tabpage_25
end type
type tabpage_25 from userobject within tab_1
dw_anexos dw_anexos
end type
type tabpage_7 from userobject within tab_1
end type
type tab_4 from tab within tabpage_7
end type
type tabpage_3 from userobject within tab_4
end type
type dw_colegiados_agrupaciones from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_4
dw_colegiados_agrupaciones dw_colegiados_agrupaciones
end type
type tabpage_14 from userobject within tab_4
end type
type dw_colegiado_orientaciones_profesionales from u_dw within tabpage_14
end type
type tabpage_14 from userobject within tab_4
dw_colegiado_orientaciones_profesionales dw_colegiado_orientaciones_profesionales
end type
type tabpage_15 from userobject within tab_4
end type
type dw_colegiados_situacion_incompabilidad from u_dw within tabpage_15
end type
type tabpage_15 from userobject within tab_4
dw_colegiados_situacion_incompabilidad dw_colegiados_situacion_incompabilidad
end type
type tabpage_17 from userobject within tab_4
end type
type dw_titulacion from u_dw within tabpage_17
end type
type tabpage_17 from userobject within tab_4
dw_titulacion dw_titulacion
end type
type tabpage_27 from userobject within tab_4
end type
type dw_titulacion_hab from u_csd_dw within tabpage_27
end type
type tabpage_27 from userobject within tab_4
dw_titulacion_hab dw_titulacion_hab
end type
type tabpage_28 from userobject within tab_4
end type
type dw_inhabilitaciones from u_csd_dw within tabpage_28
end type
type tabpage_28 from userobject within tab_4
dw_inhabilitaciones dw_inhabilitaciones
end type
type tab_4 from tab within tabpage_7
tabpage_3 tabpage_3
tabpage_14 tabpage_14
tabpage_15 tabpage_15
tabpage_17 tabpage_17
tabpage_27 tabpage_27
tabpage_28 tabpage_28
end type
type tabpage_7 from userobject within tab_1
tab_4 tab_4
end type
type tabpage_5 from userobject within tab_1
end type
type tab_2 from tab within tabpage_5
end type
type tabpage_12 from userobject within tab_2
end type
type dw_colegiados_datos_fiscales from u_dw within tabpage_12
end type
type dw_conceptos_remesables from u_dw within tabpage_12
end type
type tabpage_12 from userobject within tab_2
dw_colegiados_datos_fiscales dw_colegiados_datos_fiscales
dw_conceptos_remesables dw_conceptos_remesables
end type
type tabpage_13 from userobject within tab_2
end type
type dw_colegiados_banco_cuenta from u_dw within tabpage_13
end type
type dw_colegiados_conceptos_domiciliables from u_dw within tabpage_13
end type
type tabpage_13 from userobject within tab_2
dw_colegiados_banco_cuenta dw_colegiados_banco_cuenta
dw_colegiados_conceptos_domiciliables dw_colegiados_conceptos_domiciliables
end type
type tabpage_18 from userobject within tab_2
end type
type dw_colegiados_empresas from u_dw within tabpage_18
end type
type tabpage_18 from userobject within tab_2
dw_colegiados_empresas dw_colegiados_empresas
end type
type tabpage_23 from userobject within tab_2
end type
type dw_cp from u_dw within tabpage_23
end type
type tabpage_23 from userobject within tab_2
dw_cp dw_cp
end type
type tabpage_29 from userobject within tab_2
end type
type dw_colegiados_recc from u_dw within tabpage_29
end type
type tabpage_29 from userobject within tab_2
dw_colegiados_recc dw_colegiados_recc
end type
type tab_2 from tab within tabpage_5
tabpage_12 tabpage_12
tabpage_13 tabpage_13
tabpage_18 tabpage_18
tabpage_23 tabpage_23
tabpage_29 tabpage_29
end type
type tabpage_5 from userobject within tab_1
tab_2 tab_2
end type
type tabpage_2 from userobject within tab_1
end type
type cb_1 from commandbutton within tabpage_2
end type
type tab_5 from tab within tabpage_2
end type
type tabpage_4 from userobject within tab_5
end type
type dw_colegiados_altas_bajas_situaciones from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_5
dw_colegiados_altas_bajas_situaciones dw_colegiados_altas_bajas_situaciones
end type
type tabpage_24 from userobject within tab_5
end type
type dw_cambios_domicilio from u_dw within tabpage_24
end type
type tabpage_24 from userobject within tab_5
dw_cambios_domicilio dw_cambios_domicilio
end type
type tabpage_16 from userobject within tab_5
end type
type dw_colegiados_modificacion_datos from u_dw within tabpage_16
end type
type tabpage_16 from userobject within tab_5
dw_colegiados_modificacion_datos dw_colegiados_modificacion_datos
end type
type tab_5 from tab within tabpage_2
tabpage_4 tabpage_4
tabpage_24 tabpage_24
tabpage_16 tabpage_16
end type
type tabpage_2 from userobject within tab_1
cb_1 cb_1
tab_5 tab_5
end type
type tabpage_8 from userobject within tab_1
end type
type tab_3 from tab within tabpage_8
end type
type tabpage_9 from userobject within tab_3
end type
type dw_colegiados_cesion_datos_nuevos from u_dw within tabpage_9
end type
type dw_colegiados_cesion_datos_internet from u_dw within tabpage_9
end type
type tabpage_9 from userobject within tab_3
dw_colegiados_cesion_datos_nuevos dw_colegiados_cesion_datos_nuevos
dw_colegiados_cesion_datos_internet dw_colegiados_cesion_datos_internet
end type
type tabpage_11 from userobject within tab_3
end type
type dw_colegiados_otros_datos from u_dw within tabpage_11
end type
type tabpage_11 from userobject within tab_3
dw_colegiados_otros_datos dw_colegiados_otros_datos
end type
type tabpage_20 from userobject within tab_3
end type
type dw_colegiados_listas_pertenece from u_dw within tabpage_20
end type
type tabpage_20 from userobject within tab_3
dw_colegiados_listas_pertenece dw_colegiados_listas_pertenece
end type
type tabpage_26 from userobject within tab_3
end type
type dw_personas_autorizadas from u_dw within tabpage_26
end type
type tabpage_26 from userobject within tab_3
dw_personas_autorizadas dw_personas_autorizadas
end type
type tab_3 from tab within tabpage_8
tabpage_9 tabpage_9
tabpage_11 tabpage_11
tabpage_20 tabpage_20
tabpage_26 tabpage_26
end type
type tabpage_8 from userobject within tab_1
tab_3 tab_3
end type
type tabpage_21 from userobject within tab_1
end type
type pb_src_nuevo from picturebutton within tabpage_21
end type
type dw_seguros from u_dw within tabpage_21
end type
type pb_seguros from picturebutton within tabpage_21
end type
type tabpage_21 from userobject within tab_1
pb_src_nuevo pb_src_nuevo
dw_seguros dw_seguros
pb_seguros pb_seguros
end type
type tabpage_22 from userobject within tab_1
end type
type pb_prem_nuevo from picturebutton within tabpage_22
end type
type pb_mutua from picturebutton within tabpage_22
end type
type dw_mutua from u_dw within tabpage_22
end type
type tabpage_22 from userobject within tab_1
pb_prem_nuevo pb_prem_nuevo
pb_mutua pb_mutua
dw_mutua dw_mutua
end type
type tab_1 from tab within w_colegiados_detalle
tabpage_1 tabpage_1
tabpage_19 tabpage_19
tabpage_6 tabpage_6
tabpage_10 tabpage_10
tabpage_25 tabpage_25
tabpage_7 tabpage_7
tabpage_5 tabpage_5
tabpage_2 tabpage_2
tabpage_8 tabpage_8
tabpage_21 tabpage_21
tabpage_22 tabpage_22
end type
type dw_2 from u_dw within w_colegiados_detalle
end type
type cb_2 from commandbutton within w_colegiados_detalle
end type
end forward

global type w_colegiados_detalle from w_detalle
integer x = 64
integer width = 4485
integer height = 2316
string title = "Detalle de Colegiados"
string menuname = "m_detalle_colegiados"
event csd_recupera_otros_datos ( )
event csd_busqueda_rapida ( )
event csd_imprimir ( )
event csd_impresos ( )
event csd_retrieve_tab_seguros ( )
event csd_retrieve_tab_mutua ( )
event csd_refrescar_conceptos ( )
tab_1 tab_1
dw_2 dw_2
cb_2 cb_2
end type
global w_colegiados_detalle w_colegiados_detalle

type variables
u_dw idw_colegiados_domicilios
u_dw idw_colegiados_altas_bajas_situaciones
u_dw idw_colegiados_cesion_datos_internet
u_dw idw_colegiados_cesion_datos_nuevos

u_dw idw_colegiados_incompatibilidades
u_dw idw_colegiados_datos_fiscales
u_dw idw_colegiados_sociedades
u_dw idw_colegiados_personas
u_dw idw_colegiados_agrupaciones
u_dw idw_colegiados_otros_datos
u_dw idw_colegiados_conceptos_domiciliables
u_dw idw_colegiados_conceptos_remesables
u_dw idw_colegiados_orientaciones_agrupaciones
u_dw idw_colegiados_fotos_firmas
//u_dw idw_colegiados_situaciones_profesionales
u_dw idw_colegiados_situacion_incompatibilidad
//u_dw idw_colegiados_firmas
u_dw idw_colegiados_modificacion_datos
u_dw idw_colegiados_empresas
u_dw idw_colegiados_listas_pertenece
u_dw idw_seguros
u_dw idw_mutua
u_dw idw_colegiados_titulacion
u_dw idw_colegiados_telefonos
u_dw idw_colegiados_banco_cuenta
u_dw idw_cp
u_dw idw_cambios_domicilio
u_dw idw_anexos
u_dw idw_personas_autorizadas
u_dw idw_colegiados_titulacion_hab
u_dw idw_colegiados_inhabilitaciones
u_dw idw_colegiados_recc
boolean i_permitir_dobleclick=false
int lineas

end variables

forward prototypes
public subroutine of_resetea_itemstatus (datawindow dw)
public subroutine of_resetea_itemstatus ()
public subroutine of_resetea_itemstatus_colegiados ()
public function integer of_comprueba_intervalos_recc ()
end prototypes

event csd_recupera_otros_datos;string codigo
long i

 DECLARE otros_conceptos CURSOR FOR  
  SELECT otros_conceptos.codigo  
    FROM otros_conceptos  
   WHERE ( otros_conceptos.colegio = :g_colegio ) AND  
         ( otros_conceptos.modulo = 'C' );
			

	Open otros_conceptos;
	
	Fetch otros_conceptos into :codigo;
	
	Do	while sqlca.sqlcode = 0
	i = idw_colegiados_otros_datos.InsertRow(0)
	idw_colegiados_otros_datos.setitem(i,'id_colegiado',dw_1.getitemstring(1,'id_colegiado'))
	idw_colegiados_otros_datos.setitem(i,'cod_caracteristica',codigo)
	Fetch otros_conceptos into :codigo;
	loop
close otros_conceptos;
end event

event csd_busqueda_rapida;dw_1.TriggerEvent("csd_retrieve")
end event

event csd_imprimir();dw_2.settrans(SQLCA)
dw_2.reset()
dw_2.retrieve(dw_1.getitemstring(1,'id_colegiado'))
g_idioma.of_cambia_textos_dw( dw_2 )
printsetup()
dw_2.print()
end event

event csd_impresos;openwithparm(w_colegiados_impresos, this)
end event

event csd_retrieve_tab_seguros();string id_col

id_col = dw_1.getitemstring(1, 'id_colegiado')

idw_seguros.retrieve(id_col)
dw_1.event csd_botones_tabs()

end event

event csd_retrieve_tab_mutua();string id_col

id_col = dw_1.getitemstring(1, 'id_colegiado')

idw_mutua.retrieve(id_col)
dw_1.event csd_botones_tabs()

end event

event csd_refrescar_conceptos();idw_colegiados_conceptos_domiciliables.retrieve(dw_1.getitemstring(1, 'id_colegiado'))

end event

public subroutine of_resetea_itemstatus (datawindow dw);//*************************************************************
// Resetea el itemStatus de un datawindow 
// Creado por Jesus 02/07/2010
//
// SCP-385
//*************************************************************

for lineas=0 to dw.RowCount()
	dw.SetItemStatus(lineas, 0, Primary!, NotModified!)
next
end subroutine

public subroutine of_resetea_itemstatus ();
end subroutine

public subroutine of_resetea_itemstatus_colegiados ();//*************************************************************
// Resetea el itemStatus de todos los datawindows de la ventana de colegiados
//
// Creado por Jesus 02/07/2010
//
// SCP-385
//*************************************************************

of_resetea_itemstatus(dw_1)
of_resetea_itemstatus(dw_2)
of_resetea_itemstatus(idw_colegiados_domicilios)
of_resetea_itemstatus(idw_colegiados_cesion_datos_internet)
of_resetea_itemstatus(idw_colegiados_cesion_datos_nuevos)
of_resetea_itemstatus(idw_colegiados_situacion_incompatibilidad)
of_resetea_itemstatus(idw_colegiados_datos_fiscales)
of_resetea_itemstatus(idw_colegiados_conceptos_remesables)
of_resetea_itemstatus(idw_colegiados_sociedades)
of_resetea_itemstatus(idw_colegiados_personas)
of_resetea_itemstatus(idw_colegiados_agrupaciones)
of_resetea_itemstatus(idw_colegiados_orientaciones_agrupaciones)
of_resetea_itemstatus(idw_colegiados_otros_datos)
of_resetea_itemstatus(idw_colegiados_conceptos_domiciliables)
of_resetea_itemstatus(idw_colegiados_empresas)
of_resetea_itemstatus(idw_colegiados_fotos_firmas)
of_resetea_itemstatus(idw_colegiados_listas_pertenece)
of_resetea_itemstatus(idw_colegiados_titulacion)
of_resetea_itemstatus(idw_colegiados_telefonos)
of_resetea_itemstatus(idw_colegiados_banco_cuenta)
of_resetea_itemstatus(idw_colegiados_altas_bajas_situaciones)
of_resetea_itemstatus(idw_colegiados_modificacion_datos)
of_resetea_itemstatus(idw_cambios_domicilio)
of_resetea_itemstatus(idw_seguros)
of_resetea_itemstatus(idw_mutua)
of_resetea_itemstatus(idw_cp)
of_resetea_itemstatus(idw_anexos)
of_resetea_itemstatus(idw_personas_autorizadas)
of_resetea_itemstatus(idw_colegiados_titulacion_hab)
of_resetea_itemstatus(tab_1.tabpage_5.tab_2.tabpage_12.dw_conceptos_remesables)
of_resetea_itemstatus(tab_1.tabpage_7.tab_4.tabpage_28.dw_inhabilitaciones)

end subroutine

public function integer of_comprueba_intervalos_recc ();datetime ldt_fecha_ini, ldt_fecha_fin, ldt_fecha_ini_aux, ldt_fecha_fin_aux
string ls_aplica_recc
int li_i, li_j


for li_i=1 to idw_colegiados_recc.rowcount()
		
	ldt_fecha_ini = idw_colegiados_recc.getitemdatetime( li_i, 'f_inicio')
	ldt_fecha_fin = idw_colegiados_recc.getitemdatetime( li_i, 'f_fin')
	ls_aplica_recc = idw_colegiados_recc.getitemstring(li_i, 'aplica_recc')
	
	if (isnull(ldt_fecha_ini) or isnull(ldt_fecha_fin))  then  
		if ( ls_aplica_recc = 'N') then 
			continue
		else
			messagebox(g_titulo, "Revise las fechas indicadas en los registro del RECC de contabilidad." + CR + "No puede indicar que aplica RECC sin indicar las fechas de aplicaci$$HEX1$$f300$$ENDHEX$$n", Stopsign!, Ok!)
			return -1 	
		end if
		
	end if	

	if (ldt_fecha_ini > ldt_fecha_fin) then 
			
		messagebox(g_titulo, "Revise las fechas indicadas en los registro del RECC de contabilidad." + CR + "No puede haber fechas de fin anteriores a las fechas de inicio", Stopsign!, Ok!)
		return -1		
	end if
	
	  	
	for li_j= li_i +1 to idw_colegiados_recc.rowcount() 
		
		ldt_fecha_ini_aux = idw_colegiados_recc.getitemdatetime( li_j, 'f_inicio')
		ldt_fecha_fin_aux = idw_colegiados_recc.getitemdatetime( li_j, 'f_fin')
		if (isnull(ldt_fecha_ini) or isnull(ldt_fecha_fin)) then  continue
		
		if (ldt_fecha_ini >= ldt_fecha_ini_aux and ldt_fecha_ini <= ldt_fecha_fin_aux) or (ldt_fecha_fin >= ldt_fecha_ini_aux and ldt_fecha_fin <= ldt_fecha_fin_aux) then 
			messagebox(g_titulo, "Revise las fechas indicadas en los registro del RECC de contabilidad." + CR + "                    Existen rangos de fecha que coinciden", Stopsign!, Ok!)
			return -1
		end if
			
	next	
			 
next


return 1
end function

event activate;call super::activate;g_dw_lista  = g_dw_lista_colegiados
g_w_lista   = g_lista_colegiados
g_w_detalle = g_detalle_colegiados
g_lista     = 'w_colegiados_lista'
g_detalle   = 'w_colegiados_detalle'

// Se asigna el valor del texto para "Colegio"
// dw_1.Object.colegio_t.Text=f_devuelve_tipo_delegacion()
//dw_1.Object.delegacion_t.Text=f_devuelve_tipo_delegacion()

end event

on w_colegiados_detalle.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_detalle_colegiados" then this.MenuID = create m_detalle_colegiados
this.tab_1=create tab_1
this.dw_2=create dw_2
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_2
end on

on w_colegiados_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.dw_2)
destroy(this.cb_2)
end on

event open;call super::open;string titulo
g_recien_grabado_modificacion=TRUE

if g_colegio <> 'COAATA' then tab_1.tabpage_5.tab_2.tabpage_23.visible = FALSE

idw_colegiados_domicilios              			= tab_1.tabpage_1.dw_colegiados_domicilios
idw_colegiados_cesion_datos_internet   		= tab_1.tabpage_8.tab_3.tabpage_9.dw_colegiados_cesion_datos_internet
idw_colegiados_cesion_datos_nuevos   		= tab_1.tabpage_8.tab_3.tabpage_9.dw_colegiados_cesion_datos_nuevos

idw_colegiados_situacion_incompatibilidad 	= tab_1.tabpage_7.tab_4.tabpage_15.dw_colegiados_situacion_incompabilidad
//idw_colegiados_situaciones_profesionales = tab_1.tabpage_7.tab_4.tabpage_15.dw_colegiados_incompatibilidades
idw_colegiados_datos_fiscales					= tab_1.tabpage_5.tab_2.tabpage_12.dw_colegiados_datos_fiscales
idw_colegiados_conceptos_remesables		= tab_1.tabpage_5.tab_2.tabpage_12.dw_conceptos_remesables
idw_colegiados_sociedades						= tab_1.tabpage_6.dw_colegiados_sociedades
idw_colegiados_personas						= tab_1.tabpage_6.dw_colegiados_personas
idw_colegiados_agrupaciones					= tab_1.tabpage_7.tab_4.tabpage_3.dw_colegiados_agrupaciones
idw_colegiados_orientaciones_agrupaciones = tab_1.tabpage_7.tab_4.tabpage_14.dw_colegiado_orientaciones_profesionales
idw_colegiados_otros_datos				     	= tab_1.tabpage_8.tab_3.tabpage_11.dw_colegiados_otros_datos
idw_colegiados_conceptos_domiciliables 		= tab_1.tabpage_5.tab_2.tabpage_13.dw_colegiados_conceptos_domiciliables
idw_colegiados_empresas						= tab_1.tabpage_5.tab_2.tabpage_18.dw_colegiados_empresas
idw_colegiados_fotos_firmas					= tab_1.tabpage_10.dw_fotos_firmas 
//idw_colegiados_firmas							= tab_1.tabpage_10.dw_firmas
idw_colegiados_listas_pertenece				= tab_1.tabpage_8.tab_3.tabpage_20.dw_colegiados_listas_pertenece
idw_colegiados_titulacion						= tab_1.tabpage_7.tab_4.tabpage_17.dw_titulacion
idw_colegiados_telefonos						= tab_1.tabpage_19.dw_colegiados_telefonos
idw_colegiados_banco_cuenta 					= tab_1.tabpage_5.tab_2.tabpage_13.dw_colegiados_banco_cuenta
idw_colegiados_altas_bajas_situaciones 	= tab_1.tabpage_2.tab_5.tabpage_4.dw_colegiados_altas_bajas_situaciones
idw_colegiados_modificacion_datos			= tab_1.tabpage_2.tab_5.tabpage_16.dw_colegiados_modificacion_datos
idw_cambios_domicilio							= tab_1.tabpage_2.tab_5.tabpage_24.dw_cambios_domicilio
idw_seguros 										= tab_1.tabpage_21.dw_seguros
idw_mutua 											= tab_1.tabpage_22.dw_mutua
idw_cp 												=  tab_1.tabpage_5.tab_2.tabpage_23.dw_cp
idw_anexos 										=  tab_1.tabpage_25.dw_anexos
idw_personas_autorizadas						= tab_1.tabpage_8.tab_3.tabpage_26.dw_personas_autorizadas	
idw_colegiados_titulacion_hab				= tab_1.tabpage_7.tab_4.tabpage_27.dw_titulacion_hab
idw_colegiados_inhabilitaciones			= tab_1.tabpage_7.tab_4.tabpage_28.dw_inhabilitaciones
idw_colegiados_recc		= tab_1.tabpage_5.tab_2.tabpage_29.dw_colegiados_recc
//A partir de este momento, cualquier referencia a las dw esclavas dentro de la 
//ventana se hara por idw_esclava1 o idw_esclava2
//dw_1.of_setlinkage(TRUE)  Esto se hace en la Ventana Padre

f_enlaza_dw(dw_1, idw_colegiados_recc, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_colegiados_domicilios, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_colegiados_altas_bajas_situaciones, 'id_colegiado', 'id_colegiado')

f_enlaza_dw(dw_1, idw_colegiados_cesion_datos_internet, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_colegiados_cesion_datos_nuevos, 'id_colegiado', 'id_colegiado')

f_enlaza_dw(dw_1, idw_colegiados_situacion_incompatibilidad, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_colegiados_datos_fiscales, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_colegiados_sociedades, 'id_colegiado', 'id_col_per')
f_enlaza_dw(dw_1, idw_colegiados_personas, 'id_colegiado', 'id_col_soc')
//f_enlaza_dw(dw_1, idw_colegiados_firmas,'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_colegiados_fotos_firmas,'id_colegiado', 'id_colegiado')

// se quita el f_enlaza porque ahora tenemos 2 retrieval's args. f_enlaza_dw(dw_1, idw_colegiados_modificacion_datos,'id_colegiado', 'id_colegiado')

f_enlaza_dw(dw_1, idw_colegiados_agrupaciones, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_colegiados_orientaciones_agrupaciones, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_colegiados_otros_datos, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_colegiados_conceptos_domiciliables, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_colegiados_conceptos_remesables, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_colegiados_empresas, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_colegiados_listas_pertenece, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_seguros,'id_colegiado', 'id_col')
f_enlaza_dw(dw_1, idw_mutua,'id_colegiado', 'id_col')
f_enlaza_dw(dw_1, idw_colegiados_titulacion, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_colegiados_titulacion_hab, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_colegiados_inhabilitaciones, 'id_colegiado', 'id_colegiado')

f_enlaza_dw(dw_1, idw_colegiados_telefonos, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_colegiados_banco_cuenta, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_cp, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_cambios_domicilio, 'id_colegiado', 'id_colegiado')
f_enlaza_dw(dw_1, idw_anexos, 'id_colegiado', 'id_modulo')
f_enlaza_dw(dw_1, idw_personas_autorizadas, 'id_colegiado', 'id_colegiado')



//A partir de aqui se pueden introducir las funciones de cambios de tama#o y
//posicion de los controles de la ventana.

inv_resize.of_register (tab_1, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_5.tab_2, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_8.tab_3, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_7.tab_4, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_2.tab_5, "scaletoright&bottom")
inv_resize.of_register (idw_colegiados_domicilios, "scaletoRight&Bottom")
inv_resize.of_register (idw_colegiados_fotos_firmas, "scaletoBottom")
//inv_resize.of_register (tab_1.tabpage_10.p_foto_colegiado, "FixedToRight&ScaleToBottom")
inv_resize.of_register (idw_colegiados_altas_bajas_situaciones, "scaletoRight&Bottom")
//inv_resize.of_register (idw_colegiados_cesion_datos_internet, "scaletoRight&Bottom")
//inv_resize.of_register (idw_colegiados_cesion_datos_nuevos, "FixedtoBottom")

inv_resize.of_register (idw_colegiados_situacion_incompatibilidad, "scaletoRight&Bottom")
inv_resize.of_register (idw_colegiados_datos_fiscales, "scaletoRight")
inv_resize.of_register (idw_colegiados_sociedades, "scaletoRight&Bottom")
inv_resize.of_register (idw_colegiados_personas, "scaletoRight&Bottom")
inv_resize.of_register (idw_colegiados_agrupaciones, "scaletoRight&Bottom")
inv_resize.of_register (idw_colegiados_orientaciones_agrupaciones, "ScaleToRight&Bottom")
inv_resize.of_register (idw_cp, "ScaleToRight&Bottom")
inv_resize.of_register (idw_anexos, "ScaleToRight&Bottom")
//inv_resize.of_register (idw_colegiados_orientaciones_agrupaciones, "FixedtoRight")
//inv_resize.of_register (idw_colegiados_firmas, "scaletoRight&Bottom")
//inv_resize.of_register (tab_1.tabpage_10.p_firma_colegiado, "FixedToRight&ScaleToBottom")
inv_resize.of_register (idw_colegiados_otros_datos, "scaletoRight&Bottom")
inv_resize.of_register (idw_colegiados_conceptos_domiciliables, "scaletoRight&Bottom")
inv_resize.of_register (idw_colegiados_conceptos_remesables, "scaletoRight&Bottom")
inv_resize.of_register (idw_colegiados_empresas, "scaletoRight&Bottom")
inv_resize.of_register (idw_colegiados_modificacion_datos, "scaletoRight&Bottom")
inv_resize.of_register (idw_colegiados_listas_pertenece, "scaletoRight&Bottom")
inv_resize.of_register (idw_colegiados_titulacion, "scaletoRight&Bottom")
inv_resize.of_register (idw_colegiados_titulacion_hab, "scaletoRight&Bottom")
inv_resize.of_register (idw_colegiados_inhabilitaciones, "scaletoRight&Bottom")

inv_resize.of_register (idw_colegiados_telefonos, "scaletoRight&Bottom")
inv_resize.of_register (idw_colegiados_banco_cuenta, "FixedtoBottom")
inv_resize.of_register (idw_seguros, "scaletoRight&Bottom")
inv_resize.of_register (idw_mutua, "scaletoRight&Bottom")
inv_resize.of_register (tab_1.tabpage_21.pb_seguros, "FixedToRight")
inv_resize.of_register (tab_1.tabpage_22.pb_mutua, "FixedToRight")
inv_resize.of_register (tab_1.tabpage_21.pb_src_nuevo, "FixedToRight")
inv_resize.of_register (tab_1.tabpage_22.pb_prem_nuevo, "FixedToRight")
//inv_resize.of_register (tab_1.tabpage_10.st_1, "Fixedtoright")
//inv_resize.of_register (tab_1.tabpage_10.st_2, "Fixedtoright")
inv_resize.of_register (idw_cambios_domicilio, "scaletoRight&Bottom")
inv_resize.of_register (idw_personas_autorizadas, "scaletoRight&Bottom")
inv_resize.of_register (idw_colegiados_recc, "scaletoRight&Bottom")

// Indicamos que queremos cambiar el idioma
if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)

st_control_eventos c_evento
c_evento.evento = 'ABRIR_COLEGIADO'
c_evento.dw = dw_1
if f_control_eventos(c_evento)=-1 then return

dw_1.Object.DataWindow.ShowBackColorOnXP = "yes" //CBU-42
end event

event csd_nuevo;call super::csd_nuevo;if AncestorReturnValue>0 then
	//Variables de control de grabacion de modificacion
	g_recien_grabado_modificacion=TRUE
	
	//Introducimos en el campo clave el valor obtenido desde el contador.
	dw_1.SetItem(dw_1.GetRow(),'id_colegiado',f_siguiente_numero('COLEGIADOS',10))
	
	//donde "n" es un entero que indica la longitud en caracteres del contador
	dw_1.setfocus()
	
	//Inicializacion de campos: f_alta, f_colegiacion a la fecha actual
	Dw_1.setitem(1, 'f_alta', datetime(Today()))
	Dw_1.setitem(1, 'f_colegiacion', datetime(Today()))
	Dw_1.SetItem(1, 'f_ultima_fact', datetime(Today())) 
	
	idw_colegiados_titulacion.Event  pfc_addrow()
	idw_colegiados_titulacion.setitemstatus(1,0,Primary!,DataModified!)
	idw_colegiados_titulacion.SetItem(1,'cons_tipo_titulacion','N')
//	idw_colegiados_titulacion.SetItem(1,'cons_circunst_habilitacion','N')
	idw_colegiados_titulacion.SetItem(1,'cons_tit_resg','T')
	
	idw_colegiados_banco_cuenta.Event  pfc_addrow()
	idw_colegiados_banco_cuenta.setitemstatus(1,0,Primary!,DataModified!)
	idw_colegiados_telefonos.Event  pfc_addrow()
	idw_colegiados_telefonos.setitemstatus(1,0,Primary!,DataModified!)
	
	idw_colegiados_cesion_datos_internet.Event  pfc_addrow()
	idw_colegiados_cesion_datos_internet.setitemstatus(1,0,Primary!,DataModified!)
	idw_colegiados_cesion_datos_internet.SetItem(1,'per_todos_datos','N')
	idw_colegiados_cesion_datos_internet.SetItem(1,'per_comer_notel','N')
	idw_colegiados_cesion_datos_internet.SetItem(1,'per_comer_sitel','N')
	idw_colegiados_cesion_datos_internet.SetItem(1,'visible_web','N')
	idw_colegiados_cesion_datos_internet.SetItem(1,'publicidad','N')	
	idw_colegiados_cesion_datos_internet.SetItem(1,'recibir_c_postales','N')
	idw_colegiados_cesion_datos_internet.SetItem(1,'recibir_c_email','N')	
	idw_colegiados_cesion_datos_internet.SetItem(1,'recibir_c_sms','N')
	idw_colegiados_cesion_datos_internet.SetItem(1,'recibir_c_web','N')
	idw_colegiados_cesion_datos_internet.SetItem(1,'domicilio_web','N')
	
	idw_colegiados_cesion_datos_nuevos.Event  pfc_addrow()
//	idw_colegiados_cesion_datos_nuevos.setitemstatus(1,0,Primary!,DataModified!)
	idw_colegiados_cesion_datos_nuevos.SetItem(1,'c_telefono_prof','N')
	idw_colegiados_cesion_datos_nuevos.SetItem(1,'c_telefono_part','N')
	idw_colegiados_cesion_datos_nuevos.SetItem(1,'c_movil_1','N')
	idw_colegiados_cesion_datos_nuevos.SetItem(1,'c_movil_2','N')
	idw_colegiados_cesion_datos_nuevos.SetItem(1,'c_fax','N')	
	idw_colegiados_cesion_datos_nuevos.SetItem(1,'c_url','N')
	idw_colegiados_cesion_datos_nuevos.SetItem(1,'c_email','N')	
	
	
	idw_colegiados_datos_fiscales.Event  pfc_addrow()
	idw_colegiados_datos_fiscales.setitemstatus(1,0,Primary!,DataModified!)
//	idw_colegiados_empresas.Event  pfc_addrow()
//	idw_colegiados_empresas.setitemstatus(1,0,Primary!,DataModified!)
	//idw_colegiados_empresas.SetItem(1,'trabaja_para_empresa','N')
	
	idw_colegiados_domicilios.Event  pfc_addrow()
	idw_colegiados_domicilios.SetItem(1,'particular','S')
	idw_colegiados_domicilios.SetItem(1,'profesional','S')
	idw_colegiados_domicilios.SetItem(1,'comercial','S')
	idw_colegiados_domicilios.SetItem(1,'fiscal','S')	
	//idw_colegiados_domicilios.setitemstatus(1,0,Primary!,DataModified!)
	idw_colegiados_conceptos_remesables.Event  pfc_addrow()
	//idw_colegiados_conceptos_domiciliables.setitemstatus(1,0,Primary!,DataModified!)

	
	idw_colegiados_conceptos_remesables.SetItem(1,'concepto','HO')
	idw_colegiados_conceptos_remesables.SetItem(1,'forma_de_pago','TR')
	
	this.Event csd_recupera_otros_datos()
	
	st_control_eventos c_evento
	c_evento.evento = 'COLEGIADO_NUEVO'
	c_evento.dw = dw_1
	if f_control_eventos(c_evento)=-1 then return -1
	
	
	// MODIFICADO RICARDO 20-11-03
   dwobject dwo
   dwo = dw_1.object.tipo_persona
   dw_1.trigger event itemchanged(dw_1.getrow(), dwo, 'P')
   // FIN MODIFICADO RICARDO 20-11-03
	
	// IRPF e IVA por defecto
	if g_colegio_retiene_irpf = 'S' then idw_colegiados_datos_fiscales.setitem(1, 'irpf', g_irpf_por_defecto)
	if g_colegio_retiene_iva = 'S' then idw_colegiados_datos_fiscales.setitem(1, 'iva_igic', f_dame_porcent_iva(g_t_iva_defecto))
	idw_colegiados_datos_fiscales.setitem(1, 'ultima_factura', 0)
	idw_colegiados_datos_fiscales.setitem(1, 'ultima_factura_rectif', 0)
	
	// Datos colegiales por defecto
	datawindowchild dwc_demarc
	dw_1.getchild('demarcacion',dwc_demarc)
	dwc_demarc.settransobject(sqlca)
	if dwc_demarc.retrieve() = 1 then dw_1.setitem(1, 'demarcacion', dwc_demarc.getitemstring(1, 'cod_demarcacion'))

	datawindowchild dwc_deleg
	dw_1.getchild('delegacion',dwc_deleg)
	dwc_deleg.settransobject(sqlca)
	if dwc_deleg.retrieve() = 1 then dw_1.setitem(1, 'delegacion', dwc_deleg.getitemstring(1, 'cod_delegacion'))

	dw_1.setitem(1, 'colegio', g_cod_colegio)
	
	idw_cp.Event  pfc_addrow()
	idw_cp.setitemstatus(1,0,Primary!,DataModified!)
	idw_cp.setitem(1, 'activo_cp', 'N')
	
end if

return AncestorReturnValue
end event

event csd_anterior;call super::csd_anterior;if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then
	g_colegiados_consulta.id_colegiado = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'id_colegiado')
	dw_1.event csd_retrieve()
end if

end event

event csd_siguiente;call super::csd_siguiente;if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then
	g_colegiados_consulta.id_colegiado = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'id_colegiado')
	dw_1.event csd_retrieve()
end if
end event

event csd_primero;call super::csd_primero;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(1)
	g_dw_lista.scrolltorow(1)
	g_colegiados_consulta.id_colegiado = g_dw_lista.getitemstring(1,"id_colegiado")
	
	dw_1.event csd_retrieve()
end if

end event

event csd_ultimo;call super::csd_ultimo;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(g_dw_lista.rowcount())
	g_dw_lista.scrolltorow(g_dw_lista.rowcount())
	g_colegiados_consulta.id_colegiado = g_dw_lista.getitemstring(g_dw_lista.rowcount(),"id_colegiado")
	
	dw_1.event csd_retrieve()
end if
end event

event pfc_preupdate;call super::pfc_preupdate;//control de permisos
if f_puedo_escribir(g_usuario, '0000000001')= -1 then return -1
string mensaje='', tipo_pers = ''
string sexo, tipo_imagen
int f,j
datetime f_coleg, f_titul
boolean  lb_domicilio_modif

 lb_domicilio_modif = false

//A$$HEX1$$f100$$ENDHEX$$adido por Eloy Brodin 24/11/06
// Comprobaciones de formato
int row
u_csd_nif uo_nif
row=dw_1.GetRow()

uo_nif.of_comprobar_documento(dw_1.GetItemString(row,'nif'),'')

// PARA MALLORCA SI ES RESIDENTE O NO RESIDENTE AUTOGENERAMOS EL N$$HEX2$$ba002000$$ENDHEX$$DE COELGIADO
string n_col
if g_colegio='COAATMCA' and f_es_vacio(dw_1.GetItemString(dw_1.GetRow(),'n_colegiado')) then
	if dw_1.GetItemSTring(dw_1.GetRow(),'c_geografico')<>'H' then
		n_col='PM'+f_siguiente_numero('N_COL_AUTO',5)
		dw_1.SetItem(dw_1.GetRow(),'n_colegiado',n_col)
	end if
end if

mensaje += f_valida(dw_1,'n_colegiado','NOVACIO',g_idioma.of_getmsg('colegiados.campo_colegiado','Debe especificar un valor en el campo N$$HEX2$$ba002000$$ENDHEX$$de colegiado.'))
mensaje += f_valida(dw_1,'delegacion','NOVACIO',g_idioma.of_getmsg('colegiados.campo_delegacion','Debe especificar un valor en el campo delegaci$$HEX1$$f300$$ENDHEX$$n.'))	
mensaje += f_valida(dw_1,'nif','NOVACIO',g_idioma.of_getmsg('colegiados.campo_nif','Debe especificar un valor en el campo NIF.'))
mensaje += f_valida(dw_1,'sexo','NOVACIO',g_idioma.of_getmsg('colegiados.campo_sexo','Debe especificar un valor en el campo sexo.'))

tipo_pers=dw_1.GetItemString(dw_1.getrow(), 'tipo_persona')
sexo     =dw_1.GetItemString(dw_1.getrow(), 'sexo')
if tipo_pers = "P" then
   mensaje += f_valida(dw_1,'nombre','NOVACIO',g_idioma.of_getmsg('colegiados.campo_nombre','Debe especificar un valor en el campo nombre.'))
	mensaje += f_valida(dw_1,'apellidos','NOVACIO',g_idioma.of_getmsg('colegiados.campo_apellido','Debe especificar un valor en el campo apellidos.'))
else
	mensaje += f_valida(dw_1,'apellidos','NOVACIO','Debe especificar un valor en el campo sociedad.')
end if	

mensaje += f_valida(dw_1,'colegio','NOVACIO',g_idioma.of_getmsg('colegiados.campo_colegio','Debe especificar un valor en el campo colegio.'))
mensaje += f_valida(dw_1,'situacion','NOVACIO',g_idioma.of_getmsg('colegiados.campo_situacion','Debe especificar un valor en el campo situaci$$HEX1$$f300$$ENDHEX$$n.'))
mensaje += f_valida(dw_1,'t_alta','NOVACIO',g_idioma.of_getmsg('colegiados.campo_alta','Debe especificar un valor en el campo tipo de alta.'))

//Validaciones de la tabla auxiliar domicilios
//--------------------------------------------
mensaje += f_valida(idw_colegiados_domicilios,'tipo_via','NOVACIO',g_idioma.of_getmsg('colegiados.campo_tipo_via','Debe especificar un valor en el campo tipo de v$$HEX1$$ed00$$ENDHEX$$a.'))
mensaje += f_valida(idw_colegiados_domicilios,'nom_via','NOVACIO',g_idioma.of_getmsg('colegiados.campo_nombre_via','Debe especificar un valor en el campo nombre de v$$HEX1$$ed00$$ENDHEX$$a.'))
mensaje += f_valida(idw_colegiados_domicilios,'cod_pob','NOVACIO',g_idioma.of_getmsg('colegiados.campo_codigo_poblacion','Debe especificar un valor en el campo c$$HEX1$$f300$$ENDHEX$$digo de poblaci$$HEX1$$f300$$ENDHEX$$n.'))
mensaje += f_valida(idw_colegiados_domicilios,'cod_prov','NOVACIO',g_idioma.of_getmsg('colegiados.campo_codigo_provincia','Debe especificar un valor en el campo c$$HEX1$$f300$$ENDHEX$$digo de provincia.'))
mensaje += f_valida(idw_colegiados_domicilios,'cp','NOVACIO',g_idioma.of_getmsg('colegiados.campo_codigo_postal','Debe especificar un valor en el c$$HEX1$$f300$$ENDHEX$$digo postal.'))
mensaje += f_valida(idw_colegiados_domicilios,'pais','NOVACIO',g_idioma.of_getmsg('colegiados.campo_pais','Debe especificar un valor en el campo pa$$HEX1$$ed00$$ENDHEX$$s.'))

idw_colegiados_domicilios.triggerevent ('csd_actualiza_poblaciones_activas')

//Andr$$HEX1$$e900$$ENDHEX$$s: Comprobamos que tenga un domicilio para correspondencia y uno fiscal
if idw_colegiados_domicilios.find("comercial='S'",1,idw_colegiados_domicilios.rowcount())<1 then 
	mensaje+=cr+g_idioma.of_getmsg('colegiados.dom_correspondencia','Debe especificar un domicilio para correspondencia')
end if
if idw_colegiados_domicilios.find("fiscal='S'",1,idw_colegiados_domicilios.rowcount())<1 then
	mensaje+=cr+g_idioma.of_getmsg('colegiados.dom_fiscal','Debe especificar un domicilio fiscal')
end if

//Validaciones de la tabla auxiliar altas_bajas_situaciones
//---------------------------------------------------------
mensaje += f_valida(idw_colegiados_altas_bajas_situaciones,'codigo','NOVACIO',g_idioma.of_getmsg('colegiados.campo_situacion','Debe especificar un valor en el campo Situaci$$HEX1$$f300$$ENDHEX$$n.'))


//Validaciones de la tabla auxiliar Agrupaciones
//----------------------------------------------
mensaje += f_valida(idw_colegiados_agrupaciones,'agrupacion','NOVACIO',g_idioma.of_getmsg('colegiados.campo_agrupacion','Debe especificar un valor en el campo agrupaci$$HEX1$$f300$$ENDHEX$$n.'))

//Validaci$$HEX1$$f300$$ENDHEX$$n en Titulaci$$HEX1$$f300$$ENDHEX$$n Habilitantes
mensaje += f_valida(idw_colegiados_titulacion_hab,'cod_titulacion','NOVACIO',g_idioma.of_getmsg('colegiados.campo_titulacion_hab','Debe especificar un valor en el campo titulaci$$HEX1$$f300$$ENDHEX$$n habilitante.'))


//Validaciones de la tabla auxiliar Orientaci$$HEX1$$f300$$ENDHEX$$n Profesional
//---------------------------------------------------------
mensaje += f_valida(idw_colegiados_orientaciones_agrupaciones,'orientacion_profesional','NOVACIO',g_idioma.of_getmsg('colegiados.campo_orientacion_profesional','Debe especificar un valor en el campo orientaci$$HEX1$$f300$$ENDHEX$$n profesional.'))

//Validaciones de la tabla auxiliar Situac.Prof/Incompatib.
//---------------------------------------------------------
mensaje += f_valida(idw_colegiados_situacion_incompatibilidad,'tipo_situacion','NOVACIO',g_idioma.of_getmsg('colegiados.campo_tipo_situacion','Debe especificar un valor en el campo tipo de situaci$$HEX1$$f300$$ENDHEX$$n.'))
mensaje += f_valida(idw_colegiados_situacion_incompatibilidad,'fecha_inicio','NONULO',g_idioma.of_getmsg('colegiados.campo_f_inicio','Debe especificar un valor en el campo fecha de inicio.'))

//Validaciones de la tabla auxiliar Conceptos Domiciliables
//---------------------------------------------------------
mensaje += f_valida(idw_colegiados_conceptos_domiciliables,'concepto','NOVACIO',g_idioma.of_getmsg('colegiados.msg_con_facturables','Debe especificar en la pesta$$HEX1$$f100$$ENDHEX$$a de Conceptos Facturables (Contabilidad) un valor en el campo concepto.'))
mensaje += f_valida(idw_colegiados_conceptos_domiciliables,'forma_de_pago','NOVACIO',g_idioma.of_getmsg('colegiados.msg_con_facturables_fp','Debe especificar en la pesta$$HEX1$$f100$$ENDHEX$$a de Conceptos Facturables (Contabilidad) un valor en el campo forma de pago.'))
string mensaje2


//Validaciones de la tabla auxiliar Sociedades
//--------------------------------------------
mensaje += f_valida(idw_colegiados_personas,'id_col_soc','NOVACIO',g_idioma.of_getmsg('colegiados.campo_sociedad','Debe especificar un valor en el campo sociedad.'))
mensaje += f_valida(idw_colegiados_personas,'porcent','MENORCIEN',g_idioma.of_getmsg('colegiados.campo_porcentaje','El porcentaje debe ser menor o igual que cien.'))	

//Validaciones de la tabla auxiliar datos fiscales
//------------------------------------------------
mensaje += f_valida(idw_colegiados_datos_fiscales,'iva_igic','NONULO',g_idioma.of_getmsg('colegiados.general_campo_sociedad','Debe especificar en la pesta$$HEX1$$f100$$ENDHEX$$a de Datos generales, pagos (Contabilidad) un valor en el campo retenci$$HEX1$$f300$$ENDHEX$$n IVA.'))
mensaje += f_valida(idw_colegiados_datos_fiscales,'irpf','NONULO',g_idioma.of_getmsg('colegiados.general_campo_irpf','Debe especificar en la pesta$$HEX1$$f100$$ENDHEX$$a de Datos generales, pagos (Contabilidad) un valor en el campo retenci$$HEX1$$f300$$ENDHEX$$n IRPF.'))
mensaje += f_valida(idw_colegiados_datos_fiscales,'ret_voluntaria','NONULO',g_idioma.of_getmsg('colegiados.general.campo_voluntaria','Debe especificar en la pesta$$HEX1$$f100$$ENDHEX$$a de Datos generales, pagos (Contabilidad) un valor en el campo retenci$$HEX1$$f300$$ENDHEX$$n voluntaria.'))

mensaje += f_valida(idw_colegiados_datos_fiscales,'iva_igic','MENORCIEN','En la pesta$$HEX1$$f100$$ENDHEX$$a de Datos generales, pagos (Contabilidad) la  retenci$$HEX1$$f300$$ENDHEX$$n IVA debe ser menor o igual que cien.')
mensaje += f_valida(idw_colegiados_datos_fiscales,'irpf','MENORCIEN','En la pesta$$HEX1$$f100$$ENDHEX$$a de Datos generales, pagos (Contabilidad) la  retenci$$HEX1$$f300$$ENDHEX$$n IRPF debe ser menor o igual que cien.')
mensaje += f_valida(idw_colegiados_datos_fiscales,'ret_voluntaria','MENORCIEN','En la pesta$$HEX1$$f100$$ENDHEX$$a de Datos generales, pagos (Contabilidad) la retenci$$HEX1$$f300$$ENDHEX$$n voluntaria debe ser menor o igual que cien.')

//Validaciones de la tabla auxiliar Fotos-Firmas
//----------------------------------------------
mensaje += f_valida(idw_colegiados_fotos_firmas,'tipo','NOVACIO','Debe especificar un valor en el campo tipo de Fotos/Firmas.')

//Validaciones de la tabla auxiliar Otros datos colegiados
//--------------------------------------------------------
mensaje += f_valida(idw_colegiados_otros_datos,'cod_caracteristica','NOVACIO','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo de Caracter$$HEX1$$ed00$$ENDHEX$$stica.')

//Validacion para sumatoria de porcentajes en sociedad
//----------------------------------------------------
int i
double suma=0
string tipo_persona
tipo_persona=dw_1.getitemstring(1,'tipo_persona')
if tipo_persona='S' then
	if idw_colegiados_personas.rowcount() >0 then
		for i=1 to idw_colegiados_personas.rowcount()
			 suma=suma+idw_colegiados_personas.getitemnumber(i,'porcent')
		next
		if suma > 100 then mensaje=mensaje+cr+g_idioma.of_getmsg('suma_porcentajes',"La suma de porcentajes de participaci$$HEX1$$f300$$ENDHEX$$n en una sociedad no puede ser mayor que cien.")
	end if
end if

//Validaciones de la tabla Personas Autorizadas
//--------------------------------------------
mensaje += f_valida(idw_personas_autorizadas,'nombre','NOVACIO',g_idioma.of_getmsg('colegiados_autorizaciones.nombre','Debe especificar un valor en el campo nombre.'))
mensaje += f_valida(idw_personas_autorizadas,'nif','NOVACIO',g_idioma.of_getmsg('colegiados_autorizaciones.nif','Debe especificar un valor en el campo NIF.'))	

//fin 
int retorno=1
if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
else
	// Avisar si existe un tercero con el nif del colegiado
	if not f_es_vacio(f_cliente_id_cliente(dw_1.getitemstring(1, 'nif'))) then 
		messagebox(g_titulo,g_idioma.of_getmsg('colegiados.avisos_duplicados_nif',"AVISO DUPLICIDAD DE NIF: Existe una persona en terceros con este NIF"))
	end if
	
	// Avisar si los dc de la cuenta no son v$$HEX1$$e100$$ENDHEX$$lidos
	string cuenta, dc
	if(idw_colegiados_conceptos_remesables.rowcount( ) > 0)then
		cuenta = idw_colegiados_conceptos_remesables.getitemstring(1, 'datos_bancarios')
	end if
	if LenA(cuenta) = 20 then
		dc = f_digito_control_cuenta_bancaria(MidA(cuenta,1,4),MidA(cuenta,5,4),MidA(cuenta,11,10))
		if dc <> MidA(cuenta,9,2) then messagebox(g_titulo,g_idioma.of_getmsg('colegiados.digitos_control',"Los d$$HEX1$$ed00$$ENDHEX$$gitos de control de la cuenta bancaria no son v$$HEX1$$e100$$ENDHEX$$lidos (Datos generales, pagos)"))
	end if
	cuenta = idw_colegiados_banco_cuenta.getitemstring(1, 'cuenta_domic')
	if LenA(cuenta) = 20 then
		dc = f_digito_control_cuenta_bancaria(MidA(cuenta,1,4),MidA(cuenta,5,4),MidA(cuenta,11,10))
		if dc <> MidA(cuenta,9,2) then messagebox(g_titulo,g_idioma.of_getmsg('colegiados.digitos_control_con',"Los d$$HEX1$$ed00$$ENDHEX$$gitos de control de la cuenta bancaria no son v$$HEX1$$e100$$ENDHEX$$lidos (Conceptos Facturables)"))
	end if	

	//Se controla que la fecha de Titulacion no sea mayor que la de Colegiacion
	f_coleg=dw_1.getitemdatetime(1,'f_colegiacion')
	f_titul=dw_1.getitemdatetime(1,'f_titulacion')
	if not isnull(f_coleg) and not isnull(f_titul) and f_titul > f_coleg then

		// No obligamos, vamos s$$HEX1$$f300$$ENDHEX$$lo a avisar
		messagebox(g_titulo, 'La fecha Fin Carrera no debe ser mayor que la de Colegiaci$$HEX1$$f300$$ENDHEX$$n.')
	end if 	
	
	// Introducimos el valor de la clave en la tabla t_usuario si no existe (s$$HEX1$$f300$$ENDHEX$$lo Guip$$HEX1$$fa00$$ENDHEX$$zcoa)
	if g_colegio = 'COAATGUI' then
		string cod, id_col, nombre, apellidos, nom_usu, clave, passw
		id_col = dw_1.getitemstring(1, 'id_colegiado')
	
		SELECT t_usuario.cod_usuario, t_usuario.password  
		INTO :cod, :passw  
		FROM t_usuario  
		WHERE t_usuario.id_col = :id_col   ;
		
		if isnull(cod) or cod = '' then
			nombre = dw_1.getitemstring(1, 'nombre')
			if isnull(nombre) then nombre = ''
				apellidos = dw_1.getitemstring(1, 'apellidos')
			if isnull(apellidos) then apellidos = ''
				n_col = dw_1.getitemstring(1, 'n_colegiado')
			if nombre='' then 
				nom_usu = apellidos
			else			
				nom_usu = apellidos + ', ' + nombre
			end if
			for f=1 to idw_colegiados_otros_datos.rowcount()
				if idw_colegiados_otros_datos.getitemstring(f, 'cod_caracteristica') = '05' then
					clave = idw_colegiados_otros_datos.getitemstring(f, 'texto')
				end if
			next
			//Javier Osuna 02/06/2010
			//comprobamos que el login no es duplicado en caso contrario se introduce como vacio y se avisa al usuario SCP-360
			string log_col
			int n_login
			log_col=n_col
			SELECT count(t_usuario.login)
			 INTO :n_login
			 FROM t_usuario  
			 WHERE t_usuario.login = :log_col  ; 
			 if n_login>0 then
				messagebox(g_titulo,"AVISO DUPLICIDAD DE LOGIN: El login para este usuario aparece ya en la base de datos, introduzca un nuevo usuario de manera manual para este colegiado.")
			else
				INSERT INTO t_usuario  
				( cod_usuario, nombre_usuario, password, login, departamento, id_col )  
				VALUES 
				( :n_col, :nom_usu, :clave, :n_col, null, :id_col )  ;
				commit;
			end if
			
		else // Si se ha modificado la clave, actualizamos en la tabla t_usuarios
			for f=1 to idw_colegiados_otros_datos.rowcount()
				if idw_colegiados_otros_datos.getitemstring(f, 'cod_caracteristica') = '05' then
					clave = idw_colegiados_otros_datos.getitemstring(f, 'texto')
				end if
			next
			
			if passw <> clave then
				UPDATE t_usuario  
     			SET password = :clave  
   				WHERE t_usuario.id_col = :id_col   ;
			end if	
		end if
	end if
	
	// HISTORICO DE DOMICILIOS
	string old_dom_activo,old_pob_activa,old_dom_activo_fiscal,old_pob_activa_fiscal, old_es_fiscal, old_es_comercial
	string new_dom_activo,new_pob_activa,new_dom_activo_fiscal,new_pob_activa_fiscal, new_es_fiscal, new_es_comercial
	string is_id_domicilio
	boolean ib_cambia_tipo_domicilio
	long linea,il_cont
	
	id_col = dw_1.getitemstring(1, 'id_colegiado')
	new_dom_activo_fiscal=trim(dw_1.GetItemString(dw_1.GetRow(),'domicilio_activo_fiscal'))
	new_pob_activa_fiscal=trim(dw_1.GetItemString(dw_1.GetRow(),'poblacion_activa_fiscal'))
	new_dom_activo=trim(dw_1.GetItemString(dw_1.GetRow(),'domicilio_activo'))
	new_pob_activa=trim(dw_1.GetItemString(dw_1.GetRow(),'poblacion_activa'))
	
	select domicilio_activo_fiscal, poblacion_activa_fiscal, domicilio_activo, poblacion_activa 
	into :old_dom_activo_fiscal,:old_pob_activa_fiscal,:old_dom_activo,:old_pob_activa
	from colegiados where id_colegiado=:id_col;
	
	old_dom_activo_fiscal=trim(old_dom_activo_fiscal)
	old_pob_activa_fiscal=trim(old_pob_activa_fiscal)
	old_dom_activo=trim(old_dom_activo)
	old_pob_activa=trim(old_pob_activa)
	
	/****** modificado por Alexis 22-07-09. Se ha introducido la variable lb_domicilio_modif para evitar que guarde dos entradas en el hist$$HEX1$$f300$$ENDHEX$$rico ******/
	//SCP-387 Miramos no introducir lineas en el hist$$HEX1$$f300$$ENDHEX$$rico con el domicilio actual en blanco. JESUS 09-07-2010
	if  NOT f_es_vacio(new_dom_activo_fiscal) and NOT f_es_vacio(new_pob_activa_fiscal) and (old_dom_activo_fiscal<>new_dom_activo_fiscal or old_pob_activa_fiscal<>new_pob_activa_fiscal) then
		lb_domicilio_modif = true
		linea=idw_cambios_domicilio.event pfc_addrow()
		idw_cambios_domicilio.SetItem(linea,'fiscal','S')
		idw_cambios_domicilio.SetItem(linea,'domicilio_antiguo',old_dom_activo_fiscal)
		idw_cambios_domicilio.SetItem(linea,'poblacion_antigua',old_pob_activa_fiscal)	
		idw_cambios_domicilio.SetItem(linea,'domicilio_nuevo',new_dom_activo_fiscal)
		idw_cambios_domicilio.SetItem(linea,'poblacion_nueva',new_pob_activa_fiscal)	
	end if
	
	if (NOT f_es_vacio(new_dom_activo) and NOT f_es_vacio(new_pob_activa) and (old_dom_activo<>new_dom_activo or old_pob_activa<>new_pob_activa) and  lb_domicilio_modif = false) then
		linea=idw_cambios_domicilio.event pfc_addrow()
		idw_cambios_domicilio.SetItem(linea,'fiscal','N')
		idw_cambios_domicilio.SetItem(linea,'domicilio_antiguo',old_dom_activo)
		idw_cambios_domicilio.SetItem(linea,'poblacion_antigua',old_pob_activa)	
		idw_cambios_domicilio.SetItem(linea,'domicilio_nuevo',new_dom_activo)
		idw_cambios_domicilio.SetItem(linea,'poblacion_nueva',new_pob_activa)		
	end if
	
end if


//CBU-53
mensaje2=''
if(idw_colegiados_conceptos_remesables.rowcount( ) > 0)then
	if f_es_vacio(idw_colegiados_conceptos_remesables.GetItemString(1,'datos_bancarios')) then mensaje2+='- Cuenta Bancaria CCC' +cr
end if
if f_es_vacio(idw_colegiados_banco_cuenta.GetItemString(1,'cuenta_domic')) then mensaje2+='- Cuenta Banco domiciliacion'

if not(f_es_vacio(mensaje2)) then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Recuerde que no ha rellenado los siguientes conceptos:"+cr+mensaje2)
end if


boolean lb_cuentas_correctas, lb_bics_correctos
string ls_cuenta_iban, ls_bic
int fila

ls_cuenta_iban = idw_colegiados_conceptos_remesables.getitemstring( idw_colegiados_conceptos_remesables.getrow(), 'datos_bancarios_iban')
if not f_es_vacio(ls_cuenta_iban) and not gnv_control_cuentas_bancarias.of_comprobar_iban(ls_cuenta_iban) then  messagebox(g_titulo, "Revise la cuenta introducida en el campo IBAN de los conceptos remesables. No es una cuenta v$$HEX1$$e100$$ENDHEX$$lida", Exclamation!)

ls_bic = idw_colegiados_conceptos_remesables.getitemstring( idw_colegiados_conceptos_remesables.getrow(), 'bic')
if not f_es_vacio(ls_bic) and not gnv_control_cuentas_bancarias.of_comprobar_bic( ls_bic) then messagebox(g_titulo, "Revise el c$$HEX1$$f300$$ENDHEX$$digo BIC de los conceptos remesables. El formato no es v$$HEX1$$e100$$ENDHEX$$lido", Exclamation!)

ls_cuenta_iban = idw_colegiados_banco_cuenta.getitemstring( idw_colegiados_banco_cuenta.getrow(), 'datos_bancarios_iban')
if not f_es_vacio(ls_cuenta_iban) and not gnv_control_cuentas_bancarias.of_comprobar_iban(ls_cuenta_iban) then  messagebox(g_titulo, "Revise el IBAN de la cuenta gen$$HEX1$$e900$$ENDHEX$$rica de los conceptos domiciliables. No es una cuenta v$$HEX1$$e100$$ENDHEX$$lida", Exclamation!)

ls_bic = idw_colegiados_banco_cuenta.getitemstring( idw_colegiados_banco_cuenta.getrow(), 'bic')
if not f_es_vacio(ls_bic) and not gnv_control_cuentas_bancarias.of_comprobar_bic( ls_bic) then messagebox(g_titulo, "Revise el c$$HEX1$$f300$$ENDHEX$$digo BIC de la cuenta gen$$HEX1$$e900$$ENDHEX$$rica de los conceptos domiciliables. El formato no es v$$HEX1$$e100$$ENDHEX$$lido", Exclamation!)

lb_cuentas_correctas = true 
lb_bics_correctos = true


For fila = 1 to idw_colegiados_conceptos_domiciliables.RowCount() 
	IF idw_colegiados_conceptos_domiciliables.GetItemStatus( fila,0, Primary!) <> NotModified! then 
		
		//Si hay cuenta bancaria, comprobamos que tenga IBAN y BIC
		ls_cuenta_iban = idw_colegiados_conceptos_domiciliables.GetItemString(fila, 'datos_bancarios_iban')
		if  not (f_es_vacio(ls_cuenta_iban)) then	
				if not (gnv_control_cuentas_bancarias.of_comprobar_iban(ls_cuenta_iban)) then lb_cuentas_correctas = false
		end if	
		
		ls_bic = idw_colegiados_conceptos_domiciliables.GetItemString(fila, 'bic')
		if  not (f_es_vacio(ls_bic)) then	
				if not (gnv_control_cuentas_bancarias.of_comprobar_bic(ls_bic)) then lb_bics_correctos = false
		end if	
				
	END IF
next

if lb_cuentas_correctas = false then messagebox(g_titulo, "Revise las cuentas introducidas en el campo IBAN de los conceptos domiciliables. Alguna cuenta no es v$$HEX1$$e100$$ENDHEX$$lida", Exclamation!)
if lb_bics_correctos = false then messagebox(g_titulo, "Revise el c$$HEX1$$f300$$ENDHEX$$digo BIC de los conceptos domiciliables. Alg$$HEX1$$fa00$$ENDHEX$$n dato no dispone de un formato v$$HEX1$$e100$$ENDHEX$$lido", Exclamation!)


ls_cuenta_iban = idw_cp.getitemstring( idw_cp.getrow(), 'cuenta_personal_iban')
if  not f_es_vacio(ls_cuenta_iban) and not gnv_control_cuentas_bancarias.of_comprobar_iban(ls_cuenta_iban) then  messagebox(g_titulo, "Revise la cuenta introducida en el campo IBAN de la cuenta personal. No es una cuenta v$$HEX1$$e100$$ENDHEX$$lida", Exclamation!)

ls_bic = idw_cp.getitemstring( idw_cp.getrow(), 'cuenta_personal_bic')
if  not f_es_vacio(ls_bic) and not gnv_control_cuentas_bancarias.of_comprobar_bic( ls_bic) then messagebox(g_titulo, "Revise el c$$HEX1$$f300$$ENDHEX$$digo BIC de la cuenta personal. El formato no es v$$HEX1$$e100$$ENDHEX$$lido", Exclamation!)




if( of_comprueba_intervalos_recc() = -1) then return -1

return retorno

end event

event type integer pfc_postupdate(powerobject apo_control[]);call super::pfc_postupdate;g_recien_grabado_modificacion=TRUE
return 1
end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_colegiados_detalle
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_colegiados_detalle
integer taborder = 20
end type

type cb_nuevo from w_detalle`cb_nuevo within w_colegiados_detalle
string tag = "texto=general.nuevo"
integer taborder = 50
end type

type cb_ayuda from w_detalle`cb_ayuda within w_colegiados_detalle
string tag = "texto=general.ayuda"
integer taborder = 100
end type

type cb_grabar from w_detalle`cb_grabar within w_colegiados_detalle
string tag = "texto=general.grabar"
integer taborder = 70
end type

type cb_ant from w_detalle`cb_ant within w_colegiados_detalle
integer taborder = 80
end type

type cb_sig from w_detalle`cb_sig within w_colegiados_detalle
integer taborder = 90
end type

type dw_1 from w_detalle`dw_1 within w_colegiados_detalle
event csd_modificacion_datos ( string id_colegiado,  u_dw dw,  string nombre_dw,  string campo,  long row )
event csd_clave_acceso ( )
event csd_botones_tabs ( )
event type string csd_matricula_colegio ( )
event csd_formatear_nif ( )
event csd_baja_conceptos_remesables ( string id_colegiado )
event csd_inserta_concepto_domic ( string codigo,  string forma_pago,  string as_empresa )
integer x = 37
integer y = 32
integer width = 4393
integer height = 808
integer taborder = 30
string dataobject = "d_colegiados_detalle"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_1::csd_modificacion_datos;// Actualiza los datos modificados en la tabla "modificaciones"
// ------------------------------------------------------------
string  colegiado, modificacion, data, tipo
integer fila

// Se devuelve un valor campo de la DW segun sea el tipo de dato
tipo=dw.Describe(campo+".ColType")
if tipo='!' then return // Define un tipo constanste

data=''
CHOOSE CASE upper(LeftA(tipo ,2))
	CASE 'CH' // Tipo 'String'
		data=dw.getitemstring(row,campo)
	CASE 'DA' // Tipo 'DateTime'
		data=string(dw.getitemdatetime(row,campo),'dd/mm/yyyy')
	CASE ELSE // queda 'Number'
      data=string(dw.getitemnumber(row,campo))
END CHOOSE

if f_es_vacio(data) then data=''   // return

//se a$$HEX1$$f100$$ENDHEX$$ade un registro a modificaci$$HEX1$$f300$$ENDHEX$$n de datos
if g_recien_grabado_modificacion=TRUE then
	idw_colegiados_modificacion_datos.triggerevent("pfc_addrow")
end if

fila        =idw_colegiados_modificacion_datos.rowcount()
colegiado   =id_colegiado
modificacion=idw_colegiados_modificacion_datos.getitemstring(fila,'modificacion')

// se concatenan las modificaciones con la anterior
if isnull(modificacion) then modificacion = ''
modificacion = modificacion + nombre_dw + ' ' + campo + '=' + data + '; '

// Se actualiza la dw de modificaciones oculta
idw_colegiados_modificacion_datos.setitem(fila,'id_colegiado',colegiado)
idw_colegiados_modificacion_datos.setitem(fila,'modificacion',modificacion)
idw_colegiados_modificacion_datos.setitem(fila,'fecha',datetime(today(),now()))
idw_colegiados_modificacion_datos.setitem(fila,'usuario',g_usuario)

g_recien_grabado_modificacion=FALSE
end event

event dw_1::csd_clave_acceso();int fila
string clave

randomize(0)
clave = RightA('0000' + string(rand(9999)),4)

fila = idw_colegiados_otros_datos.insertrow(0)
idw_colegiados_otros_datos.setitem(fila, 'id_colegiado', dw_1.getitemstring(1, 'id_colegiado'))
idw_colegiados_otros_datos.setitem(fila, 'cod_caracteristica', '05')
idw_colegiados_otros_datos.setitem(fila, 'texto', clave)

end event

event dw_1::csd_botones_tabs();if dw_1.getitemstring(1,'tipo_persona')='P' then
	idw_colegiados_sociedades.visible=true
	idw_colegiados_personas.visible=false
else
	idw_colegiados_personas.visible=true
	idw_colegiados_sociedades.visible=false
end if

if idw_mutua.rowcount()>0 then 
	tab_1.tabpage_22.pb_mutua.visible = true
	tab_1.tabpage_22.pb_prem_nuevo.visible = false
else
	tab_1.tabpage_22.pb_mutua.visible = false
	tab_1.tabpage_22.pb_prem_nuevo.visible = true
end if

if idw_seguros.rowcount()>0 then 
	tab_1.tabpage_21.pb_seguros.visible = true
	tab_1.tabpage_21.pb_src_nuevo.visible = false
else
	tab_1.tabpage_21.pb_seguros.visible = false
	tab_1.tabpage_21.pb_src_nuevo.visible = true
end if


end event

event type string dw_1::csd_matricula_colegio();// Devuelve la matr$$HEX1$$ed00$$ENDHEX$$cula del colegio de residencia para el n$$HEX1$$fa00$$ENDHEX$$mero de acreditado
string mat

CHOOSE CASE g_colegio
	CASE 'COAATB'
		mat = 'BI'
	CASE 'COAATMU'
		mat = 'MU'
	CASE 'COAATBU'
		mat = 'BU'
	CASE 'COAATGUI'
		mat = 'SS'
	CASE 'COAATGC'
		mat = 'GC'
	CASE 'COAATLR'
		mat = 'LO'
	CASE 'COAATCU'
		mat = 'CU'
	CASE 'COAATTFE'
		mat = 'TF'
	CASE 'COAATZ'
		mat = '0Z'
	CASE 'COAATGU'
		mat = 'GU'
	CASE 'COAATLE'
		mat = 'LE'
	CASE 'COAATAVI'
		mat = 'AV'
	CASE 'COAATA'
		mat = '0A'
	CASE 'COAATNA'
		mat = 'NA'
	CASE 'COAATTGN'
		mat = '0T'
	CASE 'COAATLL'
		mat = 'LL'	
	CASE 'COAATTEB'
		mat = 'TB'
	CASE 'COAATTER'
		mat = 'TE'
	CASE 'COAATCC'
		mat = 'CC'	
	CASE 'COAATMCA'
		mat = 'PM'		
END CHOOSE

return mat

end event

event dw_1::csd_formatear_nif();u_csd_nif uo_nif
string nif,nif_formateado
long row
integer hay

nif = this.getitemstring(1,'nif')

row=dw_1.GetRow()
//nif_formateado=uo_nif.of_formatear_nif(nif)
nif_formateado=uo_nif.of_comprobar_documento(nif,'')


Select count(*) 
into :hay 
from colegiados 
where nif = :nif;		

if hay > 0 then 
	messagebox(g_titulo,'Nif de colegiado duplicado.',Information!)
end if

/*
//A$$HEX1$$f100$$ENDHEX$$adido por Eloy Brodin 24/11/06
// Comprobaciones de formato
if uo_nif.of_comprobar_nif(this.GetItemString(row,'nif'),'00055',this.GetItemString(row,'tipo_persona'))=-1 then
	messagebox(g_titulo,'Formato de NIF Incorrecto.'+cr+cr+'Ej.: 12345678Z,X1234567Z,A12345678,A1234567R',Information!)
end if
*/
end event

event dw_1::csd_baja_conceptos_remesables(string id_colegiado);integer Respuesta


Respuesta = MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n", "$$HEX1$$bf00$$ENDHEX$$Desea borrar los conceptos remesables?", Exclamation!, YesNo!, 2)

IF Respuesta = 1 THEN
  delete from conceptos_domiciliables  
  where conceptos_domiciliables.id_colegiado = :id_colegiado  ;
  commit;
end if






end event

event dw_1::csd_inserta_concepto_domic(string codigo, string forma_pago, string as_empresa);double importe

idw_colegiados_conceptos_domiciliables.Event  pfc_addrow()
idw_colegiados_conceptos_domiciliables.SetItem(1,'concepto',codigo)
idw_colegiados_conceptos_domiciliables.SetItem(1,'forma_de_pago',forma_pago)
idw_colegiados_conceptos_domiciliables.SetItem(1,'empresa',as_empresa)


select importe into :importe from csi_articulos_servicios where codigo=:codigo;

idw_colegiados_conceptos_domiciliables.SetItem(1,'importe',importe)
end event

event dw_1::csd_retrieve;if g_colegiados_consulta.id_colegiado = '' or isnull(g_colegiados_consulta.id_colegiado) then return
int    retorno
double i
retorno = parent.event closequery()
if retorno = 1 then return

this.retrieve(g_colegiados_consulta.id_colegiado)
//Se enlaza el Tab dependiendo del valor de tipo_persona

g_colegiados_consulta.id_colegiado=''

//Busca datos en cesi$$HEX1$$f300$$ENDHEX$$n de datos internet VU
if idw_colegiados_cesion_datos_nuevos.rowcount() = 0 then
	idw_colegiados_cesion_datos_nuevos.Event  pfc_addrow()
	idw_colegiados_cesion_datos_nuevos.SetItem(1,'c_telefono_prof','N')
	idw_colegiados_cesion_datos_nuevos.SetItem(1,'c_telefono_part','N')
	idw_colegiados_cesion_datos_nuevos.SetItem(1,'c_movil_1','N')
	idw_colegiados_cesion_datos_nuevos.SetItem(1,'c_movil_2','N')
	idw_colegiados_cesion_datos_nuevos.SetItem(1,'c_fax','N')	
	idw_colegiados_cesion_datos_nuevos.SetItem(1,'c_url','N')
	idw_colegiados_cesion_datos_nuevos.SetItem(1,'c_email','N')	
end if


event csd_botones_tabs()

//Ponemos todos los datawindows como no modificados, para que no pida grabar
//SCP-385 Jesus 2-7-2010
of_resetea_itemstatus_colegiados()


end event

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event dw_1::itemchanged;call super::itemchanged;string n_col, codigo, nif, id_colegiado, ret
long n_reg=0,ll_pos
integer fila, f, retorno=0, hayotro
boolean existe_sit_alta_baja=false
st_factufa_facturas_pendientes datos

id_colegiado = this.getitemstring(row, 'id_colegiado')

// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, 'DETALLE', dwo.name, row)

CHOOSE CASE	dwo.name
	CASE 'n_colegiado'
		n_col = data
      if g_colegio = 'COAATLR' then
      	// rellenaremos con ceros
         n_col = f_rellenar_ceros(5, n_col)
      end if
                
      hayotro = f_colegiado_duplicado(n_col)
      if hayotro =  1 then 
	      messagebox(g_titulo,g_idioma.of_getmsg('colegiados.duplicado','N$$HEX1$$fa00$$ENDHEX$$mero de colegiado duplicado.'))
         return 1
      end if
      if g_colegio = 'COAATLR' then
         this.post setitem(row, 'n_colegiado', n_col)
      end if
	
	CASE 'situacion', 'c_geografico' //, 't_alta', 't_baja'
		// Si la situaci$$HEX1$$f300$$ENDHEX$$n o residente se modifica se a$$HEX1$$f100$$ENDHEX$$ade un registro al hist$$HEX1$$f300$$ENDHEX$$rico de alta/baja/sit
		codigo=data
		if codigo = '' then return
		existe_sit_alta_baja=false
		fila =idw_colegiados_altas_bajas_situaciones.rowcount()
		for f = 1 to idw_colegiados_altas_bajas_situaciones.rowcount()
			// Se controla que para un codigo/tipo no se repitan en un dia
			if	MidA(idw_colegiados_altas_bajas_situaciones.getitemstring(f,'campo_modificado'),1,10)=MidA(string(dwo.name),1,10) and &
			string(idw_colegiados_altas_bajas_situaciones.getitemdatetime(f,'fecha'),"dd/mm/yyyy") = string(today(),"dd/mm/yyyy") then
				existe_sit_alta_baja = true
				fila = f
			end if	
		next
		
		if not existe_sit_alta_baja then
			idw_colegiados_altas_bajas_situaciones.triggerevent("pfc_addrow")
			fila =idw_colegiados_altas_bajas_situaciones.rowcount()
		end if
		
		idw_colegiados_altas_bajas_situaciones.setitem(fila,'id_colegiado',this.getitemstring(this.getrow(),'id_colegiado'))
		idw_colegiados_altas_bajas_situaciones.setitem(fila,'codigo',codigo)
		idw_colegiados_altas_bajas_situaciones.setitem(fila,'campo_modificado',dwo.name)
		
		//En el campo fecha se pone la de hoy con la hora
		idw_colegiados_altas_bajas_situaciones.setitem(fila,'fecha',datetime(today(),now()))
		
		//Se actualizan los indicadores de tipo situacion, alta, baja
		if dwo.name='situacion' then idw_colegiados_altas_bajas_situaciones.setitem(fila,'situacion','S')
		if dwo.name='t_alta' then idw_colegiados_altas_bajas_situaciones.setitem(fila,'alta','S')
		if dwo.name='t_baja' then idw_colegiados_altas_bajas_situaciones.setitem(fila,'baja','S')
		if dwo.name='c_geografico' then idw_colegiados_altas_bajas_situaciones.setitem(fila,'residente','S')

		idw_colegiados_altas_bajas_situaciones.sort()		

	CASE 'tipo_persona'
		// Se asigna S al campo sexo si el tipo de persona es 'S'
		if data = "S" then
			this.setitem(1,'sexo',"S")
		else 
			this.setitem(1,'sexo'," ")
		end if	
		// Se ocultan/muestran las DWs de Sociedades		
		if data='P' then 
			idw_colegiados_sociedades.visible = true
			idw_colegiados_personas.visible = false
		else 
			idw_colegiados_personas.visible = true
			idw_colegiados_sociedades.visible = false
		end if

	CASE 'sexo'
		// Se asigna "S" si es sociedad
		if data = "S" then
			this.setitem(1,'tipo_persona',"S")
		else 
			this.setitem(1,'tipo_persona',"P")
		end if	
		// Se ocultan/muestran las DWs de Sociedades		
		if data<>'S' then 
			idw_colegiados_sociedades.visible = true
			idw_colegiados_personas.visible = false
		else 
			idw_colegiados_personas.visible = true
			idw_colegiados_sociedades.visible = false
		end if
		
//	CASE 'f_alta'
//		if not isnull(this.getitemdatetime(1,'f_baja')) then 
//			// Si es f_alta > f_baja se asigna directamente alta='S'
//			if	datetime(Date(data)) > this.getitemdatetime(1,'f_baja') then 
//				this.setitem(1,'alta_baja',"S")
//				return no_action
//				retorno = 0
//			end if
//		end if
		
//	CASE 'f_baja'
//		if not f_es_vacio(string(this.getitemdatetime(1,'f_alta'))) then
//			if datetime(Date(data), time("23:59:59")) > this.getitemdatetime(1,'f_alta') then			
//				messagebox(g_titulo," Se proceder$$HEX2$$e1002000$$ENDHEX$$a colocar de baja a este colegiado ")
//				retorno = 0
//				this.setitem(1,'alta_baja',"N")
//			end if
//		else 
//			Messagebox(g_titulo,"No se puede actualizar por no existir fecha de alta")
//		end if
	
	CASE 'nif'
		
		// COMENTADO POR ELOY 22/04/2009. CAMBIADA LA FUNCION DE COMPROBACION DE NIF
		/*
		id_colegiado = this.getitemstring(row, 'id_colegiado')

		// Validamos que el nif no exista ya en los colegiados
		if RightA(data, 1) = '*' then
			nif = f_calculo_nif(data)
			if nif = '-1' then return -1
		else
			nif = data
		end if

		select count(id_colegiado) into :n_reg from colegiados where nif = :nif and id_colegiado <> :id_colegiado;
		if n_reg>0 then Messagebox(g_titulo,g_idioma.of_getmsg('colegiados.duplicado_nif', "Existe otro colegiado con ese nif"), exclamation!)
		this.post setitem(row, 'nif', nif)			
*/
		this.PostEvent('csd_formatear_nif')

	CASE 'matricula'
		// INC. 3362 - Formamos el n$$HEX2$$ba002000$$ENDHEX$$acreditado con el siguiente formato XXCCCCCCCYY
		// X - Colegio de residencia, C - N$$HEX2$$ba002000$$ENDHEX$$colegiado, Y - Colegio de acogida
		string mat
		n_col = RightA('0000000' + this.getitemstring(1, 'n_colegiado'), 7)
		mat = event csd_matricula_colegio()
		this.setitem(1, 'n_acreditado', mat + n_col + data)
		
	CASE 'alta_baja'//Descomentado el 20/08/07
		// Abrimos la ventana donde pondr$$HEX1$$e100$$ENDHEX$$n la fecha y el tipo
		openwithparm(w_colegiados_alta_baja, data)
		ret = message.stringparm
		// Si han cancelado no modificamos el check
		if ret = "-1" then return 2

		// Actualizamos los datos introducidos en la ventana y a$$HEX1$$f100$$ENDHEX$$adimos en el historico
		if data = 'S' then
			 long num
			if g_colegiados_consulta.tipo='A2' then
				select count(*) into :num from csi_facturas_emitidas where id_persona=:id_colegiado and pagado='N';
				if num>0 then
					datos.id_col=id_colegiado
					OpenWithParm(w_colegiados_facturas_no_pagadas,datos)
				end if
			end if
			event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, 'DETALLE', 'f_alta', row)
			event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, 'DETALLE', 't_alta', row)			
			this.setitem(1,'f_alta',g_colegiados_consulta.fecha)
			this.setitem(1,'t_alta',g_colegiados_consulta.tipo)
		else
			event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, 'DETALLE', 'f_baja', row)
			event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, 'DETALLE', 't_baja', row)						
			this.setitem(1,'f_baja',g_colegiados_consulta.fecha)
			this.setitem(1,'t_baja',g_colegiados_consulta.tipo)
			if ret <> "-1" then
				if g_borrar_conceptos_facturables = 'S' then
       				event csd_baja_conceptos_remesables(id_colegiado)
			      	 idw_colegiados_conceptos_domiciliables.retrieve(id_colegiado)
			end if
			end if
			if idw_colegiados_conceptos_domiciliables.rowcount()>0 then
				if idw_colegiados_conceptos_domiciliables.getitemdecimal(1,'compute_1')> 0 then
					messagebox(g_titulo,g_idioma.of_getmsg('colegiados.con_domiciliables_may0',"Existen conceptos domiciliables con importes mayores a 0 que son suceptibles a facturaci$$HEX1$$f300$$ENDHEX$$n"))
				end if
			end if
		end if

		// Insertamos el registro en "altas, bajas y situaciones"
		idw_colegiados_altas_bajas_situaciones.triggerevent("pfc_addrow")
		fila =idw_colegiados_altas_bajas_situaciones.rowcount()
		idw_colegiados_altas_bajas_situaciones.setitem(fila,'id_colegiado',this.getitemstring(this.getrow(),'id_colegiado'))
		idw_colegiados_altas_bajas_situaciones.setitem(fila,'codigo',g_colegiados_consulta.tipo)
		idw_colegiados_altas_bajas_situaciones.setitem(fila,'campo_modificado',dwo.name)
		idw_colegiados_altas_bajas_situaciones.setitem(fila,'fecha',g_colegiados_consulta.fecha)
		if data = 'S' then idw_colegiados_altas_bajas_situaciones.setitem(fila,'alta','S')
		if data = 'N' then idw_colegiados_altas_bajas_situaciones.setitem(fila,'baja','S')
		
		// Grabamos todos los cambios
		// Comentado por Eloy SCP-210. Sustituimos los updates por el csd_grabar que realiza las validaciones
			//this.post update()
			//idw_colegiados_modificacion_datos.update()		
	    idw_colegiados_altas_bajas_situaciones.update()
		
		parent.post event csd_grabar()
		idw_colegiados_altas_bajas_situaciones.sort()

END CHOOSE

return retorno

end event

event dw_1::doubleclicked;call super::doubleclicked;string obser,aviso, dom_activo, pob_activa, dom_fiscal_activo, pob_fiscal_activa, data_item
g_busqueda.solo_despliega_texto=False

CHOOSE CASE dwo.name
	CASE 't_observaciones'
		g_busqueda.titulo="Observaciones"
		obser    =this.GetItemString(row, 'observaciones')
		data_item=this.getitemstring(row, 'observaciones') // para control modificaciones
		openwithparm(w_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
			if not isnull(obser) then 
			   if data_item<>obser then dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, "DETALLE", 'observaciones', row)
				dw_1.SetItem(row,'observaciones',obser)
			end if 	
		end if

	CASE 't_aviso'
		g_busqueda.titulo="Aviso"
		aviso    =this.GetItemString(row, 'aviso')
		data_item=this.getitemstring(row, 'aviso') // para control modificaciones
		openwithparm(w_observaciones, aviso)
		if Message.Stringparm <> '-1' then 
			aviso = Message.Stringparm
			if not isnull(aviso) then 
				if data_item<>aviso then dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, "DETALLE", 'aviso', row)
				dw_1.SetItem(row,'aviso',aviso)
		   end if
		end if
		
	CASE 't_dom_activo'
		g_busqueda.titulo="Domicilio Activo"
		g_busqueda.solo_despliega_texto=True
		dom_activo=this.GetItemString(row, 'domicilio_activo')
		data_item =this.getitemstring(row, 'domicilio_activo') // para control modificaciones
		openwithparm(w_observaciones, dom_activo)
		if Message.Stringparm <> '-1' then
			dom_activo = Message.Stringparm
			if not isnull(dom_activo) then 
				if data_item<>dom_activo then	dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, "DETALLE", 'domicilio_activo', row)
				dw_1.SetItem(row,'domicilio_activo',dom_activo)
			end if	
		end if

	CASE 't_pob_activa'
		g_busqueda.titulo="Poblacion Activa"
		g_busqueda.solo_despliega_texto=True
		pob_activa=this.GetItemString(row, 'poblacion_activa')
		data_item =this.getitemstring(row, 'poblacion_activa') // para control modificaciones
		openwithparm(w_observaciones, pob_activa)
		if Message.Stringparm <> '-1' then
			pob_activa = Message.Stringparm
			if not isnull(pob_activa) then 
				if data_item<>pob_activa then dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, "DETALLE", 'poblacion_activa', row)
				dw_1.SetItem(row,'poblacion_activa',pob_activa)
			end if	
		end if

	CASE 't_dom_fiscal_activo'
		g_busqueda.titulo="Domicilio Fiscal Activo"
		g_busqueda.solo_despliega_texto=True
		dom_fiscal_activo=this.GetItemString(row, 'domicilio_activo_fiscal')
		data_item        =this.getitemstring(row, 'domicilio_activo_fiscal') // para control modificaciones
		openwithparm(w_observaciones, dom_fiscal_activo)
		if Message.Stringparm <> '-1' then
			dom_fiscal_activo = Message.Stringparm
			if not isnull(dom_fiscal_activo) then 
				if data_item<>dom_fiscal_activo then dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, "DETALLE", 'domicilio_activo_fiscal', row)
				dw_1.SetItem(row,'domicilio_activo_fiscal',dom_fiscal_activo)
			end if
		end if

	CASE 't_pob_fiscal_activa'
		g_busqueda.titulo="Poblacion Fiscal Activa"
		g_busqueda.solo_despliega_texto=True
		pob_fiscal_activa=this.GetItemString(row, 'poblacion_activa_fiscal')
		data_item        =this.getitemstring(row, 'poblacion_activa_fiscal') // para control modificaciones
		openwithparm(w_observaciones, pob_fiscal_activa)
		if Message.Stringparm <> '-1' then
			pob_fiscal_activa = Message.Stringparm
			if not isnull(pob_fiscal_activa) then 
				if data_item<>pob_fiscal_activa then dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, "DETALLE", 'poblacion_activa_fiscal', row)
				dw_1.SetItem(row,'poblacion_activa_fiscal',pob_fiscal_activa)
			end if
		end if

END CHOOSE
end event

event dw_1::itemerror;call super::itemerror;return 1
end event

event dw_1::retrieveend;call super::retrieveend;SetPointer(Arrow!)
idw_colegiados_modificacion_datos.Retrieve( dw_1.GetItemString(1,'id_colegiado'), '01' )
if f_comprueba_incidencias(1,dw_1) then
end if
if f_comprueba_incidencias(1,dw_1) then
	dw_1.object.b_incidencias.Background.color=f_color_rojo()
else
	dw_1.object.b_incidencias.Background.color=f_color_windows_buttonface()
end if		


end event

event dw_1::buttonclicked;call super::buttonclicked;string id_soc, id_regsoc


CHOOSE CASE dwo.name
	CASE 'b_incidencias'
		g_incidencias.tipo='C'
		g_incidencias.id=dw_1.getitemstring(1,'id_colegiado')
		message.stringparm=''
		open(w_incidencias)
		if message.stringparm='S' then
			dw_1.object.b_incidencias.Background.color=f_color_rojo()
		else
			dw_1.object.b_incidencias.Background.color=f_color_windows_buttonface()
		end if			
		
	CASE 'b_regsoc'
		parent.event pfc_save()
		id_soc=this.GetItemString(row,'id_colegiado')
		
		select id_regsoc into :id_regsoc from regsoc where id_colegiado_sociedad=:id_soc;
	
		if not(f_es_vacio(id_regsoc)) then	
			g_regsoc_consulta = id_regsoc
			Message.StringParm=''
		else
			gb_nuevo=true
			Message.StringParm='RECUPERAR'
		end if
		OpenSheet(g_detalle_regsoc,'w_regsoc_detalle',w_aplic_frame,0,original!)

	case 'b_cartas_defuncion'

		st_colegiado_defuncion st_col
		
		st_col.f_defuncion= dw_1.GetItemDateTime(dw_1.GetRow(),'f_baja')
		st_col.n_colegiado=dw_1.GetItemString(dw_1.GetRow(),'n_colegiado')
		OpenWithParm(w_cartas_defuncion_generacion,st_col)

END CHOOSE

end event

type tab_1 from tab within w_colegiados_detalle
integer x = 50
integer y = 872
integer width = 4379
integer height = 1228
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean multiline = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_19 tabpage_19
tabpage_6 tabpage_6
tabpage_10 tabpage_10
tabpage_25 tabpage_25
tabpage_7 tabpage_7
tabpage_5 tabpage_5
tabpage_2 tabpage_2
tabpage_8 tabpage_8
tabpage_21 tabpage_21
tabpage_22 tabpage_22
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_19=create tabpage_19
this.tabpage_6=create tabpage_6
this.tabpage_10=create tabpage_10
this.tabpage_25=create tabpage_25
this.tabpage_7=create tabpage_7
this.tabpage_5=create tabpage_5
this.tabpage_2=create tabpage_2
this.tabpage_8=create tabpage_8
this.tabpage_21=create tabpage_21
this.tabpage_22=create tabpage_22
this.Control[]={this.tabpage_1,&
this.tabpage_19,&
this.tabpage_6,&
this.tabpage_10,&
this.tabpage_25,&
this.tabpage_7,&
this.tabpage_5,&
this.tabpage_2,&
this.tabpage_8,&
this.tabpage_21,&
this.tabpage_22}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_19)
destroy(this.tabpage_6)
destroy(this.tabpage_10)
destroy(this.tabpage_25)
destroy(this.tabpage_7)
destroy(this.tabpage_5)
destroy(this.tabpage_2)
destroy(this.tabpage_8)
destroy(this.tabpage_21)
destroy(this.tabpage_22)
end on

event selectionchanged;//int    indice_tab
//string nombre_tab, dw_activa_en_tab
//
//indice_tab = this.selectedtab
//nombre_tab = this.classname()
//
//messagebox(' en selection ',indice_tab)
//messagebox(' en selection ',nombre_tab)
//
//dw_activa_en_tab = this.name
end event

type tabpage_1 from userobject within tab_1
string tag = "texto=colegiados.domicilios"
integer x = 18
integer y = 208
integer width = 4343
integer height = 1004
long backcolor = 79741120
string text = "Domicilios"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Library!"
long picturemaskcolor = 536870912
dw_colegiados_domicilios dw_colegiados_domicilios
end type

on tabpage_1.create
this.dw_colegiados_domicilios=create dw_colegiados_domicilios
this.Control[]={this.dw_colegiados_domicilios}
end on

on tabpage_1.destroy
destroy(this.dw_colegiados_domicilios)
end on

type dw_colegiados_domicilios from u_dw within tabpage_1
event csd_actualiza_dom_pob_activa ( long row )
event csd_actualiza_dom_pob_fiscal_activa ( long row )
event csd_actualiza_poblaciones_activas ( )
integer x = 18
integer y = 20
integer width = 4306
integer height = 940
integer taborder = 11
string dataobject = "d_colegiados_domicilios"
boolean hscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event csd_actualiza_dom_pob_activa(long row);string dom_activo, pob_activa
long linea

dom_activo= f_obtener_domicilio_activo(dw_colegiados_domicilios.getitemstring(row,'tipo_via'), &
													dw_colegiados_domicilios.getitemstring(row,'nom_via'))
													
pob_activa= f_obtener_poblacion_activa(dw_colegiados_domicilios.getitemstring(row,'cod_pob'), & 
													dw_colegiados_domicilios.getitemstring(row,'cod_prov'), &
													dw_colegiados_domicilios.getitemstring(row,'cp'))

dw_1.setitem(1,'domicilio_activo',dom_activo)
dw_1.setitem(1,'poblacion_activa',pob_activa)
	


end event

event csd_actualiza_dom_pob_fiscal_activa(long row);string dom_fiscal_activo, pob_fiscal_activa

dom_fiscal_activo= f_obtener_domicilio_activo(dw_colegiados_domicilios.getitemstring(row,'tipo_via'), &
													dw_colegiados_domicilios.getitemstring(row,'nom_via'))
													
pob_fiscal_activa= f_obtener_poblacion_activa(dw_colegiados_domicilios.getitemstring(row,'cod_pob'), & 
													dw_colegiados_domicilios.getitemstring(row,'cod_prov'), &
													dw_colegiados_domicilios.getitemstring(row,'cp'))

dw_1.setitem(1,'domicilio_activo_fiscal',dom_fiscal_activo)
dw_1.setitem(1,'poblacion_activa_fiscal',pob_fiscal_activa)


end event

event csd_actualiza_poblaciones_activas();integer i
string a
for i=1 to idw_colegiados_domicilios.rowcount() 
	a=this.getitemstring(i,'comercial')
	if this.getitemstring(i,'comercial')='S' then
		this.event csd_actualiza_dom_pob_activa(i)
	end if
	a=this.getitemstring(i,'fiscal')
	if this.getitemstring(i,'fiscal')='S' then
		this.event csd_actualiza_dom_pob_fiscal_activa(i)
	end if	
next 


end event

event pfc_addrow;call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
dw_colegiados_domicilios.setitem(dw_colegiados_domicilios.getrow(), 'id_domicilio', f_siguiente_numero('DOMICILIOS', 10))
//donde "n" es un entero que indicamla longitud en caracteres del contador
return 1
end event

event pfc_insertrow;call super::pfc_insertrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
dw_colegiados_domicilios.setitem(dw_colegiados_domicilios.getrow(), 'id_domicilio', f_siguiente_numero('DOMICILIOS', 10))
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

event itemchanged;call super::itemchanged;string  cod_postal, cod_provincia, cod_pais
string  dom_activo, pob_activa
string  cod_via, nom_via, cod_pob, cod_prov
integer f

// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)

CHOOSE CASE dwo.name
	//cuando se cambia la poblaci$$HEX1$$f300$$ENDHEX$$n actualizo los c$$HEX1$$f300$$ENDHEX$$digos de: cp, provincia y pais
	CASE 'cod_pob' 
		// MODIFICADO RICARDO 03-10-30
		IF f_es_vacio(data) then
			this.setitem(row,'cp','')
			this.setitem(row,'cod_prov','')
			this.setitem(row,'pais','')
		else
			cod_provincia=f_devuelve_cod_provincia(data)
			cod_postal=f_devuelve_cod_postal(data)
			cod_pais=f_devuelve_cod_pais(data)
			
			this.setitem(row,'cod_pob',data)
			this.setitem(row,'cp',cod_postal)
			this.setitem(row,'cod_prov',cod_provincia)
			this.setitem(row,'pais',cod_pais)
		end if
		// Si Correspondencia es 'S' se actualiza Dom. y pobl activa
		if dw_colegiados_domicilios.getitemstring(row,'comercial') = 'S' then 
			dw_colegiados_domicilios.event csd_actualiza_dom_pob_activa(row)
		end if	
		// Si Fiscal es 'S' se actualiza Dom. y pobl fiscal activa
		if dw_colegiados_domicilios.getitemstring(row,'fiscal') = 'S' then 
			dw_colegiados_domicilios.event csd_actualiza_dom_pob_fiscal_activa(row)
		end if	
		// fin MODIFICADO RICARDO 03-10-30
		
		
	CASE 'comercial' // Correspondencia 
		if data = 'S' then 
			// Se actualizan domicilio y poblacion activa
			dw_colegiados_domicilios.event csd_actualiza_dom_pob_activa(row)
			// Se Inicializan los demas campos de correspondencia a "N"
			for f=1 to dw_colegiados_domicilios.rowcount()
				 if f <> row then setitem(f,'comercial',"N")
			next	
		else
			// Se inicializa los campos de domicilio y poblacion activa
			dw_1.setitem(1,'domicilio_activo',"")
			dw_1.setitem(1,'poblacion_activa',"")
		end if	

	CASE 'fiscal'
		if data = 'S' then 
			// Se actualizan domicilio y poblacion fiscal activa
			dw_colegiados_domicilios.event csd_actualiza_dom_pob_fiscal_activa(row)
			// Se inicializan los demas registros a "N"
			for f=1 to dw_colegiados_domicilios.rowcount()
				 if f <> row then setitem(f,'fiscal',"N")
			next	
		else
			// Se inicializa los campos de domicilio y poblacion fiscal activa
			dw_1.setitem(1,'domicilio_activo_fiscal',"")
			dw_1.setitem(1,'poblacion_activa_fiscal',"")
		end if	
		
	CASE 'tipo_via'
		// Si Correspondencia es 'S' se actualiza Dom. y pobl activa
		if dw_colegiados_domicilios.getitemstring(row,'comercial') = 'S' then 
			dw_colegiados_domicilios.event csd_actualiza_dom_pob_activa(row)
		end if	
		// Si Fiscal es 'S' se actualiza Dom. y pobl fiscal activa
		if dw_colegiados_domicilios.getitemstring(row,'fiscal') = 'S' then 
			dw_colegiados_domicilios.event csd_actualiza_dom_pob_fiscal_activa(row)
		end if	
		
	CASE 'nom_via', 'cp', 'cod_prov'
		// Si Correspondencia es 'S' se actualiza Dom. y pobl activa
		if idw_colegiados_domicilios.getitemstring(row,'comercial') = 'S' then 
		//	messagebox(' comercial es S ',row)
			dw_colegiados_domicilios.event csd_actualiza_dom_pob_activa(row)
		end if	
		// Si Fiscal es 'S' se actualiza Dom. y pobl fiscal activa
		if dw_colegiados_domicilios.getitemstring(row,'fiscal') = 'S' then 
			dw_colegiados_domicilios.event csd_actualiza_dom_pob_fiscal_activa(row)
		end if	
End choose	

end event

event buttonclicked;string pob, cod_provincia,cod_postal,cod_pais
CHOOSE CASE dwo.name
	CASE 'b_poblacion'
		
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(row,'cod_pob',pob)
		
		cod_provincia=f_devuelve_cod_provincia(pob)
		cod_postal=f_devuelve_cod_postal(pob)
		cod_pais=f_devuelve_cod_pais(pob)
		
		this.setitem(row,'cp',cod_postal)
		this.setitem(row,'cod_prov',cod_provincia)
		this.setitem(row,'pais',cod_pais)
		// Si Correspondencia es 'S' se actualiza Dom. y pobl activa
		if dw_colegiados_domicilios.getitemstring(row,'comercial') = 'S' then 
			dw_colegiados_domicilios.event csd_actualiza_dom_pob_activa(row)
		end if	
		// Si Fiscal es 'S' se actualiza Dom. y pobl fiscal activa
		if dw_colegiados_domicilios.getitemstring(row,'fiscal') = 'S' then 
			dw_colegiados_domicilios.event csd_actualiza_dom_pob_fiscal_activa(row)
		end if			
		
	CASE ELSE
END CHOOSE

end event

type tabpage_19 from userobject within tab_1
event create ( )
event destroy ( )
string tag = "texto=colegiados.telefonos"
integer x = 18
integer y = 208
integer width = 4343
integer height = 1004
long backcolor = 79741120
string text = "Tel$$HEX1$$e900$$ENDHEX$$fonos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom020!"
long picturemaskcolor = 536870912
dw_colegiados_telefonos dw_colegiados_telefonos
end type

on tabpage_19.create
this.dw_colegiados_telefonos=create dw_colegiados_telefonos
this.Control[]={this.dw_colegiados_telefonos}
end on

on tabpage_19.destroy
destroy(this.dw_colegiados_telefonos)
end on

type dw_colegiados_telefonos from u_dw within tabpage_19
integer x = 18
integer y = 20
integer width = 4306
integer height = 940
integer taborder = 20
string dataobject = "d_colegiados_telefonos"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)

end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_delete.enabled = false
am_dw.m_table.m_addrow.enabled = false
am_dw.m_table.m_insert.enabled = false
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;// se controla que sea una sola fila
if dw_colegiados_telefonos.rowcount() >= 1 then 
	messagebox(g_titulo,g_idioma.of_getmsg('coelgiados.anyadir_registros',"No se pueden a$$HEX1$$f100$$ENDHEX$$adir m$$HEX1$$e100$$ENDHEX$$s registros"))
	return 0
else 
	return 1
end if
end event

type tabpage_6 from userobject within tab_1
string tag = "texto=sociedades"
integer x = 18
integer y = 208
integer width = 4343
integer height = 1004
long backcolor = 79741120
string text = "Sociedades"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom073!"
long picturemaskcolor = 536870912
dw_colegiados_sociedades dw_colegiados_sociedades
dw_colegiados_personas dw_colegiados_personas
end type

on tabpage_6.create
this.dw_colegiados_sociedades=create dw_colegiados_sociedades
this.dw_colegiados_personas=create dw_colegiados_personas
this.Control[]={this.dw_colegiados_sociedades,&
this.dw_colegiados_personas}
end on

on tabpage_6.destroy
destroy(this.dw_colegiados_sociedades)
destroy(this.dw_colegiados_personas)
end on

type dw_colegiados_sociedades from u_dw within tabpage_6
integer x = 18
integer y = 20
integer width = 4306
integer height = 940
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_colegiados_sociedades"
boolean ib_rmbmenu = false
end type

event doubleclicked;call super::doubleclicked;if row <> 0 then
	g_colegiados_consulta.id_colegiado = this.getitemstring(row,'id_col_soc')			
	//	message.stringparm = "w_colegiados_detalle"
	//	w_aplic_frame.postevent("csd_colegiadosdetalle")
	
	dw_1.Postevent("csd_retrieve")
end if


end event

type dw_colegiados_personas from u_dw within tabpage_6
event type integer csd_controla_duplicados ( long row,  string data,  string tipo )
integer x = 18
integer y = 20
integer width = 4306
integer height = 940
integer taborder = 11
string dataobject = "d_colegiados_personas"
end type

event type integer csd_controla_duplicados(long row, string data, string tipo);integer f

CHOOSE CASE tipo
	CASE 'COL'
		// Se controlan los colegiados duplicados
		for f=1 to this.rowcount()
			if f <> row and this.getitemstring(f,'n_col') = data then
				MessageBox(g_titulo,g_idioma.of_getmsg('colegiados.duplicar_colegiados','No se pueden duplicar colegiados.'))
				this.setitem(row,'n_col','')
				this.setitem(row,'id_col_per','')
				this.setitem(row,'porcent',0)
				return 1
			end if
		next
	CASE 'CLI'
		// Se controlan los clientes duplicados
		for f=1 to this.rowcount()
			if f <> row and this.getitemstring(f,'n_cli') = data then
				MessageBox(g_titulo,g_idioma.of_getmsg('colegiados.duplicar_clientes','No se pueden duplicar clientes.'))
				this.setitem(row,'n_cli','')
				this.setitem(row,'id_cli_per','')
				this.setitem(row,'porcent',0)
				return 1
			end if
		next
END CHOOSE

return 0

end event

event buttonclicked;call super::buttonclicked;string id_persona

CHOOSE CASE dwo.name
	CASE 'b_1'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_persona=f_busqueda_colegiados()
		
		if not f_es_vacio(id_persona) then
			this.setitem(row, 'id_col_per',id_persona)
			this.setitem(row, 'n_col',f_colegiado_n_col(id_persona))
			this.setitem(row, 'nombre',f_colegiado_apellido(id_persona))
			this.setitem(row, 'nif',f_devuelve_nif(id_persona))
			this.setitem(row, 'porcent',0)
			this.setitem(row, 'id_cli_per', '')
			this.setitem(row, 'n_cli', '')			
			this.event csd_controla_duplicados(row, f_colegiado_n_col(id_persona), 'COL')
		end if

		// Modificacion de Datos
		dw_1.event csd_modificacion_datos(dw_1.getitemstring(1,'id_colegiado'), this, Upper(Parent.text), 'n_col', row)
		
	CASE 'b_2'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
		g_busqueda.dw="d_lista_busqueda_clientes"		
		id_persona=f_busqueda_clientes_exp()
		
		if not f_es_vacio(id_persona) then
			this.setitem(row, 'id_cli_per',id_persona)
			this.setitem(row, 'n_cli',f_clientes_n_cliente(id_persona))
			this.setitem(row, 'nombre',f_dame_cliente(id_persona))
			this.setitem(row, 'nif',f_dame_nif(id_persona))
			this.setitem(row, 'porcent',0)
			this.setitem(row, 'id_col_per', '')
			this.setitem(row, 'n_col', '')
			this.event csd_controla_duplicados(row, f_clientes_n_cliente(id_persona), 'CLI')
		end if

		// Modificacion de Datos
		dw_1.event csd_modificacion_datos(dw_1.getitemstring(1,'id_colegiado'), this, Upper(Parent.text), 'n_cli', row)
END CHOOSE

end event

event doubleclicked;if row <> 0 and i_permitir_dobleclick=true  then
	g_colegiados_consulta.id_colegiado = this.getitemstring(row,'id_col_per')	
	//	message.stringparm = "w_colegiados_detalle"
	//	w_aplic_frame.postevent("csd_colegiadosdetalle")

	dw_1.Postevent("csd_retrieve")
end if
end event

event itemchanged;call super::itemchanged;string  id_col, col, cli, id_cli
integer f

// Modificacion de Datos
dw_1.event csd_modificacion_datos(dw_1.getitemstring(1,'id_colegiado'), this, Upper(Parent.text), dwo.name, row)

CHOOSE CASE this.getcolumnname()
	CASE 'n_col'
		col=this.gettext()
		id_col=''
		select id_colegiado into :id_col from colegiados where n_colegiado = :col;
		if not f_es_vacio(id_col) then 
			i_permitir_dobleclick=true
			this.setitem(this.getrow(),'id_col_per', id_col)
			this.event csd_controla_duplicados(row,f_colegiado_n_col(this.getitemstring(this.getrow(),'id_col_per')), 'COL')
		else
			this.setitem(this.getrow(),'id_col_per', '')
			this.setitem(this.getrow(),'n_col', '')
		end if
			
	CASE 'n_cli'
		cli=this.gettext()
		id_cli=''
		select id_cliente into :id_cli from clientes where n_cliente = :cli;
		if not f_es_vacio(id_cli) then 
//			i_permitir_dobleclick=true
			this.setitem(this.getrow(),'id_cli_per', id_cli)
			this.event csd_controla_duplicados(row,f_clientes_n_cliente(this.getitemstring(this.getrow(),'id_cli_per')), 'CLI')
		else
			this.setitem(this.getrow(),'id_cli_per', '')
			this.setitem(this.getrow(),'n_cli', '')
		end if
END CHOOSE

end event

event retrieveend;call super::retrieveend;integer i
for i=1 to this.rowcount()
	this.setitem(i,'n_col', f_colegiado_n_col(this.getitemstring(i,'id_col_per')))
	this.setitem(i,'n_cli', f_clientes_n_cliente(this.getitemstring(i,'id_cli_per')))
next	
this.ResetUpdate()

end event

event itemfocuschanged;call super::itemfocuschanged;return 1
end event

event itemerror;call super::itemerror;return 1
end event

event pfc_addrow;call super::pfc_addrow;//this.setitem(getrow(), 'id_col_per', 'X')
//this.setitem(getrow(), 'id_cli_per', 'X')
this.setitem(this.getrow(), 'id_regsoc_socio', f_siguiente_numero('ID_REGSOC_SOCIO', 10))

return 1

end event

event pfc_insertrow;call super::pfc_insertrow;//this.setitem(getrow(), 'id_col_per', 'X')
//this.setitem(getrow(), 'id_cli_per', 'X')
this.setitem(this.getrow(), 'id_regsoc_socio', f_siguiente_numero('ID_REGSOC_SOCIO', 10))

return 1

end event

event pfc_preupdate;call super::pfc_preupdate;// Si no se ha introducido ni el cliente ni el colegiado ponemos X
// para que la clave no tenga valor nulo
int i, f

//for i=1 to this.rowcount()
//	if f_es_vacio(this.getitemstring(i,'id_col_per')) then this.setitem(i,'id_col_per','X')
//	if f_es_vacio(this.getitemstring(i,'id_cli_per')) then this.setitem(i,'id_cli_per','X')
//next

// Si el id_cliente y id_colegiado son vacios se debe borrar la fila insertada
for f=this.rowcount() to 1 step -1
	if this.getitemstring(f,'id_col_per')='' and	this.getitemstring(f,'id_cli_per')='' then 
		this.deleterow(f)
	end if
next

return 1

end event

type tabpage_10 from userobject within tab_1
string tag = "texto=colegiados.fotos_firmas"
integer x = 18
integer y = 208
integer width = 4343
integer height = 1004
long backcolor = 79741120
string text = "Fotos , Firmas"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Picture1!"
long picturemaskcolor = 536870912
st_2 st_2
st_1 st_1
p_firma_colegiado p_firma_colegiado
dw_fotos_firmas dw_fotos_firmas
p_foto_colegiado p_foto_colegiado
end type

on tabpage_10.create
this.st_2=create st_2
this.st_1=create st_1
this.p_firma_colegiado=create p_firma_colegiado
this.dw_fotos_firmas=create dw_fotos_firmas
this.p_foto_colegiado=create p_foto_colegiado
this.Control[]={this.st_2,&
this.st_1,&
this.p_firma_colegiado,&
this.dw_fotos_firmas,&
this.p_foto_colegiado}
end on

on tabpage_10.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.p_firma_colegiado)
destroy(this.dw_fotos_firmas)
destroy(this.p_foto_colegiado)
end on

type st_2 from statictext within tabpage_10
integer x = 3045
integer y = 52
integer width = 155
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Foto:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_10
integer x = 2176
integer y = 52
integer width = 187
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Firma:"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_firma_colegiado from picture within tabpage_10
integer x = 1847
integer y = 128
integer width = 841
integer height = 692
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event doubleclicked;openwithparm(w_zoom_foto,this.picturename)
end event

type dw_fotos_firmas from u_dw within tabpage_10
event csd_abrir_fichero ( integer fila )
integer x = 18
integer y = 20
integer width = 1787
integer height = 940
integer taborder = 11
string dataobject = "d_colegiados_fotos_firmas"
end type

event csd_abrir_fichero(integer fila);string  fichero, ruta, data_item
long    cancelar
integer numfilas

if not f_es_vacio(This.getitemstring(fila,'ruta')) then data_item=This.getitemstring(fila,'ruta')

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio_original
cambia_directorio = create n_cst_filesrvwin32
directorio_original = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02

cancelar=getfileopenname('Selecci$$HEX1$$f300$$ENDHEX$$n del fichero',ruta, fichero,"Im$$HEX1$$e100$$ENDHEX$$genes de fotos y firmas")

// Paco 29/05//2007. Si el fichero existe retornamos
if fileexists(g_directorio_fotos+fichero) and cancelar = 1 then
	if messagebox(g_titulo,g_idioma.of_getmsg('existe_fichero', 'El fichero ya existe, $$HEX1$$bf00$$ENDHEX$$desea sobreescribir?'), Question!, YesNo!) <> 1 then
		cambia_directorio.of_changedirectory(directorio_original)
		destroy cambia_directorio
		return
	end if
end if

if cancelar = 1 then
   	if data_item<>fichero then dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), 'ruta', this.getrow()	)
	This.SetItem(fila,'ruta',fichero)
end if

// Se copia el archivo al directorio de "Fotos"
f_copiarfichero(ruta,g_directorio_fotos+fichero)

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio_original)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02

end event

event retrieveend;call super::retrieveend;string foto,activa,tipo
int i

p_foto_colegiado.picturename=""
p_firma_colegiado.picturename=""

//Muestro la foto y firma deseadas del colegiado

if rowcount > 0 then
	for i=1 to rowcount() 
		activa=this.getitemstring(i,'activa')
		tipo=this.getitemstring(i,'tipo')
		if activa='S' then 
			foto=this.getitemstring(i,'ruta')
			if tipo='O' then
				p_foto_colegiado.picturename=g_directorio_fotos+foto
			else
				p_firma_colegiado.picturename=g_directorio_fotos+foto
			end if
		end if
	next
end if
end event

event type long pfc_insertrow();call super::pfc_insertrow;if ancestorreturnvalue >= 1 then 
	this.SetItem(ancestorreturnvalue,'id_foto_firma',f_siguiente_numero('FOTOS_FIRMAS',10))
	this.SetItem(ancestorreturnvalue,'activa','N')
end if
// this.Post Event csd_abrir_fichero(this.getrow()) // aqui se dispara el evento abrir file
return ancestorreturnvalue
end event

event type long pfc_addrow();call super::pfc_addrow;if ancestorreturnvalue >= 1 then 
	this.SetItem(ancestorreturnvalue,'id_foto_firma',f_siguiente_numero('FOTOS_FIRMAS',10))
	this.SetItem(ancestorreturnvalue,'activa','N')
end if
// this.Post Event csd_abrir_fichero(this.getrow()) // aqui se dispara el evento abrir file
return ancestorreturnvalue
end event

event itemchanged;integer i
string  tipo_imagen, activa

// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)

// Como m$$HEX1$$e100$$ENDHEX$$ximo una foto y una firma pueden estar activas simult$$HEX1$$e100$$ENDHEX$$neamente
if dwo.name = 'activa' then
	tipo_imagen=this.getitemstring(this.getrow(),'tipo')		
	if string(data)='S' then//Verifico si antes de activar la imagen se ha selecionado su tipo
		if f_es_vacio(tipo_imagen) then
			messagebox(g_titulo,g_idioma.of_getmsg('colegiados.activar_imagen',"Antes de activar una imagen debe indicar su tipo"))
			return 2
		end if
		For i = 1 to this.rowcount()
			if ((row <> i) and (this.getitemstring(i,'tipo')=tipo_imagen)) then this.setitem(i,'activa','N')
		next
		if tipo_imagen='O' then 
			p_foto_colegiado.picturename = g_directorio_fotos+this.getitemstring(row,'ruta')
		else 
			p_firma_colegiado.picturename = g_directorio_fotos+this.getitemstring(row,'ruta')
		end if
	else
		if tipo_imagen='O' then 
			p_foto_colegiado.picturename=""
		else 
			p_firma_colegiado.picturename=""
		end if
	end if
end if
if dwo.name = 'tipo' then
	activa=this.getitemstring(this.getrow(),'activa')		
	if activa='S' then
		messagebox(g_titulo,g_idioma.of_getmsg('colegiados.cambiar_imagen_activa',"No puede cambiar el tipo de una imagen activa"))
		return 2
	end if
	
	// Se verifica que no haya dos (2) tipos de foto o firma iguales
	// Solamente habra un tipo de cada formato grafico
	// NOV- 01 PARA INCLUIR SOCIEDADES, S$$HEX2$$cd002000$$ENDHEX$$SE PERMITE >1 FOTOS/FIRMA POR COLEG.
	/*For i = 1 to this.rowcount()
		if ((row <> i) and (this.getitemstring(i,'tipo')=data)) then 
			messagebox(g_titulo,'No se pueden asignar tipos de Fotos $$HEX2$$f3002000$$ENDHEX$$Firmas duplicados')
			this.setitem(this.getrow(),'tipo','')	
			return 1
		end if
	next*/
	
end if

end event

event type integer pfc_predeleterow();call super::pfc_predeleterow;long i
string tipo_foto
integer fila_a_borrar

//Al borrar una imagen compruebo si hay alguna otra activa del mismo tipo y la muestro

fila_a_borrar=this.getrow()
tipo_foto=this.getitemstring(fila_a_borrar,'tipo')
if (tipo_foto='O') then
	p_foto_colegiado.picturename = ''
else 
	p_firma_colegiado.picturename = ''
end if
For i = 1 to this.rowcount()
	if ((this.getitemstring(i,'activa')='S') and (this.getitemstring(i,'tipo')=tipo_foto) and (i <> fila_a_borrar)) then
		if (tipo_foto='O') then
			p_foto_colegiado.picturename = g_directorio_fotos+this.getitemstring(i,'ruta')
		else 
			p_firma_colegiado.picturename = g_directorio_fotos+this.getitemstring(i,'ruta')
		end if
	end if
next
return 1
end event

event type integer pfc_preinsertrow();call super::pfc_preinsertrow;//// se controla que sea una sola fila
//if dw_fotos_firmas.rowcount() >= 2 then 
//	messagebox(g_titulo,"No se pueden a$$HEX1$$f100$$ENDHEX$$adir m$$HEX1$$e100$$ENDHEX$$s registros")	
//	return 0
//else 
//	return 1
//end if
return ancestorreturnvalue
end event

event buttonclicked;call super::buttonclicked;// Se abre la ventana explorador para buscar el fichero
this.Event csd_abrir_fichero(this.getrow()) // aqui se ejecuta el evento abrir file
	

end event

event itemerror;call super::itemerror;return 1
end event

type p_foto_colegiado from picture within tabpage_10
integer x = 2702
integer y = 128
integer width = 841
integer height = 692
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event doubleclicked;openwithparm(w_zoom_foto,this.picturename)

end event

type tabpage_25 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 4343
integer height = 1004
long backcolor = 79741120
string text = "Anexos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Copy!"
long picturemaskcolor = 536870912
dw_anexos dw_anexos
end type

on tabpage_25.create
this.dw_anexos=create dw_anexos
this.Control[]={this.dw_anexos}
end on

on tabpage_25.destroy
destroy(this.dw_anexos)
end on

type dw_anexos from u_dw within tabpage_25
integer x = 18
integer y = 20
integer width = 4306
integer height = 940
integer taborder = 50
string dataobject = "d_colegiados_anexos"
end type

event buttonclicked;call super::buttonclicked;string cod
int i
st_w_escanear lst_datos_escanear
string ls_ruta_relativa_documentos,ruta_fichero,id_colegiado
string ls_ruta_doc,ls_nom_doc,ls_ruta_guardar,ls_ruta_dest
int li_valor
n_file_dialogs lnv_file_dialog
boolean lb_existe
double tamano

id_colegiado=dw_1.GetItemString(dw_1.GetRow(),'id_colegiado')

ls_ruta_relativa_documentos=id_colegiado
//ls_ruta_guardar=g_directorio_colegiados_anexos+ls_ruta_relativa_documentos+"\"


ls_ruta_guardar=f_obtener_ruta_documentos("colegiados","",id_colegiado,"",5)


choose case dwo.name
	case 'b_escanear'
		lst_datos_escanear.nombre_fichero=''
		lst_datos_escanear.ruta=ls_ruta_guardar
			
		openWithParm(w_escaner_principal,lst_datos_escanear)
		
		ls_nom_doc=Message.StringParm
		
	//	if f_es_vacio(ruta_fichero) then return
	//	ls_nom_doc=MidA(ruta_fichero,lastpos(ruta_fichero,'\') + 1,LenA(ruta_fichero))
		tamano = Ceiling(gnv_fichero.of_GetFileSize(ls_ruta_guardar+ls_nom_doc) / 1024)
		
		this.setitem(row,'nombre_fichero',ls_nom_doc) 
		this.setitem(row,'tamanyo',tamano)

		//this.setitem(row,'ruta_fichero',ls_ruta_relativa_documentos)
		
	case 'b_seleccionar_fichero'				
		//Comprobamos que existe g_directorio_documentos_fases+g_anyo_numeracion ya que sino, no podemos crear
		//un directorio por debajo de este
		
		lb_existe=gnv_fichero.of_directoryexists(ls_ruta_guardar)
		
		if not lb_existe then
			li_valor=gnv_fichero.of_createdirectory(ls_ruta_guardar)
		end if
		
		if li_valor=-1 then 
			Messagebox('Error','Error al crear el directorio donde se copiar$$HEX1$$e100$$ENDHEX$$n los documentos asociados a este colegiado.'&
			+cr+'Aseg$$HEX1$$fa00$$ENDHEX$$rese de que el directorio '+g_directorio_colegiados_anexos+' existe.',StopSign!)
			return
	   end if
		//Seleccionamos el fichero y lo copiamos al directorio adecuado
		//S$$HEX1$$f300$$ENDHEX$$lo permitimos seleccionar un fichero
		lnv_file_dialog.ib_allowmultiselect = false

		li_valor = lnv_file_dialog.of_getopenfilename("Seleccionar Documento", ls_ruta_doc, ls_nom_doc,"", "Todos los archivos,*.*,")
		if li_valor = 1 then
			//creamos el directorio y copiamos el fichero
			ls_ruta_dest=ls_ruta_guardar+ls_nom_doc
			gnv_fichero.of_createdirectory(ls_ruta_guardar)
			gnv_fichero.of_filecopy(ls_ruta_doc + "\" + ls_nom_doc, ls_ruta_dest, FALSE)
			//guardamos el nombre del fichero
			tamano = Ceiling(gnv_fichero.of_GetFileSize(ls_ruta_dest) / 1024)
			
			this.setitem(row,'nombre_fichero',ls_nom_doc) 
			this.setitem(row,'tamanyo',tamano)

		end if 
	case else
end choose

end event

event doubleclicked;call super::doubleclicked;string ls_nombre_fichero,id_doc_modulo,id_modulo
string ls_ruta

if row<=0 then return
ls_nombre_fichero=this.GetItemString(row,'nombre_fichero')
if f_es_vacio(ls_nombre_fichero) then return
//Abrimos el fichero con su programa asociado en Windows
//id_doc_modulo=this.GetItemString(this.GetRow(),'id_documento_modulo')

id_modulo=this.GetItemString(this.GetRow(),'id_modulo')



ls_ruta=f_obtener_ruta_documentos("COLEGIADOS","",id_modulo,"",5)


f_abrir_fichero(ls_ruta,ls_nombre_fichero,"")

end event

event pfc_addrow;call super::pfc_addrow;this.SetItem(ancestorreturnvalue,'id_documento_modulo',f_siguiente_numero('ID_DOC_MODULO',20))
this.SetItem(ancestorreturnvalue,'id_tipo_modulo','COLEGIADOS')
this.SetItem(ancestorreturnvalue,'id_modulo',dw_1.GetItemString(dw_1.GetRow(),'id_colegiado'))
this.SetItem(ancestorreturnvalue,'id_usuario',g_usuario)
this.SetItem(ancestorreturnvalue,'visible_web','N')

return ancestorreturnvalue
end event

event pfc_predeleterow;call super::pfc_predeleterow;string ruta

if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Se va a borrar el fichero definitivamente. $$HEX1$$bf00$$ENDHEX$$Est$$HEX2$$e1002000$$ENDHEX$$seguro?",Question!,YesNo!)=1 then
	//ruta=g_directorio_colegiados_anexos+dw_1.GetItemString(dw_1.GetRow(),'id_colegiado')+"\"
	ruta=f_obtener_ruta_documentos("COLEGIADOS","",dw_1.GetItemString(dw_1.GetRow(),'id_colegiado'),"",5)
	FileDelete(ruta+this.GetItemString(this.GetRow(),'nombre_fichero'))
	return CONTINUE_ACTION
else
	return PREVENT_ACTION
end if
end event

event constructor;call super::constructor;DataWindowChild dddw
this.GetChild('cod_tipo_documento',dddw)
	
	// Obtenemos la transaccion para la DropDown
dddw.SetTransObject(SQLCA)
		
// Actualiza el campo con Drop Down
dddw.Retrieve()

dddw.SetFilter("colegiados='S'")
dddw.Filter()
end event

type tabpage_7 from userobject within tab_1
string tag = "texto=colegiados.perfil_prof"
integer x = 18
integer y = 208
integer width = 4343
integer height = 1004
long backcolor = 79741120
string text = "Perfil Profesional"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom089!"
long picturemaskcolor = 536870912
tab_4 tab_4
end type

on tabpage_7.create
this.tab_4=create tab_4
this.Control[]={this.tab_4}
end on

on tabpage_7.destroy
destroy(this.tab_4)
end on

type tab_4 from tab within tabpage_7
event create ( )
event destroy ( )
integer x = 9
integer y = 12
integer width = 4338
integer height = 960
integer taborder = 10
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
tabpage_3 tabpage_3
tabpage_14 tabpage_14
tabpage_15 tabpage_15
tabpage_17 tabpage_17
tabpage_27 tabpage_27
tabpage_28 tabpage_28
end type

on tab_4.create
this.tabpage_3=create tabpage_3
this.tabpage_14=create tabpage_14
this.tabpage_15=create tabpage_15
this.tabpage_17=create tabpage_17
this.tabpage_27=create tabpage_27
this.tabpage_28=create tabpage_28
this.Control[]={this.tabpage_3,&
this.tabpage_14,&
this.tabpage_15,&
this.tabpage_17,&
this.tabpage_27,&
this.tabpage_28}
end on

on tab_4.destroy
destroy(this.tabpage_3)
destroy(this.tabpage_14)
destroy(this.tabpage_15)
destroy(this.tabpage_17)
destroy(this.tabpage_27)
destroy(this.tabpage_28)
end on

type tabpage_3 from userobject within tab_4
event create ( )
event destroy ( )
string tag = "texto=colegiados.agrupaciones"
integer x = 18
integer y = 100
integer width = 4302
integer height = 844
long backcolor = 79741120
string text = "Agrupaciones"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_colegiados_agrupaciones dw_colegiados_agrupaciones
end type

on tabpage_3.create
this.dw_colegiados_agrupaciones=create dw_colegiados_agrupaciones
this.Control[]={this.dw_colegiados_agrupaciones}
end on

on tabpage_3.destroy
destroy(this.dw_colegiados_agrupaciones)
end on

type dw_colegiados_agrupaciones from u_dw within tabpage_3
integer x = 18
integer y = 20
integer width = 4256
integer height = 804
integer taborder = 21
string dataobject = "d_colegiados_agrupaciones"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event pfc_addrow;call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.getrow(), 'id_agrupacion', f_siguiente_numero('AGRUPACIONES', 10))
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

event pfc_insertrow;call super::pfc_insertrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.getrow(), 'id_agrupacion', f_siguiente_numero('AGRUPACIONES', 10))
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

event itemchanged;call super::itemchanged;integer  f
string   cod_agrupa, fecha_inic, fecha_fin

// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)

choose case dwo.name
case 'agrupacion', 'f_inicio', 'f_fin'
	// se asigna a variables de comparacion
	choose case dwo.name
	case 'agrupacion'
		cod_agrupa=data
		fecha_inic=string(this.getitemdatetime(row,'f_inicio'),"dd/mm/yyyy")
		fecha_fin =string(this.getitemdatetime(row,'f_fin'),"dd/mm/yyyy")
	case 'f_inicio'
		cod_agrupa=this.getitemstring(row,'agrupacion') 		
		fecha_inic=data
		fecha_fin =string(this.getitemdatetime(row,'f_fin'),"dd/mm/yyyy")
	case 'f_fin'
		cod_agrupa=this.getitemstring(row,'agrupacion') 		
		fecha_inic=string(this.getitemdatetime(row,'f_inicio'),"dd/mm/yyyy")
		fecha_fin =data		
	end choose
	
	// Se recorre toda la DW para los chequeos
	for f=1 to this.rowcount()
		if f <> row and this.getitemstring(f,'agrupacion') = cod_agrupa then
			// Se chequea que no tengan la misma fecha inicio
			if string(this.getitemdatetime(f,'f_inicio'),"dd/mm/yyyy")=fecha_inic then
				MessageBox(g_titulo,g_idioma.of_getmsg('colegiados.agrupaciones_f_ini_iguales','No se pueden duplicar agrupaciones con fecha de inicio iguales.'))
				return 1
			end if

			// Se chequea que la fecha inicio no este dentro del rango de otra
			if date(this.getitemdatetime(f,'f_inicio'))< date(fecha_inic) and &
				date(this.getitemdatetime(f,'f_fin'))   >=date(fecha_inic) then
				MessageBox(g_titulo,g_idioma.of_getmsg('colegiados.agrupaciones_f_ini_rango','No se pueden duplicar agrupaciones con fecha de inicio dentro del rango de otra.'))
				return 1
			end if
			
			// Se chequea que la fecha fin no este dentro del rango de otra
			if date(this.getitemdatetime(f,'f_inicio'))< date(fecha_fin) and &
				date(this.getitemdatetime(f,'f_fin'))   >=date(fecha_fin) then
				MessageBox(g_titulo,g_idioma.of_getmsg('colegiados.agrupaciones_f_fin_rango','No se pueden duplicar agrupaciones con fecha final dentro del rango de otra.'))
				return 1
			end if
		end if
	next

	// Se chequea que la fecha inicio no sea mayor que de inicio
   if dwo.name = 'f_inicio' then
		if date(data) > date(this.getitemdatetime(row,'f_fin')) then
			MessageBox(g_titulo,g_idioma.of_getmsg('colegiados.f_ini_fin','La fecha inicio no puede ser mayor que la fecha final.'))
			return 1
		end if
   end if
	
   if dwo.name = 'f_fin' then
	// Se chequea que la fecha fin no sea menor que de inicio
		if date(data) < date(this.getitemdatetime(row,'f_inicio')) then
			MessageBox(g_titulo,g_idioma.of_getmsg('colegiados.f_ini_fin_menor','La fecha final no puede ser menor que la fecha de inicio.'))
			return 1
		end if
	end if

end choose

end event

event itemerror;call super::itemerror;return 1
end event

type tabpage_14 from userobject within tab_4
event create ( )
event destroy ( )
string tag = "texto=colegiados.orientaciones_profesionales"
integer x = 18
integer y = 100
integer width = 4302
integer height = 844
long backcolor = 79741120
string text = "Orientaciones Profesionales"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_colegiado_orientaciones_profesionales dw_colegiado_orientaciones_profesionales
end type

on tabpage_14.create
this.dw_colegiado_orientaciones_profesionales=create dw_colegiado_orientaciones_profesionales
this.Control[]={this.dw_colegiado_orientaciones_profesionales}
end on

on tabpage_14.destroy
destroy(this.dw_colegiado_orientaciones_profesionales)
end on

type dw_colegiado_orientaciones_profesionales from u_dw within tabpage_14
integer x = 18
integer y = 20
integer width = 4256
integer height = 804
integer taborder = 10
string dataobject = "d_colegiados_orientaciones_profesionales"
boolean hscrollbar = true
end type

event pfc_addrow;call super::pfc_addrow;//Introducimos en el campo clave el valor obtenido desde el contador.
this.SetItem(this.GetRow(),'id_orientaciones',f_siguiente_numero('ORIENT_PROFESIONALES',10))
return 1

end event

event itemchanged;call super::itemchanged;integer f

// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)

choose case dwo.name
	case 'orientacion_profesional'
	for f=1 to this.rowcount()
		if f <> row and this.getitemstring(f,'orientacion_profesional') = data then
			this.setitem(row,'orientacion_profesional','')
			MessageBox(g_titulo,'No se pueden duplicar descripciones de orientaciones.')
			return 1
		end if
	next
end choose

end event

event itemerror;call super::itemerror;return 1
end event

type tabpage_15 from userobject within tab_4
event create ( )
event destroy ( )
string tag = "texto=colegiados.sit_prof_incom"
integer x = 18
integer y = 100
integer width = 4302
integer height = 844
long backcolor = 79741120
string text = "Situaciones profesionales/Incompatibilidades"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_colegiados_situacion_incompabilidad dw_colegiados_situacion_incompabilidad
end type

on tabpage_15.create
this.dw_colegiados_situacion_incompabilidad=create dw_colegiados_situacion_incompabilidad
this.Control[]={this.dw_colegiados_situacion_incompabilidad}
end on

on tabpage_15.destroy
destroy(this.dw_colegiados_situacion_incompabilidad)
end on

type dw_colegiados_situacion_incompabilidad from u_dw within tabpage_15
event csd_oculta_cabecera_incompa ( )
integer x = 18
integer y = 20
integer width = 4256
integer height = 804
integer taborder = 21
string dataobject = "d_colegiados_situacion_incompabilidad"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event csd_oculta_cabecera_incompa();integer cf

this.object.tipo_incompatibilidad_t.visible = False
//this.object.organismo_t.visible             = False
this.object.cod_pob_t.visible               = False
this.object.observaciones_t.visible         = False

// Se recorren todos las incompatibilidades para act/desact la cabecera
for cf = 1 to this.rowcount()
	if this.getitemstring(cf,'incompatibilidad') = 'S' then
		this.object.tipo_incompatibilidad_t.visible = True
		this.object.organismo_t.visible             = True
		this.object.cod_pob_t.visible               = True
		this.object.observaciones_t.visible         = True
	end if
end for				


end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event pfc_insertrow;call super::pfc_insertrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.getrow(), 'id_incompatibilidad', f_siguiente_numero('INCOMPATIBILIDADES', 10))
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

event pfc_addrow;call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.getrow(), 'id_incompatibilidad', f_siguiente_numero('INCOMPATIBILIDADES', 10))
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

event doubleclicked;call super::doubleclicked;string obser_incompa
g_busqueda.solo_despliega_texto=False

CHOOSE CASE dwo.name
	CASE 't_observaciones'
		g_busqueda.titulo="Observaciones"
		obser_incompa = this.GetItemString(row, 'observaciones')
		openwithparm(w_observaciones, obser_incompa)
		if Message.Stringparm <> '-1' then
			obser_incompa = Message.Stringparm
			if not isnull(obser_incompa) then this.SetItem(row,'observaciones',obser_incompa)
		end if
END CHOOSE
end event

event itemchanged;call super::itemchanged;integer cf, F
string  cod_situacion, fecha_inic, fecha_fin

// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)

choose case dwo.name 
case 'tipo_situacion', 'fecha_inicio', 'f_fin'
	// se asigna a variables de comparacion
	choose case dwo.name
	case 'tipo_situacion'
		cod_situacion=data
		fecha_inic=string(this.getitemdatetime(row,'fecha_inicio'),"dd/mm/yyyy")
		fecha_fin =string(this.getitemdatetime(row,'fecha_fin'),"dd/mm/yyyy")
	case 'fecha_inicio'
		cod_situacion=this.getitemstring(row,'tipo_situacion') 		
		fecha_inic=data
		fecha_fin =string(this.getitemdatetime(row,'fecha_fin'),"dd/mm/yyyy")
	case 'fecha_fin'
		cod_situacion=this.getitemstring(row,'tipo_situacion') 		
		fecha_inic=string(this.getitemdatetime(row,'fecha_inicio'),"dd/mm/yyyy")
		fecha_fin =data		
	end choose
	
//	// Se recorre toda la DW para los chequeos
//	for f=1 to this.rowcount()
//		if f <> row and this.getitemstring(f,'tipo_situacion') = cod_situacion then
//			// Se chequea que no tengan la misma fecha inicio
//			if string(this.getitemdatetime(f,'fecha_inicio'),"dd/mm/yyyy")=fecha_inic then
//				MessageBox(g_titulo,'No se pueden duplicar tipos de situaciones con fecha de inicio iguales.')
//				return 1
//			end if
//
//			// Se chequea que la fecha inicio no este dentro del rango de otra
//			if date(this.getitemdatetime(f,'fecha_inicio'))< date(fecha_inic) and &
//				date(this.getitemdatetime(f,'fecha_fin'))   >=date(fecha_inic) then
//				MessageBox(g_titulo,'No se pueden duplicar tipos de situaciones con fecha de inicio dentro del rango de otra.')
//				return 1
//			end if
//			
//			// Se chequea que la fecha inicio no este dentro del rango de otra
//			if date(this.getitemdatetime(f,'fecha_inicio'))< date(fecha_fin) and &
//				date(this.getitemdatetime(f,'fecha_fin'))   >=date(fecha_fin) then
//				MessageBox(g_titulo,'No se pueden duplicar tipos de situaciones con fecha final dentro del rango de otra.')
//				return 1
//			end if
//		end if
//	next

	// Se chequea que la fecha inicio no sea mayor que de inicio
   if dwo.name = 'fecha_inicio' then
		if date(data) > date(this.getitemdatetime(row,'fecha_fin')) then
			MessageBox(g_titulo,g_idioma.of_getmsg('colegiados.f_ini_fin','La fecha inicio no puede ser mayor que la fecha final.'))
			return 1
		end if
   end if

	// Se chequea que la fecha fin no sea menor que de inicio
   if dwo.name = 'fecha_fin' then
		if date(data) < date(this.getitemdatetime(row,'fecha_inicio')) then
			MessageBox(g_titulo,g_idioma.of_getmsg('colegiados.f_ini_fin_menor','La fecha final no puede ser menor que la fecha de inicio.'))
			return 1
		end if
	end if

case 'incompatibilidad'
		this.object.tipo_incompatibilidad_t.visible = False
//		this.object.organismo_t.visible             = False
		this.object.cod_pob_t.visible               = False
		this.object.observaciones_t.visible         = False

		// Se recorren todos las incompatibilidades para act/desact la cabecera
		for cf = 1 to this.rowcount()
			if (getitemstring(cf,'incompatibilidad') = 'S' and cf <> row) or data = 'S' then
				this.object.tipo_incompatibilidad_t.visible = True
				this.object.organismo_t.visible             = True
				this.object.cod_pob_t.visible               = True
				this.object.observaciones_t.visible         = True
			end if
		end for				

end choose

end event

event retrieveend;call super::retrieveend;// Se oculta/despliega la cabecera de DW de Incompatibilidades 
this.event csd_oculta_cabecera_incompa()
end event

event itemerror;call super::itemerror;return 1
end event

event buttonclicked;string pob
CHOOSE CASE dwo.name
	CASE 'b_poblacion'
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(row,'cod_pob',pob)
	CASE ELSE
END CHOOSE

end event

type tabpage_17 from userobject within tab_4
string tag = "texto=colegiados.tit_consejo"
integer x = 18
integer y = 100
integer width = 4302
integer height = 844
long backcolor = 79741120
string text = "+datos t$$HEX1$$ed00$$ENDHEX$$tulaci$$HEX1$$f300$$ENDHEX$$n/consejo"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_titulacion dw_titulacion
end type

on tabpage_17.create
this.dw_titulacion=create dw_titulacion
this.Control[]={this.dw_titulacion}
end on

on tabpage_17.destroy
destroy(this.dw_titulacion)
end on

type dw_titulacion from u_dw within tabpage_17
integer x = 18
integer y = 20
integer width = 4256
integer height = 744
integer taborder = 11
string dataobject = "d_colegiados_titulacion"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

type tabpage_27 from userobject within tab_4
string tag = "texto=colegiados.tit_habilitante"
integer x = 18
integer y = 100
integer width = 4302
integer height = 844
long backcolor = 79741120
string text = "Titulaciones habilitante"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_titulacion_hab dw_titulacion_hab
end type

on tabpage_27.create
this.dw_titulacion_hab=create dw_titulacion_hab
this.Control[]={this.dw_titulacion_hab}
end on

on tabpage_27.destroy
destroy(this.dw_titulacion_hab)
end on

type dw_titulacion_hab from u_csd_dw within tabpage_27
integer x = 64
integer y = 44
integer width = 4137
integer height = 692
integer taborder = 11
string dataobject = "d_colegiado_titulaciones"
end type

event pfc_addrow;call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.getrow(), 'id_titulacion', f_siguiente_numero('ID_TITULACION', 10))
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

event pfc_insertrow;call super::pfc_insertrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.getrow(), 'id_titulacion', f_siguiente_numero('ID_TITULACION', 10))
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)
end event

type tabpage_28 from userobject within tab_4
integer x = 18
integer y = 100
integer width = 4302
integer height = 844
long backcolor = 79741120
string text = "Inhabilitaciones"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_inhabilitaciones dw_inhabilitaciones
end type

on tabpage_28.create
this.dw_inhabilitaciones=create dw_inhabilitaciones
this.Control[]={this.dw_inhabilitaciones}
end on

on tabpage_28.destroy
destroy(this.dw_inhabilitaciones)
end on

type dw_inhabilitaciones from u_csd_dw within tabpage_28
integer x = 41
integer y = 32
integer width = 4197
integer height = 776
integer taborder = 11
string dataobject = "d_colegiados_inhabilitaciones"
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)


end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)
end event

event pfc_addrow;call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.getrow(), 'id_inhabilitacion', f_siguiente_numero('ID_INHABILITACION', 10))
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

type tabpage_5 from userobject within tab_1
string tag = "texto=colegiados.contabilidad"
integer x = 18
integer y = 208
integer width = 4343
integer height = 1004
long backcolor = 79741120
string text = "Contabilidad"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "FormatDollar!"
long picturemaskcolor = 536870912
tab_2 tab_2
end type

on tabpage_5.create
this.tab_2=create tab_2
this.Control[]={this.tab_2}
end on

on tabpage_5.destroy
destroy(this.tab_2)
end on

type tab_2 from tab within tabpage_5
string tag = "texto=colegiados.contabilidad"
integer x = 105
integer y = 52
integer width = 4270
integer height = 876
integer taborder = 40
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
boolean pictureonright = true
integer selectedtab = 1
tabpage_12 tabpage_12
tabpage_13 tabpage_13
tabpage_18 tabpage_18
tabpage_23 tabpage_23
tabpage_29 tabpage_29
end type

on tab_2.create
this.tabpage_12=create tabpage_12
this.tabpage_13=create tabpage_13
this.tabpage_18=create tabpage_18
this.tabpage_23=create tabpage_23
this.tabpage_29=create tabpage_29
this.Control[]={this.tabpage_12,&
this.tabpage_13,&
this.tabpage_18,&
this.tabpage_23,&
this.tabpage_29}
end on

on tab_2.destroy
destroy(this.tabpage_12)
destroy(this.tabpage_13)
destroy(this.tabpage_18)
destroy(this.tabpage_23)
destroy(this.tabpage_29)
end on

type tabpage_12 from userobject within tab_2
event create ( )
event destroy ( )
string tag = "texto=colegiados.datos_generales_pagos"
integer x = 18
integer y = 100
integer width = 4233
integer height = 760
long backcolor = 79741120
string text = "Datos generales, pagos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_colegiados_datos_fiscales dw_colegiados_datos_fiscales
dw_conceptos_remesables dw_conceptos_remesables
end type

on tabpage_12.create
this.dw_colegiados_datos_fiscales=create dw_colegiados_datos_fiscales
this.dw_conceptos_remesables=create dw_conceptos_remesables
this.Control[]={this.dw_colegiados_datos_fiscales,&
this.dw_conceptos_remesables}
end on

on tabpage_12.destroy
destroy(this.dw_colegiados_datos_fiscales)
destroy(this.dw_conceptos_remesables)
end on

type dw_colegiados_datos_fiscales from u_dw within tabpage_12
event csd_asignar_cc ( string ls_cuenta_anterior,  string ls_colegiado,  string ls_data )
integer x = 18
integer y = 20
integer width = 3799
integer height = 388
integer taborder = 21
string dataobject = "d_colegiados_datos_fiscales"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event csd_asignar_cc(string ls_cuenta_anterior, string ls_colegiado, string ls_data);string   ls_cuenta_contable, cuenta, nif, titulo, n_col, cod_colegio
st_cuenta cuenta_struct


//Cuenta nueva
if ls_cuenta_anterior = "" or isnull(ls_cuenta_anterior) then
	// Comprobamos si la cuenta exist$$HEX1$$ed00$$ENDHEX$$a para evitar error de duplicado
	SELECT cuenta INTO :cuenta from cuentas where cuenta like :ls_data USING bd_ejercicio;
	if bd_ejercicio.SQLNrows = 0 then
		// En el campo resumen de la cuenta contable ponemos el NIF del colegiado
		nif = f_devuelve_nif(ls_colegiado)
		titulo = f_colegiado_apellido(ls_colegiado)
		n_col = f_colegiado_n_col(ls_colegiado)
		cod_colegio = f_colegiado_cod_colegio(ls_colegiado)

		cuenta_struct.cuenta 		= ls_data
		cuenta_struct.titulo 		= titulo
		cuenta_struct.resumen 		= nif
		cuenta_struct.final 			= 'D'
		cuenta_struct.empresa		= 'S'
		cuenta_struct.debe			= 0
		cuenta_struct.haber			= 0
		cuenta_struct.saldo			= 0
		cuenta_struct.presupuesto	= 0
		cuenta_struct.id_col			= ls_colegiado
		cuenta_struct.s1				= 0
		cuenta_struct.s2				= 0
		cuenta_struct.s3				= 0
		cuenta_struct.ica				= 0
		cuenta_struct.otros			= 0	
		if not f_es_vacio(f_cuenta_pgc_sincronizada(cuenta_struct, 'N')) then 
			setnull(cuenta) //-> Con esto saca el mesaje de abajo
			if f_es_vacio(cuenta) then
				MessageBox(g_titulo, 'Ha habido problemas creando la cuenta contable del colegiado ' + n_col)
				rollback using bd_ejercicio;
			else
				commit using bd_ejercicio;
			end if
		end if		
	else
		MessageBox(g_titulo, 'La Cuenta Contable ingresada, Ya Existe...')
		this.setitem(this.getrow(),"cuenta_contable"," ")
		return 
	end if
	
end if


//Cuenta existente
if ls_cuenta_anterior <> ls_data or ls_cuenta_anterior <> "" or not isnull(ls_cuenta_anterior) then

	if  MessageBox(g_titulo, "Seguro de Modificar la Cuenta del Colegiado?",Exclamation!,YesNo! ) <> 1 then
		this.setitem(this.getrow(),"cuenta_contable",ls_cuenta_anterior)
		return 
	else
		// Comprobamos si la cuenta exist$$HEX1$$ed00$$ENDHEX$$a para evitar error de duplicado
		SELECT cuenta INTO :cuenta from cuentas where cuenta like :ls_data USING bd_ejercicio;
		
		if bd_ejercicio.SQLNrows = 0 then
			// En el campo resumen de la cuenta contable ponemos el NIF del colegiado
			nif = f_devuelve_nif(ls_colegiado)
			titulo = f_colegiado_apellido(ls_colegiado)
			n_col = f_colegiado_n_col(ls_colegiado)
			cod_colegio = f_colegiado_cod_colegio(ls_colegiado)
			
			if isnull(ls_data) then ls_data =""
			
			cuenta_struct.cuenta 		= ls_data
			cuenta_struct.titulo 		= titulo
			cuenta_struct.resumen 		= nif
			cuenta_struct.final 			= 'D'
			cuenta_struct.empresa		= 'S'
			cuenta_struct.debe			= 0
			cuenta_struct.haber			= 0
			cuenta_struct.saldo			= 0
			cuenta_struct.presupuesto	= 0
			cuenta_struct.id_col			= ls_colegiado
			cuenta_struct.s1				= 0
			cuenta_struct.s2				= 0
			cuenta_struct.s3				= 0
			cuenta_struct.ica				= 0
			cuenta_struct.otros			= 0	
			
			if ls_data = "" then
				cuenta_struct.cuenta 		= ls_cuenta_anterior
				f_borrar_cuenta_pgc_sincronizada(cuenta_struct,'N') //Borrar la cuenta de la base de datos de contabilidad
				if bd_ejercicio.SQLCode = 0 then
					commit using bd_ejercicio;
				end if
				
			elseif not f_es_vacio(f_cuenta_pgc_sincronizada(cuenta_struct, 'N')) then 
				setnull(cuenta) //-> Con esto saca el mesaje de abajo
				if f_es_vacio(cuenta) then
					MessageBox(g_titulo, 'Ha habido problemas creando la cuenta contable del colegiado ' + n_col)
					rollback using bd_ejercicio;
				else
					commit using bd_ejercicio;
				end if
			end if		
		else
			MessageBox(g_titulo, 'La Cuenta Contable ingresada, Ya Existe...')
			this.setitem(this.getrow(),"cuenta_contable"," ")
			return 
		end if
	end if
end if
			
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;// se controla que sea una sola fila
if dw_colegiados_datos_fiscales.rowcount() >= 1 then 
	messagebox(g_titulo,g_idioma.of_getmsg('colegiados.anyadir_registros',"No se pueden a$$HEX1$$f100$$ENDHEX$$adir m$$HEX1$$e100$$ENDHEX$$s registros"))	
	return 0
else 
	return 1
end if
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_delete.enabled = false
//am_dw.m_table.m_addrow.enabled = false
am_dw.m_table.m_insert.enabled = false
end event

event itemchanged;call super::itemchanged;string   ls_cuenta_contable, cuenta, nif, titulo, n_col, cod_colegio, ls_colegiado, ls_cuenta_anterior
st_cuenta cuenta_struct

ls_colegiado = this.getitemstring(this.getrow(),'id_colegiado')

if  dwo.name = "check_cc" then

			if  data ='S' then
				ls_cuenta_anterior = this.getitemstring(this.getrow(),"cuenta_contable")
				if ls_cuenta_anterior <> "" or not isnull(ls_cuenta_anterior) then
					if  MessageBox(g_titulo, "Seguro de Modificar la Cuenta del Colegiado?",Exclamation!,YesNo! ) = 1 then
						ls_cuenta_contable = f_dame_cuenta_col(ls_colegiado,'P')
						this.setitem(row,"cuenta_contable", ls_cuenta_contable)
					else
						this.setitem(row,"cuenta_contable",ls_cuenta_anterior)	
						this.setitem(row,"check_cc",'N')
						return 1
					end if
				else
					ls_cuenta_contable = f_dame_cuenta_col(ls_colegiado,'P')
					this.setitem(row,"cuenta_contable", ls_cuenta_contable)
				end if
			end if
	
elseif dwo.name = "cuenta_contable" then
	
			ls_cuenta_anterior = this.getitemstring(row,"cuenta_contable")
			this.event csd_asignar_cc(ls_cuenta_anterior, ls_colegiado, data)
	
//			//Cuenta nueva
//			if ls_cuenta_anterior = "" or isnull(ls_cuenta_anterior) then
//				data =""
//				// Comprobamos si la cuenta exist$$HEX1$$ed00$$ENDHEX$$a para evitar error de duplicado
//				SELECT cuenta INTO :cuenta from cuentas where cuenta like :data USING bd_ejercicio;
//				if bd_ejercicio.SQLNrows = 0 then
//					// En el campo resumen de la cuenta contable ponemos el NIF del colegiado
//					nif = f_devuelve_nif(ls_colegiado)
//					titulo = f_colegiado_apellido(ls_colegiado)
//					n_col = f_colegiado_n_col(ls_colegiado)
//					cod_colegio = f_colegiado_cod_colegio(ls_colegiado)
//			
//					cuenta_struct.cuenta 		= data
//					cuenta_struct.titulo 		= titulo
//					cuenta_struct.resumen 		= nif
//					cuenta_struct.final 			= 'D'
//					cuenta_struct.empresa		= 'S'
//					cuenta_struct.debe			= 0
//					cuenta_struct.haber			= 0
//					cuenta_struct.saldo			= 0
//					cuenta_struct.presupuesto	= 0
//					cuenta_struct.id_col			= ls_colegiado
//					cuenta_struct.s1				= 0
//					cuenta_struct.s2				= 0
//					cuenta_struct.s3				= 0
//					cuenta_struct.ica				= 0
//					cuenta_struct.otros			= 0	
//					if not f_es_vacio(f_cuenta_pgc_sincronizada(cuenta_struct, 'N')) then 
//						setnull(cuenta) //-> Con esto saca el mesaje de abajo
//						if f_es_vacio(cuenta) then
//							MessageBox(g_titulo, 'Ha habido problemas creando la cuenta contable del colegiado ' + n_col)
//							rollback using bd_ejercicio;
//						else
//							commit using bd_ejercicio;
//						end if
//					end if		
//				else
//					MessageBox(g_titulo, 'La Cuenta Contable ingresada, Ya Existe...')
//					this.setitem(row,"cuenta_contable",ls_cuenta_anterior)
//					return 1
//				end if
//				
//			end if
//	
//	
//			//Cuenta existente
//			if ls_cuenta_anterior <> data then
//		
//				if  MessageBox(g_titulo, "Seguro de Modificar la Cuenta del Colegiado?",Exclamation!,YesNo! ) <> 1 then
//					this.setitem(row,"cuenta_contable",ls_cuenta_anterior)
//					return 1
//				else
//					// Comprobamos si la cuenta exist$$HEX1$$ed00$$ENDHEX$$a para evitar error de duplicado
//					SELECT cuenta INTO :cuenta from cuentas where cuenta like :data USING bd_ejercicio;
//					if bd_ejercicio.SQLNrows = 0 then
//						// En el campo resumen de la cuenta contable ponemos el NIF del colegiado
//						nif = f_devuelve_nif(ls_colegiado)
//						titulo = f_colegiado_apellido(ls_colegiado)
//						n_col = f_colegiado_n_col(ls_colegiado)
//						cod_colegio = f_colegiado_cod_colegio(ls_colegiado)
//				
//						cuenta_struct.cuenta 		= data
//						cuenta_struct.titulo 		= titulo
//						cuenta_struct.resumen 		= nif
//						cuenta_struct.final 			= 'D'
//						cuenta_struct.empresa		= 'S'
//						cuenta_struct.debe			= 0
//						cuenta_struct.haber			= 0
//						cuenta_struct.saldo			= 0
//						cuenta_struct.presupuesto	= 0
//						cuenta_struct.id_col			= ls_colegiado
//						cuenta_struct.s1				= 0
//						cuenta_struct.s2				= 0
//						cuenta_struct.s3				= 0
//						cuenta_struct.ica				= 0
//						cuenta_struct.otros			= 0	
//						if not f_es_vacio(f_cuenta_pgc_sincronizada(cuenta_struct, 'N')) then 
//							setnull(cuenta) //-> Con esto saca el mesaje de abajo
//							if f_es_vacio(cuenta) then
//								MessageBox(g_titulo, 'Ha habido problemas creando la cuenta contable del colegiado ' + n_col)
//								rollback using bd_ejercicio;
//							else
//								commit using bd_ejercicio;
//							end if
//						end if		
//					else
//						MessageBox(g_titulo, 'La Cuenta Contable ingresada, Ya Existe...')
//						this.setitem(row,"cuenta_contable",ls_cuenta_anterior)
//						return 1
//					end if
//				end if
//			end if
//			


end if
	
// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)

end event

event retrieveend;call super::retrieveend;// MODIFICADO RICARDO 2005-03-15
if f_es_vacio(this.GetItemString(rowcount, 'embargo_hacienda')) then
	// Si no tiene valor, ponemos el valor por defecto
	this.SetItem(rowcount, 'embargo_hacienda', 'N')
	this.update()
end if
// FIN MODIFICADO RICARDO 2005-03-15
end event

event itemerror;call super::itemerror;return 1
end event

type dw_conceptos_remesables from u_dw within tabpage_12
integer x = 14
integer y = 424
integer width = 3858
integer height = 304
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_colegiados_conceptos_remesables"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_delete.enabled = false
am_dw.m_table.m_addrow.enabled = false
am_dw.m_table.m_insert.enabled = false
end event

event itemchanged;call super::itemchanged;string cod,des

//Modificaci$$HEX1$$f300$$ENDHEX$$n datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)

choose case dwo.name
	case 'datos_bancarios'
		cod=LeftA(data,4)
		select csi_bancos_maestro.descripcion into :des from csi_bancos_maestro where csi_bancos_maestro.cod = :cod;
		this.setitem(row,'nombre_banco',des)
	CASE 'datos_bancarios_iban'
		if (gnv_control_cuentas_bancarias.of_comprobar_iban(data) or f_es_vacio(data)) then 
			if not f_es_vacio(data) then
				data = gnv_control_cuentas_bancarias.of_eliminar_caracteres_no_validos(data)
				this.setitem(this.getrow(), 'datos_bancarios_iban', data)
			end if	
			this.setitem(row, 'cuenta_correcta', 1)
			this.object.t_iban.text = gnv_control_cuentas_bancarias.of_obtener_iban_escrito(data)
		else 
			this.object.t_iban.text = ''
			this.setitem(row, 'cuenta_correcta', 0)
			messagebox(g_titulo, 'El n$$HEX1$$fa00$$ENDHEX$$mero de cuenta no es v$$HEX1$$e100$$ENDHEX$$lido', stopsign!)
		end if	
		
	CASE 'bic'
		if not (gnv_control_cuentas_bancarias.of_comprobar_bic(data)) then 	messagebox(g_titulo, 'Revise el c$$HEX1$$f300$$ENDHEX$$digo BIC de la cuenta de cobros. No dispone de un formato correcto' + cr + 'Debe disponer de un c$$HEX1$$f300$$ENDHEX$$digo alfanum$$HEX1$$e900$$ENDHEX$$rico de ocho u once caracteres', StopSign!)
		
case else
end choose


end event

event buttonclicked;call super::buttonclicked;string ls_cuenta

choose case dwo.name
	case 'b_comprobacion_cuentas'

		ls_cuenta = this.getitemstring( row, 'datos_bancarios_iban')
		
		openwithparm(w_comprobacion_cuentas_bancarias, ls_cuenta )
		
		ls_cuenta = message.stringparm
		
		if not f_es_vacio(ls_cuenta) then
			this.setitem(row, 'datos_bancarios_iban', ls_cuenta)
			this.setitem(row, 'cuenta_correcta', 1)
			this.object.t_iban.text = gnv_control_cuentas_bancarias.of_obtener_iban_escrito(ls_cuenta)
		end if
		
end choose
end event

event losefocus;call super::losefocus;string ls_iban

this.accepttext()

if this.getcolumnname( ) = 'datos_bancarios_iban' then
	ls_iban = this.getitemstring( this.getrow(), 'datos_bancarios_iban')
	
	if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban) or f_es_vacio(ls_iban) then 
		this.setitem(this.getrow(), 'cuenta_correcta', 1)	
	else
		this.setitem(this.getrow(), 'cuenta_correcta', 0)	
	end if		

end if
end event

event itemfocuschanged;call super::itemfocuschanged;string ls_iban

if dwo.name = 'datos_bancarios_iban' then
		
	ls_iban = this.getitemstring( row, 'datos_bancarios_iban')
	
	if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban) or f_es_vacio(ls_iban) then 
		this.setitem(row, 'cuenta_correcta', 1)	
	else
		this.setitem(row, 'cuenta_correcta', 0)	
	end if		
end if		
end event

event retrieveend;call super::retrieveend;string ls_iban

if this.rowcount() > 0 then 

	ls_iban = this.getitemstring( this.getrow(), 'datos_bancarios_iban')
		
	if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban) or f_es_vacio(ls_iban) then 
		this.setitem(this.getrow(), 'cuenta_correcta', 1)	
	else
		this.setitem(this.getrow(), 'cuenta_correcta', 0)	
	end if		
	
	this.SetItemStatus(this.getrow(), 0, Primary!, NotModified!)
end if	
end event

type tabpage_13 from userobject within tab_2
event create ( )
event destroy ( )
string tag = "texto=colegiados.conceptos_fact"
integer x = 18
integer y = 100
integer width = 4233
integer height = 760
long backcolor = 79741120
string text = "Conceptos Facturables"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_colegiados_banco_cuenta dw_colegiados_banco_cuenta
dw_colegiados_conceptos_domiciliables dw_colegiados_conceptos_domiciliables
end type

on tabpage_13.create
this.dw_colegiados_banco_cuenta=create dw_colegiados_banco_cuenta
this.dw_colegiados_conceptos_domiciliables=create dw_colegiados_conceptos_domiciliables
this.Control[]={this.dw_colegiados_banco_cuenta,&
this.dw_colegiados_conceptos_domiciliables}
end on

on tabpage_13.destroy
destroy(this.dw_colegiados_banco_cuenta)
destroy(this.dw_colegiados_conceptos_domiciliables)
end on

type dw_colegiados_banco_cuenta from u_dw within tabpage_13
integer x = 18
integer y = 604
integer width = 4192
integer height = 156
integer taborder = 30
string dataobject = "d_colegiados_banco_cuenta_domic"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;integer f, des
string cod


// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)

choose case dwo.name
	case 'cuenta_domic'
		cod=LeftA(data,4)
		select count(*) into :des from csi_bancos_maestro where csi_bancos_maestro.cod = :cod;
		if des>0 then this.setitem(row,'banco_domic',cod)
		
	CASE 'datos_bancarios_iban'

		if (gnv_control_cuentas_bancarias.of_comprobar_iban(data) or f_es_vacio(data)) then 
			if not f_es_vacio(data) then
				data = gnv_control_cuentas_bancarias.of_eliminar_caracteres_no_validos(data)
				this.setitem(this.getrow(), 'datos_bancarios_iban', data)
			end if	
			this.setitem(row, 'cuenta_correcta', 1)		
		else 			
			this.setitem(row, 'cuenta_correcta', 0)
			messagebox(g_titulo, 'El n$$HEX1$$fa00$$ENDHEX$$mero de cuenta no es v$$HEX1$$e100$$ENDHEX$$lido', stopsign!)
		end if			

	CASE 'bic'
		if not (gnv_control_cuentas_bancarias.of_comprobar_bic(data)) then 	messagebox(g_titulo, 'Revise el c$$HEX1$$f300$$ENDHEX$$digo BIC de la cuenta de cobros. No dispone de un formato correcto' + cr + 'Debe disponer de un c$$HEX1$$f300$$ENDHEX$$digo alfanum$$HEX1$$e900$$ENDHEX$$rico de ocho u once caracteres', StopSign!)		
	
	case else				
end choose

end event

event buttonclicked;call super::buttonclicked;string ls_cuenta

choose case dwo.name
	case 'b_comprobacion_cuentas'

		ls_cuenta = this.getitemstring( row, 'datos_bancarios_iban')
		
		openwithparm(w_comprobacion_cuentas_bancarias, ls_cuenta )
		
		ls_cuenta = message.stringparm
		
		if not f_es_vacio(ls_cuenta) then
			this.setitem(row, 'datos_bancarios_iban', ls_cuenta)
			this.setitem(row, 'cuenta_correcta', 1)		
		end if
		
	case else
end choose
end event

event retrieveend;call super::retrieveend;if this.rowcount() > 0 then 
	string ls_iban
	
	ls_iban = this.getitemstring( this.getrow(), 'datos_bancarios_iban')
		
	if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban) or f_es_vacio(ls_iban) then 
		this.setitem(this.getrow(), 'cuenta_correcta', 1)	
	else
		this.setitem(this.getrow(), 'cuenta_correcta', 0)	
	end if		
	
	this.SetItemStatus(this.getrow(), 0, Primary!, NotModified!)
end if
end event

type dw_colegiados_conceptos_domiciliables from u_dw within tabpage_13
integer x = 18
integer y = 20
integer width = 4256
integer height = 572
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_colegiados_conceptos_domiciliables"
boolean hscrollbar = true
end type

event itemchanged;integer f,i
string cod,des, ls_null

setnull(ls_null)

// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)

choose case dwo.name
	case 'concepto'
		
		for f=1 to this.rowcount()
			if f <> row and this.getitemstring(f,'concepto') = data then
				MessageBox(g_titulo,g_idioma.of_getmsg('colegiados.duplicar_conceptos','No se pueden duplicar conceptos.'))
				this.setitem(row,'concepto','')
				this.setitem(row,'empresa','')
				
				return 1
			end if
		next
		
		//Introducido por Alexis para dar soporte a las incidencias CBI-139 y ICN-385.03/02/2009.
		if  not(f_es_vacio(this.GetItemString(row,'datos_bancarios'))) then
			
			if messagebox(g_titulo, 'Si cambia concepto, se eliminar$$HEX2$$e1002000$$ENDHEX$$la cuenta bancaria. $$HEX1$$bf00$$ENDHEX$$Desea continuar?',Exclamation!,YesNo! ) = 1 then
				this.setitem(row, 'datos_bancarios', ls_null)
			else
				//Se devuelve el concepto que ten$$HEX1$$ed00$$ENDHEX$$a en la l$$HEX1$$ed00$$ENDHEX$$nea. 
				this.setitem(row, 'concepto', this.getitemstring(row, 'concepto'))
				return 2
			end if

		end if	
		
		double importe
		select importe into :importe from csi_articulos_servicios where codigo = :data;
		this.SetItem(row,'importe',importe)
		this.setitem(row,'empresa',g_empresa)
		
	case 'datos_bancarios'
		//Luis CBI-139
		if(g_colegio <> 'COAATB') then
			if not(f_es_vacio(data)) then
				for i=1 to this.rowcount()
					if i=row then continue
					//Javier Osuna CBU-137 18/05/2010
					//Los numeros de cuenta existentes en base de datos anteriores a la reforma para las incidencias CBI-139 y ICN-385.03/02/2009. existen pese a estar ocultas y , portanto , hacen saltar este disparador, a$$HEX1$$f100$$ENDHEX$$adida la condici$$HEX1$$f300$$ENDHEX$$n and this.GetItemString(i,'concepto')="CONCEPTOS DE EXPEDIENTES" para evitar esta situaci$$HEX1$$f300$$ENDHEX$$n
					if not(f_es_vacio(this.GetItemString(i,'datos_bancarios'))) and this.GetItemString(i,'concepto')="CONCEPTOS DE EXPEDIENTES" then
						MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","No pueden haber dos cuentas extras")
						return 2
					end if			
				next
			end if
		end if
		cod=LeftA(data,4)
		select csi_bancos_maestro.descripcion into :des from csi_bancos_maestro where csi_bancos_maestro.cod = :cod;
		this.setitem(row,'nombre_banco',des)
		
	CASE 'datos_bancarios_iban'

		if (gnv_control_cuentas_bancarias.of_comprobar_iban(data) or f_es_vacio(data)) then 
			if not f_es_vacio(data) then
				data = gnv_control_cuentas_bancarias.of_eliminar_caracteres_no_validos(data)
				this.setitem(this.getrow(), 'datos_bancarios_iban', data)
			end if	
			this.setitem(row, 'cuenta_correcta', 1)			
		else 
		    this.setitem(row, 'cuenta_correcta', 0)
			messagebox(g_titulo, 'El n$$HEX1$$fa00$$ENDHEX$$mero de cuenta no es v$$HEX1$$e100$$ENDHEX$$lido', stopsign!)
		end if			

	CASE 'bic'
		if not (gnv_control_cuentas_bancarias.of_comprobar_bic(data)) then 	messagebox(g_titulo, 'Revise el c$$HEX1$$f300$$ENDHEX$$digo BIC de la cuenta de cobros. No dispone de un formato correcto' + cr + 'Debe disponer de un c$$HEX1$$f300$$ENDHEX$$digo alfanum$$HEX1$$e900$$ENDHEX$$rico de ocho u once caracteres', StopSign!)	
		
		
		
	case else
end choose

end event

event itemerror;call super::itemerror;return 1
end event

event retrieveend;call super::retrieveend;// MODIFICADO RICARDO 04-09-14
// Cuando carguemos la DW, para todas aquellas filas que no tengan valor les colocamos el valor del check a 'N'
long fila
string ls_iban
this.setfilter("empresa='"+g_empresa+"'")
this.filter()
for fila = 1 to this.rowcount()
	if f_es_vacio(this.GetItemString(fila, 'es_extra')) then this.SetItem(fila, 'es_extra', 'N')
next
// Grabamos la dw, de esta forma el usuario no se entera que estamos tocando el campo
this.update()

// FIN MODIFICADO RICARDO 04-09-14   


if this.rowcount() >0  then 

	ls_iban = this.getitemstring( this.getrow(), 'datos_bancarios_iban')
		
	if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban) or f_es_vacio(ls_iban) then 
		this.setitem(this.getrow(), 'cuenta_correcta', 1)	
	else
		this.setitem(this.getrow(), 'cuenta_correcta', 0)	
	end if		
	
	this.SetItemStatus(this.getrow(), 0, Primary!, NotModified!)
end if	
end event

event buttonclicked;call super::buttonclicked;string ls_cuenta

choose case dwo.name

case 'b_comprobacion_cuentas'

		ls_cuenta = this.getitemstring( row, 'datos_bancarios_iban')
		
		openwithparm(w_comprobacion_cuentas_bancarias, ls_cuenta )
		
		ls_cuenta = message.stringparm
		
		if not f_es_vacio(ls_cuenta) then
			this.setitem(row, 'datos_bancarios_iban', ls_cuenta)
			this.setitem(row, 'cuenta_correcta', 1)			
		end if
	
end choose
end event

event itemfocuschanged;call super::itemfocuschanged;string ls_iban

if dwo.name = 'datos_bancarios_iban' then
		
	ls_iban = this.getitemstring( row, 'datos_bancarios_iban')
	
	if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban) or f_es_vacio(ls_iban) then 
		this.setitem(row, 'cuenta_correcta', 1)	
	else
		this.setitem(row, 'cuenta_correcta', 0)	
	end if		
end if		
end event

event losefocus;call super::losefocus;string ls_iban

this.accepttext()

if this.getcolumnname( ) = 'datos_bancarios_iban' then
	ls_iban = this.getitemstring( this.getrow(), 'datos_bancarios_iban')
	
	if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban) or f_es_vacio(ls_iban) then 
		this.setitem(this.getrow(), 'cuenta_correcta', 1)	
	else
		this.setitem(this.getrow(), 'cuenta_correcta', 0)	
	end if		

end if
end event

type tabpage_18 from userobject within tab_2
string tag = "texto=general.empresas"
integer x = 18
integer y = 100
integer width = 4233
integer height = 760
long backcolor = 79741120
string text = "Empresas"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_colegiados_empresas dw_colegiados_empresas
end type

on tabpage_18.create
this.dw_colegiados_empresas=create dw_colegiados_empresas
this.Control[]={this.dw_colegiados_empresas}
end on

on tabpage_18.destroy
destroy(this.dw_colegiados_empresas)
end on

type dw_colegiados_empresas from u_dw within tabpage_18
integer x = 18
integer y = 20
integer width = 4256
integer height = 732
integer taborder = 11
string dataobject = "d_colegiados_empresas"
boolean vscrollbar = false
end type

event itemerror;call super::itemerror;return 1

end event

event dberror;call super::dberror;return 1
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = false
end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)

end event

event pfc_addrow;call super::pfc_addrow;string id_empresa, id_colegiado
int existe

g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Empresas de Asalariados"
g_busqueda.dw="d_lista_busqueda_terceros"
	
id_empresa = f_busqueda_terceros(g_terceros_codigos.empresas)
id_colegiado = dw_1.getitemstring(1, 'id_colegiado')

// Comprobamos que no exista ya
select count(*) into :existe from colegiados_empresas where id_colegiado = :id_colegiado and id_empresa = :id_empresa ;

if f_es_vacio (id_empresa) or existe>0 then
	deleterow(rowcount())
	return 0
end if

this.setitem(getrow(), 'id_empresa', id_empresa)
this.update()
this.retrieve(dw_1.getitemstring(1, 'id_colegiado'))
return 1

end event

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)

end event

event pfc_deleterow;call super::pfc_deleterow;this.update()
return 1
end event

event doubleclicked;call super::doubleclicked;IF row <= 0 then return
SetPointer(HourGlass!)
g_clientes_consulta.id_cliente = this.GetItemString(this.GetRow(), 'id_empresa')
Message.StringParm = "w_clientes_detalle"
w_aplic_frame.Post Event csd_clientesdetalle()

end event

type tabpage_23 from userobject within tab_2
string tag = "texto=colegiados.cuenta_personal"
integer x = 18
integer y = 100
integer width = 4233
integer height = 760
long backcolor = 79741120
string text = "Cuenta personal"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cp dw_cp
end type

on tabpage_23.create
this.dw_cp=create dw_cp
this.Control[]={this.dw_cp}
end on

on tabpage_23.destroy
destroy(this.dw_cp)
end on

type dw_cp from u_dw within tabpage_23
integer x = 18
integer y = 20
integer width = 4256
integer height = 728
integer taborder = 11
string dataobject = "d_colegiados_cp"
boolean minbox = true
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_delete.enabled = false
//am_dw.m_table.m_addrow.enabled = false
am_dw.m_table.m_insert.enabled = false
end event

event retrieveend;call super::retrieveend;if f_es_vacio(this.GetItemString(rowcount, 'activo_cp')) then
	// Si no tiene valor, ponemos el valor por defecto
	this.SetItem(rowcount, 'activo_cp', 'N')
	this.update()
end if

string ls_iban

if this.rowcount() > 0 then 
	
	ls_iban = this.getitemstring( this.getrow(), 'cuenta_personal_iban')
		
	if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban) or f_es_vacio(ls_iban) then 
		this.setitem(this.getrow(), 'cuenta_correcta', 1)	
	else
		this.setitem(this.getrow(), 'cuenta_correcta', 0)	
	end if		
	
	this.SetItemStatus(this.getrow(), 0, Primary!, NotModified!)
end if
end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)


choose case dwo.name
		CASE 'cuenta_personal_iban'

		if (gnv_control_cuentas_bancarias.of_comprobar_iban(data) or f_es_vacio(data)) then 
			if not f_es_vacio(data) then
				data = gnv_control_cuentas_bancarias.of_eliminar_caracteres_no_validos(data)
				this.setitem(this.getrow(), 'cuenta_personal_iban', data)
			end if	
			this.setitem(row, 'cuenta_correcta', 1)
			this.object.t_iban.text = gnv_control_cuentas_bancarias.of_obtener_iban_escrito(data)
		else 
			this.object.t_iban.text = ''
			this.setitem(row, 'cuenta_correcta', 0)
			messagebox(g_titulo, 'El n$$HEX1$$fa00$$ENDHEX$$mero de cuenta no es v$$HEX1$$e100$$ENDHEX$$lido', stopsign!)
		
		end if			

	CASE 'cuenta_personal_bic'
		if not (gnv_control_cuentas_bancarias.of_comprobar_bic(data)) then 	messagebox(g_titulo, 'Revise el c$$HEX1$$f300$$ENDHEX$$digo BIC de la cuenta de cobros. No dispone de un formato correcto' + cr + 'Debe disponer de un c$$HEX1$$f300$$ENDHEX$$digo alfanum$$HEX1$$e900$$ENDHEX$$rico de ocho u once caracteres', StopSign!)
		
	case else
		
end choose
end event

event buttonclicked;call super::buttonclicked;string ls_cuenta

choose case dwo.name
	case 'b_comprobacion_cuentas'
	
		ls_cuenta = this.getitemstring( row, 'cuenta_personal_iban')
		
		openwithparm(w_comprobacion_cuentas_bancarias, ls_cuenta )
		
		ls_cuenta = message.stringparm
		
		if not f_es_vacio(ls_cuenta) then
			this.setitem(row, 'cuenta_personal_iban', ls_cuenta)
			this.setitem(row, 'cuenta_correcta', 1)
			this.object.t_iban.text = gnv_control_cuentas_bancarias.of_obtener_iban_escrito(ls_cuenta)
		end if
		
	case else
		
end choose
end event

event itemfocuschanged;call super::itemfocuschanged;string ls_iban

if dwo.name = 'cuenta_personal_iban' then
		
	ls_iban = this.getitemstring( row, 'cuenta_personal_iban')
	
	if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban) or f_es_vacio(ls_iban) then 
		this.setitem(row, 'cuenta_correcta', 1)	
	else
		this.setitem(row, 'cuenta_correcta', 0)	
	end if		
end if		
end event

event losefocus;call super::losefocus;string ls_iban

this.accepttext()

if this.getcolumnname( ) = 'cuenta_personal_iban' then
	ls_iban = this.getitemstring( this.getrow(), 'cuenta_personal_iban')
	
	if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban) or f_es_vacio(ls_iban) then 
		this.setitem(this.getrow(), 'cuenta_correcta', 1)	
	else
		this.setitem(this.getrow(), 'cuenta_correcta', 0)	
	end if		

end if
end event

type tabpage_29 from userobject within tab_2
integer x = 18
integer y = 100
integer width = 4233
integer height = 760
long backcolor = 79741120
string text = "RECC"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_colegiados_recc dw_colegiados_recc
end type

on tabpage_29.create
this.dw_colegiados_recc=create dw_colegiados_recc
this.Control[]={this.dw_colegiados_recc}
end on

on tabpage_29.destroy
destroy(this.dw_colegiados_recc)
end on

type dw_colegiados_recc from u_dw within tabpage_29
event csd_asignar_cc ( string ls_cuenta_anterior,  string ls_colegiado,  string ls_data )
integer x = 18
integer y = 20
integer width = 4274
integer height = 780
integer taborder = 21
string dataobject = "d_colegiados_recc"
boolean vscrollbar = false
end type

event itemerror;call super::itemerror;return 1
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_delete.enabled = true
//am_dw.m_table.m_addrow.enabled = false
am_dw.m_table.m_insert.enabled = false
end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event itemchanged;call super::itemchanged;// Modificacion de Datos

date ldt_date

if (dwo.name = "f_inicio") then
	ldt_date = date(data)
	if (day(ldt_date) <> 1 or month(ldt_date) <> 1) then 
		messagebox(g_titulo, "Para aplicar el regimen RECC se debe aplicar a un a$$HEX1$$f100$$ENDHEX$$o natural desde el 1 de Enero", StopSign!, Ok!)
		return 2
	end if
end if

if (dwo.name = "f_fin") then
	ldt_date = date(data)
	if (day(ldt_date) <> 31 or month(ldt_date) <> 12) then 
		messagebox(g_titulo, "Para aplicar el regimen RECC se debe aplicar a un a$$HEX1$$f100$$ENDHEX$$o natural hasta el 31 de Diciembre", StopSign!, Ok!)
		return 2
	end if
end if

dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)

end event

event pfc_deleterow;call super::pfc_deleterow;this.update()
return 1
end event

type tabpage_2 from userobject within tab_1
string tag = "texto=colegiados.historico"
integer x = 18
integer y = 208
integer width = 4343
integer height = 1004
long backcolor = 79741120
string text = "Hist$$HEX1$$f300$$ENDHEX$$ricos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Start!"
long picturemaskcolor = 536870912
cb_1 cb_1
tab_5 tab_5
end type

on tabpage_2.create
this.cb_1=create cb_1
this.tab_5=create tab_5
this.Control[]={this.cb_1,&
this.tab_5}
end on

on tabpage_2.destroy
destroy(this.cb_1)
destroy(this.tab_5)
end on

type cb_1 from commandbutton within tabpage_2
integer x = 2459
integer y = 20
integer width = 480
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Datos Hist$$HEX1$$f300$$ENDHEX$$ricos"
end type

event clicked;openwithparm(w_historico, dw_1.getitemstring(1,'id_colegiado')+"01")
end event

type tab_5 from tab within tabpage_2
string tag = "texto=colegiados.historico"
integer x = 5
integer y = 24
integer width = 4338
integer height = 964
integer taborder = 40
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
tabpage_4 tabpage_4
tabpage_24 tabpage_24
tabpage_16 tabpage_16
end type

on tab_5.create
this.tabpage_4=create tabpage_4
this.tabpage_24=create tabpage_24
this.tabpage_16=create tabpage_16
this.Control[]={this.tabpage_4,&
this.tabpage_24,&
this.tabpage_16}
end on

on tab_5.destroy
destroy(this.tabpage_4)
destroy(this.tabpage_24)
destroy(this.tabpage_16)
end on

type tabpage_4 from userobject within tab_5
string tag = "texto=colegiados.altas_bajas_sit"
integer x = 18
integer y = 100
integer width = 4302
integer height = 848
long backcolor = 79741120
string text = "Altas, Bajas y Situaciones"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_colegiados_altas_bajas_situaciones dw_colegiados_altas_bajas_situaciones
end type

on tabpage_4.create
this.dw_colegiados_altas_bajas_situaciones=create dw_colegiados_altas_bajas_situaciones
this.Control[]={this.dw_colegiados_altas_bajas_situaciones}
end on

on tabpage_4.destroy
destroy(this.dw_colegiados_altas_bajas_situaciones)
end on

type dw_colegiados_altas_bajas_situaciones from u_dw within tabpage_4
integer x = 18
integer y = 20
integer width = 4256
integer height = 804
integer taborder = 10
string dataobject = "d_colegiados_altas_bajas_situaciones"
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event pfc_insertrow;call super::pfc_insertrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
dw_colegiados_altas_bajas_situaciones.setitem(dw_colegiados_altas_bajas_situaciones.getrow(), 'id_altas_bajas_situaciones', f_siguiente_numero('ALTA_BAJA_SITUACION', 10))
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

event pfc_addrow;call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
dw_colegiados_altas_bajas_situaciones.setitem(dw_colegiados_altas_bajas_situaciones.getrow(), 'id_altas_bajas_situaciones', f_siguiente_numero('ALTA_BAJA_SITUACION', 10))
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

event doubleclicked;string obser_situacion, data_item
g_busqueda.solo_despliega_texto=False

CHOOSE CASE dwo.name
	CASE 't_observaciones'
		g_busqueda.titulo="Observaciones"
		obser_situacion=this.GetItemString(row, 'observaciones')
		data_item      =this.getitemstring(row, 'observaciones') // para control modificaciones
		openwithparm(w_observaciones, obser_situacion)
		if Message.Stringparm <> '-1' then
			obser_situacion = Message.Stringparm
			if not isnull(obser_situacion) then 
				if data_item<>obser_situacion then dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), 'observaciones', row)				
				this.SetItem(row,'observaciones',obser_situacion)
			end if
		end if

END CHOOSE
end event

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_delete.enabled = true
am_dw.m_table.m_addrow.enabled = false
am_dw.m_table.m_insert.enabled = false
end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)
end event

type tabpage_24 from userobject within tab_5
string tag = "texto=colegiados.cambios_dom"
integer x = 18
integer y = 100
integer width = 4302
integer height = 848
long backcolor = 79741120
string text = "Cambios de Domicilio"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cambios_domicilio dw_cambios_domicilio
end type

on tabpage_24.create
this.dw_cambios_domicilio=create dw_cambios_domicilio
this.Control[]={this.dw_cambios_domicilio}
end on

on tabpage_24.destroy
destroy(this.dw_cambios_domicilio)
end on

type dw_cambios_domicilio from u_dw within tabpage_24
integer x = 18
integer y = 20
integer width = 4256
integer height = 804
integer taborder = 11
string dataobject = "d_colegiados_cambios_dom"
boolean hscrollbar = true
boolean ib_rmbmenu = false
end type

event pfc_addrow;call super::pfc_addrow;
this.SetItem(ancestorreturnvalue,'usuario',g_usuario)
this.SetItem(ancestorreturnvalue,'fecha',datetime(today(),now()))
this.SetItem(ancestorreturnvalue,'id_colegiado',dw_1.GetItemString(dw_1.GetRow(),'id_colegiado'))
this.SetItem(ancestorreturnvalue,'id_cambio_dom',f_siguiente_numero('ID_CAMBIO_DOM',10))


return ancestorreturnvalue
end event

type tabpage_16 from userobject within tab_5
boolean visible = false
integer x = 18
integer y = 100
integer width = 4302
integer height = 848
long backcolor = 79741120
string text = "Modificaci$$HEX1$$f300$$ENDHEX$$n de datos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_colegiados_modificacion_datos dw_colegiados_modificacion_datos
end type

on tabpage_16.create
this.dw_colegiados_modificacion_datos=create dw_colegiados_modificacion_datos
this.Control[]={this.dw_colegiados_modificacion_datos}
end on

on tabpage_16.destroy
destroy(this.dw_colegiados_modificacion_datos)
end on

type dw_colegiados_modificacion_datos from u_dw within tabpage_16
integer x = 18
integer y = 20
integer width = 4256
integer height = 804
integer taborder = 11
string dataobject = "d_historico"
end type

event pfc_addrow;call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.rowcount(), 'id_modificacion', f_siguiente_numero('MODIFICACIONES', 10))
this.setitem(this.rowcount(), 'id_colegiado', dw_1.GetItemString(1,'id_colegiado') )
this.setitem(this.rowcount(), 'tipo_modulo', '01')
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

event pfc_insertrow;call super::pfc_insertrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.rowcount(), 'id_modificacion', f_siguiente_numero('MODIFICACIONES', 10))
this.setitem(this.rowcount(), 'id_colegiado', dw_1.GetItemString(1,'id_colegiado') )
this.setitem(this.rowcount(), 'tipo_modulo', '01')
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

type tabpage_8 from userobject within tab_1
string tag = "texto=colegiados.otros_datos"
integer x = 18
integer y = 208
integer width = 4343
integer height = 1004
long backcolor = 79741120
string text = "Otros Datos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "ArrangeIcons!"
long picturemaskcolor = 536870912
tab_3 tab_3
end type

on tabpage_8.create
this.tab_3=create tab_3
this.Control[]={this.tab_3}
end on

on tabpage_8.destroy
destroy(this.tab_3)
end on

type tab_3 from tab within tabpage_8
event create ( )
event destroy ( )
integer x = 9
integer y = 12
integer width = 4334
integer height = 968
integer taborder = 40
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
tabpage_9 tabpage_9
tabpage_11 tabpage_11
tabpage_20 tabpage_20
tabpage_26 tabpage_26
end type

on tab_3.create
this.tabpage_9=create tabpage_9
this.tabpage_11=create tabpage_11
this.tabpage_20=create tabpage_20
this.tabpage_26=create tabpage_26
this.Control[]={this.tabpage_9,&
this.tabpage_11,&
this.tabpage_20,&
this.tabpage_26}
end on

on tab_3.destroy
destroy(this.tabpage_9)
destroy(this.tabpage_11)
destroy(this.tabpage_20)
destroy(this.tabpage_26)
end on

type tabpage_9 from userobject within tab_3
event create ( )
event destroy ( )
string tag = "texto=colegiados.cesion_datos_int"
integer x = 18
integer y = 100
integer width = 4297
integer height = 852
long backcolor = 79741120
string text = "Cesi$$HEX1$$f300$$ENDHEX$$n de datos/Internet"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_colegiados_cesion_datos_nuevos dw_colegiados_cesion_datos_nuevos
dw_colegiados_cesion_datos_internet dw_colegiados_cesion_datos_internet
end type

on tabpage_9.create
this.dw_colegiados_cesion_datos_nuevos=create dw_colegiados_cesion_datos_nuevos
this.dw_colegiados_cesion_datos_internet=create dw_colegiados_cesion_datos_internet
this.Control[]={this.dw_colegiados_cesion_datos_nuevos,&
this.dw_colegiados_cesion_datos_internet}
end on

on tabpage_9.destroy
destroy(this.dw_colegiados_cesion_datos_nuevos)
destroy(this.dw_colegiados_cesion_datos_internet)
end on

type dw_colegiados_cesion_datos_nuevos from u_dw within tabpage_9
integer x = 2606
integer y = 52
integer width = 1541
integer height = 760
integer taborder = 11
string dataobject = "d_colegiados_cesion_datos_nuevos"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)

end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_delete.enabled = false
am_dw.m_table.m_addrow.enabled = false
am_dw.m_table.m_insert.enabled = false
end event

type dw_colegiados_cesion_datos_internet from u_dw within tabpage_9
integer x = 5
integer y = 52
integer width = 2629
integer height = 760
integer taborder = 10
string dataobject = "d_colegiados_cesion_datos_internet"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event pfc_preinsertrow;call super::pfc_preinsertrow;// se controla que sea una sola fila
if dw_colegiados_cesion_datos_internet.rowcount() >= 1 then 
	messagebox(g_titulo,g_idioma.of_getmsg('colegiados.anyadir_registros',"No se pueden a$$HEX1$$f100$$ENDHEX$$adir m$$HEX1$$e100$$ENDHEX$$s registros"))
	return 0
else 
	return 1
end if
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_delete.enabled = false
am_dw.m_table.m_addrow.enabled = false
am_dw.m_table.m_insert.enabled = false
end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)

//CGC-118
if(g_colegio = 'COAATGC')then
	if(dwo.name = 'email')then
		this.accepttext()
		if not(f_es_vacio(this.getitemstring(1,'email')))then
			this.setitem(1,'recibir_c_email','S')
		end if
	end if
end if
end event

type tabpage_11 from userobject within tab_3
event create ( )
event destroy ( )
string tag = "texto=colegiados.otros_datos"
integer x = 18
integer y = 100
integer width = 4297
integer height = 852
long backcolor = 79741120
string text = "Otros Datos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_colegiados_otros_datos dw_colegiados_otros_datos
end type

on tabpage_11.create
this.dw_colegiados_otros_datos=create dw_colegiados_otros_datos
this.Control[]={this.dw_colegiados_otros_datos}
end on

on tabpage_11.destroy
destroy(this.dw_colegiados_otros_datos)
end on

type dw_colegiados_otros_datos from u_dw within tabpage_11
event csd_error_cod ( )
event csd_oculta_cabecera_datos ( )
integer x = 18
integer y = 20
integer width = 4256
integer height = 804
integer taborder = 10
string dataobject = "d_colegiados_otros_datos"
boolean hscrollbar = true
end type

event csd_oculta_cabecera_datos;//integer cf
//string  cod_caracteristica
//		
//// Se recorren todos los registros
//this.object.valor_t.width = this.object.numero.width 
//
//for cf = 1 to this.rowcount()
//	cod_caracteristica = this.getitemstring(cf,'cod_caracteristica')
//	if f_debe_mostrar_campo(cod_caracteristica)='S' then
//		this.object.valor_t.width = this.object.texto.width
//	end if
//next
//
end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event itemchanged;call super::itemchanged;integer f
string  nombre_caract

// Modificacion de Datos
nombre_caract=f_descripcion_otros_datos(this.getitemstring(row,'cod_caracteristica'))
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), dwo.name, row)

choose case dwo.name
	case 'cod_caracteristica'
	for f=1 to this.rowcount()
		if f <> row and this.getitemstring(f,'cod_caracteristica') = data then
			this.setitem(row,'cod_caracteristica','')
			MessageBox(g_titulo,g_idioma.of_getmsg('colegiados.duplicar_caracteristicas','No se pueden duplicar caracter$$HEX1$$ed00$$ENDHEX$$sticas.'))
			return 1
		end if
	next
end choose

// Se oculta/despliega la cabecera de DW de Incompatibilidades 
this.event csd_oculta_cabecera_datos()

end event

event itemerror;call super::itemerror;return 1
end event

event retrieveend;call super::retrieveend;// Se oculta/despliega la cabecera de DW de Incompatibilidades 
this.event csd_oculta_cabecera_datos()
end event

event pfc_addrow;call super::pfc_addrow;// Se oculta/despliega la cabecera de DW de Incompatibilidades 
this.event csd_oculta_cabecera_datos()
return 1
end event

event pfc_deleterow;call super::pfc_deleterow;// Se oculta/despliega la cabecera de DW de Incompatibilidades 
this.event csd_oculta_cabecera_datos()
return 1
end event

event pfc_insertrow;call super::pfc_insertrow;// Se oculta/despliega la cabecera de DW de Incompatibilidades 
this.event csd_oculta_cabecera_datos()
return 1
end event

event itemfocuschanged;call super::itemfocuschanged;// Se oculta/despliega la cabecera de DW de Incompatibilidades 
this.event csd_oculta_cabecera_datos()

end event

type tabpage_20 from userobject within tab_3
string tag = "texto=colegiados.lista_colegiados"
integer x = 18
integer y = 100
integer width = 4297
integer height = 852
long backcolor = 79741120
string text = "Lista de Colegiados"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_colegiados_listas_pertenece dw_colegiados_listas_pertenece
end type

on tabpage_20.create
this.dw_colegiados_listas_pertenece=create dw_colegiados_listas_pertenece
this.Control[]={this.dw_colegiados_listas_pertenece}
end on

on tabpage_20.destroy
destroy(this.dw_colegiados_listas_pertenece)
end on

type dw_colegiados_listas_pertenece from u_dw within tabpage_20
integer x = 18
integer y = 20
integer width = 4256
integer height = 804
integer taborder = 11
string dataobject = "d_colegiados_listas_pertenece"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;call super::doubleclicked;if row=0 then return

g_listas_consulta.id_lista = this.getitemstring(row,'id_lista')
message.stringparm = "w_listas_detalle"
w_aplic_frame.postevent("csd_listas_detalle")

end event

type tabpage_26 from userobject within tab_3
string tag = "texto=colegiados.pers_autoriz"
integer x = 18
integer y = 100
integer width = 4297
integer height = 852
long backcolor = 79741120
string text = "Personas Autorizadas"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_personas_autorizadas dw_personas_autorizadas
end type

on tabpage_26.create
this.dw_personas_autorizadas=create dw_personas_autorizadas
this.Control[]={this.dw_personas_autorizadas}
end on

on tabpage_26.destroy
destroy(this.dw_personas_autorizadas)
end on

type dw_personas_autorizadas from u_dw within tabpage_26
integer x = 14
integer y = 16
integer width = 4261
integer height = 736
integer taborder = 11
string dataobject = "d_colegiados_autorizados"
end type

event pfc_addrow;call super::pfc_addrow;this.SetItem(ancestorreturnvalue,'id_colegiado',dw_1.GetItemString(dw_1.GetRow(),'id_colegiado'))
this.SetItem(ancestorreturnvalue,'id_col_autorizado',f_siguiente_numero('ID_COL_AUTORIZADO',10))

return ancestorreturnvalue
end event

event pfc_insertrow;call super::pfc_insertrow;this.SetItem(ancestorreturnvalue,'id_colegiado',dw_1.GetItemString(dw_1.GetRow(),'id_colegiado'))
this.SetItem(ancestorreturnvalue,'id_col_autorizado',f_siguiente_numero('ID_COL_AUTORIZADO',10))

return ancestorreturnvalue
end event

type tabpage_21 from userobject within tab_1
string tag = "texto=colegiados.seguros"
integer x = 18
integer y = 208
integer width = 4343
integer height = 1004
long backcolor = 79741120
string text = "Seguros"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom046!"
long picturemaskcolor = 536870912
pb_src_nuevo pb_src_nuevo
dw_seguros dw_seguros
pb_seguros pb_seguros
end type

on tabpage_21.create
this.pb_src_nuevo=create pb_src_nuevo
this.dw_seguros=create dw_seguros
this.pb_seguros=create pb_seguros
this.Control[]={this.pb_src_nuevo,&
this.dw_seguros,&
this.pb_seguros}
end on

on tabpage_21.destroy
destroy(this.pb_src_nuevo)
destroy(this.dw_seguros)
destroy(this.pb_seguros)
end on

type pb_src_nuevo from picturebutton within tabpage_21
string tag = "texto=general.dar_alta"
integer x = 3195
integer y = 16
integer width = 297
integer height = 160
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Dar Alta"
boolean originalsize = true
vtextalign vtextalign = multiline!
end type

event clicked;IF idw_seguros.rowcount() > 0 then return

gb_nuevo = TRUE
OpenSheet(g_detalle_musaat, 'w_musaat_detalle',  w_aplic_frame, 0, original!)
DO WHILE not isvalid(g_detalle_musaat)
	yield()
LOOP

string id_col
id_col = dw_1.getitemstring(1, 'id_colegiado')
g_detalle_musaat.dynamic post event csd_poner_colegiado(id_col)

end event

type dw_seguros from u_dw within tabpage_21
integer x = 18
integer y = 20
integer width = 3173
integer height = 920
integer taborder = 40
boolean enabled = false
string dataobject = "d_colegiados_seguros"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;call super::doubleclicked;//IF row <= 0 then return
//SetPointer(HourGlass!)
//g_dw_lista_musaat = this
////Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada:
//g_musaat_consulta.id_musaat = this.GetItemString(this.GetRow(), 'id_musaat')
//Message.StringParm = "w_musaat_detalle"
//w_aplic_frame.Post Event csd_musaat_detalle()
end event

type pb_seguros from picturebutton within tabpage_21
string tag = "texto=general.ficha_ampliada"
integer x = 3195
integer y = 16
integer width = 297
integer height = 160
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Ficha Ampliada"
boolean originalsize = true
vtextalign vtextalign = multiline!
end type

event clicked;IF idw_seguros.rowcount() <= 0 then return

g_dw_lista_musaat = idw_seguros
g_musaat_consulta.id_musaat = idw_seguros.GetItemString(idw_seguros.GetRow(), 'id_musaat')
OpenSheet(g_detalle_musaat, 'w_musaat_detalle',  w_aplic_frame, 0, original!)

post event csd_refrescar_conceptos()
end event

type tabpage_22 from userobject within tab_1
string tag = "texto=colegiados.mutua"
integer x = 18
integer y = 208
integer width = 4343
integer height = 1004
long backcolor = 79741120
string text = "Mutua"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom090!"
long picturemaskcolor = 536870912
pb_prem_nuevo pb_prem_nuevo
pb_mutua pb_mutua
dw_mutua dw_mutua
end type

on tabpage_22.create
this.pb_prem_nuevo=create pb_prem_nuevo
this.pb_mutua=create pb_mutua
this.dw_mutua=create dw_mutua
this.Control[]={this.pb_prem_nuevo,&
this.pb_mutua,&
this.dw_mutua}
end on

on tabpage_22.destroy
destroy(this.pb_prem_nuevo)
destroy(this.pb_mutua)
destroy(this.dw_mutua)
end on

type pb_prem_nuevo from picturebutton within tabpage_22
integer x = 3195
integer y = 16
integer width = 297
integer height = 160
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Dar Alta"
boolean originalsize = true
vtextalign vtextalign = multiline!
end type

event clicked;IF idw_mutua.rowcount() > 0 then return

gb_nuevo = TRUE
OpenSheet(g_detalle_premaat, 'w_premaat_detalle',  w_aplic_frame, 0, original!)
DO WHILE not isvalid(g_detalle_premaat)
	yield()
LOOP

string id_col
id_col = dw_1.getitemstring(1, 'id_colegiado')
g_detalle_premaat.dynamic post event csd_poner_colegiado(id_col)

end event

type pb_mutua from picturebutton within tabpage_22
string tag = "texto=general.ficha_ampliada"
integer x = 3195
integer y = 16
integer width = 297
integer height = 160
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Ficha Ampliada"
boolean originalsize = true
vtextalign vtextalign = multiline!
end type

event clicked;IF idw_mutua.rowcount() <= 0 then return

g_dw_lista_premaat = idw_mutua
g_premaat_consulta.id_premaat = idw_mutua.GetItemString(idw_mutua.GetRow(), 'id_premaat')
OpenSheet(g_detalle_premaat, 'w_premaat_detalle',  w_aplic_frame, 0, original!)

post event csd_refrescar_conceptos()
end event

type dw_mutua from u_dw within tabpage_22
integer x = 18
integer y = 20
integer width = 3173
integer height = 920
integer taborder = 20
string dataobject = "d_colegiados_premaat"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;call super::doubleclicked;//IF row <= 0 then return
//SetPointer(HourGlass!)
//g_dw_lista_premaat = this
////Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada:
//g_premaat_consulta.id_premaat = this.GetItemString(this.GetRow(), 'id_premaat')
//Message.StringParm = "w_premaat_detalle"
//w_aplic_frame.Post Event csd_premaat_detalle()
end event

type dw_2 from u_dw within w_colegiados_detalle
boolean visible = false
integer x = 201
integer y = 108
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_colegiados_listado_ficha"
end type

type cb_2 from commandbutton within w_colegiados_detalle
integer x = 3095
integer y = 72
integer width = 302
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Morosidad"
end type

event clicked;string ls_colegiado 
st_datos_morosidad  lst_datos

if dw_1.rowcount() = 0 then return

dw_1.accepttext()

//ls_colegiado = dw_1.GetItemString(dw_1.GetRow(),'n_colegiado')
lst_datos.n_colegiado= dw_1.GetItemString(dw_1.GetRow(),'n_colegiado')

//if not(f_es_vacio(ls_colegiado)) then

if not(f_es_vacio(lst_datos.n_colegiado)) then
	
//	OpenWithParm(w_morosidad_colegiado,ls_colegiado)
	OpenWithParm(w_morosidad_colegiado,lst_datos)
else
	messagebox(g_titulo, 'Debe Tener Nro. de Colegiado.')
end if

end event

