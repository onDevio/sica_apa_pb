HA$PBExportHeader$w_regsoc_detalle.srw
forward
global type w_regsoc_detalle from w_detalle
end type
type tab_1 from tab within w_regsoc_detalle
end type
type tabpage_3 from userobject within tab_1
end type
type dw_4 from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_4 dw_4
end type
type tabpage_2 from userobject within tab_1
end type
type dw_3 from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_3 dw_3
end type
type tabpage_1 from userobject within tab_1
end type
type dw_actividades from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_actividades dw_actividades
end type
type tabpage_5 from userobject within tab_1
end type
type dw_5 from u_dw within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_5 dw_5
end type
type tabpage_4 from userobject within tab_1
end type
type dw_anexos from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_anexos dw_anexos
end type
type tab_1 from tab within w_regsoc_detalle
tabpage_3 tabpage_3
tabpage_2 tabpage_2
tabpage_1 tabpage_1
tabpage_5 tabpage_5
tabpage_4 tabpage_4
end type
type dw_numero from u_dw within w_regsoc_detalle
end type
type dw_2 from u_dw within w_regsoc_detalle
end type
type dw_razon from u_dw within w_regsoc_detalle
end type
end forward

global type w_regsoc_detalle from w_detalle
integer width = 4462
integer height = 2868
string title = "Detalle Registro Sociedades"
tab_1 tab_1
dw_numero dw_numero
dw_2 dw_2
dw_razon dw_razon
end type
global w_regsoc_detalle w_regsoc_detalle

type variables
u_dw idw_actividades,idw_socios,idw_agenda,idw_sancion,idw_anexos
end variables

forward prototypes
public function string f_regsoc_dw_dinamico ()
end prototypes

public function string f_regsoc_dw_dinamico ();string ls_dw_syntax

select descripcion into :ls_dw_syntax from var_globales where nombre='regsoc_syntax';

	
return ls_dw_syntax
end function

on w_regsoc_detalle.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_numero=create dw_numero
this.dw_2=create dw_2
this.dw_razon=create dw_razon
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_numero
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_razon
end on

on w_regsoc_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.dw_numero)
destroy(this.dw_2)
destroy(this.dw_razon)
end on

event open;call super::open;g_dw_lista  = g_dw_lista_regsoc
g_w_lista   = g_lista_regsoc
g_w_detalle = g_detalle_regsoc
g_lista     = 'w_regsoc_lista'
g_detalle   = 'w_regsoc_detalle'

//A partir de aqui se pueden introducir las funciones de cambios de tama#o y
//posicion de los controles de la ventana.

if g_modo_funcionamiento<>'1' then //cambiamos el dw de socios
 tab_1.tabpage_2.dw_3.dataobject='d_regsoc_socios'
 tab_1.tabpage_2.dw_3.settransobject(sqlca)	
end if

idw_actividades = tab_1.tabpage_1.dw_actividades
idw_socios =tab_1.tabpage_2.dw_3
idw_agenda=tab_1.tabpage_3.dw_4
idw_sancion=tab_1.tabpage_5.dw_5
idw_anexos=tab_1.tabpage_4.dw_anexos

inv_resize.of_register (tab_1, "scaletoRight&Bottom")
inv_resize.of_register (tab_1.tabpage_1, "scaletoright&bottom")
inv_resize.of_register (idw_actividades, "scaletoright&bottom")
inv_resize.of_register (idw_socios, "scaletoright&bottom")
inv_resize.of_register (idw_agenda, "scaletoright&bottom")
inv_resize.of_register (idw_sancion, "scaletoright&bottom")
inv_resize.of_register (idw_anexos, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_2, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_3, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_4, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_5, "scaletoright&bottom")

string ls_dw_syntax,ls_dw_err


f_enlaza_dw(dw_1, dw_numero, 'id_regsoc', 'id_regsoc')
f_enlaza_dw(dw_1, dw_2, 'id_regsoc', 'regsoc_id_regsoc')
f_enlaza_dw(dw_1, dw_razon, 'id_regsoc', 'id_regsoc')
f_enlaza_dw(dw_1, idw_actividades, 'id_regsoc', 'id_regsoc')

if g_modo_funcionamiento<>'1' then
	f_enlaza_dw(dw_1, idw_socios, 'id_regsoc', 'id_regsoc')
else
	f_enlaza_dw(dw_1, idw_socios, 'id_colegiado_sociedad', 'id_colegiado_sociedad')
end if

