HA$PBExportHeader$w_premaat_sabana.srw
forward
global type w_premaat_sabana from w_sheet
end type
type dw_listado from u_dw within w_premaat_sabana
end type
type cb_salir from u_cb within w_premaat_sabana
end type
type st_mensajes from u_st within w_premaat_sabana
end type
type cb_actualizar from u_cb within w_premaat_sabana
end type
type cb_listado from u_cb within w_premaat_sabana
end type
type cb_generar from u_cb within w_premaat_sabana
end type
type dw_lista from u_dw within w_premaat_sabana
end type
type st_mensajes2 from u_st within w_premaat_sabana
end type
type cb_generar_excel from u_cb within w_premaat_sabana
end type
type st_mensajes3 from u_st within w_premaat_sabana
end type
type cbx_version_sabana_premaat_mayo_2014 from checkbox within w_premaat_sabana
end type
type cbx_actualizar_bajas from checkbox within w_premaat_sabana
end type
type oleobject_1 from oleobject within w_premaat_sabana
end type
end forward

global type w_premaat_sabana from w_sheet
integer width = 4462
integer height = 1784
string title = "S$$HEX1$$e100$$ENDHEX$$bana Premaat"
boolean controlmenu = false
windowstate windowstate = maximized!
event type integer csd_borrar_conceptos_domiciliables ( )
event type integer csd_validar_datos ( )
event type integer csd_generar_cuotas_sabana ( string docname,  integer value )
event type integer csd_generar_cuotas_excel ( string docname,  integer value )
dw_listado dw_listado
cb_salir cb_salir
st_mensajes st_mensajes
cb_actualizar cb_actualizar
cb_listado cb_listado
cb_generar cb_generar
dw_lista dw_lista
st_mensajes2 st_mensajes2
cb_generar_excel cb_generar_excel
st_mensajes3 st_mensajes3
cbx_version_sabana_premaat_mayo_2014 cbx_version_sabana_premaat_mayo_2014
cbx_actualizar_bajas cbx_actualizar_bajas
oleobject_1 oleobject_1
end type
global w_premaat_sabana w_premaat_sabana

type variables
int i_generadas=0,i_falladas=0
u_dw idw_lista

end variables

forward prototypes
public subroutine f_mensaje_pantalla (string mensaje)
public subroutine wf_preemat_colegiado_alta (string ident_colegiado, ref boolean baja, ref date fecha_alta)
end prototypes

event type integer csd_borrar_conceptos_domiciliables();//Datastore ds_musaat
//long ll_nbr, i
//string fp, concepto
//
//ds_musaat = create datastore
//ds_musaat.DataObject = 'd_musaat_calculo_recibos'
//ds_musaat.SetTransObject(sqlca)	
//ds_musaat.Retrieve(g_codigos_conceptos.musaat_fija_plazo1,g_codigos_conceptos.musaat_fija_plazo2)
//
//ll_nbr = ds_musaat.RowCount()
//
//f_mensaje_pantalla('Inicio borrado...')
//FOR  i = ll_nbr TO 1 STEP -1
//	ds_musaat.DeleteRow(i)
//NEXT
//
//ds_musaat.Update()
//f_mensaje_pantalla('Fin borrado...')
//destroy ds_musaat
//
//return 1
//

delete from conceptos_domiciliables where concepto like '150%' ;

return 1

end event

