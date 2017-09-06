HA$PBExportHeader$w_descargar_actualizacion.srw
$PBExportComments$Ventana que ejecuta el comando ftp PUT
forward
global type w_descargar_actualizacion from w_consulta
end type
type ole_1 from olecustomcontrol within w_descargar_actualizacion
end type
type cbx_contrato from checkbox within w_descargar_actualizacion
end type
type dw_comprimir from u_dw within w_descargar_actualizacion
end type
type cb_3 from commandbutton within w_descargar_actualizacion
end type
type cb_5 from commandbutton within w_descargar_actualizacion
end type
type uo_1 from uo_csd_barra_progreso within w_descargar_actualizacion
end type
type pb_4 from picturebutton within w_descargar_actualizacion
end type
type mle_1 from multilineedit within w_descargar_actualizacion
end type
type gb_1 from groupbox within w_descargar_actualizacion
end type
end forward

global type w_descargar_actualizacion from w_consulta
boolean visible = false
integer width = 2821
integer height = 944
string title = "Transferencia de ficheros"
event csd_ftp_custom pbm_custom01
event csd_iniciar_descarga ( )
event csd_detectar_actualizacion_ftp ( )
event type integer csd_busca_ficheros_ftp ( string tipo_fichero )
ole_1 ole_1
cbx_contrato cbx_contrato
dw_comprimir dw_comprimir
cb_3 cb_3
cb_5 cb_5
uo_1 uo_1
pb_4 pb_4
mle_1 mle_1
gb_1 gb_1
end type
global w_descargar_actualizacion w_descargar_actualizacion

type variables
//Variable de instancia para almacenar el id de la conexi$$HEX1$$f300$$ENDHEX$$n
ulong ui_idconexion

//Objeto de env$$HEX1$$ed00$$ENDHEX$$o FTP
n_csd_ftpservices inv_ftpservices

//Variable de instancia para guardar la ventana
w_response iw_descargar_actualizacion

//Variable para saber si se ha descargado un exe
boolean ib_descargado_exe

//Variable para saber si se ha abortado la descarga
boolean ib_abortado

//Variable para mostrar o no el aviso de descarga de ficheros
boolean ib_mostrar_aviso
end variables

event csd_ftp_custom;//Evento custom que se ejecuta cada cierto tiempo para comprobar el estado del env$$HEX1$$ed00$$ENDHEX$$o
ulong lu_estado
ulong lu_bytesenviados
ulong lu_totalbytes
string ls_mensajeestado
boolean lb_enviado = true

Yield()
//Comprobar si se ha cancelado y cerrar conexion
//if ib_abortado = true then
//	inv_ftpservices.of_cerrarconexionservidor(ui_idconexion)
//end if

inv_ftpservices.of_estadotransferenciaarchivo(wparam,lu_estado,ls_mensajeestado,lu_bytesenviados,lu_totalbytes)

choose case lu_estado
	case inv_ftpservices.ESTADO_TRANSFERENCIA_CONECTANDO
		//ESTADO_TRANSFERENCIA_CONECTANDO
		
	case inv_ftpservices.ESTADO_TRANSFERENCIA_CONECTADO
		//ESTADO_TRANSFERENCIA_CONECTADO
		//Una vez nos hayamos conectado, iniciamos el env$$HEX1$$ed00$$ENDHEX$$o de archivos
		//Y ocultamos los botones correspondientes de la pantalla
		pb_4.visible=true
	
	case inv_ftpservices.ESTADO_TRANSFERENCIA_DESCARGANDO
		//ESTADO_TRANSFERENCIA_DESCARGANDO
		uo_1.incrementar(lu_bytesenviados/lu_totalbytes*100)
		
	case inv_ftpservices.ESTADO_TRANSFERENCIA_ENVIANDO
		//ESTADO_TRANSFERENCIA_ENVIANDO
		//Incrementamos la barra de estado

	case inv_ftpservices.ESTADO_TRANSFERENCIA_COMPLETADO
		//ESTADO_TRANSFERENCIA_COMPLETADO
		pb_4.visible=false

		
	case inv_ftpservices.ESTADO_TRANSFERENCIA_ABORTADO
		//ESTADO_TRANSFERENCIA_ABORTADO
		//Cerramos la conexi$$HEX1$$f300$$ENDHEX$$n e inicializamos a 0 el id.
		pb_4.visible=false
		
