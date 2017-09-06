HA$PBExportHeader$w_colegiados_factura_n.srw
forward
global type w_colegiados_factura_n from w_response
end type
type dw_lista from u_dw within w_colegiados_factura_n
end type
type cb_domiciliaciones from commandbutton within w_colegiados_factura_n
end type
type cb_2 from commandbutton within w_colegiados_factura_n
end type
type cb_1 from commandbutton within w_colegiados_factura_n
end type
type dw_1 from u_dw within w_colegiados_factura_n
end type
type st_1 from statictext within w_colegiados_factura_n
end type
type dw_2 from u_dw within w_colegiados_factura_n
end type
end forward

global type w_colegiados_factura_n from w_response
integer width = 4558
integer height = 1756
string title = "Generaci$$HEX1$$f300$$ENDHEX$$n Masiva de Facturas"
event csd_generar_linea_cobro_domiciliable ( string id_factura )
event csd_borrar_conceptos_domiciliables_extra ( string id_factura,  string id_colegiado )
dw_lista dw_lista
cb_domiciliaciones cb_domiciliaciones
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
st_1 st_1
dw_2 dw_2
end type
global w_colegiados_factura_n w_colegiados_factura_n

type variables
datastore i_ds_domiciliaciones, ids_colegiados_conceptos_domic_exta_factur
string i_lista_no_validos,i_banco
string i_col_cli

end variables

forward prototypes
public function integer f_subvencion_coleg (string id_factura)
public function integer f_subvencion_sin_musaat (string id_factura)
public function boolean wf_subvencion_coaatgc (string id_colegiado, date fecha)
public function boolean wf_subvencion_coaatmca (string id_colegiado, date fecha)
end prototypes

event csd_generar_linea_cobro_domiciliable(string id_factura);string id_pago, forma_pago, pagado, n_talon, banco, cuenta, centro, proyecto, cta_presupuestaria
string contabilizado, cuenta_gastos, n_remesa, n_fact, id_persona, n_col  
datetime f_pago, f_vencimiento, f_contabilizado
double importe, importe_gastos
int fila

SELECT id_pago,id_factura,forma_pago,importe,f_pago,pagado,f_vencimiento,n_talon,banco,cuenta,centro,proyecto,
		 cta_presupuestaria,contabilizado,f_contabilizado,importe_gastos,cuenta_gastos,n_remesa  
INTO :id_pago,:id_factura,:forma_pago,:importe,:f_pago,:pagado,:f_vencimiento,:n_talon,:banco,:cuenta,:centro,
	  :proyecto,:cta_presupuestaria,:contabilizado,:f_contabilizado,:importe_gastos,
	  :cuenta_gastos,:n_remesa  
FROM csi_cobros where id_factura = :id_factura;
	 
	 
select n_fact,id_persona,n_col into :n_fact,:id_persona,:n_col from csi_facturas_emitidas where id_factura=:id_factura;
//Insertamos una linea en el dw externo para luego emitir domiciliaciones en caso de que se desee...
fila = dw_lista.InsertRow(0)

dw_lista.SetItem(fila,'id_pago',id_pago)
dw_lista.SetItem(fila,'n_fact',n_fact)
dw_lista.SetItem(fila,'id_persona',id_persona)
dw_lista.SetItem(fila,'id_factura',id_factura)
dw_lista.SetItem(fila,'forma_pago',forma_pago)
dw_lista.SetItem(fila,'importe',importe)
dw_lista.SetItem(fila,'f_pago',f_pago)
dw_lista.SetItem(fila,'pagado',pagado)
dw_lista.SetItem(fila,'f_vencimiento',f_vencimiento)
dw_lista.SetItem(fila,'n_talon',n_talon)
dw_lista.SetItem(fila,'banco',banco)
dw_lista.SetItem(fila,'cuenta',cuenta)
dw_lista.SetItem(fila,'centro',centro)
dw_lista.SetItem(fila,'proyecto',proyecto)
dw_lista.SetItem(fila,'contabilizado',contabilizado)
dw_lista.SetItem(fila,'f_contabilizado',f_contabilizado)
dw_lista.SetItem(fila,'importe_gastos',importe)
dw_lista.SetItem(fila,'cuenta_gastos',cuenta_gastos)
dw_lista.SetItem(fila,'n_remesa',n_remesa)
dw_lista.SetItem(fila,'n_col',n_col)



end event

event csd_borrar_conceptos_domiciliables_extra(string id_factura, string id_colegiado);// EVENTO QUE SE ENCARGAR$$HEX2$$c1002000$$ENDHEX$$DE MODIFICAR LOS CONCEPTOS DOMICILIABLES DE ESTE COLEGIADO DE FORMA QUE LOS QUE SEAN EXTRAS O
// UNICOS DESAPAREZCAN... 
long fila

if id_factura = '-1' then return 


if not isvalid(ids_colegiados_conceptos_domic_exta_factur) then
	ids_colegiados_conceptos_domic_exta_factur = create datastore
	ids_colegiados_conceptos_domic_exta_factur.dataobject = 'd_colegiados_conceptos_domic_exta_factur'
	ids_colegiados_conceptos_domic_exta_factur.settransobject(SQLCA)
end if

// Recuperamos para la factura indicada, y si no hay salimos
if ids_colegiados_conceptos_domic_exta_factur.retrieve(id_factura, id_colegiado)=0 then return

