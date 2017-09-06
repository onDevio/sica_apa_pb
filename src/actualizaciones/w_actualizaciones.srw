HA$PBExportHeader$w_actualizaciones.srw
forward
global type w_actualizaciones from w_response
end type
type sle_1 from singlelineedit within w_actualizaciones
end type
type pb_buscar from picturebutton within w_actualizaciones
end type
type st_1 from statictext within w_actualizaciones
end type
type st_2 from statictext within w_actualizaciones
end type
type pb_salir from picturebutton within w_actualizaciones
end type
type pb_actualizar from picturebutton within w_actualizaciones
end type
type gb_1 from groupbox within w_actualizaciones
end type
type dw_1 from u_dw within w_actualizaciones
end type
type dw_sucesos from u_dw within w_actualizaciones
end type
type st_3 from statictext within w_actualizaciones
end type
type st_referencia from statictext within w_actualizaciones
end type
type st_aviso from statictext within w_actualizaciones
end type
type st_texto from statictext within w_actualizaciones
end type
end forward

global type w_actualizaciones from w_response
integer width = 2331
integer height = 1368
long backcolor = 80269524
event csd_tabla_actualizaciones ( )
event csd_detectar_actualizacion_ftp ( )
sle_1 sle_1
pb_buscar pb_buscar
st_1 st_1
st_2 st_2
pb_salir pb_salir
pb_actualizar pb_actualizar
gb_1 gb_1
dw_1 dw_1
dw_sucesos dw_sucesos
st_3 st_3
st_referencia st_referencia
st_aviso st_aviso
st_texto st_texto
end type
global w_actualizaciones w_actualizaciones

type prototypes

end prototypes

type variables
string filename
string is_nombre_fichero,i_modalidad
end variables

forward prototypes
public function integer f_suceso (string informe, string categoria, string referencia)
end prototypes

event csd_tabla_actualizaciones();integer li_retorno
integer value, file_num,file_dest, file_log
string pathname,tabla, version, linea,descripcion,accion,t_version
datastore ds_tabla
oleobject i_zip
string archivo_version
string sql
string cadena_log

integer i

pathname = g_directorio_actualizaciones + 'actualizaciones.txt'
filename = 'actualizaciones.txt'

if RightA(pathname,3)='txt' then
	//comprobamos que el fichero existe
	file_num=fileopen(pathname,LineMode!,Read!)
	if file_num<0 then
		//messagebox("Error","No se pudo abrir el fichero")
		//return 0
	else
	
file_dest=fileopen(g_directorio_temporales+'actualizaciones.txt',LineMode!, Write!, LockWrite!, Replace! )

//copiamos los datos al fichero temporal.
do while (fileRead(file_num,linea)>0)
	filewrite(file_dest,linea)
loop
			
//cerramos los ficheros
fileclose(file_dest)
fileclose(file_num)
			
//seleccionamos el dw y la version de esa tabla correspondiente a la tb de la base de datos a actualizar
//select sql,descripcion,version into :sql, :descripcion,:t_version from actualizaciones where tabla=:tabla;

date hoy
hoy=today()		
		
sql = 'select id_actualizacion, tabla, sql, version, f_actualizacion, descripcion from actualizaciones'

string ls_sql_syntax,ls_style,ls_dw_err,ls_dw_syntax
 		
//Generamos el datawindow dinamic$$HEX1$$e100$$ENDHEX$$mente
ls_sql_syntax=sql
ls_style = "style(type=grid) " //El tipo del datawindow ser$$HEX2$$e1002000$$ENDHEX$$grid
ls_dw_err = ""
ls_dw_syntax = SyntaxFromSQL(sqlca, ls_sql_syntax, ls_style, ls_dw_err)
If ls_dw_err <> "" Then
	f_suceso("No se ha podido realizar la actualizaci$$HEX1$$f300$$ENDHEX$$n.",'3','Tabla Actualizaciones')
	rollback using sqlca;
	Return
End If
			
