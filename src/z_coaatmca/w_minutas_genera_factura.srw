HA$PBExportHeader$w_minutas_genera_factura.srw
forward
global type w_minutas_genera_factura from w_response
end type
type cb_buscar from commandbutton within w_minutas_genera_factura
end type
type dw_1 from u_dw within w_minutas_genera_factura
end type
type dw_minutas from u_dw within w_minutas_genera_factura
end type
type cb_generar from commandbutton within w_minutas_genera_factura
end type
type cb_domiciliaciones from commandbutton within w_minutas_genera_factura
end type
type dw_2 from u_dw within w_minutas_genera_factura
end type
type dw_lista from u_dw within w_minutas_genera_factura
end type
end forward

global type w_minutas_genera_factura from w_response
integer x = 214
integer y = 221
integer width = 3378
integer height = 2100
string title = "Generar Facturas Pendientes"
event csd_generar_linea_cobro_domiciliable ( string id_factura )
cb_buscar cb_buscar
dw_1 dw_1
dw_minutas dw_minutas
cb_generar cb_generar
cb_domiciliaciones cb_domiciliaciones
dw_2 dw_2
dw_lista dw_lista
end type
global w_minutas_genera_factura w_minutas_genera_factura

type variables
string   is_sql_original, is_musaat, is_cip, is_dv, is_desplaza, is_honorario, is_impresos
n_csd_impresion_formato i_impresion_formato
datawindowchild    idwc_conceptos
end variables

event csd_generar_linea_cobro_domiciliable(string id_factura);string id_pago, forma_pago, pagado, n_talon, banco, cuenta, centro, proyecto, cta_presupuestaria
string contabilizado, cuenta_gastos, n_remesa,n_fact,id_persona,n_col 
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

on w_minutas_genera_factura.create
int iCurrent
call super::create
this.cb_buscar=create cb_buscar
this.dw_1=create dw_1
this.dw_minutas=create dw_minutas
this.cb_generar=create cb_generar
this.cb_domiciliaciones=create cb_domiciliaciones
this.dw_2=create dw_2
this.dw_lista=create dw_lista
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_buscar
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_minutas
this.Control[iCurrent+4]=this.cb_generar
this.Control[iCurrent+5]=this.cb_domiciliaciones
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_lista
end on

on w_minutas_genera_factura.destroy
call super::destroy
destroy(this.cb_buscar)
destroy(this.dw_1)
destroy(this.dw_minutas)
destroy(this.cb_generar)
destroy(this.cb_domiciliaciones)
destroy(this.dw_2)
destroy(this.dw_lista)
end on

event open;call super::open;string   ls_codigo

f_centrar_ventana(this) 

dw_1.event pfc_addrow()

dw_1.SetItem(1,'f_factura',DateTime(Today(),Now()))
dw_1.SetItem(1,'f_pago',DateTime(Today(),Now()))
dw_1.Setitem(1,'forma_pago',g_forma_pago_por_defecto)
dw_1.SetItem(1,'banco',g_banco_por_defecto)
i_impresion_formato = create n_csd_impresion_formato


////Asigna los valores de las variables globales que se llenan en f_inicializar_globales para realizar los filtros de los conceptos en las b$$HEX1$$fa00$$ENDHEX$$squedas

is_musaat    = g_codigos_conceptos.musaat_variable
is_cip			 = g_codigos_conceptos.cip
is_dv		     = g_codigos_conceptos.dv
is_honorario =  g_codigos_conceptos.honorarios
is_desplaza  =  g_codigos_conceptos.desplazamientos
is_impresos  =  g_codigos_conceptos.impresos


end event

event close;//
end event

event closequery;//
end event

event pfc_postopen;call super::pfc_postopen;string     ls_condicion, ls_mes
long       ll_mes,ll_anio
datetime ldt_desde

dw_1.of_SetDropDownCalendar(True)
dw_1.iuo_calendar.of_register(dw_1.iuo_calendar.DDLB)
dw_1.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_1.iuo_calendar.of_SetInitialValue(True)
dw_1.setformat('f_desde','dd/mm/yyyy')
dw_1.setformat('f_hasta','dd/mm/yyyy')
dw_1.setformat('f_factura','dd/mm/yyyy')
dw_1.setformat('f_pago','dd/mm/yyyy')


