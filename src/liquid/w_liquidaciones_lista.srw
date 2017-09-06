HA$PBExportHeader$w_liquidaciones_lista.srw
forward
global type w_liquidaciones_lista from w_lista
end type
type dw_lista_facturas from u_dw within w_liquidaciones_lista
end type
type dw_informe from u_dw within w_liquidaciones_lista
end type
type st_indicador from statictext within w_liquidaciones_lista
end type
type cb_fact_individual from commandbutton within w_liquidaciones_lista
end type
type dw_fact_deducidas from u_dw within w_liquidaciones_lista
end type
type dw_2 from u_dw within w_liquidaciones_lista
end type
type dw_facturas_pendientes from u_dw within w_liquidaciones_lista
end type
type dw_lista_facturas_incluidas from u_dw within w_liquidaciones_lista
end type
end forward

global type w_liquidaciones_lista from w_lista
integer width = 4503
integer height = 2432
string title = "Lista Previa de Liquidaciones"
string menuname = "m_liquidaciones_lista"
boolean minbox = false
event csd_facturas_ptes ( )
event csd_contabilizar ( )
event csd_transferencias ( )
event csd_talones ( )
event csd_facturas ( )
event csd_informe ( )
event csd_saldos_deudores ( )
event csd_contabilizar_cuenta_personal ( integer fila )
dw_lista_facturas dw_lista_facturas
dw_informe dw_informe
st_indicador st_indicador
cb_fact_individual cb_fact_individual
dw_fact_deducidas dw_fact_deducidas
dw_2 dw_2
dw_facturas_pendientes dw_facturas_pendientes
dw_lista_facturas_incluidas dw_lista_facturas_incluidas
end type
global w_liquidaciones_lista w_liquidaciones_lista

type variables



end variables

forward prototypes
public subroutine wf_devolucion (integer fila)
public function integer wf_liq_anula ()
public subroutine wf_calcula_deudas (ref double saldo_deudor, double deudas_facturas, integer fila, double importes_anteriores)
public function integer wf_generar_liquidacion (string tipo)
public function string wf_cuenta_contable_fp (string as_formapago)
public subroutine wf_crear_apunte (datetime fecha, string cuenta, string concepto, double debe, double haber, string orden_apunte, string contrapartida)
end prototypes

event csd_facturas_ptes();if dw_lista.rowcount() > 0 then
	
///***SCP-1060. Alexis. Se aprovech$$HEX2$$f3002000$$ENDHEX$$para bloquear este acceso (SCP-811) , ya que en Navarra comentaron que no lo utilizan ***///	
//	if g_colegio = 'COAATNA' then 
//		Open(w_liquidaciones_descontar_fact)
//	else
		/***************************************************/
			st_facturas datos
			string id_liq
			long ll_fila,ll_primera_fila_visible,ll_primera_fila_despues
			
			id_liq=dw_lista.getitemstring(dw_lista.getrow(),'id_liquidacion')
			
			datos.id_receptor = dw_lista.getitemstring(dw_lista.getrow(),'id_colegiado')
			datos.id_liquidacion = dw_lista.getitemstring(dw_lista.getrow(),'id_liquidacion')
			datos.id_fase = dw_lista.getitemstring(dw_lista.getrow(),'id_fase')
			
			//Obtenemos la fila seleccionada
			ll_fila=dw_lista.getrow()
			//Obtenemos la primera fila visible del dw
			dw_lista.setredraw(false)
			////dw_lista.scrollnextrow()
			////ll_primera_fila_visible=dw_lista.scrollpriorrow()
			dw_lista.setredraw(true)
			
			if dw_lista.getitemstring( ll_fila, 'estado') = 'P' then
			
				OpenWithParm(w_factufa_facturas_sin_liquidar,datos)
						
				dw_lista.setredraw(false)
				this.event csd_actualiza_listas()
		//		
		//		//Volvemos a la fila donde est$$HEX1$$e100$$ENDHEX$$bamos antes
		//		dw_lista.scrolltorow(ll_primera_fila_visible)
		//		dw_lista.selectrow(ll_primera_fila_visible,false)
		//		
		//		//Obtenemos la primera fila visible del dw...
		//		dw_lista.scrollnextrow()
		//		ll_primera_fila_despues=dw_lista.scrollpriorrow()
		//		
		//		//..y comprobamos que sea la misma que la primera visible antes
		//		do while ll_primera_fila_despues<ll_primera_fila_visible
		//			ll_primera_fila_despues=dw_lista.scrollnextrow()
		//		loop
				
				//Marcamos la fila que estaba marcada antes
				
				dw_lista.setrow(ll_fila)
				dw_lista.selectrow(ll_fila,true)
				dw_lista.setredraw(true)
			else
				messagebox(g_titulo, 'No puede agregar facturas a una liquidaci$$HEX1$$f300$$ENDHEX$$n que no est$$HEX2$$e9002000$$ENDHEX$$en estado pendiente')
			end if	
//	end if
end if




end event

event csd_contabilizar();// Modificado Ricardo 04-03-15
if not g_contabilidad_automatica then return

//SCP-166 Verificamos que el ejercicio contable esta abierto
if NOT f_ejercicio_abierto(g_ejercicio) then
	Messagebox(g_titulo,'El ejercicio contable '+ g_ejercicio + ' no est$$HEX2$$e1002000$$ENDHEX$$abierto. No es posible continuar con el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n.',stopsign!)
	return
end if

dw_lista.AcceptText()

long cuantos, asiento
string mensaje = '', desc_banco, formapago_ant, ctabanco_d, descp_breve, formapago_ult, n_registro
string mensajeLiquidacion = ''
int continuar, i
boolean seguir=false
datetime fecha, fecha_anterior
double importe, saldo = 0, saldo_deudor = 0, total_asiento = 0
string estado, concepto_base, concepto, formadepago, id_colegiado, cuenta_col, cliente, n_expedi, id_minuta
string ctabanco, contabilizada, n_documento, id_cli, cuenta_presupuestaria, modo_contabilizacion, n_visado
long fila
string n_asiento, n_asiento_old, n_asiento_renumerado
// ------ Pre-contabilizaci$$HEX1$$f300$$ENDHEX$$n
if isnull(g_num_digitos) or g_num_digitos > 10 or g_num_digitos < 6 then mensaje = mensaje + cr + "g_num_digitos"
if f_es_vacio(g_conta.cuenta_clientes_general) then mensaje = mensaje + cr + "g_conta.cuenta_clientes_general"
if f_es_vacio(g_prefijo_arqui) then mensaje = mensaje + cr + "g_prefijo_arqui"
if f_es_vacio(g_sica_diario.liq_honos) then mensaje = mensaje + cr + "g_sica_diario.liq_honos"
if f_es_vacio(g_t_asiento_apuntes_automaticos) then mensaje = mensaje + cr + "g_t_asiento_apuntes_automaticos"
if f_es_vacio(g_sica_t_doc.transferencia) then mensaje = mensaje + cr + "g_sica_t_doc.transferencia" 
if f_es_vacio(g_sica_t_doc.talon) then mensaje = mensaje + cr + "g_sica_t_doc.talon" 
if f_es_vacio(g_centro_por_defecto) then mensaje = mensaje + cr + "g_centro_por_defecto"

if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)//mensaje = mensaje + cr + "g_explotacion_por_defecto"
if f_es_vacio(g_explotacion_por_defecto) then mensaje = mensaje + cr + "g_explotacion_por_defecto"

select count(*) into :cuantos from csi_bancos where cuenta_contable = null or cuenta_contable = '';
if cuantos > 0 then Messagebox(g_titulo,"Hay bancos sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso.",Stopsign!)


if mensaje <> '' then
	mensaje = 'Hay que definir las siguientes variables para poder contabilizar:' + cr + mensaje
	messagebox(g_titulo,mensaje,Stopsign!)
	Messagebox(g_titulo,'De momento les pondremos valores por defecto, pero no se debe poner en marcha si se lee este mensaje!!!',Stopsign!)
	continuar = Messagebox(g_titulo,'$$HEX2$$bf002000$$ENDHEX$$Desea Continuar ? ',Question!, YesNo!)
	if continuar = 2 then return	
end if

for i = 1 to dw_lista.RowCount()
	yield()
	estado = dw_lista.GetItemString(i,'estado')
	if estado <> 'L' then continue
	contabilizada = dw_lista.GetItemString(i,'contabilizada')
	if contabilizada = 'S' then continue	
	if string(year(date(dw_lista.GetItemDateTime(i,'f_liquidacion'))))<>g_ejercicio then
		messagebox(g_titulo, "Algunas de las liquidaciones a contabilizar no pertenecen al ejercicio actual (fila "+string(i)+")", stopsign!)
		return 
	end if
	/*if f_es_vacio(string(dw_lista.GetItemDateTime(i,'f_liquidacion'))) then
		messagebox(g_titulo, "Algunas de las liquidaciones a contabilizar no tienen fecha de liquidaci$$HEX1$$f300$$ENDHEX$$n (fila " +string(i) + ")", stopsign!)
		return
	end if*/
next


if f_es_vacio(g_conta.cuenta_clientes_general) then g_conta.cuenta_clientes_general = '4400000'
if f_es_vacio(g_prefijo_arqui) then g_prefijo_arqui = '430'

// Vamos a contabilizar primero en un proceso aparte las que son por cuenta personal
dw_lista.Setsort("forma_pago A")
dw_lista.sort()
for i = 1 to dw_lista.rowcount()
	if dw_lista.GetItemString(i,'forma_pago') = g_formas_pago.cuenta_personal then event csd_contabilizar_cuenta_personal(i)
next


// 
//modo_contabilizacion = dw_modo_liq.getitemstring(1, 'modo_contabilizacion')
asiento = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.liq_honos,7))
if isnull(asiento) then asiento = 0
dw_lista.Setsort("f_liquidacion A, forma_pago A")
dw_lista.sort()
setnull(fecha_anterior)
setnull(formapago_ant)


