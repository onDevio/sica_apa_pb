HA$PBExportHeader$w_musaat_detalle.srw
forward
global type w_musaat_detalle from w_detalle
end type
type tab_1 from tab within w_musaat_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_src from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_src dw_src
end type
type tabpage_11 from userobject within tab_1
end type
type dw_otros_seguros_src from u_dw within tabpage_11
end type
type tabpage_11 from userobject within tab_1
dw_otros_seguros_src dw_otros_seguros_src
end type
type tabpage_2 from userobject within tab_1
end type
type dw_accidentes from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_accidentes dw_accidentes
end type
type tabpage_3 from userobject within tab_1
end type
type dw_tasadores from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_tasadores dw_tasadores
end type
type tabpage_7 from userobject within tab_1
end type
type dw_peritos from u_dw within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_peritos dw_peritos
end type
type tabpage_4 from userobject within tab_1
end type
type dw_domiciliaciones from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_domiciliaciones dw_domiciliaciones
end type
type tabpage_10 from userobject within tab_1
end type
type pb_2 from picturebutton within tabpage_10
end type
type dw_otros_seguros from u_dw within tabpage_10
end type
type tabpage_10 from userobject within tab_1
pb_2 pb_2
dw_otros_seguros dw_otros_seguros
end type
type tabpage_5 from userobject within tab_1
end type
type dw_movimientos from u_dw within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_movimientos dw_movimientos
end type
type tabpage_6 from userobject within tab_1
end type
type dw_coberturas from u_dw within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_coberturas dw_coberturas
end type
type tabpage_8 from userobject within tab_1
end type
type pb_1 from picturebutton within tabpage_8
end type
type dw_otros from u_dw within tabpage_8
end type
type tabpage_8 from userobject within tab_1
pb_1 pb_1
dw_otros dw_otros
end type
type tabpage_9 from userobject within tab_1
end type
type dw_modificacion_datos from u_dw within tabpage_9
end type
type tabpage_9 from userobject within tab_1
dw_modificacion_datos dw_modificacion_datos
end type
type tab_1 from tab within w_musaat_detalle
tabpage_1 tabpage_1
tabpage_11 tabpage_11
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_7 tabpage_7
tabpage_4 tabpage_4
tabpage_10 tabpage_10
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_8 tabpage_8
tabpage_9 tabpage_9
end type
end forward

global type w_musaat_detalle from w_detalle
integer width = 4256
integer height = 2132
string title = "Detalle de Seguros"
event csd_poner_colegiado ( string id_col )
tab_1 tab_1
end type
global w_musaat_detalle w_musaat_detalle

type variables
u_dw idw_src, idw_accidentes, idw_tasaciones, idw_domiciliaciones, idw_movimientos, idw_coberturas
u_dw idw_peritos, idw_otros, idw_modificacion_datos, idw_otros_seguros, idw_otros_seguros_src
boolean i_nuevo = false, ib_recalculo = false

end variables

event csd_poner_colegiado(string id_col);dw_1.setitem(1, 'id_col', id_col)
if idw_otros_seguros_src.RowCount() > 0 then idw_otros_seguros_src.setitem(1, 'id_colegiado', id_col)


end event

on w_musaat_detalle.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_musaat_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event activate;call super::activate;g_dw_lista = g_dw_lista_musaat
g_w_lista = g_lista_musaat
g_w_detalle = g_detalle_musaat
g_lista = 'w_musaat_lista'
g_detalle = 'w_musaat_detalle'
end event

event csd_anterior;call super::csd_anterior;If g_dw_lista.RowCount() > 0 then
   g_musaat_consulta.id_musaat =g_dw_lista.GetItemString(g_dw_lista.GetRow(),'id_musaat')
   dw_1.event csd_retrieve()
end if

end event

event csd_nuevo;call super::csd_nuevo;
i_nuevo = true

IF AncestorReturnVAlue>0 then
	g_recien_grabado_modificacion=TRUE
	
	//Metemos en el campo clave el valor obtenido desde el contador.
	dw_1.SetItem(dw_1.GetRow(),'id_musaat',f_siguiente_numero('MUSAAT',10))
	idw_src.event pfc_addrow()
	idw_src.setitemstatus(1, 0, Primary!, DataModified!)
	idw_src.setitem(1, 'src_estado', '00')
	idw_src.setitem(1, 'src_cober', '00')
	idw_src.setitem(1, 'src_alta', 'S')
	idw_src.setitem(1, 'src_coef_cm', 1)
	idw_src.setitem(1, 'exceso', 'N')
	///*** CAL-255. Se a$$HEX1$$f100$$ENDHEX$$aden dado que con los valores iniciales asignados en el datawindow no los cog$$HEX1$$ed00$$ENDHEX$$a correctamente y no los guardaba. Alexis. 08/04/2010 ***///
	idw_src.setitem(1, 'src_cia', 'MU')
	idw_src.setitem(1, 'src_t_poliza', '01')
	///*** FIN CAL-255 ***///
	idw_src.setitem(1, 'src_poliza_plus', 'N')
	
	idw_accidentes.event pfc_addrow()
	idw_accidentes.setitemstatus(1, 0, Primary!, DataModified!)
	idw_accidentes.setitem(1, 'accidentes_alta', 'N')
	idw_tasaciones.event pfc_addrow()
	idw_tasaciones.setitemstatus(1, 0, Primary!, DataModified!)
	idw_tasaciones.setitem(1, 'tasadores_cober', '00')
	idw_tasaciones.setitem(1, 'tasadores_alta', 'N')
	
	idw_peritos.event pfc_addrow()
	idw_peritos.setitemstatus(1, 0, Primary!, DataModified!)
	idw_peritos.setitem(1, 'peritos_cober', '00')
	idw_peritos.setitem(1, 'peritos_alta', 'N')
	
	idw_otros.event pfc_addrow()
	idw_otros.setitemstatus(1, 0, Primary!, DataModified!)
	
	idw_otros_seguros_src.event pfc_addrow()
