HA$PBExportHeader$w_fases_libros.srw
forward
global type w_fases_libros from w_response
end type
type cb_3 from commandbutton within w_fases_libros
end type
type dw_1 from u_dw within w_fases_libros
end type
type cb_1 from commandbutton within w_fases_libros
end type
type cb_2 from commandbutton within w_fases_libros
end type
type dw_2 from u_dw within w_fases_libros
end type
end forward

global type w_fases_libros from w_response
integer x = 214
integer y = 221
integer width = 3067
integer height = 1600
cb_3 cb_3
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
dw_2 dw_2
end type
global w_fases_libros w_fases_libros

type variables
DataWindowChild i_dwc_arquitectos,i_dwc_dir_obra,i_dwc_constructor,i_dwc_propietario, i_dwc_coordinador_seguridad
w_fases_detalle i_w
//string i_registro
end variables

event open;string tipo_act,tipo_obra, descrip, autor_proyecto, director_proyecto, coor_seguridad
string municipio,emplaz,provincia
long i
i_w = g_detalle_fases

f_centrar_ventana(this)

//select n_registro into :i_registro from fases where id_fase= :g_st_fases_libro.id_fase ;

choose case g_st_fases_libro.tipo
	case 'LO'
		this.title = 'Libro de $$HEX1$$d300$$ENDHEX$$rdenes'
		dw_1.dataobject = 'd_fases_libros_libro_orden'
		
	case 'LI'
		this.title = 'Libro de Incidencias'
		dw_1.dataobject = 'd_fases_libros_libro_incid'	
		dw_1.TriggerEvent("csd_oculta")
		dw_1.TriggerEvent("csd_calendario")
		
		if g_colegio='COAATNA' then dw_1.object.arquitecto_t.text='Retirado por:'
end choose

dw_1.settransobject(SQLCA)
dw_1.GetChild('director_obra',i_dwc_dir_obra)
dw_1.GetChild('arquitecto',i_dwc_arquitectos)
dw_1.GetChild('constructor',i_dwc_constructor)
dw_1.GetChild('propietario',i_dwc_propietario)
dw_1.GetChild('seleccion_coordinador_seguridad',i_dwc_coordinador_seguridad)
i_dwc_dir_obra.settransobject(sqlca)
i_dwc_dir_obra.InsertRow (0)
i_dwc_arquitectos.settransobject(sqlca)
i_dwc_arquitectos.InsertRow (0)
i_dwc_constructor.settransobject(sqlca)
i_dwc_constructor.InsertRow (0)
i_dwc_propietario.settransobject(sqlca)
i_dwc_propietario.InsertRow (0)
i_dwc_coordinador_seguridad.settransobject(sqlca)
i_dwc_coordinador_seguridad.InsertRow (0)

dw_1.retrieve(g_st_fases_libro.id_docu)

if dw_1.rowcount() = 0 then
	cb_3.enabled=false
	cb_2.enabled=true
	dw_1.insertrow(0)
	dw_1.setitem(1,'n_libro',g_st_fases_libro.n_libro)
	dw_1.setitem(1,'fecha',string(g_st_fases_libro.fecha,'dd/mm/yyyy'))
	dw_1.setitem(1,'fecha_ret',string(g_st_fases_libro.fecha_ret,'dd/mm/yyyy'))
	dw_1.setitem(1,'contrato',g_st_fases_libro.registro)
	dw_1.setitem(1,'id_docu',g_st_fases_libro.id_docu)
	///*** SCP-1660. Se rellena el campo que guarda el n$$HEX2$$ba002000$$ENDHEX$$de visado en caso de que exista. Alexis. 19/09/2011 ***///
	if lower(dw_1.describe("n_visado.name")) = 'n_visado' then 
		dw_1.setitem(1,'n_visado',g_st_fases_libro.visado)
	end if	
	///*** Fin SCP-1660 ***///
	
	choose case g_st_fases_libro.tipo
		case 'LO'
			dw_1.setitem(1,'director_obra_texto',f_fases_colegiados_fase(g_st_fases_libro.id_fase))
			dw_1.setitem(1,'arquitecto_texto',f_fases_colegiados_fase(g_st_fases_libro.id_fase))
			dw_1.setitem(1,'propietario_texto',f_fases_clientes_fase_sin_nif(g_st_fases_libro.id_fase))
		case 'LI'
			dw_1.setitem(1,'colegio',g_colegio)
			dw_1.setitem(1,'fecha_entrega',today())
	end choose
	
