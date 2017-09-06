HA$PBExportHeader$w_ing_ret.srw
forward
global type w_ing_ret from w_response
end type
type dw_1 from u_dw within w_ing_ret
end type
type cb_2 from u_cb within w_ing_ret
end type
type dw_2 from u_dw within w_ing_ret
end type
type cb_previsualizar from commandbutton within w_ing_ret
end type
type gb_1 from groupbox within w_ing_ret
end type
end forward

global type w_ing_ret from w_response
integer width = 3113
integer height = 1132
string title = "Ingresa - Retira"
boolean ib_disableclosequery = true
event csd_nuevo ( )
event csd_validar ( )
dw_1 dw_1
cb_2 cb_2
dw_2 dw_2
cb_previsualizar cb_previsualizar
gb_1 gb_1
end type
global w_ing_ret w_ing_ret

type variables
long i_asiento

end variables

event csd_nuevo();//string n_traspaso

// Vaciamos los datawindows utilizados
dw_1.reset()
dw_2.reset()


//// Calculamos el siguiente numero de traspaso
//select max(numero) into :n_traspaso from csi_traspasos_basicos ;
//n_traspaso=right('0000000000'+ string(double(n_traspaso) + 1), 10)
//if isnull(n_traspaso) then n_traspaso = '0000000001'
//
//dw_1.insertrow(0)
//dw_1.setitem(1,'id_traspaso', f_siguiente_numero ('ID_TRASPASO', 10))
//dw_1.SetItem(1,'fecha',datetime(Today()))
//dw_1.setitem(1,'numero', n_traspaso)
//dw_1.SetItem(1,'centro', f_devuelve_centro(g_cod_delegacion))
//
end event

on w_ing_ret.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.dw_2=create dw_2
this.cb_previsualizar=create cb_previsualizar
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_previsualizar
this.Control[iCurrent+5]=this.gb_1
end on

on w_ing_ret.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.cb_previsualizar)
destroy(this.gb_1)
end on

event open;call super::open;// Centramos la ventana 
f_centrar_ventana(this)

end event

event pfc_postopen;// SOBRESCRITO

// Vaciamos los datawindows
dw_1.reset()
dw_2.reset()

//Recuperamos la consulta de Inicio en caso de que exista
This.Event csd_recuperar_consulta('INICIO')

///*** SCP-1846 en caso de no se haya encontrado la consulta y no se haya introducido la linea, procedemos a introducirla ***///
If dw_1.rowcount() = 0 then
	dw_1.insertrow(0)
end if	

// Esto se tiene que ejecutar despu$$HEX1$$e900$$ENDHEX$$s de recuperar la consulta de inicio si no da error
// Calculamos el siguiente numero de traspaso
string n_traspaso
select max(numero) into :n_traspaso from csi_traspasos_basicos where empresa = :g_empresa;
n_traspaso=RightA('0000000000'+ string(double(n_traspaso) + 1), 10)
if isnull(n_traspaso) then n_traspaso = '0000000001'

dw_1.setitem(1,'id_traspaso', f_siguiente_numero ('ID_TRASPASO', 10))
dw_1.SetItem(1,'fecha',datetime(Today()))
dw_1.setitem(1,'numero', n_traspaso)
dw_1.SetItem(1,'centro', f_devuelve_centro(g_cod_delegacion))
dw_1.setitem(1,'banco', f_banco_asociado_a_forma_pago('TA'))
dw_1.setitem(1,'usuario', g_usuario)
///*** SCP-1801 - Alexis. Se indica el c$$HEX1$$f300$$ENDHEX$$digo de empresa con la empresa activa. ***///
dw_1.setitem( dw_1.getrow(), 'empresa', g_empresa)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_ing_ret
integer x = 3570
integer y = 1532
integer taborder = 30
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_ing_ret
integer x = 3063
integer y = 1532
end type

type dw_1 from u_dw within w_ing_ret
integer x = 37
integer y = 32
integer width = 3058
integer height = 740
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_ing_ret_datos"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;string id_col

CHOOSE CASE dwo.name
	CASE 'cb_busqueda_colegiado'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()
		//Comprobamos que el colegiado existe
		if id_col="-1" then
			messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
			this.setfocus()
			return -1
		else
			this.SetItem(1,'id_colegiado',id_col)
			this.SetItem(1,'n_col',f_colegiado_n_col(id_col))				
		end if
END CHOOSE

end event

event constructor;call super::constructor;this.settransobject(sqlca)
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event itemchanged;call super::itemchanged;string formadepago, banc_asoc, id_col, banco_pago

