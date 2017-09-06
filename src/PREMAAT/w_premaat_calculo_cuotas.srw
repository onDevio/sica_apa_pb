HA$PBExportHeader$w_premaat_calculo_cuotas.srw
forward
global type w_premaat_calculo_cuotas from w_sheet
end type
type cb_cerrar from commandbutton within w_premaat_calculo_cuotas
end type
type st_mensajes from statictext within w_premaat_calculo_cuotas
end type
type cb_actualizar_cuotas from commandbutton within w_premaat_calculo_cuotas
end type
type cb_listado_previo from commandbutton within w_premaat_calculo_cuotas
end type
type st_1 from statictext within w_premaat_calculo_cuotas
end type
type cb_preproceso from commandbutton within w_premaat_calculo_cuotas
end type
type tab_1 from tab within w_premaat_calculo_cuotas
end type
type tabpage_1 from userobject within tab_1
end type
type st_total_basico from statictext within tabpage_1
end type
type dw_basico from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
st_total_basico st_total_basico
dw_basico dw_basico
end type
type tabpage_2 from userobject within tab_1
end type
type st_total_2000 from statictext within tabpage_2
end type
type dw_2000 from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
st_total_2000 st_total_2000
dw_2000 dw_2000
end type
type tabpage_3 from userobject within tab_1
end type
type st_total_comple1 from statictext within tabpage_3
end type
type dw_comple1 from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
st_total_comple1 st_total_comple1
dw_comple1 dw_comple1
end type
type tabpage_4 from userobject within tab_1
end type
type dw_bonif from u_dw within tabpage_4
end type
type st_total_bonif from statictext within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_bonif dw_bonif
st_total_bonif st_total_bonif
end type
type tab_1 from tab within w_premaat_calculo_cuotas
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
type cb_generar_cuotas from commandbutton within w_premaat_calculo_cuotas
end type
type dw_lista_datos from u_dw within w_premaat_calculo_cuotas
end type
type dw_parametros from u_dw within w_premaat_calculo_cuotas
end type
type cb_listado_inc from commandbutton within w_premaat_calculo_cuotas
end type
end forward

global type w_premaat_calculo_cuotas from w_sheet
integer width = 3589
integer height = 2428
string title = "C$$HEX1$$e100$$ENDHEX$$lculo de Cuotas de PREMAAT"
string menuname = "m_cerrar"
boolean controlmenu = false
windowstate windowstate = maximized!
event csd_recuperar_cuotas_antiguas ( )
cb_cerrar cb_cerrar
st_mensajes st_mensajes
cb_actualizar_cuotas cb_actualizar_cuotas
cb_listado_previo cb_listado_previo
st_1 st_1
cb_preproceso cb_preproceso
tab_1 tab_1
cb_generar_cuotas cb_generar_cuotas
dw_lista_datos dw_lista_datos
dw_parametros dw_parametros
cb_listado_inc cb_listado_inc
end type
global w_premaat_calculo_cuotas w_premaat_calculo_cuotas

type variables
u_dw idw_basico, idw_2000, idw_comple1, idw_bonif
datastore ids_borrar_cuotas, ids_informe_depuracion



end variables

forward prototypes
public subroutine f_mensaje_pantalla (string mensaje)
end prototypes

event csd_recuperar_cuotas_antiguas();string sl_cod_basico, sl_cod_2000, sl_cod_comple1
string sql

ids_borrar_cuotas = create datastore
ids_borrar_cuotas.dataobject = 'd_premaat_calculo_cuotas_domiciliaciones'
ids_borrar_cuotas.settransobject(sqlca)

if dw_parametros.rowcount() < 1 then
	messagebox(g_titulo,g_idioma.of_getmsg('premaat.msg_datos_defecto',"Falta configurar datos por defecto"))
	return
end if
sl_cod_basico = dw_parametros.getitemstring(1, 'cod_basico')
sl_cod_2000 = dw_parametros.getitemstring(1, 'cod_2000')
sl_cod_comple1 = dw_parametros.getitemstring(1, 'cod_comple1')


sql = ids_borrar_cuotas.describe("Datawindow.Table.Select")


sql += " and conceptos_domiciliables.concepto in  ('"+sl_cod_basico+"', '"+sl_cod_2000+"', '"+sl_cod_comple1+"', '"+g_codigos_conceptos.bonif_premaat+"')"

ids_borrar_cuotas.Modify("DataWindow.Table.Select= ~"" + sql + "~"")

ids_borrar_cuotas.retrieve()
end event

public subroutine f_mensaje_pantalla (string mensaje);st_mensajes.text = mensaje
end subroutine

