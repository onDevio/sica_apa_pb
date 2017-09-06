HA$PBExportHeader$w_colegiados_factura_cualquier_concepto.srw
forward
global type w_colegiados_factura_cualquier_concepto from window
end type
type dw_2 from u_dw within w_colegiados_factura_cualquier_concepto
end type
type dw_1 from u_dw within w_colegiados_factura_cualquier_concepto
end type
type st_1 from statictext within w_colegiados_factura_cualquier_concepto
end type
type cb_2 from commandbutton within w_colegiados_factura_cualquier_concepto
end type
type cb_1 from commandbutton within w_colegiados_factura_cualquier_concepto
end type
end forward

global type w_colegiados_factura_cualquier_concepto from window
integer y = 300
integer width = 3621
integer height = 2176
boolean titlebar = true
string title = "Emisi$$HEX1$$f300$$ENDHEX$$n de factura"
windowtype windowtype = response!
long backcolor = 67108864
event csd_configurar_ventana_colegiado ( )
event csd_configurar_ventana_cliente ( )
event csd_cargar_asistentes ( )
dw_2 dw_2
dw_1 dw_1
st_1 st_1
cb_2 cb_2
cb_1 cb_1
end type
global w_colegiados_factura_cualquier_concepto w_colegiados_factura_cualquier_concepto

type variables
datastore ids_asist
end variables

event csd_configurar_ventana_colegiado();// Cambiamos el dw del detalle de las facturas
dw_1.dataobject='d_colegiados_datos_factura_cualquier_col'
dw_1.settransobject(sqlca)
dw_1.insertrow(0)
dw_1.setfocus()
end event

event csd_configurar_ventana_cliente();// Cambiamos el dw del detalle de las facturas
dw_1.dataobject='d_colegiados_datos_factura_cualquier_cli'
dw_1.settransobject(sqlca)
dw_1.insertrow(0)
dw_1.setfocus()	
end event

event csd_cargar_asistentes();// Evento que carga la lista de colegiados asistentes a un curso
int i, fila
string id_col

dw_1.deleterow(0)

for i=1 to ids_asist.rowcount()
	id_col = f_colegiado_id_col(ids_asist.getitemstring(i, 'n_colegiado'))
	// Vamos a meter s$$HEX1$$f300$$ENDHEX$$lo los colegiados
	if not f_es_vacio(id_col) then
		fila = dw_1.insertrow(0)
		dw_1.setitem(fila, 'id_col', id_col)
		dw_1.setitem(fila, 'n_col', f_colegiado_n_col(id_col))
	end if
next

end event

event open;ids_asist = Message.PowerObjectParm // DS con los asistentes de un curso

f_centrar_ventana(this)
dw_1.SetTransObject(SQLCA)
dw_1.InsertRow(0)
dw_2.InsertRow(0)

dw_2.SetItem(1,'fecha',datetime(Today()))
dw_2.SetItem(1,'formapago',g_formas_pago.defecto)


dw_2.of_SetDropDownCalendar(True)
dw_2.iuo_calendar.of_register(dw_2.iuo_calendar.DDLB)
dw_2.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_2.iuo_calendar.of_SetInitialValue(True)

// Si se le ha pasado el ds es porque venimos desde formaci$$HEX1$$f300$$ENDHEX$$n
if isvalid(ids_asist) then event csd_cargar_asistentes()
end event

on w_colegiados_factura_cualquier_concepto.create
this.dw_2=create dw_2
this.dw_1=create dw_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_2,&
this.dw_1,&
this.st_1,&
this.cb_2,&
this.cb_1}
end on

on w_colegiados_factura_cualquier_concepto.destroy
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type dw_2 from u_dw within w_colegiados_factura_cualquier_concepto
integer x = 91
integer width = 3470
integer height = 776
integer taborder = 20
string dataobject = "d_colegiados_datos_factura_cualquier_con"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;string descripcion, t_iva
double importe
int i

