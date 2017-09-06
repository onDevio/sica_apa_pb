HA$PBExportHeader$n_csd_conversion_xml_a_zip.sru
forward
global type n_csd_conversion_xml_a_zip from nonvisualobject
end type
end forward

global type n_csd_conversion_xml_a_zip from nonvisualobject
end type
global n_csd_conversion_xml_a_zip n_csd_conversion_xml_a_zip

type variables

private:
// VARIABLES DE INSTANCIA
string is_fichero_xml
string is_ruta_salida
string is_fichero_zip,is_fichero_zip_1,is_fichero_zip_2

// descriptor del fichero
string is_fichero_ini
integer ii_descriptor
string is_tipo

PBDOM_OBJECT cabecera_xml[]
PBDOM_OBJECT contenido[]
PBDOM_OBJECT contrato[]
PBDOM_OBJECT lista_clientes[]
PBDOM_OBJECT lista_docs[]
PBDOM_OBJECT lista_colegiados[]
PBDOM_OBJECT clientes[]
PBDOM_OBJECT cliente_rep[]
PBDOM_OBJECT colegia[]
PBDOM_OBJECT docs[]
PBDOM_Document    pbdom_doc
PBDOM_Builder     pbdom_bldr

public:
string is_emplazamiento
string is_num_interno
string is_num_recibo
string is_num_web
string is_num_certificado
string is_tipo_cert
string is_municipio
string is_cod_postal
string is_bloque,is_escalera,is_piso,is_puerta,is_cp
string is_tipo_edificio
string is_f_entrada
string is_f_visado
string is_situacion
string is_nombre_promotor
string is_num_visado
string is_version
string is_estado_recibo
string is_importe

integer ii_num_col,ii_num_cli,ii_num_ficheros
string descripcion_obra
string situacion_visado,gestion_cobro,autor
string tipo_act1,tipo_act2,tipo_obra,destino, obra_oficial,medianeras
string sup_garaje,num_edificios,num_viviendas,volumen,altura,uso_edificios
string plantas_br,sup_bj,sup_sr,plantas_sr,sup_viv,sup_otros,sup_br,sup_parcela
string  pre_seguridad,honor
string f_visado,observaciones,tipologia
string pem,num_lados,clase_promotor,uso_edif,estudio_geo
string cc_forjado,cc_acero,cc_acero_tipo,cc_hormi,cc_hormi_tipo,cc_muros,cc_cubiertas
string f_visado_pe,f_visado_pb,n_visado_pe,n_visado_pb,mantenimiento,f_mantenimiento, titulacion

string colegiados[],participacion[]
string rep_nombre[],rep_nif[],rep_direccion[],rep_cp[],rep_poblacion[],rep_telefono[],rep_nacionalidad[]
string cli_nombre[],cli_nif[],cli_direccion[],cli_cp[],cli_poblacion[],cli_telefono[],cli_nacionalidad[],cli_numero[]
string docs_fecha[],docs_nombre[],docs_tipo[]

end variables

forward prototypes
public subroutine of_inicializar (string fichero_xml, string ruta_salida, string fichero_zip)
private function integer f_escribir_datos_colegiados ()
private function integer f_escribir_datos_clientes ()
private function integer f_escribir_datos_contrato ()
private function integer f_crear_zip ()
public function string of_error (integer err)
public function integer of_convertir ()
private function integer f_cargar_datos_xml ()
public function integer f_cargar_datos_certif ()
public function integer f_cargar_datos_recibos ()
public function integer f_cargar_datos_visados ()
end prototypes

public subroutine of_inicializar (string fichero_xml, string ruta_salida, string fichero_zip);// FUNCTION public f_inicializar
// FUNCION QUE INICIALIZA EL OBJETO CON LOS PARAMETROS DE ENTRADA
// Parametros de Entrada:
//   fichero_xml -> Fichero XML de origen con la ruta completa. Ej.  c:\dir_xml\prueba.xml
//   ruta_salida -> Ruta donde queremos generar el .ini Ej. C:\fichero_generado\
//   fichero_zip -> Nombre completo del fichero Ej. VISADO-09-00002.zip

// Parametros de Salida:
//   NINGUNO