//	SELECT fases.fase, fases.tipo_trabajo INTO :tipo_act,:tipo_obra 
//	FROM fases  WHERE fases.id_fase = :g_st_fases_libro.id_fase ;
//	dw_1.setitem(1,'obra',f_dame_desc_tipo_actuacion(tipo_act)+ ' - ' + &
//		f_dame_desc_tipo_obra(tipo_obra))
		
	SELECT fases.descripcion INTO :descrip 
	FROM fases  WHERE fases.id_fase = :g_st_fases_libro.id_fase ;
	dw_1.setitem(1,'obra', descrip)
		
//	if i_dwc_arquitectos.rowcount() > 0 then
//		if g_st_fases_libro.tipo='LO' then
//			dw_1.setitem(1,'director_obra',i_dwc_arquitectos.getitemstring(1,'id_col'))
//		end if
//		dw_1.setitem(1,'arquitecto',i_dwc_arquitectos.getitemstring(1,'id_col'))
//	end if
//	if i_dwc_propietario.rowcount() > 0 then
//		if g_st_fases_libro.tipo='LO' then
//			dw_1.setitem(1,'constructor',i_dwc_propietario.getitemstring(1,'id_cliente'))
//		end if
//		dw_1.setitem(1,'propietario',i_dwc_propietario.getitemstring(1,'id_cliente'))
//	end if	
	
	dw_1.setitem(1,'emplazamiento',f_dame_direccion_contrato(g_st_fases_libro.id_fase))

	if (g_colegio = 'COAATGUI' or g_colegio = 'COAATLE') and g_st_fases_libro.tipo = 'LI' then dw_1.setitem(1, 'coordinador_seguridad', f_fases_colegiados_fase(g_st_fases_libro.id_fase))
	
	if g_colegio = 'COAATNA' then
		
		SELECT poblaciones.descripcion,provincias.nombre INTO :municipio,:provincia FROM fases,poblaciones,provincias  
		WHERE ( fases.poblacion = poblaciones.cod_pob ) and (poblaciones.provincia=provincias.cod_provincia) and  	( ( fases.id_fase = :g_st_fases_libro.id_fase ) )   ;
		if lower(dw_1.describe("municipio.name")) = 'municipio' then dw_1.setitem(1,'municipio',municipio) 		
		if lower(dw_1.describe("emplazamiento.name")) = 'emplazamiento' then 
			emplaz=f_musaat_devuelve_emplazamiento_fase(g_st_fases_libro.id_fase)
			emplaz+=', '+municipio+' ('+provincia+')'
			dw_1.setitem(1,'emplazamiento',emplaz)
		end if
		if lower(dw_1.describe("coordinador.name")) = 'coordinador' then dw_1.setitem(1,'coordinador',f_fases_colegiados_fase(g_st_fases_libro.id_fase))
	end if
	
	if g_colegio = 'COAATLE' and g_st_fases_libro.tipo = 'LI' then 
		SELECT poblaciones.descripcion,provincias.nombre INTO :municipio,:provincia FROM fases,poblaciones,provincias  
		WHERE ( fases.poblacion = poblaciones.cod_pob ) and (poblaciones.provincia=provincias.cod_provincia) and  	( ( fases.id_fase = :g_st_fases_libro.id_fase ) )   ;
		if lower(dw_1.describe("municipio.name")) = 'municipio' then dw_1.setitem(1,'municipio',municipio) 		
		if lower(dw_1.describe("emplazamiento.name")) = 'emplazamiento' then 
			emplaz=f_musaat_devuelve_emplazamiento_fase(g_st_fases_libro.id_fase)
			dw_1.setitem(1,'emplazamiento',emplaz)
		end if
		
	end if	
	
	//Cambio Luis COAM-157
	if (g_colegio = 'COAATMCA' and dw_1.dataobject = 'd_fases_libros_libro_incid')then
		
		string desc_tipo_via, cp, poblacion, cod_tipo_via, nombre_calle, n_calle, cod_pob,id_fase
				
		id_fase = i_w.dw_1.getitemstring(1,'id_fase')
		SELECT fases.tipo_via_emplazamiento,  fases.emplazamiento,  fases.n_calle,   fases.poblacion INTO :cod_tipo_via,   :nombre_calle,   :n_calle,   :cod_pob  
		FROM fases WHERE ( fases.id_fase = :id_fase );
		
		desc_tipo_via = f_dame_desc_tipo_via(cod_tipo_via)
		if f_es_vacio(desc_tipo_via) then desc_tipo_via = ''
		if f_es_vacio(nombre_calle) then nombre_calle = ''
		if f_es_vacio(n_calle) then n_calle = ''
		cp = f_devuelve_cod_postal(cod_pob)
		if f_es_vacio(cp) then cp = ''
		poblacion = f_dame_poblacion(cod_pob)
		if f_es_vacio(poblacion) then poblacion = ''
		
		dw_1.setitem(1,'emplazamiento',desc_tipo_via + ' ' + nombre_calle + ' ' + n_calle)
		dw_1.setitem(1,'municipio',cp + ' - ' + poblacion)
		
		for i = 1 to i_w.idw_fases_arquitectos.rowcount() 
			if(i_w.idw_fases_arquitectos.getitemstring(i,'tipo_a') = 'S')then
				if not(f_es_vacio(autor_proyecto))then
					autor_proyecto = autor_proyecto + '; '
				end if
				autor_proyecto = autor_proyecto + i_w.idw_fases_arquitectos.getitemstring(i,'apellidos') +', '+ i_w.idw_fases_arquitectos.getitemstring(i,'nombre')
			end if
			if(i_w.idw_fases_arquitectos.getitemstring(i,'tipo_d') = 'S')then
				if not(f_es_vacio(director_proyecto))then
					director_proyecto = director_proyecto + '; '
				end if
				director_proyecto = director_proyecto + i_w.idw_fases_arquitectos.getitemstring(i,'apellidos') +', '+ i_w.idw_fases_arquitectos.getitemstring(i,'nombre')
			end if
			if not(f_es_vacio(coor_seguridad))then
				coor_seguridad = coor_seguridad + '; '
			end if
			coor_seguridad = coor_seguridad + i_w.idw_fases_arquitectos.getitemstring(i,'apellidos') +', '+ i_w.idw_fases_arquitectos.getitemstring(i,'nombre')
		next
		for i = 1 to i_w.idw_fases_colegiados.rowcount() 
			if(i_w.idw_fases_colegiados.getitemstring(i,'tipo_d') = 'S')then
				if not(f_es_vacio(director_proyecto))then
					director_proyecto = director_proyecto + '; '
				end if
				director_proyecto = director_proyecto + i_w.idw_fases_colegiados.getitemstring(i,'compute_1')
			end if
		next
		
			dw_1.setitem(1,'autor_proyecto',autor_proyecto)
			dw_1.setitem(1,'direccion',director_proyecto)
			// Cambiado por Eloy a petici$$HEX1$$f300$$ENDHEX$$n de Mateo Moya. El coordinador suele ser el colegiado, no el arquitecto.
			//dw_1.setitem(1,'coordinador_seguridad',coor_seguridad)
			dw_1.setitem(1,'coordinador_seguridad',f_fases_colegiados_fase(g_st_fases_libro.id_fase))
			if(i_w.dw_1.getitemstring(1,'fase') = '04' or i_w.dw_1.getitemstring(1,'fase') = '05')then
				dw_1.setitem(1,'autor_estudio_seguridad',coor_seguridad)
			end if			
	end if
	//fin cambio
