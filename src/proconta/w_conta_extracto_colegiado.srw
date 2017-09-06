HA$PBExportHeader$w_conta_extracto_colegiado.srw
forward
global type w_conta_extracto_colegiado from w_sheet
end type
type st_mensaje from statictext within w_conta_extracto_colegiado
end type
type tab_1 from tab within w_conta_extracto_colegiado
end type
type tabpage_12 from userobject within tab_1
end type
type dw_consulta from u_dw within tabpage_12
end type
type tabpage_12 from userobject within tab_1
dw_consulta dw_consulta
end type
type tabpage_1 from userobject within tab_1
end type
type dw_resumen from datawindow within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_resumen dw_resumen
cb_2 cb_2
end type
type tabpage_1a from userobject within tab_1
end type
type cb_22 from commandbutton within tabpage_1a
end type
type dw_resumen_al from datawindow within tabpage_1a
end type
type tabpage_1a from userobject within tab_1
cb_22 cb_22
dw_resumen_al dw_resumen_al
end type
type tabpage_6 from userobject within tab_1
end type
type cb_7 from commandbutton within tabpage_6
end type
type dw_iva_col from u_dw within tabpage_6
end type
type tabpage_6 from userobject within tab_1
cb_7 cb_7
dw_iva_col dw_iva_col
end type
type tabpage_2 from userobject within tab_1
end type
type dw_honor from u_dw within tabpage_2
end type
type cb_3 from commandbutton within tabpage_2
end type
type dw_honor1 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_honor dw_honor
cb_3 cb_3
dw_honor1 dw_honor1
end type
type tabpage_3 from userobject within tab_1
end type
type cb_5 from commandbutton within tabpage_3
end type
type dw_reten from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cb_5 cb_5
dw_reten dw_reten
end type
type tabpage_4 from userobject within tab_1
end type
type cb_4 from commandbutton within tabpage_4
end type
type dw_iva from datawindow within tabpage_4
end type
type tabpage_4 from userobject within tab_1
cb_4 cb_4
dw_iva dw_iva
end type
type tabpage_5 from userobject within tab_1
end type
type cb_6 from commandbutton within tabpage_5
end type
type dw_fact_honor from u_dw within tabpage_5
end type
type tabpage_5 from userobject within tab_1
cb_6 cb_6
dw_fact_honor dw_fact_honor
end type
type tabpage_13 from userobject within tab_1
end type
type cb_11 from commandbutton within tabpage_13
end type
type dw_fact_gastos from u_dw within tabpage_13
end type
type tabpage_13 from userobject within tab_1
cb_11 cb_11
dw_fact_gastos dw_fact_gastos
end type
type tabpage_7 from userobject within tab_1
end type
type cb_9 from commandbutton within tabpage_7
end type
type cb_8 from commandbutton within tabpage_7
end type
type dw_ing_gas from u_dw within tabpage_7
end type
type tabpage_7 from userobject within tab_1
cb_9 cb_9
cb_8 cb_8
dw_ing_gas dw_ing_gas
end type
type tabpage_8 from userobject within tab_1
end type
type cb_10 from commandbutton within tabpage_8
end type
type dw_ing_gas_renta from u_dw within tabpage_8
end type
type tabpage_8 from userobject within tab_1
cb_10 cb_10
dw_ing_gas_renta dw_ing_gas_renta
end type
type tabpage_9 from userobject within tab_1
end type
type cb_imprimir_tabpage_9 from commandbutton within tabpage_9
end type
type dw_ing_gas_lr from u_dw within tabpage_9
end type
type tabpage_9 from userobject within tab_1
cb_imprimir_tabpage_9 cb_imprimir_tabpage_9
dw_ing_gas_lr dw_ing_gas_lr
end type
type tabpage_10 from userobject within tab_1
end type
type cb_imprimir_tabpage_10 from commandbutton within tabpage_10
end type
type dw_ing_gas_tfe from u_dw within tabpage_10
end type
type tabpage_10 from userobject within tab_1
cb_imprimir_tabpage_10 cb_imprimir_tabpage_10
dw_ing_gas_tfe dw_ing_gas_tfe
end type
type tabpage_11 from userobject within tab_1
end type
type cb_imprimir_tabpage_11 from commandbutton within tabpage_11
end type
type dw_ing_gas_za from u_dw within tabpage_11
end type
type tabpage_11 from userobject within tab_1
cb_imprimir_tabpage_11 cb_imprimir_tabpage_11
dw_ing_gas_za dw_ing_gas_za
end type
type tabpage_14 from userobject within tab_1
end type
type dw_ing_gas_gu from u_dw within tabpage_14
end type
type cb_imprimir_tabpage_14 from commandbutton within tabpage_14
end type
type tabpage_14 from userobject within tab_1
dw_ing_gas_gu dw_ing_gas_gu
cb_imprimir_tabpage_14 cb_imprimir_tabpage_14
end type
type tabpage_15 from userobject within tab_1
end type
type cb_imprimir_tabpage_15 from commandbutton within tabpage_15
end type
type dw_ing_gas_le from u_dw within tabpage_15
end type
type tabpage_15 from userobject within tab_1
cb_imprimir_tabpage_15 cb_imprimir_tabpage_15
dw_ing_gas_le dw_ing_gas_le
end type
type tabpage_16 from userobject within tab_1
end type
type dw_ing_gas_avi from u_dw within tabpage_16
end type
type cb_imprimir_tabpage_16 from commandbutton within tabpage_16
end type
type tabpage_16 from userobject within tab_1
dw_ing_gas_avi dw_ing_gas_avi
cb_imprimir_tabpage_16 cb_imprimir_tabpage_16
end type
type tabpage_17 from userobject within tab_1
end type
type cb_imprimir_tabpage_17 from commandbutton within tabpage_17
end type
type dw_liquidacion_mur from u_csd_dw within tabpage_17
end type
type tabpage_17 from userobject within tab_1
cb_imprimir_tabpage_17 cb_imprimir_tabpage_17
dw_liquidacion_mur dw_liquidacion_mur
end type
type tabpage_18 from userobject within tab_1
end type
type cb_imprimir_tabpage_18 from commandbutton within tabpage_18
end type
type dw_ing_gas_na from u_dw within tabpage_18
end type
type tabpage_18 from userobject within tab_1
cb_imprimir_tabpage_18 cb_imprimir_tabpage_18
dw_ing_gas_na dw_ing_gas_na
end type
type tabpage_19 from userobject within tab_1
end type
type cb_imprimir_tabpage_19 from commandbutton within tabpage_19
end type
type dw_colegiado_ingreso_gasto from u_dw within tabpage_19
end type
type tabpage_19 from userobject within tab_1
cb_imprimir_tabpage_19 cb_imprimir_tabpage_19
dw_colegiado_ingreso_gasto dw_colegiado_ingreso_gasto
end type
type tab_1 from tab within w_conta_extracto_colegiado
tabpage_12 tabpage_12
tabpage_1 tabpage_1
tabpage_1a tabpage_1a
tabpage_6 tabpage_6
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_13 tabpage_13
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
tabpage_10 tabpage_10
tabpage_11 tabpage_11
tabpage_14 tabpage_14
tabpage_15 tabpage_15
tabpage_16 tabpage_16
tabpage_17 tabpage_17
tabpage_18 tabpage_18
tabpage_19 tabpage_19
end type
end forward

global type w_conta_extracto_colegiado from w_sheet
integer width = 3616
integer height = 2076
string title = "Datos contables del colegiado"
string menuname = "m_cerrar"
windowstate windowstate = maximized!
long backcolor = 67108864
event csd_consulta_general ( )
st_mensaje st_mensaje
tab_1 tab_1
end type
global w_conta_extracto_colegiado w_conta_extracto_colegiado

type variables
datawindow idw_honor, idw_reten, idw_resumen, idw_iva, idw_fact_honor, idw_aport, idw_asemas, idw_ing_gas
datawindow idw_iva_col, idw_ing_gas_renta, idw_ing_gas_lr,idw_ing_gas_tfe, idw_ing_gas_za, idw_consulta
datawindow idw_fact_gastos, idw_ing_gas_gu, idw_ing_gas_le, idw_ing_gas_avi, idw_resumen_al, idw_liquidacion_mur
datawindow idw_ing_gas_na,idw_ing_gas_gasto
u_dw idw_general
string i_id_col, i_centro, i_bd_ant, i_sql_nuevo, i_f_desde,i_f_hasta
n_csd_impresion_formato i_impresion_formato,i_num_colegiado

datetime i_df,i_hf
string tri_anyo,i_ejercicio
date i_fecha_desde,i_fecha_hasta


end variables

forward prototypes
public function string f_nombre_pdf (string ejercicio, string colegiado, string descripcion, string trianyo, date f_desde, date f_hasta)
end prototypes

event csd_consulta_general();string sql_aux
  
/*f_sql('n_colegiado','LIKE','n_colegiado',idw_general,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('n_colegiado','>=','n_cold',idw_general,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('n_colegiado','<=','n_colh',idw_general,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('apellidos','LIKE','apellido_nombresociedad',idw_general,i_sql_nuevo,'1','')
*/

// Todos los colegiados que pertenezcan a la lista de extracto elegida..
// Pero comprobando si hay que incluirlos o incluirlos
string incl_excl, operador_not
operador_not = ''
/*incl_excl = idw_general.GetItemString(1,'incluir_lista')
if incl_excl = 'E' then operador_not = ' NOT '*/

if PosA(upper(i_sql_nuevo), "WHERE") > 0 then
	sql_aux = "and colegiados.id_colegiado " + operador_not + "IN (SELECT id_lista_miembro FROM listas_miembros WHERE id_lista='"+idw_general.getitemstring(1,'lista_extracto')+"')"
else
	sql_aux = "WHERE colegiados.id_colegiado " + operador_not + "IN (SELECT id_lista_miembro FROM listas_miembros WHERE id_lista='"+idw_general.getitemstring(1,'lista_extracto')+"')"
end if	
if not isnull(sql_aux) then i_sql_nuevo += sql_aux


end event

public function string f_nombre_pdf (string ejercicio, string colegiado, string descripcion, string trianyo, date f_desde, date f_hasta); // Devolvemos el nombre del fichero
 
 string nombre_fichero,fecha_desde,fecha_hasta, nombre_empresa
 
fecha_desde = f_reemplaza_cadena(string(f_desde),'/','')
fecha_hasta = f_reemplaza_cadena(string(f_hasta),'/','') 

nombre_empresa = TRIM(g_nombre_empresa_csb)
IF f_es_vacio(nombre_empresa) THEN nombre_empresa = g_empresa

 nombre_fichero = ejercicio + '_'+ nombre_empresa+'_' + colegiado + '_' + descripcion + '_' + trianyo + '_' + fecha_desde + '_' + fecha_hasta
 
 return nombre_fichero
end function

on w_conta_extracto_colegiado.create
int iCurrent
call super::create
if this.MenuName = "m_cerrar" then this.MenuID = create m_cerrar
this.st_mensaje=create st_mensaje
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_mensaje
this.Control[iCurrent+2]=this.tab_1
end on

on w_conta_extracto_colegiado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_mensaje)
destroy(this.tab_1)
end on

event open;this.of_setresize(true)
f_centrar_ventana(this)