choose case dwo.name
	case 'concepto'
		if dw_1.rowcount() > 0 then
			dw_1.setitem(dw_1.rowcount(),'texto_adicional',data)
   	  SELECT descripcion,importe,t_iva  
   		  INTO :descripcion,:importe,:t_iva  FROM csi_articulos_servicios  WHERE codigo = :data and empresa=:g_empresa;
			for i=1 to dw_1.rowcount()
				dw_1.SetItem(i,'texto_adicional',descripcion)	
				dw_1.SetItem(i,'precio',importe)
				dw_1.SetItem(i,'importe',importe)
				dw_1.SetItem(i,'t_iva',t_iva)
				dw_1.SetItem(i,'importe_iva',f_aplica_t_iva(importe,t_iva))
				dw_1.SetItem(i,'total_linea',importe + f_aplica_t_iva(importe,t_iva))	
			next
		end if
	case 'receptor_factura'
		//Cambiamos los elementos que se muestran en la pantalla seg$$HEX1$$fa00$$ENDHEX$$n el receptor de la factura (cliente o colegiado)
		choose case data
			case 'C'
				event csd_configurar_ventana_colegiado()
				//Ocultar la lista de colegiados y el boton cargar lista
			case 'T'	
				event csd_configurar_ventana_cliente()
		end choose
end choose

end event

event buttonclicked;string id_lista,id_articulo,descripcion,t_iva
double importe
int i,j

//Creamos DS de lista_colegiados
datastore ds_lista_col

ds_lista_col = create datastore
ds_lista_col.dataobject ='d_listas_miembros'
ds_lista_col.SetTransObject(SQLCA)

ds_lista_col.reset()
id_lista=dw_2.getitemstring(1,'lista_col')
ds_lista_col.retrieve(id_lista)
if ds_lista_col.rowcount() > 0 then
	for i=1 to ds_lista_col.rowcount()
		dw_1.accepttext()
		dw_1.event pfc_addrow()
//		j=dw_1.rowcount()
		dw_1.setitem(dw_1.rowcount(),'n_col',ds_lista_col.getitemstring(i,'n_col'))
		dw_1.setitem(dw_1.rowcount(),'id_col',ds_lista_col.getitemstring(i,'id_lista_miembro'))
		if dw_1.rowcount() > 1 then
			dw_1.setitem(dw_1.rowcount(),'texto_adicional',dw_1.getitemstring(dw_1.rowcount() -1,'texto_adicional'))
			dw_1.SetItem(dw_1.rowcount(),'unidades',dw_1.getitemnumber(dw_1.rowcount() -1,'unidades'))
			dw_1.SetItem(dw_1.rowcount(),'precio',dw_1.getitemnumber(dw_1.rowcount() -1,'precio'))			
			dw_1.setitem(dw_1.rowcount(),'importe',dw_1.getitemnumber(dw_1.rowcount() -1,'importe'))
			dw_1.setitem(dw_1.rowcount(),'t_iva',dw_1.getitemstring(dw_1.rowcount() -1,'t_iva'))
			dw_1.SetItem(dw_1.rowcount(),'importe_iva',dw_1.getitemnumber(dw_1.rowcount() -1,'importe_iva'))
			dw_1.SetItem(dw_1.rowcount(),'total_linea',dw_1.getitemnumber(dw_1.rowcount() -1,'total_linea'))
		else
			id_articulo=dw_2.getitemstring(dw_2.rowcount(),'concepto')
   	  	SELECT descripcion,importe,t_iva  
   			INTO :descripcion,:importe,:t_iva  FROM csi_articulos_servicios  
				WHERE codigo = :id_articulo ;
			dw_1.SetItem(dw_1.rowcount(),'texto_adicional',descripcion)	
//			dw_1.SetItem(dw_1.rowcount(),'unidades',1)			
			dw_1.SetItem(dw_1.rowcount(),'precio',importe)	
			dw_1.SetItem(dw_1.rowcount(),'importe',importe)
			dw_1.SetItem(dw_1.rowcount(),'t_iva',t_iva)
			dw_1.SetItem(dw_1.rowcount(),'importe_iva',f_aplica_t_iva(importe,t_iva))
			dw_1.SetItem(dw_1.rowcount(),'total_linea',importe + f_aplica_t_iva(importe,t_iva))	
		end if
	next
end if
destroy ds_lista_col
end event

type dw_1 from u_dw within w_colegiados_factura_cualquier_concepto
event csd_copiar_linea ( )
integer x = 9
integer y = 832
integer width = 3584
integer height = 1104
integer taborder = 10
string dataobject = "d_colegiados_datos_factura_cualquier_col"
end type