f_enlaza_dw(dw_1, idw_agenda, 'id_regsoc', 'id_regsoc')
f_enlaza_dw(dw_1, idw_sancion, 'id_regsoc', 'id_regsoc')
f_enlaza_dw(dw_1, idw_anexos, 'id_regsoc', 'ubicacion')
//string vari
//vari=dw_2.object.datawindow.syntax
// descomentar para guardar en variable el datawindow dw_2
//insert into var_globales(nombre,descripcion) values ('prueba',:vari);
// RYC 2008
if g_modo_funcionamiento='1' then   
	// SI ESTA ENLAZADO CON SOCIOS
   dw_razon.visible=false
else   
	dw_2.visible=false
end if
		

end event

event csd_nuevo;call super::csd_nuevo;string ls_numero
ls_numero=f_siguiente_numero('REGSOC',10)
//Introducimos en el campo clave el valor obtenido desde el contador.
// RYC 2008
// INSERTAMOS LAS LINEAS
dw_1.SetItem(dw_1.GetRow(),'id_regsoc',ls_numero)
dw_numero.event pfc_addrow()
dw_numero.setitem(dw_numero.getrow(),'id_regsoc',ls_numero)

if g_modo_funcionamiento='1' then
	// SI ESTA ENLAZADO CON SOCIOS
	dw_2.insertrow(0)
	dw_2.setitem(dw_2.getrow(),'regsoc_id_regsoc',ls_numero)
else
	dw_razon.insertrow(0)
end if

dw_1.setfocus()
return 1


end event

event pfc_preupdate;call super::pfc_preupdate;// COMPROBACIONES


// LOS DATOS SE GUARDAN SOLO EN DW_1, hay que pasarlos a ese datawindow
dw_1.accepttext()
dw_numero.accepttext()
dw_razon.accepttext()


return 1

end event

event csd_siguiente;call super::csd_siguiente;
//if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then
	   g_regsoc_consulta = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'id_regsoc')
		dw_1.event csd_retrieve()
end if

end event

event csd_anterior;call super::csd_anterior;//event pfc_preupdate()
//if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then
	g_regsoc_consulta= g_dw_lista.getitemstring(g_dw_lista.getrow(), 'id_regsoc')
	dw_1.event csd_retrieve()
end if
end event

event csd_primero;call super::csd_primero;event pfc_preupdate()
//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(1)
	g_dw_lista.scrolltorow(1)
	g_regsoc_consulta= g_dw_lista.getitemstring(1,"id_regsoc")
	
	dw_1.event csd_retrieve()
end if
end event

event csd_ultimo;call super::csd_ultimo;event pfc_preupdate()
//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(g_dw_lista.rowcount())
	g_dw_lista.scrolltorow(g_dw_lista.rowcount())
	g_regsoc_consulta= g_dw_lista.getitemstring(g_dw_lista.rowcount(),"id_regsoc")
	
	dw_1.event csd_retrieve()
end if
end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_regsoc_detalle
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_regsoc_detalle
end type

type cb_nuevo from w_detalle`cb_nuevo within w_regsoc_detalle
end type

type cb_ayuda from w_detalle`cb_ayuda within w_regsoc_detalle
end type

type cb_grabar from w_detalle`cb_grabar within w_regsoc_detalle
end type

event cb_grabar::clicked;call super::clicked;//messagebox('fds','fdfsdf')
end event

type cb_ant from w_detalle`cb_ant within w_regsoc_detalle
end type

type cb_sig from w_detalle`cb_sig within w_regsoc_detalle
end type

type dw_1 from w_detalle`dw_1 within w_regsoc_detalle
integer y = 500
integer width = 4352
integer height = 952
string dataobject = "d_regsoc_detalle"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_1::csd_retrieve;call super::csd_retrieve;string ls_dw_syntax,ls_dw_err

if g_regsoc_consulta = '' or isnull(g_regsoc_consulta) then return
int retorno
double i

retorno = parent.event closequery()
if retorno = 1 then return
//messagebox('fdsf','retrieve')
this.retrieve(g_regsoc_consulta)

//dw_2.retrieve(g_regsoc_consulta) // Como no puedo usar el f_enlaza
//dw_numero.retrieve(g_regsoc_consulta)
//dw_razon.retrieve(g_regsoc_consulta)

g_regsoc_consulta = ''



end event

event dw_1::doubleclicked;call super::doubleclicked;string obser
// RYC 2008
// OBSERVACIONES
CHOOSE CASE dwo.name
	CASE 'r_1'  
		g_busqueda.titulo = "Observaciones"
		obser = this.GetItemString(row, 'observaciones')
		openwithparm(w_regsoc_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
			if obser = '-2' then setnull(obser)
			this.SetItem(row, 'observaciones', obser)
		end if
END CHOOSE
end event

event dw_1::retrieveend;call super::retrieveend;//string id_regsoc
//id_regsoc = this.getitemstring(1, 'id_regsoc')
//dw_2.retrieve(id_regsoc)
//comprobamos si esta vacio
if dw_1.rowcount()=0 then
	//recargamos el de la lista
	if g_dw_lista.rowcount() > 0 then
	   g_regsoc_consulta = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'id_regsoc')
		dw_1.event csd_retrieve()
   end if
