HA$PBExportHeader$w_minutas_devolucion.srw
forward
global type w_minutas_devolucion from w_response
end type
type dw_3 from u_dw within w_minutas_devolucion
end type
type st_proceso from statictext within w_minutas_devolucion
end type
type st_1 from statictext within w_minutas_devolucion
end type
type cb_aumentar from commandbutton within w_minutas_devolucion
end type
type cb_disminuir from commandbutton within w_minutas_devolucion
end type
type sle_imprimir_copias from singlelineedit within w_minutas_devolucion
end type
type st_3 from statictext within w_minutas_devolucion
end type
type st_2 from statictext within w_minutas_devolucion
end type
type sle_imprimir_originales from singlelineedit within w_minutas_devolucion
end type
type cb_disminuir_copias from commandbutton within w_minutas_devolucion
end type
type cb_aumentar_copias from commandbutton within w_minutas_devolucion
end type
type cb_1 from commandbutton within w_minutas_devolucion
end type
type cb_2 from commandbutton within w_minutas_devolucion
end type
type dw_2 from u_dw within w_minutas_devolucion
end type
type dw_fact from u_dw within w_minutas_devolucion
end type
type dw_4 from u_dw within w_minutas_devolucion
end type
type dw_1 from u_dw within w_minutas_devolucion
end type
type dw_historico from u_csd_dw within w_minutas_devolucion
end type
end forward

global type w_minutas_devolucion from w_response
integer width = 2555
integer height = 2120
string title = "Devoluciones"
dw_3 dw_3
st_proceso st_proceso
st_1 st_1
cb_aumentar cb_aumentar
cb_disminuir cb_disminuir
sle_imprimir_copias sle_imprimir_copias
st_3 st_3
st_2 st_2
sle_imprimir_originales sle_imprimir_originales
cb_disminuir_copias cb_disminuir_copias
cb_aumentar_copias cb_aumentar_copias
cb_1 cb_1
cb_2 cb_2
dw_2 dw_2
dw_fact dw_fact
dw_4 dw_4
dw_1 dw_1
dw_historico dw_historico
end type
global w_minutas_devolucion w_minutas_devolucion

type variables
datawindowchild i_dwc_colegiados,i_dwc_clientes
w_fases_detalle i_w
datawindow  idw_clientes, idw_colegiados, idw_descuentos 
datawindow  idw_estadistica, idw_fases_datos_exp, idw_1, idw_fases_src, idw_honos
string grabar_renuncia = 'N'
boolean ib_generar_movim= false
u_dw idw_fases_modificacion_datos
string is_id_fase
double porc_realizado_musaatcc=0
end variables

forward prototypes
public subroutine wf_generar_movim_0 (string id_fase, string id_col, double porc_renuncia)
public function integer wf_actualiza_mov_musaat (string id_minuta)
end prototypes

public subroutine wf_generar_movim_0 (string id_fase, string id_col, double porc_renuncia);// SCP-144 Se genera el movimiento de renuncia con importe 0

st_musaat_datos st_musaat_datos

if not ib_generar_movim then return

st_musaat_datos.n_visado = id_fase
st_musaat_datos.recuperar = true
st_musaat_datos.genera_movi = true
st_musaat_datos.id_col = id_col
st_musaat_datos.cobertura = 0 // ICT-65
st_musaat_datos.porcentaje_devolucion = porc_renuncia
st_musaat_datos.importe_sobre_honos = 0
st_musaat_datos.obra_iniciada = dw_1.getitemstring(1,'obra_iniciada')
st_musaat_datos.f_renuncia = datetime(today(),now()) //dw_1.getitemdatetime(1,'fecha')

if i_w.idw_fases_datos_exp.getitemstring(1, 'administracion') = 'N' then
	st_musaat_datos.tipo_csd = '60'
else
	st_musaat_datos.tipo_csd = '63'
end if
if f_colegiado_tipopersona(id_col) = 'S' then
	f_musaat_calcula_prima_sociedad(st_musaat_datos)
else
	f_musaat_calcula_prima(st_musaat_datos)	
end if

messagebox(g_titulo, "Se ha generado el movimiento de renuncia con prima 0.")

end subroutine

public function integer wf_actualiza_mov_musaat (string id_minuta);// Actualiza el movimiento de musaat creado.
string obra_iniciada
datetime f_renuncia, f_extorno


obra_iniciada = dw_1.getitemstring(1, 'obra_iniciada')
f_renuncia = datetime(today())
dw_2.accepttext()
f_extorno  = dw_2.getitemdatetime(1, 'fecha_pago')

UPDATE musaat_movimientos  
SET  obra_iniciada = :obra_iniciada,   
         f_renuncia = :f_renuncia,
	    f_extorno  = :f_extorno
WHERE musaat_movimientos.id_minuta = :id_minuta   
using SQLCA   ;

return 1


end function

on w_minutas_devolucion.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.st_proceso=create st_proceso
this.st_1=create st_1
this.cb_aumentar=create cb_aumentar
this.cb_disminuir=create cb_disminuir
this.sle_imprimir_copias=create sle_imprimir_copias
this.st_3=create st_3
this.st_2=create st_2
this.sle_imprimir_originales=create sle_imprimir_originales
this.cb_disminuir_copias=create cb_disminuir_copias
this.cb_aumentar_copias=create cb_aumentar_copias
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_2=create dw_2
this.dw_fact=create dw_fact
this.dw_4=create dw_4
this.dw_1=create dw_1
this.dw_historico=create dw_historico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.st_proceso
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_aumentar
this.Control[iCurrent+5]=this.cb_disminuir
this.Control[iCurrent+6]=this.sle_imprimir_copias
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.sle_imprimir_originales
this.Control[iCurrent+10]=this.cb_disminuir_copias
this.Control[iCurrent+11]=this.cb_aumentar_copias
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.dw_2
this.Control[iCurrent+15]=this.dw_fact
this.Control[iCurrent+16]=this.dw_4
this.Control[iCurrent+17]=this.dw_1
this.Control[iCurrent+18]=this.dw_historico
end on

on w_minutas_devolucion.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.st_proceso)
destroy(this.st_1)
destroy(this.cb_aumentar)
destroy(this.cb_disminuir)
destroy(this.sle_imprimir_copias)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_imprimir_originales)
destroy(this.cb_disminuir_copias)
destroy(this.cb_aumentar_copias)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.dw_fact)
destroy(this.dw_4)
destroy(this.dw_1)
destroy(this.dw_historico)
end on

event open;call super::open;f_centrar_ventana(this)

dw_1.insertrow(0)
dw_2.insertrow(0)
dw_2.SetItem(1,'fecha_pago',DateTime(Today(),Now()))
dw_2.Setitem(1,'forma_pago',g_formas_pago.liquidacion)
dw_2.SetItem(1,'banco',g_banco_por_defecto)
dw_2.SetItem(1,'forma_pago_liq',g_formas_pago.transferencia)
dw_2.settaborder('forma_pago', 0)
dw_2.settaborder('banco', 0)
dw_4.insertrow(0)

i_w = g_detalle_fases
idw_clientes = i_w.idw_fases_promotores
idw_colegiados = i_w.idw_fases_colegiados
idw_descuentos = i_w.idw_fases_informes
idw_fases_datos_exp = i_w.dw_fases_datos_exp
idw_fases_src = i_w.idw_fases_src
idw_estadistica = i_w.idw_fases_estadistica
idw_honos = i_w.idw_fases_cip_tfe
idw_1 = i_w.dw_1
idw_fases_modificacion_datos	= dw_historico

// ICN-180 Para Navarra si es SIN gestion de cobro si que se puede devolver aunque este cerrado
if g_colegio<>'COAATNA' or (g_colegio='COAATNA' and i_w.dw_1.GetItemString(i_w.dw_1.GetRow(),'tipo_gestion')<>'P') then
	// CGN-262 Si est$$HEX2$$e1002000$$ENDHEX$$cerrado el contrato mostramos aviso y cerramos la ventana
	if idw_fases_datos_exp.getitemstring(1, 'cerrado') = 'S' then
		messagebox(g_titulo, "ATENCI$$HEX1$$d300$$ENDHEX$$N: Este contrato se encuentra en estado cerrado. No se permiten devoluciones.",  information!, ok!)
		dw_1.SetItemStatus(1, 0, Primary!, NotModified!)
		closewithreturn(this, 'CANCELAR')
		return
	end if
end if


dw_2.SetItem(1,'asunto','DEVOLUCION Reg. ' + idw_1.getitemstring(1, 'n_registro') + ' EXP. ' + idw_1.getitemstring(1, 'n_EXPEDI'))

dw_1.setitem(1,'presupuesto', i_w.idw_fases_estadistica.getitemnumber(1, 'pem'))
dw_1.setitem(1,'n_contrato_ant', idw_1.getitemstring(1, 'n_contrato_ant'))
dw_1.setitem(1, 'usuario', g_usuario)
dw_fact.insertrow(0)

// Si el dw tiene el campo "devolver proyecto"
if lower(dw_1.describe("devol_proy.name")) = 'devol_proy' then 
	string tipo_act, existe
	tipo_act = idw_1.getitemstring(1, 'fase')
	select tipo_act into :existe from fases_renuncias_desglose where tipo_act = :tipo_act ;
	
	if not f_es_vacio(existe) then dw_1.setitem(1, 'devol_proy', 'S')
	if g_colegio = 'COAATCC' then dw_1.setitem(1, 'devol_proy', 'N')
end if
end event

event csd_recuperar_consulta(string param);call super::csd_recuperar_consulta;dw_fact.trigger event itemchanged(1, dw_fact.object.fact, dw_fact.getitemstring(1, 'fact'))
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_minutas_devolucion
integer x = 2533
integer y = 1376
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_minutas_devolucion
integer x = 2533
integer y = 1236
integer taborder = 0
end type

type dw_3 from u_dw within w_minutas_devolucion
boolean visible = false
integer x = 1833
integer y = 1288
integer width = 1225
integer height = 604
integer taborder = 0
string dataobject = "d_factu_minutas_detalle"
boolean ib_isupdateable = false
end type

type st_proceso from statictext within w_minutas_devolucion
integer x = 55
integer y = 1836
integer width = 1701
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

type st_1 from statictext within w_minutas_devolucion
integer x = 69
integer y = 32
integer width = 1701
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Introduzca las cantidades a devolver por este contrato :"
boolean focusrectangle = false
end type

type cb_aumentar from commandbutton within w_minutas_devolucion
boolean visible = false
integer x = 2345
integer y = 1344
integer width = 64
integer height = 44
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "+"
end type

event clicked;if sle_imprimir_copias.text < '98' then
	sle_imprimir_copias.text= string(integer(sle_imprimir_copias.text) + 1 , '00')
end if
end event

type cb_disminuir from commandbutton within w_minutas_devolucion
boolean visible = false
integer x = 2345
integer y = 1392
integer width = 64
integer height = 44
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "-"
end type

event clicked;if sle_imprimir_copias.text > '00' then
	sle_imprimir_copias.text= string(integer(sle_imprimir_copias.text) - 1 , '00')
end if
end event

type sle_imprimir_copias from singlelineedit within w_minutas_devolucion
boolean visible = false
integer x = 2235
integer y = 1344
integer width = 105
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "01"
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

event losefocus;this.text= string(integer(this.text) , '00')

end event

type st_3 from statictext within w_minutas_devolucion
boolean visible = false
integer x = 1957
integer y = 1512
integer width = 270
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$ba002000$$ENDHEX$$Copias :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_minutas_devolucion
boolean visible = false
integer x = 1915
integer y = 1360
integer width = 311
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$ba002000$$ENDHEX$$Originales :"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_imprimir_originales from singlelineedit within w_minutas_devolucion
boolean visible = false
integer x = 2235
integer y = 1496
integer width = 105
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "01"
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

event losefocus;this.text= string(integer(this.text) , '00')

end event

type cb_disminuir_copias from commandbutton within w_minutas_devolucion
boolean visible = false
integer x = 2345
integer y = 1544
integer width = 64
integer height = 44
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "-"
end type

event clicked;if sle_imprimir_originales.text > '00' then
	sle_imprimir_originales.text= string(integer(sle_imprimir_originales.text) - 1 , '00')
end if
end event

type cb_aumentar_copias from commandbutton within w_minutas_devolucion
boolean visible = false
integer x = 2345
integer y = 1496
integer width = 64
integer height = 44
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "+"
end type

event clicked;if sle_imprimir_originales.text < '98' then
	sle_imprimir_originales.text= string(integer(sle_imprimir_originales.text) + 1 , '00')
end if
end event

type cb_1 from commandbutton within w_minutas_devolucion
event csd_modificacion_datos ( string idfase,  u_dw dw,  string nombre_dw,  string campo,  long row )
integer x = 654
integer y = 1916
integer width = 402
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
end type

event csd_modificacion_datos(string idfase, u_dw dw, string nombre_dw, string campo, long row);// Actualiza los datos modificados en la tabla "modificaciones"
// ------------------------------------------------------------
string  fase, modificacion, data, tipo
integer fila

// Le quitamos el n$$HEX2$$ba002000$$ENDHEX$$de filas al nombre del tab que lo lleve
if PosA(nombre_dw, '(') > 0 then nombre_dw = LeftA(nombre_dw, PosA(nombre_dw, '(')-2)

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

// David 13/03/2006 - Excepci$$HEX1$$f300$$ENDHEX$$n: Para Guadalajara, cuando se modifica el campo del texto de un reparo que obtenga 
// el valor anterior de la BD para que no coja el texto inicial que no ha introducido el usuario
if g_colegio = 'COAATGU' and nombre_dw = 'REPAROS' and campo = 'texto' then
	string id_reparo, texto
	id_reparo = dw.getitemstring(row,'id_reparo')
	SELECT fases_reparos.texto  INTO :texto FROM fases_reparos WHERE fases_reparos.id_reparo = :id_reparo  ;
	if isnull(texto) then texto = ''
	data = texto
end if


//se a$$HEX1$$f100$$ENDHEX$$ade un registro a modificaci$$HEX1$$f300$$ENDHEX$$n de datos
if g_recien_grabado_modificacion_fases=TRUE then
	idw_fases_modificacion_datos.triggerevent("pfc_addrow")
