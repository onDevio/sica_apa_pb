HA$PBExportHeader$w_musaat_situacion_asegurados.srw
$PBExportComments$Chequea las coberturas y bonus malus de los asegurados de MUSAAT con el fichero de MUSAAT
forward
global type w_musaat_situacion_asegurados from w_sheet
end type
type dw_listado from u_dw within w_musaat_situacion_asegurados
end type
type sle_buscar from u_sle within w_musaat_situacion_asegurados
end type
type cb_buscar from u_cb within w_musaat_situacion_asegurados
end type
type cb_salir from u_cb within w_musaat_situacion_asegurados
end type
type cb_1 from commandbutton within w_musaat_situacion_asegurados
end type
type st_mensajes from u_st within w_musaat_situacion_asegurados
end type
type cb_actualizar from u_cb within w_musaat_situacion_asegurados
end type
type cb_listado from u_cb within w_musaat_situacion_asegurados
end type
type cb_generar from u_cb within w_musaat_situacion_asegurados
end type
type dw_lista from u_dw within w_musaat_situacion_asegurados
end type
type oleobject_1 from oleobject within w_musaat_situacion_asegurados
end type
end forward

global type w_musaat_situacion_asegurados from w_sheet
integer x = 214
integer y = 221
integer width = 3511
integer height = 1680
string title = "Asegurados de MUSAAT"
boolean controlmenu = false
windowstate windowstate = maximized!
event type integer csd_generar_conceptos_domiciliables ( string docname,  integer value )
event type integer csd_cargar_datos_xls ( string docname,  integer value )
dw_listado dw_listado
sle_buscar sle_buscar
cb_buscar cb_buscar
cb_salir cb_salir
cb_1 cb_1
st_mensajes st_mensajes
cb_actualizar cb_actualizar
cb_listado cb_listado
cb_generar cb_generar
dw_lista dw_lista
oleobject_1 oleobject_1
end type
global w_musaat_situacion_asegurados w_musaat_situacion_asegurados

type variables
u_dw idw_lista

// idw_2000, idw_comple1
//datastore ids_borrar_cuotas
end variables

forward prototypes
public subroutine wf_mensaje_pantalla (string mensaje)
end prototypes

event type integer csd_generar_conceptos_domiciliables(string docname, integer value);integer nfile, fila_insertada
string named, tupla, colegiado
string campo_nif, campo_ase, cober, id_cober, poliza, campo_plz
long campo_pre, campo_pol, campo_col
double campo_cob, campo_ks, ks
long ll_nbr, ll_foundrow

id_cober = '00'

IF value = 1 THEN
	wf_mensaje_pantalla('Inicio generaci$$HEX1$$f300$$ENDHEX$$n...')
	
	nfile = FileOpen(docname, LineMode!, Read!, LockWrite!) 	
   value = FileRead(nfile, tupla)
		
	ll_nbr = dw_lista.retrieve()
	
	DO WHILE value >= 0		
		// campo_pol = pref + poliza
		//	campo_pol = long( Trim(Mid(tupla, 1, 2)) + Trim(Mid(tupla, 4, 6)) )
		//	campo_nif = Trim(Mid(tupla, 11, 9))
		//	campo_ase = Trim(Mid(tupla, 21, 6))
		//	campo_col = long(Trim(Mid(tupla, 28, 2)))
		//	campo_cob = double( Trim( Mid(tupla, 31, 11) + ',' + Mid(tupla, 42, 2) ) )
		//	campo_ks  = double( Trim( Mid(tupla, 45, 3)  + ',' + Mid(tupla, 48, 2) ) )
		campo_pre = long(Trim(MidA(tupla,1,2)))
		campo_pol = long(Trim(MidA(tupla,3,6)))
		campo_plz = /*string(campo_pre) +*/ string(campo_pol)
		campo_nif = Trim(MidA(tupla,9,9))
		campo_ase = Trim(MidA(tupla,18,6))
		campo_col = long(Trim(MidA(tupla,24,2)))
		campo_cob = double(Trim(MidA(tupla,26,9)+','+MidA(tupla,34,2)))
		campo_ks  = double(Trim(MidA(tupla,37,1)+','+MidA(tupla,38,2)))
		//	messagebox('campo_cob ',string(campo_pol)+cr+campo_nif+cr+campo_ase+&
		//	cr+string(campo_col)+cr+string(campo_cob)+cr+string(campo_ks))		
		
		if long(g_col_codigo_musaat) <> campo_col then
			//	messagebox(g_titulo, 'El Fichero de Situaci$$HEX1$$f300$$ENDHEX$$n de Asegurados no corresponde con la Empresa.')
			// return 1
		// end if
			value = FileRead(nfile, tupla)
			continue
		else
			// Hacemos la b$$HEX1$$fa00$$ENDHEX$$squeda por el campo nif
			colegiado =	f_devuelve_id_col_de_nif(campo_nif)
			ll_foundrow = dw_lista.Find( "id_col = '" + colegiado + "'", 1, ll_nbr)
			if ll_foundrow > 0 THEN
				id_cober = Trim(f_musaat_dame_codigo_cobertura_src(campo_cob))
				ks = dw_lista.getitemNumber(ll_foundrow, 'src_coef_cm')
				cober = dw_lista.getitemString(ll_foundrow, 'src_cober')
				poliza = dw_lista.getitemString(ll_foundrow, 'src_n_poliza')
				// Actualizamos la cobertura y/o el Bonus Malus (ks)
				IF ks <> campo_ks or cober <> id_cober or poliza <> string(campo_plz) THEN
					// Vamos rellenando el listado de variaciones
					fila_insertada = dw_listado.insertrow(0)
					dw_listado.setitem(fila_insertada, 'n_col', f_colegiado_n_col(colegiado))
					dw_listado.setitem(fila_insertada, 'nombre', f_colegiado_nombre(colegiado) + ' ' + f_colegiado_apellidos(colegiado))
					dw_listado.setitem(fila_insertada, 'src_n_poliza', poliza)
					dw_listado.setitem(fila_insertada, 'src_coef_cm', ks)
					dw_listado.setitem(fila_insertada, 'src_cober', cober)	
					dw_listado.setitem(fila_insertada, 'src_coef_cm_act', campo_ks)
					dw_listado.setitem(fila_insertada, 'src_cober_act', id_cober)	
				END IF
				dw_lista.Setitem(ll_foundrow, 'src_prefijo', campo_pre)
				dw_lista.Setitem(ll_foundrow, 'src_n_poliza', campo_plz)
				// ELIMINAR: Campo provisional para COAATGC
