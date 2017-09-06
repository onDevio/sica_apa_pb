HA$PBExportHeader$w_musaat_fichero_est.srw
$PBExportComments$Generador del fichero estad$$HEX1$$ed00$$ENDHEX$$stico
forward
global type w_musaat_fichero_est from w_response
end type
type st_proceso from statictext within w_musaat_fichero_est
end type
type dw_movimientos from u_dw within w_musaat_fichero_est
end type
type cb_recuperar from commandbutton within w_musaat_fichero_est
end type
type cb_guardar_texto from commandbutton within w_musaat_fichero_est
end type
type dw_consulta from u_dw within w_musaat_fichero_est
end type
type cb_guardar_como from commandbutton within w_musaat_fichero_est
end type
type dw_1 from u_dw within w_musaat_fichero_est
end type
type cbx_excluir from checkbox within w_musaat_fichero_est
end type
type cb_listado from commandbutton within w_musaat_fichero_est
end type
type cb_salir from commandbutton within w_musaat_fichero_est
end type
end forward

global type w_musaat_fichero_est from w_response
integer width = 3479
integer height = 1728
string title = "Fichero Estad$$HEX1$$ed00$$ENDHEX$$stico"
boolean minbox = true
boolean maxbox = true
windowtype windowtype = popup!
windowstate windowstate = maximized!
event csd pbm_keydown
st_proceso st_proceso
dw_movimientos dw_movimientos
cb_recuperar cb_recuperar
cb_guardar_texto cb_guardar_texto
dw_consulta dw_consulta
cb_guardar_como cb_guardar_como
dw_1 dw_1
cbx_excluir cbx_excluir
cb_listado cb_listado
cb_salir cb_salir
end type
global w_musaat_fichero_est w_musaat_fichero_est

type variables
boolean i_escape = false, i_en_proceso = false
end variables

forward prototypes
public function integer f_recuperar_movimientos ()
end prototypes

event csd;// Dependiendo de la tecla de funci$$HEX1$$f300$$ENDHEX$$n que se pulse debemos hacer una cosa u otra


CHOOSE CASE key
	CASE keyEscape!
		i_escape = true
END CHOOSE
end event

public function integer f_recuperar_movimientos ();//MODIFICADO POR RICARDO A FECHA 04-06-14
// Se pretende hacer que sea por centro por lo que es necesario abrir una ventana de consulta
g_dw_lista = dw_movimientos
open(w_musaat_fichero_eco_consulta)
//MODIFICADO POR RICARDO A FECHA 04-06-14

if message.stringparm = '-1' then return -1

return 1



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

on w_musaat_fichero_est.create
int iCurrent
call super::create
this.st_proceso=create st_proceso
this.dw_movimientos=create dw_movimientos
this.cb_recuperar=create cb_recuperar
this.cb_guardar_texto=create cb_guardar_texto
this.dw_consulta=create dw_consulta
this.cb_guardar_como=create cb_guardar_como
this.dw_1=create dw_1
this.cbx_excluir=create cbx_excluir
this.cb_listado=create cb_listado
this.cb_salir=create cb_salir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_proceso
this.Control[iCurrent+2]=this.dw_movimientos
this.Control[iCurrent+3]=this.cb_recuperar
this.Control[iCurrent+4]=this.cb_guardar_texto
this.Control[iCurrent+5]=this.dw_consulta
this.Control[iCurrent+6]=this.cb_guardar_como
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.cbx_excluir
this.Control[iCurrent+9]=this.cb_listado
this.Control[iCurrent+10]=this.cb_salir
end on

on w_musaat_fichero_est.destroy
call super::destroy
destroy(this.st_proceso)
destroy(this.dw_movimientos)
destroy(this.cb_recuperar)
destroy(this.cb_guardar_texto)
destroy(this.dw_consulta)
destroy(this.cb_guardar_como)
destroy(this.dw_1)
destroy(this.cbx_excluir)
destroy(this.cb_listado)
destroy(this.cb_salir)
end on

event pfc_preopen();this.of_setresize(true)
inv_resize.of_Register (cb_guardar_como, "FixedtoBottom")
inv_resize.of_Register (cb_guardar_texto, "FixedtoBottom")
inv_resize.of_Register (cb_recuperar, "FixedtoBottom")
inv_resize.of_Register (dw_consulta, "FixedtoBottom")
inv_resize.of_Register (st_proceso, "FixedtoBottom")
inv_resize.of_Register (dw_1, "ScaletoRight&Bottom")
inv_resize.of_Register (cbx_excluir, "FixedtoBottom")
// Modificado Ricardo 2005-03-08
inv_resize.of_Register (cb_listado, "FixedtoBottom")
inv_resize.of_Register (cb_salir, "FixedtoBottom")

end event

event closequery;call super::closequery;if i_en_proceso then return 1

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_musaat_fichero_est
string tag = "texto=general.recuperar_pantalla"
integer taborder = 30
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_musaat_fichero_est
string tag = "texto=general.guardar_pantalla"
end type

