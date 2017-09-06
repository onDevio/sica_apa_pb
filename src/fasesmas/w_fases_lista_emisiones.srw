HA$PBExportHeader$w_fases_lista_emisiones.srw
forward
global type w_fases_lista_emisiones from w_popup
end type
type gb_1 from groupbox within w_fases_lista_emisiones
end type
type rb_recibo from radiobutton within w_fases_lista_emisiones
end type
type rb_factura from radiobutton within w_fases_lista_emisiones
end type
type st_3 from statictext within w_fases_lista_emisiones
end type
type cb_disminuir from commandbutton within w_fases_lista_emisiones
end type
type cb_aumentar from commandbutton within w_fases_lista_emisiones
end type
type sle_imprimir_copias from singlelineedit within w_fases_lista_emisiones
end type
type st_2 from statictext within w_fases_lista_emisiones
end type
type cb_disminuir_copias from commandbutton within w_fases_lista_emisiones
end type
type cb_aumentar_copias from commandbutton within w_fases_lista_emisiones
end type
type sle_imprimir_originales from singlelineedit within w_fases_lista_emisiones
end type
type dw_lista_emisiones from u_dw within w_fases_lista_emisiones
end type
type cb_duplicar from commandbutton within w_fases_lista_emisiones
end type
type gb_2 from groupbox within w_fases_lista_emisiones
end type
type cb_grabar from commandbutton within w_fases_lista_emisiones
end type
type dw_lista_emisiones_minutas from u_dw within w_fases_lista_emisiones
end type
type cb_ver from commandbutton within w_fases_lista_emisiones
end type
type gb_3 from groupbox within w_fases_lista_emisiones
end type
type cb_salir from commandbutton within w_fases_lista_emisiones
end type
type dw_recibos from u_dw within w_fases_lista_emisiones
end type
type dw_visualizacion from u_dw within w_fases_lista_emisiones
end type
type dw_desglose_factura from u_dw within w_fases_lista_emisiones
end type
type dw_facturas from u_dw within w_fases_lista_emisiones
end type
end forward

global type w_fases_lista_emisiones from w_popup
integer width = 4731
integer height = 2292
string title = "Lista de Facturas"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event csd_inserta_informes ( )
gb_1 gb_1
rb_recibo rb_recibo
rb_factura rb_factura
st_3 st_3
cb_disminuir cb_disminuir
cb_aumentar cb_aumentar
sle_imprimir_copias sle_imprimir_copias
st_2 st_2
cb_disminuir_copias cb_disminuir_copias
cb_aumentar_copias cb_aumentar_copias
sle_imprimir_originales sle_imprimir_originales
dw_lista_emisiones dw_lista_emisiones
cb_duplicar cb_duplicar
gb_2 gb_2
cb_grabar cb_grabar
dw_lista_emisiones_minutas dw_lista_emisiones_minutas
cb_ver cb_ver
gb_3 gb_3
cb_salir cb_salir
dw_recibos dw_recibos
dw_visualizacion dw_visualizacion
dw_desglose_factura dw_desglose_factura
dw_facturas dw_facturas
end type
global w_fases_lista_emisiones w_fases_lista_emisiones

type variables
u_dw i_dw_facturas,i_dw_recibos
string i_id_fase, i_id_factura
boolean i_fase_abonada = true
integer ilinea1,ilinea2 // la linea seleccionada de los dw de facturas
end variables

event csd_inserta_informes();int i,fila
dw_lista_emisiones_minutas.object.t_1.text = 'Facturas provenientes de Avisos'
for i = 1 to i_dw_facturas.rowcount()
	fila = dw_lista_emisiones_minutas.InsertRow(0)
	dw_lista_emisiones_minutas.SetItem(fila,'id',i_dw_facturas.GetItemString(i,'id_factura'))
	dw_lista_emisiones_minutas.SetItem(fila,'n_factura',i_dw_facturas.GetItemString(i,'n_fact'))
	dw_lista_emisiones_minutas.SetItem(fila,'f_factura',i_dw_facturas.GetItemDatetime(i,'fecha'))
	dw_lista_emisiones_minutas.SetItem(fila,'nombre',i_dw_facturas.GetItemString(i,'nombre'))
	dw_lista_emisiones_minutas.SetItem(fila,'tipo_factura',i_dw_facturas.GetItemString(i,'tipo_factura'))
	dw_lista_emisiones_minutas.SetItem(fila,'b_imponible',i_dw_facturas.GetItemNumber(i,'base_imp'))
	dw_lista_emisiones_minutas.SetItem(fila,'pagado',i_dw_facturas.GetItemString(i,'pagado'))
	dw_lista_emisiones_minutas.SetItem(fila,'f_pago',i_dw_facturas.GetItemDatetime(i,'f_pago'))
	dw_lista_emisiones_minutas.SetItem(fila,'abonado',i_dw_facturas.GetItemString(i,'abonada'))
	dw_lista_emisiones_minutas.SetItem(fila,'id_liquidacion',i_dw_facturas.GetItemString(i,'id_liquidacion'))
	dw_lista_emisiones_minutas.SetItem(fila,'tipo_emision','F')  //Factura
	dw_lista_emisiones_minutas.SetItem(fila,'proforma',i_dw_facturas.GetItemString(i,'proforma'))
