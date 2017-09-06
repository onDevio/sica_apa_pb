HA$PBExportHeader$w_recibos_importa.srw
forward
global type w_recibos_importa from w_sheet
end type
type dw_fichero from datawindow within w_recibos_importa
end type
type cb_1 from commandbutton within w_recibos_importa
end type
type cb_procesar from commandbutton within w_recibos_importa
end type
type dw_1 from u_dw within w_recibos_importa
end type
type st_1 from statictext within w_recibos_importa
end type
end forward

global type w_recibos_importa from w_sheet
integer width = 3968
integer height = 2384
string menuname = "m_manteni"
windowstate windowstate = maximized!
dw_fichero dw_fichero
cb_1 cb_1
cb_procesar cb_procesar
dw_1 dw_1
st_1 st_1
end type
global w_recibos_importa w_recibos_importa

forward prototypes
public function string wf_tipo_iva (double importe, double iva)
public function boolean wf_comprobar_n_fact (string n_fact)
public subroutine wf_articulo_iva (string articulo, ref double porcent, ref string tipo_iva)
public function double wf_importe_recibos_colegiado (string id_colegiado, datastore ds_recibos)
end prototypes

public function string wf_tipo_iva (double importe, double iva);double porcent
string retorno

porcent = Round ( ( iva / importe ) * 100 , 0 )

  SELECT csi_t_iva.t_iva  
    INTO :retorno  
    FROM csi_t_iva  
   WHERE csi_t_iva.porcent = :porcent ;


if f_es_vacio(retorno) then retorno = string(porcent)

return retorno

end function

public function boolean wf_comprobar_n_fact (string n_fact);boolean retorno = false
int cuantos

  SELECT count(*)  
    INTO :cuantos  
    FROM csi_facturas_emitidas  
   WHERE csi_facturas_emitidas.n_fact = :n_fact   
           ;

if cuantos > 0 then
	retorno = true
end if

return retorno
end function

public subroutine wf_articulo_iva (string articulo, ref double porcent, ref string tipo_iva);
  SELECT csi_t_iva.porcent , csi_t_iva.t_iva
    INTO :porcent,:tipo_iva
    FROM csi_articulos_servicios,   
         csi_t_iva  
   WHERE ( csi_articulos_servicios.t_iva = csi_t_iva.t_iva ) and  
         ( ( csi_articulos_servicios.codigo = :articulo ) )   ;

if isnull(porcent) then porcent = 0


end subroutine

public function double wf_importe_recibos_colegiado (string id_colegiado, datastore ds_recibos);double retorno = 0
long i 
string id_pers

FOR i=1 to ds_recibos.RowCount() - 1
	id_pers = ds_recibos.GetItemString(i,'id_persona')
	if id_pers <> id_colegiado then continue
	
	retorno += ds_recibos.GetItemNumber(i,'total')
NEXT

return retorno


end function

event open;call super::open;of_SetResize (true)
inv_resize.of_Register (dw_1, "ScaleToRight")
inv_resize.of_Register (dw_fichero, "ScaleToBottom")
inv_resize.of_Register (cb_procesar, "FixedToBottom")
inv_resize.of_Register (st_1, "FixedToBottom")

dw_1.InsertRow(0)

dw_1.SetItem(1,'banco',g_banco_por_defecto)
dw_1.SetItem(1,'formapago',g_forma_pago_por_defecto)
dw_1.SetItem(1,'fecha',today())



end event

on w_recibos_importa.create
int iCurrent
call super::create
if this.MenuName = "m_manteni" then this.MenuID = create m_manteni
this.dw_fichero=create dw_fichero
this.cb_1=create cb_1
this.cb_procesar=create cb_procesar
this.dw_1=create dw_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_fichero
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_procesar
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.st_1
end on

on w_recibos_importa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_fichero)
destroy(this.cb_1)
destroy(this.cb_procesar)
destroy(this.dw_1)
destroy(this.st_1)
end on

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_recibos_importa
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_recibos_importa
end type

