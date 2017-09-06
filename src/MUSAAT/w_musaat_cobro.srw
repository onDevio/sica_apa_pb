HA$PBExportHeader$w_musaat_cobro.srw
$PBExportComments$Ya no se utiliza, se hace mediante domiciliaciones
forward
global type w_musaat_cobro from w_response
end type
type rb_tasadores from radiobutton within w_musaat_cobro
end type
type rb_accidentes from radiobutton within w_musaat_cobro
end type
type rb_fija from radiobutton within w_musaat_cobro
end type
type st_proceso from statictext within w_musaat_cobro
end type
type st_total from statictext within w_musaat_cobro
end type
type st_registros from statictext within w_musaat_cobro
end type
type cb_aumentar from commandbutton within w_musaat_cobro
end type
type cb_disminuir from commandbutton within w_musaat_cobro
end type
type sle_imprimir_copias from singlelineedit within w_musaat_cobro
end type
type st_3 from statictext within w_musaat_cobro
end type
type st_2 from statictext within w_musaat_cobro
end type
type sle_imprimir_originales from singlelineedit within w_musaat_cobro
end type
type cb_disminuir_copias from commandbutton within w_musaat_cobro
end type
type cb_aumentar_copias from commandbutton within w_musaat_cobro
end type
type dw_2 from u_dw within w_musaat_cobro
end type
type cb_2 from commandbutton within w_musaat_cobro
end type
type cb_1 from commandbutton within w_musaat_cobro
end type
type dw_1 from u_dw within w_musaat_cobro
end type
type gb_1 from groupbox within w_musaat_cobro
end type
end forward

global type w_musaat_cobro from w_response
integer width = 3246
integer height = 2124
string title = "Generaci$$HEX1$$f300$$ENDHEX$$n de Facturas de Prima Fija de MUSAAT"
boolean minbox = true
boolean maxbox = true
windowtype windowtype = popup!
rb_tasadores rb_tasadores
rb_accidentes rb_accidentes
rb_fija rb_fija
st_proceso st_proceso
st_total st_total
st_registros st_registros
cb_aumentar cb_aumentar
cb_disminuir cb_disminuir
sle_imprimir_copias sle_imprimir_copias
st_3 st_3
st_2 st_2
sle_imprimir_originales sle_imprimir_originales
cb_disminuir_copias cb_disminuir_copias
cb_aumentar_copias cb_aumentar_copias
dw_2 dw_2
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_musaat_cobro w_musaat_cobro

type variables
// Valores posibles (FIJA SRC, ACCIDENTES, TASADORES)
string i_seguro = 'FIJA SRC'
end variables

forward prototypes
public function string f_linea_fichero_musaat (long fila, string n_fact, integer hfichero)
end prototypes

public function string f_linea_fichero_musaat (long fila, string n_fact, integer hfichero);string linea, n_poliza
double dl_importe
string campo_poliza, campo_importe, sl_importe
int retorno

choose case i_seguro
	case 'FIJA SRC'
		campo_poliza = 'src_n_poliza'
		campo_importe = 'src_importe'
	case 'ACCIDENTES'
		campo_poliza = 'accidentes_n_poliza'
		campo_importe = 'accidentes_importe'		
	case 'TASADORES'
		campo_poliza = 'tasadores_n_poliza'
		campo_importe = 'tasadores_importe'		
end choose
n_poliza = dw_1.getitemstring(fila, campo_poliza)
dl_importe = dw_1.getitemnumber(fila, campo_importe)
sl_importe = string(dl_importe, '#0.00')
sl_importe = f_reemplaza_cadena(sl_importe, ",", "")
sl_importe = RightA('000000000000000' + sl_importe, 15)
linea += space(2)
linea += f_rellenar_ceros(6, n_poliza)
n_fact = RightA(space(16) + n_fact, 16)
linea += n_fact
linea+= sl_importe

retorno = FileWrite(hFichero, linea)
return string(retorno)
end function