if (dw_1.Create(ls_dw_syntax))<=0 then 
	f_suceso("No se ha podido realizar la actualizaci$$HEX1$$f300$$ENDHEX$$n.",'3','Tabla Actualizaciones')
	rollback using sqlca;
	Return
end if

//metemos la transacci$$HEX1$$f300$$ENDHEX$$n al dw creado
li_retorno= dw_1.settrans(sqlca)	

st_texto.text= 'Actualizando la tabla Actualizaciones'

dw_1.retrieve()
			
do while dw_1.rowcount()>0
	dw_1.deleterow(1)
loop
dw_1.update()

//hacemos un importfile del fichero temporal sobre el ds
if dw_1.importfile(g_directorio_temporales+filename)<=0 then
	//si falla, deshacemos los cambios con un rollback
	rollback using sqlca;
	// y lo escribimos en el log
	f_suceso("["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n de base de datos a version " + version + " usando fichero " + pathname,'3',pathname)
	fileclose(file_log)
	return
end if

//guardamos los cambios y borramos el fichero temporal
dw_1.update()

filedelete(g_directorio_temporales + filename)
filedelete(g_directorio_actualizaciones + filename)

end if
end if
end event

public function integer f_suceso (string informe, string categoria, string referencia);//	Funci$$HEX1$$f300$$ENDHEX$$n que inserta un suceso en dw_sucesos
//   suceso 	: texto descriptivo del suceso que va a insertar en el dw
//   categoria	: categor$$HEX1$$ed00$$ENDHEX$$a del suceso (implica que se muestre una imagen u otra)
//			1: aviso
//			2: advertencia
//			3: error
int fila

fila = dw_sucesos.InsertRow(0)
dw_sucesos.setitem(fila,'categoria',categoria)
dw_sucesos.setitem(fila,'informe',informe)
dw_sucesos.setitem(fila,'referencia',referencia)

dw_sucesos.InsertRow(0)

return 1
end function

on w_actualizaciones.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.pb_buscar=create pb_buscar
this.st_1=create st_1
this.st_2=create st_2
this.pb_salir=create pb_salir
this.pb_actualizar=create pb_actualizar
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_sucesos=create dw_sucesos
this.st_3=create st_3
this.st_referencia=create st_referencia
this.st_aviso=create st_aviso
this.st_texto=create st_texto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.pb_buscar
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.pb_salir
this.Control[iCurrent+6]=this.pb_actualizar
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.dw_sucesos
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_referencia
this.Control[iCurrent+12]=this.st_aviso
this.Control[iCurrent+13]=this.st_texto
end on

on w_actualizaciones.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.pb_buscar)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.pb_salir)
destroy(this.pb_actualizar)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_sucesos)
destroy(this.st_3)
destroy(this.st_referencia)
destroy(this.st_aviso)
destroy(this.st_texto)
end on

event open;call super::open;//i_Modalidad indica desde donde se ha llamado el proceso:
//		1 : Desde actualizaciones autom$$HEX1$$e100$$ENDHEX$$ticas
//		2 : Desde actualizaciones manuales
// esto implica que no se visualizar$$HEX2$$e1002000$$ENDHEX$$la parte de selecci$$HEX1$$f300$$ENDHEX$$n de ficheros
i_modalidad = Message.StringParm

if i_modalidad = '1' then
	st_1.text = 'Actualizaciones autom$$HEX1$$e100$$ENDHEX$$ticas'
	st_2.visible = false
	sle_1.visible = false
	pb_buscar.visible = false
	pb_actualizar.visible = false
	gb_1.visible = false
else
	st_aviso.visible = false
end if
	
//st_1.backcolor  =  30525110
//st_2.backcolor  =  31315402
//st_aviso.backcolor  =  30525110
//st_texto.backcolor  =  30525110
//st_3.backcolor  =  30525110
//st_referencia.backcolor  =  30525110

//pb_salir.Picturename=g_dir_aplicacion+".\Imagenes\4 copy.gif"
//pb_buscar.Picturename=g_dir_aplicacion+".\Imagenes\buscar2 copy.gif"
//pb_actualizar.Picturename=g_dir_aplicacion+".\Imagenes\actualizar copy.gif"
end event