type dw_fichero from datawindow within w_recibos_importa
integer x = 78
integer y = 584
integer width = 3694
integer height = 1408
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_recibos_fichero"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_recibos_importa
integer x = 3397
integer y = 124
integer width = 485
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Importar Fichero"
end type

event clicked;dw_fichero.Reset()


string filename
int fd,ret

ret = GetFileOpenName("Seleccione archivo",filename,filename,"txt","Archivos de texto (*.txt),*.txt")

if ret <> 1 then return

ret = dw_fichero.ImportFile(filename)

if ret <= 0 then
	string texto
	choose case ret
		case 0
			texto = "Demasiadas filas"
		case -1
			texto = "No hay filas"
		case -2
			texto = "Fichero vac$$HEX1$$ed00$$ENDHEX$$o"
		case -3
			texto = "Invalid argument"
		case -4
			texto = "Invalid input"
		case -5
			texto = "No se puede abrir el fichero"
		case -6
			texto = "No se puede cerrar el fichero"
		case -7
			texto = "Error leyendo el fichero"
		case -8
			texto = "No es un fichero de texto"
		case -9
			texto = "Proceso cancelado por el usuario"
		case -10
			texto = "Formato de archivo de dBase no soportado"
		case else
			texto = ""
	end choose
	MessageBox(g_titulo,'ERROR: ' + texto)
	return
end if

cb_procesar.enabled = true


end event

type cb_procesar from commandbutton within w_recibos_importa
integer x = 1728
integer y = 2044
integer width = 393
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Procesar"
end type

event clicked;string serie,articulo_def,forma_pago,banco,mensaje,tipo_f_pago,iva_incluido
boolean todos_num,todos_fecha
datetime fecha_def

todos_num = (dw_1.GetItemString(1,'n_recibo') = "S" )
todos_fecha = (dw_1.GetItemString(1,'fecha_todos') = "S" )
serie = dw_1.GetItemString(1,'serie')
articulo_def = dw_1.GetItemString(1,'articulo')
fecha_def = dw_1.GetItemDateTime(1,'fecha')
tipo_f_pago = dw_1.GetItemString(1,'t_forma_pago')
iva_incluido = dw_1.GetItemString(1,'iva_incl')

mensaje = ""
mensaje += f_valida(dw_1,'serie','NOVACIO','Debe especificar la serie.')
mensaje += f_valida(dw_1,'articulo','NOVACIO','Debe especificar el articulo.')
mensaje += f_valida(dw_1,'fecha','NONULO','Debe especificar la fecha por defecto.')
if tipo_f_pago = 'F' then 
	mensaje += f_valida(dw_1,'formapago','NOVACIO','Debe especificar la forma de pago.')
end if
mensaje += f_valida(dw_1,'banco','NOVACIO','Debe especificar el Banco.')

if mensaje <> "" then
	MessageBox(g_titulo,mensaje,StopSign!)
	return
end if

long i,fila
datastore ds_facturas,ds_lineas,ds_cobros,ds_errores
string n_col,n_recibo,concepto,id_col,id_factura,t_iva
datetime fecha
double importe,importe_iva,porcent_iva,saldo,importe_recibos

ds_facturas = create datastore
ds_facturas.dataobject = 'd_recibos_factu_e'
ds_facturas.SetTransObject(SQLCA)

ds_lineas = create datastore
ds_lineas.dataobject = 'd_recibos_lineas_f'
ds_lineas.SetTransObject(SQLCA)

ds_cobros = create datastore
ds_cobros.dataobject = 'd_recibos_cobros'
ds_cobros.SetTransObject(SQLCA)

ds_errores = create datastore
ds_errores.dataObject = 'd_recibos_errores'
ds_errores.SetTransObject(SQLCA)

