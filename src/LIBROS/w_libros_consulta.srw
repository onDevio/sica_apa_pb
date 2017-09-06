HA$PBExportHeader$w_libros_consulta.srw
forward
global type w_libros_consulta from w_consulta
end type
end forward

global type w_libros_consulta from w_consulta
integer width = 2112
integer height = 2036
string title = "Consulta de Biblioteca"
end type
global w_libros_consulta w_libros_consulta

type variables
string i_sql_nuevo
end variables

on w_libros_consulta.create
call super::create
end on

on w_libros_consulta.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_libros_consulta
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_libros_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_libros_consulta
integer x = 1559
integer y = 1208
end type

type st_5 from w_consulta`st_5 within w_libros_consulta
end type

type cb_1 from w_consulta`cb_1 within w_libros_consulta
integer x = 402
integer y = 1820
fontcharset fontcharset = ansi!
end type

event cb_1::clicked;call super::clicked;string sql_nuevo,c,cadena
integer comas,i

i_sql_nuevo=g_dw_lista.describe("datawindow.table.select")

dw_1.AcceptText()


// Si todos los campos relativos a pr$$HEX1$$e900$$ENDHEX$$stamos son vac$$HEX1$$ed00$$ENDHEX$$os, traemos libros sin 
// 	tener	en cuenta los pr$$HEX1$$e900$$ENDHEX$$stamos
IF IsNull(dw_1.getitemDateTime(1,'f_prestamo_desde')) AND IsNull(dw_1.getitemDateTime(1,'f_prestamo_hasta')) and &
IsNull(dw_1.getitemString(1,'n_colegiado')) and IsNull(dw_1.getitemString(1,'nombre')) and  IsNull(dw_1.getitemString(1,'apellido_nombresociedad'))THEN
	// OUTER JOIN	
	i_sql_nuevo += ' where libros.id_libro *= prestamos.id_libro'
	
ELSE
// Si hay campos relativos a pr$$HEX1$$e900$$ENDHEX$$stamos con valor, traemos libros que tengan 
// 	pr$$HEX1$$e900$$ENDHEX$$stamos
	i_sql_nuevo += ' where libros.id_libro = prestamos.id_libro'
	
END IF

IF NOT  f_es_vacio(dw_1.GetItemString(1,'nombre')) or NOT f_es_vacio(dw_1.GetItemString(1,'apellido_nombresociedad'))  THEN 
	i_sql_nuevo = f_sql_join(i_sql_nuevo, {'( colegiados.id_colegiado = prestamos.colegiado)'})	
END IF

