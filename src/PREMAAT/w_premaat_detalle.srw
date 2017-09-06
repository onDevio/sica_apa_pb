HA$PBExportHeader$w_premaat_detalle.srw
forward
global type w_premaat_detalle from w_detalle
end type
type tab_1 from tab within w_premaat_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_datos_ben from u_dw within tabpage_1
end type
type dw_beneficiarios from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_datos_ben dw_datos_ben
dw_beneficiarios dw_beneficiarios
end type
type tabpage_2 from userobject within tab_1
end type
type dw_domiciliaciones from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_domiciliaciones dw_domiciliaciones
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_5 from userobject within tab_1
end type
type dw_prestaciones from u_dw within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_prestaciones dw_prestaciones
end type
type tabpage_4 from userobject within tab_1
end type
type dw_datos_heredero from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_datos_heredero dw_datos_heredero
end type
type tabpage_6 from userobject within tab_1
end type
type dw_otros_datos from u_dw within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_otros_datos dw_otros_datos
end type
type tabpage_7 from userobject within tab_1
end type
type dw_historico_estados from u_dw within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_historico_estados dw_historico_estados
end type
type tab_1 from tab within w_premaat_detalle
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_5 tabpage_5
tabpage_4 tabpage_4
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type
end forward

global type w_premaat_detalle from w_detalle
integer width = 3675
integer height = 1964
string title = "Detalle de Mutua"
event csd_poner_colegiado ( string id_col )
event csd_cuota_incorporacion ( )
tab_1 tab_1
end type
global w_premaat_detalle w_premaat_detalle

type variables
u_dw idw_beneficiarios, idw_domiciliaciones, idw_datos_ben, idw_datos_heredero, idw_prestaciones, idw_otros_datos
u_dw idw_historico_estados

end variables

event csd_poner_colegiado(string id_col);dw_1.setitem(1, 'id_col', id_col)
dw_1.setitem(1, 'n_col', f_colegiado_n_col(id_col))
end event

event csd_cuota_incorporacion();//
double i, fila_insertada, cuota,importe,bonif=0
string sl_grupo, sl_comple1, sl_modulo_ahorro, id_col, sl_sexo, sl_forma_pago_defecto, sl_n_colegiado, sl_nombre
string sl_cod_basico, sl_cod_2000, sl_cod_comple1, sl_forma_pago
datetime dtl_f_nacimiento
long fila

sl_cod_basico = g_codigos_conceptos.premaat_cod_basico
sl_cod_2000 = g_codigos_conceptos.premaat_cod_2000
sl_cod_comple1 = g_codigos_conceptos.premaat_cod_comple1
sl_forma_pago_defecto = g_forma_pago_por_defecto
if f_es_vacio(sl_forma_pago_defecto) then sl_forma_pago_defecto = 'DB'

i=dw_1.GetRow()

sl_grupo = dw_1.getitemstring(i, 'grupo')
sl_comple1 = dw_1.getitemstring(i, 'grupo_comple1')
sl_modulo_ahorro = dw_1.getitemstring(i, 'modulo_ahorro')	
id_col = dw_1.getitemstring(i, 'id_col')		

select sexo, n_colegiado, f_nacimiento, nombre 
into :sl_sexo,:sl_n_colegiado,:dtl_f_nacimiento,:sl_nombre 
from colegiados where id_colegiado=:id_col;


if sl_grupo='A' then
	cuota = f_premaat_dame_cuota('A', dtl_f_nacimiento, sl_sexo, '')
	if cuota > 0 then		
		if g_colegio='COAATLE' then bonif+=round(cuota*g_porc_bonif_premaat,2)
		//insert into conceptos_domiciliables (id_colegiado,forma_de_pago,concepto,importe,es_extra)
		//values (:id_col,:sl_forma_pago_defecto,:sl_cod_basico,:cuota,'N');
		
		fila=idw_domiciliaciones.Find("concepto='"+sl_cod_basico+"'",1,idw_domiciliaciones.rowcount())
		if fila<1 then	fila=idw_domiciliaciones.insertrow(0)

		 idw_domiciliaciones.SetItem(fila,'id_colegiado',id_col)
		idw_domiciliaciones.SetItem(fila,'forma_de_pago',sl_forma_pago_defecto)
		idw_domiciliaciones.SetItem(fila,'concepto',sl_cod_basico)
		idw_domiciliaciones.SetItem(fila,'importe',cuota)
		idw_domiciliaciones.SetItem(fila,'es_extra','N')
		idw_domiciliaciones.SetItem(fila, 'empresa',g_empresa)
		
		
	end if