g_apunte.diario = g_sica_diario.liq_honos
g_apunte.proyecto = g_explotacion_por_defecto
g_apunte.centro = g_centro_por_defecto
g_apunte.n_apunte = '00000'

for i = 1 to dw_lista.RowCount()
	// Permitimos otros eventos
	yield()
	estado = dw_lista.GetItemString(i,'estado')
	if estado <> 'L' then continue // Solo miramos las liquidadas
	contabilizada = dw_lista.GetItemString(i,'contabilizada')
	if contabilizada = 'S' then continue	// No contabilizadas, claro
	if f_es_vacio(string(dw_lista.GetItemDateTime(i,'f_liquidacion'))) then
		mensajeLiquidacion = mensajeLiquidacion  + "Algunas de las liquidaciones a contabilizar no tienen fecha de liquidaci$$HEX1$$f300$$ENDHEX$$n (fila "+string(i)+")" + CR
		//messagebox(g_titulo, "Algunas de las liquidaciones a contabilizar no tienen fecha de liquidaci$$HEX1$$f300$$ENDHEX$$n (fila "+string(i)+")", Information!,Ok!)
		continue
	end if 	
	formadepago 	= dw_lista.GetItemString(i,'forma_pago')
	ctabanco		 	= dw_lista.GetItemString(i,'banco')
	fecha 			 	= dw_lista.GetItemDateTime(i,'f_liquidacion')
	importe 		 	= dw_lista.GetItemNumber(i,'importe')
	id_colegiado 	= dw_lista.GetItemString(i,'id_colegiado')
	id_minuta 	 	= dw_lista.GetItemString(i,'id_fase')
	n_documento 	= dw_lista.GetItemString(i,'n_documento')
	
	if isnull(formapago_ant)   then formapago_ant =  dw_lista.GetItemstring(i,'forma_pago')
	
	SELECT fases.n_expedi, fases.archivo, fases.n_registro  
    	INTO :n_expedi, :n_visado,  :n_registro
   	 FROM fases,   
         fases_minutas,
			fases_liquidaciones
  	 WHERE ( fases.id_fase = fases_minutas.id_fase ) and  
			( fases_minutas.id_minuta = fases_liquidaciones.id_fase ) and  
         ( ( fases_liquidaciones.id_fase = :id_minuta ) )   ;

	concepto_base=''
	
	// Modificado David - 10/11/2005 - Poner n$$HEX2$$ba002000$$ENDHEX$$exp o n$$HEX2$$ba002000$$ENDHEX$$visado
	CHOOSE CASE g_colegio
		CASE 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATA','COAATNA',  'COAATTGN', 'COAATTEB', 'COAATTER', 'COAATMCA', 'COAATLL'
			
			///*** SCP-901. Alexis. 25/01/2011. Se modifica para que se cree una dependencia parametrizada mediante la var_global g_conta_concepto_solo_n_registros ***///
			if g_conta_concepto_solo_n_registros = 'S' then
				concepto_base = 'N$$HEX1$$ba00$$ENDHEX$$Reg. ' + ' ' + n_registro
			else	
				concepto_base = 'V$$HEX2$$ba002000$$ENDHEX$$' + ' ' + n_visado
			end if	
			if f_es_vacio(concepto_base ) then concepto_base = n_registro
		CASE ELSE
			concepto_base = g_conta.concepto_exp +' ' + n_expedi
	END CHOOSE
	
	if formapago_ant <> formadepago then
		asiento++
		g_apunte.n_apunte = '00000'
	end if
	
	g_apunte.n_asiento = RightA('0000000' + trim(string(asiento)),7)
	g_apunte.n_doc = n_documento
	g_apunte.id_interno = dw_lista.GetItemString(i,'id_liquidacion')
	g_apunte.fecha = datetime(date(fecha), time("00:00:00"))
	g_apunte.t_asiento = f_t_asiento_liquidacion ( ) 	
	g_apunte.cta_presupuestaria = cuenta_presupuestaria	

	choose case formadepago
		case g_formas_pago.transferencia
			g_apunte.t_doc = g_sica_t_doc.transferencia
		case g_formas_pago.talon
			g_apunte.t_doc = g_sica_t_doc.talon
		case g_formas_pago.metalico
			g_apunte.t_doc ='ME'
		case else
			g_apunte.t_doc = g_sica_t_doc.generico
	end choose

	if formadepago = g_formas_pago.cuenta_personal then
		cuenta_col = f_dame_cuenta_col(id_colegiado, 'CP')
	else
		if dw_lista.GetItemString(i,'tipo') <> '0' then // Si es una devolucion
			cuenta_col = f_dame_cuenta_col(id_colegiado,'G')
		else
			cuenta_col = f_dame_cuenta_col(id_colegiado,'P')
		end if
	end if
	
	id_cli = f_minutas_id_cli(id_minuta)
	cliente = f_dame_cliente(id_cli)
	concepto_base = concepto_base + ' ' + cliente
	if  dw_lista.getitemstring(i, 'tipo')<>'0' and dw_lista.getitemstring(i, 'tipo')<>'9' then
		concepto = LeftA('Ab.Ing ' + concepto_base,57)
	else
		concepto = LeftA('Liq.Hon ' + concepto_base,57)
	end if

	// Cuando es una liquidaci$$HEX1$$f300$$ENDHEX$$n manual que coja el concepto introducido
	string conc
	conc = dw_lista.GetItemString(i,'concepto')
	if id_minuta = 'LIQMANUAL' and not f_es_vacio(conc) then	concepto = LeftA(conc,57)
	// Cuando es un extorno que coja el concepto introducido y a$$HEX1$$f100$$ENDHEX$$ada el colegiado
	if id_minuta = 'EXTORNO' and not f_es_vacio(conc) then
		string nombre
		nombre =	 f_colegiado_apellido(id_colegiado)
		if f_es_vacio(nombre) then nombre = ''
		conc = conc + ' ' + nombre		
		concepto = LeftA(conc,57)
	end if

	// Apunte por el debe
	wf_crear_apunte(datetime(date(fecha), time("00:00:00")),cuenta_col, concepto, importe, 0, '00',ctabanco)
	
	total_asiento += importe
	dw_lista.SetItem(i,'contabilizada','S')
	
//	Si es una devoluci$$HEX1$$f300$$ENDHEX$$n se ponen las facturas y los cobros como pagados
	if dw_lista.getitemstring(i, 'tipo') = '1' then wf_devolucion(i)
	
	if isnull(fecha_anterior) then fecha_anterior = dw_lista.GetItemDateTime(i,'f_liquidacion')
	
	// Si no se tiene banco se busca la cuenta contable asociada de la forma de pago
	if f_es_vacio(ctabanco) then
		select cuenta, descripcion_breve into :ctabanco_d, :descp_breve from csi_formas_de_pago where tipo_pago = :formadepago;
		ctabanco = ctabanco_d
	else
		select nombre into :desc_banco from csi_bancos where cuenta_contable = :ctabanco;
		select  descripcion_breve into  :descp_breve from csi_formas_de_pago where tipo_pago = :formadepago;
		ctabanco_d = ctabanco
	end if
		
	// Se busca el concepto
	Concepto ='Pago liquidaci$$HEX1$$f300$$ENDHEX$$n en '+ lower( descp_breve ) //+ctabanco

	if formadepago <> 'TR' then
		// Cargo a Banco apunte por el haber
		wf_crear_apunte(datetime(date(fecha), time("00:00:00")),ctabanco, concepto,0, importe, '00',cuenta_col)
		total_asiento = 0
		if (date(fecha_anterior)<>date(dw_lista.GetItemDateTime(i,'f_liquidacion'))) then
			asiento++
			g_apunte.n_apunte = '00000'
		 elseif (  i<dw_lista.RowCount() ) then
			if (formadepago = dw_lista.GetItemstring(i+1,'forma_pago'))    and ( date(dw_lista.GetItemDateTime(i,'f_liquidacion'))<>date(dw_lista.GetItemDateTime(i+1,'f_liquidacion'))) then 
				asiento++
				g_apunte.n_apunte = '00000'
			end if
		end if
		 formapago_ult = formadepago
	
else
	
	if  ((formapago_ant<> formapago_ult)  and ( formapago_ult<>'')) then 
		seguir = true
	elseif (  i=dw_lista.RowCount()) then 
		seguir = true
	elseif (  i<dw_lista.RowCount() and (formadepago<>dw_lista.GetItemstring(i+1,'forma_pago'))  ) then 
		seguir = true
	elseif (  i<dw_lista.RowCount() and (formadepago = dw_lista.GetItemstring(i+1,'forma_pago'))  )  and ( date(dw_lista.GetItemDateTime(i,'f_liquidacion'))<>date(dw_lista.GetItemDateTime(i+1,'f_liquidacion'))) then 
		asiento++
		g_apunte.n_apunte = '00000'
		seguir = true
	elseif ( date(fecha_anterior)<>date(dw_lista.GetItemDateTime(i,'f_liquidacion')))  and (formapago_ant<> 'TR')then
		seguir = true
	end if
	if seguir then
		g_apunte.n_doc = ''
		// Cargo a Banco Apunte al debe
		wf_crear_apunte(datetime(date(fecha), time("00:00:00")),ctabanco_d, concepto,0,  f_redondea(total_asiento), '00','')		
		total_asiento = 0
		g_apunte.n_apunte = '00000'
		seguir=false
	end if
end if
fecha_anterior = fecha
formapago_ant = formadepago
	
next



if dw_2.RowCount()>0 then
	n_asiento = "-1"
	n_asiento_old = ''
	FOR fila = 1 to dw_2.RowCount()
		n_asiento = dw_2.getitemstring(fila, 'n_asiento')
		// Si cambia de asiento/diario, renumeramos de nuevo
		if n_asiento <> n_asiento_old  then
			n_asiento_renumerado = f_siguiente_numero_bd_ejercicio(g_sica_diario.liq_honos,7) // ESto asegura que los numeros de asiento se hagan bien
		end if
		// Cambiamos el asiento segun
		dw_2.SetItem(fila, 'n_asiento', n_asiento_renumerado)
		// Mantenemos los datos de la iteracion anterior
		n_asiento_old = n_asiento
	
	NEXT
	dw_lista.Update()
	dw_lista.groupcalc()
	dw_2.Update()
	dw_2.reset()