//				dw_lista.Setitem(ll_foundrow, 'nif_a_eliminar', campo_nif) 
				dw_lista.Setitem(ll_foundrow, 'n_mutualista', campo_ase)
				dw_lista.Setitem(ll_foundrow, 'src_coef_cm', campo_ks)
				dw_lista.Setitem(ll_foundrow, 'src_cober', id_cober)
				//	Si la cobertura y el bonus malus son 0 lo damos de baja
				if campo_ks = 0 and id_cober = '00' then
					dw_lista.Setitem(ll_foundrow, 'src_alta', 'N')
					dw_lista.Setitem(ll_foundrow, 'src_f_baja', today())
				end if
			END IF
		value = FileRead(nfile, tupla)
		end if
	LOOP

	wf_mensaje_pantalla('Fin generaci$$HEX1$$f300$$ENDHEX$$n.')
	cb_listado.enabled = true
	cb_actualizar.enabled = true
	FileClose(nfile)
end if

return 0
end event

event type integer csd_cargar_datos_xls(string docname, integer value);integer nfile, fila_insertada
string named, tupla, colegiado
string campo_nif, campo_ase, cober, id_cober, poliza, campo_plz
string campo_pre, campo_pol, campo_col
double campo_cob, campo_ks, ks
long ll_nbr, ll_foundrow,i
string campo
oleobject  excel_oleobject

i=2
excel_oleobject = CREATE OLEObject

if excel_oleobject.ConnectToNewObject("excel.application") <> 0 then
 messagebox("Error","Microsoft Excel is not supported on your computer")
 return 1
end if

excel_oleobject.Application.Workbooks.Open(docname)
excel_oleobject.Application.Visible = False
excel_oleobject.windowstate = 2 // 1 : Normal, 2 : Minimize, 3 : Maximize

excel_oleobject.Application.Range("A1").Select()

id_cober = '00'

