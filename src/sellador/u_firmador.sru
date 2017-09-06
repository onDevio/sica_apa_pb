HA$PBExportHeader$u_firmador.sru
$PBExportComments$Cross platform user object ancestor
forward
global type u_firmador from nonvisualobject
end type
end forward

global type u_firmador from nonvisualobject
end type
global u_firmador u_firmador

type prototypes

end prototypes

type variables
Public:
string i_path_certificado = ''
string i_password_certificado = ''
string i_nombre_firmador = ''
string i_razon = ''
string i_localidad = ''
string i_nombre_fichero_entrada = ''
string i_nombre_fichero_salida
string i_error = ''
string i_id_fase=''
string i_sentencia = ''
string i_sentencia_proteger = ''
string i_sentencia_firmar = ''
string i_ownerpass = ''
integer i_retorno = 1
datetime f_visado

u_analizador_pdf inv_analiza_pdf


private:
string ist_comando = ' -sign '
string ist_path_certificado = ' -keypath '
string ist_password_certificado = ' -keypass '
string ist_nombre_firmador = ' -name '
string ist_razon = ' -reason '
string ist_localidad = ' -location '
string ist_parametro_salida = ' -o '

end variables

forward prototypes
public function integer of_proteger_nt ()
public function integer of_firmar_nt ()
public function integer of_cunyar (st_sello sello)
end prototypes

public function integer of_proteger_nt ();string sentencia = ''
int fichero_bat, li_FileNum, i, lineas_error
integer n
boolean lb_exist = False

sentencia += ' -l log3.txt ' 

// i_sentencia es un string que contiene los parametros de seguridad
// como minimo llebara el ownerpass
sentencia += i_sentencia

// No sobreescribo el fichero original. Pues esto no se comprueba aqui. se hace desde donde se llama a este objeto
sentencia += '"' + i_nombre_fichero_salida + '"'

//if (run("secursign.bat -encrypt " + sentencia ,Minimized!) <> 1) then
// i_error += 'Error en la ejecucion del archivo por lotes MS-DOS secursign.bat' + cr
// i_retorno = -1
//end if

//Parametros iniciales
n_runandwait runandwait
runandwait = create n_runandwait
runandwait.of_SetPriority(runandwait.HIGH_PRIORITY_CLASS)
runandwait.of_SetCurrentDirectory(g_dir_aplicacion)
runandwait.of_SetWindow("minimize")

if runandwait.of_runandwait("secursign.bat -encrypt " + sentencia) <> 1 then
 i_error += 'Error en la ejecucion del archivo por lotes MS-DOS secursign.bat' + cr
 i_retorno = -1
end if

if fileexists(g_dir_aplicacion + "log3.txt") then
 i_error += 'Error en la protecci$$HEX1$$f300$$ENDHEX$$n del documento ' + i_nombre_fichero_salida + cr
 i_retorno = -1
 filedelete(g_dir_aplicacion + "log3.txt")
end if

return i_retorno
end function

public function integer of_firmar_nt ();string sentencia = ''
int fichero_bat, li_FileNum, i, lineas_error
datastore ds_error
integer retorno = 1, n 
boolean lb_exist = False


sentencia += ' -l log2.txt ' 
if not f_es_vacio(i_ownerpass) then
	sentencia += ' -d ' + i_ownerpass+ ' '
end if

sentencia += ist_comando + ist_path_certificado + '"' +i_path_certificado +'"'+ ist_password_certificado + i_password_certificado + &
ist_nombre_firmador + '"'+i_nombre_firmador + '"' + ist_razon + '"' + i_razon + '"' + ist_localidad + '"' + i_localidad + '" '
	
// No sobreescribo el fichero original. Pues esto no se comprueba aqui. se hace desde donde se llama a este objeto
//sentencia += ist_parametro_salida + ' ' + fichero_in + ' ' + fichero_in 
sentencia += '"' + i_nombre_fichero_salida + '"'

//if (run("secursign.bat" + sentencia ,Minimized!)) <> 1 then
// i_error += 'Error en la ejecucion del archivo por lotes MS-DOS secursign.bat' + cr
// i_retorno = -1 
//end if

//Parametros iniciales
n_runandwait runandwait
runandwait = create n_runandwait
runandwait.of_SetPriority(runandwait.HIGH_PRIORITY_CLASS)
runandwait.of_SetCurrentDirectory(g_dir_aplicacion)
runandwait.of_SetWindow("minimize")

retorno = runandwait.of_runandwait("secursign.bat" + sentencia)