on w_premaat_calculo_cuotas.create
int iCurrent
call super::create
if this.MenuName = "m_cerrar" then this.MenuID = create m_cerrar
this.cb_cerrar=create cb_cerrar
this.st_mensajes=create st_mensajes
this.cb_actualizar_cuotas=create cb_actualizar_cuotas
this.cb_listado_previo=create cb_listado_previo
this.st_1=create st_1
this.cb_preproceso=create cb_preproceso
this.tab_1=create tab_1
this.cb_generar_cuotas=create cb_generar_cuotas
this.dw_lista_datos=create dw_lista_datos
this.dw_parametros=create dw_parametros
this.cb_listado_inc=create cb_listado_inc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cerrar
this.Control[iCurrent+2]=this.st_mensajes
this.Control[iCurrent+3]=this.cb_actualizar_cuotas
this.Control[iCurrent+4]=this.cb_listado_previo
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_preproceso
this.Control[iCurrent+7]=this.tab_1
this.Control[iCurrent+8]=this.cb_generar_cuotas
this.Control[iCurrent+9]=this.dw_lista_datos
this.Control[iCurrent+10]=this.dw_parametros
this.Control[iCurrent+11]=this.cb_listado_inc
end on

on w_premaat_calculo_cuotas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_cerrar)
destroy(this.st_mensajes)
destroy(this.cb_actualizar_cuotas)
destroy(this.cb_listado_previo)
destroy(this.st_1)
destroy(this.cb_preproceso)
destroy(this.tab_1)
destroy(this.cb_generar_cuotas)
destroy(this.dw_lista_datos)
destroy(this.dw_parametros)
destroy(this.cb_listado_inc)
end on

event pfc_postopen();call super::pfc_postopen;//Recuperamos la consulta de Inicio en caso de que exista
This.Event csd_recuperar_consulta('INICIO')
end event

event open;call super::open;idw_basico = tab_1.tabpage_1.dw_basico
idw_2000 = tab_1.tabpage_2.dw_2000
idw_comple1 = tab_1.tabpage_3.dw_comple1
idw_bonif = tab_1.tabpage_4.dw_bonif

of_SetResize (true)
inv_resize.of_Register (dw_lista_datos, "ScaletoRight")
inv_resize.of_Register (tab_1, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_basico, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_2000, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_comple1, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_bonif, "ScaletoRight&Bottom")

inv_resize.of_Register (tab_1.tabpage_1.st_total_basico, "FixedtoBottom")
inv_resize.of_Register (tab_1.tabpage_2.st_total_2000, "FixedtoBottom")
inv_resize.of_Register (tab_1.tabpage_3.st_total_comple1, "FixedtoBottom")
inv_resize.of_Register (tab_1.tabpage_4.st_total_bonif, "FixedtoBottom")

inv_resize.of_Register (cb_preproceso, "FixedtoBottom")
inv_resize.of_Register (cb_generar_cuotas, "FixedtoBottom")
inv_resize.of_Register (cb_listado_previo, "FixedtoBottom")
inv_resize.of_Register (cb_listado_inc, "FixedtoBottom")
inv_resize.of_Register (cb_actualizar_cuotas, "FixedtoBottom")
inv_resize.of_Register (cb_cerrar, "FixedtoBottom")
inv_resize.of_Register (st_mensajes, "FixedtoBottom")

dw_lista_datos.retrieve()
this.post event csd_recuperar_cuotas_antiguas()

if g_colegio = 'COAATLE' then tab_1.tabpage_4.visible = true

if g_usar_idioma='S' then g_idioma.of_cambia_textos( this)
end event

event closequery;//SOBREESCRITO
return 0
end event

event close;call super::close;destroy ids_borrar_cuotas
end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_premaat_calculo_cuotas
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_premaat_calculo_cuotas
end type

type cb_cerrar from commandbutton within w_premaat_calculo_cuotas
string tag = "texto=general.salir"
boolean visible = false
integer x = 3127
integer y = 2088
integer width = 375
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;close(parent)
end event

type st_mensajes from statictext within w_premaat_calculo_cuotas
integer x = 2217
integer y = 2100
integer width = 1271
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388736
long backcolor = 79741120
boolean focusrectangle = false
end type

type cb_actualizar_cuotas from commandbutton within w_premaat_calculo_cuotas
integer x = 1755
integer y = 2088
integer width = 421
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Actualizar Cuotas"
end type

event clicked;double i

// Fase 1: Borrar cuotas antiguas
f_mensaje_pantalla('Borrando cuotas antiguas...') 
for i = ids_borrar_cuotas.rowcount() to 1 step -1
	ids_borrar_cuotas.deleterow(i)
next

ids_borrar_cuotas.update()

// Fase 2 : Grabando nuevas cuotas
f_mensaje_pantalla('Grabando datos...') 
idw_basico.update()
idw_2000.update()
idw_comple1.update()
idw_bonif.update()