event type integer csd_validar_datos();////Validamos que no haya claves primarias repetidas
////15/Feb:Tambi$$HEX1$$e900$$ENDHEX$$n validamos que no haya filas con n_colegiado vac$$HEX1$$ed00$$ENDHEX$$o
////Devuelve: 1 si hay claves primarias repetidas
////				0 si no hay
//
//st_buscar_duplicados_pk_2 lst_duplicados[]
//st_array_bd_pk_2 lst_retorno
long ll_tamanyoarray,i
string ls_mensaje,ls_concepto
int li_valorretorno
//
//lst_retorno=f_buscar_duplicados_pk_2(dw_lista,'nif_fichero','concepto')
//
//lst_duplicados=lst_retorno.vector
//
//ll_tamanyoarray=upperbound(lst_duplicados)
//
//if ll_tamanyoarray>0 then
//	ls_mensaje='los siguientes pares de columnas est$$HEX1$$e100$$ENDHEX$$n repetidas'
//	for i=1 to ll_tamanyoarray
//		select descripcion into :ls_concepto from csi_articulos_servicios where codigo=:lst_duplicados[i].col2;
//		ls_mensaje=ls_mensaje+cr+lst_duplicados[i].col1+','+ls_concepto
//	next
//	ls_mensaje+=cr+' Ha de eliminar las filas duplicadas antes de poder guardar los datos'
//	MessageBox(g_titulo,ls_mensaje,StopSign!)
//	li_valorretorno=1
//else
//	li_valorretorno=0
//end if

//comprobamos que no haya n_colegiado vac$$HEX1$$ed00$$ENDHEX$$os
string ls_ncolegiado
long ll_numfilasvacias
boolean lb_hayfallos=false

ls_mensaje=g_idioma.of_getmsg('premaat.vacia_fila_col','Las siguientes filas tienen vac$$HEX1$$ed00$$ENDHEX$$a la columna "N$$HEX2$$ba002000$$ENDHEX$$colegiado", no podr$$HEX2$$e1002000$$ENDHEX$$guardar los datos hasta que corrija esta situaci$$HEX1$$f300$$ENDHEX$$n:')+cr

for i=1 to dw_lista.rowcount()
	ls_ncolegiado=dw_lista.getitemstring(i,'num_col')
	if ls_ncolegiado='' then
		lb_hayfallos=true
		ll_numfilasvacias++
		ls_mensaje+=dw_lista.getitemstring(i,'nif_fichero')+cr
	end if
	//S$$HEX1$$f300$$ENDHEX$$lo reportamos las 10 primeras filas err$$HEX1$$f300$$ENDHEX$$neas
	if ll_numfilasvacias>10 then
		ls_mensaje+='...'
		exit
	end if
next

if lb_hayfallos=true then
	li_valorretorno=1
	Messagebox(g_titulo,ls_mensaje,StopSign!)
end if

return li_valorretorno

end event

event type integer csd_generar_cuotas_sabana(string docname, integer value);oleobject excel_oleobject
double campo_imp, imp
long i, fila_insertada, dup, ll_contar_baja
string campo, colegiado, campo_nif, conc, n_colegiado, campo_nom, campo_mut, campo_grup, campo_ape1, campo_ape2, datos_fichero
double campo_com, campo_ips, campo_ccs, campo_tot
date    ld_fecha_alta
boolean  lb_baja= false
datetime campo_fecha

dw_listado.ShareDataoff()

i = 2
excel_oleobject = CREATE OLEObject

if excel_oleobject.ConnectToNewObject("excel.application") <> 0 then
 messagebox("Error","Microsoft Excel is not supported on your computer")
 return 1
end if

excel_oleobject.Application.Workbooks.Open(docname)
excel_oleobject.Application.Visible = False
excel_oleobject.windowstate = 2 // 1 : Normal, 2 : Minimize, 3 : Maximize

/*Set Focus to the top left cell of this spreadsheet.*/
excel_oleobject.Application.Range("A1").Select()


f_mensaje_pantalla('Inicio generaci$$HEX1$$f300$$ENDHEX$$n...')

dw_lista.setredraw(false)

campo = string(excel_oleobject.Application.Cells(i, 1).Value)
//ll_contar_baja = 0//contador para colegiados de baja

