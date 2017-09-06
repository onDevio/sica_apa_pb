HA$PBExportHeader$w_musaat_calculo_recibos.srw
forward
global type w_musaat_calculo_recibos from w_sheet
end type
type dw_listado from u_dw within w_musaat_calculo_recibos
end type
type cb_salir from u_cb within w_musaat_calculo_recibos
end type
type st_mensajes from u_st within w_musaat_calculo_recibos
end type
type cb_actualizar from u_cb within w_musaat_calculo_recibos
end type
type cb_listado from u_cb within w_musaat_calculo_recibos
end type
type cb_generar from u_cb within w_musaat_calculo_recibos
end type
type dw_datos_mensual from u_dw within w_musaat_calculo_recibos
end type
type dw_lista from u_dw within w_musaat_calculo_recibos
end type
type st_mensajes2 from u_st within w_musaat_calculo_recibos
end type
type oleobject_1 from oleobject within w_musaat_calculo_recibos
end type
end forward

global type w_musaat_calculo_recibos from w_sheet
integer x = 214
integer y = 221
integer width = 4462
integer height = 2020
string title = "Actualizar Domiciliaciones de MUSAAT"
boolean controlmenu = false
windowstate windowstate = maximized!
event type integer csd_borrar_conceptos_domiciliables ( )
event type integer csd_generar_conceptos_domiciliables ( string docname,  integer value )
event type integer csd_generar_conceptos_domiciliables_xls ( string docname,  integer value )
event type integer csd_validar_datos ( )
event type integer csd_generar_conceptos_domiciliables_alt ( string docname,  integer value )
event type integer csd_generar_cuotas_xls_2007 ( string docname,  integer value )
event type integer csd_generar_cuotas_txt_2007 ( string docname,  integer value )
dw_listado dw_listado
cb_salir cb_salir
st_mensajes st_mensajes
cb_actualizar cb_actualizar
cb_listado cb_listado
cb_generar cb_generar
dw_datos_mensual dw_datos_mensual
dw_lista dw_lista
st_mensajes2 st_mensajes2
oleobject_1 oleobject_1
end type
global w_musaat_calculo_recibos w_musaat_calculo_recibos

type variables
int i_generadas=0,i_falladas=0
u_dw idw_lista

end variables

forward prototypes
public subroutine f_mensaje_pantalla (string mensaje)
end prototypes

event type integer csd_borrar_conceptos_domiciliables();Datastore ds_musaat
long ll_nbr, i
string fp, concepto

ds_musaat = create datastore
ds_musaat.DataObject = 'd_musaat_calculo_recibos'
ds_musaat.SetTransObject(sqlca)	
// Primero plazo 1
ds_musaat.Retrieve(g_codigos_conceptos.musaat_fija_plazo1, g_empresa)

ll_nbr = ds_musaat.RowCount()
f_mensaje_pantalla('Inicio borrando domiciliaciones MUSAAT...')
FOR  i = ll_nbr TO 1 STEP -1
	ds_musaat.DeleteRow(i)
NEXT
ds_musaat.Update()

// Ahora plazo 2
ds_musaat.Retrieve(g_codigos_conceptos.musaat_fija_plazo2, g_empresa)
ll_nbr = ds_musaat.RowCount()
FOR  i = ll_nbr TO 1 STEP -1
	ds_musaat.DeleteRow(i)
NEXT
ds_musaat.Update()

f_mensaje_pantalla('Fin borrando domiciliaciones MUSAAT...')
destroy ds_musaat

return 1

end event