end if

end event

event dw_1::itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE 'indefinida'
		datetime duracion
		setnull(duracion)
		if(data = 'S') then
			this.setitem( 1,'fecha_duracion',duracion)
		end if
END CHOOSE
end event

type tab_1 from tab within w_regsoc_detalle
integer x = 18
integer y = 1452
integer width = 4366
integer height = 1184
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_3 tabpage_3
tabpage_2 tabpage_2
tabpage_1 tabpage_1
tabpage_5 tabpage_5
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_3=create tabpage_3
this.tabpage_2=create tabpage_2
this.tabpage_1=create tabpage_1
this.tabpage_5=create tabpage_5
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_3,&
this.tabpage_2,&
this.tabpage_1,&
this.tabpage_5,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_3)
destroy(this.tabpage_2)
destroy(this.tabpage_1)
destroy(this.tabpage_5)
destroy(this.tabpage_4)
end on

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4329
integer height = 1056
long backcolor = 79741120
string text = "Agenda"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom023!"
long picturemaskcolor = 536870912
dw_4 dw_4
end type

on tabpage_3.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on tabpage_3.destroy
destroy(this.dw_4)
end on

type dw_4 from u_dw within tabpage_3
integer y = 8
integer width = 4325
integer height = 1044
integer taborder = 11
string dataobject = "d_regsoc_agenda"
end type

event pfc_addrow;call super::pfc_addrow;this.SetItem(this.getRow(),'id_regsoc_agenda',f_siguiente_numero('ID_REGSOC_AGENDA',10))
this.SetItem(this.getRow(),'id_regsoc',dw_1.getitemstring(1,'id_regsoc'))
return 1
end event

event pfc_insertrow;call super::pfc_insertrow;this.SetItem(this.getRow(),'id_regsoc_agenda',f_siguiente_numero('ID_REGSOC_AGENDA',10))
this.SetItem(this.getRow(),'id_regsoc',dw_1.getitemstring(1,'id_regsoc'))
return 1
end event

event constructor;call super::constructor;
// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4329
integer height = 1056
long backcolor = 79741120
string text = "Socios"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Picture!"
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tabpage_2.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_2.destroy
destroy(this.dw_3)
end on

type dw_3 from u_dw within tabpage_2
integer y = 8
integer width = 4329
integer height = 1040
integer taborder = 11
string dataobject = "d_regsoc_socios_enlazado"
end type

event pfc_insertrow;call super::pfc_insertrow;this.SetItem(this.getRow(),'id_regsoc_socio',f_siguiente_numero('ID_REGSOC_SOCIO',10))
// depende del modo
if g_modo_funcionamiento<>'1' then
	this.SetItem(this.getRow(),'id_regsoc',dw_1.getitemstring(1,'id_regsoc'))
else
	this.SetItem(this.getRow(),'id_colegiado_sociedad',dw_1.getitemstring(1,'id_colegiado_sociedad'))
end if

string id_regsoc
datawindowchild dddw_para_actualizar
this.GetChild('id_actividad',dddw_para_actualizar)	
// Obtenemos la transaccion para la DropDown
dddw_para_actualizar.SetTransObject(SQLCA)
// Actualiza el campo con Drop Down
dddw_para_actualizar.Retrieve()
id_regsoc=dw_1.getitemstring(1,'id_regsoc')
dddw_para_actualizar.setfilter("id_regsoc='"+ id_regsoc + "'")
dddw_para_actualizar.filter()
return 1
end event

event pfc_addrow;call super::pfc_addrow;this.SetItem(this.getRow(),'id_regsoc_socio',f_siguiente_numero('ID_REGSOC_SOCIO',10))

// depende del modo
if g_modo_funcionamiento<>'1' then
	this.SetItem(this.getRow(),'id_regsoc',dw_1.getitemstring(1,'id_regsoc'))
else
	this.SetItem(this.getRow(),'id_colegiado_sociedad',dw_1.getitemstring(1,'id_colegiado_sociedad'))
end if


//f_regsoc_actualizar_dddw(this)
string id_regsoc
datawindowchild dddw_para_actualizar
this.GetChild('id_actividad',dddw_para_actualizar)	
// Obtenemos la transaccion para la DropDown
dddw_para_actualizar.SetTransObject(SQLCA)
// Actualiza el campo con Drop Down
dddw_para_actualizar.Retrieve()
id_regsoc=dw_1.getitemstring(1,'id_regsoc')
dddw_para_actualizar.setfilter("id_regsoc='"+ id_regsoc + "'")
dddw_para_actualizar.filter()
return 1
end event