DO WHILE campo <> '' and (not isnull(campo))
	setpointer(hourglass!)

	IF cbx_version_sabana_premaat_mayo_2014.checked = False THEN // SCP-2397
		campo_nif = trim(string(excel_oleobject.Application.Cells(i, 10).Value))
		campo_mut = trim(string(excel_oleobject.Application.Cells(i, 11).Value))	
		campo_nom = trim(string(excel_oleobject.Application.Cells(i, 12).Value))	
		campo_ape1 = trim(string(excel_oleobject.Application.Cells(i, 13).Value))	
		campo_ape2 = trim(string(excel_oleobject.Application.Cells(i, 14).Value))		
		campo_grup = lower(trim(string(excel_oleobject.Application.Cells(i, 16).Value)))
		campo_ccs = double(excel_oleobject.Application.Cells(i, 36).Value)
		campo_ips = double(excel_oleobject.Application.Cells(i, 37).Value)
		campo_tot = double(excel_oleobject.Application.Cells(i, 4).Value)
		campo_fecha = datetime(excel_oleobject.Application.Cells(i, 1).Value)
	ELSE
		campo_nif = trim(string(excel_oleobject.Application.Cells(i, 11).Value))
		campo_mut = trim(string(excel_oleobject.Application.Cells(i, 7).Value))	
		campo_nom = trim(string(excel_oleobject.Application.Cells(i, 12).Value))	
		campo_ape1 = trim(string(excel_oleobject.Application.Cells(i, 13).Value))	
		campo_ape2 = ''
