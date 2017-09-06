HA$PBExportHeader$w_impresion_datos_sellado.srw
forward
global type w_impresion_datos_sellado from w_response
end type
type tab_dir from tab within w_impresion_datos_sellado
end type
type tabpage_1 from userobject within tab_dir
end type
type dw_pos_sellos from u_dw within tabpage_1
end type
type dw_datos_firma from u_dw within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_opciones_sello from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_dir
dw_pos_sellos dw_pos_sellos
dw_datos_firma dw_datos_firma
gb_1 gb_1
dw_opciones_sello dw_opciones_sello
end type
type tabpage_2 from userobject within tab_dir
end type
type dw_certificados from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_dir
dw_certificados dw_certificados
end type
type tabpage_3 from userobject within tab_dir
end type
type dw_configuracion_sello from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_dir
dw_configuracion_sello dw_configuracion_sello
end type
type tab_dir from tab within w_impresion_datos_sellado
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type sle_certificado from singlelineedit within w_impresion_datos_sellado
end type
type gb_2 from groupbox within w_impresion_datos_sellado
end type
end forward

global type w_impresion_datos_sellado from w_response
integer x = 214
integer y = 221
integer width = 3835
integer height = 1520
string title = "Opciones de sellado"
tab_dir tab_dir
sle_certificado sle_certificado
gb_2 gb_2
end type
global w_impresion_datos_sellado w_impresion_datos_sellado

type variables
u_dw idw_opciones_sello, idw_configuracion_sello, idw_datos_sello, idw_posiciones_sello, idw_certificados

String certificado_id

st_configuracion_sello ist_configuracion_sello
end variables

forward prototypes
public subroutine wf_anyadir_menu_grabar_datos (m_dw am_dw, u_dw dw_padre)
public function string f_password ()
end prototypes

public subroutine wf_anyadir_menu_grabar_datos (m_dw am_dw, u_dw dw_padre);
long submenus, i

// Menu personalizado con la opci$$HEX1$$f300$$ENDHEX$$n de grabar los datos por defecto
m_sellador_grabar_datos menu
menu = create m_sellador_grabar_datos
menu.idw_padre = dw_padre

// Copiamos las entradas de nuestro menu a las del dw
submenus = upperbound(am_dw.m_table.item)
for i = 1 to upperbound(menu.Item)
	submenus++
	am_dw.m_table.Item[submenus] = menu.Item[i]
next
end subroutine

public function string f_password ();//Creamos un password aleatorio


int i,numero
string password = '',mascara

Randomize(0)
mascara = 'CCNNNNCC'

for i= 1 to LenA(mascara)
	if MidA(mascara,i,1) = 'C' then
		numero = Rand(25)
		numero = 65 + numero
		password = password + CharA(numero)
	else
		numero = Rand(9)
		password = password + string(numero)
	end if
next


return password
end function

on w_impresion_datos_sellado.create
int iCurrent
call super::create
this.tab_dir=create tab_dir
this.sle_certificado=create sle_certificado
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_dir
this.Control[iCurrent+2]=this.sle_certificado
this.Control[iCurrent+3]=this.gb_2
end on

on w_impresion_datos_sellado.destroy
call super::destroy
destroy(this.tab_dir)
destroy(this.sle_certificado)
destroy(this.gb_2)
end on

event open;call super::open;f_centrar_ventana(this)

if isvalid(message.powerobjectparm) then
	ist_configuracion_sello = message.powerobjectparm
end if

idw_datos_sello = tab_dir.tabpage_1.dw_datos_firma
idw_opciones_sello = tab_dir.tabpage_1.dw_opciones_sello
idw_posiciones_sello = tab_dir.tabpage_1.dw_pos_sellos
idw_certificados = tab_dir.tabpage_2.dw_certificados
idw_configuracion_sello = tab_dir.tabpage_3.dw_configuracion_sello

idw_configuracion_sello.Object.firmar_documento.visible=false
idw_configuracion_sello.Object.t_11.visible=false