// Si hay borramos todas las filas del dastastore y grabamos
FOR fila = ids_colegiados_conceptos_domic_exta_factur.RowCount() TO 1 STEP -1
        ids_colegiados_conceptos_domic_exta_factur.deleterow(fila)
NEXT
if ids_colegiados_conceptos_domic_exta_factur.update()<>1 then
	Messagebox(g_titulo, "Error al intentar borrar los conceptos domiciliables extras colegiado "+f_colegiado_n_col(ids_colegiados_conceptos_domic_exta_factur.getitemstring(1, 'conceptos_domiciliables_id_colegiado')), stopsign!)
else
	// Confirmamos los cambios en BBDD
	commit;
end if

end event

public function integer f_subvencion_coleg (string id_factura);string linea, ls_factura
double importe

ls_factura = id_factura

select total into :importe from csi_facturas_emitidas where id_factura = :id_factura;

update csi_facturas_emitidas set total = 0, base_imp= 0, subtotal = 0 where id_factura = :id_factura;
update csi_cobros set importe = 0 where id_factura = :id_factura;

linea =f_siguiente_numero('LINEA_FEMI',10)

importe = importe * (-1)

insert into csi_lineas_fact_emitidas 
values (:ls_factura,:linea,'','',:importe,1,:importe,'110','00',0,:importe,0,0,'','','','','','','',null,'','SUBVENCI$$HEX2$$d3002000$$ENDHEX$$COL.LEGIAL',0,0,'');
//values (:ls_factura,:linea,'','SUBVENCI$$HEX2$$d3002000$$ENDHEX$$COL.LEGIAL',null,null,null,'110','',null,:importe,null,null,'','','','','','','',null,'','',null,null,'');

return 1

end function

public function integer f_subvencion_sin_musaat (string id_factura);string linea, ls_factura
double importe, subven_musaat

ls_factura = id_factura

select total into :importe from csi_facturas_emitidas where id_factura = :id_factura;

SELECT sum ( csi_lineas_fact_emitidas.total )  
INTO :subven_musaat
FROM csi_lineas_fact_emitidas,   
csi_articulos_servicios
WHERE ( csi_lineas_fact_emitidas.articulo = csi_articulos_servicios.codigo ) and  
( ( csi_lineas_fact_emitidas.id_factura = :id_factura ) AND  
( csi_articulos_servicios.familia <> '01' ))   ;

importe = round(importe - subven_musaat, 2)

//update csi_facturas_emitidas set total = :importe where id_factura = :id_factura;

update csi_facturas_emitidas set total = :importe, base_imp= :importe, subtotal = :importe where id_factura = :id_factura;
update csi_cobros set importe = :importe where id_factura = :id_factura;

linea = f_siguiente_numero('LINEA_FEMI',10)

importe = subven_musaat * (-1)

insert into csi_lineas_fact_emitidas 
values (:ls_factura,:linea,'','',:importe,1,:importe,'110','00',0,:importe,0,0,'','','','','','','',null,'','SUBVENCI$$HEX2$$d3002000$$ENDHEX$$COL.LEGIAL',0,0,'');

return 1

end function

public function boolean wf_subvencion_coaatgc (string id_colegiado, date fecha);// TIPO DE SUBVENCION:
// Los primeros 18 meses no paga cuota
// El resto de meses paga el precio que est$$HEX2$$e1002000$$ENDHEX$$estipulado (2009=54 Euros) 

datetime f_colegiacion, f_titulacion, f_alta
string 	alta_baja
boolean exento
long num_meses
  SELECT colegiados.f_titulacion,   colegiados.alta_baja,    colegiados.f_alta  
  INTO   :f_titulacion,   :alta_baja,   :f_alta  
  FROM colegiados  
  WHERE colegiados.id_colegiado = :id_colegiado and colegiados.t_alta = 'A3'  ;

if alta_baja = '' then 
	exento = false
else
	// MENOS DE 18 MESES DE ALTA EST$$HEX2$$c1002000$$ENDHEX$$EXENTO
	num_meses=(Month(fecha) - Month(date(f_alta))) + ((Year(fecha) - Year(date(f_alta))) * 12) 
	
	If  (Day(fecha) - Day(date(f_alta))) > 0 then num_meses++

	//MessageBox("NUMERO MESES",string(num_meses))
	
	if num_meses <=18 then 
		exento=true
	else
		exento= false
	end if
end if


return exento


end function

public function boolean wf_subvencion_coaatmca (string id_colegiado, date fecha);// TIPO DE SUBVENCION:
// Los primeros 12 meses no paga cuota
// El colegiado debe proceder de la escuela 

datetime f_colegiacion, f_titulacion
string 	alta_baja
boolean exento
long num_meses

  SELECT colegiados.f_colegiacion,   colegiados.alta_baja
  INTO   :f_colegiacion,   :alta_baja
  FROM colegiados  
  WHERE colegiados.id_colegiado = :id_colegiado and (colegiados.cons_procedencia= 'E' or colegiados.cons_procedencia= 'ESCUELA');

if alta_baja = '' then 
	exento = false