is_fichero_xml = fichero_xml
is_ruta_salida = ruta_salida
is_fichero_zip = fichero_zip
is_fichero_zip_1 = left(fichero_zip,len(fichero_zip) - 4)+'_1.zip'
is_fichero_zip_2 = left(fichero_zip,len(fichero_zip) - 4)+'_2.zip'

gnv_fichero.of_deltree(g_directorio_temporal)
gnv_fichero.of_CreateDirectory(g_directorio_temporal)

end subroutine

private function integer f_escribir_datos_colegiados ();// Funci$$HEX1$$f300$$ENDHEX$$n que escribe los datos de la secci$$HEX1$$f300$$ENDHEX$$n [COLEGIADOS]

// Parametros de Entrada:
//   NINGUNO

// Parametros de Salida:
//   integer err - Error en la escritura  (0-> todo correcto, < 0 -> Fallo)

integer err
integer fic,i
boolean flag

flag = false
//FUNCIONAMIENTO:
// Escribir los colegiados

fic = FileOpen(g_directorio_temporal+is_fichero_ini, LineMode!, Write!, LockReadWrite!, Append!,EncodingAnsi!)
if fic<0 then return -2

FileClose(fic)

SetProfileString(g_directorio_temporal+is_fichero_ini,'COLEGIADOS','total',string(ii_num_col))

string n_col,nom,app,nombre_comp

for i=1 to UpperBound(colegiados)
	select n_colegiado,nombre,apellidos into :n_col,:nom,:app from colegiados where n_consejo=:colegiados[i];
	if f_es_vacio(n_col) then
		SetProfileString(g_directorio_temporal+is_fichero_ini,'COLEGIADOS','numero_'+string(i),colegiados[i])
		if i=1 then SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','colegiado',colegiados[1])		
	else
		SetProfileString(g_directorio_temporal+is_fichero_ini,'COLEGIADOS','numero_'+string(i),n_col)
		if i=1 then SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','colegiado',n_col)						
	end if
	
	if f_es_vacio(nom) then
		nombre_comp=nom+app
	else
		nombre_comp=app
	end if
	if nombre_comp = autor then flag = true

	SetProfileString(g_directorio_temporal+is_fichero_ini,'COLEGIADOS','porcentaje_'+string(i),participacion[i])
	SetProfileString(g_directorio_temporal+is_fichero_ini,'COLEGIADOS','director_'+string(i),participacion[i])
	if autor=nombre_comp then
		SetProfileString(g_directorio_temporal+is_fichero_ini,'COLEGIADOS','autor_'+string(i),'S')
	else
		SetProfileString(g_directorio_temporal+is_fichero_ini,'COLEGIADOS','autor_'+string(i),'N')		
	end if
	SetProfileString(g_directorio_temporal+is_fichero_ini,'COLEGIADOS','csfp_'+string(i),'N')	
	SetProfileString(g_directorio_temporal+is_fichero_ini,'COLEGIADOS','director_em_'+string(i),'N')	
	SetProfileString(g_directorio_temporal+is_fichero_ini,'COLEGIADOS','autor_ess_'+string(i),'N')	
	SetProfileString(g_directorio_temporal+is_fichero_ini,'COLEGIADOS','autor_eb_'+string(i),'N')	
	SetProfileString(g_directorio_temporal+is_fichero_ini,'COLEGIADOS','atcssdo_'+string(i),'N')	
	SetProfileString(g_directorio_temporal+is_fichero_ini,'COLEGIADOS','funcionario_'+string(i),'N')	
next

//26/01/2010 porrero COAM-313

if not flag then 
	SetProfileString(g_directorio_temporal+is_fichero_ini,'ARQUITECTOS','total','1')
	SetProfileString(g_directorio_temporal+is_fichero_ini,'ARQUITECTOS','apellidos_1',autor)
	SetProfileString(g_directorio_temporal+is_fichero_ini,'ARQUITECTOS','autor_1','S')
	SetProfileString(g_directorio_temporal+is_fichero_ini,'ARQUITECTOS','director_1','N')
	SetProfileString(g_directorio_temporal+is_fichero_ini,'ARQUITECTOS','numero_1','0')
	SetProfileString(g_directorio_temporal+is_fichero_ini,'ARQUITECTOS','titulacion_1',titulacion)
end if
return err
end function

