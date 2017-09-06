HA$PBExportHeader$w_musaat_fichero_eco.srw
$PBExportComments$Generador del fichero econ$$HEX1$$f300$$ENDHEX$$mico
forward
global type w_musaat_fichero_eco from w_response
end type
type st_total from statictext within w_musaat_fichero_eco
end type
type st_proceso from statictext within w_musaat_fichero_eco
end type
type dw_movimientos from u_dw within w_musaat_fichero_eco
end type
type cb_recuperar from commandbutton within w_musaat_fichero_eco
end type
type cb_guardar_texto from commandbutton within w_musaat_fichero_eco
end type
type dw_consulta from u_dw within w_musaat_fichero_eco
end type
type cb_guardar_como from commandbutton within w_musaat_fichero_eco
end type
type dw_1 from u_dw within w_musaat_fichero_eco
end type
type cb_salir from commandbutton within w_musaat_fichero_eco
end type
type cb_listado from commandbutton within w_musaat_fichero_eco
end type
type cbx_excluir from checkbox within w_musaat_fichero_eco
end type
end forward

global type w_musaat_fichero_eco from w_response
integer width = 3479
integer height = 1656
boolean titlebar = false
boolean controlmenu = false
windowtype windowtype = popup!
windowstate windowstate = maximized!
event csd_key pbm_keydown
st_total st_total
st_proceso st_proceso
dw_movimientos dw_movimientos
cb_recuperar cb_recuperar
cb_guardar_texto cb_guardar_texto
dw_consulta dw_consulta
cb_guardar_como cb_guardar_como
dw_1 dw_1
cb_salir cb_salir
cb_listado cb_listado
cbx_excluir cbx_excluir
end type
global w_musaat_fichero_eco w_musaat_fichero_eco

type variables
boolean i_escape = false, i_en_proceso = false
end variables

forward prototypes
public function integer f_recuperar_movimientos ()
end prototypes

event csd_key;// Dependiendo de la tecla de funci$$HEX1$$f300$$ENDHEX$$n que se pulse debemos hacer una cosa u otra


CHOOSE CASE key
	CASE keyEscape!
		i_escape = true
END CHOOSE
end event

public function integer f_recuperar_movimientos ();//MODIFICADO POR RICARDO A FECHA 04-06-14
// Se pretende hacer que sea por centro por lo que es necesario abrir una ventana de consulta
g_dw_lista = dw_movimientos
open(w_musaat_fichero_eco_consulta)

if message.stringparm = '-1' then return -1

return 1

//MODIFICADO POR RICARDO A FECHA 04-06-14




/*
COMENTADO POR RICARDO A FECHA 04-06-14

string sql_nuevo, sql_copia

//Recuperamos le select del datawindow de lista
sql_nuevo = dw_movimientos.describe("datawindow.table.select")
sql_copia = sql_nuevo
f_sql('musaat_movimientos.fecha_calculo', '>=', 'f_desde', dw_consulta,sql_nuevo, '1', '')
f_sql('musaat_movimientos.fecha_calculo', '<', 'f_hasta', dw_consulta,sql_nuevo, '1', '')

if cbx_excluir.checked = true then f_sql_valores ('musaat_movimientos.fecha_notificacion','=','null','CH',sql_nuevo,'1','')

//messagebox('kk', sql_nuevo)
dw_movimientos.modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

dw_movimientos.retrieve()

dw_movimientos.modify("DataWindow.Table.Select= ~"" + sql_copia + "~"")
*/
end function

on w_musaat_fichero_eco.create
int iCurrent
call super::create
this.st_total=create st_total
this.st_proceso=create st_proceso
this.dw_movimientos=create dw_movimientos
this.cb_recuperar=create cb_recuperar
this.cb_guardar_texto=create cb_guardar_texto
this.dw_consulta=create dw_consulta
this.cb_guardar_como=create cb_guardar_como
this.dw_1=create dw_1
this.cb_salir=create cb_salir
this.cb_listado=create cb_listado
this.cbx_excluir=create cbx_excluir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_total
this.Control[iCurrent+2]=this.st_proceso
this.Control[iCurrent+3]=this.dw_movimientos
this.Control[iCurrent+4]=this.cb_recuperar
this.Control[iCurrent+5]=this.cb_guardar_texto
this.Control[iCurrent+6]=this.dw_consulta
this.Control[iCurrent+7]=this.cb_guardar_como
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.cb_salir
this.Control[iCurrent+10]=this.cb_listado
this.Control[iCurrent+11]=this.cbx_excluir
end on

on w_musaat_fichero_eco.destroy
call super::destroy
destroy(this.st_total)
destroy(this.st_proceso)
destroy(this.dw_movimientos)
destroy(this.cb_recuperar)
destroy(this.cb_guardar_texto)
destroy(this.dw_consulta)
destroy(this.cb_guardar_como)
destroy(this.dw_1)
destroy(this.cb_salir)
destroy(this.cb_listado)
destroy(this.cbx_excluir)
end on

event pfc_preopen();this.of_setresize(true)
inv_resize.of_Register (cb_guardar_como, "FixedtoBottom")
inv_resize.of_Register (cb_guardar_texto, "FixedtoBottom")
inv_resize.of_Register (cb_recuperar, "FixedtoBottom")
inv_resize.of_Register (dw_consulta, "FixedtoBottom")
inv_resize.of_Register (st_proceso, "FixedtoBottom")
inv_resize.of_Register (st_total, "FixedtoBottom")
inv_resize.of_Register (dw_1, "ScaletoRight&Bottom")
inv_resize.of_Register (cbx_excluir, "FixedtoBottom")
// Modificado Ricardo 2005-03-08
inv_resize.of_Register (cb_salir, "FixedtoBottom")
inv_resize.of_Register (cb_listado, "FixedtoBottom")