else
	// MENOS DE 18 MESES DE ALTA EST$$HEX2$$c1002000$$ENDHEX$$EXENTO
	num_meses=(Month(fecha) - Month(date(f_colegiacion))) + ((Year(fecha) - Year(date(f_colegiacion))) * 12) 
	
	If  (Day(fecha) - Day(date(f_colegiacion))) > 0 then num_meses++

	//MessageBox("NUMERO MESES",string(num_meses))
	
	if num_meses <=12 then 
		exento=true
	else
		exento= false
	end if
end if


return exento

end function

on w_colegiados_factura_n.create
int iCurrent
call super::create
this.dw_lista=create dw_lista
this.cb_domiciliaciones=create cb_domiciliaciones
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.st_1=create st_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_lista
this.Control[iCurrent+2]=this.cb_domiciliaciones
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_2
end on

on w_colegiados_factura_n.destroy
call super::destroy
destroy(this.dw_lista)
destroy(this.cb_domiciliaciones)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.dw_2)
end on

event open;call super::open;string centro,n_cuenta
datawindowchild dwc_t_inter

// Variable para saber si hemos llamado a la ventana desde colegiados o desde clientes("CLI")
i_col_cli = message.stringparm


dw_2.of_SetDropDownCalendar(True)
dw_2.iuo_calendar.of_register(dw_2.iuo_calendar.DDLB)
dw_2.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_2.iuo_calendar.of_SetInitialValue(True)
//mostramos solo los descuentos de la empresa que toque
dw_1.getchild("articulo",dwc_t_inter)
dwc_t_inter.SetTransObject(SQLCA)

dwc_t_inter.retrieve(g_empresa)

f_centrar_ventana(this) 
dw_1.SetTransObject(SQLCA)

dw_1.InsertRow(0)
dw_2.InsertRow(0)

centro = f_devuelve_centro(g_cod_delegacion)

if i_col_cli = 'CLI' then 
	dw_2.object.ordenar_t.visible = false
	dw_2.object.ordenar.visible = false
	dw_2.modify("incluir_todos.visible = '0'")
	dw_2.modify("ordenar.visible = '0'")
	dw_2.modify("ordenar_t.visible = '0'")
	// MODIFICADO RICARDO 04-09-14
	dw_2.object.borrar_extras.visible = false
	dw_2.setitem(1, 'borrar_extras', 'N')
	// FIN MODIFICADO RICARDO 04-09-14
end if
if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)


dw_2.SetItem(1,'fecha',datetime(Today()))
dw_2.SetItem(1,'formapago',g_formas_pago.defecto)
dw_2.SetItem(1,'formapago_mensual',g_formas_pago.defecto)
//SCP-1147. No se filtra por banco, puesto que las formas de pago no est$$HEX1$$e100$$ENDHEX$$n preparadas para multi-empresa
//dw_2.SetItem(1,'banco',g_banco_por_defecto)
dw_2.SetItem(1,'codigo',f_cobros_devuelve_ncontrol(g_banco_por_defecto))
dw_2.SetItem(1,'centro',centro)
dw_2.SetItem(1,'proyecto',g_explotacion_por_defecto)

cb_domiciliaciones.enabled=false

string todos

todos = dw_2.GetItemString(1,"incluir_todos")

// Indicamos que queremos cambiar el idioma
if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)

end event

event pfc_close();call super::pfc_close;// MODIFICADO RICARDO 04-09-14
// si el datastore de conceptos extras est$$HEX2$$e1002000$$ENDHEX$$creado lo destruimos
if isvalid(ids_colegiados_conceptos_domic_exta_factur) then destroy ids_colegiados_conceptos_domic_exta_factur
// FIN MODIFICADO RICARDO 04-09-14

end event

event csd_recuperar_consulta;// SOBREESCRITO

// Hay que limpiar el dw_1 para que no se mezclen los conceptos de las consultas guardadas.
dw_1.reset()

/////// INICIO csd_recuperar_consulta de w_response ///////

string ventana,id_consulta,valor_string,dw,tipo_columna,dw_ant='',ventana1
datetime valor_datetime
double valor_double
int i,j,col,fila,k,l
tab tab_actual
userobject tabpage_actual
datastore ds_datos_consulta
datawindow dw_actual,dw_aux
 
SetPointer(HourGlass!)
ds_datos_consulta = create datastore
ds_datos_consulta.dataobject = 'd_consultas_datos'
ds_datos_consulta.SetTransObject(SQLCA)

ventana = this.classname()
//Queremos quitar del nombre de la ventana la parte final (la que va despues del gui$$HEX1$$f300$$ENDHEX$$n)
//Para que nos recupere las consultas realizadas para w_xx_consulta y w_xx_listados 
if param<>'INICIO' then ventana = f_modulo_ventana(ventana)

if f_es_vacio(param) THEN
	OpenWithParm(w_consulta_seleccion,ventana) 
	id_consulta = Message.StringParm
else
	select id_consulta into :id_consulta from consultas where ventana like :ventana and descripcion=:param;
end if

if f_es_vacio(id_consulta) then return

//Recorremos todos los objetos de la ventana
for i = 1 to UpperBound(this.control[])
	//RESETEAMOS todos los dw por si alguno ten$$HEX1$$ed00$$ENDHEX$$a alg$$HEX1$$fa00$$ENDHEX$$n dato anterior
	if TypeOf(this.control[i])= Datawindow! then
		dw_actual = this.control[i]
		dw_actual.resetupdate()
	end if
	if TypeOf(this.control[i])= Tab! then
		tab_actual = this.control[i]
		//Recorremos todos los tabpages del TAB
		for j= 1 to UpperBound(tab_actual.control[])
			tabpage_actual = tab_actual.control[j]
			//En cada tabpage buscamos los DW que posee...
			for k=1 to UpperBound(tabpage_actual.control[])
				if TypeOf(tabpage_actual.control[k])=Datawindow! then
					dw_actual = tabpage_actual.control[k]
					dw_actual.resetupdate()
				end if
			next
		next
	end if
	