end if

if not  f_es_vacio(mensajeLiquidacion) then 
	messagebox(g_titulo, mensajeLiquidacion, Information!,Ok!)
end if 
	messagebox(g_titulo, 'Proceso Finalizado')

end event

event csd_transferencias();if dw_lista.rowcount()>0 then wf_generar_liquidacion("TR")
end event

event csd_talones();if dw_lista.rowcount()>0 then wf_generar_liquidacion("TA")
end event

event csd_facturas;long i,j, k
string id_fase, id_col, id_factura, tipo_fact, id_liq
st_imprimir_factura_obj_impr  st_imp_fact, lst_tipo_fact
//Messagebox(g_titulo,'Consideramos el tipo de facturas 03: emisor el colegio y receptor el colegiado',Information!)

double num_facturas=0



//Modificado Yexaira  27-08-2007
//Se abre la ventana de selecci$$HEX1$$f300$$ENDHEX$$n de tipo de facturas
open(w_factu_e_tipo_fact)
lst_tipo_fact = Message.powerobjectparm
// Verificamos si el tipo seleccionado existe en el dw

dw_lista_facturas.setredraw(FALSE)
FOR i=1 TO dw_lista.RowCount()
	// Informamos del n$$HEX2$$ba002000$$ENDHEX$$de facturas que se van a imprimir
	id_fase = dw_lista.GetItemString(i,'id_fase')
	id_col  = dw_lista.GetItemString(i,'id_colegiado')
	dw_lista_facturas.Retrieve(id_fase, id_col)
	//num_facturas += dw_lista_facturas.rowcount()
	for k= 1 to lst_tipo_fact.n_tipo
		for j = 1 to dw_lista_facturas.RowCount()
			if dw_lista_facturas.GetItemString(j,'tipo_factura') =   lst_tipo_fact.tipo_fact[k] then
				num_facturas =num_facturas+1
			end if
		next
	next
	// Ahora tambi$$HEX1$$e900$$ENDHEX$$n sumamos las facturas pendientes deducidas de las liquidaciones
	id_liq = dw_lista.GetItemString(i,'id_liquidacion')
	dw_fact_deducidas.Retrieve(id_liq)
	num_facturas += dw_fact_deducidas.rowcount()
NEXT

if num_facturas = 0 then return
//esto cambiar$$HEX1$$ed00$$ENDHEX$$a

messagebox(g_titulo, "Se van a imprimir " + string(num_facturas) + " facturas.")

// Pedimos el n$$HEX2$$ba002000$$ENDHEX$$de originales y copias de cada factura
long ll_originales,ll_copias
string ls_valretorno,ls_n_fact,ls_valoremail
n_csd_impresion_formato l_uo_impresion_formato

l_uo_impresion_formato=create n_csd_impresion_formato

l_uo_impresion_formato.papel='S'

st_w_factu_e_imprimir l_st_w_factu
l_st_w_factu.varias_facturas=true
l_st_w_factu.impresion_formato=l_uo_impresion_formato

openwithparm(w_factu_e_imprimir,l_st_w_factu)

ls_valretorno=Message.stringparm

 if ls_valretorno = 'CANCELAR' then 
	return
end if

ls_valoremail=l_uo_impresion_formato.email
ll_originales=l_uo_impresion_formato.copias
ll_copias=long(ls_valretorno)


if ll_originales>0 or ll_copias>0 then
	SetPointer(HourGlass!)
	FOR i=1 TO dw_lista.RowCount()
		id_fase = dw_lista.GetItemString(i,'id_fase')
		id_col  = dw_lista.GetItemString(i,'id_colegiado')
		dw_lista_facturas.Retrieve(id_fase, id_col)
		FOR j=1 TO dw_lista_facturas.RowCount()
			id_factura = dw_lista_facturas.GetItemString(j,'id_factura')
			tipo_fact = dw_lista_facturas.GetItemString(j,'tipo_factura')
			ls_n_fact=f_dame_n_fact_de_id(id_factura)
			//	if tipo_fact <> '03' then continue

			//st_imprimir_factura_obj_impr st_imp_fact
			st_imp_fact.id_factura = id_factura
			st_imp_fact.id_persona = id_col
			st_imp_fact.tipo = tipo_fact
			st_imp_fact.copia = 'N'
			//st_imp_fact.num_copias = ll_originales
			st_imp_fact.dw = dw_lista_facturas
			st_imp_fact.impresion_formato=l_uo_impresion_formato
			st_imp_fact.impresion_formato.copias=ll_originales
			st_imp_fact.impresion_formato.nombre=ls_n_fact
     		st_imp_fact.impresion_formato.asunto_email='Factura '+ls_n_fact
     
			for k = 1 to lst_tipo_fact.n_tipo
				if tipo_fact =   lst_tipo_fact.tipo_fact[k] then
					if ll_originales> 0 then  f_imprimir_factura_objeto_impr(st_imp_fact)
					
					
					st_imp_fact.copia = 'S'
					st_imp_fact.impresion_formato.copias=ll_copias
					//Evitamos que envie el email 2 veces
					st_imp_fact.impresion_formato.email='N'
		
					//st_imp_fact.num_copias = ll_copias	
					
					if ll_copias > 0 then f_imprimir_factura_objeto_impr(st_imp_fact)
					
					//Imprimimos en pdf
					if st_imp_fact.impresion_formato.pdf='S' then
						st_imp_fact.copia = 'V'
						st_imp_fact.impresion_formato.copias=1
						f_imprimir_factura_objeto_impr(st_imp_fact)
					end if 
					//Restablecemos el valor original de email
					st_imp_fact.impresion_formato.email=ls_valoremail
				end if
			
			next
		NEXT
		id_liq = dw_lista.GetItemString(i,'id_liquidacion')
		dw_fact_deducidas.Retrieve(id_liq)
		FOR j=1 TO dw_fact_deducidas.RowCount()
			id_factura = dw_fact_deducidas.GetItemString(j,'id_factura')
			tipo_fact = dw_fact_deducidas.GetItemString(j,'tipo_factura')
			ls_n_fact=f_dame_n_fact_de_id(id_factura)
			
			st_imp_fact.id_factura = id_factura
			st_imp_fact.id_persona = id_col
			st_imp_fact.tipo = tipo_fact
			st_imp_fact.copia = 'N'
			//st_imp_fact.num_copias = ll_originales
			st_imp_fact.dw = dw_fact_deducidas
			st_imp_fact.impresion_formato.copias=ll_originales
			st_imp_fact.impresion_formato.nombre=ls_n_fact
     		st_imp_fact.impresion_formato.asunto_email='Factura '+ls_n_fact
     
			
			if ll_originales> 0 then f_imprimir_factura_objeto_impr(st_imp_fact)

			st_imp_fact.copia = 'S'
			st_imp_fact.impresion_formato.copias=ll_copias
			//Evitamos que envie el email 2 veces
			st_imp_fact.impresion_formato.email='N'
			//st_imp_fact.num_copias = ll_copias
			
			if ll_copias > 0 then f_imprimir_factura_objeto_impr(st_imp_fact)
			//Imprimimos en pdf
			if st_imp_fact.impresion_formato.pdf='S' then
				st_imp_fact.copia = 'V'
				st_imp_fact.impresion_formato.copias=1
			   f_imprimir_factura_objeto_impr(st_imp_fact)
			end if	
			//Restablecemos el valor original de email
			st_imp_fact.impresion_formato.email=ls_valoremail
		NEXT
	NEXT
end if
dw_lista_facturas.setredraw(TRUE) 

end event

event csd_informe();long i,ll_job
n_csd_impresion_formato uo_impresion
string id_fase,email,id_col,n_col,nom,app,n_colegiados,enviar_email,id_minuta
datetime f_entrada
string n_reg
datastore ds_impresion_facturas
uo_impresion=create n_csd_impresion_formato

if dw_lista.rowcount()<= 0 then return

uo_impresion.masivo=false
for i=2 to dw_lista.rowcount()
	if dw_lista.GetItemString(i,'id_colegiado')<>dw_lista.GetItemString(i - 1,'id_colegiado') then
		uo_impresion.masivo=true
		exit
	end if
next


setpointer(hourglass!)
dw_informe.reset()

//ll_job=printopen()


uo_impresion.copias=1
uo_impresion.generar_registro=g_formato_impresion.generar_registro
uo_impresion.tipo_receptor='C'
uo_impresion.serie='LIQUID'
uo_impresion.visualizar_web = 'N'
uo_impresion.email = 'N'
uo_impresion.pdf= 'N'
uo_impresion.papel='S'
uo_impresion.asunto_email="Liquidaci$$HEX1$$f300$$ENDHEX$$n XX-XXXXX"
uo_impresion.nombre="Liquidacion_XX-XXXXX"

//uo_impresion.masivo=true
uo_impresion.ruta_automatica=true
//uo_impresion.ll_printjob=ll_job
if not(uo_impresion.masivo) then
	id_col=dw_lista.GetItemString(1,'id_colegiado')
	select email into :email from colegiados where id_colegiado=:id_col;
	uo_impresion.direccion_email = email
end if
if uo_impresion.f_opciones_impresion()<=0 then return

enviar_email=uo_impresion.email 


//Como f_liquidacion_generar_informe cambia el dataobject de dw_informe
//no podemos acumular las filas de los informes e imprimirlas luego todas juntas.
//Usamos, en su lugar, un trabajo de impresi$$HEX1$$f300$$ENDHEX$$n
for i=1 to dw_lista.rowcount()
	uo_impresion.email=enviar_email
	//      MODIFICADO RICARDO 04-02-27
   // Las retenidas y anuladas las saltamos
	if dw_lista.getitemString(i, 'estado')  = 'R' or dw_lista.getitemString(i, 'estado')  = 'A' then continue
	//      MODIFICADO RICARDO 04-02-27
	
	f_liquidacion_generar_informe(dw_informe,dw_lista,i)
	dw_informe.groupcalc()
	//if dw_informe.RowCount()>0 then dw_informe.print()