end choose

//Mostramos el mensaje
mle_1.text=ls_mensajeestado

//Comprobamos el valor de retorno del env$$HEX1$$ed00$$ENDHEX$$o
if lb_enviado = false then
	mle_1.text="Se produjo un error al intentar enviar el archivo"
end if
end event

event csd_detectar_actualizacion_ftp();ulong ul_buscar
integer devuelve, ret, li_ret_funcion
string ls_destino_seleccionado
boolean lb_recibido, lb_error = false
nca_folderbrowse lnca_bff

if not f_es_vacio(g_ftp_actualizaciones) then
	
	//Abrimos la conexi$$HEX1$$f300$$ENDHEX$$n
	ui_idconexion = inv_ftpservices.of_abrirconexionservidor(g_ftp_actualizaciones,integer(g_puerto_actualizaciones),g_login_actualizaciones,g_password_actualizaciones,false,false,iw_descargar_actualizacion,01)
	
	//El siguiente paso es buscar, mediante la funci$$HEX1$$f300$$ENDHEX$$n f_busca_ficheros_ftp, una serie de ficheros
	//de un tipo determinado en el servidor FTP
	li_ret_funcion = this.event csd_busca_ficheros_ftp('exe')
	
	if li_ret_funcion = 1 then
		if ib_abortado = true then
			Messagebox(g_titulo,"Se ha abortado la descarga del fichero. Int$$HEX1$$e900$$ENDHEX$$ntelo m$$HEX1$$e100$$ENDHEX$$s tarde.")
		else
			Messagebox(g_titulo,"Ha ocurrido un error al descargar la actualizaci$$HEX1$$f300$$ENDHEX$$n.")
		end if
		lb_error = true
	elseif li_ret_funcion = 2 then
		//Messagebox(g_titulo,"El programa ha descargado la nueva versi$$HEX1$$f300$$ENDHEX$$n en la ruta .... Salga del programa y actual$$HEX1$$ed00$$ENDHEX$$celo con este fichero.")
		lb_error = true
	elseif li_ret_funcion = 3 then
		//Si el usuario no desea descargar la nueva versi$$HEX1$$f300$$ENDHEX$$n
		lb_error = true
	else
		li_ret_funcion = this.event csd_busca_ficheros_ftp('sql')
		if li_ret_funcion = 1 then
			Messagebox(g_titulo,"Ha ocurrido un error al descargar la actualizaci$$HEX1$$f300$$ENDHEX$$n.")
			lb_error = true
		else
			this.event csd_busca_ficheros_ftp('txt')
			if li_ret_funcion = 1 then
				Messagebox(g_titulo,"Ha ocurrido un error al descargar la actualizaci$$HEX1$$f300$$ENDHEX$$n.")	
				lb_error = true
			end if
		end if
	end if
	
	//Cerramos la conexi$$HEX1$$f300$$ENDHEX$$n si no se ha abortado
	if ib_abortado = false then
		inv_ftpservices.of_cerrarconexionservidor(ui_idconexion)
	end if
	
	//Si no ha ocurrido ning$$HEX1$$fa00$$ENDHEX$$n error. actualizamos
	if lb_error = false then
		//Actualiza
		//Messagebox(g_titulo,"ACTUALIZA")	
		f_actualizaciones()
		g_no_actualizar = true
	end if
end if

SetPointer(Arrow!)

filedelete("C:\ftpservices.log")

close(this)
end event

