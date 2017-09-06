HA$PBExportHeader$w_csd_impresion_formatos1.srw
forward
global type w_csd_impresion_formatos1 from w_response
end type
type cb_1 from commandbutton within w_csd_impresion_formatos1
end type
type cb_2 from commandbutton within w_csd_impresion_formatos1
end type
type tab_1 from tab within w_csd_impresion_formatos1
end type
type tabpage_1 from userobject within tab_1
end type
type dw_impresion from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_impresion dw_impresion
end type
type tabpage_2 from userobject within tab_1
end type
type dw_certificado from u_dw within tabpage_2
end type
type dw_pdf from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_certificado dw_certificado
dw_pdf dw_pdf
end type
type tabpage_3 from userobject within tab_1
end type
type tab_2 from tab within tabpage_3
end type
type tabpage_5 from userobject within tab_2
end type
type mle_mensaje from multilineedit within tabpage_5
end type
type tabpage_5 from userobject within tab_2
mle_mensaje mle_mensaje
end type
type tabpage_6 from userobject within tab_2
end type
type dw_adj from u_dw within tabpage_6
end type
type tabpage_6 from userobject within tab_2
dw_adj dw_adj
end type
type tab_2 from tab within tabpage_3
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type
type dw_mail from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
tab_2 tab_2
dw_mail dw_mail
end type
type tabpage_4 from userobject within tab_1
end type
type dw_sms from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_sms dw_sms
end type
type tab_1 from tab within w_csd_impresion_formatos1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
type cbx_papel from checkbox within w_csd_impresion_formatos1
end type
type cbx_pdf from checkbox within w_csd_impresion_formatos1
end type
type cbx_mail from checkbox within w_csd_impresion_formatos1
end type
type dw_opciones from u_dw within w_csd_impresion_formatos1
end type
type cbx_sms from checkbox within w_csd_impresion_formatos1
end type
type gb_1 from groupbox within w_csd_impresion_formatos1
end type
end forward

global type w_csd_impresion_formatos1 from w_response
integer x = 214
integer y = 221
integer width = 2007
integer height = 1952
cb_1 cb_1
cb_2 cb_2
tab_1 tab_1
cbx_papel cbx_papel
cbx_pdf cbx_pdf
cbx_mail cbx_mail
dw_opciones dw_opciones
cbx_sms cbx_sms
gb_1 gb_1
end type
global w_csd_impresion_formatos1 w_csd_impresion_formatos1

type variables
st_csd_seleccion_formato_impresion i_opciones
st_reg_es_series_rutas ist_rutas
u_dw idw_papel,idw_pdf,idw_mail,idw_certificado,idw_sms,idw_adjuntos


//string i_certificado
end variables

forward prototypes
public function integer wf_comprobar_configuracion_sello ()
end prototypes

public function integer wf_comprobar_configuracion_sello ();boolean lbo_certificado_activo
string nombre, situacion, razon, certificado, password, mensaje, nulo
integer retorno
decimal x1, y1
n_firmador_pdf firmador

certificado = idw_certificado.GetItemString(1,'nombre_certificado')

if f_es_vacio(certificado) then
	Messagebox(g_titulo,'NO se ha inclu$$HEX1$$ed00$$ENDHEX$$do ning$$HEX1$$fa00$$ENDHEX$$n certificado v$$HEX1$$e100$$ENDHEX$$lido para firmar el documento. Revise la configuraci$$HEX1$$f300$$ENDHEX$$n de sellado o inicie Sesi$$HEX1$$f300$$ENDHEX$$n.',StopSign!)
	return -1
end if

//Comprobamos que est$$HEX1$$e900$$ENDHEX$$n rellenos los datos obligatorios del sello
nombre = idw_certificado.getitemstring(1,'nombre')
situacion = idw_certificado.getitemstring(1,'situacion')
razon = idw_certificado.getitemstring(1,'razon')

certificado = g_directorio_certificados + certificado

password = idw_certificado.getitemstring(1,'password')

if f_es_vacio(nombre) then mensaje += 'Debe especificar un nombre.' +cr
if f_es_vacio(situacion) then mensaje += 'Debe especificar una situaci$$HEX1$$f300$$ENDHEX$$n.' +cr
if f_es_vacio(razon) then mensaje += 'Debe especificar una raz$$HEX1$$f300$$ENDHEX$$n.' +cr
if not(fileexists(certificado)) then
		mensaje += 'Debe especificar un certificado v$$HEX1$$e100$$ENDHEX$$lido.' +cr		
end if
if f_es_vacio(password) then mensaje += 'Debe especificar la contrase$$HEX1$$f100$$ENDHEX$$a del certificado.' +cr

// Validaciones de Configuracion del sello
x1 = i_opciones.ast_configuracion_sello.dw_configuracion_sello.GetItemDecimal(1, 'x')
y1 = i_opciones.ast_configuracion_sello.dw_configuracion_sello.GetItemDecimal(1, 'y')

if i_opciones.ast_configuracion_sello.dw_configuracion_sello.GetItemString(1, 'posicion') = 'L' then
 if f_es_vacio(string(x1)) or f_es_vacio(string(y1)) then mensaje += 'Debe especificar la coordenadas X e Y de la posici$$HEX1$$f300$$ENDHEX$$n libre.' +cr
end if

// Validaciones de Seguridad de Configuracion del sello
firmador = create n_firmador_pdf
//i_sentencia_proteger = ''



if i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'encriptar') = "S" then 
 if f_es_vacio(i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'password')) or f_es_vacio(i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'password2')) then
  mensaje += "Debe especificar la contrase$$HEX1$$f100$$ENDHEX$$a de propietario" +cr
 end if
 
 if (i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'password') <> i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'password2')) then
  mensaje += "Las contrase$$HEX1$$f100$$ENDHEX$$as de propietario deben coincidir" +cr
 end if   
 
 firmador.f_ownerpass(i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'password'))
 
end if	

if i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'habilitar_userpass') = "S" then
 if f_es_vacio(i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'userpass')) or f_es_vacio(i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'userpass2')) then
  mensaje += "Debe especificar la contrase$$HEX1$$f100$$ENDHEX$$a de usuario" +cr
 end if
 
 if (i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'userpass') <> i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'userpass2')) then
  mensaje += "Las contrase$$HEX1$$f100$$ENDHEX$$as de usuario deben coincidir" +cr
 end if 
 
 firmador.f_userpass(i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'habilitar_userpass'),i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'userpass'))