//	printdatawindow(ll_job,dw_informe)


	id_minuta=dw_lista.GetItemString(i,'id_fase')
	n_reg=''

	//select n_registro,f_entrada into :n_reg,:f_entrada from fases where id_fase=:id_fase;
	select f.n_registro,f.f_entrada into :n_reg,:f_entrada from fases f,fases_minutas m where f.id_fase=m.id_fase and m.id_minuta=:id_minuta;
	uo_impresion.dw=dw_informe
	uo_impresion.id_receptor=dw_lista.GetItemString(i,'id_colegiado')
	uo_impresion.ruta_relativa2=string(year(date(f_entrada)))
	uo_impresion.ruta_relativa3=n_reg
	uo_impresion.asunto_email="Liquidaci$$HEX1$$f300$$ENDHEX$$n "+dw_lista.GetItemString(i,'id_liquidacion')
	uo_impresion.nombre="Liquidacion_"+dw_lista.GetItemString(i,'id_liquidacion')
	if uo_impresion.masivo then
		select email,n_colegiado,nombre,apellidos into :email,:n_col,:nom,:app from colegiados where id_colegiado=:uo_impresion.id_receptor;			
		if f_es_vacio(email) then
			n_col=n_col+'-'+nom+' '+app+cr
			if pos(n_colegiados,n_col)<=0 then n_colegiados+=n_col
			uo_impresion.direccion_email = ""
			uo_impresion.email='N'
		else
			uo_impresion.direccion_email = email
		end if
	end if
	uo_impresion.f_impresion()

next


//En algunos sitios quieren dos copias, pero de toda la remesa, no intercalando dos de cada
if g_colegio='COAATZ' or g_colegio = 'COAATGU' then
	for i=1 to dw_lista.rowcount()
		//      MODIFICADO RICARDO 04-02-27
		// Las retenidas y anuladas las saltamos
		if dw_lista.getitemString(i, 'estado')  = 'R' or dw_lista.getitemString(i, 'estado')  = 'A' then continue
		//      MODIFICADO RICARDO 04-02-27
		
		f_liquidacion_generar_informe(dw_informe,dw_lista,i)
		dw_informe.groupcalc()
		//if dw_informe.RowCount()>0 then dw_informe.print()
		//printdatawindow(ll_job,dw_informe)
		id_minuta=dw_lista.GetItemString(i,'id_fase')
		n_reg=''
		//select n_registro,f_entrada into :n_reg,:f_entrada from fases where id_fase=:id_fase;		
		select f.n_registro,f.f_entrada into :n_reg,:f_entrada from fases f,fases_minutas m where f.id_fase=m.id_fase and m.id_minuta=:id_minuta;

		uo_impresion.dw=dw_informe
		uo_impresion.id_receptor=dw_lista.GetItemString(i,'id_colegiado')
		uo_impresion.ruta_relativa2=string(year(date(f_entrada)))
		uo_impresion.ruta_relativa3=n_reg
		uo_impresion.asunto_email="Liquidaci$$HEX1$$f300$$ENDHEX$$n "+dw_lista.GetItemString(i,'id_liquidacion')
		uo_impresion.nombre="Liquidacion_"+dw_lista.GetItemString(i,'id_liquidacion')	
		// Si es masivo cogemos la direccion del colegiado, sino usamos la de la ventana
		uo_impresion.email = 'N'
		uo_impresion.pdf= 'N'
		uo_impresion.f_impresion()
	next
end if

if not(f_es_vacio(n_colegiados)) then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Los siguientes colegiados no tienen email:"+cr+n_colegiados)
end if
//dw_informe.sort()
//printclose(ll_job)
setpointer(arrow!)


end event

event csd_saldos_deudores();string id_col, coleg, lista_col, orden, id_col_ant='', sql_orig, sql_izq, sql_dcha, sql_mod
string id_col_list, estado
long i, j
datetime fecha
double importe

if dw_lista.rowcount() = 0 then return

datastore ds_sald
ds_sald = create datastore
ds_sald.dataobject = 'd_liquidacion_listado_saldos_deud'
ds_sald.SetTransObject(bd_ejercicio)

// Guardamos la ordenaci$$HEX1$$f300$$ENDHEX$$n que tiene el dw
orden = dw_lista.Describe ("DataWindow.Table.Sort")
dw_lista.setredraw(false)
dw_lista.setsort("id_colegiado")
dw_lista.sort()

// Recorremos la lista para obtener los colegiados
// Ordenamos por id_colegiado para meter solo una vez cada colegiado
for i=1 to dw_lista.rowcount()
	id_col = dw_lista.getitemstring(i, 'id_colegiado')
	if id_col <> id_col_ant and i>1 then coleg += ", " + id_col
	if i=1 then coleg = id_col
	id_col_ant = id_col
next

// Modificamos la select para que recupere solo sobre los que hay en la lista
sql_orig = ds_sald.describe("datawindow.table.select")

sql_izq = MidA(sql_orig, 1, PosA(sql_orig, "GROUP BY")-1)
sql_dcha = MidA(sql_orig, PosA(sql_orig, "GROUP BY"), LenA(sql_orig))
sql_mod = sql_izq + " and cuentas.id_col IN ("+f_coloca_comillas(coleg)+") " + sql_dcha

ds_sald.modify("datawindow.table.select= ~"" + sql_mod + "~"")

fecha = datetime(relativedate(today(),1),time('00:00'))
ds_sald.retrieve(g_prefijo_arqui+'%', fecha, 0)


if ds_sald.rowcount()=0 then
	messagebox(g_titulo, "No existen colegiados con saldo deudor")
else
	// Obtenemos el importe de las liquidaciones pendientes de los colegiados con saldo deudor
	for i=1 to ds_sald.rowcount()
		id_col_list = ds_sald.getitemstring(i, 'cuentas_id_col')
		importe=0		
		for j=1 to dw_lista.rowcount()
			id_col = dw_lista.getitemstring(j, 'id_colegiado')
			estado = dw_lista.getitemstring(j, 'estado')
			if id_col = id_col_list and estado = 'P' then importe += dw_lista.getitemnumber(j, 'importe')
		next
		ds_sald.setitem(i, 'liquidaciones', importe)
	next
	ds_sald.print()
end if

// Restauramos la ordenaci$$HEX1$$f300$$ENDHEX$$n anterior
dw_lista.setsort(orden)
dw_lista.sort()
dw_lista.setredraw(true)

destroy ds_sald

end event

event csd_contabilizar_cuenta_personal(integer fila);long cuantos, asiento
string mensaje = '', desc_banco
int continuar, i
datetime fecha, fecha_anterior
double importe, saldo = 0, saldo_deudor = 0, total_asiento = 0
string estado, concepto_base, concepto, formadepago, id_colegiado, cuenta_col, cliente, n_expedi, id_minuta
string ctabanco, contabilizada, n_documento, id_cli, cuenta_presupuestaria, modo_contabilizacion, n_visado

estado = dw_lista.GetItemString(fila,'estado')
// Solo miramos las liquidadas
if estado <> 'L' then return

contabilizada = dw_lista.GetItemString(fila,'contabilizada')
// No contabilizadas, claro
if contabilizada = 'S' then return
	
if string(year(date(dw_lista.GetItemDateTime(fila,'f_liquidacion'))))<>g_ejercicio then
	messagebox(g_titulo, "Algunas de las liquidaciones a contabilizar no pertenecen al ejercicio actual (fila "+string(i)+")", stopsign!)
	return 
end if

modo_contabilizacion = 'N'

asiento = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.liq_honos,7))
asiento = asiento - 1
if isnull(asiento) then asiento = 0


// Contabilizamos las liquidadas no contabilizadas
g_apunte.n_apunte = '00000'

fecha = dw_lista.GetItemDateTime(fila,'f_liquidacion')
importe = dw_lista.GetItemNumber(fila,'importe')
id_colegiado = dw_lista.GetItemString(fila,'id_colegiado')
id_minuta = dw_lista.GetItemString(fila,'id_fase')
n_documento = dw_lista.GetItemString(fila,'n_documento')
	
SELECT fases.n_expedi, fases.archivo  
INTO :n_expedi, :n_visado
FROM fases, fases_minutas, fases_liquidaciones
WHERE ( fases.id_fase = fases_minutas.id_fase ) and  
		( fases_minutas.id_minuta = fases_liquidaciones.id_fase ) and  
		( ( fases_liquidaciones.id_fase = :id_minuta ) )   ;

concepto_base=''
concepto_base = 'V$$HEX2$$ba002000$$ENDHEX$$' + ' ' + n_visado
	
formadepago = dw_lista.GetItemString(fila,'forma_pago')
ctabanco = dw_lista.GetItemString(fila,'banco')

//Rellenamos DATOS GENERALES DE G_APUNTE
asiento++
g_apunte.n_apunte = '00000'
g_apunte.n_asiento = RightA('0000000' + trim(string(asiento)),7)
g_apunte.n_doc = n_documento
g_apunte.id_interno = dw_lista.GetItemString(fila,'id_liquidacion')
g_apunte.fecha = datetime(date(fecha), time("00:00:00"))
// 26/04/05 g_apunte.t_asiento = g_t_asiento_apuntes_automaticos
g_apunte.t_asiento = f_t_asiento_liquidacion ( ) 	
g_apunte.n_apunte = '00000'
g_apunte.diario = g_sica_diario.liq_honos
g_apunte.proyecto = g_explotacion_por_defecto
g_apunte.centro = g_centro_por_defecto
g_apunte.cta_presupuestaria = cuenta_presupuestaria	
g_apunte.t_doc = g_sica_t_doc.generico

cuenta_col = f_dame_cuenta_col(id_colegiado, 'CP')
	
id_cli = f_minutas_id_cli(id_minuta)
cliente = f_dame_cliente(id_cli)
concepto_base = concepto_base + ' ' + cliente
	