end if

//Debido a que hay una DW que no es de Fases se coloca el tipo_modulo al que pertenece
//if nombre_dw = Upper('dw_fases_datos_exp') then
//	idw_fases_modificacion_datos.triggerevent("pfc_addrow")
//   idw_fases_modificacion_datos.setitem(idw_fases_modificacion_datos.rowcount(),'tipo_modulo','02')
//end if
//David - 22/11/2004 : Para que se muestren los cambios desde esta ventana

fila        =idw_fases_modificacion_datos.rowcount()
fase        =idfase
if fila>0 then
	modificacion=idw_fases_modificacion_datos.getitemstring(fila,'modificacion')
end if
// se concatenan las modificaciones con la anterior
if isnull(modificacion) then modificacion = ''
if LeftA(nombre_dw,6) = 'MUSAAT' or LeftA(nombre_dw,7) = 'DETALLE' or LeftA(nombre_dw,7) = 'EXPEDIE' then
	modificacion = modificacion + nombre_dw + ' ' + campo + '=' + data + '; '	
else
	modificacion = modificacion + nombre_dw + ' (' + string(row) + ') ' + campo + '=' + data + '; '
end if

// Se actualiza la dw de modificaciones oculta
idw_fases_modificacion_datos.setitem(fila,'id_colegiado',fase)
idw_fases_modificacion_datos.setitem(fila,'modificacion',modificacion)
idw_fases_modificacion_datos.setitem(fila,'fecha',datetime(today(),now()))
idw_fases_modificacion_datos.setitem(fila,'usuario',g_usuario)

g_recien_grabado_modificacion_fases=FALSE

this.TriggerEvent('csd_control_estados')

end event

event clicked;string mensaje, forma_pago, banco, asunto, id_col, es_contado, id_cliente_mayor_porc, obra_ofi='N', tipo_movimiento_csd
string obra_oficial, t_visado, pendiente='S', id_minuta, id_fase, id_cli, n_aviso, pagador, t_iva, id_cliente, t_iva_honos
string t_iva_desplaza, t_iva_dv, t_iva_cip, cliente_colegiado, t_visado_entrada, obra_oficial_entrada, n_contrato_ant
string decenal, observaciones, paga_dv, restar_cip, restar_musaat, restar_dv, n_renuncia
datetime fecha_pago, fecha, f_nula,f_alta
double porc_iva, base_musaat, total_cliente, total_colegiado, irpf, total_aviso, base_dv, porc_iva_honos, porc_iva_desplaza
double porc_iva_dv, porc_iva_cip, porc_cli_mayor=0, porc_col=0, porc_col_real=0, suma_porc=0, iva_cip=0, iva_dv=0, musaat=0
double cip=0, porc_renuncia=0, total_liquidacion=0, dv=0, base_otros=0
boolean genera_movi=false, encontrado=false, es_sociedad=false, fact=false
int i, j
n_csd_impresion_formato impresion_formato
impresion_formato = create n_csd_impresion_formato

st_musaat_datos st_musaat_datos
st_liquidacion st_liquidacion
id_col=dw_1.getitemstring(1, 'id_colegiado')
SELECT src_f_alta INTO :f_alta FROM musaat  
WHERE id_col=:id_col;



setnull(f_nula)

dw_1.accepttext()
dw_fact.accepttext()

SetPointer(HourGlass!)
Parent.st_proceso.text = 'Validando entrada ...'

cliente_colegiado = dw_1.getitemstring(1,'cliente_colegiado')
choose case cliente_colegiado
	case 'cl'
		mensaje = mensaje + f_valida(dw_1,'id_colegiado','NONULO','Debe especificar el colegiado.')		
		mensaje = mensaje + f_valida(dw_1,'id_cliente','NONULO','Debe especificar el cliente.')
		id_cliente = dw_1.getitemstring(1, 'id_cliente')
		id_col = dw_1.getitemstring(1, 'id_colegiado')
	case 'co', 'em'
		mensaje = mensaje + f_valida(dw_1,'id_colegiado','NONULO','Debe especificar el colegiado.')
		id_col = dw_1.getitemstring(1, 'id_colegiado')
end choose

fact = dw_fact.getitemstring(1,'fact') = 'S'
if fact then
	mensaje = mensaje + f_valida(dw_2,'fecha_pago','NONULO','Debe especificar la fecha de pago.')
	mensaje = mensaje + f_valida(dw_2,'forma_pago','NONULO','Debe especificar la forma de pago.')
	mensaje = mensaje + f_valida(dw_2,'banco','NONULO','Debe especificar el banco.')
	mensaje = mensaje + f_valida(dw_2,'asunto','NONULO','Debe especificar el concepto.')
end if

if mensaje <>'' Then
	st_proceso.text = ''
	Messagebox(g_titulo,mensaje,StopSign!)
	return
End if

fecha_pago = dw_2.getitemdatetime(1, 'fecha_pago')
if fact then
	forma_pago = dw_2.getitemstring(1, 'forma_pago')
	banco = dw_2.getitemstring(1, 'banco')
	asunto = dw_2.getitemstring(1, 'asunto')
end if
t_visado_entrada = dw_1.getitemstring(1, 'tipo_visado')
obra_oficial_entrada = dw_1.getitemstring(1, 'tipo_oo')
porc_renuncia = dw_1.getitemnumber(1, 'porc_renuncia')
musaat = dw_1.getitemnumber(1, 'musaat')

if porc_renuncia <> 100 and musaat > 0 then
     if  messagebox(g_titulo, "Si la obra o actuaci$$HEX1$$f300$$ENDHEX$$n profesional ha comenzado, no debe realizarse la devoluci$$HEX1$$f300$$ENDHEX$$n de primas profesionales"+ CR + "$$HEX1$$bf00$$ENDHEX$$Desea continuar?", Exclamation!, YesNo!, 2) = 2 then
		return -1
	else
		if messagebox(g_titulo, "Recuerde que se ha de devolver el equivalente al 95% del total pagado  "+ CR + "$$HEX1$$bf00$$ENDHEX$$Desea continuar?", Exclamation!, YesNo!, 2) = 2 then
			return -1
		end if
	end if	
end if	

cip = dw_1.getitemnumber(1, 'cip')
dv = dw_1.getitemnumber(1, 'dv')
musaat = f_redondea(musaat)
cip = f_redondea(cip)
dv = f_redondea(dv)
porc_renuncia = f_redondea(porc_renuncia)
n_contrato_ant = dw_1.getitemstring(1, 'n_contrato_ant')
decenal = dw_1.getitemstring(1, 'decenal')

if isnull(musaat) then musaat = 0
if isnull(cip) then cip = 0
if isnull(dv) then dv = 0
if isnull(porc_renuncia) then porc_renuncia = 0
			
if musaat <> 0 then genera_movi = true else genera_movi = false

if f_colegiado_tipopersona(id_col) = 'S' then es_sociedad = true

// Buscamos el primer movimiento de este colegiado en el contrato
for i = 1 to idw_fases_src.rowcount()
	// No es Sociedad
	if es_sociedad = false  then
		if id_col = idw_fases_src.getitemstring(i, 'id_col') then
			encontrado = true
			obra_oficial  = idw_fases_src.getitemstring(i, 'obra_oficial')
			exit
		end if
	else
	// Si se trata de una sociedad buscaremos el primer colegiado de la sociedad en los movimientos de musaat.
		if f_colegiado_es_asociado(id_col, idw_fases_src.getitemstring(i, 'id_col')) then
			encontrado = true
			obra_oficial  = idw_fases_src.getitemstring(i, 'obra_oficial')
			exit
		end if
	end if
next

if f_es_vacio(obra_oficial_entrada) then
	if obra_oficial = 'N' then obra_oficial = '0'
	if obra_oficial = 'S' then 
		if idw_1.getitemstring(1, 'aplicado_10') = 'S' then
			obra_oficial = '1' // 10%
		else
			obra_oficial = '2' // 100% seguridad
		end if
	end if
	if f_es_vacio(obra_oficial) then obra_oficial = '0'
else
	obra_oficial = obra_oficial_entrada
end if

// El tipo de visado es de devolucion : 6
if f_es_vacio(t_visado_entrada) then
	t_visado = '6'
else
	t_visado = t_visado_entrada
end if

if cliente_colegiado = 'cl' then encontrado = true // Si es cliente que pase esta validaci$$HEX1$$f300$$ENDHEX$$n

// Modificado David - 01/03/2005
// En Gran Canaria si no es primer visado puede que no tenga movimiento, debe pasar la validaci$$HEX1$$f300$$ENDHEX$$n
if idw_1.getitemstring(1, 'tipo_registro') <> 'IP' then encontrado = true

// tipo de movimiento csd = t_visado + obra_oficial, lo grabaremos en el campo tipo_minuta de la minuta
tipo_movimiento_csd = t_visado + obra_oficial

// Si est$$HEX2$$e1002000$$ENDHEX$$marcado decenal, es un caso especial que diferenciamos con tipo_movimiento_csd
if decenal = 'S' then tipo_movimiento_csd = 'DE'

if musaat <> 0 then
	if encontrado = false then mensaje += cr + 'Este colegiado no tiene movimientos de MUSAAT por lo que no se puede devolver nada'
	if LenA(tipo_movimiento_csd) <> 2 and f_es_vacio(mensaje) then mensaje += cr + 'Existe alguna anomalia en este contrato que impide devolver MUSAAT, rev$$HEX1$$ed00$$ENDHEX$$selo y vuelva a intentarlo'
	// 	SCP-464 	  a$$HEX1$$f100$$ENDHEX$$adida clausula de musaat para que no se puedan devolver contratos con fecha anterior al alta
	if i_w.dw_1.getitemdatetime(1, 'f_visado')< f_alta and f_alta>datetime(date('20/07/2010'), time('00:00:00'))  then
		mensaje += cr + 'No se proceder$$HEX2$$e1002000$$ENDHEX$$a la devoluci$$HEX1$$f300$$ENDHEX$$n del SRC debido a que el alta en el mismo es posterior al visado de la obra'
		dw_1.setitem(1,"restar_musaat","N")
	end if
end if


// Modificado Fernando 9-12-2002
// No dejar devolver si se trata de una obra de administracion, es sociedad  y
// mussat es distinto de 0
//if (musaat <> 0)  and (f_colegiado_tipopersona(id_col) = 'S') and &
//	(i_w.idw_fases_datos_exp.getitemstring(1, 'administracion') = 'S') then
//	mensaje += cr + 'Las devoluciones de Musaat a sociedades deben hacerse manualmente.'
//end if

// DAVID - 08/09/2004 - Los movimientos de musaat de tipo 6 deben ser negativos
if musaat>0 and t_visado='6' then mensaje += cr + 'Las devoluciones de Musaat deben tener importe negativo'
//if musaat<>0 and 
if mensaje<>'' Then
	st_proceso.text = ''
	Messagebox(g_titulo,mensaje,StopSign!)
	return
End if

Parent.st_proceso.text = 'Generando Aviso de Gastos ...'
id_fase =  idw_1.getitemstring(1, 'id_fase')
id_minuta = f_siguiente_numero('FASES-MINUTAS',10)
n_aviso = f_numera_aviso(true) // Modificado Ricardo 2005-05-12
irpf = g_irpf_por_defecto
fecha = fecha_pago
observaciones = dw_1.getitemstring(1, 'observ')

choose case cliente_colegiado
	case 'co'
		pagador = '1'
	case 'cl'
		pagador = '3'
	case 'em'
		pagador = '2'
end choose

// Coger el promotor de mayor %
if cliente_colegiado = 'co' or cliente_colegiado = 'em' then
	for i = 1 to idw_clientes.rowcount()
		if idw_clientes.getitemnumber(i, 'porcen') > porc_cli_mayor then
			id_cliente_mayor_porc = idw_clientes.getitemstring(i, 'id_cliente')
		end if
	next
	id_cliente = id_cliente_mayor_porc
end if

t_iva = g_t_iva_defecto
porc_iva =  f_dame_porcent_iva(g_t_iva_defecto)
base_musaat = musaat
total_cliente = 0
t_iva_honos = g_t_iva_00
t_iva_desplaza = g_t_iva_00  
t_iva_dv = g_t_iva_00

SELECT t_iva INTO :t_iva_cip FROM csi_articulos_servicios  
WHERE csi_articulos_servicios.codigo = :g_codigos_conceptos.cip and csi_articulos_servicios.colegio = :g_colegio;

SELECT t_iva INTO :t_iva_dv FROM csi_articulos_servicios  
WHERE csi_articulos_servicios.codigo = :g_codigos_conceptos.dv and csi_articulos_servicios.colegio = :g_colegio;

if dw_1.GetItemString(1,'forzar_iva')='S' then
	t_iva_cip=dw_1.GetItemString(1,'iva_aplicado')
	t_iva_dv=dw_1.GetItemString(1,'iva_aplicado')	
end if

porc_iva_honos = 0   
porc_iva_desplaza = 0   
porc_iva_dv = f_dame_porcent_iva(t_iva_dv)
porc_iva_cip = f_dame_porcent_iva(t_iva_cip)
iva_cip = f_aplica_t_iva(cip, t_iva_cip)
iva_dv = f_aplica_t_iva(dv, t_iva_dv)

restar_cip = dw_1.getitemstring(1, 'restar_cip') 
restar_musaat = dw_1.getitemstring(1, 'restar_musaat') 
restar_dv = dw_1.getitemstring(1, 'restar_dv') 

total_colegiado = 0
if restar_cip = 'S' then total_colegiado += cip + iva_cip
if restar_musaat = 'S' then total_colegiado += musaat
if restar_dv = 'S' then total_colegiado += dv + iva_dv

//total_colegiado = musaat + cip + iva_cip + dv + iva_dv