if retorno <> 1 then
 i_error += 'Error en la ejecucion del archivo por lotes MS-DOS secursign.bat' + cr
 i_retorno = -1
end if

if (fileexists(g_dir_aplicacion + "log2.txt") = true) then
 i_error += 'Error en la firma del documento ' + i_nombre_fichero_salida + cr
 i_retorno = -1
 filedelete(g_dir_aplicacion + "log2.txt")
end if

return i_retorno
end function

public function integer of_cunyar (st_sello sello);string fichero,id_fase,mensaje_error
long postop,posleft, tam_ancho_doc, tam_alto_doc,tam_sello,ancho_sello,error_sello,rotacion,aux
long rotacion_mod
integer retorno1,retorno = 0
string fichero_temp
n_cst_filesrv	inv_FileSrv
double ret[]

inv_analiza_pdf = create u_analizador_pdf

//Cogemos el nombre del fichero pdf
sello.fichero = i_nombre_fichero_entrada
sello.fichero_salida = i_nombre_fichero_salida
sello.id_fase = i_id_fase

tam_ancho_doc = inv_analiza_pdf.f_ancho_pagina(sello.fichero)
tam_alto_doc  = inv_analiza_pdf.f_alto_pagina(sello.fichero)
rotacion      = inv_analiza_pdf.f_calcula_rotacion(sello.fichero)

//ret = w_sellador.ole_calculo_pdf.object.getPdfSize(i_nombre_fichero_entrada)
//tam_ancho_doc = ret[1]
//tam_alto_doc = ret[2]
//rotacion = w_sellador.ole_calculo_pdf.object.getPdfrotation(i_nombre_fichero_entrada)

rotacion_mod = Mod(rotacion,180)

if rotacion_mod > 0 then
	aux = tam_ancho_doc
	tam_ancho_doc = tam_alto_doc
	tam_alto_doc = aux
end if