end if	

if not(f_es_vacio(i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'password'))) and not(f_es_vacio(i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'userpass'))) then
 if i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'password') = i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'userpass') then
  mensaje += "Las contrase$$HEX1$$f100$$ENDHEX$$a de propietario y de usuario deben de ser distintas" +cr
 end if
end if

// PROTEGER
firmador.f_nomodify(i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'nomodify'))
firmador.f_noassembly(i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'noassembly'))
firmador.f_nonotes(i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'nonotes'))
firmador.f_nofill(i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'nofill'))
firmador.f_nohighresolution(i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'nohighres'))
firmador.f_nocopy(i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'nocopy'))
firmador.f_noaccess(i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'noaccess'))
firmador.f_noprint(i_opciones.ast_configuracion_sello.dw_configuracion_sello.getItemString(1,'noprint'))

// FIRMAR
//firmador.f_certificado()

// Ahora lo pasamos el string "sentencia de seguridad" a inv_firmador,
// dentro de su vble. publica i_sentencia_proteger
i_opciones.ast_configuracion_sello.sentencia_proteger = firmador.i_cadena_proteger
//i_sentencia_firmar   = firmador.i_cadena_firmar

destroy firmador


if mensaje <> '' then
	messagebox(g_titulo, mensaje)
	retorno =  -1
else
	retorno =  1
end if


return retorno

end function

on w_csd_impresion_formatos1.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.tab_1=create tab_1
this.cbx_papel=create cbx_papel
this.cbx_pdf=create cbx_pdf
this.cbx_mail=create cbx_mail
this.dw_opciones=create dw_opciones
this.cbx_sms=create cbx_sms
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.tab_1
this.Control[iCurrent+4]=this.cbx_papel
this.Control[iCurrent+5]=this.cbx_pdf
this.Control[iCurrent+6]=this.cbx_mail
this.Control[iCurrent+7]=this.dw_opciones
this.Control[iCurrent+8]=this.cbx_sms
this.Control[iCurrent+9]=this.gb_1
end on

on w_csd_impresion_formatos1.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.tab_1)
destroy(this.cbx_papel)
destroy(this.cbx_pdf)
destroy(this.cbx_mail)
destroy(this.dw_opciones)
destroy(this.cbx_sms)
destroy(this.gb_1)
end on

event open;call super::open;int resp,fila
string ruta_docuprinter, tipo_factura

f_centrar_ventana(this)

idw_papel = tab_1.tabpage_1.dw_impresion
idw_pdf = tab_1.tabpage_2.dw_pdf
idw_mail = tab_1.tabpage_3.dw_mail
idw_certificado = tab_1.tabpage_2.dw_certificado
idw_sms = tab_1.tabpage_4.dw_sms
idw_adjuntos= tab_1.tabpage_3.tab_2.tabpage_6.dw_adj

//dw_1.insertrow(0)
idw_sms.insertrow(0)
idw_papel.insertrow(0)
idw_pdf.insertrow(0)
idw_mail.insertrow(0)
idw_certificado.insertrow(0)
dw_opciones.insertrow(0)

if isvalid(message.powerobjectparm) then
	i_opciones = message.powerobjectparm 
	if f_es_vacio(i_opciones.visualizar_web) then i_opciones.visualizar_web='N'
	if f_es_vacio(i_opciones.email) then i_opciones.email ='N'
	if f_es_vacio(i_opciones.papel) then i_opciones.papel='N'
	if f_es_vacio(i_opciones.pdf) then i_opciones.pdf='N'
	
//	dw_1.setitem(1,'nombre',i_opciones.nombre) 
//	dw_1.setitem(1,'pdf',i_opciones.pdf)
//	dw_1.setitem(1,'email',i_opciones.email)
//	dw_1.setitem(1,'papel',i_opciones.papel)
	if i_opciones.papel = 'S' then cbx_papel.checked = true
	if i_opciones.email = 'S' then cbx_mail.checked = true
	if i_opciones.pdf = 'S' then cbx_pdf.checked = true
	if i_opciones.sms = 'S' then cbx_sms.checked = true	
	if i_opciones.ver_adjuntos then tab_1.tabpage_3.tab_2.tabpage_6.visible=true
	idw_papel.setitem(1,'intervalo',i_opciones.impresora_intervalo)
	idw_papel.setitem(1,'paginas_desde',i_opciones.impresora_pagina_desde)
	idw_papel.setitem(1,'paginas_hasta',i_opciones.impresora_pagina_hasta)
	idw_papel.setitem(1,'n_copias',i_opciones.copias)
	idw_papel.setitem(1,'n_copias2',i_opciones.copias2)	
	idw_sms.SetItem(1,'texto',i_opciones.texto_sms)
	idw_sms.SetItem(1,'caracteres',len(i_opciones.texto_sms))
	idw_sms.SetItem(1,'movil',i_opciones.moviles)	
	if i_opciones.impresora_intercalar then
		idw_papel.setitem(1,'intercalar','S')
	else
		idw_papel.setitem(1,'intercalar','N')
	end if

	idw_papel.setitem(1,'nombre_print', i_opciones.impresora)
	idw_papel.setitem(1,'bandeja', i_opciones.bandeja)

	if i_opciones.ruta_automatica then
	
		ist_rutas.serie=i_opciones.serie
		ist_rutas.ruta_relativa1=i_opciones.ruta_relativa1
		ist_rutas.ruta_relativa2=i_opciones.ruta_relativa2
		ist_rutas.ruta_relativa3=i_opciones.ruta_relativa3
		ist_rutas.ruta_relativa4=i_opciones.ruta_relativa4		
	
		idw_pdf.setitem(1,'ruta_base',f_reg_es_obtener_ruta_serie(ist_rutas,0))
		idw_pdf.setitem(1,'ruta_relativa',f_reg_es_obtener_ruta_serie(ist_rutas,2))
	else
		idw_pdf.setitem(1,'ruta_base',i_opciones.ruta_base)
		idw_pdf.setitem(1,'ruta_relativa',i_opciones.ruta_relativa)
	end if
	idw_pdf.setitem(1,'nombre_fichero',i_opciones.nombre)
	idw_pdf.setitem(1,'visualizar_web',i_opciones.visualizar_web)
	dw_opciones.setitem(1,'serie',i_opciones.serie)
	dw_opciones.setitem(1,'generar_registro',i_opciones.generar_registro)	
	dw_opciones.setitem(1,'nuevo',i_opciones.nuevo_reg_salida)	
	dw_opciones.setitem(1,'n_reg',i_opciones.n_registro_salida)		
	datawindowchild dwc_serie
	dw_opciones.GetChild('serie',dwc_serie)
	dwc_serie.SetFilter("(cod_delegacion=	'"+g_cod_delegacion+"' or cod_delegacion='%') and tipo='S' and empresa = '"+g_empresa+"'")
	dwc_serie.filter()		
	if i_opciones.pdf_previsualizar then
		idw_pdf.setitem(1,'pdf_previsualizar','S')
	else
		idw_pdf.setitem(1,'pdf_previsualizar','N')
	end if
	idw_mail.setitem(1,'asunto',i_opciones.asunto_email)
	idw_mail.setitem(1,'html',i_opciones.html)	
	idw_mail.setitem(1,'direccion',i_opciones.direccion_email)
	

	//idw_mail.setitem(1,'cuerpo',i_opciones.texto_email)
	//idw_mail.setitem(1,'adjunto',i_opciones.nombre_adjunto_email)
	tab_1.tabpage_3.tab_2.tabpage_5.mle_mensaje.text=i_opciones.texto_email
	if not(f_es_vacio(i_opciones.nombre_adjunto_email)) then
		fila=idw_adjuntos.insertrow(0)
		idw_adjuntos.SetItem(fila,'nombre_fichero',i_opciones.nombre_adjunto_email)
	end if
	
	
	idw_mail.setitem(1,'plantilla',i_opciones.plantilla)	
	if i_opciones.sin_adjuntos then
		idw_mail.setitem(1,'sin_adjuntos','S')		
	else
		idw_mail.setitem(1,'sin_adjuntos','N')				
	end if