// Fase 3 : Recargamos el datastore de cuotas antiguas por si repiten el proceso
ids_borrar_cuotas.retrieve()

// Fase 4: inhabiliatacion de la botonera
cb_preproceso.enabled = true
cb_generar_cuotas.enabled = false
cb_listado_previo.enabled = false
cb_actualizar_cuotas.enabled = false
cb_listado_inc.enabled = false
f_mensaje_pantalla('Cuotas actualizadas...')

end event

type cb_listado_previo from commandbutton within w_premaat_calculo_cuotas
integer x = 1326
integer y = 2088
integer width = 421
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Listado Previo"
end type

event clicked;double i, fila_insertada
datastore ds_listado
int Net

Net = MessageBox(g_idioma.of_getmsg('general.imprimir_listado',"Imprimir Listado"),g_idioma.of_getmsg('general.imprimir_listado_pregunta',"$$HEX1$$bf00$$ENDHEX$$Desea imprimir el listado? "), Question!, OKCancel!, 1)

IF Net = 1 THEN

	ds_listado = create datastore
	ds_listado.dataobject = 'd_premaat_calculo_cuotas_listado_previo'
	ds_listado.settransobject(sqlca)
	
	for i = 1 to idw_basico.rowcount()
		fila_insertada = ds_listado.insertrow(0)
		ds_listado.setitem(fila_insertada, 'n_col', idw_basico.getitemstring(i, 'n_col'))
		ds_listado.setitem(fila_insertada, 'nombre', idw_basico.getitemstring(i, 'nombre'))
		ds_listado.setitem(fila_insertada, 'concepto', f_devuelve_desc_concepto(idw_basico.getitemstring(i, 'concepto')))
		ds_listado.setitem(fila_insertada, 'importe', idw_basico.getitemnumber(i, 'importe'))
		ds_listado.setitem(fila_insertada, 'forma_pago', f_dame_formapago(idw_basico.getitemstring(i, 'forma_de_pago'))	)	
	next
	
	for i = 1 to idw_2000.rowcount()
		fila_insertada = ds_listado.insertrow(0)
		ds_listado.setitem(fila_insertada, 'n_col', idw_2000.getitemstring(i, 'n_col'))
		ds_listado.setitem(fila_insertada, 'nombre', idw_2000.getitemstring(i, 'nombre'))
		ds_listado.setitem(fila_insertada, 'concepto', f_devuelve_desc_concepto(idw_2000.getitemstring(i, 'concepto')))
		ds_listado.setitem(fila_insertada, 'importe', idw_2000.getitemnumber(i, 'importe'))
		ds_listado.setitem(fila_insertada, 'forma_pago', f_dame_formapago(idw_2000.getitemstring(i, 'forma_de_pago'))	)
	next
	
	for i = 1 to idw_comple1.rowcount()
		fila_insertada = ds_listado.insertrow(0)
		ds_listado.setitem(fila_insertada, 'n_col', idw_comple1.getitemstring(i, 'n_col'))
		ds_listado.setitem(fila_insertada, 'nombre', idw_comple1.getitemstring(i, 'nombre'))
		ds_listado.setitem(fila_insertada, 'concepto', f_devuelve_desc_concepto(idw_comple1.getitemstring(i, 'concepto')))
		ds_listado.setitem(fila_insertada, 'importe', idw_comple1.getitemnumber(i, 'importe'))
		ds_listado.setitem(fila_insertada, 'forma_pago', f_dame_formapago(idw_comple1.getitemstring(i, 'forma_de_pago'))	)
	next
	
	for i = 1 to idw_bonif.rowcount()
		fila_insertada = ds_listado.insertrow(0)
		ds_listado.setitem(fila_insertada, 'n_col', idw_bonif.getitemstring(i, 'n_col'))
		ds_listado.setitem(fila_insertada, 'nombre', idw_bonif.getitemstring(i, 'nombre'))
		ds_listado.setitem(fila_insertada, 'concepto', f_devuelve_desc_concepto(idw_bonif.getitemstring(i, 'concepto')))
		ds_listado.setitem(fila_insertada, 'importe', idw_bonif.getitemnumber(i, 'importe'))
		ds_listado.setitem(fila_insertada, 'forma_pago', f_dame_formapago(idw_bonif.getitemstring(i, 'forma_de_pago'))	)
	next
	
	ds_listado.sort()
	ds_listado.groupcalc()
	ds_listado.print()

	destroy ds_listado

end if

end event

type st_1 from statictext within w_premaat_calculo_cuotas
string tag = "texto=premaat.generacion_cuotas_fichas"
integer x = 37
integer y = 32
integer width = 2665
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
string text = "S$$HEX1$$f300$$ENDHEX$$lo se generar$$HEX1$$e100$$ENDHEX$$n las cuotas de aquelllos colegiados que est$$HEX1$$e900$$ENDHEX$$n de alta tanto en la ficha colegial como en PREMAAT...."
boolean focusrectangle = false
end type