next

ds_datos_consulta.Retrieve(id_consulta)

for i= 1 to ds_datos_consulta.RowCount()
	dw = ds_datos_consulta.GetItemString(i,'datawindow')
	col = ds_datos_consulta.GetItemNumber(i,'columna')
	valor_double  = ds_datos_consulta.GetItemNumber(i,'valor_double')
	valor_datetime= ds_datos_consulta.GetItemDatetime(i,'valor_datetime')
	valor_string	= ds_datos_consulta.GetItemString(i,'valor_string')
	fila = ds_datos_consulta.GetItemNumber(i,'fila')
	if dw_ant <> dw then 
		SetNull(dw_actual)
		for j = 1 to UpperBound(this.control[])
			//Si es DW
			if TypeOf(this.control[j])= Datawindow! then
				dw_aux = this.control[j]
				if dw_aux.ClassName() = dw then dw_actual = dw_aux
			end if
			//Si es TAB
			if TypeOf(this.control[j])= Tab! then
			tab_actual = this.control[j]
			//Recorremos todos los tabpages del TAB
			for l= 1 to UpperBound(tab_actual.control[])
				tabpage_actual = tab_actual.control[l]
				//En cada tabpage buscamos los DW que posee...
				for k=1 to UpperBound(tabpage_actual.control[])
					if TypeOf(tabpage_actual.control[k])=Datawindow! then
						dw_aux = tabpage_actual.control[k]
						if dw_aux.ClassName() = dw then dw_actual = dw_aux
					end if
				next
			next
	end if
			
		next
	end if
	if IsNull(dw_actual) then continue
	tipo_columna = dw_actual.Describe('#'+string(col)+'.ColType')
	if dw_actual.rowcount()<fila then dw_actual.InsertRow(0)
	choose case tipo_columna
		case 'datetime'
			dw_actual.SetItem(fila,col,valor_datetime)
		case 'number'
			dw_actual.SetItem(fila,col,valor_double)
		case else
			dw_actual.SetItem(fila,col,valor_string)
	end choose
	dw_ant = dw
next
	
SetPointer(Arrow!)	

destroy ds_datos_consulta


/////// FIN csd_recuperar_consulta de w_response ///////

datetime f_nulo
setnull(f_nulo)

dw_2.setitem(1, 'fecha', f_nulo) //la fecha la borro, sino hay problemas en algunos coles pq no la cambian

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_colegiados_factura_n
boolean visible = true
integer x = 2999
integer y = 1572
integer height = 96
integer taborder = 80
string text = "Recuperar Pantalla"
end type

event cb_recuperar_pantalla::clicked;call super::clicked;dw_2.event itemchanged(1, dw_2.object.incluir_todos, dw_2.getitemstring(1, 'incluir_todos'))
end event

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_colegiados_factura_n
string tag = "texto=general.grabar_pantalla"
boolean visible = true
integer x = 2455
integer y = 1572
integer height = 96
integer taborder = 70
string text = "Grabar Pantalla"
end type

type dw_lista from u_dw within w_colegiados_factura_n
boolean visible = false
integer x = 3259
integer y = 1132
integer width = 238
integer height = 356
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_colegiados_lista_cobros_domiciliables"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type cb_domiciliaciones from commandbutton within w_colegiados_factura_n
string tag = "texto=general.generar_dom_fichero"
integer x = 503
integer y = 1572
integer width = 887
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Generar Domiciliaciones y fichero F19"
end type

event clicked;st_cobros_datos_pre_remesa datos

datos.dw_lista = dw_lista
if i_col_cli = 'CLI' then
	datos.modulo='CLIENTES'
else
	datos.modulo='COLEGIADOS'
end if

OpenWithParm(w_cobros_pre_remesa,datos)

end event

type cb_2 from commandbutton within w_colegiados_factura_n
string tag = "texto=general.salir"
integer x = 1408
integer y = 1572
integer width = 402
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;Closewithreturn(parent,-1)
end event

type cb_1 from commandbutton within w_colegiados_factura_n
string tag = "texto=general.generar_factura"
integer x = 37
integer y = 1572
integer width = 448
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generar &Facturas"
end type

event clicked;string id_factura, primera_fact, t_iva, msg18 = '', msg16 = '',msgemp='Los siguientes articulos no pertenecen a la empresa activa y no se incluir$$HEX1$$e100$$ENDHEX$$n: '+cr
double importe_cuota, porcent
int facturas_emitidas=0, retorno = 1
boolean factura_la_cuota=false,art_old=false
long fila
date fecha_factura
datetime fecha_inicio_validez,fecha_fin_validez
long lineas
if f_puedo_escribir(g_usuario,'0000000019')=-1 then return -1



if dw_1.AcceptText() <> 1 then return
if dw_2.AcceptText() <> 1 then return

SetPointer(Hourglass!)
long i, totalfilas
string id_col,mensaje=''
st_facturas datos_facturacion