idw_configuracion_sello.insertrow(0)

of_SetResize (true)
inv_resize.of_Register (tab_dir, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_datos_sello, "ScaletoBottom")
inv_resize.of_Register (idw_certificados, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_configuracion_sello, "ScaletoRight&Bottom")

end event

event pfc_postopen;string codigo_sello
int fila, i



if isvalid(ist_configuracion_sello.dw_datos_firma) and (ist_configuracion_sello.dw_datos_firma.rowcount( ) > 0) and (ist_configuracion_sello.dw_configuracion_sello.rowcount( ) > 0) then 
ist_configuracion_sello.dw_pos_sellos.RowsCopy(ist_configuracion_sello.dw_pos_sellos.GetRow(), ist_configuracion_sello.dw_pos_sellos.RowCount(), Primary!, idw_posiciones_sello, 1, Primary!)
ist_configuracion_sello.dw_datos_firma.RowsCopy(ist_configuracion_sello.dw_datos_firma.GetRow(), ist_configuracion_sello.dw_datos_firma.RowCount(), Primary!, idw_datos_sello, 1, Primary!)
ist_configuracion_sello.dw_opciones_sello.RowsCopy(ist_configuracion_sello.dw_opciones_sello.GetRow(), ist_configuracion_sello.dw_opciones_sello.RowCount(), Primary!, idw_opciones_sello, 1, Primary!)
ist_configuracion_sello.dw_certificados.RowsCopy(ist_configuracion_sello.dw_certificados.GetRow(), ist_configuracion_sello.dw_certificados.RowCount(), Primary!, idw_certificados, 1, Primary!)
ist_configuracion_sello.dw_configuracion_sello.RowsCopy(ist_configuracion_sello.dw_configuracion_sello.GetRow(), ist_configuracion_sello.dw_configuracion_sello.RowCount(), Primary!, idw_configuracion_sello, 1, Primary!)

else
	// se recupera datos de sellado. 
	f_recuperar_consulta_ventana(this, this.classname(), f_var_global('g_nombre_consulta_datos_sello_imp'))
	
	codigo_sello=idw_datos_sello.getitemstring(1,'sello')
	
	if codigo_sello<>"" then
		idw_opciones_sello.retrieve(codigo_sello)
		idw_opciones_sello.sort()
		idw_posiciones_sello.retrieve(codigo_sello)
		idw_posiciones_sello.sort()	
	end if
	
	if (g_sellador_certificado <> '' and g_sellador_password <> '') then
		sle_certificado.text = g_sellador_certificado
		fila = idw_certificados.event pfc_insertrow()
		idw_certificados.setitem(fila,'certificado',g_sellador_certificado)
		idw_certificados.setitem(fila,'password',g_sellador_password)
		for i = 1 to idw_certificados.rowcount()
			idw_certificados.setitem(i,'activo','N')
		next
		idw_certificados.setitem(fila,'activo','S')
	else
		sle_certificado.text = 'Sin sesi$$HEX1$$f300$$ENDHEX$$n iniciada'
	end if
	
	
end if

// Se ocultan elementos propios del sellador de documentos de contratos. 
idw_configuracion_sello.setitem(idw_configuracion_sello.getrow(), 'generar_zip', 'N')
idw_configuracion_sello.object.generar_zip.visible = false
idw_configuracion_sello.object.firmar_documento.visible = false
idw_configuracion_sello.object.notificar_sellado_por_email.visible = false
idw_configuracion_sello.object.t_11.visible = false
idw_configuracion_sello.object.t_10.visible = false
idw_configuracion_sello.object.t_9.visible = false
idw_configuracion_sello.object.ver_web.visible = false
idw_configuracion_sello.object.t_5.visible = false
idw_configuracion_sello.object.gb_1.visible = false

string ls_extension

