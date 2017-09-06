HA$PBExportHeader$w_fases_cobrar_gastos.srw
forward
global type w_fases_cobrar_gastos from w_response
end type
type cb_1 from commandbutton within w_fases_cobrar_gastos
end type
type dw_colegiados from u_dw within w_fases_cobrar_gastos
end type
type cb_aumentar from commandbutton within w_fases_cobrar_gastos
end type
type cb_disminuir from commandbutton within w_fases_cobrar_gastos
end type
type sle_imprimir_copias from singlelineedit within w_fases_cobrar_gastos
end type
type st_3 from statictext within w_fases_cobrar_gastos
end type
type st_2 from statictext within w_fases_cobrar_gastos
end type
type sle_imprimir_originales from singlelineedit within w_fases_cobrar_gastos
end type
type cb_disminuir_copias from commandbutton within w_fases_cobrar_gastos
end type
type cb_aumentar_copias from commandbutton within w_fases_cobrar_gastos
end type
type st_1 from statictext within w_fases_cobrar_gastos
end type
type dw_3 from u_dw within w_fases_cobrar_gastos
end type
type st_proceso from statictext within w_fases_cobrar_gastos
end type
type cb_3 from commandbutton within w_fases_cobrar_gastos
end type
type dw_pago from u_dw within w_fases_cobrar_gastos
end type
type dw_descuentos from u_dw within w_fases_cobrar_gastos
end type
type st_4 from statictext within w_fases_cobrar_gastos
end type
type dw_fact from u_dw within w_fases_cobrar_gastos
end type
end forward

global type w_fases_cobrar_gastos from w_response
integer width = 1957
integer height = 1840
string title = "Cobrar Gastos"
boolean controlmenu = false
event csd_regularizar ( )
cb_1 cb_1
dw_colegiados dw_colegiados
cb_aumentar cb_aumentar
cb_disminuir cb_disminuir
sle_imprimir_copias sle_imprimir_copias
st_3 st_3
st_2 st_2
sle_imprimir_originales sle_imprimir_originales
cb_disminuir_copias cb_disminuir_copias
cb_aumentar_copias cb_aumentar_copias
st_1 st_1
dw_3 dw_3
st_proceso st_proceso
cb_3 cb_3
dw_pago dw_pago
dw_descuentos dw_descuentos
st_4 st_4
dw_fact dw_fact
end type
global w_fases_cobrar_gastos w_fases_cobrar_gastos

type variables
datawindowchild i_dwc_colegiados
w_fases_detalle i_w
datawindow idw_clientes, idw_colegiados, idw_descuentos
datawindow idw_fases_datos_exp, idw_1, idw_fases_src, idw_estadistica, idw_minutas
string i_id_col

end variables

forward prototypes
public function double f_total_movimientos_colegiado (string id_col)
public function double f_total_avisos_colegiado (string id_col)
end prototypes

public function double f_total_movimientos_colegiado (string id_col);int i
double total_src = 0
for i = 1 to idw_fases_src.rowcount()
	if id_col = idw_fases_src.getitemstring(i, 'id_col') then
		total_src += idw_fases_src.getitemnumber(i, 'importe_vble')
	end if
next

return total_src
	
end function

public function double f_total_avisos_colegiado (string id_col);// N$$HEX1$$fa00$$ENDHEX$$mero de avisos a un colegiado no anulados
int i
double total_avisos = 0
for i = 1 to idw_minutas.rowcount()
	if id_col = idw_minutas.getitemstring(i, 'id_colegiado') then
		if idw_minutas.getitemstring(i, 'anulada') = 'N' then
//			if idw_minutas.getitemstring(i, 'id_minuta') <> dw_3.getitemstring(1, 'id_minuta') then
				total_avisos ++
//			end if
		end if
	end if
next

return total_avisos
end function