//		campo_grup = trim(string(excel_oleobject.Application.Cells(i, 8).Value))	
		campo_grup = lower(left(trim(string(excel_oleobject.Application.Cells(i, 8).Value)), 2))
		campo_ccs = 0
		campo_ips = double(excel_oleobject.Application.Cells(i, 18).Value)
		campo_tot = double(excel_oleobject.Application.Cells(i, 3).Value)
		campo_fecha = datetime(excel_oleobject.Application.Cells(i, 5).Value)
		
		choose case campo_grup
				case 'gk'
					campo_grup = '2k'
				case 'cp'
					campo_grup = 'c1'
				case 'pv'
					campo_grup = 'sv'
				case 'pa'
					campo_grup = 'Ac'
		end choose				
		
	END IF
	
	if isnull(campo_tot) or campo_tot = 0 then 
		i = i + 1
		continue
	end if

	// Buscamos el colegiado por el nif
	colegiado = f_devuelve_id_col_de_nif(campo_nif)
	// Si no lo encuentra por el nif buscamos por el numero de mutualista
	if f_es_vacio(colegiado) then colegiado = f_premaat_id_col_de_num_mutualista(campo_mut)
	
	// Si no hay forma de encontrarlo, informamos
	datos_fichero = ''
	if f_es_vacio(colegiado) then	
		datos_fichero = campo_ape1 + " " + campo_ape2 + ", " + campo_nom + " (NIF: " + campo_nif + "; N$$HEX2$$ba002000$$ENDHEX$$Mut.: " + campo_mut + ")" //+ " - N$$HEX2$$ba002000$$ENDHEX$$Pol.: " + campo_pol + ")"
		i_falladas++
	else
		i_generadas++
	end if
	n_colegiado = f_colegiado_n_col(colegiado)	
	
	/*	*/
	if n_colegiado<> '' then
		long existe
		string id_premaat, cod_grupo, cod_grupo_comple1
		select count(n_col) into :existe from premaat where n_col = :n_colegiado;
	
		if isnull(existe) then existe= 0
		
		if existe=0 then
			id_premaat =  f_siguiente_numero('PREMAAT', 10)
			
			choose case campo_grup
				case 'ba'
					cod_grupo= 'A'
				case '2k'
					cod_grupo= 'C'
				case 'c1'
					cod_grupo= 'A'
					cod_grupo_comple1 = 'S'
				case 'pr'
					cod_grupo= 'Pr'
				case 'aj'
					cod_grupo= 'Aj'
				case 'b+'
					cod_grupo= 'B+'	
				case else
					cod_grupo= 'N'
			end choose
		INSERT INTO premaat  
				( id_premaat,     id_col,   n_col,    n_mutualista,    nif,                
				  grupo,   f_alta,      grupo_comple1,  alta      )  
		VALUES (:id_premaat,  :colegiado,  :n_colegiado,   :campo_mut, :campo_nif,         :cod_grupo,   
				  :campo_fecha,        :cod_grupo_comple1,  'S'         )  ;
		
		end if
	end if
	/* */
	
	// Si hay m$$HEX1$$e100$$ENDHEX$$s de una l$$HEX1$$ed00$$ENDHEX$$nea para el mismo colegiado sumamos los importes y no insertamos
	dup = dw_lista.find ("id_colegiado<>'' and id_colegiado='"+colegiado+"' and concepto='150"+WordCap	(campo_grup)+"'" , 1, dw_lista.rowcount())
	if dup > 0 then
		imp = dw_lista.getitemnumber(dup, 'importe')
		dw_lista.setitem(dup, 'importe', imp + campo_tot)
	else
		//Se env$$HEX1$$ed00$$ENDHEX$$a a la funci$$HEX1$$f300$$ENDHEX$$n wf_preemat_colegiado_alta para verificar si est$$HEX2$$e1002000$$ENDHEX$$de alta o de baja el colegiado
		wf_preemat_colegiado_alta(colegiado,lb_baja, ld_fecha_alta)
		
		if (cbx_actualizar_bajas.checked = false) and (lb_baja = true) then 
     		ll_contar_baja = ll_contar_baja + 1
		else 
			// Vamos insertando las domiciliaciones
			fila_insertada = dw_lista.insertrow(0)
			
			if isnull(ld_fecha_alta) or ld_fecha_alta = date('01/01/1900') then
				dw_lista.setitem(fila_insertada, 'f_inicio', campo_fecha)// Se inserta la fecha en caso de que sea nula en el colegiado
			end if
			
			dw_lista.setitem(fila_insertada, 'id_colegiado', colegiado)
			dw_lista.setitem(fila_insertada, 'concepto', '150'+WordCap(campo_grup))
			dw_lista.setitem(fila_insertada, 'importe', campo_tot)
			dw_lista.setitem(fila_insertada, 'empresa', f_obtener_empresa_articulo('150'+WordCap(campo_grup)))			

			// Obtenemos la forma de pago que tuviera para este concepto anteriormente, si no se pone DB por defecto
			string cod_conc, forma_pago
			cod_conc = '150'+campo_grup
			SELECT conceptos_domiciliables.forma_de_pago  INTO :forma_pago  FROM conceptos_domiciliables  
			WHERE ( conceptos_domiciliables.id_colegiado = :colegiado ) AND ( conceptos_domiciliables.concepto = :cod_conc )   ;
			
			if f_es_vacio(forma_pago) then forma_pago = 'DB'	
			dw_lista.setitem(fila_insertada, 'forma_de_pago',forma_pago)
			
			dw_lista.setitem(fila_insertada, 'nif_fichero', datos_fichero)
			dw_lista.setitem(fila_insertada, 'num_col', n_colegiado)
			dw_lista.setitem(fila_insertada, 'es_extra', 'N')				
	//		dw_lista.setitem(fila_insertada, 'nif', campo_nif)
	//		dw_lista.setitem(fila_insertada, 'num_mut', campo_mut)
	//		dw_lista.setitem(fila_insertada, 'grupo', campo_grup)
	//		dw_lista.setitem(fila_insertada, 'comercial', campo_com)
			dw_lista.setitem(fila_insertada, 'ips', campo_ips)
			dw_lista.setitem(fila_insertada, 'ccs', campo_ccs)
	//		dw_lista.setitem(fila_insertada, 'total', campo_tot)
	//		dw_lista.setitem(fila_insertada, 'datos_fichero', datos_fichero)
		end if
	end if
	i = i + 1
	campo = string(excel_oleobject.Application.Cells(i, 1).Value)
	f_mensaje_pantalla('Leyendo fichero........' + string(i))	
LOOP
setpointer(arrow!)
dw_lista.setredraw(TRUE)

st_mensajes3.text ='N$$HEX2$$ba002000$$ENDHEX$$Colegiados de Baja  : '+string(ll_contar_baja)