event csd_copiar_linea;int linea

linea=Message.wordparm

dw_1.setitem(linea,'texto_adicional',dw_1.getitemstring(linea -1,'texto_adicional'))
dw_1.SetItem(linea,'unidades',dw_1.getitemnumber(linea -1,'unidades'))
dw_1.SetItem(linea,'precio',dw_1.getitemnumber(linea -1,'precio'))
dw_1.setitem(linea,'importe',dw_1.getitemnumber(linea -1,'importe'))
dw_1.setitem(linea,'t_iva',dw_1.getitemstring(linea -1,'t_iva'))
dw_1.SetItem(linea,'importe_iva',dw_1.getitemnumber(linea -1,'importe_iva'))
dw_1.SetItem(linea,'total_linea',dw_1.getitemnumber(linea -1,'total_linea'))
end event

event constructor;call super::constructor;this.of_SetSort(TRUE)
// Column header sort
inv_sort.of_SetColumnHeader (true)
// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

event itemchanged;call super::itemchanged;string descripcion,t_iva
double importe,p
int i

CHOOSE CASE dwo.name
	//para el dw de facturas para colegiados	
	CASE 'n_col'
		this.setitem(row,'id_col',f_colegiado_id_col(data))						
		if this.rowcount() > 1 and isnull(dw_1.getitemstring(row,'texto_adicional')) then
			this.postevent ("csd_copiar_linea",row,0)
		end if	
	//para el dw de facturas para clientes
	CASE 'nif'
		this.setitem(row,'id_cliente',f_cliente_id_cliente(data))
		this.setitem(row,'cliente',f_dame_cliente(f_cliente_id_cliente(data)))
		if this.rowcount() > 1 and isnull(dw_1.getitemstring(row,'texto_adicional')) then
			this.postevent ("csd_copiar_linea",row,0)
		end if
	CASE 'unidades'
		p=double(data) * this.getitemnumber(row,'precio')
		t_iva= this.GetItemString(row,'t_iva')
		if isnull(t_iva) then return 
		this.SetItem(row,'importe',p)
		this.SetItem(row,'importe_iva',f_aplica_t_iva(p,t_iva))
		this.SetItem(row,'total_linea',p + f_aplica_t_iva(p,t_iva))		
	CASE 'precio'
		p=double(data) * this.getitemnumber(row,'unidades')
		t_iva= this.GetItemString(row,'t_iva')	
		if isnull(t_iva) then return 
		this.SetItem(row,'importe',p)
		this.SetItem(row,'importe_iva',f_aplica_t_iva(p,t_iva))
		this.SetItem(row,'total_linea',p + f_aplica_t_iva(p,t_iva))
	CASE 't_iva'
		importe= this.GetItemNumber(row,'importe')
		if isnull(importe) then return 
		this.SetItem(row,'importe_iva',f_aplica_t_iva(importe,data))
		this.SetItem(row,'total_linea',importe + f_aplica_t_iva(importe,data))
END CHOOSE		

end event

event buttonclicked;call super::buttonclicked;string id_colegiado, col, ls_id_persona, id_cliente, cli
int i

CHOOSE CASE dwo.name
	CASE 'b_1'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_colegiado=f_busqueda_colegiados()
		if f_es_vacio(id_colegiado) then return
		
		this.setitem(row,'id_col', id_colegiado)
		this.setitem(row,'n_col', f_colegiado_n_col(id_colegiado))
		
		if this.rowcount() > 1 then
			for i=1 to this.rowcount()
				if this.getitemstring(i,'id_col')=id_colegiado and i <> row then
					MessageBox(g_titulo,'Colegiado duplicado.')
					return -1
				end if
			next
		end if
		
		if this.rowcount() > 1 and isnull(dw_1.getitemstring(row,'texto_adicional')) then
			this.postevent ("csd_copiar_linea",row,0)
		end if

	CASE 'b_buscar_cliente'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
		g_busqueda.dw="d_lista_busqueda_clientes_cta_contable"
		ls_id_persona=f_busqueda_clientes_exp()
		if ls_id_persona="-1" then return
		
		this.setitem(row,'id_cliente', ls_id_persona)
		this.setitem(row,'nif', f_dame_nif(ls_id_persona))
		this.setitem(row,'cliente', f_dame_cliente(ls_id_persona))
			
		if this.rowcount() > 1 then
			for i=1 to this.rowcount()
				if this.getitemstring(i,'id_cliente')=ls_id_persona and i <> row then
					MessageBox(g_titulo,'Cliente duplicado.')
					return -1
				end if
			next
		end if		

		if this.rowcount() > 1 and isnull(dw_1.getitemstring(row,'texto_adicional')) then
			this.postevent ("csd_copiar_linea",row,0)
		end if		