type st_proceso from statictext within w_musaat_fichero_est
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

type dw_movimientos from u_dw within w_musaat_fichero_est
boolean visible = false
integer x = 2341
integer y = 928
integer width = 681
integer taborder = 40
string dataobject = "d_musaat_movimientos"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type cb_recuperar from commandbutton within w_musaat_fichero_est
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
datetime f_desde, f_hasta
dw_1.reset()
st_proceso.text = ''
// COMENTADO POR RICARDO 04-06-16
// Comentado porque este modulo ahora debe ser multicentro, por lo que habia que a$$HEX1$$f100$$ENDHEX$$adir el centro / modalidad



//dw_consulta.accepttext()
//f_desde = dw_consulta.getitemdatetime(1, 'f_desde')
//f_hasta = dw_consulta.getitemdatetime(1, 'f_hasta')
//
//if isnull(f_desde) then
//	messagebox(g_titulo, 'Introduzca la fecha inicial')
//	return
//end if
//
//if isnull(f_hasta) then
//	messagebox(g_titulo, 'Introduzca la fecha final')	
//	return
//end if

//i_escape = false
//i_en_proceso = false
////// Recuperacion de datos
//if f_recuperar_movimientos() = -1 then return
//
//for i = 1 to dw_movimientos.rowcount()
//	yield()
//	i_en_proceso = true
//	if i_escape then 
//		messagebox(g_titulo, 'Recuperaci$$HEX1$$f300$$ENDHEX$$n cancelada')
//		exit
//	end if
//
//
// Declaracion de variables
int i, fila_insertada
string colegio, n_exp, id_fase, n_visado, emplazamiento, cod_pos, visa_ant, f_visado_sl, f_calculo_sl, nif_col, id_col, presupuesto_sl
datetime f_calculo, f_visado
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
	st_proceso.text = 'Recuperando Movimiento : ' + string(i) + '/' + string(dw_movimientos.rowcount())
	fila_insertada = dw_1.insertrow(0)
	id_fase = dw_movimientos.getitemstring(i, 'id_fase')
	id_col = dw_movimientos.getitemstring(i, 'id_col')

	// N$$HEX1$$fa00$$ENDHEX$$mero de Expedientepasar$$HEX2$$e1002000$$ENDHEX$$a secundario por 	 SCP-613
	choose case g_colegio
		case 'COAATB'
			n_exp = f_dame_exp(id_fase)
			n_visado = dw_movimientos.getitemstring(i, 'tipo_act')	+'-' + n_exp
		case 'COAATZ', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATA', 'COAATNA', 'COAATTER'
			n_visado = f_fases_n_salida(id_fase)
		case'COAATTGN', 'COAATTEB' , 'COAATLL'
			n_cst_string cadena		
			n_visado = f_fases_n_salida(id_fase)
			n_visado = cadena.of_globalreplace(n_visado,'-','')

			if f_es_vacio(dw_movimientos.getitemstring(i, 'n_contrato_ant')) then
				n_visado =  '20' + n_visado
			else
				n_visado = dw_movimientos.getitemstring(i, 'n_contrato_ant')
			end if
			n_visado = rightA('000000000000' + n_visado, 12)			
		case else
		
	end choose
	
	
	// 	 SCP-613 debido a la ley omnibus el numero de visado deja de ser obligatorio, se ha tomado la decisi$$HEX1$$f300$$ENDHEX$$n con caracter general de cambiarlo por n_registro
	//    Para evitar  	 SCP-631 se guardar$$HEX2$$e1002000$$ENDHEX$$el  Visado en caso de poseerlo y en caso contrario de aportar$$HEX2$$e1002000$$ENDHEX$$el numero de registro
	// Visado Anterior
	
	
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
			dw_1.setitem(fila_insertada, 'EXP_ANTERI', visa_ant)
		end if
		n_visado=rightA('0000000000000' +f_dame_n_reg(id_fase),12)//complemento el numero de visado con 0's 
		dw_1.setitem(fila_insertada,'N_EXPTE', n_visado)	
	case '2'	//envio el n_registro pero tambien el n_visado si es necesario
			n_visado= n_visado + space (12 - LenA(n_visado))//complemento lo que tenga numero de visado con espacios
			if not f_es_vacio(n_visado) then
				//if  (f_fases_f_visado(id_fase)<>datetime(date('01/01/1900'), time('00:00:00')) and not f_es_vacio(string( f_fases_f_visado(id_fase))) and  date( f_fases_f_visado(id_fase))<date('01/10/2010') )or ( not f_es_vacio(string(f_fases_f_abono(id_fase))) and date(f_fases_f_abono(id_fase))<date('01/10/2010') and f_fases_f_abono(id_fase)<>datetime(date('01/01/1900'), time('00:00:00')) )  then
				if not f_es_vacio(n_visado) and fecha_omni<datetime(date('01/10/2010'), time('00:00:00')) then
				dw_1.setitem(fila_insertada, 'EXP_ANTERI', n_visado)
				end if	
			end if
			visa_ant = LeftA(dw_movimientos.getitemstring(i, 'n_contrato_ant') + space(12) , 12)//Compruebo lo que habia en visado anterior y lo complemento
			if not f_es_vacio(visa_ant) then 
				dw_1.setitem(fila_insertada, 'EXP_ANTERI', visa_ant)
			end if
			n_visado=rightA('0000000000000' +f_dame_n_reg(id_fase),12)//complemento el numero de visado con 0's 
			dw_1.setitem(fila_insertada, 'N_EXPTE', n_visado)	
			
	case '3'	//mando una convinaci$$HEX1$$f300$$ENDHEX$$n de numero de expediente mas tipo actuaci$$HEX1$$f300$$ENDHEX$$n
			if not f_es_vacio(visa_ant) then 
				dw_1.setitem(fila_insertada, 'EXP_ANTERI', visa_ant)
			end if
			n_exp = f_dame_exp(id_fase)
			n_visado = dw_movimientos.getitemstring(i, 'tipo_act')	+'-' + n_exp
			dw_1.setitem(fila_insertada,'N_EXPTE', n_visado)	
			
	case '4'	//mando n$$HEX1$$fa00$$ENDHEX$$mero de registro con una R delante y si tiene visado y el visado es anterior al 01/10/2010 manda tambien el visado
			n_visado= n_visado + space (12 - LenA(n_visado))//complemento lo que tenga numero de visado con espacios
			if not f_es_vacio(n_visado) then
				//if  (f_fases_f_visado(id_fase)<>datetime(date('01/01/1900'), time('00:00:00')) and not f_es_vacio(string( f_fases_f_visado(id_fase))) and  date( f_fases_f_visado(id_fase))<date('01/10/2010') )or ( not f_es_vacio(string(f_fases_f_abono(id_fase))) and date(f_fases_f_abono(id_fase))<date('01/10/2010') and f_fases_f_abono(id_fase)<>datetime(date('01/01/1900'), time('00:00:00')) )  then
				if not f_es_vacio(n_visado) and fecha_omni<datetime(date('01/10/2010'), time('00:00:00')) then
				dw_1.setitem(fila_insertada, 'EXP_ANTERI', n_visado)
				end if	
			end if
			visa_ant = LeftA(dw_movimientos.getitemstring(i, 'n_contrato_ant') + space(12) , 12)//Compruebo lo que habia en visado anterior y lo complemento
			if not f_es_vacio(visa_ant) then 
				dw_1.setitem(fila_insertada, 'EXP_ANTERI', visa_ant)
			end if
			n_visado=rightA('000000000000R' +f_dame_n_reg(id_fase),12)//complemento el numero de visado con 0's 
			dw_1.setitem(fila_insertada, 'N_EXPTE', n_visado)	
	case '5'	//mando numero de visado tal cual
			dw_1.setitem(fila_insertada, 'N_EXPTE', n_visado)	
		
	case else//envio el n_registro pero tambien el n_visado si es necesario
			n_visado= n_visado + space (12 - LenA(n_visado))//complemento lo que tenga numero de visado con espacios
			if not f_es_vacio(n_visado) then
				if not f_es_vacio(n_visado) and fecha_omni<datetime(date('01/10/2010'), time('00:00:00')) then
				//if  (f_fases_f_visado(id_fase)<>datetime(date('01/01/1900'), time('00:00:00')) and not f_es_vacio(string( f_fases_f_visado(id_fase))) and  date( f_fases_f_visado(id_fase))<date('01/10/2010') )or ( not f_es_vacio(string(f_fases_f_abono(id_fase))) and date(f_fases_f_abono(id_fase))<date('01/10/2010') and f_fases_f_abono(id_fase)<>datetime(date('01/01/1900'), time('00:00:00')) )  then
				dw_1.setitem(fila_insertada, 'EXP_ANTERI', n_visado)
				end if	
			end if
			visa_ant = LeftA(dw_movimientos.getitemstring(i, 'n_contrato_ant') + space(12) , 12)//Compruebo lo que habia en visado anterior y lo complemento
			if not f_es_vacio(visa_ant) then 
				dw_1.setitem(fila_insertada, 'EXP_ANTERI', visa_ant)
			end if
			n_visado=rightA('0000000000000' +f_dame_n_reg(id_fase),12)//complemento el numero de visado con 0's 
			dw_1.setitem(fila_insertada, 'N_EXPTE', n_visado)	
		