if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)

i_bd_ant = bd_ejercicio.database

idw_consulta = tab_1.tabpage_12.dw_consulta

i_impresion_formato = create n_csd_impresion_formato

idw_general = tab_1.tabpage_12.dw_consulta

if g_colegiados_cta_retvol = false then 
	tab_1.tabpage_3.visible = false
//	idw_consulta.object.retenciones.visible = false
//	idw_consulta.object.retenciones_t.visible = false	
end if
if g_colegiados_cta_iva = false then 
	tab_1.tabpage_4.visible = false
//	idw_consulta.object.iva.visible = false
//	idw_consulta.object.iva_t.visible = false	
end if
if isnumber(g_codigos_conceptos.irpf) = false then
	tab_1.tabpage_7.visible = false
	idw_consulta.object.ing_gas.visible = false	
end if

// Se debe ver el check
choose case g_colegio
	case 'COAATGUI', 'COAATLR', 'COAATZ', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATNA'
		idw_consulta.object.ing_gas.visible = "1~tif(isnull(n_colegiado),1,0)"		
end choose

// En el colegio de guipuzcoa no debe salir la certificacion
if g_colegio <> 'COAATGUI' then tab_1.tabpage_8.visible = false
// En el colegio de la Rioja quieren una especie de Certificacion pero sin certificar
if g_colegio <> 'COAATLR' then tab_1.tabpage_9.visible = false
// En el colegio de la TENERIFE quieren un modelo de informacion de IRPF
if g_colegio <> 'COAATTFE' then tab_1.tabpage_10.visible = false
if g_colegio <> 'COAATZ' then tab_1.tabpage_11.visible = false
if g_colegio <> 'COAATGU' then tab_1.tabpage_14.visible = false
if g_colegio <> 'COAATLE' then tab_1.tabpage_15.visible = false
if g_colegio <> 'COAATAVI' then tab_1.tabpage_16.visible = false
if g_colegio <> 'COAATNA' then tab_1.tabpage_18.visible = false
if g_colegio <> 'COAATMCA' then tab_1.tabpage_19.visible = false
if g_colegio = 'COAATA' then 
   idw_consulta.object.resumen_al.visible = "1~tif(isnull(n_colegiado),1,0)"
   tab_1.tabpage_1a.visible = true
end if
if g_colegio = 'COAATMU' then 
//	idw_consulta.object.idw_liquidacion_mur.visible = "1~tif(isnull(n_colegiado),1,0)"	
	idw_consulta.object.liquidacion.visible  = 1
	tab_1.tabpage_17.visible = true
end if

idw_resumen = tab_1.tabpage_1.dw_resumen
idw_honor = tab_1.tabpage_2.dw_honor
idw_reten = tab_1.tabpage_3.dw_reten
idw_iva = tab_1.tabpage_4.dw_iva
idw_fact_honor = tab_1.tabpage_5.dw_fact_honor
idw_iva_col = tab_1.tabpage_6.dw_iva_col
idw_ing_gas = tab_1.tabpage_7.dw_ing_gas
idw_ing_gas_renta = tab_1.tabpage_8.dw_ing_gas_renta
idw_ing_gas_lr = tab_1.tabpage_9.dw_ing_gas_lr
idw_ing_gas_tfe = tab_1.tabpage_10.dw_ing_gas_tfe
idw_ing_gas_za = tab_1.tabpage_11.dw_ing_gas_za
idw_ing_gas_gu = tab_1.tabpage_14.dw_ing_gas_gu
idw_fact_gastos = tab_1.tabpage_13.dw_fact_gastos
idw_ing_gas_le = tab_1.tabpage_15.dw_ing_gas_le
idw_ing_gas_avi = tab_1.tabpage_16.dw_ing_gas_avi
idw_resumen_al = tab_1.tabpage_1a.dw_resumen_al
idw_liquidacion_mur = tab_1.tabpage_17.dw_liquidacion_mur
idw_ing_gas_na = tab_1.tabpage_18.dw_ing_gas_na
idw_ing_gas_gasto = tab_1.tabpage_19.dw_colegiado_ingreso_gasto

inv_resize.of_register (tab_1, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_1, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_2, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_3, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_4, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_5, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_6, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_7, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_8, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_9, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_10, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_11, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_12, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_1a, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_17, "scaletoright&bottom")

inv_resize.of_register (tab_1.tabpage_1.cb_2, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_6.cb_7, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_2.cb_3, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_3.cb_5, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_4.cb_4, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_5.cb_6, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_7.cb_8, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_7.cb_9, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_8.cb_10, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_9.cb_imprimir_tabpage_9, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_10.cb_imprimir_tabpage_10, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_11.cb_imprimir_tabpage_11, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_14.cb_imprimir_tabpage_14, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_15.cb_imprimir_tabpage_15, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_16.cb_imprimir_tabpage_16, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_17.cb_imprimir_tabpage_17, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_18.cb_imprimir_tabpage_18, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_19.cb_imprimir_tabpage_19, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_13.cb_11, "Fixedtoright")
inv_resize.of_register (tab_1.tabpage_1a.cb_22, "Fixedtoright")

inv_resize.of_register (idw_resumen, "scaletoright&bottom")
inv_resize.of_register (idw_honor, "scaletoright&bottom")
inv_resize.of_register (idw_reten, "scaletoright&bottom")
inv_resize.of_register (idw_iva, "scaletoright&bottom")
inv_resize.of_register (idw_fact_honor, "scaletoright&bottom")
inv_resize.of_register (idw_iva_col, "scaletoright&bottom")
inv_resize.of_register (idw_ing_gas, "scaletoright&bottom")
inv_resize.of_register (idw_ing_gas_renta, "scaletoright&bottom")
inv_resize.of_register (idw_ing_gas_lr, "scaletoright&bottom")
inv_resize.of_register (idw_ing_gas_tfe, "scaletoright&bottom")
inv_resize.of_register (idw_ing_gas_za, "scaletoright&bottom")
inv_resize.of_register (idw_ing_gas_gu, "scaletoright&bottom")
inv_resize.of_register (idw_ing_gas_le, "scaletoright&bottom")
inv_resize.of_register (idw_ing_gas_avi, "scaletoright&bottom")
inv_resize.of_register (idw_consulta, "scaletoright&bottom")
inv_resize.of_register (idw_fact_gastos, "scaletoright&bottom")
inv_resize.of_register (idw_resumen_al, "scaletoright&bottom")
inv_resize.of_register (idw_liquidacion_mur, "scaletoright&bottom")
inv_resize.of_register (idw_ing_gas_na, "scaletoright&bottom")
inv_resize.of_register (idw_ing_gas_gasto, "scaletoright&bottom")

inv_resize.of_register (st_mensaje, "fixedtobottom")

idw_consulta.InsertRow(0)
idw_consulta.SetFocus()
string kkk
date dk
kkk = '01/01/'+g_ejercicio
dk = date(kkk)
idw_consulta.SetItem(1,'df',datetime(dk,time('00:00')))
kkk = '31/12/'+g_ejercicio
dk = date(kkk)
idw_consulta.SetItem(1,'hf',datetime(dk,time('00:00')))


idw_resumen.SetTransObject(SQLCA)
idw_honor.SetTransObject(bd_ejercicio)
idw_reten.SetTransObject(bd_ejercicio)
idw_iva.SetTransObject(bd_ejercicio)
idw_fact_honor.SetTransObject(SQLCA)
//idw_ing_gas.SetTransObject(SQLCA)
idw_resumen_al.SetTransObject(SQLCA)
idw_liquidacion_mur.SetTransObject(SQLCA) //Juli$$HEX1$$e100$$ENDHEX$$n

f_logo_empresa(g_empresa ,idw_honor, '001')
f_logo_empresa(g_empresa ,idw_reten, '001')
f_logo_empresa(g_empresa ,idw_iva_col, '001')
f_logo_empresa(g_empresa ,idw_fact_honor, '001')
f_logo_empresa(g_empresa ,idw_fact_gastos, '001')
f_logo_empresa(g_empresa ,idw_resumen, '001') 
f_logo_empresa(g_empresa ,idw_liquidacion_mur, '000')
f_logo_empresa(g_empresa ,idw_ing_gas_avi, '000')
f_logo_empresa(g_empresa ,idw_ing_gas_gu, '000') 
f_logo_empresa(g_empresa ,idw_ing_gas_lr, '000')
f_logo_empresa(g_empresa ,idw_ing_gas_za, '000')

idw_honor.dynamic event pfc_printpreview()
idw_reten.dynamic event pfc_printpreview()
idw_fact_honor.dynamic event pfc_printpreview()
idw_fact_gastos.dynamic event pfc_printpreview()
idw_liquidacion_mur.dynamic event pfc_printpreview()

if f_es_vacio(g_prefijo_arqui) then g_prefijo_arqui = '430'
//if f_es_vacio(g_prefijo_arqui_iva) then g_prefijo_arqui_iva = '4140'
//if f_es_vacio(g_prefijo_arqui_rf) then g_prefijo_arqui_rf = '4140'


// ponemos el tipo de trimestre a eventual
idw_consulta.setitem(1,"anual",g_ejercicio)
tri_anyo = g_ejercicio
i_ejercicio=g_ejercicio
// y las fechas
if not(isnull(idw_consulta.getitemdatetime(1,"df"))) then i_fecha_desde =date(idw_consulta.getitemdatetime(1,"df"))
if not(isnull(idw_consulta.getitemdatetime(1,"hf"))) then i_fecha_hasta = date(idw_consulta.getitemdatetime(1,"hf"))

end event

event close;call super::close;destroy(i_impresion_formato)
end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_conta_extracto_colegiado
integer x = 3488
integer y = 1348
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_conta_extracto_colegiado
integer x = 3506
integer y = 1220
end type

type st_mensaje from statictext within w_conta_extracto_colegiado
integer x = 37
integer y = 1760
integer width = 2011
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
boolean focusrectangle = false
end type

type tab_1 from tab within w_conta_extracto_colegiado
integer x = 9
integer y = 24
integer width = 3529
integer height = 1716
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_12 tabpage_12
tabpage_1 tabpage_1
tabpage_1a tabpage_1a
tabpage_6 tabpage_6
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_13 tabpage_13
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
tabpage_10 tabpage_10
tabpage_11 tabpage_11
tabpage_14 tabpage_14
tabpage_15 tabpage_15
tabpage_16 tabpage_16
tabpage_17 tabpage_17
tabpage_18 tabpage_18
tabpage_19 tabpage_19
end type

on tab_1.create
this.tabpage_12=create tabpage_12
this.tabpage_1=create tabpage_1
this.tabpage_1a=create tabpage_1a
this.tabpage_6=create tabpage_6
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_13=create tabpage_13
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_9=create tabpage_9
this.tabpage_10=create tabpage_10
this.tabpage_11=create tabpage_11
this.tabpage_14=create tabpage_14
this.tabpage_15=create tabpage_15
this.tabpage_16=create tabpage_16
this.tabpage_17=create tabpage_17
this.tabpage_18=create tabpage_18
this.tabpage_19=create tabpage_19
this.Control[]={this.tabpage_12,&
this.tabpage_1,&
this.tabpage_1a,&
this.tabpage_6,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_13,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9,&
this.tabpage_10,&
this.tabpage_11,&
this.tabpage_14,&
this.tabpage_15,&
this.tabpage_16,&
this.tabpage_17,&
this.tabpage_18,&
this.tabpage_19}
end on