end if


// Cuando enviamos masivamente hay campos que desactivamos ya que se recalculan en cada
// envio del proceso, por ej. La ruta relativa var$$HEX1$$ed00$$ENDHEX$$a en funcion del numero de colegiado que tratamos
if i_opciones.masivo then
	this.title = "Opciones del Proceso de Impresi$$HEX1$$f300$$ENDHEX$$n Masivo de Documentos"
	idw_pdf.SetItem(1,'pdf_previsualizar','N')	
	idw_pdf.object.pdf_previsualizar.visible=false	
	inhabilita(idw_pdf,'ruta_base')
	inhabilita(idw_pdf,'ruta_relativa')
	idw_pdf.object.ruta_relativa.visible = false
	inhabilita(idw_mail,'direccion')
	idw_pdf.object.envio_solo_a_clientes.visible=true
	
	idw_mail.object.direccion.visible=false	
	idw_mail.object.direccion_t.visible=false	
	idw_mail.object.b_direccion.visible=false
	idw_mail.object.b_lista_direccion.visible=false
	
	if not(f_es_vacio(i_opciones.enviar_email_clientes)) then idw_pdf.SetItem(1,'envio_solo_a_clientes',i_opciones.enviar_email_clientes)	

	if i_opciones.email = 'S' then 
		idw_pdf.object.envio_solo_a_clientes.protect = true
		idw_pdf.object.envio_solo_a_clientes.color = string(RGB(120, 120, 120))
	end if	

	if not(i_opciones.masivo_cambiar_nombre) then
		inhabilita(idw_pdf,'nombre_fichero')
		idw_pdf.object.nombre_fichero.visible = false
	end if
	
	if not(i_opciones.masivo_cambiar_asunto) then 
	//	idw_mail.SetItem(1,'asunto','')	
		inhabilita(idw_mail,'asunto')			
	end if	
else 
		this.title = "Opciones del Proceso de Impresi$$HEX1$$f300$$ENDHEX$$n de Documentos"
end if

// Posibilidad de cambiar la serie
if not(i_opciones.cambiar_serie) then
	inhabilita(dw_opciones,'serie')
else
	habilita(dw_opciones,'serie',5)
end if


// El env$$HEX1$$ed00$$ENDHEX$$o simple es aquel que se activa desde la opcion Mail / SMS
if i_opciones.envio_simple then
	cbx_papel.checked=false
	cbx_papel.enabled=false
	cbx_pdf.checked=false
	cbx_pdf.enabled=false
	tab_1.tabpage_1.enabled=false
	tab_1.tabpage_2.enabled=false
	if cbx_sms.checked=true and cbx_mail.checked=false then
		tab_1.post selecttab(4)		
	else
		tab_1.post selecttab(3)
	end if
end if



// Activamos el envio por SMS en caso de tenerlo contratado
if g_envio_sms='S' then
	cbx_sms.enabled=true
else
	cbx_sms.enabled=false	
	cbx_sms.checked=false	
end if
	


// Convertimos las variables papel,email,pdf y sms en triestado:
//	S= Activado
//	N = Desactivado
//	X = Deshabilitado y desactivado

if i_opciones.papel = 'X' then 
	cbx_papel.enabled = false
	cbx_papel.checked = false
end if
if i_opciones.email = 'X' then
	cbx_mail.enabled = false
	cbx_mail.checked = false
end if
if i_opciones.pdf = 'X' then
	cbx_pdf.enabled = false
	cbx_pdf.checked = false
end if
if i_opciones.sms = 'X' then
	cbx_sms.enabled = false	
	cbx_sms.checked = false		
end if

end event

event pfc_postopen;call super::pfc_postopen;
if idw_pdf.GetItemString(1,'firmar_pdf')='S' then
	idw_certificado.visible=true
else
	idw_certificado.visible=false
end if

f_recuperar_consulta_un_dw(idw_certificado,'w_csd_impresion_formatos1','INICIO')

// Si hay sesion de sellado iniciada cargamos los datos
if not(f_es_vacio(g_sellador_certificado)) then
	idw_certificado.Object.t_iniciado.visible=true
	idw_certificado.Object.t_no_iniciado.visible=false
	idw_certificado.SetItem(1,'nombre_certificado',g_sellador_certificado)
	idw_certificado.SetItem(1,'password',g_sellador_password)
end if
	
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_csd_impresion_formatos1
integer x = 1879
integer y = 260
integer width = 41
integer taborder = 60
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_csd_impresion_formatos1
integer x = 1879
integer y = 388
integer width = 64
integer taborder = 70
end type