event type integer csd_busca_ficheros_ftp(string tipo_fichero);//Devuelve: 0 si no encuentra ning$$HEX1$$fa00$$ENDHEX$$n fichero del tipo seleccionado y que su versi$$HEX1$$f300$$ENDHEX$$n sea posterior
//				  a la que disponemos
//				1 si ha ocurrido alg$$HEX1$$fa00$$ENDHEX$$n error al descargar el fichero
//				2 si todo ha ido bien
//				3 si el usuario ha cancelado la descarga

nca_folderbrowse lnca_bff
integer ls_busqueda, devuelve, ret = 1, i
string version, ls_directorio_destino
boolean lb_recibido, lb_no_descargar = false
string ls_cadenabusqueda, ls_version, ls_destino_seleccionado, nombres[]
ulong ul_buscar
datetime fechas[]
boolean directorios[]
	
//Asignamos la version de la aplicaci$$HEX1$$f300$$ENDHEX$$n a la variable local utilizada
version = RightA(g_version,4)

//Lo mismo con el directorio de destino
ls_directorio_destino = g_directorio_actualizaciones

//Debemos buscar, dentro del directorio FTP donde nos encontramos, una serie
//de ficheros que cumplan unos requisitos. En este caso, vemos si existe alg$$HEX1$$fa00$$ENDHEX$$n fichero
//que tenga una extensi$$HEX1$$f300$$ENDHEX$$n 'tipo_fichero'
ls_cadenabusqueda = g_dir_actualizaciones + "*." + tipo_fichero

ul_buscar = inv_ftpservices.of_buscararchivos(ui_idconexion,ls_cadenabusqueda,nombres[],fechas[],directorios[])
if ul_buscar < 0 then
	//Error
	devuelve = 1
elseif ul_buscar = 0 then
	//Nada encontrado
	devuelve = 0
elseif ib_descargado_exe = true then
	//No hacemos nada
else	
	for i=1 to integer(ul_buscar)
		//Comparamos la versi$$HEX1$$f300$$ENDHEX$$n del programa que tenemos nosotros y la del nombre del fichero,
		//si la nuestra es menor que la que hemos encontrado, preguntamos al usuario si desea
		//descargarla a nuestro ordenador. Si la respuesta es s$$HEX1$$ed00$$ENDHEX$$, la descargamos
		ls_version = f_extrae_version_nombre(nombres[i])
		if tipo_fichero = 'txt' or tipo_fichero = 'sql' then
			SELECT texto INTO :version FROM var_globales WHERE nombre = 'version_sql';
		end if
//		messagebox('version',string(version))
//		messagebox('ls_version',string(ls_version))
		if long(version) < long(ls_version) then
			
			//Si son ficheros de actualizacion de BD, mostramos el aviso si es necesario
			if ul_buscar > 0 and tipo_fichero <> 'exe' and ib_mostrar_aviso = true then
				Messagebox(g_titulo,'Existen nuevas modificaciones en la base de datos. El programa se dispone a descargarlas. Por favor, espere.')
				SetPointer(Hourglass!)
				ib_mostrar_aviso = false
			end if
	
			//Si el fichero es de tipo .exe, debemos de preguntar al usuario si desea descargarlo.
			//En los dem$$HEX1$$e100$$ENDHEX$$s tipos, se debe descargar sin preguntar
			if tipo_fichero = 'exe' then
				ret = Messagebox(g_titulo,'Existe una nueva versi$$HEX1$$f300$$ENDHEX$$n del programa. $$HEX1$$bf00$$ENDHEX$$Desea descargarla?',Question!,YesNo!)
	
				//Si la respuesta es si, el usuario debe seleccionar el lugar donde desea descargar el fichero
				if ret = 1 then
					ls_destino_seleccionado = lnca_BFF.BrowseForFolder( g_firmador, 'Seleccione el destino' )
					if f_es_vacio(ls_destino_seleccionado) then 
						devuelve = 3
						exit
					end if
					ls_directorio_destino= ls_destino_seleccionado
				
					//Mostramos la barra y el texto de la etiqueta
					this.visible = true
					uo_1.mostrar_barra(true)
					uo_1.parametrizar(100)
					uo_1.texto_etiqueta('Transfiriendo fichero ' + nombres[i],-1)
				end if
			else
				this.visible = false
				SetPointer(Hourglass!)
			end if		
			if ret = 1 then

				//Descargamos a la carpeta destino
				lb_recibido = inv_ftpservices.of_iniciardescargaarchivo(ui_idconexion,'/' + g_dir_actualizaciones + nombres[i],ls_directorio_destino +  nombres[i])
				
				//Si la descarga ha fallado
				if lb_recibido = false then
					devuelve = 1
					exit
				else
					//Todo ha ido bien
					devuelve = 2
					if tipo_fichero = 'exe' then
						//Hemos descargado un exe
						ib_descargado_exe = true
						Messagebox(g_titulo,"El programa ha descargado la nueva versi$$HEX1$$f300$$ENDHEX$$n en la ruta " + ls_directorio_destino + nombres[i] + ".Salga del programa y actual$$HEX1$$ed00$$ENDHEX$$celo con este fichero.")
					end if
				end if
			else
				//No ha querido descargar la nueva version
				devuelve = 3
				exit
			end if
		end if
	next
	//devuelve = 0