end event

event closequery;call super::closequery;if i_en_proceso then return 1

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_musaat_fichero_eco
string tag = "texto=general.recuperar_pantalla"
integer taborder = 30
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_musaat_fichero_eco
string tag = "texto=general.guardar_pantalla"
end type

type st_total from statictext within w_musaat_fichero_eco
integer x = 1056
integer y = 1344
integer width = 974
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_proceso from statictext within w_musaat_fichero_eco
integer x = 69
integer y = 1344
integer width = 974
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_movimientos from u_dw within w_musaat_fichero_eco
boolean visible = false
integer x = 2341
integer y = 928
integer width = 681
integer taborder = 40
string dataobject = "d_musaat_movimientos"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type cb_recuperar from commandbutton within w_musaat_fichero_eco
string tag = "texto=general.consultar"
integer x = 713
integer y = 1456
integer width = 507
integer height = 96
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Consultar"
end type

event clicked;if i_en_proceso then return -1

// Validaciones Previas
datetime f_desde, f_hasta, f_musaat
dw_1.reset()
st_total.text = ''
st_proceso.text = ''




// Declaracion de variables
int i, fila_insertada
string colegio, n_exp, id_fase, n_visado, emplazamiento, cod_pos, visa_ant, f_visado_sl, f_calculo_sl, nif_col, id_col, presupuesto_sl
datetime f_calculo, f_visado
double total_a_pagar = 0
//datastore ds_musaat_movimientos

i_escape = false
i_en_proceso = false
//// Recuperacion de datos
if f_recuperar_movimientos() = -1 then return

for i = 1 to dw_movimientos.rowcount()
	yield()
	i_en_proceso = true
	if i_escape then 
		messagebox(g_titulo, g_idioma.of_getmsg('msg_musaat.recuperacion_cancelada','Recuperaci$$HEX1$$f300$$ENDHEX$$n cancelada'))
		exit
	end if
	st_proceso.text = g_idioma.of_getmsg('msg_musaat.recuperando_movimiento','Recuperando Movimiento : ') + string(i) + '/' + string(dw_movimientos.rowcount())
	fila_insertada = dw_1.insertrow(0)
	id_fase = dw_movimientos.getitemstring(i, 'id_fase')
	id_col = dw_movimientos.getitemstring(i, 'id_col')
	// Colegio
	colegio = g_col_codigo_musaat + space(2 - LenA(g_col_codigo_musaat))
	if f_es_vacio(colegio) then colegio = space(2)
	dw_1.setitem(fila_insertada, 'COLEGIO',colegio)
	// F.Calculo 
	f_musaat = dw_movimientos.getitemdatetime(i, 'f_musaat')
	if isnull(f_musaat) then f_musaat = datetime(date('01/01/1900'), time('00:00:00'))
	// Mes Liquid.
	dw_1.setitem(fila_insertada, 'M_LIQUID',RightA('00' + string(month(date(f_musaat))), 2) + string(year(date(f_musaat))) )
	// Moneda
	dw_1.setitem(fila_insertada, 'MONEDA','E')
	// Tipo Visado
	string t_visado
	t_visado = dw_movimientos.getitemstring(i, 't_visado')
	if f_es_vacio(t_visado) then t_visado = '1'
	dw_1.setitem(fila_insertada, 'T_VISADO', RightA( t_visado  ,1) )
	// N_VISADO 
	choose case g_colegio
		case 'COAATB'
			n_exp = f_dame_exp(id_fase)
			n_visado = dw_movimientos.getitemstring(i, 'tipo_act')	+'-' + n_exp
		case 'COAATZ', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATA', 'COAATTER' 
			n_visado = f_fases_n_salida(id_fase)
		CASE 'COAATCC'
			n_visado = f_fases_n_salida(id_fase)
			n_visado = '20'+mid(n_visado,2)
		case 'COAATMCA'
			datetime f_entrada
			n_visado = f_fases_n_salida(id_fase)
			select f_entrada into :f_entrada from fases where id_fase=:id_fase;
			if year(date(f_entrada))<=2009 and month(date(f_entrada))<11 then
				n_visado=string(long(mid(n_visado,3)))+'/'+left(n_visado,2)
			end if
		case'COAATNA' 
			n_cst_string cadena
			
			n_visado = f_fases_n_salida(id_fase)
			cadena.of_globalreplace(n_visado,'-','0')
		case'COAATTGN', 'COAATTEB' ,'COAATLL'
			n_visado = f_fases_n_salida(id_fase)
			n_visado = cadena.of_globalreplace(n_visado,'-','')
			if f_es_vacio(dw_movimientos.getitemstring(i, 'n_contrato_ant')) then
				if  not f_es_vacio(n_visado) then
					n_visado =  '20' + n_visado
				end if
			else
				n_visado = dw_movimientos.getitemstring(i, 'n_contrato_ant')
			end if
			n_visado = rightA('000000000000' + n_visado, 12)
		case else
			
	end choose
	
	// 	 SCP-613 debido a la ley omnibus el numero de visado deja de ser obligatorio, se ha tomado la decisi$$HEX1$$f300$$ENDHEX$$n con caracter general de cambiarlo por n_registro

datetime fecha_omni
fecha_omni = f_fases_f_abono(id_fase)
if fecha_omni=datetime(date('01/01/1900'), time('00:00:00')) then
	fecha_omni = f_fases_f_visado(id_fase)
	
end if
if  fecha_omni=datetime(date('01/01/1900'), time('00:00:00')) then
	fecha_omni = f_fases_f_abono(id_fase)
end if	

if  fecha_omni=datetime(date('01/01/1900'), time('00:00:00')) then
	fecha_omni =datetime(date('01/01/9999'), time('00:00:00'))