if (idw_datos_sello.rowcount() > 0 ) then 
	ls_extension = idw_datos_sello.getitemstring( 1, 'extension')
	
	if f_es_vacio(ls_extension) then idw_datos_sello.setitem( 1, 'extension', g_valor_extension_docs_sellados)
		
end if 

idw_datos_sello.of_SetDropDownCalendar(True)
idw_datos_sello.iuo_calendar.of_register(idw_datos_sello.iuo_calendar.DDLB)
idw_datos_sello.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
idw_datos_sello.iuo_calendar.of_SetInitialValue(True)

idw_datos_sello.setitem(idw_datos_sello.getrow(), 'f_visado', today())

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_impresion_datos_sellado
boolean visible = true
integer x = 603
integer y = 1296
string text = "Cancelar"
end type

event cb_recuperar_pantalla::clicked;parent.event pfc_close()
end event

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_impresion_datos_sellado
boolean visible = true
integer x = 78
integer y = 1296
string text = "Aceptar"
end type

event cb_guardar_pantalla::clicked;
idw_posiciones_sello.accepttext( )
idw_datos_sello.accepttext( )
idw_opciones_sello.accepttext( )
idw_certificados.accepttext( )
idw_configuracion_sello.accepttext( )

idw_posiciones_sello.RowsCopy(idw_posiciones_sello.GetRow(), idw_posiciones_sello.RowCount(), Primary!, ist_configuracion_sello.dw_pos_sellos, 1, Primary!)
idw_datos_sello.RowsCopy(idw_datos_sello.GetRow(), idw_datos_sello.RowCount(), Primary!, ist_configuracion_sello.dw_datos_firma, 1, Primary!)
idw_opciones_sello.RowsCopy(idw_opciones_sello.GetRow(), idw_opciones_sello.RowCount(), Primary!, ist_configuracion_sello.dw_opciones_sello, 1, Primary!)
idw_certificados.RowsCopy(idw_certificados.GetRow(), idw_certificados.RowCount(), Primary!, ist_configuracion_sello.dw_certificados, 1, Primary!)
idw_configuracion_sello.RowsCopy(idw_configuracion_sello.GetRow(), idw_configuracion_sello.RowCount(), Primary!, ist_configuracion_sello.dw_configuracion_sello, 1, Primary!)

parent.event pfc_close()
end event

type tab_dir from tab within w_impresion_datos_sellado
integer x = 27
integer y = 188
integer width = 3771
integer height = 1064
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
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
tabpage_3 tabpage_3
end type

on tab_dir.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_dir.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_dir
integer x = 18
integer y = 100
integer width = 3735
integer height = 948
long backcolor = 79741120
string text = "Datos de Sellado"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_pos_sellos dw_pos_sellos
dw_datos_firma dw_datos_firma
gb_1 gb_1
dw_opciones_sello dw_opciones_sello
end type

on tabpage_1.create
this.dw_pos_sellos=create dw_pos_sellos
this.dw_datos_firma=create dw_datos_firma
this.gb_1=create gb_1
this.dw_opciones_sello=create dw_opciones_sello
this.Control[]={this.dw_pos_sellos,&
this.dw_datos_firma,&
this.gb_1,&
this.dw_opciones_sello}
end on

on tabpage_1.destroy
destroy(this.dw_pos_sellos)
destroy(this.dw_datos_firma)
destroy(this.gb_1)
destroy(this.dw_opciones_sello)
end on

type dw_pos_sellos from u_dw within tabpage_1
boolean visible = false
integer x = 293
integer y = 1500
integer width = 1074
integer taborder = 30
string dataobject = "d_posiciones_sellos"
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;//cuando se seleccione 1posicion se tienen q poner los valores en el dwconfiguracion_sello
double posx, posy, mv, mh
string activo, pos