type cb_1 from commandbutton within w_csd_impresion_formatos1
string tag = "texto=general.aceptar"
integer x = 1234
integer y = 1752
integer width = 338
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
end type

event clicked;idw_papel.accepttext()
idw_pdf.accepttext()
idw_mail.accepttext()
idw_sms.accepttext()
idw_certificado.accepttext()
dw_opciones.acceptText()

string serie,mensaje
long num,i

serie=dw_opciones.getitemstring(1,'serie')
if 	dw_opciones.getitemstring(1,'generar_registro')='S' then
   if f_es_vacio(serie) then
		mensaje = "La serie del registro de salida no puede ser vac$$HEX1$$ed00$$ENDHEX$$a"
		if g_usar_idioma = "S" then
			mensaje = g_idioma.of_getmsg( "w_csd_impresion.serie_vacia" ,mensaje)
		end if
		MessageBox(g_titulo, mensaje)
		return
	else
		select count(*) into :num from registro_series where codigo=:serie and (cod_delegacion=:g_cod_delegacion or cod_delegacion='%');
		if num<1 then
			mensaje = "La serie seleccionada no existe. Consulte con el departamento de inform$$HEX1$$e100$$ENDHEX$$tica para su creaci$$HEX1$$f300$$ENDHEX$$n"
			if g_usar_idioma = "S" then
				mensaje = g_idioma.of_getmsg( "w_csd_impresion.serie_inexistente" ,mensaje)
			end if
			MessageBox(g_titulo, mensaje)
			return
		end if
	end if
end if

i_opciones.pdf = 'N'
i_opciones.email = 'N'
i_opciones.papel = 'N'
i_opciones.sms = 'N'

if cbx_papel.checked THEN i_opciones.papel = 'S' 
if cbx_mail.checked then i_opciones.email = 'S' 
if cbx_pdf.checked then i_opciones.pdf = 'S'
if cbx_sms.checked then i_opciones.sms = 'S'

if idw_pdf.getitemstring(1,'pdf_previsualizar')='S' then
	i_opciones.pdf_previsualizar = true
else
	i_opciones.pdf_previsualizar = false
end if

i_opciones.impresora_intervalo =	idw_papel.getitemstring(1,'intervalo')
i_opciones.impresora_pagina_desde =	idw_papel.getitemnumber(1,'paginas_desde')
i_opciones.impresora_pagina_hasta =	idw_papel.getitemnumber(1,'paginas_hasta')
i_opciones.copias = idw_papel.getitemnumber(1,'n_copias')
i_opciones.copias2 = idw_papel.getitemnumber(1,'n_copias2')
if idw_papel.getitemstring(1,'intercalar')='S' then
	i_opciones.impresora_intercalar = true
else 
	i_opciones.impresora_intercalar = false
end if

i_opciones.ruta_base = idw_pdf.getitemstring(1,'ruta_base')
i_opciones.ruta_relativa =	idw_pdf.getitemstring(1,'ruta_relativa')
i_opciones.nombre= 	idw_pdf.getitemstring(1,'nombre_fichero')
i_opciones.visualizar_web = idw_pdf.getitemstring(1,'visualizar_web')
	
//i_opciones.texto_email = 	idw_mail.getitemstring(1,'cuerpo')
i_opciones.texto_email = tab_1.tabpage_3.tab_2.tabpage_5.mle_mensaje.text
i_opciones.asunto_email = 	idw_mail.getitemstring(1,'asunto')
i_opciones.direccion_email = 	idw_mail.getitemstring(1,'direccion')
i_opciones.cc_email = 	idw_mail.getitemstring(1,'cc')
i_opciones.cco_email = 	idw_mail.getitemstring(1,'cco')
i_opciones.plantilla = 	idw_mail.getitemstring(1,'plantilla')
i_opciones.html = 	idw_mail.getitemstring(1,'html')
i_opciones.enviar_email_clientes = idw_pdf.getitemstring(1,'envio_solo_a_clientes')

i_opciones.generar_registro = dw_opciones.getitemstring(1,'generar_registro')

i_opciones.texto_sms=idw_sms.GetItemSTring(1,'texto')
i_opciones.moviles=idw_sms.GetItemSTring(1,'movil')

i_opciones.serie = dw_opciones.getitemstring(1,'serie')
i_opciones.nuevo_reg_salida=dw_opciones.GetItemString(1,'nuevo')
i_opciones.n_registro_salida=dw_opciones.GetItemString(1,'n_reg')

if idw_mail.getitemstring(1,'sin_adjuntos')='S' then
	i_opciones.sin_adjuntos = 	true
else
	i_opciones.sin_adjuntos = 	false
end if

if (i_opciones.pdf = 'N') and (i_opciones.papel = 'N') and (i_opciones.email = 'N') and (i_opciones.sms='N')  then
	mensaje =  'Debe de seleccionar por lo menos un formato'
	if g_usar_idioma = "S" then
		mensaje = g_idioma.of_getmsg( "w_csd_impresion.formato", mensaje)
	end if
	messagebox(g_titulo,mensaje)
	return
end if

if not(i_opciones.masivo) and (i_opciones.pdf = 'S') and f_es_vacio(i_opciones.nombre) then
	mensaje = 'Debe especificar un nombre de archivo'
	if g_usar_idioma = "S" then
		mensaje = g_idioma.of_getmsg( "w_csd_impresion.nombre_archivo", mensaje)
	end if
	messagebox(g_titulo,mensaje)
	return
end if

if (i_opciones.email = 'S') then
	if not(i_opciones.masivo) and f_es_vacio(i_opciones.direccion_email)  then
		mensaje = 'Debe especificar una direcci$$HEX1$$f300$$ENDHEX$$n de e-mail principal'
		if g_usar_idioma = "S" then
			mensaje = g_idioma.of_getmsg( "w_csd_impresion.mail", mensaje)
		end if
		messagebox(g_titulo,mensaje)
		return
	elseif not(i_opciones.masivo) and f_es_vacio(i_opciones.asunto_email) then
		mensaje = 'Debe especificar un asunto para el e-mail'
		if g_usar_idioma = "S" then
			mensaje = g_idioma.of_getmsg( "w_csd_impresion.asuntol", mensaje)
		end if
		messagebox(g_titulo,mensaje)
		return
	end if
end if