end if		
	
choose case g_tipo_ident_fichero
	case '1'	//solo envio n_registro y el visado anterior si existia
		
		visa_ant = LeftA(dw_movimientos.getitemstring(i, 'n_contrato_ant') + space(12) , 12)//Compruebo lo que habia en visado anterior y lo complemento
		if not f_es_vacio(visa_ant) then 
			dw_1.setitem(fila_insertada, 'VISA_ANT', visa_ant)
		end if
		n_visado=rightA('0000000000000' +f_dame_n_reg(id_fase),12)//complemento el numero de visado con 0's 
		dw_1.setitem(fila_insertada, 'N_VISADO', n_visado)	
	case '2'	//envio el n_registro pero tambien el n_visado si es necesario
			n_visado= n_visado + space (12 - LenA(n_visado))//complemento lo que tenga numero de visado con espacios
			if not f_es_vacio(n_visado) and fecha_omni<datetime(date('01/10/2010'), time('00:00:00')) then
				//if  (f_fases_f_visado(id_fase)<>datetime(date('01/01/1900'), time('00:00:00')) and not f_es_vacio(string( f_fases_f_visado(id_fase))) and  date( f_fases_f_visado(id_fase))<date('01/10/2010') )or ( not f_es_vacio(string(f_fases_f_abono(id_fase))) and date(f_fases_f_abono(id_fase))<date('01/10/2010') and f_fases_f_abono(id_fase)<>datetime(date('01/01/1900'), time('00:00:00')) )  then
				if not f_es_vacio(n_visado) and fecha_omni<datetime(date('01/10/2010'), time('00:00:00')) then
				dw_1.setitem(fila_insertada, 'VISA_ANT', n_visado)
				end if	
			end if
			visa_ant = LeftA(dw_movimientos.getitemstring(i, 'n_contrato_ant') + space(12) , 12)//Compruebo lo que habia en visado anterior y lo complemento
			if not f_es_vacio(visa_ant) then 
				dw_1.setitem(fila_insertada, 'VISA_ANT', visa_ant)
			end if
			n_visado=rightA('0000000000000' +f_dame_n_reg(id_fase),12)//complemento el numero de visado con 0's 
			dw_1.setitem(fila_insertada, 'N_VISADO', n_visado)	
			
	case '3'	//mando una convinaci$$HEX1$$f300$$ENDHEX$$n de numero de expediente mas tipo actuaci$$HEX1$$f300$$ENDHEX$$n
			if not f_es_vacio(visa_ant) then 
				dw_1.setitem(fila_insertada, 'VISA_ANT', visa_ant)
			end if
			n_exp = f_dame_exp(id_fase)
			n_visado = dw_movimientos.getitemstring(i, 'tipo_act')	+'-' + n_exp
			dw_1.setitem(fila_insertada, 'N_VISADO', n_visado)	
			
	case '4'	//mando n$$HEX1$$fa00$$ENDHEX$$mero de registro con una R delante y si tiene visado y el visado es anterior al 01/10/2010 manda tambien el visado
			n_visado= n_visado + space (12 - LenA(n_visado))//complemento lo que tenga numero de visado con espacios
			if not f_es_vacio(n_visado) then
				if not f_es_vacio(n_visado) and fecha_omni<datetime(date('01/10/2010'), time('00:00:00')) then
				//if  (f_fases_f_visado(id_fase)<>datetime(date('01/01/1900'), time('00:00:00')) and not f_es_vacio(string( f_fases_f_visado(id_fase))) and  date( f_fases_f_visado(id_fase))<date('01/10/2010') )or ( not f_es_vacio(string(f_fases_f_abono(id_fase))) and date(f_fases_f_abono(id_fase))<date('01/10/2010') and f_fases_f_abono(id_fase)<>datetime(date('01/01/1900'), time('00:00:00')) )  then
				dw_1.setitem(fila_insertada, 'VISA_ANT', n_visado)
				end if	
			end if
			visa_ant = LeftA(dw_movimientos.getitemstring(i, 'n_contrato_ant') + space(12) , 12)//Compruebo lo que habia en visado anterior y lo complemento
			if not f_es_vacio(visa_ant) then 
				dw_1.setitem(fila_insertada, 'VISA_ANT', visa_ant)
			end if
			n_visado=rightA('000000000000R' +f_dame_n_reg(id_fase),12)//complemento el numero de visado con 0's 
			dw_1.setitem(fila_insertada, 'N_VISADO', n_visado)	
	case '5'	//mando numero de visado tal cual
			dw_1.setitem(fila_insertada, 'N_VISADO', n_visado)	
		
	case else//envio el n_registro pero tambien el n_visado si es necesario
			n_visado= n_visado + space (12 - LenA(n_visado))//complemento lo que tenga numero de visado con espacios
			if not f_es_vacio(n_visado) then
			if not f_es_vacio(n_visado) and fecha_omni<datetime(date('01/10/2010'), time('00:00:00')) then
			//if  (f_fases_f_visado(id_fase)<>datetime(date('01/01/1900'), time('00:00:00')) and not f_es_vacio(string( f_fases_f_visado(id_fase))) and  date( f_fases_f_visado(id_fase))<date('01/10/2010') )or ( not f_es_vacio(string(f_fases_f_abono(id_fase))) and date(f_fases_f_abono(id_fase))<date('01/10/2010') and f_fases_f_abono(id_fase)<>datetime(date('01/01/1900'), time('00:00:00')) )  then
				dw_1.setitem(fila_insertada, 'VISA_ANT', n_visado)
				end if	
			end if
			visa_ant = LeftA(dw_movimientos.getitemstring(i, 'n_contrato_ant') + space(12) , 12)//Compruebo lo que habia en visado anterior y lo complemento
			if not f_es_vacio(visa_ant) then 
				dw_1.setitem(fila_insertada, 'VISA_ANT', visa_ant)
			end if
			n_visado=rightA('0000000000000' +f_dame_n_reg(id_fase),12)//complemento el numero de visado con 0's 
			dw_1.setitem(fila_insertada, 'N_VISADO', n_visado)	
		