end choose
	
//fin cambios omnibus
	
	
	// Fecha Visado
	f_visado = f_fases_f_visado(id_fase)
	if g_colegio = 'COAATGU' or g_colegio = 'COAATLE' or g_colegio = 'COAATAVI' or g_colegio = 'COAATA' or g_colegio = 'COAATNA' or g_colegio = 'COAATTGN' or g_colegio = 'COAATTEB'  or g_colegio = 'COAATTER' or g_colegio = 'COAATMCA' or g_colegio='COAATLL' then 
		f_visado = f_fases_f_abono(id_fase) // Modificado David 31/07/2007 - Fecha de abono en vez de fecha de visado
	end if	
	f_visado_sl = string(date(f_visado), 'ddmmyyyy')
	f_visado_sl = RightA(FillA('0',8) + f_visado_sl, 8)
	dw_1.setitem(fila_insertada, 'F_VISADO', f_visado_sl)
	
	// Fecha de Retirada de Visado
	dw_1.setitem(fila_insertada, 'F_RET_VISA', f_visado_sl)
	
	// Mes Liquidacion
	f_calculo = dw_movimientos.getitemdatetime(i, 'fecha_calculo')
	if isnull(f_calculo) then f_calculo = datetime(date('01/01/1900'), time('00:00:00'))
	dw_1.setitem(fila_insertada, 'MES_LIQ',RightA('00' + string(month(date(f_calculo))), 2) + string(year(date(f_calculo))) )
	
	// Colegio
	colegio = RightA('00' + g_col_codigo_musaat ,2)
	if f_es_vacio(colegio) then colegio = FillA('0',2)
	dw_1.setitem(fila_insertada, 'COLEGIO',colegio)	
	
	// C$$HEX1$$f300$$ENDHEX$$digo de Municipio (MOPU)
	string cod_mopu
	cod_pos = f_devuelve_cod_postal_fase(id_fase)
	SELECT poblaciones.pob_mopu INTO :cod_mopu FROM poblaciones WHERE poblaciones.cod_pos = :cod_pos   ;
	cod_mopu = cod_mopu + space(4 - LenA(cod_mopu))
	if f_es_vacio(cod_mopu) then cod_mopu = space(4)
	dw_1.setitem(fila_insertada, 'COD_MUNI',cod_mopu)	
	
	// Tipo de Visado
	string t_visado
	t_visado = dw_movimientos.getitemstring(i, 't_visado')
	if f_es_vacio(t_visado) then t_visado = '1'
	dw_1.setitem(fila_insertada, 'TIPO_VISAD', RightA( t_visado  ,1) )
	

	
	// Anulado
	dw_1.setitem(fila_insertada, 'ANULADO', 'N')
	
	// Emplazam
	emplazamiento = f_musaat_devuelve_emplazamiento_fase(id_fase)
	emplazamiento = LeftA(emplazamiento, 30)
	emplazamiento += space(30 - LenA(emplazamiento))
	if f_es_vacio(emplazamiento) then emplazamiento = space(30)
	dw_1.setitem(fila_insertada, 'EMPLAZAM', emplazamiento)	
	// Numero
	string n_calle
	n_calle = f_fases_n_calle(id_fase)
	n_calle = LeftA(n_calle, 4)
	n_calle += space(4 - LenA(n_calle))
	if f_es_vacio(n_calle) then n_calle = space(4)
	dw_1.setitem(fila_insertada, 'E_NUM', n_calle)		
	// C$$HEX1$$f300$$ENDHEX$$digo Postal
	cod_pos = LeftA(cod_pos,5) + space(5 - LenA(cod_pos))
	if f_es_vacio(cod_pos) then cod_pos = space(5)
	dw_1.setitem(fila_insertada, 'E_DP', cod_pos)	
	// Municipio
	string e_muni
	cod_pos = f_devuelve_cod_postal_fase(id_fase)
	//e_muni = f_dame_poblacion_cp(cod_pos)
	e_muni = LeftA(e_muni, 20)
	e_muni += space(20 - LenA(e_muni))
	if f_es_vacio(e_muni) then e_muni = space(20)
	dw_1.setitem(fila_insertada, 'E_MUNI', e_muni)	
	// Provincia
	string e_provi, cod_provin