type cb_preproceso from commandbutton within w_premaat_calculo_cuotas
string tag = "texto=general.preproceso"
integer x = 37
integer y = 2088
integer width = 421
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Preproceso"
end type

event clicked;double i
string sl_grupo, sl_comple1, id_col, sl_n_colegiado, sl_nombre
string sl_cod_basico, sl_cod_2000, sl_cod_comple1, sl_forma_pago
double fila_a_buscar, fila_incidencia


ids_informe_depuracion = create datastore
ids_informe_depuracion.dataobject = 'd_premaat_calculo_cuotas_depuracion'
ids_informe_depuracion.settransobject(sqlca)

if dw_parametros.rowcount() < 1 then
	messagebox(g_titulo, g_idioma.of_getmsg('premaat.msg_datos_defecto',"Falta configurar datos por defecto"))
	return
end if

f_mensaje_pantalla(g_idioma.of_getmsg('general.inicio_proceso','Inicio preproceso...'))
sl_cod_basico = dw_parametros.getitemstring(1, 'cod_basico')
sl_cod_2000 = dw_parametros.getitemstring(1, 'cod_2000')
sl_cod_comple1 = dw_parametros.getitemstring(1, 'cod_comple1')

// Fase 1 : Discrepancias datos origen - domiciliaciones
for i = 1 to dw_lista_datos.rowcount()
	sl_grupo = dw_lista_datos.getitemstring(i, 'premaat_grupo')
	sl_comple1 = dw_lista_datos.getitemstring(i, 'premaat_grupo_comple1')
	id_col = dw_lista_datos.getitemstring(i, 'colegiados_id_colegiado')		
	sl_n_colegiado = dw_lista_datos.getitemstring(i, 'n_colegiado')	
	sl_nombre = dw_lista_datos.getitemstring(i, 'nombre')	
	
	if sl_grupo = 'A' then
		fila_a_buscar=ids_borrar_cuotas.find("id_colegiado = '"+id_col+"' and concepto = '"+sl_cod_basico+"'", 1, ids_borrar_cuotas.rowcount())
		if fila_a_buscar<=0 then 
			fila_incidencia = ids_informe_depuracion.insertrow(0)
			ids_informe_depuracion.setitem(fila_incidencia, 'n_colegiado', sl_n_colegiado)
			ids_informe_depuracion.setitem(fila_incidencia, 'nombre', sl_nombre)			
			ids_informe_depuracion.setitem(fila_incidencia, 'incidencia',g_idioma.of_getmsg('premaat.msg_grupo_basico_dom','Pertenece al grupo b$$HEX1$$e100$$ENDHEX$$sico y no est$$HEX2$$e1002000$$ENDHEX$$domiciliado, se le generar$$HEX2$$e1002000$$ENDHEX$$una domiciliaci$$HEX1$$f300$$ENDHEX$$n'))						
			ids_informe_depuracion.setitem(fila_incidencia, 'tipo', '1')
		end if
	end if
	if sl_grupo = 'C' then
		fila_a_buscar=ids_borrar_cuotas.find("id_colegiado = '"+id_col+"' and concepto = '"+sl_cod_2000+"'", 1, ids_borrar_cuotas.rowcount())
		if fila_a_buscar<=0 then 
			fila_incidencia = ids_informe_depuracion.insertrow(0)
			ids_informe_depuracion.setitem(fila_incidencia, 'n_colegiado', sl_n_colegiado)
			ids_informe_depuracion.setitem(fila_incidencia, 'nombre', sl_nombre)			
			ids_informe_depuracion.setitem(fila_incidencia,'incidencia', g_idioma.of_getmsg('premaat.msg_grupo2000_basico_dom','Pertenece al grupo 2000  y no est$$HEX2$$e1002000$$ENDHEX$$domiciliado, se le generar$$HEX2$$e1002000$$ENDHEX$$una domiciliaci$$HEX1$$f300$$ENDHEX$$n'))	
			ids_informe_depuracion.setitem(fila_incidencia, 'tipo', '1')
		end if	
	end if
	
	if sl_comple1 = 'S' then
		fila_a_buscar=ids_borrar_cuotas.find("id_colegiado = '"+id_col+"' and concepto = '"+sl_cod_comple1+"'", 1, ids_borrar_cuotas.rowcount())
		if fila_a_buscar<=0 then 
			fila_incidencia = ids_informe_depuracion.insertrow(0)
			ids_informe_depuracion.setitem(fila_incidencia, 'n_colegiado', sl_n_colegiado)
			ids_informe_depuracion.setitem(fila_incidencia, 'nombre', sl_nombre)			
			ids_informe_depuracion.setitem(fila_incidencia,'incidencia', g_idioma.of_getmsg('premaat.msg_grupo_comp1_basico_dom' , 'Pertenece al grupo complementario primero y no est$$HEX2$$e1002000$$ENDHEX$$domiciliado, se le generar$$HEX2$$e1002000$$ENDHEX$$una domiciliaci$$HEX1$$f300$$ENDHEX$$n'))	
			ids_informe_depuracion.setitem(fila_incidencia, 'tipo', '1')
		end if				
	end if