IF value = 1 THEN
	wf_mensaje_pantalla('Inicio generaci$$HEX1$$f300$$ENDHEX$$n...')
	
	dw_lista.setredraw(false)

	campo = string(excel_oleobject.Application.Cells(i, 1).Value)
	
	//nfile = FileOpen(docname, LineMode!, Read!, LockWrite!) 	
	//value = FileRead(nfile, tupla)
		
	ll_nbr = dw_lista.retrieve()
	string nom,ape1,ape2,campo_mut,campo_nom
	
	DO WHILE campo <> '' and (not isnull(campo))

		wf_mensaje_pantalla('Leyendo fichero........' + string(i))
		setpointer(hourglass!)
		campo_nif = string(excel_oleobject.Application.Cells(i, 4).Value)
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
		//campo_ase = RightA('00000000' + campo_mut , 8)
		campo_ase = campo_mut
	
		campo_cob = double(trim(string(excel_oleobject.Application.Cells(i, 8).Value)))
		campo_ks  = double(trim(string(excel_oleobject.Application.Cells(i, 15).Value)))
			
		// Hacemos la b$$HEX1$$fa00$$ENDHEX$$squeda por el campo nif
		colegiado =	f_devuelve_id_col_de_nif(campo_nif)
		ll_foundrow = dw_lista.Find( "id_col = '" + colegiado + "'", 1, ll_nbr)
		if ll_foundrow > 0 THEN
			id_cober = Trim(f_musaat_dame_codigo_cobertura_src(campo_cob))
			ks = dw_lista.getitemNumber(ll_foundrow, 'src_coef_cm')
			cober = dw_lista.getitemString(ll_foundrow, 'src_cober')
			poliza = dw_lista.getitemString(ll_foundrow, 'src_n_poliza')
			// Actualizamos la cobertura y/o el Bonus Malus (ks)
			IF ks <> campo_ks or cober <> id_cober or poliza <> string(campo_pol) THEN
				// Vamos rellenando el listado de variaciones
				fila_insertada = dw_listado.insertrow(0)
				dw_listado.setitem(fila_insertada, 'n_col', f_colegiado_n_col(colegiado))
				dw_listado.setitem(fila_insertada, 'nombre', f_colegiado_nombre(colegiado) + ' ' + f_colegiado_apellidos(colegiado))
				dw_listado.setitem(fila_insertada, 'src_n_poliza', poliza)
				dw_listado.setitem(fila_insertada, 'src_coef_cm', ks)
				dw_listado.setitem(fila_insertada, 'src_cober', cober)	
				dw_listado.setitem(fila_insertada, 'src_coef_cm_act', campo_ks)
				dw_listado.setitem(fila_insertada, 'src_cober_act', id_cober)	
			END IF
			dw_lista.Setitem(ll_foundrow, 'src_prefijo', campo_pre)
			dw_lista.Setitem(ll_foundrow, 'src_n_poliza', campo_pol)
			// ELIMINAR: Campo provisional para COAATGC
	//				dw_lista.Setitem(ll_foundrow, 'nif_a_eliminar', campo_nif) 
			dw_lista.Setitem(ll_foundrow, 'n_mutualista', campo_ase)
			dw_lista.Setitem(ll_foundrow, 'src_coef_cm', campo_ks)
			dw_lista.Setitem(ll_foundrow, 'src_cober', id_cober)
			//	Si la cobertura y el bonus malus son 0 lo damos de baja
			if campo_ks = 0 and id_cober = '00' then
				dw_lista.Setitem(ll_foundrow, 'src_alta', 'N')
				dw_lista.Setitem(ll_foundrow, 'src_f_baja', today())
			end if
		END IF
		i++
		campo = string(excel_oleobject.Application.Cells(i, 1).Value)				
	LOOP

	wf_mensaje_pantalla('Fin generaci$$HEX1$$f300$$ENDHEX$$n.')
	cb_listado.enabled = true
	cb_actualizar.enabled = true
	FileClose(nfile)
end if

return 0
end event

public subroutine wf_mensaje_pantalla (string mensaje);st_mensajes.text = mensaje
end subroutine

on w_musaat_situacion_asegurados.create
int iCurrent
call super::create
this.dw_listado=create dw_listado
this.sle_buscar=create sle_buscar
this.cb_buscar=create cb_buscar
this.cb_salir=create cb_salir
this.cb_1=create cb_1
this.st_mensajes=create st_mensajes
this.cb_actualizar=create cb_actualizar
this.cb_listado=create cb_listado
this.cb_generar=create cb_generar
this.dw_lista=create dw_lista
this.oleobject_1=create oleobject_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_listado
this.Control[iCurrent+2]=this.sle_buscar
this.Control[iCurrent+3]=this.cb_buscar
this.Control[iCurrent+4]=this.cb_salir
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.st_mensajes
this.Control[iCurrent+7]=this.cb_actualizar
this.Control[iCurrent+8]=this.cb_listado
this.Control[iCurrent+9]=this.cb_generar
this.Control[iCurrent+10]=this.dw_lista
end on

on w_musaat_situacion_asegurados.destroy
call super::destroy
destroy(this.dw_listado)
destroy(this.sle_buscar)
destroy(this.cb_buscar)
destroy(this.cb_salir)
destroy(this.cb_1)
destroy(this.st_mensajes)
destroy(this.cb_actualizar)
destroy(this.cb_listado)
destroy(this.cb_generar)
destroy(this.dw_lista)
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
inv_resize.of_Register (cb_salir, "FixedtoBottom")
end event

event closequery;//SOBREESCRITO
return 0
end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_musaat_situacion_asegurados
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_musaat_situacion_asegurados
string tag = "texto=general.guardar_pantalla"
end type

type dw_listado from u_dw within w_musaat_situacion_asegurados
boolean visible = false
integer x = 2711
integer y = 464
integer taborder = 100
string dataobject = "d_musaat_listado_variaciones_asegurados"
end type

