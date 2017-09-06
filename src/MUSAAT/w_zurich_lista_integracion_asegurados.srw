HA$PBExportHeader$w_zurich_lista_integracion_asegurados.srw
forward
global type w_zurich_lista_integracion_asegurados from w_lista
end type
type cb_exportar_zurich from commandbutton within w_zurich_lista_integracion_asegurados
end type
end forward

global type w_zurich_lista_integracion_asegurados from w_lista
integer height = 1292
string title = "Lista Integraci$$HEX1$$f300$$ENDHEX$$n Asegurados Otras Compa$$HEX2$$f100ed00$$ENDHEX$$as"
cb_exportar_zurich cb_exportar_zurich
end type
global w_zurich_lista_integracion_asegurados w_zurich_lista_integracion_asegurados

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
	
	// Truncamos el contenido de cada campo para asegurar que no exceda de la longitud m$$HEX1$$e100$$ENDHEX$$xima permitida
	cadena = Left (cadena, longitud)
	 
return cadena
			
			
		
		
		
		
end function

on w_zurich_lista_integracion_asegurados.create
int iCurrent
call super::create
this.cb_exportar_zurich=create cb_exportar_zurich
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_exportar_zurich
end on

on w_zurich_lista_integracion_asegurados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_exportar_zurich)
end on

event open;call super::open;inv_resize.of_Register (cb_exportar_zurich, "FixedtoBottom")
cb_consulta.Visible = TRUE
end event

event csd_consulta;call super::csd_consulta;//Disparo el Evento Clicked del boton Consultar
cb_consulta.TriggerEvent (Clicked!)
end event

event csd_actualiza_listas;// SOBREESCRITO
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_zurich_lista_integracion_asegurados
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_zurich_lista_integracion_asegurados
end type

type st_1 from w_lista`st_1 within w_zurich_lista_integracion_asegurados
end type

type dw_lista from w_lista`dw_lista within w_zurich_lista_integracion_asegurados
string dataobject = "d_zurich_lista_integracion_asegurados"
end type

event dw_lista::csd_retrieve;//SOBREESCRITO

This.Retrieve(g_st_zurich.src_cia,g_st_zurich.f_creacion)

// Ordenamos
dw_lista.Sort()

end event

event dw_lista::pfc_updatespending;//SOBREESCRITO
return 0
end event

type cb_consulta from w_lista`cb_consulta within w_zurich_lista_integracion_asegurados
boolean visible = true
integer x = 590
integer y = 1008
end type

event cb_consulta::clicked;//SOBREESCRITO
//Abrimos la ventana de consulta
open(w_zurich_consulta_integracion)
if Message.DoubleParm = -1 then return

dw_lista.Event csd_retrieve()
end event

type cb_detalle from w_lista`cb_detalle within w_zurich_lista_integracion_asegurados
end type

