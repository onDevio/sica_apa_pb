HA$PBExportHeader$w_liquidaciones_detalle.srw
forward
global type w_liquidaciones_detalle from w_detalle
end type
type tab_1 from tab within w_liquidaciones_detalle
end type
type tabpage_2 from userobject within tab_1
end type
type dw_composite from u_dw within tabpage_2
end type
type cb_imprimir_informe from commandbutton within tabpage_2
end type
type dw_informe from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_composite dw_composite
cb_imprimir_informe cb_imprimir_informe
dw_informe dw_informe
end type
type tabpage_1 from userobject within tab_1
end type
type cb_imprimir from commandbutton within tabpage_1
end type
type dw_talon from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_imprimir cb_imprimir
dw_talon dw_talon
end type
type tabpage_3 from userobject within tab_1
end type
type dw_fact_liquidacion from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_fact_liquidacion dw_fact_liquidacion
end type
type tabpage_5 from userobject within tab_1
end type
type dw_otras_facturas_incluidas from u_dw within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_otras_facturas_incluidas dw_otras_facturas_incluidas
end type
type tabpage_4 from userobject within tab_1
end type
type dw_fact_pendientes from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_fact_pendientes dw_fact_pendientes
end type
type tab_1 from tab within w_liquidaciones_detalle
tabpage_2 tabpage_2
tabpage_1 tabpage_1
tabpage_3 tabpage_3
tabpage_5 tabpage_5
tabpage_4 tabpage_4
end type
type dw_lineas from u_dw within w_liquidaciones_detalle
end type
end forward

global type w_liquidaciones_detalle from w_detalle
integer width = 3515
integer height = 1908
string title = "Detalle de Liquidaciones"
event csd_imprimir ( )
event csd_generar_informe ( )
tab_1 tab_1
dw_lineas dw_lineas
end type
global w_liquidaciones_detalle w_liquidaciones_detalle

type variables
u_dw idw_talon, idw_informe, idw_fact_liquidacion,idw_fact_pendientes, idw_otras_facturas_incluidas

end variables

forward prototypes
public function string wf_trae_id_fase (string id_minuta)
end prototypes

event csd_generar_informe();//MODIFICADO Andr$$HEX1$$e900$$ENDHEX$$s 11/10/2005

f_liquidacion_generar_informe(idw_informe,dw_1,1)

idw_informe.groupcalc()
idw_informe.sort()
idw_informe.resetupdate() // Decimos que no nos pida grabar
idw_informe.setredraw(true)

idw_informe.inv_printpreview.of_setzoom(75)
idw_informe.event pfc_printpreview()
idw_informe.setredraw(true)

setpointer(arrow!)
end event

public function string wf_trae_id_fase (string id_minuta);string   ls_id_fase
  
  SELECT fases_minutas.id_fase  
    INTO :ls_id_fase  
    FROM fases_minutas  
   WHERE fases_minutas.id_minuta = :id_minuta   ;
	
return ls_id_fase	 

end function

on w_liquidaciones_detalle.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_lineas=create dw_lineas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_lineas
end on

on w_liquidaciones_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.dw_lineas)
end on

event activate;call super::activate;g_dw_lista  = g_dw_lista_liquidaciones
g_w_lista   = g_lista_liquidaciones
g_w_detalle = g_detalle_liquidaciones
g_lista     = 'w_liquidaciones_lista'
g_detalle   = 'w_liquidaciones_detalle'

end event

event csd_nuevo;call super::csd_nuevo;if AncestorReturnValue>0 then
	dw_1.SetItem(1,'id_liquidacion',f_siguiente_numero('LIQUIDACIONES',10))
	dw_1.SetItem(1,'id_fase', 'LIQMANUAL')
	dw_1.SetItem(1,'fases_liquidaciones_empresa', g_empresa)