//	cod_provin = f_dame_provincia(cod_pos)
		SELECT poblaciones.provincia  
		INTO :cod_provin  
		FROM poblaciones  
		WHERE poblaciones.cod_pos like :cod_pos   ;	
	e_provi = f_nombre_provincia(cod_provin)	
	e_provi = LeftA(e_provi, 20)
	e_provi += space(20 - LenA(e_provi))
	if f_es_vacio(e_provi) then e_provi = space(20)
	dw_1.setitem(fila_insertada, 'E_PROVI', e_provi)	
	
	// Honorarios Previstos
	double honorarios
	string honorar_pr
	  SELECT sum(fases.honorarios)  
    INTO :honorarios  
    FROM fases  
   WHERE fases.id_fase = :id_fase   
           ;
	honorarios = round(honorarios,0)
	honorar_pr = string(honorarios)
	honorar_pr = LeftA(honorar_pr, 8)
	honorar_pr = RightA(FillA('0',8) + honorar_pr,8)
	if f_es_vacio(honorar_pr) then honorar_pr = FillA('0',8)
	dw_1.setitem(fila_insertada, 'HONORAR_PR', honorar_pr)	
	
	// Desplazamientos Previstos
	dw_1.setitem(fila_insertada, 'DESPLAZ_PR', FillA('0',7))	
	
	// Otros Gastos Previstos
	dw_1.setitem(fila_insertada, 'OTROS_G_PR', FillA('0', 8))	
	
	// Tipo de Intervenci$$HEX1$$f300$$ENDHEX$$n
	string t_interv
	t_interv = dw_movimientos.getitemstring(i, 'tipo_act')
	
	//SCP-2396 para el fichero de musaat, si el t_intervencion es el 79 se tiene que tratar como el 71 
	if (t_interv = '79' and g_colegio = 'COAATGUI') then t_interv = '71'
	
	if (t_interv = '77' OR t_interv = '78') then t_interv= '76'
	t_interv = LeftA(t_interv, 2)
	t_interv += space(2 - LenA(t_interv))
	if f_es_vacio(t_interv) then t_interv = space(2)
	dw_1.setitem(fila_insertada, 'T_INTERV',t_interv )
	
	// Tipo de Obra
	string tipo_obra
	tipo_obra = dw_movimientos.getitemstring(i, 'tipo_obra')
	tipo_obra = LeftA(tipo_obra, 2)
	tipo_obra += space(2 - LenA(tipo_obra))
	if f_es_vacio(tipo_obra) then tipo_obra = space(2)
	dw_1.setitem(fila_insertada, 'TIPO_OBRA',tipo_obra )	
	// Destino
	string destino
	destino = dw_movimientos.getitemstring(i, 'destino')
	destino = LeftA(destino, 2)
	destino += space(2 - LenA(destino))
	if f_es_vacio(destino) then destino = space(2)
	dw_1.setitem(fila_insertada, 'DESTINO',destino )		
	// Promotor
	string clase_promotor
	select t_promotor into :clase_promotor from fases_usos where id_fase = :id_fase;
	if  clase_promotor < 'A' OR  clase_promotor > 'Z' then
		clase_promotor = 'X'
	end if	
	dw_1.setitem(fila_insertada, 'PROMOTOR',clase_promotor )	
	// N$$HEX1$$fa00$$ENDHEX$$mero de Edificios
	double num_edif
	string num_edif_sl
	SELECT fases_usos.num_edif  
	INTO :num_edif  
	FROM fases_usos  
	WHERE ( fases_usos.id_fase = :id_fase )    ;
	num_edif_sl = string(num_edif)
	num_edif_sl = LeftA(num_edif_sl, 3)
	num_edif_sl = RightA('000' +num_edif_sl,3)
	if f_es_vacio(num_edif_sl) then num_edif_sl = '000'
	dw_1.setitem(fila_insertada, 'NUM_EDIF',num_edif_sl )		
	
	// N$$HEX1$$fa00$$ENDHEX$$mero de Viviendas
	double num_viv
	string num_viv_sl
	SELECT fases_usos.num_viv  
	INTO :num_viv  
	FROM fases_usos  
	WHERE ( fases_usos.id_fase = :id_fase )    ;
	num_viv= round(num_viv, 0)
	num_viv_sl = string(num_viv)
	num_viv_sl = LeftA(num_viv_sl, 4)
	num_viv_sl = RightA('0000' + num_viv_sl, 4)
	if f_es_vacio(num_viv_sl) then num_viv_sl = '0000'
	dw_1.setitem(fila_insertada, 'NUM_VIVIE',num_viv_sl )		

	// Superficie de Viviendas
	double sup_viv
	string sup_viv_sl
	SELECT fases_usos.sup_viv  
	INTO :sup_viv  
	FROM fases_usos  
	WHERE ( fases_usos.id_fase = :id_fase )    ;
	sup_viv = round(sup_viv, 0)
	sup_viv_sl = string(sup_viv)
	sup_viv_sl = LeftA(sup_viv_sl, 6)
	sup_viv_sl = RightA('000000' + sup_viv_sl,6)
	if f_es_vacio(sup_viv_sl) then sup_viv_sl = FillA('0',6)
	dw_1.setitem(fila_insertada, 'S_VIVIEN',sup_viv_sl )		
	
	// Superficie de Garajes
	double sup_garage
	string sup_garage_sl
	SELECT fases_usos.sup_garage  
	INTO :sup_garage  
	FROM fases_usos  
	WHERE ( fases_usos.id_fase = :id_fase )    ;
	sup_garage = round(sup_garage, 0)
	sup_garage_sl = string(sup_garage)
	sup_garage_sl = LeftA(sup_garage_sl, 6)
	sup_garage_sl = RightA(FillA('0', 6) + sup_garage_sl, 6)
	if f_es_vacio(sup_garage_sl) then sup_garage_sl = FillA('0',6)
	dw_1.setitem(fila_insertada, 'S_GARAJE',sup_garage_sl )		
	// Superficie Otros
	double sup_otros
	string sup_otros_sl
	SELECT fases_usos.sup_otros  
	INTO :sup_otros  
	FROM fases_usos  
	WHERE ( fases_usos.id_fase = :id_fase )    ;
	sup_otros = round(sup_otros,0)	
	sup_otros_sl = string(sup_otros)
	sup_otros_sl = LeftA(sup_otros_sl, 6)
	sup_otros_sl = RightA(FillA('0', 6) + sup_otros_sl, 6)
	if f_es_vacio(sup_otros_sl) then sup_otros_sl = FillA('0',6)
	dw_1.setitem(fila_insertada, 'S_OTROS_U',sup_otros_sl )			
	// Superficie Total
	double sup_total
	string sup_total_sl
	sup_total = sup_viv + sup_garage + sup_otros
	sup_total = round(sup_total,0)
	sup_total_sl = string(sup_total)
	sup_total_sl = LeftA(sup_total_sl, 6)
	sup_total_sl = RightA(FillA('0', 6) + sup_total_sl, 6)
	if f_es_vacio(sup_total_sl) then sup_total_sl = FillA('0',6)
	dw_1.setitem(fila_insertada, 'SUP_TOTAL',sup_total_sl )				
	// PEM
	double material
	string material_sl
	material = dw_movimientos.getitemnumber(i, 'presupuesto')
	material = round(material,0)
	material_sl = string(material)
	material_sl = LeftA(material_sl, 10)
	material_sl = RightA(FillA('0',10) + material_sl,10)
	if f_es_vacio(material_sl) then material_sl = FillA('0',10)
	dw_1.setitem(fila_insertada, 'MATERIAL',material_sl )
	
	// PLantas s/ rasante
	double pl_s_rasan
	string pl_s_rasan_sl
	SELECT fases_usos.plantas_sob  
	INTO :pl_s_rasan  
	FROM fases_usos  
	WHERE ( fases_usos.id_fase = :id_fase )    ;	
		
	pl_s_rasan_sl = string(pl_s_rasan) 	
	pl_s_rasan_sl = LeftA(pl_s_rasan_sl, 3)
	pl_s_rasan_sl = RightA('000' + pl_s_rasan_sl, 3)
	if f_es_vacio(pl_s_rasan_sl) then pl_s_rasan_sl = space(3)
	dw_1.setitem(fila_insertada, 'PL_S_RASAN',pl_s_rasan_sl )
	
	// Sup. s/ rasante
	double su_s_rasan
	string su_s_rasan_sl
	SELECT fases_usos.sup_sob  
	INTO :su_s_rasan  
	FROM fases_usos  
	WHERE ( fases_usos.id_fase = :id_fase )    ;	
		
	su_s_rasan_sl = string(su_s_rasan) 	
	su_s_rasan_sl = LeftA(su_s_rasan_sl, 6)
	su_s_rasan_sl = RightA(FillA('0', 6) + su_s_rasan_sl, 6)
	if f_es_vacio(su_s_rasan_sl) then su_s_rasan_sl = FillA('0', 6)
	dw_1.setitem(fila_insertada, 'SU_S_RASAN',su_s_rasan_sl )
	
	// Plantas b/ rasante
	double pl_b_rasan
	string pl_b_rasan_sl
	SELECT fases_usos.plantas_baj  
	INTO :pl_b_rasan  
	FROM fases_usos  
	WHERE ( fases_usos.id_fase = :id_fase )    ;	
		
	pl_b_rasan_sl = string(pl_b_rasan) 	
	pl_b_rasan_sl = LeftA(pl_b_rasan_sl, 3)
	pl_b_rasan_sl = RightA('000' + pl_b_rasan_sl,3)
	if f_es_vacio(pl_b_rasan_sl) then pl_b_rasan_sl = '000'
	dw_1.setitem(fila_insertada, 'PL_B_RASAN',pl_b_rasan_sl )
	
	// Sup. b/ rasante
	double su_b_rasan
	string su_b_rasan_sl
	SELECT fases_usos.sup_baj  
	INTO :su_b_rasan  
	FROM fases_usos  
	WHERE ( fases_usos.id_fase = :id_fase )    ;
		
	su_b_rasan_sl = string(su_b_rasan) 	
	su_b_rasan_sl = LeftA(su_b_rasan_sl, 6)
	su_b_rasan_sl = RightA(FillA('0',6) + su_b_rasan_sl, 6)
	if f_es_vacio(su_b_rasan_sl) then su_b_rasan_sl = FillA('0', 6)
	dw_1.setitem(fila_insertada, 'SU_B_RASAN',su_b_rasan_sl )		
	// Altura
	double altura
	string altura_sl
	SELECT fases_usos.altura  
	INTO :altura  
	FROM fases_usos  
	WHERE ( fases_usos.id_fase = :id_fase )    ;	
	altura = round(altura, 0)
	altura_sl = string(altura) 	
	altura_sl = LeftA(altura_sl, 3)
	altura_sl = RightA('000' + altura_sl, 3)
	if f_es_vacio(altura_sl) then altura_sl = '000'
	dw_1.setitem(fila_insertada, 'ALTURA',altura_sl )
	
	// Lads. Media
	string lads_media
	SELECT fases_usos.colindantes  
	INTO :lads_media  
	FROM fases_usos  
	WHERE ( fases_usos.id_fase = :id_fase )    ;
		
	choose case lads_media
		case '01'
			lads_media = '0'
		case '02'
			lads_media = '1'			
		case '03'
			lads_media = '2'
		case else
			lads_media = '0'			
	end choose
	dw_1.setitem(fila_insertada, 'LADS_MEDIA',lads_media )
	// Alquiler
	string uso
	SELECT fases_usos.uso  
	INTO :uso  
	FROM fases_usos  
	WHERE ( fases_usos.id_fase = :id_fase )    ;	
	// Venta
	// AutoUso
	dw_1.setitem(fila_insertada, 'ALQUILER','N')
	dw_1.setitem(fila_insertada, 'VENTA','N')
	dw_1.setitem(fila_insertada, 'AUTOUSO','N')
	
	choose case uso
		case 'V'
			dw_1.setitem(fila_insertada, 'VENTA','S')			
		case 'A'
			dw_1.setitem(fila_insertada, 'ALQUILER','S')			
		case 'U'
			dw_1.setitem(fila_insertada, 'AUTOUSO','S')			
	end choose
	
	
	// Estudio Geot$$HEX1$$e900$$ENDHEX$$cnico
	string est_geotec
	SELECT fases_usos.estudio_geo  
	INTO :est_geotec  
	FROM fases_usos  
	WHERE ( fases_usos.id_fase = :id_fase )    ;	
	
	dw_1.setitem(fila_insertada, 'EST_GEOTEC',est_geotec)			
		
	// Control de Calidad
	string cont_calidad
	SELECT fases_usos.cc_externo  
	INTO :cont_calidad  
	FROM fases_usos  
	WHERE ( fases_usos.id_fase = :id_fase )    ;	
	dw_1.setitem(fila_insertada, 'CONT_CALID',cont_calidad)		
	// Nivel de Control de Calidad
	string niv_cont_c
	SELECT fases_usos.niv_cont  
	INTO :niv_cont_c  
	FROM fases_usos  
	WHERE ( fases_usos.id_fase = :id_fase )    ;
		
		CHOOSE case niv_cont_c
			case 'R'
				dw_1.setitem(fila_insertada, 'NIV_CONT_C','1')							
			case 'N'
				dw_1.setitem(fila_insertada, 'NIV_CONT_C','2')							
			case 'A'
				dw_1.setitem(fila_insertada, 'NIV_CONT_C','3')							
			case else
				dw_1.setitem(fila_insertada, 'NIV_CONT_C','0')							
		end choose
	// Seguro Promotor
	dw_1.setitem(fila_insertada, 'SEG_PROMOT',SPACE(24))
