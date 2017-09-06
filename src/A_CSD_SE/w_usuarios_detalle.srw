HA$PBExportHeader$w_usuarios_detalle.srw
forward
global type w_usuarios_detalle from w_detalle
end type
type tab_1 from tab within w_usuarios_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_permisos from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_permisos dw_permisos
end type
type tabpage_3 from userobject within tab_1
end type
type dw_2 from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_2 dw_2
end type
type tb_seguridad from userobject within tab_1
end type
type dw_3 from u_csd_dw within tb_seguridad
end type
type cb_desbloquear from commandbutton within tb_seguridad
end type
type tb_seguridad from userobject within tab_1
dw_3 dw_3
cb_desbloquear cb_desbloquear
end type
type tab_1 from tab within w_usuarios_detalle
tabpage_1 tabpage_1
tabpage_3 tabpage_3
tb_seguridad tb_seguridad
end type
type dw_copia_permisos from u_dw within w_usuarios_detalle
end type
type cb_copiar_perfil from commandbutton within w_usuarios_detalle
end type
end forward

global type w_usuarios_detalle from w_detalle
integer height = 2012
string title = "Detalle de Usuarios"
tab_1 tab_1
dw_copia_permisos dw_copia_permisos
cb_copiar_perfil cb_copiar_perfil
end type
global w_usuarios_detalle w_usuarios_detalle

type variables
u_dw idw_permisos, idw_copia_permisos, idw_grupos,idw_seguridad
string cod_usu
end variables

on w_usuarios_detalle.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_copia_permisos=create dw_copia_permisos
this.cb_copiar_perfil=create cb_copiar_perfil
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_copia_permisos
this.Control[iCurrent+3]=this.cb_copiar_perfil
end on

on w_usuarios_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.dw_copia_permisos)
destroy(this.cb_copiar_perfil)
end on

event activate;call super::activate;g_dw_lista = g_dw_lista_usuarios
g_w_lista = g_lista_usuarios
g_w_detalle = g_detalle_usuarios
g_lista = 'w_usuarios_lista'
g_detalle = 'w_usuarios_detalle'
end event

event open;call super::open;long    ll_found

idw_permisos = tab_1.tabpage_1.dw_permisos
idw_copia_permisos = dw_copia_permisos
idw_grupos = tab_1.tabpage_3.dw_2


f_enlaza_dw(dw_1,idw_permisos,'cod_usuario','cod_usuario')
f_enlaza_dw(dw_1,idw_grupos,'cod_usuario','cod_usuario')

//f_enlaza_dw(tab_1.tb_seguridad.dw_3,idw_permisos,'cod_usuario','cod_usuario')
inv_resize.of_Register (tab_1, "scaletobottom")
inv_resize.of_Register (idw_permisos,"ScaletoBottom")
inv_resize.of_Register (idw_grupos,"ScaletoBottom")



end event

event csd_nuevo;call super::csd_nuevo;If AncestorReturnVAlue>0 then
	dw_1.SetItem(dw_1.GetRow(),'cod_usuario',f_siguiente_numero('USUARIOS',10))
	dw_1.SetItem(dw_1.GetRow(),'t_usuario_cod_tipo_idioma',g_idioma_defecto)
	dw_1.SetFocus()
end if

return AncestorReturnVAlue
end event

event csd_anterior;call super::csd_anterior;if g_dw_lista.RowCount() > 0 then
	g_usuarios_consulta.cod_usuario = g_dw_lista.GetItemString(g_dw_lista.GetRow(),'cod_usuario')
	dw_1.Event csd_retrieve()
end if	
end event

event csd_siguiente;call super::csd_siguiente;if g_dw_lista.RowCount() > 0 then
	g_usuarios_consulta.cod_usuario = g_dw_lista.GetItemString(g_dw_lista.GetRow(),'cod_usuario')
	dw_1.Event csd_retrieve()
end if	
end event

event csd_primero;call super::csd_primero;if not isvalid(g_dw_lista) then return