// Cerramos el fichero
excel_oleobject.Application.Workbooks.Close()

// disconnect from Excel
excel_oleobject.DisconnectObject()

// destroy your object
DESTROY excel_oleobject

dw_lista.ShareData(dw_listado)

cb_listado.enabled = true
cb_actualizar.enabled = true

return 1

end event

event type integer csd_generar_cuotas_excel(string docname, integer value);oleobject excel_oleobject
double campo_imp, imp
long i, fila_insertada, dup
string campo, colegiado, campo_nif, conc, n_colegiado, campo_nom, campo_mut, campo_grup, campo_ape1, campo_ape2, datos_fichero
double campo_com, campo_ips, campo_ccs, campo_tot

dw_listado.ShareDataoff()

i = 2
excel_oleobject = CREATE OLEObject

if excel_oleobject.ConnectToNewObject("excel.application") <> 0 then
 messagebox("Error","Microsoft Excel is not supported on your computer")
 return 1
end if

excel_oleobject.Application.Workbooks.Open(docname)
excel_oleobject.Application.Visible = False
excel_oleobject.windowstate = 2 // 1 : Normal, 2 : Minimize, 3 : Maximize

/*Set Focus to the top left cell of this spreadsheet.*/
excel_oleobject.Application.Range("A1").Select()


f_mensaje_pantalla('Inicio generaci$$HEX1$$f300$$ENDHEX$$n...')

campo = string(excel_oleobject.Application.Cells(i, 1).Value)
DO WHILE campo <> '' and (not isnull(campo))
	campo_nif = trim(string(excel_oleobject.Application.Cells(i, 1).Value))
	campo_mut = trim(string(excel_oleobject.Application.Cells(i, 2).Value))	
	campo_nom = trim(string(excel_oleobject.Application.Cells(i, 3).Value))	
	campo_ape1 = trim(string(excel_oleobject.Application.Cells(i, 4).Value))	
	campo_ape2 = trim(string(excel_oleobject.Application.Cells(i, 5).Value))		
	campo_grup = trim(string(excel_oleobject.Application.Cells(i, 6).Value))		
	campo_ips = double(excel_oleobject.Application.Cells(i, 7).Value)
	campo_ccs = double(excel_oleobject.Application.Cells(i, 8).Value)
	campo_tot = double(excel_oleobject.Application.Cells(i, 9).Value)

	if isnull(campo_tot) or campo_tot = 0 then 
		i = i + 1
		continue
	end if

	// Buscamos el colegiado por el nif
	colegiado = f_devuelve_id_col_de_nif(campo_nif)
	// Si no lo encuentra por el nif buscamos por el numero de mutualista
	if f_es_vacio(colegiado) then colegiado = f_premaat_id_col_de_num_mutualista(campo_mut)
	
	// Si no hay forma de encontrarlo, informamos
	datos_fichero = ''
	if f_es_vacio(colegiado) then	
		datos_fichero = campo_ape1 + " " + campo_ape2 + ", " + campo_nom + " (NIF: " + campo_nif + "; N$$HEX2$$ba002000$$ENDHEX$$Mut.: " + campo_mut + ")" //+ " - N$$HEX2$$ba002000$$ENDHEX$$Pol.: " + campo_pol + ")"
		i_falladas++
	else
		i_generadas++
	end if
	n_colegiado = f_colegiado_n_col(colegiado)	
	
	// Si hay m$$HEX1$$e100$$ENDHEX$$s de una l$$HEX1$$ed00$$ENDHEX$$nea para el mismo colegiado sumamos los importes y no insertamos
	dup = dw_lista.find ("id_colegiado<>'' and id_colegiado='"+colegiado+"' and concepto='150"+campo_grup+"'" , 1, dw_lista.rowcount())
	if dup > 0 then
		imp = dw_lista.getitemnumber(dup, 'importe')
		dw_lista.setitem(dup, 'importe', imp + campo_tot)
	else
		// Vamos insertando las domiciliaciones
		fila_insertada = dw_lista.insertrow(0)
		dw_lista.setitem(fila_insertada, 'id_colegiado', colegiado)
		dw_lista.setitem(fila_insertada, 'concepto', '150'+campo_grup)
		dw_lista.setitem(fila_insertada, 'empresa', f_obtener_empresa_articulo('150'+campo_grup))
		dw_lista.setitem(fila_insertada, 'importe', campo_tot)
		dw_lista.setitem(fila_insertada, 'forma_de_pago', 'DB')
		dw_lista.setitem(fila_insertada, 'nif_fichero', datos_fichero)
		dw_lista.setitem(fila_insertada, 'num_col', n_colegiado)
		dw_lista.setitem(fila_insertada, 'es_extra', 'N')				
		dw_lista.setitem(fila_insertada, 'ips', campo_ips)
		dw_lista.setitem(fila_insertada, 'ccs', campo_ccs)
	end if
	i = i + 1
	campo = string(excel_oleobject.Application.Cells(i, 1).Value)