// Insertamos la bonificaci$$HEX1$$f300$$ENDHEX$$n de MUSAAT en el aviso
if g_colegio = 'COAATLE' then
	double bonif_musaat
	bonif_musaat = dw_1.getitemnumber(1, 'bonif_musaat')
	if isnull(bonif_musaat) then bonif_musaat = 0
	total_colegiado = total_colegiado + bonif_musaat
	base_otros = dw_1.getitemnumber(1, 'bonif_musaat')
end if

total_aviso = total_colegiado
if fact then pendiente = 'N'
if fact = false then fecha_pago = f_nula
string id_renuncia
// Registramos la renuncia
if lower(dw_1.describe("id_renuncia.name")) = 'id_renuncia' then 
	id_renuncia = f_siguiente_numero('RENUNCIAS', 10)
	dw_1.setitem(1, 'id_renuncia',id_renuncia )
	id_fase = idw_1.getitemstring(1, 'id_fase')
	dw_1.setitem(1, 'id_fase',  idw_1.getitemstring(1, 'id_fase'))
	dw_1.setitem(1, 'fecha', DateTime(Today(),Now()))
	
	if t_visado = '6' then//Actualiza el N$$HEX1$$fa00$$ENDHEX$$mero de renuncia
		st_control_eventos c_evento 
		c_evento.evento = 'NUMERO_RENUNCIA'
		f_control_eventos(c_evento)			
		n_renuncia= f_numera_renuncia(c_evento.param1)
		dw_1.setitem(1, 'n_renuncia',n_renuncia )
		
		if IsNull(observaciones) then observaciones=''
		observaciones='Num. Renuncia: '+n_renuncia+". '"+observaciones
	end if
	
	
		
	dw_1.setitemstatus(1, 0, Primary!, NewModified!)
	dw_1.update()
	
	this.event csd_modificacion_datos(id_fase, dw_1, 'CREAR RENUNCIA','id_renuncia', 1)
	idw_fases_modificacion_datos.AcceptText()
	idw_fases_modificacion_datos.update()

	
	Messagebox(g_titulo,"La renuncia se ha guardado correctamente.")
end if
// Fin registro

// Modificado David 26/11/03 - Para que no genere avisos con importe 0
if total_aviso = 0 then
	st_proceso.text = ''
	Messagebox(g_titulo,"El importe total es 0. No se gener$$HEX2$$f3002000$$ENDHEX$$el aviso.",StopSign!)
	// Antes no se cerraba la ventana, vamos a cerrarla para que no graben m$$HEX1$$fa00$$ENDHEX$$ltiples renuncias
	
	wf_generar_movim_0 ( id_fase, id_col, porc_renuncia)
else

	paga_dv = 'P'
	if g_colegio = 'COAATGU' or g_colegio = 'COAATZ' or g_colegio = 'COAATNA'  or g_colegio = 'COAATTER' or g_colegio = 'COAATCC' or g_colegio = 'COAATMCA' then paga_dv = 'C' // Se devuelve todo al colegiado
	
	if g_colegio = 'COAATCC' and porc_realizado_musaatcc>0 then porc_renuncia=porc_realizado_musaatcc
	
//	string sql
//		sql = "INSERT INTO fases_minutas  ( id_minuta, id_fase, id_colegiado, id_cliente, cantidad, pendiente, facturado, id_honorario, f_facturado, id_factura, tipo_minuta, irpf, importe_irpf, n_aviso, fecha, fecha_pago, tipo_gestion, pagador, reclamar, t_iva, porc_iva, forma_pago, aplica_honos, porc_honos, concepto_honos, base_honos, iva_honos, aplica_desplaza, base_desplaza, iva_desplaza, concepto_desplaza, aplica_dv, base_dv, iva_dv, aplica_cip, base_cip, iva_cip, aplica_musaat, base_musaat, iva_musaat, aplica_retvol, porc_retvol, base_retvol, iva_retvol, total_cliente, total_colegiado, t_iva_honos, t_iva_desplaza, t_iva_dv, t_iva_cip, porc_iva_honos, porc_iva_desplaza, porc_iva_dv, porc_iva_cip, anulada, banco, irpf_cliente, observaciones, base_garantia, total_aviso, aplica_impresos,	base_impresos, iva_impresos, n_contrato_ant, paga_asalariado, paga_externo, paga_dv, t_minuta, urgente, 	base_cip_suplida, t_iva_cip_suplida, porc_iva_cip_suplida, iva_cip_suplida, musaat_suplida, base_otros) "
//	sql = sql + " VALUES ( '"+ id_minuta +"', '"+ id_fase +"', '"+ id_col +"', '"+ id_cliente +"', "+ string(porc_renuncia) +", '"+ pendiente+"', 'S' , null, null, " 
//	sql = sql + " null , '"+ tipo_movimiento_csd +"', "+ string(irpf) +",  0 , '"+ n_aviso +"', "+ string(fecha) +", "+ string(fecha_pago) +", 'S' , '"+ pagador +"',  'S' , '"+ t_iva +"', " 
//	sql = sql + string(porc_iva) +", '"+ forma_pago +"', 'N', 0, null, 0, 0, 'N', " 
//	sql = sql + " 0, 0, null, '"+  restar_dv +"', "+ string(dv) +", "+ string(iva_dv) +", '"+ restar_cip +"', "+ string(cip) +", "+ string(iva_cip) +", '"+ restar_musaat +"',"
//	sql = sql + string(porc_iva) +", '"+ forma_pago +"', 'N'  0, null, 0, 0, 'N', "+ string(total_colegiado) +", '"+ t_iva_honos +"', "
//	sql = sql + "'"+ t_iva_desplaza +"', '"+ t_iva_dv +"', '"+ t_iva_cip +"', "+ string(porc_iva_honos) +", "+ string(porc_iva_desplaza) +", "+ string(porc_iva_dv) +", "
//	sql = sql + string(porc_iva_cip) +"', 'N', '"+ banco +"', 'N', '"+ observaciones +"', 0, "+ string(total_aviso)+", 'N', "
//	sql = sql + " 0, 0, '"+ n_contrato_ant +"', 'N', 'N', '"+ paga_dv +"', 'F', 'N', 0, '00', 0, 0, 0, "+ string(base_otros) 
//	sql = sql + ")"
	
	INSERT INTO fases_minutas  
		( id_minuta, id_fase, id_colegiado, id_cliente, cantidad, pendiente, facturado, id_honorario, f_facturado, 
		id_factura, tipo_minuta, irpf, importe_irpf, n_aviso, fecha, fecha_pago, tipo_gestion, pagador, reclamar, t_iva, 
		porc_iva, forma_pago, aplica_honos, porc_honos, concepto_honos, base_honos, iva_honos, aplica_desplaza, 
		base_desplaza, iva_desplaza, concepto_desplaza, aplica_dv, base_dv, iva_dv, aplica_cip, base_cip, iva_cip, 
		aplica_musaat, base_musaat, iva_musaat, aplica_retvol, porc_retvol, base_retvol, iva_retvol, total_cliente,				
		total_colegiado, t_iva_honos, t_iva_desplaza, t_iva_dv, t_iva_cip, porc_iva_honos, porc_iva_desplaza, porc_iva_dv, 
		porc_iva_cip, anulada, banco, irpf_cliente, observaciones, base_garantia, total_aviso, aplica_impresos, 
		base_impresos, iva_impresos, n_contrato_ant, paga_asalariado, paga_externo, paga_dv, t_minuta, urgente, 
		base_cip_suplida, t_iva_cip_suplida, porc_iva_cip_suplida, iva_cip_suplida, musaat_suplida, base_otros)
	
	VALUES ( :id_minuta,  :id_fase, :id_col, :id_cliente, :porc_renuncia, :pendiente, 'S', null, null, 
		null, :tipo_movimiento_csd, :irpf, 0, :n_aviso, :fecha, :fecha_pago, 'S', :pagador, 'S', :t_iva, 
		:porc_iva, :forma_pago, 'N', 0, null, 0, 0, 'N', 
		0, 0, null, :restar_dv, :dv, :iva_dv, :restar_cip, :cip, :iva_cip, 		
		:restar_musaat, :base_musaat, 0, 'N', 0, 0, 0, :total_cliente, 
		:total_colegiado, :t_iva_honos, :t_iva_desplaza, :t_iva_dv, :t_iva_cip, :porc_iva_honos, :porc_iva_desplaza, :porc_iva_dv,
		:porc_iva_cip, 'N', :banco, 'N', :observaciones, 0, :total_aviso, 'N', 
		0, 0, :n_contrato_ant, 'N', 'N', :paga_dv, 'F', 'N', 
		0, '00',	0, 0, 0, :base_otros)  ;
	COMMIT;
	
	
	Parent.st_proceso.text = 'Recuperando Datos ...'
	
	// Generamos las facturas

	if fact then // S$$HEX1$$f300$$ENDHEX$$lo si est$$HEX2$$e1002000$$ENDHEX$$marcado el check
		dw_3.Retrieve(id_minuta)
		
		// DAVID - 11/05/2004 - No es necesario ya que el n$$HEX2$$ba002000$$ENDHEX$$contrato ant. se graba en la minuta
		//	// Metemos el n$$HEX2$$ba002000$$ENDHEX$$de contrato anterior para el movimiento de musaat en el dw para tenerlo en f_generar_factura
		//	dw_3.setitem(1, 'n_contrato_ant', n_contrato_ant)
		
		Parent.st_proceso.text = 'Generando Facturas ...'
		
		// g_cobro_obligado : con esto no regulariza : puede dejar de usarse usanso el tipo_movimiento_csd
		g_cobro_obligado = 'S'
		// Modificado Ricardo 2005-05-10
		st_generar_facturas_minutas parametros_factura_minuta
		parametros_factura_minuta.fecha_factura 		= dw_3.GetItemDateTime(1,'fecha_pago')
		parametros_factura_minuta.dw_minuta 			= dw_3
		parametros_factura_minuta.num_orig 				= Integer(sle_imprimir_copias.text)
		parametros_factura_minuta.num_copias 			= Integer(sle_imprimir_originales.text)
		parametros_factura_minuta.regulariza_musaat	= false
		parametros_factura_minuta.movimiento_musaat	= genera_movi
		parametros_factura_minuta.tipo_movimiento_csd= tipo_movimiento_csd
		parametros_factura_minuta.impresion_formato = impresion_formato
		parametros_factura_minuta.tipo_prev				= ''
		parametros_factura_minuta.dw_factura			= dw_3
		// La serie va en funcion del importe del aviso (COMO SON SIEMPRE SGC, con mirar el total_colegiado, basta)
		if total_colegiado>0 then
			parametros_factura_minuta.serie				= g_serie_fases
		else
			parametros_factura_minuta.serie				= g_facturas_negativas_serie
		end if
		
		f_generar_facturas_minuta(parametros_factura_minuta)
		//f_generar_facturas_minuta(dw_3,Integer(sle_imprimir_copias.text),Integer(sle_imprimir_originales.text), FALSE, genera_movi, tipo_movimiento_csd, '', dw_3)
		// FIN Modificado Ricardo 2005-05-10
		// Esta variable global debe desaparecer
		g_cobro_obligado = 'N'
		
		// Modificado Fernando. 9-12-2002
		// La devolucion por cuenta personal o contado no debe generar ninguna liquidacion
		// Insertar la liquidaci$$HEX1$$f300$$ENDHEX$$n : en positivo
			//	SELECT csi_formas_de_pago.contado  
			//		INTO :es_contado  
			//		FROM csi_formas_de_pago  
			//		WHERE csi_formas_de_pago.tipo_pago = :forma_pago;
	
		if cliente_colegiado = 'co' then
			if forma_pago = g_formas_pago.talon or forma_pago = g_formas_pago.transferencia &
			or forma_pago = g_formas_pago.liquidacion then
				st_liquidacion.id_fase			= id_minuta
				st_liquidacion.id_col			= id_col
				st_liquidacion.importe			= abs(total_aviso)
				choose case g_colegio
					case 'COAATZ', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATA', 'COAATNA', 'COAATTGN', 'COAATTEB', 'COAATTER', 'COAATCC', 'COAATMCA' , 'COAATLL'
						st_liquidacion.concepto			= 'Devoluci$$HEX1$$f300$$ENDHEX$$n ' + 'V$$HEX1$$ba00$$ENDHEX$$: ' + f_fases_n_salida(id_fase)
					case else
						st_liquidacion.concepto			= 'Devoluci$$HEX1$$f300$$ENDHEX$$n ' + 'EXP: ' + f_dame_exp(id_fase) + ' REG: ' + f_dame_n_reg(id_fase)
				end choose
				st_liquidacion.forma_pago		= dw_2.getitemstring(1,'forma_pago_liq')
				st_liquidacion.banco				= dw_2.getitemstring(1,'banco')
				st_liquidacion.tipo				= '1'
				st_liquidacion.f_entrada 		= fecha_pago
				st_liquidacion.contabilizada 	= 'N'
				f_liquidacion(st_liquidacion)
			end if
		end if
		
		wf_generar_movim_0 ( id_fase, id_col, porc_renuncia)

		if musaat<>0 and t_visado='6' then wf_actualiza_mov_musaat(id_minuta)
		
	end if
end if

if isvalid(g_detalle_fases) then
	g_detalle_fases.postevent('csd_refrescar_avisos')
	g_detalle_fases.postevent('csd_refrescar_src')	
end if

Parent.st_proceso.text = 'Proceso Finalizado.'
messagebox(g_titulo, 'Proceso Finalizado')

close(parent)

end event

type cb_2 from commandbutton within w_minutas_devolucion
integer x = 1385
integer y = 1916
integer width = 402
integer height = 92
integer taborder = 110
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
dw_1.SetItemStatus(1, 0, Primary!, NotModified!)

closewithreturn(parent, 'CANCELAR')

end event

type dw_2 from u_dw within w_minutas_devolucion
boolean visible = false
integer x = 59
integer y = 1348
integer width = 1390
integer height = 464
integer taborder = 30
string dataobject = "d_pago_facturas"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

this.object.asunto_t.visible = false
this.object.asunto.visible = false



//Hacemos el filtro para que no muestre la forma de pago CM
datawindowchild dwc_formapago
this.GetChild('forma_pago', dwc_formapago)
dwc_formapago.settransobject(sqlca)
dwc_formapago.setfilter("tipo_pago<>'CM'")
dwc_formapago.filter()