//	idw_otros_seguros_src.setitemstatus(1, 0, Primary!, DataModified!)
	idw_otros_seguros_src.setitem(1, 'src_cober', '0')
	idw_otros_seguros_src.setitem(1, 'moroso', 'N')
	idw_otros_seguros_src.setitem(1, 'alta', 'N')

	
	dw_1.SetFocus()
end if

return AncestorReturnValue
end event

event csd_primero;call super::csd_primero;// Comprobamos que la ventana "lista previa" del m$$HEX1$$f300$$ENDHEX$$dulo est$$HEX2$$e1002000$$ENDHEX$$abierta
if not isvalid(g_dw_lista) then return
	
If g_dw_lista.RowCount() > 0 then
    g_dw_lista.SetRow(1)
    g_dw_lista.ScrollToRow(1)
	 g_musaat_consulta.id_musaat = g_dw_lista.GetItemString(1,'id_musaat')	
    dw_1.event csd_retrieve()
end if

end event

event csd_siguiente;call super::csd_siguiente;If g_dw_lista.RowCount() > 0 then
   g_musaat_consulta.id_musaat =g_dw_lista.GetItemString(g_dw_lista.GetRow(),'id_musaat')
   dw_1.event csd_retrieve()
end if

end event

event csd_ultimo;call super::csd_ultimo;// Comprobamos que la ventana "lista previa" del m$$HEX1$$f300$$ENDHEX$$dulo est$$HEX2$$e1002000$$ENDHEX$$abierta
if not isvalid(g_dw_lista) then return

If g_dw_lista.RowCount() > 0 then
  g_dw_lista.SetRow(g_dw_lista.RowCount())
  g_dw_lista.ScrollToRow(g_dw_lista.RowCount())
  g_musaat_consulta.id_musaat= g_dw_lista.GetItemString(g_dw_lista.RowCount(),'id_musaat')
  dw_1.event csd_retrieve()
end if 

end event

event open;call super::open;g_recien_grabado_modificacion=TRUE

idw_src = tab_1.tabpage_1.dw_src
idw_accidentes = tab_1.tabpage_2.dw_accidentes
idw_tasaciones = tab_1.tabpage_3.dw_tasadores
idw_domiciliaciones = tab_1.tabpage_4.dw_domiciliaciones
idw_movimientos = tab_1.tabpage_5.dw_movimientos
idw_coberturas = tab_1.tabpage_6.dw_coberturas
idw_peritos = tab_1.tabpage_7.dw_peritos
idw_otros = tab_1.tabpage_8.dw_otros
idw_modificacion_datos = tab_1.tabpage_9.dw_modificacion_datos
idw_otros_seguros = tab_1.tabpage_10.dw_otros_seguros
idw_otros_seguros_src = tab_1.tabpage_11.dw_otros_seguros_src

f_enlaza_dw(dw_1, idw_src,'id_musaat','id_musaat') //Seguro Respon. Civil
f_enlaza_dw(dw_1, idw_accidentes,'id_musaat','id_musaat')
f_enlaza_dw(dw_1, idw_tasaciones,'id_musaat','id_musaat')
f_enlaza_dw(dw_1, idw_domiciliaciones,'id_col','id_colegiado')
f_enlaza_dw(dw_1, idw_movimientos,'id_col','id_col')
f_enlaza_dw(dw_1, idw_coberturas,'id_col','id_colegiado')
f_enlaza_dw(dw_1, idw_peritos,'id_musaat','id_musaat')
f_enlaza_dw(dw_1, idw_otros,'id_musaat','id_musaat')
f_enlaza_dw(dw_1, idw_otros_seguros,'id_col','id_colegiado')
f_enlaza_dw(dw_1, idw_otros_seguros_src,'id_col','id_colegiado')

//A partir de aqu$$HEX2$$ed002000$$ENDHEX$$se pueden introducir las funciones de cambios de tama$$HEX1$$f100$$ENDHEX$$o y
//posici$$HEX1$$f300$$ENDHEX$$n de los controles de la ventana. Por ejemplo:
inv_resize.of_Register (tab_1, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_src, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_accidentes, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_tasaciones, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_domiciliaciones, "ScaletoBottom")
inv_resize.of_Register (idw_movimientos, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_coberturas, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_peritos, "ScaletoRight&Bottom")
//inv_resize.of_Register (idw_otros, "ScaletoRight&Bottom")
idw_otros.inv_resize.of_Register ("otros", "ScaletoRight&Bottom")
inv_resize.of_Register (idw_modificacion_datos, "ScaletoRight&Bottom")
//inv_resize.of_Register (tab_1.tabpage_8.pb_1, "FixedtoRight")
inv_resize.of_Register (idw_otros_seguros, "ScaletoBottom")
inv_resize.of_Register (idw_otros_seguros_src, "ScaletoBottom")

// Establecer los calendarios
idw_src.postevent('csd_calendario')
idw_accidentes.postevent('csd_calendario')
idw_tasaciones.postevent('csd_calendario')
idw_peritos.postevent('csd_calendario')
idw_otros_seguros_src.postevent('csd_calendario')

//datawindowchild  ldwc_src_cober
//string src_cia
//src_cia = idw_src.GetItemString(idw_src.GetROw(),'src_cia')
//idw_src.getchild("src_cober", ldwc_src_cober)	
//ldwc_src_cober.settransobject(sqlca)
//ldwc_src_cober.retrieve(src_cia)
end event

event pfc_preupdate;call super::pfc_preupdate;// Indicamos que queremos cambiar el idioma
if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)

//Control de permisos
if f_puedo_escribir(g_usuario,'0000000010')=-1 then return -1

// VALIDACIONES
string mensaje='', id_col, id_musaat
int cuantos
datetime f_nula
setnull(f_nula)

