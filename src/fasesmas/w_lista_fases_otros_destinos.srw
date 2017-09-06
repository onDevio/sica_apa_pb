HA$PBExportHeader$w_lista_fases_otros_destinos.srw
forward
global type w_lista_fases_otros_destinos from w_lista
end type
type cb_exportar_zurich from commandbutton within w_lista_fases_otros_destinos
end type
type dw_asociados from datawindow within w_lista_fases_otros_destinos
end type
end forward

global type w_lista_fases_otros_destinos from w_lista
integer height = 1292
string title = "Lista Integraci$$HEX1$$f300$$ENDHEX$$n Contratos Otras Compa$$HEX2$$f100ed00$$ENDHEX$$as"
cb_exportar_zurich cb_exportar_zurich
dw_asociados dw_asociados
end type
global w_lista_fases_otros_destinos w_lista_fases_otros_destinos

forward prototypes
public function string wf_prepara (any valor, string tipo, long longitud)
end prototypes

public function string wf_prepara (any valor, string tipo, long longitud);datetime datofecha
double datonum
string cadena	
	
	CHOOSE CASE tipo
			
		CASE 'D' // double, con 2 decimales
			datonum = valor
			cadena = String(f_redondea(datonum),"#0.00")
		 	IF IsNull(cadena) then cadena = ''
			 cadena = f_completar_con_caracteres(cadena,longitud,'I','0')

		CASE 'N' // number, con 0 decimales y con ceros por la izquierda
			datonum = valor
			cadena = String(Round(datonum,0))
		 	IF IsNull(cadena) then cadena = ''
			 cadena = f_completar_con_caracteres(cadena,longitud,'I','0')
	 			 
		CASE 'F' // datetime: fecha
			datofecha = valor
			cadena = String(Date(datofecha),'DDMMYYYY')
	  		IF IsNull(cadena) then cadena = ''
			 cadena = f_completar_con_caracteres(cadena,longitud,'I',' ')
			 
		CASE ELSE
			cadena = String(valor)
			IF IsNull(cadena) then cadena = ''
			 cadena = f_completar_con_caracteres(cadena,longitud,'D',' ')	
			 
	END CHOOSE
	
	cadena = f_reemplaza_cadena (cadena, CHAR(10),' ')
	
	// Truncamos el contenido de cada campo para asegurar que no exceda de la longitud m$$HEX1$$e100$$ENDHEX$$xima permitida
	cadena = Left (cadena, longitud)
	
	 
return cadena
			
			
		
		
		
		
end function

on w_lista_fases_otros_destinos.create
int iCurrent
call super::create
this.cb_exportar_zurich=create cb_exportar_zurich
this.dw_asociados=create dw_asociados
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_exportar_zurich
this.Control[iCurrent+2]=this.dw_asociados
end on

on w_lista_fases_otros_destinos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_exportar_zurich)
destroy(this.dw_asociados)
end on

event open;call super::open;inv_resize.of_Register (cb_exportar_zurich, "FixedtoBottom")
cb_consulta.Visible = TRUE
end event

event csd_consulta;call super::csd_consulta;//Disparo el Evento Clicked del boton Consultar
cb_consulta.TriggerEvent (Clicked!)
end event

event csd_actualiza_listas;// SOBREESCRITO
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_lista_fases_otros_destinos
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_lista_fases_otros_destinos
end type

type st_1 from w_lista`st_1 within w_lista_fases_otros_destinos
end type

type dw_lista from w_lista`dw_lista within w_lista_fases_otros_destinos
integer y = 0
integer height = 1004
string dataobject = "d_lista_fases_otros_destinos"
boolean hsplitscroll = true
end type

event dw_lista::csd_retrieve;//SOBREESCRITO
long i
string id_tramite, vor, vor_num, sql_nuevo, sql_nuevo_aso, codigo_colegio
datetime vor_data, cfo_data, ren_data, sin_data, f_nula//, f_entrada, f_visado, f_creacion

SetPointer(Hourglass!)
// Se asigna a variable que se utilizara para actualizar la lista (desde menu)
sql_nuevo = dw_lista.describe("datawindow.table.select")