event pfc_postopen;string concepto 
g_dw_lista = dw_1
open(w_musaat_consulta)
dw_1.Retrieve()
dw_2.reset()
dw_2.insertrow(0)
dw_2.SetItem(1,'fecha_pago',DateTime(Today(),Now()))
dw_2.Setitem(1,'forma_pago',g_forma_pago_por_defecto)
dw_2.SetItem(1,'banco',g_banco_por_defecto)
choose case i_seguro
	case 'FIJA SRC'
		concepto = 'PRIMA FIJA MUSAAT '
	case 'ACCIDENTES'
		concepto = 'SEG. ACCI. MUSAAT '		
	case 'TASADORES'
		concepto = 'SEG. TASA. MUSAAT '		
end choose
concepto += f_obtener_mes(datetime(today(), now())) + ' ' + string(year(today()))
dw_2.SetItem(1,'asunto', concepto)

end event

on w_musaat_cobro.create
int iCurrent
call super::create
this.rb_tasadores=create rb_tasadores
this.rb_accidentes=create rb_accidentes
this.rb_fija=create rb_fija
this.st_proceso=create st_proceso
this.st_total=create st_total
this.st_registros=create st_registros
this.cb_aumentar=create cb_aumentar
this.cb_disminuir=create cb_disminuir
this.sle_imprimir_copias=create sle_imprimir_copias
this.st_3=create st_3
this.st_2=create st_2
this.sle_imprimir_originales=create sle_imprimir_originales
this.cb_disminuir_copias=create cb_disminuir_copias
this.cb_aumentar_copias=create cb_aumentar_copias
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_tasadores
this.Control[iCurrent+2]=this.rb_accidentes
this.Control[iCurrent+3]=this.rb_fija
this.Control[iCurrent+4]=this.st_proceso
this.Control[iCurrent+5]=this.st_total
this.Control[iCurrent+6]=this.st_registros
this.Control[iCurrent+7]=this.cb_aumentar
this.Control[iCurrent+8]=this.cb_disminuir
this.Control[iCurrent+9]=this.sle_imprimir_copias
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.sle_imprimir_originales
this.Control[iCurrent+13]=this.cb_disminuir_copias
this.Control[iCurrent+14]=this.cb_aumentar_copias
this.Control[iCurrent+15]=this.dw_2
this.Control[iCurrent+16]=this.cb_2
this.Control[iCurrent+17]=this.cb_1
this.Control[iCurrent+18]=this.dw_1
this.Control[iCurrent+19]=this.gb_1
end on

on w_musaat_cobro.destroy
call super::destroy
destroy(this.rb_tasadores)
destroy(this.rb_accidentes)
destroy(this.rb_fija)
destroy(this.st_proceso)
destroy(this.st_total)
destroy(this.st_registros)
destroy(this.cb_aumentar)
destroy(this.cb_disminuir)
destroy(this.sle_imprimir_copias)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_imprimir_originales)
destroy(this.cb_disminuir_copias)
destroy(this.cb_aumentar_copias)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open;if f_es_vacio(g_codigos_conceptos.musaat_accidentes) then
	rb_accidentes.visible = false
end if

if f_es_vacio(g_codigos_conceptos.musaat_tasadores) then
	rb_tasadores.visible = false
end if
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_musaat_cobro
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_musaat_cobro
string tag = "texto=general.guardar_pantalla"
end type

type rb_tasadores from radiobutton within w_musaat_cobro
string tag = "texto=musaat.seguro_tasadores_musaat"
integer x = 2002
integer y = 68
integer width = 978
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "Seguro de Tasadores de MUSAAT"
borderstyle borderstyle = styleraised!
end type

event clicked;i_seguro = 'TASADORES'
dw_1.dataobject = 'd_musaat_cobro_tasadores'
dw_1.settransobject(sqlca)
parent.event pfc_postopen()
end event

type rb_accidentes from radiobutton within w_musaat_cobro
string tag = "texto=musaat.seguro_accidentes_musaat"
integer x = 869
integer y = 72
integer width = 992
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "Seguro de Accidentes de MUSAAT"
borderstyle borderstyle = styleraised!
end type

event clicked;i_seguro = 'ACCIDENTES'
dw_1.dataobject = 'd_musaat_cobro_accidentes'
dw_1.settransobject(sqlca)
parent.event pfc_postopen()
end event

