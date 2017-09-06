HA$PBExportHeader$w_musaat_funcionario.srw
forward
global type w_musaat_funcionario from w_response
end type
type cb_1 from commandbutton within w_musaat_funcionario
end type
type dw_colegiados from u_dw within w_musaat_funcionario
end type
type st_1 from statictext within w_musaat_funcionario
end type
type dw_3 from u_dw within w_musaat_funcionario
end type
type cb_3 from commandbutton within w_musaat_funcionario
end type
end forward

global type w_musaat_funcionario from w_response
integer width = 1961
integer height = 1164
string title = "MUSAAT Funcionario"
boolean controlmenu = false
event csd_regularizar ( )
cb_1 cb_1
dw_colegiados dw_colegiados
st_1 st_1
dw_3 dw_3
cb_3 cb_3
end type
global w_musaat_funcionario w_musaat_funcionario

type variables
w_fases_detalle i_w
datawindow idw_clientes, idw_colegiados, idw_descuentos
datawindow idw_fases_datos_exp, idw_1, idw_fases_src, idw_estadistica


end variables

on w_musaat_funcionario.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_colegiados=create dw_colegiados
this.st_1=create st_1
this.dw_3=create dw_3
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_colegiados
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.cb_3
end on

on w_musaat_funcionario.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_colegiados)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.cb_3)
end on

event open;call super::open;f_centrar_ventana(this)

dw_colegiados.retrieve(g_id_fase)

i_w = g_detalle_fases
idw_clientes = i_w.idw_fases_promotores
idw_colegiados = i_w.idw_fases_colegiados
idw_descuentos = i_w.idw_fases_informes
idw_fases_datos_exp = i_w.dw_fases_datos_exp
idw_fases_src = i_w.idw_fases_src
idw_estadistica = i_w.idw_fases_estadistica
idw_1 = i_w.dw_1

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_musaat_funcionario
integer x = 2533
integer y = 1796
integer width = 46
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_musaat_funcionario
integer x = 2464
integer y = 1792
integer width = 46
integer taborder = 0
end type

type cb_1 from commandbutton within w_musaat_funcionario
integer x = 379
integer y = 896
integer width = 402
integer height = 112
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
end type

event clicked;string mensaje, id_col
double musaat = 0, cip = 0, total_musaat = 0, porc_col = 0, suma_porc = 0, porc_col_real = 0
boolean factura = false
int i, j, retorno, fila_colegiado

st_musaat_datos st_musaat_datos

for j=1 to dw_colegiados.rowcount()
	id_col = dw_colegiados.getitemstring(j,'id_col')
	// Buscamos al colegiado en la lista
	for i = 1 to i_w.idw_fases_colegiados.rowcount()
		if i_w.idw_fases_colegiados.getitemstring(i, 'id_col') = id_col then
			fila_colegiado = i
			exit
		end if
	next
	// Obtenemos el % del porcentaje
	suma_porc = 0
	porc_col = i_w.idw_fases_colegiados.getitemnumber(fila_colegiado, 'porcen_a')
	for i = 1 to i_w.idw_fases_colegiados.rowcount()
		suma_porc += i_w.idw_fases_colegiados.getitemnumber(i, 'porcen_a')
	next
	porc_col_real = porc_col / suma_porc
	// Prima
	if i_w.idw_fases_estadistica.rowcount() > 0 then
		st_musaat_datos.n_visado = idw_1.getitemstring(1, 'id_fase')
		st_musaat_datos.id_col = id_col
		st_musaat_datos.tipo_act = idw_1.getitemstring(1, 'fase')
		st_musaat_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
		st_musaat_datos.pem = i_w.idw_fases_estadistica.getitemnumber(1, 'pem')
		st_musaat_datos.administracion = i_w.idw_fases_datos_exp.getitemstring(1, 'administracion')
		st_musaat_datos.superficie = i_w.idw_fases_estadistica.getitemnumber(1, 'superficie')
		st_musaat_datos.volumen = i_w.idw_fases_estadistica.getitemnumber(1, 'volumen')
		st_musaat_datos.tipo_csd = '14'
		st_musaat_datos.porcentaje = porc_col_real * 100
		st_musaat_datos.cobertura = 0
		st_musaat_datos.genera_movi = true
		retorno = f_musaat_calcula_prima(st_musaat_datos)
	end if
next

i_w.postevent('csd_refrescar_src')	

close(parent)

end event

type dw_colegiados from u_dw within w_musaat_funcionario
integer x = 37
integer y = 116
integer width = 1856
integer height = 732
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_colegiados_funcionarios"
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;// Sobreescrito
end event

type st_1 from statictext within w_musaat_funcionario
integer x = 37
integer y = 32
integer width = 1705
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Se van a generar los movimientos de MUSAAT a los funcionarios por importe 0"
boolean focusrectangle = false
end type

type dw_3 from u_dw within w_musaat_funcionario
boolean visible = false
integer x = 2053
integer y = 68
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_factu_minutas_detalle"
end type

type cb_3 from commandbutton within w_musaat_funcionario
integer x = 983
integer y = 896
integer width = 544
integer height = 112
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar: No Generar"
boolean cancel = true
end type

event clicked;close(parent)

end event