//	dw_1.SetItem(1,'f_liquidacion',DateTime(Today(),Now()))
	dw_1.SetItem(1,'f_entrada',DateTime(Today(),Now()))
	dw_1.setitem(1,'tipo','9')
	idw_talon.visible = TRUE
	tab_1.tabpage_1.cb_imprimir.visible = TRUE
	idw_talon.Reset()
	idw_talon.event pfc_addrow()
//	idw_talon.SetItem(1,'f_liquidacion',DateTime(Today(),Now()))
	idw_talon.SetItem(1,'importe',0)
	idw_fact_liquidacion.reset()
	idw_fact_pendientes.reset()
	///***ALEXIS.08/04/2011. SCP-1230. Se oculta de buenas a primeras la pesta$$HEX1$$f100$$ENDHEX$$a del tal$$HEX1$$f300$$ENDHEX$$n ***///
	tab_1.tabpage_1.visible=false
end if


return AncestorReturnValue
end event

event csd_anterior;call super::csd_anterior;if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then
	g_id_liquidacion = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'id_liquidacion')
	dw_1.event csd_retrieve()
end if

end event

event csd_primero;call super::csd_primero;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(1)
	g_dw_lista.scrolltorow(1)
	g_id_liquidacion = g_dw_lista.getitemstring(1,"id_liquidacion")
	
	dw_1.event csd_retrieve()
end if

end event

event csd_ultimo;call super::csd_ultimo;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(g_dw_lista.rowcount())
	g_dw_lista.scrolltorow(g_dw_lista.rowcount())
	g_id_liquidacion = g_dw_lista.getitemstring(g_dw_lista.rowcount(),"id_liquidacion")
	
	dw_1.event csd_retrieve()
end if
end event

event csd_siguiente;call super::csd_siguiente;if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then
	g_id_liquidacion = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'id_liquidacion')
	dw_1.event csd_retrieve()
end if
end event

event open;call super::open;idw_informe = tab_1.tabpage_2.dw_informe
idw_informe.dataobject = g_hoja_liquidacion
if g_activa_multiempresa = 'S' then f_logo_empresa(g_empresa ,idw_informe, '005') 

idw_informe.of_setprintpreview(TRUE)
idw_informe.event pfc_printpreview()

idw_talon = tab_1.tabpage_1.dw_talon
idw_talon.dataobject = g_informe_talon


if g_informe_talon='d_talon_ll' then	
	
	idw_talon.dataobject ='d_liquidacion_talon_lleida'	
	tab_1.tabpage_1.visible=false
end if

idw_talon.SetTransObject(SQLCA)
idw_talon.of_setprintpreview(TRUE)
idw_talon.event pfc_printpreview()

idw_fact_liquidacion = tab_1.tabpage_3.dw_fact_liquidacion
idw_fact_pendientes = tab_1.tabpage_4.dw_fact_pendientes
idw_otras_facturas_incluidas = tab_1.tabpage_5.dw_otras_facturas_incluidas


f_enlaza_dw(dw_1,idw_talon,'id_liquidacion','id_liquidacion')
f_enlaza_dw(dw_1,idw_otras_facturas_incluidas,'id_liquidacion','id_liquidacion')

inv_resize.of_Register (idw_talon, "ScaleToBottom")
inv_resize.of_Register (tab_1, "ScaleToRight&Bottom")
inv_resize.of_Register (tab_1.tabpage_1.cb_imprimir,"FixedToBottom")
inv_resize.of_Register (idw_informe, "ScaleToBottom")
inv_resize.of_Register (tab_1.tabpage_2.cb_imprimir_informe,"FixedToBottom")
inv_resize.of_Register (idw_fact_liquidacion, "ScaleToBottom")
inv_resize.of_Register (idw_fact_pendientes, "ScaleToBottom")
inv_resize.of_Register (idw_otras_facturas_incluidas, "ScaleToBottom")
idw_talon.inv_printpreview.of_setzoom(75)
idw_informe.inv_printpreview.of_setzoom(75)




end event

event pfc_preupdate;call super::pfc_preupdate;string mensaje , estado
datetime f_liquidacion
boolean encontrado
encontrado = false
estado = ''
mensaje = ''