event buttonclicked;call super::buttonclicked;string colegiado,apellidos,nombre,nif,alta_baja,poblacion,direccion,telefono,n_colegiado,sql_nueva,ls_syntax,ls_error
string tabla,campo1,campo2,campo3,campo4,campo5,campo6,campo7,campo8,sociedad
datastore lds_dinamico
lds_dinamico = create datastore


choose case dwo.name
		
	case 'b_1'
		//lanzamos busqueda segun la seleccion
		if this.getitemstring(row,'tipo')='1' then
		// buscamos colegiado	
			 g_busqueda.titulo = "B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
			 g_busqueda.dw = "d_regsoc_lista_busqueda_colegiados"
	       colegiado=f_regsoc_busqueda_colegiados()
			 if not f_es_vacio(colegiado) then
		       this.setitem(row,'id_colegiado',colegiado)
				 this.setitem(row,'id_cliente','')
			 end if
	       // Rellenamos la estructura
			 // creamos un datastore y el dataobject
			 if g_modo_funcionamiento='1' then
			   sociedad=dw_1.getitemstring(1,'id_colegiado_sociedad')
				if not f_es_vacio(sociedad) then
					this.setitem(row,'id_colegiado_sociedad',sociedad)
				end if
			 end if
			 //CARGAMOS LOS DATOS
//			select texto into :tabla from var_globales where nombre='regsoc_colegiado_tabla';
//			select texto into :campo1 from var_globales where nombre='regsoc_colegiado_campo1';
//			select texto into :campo2 from var_globales where nombre='regsoc_colegiado_campo2';
//			select texto into :campo3 from var_globales where nombre='regsoc_colegiado_campo3';
//			select texto into :campo4 from var_globales where nombre='regsoc_colegiado_campo4';
//			select texto into :campo5 from var_globales where nombre='regsoc_colegiado_campo5';
//			select texto into :campo6 from var_globales where nombre='regsoc_colegiado_campo6';
//			select texto into :campo7 from var_globales where nombre='regsoc_colegiado_campo7';
//			select texto into :campo8 from var_globales where nombre='regsoc_colegiado_campo8';
//			
//
//			sql_nueva="SELECT DISTINCT " + tabla + "." + campo1 + ", " + tabla + "." + campo2 + ", " + tabla + "." + campo3 + ", " + tabla + "." + campo4 + ", " + tabla + "." + campo5 + ", " + tabla + "." + campo6 +  ", " + tabla + "." + campo7 + ", " + tabla + "." + campo8 + " FROM " + tabla + " WHERE " + campo1 + " = '" + colegiado +"'"
// 
//			ls_syntax = sqlca.SyntaxFromSQL(sql_nueva, "Style(Type= Grid )",ls_error)
//        
//			lds_dinamico.create(ls_syntax,ls_error)
//			lds_dinamico.SetTransObject(SQLCA)
//			lds_dinamico.retrieve()
//		     	 //select apellidos,nombre,nif,alta_baja,poblacion_activa_fiscal,domicilio_activo_fiscal,telefono_activo,n_colegiado into :apellidos,:nombre,:nif,:alta_baja,:poblacion,:direccion,:telefono,:n_colegiado from colegiados where id_colegiado=:colegiado;
//				if lds_dinamico.rowcount()>0 then
//						nombre=lds_dinamico.getitemstring(1,4)
//						nif=lds_dinamico.getitemstring(1,6)
//						apellidos=lds_dinamico.getitemstring(1,3)
//						poblacion=lds_dinamico.getitemstring(1,7)
//						direccion=lds_dinamico.getitemstring(1,8)
//						n_colegiado=lds_dinamico.getitemstring(1,2)
//				end if
//			
//				 this.setitem(row,'apellidos',apellidos)
//				 this.setitem(row,'nombre',nombre)
//				 this.setitem(row,'cif',nif)
//				 this.setitem(row,'alta_baja','')
//				 this.setitem(row,'poblacion_descripcion',poblacion)
//				 this.setitem(row,'direccion',direccion)
//				 this.setitem(row,'telefono',telefono)
//				 this.setitem(row,'num_colegiado',n_colegiado)
//			 end if
		
	   end if
			
			
			
			//lanzamos busqueda segun la seleccion
		if this.getitemstring(row,'tipo')='2' then
		// buscamos cliente
			 g_busqueda.titulo = "B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
			 g_busqueda.dw = "d_regsoc_lista_busqueda_colegiados"
	       colegiado=f_regsoc_busqueda_clientes()
    		 if not f_es_vacio(colegiado) then
   	      this.setitem(row,'id_cliente',colegiado)
				this.setitem(row,'id_colegiado','')
			 end if
	       // Rellenamos la estructura
			 //ESTA SELECT TENDRA QUE SER CONFIGURABLE
			    // Rellenamos la estructura
			 // creamos un datastore y el dataobject
			  if g_modo_funcionamiento='1' then
			   sociedad=dw_1.getitemstring(1,'id_colegiado_sociedad')
				if not f_es_vacio(sociedad) then
					this.setitem(row,'id_colegiado_sociedad',sociedad)
				end if
			 end if
