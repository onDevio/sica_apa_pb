HA$PBExportHeader$w_descuentos_colegiado_old.srw
forward
global type w_descuentos_colegiado_old from w_popup
end type
type dw_1 from u_dw within w_descuentos_colegiado_old
end type
type dw_descuentos from u_dw within w_descuentos_colegiado_old
end type
type cb_imprimir from commandbutton within w_descuentos_colegiado_old
end type
end forward

global type w_descuentos_colegiado_old from w_popup
integer width = 2994
integer height = 1264
string title = "Descuentos Colegiado"
boolean minbox = false
boolean maxbox = false
event csd_cargar_datos ( )
dw_1 dw_1
dw_descuentos dw_descuentos
cb_imprimir cb_imprimir
end type
global w_descuentos_colegiado_old w_descuentos_colegiado_old

type variables
w_fases_detalle  i_w
long fila_colegiado
end variables

event csd_cargar_datos();string n_col, n_expedi, t_actuacion, id_col, id_fase
int i,j, fila
double suma_porc = 0, porc_col = 0, porc_col_real = 0
double honos_totales = 0, honos_col = 0
double dv_totales = 0, dv_col = 0
double cip_totales = 0, cip_col = 0
double musaat_totales = 0, musaat_col = 0
st_musaat_datos st_musaat_datos
//fila_colegiado = i_w.idw_fases_colegiados.getrow()
int retorno
double dv_avisado = 0, cip_avisado = 0, musaat_avisado = 0, honos_avisado = 0
double dv_cobrado = 0, cip_cobrado = 0, musaat_cobrado = 0, honos_cobrado = 0
setpointer(hourglass!)
For j = 1 to i_w.idw_fases_colegiados.rowcount()
	fila_colegiado = j
	dw_descuentos.insertrow(0)

	dw_descuentos.setitem(dw_descuentos.RowCount(), 'mensaje', ''  )
	
	id_fase = i_w.dw_1.getitemstring(1, 'id_fase')
	id_col = i_w.idw_fases_colegiados.getitemstring(fila_colegiado, 'id_col')
	n_col = i_w.idw_fases_colegiados.getitemstring(fila_colegiado, 'n_col')
	n_expedi = i_w.idw_fases_datos_exp.getitemstring(1, 'n_expedi')
	t_actuacion = i_w.dw_1.getitemstring(1, 'fase')
	dw_descuentos.setitem(dw_descuentos.RowCount(), 'colegiado', n_col)
	dw_descuentos.setitem(dw_descuentos.RowCount(), 'expediente', n_expedi)
	dw_descuentos.setitem(dw_descuentos.RowCount(), 'tipo_act', t_actuacion)
	
	//this.title = 'Resumen Colegiado ' + f_colegiado_apellido( f_colegiado_id_col( n_col ) )
	dw_descuentos.SetItem(dw_descuentos.RowCount(),'colegiado',n_col)
	
	porc_col = i_w.idw_fases_colegiados.getitemnumber(fila_colegiado, 'porcen_a')
	suma_porc = 0
	for i = 1 to i_w.idw_fases_colegiados.rowcount()
		suma_porc += i_w.idw_fases_colegiados.getitemnumber(i, 'porcen_a')
	next
	porc_col_real = porc_col / suma_porc
	
	honos_totales = i_w.dw_1.getitemnumber(1, 'honorarios')
	honos_col = f_redondea(honos_totales * porc_col_real )
	dw_descuentos.setitem(dw_descuentos.RowCount(), 'honorarios', honos_col)
	honos_avisado = f_total_avisado_honos_colegiado(id_fase, id_col)
	dw_descuentos.setitem(dw_descuentos.RowCount(), 'honorarios_pasados', honos_avisado)
	honos_cobrado = f_total_cobrado_honos_colegiado(id_fase, id_col)
	dw_descuentos.setitem(dw_descuentos.RowCount(), 'honorarios_cobrados', honos_cobrado)
	//DV
	dv_totales = f_dv_contrato_dw(i_w.idw_fases_informes)
	dv_col = f_redondea(dv_totales * porc_col_real )
	dw_descuentos.setitem(dw_descuentos.RowCount(), 'dv', dv_col)
	dv_avisado = f_total_avisado_dv_colegiado(id_fase, id_col)
	dw_descuentos.setitem(dw_descuentos.RowCount(), 'dv_pasada', dv_avisado)
	dv_cobrado = f_total_cobrado_dv_colegiado(id_fase, id_col)
	dw_descuentos.setitem(dw_descuentos.RowCount(), 'dv_cobrada', dv_cobrado)
	//CIP
	if g_colegio='COAATTEB' or g_colegio='COAATTGN' OR g_colegio='COAATLL' then
		cip_col = f_calcular_cip_contrato_dw(i_w.idw_fases_estadistica,i_w.dw_1,porc_col_real*100, id_col)
	else
		cip_totales = f_cip_contrato_dw(i_w.idw_fases_informes)
		cip_col = f_redondea(cip_totales * porc_col_real )
	end if
	dw_descuentos.setitem(dw_descuentos.RowCount(), 'cip', cip_col)
	cip_avisado = f_total_avisado_cip_colegiado(id_fase, id_col)
	dw_descuentos.setitem(dw_descuentos.RowCount(), 'cip_pasada', cip_avisado)
	cip_cobrado = f_total_cobrado_cip_colegiado(id_fase, id_col)
	dw_descuentos.setitem(dw_descuentos.RowCount(), 'cip_cobrada', cip_cobrado)
	//MUSAAT
	if i_w.idw_fases_estadistica.rowcount() > 0 then
		st_musaat_datos.n_visado = i_w.dw_1.getitemstring(1, 'id_fase')
		st_musaat_datos.id_col = id_col
		st_musaat_datos.tipo_act = i_w.dw_1.getitemstring(1, 'fase')
		st_musaat_datos.tipo_obra = i_w.dw_1.getitemstring(1, 'tipo_trabajo')
		st_musaat_datos.pem = i_w.idw_fases_estadistica.getitemnumber(1, 'pem')
		st_musaat_datos.administracion = i_w.idw_fases_datos_exp.getitemstring(1, 'administracion')
		st_musaat_datos.superficie = i_w.idw_fases_estadistica.getitemnumber(1, 'superficie')
		st_musaat_datos.volumen = i_w.idw_fases_estadistica.getitemnumber(1, 'volumen')
		st_musaat_datos.porcentaje =porc_col_real * 100
		st_musaat_datos.cobertura = 0
		// Le pasamos en la estructura si el colegiado es funcionario
		st_musaat_datos.funcionario = i_w.idw_fases_colegiados.getitemstring(j, 'facturado')
		//Luis CGU-401 
		st_musaat_datos.colindantes2m = i_w.idw_fases_estadistica.getitemstring(1, 'colindantes2m')
		if f_colegiado_tipopersona(id_col) = 'S' then
			retorno = f_musaat_calcula_prima_sociedad(st_musaat_datos)			
		else
			retorno = f_musaat_calcula_prima(st_musaat_datos)
		end if			
		musaat_col = st_musaat_datos.prima_comp
	end if
	
	dw_descuentos.setitem(dw_descuentos.RowCount(), 'musaat', musaat_col )
	musaat_avisado = f_total_avisado_musaat_colegiado(id_fase, id_col)
	dw_descuentos.setitem(dw_descuentos.RowCount(), 'musaat_pasado', musaat_avisado)
	musaat_cobrado = f_total_cobrado_musaat_colegiado(id_fase, id_col)
	dw_descuentos.setitem(dw_descuentos.RowCount(), 'musaat_cobrado', musaat_cobrado)