event type integer csd_generar_conceptos_domiciliables(string docname, integer value);//integer nfile, fila_insertada, i=1
//string tupla, colegiado, campo_nif, campo_ase, campo_plz, campo_pla, conc, forma_pago
//string n_colegiado
//double campo_imp
//
//dw_listado.ShareDataoff()
//
//IF value = 1 THEN
//	f_mensaje_pantalla('Inicio generaci$$HEX1$$f300$$ENDHEX$$n...')
//
//	nfile = FileOpen(docname, LineMode!, Read!, LockWrite!)
//   value = FileRead(nfile, tupla)
//
//	DO WHILE value >= 0
//		setpointer(hourglass!)
//		campo_nif = Trim(MidA(tupla,15,9))
//		campo_pla = Trim(MidA(tupla,180,1))
//		campo_imp = double(Trim(MidA(tupla,197,8)+','+MidA(tupla,206,2)))
//		campo_plz = RightA('00000000' + Trim(MidA(tupla,3,6)) , 8)
//		campo_ase = RightA('00000000' + Trim(MidA(tupla,9,6)) , 8)
//
//		choose case campo_pla
//			case '1'
//				conc = g_codigos_conceptos.musaat_fija_plazo1
//			case '2'
//				conc = g_codigos_conceptos.musaat_fija_plazo2
//		end choose
//
//		if not f_es_vacio(campo_nif) then // Si la linea es vacia no hacemos nada
//			// Buscamos el colegiado por el nif
//			colegiado = f_devuelve_id_col_de_nif(campo_nif)
//			// Si no lo encuentra por el nif buscamos por el numero de mutualista
//			if f_es_vacio(colegiado) then colegiado = f_musaat_id_col_de_num_mutualista(campo_ase)
//
//			// Y si aun no lo ha encontrado buscamos por el numero de p$$HEX1$$f300$$ENDHEX$$liza
//			if f_es_vacio(colegiado) then colegiado = f_musaat_devuelve_id_col(campo_plz)
//
//			//Modificado Andr$$HEX1$$e900$$ENDHEX$$s 2/2/2005
//			//buscamos el n$$HEX1$$fa00$$ENDHEX$$mero de colegiado ahora. Antes estaba en un campo calculado en el dw
//			//y ralentizaba la ordenaci$$HEX1$$f300$$ENDHEX$$n
//			n_colegiado=f_colegiado_n_col(colegiado)
//
//			// Vamos insertando las domiciliaciones
//			fila_insertada = dw_lista.insertrow(0)
//			dw_lista.setitem(fila_insertada, 'id_colegiado', colegiado)
//			dw_lista.setitem(fila_insertada, 'concepto', conc)
//			dw_lista.setitem(fila_insertada, 'importe', campo_imp)
//			// Obtenemos la forma de pago que tuviera para este concepto anteriormente, si no se pone DB por defecto
//			SELECT conceptos_domiciliables.forma_de_pago  	INTO :forma_pago  FROM conceptos_domiciliables  
//			WHERE ( conceptos_domiciliables.id_colegiado = :colegiado ) AND ( conceptos_domiciliables.concepto = :conc )   ;
//			
//			if f_es_vacio(forma_pago) then forma_pago = 'DB'
//			
//			dw_lista.setitem(fila_insertada, 'forma_de_pago', forma_pago)
//			dw_lista.setitem(fila_insertada, 'nif_fichero', campo_nif) 
//			dw_lista.setitem(fila_insertada, 'num_col', n_colegiado) 
//		end if
//		value = FileRead(nfile, tupla)
//		f_mensaje_pantalla('Leyendo fichero........' + string(i))
//	LOOP
//	f_mensaje_pantalla('Fin generaci$$HEX1$$f300$$ENDHEX$$n.')
//	cb_listado.enabled = true
//	cb_actualizar.enabled = true
//	FileClose(nfile)
//end if
//setpointer(arrow!)
//dw_lista.setredraw(true)
//
//dw_lista.ShareData(dw_listado)
//
return 0
//
end event

event type integer csd_generar_conceptos_domiciliables_xls(string docname, integer value);double c_imp_recibo, c_imp_pendiente, importe, imp
oleobject  excel_oleobject
long c_relacion, c_poliza, f_efectivo, f_venc,  c_cobrado
long i, ll_nbr, ll_foundrow, dup, filas_articulos_otras_empresas
string c_tipo_poliza, c_asegurado, c_nombre, c_recibo,campo,concepto, fp
string  colegiado, datos_banco, nom_banco, db, n_banco, forma_pago
int fila_insertada
string tupla, campo_nif, campo_ase, campo_plz, campo_pla, conc, campo_mut, campo_pol, campo_pre, campo_nom
double campo_imp
string n_colegiado,ape1,ape2,nom

dw_listado.ShareDataoff()

filas_articulos_otras_empresas = 0
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
DO WHILE campo <> '' and (not isnull(campo))
	setpointer(hourglass!)
	campo_nif = string(excel_oleobject.Application.Cells(i, 4).Value)
	campo_pla = string(excel_oleobject.Application.Cells(i, 10).Value)
	campo_imp = double(excel_oleobject.Application.Cells(i, 13).Value)
	campo_plz = RightA('00000000' + trim(string(excel_oleobject.Application.Cells(i, 2).Value)) , 8)
	campo_ase = RightA('00000000' + trim(string(excel_oleobject.Application.Cells(i, 3).Value)) , 8)

	campo_pre = trim(string(excel_oleobject.Application.Cells(i, 1).Value))	
	campo_pol = trim(string(excel_oleobject.Application.Cells(i, 2).Value))
	campo_mut = trim(string(excel_oleobject.Application.Cells(i, 3).Value))
	//campo_nom = excel_oleobject.Application.Cells(i, 5).Value + ' ' + excel_oleobject.Application.Cells(i, 6).Value + ', ' + excel_oleobject.Application.Cells(i, 7).Value
	nom=trim(string(excel_oleobject.Application.Cells(i, 7).Value))
	ape1=trim(string( excel_oleobject.Application.Cells(i, 5).Value))
	ape2=trim(string(excel_oleobject.Application.Cells(i, 6).Value))
	
	if IsNull(ape1) then ape1=''
	if IsNull(ape2) then ape2=''
	if IsNull(nom) then nom=''
	
	campo_nom = ape1+ ' ' + ape2 + ', ' + nom
	campo_plz = RightA('00000000' + campo_pol, 8)
	campo_ase = RightA('00000000' + campo_mut , 8)

	choose case campo_pla
		case '1'
			conc = g_codigos_conceptos.musaat_fija_plazo1
		case '2'
			conc = g_codigos_conceptos.musaat_fija_plazo2
	end choose

	if not (f_articulo_activo(conc, g_empresa) ) then 
		i = i + 1
		filas_articulos_otras_empresas = filas_articulos_otras_empresas +1
		campo = string(excel_oleobject.Application.Cells(i, 1).Value)
		continue
	end if 
	
	// Buscamos el colegiado por el nif
	colegiado = f_devuelve_id_col_de_nif(campo_nif)
	
	