next
dw_lista_emisiones_minutas.selectrow(1,false)

dw_lista_emisiones.object.t_1.text = 'Facturas provenientes del Contrato'
for i = 1 to i_dw_recibos.rowcount()
	fila = dw_lista_emisiones.InsertRow(0)
	dw_lista_emisiones.SetItem(fila,'id',i_dw_recibos.GetItemString(i,'id_factura'))
	dw_lista_emisiones.SetItem(fila,'n_factura',i_dw_recibos.GetItemString(i,'n_fact'))
	dw_lista_emisiones.SetItem(fila,'f_factura',i_dw_recibos.GetItemDatetime(i,'fecha'))
	dw_lista_emisiones.SetItem(fila,'nombre',i_dw_recibos.GetItemString(i,'nombre'))
	dw_lista_emisiones.SetItem(fila,'tipo_factura',i_dw_recibos.GetItemString(i,'tipo_factura'))
	dw_lista_emisiones.SetItem(fila,'b_imponible',i_dw_recibos.GetItemNumber(i,'base_imp'))
	dw_lista_emisiones.SetItem(fila,'pagado',i_dw_recibos.GetItemString(i,'pagado'))
	dw_lista_emisiones.SetItem(fila,'f_pago',i_dw_recibos.GetItemDatetime(i,'f_pago'))
	dw_lista_emisiones.SetItem(fila,'id_liquidacion','')
	dw_lista_emisiones.SetItem(fila,'abonado','N')
	dw_lista_emisiones.SetItem(fila,'tipo_emision','R')  //Recibo
	dw_lista_emisiones.SetItem(fila,'proforma',i_dw_recibos.GetItemString(i,'proforma'))
next
dw_lista_emisiones.selectrow(1,false)	
end event

on w_fases_lista_emisiones.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.rb_recibo=create rb_recibo
this.rb_factura=create rb_factura
this.st_3=create st_3
this.cb_disminuir=create cb_disminuir
this.cb_aumentar=create cb_aumentar
this.sle_imprimir_copias=create sle_imprimir_copias
this.st_2=create st_2
this.cb_disminuir_copias=create cb_disminuir_copias
this.cb_aumentar_copias=create cb_aumentar_copias
this.sle_imprimir_originales=create sle_imprimir_originales
this.dw_lista_emisiones=create dw_lista_emisiones
this.cb_duplicar=create cb_duplicar
this.gb_2=create gb_2
this.cb_grabar=create cb_grabar
this.dw_lista_emisiones_minutas=create dw_lista_emisiones_minutas
this.cb_ver=create cb_ver
this.gb_3=create gb_3
this.cb_salir=create cb_salir
this.dw_recibos=create dw_recibos
this.dw_visualizacion=create dw_visualizacion
this.dw_desglose_factura=create dw_desglose_factura
this.dw_facturas=create dw_facturas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.rb_recibo
this.Control[iCurrent+3]=this.rb_factura
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.cb_disminuir
this.Control[iCurrent+6]=this.cb_aumentar
this.Control[iCurrent+7]=this.sle_imprimir_copias
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.cb_disminuir_copias
this.Control[iCurrent+10]=this.cb_aumentar_copias
this.Control[iCurrent+11]=this.sle_imprimir_originales
this.Control[iCurrent+12]=this.dw_lista_emisiones
this.Control[iCurrent+13]=this.cb_duplicar
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.cb_grabar
this.Control[iCurrent+16]=this.dw_lista_emisiones_minutas
this.Control[iCurrent+17]=this.cb_ver
this.Control[iCurrent+18]=this.gb_3
this.Control[iCurrent+19]=this.cb_salir
this.Control[iCurrent+20]=this.dw_recibos
this.Control[iCurrent+21]=this.dw_visualizacion
this.Control[iCurrent+22]=this.dw_desglose_factura
this.Control[iCurrent+23]=this.dw_facturas
end on

on w_fases_lista_emisiones.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.rb_recibo)
destroy(this.rb_factura)
destroy(this.st_3)
destroy(this.cb_disminuir)
destroy(this.cb_aumentar)
destroy(this.sle_imprimir_copias)
destroy(this.st_2)
destroy(this.cb_disminuir_copias)
destroy(this.cb_aumentar_copias)
destroy(this.sle_imprimir_originales)
destroy(this.dw_lista_emisiones)
destroy(this.cb_duplicar)
destroy(this.gb_2)
destroy(this.cb_grabar)
destroy(this.dw_lista_emisiones_minutas)
destroy(this.cb_ver)
destroy(this.gb_3)
destroy(this.cb_salir)
destroy(this.dw_recibos)
destroy(this.dw_visualizacion)
destroy(this.dw_desglose_factura)
destroy(this.dw_facturas)
end on

event open;call super::open;f_centrar_ventana(this)

i_id_fase = Message.StringParm

i_dw_facturas = dw_facturas	
i_dw_recibos = dw_recibos

i_dw_facturas.Retrieve(i_id_fase)
i_dw_recibos.Retrieve(i_id_fase)

this.triggerEvent('csd_inserta_informes')

//dw_lista_emisiones.GroupCalc()

dw_lista_emisiones_minutas.SetFocus()