i_opciones.firmar_pdf=idw_pdf.GetItemString(1,'firmar_pdf')
i_opciones.certificado=idw_certificado.GetItemSTring(1,'nombre_certificado')
i_opciones.password=idw_certificado.GetItemSTring(1,'password')
i_opciones.nombre_cer=idw_certificado.GetItemSTring(1,'nombre')
i_opciones.razon=idw_certificado.GetItemSTring(1,'razon')
i_opciones.situacion=idw_certificado.GetItemSTring(1,'situacion')

i_opciones.aplica_sellado = idw_pdf.GetItemString(1,'aplica_sellado')

if (i_opciones.pdf = 'S') and (i_opciones.aplica_sellado = 'S')  then
	i = wf_comprobar_configuracion_sello()
	if i = -1 then return
end if	

// Vaciamos contenido de la configuraci$$HEX1$$f300$$ENDHEX$$n del sello. 
if (i_opciones.pdf = 'N') or (i_opciones.aplica_sellado = 'N') then 
	st_configuracion_sello lst_configuracion_sello
	i_opciones.ast_configuracion_sello = lst_configuracion_sello
end if 

i_opciones.retorno=0


for i=1 to idw_adjuntos.rowcount()
	i_opciones.adjuntos[i]=idw_adjuntos.GetItemString(i,'nombre_fichero')
next


closewithreturn(parent,i_opciones)

end event

type cb_2 from commandbutton within w_csd_impresion_formatos1
string tag = "texto=general.cancelar"
integer x = 1582
integer y = 1752
integer width = 338
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
end type

event clicked;close(parent)
end event

type tab_1 from tab within w_csd_impresion_formatos1
integer x = 55
integer y = 236
integer width = 1879
integer height = 1280
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

type tabpage_1 from userobject within tab_1
string tag = "texto=Papel"
integer x = 18
integer y = 112
integer width = 1842
integer height = 1152
long backcolor = 79741120
string text = "Papel"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Print!"
long picturemaskcolor = 16777215
dw_impresion dw_impresion
end type

on tabpage_1.create
this.dw_impresion=create dw_impresion
this.Control[]={this.dw_impresion}
end on

on tabpage_1.destroy
destroy(this.dw_impresion)
end on

type dw_impresion from u_dw within tabpage_1
integer x = 14
integer y = 8
integer width = 1824
integer height = 916
integer taborder = 11
string dataobject = "d_csd_seleccion_formato_impresion_papel"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event buttonclicked;call super::buttonclicked;choose case dwo.name
	case 'b_impresora'
		PrintSetup()
		string imp
		imp=printGetPrinter()
end choose
end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'paginas_desde','paginas_hasta'
		this.setitem(row,'intervalo','P')
end choose
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 1842
integer height = 1152
long backcolor = 79741120
string text = "PDF"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Imagenes\pdf.ico"
long picturemaskcolor = 16777215
dw_certificado dw_certificado
dw_pdf dw_pdf
end type

on tabpage_2.create
this.dw_certificado=create dw_certificado
this.dw_pdf=create dw_pdf
this.Control[]={this.dw_certificado,&
this.dw_pdf}
end on

on tabpage_2.destroy
destroy(this.dw_certificado)
destroy(this.dw_pdf)
end on

type dw_certificado from u_dw within tabpage_2
boolean visible = false
integer x = 73
integer y = 668
integer width = 1691
integer height = 376
integer taborder = 11
string dataobject = "d_csd_seleccion_formato_certificado"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event buttonclicked;call super::buttonclicked;string certificado
string nulo
int i, linea_certificado, linea_activa

SetNull(nulo)

choose case dwo.name
	case 'b_quitar'	
		idw_certificado.SetItem(1,'nombre_certificado',nulo)
		idw_certificado.SetItem(1,'password',nulo)
		idw_certificado.SetItem(1,'nombre',nulo)
		idw_certificado.SetItem(1,'razon',nulo)
		idw_certificado.SetItem(1,'situacion',nulo)	
		
	case 'b_certificado'	
		open(w_certificados)
		certificado=Message.StringParm
		
		if Not(IsNull(certificado)) and certificado<>'' then
			idw_certificado.SetItem(1,'nombre_certificado',certificado)
			idw_certificado.SetItem(1,'password','')
		
			if (i_opciones.ast_configuracion_sello.dw_certificados.rowcount( )> 0) then 
				
				linea_activa = i_opciones.ast_configuracion_sello.dw_certificados.find('activo="S"',1,i_opciones.ast_configuracion_sello.dw_certificados.rowcount())
				
				for i= 1 to i_opciones.ast_configuracion_sello.dw_certificados.rowcount( )
					i_opciones.ast_configuracion_sello.dw_certificados.setitem(i, 'activo', 'N')
				next 
				
				linea_certificado = i_opciones.ast_configuracion_sello.dw_certificados.find('certificado=" ' + certificado + '"',1,i_opciones.ast_configuracion_sello.dw_certificados.rowcount())
				
				if (linea_certificado > 0) then 
					i_opciones.ast_configuracion_sello.dw_certificados.setitem( linea_certificado, 'activo', 'S')
					i_opciones.ast_configuracion_sello.dw_certificados.setitem( linea_certificado, 'activo', 'S')
					i_opciones.ast_configuracion_sello.dw_certificados.setitem( linea_certificado, 'password', '')
				else 
					
					linea_certificado = i_opciones.ast_configuracion_sello.dw_certificados.insertrow(0)
					
					if linea_certificado > 0  then 
						i_opciones.ast_configuracion_sello.dw_certificados.setitem( linea_certificado, 'certificado', certificado)
						i_opciones.ast_configuracion_sello.dw_certificados.setitem( linea_certificado, 'activo', 'S')
						i_opciones.ast_configuracion_sello.dw_certificados.setitem( linea_certificado, 'password', '')
						
					else 
						i_opciones.ast_configuracion_sello.dw_certificados.setitem( linea_activa, 'activo', 'S')
					end if	
					
					
				end if
				
			end if
			
		end if
		
	case 'b_grabar'
		f_grabar_consulta_un_dw(idw_certificado,'w_csd_impresion_formatos1','INICIO')
		
end choose

end event

event itemchanged;call super::itemchanged;int i 