END CHOOSE

end event

event itemfocuschanged;call super::itemfocuschanged;choose case dwo.name
	case 'n_copias'
		dw_1.insertrow(0)		
		dw_1.SetColumn(1)
		dw_1.Setrow(dw_1.rowcount())				
	case else
end choose
end event

type st_1 from statictext within w_colegiados_factura_cualquier_concepto
integer x = 2002
integer y = 1848
integer width = 1367
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_colegiados_factura_cualquier_concepto
integer x = 576
integer y = 1964
integer width = 402
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;// No hacemos nada con la tecla esc si hay datos
IF KeyDown(KeyEscape!) THEN
	if dw_1.rowcount()>0 then
		string col_cli
		col_cli = dw_2.getitemstring(1, 'receptor_factura')
		choose case col_cli
			case 'C'
				if dw_1.getitemstring(1, 'n_col')<>'' then return
			case 'T'
				if dw_1.getitemstring(1, 'nif')<>'' then return
		end choose
	end if
end if

Closewithreturn(parent,-1)

end event

type cb_1 from commandbutton within w_colegiados_factura_cualquier_concepto
integer x = 137
integer y = 1964
integer width = 402
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Crear Facturas"
end type

event clicked;if f_puedo_escribir(g_usuario,'0000000019')=-1 then return -1

dw_1.AcceptText()
dw_2.AcceptText()

SetPointer(Hourglass!)
long i, totalfilas, fila,j,cod_error
string id_col,mensaje=''
st_facturas datos_facturacion
datastore lineas_factura
string receptor_factura,id_persona

//Modificado Jesus 09-12-09
//Se muestra la ventana de los 4 checks para permitir elegir el envio por email o la impresion por papel. CLE-78
if (g_colegio = 'COAATLE') then
	n_csd_impresion_formato l_uo_impresion_formato
	l_uo_impresion_formato = create n_csd_impresion_formato
	
//	l_uo_impresion_formato.pdf = g_formato_impresion_visared.pdf
	l_uo_impresion_formato.papel = g_formato_impresion_visared.papel
	l_uo_impresion_formato.email = g_formato_impresion_visared.email	
	l_uo_impresion_formato.masivo = true

	if l_uo_impresion_formato.f_opciones_impresion()<> 1 then return
end if
//Fin modificaci$$HEX1$$f300$$ENDHEX$$n


lineas_factura = create Datastore
lineas_factura.DataObject = 'd_fases_lineas_facturas'
lineas_factura.SetTransObject(SQLCA)

receptor_factura=dw_2.getitemstring(1,'receptor_factura')

choose case receptor_factura
	case 'C'
		id_persona='id_col'
	case 'T'
		id_persona='id_cliente'
end choose

for i=1 to dw_1.rowcount()
	if isnull(dw_1.getitemstring(i,id_persona)) then dw_1.deleterow(i)
next 		