id_col = dw_1.getitemstring(1, 'id_col')
id_musaat = dw_1.getitemstring(1, 'id_musaat')

mensaje=mensaje + f_valida(dw_1,'id_col','NOVACIO',g_idioma.of_getmsg('msg_musaat.tener_num_colegiado','Debe tener un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado'))

SELECT count(*)  
INTO :cuantos  
FROM musaat  
WHERE musaat.id_col = :id_col   and musaat.id_musaat <> :id_musaat;

if cuantos > 0 then
	mensaje=mensaje + g_idioma.of_getmsg('msg_musaat.colegiado_tiene_ficha','Este Colegiado ya tiene una ficha abierta en MUSAAT')
end if

mensaje=mensaje + f_valida(idw_src,'src_estado','NOVACIO',g_idioma.of_getmsg('msg_musaat.tener_estado_src','Debe tener un estado de S.R.C'))
mensaje=mensaje + f_valida(idw_src,'src_cober','NOVACIO',g_idioma.of_getmsg('msg_musaat.tener_cobertura_src','Debe tener una cobertura de S.R.C'))
mensaje=mensaje + f_valida(idw_tasaciones,'tasadores_cober','NOVACIO',g_idioma.of_getmsg('msg_musaat.tener_cobertura_tasaciones','Debe tener una cobertura de TASACIONES'))

//SCP-2390
//Coeficiente no superior a 1.5

double coeficiente
coeficiente = idw_src.getitemnumber(1, 'src_coef_cm')
if coeficiente > 1.50 then 
	mensaje=mensaje + g_idioma.of_getmsg('coeficiente','El coeficiente personal no puede ser superior a 1.50')
end if


// INC. 8722 Limite para cobertura
// INC. 9412 Desaparece el limite

//double coef, cober
//string alta, cod_cober
//coef = idw_src.getitemnumber(1, 'src_coef_cm')
//cod_cober = idw_src.getitemstring(1, 'src_cober')
//alta = idw_src.getitemstring(1, 'src_alta')
//select prima into :cober from musaat_cober_src where codigo = :cod_cober ;
//if alta = 'S' and cober > 310000 and coef > 1.50 then 
//	messagebox(g_titulo, "Un colegiado con m$$HEX1$$e100$$ENDHEX$$s del 50% de coeficiente de siniestralidad no puede contratar m$$HEX1$$e100$$ENDHEX$$s de 310.000 euros de cobertura.",information!)
//end if

// Validaciones de Conceptos Domiciliables
mensaje=mensaje + f_valida(idw_domiciliaciones,'concepto','NOVACIO',g_idioma.of_getmsg('msg_musaat.conceptos_domiciliables','Conceptos Domiciliables: Debe indicar el concepto.'))
//mensaje=mensaje + f_valida(idw_domiciliaciones,'importe','NONULO','Conceptos Domiciliables: Debe indicar el importe')
//mensaje=mensaje + f_valida(idw_domiciliaciones,'forma_de_pago','NOVACIO','Conceptos Domiciliables: Debe indicar la forma de pago')

// Validaciones de Otros Seguros
mensaje=mensaje + f_valida(idw_otros_seguros,'concepto','NOVACIO',g_idioma.of_getmsg('msg_musaat.otros_seguros_cuotas','Otros Seguros/Cuotas: Debe indicar el concepto'))
//mensaje=mensaje + f_valida(idw_otros_seguros,'importe','NONULO','Otros Seguros/Cuotas:Debe indicar el importe')
//mensaje=mensaje + f_valida(idw_otros_seguros,'forma_de_pago','NOVACIO','Otros Seguros/Cuotas: Debe indicar la forma de pago')

int retorno=1
if mensaje<>'' then
	messagebox(G_TITULO, mensaje,StopSign!)
	retorno=-1
end if

i_nuevo = false

return retorno

end event

event pfc_postupdate;call super::pfc_postupdate;g_recien_grabado_modificacion=TRUE

if isvalid(g_detalle_colegiados) then 
	g_detalle_colegiados.dynamic event csd_retrieve_tab_seguros()
	g_detalle_colegiados.dynamic event csd_refrescar_conceptos()
end if

// Abrimos la ventana de recalculo de avisos
if ib_recalculo then 
	openwithparm(w_musaat_recalculo_minutas, dw_1.getitemstring(1,'id_col'))
end if

ib_recalculo = false

return 1

end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_musaat_detalle
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_musaat_detalle
string tag = "texto=general.guardar_pantalla"
end type

type cb_nuevo from w_detalle`cb_nuevo within w_musaat_detalle
string tag = "texto=general.nuevo"
end type

type cb_ayuda from w_detalle`cb_ayuda within w_musaat_detalle
string tag = "texto=general.ayuda"
end type

type cb_grabar from w_detalle`cb_grabar within w_musaat_detalle
string tag = "texto=general.grabar"
end type

type cb_ant from w_detalle`cb_ant within w_musaat_detalle
end type

type cb_sig from w_detalle`cb_sig within w_musaat_detalle
end type

type dw_1 from w_detalle`dw_1 within w_musaat_detalle
event csd_modificacion_datos ( string id_colegiado,  u_dw dw,  string nombre_dw,  string campo,  long row )
integer height = 472
string dataobject = "d_musaat_cabecera"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_1::csd_modificacion_datos(string id_colegiado, u_dw dw, string nombre_dw, string campo, long row);// Actualiza los datos modificados en la tabla "modificaciones"
// ------------------------------------------------------------
string  colegiado, modificacion, data, tipo
integer fila

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

//se a$$HEX1$$f100$$ENDHEX$$ade un registro a modificaci$$HEX1$$f300$$ENDHEX$$n de datos
if g_recien_grabado_modificacion=TRUE then
	idw_modificacion_datos.triggerevent("pfc_addrow")
end if

