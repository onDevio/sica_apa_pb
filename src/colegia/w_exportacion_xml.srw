HA$PBExportHeader$w_exportacion_xml.srw
forward
global type w_exportacion_xml from w_response
end type
type dw_colegiados from u_csd_dw within w_exportacion_xml
end type
type dw_datos from u_csd_dw within w_exportacion_xml
end type
type cb_1 from commandbutton within w_exportacion_xml
end type
type cbx_colegiados from checkbox within w_exportacion_xml
end type
type cbx_sociedades from checkbox within w_exportacion_xml
end type
type st_1 from statictext within w_exportacion_xml
end type
type st_2 from statictext within w_exportacion_xml
end type
type cbx_cta_banco from checkbox within w_exportacion_xml
end type
type cbx_bajas from checkbox within w_exportacion_xml
end type
type dw_1 from u_csd_dw within w_exportacion_xml
end type
type cbx_domicilio from checkbox within w_exportacion_xml
end type
type gb_1 from groupbox within w_exportacion_xml
end type
end forward

global type w_exportacion_xml from w_response
integer width = 2039
integer height = 960
dw_colegiados dw_colegiados
dw_datos dw_datos
cb_1 cb_1
cbx_colegiados cbx_colegiados
cbx_sociedades cbx_sociedades
st_1 st_1
st_2 st_2
cbx_cta_banco cbx_cta_banco
cbx_bajas cbx_bajas
dw_1 dw_1
cbx_domicilio cbx_domicilio
gb_1 gb_1
end type
global w_exportacion_xml w_exportacion_xml

type variables
datastore 				idst_colegiados, idst_sociedades, idst_musaat, idst_dir_fiscal, idst_dir_comercial, idst_otros_datos, &
							idst_titulaciones_habilitante, idst_inhabilitaciones, idst_incompatibilidades, isdt_otros_src
PBDOM_Builder     	pbdom_bldr
pbdom_document		i_pbdom_doc
PBDOM_Object      		l_raiz[]

end variables

forward prototypes
public function string wf_municipio (string as_pob_mopu)
public function string wf_pass_md5 (string cadena_a_encriptar)
public function string wf_trasnforma_xml (string archivo_xml)
public subroutine wf_xml_sociedades ()
public subroutine wf_xml_colegiados (datastore ldst_colegiados)
public subroutine wf_pbdom_colegiado ()
end prototypes

public function string wf_municipio (string as_pob_mopu);string  ls_municipio
  
  SELECT municipios.descripcion  
    INTO :ls_municipio  
    FROM municipios  
   WHERE municipios.cod_muni = :as_pob_mopu   ;


return ls_municipio
end function

public function string wf_pass_md5 (string cadena_a_encriptar);long ll_status

OLEObject PBObject

String resultado

//String cadena_a_encriptar

 

PBObject = CREATE OLEObject 

ll_status = PBObject.ConnectToNewObject ("CryptKci.clsCryptoAPI")

//IF ll_status <> 0 THEN 
//
//MessageBox("Error", String(ll_status)) 
//
//Return 

//ELSE 


resultado = PBObject.CreateHash(cadena_a_encriptar,1,true,false,true)
//resultado = PBObject.Encrypt(1)

 
//END IF 

 
//DESTROY PBObject 
PBObject.DisconnectObject( )
return resultado




end function

public function string wf_trasnforma_xml (string archivo_xml);// Declare an OLE object as a reference to the parser 
oleobject  lole_xml_document , lole_xsl_document 
string ls_result ='S'
  
// Identify the file to parse (if hardcoded) 
//string ls_filename = archivo_xml
string ls_xslfilename = "C:\Sica\filtro_fichero_intercambio.xsl" 
  

// Create the OLE Object 
lole_xml_document = CREATE oleobject 
lole_xsl_document = CREATE oleobject 
//lole_result = CREATE oleobject 
// Connect to the parser 
// NOTE : This example uses the parser from IE5. 
// Use the class name "MSXML2.DOMDocument.3.0" 
// Older version: Microsoft.XMLDOM 
// for the latest version. 

Integer li_rc 

li_rc = lole_xml_document.ConnectToNewObject("MSXML2.DOMDocument.3.0") 

IF li_rc < 0 THEN 

   MessageBox("Connecting to COM Object Failed", "Error: " + String(li_rc)) 

   DESTROY lole_xml_document 

 Return ''

END IF 
  

  Integer li_rc1 

li_rc = lole_xsl_document.ConnectToNewObject("MSXML2.DOMDocument.3.0") 

IF li_rc1 < 0 THEN 

   MessageBox("Connecting to COM Object Failed", "Error: " + String(li_rc)) 

   DESTROY lole_xsl_document 

 Return ''

END IF 
  
  

// Load the file into memory (this will parse it) 
boolean lb_test 
lb_test=lole_xml_document.load(archivo_xml) 
  IF lb_test = false THEN 
    //Demonstrate the parseError attribute 
//    MessageBox("Load of XML doc Failed", "ErrorCode: "+string(lole_xml_document.parseError.ErrorCode)+ "~n~r" & 
//  + "FilePosition: " +string(lole_xml_document.parseError.Filepos)+ "~n~r" & 
//  + "Line: " +string(lole_xml_document.parseError.Line)+ "~n~r" & 
//  + "LinePosition: " +string(lole_xml_document.parseError.Linepos)+ "~n~r" & 
//  + "Reason: " +string(lole_xml_document.parseError.Reason)+ "~n~r" & 
//  + "SourceText: " +string(lole_xml_document.parseError.SrcText)) 

   DESTROY lole_xml_document 
   ls_result = 'N'
   Return ls_result

END IF

// Load the file into memory (this will parse it) 
boolean lb_test1 
lb_test1=lole_xsl_document.load(ls_xslfilename) 
  IF lb_test1 = false THEN 
    //KK-Demonstrate the parseError attribute 
//    MessageBox("Load of XML doc Failed", "ErrorCode: "+string(lole_xsl_document.parseError.ErrorCode)+ "~n~r" & 
//  + "FilePosition: " +string(lole_xsl_document.parseError.Filepos)+ "~n~r" & 
//  + "Line: " +string(lole_xsl_document.parseError.Line)+ "~n~r" & 
//  + "LinePosition: " +string(lole_xsl_document.parseError.Linepos)+ "~n~r" & 
//  + "Reason: " +string(lole_xsl_document.parseError.Reason)+ "~n~r" & 
//  + "SourceText: " +string(lole_xml_document.parseError.SrcText)) 
   DESTROY lole_xsl_document 
   ls_result = 'N'
   Return ls_result

END IF 
  
if  ls_result <> 'N' then
	
	ls_result=lole_xml_document.transformNode(lole_xsl_document) 
	
	integer li_FileNum
	
	li_FileNum = FileOpen(archivo_xml, TextMode!, Write!, Shared!, Replace!, EncodingUTF16LE! )
	FileWriteEx(li_FileNum, ls_result)
end if

// Disconnect from the XML parser 
lole_xml_document.DisConnectObject() 

lole_xsl_document.DisConnectObject() 
  

// Destroy the OLE object 
DESTROY lole_xml_document 
DESTROY lole_xsl_document

return ls_result

end function

public subroutine wf_xml_sociedades ();//PBDOM_Builder     	pbdom_bldr
PBDOM_Document    	pbdom_doc
PBDOM_Object      		l_lista_sociedades[], l_fichero_intercambio[], l_sociedad[], l_direccion_com[], l_sub_nodo[]
PBDOM_Object			l_datos_acreditacion[], l_lista_representantes[], l_representante[], l_socio[], l_direccion_fis[]
PBDOM_Element     	pbdom_elem[], pbdom_sub_elem[], l_sub_elem_representante[], pbd_representante, rep_nombre, rep_apellido
PBDOM_Element		pbdom_rep_nodo, pbdom_dir_fis[],	pbdom_via
PBDOM_Element		pbdom_raiz, pbdom_nodo, pbdom_sociedades, pbdom_cuerpo, pbdom_sub_nodo
//pbdom_document i_pbdom_doc
pbdom_document doc

integer iFileNum1
long l = 0, i, j, ll_reg_soc, ll_n_fallos, k, ll
string campo, valor, nodo, sub_campo, ls_fecha_baja, ls_fecha_insc, ls_colegiado_rep
datastore  ldst_regsoc_socios, ldst_regsoc_actividades

string        ls_colegiado, ls_nif,  ls_cuenta_domic, ls_email, ls_colegio, ls_situacion, ls_n_colegiado, &
			   ls_alta_baja, ls_escuela_final, ls_url, ls_observaciones, ls_login, ls_password, ls_incompatibilidad,&
			  ls_organismo, ls_descripcion, ls_src_alta, ls_src_cia, ls_n_mutualista, ls_src_n_poliza, ls_src_cober,  &
			  ls_telefono_3, ls_telefono_4, ls_telefono_5, ls_n_mutualista_premaat, ls_cif, ls_razon_social, ls_num_reg_mercantil, ls_cod_forma_juridica,ls_telefono,&
			  ls_fax, ls_mail, ls_web, ls_num_reg_colegio, ls_multidisciplinar, ls_cuenta_domic_regsoc, ls_objeto_social, ls_observaciones_regsoc, ls_nif_cliente,&
			  ls_nombre_cliente, ls_apellido_cliente, ls_representantes, ls_nif_socio, ls_nombre_socio, ls_apellido_socio, ls_socios, ls_tipo_via, ls_descrip_via, &
			  ls_nom_via, ls_cp, ls_poblacion, ls_cod_pob, ls_cod_prov, ls_nombre_prov, ls_pais, ls_nombre_pais, ls_municipio,ls_tipo_via_com, ls_descrip_via_com, &
			  ls_nom_via_com, ls_cp_com, ls_poblacion_com, ls_cod_pob_com, ls_cod_prov_com, ls_nombre_prov_com, ls_pais_com, ls_nombre_pais_com, ls_municipio_com,&
			  ls_pob_mopu, ls_descripcion_regsoc, ls_condicion, ls_cod_tipo_regimen, ls_primera_colegiacion, ls_src_compania,&
			  ls_tipo_documento, ls_cod_reg_mercantil, ruta_colegiado, ls_num_orden_protocolo, ls_notario, ls_telefono2, ls_c_tfno_part, ls_c_tfno_prof, ls_c_fax,&
			  ls_c_email, ls_c_url, ls_cod_tipo_idioma, ls_cod_origen
datetime    ldt_f_inicio, ldt_fecha_inscripcion, ldt_fecha_baja, ldt_fecha_escritura, ldt_fecha_fin_const
double      ldb_src_coef_cm, ldb_src_cobertura
//Objeto que comprueba el tipo de documento
u_csd_nif uo_nif

//Trae el valor de los socios profesionales para las sociedades
ldst_regsoc_socios = create datastore
ldst_regsoc_socios.dataobject ='d_dst_sociedades_prof_exportar_xml'
ldst_regsoc_socios.settransobject(sqlca)
ldst_regsoc_socios.retrieve()

//Toma la descripci$$HEX1$$f300$$ENDHEX$$n de las actividades en regosoc_actividades para concatenarlas y armar el archivo xml
ldst_regsoc_actividades = create datastore
ldst_regsoc_actividades.dataobject ='d_dst_sociedades_activid_exportar_xml'
ldst_regsoc_actividades.settransobject(sqlca)
ldst_regsoc_actividades.retrieve()


//string strxml
//
//strxml = "<?xml version='1.0' encoding='UTF-16LE' standalone='no'?>"
//strxml += "<fichero_intercambio>"
//strxml += "<lista_sociedades>"
 
 //Create a PBDOM_DOCUMENT from the XML file
//pbdom_bldr = Create PBDOM_Builder
//
//try
//	
//	boolean lb_exist = false, bRetTemp = FALSE
//	string  ls_docname, strParseErrors[]
//
//	ls_docname =  'C:\SICA\sociedades.xml'
//	lb_exist = FileExists(ls_docname)
//	if not lb_exist then 
//		messagebox(g_titulo, "No se encuentra el fichero en C:\SICA\sociedades.xml")
//		return
//	end if
//
////i_pbdom_doc = pbdom_bldr.BuildFromFile ("C:\SICA\sociedades.xml")
//i_pbdom_doc = pbdom_bldr.BuildFromFile (ls_docname)
//
//bRetTemp = pbdom_bldr.GetParseErrors(strParseErrors)
//if bRetTemp = true then
//	for l = 1 to UpperBound(strParseErrors)
//	MessageBox ("Parse Error", strParseErrors[l])
//	next
//end if
//IF IsValid( i_pbdom_doc ) THEN
//	
//	// Se posiciona en la etiqueta fichero_intercambio
//	i_pbdom_doc.GetContent(l_raiz[])
//
	boolean bb_bool
	
		for ll_reg_soc = 1 to idst_sociedades.rowcount()
				
			st_2.text =  "Procesando........  " + string(ll_reg_soc) + ' de ' + string(idst_sociedades.rowcount()) + ' Sociedades.'
			yield()
				//datos sociedades
		
					ls_colegiado 					= idst_sociedades.getitemstring(ll_reg_soc,"id_colegiado")
					ls_colegio      					= f_equivalencia_vu('VU_COLEGIOS',idst_sociedades.getitemstring(ll_reg_soc,"colegio"))
					ls_cif 								=uo_nif.of_valida_cif(idst_sociedades.getitemstring(ll_reg_soc,"colegiados_nif"))
				
					ls_razon_social 				=  idst_sociedades.getitemstring(ll_reg_soc,"colegiados_apellidos"); if isnull(ls_razon_social) then continue
					ls_num_reg_colegio 			=  idst_sociedades.getitemstring(ll_reg_soc,"regsoc_num_reg_colegio"); if isnull(ls_num_reg_colegio) then ls_num_reg_colegio = ''
					ls_num_reg_mercantil 		=  idst_sociedades.getitemstring(ll_reg_soc,"regsoc_num_reg_mercantil"); if isnull(ls_num_reg_mercantil) then ls_num_reg_mercantil = ''
					ls_num_orden_protocolo 		=  idst_sociedades.getitemstring(ll_reg_soc,"regsoc_const_protocolo"); if isnull(ls_num_orden_protocolo) then ls_num_orden_protocolo = ''
					ls_notario						=  idst_sociedades.getitemstring(ll_reg_soc,"regsoc_const_notario"); if isnull(ls_notario) then ls_notario = ''
					ls_cod_forma_juridica 		=  idst_sociedades.getitemstring(ll_reg_soc,"regsoc_cod_forma_juridica")
					ls_cod_forma_juridica			=  f_equivalencia_vu( 'VU_TIPO_FORMA_JURIDICA',ls_cod_forma_juridica)
					ls_cod_reg_mercantil 			=  idst_sociedades.getitemstring(ll_reg_soc,"cod_reg_mercantil"); if isnull(ls_cod_reg_mercantil) then ls_cod_reg_mercantil = ''
					ls_telefono 						=  idst_sociedades.getitemstring(ll_reg_soc,"telefono"); if isnull(ls_telefono) then ls_telefono = ''
					ls_telefono2						=  idst_sociedades.getitemstring(ll_reg_soc,"telefono_2"); if isnull(ls_telefono2) then ls_telefono2 = ''
					ls_fax 							=  idst_sociedades.getitemstring(ll_reg_soc,"regsoc_fax"); if isnull(ls_fax) then ls_fax = ''
					ls_web 							=  idst_sociedades.getitemstring(ll_reg_soc,"regsoc_web"); if isnull(ls_web) then ls_web = ''
					ls_mail 		 					=  idst_sociedades.getitemstring(ll_reg_soc,"correo"); if isnull(ls_mail) then ls_mail= ''
					ls_c_tfno_part					=  idst_sociedades.getitemstring(ll_reg_soc,"c_telefono_part")	
					ls_c_tfno_prof					=  idst_sociedades.getitemstring(ll_reg_soc,"c_telefono_prof")	
					ls_c_fax							=  idst_sociedades.getitemstring(ll_reg_soc,"c_fax")	
					ls_c_email						=  idst_sociedades.getitemstring(ll_reg_soc,"c_email")	
					ls_c_url							=  idst_sociedades.getitemstring(ll_reg_soc,"c_url")	
					ls_multidisciplinar 				=  idst_sociedades.getitemstring(ll_reg_soc,"regsoc_multidisciplinar")
					ldt_fecha_escritura				=  idst_sociedades.getitemdatetime(ll_reg_soc,"regsoc_const_fecha")
					ldt_fecha_fin_const			=  idst_sociedades.getitemdatetime(ll_reg_soc,"regsoc_const_fecha")
					ldt_fecha_inscripcion 			=  idst_sociedades.getitemdatetime(ll_reg_soc,"regsoc_fecha_inscripcion")
					///* Se cambia la fecha de baja por la fecha de duraci$$HEX1$$f300$$ENDHEX$$n que debe marcar la fecha hasta la que es valida la sociedad. 05/07/2010. Alexis. SCP-403 *///
					//ldt_fecha_baja 					=  idst_sociedades.getitemdatetime(ll_reg_soc,"regsoc_fecha_baja")
					ldt_fecha_baja 					=  idst_sociedades.getitemdatetime(ll_reg_soc,"regsoc_fecha_duracion")
					ls_observaciones_regsoc 	=  idst_sociedades.getitemstring(ll_reg_soc,"regsoc_observaciones")
					ls_cuenta_domic_regsoc 		=  idst_sociedades.getitemstring(ll_reg_soc,"colegiados_cuenta_domic")
					ls_objeto_social = ''
				
					if isnull(ls_cod_forma_juridica) then ls_cod_forma_juridica = ''
					if isnull(ls_cod_reg_mercantil) then ls_cod_reg_mercantil = ''
										
					if isnull(ls_c_tfno_part) or ls_c_tfno_part = 'N' then
					ls_c_tfno_part= 'false' 
					else
						ls_c_tfno_part= 'true' 
					end if
					if isnull(ls_c_tfno_prof) or ls_c_tfno_prof = 'N' then
						ls_c_tfno_prof= 'false' 
					else
						ls_c_tfno_prof= 'true' 
					end if
					if isnull(ls_c_fax) or ls_c_fax = 'N' then
						ls_c_fax= 'false' 
					else
						ls_c_fax= 'true' 
					end if
					if isnull(ls_c_email) or ls_c_email = 'N' then
						ls_c_email= 'false' 
					else
						ls_c_email= 'true' 
					end if
					if isnull(ls_c_url) or ls_c_url = 'N' then
						ls_c_url= 'false' 
					else
						ls_c_url= 'true' 
					end if
					
					if isnull(ls_observaciones_regsoc) then ls_observaciones_regsoc = ''
					if isnull(ls_cuenta_domic_regsoc) then ls_cuenta_domic_regsoc = ''

				//Datos direcciones
			//Fiscal
			if idst_dir_fiscal.rowcount() > 0 then
