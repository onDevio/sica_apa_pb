HA$PBExportHeader$w_fomento.srw
forward
global type w_fomento from w_sheet
end type
type rb_laboratorio from radiobutton within w_fomento
end type
type dw_1 from u_dw within w_fomento
end type
type cb_3 from commandbutton within w_fomento
end type
type rb_contratos from radiobutton within w_fomento
end type
type rb_finales from radiobutton within w_fomento
end type
type st_3 from statictext within w_fomento
end type
type cb_1 from commandbutton within w_fomento
end type
type gb_1 from groupbox within w_fomento
end type
type cb_2 from commandbutton within w_fomento
end type
type dw_consulta from u_dw within w_fomento
end type
end forward

global type w_fomento from w_sheet
integer width = 2944
integer height = 2084
string title = "Fichero del MOPU"
windowstate windowstate = maximized!
boolean ib_isupdateable = false
event csd_finalesobra ( )
event csd_obras ( )
event csd_laboratorio ( )
rb_laboratorio rb_laboratorio
dw_1 dw_1
cb_3 cb_3
rb_contratos rb_contratos
rb_finales rb_finales
st_3 st_3
cb_1 cb_1
gb_1 gb_1
cb_2 cb_2
dw_consulta dw_consulta
end type
global w_fomento w_fomento

type variables
datastore i_ds_lista
end variables

event csd_finalesobra();datetime f_desde, f_hasta,fecha_omni
string sql,id_fase

dw_consulta.accepttext()


if g_colegio = 'COAATNA' then 
	i_ds_lista.dataObject = 'd_finales_obra_na'
else
	i_ds_lista.dataObject = 'd_finales_obra'
end if
i_ds_lista.SetTransObject(SQLCA)
dw_1.dataobject = 'dw_lst_incidencias_mopufinal'
dw_1.SetTransObject(SQLCA)

sql = i_ds_lista.describe("Datawindow.Table.Select")