if f_puedo_escribir(g_usuario,'0000000033')=-1 then return -1

mensaje = mensaje + f_valida(dw_1,'id_colegiado','NOVACIO','No se ha especificado el colegiado.')
mensaje = mensaje + f_valida(dw_1,'forma_pago','NOVACIO','No se ha especificado la forma de pago.')

//Agregar la validacion de este campo.

if mensaje<>'' Then
	Messagebox(g_titulo,mensaje,StopSign!)
	return -1
End if
estado =  dw_1.getitemstring(dw_1.getrow(), 'estado')
f_liquidacion =  dw_1.getitemdatetime(dw_1.getrow(),'f_liquidacion')
if  estado = 'L' and f_es_vacio(string(f_liquidacion))then 
		encontrado = true
end if 

if encontrado then
	Messagebox(g_titulo,'No es posible guardar la liquidaci$$HEX1$$f300$$ENDHEX$$n liquidada mientras no tenga fecha de liquidaci$$HEX1$$f300$$ENDHEX$$n', StopSign!)
	return -1
end if 
	
return 1

end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_liquidaciones_detalle
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_liquidaciones_detalle
integer taborder = 20
end type

type cb_nuevo from w_detalle`cb_nuevo within w_liquidaciones_detalle
integer taborder = 50
end type

type cb_ayuda from w_detalle`cb_ayuda within w_liquidaciones_detalle
integer taborder = 90
end type

type cb_grabar from w_detalle`cb_grabar within w_liquidaciones_detalle
integer taborder = 60
end type

type cb_ant from w_detalle`cb_ant within w_liquidaciones_detalle
integer taborder = 70
end type

type cb_sig from w_detalle`cb_sig within w_liquidaciones_detalle
integer taborder = 80
end type

type dw_1 from w_detalle`dw_1 within w_liquidaciones_detalle
integer x = 37
integer y = 0
integer width = 3401
integer height = 704
integer taborder = 30
string dataobject = "d_liquidacion_detalle"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_1::csd_retrieve;call super::csd_retrieve;int    retorno
double i
string id_minuta,n_aviso

if f_es_vacio(g_id_liquidacion) then return
retorno = parent.event closequery()
if retorno = 1 then return

this.retrieve(g_id_liquidacion)

g_id_liquidacion = ''

if this.GetItemString(1,'forma_pago') <> 'TA' then 
	idw_talon.visible = FALSE
	tab_1.tabpage_1.cb_imprimir.visible = FALSE
else
	idw_talon.visible = TRUE
	tab_1.tabpage_1.cb_imprimir.visible = TRUE
end if


id_minuta=this.GetItemString(this.GetRow(),'id_fase')
if not(f_es_vacio(id_minuta)) then
	select n_aviso into :n_aviso from fases_minutas where id_minuta=:id_minuta;
	this.SetItem(this.GetRow(),'n_aviso',n_aviso)
	this.SetItemStatus(this.GetRow(),'n_aviso',Primary!,NotModified!)
end if


end event

event dw_1::buttonclicked;string id_colegiado, nombre_banco, id_minuta,n_aviso

