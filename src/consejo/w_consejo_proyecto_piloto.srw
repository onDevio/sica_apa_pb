HA$PBExportHeader$w_consejo_proyecto_piloto.srw
forward
global type w_consejo_proyecto_piloto from w_sheet
end type
type st_fichero from statictext within w_consejo_proyecto_piloto
end type
type hpb_fichero from hprogressbar within w_consejo_proyecto_piloto
end type
type st_proceso from statictext within w_consejo_proyecto_piloto
end type
type dw_fich from u_dw within w_consejo_proyecto_piloto
end type
type cb_recuperar from commandbutton within w_consejo_proyecto_piloto
end type
type st_1 from statictext within w_consejo_proyecto_piloto
end type
type cb_3 from commandbutton within w_consejo_proyecto_piloto
end type
type cb_2 from commandbutton within w_consejo_proyecto_piloto
end type
type dw_consulta from u_dw within w_consejo_proyecto_piloto
end type
type cb_guardar_texto from commandbutton within w_consejo_proyecto_piloto
end type
type dw_listado from u_dw within w_consejo_proyecto_piloto
end type
type dw_1 from datawindow within w_consejo_proyecto_piloto
end type
type dw_2 from datawindow within w_consejo_proyecto_piloto
end type
type dw_3 from datawindow within w_consejo_proyecto_piloto
end type
type cb_1 from commandbutton within w_consejo_proyecto_piloto
end type
type cb_promo from commandbutton within w_consejo_proyecto_piloto
end type
type dw_4 from datawindow within w_consejo_proyecto_piloto
end type
end forward

global type w_consejo_proyecto_piloto from w_sheet
integer x = 214
integer y = 221
integer width = 3442
integer height = 1724
string title = "Visados Consejo"
windowstate windowstate = maximized!
event csd_resituar_progressbar ( )
st_fichero st_fichero
hpb_fichero hpb_fichero
st_proceso st_proceso
dw_fich dw_fich
cb_recuperar cb_recuperar
st_1 st_1
cb_3 cb_3
cb_2 cb_2
dw_consulta dw_consulta
cb_guardar_texto cb_guardar_texto
dw_listado dw_listado
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
cb_1 cb_1
cb_promo cb_promo
dw_4 dw_4
end type
global w_consejo_proyecto_piloto w_consejo_proyecto_piloto

type variables
datastore ds_col
boolean ib_printpreviewactivado=false
long i_abierto
string is_mensaje1, is_mensaje2
end variables

forward prototypes
public function string wf_tipo_via (string cod_tipo_via)
public subroutine wf_cia_seguros_apa (string id_fase, ref string cia1, ref string cia2, ref string cia3, ref string cia4, ref string cia5)
public subroutine wf_rellenar_dw (datastore ds_datos_obras)
end prototypes

event csd_resituar_progressbar;hpb_fichero.y = st_proceso.y
hpb_fichero.x = this.workspacewidth() - 10 -hpb_fichero.width
end event

public function string wf_tipo_via (string cod_tipo_via);// Vamos a considerar solo los tipos de via especificados por el consejo
string retorno

CHOOSE CASE cod_tipo_via
	CASE 'AD','AL','AP','AV','BL','BO','CH','CL','CM','CO','CR','CS','CT','ED','GL',&
		  'GR','LG','MC','MN','MZ','PB','PG','PJ','PQ','PR','PS','PZ','RB','RD','TR','UR'
		retorno = cod_tipo_via
	CASE ELSE
		retorno = '  '
END CHOOSE

return retorno




//string retorno
//
//CHOOSE CASE cod_tipo_via
//	CASE 'PL'
//		retorno = 'PZ'
//	CASE 'TV'
//		retorno = 'TR'
//	CASE 'CT'
//		retorno = 'CR'
//	CASE 'PO'
//		retorno = 'PG'
//	CASE 'CA'
//		retorno = 'CM'
//	CASE 'C$$HEX1$$ba00$$ENDHEX$$'
//		retorno = 'CS'
//	CASE 'SC'
//		retorno = '  '
//	CASE 'B'
//		retorno = '  '
//	CASE 'RO'
//		retorno = 'RD'
//	CASE ELSE
//		retorno = cod_tipo_via
//END CHOOSE
//
//return retorno
//
end function

public subroutine wf_cia_seguros_apa (string id_fase, ref string cia1, ref string cia2, ref string cia3, ref string cia4, ref string cia5);string cia, id_col
int i

ds_col.retrieve(id_fase)

for i=1 to ds_col.rowcount()
	cia = ''
	id_col = ds_col.getitemstring(i, 'id_col')
	
	SELECT musaat_cias_aseguradoras.nom_s  
	INTO :cia  
	FROM musaat, musaat_cias_aseguradoras  
	WHERE ( musaat.src_cia = musaat_cias_aseguradoras.cod_s ) and  
			( ( musaat.id_col = :id_col ) )   ;
			
			
	if cia = 'M.U.S.A.A.T' or cia = 'M.U.S.A.A.T.' then cia = 'MUSAAT'

	choose case i
		case 1
			cia1 = f_completar_con_caracteres(cia,50,'D',' ')
		case 2
			cia2 = f_completar_con_caracteres(cia,50,'D',' ')
		case 3
			cia3 = f_completar_con_caracteres(cia,50,'D',' ')
		case 4
			cia4 = f_completar_con_caracteres(cia,50,'D',' ')
		case 5
			cia5 = f_completar_con_caracteres(cia,50,'D',' ')
	end choose
next

end subroutine

public subroutine wf_rellenar_dw (datastore ds_datos_obras);string clase_prom, n_registro, nom_prom, tel_prom, dir_prom, pob_prom, prov_prom, dir_obra, pob_obra 
string cp_obra, tipo, cp_asoc, cp_prom, num_obra, cia1, cia2, cia3, cia4, cia5, n_cont_ant, sql,piso_obra,puerta_obra,pob_mopu,f_abono
string id_colegiado, sl_sexo, sl_promotor = 'N', sl_destino, sFecha, ls_inicio_final, n_consejo, ls_tip, ls_to, mensaje='', nombrefichero,forma_ejecucion
long filas, i, fila, j, fichero = 0
double sup_total, sup_viv, sup_gar, sup_otros, num_edif, num_viv, pem, num_psob, sup_sob,finales_presupuesto, ld_naves = 0
double num_pbaj, sup_pbaj, altura
datetime f_desde, f_hasta, dt_f_nacimiento, fecha
int cuantos  = 0, il_edad_colegiado
string to_vacio = 'Tipo de obra vac$$HEX1$$ed00$$ENDHEX$$o: ', sl_destino_vacio = 'Destino de la obra vac$$HEX1$$ed00$$ENDHEX$$o: '
string sl_destino_incorrecto = 'Destino de la obra incorrecto: ', num_viv_cero = 'N$$HEX1$$fa00$$ENDHEX$$mero de viviendas cero: '



ds_datos_obras.Retrieve()
filas = ds_datos_obras.RowCount()

// Datastore de instancia para obtener las compa$$HEX1$$f100$$ENDHEX$$ias aseguradoras de los colegiados
ds_col = create datastore
ds_col.dataobject = 'ds_fases_colegiados_cnc'
ds_col.settransobject(sqlca)

// Metemos los datos en el datawindow para crear el fichero
setpointer(hourglass!)

for i = 1 to filas
	fila = dw_fich.insertrow(0)
	//st_proceso.text = 'Recuperando Obras : ' + string(i) + '/' + string(filas)
	
	//Inicios/finales de obra
	//Lo detecto por el dw del datastore
	if ds_datos_obras.dataobject='ds_consejo_proyecto_piloto_finales_obra' then
		ls_inicio_final='F'
	else 
		ls_inicio_final='I'
	end if
	
	dw_fich.setitem(fila, 'inicio_final', ls_inicio_final)
	//N$$HEX1$$fa00$$ENDHEX$$mero de colegiado
