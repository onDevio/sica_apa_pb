HA$PBExportHeader$w_importa_para_crear_ini.srw
forward
global type w_importa_para_crear_ini from w_response
end type
type cb_importar from commandbutton within w_importa_para_crear_ini
end type
type cb_salir from commandbutton within w_importa_para_crear_ini
end type
type dw_3 from u_dw within w_importa_para_crear_ini
end type
type dw_1 from u_dw within w_importa_para_crear_ini
end type
type dw_2 from u_csd_dw within w_importa_para_crear_ini
end type
end forward

global type w_importa_para_crear_ini from w_response
integer x = 214
integer y = 221
integer width = 4096
integer height = 1184
cb_importar cb_importar
cb_salir cb_salir
dw_3 dw_3
dw_1 dw_1
dw_2 dw_2
end type
global w_importa_para_crear_ini w_importa_para_crear_ini

type variables
n_tr i_tran 

end variables

forward prototypes
public function integer wf_obtener_ruta_cod_documentos (string cod_documentos, ref string rutas[5, 2], string id, string tipo)
end prototypes

public function integer wf_obtener_ruta_cod_documentos (string cod_documentos, ref string rutas[5, 2], string id, string tipo);string dir1_1, dir1_2, dir1_3, dir1_4, dir2_1, dir_nota_encargo, dir2_2, dir2_3, dir2_4, dir3_1, dir3_2, dir3_3, dir3_4
integer i 
string sufijo1, sufijo2

i = 1
sufijo1 = ".pdf"
sufijo2 = "_nota.pdf"

/*******************************************************************************/
/***Codigo de prueba***************************************************************/

dir_nota_encargo= Profilestring(g_dir_aplicacion + "SICA.INI","Ruta_Notas_Encargo","g_ruta_nota_encargo","")
dir1_1 = Profilestring(g_dir_aplicacion + "SICA.INI","Ruta_Notas_Encargo","g_1_1","")
dir1_2 = Profilestring(g_dir_aplicacion + "SICA.INI","Ruta_Notas_Encargo","g_1_2","")
dir1_3 = Profilestring(g_dir_aplicacion + "SICA.INI","Ruta_Notas_Encargo","g_1_3","")
dir1_4 = Profilestring(g_dir_aplicacion + "SICA.INI","Ruta_Notas_Encargo","g_1_4","")
dir2_1 = Profilestring(g_dir_aplicacion + "SICA.INI","Ruta_Notas_Encargo","g_2_1","")
dir2_2 = Profilestring(g_dir_aplicacion + "SICA.INI","Ruta_Notas_Encargo","g_2_2","")
dir2_3 = Profilestring(g_dir_aplicacion + "SICA.INI","Ruta_Notas_Encargo","g_2_3","")
dir2_4 = Profilestring(g_dir_aplicacion + "SICA.INI","Ruta_Notas_Encargo","g_2_4","")
dir3_1 = Profilestring(g_dir_aplicacion + "SICA.INI","Ruta_Notas_Encargo","g_3_1","")
dir3_2 = Profilestring(g_dir_aplicacion + "SICA.INI","Ruta_Notas_Encargo","g_3_2","")
dir3_3 = Profilestring(g_dir_aplicacion + "SICA.INI","Ruta_Notas_Encargo","g_3_3","")
dir3_4 = Profilestring(g_dir_aplicacion + "SICA.INI","Ruta_Notas_Encargo","g_3_4","")
/*****************************************************************************/
choose case tipo
	case  '1'
		if match(cod_documentos,"1_1")  then
			rutas[i,1] = dir1_1+id+sufijo1
			rutas[i,2] = "1_1"
			i = i+1
		end if
		if match(cod_documentos,"1_2") then
			rutas[i,1] = dir1_2+id+sufijo1
			rutas[i,2] = "1_2"
			i = i+1
		end if
		if match(cod_documentos,"1_3") then
			rutas[i,1] = dir1_3+id+sufijo1
			rutas[i,2] = "1_3"
			i = i+1
		end if
		if match(cod_documentos,"1_4") then
			rutas[i,1] = dir1_4+id+sufijo1
			rutas[i,2] = "1_4"
			i = i+1
		end if
		
		rutas[i,1] = dir_nota_encargo+id+sufijo2
		rutas[i,2] = "N"
		
	case  '2'
		if match(cod_documentos,"3_1")  then
			rutas[i,1] = dir2_1+id+sufijo1
			rutas[i,2] = "3_1"
			i = i+1
		end if
		if match(cod_documentos,"3_2") then
			rutas[i,1] = dir2_2+id+sufijo1
			rutas[i,2] = "3_2"
			i = i+1
		end if
		if match(cod_documentos,"3_3") then
			rutas[i,1] = dir2_3+id+sufijo1
			rutas[i,2] = "3_3"
			i = i+1
		end if
		if match(cod_documentos,"3_4") then
			rutas[i,1] = dir2_4+id+sufijo1
			rutas[i,2] = "3_4"
			i = i+1
		end if

	case  '3'
		rutas[i,1] = dir3_4+id+sufijo1
		rutas[i,2] = "4_4"
		i = i+1
		if match(cod_documentos,"4_1") then
			rutas[i,1] = dir3_1+id+sufijo1
			rutas[i,2] = "4_1"
			i = i+1
		end if
		if match(cod_documentos,"4_2") then
			rutas[i,1] = dir3_2+id+sufijo1
			rutas[i,2] = "4_2"
			i = i+1
		end if
		if match(cod_documentos,"4_3") then
			rutas[i,1] = dir3_3+id+sufijo1
				rutas[i,2] = "4_3"
			i = i+1
		end if