end if

end event

on w_fases_libros.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_2
end on

on w_fases_libros.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_2)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_libros
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_libros
end type

type cb_3 from commandbutton within w_fases_libros
integer x = 1778
integer y = 1352
integer width = 361
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
end type

event clicked;call super::clicked;call super::clicked;

string ls_concatena
int i

CHOOSE CASE g_st_fases_libro.tipo
	CASE 'LO'
		choose case g_colegio
			case "COAATGUI" 
				dw_2.dataobject = 'd_fases_libros_etiquetas_lib_orden_gui'
			case 'COAATNA'
				dw_2.dataobject = 'd_fases_libros_etiquetas_lib_orden_na'
			case 'COAATMCA'
            		dw_2.dataobject = 'd_fases_libros_etiquetas_lib_orden_mca'            

			case else
				dw_2.dataobject = 'd_fases_libros_etiquetas_lib_orden'
	end choose
	CASE 'LI'
		CHOOSE CASE g_colegio
			CASE "COAATLE"
				dw_2.dataobject = 'd_fases_libros_etiquetas_lib_incid2'	
			CASE "COAATGUI"
				dw_2.dataobject = 'd_fases_libros_etiquetas_lib_incid_gui'
			CASE "COAATNA"
				dw_2.dataobject = 'd_fases_etiqueta_libro_incidencias_na'
			case 'COAATMCA'
				dw_2.dataobject = 'd_fases_libros_etiquetas_lib_incid_mca'				
			CASE ELSE
				dw_2.dataobject = 'd_fases_libros_etiquetas_lib_incid'	
		END CHOOSE
