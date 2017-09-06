HA$PBExportHeader$w_conceptos_domic_importa.srw
forward
global type w_conceptos_domic_importa from w_sheet
end type
type dw_fichero from datawindow within w_conceptos_domic_importa
end type
type cb_1 from commandbutton within w_conceptos_domic_importa
end type
type cb_procesar from commandbutton within w_conceptos_domic_importa
end type
type dw_1 from u_dw within w_conceptos_domic_importa
end type
type st_1 from statictext within w_conceptos_domic_importa
end type
type cbx_fijo from checkbox within w_conceptos_domic_importa
end type
end forward

global type w_conceptos_domic_importa from w_sheet
integer x = 214
integer y = 221
integer width = 3968
integer height = 2384
string menuname = "m_manteni"
windowstate windowstate = maximized!
dw_fichero dw_fichero
cb_1 cb_1
cb_procesar cb_procesar
dw_1 dw_1
st_1 st_1
cbx_fijo cbx_fijo
end type
global w_conceptos_domic_importa w_conceptos_domic_importa

forward prototypes
public function string wf_tipo_iva (double importe, double iva)
public function boolean wf_comprobar_n_fact (string n_fact)
public subroutine wf_articulo_iva (string articulo, ref double porcent, ref string tipo_iva)
public function double wf_importe_recibos_colegiado (string id_colegiado, datastore ds_recibos)
public subroutine wf_comprobar_datos ()
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

public subroutine wf_comprobar_datos ();//Recorre el dw y si hay algun datos vacio lo rellena con los datos por defecto.

string concepto,forma_pago,extra
double importe
long i

dw_1.Accepttext()

concepto = dw_1.GetItemString(1,'articulo')
forma_pago = dw_1.GetItemString(1,'formapago')
extra = dw_1.GetItemString(1,'esextra')
importe = 0

for i = 1 to dw_fichero.RowCount()
	//Concepto
	if f_es_vacio(dw_fichero.GetItemString(i,'concepto')) then dw_fichero.SetItem(i,'concepto',concepto)
	if dw_fichero.GetItemString(i,'concepto') = 'EXP' then dw_fichero.Object.t_1.visible = true
	//Forma de pago
	if (cbx_fijo.checked) then
		dw_fichero.SetItem(i,'forma_pago',forma_pago)
	else
		if f_es_vacio(dw_fichero.GetItemString(i,'forma_pago')) then dw_fichero.SetItem(i,'forma_pago',forma_pago)
	end if
	//Extra
	if f_es_vacio(dw_fichero.GetItemString(i,'es_extra')) then dw_fichero.SetItem(i,'es_extra',extra)
	//Importe
	if isNull(dw_fichero.GetItemNumber(i,'importe')) then dw_fichero.SetItem(i,'importe',importe)
	//marcado
	dw_fichero.SetItem(i,'marcado','S')
next
end subroutine

event open;call super::open;of_SetResize (true)
inv_resize.of_Register (dw_1, "ScaleToRight")
inv_resize.of_Register (dw_fichero, "ScaleToBottom")
inv_resize.of_Register (cb_procesar, "FixedToBottom")
inv_resize.of_Register (st_1, "FixedToBottom")

dw_1.InsertRow(0)

dw_1.SetItem(1,'banco',g_banco_por_defecto)
dw_1.SetItem(1,'formapago',g_forma_pago_por_defecto)


datawindowchild dw_formas_pago
dw_fichero.getchild('forma_pago',dw_formas_pago)
dw_formas_pago.settransobject(sqlca)
dw_formas_pago.retrieve()

datawindowchild dw_conceptos
dw_fichero.getchild('concepto',dw_conceptos)
dw_conceptos.settransobject(sqlca)
dw_conceptos.retrieve()




end event

on w_conceptos_domic_importa.create
int iCurrent
call super::create
if this.MenuName = "m_manteni" then this.MenuID = create m_manteni
this.dw_fichero=create dw_fichero
this.cb_1=create cb_1
this.cb_procesar=create cb_procesar
this.dw_1=create dw_1
this.st_1=create st_1
this.cbx_fijo=create cbx_fijo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_fichero
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_procesar
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cbx_fijo
end on

on w_conceptos_domic_importa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_fichero)
destroy(this.cb_1)
destroy(this.cb_procesar)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.cbx_fijo)
end on

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_conceptos_domic_importa
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_conceptos_domic_importa
end type

type dw_fichero from datawindow within w_conceptos_domic_importa
integer x = 78
integer y = 584
integer width = 3694
integer height = 1376
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_conceptos_domic_fichero"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_conceptos_domic_importa
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
wf_comprobar_datos()

dw_fichero.SetRedraw(false)
dw_fichero.SetSort("#1 A, #2 A")
dw_fichero.Sort()
dw_fichero.SetRedraw(true)

cb_procesar.enabled = true


end event

type cb_procesar from commandbutton within w_conceptos_domic_importa
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

event clicked;
long i,fila
datastore ds_conceptos_domic,ds_errores
string n_col,concepto,id_col,forma_pago,datos_bancarios,banco,extra,id_col_ant,concepto_ant