end choose
	
//fin cambios omnibus

	// Emplazamiento
	emplazamiento = f_musaat_devuelve_emplazamiento_fase(id_fase)
	emplazamiento = LeftA(emplazamiento, 30)
	emplazamiento += space(30 - LenA(emplazamiento))
	if f_es_vacio(emplazamiento) then emplazamiento = space(30)
	dw_1.setitem(fila_insertada, 'EMPLAZAM', emplazamiento)
	// Codigo Postal
	cod_pos = f_devuelve_cod_postal_fase(id_fase)
	cod_pos = LeftA(cod_pos,5) + space(5 - LenA(cod_pos))
	if f_es_vacio(cod_pos) then cod_pos = space(5)
	dw_1.setitem(fila_insertada, 'COD_POST', cod_pos)

	// Fecha visado
	if f_var_global_sn('g_utiliza_f_abono_fichero_eco') <> 'S' then 
		f_visado = f_fases_f_visado(id_fase)
	else 	
		//if g_colegio = 'COAATGU' or g_colegio = 'COAATLE' or g_colegio = 'COAATAVI' or g_colegio = 'COAATA' or g_colegio = 'COAATNA'  or g_colegio = 'COAATTGN' or g_colegio = 'COAATTEB' or  g_colegio = 'COAATMCA'  or g_colegio = 'COAATCC' or g_colegio= 'COAATLL' then 
		f_visado = f_fases_f_abono(id_fase) // Modificado David 08/03/2006 - Fecha de abono en vez de fecha de visado
		if (string(date(f_visado), 'ddmmyyyy') = '01011900') then f_visado = f_fases_f_visado(id_fase)
	end if
	
	if (string(date(f_visado), 'ddmmyyyy') = '01011900') then f_visado = f_fases_f_registro(id_fase)
	
	f_visado_sl = string(date(f_visado), 'ddmmyyyy')
	f_visado_sl += space(8 - LenA(f_visado_sl))
	dw_1.setitem(fila_insertada, 'F_VISADO', f_visado_sl)
	// Fecha de C$$HEX1$$e100$$ENDHEX$$lculo
	f_calculo_sl = string(date(f_musaat), 'ddmmyyyy')
	f_calculo_sl += space(8 - LenA(f_calculo_sl))
	dw_1.setitem(fila_insertada, 'F_CALCUL', f_calculo_sl)	
	// Nif Asegurado
	nif_col = f_devuelve_nif(id_col)
	nif_col = LeftA(nif_col, 10)		
	nif_col += space(10 - LenA(nif_col))
	dw_1.setitem(fila_insertada, 'NIF_ASEG', nif_col)	
	// Prefijo
	string prefijo
	prefijo = space(3)
	if g_colegio = 'COAATGC' then 
		prefijo = f_musaat_numpre(id_col)
		prefijo = RightA(prefijo, 3)	
		prefijo += space(3 - LenA(prefijo))
	end if
	dw_1.setitem(fila_insertada, 'PREFIJO', prefijo)	
	// N$$HEX1$$fa00$$ENDHEX$$mero de P$$HEX1$$f300$$ENDHEX$$liza
	string num_pol
	num_pol = space(8)
	if g_colegio = 'COAATGC' then
		num_pol = f_musaat_numpol(id_col)
		num_pol = RightA(num_pol, 8)	
		num_pol += space(8 - LenA(num_pol))
	end if
	dw_1.setitem(fila_insertada, 'NUM_POL', num_pol)	
	// N$$HEX1$$fa00$$ENDHEX$$mero de Mutualista
	string num_mut
	num_mut = space(6)
//	if g_colegio = 'COAATGC' then	
		num_mut = f_musaat_nummut(id_col)
		num_mut = RightA(num_mut, 6)
		num_mut += space(6 - LenA(num_mut))