//f_sql('libros.n_registro','LIKE','n_registro',parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
f_sql('libros.titulo','LIKE','titulo',parent.dw_1,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('libros.autor','LIKE','autor',parent.dw_1,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('libros.editor','LIKE','editor',parent.dw_1,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('libros.prestado','LIKE','prestado',parent.dw_1,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('libros.ubicacion','=','ubicacion',parent.dw_1,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('libros.f_entrada','>=','f_entrada_desde',parent.dw_1,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('libros.f_entrada','<','f_entrada_hasta',parent.dw_1,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('libros.anyo_publicacion','>=','anio_publicacion_desde',parent.dw_1,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('libros.anyo_publicacion','<=','anio_publicacion_hasta',parent.dw_1,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('libros.n_registro','LIKE','n_registro',parent.dw_1,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('libros.sig','LIKE','sig',parent.dw_1,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('libros.tipo_libro','LIKE','tipo_libro',parent.dw_1,i_sql_nuevo,g_tipo_base_datos,'')



// CAMPOS DE LA TABLA Pr$$HEX1$$e900$$ENDHEX$$stamos
f_sql('prestamos.f_prestamo','>=','f_prestamo_desde',parent.dw_1,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('prestamos.f_prestamo','<','f_prestamo_hasta',parent.dw_1,i_sql_nuevo,g_tipo_base_datos,'')

//Si el campo de numero de colegiado no es NULL
IF NOT f_es_vacio(dw_1.GetItemString(1,'n_colegiado'))  THEN 
	f_sql('prestamos.colegiado','=','n_colegiado',parent.dw_1,i_sql_nuevo,g_tipo_base_datos,'')	

END IF
//Si el campo de nombre del colegiado no es NULL
IF NOT f_es_vacio(dw_1.GetItemString(1,'nombre')) THEN 
	f_sql('colegiados.nombre','LIKE','nombre',parent.dw_1,i_sql_nuevo,g_tipo_base_datos,'')	

END IF
//Si el campo de apellido de colegiado no es NULL
IF NOT f_es_vacio(dw_1.GetItemString(1,'apellido_nombresociedad'))  THEN 
	f_sql('colegiados.apellidos','LIKE','apellido_nombresociedad',parent.dw_1,i_sql_nuevo,g_tipo_base_datos,'')	

END IF

//MessageBox('',i_sql_nuevo)

//materias
comas=PosA(dw_1.getitemstring(1,'materias'),',')
if comas =0 then
	if not isnull(dw_1.getitemstring(1,'materias')) then
		cadena= dw_1.getitemstring(1,'materias')
		cadena='%' + cadena + '%'
		i_sql_nuevo=i_sql_nuevo + " AND libros.materias LIKE '" + cadena + "'"		
	end if
else
	for i=1 to LenA(dw_1.getitemstring(1,'materias'))
		c=MidA(dw_1.getitemstring(1,'materias'),i,1)
		if c<>',' then
			cadena=cadena+c
		else
			cadena= trim(cadena)
			cadena='%' + cadena + '%'
			i_sql_nuevo=i_sql_nuevo + " AND libros.materias LIKE '" + cadena + "'"
			cadena=''
		end if
	next
	if LenA(trim(cadena))>0 then
		cadena= trim(cadena)
		cadena='%' + cadena + '%'
		i_sql_nuevo=i_sql_nuevo + " AND libros.materias LIKE '" + cadena + "'"
	end if
end if


//MessageBox('',i_sql_nuevo)

g_dw_lista.modify("Datawindow.table.select=~"" + i_sql_nuevo + "~"")

parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_libros_consulta
integer x = 1024
integer y = 1820
end type

type cb_ayuda from w_consulta`cb_ayuda within w_libros_consulta
integer x = 1568
integer y = 1208
end type

type dw_1 from w_consulta`dw_1 within w_libros_consulta
integer x = 9
integer y = 144
integer width = 2066
integer height = 1608
string dataobject = "d_libros_consulta"
end type

event dw_1::buttonclicked;call super::buttonclicked;string id_persona

g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
g_busqueda.dw="d_lista_busqueda_colegiados"
id_persona=f_busqueda_colegiados()
this.setitem(1,'n_colegiado',f_colegiado_n_col(id_persona))


end event

event dw_1::itemchanged;call super::itemchanged;string nombre, apellido
datetime fp

choose case dwo.name
	case 'n_colegiado'

			select nombre, apellidos into :nombre, :apellido from colegiados where n_colegiado = :data;
			this.SetITem(this.GetRow(),'nombre',nombre)
			this.SetITem(this.GetRow(),'apellido_nombresociedad',apellido)
		
	//se comprueba que la fecha de prestamo desde sea anterior que la fecha de pretamo hasta	
	case 'f_prestamo_hasta'
		fp = this.GetItemDatetime(this.GetRow(),'f_prestamo_desde')
		if datetime(date(data)) < fp then
			messagebox(g_titulo,'La fecha de prestamo hasta no puede ser anterior a la fecha de pr$$HEX1$$e900$$ENDHEX$$stamo desde.')
			return 1
		end if	
	//se comprueba que la fecha de devolucion real desde sea anterior que la fecha de devolucion real hasta	
	case 'f_devolucion_real_hasta'
		fp = this.GetItemDatetime(this.GetRow(),'f_devolucion_real_desde')
		if datetime(date(data)) < fp then
			messagebox(g_titulo,'La fecha de devoluci$$HEX1$$f300$$ENDHEX$$n real hasta no puede ser anterior a la fecha de devoluci$$HEX1$$f300$$ENDHEX$$n real desde.')
			return 1
		end if	
end choose	


end event