//activo =  this.getitemstring(row, 'activo')
if data='S' then 
	pos = this.getitemstring(row, 'posicion')
	posx = this.getitemnumber(row, 'x')
	posy = this.getitemnumber(row, 'y')
	mv = this.getitemnumber(row, 'margen_vertical')
	mh = this.getitemnumber(row, 'margen_horizontal')
	idw_configuracion_sello.setitem(1, 'posicion', pos)
	idw_configuracion_sello.setitem(1, 'x', posx)
	idw_configuracion_sello.setitem(1, 'y', posy)
	idw_configuracion_sello.setitem(1, 'margen_vertical', mv)
	idw_configuracion_sello.setitem(1, 'margen_horizontal', mh)
end if
end event

event retrieveend;call super::retrieveend;long i

if  rowcount <= 0 then			 						
	this.visible = false
//	gb_3.visible = false
end if

for i=1 to rowcount
	if this.GetItemString(i,'defecto')='S' then
		this.SetItem(i,'activo','S')
		this.event itemchanged(i,this.Object.activo,'S')
		exit
	end if
next
end event

type dw_datos_firma from u_dw within tabpage_1
event csd_grabar_datos ( )
integer x = 23
integer y = 84
integer width = 1490
integer height = 808
integer taborder = 20
string dataobject = "d_datos_firmador"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event csd_grabar_datos();datetime f_visado, f_nula

if messagebox(g_titulo, "Se sobrescribir$$HEX1$$e100$$ENDHEX$$n los datos por defecto. $$HEX1$$bf00$$ENDHEX$$Seguro que desea continuar?", Question!, YesNo!, 1) = 1 then
	f_visado = idw_datos_sello.getitemdatetime(1,'f_visado')
	if not isnull(f_visado) then
		messagebox(g_titulo,'Atenci$$HEX1$$f300$$ENDHEX$$n, la fecha de visado NO se grabar$$HEX2$$e1002000$$ENDHEX$$como dato por defecto.',Information!)
		setnull(f_nula)
		idw_datos_sello.setitem(1,'f_visado',f_nula)
	end if
	f_grabar_consulta_un_dw(this,tab_dir.getparent().classname(),f_var_global('g_nombre_consulta_datos_sello_imp'))
	idw_datos_sello.setitem(1,'f_visado',f_visado)
end if
end event

event constructor;call super::constructor;this.insertRow(0)
end event

event itemchanged;call super::itemchanged;string codigo_sello

choose case dwo.name
	case 'sello'
		//tenemos q tener en cuenta ahora los 2gb y sus dws
		codigo_sello=data	
		gb_1.visible = true
	//	gb_3.visible = true
		dw_opciones_sello.visible = true
		dw_pos_sellos.visible = true		
	
		dw_opciones_sello.retrieve(codigo_sello)	
		dw_pos_sellos.retrieve(codigo_sello)


end choose
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_dash11.visible = False
am_dw.m_table.m_insert.visible = False
am_dw.m_table.m_addrow.visible = False
am_dw.m_table.m_delete.visible = False

wf_anyadir_menu_grabar_datos(am_dw, this)
end event

type gb_1 from groupbox within tabpage_1
integer x = 1728
integer y = 32
integer width = 1774
integer height = 868
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Textos"
end type

type dw_opciones_sello from u_dw within tabpage_1
integer x = 1829
integer y = 76
integer width = 1632
integer height = 804
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_textos_sellos"
boolean minbox = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event buttonclicked;call super::buttonclicked;string obser

g_busqueda.titulo="Texto Clausula"
obser    =this.GetItemString(row, 'texto')
openwithparm(w_observaciones, obser)
if Message.Stringparm <> '-1' then
	obser = Message.Stringparm
	if not isnull(obser) then 
		this.SetItem(row,'texto',obser)
	end if 	
end if
end event

event retrieveend;call super::retrieveend;if  rowcount > 0 then			 						
	this.sort()
else
	this.visible = false
	gb_1.visible = false
end if
end event

type tabpage_2 from userobject within tab_dir
integer x = 18
integer y = 100
integer width = 3735
integer height = 948
long backcolor = 79741120
string text = "Cerfificados"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_certificados dw_certificados
end type