type rb_fija from radiobutton within w_musaat_cobro
string tag = "texto=musaat.prima_fija_src"
integer x = 165
integer y = 80
integer width = 622
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "Prima Fija del SRC"
boolean checked = true
borderstyle borderstyle = styleraised!
end type

event clicked;i_seguro = 'FIJA SRC'
dw_1.dataobject = 'd_musaat_lista_cobro'
dw_1.settransobject(sqlca)
parent.event pfc_postopen()
end event

type st_proceso from statictext within w_musaat_cobro
boolean visible = false
integer x = 1627
integer y = 1408
integer width = 704
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

type st_total from statictext within w_musaat_cobro
string tag = "texto=musaat.total"
boolean visible = false
integer x = 850
integer y = 1408
integer width = 704
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "total"
boolean focusrectangle = false
end type

type st_registros from statictext within w_musaat_cobro
string tag = "texto=musaat.registros"
boolean visible = false
integer x = 119
integer y = 1408
integer width = 631
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "registros"
boolean focusrectangle = false
end type

type cb_aumentar from commandbutton within w_musaat_cobro
integer x = 2331
integer y = 1660
integer width = 64
integer height = 44
integer taborder = 30
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

type cb_disminuir from commandbutton within w_musaat_cobro
integer x = 2331
integer y = 1708
integer width = 64
integer height = 44
integer taborder = 40
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

type sle_imprimir_copias from singlelineedit within w_musaat_cobro
integer x = 2222
integer y = 1660
integer width = 105
integer height = 84
integer taborder = 20
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

type st_3 from statictext within w_musaat_cobro
string tag = "texto=musaat.n_copias"
integer x = 1952
integer y = 1820
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
boolean focusrectangle = false
end type

type st_2 from statictext within w_musaat_cobro
string tag = "texto=musaat.n_originales"
integer x = 1911
integer y = 1676
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
boolean focusrectangle = false
end type

type sle_imprimir_originales from singlelineedit within w_musaat_cobro
integer x = 2222
integer y = 1804
integer width = 105
integer height = 84
integer taborder = 20
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

type cb_disminuir_copias from commandbutton within w_musaat_cobro
integer x = 2331
integer y = 1852
integer width = 64
integer height = 44
integer taborder = 30
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

type cb_aumentar_copias from commandbutton within w_musaat_cobro
integer x = 2331
integer y = 1804
integer width = 64
integer height = 44
integer taborder = 20
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

type dw_2 from u_dw within w_musaat_cobro
integer x = 87
integer y = 1536
integer width = 1390
integer height = 460
integer taborder = 20
string dataobject = "d_pago_facturas"
boolean vscrollbar = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

datawindowchild dwc_forma_pago
// Capturamos el desplegable
this.getchild ('forma_pago', dwc_forma_pago)
dwc_forma_pago.settransobject (SQLCA)
dwc_forma_pago.setfilter("tipo_pago <>'CM'")
dwc_forma_pago.filter()


end event

type cb_2 from commandbutton within w_musaat_cobro
string tag = "texto=general.cancelar"
integer x = 2679
integer y = 1872
integer width = 434
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;close(parent)

end event

type cb_1 from commandbutton within w_musaat_cobro
string tag = "texto=general.gen_facturas"
integer x = 2679
integer y = 1632
integer width = 434
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Gen. Facturas"
end type

event clicked;string mensaje
string codigo_concepto, campo_importe
int hFichero, value
string nombrefichero, ruta
string n_fact, id_factura

SetPointer(HourGlass!)
dw_2.accepttext()
mensaje = mensaje + f_valida(dw_2,'fecha_pago','NONULO','Debe especificar la fecha de pago.')
mensaje = mensaje + f_valida(dw_2,'forma_pago','NONULO','Debe especificar la forma de pago.')
mensaje = mensaje + f_valida(dw_2,'banco','NONULO','Debe especificar el banco.')

if mensaje<>'' Then
	Messagebox(g_titulo,mensaje,StopSign!)
	return
End if

st_facturas datos_factura
long i

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02


value = GetFileSaveName("Introduzca el nombre del fichero", &
		ruta, nombrefichero, "DOC", &
		"Text Files (*.TXT),*.TXT," )