//	dw_fich.setitem(fila, 'n_colegiado', ds_datos_obras.getitemstring(i, 'n_colegiado'))
	// N$$HEX1$$fa00$$ENDHEX$$mero de Expediente (12 derecha)
	//messagebox("",string(ds_datos_obras.getitemdatetime(i, 'fases_f_entrada'), "dd/mm/yyyy"))
	n_registro = f_completar_con_caracteres(ds_datos_obras.getitemstring(i, 'fases_n_registro'),12,'I',' ')
	dw_fich.setitem(fila, 'num_exp', RightA(n_registro,12))
	// N$$HEX2$$ba002000$$ENDHEX$$Visado Luis ICTL-133
	if g_colegio = 'COAATTEB' then // CGN-319
		
		if not f_es_vacio(ds_datos_obras.getitemstring(i, 'fases_archivo')) then
			n_registro = f_completar_con_caracteres(ds_datos_obras.getitemstring(i, 'fases_archivo'),12,'I',' ')
			dw_fich.setitem(fila, 'num_exp', RightA(n_registro,12))
		else
			n_registro = f_completar_con_caracteres(ds_datos_obras.getitemstring(i, 'fases_n_registro'),12,'I',' ')
			dw_fich.setitem(fila, 'num_exp', RightA(n_registro,12))
		end if
		
	end if
	// Fecha Visado (10 dd/mm/yyyy)

	/*if g_colegio = 'COAATTGN' or g_colegio ='COAATNA' or g_colegio ='COAATA' then // CGN-319
		dw_fich.setitem(fila, 'f_visado', string(ds_datos_obras.getitemdatetime(i, 'fases_f_abono'), "dd/mm/yyyy")) 
	else
		dw_fich.setitem(fila, 'f_visado', string(ds_datos_obras.getitemdatetime(i, 'fases_f_visado'), "dd/mm/yyyy"))
	end if*/
	dw_fich.setitem(fila, 'f_entrada', string(ds_datos_obras.getitemdatetime(i, 'fases_f_entrada'), "dd/mm/yyyy"))
	// Fecha de visado de Fin de Obra (10 dd/mm/yyyy)
	sfecha = string(ds_datos_obras.getitemdatetime(i, 'fases_finales_fecha'), "dd/mm/yyyy")
	if sFecha = '01/01/1900' then sFecha = space(10)
	dw_fich.setitem(fila, 'f_visado_fin_obra', sFecha)
	// Primer Visado
	dw_fich.setitem(fila, 'primer_visado', 'N')
	if ds_datos_obras.getitemstring(i, 'fases_tipo_registro') = 'IP' then dw_fich.setitem(fila, 'primer_visado', 'S')
	// Modificaci$$HEX1$$f300$$ENDHEX$$n del Proyecto
	dw_fich.setitem(fila, 'modif_proy', 'N')
	if ds_datos_obras.getitemstring(i, 'fases_tipo_registro') = 'MO' then dw_fich.setitem(fila, 'modif_proy', 'S')
	// Cambio de Promotor
	dw_fich.setitem(fila, 'cambio_prom', 'N')
	if ds_datos_obras.getitemstring(i, 'fases_tipo_registro') = 'CC' then dw_fich.setitem(fila, 'cambio_prom', 'S')
	// Cambio de Colegiado
	dw_fich.setitem(fila, 'cambio_col', 'N')
	if ds_datos_obras.getitemstring(i, 'fases_tipo_registro') = 'RN' or &
		ds_datos_obras.getitemstring(i, 'fases_tipo_registro') = 'RS' then
		dw_fich.setitem(fila, 'cambio_col', 'S')
	end if
	// Legalizacion
	dw_fich.setitem(fila, 'legalizacion', 'N')
	if ds_datos_obras.getitemstring(i, 'fases_tipo_registro') = 'LE' then dw_fich.setitem(fila, 'legalizacion', 'S')
	// Anulaci$$HEX1$$f300$$ENDHEX$$n de encargo
	dw_fich.setitem(fila, 'anul_encargo', 'N')
	if ds_datos_obras.getitemstring(i, 'fases_tipo_registro') = 'AN' then dw_fich.setitem(fila, 'anul_encargo', 'S')
	// N$$HEX2$$ba002000$$ENDHEX$$de Expediente Anterior
	n_cont_ant = f_completar_con_caracteres(ds_datos_obras.getitemstring(i, 'fases_n_contrato_ant'),12,'I',' ')
	dw_fich.setitem(fila, 'num_exp_ant', RightA(n_cont_ant,12))
	// Anulaci$$HEX1$$f300$$ENDHEX$$n de Expediente Anterior
	dw_fich.setitem(fila, 'anul_exp_ant', 'N')
	
	// Los datos relativos al promotor y a la direcci$$HEX1$$f300$$ENDHEX$$n de la obra s$$HEX1$$f300$$ENDHEX$$lo se incluir$$HEX1$$e100$$ENDHEX$$n cuando el promotor sea persona jur$$HEX1$$ed00$$ENDHEX$$dica y no cuando sean
	// particulares, comunidades de bienes o comunidades de propietarios. El resto de datos s$$HEX2$$ed002000$$ENDHEX$$deben enviarse.
	string t_promo
	//Modificado provisionalmente Luis para fichero del CONSEJO
	t_promo = ds_datos_obras.GetItemString(i,'t_promotor')
	if(t_promo = 'J' or t_promo = 'U' or t_promo = 'V')then
		t_promo = 'G'
	end if
	if(t_promo = 'R')then
		t_promo = 'Q'
	end if
	if(t_promo = 'W')then
		t_promo = 'N'
	end if
	//fin modificaci$$HEX1$$f300$$ENDHEX$$n provisional
	if (t_promo = 'A' or t_promo = 'B' or t_promo = 'C' or t_promo = 'D' or t_promo = 'F' &
		or t_promo = 'S' or t_promo = 'P' or t_promo = 'G' or t_promo = 'Q' or t_promo = 'J' or t_promo = 'R' or t_promo = 'U' or t_promo = 'V' or t_promo = 'N' or t_promo = 'W') then	
		// DATOS DEL PROMOTOR
		//	Nombre Promotor
		nom_prom = f_completar_con_caracteres(ds_datos_obras.GetItemString(i,'clientes_apellidos'),150,'D',' ')
		dw_fich.setitem(fila, 'nom_prom', LeftA(nom_prom,150))	
		//	Tel$$HEX1$$e900$$ENDHEX$$fono Promotor
		tel_prom = f_completar_con_caracteres(ds_datos_obras.GetItemString(i,'clientes_telefono'),9,'I',' ')
		dw_fich.setitem(fila, 'tel_prom', RightA(tel_prom,9))
		// CIF Promotor
		if LenA(ds_datos_obras.GetItemString(i,'clientes_nif')) = 9 then
			dw_fich.setitem(fila, 'cif_prom', ds_datos_obras.GetItemString(i,'clientes_nif'))
		end if
		//Cambio Luis ICTL-176
		if(g_colegio = 'COAATTEB')then
		string nif_promo
		long k,m
			if(LenA(trim(ds_datos_obras.GetItemString(i,'clientes_nif'))) > 9)then
				m=1
				k=1
				nif_promo=''
				do while m > 0
					m = Pos(ds_datos_obras.GetItemString(i,'clientes_nif'), "-", k )
					nif_promo = nif_promo + Mid(ds_datos_obras.GetItemString(i,'clientes_nif'),k,m - k)
					if(m<>0)then
						k=m+1
					end if
				loop
				nif_promo = nif_promo + Mid(ds_datos_obras.GetItemString(i,'clientes_nif'),k,15 - k)
				nif_promo = trim(nif_promo)
				dw_fich.setitem(fila, 'cif_prom',nif_promo)
			end if	
		end if
		//fin cambio
		
		// Clase V$$HEX1$$ed00$$ENDHEX$$a Promotor
		dw_fich.setitem(fila, 'via_prom', wf_tipo_via(ds_datos_obras.GetItemString(i,'clientes_tipo_via')))
		// Direcci$$HEX1$$f300$$ENDHEX$$n Promotor
		dir_prom = f_completar_con_caracteres(ds_datos_obras.GetItemString(i,'clientes_nombre_via'),50,'D',' ')
		dw_fich.setitem(fila, 'dir_prom', LeftA(dir_prom,50))
		// N$$HEX1$$fa00$$ENDHEX$$mero Direcci$$HEX1$$f300$$ENDHEX$$n Promotor(4)
		// Piso Direcci$$HEX1$$f300$$ENDHEX$$n Promotor(2)
		// Puerta Direcci$$HEX1$$f300$$ENDHEX$$n Promotor(2)
		// CP Promotor
		cp_prom = ds_datos_obras.GetItemString(i,'clientes_cp')
		SELECT tipo, cp_asociado INTO :tipo, :cp_asoc FROM poblaciones WHERE poblaciones.cod_pob = :cp_prom   ;
		if tipo = 'M' then cp_prom = cp_asoc
		if isnull(cp_prom) Then cp_prom = space(5)
		cp_prom = f_completar_con_caracteres(cp_prom,5,'I',' ')	
		dw_fich.setitem(fila, 'cp_prom', LeftA(cp_prom,5))
		// Municipio Promotor
		pob_prom = f_dame_poblacion(ds_datos_obras.GetItemString(i,'clientes_cod_pob'))
		pob_prom = f_completar_con_caracteres(pob_prom,50,'D',' ')
		dw_fich.setitem(fila, 'pob_prom', LeftA(pob_prom,50))
		// Provincia Promotor
		prov_prom = f_devuelve_desc_provincia(ds_datos_obras.GetItemString(i,'clientes_cod_prov'))
		prov_prom = f_completar_con_caracteres(prov_prom,50,'D',' ')
		dw_fich.setitem(fila, 'prov_prom', LeftA(prov_prom,50))
		// Cliente = Promotor(1)
		sl_promotor = ds_datos_obras.GetItemString(i,'fases_clientes_promotor')
		dw_fich.setitem(fila, 'cliente_prom', sl_promotor)		
		// Clase V$$HEX1$$ed00$$ENDHEX$$a Obra
		dw_fich.setitem(fila, 'via_obra', wf_tipo_via(ds_datos_obras.GetItemString(i,'fases_tipo_via_emplazamiento')))
		// Direcci$$HEX1$$f300$$ENDHEX$$n Obra
		dir_obra = f_completar_con_caracteres(ds_datos_obras.GetItemString(i,'fases_emplazamiento'),50,'D',' ')
		dw_fich.setitem(fila, 'dir_obra', LeftA(dir_obra,50))
		// N$$HEX1$$fa00$$ENDHEX$$mero Direcci$$HEX1$$f300$$ENDHEX$$n Obra
		num_obra = f_completar_con_caracteres(ds_datos_obras.GetItemString(i,'fases_n_calle'),4,'D',' ')
		dw_fich.setitem(fila, 'num_obra', LeftA(num_obra,4))
		// Piso Direcci$$HEX1$$f300$$ENDHEX$$n Obra(2)
		piso_obra = f_completar_con_caracteres(ds_datos_obras.GetItemString(i,'fases_piso'),2,'D',' ')
		dw_fich.setitem(fila, 'piso_obra', LeftA(piso_obra,2))		
		// Puerta Direcci$$HEX1$$f300$$ENDHEX$$n Obra(2)
		puerta_obra = f_completar_con_caracteres(ds_datos_obras.GetItemString(i,'fases_puerta'),2,'D',' ')
		dw_fich.setitem(fila, 'puerta_obra', LeftA(puerta_obra,2))				
	end if

	// CP Obra
	cp_obra = LeftA(ds_datos_obras.GetItemString(i,'fases_poblacion'), 5)
	
	
	SELECT tipo, cp_asociado INTO :tipo, :cp_asoc FROM poblaciones WHERE poblaciones.cod_pob = :cp_obra   ;
	if tipo = 'M' then cp_obra = cp_asoc
	if isnull(cp_obra) Then cp_obra = space(5)
	cp_obra = f_completar_con_caracteres(cp_obra,5,'I',' ')
	dw_fich.setitem(fila, 'cp_obra', LeftA(cp_obra,5))
	// Municipio Obra
	pob_obra = f_completar_con_caracteres(ds_datos_obras.GetItemString(i,'poblaciones_descripcion'),50,'D',' ')
	dw_fich.setitem(fila, 'pob_obra', LeftA(pob_obra,50))

	// Titulaci$$HEX1$$f300$$ENDHEX$$n Autores Proyecto (50)
	// Tipo Intervenci$$HEX1$$f300$$ENDHEX$$n Profesional
	if ds_datos_obras.GetItemString(i,'fases_fase') = '76' then dw_fich.setitem(fila, 'tipo_act', '74' )
	ls_tip = ds_datos_obras.GetItemString(i,'fases_fase')
	if(len(ls_tip) = 1)then
		ls_tip = '0'+ls_tip
	end if
	dw_fich.setitem(fila, 'tipo_act',ls_tip)
	//Cambio Josuna 	SCP-914
	if g_colegio = 'COAATTEB' or g_colegio = 'COAATTGN' or g_colegio ='COAATLL' then
		if(ls_tip = '76')then
			dw_fich.setitem(fila, 'tipo_act', '73' )		
		end if
	end if
	//Cambio Luis CGN-489
	//Cambio CGN-882 y ICLL-215
//	if g_colegio = 'COAATTGN' or g_colegio ='COAATLL' then 
//		if(ls_tip = '12' or ls_tip = '13')then
//			dw_fich.setitem(fila, 'tipo_act', '11' )		
//		end if
//		if(ls_tip = '14')then
//			dw_fich.setitem(fila, 'tipo_act', '12' )		
//		end if
//		if(ls_tip = '15' or ls_tip = '16')then
//			dw_fich.setitem(fila, 'tipo_act', '13' )		
//		end if
//		if(ls_tip = '17')then
//			dw_fich.setitem(fila, 'tipo_act', '14' )		
//		end if
//		if(ls_tip = '76')then
//			dw_fich.setitem(fila, 'tipo_act', '73' )		
//		end if
//	end if 
	//fin cambio
	// TIpo de Obra
	ls_to = ds_datos_obras.GetItemString(i,'fases_tipo_trabajo')
	if(len(ls_to) = 1)then
		ls_to = '0'+ls_to
	end if
	dw_fich.setitem(fila, 'tipo_obra',ls_to)	
	if((ls_tip = '11' or ls_tip = '12' or ls_tip = '13' or ls_tip = '14' or ls_tip = '15' or ls_tip = '16' or ls_tip = '17') and (ls_to = '17' or ls_to = '18'))then
		dw_fich.setitem(fila, 'tipo_obra','11')	
	end if
	if((ls_tip = '11' or ls_tip = '12' or ls_tip = '13' or ls_tip = '14' or ls_tip = '15' or ls_tip = '16' or ls_tip = '17') and (ls_to = '34' or ls_to = '35'))then
		dw_fich.setitem(fila, 'tipo_obra','31')	
	end if
	if((ls_tip = '11' or ls_tip = '12' or ls_tip = '13' or ls_tip = '14' or ls_tip = '15' or ls_tip = '16' or ls_tip = '17') and (f_es_vacio(ls_to)))then
		to_vacio = to_vacio+n_registro +','
		fichero = fichero + 1
	end if
	//Cambio Luis ICTL-176
	if g_colegio = 'COAATTEB' then 
		if(ls_to = '14' or ls_to = '15')then
			dw_fich.setitem(fila, 'tipo_obra','11')				
		end if
	end if 
	//fin cambio
	//Cambio Luis CGC-115
	if(g_colegio = 'COAATGC')then
		if(ls_to = 'C1' or ls_to = 'C7')then
			dw_fich.setitem(fila, 'tipo_obra','71')
		end if
		if(ls_to = 'C2' or ls_to = 'C3' or ls_to = 'C6')then
			dw_fich.setitem(fila, 'tipo_obra','31')
		end if
		if(ls_to = 'C4')then
			dw_fich.setitem(fila, 'tipo_obra','13')
		end if
		if(ls_to = 'C5')then
			dw_fich.setitem(fila, 'tipo_obra','81')
		end if
		if(ls_to = 'C8')then
			dw_fich.setitem(fila, 'tipo_obra','41')
		end if
	end if
	
	if(ls_to = '00')then
			dw_fich.setitem(fila, 'tipo_obra','99')
		end if
		
	//fin cambio
	// Destino Principal de Obra
	sl_destino = ds_datos_obras.GetItemString(i,'fases_trabajo')
	if(len(sl_destino) = 1)then
		sl_destino = '0'+sl_destino
	end if
	//if sl_destino = '00' then sl_destino = space(2)
	//Cambio Luis ICTL-176