end if

if sl_grupo='C' then
	cuota=f_premaat_dame_cuota('C', dtl_f_nacimiento, sl_sexo, sl_modulo_ahorro)
	if cuota > 0 then		
		if g_colegio='COAATLE' then bonif+=round(cuota*g_porc_bonif_premaat,2)
//		insert into conceptos_domiciliables (id_colegiado,forma_de_pago,concepto,importe,es_extra)
//		values (:id_col,:sl_forma_pago_defecto,:sl_cod_2000,:cuota,'N');
		
		fila=idw_domiciliaciones.Find("concepto='"+sl_cod_2000+"'",1,idw_domiciliaciones.rowcount())
		if fila<1 then	fila=idw_domiciliaciones.insertrow(0)

		idw_domiciliaciones.SetItem(fila,'id_colegiado',id_col)
		idw_domiciliaciones.SetItem(fila,'forma_de_pago',sl_forma_pago_defecto)
		idw_domiciliaciones.SetItem(fila,'concepto',sl_cod_2000)
		idw_domiciliaciones.SetItem(fila,'importe',cuota)
		idw_domiciliaciones.SetItem(fila,'es_extra','N')
		idw_domiciliaciones.SetItem(fila, 'empresa',g_empresa)
		
	end if
end if

if sl_comple1='S' then	
	cuota=f_premaat_dame_cuota('C1', dtl_f_nacimiento, sl_sexo,  '')
	if cuota > 0 then		
		if g_colegio='COAATLE' then bonif+=round(cuota*g_porc_bonif_premaat,2)
//		insert into conceptos_domiciliables (id_colegiado,forma_de_pago,concepto,importe,es_extra)
//		values (:id_col,:sl_forma_pago_defecto,:sl_cod_comple1,:cuota,'N');

		fila=idw_domiciliaciones.Find("concepto='"+sl_cod_comple1+"'",1,idw_domiciliaciones.rowcount())
		if fila<1 then	fila=idw_domiciliaciones.insertrow(0)

		idw_domiciliaciones.SetItem(fila,'id_colegiado',id_col)
		idw_domiciliaciones.SetItem(fila,'forma_de_pago',sl_forma_pago_defecto)
		idw_domiciliaciones.SetItem(fila,'concepto',sl_cod_comple1)
		idw_domiciliaciones.SetItem(fila,'importe',cuota)
		idw_domiciliaciones.SetItem(fila,'es_extra','N')
		idw_domiciliaciones.SetItem(fila, 'empresa',g_empresa)
	end if
end if



if bonif>0 then
//	insert into conceptos_domiciliables (id_colegiado,forma_de_pago,concepto,importe,es_extra)
//	values (:id_col,:sl_forma_pago_defecto,:g_codigos_conceptos.bonif_premaat,:bonif,'N');
	fila=idw_domiciliaciones.Find("concepto='"+g_codigos_conceptos.bonif_premaat+"'",1,idw_domiciliaciones.rowcount())
	if fila<1 then	fila=idw_domiciliaciones.insertrow(0)

	idw_domiciliaciones.SetItem(fila,'id_colegiado',id_col)
	idw_domiciliaciones.SetItem(fila,'forma_de_pago',sl_forma_pago_defecto)
	idw_domiciliaciones.SetItem(fila,'concepto',g_codigos_conceptos.bonif_premaat)
	idw_domiciliaciones.SetItem(fila,'importe',bonif)
	idw_domiciliaciones.SetItem(fila,'es_extra','N')
	idw_domiciliaciones.SetItem(fila, 'empresa',g_empresa)
end if
	


end event

