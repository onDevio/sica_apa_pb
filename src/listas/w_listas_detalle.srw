HA$PBExportHeader$w_listas_detalle.srw
forward
global type w_listas_detalle from w_detalle
end type
type cb_1 from commandbutton within w_listas_detalle
end type
type dw_miembros_listas from u_dw within w_listas_detalle
end type
type st_1 from statictext within w_listas_detalle
end type
type cb_2 from commandbutton within w_listas_detalle
end type
type cb_3 from commandbutton within w_listas_detalle
end type
type cb_cambio from commandbutton within w_listas_detalle
end type
type cb_borrar from commandbutton within w_listas_detalle
end type
type cb_4 from commandbutton within w_listas_detalle
end type
type dw_listado from u_dw within w_listas_detalle
end type
type dw_filtros from u_dw within w_listas_detalle
end type
end forward

global type w_listas_detalle from w_detalle
integer width = 3721
integer height = 1956
string title = "Detalle de Listas"
event csd_copiar_lista ( )
event csd_rellenar_listado ( )
cb_1 cb_1
dw_miembros_listas dw_miembros_listas
st_1 st_1
cb_2 cb_2
cb_3 cb_3
cb_cambio cb_cambio
cb_borrar cb_borrar
cb_4 cb_4
dw_listado dw_listado
dw_filtros dw_filtros
end type
global w_listas_detalle w_listas_detalle

type variables
u_dw idw_miembros_listas
string is_oldcolumn,i_n_col_ultimo,i_nif_cli_ultimo
boolean i_sw
end variables

event csd_copiar_lista();string id_lista,nombre_lista
datetime fecha_creacion
int hay_error=0

string princ_fecha_et, princ_sn_et, princ_num_et, obs_et, f2_et, sn2_et, textocorto2_et, num2_et
string princ_sn, obs, sn2, textocorto2, compartida, id_cliente
datetime princ_fecha, f2
double princ_num, num2

//Messagebox(g_titulo,"Este proceso duplica la lista de colegiados, pero no los datos asociados.", Information!)

fecha_creacion=datetime(today())
nombre_lista=dw_1.getitemstring(1,'nombre_lista') + ' COPIA'//El nombre lo copio a la nueva lista
id_lista=f_siguiente_numero("LISTAS_COLEGIADOS",10)//Obtengo el siguiente id de lista disponible

princ_fecha_et = dw_1.getitemstring(1,'princ_fecha')
princ_sn_et = dw_1.getitemstring(1,'princ_sn')
princ_num_et = dw_1.getitemstring(1,'princ_num')
obs_et = dw_1.getitemstring(1,'obs')
f2_et = dw_1.getitemstring(1,'f2')
sn2_et = dw_1.getitemstring(1,'sn2')
textocorto2_et = dw_1.getitemstring(1,'textocorto2')
num2_et = dw_1.getitemstring(1,'num2')
compartida = dw_1.getitemstring(1,'compartida')

INSERT INTO listas_colegiados  
         ( id_lista,   
           propietario,   
           nombre_lista,   
           fecha_creacion,   
           activa,
			  princ_fecha,
			  princ_sn,
			  princ_num,
			  obs,
			  f2,
			  sn2,
			  textocorto2,
			  num2,
			  compartida)  
  VALUES ( :id_lista,   
           :g_usuario,   
           :nombre_lista,   
           :fecha_creacion,   
           'S',
			  :princ_fecha_et,
			  :princ_sn_et,
			  :princ_num_et,
			  :obs_et,
			  :f2_et,
			  :sn2_et,
			  :textocorto2_et,
			  :num2_et,
			  :compartida)  ;//Por defecto las listas estan activas
			  
if sqlca.sqlcode=-1 then 
	hay_error=1
else
	int i
	string miembro //copio los miembros a la nueva lista
	for i=1 to dw_miembros_listas.rowcount()
  		miembro=dw_miembros_listas.getitemstring(i,'id_lista_miembro')//El nombre lo copio a la nueva lista
		princ_fecha = dw_miembros_listas.getitemdatetime(i,'princ_fecha')
		princ_sn = dw_miembros_listas.getitemstring(i,'princ_sn')
		princ_num = dw_miembros_listas.getitemnumber(i,'princ_num')
		obs = dw_miembros_listas.getitemstring(i,'obs')
		f2 = dw_miembros_listas.getitemdatetime(i,'f2')
		sn2 = dw_miembros_listas.getitemstring(i,'sn2')
		textocorto2 = dw_miembros_listas.getitemstring(i,'textocorto2')
		num2 = dw_miembros_listas.getitemnumber(i,'num2')	  
		id_cliente = dw_miembros_listas.getitemstring(i,'id_cliente')	  
	  
	  INSERT INTO listas_miembros  
         ( id_lista,   
           id_lista_miembro,
			  princ_fecha,
			  princ_sn,
			  princ_num,
			  obs,
			  f2,
			  sn2,
			  textocorto2,
			  num2,
			  id_cliente)  
  		VALUES ( :id_lista,   
           :miembro,
			  :princ_fecha,
			  :princ_sn,
			  :princ_num,
			  :obs,
			  :f2,
			  :sn2,
			  :textocorto2,
			  :num2,
			  :id_cliente)  ;
	next
	if sqlca.sqlcode=-1 then 
		hay_error=1
	end if