if g_dw_lista.RowCount() > 0 then
	g_dw_lista.SetRow(1)
	g_dw_lista.Scrolltorow(1)
	g_usuarios_consulta.cod_usuario = g_dw_lista.GetItemString(1,'cod_usuario')
	dw_1.Event csd_retrieve()
end if	
end event

event csd_ultimo;call super::csd_ultimo;if not isvalid(g_dw_lista) then return

if g_dw_lista.RowCount() > 0 then
	g_dw_lista.SetRow(g_dw_lista.RowCount())
	g_dw_lista.Scrolltorow(g_dw_lista.RowCount())
	g_usuarios_consulta.cod_usuario = g_dw_lista.GetItemString(g_dw_lista.RowCount(),'cod_usuario')
	dw_1.Event csd_retrieve()
end if	
end event

event pfc_preupdate;call super::pfc_preupdate;integer i, j
string usuario, aplicacion

if f_puedo_escribir(g_usuario,'0000000022')=-1 then return -1

//VALIDACIONES

string mensaje=''

//Datos principales del usuario
//Nombre
mensaje = mensaje + f_valida(dw_1,'nombre_usuario','NONULO','Debe tener un nombre.')
//Login
mensaje = mensaje + f_valida(dw_1,'login','NONULO','Debe tener un login.')
//Password
mensaje = mensaje + f_valida(dw_1,'password','NONULO','Debe tener un password.')


//Validamos que no haya colegiados asociados a m$$HEX1$$e100$$ENDHEX$$s de un usuario
string ls_idcol, ls_usu
integer li_count

ls_idcol=dw_1.getitemstring(dw_1.getrow(),'id_col')
ls_usu=dw_1.getitemstring(dw_1.getrow(),'cod_usuario')

if not f_es_vacio(ls_idcol) then 
	select count(*) into :li_count from t_usuario where id_col=:ls_idcol and cod_usuario<>:ls_usu ;
end if

if li_count>0 then
	mensaje+=cr+"El colegiado ya est$$HEX2$$e1002000$$ENDHEX$$asociado a otro usuario. Cambie el colegiado."
end if
//Javier Osuna 02/06/2010
//comprobamos que el login no es duplicado SCP-360
string log_col
int n_login
log_col=dw_1.getitemstring(1, 'login')
SELECT count(t_usuario.login)
 INTO :n_login
 FROM t_usuario  
 WHERE t_usuario.login = :log_col   and t_usuario.cod_usuario<>:ls_usu; 
 if n_login>0 then
		mensaje = mensaje + cr + "Login duplicado,escriba otro login para este usuario"
end if



//Datos de los permisos
if tab_1.tabpage_1.visible = true then
	mensaje = mensaje + f_valida(idw_permisos,'cod_aplicacion','NOVACIO','Debe de especificar una aplicacion sobre la que tendr$$HEX2$$e1002000$$ENDHEX$$efecto el permiso')
	//Comprobamos si existen duplicados
	for i=1 to idw_permisos.RowCount()
     	if f_busca_duplicados_colum_dw(idw_permisos,'cod_aplicacion',i) <> 0 then
			mensaje = mensaje + cr + 'Existen permisos duplicados.'
			exit
		end if	
	next 
end if

int retorno = 1

if mensaje<>'' then
   MessageBox(g_titulo,mensaje,StopSign!)
 	retorno = -1
else
	// Actualizamos el password (si se ha modificado) en la clave de acceso de la ficha del colegiado (s$$HEX1$$f300$$ENDHEX$$lo Guip$$HEX1$$fa00$$ENDHEX$$zcoa)
	if g_colegio = 'COAATGUI' then
		string id_col, clave, passw
		id_col = dw_1.getitemstring(1, 'id_col')
		passw = dw_1.getitemstring(1, 'password')
		SELECT otros_datos_colegiado.texto  
    	INTO :clave  
    	FROM otros_datos_colegiado  
   	WHERE ( otros_datos_colegiado.id_colegiado = :id_col ) AND  
      		( otros_datos_colegiado.cod_caracteristica = '05' )   ;

		IF sqlca.SQLNRows > 0 THEN
			if passw <> clave then
				UPDATE otros_datos_colegiado  
     			SET texto = :passw  
	   		WHERE ( otros_datos_colegiado.cod_caracteristica = '05' ) AND  
         			( otros_datos_colegiado.id_colegiado = :id_col )   ;
			end if	
		END IF
	end if