event pfc_postopen();call super::pfc_postopen;integer num_ficheros,indice,num_errores=0
n_cst_filesrvwin32 ficheros
string ls_version_sql, version_fichero

integer num_ficheros_sql, num_ficheros_txt

//Recogemos la version_sql
select texto into :ls_version_sql from var_globales where nombre = 'version_sql';
	
if i_modalidad='1' then
	
	n_cst_dirattrib lista_ficheros[]
	
	//PRIMERO LAS SQL
	ficheros = create n_cst_filesrvwin32
	
	num_ficheros = ficheros.of_dirlist(g_directorio_actualizaciones + "*.sql",0,lista_ficheros[])
	num_ficheros_sql = num_ficheros
	//Ordenamos la lista de ficheros (lista_ficheros) por Nombre de fichero (1) en orden ascendente(true)
	ficheros.of_sortdirlist(lista_ficheros,1,true)
	
	if num_ficheros>0 then
		indice = 0
		do while indice < num_ficheros
			indice++
			is_nombre_fichero = lista_ficheros[indice].is_filename
			//Si el nombre no es vacio, llamamos al evento clicked
			if not f_es_vacio(is_nombre_fichero) then
				
					
				//Ahora solo debemos ejecutar las sql cuya fecha sea posterior a la que tengamos almacenada
				//en la base de datos. De esta manera, conseguimos que, mediante un fichero $$HEX1$$fa00$$ENDHEX$$nico, podamos 
				//actualizar la BD de todos los colegios, metiendo en la actualizaci$$HEX1$$f300$$ENDHEX$$n una sql por versi$$HEX1$$f300$$ENDHEX$$n
				version_fichero = LeftA(is_nombre_fichero,8)
				//messagebox('version_fichero',string(version_fichero))
				//messagebox('ls_version_sql',string(ls_version_sql))
				if version_fichero > ls_version_sql then
					this.pb_actualizar.event clicked()
					
			
					//messagebox('ejecuta el fichero',string(is_nombre_fichero))
				end if
			end if
			FileDelete(g_directorio_actualizaciones + is_nombre_fichero)
		 loop
	end if
	
	destroy ficheros
	
	
	//Actualiza la tabla actualizaciones
	this.event csd_tabla_actualizaciones()
	
	//Y despu$$HEX1$$e900$$ENDHEX$$s los txt
	ficheros = create n_cst_filesrvwin32
	
	num_ficheros = ficheros.of_dirlist(g_directorio_actualizaciones + "*.txt",0,lista_ficheros[])
	num_ficheros_txt = num_ficheros
	//Ordenamos la lista de ficheros (lista_ficheros) por Nombre de fichero (1) en orden ascendente(true)
	ficheros.of_sortdirlist(lista_ficheros,1,true)
	
	if num_ficheros>0 then
		 indice = 0
		 do while indice < num_ficheros 
		  indice++
		  is_nombre_fichero= lista_ficheros[indice].is_filename  
			//Si el nombre no es vacio, llamamos al evento clicked
			if not f_es_vacio(is_nombre_fichero) then
				this.pb_actualizar.event clicked()
			end if
			FileDelete(g_directorio_actualizaciones + is_nombre_fichero)
		 loop

	end if

	destroy ficheros
	

	//Si ha habido errores durante la actualizaci$$HEX1$$f300$$ENDHEX$$n. La ventana no se cerrar$$HEX2$$e1002000$$ENDHEX$$para que el usuario
	//pueda revisar la lista de errores.
	if dw_sucesos.rowcount()>0 then
		num_errores = dw_sucesos.getitemnumber(dw_sucesos.rowcount(),'total_errores')
	end if
	if num_errores = 0 then 
		close(this)
		messagebox(g_titulo, 'La actualizaci$$HEX1$$f300$$ENDHEX$$n se realiz$$HEX2$$f3002000$$ENDHEX$$con $$HEX1$$e900$$ENDHEX$$xito')
	end if

