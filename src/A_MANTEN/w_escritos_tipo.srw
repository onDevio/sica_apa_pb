HA$PBExportHeader$w_escritos_tipo.srw
$PBExportComments$actas, circulares, certificados
forward
global type w_escritos_tipo from w_mant_simple
end type
type rte_1 from u_rte within w_escritos_tipo
end type
type dw_variables from u_dw within w_escritos_tipo
end type
end forward

global type w_escritos_tipo from w_mant_simple
integer x = 214
integer y = 221
integer width = 3273
integer height = 1760
string title = "Mantenimiento de Tipos de Escritos"
rte_1 rte_1
dw_variables dw_variables
end type
global w_escritos_tipo w_escritos_tipo

type variables
integer i_fila = 0, icambio=0
u_dw idw_variables
boolean i_hacer_ahora


end variables

on w_escritos_tipo.create
int iCurrent
call super::create
this.rte_1=create rte_1
this.dw_variables=create dw_variables
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rte_1
this.Control[iCurrent+2]=this.dw_variables
end on

on w_escritos_tipo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rte_1)
destroy(this.dw_variables)
end on

event pfc_save;call super::pfc_save;string cadena,caracter,codescrito,fichero
long li,ca,i,j
boolean sw

if i_fila > 0 and i_fila <= dw_1.rowcount() then 	
	codescrito= dw_1.getitemstring(i_fila,'cod_escrito')
	if FileExists(g_directorio_rtf + dw_1.getitemstring(i_fila,'ruta_rtf'))=true then
		FileDelete(g_directorio_rtf + dw_1.getitemstring(i_fila,'ruta_rtf'))
	end if
	rte_1.SaveDocument(g_directorio_rtf + dw_1.getitemstring(i_fila,'ruta_rtf'), FileTypeRichText!)	
// pasar variables	
	li=rte_1.linecount()
	DELETE FROM escritos_tipo_variables
		WHERE escritos_tipo_variables.cod_t_escrito = :codescrito ;
	for i=1 to li
		rte_1.SelectText(i,1, 0,0)
		ca=rte_1.linelength()
		for j=1 to ca
			rte_1.SelectText(i,j, i,j)
			caracter=rte_1.selectedtext()					
			if caracter=']' then
				sw=false
				INSERT INTO escritos_tipo_variables & 
					(escritos_tipos_variables.cod_t_escrito,escritos_tipos_variables.etiquetas,escritos_tipos_variables.descripcion)
				VALUES (:codescrito, :cadena, :cadena) ;
				cadena=''
			end if								
			if sw=true then
				cadena=cadena + rte_1.selectedtext()
			end if
			if caracter='[' then
				sw=true
			end if
		next
	next		
	dw_variables.retrieve(codescrito)	
end if
return 1
end event

event open;// Se ha quitado el extender ancestor scrip para que se redimensionen correctamente
// las dw's


//Scrip de la ventana pfc_w_master

Integer li_rc
This.Event pfc_preopen()
This.Post Event pfc_postopen()
If LenA (This.title) = 0 Then
	If IsValid (gnv_app.iapp_object) Then
		This.title = gnv_app.iapp_object.DisplayName
	End If