on tabpage_2.create
this.dw_certificados=create dw_certificados
this.Control[]={this.dw_certificados}
end on

on tabpage_2.destroy
destroy(this.dw_certificados)
end on

type dw_certificados from u_dw within tabpage_2
event csd_grabar_datos ( )
integer x = 23
integer y = 32
integer width = 3680
integer height = 904
integer taborder = 11
string dataobject = "d_sellador_certificados"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event csd_grabar_datos();if messagebox(g_titulo, "Se sobrescribir$$HEX1$$e100$$ENDHEX$$n los datos por defecto. $$HEX1$$bf00$$ENDHEX$$Seguro que desea continuar?", Question!, YesNo!, 1) = 1 then
	f_grabar_consulta_un_dw(this,tab_dir.getparent().classname(),f_var_global('g_nombre_consulta_datos_sello_imp'))
end if
end event

event buttonclicked;call super::buttonclicked;string certificado
int i

choose case dwo.name
	case 'b_cert'
		openwithparm(w_certificados, this.getitemstring(row,'certificado'))
		certificado = message.stringparm
		if certificado = '' then return
		this.setitem(row,'certificado', certificado)
		for i = 1 to idw_certificados.rowcount()
			idw_certificados.setitem(i,'activo','N')
		next
		this.setitem(row,'activo', 'S')
end choose
end event

event itemchanged;call super::itemchanged;int i

//Siempre debe de haber por lo menos uno activo
choose case dwo.name
	case 'activo'
		for i = 1 to this.rowcount()
			if row <> i then 
				this.setitem(i,'activo','N')
			else
				this.post setitem(i,'activo','S')
			end if
		next
	case 'tipo'
		if data='N' then
			open(w_seleccion_certificado)
			certificado_id=Message.StringParm
			if f_es_vacio(certificado_id) then return 2
			idw_certificados.SetItem(row,'navegador',certificado_id)
		end if
end choose
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;wf_anyadir_menu_grabar_datos(am_dw, this)
end event

type tabpage_3 from userobject within tab_dir
integer x = 18
integer y = 100
integer width = 3735
integer height = 948
long backcolor = 79741120
string text = "Configuraci$$HEX1$$f300$$ENDHEX$$n"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_configuracion_sello dw_configuracion_sello
end type

on tabpage_3.create
this.dw_configuracion_sello=create dw_configuracion_sello
this.Control[]={this.dw_configuracion_sello}
end on

on tabpage_3.destroy
destroy(this.dw_configuracion_sello)
end on

type dw_configuracion_sello from u_dw within tabpage_3
event csd_actualizar_encriptar ( )
event csd_grabar_datos ( )
integer x = 23
integer y = 32
integer width = 3680
integer height = 904
integer taborder = 11
string dataobject = "d_configuracion_sello"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event csd_actualizar_encriptar();string modificacion,acceso,copia,impresion,impresion_ar,comentarios,relleno,ensamblaje
boolean contrase$$HEX1$$f100$$ENDHEX$$a
string password_pdf

modificacion = getitemstring(1,'nomodify')
acceso = getitemstring(1,'noaccess')
copia = getitemstring(1,'nocopy')
impresion = getitemstring(1,'noprint')
impresion_ar = getitemstring(1,'nohighres')
comentarios = getitemstring(1,'nonotes')
relleno = getitemstring(1,'nofill')
ensamblaje = getitemstring(1,'noassembly')

contrase$$HEX1$$f100$$ENDHEX$$a = modificacion = 'S' or acceso = 'S' or copia ='S' or impresion = 'S' or impresion_ar ='S' or comentarios = 'S' or relleno = 'S' or ensamblaje = 'S'

if contrase$$HEX1$$f100$$ENDHEX$$a then
	setitem(1,'encriptar','S')
	password_pdf = f_password()
	setitem(1,'password',password_pdf)
	setitem(1,'password2',password_pdf)
else
	setitem(1,'encriptar','N')
	setitem(1,'password','')
	setitem(1,'password2','')