on w_premaat_detalle.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_premaat_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event csd_nuevo;call super::csd_nuevo;
if AncestorReturnValue>0 then
	//Metemos en el campo clave el valor obtenido desde el contador.
	dw_1.SetItem(dw_1.GetRow(),'id_premaat',f_siguiente_numero('PREMAAT',10))
	
	idw_otros_datos.event pfc_addrow()
	idw_otros_datos.setitem(1, 'importe_pagar',0)
	idw_otros_datos.setitem(1, 'importe_pagar_comple1',0)
	idw_otros_datos.setitem(1, 'importe_pagar_comple2',0)
	idw_otros_datos.SetItemStatus(1, 0, Primary!, DataModified!)
	
	dw_1.SetFocus()
	

end if

return AncestorReturnValue
end event

event activate;call super::activate;g_dw_lista = g_dw_lista_premaat
g_w_lista = g_lista_premaat
g_w_detalle = g_detalle_premaat
g_lista = 'w_premaat_lista'
g_detalle = 'w_premaat_detalle'
end event

event csd_anterior;call super::csd_anterior;If g_dw_lista.RowCount() > 0 then
   g_premaat_consulta.id_premaat =g_dw_lista.GetItemString(g_dw_lista.GetRow(),'id_premaat')
   dw_1.event csd_retrieve()
end if

end event

event csd_primero;call super::csd_primero;// Comprobamos que la ventana "lista previa" del m$$HEX1$$f300$$ENDHEX$$dulo est$$HEX2$$e1002000$$ENDHEX$$abierta
if not isvalid(g_dw_lista) then return
	
If g_dw_lista.RowCount() > 0 then
    g_dw_lista.SetRow(1)
    g_dw_lista.ScrollToRow(1)
	 g_premaat_consulta.id_premaat = g_dw_lista.GetItemString(1,'id_premaat')	
    dw_1.event csd_retrieve()
end if

end event

event csd_siguiente;call super::csd_siguiente;If g_dw_lista.RowCount() > 0 then
   g_premaat_consulta.id_premaat =g_dw_lista.GetItemString(g_dw_lista.GetRow(),'id_premaat')
   dw_1.event csd_retrieve()
end if

end event

event csd_ultimo;call super::csd_ultimo;// Comprobamos que la ventana "lista previa" del m$$HEX1$$f300$$ENDHEX$$dulo est$$HEX2$$e1002000$$ENDHEX$$abierta
if not isvalid(g_dw_lista) then return

If g_dw_lista.RowCount() > 0 then
  g_dw_lista.SetRow(g_dw_lista.RowCount())
  g_dw_lista.ScrollToRow(g_dw_lista.RowCount())
  g_premaat_consulta.id_premaat= g_dw_lista.GetItemString(g_dw_lista.RowCount(),'id_premaat')
  dw_1.event csd_retrieve()
end if 

end event

event open;call super::open;idw_beneficiarios = tab_1.tabpage_1.dw_beneficiarios
idw_domiciliaciones = tab_1.tabpage_2.dw_domiciliaciones
idw_datos_ben = tab_1.tabpage_1.dw_datos_ben
idw_datos_heredero = tab_1.tabpage_4.dw_datos_heredero
idw_prestaciones = tab_1.tabpage_5.dw_prestaciones
idw_otros_datos = tab_1.tabpage_6.dw_otros_datos
idw_historico_estados = tab_1.tabpage_7.dw_historico_estados
 
f_enlaza_dw(dw_1, idw_beneficiarios,'id_col','id_col')
//f_enlaza_dw(dw_1, idw_datos_heredero,'id_heredero','id_cliente')
f_enlaza_dw(idw_beneficiarios, idw_datos_ben,'id_heredero','id_cliente')
f_enlaza_dw(dw_1, idw_domiciliaciones,'id_col','id_colegiado')
//f_enlaza_dw(dw_1, idw_domiciliaciones,'id_premaat','id_premaat')
f_enlaza_dw(dw_1, idw_prestaciones,'id_premaat','id_premaat')
f_enlaza_dw(dw_1, idw_otros_datos,'id_premaat','id_premaat')
f_enlaza_dw(dw_1, idw_historico_estados,'id_premaat','id_premaat')