End If
If IsValid(inv_preference) Then
	If gnv_app.of_IsRegistryAvailable() Then
		If LenA(gnv_app.of_GetUserKey())> 0 Then 
			li_rc = inv_preference.of_Restore( &
				gnv_app.of_GetUserKey()+'\'+this.ClassName()+'\Preferences')
		ElseIf IsValid(gnv_app.inv_debug) Then				
			of_MessageBox ("pfc_master_open_preferenceregistrydebug", &
				"PowerBuilder Foundation Class Library", "The PFC User Preferences service" +&
				" has been requested but The UserRegistrykey property has not" +&
				" been Set on The application manager Object.~r~n~r~n" + &
  				"Call of_SetRegistryUserKey on The Application Manager" +&
				" to Set The property.", &
				Exclamation!, OK!, 1)
		End If
	Else
		If LenA(gnv_app.of_GetUserIniFile()) > 0 Then
			li_rc = inv_preference.of_Restore (gnv_app.of_GetUserIniFile(), This.ClassName()+' Preferences')
		ElseIf IsValid(gnv_app.inv_debug) Then		
			of_MessageBox ("pfc_master_open_preferenceinidebug", &
				"PowerBuilder Class Library", "The PFC User Preferences service" +&
				" has been requested but The UserINIFile property has not" +&
				" been Set on The application manager Object.~r~n~r~n" + &
  				"Call of_SetUserIniFile on The Application Manager" +&
				" to Set The property.", &
				Exclamation!, OK!, 1)		
		End If
	End If
End If
If IsValid(gnv_app.inv_mru) Then
	this.event pfc_mrurestore()
End if

//Scrip de la ventana w_mant

of_SetResize (true)
inv_resize.of_Register (dw_1, "ScaletoRight")
inv_resize.of_Register (cb_anyadir, "FixedtoBottom")
inv_resize.of_Register (cb_borrar, "FixedtoBottom")
inv_resize.of_Register (cb_ayuda, "FixedtoBottom")


//Script de la ventana Hija
idw_variables = this.dw_variables

//f_enlaza_dw(dw_1,dw_variables,'cod_escrito','cod_t_escrito')

//inv_resize.of_register (dw_1, "scaletoright&bottom")
inv_resize.of_register (idw_variables, "scaletoright&bottom")
i_hacer_ahora=false
end event

event pfc_preupdate;call super::pfc_preupdate;string cod_escrito, ejecutable, nom_dir, anyo_string
int anyo, i, fila, res, retorno=1
string mensaje 

mensaje += f_valida(dw_1,'cod_escrito','NOVACIO',g_idioma.of_getmsg('general.campo_codigo','Debe especificar un valor en el campo c$$HEX1$$f300$$ENDHEX$$digo.')+cr)
mensaje += f_valida(dw_1,'cod_tipo_escrito','NOVACIO',g_idioma.of_getmsg('general.campo_tipo_escrito','Debe especificar un valor en el tipo del escrito.')+cr)
mensaje += f_valida(dw_1,'descripcion','NOVACIO','Debe especificar un valor para la descripci$$HEX1$$f300$$ENDHEX$$n.'+cr) 
mensaje += f_valida(dw_1,'ruta_rtf','NOVACIO','Debe especificar una plantilla para este escrito .'+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'cod_escrito', fila)
			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

// Si las validaciones han ido bien, creamos los directorios en que se crear$$HEX1$$e100$$ENDHEX$$n los documentos
//	generados a partir de estas plantillas.
if retorno <> -1 then 
	for fila = 1 to dw_1.RowCount()
	
	// Al crear una plantilla crearemos los directorios en que se van a almacenar los documentos 
	// generados a partir de esa plantilla
		IF dw_1.GetItemStatus(fila, 'cod_escrito', Primary!) <> NotModified! then
			//Vbles. auxiliares
			cod_escrito = dw_1.GetItemString(fila,'cod_escrito')
			//ejecutable = g_directorio_generados + 'creo_dir.bat'
			ejecutable = 'command.com /C md'
			nom_dir = g_directorio_generados + cod_escrito
				
			// Creamos el Directorio para el C$$HEX1$$f300$$ENDHEX$$digo de la Plantilla
			Run(ejecutable + ' "' + nom_dir + '"', Minimized!)
			// Creamos los subdirectorios para los anyos dentro de ese c$$HEX1$$f300$$ENDHEX$$digo de la Plantilla 
//			anyo = Year(Today())
//			for i= 1 to 5
//				// Creamos los subdirectorios para los anyos dentro de ese c$$HEX1$$f300$$ENDHEX$$digo de la Plantilla 
//				anyo_string = '\'+string(anyo)
//				Run(ejecutable+' '+nom_dir+anyo_string, Minimized!)
//				anyo++
//			next 
		END IF
	NEXT
end if

return retorno
end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_escritos_tipo
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_escritos_tipo
end type

type dw_1 from w_mant_simple`dw_1 within w_escritos_tipo
event csd_abrir_fichero ( )
event csd_cambio_fila ( )
event csd_borrar_cod ( )
integer width = 3163
integer height = 832
string dataobject = "d_mant_escritos_tipo"
end type

event dw_1::csd_abrir_fichero();string fichero,ruta
long cancelar
integer numfilas

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02

cancelar=getfileopenname('Selecci$$HEX1$$f300$$ENDHEX$$n del fichero',ruta, fichero,"Archivos (*.RTF),*.RTF")
if cancelar = 1 then
	This.SetItem(this.getrow(),'ruta_rtf',fichero)
//else
//	this.deleterow(this.getrow())
end if

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02

end event

event dw_1::csd_borrar_cod;this.setitem(this.getrow(),'cod_escrito','')
this.setcolumn(1)
end event

event dw_1::pfc_addrow;call super::pfc_addrow;//this.PostEvent("csd_abrir_fichero")
i_hacer_ahora=true
return 1



end event

event dw_1::pfc_insertrow;call super::pfc_insertrow;//this.PostEvent("csd_abrir_fichero")
i_hacer_ahora=true
return 1
end event

event dw_1::buttonclicked;string fichero,code,cadena,fich,cod
integer aux,i

aux=row
if not f_es_vacio(this.getitemstring(row,'cod_escrito')) then
	fichero=dw_1.getitemstring(row,'ruta_rtf') 
	if f_es_vacio(fichero) then
		fichero='0' //No existe todav$$HEX1$$ed00$$ENDHEX$$a
	else
		fichero='1' //Ya existe una plantilla.
	end if
	cod=f_rellenar_ceros(8,dw_1.getitemstring(row,'cod_escrito'))
	g_rtf_paso_param.campo1='0000000011' //Codigo de la ventana que lo llama.
	g_rtf_paso_param.campo2=cod // codigo del escrito
	g_rtf_paso_param.campo4=fichero
	Open(w_certificados_rtf)
	cadena=g_rtf_paso_param.campo1
	fichero=g_rtf_paso_param.campo2	
	if cadena='S' then
		This.SetItem(row,'ruta_rtf', cod +'.rtf')
		rte_1.event pfc_clear()
		rte_1.InsertDocument(g_directorio_rtf + cod +'.rtf' , TRUE, FileTypeRichText!)			
		i_fila=row		
	else
		rte_1.event pfc_clear()		
		if f_es_vacio(fichero) then
			This.SetItem(row,'ruta_rtf', cod +'.rtf')			
			rte_1.InsertDocument(g_directorio_rtf + cod +'.rtf' , TRUE, FileTypeRichText!)						
		else
			rte_1.InsertDocument(g_directorio_rtf + fichero , TRUE, FileTypeRichText!)			
		end if
		i_fila=row	
		rte_1.modified=false
	end if
	if row > 0 then dw_variables.Retrieve(dw_1.getitemstring(row,'cod_escrito'))
else
	MessageBox(g_titulo,g_idioma.of_getmsg('general.msg_codigo_valor','El c$$HEX1$$f300$$ENDHEX$$digo de escrito debe tener un valor'))
	this.setcolumn(1)	
	return
end if

end event

event dw_1::itemchanged;call super::itemchanged;string cod
integer i
i_fila=row
choose case dwo.name
	case 'cod_escrito'
		cod=this.gettext()
		for i=1 to this.rowcount()
			if cod=this.getitemstring(i,'cod_escrito') and i <> row then
				MessageBox(g_titulo,g_idioma.of_getmsg('general.msg_duplicidad_codigos','No puede haber duplicidad de c$$HEX1$$f300$$ENDHEX$$digo'))
				//this.postevent("csd_borrar_cod")
				return 1
			end if
		next 
end choose
end event

event dw_1::rowfocuschanged;int ret
string cod_escrito

// Si no hay filas, salimos del script
if this.RowCount() <= 0 then return

if currentrow > 0 then cod_escrito =this.GetItemString(currentrow,'cod_escrito')

// Aceptamos los posibles cambios introducidos en campos sin cambiar el foco a otro campo
dw_variables.AcceptText()

ret=0
// CAmbios para dw_1
ret = dw_1.Event pfc_Updatespending()
//MessageBox(g_titulo, 'RowFocuschanged = ' + string(ret) ) 
if ret > 0 then 
	if MessageBox(g_titulo,g_idioma.of_getmsg('general.grabar_cambios', '$$HEX1$$bf00$$ENDHEX$$Desea grabar los cambios?'),Exclamation!,YesNo!) = 1 then parent.event pfc_save()
end if
ret=0
ret = dw_variables.Event pfc_Updatespending()
//MessageBox(g_titulo, 'RowFocuschanged = ' + string(ret) ) 
if ret > 0 then 
	if MessageBox(g_titulo,g_idioma.of_getmsg('general.grabar_cambiosgeneral.grabar_cambios_pdtes', 'Hay cambios pendientes en la descripci$$HEX1$$f300$$ENDHEX$$n de las variables.') +cr+ &
			g_idioma.of_getmsg('general.grabar_cambiosgeneral.grabar_cambios','$$HEX1$$bf00$$ENDHEX$$Desea grabar los cambios?'),Exclamation!,YesNo!) = 1 then dw_variables.Update()
end if

rte_1.event pfc_clear()
if currentrow > 0 then
	rte_1.InsertDocument(g_directorio_rtf + dw_1.getitemstring(currentrow,'ruta_rtf') , TRUE, FileTypeRichText!)		
end if
if currentrow > 0 then dw_variables.Retrieve(cod_escrito)

end event

event dw_1::itemerror;call super::itemerror;return 1
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_escritos_tipo
integer y = 1420
end type

event cb_anyadir::clicked;parent.event pfc_save()
dw_1.event pfc_addrow()
end event

type cb_borrar from w_mant_simple`cb_borrar within w_escritos_tipo
integer y = 1420
end type

event cb_borrar::clicked;call super::clicked;parent.postevent ("pfc_save")
end event

type cb_ayuda from w_mant_simple`cb_ayuda within w_escritos_tipo
integer y = 1420
end type

type rte_1 from u_rte within w_escritos_tipo
boolean visible = false
integer x = 384
integer y = 152
integer width = 1266
integer height = 460
integer taborder = 10
boolean bringtotop = true
end type

type dw_variables from u_dw within w_escritos_tipo
integer x = 18
integer y = 936
integer width = 3163
integer height = 448
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_mant_escritos_tipo_variables"
end type

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = False
end event

event dw_variables::itemchanged;call super::itemchanged;icambio = 1

end event

