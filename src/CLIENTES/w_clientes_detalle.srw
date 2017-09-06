HA$PBExportHeader$w_clientes_detalle.srw
forward
global type w_clientes_detalle from w_detalle
end type
type tab_1 from tab within w_clientes_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_lista_mismo_nif from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_lista_mismo_nif dw_lista_mismo_nif
end type
type tabpage_2 from userobject within tab_1
end type
type dw_clientes_terceros from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_clientes_terceros dw_clientes_terceros
end type
type tab_1 from tab within w_clientes_detalle
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_clientes_detalle from w_detalle
integer x = 64
integer width = 3653
integer height = 2328
string title = "Detalle de Terceros"
tab_1 tab_1
end type
global w_clientes_detalle w_clientes_detalle

type variables
u_dw idw_clientes_lista_mismo_nif, idw_clientes_terceros
string i_nuevo_num_cliente

end variables

on w_clientes_detalle.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_clientes_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event activate;call super::activate;g_dw_lista	= g_dw_lista_clientes 
g_w_lista   = g_lista_clientes
g_w_detalle = g_detalle_clientes
g_lista     = 'w_clientes_lista'
g_detalle   = 'w_clientes_detalle'
end event

event csd_anterior;call super::csd_anterior;if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then
	g_clientes_consulta.id_cliente = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'clientes_id_cliente')
	dw_1.event csd_retrieve()
end if
end event

event type integer csd_nuevo();call super::csd_nuevo;if AncestorReturnValue>0 then
	//Introducimos en el campo clave el valor obtenido desde el contador.
	dw_1.SetItem(dw_1.GetRow(),'id_cliente',f_siguiente_numero('CLIENTES',10))
	dw_1.SetItem(dw_1.GetRow(),'empresa',g_empresa)
	//dw_1.SetItem(dw_1.GetRow(),'tipo_persona','P')
	//dw_1.SetItem(dw_1.GetRow(),'sexo','H')
	//donde "n" es un entero que indica la longitud en caracteres del contador
	dw_1.setfocus()
end if

return AncestorReturnValue
end event

event csd_primero;call super::csd_primero;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(1)
	g_dw_lista.scrolltorow(1)
	g_clientes_consulta.id_cliente = g_dw_lista.getitemstring(1,"clientes_id_cliente")
	
	dw_1.event csd_retrieve()
end if
end event

event csd_siguiente;call super::csd_siguiente;if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then
	g_clientes_consulta.id_cliente = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'clientes_id_cliente')
	dw_1.event csd_retrieve()
end if
end event

event csd_ultimo;call super::csd_ultimo;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(g_dw_lista.rowcount())
	g_dw_lista.scrolltorow(g_dw_lista.rowcount())
	g_clientes_consulta.id_cliente = g_dw_lista.getitemstring(g_dw_lista.rowcount(),"clientes_id_cliente")
	
	dw_1.event csd_retrieve()
end if
end event

event pfc_preupdate;call super::pfc_preupdate;string mensaje='', cuenta_contable, mensaje_cuenta = ''
//control de permisos
if f_puedo_escribir(g_usuario, '0000000006')= -1 then return -1

//Validaciones del datawindows principal (dw_1)
//---------------------------------------------

//A$$HEX1$$f100$$ENDHEX$$adido por Eloy Brodin 22/04/09
// Comprobaciones de formato
u_csd_nif uo_nif
long fila
string tipo_persona

fila=dw_1.GetRow()

uo_nif.of_comprobar_documento(dw_1.GetItemString(fila,'nif'),'')
/*tipo_persona='P'
if f_es_vacio(dw_1.GetItemString(fila,'nombre')) then tipo_persona='S'
if uo_nif.of_comprobar_nif(dw_1.GetItemString(fila,'nif'),'00055',tipo_persona)=-1 then
	if messagebox(g_titulo,'Formato de NIF Incorrecto.'+cr+cr+'Ej.: 12345678Z,X1234567Z,A12345678,A1234567R'+cr+cr+"$$HEX1$$bf00$$ENDHEX$$Quieres grabar igualmente?",Question!,YesNo!) <> 1 then 
		return -1
	end if
end if
*/