on w_fases_cobrar_gastos.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_colegiados=create dw_colegiados
this.cb_aumentar=create cb_aumentar
this.cb_disminuir=create cb_disminuir
this.sle_imprimir_copias=create sle_imprimir_copias
this.st_3=create st_3
this.st_2=create st_2
this.sle_imprimir_originales=create sle_imprimir_originales
this.cb_disminuir_copias=create cb_disminuir_copias
this.cb_aumentar_copias=create cb_aumentar_copias
this.st_1=create st_1
this.dw_3=create dw_3
this.st_proceso=create st_proceso
this.cb_3=create cb_3
this.dw_pago=create dw_pago
this.dw_descuentos=create dw_descuentos
this.st_4=create st_4
this.dw_fact=create dw_fact
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_colegiados
this.Control[iCurrent+3]=this.cb_aumentar
this.Control[iCurrent+4]=this.cb_disminuir
this.Control[iCurrent+5]=this.sle_imprimir_copias
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.sle_imprimir_originales
this.Control[iCurrent+9]=this.cb_disminuir_copias
this.Control[iCurrent+10]=this.cb_aumentar_copias
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.dw_3
this.Control[iCurrent+13]=this.st_proceso
this.Control[iCurrent+14]=this.cb_3
this.Control[iCurrent+15]=this.dw_pago
this.Control[iCurrent+16]=this.dw_descuentos
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.dw_fact
end on

on w_fases_cobrar_gastos.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_colegiados)
destroy(this.cb_aumentar)
destroy(this.cb_disminuir)
destroy(this.sle_imprimir_copias)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_imprimir_originales)
destroy(this.cb_disminuir_copias)
destroy(this.cb_aumentar_copias)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.st_proceso)
destroy(this.cb_3)
destroy(this.dw_pago)
destroy(this.dw_descuentos)
destroy(this.st_4)
destroy(this.dw_fact)
end on

event open;call super::open;f_centrar_ventana(this)

i_w = g_detalle_fases
idw_clientes = i_w.idw_fases_promotores
idw_colegiados = i_w.idw_fases_colegiados
idw_descuentos = i_w.idw_fases_informes
idw_fases_datos_exp = i_w.dw_fases_datos_exp
idw_fases_src = i_w.idw_fases_src
idw_estadistica = i_w.idw_fases_estadistica
idw_minutas = i_w.idw_fases_minutas
idw_1 = i_w.dw_1

dw_colegiados.retrieve(g_id_fase)
int i
for i=1 to dw_colegiados.rowcount()
	if dw_colegiados.getitemstring(i,'id_col') = g_colegiado_comodin then dw_colegiados.setitem(i, 'proc', 'N')
	// Desmarcamos cuando son CGC s$$HEX1$$f300$$ENDHEX$$lo en los colegios en los que no se cobran gastos en este tipo de gesti$$HEX1$$f300$$ENDHEX$$n
	if g_colegio <> 'COAATTFE' and g_colegio <> 'COAATBU' and g_colegio <> 'COAATTEB'  then
		if dw_colegiados.getitemstring(i,'tipo_gestion') = 'C' then	dw_colegiados.setitem(i, 'proc', 'N')
	end if
next

dw_descuentos.insertrow(0)
dw_descuentos.setitem(1, 'cip_desc', g_codigos_conceptos.cip)
dw_descuentos.setitem(1, 'musaat_desc', g_codigos_conceptos.musaat_variable)
dw_descuentos.setitem(1, 'dv_desc', g_codigos_conceptos.dv)
dw_descuentos.setitem(1, 'libro_desc', g_codigos_conceptos.impresos)

// CGN-313 
// Los descuentos de DV y Libros puede que no existan por lo que se ocultan
string codigo_dv, codigo_libro
SELECT csi_articulos_servicios.codigo  INTO :codigo_dv  FROM csi_articulos_servicios  
WHERE ( codigo = :g_codigos_conceptos.dv ) AND  ( activo = 'S' )   ;
SELECT csi_articulos_servicios.codigo  INTO :codigo_libro  
FROM csi_articulos_servicios  WHERE ( codigo = :g_codigos_conceptos.impresos ) AND  ( activo = 'S' )   ;