on tab_1.destroy
destroy(this.tabpage_12)
destroy(this.tabpage_1)
destroy(this.tabpage_1a)
destroy(this.tabpage_6)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_13)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_9)
destroy(this.tabpage_10)
destroy(this.tabpage_11)
destroy(this.tabpage_14)
destroy(this.tabpage_15)
destroy(this.tabpage_16)
destroy(this.tabpage_17)
destroy(this.tabpage_18)
destroy(this.tabpage_19)
end on

type tabpage_12 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Consulta"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
dw_consulta dw_consulta
end type

on tabpage_12.create
this.dw_consulta=create dw_consulta
this.Control[]={this.dw_consulta}
end on

on tabpage_12.destroy
destroy(this.dw_consulta)
end on

type dw_consulta from u_dw within tabpage_12
event csd_bd_anterior ( )
event type integer csd_opciones_impresion ( )
event csd_extracto_1_colegiado ( )
event csd_opciones_impresion_indiv ( )
integer x = 37
integer y = 24
integer width = 2501
integer height = 1572
integer taborder = 10
string dataobject = "d_conta_extracto_consulta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event csd_bd_anterior();// Reestablecemos la conexion con la bd inicial
bd_ejercicio.of_disconnect()
bd_ejercicio.database = i_bd_ant
bd_ejercicio.of_connect()

idw_honor.SetTransObject(bd_ejercicio)
idw_reten.SetTransObject(bd_ejercicio)
idw_iva.SetTransObject(bd_ejercicio)

end event

event type integer csd_opciones_impresion();//Ponemos por defecto las opciones de impresi$$HEX1$$f300$$ENDHEX$$n de documentos...
//f_opciones_impresion(dw_1)

//Datos de copias en papel

i_impresion_formato.pdf = g_formato_impresion.pdf
i_impresion_formato.papel = g_formato_impresion.papel
i_impresion_formato.email = g_formato_impresion.email	

i_impresion_formato.masivo = true
i_impresion_formato.masivo_cambiar_asunto = true

i_impresion_formato.ruta_base 			= g_directorio_informes_economicos
i_impresion_formato.ruta_relativa 		= i_ejercicio+idw_consulta.GetItemString(1,'n_colegiado')
i_impresion_formato.asunto_email = 'Inf.Economica '

//General
i_impresion_formato.destino 			= 'C'
i_impresion_formato.referencia 		= ''

i_impresion_formato.id_receptor=i_id_col
i_impresion_formato.generar_registro=g_formato_impresion.generar_registro
i_impresion_formato.tipo_receptor='C'
i_impresion_formato.serie='ECON'
i_impresion_formato.ruta_automatica=true





if i_impresion_formato.f_opciones_impresion()<> 1 then return -1

if f_es_vacio(i_impresion_formato.nombre) then i_impresion_formato.nombre = 'INFORMACION ECONOMICA'


if g_directorio_informes_economicos = '\' then 
	messagebox(g_titulo, "No est$$HEX2$$e1002000$$ENDHEX$$configurada la ruta, puede que el PDF no se genere correctamente" , exclamation!)
end if

i_impresion_formato.pdf_previsualizar 	= false	//No se muestra una previsualizaci$$HEX1$$f300$$ENDHEX$$n del pdf



//i_impresion_formato.dw =
i_impresion_formato.avisos 			= 0		//Modo sin Avisos
i_impresion_formato.modo_creacion	= 0		// No avisamos por ser una impresi$$HEX1$$f300$$ENDHEX$$n masiva, se sobreescribe si ya existe
//i_impresion_formato.nombre = 'Notificacion'

return 1


/*

//Ponemos por defecto las opciones de impresi$$HEX1$$f300$$ENDHEX$$n de documentos...
//f_opciones_impresion(dw_1)

//Datos de copias en papel
i_impresion_formato.papel	= idw_consulta.GetItemstring(1, "papel")
i_impresion_formato.copias = idw_consulta.GetItemnumber(1, "copias")

//Datos de copias en email
i_impresion_formato.email 			= idw_consulta.GetItemstring(1, "email")
i_impresion_formato.asunto_email = idw_consulta.GetItemstring(1, "asunto_email")

if f_es_vacio(i_impresion_formato.asunto_email) then
	i_impresion_formato.asunto_email = 'Inf.Economica '
end if

i_impresion_formato.texto_email = ''

//Datos de copias en pdf
i_impresion_formato.visualizar_web 	= 'N'
i_impresion_formato.pdf 				= idw_consulta.GetItemstring(1, "pdf") 
//i_impresion_formato.nombre				= idw_consulta.GetItemstring(1, "nombre")

if f_es_vacio(i_impresion_formato.nombre) then i_impresion_formato.nombre = 'INFORMACION ECONOMICA'

i_impresion_formato.ruta_base 			= g_directorio_informes_economicos
if g_directorio_informes_economicos = '\' then 
	messagebox(g_titulo, "No est$$HEX2$$e1002000$$ENDHEX$$configurada la ruta, puede que el PDF no se genere correctamente" , exclamation!)
end if
i_impresion_formato.ruta_relativa 		= g_ejercicio+idw_consulta.GetItemString(1,'n_colegiado')
i_impresion_formato.pdf_previsualizar 	= false	//No se muestra una previsualizaci$$HEX1$$f300$$ENDHEX$$n del pdf


//General
i_impresion_formato.destino 			= 'C'
i_impresion_formato.referencia 		= ''
//i_impresion_formato.dw =
i_impresion_formato.avisos 			= 0		//Modo sin Avisos
i_impresion_formato.modo_creacion	= 0		// No avisamos por ser una impresi$$HEX1$$f300$$ENDHEX$$n masiva, se sobreescribe si ya existe
//i_impresion_formato.nombre = 'Notificacion'
*/


end event

event csd_extracto_1_colegiado();
string apeynom, n_col, cuenta, titulo, domi_activo = '', pob_activa = '', ejer
boolean calcular_saldo_anterior = true

apeynom = f_colegiado_apellido(i_id_col)
domi_activo = f_domicilio_activo(i_id_col)
pob_activa = f_poblacion_activa(i_id_col)

n_col = f_colegiado_n_col(i_id_col)
cuenta = g_prefijo_arqui + '%'
titulo = 'CUENTA DE HONORARIOS'
idw_honor.Retrieve(i_id_col, cuenta, titulo, apeynom, n_col, i_df,i_hf, domi_activo, pob_activa, i_centro)
cuenta = g_prefijo_arqui_iva + '%'
titulo = 'CUENTA DE RETENCIONES'
cuenta = g_prefijo_arqui_rf+ '%'
idw_reten.Retrieve(i_id_col, cuenta, titulo, apeynom, n_col, i_df,i_hf, domi_activo, pob_activa, i_centro)
//idw_reten.Retrieve(i_id_col,cuenta,titulo,apeynom,n_col,i_df,i_hf)
titulo = 'CUENTA DE IVA'
//idw_iva.Retrieve(i_id_col,cuenta,titulo,apeynom,n_col,i_df,i_hf)

idw_fact_honor.Retrieve(i_id_col,i_df, i_hf, apeynom, n_col)
idw_fact_honor.groupcalc()
idw_fact_gastos.Retrieve(i_id_col,i_df, i_hf, apeynom, n_col)
idw_resumen.Retrieve(i_id_col,i_df,i_hf,i_centro, g_empresa)
idw_iva_col.Retrieve(i_id_col,i_df,i_hf,i_centro, g_empresa)
idw_ing_gas.Retrieve(i_id_col,i_df,i_hf,i_centro)
idw_ing_gas.groupcalc()
idw_ing_gas_renta.Retrieve(i_id_col,i_df,i_hf,i_centro)
idw_ing_gas_renta.groupcalc()

g_idioma.of_cambia_textos_dw( idw_resumen )
g_idioma.of_cambia_textos_dw( idw_iva_col )

if g_colegio = 'COAATLR' then	idw_ing_gas_lr.retrieve(i_id_col,i_df,i_hf,i_centro)
if g_colegio = 'COAATTFE' then idw_ing_gas_tfe.retrieve(i_id_col,i_df,i_hf,i_centro)
if g_colegio='COAATZ' then	idw_ing_gas_za.retrieve(i_id_col,i_df,i_hf,i_centro)
if g_colegio='COAATGU' then idw_ing_gas_gu.retrieve(i_id_col,i_df,i_hf,i_centro)
// Le pasamos el concepto de la retenci$$HEX1$$f300$$ENDHEX$$n voluntaria para que saque la secci$$HEX1$$f300$$ENDHEX$$n de la hucha
// Si hubiera m$$HEX1$$e100$$ENDHEX$$s de un concepto lo podr$$HEX1$$ed00$$ENDHEX$$amos hacer por familia
if g_colegio='COAATLE' then idw_ing_gas_le.retrieve(i_id_col,i_df,i_hf,i_centro, g_codigos_conceptos.retvol)
if g_colegio='COAATAVI' then idw_ing_gas_avi.retrieve(i_id_col,i_df,i_hf,i_centro)
if g_colegio = 'COAATA' then idw_resumen_al.Retrieve(i_id_col,i_df,i_hf,i_centro, g_empresa)///**Se introduce la variable de la empresa que es necesaria. ALEXIS. 1/4/2010. CAL-257**///
if g_colegio = 'COAATMCA' then idw_ing_gas_gasto.Retrieve(i_id_col,i_df,i_hf,i_centro)
if g_colegio ='COAATMU' then idw_liquidacion_mur.Retrieve(datetime(i_df),datetime(i_hf),i_id_col,i_centro) // Juli$$HEX1$$e100$$ENDHEX$$n
if g_colegio = 'COAATGUI' and g_activa_multiempresa = 'S' then f_logo_empresa(g_empresa ,idw_ing_gas_renta, '000') //SCP-2074
if g_colegio = 'COAATB' and g_activa_multiempresa = 'S' then f_logo_empresa(g_empresa ,idw_ing_gas, '001') //SCP-2047

if g_colegio='COAATNA' then 
	idw_ing_gas_na.retrieve(i_id_col,i_df,i_hf,i_centro)
	ejer = this.getitemstring(1,'anual')
	idw_ing_gas_na.setitem(1,'ejercicio',ejer)
end if

//  Saldo anterior
double debe_anterior, haber_anterior
if month(date(i_df)) = 1 and day(date(i_df)) = 1 then calcular_saldo_anterior = false
if idw_honor.RowCount() > 0 and calcular_saldo_anterior then
	cuenta = g_prefijo_arqui + '%'
	select sum(apuntes.debe), sum(apuntes.haber) into :debe_anterior, :haber_anterior
	from cuentas, apuntes
	where cuentas.cuenta = apuntes.cuenta and cuentas.cuenta like :cuenta and
	cuentas.id_col = :i_id_col and
	apuntes.fecha < :i_df using bd_ejercicio;
	idw_honor.InsertRow(1)
	idw_honor.SetItem(1,'apuntes_concepto','Saldo anterior...')
	idw_honor.SetItem(1,'apuntes_debe',debe_anterior)
	idw_honor.SetItem(1,'apuntes_haber',haber_anterior)