//mensaje=mensaje + f_valida(dw_1,'n_cliente','NOVACIO','Debe especificar un valor en el campo n$$HEX1$$fa00$$ENDHEX$$mero de cliente')
mensaje=mensaje + f_valida(dw_1,'apellidos','NOVACIO',g_idioma.of_getmsg('msg_cliente.apellido','Debe especificar un valor en el campo apellidos'))
mensaje=mensaje + f_valida(idw_clientes_terceros,'c_tercero','NOVACIO',g_idioma.of_getmsg('msg_cliente.tipo_tercero','Debe especificar un valor en el campo tipo tercero'))

if idw_clientes_terceros.rowcount() <= 0 then
	mensaje +=  cr + g_idioma.of_getmsg('msg_cliente.espec_tipo_tercero','Debe especificar un tipo de tercero')
end if
//mensaje=mensaje + f_valida(dw_1,'nif','NOVACIO','Debe especificar un valor en el campo nif')
//mensaje=mensaje + f_valida(dw_1,'tipo_persona','NOVACIO','Debe especificar un valor en el campo tipo de persona')
//mensaje=mensaje + f_valida(dw_1,'tipo_via','NOVACIO','Debe especificar un valor en el campo tipo de via')
//mensaje=mensaje + f_valida(dw_1,'nombre_via','NOVACIO','Debe especificar un valor en el campo nombre de via')
//mensaje=mensaje + f_valida(dw_1,'cod_pob','NOVACIO','Debe especificar un valor en el campo poblaci$$HEX1$$f300$$ENDHEX$$n')
//mensaje=mensaje + f_valida(dw_1,'cod_prov','NOVACIO','Debe especificar un valor en el campo provincia')
//mensaje=mensaje + f_valida(dw_1,'cp','NOVACIO','Debe especificar un valor en el campo c$$HEX1$$f300$$ENDHEX$$digo postal')
//mensaje=mensaje + f_valida(dw_1,'pais','NOVACIO','Debe especificar un valor en el campo pa$$HEX1$$ed00$$ENDHEX$$s')

if not f_es_vacio(dw_1.getitemstring(1,'cuenta_contable')) then
	mensaje_cuenta += f_validar_cuenta(dw_1.getitemstring(1,'cuenta_contable'), 1,'')
end if

if not f_es_vacio(mensaje_cuenta) then
	mensaje += mensaje_cuenta
end if

if dw_1.getitemstring(1, 'id_cliente') = 'FICTICIO' then	mensaje += g_idioma.of_getmsg('msg_cliente.modif_colegiado_fict',"No se puede modificar el colegiado FICTICIO")

// Inicalizamos el campo empresa si no tiene valor
if f_es_vacio(dw_1.getitemstring(1,'empresa')) then
	dw_1.setitem(1, 'empresa', g_empresa)
end if

//fin
int retorno=1
if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno = -1
else
	// Avisar si existe un colegiado con el nif del tercero
	if not f_es_vacio(f_colegiado_id_colegiado(dw_1.getitemstring(1, 'nif'))) then 
		messagebox(g_titulo,g_idioma.of_getmsg('msg_cliente.duplicidad_nif',  "AVISO DUPLICIDAD DE NIF: Existe un colegiado con este nif"))
	end if
	// Avisar si los dc de la cuenta no son v$$HEX1$$e100$$ENDHEX$$lidos
	string cuenta, dc
	cuenta = dw_1.getitemstring(1, 'cuenta_bancaria')
	if LenA(cuenta) = 20 then
		dc = f_digito_control_cuenta_bancaria(MidA(cuenta,1,4),MidA(cuenta,5,4),MidA(cuenta,11,10))
		if dc <> MidA(cuenta,9,2) then messagebox(g_titulo,g_idioma.of_getmsg('msg_cliente.digitos_control', "Los d$$HEX1$$ed00$$ENDHEX$$gitos de control de la cuenta bancaria no son v$$HEX1$$e100$$ENDHEX$$lidos"))
	end if
end if

return retorno

end event