private function integer f_escribir_datos_clientes ();// Funci$$HEX1$$f300$$ENDHEX$$n que escribe los datos de la secci$$HEX1$$f300$$ENDHEX$$n [CLIENTES]

// Parametros de Entrada:
//   NINGUNO

// Parametros de Salida:
//   integer err - Error en la escritura

integer err
integer fic,i
double particip
//FUNCIONAMIENTO:

// Comprobamos si existe el fichero
fic = FileOpen(g_directorio_temporal+is_fichero_ini, LineMode!, Write!, LockReadWrite!, Append!,EncodingAnsi!)
if fic<0 then return -2

FileClose(fic)

if ii_num_cli<=0 then return err
// Escribir el cliente
SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','total',string(ii_num_cli))
particip=100/ii_num_cli
for i=1 to ii_num_cli
	if ii_num_cli=3 and i=3 then particip=33.34
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','nif_'+string(i),cli_nif[i])	
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','participacion_'+string(i),string(particip))
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','promotor_'+string(i),'S')		
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','autor_encargo_'+string(i),'N')		
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','apellidos_'+string(i),cli_nombre[i])		
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','tipo_via_'+string(i),'00')
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','nombre_via_'+string(i),cli_direccion[i])		
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','cp_'+string(i),cli_cp[i])			
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','poblacion_'+string(i),cli_poblacion[i])			
	
	// Escribir el representante
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','rep_nif_'+string(i),rep_nif[i])	
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','promotor_'+string(i),'S')		
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','autor_encargo_'+string(i),'N')		
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','rep_apellidos_'+string(i),rep_nombre[i])		
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','rep_tipo_via_'+string(i),'00')
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','rep_direcciona_'+string(i),rep_direccion[i])		
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','rep_cp_'+string(i),rep_cp[i])	
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CLIENTES','rep_poblacion_'+string(i),rep_poblacion[i])			
	

next


return err
end function

private function integer f_escribir_datos_contrato ();// Funci$$HEX1$$f300$$ENDHEX$$n que escribe los datos de la secci$$HEX1$$f300$$ENDHEX$$n [CONTRATO]

// Parametros de Entrada:
//   NINGUNO

// Parametros de Salida:
//   integer err - Error en la escritura  (0-> todo correcto, < 0 -> Fallo)

integer err=0,fic
string cod_pos,descripcion
//FUNCIONAMIENTO:
// Escribir los datos del contrato
is_fichero_ini=left(is_fichero_zip,len(is_fichero_zip) -4) +'.ini'
fic = FileOpen(g_directorio_temporal+is_fichero_ini, LineMode!, Write!, LockReadWrite!, Replace!,EncodingAnsi!)
if fic<0 then return -2

FileClose(fic)

if right(g_directorio_temporal,1)<>'\' then g_directorio_temporal+='\'
SetProfileString(g_directorio_temporal+is_fichero_ini,'VERSIONES','version',is_version)
SetProfileString(g_directorio_temporal+is_fichero_ini,'DESCRIPTORES','tipo',is_tipo)
SetProfileString(g_directorio_temporal+is_fichero_ini,'COLEGIO','colegio','33')
SetProfileString(g_directorio_temporal+is_fichero_ini,'COLEGIO','delegaci$$HEX1$$f300$$ENDHEX$$n','01')

SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','n_registro',is_num_interno)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','n_expedi','')
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','n_visado',is_num_visado)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','n_exp_colegial','')
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','n_reg_colegial','')
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','f_entrada',is_f_entrada)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','f_visado',is_f_visado)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','f_abono','')
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','f_final_obra','')
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','cerrado','N')
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','titulo',descripcion_obra)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','tipo_actuacion',tipo_act1)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','tipo_obra',tipo_obra)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','destino',destino)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','tipo_via_emplazamiento','00')
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','emplazamiento',is_emplazamiento)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','n_calle',is_bloque+is_escalera)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','piso',is_piso)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','puerta',is_puerta)
is_municipio='M'+is_municipio
select cod_pos,descripcion into :cod_pos,:descripcion from poblaciones where cod_pob=:is_municipio;
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','cod_pos',cod_pos)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','desc_poblacion',descripcion)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','poblacion',is_municipio)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','cod_pos',is_cp)
if gestion_cobro='1' then
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','gestion_de_cobro','C')
else
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','gestion_de_cobro','P')	
end if

