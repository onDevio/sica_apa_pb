HA$PBExportHeader$w_libros_listados.srw
forward
global type w_libros_listados from w_listados
end type
end forward

global type w_libros_listados from w_listados
integer height = 2016
string title = "Listados de Biblioteca"
end type
global w_libros_listados w_libros_listados

on w_libros_listados.create
call super::create
end on

on w_libros_listados.destroy
call super::destroy
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

// Se desplaza el apuntador al primer registro
dw_listados_varios.scrolltorow(1)
dw_listados_varios.setfocus()

// Le quitamos el foco al campo E/S, se seleccionar$$HEX2$$e1002000$$ENDHEX$$en f(tipo de listado)
//dw_listados.SetTabOrder('es_listados',0)

end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_libros_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_libros_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_libros_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_libros_listados
end type

type cb_ver from w_listados`cb_ver within w_libros_listados
end type

event cb_ver::clicked;call super::clicked;string sql, listado,descripcion,id_persona,c,cadena
integer comas,i

dw_listados.accepttext()
dw_1.of_setprintpreview(TRUE)

// Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado

dw_1.of_SetTransObject(SQLCA)
sql = dw_1.describe("datawindow.table.select")

// Se asigna el titulo del informe con la descripcion
descripcion=dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'descripcion')
//messagebox("listado",listado )
//messagebox("descripcion",descripcion )
if listado <> 'd_libros_listados_etiqueta_1' and listado <> 'd_libros_listados_etiqueta_2' then dw_1.object.st_titulo_listado.text = descripcion

//Se verifica el parametro de busqueda para crear el sql
if listado <> 'd_libros_listados_pendientes' and listado <> 'd_libros_listados_prestados' and listado <> 'd_libros_listados_prestados_pendiente' then 
	IF  IsNull(dw_listados.getitemDateTime(1,'f_prestamo_desde')) AND IsNull(dw_listados.getitemDateTime(1,'f_prestamo_hasta')) and &
	IsNull(dw_listados.getitemString(1,'n_colegiado')) and IsNull(dw_listados.getitemString(1,'nombre')) and  IsNull(dw_listados.getitemString(1,'apellido_nombresociedad'))THEN
	
			sql += ' where libros.id_libro *= prestamos.id_libro'
		
	ELSE
		sql += ' where libros.id_libro = prestamos.id_libro'
		
	END IF
	IF NOT  f_es_vacio(dw_listados.GetItemString(1,'nombre')) or NOT f_es_vacio(dw_listados.GetItemString(1,'apellido_nombresociedad'))  THEN 
		sql = f_sql_join(sql, {'( colegiados.id_colegiado = prestamos.colegiado)'})	
	END IF
else
//end if
//
//if listado = 'd_libros_listados_pendientes'  then 
	IF  not IsNull(dw_listados.getitemString(1,'n_colegiado')) or not IsNull(dw_listados.getitemString(1,'nombre')) or not IsNull(dw_listados.getitemString(1,'apellido_nombresociedad'))THEN
		sql += ' and prestamos.colegiado = colegiados.id_colegiado'
	else
		sql += ' and prestamos.colegiado *= colegiados.id_colegiado'
	end if
end if

if  listado = 'd_libros_listados_prestados_pendiente' then
	sql += ' and ((prestamos.f_devolucion_prevista < prestamos.f_devolucion_real)  or (prestamos.f_devolucion_prevista < '+"'"+ string(today(),"yyyy-mm-dd") +"'"+' and prestamos.f_devolucion_real is null))'
	
end if
//
//************************************

f_sql('libros.titulo','LIKE','titulo',parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('libros.autor','LIKE','autor',parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('libros.editor','LIKE','editor',parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('libros.prestado','LIKE','prestado',parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('libros.ubicacion','=','ubicacion',parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('libros.f_entrada','>=','f_entrada_desde',parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('libros.f_entrada','<','f_entrada_hasta',parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('libros.anyo_publicacion','>=','anio_publicacion_desde',parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('libros.anyo_publicacion','<=','anio_publicacion_hasta',parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('libros.n_registro','LIKE','n_registro',parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('libros.sig','LIKE','sig',parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('libros.tipo_libro','LIKE','tipo_libro',parent.dw_listados,sql,g_tipo_base_datos,'')


// CAMPOS DE LA TABLA Pr$$HEX1$$e900$$ENDHEX$$stamos
f_sql('prestamos.f_prestamo','>=','f_prestamo_desde',parent.dw_listados,sql,g_tipo_base_datos,'')
f_sql('prestamos.f_prestamo','<','f_prestamo_hasta',parent.dw_listados,sql,g_tipo_base_datos,'')
IF not IsNull(dw_listados.getitemString(1,'n_colegiado')) then 
	f_sql('prestamos.colegiado','=','n_colegiado',parent.dw_listados,sql,g_tipo_base_datos,'')
end if


//colegiados
//Si el campo de nombre del colegiado no es NULL
IF NOT f_es_vacio(dw_listados.GetItemString(1,'nombre')) THEN 
	f_sql('colegiados.nombre','LIKE','nombre',parent.dw_listados,sql,g_tipo_base_datos,'')	

END IF
//Si el campo de apellido de colegiado no es NULL
IF NOT f_es_vacio(dw_listados.GetItemString(1,'apellido_nombresociedad'))  THEN 
	f_sql('colegiados.apellidos','LIKE','apellido_nombresociedad',parent.dw_listados,sql,g_tipo_base_datos,'')	

END IF


//materias
comas=PosA(dw_listados.getitemstring(1,'materias'),',')
if comas =0 then
	if not isnull(dw_listados.getitemstring(1,'materias')) then
		cadena= dw_listados.getitemstring(1,'materias')
		cadena='%' + cadena + '%'
		sql=sql + " AND libros.materias LIKE '" + cadena + "'"		
	end if
else
	for i=1 to LenA(dw_listados.getitemstring(1,'materias'))
		c=MidA(dw_listados.getitemstring(1,'materias'),i,1)
		if c<>',' then
			cadena=cadena+c
		else
			cadena= trim(cadena)
			cadena='%' + cadena + '%'
			sql=sql + " AND libros.materias LIKE '" + cadena + "'"
			cadena=''
		end if
	next
	if LenA(trim(cadena))>0 then
		cadena= trim(cadena)
		cadena='%' + cadena + '%'
		sql=sql + " AND libros.materias LIKE '" + cadena + "'"
	end if
end if
//messagebox("",sql )


dw_1.SetTransobject(sqlca)
dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
dw_1.retrieve()

//Se pasa por el filtro para evitar repeticiones y realizar la b$$HEX1$$fa00$$ENDHEX$$squeda por fecha y por colegiado
int j,k
string id_libro,f_pres,f_pres_col_desde,f_pres_col_hasta,f_dev_real,f_dev_real_desde,f_dev_real_hasta,coleg

//Introduce el n$$HEX2$$ba002000$$ENDHEX$$de colegiado en el campo computado n_col
if listado <> 'd_libros_listados_etiqueta_1' and listado <> 'd_libros_listados_etiqueta_2' then
	if dw_listados_varios.getrow()=1 then
	else
		
		for k=1 to dw_1.rowcount()
			//dw_1.setitem(k,'n_col',f_colegiado_n_col(dw_1.getitemstring(k,'prestamos_colegiado')))
		next
	end if
end if

if dw_1.RowCount() > 0 then
	
	g_libros_consulta.f_prestamo_desde=dw_listados.getitemDateTime(1,'f_prestamo_desde')
	g_libros_consulta.f_prestamo_hasta=dw_listados.getitemDateTime(1,'f_prestamo_hasta')
	
	//fecha pr$$HEX1$$e900$$ENDHEX$$stamo
	if string(g_libros_consulta.f_prestamo_desde)<>"01/01/00 00:00:00" and string(g_libros_consulta.f_prestamo_hasta)<>"01/01/00 00:00:00" then

			f_pres_col_desde=string(date(g_libros_consulta.f_prestamo_desde))
			f_pres_col_hasta=string(date(g_libros_consulta.f_prestamo_hasta))
			dw_1.SetFilter("string(prestamos_f_prestamo) >='"+f_pres_col_desde+"' and string(prestamos_f_prestamo) <='"+ f_pres_col_hasta +"'")
			dw_1.Filter()
			dw_1.setfilter("")
			
	end if

	if listado<>'d_libros_listados_ficha_libro' then
		for i=1 to dw_1.rowcount()
			id_libro=dw_1.getitemstring(i,'id_libro')
			for j=i+1 to dw_1.rowcount()
				dw_1.setrow(j)
				if id_libro=dw_1.getitemstring(j,'id_libro') then
					dw_1.deleterow(dw_1.getrow())
					j=j - 1
				end if
			next
		next
	end if
	
end if
	
dw_1.ResetUpdate() 

// Al final:
if dw_1.rowcount() > 0 then
	dw_1.visible 		  = true
	// No tiene reports y no son etiquetas, hacemos el preview
	if dw_1.Describe("DataWindow.Nested") = "no" and dw_1.describe("Datawindow.Label.Columns") = "0" then
		dw_1.event pfc_printpreview()
	end if
	this.enabled        = false
	cb_zoom.enabled     = true
	cb_imprimir.enabled = true
	cb_guardar.enabled  = true
	cb_escala.enabled   = true
	cb_ordenar.enabled  = true
else
	messagebox(g_titulo,'No se han encontrados registros segun las especificaciones.')
end if
end event

type cb_salir from w_listados`cb_salir within w_libros_listados
end type