// Abono a la Cuenta del colegiado
concepto = LeftA('Liq.Hon ' + concepto_base,57)
	
// INC 6113 - Si es devoluci$$HEX1$$f300$$ENDHEX$$n o regularizaci$$HEX1$$f300$$ENDHEX$$n que cambie el concepto
if g_colegio = 'COAATA' and dw_lista.getitemstring(fila, 'tipo')<>'0' and dw_lista.getitemstring(fila, 'tipo')<>'9' then
	concepto = LeftA('Ab.Ing ' + concepto_base,57)
end if
	
// Cuando es una liquidaci$$HEX1$$f300$$ENDHEX$$n manual que coja el concepto introducido
string conc
conc = dw_lista.GetItemString(fila,'concepto')
if id_minuta = 'LIQMANUAL' and not f_es_vacio(conc) then	concepto = LeftA(conc,57)
// Cuando es un extorno que coja el concepto introducido y a$$HEX1$$f100$$ENDHEX$$ada el colegiado
if id_minuta = 'EXTORNO' and not f_es_vacio(conc) then
	string nombre
	nombre =	 f_colegiado_apellido(id_colegiado)
	if f_es_vacio(nombre) then nombre = ''
	conc = conc + ' ' + nombre		
	concepto = LeftA(conc,57)
end if

ctabanco = f_dame_cuenta_col(id_colegiado,'P')

// Cargo a Banco
g_apunte.concepto = concepto
g_apunte.cuenta = ctabanco
g_apunte.debe = importe
g_apunte.haber = 0
g_apunte.contrapartida= cuenta_col
f_apunte_dw(g_apunte,dw_2,'E')	/***************/		
		
g_apunte.concepto = concepto
g_apunte.cuenta = cuenta_col
g_apunte.debe = 0
g_apunte.haber = importe
g_apunte.contrapartida = ctabanco
f_apunte_dw(g_apunte,dw_2,'E')	/***************/
	
	
//Marcamos la liquidacion como contabilizada:
dw_lista.SetItem(fila,'contabilizada','S')
	
//Si es una devoluci$$HEX1$$f300$$ENDHEX$$n se ponen las facturas y los cobros como pagados
if dw_lista.getitemstring(fila, 'tipo') = '1' then wf_devolucion(fila)
	
dw_lista.Update()
if dw_2.RowCount()>0 then
	dw_2.Update()
	f_actualiza_numero_bd_ejercicio(g_sica_diario.liq_honos, asiento)
	dw_2.reset()
end if

end event

public subroutine wf_devolucion (integer fila);datastore ds_facturas
datastore ds_cobros
string id_fase, id_col
int i, j

id_fase = dw_lista.GetItemString(fila,'id_fase')
id_col  = dw_lista.GetItemString(fila,'id_colegiado')

ds_facturas=create datastore
ds_facturas.dataobject='ds_facturas_devolucion'
ds_facturas.SetTransObject(SQLCA)
ds_facturas.Retrieve(id_fase, id_col)

ds_cobros=create datastore
ds_cobros.dataobject='ds_cobros_facturas_devolucion'
ds_cobros.SetTransObject(SQLCA)

for i=1 to ds_facturas.rowcount()
	ds_facturas.setitem(i, 'pagado','S')
	ds_cobros.reset()
	ds_cobros.Retrieve(ds_facturas.getitemstring(i, 'id_factura'))	
	for j=1 to ds_cobros.rowcount()
		ds_cobros.setitem(j, 'pagado','S')
	next
	ds_cobros.update()
next
ds_facturas.update()

destroy ds_cobros
destroy ds_facturas

end subroutine

public function integer wf_liq_anula ();//Esta funci$$HEX1$$f300$$ENDHEX$$n anula las liquidaciones procedentes de facturas anuladas
//es para evitar transferencias negativas.
//Hay dos procesos: uno por fase y otro por minuta (para que valga para aparejadores)
//Esta funci$$HEX1$$f300$$ENDHEX$$n es llamada ANTES de hacer el retrieve!!!!

Datastore ds_liq
string id_col, id_fase, id_minuta
string id_col_ant, id_fase_ant, id_minuta_ant
double importe, importe_ant, total
long i

SetPointer(Hourglass!)
//st_indicador.text = 'Revisando liquidaciones...'

ds_liq = create datastore
ds_liq.Dataobject = 'ds_liquidacion_anula_por_fase'
ds_liq.SetTransObject(SQLCA)
ds_liq.Retrieve()

id_col_ant = ''
id_fase_ant = ''
importe_ant = 0
FOR i=1 TO ds_liq.RowCount()
//	id_minuta = ds_liq.GetItemString(i,'id_minuta')
//	if f_es_vacio(id_minuta) then continue
	//Si llegamos aqu$$HEX2$$ed002000$$ENDHEX$$es que estamos en un colegio de arquitectos
	importe = ds_liq.GetItemNumber(i,'importe')
	id_fase = ds_liq.GetItemString(i,'id_fase')
	id_col = ds_liq.GetItemString(i,'id_colegiado')
	if id_col = id_col_ant and id_fase = id_fase_ant then
		//Si llegamos aqu$$HEX2$$ed002000$$ENDHEX$$es que hay dos liquidaciones iguales:
		if importe_ant = -importe then
			//Si llegamos aqu$$HEX2$$ed002000$$ENDHEX$$es que hay que anular esta liquidaci$$HEX1$$f300$$ENDHEX$$n (anula la anterior)
			//por lo que marcaremos las dos como anuladas y contabilizadas para que
			//no molesten mas.
			ds_liq.SetItem(i,'estado','A')
			ds_liq.SetItem(i,'contabilizada','S')
			ds_liq.SetItem(i - 1,'estado','A')
			ds_liq.SetItem(i - 1,'contabilizada','S')			
		end if
	end if
	importe_ant = importe
	id_fase_ant = id_fase
	id_col_ant = id_col
NEXT
ds_liq.Update()
destroy ds_liq

////Ahora repetimos el proceso para los aparejadores
//ds_liq = create datastore
//ds_liq.Dataobject = 'd_liquidacion_anula_por_minuta'
//ds_liq.SetTransObject(SQLCA)
//ds_liq.Retrieve()
//
//id_minuta_ant = ''
//importe_ant = 0
//FOR i=1 TO ds_liq.RowCount()
//	id_minuta = ds_liq.GetItemString(i,'id_minuta')
//	if not f_es_vacio(id_minuta) then continue
//	//Si llegamos aqu$$HEX2$$ed002000$$ENDHEX$$es que estamos en un colegio de aparejadores
//	importe = ds_liq.GetItemNumber(i,'importe')
//	if id_minuta = id_minuta_ant then
//		//Si llegamos aqu$$HEX2$$ed002000$$ENDHEX$$es que hay dos liquidaciones iguales:
//		if importe_ant = -importe then
//			//Si llegamos aqu$$HEX2$$ed002000$$ENDHEX$$es que hay que anular esta liquidaci$$HEX1$$f300$$ENDHEX$$n (anula la anterior)
//			//por lo que marcaremos las dos como anuladas y contabilizadas para que
//			//no molesten mas.
//			ds_liq.SetItem(i,'estado','A')
//			ds_liq.SetItem(i,'contabilizada','S')
//			ds_liq.SetItem(i - 1,'estado','A')
//			ds_liq.SetItem(i - 1,'contabilizada','S')			
//		end if
//	end if
//	importe_ant = importe
//	id_minuta_ant = id_minuta
//NEXT

//ds_liq.Update()
//destroy ds_liq

//st_indicador.text = ''

return 1
end function

public subroutine wf_calcula_deudas (ref double saldo_deudor, double deudas_facturas, integer fila, double importes_anteriores);double saldo = 0,  importe = 0
string id_colegiado, contabilizada, estado
saldo_deudor = 0
deudas_facturas = 0

contabilizada = dw_lista.GetItemString(fila,'contabilizada')
if contabilizada = 'S' then return	

estado = dw_lista.GetItemString(fila,'estado')
if estado <> 'P' then return	
	
importe = dw_lista.getitemnumber(fila, 'importe')

if g_liquidacion_incluir_saldo_deudor = 'S' then 
	id_colegiado = dw_lista.getitemstring(fila, 'id_colegiado')
	saldo = f_colegiado_saldo(id_colegiado)
	saldo = saldo * (-1)
	saldo = saldo - importes_anteriores //MODIFICADO RICARDO 2005-03-10 Intento de corregir el mal calculo en trasferencias
	// Si tiene saldo deudor no hay apuntes
	if saldo < 0 then 
		saldo_deudor = importe
		importe = 0
	// Si el saldo es menor que el importe entonces liquido por la diferencia
	elseif saldo < importe then		
		saldo_deudor = importe - saldo			
		importe = saldo
	// Sino pago la totalidad del importe
	else	
		saldo_deudor = 0
	end if
end if
saldo_deudor = f_redondea(saldo_deudor)
deudas_facturas = f_redondea(deudas_facturas)
importe = f_redondea(importe)
dw_lista.setitem(fila, 'saldo_deudor', saldo_deudor)
dw_lista.setitem(fila, 'deuda_facturas', deudas_facturas)
dw_lista.setitem(fila, 'importe', importe)

end subroutine

public function integer wf_generar_liquidacion (string tipo);// Tipo = TR (Transferencia), TA (Tal$$HEX1$$f300$$ENDHEX$$n)
string n_talon_inicial, banco, n_talon, cuenta_banco, lista_liquidaciones = '( ', sql_nueva, orden, nombre_ventana
datetime fecha_talon
double i, saldo = 0 , saldo_deudor = 0, deuda_facturas = 0, importes_anteriores = 0, valor_cont
long Job
st_cobros_datos_remesa datos_remesa
st_liquidacion_datos_talon st_talon
datastore ds_talon
	
nombre_ventana = classname() // A fin de evitar Bad Runtime Reference
SetPointer(Hourglass!)
		