//	end if
	dw_1.setitem(fila_insertada, 'NUM_MUT', num_mut)		
	// Presupuesto
	double presupuesto, pem_decimal
	double pem_entera
	string pem_entera_sl, pem_decimal_sl	
	presupuesto = dw_movimientos.getitemnumber(i, 'presupuesto')
	if isnull(presupuesto) then presupuesto = 0
	pem_entera = truncate(presupuesto, 0)
	pem_decimal = presupuesto - pem_entera
	pem_decimal = pem_decimal * 100
	// 30/07/2007 Cambiamos el truncate por el round porque estaba dando problemas (INC. 8105)
	pem_decimal = round(pem_decimal, 0) //truncate(pem_decimal, 0)
	pem_entera_sl = RightA( FillA('0', 12) + string(pem_entera), 12) + '.'
	pem_decimal_sl = RightA(FillA('0', 2) + string(pem_decimal), 2)
	presupuesto_sl = pem_entera_sl + pem_decimal_sl
	dw_1.setitem(fila_insertada, 'PEM', presupuesto_sl)		
	
	string t_interv
	t_interv = dw_movimientos.getitemstring(i, 'tipo_act')
	
	//SCP-2396 para el fichero de musaat, si el t_intervencion es el 79 se tiene que tratar como el 71 
	if (t_interv = '79' and g_colegio = 'COAATGUI') then t_interv = '71'
	
	if (t_interv = '77' OR t_interv = '78') then t_interv= '76'
	t_interv = LeftA(t_interv,3)	
	t_interv += space(3 - LenA(t_interv))
	dw_1.setitem(fila_insertada, 'T_INTERV', t_interv)		
	
	string t_obra
	t_obra = dw_movimientos.getitemstring(i, 'tipo_obra')
	t_obra = LeftA(t_obra,3)
	t_obra += space(3 - LenA(t_obra))
	dw_1.setitem(fila_insertada, 'T_OBRA', t_obra)		

	string segurid
	segurid = space(3)
	dw_1.setitem(fila_insertada, 'SEGURID', segurid)		

	string obra_ofi
	obra_ofi = dw_movimientos.getitemstring(i, 'obra_oficial')
	obra_ofi += space(1 - LenA(obra_ofi))
	if obra_ofi = 'N' then obra_ofi = '0'
	
	if obra_ofi = 'S' then 
		obra_ofi = '2'
	end if 
	dw_1.setitem(fila_insertada, 'OBRA_OFI', obra_ofi)	
	// Porcentaje
	double porc
	string porc_sl
	int pos_punto
	porc = dw_movimientos.getitemnumber(i, 'porcentaje')
	if isnull(porc) then porc = 0	
	porc_sl = string(porc)
	pos_punto = PosA(porc_sl,',')
	if pos_punto > 0 then 
		porc_sl += '00' //Rellenp con ceros decimales por si acaso
		porc_sl = MidA(porc_sl,1,pos_punto - 1) + '.' + MidA(porc_sl,pos_punto + 1,2)
	else
		porc_sl = RightA(FillA('0',7) + porc_sl + '.00', 7)
	end if
	porc_sl = RightA(FillA('0',7) + porc_sl, 7)
	if isnull(porc_sl) then porc_sl = '00000000'	
	dw_1.setitem(fila_insertada, 'PORCENT', porc_sl)	
	// Superficie
	double superfic
	string superfic_sl
	superfic = dw_movimientos.getitemnumber(i, 'superficie')
	superfic = round(superfic,0)
	if isnull(superfic) then superfic = 0	
	superfic_sl = RightA(FillA('0',6) + string(superfic), 6)
	dw_1.setitem(fila_insertada, 'SUPERFIC', superfic_sl)
	// Volumen
	double volumen
	string volumen_sl
	volumen = dw_movimientos.getitemnumber(i, 'volumen')
	if isnull(volumen) then volumen = 0		
	volumen_sl = RightA(FillA('0',8) + string(volumen), 8)	
	dw_1.setitem(fila_insertada, 'VOLUMEN', volumen_sl)
	// Prima
	double prima_t
	string prima_t_sl
	int pos_menos
	prima_t = dw_movimientos.getitemnumber(i, 'importe_vble')
	if isnull(prima_t) then prima_t = 0		
	total_a_pagar += prima_t
	prima_t_sl = string(prima_t)
	pos_punto = PosA(prima_t_sl,',')
	if pos_punto > 0 then 
		prima_t_sl += '00' //Relleno con ceros decimales por si acaso			
		prima_t_sl = MidA(prima_t_sl,1,pos_punto - 1) + '.' + MidA(prima_t_sl,pos_punto + 1,2)
		prima_t_sl = RightA(FillA('0',12) + prima_t_sl , 12)	
	else
		prima_t_sl = RightA(FillA('0',12) + prima_t_sl + '.00', 12)		
	end if

	
	// Relleno de ceros, si es negativo el signo - al principio
	pos_menos = PosA(prima_t_sl, '-')
	if  pos_menos <= 0 then

	else
		prima_t_sl = ReplaceA(prima_t_sl, pos_menos, 1, '0')
		prima_t_sl = MidA(prima_t_sl, 2, LenA(prima_t_sl))
		prima_t_sl = '-' + prima_t_sl

	end if
	dw_1.setitem(fila_insertada, 'PRIMA_T', prima_t_sl)	
	
	// Nif Pagador
	string nif_pagador
	nif_pagador =dw_movimientos.getitemstring(i, 'nif_pagador')
	nif_pagador = LeftA(nif_pagador, 10)
	nif_pagador += space(10 - LenA(nif_pagador))
	dw_1.setitem(fila_insertada, 'NIF_P', nif_pagador)	
	
	string nom_p = '', domic_p = '', c_post_p = ''
	if nif_col = nif_pagador then
		// Mirar en colegiados
		nom_p = f_colegiado_apellido(id_col)
		domic_p = f_domicilio_activo(id_col)
		c_post_p = f_musaat_devuelve_cp_comercial(id_col)
	else
		// Mirar en terceros
		nom_p = f_musaat_nombre_cliente_por_nif(nif_pagador)
		domic_p = f_musaat_domicilio_cliente_por_nif(nif_pagador)
		c_post_p = f_musaat_codpostal_cliente_por_nif(nif_pagador)
		// O es una sociedad
		if f_es_vacio(nom_p) then
			string id_soc
			id_soc = f_devuelve_id_col_de_nif(nif_pagador)
			nom_p = f_colegiado_apellido(id_soc)
			domic_p = f_domicilio_activo(id_soc)
			c_post_p = f_musaat_devuelve_cp_comercial(id_soc)
		end if
	end if

	nom_p += space(30 - LenA(nom_p))
	domic_p += space(30 - LenA(domic_p))
	c_post_p += space(5 - LenA(c_post_p))
	nom_p = LeftA(nom_p,30)
	domic_p = LeftA(domic_p,30)
	c_post_p = LeftA(c_post_p,5)	
	dw_1.setitem(fila_insertada, 'NOM_P', nom_p)
	dw_1.setitem(fila_insertada, 'DOMIC_P', domic_p)
	dw_1.setitem(fila_insertada, 'C_POST_P', c_post_p)
	// Cobertura o Garantia
	double cobertura
	string sl_cobertura
	cobertura = dw_movimientos.getitemnumber(i, 'cobertura')
	if isnull(cobertura) then cobertura = 0
	sl_cobertura = string(cobertura)		
	pos_punto = PosA(sl_cobertura,',')
	if pos_punto > 0 then 
		sl_cobertura += '00' //Rellenp con ceros decimales por si acaso
		sl_cobertura = MidA(sl_cobertura,1,pos_punto - 1) + '.' + MidA(sl_cobertura,pos_punto + 1,2)
	else
		sl_cobertura = RightA(FillA('0',15) + sl_cobertura + '.00', 15)				
	end if
	sl_cobertura = RightA(FillA('0',15) + sl_cobertura, 15)
	dw_1.setitem(fila_insertada, 'GARANTIA', sl_cobertura)	
	// Coeficiente de siniestralidad
	double coef_sin
	string coef_sin_sl
	coef_sin = dw_movimientos.getitemnumber(i, 'coef_sin')
	if isnull(coef_sin) then coef_sin = 1
	coef_sin_sl = string(coef_sin)	
	pos_punto = PosA(coef_sin_sl,',')
	if pos_punto > 0 then 
		coef_sin_sl += '00' //Rellenp con ceros decimales por si acaso
		coef_sin_sl = MidA(coef_sin_sl,1,pos_punto - 1) + '.' + MidA(coef_sin_sl,pos_punto + 1,2)
	else
		coef_sin_sl = RightA(FillA('0',5) + coef_sin_sl + '.00', 5)			
	end if
	coef_sin_sl = RightA(FillA('0',5) + coef_sin_sl, 5)
	dw_1.setitem(fila_insertada, 'COEF_SIN', coef_sin_sl)		

	string nom_apel
	nom_apel =f_colegiado_nombre_apellido(id_col)
	nom_apel = LeftA(nom_apel, 30)
	nom_apel += space(30 - LenA(nom_apel))
	dw_1.setitem(fila_insertada, 'NOM_APEL', nom_apel)	
	
	string colindante
	colindante = dw_movimientos.getitemstring(i, 'musaat_movimientos_colindantes2m')
	dw_1.setitem(fila_insertada, 'COLINDAN', colindante)
	
	string doble_cond
	doble_cond = dw_movimientos.getitemstring(i, 'musaat_movimientos_doble_condicion')
	dw_1.setitem(fila_insertada, 'D_COND', doble_cond)
	
	string int_forzosa
	int_forzosa = dw_movimientos.getitemstring(i, 'musaat_movimientos_int_forzosa')
	dw_1.setitem(fila_insertada, 'INT_FORZ', int_forzosa)
	
	//SCP-891
	string dap_sl
	double dap
	dap = dw_movimientos.getitemnumber(i, 'src_recargo')
	if dap = 1 then
		dap_sl= 'N'
	else
		dap_sl = 'S'
	end if
	dw_1.setitem(fila_insertada, 'DAP', dap_sl)
	
	string zona
	zona = dw_movimientos.getitemstring(i, 'cod_colegio_dest')
	if f_es_vacio(zona) then zona = g_cod_colegio
	dw_1.setitem(fila_insertada, 'ZONA', zona)
	
	string obra_com
	obra_com = dw_movimientos.getitemstring(i, 'obra_iniciada')
	if f_es_vacio(obra_com) then obra_com= 'N'
	dw_1.setitem(fila_insertada, 'OBRA_COM', obra_com)
	
	datetime f_renuncia
	string f_renuncia_sl
	f_renuncia = dw_movimientos.getitemdatetime(i, 'f_renuncia')
	f_renuncia_sl = string(date(f_renuncia), 'ddmmyyyy')
	if  f_renuncia_sl='01011900' then f_renuncia_sl= ''
	f_renuncia_sl += space(8 - LenA(f_renuncia_sl))
	dw_1.setitem(fila_insertada, 'F_RENUNCIA', f_renuncia_sl)	
	
	datetime f_extorno
	string f_extorno_sl
	f_extorno = dw_movimientos.getitemdatetime(i, 'f_extorno')
	f_extorno_sl = string(date(f_extorno), 'ddmmyyyy')
	if  f_extorno_sl='01011900' then f_extorno_sl= ''
	f_extorno_sl += space(8 - LenA(f_extorno_sl))
	dw_1.setitem(fila_insertada, 'F_EXTORNO', f_extorno_sl)
	
	string nom_prom
	nom_prom = dw_movimientos.getitemstring(i, 'nom_promotor')
	if isnull(nom_prom) then nom_prom= ''
	nom_prom = LeftA(nom_prom, 30)		
	nom_prom += space(30 - LenA(nom_prom))
	dw_1.setitem(fila_insertada, 'NOM_PROMO', nom_prom)
	
	string nif_prom
	nif_prom = dw_movimientos.getitemstring(i, 'nif_promotor')
	if isnull(nif_prom) then nif_prom= ''
	nif_prom = LeftA(nif_prom, 10)		
	nif_prom += space(10 - LenA(nif_prom))
	dw_1.setitem(fila_insertada, 'NIF_PROMO', nif_prom)	
	
	
	/*****************/
	string observac
	observac = dw_movimientos.getitemstring(i, 'observaciones')
	if isnull(observac) then observac = ''
	observac = LeftA(observac, 25)		
	observac += space(25 - LenA(observac))
	dw_1.setitem(fila_insertada, 'OBSERVAC', observac)

	string libre
	libre = space(18)
	dw_1.setitem(fila_insertada, 'LIBRE', libre)		
	
	//SCP-2406 
	datetime ldt_fecha_cfo
	string ls_fecha_cfo
	ldt_fecha_cfo = dw_movimientos.getitemdatetime(i, 'musaat_movimientos_fecha_cfo')
	ls_fecha_cfo = string(date(ldt_fecha_cfo), 'ddmmyyyy')
	if  ls_fecha_cfo='01011900' then ls_fecha_cfo= ''
	ls_fecha_cfo += space(8 - LenA(ls_fecha_cfo))
	dw_1.setitem(fila_insertada, 'fecha_cfo', ls_fecha_cfo)