Next

end event

on w_descuentos_colegiado_old.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_descuentos=create dw_descuentos
this.cb_imprimir=create cb_imprimir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_descuentos
this.Control[iCurrent+3]=this.cb_imprimir
end on

on w_descuentos_colegiado_old.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_descuentos)
destroy(this.cb_imprimir)
end on

event open;call super::open;i_w = message.powerobjectparm

if i_w.idw_fases_colegiados.rowcount() <= 0 then return

// Si solo hay un colegiado hacemos que no se vean los totales
if i_w.idw_fases_colegiados.rowcount() = 1 then dw_descuentos.modify("DataWindow.Summary.Height='0'")

dw_1.insertrow(0)

// Llamamos al control de eventos
st_control_eventos c_evento
c_evento.evento = 'W_DESCUENTOS_COLEGIA'
c_evento.dw = dw_descuentos
if f_control_eventos(c_evento)=-1 then return


this.postevent('csd_cargar_datos')


end event

event pfc_preopen;call super::pfc_preopen;f_centrar_ventana(this)
end event

type dw_1 from u_dw within w_descuentos_colegiado_old
integer x = 2542
integer width = 393
integer height = 268
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_musaat_pagado_avi_fact"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;string id_col, id_fase
int j

choose case dwo.name
	case 'avi_fact'
		j=1
		id_fase = i_w.dw_1.getitemstring(1, 'id_fase')
		if data = 'A' then
			For j = 1 to i_w.idw_fases_colegiados.rowcount()
				id_col = i_w.idw_fases_colegiados.getitemstring(j, 'id_col')
				dw_descuentos.setitem(j, 'musaat_cobrado', f_total_cobrado_musaat_colegiado(id_fase, id_col))
			next
		else
			For j = 1 to i_w.idw_fases_colegiados.rowcount()
				id_col = i_w.idw_fases_colegiados.getitemstring(j, 'id_col')
				dw_descuentos.setitem(j, 'musaat_cobrado', f_total_cobrado_musaat_colegiado_fact(id_fase, id_col))
			next
		end if
end choose

end event

type dw_descuentos from u_dw within w_descuentos_colegiado_old
integer x = 37
integer width = 2514
integer height = 1112
integer taborder = 0
string dataobject = "d_descuentos_colegiado_old"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;//
long i

for i=1 to dw_descuentos.rowcount()
	
	
	
next
end event

type cb_imprimir from commandbutton within w_descuentos_colegiado_old
integer x = 2574
integer y = 408
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

event clicked;dw_descuentos.print()
end event