event open;call super::open;
if not(f_es_vacio(g_nif_cliente)) then

	dw_1.InsertRow(0)
	dw_1.SetItem(dw_1.RowCount(),'id_cliente',f_siguiente_numero('CLIENTES',10))
	dw_1.SetItem(dw_1.RowCount(),'nif',g_nif_cliente)
//	dw_1.SetItem(dw_1.RowCount(),'n_cliente',g_nif_cliente)
	
	dw_1.SetColumn('tipo_persona')
	//	dw_1.Object.nif.TabOrder=0
end if

idw_clientes_lista_mismo_nif = tab_1.tabpage_1.dw_lista_mismo_nif
idw_clientes_terceros = tab_1.tabpage_2.dw_clientes_terceros

f_enlaza_dw(dw_1,idw_clientes_terceros,'id_cliente','id_cliente')

inv_resize.of_Register (tab_1, "scaletoright&bottom")
inv_resize.of_register (idw_clientes_lista_mismo_nif, "scaletoright&bottom")
inv_resize.of_register (idw_clientes_terceros, "scaletoright&bottom")

dw_1.Object.DataWindow.ShowBackColorOnXP = "yes" //CBU-42


end event

event pfc_postupdate;call super::pfc_postupdate;//if not(f_es_vacio(g_nif_cliente)) and not (isnull(g_dw_fases_clientes)) then
//	g_dw_fases_clientes.SetItem(g_dw_fases_clientes.GetRow(),'id_cliente',dw_1.GetItemString(1,'id_cliente'))
//	g_dw_fases_clientes.SetItem(g_dw_fases_clientes.GetRow(),'nif',dw_1.GetItemString(1,'nif'))
//	SetNull(g_nif_cliente)
//end if
return 1
end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_clientes_detalle
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_clientes_detalle
string tag = "texto=general.guardar_pantalla"
end type

type cb_nuevo from w_detalle`cb_nuevo within w_clientes_detalle
string tag = "texto=general.nuevo"
end type

type cb_ayuda from w_detalle`cb_ayuda within w_clientes_detalle
string tag = "texto=general.ayuda"
integer x = 2597
end type

type cb_grabar from w_detalle`cb_grabar within w_clientes_detalle
string tag = "texto=general.grabar"
end type

type cb_ant from w_detalle`cb_ant within w_clientes_detalle
end type

type cb_sig from w_detalle`cb_sig within w_clientes_detalle
end type

type dw_1 from w_detalle`dw_1 within w_clientes_detalle
event modificar_nif ( )
integer x = 41
integer y = 32
integer width = 3557
integer height = 1304
string dataobject = "d_clientes_detalle"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_1::csd_retrieve;call super::csd_retrieve;if g_clientes_consulta.id_cliente = '' or isnull(g_clientes_consulta.id_cliente) then return
int    retorno
double i
retorno = parent.event closequery()
if retorno = 1 then return

this.retrieve(g_clientes_consulta.id_cliente)

g_clientes_consulta.id_cliente=''
end event

event dw_1::itemchanged;string mensaje, n_cliente, apellidos, nombre, nif, tipo_persona, sexo, observaciones, email, url, tipo_via, nombre_via
string cod_pob, cod_prov, pais, cp, telefono, fax, nif_, cod_postal, cod_provincia, cod_pais, pob, cod
long num_pob
int n_reg, opc, num_repetidos
char letra
u_csd_nif uo_nif
string nif_formateado,i_nif
mensaje = g_idioma.of_getmsg('msg_cliente.varios_nif_recuperar', 'Existen uno o m$$HEX1$$e100$$ENDHEX$$s clientes con el NIF especificado. $$HEX1$$bf00$$ENDHEX$$Desea recuperar sus datos?')

