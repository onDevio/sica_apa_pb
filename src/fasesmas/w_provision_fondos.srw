HA$PBExportHeader$w_provision_fondos.srw
forward
global type w_provision_fondos from w_response
end type
type cb_1 from commandbutton within w_provision_fondos
end type
type cb_3 from commandbutton within w_provision_fondos
end type
type dw_1 from u_dw within w_provision_fondos
end type
end forward

global type w_provision_fondos from w_response
integer width = 2487
integer height = 884
string title = "Provisi$$HEX1$$f300$$ENDHEX$$n Fondos"
boolean controlmenu = false
event csd_regularizar ( )
cb_1 cb_1
cb_3 cb_3
dw_1 dw_1
end type
global w_provision_fondos w_provision_fondos

type variables
datawindowchild i_dwc_colegiados, i_dwc_clientes
w_fases_detalle i_w
datawindow idw_1, idw_prov_fondos

end variables

on w_provision_fondos.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_3=create cb_3
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.dw_1
end on

on w_provision_fondos.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.dw_1)
end on

event open;call super::open;f_centrar_ventana(this)

dw_1.insertrow(0)

i_w = g_detalle_fases
idw_1 = i_w.dw_1
idw_prov_fondos = i_w.idw_fases_garantias

IF i_dwc_clientes.Retrieve(g_id_fase)<1 THEN
	i_dwc_clientes.InsertRow(0)
END IF

if i_dwc_colegiados.Retrieve(g_id_fase)<1 then
	i_dwc_colegiados.insertrow(0)
end if

IF i_dwc_colegiados.Retrieve(g_id_fase)=1 THEN dw_1.setitem(1, 'colegiado', i_dwc_colegiados.getitemstring(1, 'id_col'))
IF i_dwc_clientes.Retrieve(g_id_fase)=1 THEN dw_1.setitem(1, 'cliente', i_dwc_clientes.getitemstring(1, 'id_cliente'))

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_provision_fondos
integer x = 2533
integer y = 1796
integer width = 46
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_provision_fondos
integer x = 2464
integer y = 1792
integer width = 46
integer taborder = 0
end type

type cb_1 from commandbutton within w_provision_fondos
integer x = 731
integer y = 600
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

event clicked;string col, cli
double fondos
int fila, cuantos

dw_1.accepttext()

col = dw_1.getitemstring(1, 'colegiado')
cli = dw_1.getitemstring(1, 'cliente')
fondos = dw_1.getitemnumber(1, 'prov_fondos')

// Validaciones
if f_es_vacio(col) or f_es_vacio(cli) or fondos=0 then
	messagebox(g_titulo, "Debe seleccionar un colegiado y un cliente e introducir una cantidad mayor que 0")
	return
end if

// Se comprueba que no existe ya una prov.fondos para dicho contrato
SELECT count (*)  
INTO :cuantos  
FROM fases_garantias  
WHERE ( fases_garantias.id_fase = :g_id_fase ) AND  
      ( fases_garantias.id_colegiado = :col ) AND  
      ( fases_garantias.id_cliente = :cli )   ;
		
if cuantos>0 then
	messagebox(g_titulo, "Ya existe una provisi$$HEX1$$f300$$ENDHEX$$n de fondos para este contrato")
	return
end if


// Se imprime la carta
datastore ds_carta
ds_carta = create datastore
ds_carta.dataobject = 'd_carta_peticion_provision_fondos'
ds_carta.settransobject(sqlca)
ds_carta.insertrow(0)

ds_carta.setitem(1, 'colegiado', col)
ds_carta.setitem(1, 'cliente', cli)
ds_carta.setitem(1, 'prov_fondos', fondos)
ds_carta.setitem(1, 'emplazamiento', idw_1.getitemstring(1, 'emplazamiento'))
ds_carta.setitem(1, 'descripcion', idw_1.getitemstring(1, 'descripcion'))
ds_carta.print()

destroy ds_carta

// Insertamos la fila en el tab de Prov. Fondos
fila = idw_prov_fondos.insertrow(0)
idw_prov_fondos.setitem(fila, 'id_fase', g_id_fase)
idw_prov_fondos.setitem(fila, 'id_colegiado', col)
idw_prov_fondos.setitem(fila, 'id_cliente', cli)
idw_prov_fondos.setitem(fila, 'f_in', datetime(today()))
//idw_prov_fondos.setitem(fila, 'f_out', datetime(today()))
idw_prov_fondos.setitem(fila, 'importe', fondos)
idw_prov_fondos.update()
idw_prov_fondos.retrieve(g_id_fase)

close(parent)

end event

type cb_3 from commandbutton within w_provision_fondos
integer x = 1335
integer y = 600
integer width = 402
integer height = 112
integer taborder = 120
boolean bringtotop = true
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

type dw_1 from u_dw within w_provision_fondos
event csd_calcular ( )
integer x = 37
integer y = 32
integer width = 2395
integer height = 500
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_provision_fondos"
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;// Sobreescrito
end event

event constructor;call super::constructor;this.getchild('colegiado',i_dwc_colegiados)
i_dwc_colegiados.settransobject(sqlca)
i_dwc_colegiados.InsertRow (0)

this.getchild('cliente',i_dwc_clientes)
i_dwc_clientes.settransobject(sqlca)
i_dwc_clientes.InsertRow (0)

end event

event itemchanged;call super::itemchanged;double porc, imp, honos

honos = idw_1.getitemnumber(1, 'honorarios')

CHOOSE CASE dwo.name
	CASE 'porcen'
		this.setitem(1, 'prov_fondos', f_redondea(honos*double(data)/100))		
	CASE 'prov_fondos'
		this.setitem(1, 'porcen', f_redondea(double(data)/honos*100))
END CHOOSE

end event