type sle_buscar from u_sle within w_musaat_situacion_asegurados
boolean visible = false
integer x = 2702
integer y = 440
integer taborder = 90
end type

type cb_buscar from u_cb within w_musaat_situacion_asegurados
string tag = "texto=general.buscar"
boolean visible = false
integer x = 2208
integer y = 432
integer width = 389
integer taborder = 80
string text = "&Buscar"
end type

event clicked;call super::clicked;string sql_nuevo, concepto, fp

sql_nuevo = parent.dw_lista.describe("datawindow.table.select")

f_sql('sle_buscar', 'LIKE', 'id_colegiado', Parent.dw_lista, sql_nuevo, '1', '')
//f_sql('sle_buscar', 'LIKE', 'concepto', Parent.dw_lista, sql_nuevo, '1', '')
//f_sql('sle_buscar', 'LIKE', 'forma_de_pago', Parent.dw_lista, sql_nuevo, '1', '')
//f_sql('sle_buscar', 'LIKE', 'datos_bancarios', Parent.dw_lista, sql_nuevo, '1', '')
//f_sql('sle_buscar', 'LIKE', 'id_colegiado', Parent.dw_lista, sql_nuevo, '1', '')

parent.dw_lista.modify("DataWindow.Table.Select= ~""+ sql_nuevo + "~"")

//concepto = dw_lista_datos.GetitemString(1, 'concepto')
//fp = dw_lista_datos.GetitemString(1, 'forma_pago')
//
//dw_lista.retrieve(concepto,fp)





end event

type cb_salir from u_cb within w_musaat_situacion_asegurados
string tag = "texto=general.salir"
integer x = 2885
integer y = 1444
integer width = 448
integer height = 96
integer taborder = 40
string text = "&Salir"
end type

event clicked;call super::clicked;close(Parent)
end event

type cb_1 from commandbutton within w_musaat_situacion_asegurados
boolean visible = false
integer x = 2903
integer y = 800
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "none"
end type

type st_mensajes from u_st within w_musaat_situacion_asegurados
integer x = 1614
integer y = 1456
integer width = 1147
integer height = 76
integer weight = 700
fontcharset fontcharset = ansi!
long textcolor = 255
string text = ""
end type

type cb_actualizar from u_cb within w_musaat_situacion_asegurados
string tag = "texto=general.actualizar_datos"
integer x = 1083
integer y = 1444
integer width = 503
integer height = 96
integer taborder = 60
string text = "Actualizar datos"
end type

event clicked;call super::clicked;// Fase 1 : Grabando nuevas cuotas
wf_mensaje_pantalla('Grabando datos...') 
dw_lista.update()

// Fase 2: inhabiliatacion de la botonera
cb_listado.enabled = false
cb_actualizar.enabled = false
wf_mensaje_pantalla('Datos actualizados.') 

return 1
end event

type cb_listado from u_cb within w_musaat_situacion_asegurados
string tag = "texto=musaat.listado_variaciones"
integer x = 571
integer y = 1444
integer width = 503
integer height = 96
integer taborder = 10
string text = "Listado variaciones"
end type

event clicked;call super::clicked;integer Net

Net = MessageBox(g_idioma.of_getmsg('msg_musaat.imprimir_listado',"Imprimir Listado"),g_idioma.of_getmsg('msg_musaat.desea_imprimir_listado',"$$HEX1$$bf00$$ENDHEX$$Desea imprimir el listado? "), Question!, OKCancel!, 2)

IF Net = 1 THEN dw_listado.print()

end event

type cb_generar from u_cb within w_musaat_situacion_asegurados
string tag = "texto=general.generar"
integer x = 59
integer y = 1444
integer width = 503
integer height = 96
integer taborder = 70
string text = "Generar"
end type

event clicked;call super::clicked;string docname,named,extension
integer value

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02

value = GetFileOpenName("Selecione Fichero de Asegurados.", &
		+ docname, named, "XLS, TXT" , &
		+ "Excel Files (*.XLS),*.XLS,Text Files (*.TXT),*.TXT")
		
extension = RightA(named,3)

CHOOSE CASE upper(extension)
	CASE 'TXT'
		Parent.trigger event csd_generar_conceptos_domiciliables(docname,value)
	case 'XLS'
		Parent.trigger event csd_cargar_datos_xls(docname,value)
	CASE ELSE		
END CHOOSE

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02

end event

type dw_lista from u_dw within w_musaat_situacion_asegurados
integer x = 59
integer y = 56
integer width = 3360
integer height = 1356
integer taborder = 30
string dataobject = "d_musaat_gestion_src"
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

type oleobject_1 from oleobject within w_musaat_situacion_asegurados descriptor "pb_nvo" = "true" 
end type

on oleobject_1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on oleobject_1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