end if
if hay_error=0 then
	COMMIT;//Si todo ha ido bien actualizo la B.D.
	messagebox(g_titulo,g_idioma.of_getmsg('msg_listas.copiada_exito',"La lista ha sido copiada con $$HEX1$$e900$$ENDHEX$$xito"))
	g_listas_consulta.id_lista=id_lista
	dw_1.triggerevent("csd_retrieve")
else
	ROLLBACK;//Si no deshago los cambios
	messagebox(g_titulo,g_idioma.of_getmsg('msg_listas.error_copia',"Error durante la copia de la lista"))
end if

end event

event csd_rellenar_listado();// El listado no es externo pero se insertan las filas para que
// se impriman en el mismo orden en el que se estan visualizando.

long i, fila

dw_listado.reset()

// Etiquetas
dw_listado.object.t_princ_fecha.text = dw_1.getitemstring(1,'princ_fecha')
dw_listado.object.t_f2.text = dw_1.getitemstring(1,'f2')
dw_listado.object.t_princ_num.text = dw_1.getitemstring(1,'princ_num')
dw_listado.object.t_num2.text = dw_1.getitemstring(1,'num2')
dw_listado.object.t_princ_sn.text = dw_1.getitemstring(1,'princ_sn')
dw_listado.object.t_obs.text = dw_1.getitemstring(1,'obs')
dw_listado.object.t_sn2.text = dw_1.getitemstring(1,'sn2')
dw_listado.object.t_textocorto2.text = dw_1.getitemstring(1,'textocorto2')
// Modificado David - 21/03/2005
// Hay que pasarle la funci$$HEX1$$f300$$ENDHEX$$n para que no de error cuando el nombre tiene comillas
string nombre_lista
nombre_lista = dw_1.getitemstring(1,'nombre_lista')
dw_listado.object.nombre_lista.text = f_string_permitir_comillas(nombre_lista)

for i=1 to dw_miembros_listas.rowcount()
	fila = dw_listado.insertrow(0)
	// Campos
	dw_listado.setitem(fila, 'n_col', dw_miembros_listas.getitemstring(i,'n_col'))
	dw_listado.setitem(fila, 'colegiados_nombre', dw_miembros_listas.getitemstring(i,'colegiados_nombre'))
	dw_listado.setitem(fila, 'apellidos', dw_miembros_listas.getitemstring(i,'apellidos'))
	dw_listado.setitem(fila, 'nif_cli', dw_miembros_listas.getitemstring(i,'nif_cli'))
	dw_listado.setitem(fila, 'clientes_apellidos', dw_miembros_listas.getitemstring(i,'clientes_apellidos'))
	dw_listado.setitem(fila, 'clientes_nombre', dw_miembros_listas.getitemstring(i,'clientes_nombre'))
	
	dw_listado.setitem(fila, 'princ_fecha', dw_miembros_listas.getitemdatetime(i,'princ_fecha'))
	dw_listado.setitem(fila, 'f2', dw_miembros_listas.getitemdatetime(i,'f2'))
	dw_listado.setitem(fila, 'princ_num', dw_miembros_listas.getitemnumber(i,'princ_num'))
	dw_listado.setitem(fila, 'num2', dw_miembros_listas.getitemnumber(i,'num2'))
	dw_listado.setitem(fila, 'princ_sn', dw_miembros_listas.getitemstring(i,'princ_sn'))
	dw_listado.setitem(fila, 'obs', dw_miembros_listas.getitemstring(i,'obs'))
	dw_listado.setitem(fila, 'sn2', dw_miembros_listas.getitemstring(i,'sn2'))
	dw_listado.setitem(fila, 'textocorto2', dw_miembros_listas.getitemstring(i,'textocorto2'))
next

end event

on w_listas_detalle.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_miembros_listas=create dw_miembros_listas
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_cambio=create cb_cambio
this.cb_borrar=create cb_borrar
this.cb_4=create cb_4
this.dw_listado=create dw_listado
this.dw_filtros=create dw_filtros
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_miembros_listas
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.cb_cambio
this.Control[iCurrent+7]=this.cb_borrar
this.Control[iCurrent+8]=this.cb_4
this.Control[iCurrent+9]=this.dw_listado
this.Control[iCurrent+10]=this.dw_filtros
end on