//tam_doc=612
//sello.texto1="Este visado queda condicionado en su validez y eficacia a la incorporaci$$HEX1$$f300$$ENDHEX$$n al mismo del Estudio de Seguridad para el cumplimiento del art.17.1 de R.D 1627/1997 de 24 de octubre de 1997 lasgoeqahashdgjag$$HEX1$$f100$$ENDHEX$$jglaksdjgjkn adsjhn asdjk dis ias sdaklfjfas asdkjfldf  dklfjlad  kdjfla aldsjfl   dkfala  ksdajfaljafoejlajfaln asdl a asdjkhasdklfjka jkasd"
//sello.texto2="Visado de conformidad con la ley 4/1992 de la G.V. y el art."		
choose case g_colegio
	case 'COAATTFE'
		////Un folio tiene una medida de 842 X 596 puntos
		sello.postop=833
		sello.posleft=380
		f_ps_sellar_coapatfe(sello)
		
	case 'COAATCU'
		////Un folio tiene una medida de 842 X 596 puntos
		sello.postop=833
		sello.posleft=380
		f_ps_sellar_coapacu(sello)
		
	case 'COAATZ'
		////Un folio tiene una medida de 842 X 596 puntos
		sello.postop=833
		sello.posleft=380
		f_ps_sellar_coapazar(sello)
		
	case 'COAATMU'
		////Un folio tiene una medida de 842 X 596 puntos
		sello.postop=833
		sello.posleft=380
		if sello.tipo = '1' then
			if rotacion > 0 then
				fichero_temp = LeftA(i_nombre_fichero_salida, LenA(i_nombre_fichero_salida) - 6) + "_t.pdf"
				
				//Sellamos las imagenes con el sello antiguo
				sello.fichero_salida = fichero_temp
				f_ps_sellar_coapamu_rotado(sello)
				
				//Sellamos los textos
				sello.fichero = fichero_temp
				sello.fichero_salida = i_nombre_fichero_salida
				f_ps_sellar_coapamu_rotado_textos(sello)

				//Borramos el anterior a mitad sellar (solo tiene imagenes)
				filedelete(fichero_temp)
			else
				f_ps_sellar_coapamu(sello)
			end if
		else  // peque$$HEX1$$f100$$ENDHEX$$o
			if rotacion > 0 then
				fichero_temp = LeftA(i_nombre_fichero_salida, LenA(i_nombre_fichero_salida) - 6) + "_t.pdf"
				
				//Sellamos las imagenes con el sello antiguo
				sello.fichero_salida = fichero_temp
				f_ps_sellar_coapamu_pequenyo_rotado(sello)
				
				//Sellamos los textos
				sello.fichero = fichero_temp
				sello.fichero_salida = i_nombre_fichero_salida
				f_ps_sellar_coapamu_pequenyo_rotado_texto(sello)

				//Borramos el anterior a mitad sellar (solo tiene imagenes)
				filedelete(fichero_temp)
			else
				f_ps_sellar_coapamu_pequenyo(sello)
			end if
		end if
		
	case 'COAATGUI'
		if rotacion > 0 then
			fichero_temp = LeftA(i_nombre_fichero_salida, LenA(i_nombre_fichero_salida) - 6) + "_t.pdf"
			
			//Sellamos las imagenes con el sello antiguo
			sello.fichero_salida = fichero_temp
			f_ps_sellar_coapagui_rotado(sello)
			
			//Sellamos los textos
			sello.fichero = fichero_temp
			sello.fichero_salida = i_nombre_fichero_salida
			f_ps_sellar_coapagui_rotado_textos(sello)

			//Borramos el anterior a mitad sellar (solo tiene imagenes)
			filedelete(fichero_temp)
		else
			f_ps_sellar_coapagui(sello)
		end if
		
	case 'COAATGC'
		f_ps_sellar_coapapalmas(sello)	
		
	case 'COAATLR'
		sello.f_visado=f_visado
		if sello.tipo = '1' then
			if rotacion > 0 then
				fichero_temp = LeftA(i_nombre_fichero_salida, LenA(i_nombre_fichero_salida) - 6) + "_t.pdf"
				
				//Sellamos las imagenes con el sello antiguo
				sello.fichero_salida = fichero_temp
				f_ps_sellar_coaparioja_rotado(sello)
				
				//Sellamos los textos
				sello.fichero = fichero_temp
				sello.fichero_salida = i_nombre_fichero_salida
				f_ps_sellar_coaparioja_rotado_textos(sello)

				//Borramos el anterior a mitad sellar (solo tiene imagenes)
				filedelete(fichero_temp)
			else
				f_ps_sellar_coaparioja(sello)
			end if
		elseif sello.tipo = '2' then  // peque$$HEX1$$f100$$ENDHEX$$o
			if rotacion > 0 then
				fichero_temp = LeftA(i_nombre_fichero_salida, LenA(i_nombre_fichero_salida) - 6) + "_t.pdf"
				
				//Sellamos las imagenes con el sello antiguo
				sello.fichero_salida = fichero_temp
				f_ps_sellar_coaparioja_pequenyo_rotado(sello)
				
				//Sellamos los textos
				sello.fichero = fichero_temp
				sello.fichero_salida = i_nombre_fichero_salida
				f_ps_sellar_coaparioja_pequenyo_rotado_te(sello)

				//Borramos el anterior a mitad sellar (solo tiene imagenes)
				filedelete(fichero_temp)
			else
				f_ps_sellar_coaparioja_pequenyo(sello)
			end if
		elseif sello.tipo = '3' then  // peque$$HEX1$$f100$$ENDHEX$$o-devuelto
			if rotacion > 0 then
				fichero_temp = LeftA(i_nombre_fichero_salida, LenA(i_nombre_fichero_salida) - 6) + "_t.pdf"
				
				//Sellamos las imagenes con el sello antiguo
				sello.fichero_salida = fichero_temp
				f_ps_sellar_coaparioja_pequenyo_rotado(sello)
				
				//Sellamos los textos
				sello.fichero = fichero_temp
				sello.fichero_salida = i_nombre_fichero_salida
				f_ps_sellar_coaparioja_pequenyo_r_dev_te(sello)

				//Borramos el anterior a mitad sellar (solo tiene imagenes)
				filedelete(fichero_temp)
			else
				f_ps_sellar_coaparioja_pequenyo_dev(sello)
			end if			
		end if
		
	//case 'COAATB'
		//f_ps_sellar_coapavizcaya(sello)
		
	case 'COAATBU'
		f_ps_sellar_coapaburgos(sello)	

	case else 
		//f_ps_sellar_prueba(sello)
end choose

if (FileExists(g_dir_aplicacion + "stamppdf.err") = True) then
	i_error += 'Error en el estampado del Sello.'
	i_retorno = -1
	FileDelete(g_dir_aplicacion + "stamppdf.err")	//Borramos el fichero
else
	i_retorno = 1
end if

destroy inv_analiza_pdf
return i_retorno

end function

on u_firmador.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_firmador.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