//			 //CARGAMOS LOS DATOS
//			select texto into :tabla from var_globales where nombre='regsoc_cliente_tabla';
//			select texto into :campo1 from var_globales where nombre='regsoc_cliente_campo1';
//			select texto into :campo2 from var_globales where nombre='regsoc_cliente_campo2';
//			select texto into :campo3 from var_globales where nombre='regsoc_cliente_campo3';
//			select texto into :campo4 from var_globales where nombre='regsoc_cliente_campo4';
//			select texto into :campo6 from var_globales where nombre='regsoc_cliente_campo6';
//		
//			sql_nueva="SELECT DISTINCT " + tabla + "." + campo1 + ", " + tabla + "." + campo2 + ", " + tabla + "." + campo3 + ", " + tabla + "." + campo4 + ", " + tabla + "." + campo6 +  " FROM " + tabla + " WHERE " + campo1 + " = '" + colegiado +"'"
//			ls_syntax = sqlca.SyntaxFromSQL(sql_nueva, "Style(Type= Grid )",ls_error)
//        
//			lds_dinamico.create(ls_syntax,ls_error)
//			lds_dinamico.SetTransObject(SQLCA)
//			lds_dinamico.retrieve()
//		     	 //select apellidos,nombre,nif,alta_baja,poblacion_activa_fiscal,domicilio_activo_fiscal,telefono_activo,n_colegiado into :apellidos,:nombre,:nif,:alta_baja,:poblacion,:direccion,:telefono,:n_colegiado from colegiados where id_colegiado=:colegiado;
//				if lds_dinamico.rowcount()>0 then
//						nombre=lds_dinamico.getitemstring(1,4)
//						nif=lds_dinamico.getitemstring(1,5)
//						apellidos=lds_dinamico.getitemstring(1,3)
//				end if
//			 
//		     	// select apellidos,nombre,nif into :apellidos,:nombre,:nif  from clientes where id_cliente=:colegiado;
//			  	 this.setitem(row,'apellidos',apellidos)
//				 this.setitem(row,'nombre',nombre)
//				 this.setitem(row,'cif',nif)
//				 this.setitem(row,'alta_baja','N')
//		   	 this.setitem(row,'poblacion_descripcion','')
//		   	 this.setitem(row,'direccion','')
//    			 this.setitem(row,'telefono','')
//				 this.setitem(row,'num_colegiado','')
			 
			end if	

end choose
end event

event constructor;call super::constructor;string id_regsoc
datawindowchild dddw_para_actualizar
this.GetChild('id_actividad',dddw_para_actualizar)	
// Obtenemos la transaccion para la DropDown
dddw_para_actualizar.SetTransObject(SQLCA)
// Actualiza el campo con Drop Down
dddw_para_actualizar.Retrieve()
dddw_para_actualizar.setfilter("id_regsoc=''")
dddw_para_actualizar.filter()


// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event retrieveend;call super::retrieveend;//f_regsoc_actualizar_dddw(this)
string id_regsoc
datawindowchild dddw_para_actualizar
this.GetChild('id_actividad',dddw_para_actualizar)	
// Obtenemos la transaccion para la DropDown
dddw_para_actualizar.SetTransObject(SQLCA)
// Actualiza el campo con Drop Down
dddw_para_actualizar.Retrieve()
id_regsoc=dw_1.getitemstring(1,'id_regsoc')
dddw_para_actualizar.setfilter("id_regsoc='"+ id_regsoc + "'")
dddw_para_actualizar.filter()


// Recorremos por si falta rellenar la columna tipo

long i
string tipo
if this.rowcount()<=0 then return

for i=1 to this.rowcount() // tambien rellenamos por defecto los valores de los checks
	tipo=this.getitemstring(i,'tipo')
	if f_es_vacio(tipo) then
		if f_regsoc_col_o_cli(this.getitemstring(i,'id_regsoc_socio')) then
			this.setitem(i,'tipo','1')
			this.setitem(i,'representante','N')
			this.setitem(i,'alta_baja','N')
			this.setitem(i,'administrador','N')
		else
			this.setitem(i,'tipo','2')
			this.setitem(i,'representante','N')
			this.setitem(i,'alta_baja','N')
			this.setitem(i,'administrador','N')
		end if
	end if