end if
end event

event csd_grabar_datos();if messagebox(g_titulo, "Se sobrescribir$$HEX1$$e100$$ENDHEX$$n los datos por defecto. $$HEX1$$bf00$$ENDHEX$$Seguro que desea continuar?", Question!, YesNo!, 1) = 1 then
	f_grabar_consulta_un_dw(this,tab_dir.getparent().classname(),f_var_global('g_nombre_consulta_datos_sello_imp'))
end if
end event

event buttonclicked;call super::buttonclicked;string texto, ls_fichero_pdf,cadena
st_sello posiciones
long currentrow

choose case dwo.name
	case 'b_texto'
		g_busqueda.titulo="Texto del aviso"
		texto = this.GetItemString(row, 'texto_aviso')
		openwithparm(w_observaciones, texto)
		if Message.Stringparm <> '-1' then
			texto = Message.Stringparm
			if not isnull(texto) then 
				this.SetItem(row,'texto_aviso',texto)
			end if
		end if

end choose

end event

event constructor;call super::constructor;this.object.b_obtener.visible = false
end event

event clicked;call super::clicked;idw_configuracion_sello.AcceptText()

end event

event itemchanged;call super::itemchanged;string nulo
decimal nula


setnull(nulo)
setnull(nula)



choose case dwo.name
	case 'nomodify', 'noaccess', 'nocopy', 'noprint', 'nohighres', 'nonotes', 'nofill', 'noassembly'
		
		this.post event csd_actualizar_encriptar()
		
	case 'encriptar'
		if data = "N" then 
		 idw_configuracion_sello.SetItem(1,'password', nulo)
		 idw_configuracion_sello.SetItem(1,'password2', nulo) 
		 
		 idw_configuracion_sello.SetItem(1,'userpass', nulo)
		 idw_configuracion_sello.SetItem(1,'userpass2', nulo) 
		 
		 idw_configuracion_sello.SetItem(1,'nomodify', "N") 
		 idw_configuracion_sello.SetItem(1,'noassembly', "N") 
		 idw_configuracion_sello.SetItem(1,'nonotes', "N") 
		 idw_configuracion_sello.SetItem(1,'nofill', "N") 
		 idw_configuracion_sello.SetItem(1,'nohighres', "N") 
		 idw_configuracion_sello.SetItem(1,'nocopy', "N")  
		 idw_configuracion_sello.SetItem(1,'noaccess', "N") 
		 idw_configuracion_sello.SetItem(1,'noprint', "N") 
		 idw_configuracion_sello.SetItem(1,'habilitar_userpass', "N") 
		end if	
	case 'habilitar_userpass'
		if data = "N" then 
		 idw_configuracion_sello.SetItem(1,'userpass', nulo)
		 idw_configuracion_sello.SetItem(1,'userpass2', nulo) 
		end if
	case 'posicion'
		if data = "L" then
			idw_configuracion_sello.object.gb_margen.text='Coordenadas'			
		else
			idw_configuracion_sello.object.gb_margen.text='M$$HEX1$$e100$$ENDHEX$$rgenes'
			idw_configuracion_sello.SetItem(1,'x', nula)
			idw_configuracion_sello.SetItem(1,'y', nula)
		end if
end choose

end event

event itemerror;call super::itemerror;return 3
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_dash11.visible = False
am_dw.m_table.m_insert.visible = False
am_dw.m_table.m_addrow.visible = False
am_dw.m_table.m_delete.visible = False

wf_anyadir_menu_grabar_datos(am_dw, this)

end event

type sle_certificado from singlelineedit within w_impresion_datos_sellado
integer x = 69
integer y = 76
integer width = 3675
integer height = 64
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
boolean border = false
end type

type gb_2 from groupbox within w_impresion_datos_sellado
integer x = 32
integer y = 20
integer width = 3762
integer height = 136
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Certificado de Sesi$$HEX1$$f300$$ENDHEX$$n"
end type