end if

return devuelve
end event

on w_descargar_actualizacion.create
int iCurrent
call super::create
this.ole_1=create ole_1
this.cbx_contrato=create cbx_contrato
this.dw_comprimir=create dw_comprimir
this.cb_3=create cb_3
this.cb_5=create cb_5
this.uo_1=create uo_1
this.pb_4=create pb_4
this.mle_1=create mle_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_1
this.Control[iCurrent+2]=this.cbx_contrato
this.Control[iCurrent+3]=this.dw_comprimir
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_5
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.pb_4
this.Control[iCurrent+8]=this.mle_1
this.Control[iCurrent+9]=this.gb_1
end on

on w_descargar_actualizacion.destroy
call super::destroy
destroy(this.ole_1)
destroy(this.cbx_contrato)
destroy(this.dw_comprimir)
destroy(this.cb_3)
destroy(this.cb_5)
destroy(this.uo_1)
destroy(this.pb_4)
destroy(this.mle_1)
destroy(this.gb_1)
end on

event open;call super::open;uo_1.backcolor  = 31315402
mle_1.backcolor = 31315402

this.pb_4.Picturename = g_dir_aplicacion + '.\Imagenes\abortar.gif'

f_centrar_ventana(this)

//No se ha descargado un exe
ib_descargado_exe = false

//No se ha abortado
ib_abortado = false

//Guardamos la referencia a la ventana en una variable de instancia
iw_descargar_actualizacion = this

//Mostramos el aviso
ib_mostrar_aviso = true

this.event csd_detectar_actualizacion_ftp()
end event

event close;call super::close;filedelete("C:\ftpservices.log")
end event

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_descargar_actualizacion
integer x = 1879
integer y = 2356
integer taborder = 80
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_descargar_actualizacion
integer x = 1490
integer y = 2288
end type

type cb_limpiar from w_consulta`cb_limpiar within w_descargar_actualizacion
end type

type st_5 from w_consulta`st_5 within w_descargar_actualizacion
boolean visible = false
integer x = 608
integer y = 1168
long backcolor = 79741120
string text = "Ficheros a enviar:"
end type

type cb_1 from w_consulta`cb_1 within w_descargar_actualizacion
boolean visible = false
integer x = 818
integer y = 2340
integer taborder = 110
integer weight = 700
boolean default = false
end type

type cb_2 from w_consulta`cb_2 within w_descargar_actualizacion
boolean visible = false
integer x = 1947
integer y = 2268
integer taborder = 130
boolean cancel = false
end type

