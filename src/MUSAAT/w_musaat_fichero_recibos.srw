HA$PBExportHeader$w_musaat_fichero_recibos.srw
$PBExportComments$Generador del fichero de recibos
forward
global type w_musaat_fichero_recibos from w_response
end type
type cb_1 from commandbutton within w_musaat_fichero_recibos
end type
type cb_2 from commandbutton within w_musaat_fichero_recibos
end type
type st_1 from statictext within w_musaat_fichero_recibos
end type
type st_proceso from statictext within w_musaat_fichero_recibos
end type
type dw_1 from u_dw within w_musaat_fichero_recibos
end type
type cb_3 from commandbutton within w_musaat_fichero_recibos
end type
type cb_listado from commandbutton within w_musaat_fichero_recibos
end type
type dw_listado from u_dw within w_musaat_fichero_recibos
end type
type dw_concepto from u_dw within w_musaat_fichero_recibos
end type
type dw_consulta from u_dw within w_musaat_fichero_recibos
end type
type cbx_vaciar from checkbox within w_musaat_fichero_recibos
end type
end forward

global type w_musaat_fichero_recibos from w_response
integer width = 2368
integer height = 1908
cb_1 cb_1
cb_2 cb_2
st_1 st_1
st_proceso st_proceso
dw_1 dw_1
cb_3 cb_3
cb_listado cb_listado
dw_listado dw_listado
dw_concepto dw_concepto
dw_consulta dw_consulta
cbx_vaciar cbx_vaciar
end type
global w_musaat_fichero_recibos w_musaat_fichero_recibos

forward prototypes
public function string f_linea_fichero_musaat (long fila, integer hfichero)
end prototypes

public function string f_linea_fichero_musaat (long fila, integer hfichero);// MODIFICADO RICARDO 2005-03-02
//  -> SEG$$HEX1$$da00$$ENDHEX$$N LA PETICI$$HEX1$$d300$$ENDHEX$$N REALIZADA POR ZARAGOZA EN LA QUE ENVI$$HEX2$$d3002000$$ENDHEX$$UN CORREO DE MUSAAT. VER INCIDENCIA 2064
//		- El numero de factura en blanco
//		- El importe con la coma decimal
string linea, n_poliza
double dl_importe
string campo_poliza, campo_importe, sl_importe, n_fact, id_persona, tipo_persona,concepto
int retorno

id_persona = dw_1.getitemstring(fila, 'id_persona')
tipo_persona = dw_1.getitemstring(fila, 'tipo_persona')
concepto = dw_concepto.getitemstring(1, 'concepto')
if tipo_persona <> 'C' then return '-1'
n_fact = dw_1.getitemstring(fila, 'n_fact')
dl_importe = dw_1.getitemnumber(fila, 'total')
sl_importe = string(dl_importe, '#0.00')

n_poliza = f_musaat_numpol_za(id_persona,concepto)

n_fact = space(16)
sl_importe = RightA('000000000000000' + sl_importe, 15)

linea += n_poliza + n_fact + sl_importe

retorno = FileWrite(hFichero, linea)
return string(retorno)
end function

on w_musaat_fichero_recibos.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.st_proceso=create st_proceso
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_listado=create cb_listado
this.dw_listado=create dw_listado
this.dw_concepto=create dw_concepto
this.dw_consulta=create dw_consulta
this.cbx_vaciar=create cbx_vaciar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_proceso
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.cb_listado
this.Control[iCurrent+8]=this.dw_listado
this.Control[iCurrent+9]=this.dw_concepto
this.Control[iCurrent+10]=this.dw_consulta
this.Control[iCurrent+11]=this.cbx_vaciar
end on

on w_musaat_fichero_recibos.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.st_proceso)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_listado)
destroy(this.dw_listado)
destroy(this.dw_concepto)
destroy(this.dw_consulta)
destroy(this.cbx_vaciar)
end on

event open;call super::open;dw_consulta.insertrow(0)

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_musaat_fichero_recibos
string tag = "texto=general.recuperar_pantalla"
integer y = 1404
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_musaat_fichero_recibos
string tag = "texto=general.guardar_pantalla"
end type

type cb_1 from commandbutton within w_musaat_fichero_recibos
string tag = "texto=general.generar_fichero"
integer x = 919
integer y = 1664
integer width = 421
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Generar Fichero"
end type

event clicked;string mensaje
int hFichero, value
string nombrefichero, ruta
long i

SetPointer(HourGlass!)
dw_1.trigger event pfc_accepttext(true) // Modificado Ricardo 2005/02/21

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02

value = GetFileSaveName("Introduzca el nombre del fichero", &
		ruta, nombrefichero, "DOC", &
		"Text Files (*.TXT),*.TXT," )

if value <> 1 then return

hFichero = FileOpen(NombreFichero,Linemode!,write!,shared!,replace!)

st_proceso.visible = true
For i = 1 to dw_1.RowCount()
	st_proceso.text = 'Procesando factura : ' + string(i) + ' de ' + string(dw_1.rowcount())
	f_linea_fichero_musaat(i, hFichero)
Next
fileclose(hFichero)

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02



messagebox(g_titulo, g_idioma.of_getmsg('msg_musaat.proceso_finalizado_exito','Proceso Finalizado con $$HEX1$$e900$$ENDHEX$$xito' ))

end event

type cb_2 from commandbutton within w_musaat_fichero_recibos
string tag = "texto=general.salir"
integer x = 1403
integer y = 1664
integer width = 421
integer height = 100
integer taborder = 30
boolean bringtotop = true
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

type st_1 from statictext within w_musaat_fichero_recibos
string tag = "texto=musaat.especificar_rango_facturas_adecuado"
integer x = 69
integer y = 32
integer width = 1125
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
string text = "Especifique el/los rango/s de facturas adecuado/s:"
boolean focusrectangle = false
end type