on w_listas_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_miembros_listas)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_cambio)
destroy(this.cb_borrar)
destroy(this.cb_4)
destroy(this.dw_listado)
destroy(this.dw_filtros)
end on

event activate;call super::activate;g_dw_lista 	= g_dw_lista_listas
g_w_lista   = g_lista_listas
g_w_detalle = g_detalle_listas
g_lista     = 'w_listas_lista'
g_detalle   = 'w_listas_detalle'



end event

event csd_anterior();call super::csd_anterior;if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then
	g_listas_consulta.id_lista = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'id_lista')
	dw_1.event csd_retrieve()
end if

end event

event type integer csd_nuevo();call super::csd_nuevo;If AncestorReturnValue>0 then
	//Introducimos en el campo clave el valor obtenido desde el contador.
	dw_1.SetItem(dw_1.GetRow(),'id_lista',f_siguiente_numero('LISTAS_COLEGIADOS',10))
	
	//donde "n" es un entero que indica la longitud en caracteres del contador
	dw_1.setfocus()
	
	//Inicializacion de campos: f_alta, f_colegiacion a la fecha actual
	Dw_1.setitem(1, 'fecha_creacion', datetime(Today()))
	Dw_1.setitem(1, 'activa', 'S')
	Dw_1.setitem(1, 'propietario', g_usuario)
	
	dw_miembros_listas.PostEvent("csd_configura")
	
	//idw_colegiados_cesion_datos_internet.Event  pfc_addrow()
	//idw_colegiados_cesion_datos_internet.setitemstatus(1,0,Primary!,DataModified!)
end if	

return AncestorReturnValue

end event

event csd_primero;call super::csd_primero;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(1)
	g_dw_lista.scrolltorow(1)
	g_listas_consulta.id_lista = g_dw_lista.getitemstring(1,"id_lista")
	
	dw_1.event csd_retrieve()
end if
end event

event csd_siguiente;call super::csd_siguiente;if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then
	g_listas_consulta.id_lista = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'id_lista')
	dw_1.event csd_retrieve()
end if
end event

event csd_ultimo;call super::csd_ultimo;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(g_dw_lista.rowcount())
	g_dw_lista.scrolltorow(g_dw_lista.rowcount())
	g_listas_consulta.id_lista = g_dw_lista.getitemstring(g_dw_lista.rowcount(),"id_lista")
	
	dw_1.event csd_retrieve()
end if
end event

event pfc_preupdate;call super::pfc_preupdate;integer f
string mensaje='', tipo_pers = ''

if dw_1.rowcount() = 0 and dw_miembros_listas.rowcount() = 0 then return 1
if f_puedo_escribir(g_usuario, '0000000023')= -1 then return -1

//Validaciones del datawindows principal (dw_1)
mensaje=mensaje + f_valida(dw_1,'nombre_lista','NOVACIO',g_idioma.of_getmsg('msg_listas.especif_nom_lista','Debe especificar un valor en el campo Nombre Lista'))
mensaje=mensaje + f_valida(dw_1,'propietario','NOVACIO',g_idioma.of_getmsg('msg_listas.especif_propietario','Debe especificar un valor en el campo propietario'))

// Si no se ha introducido ni el cliente ni el colegiado ponemos X
// para que la clave no tenga valor nulo
int i
for i=1 to dw_miembros_listas.rowcount()
	if f_es_vacio(dw_miembros_listas.getitemstring(i,'id_lista_miembro')) then dw_miembros_listas.setitem(i,'id_lista_miembro','X')
	if f_es_vacio(dw_miembros_listas.getitemstring(i,'id_cliente')) then dw_miembros_listas.setitem(i,'id_cliente','X')
next

// Si el id_cliente y id_lista_miembro son vacios se debe borrar la fila insertada
for f=dw_miembros_listas.rowcount() to 1 step -1
	if dw_miembros_listas.getitemstring(f,'id_lista_miembro')='X' and	dw_miembros_listas.getitemstring(f,'id_cliente')='X' then 
		dw_miembros_listas.deleterow(f)
	end if
next	

// Controlamos que la lista no sea modificada sino es compartida excepto por el propietario
string propietario, id_lista, compartida
id_lista=dw_1.getitemstring(dw_1.getrow(),'id_lista')
SELECT listas_colegiados.propietario, listas_colegiados.compartida
INTO   :propietario, :compartida
FROM   listas_colegiados  
WHERE  listas_colegiados.id_lista like :id_lista   ;