CHOOSE CASE tipo
	CASE 'TA' // TALONES
		Open(w_liquidaciones_n_talon_inicial)
		st_talon = Message.PowerObjectParm
		if st_talon.n_talon_inicial='-1' then return -1   //Opci$$HEX1$$f300$$ENDHEX$$n Cancelar de la ventana de tal$$HEX1$$f300$$ENDHEX$$n inicial
		n_talon_inicial = st_talon.n_talon_inicial
		fecha_talon	= datetime(date(st_talon.fecha_talon), now())
		banco = st_talon.banco
		messagebox('IMPRESION DE TALONES', 'Coloque los impresos de tal$$HEX1$$f300$$ENDHEX$$n en la impresora en la posici$$HEX1$$f300$$ENDHEX$$n adecuada, por favor')
		ds_talon	= create datastore
		ds_talon.dataobject = g_informe_talon
		ds_talon.SetTransObject(SQLCA)
		
	CASE 'TR' // TRANSFERENCIAS
		Open(w_liquidaciones_datos_remesa)
		datos_remesa = Message.PowerObjectParm	
		banco = datos_remesa.banco
		fecha_talon = datetime(date(datos_remesa.fecha), now())
		n_talon_inicial = f_siguiente_numero('NUM_TRANSFERENCIA', 8)
END CHOOSE

cuenta_banco = f_dame_cuenta_contable_banco(banco)
n_talon = n_talon_inicial

// Guardamos la ordenaci$$HEX1$$f300$$ENDHEX$$n que tiene el dw y colocamos por colegiado
if g_contabiliza_liquidacion_auto ='S' then
	orden = dw_lista.Describe ("DataWindow.Table.Sort")
	dw_lista.setsort("id_colegiado A, id_liquidacion A")
	dw_lista.sort()
end if

for i= 1 to dw_lista.RowCount()
	st_indicador.Text='Tramitando liquidaci$$HEX1$$f300$$ENDHEX$$n '+string(i)+' de '+string(dw_lista.RowCount())
	// Solo se liquida y contabiliza lo que est$$HEX2$$e9002000$$ENDHEX$$pendiente y no contabilizado
	if dw_lista.getitemstring(i,'estado')='P' and dw_lista.getitemstring(i,'forma_pago')= tipo then
		// Calcular Saldo deudor y otras deudas
		if g_contabiliza_liquidacion_auto = 'S' then 
			if i>1 then
				// en cuanto cambie de colegiado reseteamos la variable acumulada
				if dw_lista.GetItemString(i,'id_colegiado')<> dw_lista.GetItemString(i - 1,'id_colegiado') then importes_anteriores = 0
			end if
			wf_calcula_deudas(saldo_deudor, deuda_facturas, i, importes_anteriores)
		end if
		// Pillamos el importe de esta liquidacion
		importes_anteriores += dw_lista.getitemNumber(i,'importe')
		dw_lista.SetItem(i,'n_documento',n_talon)
		n_talon = RightA('0000000000000000000000'+string(double(n_talon) + 1 ),8)
		valor_cont = double(n_talon)				
		///*** SCP-388. Alexis. 22/06/2010. Se modifica para que posteriormente el fichero q34 que se genera, se genere s$$HEX1$$f300$$ENDHEX$$lo con las pendientes. ***///
		if tipo <> 'TR' then dw_lista.SetItem(i,'estado','L')
		dw_lista.SetItem(i,'f_liquidacion',fecha_talon)			
		dw_lista.SetItem(i,'banco',cuenta_banco)
	end if
next

// Acabado todo actualizamos
dw_lista.Update()

if g_contabiliza_liquidacion_auto = 'S' then 	// CBI-57 Ponemos la misma ordenaci$$HEX1$$f300$$ENDHEX$$n que al numerar los talones ya que se cambia el orden en el evento de contabilizar
	dw_lista.setsort("id_colegiado A, id_liquidacion A")
	dw_lista.sort()	
end if

CHOOSE CASE tipo
	CASE 'TA'
		/////////////	imprimir varios talones en la misma pagina 30/03/2011
		string ids_liquidaciones, sql
		if g_imprimir_talon_multiples='S' and  ds_talon.dataobject = 'd_talon_ll' then
			Job=PrintOpen()
			sql = ds_talon.Describe('DataWindow.Table.Select')
			ids_liquidaciones = ' WHERE fases_liquidaciones.id_liquidacion IN ('
			// Impresi$$HEX1$$f300$$ENDHEX$$n de Talones
			for i= 1 to dw_lista.RowCount()
				st_indicador.Text='Imprimiendo Tal$$HEX1$$f300$$ENDHEX$$n '+string(i)+' de '+string(dw_lista.RowCount())
				// S$$HEX1$$f300$$ENDHEX$$lo se imprimen talones liquidados
				if dw_lista.getitemstring(i,'estado')='L' and dw_lista.getitemstring(i,'forma_pago')= g_formas_pago.talon then
					ids_liquidaciones+='~''+dw_lista.GetItemString(i,'id_liquidacion')+'~','
					lista_liquidaciones += + dw_lista.getitemstring(i, 'id_liquidacion') + + '~'' + ', ' 
					ds_talon.Modify("fecha_vencimiento.Text='"+string(st_talon.f_vencimiento, "DD/MM/YYYY")+"'")
					ds_talon.Modify("fecha_vencimiento_talon.Text='"+string(string(day(date( st_talon.f_vencimiento ))) + space(14)+ Upper(f_obtener_mes (st_talon.f_vencimiento )) + FillA(' ', 30 - LenA(f_obtener_mes(st_talon.f_vencimiento ))) + string(year(date(st_talon.f_vencimiento))))+"'")
				end if
			 next
			ids_liquidaciones = LeftA(ids_liquidaciones,Len(ids_liquidaciones)-1)
			ids_liquidaciones = ids_liquidaciones+')'
			sql = sql+ids_liquidaciones
			if g_debug='1' then messagebox('',sql)
			ds_talon.Modify('DataWindow.Table.Select="'+sql+'"')
			ds_talon.Retrieve()		
			PrintDataWindow(Job, ds_talon)
			ds_talon.Reset()	
		else
			//////////////		
			Job=PrintOpen()	
			// Impresi$$HEX1$$f300$$ENDHEX$$n de Talones
			for i= 1 to dw_lista.RowCount()
				st_indicador.Text='Imprimiendo Tal$$HEX1$$f300$$ENDHEX$$n '+string(i)+' de '+string(dw_lista.RowCount())
				// S$$HEX1$$f300$$ENDHEX$$lo se imprimen talones liquidados
				if dw_lista.getitemstring(i,'estado')='L' and dw_lista.getitemstring(i,'forma_pago')= g_formas_pago.talon then
					ds_talon.Retrieve(dw_lista.GetItemString(i,'id_liquidacion'))
					lista_liquidaciones += '~'' + dw_lista.getitemstring(i, 'id_liquidacion') + + '~'' + ', ' 
					ds_talon.Modify("fecha_vencimiento.Text='"+string(st_talon.f_vencimiento, "DD/MM/YYYY")+"'")
					ds_talon.Modify("fecha_vencimiento_talon.Text='"+string(string(day(date( st_talon.f_vencimiento ))) + space(14)+ Upper(f_obtener_mes (st_talon.f_vencimiento )) + FillA(' ', 30 - LenA(f_obtener_mes(st_talon.f_vencimiento ))) + string(year(date(st_talon.f_vencimiento))))+"'")
					PrintDataWindow(Job, ds_talon)
					ds_talon.Reset()	
				end if
			next
		end if
		PrintClose(job)
		destroy ds_talon
		messagebox('IMPRESION DEL LISTADO DE TALONES GENERADOS', 'Coloque papel blanco en la impresora , va a salir el listado de talones generado')
		// Le quitamos la ultima coma y le a$$HEX1$$f100$$ENDHEX$$adimos el cerrar parentesis
		lista_liquidaciones = LeftA(lista_liquidaciones, LenA(lista_liquidaciones)-2) + ' )'
		// Listado Liquidaciones
		st_indicador.Text='Imprimiendo Listado.'
		datastore ds_liquidacion_listado
		ds_liquidacion_listado = create datastore
		ds_liquidacion_listado.dataobject = g_listado_liquid_honos
		if g_colegio = 'COAATA' and tipo = 'TA' then ds_liquidacion_listado.dataobject = 'd_listado_talones_liquidaciones_honos_al'
		ds_liquidacion_listado.SetTransObject(SQLCA)
		sql_nueva = ds_liquidacion_listado.describe("datawindow.table.select") + ' and fases_liquidaciones.id_liquidacion in ' + lista_liquidaciones
		ds_liquidacion_listado.modify("datawindow.table.select= ~"" + sql_nueva + "~"")
		ds_liquidacion_listado.retrieve()
		ds_liquidacion_listado.groupcalc()
		if ds_liquidacion_listado.RowCount()>0 then
			for i = 1 to f_var_global_numero('numero_impresos_listados_domiciliaciones')
				ds_liquidacion_listado.print()
			next	
		end if
		destroy ds_liquidacion_listado
		
	CASE 'TR'
		IF NOT gnv_control_cuentas_bancarias.of_validar_datos_bancarios_movimientos('P', dw_lista)  THEN RETURN -1
		// David 31/05/2006 - Quieren que el fichero salga ordenado alfab$$HEX1$$e900$$ENDHEX$$ticamente
		if g_colegio = 'COAATB' then
			dw_lista.setsort("compute_1 A")
			dw_lista.sort()
		end if				
		// actualizamos el contador secuencial de transferencias
		update contadores set valor=:valor_cont where contador = 'NUM_TRANSFERENCIA';
		st_indicador.Text='Generando Fichero.'
		IF f_genera_csb34(dw_lista, datos_remesa, nombre_ventana,lista_liquidaciones) = -1 THEN RETURN -1
		st_indicador.Text='Imprimiendo Listado.'
		f_imprimir_listado_transferencias(nombre_ventana,lista_liquidaciones)
		
	END CHOOSE