END CHOOSE

dw_2.settransobject(SQLCA)
dw_2.retrieve(g_st_fases_libro.id_docu)
dw_2.modify("t_29.text='"+ g_st_fases_libro.registro + "'")
dw_2.modify("t_30.text='"+ string(g_st_fases_libro.fecha,'dd/mm/yy') + "'")
dw_2.modify("t_37.text='"+ g_st_fases_libro.n_libro + "'")
dw_2.modify("t_31.text='"+ g_st_fases_libro.registro + "'")
dw_2.modify("t_32.text='"+ string(g_st_fases_libro.fecha,'dd/mm/yy') + "'")
dw_2.modify("t_38.text='"+ g_st_fases_libro.n_libro + "'")

CHOOSE CASE g_st_fases_libro.tipo
	CASE 'LO'
		dw_2.modify("t_33.text='"+ g_st_fases_libro.registro + "'")
		dw_2.modify("t_34.text='"+ string(g_st_fases_libro.fecha,'dd/mm/yy') + "'")
		dw_2.modify("t_35.text='"+ g_st_fases_libro.registro + "'")
		dw_2.modify("t_36.text='"+ string(g_st_fases_libro.fecha,'dd/mm/yy') + "'")
		dw_2.modify("t_39.text='"+ g_st_fases_libro.n_libro + "'")
		dw_2.modify("t_40.text='"+ g_st_fases_libro.n_libro + "'")
		
		if g_colegio = "COAATGUI" then dw_2.setitem(1, 'n_expediente', f_dame_exp(g_st_fases_libro.id_fase))
		
	CASE 'LI'
		if g_colegio = "COAATLE" then
			for i = 1 to g_st_fases_libro.n_col
				if i > 1  then ls_concatena+= ';  '
				ls_concatena += f_colegiado_n_col(g_st_fases_libro.colegiado[i]) +' '+f_colegiado_apellido( g_st_fases_libro.colegiado[i] )
			next
			dw_2.modify("t_11.text='"+ ls_concatena + "'")
		else
			dw_2.modify("t_29.text='"+ f_dame_exp(g_st_fases_libro.id_fase) + "'")
			dw_2.modify("t_31.text='"+ f_dame_exp(g_st_fases_libro.id_fase) + "'")
		end if
END CHOOSE

if g_colegio='COAATMCA' then
	 if(dw_2.dataobject = 'd_fases_libros_etiquetas_lib_orden_mca')then
			dw_2.setitem(1,'f_comienzo',dw_1.getitemstring(1,'fecha'))
			dw_2.setitem(1,'f_terminacion',dw_1.getitemstring(1,'fecha_ret'))
			dw_2.setitem(1,'autor_encargo',dw_1.getitemstring(1,'autor_encargo'))
	end if

	OpenWithParm(w_etiquetas_posicionador,dw_2)
	return
end if

// Ventana de selecci$$HEX1$$f300$$ENDHEX$$n de impresora para que cojan la de etiquetas
PrintSetup()

// ICN-286 Se ha dejado SOLO para Libro Incidencias
// Solo quieren imprimir 2 etiquetas, basta con las 2 de la parte superior.
if g_colegio = 'COAATNA' and g_st_fases_libro.tipo='LI' then dw_2.RowsCopy(dw_2.GetRow(), dw_2.RowCount(), Primary!, dw_2, 1, Primary!) // 2 copias 
dw_2.print()

end event

type dw_1 from u_dw within w_fases_libros
event csd_calendario ( )
event csd_oculta ( )
integer x = 110
integer y = 64
integer width = 2821
integer height = 1252
integer taborder = 10
end type