//	// Si no lo encuentra por el nif buscamos por el numero de mutualista
//	if f_es_vacio(colegiado) then colegiado = f_musaat_id_col_de_num_mutualista(campo_ase)
//	// Y si aun no lo ha encontrado buscamos por el numero de p$$HEX1$$f300$$ENDHEX$$liza
//	if f_es_vacio(colegiado) then colegiado = f_musaat_devuelve_id_col(campo_plz)


//	colegiado = ''
	// N$$HEX2$$ba002000$$ENDHEX$$MUTUALISTA
	// Con ceros
	if f_es_vacio(colegiado) then colegiado = f_musaat_id_col_de_num_mutualista(campo_ase)
	// Sin ceros
	if f_es_vacio(colegiado) then colegiado = f_musaat_id_col_de_num_mutualista(campo_mut)
	
	// N$$HEX2$$ba002000$$ENDHEX$$POLIZA
	// Sin ceros y sin prefijo
	if f_es_vacio(colegiado) then colegiado = f_musaat_devuelve_id_col(campo_pol)
	// Sin ceros y con prefijo
	if f_es_vacio(colegiado) then colegiado = f_musaat_devuelve_id_col(campo_pre+campo_pol)
	// Con ceros y sin prefijo
	if f_es_vacio(colegiado) then colegiado = f_musaat_devuelve_id_col(campo_plz)
	// Con ceros y con prefijo
	if f_es_vacio(colegiado) then colegiado = f_musaat_devuelve_id_col(RightA('00000000' + campo_pre+campo_pol,8))

	// Si no hay forma de encontrarlo, informamos
	campo_nif = ''
	if f_es_vacio(colegiado) then	
		campo_nif = campo_nom + " (N$$HEX2$$ba002000$$ENDHEX$$Mut.: " + campo_mut + " - N$$HEX2$$ba002000$$ENDHEX$$Pol.: " + campo_pol + ")"
		i_falladas++
	else
		i_generadas++
	end if
		
	n_colegiado=f_colegiado_n_col(colegiado)

	// Si hay m$$HEX1$$e100$$ENDHEX$$s de una l$$HEX1$$ed00$$ENDHEX$$nea para el mismo colegiado sumamos los importes y no insertamos
	dup = dw_lista.find ("id_colegiado <> '' and id_colegiado = '" + colegiado + "' and concepto = '" + conc + "' and  empresa = '" + g_empresa +"'" , 1, dw_lista.rowcount()) 
	if dup > 0 then
		imp = dw_lista.getitemnumber(dup, 'importe')
		dw_lista.setitem(dup, 'importe', imp + campo_imp)
	else
		// Vamos insertando las domiciliaciones
		fila_insertada = dw_lista.insertrow(0)
		dw_lista.setitem(fila_insertada, 'id_colegiado', colegiado)
		dw_lista.setitem(fila_insertada, 'concepto', conc)
		dw_lista.setitem(fila_insertada, 'empresa', g_empresa)
		dw_lista.setitem(fila_insertada, 'importe', campo_imp)
		
		// Obtenemos la forma de pago que tuviera para este concepto anteriormente, si no se pone DB por defecto
		SELECT conceptos_domiciliables.forma_de_pago  	INTO :forma_pago  FROM conceptos_domiciliables  
		WHERE ( conceptos_domiciliables.id_colegiado = :colegiado ) AND ( conceptos_domiciliables.concepto = :conc )   ;
		
		if f_es_vacio(forma_pago) then forma_pago = 'DB'
		
		dw_lista.setitem(fila_insertada, 'forma_de_pago', forma_pago)
		dw_lista.setitem(fila_insertada, 'nif_fichero', campo_nif)
		dw_lista.setitem(fila_insertada, 'num_col', n_colegiado)

		// Por si hay que subsanar
		dw_lista.setitem(fila_insertada, 'num_mutualista', campo_mut)
		dw_lista.setitem(fila_insertada, 'num_poliza', campo_pol)
		dw_lista.setitem(fila_insertada, 'prefijo', campo_pre)		
	end if
	i = i + 1
	campo = string(excel_oleobject.Application.Cells(i, 1).Value)
	f_mensaje_pantalla('Leyendo fichero........' + string(i))
LOOP
setpointer(arrow!)
dw_lista.setredraw(true)

f_mensaje_pantalla('Fin generaci$$HEX1$$f300$$ENDHEX$$n...')
// Cerramos el fichero
excel_oleobject.Application.Workbooks.Close()

// disconnect from Excel
excel_oleobject.DisconnectObject()

// destroy your object
DESTROY excel_oleobject

dw_lista.ShareData(dw_listado)

if (filas_articulos_otras_empresas > 0) then messagebox(g_titulo, "Algunos art$$HEX1$$ed00$$ENDHEX$$culos no est$$HEX1$$e100$$ENDHEX$$n activos para la actual empresa, de modo que no se han importado los datos", Exclamation!, Ok!)

cb_listado.enabled = true
cb_actualizar.enabled = true

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

ls_mensaje=g_idioma.of_getmsg('msg_musaat.filas_columna_n_colegiado_vacia','Las siguientes filas tienen vac$$HEX1$$ed00$$ENDHEX$$a la columna "N$$HEX2$$ba002000$$ENDHEX$$colegiado", no podr$$HEX2$$e1002000$$ENDHEX$$guardar los datos hasta que corrija esta situaci$$HEX1$$f300$$ENDHEX$$n:')+cr

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