idwc_conceptos.Accepttext()

ls_condicion+= "(codigo = '"+is_cip+"' "
ls_condicion+= " or " +"codigo='"+is_musaat+"' "
ls_condicion+= " or " +"codigo='"+is_dv+"' "
ls_condicion+= " or " +"codigo='"+is_honorario+"' "
ls_condicion+= " or " +"codigo='"+is_desplaza+"' "
ls_condicion+= " or " +"codigo='"+is_impresos+"' "+")"

idwc_conceptos.setfilter(ls_condicion)
idwc_conceptos.filter()


ll_mes = Month(today())
ll_anio = Year(today())
ldt_desde =datetime(date("01/"+string(ll_mes)+"/"+string(ll_anio)))


if LenA(string(ll_mes)) = 1 then 
	ls_mes = '0' + string(ll_mes)
else
	ls_mes = string(ll_mes)
end if

dw_1.setitem(1, 'f_desde', ldt_desde)
dw_1.setitem(1, 'f_hasta', f_ultimo_dia_mes(ldt_desde))

cb_domiciliaciones.enabled = false

//Recuperamos la consulta de Inicio en caso de que exista
This.Event csd_recuperar_consulta('INICIO')

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_minutas_genera_factura
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_minutas_genera_factura
end type

type cb_buscar from commandbutton within w_minutas_genera_factura
integer x = 1362
integer y = 312
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Buscar"
end type

event clicked;datetime   ldt_f_desde, ldt_f_hasta
date         ld_f_desde, ld_f_hasta
string       sql_principal, sql_nuevo, ls_obra_oficial, ls_conceptos
long         i

SetPointer(HourGlass!)

dw_1.accepttext()

ldt_f_desde=dw_1.getitemdatetime(1,'f_desde')
ldt_f_hasta=dw_1.getitemdatetime(1,'f_hasta')

ld_f_desde= date(ldt_f_desde)
ld_f_hasta= date(ldt_f_hasta)

if not isnull(ld_f_desde) and not isnull(ld_f_hasta) and ld_f_hasta < ld_f_desde then
	messagebox(g_titulo, 'La fecha Hasta  no debe ser menor que la fecha Desde.')
end if 	

sql_principal = dw_minutas.describe("datawindow.table.select")
sql_nuevo = dw_minutas.describe("datawindow.table.select")

f_sql('fases_minutas.fecha','>=','f_desde',dw_1,sql_nuevo,'1','')
f_sql('fases_minutas.fecha','<','f_hasta',dw_1,sql_nuevo,'1','')

f_sql('fases.tipo_gestion','LIKE','tipo_gestion',dw_1,sql_nuevo,'1','')

sql_nuevo+= " and " +" fases_minutas.total_aviso > 0"
sql_nuevo+= " and " +" fases_minutas.pendiente = 'S' "

ls_obra_oficial = dw_1.getitemstring(1,"obra_oficial")
if ls_obra_oficial ='S' then
	f_sql('expedientes.administracion','LIKE','obra_oficial',dw_1,sql_nuevo,'1','')
end if

ls_conceptos = dw_1.getitemstring(1,"concepto")

if ls_conceptos = is_musaat then
	sql_nuevo+= " and " +" fases_minutas.base_musaat > 0"
end if

if ls_conceptos = is_impresos then
	sql_nuevo+= " and " +" fases_minutas.base_impresos > 0"
end if

if ls_conceptos = is_cip then
	sql_nuevo+= " and " +" fases_minutas.base_cip > 0"
end if

if ls_conceptos = is_dv then
	sql_nuevo+= " and " +" fases_minutas.base_dv > 0"
end if

if ls_conceptos = is_desplaza then
	sql_nuevo+= " and " +" fases_minutas.base_desplaza > 0"
end if

if ls_conceptos = is_honorario then
	sql_nuevo+= " and " +" fases_minutas.base_honos > 0"
end if

if g_colegio = 'COAATMCA' then
	sql_nuevo+= " and " +" fases_minutas.base_cip = 0 and  fases_minutas.base_impresos =0 and fases_minutas.base_dv = 0 and fases_minutas.base_musaat >0 "
end if
dw_minutas.Modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")