if f_es_vacio(codigo_dv) then 
	dw_descuentos.object.dv_desc.visible = false
	dw_descuentos.object.dv_sn.visible = false
end if

if f_es_vacio(codigo_libro) then 
	dw_descuentos.object.libro_desc.visible = false
	dw_descuentos.object.libro_sn.visible = false
end if

dw_pago.insertrow(0)
dw_pago.SetItem(1,'fecha_pago',DateTime(Today(),Now()))
dw_pago.Setitem(1,'forma_pago',g_forma_pago_por_defecto)
dw_pago.SetItem(1,'banco',g_banco_por_defecto)
dw_pago.SetItem(1,'asunto','Cobro Gastos Reg. ' + idw_1.getitemstring(1, 'n_registro') + ' EXP. ' + idw_1.getitemstring(1, 'n_EXPEDI'))
dw_pago.object.forma_pago_liq.visible = false
dw_pago.object.forma_pago_liq_t.visible = false

dw_fact.insertrow(0)

if g_colegio='COAATMCA' then
	dw_descuentos.SetItem(1,'libro_sn','S')
	
end if

//Cambio hecho por Luis 11/02/2009
// Si existe m$$HEX1$$e100$$ENDHEX$$s de un colegiado, no se permite facturar y cobrar aviso
if(g_colegio = 'COAATTGN' OR g_colegio='COAATLL')then
	if(dw_colegiados.rowcount() > 1)then
		dw_fact.Object.fact.Protect=1
	end if
end if
//fin cambio

dw_descuentos.setitem(1,'cip_sn','N')
dw_fact.setitem(1,'fact','N')
dw_fact.visible=false
dw_fact.enabled=false 
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_cobrar_gastos
integer x = 2533
integer y = 1796
integer width = 46
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_cobrar_gastos
integer x = 2464
integer y = 1792
integer width = 46
integer taborder = 0
end type

type cb_1 from commandbutton within w_fases_cobrar_gastos
event csd_datos_cgc ( )
integer x = 439
integer y = 1552
integer width = 402
integer height = 112
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event csd_datos_cgc();// ffffffffff
int i

//for i = 1 to idw_clientes.rowcount()
//	if idw_clientes.getitemnumber(i, 'porcen') > porc_cli_mayor then
//		id_cliente_mayor_porc = idw_clientes.getitemstring(i, 'id_cliente')
//	end if
//next
//


end event

event clicked;string mensaje, id_col, id_fase, id_cliente_mayor_porc, dv_sn, mus_sn, cip_sn, libro_sn, paga_dv
double musaat=0, cip=0, total_musaat=0, porc_col=0, suma_porc=0, porc_col_real=0, porc_cli_mayor=0, libro=0
double cip_totales=0, dv_totales=0, dv=0, libros_total=0,suma_porc_real = 0
boolean fact = false, coleg = false
int i, j, retorno, fila_colegiado
st_musaat_datos st_musaat_datos
long k = 1, contador = 0,conta_inf=0


setpointer(hourglass!)

//if ((g_colegio = 'COAATTGN' or g_colegio = 'COAATTEB') and (dw_fact.getitemstring(1,'fact')='S'))then
//	DO WHILE (k <= dw_colegiados.rowcount()) and (contador = 0)
//		id_col = dw_colegiados.getitemstring(k,'id_col')
//		if g_forma_pago_por_defecto ='DB'  and not isnull(id_col) then
//			if f_dame_otros_conceptos_colegiado(id_col, '04') = 'N' then
//				Messagebox(g_titulo, 'No puede realizarse cobros por rebut bancari.')
//				dw_pago.Setitem(1,'forma_pago','TR')
//				contador = 1
//				return
//			end if
//		end if
//	loop
//end if


dw_pago.accepttext()
dw_descuentos.accepttext()