next
this.update()


end event

event pfc_postupdate;call super::pfc_postupdate;
string id_regsoc
datawindowchild dddw_para_actualizar
this.GetChild('id_actividad',dddw_para_actualizar)	
// Obtenemos la transaccion para la DropDown
dddw_para_actualizar.SetTransObject(SQLCA)
// Actualiza el campo con Drop Down
dddw_para_actualizar.Retrieve()
id_regsoc=dw_1.getitemstring(1,'id_regsoc')
dddw_para_actualizar.setfilter("id_regsoc='"+ id_regsoc + "'")
dddw_para_actualizar.filter()

return 1
end event

event pfc_preupdate;call super::pfc_preupdate;//Actualizamos en el modo 1 con el id_colegiado_sociedad por si ha cambiado
// si esta vacio no dejamos grabar
string id_colegiado_sociedad
long i
if g_modo_funcionamiento='1' then
	id_colegiado_sociedad=dw_1.getitemstring(1,'id_colegiado_sociedad')
	if f_es_vacio(id_colegiado_sociedad) then
		messagebox(g_titulo,'No puede guardar sin haber asignado una sociedad al registro')
		return -1
	end if
	//recorremos y rellenamos la pesta$$HEX1$$f100$$ENDHEX$$a de socios
	if idw_socios.rowcount()>0 then
		for i=1 to idw_socios.rowcount()
			idw_socios.setitem(i,'id_colegiado_sociedad',id_colegiado_sociedad)			
		next
	end if
end if
return 1

end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4329
integer height = 1056
long backcolor = 79741120
string text = "Actividades Profesionales"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "EditObject!"
long picturemaskcolor = 536870912
dw_actividades dw_actividades
end type

on tabpage_1.create
this.dw_actividades=create dw_actividades
this.Control[]={this.dw_actividades}
end on

on tabpage_1.destroy
destroy(this.dw_actividades)
end on

type dw_actividades from u_dw within tabpage_1
integer y = 8
integer width = 4320
integer height = 1040
integer taborder = 11
string dataobject = "d_regsoc_actividades"
end type

event pfc_addrow;call super::pfc_addrow;this.SetItem(this.getRow(),'id_regsoc_actividad',f_siguiente_numero('REGSOC_ACTIVIDAD',10))
this.SetItem(this.getRow(),'id_regsoc',dw_1.getitemstring(1,'id_regsoc'))
return 1
end event

event pfc_insertrow;call super::pfc_insertrow;this.SetItem(this.getRow(),'id_regsoc_actividad',f_siguiente_numero('REGSOC_ACTIVIDAD',10))
this.SetItem(this.getRow(),'id_regsoc',dw_1.getitemstring(1,'id_regsoc'))
return 1
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4329
integer height = 1056
long backcolor = 79741120
string text = "Sanciones"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Warning!"
long picturemaskcolor = 536870912
dw_5 dw_5
end type

on tabpage_5.create
this.dw_5=create dw_5
this.Control[]={this.dw_5}
end on

on tabpage_5.destroy
destroy(this.dw_5)
end on

type dw_5 from u_dw within tabpage_5
integer y = 8
integer width = 4325
integer height = 1040
integer taborder = 11
string dataobject = "d_regsoc_sancion"
end type

event pfc_addrow;call super::pfc_addrow;this.SetItem(this.getRow(),'id_reg_soc_sancion',f_siguiente_numero('ID_SANCION',10))
this.SetItem(this.getRow(),'id_regsoc',dw_1.getitemstring(1,'id_regsoc'))
return 1
end event

event pfc_insertrow;call super::pfc_insertrow;this.SetItem(this.getRow(),'id_reg_soc_sancion',f_siguiente_numero('ID_SANCION',10))
this.SetItem(this.getRow(),'id_regsoc',dw_1.getitemstring(1,'id_regsoc'))
return 1
end event

event constructor;call super::constructor;
// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4329
integer height = 1056
long backcolor = 79741120
string text = "Anexos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom039!"
long picturemaskcolor = 536870912
dw_anexos dw_anexos
end type

on tabpage_4.create
this.dw_anexos=create dw_anexos
this.Control[]={this.dw_anexos}
end on

on tabpage_4.destroy
destroy(this.dw_anexos)
end on

type dw_anexos from u_dw within tabpage_4
integer y = 8
integer width = 4338
integer height = 1040
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_regsoc_anexos"
end type