next
total_a_pagar = f_redondea(total_a_pagar)
st_total.text = 'Total primas: ' + string(total_a_pagar, '#,##0.00')

i_escape = false
i_en_proceso = false

end event

type cb_guardar_texto from commandbutton within w_musaat_fichero_eco
string tag = "texto=general.fichero"
integer x = 1801
integer y = 1456
integer width = 507
integer height = 96
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Fichero"
end type

event clicked;if i_en_proceso then return -1

string p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25
string p26,p27,p28,p29,p30,p31,p32,p33,p34,p35, p36, p37, p38, p39, p40, p41, p42 
string p43,p44,p45, p46, p47, p48, p49, p50, p51, p52, p53, p54
int i
string linea, nombrefichero, ruta
int hFichero
int value

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02


value = GetFileSaveName("Introduzca el nombre del fichero", &
		ruta, nombrefichero, "DOC", &
		"Text Files (*.TXT),*.TXT," + &
		" Doc Files (*.DOC), *.DOC")

IF value <> 1 THEN 
	// MODIFICADO RICARDO 04-03-02
	// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
	cambia_directorio.of_changedirectory(directorio)
	destroy cambia_directorio
	// FIN MODIFICADO RICARDO 04-03-02
	return
end if

hFichero = FileOpen(NombreFichero,Linemode!,write!,shared!,replace!)
for i = 1 to dw_1.rowcount()
	p1 = dw_1.getitemstring(i,1)
	if f_es_vacio(p1) then p1 = space(2)
	p2 = dw_1.getitemstring(i,2)
	if f_es_vacio(p2) then p2 = space(6)	
	p3 = dw_1.getitemstring(i,3)
	if f_es_vacio(p3) then p3 = space(1)	
	p4 = dw_1.getitemstring(i,4)
	if f_es_vacio(p4) then p4 = space(1)	
	p5 = dw_1.getitemstring(i,5)
	if f_es_vacio(p5) then p5 = space(12)	
	p6 = dw_1.getitemstring(i,6)
	if f_es_vacio(p6) then p6 = space(30)	
	p7 = dw_1.getitemstring(i,7)
	if f_es_vacio(p7) then p7 = space(5)	
	p8 = dw_1.getitemstring(i,8)
	if f_es_vacio(p8) then p8 = space(12)	
	p9 = dw_1.getitemstring(i,9)
	if f_es_vacio(p9) then p9 = space(8)	
	p10 = dw_1.getitemstring(i,10)
	if f_es_vacio(p10) then p10 = space(8)	
	
	p11 = dw_1.getitemstring(i,11)
	if f_es_vacio(p11) then p11 = space(10)	
	p12 = dw_1.getitemstring(i,12)
	if f_es_vacio(p12) then p12 = space(3)	
	p13 = dw_1.getitemstring(i,13)
	if f_es_vacio(p13) then p13 = space(8)	
	p14 = dw_1.getitemstring(i,14)
	if f_es_vacio(p14) then p14 = space(6)	
	p15 = dw_1.getitemstring(i,15)
	if f_es_vacio(p15) then p15 = space(15)	
	p16 = dw_1.getitemstring(i,16)
	if f_es_vacio(p16) then p16 = space(3)	
	p17 = dw_1.getitemstring(i,17)
	if f_es_vacio(p17) then p17 = space(3)	
	p18 = dw_1.getitemstring(i,18)
	if f_es_vacio(p18) then p18 = space(3)	
	p19 = dw_1.getitemstring(i,19)
	if f_es_vacio(p19) then p19 = space(1)	
	p20 = dw_1.getitemstring(i,20)
	if f_es_vacio(p20) then p20 = space(7)	
	
	p21 = dw_1.getitemstring(i,21)
	if f_es_vacio(p21) then p21 = space(6)	
	p22 = dw_1.getitemstring(i,22)
	if f_es_vacio(p22) then p22 = space(8)	
	p23 = dw_1.getitemstring(i,23)
	if f_es_vacio(p23) then p23 = space(12)	
	p24 = dw_1.getitemstring(i,24)
	if f_es_vacio(p24) then p24 = space(10)	
	p25 = dw_1.getitemstring(i,25)
	if f_es_vacio(p25) then p25 = space(30)	
	p26 = dw_1.getitemstring(i,26)
	if f_es_vacio(p26) then p26 = space(30)	
	p27 = dw_1.getitemstring(i,27)
	if f_es_vacio(p27) then p27 = space(5)	
	p28 = dw_1.getitemstring(i,28)
	if f_es_vacio(p28) then p28 = space(15)	
	p29 = dw_1.getitemstring(i,29)
	if f_es_vacio(p29) then p29 = space(5)	
	p30 = dw_1.getitemstring(i,30)
	if f_es_vacio(p30) then p30 = space(30)	
	
	p31 = dw_1.getitemstring(i,31)
	if f_es_vacio(p31) then p31 = space(25)	
	p32 = dw_1.getitemstring(i,32)
	if f_es_vacio(p32) then p32 = space(14)	

	//Nuevos Campos agregados para el 2010
	p33 = dw_1.getitemstring(i,33)
	if f_es_vacio(p33) then p33 ='N'	
	p34 = dw_1.getitemstring(i,34)
	if f_es_vacio(p34) then p34 ='N'	
	p35 = dw_1.getitemstring(i,35)
	if f_es_vacio(p35) then p35 = 'N'	

	
	// Nuevos campos agregados para el 2011
	p36 = dw_1.getitemstring(i,36)
	if f_es_vacio(p36) then p36 ='N'	
	p37 = dw_1.getitemstring(i,37)
	if f_es_vacio(p37) then p37 = space(2)	
	p38 = dw_1.getitemstring(i,38)
	if f_es_vacio(p38) then p38 = 'N'	
	p39 = dw_1.getitemstring(i,39)
	if f_es_vacio(p39) then p39 = space(8)	
	p40 = dw_1.getitemstring(i,40)
	if f_es_vacio(p40) then p40 = space(8)	
	p41 = dw_1.getitemstring(i,41)
	if f_es_vacio(p41) then p41 = space(10)	
	p42 = dw_1.getitemstring(i,42)
	if f_es_vacio(p42) then p42 = space(30)
	p43 = dw_1.getitemstring(i,43)
	if f_es_vacio(p43) then p43 = space(8)
	
	// Nuevos campos agregados para el 2012
	if f_es_vacio(p44) then p44 = space(30)	
	if f_es_vacio(p45) then p45 = space(5)	
	if f_es_vacio(p46) then p46 = space(30)	
	if f_es_vacio(p47) then p47 = space(30)	
	if f_es_vacio(p48) then p48 = space(3)	
	if f_es_vacio(p49) then p49 = space(3)	
	if f_es_vacio(p50) then p50 = space(5)	
	if f_es_vacio(p51) then p51 = space(3)	
	if f_es_vacio(p52) then p52 = space(5)	
	if f_es_vacio(p53) then p53 = space(2)	
	if f_es_vacio(p54) then p54 = space(3)	

	// Nuevos campos agregados para el 2012, p43 hasta p54: direccion_promotor, cp_promotor, localidad_promotor, provincia_promotor, num_viv, sup_sob, plantas_sob, sup_baj, plantas_baj, duracion_obra, tipo_construccion
	linea = p1+p2+p3+p4+p5+p6+p7+p8+p9+p10+p11+p12+p13+p14+p15+p16+p17+p18+p19+p20+p21+p22+p23+p24+p25
	linea += p26+p27+p28+p29+p30+p34+p33+p35+p36+p37+p38+p39+p40+p41+p42+p44+p45+p46+p47+p48+p49+p50+p51+p52+p53+p54+p43+p31+p32

	FileWrite(hFichero, linea)