end event

event itemchanged;call super::itemchanged;CHOOSE CASE DWO.NAME 
	case 'forma_pago'
		if data = g_formas_pago.cargo then
			this.object.banco.protect = 1
			this.object.banco.background.color = f_color_gris()
			choose CASE g_colegio
				case 'COAATB'
					THIS.SETITEM(1,'BANCO','09')
			END CHOOSE
		else
			this.object.banco.protect = 0
			this.object.banco.background.color = f_color_blanco()			
		end if
end choose
end event

type dw_fact from u_dw within w_minutas_devolucion
integer x = 91
integer y = 1244
integer width = 709
integer height = 84
integer taborder = 20
string dataobject = "d_facturar_y_cobrar"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;if data = 'S' then
	dw_2.visible = true
	st_2.visible = true
	st_3.visible = true
	sle_imprimir_copias.visible = true
	sle_imprimir_originales.visible = true
	cb_aumentar.visible = true
	cb_disminuir.visible = true
	cb_aumentar_copias.visible = true
	cb_disminuir_copias.visible = true
else
	dw_2.visible = false
	st_2.visible = false
	st_3.visible = false
	sle_imprimir_copias.visible = false
	sle_imprimir_originales.visible = false
	cb_aumentar.visible = false
	cb_disminuir.visible = false
	cb_aumentar_copias.visible = false
	cb_disminuir_copias.visible = false
end if

end event

type dw_4 from u_dw within w_minutas_devolucion
integer x = 2011
integer width = 393
integer height = 224
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

event itemchanged;call super::itemchanged;double pagado_musaat, musaat, musaat_a_retener, porc_realizado
string id_col, id_fase, id_cliente, cliente_colegiado
boolean restar_musaat=false

dw_1.postevent ("csd_rellenar_descuentos")

//choose case dwo.name
//	case 'avi_fact'
//		id_col = dw_1.getitemstring(1, 'id_colegiado')
//		id_cliente = dw_1.getitemstring(1, 'id_cliente')
//		id_fase = i_w.dw_1.getitemstring(1, 'id_fase')
//		cliente_colegiado = dw_1.getitemstring(1,'cliente_colegiado')
//		porc_realizado = f_redondea ( 100 - dw_1.getitemnumber(1, 'porc_renuncia'))
//		restar_musaat = ( dw_1.getitemstring(1, 'restar_musaat') = 'S')
//		// Modificado David - 28/02/2005
//		// Para Gran Canaria lo pagado se calcula sobre la misma actuaci$$HEX1$$f300$$ENDHEX$$n del expediente
//		if g_colegio <> 'COAATGC' then
//			if data = 'A' then
//				choose case cliente_colegiado
//					case 'co', 'em'
//						pagado_musaat = f_total_cobrado_musaat_colegiado(id_fase, id_col) 
//					case 'cl'
//						pagado_musaat = f_total_cobrado_musaat_cliente(id_fase, id_cliente, id_col) 
//				end choose
//			else
//				choose case cliente_colegiado
//					case 'co', 'em'
//						//pagado_musaat = f_total_cobrado_musaat_colegiado_fact(id_fase, id_col) 
//						pagado_musaat = f_total_cobrado_musaat_col_fact_rd(id_fase, id_col)
//					case 'cl'
//						//pagado_musaat = f_total_cobrado_musaat_cliente_fact(id_fase, id_cliente) 
//						pagado_musaat = f_total_cobrado_musaat_cli_fact_rd(id_fase, id_cliente) 
//				end choose
//			end if
//		else
//			string tipo_act, id_exp
//			tipo_act = idw_1.getitemstring(1, 'fase')
//			id_exp = idw_1.getitemstring(1, 'id_expedi')
//			if data = 'A' then
//				choose case cliente_colegiado
//					case 'co', 'em'
//						pagado_musaat = f_total_cobrado_musaat_colegiado_expedi(id_exp, id_col, tipo_act)
//					case 'cl'
//						pagado_musaat = f_total_cobrado_musaat_cliente_expedi(id_exp, id_col, tipo_act, id_col)
//				end choose
//			else
//				choose case cliente_colegiado
//					case 'co', 'em'
//						//pagado_musaat = f_total_cobrado_musaat_coleg_fact_exp(id_exp, id_col, tipo_act)
//						pagado_musaat = f_tot_cobrado_musaat_col_fact_exp_rd(id_exp, id_col, tipo_act)
//					case 'cl'
//						//pagado_musaat = f_total_cobrado_musaat_cliente_fact_exp(id_exp, id_col, tipo_act)
//						pagado_musaat = f_total_cobrado_musaat_cli_fact_exp_rd(id_exp, id_col, tipo_act)
//				end choose
//			end if
//		end if
//		
//		dw_1.setitem(1, 'pagado_musaat', pagado_musaat)
//		
//		musaat_a_retener = f_redondea( pagado_musaat * (porc_realizado /100))
//		dw_1.setitem(1, 'realizado_musaat', musaat_a_retener)
//
//		if restar_musaat then
//			if pagado_musaat >= musaat_a_retener then
//				musaat = (-1) * f_redondea(( pagado_musaat - musaat_a_retener ))
//			else
//				musaat = (-1) * pagado_musaat
//			end if
//		else
//			musaat = 0
//		end if		
//			
//		musaat = f_redondea(musaat)
//		
//		if f_colegiado_tipopersona(id_col) = 'N' then	
//			// CBU-48 No se debe devolver Musaat a un colegiado de baja en el SRC
//			if not f_tiene_musaat_src(id_col) then 
//				messagebox(g_titulo, "El colegiado actualmente NO se encuentra de alta en Musaat.", stopsign!)
//				musaat = 0
//			end if
//		end if
//		
//		dw_1.setitem(1, 'musaat', musaat)
//end choose

end event

type dw_1 from u_dw within w_minutas_devolucion
event csd_cargar_dddw ( )
event csd_rellenar_descuentos ( )
event csd_tipologia ( )
event csd_calcula_importes_desglose ( )
event csd_calcula_importes_desglose_cc ( )
event csd_comprueba_alta_baja_colegiado ( )
integer x = 73
integer y = 96
integer width = 2414
integer height = 1140
integer taborder = 10
string dataobject = "d_minutas_renuncias"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event csd_cargar_dddw();// Modificado Fernando 5-12-2002
// COLEGIADOS
string id_col_inicial

IF i_dwc_colegiados.Retrieve(i_w.dw_1.GetItemString(1,'id_fase'))<1 THEN
	i_dwc_colegiados.InsertRow(0)
END IF

if i_dwc_colegiados.rowcount() > 0 then
	id_col_inicial = i_dwc_colegiados.getitemstring(1, 'id_col')
	dw_1.setitem(1, 'id_colegiado', id_col_inicial)
	this.post event csd_comprueba_alta_baja_colegiado()
	this.post event csd_tipologia()
end if

i_dwc_colegiados.ResetUpdate()

// CLIENTES
string id_cli_inicial
IF i_dwc_clientes.Retrieve(i_w.dw_1.GetItemString(1,'id_fase'))<1 THEN
	i_dwc_clientes.InsertRow(0)
END IF

if i_dwc_clientes.rowcount() > 0 then
	id_cli_inicial = i_dwc_clientes.getitemstring(1, 'id_cliente')
	dw_1.setitem(1, 'id_cliente', id_cli_inicial)
	this.post event csd_tipologia()
end if

i_dwc_clientes.ResetUpdate()
end event

event csd_rellenar_descuentos();string id_col, id_fase, id_cliente
double cip, musaat, porc_renuncia = 0, porc_realizado = 0, dv
boolean restar_cip = false, restar_musaat = false, restar_dv = false
double total_cip = 0, total_musaat = 0, total_dv = 0
double pagado_cip = 0, pagado_musaat = 0, pagado_dv = 0
double realizado_cip = 0, realizado_musaat = 0
double porc_col = 0, suma_porc = 0, porc_col_real = 0, porc_cli = 0, porc_cli_real = 0
st_musaat_datos st_musaat_datos
int i, retorno, fila_colegiado, fila_cliente
double cip_a_retener = 0 , musaat_a_retener = 0, dv_a_retener, total_pagado_anyo = 0
string cliente_colegiado

dw_1.accepttext()

// $$HEX1$$bf00$$ENDHEX$$Devoluci$$HEX1$$f300$$ENDHEX$$n a cliente o colegiado?
cliente_colegiado = this.getitemstring(1,'cliente_colegiado')

// Recuperamos los datos de entrada
restar_cip = ( this.getitemstring(1, 'restar_cip') = 'S')
restar_musaat = ( this.getitemstring(1, 'restar_musaat') = 'S')
restar_dv = ( this.getitemstring(1, 'restar_dv') = 'S')
id_col = dw_1.getitemstring(1, 'id_colegiado')
id_cliente = dw_1.getitemstring(1, 'id_cliente')
id_fase = i_w.dw_1.getitemstring(1, 'id_fase')
porc_renuncia = this.getitemnumber(1, 'porc_renuncia')
porc_realizado = f_redondea ( 100 - porc_renuncia )

// Validaciones
choose case cliente_colegiado
	case 'cl', 'em'
		if f_es_vacio(id_cliente) then return
		if f_es_vacio(id_col) then return
		// Buscamos al colegiado en la lista
		for i = 1 to i_w.idw_fases_promotores.rowcount()
			if i_w.idw_fases_promotores.getitemstring(i, 'id_cliente') = id_cliente then
				fila_colegiado = i
				exit
			end if
		next
		// Obtenemos el % del porcentaje
		porc_col = i_w.idw_fases_promotores.getitemnumber(fila_colegiado, 'porcen')
		for i = 1 to i_w.idw_fases_promotores.rowcount()
			suma_porc += i_w.idw_fases_promotores.getitemnumber(i, 'porcen')
		next
		porc_col_real = porc_col / suma_porc
		
	case 'co'
		if f_es_vacio(id_col) then return
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
end choose

// Prima Total (actual)
if i_w.idw_fases_estadistica.rowcount() > 0 then
	st_musaat_datos.n_visado = idw_1.getitemstring(1, 'id_fase')
	st_musaat_datos.id_col = id_col
	st_musaat_datos.tipo_act = idw_1.getitemstring(1, 'fase')
	st_musaat_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
	st_musaat_datos.pem = i_w.idw_fases_estadistica.getitemnumber(1, 'pem')
	st_musaat_datos.administracion = i_w.idw_fases_datos_exp.getitemstring(1, 'administracion')
	st_musaat_datos.superficie = i_w.idw_fases_estadistica.getitemnumber(1, 'sup_total')
	st_musaat_datos.volumen = i_w.idw_fases_estadistica.getitemnumber(1, 'volumen')
	st_musaat_datos.porcentaje = porc_col_real * 100
	

	//SCP-193 Para devoluciones anteriores al 4/08/09 con prima negativa debe realizarse con recargo inicial 0.3%
	date f_aux1
	f_aux1 = date(f_musaat_fecha_visado_movimiento(id_fase))
	if f_aux1< date('4/8/2009')  then
		st_musaat_datos.no_aplicar_tarifa_coef_g =true
	else
		st_musaat_datos.no_aplicar_tarifa_coef_g =false
	end if
	// fin scp-193
	
	if f_colegiado_tipopersona(id_col) = 'S' then
		retorno = f_musaat_calcula_prima_sociedad(st_musaat_datos)			
	else
		retorno = f_musaat_calcula_prima(st_musaat_datos)
	end if			
	total_musaat = st_musaat_datos.prima_comp
	total_musaat = f_redondea(total_musaat)
end if



dw_1.setitem(1, 'total_musaat', total_musaat)

// CIP Total (actual)
total_cip = f_cip_contrato_dw(i_w.idw_fases_informes)
total_cip = f_redondea(total_cip * porc_col_real )
total_cip = f_redondea(total_cip)
dw_1.setitem(1, 'total_cip', total_cip)

// DV total (actual)
total_dv = f_dv_contrato_dw(i_w.idw_fases_informes)
total_dv = f_redondea(total_dv * porc_col_real )
total_dv = f_redondea(total_dv)
if g_colegio = 'COAATCC' then total_dv = 0 // ICC-121 Utilizamos los campos de dv para cobrar los gastos de renuncia (5%)
dw_1.setitem(1, 'total_dv', total_dv)

// Modificado David - 28/02/2005
// Para Gran Canaria lo pagado se calcula sobre la misma actuaci$$HEX1$$f300$$ENDHEX$$n del expediente
if g_colegio <> 'COAATGC' then
	choose case cliente_colegiado
		case 'co', 'em'
			// Pagado
			pagado_cip = f_total_cobrado_cip_colegiado(id_fase, id_col)
			if g_colegio = 'COAATGUI' then pagado_cip = f_total_cobrado_cip_colegiado_gui(id_fase, id_col)			
			if dw_4.getitemstring(1, 'avi_fact') = 'A' then
				pagado_musaat = f_total_cobrado_musaat_colegiado(id_fase, id_col)
			else
				//pagado_musaat = f_total_cobrado_musaat_colegiado_fact(id_fase, id_col)
				pagado_musaat = f_total_cobrado_musaat_col_fact_rd(id_fase, id_col)
			end if
			pagado_dv = f_total_cobrado_dv_colegiado(id_fase, id_col) 
	
		case 	'cl'
			// Pagado
			pagado_cip = f_total_cobrado_cip_cliente(id_fase, id_cliente, id_col) 
			if dw_4.getitemstring(1, 'avi_fact') = 'A' then
				pagado_musaat = f_total_cobrado_musaat_cliente(id_fase, id_cliente, id_col) 
			else
				//pagado_musaat = f_total_cobrado_musaat_cliente_fact(id_fase, id_cliente) 
				pagado_musaat = f_total_cobrado_musaat_cli_fact_rd(id_fase, id_cliente)
			end if
			pagado_dv = f_total_cobrado_dv_cliente(id_fase, id_cliente, id_col) 
	end choose