//dw_lista_emisiones.SetFocus()
if dw_lista_emisiones_minutas.Rowcount()=0 and dw_lista_emisiones.Rowcount()=0 then 
	Close(this)
	messagebox(g_titulo, 'No existen facturas para este contrato')
	return
end if

//dw_lista_emisiones_minutas.SetRow(1)
//dw_lista_emisiones_minutas.SelectRow(1,true)
//dw_lista_emisiones_minutas.Event RowFocusChanged(1)

//Yexaira 29/11/10 Se cambia para que se tenga el focus en la dw de fact
//if dw_lista_emisiones_minutas.rowcount() > 0 then dw_lista_emisiones_minutas.Event RowFocusChanged(1)
if dw_lista_emisiones.rowcount() > 0 then dw_lista_emisiones.Event RowFocusChanged(1)

if g_colegio <> 'COAATTFE' then 
	rb_factura.visible = false
	rb_recibo.visible = false
end if

end event

type gb_1 from groupbox within w_fases_lista_emisiones
integer x = 37
integer y = 1532
integer width = 3049
integer height = 660
integer taborder = 21
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type rb_recibo from radiobutton within w_fases_lista_emisiones
integer x = 4210
integer y = 192
integer width = 338
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Recibo"
end type

type rb_factura from radiobutton within w_fases_lista_emisiones
integer x = 4210
integer y = 104
integer width = 338
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Factura"
boolean checked = true
end type

type st_3 from statictext within w_fases_lista_emisiones
boolean visible = false
integer x = 2976
integer y = 296
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

type cb_disminuir from commandbutton within w_fases_lista_emisiones
boolean visible = false
integer x = 3342
integer y = 316
integer width = 64
integer height = 44
integer taborder = 240
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

type cb_aumentar from commandbutton within w_fases_lista_emisiones
boolean visible = false
integer x = 3342
integer y = 272
integer width = 64
integer height = 44
integer taborder = 250
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

type sle_imprimir_copias from singlelineedit within w_fases_lista_emisiones
boolean visible = false
integer x = 3232
integer y = 276
integer width = 105
integer height = 84
integer taborder = 240
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

type st_2 from statictext within w_fases_lista_emisiones
boolean visible = false
integer x = 2432
integer y = 288
integer width = 325
integer height = 60
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

type cb_disminuir_copias from commandbutton within w_fases_lista_emisiones
boolean visible = false
integer x = 2857
integer y = 316
integer width = 64
integer height = 44
integer taborder = 230
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

type cb_aumentar_copias from commandbutton within w_fases_lista_emisiones
boolean visible = false
integer x = 2857
integer y = 272
integer width = 64
integer height = 44
integer taborder = 220
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

type sle_imprimir_originales from singlelineedit within w_fases_lista_emisiones
boolean visible = false
integer x = 2747
integer y = 276
integer width = 105
integer height = 84
integer taborder = 210
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

type dw_lista_emisiones from u_dw within w_fases_lista_emisiones
integer x = 37
integer y = 480
integer width = 3913
integer height = 704
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_factufa_lista_emisiones"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
end event

event rowfocuschanged;call super::rowfocuschanged;string id,tipo,id_factura,filtro,abonado,pagado, empresa

ilinea2=currentrow

dw_recibos.SetRedraw(FALSE)
dw_facturas.SetRedraw(FALSE)
dw_desglose_factura.SetRedraw(FALSE)

dw_recibos.SetFilter('')
dw_recibos.Filter()
dw_facturas.SetFilter('')
dw_facturas.Filter()

if this.rowcount()=0 then return
id = this.GetItemString(currentrow,'id')
if f_es_vacio(id) then return
i_id_factura=id
tipo = this.GetItemString(currentrow,'tipo_emision')
abonado = this.GetItemString(currentrow,'abonado')
pagado = this.GetItemString(currentrow,'pagado')
empresa = f_obtener_empresa_factura(i_id_factura)


datawindowchild	dwc_bancos
dw_recibos.getchild('banco',dwc_bancos)
dwc_bancos.settransobject(SQLCA)
dwc_bancos.retrieve(empresa)

filtro = "id_factura = '"+id+"'"
if tipo = 'F' then   //Es factura
	dw_recibos.visible=false
	dw_facturas.visible=true
	dw_facturas.SetFilter(filtro)
	dw_facturas.Filter()
	dw_desglose_factura.Retrieve(id)
else 
	dw_recibos.visible=true
	dw_facturas.visible=false
	dw_recibos.SetFilter(filtro)
	dw_recibos.Filter()
	dw_desglose_factura.Retrieve(id)
end if

//dw_recibos.SetRedraw(TRUE)
//dw_facturas.SetRedraw(TRUE)
dw_desglose_factura.SetRedraw(TRUE)	

//if abonado='S' then cb_anular.enabled=false else cb_anular.enabled = true
//if pagado ='S' then cb_pagar.enabled=false else cb_pagar.enabled = true

end event

event losefocus;call super::losefocus;this.SelectRow(ilinea2, FALSE)

end event

event clicked;call super::clicked;if row > 0 then dw_lista_emisiones.Event RowFocusChanged(row)
end event