next
//messagebox('kk', string(len(linea)))
FileClose(hFichero)
if Messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.dar_fecha_notificacion', '$$HEX1$$bf00$$ENDHEX$$Desea dar fecha de notificaci$$HEX1$$f300$$ENDHEX$$n a estos movimientos?'), Question!, YesNo!) = 1 then
	for i = 1 to dw_movimientos.rowcount()
			dw_movimientos.setitem(i, 'fecha_notificacion', datetime(today(), now()))
	next
	dw_movimientos.update()
end if

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02

end event

type dw_consulta from u_dw within w_musaat_fichero_eco
boolean visible = false
integer x = 27
integer y = 1408
integer width = 1623
integer height = 152
integer taborder = 50
string dataobject = "d_musaat_movimientos_consulta_fichero"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.insertrow(0)

// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

type cb_guardar_como from commandbutton within w_musaat_fichero_eco
string tag = "texto=general.guardar_como"
boolean visible = false
integer x = 2345
integer y = 1456
integer width = 507
integer height = 96
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Guardar Como ... "
end type

event clicked;if i_en_proceso then return -1

int i
if dw_1.saveas() <> 1 then return
if Messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.dar_fecha_notificacion', '$$HEX1$$bf00$$ENDHEX$$Desea dar fecha de notificacion a estos movimientos?'), Question!, YesNo!) = 1 then
	for i = 1 to dw_movimientos.rowcount()
			dw_movimientos.setitem(i, 'fecha_notificacion', datetime(today(), now()))
	next
	dw_movimientos.update()	