fila        =idw_modificacion_datos.rowcount()
colegiado   =id_colegiado
modificacion=idw_modificacion_datos.getitemstring(fila,'modificacion')

// se concatenan las modificaciones con la anterior
if isnull(modificacion) then modificacion = ''
modificacion = modificacion + nombre_dw + ' ' + campo + '=' + data + '; '

// Se actualiza la dw de modificaciones oculta
idw_modificacion_datos.setitem(fila,'id_colegiado',colegiado)
idw_modificacion_datos.setitem(fila,'modificacion',modificacion)
idw_modificacion_datos.setitem(fila,'fecha',datetime(today(),now()))
idw_modificacion_datos.setitem(fila,'usuario',g_usuario)

g_recien_grabado_modificacion=FALSE

end event

event dw_1::csd_retrieve;call super::csd_retrieve;if g_musaat_consulta.id_musaat = '' or isnull(g_musaat_consulta.id_musaat) then return
int retorno
retorno = parent.event closequery()
if retorno = 1 then return
this.Retrieve(g_musaat_consulta.id_musaat)
g_musaat_consulta.id_musaat=''

datawindowchild  ldwc_src_cober
string src_cia

src_cia = idw_src.GetItemString(1,'src_cia')
idw_src.getchild("src_cober", ldwc_src_cober)	
ldwc_src_cober.settransobject(sqlca)
ldwc_src_cober.retrieve(src_cia)



end event

event dw_1::buttonclicked;call super::buttonclicked;string id_colegiado

// Modificacion de Datos
dw_1.event csd_modificacion_datos(dw_1.getitemstring(dw_1.getrow(),'id_musaat'), this, 'DETALLE', 'id_col', row)

choose case dwo.name
	case 'cb_busqueda_colegiados'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		
		id_colegiado=f_busqueda_colegiados()
		
		if not f_es_vacio(id_colegiado) then 
			this.setitem(row,'id_col',id_colegiado)
			if idw_otros_seguros_src.RowCount() > 0 then idw_otros_seguros_src.setitem(1, 'id_colegiado', id_colegiado)
		end if	
end choose

end event

event dw_1::itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_musaat'), this, 'DETALLE', dwo.name, row)

choose case dwo.name
	case 'n_mutualista'
		if not isnumber(data) or PosA(data, '.')>0 or PosA(data,',')>0 then
			MessageBox(g_idioma.of_getmsg('msg_musaat.error_intro_dato','Error de introducci$$HEX1$$f300$$ENDHEX$$n de dato'),g_idioma.of_getmsg('msg_musaat.n_mutualista_numero', 'El N$$HEX2$$ba002000$$ENDHEX$$de mutualista ha de ser un n$$HEX1$$fa00$$ENDHEX$$mero (sin puntos ni comas)'))
			return 1
		end if
		
	case else
end choose

end event

event dw_1::itemerror;call super::itemerror;return 1
end event

event dw_1::retrieveend;call super::retrieveend;i_nuevo = false
idw_modificacion_datos.Retrieve( dw_1.GetItemString(1,'id_musaat'), '04')
g_recien_grabado_modificacion=TRUE

end event

type tab_1 from tab within w_musaat_detalle
integer y = 544
integer width = 4169
integer height = 1376
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
tabpage_11 tabpage_11
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_7 tabpage_7
tabpage_4 tabpage_4
tabpage_10 tabpage_10
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_8 tabpage_8
tabpage_9 tabpage_9
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_11=create tabpage_11
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_7=create tabpage_7
this.tabpage_4=create tabpage_4
this.tabpage_10=create tabpage_10
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_8=create tabpage_8
this.tabpage_9=create tabpage_9
this.Control[]={this.tabpage_1,&
this.tabpage_11,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_7,&
this.tabpage_4,&
this.tabpage_10,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_8,&
this.tabpage_9}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_11)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_7)
destroy(this.tabpage_4)
destroy(this.tabpage_10)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_8)
destroy(this.tabpage_9)
end on

type tabpage_1 from userobject within tab_1
string tag = "texto=musaat.seguro_responsabilidad_civil"
integer x = 18
integer y = 100
integer width = 4133
integer height = 1260
long backcolor = 79741120
string text = "Seguro de Responsabilidad Civil MUSAAT"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_src dw_src
end type

on tabpage_1.create
this.dw_src=create dw_src
this.Control[]={this.dw_src}
end on

on tabpage_1.destroy
destroy(this.dw_src)
end on

type dw_src from u_dw within tabpage_1
event csd_calendario ( )
integer x = 18
integer y = 20
integer width = 3035
integer height = 1184
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_musaat_src"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event csd_calendario;this.of_SetDropDownCalendar(true)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateformat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(false)
end event

event pfc_addrow;call super::pfc_addrow;datawindowchild  ldwc_src_cober
string src_cia
this.setitem(1, 'src_estado', '00')
this.setitem(1, 'src_cober', '00')

src_cia = this.GetItemString(1,'src_cia')
this.getchild("src_cober", ldwc_src_cober)	
ldwc_src_cober.settransobject(sqlca)
ldwc_src_cober.retrieve(src_cia)

return ancestorreturnvalue
end event

event pfc_insertrow;call super::pfc_insertrow;this.setitem(1, 'src_estado', '00')
this.setitem(1, 'src_cober', '00')
return ancestorreturnvalue
end event

event itemchanged;call super::itemchanged;datawindowchild  ldwc_src_cober
int fila, i
string codigo,ls_null
datetime fecha
double src_coef_cm
setnull(ls_null)
// Modificacion de Datos
dw_1.event csd_modificacion_datos(dw_1.getitemstring(dw_1.getrow(),'id_musaat'), this, Upper(Parent.text), dwo.name, row)