// Se consulta por la fehca de introducci$$HEX1$$f300$$ENDHEX$$n del final de obra
//En Navarra se utiliza la fecha de cierre
if g_colegio='COAATNA' then
	f_sql('expedientes.f_cierre','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
	f_sql('expedientes.f_cierre','<','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')
else
	f_sql('fases_finales.f_intro','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
	f_sql('fases_finales.f_intro','<','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')
end if
f_sql('fases.cod_colegio_dest','=','cod_colegio', dw_consulta,sql,g_tipo_base_datos,'')
i_ds_lista.modify("datawindow.table.select= ~"" + sql+ "~"")
i_ds_lista.Retrieve()


long filas,i,cuantos,fila
integer fichero
string sCodigo,sPoblacion,sMes,sAnyo,sExp,sNumRegistro,sTipo
string sNumEdif,sNumViv,sNumVivSub,sSupTotal,sSupViv,sSupOtros,sPresup,sPromotor
string linea,fase,nifpromotor
string NombreFichero
long NumEdif,NumViv
double SupTotal,SupViv,SupOtros,SupGar,Presup
datetime fecha

filas = i_ds_lista.RowCount()

NombreFichero = "FINALES.txt"

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02

if GetFileSaveName('Seleccione nombre de fichero',NombreFichero,NombreFichero,'.txt','Ficheros de datos (*.txt),*.txt')<> 1 Then return

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

For i = 1 to filas
	st_3.text = string(i) + "/" + string(filas)
	//Colegio
	sCodigo = LeftA(g_pobla_colegio_carta,2)
	// Codigo de Municipio
	sPoblacion = i_ds_lista.GetItemString(i,'poblaciones_pob_mopu')
	if isnull(sPoblacion) Then sPoblacion = space(3)
	sPoblacion = f_completar_con_caracteres(sPoblacion,3,'I','0')
	sPoblacion = LeftA(sPoblacion, 3)
	// Mes terminacion
	if g_colegio = 'COAATNA' then
		fecha = i_ds_lista.GetItemDateTime(i,'expedientes_f_cierre')
		id_fase = i_ds_lista.GetItemString(i,'fases_id_fase')
	else
		fecha = i_ds_lista.GetItemDateTime(i,'fases_finales_fecha')
		id_fase  = i_ds_lista.GetItemString(i,'fases_finales_id_fase')
	end if
	sMes = String(Month(Date(fecha)))
	if isnull(sMes) Then sMes = ''
	smes = f_completar_con_caracteres(sMes,2,'I','0')
	smes = LeftA(smes, 2)
	// A$$HEX1$$f100$$ENDHEX$$o Terminaci$$HEX1$$f300$$ENDHEX$$n
	sAnyo = String(Year(Date(fecha)))
	if isnull(sAnyo) Then sAnyo = ''
	sAnyo = f_completar_con_caracteres(sAnyo,4,'I','0')
	sAnyo = LeftA(sAnyo, 4)


	
	fecha_omni = f_fases_f_visado(id_fase)
		
	
	if  fecha_omni=datetime(date('01/01/1900'), time('00:00:00')) then
		fecha_omni = f_fases_f_abono(id_fase)
	end if	
	
	if  fecha_omni=datetime(date('01/01/1900'), time('00:00:00')) then
		fecha_omni =datetime(date('01/01/9999'), time('00:00:00'))
	end if		
	
	// N$$HEX2$$ba002000$$ENDHEX$$Expediente
	
	//  Se tipifica con una variable global 'g_tipo_ident_muss' los datos que se envian a Fomento segun:
	//   1     	Mando numero de registro tal cual
	//   4		Mando numero de registro con R delante o numero de visado si es anterior 1 octubre
	//   3, 2		Mando numero de registro tal cual o numero de visado si es anterior 1 octubre
	//   5.        Mando numero de visado tal cual
	
	choose case g_tipo_ident_fichero
			
		case '3','2'
			if fecha_omni < datetime(date('01/10/2010') , time('00:00:00')) then 
				sNumRegistro = i_ds_lista.GetItemString(i,'fases_archivo')
				if isnull(sNumRegistro) Then sNumRegistro = ''
				sNumRegistro = RightA(f_completar_con_caracteres(sNumRegistro,9,'I',' '),9)
				sNumRegistro = LeftA(sNumRegistro, 9)
			else
				sNumRegistro = i_ds_lista.GetItemString(i,'Fases_n_registro')
				if isnull(sNumRegistro) Then sNumRegistro = ''
				sNumRegistro = RightA(f_completar_con_caracteres(sNumRegistro,9,'I',' '),9)
				sNumRegistro = LeftA(sNumRegistro, 9)
			end if
			
		case  '4'
			
			if fecha_omni<datetime(date('01/10/2010'), time('00:00:00')) then
				sNumRegistro = i_ds_lista.GetItemString(i,'fases_archivo')
				if isnull(sNumRegistro) Then sNumRegistro = ''
				sNumRegistro = RightA(f_completar_con_caracteres(sNumRegistro,9,'I',' '),9)
				sNumRegistro = LeftA(sNumRegistro, 9)
			else
				sNumRegistro = i_ds_lista.GetItemString(i,'Fases_n_registro')
				if isnull(sNumRegistro) Then sNumRegistro = ''
				sNumRegistro = RightA(f_completar_con_caracteres('R'+sNumRegistro,9,'I',' '),9)
				sNumRegistro = LeftA(sNumRegistro, 9)
			end if
		
		case '1'
			sNumRegistro = i_ds_lista.GetItemString(i,'Fases_n_registro')
			if isnull(sNumRegistro) Then sNumRegistro = ''
			sNumRegistro = RightA(f_completar_con_caracteres(sNumRegistro,9,'I',' '),9)
			sNumRegistro = LeftA(sNumRegistro, 9)
		case '5'
			sNumRegistro = i_ds_lista.GetItemString(i,'fases_archivo')
			if isnull(sNumRegistro) Then sNumRegistro = ''
			sNumRegistro = RightA(f_completar_con_caracteres(sNumRegistro,9,'I',' '),9)
			sNumRegistro = LeftA(sNumRegistro, 9)
	end choose

	/*sNumRegistro = i_ds_lista.GetItemString(i,'Fases_n_registro')
	if isnull(sNumRegistro) Then sNumRegistro = ''
	sNumRegistro = RightA(f_completar_con_caracteres(sNumRegistro,9,'I',' '),9)
	sNumRegistro = LeftA(sNumRegistro, 9)
	if g_colegio = 'COAATZ' or g_colegio = 'COAATGU' or g_colegio = 'COAATLE' or g_colegio = 'COAATAVI' or g_colegio = 'COAATA' or g_colegio = 'COAATTER' or g_colegio = 'COAATTEB' or g_colegio = 'COAATNA' then // Para estos colegios el n$$HEX2$$ba002000$$ENDHEX$$visado
		sNumRegistro = i_ds_lista.GetItemString(i,'fases_archivo')
		if isnull(sNumRegistro) Then
			// En el caso de que no haya n$$HEX2$$ba002000$$ENDHEX$$de visado, ponemos n$$HEX2$$ba002000$$ENDHEX$$de registro
			sNumRegistro = i_ds_lista.GetItemString(i,'Fases_n_registro')
			if isnull(sNumRegistro) Then
				sNumRegistro = ''
			end if
		end if
		sNumRegistro = RightA(f_completar_con_caracteres(sNumRegistro,9,'I',' '),9)
		sNumRegistro = LeftA(sNumRegistro, 9)
	end if	*/
	// Ejecucion
	
	//En Navarra gastan un DW distinto (vease l$$HEX1$$ed00$$ENDHEX$$nea 8)
	if g_colegio = 'COAATNA' then
		fase = i_ds_lista.GetItemString(i,'fases_id_fase')
		sTipo = 'T'
	else
		fase = i_ds_lista.GetItemString(i,'fases_finales_id_fase')
		sTipo = i_ds_lista.GetItemString(i,'fases_finales_total_parcial')
	end if
	if sTipo = 'T' or sTipo = 'V' then
		select count(*) into :cuantos
		from fases_finales where id_fase = :fase;
		if cuantos > 1 then
			sTipo = "2"
		else
			sTipo = "1"
		end if
	else
		sTipo = "3"
	end if
	sTipo = LeftA(sTipo, 1)
	// N edificios
	NumEdif = i_ds_lista.getItemNumber(i,'fases_finales_num_edif')
	/*
	if isnull(NumEdif) or NumEdif = 0 then
		NumEdif = i_ds_lista.GetItemNumber(i,'fases_usos_num_edif')
		if isnull(NumEdif) then NumEdif = 0
	end if
	*/
	if isnull(NumEdif) then NumEdif = 0
	sNumEdif = f_completar_con_caracteres(string(NumEdif),3,'I',' ')
	sNumEdif = LeftA(sNumEdif, 3)
	// Numero de Viviendas
	NumViv = i_ds_lista.GetItemNumber(i,'fases_finales_num_viv')
	/* Se comenta por SCP-925
	if isnull(NumViv) or NumViv = 0 then
		NumViv = i_ds_lista.GetItemNumber(i,'fases_usos_num_viv')
		if isnull(NumViv) then NumViv = 0
	end if
	*/
	if isnull(NumViv) then NumViv = 0
	sNumViv = f_completar_con_caracteres(string(NumViv),4,'I',' ')
	sNumViv = LeftA(sNumViv, 4)
	// Numero de Viviendas Subvencionadas
	sNumVivSub = space(4)
	// Superficie de viviendas
	SupViv = round(i_ds_lista.GetItemNumber(i,'fases_finales_sup_viv'),0)
	/*Se comenta por SCP-925
	if isnull(SupViv) or SupViv = 0 Then
		SupViv = i_ds_lista.GetItemNumber(i,'fases_usos_sup_viv')
		if isnull(SupViv) Then SupViv = 0
	end if	*/
	if isnull(SupViv) Then SupViv = 0
	// Superficie de Garajes
	SupGar = round(i_ds_lista.GetItemNumber(i,'fases_finales_sup_garage'),0)
	/*Se comenta por SCP-925
	if isnull(SupGar) or SupGar = 0 Then
		SupGar = i_ds_lista.GetItemNumber(i,'fases_usos_sup_garage')
		if isnull(SupGar) Then SupGar = 0
	end if
	*/
	if isnull(SupGar) Then SupGar = 0 
	
	SupOtros = round(i_ds_lista.GetItemNumber(i,'fases_finales_sup_otros'),0)
	/*Se comenta por SCP-925
	if isnull(SupOtros) or SupOtros = 0 Then
		SupOtros = i_ds_lista.GetItemNumber(i,'fases_usos_sup_otros')
		if isnull(SupOtros) Then SupOtros = 0
	end if
	*/
	if isnull(SupOtros) Then SupOtros = 0
	SupOtros = SupOtros + SupGar
	SupTotal = SupOtros + SupViv
	
	sSupTotal = f_completar_con_caracteres(string(round(SupTotal,0)),6,'I',' ')
	sSupTotal = LeftA(sSupTotal, 6)	
	sSupViv = f_completar_con_caracteres(string(round(SupViv,0)),6,'I',' ')
	sSupViv = LeftA(sSupViv, 6)		
	sSupOtros = f_completar_con_caracteres(string(round(SupOtros,0)),6,'I',' ')
	sSupOtros = LeftA(sSupOtros, 6)		
	// Presupuesto
	Presup = round(i_ds_lista.GetItemNumber(i,'fases_finales_presupuesto') /100,1)
	if isnull(Presup) or Presup = 0 then
		Presup = round(i_ds_lista.GetItemNumber(i,'fases_usos_pem')/100,1)
		if isnull(Presup) then Presup = 0
	end if
	int pos_coma
	sPresup = string(Presup, '###########0')
//	pos_coma = pos(sPresup, ',', 1)
//	sPresup = replace(sPresup, pos_coma, 1, '')	
	sPresup = RightA(f_completar_con_caracteres(sPresup,7,'I',' '),7)	
	sPresup = RightA(sPresup, 7)		
	
	//Promotor
	select t_promotor into :sPromotor from fases_usos where id_fase = :fase;
	if f_es_vacio(sPromotor) then sPromotor = space(1)
	
	if (sPromotor >= "0" and sPromotor <= "9") or sPromotor = "H" then 
		sPromotor = "1"
	else
		if sPromotor >= "A" and sPromotor <= "E" then 
			sPromotor = "2"
		else
			if SPromotor = "F" then 
				sPromotor = "3"
			else
				if sPromotor = "Q" or sPromotor = "S" then 
					sPromotor = "4"
				else
					if sPromotor = "P" then 
						sPromotor = "6"
					else
						sPromotor = "7"
					end if
				end if
			end if
		end if
	end if
	sPromotor = LeftA(sPromotor, 1)	
	
	linea = sCodigo + sPoblacion + sMes + sAnyo + sNumRegistro + sTipo
	linea = linea + sNumEdif + sNumViv + sNumVivSub
	linea = linea + sSupTotal + sSupViv + sSupOtros + sPresup + sPromotor

	FileWrite(fichero,linea)

	fila = dw_1.InsertRow(0)
	dw_1.SetItem(fila,'numcontrato',sNumRegistro)
	dw_1.SetItem(fila,'tipoobra',i_ds_lista.GetItemString(i,'fases_tipo_trabajo'))
	dw_1.SetItem(fila,'tipoact',i_ds_lista.GetItemString(i,'fases_fase'))		
	dw_1.SetItem(fila,'numedif',sNumEdif)
	dw_1.SetItem(fila,'numviv',sNumViv)
	dw_1.SetItem(fila,'sup',string(round(SupTotal,0),"#,##0"))
	dw_1.SetItem(fila,'pem',string(Presup,"#,##0.0"))
Next

//messagebox('kk', string(len(linea)))
dw_1.of_setprintpreview(TRUE)
dw_1.event pfc_printpreview()
dw_1.visible = true
cb_3.visible = true

FileClose(fichero)

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02

end event

event csd_obras();datetime f_desde, f_hasta
string sql

dw_consulta.accepttext()

i_ds_lista.dataObject = 'd_obras'
i_ds_lista.SetTransObject(SQLCA)
dw_1.dataobject = 'dw_lst_incidencias_mopu'
dw_1.SetTransObject(SQLCA)

sql = i_ds_lista.describe("Datawindow.Table.Select")

// Se puede consultar por fecha abono, por fecha de visado o por fecha de registro
//                  *****RD 1000/2010******
if dw_consulta.getitemstring(1, 'fecha') = 'V' then
	f_sql('fases.f_visado','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
	f_sql('fases.f_visado','<','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')
elseif dw_consulta.getitemstring(1, 'fecha') = 'R' then
	f_sql('fases.f_entrada','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
	f_sql('fases.f_entrada','<','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')
else
	f_sql('fases.f_abono','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
	f_sql('fases.f_abono','<','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')	
end if

i_ds_lista.modify("datawindow.table.select= ~"" + sql+ "~"")
i_ds_lista.Retrieve()


long filas,i,cuantos,fila
integer fichero
string sCodigo,sPoblacion,sFecha,sExp,sNumRegistro,sTipo,sNumRegistroAnt
string sNumEdif,sNumViv,sSupTotal,sSupViv,sSupOtros,sPresup,sPromotor,sNumVivSub,sSupGar
string sAnulado,sFechaAbono,sTipoObra,sTipoAct,sDestino
string sNumSob,sSupSob,sNumBaj,sSupBaj,sAltura
string sMedianeras,sUso
string linea,fase
string NombreFichero
long NumEdif,NumViv,NumSob,NumBaj
double SupTotal,SupViv,SupOtros,SupGar,Presup,SupSob,SupBaj,Altura
datetime fecha

filas = i_ds_lista.RowCount()

datetime fecha_omni
string id_fase=""


NombreFichero = "FOMENTO.txt"

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02

if GetFileSaveName('Seleccione nombre de fichero',NombreFichero,NombreFichero,'.txt','Ficheros de datos (*.txt),*.txt')<> 1 Then return

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

For i = 1 to filas
	
	id_fase=i_ds_lista.getitemstring(i,"fases_id_fase")
	fecha_omni = f_fases_f_visado(id_fase)
		
	
	if  fecha_omni=datetime(date('01/01/1900'), time('00:00:00')) then
		fecha_omni = f_fases_f_abono(id_fase)
	end if	
	
	if  fecha_omni=datetime(date('01/01/1900'), time('00:00:00')) then
		fecha_omni =datetime(date('01/01/9999'), time('00:00:00'))
	end if		

	
	
	st_3.text = string(i) + "/" + string(filas)

	// N$$HEX2$$ba002000$$ENDHEX$$Expediente
	
	//  Se tipifica con una variable global 'g_tipo_ident_muss' los datos que se envian a Fomento segun:
	//   1     	Mando numero de registro tal cual
	//   4		Mando numero de registro con R delante o numero de visado si es anterior 1 octubre
	//   3, 2		Mando numero de registro tal cual o numero de visado si es anterior 1 octubre
	//   5.        Mando numero de visado tal cual
	
	choose case g_tipo_ident_fichero
			
		case '3','2'
			if fecha_omni < datetime(date('01/10/2010') , time('00:00:00')) then 
				sNumRegistro = i_ds_lista.GetItemString(i,'fases_archivo')
				if isnull(sNumRegistro) Then sNumRegistro = ''
				sNumRegistro = RightA(f_completar_con_caracteres(sNumRegistro,9,'I',' '),9)
				sNumRegistro = LeftA(sNumRegistro, 9)
			else
				sNumRegistro = i_ds_lista.GetItemString(i,'Fases_n_registro')
				if isnull(sNumRegistro) Then sNumRegistro = ''
				sNumRegistro = RightA(f_completar_con_caracteres(sNumRegistro,9,'I',' '),9)
				sNumRegistro = LeftA(sNumRegistro, 9)
			end if
			
		case  '4'
			
			if fecha_omni<datetime(date('01/10/2010'), time('00:00:00')) then
				sNumRegistro = i_ds_lista.GetItemString(i,'fases_archivo')
				if isnull(sNumRegistro) Then sNumRegistro = ''
				sNumRegistro = RightA(f_completar_con_caracteres(sNumRegistro,9,'I',' '),9)
				sNumRegistro = LeftA(sNumRegistro, 9)
			else
				sNumRegistro = i_ds_lista.GetItemString(i,'Fases_n_registro')
				if isnull(sNumRegistro) Then sNumRegistro = ''
				sNumRegistro = RightA(f_completar_con_caracteres('R'+sNumRegistro,9,'I',' '),9)
				sNumRegistro = LeftA(sNumRegistro, 9)
			end if
		
		case '1'
			sNumRegistro = i_ds_lista.GetItemString(i,'Fases_n_registro')
			if isnull(sNumRegistro) Then sNumRegistro = ''
			sNumRegistro = RightA(f_completar_con_caracteres(sNumRegistro,9,'I',' '),9)
			sNumRegistro = LeftA(sNumRegistro, 9)
		case '5'
			sNumRegistro = i_ds_lista.GetItemString(i,'fases_archivo')
			if isnull(sNumRegistro) Then sNumRegistro = ''
			sNumRegistro = RightA(f_completar_con_caracteres(sNumRegistro,9,'I',' '),9)
			sNumRegistro = LeftA(sNumRegistro, 9)
	end choose
	
	/*sNumRegistro = i_ds_lista.GetItemString(i,'Fases_n_registro')
	if isnull(sNumRegistro) Then sNumRegistro = ''
	sNumRegistro = RightA(f_completar_con_caracteres(sNumRegistro,9,'I',' '),9)
	sNumRegistro = LeftA(sNumRegistro, 9)
	if g_colegio = 'COAATZ' or g_colegio = 'COAATGU' or g_colegio = 'COAATLE' or g_colegio = 'COAATAVI' or g_colegio = 'COAATA' or g_colegio = 'COAATNA' or g_colegio = 'COAATTER' then // Para estos colegios el n$$HEX2$$ba002000$$ENDHEX$$visado
		sNumRegistro = i_ds_lista.GetItemString(i,'fases_archivo')
		if isnull(sNumRegistro) Then
			// En el caso de que no haya n$$HEX2$$ba002000$$ENDHEX$$de visado, ponemos n$$HEX2$$ba002000$$ENDHEX$$de registro
			sNumRegistro = i_ds_lista.GetItemString(i,'Fases_n_registro')
			if isnull(sNumRegistro) Then
				sNumRegistro = ''
			end if
		end if
		sNumRegistro = RightA(f_completar_con_caracteres(sNumRegistro,9,'I',' '),9)
		sNumRegistro = LeftA(sNumRegistro, 9)
	end if
	*/
	
	// Fecha de Visado
	fecha = i_ds_lista.GetItemDateTime(i,'fases_f_visado')
	sFecha = String(fecha,"ddmmyyyy")
	if isnull(sFecha) or sFecha = '' then sFecha = space(8)
	sFecha = LeftA(sFecha, 8)
	//Colegio
	sCodigo = LeftA(g_pobla_colegio_carta,2)
	// Codigo de Municipio
	sPoblacion = i_ds_lista.GetItemString(i,'poblaciones_pob_mopu')
	if isnull(sPoblacion) Then sPoblacion = space(3)
	sPoblacion = f_completar_con_caracteres(sPoblacion,3,'I','0')
	sPoblacion = LeftA(sPoblacion, 3)
	// Tipo de VIsado
	sTipo = '1'
	choose case i_ds_lista.GetItemString(i,'fases_tipo_registro')
		case 'IP' //PRIMER VISADO / VISADO OBLIGATORIO
			sTipo = '1'
		case 'MO' //MODIFICACI$$HEX1$$d300$$ENDHEX$$N PROY.
			sTipo = '2'
		case 'CC'
			sTipo = '3'
		case 'RS', 'RN' //CAMBIO COLEGIADO
			sTipo = '4'
		case 'LE' //LEGALIZACI$$HEX1$$d300$$ENDHEX$$N
			sTipo = '5'			
		case 'AN' //ANULACI$$HEX1$$d300$$ENDHEX$$N ENCARGO
			sTipo = '6'
	end choose
	// Registro Anterior
	//	sNumRegistroAnt = space(9)
	sNumRegistroAnt = i_ds_lista.GetItemString(i,'fases_n_contrato_ant')
	if isnull(sNumRegistroAnt) Then sNumRegistroAnt = ''
	sNumRegistroAnt = RightA(f_completar_con_caracteres(sNumRegistroAnt,9,'I',' '),9)
	sNumRegistroAnt = LeftA(sNumRegistroAnt, 9)
	// Anulado
	sAnulado = 'N'
	// Fecha Retirada
	fecha = i_ds_lista.GetItemDateTime(i,'fases_f_abono')
	sFechaAbono = String(fecha,"ddmmyyyy")
	if f_es_vacio(sFechaAbono) then sFechaAbono = space(8)
	sFechaAbono = LeftA(sFechaAbono, 8)
	//Tipo de Actuacion
	sTipoAct = i_ds_lista.GetItemString(i,'fases_fase') 
	if f_es_vacio(sTipoAct) then sTipoAct = space(2)
	sTipoAct = LeftA(sTipoAct, 2)
	// Tipo de Obra
	sTipoObra = i_ds_lista.GetItemString(i,'fases_tipo_trabajo')
	if f_es_vacio(sTipoObra) Then sTipoObra = space(2)
	sTipoObra = LeftA(sTipoObra, 2)	
	// Destino
	sDestino = i_ds_lista.GetItemString(i,'fases_trabajo')
	if f_es_vacio(sDestino) Then sDestino = space(2)
	sDestino = LeftA(sDestino, 2)
	// Nif Promotor
	fase = i_ds_lista.GetItemString(i,'fases_id_fase')
	select t_promotor into :sPromotor from fases_usos where id_fase = :fase;
//	if (sPromotor >= "0" and sPromotor <= "9") then sPromotor = "X"
	if f_es_vacio(sPromotor) then sPromotor = ' '
	// Numero de Edificios
	NumEdif = i_ds_lista.GetItemNumber(i,'fases_usos_num_edif')
	if isnull(NumEdif) then NumEdif = 0
	sNumEdif = f_completar_con_caracteres(string(NumEdif),3,'I',' ')
	sNumEdif = LeftA(sNumEdif, 3)
	// Nuemero de Viviendas
	NumViv = i_ds_lista.GetItemNumber(i,'fases_usos_num_viv')
	if isnull(NumViv) then NumViv = 0
	sNumViv = f_completar_con_caracteres(string(NumViv),4,'I',' ')
	sNumViv = LeftA(sNumViv, 4)
	// Numero de Viviendas Subvencionadas
	sNumVivSub = space(4) //Falta?
	sNumVivSub = LeftA(sNumVivSub, 4)
	// Superficie de Viviendas
	SupViv = round(i_ds_lista.GetItemNumber(i,'fases_usos_sup_viv'),0)
	if isnull(SupViv) Then SupViv = 0
	
	SupGar = round(i_ds_lista.GetItemNumber(i,'fases_usos_sup_garage'),0)
	if isnull(SupGar) Then SupGar = 0
	
	SupOtros = round(i_ds_lista.GetItemNumber(i,'fases_usos_sup_otros'),0)
	if isnull(SupOtros) Then SupOtros = 0
	
	SupTotal = SupOtros + SupViv + SupGar
	sSupTotal = f_completar_con_caracteres(string(round(SupTotal,0)),6,'I',' ')
	sSupTotal = LeftA(sSupTotal, 6)
	
	sSupViv = f_completar_con_caracteres(string(round(SupViv,0)),6,'I',' ')
	sSupViv = LeftA(sSupViv, 6)	
	sSupOtros = f_completar_con_caracteres(string(round(SupOtros,0)),6,'I',' ')
	sSupOtros = LeftA(sSupOtros, 6)	
	sSupGar = f_completar_con_caracteres(string(round(SupGar,0)),6,'I',' ')
	sSupGar = LeftA(sSupGar, 6)	
	// Presupuesto
	Presup = round(i_ds_lista.GetItemNumber(i,'fases_usos_pem')/100,1)
	if isnull(Presup) or Presup = 0 then
		Presup = round(i_ds_lista.GetItemNumber(i,'fases_usos_pem')/100,1)
		if isnull(Presup) then Presup = 0
	end if
//	int pos_coma
	sPresup = string(Presup,'###########0')
//	pos_coma = pos(sPresup, ',', 1)
//	sPresup = replace(sPresup, pos_coma, 1, '')
	sPresup = RightA(f_completar_con_caracteres(sPresup,7,'I',' '),7)
	sPresup = RightA(sPresup, 7)
	// N$$HEX1$$fa00$$ENDHEX$$mero de Viviendas sobre rasante
	NumSob = i_ds_lista.GetItemNumber(i,'fases_usos_plantas_sob')
	sNumSob = f_completar_con_caracteres(string(NumSob),2,'I',' ')
	if isnull(sNumSob) then sNumSob = space(2)
	sNumSob = LeftA(sNumSob, 2)
	// Superficie sobre rasante
	SupSob = i_ds_lista.GetItemNumber(i,'fases_usos_sup_sob')
	sSupSob = f_completar_con_caracteres(string(round(SupSob,0)),6,'I',' ')
	if isnull(sSupSob) then sSupSob = space(6)
	sSupSob = LeftA(sSupSob, 6)
	// Numero de Viviendas bajo rasante
	NumBaj = i_ds_lista.GetItemNumber(i,'fases_usos_plantas_baj')
	sNumBaj = f_completar_con_caracteres(string(NumBaj),1,'I',' ')
	if isnull(sNumBaj) then sNumBaj = space(1)
	sNumBaj = LeftA(sNumBaj, 1)
	// Superficie Bajo rasante
	SupBaj = i_ds_lista.GetItemNumber(i,'fases_usos_sup_baj')
	sSupBaj = f_completar_con_caracteres(string(round(SupBaj,0)),6,'I',' ')
	if isnull(sSupBaj) then sSupBaj = space(6)
	sSupBaj = LeftA(sSupBaj, 6)
	// Altura
	Altura = round(i_ds_lista.GetItemNumber(i,'fases_usos_altura'),0)
	sAltura = f_completar_con_caracteres(string(Altura),3,'I',' ')
	if isnull(sAltura) then sAltura = space(3)
	sAltura = LeftA(sAltura, 3)	
	// Medianeras	
	sMedianeras = i_ds_lista.GetItemString(i,'fases_usos_colindantes')
	if (sMedianeras<>'01' and sMedianeras<>'02' and sMedianeras<>'03') or isnull(sMedianeras) then sMedianeras = '0'
	if sMedianeras = '01' then sMedianeras = '0'
	if sMedianeras = '02' then sMedianeras = '1'
	if sMedianeras = '03' then sMedianeras = '2'
	sMedianeras = LeftA(sMedianeras, 1)		
	// Uso
	sUso = i_ds_lista.GetItemString(i,'fases_usos_uso')
	if (upper(sUso) <> "A") and (upper(sUso) <> "V") and (upper(sUso) <> "U") then sUso = "NNN"
	if upper(sUso) = "V" then sUso = "SNN"
	if upper(sUso) = "A" then sUso = "NSN"
	if upper(sUso) = "U" then sUso = "NNS"
	if isNULL(sUso) then sUso = "NNN"

	linea = sNumRegistro + sFecha + sCodigo + sPoblacion + sTipo + sNumRegistroAnt + sAnulado
	linea = linea + sFechaAbono + sTipoAct + sTipoObra + sDestino + sPromotor
	linea = linea + sNumEdif + sNumViv + sNumVivSub
	linea = linea + sSupTotal + sSupViv + sSupGar + sSupOtros + sPresup 
	linea = linea + sNumSob + sSupSob + sNumBaj + sSupBaj + sAltura
	linea = linea + sMedianeras + sUso

	FileWrite(fichero,linea)

	fila = dw_1.InsertRow(0)
	dw_1.SetItem(fila,'numcontrato',sNumRegistro)
	dw_1.SetItem(fila,'tipoact',i_ds_lista.GetItemString(i,'fases_fase'))	
	dw_1.SetItem(fila,'tipoobra',i_ds_lista.GetItemString(i,'fases_tipo_trabajo'))	
	dw_1.SetItem(fila,'numedif',sNumEdif)
	dw_1.SetItem(fila,'numviv',sNumViv)
	dw_1.SetItem(fila,'sup',string(round(SupTotal,0),"#,##0"))
	dw_1.SetItem(fila,'pem',string(Presup,"#,##0.0"))
Next
//messagebox('kk', string(len(linea)))
dw_1.of_setprintpreview(TRUE)
dw_1.event pfc_printpreview()
dw_1.visible = true
cb_3.visible = true

FileClose(fichero)

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02

end event

event csd_laboratorio();datetime f_desde, f_hasta
string sql

dw_consulta.accepttext()

i_ds_lista.dataObject = 'd_obras_laboratorio'  
i_ds_lista.SetTransObject(SQLCA)
dw_1.dataobject = 'dw_lst_incidencias_mopu_laboratorio'
dw_1.SetTransObject(SQLCA)

sql = i_ds_lista.describe("Datawindow.Table.Select")

// Se puede consultar por fecha abono, por fecha de visado o por fecha de registro
//                  *****RD 1000/2010******
if dw_consulta.getitemstring(1, 'fecha') = 'V' then
	f_sql('fases.f_visado','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
	f_sql('fases.f_visado','<','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')
elseif dw_consulta.getitemstring(1, 'fecha') = 'R' then
	f_sql('fases.f_entrada','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
	f_sql('fases.f_entrada','<','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')
else
	f_sql('fases.f_abono','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
	f_sql('fases.f_abono','<','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')	
end if

i_ds_lista.modify("datawindow.table.select= ~"" + sql+ "~"")
i_ds_lista.Retrieve()


long filas,i,cuantos,fila
integer fichero
string sCodigo,sPoblacion,sFecha,sExp,sNumRegistro,sTipo,sNumRegistroAnt
string sNumEdif,sNumViv,sSupTotal,sSupViv,sSupOtros,sPresup,sPromotor,sNumVivSub,sSupGar
string sAnulado,sFechaAbono,sTipoObra,sTipoAct,sDestino
string sNumSob,sSupSob,sNumBaj,sSupBaj,sAltura
string sMedianeras,sUso,sDesc,sConsObra,sEmp,sNEmp,sViaEmp
string linea,fase
string NombreFichero
long NumEdif,NumViv,NumSob,NumBaj
double SupTotal,SupViv,SupOtros,SupGar,Presup,SupSob,SupBaj,Altura
datetime fecha

filas = i_ds_lista.RowCount()

NombreFichero = "LABORATORIO.txt"

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02

if GetFileSaveName('Seleccione nombre de fichero',NombreFichero,NombreFichero,'.txt','Ficheros de datos (*.txt),*.txt')<> 1 Then return

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

For i = 1 to filas
	st_3.text = string(i) + "/" + string(filas)
	// N$$HEX2$$ba002000$$ENDHEX$$Expediente
	sNumRegistro = i_ds_lista.GetItemString(i,'Fases_n_registro')
	if isnull(sNumRegistro) Then sNumRegistro = ''
	sNumRegistro = RightA(f_completar_con_caracteres(sNumRegistro,9,'I',' '),9)
	sNumRegistro = LeftA(sNumRegistro, 9)		
	// Fecha de Visado
	fecha = i_ds_lista.GetItemDateTime(i,'fases_f_visado')
	sFecha = String(fecha,"ddmmyyyy")
	if isnull(sFecha) then sFecha = space(8)
	sFecha = LeftA(sFecha, 8)
	//Colegio
	sCodigo = LeftA(g_pobla_colegio_carta,2)
	// Codigo de Municipio
	sPoblacion = i_ds_lista.GetItemString(i,'poblaciones_pob_mopu')
	if isnull(sPoblacion) Then sPoblacion = space(3)
	sPoblacion = f_completar_con_caracteres(sPoblacion,3,'I','0')
	sPoblacion = LeftA(sPoblacion, 3)
	// Tipo de VIsado
	sTipo = '1'
	choose case i_ds_lista.GetItemString(i,'fases_tipo_registro')
		case 'IP' //PRIMER VISADO / VISADO OBLIGATORIO
			sTipo = '1'
		case 'MO' //MODIFICACI$$HEX1$$d300$$ENDHEX$$N PROY.
			sTipo = '2'
		case 'CC'
			sTipo = '3'
		case 'RS', 'RN' //CAMBIO COLEGIADO
			sTipo = '4'
		case 'LE' //LEGALIZACI$$HEX1$$d300$$ENDHEX$$N
			sTipo = '5'			
		case 'AN' //ANULACI$$HEX1$$d300$$ENDHEX$$N ENCARGO
			sTipo = '6'
	end choose
	// Registro Anterior
	// sNumRegistroAnt = space(9)
	sNumRegistroAnt = i_ds_lista.GetItemString(i,'fases_n_contrato_ant')
	if isnull(sNumRegistroAnt) Then sNumRegistroAnt = ''
	sNumRegistroAnt = RightA(f_completar_con_caracteres(sNumRegistroAnt,9,'I',' '),9)
	sNumRegistroAnt = LeftA(sNumRegistroAnt, 9)	
	// Anulado
	sAnulado = 'N' //'N'
	// Fecha Retirada
	fecha = i_ds_lista.GetItemDateTime(i,'fases_f_abono')
	sFechaAbono = String(fecha,"ddmmyyyy")
	if f_es_vacio(sFechaAbono) then sFechaAbono = space(8)
	sFechaAbono = LeftA(sFechaAbono, 8)
	//Tipo de Actuacion
	sTipoAct = i_ds_lista.GetItemString(i,'fases_fase')
	if f_es_vacio(sTipoAct) then sTipoAct = space(2)
	sTipoAct = LeftA(sTipoAct, 2)
	// Tipo de Obra
	sTipoObra = i_ds_lista.GetItemString(i,'fases_tipo_trabajo')
	if f_es_vacio(sTipoObra) Then sTipoObra = space(2)
	sTipoObra = LeftA(sTipoObra, 2)	
	// Destino
	sDestino = i_ds_lista.GetItemString(i,'fases_trabajo')
	if f_es_vacio(sDestino) Then sDestino = space(2)
	sDestino = LeftA(sDestino, 2)
	// Nif Promotor
	fase = i_ds_lista.GetItemString(i,'fases_id_fase')
	select t_promotor into :sPromotor from fases_usos where id_fase = :fase;
	if (sPromotor >= "0" and sPromotor <= "9") then sPromotor = "X"
	if f_es_vacio(sPromotor) then sPromotor = ' '
	// Numero de Edificios
	NumEdif = i_ds_lista.GetItemNumber(i,'fases_usos_num_edif')
	if isnull(NumEdif) then NumEdif = 0
	sNumEdif = f_completar_con_caracteres(string(NumEdif),3,'I',' ')
	sNumEdif = LeftA(sNumEdif, 3)
	// Numero de Viviendas
	NumViv = i_ds_lista.GetItemNumber(i,'fases_usos_num_viv')
	if isnull(NumViv) then NumViv = 0
	sNumViv = f_completar_con_caracteres(string(NumViv),4,'I',' ')
	sNumViv = LeftA(sNumViv, 4)
	// Numero de Viviendas Subvencionadas
	sNumVivSub = space(4) //Falta?
	sNumVivSub = LeftA(sNumVivSub, 4)
	// Superficie de Viviendas
	SupViv = round(i_ds_lista.GetItemNumber(i,'fases_usos_sup_viv'),0)
	if isnull(SupViv) Then SupViv = 0
	
	SupGar = round(i_ds_lista.GetItemNumber(i,'fases_usos_sup_garage'),0)
	if isnull(SupGar) Then SupGar = 0
	
	SupOtros = round(i_ds_lista.GetItemNumber(i,'fases_usos_sup_otros'),0)
	if isnull(SupOtros) Then SupOtros = 0
	
	SupTotal = SupOtros + SupViv + SupGar
	sSupTotal = f_completar_con_caracteres(string(round(SupTotal,0)),6,'I',' ')
	sSupTotal = LeftA(sSupTotal, 6)
	
	sSupViv = f_completar_con_caracteres(string(round(SupViv,0)),6,'I',' ')
	sSupViv = LeftA(sSupViv, 6)	
	sSupOtros = f_completar_con_caracteres(string(round(SupOtros,0)),6,'I',' ')
	sSupOtros = LeftA(sSupOtros, 6)	
	sSupGar = f_completar_con_caracteres(string(round(SupGar,0)),6,'I',' ')
	sSupGar = LeftA(sSupGar, 6)	
	// Presupuesto en CENTENAS
	int pos_coma
	Presup = round((i_ds_lista.GetItemNumber(i,'fases_usos_pem') / 100) ,1)
	sPresup = string(Presup,'###########0')
//	pos_coma = pos(sPresup, ',', 1)
//	sPresup = replace(sPresup, pos_coma, 1, '')
	sPresup = RightA(f_completar_con_caracteres(sPresup,7,'I',' '),7)
	if isnull(sPresup) then sPresup = space(7)
	sPresup = RightA(sPresup, 7)
	// N$$HEX1$$fa00$$ENDHEX$$mero de Viviendas sobre rasante
	NumSob = i_ds_lista.GetItemNumber(i,'fases_usos_plantas_sob')
	sNumSob = f_completar_con_caracteres(string(NumSob),2,'I',' ')
	if isnull(sNumSob) then sNumSob = space(2)
	sNumSob = LeftA(sNumSob, 2)
	// Superficie sobre rasante
	SupSob = i_ds_lista.GetItemNumber(i,'fases_usos_sup_sob')
	sSupSob = f_completar_con_caracteres(string(round(SupSob,0)),6,'I',' ')
	if isnull(sSupSob) then sSupSob = space(6)
	sSupSob = LeftA(sSupSob, 6)
	// Numero de Viviendas bajo rasante
	NumBaj = i_ds_lista.GetItemNumber(i,'fases_usos_plantas_baj')
	sNumBaj = f_completar_con_caracteres(string(NumBaj),1,'I',' ')
	if isnull(sNumBaj) then sNumBaj = space(1)
	sNumBaj = LeftA(sNumBaj, 1)
	// Superficie Bajo rasante
	SupBaj = i_ds_lista.GetItemNumber(i,'fases_usos_sup_baj')
	sSupBaj = f_completar_con_caracteres(string(round(SupBaj,0)),6,'I',' ')
	if isnull(sSupBaj) then sSupBaj = space(6)
	sSupBaj = LeftA(sSupBaj, 6)
	// Altura
	Altura = round(i_ds_lista.GetItemNumber(i,'fases_usos_altura'),0)
	sAltura = f_completar_con_caracteres(string(Altura),3,'I',' ')
	if isnull(sAltura) then sAltura = space(3)
	sAltura = LeftA(sAltura, 3)	
	// Medianeras	
	sMedianeras = i_ds_lista.GetItemString(i,'fases_usos_colindantes')
	if (sMedianeras<>'01' and sMedianeras<>'02' and sMedianeras<>'03') or isnull(sMedianeras) then sMedianeras = '0'
	if sMedianeras = '01' then sMedianeras = '0'
	if sMedianeras = '02' then sMedianeras = '1'
	if sMedianeras = '03' then sMedianeras = '2'
	sMedianeras = LeftA(sMedianeras, 1)		
	// Uso
	sUso = i_ds_lista.GetItemString(i,'fases_usos_uso')
	if (upper(sUso) <> "A") and (upper(sUso) <> "V") and (upper(sUso) <> "U") then sUso = "NNN"
	if upper(sUso) = "V" then sUso = "SNN"
	if upper(sUso) = "A" then sUso = "NSN"
	if upper(sUso) = "U" then sUso = "NNS"
	if isNULL(sUso) then sUso = "NNN"
	//Descripcion de las Obras
	sDesc = i_ds_lista.GetItemString(i,'fases_descripcion')
	if f_es_vacio(sDesc) then sDesc = ' '
	// Emplazamiento de la obra
	sEmp = i_ds_lista.GetItemString(i,'fases_emplazamiento')
	if f_es_vacio(sEmp) then sEmp = ' '
	// Tipo de la via del emplazamiento
	sViaEmp = i_ds_lista.GetItemString(i,'fases_tipo_via_emplazamiento')
	if f_es_vacio(sViaEmp) then sViaEmp = ' '
	// n$$HEX2$$ba002000$$ENDHEX$$del emplazamiento
	sNEmp = i_ds_lista.GetItemString(i,'fases_n_calle')
	if f_es_vacio(sNEmp) then sNEmp = space(2)
	// Contructor de la Obra
	sConsObra = i_ds_lista.GetItemString(i,'fases_finales_constructor_obras')
	if f_es_vacio(sConsObra) then sConsObra = ' '

	linea = sNumRegistro + sFecha + sCodigo + sPoblacion + sTipo + sNumRegistroAnt + sAnulado
	linea = linea + sFechaAbono + sTipoAct + sTipoObra + sDestino + sPromotor
	linea = linea + sNumEdif + sNumViv + sNumVivSub
	linea = linea + sSupTotal + sSupViv + sSupGar + sSupOtros + sPresup 
	linea = linea + sNumSob + sSupSob + sNumBaj + sSupBaj + sAltura
	linea = linea + sMedianeras + sUso
	linea = linea + sDesc + sViaEmp + sEmp + sNEmp + sConsObra

	FileWrite(fichero,linea)

	fila = dw_1.InsertRow(0)
	dw_1.SetItem(fila,'numcontrato',sNumRegistro)
	dw_1.SetItem(fila,'tipoact',i_ds_lista.GetItemString(i,'fases_fase'))	
	dw_1.SetItem(fila,'tipoobra',i_ds_lista.GetItemString(i,'fases_tipo_trabajo'))	
	dw_1.SetItem(fila,'numedif',sNumEdif)
	dw_1.SetItem(fila,'numviv',sNumViv)
	dw_1.SetItem(fila,'sup',string(round(SupTotal,0),"#,##0"))
	dw_1.SetItem(fila,'pem',string(Presup,"#,##0.0"))
	dw_1.SetItem(fila,'descripcion',sDesc)
	dw_1.SetItem(fila,'constructor_obras',sConsObra)
	dw_1.SetItem(fila,'tipo_via_emplazamiento',sViaEmp)
	dw_1.SetItem(fila,'emplazamiento',sEmp)
	dw_1.SetItem(fila,'n_calle',sNEmp)
Next
//messagebox('kk', string(len(linea)))
dw_1.of_setprintpreview(TRUE)
dw_1.event pfc_printpreview()
dw_1.visible = true
cb_3.visible = true

FileClose(fichero)

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02

end event

on w_fomento.create
int iCurrent
call super::create
this.rb_laboratorio=create rb_laboratorio
this.dw_1=create dw_1
this.cb_3=create cb_3
this.rb_contratos=create rb_contratos
this.rb_finales=create rb_finales
this.st_3=create st_3
this.cb_1=create cb_1
this.gb_1=create gb_1
this.cb_2=create cb_2
this.dw_consulta=create dw_consulta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_laboratorio
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.rb_contratos
this.Control[iCurrent+5]=this.rb_finales
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.dw_consulta
end on

on w_fomento.destroy
call super::destroy
destroy(this.rb_laboratorio)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.rb_contratos)
destroy(this.rb_finales)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.cb_2)
destroy(this.dw_consulta)
end on

event open;call super::open;this.of_setresize(true)
f_centrar_ventana(this)

//inv_resize.of_Register (cb_1, "FixedToRight")
//inv_resize.of_Register (cb_2, "FixedToRight&Bottom")
//inv_resize.of_Register (cb_3, "FixedToRight")
inv_resize.of_Register (dw_1, "ScaleToRight&Bottom")
inv_resize.of_Register (st_3, "FixedToBottom")

dw_consulta.InsertRow(0)
dw_consulta.SetFocus()

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
dw_consulta.setitem(1,'cod_colegio', g_cod_colegio)

i_ds_lista = create datastore

end event

event pfc_postopen();call super::pfc_postopen;//Recuperamos la consulta de Inicio en caso de que exista
This.Event csd_recuperar_consulta('INICIO')
end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_fomento
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_fomento
end type

type rb_laboratorio from radiobutton within w_fomento
integer x = 1701
integer y = 256
integer width = 530
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Laboratorio"
end type

type dw_1 from u_dw within w_fomento
boolean visible = false
integer x = 37
integer y = 612
integer width = 2821
integer height = 1248
integer taborder = 0
string dataobject = "dw_lst_incidencias_mopufinal"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type cb_3 from commandbutton within w_fomento
boolean visible = false
integer x = 2478
integer y = 304
integer width = 361
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
boolean default = true
end type

event clicked;dw_1.print()
end event

type rb_contratos from radiobutton within w_fomento
integer x = 1701
integer y = 100
integer width = 530
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Contratos Visados"
end type

type rb_finales from radiobutton within w_fomento
integer x = 1701
integer y = 180
integer width = 530
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Finales de Obra"
boolean checked = true
end type

type st_3 from statictext within w_fomento
integer x = 37
integer y = 1880
integer width = 251
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 8421504
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_fomento
integer x = 2478
integer y = 64
integer width = 361
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Generar"
boolean default = true
end type

event clicked;cb_3.visible = false
dw_1.visible = false
if rb_finales.checked then
	//Se unific$$HEX2$$f3002000$$ENDHEX$$c$$HEX1$$f300$$ENDHEX$$digo en una sola funci$$HEX1$$f300$$ENDHEX$$n (habian dos funciones practicamente iguales!)
	/*if g_colegio = 'COAATNA' then 
		parent.event csd_finalesobra_na()
	else*/
		parent.event csd_finalesobra()
	//end if
elseif rb_contratos.checked then
	parent.event csd_obras()
else
	parent.event csd_laboratorio()
end if

end event

type gb_1 from groupbox within w_fomento
integer x = 1637
integer y = 44
integer width = 658
integer height = 288
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Tipo Estad$$HEX1$$ed00$$ENDHEX$$stica"
end type

type cb_2 from commandbutton within w_fomento
integer x = 2478
integer y = 184
integer width = 361
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
boolean cancel = true
end type

event clicked;close(parent)

end event

type dw_consulta from u_dw within w_fomento
integer x = 37
integer y = 32
integer width = 2386
integer height = 516
integer taborder = 10
string dataobject = "d_consejo_consulta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
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