end if

end event

event csd_opciones_impresion_indiv();// Ponemos por defecto las opciones de impresi$$HEX1$$f300$$ENDHEX$$n de documentos
// En este caso para la impresi$$HEX1$$f300$$ENDHEX$$n individual cuando se abre la ventana



//Datos de copias en papel
i_impresion_formato.papel = g_formato_impresion.papel
i_impresion_formato.copias 					= 1
i_impresion_formato.impresora_pag_desde 	= 1
i_impresion_formato.impresora_intervalo 	= 'T'
i_impresion_formato.impresora_intercalar 	= false

//Datos de copias en email
i_impresion_formato.email = g_formato_impresion.email	
i_impresion_formato.asunto_email = 'Informaci$$HEX1$$f300$$ENDHEX$$n Econ$$HEX1$$f300$$ENDHEX$$mica '
i_impresion_formato.texto_email 	= ''
i_impresion_formato.direccion_email 	= ''
i_impresion_formato.direccion_email = f_devuelve_mail(i_id_col)

//Datos de copias en pdf
i_impresion_formato.visualizar_web 		= 'N'
i_impresion_formato.pdf = g_formato_impresion.pdf
i_impresion_formato.ruta_base				= g_directorio_informes_economicos
if g_directorio_informes_economicos = '\' then 
	messagebox(g_titulo, "No est$$HEX2$$e1002000$$ENDHEX$$configurada la ruta, puede que el PDF no se genere correctamente" , exclamation!)
end if

i_impresion_formato.pdf_previsualizar 	= false	//No se muestra una previsualizaci$$HEX1$$f300$$ENDHEX$$n del pdf

//General
i_impresion_formato.destino 			= 'C'
i_impresion_formato.referencia 		= ''
i_impresion_formato.avisos 			= 1 		//Activamos los avisos pq no es masivo
i_impresion_formato.modo_creacion	= 2		//Avisamos si ya existe
i_impresion_formato.masivo = false
i_impresion_formato.id_receptor=i_id_col
i_impresion_formato.generar_registro=g_formato_impresion.generar_registro
i_impresion_formato.tipo_receptor='C'
i_impresion_formato.serie='ECON'

//i_impresion_formato.ruta_relativa 		= g_ejercicio+'\'+idw_resumen.GetItemString(1,'n_colegiado')  // Ya no sirve
i_impresion_formato.ruta_automatica=true

i_impresion_formato.ruta_relativa1=''
i_impresion_formato.ruta_relativa2=i_ejercicio
i_impresion_formato.ruta_relativa3=idw_resumen.GetItemString(1,'n_colegiado')

if idw_consulta.getitemstring(1,'radio') = 'T' then
	if idw_consulta.getitemstring(1,'trimestres') = '5' then
		i_impresion_formato.ruta_relativa3+='\anual'
	else
		i_impresion_formato.ruta_relativa3+='\trimestral'
	end if
end if

end event

event buttonclicked;call super::buttonclicked;string id_col, n_col,email, email2, email1

this.AcceptText()
//this.Event csd_opciones_impresion()
this.SetItem(1, 'mensaje', '') 


CHOOSE CASE dwo.name
	CASE 'b_busq'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()   
		if NOT f_es_vacio(id_col)  then this.setitem(1,'n_colegiado',f_colegiado_n_col(id_col))

	CASE 'b_aceptar'

				
		st_mensaje.text = ''

		i_id_col = this.GetItemString(1,'n_colegiado')
		i_centro = this.GetItemString(1,'centro')
		if f_es_vacio(i_centro) then i_centro = '%'
		i_df = datetime(date(This.GetItemDateTime(1,'df')), time('00:00:00'))
		i_hf = This.GetItemDateTime(1,'hf')
		date hf
		hf = date(i_hf)
		//hf = relativedate(hf,1)
		i_hf = datetime(hf,time('23:59:59'))

		// Cambiaremos la conexi$$HEX1$$f300$$ENDHEX$$n a la bd de contabilidad para poder consultar otros ejercicios
		string bd_cons
		// 	 SCP-384 creamos el a$$HEX1$$f100$$ENDHEX$$o del ejercicio con la fecha desde y reemplazaremos g ejercicio en todo el evento para formar ruta y nombre de archivo
			//Para que actualize ambos campos al contenido
		i_fecha_desde = date(dw_consulta.getitemdatetime(1,"df"))
		i_fecha_hasta = date(dw_consulta.getitemdatetime(1,"hf"))
	i_ejercicio=string(year(date(i_df)))
		if  i_ejercicio="" then
			i_ejercicio=string(year(date(i_hf)))
			if  i_ejercicio="" then
			i_ejercicio=  this.GetItemString(1,'anual')
				if  i_ejercicio="" then
					i_ejercicio=g_ejercicio
				end if	
			end if
		end if
		// 	fin SCP-384 
		// Vemos que bd se deber$$HEX1$$ed00$$ENDHEX$$a consultar dependiendo de la fecha desde
		bd_cons = 'conta' + string(year(date(i_df))) + g_empresa
		// Si la bd a consultar no es a la que estamos conectados cambiamos la conexi$$HEX1$$f300$$ENDHEX$$n
		if i_bd_ant <> bd_cons then
			bd_ejercicio.of_disconnect()
			bd_ejercicio.database = bd_cons
			if bd_ejercicio.of_connect() = -1 then 
				MessageBox(g_titulo, "La conexi$$HEX1$$f300$$ENDHEX$$n con la Base de Datos del ejercicio ha fallado.",StopSign!)
				bd_ejercicio.of_disconnect()
				bd_ejercicio.database = i_bd_ant		
				bd_ejercicio.of_connect()
			end if
			idw_honor.SetTransObject(bd_ejercicio)
			idw_reten.SetTransObject(bd_ejercicio)
			idw_iva.SetTransObject(bd_ejercicio)
		end if

		if not(isnull(i_id_col)) then
			i_id_col = f_colegiado_id_col(i_id_col)
			this.TriggerEvent("csd_extracto_1_colegiado")
			event csd_bd_anterior() // Restauramos la conexi$$HEX1$$f300$$ENDHEX$$n inicial
			return
		end if

		//Si llegamos aqu$$HEX2$$ed002000$$ENDHEX$$es que vamos a imprimir muchos:
		Datastore ds_coleg//, ds_listado
		string ap_desde, ap_hasta, primero, ultimo, n_col_desde, n_col_hasta
		long cuantos_colegiados,i
		boolean resumen, honorarios, retenciones, iva, fact_honor, listado_resumen, iva_col, ing_gas,liquidacion
		boolean por_apellidos = true, por_numero = false, fact_gastos, resumen_al
		
		resumen = (dw_consulta.GetItemString(1,'resumen') = 'S')
		honorarios = (dw_consulta.GetItemString(1,'honorarios') = 'S')
		retenciones = (dw_consulta.GetItemString(1,'retenciones') = 'S')
		iva = (dw_consulta.GetItemString(1,'iva') = 'S')
		fact_honor = (dw_consulta.GetItemString(1,'fact_honor') = 'S')
		fact_gastos = (dw_consulta.GetItemString(1,'fact_gastos') = 'S')
		listado_resumen = (dw_consulta.GetItemString(1,'listado_resumen') = 'S')
		iva_col = (dw_consulta.GetItemString(1,'iva_col') = 'S')
		ing_gas = (dw_consulta.GetItemString(1,'ing_gas') = 'S')
		resumen_al = (dw_consulta.GetItemString(1,'resumen_al') = 'S')
		liquidacion = (dw_consulta.getitemstring(1,'liquidacion')='S')
		
		ap_desde = this.GetItemString(1,'apellidos_desde')
		ap_hasta = this.GetItemString(1,'apellidos_hasta')
		if f_es_vacio(ap_desde) or f_es_vacio(ap_hasta) then
			por_apellidos = false
		else
			por_apellidos = true
		end if
		
		n_col_desde = this.GetItemString(1,'n_col_desde')
		n_col_hasta = this.GetItemString(1,'n_col_hasta')
		if f_es_vacio(n_col_desde) or f_es_vacio(n_col_hasta) then
			por_numero = false
		else
			por_numero = true
		end if
		
		if not(por_apellidos) and not(por_numero) then
			Messagebox(g_titulo,"Es necesario indicar un rango de apellidos o de n$$HEX1$$fa00$$ENDHEX$$meros de colegiados",Stopsign!)
			return	
		end if

		ds_coleg = create datastore
		string l_campo
      	l_campo =  dw_consulta.getitemstring(1,"lista_extractos")
		if l_campo <> "" then
      	     ds_coleg.DataObject = 'd_conta_colegiados_lista'
	    elseif por_apellidos then
			ds_coleg.DataObject = 'd_conta_todos_los_colegiados'
		elseif por_numero then
			ds_coleg.DataObject = 'd_conta_todos_los_colegiados_por_numero'
		end if
		ds_coleg.SetTransObject(SQLCA)
		
		// Miramos a ver si utiliza lista	
		///////// Julian
		string sql_aux, campo		
		string incl_excl, operador_not
		operador_not = ''
		incl_excl = idw_general.GetItemString(1,'incluir_lista')
		if incl_excl = 'E' then operador_not = ' NOT '
		/*campo =  dw_consulta.getitemstring(1,"lista_extractos")
		if campo <>"" then*/
		i_sqL_nuevo = ds_coleg.describe("datawindow.table.select")
		if PosA(upper(i_sql_nuevo), "WHERE") > 0 then
			sql_aux = "and colegiados.id_colegiado " + operador_not + "IN (SELECT id_lista_miembro FROM listas_miembros WHERE id_lista='"+idw_general.getitemstring(1,'lista_extractos')+"')"
		else
			sql_aux = "WHERE colegiados.id_colegiado " + operador_not + "IN (SELECT id_lista_miembro FROM listas_miembros WHERE id_lista='"+idw_general.getitemstring(1,'lista_extractos')+"')"
		end if	
		if not isnull(sql_aux) then i_sql_nuevo += sql_aux
		
		ds_coleg.modify("datawindow.table.select= ~"" + i_sql_nuevo + "~"")
		/*end if*/
		
		///// Fin Julian

		st_mensaje.text = 'Buscando colegiados...'
		if l_campo <>"" then
		  ds_coleg.Retrieve()  	
		elseif por_apellidos then
			ds_coleg.Retrieve(ap_desde,ap_hasta, i_centro)
		elseif por_numero then
			ds_coleg.Retrieve(n_col_desde,n_col_hasta, i_centro)
		end if
		this.SetItem(1,'mensaje','Encontrados '+string(ds_coleg.rowcount())+' colegiados.')
		st_mensaje.text = ''
		cuantos_colegiados = ds_coleg.RowCount()
		if ds_coleg.RowCount() = 0 then
			Messagebox(g_titulo,"No se ha encontrado ning$$HEX1$$fa00$$ENDHEX$$n colegiado")
			destroy ds_coleg
			return
		end if
		
		primero = ds_coleg.GetItemString(1,'apellidos') + '-' + ds_coleg.GetItemString(1,'n_colegiado')
		ultimo = ds_coleg.GetItemString(cuantos_colegiados,'apellidos') + '-' + ds_coleg.GetItemString(cuantos_colegiados,'n_colegiado')
		
		int resp
		resp = Messagebox(g_titulo,"Se van a procesar "+string(cuantos_colegiados)+" empezando por "+primero+ " hasta " + ultimo + ". $$HEX1$$bf00$$ENDHEX$$Desea continuar?",Question!,Yesno!)
		if resp = 2 then
			destroy ds_coleg
			return
		end if

		
		// ABRIMOS LA VENTANA DE OPCIONES DE IMPRESION
		if this.Event csd_opciones_impresion()<>1 then return
		
		long seimprimen, seenvian, secreanpdfs
		double h,hi,hr,ap, ap_iva,asemas
		string ape_col, nom_col, email_impr, papel, direccion_email
		