//A partir de aqu$$HEX2$$ed002000$$ENDHEX$$se pueden introducir las funciones de cambios de tama$$HEX1$$f100$$ENDHEX$$o y
//posici$$HEX1$$f300$$ENDHEX$$n de los controles de la ventana. Por ejemplo:
inv_resize.of_Register (tab_1, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_datos_ben, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_beneficiarios, "ScaletoBottom")
inv_resize.of_Register (idw_domiciliaciones, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_datos_heredero, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_prestaciones, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_otros_datos, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_historico_estados, "ScaletoRight&Bottom")
end event

event pfc_preupdate;call super::pfc_preupdate;//Control de permisos
if f_puedo_escribir(g_usuario, '0000000024')= -1 then return -1
// VALIDACIONES
double cuantos
string id_col, id_premaat
string mensaje='', alta

alta = dw_1.getitemstring(1, 'alta')

mensaje=mensaje + f_valida(dw_1,'id_col','NOVACIO',g_idioma.of_getmsg('msg_listas.n_coleg_valido','Debe tener un n$$HEX1$$fa00$$ENDHEX$$meo de colegiado'))

if alta = 'S' then
//mensaje=mensaje + f_valida(dw_1,'importe_cobrar','NONULO','Debe tener un importe a cobrar')
//mensaje=mensaje + f_valida(dw_1,'importe_pagar','NONULO','Debe tener un importe a pagar')
//mensaje=mensaje + f_valida(dw_1,'n_mutualista','NOVACIO','Debe tener un n$$HEX1$$fa00$$ENDHEX$$mero de mutualista')
//mensaje=mensaje + f_valida(dw_1,'tipo_prestacion','NOVACIO','Debe tener un tipo de prestaci$$HEX1$$f300$$ENDHEX$$n')
//mensaje=mensaje + f_valida(dw_1,'tipo_mutualista','NOVACIO','Debe tener un tipo de mutualista')
//mensaje=mensaje + f_valida(dw_1,'grupo','NOVACIO','Debe tener un grupo')
end if
// Validaciones de Beneficiarios
mensaje=mensaje + f_valida(idw_beneficiarios,'id_heredero','NOVACIO',g_idioma.of_getmsg('premaat.msg_ben_nif','El Beneficiario debe tener un N.I.F.'))
// Validaciones de Domiciliaciones
mensaje=mensaje + f_valida(idw_domiciliaciones,'concepto','NOVACIO',g_idioma.of_getmsg('premaat.msg_dom_concepto_dom','Domiciliaciones: Indique el Concepto a domiciliar'))
mensaje=mensaje + f_valida(idw_domiciliaciones,'importe','NONULO',g_idioma.of_getmsg('premaat.msg_dom_concepto_importe','Domiciliaciones: Indique el importe'))
mensaje=mensaje + f_valida(idw_domiciliaciones,'forma_de_pago','NOVACIO',g_idioma.of_getmsg('premaat.msg_dom_forma_pago','Domiciliaciones: Indique la forma de pago'))
// Validaciones de Prestaciones
mensaje=mensaje + f_valida(idw_prestaciones,'tipo_prestacion','NOVACIO',g_idioma.of_getmsg('premaat.msg_pres_tipo','Prestaciones: Indique el Tipo de Prestaci$$HEX1$$f300$$ENDHEX$$n'))
mensaje=mensaje + f_valida(idw_prestaciones,'importe','NONULO',g_idioma.of_getmsg('premaat.msg_pres_importe','Prestaciones: Indique el importe'))
mensaje=mensaje + f_valida(idw_prestaciones,'forma_pago','NOVACIO',g_idioma.of_getmsg('premaat.msg_pres_f_cobro','Prestaciones: Indique la forma de cobro'))

// Validaci$$HEX1$$f300$$ENDHEX$$n de NO duplicidad
id_col = dw_1.getitemstring(1,'id_col')  
id_premaat = dw_1.getitemstring(1,'id_premaat')  

	SELECT count(*)  
    INTO :cuantos  
    FROM premaat  
   WHERE premaat.id_col = :id_col   and premaat.id_premaat <> :id_premaat;