event type integer csd_generar_conceptos_domiciliables_alt(string docname, integer value);//// Evento alternativo para un formato diferente de fichero
//integer nfile, fila_insertada, i=1
//string tupla, colegiado, campo_ase, campo_plz, campo_pla, conc, nombre, n_colegiado
//double campo_imp, imp
//long dup
//			
//dw_lista.object.nif_fichero_t.text = 'N$$HEX2$$ba002000$$ENDHEX$$Mut. y Nombre en fichero'
//dw_listado.object.nif_fichero_t.text = 'N$$HEX2$$ba002000$$ENDHEX$$Mut. y Nombre en fichero'
//
//// Modificado Ricardo 04-02-26
//dw_listado.ShareDataoff()
//// FIN Modificado Ricardo 04-02-26
//
//IF value = 1 THEN
//	f_mensaje_pantalla('Inicio generaci$$HEX1$$f300$$ENDHEX$$n...')
//
//	nfile = FileOpen(docname, LineMode!, Read!, LockWrite!)
//   value = FileRead(nfile, tupla)
//
//	DO WHILE value >= 0
//		campo_plz = Trim(MidA(tupla,10,5))
//		campo_ase = Trim(MidA(tupla,46,5))
//		campo_pla = RightA('00' + Trim(MidA(tupla,142,2)) , 1)
//		campo_imp = double(Trim(MidA(tupla,170,8)))
//		nombre = Trim(MidA(tupla,51,80))
//		
//		choose case campo_pla
//			case '1'
//				conc = g_codigos_conceptos.musaat_fija_plazo1
//			case '2'
//				conc = g_codigos_conceptos.musaat_fija_plazo2
//		end choose
//
//		// No viene el nif en el fichero utilizaremos el n$$HEX2$$ba002000$$ENDHEX$$mutualista como referencia
//		if not f_es_vacio(campo_ase) then // Si la linea es vacia no hacemos nada
//			colegiado = f_musaat_id_col_de_num_mutualista(campo_ase)
//
//			// Si no lo ha encontrado buscamos por el numero de p$$HEX1$$f300$$ENDHEX$$liza
//			if f_es_vacio(colegiado) then colegiado = f_musaat_devuelve_id_col(campo_plz)
//
//			// buscamos el n$$HEX1$$fa00$$ENDHEX$$mero de colegiado ahora. Antes estaba en un campo calculado en el dw
//			// y ralentizaba la ordenaci$$HEX1$$f300$$ENDHEX$$n
//			n_colegiado = f_colegiado_n_col(colegiado)
//
//			// Si hay m$$HEX1$$e100$$ENDHEX$$s de una l$$HEX1$$ed00$$ENDHEX$$nea para el mismo colegiado sumamos los importes y no insertamos
//			dup = dw_lista.find ("id_colegiado <> '' and id_colegiado = '" + colegiado + "'", 1, dw_lista.rowcount()) 
//			if dup > 0 then
//				imp = dw_lista.getitemnumber(dup, 'importe')
//				dw_lista.setitem(dup, 'importe', imp + campo_imp)
//			else
//				// Vamos insertando las domiciliaciones
//				fila_insertada = dw_lista.insertrow(0)
//				dw_lista.setitem(fila_insertada, 'id_colegiado', colegiado)
//				dw_lista.setitem(fila_insertada, 'concepto', conc)
//				dw_lista.setitem(fila_insertada, 'importe', campo_imp)
//				dw_lista.setitem(fila_insertada, 'forma_de_pago', 'DB')
//				dw_lista.setitem(fila_insertada, 'nif_fichero', campo_ase + '   ' + nombre)
//				dw_lista.setitem(fila_insertada, 'num_col', n_colegiado)
//			end if
//		end if
//		value = FileRead(nfile, tupla)
//	LOOP
//
//	f_mensaje_pantalla('Fin generaci$$HEX1$$f300$$ENDHEX$$n.')
//	cb_listado.enabled = true
//	cb_actualizar.enabled = true
//	FileClose(nfile)
//end if
//
//// Ricardo 04-02-26
//dw_lista.ShareData(dw_listado)
//// Ricardo 04-02-26
//
return 0
//
end event

event type integer csd_generar_cuotas_xls_2007(string docname, integer value);oleobject excel_oleobject
double campo_imp, imp
long i, fila_insertada, dup, filas_articulos_otras_empresas
string campo, colegiado, campo_nif, campo_ase, campo_plz, campo_pla, conc, n_colegiado, campo_nom, campo_mut, forma_pago
string campo_pol, campo_pre, extra='N'


dw_listado.ShareDataoff()