if f_es_vacio(propietario)=false then
	if propietario<>g_usuario and compartida <>'S' then
		mensaje=mensaje +cr+ g_idioma.of_getmsg('msg_listas.solo_propietario_modif',"S$$HEX1$$f300$$ENDHEX$$lo el usuario propietario de la lista puede modificarla")
	end if
end if

//fin 
int retorno=1
if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if
return retorno

end event

event open;call super::open;idw_miembros_listas  = dw_miembros_listas

f_enlaza_dw(dw_1, idw_miembros_listas, 'id_lista', 'id_lista')
inv_resize.of_register (idw_miembros_listas, "scaletoright&bottom")
inv_resize.of_register (dw_filtros, "scaletoright")
inv_resize.of_register (cb_cambio, "fixedtoright")

dw_filtros.insertrow(0)


end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_listas_detalle
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_listas_detalle
string tag = "texto=general.guardar_pantalla"
integer x = 37
integer y = 1152
end type

type cb_nuevo from w_detalle`cb_nuevo within w_listas_detalle
string tag = "texto=listas.nuevo"
integer taborder = 40
end type

type cb_ayuda from w_detalle`cb_ayuda within w_listas_detalle
string tag = "texto=general.ayuda"
integer taborder = 150
end type

type cb_grabar from w_detalle`cb_grabar within w_listas_detalle
string tag = "texto=general.grabar"
integer taborder = 110
end type

type cb_ant from w_detalle`cb_ant within w_listas_detalle
integer taborder = 120
end type

type cb_sig from w_detalle`cb_sig within w_listas_detalle
integer taborder = 130
end type

type dw_1 from w_detalle`dw_1 within w_listas_detalle
event csd_campo_incorrecto ( )
integer width = 3589
integer height = 412
string dataobject = "d_listas_detalle"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_1::csd_campo_incorrecto;dw_miembros_listas.setfocus()

end event

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event dw_1::csd_retrieve;call super::csd_retrieve;if g_listas_consulta.id_lista = '' or isnull(g_listas_consulta.id_lista) then return
int    retorno
double i
retorno = parent.event closequery()

if retorno = 1 then return

this.retrieve(g_listas_consulta.id_lista)

g_listas_consulta.id_lista=''


end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;//Toma la ultima columna posicionada
is_oldcolumn=dwo.name
end event

event dw_1::getfocus;call super::getfocus;//if i_sw=true then
//	messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')	
//	this.postevent ("csd_campo_incorrecto")
//end if
end event

event dw_1::itemchanged;call super::itemchanged;dw_miembros_listas.PostEvent("csd_configura")
end event

event dw_1::retrieveend;call super::retrieveend;dw_miembros_listas.PostEvent("csd_configura")
end event

type cb_1 from commandbutton within w_listas_detalle
string tag = "texto=listas.copiar_lista"
integer x = 1106
integer y = 428
integer width = 311
integer height = 60
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Copiar Lista"
end type

event clicked;if i_sw=true then
	messagebox(g_titulo,g_idioma.of_getmsg('msg_listas.n_coleg_valido','Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.'))
	dw_1.postevent ("csd_campo_incorrecto")
else
	parent.triggerevent ("csd_copiar_lista")	
end if

end event

type dw_miembros_listas from u_dw within w_listas_detalle
event csd_configura ( )
integer x = 18
integer y = 492
integer width = 3648
integer height = 1196
integer taborder = 100
string dataobject = "d_listas_miembros"
boolean hscrollbar = true
end type

event csd_configura;string etiq
integer valor

dw_1.AcceptText()

valor=1
etiq = dw_1.GetItemString(1,'princ_fecha')
if isnull(etiq) then valor = 0
this.Object.princ_fecha.Visible = valor
this.Object.princ_fecha_t.Visible = valor
this.Object.princ_fecha_t.Text = etiq

valor=1
etiq = dw_1.GetItemString(1,'princ_sn')
if isnull(etiq) then valor = 0
this.Object.princ_sn.Visible = valor
this.Object.princ_sn_t.Visible = valor
this.Object.princ_sn_t.Text = etiq

valor=1
etiq = dw_1.GetItemString(1,'obs')
if isnull(etiq) then valor = 0
this.Object.obs.Visible = valor
this.Object.obs_t.Visible = valor
this.Object.obs_t.Text = etiq

valor=1
etiq = dw_1.GetItemString(1,'princ_num')
if isnull(etiq) then valor = 0
this.Object.princ_num.Visible = valor
this.Object.princ_num_t.Visible = valor
this.Object.princ_num_total.Visible = valor
this.Object.princ_num_t.Text = etiq