st_proceso.text = 'Validando entrada ...'

// Debe estar seleccionado al menos un descuento
cip_sn = dw_descuentos.getitemstring(1, 'cip_sn')
mus_sn = dw_descuentos.getitemstring(1, 'musaat_sn')
dv_sn = dw_descuentos.getitemstring(1, 'dv_sn')
libro_sn = dw_descuentos.getitemstring(1, 'libro_sn')
if cip_sn = 'N' and mus_sn = 'N' and dv_sn = 'N' and libro_sn = 'N' then mensaje += "Debe marcar un descuento."

// Comprobar si est$$HEX2$$e1002000$$ENDHEX$$marcado el check de cobrar y validar
fact = dw_fact.getitemstring(1,'fact') = 'S'
if fact then
	mensaje = mensaje + f_valida(dw_pago,'fecha_pago','NONULO','Debe especificar la fecha de pago.')
	mensaje = mensaje + f_valida(dw_pago,'forma_pago','NONULO','Debe especificar la forma de pago.')
	mensaje = mensaje + f_valida(dw_pago,'banco','NONULO','Debe especificar el banco.')
	mensaje = mensaje + f_valida(dw_pago,'asunto','NONULO','Debe especificar el concepto.')
end if

if mensaje<>'' Then
	Messagebox(g_titulo,mensaje,StopSign!)
	return
end if

// Avisar que no hay colegiados marcados
for i=1 to dw_colegiados.rowcount()
	if dw_colegiados.getitemstring(i,'proc') = 'S' then coleg = true
next
if not coleg then Messagebox(g_titulo,'No se ha marcado ning$$HEX1$$fa00$$ENDHEX$$n colegiado.')

st_proceso.text = 'Procesando datos ...'

// Coger el promotor de mayor %
for i = 1 to idw_clientes.rowcount()
	if idw_clientes.getitemnumber(i, 'porcen') > porc_cli_mayor then
		id_cliente_mayor_porc = idw_clientes.getitemstring(i, 'id_cliente')
	end if
next