filas_articulos_otras_empresas = 0
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
DO WHILE campo <> '' and (not isnull(campo))
	setpointer(hourglass!)
	campo_pla = RightA(string(excel_oleobject.Application.Cells(i, 7).Value),1)
	campo_imp = double(excel_oleobject.Application.Cells(i, 10).Value)
	campo_pre = trim(string(excel_oleobject.Application.Cells(i, 2).Value))	
	campo_pol = trim(string(excel_oleobject.Application.Cells(i, 3).Value))
	campo_mut = trim(string(excel_oleobject.Application.Cells(i, 5).Value))
	campo_nom = excel_oleobject.Application.Cells(i, 6).Value
	
	campo_plz = RightA('00000000' + campo_pol, 8)
	campo_ase = RightA('00000000' + campo_mut , 8)

	choose case campo_pla
		case '1'
			conc = g_codigos_conceptos.musaat_fija_plazo1
		case '2'
			conc = g_codigos_conceptos.musaat_fija_plazo2
	end choose
	
	if not (f_articulo_activo(conc, g_empresa) ) then 
		i = i + 1
		filas_articulos_otras_empresas = filas_articulos_otras_empresas + 1
		campo = string(excel_oleobject.Application.Cells(i, 1).Value)
		continue
	end if 
	
	// Si es fichero mensual cogemos el concepto introducido y si es extra
	if dw_datos_mensual.getitemstring(1, 'mensual') = 'S' then
		conc = dw_datos_mensual.getitemstring(1, 'concepto')
		extra = dw_datos_mensual.getitemstring(1, 'extra')
	end if

	colegiado = ''
	// N$$HEX2$$ba002000$$ENDHEX$$MUTUALISTA
	// Con ceros
	if f_es_vacio(colegiado) then colegiado = f_musaat_id_col_de_num_mutualista(campo_ase)
	// Sin ceros
	if f_es_vacio(colegiado) then colegiado = f_musaat_id_col_de_num_mutualista(campo_mut)
	
	// N$$HEX2$$ba002000$$ENDHEX$$POLIZA
	// Sin ceros y sin prefijo
	if f_es_vacio(colegiado) then colegiado = f_musaat_devuelve_id_col(campo_pol)
	// Sin ceros y con prefijo
	if f_es_vacio(colegiado) then colegiado = f_musaat_devuelve_id_col(campo_pre+campo_pol)
	// Con ceros y sin prefijo
	if f_es_vacio(colegiado) then colegiado = f_musaat_devuelve_id_col(campo_plz)
	// Con ceros y con prefijo
	if f_es_vacio(colegiado) then colegiado = f_musaat_devuelve_id_col(RightA('00000000' + campo_pre+campo_pol,8))

	// Si no hay forma de encontrarlo, informamos
	campo_nif = ''
	if f_es_vacio(colegiado) then	
		campo_nif = campo_nom + " (N$$HEX2$$ba002000$$ENDHEX$$Mut.: " + campo_mut + " - N$$HEX2$$ba002000$$ENDHEX$$Pol.: " + campo_pol + ")"
		i_falladas++
	else
		i_generadas++
	end if
		
	n_colegiado = f_colegiado_n_col(colegiado)

	// Si hay m$$HEX1$$e100$$ENDHEX$$s de una l$$HEX1$$ed00$$ENDHEX$$nea para el mismo colegiado sumamos los importes y no insertamos
	dup = dw_lista.find ("id_colegiado <> '' and id_colegiado = '" + colegiado + "' and  empresa = '" + g_empresa +"'", 1, dw_lista.rowcount()) 
	if dup > 0 then
		imp = dw_lista.getitemnumber(dup, 'importe')
		dw_lista.setitem(dup, 'importe', imp + campo_imp)
	else
		// Vamos insertando las domiciliaciones
		fila_insertada = dw_lista.insertrow(0)
		dw_lista.setitem(fila_insertada, 'id_colegiado', colegiado)
		dw_lista.setitem(fila_insertada, 'concepto', conc)
		dw_lista.setitem(fila_insertada, 'empresa', g_empresa)
		dw_lista.setitem(fila_insertada, 'importe', campo_imp)
		
		// Obtenemos la forma de pago que tuviera para este concepto anteriormente, si no se pone DB por defecto
		SELECT conceptos_domiciliables.forma_de_pago  	INTO :forma_pago  FROM conceptos_domiciliables  
		WHERE ( conceptos_domiciliables.id_colegiado = :colegiado ) AND ( conceptos_domiciliables.concepto = :conc )   ;
		
		if f_es_vacio(forma_pago) then forma_pago = 'DB'
		
		dw_lista.setitem(fila_insertada, 'forma_de_pago', forma_pago)

		dw_lista.setitem(fila_insertada, 'nif_fichero', campo_nif)
		dw_lista.setitem(fila_insertada, 'num_col', n_colegiado)
		dw_lista.setitem(fila_insertada, 'es_extra', extra)
		
		// Por si hay que subsanar
		dw_lista.setitem(fila_insertada, 'num_mutualista', campo_mut)
		dw_lista.setitem(fila_insertada, 'num_poliza', campo_pol)
		dw_lista.setitem(fila_insertada, 'prefijo', campo_pre)	
	end if
	i = i + 1
	campo = string(excel_oleobject.Application.Cells(i, 1).Value)
	f_mensaje_pantalla('Leyendo fichero........' + string(i))
LOOP
setpointer(arrow!)
dw_lista.setredraw(true)

f_mensaje_pantalla('Fin generaci$$HEX1$$f300$$ENDHEX$$n...')

// Cerramos el fichero
excel_oleobject.Application.Workbooks.Close()

// disconnect from Excel
excel_oleobject.DisconnectObject()

// destroy your object
DESTROY excel_oleobject

dw_lista.ShareData(dw_listado)

if (filas_articulos_otras_empresas > 0) then messagebox(g_titulo, "Algunos art$$HEX1$$ed00$$ENDHEX$$culos no est$$HEX1$$e100$$ENDHEX$$n activos para la actual empresa, de modo que no se han importado los datos", Exclamation!, Ok!)

cb_listado.enabled = true
cb_actualizar.enabled = true