end choose 

return 1
end function

on w_importa_para_crear_ini.create
int iCurrent
call super::create
this.cb_importar=create cb_importar
this.cb_salir=create cb_salir
this.dw_3=create dw_3
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_importar
this.Control[iCurrent+2]=this.cb_salir
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_2
end on

on w_importa_para_crear_ini.destroy
call super::destroy
destroy(this.cb_importar)
destroy(this.cb_salir)
destroy(this.dw_3)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event close;call super::close;///
end event

event open;call super::open;f_centrar_ventana(this)

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_importa_para_crear_ini
integer x = 32
integer y = 1188
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_importa_para_crear_ini
integer x = 32
integer y = 1060
end type

type cb_importar from commandbutton within w_importa_para_crear_ini
integer x = 1179
integer y = 980
integer width = 398
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Importar"
end type

event clicked;//comprobamos q el data window lista no esta vacio
integer contador,i,j,k
string ls_nombre_nota_encargo, ruta_nota_encargo, ruta_nota_encargo_final,  cadena_fdf
string trabajos, aux,  ruta_archivo, archivo, ruta_archivo_ini,cod_documentos
integer numero_trabajos, posicion, posic
int prueba
u_zip zip
n_cst_filesrvwin32 l_f
boolean encontrado, existe_b
//vector donde almacenaremos las rutas de los cod_documentos
string rutas[5,2],id
integer contador_rutas, res
string ruta_archivo_zip
string tipo, email 
string n_colegiado
	string aux_2
long fila
integer existe

SetPointer(HourGlass!)
encontrado = false 
//tomamos la ruta donde se encuentra el fdf de la correspondiente nota de encargo
ruta_nota_encargo = Profilestring(g_dir_aplicacion + "SICA.INI","Ruta_Notas_Encargo","g_fdf","")
if dw_1.rowcount() > 0 then
	contador = dw_1.rowcount()
	for i = 1 to contador step 1
		//el bucle procesara las filas de la lista que tengan el valor del selector = S
		if dw_1.getitemstring(i,"seleccion") = 'S' then
			//obtenemos el nombre de la nota de encargo
			tipo = dw_1.getitemstring(i,"formaenvio")
			email = dw_1.getitemstring(i,"correoelectronico")
			cod_documentos = dw_1.getitemstring(i,"coddocumentos")
			id = string(dw_1.getitemnumber(i,"id"))
			choose case tipo
				case "3"
					tipo = "2"
				case "4"
					tipo = "3"
			end choose
			if tipo = "1" then