// C$$HEX1$$e100$$ENDHEX$$lculo MUSAAT (para cada colegiado seleccionado)
for j=1 to dw_colegiados.rowcount()
	if dw_colegiados.getitemstring(j, 'proc') = 'N' then continue // Los no marcados los saltamos
	id_col = dw_colegiados.getitemstring(j,'id_col')
	id_fase = idw_1.getitemstring(1, 'id_fase')
	// Si es el colegiado comodin pasamos
	if id_col = g_colegiado_comodin then continue		
	// Buscamos al colegiado en la lista
	for i = 1 to i_w.idw_fases_colegiados.rowcount()
		if i_w.idw_fases_colegiados.getitemstring(i, 'id_col') = id_col then
			fila_colegiado = i
			exit
		end if
	next

	// Obtenemos el % del porcentaje
	suma_porc = 0
	suma_porc_real = 0
	porc_col = i_w.idw_fases_colegiados.getitemnumber(fila_colegiado, 'porcen_a')
	for i = 1 to i_w.idw_fases_colegiados.rowcount()
		suma_porc += i_w.idw_fases_colegiados.getitemnumber(i, 'porcen_a')
		suma_porc_real += i_w.idw_fases_colegiados.getitemnumber(i, 'porcen_a')
	next
	
	//Cambio Luis CGU-308
	if(i_w.idw_fases_colegiados.rowcount() = 1)then
		suma_porc = 100
	end if
	
	porc_col_real = porc_col / suma_porc

	// Prima
	if mus_sn = 'N' then // Si no est$$HEX2$$e1002000$$ENDHEX$$marcado no calculamos
		total_musaat = 0
		st_musaat_datos.tipo_csd = '00'
	else
		if i_w.idw_fases_estadistica.rowcount() > 0 then
			st_musaat_datos.n_visado = id_fase
			st_musaat_datos.id_col = id_col
			st_musaat_datos.tipo_act = idw_1.getitemstring(1, 'fase')
			st_musaat_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
			st_musaat_datos.pem = i_w.idw_fases_estadistica.getitemnumber(1, 'pem')
			st_musaat_datos.administracion = i_w.idw_fases_datos_exp.getitemstring(1, 'administracion')
			st_musaat_datos.superficie = i_w.idw_fases_estadistica.getitemnumber(1, 'superficie')
			st_musaat_datos.volumen = i_w.idw_fases_estadistica.getitemnumber(1, 'volumen')
			st_musaat_datos.porcentaje = porc_col_real * 100
			st_musaat_datos.cobertura = 0
			//Luis ICT-147
			st_musaat_datos.colindantes2m = i_w.idw_fases_estadistica.getitemstring(1, 'colindantes2m')
			if f_colegiado_tipopersona(id_col) = 'S' then
				retorno = f_musaat_calcula_prima_sociedad(st_musaat_datos)			
			else
				retorno = f_musaat_calcula_prima(st_musaat_datos)
			end if			
			total_musaat = st_musaat_datos.prima_comp
			total_musaat = f_redondea(total_musaat)
			
			// Ponemos el tipo de minuta (codigo adaptado de w_minutas_detalle)
			
			fila_colegiado = 0
			// Si Administraci$$HEX1$$f300$$ENDHEX$$n y es funcionario donde se realiza la obra entonces MUSAAT 0 y tipo 14
			if st_musaat_datos.administracion = 'S' then
				for i = 1 to idw_colegiados.rowcount()
					if idw_colegiados.getitemstring(i, 'id_col' ) = id_col and idw_colegiados.getitemstring(i, 'facturado' ) = 'S' then
						fila_colegiado = i
						exit
					end if
				next
				if fila_colegiado > 0 then
					total_musaat = 0
					st_musaat_datos.tipo_csd = '14'
				end if
			else
			// Si no es de administracion, si hay una minuta ya pasada entonces MUSAAT es cero
				if f_total_avisos_colegiado(id_col) > 0 then
					total_musaat = 0
					st_musaat_datos.tipo_csd = '00'
				end if
			end if
			
			// Tipo movimiento csd : Solo primeros visados y certificaciones
			// Quizas falta codificar la ultima certificacion
			if total_musaat = 0 then  // Si no hay MUSAAT --> 00
				st_musaat_datos.tipo_csd = '00'
			else
				if st_musaat_datos.administracion = 'S' then
					if idw_1.getitemstring(1,'aplicado_10') = 'S' then
						st_musaat_datos.tipo_csd = '23' //Siguientes certificaci$$HEX1$$f300$$ENDHEX$$n
					else
						st_musaat_datos.tipo_csd = '12' // 100% seguridad 
					end if
				else
					st_musaat_datos.tipo_csd = '10' // 100% NO SEGURIDAD
				end if
			end if
			
			if total_musaat = 0 then
				st_musaat_datos.tipo_csd = '00'
			end if
		end if
		
		// Si hay mas de un movimiento y suman mas de 1 unidad (euros)
		if f_tiene_movi_musaat(id_fase, id_col, false) and (f_total_movimientos_colegiado(id_col) > 1) then 
			total_musaat = 0
		else
			total_musaat = max(total_musaat - f_total_avisado_musaat_colegiado(id_fase, id_col),0)
		end if
	end if
	
	// CIP
	if cip_sn = 'N' then // Si no est$$HEX2$$e1002000$$ENDHEX$$marcado no calculamos 
		cip = 0
	else
		if g_colegio='COATTEB' or g_colegio='COAATTGN' OR g_colegio='COAATLL' then
			cip_totales=f_calcular_cip_contrato_dw(idw_estadistica,idw_1,porc_col_real*100, id_col)
			cip = max((cip_totales) - f_total_avisado_cip_colegiado(id_fase, id_col) , 0)
		elseif g_colegio='COAATMCA' then
			cip_totales = f_cip_contrato_dw(idw_descuentos)			
			cip = max((cip_totales * porc_col / suma_porc_real) - f_total_avisado_cip_colegiado(id_fase, id_col) , 0)
			//cip_totales=f_calcular_cip_contrato_dw(idw_estadistica,idw_1,100)
		else
			
			cip_totales = f_cip_contrato_dw(idw_descuentos)
			cip = max((cip_totales * porc_col_real) - f_total_avisado_cip_colegiado(id_fase, id_col) , 0)
		end if
		if isnull(cip) then cip = 0
		cip = f_redondea(cip)
	end if

	// DV
	if dv_sn = 'N' then // Si no est$$HEX2$$e1002000$$ENDHEX$$marcado no calculamos
		dv = 0
	else
		dv_totales = f_dv_contrato_dw(idw_descuentos)
		
			if f_total_avisado_dv_colegiado(id_fase, id_col) > 0 then
				dv = 0
			else
				if g_colegio = 'COAATMCA' then
					// En otros datos se guarda si es el cliente paga el CCV o el colegiado (paga_ccv='N' (DEFECTO) -> Paga el cliente, paga_ccv='S' -> paga el colegiado )
					select s_n into :paga_dv from otros_datos_colegiado where id_colegiado = :id_col and cod_caracteristica = 'PC';
					if f_es_vacio(paga_dv) or paga_dv='N' then 
						paga_dv='P'
					else
						paga_dv='C'
					end if
					//if paga_dv = 'C' then
						dv = max((dv_totales * porc_col / suma_porc_real) ,0)
			
					///else
					//	dv = dv_totales 
					//end if
				else
					dv = max((dv_totales * porc_col_real) /*- f_total_avisado_dv_colegiado(id_fase, id_col)*/, 0)		
				end if
			end if
		
		dv = f_redondea(dv)
	end if

	// Libros
	if libro_sn = 'S' then
		// Para Mallorca, el importe LIBRO es la CUOTA DE MANTENIMIENTO, y la cogemos de los gastos.
		if g_colegio='COAATMCA' then

			double impresos_linea = 0
			libros_total=0

			for conta_inf = 1 to idw_descuentos.rowcount()
				if idw_descuentos.getitemstring(conta_inf, 'tipo_informe') = g_codigos_conceptos.impresos then
					impresos_linea = idw_descuentos.getitemnumber(conta_inf, 'cuantia_colegiado') 
					libros_total += impresos_linea
				end if
			next
			if isnull(libros_total) then libros_total = 0
			
			if f_total_avisado_libros_colegiado(id_fase, id_col) > 0 then
				libros_total = 0
			end if
			libro = libros_total * porc_col / suma_porc_real 
		else
			SELECT importe INTO :libros_total FROM csi_articulos_servicios WHERE codigo = :g_codigos_conceptos.impresos;
			libro = libros_total * porc_col_real
		end if
		
	end if
	if  g_colegio = 'COAATTGN' OR g_colegio='COAATLL'  and dw_fact.getitemstring(1,'fact')='S'then
		if dw_pago.getitemstring(1,'forma_pago') ='DB'  and not isnull(id_col) then
			if f_dame_otros_conceptos_colegiado(id_col, '04') = 'N' then
				if(dw_colegiados.rowcount() = 1)then
					Messagebox(g_titulo, 'No puede realizarse cobros por rebut bancari. Seleccione la nueva forma de pago.')
					return