valor=1
etiq = dw_1.GetItemString(1,'f2')
if isnull(etiq) then valor = 0
this.Object.f2.Visible = valor
this.Object.f2_t.Visible = valor
this.Object.f2_t.Text = etiq

valor=1
etiq = dw_1.GetItemString(1,'sn2')
if isnull(etiq) then valor = 0
this.Object.sn2.Visible = valor
this.Object.sn2_t.Visible = valor
this.Object.sn2_t.Text = etiq

valor=1
etiq = dw_1.GetItemString(1,'textocorto2')
if isnull(etiq) then valor = 0
this.Object.textocorto2.Visible = valor
this.Object.textocorto2_t.Visible = valor
this.Object.textocorto2_t.Text = etiq

valor=1
etiq = dw_1.GetItemString(1,'num2')
if isnull(etiq) then valor = 0
this.Object.num2.Visible = valor
this.Object.num2_t.Visible = valor
this.Object.num2_total.Visible = valor
this.Object.num2_t.Text = etiq
end event

event buttonclicked;call super::buttonclicked;string id_persona, a, nulo
integer f
setnull(nulo)

choose case dwo.name
	case 'b_busqueda_colegiado'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_persona=f_busqueda_colegiados()
		if id_persona="-1" then
//			this.deleterow(row)
		else
			// Se chequea que el colegiado no este duplicado en la lista
			for f=1 to dw_miembros_listas.rowcount() 
				if dw_miembros_listas.getitemstring(f,'id_lista_miembro')=id_persona then 
					messagebox(g_titulo, g_idioma.of_getmsg('msg_listas.coleg_ya_existe','Este colegiado ya existe en la lista'))
					this.setitem(row,'id_lista_miembro', 'X')
					this.setitem(row,'apellidos', nulo)
					this.setitem(row,'colegiados_nombre', nulo)
					this.setitem(row,'n_col', nulo)
					return no_action
				end if
			end for
	
			this.setitem(row,'id_lista_miembro',id_persona)
			this.setitem(row,'n_col',f_colegiado_n_col(id_persona))
			this.setitem(row,'tipo', f_colegiado_tipopersona(this.getitemstring(this.getrow(),'id_lista_miembro')))		
			this.setitem(row,'apellidos', f_colegiado_apellido(id_persona))			
			this.setitem(row,'colegiados_nombre', nulo)
		end if

	case 'b_busqueda_cliente'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
		g_busqueda.dw="d_lista_busqueda_clientes"		
		id_persona=f_busqueda_clientes_exp()
		if f_es_vacio(id_persona) then
//			this.deleterow(row)
		else
			// Se chequea que el cliente no este duplicado en la lista
			for f=1 to dw_miembros_listas.rowcount() 
				if dw_miembros_listas.getitemstring(f,'id_cliente')=id_persona then
					messagebox(g_titulo, g_idioma.of_getmsg('msg_listas.cliente_ya_existe','Este cliente ya existe en la lista'))
					this.setitem(row,'id_cliente', nulo)
					this.setitem(row,'clientes_apellidos', nulo)
					this.setitem(row,'clientes_nombre', nulo)
					this.setitem(row,'nif_cli', nulo)
					return no_action
				end if
			end for
			
			this.setitem(row,'id_cliente',id_persona)
			this.setitem(row,'nif_cli',f_dame_nif(id_persona))
			this.setitem(row,'clientes_apellidos', f_dame_cliente(id_persona))			
			this.setitem(row,'clientes_nombre', nulo)
		end if
end choose

end event

event pfc_insertrow;call super::pfc_insertrow;//this.Triggerevent("buttonclicked")
return 1
end event

event pfc_addrow;call super::pfc_addrow;//this.Triggerevent("buttonclicked")
return 1
end event

event retrieveend;long i
string sn
for i=1 to this.rowcount()
//	this.setitem(i,'n_col', f_colegiado_n_col(this.getitemstring(i,'id_lista_miembro')))
//	this.setitem(i,'tipo', f_colegiado_tipopersona(this.getitemstring(i,'id_lista_miembro')))	
//	this.setitem(i,'apellidos', f_colegiado_apellido(this.getitemstring(i,'id_lista_miembro')))	
	sn = this.GetItemString(i,'princ_sn')
	if isnull(sn) then SetItem(i,'princ_sn','N')
	sn = this.GetItemString(i,'sn2')
	if isnull(sn) then SetItem(i,'sn2','N')
next	
this.ResetUpdate()
end event

event itemchanged;call super::itemchanged;string  id_col, col, nulo, cli, id_cli
integer f

