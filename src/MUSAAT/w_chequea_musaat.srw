HA$PBExportHeader$w_chequea_musaat.srw
$PBExportComments$Chequea movis de MUSAAT... A incluir en v 3
forward
global type w_chequea_musaat from w_response
end type
type dw_2 from u_dw within w_chequea_musaat
end type
type cb_2 from commandbutton within w_chequea_musaat
end type
type cb_1 from commandbutton within w_chequea_musaat
end type
type dw_1 from u_dw within w_chequea_musaat
end type
end forward

global type w_chequea_musaat from w_response
integer width = 3058
dw_2 dw_2
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_chequea_musaat w_chequea_musaat

on w_chequea_musaat.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
end on

on w_chequea_musaat.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_chequea_musaat
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_chequea_musaat
string tag = "texto=general.guardar_pantalla"
end type

type dw_2 from u_dw within w_chequea_musaat
integer x = 1993
integer y = 808
integer width = 727
integer taborder = 20
string dataobject = "d_chequeo_musaat_external"
boolean ib_isupdateable = false
end type

type cb_2 from commandbutton within w_chequea_musaat
string tag = "texto=general.chequea"
integer x = 549
integer y = 1248
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "chequea"
end type

event clicked;int i
string mensaje = ''
st_musaat_datos st_musaat_datos
int j = 0
int fd

fd = fileopen('c:\sica\errores_musaat.txt', StreamMode!, Write!)
for i = 1 to dw_1.rowcount()
//st_musaat_datos.n_visado = dw_1.getitemstring(1, 'contrato')
st_musaat_datos.id_col = dw_1.getitemstring(i, 'id_col')
st_musaat_datos.tipo_act = dw_1.getitemstring(i, 'tipo_act')
st_musaat_datos.tipo_obra = dw_1.getitemstring(i, 'tipo_obra')
st_musaat_datos.pem = dw_1.getitemnumber(i, 'presupuesto')
st_musaat_datos.superficie = dw_1.getitemnumber(i, 'superficie')
st_musaat_datos.volumen = dw_1.getitemnumber(i, 'volumen')
st_musaat_datos.porcentaje = dw_1.getitemnumber(i, 'porcentaje')
st_musaat_datos.cobertura = dw_1.getitemnumber(i, 'cobertura')

f_musaat_calcula_prima(st_musaat_datos)

if dw_1.getitemnumber(i, 'importe_vble') <> st_musaat_datos.prima_comp then
	mensaje += 'Reg: ' + dw_1.getitemstring(i, 'n_contrato') + '  Fichero:' + string(dw_1.getitemnumber(i, 'importe_vble') ) + ' Calculo: ' + string(st_musaat_datos.prima_comp ) + ' Col: ' + dw_1.getitemstring(i, 'n_col') + cr
	dw_2.insertrow(0)
	dw_2.setitem(dw_2.rowcount(), 'registro',dw_1.getitemstring(i, 'n_contrato'))
	dw_2.setitem(dw_2.rowcount(), 'n_col',dw_1.getitemstring(i, 'n_col') )
	dw_2.setitem(dw_2.rowcount(), 'imp_fichero',dw_1.getitemnumber(i, 'importe_vble') )
	dw_2.setitem(dw_2.rowcount(), 'imp_calculo',st_musaat_datos.prima_comp)
	
	j++
//	messagebox('kk', mensaje)
end if
//dw_2.setitem(1, 'presupuesto_calculo', st_musaat_datos.pem)
//dw_2.setitem(1, 'tabla', st_musaat_datos.tabla)
//dw_2.setitem(1, 'cobertura', st_musaat_datos.cobertura)
//dw_2.setitem(1, 'importe_musaat', st_musaat_datos.prima_comp)
//dw_2.setitem(1, 'coef_k', st_musaat_datos.coef_k)
//dw_2.setitem(1, 'coef_c', st_musaat_datos.coef_c)
//dw_2.setitem(1, 'coef_g', st_musaat_datos.coef_g)
//dw_2.setitem(1, 'coef_cm', st_musaat_datos.coef_cm)
//dw_2.setitem(1, 'coef_colegio', st_musaat_datos.coef_colegio)
//dw_2.setitem(1, 'formula', st_musaat_datos.formula)

next
filewrite(fd, mensaje)
fileclose(fd)

dw_2.setsort('n_col')
dw_2.sort()
string cadena[]
cadena[1]=string(j)
messagebox('kk', g_idioma.of_getmsg('msg_musaat.no_coinciden_movimientos',cadena,'No coinciden ' + string(j) + ' movimientos'))
if messagebox('kk',g_idioma.of_getmsg('msg_musaat.imprimir', 'imprimir?'), Question!, YesNo!) = 1 then dw_2.print()

end event

type cb_1 from commandbutton within w_chequea_musaat
string tag = "texto=general.recupera"
integer x = 91
integer y = 1248
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "recupera"
end type

event clicked;dw_1.retrieve()
end event

type dw_1 from u_dw within w_chequea_musaat
integer x = 37
integer y = 40
integer width = 2903
integer height = 1172
integer taborder = 10
string dataobject = "d_chequeo_musaat"
boolean ib_isupdateable = false
end type