next
// Fase 2 : Discrepancias domiciliaciones - datos origen
for i = 1 to ids_borrar_cuotas.rowcount()
	id_col = ids_borrar_cuotas.getitemstring(i, 'id_colegiado')
	sl_n_colegiado= f_colegiado_n_col(ids_borrar_cuotas.getitemstring(i, 'id_colegiado')	)
	sl_nombre= f_colegiado_apellido(ids_borrar_cuotas.getitemstring(i, 'id_colegiado')	)
	choose case ids_borrar_cuotas.getitemstring(i, 'concepto')
		case sl_cod_basico
			fila_a_buscar=dw_lista_datos.find("colegiados_id_colegiado = '"+id_col+"' and premaat_grupo = 'A'", 1, ids_borrar_cuotas.rowcount())
			if fila_a_buscar<=0 then 
				fila_incidencia = ids_informe_depuracion.insertrow(0)
				ids_informe_depuracion.setitem(fila_incidencia, 'n_colegiado', sl_n_colegiado)
				ids_informe_depuracion.setitem(fila_incidencia, 'nombre', sl_nombre)			
				ids_informe_depuracion.setitem(fila_incidencia, 'incidencia',g_idioma.of_getmsg('premaat.msg_dom_cuota_dom','Tiene domiciliada la cuota b$$HEX1$$e100$$ENDHEX$$sica y no pertenece a ella, Se perder$$HEX2$$e1002000$$ENDHEX$$esta domiciliaci$$HEX1$$f300$$ENDHEX$$n'))	
				ids_informe_depuracion.setitem(fila_incidencia, 'tipo', '2')
			end if					
		case sl_cod_2000
			fila_a_buscar=dw_lista_datos.find("colegiados_id_colegiado = '"+id_col+"' and premaat_grupo = 'C'", 1, ids_borrar_cuotas.rowcount())
			if fila_a_buscar<=0 then 
				fila_incidencia = ids_informe_depuracion.insertrow(0)
				ids_informe_depuracion.setitem(fila_incidencia, 'n_colegiado', sl_n_colegiado)
				ids_informe_depuracion.setitem(fila_incidencia, 'nombre', sl_nombre)			
				ids_informe_depuracion.setitem(fila_incidencia, 'incidencia', g_idioma.of_getmsg('premaat.msg_dom_cuota2000_dom','Tiene domiciliada la cuota 2000 y no pertenece a ella, Se perder$$HEX2$$e1002000$$ENDHEX$$esta domiciliaci$$HEX1$$f300$$ENDHEX$$n'))	
				ids_informe_depuracion.setitem(fila_incidencia, 'tipo', '2')
			end if					
		case sl_comple1
			fila_a_buscar=dw_lista_datos.find("colegiados_id_colegiado = '"+id_col+"' and premaat_grupo_comple1 = 'S'", 1, ids_borrar_cuotas.rowcount())
			if fila_a_buscar<=0 then 
				fila_incidencia = ids_informe_depuracion.insertrow(0)
				ids_informe_depuracion.setitem(fila_incidencia, 'n_colegiado', sl_n_colegiado)
				ids_informe_depuracion.setitem(fila_incidencia, 'nombre', sl_nombre)			
				ids_informe_depuracion.setitem(fila_incidencia, 'incidencia',g_idioma.of_getmsg('premaat.msg_dom_cuotacomp_dom','Tiene domiciliada la cuota complementaria 1$$HEX2$$aa002000$$ENDHEX$$y no pertenece a ella, Se perder$$HEX2$$e1002000$$ENDHEX$$esta domiciliaci$$HEX1$$f300$$ENDHEX$$n')	)
				ids_informe_depuracion.setitem(fila_incidencia, 'tipo', '2')
			end if								
	end choose
next

//// Impresi$$HEX1$$f300$$ENDHEX$$n
//if ids_informe_depuracion.rowcount() >0 then
//	ids_informe_depuracion.groupcalc()
//	ids_informe_depuracion.print()
//end if
//destroy ids_informe_depuracion

if ids_informe_depuracion.rowcount() >0 then cb_listado_inc.enabled = true

cb_generar_cuotas.enabled = true