return 1

end event

event type integer csd_generar_cuotas_txt_2007(string docname, integer value);long nfile, fila_insertada, i=1, dup, filas_articulos_otras_empresas
string campo, colegiado, campo_nif, campo_ase, campo_plz, campo_pla, conc, n_colegiado, campo_nom, campo_mut, forma_pago
string campo_pol, campo_pre, tupla, extra='N'
double campo_imp, imp
			
dw_listado.ShareDataoff()

filas_articulos_otras_empresas = 0

IF value = 1 THEN
	f_mensaje_pantalla('Inicio generaci$$HEX1$$f300$$ENDHEX$$n...')

	nfile = FileOpen(docname, LineMode!, Read!, LockWrite!)
	value = FileRead(nfile, tupla)

	dw_lista.setredraw(false)
	DO WHILE value >= 0
		setpointer(hourglass!)
		campo_pla = RightA(Trim(MidA(tupla,131,13)),1)
		campo_imp = double(Trim(MidA(tupla,163,15)))
		campo_pre = Trim(MidA(tupla,7,2))
		campo_pol = Trim(MidA(tupla,9,6))
		campo_mut = Trim(MidA(tupla,45,6))
		campo_nom = Trim(MidA(tupla,51,80))
	
		campo_plz = RightA('00000000' + campo_pol, 8)
		campo_ase = RightA('00000000' + campo_mut , 8)

		choose case campo_pla
			case '1'
				conc = g_codigos_conceptos.musaat_fija_plazo1
			case '2'
				conc = g_codigos_conceptos.musaat_fija_plazo2
		end choose
		
		if not (f_articulo_activo(conc, g_empresa) ) then 
			value = FileRead(nfile, tupla)
			filas_articulos_otras_empresas = filas_articulos_otras_empresas +1
			continue
		end if 
			
		// Si es fichero mensual cogemos el concepto introducido y si es extra
		if dw_datos_mensual.getitemstring(1, 'mensual') = 'S' then
			conc = dw_datos_mensual.getitemstring(1, 'concepto')
			extra = dw_datos_mensual.getitemstring(1, 'extra')
		end if		

		colegiado = ''
		// N$$HEX2$$ba002000$$ENDHEX$$MUTUALISTA
		// Con ceros
		if f_es_vacio(colegiado) then colegiado = f_musaat_id_col_de_num_mutualista(campo_ase)
		// Sin ceros
		if f_es_vacio(colegiado) then colegiado = f_musaat_id_col_de_num_mutualista(campo_mut)
		
		// N$$HEX2$$ba002000$$ENDHEX$$POLIZA
		// Sin ceros y sin prefijo
		if f_es_vacio(colegiado) then colegiado = f_musaat_devuelve_id_col(campo_pol)
		// Sin ceros y con prefijo
		if f_es_vacio(colegiado) then colegiado = f_musaat_devuelve_id_col(campo_pre+campo_pol)
		// Con ceros y sin prefijo
		if f_es_vacio(colegiado) then colegiado = f_musaat_devuelve_id_col(campo_plz)
		// Con ceros y con prefijo
		if f_es_vacio(colegiado) then colegiado = f_musaat_devuelve_id_col(RightA('00000000' + campo_pre+campo_pol,8))

		// Si no hay forma de encontrarlo, informamos
		campo_nif = ''
		if f_es_vacio(colegiado) then	
			campo_nif = campo_nom + " (N$$HEX2$$ba002000$$ENDHEX$$Mut.: " + campo_mut + " - N$$HEX2$$ba002000$$ENDHEX$$Pol.: " + campo_pol + ")"
			i_falladas++
		else
			i_generadas++
		end if
			
		n_colegiado = f_colegiado_n_col(colegiado)
	
		// Si hay m$$HEX1$$e100$$ENDHEX$$s de una l$$HEX1$$ed00$$ENDHEX$$nea para el mismo colegiado sumamos los importes y no insertamos
		dup = dw_lista.find ("id_colegiado <> '' and id_colegiado = '" + colegiado + "' and  empresa = '" + g_empresa +"'", 1, dw_lista.rowcount()) 
		if dup > 0 then
			imp = dw_lista.getitemnumber(dup, 'importe')
			dw_lista.setitem(dup, 'importe', imp + campo_imp)
		else
			// Vamos insertando las domiciliaciones
			fila_insertada = dw_lista.insertrow(0)
			dw_lista.setitem(fila_insertada, 'id_colegiado', colegiado)
			dw_lista.setitem(fila_insertada, 'concepto', conc)
			dw_lista.setitem(fila_insertada, 'empresa',g_empresa)
			dw_lista.setitem(fila_insertada, 'importe', campo_imp)
			// Obtenemos la forma de pago que tuviera para este concepto anteriormente, si no se pone DB por defecto
			SELECT conceptos_domiciliables.forma_de_pago  	INTO :forma_pago  FROM conceptos_domiciliables  
			WHERE ( conceptos_domiciliables.id_colegiado = :colegiado ) AND ( conceptos_domiciliables.concepto = :conc )   ;
			
			if f_es_vacio(forma_pago) then forma_pago = 'DB'
			
			dw_lista.setitem(fila_insertada, 'forma_de_pago', forma_pago)
			dw_lista.setitem(fila_insertada, 'nif_fichero', campo_nif)
			dw_lista.setitem(fila_insertada, 'num_col', n_colegiado)
			dw_lista.setitem(fila_insertada, 'es_extra', extra)
			
			// Por si hay que subsanar
			dw_lista.setitem(fila_insertada, 'num_mutualista', campo_mut)
			dw_lista.setitem(fila_insertada, 'num_poliza', campo_pol)
			dw_lista.setitem(fila_insertada, 'prefijo', campo_pre)
		end if
		value = FileRead(nfile, tupla)
		f_mensaje_pantalla('Leyendo fichero........' + string(fila_insertada))
	LOOP