type cb_ayuda from w_lista`cb_ayuda within w_zurich_lista_integracion_asegurados
end type

type cb_exportar_zurich from commandbutton within w_zurich_lista_integracion_asegurados
integer x = 1211
integer y = 1008
integer width = 599
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Exportaci$$HEX1$$f300$$ENDHEX$$n &Asegurados"
end type

event clicked;string cole_col, cole_nif, cole_num, cole_nom, cole_adr, cole_cp, cole_pob, cole_email, zur_tram, zur_alta, zur_motiu_baixa, zur_moros, zur_cer, zur_pol, zur_cob
string directorio, nombre_fichero, cadena
datetime zur_data_alta, zur_data_baixa
long i, value, zur_num_sin
int hfichero
n_cst_filesrvwin32 cambia_directorio
n_cst_string ln_cst_string

SetPointer(Hourglass!)
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
nombre_fichero = ln_cst_string.of_globalreplace(f_musaat_descripcion_companyia(g_st_zurich.src_cia),' ','_') + '_Asegurados'  + '_' + String(g_st_zurich.mes) + '_' + String(g_st_zurich.anyo) + '_' + String(g_st_zurich.f_creacion,'DDMMYYYY')+'.txt'
value = GetFileSaveName("Introduzca el nombre del fichero", 	nombre_fichero, nombre_fichero, "TXT", "Text Files (*.TXT),*.TXT," )
IF value <> 1 THEN 
	// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
	cambia_directorio.of_changedirectory(directorio)
	destroy cambia_directorio
	return
end if

hfichero = FileOpen(nombre_fichero,Linemode!,write!,shared!,replace!)

for i = 1 to dw_lista.RowCount()
	
	cole_col = dw_lista.object.cole_col[i]
	cole_nif = dw_lista.object.cole_nif[i]
	cole_num = dw_lista.object.cole_num[i]
	cole_nom = dw_lista.object.cole_nom[i]
	cole_adr = dw_lista.object.cole_adr[i]
	cole_cp = dw_lista.object.cole_cp[i]
	cole_pob = dw_lista.object.cole_pob[i]
	cole_email = dw_lista.object.cole_email[i]
	zur_tram = dw_lista.object.zur_tram[i]
	zur_alta = dw_lista.object.zur_alta[i]
	zur_data_alta = dw_lista.object.zur_data_alta[i]
	zur_data_baixa = dw_lista.object.zur_data_baixa[i]
	zur_motiu_baixa = dw_lista.object.zur_motiu_baixa[i]
	zur_moros = dw_lista.object.zur_moros[i]
	zur_num_sin = dw_lista.object.zur_num_sin[i]
	zur_cer = dw_lista.object.zur_cer[i]
	zur_pol = dw_lista.object.zur_pol[i]
	zur_cob = dw_lista.object.zur_cob[i]

	cadena = wf_prepara(g_st_zurich.mes,'N',2) + wf_prepara(g_st_zurich.anyo,'N',4)  +wf_prepara(cole_col,'',2) +  wf_prepara(cole_nif,'',10) +  wf_prepara(cole_num,'',6) +  wf_prepara(cole_nom,'',75) +  wf_prepara(cole_adr,'',100) +  wf_prepara(cole_cp,'',5) +  wf_prepara(cole_pob,'',75) +  wf_prepara(cole_email,'',100) +  wf_prepara(zur_tram,'',1) +  wf_prepara(zur_alta,'',1) +  wf_prepara(zur_data_alta,'F',8) +  wf_prepara(zur_data_baixa,'F',8) +  wf_prepara(zur_motiu_baixa,'',255) +  wf_prepara(zur_moros,'',1) +  wf_prepara(zur_num_sin,'N',5) +  wf_prepara(zur_cer,'',15) +  wf_prepara(zur_pol,'',15) +  wf_prepara(zur_cob,'',9)   
//		cadena = wf_prepara(g_st_zurich.mes,'N',2) + wf_prepara(g_st_zurich.anyo,'',4) + wf_prepara(coleg_vr,'',2) + wf_prepara(coleg_cz,'',2) + vor + wf_prepara(vor_t,'',1) + wf_prepara(vor_exp,'',12)+ wf_prepara(vor_num,'',12)+ wf_prepara(vor_data,'F',8)+ wf_prepara(cole_num,'',6)+ wf_prepara(cole_nom,'',75)+ wf_prepara(cole_par,'D',6) + wf_prepara(cole_nif,'',10)+ wf_prepara(obr_adr,'',100) + wf_prepara(obr_num,'',4) + wf_prepara(obr_cp,'',5) + wf_prepara(obr_pob,'',75) + wf_prepara(obr_cat,'',100) + wf_prepara(obr_pem,'D',15) + wf_prepara(obr_ti,'',3) + wf_prepara(obr_to,'',3) + wf_prepara(obr_td,'',3) + wf_prepara(obr_ofi,'',1) + wf_prepara(obr_vol,'D',8) + wf_prepara(obr_col,'',1) + wf_prepara(obr_ne,'N',3) + wf_prepara(obr_nh,'N',4) + wf_prepara(obr_st,'D',9) + wf_prepara(obr_sh,'D',9) + wf_prepara(obr_sg,'D',9) + wf_prepara(obr_sa,'D',9) + wf_prepara(obr_psr,'N',3) + wf_prepara(obr_ssr,'D',9) + wf_prepara(obr_pbr,'N',3) + wf_prepara(obr_sbr,'D',9) + wf_prepara(obr_alt,'D',6) + wf_prepara(obr_mtg,'',1) + wf_prepara(obr_llg,'',1) + wf_prepara(obr_vda,'',1) + wf_prepara(obr_au,'',1) + wf_prepara(obr_eg,'',1) + wf_prepara(obr_cq,'',1) + wf_prepara(obr_ncq,'',1) + wf_prepara(cfo_tp,'',1) + wf_prepara(cfo_data,'F',8) + wf_prepara(cfo_per,'D',6) + wf_prepara(ren_data,'F',8) + wf_prepara(ren_per,'D',6) + wf_prepara(sin_data,'F',8) + wf_prepara(prom_tip,'',1) + wf_prepara(prom_nif,'',10) + wf_prepara(prom_nom,'',75) + wf_prepara(prom_adr,'',100) + wf_prepara(prom_num,'',4) + wf_prepara(prom_cp,'',5) + wf_prepara(prom_pob,'',25) + wf_prepara(observacions,'',255) + wf_prepara(zur_cer,'',15) + wf_prepara(zur_pol,'',15) + wf_prepara(zur_cob,'',9) + wf_prepara(zur_tram,'',1) 
	IF g_debug = '1' then 
		if Len(cadena) <> 697 then 	MessageBox(g_titulo,'L$$HEX1$$ed00$$ENDHEX$$nea: '+String(i)+cr+'Longitud diferente de 698: '+string(Len(cadena)))
	END IF
	
	FileWrite(hFichero,cadena)	
next

FileClose(hFichero)
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
MessageBox(g_titulo,'Se ha creado el fichero: '+nombre_fichero)
SetPointer(Arrow!)

end event