else
	string tipo_act, id_exp
	tipo_act = idw_1.getitemstring(1, 'fase')
	id_exp = idw_1.getitemstring(1, 'id_expedi')
		
	choose case cliente_colegiado
		case 'co', 'em'
			// Pagado
			pagado_cip = f_total_cobrado_cip_colegiado_expediente(id_exp, id_col, tipo_act)
			if dw_4.getitemstring(1, 'avi_fact') = 'A' then
				pagado_musaat = f_total_cobrado_musaat_colegiado_expedi(id_exp, id_col, tipo_act)
			else
				//pagado_musaat = f_total_cobrado_musaat_coleg_fact_exp(id_exp, id_col, tipo_act)
				pagado_musaat = f_tot_cobrado_musaat_col_fact_exp_rd(id_exp, id_col, tipo_act)
			end if
			pagado_dv = f_total_cobrado_dv_colegiado_expediente(id_exp, id_col, tipo_act)
	
		case 	'cl'
			// Pagado
			pagado_cip = f_total_cobrado_cip_cliente_expediente(id_exp, id_cliente, tipo_act, id_col)
			if dw_4.getitemstring(1, 'avi_fact') = 'A' then
				pagado_musaat = f_total_cobrado_musaat_cliente_expedi(id_exp, id_cliente, tipo_act, id_col)
			else
				//pagado_musaat = f_total_cobrado_musaat_cliente_fact_exp(id_exp, id_cliente, tipo_act) 
				pagado_musaat = f_total_cobrado_musaat_cli_fact_exp_rd(id_exp, id_cliente, tipo_act)
			end if
			pagado_dv = f_total_cobrado_dv_cliente_expediente(id_exp, id_cliente, tipo_act, id_col)
	end choose
end if
if g_colegio = 'COAATCC' then pagado_dv = 0 // ICC-121 Utilizamos los campos de dv para cobrar los gastos de renuncia (5%)

dw_1.setitem(1, 'pagado_cip', pagado_cip)
dw_1.setitem(1, 'pagado_musaat', pagado_musaat)
dw_1.setitem(1, 'pagado_dv', pagado_dv)

// Realizado
musaat_a_retener = f_redondea( pagado_musaat * (porc_realizado /100))
cip_a_retener = f_redondea( pagado_cip * (porc_realizado /100))
dv_a_retener = f_redondea( pagado_dv * (porc_realizado /100))
if g_colegio = 'COAATCC' then dv_a_retener = 0 // ICC-121 Utilizamos los campos de dv para cobrar los gastos de renuncia (5%)
dw_1.setitem(1, 'realizado_cip', cip_a_retener)
dw_1.setitem(1, 'realizado_musaat', musaat_a_retener)
dw_1.setitem(1, 'realizado_dv', dv_a_retener)

// A devolver
if restar_cip then
	if pagado_cip >= cip_a_retener then
		cip = (-1) * f_redondea(( pagado_cip - cip_a_retener ))
	else
		cip = (-1) * pagado_cip
	end if
else
	cip = 0
end if

if restar_musaat then
	if pagado_musaat >= musaat_a_retener then
		musaat = (-1) * f_redondea(( pagado_musaat - musaat_a_retener ))
	else
		musaat = (-1) * pagado_musaat
	end if
else
	musaat = 0
end if

//SCP-144 
datetime f_mov_tipo6, f_mov_tipo1
date f_aux, fecha_dev
f_aux = date(f_musaat_fecha_visado_movimiento(id_fase))
fecha_dev = f_fecha_minutas_devolucion(f_aux)
// SCP-144 Modificaciones normas MUSAAT 2009. No se devolver$$HEX2$$e1002000$$ENDHEX$$ninguna cantidad cuando supere la fecha de liquidaci$$HEX1$$f300$$ENDHEX$$n del visado inicial + 4 a$$HEX1$$f100$$ENDHEX$$os + 1 mes. Se generar$$HEX2$$e1002000$$ENDHEX$$movimiento con importe 0
//f_mov_tipo6 = f_ultimo_dia_mes(datetime(today()))
//f_mov_tipo1 = f_ultimo_dia_mes(datetime(date(string(day(f_aux))+"/"+string(month(f_aux)+1)+"/"+string(year(f_aux)+4)), time('00:00:00')))
if fecha_dev <> date('1/1/1900') then
	//if f_mov_tipo6 > f_mov_tipo1 then
	if fecha_dev < today() then
		musaat = 0
		ib_generar_movim = true
		messagebox(g_titulo, "Atenci$$HEX1$$f300$$ENDHEX$$n: Transcurridos cuatro a$$HEX1$$f100$$ENDHEX$$os NO procede realizar devoluci$$HEX1$$f300$$ENDHEX$$n de Musaat")
	else
		// Nuevas normas MUSAAT 2009. En renuncias a visados anteriores a 2009 se devuelve el 80% del porcentaje al que se renuncia (expcepto si es el 100%)
		// 20/01/2009 S$$HEX1$$f300$$ENDHEX$$lo en obras compartidas
		// 10/02/2009 Se considera obra compartida si renuncia a menos de un 100%
		//if f_musaat_fecha_visado_movimiento (id_fase) <  datetime(date('01/01/2009'), time('00:00:00')) and porc_renuncia < 100 and today() > date('01/01/2009') /*and porc_col_real <> 1*/ then
		// CGC-178 Javier Osuna
		// Nuevas normas MUSAAT 2010. En renuncias a visados anteriores a 2010 se devuelve el 80% del porcentaje al que se renuncia (expcepto si es el 100%)
		// 11/06/2010 S$$HEX1$$f300$$ENDHEX$$lo en obras compartidas
		// 11/06/2010 Se considera obra compartida si renuncia a menos de un 100%. 
		///*** 22/12/2010 Se modifica con la aplicaci$$HEX1$$f300$$ENDHEX$$n de los cambios para visados posteriores al 01/01/2011
//		if   f_musaat_fecha_visado_movimiento (id_fase)>  datetime(date('01/01/1900'), time('00:00:00')) and f_musaat_fecha_visado_movimiento (id_fase) <  datetime(today(),now()) and porc_renuncia < 100  /*and porc_col_real <> 1*/ then
//			musaat = f_redondea(( pagado_musaat - musaat_a_retener ) * (-0.8))
//			// CGC-178 Javier Osuna
//			//messagebox(g_titulo, "Atenci$$HEX1$$f300$$ENDHEX$$n: En obras anteriores a 2009 se devuelve un 80% (importe Musaat) del porcentaje de renuncia")
//			messagebox(g_titulo, "Atenci$$HEX1$$f300$$ENDHEX$$n: En obras comenzadas antes del 1 de Enero de 2011 y con porcentaje de renuncia inferior al 100%, se devuelve un 80% (importe Musaat) del porcentaje de renuncia")
//		
//		end if
//		
//		if   f_musaat_fecha_visado_movimiento (id_fase) >  datetime(date('01/01/2011'), time('00:00:00')) then
			if porc_renuncia <> 100 then
				messagebox(g_titulo, "Atenci$$HEX1$$f300$$ENDHEX$$n: A partir del 1 de Enero de 2011, para la obra comenzada,  no se devolver$$HEX2$$e1002000$$ENDHEX$$importe de mussat")
				musaat = 0
				this.setitem(1, 'restar_musaat', 'N')
			else
				// Se devuelve unicamente el 95% de musaat
				musaat = f_redondea(( pagado_musaat - musaat_a_retener ) * (-0.95))
				
				if g_colegio <> 'COAATGC' then
					choose case cliente_colegiado
						case 'co', 'em'
							total_pagado_anyo = f_tot_cobrado_musaat_col_anyo_rd (id_fase, id_col, f_musaat_fecha_visado_movimiento (id_fase))
						case 'cl'
							total_pagado_anyo = f_total_cobrado_musaat_cli_fact_anyo_rd(id_fase, id_col, f_musaat_fecha_visado_movimiento (id_fase))
					end choose		
				else
					choose case cliente_colegiado
						case 'co', 'em'
							total_pagado_anyo =f_tot_cobrado_musaat_col_exp_anyo_rd(id_exp, id_cliente, tipo_act, f_musaat_fecha_visado_movimiento (id_fase))
						case 'cl'
							total_pagado_anyo = f_tot_cobrado_musaat_cli_exp_anyo_rd(id_exp, id_cliente, tipo_act, f_musaat_fecha_visado_movimiento (id_fase))
					end choose	
				end if	
				
				if total_pagado_anyo + musaat < 0 then
					messagebox(g_titulo, "Atenci$$HEX1$$f300$$ENDHEX$$n: (Devoluciones a partir del 1 de Enero de 2011) La cantidad facturada durante el a$$HEX1$$f100$$ENDHEX$$o es de: " + string(total_pagado_anyo) +"(importe Musaat)")
					musaat = - total_pagado_anyo
				else 	
					messagebox(g_titulo, "Atenci$$HEX1$$f300$$ENDHEX$$n: Devoluciones a partir del 1 de Enero de 2011 y con porcentaje de renuncia al 100%,  se devolver$$HEX2$$e1002000$$ENDHEX$$un 95% (importe Musaat) del porcentaje de renuncia")
				end if	
			end if
//		end if
		
	end if
end if

if restar_dv then
	if pagado_dv >= dv_a_retener then
		dv = (-1) * f_redondea(( pagado_dv - dv_a_retener ))
	else
		dv = (-1) * pagado_dv
	end if
else
	dv = 0
end if



// ICC-121 Utilizamos los campos de dv para cobrar los gastos de renuncia (5%)
// ICC-248 Se icluye el iva y musaat en los gastos de renuncias
if g_colegio = 'COAATCC' then 
	double porc_iva_cip
	string t_iva_cip
	
	SELECT t_iva INTO :t_iva_cip FROM csi_articulos_servicios  
WHERE csi_articulos_servicios.codigo = :g_codigos_conceptos.cip and csi_articulos_servicios.colegio = :g_colegio;

	porc_iva_cip = f_dame_porcent_iva(t_iva_cip)
	dv = f_redondea( (cip+ (porc_iva_cip * cip/100)+musaat) * 0.05) * (-1)
end if

// Bonificaci$$HEX1$$f300$$ENDHEX$$n MUSAAT - COAATLE
if lower(this.describe("bonif_musaat.name")) = 'bonif_musaat' then
	if cliente_colegiado = 'co' and LeftA(f_colegiado_residente(id_col),1) = 'R' then
		this.setitem(1, 'bonif_musaat', f_redondea(musaat*g_porc_bonif_musaat*(-1)))
		this.setitem(1, 'porc_bonif', g_porc_bonif_musaat*100)
	end if
end if


cip = f_redondea(cip)
musaat = f_redondea(musaat)
dv = f_redondea(dv)
dw_1.setitem(1, 'cip',cip)

if f_colegiado_tipopersona(id_col) = 'N' then	
	// CBU-48 No se debe devolver Musaat a un colegiado de baja en el SRC
	if not f_tiene_musaat_src(id_col) then 
		messagebox(g_titulo, "El colegiado actualmente NO se encuentra de alta en Musaat.", stopsign!)
		musaat = 0
	end if
end if

dw_1.setitem(1, 'musaat', musaat)
dw_1.setitem(1, 'dv', dv)

if g_colegio = 'COAATCC' then
	string existe
	tipo_act = idw_1.getitemstring(1, 'fase')
	select tipo_act into :existe from fases_renuncias_desglose where tipo_act = :tipo_act ;
	
	if not f_es_vacio(existe) then dw_1.event itemchanged(1, dw_1.object.porc_renuncia, '100')
end if
end event

event csd_tipologia;string id_col
boolean es_sociedad, encontrado = false
int i
string obra_oficial = 'N', t_visado

id_col = dw_1.getitemstring(1, 'id_colegiado')

if f_colegiado_tipopersona(id_col) = 'S' then
	es_sociedad = true		
end if		
// Buscamos el primer movimiento de este colegiado en el contrato
for i = 1 to idw_fases_src.rowcount()
	// No es Sociedad
	if es_sociedad = false  then
		if id_col = idw_fases_src.getitemstring(i, 'id_col') then
			encontrado = true
			obra_oficial  = idw_fases_src.getitemstring(i, 'obra_oficial')
			exit
		end if
	else
	// Si se trata de una sociedad buscaremos el primer colegiado de la sociedad en los movimientos de musaat.
		if f_colegiado_es_asociado(id_col, idw_fases_src.getitemstring(i, 'id_col')) then
			encontrado = true
			obra_oficial  = idw_fases_src.getitemstring(i, 'obra_oficial')
			exit
		end if
	end if
next
if obra_oficial = 'N' then obra_oficial = '0'
if obra_oficial = 'S' then 
	if idw_1.getitemstring(1, 'aplicado_10') = 'S' then
		obra_oficial = '1' // 10%
	else
		obra_oficial = '2' // 100% seguridad
	end if
end if
if f_es_vacio(obra_oficial) then obra_oficial = '0'
// El tipo de visado es de devolucion : 6
t_visado = '6'

this.setitem(1, 'tipo_visado', t_visado)
this.setitem(1, 'tipo_oo', obra_oficial)
end event

event csd_calcula_importes_desglose();if g_colegio = 'COAATCC' THEN 
   event csd_calcula_importes_desglose_cc()
   return
end if

dw_1.accepttext()

string id_col, id_fase, id_cliente
double cip, musaat, porc_renuncia = 0, porc_realizado = 0, dv, porc_realizado_cip = 0, porc_realizado_musaat = 0
boolean restar_cip = false, restar_musaat = false, restar_dv = false
double total_cip = 0, total_musaat = 0, total_dv = 0
double pagado_cip = 0, pagado_musaat = 0, pagado_dv = 0
double realizado_cip = 0, realizado_musaat = 0
double porc_col = 0, suma_porc = 0, porc_col_real = 0, porc_cli = 0, porc_cli_real = 0
st_musaat_datos st_musaat_datos
int i, retorno, fila_colegiado, fila_cliente
double cip_a_retener = 0 , musaat_a_retener = 0, dv_a_retener, total_pagado_anyo
string cliente_colegiado


string tipo_act
double porc_proy_musaat, porc_proy_cip, porc_dir_musaat, porc_dir_cip