end if

//Volvemos a cargar las variables globales, por si han cambiado
f_inicializar_var_globales()
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_actualizaciones
integer x = 2245
integer y = 8
integer width = 59
integer height = 104
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_actualizaciones
integer x = 2176
integer y = 8
integer width = 46
integer height = 104
integer taborder = 0
end type

type sle_1 from singlelineedit within w_actualizaciones
integer x = 535
integer y = 220
integer width = 937
integer height = 68
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type pb_buscar from picturebutton within w_actualizaciones
integer x = 1477
integer y = 216
integer width = 96
integer height = 72
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "..."
alignment htextalign = left!
end type

event clicked;string pathname 
int value


value=GetFileOpenName ( "Seleccione fichero origen", pathname, filename ,"txt" , "Archivos de texto" )

choose case value
	case -1
		f_suceso("Error abriendo el fichero",'3',filename)
		return -1
	case 0
		return 0
end choose
sle_1.text=pathname
end event

type st_1 from statictext within w_actualizaciones
integer x = 18
integer y = 40
integer width = 2290
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 8388608
long backcolor = 67108864
string text = "Actualizaciones"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_actualizaciones
integer x = 64
integer y = 228
integer width = 439
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
string text = "Seleccione Fichero:"
boolean focusrectangle = false
end type

type pb_salir from picturebutton within w_actualizaciones
integer x = 1934
integer y = 1120
integer width = 352
integer height = 132
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
boolean cancel = true
vtextalign vtextalign = vcenter!
end type

event clicked;close(parent)
end event

type pb_actualizar from picturebutton within w_actualizaciones
integer x = 1582
integer y = 208
integer width = 352
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Procesar"
vtextalign vtextalign = vcenter!
end type

event clicked;
string aux 
int li_retorno
int value, file_num,file_dest, file_log
string pathname,tabla, version, linea,descripcion,accion,t_version
datastore ds_tabla
oleobject i_zip
string archivo_version
string sql
string cadena_log
int i
date hoy
string version_bd

select texto into :version_bd from var_globales where nombre = 'version';

//Si no le hemos pasado ningun fichero
if f_es_vacio(is_nombre_fichero) then
	//Lo cogemos del boton
	pathname=sle_1.text
else
	//Si no, cogemos el que le hemos pasado
	pathname= g_directorio_actualizaciones + is_nombre_fichero
end if

filename = is_nombre_fichero

//pathname=sle_1.text

/*ficheros de texto */
//actualizaciones de bd.
	
if RightA(pathname,3)='txt' or RightA(pathname,3)='sql' then
	//comprobamos que el fichero existe
	file_num=fileopen(pathname,LineMode!,Read!)
	if file_num<0 then
		f_suceso("No se pudo abrir el fichero " + is_nombre_fichero,'3',is_nombre_fichero)
		return 0
	end if
	
//leemos 1$$HEX2$$ba002000$$ENDHEX$$linea --> tabla a modificar
	fileRead(file_num,tabla)

//leemos 2$$HEX2$$ba002000$$ENDHEX$$linea --> accion a realizar (1 -> reemplazar datos; 2 -> a$$HEX1$$f100$$ENDHEX$$adir datos; 3 -> ejecutar sentencia sql )
	fileRead(file_num,accion)
	if accion <>'1' and accion<>'2' and accion<>'3' then
		f_suceso("El formato del archivo "+ is_nombre_fichero + " es incorrecto",'3',pathname)
		fileclose(file_num)
		return 0
	end if