//		ds_listado = create datastore
//		ds_listado.Dataobject = 'd_conta_extracto_resumen_listado'
//		ds_listado.SetTransObject(SQLCA)
		
		seimprimen = 0
		seenvian = 0
		secreanpdfs = 0
		
		FOR i=1 TO cuantos_colegiados
			
			// Comentada porque esta puesta despu$$HEX1$$e900$$ENDHEX$$s
			//st_mensaje.text = 'Procesando ' + string(i) + ' de ' + string(cuantos_colegiados) + '. '+string(seimprimen)+ ' lanzados por impresora.'
			
			///* Cambio para introducir el n$$HEX1$$fa00$$ENDHEX$$mero de colegiado en el motivo del env$$HEX1$$ed00$$ENDHEX$$o de correo. Ya que en el env$$HEX1$$ed00$$ENDHEX$$o por 
			// sockets los correos no se distinguen suficientemente en el env$$HEX1$$ed00$$ENDHEX$$o. CBI-144. ALEXIS. 05/02/2010 ****///
			
			i_impresion_formato.asunto_email = "Inf.Econ$$HEX1$$f300$$ENDHEX$$mica " + ds_coleg.GetItemString(i,'n_colegiado')
			///*******Fin cambio del t$$HEX1$$ed00$$ENDHEX$$tulo. Alexis. CBI-144*****///
			
			//Modificado Jesus 09-12-09 CLE-78
			//Se almacena el valor del email en la estructura para poder enviar la factura.
			//SCP-318 GENERICIDAD JESUS 15-04-2010
			//08-09-2010 Se deja el tratamiento de email personal o profesional para todos los casos y s$$HEX1$$f300$$ENDHEX$$lo se deja para la SCP-318 el tratamiento de checks
				
			//email1 = ds_coleg.GetItemString(i,'email')
			email1 = ds_coleg.GetItemString(i,'email_profesional')
			email = ''
			
			//Preferencia de email profesional (email2) sobre el personal (email1)
			/*if not f_es_vacio(email2) then //Tiene email profesional, lo pongo
				email = email2
			else //No tiene email profesional, pues vamos a por el personal
				if not f_es_vacio(email1) then //Si tiene se lo a$$HEX1$$f100$$ENDHEX$$ado
					email = email1
				end if
			end if*/
										
			if f_es_vacio(email1)  then
				i_impresion_formato.direccion_email = ''
				/*i_impresion_formato.papel='S'
				i_impresion_formato.email='N'*/				
			else
				i_impresion_formato.direccion_email=email1
				/*i_impresion_formato.papel='N'
				i_impresion_formato.email='S'*/
			end if
					
			//
			//********************************************* 
			//** Se hace tratamiento solo si la variable global esta activa **
			//**							SCP-318									    **
			//*********************************************
			
			if g_imprime_resumen_sin_email ='S' then
				
				//Se guardan los valores de la ventana por ser envio masivo
				email_impr=i_impresion_formato.email
				papel=i_impresion_formato.papel
				
				//Se hace el tratamiento:
					
				//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
				//       Papel            Email            |       Resultado
				//  ------------------------------------------------------------------------------------
				//  ------------------------------------------------------------------------------------
				//         x                                   |          Papel
				//  ------------------------------------------------------------------------------------
				//                             x               |         Si tiene email, email, sino papel
				//  ------------------------------------------------------------------------------------
				//         x                  x                |        Si tiene email, email, sino papel
				//  ------------------------------------------------------------------------------------
				//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
				
				if (email_impr='S') then
					if f_es_vacio(email1) then
						i_impresion_formato.papel='S'
						i_impresion_formato.email='N'
					else
						i_impresion_formato.papel='N'
						i_impresion_formato.email='S'
					end if
				else
					if (papel='S') then
						i_impresion_formato.papel='S'
						i_impresion_formato.email='N'
					end if
				end if
					
			end if
					
			i_id_col = ds_coleg.GetItemString(i,'id_colegiado')
			this.TriggerEvent("csd_extracto_1_colegiado")
			if idw_resumen.RowCount() = 0 then continue
//			if h+hi+hr+ap+ap_iva+asemas = 0 then continue
				
			// Vamos a rellenar la linea en el listado resumen
//			ds_listado.InsertRow(0)
//			ds_listado.SetItem(ds_listado.RowCount(),'n_colegiado', idw_resumen.GetItemString(1,'n_colegiado'))
//			ape_col = idw_resumen.GetItemString(1,'apellidos')
//			nom_col = idw_resumen.GetItemString(1,'nombre')
//			if isnull(nom_col) then nom_col = ''
//			ape_col = trim(ape_col)+ ' ' + trim(nom_col)
//			ds_listado.SetItem(ds_listado.RowCount(),'colegiado', ape_col)
//			ds_listado.SetItem(ds_listado.RowCount(),'honor', h)
//			ds_listado.SetItem(ds_listado.RowCount(),'honor_iva', hi )
//			ds_listado.SetItem(ds_listado.RowCount(),'honor_irpf',hr )
//			ds_listado.SetItem(ds_listado.RowCount(),'aport', ap)
//			ds_listado.SetItem(ds_listado.RowCount(),'aport_iva',ap_iva )
//			ds_listado.SetItem(ds_listado.RowCount(),'asemas',asemas )
//			ds_listado.SetItem(ds_listado.RowCount(),'df',i_df )
//			ds_listado.SetItem(ds_listado.RowCount(),'hf',i_hf )
				
			if (i_impresion_formato.papel='S') then
				seimprimen++
			end if
			if (i_impresion_formato.email='S') then
				seenvian++
			end if 
			if (i_impresion_formato.pdf='S') then
				secreanpdfs++
			end if
			st_mensaje.text = 'Procesando ' + string(i) + ' de ' + string(cuantos_colegiados) + '. '+string(seimprimen)+ ' lanzados por impresora. '+string(seenvian)+' enviados por mail. '+string(secreanpdfs)+" PDF's generados."
	
	
			// Inicializamos unos valores para el objeto de impresi$$HEX1$$f300$$ENDHEX$$n avanzado
			// Nombre del fichero pdf generado 'Info_economica_' + n$$HEX2$$ba002000$$ENDHEX$$colegiado + fecha
			i_impresion_formato.id_receptor=i_id_col
			
			/*email=f_devuelve_mail(i_id_col)
			if f_es_vacio(email) then
				i_impresion_formato.direccion_email = ''
			else
				i_impresion_formato.direccion_email=email
			end if*/
			//i_impresion_formato.nombre = 'Info_economica_'+idw_resumen.GetItemString(1,'n_colegiado')+string(today(),'ddmmyyyy')
			//i_impresion_formato.ruta_relativa = g_ejercicio+'\'+idw_resumen.GetItemString(1,'n_colegiado')
				
			i_impresion_formato.ruta_relativa1=''
			i_impresion_formato.ruta_relativa2=i_ejercicio
			i_impresion_formato.ruta_relativa3=idw_resumen.GetItemString(1,'n_colegiado')			
		
			if idw_consulta.getitemstring(1,'radio') = 'T' then
				if idw_consulta.getitemstring(1,'trimestres') = '5' then
					i_impresion_formato.ruta_relativa3+='\anual'
				else
					i_impresion_formato.ruta_relativa3+='\trimestral'
				end if
			end if				 

			
			//Ahora a imprimir lo que toque
			Datawindowchild listafact
			idw_resumen.GetChild('dw_3', listafact)
				
			boolean tiene_facturas = false, tiene_iva = false, tiene_ing_gas = false
			// NUEVO : Imprimimos la hoja  resumen de facturas solo si tiene facturas	
			if LenA(	string(	idw_resumen.object.DW_3.object.datawindow.data) ) > 0 then tiene_facturas = true else tiene_facturas = false
			if LenA(	string(	idw_iva_col.object.DW_1.object.datawindow.data) + string(	idw_iva_col.object.DW_3.object.datawindow.data)) > 0 then tiene_iva = true else tiene_iva = false
			if LenA(	string(	idw_ing_gas.object.DW_1.object.datawindow.data) + string(	idw_ing_gas.object.DW_2.object.datawindow.data)) > 0 then tiene_ing_gas = true else tiene_ing_gas = false	
		
			boolean tiene_ing_gas_gui
			if LenA(	string(	idw_ing_gas_renta.object.DW_1.object.datawindow.data) + string(	idw_ing_gas_renta.object.DW_2.object.datawindow.data)) > 0 then tiene_ing_gas_gui = true else tiene_ing_gas_gui = false	

			string colegiado
			colegiado =idw_resumen.GetItemString(1,'n_colegiado')
			i_fecha_desde = date(dw_consulta.getitemdatetime(1,"df"))
			i_fecha_hasta = date(dw_consulta.getitemdatetime(1,"hf"))
				
			if dw_consulta.getitemstring(1,"radio") = "M" then
				tri_anyo = 'Eventual'
			else
				choose case dw_consulta.getitemstring(1,"trimestres")
					case "1"
						tri_anyo = 'T1'
					case "2"
						tri_anyo = 'T2'
					case "3"
						tri_anyo = 'T3'
					case "4"
						tri_anyo = 'T4'
					case "5"
						tri_anyo =i_ejercicio
				end choose
			end if			
			
			// Ponermos el nombre fijo para que los genere todos y no los machaque
			if resumen and tiene_facturas	then
				i_impresion_formato.dw = idw_resumen
				string nom,tipo
				tipo = 'Resumen'
				nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
				i_impresion_formato.nombre = "Resumen"
				i_impresion_formato.nombre = nom
				i_impresion_formato.f_impresion()
			end if
	
			if honorarios and idw_honor.RowCount() > 0 then
				// 10/10/2005 - Esto se hace porque es la $$HEX1$$fa00$$ENDHEX$$nica forma que se ha encontrado para que imprima
				// el dw igual que se visualiza y se imprime de forma individual (Problema que han tenido en Bizkaia)
				idw_honor.setfilter("")
				idw_honor.filter()
				
				i_impresion_formato.dw = idw_honor
				i_impresion_formato.nombre = "Cuenta Honorarios"
				tipo = "Cuenta Honorarios"
				i_impresion_formato.nombre = nom
				nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
				select n_colegiado into :n_col from colegiados where id_colegiado = :i_id_col; 
				i_impresion_formato.nombre = i_ejercicio + n_col + 'honorarios' + tri_anyo + i_f_desde + i_f_hasta
				i_impresion_formato.f_impresion()
			end if

			if retenciones and idw_reten.RowCount() > 0 then 
				i_impresion_formato.dw = idw_reten
				i_impresion_formato.nombre = "Cuenta Retenciones"
				tipo = "Cuenta Retenciones"
				nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
				i_impresion_formato.nombre = nom
				i_impresion_formato.f_impresion()
			end if
	
			if iva and idw_iva.RowCount() > 0 then 
				i_impresion_formato.dw = idw_iva
				i_impresion_formato.nombre = "Cuenta IVA"
				tipo = "CuentaI VA"
				nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
				i_impresion_formato.nombre = nom
				i_impresion_formato.f_impresion()
			end if
				
			if fact_honor and idw_fact_honor.RowCount() > 0 then 
				i_impresion_formato.dw = idw_fact_honor
				i_impresion_formato.nombre = "Facturas Honorarios"
				tipo = "Facturas Honorarios"
				nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
				i_impresion_formato.nombre = nom
				i_impresion_formato.f_impresion()
			end if
			
			if fact_gastos and idw_fact_gastos.RowCount() > 0 then 
				i_impresion_formato.dw = idw_fact_gastos
				i_impresion_formato.nombre = "Facturas Gastos"				
				Tipo = "Facturas Gastos"
				nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
				i_impresion_formato.nombre =nom
				i_impresion_formato.f_impresion()
			end if
			
			if liquidacion and idw_liquidacion_mur.RowCount() > 0 then 
				i_impresion_formato.dw = idw_liquidacion_mur
				i_impresion_formato.nombre = "Liquidaciones"				
				Tipo = "Liquidaciones"
				nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
				i_impresion_formato.nombre =nom
				i_impresion_formato.ruta_relativa3+='\quincenal'	
				i_impresion_formato.f_impresion()
			end if
			
			if iva_col and tiene_iva then 
				string nombre
				i_impresion_formato.dw = idw_iva_col
				i_impresion_formato.nombre = "Resumen IVA"		
				tipo = "Resumen IVA"
				nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
				i_impresion_formato.nombre = nom
				i_impresion_formato.f_impresion()
			end if
			
			if resumen_al and tiene_facturas   then
				i_impresion_formato.dw = idw_resumen_al
				i_impresion_formato.nombre = "Resumen y Saldo"
				tipo = "Resumen y Saldo"
				nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
				i_impresion_formato.nombre = nom
				i_impresion_formato.f_impresion()
			end if
				
			tipo = "Ingresos Gastos"
			nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
			i_impresion_formato.nombre = nom
			
			CHOOSE CASE g_colegio
				case 'COAATGUI'
					if ing_gas and tiene_ing_gas_gui then
						i_impresion_formato.dw = idw_ing_gas_renta
						if g_activa_multiempresa = 'S' then
	               			f_logo_empresa(g_empresa ,idw_ing_gas_renta, '000')
                   		end if
						i_impresion_formato.f_impresion()
					end if
				case 'COAATLR'
					if ing_gas and tiene_ing_gas then 
						i_impresion_formato.dw = idw_ing_gas_lr
						i_impresion_formato.f_impresion()
					end if
				case 'COAATTFE'
					if ing_gas and tiene_ing_gas then 
						i_impresion_formato.dw = idw_ing_gas_tfe
						i_impresion_formato.f_impresion()
					end if
				case 'COAATZ'
					if ing_gas and tiene_ing_gas then 
						i_impresion_formato.dw = idw_ing_gas_za
						if g_activa_multiempresa = 'S' then
	                       	f_logo_empresa(g_empresa ,idw_ing_gas_za, '000')
                   		end if
						i_impresion_formato.f_impresion()
					end if
				case 'COAATGU'
					if ing_gas and tiene_ing_gas then 
						i_impresion_formato.dw = idw_ing_gas_gu
						i_impresion_formato.f_impresion()
					end if
				case 'COAATLE'
					if ing_gas and tiene_ing_gas then 
						i_impresion_formato.dw = idw_ing_gas_le
						i_impresion_formato.f_impresion()
					end if					
				case 'COAATAVI'
					if ing_gas and tiene_ing_gas then 
						i_impresion_formato.dw = idw_ing_gas_avi
						i_impresion_formato.f_impresion()
					end if
				case 'COAATNA'
					if ing_gas and tiene_ing_gas then 
						i_impresion_formato.dw = idw_ing_gas_na
						if g_activa_multiempresa = 'S' then
	                      		f_logo_empresa(g_empresa ,idw_ing_gas_na,'000')
                   		end if
						i_impresion_formato.f_impresion()
					end if
				case else
					if ing_gas and tiene_ing_gas then
						i_impresion_formato.dw = idw_ing_gas
						if g_colegio = 'COAATB' and g_activa_multiempresa = 'S' then
	               			f_logo_empresa(g_empresa ,idw_ing_gas, '001')
                   		end if
						i_impresion_formato.f_impresion()
					end if						
			END CHOOSE
			
			//Modificado Jesus 12-02-10 cbi-141 
			// Se aparta del choose case la restauraci$$HEX1$$f300$$ENDHEX$$n de los valores de envio masivo de mails.
			// En vez de parametrizar por colegios, se parametriza por la variable global
			//if (g_colegio = 'COAATLE' or g_colegio = 'COAATB') then
			if g_imprime_resumen_sin_email ='S' then
				//Ponemos los campos como venian de la ventana de impresi$$HEX1$$f300$$ENDHEX$$n...
				i_impresion_formato.email=email_impr
				i_impresion_formato.papel=papel
			end if
				
		NEXT
	
	//		if listado_resumen and ds_listado.RowCount() > 0 then
	//			ds_listado.Sort()
	//		//	ds_listado.Print()
	//		end if
			
	//		If ds_listado.RowCount() > 0 then
	//			resp = MessageBox(g_titulo,'$$HEX1$$bf00$$ENDHEX$$Desea guardar los datos del resumen en un fichero?',Question!,Yesno!)
	//			if resp = 1 then idw_resumen.saveas()//s_listado.SaveAs()
	//		end if
	
		destroy ds_coleg
	//	destroy ds_listado	
		event csd_bd_anterior() // Restauramos la conexi$$HEX1$$f300$$ENDHEX$$n inicial
		// Miramos si se coge el listado de la lista


	case 'b_listas'
		Open(w_listas_seleccion)
		this.SetItem(1,'lista_colegiados',Message.Stringparm)		