event doubleclicked;call super::doubleclicked;
// SCP-667 No se abrir$$HEX2$$e1002000$$ENDHEX$$el detalle si pulsa sobre el nuevo bot$$HEX1$$f300$$ENDHEX$$n convertir
if row < 1 OR dwo.name = 'cb_convertir' then return

if f_factura_dame_empresa(this.getitemstring(row,'id')) = g_empresa then
g_dw_lista_facturacion_emitida = this
g_facturacion_emitida_consulta.id_factura = this.getitemstring(row,'id')

else
	messagebox(g_titulo, "No se pueden abrir el detalle de facturas de otra empresa", StopSign!,OK! )
	return
end if
//message.stringparm = "w_facturacion_emitida_detalle"
//w_aplic_frame.event csd_facturacion_emitida_detalle()

//Se abrir$$HEX2$$e1002000$$ENDHEX$$la factura la vuelta en la ventana w_fases_detalle
close(parent)

end event

event buttonclicked;call super::buttonclicked;String lista_id_facturas, ls_id_persona
long retorno

// Se comprueba si la factura es v$$HEX1$$e100$$ENDHEX$$lida para conversi$$HEX1$$f300$$ENDHEX$$n...
IF This.GetItemString(row,'proforma') <> 'S'THEN 
	MessageBox(g_titulo,'No hay documentos v$$HEX1$$e100$$ENDHEX$$lidos para continuar.'+cr+'Se aborta este proceso.', StopSign!)
	RETURN
END IF

// Conversi$$HEX1$$f300$$ENDHEX$$n individual
// Comprobaci$$HEX1$$f300$$ENDHEX$$n con concatenaci$$HEX1$$f300$$ENDHEX$$n de id_factura para el IN
//lista_id_facturas = '0001802863,0001802863,0001802863'
lista_id_facturas = This.GetItemString(row,'id')

i_dw_recibos.SetRedraw(FALSE)

if f_obtener_codigo_tipo_factura(lista_id_facturas) = '03' then 
	ls_id_persona = f_get_id_persona_from_fact(lista_id_facturas)
	if f_colegiado_es_moroso(ls_id_persona) then 
		MessageBox(g_titulo, "El " + g_idioma.of_getmsg('colegiados.colegiado','colegiado') + ' ' + f_colegiado_n_col(ls_id_persona) + ' es ' +  g_idioma.of_getmsg('colegiados.moroso','moroso'),Exclamation!, OK!,1)	
	end if 	
end if 	

OpenWithParm(w_factufa_proforma_a_factura,lista_id_facturas)
retorno=message.doubleparm

//SCP-792 En caso de haber cancelado el proceso no a$$HEX1$$f100$$ENDHEX$$adimos fecha de abono
if retorno <> -1 then
	//SCP-792 A$$HEX1$$f100$$ENDHEX$$adimos fecha de abono al contrato en caso de ser necesario
	f_anyadir_f_abono(i_id_fase)
	f_cambia_estado_si_facturado(i_id_fase)
	//Refrescamos
	if isvalid(g_dw1) then g_fases_consulta.id_fase = g_dw1.getitemstring(1, 'id_fase')
	if isvalid(g_dw1) then g_dw1.dynamic Trigger Event csd_retrieve()
end if

/* SCP-667 Pendiente: refrescar la informaci$$HEX1$$f300$$ENDHEX$$n
i_dw_recibos.Reset()
i_dw_recibos.Retrieve(i_id_fase)
Parent.triggerEvent('csd_inserta_informes')

if row > 0 then dw_lista_emisiones.Event RowFocusChanged(row)*/

///***  Alexis se refrescan los datawindows visibles ***///

dw_lista_emisiones_minutas.reset()
dw_lista_emisiones.reset()

i_dw_facturas.Retrieve(i_id_fase)
i_dw_recibos.Retrieve(i_id_fase)

parent.triggerEvent('csd_inserta_informes')

//dw_lista_emisiones.GroupCalc()

dw_lista_emisiones_minutas.SetFocus()

//dw_lista_emisiones.SetFocus()
if dw_lista_emisiones_minutas.Rowcount()=0 and dw_lista_emisiones.Rowcount()=0 then 
	Close(parent)
	messagebox(g_titulo, 'No existen facturas para este contrato')
	return
end if

//dw_lista_emisiones_minutas.SetRow(1)
//dw_lista_emisiones_minutas.SelectRow(1,true)
//dw_lista_emisiones_minutas.Event RowFocusChanged(1)

if dw_lista_emisiones_minutas.rowcount() > 0 then dw_lista_emisiones_minutas.Event RowFocusChanged(1)

if IsValid(g_detalle_fases) then
	w_fases_detalle w_ventana
	w_ventana=g_detalle_fases
	w_ventana.tab_1.tabpage_13.dw_fases_src.retrieve(i_id_fase)
	w_ventana.tab_1.event csd_poner_titulo()
end if
end event

type cb_duplicar from commandbutton within w_fases_lista_emisiones
integer x = 4187
integer y = 400
integer width = 379
integer height = 104
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
end type

event clicked;n_csd_impresion_formato l_uo_impresion_formato
st_w_factu_e_imprimir l_st_w_factu
string ls_valretorno,ls_valoremail, sl_originales, sl_copias
long ll_originales, ll_copias, i
l_uo_impresion_formato=create n_csd_impresion_formato
st_imprimir_factura_obj_impr st_imp_fact
string id_fase,visared,id_col,dir_email