event csd_calendario;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event csd_oculta();
if g_colegio = "COAATLE" then
	this.object.t_7.visible = true
	this.object.t_6.visible = true
	this.object.n_visado.visible = true
	this.object.fecha_entrega.visible = true
else
	this.object.t_7.visible = false
	this.object.t_6.visible = false
	this.object.n_visado.visible = false
	this.object.fecha_entrega.visible = false
end if
end event

event retrieveend;call super::retrieveend;if i_dwc_arquitectos.Retrieve(g_st_fases_libro.id_fase) < 1 THEN
	i_dwc_arquitectos.insertrow(0)
end if
if i_dwc_dir_obra.Retrieve(g_st_fases_libro.id_fase) < 1 THEN
	i_dwc_dir_obra.insertrow(0)
end if
if i_dwc_constructor.Retrieve(g_st_fases_libro.id_fase) < 1 THEN
	i_dwc_constructor.insertrow(0)
end if
if i_dwc_propietario.Retrieve(g_st_fases_libro.id_fase) < 1 THEN
	i_dwc_propietario.insertrow(0)
end if
if i_dwc_coordinador_seguridad.Retrieve(g_st_fases_libro.id_fase) < 1 THEN
	i_dwc_coordinador_seguridad.insertrow(0)
end if

i_dwc_arquitectos.insertrow(1)
i_dwc_dir_obra.insertrow(1)
i_dwc_constructor.insertrow(1)
i_dwc_propietario.insertrow(1)
i_dwc_coordinador_seguridad.insertrow(1)

dw_1.setitem(1,'n_libro',g_st_fases_libro.n_libro)
dw_1.setitem(1,'fecha',string(g_st_fases_libro.fecha,'dd/mm/yyyy'))
dw_1.setitem(1,'fecha_ret',string(g_st_fases_libro.fecha_ret,'dd/mm/yyyy'))
dw_1.setitem(1,'contrato',g_st_fases_libro.registro)
//if g_st_fases_libro.tipo = 'LI' then dw_1.setitem(1,'colegio',g_colegio)
cb_2.enabled=false
DW_1.RESETUPDATE()
end event

event itemchanged;call super::itemchanged;cb_2.enabled=true
cb_3.enabled=false

string prom, arq, ls_coordinador_seguridad
CHOOSE CASE dwo.name
	CASE 'propietario'
		prom = this.getitemstring(1, 'promotor')
		if isnull(prom) then prom = ''
		prom = prom + ' ' + f_dame_cliente(data)
		this.setitem(1, 'promotor', prom)
	CASE 'arquitecto'
		arq = this.getitemstring(1, 'autor_proyecto')
		if isnull(arq) then arq = ''
		arq = arq + ' ' + f_colegiado_apellido(data)
		this.setitem(1, 'autor_proyecto', arq)
		///*** SCP-1660. Se a$$HEX1$$f100$$ENDHEX$$ade caso para el campo de coordinador de seguridad. Alexis. 19/09/2011 ***///
	CASE 'seleccion_coordinador_seguridad'
		ls_coordinador_seguridad = this.getitemstring(1, 'coordinador_seguridad')
		if isnull(ls_coordinador_seguridad) then ls_coordinador_seguridad = ''
		ls_coordinador_seguridad = ls_coordinador_seguridad + ' ' + f_colegiado_apellido(data)
		this.setitem(1, 'coordinador_seguridad', ls_coordinador_seguridad)
		
END CHOOSE

end event

event editchanged;call super::editchanged;cb_2.enabled=true
cb_3.enabled=false
end event

type cb_1 from commandbutton within w_fases_libros
integer x = 2569
integer y = 1352
integer width = 361
integer height = 96
integer taborder = 30
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

type cb_2 from commandbutton within w_fases_libros
integer x = 2176
integer y = 1352
integer width = 361
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Grabar"
end type

event clicked;dw_1.update()
cb_3.enabled=true

end event

type dw_2 from u_dw within w_fases_libros
boolean visible = false
integer x = 137
integer y = 1244
integer width = 581
integer height = 144
integer taborder = 10
string dataobject = "dw_fases_libros_etiquetas_lib_orden"
boolean ib_isupdateable = false
end type