datastore ds_lineas
ds_lineas = create datastore
ds_lineas.dataobject = dw_1.dataobject
// a$$HEX1$$f100$$ENDHEX$$adida validaci$$HEX1$$f300$$ENDHEX$$n de articulos para evitar que los cojan de listas antiguas y se generen
lineas=dw_1.rowcount( )
For fila = 1 to dw_1.rowcount( )
	//para consultas anteriores a corregurias el campo empresa es vacio, le asignamos la empresa 01
	if f_es_vacio(dw_1.GetItemString(fila,'empresa')) then dw_1.SetItem(fila,'empresa',f_obtener_empresa_nombre_corto('01'))
	//
	//IF dw_1.GetItemString(fila,'empresa')<>f_obtener_empresa_nombre_corto(g_empresa)  then
	IF dw_1.GetItemString(fila,'empresa')<>f_obtener_empresa_nombre_corto(g_empresa)  then
		art_old=true
		msgemp=msgemp+dw_1.GetItemString(fila,'articulo')+cr
		dw_1.deleterow(fila)
		fila=fila - 1
	else
	end if
NEXT
if art_old=true then 
	messagebox(g_titulo,msgemp)
end if	

if(dw_1.RowCount() = 0)then 
	Messagebox(g_titulo, 'Debe insertar conceptos para facturar')
	return
end if 


//Validacion Cambio IVA Julio 2010
	fecha_factura=date( dw_2.getitemdatetime(1,'fecha'))
	For fila = 1 to dw_1.rowcount( )
		
		t_iva = dw_1.GetItemString(fila,"t_iva")
		if(f_es_vacio(t_iva))then continue
		select f_inicio_validez,f_fin_validez,porcent into: fecha_inicio_validez,: fecha_fin_validez,:porcent from csi_t_iva where t_iva=:t_iva;
				
		if date(fecha_inicio_validez)>fecha_factura then
			msg18 = g_idioma.of_getmsg('factura_e.iva18','Los tipos de IVA al 18% y 8% s$$HEX1$$f300$$ENDHEX$$lo son v$$HEX1$$e100$$ENDHEX$$lidos para fechas posteriores al ')+' '+string(date(fecha_inicio_validez))+'. '+ g_idioma.of_getmsg('factura_e.continuar','$$HEX1$$bf00$$ENDHEX$$Desea continuar?')
		elseif date(fecha_fin_validez)<fecha_factura then
			msg16 = g_idioma.of_getmsg('factura_e.iva16','Los tipos de IVA al 16% y 7% s$$HEX1$$f300$$ENDHEX$$lo son v$$HEX1$$e100$$ENDHEX$$lidos para fechas anteriores al') +' '+ string(date(fecha_fin_validez)) +'. '+ g_idioma.of_getmsg('factura_e.continuar','$$HEX1$$bf00$$ENDHEX$$Desea continuar?')
		end if
	next	
	if not(f_es_vacio(msg18))then
		retorno = messagebox(g_titulo,msg18,Exclamation!, YesNo!,1)
		if(retorno=2) then 
			return 
		end if
	end if
	if not(f_es_vacio(msg16))then
		retorno = messagebox(g_titulo,msg16,Exclamation!, YesNo!,1)
		if(retorno=2) then 
			return 
		end if
	end if
//fin cambio

//Modificado Jesus 09-12-09
//Se muestra la ventana de los 4 checks para permitir elegir el envio por email o la impresion por papel. CLE-78
if (g_colegio = 'COAATLE') then
	n_csd_impresion_formato l_uo_impresion_formato
	l_uo_impresion_formato = create n_csd_impresion_formato
	
	l_uo_impresion_formato.pdf = g_formato_impresion_visared.pdf
	l_uo_impresion_formato.papel = g_formato_impresion_visared.papel
	l_uo_impresion_formato.email = g_formato_impresion_visared.email	
	l_uo_impresion_formato.masivo = true

	if l_uo_impresion_formato.f_opciones_impresion()<> 1 then return
end if
//Fin modificaci$$HEX1$$f300$$ENDHEX$$n


ds_lineas.object.data = dw_1.object.data

dw_lista.Reset()

for i= 1 to dw_1.RowCount()
	if f_es_vacio(dw_1.GetItemString(i,'articulo')) then mensaje +=g_idioma.of_getmsg('colegiados.valor_concepto','Debe especificar un valor para el Concepto.')+'  (linea '+string(i)+')'+cr
	if f_es_vacio(dw_1.GetItemString(i,'t_iva')) then mensaje +=g_idioma.of_getmsg('colegiados.valor_tipo_impuestos','Debe especificar un valor para el Tipo de Impuestos.')+'  (linea '+string(i)+')'+cr
	if isnull(dw_1.GetItemNumber(i,'total')) then mensaje +=g_idioma.of_getmsg('colegiados.valor_total_linea','Debe especificar un valor para el Total de la l$$HEX1$$ed00$$ENDHEX$$nea.')+'  (linea '+string(i)+')'+cr
	if isnull(dw_1.GetItemNumber(i,'subtotal')) then mensaje +=g_idioma.of_getmsg('colegiados.valor_importe','Debe especificar un valor para el Importe.')+'  (linea '+string(i)+')'+cr