if f_es_vacio(dw_2.GetItemString(1,'serie')) then mensaje +='Debe especificar una serie para las facturas.'+cr
if f_es_vacio(dw_2.GetItemString(1,'formapago')) then mensaje +='Debe especificar una forma de pago para las facturas.'+cr
if f_es_vacio(dw_2.GetItemString(1,'banco')) then mensaje +='Debe especificar un banco para las facturas.'+cr
if isnull(dw_2.GetItemdatetime(1,'fecha')) then mensaje +='Debe especificar una fecha para las facturas.'+cr
if f_es_vacio(dw_2.GetItemString(1,'asunto')) then mensaje +='Debe especificar un asunto para las facturas.'+cr
if f_es_vacio(dw_2.GetItemString(1,'concepto')) then mensaje +='Debe especificar un valor para el Concepto.'+cr
for i= 1 to dw_1.RowCount()
	if f_es_vacio(dw_1.GetItemString(i,id_persona)) then mensaje +='Debe especificar un valor para el N$$HEX2$$ba002000$$ENDHEX$$de colegiado/NIF.'+'  (linea '+string(i)+')'+cr	
	if f_es_vacio(dw_1.GetItemString(i,'texto_adicional')) then mensaje +='Debe especificar un valor para el Texto adicional.'+'  (linea '+string(i)+')'+cr	
	if f_es_vacio(dw_1.GetItemString(i,'t_iva')) then mensaje +='Debe especificar un valor para el Tipo de Impuestos.'+'  (linea '+string(i)+')'+cr
	if isnull(dw_1.GetItemNumber(i,'total_factura')) then mensaje +='Debe especificar un valor para el Total de la l$$HEX1$$ed00$$ENDHEX$$nea.'+'  (linea '+string(i)+')'+cr
	if isnull(dw_1.GetItemNumber(i,'importe')) then mensaje +='Debe especificar un valor para el Importe.'+'  (linea '+string(i)+')'+cr
	if isnull(dw_1.GetItemNumber(i,'importe_iva')) then mensaje +='Debe especificar un valor para el Importe impuestos.'+'  (linea '+string(i)+')'+cr	
	if isnull(dw_1.GetItemNumber(i,'precio')) then mensaje +='Debe especificar un valor para el Precio.'+'  (linea '+string(i)+')'+cr
	if isnull(dw_1.GetItemNumber(i,'unidades')) then mensaje +='Debe especificar un valor para las Unidades.'+'  (linea '+string(i)+')'+cr		
next

if mensaje <>'' then
	Messagebox(g_titulo,mensaje)
	return
end if

totalfilas = dw_1.RowCount()

i = messagebox(g_titulo,'Se van a generar ' + string(totalfilas) + ' facturas. $$HEX1$$bf00$$ENDHEX$$Desea Continuar?',Question!,YesNo!)
if i = 2 then return

datos_facturacion.formapago		= dw_2.GetItemString(1,'formapago')
datos_facturacion.serie				= dw_2.GetItemString(1,'serie')
datos_facturacion.fecha			= dw_2.GetItemDateTime(1,'fecha')
datos_facturacion.num_originales	= dw_2.GetItemNumber(1,'n_originales')
datos_facturacion.num_copias		= dw_2.GetItemNumber(1,'n_copias')
datos_facturacion.incluir_todos	= dw_2.GetItemString(1,'incluir_todos')
datos_facturacion.asunto			= dw_2.GetItemString(1,'asunto')
datos_facturacion.es_colegiado	= true
datos_facturacion.pagada			= 'S'
datos_facturacion.banco				= dw_2.GetItemString(1,'banco')
datos_facturacion.incluir_todos = 'S'
datos_facturacion.cod_empresa=g_empresa
choose case receptor_factura
	case 'C'
		datos_facturacion.tipo_factura = g_colegio_colegiado
	case 'T'
		datos_facturacion.tipo_factura = g_colegio_cliente
end choose

//// ---------------------NUEVO--------------------------------------------------------
//// Quitamos el autocommit por si hay que hacer un rollback
//sqlca.autocommit = false
//execute immediate 'begin tran' using sqlca;
////--------------------------------------------------------------------------------------------

string email, papel, direccion_email

FOR j=1 TO totalfilas
	
	datos_facturacion.id_receptor 		= dw_1.GetItemString(j,id_persona)