double importe,importe_iva,porcent_iva,saldo,importe_recibos

ds_conceptos_domic = create datastore
ds_conceptos_domic.dataobject = 'd_colegiados_conceptos_domiciliables'
ds_conceptos_domic.SetTransObject(SQLCA)

ds_errores = create datastore
ds_errores.dataObject = 'd_recibos_errores'
ds_errores.SetTransObject(SQLCA)

id_col_ant = '*'
concepto_ant = '*'

FOR i = 1 to dw_fichero.RowCount()
	
	banco = dw_1.GetItemString(1,'banco')
	
	st_1.visible = true
	st_1.text = "Procesando Conceptos facturables " + string(i) + " de " + string(dw_fichero.RowCount())
	if dw_fichero.GetItemString(i,'marcado') <> 'S' then continue
	
	n_col = dw_fichero.GetItemString(i,'n_col')
	concepto = dw_fichero.GetItemString(i,'concepto')
	importe = dw_fichero.GetItemNumber(i,'importe')
	forma_pago = dw_fichero.GetItemString(i,'forma_pago')
	extra = dw_fichero.GetItemString(i,'es_extra')
	datos_bancarios = dw_fichero.GetItemString(i,'datos_bancarios')
	
	if f_es_vacio(n_col) then
		fila = ds_errores.InsertRow(0)
		ds_errores.SetItem(fila,'fila',i)
//		ds_errores.SetItem(fila,'num',n_col)
		ds_errores.SetItem(fila,'texto','N$$HEX2$$ba002000$$ENDHEX$$Colegiado vac$$HEX1$$ed00$$ENDHEX$$o')
		continue
	end if
	
	id_col = f_colegiado_id_col(n_col)
	
	if f_es_vacio(id_col) then
		fila = ds_errores.InsertRow(0)
		ds_errores.SetItem(fila,'fila',i)
		ds_errores.SetItem(fila,'num',n_col)
		ds_errores.SetItem(fila,'texto','El colegiado ' + n_col + ' no existe en la base de datos.')
		continue
	end if
	
	if id_col = id_col_ant and concepto = concepto_ant then 
		fila = ds_errores.InsertRow(0)
		ds_errores.SetItem(fila,'fila',i)
		ds_errores.SetItem(fila,'num',n_col)
		ds_errores.SetItem(fila,'texto','Ya existe el concepto, '+f_coleg_desc_concep_fact(concepto)+', para el colegiado: '+n_col+'.')
		continue	
		
	end if
	
	if not f_articulo_activo(concepto, g_empresa) then 
		fila = ds_errores.InsertRow(0)
		ds_errores.SetItem(fila,'fila',i)
		ds_errores.SetItem(fila,'num',n_col)
		ds_errores.SetItem(fila,'texto','El art$$HEX1$$ed00$$ENDHEX$$culo especificado, '+f_coleg_desc_concep_fact(concepto)+', no se encuentra activo en la actual empresa.')
		continue	
		
	end if
	
	
	if f_existe_concepto_domic_colegiado(concepto,id_col, g_empresa) then 
		fila = ds_errores.InsertRow(0)
		ds_errores.SetItem(fila,'fila',i)
		ds_errores.SetItem(fila,'num',n_col)
		ds_errores.SetItem(fila,'texto','Ya existe un concepto domiciliado para el colegiado del art$$HEX1$$ed00$$ENDHEX$$culo indicado, '+f_coleg_desc_concep_fact(concepto)+'. Puede tratar los datos desde la gesti$$HEX1$$f300$$ENDHEX$$n de domiciliaciones.')
		continue	
	end if
		
	if isnull(importe) then importe = 0
	
	fila = ds_conceptos_domic.InsertRow(0)
	
	ds_conceptos_domic.SetItem(fila,'id_colegiado',id_col)
	ds_conceptos_domic.SetItem(fila,'concepto',concepto)
	ds_conceptos_domic.SetItem(fila,'empresa',g_empresa)
	ds_conceptos_domic.SetItem(fila,'forma_de_pago',forma_pago)
	ds_conceptos_domic.SetItem(fila,'datos_bancarios',datos_bancarios)
	ds_conceptos_domic.SetItem(fila,'nombre_banco',banco)
	ds_conceptos_domic.SetItem(fila,'importe',importe)
	ds_conceptos_domic.SetItem(fila,'es_extra',extra)
	
	id_col_ant = id_col
	concepto_ant = concepto

NEXT

st_1.visible = false

st_datos_recibos datos

datos.ds_recibos = ds_conceptos_domic
datos.ds_errores = ds_errores

openwithparm(w_conceptos_domic_generar,datos)


destroy ds_conceptos_domic
destroy ds_errores




end event

type dw_1 from u_dw within w_conceptos_domic_importa
integer y = 28
integer width = 3762
integer height = 424
integer taborder = 10
string dataobject = "d_conceptos_domic_importar"
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

type st_1 from statictext within w_conceptos_domic_importa
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

type cbx_fijo from checkbox within w_conceptos_domic_importa
integer x = 2185
integer y = 196
integer width = 206
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "fijo:"
end type