type dw_listados from w_listados`dw_listados within w_libros_listados
integer y = 204
integer width = 2057
integer height = 1660
string dataobject = "d_libros_consulta"
boolean ib_isupdateable = false
end type

event dw_listados::csd_oculta;string  dwactual, descactual
integer nro_opcion

dwactual  = dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'dw')
descactual= dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'descripcion')
nro_opcion= dw_listados_varios.getrow()

// Se oculta la opcion del tipo de registro del dw de consulta  por presentar la de Listados
//dw_listados.object.es.visible				= false // la de consulta
//dw_listados.object.es_listados.visible	= True // la de listados
//
// aqui va el campo por donde se filtrara
// this.object.departamento.visible   = (pos("d_listado_1 d_listado_2", lower(dwactual)) > 1)
// this.object.departamento_t.visible = this.object.departamento.visible


// CASE=1 Listados Pendientes para enviar a Cartas
// CASE=2 Listados Libros
// CASE=3 Listados n$$HEX2$$ba002000$$ENDHEX$$Registro para enviar a Etiquetas

//CHOOSE CASE nro_opcion
//	CASE 1,3
		//dw_listados.object.n_registro.visible     = true
		//dw_listados.object.n_registro_t.visible   = true
		//dw_listados.object.n_colegiado.visible    = true
		//dw_listados.object.n_colegiado_t.visible  = true
//		dw_listados.object.titulo.visible         = true
//		dw_listados.object.titulo_t.visible       = true
//		dw_listados.object.autor.visible          = true
//		dw_listados.object.autor_t.visible        = true
//		dw_listados.object.materias.visible       = true
//		dw_listados.object.materias_t.visible     = true	
//		dw_listados.object.isbn.visible           = false
//		dw_listados.object.isbn_t.visible         = false	
//		dw_listados.object.f_devolucion_real_desde.visible = false
//		dw_listados.object.f_devolucion_real_hasta.visible = false
//		dw_listados.object.f_devolucion_real_t.visible     = false
//	   if nro_opcion = 1 then
//			dw_listados.setitem(1,'prestado','S')
//			dw_listados.object.prestado.visible    = false
//			dw_listados.object.prestado_t.visible  = false
//			dw_listados.object.f_prestamo_desde.visible  = false
//			dw_listados.object.f_prestamo_t.visible      = false
//			dw_listados.object.f_prestamo_hasta.visible  = false
//			dw_listados.object.hasta_t.visible           = false
//			dw_listados.object.desde_t.visible           = false
//		else
//			dw_listados.object.prestado.visible    = true
//			dw_listados.object.prestado_t.visible  = true
//			dw_listados.object.f_prestamo_desde.visible = true
//			dw_listados.object.f_prestamo_t.visible     = true
//			dw_listados.object.f_prestamo_hasta.visible = true
//			dw_listados.object.hasta_t.visible          = true
//			dw_listados.object.desde_t.visible          = true
//		end if
		
//	CASE 2   

		//dw_listados.setitem(1,'prestado','%')
	
//	   dw_listados.object.n_registro.visible     = true
//		dw_listados.object.n_registro_t.visible   = true
//		dw_listados.object.n_colegiado.visible    = true
//		dw_listados.object.n_colegiado_t.visible  = true
//		dw_listados.object.titulo.visible         = true
//		dw_listados.object.titulo_t.visible       = true
//		dw_listados.object.autor.visible          = true
//		dw_listados.object.autor_t.visible        = true
//		dw_listados.object.materias.visible       = true
//		dw_listados.object.materias_t.visible     = true	
//		dw_listados.object.isbn.visible           = true
//		dw_listados.object.isbn_t.visible         = true	
//		dw_listados.object.f_prestamo_desde.visible        = true
//		dw_listados.object.f_prestamo_t.visible      	   = true
//		dw_listados.object.f_prestamo_hasta.visible        = true
//		dw_listados.object.hasta_t.visible                 = true
//		dw_listados.object.desde_t.visible                 = true
//		dw_listados.object.f_devolucion_real_desde.visible = true
//		dw_listados.object.f_devolucion_real_hasta.visible = true
//		dw_listados.object.f_devolucion_real_t.visible     = true
//		dw_listados.object.prestado.visible    = true
//		dw_listados.object.prestado_t.visible  = true
//	CASE 3
//		dw_listados.object.n_registro.visible      = true
//		dw_listados.object.n_registro_t.visible    = true
//		dw_listados.object.titulo.visible          = true
//		dw_listados.object.titulo_t.visible        = true
//		dw_listados.object.autor.visible           = true
//		dw_listados.object.autor_t.visible         = true	
//		dw_listados.object.isbn.visible            = true
//		dw_listados.object.isbn_t.visible          = true	
//		// Se coloca al tipo de registro (es) = '%' para que traiga todos los registros
		//setitem(1,'es_listados','%')
		// Se coloca al tipo de registro (es) en funci$$HEX1$$f300$$ENDHEX$$n del tipo de listado
//		if nro_opcion = 2 OR nro_opcion = 3 then 
//			setitem(1,'es_listados','E')
//		elseif nro_opcion = 5 OR nro_opcion = 6 then
//			setitem(1,'es_listados','S')
//		end if
//end choose
end event

event dw_listados::itemchanged;call super::itemchanged;datetime fp
datetime fd
string  nombre,apellido
choose case dwo.name
	//se comprueba que la fecha de pr$$HEX1$$e900$$ENDHEX$$stamo desde sea anterior que la fecha de pr$$HEX1$$e900$$ENDHEX$$stamo hasta	
		case 'f_prestamo_hasta'
					fp = this.GetItemDatetime(this.GetRow(),'f_prestamo_desde')
					if datetime(date(data)) < fp then
						messagebox(g_titulo,'La fecha de prestamo hasta no puede ser anterior a la fecha de pr$$HEX1$$e900$$ENDHEX$$stamo desde.')
						return 1
					end if	
	//se comprueba que la fecha de devolucion real desde sea anterior que la fecha de devolucion real hasta	
		case 'f_devolucion_real_hasta'
					fd = this.GetItemDatetime(this.GetRow(),'f_devolucion_real_desde')
					if datetime(date(data)) < fd then
						messagebox(g_titulo,'La fecha de devoluci$$HEX1$$f300$$ENDHEX$$n real hasta no puede ser anterior a la fecha de devoluci$$HEX1$$f300$$ENDHEX$$n real desde.')
						return 1
					end if	
		case 'n_colegiado'

			select nombre, apellidos into :nombre, :apellido from colegiados where n_colegiado = :data;
			this.SetITem(this.GetRow(),'nombre',nombre)
			this.SetITem(this.GetRow(),'apellido_nombresociedad',apellido)
end choose	
end event

event dw_listados::buttonclicked;call super::buttonclicked;string id_persona

g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
g_busqueda.dw="d_lista_busqueda_colegiados"
id_persona=f_busqueda_colegiados()
this.setitem(1,'n_colegiado',f_colegiado_n_col(id_persona))

end event

type cb_imprimir from w_listados`cb_imprimir within w_libros_listados
end type

type cb_zoom from w_listados`cb_zoom within w_libros_listados
end type

type cb_esp from w_listados`cb_esp within w_libros_listados
end type

type cb_guardar from w_listados`cb_guardar within w_libros_listados
end type

type cb_escala from w_listados`cb_escala within w_libros_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_libros_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_libros_listados
end type

type dw_1 from w_listados`dw_1 within w_libros_listados
integer width = 3616
end type

event dw_1::retrieveend;//string descripcion
//integer i
//
//descripcion=dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'descripcion')
//dw_1.object.t_1.text = descripcion
//
//
//
//if (descripcion='Libros Pendientes de Devoluci$$HEX1$$f300$$ENDHEX$$n para Exportar a Cartas') then
//	for i=1 to this.rowcount()
//		this.setitem(i,'prestamos_colegiado', f_colegiado_n_col(this.getitemstring(i,'prestamos_colegiado')))
//		//this.setitem(i,'compute_1', f_colegiado_apellido(this.object.prestamos_colegiado))	
//	next	
//	this.ResetUpdate() 
//	
//end if
end event