END CHOOSE

end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)


end event

event itemchanged;call super::itemchanged;string l_anyo, l_f_desde,l_f_hasta
this.acceptText()
i_fecha_desde = date(dw_consulta.getitemdatetime(1,"df"))
i_fecha_hasta = date(dw_consulta.getitemdatetime(1,"hf"))
 CHOOSE CASE dwo.name
	case "radio"		
       if data = "T" then
         dw_consulta.object.trimestres.visible = true				
		dw_consulta.object.anual.visible = false
         if dw_consulta.object.trimestres.visible  then
				dw_consulta.object.t_trimestres.visible = true	
		end if
	  end if
	  if data ="M"then
	    dw_consulta.object.anual.visible = false
         dw_consulta.object.trimestres.visible = false
     	dw_consulta.object.t_trimestres.visible = false
 	    tri_anyo = 'Eventual'
       end if
case "anual"	    			
	      l_anyo =  dw_consulta.getitemstring(row,"anual")	  
      	  l_f_desde = "01/01/" + l_anyo
		  l_f_hasta = "31/12/"  + l_anyo
		  dw_consulta.setitem(row,"df",date(l_f_desde))
		  dw_consulta.setitem(row,"hf",date(l_f_hasta))	
		  dw_consulta.object.anual.visible = true	
           tri_anyo = l_anyo
case "trimestres"
	l_anyo = string(year(today()))
	dw_consulta.object.t_trimestres.visible = true
		if data = "1" then
		 dw_consulta.object.anual.visible = false
  		 l_f_desde = "01/01/" + l_anyo
		 l_f_hasta = "31/03/"  + l_anyo
		 dw_consulta.setitem(row,"df",date(l_f_desde))
		 dw_consulta.setitem(row,"hf",date(l_f_hasta))		
		 tri_anyo = 'T1'
	elseif data = "2" then
		 dw_consulta.object.anual.visible = false
  		 l_f_desde = "01/04/" + l_anyo
		 l_f_hasta = "30/06/"  + l_anyo
		 dw_consulta.setitem(row,"df",date(l_f_desde))
		 dw_consulta.setitem(row,"hf",date(l_f_hasta))		   
 		 tri_anyo = 'T2'
	elseif data = "3" then
		 dw_consulta.object.anual.visible = false
  		 l_f_desde = "01/07/" + l_anyo
		 l_f_hasta = "30/09/"  + l_anyo
		 dw_consulta.setitem(row,"df",date(l_f_desde))
		 dw_consulta.setitem(row,"hf",date(l_f_hasta))		   
		 tri_anyo = 'T3'		 
  	elseif data = "4" then
		 dw_consulta.object.anual.visible = false
  		 l_f_desde = "01/10/" + l_anyo
		 l_f_hasta = "31/12/"  + l_anyo
		 dw_consulta.setitem(row,"df",date(l_f_desde))
		 dw_consulta.setitem(row,"hf",date(l_f_hasta))		
		 tri_anyo = 'T4'
	elseif data = "5" then
		 dw_consulta.object.anual.visible = true	
		 // Cojo el ejercicio de la aplicacion
		//l_anyo = string(year(today()))
		  l_anyo =i_ejercicio
		  dw_consulta.setitem(row,"anual",l_anyo)
		  dw_consulta.object.anual.visible = true	
		  l_f_desde = "01/01/" + l_anyo
		  l_f_hasta = "31/12/"  + l_anyo
		  dw_consulta.setitem(row,"df",date(l_f_desde))
		  dw_consulta.setitem(row,"hf",date(l_f_hasta))
           tri_anyo = l_anyo
		 
	end if
		
end choose
this.acceptText()
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Resumen (Facturas)"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
dw_resumen dw_resumen
cb_2 cb_2
end type

on tabpage_1.create
this.dw_resumen=create dw_resumen
this.cb_2=create cb_2
this.Control[]={this.dw_resumen,&
this.cb_2}
end on

on tabpage_1.destroy
destroy(this.dw_resumen)
destroy(this.cb_2)
end on

type dw_resumen from datawindow within tabpage_1
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 20
string title = "none"
string dataobject = "d_infocol"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within tabpage_1
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;//if idw_resumen.RowCount() > 0 then idw_resumen.Print()

if idw_resumen.RowCount() = 0 then return

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_resumen
i_impresion_formato.nombre = 'Resumen'
string nom,tipo,colegiado

tipo = 'Resumen'
colegiado =idw_resumen.GetItemString(1,'n_colegiado') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom

i_impresion_formato.impresora_pag_hasta = long(idw_resumen.Describe("evaluate('PageCount()',1)"))

if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if

end event

type tabpage_1a from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Resumen Fact. y Saldo"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
cb_22 cb_22
dw_resumen_al dw_resumen_al
end type

on tabpage_1a.create
this.cb_22=create cb_22
this.dw_resumen_al=create dw_resumen_al
this.Control[]={this.cb_22,&
this.dw_resumen_al}
end on

on tabpage_1a.destroy
destroy(this.cb_22)
destroy(this.dw_resumen_al)
end on