choose case dwo.name
	case 'nombre'
			if (i_opciones.ast_configuracion_sello.dw_datos_firma.rowcount( ) > 0 ) then 
				i_opciones.ast_configuracion_sello.dw_datos_firma.setitem(1, 'nombre', data)
			end if	

	case 'situacion'		
			if (i_opciones.ast_configuracion_sello.dw_datos_firma.rowcount( ) > 0 ) then 
				i_opciones.ast_configuracion_sello.dw_datos_firma.setitem(1, 'situacion', data)
			end if	
		
	case 'razon'
			if (i_opciones.ast_configuracion_sello.dw_datos_firma.rowcount( ) > 0 ) then 
				i_opciones.ast_configuracion_sello.dw_datos_firma.setitem(1, 'razon', data)
			end if	

	case 'password'
			
			if (i_opciones.ast_configuracion_sello.dw_certificados.rowcount( )> 0) then 
				i = i_opciones.ast_configuracion_sello.dw_certificados.find('activo="S"',1,i_opciones.ast_configuracion_sello.dw_certificados.rowcount())
				
				if (i > 0) then 
					i_opciones.ast_configuracion_sello.dw_certificados.setitem( i, 'password', data)
				end if	
			end if
			
		
end choose
end event

type dw_pdf from u_dw within tabpage_2
integer x = 5
integer y = 36
integer width = 1819
integer height = 624
integer taborder = 11
string dataobject = "d_csd_seleccion_formato_impresion_pdf"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event buttonclicked;call super::buttonclicked;//Se abre la ventana de selecci$$HEX1$$f300$$ENDHEX$$n de directorio
nca_folderbrowse seleccion
string ruta, ls_certificado
datastore lds_datos_firmado, lds_certificados
int i, linea_certificado
//st_configuracion_sello lst_configuracion_sello
//lst_configuracion_sello.dw_certificados = create datastore
//lst_configuracion_sello.dw_configuracion_sello = create datastore
//lst_configuracion_sello.dw_datos_firma = create datastore
//lst_configuracion_sello.dw_opciones_sello = create datastore
//lst_configuracion_sello.dw_pos_sellos = create datastore
//lst_configuracion_sello.dw_certificados.dataobject = 'd_sellador_certificados'
//lst_configuracion_sello.dw_configuracion_sello.dataobject = 'd_configuracion_sello'
//lst_configuracion_sello.dw_datos_firma.dataobject = 'd_datos_firmador'
//lst_configuracion_sello.dw_opciones_sello.dataobject = 'd_textos_sellos'
//lst_configuracion_sello.dw_pos_sellos.dataobject = 'd_posiciones_sellos'

choose case dwo.name
	case 'b_rutabase'
				
		ruta = seleccion.browseforfolder( w_csd_impresion_formatos1,'Seleccione un directorio')
		
		if not f_es_vacio(ruta) then this.setitem(1,'ruta_base',ruta)

	case 'b_configuracion_sello'
		
		openwithparm(w_impresion_datos_sellado, i_opciones.ast_configuracion_sello)

//		if isvalid(message.powerobjectparm) then
if isvalid(i_opciones.ast_configuracion_sello.dw_datos_firma) and (i_opciones.ast_configuracion_sello.dw_datos_firma.rowcount( ) > 0) and (i_opciones.ast_configuracion_sello.dw_certificados.rowcount( ) > 0) then 
			
			lds_datos_firmado = create datastore
			lds_certificados = create datastore
			lds_datos_firmado.dataobject = 'd_datos_firmador'
			lds_certificados.dataobject = 'd_sellador_certificados'
			
			//lst_configuracion_sello = message.powerobjectparm
			
			lds_datos_firmado = i_opciones.ast_configuracion_sello.dw_datos_firma
			
			// Si no se han completado los datos en la configuraci$$HEX1$$f300$$ENDHEX$$n del sellado, se recogen los datos que hayan en pantalla. 
			if not f_es_vacio(lds_datos_firmado.getitemstring(lds_datos_firmado.getrow(), 'nombre')) then 
				idw_certificado.setitem( idw_certificado.getrow(), 'nombre', lds_datos_firmado.getitemstring(lds_datos_firmado.getrow(), 'nombre'))
			else
				lds_datos_firmado.setitem(lds_datos_firmado.getrow(), 'nombre', idw_certificado.getitemstring( idw_certificado.getrow(), 'nombre'))
			end if 	
			
			if not f_es_vacio(lds_datos_firmado.getitemstring(lds_datos_firmado.getrow(), 'situacion')) then 
				idw_certificado.setitem( idw_certificado.getrow(), 'situacion', lds_datos_firmado.getitemstring(lds_datos_firmado.getrow(), 'situacion'))
			else 
				lds_datos_firmado.setitem(lds_datos_firmado.getrow(), 'situacion', idw_certificado.getitemstring( idw_certificado.getrow(), 'situacion'))
			end if	
			
			if not f_es_vacio(lds_datos_firmado.getitemstring(lds_datos_firmado.getrow(), 'razon')) then 
				idw_certificado.setitem( idw_certificado.getrow(), 'razon', lds_datos_firmado.getitemstring(lds_datos_firmado.getrow(), 'razon'))
			else 
				lds_datos_firmado.setitem(lds_datos_firmado.getrow(), 'razon', idw_certificado.getitemstring( idw_certificado.getrow(), 'razon'))
			end if	

			lds_certificados = i_opciones.ast_configuracion_sello.dw_certificados
				
			i =lds_certificados.find('activo="S"',1,lds_certificados.rowcount())
			if (i > 0) then 
				idw_certificado.setitem( idw_certificado.getrow(), 'nombre_certificado', lds_certificados.getitemstring(i, 'certificado'))
				idw_certificado.setitem( idw_certificado.getrow(), 'password', lds_certificados.getitemstring(i, 'password'))
			else // No hay certificado seleccionado como activo.   
				ls_certificado = idw_certificado.getitemstring(idw_certificado.getrow(), 'certificado')
				if not f_es_vacio(ls_certificado) then //si hay certificado asignado
					linea_certificado = lds_certificados.find('certificado=" ' + ls_certificado + '"', 1, idw_certificado.rowcount())
					// si est$$HEX2$$e1002000$$ENDHEX$$
					if (linea_certificado >0) then 
						lds_certificados.setitem( linea_certificado, 'certificado', ls_certificado)
						lds_certificados.setitem( linea_certificado, 'activo', 'S')
						lds_certificados.setitem( linea_certificado, 'password', idw_certificado.GetItemString( idw_certificado.getrow(), 'password'))
					else 
						linea_certificado = lds_certificados.insertrow(0)
										
						lds_certificados.setitem( linea_certificado, 'certificado', ls_certificado)
						lds_certificados.setitem( linea_certificado, 'activo', 'S')
						lds_certificados.setitem( linea_certificado, 'password', idw_certificado.GetItemString( idw_certificado.getrow(), 'password'))
					end if
				end if	
			end if	
			
		
			
		else
			i_opciones.aplica_sellado = 'N'
		end if		
		