FOR i = 1 to dw_fichero.RowCount()
	forma_pago = dw_1.GetItemString(1,'formapago')
	banco = dw_1.GetItemString(1,'banco')
	
	st_1.visible = true
	st_1.text = "Procesando recibo " + string(i) + " de " + string(dw_fichero.RowCount())
	if dw_fichero.GetItemString(i,'selec') <> 'S' then continue
	
	n_col = dw_fichero.GetItemString(i,'n_col')
	fecha = dw_fichero.GetItemDateTime(i,'fecha')
	n_recibo = dw_fichero.GetItemString(i,'num_recibo')
	concepto = dw_fichero.GetItemString(i,'concepto')
	importe = dw_fichero.GetItemNumber(i,'importe')
	wf_articulo_iva(articulo_def,porcent_iva,t_iva)
	
	if iva_incluido = 'S' then
		importe_iva = Round( importe - (100 * importe) / (100 + porcent_iva) , 2 )
		importe = importe - importe_iva //Round((100 * importe) / (100 + porcent_iva) , 2 )
	else
		importe_iva = importe * porcent_iva / 100
	end if

	

	if f_es_vacio(n_col) then
		fila = ds_errores.InsertRow(0)
		ds_errores.SetItem(fila,'fila',i)
		ds_errores.SetItem(fila,'num',n_recibo)
		ds_errores.SetItem(fila,'texto','N$$HEX2$$ba002000$$ENDHEX$$Colegiado vac$$HEX1$$ed00$$ENDHEX$$o')
		continue
	end if
	
	id_col = f_colegiado_id_col(n_col)
	if f_es_vacio(id_col) then
		fila = ds_errores.InsertRow(0)
		ds_errores.SetItem(fila,'fila',i)
		ds_errores.SetItem(fila,'num',n_recibo)
		ds_errores.SetItem(fila,'texto','El colegiado ' + n_col + ' no existe en la base de datos.')
		continue
	end if
	
	if isnull(importe) then importe = 0
	if isnull(importe_iva) then importe_iva = 0
	
	if f_es_vacio(n_recibo) or todos_num then
		//Generar num recibo
		//n_recibo=f_siguiente_n_fact_emitida(g_colegio_colegiado,serie,'',fecha)  //se generar$$HEX2$$e1002000$$ENDHEX$$al grabar
		n_recibo=""
	else
		n_recibo = RightA('000000' + n_recibo, 6)
		n_recibo = LeftA( RightA(TRIM(serie),6) + '-' + RightA(g_ejercicio,2) + n_recibo, 15)
		//Comprobamos duplicados 
		boolean existe = false
		existe = wf_comprobar_n_fact(n_recibo)
		if existe then
			fila = ds_errores.InsertRow(0)
			ds_errores.SetItem(fila,'fila',i)
			ds_errores.SetItem(fila,'num',n_recibo)
			ds_errores.SetItem(fila,'texto','El recibo ' + n_recibo + ' ya existe en la base de datos.')
			continue
		end if
	end if
	
	fila = ds_facturas.InsertRow(0)
	
	id_factura = f_siguiente_numero('FACTUEMI',10)
	ds_facturas.SetItem(fila,'id_factura',id_factura)
	ds_facturas.SetItem(fila,'usuario',g_usuario)
	
	if isnull(fecha) or todos_fecha then
		fecha = fecha_def
	end if
	ds_facturas.SetItem(fila,'fecha',fecha)
	ds_facturas.SetItem(fila,'n_fact',n_recibo)
	ds_facturas.SetItem(fila,'n_col',n_col)
	ds_facturas.SetItem(fila,'id_persona',id_col)
	ds_facturas.SetItem(fila,'nif',f_devuelve_nif(id_col))
	ds_facturas.SetItem(fila,'nombre',f_colegiado_apellido(id_col))
	ds_facturas.SetItem(fila,'domicilio',f_domicilio_fiscal(id_col))
	ds_facturas.SetItem(fila,'domicilio_largo',f_domicilio_fiscal(id_col))					
	ds_facturas.SetItem(fila,'poblacion',f_poblacion_fiscal(id_col))
	ds_facturas.SetItem(fila,'cuenta',f_devuelve_cuenta(id_col))
	ds_facturas.SetItem(fila,'empresa',g_empresa)
	ds_facturas.SetItem(fila,'asunto',concepto)
	
	ds_facturas.SetItem(fila,'base_imp',importe)
	ds_facturas.SetItem(fila,'total',importe + importe_iva)
	ds_facturas.SetItem(fila,'subtotal',importe)
	ds_facturas.SetItem(fila,'iva',importe_iva)
	
	if tipo_f_pago <> 'F' then
		saldo = f_saldo_cuenta_bancaria_col(id_col,DateTime(Date("01-01-"+g_ejercicio)),DateTime(Date("31-12-"+g_ejercicio)))
		importe_recibos = wf_importe_recibos_colegiado(id_col,ds_facturas)
		if (saldo >= importe + importe_iva + importe_recibos)  and (saldo> 0) then
			forma_pago = g_formas_pago.cuenta_personal
		else
			if tipo_f_pago = "I" then
				forma_pago = ""
				banco = ""
			else
				forma_pago = g_formas_pago.domiciliacion
			end if
		end if
	end if
	ds_facturas.SetItem(fila,'formadepago',forma_pago)
	if forma_pago = g_formas_pago.cuenta_personal then
		ds_facturas.SetItem(fila,'pagado','S')
		ds_facturas.SetItem(fila,'f_pago',fecha)
	end if

	if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)

	ds_facturas.SetItem(fila,'banco',banco)
	
	ds_facturas.SetItem(fila,'tipo_factura',g_colegio_colegiado)
	ds_facturas.SetItem(fila,'centro',f_devuelve_centro(g_cod_delegacion))
	ds_facturas.SetItem(fila,'proyecto',g_explotacion_por_defecto)
	ds_facturas.SetItem(fila,'t_iva',t_iva)

	fila = ds_lineas.InsertRow(0)
	ds_lineas.SetItem(fila,'id_factura',id_factura)
	ds_lineas.SetItem(fila,'id_linea',f_siguiente_numero('LINEA_FEMI',10))
	ds_lineas.SetItem(fila,'articulo',articulo_def)
	ds_lineas.SetItem(fila,'descripcion_larga',concepto)
	ds_lineas.SetItem(fila,'precio',importe)
	ds_lineas.SetItem(fila,'subtotal',importe)
	ds_lineas.SetItem(fila,'total',importe + importe_iva)
	ds_lineas.SetItem(fila,'subtotal_iva',importe_iva)
	ds_lineas.SetItem(fila,'t_iva',t_iva)
	
	
	fila = ds_cobros.InsertRow(0)
	ds_cobros.SetItem(fila,'id_factura',id_factura)
	ds_cobros.SetItem(fila,'id_pago',f_siguiente_numero('COBRO_FEMI',10))
	ds_cobros.SetItem(fila,'forma_pago',forma_pago)
	if forma_pago = g_formas_pago.cuenta_personal then
		ds_cobros.SetItem(fila,'pagado','S')
		ds_cobros.SetItem(fila,'f_pago',fecha)
	end if
	ds_cobros.SetItem(fila,'banco',banco)
	ds_cobros.SetItem(fila,'importe',importe + importe_iva)
	if dw_1.GetItemString(1,'tipo_recibo') = "D" then ds_cobros.SetItem(fila,'devuelto','S')
	ds_cobros.SetItem(fila,'centro',f_devuelve_centro(g_cod_delegacion))
	ds_cobros.SetItem(fila,'proyecto',g_explotacion_por_defecto)
	ds_cobros.SetItem(fila,'f_vencimiento',fecha)
	ds_cobros.SetItem(fila,'empresa',g_empresa)

NEXT

st_1.visible = false

st_datos_recibos datos

datos.ds_recibos = ds_facturas
datos.ds_lineas = ds_lineas
datos.ds_cobros = ds_cobros
datos.ds_errores = ds_errores
datos.serie = serie
datos.fecha = fecha

openwithparm(w_recibos_generar,datos)


destroy ds_facturas
destroy ds_lineas
destroy ds_cobros
destroy ds_errores

//this.enabled = false


end event

type dw_1 from u_dw within w_recibos_importa
integer x = 32
integer y = 28
integer width = 3762
integer height = 524
integer taborder = 10
string dataobject = "d_recibos_importar"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

type st_1 from statictext within w_recibos_importa
boolean visible = false
integer x = 2949
integer y = 2044
integer width = 818
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 128
alignment alignment = right!
boolean focusrectangle = false
end type