//choose case this.getcolumnname()
setnull(nulo)
choose case dwo.name
	case 'n_col'
		// Se chequea que el codigo no este duplicado en la lista
		for f=1 to dw_miembros_listas.rowcount() 
			if dw_miembros_listas.getitemstring(f,'n_col')=data then 
				messagebox(g_titulo, g_idioma.of_getmsg('msg_listas.coleg_ya_existe','Este colegiado ya existe en la lista'))
				this.setitem(row,'id_lista_miembro', 'X')
				this.setitem(row,'apellidos', nulo)
				this.setitem(row,'colegiados_nombre', nulo)
				this.post setitem(row,'n_col', nulo)
				return no_action
			end if
		end for
		
		// se verifica que existe el colegiado en la tabla colegiados
		col=this.gettext()
		select id_colegiado into :id_col from colegiados where n_colegiado = :col;
		this.setitem(this.getrow(),'id_lista_miembro', id_col)
		this.setitem(this.getrow(),'tipo', f_colegiado_tipopersona(id_col))			
		this.setitem(this.getrow(),'apellidos', f_colegiado_apellido(id_col))			
		this.setitem(this.getrow(),'colegiados_nombre', nulo)

	case 'nif_cli'
		// Se chequea que el cliente no este duplicado en la lista
		for f=1 to dw_miembros_listas.rowcount() 
			if dw_miembros_listas.getitemstring(f,'nif_cli')=data then
				messagebox(g_titulo, g_idioma.of_getmsg('msg_listas.cliente_ya_existe','Este cliente ya existe en la lista'))
				this.setitem(row,'id_cliente', nulo)
				this.setitem(row,'clientes_apellidos', nulo)
				this.setitem(row,'clientes_nombre', nulo)
				this.post setitem(row,'nif_cli', nulo)
				return no_action
			end if
		end for
		
		// se verifica que existe el cliente en la tabla cliente
		cli=this.gettext()
		select id_cliente into :id_cli from clientes where nif = :cli;
		this.setitem(this.getrow(),'id_cliente', id_cli)
		this.setitem(this.getrow(),'clientes_apellidos', f_dame_cliente(id_cli))
		this.setitem(this.getrow(),'clientes_nombre', nulo)
end choose

end event

event itemfocuschanged;//Toma la ultima columna posicionada
is_oldcolumn=dwo.name

end event

event losefocus;string id_col, nif_cli, nulo

setnull(nulo)
i_sw=false
// se obtiene el ultimo n_col o nif_cli ingresado
if this.rowcount() > 0 then id_col = this.getitemstring(this.rowcount(),'n_col')
if this.rowcount() > 0 then nif_cli = this.getitemstring(this.rowcount(),'nif_cli')

//// se verifica que exista el ultimo colegiado antes de posicionar a otra fila
//select id_colegiado into :id_col from colegiados where n_colegiado = :i_n_col_ultimo;
//select id_cliente into :nif_cli from clientes where nif = :i_nif_cli_ultimo;

//if f_es_vacio(id_col) and f_es_vacio(nif_cli) then 
//	i_sw=true
////	messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
////	this.setfocus()
//end if	

// Se inserta un registro si se cumplen las condiciones
if KeyDown(KeyTab!) and is_oldcolumn = 'nif_cli' and (not f_es_vacio(id_col) or not f_es_vacio(nif_cli)) then
	this.event pfc_addrow()
	this.setfocus()
	this.setcolumn('n_col')
end if	

//Se asigna la ultima columna
is_oldcolumn=this.getcolumnname()

end event

event pfc_preinsertrow;call super::pfc_preinsertrow;string n_col_ultimo, id_col, n_cli_ultimo, id_cli

if this.rowcount() > 0 then
	
	n_col_ultimo = this.getitemstring(this.rowcount(),'n_col')
	n_cli_ultimo = this.getitemstring(this.rowcount(),'nif_cli')
	
	select id_colegiado into :id_col from colegiados where n_colegiado = :n_col_ultimo;
	select id_cliente into :id_cli from clientes where nif = :n_cli_ultimo;
	
	if f_es_vacio(id_col) and f_es_vacio(id_cli) then 
		messagebox(g_titulo,g_idioma.of_getmsg('msg_listas.n_coleg_nif_cliente_valido','Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado o nif de cliente v$$HEX1$$e100$$ENDHEX$$lido.'))
		this.setfocus()
		return -1
	else
		return 1	
	end if	
else
	return 1
end if
end event

event doubleclicked;string obser
if row <= 0 then return