if cuantos > 0 then
	mensaje=mensaje + g_idioma.of_getmsg('colegiados.premaat','Este Colegiado ya tiene una ficha abierta en PREMAAT')
end if
// FIN
int retorno=1

if mensaje<>'' then
	messagebox(G_TITULO, mensaje,StopSign!)
	retorno=-1
end if


string old_alta,new_alta,tipo
long linea


select alta into :old_alta from premaat where id_premaat=:id_premaat;


if alta<>old_alta then
	linea= idw_historico_estados.event pfc_addrow()
	if alta='S' then
		if g_calcular_cuota_alta_premaat='S' then event csd_cuota_incorporacion()
		tipo='A'
	else
		tipo='B'
	end if

	idw_historico_estados.SetItem(linea,'id_premaat',id_premaat)
	idw_historico_estados.SetItem(linea,'usuario',g_usuario)		
	idw_historico_estados.SetItem(linea,'tipo',tipo)	
	idw_historico_estados.SetItem(linea,'fecha',datetime(today(),now()))		
//	idw_historico_estados.SetItem(linea,'domicilio_antiguo',old_dom_activo_fiscal)
//	idw_historico_estados.SetItem(linea,'poblacion_antigua',old_pob_activa_fiscal)	
//	idw_historico_estados.SetItem(linea,'domicilio_nuevo',new_dom_activo_fiscal)
//	idw_cambios_domicilio.SetItem(linea,'poblacion_nueva',new_pob_activa_fiscal)	
end if








return retorno

end event

event pfc_postupdate;call super::pfc_postupdate;if isvalid(g_detalle_colegiados) then 
	g_detalle_colegiados.dynamic event csd_retrieve_tab_mutua()
	g_detalle_colegiados.dynamic event csd_refrescar_conceptos()
end if
return 1
end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_premaat_detalle
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_premaat_detalle
end type

type cb_nuevo from w_detalle`cb_nuevo within w_premaat_detalle
end type

type cb_ayuda from w_detalle`cb_ayuda within w_premaat_detalle
end type

type cb_grabar from w_detalle`cb_grabar within w_premaat_detalle
end type

type cb_ant from w_detalle`cb_ant within w_premaat_detalle
end type

type cb_sig from w_detalle`cb_sig within w_premaat_detalle
end type

type dw_1 from w_detalle`dw_1 within w_premaat_detalle
integer width = 3429
integer height = 772
string dataobject = "d_premaat_cabecera"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_1::csd_retrieve;call super::csd_retrieve;if g_premaat_consulta.id_premaat = '' or isnull(g_premaat_consulta.id_premaat) then return
int retorno
retorno = parent.event closequery()
if retorno = 1 then return
this.Retrieve(g_premaat_consulta.id_premaat)
g_premaat_consulta.id_premaat=''
end event

event dw_1::buttonclicked;call super::buttonclicked;string id_colegiado, n_col, id_heredero
choose case dwo.name
	case 'cb_colegiado'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		
		id_colegiado=f_busqueda_colegiados()
		n_col = f_colegiado_n_col(id_colegiado)
		
		if not f_es_vacio(id_colegiado) then this.setitem(row,'id_col',id_colegiado)
		if not f_es_vacio(n_col) then this.setitem(row,'n_col',n_col)
	case 'cb_heredero'		
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Herederos"
		g_busqueda.dw="d_lista_busqueda_terceros"
		
		id_heredero=f_busqueda_terceros(g_terceros_codigos.ben_premaat)
		n_col = f_clientes_n_cliente(id_heredero)
		
		if not f_es_vacio(id_heredero) then this.setitem(row,'id_heredero',id_heredero)	
	case 'b_borrar_grupo'
		if messagebox(g_titulo, g_idioma.of_getmsg('colegiados.premaat_baja','$$HEX1$$bf00$$ENDHEX$$Desea dar de Baja a este colegiado en PREMAAT?~rLos importes a cobrar y pagar se actualizar$$HEX1$$e100$$ENDHEX$$n a 0'), Question!, YesNo!) <> 1 then
			return
		else
			this.Setitem(1,'alta','N')
			this.Setitem(1,'grupo','')
			this.Setitem(1,'importe_pagar',0)
			this.Setitem(1,'importe_pagar_comple1',0)
			this.Setitem(1,'importe_pagar_comple2',0)
			this.Setitem(1,'importe_cobrar',0)
			
		end if