CHOOSE CASE dwo.name
	CASE 'nif'
		nif_ = string(data)
		
		if RightA(nif_, 1) = "*" then
			i_nif=left(nif_,len(nif_) - 1)
			//nif_formateado = uo_nif.of_formatear_nif(i_nif)			
			nif_formateado = uo_nif.of_comprobar_documento(i_nif,'')			
			if nif_<>nif_formateado then 
				this.post setitem(1,'nif', nif_formateado)
				nif_=nif_formateado
			end if
		else
			//nif_formateado = uo_nif.of_formatear_nif(nif_)			
			nif_formateado = uo_nif.of_comprobar_documento(nif_,'')			
		end if
		
			SELECT Count(*) INTO :n_reg  FROM clientes  WHERE clientes.nif = :nif_;

			if n_reg>0 and not(f_es_vacio(nif_)) then
				// Almacenamos aqu$$HEX2$$ed002000$$ENDHEX$$la letra que tendr$$HEX2$$e1002000$$ENDHEX$$el NIF
				letra = CharA(64+n_reg)
				// Recuperamos los clientes con el mismo NIF
			   // idw_clientes_lista_mismo_nif.retrieve(nif_)
				opc=messagebox(G_TITULO,mensaje,Exclamation!,YesNo!)
				if opc=1 then
					SELECT n_cliente, apellidos, nombre, nif, tipo_persona, sexo, observaciones, email,   
							 url, tipo_via, nombre_via, cod_pob, cod_prov, pais, cp, telefono, fax  
					INTO :n_cliente, :apellidos, :nombre, :nif, :tipo_persona, :sexo, :observaciones,   
						  :email, :url, :tipo_via, :nombre_via, :cod_pob, :cod_prov, :pais, :cp, 
						  :telefono, :fax  
					FROM clientes  
					WHERE clientes.nif = :nif_; 
			
					idw_clientes_lista_mismo_nif.retrieve(nif_,n_cliente)
					n_cliente = n_cliente+"-"+ letra
					//Rellenamos los campos con los datos almacenados
					this.setitem(this.getrow(),'n_cliente',n_cliente)
					this.setitem(this.getrow(),'apellidos',apellidos)
					this.setitem(this.getrow(),'nombre',nombre)
					this.setitem(this.getrow(),'tipo_persona',tipo_persona)
					this.setitem(this.getrow(),'sexo',sexo)
					this.setitem(this.getrow(),'observaciones',observaciones)
					this.setitem(this.getrow(),'url',url)
					this.setitem(this.getrow(),'email',email)
					this.setitem(this.getrow(),'tipo_via',tipo_via)
					this.setitem(this.getrow(),'nombre_via',nombre_via)
					this.setitem(this.getrow(),'cod_pob',cod_pob)
					this.setitem(this.getrow(),'cod_prov',cod_prov)
					this.setitem(this.getrow(),'pais',pais)
					this.setitem(this.getrow(),'cp',cp)
					this.setitem(this.getrow(),'telefono',telefono)
					this.setitem(this.getrow(),'fax',fax)
				else
					this.setitem(this.getrow(),'n_cliente',nif_+"-"+letra)
				end if
				
			else
				this.setitem(this.getrow(),'n_cliente',nif_)	
		end if

	if RightA(nif_, 1) = "*" then return 1
	// Si no hay nombre es una empresa. Si tampoco hay apellidos es que es un cliente nuevo y todavia no se han
	// rellenado los datos. En ese caso ponemos por defecto el tipo_persona=P.
/*	tipo_persona='P'	
	if f_es_vacio(dw_1.GetItemString(row,'nombre')) and not(f_es_Vacio(dw_1.GetItemString(row,'apellidos')) )then tipo_persona='S'
	if uo_nif.of_comprobar_nif(nif_,'00055',tipo_persona)=-1 then
		messagebox(g_titulo,'Formato de NIF Incorrecto.'+cr+cr+'Ej.: 12345678Z,X1234567Z,A12345678,A1234567R',Information!)
	end if	
*/