IF value <> 1 THEN 
	// MODIFICADO RICARDO 04-03-02
	// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
	cambia_directorio.of_changedirectory(directorio)
	destroy cambia_directorio
	// FIN MODIFICADO RICARDO 04-03-02
	return
end if

hFichero = FileOpen(NombreFichero,Linemode!,write!,shared!,replace!)

//Rellenar datos generales de la factura
setnull(datos_factura.id_emisor)
datos_factura.fecha = dw_2.GetItemDateTime(1,'fecha_pago')

datos_factura.formapago = dw_2.GetItemString(1,'forma_pago')
datos_factura.num_originales = integer(sle_imprimir_copias.text)
datos_factura.num_copias = integer(sle_imprimir_originales.text)
datos_factura.es_colegiado = TRUE
datos_factura.banco = dw_2.GetItemString(1,'banco')
datos_factura.pagada = 'S'
datos_factura.asunto = dw_2.GetItemString(1,'asunto') 
datos_factura.descripcion_larga = dw_2.GetItemString(1,'asunto')
datos_factura.serie = g_serie_musaat
datos_factura.t_impuesto = f_csi_articulos_servicios_t_iva(g_codigos_conceptos.premaat, g_empresa)

choose case i_seguro
	case 'FIJA SRC'
		codigo_concepto = g_codigos_conceptos.musaat_fija
		campo_importe = 'src_importe'
	case 'ACCIDENTES'
		codigo_concepto = g_codigos_conceptos.musaat_accidentes		
		campo_importe = 'accidentes_importe'		
	case 'TASADORES'
		codigo_concepto = g_codigos_conceptos.musaat_tasadores
		campo_importe = 'tasadores_importe'		
end choose
datos_factura.cod_articulo = codigo_concepto
datos_factura.descripcion = f_devuelve_desc_concepto(codigo_concepto)

st_proceso.visible = true
For i = 1 to dw_1.RowCount()
	st_proceso.text = 'Generando : ' + string(i) + ' / ' + string(dw_1.rowcount()) + ' Facturas'
	datos_factura.id_receptor = dw_1.GetItemString(i,'id_col')
	datos_factura.base_imponible = dw_1.GetItemNumber(i,campo_importe)
	datos_factura.unidades = 1
	datos_factura.importe_iva = f_aplica_t_iva(datos_factura.base_imponible, datos_factura.t_impuesto)	
	if datos_factura.base_imponible > 0 then 
		id_factura = f_factura(datos_factura)
	end if
	n_fact = f_dame_n_fact_de_id(id_factura)
	f_linea_fichero_musaat(i, n_fact, hFichero)
Next
string  mensaje_domiciliacion = ''
if dw_2.getitemstring(1, 'forma_pago') = g_formas_pago.domiciliacion then
	mensaje_domiciliacion = g_idioma.of_getmsg('msg_musaat.domiciliar_cobros','~rRecuerde domiciliar los cobros de estas facturas dentro del M$$HEX1$$f300$$ENDHEX$$dulo de Cobros.')
end if
fileclose(hFichero)

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02


messagebox(g_titulo, g_idioma.of_getmsg('msg_musaat.proceso_finalizado_exito','Proceso Finalizado con $$HEX1$$e900$$ENDHEX$$xito') + mensaje_domiciliacion)
end event

type dw_1 from u_dw within w_musaat_cobro
integer x = 55
integer y = 180
integer width = 3090
integer height = 1176
integer taborder = 10
string dataobject = "d_musaat_lista_cobro"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)
this.of_SetTransObject(SQLCA)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

// Enable printpreview service
of_SetPrintPreview (true)
end event

event retrieveend;call super::retrieveend;if this.rowcount() <= 0 then return
st_registros.text = 'Total de Facturas : ' + string(dw_1.rowcount())
st_total.text = 'Importe Total : ' + string(f_redondea(dw_1.getitemnumber(dw_1.rowcount(), 'total'))) + ' Euros'

st_registros.visible = true
st_total.visible = true
end event

type gb_1 from groupbox within w_musaat_cobro
string tag = "texto=musaat.tipo_cuota_musaat"
integer x = 64
integer y = 8
integer width = 3063
integer height = 156
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "Tipo de Cuota de MUSAAT"
end type