end choose
end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'firmar_pdf'
		if data='S' then
			idw_certificado.visible=true
			this.object.aplica_sellado.visible = true
			this.object.b_configuracion_sello.visible = true
			this.setitem(this.getrow( ), 'aplica_sellado', 'S')
			this.post event buttonclicked(1,0, idw_pdf.object.b_configuracion_sello )

		else
			idw_certificado.visible=false
			this.setitem(this.getrow( ), 'aplica_sellado', 'N')
			this.object.aplica_sellado.visible = false
			this.object.b_configuracion_sello.visible = false
		end if
		
end choose
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 1842
integer height = 1152
long backcolor = 79741120
string text = "Mail"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom025!"
long picturemaskcolor = 16777215
tab_2 tab_2
dw_mail dw_mail
end type

on tabpage_3.create
this.tab_2=create tab_2
this.dw_mail=create dw_mail
this.Control[]={this.tab_2,&
this.dw_mail}
end on

on tabpage_3.destroy
destroy(this.tab_2)
destroy(this.dw_mail)
end on

type tab_2 from tab within tabpage_3
integer x = 37
integer y = 300
integer width = 1760
integer height = 704
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on tab_2.create
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.Control[]={this.tabpage_5,&
this.tabpage_6}
end on

on tab_2.destroy
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

type tabpage_5 from userobject within tab_2
integer x = 18
integer y = 100
integer width = 1723
integer height = 588
long backcolor = 79741120
string text = "Mensaje"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
mle_mensaje mle_mensaje
end type

on tabpage_5.create
this.mle_mensaje=create mle_mensaje
this.Control[]={this.mle_mensaje}
end on

on tabpage_5.destroy
destroy(this.mle_mensaje)
end on

type mle_mensaje from multilineedit within tabpage_5
integer x = 23
integer y = 16
integer width = 1678
integer height = 556
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean border = false
boolean vscrollbar = true
end type

type tabpage_6 from userobject within tab_2
boolean visible = false
integer x = 18
integer y = 100
integer width = 1723
integer height = 588
long backcolor = 79741120
string text = "Adjuntos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_adj dw_adj
end type

on tabpage_6.create
this.dw_adj=create dw_adj
this.Control[]={this.dw_adj}
end on

on tabpage_6.destroy
destroy(this.dw_adj)
end on

type dw_adj from u_dw within tabpage_6
integer x = 9
integer y = 16
integer width = 1696
integer height = 540
integer taborder = 11
string dataobject = "d_csd_seleccion_formato_impresion_adj"
boolean ib_isupdateable = false
end type

event pfc_preinsertrow;call super::pfc_preinsertrow;n_file_dialogs uo_file
string ruta_origen,nom_doc

long retorno_ventana,i,fila
uo_file.ib_allowmultiselect = true
 
retorno_ventana = uo_file.of_getopenfilename("Seleccionar Archivo", ruta_origen, nom_doc,"", "Todos los archivos,*.*,")

if retorno_ventana = 1 then
 //Recorremos el vector de nombres de ficheros seleccionados (todos de la misma ruta)
	 for i = 1 to UpperBound(uo_file.is_selectedfiles)
		fila=this.insertrow(0)
		this.SetItem(fila,'nombre_fichero',ruta_origen+uo_file.is_selectedfiles[i])
		this.SetItem(fila,'tamanyo','0 Kb')		
	 next	
end if

return PREVENT_ACTION


end event