CHOOSE CASE dwo.name
	CASE 'n_col'
		id_col=f_colegiado_id_col(data)
		this.SetItem(1,'id_colegiado', id_col)
		
	CASE 'forma_pago'
		this.setitem(1, 'banco', f_banco_asociado_a_forma_pago(string(data)))

	CASE 'tipo'
		if data = 'I' then this.setitem(1, 'descripcion', 'INGRESO')
		if data = 'R' then 
			this.setitem(1, 'descripcion', 'RETIRADA')
			this.setitem(1, 'n_copias', '0')
		end if
END CHOOSE

end event

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;// No permitimos hacer nada con las lineas
am_dw.m_table.m_addrow.enabled = false
am_dw.m_table.m_insert.enabled = false
am_dw.m_table.m_delete.enabled = false
end event

type cb_2 from u_cb within w_ing_ret
integer x = 2373
integer y = 856
integer width = 549
integer taborder = 50
boolean bringtotop = true
string text = "&Salir"
boolean cancel = true
end type

event clicked;call super::clicked;closewithreturn(parent,'')
end event

type dw_2 from u_dw within w_ing_ret
boolean visible = false
integer x = 3598
integer y = 132
integer width = 3442
integer height = 444
integer taborder = 0
string dataobject = "d_apuntes_automaticos"
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.SetTransObject(bd_ejercicio)
end event

type cb_previsualizar from commandbutton within w_ing_ret
integer x = 37
integer y = 856
integer width = 549
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Confirmar Operaci$$HEX1$$f300$$ENDHEX$$n"
end type

event clicked;string mensaje = '', num_talon, ctabanco, cuenta_presupuestaria, cuenta, descrip, id_traspaso, formadepago
string banco, centro, proyecto, id_persona, tip, concepto_base, n_traspaso
long cuantos, i
datetime fecha, f_venc
double importe

dw_1.accepttext()

//SCP-166 Verificamos que el ejercicio contable esta abierto
if NOT f_ejercicio_abierto(g_ejercicio) then
	Messagebox(g_titulo,'El ejercicio contable '+ g_ejercicio + ' no est$$HEX2$$e1002000$$ENDHEX$$abierto. No es posible continuar con el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n.',stopsign!)
	return
end if


// No me gusta este tipo de mensajes pero los dejamos
if isnull(g_num_digitos) or g_num_digitos > 10 or g_num_digitos < 6 then mensaje = mensaje + cr + "g_num_digitos"
if f_es_vacio(g_conta.cuenta_clientes_general) then mensaje = mensaje + cr + "g_conta.cuenta_clientes_general"
if f_es_vacio(g_prefijo_arqui) then mensaje = mensaje + cr + "g_prefijo_arqui"
if f_es_vacio(g_sica_diario.ing_retira) then mensaje = mensaje + cr + "g_sica_diario.ing_retira"
if f_es_vacio(g_t_asiento_apuntes_automaticos) then mensaje = mensaje + cr + "g_t_asiento_apuntes_automaticos"
if f_es_vacio(g_t_doc_recibos_sica) then mensaje = mensaje + cr + "g_t_doc_talon" 
if f_es_vacio(g_centro_por_defecto) then mensaje = mensaje + cr + "g_centro_por_defecto"

if f_es_vacio(g_centro_por_defecto) then mensaje = mensaje + cr + "g_centro_por_defecto"
if f_es_vacio(g_prefijo_cuenta_bancaria_col) then mensaje = mensaje + cr + "g_prefijo_cuenta_bancaria_col"

if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)//mensaje = mensaje + cr + "g_explotacion_por_defecto"
if f_es_vacio(g_explotacion_por_defecto) then mensaje = mensaje + cr + "g_explotacion_por_defecto"

select count(*) into :cuantos from csi_bancos where cuenta_contable = null or cuenta_contable = '';
if cuantos > 0 then Messagebox(g_titulo,"Hay bancos sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso.",Stopsign!)

if mensaje <> '' then
	mensaje = 'Hay que definir las siguientes variables para poder contabilizar:' + cr + mensaje
	messagebox(g_titulo,mensaje,Stopsign!)
	Messagebox(g_titulo,'De momento les pondremos valores por defecto, pero no se debe poner en marcha si se lee este mensaje!!!',Stopsign!)
	if Messagebox(g_titulo,'$$HEX1$$bf00$$ENDHEX$$Desea Continuar? ',Question!, YesNo!) = 2 then return
end if