if g_contabiliza_liquidacion_auto = 'S' then 
	st_indicador.Text='Contabilizando liquidaciones'
	this.trigger event csd_contabilizar()
	// David 21/03/2006 - Devolvemos la ordenaci$$HEX1$$f300$$ENDHEX$$n una vez impresos los talones si no salen desordenados (INC. 4884). Lo colocamos por colegiado
	dw_lista.setsort(orden)
	dw_lista.sort()
end if

st_indicador.Text=''
SetPointer(Arrow!)
Messagebox(g_titulo,'Proceso Finalizado.')	

return 1

end function

public function string wf_cuenta_contable_fp (string as_formapago);//	Funci$$HEX1$$f300$$ENDHEX$$n: wf_cuenta_contable_banco
//  Creada: 14/05/08
//	Devuele la cuenta contable asociada al banco que se pasa por argumento

string ls_cuenta_contable

SELECT	cuenta
INTO		:ls_cuenta_contable
FROM		csi_formas_de_pago
WHERE	tipo_pago = :as_formapago
;


return ls_cuenta_contable

end function

public subroutine wf_crear_apunte (datetime fecha, string cuenta, string concepto, double debe, double haber, string orden_apunte, string contrapartida);// Generacion del apunte
g_apunte.fecha = datetime(date(fecha), time("00:00:00"))
g_apunte.cuenta = cuenta
g_apunte.concepto = trim(concepto)
g_apunte.debe = debe
g_apunte.haber = haber
g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)				
g_apunte.orden_apunte = orden_apunte
g_apunte.contrapartida = contrapartida
f_apunte_dw(g_apunte,dw_2,'E')
end subroutine

on w_liquidaciones_lista.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_liquidaciones_lista" then this.MenuID = create m_liquidaciones_lista
this.dw_lista_facturas=create dw_lista_facturas
this.dw_informe=create dw_informe
this.st_indicador=create st_indicador
this.cb_fact_individual=create cb_fact_individual
this.dw_fact_deducidas=create dw_fact_deducidas
this.dw_2=create dw_2
this.dw_facturas_pendientes=create dw_facturas_pendientes
this.dw_lista_facturas_incluidas=create dw_lista_facturas_incluidas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_lista_facturas
this.Control[iCurrent+2]=this.dw_informe
this.Control[iCurrent+3]=this.st_indicador
this.Control[iCurrent+4]=this.cb_fact_individual
this.Control[iCurrent+5]=this.dw_fact_deducidas
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_facturas_pendientes
this.Control[iCurrent+8]=this.dw_lista_facturas_incluidas
end on

on w_liquidaciones_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_lista_facturas)
destroy(this.dw_informe)
destroy(this.st_indicador)
destroy(this.cb_fact_individual)
destroy(this.dw_fact_deducidas)
destroy(this.dw_2)
destroy(this.dw_facturas_pendientes)
destroy(this.dw_lista_facturas_incluidas)
end on

event open;call super::open;// Aqui he a$$HEX1$$f100$$ENDHEX$$adido que oculte el boton contabilizar segun var.global g_liquidacion_incluir_saldo_deudor, hacer lo mismo con la opcion de menu contabilizar en la versi$$HEX1$$f300$$ENDHEX$$n 2
inv_resize.of_Register (dw_lista, "ScaletoRight")
inv_resize.of_Register (cb_fact_individual, "FixedtoRight&Bottom")
inv_resize.of_Register (dw_lista_facturas,"FixedtoBottom")
inv_resize.of_Register (st_indicador, "FixedtoBottom")
inv_resize.of_Register (dw_lista_facturas_incluidas, "fixedtoBottom&ScaletoRight")
inv_resize.of_Register (dw_facturas_pendientes, "FixedtoRight&Bottom")
inv_resize.of_Register (dw_2, "FixedtoBottom")

//Control de variables globales
if f_es_vacio(g_liquidacion_incluir_saldo_deudor) then g_liquidacion_incluir_saldo_deudor = 'N'
if g_modo_liquidaciones <> 'L' then m_liquidaciones_lista.m_tools.m_facturas.enabled = false
//dw_informe.dataobject = g_hoja_liquidacion
//dw_informe.SetTransObject(SQLCA)		

if g_colegio = 'COAATNA' then dw_lista.object.b_fact_pend.visible = true

end event

event activate;call super::activate;g_dw_lista  = dw_lista
g_w_lista   = g_lista_liquidaciones
g_w_detalle = g_detalle_liquidaciones
g_lista     = 'w_liquidaciones_lista2'
g_detalle 	= 'w_liquidaciones_detalle'

end event

event csd_consulta();call super::csd_consulta;//Abrimos la ventana de consulta
g_consulta_actual_liquidaciones = i_sentencia_sql_lista // Es la mejor forma de pasar la consulta antigua
open(w_liquidaciones_consulta)
if Message.DoubleParm = -1 then return

//Ponemos aqu$$HEX2$$ed002000$$ENDHEX$$esta llamada para asegurarnos que las liquidaciones que se procesan son las correctas
wf_liq_anula()
dw_lista.Event csd_retrieve()
end event

event csd_detalle();call super::csd_detalle;if dw_lista.rowcount()>0 then
	g_id_liquidacion = dw_lista.GetItemString(dw_lista.GetRow(),'id_liquidacion')
	
	message.stringparm = "w_liquidaciones_detalle"
	w_aplic_frame.postevent("csd_liquidacionesdetalle")
end if
end event

event csd_listados();call super::csd_listados;Open(w_liquidaciones_listados)
end event

event csd_nuevo();call super::csd_nuevo;opensheet(g_detalle_liquidaciones, g_detalle, w_aplic_frame, 0, original!)
end event

event pfc_postopen();call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_liquidaciones = dw_lista

//Recuperamos la consulta de Inicio en caso de que exista
This.post Event csd_recuperar_consulta('INICIO')

end event

event pfc_preupdate;call super::pfc_preupdate;if f_puedo_escribir(g_usuario,'0000000033')=-1 then return -1

string estado
datetime f_liquidacion
int i
boolean encontrado

encontrado = false

dw_lista.accepttext()

for i=1 to dw_lista.rowcount() 
	estado = dw_lista.getitemstring(i,'estado')
	f_liquidacion = dw_lista.getitemdatetime(i,'f_liquidacion')
	if  estado = 'L' and f_es_vacio(string(f_liquidacion))then 
		encontrado = true
	end if 
next

if encontrado then
	messagebox(g_titulo, 'Mientras exista almenos una liquidacion con estado liquidado y sin fecha de liquidaci$$HEX1$$f300$$ENDHEX$$n no ser$$HEX2$$e1002000$$ENDHEX$$posible guardar los cambios.',StopSign!)
	return -1
end if 


return 1

end event

event csd_actualiza_listas;call super::csd_actualiza_listas;//Est$$HEX2$$e1002000$$ENDHEX$$programado en el padre
return
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_liquidaciones_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_liquidaciones_lista
end type

type st_1 from w_lista`st_1 within w_liquidaciones_lista
integer y = 1804
integer height = 48
end type

type dw_lista from w_lista`dw_lista within w_liquidaciones_lista
event csd_marcar_pendientes_cobro ( )
event csd_marcar_incluidas_en_liquidacion ( )
event csd_marcar_retenidas_por_embargo ( )
integer x = 0
integer y = 32
integer width = 3991
integer height = 1728
string dataobject = "d_liquidacion_lista"
end type

event dw_lista::csd_marcar_pendientes_cobro();//Marca las liquidaciones correspondientes a colegiados con facturas pendientes de cobro
int i,li_facturas_pendientes
string ls_id_colegiado

i=1

for i=1 to rowcount()
	ls_id_colegiado=getitemstring(i,'id_colegiado')
	select count(*) into :li_facturas_pendientes from csi_facturas_emitidas where & 
	( csi_facturas_emitidas.id_persona = :ls_id_colegiado ) AND
         ( csi_facturas_emitidas.pagado <> 'S' ) AND csi_facturas_emitidas.tipo_factura='03'&
			AND csi_facturas_emitidas.solo_pagos<>'S';
	if li_facturas_pendientes>0 then
		this.setitem(i,'fac_pen_cobro',string(li_facturas_pendientes))
	end if
next

this.resetupdate()
end event

event dw_lista::csd_marcar_incluidas_en_liquidacion();string id_liquidacion
long fila
double importe_facturas


FOR fila = 1 TO dw_lista.rowCount()
	// Rellenamos el importe de las facturas incluidas en las liquidaciones
	id_liquidacion = dw_lista.getitemString(fila, "id_liquidacion")
	select sum(total) into :importe_facturas from csi_facturas_emitidas where id_liquidacion = :id_liquidacion and pagado = 'S';
	if isnull(importe_facturas) then importe_facturas = 0
	dw_lista.setitem(fila, 'importe_facturas_incluidas', importe_facturas)
	
	
NEXT
dw_lista.resetupdate()


end event

event dw_lista::csd_marcar_retenidas_por_embargo();string id_colegiado
long fila, retenidas = 0

// Modificado ricardo 2005-03-15
FOR fila = 1 TO dw_lista.rowCount()
	// Para las pendientes, miramos si esas son 
	IF dw_lista.GetItemString(fila, "estado")='P' THEN
		id_colegiado = dw_lista.GetItemString(fila, "id_colegiado")
		if f_colegiado_embargo_hacienda(id_colegiado) then
			dw_lista.SetItem(fila, "estado",'R') // La pasamos a retenida
			retenidas++
		end if
	END IF
NEXT
dw_lista.update()
// FIN MOdificado ricardo 2005-03-15
parent.setredraw(true)


// MOdificado ricardo 2005-03-15
if retenidas>0 then Messagebox(g_titulo, "De las liquidaciones mostradas, "+string(retenidas)+" han sido retenidas autom$$HEX1$$e100$$ENDHEX$$ticamente por embargos de Hacienda.")
// FIN MOdificado ricardo 2005-03-15

end event

event dw_lista::rowfocuschanged;call super::rowfocuschanged;if this.rowcount() = 0 then return
// Acualizamos los otros dw para que se vea la informacion con el colegiado actual	
dw_lista_facturas.Retrieve(dw_lista.GetItemString(currentrow,'id_fase'),dw_lista.GetItemString(currentrow,'id_colegiado'))
dw_facturas_pendientes.Retrieve(dw_lista.GetItemString(currentrow,'id_colegiado'))

