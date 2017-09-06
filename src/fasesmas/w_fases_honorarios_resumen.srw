HA$PBExportHeader$w_fases_honorarios_resumen.srw
forward
global type w_fases_honorarios_resumen from w_popup
end type
type dw_honos from u_dw within w_fases_honorarios_resumen
end type
type cb_imprimir from commandbutton within w_fases_honorarios_resumen
end type
end forward

global type w_fases_honorarios_resumen from w_popup
integer x = 214
integer y = 221
integer width = 3054
integer height = 1516
string title = "Descuentos Colegiado"
boolean minbox = false
boolean maxbox = false
event csd_cargar_datos ( )
dw_honos dw_honos
cb_imprimir cb_imprimir
end type
global w_fases_honorarios_resumen w_fases_honorarios_resumen

type variables
w_fases_detalle  i_w
long fila_colegiado
end variables

event csd_cargar_datos();string t_actuacion, id_col, id_fase
int i,j, fila, k
double suma_porc=0, porc_col=0, porc_col_real=0, honos_totales=0, honos_col=0, honos_avisado=0, honos_cobrado=0

datastore ds_fases
ds_fases = create datastore
ds_fases.dataobject = 'ds_fases_expediente'
ds_fases.settransobject(sqlca)
ds_fases.retrieve(i_w.idw_fases_datos_exp.getitemstring(1, 'id_expedi'))

dw_honos.setredraw(false)

for k = 1 to ds_fases.rowcount()
	id_fase = ds_fases.getitemstring(k, 'fases_id_fase')
	t_actuacion = ds_fases.getitemstring(k, 'fases_fase')
	For j = 1 to i_w.idw_fases_colegiados.rowcount()
		fila = dw_honos.insertrow(0)
	
		id_col = i_w.idw_fases_colegiados.getitemstring(j, 'id_col')
		dw_honos.SetItem(fila, 'colegiado', id_col)
		dw_honos.SetItem(fila, 'tipo_act', t_actuacion)
		
		// Obtenemos los porcentajes de cada colegiado
		porc_col = i_w.idw_fases_colegiados.getitemnumber(j, 'porcen_a')
		suma_porc = 0
		for i = 1 to i_w.idw_fases_colegiados.rowcount()
			suma_porc += i_w.idw_fases_colegiados.getitemnumber(i, 'porcen_a')
		next
		porc_col_real = porc_col / suma_porc
		
		// Obtenemos las distintas cantidades de honorarios
		honos_totales = ds_fases.getitemnumber(k, 'fases_honorarios')
		honos_col = f_redondea(honos_totales * porc_col_real )
		honos_avisado = f_total_avisado_honos_colegiado(id_fase, id_col)
		honos_cobrado = f_total_cobrado_honos_colegiado_fact(id_fase, id_col)
		
		dw_honos.setitem(fila, 'honorarios', honos_col)
		dw_honos.setitem(fila, 'honorarios_pasados', honos_avisado)
		dw_honos.setitem(fila, 'honorarios_cobrados', honos_cobrado)
	
	next
next

dw_honos.groupcalc()
dw_honos.sort()
dw_honos.setredraw(true)

destroy(ds_fases)

end event

on w_fases_honorarios_resumen.create
int iCurrent
call super::create
this.dw_honos=create dw_honos
this.cb_imprimir=create cb_imprimir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_honos
this.Control[iCurrent+2]=this.cb_imprimir
end on

on w_fases_honorarios_resumen.destroy
call super::destroy
destroy(this.dw_honos)
destroy(this.cb_imprimir)
end on

event open;call super::open;i_w = message.powerobjectparm

if i_w.idw_fases_colegiados.rowcount() <= 0 then return

//// Si solo hay un colegiado hacemos que no se vean los totales
//if i_w.idw_fases_colegiados.rowcount() = 1 then dw_descuentos.modify("DataWindow.Summary.Height='0'")

//// Llamamos al control de eventos
//st_control_eventos c_evento
//c_evento.evento = 'W_DESCUENTOS_COLEGIA'
//c_evento.dw = dw_descuentos
//if f_control_eventos(c_evento)=-1 then return


this.postevent('csd_cargar_datos')

end event

event pfc_preopen;call super::pfc_preopen;f_centrar_ventana(this)
end event

type dw_honos from u_dw within w_fases_honorarios_resumen
integer x = 37
integer y = 32
integer width = 2523
integer height = 1276
integer taborder = 0
string dataobject = "d_fases_honorarios_resumen"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type cb_imprimir from commandbutton within w_fases_honorarios_resumen
integer x = 2633
integer y = 32
integer width = 334
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
end type

event clicked;dw_honos.print()
end event