if obra_oficial='1' then
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','administracion','S')
else
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','administracion','N')	
end if

if estudio_geo='1' then
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','estudio geotecnico','S')
else
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','estudio geotecnico','N')	
end if

if uso_edif='1' then
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','uso','V')
elseif uso_edif='2' then
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','uso','A')	
else
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','uso','U')
end if

if medianeras='2' then
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','colindantes','01')
else
	if num_lados='1' then
		SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','colindantes','02')
	else
		SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','colindantes','03')
	end if
end if
	

SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','observaciones',observaciones)

SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','volumen',volumen)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','altura',altura)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','sup_viv',sup_viv)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','sup_garaje',sup_garaje)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','sup_otros',sup_otros)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','total_sup',string(long(sup_viv)+long(sup_garaje)+long(sup_otros)))
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','num_viv',num_viviendas)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','num_edif',num_edificios)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','clase_promotor',clase_promotor)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','honorarios',honor)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','sup_baj',sup_br)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','sup_sob',sup_sr)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','plantas_baj',plantas_br)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','plantas_sob',plantas_sr)

SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','tipologia',tipologia)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','sup_parcela',sup_parcela)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','pem',pem)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','pres_seguridad',pre_seguridad)

SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','n_visado_pb',n_visado_pb)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','n_visado_pe',n_visado_pe)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','f_visado_pb',f_visado_pb)
SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','f_visado_pe',f_visado_pe)

if mantenimiento='1' then
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','mantenimiento','S')
else
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','mantenimiento','N')
end if

SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','f_mantenimiento',f_mantenimiento)


 
if cc_hormi='1' then
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','cc_hormigon','S')
else
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','cc_hormigon','N')
end if

if cc_acero='1' then
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','cc_acero','S')
else
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','cc_acero','N')	
end if

if cc_hormi_tipo='1' then
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','cc_hormigon_tipo','1')
else
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','cc_hormigon_tipo','2')	
end if

if cc_acero_tipo='1' then
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','cc_acero_tipo','1')
else
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','cc_acero_tipo','2')	
end if

if cc_forjado='1' then
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','cc_forjado','S')
else
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','cc_forjado','N')
end if

if cc_muros='1' then
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','cc_muros','S')
else
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','cc_muros','N')	
end if

if cc_cubiertas='1' then
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','cc_cubiertas','S')
else
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','cc_cubiertas','N')	
end if

return err



end function

private function integer f_crear_zip ();// Funci$$HEX1$$f300$$ENDHEX$$n que crear el fichero .zip con los datos de la obra y los documentos adjuntos
// Parametros de Entrada:
//   NINGUNO
// Parametros de Salida:
//   integer err - Error en la escritura  (0-> todo correcto, < 0 -> Fallo)

integer err

// FUNCIONAMIENTO
oleobject zip, Files, oFile
integer retorno1,retorno2,retorno3,i


// Crear ZIP INTERVENCION 1
zip = create oleobject
retorno1 = zip.ConnectToNewObject("SAWZip.Archive")

if retorno1 < 0 then return -4
try
	zip.create(is_ruta_salida + is_fichero_zip_1)
catch (throwable e1)
	return -5
end try
	
Files = create oleobject
retorno2 = Files.ConnectToNewObject("SAWZip.Files")
Files = zip.Files

// Adjuntar fichero .ini
oFile = create oleobject
retorno3 = oFile.ConnectToNewObject("SAWZip.File")	

oFile.Name = g_directorio_temporal+is_fichero_ini
Files.Add(oFile)


// Adjuntar ficheros del contrato
for i = 1 to UpperBound(docs_nombre)
	oFile = create oleobject
	retorno3 = oFile.ConnectToNewObject("SAWZip.File")	
	if Not(FileExists( g_directorio_temporal+docs_nombre[i])) then continue
	oFile.Name =  g_directorio_temporal+docs_nombre[i]
	try
		Files.Add(oFile)
	catch (throwable e2)
		return -6
	end try
		
next

// Cerrar zip
zip.close()
destroy zip
destroy files
destroy oFile