CHOOSE CASE dwo.name
	CASE 'src_alta'
		choose case data
			case 'S'
				this.setitem(1, 'src_f_alta', datetime(today(), now()))
				this.setitem(1, 'src_cia', 'MU')
				
				this.getchild("src_cober", ldwc_src_cober)	
				ldwc_src_cober.settransobject(sqlca)
				this.setitem(1,'src_cober',ls_null)
				ldwc_src_cober.retrieve('MU')			
				
			case 'N'	
				if IsNull(this.GetItemDateTime(1,'src_f_baja')) then
					this.setitem(1, 'src_f_baja', datetime(today(), now()))
				end if
				this.setitem(1, 'exceso', 'N')	
				this.setitem(1, 'src_cia', 'NT')
				
			case 'O'
				this.setitem(1, 'src_cia', '')
				this.setitem(1,'src_cober',ls_null)
		end choose
	
	CASE 'src_cober'
		 codigo=data
		 fila = 0
		 // Modificaci$$HEX1$$f300$$ENDHEX$$n Paco 21/06/2007
		 // comprobar si ya existe la fecha de hoy
		 for i = 1 to idw_coberturas.rowcount()
			fecha = idw_coberturas.getitemdatetime(i, 'fecha')
			if date(fecha) = today() then
				fila = i
				exit
			end if
		 next
		 
		 if fila <= 0 then
			idw_coberturas.triggerevent("pfc_addrow")
			fila =idw_coberturas.rowcount()
		end if
		
		idw_coberturas.setitem(fila,'id_colegiado',dw_1.getitemstring(this.getrow(),'id_col'))
		idw_coberturas.setitem(fila,'codigo',codigo)
		idw_coberturas.setitem(fila,'src_coef_cm', idw_src.getitemnumber(1, 'src_coef_cm'))		
		//En el campo fecha se pone la de hoy con la hora
		idw_coberturas.setitem(fila,'fecha',datetime(today(),now()))
		
		idw_coberturas.sort()
		
		// I3888 Quieren este aviso
		if g_colegio = 'COAATGC' then messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.comunicar_dpto_visado', "Comunicar al Dpto. de Visado"), information!)
		
		ib_recalculo = true // Despu$$HEX1$$e900$$ENDHEX$$s de grabar recalcularemos los avisos pendientes
		
	CASE 'src_n_poliza'
		if not isnumber(data) or PosA(data, '.')>0 or PosA(data,',')>0 then
			MessageBox(g_idioma.of_getmsg('msg_musaat.error_intro_dato','Error de introducci$$HEX1$$f300$$ENDHEX$$n de dato'),g_idioma.of_getmsg('msg_musaat.n_poliza_numero', 'El N$$HEX2$$ba002000$$ENDHEX$$de p$$HEX1$$f300$$ENDHEX$$liza SRC ha de ser un n$$HEX1$$fa00$$ENDHEX$$mero (sin puntos ni comas)'))
			return 1
		end if
		
	CASE 'src_coef_cm'
		src_coef_cm=double(data)
		fila = 0
		// Modificaci$$HEX1$$f300$$ENDHEX$$n Paco 21/06/2007
		// comprobar si ya existe la fecha de hoy
		for i = 1 to idw_coberturas.rowcount()
			fecha = idw_coberturas.getitemdatetime(i, 'fecha')
			if date(fecha) = today() then
				fila = i
				exit
			end if
		next
		
		if fila <= 0 then
			idw_coberturas.triggerevent("pfc_addrow")
			fila =idw_coberturas.rowcount()
		end if
		
		idw_coberturas.setitem(fila,'id_colegiado',dw_1.getitemstring(this.getrow(),'id_col'))
		idw_coberturas.setitem(fila,'codigo',idw_src.getitemstring(1, 'src_cober'))
		idw_coberturas.setitem(fila,'src_coef_cm', src_coef_cm)		
		//En el campo fecha se pone la de hoy con la hora
		idw_coberturas.setitem(fila,'fecha',datetime(today(),now()))
		
		idw_coberturas.sort()
		
		// I3888 Quieren este aviso
		if g_colegio = 'COAATGC' then messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.comunicar_dpto_visado', "Comunicar al Dpto. de Visado"), information!)

		ib_recalculo = true // Despu$$HEX1$$e900$$ENDHEX$$s de grabar recalcularemos los avisos pendientes
		
	CASE 'src_cia'	
		this.getchild("src_cober", ldwc_src_cober)	
		ldwc_src_cober.settransobject(sqlca)
		this.setitem(1,'src_cober',ls_null)
		ldwc_src_cober.retrieve(data)
	CASE 'src_t_poliza'	
		this.setitem(1,'src_cober',ls_null)
		
END CHOOSE

end event

event itemerror;call super::itemerror;return 1
end event

event clicked;call super::clicked;string t_poliza

// Filtramos las coberturas seg$$HEX1$$fa00$$ENDHEX$$n el tipo de poliza
CHOOSE CASE dwo.name
	CASE 'src_cober'
		t_poliza = this.getitemstring(1, 'src_t_poliza')
		if isnull(t_poliza) then t_poliza = ''
		DataWindowChild dwc_cober_src
		this.GetChild('src_cober', dwc_cober_src)
		dwc_cober_src.setfilter("t_poliza = '" + t_poliza + "'")		
		dwc_cober_src.filter()
END CHOOSE

end event

type tabpage_11 from userobject within tab_1
string tag = "Otros Seguros de Responsabilidad Civil"
integer x = 18
integer y = 100
integer width = 4133
integer height = 1260
long backcolor = 79741120
string text = "Otros Seguros de Responsabilidad Civil"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_otros_seguros_src dw_otros_seguros_src
end type

on tabpage_11.create
this.dw_otros_seguros_src=create dw_otros_seguros_src
this.Control[]={this.dw_otros_seguros_src}
end on

on tabpage_11.destroy
destroy(this.dw_otros_seguros_src)
end on