next
if f_es_vacio(dw_2.GetItemString(1,'serie')) then mensaje +=g_idioma.of_getmsg('colegiados.valor_serie','Debe especificar una serie para las facturas.')+cr
if isnull(dw_2.GetItemDatetime(1,'fecha')) then mensaje +=g_idioma.of_getmsg('colegiados.valor_fecha','Debe especificar la fecha para las facturas.')+cr
if f_es_vacio(dw_2.GetItemString(1,'asunto')) then mensaje +=g_idioma.of_getmsg('colegiados.valor_asunto','Debe especificar el asunto para las facturas.')+cr
if f_es_vacio(dw_2.GetItemString(1,'centro')) then mensaje +=g_idioma.of_getmsg('colegiados.valor_centro','Debe especificar el centro para las facturas.')+cr
if dw_2.GetItemString(1,'incluir_todos')='N' and f_es_vacio(dw_2.GetItemString(1,'formapago_mensual')) then
	mensaje += 'Debe especificar la forma de pago de las facturas que se van a emitir'+cr
end if
if dw_2.GetItemString(1,'incluir_todos')='S' and f_es_vacio(dw_2.GetItemString(1,'formapago')) then
	mensaje += 'Debe especificar la forma de pago de las facturas que se van a emitir'+cr
end if


// Modificado Ricardo 04-03-12
string formapago, banco
long n_reg
if dw_2.GetItemString(1,'incluir_todos')='S' then
	formapago		= dw_2.GetItemString(1,'formapago')
else
	formapago		= dw_2.GetItemString(1,'formapago_mensual')
end if

// Modificado Ricardo 04-04-26
// POR ORDEN DE PACO, ESTO NO DEBE SER OBLIGATORIO... :(
		// Con domiciliacion bancaria no se permite pagar a no
		//if formapago = 'DB' and dw_2.GetItemString(1,'pagada') = 'N' then mensaje += "Con domiciliaci$$HEX1$$f300$$ENDHEX$$n bancaria deben marcase las facturas como pagadas"
// Por este mismo criterio, hay que ponerlo si el pagado es a 'S', tanto la Forma de pago, como el banco (este ultimo comprogar si existe en la bbdd)
if dw_2.GetItemString(1,'pagada') = 'S' then 
	banco = dw_2.GetItemString(1,'banco')
	if f_es_vacio(banco) then 
		mensaje +=g_idioma.of_getmsg('colegiados.valor_banco','Debe especificar el banco para las facturas.')+cr
	else
		// Miramos si dicho banco est$$HEX2$$e1002000$$ENDHEX$$en la bbdd almacenado
		//SCP-1147. A$$HEX1$$f100$$ENDHEX$$adido al where la empresa, porque los bancos son multiempresa.
		select count(*) into :n_reg from csi_bancos where codigo = :banco AND empresa = :g_empresa	;
		if n_reg = 0 then
			// No existe el banco, por lo que no dejamos continuar
			mensaje =+ 'Debe seleccionar el banco de entre los existentes.'+cr
		end if
	end if
end if
// FIN Modificado Ricardo 04-03-12

if mensaje <>'' then
	Messagebox(g_titulo,mensaje)
	return
end if
// Inhabilitamos este bot$$HEX1$$f300$$ENDHEX$$n
this.enabled = false

// Ordenamos la lista
if dw_2.getitemstring(1, 'ordenar') = 'N' then
	g_dw_lista.setsort("n_colegiado A")
	g_dw_lista.sort()
else
	g_dw_lista.setsort("apellidos A")
	g_dw_lista.sort()
end if
if i_col_cli = 'CLI' then
	g_dw_lista.setsort("apellidos A")
	g_dw_lista.sort()
end if

totalfilas = g_dw_lista.RowCount()

if dw_2.GetItemString(1,'incluir_todos')='S' then
	datos_facturacion.formapago		= dw_2.GetItemString(1,'formapago')
else
	datos_facturacion.formapago		= dw_2.GetItemString(1,'formapago_mensual')
end if
datos_facturacion.banco 			= dw_2.GetItemString(1,'banco')
datos_facturacion.serie				= dw_2.GetItemString(1,'serie')
datos_facturacion.fecha				= dw_2.GetItemDateTime(1,'fecha')
datos_facturacion.fecha_factura	= dw_2.GetItemDateTime(1,'fecha')
datos_facturacion.num_originales	= dw_2.GetItemNumber(1,'n_originales')
datos_facturacion.num_copias		= dw_2.GetItemNumber(1,'n_copias')
datos_facturacion.incluir_todos	= dw_2.GetItemString(1,'incluir_todos')
datos_facturacion.asunto			= dw_2.GetItemString(1,'asunto')
datos_facturacion.obs 				= dw_2.GetItemString(1,'obs')
datos_facturacion.centro			= dw_2.GetItemString(1,'centro')
datos_facturacion.proyecto			= dw_2.GetItemString(1,'proyecto')
datos_facturacion.pagada			= dw_2.GetItemString(1,'pagada')
datos_facturacion.tipo_factura	= g_colegio_colegiado
datos_facturacion.anulada			= 'N'
datos_facturacion.es_colegiado	= true
datos_facturacion.ds_lineas	= ds_lineas
datos_facturacion.cod_empresa=g_empresa
// Si son facturas a clientes cambiamos los datos de facturaci$$HEX1$$f300$$ENDHEX$$n
if i_col_cli = 'CLI' then
	datos_facturacion.tipo_factura	= g_colegio_cliente
	datos_facturacion.es_colegiado	= false