type dw_mail from u_dw within tabpage_3
integer x = 23
integer y = 20
integer width = 1810
integer height = 1128
integer taborder = 11
string dataobject = "d_csd_seleccion_formato_impresion_mail"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event buttonclicked;call super::buttonclicked;string id_col,email,emails,campo,n_col, email_profesional
string id_lista,notienecorreo,app,nombre,nombre_completo
long i
n_cst_string  n_string
choose case dwo.name
	case 'b_plantilla'
		string ls_filter,ls_pathname,ls_filename,ls_direc,destino
		integer li_rc,posic
		ls_filter = "Ficheros de Plantillas,*.txt"
		
		gnv_fichero.of_changedirectory(g_directorio_rtf)
		
		li_rc = GetFileOpenName("Selecciona la plantilla", &
				ls_pathname, ls_filename, "", ls_filter)
		
		if li_rc = 1 then 
			posic=LastPos(ls_pathname,'\')
			ls_direc=MidA(ls_pathname,1,posic)
			destino=ls_pathname
			if upper(ls_direc)<>upper(g_directorio_rtf) then
				MessageBox(g_titulo,"Se va a copiar la plantilla al directorio de plantillas "+g_directorio_rtf)
				destino=g_directorio_rtf+ls_filename
				gnv_fichero.of_filecopy(ls_pathname, destino, FALSE)
			end if
			this.Setitem(1,'plantilla', ls_filename)
			
		end if
		
	case 'b_direccion','b_cc','b_cco'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()
		if f_es_vacio(id_col) then return
		//Cambio introducido por Javier Osuna 31 mayo 2010
		//SCP-186
			select email_profesional into :email from colegiados where id_colegiado=:id_col;
			if f_es_vacio(email) then
				select email into :email from colegiados where id_colegiado=:id_col;
			end if
		//fin cambio
		if not(f_es_vacio(email)) then
			//Introducido por Alexis para evitar que pasen puntos y comas. 16/11/2009
			if pos(email, ';') > 0 then
				email = n_string.of_globalreplace(email, ';', ',')
			end if
			
			campo=dwo.name
			emails=this.GetITemString(1,mid(campo,3))
			if IsNull(emails) then emails=''
			if pos(emails,email)<=0 then			
				if f_es_vacio(emails) then 
					emails=email
				else
					emails+=', '+email
				end if
			end if
			this.SetItem(1,mid(campo,3),emails)
		else
			MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","El colegiado seleccionado no tiene definido email en la ficha de colegiado")
		end if
	case 'b_lista_direccion','b_lista_cc','b_lista_cco'
		Open(w_listas_seleccion)
		id_lista=Message.StringParm	
		datastore ds_lista
		ds_lista=create datastore
		ds_lista.dataobject='d_listas_miembros'
		ds_lista.SetTransObject(SQLCA)
		ds_lista.retrieve(id_lista)

		for i=1 to ds_lista.Rowcount()
			id_col=ds_lista.GetItemString(i,'id_lista_miembro')
			if f_es_vacio(id_col) then continue
			select email,apellidos,nombre,n_colegiado, email_profesional into :email,:app,:nombre,:n_col, :email_profesional from colegiados where id_colegiado=:id_col;
			email = email_profesional
			if f_es_vacio(email_profesional) then email = email
				
			if not(f_es_vacio(email)) then
			//Introducido por Alexis para evitar que pasen puntos y comas. 16/11/2009
				if pos(email, ';') > 0 then
					email = n_string.of_globalreplace(email, ';', ',')
				end if	
				
				campo=dwo.name
				emails=this.GetITemString(1,mid(campo,9))
				if IsNull(emails) then emails=''
				if pos(emails,email)<=0 then			
					if f_es_vacio(emails) then 
						emails=email
					else
						emails+=', '+email
					end if
				end if
				this.SetItem(1,mid(campo,9),emails)
			else
				nombre_completo=nombre+' '+app
				if pos(notienecorreo,nombre_completo)<=0  then notienecorreo+=n_col+' - '+nombre_completo+cr				
			end if			
		next
		if not(f_es_vacio(notienecorreo)) then		
			MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Los siguientes colegiados de la lista no tienen direcci$$HEX1$$f300$$ENDHEX$$n de correo: "+cr+notienecorreo)
		end if		
end choose
end event

event itemchanged;call super::itemchanged;if i_opciones.masivo then 
	choose case dwo.name
	
		case 'cc', 'cco'
			messagebox(g_titulo, "Tenga en cuenta que se enviar$$HEX2$$e1002000$$ENDHEX$$un correo por cada uno de los documentos que se emitan al destinatario indicado", Exclamation!, ok!)
	end choose		
end if
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 1842
integer height = 1152
long backcolor = 79741120
string text = "SMS"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom020!"
long picturemaskcolor = 536870912
dw_sms dw_sms
end type

on tabpage_4.create
this.dw_sms=create dw_sms
this.Control[]={this.dw_sms}
end on

on tabpage_4.destroy
destroy(this.dw_sms)
end on

type dw_sms from u_dw within tabpage_4
integer x = 27
integer y = 72
integer width = 1778
integer height = 944
integer taborder = 11
string dataobject = "d_csd_seleccion_formato_impresion_sms"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
end type

event editchanged;call super::editchanged;dw_sms.SetItem(row,'caracteres',len(data))
end event

event buttonclicked;call super::buttonclicked;string id_col,movil,moviles

choose case dwo.name
	case 'b_col'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()
		if f_es_vacio(id_col) then return
		select telefono_3 into :movil from colegiados where id_colegiado=:id_col;
		if not(f_es_vacio(movil)) then
			moviles=this.GetITemString(1,'movil')
			if pos(moviles,movil)<=0 then			
				if f_es_vacio(moviles) then 
					moviles=movil
				else
					moviles+=', '+movil
				end if
			end if
			this.SetItem(1,'movil',moviles)
		else
			MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","El colegiado seleccionado no tiene definido un movil en la ficha de colegiado")
		end if
end choose
end event

type cbx_papel from checkbox within w_csd_impresion_formatos1
string tag = "texto=Papel"
integer x = 178
integer y = 108
integer width = 343
integer height = 64
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Papel"
end type

type cbx_pdf from checkbox within w_csd_impresion_formatos1
integer x = 709
integer y = 108
integer width = 343
integer height = 64
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "PDF"
end type

type cbx_mail from checkbox within w_csd_impresion_formatos1
integer x = 1202
integer y = 108
integer width = 283
integer height = 64
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mail"
end type

event clicked;if cbx_mail.checked then 
	idw_pdf.object.envio_solo_a_clientes.protect = true
	idw_pdf.object.envio_solo_a_clientes.color = string(RGB(120, 120, 120))
else
	idw_pdf.object.envio_solo_a_clientes.protect = false
			idw_pdf.object.envio_solo_a_clientes.color = string(RGB(0, 0, 0))
end if 
end event

type dw_opciones from u_dw within w_csd_impresion_formatos1
integer x = 50
integer y = 1520
integer width = 1120
integer height = 328
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_csd_seleccion_formato_impresion_op"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;//MessageBox("DEBUG",this.getItemString(row,'generar_registro'))

// EL ESTADO X LO UTILIZAMOS PARA OCULTAR LA OPCION
// NO PERMITIMOS CAMBIAR A ESTE ESTADO MANUALMENTE, SOLO POR CODIGO
string serie,numero

choose case dwo.name
	case 'generar_registro'
		if data='X' then
		 this.post SetItem(row,'generar_registro','S')
		end if
	case 'serie'
		ist_rutas.serie=data
		idw_pdf.setitem(1,'ruta_base',f_reg_es_obtener_ruta_serie(ist_rutas,0))
		if not i_opciones.masivo then idw_pdf.setitem(1,'ruta_relativa',f_reg_es_obtener_ruta_serie(ist_rutas,2))
		if this.GetItemSTring(this.GetRow(),'generar_registro')='N' then
			this.SetItem(this.GetRow(),'n_reg',data+'-')
		end if
	case 'n_reg'		
		numero=data
		if IsNumber(numero) then 
			serie=this.GetItemSTring(this.GetRow(),'serie')
			this.post SetItem(1,'n_reg',	f_formatear_registro_salida(serie,numero))				
		end if
		
end choose
		
end event

type cbx_sms from checkbox within w_csd_impresion_formatos1
integer x = 1641
integer y = 112
integer width = 256
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "SMS"
end type

type gb_1 from groupbox within w_csd_impresion_formatos1
string tag = "texto=w_csd_impresion.opciones"
integer x = 59
integer y = 24
integer width = 1865
integer height = 192
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Opciones de Impresi$$HEX1$$f300$$ENDHEX$$n"
end type