tipo_act = idw_1.getitemstring(1, 'fase')

select porc_proy_musaat, porc_proy_cip, porc_dir_musaat, porc_dir_cip
into :porc_proy_musaat, :porc_proy_cip, :porc_dir_musaat, :porc_dir_cip
from fases_renuncias_desglose 
where tipo_act = :tipo_act ;

//// $$HEX1$$bf00$$ENDHEX$$Devoluci$$HEX1$$f300$$ENDHEX$$n a cliente o colegiado?
//cliente_colegiado = this.getitemstring(1,'cliente_colegiado')
//
//// Recuperamos los datos de entrada
//restar_cip = ( this.getitemstring(1, 'restar_cip') = 'S')
//restar_musaat = ( this.getitemstring(1, 'restar_musaat') = 'S')
//restar_dv = ( this.getitemstring(1, 'restar_dv') = 'S')
//id_cliente = dw_1.getitemstring(1, 'id_cliente')
//id_fase = i_w.dw_1.getitemstring(1, 'id_fase')
id_col = dw_1.getitemstring(1, 'id_colegiado')

porc_renuncia = this.getitemnumber(1, 'porc_renuncia')
porc_realizado = f_redondea ( 100 - porc_renuncia )
//
//// Validaciones
//choose case cliente_colegiado
//	case 'cl', 'em'
//		if f_es_vacio(id_cliente) then return
//		if f_es_vacio(id_col) then return
//		// Buscamos al colegiado en la lista
//		for i = 1 to i_w.idw_fases_promotores.rowcount()
//			if i_w.idw_fases_promotores.getitemstring(i, 'id_cliente') = id_cliente then
//				fila_colegiado = i
//				exit
//			end if
//		next
//		// Obtenemos el % del porcentaje
//		porc_col = i_w.idw_fases_promotores.getitemnumber(fila_colegiado, 'porcen')
//		for i = 1 to i_w.idw_fases_promotores.rowcount()
//			suma_porc += i_w.idw_fases_promotores.getitemnumber(i, 'porcen')
//		next
//		porc_col_real = porc_col / suma_porc
//		
//	case 'co'
//		if f_es_vacio(id_col) then return
//		// Buscamos al colegiado en la lista
//		for i = 1 to i_w.idw_fases_colegiados.rowcount()
//			if i_w.idw_fases_colegiados.getitemstring(i, 'id_col') = id_col then
//				fila_colegiado = i
//				exit
//			end if
//		next
//		// Obtenemos el % del porcentaje
//		porc_col = i_w.idw_fases_colegiados.getitemnumber(fila_colegiado, 'porcen_a')
//		for i = 1 to i_w.idw_fases_colegiados.rowcount()
//			suma_porc += i_w.idw_fases_colegiados.getitemnumber(i, 'porcen_a')
//		next
//		porc_col_real = porc_col / suma_porc
//end choose
//
//// Prima Total (actual)
//if i_w.idw_fases_estadistica.rowcount() > 0 then
//	st_musaat_datos.n_visado = idw_1.getitemstring(1, 'id_fase')
//	st_musaat_datos.id_col = id_col
//	st_musaat_datos.tipo_act = idw_1.getitemstring(1, 'fase')
//	st_musaat_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
//	st_musaat_datos.pem = i_w.idw_fases_estadistica.getitemnumber(1, 'pem')
//	st_musaat_datos.administracion = i_w.idw_fases_datos_exp.getitemstring(1, 'administracion')
//	st_musaat_datos.superficie = i_w.idw_fases_estadistica.getitemnumber(1, 'sup_total')
//	st_musaat_datos.volumen = i_w.idw_fases_estadistica.getitemnumber(1, 'volumen')
//	st_musaat_datos.porcentaje = porc_col_real * 100
//	if f_colegiado_tipopersona(id_col) = 'S' then
//		retorno = f_musaat_calcula_prima_sociedad(st_musaat_datos)			
//	else
//		retorno = f_musaat_calcula_prima(st_musaat_datos)
//	end if			
//	total_musaat = st_musaat_datos.prima_comp
//	total_musaat = f_redondea(total_musaat)
//end if
//dw_1.setitem(1, 'total_musaat', total_musaat)
//
//// CIP Total (actual)
//total_cip = f_cip_contrato_dw(i_w.idw_fases_informes)
//total_cip = f_redondea(total_cip * porc_col_real )
//total_cip = f_redondea(total_cip)
//dw_1.setitem(1, 'total_cip', total_cip)
//
//// DV total (actual)
//total_dv = f_dv_contrato_dw(i_w.idw_fases_informes)
//total_dv = f_redondea(total_dv * porc_col_real )
//total_dv = f_redondea(total_dv)
//dw_1.setitem(1, 'total_dv', total_dv)
//
//// Modificado David - 28/02/2005
//// Para Gran Canaria lo pagado se calcula sobre la misma actuaci$$HEX1$$f300$$ENDHEX$$n del expediente
//if g_colegio <> 'COAATGC' then
//	choose case cliente_colegiado
//		case 'co', 'em'
//			// Pagado
//			pagado_cip = f_total_cobrado_cip_colegiado(id_fase, id_col)
//			if dw_4.getitemstring(1, 'avi_fact') = 'A' then
//				pagado_musaat = f_total_cobrado_musaat_colegiado(id_fase, id_col)
//			else
//				pagado_musaat = f_total_cobrado_musaat_colegiado_fact(id_fase, id_col)
//			end if
//			pagado_dv = f_total_cobrado_dv_colegiado(id_fase, id_col) 
//	
//		case 	'cl'
//			// Pagado
//			pagado_cip = f_total_cobrado_cip_cliente(id_fase, id_cliente, id_col) 
//			if dw_4.getitemstring(1, 'avi_fact') = 'A' then
//				pagado_musaat = f_total_cobrado_musaat_cliente(id_fase, id_cliente, id_col) 
//			else
//				pagado_musaat = f_total_cobrado_musaat_cliente_fact(id_fase, id_cliente) 
//			end if
//			pagado_dv = f_total_cobrado_dv_cliente(id_fase, id_cliente, id_col) 
//	end choose
//else
//	string tipo_act, id_exp
//	tipo_act = idw_1.getitemstring(1, 'fase')
//	id_exp = idw_1.getitemstring(1, 'id_expedi')
//		
//	choose case cliente_colegiado
//		case 'co', 'em'
//			// Pagado
//			pagado_cip = f_total_cobrado_cip_colegiado_expediente(id_exp, id_col, tipo_act)
//			if dw_4.getitemstring(1, 'avi_fact') = 'A' then
//				pagado_musaat = f_total_cobrado_musaat_colegiado_expedi(id_exp, id_col, tipo_act)
//			else
//				pagado_musaat = f_total_cobrado_musaat_coleg_fact_exp(id_exp, id_col, tipo_act)
//			end if
//			pagado_dv = f_total_cobrado_dv_colegiado_expediente(id_exp, id_col, tipo_act)
//	
//		case 	'cl'
//			// Pagado
//			pagado_cip = f_total_cobrado_cip_cliente_expediente(id_exp, id_cliente, tipo_act, id_col)
//			if dw_4.getitemstring(1, 'avi_fact') = 'A' then
//				pagado_musaat = f_total_cobrado_musaat_cliente_expedi(id_exp, id_cliente, tipo_act, id_col)
//			else
//				pagado_musaat = f_total_cobrado_musaat_cliente_fact_exp(id_exp, id_cliente, tipo_act) 
//			end if
//			pagado_dv = f_total_cobrado_dv_cliente_expediente(id_exp, id_cliente, tipo_act, id_col)
//	end choose
//end if
//
//dw_1.setitem(1, 'pagado_cip', pagado_cip)
//dw_1.setitem(1, 'pagado_musaat', pagado_musaat)
//dw_1.setitem(1, 'pagado_dv', pagado_dv)

string devol_proy

devol_proy = this.getitemstring(1, 'devol_proy')


// Obtenemos los porcentajes realizados en funci$$HEX1$$f300$$ENDHEX$$n de si se devuelve el proyecto y del porcentaje de renuncia
CHOOSE CASE devol_proy
	CASE 'S'
		if porc_renuncia = 100 then // Si se devuelve el proyecto y el 100 de la direcci$$HEX1$$f300$$ENDHEX$$n, se ha realizado 0
			porc_realizado_cip = porc_realizado
			porc_realizado_musaat = porc_realizado
		else // Si se devuelve el proyecto, el porcentaje realizado ser$$HEX2$$e1002000$$ENDHEX$$el correspondiente a la direcci$$HEX1$$f300$$ENDHEX$$n
			porc_realizado_cip = f_redondea ( porc_realizado * porc_dir_cip / 100 )
			porc_realizado_musaat = f_redondea ( porc_realizado * porc_dir_musaat  / 100 ) 
		end if
				
	CASE 'N'
		if porc_renuncia = 100 then // Si no se devuelve el proyecto y el 100 de la direcci$$HEX1$$f300$$ENDHEX$$n, el porcentaje realizado es el correspondiente a la direcci$$HEX1$$f300$$ENDHEX$$n
			porc_realizado_cip = porc_proy_cip
			porc_realizado_musaat = porc_proy_musaat
		else // Si no se devuelve el proy, el porcentaje realizado ser$$HEX2$$e1002000$$ENDHEX$$la suma del proyecto y el restante de la direcci$$HEX1$$f300$$ENDHEX$$n
			porc_realizado_cip = f_redondea ( porc_realizado * porc_dir_cip / 100 )  + porc_proy_cip 
			porc_realizado_musaat = f_redondea ( porc_realizado * porc_dir_musaat  / 100 ) + porc_proy_musaat 
		end if		
END CHOOSE

restar_cip = dw_1.getitemstring(1, 'restar_cip') = 'S'
restar_musaat = dw_1.getitemstring(1, 'restar_musaat') = 'S'
restar_dv = dw_1.getitemstring(1, 'restar_dv') = 'S'

pagado_cip = dw_1.getitemnumber(1, 'pagado_cip')
pagado_musaat = dw_1.getitemnumber(1, 'pagado_musaat')
pagado_dv = dw_1.getitemnumber(1, 'pagado_dv')

// Realizado
musaat_a_retener = f_redondea( pagado_musaat * (porc_realizado_musaat /100))
cip_a_retener = f_redondea( pagado_cip * (porc_realizado_cip /100))
dv_a_retener = f_redondea( pagado_dv * (porc_realizado /100))
dw_1.setitem(1, 'realizado_cip', cip_a_retener)
dw_1.setitem(1, 'realizado_musaat', musaat_a_retener)
dw_1.setitem(1, 'realizado_dv', dv_a_retener)

// A devolver
if restar_cip then
	if pagado_cip >= cip_a_retener then
		cip = (-1) * f_redondea(( pagado_cip - cip_a_retener ))
	else
		cip = (-1) * pagado_cip
	end if
else
	cip = 0
end if
if restar_musaat then
	if pagado_musaat >= musaat_a_retener then
		musaat = (-1) * f_redondea(( pagado_musaat - musaat_a_retener ))
	else
		musaat = (-1) * pagado_musaat
	end if
else
	musaat = 0
end if
if restar_dv then
	if pagado_dv >= dv_a_retener then
		dv = (-1) * f_redondea(( pagado_dv - dv_a_retener ))
	else
		dv = (-1) * pagado_dv
	end if
else
	dv = 0
end if

//// Bonificaci$$HEX1$$f300$$ENDHEX$$n MUSAAT - COAATLE
//if lower(this.describe("bonif_musaat.name")) = 'bonif_musaat' then
//	if cliente_colegiado = 'co' and LeftA(f_colegiado_residente(id_col),1) = 'R' then
//		this.setitem(1, 'bonif_musaat', f_redondea(musaat*g_porc_bonif_musaat*(-1)))
//		this.setitem(1, 'porc_bonif', g_porc_bonif_musaat*100)
//	end if
//end if

// Nuevas normas MUSAAT 2009. En renuncias a visados anteriores a 2009 se devuelve el 80% del porcentaje al que se renuncia (expcepto si es el 100%)
// 20/01/2009 S$$HEX1$$f300$$ENDHEX$$lo en obras compartidas
// 10/02/2009 Se considera obra compartida si renuncia a menos de un 100%
//Cambio Luis ICN-295
//if f_musaat_fecha_visado_movimiento (id_fase) <  datetime(date('01/01/2009'), time('00:00:00')) and porc_renuncia < 100 and today() > date('01/01/2009') /*and porc_col_real <> 1*/ then
//Segun nuevas normas del musaat de octubre del 2009 el descuento se aplica a todas las obras comenzadas con participaci$$HEX1$$f300$$ENDHEX$$n compartida 
//if   f_musaat_fecha_visado_movimiento (id_fase)>  datetime(date('01/01/1900'), time('00:00:00')) and f_musaat_fecha_visado_movimiento (id_fase) <  datetime(today(),now()) and porc_renuncia < 100  /*and porc_col_real <> 1*/ then
//	musaat = f_redondea(( pagado_musaat - musaat_a_retener ) * (-0.8))
//	// CGC-178 Javier Osuna
//	//messagebox(g_titulo, "Atenci$$HEX1$$f300$$ENDHEX$$n: En obras anteriores a 2009 se devuelve un 80% (importe Musaat) del porcentaje de renuncia")
//	messagebox(g_titulo, "Atenci$$HEX1$$f300$$ENDHEX$$n: En obras comenzadas con porcentaje de renuncia inferior al 100% se devuelve un 80% (importe Musaat) del porcentaje de renuncia")
//end if
//fin cambio

if porc_renuncia <> 100 then
	messagebox(g_titulo, "Atenci$$HEX1$$f300$$ENDHEX$$n: En obras comenzadas a partir del 1 de Enero de 2011 y con la obra comenzada,  no se devolver$$HEX2$$e1002000$$ENDHEX$$del porcentaje de renuncia")
	musaat = 0
	this.setitem(1, 'restar_musaat', 'N')