//				ls_nombre_nota_encargo = dw_1.getitemstring(i,"nombrenotaencargo")
//				posicion = lastpos(ls_nombre_nota_encargo,"_")
//				ls_nombre_nota_encargo = replace(ls_nombre_nota_encargo,posicion,10,".fdf")
				ls_nombre_nota_encargo = id + ".fdf"
				//ahora deberemos de generar el fdf, para ello necesitamos la ruta donde se encuentra la nota de encargo
				ruta_nota_encargo_final = ruta_nota_encargo + ls_nombre_nota_encargo
				//
				existe_b = FileExists(trim(ruta_nota_encargo_final))
				if not existe_b then 
					messagebox(g_titulo,"Ruta no v$$HEX1$$e100$$ENDHEX$$lida: " +ruta_nota_encargo_final + ". Por favor revise que la ruta es correcta y el archivo se encuentra en ella")
					SetPointer(Arrow!)
					return
				end if
				//
				//aqui como prueba le pasamos el fdf
				cadena_fdf = f_obtener_linea_fdf(ruta_nota_encargo_final)
				trabajos = f_buscar_patron_en_fdf(cadena_fdf,"NumTrabajos")
				if not f_es_vacio(trabajos) then
					numero_trabajos = integer(trabajos)
				else
					numero_trabajos = 0
				end if
				
				for j = 1 to numero_trabajos step 1
					dw_2.insertrow(0)
					ruta_archivo = f_generar_ini_desde_fdf(ruta_nota_encargo_final,j,ls_nombre_nota_encargo,ruta_archivo_zip, email)
					ruta_archivo_ini = ruta_archivo
					dw_2.setitem(1,"path",ruta_archivo)
					//dw_2.saveasformattedtext( "d:\javi\sicap\contenidozip.text")
					//Si es el primer trabajo deberemos de adjuntar en el paquete .zip
				 		if j = 1 then
							wf_obtener_ruta_cod_documentos(cod_documentos,rutas,id,tipo)	
							existe = f_comprobar_existencia_archivos_rutas(RUTAS)
							if existe = 0 then
									if j= 1 then
										f_cambiar_vector_rutas(rutas)
										//contador_rutas = UpperBound(rutas)
										for k = 1 to 5
											if not f_es_vacio(rutas[k,2]) then
												fila = dw_2.insertrow(0)
												dw_2.setitem(fila,"path",rutas[k,1])
											end if
										next 
									end if
								for k= 1 to dw_2.rowcount()
									aux_2 = dw_2.getitemstring(k,"path")
								next
							end if
						end if
						if existe = 0 then
							//dw_2.saveasformattedtext( "d:\javi\sicap\contenidozip.text")
							posicion = pos(ruta_archivo,".")
							ruta_archivo = replace(ruta_archivo,posicion,10,".zip")
							//antes de crear el zip vemos a ver si hay algun zip con el mismo nombre en la ruta
							//si es asi lo eliminamos
	//							if fileexists(ruta_archivo_zip) then
	//								filedelete(ruta_archivo_zip)
	//							end if
							zip = create u_zip
							zip.idw_1 = dw_2
							zip.ruta_zip = ruta_archivo_zip
							//zip.ruta_zip = ruta_archivo 
							zip.event compress( )
							dw_2.reset()
							 destroy(zip)	
							 //obtenemos el nombre del archivo
							//archivo = ruta_archivo
							archivo = ruta_archivo_zip
							do while not encontrado
								posic = pos(archivo,"\")
								if posic > 0 then
									archivo = mid(archivo,posic+1)
								else
									encontrado = true
								end if
							loop
							
							 l_f = create n_cst_filesrvwin32
							 res = l_f.of_filecopy(g_dir_aplicacion+archivo,g_directorio_importacion+archivo)
							//borramos el zip del raiz
							//filedelete(ruta_archivo)
							filedelete(ruta_archivo_zip)
							//ahora hay que borrar los ini q nos ha generado en el raiz de sica
							filedelete(ruta_archivo_ini)
							encontrado = false
							if dw_1.getitemstring(i,"seleccion") = 'S' then dw_1.setitem(i,"copisteria",1)
					else
						//no dejamos insertar + trabajos
						j = numero_trabajos + 1
						messagebox(g_titulo,"Ruta no v$$HEX1$$e100$$ENDHEX$$lida: " + rutas[existe,1] + ". Por favor revise que la ruta es correcta y el archivo se encuentra en ella")
						prueba = dw_1.update()
						w_eimporta_detalle.dw_paquetes.event csd_refrescar()
						SetPointer(Arrow!)
						close (w_importa_para_crear_ini) // quizas mejor un retrieve
						return
					end if
					
				next
//					prueba = dw_1.setitem(i,"copisteria",1)					
			else
				n_colegiado = string(dw_1.getitemnumber(i,"n_colegiado"))
				
				ruta_archivo_zip = g_dir_aplicacion +"\"+ "Tipo_"+tipo+"_"+id+"_"+n_colegiado+".zip"
				wf_obtener_ruta_cod_documentos(cod_documentos,rutas,id,tipo)	
				existe = f_comprobar_existencia_archivos_rutas(RUTAS)
				if existe = 0 then
					f_cambiar_vector_rutas(rutas)
					//contador_rutas = UpperBound(rutas)
					for k = 1 to 5
						if not f_es_vacio(rutas[k,2]) then
								fila = dw_2.insertrow(0)
								dw_2.setitem(fila,"path",rutas[k,1])
						end if
					next 
					for k= 1 to dw_2.rowcount()
							aux_2 = dw_2.getitemstring(k,"path")
					next
					//antes de crear el zip vemos a ver si hay algun zip con el mismo nombre en la ruta
					//si es asi lo eliminamos
//					if fileexists(ruta_archivo_zip) then
//						filedelete(ruta_archivo_zip)
//					end if
					zip = create u_zip
					zip.idw_1 = dw_2
					zip.ruta_zip = ruta_archivo_zip
					zip.event compress( )
					dw_2.reset()
					 destroy(zip)	
					 //obtenemos el nombre del archivo
					archivo = ruta_archivo_zip
					do while not encontrado
						posic = pos(archivo,"\")
						if posic > 0 then
							archivo = mid(archivo,posic+1)
						else
							encontrado = true
						end if
					loop
					 l_f = create n_cst_filesrvwin32
					 res = l_f.of_filecopy(g_dir_aplicacion+archivo,g_directorio_importacion+archivo)
					//borramos el zip del raiz
					filedelete(ruta_archivo_zip)
					filedelete(ruta_archivo_ini)
					encontrado = false
					if dw_1.getitemstring(i,"seleccion") = 'S' then dw_1.setitem(i,"copisteria",1)
				else
					messagebox(g_titulo,"Ruta no v$$HEX1$$e100$$ENDHEX$$lida: " + rutas[existe,1] + ". Por favor revise que la ruta es correcta y el archivo se encuentra en ella")
					prueba = dw_1.update()
					w_eimporta_detalle.dw_paquetes.event csd_refrescar()
					//close (w_importa_para_crear_ini)
					SetPointer(Arrow!)
					return
				end if
				end if
			end if
			// Salvo las l$$HEX1$$ed00$$ENDHEX$$neas.
			
	next 
	
	prueba = dw_1.update()
	w_eimporta_detalle.dw_paquetes.event csd_refrescar()
	SetPointer(Arrow!)
	close (w_importa_para_crear_ini)
end if
SetPointer(Arrow!)
end event

type cb_salir from commandbutton within w_importa_para_crear_ini
integer x = 1797
integer y = 980
integer width = 398
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Salir"
end type

event clicked;i_tran.of_disconnect()
destroy(i_tran)
close( w_importa_para_crear_ini )
end event

type dw_3 from u_dw within w_importa_para_crear_ini
boolean visible = false
integer x = 672
integer y = 1068
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_archivos_a_comprimir"
end type

type dw_1 from u_dw within w_importa_para_crear_ini
integer x = 78
integer y = 84
integer width = 3991
integer height = 852
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_importa_para_crear_ini"
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;//debemos de conectarnos a la base de datos correspondiente
string directorio
i_tran = create n_tr
integer i
//////////////////////////////// Permite ordenar
this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)
//this.of_SetTransObject(SQLCA)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

// Enable printpreview service
of_SetPrintPreview (true)
///////////////////////////////
//directorio =  Profilestring("SICA.ini","path","Aplicacion","")
 
string ls_inifile
ls_inifile = gnv_app.of_getappinifile()
// If i_tran.of_init("d:\javi\sicap\SICA.ini","Database2") = -1 then
ls_inifile = gnv_app.of_getappinifile()
 If i_tran.of_init( ls_inifile,"Database2") = -1 then
		//Database es el nombre de la secci$$HEX1$$f300$$ENDHEX$$n de base de datos en "conta.ini"
		 MessageBox(g_titulo, "La conexi$$HEX1$$f300$$ENDHEX$$n ha fallado con la base de datos, en n:/, del visado digital de" 	+ CR + i_tran.SQLErrText,StopSign!)		 
		 Halt
   end if
i_tran.of_connect()
dw_1.settransobject( i_tran)
dw_1.retrieve()

for i = 1 to dw_1.rowcount() 
	dw_1.setitem(1,"seleccion" ,'N')
next
end event

type dw_2 from u_csd_dw within w_importa_para_crear_ini
boolean visible = false
integer x = 2405
integer y = 1004
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dirlist"
end type