l_uo_impresion_formato.pdf = g_formato_impresion.pdf
l_uo_impresion_formato.papel = g_formato_impresion.papel
l_uo_impresion_formato.email = g_formato_impresion.email	
l_uo_impresion_formato.masivo=true
l_uo_impresion_formato.destino='F'
l_uo_impresion_formato.referencia2=i_id_fase
	
select fases.e_mail into :visared from fases where fases.id_fase=:i_id_fase;
	
if visared='V' then
	l_uo_impresion_formato.pdf = g_formato_impresion_visared.pdf
	l_uo_impresion_formato.papel = g_formato_impresion_visared.papel
	l_uo_impresion_formato.email = g_formato_impresion_visared.email				
end if

if l_uo_impresion_formato.f_opciones_impresion()<>1 then return

SetPointer(HourGlass!)

st_imp_fact.objeto_nuevo='S'

dw_lista_emisiones_minutas.setredraw(FALSE)
for i=1 to dw_lista_emisiones_minutas.rowcount()
	if dw_lista_emisiones_minutas.getitemstring(i,'check')='S' then
		dw_lista_emisiones_minutas.event rowfocuschanged(i)	
		st_imp_fact.id_factura 								= dw_facturas.GetItemString(1,'id_factura')
		st_imp_fact.tipo 										= dw_facturas.GetItemString(1,'tipo_factura')
		st_imp_fact.copia 									= 'N'
		st_imp_fact.recibo 									= rb_recibo.checked
		st_imp_fact.impresion_formato 					= l_uo_impresion_formato

		//st_imp_fact.impresion_formato.copias 			= ll_originales
		st_imp_fact.impresion_formato.nombre 			= dw_facturas.getitemstring(1,'n_fact')
		st_imp_fact.impresion_formato.asunto_email 	= 'Factura '+ dw_facturas.getitemstring(1,'n_fact')
		//st_imp_fact.impresion_formato.email 			= ls_valoremail
		if dw_facturas.getitemstring(1,'tipo_factura')='03' or dw_facturas.getitemstring(1,'tipo_factura')='02' then
			id_col=dw_facturas.getitemstring(1,'id_persona')
		else
			id_col=dw_facturas.getitemstring(1,'emisor')			
		end if
		
		select email into :dir_email from colegiados where id_colegiado=:id_col;
		st_imp_fact.impresion_formato.direccion_email 			= dir_email		
		f_imprimir_factura_objeto_impr(st_imp_fact)
		
		dw_lista_emisiones_minutas.setitem(i,'check','N')
	end if
next
dw_lista_emisiones_minutas.setredraw(TRUE)

dw_lista_emisiones.setredraw(FALSE)
for i=1 to dw_lista_emisiones.rowcount()
	if dw_lista_emisiones.getitemstring(i,'check')='S' then
		dw_lista_emisiones.event rowfocuschanged(i)
		st_imp_fact.id_factura 								= dw_recibos.GetItemString(1,'id_factura')
		st_imp_fact.tipo 										= dw_recibos.GetItemString(1,'tipo_factura')
		st_imp_fact.copia 									= 'N'
		st_imp_fact.recibo 									= rb_recibo.checked
		st_imp_fact.impresion_formato 					= l_uo_impresion_formato
		//st_imp_fact.impresion_formato.copias 			= ll_originales
		st_imp_fact.impresion_formato.nombre 			= dw_recibos.getitemstring(1,'n_fact')
		st_imp_fact.impresion_formato.asunto_email 	= 'Factura '+ dw_recibos.getitemstring(1,'n_fact')
		//st_imp_fact.impresion_formato.email 			= ls_valoremail
		st_imp_fact.id_cliente_pagador						= dw_recibos.GetItemString(1,'id_cliente_pagador')
		st_imp_fact.paga_empresa							= dw_recibos.GetItemString(1,'paga_empresa')
		st_imp_fact.paga_externo							= dw_recibos.GetItemString(1,'paga_externo')
		st_imp_fact.imprime_cta_banco_col				= dw_recibos.GetItemString(1,'imprime_cta_banco_col')

		if dw_recibos.getitemstring(1,'tipo_factura')='03' or dw_recibos.getitemstring(1,'tipo_factura')='02' then
			id_col=dw_recibos.getitemstring(1,'id_persona')
		else
			id_col=dw_facturas.getitemstring(1,'emisor')			
		end if
		
		select email into :dir_email from colegiados where id_colegiado=:id_col;
		st_imp_fact.impresion_formato.direccion_email 			= dir_email		
		  
		f_imprimir_factura_objeto_impr(st_imp_fact)
			
		dw_lista_emisiones.setitem(i,'check','N')
	end if
next
dw_lista_emisiones.setredraw(TRUE)



SetPointer(Arrow!)