else
	// Se devuelve unicamente el 95% de musaat
	musaat = f_redondea(( pagado_musaat - musaat_a_retener ) * (-0.95))
				
	choose case cliente_colegiado
	case 'co', 'em'
		total_pagado_anyo = f_tot_cobrado_musaat_col_anyo_rd (id_fase, id_col, f_musaat_fecha_visado_movimiento (id_fase))
	case 'cl'
		total_pagado_anyo = f_total_cobrado_musaat_cli_fact_anyo_rd(id_fase, id_col, f_musaat_fecha_visado_movimiento (id_fase))
	end choose		
				
				
	if total_pagado_anyo + musaat < 0 then
		messagebox(g_titulo, "Atenci$$HEX1$$f300$$ENDHEX$$n: (En obras comenzadas a partir del 1 de Enero de 2011) La cantidad factura durante el a$$HEX1$$f100$$ENDHEX$$o es de: " + string(total_pagado_anyo) +"(importe Musaat)")
		musaat = - total_pagado_anyo
	else 	
		messagebox(g_titulo, "Atenci$$HEX1$$f300$$ENDHEX$$n: En obras comenzadas a partir del 1 de Enero de 2011 y con porcentaje de renuncia al 100%,  se devolver$$HEX2$$e1002000$$ENDHEX$$un 95% (importe Musaat) del porcentaje de renuncia")
	end if	
end if


cip = f_redondea(cip)
musaat = f_redondea(musaat)
dv = f_redondea(dv)
dw_1.setitem(1, 'cip',cip)

if f_colegiado_tipopersona(id_col) = 'N' then	
	// CBU-48 No se debe devolver Musaat a un colegiado de baja en el SRC
	if not f_tiene_musaat_src(id_col) then 
		messagebox(g_titulo, "El colegiado actualmente NO se encuentra de alta en Musaat.", stopsign!)
		musaat = 0
	end if
end if

dw_1.setitem(1, 'musaat', musaat)
dw_1.setitem(1, 'dv', dv)

end event

event csd_calcula_importes_desglose_cc();string id_col, id_fase, id_cliente, t_iva_cip
double cip, musaat, porc_renuncia = 0, porc_realizado = 0, dv, porc_realizado_cip = 0, porc_realizado_musaat = 0
boolean restar_cip = false, restar_musaat = false, restar_dv = false
double total_cip = 0, total_musaat = 0, total_dv = 0
double pagado_cip = 0, pagado_musaat = 0, pagado_dv = 0, porc_iva_cip
double realizado_cip = 0, realizado_musaat = 0
double porc_col = 0, suma_porc = 0, porc_col_real = 0, porc_cli = 0, porc_cli_real = 0
st_musaat_datos st_musaat_datos
int i, retorno, fila_colegiado, fila_cliente
double cip_a_retener = 0 , musaat_a_retener = 0, dv_a_retener
string cliente_colegiado

dw_1.accepttext()

string tipo_act, tarifa
double porc_proy_musaat, porc_proy_cip, porc_dir_musaat, porc_dir_cip

string existe
tipo_act = idw_1.getitemstring(1, 'fase')
select tipo_act into :existe from fases_renuncias_desglose where tipo_act = :tipo_act ;

if f_es_vacio(existe) then 
	event csd_rellenar_descuentos()
	return
end if


tipo_act = idw_1.getitemstring(1, 'fase')
tarifa = idw_honos.getitemstring(1, 'tarifa')

select porc_proy_musaat, porc_proy_cip, porc_dir_musaat, porc_dir_cip
into :porc_proy_musaat, :porc_proy_cip, :porc_dir_musaat, :porc_dir_cip
from fases_renuncias_desglose 
where tipo_act = :tipo_act  and cod_tarifa = :tarifa;

//// $$HEX1$$bf00$$ENDHEX$$Devoluci$$HEX1$$f300$$ENDHEX$$n a cliente o colegiado?
//cliente_colegiado = this.getitemstring(1,'cliente_colegiado')
//
//// Recuperamos los datos de entrada
//restar_cip = ( this.getitemstring(1, 'restar_cip') = 'S')
//restar_musaat = ( this.getitemstring(1, 'restar_musaat') = 'S')
//restar_dv = ( this.getitemstring(1, 'restar_dv') = 'S')
id_col = dw_1.getitemstring(1, 'id_colegiado')
//id_cliente = dw_1.getitemstring(1, 'id_cliente')
//id_fase = i_w.dw_1.getitemstring(1, 'id_fase')
porc_renuncia = this.getitemnumber(1, 'porc_renuncia')
porc_realizado = f_redondea ( 100 - porc_renuncia )

if porc_proy_musaat = 0 and porc_proy_cip = 0 and porc_dir_musaat= 0 and porc_dir_cip = 0 then
	porc_proy_musaat = porc_realizado
	porc_proy_cip = porc_realizado
	porc_dir_musaat = porc_realizado
	porc_dir_cip = porc_realizado
end if


//
//// Validaciones
//choose case cliente_colegiado
//	case 'cl', 'em'
//		if f_es_vacio(id_cliente) then return
//		if f_es_vacio(id_col) then return
//		// Buscamos al colegiado en la lista
//		for i = 1 to i_w.idw_fases_promotores.rowcount()
//			if i_w.idw_fases_promotores.getitemstring(i, 'id_cliente') = id_cliente then
//				fila_colegiado = i
//				exit
//			end if
//		next
//		// Obtenemos el % del porcentaje
//		porc_col = i_w.idw_fases_promotores.getitemnumber(fila_colegiado, 'porcen')
//		for i = 1 to i_w.idw_fases_promotores.rowcount()
//			suma_porc += i_w.idw_fases_promotores.getitemnumber(i, 'porcen')
//		next
//		porc_col_real = porc_col / suma_porc
//		
//	case 'co'
//		if f_es_vacio(id_col) then return
//		// Buscamos al colegiado en la lista
//		for i = 1 to i_w.idw_fases_colegiados.rowcount()
//			if i_w.idw_fases_colegiados.getitemstring(i, 'id_col') = id_col then
//				fila_colegiado = i
//				exit
//			end if
//		next
//		// Obtenemos el % del porcentaje
//		porc_col = i_w.idw_fases_colegiados.getitemnumber(fila_colegiado, 'porcen_a')
//		for i = 1 to i_w.idw_fases_colegiados.rowcount()
//			suma_porc += i_w.idw_fases_colegiados.getitemnumber(i, 'porcen_a')
//		next
//		porc_col_real = porc_col / suma_porc
//end choose
//
//// Prima Total (actual)
//if i_w.idw_fases_estadistica.rowcount() > 0 then
//	st_musaat_datos.n_visado = idw_1.getitemstring(1, 'id_fase')
//	st_musaat_datos.id_col = id_col
//	st_musaat_datos.tipo_act = idw_1.getitemstring(1, 'fase')
//	st_musaat_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
//	st_musaat_datos.pem = i_w.idw_fases_estadistica.getitemnumber(1, 'pem')
//	st_musaat_datos.administracion = i_w.idw_fases_datos_exp.getitemstring(1, 'administracion')
//	st_musaat_datos.superficie = i_w.idw_fases_estadistica.getitemnumber(1, 'sup_total')
//	st_musaat_datos.volumen = i_w.idw_fases_estadistica.getitemnumber(1, 'volumen')
//	st_musaat_datos.porcentaje = porc_col_real * 100
//	if f_colegiado_tipopersona(id_col) = 'S' then
//		retorno = f_musaat_calcula_prima_sociedad(st_musaat_datos)			
//	else
//		retorno = f_musaat_calcula_prima(st_musaat_datos)
//	end if			
//	total_musaat = st_musaat_datos.prima_comp
//	total_musaat = f_redondea(total_musaat)
//end if
//dw_1.setitem(1, 'total_musaat', total_musaat)
//
//// CIP Total (actual)
//total_cip = f_cip_contrato_dw(i_w.idw_fases_informes)
//total_cip = f_redondea(total_cip * porc_col_real )
//total_cip = f_redondea(total_cip)
//dw_1.setitem(1, 'total_cip', total_cip)
//
//// DV total (actual)
//total_dv = f_dv_contrato_dw(i_w.idw_fases_informes)
//total_dv = f_redondea(total_dv * porc_col_real )
//total_dv = f_redondea(total_dv)
//dw_1.setitem(1, 'total_dv', total_dv)
//
//// Modificado David - 28/02/2005
//// Para Gran Canaria lo pagado se calcula sobre la misma actuaci$$HEX1$$f300$$ENDHEX$$n del expediente
//if g_colegio <> 'COAATGC' then
//	choose case cliente_colegiado
//		case 'co', 'em'
//			// Pagado
//			pagado_cip = f_total_cobrado_cip_colegiado(id_fase, id_col)
//			if dw_4.getitemstring(1, 'avi_fact') = 'A' then
//				pagado_musaat = f_total_cobrado_musaat_colegiado(id_fase, id_col)
//			else
//				pagado_musaat = f_total_cobrado_musaat_colegiado_fact(id_fase, id_col)
//			end if
//			pagado_dv = f_total_cobrado_dv_colegiado(id_fase, id_col) 
//	
//		case 	'cl'
//			// Pagado
//			pagado_cip = f_total_cobrado_cip_cliente(id_fase, id_cliente, id_col) 
//			if dw_4.getitemstring(1, 'avi_fact') = 'A' then
//				pagado_musaat = f_total_cobrado_musaat_cliente(id_fase, id_cliente, id_col) 
//			else
//				pagado_musaat = f_total_cobrado_musaat_cliente_fact(id_fase, id_cliente) 
//			end if
//			pagado_dv = f_total_cobrado_dv_cliente(id_fase, id_cliente, id_col) 
//	end choose
//else
//	string tipo_act, id_exp
//	tipo_act = idw_1.getitemstring(1, 'fase')
//	id_exp = idw_1.getitemstring(1, 'id_expedi')
//		
//	choose case cliente_colegiado
//		case 'co', 'em'
//			// Pagado
//			pagado_cip = f_total_cobrado_cip_colegiado_expediente(id_exp, id_col, tipo_act)
//			if dw_4.getitemstring(1, 'avi_fact') = 'A' then
//				pagado_musaat = f_total_cobrado_musaat_colegiado_expedi(id_exp, id_col, tipo_act)
//			else
//				pagado_musaat = f_total_cobrado_musaat_coleg_fact_exp(id_exp, id_col, tipo_act)
//			end if
//			pagado_dv = f_total_cobrado_dv_colegiado_expediente(id_exp, id_col, tipo_act)
//	
//		case 	'cl'
//			// Pagado
//			pagado_cip = f_total_cobrado_cip_cliente_expediente(id_exp, id_cliente, tipo_act, id_col)
//			if dw_4.getitemstring(1, 'avi_fact') = 'A' then
//				pagado_musaat = f_total_cobrado_musaat_cliente_expedi(id_exp, id_cliente, tipo_act, id_col)
//			else
//				pagado_musaat = f_total_cobrado_musaat_cliente_fact_exp(id_exp, id_cliente, tipo_act) 
//			end if
//			pagado_dv = f_total_cobrado_dv_cliente_expediente(id_exp, id_cliente, tipo_act, id_col)
//	end choose
//end if
//
//dw_1.setitem(1, 'pagado_cip', pagado_cip)
//dw_1.setitem(1, 'pagado_musaat', pagado_musaat)
//dw_1.setitem(1, 'pagado_dv', pagado_dv)

string devol_proy

devol_proy = this.getitemstring(1, 'devol_proy')


// Obtenemos los porcentajes realizados en funci$$HEX1$$f300$$ENDHEX$$n de si se devuelve el proyecto y del porcentaje de renuncia
CHOOSE CASE devol_proy
	CASE 'S'
		if porc_renuncia = 100 then // Si se devuelve el proyecto y el 100 de la direcci$$HEX1$$f300$$ENDHEX$$n, se ha realizado 0
			porc_realizado_cip = porc_realizado
			porc_realizado_musaat = porc_realizado
		else // Si se devuelve el proyecto, el porcentaje realizado ser$$HEX2$$e1002000$$ENDHEX$$el correspondiente a la direcci$$HEX1$$f300$$ENDHEX$$n
			porc_realizado_cip = f_redondea ( porc_realizado * porc_dir_cip / 100 )
			porc_realizado_musaat = f_redondea ( porc_realizado * porc_dir_musaat  / 100 ) 
		end if
				
	CASE 'N'
		if porc_renuncia = 100 then // Si no se devuelve el proyecto y el 100 de la direcci$$HEX1$$f300$$ENDHEX$$n, el porcentaje realizado es el correspondiente a la direcci$$HEX1$$f300$$ENDHEX$$n
			porc_realizado_cip = porc_proy_cip
			porc_realizado_musaat = porc_proy_musaat
		else // Si no se devuelve el proy, el porcentaje realizado ser$$HEX2$$e1002000$$ENDHEX$$la suma del proyecto y el restante de la direcci$$HEX1$$f300$$ENDHEX$$n
			porc_realizado_cip = f_redondea ( porc_realizado * porc_dir_cip / 100 )  + porc_proy_cip 
			porc_realizado_musaat = f_redondea ( porc_realizado * porc_dir_musaat  / 100 ) + porc_proy_musaat 
		end if		
END CHOOSE
porc_realizado_musaatcc=f_redondea ( 100-porc_realizado_musaat )
restar_cip = dw_1.getitemstring(1, 'restar_cip') = 'S'
restar_musaat = dw_1.getitemstring(1, 'restar_musaat') = 'S'
restar_dv = dw_1.getitemstring(1, 'restar_dv') = 'S'

pagado_cip = dw_1.getitemnumber(1, 'pagado_cip')
pagado_musaat = dw_1.getitemnumber(1, 'pagado_musaat')
pagado_dv = dw_1.getitemnumber(1, 'pagado_dv')

// Realizado
musaat_a_retener = f_redondea( pagado_musaat * (porc_realizado_musaat /100))
cip_a_retener = f_redondea( pagado_cip * (porc_realizado_cip /100))
dv_a_retener = f_redondea( pagado_dv * (porc_realizado /100))
dw_1.setitem(1, 'realizado_cip', cip_a_retener)
dw_1.setitem(1, 'realizado_musaat', musaat_a_retener)
dw_1.setitem(1, 'realizado_dv', dv_a_retener)