//if g_f_abono_es_visado = 'S' THEN 
//	sql_nuevo = f_reemplaza_cadena(sql_nuevo,'SCD.f_visado','SCD.f_abono')
//end if
//
This.modify("DataWindow.Table.Select= ~"" + sql_nuevo+ "~"")

This.Retrieve(g_st_zurich.mes,g_st_zurich.anyo,g_st_zurich.src_cia,g_st_zurich.f_creacion)

SetNull(f_nula) 

// Inicializamos los campos necesarios para aplicar la ordenaci$$HEX1$$f300$$ENDHEX$$n
For i = 1 to dw_lista.RowCount()
	
	id_tramite = dw_lista.object.id_tramite[i]
	IF id_tramite = 'IP' OR id_tramite = 'VV' OR f_es_vacio(id_tramite) then 
		vor = 'V' 
		vor_num = dw_lista.object.n_visado[i]
	else
		vor = 'R'
		vor_num = dw_lista.object.n_registro[i]
	end if
	
	dw_lista.object.vor[i] = vor
	dw_lista.object.vor_num[i] = vor_num
	
next

// Ordenamos
dw_lista.Sort()
SetPointer(Arrow!)


end event

event dw_lista::pfc_updatespending;//SOBREESCRITO
return 0
end event

type cb_consulta from w_lista`cb_consulta within w_lista_fases_otros_destinos
boolean visible = true
integer x = 590
integer y = 1008
end type

event cb_consulta::clicked;//SOBREESCRITO
//Abrimos la ventana de consulta
open(w_query_fases_otros_destinos)
if Message.DoubleParm = -1 then return

dw_lista.Event csd_retrieve()
end event

type cb_detalle from w_lista`cb_detalle within w_lista_fases_otros_destinos
end type