//	if(g_colegio = 'COAATTEB')then
//	string ls_to_aux
//		ls_to_aux = ls_to
//		ls_to = dw_fich.getitemstring(fila,'tipo_obra')
//		if((ls_tip = '11' or ls_tip = '12' or ls_tip = '13' or ls_tip = '14' or ls_tip = '15' or ls_tip = '16' or ls_tip = '17') and (ls_to = '11'  or ls_to = '12' or ls_to = '13'))then
//			if(sl_destino = '15')then sl_destino = '11'
//			if(sl_destino = '16')then sl_destino = '14'
//			if(sl_destino = '17')then sl_destino = '12'			
//		end if	
//		ls_to = ls_to_aux
//	end if
	//fin cambio
	
	if(sl_destino = '00')then sl_destino = '91'
	
	//Cambio Luis CGN-489
	//Cambio CGN-882 y ICLL-215
		if(g_colegio = 'COAATTGN' OR g_colegio = 'COAATLL' or g_colegio = 'COAATTEB' )then
			if(sl_destino = '12')then sl_destino = '11'
			if(sl_destino = '13')then sl_destino = '11'	
			if(sl_destino = '14')then sl_destino = '12'
			if(sl_destino = '15')then sl_destino = '13'
			if(sl_destino = '16')then sl_destino = '13'	
			if(sl_destino = '17')then sl_destino = '14'
		end if
	//fin cambio
	
	if((ls_tip = '11' or ls_tip = '12' or ls_tip = '13' or ls_tip = '14' or ls_tip = '15' or ls_tip = '16' or ls_tip = '17') and (ls_to = '11'  or ls_to = '12' or ls_to = '13') and &
	(sl_destino <> '11' and sl_destino <> '12' and sl_destino <> '13' and sl_destino <> '14' and sl_destino <> '21' and sl_destino <> '22' and sl_destino <> '31' and sl_destino <> '32' and sl_destino <> '33' and sl_destino <> '34' and sl_destino <> '35' and sl_destino <> '36' and sl_destino <> '37' and sl_destino <> '38' and sl_destino <> '39' and sl_destino <> '41' and sl_destino <> '42' and sl_destino <> '43' and sl_destino <> '51' and sl_destino <> '52' and sl_destino <> '53' and sl_destino <> '54' and sl_destino <> '55' and sl_destino <> '61' and sl_destino <> '62'))then
			if(f_es_vacio(is_mensaje1))then
				is_mensaje1 = 'Existen contratos cuyo destino de la obra tiene valor incorrecto para la combinaci$$HEX1$$f300$$ENDHEX$$n de tipo de actuaci$$HEX1$$f300$$ENDHEX$$n y tipo de obra.'
			end if
			sl_destino_incorrecto = sl_destino_incorrecto+n_registro+','
			fichero = fichero + 1
	end if
	if((ls_tip = '11' or ls_tip = '12' or ls_tip = '13' or ls_tip = '14' or ls_tip = '15' or ls_tip = '16' or ls_tip = '17') and (ls_to = '11'  or ls_to = '12' or ls_to = '13') and (f_es_vacio(sl_destino)))then
		sl_destino_vacio = sl_destino_vacio+n_registro+','
		fichero = fichero + 1
	end if
	dw_fich.setitem(fila, 'destino', sl_destino)	
	// Clase de Promotor