end if
integer aplica_sub
string primer_id_factura= '' , ultimo_id_factura = '', email, direccion_email, papel
cb_2.enabled = false


for i=1 to dw_1.rowcount()
	if dw_1.GetItemString(i,'articulo')=g_codigos_conceptos.cuota_colegial then
		factura_la_cuota=true
		exit
	end if
next


FOR i=1 TO totalfilas
	if g_colegio = 'COAATGU' then
		if g_dw_lista.GetItemString(i,'alta_baja') = 'N' then continue //CGU-184
	end if
	
	//Modificado Jesus 09-12-09
	if (g_colegio = 'COAATLE') then
		//Se almacena el valor del email en la estructura para poder enviar la factura.
		l_uo_impresion_formato.direccion_email= g_dw_lista.GetItemString(i,'email')
		//Se guardan los valores de la ventana por ser envio masivo
		email=l_uo_impresion_formato.email
		direccion_email=l_uo_impresion_formato.direccion_email	
		if (f_es_vacio(direccion_email)) then
			direccion_email=''
		end if
		papel=l_uo_impresion_formato.papel
		
		//Se hace el tratamiento:
				
		//       Papel            Email            |       Resultado
		//  -----------------------------------------------------------
		//  -----------------------------------------------------------
		//         x                                   |          Papel
		//  -----------------------------------------------------------
		//                             x               |         Si tiene email, email, sino papel
		//  -----------------------------------------------------------
		//         x                  x                |   Si tiene email, email, sino papel
		//  -----------------------------------------------------------
		
		if (email='S') then
			if f_es_vacio(direccion_email) then
				l_uo_impresion_formato.papel='S'
				l_uo_impresion_formato.email='N'
			else
				l_uo_impresion_formato.papel='N'
				l_uo_impresion_formato.email='S'
			end if
		else
			if (papel='S') then
				l_uo_impresion_formato.papel='S'
				l_uo_impresion_formato.email='N'
			end if
		end if
		
		datos_facturacion.impresion_formato=l_uo_impresion_formato
		
	end if
	//Fin modificacion
	
	datos_facturacion.id_receptor 		= g_dw_lista.GetItemString(i,'id_colegiado')
	st_1.text = 'Procesando ' + string(i) + ' de ' + string(totalfilas)

	
		
// SUBVENCIONES DE CUOTAS
	if  dw_2.GetItemString(1,'incluir_todos') = 'N' then		
		choose case g_colegio
			case 'COAATTGN'
				id_factura = f_factura(datos_facturacion)
				aplica_sub = f_colegiado_subvencion_quotas(datos_facturacion.id_receptor,dw_2.GetItemDateTime(1,'fecha'))
				if aplica_sub=1 then // Aplica subvencion sin la cobertura de musaat
					f_subvencion_sin_musaat(id_factura)
				elseif aplica_sub=2 then  // Aplica la subvencion  de todas las coberturas
					f_subvencion_coleg(id_factura)
				end if
			case 'COAATLL'
				id_factura = f_factura(datos_facturacion)
				aplica_sub = f_colegiado_subvencion_quotas(datos_facturacion.id_receptor,dw_2.GetItemDateTime(1,'fecha'))
				if aplica_sub=1 then // Aplica subvencion sin la cobertura de musaat
					f_subvencion_sin_musaat(id_factura)
				elseif aplica_sub=2 then  // Aplica la subvencion  de todas las coberturas
					f_subvencion_coleg(id_factura)
				end if
			case 'COAATGC'
				if wf_subvencion_coaatgc(datos_facturacion.id_receptor,date(datos_facturacion.fecha)) then continue
					
			case 'COAATMCA'
				if factura_la_cuota then
					if wf_subvencion_coaatmca(datos_facturacion.id_receptor,date(datos_facturacion.fecha)) then continue
				end if
		end choose
	else
		//SCP-1940
		if (g_colegio='COAATTGN' or g_colegio='COAATLL') then id_factura = f_factura(datos_facturacion)
	end if
	
	// Las facturas para Tarragona y lleida se genera antes
	if g_colegio<>'COAATTGN' AND g_colegio<>'COAATLL' then id_factura = f_factura(datos_facturacion)

	if id_factura<>'-1' then facturas_emitidas++
	
	if  id_factura<>'-1' and primer_id_factura = ''   then primer_id_factura = id_factura	
	if  id_factura<>'-1' then ultimo_id_factura = id_factura
	parent.Event csd_generar_linea_cobro_domiciliable(id_factura)
	
	//MODIFICADO RICARDO 04-09-14
	if dw_2.GetitemString(1, 'borrar_extras') = 'S' then
		// Para los colegiados, llamaremos al evento que se encargar$$HEX2$$e1002000$$ENDHEX$$de borrar los que son extras
		parent.trigger event csd_borrar_conceptos_domiciliables_extra(id_factura, datos_facturacion.id_receptor)
	end if
	//FIN MODIFICADO RICARDO 04-09-14
	
	//Modificado Jesus 09-12-09
	//Ponemos los campos como venian de la ventana de impresi$$HEX1$$f300$$ENDHEX$$n...
	if (g_colegio = 'COAATLE') then
		l_uo_impresion_formato.email=email
		l_uo_impresion_formato.papel=papel
	end if
		