CHOOSE CASE dwo.name
	CASE 'obs'
		g_busqueda.titulo="Observaciones"
		obser    =this.GetItemString(row, 'obs')
		openwithparm(w_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
			if not isnull(obser) then this.SetItem(row,'obs',obser)
		end if
	case ELSE
		g_colegiados_consulta.id_colegiado = this.getitemstring(row,'id_lista_miembro')
		if not isnull(g_colegiados_consulta.id_colegiado) then
			message.stringparm = "w_colegiados_detalle"
			w_aplic_frame.postevent("csd_colegiadosdetalle")
		end if
END CHOOSE

end event

event constructor;call super::constructor;this.of_SetSort(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)

// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

event clicked;//SOBREESCRITO
//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked
//
//	Description:  DataWindow clicked
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0 	Added Linkage service notification
// 6.0 	Introduced non zero return value
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

/*IF IsValid (inv_linkage) THEN
	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
		inv_linkage.CONTINUE_ACTION Then
		// The user or a service action prevents from going to the clicked row.
		Return 1
	End If
END IF
*/
IF IsValid (inv_RowSelect) THEN
	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF

end event

type st_1 from statictext within w_listas_detalle
string tag = "texto=listas.miembros_lista"
integer x = 18
integer y = 440
integer width = 791
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "Miembros de la lista"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_listas_detalle
string tag = "texto=listas.exportar_lista"
integer x = 1458
integer y = 428
integer width = 343
integer height = 60
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Exportar lista"
end type

event clicked;parent.event csd_rellenar_listado()

//dw_miembros_listas.Modify("destroy column id_lista")

dw_listado.SaveAs()

end event

type cb_3 from commandbutton within w_listas_detalle
string tag = "texto=listas.imprimir_lista"
integer x = 1851
integer y = 428
integer width = 343
integer height = 60
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir Lista"
end type

event clicked;parent.event csd_rellenar_listado()

dw_listado.print()

end event

type cb_cambio from commandbutton within w_listas_detalle
integer x = 3611
integer y = 8
integer width = 59
integer height = 404
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = ">"
end type

event clicked;if dw_filtros.visible = false then
	this.text = '<'
	dw_filtros.visible = true
else
	this.text = '>'	
	dw_filtros.visible = false	
end if
end event

type cb_borrar from commandbutton within w_listas_detalle
string tag = "texto=listas.borrar_lista"
integer x = 2258
integer y = 428
integer width = 352
integer height = 60
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Borrar Lista"
end type

event clicked;if messagebox(g_titulo, g_idioma.of_getmsg('msg_listas.seguro_eliminar','$$HEX1$$bf00$$ENDHEX$$Est$$HEX2$$e1002000$$ENDHEX$$seguro que desea eliminar esta lista?'), Question!, YesNo!) <> 1 then return
int i, filas
dw_miembros_listas.setfilter('')
dw_miembros_listas.filter()

filas = dw_miembros_listas.rowcount()
for i = filas to 1 step -1
	dw_miembros_listas.deleterow(i)
next
dw_miembros_listas.update()

dw_1.deleterow(1)
dw_1.update()
messagebox(g_titulo, g_idioma.of_getmsg('msg_listas.lista_eliminada','La lista ha sido eliminada, la ventana se cerrara en este momento'))
close(parent)

end event

type cb_4 from commandbutton within w_listas_detalle
boolean visible = false
integer x = 2761
integer y = 432
integer width = 165
integer height = 60
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;string condicion_filtro = ''
datetime f1_desde, f1_hasta, f2_desde, f2_hasta
string casilla_sn1, casilla_sn2, texto1_desde, texto1_hasta
double num1_desde, num1_hasta, num2_desde, num2_hasta

dw_filtros.accepttext()
f1_desde = dw_filtros.getitemdatetime(1, 'f1_desde')
f1_hasta = dw_filtros.getitemdatetime(1, 'f1_hasta')

f2_desde = dw_filtros.getitemdatetime(1, 'f2_desde')
f2_hasta = dw_filtros.getitemdatetime(1, 'f2_hasta')

casilla_sn1 = dw_filtros.getitemstring(1, 'sn1')

casilla_sn2 = dw_filtros.getitemstring(1, 'sn2')

num1_desde = dw_filtros.getitemnumber(1, 'num1_desde')
num1_hasta = dw_filtros.getitemnumber(1, 'num1_hasta')

num2_desde = dw_filtros.getitemnumber(1, 'num2_desde')
num2_hasta = dw_filtros.getitemnumber(1, 'num2_hasta')

texto1_desde = dw_filtros.getitemstring(1, 'texto1_desde')
texto1_hasta = dw_filtros.getitemstring(1, 'texto1_hasta')
//choose case dwo.name
//	case 'b_filtrar'

				
		if casilla_sn1 <> '%' then
			if condicion_filtro <> '' then condicion_filtro += ' and '
			condicion_filtro += "princ_sn LIKE ~~'" + string(casilla_sn1) + "%~~'"
		end if
			
		if not(f_es_vacio(texto1_HASTA)) then
			if condicion_filtro <> '' then condicion_filtro += ' and '	
			condicion_filtro += "textocorto2 LIKE '" + texto1_hasta + "%~~'"
//dw_1.setfilter("ctn like '%" + ct + "%'")			
//			dw_1.setfilter("ctn like '%" + ct + "%'")
		end if
	
//end choose
messagebox(g_idioma.of_getmsg('msg_listas.filtro','El filtro es'), condicion_filtro)
dw_miembros_listas.setfilter(condicion_filtro)
dw_miembros_listas.filter()
end event

type dw_listado from u_dw within w_listas_detalle
boolean visible = false
integer x = 800
integer y = 396
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_listas_listado"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_filtros from u_dw within w_listas_detalle
boolean visible = false
integer x = 1426
integer y = 8
integer width = 2185
integer height = 404
integer taborder = 20
string dataobject = "d_listas_consulta_filtra"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;string condicion_filtro = ''
datetime f1_desde, f1_hasta, f2_desde, f2_hasta
string casilla_sn1, casilla_sn2, texto1_desde, texto1_hasta
double num1_desde, num1_hasta, num2_desde, num2_hasta

this.accepttext()
f1_desde = this.getitemdatetime(1, 'f1_desde')
f1_hasta = this.getitemdatetime(1, 'f1_hasta')

f2_desde = this.getitemdatetime(1, 'f2_desde')
f2_hasta = this.getitemdatetime(1, 'f2_hasta')

casilla_sn1 = this.getitemstring(1, 'sn1')

casilla_sn2 = this.getitemstring(1, 'sn2')

num1_desde = this.getitemnumber(1, 'num1_desde')
num1_hasta = this.getitemnumber(1, 'num1_hasta')

num2_desde = this.getitemnumber(1, 'num2_desde')
num2_hasta = this.getitemnumber(1, 'num2_hasta')

texto1_desde = this.getitemstring(1, 'texto1_desde')
texto1_hasta = this.getitemstring(1, 'texto1_hasta')
choose case dwo.name
	case 'b_filtrar'
		if not(isnull(f1_desde)) then
			condicion_filtro += 'princ_fecha >= DateTime("' + string(f1_desde) + '")'
		end if 
		
		if not(isnull(f1_hasta)) then
			if condicion_filtro <> '' then condicion_filtro += ' and '
			condicion_filtro += 'princ_fecha <= DateTime("' + string(f1_hasta) + '")'
		end if 
		
		if not(isnull(f2_desde)) then
			if condicion_filtro <> '' then condicion_filtro += ' and '
			condicion_filtro += 'f2 >= DateTime("' + string(f2_desde) + '")'
		end if 
				
		if not(isnull(f2_hasta)) then
			if condicion_filtro <> '' then condicion_filtro += ' and '
			condicion_filtro += 'f2 <= DateTime("' + string(f2_hasta) + '")'
		end if 
				
		if casilla_sn1 <> '%' then
			if condicion_filtro <> '' then condicion_filtro += ' and '
			condicion_filtro += 'princ_sn = "' + casilla_sn1 + '"'
		end if
			
		if casilla_sn2 <> '%' then
			if condicion_filtro <> '' then condicion_filtro += ' and '	
			condicion_filtro += 'sn2 = "' + casilla_sn2		 + '"'	
		end if	
		
		if not(isnull(num1_desde)) then
			if condicion_filtro <> '' then condicion_filtro += ' and '
			condicion_filtro += 'princ_num >= ' + string(num1_desde)
		end if
		
		if not(isnull(num1_hasta)) then
			if condicion_filtro <> '' then condicion_filtro += ' and '
			condicion_filtro += 'princ_num <= ' + string(num1_hasta)
		end if
		
		if not(isnull(num2_desde)) then
			if condicion_filtro <> '' then condicion_filtro += ' and '				
			condicion_filtro += 'num2 >= ' + string(num2_desde)			
		end if

		if not(isnull(num2_hasta)) then
			if condicion_filtro <> '' then condicion_filtro += ' and '				
			condicion_filtro += 'num2 <= ' + string(num2_hasta)				
		end if		
		
		if not(f_es_vacio(texto1_desde)) then
			if condicion_filtro <> '' then condicion_filtro += ' and '	
			condicion_filtro += 'textocorto2 >= "' + string(texto1_desde) + '"'
		end if
		
		if not(f_es_vacio(texto1_hasta)) then
			if condicion_filtro <> '' then condicion_filtro += ' and '	
			condicion_filtro += 'textocorto2 <= "' + string(texto1_hasta) + '"'
		end if		
end choose
//messagebox('El filtro es', condicion_filtro)
dw_miembros_listas.setfilter(condicion_filtro)
dw_miembros_listas.filter()
end event