//	clase_prom = ds_datos_obras.GetItemString(i,'t_promotor')
	clase_prom = t_promo
	if clase_prom < 'A' OR  clase_prom > 'Z' then clase_prom = 'X'
	dw_fich.setitem(fila, 'clase_prom', clase_prom)
	// N$$HEX1$$fa00$$ENDHEX$$mero de Edificios
	num_edif = ds_datos_obras.GetItemNumber(i,'fases_usos_num_edif')
	if isnull(num_edif) then num_edif = 0
	dw_fich.setitem(fila, 'num_edif', RightA(f_completar_con_caracteres(string(num_edif),3,'I',' '),3))
	// N$$HEX1$$fa00$$ENDHEX$$mero de Viviendas
	num_viv = ds_datos_obras.GetItemNumber(i,'fases_usos_num_viv')
	if isnull(num_viv) then num_viv = 0
	dw_fich.setitem(fila, 'num_viv', RightA(f_completar_con_caracteres(string(num_viv),4,'I',' '),4))
	//Cambio Luis CBU-90
	if(g_colegio = 'COAATBU' and ls_to = '12' and num_viv = 0)then
		ld_naves = 1
		num_viv = 1
	end if
	//fin cambio
	if((ls_tip = '11' or ls_tip = '12' or ls_tip = '13' or ls_tip = '14' or ls_tip = '15' or ls_tip = '16' or ls_tip = '17') and (ls_to = '11'  or ls_to = '12' or ls_to = '13') and (sl_destino = '11' or sl_destino = '12' or sl_destino = '13' or sl_destino = '14'))then
		if(num_viv = 0)then
			if(f_es_vacio(is_mensaje2))then
				is_mensaje2 = 'Existen contratos con el n$$HEX1$$fa00$$ENDHEX$$mero de viviendas igual a cero, a pesar de una combinaci$$HEX1$$f300$$ENDHEX$$n de tipo de actuaci$$HEX1$$f300$$ENDHEX$$n, tipo de obra y destino que no lo permite.'
			end if
			num_viv_cero = num_viv_cero + n_registro+','
			fichero = fichero + 1
		end if
	end if
	//Cambio Luis CBU-90
	if(g_colegio = 'COAATBU' and ls_to = '12' and ld_naves = 1)then
		num_viv = 0
		ld_naves = 0
	end if
	//fin cambio
	// Superficie Total
	sup_viv = round(ds_datos_obras.GetItemNumber(i,'fases_usos_sup_viv'),0)
	sup_gar = round(ds_datos_obras.GetItemNumber(i,'fases_usos_sup_garage'),0)
	sup_otros = round(ds_datos_obras.GetItemNumber(i,'fases_usos_sup_otros'),0)
	if isnull(sup_viv) then sup_viv = 0
	if isnull(sup_gar) then sup_gar = 0
	if isnull(sup_otros) then sup_otros = 0
	sup_total = sup_viv + sup_gar + sup_otros
	dw_fich.setitem(fila, 'sup_total', RightA(f_completar_con_caracteres(string(sup_total),6,'I',' '),6))
	// Superficie de Viviendas
	dw_fich.setitem(fila, 'sup_viv', RightA(f_completar_con_caracteres(string(sup_viv),6,'I',' '),6))
	// Superficie de Garaje
	dw_fich.setitem(fila, 'sup_gar', RightA(f_completar_con_caracteres(string(sup_gar),6,'I',' '),6))
	// Superficie Otros
	dw_fich.setitem(fila, 'sup_otros', RightA(f_completar_con_caracteres(string(sup_otros),6,'I',' '),6))
	// Presupuesto Material Obra (En euros sin decimales)
	pem = round(ds_datos_obras.GetItemnumber(i,'fases_usos_pem'),0)
	dw_fich.setitem(fila, 'pem', LeftA(f_completar_con_caracteres(string(pem),9,'D',' '),9))
	// N$$HEX2$$ba002000$$ENDHEX$$de Plantas sobre Rasante
	num_psob = ds_datos_obras.GetItemNumber(i,'fases_usos_plantas_sob')
	if isnull(num_psob) then num_psob = 0
	dw_fich.setitem(fila, 'plantas_sob', RightA(f_completar_con_caracteres(string(num_psob),3,'I',' '),3))
	// Superficie sobre Rasante
	sup_sob = round(ds_datos_obras.GetItemNumber(i,'fases_usos_sup_sob'),0)
	if isnull(sup_sob) then sup_sob = 0
	dw_fich.setitem(fila, 'sup_sob', RightA(f_completar_con_caracteres(string(sup_sob),6,'I',' '),6))
	// N$$HEX2$$ba002000$$ENDHEX$$de Plantas bajo Rasante
	num_pbaj = ds_datos_obras.GetItemNumber(i,'fases_usos_plantas_baj')
	if isnull(num_pbaj) then num_pbaj = 0	
	dw_fich.setitem(fila, 'plantas_bajo', RightA(f_completar_con_caracteres(string(num_pbaj),3,'I',' '),3))
	// Superficie bajo Rasante
	sup_pbaj = round(ds_datos_obras.GetItemNumber(i,'fases_usos_sup_baj'),0)
	if isnull(sup_pbaj) then sup_pbaj = 0
	dw_fich.setitem(fila, 'sup_bajo', RightA(f_completar_con_caracteres(string(sup_pbaj),6,'I',' '),6))
	// Altura en metros del Edificio
	altura = round(ds_datos_obras.GetItemNumber(i,'fases_usos_altura'),0)
	if isnull(altura) then altura = 0	
	dw_fich.setitem(fila, 'altura', RightA(f_completar_con_caracteres(string(altura),3,'I',' '),3))
	// Edificio entre medianeras
	dw_fich.setitem(fila, 'medianeras', 'S') 
	// Edificio entre medianeras un lado
	dw_fich.setitem(fila, 'med_un_lado', 'N')
	// Edificio entre medianeras m$$HEX1$$e100$$ENDHEX$$s de un lado
	dw_fich.setitem(fila, 'med_mas_lado', 'N')
	choose case ds_datos_obras.getitemstring(i, 'fases_usos_colindantes')
		case '01'
			dw_fich.setitem(fila, 'medianeras', 'N')
		case '02'
			dw_fich.setitem(fila, 'med_un_lado', 'S')
		case '03'
			dw_fich.setitem(fila, 'med_mas_lado', 'S')
	end choose
	// Uso edificio venta
	dw_fich.setitem(fila, 'uso_venta', 'N')	
	// Uso edificio alquiler
	dw_fich.setitem(fila, 'uso_alquiler', 'N')	
	// Uso edificio autouso
	dw_fich.setitem(fila, 'uso_autouso', 'N')
	choose case ds_datos_obras.getitemstring(i, 'fases_usos_uso')
		case 'V'
			dw_fich.setitem(fila, 'uso_venta', 'S')	
		case 'A'
			dw_fich.setitem(fila, 'uso_alquiler', 'S')	
		case 'U'
			dw_fich.setitem(fila, 'uso_autouso', 'S')
	end choose
	// Estudio Geot$$HEX1$$e900$$ENDHEX$$cnico
	dw_fich.setitem(fila, 'estudio_geo', ds_datos_obras.getitemstring(i, 'fases_usos_estudio_geo'))
	// Control de Calidad
	dw_fich.setitem(fila, 'control_cal', ds_datos_obras.getitemstring(i, 'fases_usos_cc_externo'))	
	// Nivel Control Calidad Reducido
	dw_fich.setitem(fila, 'nivel_cc_red', 'N')	
	// Nivel Control Calidad Normal
	dw_fich.setitem(fila, 'nivel_cc_norm', 'N')	
	// Nivel Control Calidad Alto
	dw_fich.setitem(fila, 'nivel_cc_alto', 'N')	
	choose case ds_datos_obras.getitemstring(i, 'fases_usos_niv_cont')
		case 'R'
			dw_fich.setitem(fila, 'nivel_cc_red', 'S')	
		case 'N'
			dw_fich.setitem(fila, 'nivel_cc_norm', 'S')	
		case 'A'
			dw_fich.setitem(fila, 'nivel_cc_alto', 'S')
	end choose	
	// C$$HEX1$$ed00$$ENDHEX$$a Seguros Aparejador 1
	cia1='';cia2='';cia3='';cia4='';cia5=''
	wf_cia_seguros_apa(ds_datos_obras.getitemstring(i, 'fases_id_fase'),cia1,cia2,cia3,cia4,cia5)
	dw_fich.setitem(fila, 'cia_seg_apa1', cia1)
	// C$$HEX1$$ed00$$ENDHEX$$a Seguros Aparejador 2
	dw_fich.setitem(fila, 'cia_seg_apa2', cia2)
	// C$$HEX1$$ed00$$ENDHEX$$a Seguros Aparejador 3
	dw_fich.setitem(fila, 'cia_seg_apa3', cia3)
	// C$$HEX1$$ed00$$ENDHEX$$a Seguros Aparejador 4
	dw_fich.setitem(fila, 'cia_seg_apa4', cia4)
	// C$$HEX1$$ed00$$ENDHEX$$a Seguros Aparejador 5
	dw_fich.setitem(fila, 'cia_seg_apa5', cia5)
	// C$$HEX1$$ed00$$ENDHEX$$a Seguros Promotor
	// Cobro a cargo de Coaat
	dw_fich.setitem(fila, 'cobro_col1', 'N')
	dw_fich.setitem(fila, 'cobro_col2', 'N')
	dw_fich.setitem(fila, 'cobro_col3', 'N')
	dw_fich.setitem(fila, 'cobro_col4', 'N')
	dw_fich.setitem(fila, 'cobro_col5', 'N')
	
	ds_col.retrieve(ds_datos_obras.getitemstring(i, 'fases_id_fase'))
	for j = 1 to ds_col.rowcount()
		//En el formato del fichero CNC s$$HEX1$$f300$$ENDHEX$$lo hay sitio para 5 colegiados
		if j>5 then exit
		if ds_col.getitemstring(j, 'tipo_gestion') = 'C' then dw_fich.setitem(fila, 'cobro_col'+ string(j), 'S')
	next 
	// Se miraba seg$$HEX1$$fa00$$ENDHEX$$n lo que pon$$HEX1$$ed00$$ENDHEX$$a en el contrato
	//	if ds_datos_obras.getitemstring(i, 'fases_tipo_gestion') = 'C' then 
	//		dw_fich.setitem(fila, 'cobro_col', 'S')
	//	end if

	// Obra Oficial
	dw_fich.setitem(fila, 'obra_admon', ds_datos_obras.getitemstring(i, 'expedientes_administracion'))		
	
	//	// NIF Arquitecto T$$HEX1$$e900$$ENDHEX$$cnico: desaparece
	//	if len(ds_datos_obras.GetItemString(i,'colegiados_nif')) = 9 then
	//		dw_fich.setitem(fila, 'nif_col', ds_datos_obras.GetItemString(i,'colegiados_nif'))
	//	end if

	// Colegiados asalariados
	dw_fich.setitem(fila, 'asa_col1', 'N')
	dw_fich.setitem(fila, 'asa_col2', 'N')
	dw_fich.setitem(fila, 'asa_col3', 'N')
	dw_fich.setitem(fila, 'asa_col4', 'N')
	dw_fich.setitem(fila, 'asa_col5', 'N')
	for j = 1 to ds_col.rowcount()
		if j>5 then exit
		if f_colegiado_situacion(ds_col.getitemstring(j, 'id_col')) = 'A' then dw_fich.setitem(fila, 'asa_col'+ string(j), 'S')
	next 
	// Act$$HEX1$$fa00$$ENDHEX$$a mediante sociedad profesional
	dw_fich.setitem(fila, 'soci_col1', 'N')
	dw_fich.setitem(fila, 'soci_col2', 'N')
	dw_fich.setitem(fila, 'soci_col3', 'N')
	dw_fich.setitem(fila, 'soci_col4', 'N')
	dw_fich.setitem(fila, 'soci_col5', 'N')	
	
	for j = 1 to ds_col.rowcount()
		if j>5 then exit
		id_colegiado = ds_col.getitemstring(j, 'id_col')
		cuantos = 0
		SELECT count(*)  
		INTO :cuantos  
		FROM sociedades  
		WHERE 	( sociedades.id_col_soc = :id_colegiado )   ;
		
		if cuantos > 0 then 	dw_fich.setitem(fila, 'soci_col'+string(j), 'S')
	next 	
	
	// Colegiados acreditados
	dw_fich.setitem(fila, 'acre_col1', 'N')
	dw_fich.setitem(fila, 'acre_col2', 'N')
	dw_fich.setitem(fila, 'acre_col3', 'N')
	dw_fich.setitem(fila, 'acre_col4', 'N')
	dw_fich.setitem(fila, 'acre_col5', 'N')
	for j = 1 to ds_col.rowcount()
		if j>5 then exit
		if f_colegiado_residente(ds_col.getitemstring(j, 'id_col')) = 'H' then dw_fich.setitem(fila, 'acre_col'+ string(j), 'S')
	next 
	
	// Edades de los colegiados
	dw_fich.setitem(fila, 'edad_col1', space(2))
	dw_fich.setitem(fila, 'edad_col2', space(2))
	dw_fich.setitem(fila, 'edad_col3', space(2))
	dw_fich.setitem(fila, 'edad_col4', space(2))
	dw_fich.setitem(fila, 'edad_col5', space(2))
	for j = 1 to ds_col.rowcount()
		if j>5 then exit
		id_colegiado = ds_col.getitemstring(j, 'id_col')
		
		SELECT colegiados.f_nacimiento  
		INTO :dt_f_nacimiento
		FROM colegiados  
		WHERE colegiados.id_colegiado = :id_colegiado   ;
		
		il_edad_colegiado = f_edad(dt_f_nacimiento, datetime(today(), now()))
		if il_edad_colegiado > 0 and il_edad_colegiado < 100 then dw_fich.setitem(fila, 'edad_col'+ string(j), f_completar_con_caracteres(string(il_edad_colegiado),2, 'I', '0') )
	next 
	
	// Sexo de los colegiados
	dw_fich.setitem(fila, 'sexo_col1', 'V')
	dw_fich.setitem(fila, 'sexo_col2', 'V')
	dw_fich.setitem(fila, 'sexo_col3', 'V')
	dw_fich.setitem(fila, 'sexo_col4', 'V')
	dw_fich.setitem(fila, 'sexo_col5', 'V')
	for j = 1 to ds_col.rowcount()
		if j>5 then exit
		id_colegiado = ds_col.getitemstring(j, 'id_col')
		
		SELECT colegiados.sexo
		INTO :sl_sexo
		FROM colegiados  
		WHERE colegiados.id_colegiado = :id_colegiado   ;
		// conversi$$HEX1$$f300$$ENDHEX$$n de tipos
		choose case sl_sexo
			case 'S'
				sl_sexo = space(1)
			case 'M'
				sl_sexo = 'V'
			case 'F'
				sl_sexo = 'M'
			case else
				sl_sexo = 'V'
		end choose
		dw_fich.setitem(fila, 'sexo_col'+ string(j), sl_sexo)
	next
	if lower(ds_datos_obras.describe("fases_n_consejo_fase.name")) = 'fases_n_consejo_fase' then
		n_consejo = f_completar_con_caracteres(ds_datos_obras.getitemstring(i, 'fases_n_consejo_fase'),12,'D',' ')
		dw_fich.setitem(fila, 'n_consejo', n_consejo)
	end if
	// Codigo de municipio	SCP-722 MOPU
	f_abono=string (date(ds_datos_obras.GetItemdatetime(i,'fases_f_abono')))
	dw_fich.setitem(fila, 'f_abono', f_abono)
	//messagebox("",ds_datos_obras.GetItemString(i,'poblaciones_pob_mopu'))
	pob_mopu=f_completar_con_caracteres(ds_datos_obras.GetItemString(i,'poblaciones_pob_mopu'),3,'D',' ')
	dw_fich.setitem(fila, 'cod_mopu', pob_mopu)
	//dw_fich.setitem(fila, 'cod_mopu', "")
	if ds_datos_obras.dataobject='ds_consejo_proyecto_piloto_finales_obra' then
	choose case ds_datos_obras.GetItemString(i,'fases_finales_total_parcial')
		case "P"
			forma_ejecucion="3"
		case "T"
			forma_ejecucion="1"
		Case "V"
			forma_ejecucion="2"
		
	end choose		
	dw_fich.setitem(fila,'total_parcial',forma_ejecucion)
	finales_presupuesto = round(ds_datos_obras.GetItemnumber(i,'fases_finales_presupuesto'),0)
	dw_fich.setitem(fila, 'finales_presupuesto', RightA(f_completar_con_caracteres(string(finales_presupuesto),9,'I','0'),9))
end if
next

//Cambio Luis Fichero que muestra los contratos con errores en el consejo
	if(fichero > 0)then
		nombrefichero = 'N$$HEX2$$ba002000$$ENDHEX$$registro de contratos con error'
		if not(i_abierto > 0)then
			MessageBox(g_titulo, 'Existen errores en alg$$HEX1$$fa00$$ENDHEX$$n contrato. A continuaci$$HEX1$$f300$$ENDHEX$$n se describen. Se va a generar un fichero con los N$$HEX2$$ba002000$$ENDHEX$$de registro de los contratos con errores. Estos deben de ser modificados, de lo contrario, provocar$$HEX1$$e100$$ENDHEX$$n errores en el fichero del Consejo')
			if GetFileSaveName('Seleccione nombre de fichero',nombrefichero,nombrefichero,'.txt','Ficheros de datos (*.txt),*.txt')<> 1 Then return
			i_abierto = FileOpen(NombreFichero,LineMode!,Write!,LockWrite!,Replace!)
			if i_abierto = -1 then 
				Messagebox(g_titulo,'Ha habido un error accediendo al fichero.',StopSign!)
				return
			end if
		end if
		if(ls_inicio_final = 'I')then
			FileWrite(i_abierto,'Errores en los contratos de Inicio de Obra')
			FileWrite(i_abierto,'')
		else
			FileWrite(i_abierto,'Errores en los contratos de Finales de Obra')
			FileWrite(i_abierto,'')
		end if
		FileWrite(i_abierto,to_vacio)
		FileWrite(i_abierto,sl_destino_vacio)
		FileWrite(i_abierto,sl_destino_incorrecto)
		FileWrite(i_abierto,num_viv_cero)
		FileWrite(i_abierto,'')
	end if
	if(ls_inicio_final = 'F')then
		FileClose(i_abierto)
		if(is_mensaje1 <> '' or is_mensaje2 <> '')then
			mensaje = is_mensaje1+cr+is_mensaje2
			MessageBox(g_titulo,mensaje)
		end if
		i_abierto = 0
		is_mensaje1 = ''
		is_mensaje2 = ''
	end if
//fin cambio Luis

setpointer(arrow!)
//st_proceso.text = ''
destroy ds_col

end subroutine