dw_minutas.Retrieve()

dw_minutas.modify("DataWindow.Table.Select= ~"" + sql_principal + "~"")

cb_generar.enabled = true

end event

type dw_1 from u_dw within w_minutas_genera_factura
integer x = 18
integer width = 3310
integer height = 512
integer taborder = 70
string dataobject = "d_minutas_pendientes_consulta"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemerror;call super::itemerror;//return 3
end event

event constructor;call super::constructor;string sql_nuevo,sql_principal, ls_msg

this.getchild("concepto", idwc_conceptos)
idwc_conceptos.settransobject(sqlca)
idwc_conceptos.retrieve()


end event

event itemchanged;call super::itemchanged;string  ls_tipo_pago, ls_banco, ls_banco_pago
Choose Case dwo.name
	Case	'f_desde', 'f_hasta', 'concepto'
		dw_minutas.reset()
		
		
	Case 'forma_pago'
			
		ls_tipo_pago = data

		SELECT csi_formas_de_pago.banco_asociado  
		INTO :ls_banco  
		FROM csi_formas_de_pago  
		WHERE csi_formas_de_pago.tipo_pago = :ls_tipo_pago ;
		
		// Si la forma de pago es TR o DB y el banco es vac$$HEX1$$ed00$$ENDHEX$$o que lo ponga sino no
		
		ls_banco_pago = this.GetItemString(row,'banco')

		
		if not f_es_vacio(ls_banco_pago) and ls_banco <> ls_banco_pago then messagebox(g_titulo, "Se va a cambiar el banco")
		IF NOT f_es_vacio(ls_banco) then this.setitem(row, 'banco', ls_banco)

		
		
end choose
end event

type dw_minutas from u_dw within w_minutas_genera_factura
integer x = 37
integer y = 548
integer width = 3273
integer height = 1324
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_minutas_pendientes"
boolean hscrollbar = true
end type

event constructor;call super::constructor;//this.of_SetRowSelect(TRUE)
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

event clicked;call super::clicked;long i

choose case dwo.name
	case "t_todos"
		if  this.RowCount() > 0 then
			if this.Find("todos = 'N'", 1, this.RowCount()) > 0 then
				for i=1 to this.RowCount()
					this.SetItem(i,"todos","S")
				next
			else
				for i=1 to this.RowCount()
					this.SetItem(i,"todos","N")
				next
			end if
		end if
end choose


IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 
end event

type cb_generar from commandbutton within w_minutas_genera_factura
integer x = 2798
integer y = 1896
integer width = 535
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Facturar y Cobrar"
end type

event clicked;string      ls_conceptos, ls_forma_pago, ls_banco, ls_check, ls_id_fase, ls_sql_original, ls_sql_nuevo
datetime  ldt_f_factura, ldt_f_pago
date         ld_f_fact, ld_f_pago
long         i, origin, copia, ll_contador
u_dw       dw_minutas_detalle,dw_caja_pago
datastore ldst_id_facturas, ldst_listado_facturas
st_liquidacion datos_liquidacion


ll_contador = 1
ldst_listado_facturas = create datastore
ldst_listado_facturas.dataobject ='d_listado_facturas_generadas'
ldst_listado_facturas.settransobject(sqlca)
ldst_listado_facturas.retrieve()

ls_sql_original = ldst_listado_facturas.describe("datawindow.table.select")
ls_sql_nuevo = ldst_listado_facturas.describe("datawindow.table.select")

dw_1.accepttext()

//Toma los datos de las facturas
ls_forma_pago = dw_1.getitemstring(1,"forma_pago")
ls_banco = dw_1.getitemstring(1,"banco")

ldt_f_factura=dw_1.getitemdatetime(1,'f_factura')
ldt_f_pago=dw_1.getitemdatetime(1,'f_pago')

ld_f_fact= date(ldt_f_factura)
ld_f_pago= date(ldt_f_pago)

// toma el valor de los conceptos para determinar el caso a considerar para la generaci$$HEX1$$f300$$ENDHEX$$n de la factura
ls_conceptos = dw_1.getitemstring(1,"concepto")