end choose
end event

event dw_1::itemchanged;call super::itemchanged;choose case dwo.name
	case 'alta'
		if data = 'N' then
			if (idw_domiciliaciones.rowcount() > 0) or (idw_prestaciones.rowcount() >0) then
				messagebox(g_titulo, g_idioma.of_getmsg('colegiados.premaat_baja_dom','Al dar de baja al colegiado en PREMAAT deber$$HEX1$$ed00$$ENDHEX$$a revisar las domiciliaciones y prestaciones que siguen activas'))
			end if
		end if
end choose
end event

event dw_1::doubleclicked;call super::doubleclicked;string obser
CHOOSE CASE dwo.name
	CASE 'observaciones'
		g_busqueda.titulo="Observaciones"
		obser    =this.GetItemString(row, 'observaciones')
		openwithparm(w_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
			dw_1.SetItem(row,'observaciones',obser)
		end if
end choose
end event

type tab_1 from tab within w_premaat_detalle
string tag = "texto=premaat.beneficiarios"
integer y = 800
integer width = 3584
integer height = 928
integer taborder = 70
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
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_5 tabpage_5
tabpage_4 tabpage_4
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_5=create tabpage_5
this.tabpage_4=create tabpage_4
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_5,&
this.tabpage_4,&
this.tabpage_6,&
this.tabpage_7}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_5)
destroy(this.tabpage_4)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
end on

type tabpage_1 from userobject within tab_1
string tag = "Beneficiarios"
integer x = 18
integer y = 112
integer width = 3547
integer height = 800
long backcolor = 79741120
string text = "Beneficiarios"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Picture!"
long picturemaskcolor = 536870912
string powertiptext = "Beneficiarios del Colegiado"
dw_datos_ben dw_datos_ben
dw_beneficiarios dw_beneficiarios
end type

on tabpage_1.create
this.dw_datos_ben=create dw_datos_ben
this.dw_beneficiarios=create dw_beneficiarios
this.Control[]={this.dw_datos_ben,&
this.dw_beneficiarios}
end on

on tabpage_1.destroy
destroy(this.dw_datos_ben)
destroy(this.dw_beneficiarios)
end on

type dw_datos_ben from u_dw within tabpage_1
integer x = 1701
integer y = -16
integer width = 1829
integer height = 800
integer taborder = 20
string dataobject = "d_premaat_datos_ben"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_beneficiarios from u_dw within tabpage_1
integer width = 1719
integer height = 804
integer taborder = 11
string dataobject = "d_premaat_beneficiarios"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

event pfc_addrow;call super::pfc_addrow;this.SetItem(ancestorreturnvalue,'id',f_siguiente_numero('PREMAAT_BEN',10)) 
return ancestorreturnvalue
end event

event pfc_insertrow;call super::pfc_insertrow;this.SetItem(ancestorreturnvalue,'id',f_siguiente_numero('PREMAAT_BEN',10)) 
return ancestorreturnvalue
end event

event buttonclicked;call super::buttonclicked;string id_heredero
choose case dwo.name
	case 'cb_heredero'		
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Herederos"
		g_busqueda.dw="d_lista_busqueda_terceros"
		
		id_heredero=f_busqueda_terceros(g_terceros_codigos.ben_premaat)
		
		if not f_es_vacio(id_heredero) then this.setitem(row,'id_heredero',id_heredero)	
		idw_datos_ben.retrieve(id_heredero)
	case 'b_sig'
		if this.getrow() < this.rowcount() then
			this.scrolltorow(this.getrow() +1)
		end if
	case 'b_ant'
		if this.getrow() > 1 then
			this.scrolltorow(this.getrow() -1)
		end if
	case 'cb_anyadir'
		this.event pfc_addrow()
	case 'cb_borrar'
		this.deleterow(this.getrow())		