end if
end event

type dw_1 from u_dw within w_musaat_fichero_eco
integer x = 37
integer y = 32
integer width = 3387
integer height = 1284
integer taborder = 20
string dataobject = "d_musaat_economico2002"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;//this.of_SetRowSelect(TRUE)
//this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
//this.of_SetProperty(TRUE)
//this.of_SetTransObject(SQLCA)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

// Enable printpreview service
//of_SetPrintPreview (true)
end event

type cb_salir from commandbutton within w_musaat_fichero_eco
string tag = "texto=general.salir"
integer x = 2889
integer y = 1456
integer width = 507
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;// Creado Ricardo 2005-03-08

close(parent)
end event

type cb_listado from commandbutton within w_musaat_fichero_eco
string tag = "texto=general.listado"
integer x = 1257
integer y = 1456
integer width = 507
integer height = 96
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Listado"
end type

event clicked;// Creado por Ricardo 2005-03-08

if dw_1.RowCount()<1 then return

// Creamos un listado para poder imprimir los datos
datastore ds_listado
ds_listado = create datastore
ds_listado.dataobject = 'd_musaat_economico2002_listado'
ds_listado.settransobject(SQLCA)
dw_1.sharedata(ds_listado) // Ahora comparten los datos

// imprimimos
if ds_listado.rowCount()>0 then ds_listado.print()

// Descompartimos los buffers
ds_listado.sharedataoff()
// Destruimos el datastore
destroy ds_listado
end event

type cbx_excluir from checkbox within w_musaat_fichero_eco
string tag = "texto=musaat.excluir_movimientos_comunicados"
boolean visible = false
integer x = 279
integer y = 1544
integer width = 1115
integer height = 56
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Excluir movimientos ya comunicados"
end type