f_mensaje_pantalla(g_idioma.of_getmsg('premaat.msg_fin_proceso','Fin del preproceso...'))
end event

type tab_1 from tab within w_premaat_calculo_cuotas
integer x = 37
integer y = 696
integer width = 3465
integer height = 1364
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
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

type tabpage_1 from userobject within tab_1
string tag = "texto=premaat.grupo_basico"
integer x = 18
integer y = 100
integer width = 3429
integer height = 1248
long backcolor = 79741120
string text = "Grupo B$$HEX1$$e100$$ENDHEX$$sico"
long tabtextcolor = 16711680
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_total_basico st_total_basico
dw_basico dw_basico
end type

on tabpage_1.create
this.st_total_basico=create st_total_basico
this.dw_basico=create dw_basico
this.Control[]={this.st_total_basico,&
this.dw_basico}
end on

on tabpage_1.destroy
destroy(this.st_total_basico)
destroy(this.dw_basico)
end on

type st_total_basico from statictext within tabpage_1
integer x = 9
integer y = 1172
integer width = 805
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_basico from u_dw within tabpage_1
integer x = 27
integer y = 28
integer width = 3360
integer height = 1128
integer taborder = 20
string dataobject = "d_premaat_calculo_cuotas_domiciliaciones"
boolean hscrollbar = true
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetSort(TRUE)
inv_sort.of_SetColumnHeader (true)
inv_sort.of_SetStyle (2)

end event

type tabpage_2 from userobject within tab_1
string tag = "texto=premaat.grupo_2000"
integer x = 18
integer y = 100
integer width = 3429
integer height = 1248
long backcolor = 79741120
string text = "Grupo 2000"
long tabtextcolor = 16711680
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_total_2000 st_total_2000
dw_2000 dw_2000
end type

on tabpage_2.create
this.st_total_2000=create st_total_2000
this.dw_2000=create dw_2000
this.Control[]={this.st_total_2000,&
this.dw_2000}
end on

on tabpage_2.destroy
destroy(this.st_total_2000)
destroy(this.dw_2000)
end on

type st_total_2000 from statictext within tabpage_2
integer x = 14
integer y = 1176
integer width = 718
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_2000 from u_dw within tabpage_2
integer x = 27
integer y = 28
integer width = 3360
integer height = 1128
integer taborder = 11
string dataobject = "d_premaat_calculo_cuotas_domiciliaciones"
boolean hscrollbar = true
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetSort(TRUE)
inv_sort.of_SetColumnHeader (true)
inv_sort.of_SetStyle (2)

end event

type tabpage_3 from userobject within tab_1
string tag = "texto=premaat.complementario_1"
integer x = 18
integer y = 100
integer width = 3429
integer height = 1248
long backcolor = 79741120
string text = "Complementario 1$$HEX1$$ba00$$ENDHEX$$"
long tabtextcolor = 16711680
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_total_comple1 st_total_comple1
dw_comple1 dw_comple1
end type

on tabpage_3.create
this.st_total_comple1=create st_total_comple1
this.dw_comple1=create dw_comple1
this.Control[]={this.st_total_comple1,&
this.dw_comple1}
end on

on tabpage_3.destroy
destroy(this.st_total_comple1)
destroy(this.dw_comple1)
end on

type st_total_comple1 from statictext within tabpage_3
integer x = 9
integer y = 1172
integer width = 1001
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_comple1 from u_dw within tabpage_3
integer x = 27
integer y = 28
integer width = 3360
integer height = 1128
integer taborder = 11
string dataobject = "d_premaat_calculo_cuotas_domiciliaciones"
boolean hscrollbar = true
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetSort(TRUE)
inv_sort.of_SetColumnHeader (true)
inv_sort.of_SetStyle (2)

end event

type tabpage_4 from userobject within tab_1
string tag = "texto=premaat.bonificaciones"
boolean visible = false
integer x = 18
integer y = 100
integer width = 3429
integer height = 1248
long backcolor = 79741120
string text = "Bonificaciones"
long tabtextcolor = 16711680
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_bonif dw_bonif
st_total_bonif st_total_bonif
end type

on tabpage_4.create
this.dw_bonif=create dw_bonif
this.st_total_bonif=create st_total_bonif
this.Control[]={this.dw_bonif,&
this.st_total_bonif}
end on

on tabpage_4.destroy
destroy(this.dw_bonif)
destroy(this.st_total_bonif)
end on

type dw_bonif from u_dw within tabpage_4
integer x = 27
integer y = 28
integer width = 3360
integer height = 1128
integer taborder = 30
string dataobject = "d_premaat_calculo_cuotas_domiciliaciones"
boolean hscrollbar = true
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetSort(TRUE)
inv_sort.of_SetColumnHeader (true)
inv_sort.of_SetStyle (2)