choose case dwo.name
	case 'b_colegiado'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		
		id_colegiado=f_busqueda_colegiados()
		
		if not f_es_vacio(id_colegiado) then 
			this.setitem(row,'id_colegiado',id_colegiado)
			idw_talon.setItem(1,'id_col',id_colegiado)
			SELECT nombre_banco INTO :nombre_banco FROM conceptos_remesables  WHERE id_colegiado = :id_colegiado   ;
			
			this.setitem(row,'nombre_banco',nombre_banco)
			this.setitem(row,'datos_bancarios',gnv_control_cuentas_bancarias.of_obtener_iban_nombre_modulo ('COL_REMESABLE',id_colegiado) )
			this.setitemstatus(row,'nombre_banco',primary!, notmodified!)
			this.setitemstatus(row,'datos_bancarios',primary!, notmodified!)
			// Acualizamos los otros dw para que se vea la informacion con el colegiado actual	
			idw_fact_liquidacion.Retrieve(dw_1.GetItemString(1,'id_fase'),dw_1.GetItemString(1,'id_colegiado'))
			idw_fact_pendientes.Retrieve(dw_1.GetItemString(1,'id_colegiado'))			
		end if
		
	case 'b_aviso'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Minutas"
		openWithParm(w_busqueda_fases_minutas,this.GetItemString(this.GetRow(),'id_colegiado'))
		id_minuta=Message.StringParm
		if not f_es_vacio(id_minuta) then
			select n_aviso into :n_aviso from fases_minutas where id_minuta=:id_minuta;
			this.SetItem(row,'id_fase',id_minuta)
			this.SetItem(row,'n_aviso',n_aviso)
		end if		

end choose
end event

event dw_1::itemchanged;CHOOSE CASE dwo.name
	CASE 'forma_pago'
		if idw_talon.dataobject <> 'd_liquidacion_talon_lleida' then ///***ALEXIS.08/04/2011. SCP-1230. Para el formato de Lleida no se ver$$HEX2$$e1002000$$ENDHEX$$la pesta$$HEX1$$f100$$ENDHEX$$a de talones***///
			if data = 'TA' then
				idw_talon.visible = true
				tab_1.tabpage_1.cb_imprimir.visible = true
				tab_1.tabpage_1.visible = true
			else
				idw_talon.visible = false
				tab_1.tabpage_1.cb_imprimir.visible = false
				tab_1.tabpage_1.visible = false
			end if
		end if	
	CASE 'importe'
		idw_talon.SetItem(1,'importe',double(data))
	CASE 'saldo_deudor'
		idw_talon.SetItem(1,'saldo_deudor',double(data))
	CASE 'deuda_facturas'
		idw_talon.SetItem(1,'deuda_facturas',double(data))
	CASE 'f_liquidacion'
		idw_talon.SetItem(1,'f_liquidacion',DateTime(Date(data),Now())	)
	CASE 'estado'
		if  data = 'L' and f_es_vacio(string(dw_1.getitemdatetime(1,'f_liquidacion')))  then 
			dw_1.SetItem(1,'f_liquidacion',DateTime(today(),Now())	)
		end if 
	CASE 'id_colegiado'
		idw_talon.SetItem(1,'id_colegiado',data	)	
	CASE ELSE
//		idw_talon.SetItem(1,dwo.name,data)
END CHOOSE

			
// Llamamos al evento que rellena el informe
parent.post event csd_generar_informe()
			
end event

event dw_1::retrieveend;call super::retrieveend;// MODIFICADO RICARDO 04-09-29

// Solo visualizamos el tal$$HEX1$$f300$$ENDHEX$$n en el caso de que la forma de pago sea tal$$HEX1$$f300$$ENDHEX$$n
if idw_talon.dataobject <> 'd_liquidacion_talon_lleida' then 	///***ALEXIS.08/04/2011. SCP-1230. Para el formato de Lleida no se ver$$HEX2$$e1002000$$ENDHEX$$la pesta$$HEX1$$f100$$ENDHEX$$a de talones***///
	if dw_1.getitemstring(1, 'forma_pago') = 'TA' then
		idw_talon.visible = true
		tab_1.tabpage_1.cb_imprimir.visible = true
		tab_1.tabpage_1.visible = true
	else
		idw_talon.visible = false
		tab_1.tabpage_1.cb_imprimir.visible = false
		tab_1.tabpage_1.visible = false
	end if
end if
// Llamamos al evento que rellena el informe
parent.trigger event csd_generar_informe()

// Sincronizamos el dw de facturas a liquidar
// Acualizamos los otros dw para que se vea la informacion con el colegiado actual	
idw_fact_liquidacion.Retrieve(dw_1.GetItemString(1,'id_fase'),dw_1.GetItemString(1,'id_colegiado'))
idw_fact_pendientes.Retrieve(dw_1.GetItemString(1,'id_colegiado'))
end event