event constructor;call super::constructor;
// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event pfc_addrow;call super::pfc_addrow;this.SetItem(this.getRow(),'id_documento_modulo',f_siguiente_numero('ID_REGSOC_ANEXO',10))
this.SetItem(this.getRow(),'ubicacion',dw_1.getitemstring(1,'id_regsoc'))
return 1
end event

event pfc_insertrow;call super::pfc_insertrow;this.SetItem(this.getRow(),'id_documento_modulo',f_siguiente_numero('ID_REGSOC_ANEXO',10))
this.SetItem(this.getRow(),'ubicacion',dw_1.getitemstring(1,'id_regsoc'))
return 1
end event

event buttonclicked;call super::buttonclicked;string filename,pathname,ruta_relativa,ruta_origen,ruta_destino,id,id_plan,directorio
string extension,id_plan_fichero,cd_rom,nombre,destino, ls_id_regsoc
long fd, posicion,fin
integer opcion
long longitud
integer error_archivo

n_cst_filesrvwin32 file_srv
file_srv = create n_cst_filesrvwin32

/******************************************************************************/
/****** Obtenci$$HEX1$$f300$$ENDHEX$$n recursiva del nombre de fichero a partir de ruta origen *****/
/******************************************************************************/

ruta_origen = f_obtener_fichero('*',false,ruta_origen,"Seleccione el archivo",'*')
		 
IF ruta_origen = '-1' THEN return // en el caso de que no se seleccione un archivo(se cancele en la ventana) 

ruta_relativa = ruta_origen
		
fin = 0
		