//	datos_facturacion.descripcion					=dw_1.GetItemString(j,'texto_adicional')
//	datos_facturacion.descripcion_larga			=dw_1.GetItemString(j,'texto_adicional')
//	datos_facturacion.precio						=dw_1.GetItemNumber(j,'precio')
//	datos_facturacion.unidades						=dw_1.GetItemNumber(j,'unidades')
//	datos_facturacion.base_imponible				=dw_1.GetItemNumber(j,'importe')
//	datos_facturacion.t_impuesto					=dw_1.GetItemString(j,'t_iva')
//	datos_facturacion.importe_iva					=dw_1.GetItemNumber(j,'importe_iva')
//	datos_facturacion.cod_articulo				=dw_2.GetItemString(1,'concepto')

	lineas_factura.reset()
	lineas_factura.InsertRow(0)
	lineas_factura.SetItem(1,'descripcion',dw_1.GetItemString(j,'texto_adicional'))
	lineas_factura.SetItem(1,'descripcion_larga',dw_1.GetItemString(j,'texto_adicional'))
	lineas_factura.SetItem(1,'precio',dw_1.GetItemNumber(j,'precio'))
	lineas_factura.SetItem(1,'unidades',dw_1.GetItemNumber(j,'unidades'))
	lineas_factura.SetItem(1,'subtotal',dw_1.GetItemNumber(j,'importe'))
	lineas_factura.SetItem(1,'t_iva',dw_1.GetItemString(j,'t_iva'))
	lineas_factura.SetItem(1,'subtotal_iva',dw_1.GetItemNumber(j,'importe_iva'))
	lineas_factura.SetItem(1,'articulo',dw_2.GetItemString(1,'concepto'))
	lineas_factura.SetItem(1,'total',dw_1.GetItemNumber(i,'importe') + dw_1.GetItemNumber(j,'importe_iva'))

	datos_facturacion.ds_lineas = lineas_factura
	
	
	//Modificado Jesus 09-12-09
	if (g_colegio = 'COAATLE') then
		//Se almacena el valor del email en la estructura para poder enviar la factura.
		l_uo_impresion_formato.direccion_email= f_devuelve_mail( dw_1.GetItemString(j, 'id_col') )
		//Se guardan los valores de la ventana por ser envio masivo
		email=l_uo_impresion_formato.email
		direccion_email=l_uo_impresion_formato.direccion_email	
		if (f_es_vacio(direccion_email)) then
			direccion_email=''
		end if
		papel=l_uo_impresion_formato.papel
		
		//Se hace el tratamiento:
		//		* Si hay papel y hay email --> email
		//		* Si no hay papel y no hay email --> papel
		if (papel='S') then
			if email='S' AND NOT f_es_vacio(direccion_email) then
				l_uo_impresion_formato.papel='N'
			elseif email='S' then
				l_uo_impresion_formato.email='N'
			elseif (not f_es_vacio(direccion_email) ) then
				l_uo_impresion_formato.email='S'
				l_uo_impresion_formato.papel='N'
			end if
		else
			if f_es_vacio(direccion_email) then
				l_uo_impresion_formato.papel='S'
				l_uo_impresion_formato.email='N'
			else 
				l_uo_impresion_formato.email='S'
			end if
		end if
		
		datos_facturacion.impresion_formato=l_uo_impresion_formato
		
	end if
	//Fin modificacion
	
	st_1.text = 'Procesando ' + string(j) + ' de ' + string(totalfilas)
	f_factura(datos_facturacion)
	
	if (g_colegio = 'COAATLE') then
		//Modificado Jesus 09-12-09
		//Ponemos los campos como venian de la ventana de impresi$$HEX1$$f300$$ENDHEX$$n...
		l_uo_impresion_formato.email=email
		l_uo_impresion_formato.papel=papel
	end if
	
NEXT

// Hacemos un rollback o un commit de todo
// O est$$HEX2$$e1002000$$ENDHEX$$todo bien o echamos atras TODO
//if cod_error <> 0 then 
//	execute immediate 'ROLLBACK  TRANSACTION' using sqlca ;
//	messagebox('Error ( en facturas ) ','Se produjeron errores. No se ha creado NADA')
//else
//	execute immediate 'COMMIT  TRANSACTION' using sqlca ;
	st_1.text = ''
	MessageBox(g_titulo, 'Proceso finalizado. '+string(totalfilas)+ ' facturas.', Information!)	
//	mensaje = 'El proceso se ejecut$$HEX2$$f3002000$$ENDHEX$$con $$HEX1$$e900$$ENDHEX$$xito.~r'
//	mensaje = mensaje + 'Facturas generadas desde '+factura_primera+' hasta '+factura_ultima+' .~r'
//	messagebox('Aviso',mensaje)	
//end if


//// ---------------NUEVO------------------------------
//// Restauramos el autocommit
//sqlca.autocommit = true
////-------------------------------------------------------------

destroy lineas_factura
Closewithreturn(parent,1)

end event