if not(f_es_vacio(tipo_act2)) then
	// Crear ZIP INTERVENCION 2
	SetProfileString(g_directorio_temporal+is_fichero_ini,'CONTRATO','tipo_actuacion',tipo_act2)
	zip = create oleobject
	retorno1 = zip.ConnectToNewObject("SAWZip.Archive")
	
	if retorno1 < 0 then return -4
	try
		zip.create(is_ruta_salida + is_fichero_zip_2)
	catch (throwable e3)
		return -5
	end try
		
	Files = create oleobject
	retorno2 = Files.ConnectToNewObject("SAWZip.Files")
	Files = zip.Files
	
	// Adjuntar fichero .ini
	oFile = create oleobject
	retorno3 = oFile.ConnectToNewObject("SAWZip.File")	
	
	oFile.Name = g_directorio_temporal+is_fichero_ini
	Files.Add(oFile)
	
	
	// Adjuntar ficheros del contrato
	for i = 1 to UpperBound(docs_nombre)
		oFile = create oleobject
		retorno3 = oFile.ConnectToNewObject("SAWZip.File")	
		if Not(FileExists( g_directorio_temporal+docs_nombre[i])) then continue
		oFile.Name =  g_directorio_temporal+docs_nombre[i]
		try
			Files.Add(oFile)
		catch (throwable e4)
			return -6
		end try
			
	next
	
	// Cerrar zip
	zip.close()
	destroy zip
	destroy files
	destroy oFile
end if

return err
end function

public function string of_error (integer err);// FUNCION QUE DEVUELVE EL MENSAJE DE ERROR
// ENTRADA: Codigo del error
// SALIDA: Descripcion del error
string descripcion

choose case err
	case -1
		descripcion= "Error al abrir el fichero XML"
	case -2
		descripcion="Error al intentar crear el fichero .INI"
	case -3
		descripcion="Error al crear el objeto XML"
	case -4
		descripcion="No se pudo acceder a la libreria sawzip.dll"		
	case -5
		descripcion="No se pudo crear el zip en la ruta destino"			
	case -6
		descripcion="No se pudo comprimir el fichero en el zip"				
end choose
return descripcion
end function

public function integer of_convertir ();// Funci$$HEX1$$f300$$ENDHEX$$n que genera el fichero ZIP con los documentos y un .INI a partir del XML de entrada

// Parametros de Entrada:
//   NINGUNO

// Parametros de Salida:
//   integer err - C$$HEX1$$f300$$ENDHEX$$digo del error  (0-> todo correcto, < 0 -> Fallo)

integer err
// Cargamos las variables del objeto con los datos del XML
err=f_cargar_datos_xml()
if err<0 then return err
 // Si devuelve 1 estamos cargando un recibo. Solamente se nesita tener acceso a los datos leidos
if err=1 then return 0

// Escribimos en el .ini los datos del contrato
err=f_escribir_datos_contrato()
if err<0 then return err

// Escribimos en el .ini los datos de los clientes
err=f_escribir_datos_clientes()
if err<0 then return err

// Escribimos en el .ini los datos de los colegiados
err=f_escribir_datos_colegiados()
if err<0 then return err

// Creamos el .zip con los datos del contrato y los adjuntos
err=f_crear_zip()
if err<0 then return err

return 0

end function

private function integer f_cargar_datos_xml ();// Funci$$HEX1$$f300$$ENDHEX$$n que carga los datos del XML en variables internas del objeto 
// Parametros de Entrada:
//   NINGUNO

// Parametros de Salida:
//   integer err - Error obtenido en la carga de datos (0-> todo correcto, < 0 -> Fallo)
integer err
string campo,valor,tipo_xml
string xml_string,linea
long i,j,k,fd

// FUNCIONAMIENTO



// CONVERTIMOS EL XML EN STRING YA QUE DIRECTAMENTE NO LEE BIEN LOS RETORNOS DE CARRO
fd = FileOpen(is_fichero_xml,LineMode!,Read!,LockWrite!)
if fd<0 then return -1
pbdom_bldr = Create PBDOM_Builder
xml_string = ''
do while FileRead(fd,linea) > 0
	linea=trim(linea)
	if xml_string = '' then
		xml_string += linea
	else
		xml_string = xml_string + linea
	end if
loop

Fileclose(fd)

try
	pbdom_doc = pbdom_bldr.buildfromString(xml_string)
catch (throwable e1)
	return -3
end try