on w_consejo_proyecto_piloto.create
int iCurrent
call super::create
this.st_fichero=create st_fichero
this.hpb_fichero=create hpb_fichero
this.st_proceso=create st_proceso
this.dw_fich=create dw_fich
this.cb_recuperar=create cb_recuperar
this.st_1=create st_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_consulta=create dw_consulta
this.cb_guardar_texto=create cb_guardar_texto
this.dw_listado=create dw_listado
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_1=create cb_1
this.cb_promo=create cb_promo
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_fichero
this.Control[iCurrent+2]=this.hpb_fichero
this.Control[iCurrent+3]=this.st_proceso
this.Control[iCurrent+4]=this.dw_fich
this.Control[iCurrent+5]=this.cb_recuperar
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.cb_3
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.dw_consulta
this.Control[iCurrent+10]=this.cb_guardar_texto
this.Control[iCurrent+11]=this.dw_listado
this.Control[iCurrent+12]=this.dw_1
this.Control[iCurrent+13]=this.dw_2
this.Control[iCurrent+14]=this.dw_3
this.Control[iCurrent+15]=this.cb_1
this.Control[iCurrent+16]=this.cb_promo
this.Control[iCurrent+17]=this.dw_4
end on

on w_consejo_proyecto_piloto.destroy
call super::destroy
destroy(this.st_fichero)
destroy(this.hpb_fichero)
destroy(this.st_proceso)
destroy(this.dw_fich)
destroy(this.cb_recuperar)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_consulta)
destroy(this.cb_guardar_texto)
destroy(this.dw_listado)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.cb_promo)
destroy(this.dw_4)
end on

event open;call super::open;this.of_setresize(true)
f_centrar_ventana(this)

inv_resize.of_Register (dw_listado, "ScaleToRight&Bottom")
inv_resize.of_Register (st_proceso, "FixedtoBottom")
inv_resize.of_Register (st_fichero, "FixedToRight&Bottom")

dw_consulta.InsertRow(0)
dw_consulta.SetFocus()

if(g_colegio = 'COAATTGN' or g_colegio = 'COAATTEB' or g_colegio = 'COAATLL')then cb_1.visible = true
if(g_colegio = 'COAATMCA')then cb_promo.visible = false

long mes,anyo
datetime f_desde
mes = Month(today())
anyo = Year(today())
f_desde = datetime(date("01/"+string(mes)+"/"+string(anyo)))

string m
if LenA(string(mes)) = 1 then 
	m = '0' + string(mes)
else
	m = string(mes)
end if

dw_consulta.setitem(1, 'mes', m)
dw_consulta.setitem(1, 'f_desde', f_desde)
dw_consulta.setitem(1, 'f_hasta', f_ultimo_dia_mes(f_desde))
dw_consulta.setitem(1,'cod_colegio_dest', g_cod_colegio)


end event

event pfc_postopen();call super::pfc_postopen;//Recuperamos la consulta de Inicio en caso de que exista
This.Event csd_recuperar_consulta('INICIO')
end event

event resize;call super::resize;this.post event csd_resituar_progressbar()
end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_consejo_proyecto_piloto
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_consejo_proyecto_piloto
end type

type st_fichero from statictext within w_consejo_proyecto_piloto
integer x = 1563
integer y = 1500
integer width = 763
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Progreso de generaci$$HEX1$$f300$$ENDHEX$$n del fichero"
boolean focusrectangle = false
end type

type hpb_fichero from hprogressbar within w_consejo_proyecto_piloto
integer x = 2345
integer y = 1504
integer width = 1001
integer height = 64
unsignedinteger maxposition = 100
integer setstep = 10
end type

type st_proceso from statictext within w_consejo_proyecto_piloto
integer x = 37
integer y = 1364
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

type dw_fich from u_dw within w_consejo_proyecto_piloto
boolean visible = false
integer x = 2601
integer y = 1044
integer width = 343
integer height = 156
integer taborder = 0
string dataobject = "d_consejo_fichero"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type cb_recuperar from commandbutton within w_consejo_proyecto_piloto
integer x = 1787
integer y = 128
integer width = 375
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Consultar"
end type

event clicked;string sql
datastore ds_datos_obras
datetime f_desde, f_hasta

st_proceso.text = ''

// Recuperamos los datos en el datastore con las fechas introducidas
dw_consulta.accepttext()

f_desde = dw_consulta.getitemdatetime(1, 'f_desde')
f_hasta = datetime(date(dw_consulta.getitemdatetime(1, 'f_hasta')), time('23:59:59'))

if isnull(f_desde) then
	messagebox(g_titulo, 'Introduzca la fecha inicial')
	return
end if

if isnull(f_hasta) then
	messagebox(g_titulo, 'Introduzca la fecha final')	
	return
end if

dw_fich.reset()
dw_listado.reset()

ds_datos_obras = create datastore
ds_datos_obras.dataobject = 'ds_consejo_proyecto_piloto'
ds_datos_obras.settransobject(SQLCA)

sql = ds_datos_obras.describe("Datawindow.Table.Select")