// Validaciones
mensaje = ''
importe = dw_1.GetItemNumber(1,'importe')
if isnull(importe) then importe = 0
if importe=0 then mensaje+=cr+"Debe especificar un valor en el campo Importe."
mensaje += f_valida(dw_1, 'fecha', 'NONULO', "Debe especificar un valor en el campo Fecha.")
mensaje += f_valida(dw_1, 'id_colegiado', 'NOVACIO', "Debe especificar un valor en el campo Colegiado.")
mensaje += f_valida(dw_1, 'forma_pago', 'NOVACIO', "Debe especificar un valor en el campo Forma Pago.")
//mensaje += f_valida(dw_1, 'banco', 'NOVACIO', "Debe especificar un valor en el campo Banco.")

// Miramos que el a$$HEX1$$f100$$ENDHEX$$o est$$HEX2$$e9002000$$ENDHEX$$dentro del ejercicio actual
if string(year(date(dw_1.GetItemDateTime(1,'fecha')))) <> g_ejercicio then
	mensaje+=cr+"La fecha del movimiento no pertenece al a$$HEX1$$f100$$ENDHEX$$o actual abierto, por lo que no es posible realizar este movimiento"
end if

if mensaje<>'' then
	Messagebox(g_titulo, mensaje, stopsign!)
	return 
end if

// Comprobamos el saldo de la cuenta del colegiado en los retira, si es negativo mostramos la ventana y no se deja continuar
if dw_1.GetItemString(1,'tipo') = 'R' and not f_es_vacio(g_prefijo_cuenta_bancaria_col) then
	st_saldo_cuenta_bancaria_colegiado lst_entrada
	lst_entrada.id_colegiado = dw_1.GetItemString(1,'id_colegiado')
	lst_entrada.f_desde = datetime(date('01/01/'+g_ejercicio),time('00:00'))
	lst_entrada.f_hasta = datetime(Today(), time('23:59:59'))

	double saldo
	saldo = f_saldo_cuenta_bancaria_col(lst_entrada.id_colegiado, lst_entrada.f_desde, lst_entrada.f_hasta)

	if saldo < dw_1.GetItemNumber(1,'importe') then
		openwithparm(w_saldo_cuenta_bancaria_colegiado, lst_entrada)
		messagebox(g_titulo, "No es posible realizar esta operaci$$HEX1$$f300$$ENDHEX$$n", exclamation!)	
		return
	end if
end if


this.enabled = false

////Para asegurarnos que si se cumplen las condiciones de imprimir tal$$HEX1$$f300$$ENDHEX$$n que el n$$HEX1$$fa00$$ENDHEX$$mero de tal$$HEX1$$f300$$ENDHEX$$n no sea nulo
//if (t='R') and (f_pago='TA') and (imp_tal='S') then 
//	mensaje +=f_valida(dw_1,'n_talon','NOVACIO','Debe especificar un valor en el campo Tal$$HEX1$$f300$$ENDHEX$$n.')
//end if
//

i_asiento = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.ing_retira,7))
i_asiento = i_asiento - 1
if isnull(i_asiento) then i_asiento = 0

// Pillamos los valores que son ncesarios para generar
fecha 		= dw_1.GetItemDateTime(1,'fecha')
importe 		= dw_1.GetItemNumber(1,'importe')
formadepago = dw_1.GetItemString(1,'forma_pago')
banco 		= dw_1.GetItemString(1,'banco')
centro 		= g_centro_por_defecto
proyecto 	= g_explotacion_por_defecto
tip 			= dw_1.GetItemString(1,'tipo')
id_persona 	= dw_1.GetItemString(1,'id_colegiado')
num_talon	= dw_1.getitemstring(1,'n_talon')
n_traspaso 	= dw_1.getitemstring(1,'numero')
descrip	 	= dw_1.getitemstring(1,'descripcion')
centro 		= dw_1.GetItemString(1,'centro')

if f_es_vacio(banco) then banco = g_banco_por_defecto
if f_es_vacio(proyecto) then proyecto = g_explotacion_por_defecto

// Descripci$$HEX1$$f300$$ENDHEX$$n del apunte
if f_es_vacio(descrip) then
	if (tip='I') then concepto_base = 'Ingresa' else concepto_base = 'Retira'
else
	concepto_base = descrip
end if

cuenta = f_dame_cuenta_col(id_persona, 'CP')

//Cogemos la Cta. del Banco de la Cuenta Contable del Banco que seleccionamos para la remesa
SELECT cuenta_contable INTO :ctabanco  
FROM csi_bancos WHERE codigo = :banco  and empresa=:g_empresa ;