end if

return retorno
	
end event

event pfc_postopen;call super::pfc_postopen;string  permiso

//Verifica si el usuario que entra tiene el permiso para visualizar el password
  SELECT t_permisos.permiso  
    INTO :permiso  
    FROM t_permisos  
   WHERE ( t_permisos.cod_usuario = :g_usuario ) AND  
         ( t_permisos.cod_aplicacion ='PERM_PASSW'   )   ;

if permiso <> '' and not isnull(permiso)  then
	dw_1.Modify("password.Edit.Password=no")
	dw_1.Modify("password.Format='[General];'None''")
end if
end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_usuarios_detalle
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_usuarios_detalle
end type

type cb_nuevo from w_detalle`cb_nuevo within w_usuarios_detalle
end type

type cb_ayuda from w_detalle`cb_ayuda within w_usuarios_detalle
end type

type cb_grabar from w_detalle`cb_grabar within w_usuarios_detalle
end type

type cb_ant from w_detalle`cb_ant within w_usuarios_detalle
end type

type cb_sig from w_detalle`cb_sig within w_usuarios_detalle
end type

type dw_1 from w_detalle`dw_1 within w_usuarios_detalle
integer x = 23
integer y = 8
integer width = 2688
integer height = 604
string dataobject = "d_usuarios"
end type

event dw_1::csd_retrieve;call super::csd_retrieve;idw_seguridad = tab_1.tb_seguridad.dw_3
if g_usuarios_consulta.cod_usuario = '' or isnull(g_usuarios_consulta.cod_usuario) then return

int retorno
retorno = parent.event closequery()
if retorno = 1 then return
this.retrieve(g_usuarios_consulta.cod_usuario)
idw_seguridad.retrieve(g_usuarios_consulta.cod_usuario)
cod_usu =g_usuarios_consulta.cod_usuario 
g_usuarios_consulta.cod_usuario = ''
end event

event dw_1::buttonclicked;call super::buttonclicked;string id_cole

//Introducimos el c$$HEX1$$f300$$ENDHEX$$digo necesario para hacer una b$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida
g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
g_busqueda.dw="d_lista_busqueda_colegiados"
id_cole=f_busqueda_colegiados()
if f_es_vacio(id_cole) then return
this.setitem(row,'id_col',id_cole)
this.setitem(row,'n_col',f_colegiado_n_col(id_cole))
this.setitem(row,'nombre_usuario',f_colegiado_apellido(id_cole))
end event

event dw_1::itemchanged;call super::itemchanged;string id_col
string log_col
int n_login
choose case dwo.name
	case 'n_col'
		id_col = f_colegiado_id_col(data)
		this.SetItem(row,'id_col', id_col)
		this.setitem(row,'nombre_usuario',f_colegiado_apellido(id_col))
		
 		 
end choose

end event

type tab_1 from tab within w_usuarios_detalle
integer x = 23
integer y = 620
integer width = 2679
integer height = 1184
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
tabpage_3 tabpage_3
tb_seguridad tb_seguridad
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_3=create tabpage_3
this.tb_seguridad=create tb_seguridad
this.Control[]={this.tabpage_1,&
this.tabpage_3,&
this.tb_seguridad}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_3)
destroy(this.tb_seguridad)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2642
integer height = 1068
long backcolor = 79741120
string text = "Permisos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_permisos dw_permisos
end type

on tabpage_1.create
this.dw_permisos=create dw_permisos
this.Control[]={this.dw_permisos}
end on

on tabpage_1.destroy
destroy(this.dw_permisos)
end on

type dw_permisos from u_dw within tabpage_1
integer x = 18
integer y = 24
integer width = 2597
integer height = 1024
integer taborder = 11
string dataobject = "d_permisos"
end type

event pfc_addrow;call super::pfc_addrow;string usuario

usuario=dw_1.GetItemString(1,'cod_usuario')
idw_permisos.SetItem(this.GetRow(),'cod_usuario',usuario)
return 1
end event