type cb_ayuda from w_consulta`cb_ayuda within w_descargar_actualizacion
integer x = 3090
integer y = 820
integer taborder = 150
boolean cancel = false
end type

type dw_1 from w_consulta`dw_1 within w_descargar_actualizacion
boolean visible = false
integer x = 530
integer y = 1548
integer width = 2171
integer height = 356
integer taborder = 20
string dataobject = "dw_ftp_put"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::buttonclicked;string aux, path
if getfileopenname("Transferencia de ficheros",path,aux)=1 then
	dw_1.setitem(1,1,path)
	dw_1.setitem(1,'filename',aux)
end if

end event

type ole_1 from olecustomcontrol within w_descargar_actualizacion
event statechanged ( integer state )
boolean visible = false
integer x = 3136
integer y = 596
integer width = 174
integer height = 152
integer taborder = 90
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
string binarykey = "w_descargar_actualizacion.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
end type

event statechanged;setpointer(hourglass!)
string vdata

choose case State
	case 11
		vdata=string(this.object.responsecode)+':  '
		messagebox(g_titulo,"Error transfiriendo"+'~n~r'+string(vdata)+ string(this.object.Responseinfo),exclamation!)
//		parent.postevent("pfc_close",0,-1)
		cb_2.enabled=true
		closewithreturn(parent,-1)
	case 12
		vdata=this.object.getchunk(1024,0)
		messagebox(g_titulo,"Fichero transferido")
//		parent.postevent("pfc_close",0,0)
		cb_2.enabled=true
		closewithreturn(parent,-1)
	case else
		setpointer(hourglass!)
end choose
		
end event

event error;action=exceptionIgnore!
end event

type cbx_contrato from checkbox within w_descargar_actualizacion
boolean visible = false
integer x = 1449
integer y = 2356
integer width = 741
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Adjuntar datos del contrato"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type dw_comprimir from u_dw within w_descargar_actualizacion
boolean visible = false
integer x = 2885
integer y = 312
integer width = 539
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ftp_put"
end type

type cb_3 from commandbutton within w_descargar_actualizacion
boolean visible = false
integer x = 384
integer y = 2320
integer width = 407
integer height = 96
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "descomprimir"
end type

event clicked;//u_zip zip
//
//zip = create u_zip
//
//zip.ruta_zip = g_dir_aplicacion + g_paquete_temporal + g_prefijo_expediente + idw_fase.getitemstring(1, 'fases_n_expedi') + '_' + g_prefijo_registro + idw_fase.getitemstring(1, 'fases_n_registro') + '.ini'
//zip.ruta_destino = g_dir_aplicacion 
//zip.event uncompress()
//
//destroy u_zip
end event

type cb_5 from commandbutton within w_descargar_actualizacion
boolean visible = false
integer x = 1093
integer y = 2248
integer width = 443
integer height = 76
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
end type

type uo_1 from uo_csd_barra_progreso within w_descargar_actualizacion
event destroy ( )
integer x = 178
integer y = 244
integer width = 2437
integer taborder = 70
end type

on uo_1.destroy
call uo_csd_barra_progreso::destroy
end on

type pb_4 from picturebutton within w_descargar_actualizacion
boolean visible = false
integer x = 1189
integer y = 580
integer width = 352
integer height = 132
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = ".\Imagenes\abortar.gif"
alignment htextalign = left!
end type

event clicked;if ui_idconexion <> 0 then
	//Cerramos la conexion
	inv_ftpservices.of_cerrarconexionservidor(ui_idconexion)
	ui_idconexion = 0
end if

ib_abortado = true

filedelete("C:\ftpservices.log")
end event

event constructor;this.Picturename = g_dir_aplicacion + '.\Imagenes\abortar.gif	'
end event

type mle_1 from multilineedit within w_descargar_actualizacion
integer x = 791
integer y = 152
integer width = 1216
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
boolean border = false
alignment alignment = center!
end type

type gb_1 from groupbox within w_descargar_actualizacion
integer x = 123
integer y = 88
integer width = 2546
integer height = 652
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 77956459
string text = "Transferencia"
borderstyle borderstyle = stylelowered!
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Fw_descargar_actualizacion.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Fw_descargar_actualizacion.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