type dw_otros_seguros_src from u_dw within tabpage_11
event csd_calendario ( )
integer x = 9
integer y = 20
integer width = 3058
integer height = 1212
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_otros_src_colegiados"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event csd_calendario;this.of_SetDropDownCalendar(true)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateformat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(false)
end event

event itemchanged;call super::itemchanged;if dwo.name = 'alta' then
		choose case data
			case 'S'
				this.setitem(1, 'f_alta', datetime(today(), now()))
							
			case 'N'	
				if IsNull(this.GetItemDateTime(1,'f_baja')) then
					this.setitem(1, 'f_baja', datetime(today(), now()))
				end if
			
		end choose
	
end if		


end event

event itemerror;call super::itemerror;return 1
end event

event pfc_insertrow;call super::pfc_insertrow;
this.SetItem(dw_1.GetRow(),'id_src_colegiado',f_siguiente_numero('ID_SRC_COLEGIADOS',10))

return ancestorreturnvalue
end event

event pfc_addrow;call super::pfc_addrow;
this.SetItem(dw_1.GetRow(),'id_src_colegiado',f_siguiente_numero('ID_SRC_COLEGIADOS',10))

return ancestorreturnvalue
end event

type tabpage_2 from userobject within tab_1
string tag = "texto=musaat.seguro_accidentes"
integer x = 18
integer y = 100
integer width = 4133
integer height = 1260
long backcolor = 79741120
string text = "Seguro de Accidentes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_accidentes dw_accidentes
end type

on tabpage_2.create
this.dw_accidentes=create dw_accidentes
this.Control[]={this.dw_accidentes}
end on

on tabpage_2.destroy
destroy(this.dw_accidentes)
end on

type dw_accidentes from u_dw within tabpage_2
event csd_calendario ( )
integer x = 18
integer y = 20
integer width = 3035
integer height = 1184
integer taborder = 11
string dataobject = "d_musaat_accidentes"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event csd_calendario;this.of_SetDropDownCalendar(true)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateformat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(false)
end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(dw_1.getitemstring(dw_1.getrow(),'id_musaat'), this, Upper(Parent.text), dwo.name, row)

choose case dwo.name
	case 'accidentes_alta'
		if data = 'S' then
			this.setitem(1, 'accidentes_f_alta', datetime(today(), now()))
		else
			this.setitem(1, 'accidentes_f_baja', datetime(today(), now()))			
		end if
	case 'accidentes_n_poliza'

		if not isnumber(data) or PosA(data, '.')>0 or PosA(data,',')>0 then
			MessageBox(g_idioma.of_getmsg('msg_musaat.error_intro_dato','Error de introducci$$HEX1$$f300$$ENDHEX$$n de dato'), g_idioma.of_getmsg('msg_musaat.n_poliza_accidentes_numero','El N$$HEX2$$ba002000$$ENDHEX$$de p$$HEX1$$f300$$ENDHEX$$liza Accidentes ha de ser un n$$HEX1$$fa00$$ENDHEX$$mero (sin puntos ni comas)'))
			return 1
		end if
		
	case else		
end choose
end event

event itemerror;call super::itemerror;return 1
end event

type tabpage_3 from userobject within tab_1
string tag = "texto=musaat.seguro_tasaciones"
integer x = 18
integer y = 100
integer width = 4133
integer height = 1260
long backcolor = 79741120
string text = "Seguro de Tasaciones"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_tasadores dw_tasadores
end type

on tabpage_3.create
this.dw_tasadores=create dw_tasadores
this.Control[]={this.dw_tasadores}
end on

on tabpage_3.destroy
destroy(this.dw_tasadores)
end on

type dw_tasadores from u_dw within tabpage_3
event csd_calendario ( )
integer x = 18
integer y = 20
integer width = 3035
integer height = 1184
integer taborder = 11
string dataobject = "d_musaat_tasadores"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event csd_calendario;this.of_SetDropDownCalendar(true)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateformat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(false)
end event

event pfc_addrow;call super::pfc_addrow;this.setitem(1, 'tasadores_cober', '00')
return ancestorreturnvalue
end event

event pfc_insertrow;call super::pfc_insertrow;this.setitem(1, 'tasadores_cober', '00')
return ancestorreturnvalue
end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(dw_1.getitemstring(dw_1.getrow(),'id_musaat'), this, Upper(Parent.text), dwo.name, row)

choose case dwo.name
	case 'tasadores_alta'
		if data = 'S' then
			this.setitem(1, 'tasadores_f_alta', datetime(today(), now()))
		else
			this.setitem(1, 'tasadores_f_baja', datetime(today(), now()))			
		end if
	case 'tasadores_n_poliza'

		if not isnumber(data) or PosA(data, '.')>0 or PosA(data,',')>0 then
			MessageBox(g_idioma.of_getmsg('msg_musaat.error_intro_dato','Error de introducci$$HEX1$$f300$$ENDHEX$$n de dato'), g_idioma.of_getmsg('msg_musaat.n_poliza_tasaciones','El N$$HEX2$$ba002000$$ENDHEX$$de p$$HEX1$$f300$$ENDHEX$$liza Tasaciones ha de ser un n$$HEX1$$fa00$$ENDHEX$$mero (sin puntos ni comas)'))
			return 1
		end if
		
	case else			
end choose
end event

event itemerror;call super::itemerror;return 1
end event

type tabpage_7 from userobject within tab_1
string tag = "texto=musaat.seguro_peritos"
integer x = 18
integer y = 100
integer width = 4133
integer height = 1260
long backcolor = 79741120
string text = "Seguro Peritos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_peritos dw_peritos
end type

on tabpage_7.create
this.dw_peritos=create dw_peritos
this.Control[]={this.dw_peritos}
end on

on tabpage_7.destroy
destroy(this.dw_peritos)
end on