if ( ls_forma_pago = '' or isnull(ls_forma_pago)) or &
   ( ls_banco = '' or isnull(ls_banco)) or &
   ( isnull(ld_f_fact)) or &
   ( isnull(ld_f_pago)) then
	messagebox(g_titulo, 'Debe completar los Datos de la Factura')
	return 1
end if
	

dw_minutas.accepttext()

for i = 1 to dw_minutas.rowcount()
	ls_check = dw_minutas.object.todos[i]
	
	if ls_check ='S' then
		ls_id_fase = dw_minutas.getitemstring(i,"fases_minutas_id_minuta")
		dw_2.retrieve(ls_id_fase)
		// Actualizamos los valores
		dw_2.SetItem(1,'fecha_pago',ldt_f_pago)
		dw_2.SetItem(1,'forma_pago',ls_forma_pago)
		dw_2.SetItem(1,'banco',ls_banco) // No se pue
		
//		CHOOSE CASE g_colegio
//			CASE 'COAATZ', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATA', 'COAATGC', 'COAATNA','COAATTGN', 'COAATCC', 'COAATTEB', 'COAATTER',  'COAATMCA'
//				if f_fases_cambia_estado_fase_segun_pagado( ls_id_fase , 'MINUTAS')='-1' then
//					Messagebox(g_titulo, "Error al actualizar el estado del contrato", stopsign!)
//					return
//				end if
//		END CHOOSE
	
		
		
		dw_minutas_detalle = dw_2 // dw oculto con los valores de los avisos
		dw_caja_pago =  dw_1 // dw con los datos de la factura y el filtro de b$$HEX1$$fa00$$ENDHEX$$squeda
		origin = 0
		copia = 0
		//Se debe declarar la siguiente estructura
		st_generar_facturas_minutas parametros_factura_minuta
		
		//Se deben pasar los siguientes valores por la estructura
		parametros_factura_minuta.impresion_formato 	= i_impresion_formato
		parametros_factura_minuta.fecha_factura       =  ldt_f_factura
		parametros_factura_minuta.dw_minuta 			= dw_minutas_detalle
		parametros_factura_minuta.num_orig 			= Integer(origin)
		parametros_factura_minuta.num_copias 		= Integer(copia)
		parametros_factura_minuta.regulariza_musaat		= false
		parametros_factura_minuta.movimiento_musaat	= true
		parametros_factura_minuta.tipo_movimiento_csd	=dw_minutas_detalle.getitemstring(1, 'tipo_minuta')
		parametros_factura_minuta.tipo_prev			= ''
		parametros_factura_minuta.dw_factura			= dw_caja_pago
		parametros_factura_minuta.serie			         = g_serie_fases

		
		//Esta funci$$HEX1$$f300$$ENDHEX$$n genera la factura y el cobro seg$$HEX1$$fa00$$ENDHEX$$n la forma de pago
		f_generar_facturas_minuta(parametros_factura_minuta)
		
		//se arma el sql para aplicar al listado en caso de que la opci$$HEX1$$f300$$ENDHEX$$n se encuentre tildada
		if ll_contador = 1 then
			ls_sql_nuevo+= " and " +"(" + "(" +" csi_lineas_fact_emitidas.id_fase ='"+ls_id_fase+"'"+")"
			ll_contador ++
		else
			ls_sql_nuevo = ls_sql_nuevo +  " or " + "(" +" csi_lineas_fact_emitidas.id_fase ='"+ls_id_fase+"'"+")"
			ll_contador ++
		end if
			
		dw_minutas_detalle.SetItem(1,'pendiente','N')
		dw_minutas_detalle.update()

		//Generar liquidaci$$HEX1$$f300$$ENDHEX$$n
		if dw_minutas_detalle.getitemstring(1, 'tipo_gestion') = 'C' then
			// VAciamos la estructura primero ya que sino no funciona correctamente :(
			setnull(datos_liquidacion.importe)
			// VAciamos el asunto
			setnull(datos_liquidacion.concepto)
			
			// Ahora ponemos lo que nos interesa
			datos_liquidacion.id_fase		= dw_minutas_detalle.getitemstring(1, 'id_minuta')
			datos_liquidacion.id_col		= dw_minutas_detalle.getitemstring(1, 'id_colegiado')
			datos_liquidacion.f_entrada	= ldt_f_pago
			datos_liquidacion.tipo			= '0'	
			f_liquidacion(datos_liquidacion)
		end if
	end if
	