end if
setpointer(arrow!)
dw_lista.setredraw(true)

if (filas_articulos_otras_empresas > 0) then messagebox(g_titulo, "Algunos art$$HEX1$$ed00$$ENDHEX$$culos no est$$HEX1$$e100$$ENDHEX$$n activos para la actual empresa, de modo que no se han importado los datos", Exclamation!, Ok!)

cb_listado.enabled = true
cb_actualizar.enabled = true
FileClose(nfile)

// Ricardo 04-02-26
dw_lista.ShareData(dw_listado)
// Ricardo 04-02-26

return 0

end event

public subroutine f_mensaje_pantalla (string mensaje);st_mensajes.Text = mensaje
end subroutine

on w_musaat_calculo_recibos.create
int iCurrent
call super::create
this.dw_listado=create dw_listado
this.cb_salir=create cb_salir
this.st_mensajes=create st_mensajes
this.cb_actualizar=create cb_actualizar
this.cb_listado=create cb_listado
this.cb_generar=create cb_generar
this.dw_datos_mensual=create dw_datos_mensual
this.dw_lista=create dw_lista
this.st_mensajes2=create st_mensajes2
this.oleobject_1=create oleobject_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_listado
this.Control[iCurrent+2]=this.cb_salir
this.Control[iCurrent+3]=this.st_mensajes
this.Control[iCurrent+4]=this.cb_actualizar
this.Control[iCurrent+5]=this.cb_listado
this.Control[iCurrent+6]=this.cb_generar
this.Control[iCurrent+7]=this.dw_datos_mensual
this.Control[iCurrent+8]=this.dw_lista
this.Control[iCurrent+9]=this.st_mensajes2
end on

on w_musaat_calculo_recibos.destroy
call super::destroy
destroy(this.dw_listado)
destroy(this.cb_salir)
destroy(this.st_mensajes)
destroy(this.cb_actualizar)
destroy(this.cb_listado)
destroy(this.cb_generar)
destroy(this.dw_datos_mensual)
destroy(this.dw_lista)
destroy(this.st_mensajes2)
destroy(this.oleobject_1)
end on

event open;call super::open;of_SetResize (true)

//DesHabilitamos botones antes de Generar
cb_listado.enabled = false
cb_actualizar.enabled = false

inv_resize.of_Register (dw_lista, "ScaletoRight&Bottom")
inv_resize.of_Register (cb_generar, "FixedtoBottom")
inv_resize.of_Register (cb_listado, "FixedtoBottom")
inv_resize.of_Register (cb_actualizar, "FixedtoBottom")
inv_resize.of_Register (st_mensajes, "FixedtoBottom")
inv_resize.of_Register (cb_salir, "FixedtoRight&Bottom")
inv_resize.of_Register (st_mensajes2, "FixedtoBottom")
inv_resize.of_Register (dw_datos_mensual, "ScaletoRight")

dw_datos_mensual.insertrow(0)

end event

event closequery;//SOBREESCRITO
return 0
end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_musaat_calculo_recibos
integer x = 4402
integer y = 764
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_musaat_calculo_recibos
integer x = 4384
integer y = 624
end type

type dw_listado from u_dw within w_musaat_calculo_recibos
boolean visible = false
integer x = 3959
integer y = 1144
integer taborder = 10
string dataobject = "d_musaat_listado_domic_prima_fija"
end type

type cb_salir from u_cb within w_musaat_calculo_recibos
integer x = 3867
integer y = 1736
integer width = 503
integer height = 96
integer taborder = 40
string text = "&Salir"
end type

event clicked;call super::clicked;close(Parent)
end event

type st_mensajes from u_st within w_musaat_calculo_recibos
integer x = 1614
integer y = 1724
integer width = 1074
integer height = 60
integer weight = 700
fontcharset fontcharset = ansi!
long textcolor = 8388736
string text = ""
end type

type cb_actualizar from u_cb within w_musaat_calculo_recibos
integer x = 1079
integer y = 1736
integer width = 503
integer height = 96
integer taborder = 60
string text = "Actualizar datos"
end type

event clicked;call super::clicked;integer Net,li_resValidar,i

// Validamos los datos antes de guardar
li_resValidar=event	csd_validar_datos()
if li_resValidar=1 then
	//Si hay datos repetidos no permitimos que se guarden los datos
	return -1
end if

// Fase 0 : Borrando cuotas anteriores
if dw_datos_mensual.getitemstring(1, 'mensual') = 'N' then
	Net = MessageBox(g_idioma.of_getmsg('msg_musaat.actualizar_datos',"Actualizar Datos"),g_idioma.of_getmsg('msg_musaat.borraran_anteriores_actualizar',"Se borrar$$HEX1$$e100$$ENDHEX$$n las cuotas anteriores, $$HEX1$$bf00$$ENDHEX$$Desea actualizar las cuotas? "), Question!, OKCancel!, 1)
	IF Net = 1 THEN parent.event csd_borrar_conceptos_domiciliables()