type cb_ayuda from w_lista`cb_ayuda within w_lista_fases_otros_destinos
end type

type cb_exportar_zurich from commandbutton within w_lista_fases_otros_destinos
integer x = 1211
integer y = 1008
integer width = 512
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Exportar"
end type

event clicked;string coleg_vr, coleg_cz,  vor_t, vor_exp, cole_num, cole_nom, cole_nif, obr_adr, obr_num, obr_cp, obr_pob, obr_ti, obr_to, obr_td, obr_ofi, obr_col, obr_mtg, obr_uso, obr_llg, obr_vda, obr_au, obr_eg, obr_cq, obr_ncq, cfo_tp, prom_tip, prom_nif, prom_nom, prom_adr, prom_num, prom_cp, prom_pob
//string obr_cat, observacions, zur_cer, zur_pol, zur_cob, zur_tram, 
string id_fase, n_registro, n_visado
//string obr_tipo_via, prom_tipo_via
string directorio, nombre_fichero, cadena
string vor, vor_num, id_tramite
double cole_par, obr_pem, obr_vol, obr_ne, obr_nh, obr_st, obr_sh, obr_sg, obr_sa, obr_psr, obr_ssr, obr_pbr, obr_sbr, obr_alt
double cfo_per, ren_per, cole_gar, cole_sin
//datetime sin_data//, f_entrada, f_visado, f_creacion
long i, value

string cole_ass, id_colegiado, src_alta, data, vor_data, cfo_data, ren_data

int hfichero
n_cst_filesrvwin32 cambia_directorio

SetPointer(Hourglass!)
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
nombre_fichero = 'Datos_Contratos_otras_demarcaciones'  + '_' + String(g_st_zurich.mes) + '_' + String(g_st_zurich.anyo) + '_' + String(g_st_zurich.f_creacion,'DDMMYYYY')+'.txt'
value = GetFileSaveName("Introduzca el nombre del fichero", 	nombre_fichero, nombre_fichero, "TXT", "Text Files (*.TXT),*.TXT," )
IF value <> 1 THEN 
	// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
	cambia_directorio.of_changedirectory(directorio)
	destroy cambia_directorio
	return
end if

hfichero = FileOpen(nombre_fichero,Linemode!,write!,shared!,replace!)

select colegios.cod_colegios_cat into :coleg_vr from colegios, var_globales where colegios.cod_colegio = var_globales.texto and var_globales.nombre = 'g_cod_colegio';

for i = 1 to dw_lista.RowCount()

//	coleg_vr = dw_lista.object.coleg_vr[i]
	coleg_cz = dw_lista.object.coleg_cz[i]
select colegios.cod_colegios_cat into :coleg_cz from colegios where colegios.cod_colegio = :coleg_cz;

	id_fase = dw_lista.object.id_fase[i]
	id_tramite = dw_lista.object.id_tramite[i]
	//f_creacion = dw_lista.object.f_creacion[i]
	CHOOSE CASE id_tramite 
		CASE 'VV', 'IP' 
			vor = 'V'
		CASE else 
			vor = 'R'
	END CHOOSE	
	
	vor_num = dw_lista.object.vor_num[i]
	data = dw_lista.object.data1[i]
	vor_data = dw_lista.object.vor_data[i]

//	vor_t = dw_lista.object.vor_t[i]
//	vor_exp = dw_lista.object.vor_exp[i]
	cole_num = dw_lista.object.cole_num[i]
	cole_nom = dw_lista.object.cole_nom[i]
	cole_ass = dw_lista.object.cole_ass[i]
	id_colegiado = dw_lista.object.id_colegiado[i]
	
	if cole_ass = 'MUSAAT' then 
		cole_gar = dw_lista.object.cole_gar[i]
		cole_sin = dw_lista.object.cole_sin[i]
	else 
		select sc.alta, LTRIM(mca.nom_s), sc.src_cober
		into :src_alta, :cole_ass, :cole_gar
		from src_colegiado sc, musaat_cias_aseguradoras mca
		where sc.src_cia = mca.cod_s and sc.id_colegiado =:id_colegiado;
		
		if src_alta = 'S' then 
			cole_sin = 1.00
		else 
			cole_ass = ''
			cole_gar = 0.00
			cole_sin = 1.00
		end if 	
		
	end if 
	
	cole_par = dw_lista.object.cole_par[i]
	cole_nif = dw_lista.object.cole_nif[i]
//	obr_tipo_via = dw_lista.object.obr_tipo_via[i]
	obr_adr = dw_lista.object.obr_adr[i]
//  IF NOT f_es_vacio(obr_tipo_via) then  obr_adr = obr_tipo_via + ' ' + obr_adr
	obr_num = dw_lista.object.obr_num[i]
	obr_cp = dw_lista.object.obr_cp[i]
	obr_pob = dw_lista.object.obr_pob[i]
	//obr_cat = dw_lista.object.obr_cat[i]
	obr_pem = dw_lista.object.obr_pem[i]
	obr_ti = dw_lista.object.obr_ti[i]
	obr_to = dw_lista.object.obr_to[i]
	obr_td = dw_lista.object.obr_td[i]
	obr_ofi = dw_lista.object.obr_ofi[i]
	IF f_es_vacio(obr_ofi) then obr_ofi = 'N'
	obr_vol = dw_lista.object.obr_vol[i]
	obr_col = dw_lista.object.obr_col[i]
	obr_ne = dw_lista.object.obr_ne[i]
	obr_nh = dw_lista.object.obr_nh[i]
	obr_sh = dw_lista.object.obr_sh[i]
	obr_sg = dw_lista.object.obr_sg[i]
	obr_sa = dw_lista.object.obr_sa[i]
	IF IsNull(obr_sh) then obr_sh = 0
	IF IsNull(obr_sg) then obr_sg = 0
	IF IsNull(obr_sa) then obr_sa = 0
	obr_st = obr_sh + obr_sg + obr_sa
	obr_psr = dw_lista.object.obr_psr[i]
	obr_ssr = dw_lista.object.obr_ssr[i]
	obr_pbr = dw_lista.object.obr_pbr[i]
	obr_sbr = dw_lista.object.obr_sbr[i]
	obr_alt = dw_lista.object.obr_alt[i]
	obr_mtg = dw_lista.object.obr_mtg[i]
	if obr_mtg = '02' OR obr_mtg = '03' then // tabla colindantes: '02','03' A un lado / M$$HEX1$$e100$$ENDHEX$$s de un lado
		obr_mtg = 'S' 
	else  // 01 No existen, $$HEX2$$f3002000$$ENDHEX$$Vac$$HEX1$$ed00$$ENDHEX$$o
		obr_mtg = 'N'
	end if
	
	obr_vda = 'N'
	obr_llg = 'N'
	obr_au = 'N'
	
	obr_uso = dw_lista.object.obr_uso[i]
	CHOOSE CASE obr_uso 
		CASE 'V' 
			obr_vda = 'S'
		CASE 'A' 
			obr_llg = 'S'
		CASE 'U' 
			obr_au = 'S'
	END CHOOSE
	obr_eg = dw_lista.object.obr_eg[i]
	obr_cq = dw_lista.object.obr_cq[i]
	obr_ncq = dw_lista.object.obr_ncq[i]
	cfo_tp = dw_lista.object.cfo_tp[i]
	if cfo_tp  ='V' then cfo_tp = 'T' // t_fases_finales
	cfo_data = dw_lista.object.cfo_data[i]
	cfo_per = dw_lista.object.cfo_per[i]
	ren_data = dw_lista.object.ren_data[i]
	ren_per = dw_lista.object.ren_per[i]
	//sin_data = dw_lista.object.sin_data[i]
	prom_tip = dw_lista.object.prom_tip[i]
	prom_nif = dw_lista.object.prom_nif[i]
	prom_nom = dw_lista.object.prom_nom[i]
	//prom_tipo_via = dw_lista.object.prom_tipo_via[i]
	prom_adr = dw_lista.object.prom_adr[i]
	//IF NOT f_es_vacio(prom_tipo_via) then  prom_adr = prom_tipo_via + ' ' + prom_adr
	prom_num = dw_lista.object.prom_num[i]
	prom_cp = dw_lista.object.prom_cp[i]
	prom_pob = dw_lista.object.prom_pob[i]
	//observacions = dw_lista.object.observacions[i]
	//observacions = ''
//	zur_cer = dw_lista.object.zur_cer[i]
//	zur_pol = dw_lista.object.zur_pol[i]
//	zur_cob = dw_lista.object.zur_cob[i]
//	zur_tram = dw_lista.object.zur_tram[i]
	

	//cadena = wf_prepara(g_st_zurich.mes,'N',2) + wf_prepara(g_st_zurich.anyo,'N',4) + wf_prepara(coleg_vr,'',2) + wf_prepara(coleg_cz,'',2) + vor + wf_prepara(vor_t,'',1) + wf_prepara(vor_exp,'',12)+ wf_prepara(vor_num,'',12)+ wf_prepara(vor_data,'F',8)+ wf_prepara(cole_num,'',6)+ wf_prepara(cole_nom,'',75)+ wf_prepara(cole_par,'D',6) + wf_prepara(cole_nif,'',10)+ wf_prepara(obr_adr,'',100) + wf_prepara(obr_num,'',4) + wf_prepara(obr_cp,'',5) + wf_prepara(obr_pob,'',75) + wf_prepara(obr_cat,'',100) + wf_prepara(obr_pem,'D',15) + wf_prepara(obr_ti,'',3) + wf_prepara(obr_to,'',3) + wf_prepara(obr_td,'',3) + wf_prepara(obr_ofi,'',1) + wf_prepara(obr_vol,'D',8) + wf_prepara(obr_col,'',1) + wf_prepara(obr_ne,'N',3) + wf_prepara(obr_nh,'N',4) + wf_prepara(obr_st,'D',9) + wf_prepara(obr_sh,'D',9) + wf_prepara(obr_sg,'D',9) + wf_prepara(obr_sa,'D',9) + wf_prepara(obr_psr,'N',3) + wf_prepara(obr_ssr,'D',9) + wf_prepara(obr_pbr,'N',3) + wf_prepara(obr_sbr,'D',9) + wf_prepara(obr_alt,'D',6) + wf_prepara(obr_mtg,'',1) + wf_prepara(obr_llg,'',1) + wf_prepara(obr_vda,'',1) + wf_prepara(obr_au,'',1) + wf_prepara(obr_eg,'',1) + wf_prepara(obr_cq,'',1) + wf_prepara(obr_ncq,'',1) + wf_prepara(cfo_tp,'',1) + wf_prepara(cfo_data,'F',8) + wf_prepara(cfo_per,'D',6) + wf_prepara(ren_data,'F',8) + wf_prepara(ren_per,'D',6) + wf_prepara(sin_data,'F',8) + wf_prepara(prom_tip,'',1) + wf_prepara(prom_nif,'',10) + wf_prepara(prom_nom,'',75) + wf_prepara(prom_adr,'',100) + wf_prepara(prom_num,'',4) + wf_prepara(prom_cp,'',5) + wf_prepara(prom_pob,'',25) + wf_prepara(observacions,'',255) + wf_prepara(zur_cer,'',15) + wf_prepara(zur_pol,'',15) + wf_prepara(zur_cob,'',9) + wf_prepara(zur_tram,'',1) 
	cadena = wf_prepara(coleg_vr, '', 2) + wf_prepara(coleg_cz, '', 2) + data + vor + wf_prepara(vor_num, '', 12) + wf_prepara('', '', 12) + vor_data
	cadena = cadena + wf_prepara(cole_num, '', 6) + wf_prepara(cole_nom, '', 30) + wf_prepara(cole_ass, '', 25) + wf_prepara(cole_gar, 'N', 15) + wf_prepara(cole_sin, 'D', 5) + wf_prepara(cole_par, 'N', 6) + wf_prepara(cole_nif, '', 10)
	cadena = cadena + wf_prepara(obr_adr, '', 30) + wf_prepara(obr_num, '', 4) + wf_prepara(obr_cp, '', 5) + wf_prepara(obr_pob, '', 25) 
	cadena = cadena + wf_prepara(obr_pem, 'D', 15) + wf_prepara(obr_ti, '', 3) + wf_prepara(obr_to, '', 3) + wf_prepara(obr_td, '', 3) + obr_ofi + wf_prepara(obr_vol, 'D', 8)
	cadena = cadena + wf_prepara(obr_col, '', 1)+ wf_prepara(obr_ne, '', 3) + wf_prepara(obr_nh, '', 4) + wf_prepara(obr_st, 'D', 9) + wf_prepara(obr_sh, 'D', 9) + wf_prepara(obr_sg, 'D', 9) + wf_prepara(obr_sa, 'D', 9)
	cadena = cadena + wf_prepara(obr_psr, '', 3) + wf_prepara(obr_ssr, 'D', 9) + wf_prepara(obr_pbr, '', 3) + wf_prepara(obr_sbr, 'D', 9) + wf_prepara(obr_alt, 'D', 6) 
	cadena = cadena + wf_prepara(obr_mtg, '', 1) + obr_llg + obr_vda + obr_au + wf_prepara(obr_eg, '', 1) + wf_prepara(obr_cq, '', 1) + wf_prepara(obr_ncq, '', 1) + wf_prepara(cfo_tp, '', 1) + wf_prepara(cfo_data, '', 8) + wf_prepara( cfo_per, 'D', 6) 
	cadena = cadena + wf_prepara(ren_data, '', 8) + wf_prepara( ren_per, 'D', 6)
	cadena = cadena + prom_tip + wf_prepara(prom_nif, '', 10) + wf_prepara( prom_nom, '', 30) + wf_prepara( prom_adr, '', 60) + wf_prepara( prom_num, '', 4) + wf_prepara( prom_cp, '', 5) + wf_prepara( prom_pob, '', 25)
	cadena = cadena + + wf_prepara('', '', 100)
	IF g_debug = '1' then 
		if Len(cadena) <> 582 then 	MessageBox(g_titulo,'L$$HEX1$$ed00$$ENDHEX$$nea: '+String(i)+cr+'Longitud diferente de 582: '+string(Len(cadena)))
	END IF
	
	FileWrite(hFichero,cadena)	
next

FileClose(hFichero)
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
MessageBox(g_titulo,'Se ha creado el fichero: '+nombre_fichero)
SetPointer(Arrow!)

end event

type dw_asociados from datawindow within w_lista_fases_otros_destinos
boolean visible = false
integer x = 2793
integer y = 1056
integer width = 686
integer height = 400
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_zurich_lista_integra_contratos_aso"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