end event

type st_total_bonif from statictext within tabpage_4
integer x = 9
integer y = 1172
integer width = 1001
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_generar_cuotas from commandbutton within w_premaat_calculo_cuotas
integer x = 896
integer y = 2088
integer width = 421
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Generar Cuotas"
end type

event clicked;double i, fila_insertada, cuota
string sl_grupo, sl_comple1, sl_modulo_ahorro, id_col, sl_sexo, sl_forma_pago_defecto, sl_n_colegiado, sl_nombre
string sl_cod_basico, sl_cod_2000, sl_cod_comple1, sl_forma_pago
datetime dtl_f_nacimiento
double fila_busca_fp

f_mensaje_pantalla('C$$HEX1$$e100$$ENDHEX$$lculo previo de cuotas...')
idw_basico.reset()
idw_2000.reset()
idw_comple1.reset()

sl_cod_basico = dw_parametros.getitemstring(1, 'cod_basico')
sl_cod_2000 = dw_parametros.getitemstring(1, 'cod_2000')
sl_cod_comple1 = dw_parametros.getitemstring(1, 'cod_comple1')
sl_forma_pago_defecto = dw_parametros.getitemstring(1, 'forma_pago_defecto')
if f_es_vacio(sl_forma_pago_defecto) then sl_forma_pago_defecto = 'DB'

for i = 1 to dw_lista_datos.rowcount()
	sl_grupo = dw_lista_datos.getitemstring(i, 'premaat_grupo')
	sl_comple1 = dw_lista_datos.getitemstring(i, 'premaat_grupo_comple1')
	sl_modulo_ahorro = dw_lista_datos.getitemstring(i, 'premaat_modulo_ahorro')	
	id_col = dw_lista_datos.getitemstring(i, 'colegiados_id_colegiado')		
	sl_sexo = dw_lista_datos.getitemstring(i, 'colegiados_sexo')		
	dtl_f_nacimiento = dw_lista_datos.getitemdatetime(i, 'colegiados_f_nacimiento')			
	sl_n_colegiado = dw_lista_datos.getitemstring(i, 'n_colegiado')	
	sl_nombre = dw_lista_datos.getitemstring(i, 'nombre')	
	
	if sl_grupo = 'A' then
		cuota = f_premaat_dame_cuota('A', dtl_f_nacimiento, sl_sexo, '')
		if cuota > 0 then
			fila_insertada = idw_basico.insertrow(0)
			idw_basico.setitem(fila_insertada, 'id_colegiado', id_col)
			idw_basico.setitem(fila_insertada, 'concepto', sl_cod_basico)	
			idw_basico.setitem(fila_insertada, 'n_col', sl_n_colegiado)		
			idw_basico.setitem(fila_insertada, 'nombre', sl_nombre)		
			idw_basico.setitem(fila_insertada, 'importe', cuota)
			fila_busca_fp = ids_borrar_cuotas.find("id_colegiado = '"+ id_col + "' and concepto = '"+sl_cod_basico+"'", 1, ids_borrar_cuotas.rowcount())
			if fila_busca_fp >0 then
				sl_forma_pago = ids_borrar_cuotas.getitemstring(fila_busca_fp, 'forma_de_pago')
			else
				sl_forma_pago = sl_forma_pago_defecto
			end if
			idw_basico.setitem(fila_insertada, 'forma_de_pago', sl_forma_pago)
			
			// Bonificaci$$HEX1$$f300$$ENDHEX$$n
			if g_colegio = 'COAATLE' then
				fila_insertada = idw_bonif.insertrow(0)
				idw_bonif.setitem(fila_insertada, 'id_colegiado', id_col)
				idw_bonif.setitem(fila_insertada, 'concepto', g_codigos_conceptos.bonif_premaat)	
				idw_bonif.setitem(fila_insertada, 'n_col', sl_n_colegiado)		
				idw_bonif.setitem(fila_insertada, 'nombre', sl_nombre)
				idw_bonif.setitem(fila_insertada, 'importe', round(cuota*g_porc_bonif_premaat,2))
				idw_bonif.setitem(fila_insertada, 'forma_de_pago', sl_forma_pago)
			end if
		end if
	end if
			

	if sl_grupo = 'C' then
		cuota = f_premaat_dame_cuota('C', dtl_f_nacimiento, sl_sexo, sl_modulo_ahorro)
		if cuota > 0 then		
			fila_insertada = idw_2000.insertrow(0)		
			idw_2000.setitem(fila_insertada, 'id_colegiado', id_col)
			idw_2000.setitem(fila_insertada, 'concepto', sl_cod_2000)	
			idw_2000.setitem(fila_insertada, 'n_col', sl_n_colegiado)		
			idw_2000.setitem(fila_insertada, 'nombre', sl_nombre)		
			idw_2000.setitem(fila_insertada, 'importe', f_premaat_dame_cuota('C', dtl_f_nacimiento, sl_sexo, sl_modulo_ahorro))
			fila_busca_fp = ids_borrar_cuotas.find("id_colegiado = '"+ id_col + "' and concepto = '"+sl_cod_2000+"'", 1, ids_borrar_cuotas.rowcount())
			if fila_busca_fp >0 then
				sl_forma_pago = ids_borrar_cuotas.getitemstring(fila_busca_fp, 'forma_de_pago')
			else
				sl_forma_pago = sl_forma_pago_defecto
			end if		
			idw_2000.setitem(fila_insertada, 'forma_de_pago', sl_forma_pago)
			
			// Bonificaci$$HEX1$$f300$$ENDHEX$$n
			if g_colegio = 'COAATLE' then
				fila_insertada = idw_bonif.insertrow(0)
				idw_bonif.setitem(fila_insertada, 'id_colegiado', id_col)
				idw_bonif.setitem(fila_insertada, 'concepto', g_codigos_conceptos.bonif_premaat)	
				idw_bonif.setitem(fila_insertada, 'n_col', sl_n_colegiado)		
				idw_bonif.setitem(fila_insertada, 'nombre', sl_nombre)
				idw_bonif.setitem(fila_insertada, 'importe', round(cuota*g_porc_bonif_premaat,2))
				idw_bonif.setitem(fila_insertada, 'forma_de_pago', sl_forma_pago)
			end if
		end if
	end if			
			
	if sl_comple1 = 'S' then
		fila_insertada = idw_comple1.insertrow(0)	
		idw_comple1.setitem(fila_insertada, 'id_colegiado', id_col)
		idw_comple1.setitem(fila_insertada, 'concepto', sl_cod_comple1)	
		idw_comple1.setitem(fila_insertada, 'n_col', sl_n_colegiado)		
		idw_comple1.setitem(fila_insertada, 'nombre', sl_nombre)		
		idw_comple1.setitem(fila_insertada, 'importe', f_premaat_dame_cuota('C1', dtl_f_nacimiento, sl_sexo,  ''))
		fila_busca_fp = ids_borrar_cuotas.find("id_colegiado = '"+ id_col + "' and concepto = '"+sl_cod_comple1+"'", 1, ids_borrar_cuotas.rowcount())
		if fila_busca_fp >0 then
			sl_forma_pago = ids_borrar_cuotas.getitemstring(fila_busca_fp, 'forma_de_pago')
		else
			sl_forma_pago = sl_forma_pago_defecto
		end if			
		idw_comple1.setitem(fila_insertada, 'forma_de_pago', sl_forma_pago)				
	end if