DO WHILE fin <> 1
	IF PosA(ruta_relativa,'\') > 0 THEN
		posicion = PosA(ruta_relativa,'\')
		ruta_relativa = MidA(ruta_relativa,posicion+1)
	ELSEIF PosA(ruta_relativa,'\') = 0 THEN
		fin = 1 
	END IF
LOOP
		
/******************** en ruta_relativa tenemos el nombre de fichero ****************/
/*************************** Fin obtencion nombre fichero **************************/

/************************************************/
/* Ruta destino diferente si viene planeamiento */ 
/************************************************/

// Modificado por Alexis el 03-09-2009. Los anexos se subir$$HEX1$$e100$$ENDHEX$$n a una carpeta concreta con el identificador del Regsoc
ls_id_regsoc = dw_numero.getitemstring(1, 'id_regsoc')
	
	//ruta_destino = g_directorio_ficheros + '\' + ls_id_regsoc + '\'
	
	ruta_destino = f_obtener_ruta_documentos("regsoc","",ls_id_regsoc,"",5)
	
IF ruta_origen <> '-1' THEN 
	
	if FileExists(ruta_destino + ruta_relativa) then
	     messagebox(g_titulo,'El fichero ya existe')
		  return -1	
	end if
	
	//********CAMBIO GENERICO********//
	//Modificado Jesus 2/3/2010 CZA-169 Comprueba si existe la carpeta y sino la crea
	boolean lb_existe
	int li_valor=1
	
	lb_existe=file_srv.of_directoryexists(ruta_destino)
	if not lb_existe then
		li_valor=file_srv.of_createdirectory(ruta_destino)
	end if
	
	if li_valor=-1 then 
		Messagebox('Error','Error al crear el directorio donde se copiar$$HEX1$$e100$$ENDHEX$$n los documentos asociados a esta sociedad.'&
		+cr+'Aseg$$HEX1$$fa00$$ENDHEX$$rese de que el directorio '+ruta_destino+' existe.',StopSign!)
		return -1
	end if

	//Fin Modificacion
	//********FIN CAMBIO GENERICO********//
	
    		error_archivo = file_srv.of_filecopy(ruta_origen,ruta_destino + ruta_relativa) 		
			destino = ruta_destino + ruta_relativa
//			error_archivo = copyFileA(ruta_origen,destino,FALSE)		
end if
if error_archivo<=0  then
	MessageBox(g_titulo,'Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al copiar el archivo ' + ruta_origen + " en " + ruta_destino + ruta_relativa)
else	
	// A$$HEX1$$f100$$ENDHEX$$adimos el nombre del fichero a la columna
	this.setitem(row,'nombre_fichero',ruta_relativa)
	// A$$HEX1$$f100$$ENDHEX$$adimos distintivos para los ficheros que se guardaran en la BD. Alexis 03-09-2009
	this.setitem(row,'id_tipo_modulo','REGSOC')
	this.setitem(row,'id_modulo',ls_id_regsoc)
end if




end event

event doubleclicked;call super::doubleclicked;//Modificado por Alexis el 03-09-2009. Los ficheros se encuentran en carpetas particulares para cada id_regsoc

string ls_id_regsoc

//extraemos el identificador del registro de sociedad que coincidir$$HEX2$$e1002000$$ENDHEX$$con el directorio
ls_id_regsoc = dw_numero.getitemstring(1, 'id_regsoc')

if row > 0 and dwo.name='nombre_fichero' then
	integer res
	string fichero
	fichero=this.getitemstring(row,'nombre_fichero')
	if not f_es_vacio(fichero) then
		//Cambio Luis CTE-64
		if(g_colegio <> 'COAATTFE')then
			res = f_regsoc_csd_abrir_fichero(w_regsoc_detalle,fichero,g_directorio_ficheros + '\' + ls_id_regsoc + '\')
		else
			res = f_regsoc_csd_abrir_fichero(w_regsoc_detalle,fichero,g_directorio_ficheros + '\')
		end if
		//fin cambio
	end if
end if

end event

type dw_numero from u_dw within w_regsoc_detalle
integer x = 18
integer y = 32
integer width = 4352
integer height = 144
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_regsoc_detalle_numero"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;
// RYC 2008
// COPIAMOS AL DW_1 QUE ES EL QUE GRABA

choose case dwo.name
	case 'num_reg_colegio'
		dw_1.setitem(dw_1.getrow(),'num_reg_colegio',data)
	case 'num_reg_mercantil'
		dw_1.setitem(dw_1.getrow(),'num_reg_mercantil',data)
end choose

end event

type dw_2 from u_dw within w_regsoc_detalle
integer x = 32
integer y = 180
integer width = 4338
integer height = 328
integer taborder = 11
string dataobject = "d_regsoc_detalle_icav"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event retrieveend;call super::retrieveend;// RYC 2008
// si no aparece ninguna linea y estamos en el modo 1 mostramos una linea vacia

if g_modo_funcionamiento='1' and dw_2.rowcount()<=0 then  
	dw_2.insertrow(0)
end if
end event

event buttonclicked;call super::buttonclicked;//buscamos el colegiado
string colegiado,apellidos,nif,domicilio,poblacion,web,email,telefono,fax,n_colegiado

if dwo.name='b_colegiado' then
	
   g_busqueda.titulo = "B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Sociedades"
	g_busqueda.dw = "d_regsoc_lista_busqueda_colegiados"
	colegiado=f_regsoc_busqueda_colegiados()

	if not f_es_vacio(colegiado) then
		dw_1.setitem(1,'id_colegiado_sociedad',colegiado)
// Aqui rellenamos los 4 campos para que se visualizen
	   SELECT colegiados.apellidos,   
         colegiados.nif,   
         colegiados.domicilio_activo_fiscal,   
         colegiados.poblacion_activa_fiscal,telefono_2,url,email,telefono_5,colegiados.n_colegiado
			
		into :apellidos,:nif,:domicilio,:poblacion,:telefono,:web,:email,:fax,:n_colegiado
      FROM       colegiados  
      WHERE  colegiados.id_colegiado = :colegiado;
	
	this.setitem(row,'colegiados_apellidos',apellidos)
	this.setitem(row,'colegiados_nif',nif)
	this.setitem(row,'colegiados_domicilio_activo_fiscal',domicilio)
	this.setitem(row,'colegiados_poblacion_activa_fiscal',poblacion)
	this.setitem(row,'colegiados_n_colegiado',n_colegiado)
			
	end if
    // RELLENAMOS WEB,EMAIL,TELEFONO Y FAX
	dw_1.setitem(row,'fax',fax)
	dw_1.setitem(row,'mail',email)
	dw_1.setitem(row,'web',web)
	dw_1.setitem(row,'telefono',telefono)
	
	
	//AHORA REVISAMOS LOS SOCIOS
	idw_socios.retrieve(colegiado)
	
end if
end event

type dw_razon from u_dw within w_regsoc_detalle
integer x = 18
integer y = 180
integer width = 4357
integer height = 324
integer taborder = 11
string dataobject = "d_regsoc_detalle_razon"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;// RYC 2008
// COPIAMOS AL DW_1 QUE ES EL QUE GRABA


choose case dwo.name
		
case 'razon_social'
	dw_1.setitem(dw_1.getrow(),'razon_social',data)
case 'direccion'
	dw_1.setitem(dw_1.getrow(),'direccion',data)
case 'cod_prov'
	dw_1.setitem(dw_1.getrow(),'cod_prov',data)
case 'cod_prov'
	dw_1.setitem(dw_1.getrow(),'cod_pob',data)
case 'cp'
	dw_1.setitem(dw_1.getrow(),'cp',data)
case 'cif'
	dw_1.setitem(dw_1.getrow(),'cif',data)
case 'poblacion_descripcion'
	dw_1.setitem(dw_1.getrow(),'poblacion_descripcion',data)

end choose
end event