/*n_csd_impresion_formato l_uo_impresion_formato
st_w_factu_e_imprimir l_st_w_factu
string ls_valretorno,ls_valoremail, sl_originales, sl_copias
long ll_originales, ll_copias, i
l_uo_impresion_formato=create n_csd_impresion_formato

SetPointer(HourGlass!)

l_uo_impresion_formato.papel='S'
// Preguntamos los originales y las copias
l_st_w_factu.varias_facturas = true
l_st_w_factu.impresion_formato = l_uo_impresion_formato

openwithparm(w_factu_e_imprimir,l_st_w_factu)

ls_valretorno = Message.stringparm
if ls_valretorno = 'CANCELAR' then 
	return
end if

ls_valoremail = l_uo_impresion_formato.email
ll_originales = l_uo_impresion_formato.copias
ll_copias = long(ls_valretorno)

dw_lista_emisiones_minutas.setredraw(FALSE)
for i=1 to dw_lista_emisiones_minutas.rowcount()
	if dw_lista_emisiones_minutas.getitemstring(i,'check')='S' then
		dw_lista_emisiones_minutas.event rowfocuschanged(i)
		
		st_imprimir_factura_obj_impr st_imp_fact
		st_imp_fact.id_factura 								= dw_facturas.GetItemString(1,'id_factura')
		st_imp_fact.tipo 										= dw_facturas.GetItemString(1,'tipo_factura')
		st_imp_fact.copia 									= 'N'
		st_imp_fact.recibo 									= rb_recibo.checked
		st_imp_fact.impresion_formato 					= l_uo_impresion_formato
		st_imp_fact.impresion_formato.copias 			= ll_originales
		st_imp_fact.impresion_formato.nombre 			= dw_facturas.getitemstring(1,'n_fact')
		st_imp_fact.impresion_formato.asunto_email 	= 'Factura '+ dw_facturas.getitemstring(1,'n_fact')
		st_imp_fact.impresion_formato.email 			= ls_valoremail
		  
		// Imprimimos originales
		if ll_originales > 0 then f_imprimir_factura_objeto_impr(st_imp_fact)
		
		// Imprimimos copias
		st_imp_fact.copia = 'S'
		st_imp_fact.impresion_formato.copias = ll_copias

		// Evitamos que envie el email 2 veces
		st_imp_fact.impresion_formato.email = 'N'
		if ll_copias > 0 then f_imprimir_factura_objeto_impr(st_imp_fact)

		// Imprimimos en pdf
		if st_imp_fact.impresion_formato.pdf='S' then
			st_imp_fact.copia = 'V'
			st_imp_fact.impresion_formato.copias=1
		   f_imprimir_factura_objeto_impr(st_imp_fact)
		end if 

		dw_lista_emisiones_minutas.setitem(i,'check','N')
	end if
next
dw_lista_emisiones_minutas.setredraw(TRUE)

dw_lista_emisiones.setredraw(FALSE)
for i=1 to dw_lista_emisiones.rowcount()
	if dw_lista_emisiones.getitemstring(i,'check')='S' then
		dw_lista_emisiones.event rowfocuschanged(i)
		
		st_imp_fact.id_factura 								= dw_recibos.GetItemString(1,'id_factura')
		st_imp_fact.tipo 										= dw_recibos.GetItemString(1,'tipo_factura')
		st_imp_fact.copia 									= 'N'
		st_imp_fact.recibo 									= rb_recibo.checked
		st_imp_fact.impresion_formato 					= l_uo_impresion_formato
		st_imp_fact.impresion_formato.copias 			= ll_originales
		st_imp_fact.impresion_formato.nombre 			= dw_recibos.getitemstring(1,'n_fact')
		st_imp_fact.impresion_formato.asunto_email 	= 'Factura '+ dw_recibos.getitemstring(1,'n_fact')
		st_imp_fact.impresion_formato.email 			= ls_valoremail
		  
		// Imprimimos originales
		if ll_originales > 0 then f_imprimir_factura_objeto_impr(st_imp_fact)
		
		// Imprimimos copias
		st_imp_fact.copia = 'S'
		st_imp_fact.impresion_formato.copias = ll_copias

		// Evitamos que envie el email 2 veces
		st_imp_fact.impresion_formato.email = 'N'
		if ll_copias > 0 then f_imprimir_factura_objeto_impr(st_imp_fact)

		// Imprimimos en pdf
		st_imp_fact.copia = 'V'
		st_imp_fact.impresion_formato.copias = 1
		f_imprimir_factura_objeto_impr(st_imp_fact)
	
		dw_lista_emisiones.setitem(i,'check','N')
	end if
next
dw_lista_emisiones.setredraw(TRUE)

SetPointer(Arrow!)
*/

end event

type gb_2 from groupbox within w_fases_lista_emisiones
integer width = 3986
integer height = 1216
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
end type

type cb_grabar from commandbutton within w_fases_lista_emisiones
boolean visible = false
integer x = 2514
integer y = 52
integer width = 457
integer height = 76
integer taborder = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Guardar cambios"
end type

type dw_lista_emisiones_minutas from u_dw within w_fases_lista_emisiones
integer x = 37
integer y = 32
integer width = 3913
integer height = 448
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_factufa_lista_emisiones"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
end event

event rowfocuschanged;call super::rowfocuschanged;string id,tipo,id_factura,filtro,abonado,pagado

ilinea1=currentrow

dw_recibos.SetRedraw(FALSE)
dw_facturas.SetRedraw(FALSE)
dw_desglose_factura.SetRedraw(FALSE)