//leemos 3$$HEX2$$ba002000$$ENDHEX$$linea --> n$$HEX1$$fa00$$ENDHEX$$mero de versi$$HEX1$$f300$$ENDHEX$$n de la modificaci$$HEX1$$f300$$ENDHEX$$n
	fileRead(file_num,version)
	if LeftA(version,2)<>'20' then
		f_suceso("El formato del archivo "+ is_nombre_fichero + " es incorrecto.",'3',pathname)
		fileclose(file_num)
		return 0
	end if
	// accion
	//		1 reemplazar
	//		2 a$$HEX1$$f100$$ENDHEX$$adir
	//		3 sql
	
	//fichero de log de actualizaciones
	file_log=fileopen(g_dir_aplicacion+"log_actualizaciones.txt",LineMode!,Write!,LockWrite!,Append!)

	choose case accion
		case "1", "2"	//se trata de actualizaci$$HEX1$$f300$$ENDHEX$$n de tablas
			
			//fichero temporal donde se guardan los datos para luego hacer el fileimport.
			file_dest=fileopen(g_directorio_temporales+filename,LineMode!, Write!, LockWrite!, Replace! )
			
			//copiamos los datos al fichero temporal.
			do while (fileRead(file_num,linea)>0)
				filewrite(file_dest,linea)
			loop
			
			//cerramos los ficherosdod
			fileclose(file_dest)
			fileclose(file_num)
			
			//seleccionamos el dw y la version de esa tabla correspondiente a la tb de la base de datos a actualizar
			do while f_es_vacio(sql)
				select sql,descripcion,version into :sql, :descripcion,:t_version from actualizaciones where tabla=:tabla;
			loop
			st_texto.text = descripcion
			
			//comparamos las versiones
			if version < t_version then
				//si la actualizaci$$HEX1$$f300$$ENDHEX$$n es menor salimos
//				if i_modalidad <>'1' then			
					f_suceso("La versi$$HEX1$$f300$$ENDHEX$$n a la que intenta actualizar es anterior a la que dispone. No se realizar$$HEX2$$e1002000$$ENDHEX$$ninguna acci$$HEX1$$f300$$ENDHEX$$n",'3','')