end choose
end event

event constructor;call super::constructor;
// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE 'alta'
//		if data = 'N' then
//			int ret
//			ret = Messagebox(g_titulo,'$$HEX1$$bf00$$ENDHEX$$Desea que el importe a cobrar sea 0?',Question!,YesNo!)
//			if ret = 1 Then
//				this.setItem(row,'importe_cobrar',0)
//			End If
//		End If
END CHOOSE

end event

type tabpage_2 from userobject within tab_1
string tag = "Conceptos Domiciliables"
integer x = 18
integer y = 112
integer width = 3547
integer height = 800
long backcolor = 79741120
string text = "Conceptos Domiciliables"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom025!"
long picturemaskcolor = 536870912
string powertiptext = "Conceptos Domiciliables"
dw_domiciliaciones dw_domiciliaciones
end type

on tabpage_2.create
this.dw_domiciliaciones=create dw_domiciliaciones
this.Control[]={this.dw_domiciliaciones}
end on

on tabpage_2.destroy
destroy(this.dw_domiciliaciones)
end on

type dw_domiciliaciones from u_dw within tabpage_2
integer x = -18
integer y = 16
integer width = 3547
integer height = 768
integer taborder = 11
string dataobject = "d_premaat_conceptos_domiciliables"
end type

event itemchanged;call super::itemchanged;integer f
string cod,des,empresa

choose case dwo.name
	case 'concepto'
		for f=1 to this.rowcount()
			if f <> row and this.getitemstring(f,'concepto') = data then
				MessageBox(g_titulo,g_idioma.of_getmsg('premaat.duplicar_conceptos','No se pueden duplicar conceptos.'))
				this.setitem(row,'concepto','')
				this.setitem(row,'empresa','')
				return 1
			end if
		next
		
		double importe
		select importe into :importe from csi_articulos_servicios where codigo = :data and empresa=:g_empresa;
		this.SetItem(row,'importe',importe)
		this.setitem(row,'empresa',g_empresa)
end choose

end event

event retrieveend;call super::retrieveend;// MODIFICADO RICARDO 04-09-14
// Cuando carguemos la DW, para todas aquellas filas que no tengan valor les colocamos el valor del check a 'N'
long fila

for fila = 1 to this.rowcount()
	if f_es_vacio(this.GetItemString(fila, 'es_extra')) then this.SetItem(fila, 'es_extra', 'N')
next
// Grabamos la dw, de esta forma el usuario no se entera que estamos tocando el campo
this.update()
// FIN MODIFICADO RICARDO 04-09-14   
this.setfilter("empresa='"+g_empresa+"'")
this.filter()

end event

type tabpage_3 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 3547
integer height = 800
long backcolor = 79741120
string text = "Datos del Colegiado"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type

type tabpage_5 from userobject within tab_1
string tag = "texto=premaat.prestaciones"
integer x = 18
integer y = 112
integer width = 3547
integer height = 800
long backcolor = 79741120
string text = "Prestaciones"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "FormatDollar!"
long picturemaskcolor = 536870912
string powertiptext = "Prestaciones"
dw_prestaciones dw_prestaciones
end type

on tabpage_5.create
this.dw_prestaciones=create dw_prestaciones
this.Control[]={this.dw_prestaciones}
end on

on tabpage_5.destroy
destroy(this.dw_prestaciones)
end on

type dw_prestaciones from u_dw within tabpage_5
integer x = -18
integer y = 16
integer width = 3547
integer height = 768
integer taborder = 11
string dataobject = "d_premaat_prestaciones"
end type

event buttonclicked;call super::buttonclicked;string tipo_persona, id_beneficiario, id_colegiado

tipo_persona = this.getitemstring(row, 'tipo_persona')

choose case tipo_persona
	case 'C'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		
		id_colegiado=f_busqueda_colegiados()
		
		if not f_es_vacio(id_colegiado) then this.setitem(row,'id_persona',id_colegiado)
	case 'B'		