type cb_22 from commandbutton within tabpage_1a
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;//if idw_resumen.RowCount() > 0 then idw_resumen.Print()

if idw_resumen_al.RowCount() = 0 then return

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_resumen_al
i_impresion_formato.nombre = 'Resumen'
string nom,tipo,colegiado

tipo = 'Resumen'
colegiado =idw_resumen_al.GetItemString(1,'n_colegiado') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom
i_impresion_formato.impresora_pag_hasta = long(idw_resumen_al.Describe("evaluate('PageCount()',1)"))

if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if

end event

type dw_resumen_al from datawindow within tabpage_1a
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 20
string title = "none"
string dataobject = "d_infocol_al"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Resumen IVA (Facturas)"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
cb_7 cb_7
dw_iva_col dw_iva_col
end type

on tabpage_6.create
this.cb_7=create cb_7
this.dw_iva_col=create dw_iva_col
this.Control[]={this.cb_7,&
this.dw_iva_col}
end on

on tabpage_6.destroy
destroy(this.cb_7)
destroy(this.dw_iva_col)
end on

type cb_7 from commandbutton within tabpage_6
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;//if idw_iva_col.RowCount() > 0 then idw_iva_col.Print()

if idw_iva_col.RowCount() = 0 then return

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_iva_col
i_impresion_formato.nombre = 'Resumen IVA'
string nom,tipo,colegiado

tipo = 'Resumen IVA'
colegiado =idw_iva_col.GetItemString(1,'n_colegiado') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom
i_impresion_formato.impresora_pag_hasta = long(idw_iva_col.Describe("evaluate('PageCount()',1)"))

if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if

end event

type dw_iva_col from u_dw within tabpage_6
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 10
string dataobject = "d_infocol_iva"
boolean hscrollbar = true
boolean righttoleft = true
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Cta. Honorarios"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
dw_honor dw_honor
cb_3 cb_3
dw_honor1 dw_honor1
end type

on tabpage_2.create
this.dw_honor=create dw_honor
this.cb_3=create cb_3
this.dw_honor1=create dw_honor1
this.Control[]={this.dw_honor,&
this.cb_3,&
this.dw_honor1}
end on

on tabpage_2.destroy
destroy(this.dw_honor)
destroy(this.cb_3)
destroy(this.dw_honor1)
end on

type dw_honor from u_dw within tabpage_2
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 11
string dataobject = "d_conta_extracto_colegiado"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_setprintpreview(true)
end event

type cb_3 from commandbutton within tabpage_2
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;//if idw_honor.RowCount() > 0 then idw_honor.Print()

if idw_honor.RowCount() = 0 then return

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_honor
i_impresion_formato.nombre = 'Cuenta Honorarios'
string nom,tipo,colegiado

tipo = 'Cuenta Honorarios'
colegiado =idw_honor.GetItemString(1,'compute_4') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom
i_impresion_formato.impresora_pag_hasta = long(idw_honor.Describe("evaluate('PageCount()',1)"))

if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if

end event

type dw_honor1 from datawindow within tabpage_2
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 20
string title = "none"
string dataobject = "d_conta_extracto_colegiado"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Cta. Retenciones"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
cb_5 cb_5
dw_reten dw_reten
end type

on tabpage_3.create
this.cb_5=create cb_5
this.dw_reten=create dw_reten
this.Control[]={this.cb_5,&
this.dw_reten}
end on

on tabpage_3.destroy
destroy(this.cb_5)
destroy(this.dw_reten)
end on

type cb_5 from commandbutton within tabpage_3
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;//if idw_reten.RowCount() > 0 then idw_reten.Print()

if idw_reten.RowCount() = 0 then return

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_reten
i_impresion_formato.nombre = 'Cuenta Retenciones'
string nom,tipo,colegiado

tipo = 'Cuenta Retenciones'
colegiado =idw_reten.GetItemString(1,'compute_4') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom
i_impresion_formato.impresora_pag_hasta = long(idw_reten.Describe("evaluate('PageCount()',1)"))

if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if

end event

type dw_reten from u_dw within tabpage_3
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 21
string dataobject = "d_conta_extracto_colegiado"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_setprintpreview(true)
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Cta. IVA/IGIC"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
cb_4 cb_4
dw_iva dw_iva
end type

on tabpage_4.create
this.cb_4=create cb_4
this.dw_iva=create dw_iva
this.Control[]={this.cb_4,&
this.dw_iva}
end on

on tabpage_4.destroy
destroy(this.cb_4)
destroy(this.dw_iva)
end on

type cb_4 from commandbutton within tabpage_4
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

type dw_iva from datawindow within tabpage_4
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 20
string title = "none"
string dataobject = "d_conta_extracto_colegiado"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Fact. Honorarios"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
cb_6 cb_6
dw_fact_honor dw_fact_honor
end type

on tabpage_5.create
this.cb_6=create cb_6
this.dw_fact_honor=create dw_fact_honor
this.Control[]={this.cb_6,&
this.dw_fact_honor}
end on

on tabpage_5.destroy
destroy(this.cb_6)
destroy(this.dw_fact_honor)
end on

type cb_6 from commandbutton within tabpage_5
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;//dw_fact_honor.Print()

if dw_fact_honor.RowCount() = 0 then return

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_fact_honor
i_impresion_formato.nombre = 'Facturas Honorarios'
string nom,tipo,colegiado

tipo = 'Facturas Honorarios'
colegiado =idw_fact_honor.GetItemString(1,'compute_4') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom
i_impresion_formato.impresora_pag_hasta = long(dw_fact_honor.Describe("evaluate('PageCount()',1)"))

if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if

end event

type dw_fact_honor from u_dw within tabpage_5
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 11
string dataobject = "d_conta_extracto_honorarios"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_setprintpreview(true)
end event

type tabpage_13 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 79741120
string text = "Fact. Gastos"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
cb_11 cb_11
dw_fact_gastos dw_fact_gastos
end type

on tabpage_13.create
this.cb_11=create cb_11
this.dw_fact_gastos=create dw_fact_gastos
this.Control[]={this.cb_11,&
this.dw_fact_gastos}
end on

on tabpage_13.destroy
destroy(this.cb_11)
destroy(this.dw_fact_gastos)
end on

type cb_11 from commandbutton within tabpage_13
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;//dw_fact_gastos.Print()

if dw_fact_gastos.RowCount() = 0 then return

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_fact_gastos
i_impresion_formato.nombre = 'Facturas Gastos'
string nom,tipo,colegiado

tipo = 'Facturas gastos'
colegiado =idw_fact_gastos.GetItemString(1,'compute_4') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom
i_impresion_formato.impresora_pag_hasta = long(dw_fact_gastos.Describe("evaluate('PageCount()',1)"))

if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if

end event

type dw_fact_gastos from u_dw within tabpage_13
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 21
string dataobject = "d_conta_extracto_gastos"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_setprintpreview(true)
end event

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Ingresos - Gastos"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
cb_9 cb_9
cb_8 cb_8
dw_ing_gas dw_ing_gas
end type

on tabpage_7.create
this.cb_9=create cb_9
this.cb_8=create cb_8
this.dw_ing_gas=create dw_ing_gas
this.Control[]={this.cb_9,&
this.cb_8,&
this.dw_ing_gas}
end on

on tabpage_7.destroy
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.dw_ing_gas)
end on

type cb_9 from commandbutton within tabpage_7
integer x = 3136
integer y = 112
integer width = 329
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Disco H. 190"
end type

event clicked;open(w_inggas_consulta)
end event

type cb_8 from commandbutton within tabpage_7
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;//if idw_ing_gas.RowCount() > 0 then idw_ing_gas.Print()

if idw_ing_gas.RowCount() = 0 then return

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_ing_gas
i_impresion_formato.nombre = 'Ingresos Gastos'
string nom,tipo,colegiado

tipo = 'Ingresos Gastos'
colegiado =idw_ing_gas.GetItemString(1,'n_colegiado') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom
i_impresion_formato.impresora_pag_hasta = long(idw_ing_gas.Describe("evaluate('PageCount()',1)"))

if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if

end event

type dw_ing_gas from u_dw within tabpage_7
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 11
string dataobject = "d_inggas_biz"
boolean hscrollbar = true
end type

type tabpage_8 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Ingresos - Gastos"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
cb_10 cb_10
dw_ing_gas_renta dw_ing_gas_renta
end type

on tabpage_8.create
this.cb_10=create cb_10
this.dw_ing_gas_renta=create dw_ing_gas_renta
this.Control[]={this.cb_10,&
this.dw_ing_gas_renta}
end on

on tabpage_8.destroy
destroy(this.cb_10)
destroy(this.dw_ing_gas_renta)
end on

type cb_10 from commandbutton within tabpage_8
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;//if idw_ing_gas_renta.RowCount() > 0 then idw_ing_gas_renta.Print()

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_ing_gas_renta
i_impresion_formato.nombre = 'Ingresos Gastos'
string nom,tipo,colegiado

tipo = 'Ingresos Gastos'
colegiado =idw_ing_gas_renta.GetItemString(1,'n_colegiado') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom
i_impresion_formato.impresora_pag_hasta = long(idw_ing_gas_renta.Describe("evaluate('PageCount()',1)"))

if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if

end event

type dw_ing_gas_renta from u_dw within tabpage_8
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 50
string dataobject = "d_inggas_gui"
boolean hscrollbar = true
end type

type tabpage_9 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Ingresos - Gastos"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
cb_imprimir_tabpage_9 cb_imprimir_tabpage_9
dw_ing_gas_lr dw_ing_gas_lr
end type

on tabpage_9.create
this.cb_imprimir_tabpage_9=create cb_imprimir_tabpage_9
this.dw_ing_gas_lr=create dw_ing_gas_lr
this.Control[]={this.cb_imprimir_tabpage_9,&
this.dw_ing_gas_lr}
end on

on tabpage_9.destroy
destroy(this.cb_imprimir_tabpage_9)
destroy(this.dw_ing_gas_lr)
end on

type cb_imprimir_tabpage_9 from commandbutton within tabpage_9
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;//if idw_ing_gas_lr.RowCount() > 0 then idw_ing_gas_lr.Print()

if idw_ing_gas_lr.RowCount() = 0 then return

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_ing_gas_lr
i_impresion_formato.nombre = 'Ingresos Gastos'
string nom,tipo,colegiado

tipo = 'Ingresos Gastos'
colegiado =idw_ing_gas_lr.GetItemString(1,'n_colegiado') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom
i_impresion_formato.impresora_pag_hasta = long(idw_ing_gas_lr.Describe("evaluate('PageCount()',1)"))

if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if


end event

type dw_ing_gas_lr from u_dw within tabpage_9
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 11
string dataobject = "d_inggas_lr"
end type

type tabpage_10 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Ingresos - Gastos"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
cb_imprimir_tabpage_10 cb_imprimir_tabpage_10
dw_ing_gas_tfe dw_ing_gas_tfe
end type

on tabpage_10.create
this.cb_imprimir_tabpage_10=create cb_imprimir_tabpage_10
this.dw_ing_gas_tfe=create dw_ing_gas_tfe
this.Control[]={this.cb_imprimir_tabpage_10,&
this.dw_ing_gas_tfe}
end on