dw_recibos.SetFilter('')
dw_recibos.Filter()
dw_facturas.SetFilter('')
dw_facturas.Filter()

if this.rowcount()=0 then return
id = this.GetItemString(currentrow,'id')
if f_es_vacio(id) then return
i_id_factura=id
tipo = this.GetItemString(currentrow,'tipo_emision')
abonado = this.GetItemString(currentrow,'abonado')
pagado = this.GetItemString(currentrow,'pagado')

filtro = "id_factura = '"+id+"'"
if tipo = 'F' then   //Es factura
	dw_recibos.visible=false
	dw_facturas.visible=true
	dw_desglose_factura.visible = true
	dw_facturas.SetFilter(filtro)
	dw_facturas.Filter()
	dw_desglose_factura.Retrieve(id)
else 
	dw_recibos.visible=true
	dw_facturas.visible=false
	dw_desglose_factura.visible = false
	dw_recibos.SetFilter(filtro)
	dw_recibos.Filter()
	dw_desglose_factura.Retrieve(id)
end if

dw_recibos.SetRedraw(TRUE)
dw_facturas.SetRedraw(TRUE)
dw_desglose_factura.SetRedraw(TRUE)	

//if abonado='S' then cb_anular.enabled=false else cb_anular.enabled = true
//if pagado ='S' then cb_pagar.enabled=false else cb_pagar.enabled = true

end event

event losefocus;call super::losefocus;this.SelectRow(ilinea1, FALSE)

end event

event clicked;call super::clicked;if row > 0 then dw_lista_emisiones_minutas.Event RowFocusChanged(row)
end event

event doubleclicked;call super::doubleclicked;// SCP-667 No se abrir$$HEX2$$e1002000$$ENDHEX$$el detalle si pulsa sobre el nuevo bot$$HEX1$$f300$$ENDHEX$$n convertir
if row < 1 OR dwo.name = 'cb_convertir' then return

if f_factura_dame_empresa(this.getitemstring(row,'id')) = g_empresa then
g_dw_lista_facturacion_emitida = this
g_facturacion_emitida_consulta.id_factura = this.getitemstring(row,'id')
else
	messagebox(g_titulo, "No se pueden abrir el detalle de facturas de otra empresa", StopSign!,OK! )
	return
end if

//message.stringparm = "w_facturacion_emitida_detalle"
//w_aplic_frame.event csd_facturacion_emitida_detalle()

close(parent)
end event

event buttonclicked;call super::buttonclicked;// SCP-677 No aplica para facturas de minutas

end event

type cb_ver from commandbutton within w_fases_lista_emisiones
integer x = 4187
integer y = 272
integer width = 379
integer height = 104
integer taborder = 41
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Previsualizar"
end type

event clicked;string ls_empresa_factura, serie, anyo, ls_plantilla, tipo_dw

if dw_visualizacion.visible=true then
	dw_visualizacion.visible = false
	cb_ver.text = "&Previsualizar"
	