type st_proceso from statictext within w_musaat_fichero_recibos
boolean visible = false
integer x = 59
integer y = 1576
integer width = 951
integer height = 52
boolean bringtotop = true
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

type dw_1 from u_dw within w_musaat_fichero_recibos
integer x = 55
integer y = 476
integer width = 2277
integer height = 1060
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_musaat_fichero_recibos_lista_fact"
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)
// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = false
am_dw.m_table.m_debug.enabled = false
end event

event type long pfc_insertrow();call super::pfc_insertrow;if AncestorReturnValue>0 then
	this.setitem(AncestorReturnValue, 'manual', 'S')
end if
return AncestorReturnValue
end event

event type long pfc_addrow();call super::pfc_addrow;if AncestorReturnValue>0 then
	this.setitem(AncestorReturnValue, 'manual', 'S')
end if
return AncestorReturnValue
end event

event type integer pfc_updatespending();call super::pfc_updatespending;return 0
end event

event itemchanged;call super::itemchanged;string id_col
CHOOSE CASE dwo.name
	CASE 'n_col'
		if not isnull(data) then
			id_col=f_colegiado_id_col(data)
			if f_es_vacio(id_col) then 
				post Messagebox(g_titulo, g_idioma.of_getmsg('msg_musaat.colegiado_no_existe','El colegiado no existe'))
				return 2
			end if
			this.SetItem(row,'id_persona',id_col)
			this.setitem(row, 'tipo_persona', 'C')
		else
			// Si data es nulo, ponemos los dos campos a nulos!!
			this.SetItem(row,'id_persona',data)
			this.setitem(row, 'tipo_persona', data)
		end if
		
END CHOOSE
end event

type cb_3 from commandbutton within w_musaat_fichero_recibos
string tag = "texto=general.buscar"
integer x = 1893
integer y = 104
integer width = 434
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Buscar"
end type

event clicked;// Mdificado Ricardo 2005/02/23
string mensaje='', factura_desde, factura_hasta,sql_nuevo
datastore ds_factu
int i

SetPointer(HourGlass!)
dw_consulta.accepttext()
dw_concepto.accepttext()
if cbx_vaciar.checked then dw_1.reset()

for i=1 to dw_consulta.rowcount()
	if f_es_vacio(dw_consulta.GetItemString(i,'factura_desde')) then mensaje += g_idioma.of_getmsg('msg_musaat.introducir_num_factura_desde','Debe introducir el n$$HEX2$$ba002000$$ENDHEX$$factura desde en la fila ') + string(i) + cr
	if f_es_vacio(dw_consulta.GetItemString(i,'factura_hasta')) then mensaje += g_idioma.of_getmsg('msg_musaat.introducir_num_factura_hasta','Debe introducir el n$$HEX2$$ba002000$$ENDHEX$$factura hasta en la fila ') + string(i) + cr
next
// Mostramos los mensajes de error si hay
if mensaje<>'' then
	messagebox(g_titulo, mensaje, StopSign!)
	return
end if

// Creamos el datastore
ds_factu = create datastore
ds_factu.dataobject = 'd_musaat_fichero_recibos_lista_fact'
ds_factu.settransobject(sqlca)

//Recuperamos le select del datawindow de lista
sql_nuevo = ds_factu.describe("datawindow.table.select")
f_sql('csi_lineas_fact_emitidas.articulo', '=', 'concepto', dw_concepto,sql_nuevo, '1', '')
ds_factu.modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")
// Colocamos toda la serie de las facturas
for i = 1 to dw_consulta.rowcount()
	factura_desde = dw_consulta.getitemstring(i, 'factura_desde')
	factura_hasta = dw_consulta.getitemstring(i, 'factura_hasta')
	ds_factu.retrieve(factura_desde, factura_hasta)
	ds_factu.rowscopy(1, ds_factu.rowcount(), Primary!, dw_1, 1, Primary!)
	ds_factu.reset()
next

destroy ds_factu

end event

type cb_listado from commandbutton within w_musaat_fichero_recibos
string tag = "texto=general.listado_previo"
integer x = 434
integer y = 1664
integer width = 421
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Listado Previo"
end type

event clicked;SetPointer(HourGlass!)
dw_1.trigger event pfc_accepttext(true) // Modificado Ricardo 2005/02/21


// Creamos el datastore con el listado a imprimir
dw_1.rowscopy(1, dw_1.rowcount(), Primary!, dw_listado, 1, Primary!)

// imprimimos el listado
dw_listado.print()
end event

type dw_listado from u_dw within w_musaat_fichero_recibos
boolean visible = false
integer x = 69
integer y = 1592
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_musaat_listado_fichero_recibos_fact"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;of_SetPrintPreview(TRUE)
dw_listado.trigger event pfc_printpreview()
end event

type dw_concepto from u_dw within w_musaat_fichero_recibos
integer x = 37
integer y = 364
integer width = 1833
integer height = 80
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_musaat_fichero_recibos_consulta_2"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.insertrow(0)
end event

event buttonclicked;call super::buttonclicked;string nulo
setnull(nulo)

CHOOSE CASE dwo.name
	CASE 'b_borrar'
		this.setitem(row, 'concepto', nulo)
END CHOOSE
end event

type dw_consulta from u_dw within w_musaat_fichero_recibos
integer x = 37
integer y = 104
integer width = 1833
integer height = 264
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_musaat_fichero_recibos_consulta"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

type cbx_vaciar from checkbox within w_musaat_fichero_recibos
string tag = "texto=musaat.vaciar_facts"
integer x = 1915
integer y = 264
integer width = 366
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Vaciar Facts"
boolean checked = true
end type