LOOP

// Cerramos el fichero
excel_oleobject.Application.Workbooks.Close()

// disconnect from Excel
excel_oleobject.DisconnectObject()

// destroy your object
DESTROY excel_oleobject

dw_lista.ShareData(dw_listado)

cb_listado.enabled = true
cb_actualizar.enabled = true

return 1

end event

public subroutine f_mensaje_pantalla (string mensaje);st_mensajes.Text = mensaje
end subroutine

public subroutine wf_preemat_colegiado_alta (string ident_colegiado, ref boolean baja, ref date fecha_alta);//FUNCION QUE VERIFICA SI EL COLEGIADO EST$$HEX2$$c1002000$$ENDHEX$$DE BAJA	 O NO
string   ls_altabaja
datetime ldt_alta
  
  SELECT colegiados.alta_baja, colegiados.f_alta  
    INTO :ls_altabaja,  
	        :ldt_alta
    FROM colegiados  
   WHERE colegiados.id_colegiado = :ident_colegiado   ;

if isnull(ls_altabaja) then
	baja = true
	fecha_alta = date(today())
else
	if  ls_altabaja = 'N' then // est$$HEX2$$e1002000$$ENDHEX$$de baja por lo tanto no debe seterasele ning$$HEX1$$fa00$$ENDHEX$$n valor al colegiado
		baja = true
	else
		baja = false
	end if
	fecha_alta = date(ldt_alta)
end if


end subroutine

on w_premaat_sabana.create
int iCurrent
call super::create
this.dw_listado=create dw_listado
this.cb_salir=create cb_salir
this.st_mensajes=create st_mensajes
this.cb_actualizar=create cb_actualizar
this.cb_listado=create cb_listado
this.cb_generar=create cb_generar
this.dw_lista=create dw_lista
this.st_mensajes2=create st_mensajes2
this.cb_generar_excel=create cb_generar_excel
this.st_mensajes3=create st_mensajes3
this.cbx_version_sabana_premaat_mayo_2014=create cbx_version_sabana_premaat_mayo_2014
this.cbx_actualizar_bajas=create cbx_actualizar_bajas
this.oleobject_1=create oleobject_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_listado
this.Control[iCurrent+2]=this.cb_salir
this.Control[iCurrent+3]=this.st_mensajes
this.Control[iCurrent+4]=this.cb_actualizar
this.Control[iCurrent+5]=this.cb_listado
this.Control[iCurrent+6]=this.cb_generar
this.Control[iCurrent+7]=this.dw_lista
this.Control[iCurrent+8]=this.st_mensajes2
this.Control[iCurrent+9]=this.cb_generar_excel
this.Control[iCurrent+10]=this.st_mensajes3
this.Control[iCurrent+11]=this.cbx_version_sabana_premaat_mayo_2014
this.Control[iCurrent+12]=this.cbx_actualizar_bajas
end on