else
	string id_factura, tipo_factura, emisor, dw_plantilla, dw_plantilla_adicional, n_factura,id_cliente_pagador,paga_empresa,paga_externo,imprime_cta_banco_col
	double i
		
	if i_id_factura = '' then return
	
	for i=1 to dw_lista_emisiones_minutas.rowcount()
		if dw_lista_emisiones_minutas.getitemstring(i,'check')='S' then
			dw_lista_emisiones_minutas.event rowfocuschanged(i)
			id_factura		= dw_facturas.GetItemString(1,'id_factura')
			tipo_factura 	= dw_facturas.GetItemString(1,'tipo_factura')
			emisor 			= dw_facturas.GetItemString(1,'emisor')
			n_factura 		= dw_facturas.GetItemString(1,'n_fact')
		end if
	next
	for i=1 to dw_lista_emisiones.rowcount()
		if dw_lista_emisiones.getitemstring(i,'check')='S' then
			dw_lista_emisiones.event rowfocuschanged(i)
			id_factura		= dw_recibos.GetItemString(1,'id_factura')
			tipo_factura 	= dw_recibos.GetItemString(1,'tipo_factura')
			emisor 			= dw_recibos.GetItemString(1,'emisor')
			n_factura 		= dw_recibos.GetItemString(1,'n_fact')
			id_cliente_pagador	= dw_recibos.GetItemString(1,'id_cliente_pagador')
			paga_empresa			= dw_recibos.GetItemString(1,'paga_empresa')
			paga_externo			= dw_recibos.GetItemString(1,'paga_externo')
			imprime_cta_banco_col	= dw_recibos.GetItemString(1,'imprime_cta_banco_col')
		end if
	next
	
	// Parche de Bizkaia
	if g_colegio = 'COAATB' and tipo_factura = g_colegio_cliente then
		if LeftA(n_factura, 5) <> 'CLIEN' then 
			tipo_factura = g_colegio_colegiado
	//		select plantilla into :sl_formato_factura from tipos_facturas where codigo = :tipo;
	//		ds_impresion_facturas.dataobject = sl_formato_factura
	//		ds_impresion_facturas.SetTransObject(SQLCA)
		end if
	end if
	// Fin del parche de Bizkaia
	
	If f_es_vacio(tipo_factura)then
		messagebox(g_titulo, "Seleccione una factura para poder previsualizar", stopsign!, Ok!)
	else
	ls_empresa_factura = f_obtener_empresa_factura(id_factura)
				serie=f_obtener_serie_factura(id_factura)
				anyo=f_obtener_anyo_factura(id_factura)
				f_dame_plantilla_serie_fact(serie,anyo,ls_plantilla , tipo_dw, ls_empresa_factura )
		
		if f_es_vacio(ls_plantilla) then
			// Recuperamos el formato de la base de datos
			select plantilla, plantilla_adicional  into :dw_plantilla, :dw_plantilla_adicional from tipos_facturas where codigo = :tipo_factura;
			if SQLCA.sqlcode <> 0 or f_es_vacio(dw_plantilla) then
				messagebox(g_titulo, 'No se encuentra el formato de factura para el tipo de factura: ' + tipo_factura)
				return
			end if
			 if g_colegio = 'COAATMCA' and LeftA(n_factura, 2) = 'PC'  then  dw_plantilla= 'd_recibos_musaat_cma'
			// Si es recibo tomamos el formato de la plantilla adicional que es la destinada para recibos
			if rb_recibo.checked then dw_plantilla = dw_plantilla_adicional
		else
				
				dw_plantilla= ls_plantilla
		end if
		dw_visualizacion.dataobject=dw_plantilla
		dw_visualizacion.SetTransObject(SQLCA)
		
		st_imprimir_factura_obj_impr st_imp_fact
		st_imp_fact.id_factura = id_factura
		st_imp_fact.id_persona = emisor
		st_imp_fact.tipo = tipo_factura
		st_imp_fact.id_cliente_pagador=id_cliente_pagador
		st_imp_fact.paga_empresa = paga_empresa
		st_imp_fact.paga_externo= paga_externo
		st_imp_fact.imprime_cta_banco_col = imprime_cta_banco_col
		st_imp_fact.copia = 'X'
		st_imp_fact.num_copias = 0
		st_imp_fact.dw = dw_visualizacion
		st_imp_fact.recibo = rb_recibo.checked
		
		n_csd_impresion_formato l_uo_impresion_formato
		l_uo_impresion_formato = create n_csd_impresion_formato
		st_imp_fact.impresion_formato = l_uo_impresion_formato
		
		f_imprimir_factura_objeto_impr(st_imp_fact)
		
		/////*** SCP-873. Alexis. 27/01/2011. Se modifica el logo para los colegios que se aplique multiempresa y disponga de datos en la tabla csi_empresas. ***///
		if g_activa_multiempresa = 'S' then
		st_datos_empresa_emisora lst_datos_empresa_emisora
//		string 	ls_empresa_factura 
//		
//		ls_empresa_factura = f_obtener_empresa_factura(id_factura)
		f_rellena_st_datos_empresa(lst_datos_empresa_emisora , ls_empresa_factura)

			if not f_es_vacio(lst_datos_empresa_emisora.logo_empresa)then
				if lower(dw_visualizacion.describe("p_logo_empresa.name")) = 'p_logo_empresa' then 
					dw_visualizacion.Object.p_logo_empresa.Filename = ".\imagenes\" + lst_datos_empresa_emisora.logo_empresa 
				end if	
			end if	
		end if	
		
		
		cb_ver.text = "Cerrar"
		dw_visualizacion.visible=true
		dw_visualizacion.Object.DataWindow.Print.Preview='YES'
		if dw_visualizacion.inv_printpreview.of_GetEnabled() then
			return dw_visualizacion.inv_printpreview.of_SetZoom(75)
		end if
	end if	
end if	

end event

type gb_3 from groupbox within w_fases_lista_emisiones
integer x = 4023
integer width = 658
integer height = 576
integer taborder = 41
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Opciones de impresi$$HEX1$$f300$$ENDHEX$$n"
end type

type cb_salir from commandbutton within w_fases_lista_emisiones
integer x = 3104
integer y = 2044
integer width = 357
integer height = 104
integer taborder = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
boolean cancel = true
end type

event clicked;close(parent)
end event

type dw_recibos from u_dw within w_fases_lista_emisiones
integer x = 27
integer y = 1264
integer width = 2450
integer height = 268
integer taborder = 11
string dataobject = "d_fases_lista_facturas_fase"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;datawindowchild	dwc_bancos
dw_recibos.getchild('banco',dwc_bancos)
dwc_bancos.settransobject(SQLCA)
dwc_bancos.retrieve(g_empresa)
end event

type dw_visualizacion from u_dw within w_fases_lista_emisiones
boolean visible = false
integer width = 3986
integer height = 2176
integer taborder = 10
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;call super::doubleclicked;this.visible=false
cb_ver.text = "&Previsualizar"
end event

event constructor;call super::constructor;of_SetPrintPreview (true)
end event

type dw_desglose_factura from u_dw within w_fases_lista_emisiones
integer x = 46
integer y = 1576
integer width = 3022
integer height = 596
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_fases_lineas_facturas"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_facturas from u_dw within w_fases_lista_emisiones
integer x = 37
integer y = 1280
integer width = 2450
integer height = 236
integer taborder = 11
string dataobject = "d_fases_lista_facturas_minutas"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