/*

		nif = data
		if RightA(nif, 1) = '*' then
			nif = f_calculo_nif(nif)
//			if nif = '-1' then return -1
		elseif RightA(nif,1) >= 'A' and RightA(nif,1) <= 'Z' then
			if not f_comprobar_nif(nif) then
				messagebox(g_titulo,g_idioma.of_getmsg('msg_cliente.letra_nif', 'La letra del NIF no es correcta'))
//				return -1
			end if
		end if
		
		if nif <> '-1' then this.post setitem(1,'nif', nif)
			nif_ = string(data)

			SELECT Count(*) INTO :n_reg  FROM clientes  WHERE clientes.nif = :nif_;

			if n_reg>0 and not(f_es_vacio(nif_)) then
				// Almacenamos aqu$$HEX2$$ed002000$$ENDHEX$$la letra que tendr$$HEX2$$e1002000$$ENDHEX$$el NIF
				letra = CharA(64+n_reg)
				// Recuperamos los clientes con el mismo NIF
			   // idw_clientes_lista_mismo_nif.retrieve(nif_)
				opc=messagebox(G_TITULO,mensaje,Exclamation!,YesNo!)
				if opc=1 then
					SELECT n_cliente, apellidos, nombre, nif, tipo_persona, sexo, observaciones, email,   
							 url, tipo_via, nombre_via, cod_pob, cod_prov, pais, cp, telefono, fax  
					INTO :n_cliente, :apellidos, :nombre, :nif, :tipo_persona, :sexo, :observaciones,   
						  :email, :url, :tipo_via, :nombre_via, :cod_pob, :cod_prov, :pais, :cp, 
						  :telefono, :fax  
					FROM clientes  
					WHERE clientes.nif = :nif_; 
			
					idw_clientes_lista_mismo_nif.retrieve(nif_,n_cliente)
					n_cliente = n_cliente+"-"+ letra
					//Rellenamos los campos con los datos almacenados
					this.setitem(this.getrow(),'n_cliente',n_cliente)
					this.setitem(this.getrow(),'apellidos',apellidos)
					this.setitem(this.getrow(),'nombre',nombre)
					this.setitem(this.getrow(),'tipo_persona',tipo_persona)
					this.setitem(this.getrow(),'sexo',sexo)
					this.setitem(this.getrow(),'observaciones',observaciones)
					this.setitem(this.getrow(),'url',url)
					this.setitem(this.getrow(),'email',email)
					this.setitem(this.getrow(),'tipo_via',tipo_via)
					this.setitem(this.getrow(),'nombre_via',nombre_via)
					this.setitem(this.getrow(),'cod_pob',cod_pob)
					this.setitem(this.getrow(),'cod_prov',cod_prov)
					this.setitem(this.getrow(),'pais',pais)
					this.setitem(this.getrow(),'cp',cp)
					this.setitem(this.getrow(),'telefono',telefono)
					this.setitem(this.getrow(),'fax',fax)
				else
					this.setitem(this.getrow(),'n_cliente',nif_+"-"+letra)
				end if
			else
				this.setitem(this.getrow(),'n_cliente',nif_)	
		end if
*/	
	CASE 'cod_pob'
		pob = data + '%'
		SELECT count(*) INTO :num_pob FROM poblaciones WHERE poblaciones.cod_pos like :pob ;
		if num_pob > 1 then
			st_busqueda_poblaciones lst_busq_pob
			lst_busq_pob.cod_postal = data
			g_busqueda.titulo='Poblaciones'
			g_busqueda.dw='d_poblaciones_lista_busqueda'
			openwithparm(w_busqueda_poblaciones,lst_busq_pob)
			cod = Message.StringParm
//			if f_es_vacio(cod) then return
//			this.post setitem(row,'cod_pob',cod)
		else
			SELECT cod_pob INTO :cod FROM poblaciones WHERE poblaciones.cod_pos like :pob   ;
		end if
			this.post setitem(row,'cod_pob',cod)
			this.setitem(row,'cp',f_devuelve_cod_postal(cod))
			this.setitem(row,'cod_prov',f_devuelve_cod_provincia(cod))
			this.setitem(row,'pais',f_devuelve_cod_pais(cod))