event dw_1::retrievestart;call super::retrievestart;idw_fact_liquidacion.reset()
idw_fact_pendientes.reset()
end event

event dw_1::doubleclicked;call super::doubleclicked;string obser,  ls_id_fase, ls_id_minuta



CHOOSE CASE dwo.name
	CASE 't_observaciones'
		g_busqueda.titulo="Observaciones"
		obser    =this.GetItemString(row, 'observaciones')
		openwithparm(w_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
			dw_1.SetItem(row,'observaciones',obser)
		end if
		
	CASE 'n_aviso'
		
		if this.rowcount() = 0 then return

		//Se debe enlazar la informaci$$HEX1$$f300$$ENDHEX$$n del detalle de la liquidaci$$HEX1$$f300$$ENDHEX$$n con id_fase 
		ls_id_minuta = this.getitemstring(this.getrow(),"id_fase")
		ls_id_fase = wf_trae_id_fase(ls_id_minuta)
		g_fases_consulta.id_fase = ls_id_fase
		
		close(w_fases_liquidaciones)
		close(w_fases_detalle)
		close(w_liquidaciones_detalle)
		
		message.stringparm = "w_fases_detalle"
		SetPointer(Hourglass!)
	
		w_aplic_frame.postevent("csd_fasesdetalle")
	
			
		
END CHOOSE
end event

type tab_1 from tab within w_liquidaciones_detalle
event create ( )
event destroy ( )
integer x = 9
integer y = 728
integer width = 3401
integer height = 980
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_2 tabpage_2
tabpage_1 tabpage_1
tabpage_3 tabpage_3
tabpage_5 tabpage_5
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_1=create tabpage_1
this.tabpage_3=create tabpage_3
this.tabpage_5=create tabpage_5
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_2,&
this.tabpage_1,&
this.tabpage_3,&
this.tabpage_5,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_2)
destroy(this.tabpage_1)
destroy(this.tabpage_3)
destroy(this.tabpage_5)
destroy(this.tabpage_4)
end on

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3365
integer height = 864
long backcolor = 79741120
string text = "Informe"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_composite dw_composite
cb_imprimir_informe cb_imprimir_informe
dw_informe dw_informe
end type

on tabpage_2.create
this.dw_composite=create dw_composite
this.cb_imprimir_informe=create cb_imprimir_informe
this.dw_informe=create dw_informe
this.Control[]={this.dw_composite,&
this.cb_imprimir_informe,&
this.dw_informe}
end on

on tabpage_2.destroy
destroy(this.dw_composite)
destroy(this.cb_imprimir_informe)
destroy(this.dw_informe)
end on

type dw_composite from u_dw within tabpage_2
boolean visible = false
integer x = 2990
integer y = 184
integer width = 201
integer height = 140
integer taborder = 11
boolean enabled = false
string dataobject = "ds_composite"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type cb_imprimir_informe from commandbutton within tabpage_2
integer x = 2889
integer y = 764
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;//      MODIFICADO RICARDO 04-02-27
// Las retenidas y anuladas las saltamos
if dw_1.getitemString(1, 'estado')  = 'R' or dw_1.getitemString(1, 'estado')  = 'A' then return
//      MODIFICADO RICARDO 04-02-27

if idw_informe.Describe("DataWindow.Print.Margin.Bottom")='14000' then

	tab_1.tabpage_2.dw_composite.object.dw_1.dataobject = idw_informe.dataobject
	tab_1.tabpage_2.dw_composite.object.dw_2.dataobject = idw_informe.dataobject
	
	datawindowchild dwc, dwc2
	
	tab_1.tabpage_2.dw_composite.GetChild("dw_1", dwc)
	tab_1.tabpage_2.dw_composite.GetChild("dw_2", dwc2)
	
	idw_informe.RowsCopy(1,  idw_informe.RowCount(), Primary!, dwc, 1, Primary!)
	idw_informe.RowsCopy(1,  idw_informe.RowCount(), Primary!, dwc2, 1, Primary!) 
	
	idw_informe = tab_1.tabpage_2.dw_composite
	