next

i_escape = false
i_en_proceso = false
end event

type cb_guardar_texto from commandbutton within w_musaat_fichero_est
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
string p26,p27,p28,p29,p30,p31,p32, p33, p34, p35,p36,p37,p38,p39,p40,p41
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

value = GetFileSaveName("Introduzca el nombre del fichero estad$$HEX1$$ed00$$ENDHEX$$stico", &
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
	if f_es_vacio(p1) then p1 = space(12)
	p2 = dw_1.getitemstring(i,2)
	if f_es_vacio(p2) then p2 = FillA('0',8)	
	p3 = dw_1.getitemstring(i,3)
	if f_es_vacio(p3) then p3 = FillA('0',8)	
	p4 = dw_1.getitemstring(i,4)
	if f_es_vacio(p4) then p4 = FillA('0',6)	
	p5 = dw_1.getitemstring(i,5)
	if f_es_vacio(p5) then p5 = FillA('0',2)	
	p6 = dw_1.getitemstring(i,6)
	if f_es_vacio(p6) then p6 = space(4)	
	p7 = dw_1.getitemstring(i,7)
	if f_es_vacio(p7) then p7 = FillA('0',1)	
	p8 = dw_1.getitemstring(i,8)
	if f_es_vacio(p8) then p8 = space(12)	
	p9 = dw_1.getitemstring(i,9)
	if f_es_vacio(p9) then p9 = space(1)	
	p10 = dw_1.getitemstring(i,10)
	if f_es_vacio(p10) then p10 = space(30)	
	
	p11 = dw_1.getitemstring(i,11)
	if f_es_vacio(p11) then p11 = space(4)	
	p12 = dw_1.getitemstring(i,12)
	if f_es_vacio(p12) then p12 = space(5)	
	p13 = dw_1.getitemstring(i,13)
	if f_es_vacio(p13) then p13 = space(20)	
	p14 = dw_1.getitemstring(i,14)
	if f_es_vacio(p14) then p14 = space(20)	
	p15 = dw_1.getitemstring(i,15)
	if f_es_vacio(p15) then p15 = FillA('0',8)	
	p16 = dw_1.getitemstring(i,16)
	if f_es_vacio(p16) then p16 = FillA('0',7)
	p17 = dw_1.getitemstring(i,17)
	if f_es_vacio(p17) then p17 = FillA('0',8)
	p18 = dw_1.getitemstring(i,18)
	if f_es_vacio(p18) then p18 = space(2)	
	p19 = dw_1.getitemstring(i,19)
	if f_es_vacio(p19) then p19 = space(2)	
	p20 = dw_1.getitemstring(i,20)
	if f_es_vacio(p20) then p20 = space(2)	
	
	p21 = dw_1.getitemstring(i,21)
	if f_es_vacio(p21) then p21 = space(1)	
	p22 = dw_1.getitemstring(i,22)
	if f_es_vacio(p22) then p22 = FillA('0',3)	
	p23 = dw_1.getitemstring(i,23)
	if f_es_vacio(p23) then p23 = FillA('0',4)
	p24 = dw_1.getitemstring(i,24)
	if f_es_vacio(p24) then p24 = FillA('0',6)
	p25 = dw_1.getitemstring(i,25)
	if f_es_vacio(p25) then p25 = FillA('0',6)
	p26 = dw_1.getitemstring(i,26)
	if f_es_vacio(p26) then p26 = FillA('0',6)
	p27 = dw_1.getitemstring(i,27)
	if f_es_vacio(p27) then p27 = FillA('0',6)
	p28 = dw_1.getitemstring(i,28)
	if f_es_vacio(p28) then p28 = FillA('0',10)
	p29 = dw_1.getitemstring(i,29)
	if f_es_vacio(p29) then p29 = FillA('0',3)
	p30 = dw_1.getitemstring(i,30)
	if f_es_vacio(p30) then p30 = FillA('0',6)
	
	p31 = dw_1.getitemstring(i,31)
	if f_es_vacio(p31) then p31 = FillA('0',3)
	p32 = dw_1.getitemstring(i,32)
	if f_es_vacio(p32) then p32 = FillA('0',6)	
	p33 = dw_1.getitemstring(i,33)
	if f_es_vacio(p33) then p33 = FillA('0',3)
	p34 = dw_1.getitemstring(i,34)
	if f_es_vacio(p34) then p34 = space(1)	
	p35 = dw_1.getitemstring(i,35)
	if f_es_vacio(p35) then p35 = space(1)	
	p36 = dw_1.getitemstring(i,36)
	if f_es_vacio(p36) then p36 = space(1)	
	p37 = dw_1.getitemstring(i,37)
	if f_es_vacio(p37) then p37 = space(1)	
	p38 = dw_1.getitemstring(i,38)
	if f_es_vacio(p38) then p38 = space(1)	
	p39 = dw_1.getitemstring(i,39)
	if f_es_vacio(p39) then p39 = space(1)	
	p40 = dw_1.getitemstring(i,40)
	if f_es_vacio(p40) then p40 = space(1)	
	
	p41 = dw_1.getitemstring(i,41)
	if f_es_vacio(p41) then p41 = space(24)	
	
	linea = p1+p2+p3+p4+p5+p6+p7+p8+p9+p10+p11+p12+p13+p14+p15+p16+p17+p18+p19+p20+p21+p22+p23+p24+p25
	linea += p26+p27+p28+p29+p30+p31+p32+p33+p34+p35+p36+p37+p38+p39+p40+p41

	FileWrite(hFichero, linea)

next
//messagebox('kk', string(len(linea)))
FileClose(hFichero)
// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02


end event

type dw_consulta from u_dw within w_musaat_fichero_est
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

type cb_guardar_como from commandbutton within w_musaat_fichero_est
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

if dw_1.saveas() <> 1 then return

end event

type dw_1 from u_dw within w_musaat_fichero_est
integer x = 37
integer y = 32
integer width = 3387
integer height = 1284
integer taborder = 20
string dataobject = "d_musaat_estadistico_2002"
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

type cbx_excluir from checkbox within w_musaat_fichero_est
string tag = "texto=musaat.excluir_mov_comunicados"
boolean visible = false
integer x = 279
integer y = 1560
integer width = 1115
integer height = 56
integer taborder = 60
boolean bringtotop = true
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

type cb_listado from commandbutton within w_musaat_fichero_est
string tag = "texto=general.listado"
integer x = 1257
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
string text = "&Listado"
end type

event clicked;// Creado por Ricardo 2005-03-08

if dw_1.RowCount()<1 then return

// Creamos un listado para poder imprimir los datos
datastore ds_listado
ds_listado = create datastore
ds_listado.dataobject = 'd_musaat_estadistico_2002_listado'
ds_listado.settransobject(SQLCA)
dw_1.sharedata(ds_listado) // Ahora comparten los datos

// imprimimos
if ds_listado.rowCount()>0 then ds_listado.print()

// Descompartimos los buffers
ds_listado.sharedataoff()
// Destruimos el datastore
destroy ds_listado
end event

type cb_salir from commandbutton within w_musaat_fichero_est
string tag = "texto=general.salir"
integer x = 2889
integer y = 1456
integer width = 507
integer height = 96
integer taborder = 90
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