//		end if

	CASE 'datos_bancarios_iban'
		if (gnv_control_cuentas_bancarias.of_comprobar_iban(data) or f_es_vacio(data)) then 
			if not f_es_vacio(data) then
				data = gnv_control_cuentas_bancarias.of_eliminar_caracteres_no_validos(data)
				this.setitem(this.getrow(), 'datos_bancarios_iban', data)
			end if	
			this.setitem(row, 'cuenta_correcta', 1)
			this.object.t_iban.text = gnv_control_cuentas_bancarias.of_obtener_iban_escrito(data)
		else 
			this.object.t_iban.text = ''
			this.setitem(row, 'cuenta_correcta', 0)
			messagebox(g_titulo, 'El n$$HEX1$$fa00$$ENDHEX$$mero de cuenta no es v$$HEX1$$e100$$ENDHEX$$lido', stopsign!)
		end if	
	
	CASE 'bic'
		if not (gnv_control_cuentas_bancarias.of_comprobar_bic(data)) then 	messagebox(g_titulo, 'Revise el c$$HEX1$$f300$$ENDHEX$$digo BIC de la cuenta de cobros. No dispone de un formato correcto' + cr + 'Debe disponer de un c$$HEX1$$f300$$ENDHEX$$digo alfanum$$HEX1$$e900$$ENDHEX$$rico de ocho u once caracteres', StopSign!)			
END CHOOSE

end event

event dw_1::retrieveend;call super::retrieveend;SetPointer(Arrow!)
idw_clientes_lista_mismo_nif.retrieve(this.GetItemString(rowcount,'nif'),this.GetItemString(rowcount,'id_cliente'))
if f_comprueba_incidencias(2,dw_1) then
	dw_1.object.b_incidencias.Background.color=f_color_rojo()
else
	dw_1.object.b_incidencias.Background.color=f_color_windows_buttonface()
end if

// Modificado por ricardo 04/02/16
// Se que no es muy ortodoxo, pero es la forma m$$HEX1$$e100$$ENDHEX$$s sencilla de evitar errores....
// En el caso de que al recueperar una fila de la bbdd no tenga valor, lo que se har$$HEX2$$e1002000$$ENDHEX$$es colocarle
// el valor por defecto y grabar automaticamente ese dw unicamente
if f_es_vacio(this.getitemString(rowcount, 'irpf')) then
	this.setitem(rowcount, 'irpf', 'N')
	this.update()
end if
// FIN Modificado por ricardo 04/02/16
// Modificado por ricardo 2005-06-14
if f_es_vacio(this.getitemString(rowcount, 'visible_web')) then
	this.setitem(rowcount, 'visible_web', 'N')
	this.update()
end if
// FIN Modificado por ricardo 2005-06-14

string ls_iban

if this.rowcount() > 0 then 
	
	ls_iban = this.getitemstring( this.getrow(), 'datos_bancarios_iban')
		
	if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban) or f_es_vacio(ls_iban) then 
		this.setitem(this.getrow(), 'cuenta_correcta', 1)
		this.object.t_iban.text = gnv_control_cuentas_bancarias.of_obtener_iban_escrito(ls_iban)
	else
		this.setitem(this.getrow(), 'cuenta_correcta', 0)	
		this.object.t_iban.text = ''
	end if		
	
	this.SetItemStatus(this.getrow(), 0, Primary!, NotModified!)

end if
end event

event dw_1::doubleclicked;call super::doubleclicked;string texto
g_busqueda.solo_despliega_texto=False

CHOOSE CASE dwo.name
	CASE 'observaciones'
		g_busqueda.titulo="Observaciones"
		texto = this.GetItemString(row, 'observaciones')
		openwithparm(w_observaciones, texto)
		if Message.Stringparm <> '-1' then
			texto = Message.Stringparm
			if not isnull(texto) then this.SetItem(row,'observaciones',texto)
		end if
END CHOOSE
end event

event dw_1::itemerror;call super::itemerror;return 1
end event