//				end if	
				return 0
			end if
			
			hoy=today()		

 			string ls_sql_syntax,ls_style,ls_dw_err,ls_dw_syntax
 		
			//Generamos el datawindow dinamic$$HEX1$$e100$$ENDHEX$$mente
			ls_sql_syntax=sql
			ls_style = "style(type=grid) " //El tipo del datawindow ser$$HEX2$$e1002000$$ENDHEX$$grid
			ls_dw_err = ""
			ls_dw_syntax = SyntaxFromSQL(sqlca, ls_sql_syntax, ls_style, ls_dw_err)
			If ls_dw_err <> "" Then
				f_suceso("No se ha podido realizar la actualizaci$$HEX1$$f300$$ENDHEX$$n.",'3',is_nombre_fichero)
				rollback using sqlca;
				Return
			End If
			
			if (dw_1.Create(ls_dw_syntax))<=0 then 
				f_suceso("No se ha podido realizar la actualizaci$$HEX1$$f300$$ENDHEX$$n.",'3',is_nombre_fichero)
				rollback using sqlca;
				Return
			end if

			//metemos la transacci$$HEX1$$f300$$ENDHEX$$n al dw creado
			li_retorno= dw_1.settrans(sqlca)	
			
			update actualizaciones set version=:version, f_actualizacion=:hoy where tabla=:tabla;
		
			dw_1.retrieve()
			
			//si reemplazamos datos, 
			if accion="1" then
				//borramos todas las filas
				do while dw_1.rowcount()>0
					dw_1.deleterow(1)
				loop
				//y grabamos los datos.
				dw_1.update()
			end if
			
		//hacemos un importfile del fichero temporal sobre el ds
			if dw_1.importfile(g_directorio_temporales+filename)<=0 then
				//si falla, deshacemos los cambios con un rollback
				rollback using sqlca;
				// y lo escribimos en el log
				cadena_log="["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n de registros en la Base de Datos"
				f_suceso(cadena_log,'3','Versi$$HEX1$$f300$$ENDHEX$$n :' +version + '  Fichero: '+is_nombre_fichero)
				fileclose(file_log)
				return
			end if
			//guardamos los cambios y borramos el fichero temporal
			dw_1.update()
			filedelete(g_directorio_temporales+filename)
			
		case "3"
			//ejecutamos sentencias sql.
			//comprobamos que la version de sql a ejecutar es mayor que la $$HEX1$$fa00$$ENDHEX$$ltima ejecutada
			select texto into :t_version from var_globales where nombre = 'version_sql';
			if version<=t_version then
				//si es menor salimos
				if i_modalidad <>'1' then
					f_suceso("La versi$$HEX1$$f300$$ENDHEX$$n a la que intenta actualizar es anterior a la que dispone. No se realizar$$HEX2$$e1002000$$ENDHEX$$ninguna acci$$HEX1$$f300$$ENDHEX$$n",'2','')
				end if
				fileclose(file_num)
				return 0
			end if
			
			st_texto.text = 'Ejecutando SQL...'
			
			i = 2
			do while (fileRead(file_num,sql)>0)
				//mientras leamos del fichero ejecutamos sentencias de sql (1 x l$$HEX1$$ed00$$ENDHEX$$nea)
				EXECUTE IMMEDIATE :sql ;
				if SQLCA.SqlCode < 0 then 
					//si ejecutar la sql da fall$$HEX1$$f300$$ENDHEX$$,
			//		f_suceso("La consulta de la l$$HEX1$$ed00$$ENDHEX$$nea " + string(i) + " no ha tenido $$HEX1$$e900$$ENDHEX$$xito. No se actualizar$$HEX2$$e1002000$$ENDHEX$$ning$$HEX1$$fa00$$ENDHEX$$n registro.",'3','SQL '+string(i))
					//deshacemos los cambios 
					rollback using sqlca;
					// y lo escribos en el log
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n de base de datos a version " + version + " usando fichero " + pathname +" en la linea "+string(i)
					f_suceso("["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n SQL de base de datos ",'3','Versi$$HEX1$$f300$$ENDHEX$$n :' +version + '  Fichero: '+is_nombre_fichero)
					filewrite(file_log,cadena_log)
					fileclose(file_log)
				end if
				i++
			loop
			fileclose(file_num)
			
			//si todo ha ido bien lo escribimos en la base de datos y guardamos los datos con commit	
			f_suceso("["+string(today())+"] base de datos actualizada a version " + version + " usando fichero " + pathname,'1','')
			update var_globales set texto=:version where nombre='version_sql';
			filewrite(file_log,cadena_log)
			fileclose(file_log)
			commit using sqlca;
			
		case else
			f_suceso("El formato del archivo "+ is_nombre_fichero + " es incorrecto.",'3',pathname)
			fileclose(file_num)
			return 0
	end choose
end if

fileclose(file_num)

FileDelete(g_directorio_actualizaciones + is_nombre_fichero)
end event

type gb_1 from groupbox within w_actualizaciones
integer x = 41
integer y = 144
integer width = 1966
integer height = 192
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
borderstyle borderstyle = stylelowered!
end type

type dw_1 from u_dw within w_actualizaciones
boolean visible = false
integer x = 1536
integer y = 1456
integer width = 123
integer height = 80
integer taborder = 11
string dataobject = "ds_generico"
end type

type dw_sucesos from u_dw within w_actualizaciones
integer x = 18
integer y = 140
integer width = 2290
integer height = 956
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_actualizaciones_sucesos"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event rowfocuschanged;call super::rowfocuschanged;if currentrow=0 then return
st_referencia.text = dw_sucesos.getitemstring(currentrow,'referencia')

end event

type st_3 from statictext within w_actualizaciones
boolean visible = false
integer x = 192
integer y = 1444
integer width = 283
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Referencia :"
boolean focusrectangle = false
end type

type st_referencia from statictext within w_actualizaciones
boolean visible = false
integer x = 475
integer y = 1440
integer width = 1499
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_aviso from statictext within w_actualizaciones
integer x = 101
integer y = 1164
integer width = 1765
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
string text = "Este proceso puede durar unos minutos. Espere, por favor."
boolean focusrectangle = false
end type

type st_texto from statictext within w_actualizaciones
integer x = 87
integer y = 352
integer width = 1874
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
boolean focusrectangle = false
end type