//				ls_condicion = "id_colegiado ='"+ls_colegiado+"'"
//				idst_dir_fiscal.setfilter(ls_condicion)
//				idst_dir_fiscal.filter()
				long ll_found
				ll_found = idst_dir_fiscal.Find(  "domicilios.profesional = 'S' and domicilios.id_colegiado='"+ls_colegiado+"'",  1, idst_dir_fiscal.RowCount())
				if ll_found <= 0 then 
						// Si no se consigue domicilio fiscal se busca el domicilio fiscal
					ll_found = idst_dir_fiscal.Find(  "domicilios.fiscal = 'S' and domicilios.id_colegiado='"+ls_colegiado+"'",  1, idst_dir_fiscal.RowCount())
				end if
//				
			end if
			
			//Comercial
			if idst_dir_comercial.rowcount() > 0 then
				ls_condicion = "id_colegiado ='"+ls_colegiado+"'"
				idst_dir_comercial.setfilter(ls_condicion)
				idst_dir_comercial.filter()
						
					ls_cod_pob_com = idst_dir_comercial.getitemstring(1,"cod_pob")
					
					ls_nombre_pais_com = idst_dir_comercial.getitemstring(1,"paises_nombre")		
				
			end if
			
			if idst_otros_datos.rowcount() > 0 then
				ls_condicion = "id_colegiado ='"+ls_colegiado+"'"
				idst_otros_datos.setfilter(ls_condicion)
				idst_otros_datos.filter()
		
				if idst_otros_datos.rowcount() > 0 then
					ls_cod_tipo_idioma = idst_otros_datos.getitemstring(1,"t_usuario_cod_tipo_idioma")
					ls_login  =  idst_otros_datos.getitemstring(1,"t_usuario_login")
					if isnull(ls_login) then ls_login = ''
					ls_password  =  idst_otros_datos.getitemstring(1,"t_usuario_password")
					if not isnull(ls_password) then
						ls_password=lower(wf_pass_md5(ls_password))
					else
						ls_password = ''
					end if
					
					ll_n_fallos  =  idst_otros_datos.getitemnumber(1,"t_usuario_n_fallos")
				
				end if
			end if
			
		//actividades de la sociedad
		if ldst_regsoc_actividades.rowcount() > 0 then
				ls_condicion = "colegiados_id_colegiado ='"+ls_colegiado+"'"
				ldst_regsoc_actividades.setfilter(ls_condicion)
				ldst_regsoc_actividades.filter()
		
				if ldst_regsoc_actividades.rowcount() > 0 then
					for i = 1 to ldst_regsoc_actividades.rowcount()
						ls_objeto_social += ldst_regsoc_actividades.getitemstring(i, 'regsoc_actividades_descripcion')
						ls_objeto_social += '. '
						
					next
				end if
				ldst_regsoc_actividades.setfilter('')
				ldst_regsoc_actividades.filter()
		end if
		if isnull(ls_objeto_social)	 then ls_objeto_social	 = ''
		bb_bool = i_pbdom_doc.getelementsbytagname('lista_sociedades', pbdom_elem)
		
		pbdom_sociedades = create pbdom_element
		pbdom_sociedades.SetName("Sociedad")	
		
		// Agregamos nodo de cif
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cif")
		pbdom_cuerpo.AddContent(ls_cif)
		pbdom_sociedades.AddContent(pbdom_cuerpo)
		
		// Agregamos nodo de razon_social
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("razon_social")
		pbdom_cuerpo.AddContent(ls_razon_social)
		pbdom_sociedades.AddContent(pbdom_cuerpo)
		
		// Agregamos nodo de num_reg_colegio
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("num_reg_colegio")
		pbdom_cuerpo.AddContent(ls_num_reg_colegio)
		pbdom_sociedades.AddContent(pbdom_cuerpo)
	
		// Agregamos nodo de num_reg_mercantil
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("num_reg_mercantil")
		pbdom_cuerpo.AddContent(ls_num_reg_mercantil)
		pbdom_sociedades.AddContent(pbdom_cuerpo)
		
		// Agregamos nodo de fecha de escritura de constitucion
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("fecha_escritura_constitucion")
		ls_fecha_insc = string(date(ldt_fecha_escritura),  "yyyy-mm-dd")
		if isnull(ls_fecha_insc) or  ls_fecha_insc = ''  then ls_fecha_insc = '0001-01-01'
		pbdom_cuerpo.AddContent(ls_fecha_insc)
		pbdom_sociedades.AddContent(pbdom_cuerpo)
		
		// Agregamos nodo de numero de orden protocolo
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("num_orden_protocolo")
		pbdom_cuerpo.AddContent(ls_num_orden_protocolo)
		pbdom_sociedades.AddContent(pbdom_cuerpo)
		
		// Agregamos nodo de notario autorizante
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("notario_autorizante")
		pbdom_cuerpo.AddContent(ls_notario)
		pbdom_sociedades.AddContent(pbdom_cuerpo)
		
		// Agregamos nodo de fecha_fin_constitucion
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("fecha_finconstitucion")
		ls_fecha_insc = string(date(ldt_fecha_fin_const),  "yyyy-mm-dd")
		if isnull(ls_fecha_insc) or  ls_fecha_insc = ''  then ls_fecha_insc = '0001-01-01'
		pbdom_cuerpo.AddContent(ls_fecha_insc)
		pbdom_sociedades.AddContent(pbdom_cuerpo)
		
		// Agregamos nodo de direccion_correspondencia
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("direccion_correspondencia")
		
		if idst_dir_comercial.rowcount()>0 then
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_tipo_via")
				ls_tipo_via_com =f_equivalencia_vu('VU_TIPO_VIA',idst_dir_fiscal.getitemstring(1,"tipo_via"))
				pbdom_via.AddContent(ls_tipo_via_com)
				pbdom_cuerpo.AddContent(pbdom_via)
	
				pbdom_via= create pbdom_element
				pbdom_via.SetName("nom_via")
				ls_nom_via_com = idst_dir_comercial.getitemstring(1,"nom_via"); if isnull(ls_nom_via_com) then ls_nom_via_com = ''
				pbdom_via.AddContent(ls_nom_via_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_postal")
				ls_cp_com = idst_dir_comercial.getitemstring(1,"cp"); if isnull(ls_cp_com) then ls_cp_com = '0000'
				pbdom_via.AddContent(ls_cp_com)
				pbdom_cuerpo.AddContent(pbdom_via)
	
				pbdom_via= create pbdom_element
				pbdom_via.SetName("poblacion")
				ls_poblacion_com= idst_dir_comercial.getitemstring(1,"poblaciones_descripcion"); if isnull(ls_poblacion_com) then ls_poblacion_com = ''
				pbdom_via.AddContent(ls_poblacion_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_municipio")
				ls_pob_mopu = idst_dir_comercial.getitemstring(1,"poblaciones_pob_mopu")
				if  ls_pob_mopu = '' or isnull(ls_pob_mopu) then
						ls_municipio_com= '000'
				else
						ls_municipio_com=ls_pob_mopu
				end if						
				pbdom_via.AddContent(ls_municipio_com)
				pbdom_cuerpo.AddContent(pbdom_via)
				
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_provincia")
				ls_cod_prov_com = f_equivalencia_vu( 'VU_PROVINCIAS',idst_dir_comercial.getitemstring(1,"cod_prov"))
				pbdom_via.AddContent(ls_cod_prov_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("desc_provincia")
				ls_nombre_prov_com = f_nombre_provincias_vu(ls_cod_prov_com)
				pbdom_via.AddContent(ls_cod_prov_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_pais")
				ls_pais_com = idst_dir_comercial.getitemstring(1,"cod_iso"); if isnull(ls_pais_com) then ls_pais_com= '0'
				pbdom_via.AddContent(ls_pais_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
			end if	
		pbdom_sociedades.AddContent(pbdom_cuerpo)
		
		// Agregamos nodo de direccion_fiscal
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("direccion_fiscal")
		if ll_found > 0 then 
		//if idst_dir_fiscal.rowcount()>0 then
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_tipo_via")
				ls_tipo_via =f_equivalencia_vu('VU_TIPO_VIA',idst_dir_fiscal.getitemstring(ll_found,"tipo_via"))
				pbdom_via.AddContent(ls_tipo_via)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("nom_via")
				ls_nom_via = idst_dir_fiscal.getitemstring(ll_found,"nom_via"); if isnull(ls_nom_via) then ls_nom_via = ''
				pbdom_via.AddContent(ls_nom_via)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_postal")
				ls_cp_com = idst_dir_fiscal.getitemstring(ll_found,"cp"); if isnull(ls_cp_com) then ls_cp_com = ''
				pbdom_via.AddContent(ls_cp_com)
				pbdom_cuerpo.AddContent(pbdom_via)
				
		
				pbdom_via= create pbdom_element
				pbdom_via.SetName("poblacion")
				ls_poblacion= idst_dir_fiscal.getitemstring(ll_found,"poblaciones_descripcion"); if isnull(ls_poblacion) then ls_poblacion = ''
				pbdom_via.AddContent(ls_poblacion)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_municipio")
				ls_pob_mopu = idst_dir_fiscal.getitemstring(ll_found,"pob_mopu")
				if  ls_pob_mopu = '' or  isnull(ls_pob_mopu) then
						ls_municipio_com= '000'
				else
						ls_municipio_com=ls_pob_mopu
				end if						
				pbdom_via.AddContent(ls_municipio_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_provincia")
				ls_cod_prov_com = f_equivalencia_vu( 'VU_PROVINCIAS',idst_dir_fiscal.getitemstring(ll_found,"cod_prov"))
				pbdom_via.AddContent(ls_cod_prov_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("desc_provincia")
				ls_nombre_prov_com = f_nombre_provincias_vu(ls_cod_prov_com)
				pbdom_via.AddContent(ls_cod_prov_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_pais")
				ls_pais_com = idst_dir_fiscal.getitemstring(ll_found,"cod_iso"); if isnull(ls_pais_com) then ls_pais_com= '0'
				pbdom_via.AddContent(ls_pais_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
			end if	
		pbdom_sociedades.AddContent(pbdom_cuerpo)
		
			
		// Agregamos nodo de cod_forma_juridica
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cod_forma_juridica")
		pbdom_cuerpo.AddContent(ls_cod_forma_juridica)
		pbdom_sociedades.AddContent(pbdom_cuerpo)
			
		// Agregamos nodo de cod_reg_mercantil
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cod_reg_mercantil")
		pbdom_cuerpo.AddContent(ls_cod_reg_mercantil)
		pbdom_sociedades.AddContent(pbdom_cuerpo)	
		
		// Agregamos nodo de datos_acreditacion
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("datos_acreditacion")
		
		pbdom_via= create pbdom_element
		pbdom_via.SetName("login")
		pbdom_via.AddContent(ls_login)
		pbdom_cuerpo.AddContent(pbdom_via)
		
		pbdom_via= create pbdom_element
		pbdom_via.SetName("password")
		pbdom_via.AddContent(ls_password)
		pbdom_cuerpo.AddContent(pbdom_via)
		
		pbdom_via= create pbdom_element
		pbdom_via.SetName("num_fallos")
		string ls_fallos
		if not isnull(ll_n_fallos) then  
			ls_fallos =string(ll_n_fallos)
		else
			ls_fallos= string(0)
		end if
		pbdom_via.AddContent(ls_fallos)
		pbdom_cuerpo.AddContent(pbdom_via)
		pbdom_sociedades.AddContent(pbdom_cuerpo)	
		
		
		// Agregamos nodo de cod_entidad
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cod_entidad")
		pbdom_cuerpo.AddContent(ls_colegio)
		pbdom_sociedades.AddContent(pbdom_cuerpo)	
		
		// Agregamos nodo de telefono_1
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("telefono_1")
		pbdom_cuerpo.AddContent(ls_telefono)
		pbdom_sociedades.AddContent(pbdom_cuerpo)	
		// Agregamos nodo de telefono_2
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("telefono_2")
		pbdom_cuerpo.AddContent(ls_telefono2)
		pbdom_sociedades.AddContent(pbdom_cuerpo)	
		// Agregamos nodo de fax
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("fax")
		pbdom_cuerpo.AddContent(ls_fax)
		pbdom_sociedades.AddContent(pbdom_cuerpo)	
		// Agregamos nodo de email
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("email")
		pbdom_cuerpo.AddContent(ls_mail)
		pbdom_sociedades.AddContent(pbdom_cuerpo)	
		
		// Agregamos nodo de url
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("url")
		pbdom_cuerpo.AddContent(ls_web)
		pbdom_sociedades.AddContent(pbdom_cuerpo)	
			
		// Agregamos nodo de cesion_telef1
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cesion_telf1")
		pbdom_cuerpo.AddContent(ls_c_tfno_part)
		pbdom_sociedades.AddContent(pbdom_cuerpo)
		// Agregamos nodo de cesion_telef2
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cesion_telf2")
		pbdom_cuerpo.AddContent(ls_c_tfno_prof)
		pbdom_sociedades.AddContent(pbdom_cuerpo)
		// Agregamos nodo de cesion_fax
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cesion_fax")
		pbdom_cuerpo.AddContent(ls_c_fax)
		pbdom_sociedades.AddContent(pbdom_cuerpo)
		// Agregamos nodo de cesion_email
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cesion_email")
		pbdom_cuerpo.AddContent(ls_c_email)
		pbdom_sociedades.AddContent(pbdom_cuerpo)
		// Agregamos nodo de cesion_url
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cesion_url")
		pbdom_cuerpo.AddContent(ls_c_url)
		pbdom_sociedades.AddContent(pbdom_cuerpo)
		// ********** Termina nodo de cesion_datos
			
		
		// Agregamos nodo de multidisciplinar
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("multidisciplinar")
		if ls_multidisciplinar = 'N' then
				pbdom_cuerpo.AddContent('false')
		else
				pbdom_cuerpo.AddContent('true')
		end if
		
		pbdom_sociedades.AddContent(pbdom_cuerpo)	
		
		// Agregamos nodo de fecha_inscripcion_registro
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("fecha_inscripcion_registro")
		ls_fecha_insc = string(date(ldt_fecha_inscripcion),  "yyyy-mm-dd")
		if isnull(ls_fecha_insc) or  ls_fecha_insc = ''  then ls_fecha_insc = '0001-01-01'
		pbdom_cuerpo.AddContent(ls_fecha_insc)
		pbdom_sociedades.AddContent(pbdom_cuerpo)	
		
		// Agregamos nodo de fecha_baja
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("fecha_baja")
		ls_fecha_baja = string(date(ldt_fecha_baja), "yyyy-mm-dd")
		if isnull(ls_fecha_baja) or  ls_fecha_baja = '' then ls_fecha_baja = '0001-01-01'
		pbdom_cuerpo.AddContent(ls_fecha_baja)
		pbdom_sociedades.AddContent(pbdom_cuerpo)	
		
		
		// Agregamos nodo de observaciones
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("observaciones")
		pbdom_cuerpo.AddContent(ls_observaciones_regsoc)
		pbdom_sociedades.AddContent(pbdom_cuerpo)	
		
		// Agregamos nodo de objeto_social
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("objeto_social")
		pbdom_cuerpo.AddContent(ls_objeto_social)
		pbdom_sociedades.AddContent(pbdom_cuerpo)	
		
		// Agregamos nodo de cuenta_banco
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cuenta_banco")
		if cbx_cta_banco.checked = true then
			pbdom_cuerpo.AddContent(ls_cuenta_domic_regsoc)
		end if
		pbdom_sociedades.AddContent(pbdom_cuerpo)	
		
		
		
		// Agregamos nodo de lista_representantes
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("lista_representantes")
		
		
			if ldst_regsoc_socios.rowcount() > 0 then
				ls_condicion = "sociedades.representante = 'S' and  sociedades.id_col_soc ='"+ls_colegiado+"'"
				ldst_regsoc_socios.setfilter(ls_condicion)
				ldst_regsoc_socios.filter()
				ls_representantes = ''
			for ll = 1 to ldst_regsoc_socios.rowcount()
				if ldst_regsoc_socios.rowcount() > 0 then
					pbdom_rep_nodo= create pbdom_element
					pbdom_rep_nodo.SetName("Representante")
					ls_colegiado_rep = ldst_regsoc_socios.getitemstring(ll,"id_col_per")
					if isnull(ls_colegiado_rep) then 
						ls_colegiado_rep = ldst_regsoc_socios.getitemstring(ll,"id_cli_per")
						ls_nif_cliente = f_dame_nif(ls_colegiado_rep)
						if isnull(ls_nif_cliente) or ls_nif_cliente = '' then continue
						ls_tipo_documento= uo_nif.of_obtener_tipo_doc(ls_nif_cliente)
						choose case ls_tipo_documento
						case 'NIF'
							ls_nif_cliente =uo_nif.of_valida_nif(ls_nif_cliente)
						case 'NIE'
							ls_nif_cliente =uo_nif.of_valida_nie(ls_nif_cliente)
						case else
							if isnull(ls_nif_cliente) or ls_nif_cliente = '' then ls_nif_cliente=ls_colegio+'-'+ls_colegiado
						end choose
						ls_nombre_cliente =f_dame_cliente_nombre(ls_colegiado_rep)
						ls_apellido_cliente = f_dame_cliente_apellidos(ls_colegiado_rep)
					else
						ls_nif_cliente = f_devuelve_nif(ls_colegiado_rep)
						if isnull(ls_nif_cliente) or ls_nif_cliente = '' then continue
						ls_tipo_documento= uo_nif.of_obtener_tipo_doc(ls_nif_cliente)
						choose case ls_tipo_documento
						case 'NIF'
							ls_nif_cliente =uo_nif.of_valida_nif(ls_nif_cliente)
						case 'NIE'
							ls_nif_cliente =uo_nif.of_valida_nie(ls_nif_cliente)
						case else
							if isnull(ls_nif_cliente) or ls_nif_cliente = '' then ls_nif_cliente=ls_colegio+'-'+ls_colegiado
						end choose
						ls_nombre_cliente =f_colegiado_nombre(ls_colegiado_rep)
						ls_apellido_cliente = f_colegiado_apellidos(ls_colegiado_rep)
					end if
					pbd_representante = create pbdom_element
					if not isnull(ls_nif_cliente) then 
						pbd_representante.SetName("nif")
						pbd_representante.AddContent(ls_nif_cliente)
					end if
					pbdom_rep_nodo.AddContent (pbd_representante)
					rep_apellido = create pbdom_element
					if not isnull(ls_nif_cliente) then 
							rep_apellido.SetName("apellidos")
							rep_apellido.AddContent(ls_apellido_cliente)
					end if
					pbdom_rep_nodo.AddContent (rep_apellido)
							rep_nombre = create pbdom_element
					if not isnull(ls_nif_cliente) then 
							rep_nombre.SetName("nombre")
							rep_nombre.AddContent(ls_nombre_cliente)
					end if
					pbdom_rep_nodo.AddContent (rep_nombre)
					pbdom_cuerpo.AddContent(pbdom_rep_nodo)
	
				end if
				next 
				ldst_regsoc_socios.setfilter('')
				ldst_regsoc_socios.filter()
		end if
		
		pbdom_sociedades.AddContent(pbdom_cuerpo)		
	
		// Agregamos nodo de objeto_social
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("lista_socios")
		
			if ldst_regsoc_socios.rowcount() > 0 then
				ls_condicion = "sociedades.id_col_soc ='"+ls_colegiado+"'"
				ldst_regsoc_socios.setfilter(ls_condicion)
				ldst_regsoc_socios.filter()
				ls_representantes = ''
			for ll = 1 to ldst_regsoc_socios.rowcount()
				if ldst_regsoc_socios.rowcount() > 0 then
				pbdom_rep_nodo= create pbdom_element
				pbdom_rep_nodo.SetName("Socio")
				ls_colegiado_rep = ldst_regsoc_socios.getitemstring(ll,"id_col_per")
				if isnull(ls_colegiado_rep) then 
					ls_colegiado_rep = ldst_regsoc_socios.getitemstring(ll,"id_cli_per")
					ls_nif_cliente = f_dame_nif(ls_colegiado_rep)
					if isnull(ls_nif_cliente) or ls_nif_cliente = '' then continue
					ls_tipo_documento= uo_nif.of_obtener_tipo_doc(ls_nif_cliente)
					choose case ls_tipo_documento
					case 'NIF'
						ls_nif_cliente =uo_nif.of_valida_nif(ls_nif_cliente)
					case 'NIE'
						ls_nif_cliente =uo_nif.of_valida_nie(ls_nif_cliente)
					case else
						if isnull(ls_nif_cliente) or ls_nif_cliente = '' then ls_nif_cliente=ls_colegio+'-'+ls_colegiado
					end choose
					
					ls_nombre_cliente =f_dame_cliente_nombre(ls_colegiado_rep)
					ls_apellido_cliente = f_dame_cliente_apellidos(ls_colegiado_rep)
					
				else
					ls_nif_cliente = f_devuelve_nif(ls_colegiado_rep)
					if isnull(ls_nif_cliente) or ls_nif_cliente = '' then continue
					ls_tipo_documento= uo_nif.of_obtener_tipo_doc(ls_nif_cliente)
					choose case ls_tipo_documento
					case 'NIF'
						ls_nif_cliente =uo_nif.of_valida_nif(ls_nif_cliente)
					case 'NIE'
						ls_nif_cliente =uo_nif.of_valida_nie(ls_nif_cliente)
					case else
						if isnull(ls_nif_cliente) or ls_nif_cliente = '' then ls_nif_cliente=ls_colegio+'-'+ls_colegiado
					end choose
					ls_nombre_cliente =f_colegiado_nombre(ls_colegiado_rep)
					ls_apellido_cliente = f_colegiado_apellidos(ls_colegiado_rep)
				end if
				pbd_representante = create pbdom_element
				if not isnull(ls_nif_cliente) then 
					pbd_representante.SetName("nif")
					pbd_representante.AddContent(ls_nif_cliente)
				end if
				pbdom_rep_nodo.AddContent (pbd_representante)
				rep_apellido = create pbdom_element
				if not isnull(ls_nif_cliente) then 
					rep_apellido.SetName("apellidos")
					rep_apellido.AddContent(ls_apellido_cliente)
				end if
				pbdom_rep_nodo.AddContent (rep_apellido)
				rep_nombre = create pbdom_element
				if not isnull(ls_nif_cliente) then 
					rep_nombre.SetName("nombre")
					rep_nombre.AddContent(ls_nombre_cliente)
				end if
				pbdom_rep_nodo.AddContent (rep_nombre)
				pbdom_cuerpo.AddContent(pbdom_rep_nodo)
				end if
			next
			ldst_regsoc_socios.setfilter('')
				ldst_regsoc_socios.filter()
			end if
	
			pbdom_sociedades.AddContent(pbdom_cuerpo)
			
		// Agregamos nodo de lista_habilitaciones
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("lista_habilitaciones")
		if idst_inhabilitaciones.rowcount() >0 then 
			ls_condicion = "id_colegiado ='"+ls_colegiado+"'"
			idst_inhabilitaciones.setfilter(ls_condicion)
			idst_inhabilitaciones.filter()
			for ll = 1 to idst_inhabilitaciones.rowcount()
				ls_cod_origen		= idst_inhabilitaciones.getitemstring(ll,"cod_origen"); if isnull(ls_cod_origen) then continue 
				ls_descripcion 	 	= idst_inhabilitaciones.getitemstring(ll,"descripcion") ; if isnull(ls_descripcion) then ls_descripcion = ''
								
				pbdom_sub_nodo= create pbdom_element
				pbdom_sub_nodo.SetName("HabilitacionSociedad")
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("origen")
				pbdom_via.AddContent(ls_cod_origen)
				pbdom_sub_nodo.AddContent(pbdom_via)
				
				pbdom_via= create pbdom_element
				pbdom_via.SetName("ambito")
				pbdom_via.AddContent('')
				pbdom_sub_nodo.AddContent(pbdom_via)
				
				pbdom_via= create pbdom_element
				pbdom_via.SetName("observaciones")
				pbdom_via.AddContent(ls_descripcion)
				pbdom_sub_nodo.AddContent(pbdom_via)
				pbdom_cuerpo.AddContent(pbdom_sub_nodo)
			next
			idst_inhabilitaciones.setfilter('')
			idst_inhabilitaciones.filter()
			
		end if
		// ********** Termina nodo de lista_inhabilitaciones
		pbdom_sociedades.AddContent(pbdom_cuerpo)	
		
		// Agregamos nodo de datos_seguro
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("datos_seguro")
		if idst_musaat.rowcount() > 0 then
			ls_condicion = "id_col ='"+ls_colegiado+"'"
			idst_musaat.setfilter(ls_condicion)
			idst_musaat.filter()
			if idst_musaat.rowcount() > 0 then
				pbdom_via= create pbdom_element
				pbdom_via.SetName("companiaSRC")
				ls_src_compania =f_musaat_descripcion_companyia(idst_musaat.getitemstring(1,"src_cia"))
				if isnull(ls_src_compania) or ls_src_compania = '' then ls_src_compania= 'No tiene'
				pbdom_via.AddContent(ls_src_compania)
				pbdom_cuerpo.AddContent(pbdom_via)
				
	
				//case 'observaciones'
			else
					pbdom_via= create pbdom_element
					pbdom_via.SetName("companiaSRC")
					pbdom_via.AddContent('No tiene')
					pbdom_cuerpo.AddContent(pbdom_via)
			end if
			idst_musaat.setfilter('')
			idst_musaat.filter()
		else
			pbdom_via= create pbdom_element
			pbdom_via.SetName("companiaSRC")
			pbdom_via.AddContent('No tiene')
			pbdom_cuerpo.AddContent(pbdom_via)
			
		end if
		pbdom_sociedades.AddContent(pbdom_cuerpo)	
		
		
		pbdom_elem[1].AddContent(pbdom_sociedades)	
	
	next


//if ll_reg_soc > 0 then
//	string fichero
//	
////	fichero = "sociedades_"+g_colegio +"'.xml"
//	n_cst_filesrvwin32 cambia_directorio
//	string directorio,ruta
//	cambia_directorio = create n_cst_filesrvwin32
//	directorio = cambia_directorio.of_getcurrentdirectory()
//	
//		if GetFileSaveName('Seleccione nombre de fichero de sociedades',ruta,fichero,'.xml','Ficheros de datos (*.xml),*.xml')<> 1 Then 
//			Messagebox(g_titulo, "No se ha logrado crear el fichero de sociedades!!!")
//		else
//			if i_pbdom_doc.SaveDocument (fichero )  then 
//				Messagebox(g_titulo, 'Fichero de sociedades ' +fichero +' generado con exito!!')
//			else
//				Messagebox(g_titulo, 'Error al momento de generar el fichero')
//			end if
//			destroy cambia_directorio
//		end if
//	
//else
//	Messagebox(g_titulo, 'No se encuentras sociedades a procesar')
//end if
//end if
//
//catch (PBDOM_EXCEPTION pbdom_except)
//	Messagebox("Excepci$$HEX1$$f300$$ENDHEX$$n",pbdom_except.text )
//CATCH ( PBXRuntimeError re )
//MessageBox( "PBNI Exception", re.getMessage() )
//END TRY
//destroy pbdom_bldr
end subroutine

public subroutine wf_xml_colegiados (datastore ldst_colegiados);datastore   ldst_telefonos,  ldst_premaat
			
long          i, ll_n_fallos, j, k, ll_fila_new, m, ll_registros, ll_fila_representantes, ll_filas_socios, ll_fila_new_soc, ll_reg_soc
string        ls_colegiado, ls_nif, ls_nombre, ls_apellidos, ls_sexo, ls_cuenta_domic, ls_email, ls_colegio, ls_cons_procedencia, ls_situacion, ls_n_colegiado, &
			   ls_n_consejo, ls_alta_baja, ls_escuela_final, ls_url, ls_cod_tipo_idioma, ls_ejerciente, ls_observaciones, ls_login, ls_password, ls_incompatibilidad,&
			  ls_organismo, ls_descripcion, ls_src_alta, ls_src_cia, ls_n_mutualista, ls_src_n_poliza, ls_src_cober,  ls_telefono_1,ls_telefono_2, &
			  ls_telefono_3, ls_telefono_4, ls_telefono_5, ls_n_mutualista_premaat, ls_cif, ls_razon_social, ls_num_reg_mercantil, ls_cod_forma_juridica,ls_telefono,&
			  ls_fax, ls_mail, ls_web, ls_num_reg_colegio, ls_multidisciplinar, ls_cuenta_domic_regsoc, ls_objeto_social, ls_observaciones_regsoc, ls_nif_cliente,&
			  ls_nombre_cliente, ls_apellido_cliente, ls_representantes, ls_nif_socio, ls_nombre_socio, ls_apellido_socio, ls_socios, ls_tipo_via, ls_descrip_via, &
			  ls_nom_via, ls_cp, ls_poblacion, ls_cod_pob, ls_cod_prov, ls_nombre_prov, ls_pais, ls_nombre_pais, ls_municipio,ls_tipo_via_com, ls_descrip_via_com, &
			  ls_nom_via_com, ls_cp_com, ls_poblacion_com, ls_cod_pob_com, ls_cod_prov_com, ls_nombre_prov_com, ls_pais_com, ls_nombre_pais_com, ls_municipio_com,&
			  ls_pob_mopu, ls_descripcion_regsoc, ls_condicion, ls_cod_tipo_regimen, ls_primera_colegiacion, ls_src_compania,&
			  ls_tipo_documento, ls_cod_reg_mercantil, ruta_colegiado
			  
datetime   ldt_f_nacimiento, ldt_f_colegiacion, ldt_f_baja, ldt_f_titulacion, ldt_f_inicio, ldt_fecha_inscripcion, ldt_fecha_baja
double      ldb_src_coef_cm, ldb_src_cobertura
//Objeto que comprueba el tipo de documento
u_csd_nif uo_nif

//Retrieve de colegiados
//dw_colegiados.settransobject(sqlca)

	ll_registros = ldst_colegiados.rowcount()


	dw_datos.setredraw(false)
	for i = 1 to ll_registros

		st_1.text =  "Procesando........ " + string(i) + ' de ' + string(ll_registros) + ' Colegiados.'
		yield()
		
		ls_colegiado = ldst_colegiados.getitemstring(i,"id_colegiado")
		ls_colegio      = f_equivalencia_vu('VU_COLEGIOS', g_cod_colegio)
		//ls_colegio      = f_equivalencia_vu('VU_COLEGIOS',ldst_colegiados.getitemstring(i,"colegio"))
		
		
		//Datos del colegiado
		ls_tipo_documento = uo_nif.of_obtener_tipo_doc(ldst_colegiados.getitemstring(i,"nif"))
		if ls_tipo_documento = 'DESCONOCIDO' then ls_tipo_documento= 'PASS'
		choose case ls_tipo_documento
			case 'NIF'
				ls_nif =uo_nif.of_valida_nif(ldst_colegiados.getitemstring(i,"nif"))
			case 'NIE'
				ls_nif =uo_nif.of_valida_nie(ldst_colegiados.getitemstring(i,"nif"))
			case else
				ls_nif = ldst_colegiados.getitemstring(i,"nif")
				if isnull(ls_nif) or ls_nif = '' then ls_nif=ls_colegio+'-'+ls_colegiado
		end choose
		
		
		ls_nombre = ldst_colegiados.getitemstring(i,"nombre")
		ls_apellidos= ldst_colegiados.getitemstring(i,"apellidos")
		ldt_f_nacimiento = ldst_colegiados.getitemdatetime(i,"f_nacimiento")
		ls_sexo = ldst_colegiados.getitemstring(i,"sexo")
		if isnull(ls_sexo) then ls_sexo = 'H'
		ls_email = ldst_colegiados.getitemstring(i,"correo")
		if cbx_cta_banco.checked = true then
		ls_cuenta_domic = ldst_colegiados.getitemstring(i,"cuenta_domic")					
		end if	

		
		ls_cons_procedencia = ldst_colegiados.getitemstring(i,"cons_procedencia")
		ls_situacion =f_equivalencia_vu('VU_SITUACIONES_PROFESIONALES',ldst_colegiados.getitemstring(i,"situacion"))
		ldt_f_colegiacion = ldst_colegiados.getitemdatetime(i,"f_colegiacion")
		ls_n_colegiado  = ldst_colegiados.getitemstring(i,"n_colegiado")
		ls_n_consejo = ldst_colegiados.getitemstring(i,"n_consejo")
		ls_alta_baja = ldst_colegiados.getitemstring(i,"alta_baja")
		ldt_f_baja = ldst_colegiados.getitemdatetime(i,"f_baja")
		
		ls_escuela_final = ldst_colegiados.getitemstring(i,"cons_escuela_final")
		if len(ls_escuela_final)> 2 or (isnull(ls_escuela_final) or ls_escuela_final='') then ls_escuela_final='00'
		ldt_f_titulacion = ldst_colegiados.getitemdatetime(i,"f_titulacion")
		
		ls_primera_colegiacion = f_cod_colegio_procedencia(ldst_colegiados.getitemstring(i,"cons_procedencia"))
		if (len(ls_primera_colegiacion)> 2) or (isnull(ls_primera_colegiacion) or ls_primera_colegiacion='') then
			ls_primera_colegiacion = ls_colegio
		else
			ls_primera_colegiacion = f_equivalencia_vu('VU_COLEGIOS',ls_primera_colegiacion)
		end if
		
				
		ls_telefono_1 = ldst_colegiados.getitemstring(i,"telefono_1")
		ls_telefono_2 = ldst_colegiados.getitemstring(i,"telefono_2")
		ls_telefono_3 = ldst_colegiados.getitemstring(i,"telefono_3")
		ls_telefono_4 = ldst_colegiados.getitemstring(i,"telefono_4")
		ls_telefono_5 = ldst_colegiados.getitemstring(i,"telefono_5")
		
		// Se obtiene la cesion de datos
		
		ls_cod_tipo_regimen =  f_equivalencia_vu('VU_TIPO_REGIMEN',ldst_colegiados.getitemstring(i,"premaat_grupo"))
		ls_n_mutualista_premaat =  ldst_colegiados.getitemstring(i,"premaat_n_mutualista")
	
	
		if idst_otros_datos.rowcount() > 0 then
			ls_condicion = "id_colegiado ='"+ls_colegiado+"'"
			idst_otros_datos.setfilter(ls_condicion)
			idst_otros_datos.filter()
			
			if idst_otros_datos.rowcount() > 0 then
				ls_url = idst_otros_datos.getitemstring(1,"url")
				ls_cod_tipo_idioma = idst_otros_datos.getitemstring(1,"t_usuario_cod_tipo_idioma")
				ls_ejerciente =  idst_otros_datos.getitemstring(1,"ejerciente")
				ls_observaciones =  idst_otros_datos.getitemstring(1,"colegiados_observaciones")
				ls_login  =  idst_otros_datos.getitemstring(1,"t_usuario_login")
				ls_password  =  idst_otros_datos.getitemstring(1,"t_usuario_password")
				if not isnull(ls_password) then ls_password=lower(wf_pass_md5(ls_password))
				ll_n_fallos  =  idst_otros_datos.getitemnumber(1,"t_usuario_n_fallos")
				ls_incompatibilidad =  idst_otros_datos.getitemstring(1,"incompatibilidades_incompatibilidad")
				ldt_f_inicio =  idst_otros_datos.getitemdatetime(1,"incompatibilidades_fecha_inicio")
				ls_organismo =  idst_otros_datos.getitemstring(1,"incompatibilidades_organismo")
				ls_descripcion =  idst_otros_datos.getitemstring(1,"t_incompatibilidad_descripcion")
			end if
			idst_otros_datos.setfilter('')
			idst_otros_datos.filter()
		end if
	
		//Datos direcciones
		//Fiscal
		if idst_dir_fiscal.rowcount() > 0 then
			long ll_found

			ll_found = idst_dir_fiscal.Find(  "domicilios.profesional = 'S' and domicilios.id_colegiado='"+ls_colegiado+"'",  1, idst_dir_fiscal.RowCount())
			if ll_found <= 0 then 
					// Si no se consigue domicilio fiscal se busca el domicilio fiscal
				ll_found = idst_dir_fiscal.Find(  "domicilios.fiscal = 'S' and domicilios.id_colegiado='"+ls_colegiado+"'",  1, idst_dir_fiscal.RowCount())
			end if
			//ls_condicion = "id_colegiado ='"+ls_colegiado+"'"
//			idst_dir_fiscal.setfilter(ls_condicion)
//			idst_dir_fiscal.filter()
			if ll_found > 0 then 
			//if idst_dir_fiscal.rowcount() > 0 then
				ls_tipo_via =  f_equivalencia_vu('VU_TIPO_VIA',idst_dir_fiscal.getitemstring(ll_found,"tipo_via"))
				//if ls_tipo_via='SC' or isnull(ls_tipo_via) or ls_tipo_via= '' or ls_tipo_via='00' then ls_tipo_via='CL'
				ls_descrip_via = idst_dir_fiscal.getitemstring(ll_found,"tipos_via_descripcion")
				ls_nom_via = idst_dir_fiscal.getitemstring(ll_found,"nom_via")
				ls_cp = idst_dir_fiscal.getitemstring(ll_found,"cp")
				ls_poblacion = idst_dir_fiscal.getitemstring(ll_found,"poblaciones_descripcion")
				ls_cod_pob = idst_dir_fiscal.getitemstring(ll_found,"cod_pob")
				ls_pob_mopu = idst_dir_fiscal.getitemstring(ll_found,"pob_mopu")
				if  isnull(ls_pob_mopu)  or  ls_pob_mopu= '' then 
					ls_municipio= '000'
				else
					ls_municipio=ls_pob_mopu
				end if
				ls_cod_prov = f_equivalencia_vu( 'VU_PROVINCIAS', idst_dir_fiscal.getitemstring(ll_found,"cod_prov"))
				//ls_nombre_prov = idst_dir_fiscal.getitemstring(1,"provincias_nombre")
				ls_nombre_prov = f_nombre_provincias_vu(ls_cod_prov)
				ls_pais = idst_dir_fiscal.getitemstring(ll_found,"cod_iso")
				if isnull(ls_pais) then ls_pais= '00'
				ls_nombre_pais = idst_dir_fiscal.getitemstring(ll_found,"paises_nombre")
			end if
//			idst_dir_fiscal.setfilter("")
//			idst_dir_fiscal.filter()
		end if
	
		//Comercial
		if idst_dir_comercial.rowcount() > 0 then
			ls_condicion = "id_colegiado ='"+ls_colegiado+"'"
			idst_dir_comercial.setfilter(ls_condicion)
			idst_dir_comercial.filter()
			
			if idst_dir_comercial.rowcount() > 0 then
				ls_tipo_via_com =  f_equivalencia_vu('VU_TIPO_VIA',idst_dir_comercial.getitemstring(1,"tipo_via"))
	//			if ls_tipo_via_com='SC' or isnull(ls_tipo_via_com) or ls_tipo_via_com= '' or ls_tipo_via_com='00' then ls_tipo_via_com='CL'
				ls_descrip_via_com = idst_dir_comercial.getitemstring(1,"tipos_via_descripcion")
				ls_nom_via_com = idst_dir_comercial.getitemstring(1,"nom_via")
				ls_cp_com = idst_dir_comercial.getitemstring(1,"cp")
				ls_poblacion_com = idst_dir_comercial.getitemstring(1,"poblaciones_descripcion")
				ls_cod_pob_com = idst_dir_comercial.getitemstring(1,"cod_pob")
				ls_pob_mopu = idst_dir_comercial.getitemstring(1,"poblaciones_pob_mopu")
				if isnull(ls_pob_mopu) or ls_pob_mopu = '' then 
					ls_municipio_com= '000'
				else
					ls_municipio_com=ls_pob_mopu
				end if
				
				ls_cod_prov_com = f_equivalencia_vu( 'VU_PROVINCIAS',idst_dir_comercial.getitemstring(1,"cod_prov"))
				ls_nombre_prov_com = f_nombre_provincias_vu(ls_cod_prov_com)
				ls_pais_com = idst_dir_comercial.getitemstring(1,"cod_iso")
				if isnull(ls_pais_com) then ls_pais_com= '00'
				ls_nombre_pais_com = idst_dir_comercial.getitemstring(1,"paises_nombre")		
			end if
			idst_dir_comercial.setfilter('')
			idst_dir_comercial.filter()
		end if
	
	

		//datos seguro
		//if idst_musaat.rowcount() > 0 then
			ls_condicion = "id_col ='"+ls_colegiado+"'"
			idst_musaat.setfilter(ls_condicion)
			idst_musaat.filter()
			
			if idst_musaat.rowcount() > 0 then
				ls_src_alta = idst_musaat.getitemstring(1,"src_alta")
				ls_src_cia =  f_equivalencia_vu('VU_SRC_CIA',idst_musaat.getitemstring(1,"src_alta"))
				ls_src_compania =f_musaat_descripcion_companyia(idst_musaat.getitemstring(1,"src_cia"))
				ls_n_mutualista =  idst_musaat.getitemstring(1,"n_mutualista")
				ls_src_n_poliza =  idst_musaat.getitemstring(1,"src_n_poliza")
				ls_src_cober =  idst_musaat.getitemstring(1,"src_cober")
				ldb_src_cobertura =f_colegiado_src_cober_desc(ls_colegiado )
				ldb_src_coef_cm =  idst_musaat.getitemnumber(1,"src_coef_cm")
			else
				ls_src_alta = ''
				ls_src_cia =  ''
				ls_src_compania = ''
				ls_n_mutualista =  ''
				ls_src_n_poliza =  ''
				ls_src_cober =  ''
				ldb_src_cobertura = 0
				ldb_src_coef_cm = 0
			end if
			idst_musaat.setfilter('')
			idst_musaat.filter()
		//end if
	

	
		//SE INGRESAN TANTAS FILAS EN EL EXTERNAL COMO REGISTROS DE COLEGIADOS EXISTAN
		ll_fila_new = dw_datos.insertrow(0)
		
		dw_datos.setitem(ll_fila_new,"tipo_documento",ls_tipo_documento)
		dw_datos.setitem(ll_fila_new,"nif",ls_nif)
		dw_datos.setitem(ll_fila_new,"apellidos",ls_apellidos)
		dw_datos.setitem(ll_fila_new,"nombre",ls_nombre)
		dw_datos.setitem(ll_fila_new,"f_nacimiento",ldt_f_nacimiento)
		dw_datos.setitem(ll_fila_new,"sexo",ls_sexo)
		
		dw_datos.setitem(ll_fila_new,"tipo_via_fiscal",ls_tipo_via)
		dw_datos.setitem(ll_fila_new,"descripcion_dir_fiscal",ls_descrip_via)
		dw_datos.setitem(ll_fila_new,"nom_via_fiscal",ls_nom_via)
		dw_datos.setitem(ll_fila_new,"cp_fiscal",ls_cp)
		dw_datos.setitem(ll_fila_new,"poblacion_fiscal",ls_poblacion)
		dw_datos.setitem(ll_fila_new,"municipio_fiscal",ls_municipio)
		dw_datos.setitem(ll_fila_new,"cod_prov_fiscal",ls_cod_prov)
		dw_datos.setitem(ll_fila_new,"desc_prov_fiscal",ls_nombre_prov)
		dw_datos.setitem(ll_fila_new,"pais_fiscal",ls_pais)
		dw_datos.setitem(ll_fila_new,"nombre_pais_fiscal",ls_nombre_pais)
		
		dw_datos.setitem(ll_fila_new,"tipo_via_comercial",ls_tipo_via_com)
		dw_datos.setitem(ll_fila_new,"descripcion_dir_comercial",ls_descrip_via_com)
		dw_datos.setitem(ll_fila_new,"nom_via_comercial",ls_nom_via_com)
		dw_datos.setitem(ll_fila_new,"cp_comercial",ls_cp_com)
		dw_datos.setitem(ll_fila_new,"poblacion_comercial",ls_poblacion_com)
		dw_datos.setitem(ll_fila_new,"municipio_comercial",ls_municipio_com)
		dw_datos.setitem(ll_fila_new,"cod_prov_comercial",ls_cod_prov_com)
		dw_datos.setitem(ll_fila_new,"desc_prov_comercial",ls_nombre_prov_com)
		dw_datos.setitem(ll_fila_new,"pais_comercial",ls_pais_com)
		dw_datos.setitem(ll_fila_new,"nombre_pais_comercial",ls_nombre_pais_com)
		
		dw_datos.setitem(ll_fila_new,"telefono_1",ls_telefono_1)
		dw_datos.setitem(ll_fila_new,"telefono_2",ls_telefono_2)
		dw_datos.setitem(ll_fila_new,"telefono_3",ls_telefono_3)
		dw_datos.setitem(ll_fila_new,"telefono_4",ls_telefono_4)
		dw_datos.setitem(ll_fila_new,"telefono_5",ls_telefono_5)
		
		dw_datos.setitem(ll_fila_new,"correo",ls_email)
		dw_datos.setitem(ll_fila_new,"url",ls_url)
		dw_datos.setitem(ll_fila_new,"cuenta_domic",ls_cuenta_domic)
		dw_datos.setitem(ll_fila_new,"colegio",ls_colegio)
		dw_datos.setitem(ll_fila_new,"cod_colegio_primera_colegiacion",ls_primera_colegiacion)
		
	//	dw_datos.setitem(ll_fila_new,"cons_procedencia",ls_cons_procedencia)
		dw_datos.setitem(ll_fila_new,"f_colegiacion",ldt_f_colegiacion)
		dw_datos.setitem(ll_fila_new,"situacion",ls_situacion)
		dw_datos.setitem(ll_fila_new,"n_colegiado",ls_n_colegiado)
		dw_datos.setitem(ll_fila_new,"n_consejo",ls_n_consejo)
		dw_datos.setitem(ll_fila_new,"alta_baja",ls_alta_baja)
		dw_datos.setitem(ll_fila_new,"f_baja",date(ldt_f_baja))
		dw_datos.setitem(ll_fila_new,"ejerciente",ls_ejerciente)
		dw_datos.setitem(ll_fila_new,"cod_tipo_idioma",ls_cod_tipo_idioma)
		dw_datos.setitem(ll_fila_new,"observaciones",ls_observaciones)
		dw_datos.setitem(ll_fila_new,"login",ls_login)
		dw_datos.setitem(ll_fila_new,"password",ls_password)
		dw_datos.setitem(ll_fila_new,"n_fallos",ll_n_fallos)
		dw_datos.setitem(ll_fila_new,"cons_escuela_final",ls_escuela_final)
		dw_datos.setitem(ll_fila_new,"f_titulacion",ldt_f_titulacion)
		dw_datos.setitem(ll_fila_new,"incompatibilidad",ls_incompatibilidad)
		dw_datos.setitem(ll_fila_new,"fecha_inicio",ldt_f_inicio)
		dw_datos.setitem(ll_fila_new,"organismo",ls_organismo)
		dw_datos.setitem(ll_fila_new,"descripcion",ls_descripcion)
		dw_datos.setitem(ll_fila_new,"cesion_email",ls_email)
		dw_datos.setitem(ll_fila_new,"cesion_url",ls_url)
		dw_datos.setitem(ll_fila_new,"src_alta",ls_src_alta)
		dw_datos.setitem(ll_fila_new,"src_compania",ls_src_compania)
		
		dw_datos.setitem(ll_fila_new,"src_cia",ls_src_cia)
		dw_datos.setitem(ll_fila_new,"n_mutualista",ls_n_mutualista)
		dw_datos.setitem(ll_fila_new,"src_n_poliza",ls_src_n_poliza)
		dw_datos.setitem(ll_fila_new,"src_cober",ls_src_cober)
		dw_datos.setitem(ll_fila_new,"cobertura_col",ldb_src_cobertura)
		dw_datos.setitem(ll_fila_new,"src_coef_cm",ldb_src_coef_cm)
		
		if not isnull(ls_cod_tipo_regimen) then
			dw_datos.setitem(ll_fila_new,"cod_tipo_regimen",ls_cod_tipo_regimen)
			dw_datos.setitem(ll_fila_new,"n_mutualista_premaat",ls_n_mutualista_premaat)
		end if
		
	next
//	if ll_registros>0 then
//	
//		dw_datos.Modify("DataWindow.Export.XML.IncludeWhitespace = 'Yes' ")
//		dw_datos.Object.DataWindow.Export.XML.HeadGroups = "Yes"
//		dw_datos.Object.DataWindow.Export.XML.MetaDataType = XMLNone!
//		//Se pasa el template del xml
//		dw_datos.Modify("DataWindow.Export.XML.UseTemplate = 'fichero_intercambio_colegiados_delenode'")
//		dw_datos.Modify("DataWindow.Export.XML.MetaDataType = 0")
//		dw_datos.Modify("DataWindow.Export.XML.SaveMetaData = 1")
//		
//		
//		n_cst_filesrvwin32 cambia_directorio
//		string directorio,ruta, fichero
//		
//		cambia_directorio = create n_cst_filesrvwin32
//		directorio = cambia_directorio.of_getcurrentdirectory()
//		if GetFileSaveName('Seleccione nombre de fichero de colegiados',ruta,fichero,'.xml','Ficheros de datos (*.xml),*.xml')<> 1 Then 
//			Messagebox(g_titulo, "No se ha logrado generar el fichero de colegiados!!!")
//		else
//			if dw_datos.SaveAs(fichero,XML!,true)= 1 then
//				if g_colegio <> 'COAATCU' then ruta_colegiado = wf_trasnforma_xml(ruta)
//				if ruta_colegiado<> 'N' then 
//					Messagebox(g_titulo, "Fichero de colegiados generado con $$HEX1$$e900$$ENDHEX$$xito!!!")
//				else
//					Messagebox(g_titulo, "No se ha logrado generar el fichero de colegiados!!!")
//				end if
//			else
//				Messagebox(g_titulo, "No se ha logrado generar el fichero de colegiados!!!")
//			end if
//			destroy cambia_directorio
//		end if
//	end if
//	
//end if






//destroy ldst_colegiados

//destroy ldst_telefonos







end subroutine

public subroutine wf_pbdom_colegiado ();datastore ldst_dir_fiscal

PBDOM_Document    	pbdom_doc
PBDOM_Object      		l_lista_sociedades[], l_fichero_intercambio[], l_sociedad[], l_direccion_com[], l_sub_nodo[]
PBDOM_Object			l_datos_acreditacion[], l_lista_representantes[], l_representante[], l_socio[], l_direccion_fis[]
PBDOM_Element     	pbdom_elem[], pbdom_sub_elem[], l_sub_elem_representante[], pbd_representante, rep_nombre, rep_apellido
PBDOM_Element		pbdom_rep_nodo, pbdom_sub_nodo,	pbdom_via
PBDOM_Element		pbdom_nodo, pbdom_persona, pbdom_colegiados, pbdom_cuerpo
//pbdom_document i_pbdom_doc
pbdom_document doc
boolean	 bb_bool
long          i, ll_registros, ll_found, ll_n_fallos, ll
string        ls_colegiado, ls_colegio, ls_tipo_documento, ls_nif, ls_nombre, ls_apellidos, ls_sexo, ls_fecha, &
			 ls_tipo_via_com, ls_nom_via_com, ls_cp_com, ls_poblacion_com, ls_pob_mopu, ls_municipio_com, &
			 ls_cod_prov_com, ls_nombre_prov_com, ls_pais_com, ls_tipo_via, ls_nom_via, ls_poblacion, ls_condicion, &
			 ls_cod_pob_com, ls_nombre_pais_com, ls_telefono_1, ls_telefono_2, ls_telefono_3, ls_telefono_4, ls_telefono_5, &
			 ls_email, ls_url, ls_cuenta_domic, ls_cons_procedencia, ls_n_colegiado, ls_alta_baja, ls_escuela_final, ls_primera_colegiacion, &
			 ls_situacion, ls_ejerciente, ls_login, ls_password, ls_src_alta, ls_src_cia, ls_src_compania, ls_n_mutualista, ls_src_n_poliza, ls_src_cober, &
			 ls_cod_tipo_regimen, ls_n_mutualista_premaat, ls_c_tfno_part, ls_c_tfno_prof, ls_c_movil_1, ls_c_movil_2, ls_c_fax, &
			 ls_c_email, ls_c_url,ls_publicidad, ls_titulacion, ls_anyo_terminacion, ls_descripcion, ls_organismo, ls_temp,&
			 ls_cod_origen, ls_tipo, ls_src_otras_cias
			 
datetime   ldt_f_nacimiento, ldt_f_colegiacion, ldt_f_baja, ldt_f_titulacion, ldt_f_inicio, ldt_f_fin
double      ldb_src_cobertura
decimal	 ldb_src_coef_cm

//Objeto que comprueba el tipo de documento
u_csd_nif uo_nif

ll_registros = idst_colegiados.rowcount()

for i = 1 to ll_registros
	
	st_1.text =  "Procesando........ " + string(i) + ' de ' + string(ll_registros) + ' Colegiados.'
	yield()
		
	ls_colegiado 		= idst_colegiados.getitemstring(i,"id_colegiado")
	ls_colegio      		= f_equivalencia_vu('VU_COLEGIOS', g_cod_colegio)
		
	//Datos del colegiado
	ls_tipo_documento = uo_nif.of_obtener_tipo_doc(idst_colegiados.getitemstring(i,"nif"))
	if ls_tipo_documento = 'DESCONOCIDO' then ls_tipo_documento= 'PASS'
	choose case ls_tipo_documento
		case 'NIF'
			ls_nif =uo_nif.of_valida_nif(idst_colegiados.getitemstring(i,"nif"))
		case 'NIE'
			ls_nif =uo_nif.of_valida_nie(idst_colegiados.getitemstring(i,"nif"))
		case else
			ls_nif = idst_colegiados.getitemstring(i,"nif")
			if isnull(ls_nif) or ls_nif = '' then ls_nif=ls_colegio+'-'+ls_colegiado
	end choose
	ls_nombre 			= idst_colegiados.getitemstring(i,"nombre"); if isnull(ls_nombre) then ls_nombre= ''
	ls_apellidos			= idst_colegiados.getitemstring(i,"apellidos"); if isnull(ls_apellidos) then ls_apellidos= ''
	ldt_f_nacimiento 	= idst_colegiados.getitemdatetime(i,"f_nacimiento")
	ls_sexo 				= idst_colegiados.getitemstring(i,"sexo");	if isnull(ls_sexo) then ls_sexo = 'H'
	//Datos direcciones Fiscal
	if idst_dir_fiscal.rowcount() > 0 then
		ll_found = idst_dir_fiscal.Find(  "domicilios.profesional = 'S' and domicilios.id_colegiado='"+ls_colegiado+"'",  1, idst_dir_fiscal.RowCount())
		if ll_found <= 0 then 
		// Si no se consigue domicilio fiscal se busca el domicilio fiscal
			ll_found = idst_dir_fiscal.Find(  "domicilios.fiscal = 'S' and domicilios.id_colegiado='"+ls_colegiado+"'",  1, idst_dir_fiscal.RowCount())
		end if
	end if
	//Comercial
	if idst_dir_comercial.rowcount() > 0 then
		ls_condicion = "id_colegiado ='"+ls_colegiado+"'"
		idst_dir_comercial.setfilter(ls_condicion)
		idst_dir_comercial.filter()
		ls_cod_pob_com = idst_dir_comercial.getitemstring(1,"cod_pob")
		ls_nombre_pais_com = idst_dir_comercial.getitemstring(1,"paises_nombre")		
	end if
	ls_telefono_1 	= idst_colegiados.getitemstring(i,"telefono_1");	if isnull(ls_telefono_1) then ls_telefono_1= '' 
	ls_telefono_2 	= idst_colegiados.getitemstring(i,"telefono_2");	if isnull(ls_telefono_2) then ls_telefono_2= ''
	ls_telefono_3	= idst_colegiados.getitemstring(i,"telefono_3");	if isnull(ls_telefono_3) then ls_telefono_3= ''
	ls_telefono_4 	= idst_colegiados.getitemstring(i,"telefono_4");	if isnull(ls_telefono_4) then ls_telefono_4= ''
	ls_telefono_5 	= idst_colegiados.getitemstring(i,"telefono_5");	if isnull(ls_telefono_5) then ls_telefono_5= ''
	ls_publicidad	= idst_colegiados.getitemstring(i,"publicidad");	
	ls_email 		 	= idst_colegiados.getitemstring(i,"correo_electronico"); if isnull(ls_email) then ls_email= ''
	ls_c_tfno_part	= idst_colegiados.getitemstring(i,"c_telefono_part")	
	ls_c_tfno_prof	= idst_colegiados.getitemstring(i,"c_telefono_prof")	
	ls_c_movil_1	= idst_colegiados.getitemstring(i,"c_movil_1")	
	ls_c_movil_2	= idst_colegiados.getitemstring(i,"c_movil_2")	
	ls_c_fax			= idst_colegiados.getitemstring(i,"c_fax")	
	ls_c_email		= idst_colegiados.getitemstring(i,"c_email")	
	ls_c_url			= idst_colegiados.getitemstring(i,"c_url")	
	if isnull(ls_c_tfno_part) or ls_c_tfno_part = 'N' then
		ls_c_tfno_part= 'false' 
	else
		ls_c_tfno_part= 'true' 
	end if
		if isnull(ls_c_tfno_prof) or ls_c_tfno_prof = 'N' then
		ls_c_tfno_prof= 'false' 
	else
		ls_c_tfno_prof= 'true' 
	end if
	if isnull(ls_c_movil_1) or ls_c_movil_1 = 'N' then
		ls_c_movil_1= 'false' 
	else
		ls_c_movil_1= 'true' 
	end if
	if isnull(ls_c_movil_2) or ls_c_movil_2 = 'N' then
		ls_c_movil_2= 'false' 
	else
		ls_c_movil_2= 'true' 
	end if
	if isnull(ls_c_fax) or ls_c_fax = 'N' then
		ls_c_fax= 'false' 
	else
		ls_c_fax= 'true' 
	end if
	if isnull(ls_c_email) or ls_c_email = 'N' then
		ls_c_email= 'false' 
	else
		ls_c_email= 'true' 
	end if
	if isnull(ls_c_url) or ls_c_url = 'N' then
		ls_c_url= 'false' 
	else
		ls_c_url= 'true' 
	end if
	if isnull(ls_publicidad) or ls_publicidad = 'N' then
		ls_publicidad= 'false' 
	else
		ls_publicidad= 'true' 
	end if
	if cbx_cta_banco.checked = true then
		ls_cuenta_domic = idst_colegiados.getitemstring(i,"cuenta_domic")		
		if isnull(ls_cuenta_domic) then ls_cuenta_domic= ''
	else
		ls_cuenta_domic = ' '
	end if	
	ls_ejerciente =  idst_colegiados.getitemstring(i,"ejerciente")
	if isnull(ls_ejerciente) or  ls_ejerciente= 'N'  then 
			ls_ejerciente= 'false'
	else
			ls_ejerciente = 'true'
	end if
	
	if idst_otros_datos.rowcount() > 0 then
			ls_condicion = "id_colegiado ='"+ls_colegiado+"'"
			idst_otros_datos.setfilter(ls_condicion)
			idst_otros_datos.filter()
			
			if idst_otros_datos.rowcount() > 0 then
				ls_url = idst_otros_datos.getitemstring(1,"url")
				if isnull(ls_url) then ls_url= ''
//				ls_cod_tipo_idioma = idst_otros_datos.getitemstring(1,"t_usuario_cod_tipo_idioma")
//				ls_ejerciente =  idst_otros_datos.getitemstring(1,"ejerciente")
//				if isnull(ls_ejerciente) or  ls_ejerciente= 'N'  then 
//					ls_ejerciente= 'false'
//				else
//					ls_ejerciente = 'true'
//				end if
				ls_login  =  idst_otros_datos.getitemstring(1,"t_usuario_login")
				if isnull(ls_login) then ls_login= ''
				ls_password  =  idst_otros_datos.getitemstring(1,"t_usuario_password")
				if not isnull(ls_password) then 
					ls_password=lower(wf_pass_md5(ls_password))
				else
					ls_password = ''
				end if
				ll_n_fallos  =  idst_otros_datos.getitemnumber(1,"t_usuario_n_fallos")
			else
				ls_url= '';  ls_login= ''; ls_password = ''
			end if
			idst_otros_datos.setfilter('')
			idst_otros_datos.filter()
		else
			ls_url= ''; ls_login= ''; ls_password = ''
		end if
		
		ls_cons_procedencia 	= idst_colegiados.getitemstring(i,"cons_procedencia");	if isnull(ls_cons_procedencia) then ls_cons_procedencia= ''
		ls_situacion 				= f_equivalencia_vu('VU_SITUACIONES_PROFESIONALES',idst_colegiados.getitemstring(i,"situacion")); if isnull(ls_situacion) then ls_situacion = 'OT'
		ldt_f_colegiacion 		= idst_colegiados.getitemdatetime(i,"f_colegiacion")
		ls_n_colegiado  		= idst_colegiados.getitemstring(i,"n_colegiado"); if isnull(ls_n_colegiado) then ls_n_colegiado= ''
		ls_alta_baja 			= idst_colegiados.getitemstring(i,"alta_baja")
		///* Alexis. SCP-446. 12/07/2010. Modificado porque no miraba directamente si estaba de baja el colegiado *///
		if ls_alta_baja = 'N' or isnull(ls_alta_baja) or  ls_ejerciente= 'false'  then 
			ls_alta_baja= 'false'
		else
			ls_alta_baja = 'true'
		end if
		ldt_f_baja 				= idst_colegiados.getitemdatetime(i,"f_baja")
		ldt_f_titulacion 			= idst_colegiados.getitemdatetime(i,"f_titulacion")
		ls_primera_colegiacion = f_cod_colegio_procedencia(idst_colegiados.getitemstring(i,"cons_procedencia"))
		if (len(ls_primera_colegiacion)> 2) or (isnull(ls_primera_colegiacion) or ls_primera_colegiacion='') then
			ls_primera_colegiacion = ls_colegio
		else
			ls_primera_colegiacion = f_equivalencia_vu('VU_COLEGIOS',ls_primera_colegiacion)
			if isnull(ls_primera_colegiacion) then ls_primera_colegiacion=ls_colegio
		end if
	
		
	//datos seguro
		if idst_musaat.rowcount() > 0 then
			ls_condicion = "id_col ='"+ls_colegiado+"'"
			idst_musaat.setfilter(ls_condicion)
			idst_musaat.filter()
			
			if idst_musaat.rowcount() > 0 then //and idst_musaat.getitemstring(1,"src_alta") <> 'N' then
				ls_src_alta 			=  idst_musaat.getitemstring(1,"src_alta");	if isnull(ls_src_alta) then ls_src_alta= 'N'
				if (ls_src_alta = 'S') then 
					ls_src_cia 			=  f_equivalencia_vu('VU_SRC_CIA',idst_musaat.getitemstring(1,"src_alta"));	if isnull(ls_src_cia) then ls_src_cia=''
					ls_src_compania 	=  f_musaat_descripcion_companyia(idst_musaat.getitemstring(1,"src_cia"));	if isnull(ls_src_compania) then ls_src_compania='N'
					ls_n_mutualista 	=  idst_musaat.getitemstring(1,"n_mutualista");	if isnull(ls_n_mutualista) then ls_n_mutualista=''
					ls_src_n_poliza 	=  idst_musaat.getitemstring(1,"src_n_poliza");	if isnull(ls_src_n_poliza) then ls_src_n_poliza=''
					ls_src_cober 		=  idst_musaat.getitemstring(1,"src_cober");	if isnull(ls_src_cober) then ls_src_cober=''
					ldb_src_cobertura 	=  f_colegiado_src_cober_desc(ls_colegiado )
					ldb_src_coef_cm 	=  idst_musaat.getitemnumber(1,"src_coef_cm")
				else 
					ls_condicion = "id_colegiado ='"+ls_colegiado+"'"
					isdt_otros_src.setfilter(ls_condicion)
					isdt_otros_src.filter()
					if (isdt_otros_src.rowcount() > 0) then
						ls_src_otras_cias = isdt_otros_src.getitemstring(1,"alta")
						
						if (ls_src_otras_cias = 'S') then 
							ls_src_cia = f_equivalencia_vu('VU_SRC_CIA', 'O'); if isnull(ls_src_cia) then ls_src_cia=''
							ls_src_compania =  f_musaat_descripcion_companyia(isdt_otros_src.getitemstring(1,"src_cia"));	if isnull(ls_src_compania) then ls_src_compania='N'
							ls_n_mutualista =  idst_musaat.getitemstring(1,"n_mutualista");	if isnull(ls_n_mutualista) then ls_n_mutualista='' // Se sigue cogiendo de los datos del idst_musaat
							ls_src_n_poliza = isdt_otros_src.getitemstring(1,"numero_poliza");	if isnull(ls_src_n_poliza) then ls_src_n_poliza=''
							
							ls_src_cober = isdt_otros_src.getitemstring(1,"src_cober")
							if not f_es_vacio(ls_src_cober)  and isNumber(ls_src_cober) then 
								 ldb_src_cobertura =  double(ls_src_cober)
							else
								ldb_src_cobertura 	= 0
							end if 								
							
							setnull(ldb_src_coef_cm)  
						else
							ls_src_alta = 'N'; ls_src_cia='N'; ls_src_compania=''; ls_n_mutualista=''; ls_src_n_poliza='';ls_src_cober=''; setnull(ldb_src_cobertura); setnull(ldb_src_coef_cm) 
						end if
					else
						ls_src_alta = 'N'; ls_src_cia='N'; ls_src_compania=''; ls_n_mutualista=''; ls_src_n_poliza='';ls_src_cober=''; setnull(ldb_src_cobertura); setnull(ldb_src_coef_cm) 	
					end if	
				end if
			end if
			idst_musaat.setfilter('')
			idst_musaat.filter()
		else
			ls_src_alta = 'N'; ls_src_cia='N'; ls_src_compania=''; ls_n_mutualista=''; ls_src_n_poliza='';ls_src_cober=''; setnull(ldb_src_cobertura); setnull(ldb_src_coef_cm) 
		end if			
		
	//datos premaat
	// /*CBI-164. Se a$$HEX1$$f100$$ENDHEX$$ade comprobaci$$HEX1$$f300$$ENDHEX$$n para ver si el colegiado esta de alta, de no ser as$$HEX1$$ed00$$ENDHEX$$, no recoger$$HEX2$$e1002000$$ENDHEX$$datos. Alexis. 25/06/2010 */ //
	if idst_colegiados.getitemstring(i,"premaat_alta") = 'S' then
		ls_cod_tipo_regimen 		=  f_equivalencia_vu('VU_TIPO_REGIMEN',idst_colegiados.getitemstring(i,"premaat_grupo"));	if isnull(ls_cod_tipo_regimen) then ls_cod_tipo_regimen= '0000'
		ls_n_mutualista_premaat =  idst_colegiados.getitemstring(i,"premaat_n_mutualista");	if isnull(ls_n_mutualista_premaat) then ls_n_mutualista_premaat= ''
	else
		ls_cod_tipo_regimen= '0000'
		ls_n_mutualista_premaat= ''
	end if	
	// /* Fin cambios CBI-164*/ //
	
	bb_bool = i_pbdom_doc.getelementsbytagname('lista_colegiados', pbdom_elem)
	
	pbdom_colegiados = create pbdom_element
	pbdom_colegiados.SetName("Colegiado")	
		// Agregamos el nodo Persona
		pbdom_persona= create pbdom_element
		pbdom_persona.SetName("persona")	
		// Agregamos nodo de tipo_documento
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("tipo_documento")
		pbdom_cuerpo.AddContent(ls_tipo_documento)
		pbdom_persona.AddContent(pbdom_cuerpo)
		// Agregamos nodo de nif
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("nif")
		pbdom_cuerpo.AddContent(ls_nif)
		pbdom_persona.AddContent(pbdom_cuerpo)
		// Agregamos nodo de apellidos
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("apellidos")
		pbdom_cuerpo.AddContent(ls_apellidos)
		pbdom_persona.AddContent(pbdom_cuerpo)
		// Agregamos nodo de nombre
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("nombre")
		pbdom_cuerpo.AddContent(ls_nombre)
		pbdom_persona.AddContent(pbdom_cuerpo)
		// Agregamos nodo de f_nacimiento
		pbdom_cuerpo= create pbdom_element
		ls_fecha = string(date(ldt_f_nacimiento),  "yyyy-mm-dd")
		if isnull(ls_fecha) or  ls_fecha = ''  then ls_fecha = '0001-01-01'
		pbdom_cuerpo.SetName("f_nacimiento")
		pbdom_cuerpo.AddContent(ls_fecha)
		pbdom_persona.AddContent(pbdom_cuerpo)
		// lugar_nacimiento, cod_provincia_nacimiento, desc_provincia_nacimiento
		// Agregamos nodo de sexo
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cod_sexo")
		pbdom_cuerpo.AddContent(ls_sexo)
		pbdom_persona.AddContent(pbdom_cuerpo)
		// Agregamos nodo de direccion_correspondencia
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("direccion_correspondencia")
		if idst_dir_comercial.rowcount()>0 then
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_tipo_via")
				ls_tipo_via_com =f_equivalencia_vu('VU_TIPO_VIA',idst_dir_fiscal.getitemstring(1,"tipo_via"))
				pbdom_via.AddContent(ls_tipo_via_com)
				pbdom_cuerpo.AddContent(pbdom_via)
	
				pbdom_via= create pbdom_element
				pbdom_via.SetName("nom_via")
				ls_nom_via_com = idst_dir_comercial.getitemstring(1,"nom_via"); if isnull(ls_nom_via_com) then ls_nom_via_com = ''
				pbdom_via.AddContent(ls_nom_via_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_postal")
				ls_cp_com = idst_dir_comercial.getitemstring(1,"cp"); if isnull(ls_cp_com) then ls_cp_com = '0000'
				pbdom_via.AddContent(ls_cp_com)
				pbdom_cuerpo.AddContent(pbdom_via)
	
				pbdom_via= create pbdom_element
				pbdom_via.SetName("poblacion")
				ls_poblacion_com= idst_dir_comercial.getitemstring(1,"poblaciones_descripcion"); if isnull(ls_poblacion_com) then ls_poblacion_com = ''
				pbdom_via.AddContent(ls_poblacion_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_municipio")
				ls_pob_mopu = idst_dir_comercial.getitemstring(1,"poblaciones_pob_mopu")
				if  ls_pob_mopu = '' or isnull(ls_pob_mopu) then
						ls_municipio_com= '000'
				else
						ls_municipio_com=ls_pob_mopu
				end if						
				pbdom_via.AddContent(ls_municipio_com)
				pbdom_cuerpo.AddContent(pbdom_via)
				
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_provincia")
				ls_cod_prov_com = f_equivalencia_vu( 'VU_PROVINCIAS',idst_dir_comercial.getitemstring(1,"cod_prov"))
				pbdom_via.AddContent(ls_cod_prov_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("desc_provincia")
				ls_nombre_prov_com = f_nombre_provincias_vu(ls_cod_prov_com)
				pbdom_via.AddContent(ls_cod_prov_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_pais")
				ls_pais_com = idst_dir_comercial.getitemstring(1,"cod_iso"); if isnull(ls_pais_com) then ls_pais_com = '0'
				pbdom_via.AddContent(ls_pais_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
			end if	
		pbdom_persona.AddContent(pbdom_cuerpo)
		// Agregamos nodo de direccion_fiscal
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("direccion_fiscal")
		if ll_found > 0 then 
		//if idst_dir_fiscal.rowcount()>0 then
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_tipo_via")
				ls_tipo_via =f_equivalencia_vu('VU_TIPO_VIA',idst_dir_fiscal.getitemstring(ll_found,"tipo_via"))
				pbdom_via.AddContent(ls_tipo_via)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("nom_via")
				ls_nom_via = idst_dir_fiscal.getitemstring(ll_found,"nom_via"); if isnull(ls_nom_via) then ls_nom_via = ''
				pbdom_via.AddContent(ls_nom_via)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_postal")
				ls_cp_com = idst_dir_fiscal.getitemstring(ll_found,"cp"); if isnull(ls_cp_com) then ls_cp_com = ''
				pbdom_via.AddContent(ls_cp_com)
				pbdom_cuerpo.AddContent(pbdom_via)
				
		
				pbdom_via= create pbdom_element
				pbdom_via.SetName("poblacion")
				ls_poblacion= idst_dir_fiscal.getitemstring(ll_found,"poblaciones_descripcion"); if isnull(ls_poblacion) then ls_poblacion = ''
				pbdom_via.AddContent(ls_poblacion)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_municipio")
				ls_pob_mopu = idst_dir_fiscal.getitemstring(ll_found,"pob_mopu")
				if  ls_pob_mopu = '' or  isnull(ls_pob_mopu) then
						ls_municipio_com= '000'
				else
						ls_municipio_com=ls_pob_mopu
				end if						
				pbdom_via.AddContent(ls_municipio_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_provincia")
				ls_cod_prov_com = f_equivalencia_vu( 'VU_PROVINCIAS',idst_dir_fiscal.getitemstring(ll_found,"cod_prov"))
				pbdom_via.AddContent(ls_cod_prov_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("desc_provincia")
				ls_nombre_prov_com = f_nombre_provincias_vu(ls_cod_prov_com)
				pbdom_via.AddContent(ls_cod_prov_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_pais")
				ls_pais_com = idst_dir_fiscal.getitemstring(ll_found,"cod_iso"); if isnull(ls_pais_com) then ls_pais_com = '0'
				pbdom_via.AddContent(ls_pais_com)
				pbdom_cuerpo.AddContent(pbdom_via)
							
			end if	
		pbdom_persona.AddContent(pbdom_cuerpo)
		// Agregamos nodo de telefono_particular
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("telefono_particular")
		pbdom_cuerpo.AddContent(ls_telefono_1)
		pbdom_persona.AddContent(pbdom_cuerpo)
		// Agregamos nodo de telefono_profesional
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("telefono_profesional")
		pbdom_cuerpo.AddContent(ls_telefono_2)
		pbdom_persona.AddContent(pbdom_cuerpo)
		// Agregamos nodo de telefono_movil_1
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("telefono_movil_1")
		pbdom_cuerpo.AddContent(ls_telefono_3)
		pbdom_persona.AddContent(pbdom_cuerpo)
		// Agregamos nodo de telefono_movil_2
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("telefono_movil_2")
		pbdom_cuerpo.AddContent(ls_telefono_4)
		pbdom_persona.AddContent(pbdom_cuerpo)
		// Agregamos nodo de fax
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("fax")
		pbdom_cuerpo.AddContent(ls_telefono_5)
		pbdom_persona.AddContent(pbdom_cuerpo)
		// Agregamos nodo de email
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("email")
		pbdom_cuerpo.AddContent(ls_email)
		pbdom_persona.AddContent(pbdom_cuerpo)
		// Agregamos nodo de url
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("url")
		pbdom_cuerpo.AddContent(ls_url)
		pbdom_persona.AddContent(pbdom_cuerpo)
		// Agregamos nodo de cuenta_banco
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cuenta_banco")
		pbdom_cuerpo.AddContent(ls_cuenta_domic)
		pbdom_persona.AddContent(pbdom_cuerpo)
		// Termina el nodo de Persona
		pbdom_colegiados.AddContent(pbdom_persona)
		
		//************ Nodo de datos colegiales
		pbdom_nodo= create pbdom_element
		pbdom_nodo.SetName("datos_colegiales")	
		// Agregamos nodo de cod_situacion_profesional
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cod_situacion_profesional")
		pbdom_cuerpo.AddContent(ls_situacion)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de cod_colegio_residencia
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cod_colegio_residencia")
		pbdom_cuerpo.AddContent(ls_colegio)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de num_colegiado
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("num_colegiado")
		pbdom_cuerpo.AddContent(ls_n_colegiado)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de alta
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("alta")
		pbdom_cuerpo.AddContent(ls_alta_baja)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de cod_colegio_primera_colegiacion
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cod_colegio_primera_colegiacion")
		pbdom_cuerpo.AddContent(ls_primera_colegiacion)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de f_primera_colegiacion
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("f_primera_colegiacion")
		ls_fecha = string(date(ldt_f_colegiacion),  "yyyy-mm-dd")
		if isnull(ls_fecha) or  ls_fecha = ''  then ls_fecha = '0001-01-01'
		pbdom_cuerpo.AddContent(ls_fecha)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de f_titulacion
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("f_titulacion")
		ls_fecha = string(date(ldt_f_titulacion),  "yyyy-mm-dd")
		if isnull(ls_fecha) or  ls_fecha = ''  then ls_fecha = '0001-01-01'
		pbdom_cuerpo.AddContent(ls_fecha)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de ejerciente
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("ejerciente")
		pbdom_cuerpo.AddContent(ls_ejerciente)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de f_baja
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("f_baja")
		ls_fecha = string(date(ldt_f_baja),  "yyyy-mm-dd")
		if isnull(ls_fecha) or  ls_fecha = ''  then ls_fecha = '0001-01-01'
		pbdom_cuerpo.AddContent(ls_fecha)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de revista_cercha
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("revista_cercha")
		pbdom_cuerpo.AddContent('false')
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// ********** Termina nodo de datos colegiales
		pbdom_colegiados.AddContent(pbdom_nodo)
		
		//************ Nodo de datos_acreditacion
		pbdom_nodo= create pbdom_element
		pbdom_nodo.SetName("datos_acreditacion")	
		// Agregamos nodo de login
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("login")
		pbdom_cuerpo.AddContent(ls_login)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de password
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("password")
		pbdom_cuerpo.AddContent(ls_password)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de num_fallos
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("num_fallos")
		string ls_fallos
		if not isnull(ll_n_fallos) then  
			ls_fallos =string(ll_n_fallos)
		else
			ls_fallos= string(0)
		end if
		pbdom_cuerpo.AddContent(ls_fallos)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// ********** Termina nodo de datos_acreditacion
		pbdom_colegiados.AddContent(pbdom_nodo)
					
		//************ Nodo de lista_titulaciones_habilitantes
		pbdom_nodo= create pbdom_element
		pbdom_nodo.SetName("lista_titulaciones_habilitantes")	
		if idst_titulaciones_habilitante.rowcount() >0 then 
			ls_condicion = "id_colegiado ='"+ls_colegiado+"'"
			idst_titulaciones_habilitante.setfilter(ls_condicion)
			idst_titulaciones_habilitante.filter()
			for ll = 1 to idst_titulaciones_habilitante.rowcount()
				ls_escuela_final		=  idst_titulaciones_habilitante.getitemstring(ll,"cod_escuela"); if len(ls_escuela_final)> 2 or (isnull(ls_escuela_final) or ls_escuela_final='') then ls_escuela_final='00'
				ls_titulacion 				=  f_equivalencia_vu('VU_TITULACION_HAB', idst_titulaciones_habilitante.getitemstring(ll,"cod_titulacion"));
				if isnull(ls_titulacion)  then ls_titulacion=''
				ls_anyo_terminacion 	=  idst_titulaciones_habilitante.getitemstring(ll,"anyo_terminacion"); if isnull(ls_anyo_terminacion) then ls_anyo_terminacion = ''
					
				pbdom_sub_nodo= create pbdom_element
				pbdom_sub_nodo.SetName("TitulacionHabilitante")
				
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_titulacion")
				pbdom_via.AddContent(ls_titulacion)
				pbdom_sub_nodo.AddContent(pbdom_via)
				
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_escuela")
				pbdom_via.AddContent(ls_escuela_final)
				pbdom_sub_nodo.AddContent(pbdom_via)
				
				pbdom_via= create pbdom_element
				pbdom_via.SetName("anyo_terminacion")
				pbdom_via.AddContent(ls_anyo_terminacion)
				pbdom_sub_nodo.AddContent(pbdom_via)
				pbdom_nodo.AddContent(pbdom_sub_nodo)
			next
			idst_titulaciones_habilitante.setfilter('')
			idst_titulaciones_habilitante.filter()
			
		end if
			
		// ********** Termina nodo de lista_titulaciones_habilitantes
		pbdom_colegiados.AddContent(pbdom_nodo)
		
		//************ Nodo de lista_incompatibilidades
		pbdom_nodo= create pbdom_element
		pbdom_nodo.SetName("lista_incompatibilidades")	
		
		if idst_incompatibilidades.rowcount() >0 then 
			ls_condicion = " incompatibilidades.incompatibilidad='S' and incompatibilidades.id_colegiado ='"+ls_colegiado+"'"
			idst_incompatibilidades.setfilter(ls_condicion)
			idst_incompatibilidades.filter()
			for ll = 1 to idst_incompatibilidades.rowcount()
				ldt_f_inicio		 		= idst_incompatibilidades.getitemdatetime(ll,"fecha_inicio")
				ls_organismo			= idst_incompatibilidades.getitemstring(ll,"organismo");  if isnull(ls_organismo) then ls_organismo = ''
				ls_descripcion		 	= idst_incompatibilidades.getitemstring(ll,"observaciones"); if isnull(ls_descripcion) then ls_descripcion = ''
				ls_temp = 'true'	
				pbdom_sub_nodo= create pbdom_element
				pbdom_sub_nodo.SetName("Incompatibilidad")

				pbdom_via= create pbdom_element
				pbdom_via.SetName("activa")
				pbdom_via.AddContent(ls_temp)
				pbdom_sub_nodo.AddContent(pbdom_via)
				
				pbdom_via= create pbdom_element
				pbdom_via.SetName("f_inicio")
				ls_fecha = string(date(ldt_f_inicio),  "yyyy-mm-dd")
				if isnull(ls_fecha) or  ls_fecha = ''  then ls_fecha = '0001-01-01'
				pbdom_via.AddContent(ls_fecha)
				pbdom_sub_nodo.AddContent(pbdom_via)
				
				pbdom_via= create pbdom_element
				pbdom_via.SetName("organismo")
				pbdom_via.AddContent(ls_organismo)
				pbdom_sub_nodo.AddContent(pbdom_via)
				
				pbdom_via= create pbdom_element
				pbdom_via.SetName("descripcion")
				pbdom_via.AddContent(ls_descripcion)
				pbdom_sub_nodo.AddContent(pbdom_via)
				pbdom_nodo.AddContent(pbdom_sub_nodo)
			next
			idst_incompatibilidades.setfilter('')
			idst_incompatibilidades.filter()
			
		end if
			
		// ********** Termina nodo de lista_incompatibilidades
		pbdom_colegiados.AddContent(pbdom_nodo)
		
		//************ Nodo de lista_inhabilitaciones
		pbdom_nodo= create pbdom_element
		pbdom_nodo.SetName("lista_inhabilitaciones")	
		if idst_inhabilitaciones.rowcount() >0 then 
			ls_condicion = "id_colegiado ='"+ls_colegiado+"'"
			idst_inhabilitaciones.setfilter(ls_condicion)
			idst_inhabilitaciones.filter()
			for ll = 1 to idst_inhabilitaciones.rowcount()
				ls_cod_origen		= idst_inhabilitaciones.getitemstring(ll,"cod_origen"); if isnull(ls_cod_origen) then continue 
				ls_tipo 				= idst_inhabilitaciones.getitemstring(ll,"cod_tipo"); if isnull(ls_tipo) then continue 
				ls_descripcion 	 	= idst_inhabilitaciones.getitemstring(ll,"descripcion") ; if isnull(ls_descripcion) then ls_anyo_terminacion = ''
				ldt_f_inicio	 		= idst_inhabilitaciones.getitemdatetime(ll,"fecha_inicio")
				ldt_f_fin		 		= idst_inhabilitaciones.getitemdatetime(ll,"fecha_fin")
				
				pbdom_sub_nodo= create pbdom_element
				pbdom_sub_nodo.SetName("Inhabilitacion")
				pbdom_via= create pbdom_element
				pbdom_via.SetName("activa")
				pbdom_via.AddContent('true')
				pbdom_sub_nodo.AddContent(pbdom_via)
				
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_origen_inhabilitacion")
				pbdom_via.AddContent(ls_cod_origen)
				pbdom_sub_nodo.AddContent(pbdom_via)
				
				pbdom_via= create pbdom_element
				pbdom_via.SetName("cod_tipo_inhabilitacion")
				pbdom_via.AddContent(ls_tipo)
				pbdom_sub_nodo.AddContent(pbdom_via)
				
				pbdom_via= create pbdom_element
				pbdom_via.SetName("f_inicio")
				ls_fecha = string(date(ldt_f_inicio),  "yyyy-mm-dd")
				if isnull(ls_fecha) or  ls_fecha = ''  then ls_fecha = '0001-01-01'
				pbdom_via.AddContent(ls_fecha)
				pbdom_sub_nodo.AddContent(pbdom_via)
				
				pbdom_via= create pbdom_element
				pbdom_via.SetName("f_fin")
				ls_fecha = string(date(ldt_f_fin),  "yyyy-mm-dd")
				if isnull(ls_fecha) or  ls_fecha = ''  then ls_fecha = '0001-01-01'
				pbdom_via.AddContent(ls_fecha)
				pbdom_sub_nodo.AddContent(pbdom_via)
				
				pbdom_via= create pbdom_element
				pbdom_via.SetName("descripcion")
				pbdom_via.AddContent(ls_descripcion)
				pbdom_sub_nodo.AddContent(pbdom_via)
				pbdom_nodo.AddContent(pbdom_sub_nodo)
			next
			idst_inhabilitaciones.setfilter('')
			idst_inhabilitaciones.filter()
			
		end if
		
		// ********** Termina nodo de lista_inhabilitaciones
		pbdom_colegiados.AddContent(pbdom_nodo)
		
		//************ Nodo de cesion_datos
		pbdom_nodo= create pbdom_element
		pbdom_nodo.SetName("cesion_datos")	
		// Agregamos nodo de cesion_telefono_profesional
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cesion_telefono_profesional")
		pbdom_cuerpo.AddContent(ls_c_tfno_prof)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de compania_src_descripcion
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cesion_telefono_particular")
		pbdom_cuerpo.AddContent(ls_c_tfno_part)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de cesion_movil_1
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cesion_movil_1")
		pbdom_cuerpo.AddContent(ls_c_movil_1)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de cesion_movil_2
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cesion_movil_2")
		pbdom_cuerpo.AddContent(ls_c_movil_2)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de cesion_fax
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cesion_fax")
		pbdom_cuerpo.AddContent(ls_c_fax)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de cesion_email
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cesion_email")
		pbdom_cuerpo.AddContent(ls_c_email)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de cesion_url
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cesion_url")
		pbdom_cuerpo.AddContent(ls_c_url)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de publicidad
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("publicidad")
		pbdom_cuerpo.AddContent(ls_publicidad)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// ********** Termina nodo de cesion_datos
		pbdom_colegiados.AddContent(pbdom_nodo)
		
		//************ Nodo de datos_seguro_rc
		pbdom_nodo= create pbdom_element
		pbdom_nodo.SetName("datos_seguro_rc")	
		// Agregamos nodo de cod_compania_src
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cod_compania_src")
		pbdom_cuerpo.AddContent(ls_src_cia)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de compania_src_descripcion
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("compania_src_descripcion")
		pbdom_cuerpo.AddContent(ls_src_compania)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de src_numero_mutualista
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("src_numero_mutualista")
		pbdom_cuerpo.AddContent(ls_n_mutualista)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de src_numero_poliza
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("src_numero_poliza")
		pbdom_cuerpo.AddContent(ls_src_n_poliza)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de src_cobertura
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("src_cobertura")
		if not isnull(ldb_src_cobertura) then  
			ls_fallos =f_reemplaza_cadena(string(ldb_src_cobertura), ',', '.')
		else
			ls_fallos= string(0)
		end if
		pbdom_cuerpo.AddContent(ls_fallos)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de src_coeficiente_siniestralidad
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("src_coeficiente_siniestralidad")
		if not isnull(ldb_src_coef_cm) then  
			ls_fallos =f_reemplaza_cadena(string(ldb_src_coef_cm), ',', '.')
		else
			ls_fallos= string(0)
		end if
		pbdom_cuerpo.AddContent(ls_fallos)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de cod_ambito_src
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cod_ambito_src")
		pbdom_cuerpo.AddContent('')
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de observaciones
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("observaciones")
		pbdom_cuerpo.AddContent('')
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// ********** Termina nodo de datos_seguro_rc
		pbdom_colegiados.AddContent(pbdom_nodo)
		
		//************ Nodo de datos_prevision_social
		pbdom_nodo= create pbdom_element
		pbdom_nodo.SetName("datos_prevision_social")	
		if isnull(ls_cod_tipo_regimen) or ls_cod_tipo_regimen= '' then ls_cod_tipo_regimen= '0000'
		// Agregamos nodo de cod_tipo_regimen
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("cod_tipo_regimen")
		pbdom_cuerpo.AddContent(ls_cod_tipo_regimen)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// Agregamos nodo de regimen_numero_mutualista
		pbdom_cuerpo= create pbdom_element
		pbdom_cuerpo.SetName("regimen_numero_mutualista")
		pbdom_cuerpo.AddContent(ls_n_mutualista_premaat)
		pbdom_nodo.AddContent(pbdom_cuerpo)
		// ********** Termina nodo de datos_prevision_social
		pbdom_colegiados.AddContent(pbdom_nodo)
		
		pbdom_elem[1].AddContent(pbdom_colegiados)	
	
	next
	
	
	
end subroutine

on w_exportacion_xml.create
int iCurrent
call super::create
this.dw_colegiados=create dw_colegiados
this.dw_datos=create dw_datos
this.cb_1=create cb_1
this.cbx_colegiados=create cbx_colegiados
this.cbx_sociedades=create cbx_sociedades
this.st_1=create st_1
this.st_2=create st_2
this.cbx_cta_banco=create cbx_cta_banco
this.cbx_bajas=create cbx_bajas
this.dw_1=create dw_1
this.cbx_domicilio=create cbx_domicilio
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_colegiados
this.Control[iCurrent+2]=this.dw_datos
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cbx_colegiados
this.Control[iCurrent+5]=this.cbx_sociedades
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.cbx_cta_banco
this.Control[iCurrent+9]=this.cbx_bajas
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.cbx_domicilio
this.Control[iCurrent+12]=this.gb_1
end on

on w_exportacion_xml.destroy
call super::destroy
destroy(this.dw_colegiados)
destroy(this.dw_datos)
destroy(this.cb_1)
destroy(this.cbx_colegiados)
destroy(this.cbx_sociedades)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cbx_cta_banco)
destroy(this.cbx_bajas)
destroy(this.dw_1)
destroy(this.cbx_domicilio)
destroy(this.gb_1)
end on

event closequery;close(w_exportacion_xml)

end event

event open;call super::open;datetime f_desde
string mes

dw_1.insertrow(0)


mes = string(month(today()))		
f_desde = datetime(date('01/'+mes+'/'+string(year(today()))), time('00:00:00'))
//dw_1.setitem(1, 'mes', mes)
dw_1.setitem(1, 'f_desde', f_desde)
dw_1.setitem(1, 'f_hasta', f_ultimo_dia_mes(f_desde))
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_exportacion_xml
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_exportacion_xml
end type

type dw_colegiados from u_csd_dw within w_exportacion_xml
boolean visible = false
integer x = 2231
integer y = 352
integer width = 439
integer height = 96
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_colegiados_sociedades_armar_xml"
end type

type dw_datos from u_csd_dw within w_exportacion_xml
integer x = 2048
integer y = 512
integer width = 658
integer height = 832
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_colegiados_soc_external_xml_new"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

type cb_1 from commandbutton within w_exportacion_xml
integer x = 1573
integer y = 736
integer width = 402
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Generar XML"
end type

event clicked;
//datastore 	 ldst_colegiados
datetime 		f_desde, f_hasta
string 			ruta_colegiado
long 			l

//Objeto que comprueba el tipo de documento
u_csd_nif uo_nif

dw_1.accepttext()
//Trae los datos del colegiado
idst_colegiados = create datastore
idst_colegiados.dataobject ='d_colegiados_exportar_xml_n'
idst_colegiados.settransobject(sqlca)
idst_colegiados.retrieve()

// Obtiene los datos de las sociedades
idst_sociedades = create datastore
idst_sociedades.dataobject ='d_dst_sociedades_coleg_exportar_xml'
idst_sociedades.settransobject(sqlca)
idst_sociedades.retrieve()

//Trae los datos  MUSAAT
idst_musaat = create datastore
idst_musaat.dataobject ='d_dst_datos_musaat_exportar_xml'
idst_musaat.settransobject(sqlca)
idst_musaat.retrieve()

//Trae los datos  MUSAAT
isdt_otros_src = create datastore
isdt_otros_src.dataobject ='d_dst_datos_otra_SRC_exportar_xml'
isdt_otros_src.settransobject(sqlca)
isdt_otros_src.retrieve()

//Trae la direcci$$HEX1$$f300$$ENDHEX$$n fiscal del colegiado y sociedades
idst_dir_fiscal = create datastore
idst_dir_fiscal.dataobject ='d_dst_dir_fiscal_exportar_xml'
idst_dir_fiscal.settransobject(sqlca)
idst_dir_fiscal.retrieve()

//Trae la direcci$$HEX1$$f300$$ENDHEX$$n comercial del colegiado y sociedades
idst_dir_comercial = create datastore
idst_dir_comercial.dataobject ='d_dst_dir_exportar_xml'
idst_dir_comercial.settransobject(sqlca)
idst_dir_comercial.retrieve()

//Completa los datos del colegiado
idst_otros_datos = create datastore
idst_otros_datos.dataobject ='d_dst_otros_datos_coleg_exportar_xml'
idst_otros_datos.settransobject(sqlca)
idst_otros_datos.retrieve()


//Devuelve las titulaciones habilitantes de los colegiados
idst_titulaciones_habilitante = create datastore
idst_titulaciones_habilitante.dataobject ='d_colegiado_titulaciones_hab'
idst_titulaciones_habilitante.settransobject(sqlca)
idst_titulaciones_habilitante.retrieve()

//Devuelve las inhabilitaciones de los colegiados
idst_inhabilitaciones = create datastore
idst_inhabilitaciones.dataobject ='d_dst_colegiados_inhabilitaciones'
idst_inhabilitaciones.settransobject(sqlca)
idst_inhabilitaciones.retrieve()

//Devuelve las incompatibilidades de los colegiados
idst_incompatibilidades = create datastore
idst_incompatibilidades.dataobject ='d_colegiados_incompatibilidades'
idst_incompatibilidades.settransobject(sqlca)
idst_incompatibilidades.retrieve()

//string sql_nuevo

f_desde = dw_1.getitemdatetime(1, "f_desde")
f_hasta =   dw_1.getitemdatetime(1, "f_hasta")

if cbx_colegiados.checked = true then
	
pbdom_bldr = Create PBDOM_Builder

	try
		
		boolean lb_exist = false, bRetTemp = FALSE
		string  ls_docname, strParseErrors[]
	
		ls_docname =  'C:\SICA\colegiados.xml'
		lb_exist = FileExists(ls_docname)
		if not lb_exist then 
			ls_docname = g_dir_aplicacion  + 'colegiados.xml'
			lb_exist = FileExists(ls_docname)
			
			if not lb_exist then 
				messagebox(g_titulo, "No se encuentra el fichero en " + ls_docname )
				return
			end if
		end if
		i_pbdom_doc = pbdom_bldr.BuildFromFile (ls_docname)
		
		bRetTemp = pbdom_bldr.GetParseErrors(strParseErrors)
		if bRetTemp = true then
			for l = 1 to UpperBound(strParseErrors)
				MessageBox ("Parse Error", strParseErrors[l])
			next
		end if
		
		  IF IsValid( i_pbdom_doc ) THEN
		
			// Se posiciona en la etiqueta fichero_intercambio
			i_pbdom_doc.GetContent(l_raiz[])
		
			if cbx_bajas.checked then
			// Se pasan los que esten de baja si se encuentra seleccionado
				idst_colegiados.setfilter("colegiados.alta_baja = 'N' and colegiados.f_baja >=" + string(f_desde, 'yyyy-mm-dd')+ " and colegiados.f_baja <= " + string(f_hasta, 'yyyy-mm-dd'))
				idst_colegiados.filter()
				wf_pbdom_colegiado()
				idst_colegiados.setfilter('')
				idst_colegiados.filter()
			end if
			
			idst_colegiados.setfilter("colegiados.alta_baja = 'S'")
			idst_colegiados.filter()
			wf_pbdom_colegiado()
			idst_colegiados.setfilter('')
			idst_colegiados.filter()
			
							
			if idst_colegiados.rowcount() > 0 then
				string fichero
			
				n_cst_filesrvwin32 cambia_directorio
				string directorio,ruta
				cambia_directorio = create n_cst_filesrvwin32
				directorio = cambia_directorio.of_getcurrentdirectory()
				
					if GetFileSaveName('Seleccione nombre de fichero de colegiados',ruta,fichero,'.xml','Ficheros de datos (*.xml),*.xml')<> 1 Then 
						Messagebox(g_titulo, "No se ha logrado crear el fichero de colegiados!!!")
					else
						if i_pbdom_doc.SaveDocument (fichero )  then 
							Messagebox(g_titulo, 'Fichero de colegiado ' +fichero +' generado con exito!!')
						else
							Messagebox(g_titulo, 'Error al momento de generar el fichero')
						end if
						destroy cambia_directorio
					end if
			
			else
				Messagebox(g_titulo, 'No se encuentran colegiados a procesar')
			end if
		end if
	
	catch (PBDOM_EXCEPTION pbdom_except)
		Messagebox("Excepci$$HEX1$$f300$$ENDHEX$$n",pbdom_except.text )
	CATCH ( PBXRuntimeError re )
		MessageBox( "PBNI Exception", re.getMessage() )
	END TRY
end if

destroy idst_colegiados

//Se procesan las sociedades
if cbx_sociedades.checked = true then
	

	pbdom_bldr = Create PBDOM_Builder

	try
		
//		boolean lb_exist = false, bRetTemp = FALSE
//		string  ls_docname, strParseErrors[]
	
		ls_docname =  'C:\SICA\sociedades.xml'
		lb_exist = FileExists(ls_docname)
		if not lb_exist then 
			messagebox(g_titulo, "No se encuentra el fichero en C:\SICA\sociedades.xml")
			return
		end if
	
		////i_pbdom_doc = pbdom_bldr.BuildFromFile ("C:\SICA\sociedades.xml")
		i_pbdom_doc = pbdom_bldr.BuildFromFile (ls_docname)
		//i_pbdom_doc = pbdom_bldr.BuildFromString (strXML)
		
		
		bRetTemp = pbdom_bldr.GetParseErrors(strParseErrors)
		if bRetTemp = true then
			for l = 1 to UpperBound(strParseErrors)
				MessageBox ("Parse Error", strParseErrors[l])
			next
		end if
		
	//	  i_pbdom_doc.GetRootElement().GetChildElement("lista_sociedades")
		  IF IsValid( i_pbdom_doc ) THEN
		
			// Se posiciona en la etiqueta fichero_intercambio
			i_pbdom_doc.GetContent(l_raiz[])
		
			idst_sociedades.setfilter("colegiados_alta_baja = 'S'")
			idst_sociedades.filter()
			wf_xml_sociedades()
			idst_sociedades.setfilter("")
			idst_sociedades.filter()

			if cbx_bajas.checked then
			// Se pasan los que esten de baja si se encuentra seleccionado
				idst_sociedades.setfilter("colegiados_alta_baja = 'N' and colegiados_f_baja >=" + string(f_desde, 'yyyy-mm-dd')+ " and colegiados_f_baja <= " + string(f_hasta, 'yyyy-mm-dd'))
				idst_sociedades.filter()
				wf_xml_sociedades()
				idst_sociedades.setfilter("")
				idst_sociedades.filter()
			end if
				
				
			if idst_sociedades.rowcount() > 0 then
//				string fichero
			
				n_cst_filesrvwin32 cambia_directorio2
//				string directorio,ruta
				cambia_directorio2 = create n_cst_filesrvwin32
				directorio = cambia_directorio2.of_getcurrentdirectory()
				
					if GetFileSaveName('Seleccione nombre de fichero de sociedades',ruta,fichero,'.xml','Ficheros de datos (*.xml),*.xml')<> 1 Then 
						Messagebox(g_titulo, "No se ha logrado crear el fichero de sociedades!!!")
					else
						if i_pbdom_doc.SaveDocument (fichero )  then 
							Messagebox(g_titulo, 'Fichero de sociedades ' +fichero +' generado con exito!!')
						else
							Messagebox(g_titulo, 'Error al momento de generar el fichero')
						end if
						destroy cambia_directorio2
					end if
			
			else
				Messagebox(g_titulo, 'No se encuentran sociedades a procesar')
			end if
		end if
	
	catch (PBDOM_EXCEPTION pbdom_except1)
		Messagebox("Excepci$$HEX1$$f300$$ENDHEX$$n",pbdom_except1.text )
	CATCH ( PBXRuntimeError re1 )
		MessageBox( "PBNI Exception", re1.getMessage() )
	END TRY
end if


destroy idst_sociedades
destroy idst_musaat
destroy idst_dir_fiscal
destroy idst_dir_comercial
destroy idst_otros_datos
destroy idst_titulaciones_habilitante
destroy idst_inhabilitaciones
destroy idst_incompatibilidades


end event

type cbx_colegiados from checkbox within w_exportacion_xml
integer x = 37
integer y = 32
integer width = 695
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Procesar Colegiados"
boolean checked = true
end type

type cbx_sociedades from checkbox within w_exportacion_xml
integer x = 878
integer y = 24
integer width = 695
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Procesar Sociedades"
boolean checked = true
end type

type st_1 from statictext within w_exportacion_xml
integer x = 37
integer y = 672
integer width = 1463
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within w_exportacion_xml
integer x = 37
integer y = 768
integer width = 1463
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
boolean border = true
boolean focusrectangle = false
end type

type cbx_cta_banco from checkbox within w_exportacion_xml
integer x = 73
integer y = 256
integer width = 695
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Incluir Cta Bancarias"
boolean checked = true
end type

type cbx_bajas from checkbox within w_exportacion_xml
integer x = 73
integer y = 352
integer width = 622
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Incluir bajas"
end type

event clicked;if this.checked then 
	dw_1.object.mes.protect = false
	dw_1.object.f_desde.protect = false
	dw_1.object.f_hasta.protect = false
else
	dw_1.object.mes.protect = true
	dw_1.object.f_desde.protect = true
	dw_1.object.f_hasta.protect = true
end if
end event

type dw_1 from u_csd_dw within w_exportacion_xml
integer x = 475
integer y = 320
integer width = 1463
integer height = 256
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_consejo_meses"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'mes'
		datetime f_desde
		string mes
		mes = data
		
		f_desde = datetime(date('01/'+mes+'/'+string(year(today()))), time('00:00:00'))
		this.setitem(1, 'f_desde', f_desde)
		this.setitem(1, 'f_hasta', f_ultimo_dia_mes(f_desde))
		
end choose
end event

type cbx_domicilio from checkbox within w_exportacion_xml
boolean visible = false
integer x = 878
integer y = 256
integer width = 882
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Notificar domicilio profesional"
boolean checked = true
end type

event clicked;if this.checked then 
	dw_1.object.mes.protect = false
	dw_1.object.f_desde.protect = false
	dw_1.object.f_hasta.protect = false
else
	dw_1.object.mes.protect = true
	dw_1.object.f_desde.protect = true
	dw_1.object.f_hasta.protect = true
end if
end event

type gb_1 from groupbox within w_exportacion_xml
integer x = 37
integer y = 160
integer width = 1938
integer height = 448
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Opciones"
end type