//				else
//					Messagebox(g_titulo, 'No puede realizarse cobros por rebut bancari.')
//					dw_pago.Setitem(1,'forma_pago','TR')
				end if
			end if
		end if

	end if

	
	if total_musaat > 0 or dv > 0 or cip > 0 or libro > 0 then // Generar avisos y facturas si corresponde
		// Pasamos los datos a la estructura
		st_cobrar_gastos_contrato st_datos
		st_datos.st_proceso = st_proceso
		st_datos.dw_pago = dw_pago
		st_datos.i_id_col = id_col
		st_datos.cip = cip
		st_datos.musaat = total_musaat
		st_datos.dv = dv
		st_datos.libros = libro
		st_datos.dw_3 = dw_3
		st_datos.impr_copias = Integer(sle_imprimir_copias.text)
		st_datos.impr_orig = Integer(sle_imprimir_originales.text)
		st_datos.facturar = fact
		st_datos.honorarios = idw_1.getitemnumber(1, 'honorarios')
		st_datos.clientes = idw_clientes
		st_datos.porc_col = porc_col_real
		st_datos.paga_gastos = idw_1.getitemstring(1, 'paga_gastos_cliente')
		st_datos.n_contrato_ant = idw_1.getitemstring(1, 'n_contrato_ant')
		
		if g_colegio='COAATMCA' then
			st_datos.id_cliente = id_cliente_mayor_porc
			st_datos.tipo_minuta = st_musaat_datos.tipo_csd			
			f_cobrar_gastos_contrato_mca(st_datos)
		else
			// Generamos los avisos cuando es CGC en algunos casos
			if (g_colegio = 'COAATTFE' or g_colegio = 'COAATBU' or g_colegio = 'COAATTEB' ) and idw_1.getitemstring(1,'tipo_gestion') = 'C' then
				f_cobrar_gastos_contrato_cgc(st_datos)
			else
				st_datos.id_cliente = id_cliente_mayor_porc
				st_datos.tipo_minuta = st_musaat_datos.tipo_csd
				f_cobrar_gastos_contrato(st_datos)
			end if
		end if
	end if