type dw_peritos from u_dw within tabpage_7
event csd_calendario ( )
integer x = 18
integer y = 20
integer width = 3035
integer height = 1184
integer taborder = 11
string dataobject = "d_musaat_peritos"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event csd_calendario;this.of_SetDropDownCalendar(true)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateformat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(false)
end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(dw_1.getitemstring(dw_1.getrow(),'id_musaat'), this, Upper(Parent.text), dwo.name, row)

choose case dwo.name
	case 'peritos_alta'
		if data = 'S' then
			this.setitem(1, 'peritos_f_alta', datetime(today(), now()))
		else
			this.setitem(1, 'peritos_f_baja', datetime(today(), now()))			
		end if
	case 'peritos_n_poliza'

		if not isnumber(data) or PosA(data, '.')>0 or PosA(data,',')>0 then
			MessageBox(g_idioma.of_getmsg('msg_musaat.error_intro_dato','Error de introducci$$HEX1$$f300$$ENDHEX$$n de dato'), g_idioma.of_getmsg('msg_musaat.n_poliza_peritos','El N$$HEX2$$ba002000$$ENDHEX$$de p$$HEX1$$f300$$ENDHEX$$liza Peritos ha de ser un n$$HEX1$$fa00$$ENDHEX$$mero (sin puntos ni comas)'))
			return 1
		end if
		
	case else				
end choose
end event

event pfc_addrow;call super::pfc_addrow;this.setitem(1, 'peritos_cober', '00')
return ancestorreturnvalue
end event

event pfc_insertrow;call super::pfc_insertrow;this.setitem(1, 'peritos_cober', '00')
return ancestorreturnvalue
end event

event itemerror;call super::itemerror;return 1
end event

type tabpage_4 from userobject within tab_1
string tag = "texto=musaat.conceptos_domiciliables"
integer x = 18
integer y = 100
integer width = 4133
integer height = 1260
long backcolor = 79741120
string text = "Conceptos Domiciliables"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_domiciliaciones dw_domiciliaciones
end type

on tabpage_4.create
this.dw_domiciliaciones=create dw_domiciliaciones
this.Control[]={this.dw_domiciliaciones}
end on

on tabpage_4.destroy
destroy(this.dw_domiciliaciones)
end on

type dw_domiciliaciones from u_dw within tabpage_4
integer x = -18
integer y = -4
integer width = 4096
integer height = 1184
integer taborder = 21
string dataobject = "d_musaat_conceptos_domiciliables"
end type

event itemchanged;call super::itemchanged;integer f
string cod,des,emp

// Modificacion de Datos
dw_1.event csd_modificacion_datos(dw_1.getitemstring(dw_1.getrow(),'id_musaat'), this, Upper(Parent.text), dwo.name, row)

choose case dwo.name
	case 'concepto'
		for f=1 to this.rowcount()
			if f <> row and this.getitemstring(f,'concepto') = data then
				MessageBox(g_titulo,g_idioma.of_getmsg('msg_musaat.no_duplicar_conceptos','No se pueden duplicar conceptos.'))
				this.setitem(row,'concepto','')
				this.setitem(row,'empresa','')
				return 1
			end if
		next
		
		double importe
		select importe, empresa into :importe, :emp from csi_articulos_servicios where codigo = :data and empresa=:g_empresa;
		this.SetItem(row,'importe',importe)
		this.SetItem(row,'empresa',emp)
		
end choose

end event

event retrieveend;call super::retrieveend;// MODIFICADO RICARDO 04-09-14
// Cuando carguemos la DW, para todas aquellas filas que no tengan valor les colocamos el valor del check a 'N'
long fila
this.setfilter("empresa='"+g_empresa+"'")
this.filter()
for fila = 1 to this.rowcount()	
	if f_es_vacio(this.GetItemString(fila, 'es_extra')) then this.SetItem(fila, 'es_extra', 'N')
next
// Grabamos la dw, de esta forma el usuario no se entera que estamos tocando el campo
this.update()
// FIN MODIFICADO RICARDO 04-09-14   

end event

type tabpage_10 from userobject within tab_1
string tag = "texto=musaat.otros_seguros_cuotas"
integer x = 18
integer y = 100
integer width = 4133
integer height = 1260
long backcolor = 79741120
string text = "Otros Seguros / Cuotas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
pb_2 pb_2
dw_otros_seguros dw_otros_seguros
end type

on tabpage_10.create
this.pb_2=create pb_2
this.dw_otros_seguros=create dw_otros_seguros
this.Control[]={this.pb_2,&
this.dw_otros_seguros}
end on

on tabpage_10.destroy
destroy(this.pb_2)
destroy(this.dw_otros_seguros)
end on

type pb_2 from picturebutton within tabpage_10
string tag = "texto=musaat.importar_cuotas"
integer x = 3675
integer y = 28
integer width = 279
integer height = 168
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Importar Cuotas"
boolean originalsize = true
vtextalign vtextalign = multiline!
end type

type dw_otros_seguros from u_dw within tabpage_10
integer x = -18
integer y = -4
integer width = 3657
integer height = 1184
integer taborder = 31
string dataobject = "d_musaat_conceptos_domiciliables_otros_seg"
end type

event itemchanged;call super::itemchanged;integer f
string cod,des,emp

// Modificacion de Datos
dw_1.event csd_modificacion_datos(dw_1.getitemstring(dw_1.getrow(),'id_musaat'), this, Upper(Parent.text), dwo.name, row)

choose case dwo.name
	case 'concepto'
		for f=1 to this.rowcount()
			if f <> row and this.getitemstring(f,'concepto') = data then
				MessageBox(g_titulo,g_idioma.of_getmsg('msg_musaat.no_duplicar_conceptos','No se pueden duplicar conceptos.'))
				this.setitem(row,'concepto','')
				this.setitem(row,'empresa','')
				return 1
			end if
		next
		
		double importe
		select importe, empresa into :importe, :emp from csi_articulos_servicios where codigo = :data;
		this.SetItem(row,'importe',importe)
		this.SetItem(row,'empresa',emp)