NEXT

st_1.text = ''
MessageBox(g_titulo,g_idioma.of_getmsg('colegiados.proceso_finalizado','Proceso finalizado. ')+string(facturas_emitidas)+ ' facturas.' + cr +&
				+ g_idioma.of_getmsg('facturas_creadas','Rango de facturas creadas: ') + f_dame_n_fact_de_id(primer_id_factura) + ' - '  +&
				+ f_dame_n_fact_de_id(ultimo_id_factura), Information!)
cb_domiciliaciones.enabled=true
cb_1.enabled = false
cb_2.enabled = true
destroy ds_lineas

end event

type dw_1 from u_dw within w_colegiados_factura_n
integer y = 800
integer width = 4425
integer height = 736
integer taborder = 30
string dataobject = "d_colegiados_factura_1_n"
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;string descripcion,t_iva,emp
double importe

CHOOSE CASE dwo.name
	CASE 'articulo'
		SELECT descripcion,importe,t_iva,empresa  
		INTO :descripcion,:importe,:t_iva,:emp  FROM csi_articulos_servicios  WHERE codigo = :data and empresa=:g_empresa ;

		if isnull(importe) then importe = 0
		  
		this.SetItem(row,'descripcion_larga',descripcion)	
		this.SetItem(row,'subtotal',importe)
		this.SetItem(row,'precio',importe)
		this.SetItem(row,'t_iva',t_iva)
		this.SetItem(row,'subtotal_iva',f_aplica_t_iva(importe,t_iva))
		this.SetItem(row,'total',importe + f_aplica_t_iva(importe,t_iva))
		this.setitem(row,'empresa',f_obtener_empresa_nombre_corto(emp))
	CASE 'subtotal'
		t_iva= this.GetItemString(row,'t_iva')
		if isnull(t_iva) then return 
		this.SetItem(row,'precio',double(data))		
		this.SetItem(row,'subtotal_iva',f_aplica_t_iva(double(data),t_iva))
		this.SetItem(row,'total',double(data) + f_aplica_t_iva(double(data),t_iva))
	CASE 't_iva'
		importe= this.GetItemNumber(row,'subtotal')
		if isnull(importe) then return 
		this.SetItem(row,'subtotal_iva',f_aplica_t_iva(importe,data))
		this.SetItem(row,'total',importe + f_aplica_t_iva(importe,data))
END CHOOSE		

end event

type st_1 from statictext within w_colegiados_factura_n
integer x = 37
integer y = 708
integer width = 1271
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_2 from u_dw within w_colegiados_factura_n
integer x = 27
integer y = 4
integer width = 3611
integer height = 700
integer taborder = 10
string dataobject = "d_colegiados_datos_factura"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;boolean lb_incluir_todos

CHOOSE CASE dwo.name
	CASE 'banco'
		this.SetItem(1,'codigo',f_cobros_devuelve_ncontrol(data))
	
	//SCP-1147. No se filtra por banco, puesto que las formas de pago no est$$HEX1$$e100$$ENDHEX$$n preparadas para multi-empresa
	CASE 'formapago',  'formapago_mensual'
		// Al mofidificar a forma de pago domiciliacion bancaria, los cobros deben quedarse como no pagados obligatoriamente o no funciona la domiciliacion
		if data = 'DB' or data='PP' or data = 'PE' then
			this.setitem(row, 'pagada', 'N')
		else
			if NOT f_es_vacio(data) then this.setitem(row, 'pagada', 'S')
		end if
		
	CASE 'incluir_todos'
			// Vaciamos los dos campos de la forma de pago
		if data='S' then
			lb_incluir_todos = TRUE
			dw_2.setitem(row, 'formapago_mensual', '')
		else		
			lb_incluir_todos = FALSE
			dw_2.setitem(row, 'formapago', '')
		end if		
		dw_1.Object.subtotal.visible=lb_incluir_todos
		dw_1.Object.t_iva.visible=lb_incluir_todos
		dw_1.Object.subtotal_iva.visible=lb_incluir_todos
		dw_1.Object.total.visible=lb_incluir_todos
		dw_1.Object.subtotal_t.visible=lb_incluir_todos
		dw_1.Object.t_iva_t.visible=lb_incluir_todos
		dw_1.Object.subtotal_iva_t.visible=lb_incluir_todos
		dw_1.Object.total_t.visible=lb_incluir_todos
		dw_1.Object.t_2.visible=lb_incluir_todos
		dw_1.Object.compute_1.visible=lb_incluir_todos
		dw_1.Object.compute_2.visible=lb_incluir_todos
		dw_1.Object.compute_3.visible=lb_incluir_todos
		
END CHOOSE
end event

event constructor;call super::constructor;	datawindowchild dwc_forma_pago
	datawindowchild dwc_series_facturas
			// Capturamos el desplegable
			dw_2.getchild ('formapago_mensual', dwc_forma_pago)
			dwc_forma_pago.settransobject (SQLCA)
			dwc_forma_pago.setfilter("tipo_pago <>'CM'")
			dwc_forma_pago.filter()
			/*
			dw_2.getchild ('serie', dwc_series_facturas)
			dwc_series_facturas.settransobject (SQLCA)
			dwc_series_facturas.setfilter("empresa ='"+g_empresa+"'")
			dwc_series_facturas.filter()*/
end event