on w_premaat_sabana.destroy
call super::destroy
destroy(this.dw_listado)
destroy(this.cb_salir)
destroy(this.st_mensajes)
destroy(this.cb_actualizar)
destroy(this.cb_listado)
destroy(this.cb_generar)
destroy(this.dw_lista)
destroy(this.st_mensajes2)
destroy(this.cb_generar_excel)
destroy(this.st_mensajes3)
destroy(this.cbx_version_sabana_premaat_mayo_2014)
destroy(this.cbx_actualizar_bajas)
destroy(this.oleobject_1)
end on

event open;call super::open;of_SetResize (true)

//DesHabilitamos botones antes de Generar
cb_listado.enabled = false
cb_actualizar.enabled = false

inv_resize.of_Register (dw_lista, "ScaletoRight&Bottom")
inv_resize.of_Register (cb_salir, "FixedtoRight")

end event

event closequery;//SOBREESCRITO
return 0
end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_premaat_sabana
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_premaat_sabana
end type

type dw_listado from u_dw within w_premaat_sabana
boolean visible = false
integer x = 3927
integer y = 1060
integer taborder = 10
string dataobject = "d_premaat_sabana_listado"
end type

type cb_salir from u_cb within w_premaat_sabana
integer x = 3858
integer y = 8
integer width = 503
integer height = 96
integer taborder = 40
string text = "&Salir"
end type

event clicked;call super::clicked;close(Parent)
end event

type st_mensajes from u_st within w_premaat_sabana
integer x = 2702
integer y = 24
integer width = 1074
integer height = 60
integer weight = 700
fontcharset fontcharset = ansi!
long textcolor = 8388736
string text = ""
end type

type cb_actualizar from u_cb within w_premaat_sabana
string tag = "texto=cobros.actualizar_datos"
integer x = 1097
integer y = 8
integer width = 503
integer height = 96
integer taborder = 60
string text = "Actualizar datos"
end type

event clicked;call super::clicked;integer Net,li_resValidar,i

Net = MessageBox(g_idioma.of_getmsg('cobros.actualizar_datos',"Actualizar Datos"),g_idioma.of_getmsg('premaat.borrar_cuotas',"Se borrar$$HEX1$$e100$$ENDHEX$$n las cuotas anteriores, $$HEX1$$bf00$$ENDHEX$$Desea actualizar las cuotas? "), Question!, OKCancel!, 1)

IF Net = 1 THEN
	
   li_resValidar=event	csd_validar_datos()
	if li_resValidar=1 then
		//Si hay datos repetidos no permitimos que se guarden los datos
		if MessageBox(g_idioma.of_getmsg('cobros.actualizar_datos',"Actualizar Datos"),g_idioma.of_getmsg('premaat.continuar_actualizacion',"Desea continuar, $$HEX1$$bf00$$ENDHEX$$Desea actualizar las cuotas? "), Question!, OKCancel!, 1) = 1 then
			//dw_lista.setfilter("num_col<>'' or not isnull(num_col)")
			//dw_lista.filter()
			for i=1 to dw_lista.rowcount() 
				if (f_es_vacio(dw_lista.getitemstring(i, 'num_col'))) then 
					dw_lista.deleterow(i)
					i = i - 1
				end if
			next 	
		else
				return -1
		end if
	end if
	// Fase 0 : Borrando cuotas anteriores
	parent.event csd_borrar_conceptos_domiciliables()

	// Fase 1 : Grabando nuevas cuotas
	f_mensaje_pantalla('Grabando datos...')
	st_mensajes2.text = ''
	for i=1 to dw_lista.rowcount() 
		if (f_es_vacio(dw_lista.getitemstring(i, 'empresa'))) then 
			dw_lista.setitem(i,'empresa',g_empresa)	
		end if	
	next
	dw_lista.update()

	// Fase 2: inhabiliatacion de la botonera
	cb_listado.enabled = false
	cb_actualizar.enabled = false
	f_mensaje_pantalla('Datos actualizados.')

	return 1
end if

return -1

end event

type cb_listado from u_cb within w_premaat_sabana
integer x = 562
integer y = 8
integer width = 503
integer height = 96
integer taborder = 10
string text = "Listado"
end type