end choose

end event

event retrieveend;call super::retrieveend;// MODIFICADO RICARDO 04-09-14
// Cuando carguemos la DW, para todas aquellas filas que no tengan valor les colocamos el valor del check a 'N'
long fila
this.setfilter("empresa='"+g_empresa+"'")
this.filter()
for fila = 1 to this.rowcount()
	if f_es_vacio(this.GetItemString(fila, 'es_extra')) then this.SetItem(fila, 'es_extra', 'N')
next
// Grabamos la dw, de esta forma el usuario no se entera que estamos tocando el campo
this.update()
// FIN MODIFICADO RICARDO 04-09-14   
end event

type tabpage_5 from userobject within tab_1
string tag = "texto=musaat.historico_movimientos_src"
integer x = 18
integer y = 100
integer width = 4133
integer height = 1260
long backcolor = 79741120
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico Movimientos SRC"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_movimientos dw_movimientos
end type

on tabpage_5.create
this.dw_movimientos=create dw_movimientos
this.Control[]={this.dw_movimientos}
end on

on tabpage_5.destroy
destroy(this.dw_movimientos)
end on

type dw_movimientos from u_dw within tabpage_5
integer x = 18
integer y = 20
integer width = 3433
integer height = 1184
integer taborder = 11
string dataobject = "d_musaat_movimientos_colegiado"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type tabpage_6 from userobject within tab_1
string tag = "texto=musaat.historico_coberturas_src"
integer x = 18
integer y = 100
integer width = 4133
integer height = 1260
long backcolor = 79741120
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico Coberturas SRC"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_coberturas dw_coberturas
end type

on tabpage_6.create
this.dw_coberturas=create dw_coberturas
this.Control[]={this.dw_coberturas}
end on

on tabpage_6.destroy
destroy(this.dw_coberturas)
end on

type dw_coberturas from u_dw within tabpage_6
integer x = 18
integer y = 20
integer width = 3433
integer height = 1184
integer taborder = 11
string dataobject = "d_musaat_coberturas"
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event doubleclicked;string obser_situacion, data_item
g_busqueda.solo_despliega_texto=False

CHOOSE CASE dwo.name
	CASE 'observaciones'
		g_busqueda.titulo="Observaciones"
		obser_situacion=this.GetItemString(row, 'observaciones')
		data_item      =this.getitemstring(row, 'observaciones') // para control modificaciones
		openwithparm(w_observaciones, obser_situacion)
		if Message.Stringparm <> '-1' then
			obser_situacion = Message.Stringparm
			if not isnull(obser_situacion) then 
//				if data_item<>obser_situacion then dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_colegiado'), this, Upper(Parent.text), 'observaciones', row)				
				this.SetItem(row,'observaciones',obser_situacion)
			end if
		end if

END CHOOSE
end event

event pfc_addrow;call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(ancestorreturnvalue, 'id_cobertura', f_siguiente_numero('ID_COBERTURAS', 10))
//donde "n" es un entero que indica la longitud en caracteres del contador
return ancestorreturnvalue
end event

event pfc_insertrow;call super::pfc_insertrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(ancestorreturnvalue, 'id_cobertura', f_siguiente_numero('ID_COBERTURAS', 10))
//donde "n" es un entero que indica la longitud en caracteres del contador
return ancestorreturnvalue
end event

type tabpage_8 from userobject within tab_1
string tag = "texto=musaat.otros"
integer x = 18
integer y = 100
integer width = 4133
integer height = 1260
long backcolor = 79741120
string text = "Otros"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
pb_1 pb_1
dw_otros dw_otros
end type

on tabpage_8.create
this.pb_1=create pb_1
this.dw_otros=create dw_otros
this.Control[]={this.pb_1,&
this.dw_otros}
end on

on tabpage_8.destroy
destroy(this.pb_1)
destroy(this.dw_otros)
end on

type pb_1 from picturebutton within tabpage_8
string tag = "texto=musaat.datos_historicos"
integer x = 2834
integer y = 52
integer width = 279
integer height = 168
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Datos Hist$$HEX1$$f300$$ENDHEX$$ricos"
boolean originalsize = true
vtextalign vtextalign = multiline!
end type

event clicked;openwithparm(w_historico, dw_1.getitemstring(1,'id_musaat')+"04")
end event

type dw_otros from u_dw within tabpage_8
integer x = 18
integer y = 20
integer width = 2816
integer height = 1184
integer taborder = 21
string dataobject = "d_musaat_otros"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(dw_1.getitemstring(dw_1.getrow(),'id_musaat'), this, Upper(Parent.text), dwo.name, row)
end event

event constructor;call super::constructor;this.of_setresize(true)


end event

type tabpage_9 from userobject within tab_1
string tag = "texto=musaat.historicos"
boolean visible = false
integer x = 18
integer y = 100
integer width = 4133
integer height = 1260
long backcolor = 79741120
string text = "Hist$$HEX1$$f300$$ENDHEX$$ricos"
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_modificacion_datos dw_modificacion_datos
end type

on tabpage_9.create
this.dw_modificacion_datos=create dw_modificacion_datos
this.Control[]={this.dw_modificacion_datos}
end on

on tabpage_9.destroy
destroy(this.dw_modificacion_datos)
end on

type dw_modificacion_datos from u_dw within tabpage_9
integer x = 18
integer y = 24
integer width = 2990
integer height = 968
integer taborder = 21
string dataobject = "d_historico"
end type

event type long pfc_addrow();call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.rowcount(), 'id_modificacion', f_siguiente_numero('MODIFICACIONES', 10))
this.setitem(this.rowcount(), 'id_colegiado', dw_1.GetItemString(1,'id_musaat') )
this.setitem(this.rowcount(), 'tipo_modulo', '04')
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