pbdom_doc.GetContent(cabecera_xml[])
cabecera_xml[2].GetContent(contenido[])
contenido[1].GetContent(contrato[])

campo = contenido[1].GetName()

// DEPENDIENDO DEL TIPO DE XML USAMOS UNA FUNCION U OTRA
is_tipo='NUEVO'
choose case campo
	case 'COAT_VISADO_COLEGIO'
		err=f_cargar_datos_visados()
		
	case 'COAT_VISADO_ANEXO'
		is_tipo='ANEXO'
		err=f_cargar_datos_visados()		
		
	case 'COAT_CERTIFICADO_HABITABILIDAD_COLEGIO'
		err=f_cargar_datos_certif()
		
	case 'COAT_PRIMAS_VISADOS','COAT_CUOTAS_INTERVENCION_V','COAT_CUOTAS_COLEGIADOS','COAT_CUOTAS_INTERVENCION_CH'
		err=f_cargar_datos_recibos()
end choose



return err
end function

public function integer f_cargar_datos_certif ();long i,j
string campo,valor

// ******************************	
// CARGA DE LOS DATOS DEL CONTRATO	
// ******************************
tipo_act1='79'
tipo_obra='00'
destino='00'
gestion_cobro='P'
obra_oficial='N'
descripcion_obra='CERTIFICADO DE HABITABILIDAD'
ii_num_cli=1
ii_num_col=1
is_version='XML CH COAATMCA'
for i=1 to UpperBound(contrato)
	campo = contrato[i].GetName()
	valor = contrato[i].GetText()		

	  choose case campo
		case 'DOCUMENTACION'
			contrato[i].GetContent(lista_docs[])				
		//case 'AUTOR_PROYECTO'
		//	autor=valor
		case 'NUM_WEB'
			is_num_web=valor
		case 'NUM_INTERNO'
			is_num_interno=valor
		case 'NUM_CERTIFICADO'
			is_num_certificado=valor
		case 'SITUACION_CERTIFICADO'
			is_situacion=valor			
		case 'EMPLAZAMIENTO'
			is_emplazamiento=valor
		case 'BLOQUE'
			is_bloque=valor
		case 'ESCALERA'
			is_escalera=valor
		case 'PISO'
			is_piso=valor
		case 'PUERTA'
			is_puerta=valor
		case 'TIPO_CERTIF'
			is_tipo_cert=valor
		case 'TIPO_EDIFICIO'
			is_tipo_edificio=valor
		case 'NOMBRE_PROMOTOR'
			cli_nombre[1]=valor
			cli_nif[1]='0'
			cli_numero[1]=''
			cli_direccion[1]=''			
			cli_poblacion[1]=''
			cli_nacionalidad[1]=''
			cli_cp[1]=''
			rep_nombre[1]=''
			rep_direccion[1]=''				
			rep_cp[1]=''
			rep_poblacion[1]=''
			rep_nif[1]=''
			rep_telefono[1]=''
			rep_nacionalidad[1]=''
	
		CASE 'MUNICIPIO'
			is_municipio=valor
		case 'CODIGO_POSTAL'
			is_cp=valor
		case 'COAT_COD_COLEGIADO'
			colegiados[1]=valor
			participacion[1]='100'
		case 'FECHA_EMISION'
			is_f_entrada=valor
		case 'FECHA_VISADO'
			is_f_visado=valor

	end choose	
	
next


// ******************************	
// CARGA DE LOS DATOS DE DOCUMENTOS
// ******************************
string ruta_xml