// A devolver
if restar_cip then
	if pagado_cip >= cip_a_retener then
		cip = (-1) * f_redondea(( pagado_cip - cip_a_retener ))
	else
		cip = (-1) * pagado_cip
	end if
else
	cip = 0
end if
if restar_musaat then
	if pagado_musaat >= musaat_a_retener then
		musaat = (-1) * f_redondea(( pagado_musaat - musaat_a_retener ))
	else
		musaat = (-1) * pagado_musaat
	end if
else
	musaat = 0
end if
if restar_dv then
	if pagado_dv >= dv_a_retener then
		dv = (-1) * f_redondea(( pagado_dv - dv_a_retener ))
	else
		dv = (-1) * pagado_dv
	end if
else
	dv = 0
end if

//// Bonificaci$$HEX1$$f300$$ENDHEX$$n MUSAAT - COAATLE
//if lower(this.describe("bonif_musaat.name")) = 'bonif_musaat' then
//	if cliente_colegiado = 'co' and LeftA(f_colegiado_residente(id_col),1) = 'R' then
//		this.setitem(1, 'bonif_musaat', f_redondea(musaat*g_porc_bonif_musaat*(-1)))
//		this.setitem(1, 'porc_bonif', g_porc_bonif_musaat*100)
//	end if
//end if


cip = f_redondea(cip)
musaat = f_redondea(musaat)

SELECT t_iva INTO :t_iva_cip FROM csi_articulos_servicios  
WHERE csi_articulos_servicios.codigo = :g_codigos_conceptos.cip and csi_articulos_servicios.colegio = :g_colegio;

porc_iva_cip = f_dame_porcent_iva(t_iva_cip)
dv = f_redondea( (cip+ (porc_iva_cip * cip/100)+musaat) * 0.05) * (-1)


dw_1.setitem(1, 'cip',cip)


if f_colegiado_tipopersona(id_col) = 'N' then	
	// CBU-48 No se debe devolver Musaat a un colegiado de baja en el SRC
	if not f_tiene_musaat_src(id_col) then 
		messagebox(g_titulo, "El colegiado actualmente NO se encuentra de alta en Musaat.", stopsign!)
		musaat = 0
	end if
end if

dw_1.setitem(1, 'musaat', musaat)
dw_1.setitem(1, 'dv', dv)

end event

event csd_comprueba_alta_baja_colegiado();string ls_alta_baja, ls_id_col

ls_id_col = dw_1.getitemstring(1, 'id_colegiado')

select alta_baja into :ls_alta_baja from colegiados where id_colegiado = :ls_id_col;

if ls_alta_baja <> 'S' then
	
	if messagebox(g_titulo,'El colegiado implicado no esta de alta, $$HEX1$$bf00$$ENDHEX$$Desea continuar?',question!, YesNo!, 2) = 2 then 
	
		dw_1.SetItemStatus(1, 0, Primary!, NotModified!)
		closewithreturn(parent, 'CANCELAR')
	
	end if
	
end if

end event

event constructor;call super::constructor;// Hacemos aqu$$HEX2$$ed002000$$ENDHEX$$la llamada al control de eventos para poder cambiar el dw antes de realizar los dem$$HEX1$$e100$$ENDHEX$$s eventos
st_control_eventos c_evento
c_evento.evento = 'W_MINUTAS_DEVOLUCION'
c_evento.dw = dw_1
f_control_eventos(c_evento)


// Modificado Fernando 5-12-2002
// COLEGIADOS
this.GetChild('id_colegiado',i_dwc_colegiados)
i_dwc_colegiados.settransobject(sqlca)
i_dwc_colegiados.InsertRow (0)
// CLIENTES
this.GetChild('id_cliente',i_dwc_clientes)
i_dwc_clientes.settransobject(sqlca)
i_dwc_clientes.InsertRow (0)

this.post event csd_cargar_dddw()
this.post event csd_rellenar_descuentos()

end event

event itemchanged;double presupuesto_total, porc_renun
int fila_colegiado
			
CHOOSE CASE dwo.name
	CASE 'id_colegiado'
		this.post event csd_comprueba_alta_baja_colegiado()
		this.post event csd_tipologia()		
		this.post event csd_rellenar_descuentos()
		dw_4.setitem(1, 'avi_fact', 'A')
		
	CASE 'porc_renuncia'
		presupuesto_total = i_w.idw_fases_estadistica.getitemnumber(1, 'pem') * double(data) /100
		this.setitem(1, 'presupuesto', f_redondea(presupuesto_total))
		// Si existe el campo para el desglose de trabajos y la actuaci$$HEX1$$f300$$ENDHEX$$n tiene desglose ejecutamos un evento diferente
		if lower(dw_1.describe("devol_proy.name")) = 'devol_proy' then
			if this.getitemstring(1, 'devol_proy') <> 'X' then
				this.trigger event csd_calcula_importes_desglose()
			else
				this.trigger event csd_rellenar_descuentos()
			end if
		else
			this.trigger event csd_rellenar_descuentos()
		end if
		
	CASE 'presupuesto'
		presupuesto_total = i_w.idw_fases_estadistica.getitemnumber(1, 'pem')	
		if isnull(presupuesto_total) then presupuesto_total = 0
		if presupuesto_total <> 0 then porc_renun = double(data) / presupuesto_total * 100
//		messagebox('porc_renun',porc_renun)
		this.setitem(1, 'porc_renuncia', f_redondea(porc_renun))
		this.post event csd_rellenar_descuentos()
		
	CASE 'restar_cip'
		if data = 'N' then this.setitem(1,'cip',0)
		
	CASE 'restar_musaat'
		if data = 'N' then this.setitem(1,'musaat',0)
		
	CASE 'restar_dv'
		if data = 'N' then this.setitem(1,'dv',0)
		
	CASE 'cliente_colegiado'
		// Modificado Fernando 9-12-2002
		// Si la devoluci$$HEX1$$f300$$ENDHEX$$n es a Cliente deben poner cliente y colegiado
		// si se trata de a un colegiado solamente colegiado
		if data = 'cl' then
			this.object.cliente_t.visible = true
			this.object.id_cliente.visible = true
		else
			this.object.cliente_t.visible = false
			this.object.id_cliente.visible = false		
		end if
		
		if data = 'em' then // Empresa
			string id_empresa, id_colegiado
			id_colegiado = this.getitemstring(1,'id_colegiado')

			fila_colegiado = idw_colegiados.find("id_col = '" + id_colegiado +"'", 1, idw_colegiados.rowcount())
			if fila_colegiado <= 0 then 
				messagebox(g_titulo, 'No se encuentra el colegiado')
				return -1
			end if
			id_empresa = idw_colegiados.getitemstring(fila_colegiado, 'id_empresa')

			if f_es_vacio(id_empresa) then
				MessageBox(g_titulo,'Este colegiado no tiene definida ninguna empresa en la pesta$$HEX1$$f100$$ENDHEX$$a de Colegiados.')
				return 2					
//				elseif f_es_vacio(nom_e) or f_es_vacio(nif_e) or f_es_vacio(dom_e) or f_es_vacio(pob_e) or f_es_vacio(prov_e) then
//					MessageBox(g_titulo,'Faltan datos esenciales para facturar a la empresa de este colegiado ( nif ... )'+ cr + 'Debe rellenar estos datos antes en la ficha de la empresa')
//					return 2					
			end if
//			this.setitem(1, 'paga_asalariado', 'N')		
		
		
//			string empresa, nom_e, nif_e, dom_e, pob_e, prov_e
//			
//			select id_empresa into :id_empresa from colegiados where id_colegiado = :id_colegiado;
//			SELECT clientes.apellidos, clientes.nif, clientes.cod_pob, clientes.nombre_via, clientes.cod_prov  
//			INTO :nom_e, :nif_e, :pob_e, :dom_e, :prov_e  
//			FROM clientes  
//			WHERE clientes.id_cliente = :id_empresa   ;
//
//			if f_es_vacio(id_empresa) then
//				MessageBox(g_titulo,'Este colegiado no trabaja para ninguna empresa. Puede definir la empresa para la que trabaja en su ficha colegial.')
//				return 2					
//			elseif f_es_vacio(nom_e) or f_es_vacio(nif_e) or f_es_vacio(dom_e) or f_es_vacio(pob_e) or f_es_vacio(prov_e) then
//				MessageBox(g_titulo,'Faltan datos esenciales para facturar a la empresa de este colegiado ( nif ... )'+ cr + 'Debe rellenar estos datos antes en la ficha de la empresa')
//				return 2					
//			end if
		end if
		
		this.post event csd_rellenar_descuentos()
		dw_4.setitem(1, 'avi_fact', 'A')
		
	CASE 'porc_bonif'		
		// Calculamos la bonificaci$$HEX1$$f300$$ENDHEX$$n de musaat (s$$HEX1$$f300$$ENDHEX$$lo colegiados residentes)
		if LeftA(f_colegiado_residente(this.getitemstring(1, 'id_colegiado')),1) = 'R' then
			this.setitem(1, 'bonif_musaat', f_redondea(double(data)*(-1)*this.getitemnumber(1, 'musaat')/100))
		end if
		
	CASE 'musaat'
		// Calculamos la bonificaci$$HEX1$$f300$$ENDHEX$$n de musaat (s$$HEX1$$f300$$ENDHEX$$lo colegiados residentes)
		if g_colegio = 'COAATLE' and LeftA(f_colegiado_residente(this.getitemstring(1, 'id_colegiado')),1) = 'R' then
			this.setitem(1, 'bonif_musaat', f_redondea(double(data)*(-1)*this.getitemnumber(1, 'porc_bonif')/100))
		end if
		
	CASE 'devol_proy'
		// En funci$$HEX1$$f300$$ENDHEX$$n de si se devuelve el proyecto o no, obtenemos los porcentajes de desglose y calculamos los importes a devolver
		this.post event csd_calcula_importes_desglose()
end choose

end event

event buttonclicked;call super::buttonclicked;double presupuesto_total

st_minutas_devolucion_porcentajes_renuncia st_minutas_devolucion_porcentajes_renuncia

st_minutas_devolucion_porcentajes_renuncia.id_expedi = i_w.dw_1.getitemstring(1, 'id_expedi')
st_minutas_devolucion_porcentajes_renuncia.id_fase = i_w.dw_1.getitemstring(1, 'id_fase')
st_minutas_devolucion_porcentajes_renuncia.id_colegiado = idw_colegiados.getitemstring(1, 'id_col')
//id_col = dw_1.getitemstring(1, 'id_colegiado')


choose case dwo.name 
	case 'desglose_porcentajes'
		openwithparm(w_minutas_devolucion_porcentajes_renuncia, st_minutas_devolucion_porcentajes_renuncia)
		st_minutas_devolucion_porcentajes_renuncia = message.powerobjectparm
		if IsValid(st_minutas_devolucion_porcentajes_renuncia) then
			if not isnull(st_minutas_devolucion_porcentajes_renuncia.porc_obra_ejecutada)  and not isnull(st_minutas_devolucion_porcentajes_renuncia.porc_renuncia_sobre_pte)then
				this.setitem(1, 'porc_obra_ejecutada', st_minutas_devolucion_porcentajes_renuncia.porc_obra_ejecutada)
				this.setitem(1, 'porc_participacion_sobre_ejec', st_minutas_devolucion_porcentajes_renuncia.porc_participacion_sobre_ejec)
				this.setitem(1, 'porc_obra_pendiente', st_minutas_devolucion_porcentajes_renuncia.porc_obra_pendiente)	
				this.setitem(1, 'porc_renuncia_sobre_pendiente', st_minutas_devolucion_porcentajes_renuncia.porc_renuncia_sobre_pte)
				this.setitem(1, 'porc_participacion_sobre_pte', st_minutas_devolucion_porcentajes_renuncia.porc_participacion_sobre_pte)
				this.setitem(1, 'porc_final_sobre_total_obra', st_minutas_devolucion_porcentajes_renuncia.porc_final_sobre_total_obra)		
				this.setitem(1, 'porc_renuncia', st_minutas_devolucion_porcentajes_renuncia.porc_renuncia)
				
				presupuesto_total = i_w.idw_fases_estadistica.getitemnumber(1, 'pem') * double(st_minutas_devolucion_porcentajes_renuncia.porc_renuncia) /100
				this.setitem(1, 'presupuesto', f_redondea(presupuesto_total))
				// Si existe el campo para el desglose de trabajos y la actuaci$$HEX1$$f300$$ENDHEX$$n tiene desglose ejecutamos un evento diferente
				if lower(dw_1.describe("devol_proy.name")) = 'devol_proy' then
					if this.getitemstring(1, 'devol_proy') <> 'X' then
						this.trigger event csd_calcula_importes_desglose()
					else
						this.trigger event csd_rellenar_descuentos()
					end if
				else
					this.trigger event csd_rellenar_descuentos()
				end if
			end if
		end if		
//		messagebox('kk', string(st_minutas_devolucion_porcentajes_renuncia.porc_renuncia))
end choose
end event

event clicked;call super::clicked;datawindowchild dwc

dw_1.GetChild('iva_aplicado',dwc)
dwc.SetTransObject(SQLCA)
dwc.retrieve()
end event

type dw_historico from u_csd_dw within w_minutas_devolucion
boolean visible = false
integer x = 114
integer y = 1492
integer width = 2094
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_historico"
boolean ib_rmbmenu = false
end type

event pfc_insertrow;call super::pfc_insertrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.rowcount(), 'id_modificacion', f_siguiente_numero('MODIFICACIONES', 10))
this.setitem(this.rowcount(), 'id_colegiado', is_id_fase )
this.setitem(this.rowcount(), 'tipo_modulo', '03')
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

event pfc_addrow;call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.rowcount(), 'id_modificacion', f_siguiente_numero('MODIFICACIONES', 10))
this.setitem(this.rowcount(), 'id_colegiado', is_id_fase)

this.setitem(this.rowcount(), 'tipo_modulo', '03')
//donde "n" es un entero que indica la longitud en caracteres del contador
return ancestorreturnvalue
end event