event pfc_insertrow;call super::pfc_insertrow;string usuario

usuario=dw_1.GetItemString(1,'cod_usuario')
idw_permisos.SetItem(this.GetRow(),'cod_usuario',usuario)
return 1
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2642
integer height = 1068
long backcolor = 79741120
string text = "Grupos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_3.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_3.destroy
destroy(this.dw_2)
end on

type dw_2 from u_dw within tabpage_3
integer x = 18
integer y = 24
integer width = 2597
integer height = 1024
integer taborder = 10
string dataobject = "d_usuario_grupos"
end type

event pfc_addrow;call super::pfc_addrow;this.SetItem(this.GetRow(),'cod_usuario',dw_1.GetItemString(dw_1.GetRow(),'cod_usuario'))
return ancestorreturnvalue
end event

event type long pfc_insertrow();call super::pfc_insertrow;this.SetItem(this.GetRow(),'cod_usuario',dw_1.GetItemString(dw_1.GetRow(),'cod_usuario'))
return ancestorreturnvalue
end event

type tb_seguridad from userobject within tab_1
string tag = "texto=general.seguridad"
integer x = 18
integer y = 100
integer width = 2642
integer height = 1068
long backcolor = 79741120
string text = "Seguridad"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_3 dw_3
cb_desbloquear cb_desbloquear
end type

on tb_seguridad.create
this.dw_3=create dw_3
this.cb_desbloquear=create cb_desbloquear
this.Control[]={this.dw_3,&
this.cb_desbloquear}
end on

on tb_seguridad.destroy
destroy(this.dw_3)
destroy(this.cb_desbloquear)
end on

type dw_3 from u_csd_dw within tb_seguridad
integer x = 18
integer y = 144
integer width = 2597
integer height = 904
integer taborder = 11
string dataobject = "d_usuarios_seguridad"
end type

type cb_desbloquear from commandbutton within tb_seguridad
integer x = 23
integer y = 28
integer width = 731
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Desbloquear Usuario"
end type

event clicked;string l_usuario
integer l_esta_bloqueado

l_usuario = dw_1.getitemstring(1,'login')

select n_fallos into :l_esta_bloqueado from t_usuario where login =:l_usuario;

if (l_esta_bloqueado = 3) then
update t_usuario set n_fallos =0 where login =:l_usuario;
COMMIT;
MessageBox(g_titulo,'Se ha desbloqueado el usuario correctamente.')
idw_seguridad.retrieve(cod_usu)
else
	MessageBox(g_titulo,'Este usuario no est$$HEX2$$e1002000$$ENDHEX$$bloqueado')
end if
end event

type dw_copia_permisos from u_dw within w_usuarios_detalle
boolean visible = false
integer x = 2747
integer y = 428
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_permisos"
end type

type cb_copiar_perfil from commandbutton within w_usuarios_detalle
integer x = 2715
integer y = 672
integer width = 402
integer height = 80
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Copiar Perfil"
end type

event clicked;string usuario, codigo_usuario
int i,j

usuario=dw_1.getitemstring(1,1)
if isnull(usuario) or usuario='' then 
	messagebox(g_titulo, "Primero debe seleccionar el usuario.")
	return 0
end if
parent.event closequery()
open(w_copiar_perfil)

if not(isnull(message.stringparm)) and message.stringparm<>usuario then
	parent.event closequery()
	codigo_usuario = message.stringparm
	
	idw_copia_permisos.retrieve(codigo_usuario)
	for i=idw_copia_permisos.rowcount() to 1 step -1
		idw_copia_permisos.deleterow(i)
	next

	for i=1 to idw_permisos.rowcount()
		j=idw_copia_permisos.insertrow(0)
		idw_copia_permisos.setitem(j,'cod_usuario',codigo_usuario)
		idw_copia_permisos.setitem(j,'cod_aplicacion',idw_permisos.getitemstring(i,'cod_aplicacion'))
		idw_copia_permisos.setitem(j,'permiso',idw_permisos.getitemstring(i,'permiso'))
	next	
		
					
end if
end event