next

tab_1.tabpage_1.st_total_basico.text = string(idw_basico.rowcount(), '#,##0') + ' cuotas'
tab_1.tabpage_2.st_total_2000.text = string(idw_2000.rowcount(), '#,##0') + ' cuotas'
tab_1.tabpage_3.st_total_comple1.text = string(idw_comple1.rowcount(), '#,##0') + ' cuotas'
tab_1.tabpage_4.st_total_bonif.text = string(idw_bonif.rowcount(), '#,##0') + ' cuotas'

cb_listado_previo.enabled = true
cb_actualizar_cuotas.enabled = true
f_mensaje_pantalla('Fin c$$HEX1$$e100$$ENDHEX$$lculo previo de cuotas...')
end event

type dw_lista_datos from u_dw within w_premaat_calculo_cuotas
integer x = 37
integer y = 104
integer width = 3465
integer height = 576
integer taborder = 10
string dataobject = "ds_premaat_calculo_cuotas"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetSort(TRUE)
inv_sort.of_SetColumnHeader (true)
inv_sort.of_SetStyle (2)

end event

type dw_parametros from u_dw within w_premaat_calculo_cuotas
boolean visible = false
integer x = 2793
integer y = 12
integer width = 233
integer height = 96
integer taborder = 10
string dataobject = "d_premaat_calculo_cuotas_datos_defecto"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type cb_listado_inc from commandbutton within w_premaat_calculo_cuotas
integer x = 466
integer y = 2088
integer width = 421
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Listado Incid."
end type

event clicked;int Net

Net = MessageBox(g_idioma.of_getmsg('general.imprimir_listado',"Imprimir Listado"),g_idioma.of_getmsg('general.imprimir_listado_pregunta',"$$HEX1$$bf00$$ENDHEX$$Desea imprimir el listado? "), Question!, OKCancel!, 1)

IF Net = 1 THEN
	ids_informe_depuracion.groupcalc()
	ids_informe_depuracion.print()
end if

destroy ids_informe_depuracion

end event