next

st_proceso.text = 'Proceso Finalizado ...'

close(parent)

end event

type dw_colegiados from u_dw within w_fases_cobrar_gastos
integer x = 37
integer y = 96
integer width = 1856
integer height = 312
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_colegiados_cobrar_gastos"
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;// Sobreescrito
end event

event constructor;call super::constructor;//this.of_SetRowSelect(TRUE)
//inv_rowselect.of_setstyle(inv_rowselect.multiple)



end event

type cb_aumentar from commandbutton within w_fases_cobrar_gastos
boolean visible = false
integer x = 1829
integer y = 1088
integer width = 69
integer height = 60
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "+"
end type

event clicked;if sle_imprimir_copias.text < '98' then
	sle_imprimir_copias.text= string(integer(sle_imprimir_copias.text) + 1 , '00')
end if
end event

type cb_disminuir from commandbutton within w_fases_cobrar_gastos
boolean visible = false
integer x = 1829
integer y = 1144
integer width = 69
integer height = 60
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "-"
end type

event clicked;if sle_imprimir_copias.text > '00' then
	sle_imprimir_copias.text= string(integer(sle_imprimir_copias.text) - 1 , '00')
end if
end event

type sle_imprimir_copias from singlelineedit within w_fases_cobrar_gastos
boolean visible = false
integer x = 1714
integer y = 1100
integer width = 105
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "01"
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

event losefocus;this.text= string(integer(this.text) , '00')

end event

type st_3 from statictext within w_fases_cobrar_gastos
boolean visible = false
integer x = 1440
integer y = 1268
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$ba002000$$ENDHEX$$Copias :"
boolean focusrectangle = false
end type

type st_2 from statictext within w_fases_cobrar_gastos
boolean visible = false
integer x = 1408
integer y = 1116
integer width = 311
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$ba002000$$ENDHEX$$Originales :"
boolean focusrectangle = false
end type

type sle_imprimir_originales from singlelineedit within w_fases_cobrar_gastos
boolean visible = false
integer x = 1714
integer y = 1252
integer width = 105
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "01"
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

event losefocus;this.text= string(integer(this.text) , '00')

end event

type cb_disminuir_copias from commandbutton within w_fases_cobrar_gastos
boolean visible = false
integer x = 1829
integer y = 1296
integer width = 69
integer height = 60
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "-"
end type