ruta_xml=left(is_fichero_xml,lastpos(is_fichero_xml,'\'))
for i=1 to UpperBound(lista_docs)
	lista_docs[i].GetContent(docs[])
	for j=1 to UpperBound(docs)
		campo = docs[j].GetName()
		valor = docs[j].GetText()		
		choose case campo
			case 'NOMBRE_DOC'
				docs_nombre[i]=valor
				CopyFile(ruta_xml+valor,g_directorio_temporal+valor,0)

		end choose
		
	next
next
return 0
end function

public function integer f_cargar_datos_recibos ();long i,j,k
string campo,valor
// ******************************	
// CARGA DE LOS DATOS DEL CONTRATO	
// ******************************

for i=1 to UpperBound(contrato)
	campo = contrato[i].GetName()
	valor = contrato[i].GetText()		
	
	  choose case campo
		case 'COAT_COD_COLEGIADO'
			colegiados[1]=valor			
	//	case 'NUM_INTERNO'
	//		is_num_interno=valor
		case 'IMPORTE_TOTAL'
			is_importe=valor
		case 'NUM_RECIBO'
			is_num_recibo=valor
		case 'ESTADO'
			is_estado_recibo=valor			
		
	end choose	
	
next


return 1
end function

public function integer f_cargar_datos_visados ();long i,j,k
string campo,valor
n_cst_string cadenas
// ******************************	
// CARGA DE LOS DATOS DEL CONTRATO	
// ******************************
is_version='XML VISADO COAATMCA'

for i=1 to UpperBound(contrato)
	campo = contrato[i].GetName()
	valor = contrato[i].GetText()		
	
	  choose case campo
		case 'COAT_CLIENTE'
			contrato[i].GetContent(lista_clientes[])
		case 'DOCUMENTACION'
			contrato[i].GetContent(lista_docs[])				
		case 'COAT_COLEGIADOS'
			contrato[i].GetContent(lista_colegiados[])								
		case 'NUM_WEB'
			is_num_web=valor
		case 'NUM_INTERNO'
			is_num_interno=valor
		case 'NUM_VISADO'
			is_num_visado=valor
		case 'SITUACION_VISADO'
			is_situacion=valor			
		case 'EMPLAZAMIENTO'
			is_emplazamiento=valor
		CASE 'MUNICIPIO'
			is_municipio=valor	
		case 'FECHA_CONTRATO'
			is_f_entrada=valor
		case 'FECHA_VISADO'
			is_f_visado=valor			
		case 'AUTOR_PROYECTO'
			autor=valor
		case 'TITULACION'
			titulacion=valor
		case 'TIPO_INTERVENCION1'
			tipo_act1=valor
		case 'TIPO_INTERVENCION2'
			tipo_act2=valor
		case 'CODIGO_OBRA'
			tipo_obra=valor	
		case 'CODIGO_DEST'
			destino=valor			
		case 'DESCRIPCION'
			descripcion_obra=valor
		case 'GESTION_DE_COBRO'
			gestion_cobro=valor			
		case 'OBRA_OFICIAL'
			obra_oficial=valor			
		case 'SUPERF_GARAJE'
			sup_garaje=valor
		case 'PLANTAS_BAJO_RASANTE'
			plantas_br=valor
		case 'PLANTAS_SOBRE_RASANTE'
			plantas_sr=valor			
		case 'NUM_EDIFICIOS'
			num_edificios=valor
		case 'NUM_VIVIENDAS'
			num_viviendas=valor
		case 'ENTRE_MEDIANERA'
			medianeras=valor
		case 'PLANTAS_SOBRE_RASANTE'
			plantas_sr=valor		
		case 'PRESUPUESTO_OBRA'
			pem=cadenas.of_globalreplace(valor,'.',',')

		case 'PRE_SEGURIDAD'
			pre_seguridad=cadenas.of_globalreplace(valor,'.',',')
	
		case 'VOLUMEN'
			volumen=valor			
		case 'ALTURA'
			altura=valor									
		case 'HONORARIOS'
			honor=valor
		case 'SUPERF_VIVIENDAS'
			sup_viv=valor
		case 'SUPERF_GARAJE'
			sup_garaje=valor
		case 'SUPERF_OTROS_USOS'
			sup_otros=valor
		case 'SUPERF_SOBRE_RASANTE'
			sup_sr=valor
		case 'SUPERF_BAJO_RASANTE'
			sup_br=valor
		case 'NUM_LADOS'
			num_lados=valor
		case 'OBSERVACIONES'
			observaciones=valor	
		case 'CONTROL_CALIDAD_FORJADO'
			cc_forjado=valor
		case 'CONTROL_CALIDAD_ACERO'
			cc_acero=valor
		case 'TIPO_CC_ACERO'
			cc_acero_tipo=valor
		case 'CONTROL_CALIDAD_HORMIGON'
			cc_hormi=valor
		case 'TIPO_CC_HORMI'
			cc_hormi_tipo=valor
		case 'CONTROL_CALIDAD_MUROS'
			cc_muros=valor			
		case 'CONTROL_CALIDAD_CUBIERTAS'
			cc_cubiertas=valor
		case 'SUPERFICIE_PARCELA'
			sup_Parcela=valor
		case 'CODIGO_CLASE_PROMOTOR'
			clase_promotor=valor
		case 'USO_EDIFICIOS'
			uso_edif=valor
		case 'ESTUDIO_GEOTECNICO'
			estudio_geo=valor
		case 'NACIONALIDAD'
		
		case 'NUM_VISADO_PROYECTO_BASICO'
			n_visado_pb=valor
		case 'NUM_VISADO_PROYECTO_EJECUCION'
			n_visado_pe=valor
		case 'FECHA_VISADO_PROYECTO_BASICO'
			f_visado_pb=valor
		case 'FECHA_VISADO_PROYECTO_EJECUCION'	
			f_visado_pe=valor
		case 'PROGRAMA_MANTENIMIENTO'
			mantenimiento=valor
		case 'FECHA_VISADO_FICHA_MANTENIMIENTO'
			f_mantenimiento=valor			
			
	end choose	
	
next

// ******************************	
// CARGA DE LOS DATOS DE LOS COLEGIADOS
// ******************************


for i=1 to UpperBound(lista_colegiados)
	lista_colegiados[i].GetContent(colegia[])
	for j=1 to UpperBound(colegia)
		campo = colegia[j].GetName()
		valor = colegia[j].GetText()		
		choose case campo
			case 'COAT_COD_COLEGIADO'
				colegiados[i]=valor
			case 'POR_PARTICIPACION'
				participacion[i]=valor
		end choose
	next
next
ii_num_col=UpperBound(lista_colegiados)

// ******************************	
// CARGA DE LOS DATOS DE LOS CLIENTES
// ******************************
for i=1 to UpperBound(lista_clientes)
	lista_clientes[i].GetContent(cliente_rep[])
	for j=1 to UpperBound(cliente_rep)
		campo = upper(cliente_rep[j].GetName())
		valor = cliente_rep[j].GetText()		
		choose case campo
			case 'CLIENTE'
				cliente_rep[j].GetContent(clientes[])
				for k=1 to UpperBound(clientes)
					campo = upper(clientes[k].GetName())
					valor = clientes[k].GetText()		
					choose case campo
						case 'NUM_CLIENTE'
							cli_numero[i]=valor
						case 'NOMBRE'
							cli_nombre[i]=valor
						case 'DIRECCION'
							cli_direccion[i]=valor
						case 'MUNICIPIO'
							cli_poblacion[i]=valor
						case 'NACIONALIDAD'
							cli_nacionalidad[i]=valor
						case 'CP_CLIENTE'
							cli_cp[i]=valor
						case 'NIF'
							cli_nif[i]=valor
					end choose	
				next
			case 'REPRESENTANTE'
				rep_nombre[i]=valor
			case 'DIRECCION'
				rep_direccion[i]=valor				
			case 'CP'
				rep_cp[i]=valor
			case 'MUNICIPIO'
				rep_poblacion[i]=valor
			case 'NIF'
				rep_nif[i]=valor
			case 'TELEFONO'
				rep_telefono[i]=valor
			case 'NACIONALIDAD'
				rep_nacionalidad[i]=valor
		end choose
	next
next
ii_num_cli=UpperBound(lista_clientes)

// ******************************	
// CARGA DE LOS DATOS DE DOCUMENTOS
// ******************************
string ruta_xml

ruta_xml=left(is_fichero_xml,lastpos(is_fichero_xml,'\'))
for i=1 to UpperBound(lista_docs)
	ii_num_ficheros++
	lista_docs[i].GetContent(docs[])
	for j=1 to UpperBound(docs)
		campo = docs[j].GetName()
		valor = docs[j].GetText()		
		choose case campo
			case 'NOMBRE_DOC'
				docs_nombre[i]=valor
				CopyFile(ruta_xml+valor,g_directorio_temporal+valor,0)
			case 'TIPO_DOC'
				docs_tipo[i]=valor
			case 'FECHA_CREACION'
				docs_fecha[i]=valor		
		end choose
		
	next
next
return 0
end function

on n_csd_conversion_xml_a_zip.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_csd_conversion_xml_a_zip.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