event clicked;call super::clicked;integer Net

Net = MessageBox(g_idioma.of_getmsg('general.imprimir_listado',"Imprimir Listado"),g_idioma.of_getmsg('general.imprimir_listado_pregunta',"$$HEX1$$bf00$$ENDHEX$$Desea imprimir el listado? "), Question!, OKCancel!, 1)

IF Net = 1 THEN
	dw_listado.print()
end if

end event

type cb_generar from u_cb within w_premaat_sabana
string tag = "texto=premaat.imp_sabana"
integer x = 27
integer y = 8
integer width = 503
integer height = 96
integer taborder = 70
string text = "Importar S$$HEX1$$e100$$ENDHEX$$bana"
end type

event clicked;call super::clicked;string docname,named,extension
integer value

i_generadas=0
i_falladas=0

dw_lista.reset()

n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()

st_mensajes.text = ''
st_mensajes2.text = ''

value = GetFileOpenName("Selecione Fichero de Sabana.", docname, named, "XLS", "Excel Files (*.XLS),*.XLS")
		
extension = RightA(named,3)

if lower(extension) = 'xls' then	Parent.trigger event csd_generar_cuotas_sabana(docname,value)

// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio

st_mensajes.text = 'Generadas : '+string(i_generadas)+ ' cuotas.'
st_mensajes2.text ='Falladas  : '+string(i_falladas)+ ' cuotas.'

end event

type dw_lista from u_dw within w_premaat_sabana
integer x = 27
integer y = 232
integer width = 4334
integer height = 1436
integer taborder = 30
string dataobject = "d_premaat_calculo_recibos"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)
this.of_SetTransObject(SQLCA)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

// Enable printpreview service
of_SetPrintPreview (true)
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_debug.enabled = False
am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
end event

event buttonclicked;call super::buttonclicked;string id_col, n_mut, n_pol, pref

g_busqueda.titulo="Seleccionar colegiado"
g_busqueda.dw="d_lista_busqueda_colegiados"
id_col=f_busqueda_colegiados()
if f_es_vacio(id_col) then return


end event

type st_mensajes2 from u_st within w_premaat_sabana
integer x = 2702
integer y = 92
integer width = 1074
integer height = 60
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
long textcolor = 8388736
string text = ""
end type

type cb_generar_excel from u_cb within w_premaat_sabana
string tag = "texto=imp_excel"
integer x = 27
integer y = 116
integer width = 503
integer height = 96
integer taborder = 50
boolean bringtotop = true
string text = "Importar Excel"
end type

event clicked;call super::clicked;string docname,named,extension
integer value

i_generadas=0
i_falladas=0

dw_lista.reset()

n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()

st_mensajes.text = ''
st_mensajes2.text = ''

value = GetFileOpenName("Selecione Fichero Excel", docname, named, "XLS", "Excel Files (*.XLS),*.XLS")
		
extension = RightA(named,3)

if lower(extension) = 'xls' then	Parent.trigger event csd_generar_cuotas_excel(docname,value)

// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio

st_mensajes.text = 'Generadas : '+string(i_generadas)+ ' cuotas.'
st_mensajes2.text ='Falladas  : '+string(i_falladas)+ ' cuotas.'

end event

type st_mensajes3 from u_st within w_premaat_sabana
integer x = 2702
integer y = 160
integer width = 1074
integer height = 60
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
long textcolor = 8388736
string text = ""
end type

type cbx_version_sabana_premaat_mayo_2014 from checkbox within w_premaat_sabana
integer x = 562
integer y = 124
integer width = 1029
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nueva Versi$$HEX1$$f300$$ENDHEX$$n Fichero PREMAAT"
boolean checked = true
end type

type cbx_actualizar_bajas from checkbox within w_premaat_sabana
integer x = 1632
integer y = 124
integer width = 1029
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Actualizar colegiados de baja"
end type

type oleobject_1 from oleobject within w_premaat_sabana descriptor "pb_nvo" = "true" 
end type

on oleobject_1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on oleobject_1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