on tabpage_10.destroy
destroy(this.cb_imprimir_tabpage_10)
destroy(this.dw_ing_gas_tfe)
end on

type cb_imprimir_tabpage_10 from commandbutton within tabpage_10
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;//if idw_ing_gas_tfe.RowCount() > 0 then idw_ing_gas_tfe.Print()

if idw_ing_gas_tfe.RowCount() = 0 then return

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_ing_gas_tfe
i_impresion_formato.nombre = 'Ingresos Gastos'
string nom,tipo,colegiado

tipo = 'Resumen'
colegiado =idw_ing_gas_tfe.GetItemString(1,'n_colegiado') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom
i_impresion_formato.impresora_pag_hasta = long(idw_ing_gas_tfe.Describe("evaluate('PageCount()',1)"))

if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if


end event

type dw_ing_gas_tfe from u_dw within tabpage_10
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 10
string dataobject = "d_inggas_tfe_347"
end type

type tabpage_11 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Ingresos - Gastos"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
cb_imprimir_tabpage_11 cb_imprimir_tabpage_11
dw_ing_gas_za dw_ing_gas_za
end type

on tabpage_11.create
this.cb_imprimir_tabpage_11=create cb_imprimir_tabpage_11
this.dw_ing_gas_za=create dw_ing_gas_za
this.Control[]={this.cb_imprimir_tabpage_11,&
this.dw_ing_gas_za}
end on

on tabpage_11.destroy
destroy(this.cb_imprimir_tabpage_11)
destroy(this.dw_ing_gas_za)
end on

type cb_imprimir_tabpage_11 from commandbutton within tabpage_11
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;//if idw_ing_gas_za.RowCount() > 0 then idw_ing_gas_za.Print()

if idw_ing_gas_za.RowCount() = 0 then return

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_ing_gas_za
i_impresion_formato.nombre = 'Ingresos Gastos'
string nom,tipo,colegiado

tipo = 'Ingresos Gastos'
colegiado =idw_ing_gas_za.GetItemString(1,'n_colegiado') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom
i_impresion_formato.impresora_pag_hasta = long(idw_ing_gas_za.Describe("evaluate('PageCount()',1)"))
if g_activa_multiempresa = 'S' then
	f_logo_empresa(g_empresa ,idw_ing_gas_za,'000')
end if
if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if


end event

type dw_ing_gas_za from u_dw within tabpage_11
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 50
string dataobject = "d_inggas_za"
end type

type tabpage_14 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Ingresos - Gastos"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
dw_ing_gas_gu dw_ing_gas_gu
cb_imprimir_tabpage_14 cb_imprimir_tabpage_14
end type

on tabpage_14.create
this.dw_ing_gas_gu=create dw_ing_gas_gu
this.cb_imprimir_tabpage_14=create cb_imprimir_tabpage_14
this.Control[]={this.dw_ing_gas_gu,&
this.cb_imprimir_tabpage_14}
end on

on tabpage_14.destroy
destroy(this.dw_ing_gas_gu)
destroy(this.cb_imprimir_tabpage_14)
end on

type dw_ing_gas_gu from u_dw within tabpage_14
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 10
string dataobject = "d_inggas_gu"
end type

type cb_imprimir_tabpage_14 from commandbutton within tabpage_14
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;//if idw_ing_gas_gu.RowCount() > 0 then idw_ing_gas_gu.Print()

if idw_ing_gas_gu.RowCount() = 0 then return

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_ing_gas_gu
i_impresion_formato.nombre = 'Ingresos Gastos'
string nom,tipo,colegiado

tipo = 'Ingresos Gastos'
colegiado =idw_ing_gas_gu.GetItemString(1,'n_colegiado') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom
i_impresion_formato.impresora_pag_hasta = long(idw_ing_gas_gu.Describe("evaluate('PageCount()',1)"))

if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if


end event

type tabpage_15 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Ingresos - Gastos"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
cb_imprimir_tabpage_15 cb_imprimir_tabpage_15
dw_ing_gas_le dw_ing_gas_le
end type

on tabpage_15.create
this.cb_imprimir_tabpage_15=create cb_imprimir_tabpage_15
this.dw_ing_gas_le=create dw_ing_gas_le
this.Control[]={this.cb_imprimir_tabpage_15,&
this.dw_ing_gas_le}
end on

on tabpage_15.destroy
destroy(this.cb_imprimir_tabpage_15)
destroy(this.dw_ing_gas_le)
end on

type cb_imprimir_tabpage_15 from commandbutton within tabpage_15
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;if idw_ing_gas_le.RowCount() = 0 then return

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_ing_gas_le
i_impresion_formato.nombre = 'Ingresos Gastos'
string nom,tipo,colegiado

tipo = 'Ingresos gastos'
colegiado =idw_ing_gas_le.GetItemString(1,'n_colegiado') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom
i_impresion_formato.impresora_pag_hasta = long(idw_ing_gas_le.Describe("evaluate('PageCount()',1)"))

if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if

end event

type dw_ing_gas_le from u_dw within tabpage_15
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 10
string dataobject = "d_inggas_le"
end type

type tabpage_16 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Ingresos - Gastos"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
dw_ing_gas_avi dw_ing_gas_avi
cb_imprimir_tabpage_16 cb_imprimir_tabpage_16
end type

on tabpage_16.create
this.dw_ing_gas_avi=create dw_ing_gas_avi
this.cb_imprimir_tabpage_16=create cb_imprimir_tabpage_16
this.Control[]={this.dw_ing_gas_avi,&
this.cb_imprimir_tabpage_16}
end on

on tabpage_16.destroy
destroy(this.dw_ing_gas_avi)
destroy(this.cb_imprimir_tabpage_16)
end on

type dw_ing_gas_avi from u_dw within tabpage_16
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 10
string dataobject = "d_inggas_avi"
end type

type cb_imprimir_tabpage_16 from commandbutton within tabpage_16
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;if idw_ing_gas_avi.RowCount() = 0 then return

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_ing_gas_avi
i_impresion_formato.nombre = 'Ingresos Gastos'
string nom,tipo,colegiado

tipo = 'Ingresos Gastos'
colegiado =idw_ing_gas_avi.GetItemString(1,'n_colegiado') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom
i_impresion_formato.impresora_pag_hasta = long(idw_ing_gas_avi.Describe("evaluate('PageCount()',1)"))

if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if

end event

type tabpage_17 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Liquidaci$$HEX1$$f300$$ENDHEX$$n"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
cb_imprimir_tabpage_17 cb_imprimir_tabpage_17
dw_liquidacion_mur dw_liquidacion_mur
end type

on tabpage_17.create
this.cb_imprimir_tabpage_17=create cb_imprimir_tabpage_17
this.dw_liquidacion_mur=create dw_liquidacion_mur
this.Control[]={this.cb_imprimir_tabpage_17,&
this.dw_liquidacion_mur}
end on

on tabpage_17.destroy
destroy(this.cb_imprimir_tabpage_17)
destroy(this.dw_liquidacion_mur)
end on

type cb_imprimir_tabpage_17 from commandbutton within tabpage_17
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;if idw_liquidacion_mur.RowCount() = 0 then return

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_liquidacion_mur
i_impresion_formato.nombre = 'Liquidacion'
string nom,tipo,colegiado

tipo = 'Liquidacion'
colegiado =idw_liquidacion_mur.GetItemString(1,'n_colegiado') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom
i_impresion_formato.impresora_pag_hasta = long(idw_liquidacion_mur.Describe("evaluate('PageCount()',1)"))

if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if

end event

type dw_liquidacion_mur from u_csd_dw within tabpage_17
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 11
string dataobject = "d_liquidacion_listado_colegiado_mu"
end type

event constructor;call super::constructor;this.of_setprintpreview(true)
end event

type tabpage_18 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Ingresos - Gastos"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
cb_imprimir_tabpage_18 cb_imprimir_tabpage_18
dw_ing_gas_na dw_ing_gas_na
end type

on tabpage_18.create
this.cb_imprimir_tabpage_18=create cb_imprimir_tabpage_18
this.dw_ing_gas_na=create dw_ing_gas_na
this.Control[]={this.cb_imprimir_tabpage_18,&
this.dw_ing_gas_na}
end on

on tabpage_18.destroy
destroy(this.cb_imprimir_tabpage_18)
destroy(this.dw_ing_gas_na)
end on

type cb_imprimir_tabpage_18 from commandbutton within tabpage_18
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;if idw_ing_gas_na.RowCount() = 0 then return

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_ing_gas_na
i_impresion_formato.nombre = 'Ingresos Gastos'
string nom,tipo,colegiado

tipo = 'Ingresos Gastos'
colegiado =idw_ing_gas_na.GetItemString(1,'n_colegiado') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom
i_impresion_formato.impresora_pag_hasta = long(idw_ing_gas_na.Describe("evaluate('PageCount()',1)"))
if g_activa_multiempresa = 'S' then
	f_logo_empresa(g_empresa ,idw_ing_gas_na,'000')
end if
if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if

end event

type dw_ing_gas_na from u_dw within tabpage_18
integer x = 9
integer y = 16
integer width = 3104
integer height = 1564
integer taborder = 20
string dataobject = "d_certificado_inggas_na"
end type

type tabpage_19 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3493
integer height = 1600
long backcolor = 67108864
string text = "Ingresos -  Gastos"
long tabtextcolor = 16711680
long picturemaskcolor = 536870912
cb_imprimir_tabpage_19 cb_imprimir_tabpage_19
dw_colegiado_ingreso_gasto dw_colegiado_ingreso_gasto
end type

on tabpage_19.create
this.cb_imprimir_tabpage_19=create cb_imprimir_tabpage_19
this.dw_colegiado_ingreso_gasto=create dw_colegiado_ingreso_gasto
this.Control[]={this.cb_imprimir_tabpage_19,&
this.dw_colegiado_ingreso_gasto}
end on

on tabpage_19.destroy
destroy(this.cb_imprimir_tabpage_19)
destroy(this.dw_colegiado_ingreso_gasto)
end on

type cb_imprimir_tabpage_19 from commandbutton within tabpage_19
integer x = 3136
integer y = 16
integer width = 329
integer height = 80
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;if idw_ing_gas_gasto.RowCount() = 0 then return

idw_consulta.TriggerEvent('csd_opciones_impresion_indiv')
// Cambiamos el dw y el nombre
i_impresion_formato.dw = idw_ing_gas_gasto
i_impresion_formato.nombre = 'Ingresos Gastos'
string nom,tipo,colegiado

tipo = 'Ingresos Gastos'
colegiado =idw_ing_gas_gasto.GetItemString(1,'n_colegiado') 
nom =f_nombre_pdf(i_ejercicio,colegiado,tipo ,tri_anyo,date(i_fecha_desde) ,date(i_fecha_hasta))
i_impresion_formato.nombre = nom
i_impresion_formato.impresora_pag_hasta = long(idw_ing_gas_na.Describe("evaluate('PageCount()',1)"))

if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if

end event

type dw_colegiado_ingreso_gasto from u_dw within tabpage_19
integer x = 37
integer y = 20
integer width = 3067
integer height = 1560
integer taborder = 11
string dataobject = "d_colegiado_ingreso_gasto"
end type