next

Messagebox(g_titulo, "Factura(s) Generada(s) con $$HEX1$$e900$$ENDHEX$$xito", information!)

ls_sql_nuevo = ls_sql_nuevo + ")"

////Se genera el reporte si la opci$$HEX1$$f300$$ENDHEX$$n de listado se encuentra tildado
if dw_1.getitemstring(1,"listado") ='S' then
	ldst_listado_facturas.Modify("DataWindow.Table.Select= ~"" + ls_sql_nuevo + "~"")
     ldst_listado_facturas.Retrieve()

	//Datos de copias en papel
	i_impresion_formato.papel = g_formato_impresion.papel
	i_impresion_formato.copias 					= 1
	i_impresion_formato.impresora_pag_desde 	= 1
	i_impresion_formato.impresora_intervalo 	= 'T'
	i_impresion_formato.impresora_intercalar 	= false
	i_impresion_formato.email ='X'
	i_impresion_formato.pdf = 'X'
	
	i_impresion_formato.dw = ldst_listado_facturas
	//i_impresion_formato.nombre = ls_listado
	
	if i_impresion_formato.f_opciones_impresion()>0 then
		i_impresion_formato.f_impresion()
	end if
	
	ldst_listado_facturas.modify("DataWindow.Table.Select= ~"" + ls_sql_original + "~"")
end if



//Despu$$HEX1$$e900$$ENDHEX$$s de generar la factura se verifica la forma de pago para determinar si se generaran domiciliaciones bancarias
if ls_forma_pago = 'DB' then
	cb_domiciliaciones.enabled = true
else
	cb_domiciliaciones.enabled = false
	cb_buscar.TriggerEvent(Clicked!)
end if





//this.enabled = false



end event

type cb_domiciliaciones from commandbutton within w_minutas_genera_factura
integer x = 37
integer y = 1896
integer width = 1221
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generar Domiciliaciones y Fichero CSB 19"
end type

event clicked;long   i, j
string ls_check, ls_id_fase, ls_forma_pago, ls_id_factura
datastore  ldst_id_facturas
st_cobros_datos_pre_remesa datos

dw_minutas.accepttext()

ldst_id_facturas = create datastore
ldst_id_facturas.dataobject ='d_dst_id_facturas_emitidas'
ldst_id_facturas.settransobject(sqlca)

ls_forma_pago = dw_1.getitemstring(1,"forma_pago")

for i = 1 to dw_minutas.rowcount()
	ls_check = dw_minutas.object.todos[i]
	
	if ls_check ='S' then
		ls_id_fase = dw_minutas.getitemstring(i,"fases_minutas_id_minuta")
			
		if ls_forma_pago = 'DB' then
		
			ldst_id_facturas.retrieve(ls_id_fase)
		
			for j = 1 to ldst_id_facturas.rowcount()
				
				ls_id_factura = ldst_id_facturas.getitemstring(j,"id_factura")
			
				parent.Event csd_generar_linea_cobro_domiciliable(ls_id_factura)
			next
		end if
	end if
next



datos.dw_lista = dw_lista
datos.modulo ='COLEGIADOS'

OpenWithParm(w_cobros_pre_remesa,datos)

destroy ldst_id_facturas
cb_buscar.TriggerEvent(Clicked!)
end event

type dw_2 from u_dw within w_minutas_genera_factura
boolean visible = false
integer x = 2021
integer y = 1876
integer width = 503
integer height = 144
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_minutas_detalle"
end type

event constructor;call super::constructor;datawindowchild   i_dwc_colegiados, i_dwc_clientes

this.GetChild('id_colegiado',i_dwc_colegiados)
i_dwc_colegiados.settransobject(sqlca)
i_dwc_colegiados.InsertRow(0)  
	
this.GetChild('id_cliente',i_dwc_clientes)
i_dwc_clientes.settransobject(sqlca)
i_dwc_clientes.InsertRow(0)  

end event

type dw_lista from u_dw within w_minutas_genera_factura
boolean visible = false
integer x = 1330
integer y = 1836
integer width = 434
integer height = 200
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_colegiados_lista_cobros_domiciliables"
end type