//		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Beneficiarios"
//		g_busqueda.dw="d_lista_busqueda_terceros"
//		
//		id_beneficiario=f_busqueda_terceros(g_terceros_codigos.ben_premaat)
//		
//		if not f_es_vacio(id_beneficiario) then this.setitem(row,'id_persona',id_beneficiario)	

		openwithparm(w_premaat_selecciona_beneficiario, dw_1.getitemstring(1, 'id_col'))
		id_beneficiario = message.stringparm
		if id_beneficiario = '-1' or f_es_vacio(id_beneficiario) then return
		this.setitem(row,'id_persona',id_beneficiario)	
end choose
end event

event type long pfc_addrow();call super::pfc_addrow;this.SetItem(ancestorreturnvalue,'id_prestaciones',f_siguiente_numero('ID_PRESTACIONES',10)) 
this.setitem(ancestorreturnvalue, 'id_persona', dw_1.getitemstring(1, 'id_col'))
return ancestorreturnvalue
end event

event type long pfc_insertrow();call super::pfc_insertrow;this.SetItem(ancestorreturnvalue,'id_prestaciones',f_siguiente_numero('ID_PRESTACIONES',10)) 
this.setitem(ancestorreturnvalue, 'id_persona', dw_1.getitemstring(1, 'id_col'))
return ancestorreturnvalue
end event

event itemchanged;call super::itemchanged;string id_persona
choose case dwo.name
	case 'tipo_persona'
		if data = 'C' then id_persona =  dw_1.getitemstring(1, 'id_col') else id_persona = ''
		this.setitem(row, 'id_persona', id_persona)
	
end choose
end event

type tabpage_4 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 3547
integer height = 800
long backcolor = 79741120
string text = "Datos del Heredero"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_datos_heredero dw_datos_heredero
end type

on tabpage_4.create
this.dw_datos_heredero=create dw_datos_heredero
this.Control[]={this.dw_datos_heredero}
end on

on tabpage_4.destroy
destroy(this.dw_datos_heredero)
end on

type dw_datos_heredero from u_dw within tabpage_4
boolean visible = false
integer x = -18
integer y = -16
integer width = 3547
integer height = 800
integer taborder = 11
string dataobject = "d_premaat_datos_ben"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.object.t_cabecera.text = 'Datos personales del Heredero'
end event

type tabpage_6 from userobject within tab_1
string tag = "texto=premaat.otros_datos"
integer x = 18
integer y = 112
integer width = 3547
integer height = 800
long backcolor = 79741120
string text = "Otros datos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "EnglishQuery5!"
long picturemaskcolor = 536870912
dw_otros_datos dw_otros_datos
end type

on tabpage_6.create
this.dw_otros_datos=create dw_otros_datos
this.Control[]={this.dw_otros_datos}
end on

on tabpage_6.destroy
destroy(this.dw_otros_datos)
end on

type dw_otros_datos from u_dw within tabpage_6
event csd_oculta_tab ( )
integer x = -18
integer y = 16
integer width = 3547
integer height = 768
integer taborder = 11
string dataobject = "d_premaat_otros_datos"
boolean ib_rmbmenu = false
end type

event csd_oculta_tab();int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'PREMAAT_OTROS_DATOS'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

end event

type tabpage_7 from userobject within tab_1
string tag = "texto=colegiados.historico"
integer x = 18
integer y = 112
integer width = 3547
integer height = 800
long backcolor = 79741120
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Start!"
long picturemaskcolor = 536870912
dw_historico_estados dw_historico_estados
end type

on tabpage_7.create
this.dw_historico_estados=create dw_historico_estados
this.Control[]={this.dw_historico_estados}
end on

on tabpage_7.destroy
destroy(this.dw_historico_estados)
end on

type dw_historico_estados from u_dw within tabpage_7
integer x = 18
integer y = 16
integer width = 3511
integer height = 736
integer taborder = 11
string dataobject = "d_premaat_historico_altas"
boolean ib_rmbmenu = false
end type

event pfc_addrow;call super::pfc_addrow;idw_historico_estados.SetItem(ancestorreturnValue,'id_modificacion',f_siguiente_numero('ID_PREMAAT_HISTORICO',10))

return ancestorreturnvalue
end event