end if

string impresora, bandeja, impresora2
f_registro_serie_impresora(g_serie_liquidaciones, impresora, bandeja)
impresora2 =printgetprinter()
PrintSetPrinter(impresora)
idw_informe.Modify("DataWindow.Print.Paper.Source = '"+bandeja+"'")
idw_informe.Print()
PrintSetPrinter(impresora2)
end event

type dw_informe from u_dw within tabpage_2
integer x = 18
integer y = 16
integer width = 2811
integer height = 848
integer taborder = 11
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3365
integer height = 864
long backcolor = 79741120
string text = "Tal$$HEX1$$f300$$ENDHEX$$n"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_imprimir cb_imprimir
dw_talon dw_talon
end type

on tabpage_1.create
this.cb_imprimir=create cb_imprimir
this.dw_talon=create dw_talon
this.Control[]={this.cb_imprimir,&
this.dw_talon}
end on

on tabpage_1.destroy
destroy(this.cb_imprimir)
destroy(this.dw_talon)
end on

type cb_imprimir from commandbutton within tabpage_1
integer x = 2889
integer y = 764
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;//      MODIFICADO RICARDO 04-02-27
// Las retenidas y anuladas las saltamos
if dw_1.getitemString(1, 'estado')  = 'R' or dw_1.getitemString(1, 'estado')  = 'A' then return
//      MODIFICADO RICARDO 04-02-27


idw_talon.Print()

end event

type dw_talon from u_dw within tabpage_1
integer x = 18
integer y = 16
integer width = 2816
integer height = 848
integer taborder = 11
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3365
integer height = 864
long backcolor = 79741120
string text = "Facturas Honorarios a Liquidar"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_fact_liquidacion dw_fact_liquidacion
end type

on tabpage_3.create
this.dw_fact_liquidacion=create dw_fact_liquidacion
this.Control[]={this.dw_fact_liquidacion}
end on

on tabpage_3.destroy
destroy(this.dw_fact_liquidacion)
end on

type dw_fact_liquidacion from u_dw within tabpage_3
integer x = 18
integer y = 16
integer width = 2816
integer height = 848
integer taborder = 11
string dataobject = "d_liquidacion_facturas_liquidacion"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3365
integer height = 864
long backcolor = 79741120
string text = "Facturas Descontadas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_otras_facturas_incluidas dw_otras_facturas_incluidas
end type

on tabpage_5.create
this.dw_otras_facturas_incluidas=create dw_otras_facturas_incluidas
this.Control[]={this.dw_otras_facturas_incluidas}
end on

on tabpage_5.destroy
destroy(this.dw_otras_facturas_incluidas)
end on

type dw_otras_facturas_incluidas from u_dw within tabpage_5
integer x = 18
integer y = 16
integer width = 2816
integer height = 848
integer taborder = 11
string dataobject = "d_liquidacion_otras_facturas_incluidas"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3365
integer height = 864
long backcolor = 79741120
string text = "Facturas Pendientes no Descontadas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_fact_pendientes dw_fact_pendientes
end type

on tabpage_4.create
this.dw_fact_pendientes=create dw_fact_pendientes
this.Control[]={this.dw_fact_pendientes}
end on

on tabpage_4.destroy
destroy(this.dw_fact_pendientes)
end on

type dw_fact_pendientes from u_dw within tabpage_4
integer x = 18
integer y = 16
integer width = 2816
integer height = 848
integer taborder = 11
string dataobject = "d_liquidacion_facturas_pend_colegiado"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type dw_lineas from u_dw within w_liquidaciones_detalle
boolean visible = false
integer x = 2277
integer y = 796
integer taborder = 40
boolean bringtotop = true
string dataobject = "ds_informe_liquidacion"
end type