//Rellenamos DATOS GENERALES DE G_APUNTE
i_asiento++
g_apunte.n_asiento = RightA('0000000' + trim(string(i_asiento)),7)
g_apunte.n_apunte = '00000'
g_apunte.n_doc = n_traspaso
g_apunte.fecha = datetime(date(fecha), time("00:00:00"))
g_apunte.t_asiento = g_t_asiento_apuntes_automaticos
g_apunte.id_interno = '' // Vaciamos el id interno
g_apunte.diario = g_sica_diario.ing_retira
g_apunte.proyecto = proyecto
g_apunte.centro = centro
g_apunte.cta_presupuestaria = cuenta_presupuestaria	
choose case formadepago
	case g_formas_pago.transferencia
		g_apunte.t_doc = g_sica_t_doc.transferencia
	case g_formas_pago.talon
		g_apunte.t_doc = g_sica_t_doc.talon
	case else
		g_apunte.t_doc = g_sica_t_doc.generico
end choose

//Seg$$HEX1$$fa00$$ENDHEX$$n el tipo seleccionamos Ingresa o Retira 
choose case tip
	CASE 'I'
		// Abono a Banco
		g_apunte.concepto = LeftA(concepto_base,57)
		g_apunte.cuenta = cuenta
		g_apunte.debe = 0
		g_apunte.haber = importe
		f_apunte_dw(g_apunte,dw_2,'E')
		
		g_apunte.concepto = LeftA(concepto_base,57)
		g_apunte.cuenta = ctabanco
		g_apunte.debe = importe
		g_apunte.haber = 0
		f_apunte_dw(g_apunte,dw_2,'E')	
	CASE 'R'
		// Cargo a la Cuenta del colegiado
		g_apunte.concepto = LeftA(concepto_base,57) // cuando sea TL y se haya generado un n$$HEX1$$fa00$$ENDHEX$$mero concatenarlo al concepto
		g_apunte.cuenta = ctabanco
		g_apunte.debe = 0
		g_apunte.haber = importe
		f_apunte_dw(g_apunte,dw_2,'E')
		
		g_apunte.concepto = LeftA(concepto_base,57) // cuando sea TL y se haya generado un n$$HEX1$$fa00$$ENDHEX$$mero concatenarlo al concepto
		g_apunte.cuenta =cuenta
		g_apunte.debe = importe
		g_apunte.haber = 0
		f_apunte_dw(g_apunte,dw_2,'E')	
end choose

// Grabamos
dw_1.update()
dw_2.update()


// Imprimimos el talon
if (tip='R') and (formadepago='TA') and (dw_1.getitemstring(1,'imprimir_talon')='S') and (num_talon<>'') then
	f_venc =  dw_1.getitemdatetime(1,'f_vencimiento')
	id_traspaso = dw_1.getitemstring(1, 'id_traspaso')
	
	datastore ds_talon
	ds_talon = create datastore
	ds_talon.dataobject = g_ing_ret_talon
	ds_talon.settransobject(sqlca)
	ds_talon.retrieve(id_traspaso)
	messagebox(g_titulo,'Se va a imprimir el tal$$HEX1$$f300$$ENDHEX$$n n$$HEX1$$ba00$$ENDHEX$$: '+num_talon)
	ds_talon.Modify("fecha_vencimiento.Text='"+string(f_venc, "DD/MM/YYYY")+"'")
	ds_talon.Modify("fecha_vencimiento_talon.Text='"+string(day(date(f_venc))) + space(14)+ Upper(f_obtener_mes(f_venc)) + FillA(' ', 30 - LenA(f_obtener_mes(f_venc))) + string(year(date(f_venc)))+"'")
	// Imprimimos
	ds_talon.print()
	destroy ds_talon
end if


// Creamos un datastore para imprimir el recibo
datastore ds_recibo
ds_recibo=create datastore
if dw_1.getitemstring(1,'tipo')='I' then 
	ds_recibo.dataobject=g_ing_ret_ingresa
else
	ds_recibo.dataobject=g_ing_ret_retira
end if
// Colocamos los valores para la impresion      
ds_recibo.insertrow(1)
ds_recibo.setitem(1,'importen',dw_1.getitemnumber(1,'importe'))
ds_recibo.setitem(1,'id_col',dw_1.getitemstring(1,'id_colegiado'))	

// Imprimimos
int copias
copias = double(dw_1.getitemstring(1, 'n_copias'))
for i=1 to copias
	ds_recibo.print()
next
// Destruimos el datastore
destroy ds_recibo

// Actualizamos la base de datos de contabilidad
f_actualiza_numero_bd_ejercicio(g_sica_diario.ing_retira, i_asiento)

messagebox(g_titulo, "Se ha generado el asiento n$$HEX2$$ba002000$$ENDHEX$$" + string(i_asiento), information!)

parent.event pfc_postopen()

this.enabled = true
end event

type gb_1 from groupbox within w_ing_ret
boolean visible = false
integer x = 3552
integer y = 76
integer width = 3534
integer height = 536
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Asientos Generados:"
end type