end if

// Fase 1 : Grabando nuevas cuotas
f_mensaje_pantalla('Grabando datos...')
st_mensajes2.text = ''
//for i=1 to dw_lista.rowcount() 
//	dw_lista.setitem(i,'empresa',g_cod_empresa_aseguradora)	
//next

dw_lista.update()

// Fase 2: inhabiliatacion de la botonera
cb_listado.enabled = false
cb_actualizar.enabled = false
f_mensaje_pantalla('Datos actualizados.')

end event

type cb_listado from u_cb within w_musaat_calculo_recibos
integer x = 571
integer y = 1736
integer width = 503
integer height = 96
integer taborder = 10
string text = "Listado"
end type

event clicked;call super::clicked;integer Net

Net = MessageBox(g_idioma.of_getmsg('msg_musaat.imprimir_listado',"Imprimir Listado"),g_idioma.of_getmsg('msg_musaat.desea_imprimir_listado',"$$HEX1$$bf00$$ENDHEX$$Desea imprimir el listado? "), Question!, OKCancel!, 1)

IF Net = 1 THEN
	dw_listado.print()
end if

end event

type cb_generar from u_cb within w_musaat_calculo_recibos
integer x = 64
integer y = 1736
integer width = 503
integer height = 96
integer taborder = 70
string text = "Generar"
end type

event clicked;call super::clicked;string docname, named, extension, mensaje=''
integer value

// Comprobamos que han introducido el concepto para el fichero mensual
if dw_datos_mensual.getitemstring(1, 'mensual') = 'S' then
	mensaje = f_valida(dw_datos_mensual,'concepto','NOVACIO',g_idioma.of_getmsg('msg_musaat.introducir_concepto','Debe introducir un concepto'))
	if mensaje <> '' then 
		messagebox(g_titulo, mensaje,StopSign!)
		return
	end if
end if

i_generadas=0
i_falladas=0

dw_lista.reset()

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02

st_mensajes.text = ''
st_mensajes2.text = ''

value = GetFileOpenName("Selecione Fichero de Prima Fija", docname, named, "XLS, TXT", "Excel Files (*.XLS),*.XLS,Text Files (*.TXT),*.TXT")
		
extension = RightA(named,3)

dw_datos_mensual.accepttext()

//if lower(extension) = 'txt' then	
//	if g_colegio = 'COAATLR' then
//		Parent.trigger event csd_generar_conceptos_domiciliables_alt(docname,value)
//	else
//		Parent.trigger event csd_generar_conceptos_domiciliables(docname,value)
//	end if
//end if
//if lower(extension) = 'xls' then	Parent.trigger event csd_generar_conceptos_domiciliables_xls(docname,value)

if lower(extension) = 'xls' then
	if g_colegio = 'COAATMCA' or g_colegio = 'COAATTGN' OR g_colegio='COAATLL' or g_colegio = 'COAATTEB' or g_colegio = 'COAATTFE' or g_colegio = 'COAATNA'  or g_colegio = 'COAATZGZ' then 
		Parent.trigger event csd_generar_conceptos_domiciliables_xls(docname,value)
	else
		Parent.trigger event csd_generar_cuotas_xls_2007(docname,value)
	end if
end if
if lower(extension) = 'txt' then	Parent.trigger event csd_generar_cuotas_txt_2007(docname,value)


// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02

st_mensajes.text = 'Generadas : '+string(i_generadas)+ ' cuotas.'
st_mensajes2.text ='Falladas  : '+string(i_falladas)+ ' cuotas.'

end event

type dw_datos_mensual from u_dw within w_musaat_calculo_recibos
integer x = 37
integer y = 32
integer width = 4334
integer height = 256
integer taborder = 20
string dataobject = "d_musaat_calculo_recibos_seleccion"
boolean vscrollbar = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_lista from u_dw within w_musaat_calculo_recibos
integer x = 37
integer y = 320
integer width = 4334
integer height = 1356
integer taborder = 30
string dataobject = "d_musaat_calculo_recibos"
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

if MessageBox(g_idioma.of_getmsg('msg_musaat.subsanar',"Subsanar"),g_idioma.of_getmsg('msg_musaat.subsanar_numeros',"$$HEX1$$bf00$$ENDHEX$$Desea actualizar los n$$HEX1$$fa00$$ENDHEX$$meros de p$$HEX1$$f300$$ENDHEX$$liza y mutualista de este colegiado con los del fichero?"), Question!, OKCancel!, 1) = 1 then
	n_mut = this.getitemstring(row, 'num_mutualista')
	n_pol = this.getitemstring(row, 'num_poliza')
	pref = this.getitemstring(row, 'prefijo')

	UPDATE musaat  
	SET n_mutualista = :n_mut,   src_n_poliza = :n_pol,   src_prefijo = :pref
	WHERE musaat.id_col = :id_col   ;

end if

end event

type st_mensajes2 from u_st within w_musaat_calculo_recibos
integer x = 1614
integer y = 1788
integer width = 1074
integer height = 60
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
long textcolor = 8388736
string text = ""
end type

type oleobject_1 from oleobject within w_musaat_calculo_recibos descriptor "pb_nvo" = "true" 
end type

on oleobject_1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on oleobject_1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