// Se puede consultar por fecha abono o por fecha de visado
if dw_consulta.getitemstring(1, 'fecha') = 'V' then
	f_sql('fases.f_visado','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
	f_sql('fases.f_visado','<=','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')
	//
	dw_listado.object.fechas_visado_t.visible=true
	dw_listado.object.fechas_abono_t.visible=false
else
	f_sql('fases.f_abono','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
	f_sql('fases.f_abono','<=','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')
	//
	dw_listado.object.fechas_visado_t.visible=false
	dw_listado.object.fechas_abono_t.visible=true
end if
//Copiamos las fechas a la cabecera del dw
dw_listado.object.f_desde_t.text=string(f_desde,'dd/mm/yyyy')
dw_listado.object.f_hasta_t.text=string(f_hasta,'dd/mm/yyyy')
//SCP-1367 Agregado filtrado por colegio destino
f_sql('fases.cod_colegio_dest','=','cod_colegio_dest', dw_consulta,sql,g_tipo_base_datos,'')
ds_datos_obras.modify("datawindow.table.select= ~"" + sql+ "~"")

st_proceso.text='Recuperando inicios de obra...'

// Llamamos a la funci$$HEX1$$f300$$ENDHEX$$n que pasa los datos del datastore al dw
wf_rellenar_dw(ds_datos_obras)

destroy ds_datos_obras

ds_datos_obras = create datastore
ds_datos_obras.dataobject = 'ds_consejo_proyecto_piloto_finales_obra'
ds_datos_obras.settransobject(SQLCA)

sql = ds_datos_obras.describe("Datawindow.Table.Select")

// Los finales de obre solo tienen una fecha
f_sql('fases_finales.f_intro','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
f_sql('fases_finales.f_intro','<=','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')

ds_datos_obras.modify("datawindow.table.select= ~"" + sql+ "~"")

st_proceso.text='Recuperando finales de obra...'

// Llamamos a la funci$$HEX1$$f300$$ENDHEX$$n que pasa los datos del datastore al dw
wf_rellenar_dw(ds_datos_obras)

//S$$HEX1$$f300$$ENDHEX$$lo llamamos a pfc_printpreview() una vez
if ib_printpreviewactivado=false then
	ib_printpreviewactivado=true
	dw_listado.event pfc_printpreview()
end if


destroy ds_datos_obras

dw_fich.rowscopy(1, dw_fich.rowcount(), Primary!, dw_listado, 1, Primary!)

st_proceso.text=''
end event

type st_1 from statictext within w_consejo_proyecto_piloto
integer x = 37
integer y = 32
integer width = 1687
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean italic = true
long textcolor = 33554432
long backcolor = 79741120
string text = "Seleccione el periodo deseado de b$$HEX1$$fa00$$ENDHEX$$squeda y pulse Consultar..."
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_consejo_proyecto_piloto
integer x = 2592
integer y = 128
integer width = 375
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
end type

event clicked;//dw_1.print()

dw_listado.print()

end event

type cb_2 from commandbutton within w_consejo_proyecto_piloto
integer x = 2994
integer y = 128
integer width = 375
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;close(parent)
end event

type dw_consulta from u_dw within w_consejo_proyecto_piloto
integer x = 37
integer y = 96
integer width = 2011
integer height = 512
integer taborder = 10
string dataobject = "d_consejo_consulta"
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

event itemchanged;call super::itemchanged;datetime f_desde

CHOOSE CASE dwo.name
	CASE 'mes'
		f_desde = datetime(date('01/'+data+'/'+string(year(today()))), time('00:00:00'))
		this.setitem(1, 'f_desde', f_desde)
		this.setitem(1, 'f_hasta', f_ultimo_dia_mes(f_desde))
END CHOOSE	

end event

type cb_guardar_texto from commandbutton within w_consejo_proyecto_piloto
integer x = 2190
integer y = 128
integer width = 375
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Fichero"
end type

event clicked;string p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25
string p26,p27,p28,p29,p30,p31,p32,p33,p34,p35,p36,p37,p38,p39,p40,p41,p42,p43,p44,p45,p46,p47,p48
string p49,p50,p51,p52,p53,p54,p55,p56,p57,p58,p59,p60,p61,p62,p63,p64
string p65,p66,p67,p68,p69,p70,p71,p72,p73,p74,p75,p76,p77,p78,p79,p80,p81,p82,p83,p84,p85
string p86,p87,p88,p89,p90,p91,p92,p93,p94,p95,p96,p97,p98,p99,p100,p101,p102,p103
int i
string linea, nombrefichero, ruta
int Fichero
int value

NombreFichero = "CONSEJO.TXT"

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02

if GetFileSaveName('Seleccione nombre de fichero',nombrefichero,nombrefichero,'.txt','Ficheros de datos (*.txt),*.txt')<> 1 Then return

fichero = FileOpen(NombreFichero,LineMode!,Write!,LockWrite!,Replace!)

if fichero = -1 then 
	// MODIFICADO RICARDO 04-03-02
	// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
	cambia_directorio.of_changedirectory(directorio)
	destroy cambia_directorio
	// FIN MODIFICADO RICARDO 04-03-02
	
	Messagebox(g_titulo,'Ha habido un error accediendo al fichero.',StopSign!)
	return
end if

//Inicializamos la barra de progreso

hpb_fichero.maxposition=dw_fich.rowcount()
hpb_fichero.setstep=1
hpb_fichero.position=0

for i = 1 to dw_fich.rowcount()
	
	hpb_fichero.stepit()
	
	p1 = dw_fich.getitemstring(i,1)
	if f_es_vacio(p1) then p1 = space(12)
	p2 = dw_fich.getitemstring(i,2)
	if f_es_vacio(p2) then p2 = space(10)
	p3 = dw_fich.getitemstring(i,3)
	if f_es_vacio(p3) then p3 = space(10)
	p4 = dw_fich.getitemstring(i,4)
	if f_es_vacio(p4) then p4 = space(1)
	p5 = dw_fich.getitemstring(i,5)
	if f_es_vacio(p5) then p5 = space(1)
	p6 = dw_fich.getitemstring(i,6)
	if f_es_vacio(p6) then p6 = space(1)	
	p7 = dw_fich.getitemstring(i,7)
	if f_es_vacio(p7) then p7 = space(1)
	p8 = dw_fich.getitemstring(i,8)
	if f_es_vacio(p8) then p8 = space(1)	
	p9 = dw_fich.getitemstring(i,9)
	if f_es_vacio(p9) then p9 = space(1)	
	p10 = dw_fich.getitemstring(i,10)
	if f_es_vacio(p10) then p10 = space(12)	
	p11 = dw_fich.getitemstring(i,11)
	if f_es_vacio(p11) then p11 = space(1)	
	p12 = dw_fich.getitemstring(i,12)
	if f_es_vacio(p12) then p12 = space(150)	
	p13 = dw_fich.getitemstring(i,13)
	if f_es_vacio(p13) then p13 = space(9)	
	p14 = dw_fich.getitemstring(i,14)
	if f_es_vacio(p14) then p14 = space(9)	
	p15 = dw_fich.getitemstring(i,15)
	if f_es_vacio(p15) then p15 = space(2)
	p16 = dw_fich.getitemstring(i,16)
	if f_es_vacio(p16) then p16 = space(50)
	p17 = dw_fich.getitemstring(i,17)
	if f_es_vacio(p17) then p17 = space(4)
	p18 = dw_fich.getitemstring(i,18)
	if f_es_vacio(p18) then p18 = space(2)	
	p19 = dw_fich.getitemstring(i,19)
	if f_es_vacio(p19) then p19 = space(2)	
	p20 = dw_fich.getitemstring(i,20)
	if f_es_vacio(p20) then p20 = space(5)	
	p21 = dw_fich.getitemstring(i,21)
	if f_es_vacio(p21) then p21 = space(50)	
	p22 = dw_fich.getitemstring(i,22)
	if f_es_vacio(p22) then p22 = space(50)
	p23 = dw_fich.getitemstring(i,23)
	if f_es_vacio(p23) then p23 = space(1)
	p24 = dw_fich.getitemstring(i,24)
	if f_es_vacio(p24) then p24 = space(2)
	p25 = dw_fich.getitemstring(i,25)
	if f_es_vacio(p25) then p25 = space(50)
	p26 = dw_fich.getitemstring(i,26)
	if f_es_vacio(p26) then p26 = space(4)
	p27 = dw_fich.getitemstring(i,27)
	if f_es_vacio(p27) then p27 = space(2)
	p28 = dw_fich.getitemstring(i,28)
	if f_es_vacio(p28) then p28 = space(2)
	p29 = dw_fich.getitemstring(i,29)
	if f_es_vacio(p29) then p29 = space(5)
	p30 = dw_fich.getitemstring(i,30)
	if f_es_vacio(p30) then p30 = space(50)
	p31 = dw_fich.getitemstring(i,31)
	if f_es_vacio(p31) then p31 = space(50)
	p32 = dw_fich.getitemstring(i,32)
	if f_es_vacio(p32) then p32 = space(2)
	p33 = dw_fich.getitemstring(i,33)
	if f_es_vacio(p33) then p33 = space(2)
	p34 = dw_fich.getitemstring(i,34)
	if f_es_vacio(p34) then p34 = space(2)	
	p35 = dw_fich.getitemstring(i,35)
	if f_es_vacio(p35) then p35 = space(1)	
	p36 = dw_fich.getitemstring(i,36)
	if f_es_vacio(p36) then p36 = space(3)	
	p37 = dw_fich.getitemstring(i,37)
	if f_es_vacio(p37) then p37 = space(4)	
	p38 = dw_fich.getitemstring(i,38)
	if f_es_vacio(p38) then p38 = space(6)	
	p39 = dw_fich.getitemstring(i,39)
	if f_es_vacio(p39) then p39 = space(6)	
	p40 = dw_fich.getitemstring(i,40)
	if f_es_vacio(p40) then p40 = space(6)	
	p41 = dw_fich.getitemstring(i,41)
	if f_es_vacio(p41) then p41 = space(6)	
	p42 = dw_fich.getitemstring(i,42)
	if f_es_vacio(p42) then p42 = space(9)
	p43 = dw_fich.getitemstring(i,43)
	if f_es_vacio(p43) then p43 = space(3)
	p44 = dw_fich.getitemstring(i,44)
	if f_es_vacio(p44) then p44 = space(6)
	p45 = dw_fich.getitemstring(i,45)
	if f_es_vacio(p45) then p45 = space(3)
	p46 = dw_fich.getitemstring(i,46)
	if f_es_vacio(p46) then p46 = space(6)
	p47 = dw_fich.getitemstring(i,47)
	if f_es_vacio(p47) then p47 = space(3)	
	p48 = dw_fich.getitemstring(i,48)
	if f_es_vacio(p48) then p48 = space(1)	
	p49 = dw_fich.getitemstring(i,49)
	if f_es_vacio(p49) then p49 = space(1)	
	p50 = dw_fich.getitemstring(i,50)
	if f_es_vacio(p50) then p50 = space(1)	
	p51 = dw_fich.getitemstring(i,51)
	if f_es_vacio(p51) then p51 = space(1)	
	p52 = dw_fich.getitemstring(i,52)
	if f_es_vacio(p52) then p52 = space(1)	
	p53 = dw_fich.getitemstring(i,53)
	if f_es_vacio(p53) then p53 = space(1)	
	p54 = dw_fich.getitemstring(i,54)
	if f_es_vacio(p54) then p54 = space(1)	
	p55 = dw_fich.getitemstring(i,55)
	if f_es_vacio(p55) then p55 = space(1)
	p56 = dw_fich.getitemstring(i,56)
	if f_es_vacio(p56) then p56 = space(1)
	p57 = dw_fich.getitemstring(i,57)
	if f_es_vacio(p57) then p57 = space(1)
	p58 = dw_fich.getitemstring(i,58)
	if f_es_vacio(p58) then p58 = space(1)
	p59 = dw_fich.getitemstring(i,59)
	if f_es_vacio(p59) then p59 = space(50)
	p60 = dw_fich.getitemstring(i,60)
	if f_es_vacio(p60) then p60 = space(50)	
	p61 = dw_fich.getitemstring(i,61)
	if f_es_vacio(p61) then p61 = space(50)	
	p62 = dw_fich.getitemstring(i,62)
	if f_es_vacio(p62) then p62 = space(50)	
	p63 = dw_fich.getitemstring(i,63)
	if f_es_vacio(p63) then p63 = space(50)	
	p64 = dw_fich.getitemstring(i,64)
	if f_es_vacio(p64) then p64 = space(50)	
	p65 = dw_fich.getitemstring(i,65)
	if f_es_vacio(p65) then p65 = space(1)	
	p66 = dw_fich.getitemstring(i,66)
	if f_es_vacio(p66) then p66 = space(1)	
	p67 = dw_fich.getitemstring(i,67)
	if f_es_vacio(p67) then p67 = space(1)	
	p68 = dw_fich.getitemstring(i,68)
	if f_es_vacio(p68) then p68 = space(1)	
	p69 = dw_fich.getitemstring(i,69)
	if f_es_vacio(p69) then p69 = space(1)	
	p70 = dw_fich.getitemstring(i,70)
	if f_es_vacio(p70) then p70 = space(1)	
	p71 = dw_fich.getitemstring(i,71)
	if f_es_vacio(p71) then p71 = space(1)	
	p72 = dw_fich.getitemstring(i,72)
	if f_es_vacio(p72) then p72 = space(1)	
	p73 = dw_fich.getitemstring(i,73)
	if f_es_vacio(p73) then p73 = space(1)	
	p74 = dw_fich.getitemstring(i,74)
	if f_es_vacio(p74) then p74 = space(1)	
	p75 = dw_fich.getitemstring(i,75)
	if f_es_vacio(p75) then p75 = space(1)	
	p76 = dw_fich.getitemstring(i,76)
	if f_es_vacio(p76) then p76 = space(1)	
	p77 = dw_fich.getitemstring(i,77)
	if f_es_vacio(p77) then p77 = space(1)	
	p78 = dw_fich.getitemstring(i,78)
	if f_es_vacio(p78) then p78 = space(1)	
	p79 = dw_fich.getitemstring(i,79)
	if f_es_vacio(p79) then p79 = space(1)	
	p80 = dw_fich.getitemstring(i,80)
	if f_es_vacio(p80) then p80 = space(1)	
	p81 = dw_fich.getitemstring(i,81)
	if f_es_vacio(p81) then p81 = space(1)	
	p82 = dw_fich.getitemstring(i,82)
	if f_es_vacio(p82) then p82 = space(1)		
	p83 = dw_fich.getitemstring(i,83)
	if f_es_vacio(p83) then p83 = space(1)	
	p84 = dw_fich.getitemstring(i,84)
	if f_es_vacio(p84) then p84 = space(1)	
	p85 = dw_fich.getitemstring(i,85)
	if f_es_vacio(p85) then p85 = space(1)		
	
	p86 = dw_fich.getitemstring(i,86)
	if f_es_vacio(p86) then p86 = space(2)	
	p87 = dw_fich.getitemstring(i,87)
	if f_es_vacio(p87) then p87 = space(2)	
	p88 = dw_fich.getitemstring(i,88)
	if f_es_vacio(p88) then p88 = space(2)	
	p89 = dw_fich.getitemstring(i,89)
	if f_es_vacio(p89) then p89 = space(2)	
	p90 = dw_fich.getitemstring(i,90)
	if f_es_vacio(p90) then p90 = space(2)	
	p91 = dw_fich.getitemstring(i,91)
	if f_es_vacio(p91) then p91 = space(1)	
	p92 = dw_fich.getitemstring(i,92)
	if f_es_vacio(p92) then p92 = space(1)	
	p93 = dw_fich.getitemstring(i,93)
	if f_es_vacio(p93) then p93 = space(1)	
	p94 = dw_fich.getitemstring(i,94)
	if f_es_vacio(p94) then p94 = space(1)	
	p95 = dw_fich.getitemstring(i,95)
	if f_es_vacio(p95) then p95 = space(1)		
	p98 = dw_fich.getitemstring(i,98)
	if f_es_vacio(p98) then p98 = space(12)
//Nuevos campos tras omnibus
	p100=dw_fich.getitemstring(i,99)
	if f_es_vacio(p100) then p100 = space(3)	
	p101=dw_fich.getitemstring(i,100)
	if f_es_vacio(p101) then p101 = space(10)	
	p102=dw_fich.getitemstring(i,101)
	if f_es_vacio(p102) then p102 = space(1)	
	p103=dw_fich.getitemstring(i,102)	
	if f_es_vacio(p103) then p103 = space(9)	
	
	
	
	linea = p1+p2+p3+p4+p5+p6+p7+p8+p9+p10+p11+p12+p13+p14+p15+p16+p17+p18+p19+p20+p21+p22+p23+p24+p25
//	messagebox('',string(i) + ' ' + string(len(linea)))
	linea += p26+p27+p28+p29+p30+p31+p32+p33+p34+p35+p36+p37+p38+p39+p40+p41+p42+p43+p44+p45+p46+p47+p48
//	messagebox('',string(i) + ' ' + string(len(linea)))
	linea += p49+p50+p51+p52+p53+p54+p55+p56+p57+p58+p59+p60+p61+p62+p63+p64
	
	linea += p65+p66+p67+p68+p69+p70+p71+p72+p73+p74+p75+p76+p77+p78+p79+p80+p81+p82+p83+p84+p85
	linea +=  p86+p87+p88+p89+p90+p91+p92+p93+p94+p95+p96+p97+p98+p99+p100+p101+p102+p103
//	messagebox('',string(i) + ' ' + string(len(linea)))

	//Cambio Luis ICN-340
	if(len(linea) < 1000)then
		f_completar_con_caracteres(linea,1000,'D',' ')
	end if
	//fin cambio

	FileWrite(Fichero, linea)
//	if len(linea) <> 873 then messagebox('',string(i) + ' ' + string(len(linea)))
//messagebox('kk', string(len(linea)))
next

hpb_fichero.position=0
//messagebox('kk', string(len(linea)))
FileClose(Fichero)
// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02

end event

type dw_listado from u_dw within w_consejo_proyecto_piloto
integer x = 37
integer y = 640
integer width = 3333
integer height = 828
integer taborder = 0
string dataobject = "d_consejo_listado_proyecto_piloto"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_setprintpreview(true)
end event

type dw_1 from datawindow within w_consejo_proyecto_piloto
boolean visible = false
integer x = 2405
integer y = 1060
integer width = 155
integer height = 128
integer taborder = 40
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_consejo_proyecto_piloto
boolean visible = false
integer x = 3017
integer y = 1052
integer width = 178
integer height = 148
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_consejo_renuncias"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_consejo_proyecto_piloto
boolean visible = false
integer x = 2405
integer y = 848
integer width = 160
integer height = 148
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "ds_consejo_proyecto_piloto_finales_obra_promo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_consejo_proyecto_piloto
integer x = 1787
integer y = 128
integer width = 375
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Consultar"
end type

event clicked;string sql, sql_aux
datastore ds_datos_obras
datetime f_desde, f_hasta

st_proceso.text = ''

// Recuperamos los datos en el datastore con las fechas introducidas
dw_consulta.accepttext()

f_desde = dw_consulta.getitemdatetime(1, 'f_desde')
f_hasta = datetime(date(dw_consulta.getitemdatetime(1, 'f_hasta')), time('23:59:59'))

if isnull(f_desde) then
	messagebox(g_titulo, 'Introduzca la fecha inicial')
	return
end if

if isnull(f_hasta) then
	messagebox(g_titulo, 'Introduzca la fecha final')	
	return
end if

dw_fich.reset()
dw_listado.reset()

ds_datos_obras = create datastore
ds_datos_obras.dataobject = 'ds_consejo_proyecto_piloto'
ds_datos_obras.settransobject(SQLCA)

sql = ds_datos_obras.describe("Datawindow.Table.Select")

// Se puede consultar por fecha abono,por fecha de visado o fecha de registro
choose case dw_consulta.getitemstring(1, 'fecha') 
	case 'V' 
	f_sql('fases.f_visado','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
	f_sql('fases.f_visado','<=','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')
	//
	dw_listado.object.fechas_visado_t.visible=true
	dw_listado.object.fechas_abono_t.visible=false
	dw_listado.object.f_registro_t.visible=false
	case 'A'
	f_sql('fases.f_abono','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
	f_sql('fases.f_abono','<=','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')
	//
	dw_listado.object.fechas_visado_t.visible=false
	dw_listado.object.fechas_abono_t.visible=true
	dw_listado.object.f_registro_t.visible=false
	case 'R'
	f_sql('fases.f_entrada','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
	f_sql('fases.f_entrada','<=','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')
	dw_listado.object.fechas_visado_t.visible=false
	dw_listado.object.fechas_abono_t.visible=false
	dw_listado.object.f_registro_t.visible=true
	
end choose
//Copiamos las fechas a la cabecera del dw
dw_listado.object.f_desde_t.text=string(f_desde,'dd/mm/yyyy')
dw_listado.object.f_hasta_t.text=string(f_hasta,'dd/mm/yyyy')

if(g_colegio = 'COAATTFE')then
	sql_aux = "AND not ((fases.tipo_registro = 'MO' and fases.fase = 'CF') and (fases.f_abono is NULL or fases.f_abono = '') and (fases.estado in ('04', '05')))"
	sql = sql + sql_aux
end if
//SCP-1367 Agregado filtrado por colegio destino
f_sql('fases.cod_colegio_dest','=','cod_colegio_dest', dw_consulta,sql,g_tipo_base_datos,'')
ds_datos_obras.modify("datawindow.table.select= ~"" + sql+ "~"")

st_proceso.text='Recuperando inicios de obra...'

// Llamamos a la funci$$HEX1$$f300$$ENDHEX$$n que pasa los datos del datastore al dw
wf_rellenar_dw(ds_datos_obras)

destroy ds_datos_obras

ds_datos_obras = create datastore
ds_datos_obras.dataobject = 'ds_consejo_proyecto_piloto_finales_obra'
ds_datos_obras.settransobject(SQLCA)

sql = ds_datos_obras.describe("Datawindow.Table.Select")

// Los finales de obre solo tienen una fecha
f_sql('fases_finales.f_intro','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
f_sql('fases_finales.f_intro','<=','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')

if(g_colegio = 'COAATTFE')then
	sql_aux = "AND not ((fases.tipo_registro = 'MO' and fases.fase = 'CF') and (fases.f_abono is NULL or fases.f_abono = '') and (fases.estado in ('04', '05')))"
	sql = sql + sql_aux
end if

//SCP-1367 Agregado filtrado por colegio destino
f_sql('fases.cod_colegio_dest','=','cod_colegio_dest', dw_consulta,sql,g_tipo_base_datos,'')

ds_datos_obras.modify("datawindow.table.select= ~"" + sql+ "~"")

st_proceso.text='Recuperando finales de obra...'

// Llamamos a la funci$$HEX1$$f300$$ENDHEX$$n que pasa los datos del datastore al dw
wf_rellenar_dw(ds_datos_obras)

//S$$HEX1$$f300$$ENDHEX$$lo llamamos a pfc_printpreview() una vez
if ib_printpreviewactivado=false then
	ib_printpreviewactivado=true
	dw_listado.event pfc_printpreview()
end if


destroy ds_datos_obras

dw_fich.rowscopy(1, dw_fich.rowcount(), Primary!, dw_listado, 1, Primary!)

st_proceso.text=''
end event

type cb_promo from commandbutton within w_consejo_proyecto_piloto
integer x = 1787
integer y = 280
integer width = 375
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Promo"
end type

event clicked;
int file, j, pem, sup_otros, sup_garaje
string dwsyntax_str, sql_syntax, ruta, fecha, ERRORS, ruta_1, ruta_2, ls_expedi1, ls_expedi2
datetime f_desde, f_hasta
string ls_expedi,ls_pob,ls_num_viv,ls_sup_viv,ls_sup_otros,ls_pem,ls_f_abono,ls_emplaz,ls_poblacion,ls_promotor, ls_f_final,ls_porcen_col,ls_porcen_ren,ls_fecha,ls_f_abono_fin_obra
string ls_t_act,ls_t_obra,ls_destino,ls_sup_total,ls_plantas_sob,ls_plantas_bajo,ls_altura,ls_uso_alquiler,ls_uso_venta,ls_uso_autouso, ls_honorarios,ls_sup_gar, ls_sup_sob,ls_sup_bajo,ls_geo, ll_porcen

n_cst_filesrvwin32 g_manejador_de_ficheros
g_manejador_de_ficheros = create n_cst_filesrvwin32 
//Este proceso genera los archivos promo para el consejo de catalu$$HEX1$$f100$$ENDHEX$$a
//los archivos se generan en la ruta C:\ficheros\promo\ y necesita una la carpeta en dicha ruta
//consta de 3 archivos 
//visados_nuevos referenciado tras la ley omnibus por el numero de registro sin guion y completado con "0"s
//Fichero Renuncias referenciado en todo momento por el campo visado anterior y completado con "0"s
//finales_obra referenciado en todo momento por el campo visado anterior y completado con "0"s

	
boolean existe
ruta = 'C:\ficheros\promo\' 
ruta_1 = 'C:\ficheros\promo\'
ruta_2 = 'C:\ficheros\promo\' 
existe = g_manejador_de_ficheros.of_directoryexists(ruta)
if existe = false then g_manejador_de_ficheros.of_createdirectory(ruta)

//Fichero Visados nuevos
fecha = 'visados_nuevos_'+string(day(today()))+'_'+	string(month(today()))+'_'+Mid(string(year(today())),3,2)				
ruta = ruta +fecha
ruta = RightTrim(ruta)
ruta = ruta+".txt"
//parent.cb_recuperar.triggerEvent(Clicked!)
//dw_fich.saveas(ruta,Text!,FALSE)
//dw_1.saveas(ruta,Text!,FALSE)


integer ll_fichero, i
string fila, numero, nombre, apellidos, email, direccion_activa, telefono, cod_postal, poblacion, activa, cobertura, malus
parent.cb_recuperar.triggerevent( Clicked!)

string cod_colegio

f_desde = dw_consulta.getitemdatetime(1,'f_desde')
f_hasta = dw_consulta.getitemdatetime(1,'f_hasta')
cod_colegio = dw_consulta.getitemstring(1,'cod_colegio_dest')



dw_4.settransobject(sqlca)
dw_4.retrieve(f_desde,f_hasta,cod_colegio)



file = FileOpen("C:\ficheros\promo\visat_general.txt", &
        LineMode!, Write!, LockWrite!, Replace!)
for j=1 to dw_4.rowcount( ) 
	ls_expedi = dw_4.GetItemString(j,27)
	
	ls_expedi1 = Mid(ls_expedi,1,3)
	ls_expedi2 = Mid(ls_expedi,5,9)
	ls_expedi = ls_expedi1+ls_expedi2  
	ls_expedi = trim(ls_expedi)
	if(f_es_vacio(ls_expedi))then ls_expedi = '000000000000' else ls_expedi = f_completar_con_caracteres(ls_expedi,12,'I','0')
	ls_f_abono = string(date(dw_4.GetItemdatetime(j,24)))
	ls_f_abono = trim(ls_f_abono)
	if(f_es_vacio(ls_f_abono))then	ls_f_abono = '00000000' else ls_f_abono = f_completar_con_caracteres(ls_f_abono,8,'I','0')
	ls_f_abono_fin_obra = string(date(dw_4.GetItemdatetime(j,3)))
	ls_f_abono_fin_obra = trim(ls_f_abono_fin_obra)
	if(f_es_vacio(ls_f_abono_fin_obra))then	ls_f_abono_fin_obra = '00000000' else ls_f_abono_fin_obra = f_completar_con_caracteres(ls_f_abono_fin_obra,8,'I','0')
	ls_emplaz = dw_4.GetItemString(j,4)
	ls_emplaz = trim(ls_emplaz)
	if(f_es_vacio(ls_emplaz))then ls_emplaz = ''
	ls_emplaz = f_completar_con_caracteres(ls_emplaz,50,'D',' ')
	ls_pob =	 dw_4.GetItemString(j,5)
	ls_pob = trim(ls_pob)
	if(f_es_vacio(ls_pob))then	ls_pob = ''
	ls_pob = f_completar_con_caracteres(ls_pob,50,'D',' ')
	ls_honorarios = string(int(dw_4.GetItemnumber(j,6)))
	if(f_es_vacio(ls_honorarios))then	ls_honorarios = '00000000' else ls_honorarios = f_completar_con_caracteres(ls_honorarios,8,'I','0')
	ls_t_act = dw_4.GetItemString(j,7)
	ls_t_act = trim(ls_t_act)
	if(f_es_vacio(ls_t_act))then ls_t_act = ''
	ls_t_act = f_completar_con_caracteres(ls_t_act,2,'I','')
	ls_t_obra = dw_4.GetItemString(j,8)
	ls_t_obra = trim(ls_t_obra)
	if(f_es_vacio(ls_t_obra))then ls_t_obra = ''
	ls_t_obra = f_completar_con_caracteres(ls_t_obra,2,'I','')
	ls_destino = dw_4.GetItemString(j,9)
	ls_destino = trim(ls_destino)
	if(f_es_vacio(ls_destino))then ls_destino = ''
	ls_destino = f_completar_con_caracteres(ls_destino,2,'I','')	
	ls_promotor = dw_4.GetItemString(j,10)
	ls_promotor = trim(ls_promotor)
	if(f_es_vacio(ls_promotor))then ls_promotor = ''
	ls_promotor = f_completar_con_caracteres(ls_promotor,1,'I','')
	ls_num_viv = string(int(dw_4.GetItemnumber(j,11)))
	ls_num_viv = trim(ls_num_viv)
	if(f_es_vacio(ls_num_viv))then ls_num_viv = '0000' else ls_num_viv = f_completar_con_caracteres(ls_num_viv,6,'I','0')
	ls_sup_viv = string(int(dw_4.GetItemnumber(j,12)))
	ls_sup_viv = trim(ls_sup_viv)
	if(f_es_vacio(ls_sup_viv))then	ls_sup_viv = '000000' else ls_sup_viv = f_completar_con_caracteres(ls_sup_viv,6,'I','0')
	ls_sup_gar = string(int(dw_4.GetItemnumber(j,13)))
	ls_sup_gar = trim(ls_sup_gar)
	if(f_es_vacio(ls_sup_gar))then	ls_sup_gar = '000000' else ls_sup_gar = f_completar_con_caracteres(ls_sup_gar,6,'I','0')
	ls_sup_otros = string(int(dw_4.GetItemnumber(j,14)))
	ls_sup_otros = trim(ls_sup_otros)
	if(f_es_vacio(ls_sup_otros))then	ls_sup_otros = '000000' else ls_sup_otros = f_completar_con_caracteres(ls_sup_otros,6,'I','0')
	ls_sup_total = string(int(dw_4.GetItemnumber(j,12) + dw_4.GetItemnumber(j,13) + dw_4.GetItemnumber(j,14)))
	if(f_es_vacio(ls_sup_total))then ls_sup_total = '000000' else ls_sup_total = f_completar_con_caracteres(ls_sup_total,6,'I','0')
	ls_pem = string(int(dw_4.GetItemnumber(j,15)))
	ls_pem = trim(ls_pem)
	if(f_es_vacio(ls_pem))then ls_pem = '0000000' else ls_pem = f_completar_con_caracteres(ls_pem,7,'I','0')
	ls_plantas_sob = string(int(dw_4.GetItemnumber(j,16)))
	ls_plantas_sob = trim(ls_plantas_sob)
	if(f_es_vacio(ls_plantas_sob))then ls_plantas_sob = '000' else ls_plantas_sob = f_completar_con_caracteres(ls_plantas_sob,3,'I','0')
	ls_sup_sob = string(int(dw_4.GetItemnumber(j,18)))
	ls_sup_sob = trim(ls_sup_sob)
	if(f_es_vacio(ls_sup_sob))then ls_sup_sob = '000000' else ls_sup_sob = f_completar_con_caracteres(ls_sup_sob,6,'I','0')
	ls_plantas_bajo = string(int(dw_4.GetItemnumber(j,17)))
	ls_plantas_bajo = trim(ls_plantas_bajo)
	if(f_es_vacio(ls_plantas_bajo))then ls_plantas_bajo = '000' else ls_plantas_bajo = f_completar_con_caracteres(ls_plantas_bajo,3,'I','0')
	ls_sup_bajo = string(int(dw_4.GetItemnumber(j,19)))
	ls_sup_bajo = trim(ls_sup_bajo)
	if(f_es_vacio(ls_sup_bajo))then ls_sup_bajo = '000000' else ls_sup_bajo = f_completar_con_caracteres(ls_sup_bajo,6,'I','0')
	ls_altura = string(int(dw_4.GetItemnumber(j,20)))
	ls_altura = trim(ls_altura)
	if(f_es_vacio(ls_altura))then ls_altura = '000' else ls_altura = f_completar_con_caracteres(ls_altura,3,'I','0')
	choose case dw_4.GetItemstring(j,21)
		case 'V'
			ls_uso_venta = 'S'
			ls_uso_alquiler	= 'N'
			ls_uso_autouso = 'N'
		case 'A'
			ls_uso_venta = 'N'
			ls_uso_alquiler	= 'S'
			ls_uso_autouso = 'N'
		case 'U'
			ls_uso_venta = 'N'
			ls_uso_alquiler	= 'N'
			ls_uso_autouso = 'S'
		case else
			ls_uso_venta = ' '
			ls_uso_alquiler	= ' '
			ls_uso_autouso = ' '
	end choose
	ls_geo = dw_4.GetItemstring(j,22)
	ls_geo = trim(ls_geo)
	if(f_es_vacio(ls_geo))then ls_geo = 'N' 
	ll_porcen = string(int(dw_4.GetItemnumber(j,23)))
	if(f_es_vacio(ll_porcen))then	ll_porcen = '000' else ll_porcen = f_completar_con_caracteres(ll_porcen,3,'I','0')
	fila = ls_expedi+ls_f_abono+ls_f_abono+ls_f_abono_fin_obra+'44        '+ls_emplaz+ls_pob+'	TARRAGONA	'+ls_honorarios+'000000000000000'+ls_t_act+ls_t_obra+ls_destino+ls_promotor+ls_num_viv+'	'+ls_sup_total+ls_sup_viv+ls_sup_otros+ls_pem+ls_plantas_sob+ls_sup_sob+ls_plantas_bajo+ls_sup_bajo+ls_altura+ls_uso_alquiler+ls_uso_venta+ls_uso_autouso+ls_geo+'    '+ll_porcen
	FileWrite(file, fila)
next
FileClose(file)

	

	


//Fichero Renuncias 
f_desde = dw_consulta.getitemdatetime(1,'f_desde')
f_hasta = dw_consulta.getitemdatetime(1,'f_hasta')
fecha = 'renuncias_'+string(day(today()))+'_'+	string(month(today()))+'_'+Mid(string(year(today())),3,2)				
ruta_1 = ruta_1 +fecha
ruta_1 = RightTrim(ruta_1)
ruta_1 = ruta_1+".txt"
dw_2.settransobject(sqlca)
dw_2.retrieve(f_desde,f_hasta)	
//dw_2.saveas(ruta_1,Text!,FALSE)
file = FileOpen("C:\ficheros\promo\renuncias.txt", &
        LineMode!, Write!, LockWrite!, Replace!)
for j=1 to dw_2.rowcount( ) 
	//Se recoge el numero de contrato anterior como numero de referencia
	ls_expedi = Mid(dw_2.GetItemString(j,8),1,8)
	if(f_es_vacio(ls_expedi))then ls_expedi = '00000000' else ls_expedi = f_completar_con_caracteres(ls_expedi,8,'I','0')
	ls_fecha =	string(date(dw_2.GetItemdatetime(j,2)),'dd/mm/yyyy')
	if(f_es_vacio(ls_fecha))then	ls_fecha = '00/00/0000' else ls_fecha = f_completar_con_caracteres(ls_fecha,6,'I','0')
	ls_f_abono = string(date(dw_2.GetItemdatetime(j,3)),'dd/mm/yyyy')
	if(f_es_vacio(ls_f_abono))then	ls_f_abono = '00/00/0000' else ls_f_abono = f_completar_con_caracteres(ls_f_abono,6,'I','0')
	ls_porcen_ren = string(int(dw_2.GetItemnumber(j,4)))
	if(f_es_vacio(ls_porcen_ren))then	ls_porcen_ren = '000' else ls_porcen_ren = f_completar_con_caracteres(ls_porcen_ren,3,'I','0')
	ls_porcen_col = string(int(dw_2.GetItemnumber(j,6)))
	if(f_es_vacio(ls_porcen_col))then	ls_porcen_col = '000' else ls_porcen_col = f_completar_con_caracteres(ls_porcen_col,3,'I','0')
	ls_num_viv = string(int(dw_2.GetItemnumber(j,5)))
	if(f_es_vacio(ls_num_viv))then	ls_num_viv = '0000' else ls_num_viv = f_completar_con_caracteres(ls_num_viv,4,'I','0')
	fila = ls_expedi+ls_f_abono+ls_fecha+ls_porcen_ren+ls_porcen_col+ls_num_viv
	FileWriteEx(file, fila)
next
FileClose(file)

//Fichero finales de obra
//Se recoge el numero de contrato anterior como numero de referencia
fecha = 'finales_obra_'+string(day(today()))+'_'+	string(month(today()))+'_'+Mid(string(year(today())),3,2)				
ruta_2 = ruta_2 +fecha
ruta_2 = RightTrim(ruta_2)
ruta_2 = ruta_2+".txt"
dw_3.settransobject(sqlca)
dw_3.retrieve(f_desde, f_hasta)	
//file = FileOpen("C:\ficheros\promo\final_obra.txt")
file = FileOpen("C:\ficheros\promo\final_obra.txt", &
        LineMode!, Write!, LockWrite!, Replace!)
for j=1 to dw_3.rowcount( ) 
	ls_expedi = Mid(dw_3.GetItemString(j,20),1,8)
	if(f_es_vacio(ls_expedi))then ls_expedi = '00000000' else ls_expedi = f_completar_con_caracteres(ls_expedi,8,'I','0')
	ls_pob =	 dw_3.GetItemString(j,'fases_poblacion')
	if(f_es_vacio(ls_pob))then	ls_pob = '0000' else ls_pob = f_completar_con_caracteres(ls_pob,4,'I','0')
	ls_num_viv = string(int(dw_3.GetItemnumber(j,7)))
	if(f_es_vacio(ls_num_viv))then	ls_num_viv = '0000' else ls_num_viv = f_completar_con_caracteres(ls_num_viv,4,'I','0')
	ls_sup_viv = string(int(dw_3.GetItemnumber(j,8)))
	if(f_es_vacio(ls_sup_viv))then	ls_sup_viv = '000000' else ls_sup_viv = f_completar_con_caracteres(ls_sup_viv,6,'I','0')
	sup_otros = int(dw_3.GetItemnumber(j,9))
	sup_garaje = int(dw_3.GetItemnumber(j,21))
	sup_otros = sup_otros + sup_garaje
	ls_sup_otros = string(sup_otros)
	if(f_es_vacio(ls_sup_otros))then	ls_sup_otros = '000000' else ls_sup_otros = f_completar_con_caracteres(ls_sup_otros,6,'I','0')
	pem = int(dw_3.GetItemnumber(j,10))
	pem = pem/1000
	ls_pem = string(pem)
	if(f_es_vacio(ls_pem))then ls_pem = '0000000' else ls_pem = f_completar_con_caracteres(ls_pem,7,'I','0')
	ls_f_abono = string(date(dw_3.GetItemdatetime(j,'fases_f_abono')),'ddmmyy')
	if(f_es_vacio(ls_f_abono))then	ls_f_abono = '000000' else ls_f_abono = f_completar_con_caracteres(ls_f_abono,6,'I','0')
	ls_f_final = string(date(dw_3.GetItemdatetime(j,'fases_finales_fecha')),'ddmmyy')
	if(f_es_vacio(ls_f_final))then	ls_f_final = '000000' else ls_f_final = f_completar_con_caracteres(ls_f_final,6,'I','0')
	ls_emplaz = dw_3.GetItemString(j,'fases_emplazamiento')
	if(f_es_vacio(ls_emplaz))then ls_emplaz = ''
	ls_emplaz = f_completar_con_caracteres(ls_emplaz,46,'D',' ')
	ls_poblacion = dw_3.GetItemString(j,'poblaciones_descripcion')
	if(f_es_vacio(ls_poblacion))then ls_poblacion = ''
	ls_poblacion = f_completar_con_caracteres(ls_poblacion,30,'D',' ')
	ls_promotor = dw_3.GetItemString(j,'fases_usos_t_promotor')
	if(f_es_vacio(ls_promotor))then ls_promotor = ''
	ls_promotor = f_completar_con_caracteres(ls_promotor,2,'I',' ')
	fila = '2'+ls_expedi+ls_pob+'113 '+ls_num_viv+ls_sup_viv+ls_sup_otros+ls_pem+'4'+ls_f_abono+ls_f_final+'      1'+ls_emplaz+'				'+ls_poblacion+'				'+ls_promotor
	FileWrite(file, fila)
next
FileClose(file)

//dw_3.saveas(ruta_2,Text!,FALSE)



end event

type dw_4 from datawindow within w_consejo_proyecto_piloto
boolean visible = false
integer x = 2597
integer y = 812
integer width = 430
integer height = 192
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_consejo_visado_general"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