event clicked;if sle_imprimir_originales.text > '00' then
	sle_imprimir_originales.text= string(integer(sle_imprimir_originales.text) - 1 , '00')
end if
end event

type cb_aumentar_copias from commandbutton within w_fases_cobrar_gastos
boolean visible = false
integer x = 1829
integer y = 1240
integer width = 69
integer height = 60
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "+"
end type

event clicked;if sle_imprimir_originales.text < '98' then
	sle_imprimir_originales.text= string(integer(sle_imprimir_originales.text) + 1 , '00')
end if
end event

type st_1 from statictext within w_fases_cobrar_gastos
integer x = 37
integer y = 32
integer width = 690
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione el/los colegiado/s :"
boolean focusrectangle = false
end type

type dw_3 from u_dw within w_fases_cobrar_gastos
boolean visible = false
integer x = 1801
integer y = 36
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_factu_minutas_detalle"
end type

type st_proceso from statictext within w_fases_cobrar_gastos
integer x = 37
integer y = 1424
integer width = 1701
integer height = 52
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

type cb_3 from commandbutton within w_fases_cobrar_gastos
integer x = 1042
integer y = 1552
integer width = 402
integer height = 112
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;close(parent)

end event

type dw_pago from u_dw within w_fases_cobrar_gastos
boolean visible = false
integer x = 37
integer y = 1008
integer width = 1344
integer height = 364
integer taborder = 40
string dataobject = "d_pago_facturas"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

this.object.asunto_t.visible = false
this.object.asunto.visible = false

datawindowchild dwc_forma_pago
// Capturamos el desplegable
this.getchild ('forma_pago', dwc_forma_pago)
dwc_forma_pago.settransobject (SQLCA)
dwc_forma_pago.setfilter("tipo_pago <>'CM'")
dwc_forma_pago.filter()

end event

event itemchanged;call super::itemchanged;CHOOSE CASE DWO.NAME 
	case 'forma_pago'
		// Colocamos el banco
		this.setitem(1, 'banco', f_banco_asociado_a_forma_pago(string(data)))
		
		if data = g_formas_pago.cargo then
			this.object.banco.protect = 1
			this.object.banco.background.color = f_color_gris()
			choose CASE g_colegio
				case 'COAATB'
					THIS.SETITEM(1,'BANCO','09')
			END CHOOSE
		else
			this.object.banco.protect = 0
			this.object.banco.background.color = f_color_blanco()			
		end if
end choose

		
end event

type dw_descuentos from u_dw within w_fases_cobrar_gastos
integer x = 37
integer y = 512
integer width = 1856
integer height = 356
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_fases_marcar_descuentos"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;// Sobreescrito



end event

type st_4 from statictext within w_fases_cobrar_gastos
integer x = 37
integer y = 448
integer width = 1001
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione el/los gasto/s a incluir en el aviso:"
boolean focusrectangle = false
end type

type dw_fact from u_dw within w_fases_cobrar_gastos
integer x = 37
integer y = 912
integer width = 709
integer height = 84
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_facturar_y_cobrar"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;if data = 'S' then
	dw_pago.visible = true
	st_2.visible = true
	st_3.visible = true
	sle_imprimir_copias.visible = true
	sle_imprimir_originales.visible = true
	cb_aumentar.visible = true
	cb_disminuir.visible = true
	cb_aumentar_copias.visible = true
	cb_disminuir_copias.visible = true
else
	dw_pago.visible = false
	st_2.visible = false
	st_3.visible = false
	sle_imprimir_copias.visible = false
	sle_imprimir_originales.visible = false
	cb_aumentar.visible = false
	cb_disminuir.visible = false
	cb_aumentar_copias.visible = false
	cb_disminuir_copias.visible = false
end if


	
	
end event

event constructor;call super::constructor;if g_colegio = 'COAATMCA' then this.visible = false
end event