///*** SCP-924. Alexis. 02/03/2011. Cambios para mostrar las facturas incluidas en la liquidaci$$HEX1$$f300$$ENDHEX$$n. ***///
dw_lista_facturas_incluidas.Retrieve(dw_lista.GetItemString(currentrow,'id_liquidacion'))
end event

event dw_lista::retrievestart;call super::retrievestart;// Vaciamos los dw asociados... Se rellenaran al moverse por las filas!
dw_lista_facturas.reset()
dw_facturas_pendientes.Reset()
dw_facturas_pendientes.Reset()
dw_facturas_pendientes.visible = false
parent.setredraw(false)
end event

event dw_lista::retrieveend;call super::retrieveend;// Para cada una de las liquidaciones, hacemos la busqueda de las facturas pagadas por esta liquidacion y las colocamos
// Seria mas eficiente usar un dw teniendo todas las facturas relacionadas con la lista, pero como se acumulan consultas
// y hay unions esta opcion se hace inviable.


event csd_marcar_incluidas_en_liquidacion()

event csd_marcar_retenidas_por_embargo()

//Andr$$HEX1$$e900$$ENDHEX$$s 15/6/2005 hacemos que se marquen (de color rojo el ncol) los registros de colegiados con facturas pendientes de cobro
event csd_marcar_pendientes_cobro()

//Andr$$HEX1$$e900$$ENDHEX$$s-->para que se vean las facturas pendientes y a liquidar de la primera fila
this.event rowfocuschanged(1)
end event

event dw_lista::itemchanged;call super::itemchanged;choose case dwo.name
	case 'estado'
		if messagebox(g_titulo, 'Ha modificado el estado de la liquidaci$$HEX1$$f300$$ENDHEX$$n, $$HEX1$$bf00$$ENDHEX$$Desea continuar?', Question!,YesNo!) <> 1 then 
			return 2
		else
				this.accepttext()
				if data = 'L' then
					this.setitem(row,'f_liquidacion',DateTime(today(),Now()))
				end if
		end if 
end choose
end event

event dw_lista::buttonclicked;call super::buttonclicked;/***************************************************/
st_facturas datos
string id_liq
long ll_fila,ll_primera_fila_visible,ll_primera_fila_despues

id_liq=dw_lista.getitemstring(dw_lista.getrow(),'id_liquidacion')

datos.id_receptor = dw_lista.getitemstring(dw_lista.getrow(),'id_colegiado')
datos.id_liquidacion = dw_lista.getitemstring(dw_lista.getrow(),'id_liquidacion')
datos.id_fase = dw_lista.getitemstring(dw_lista.getrow(),'id_fase')

//Obtenemos la fila seleccionada
ll_fila=dw_lista.getrow()
//Obtenemos la primera fila visible del dw
dw_lista.setredraw(false)
dw_lista.scrollnextrow()
ll_primera_fila_visible=dw_lista.scrollpriorrow()
dw_lista.setredraw(true)

OpenWithParm(w_factufa_facturas_sin_liquidar,datos)


dw_lista.setredraw(false)
//parent.event csd_actualiza_listas()

//Volvemos a la fila donde est$$HEX1$$e100$$ENDHEX$$bamos antes
dw_lista.scrolltorow(ll_primera_fila_visible)
dw_lista.selectrow(ll_primera_fila_visible,false)

//Obtenemos la primera fila visible del dw...
dw_lista.scrollnextrow()
ll_primera_fila_despues=dw_lista.scrollpriorrow()

//..y comprobamos que sea la misma que la primera visible antes
do while ll_primera_fila_despues<ll_primera_fila_visible
	ll_primera_fila_despues=dw_lista.scrollnextrow()
loop

//Marcamos la fila que estaba marcada antes
dw_lista.setrow(ll_fila)
dw_lista.selectrow(ll_fila,true)
dw_lista.setredraw(true)



end event

type cb_consulta from w_lista`cb_consulta within w_liquidaciones_lista
integer x = 64
integer y = 1996
end type

type cb_detalle from w_lista`cb_detalle within w_liquidaciones_lista
integer x = 727
integer y = 2048
end type

type cb_ayuda from w_lista`cb_ayuda within w_liquidaciones_lista
integer x = 2011
integer y = 1728
end type

type dw_lista_facturas from u_dw within w_liquidaciones_lista
integer y = 1888
integer width = 1463
integer height = 352
integer taborder = 31
boolean bringtotop = true
string dataobject = "d_liquidacion_facturas_liquidacion"
boolean hscrollbar = true
end type

type dw_informe from u_dw within w_liquidaciones_lista
boolean visible = false
integer x = 3657
integer y = 544
integer width = 370
integer height = 252
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_informe_liquidacion_transferencia_biz"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

type st_indicador from statictext within w_liquidaciones_lista
integer x = 23
integer y = 1748
integer width = 1175
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_fact_individual from commandbutton within w_liquidaciones_lista
integer x = 3232
integer y = 1792
integer width = 206
integer height = 60
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;call super::clicked;string ls_valretorno, ls_valoremail, id_factura, tipo_factura, id_persona, emisor, n_factura, sl_originales, sl_copias
double i,j
boolean existe = false
long ll_originales, ll_copias
datawindow dw
st_w_factu_e_imprimir l_st_w_factu
st_imprimir_factura_obj_impr  st_imp_fact, lst_tipo_fact

if dw_lista.getrow() <= 0 then return

//Modificado Yexaira  27-08-2007
//Se abre la ventana de selecci$$HEX1$$f300$$ENDHEX$$n de tipo de facturas
open(w_factu_e_tipo_fact)
lst_tipo_fact = Message.powerobjectparm
// Verificamos si el tipo seleccionado existe en el dw

for i= 1 to lst_tipo_fact.n_tipo
	for j = 1 to dw_lista_facturas.RowCount()
		if dw_lista_facturas.GetItemString(j,'tipo_factura') =   lst_tipo_fact.tipo_fact[i] then
			existe= true
		end if
	next
next

if existe then
	n_csd_impresion_formato l_uo_impresion_formato
	l_uo_impresion_formato = create n_csd_impresion_formato
	
	l_uo_impresion_formato.papel = 'S'
	
	l_st_w_factu.varias_facturas = true
	l_st_w_factu.impresion_formato = l_uo_impresion_formato
	
	openwithparm(w_factu_e_imprimir,l_st_w_factu)
	
	ls_valretorno=Message.stringparm
	
	if ls_valretorno = 'CANCELAR' then return
	
	ls_valoremail = l_uo_impresion_formato.email
	ll_originales = l_uo_impresion_formato.copias
	sl_copias = ls_valretorno
	ll_copias = long(sl_copias)
	
	// Recorremos las facturas
	for i = 1 to dw_lista_facturas.RowCount()
		
		id_factura 		= dw_lista_facturas.GetItemString(i,'id_factura')
		tipo_factura	= dw_lista_facturas.GetItemString(i,'tipo_factura')
		emisor 			= dw_lista_facturas.GetItemString(i,'emisor')
		n_factura		= dw_lista_facturas.getitemstring(i,'n_fact')
		
		//st_imprimir_factura_obj_impr st_imp_fact
		
		st_imp_fact.id_factura 	= id_factura
		st_imp_fact.id_persona 	= emisor
		st_imp_fact.tipo 			= tipo_factura
		st_imp_fact.copia 		= 'N'
		st_imp_fact.dw 			= dw
		//	st_imp_fact.num_copias = ll_originales
		st_imp_fact.impresion_formato 				= l_uo_impresion_formato
		st_imp_fact.impresion_formato.copias		= ll_originales
		st_imp_fact.impresion_formato.nombre 		= n_factura
		st_imp_fact.impresion_formato.asunto_email= 'Factura '+n_factura
		st_imp_fact.impresion_formato.email 		= ls_valoremail
		for j = 1 to lst_tipo_fact.n_tipo
			if tipo_factura =   lst_tipo_fact.tipo_fact[j] then
				// Imprimimos originales
				if ll_originales > 0 then  f_imprimir_factura_objeto_impr(st_imp_fact)
				
				// Imprimimos copias
				st_imp_fact.copia = 'S'
				st_imp_fact.impresion_formato.copias = ll_copias
				st_imp_fact.impresion_formato.email = 'N' // Evitamos que envie el email 2 veces
				
				if ll_copias > 0 then f_imprimir_factura_objeto_impr(st_imp_fact)
				
				// Imprimimos en pdf
				st_imp_fact.copia = 'V'
				st_imp_fact.impresion_formato.copias = 1
				f_imprimir_factura_objeto_impr(st_imp_fact)
				
			end if
		next

next

//else
//	messagebox(g_titulo, 'No existe el tipo de factura seleccionado para imprimir')
end if
end event

type dw_fact_deducidas from u_dw within w_liquidaciones_lista
boolean visible = false
integer x = 1061
integer y = 1600
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_liquidacion_facturas_deducidas"
end type

type dw_2 from u_dw within w_liquidaciones_lista
boolean visible = false
integer y = 864
integer width = 4352
integer height = 896
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_apuntes_automaticos"
boolean hscrollbar = true
end type

event constructor;call super::constructor;SetTransObject(bd_ejercicio)
end event

type dw_facturas_pendientes from u_dw within w_liquidaciones_lista
boolean visible = false
integer x = 2962
integer y = 1888
integer width = 1463
integer height = 352
integer taborder = 21
string dataobject = "d_liquidacion_facturas_pend_colegiado"
end type

event retrieveend;call super::retrieveend;this.visible = (this.RowCount() > 0)
end event

type dw_lista_facturas_incluidas from u_dw within w_liquidaciones_lista
integer x = 1499
integer y = 1888
integer width = 1426
integer height = 352
integer taborder = 41
boolean bringtotop = true
string dataobject = "d_liquidacion_otras_facturas_incluidas"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