event dw_1::buttonclicked;string pob,ls_cuenta
CHOOSE CASE dwo.name
	CASE 'b_incidencias'
		g_incidencias.tipo='P'
		g_incidencias.id=dw_1.getitemstring(1,'id_cliente')
		open(w_incidencias)
		if message.stringparm='S' then
			dw_1.object.b_incidencias.Background.color=f_color_rojo()
		else
			dw_1.object.b_incidencias.Background.color=f_color_windows_buttonface()
		end if		
			
	CASE 'b_poblaciones'
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(1,'cod_pob',pob)
//		this.event itemchanged(1, this.object.cod_pob, pob)
		this.setitem(row,'cp',f_devuelve_cod_postal(pob))
		this.setitem(row,'cod_prov',f_devuelve_cod_provincia(pob))
		this.setitem(row,'pais',f_devuelve_cod_pais(pob))
	
	case 'b_comprobacion_cuentas'

		ls_cuenta = this.getitemstring( row, 'datos_bancarios_iban')
		
		openwithparm(w_comprobacion_cuentas_bancarias, ls_cuenta )
		
		ls_cuenta = message.stringparm
		
		if not f_es_vacio(ls_cuenta) then
			this.setitem(row, 'datos_bancarios_iban', ls_cuenta)
			this.setitem(row, 'cuenta_correcta', 1)
			this.object.t_iban.text = gnv_control_cuentas_bancarias.of_obtener_iban_escrito(ls_cuenta)
		end if
		
		
		
	CASE ELSE
END CHOOSE


return 1

end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;string ls_iban

if dwo.name = 'datos_bancarios_iban' then
		
	ls_iban = this.getitemstring( row, 'datos_bancarios_iban')
	
	if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban) or f_es_vacio(ls_iban) then 
		this.setitem(row, 'cuenta_correcta', 1)	
	else
		this.setitem(row, 'cuenta_correcta', 0)	
	end if		
end if		
end event

event dw_1::losefocus;call super::losefocus;string ls_iban

this.accepttext()

if this.getcolumnname( ) = 'datos_bancarios_iban' then
	ls_iban = this.getitemstring( this.getrow(), 'datos_bancarios_iban')
	
	if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban) or f_es_vacio(ls_iban) then 
		this.setitem(this.getrow(), 'cuenta_correcta', 1)	
	else
		this.setitem(this.getrow(), 'cuenta_correcta', 0)	
	end if		

end if
end event

type tab_1 from tab within w_clientes_detalle
integer x = 41
integer y = 1376
integer width = 3511
integer height = 744
integer taborder = 70
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
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
string tag = "texto=clientes.clientes_mismo_nif"
integer x = 18
integer y = 112
integer width = 3474
integer height = 616
long backcolor = 79741120
string text = "Clientes con Mismo NIF"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom076!"
long picturemaskcolor = 536870912
dw_lista_mismo_nif dw_lista_mismo_nif
end type

on tabpage_1.create
this.dw_lista_mismo_nif=create dw_lista_mismo_nif
this.Control[]={this.dw_lista_mismo_nif}
end on

on tabpage_1.destroy
destroy(this.dw_lista_mismo_nif)
end on

type dw_lista_mismo_nif from u_dw within tabpage_1
integer x = 14
integer y = 16
integer width = 3387
integer height = 596
integer taborder = 11
string dataobject = "d_clientes_lista_mismo_nif"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type tabpage_2 from userobject within tab_1
string tag = "texto=clientes.tipo_tercero"
integer x = 18
integer y = 112
integer width = 3474
integer height = 616
long backcolor = 79741120
string text = "Tipo de Tercero"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Question!"
long picturemaskcolor = 536870912
dw_clientes_terceros dw_clientes_terceros
end type

on tabpage_2.create
this.dw_clientes_terceros=create dw_clientes_terceros
this.Control[]={this.dw_clientes_terceros}
end on

on tabpage_2.destroy
destroy(this.dw_clientes_terceros)
end on

type dw_clientes_terceros from u_dw within tabpage_2
integer x = 14
integer y = 16
integer width = 3474
integer height = 612
integer taborder = 11
string dataobject = "d_clientes_terceros"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event pfc_addrow;call super::pfc_addrow;this.SetItem(ancestorreturnvalue,'id',f_siguiente_numero('CLIENTES_TERCEROS',10))
return ancestorreturnvalue
end event

event pfc_insertrow;call super::pfc_insertrow;this.SetItem(ancestorreturnvalue,'id',f_siguiente_numero('CLIENTES_TERCEROS',10))
return ancestorreturnvalue
end event

