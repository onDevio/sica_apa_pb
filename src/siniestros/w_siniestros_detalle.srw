HA$PBExportHeader$w_siniestros_detalle.srw
forward
global type w_siniestros_detalle from w_detalle
end type
type tab_1 from tab within w_siniestros_detalle
end type
type tabpage_3 from userobject within tab_1
end type
type dw_siniestros_detalle_datos_fase from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_siniestros_detalle_datos_fase dw_siniestros_detalle_datos_fase
end type
type tabpage_2 from userobject within tab_1
end type
type dw_siniestros_detalle_promotores from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_siniestros_detalle_promotores dw_siniestros_detalle_promotores
end type
type tabpage_1 from userobject within tab_1
end type
type dw_siniestros_detalle_colegiados from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_siniestros_detalle_colegiados dw_siniestros_detalle_colegiados
end type
type tabpage_4 from userobject within tab_1
end type
type dw_siniestros_fases_incidencias from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_siniestros_fases_incidencias dw_siniestros_fases_incidencias
end type
type tabpage_5 from userobject within tab_1
end type
type dw_siniestros_fases_tecnicos from u_dw within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_siniestros_fases_tecnicos dw_siniestros_fases_tecnicos
end type
type tabpage_6 from userobject within tab_1
end type
type dw_siniestros_tipo_danyos from u_dw within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_siniestros_tipo_danyos dw_siniestros_tipo_danyos
end type
type tabpage_7 from userobject within tab_1
end type
type dw_siniestros_causas_danyos from u_dw within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_siniestros_causas_danyos dw_siniestros_causas_danyos
end type
type tab_1 from tab within w_siniestros_detalle
tabpage_3 tabpage_3
tabpage_2 tabpage_2
tabpage_1 tabpage_1
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type
type dw_2 from u_dw within w_siniestros_detalle
end type
end forward

global type w_siniestros_detalle from w_detalle
integer width = 3771
integer height = 2376
string title = "Detalle de Siniestros"
string menuname = "m_detalle_siniestros"
event csd_imprimir ( )
tab_1 tab_1
dw_2 dw_2
end type
global w_siniestros_detalle w_siniestros_detalle

type variables
string i_n_interno
u_dw idw_tipo_danyos,idw_causas_danyos, idw_contrato, idw_clientes, idw_colegiados, idw_incidencias, idw_arquitectos
end variables

event csd_imprimir();dw_2.settrans(SQLCA)
dw_2.reset()
dw_2.retrieve(dw_1.getitemstring(1,'id_siniestro'))
printsetup()
dw_2.print()
end event

on w_siniestros_detalle.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_detalle_siniestros" then this.MenuID = create m_detalle_siniestros
this.tab_1=create tab_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_2
end on

on w_siniestros_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.dw_2)
end on

event type integer csd_nuevo();call super::csd_nuevo;if AncestorReturnValue>0 then
	//Introducimos en el campo clave el valor obtenido desde el contador.
	dw_1.SetItem(dw_1.GetRow(),'id_siniestro',f_siguiente_numero('ID_SINIESTRO',10))
	
	//Ponemos el numero del siniestro; NO CONTADOR sino el numero de siniestros q tengamos.
	double max_siniestros
	select  max(convert(integer,n_interno)) into:max_siniestros from fases_siniestros;
	
	if isnull(max_siniestros) then 
		max_siniestros=1 
	else 
		max_siniestros=max_siniestros+1
	end if 
	
	dw_1.SetItem(dw_1.GetRow(),'n_interno',RightA('000000000000'+string(max_siniestros),10))
	
	dw_1.SetItem(dw_1.GetRow(),'fecha',today())
	//donde "n" es un entero que indica la longitud en caracteres del contador
	dw_1.setfocus()
	
	//Vaciamos la variable global id_siniestro y de id_fase
	g_siniestros_consulta.id_siniestro=''
//	g_siniestros_consulta.id_fase=''
	// Modificado Ricardo por que no acabo de entender para que est$$HEX2$$e1002000$$ENDHEX$$hecho eso, y hace que funcione incorrectamente!!!!!!!
	//Datawindows de datos de la fase
	//tab_1.tabpage_3.dw_siniestros_detalle_datos_fase.retrieve(g_siniestros_consulta.id_fase)
	//Datawindows de clientes
	//tab_1.tabpage_2.dw_siniestros_detalle_promotores.retrieve(g_siniestros_consulta.id_fase)
	//Datawindows de colegiados
	//tab_1.tabpage_1.dw_siniestros_detalle_colegiados.retrieve(g_siniestros_consulta.id_siniestro)
	
	//Andr$$HEX1$$e900$$ENDHEX$$s 9/6/2005
	//para los tabs tipo de da$$HEX1$$f100$$ENDHEX$$os y causas da$$HEX1$$f100$$ENDHEX$$os
	idw_tipo_danyos.Event  pfc_addrow()
	idw_tipo_danyos.setitemstatus(1,0,Primary!,DataModified!)
	
	idw_causas_danyos.Event  pfc_addrow()
	idw_causas_danyos.setitemstatus(1,0,Primary!,DataModified!)
	//Inicializamos los checks a mano porque sino no va bien
	idw_tipo_danyos.setitem(1,'td_accidente_laboral','N')
	idw_tipo_danyos.setitem(1,'td_desprendimiento_tierras','N')
	idw_tipo_danyos.setitem(1,'td_danyos_per_ajena_obras','N')
	idw_tipo_danyos.setitem(1,'td_humedades','N')
	idw_tipo_danyos.setitem(1,'td_danyos_instalaciones','N')
	idw_tipo_danyos.setitem(1,'td_otros','N')
	
	idw_tipo_danyos.setitem(1,'td_fallos_suelo','N')
	idw_tipo_danyos.setitem(1,'td_danyos_colindantes','N')
	idw_tipo_danyos.setitem(1,'td_danyos_cosas_ajenas_obra','N')
	idw_tipo_danyos.setitem(1,'td_revestimientos_fachada','N')
	idw_tipo_danyos.setitem(1,'td_danyos_estructurales','N')
	idw_tipo_danyos.setitem(1,'td_danyos_alicatados','N')
	idw_tipo_danyos.setitem(1,'td_danyos_solados','N')
	
	idw_causas_danyos.setitem(1,'cd_error_dis_proy','N')
	idw_causas_danyos.setitem(1,'cd_defectos_cimentacion','N')
	idw_causas_danyos.setitem(1,'cd_excavacion_excesiva','N')
	idw_causas_danyos.setitem(1,'cd_otras','N')
	idw_causas_danyos.setitem(1,'cd_error_calculo_estructural','N')
	idw_causas_danyos.setitem(1,'cd_mala_ejecucion','N')
	idw_causas_danyos.setitem(1,'cd_mal_uso','N')
end if

return AncestorReturnValue

end event

event csd_primero();call super::csd_primero;//Preguntamos si hay filas el datawindows de la lista
if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(1)
	g_dw_lista.scrolltorow(1)
	//Cogemos el id_siniestro y el id_fase
	g_siniestros_consulta.id_siniestro = g_dw_lista.getitemstring(1,"fases_siniestros_id_siniestro")
//	g_siniestros_consulta.id_fase = g_dw_lista.getitemstring(1,"fases_id_fase")
	dw_1.event csd_retrieve()
end if
end event

event csd_siguiente();call super::csd_siguiente;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	//Cogemos el id_siniestro y el id_fase
//	g_siniestros_consulta.id_fase = g_dw_lista.getitemstring(g_dw_lista.getrow(),"fases_id_fase")
	g_siniestros_consulta.id_siniestro = g_dw_lista.getitemstring(g_dw_lista.getrow(),"fases_siniestros_id_siniestro")
	dw_1.event csd_retrieve()
end if

end event

event csd_ultimo();call super::csd_ultimo;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(g_dw_lista.rowcount())
	g_dw_lista.scrolltorow(g_dw_lista.rowcount())
	//Cogemos el id_siniestro y el id_fase
	g_siniestros_consulta.id_siniestro = g_dw_lista.getitemstring(g_dw_lista.rowcount(),"fases_siniestros_id_siniestro")
//	g_siniestros_consulta.id_fase = g_dw_lista.getitemstring(g_dw_lista.rowcount(),"fases_id_fase")
	
	dw_1.event csd_retrieve()
end if

end event

event open;call super::open;idw_contrato = tab_1.tabpage_3.dw_siniestros_detalle_datos_fase
idw_clientes = tab_1.tabpage_2.dw_siniestros_detalle_promotores
idw_colegiados = tab_1.tabpage_1.dw_siniestros_detalle_colegiados
idw_incidencias = tab_1.tabpage_4.dw_siniestros_fases_incidencias
idw_arquitectos = tab_1.tabpage_5.dw_siniestros_fases_tecnicos 
idw_tipo_danyos=tab_1.tabpage_6.dw_siniestros_tipo_danyos
idw_causas_danyos=tab_1.tabpage_7.dw_siniestros_causas_danyos

//Enlazamos los datawindows correspondientes para poder sacar la informacion q los relaciona.
f_enlaza_dw(dw_1,idw_colegiados,'id_siniestro','id_siniestro')
f_enlaza_dw(dw_1,idw_clientes,'id_fase','id_fase')
f_enlaza_dw(dw_1,idw_contrato,'id_fase','id_fase')
f_enlaza_dw(dw_1,idw_incidencias,'id_siniestro','id_siniestro')
f_enlaza_dw(dw_1,idw_arquitectos,'id_siniestro','id_siniestro')
f_enlaza_dw(dw_1,idw_tipo_danyos,'id_siniestro','id_siniestro')
f_enlaza_dw(dw_1,idw_causas_danyos,'id_siniestro','id_siniestro')

//Redimensionamos los tabs  y las ventanas asociadas
inv_resize.of_Register (tab_1, "scaletoright&bottom")
inv_resize.of_Register (idw_colegiados, "scaletoright&bottom")
inv_resize.of_Register (idw_clientes, "scaletoright&bottom")
inv_resize.of_Register (idw_contrato, "scaletoright&bottom")
inv_resize.of_Register (idw_incidencias, "scaletoright&bottom")
inv_resize.of_Register (idw_arquitectos, "scaletoright&bottom")
inv_resize.of_Register (idw_tipo_danyos,"scaletoright&bottom")
inv_resize.of_Register (idw_causas_danyos,"scaletoright&bottom")

end event

event csd_anterior();call super::csd_anterior;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	//Cogemos el id_siniestro y el id_fase
//	g_siniestros_consulta.id_fase = g_dw_lista.getitemstring(g_dw_lista.getrow(),"fases_id_fase")
	g_siniestros_consulta.id_siniestro = g_dw_lista.getitemstring(g_dw_lista.getrow(),"fases_siniestros_id_siniestro")
	dw_1.event csd_retrieve()
end if

end event

event activate;call super::activate;g_dw_lista	= g_dw_lista_siniestros
g_w_lista   = g_lista_siniestros
g_w_detalle = g_detalle_siniestros
g_lista     = 'w_siniestros_lista'
g_detalle   = 'w_siniestros_detalle'
end event

event pfc_preupdate;call super::pfc_preupdate;string mensaje=''

if f_puedo_escribir(g_usuario,'0000000010')=-1 then return -1

mensaje=mensaje + f_valida(dw_1,'n_interno','NOVACIO','Debe especificar un valor en numero del siniestro')
mensaje=mensaje + f_valida(dw_1,'n_musaat','NOVACIO','Debe especificar un valor en numero de la compa$$HEX2$$f100ed00$$ENDHEX$$a del SRC')
mensaje=mensaje + f_valida(idw_colegiados,'id_colegiado','NOVACIO','Debe especificar un valor en el colegiado')
mensaje=mensaje + f_valida(idw_colegiados,'src_cia','NOVACIO','Debe especificar un valor en compa$$HEX2$$f100ed00$$ENDHEX$$a del SRC para el colegiado')

int retorno=1
if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno = -1
end if
return retorno

end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_siniestros_detalle
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_siniestros_detalle
end type

type cb_nuevo from w_detalle`cb_nuevo within w_siniestros_detalle
end type

type cb_ayuda from w_detalle`cb_ayuda within w_siniestros_detalle
end type

type cb_grabar from w_detalle`cb_grabar within w_siniestros_detalle
end type

type cb_ant from w_detalle`cb_ant within w_siniestros_detalle
end type

type cb_sig from w_detalle`cb_sig within w_siniestros_detalle
end type

type dw_1 from w_detalle`dw_1 within w_siniestros_detalle
event csd_borrar_campo ( string campo,  long row )
integer x = 14
integer y = 20
integer width = 3680
integer height = 1156
string dataobject = "d_siniestros_detalle"
boolean border = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event dw_1::csd_borrar_campo(string campo, long row);this.setitem(row, campo, '')
end event

event dw_1::csd_retrieve();call super::csd_retrieve;//Comprobamos que la variabe que le pasamos, en este caso el identificador del siniestro
if g_siniestros_consulta.id_siniestro ='' or isnull(g_siniestros_consulta.id_siniestro) then return
int    retorno
double i
//Cerramos la consulta
retorno = parent.event closequery()
if retorno = 1 then return
//Retriveamos los datos del siniestro
this.retrieve(g_siniestros_consulta.id_siniestro)
////Datawindows de datos de la fase
//tab_1.tabpage_3.dw_siniestros_detalle_datos_fase.retrieve(g_siniestros_consulta.id_fase)
////Datawindows de clientes
//tab_1.tabpage_2.dw_siniestros_detalle_promotores.retrieve(g_siniestros_consulta.id_fase)
////Datawindows de colegiados
//tab_1.tabpage_1.dw_siniestros_detalle_colegiados.retrieve(g_siniestros_consulta.id_siniestro)

//Vaciamos la variable global id_siniestro y de id_fase
g_siniestros_consulta.id_siniestro=''
//g_siniestros_consulta.id_fase=''
end event

event dw_1::buttonclicked;call super::buttonclicked;string id_fase,id_siniestro,id_colegiado
string tipo_alta_src, src_cia, src_n_poliza, src_cober_musaat, src_cober_otras
string pob 
long fila,i

CHOOSE CASE dwo.name
	case 'cb_poblacion'			

		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(1,'poblacion_contacto',pob)
		// Colocamos la provincia
		string cod_provincia
		cod_provincia=f_devuelve_cod_provincia(pob)
      this.setitem(row,'provincia_contacto',cod_provincia)

	CASE 'b_busqueda_fases'

		//Creamos un datastore para coger los colegiados asociados de la fase
		datastore ds_fases_colegiados
		ds_fases_colegiados = create datastore
		ds_fases_colegiados.dataobject = 'd_fases_lista_colegiados'
		ds_fases_colegiados.settransobject(sqlca)		
		
		//Buscamos las fases
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida"
		g_busqueda.dw="d_lista_busqueda_fases"
		id_fase=f_busqueda_fases()
		
		if NOT f_es_vacio(id_fase) then
			// Vaciamos los colegiados
			for i=idw_colegiados.rowcount() to 1 step -1
				idw_colegiados.deleterow(i)			
			next
			//Ponemos para que se visualize el valor del expediente y del registro
			this.setitem(1,'n_registro',f_dame_n_reg(id_fase))	
			this.setitem(1,'n_expediente',f_dame_exp(id_fase))	
			//Ponemos el valor de la fase en el datawindow de siniestros para que guarde los cambios
			dw_1.setitem(1,'id_fase',id_fase)
			//Asignamos la id_fase a la variable global
//			g_siniestros_consulta.id_fase=id_fase
//			//Datawindows de datos de la fase
			idw_contrato.retrieve(id_fase)
//			//Datawindows de clientes
			idw_clientes.retrieve(id_fase)
			//Insertamos dentro de la tabla fases_siniestros_cole ( que relaciona los colegiados con los siniestros)
			ds_fases_colegiados.retrieve(id_fase)
			id_siniestro=dw_1.GetItemString(1,'id_siniestro')
			
			for i = 1 to ds_fases_colegiados.rowcount()
				fila=idw_colegiados.InsertRow(0)
				id_colegiado=ds_fases_colegiados.GetItemString(i,'id_col')

				idw_colegiados.SetItem(fila,'id_siniestro',id_siniestro)
				idw_colegiados.SetItem(fila,'id_colegiado',id_colegiado)

				src_cia = ''
				src_n_poliza = ''
				src_cober_musaat = ''
				src_cober_otras = ''

				tipo_alta_src = f_tipo_alta_src(id_colegiado)
				CHOOSE CASE tipo_alta_src 
					CASE 'S' // MUSAAT
						src_cia = 'MU'
						SELECT src_cober, src_n_poliza INTO :src_cober_musaat, :src_n_poliza FROM musaat WHERE musaat.id_col = :id_colegiado ;
					CASE 'O'
						SELECT src_cober, numero_poliza, src_cia INTO :src_cober_otras, :src_n_poliza, :src_cia FROM src_colegiado WHERE id_colegiado= :id_colegiado ;
				END CHOOSE		
				
				idw_colegiados.setitem(i,'src_cia',src_cia)
				idw_colegiados.setitem(i,'src_n_poliza',src_n_poliza)
				idw_colegiados.setitem(i,'src_cober', src_cober_musaat)
				idw_colegiados.setitem(i,'src_cober_otras', src_cober_otras)
				
			next 	
		end if
		destroy ds_fases_colegiados
		
	CASE 'b_borrar'
		this.SetItem(1,'id_fase', '')
		for i=idw_colegiados.rowcount() to 1 step -1
			idw_colegiados.deleterow(i)			
		next
		idw_contrato.retrieve('')
		idw_clientes.retrieve('')

END CHOOSE

end event

event dw_1::itemchanged;call super::itemchanged;//Para cuando se coga la naturaleza de los da$$HEX1$$f100$$ENDHEX$$os....
string danyos,estado_obra,n_interno, cod
choose case dwo.name
	case 'tipo_danyos'
		SELECT sini_tipo_danyos.descripcion INTO :danyos FROM sini_tipo_danyos WHERE sini_tipo_danyos.codigo= :data;
		this.SetItem(1,'danyos',danyos)
	case 'tipo_estado_obra'
		SELECT sini_tipo_estado_obra.descripcion INTO :estado_obra FROM sini_tipo_estado_obra WHERE sini_tipo_estado_obra.codigo= :data;
		this.SetItem(1,'estado_obra',estado_obra)
	
	case 'poblacion_contacto'
		// Si est$$HEX1$$e100$$ENDHEX$$n borrando lo que hay no tenemos que comprobar nada
		if not f_es_vacio(data) then
			// Si el codigo no existe no dejamos ponerlo
			SELECT poblaciones.cod_pob INTO :cod FROM poblaciones WHERE poblaciones.cod_pob = :data ;
			if SQLCA.sqlcode <> 0 then	
				MessageBox(g_titulo,'Este c$$HEX1$$f300$$ENDHEX$$digo no existe.')
				this.post event csd_borrar_campo(dwo.name, row)
				return 2
			else
				// Colocamos la provincia
				string cod_provincia
				cod_provincia=f_devuelve_cod_provincia(cod)
				this.setitem(row,'provincia_contacto',cod_provincia)
			end if
		end if
end choose

end event

event dw_1::doubleclicked;call super::doubleclicked;string obser,data_item
CHOOSE CASE dwo.name
		
	CASE 'observaciones'
		g_busqueda.titulo="Observaciones"
		obser    =this.GetItemString(row, 'observaciones')
		data_item=this.getitemstring(row, 'observaciones') // para control modificaciones
		openwithparm(w_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
		if not isnull(obser) then 
				dw_1.SetItem(row,'observaciones',obser)
			end if 	
		end if
END CHOOSE

end event

type tab_1 from tab within w_siniestros_detalle
integer x = 14
integer y = 1204
integer width = 3666
integer height = 936
integer taborder = 70
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
tabpage_3 tabpage_3
tabpage_2 tabpage_2
tabpage_1 tabpage_1
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type

on tab_1.create
this.tabpage_3=create tabpage_3
this.tabpage_2=create tabpage_2
this.tabpage_1=create tabpage_1
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.Control[]={this.tabpage_3,&
this.tabpage_2,&
this.tabpage_1,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7}
end on

on tab_1.destroy
destroy(this.tabpage_3)
destroy(this.tabpage_2)
destroy(this.tabpage_1)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
end on

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3630
integer height = 808
long backcolor = 79741120
string text = "Contrato"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Cascade!"
long picturemaskcolor = 536870912
dw_siniestros_detalle_datos_fase dw_siniestros_detalle_datos_fase
end type

on tabpage_3.create
this.dw_siniestros_detalle_datos_fase=create dw_siniestros_detalle_datos_fase
this.Control[]={this.dw_siniestros_detalle_datos_fase}
end on

on tabpage_3.destroy
destroy(this.dw_siniestros_detalle_datos_fase)
end on

type dw_siniestros_detalle_datos_fase from u_dw within tabpage_3
integer x = 18
integer y = 28
integer width = 3570
integer height = 756
integer taborder = 11
string dataobject = "d_siniestros_detalle_datos_fase"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;//Ponemos una nueva linea para que se vea el datawindows
InsertRow(0)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3630
integer height = 808
long backcolor = 79741120
string text = "Clientes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom076!"
long picturemaskcolor = 536870912
dw_siniestros_detalle_promotores dw_siniestros_detalle_promotores
end type

on tabpage_2.create
this.dw_siniestros_detalle_promotores=create dw_siniestros_detalle_promotores
this.Control[]={this.dw_siniestros_detalle_promotores}
end on

on tabpage_2.destroy
destroy(this.dw_siniestros_detalle_promotores)
end on

type dw_siniestros_detalle_promotores from u_dw within tabpage_2
integer x = 18
integer y = 28
integer width = 3570
integer height = 756
integer taborder = 11
string dataobject = "d_siniestros_detalle_promotores"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3630
integer height = 808
long backcolor = 79741120
string text = "Colegiados"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Move!"
long picturemaskcolor = 536870912
dw_siniestros_detalle_colegiados dw_siniestros_detalle_colegiados
end type

on tabpage_1.create
this.dw_siniestros_detalle_colegiados=create dw_siniestros_detalle_colegiados
this.Control[]={this.dw_siniestros_detalle_colegiados}
end on

on tabpage_1.destroy
destroy(this.dw_siniestros_detalle_colegiados)
end on

type dw_siniestros_detalle_colegiados from u_dw within tabpage_1
integer x = 18
integer y = 28
integer width = 3570
integer height = 756
integer taborder = 11
string dataobject = "d_siniestros_detalle_colegiados"
boolean ib_rmbfocuschange = false
end type

event buttonclicked;call super::buttonclicked;string id_col,n_col
string tipo_alta_src, src_cia, src_n_poliza, src_cober_musaat, src_cober_otras
integer i, cant

choose case dwo.name
	case "b_busca_colegiado"
  		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()   
		if NOT f_es_vacio(id_col)  then
			i=this.GetRow()
			this.setitem(i,'id_colegiado',id_col)

			src_cia = ''
			src_n_poliza = ''
			src_cober_musaat = ''
			src_cober_otras = ''
			
			tipo_alta_src = f_tipo_alta_src(id_col)
			CHOOSE CASE tipo_alta_src 
				CASE 'S' // MUSAAT
					src_cia = 'MU'
					SELECT src_cober, src_n_poliza INTO :src_cober_musaat, :src_n_poliza FROM musaat WHERE musaat.id_col = :id_col ;
				CASE 'O'
					SELECT src_cober, numero_poliza, src_cia INTO :src_cober_otras, :src_n_poliza, :src_cia FROM src_colegiado WHERE id_colegiado= :id_col ;
			END CHOOSE		
			
			this.setitem(i,'src_cia',src_cia)
			this.setitem(i,'src_n_poliza',src_n_poliza)
			this.setitem(i,'src_cober', src_cober_musaat)
			this.setitem(i,'src_cober_otras', src_cober_otras)
		end if
		
	case 'b_ficha_col'
		id_col=this.GetItemString(row,'id_colegiado')
		select count(*) into :cant from colegiados where colegiados.id_colegiado=:id_col;
		if cant >0 then
			if not(f_es_vacio(id_col)) then
				//datos_colegiado.id_colegiado= id_colegiado
				OpenWithParm(w_fases_ficha_colegiado,id_col)
			end if
		else	
			MessageBox(g_titulo,'El colegiado NO existe.')
		end if
		
END CHOOSE
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3630
integer height = 808
long backcolor = 79741120
string text = "Incidencias"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom079!"
long picturemaskcolor = 536870912
dw_siniestros_fases_incidencias dw_siniestros_fases_incidencias
end type

on tabpage_4.create
this.dw_siniestros_fases_incidencias=create dw_siniestros_fases_incidencias
this.Control[]={this.dw_siniestros_fases_incidencias}
end on

on tabpage_4.destroy
destroy(this.dw_siniestros_fases_incidencias)
end on

type dw_siniestros_fases_incidencias from u_dw within tabpage_4
integer x = 18
integer y = 28
integer width = 3570
integer height = 756
integer taborder = 11
string dataobject = "d_siniestros_fases_incidencias"
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event doubleclicked;call super::doubleclicked;string obser,data_item


CHOOSE CASE dwo.name
	CASE 'descripcion'
		// Cogemos el valor actual y lo pasamos a la otra ventana para que se vea
		g_busqueda.titulo="Observaciones"
		obser    =this.GetItemString(row, 'descripcion')
		data_item=this.getitemstring(row, 'descripcion') // para control modificaciones
		openwithparm(w_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
			if not isnull(obser) then 
				this.SetItem(row,'descripcion',obser)
			end if 	
		end if
END CHOOSE

end event

event type long pfc_addrow();call super::pfc_addrow;// Colocamos el contador
if ancestorreturnvalue>0 then
	this.setitem(ancestorreturnvalue, 'id_incidencia', f_siguiente_numero('ID_SINIESTROS_INCIDE', 10))
end if
return Ancestorreturnvalue

end event

event type long pfc_insertrow();call super::pfc_insertrow;// Colocamos el contador
if ancestorreturnvalue>0 then
	this.setitem(ancestorreturnvalue, 'id_incidencia', f_siguiente_numero('ID_SINIESTROS_INCIDE', 10))
end if
return Ancestorreturnvalue

end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3630
integer height = 808
long backcolor = 79741120
string text = "Arquitectos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Picture!"
long picturemaskcolor = 536870912
dw_siniestros_fases_tecnicos dw_siniestros_fases_tecnicos
end type

on tabpage_5.create
this.dw_siniestros_fases_tecnicos=create dw_siniestros_fases_tecnicos
this.Control[]={this.dw_siniestros_fases_tecnicos}
end on

on tabpage_5.destroy
destroy(this.dw_siniestros_fases_tecnicos)
end on

type dw_siniestros_fases_tecnicos from u_dw within tabpage_5
integer x = 18
integer y = 28
integer width = 3570
integer height = 756
integer taborder = 11
string dataobject = "d_siniestros_fases_tecnicos"
end type

event type long pfc_addrow();call super::pfc_addrow;// Colocamos el contador
if ancestorreturnvalue>0 then
	this.setitem(ancestorreturnvalue, 'id_fase_siniestro_tecnico', f_siguiente_numero('ID_SINIESTROS_TECNIC', 10))
end if
return Ancestorreturnvalue

end event

event type long pfc_insertrow();call super::pfc_insertrow;// Colocamos el contador
if ancestorreturnvalue>0 then
	this.setitem(ancestorreturnvalue, 'id_fase_siniestro_tecnico', f_siguiente_numero('ID_SINIESTROS_TECNIC', 10))
end if
return Ancestorreturnvalue

end event

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3630
integer height = 808
long backcolor = 79741120
string text = "Tipo Da$$HEX1$$f100$$ENDHEX$$os"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "PlaceColumn5!"
long picturemaskcolor = 536870912
dw_siniestros_tipo_danyos dw_siniestros_tipo_danyos
end type

on tabpage_6.create
this.dw_siniestros_tipo_danyos=create dw_siniestros_tipo_danyos
this.Control[]={this.dw_siniestros_tipo_danyos}
end on

on tabpage_6.destroy
destroy(this.dw_siniestros_tipo_danyos)
end on

type dw_siniestros_tipo_danyos from u_dw within tabpage_6
integer x = 18
integer y = 28
integer width = 3570
integer height = 756
integer taborder = 11
string dataobject = "d_siniestros_tipo_danyos"
boolean ib_rmbmenu = false
end type

event retrieveend;call super::retrieveend;// Modificado David 10-11-2005 - Evitamos error "required value missing"
if rowcount > 0 then
	if f_es_vacio(this.getitemstring(rowcount, 'td_accidente_laboral')) then this.SetItem(rowcount, 'td_accidente_laboral', 'N')
	if f_es_vacio(this.getitemstring(rowcount, 'td_desprendimiento_tierras')) then this.SetItem(rowcount, 'td_desprendimiento_tierras', 'N')
	if f_es_vacio(this.getitemstring(rowcount, 'td_danyos_per_ajena_obras')) then this.SetItem(rowcount, 'td_danyos_per_ajena_obras', 'N')
	if f_es_vacio(this.getitemstring(rowcount, 'td_humedades')) then this.SetItem(rowcount, 'td_humedades', 'N')
	if f_es_vacio(this.getitemstring(rowcount, 'td_danyos_instalaciones')) then this.SetItem(rowcount, 'td_danyos_instalaciones', 'N')
	if f_es_vacio(this.getitemstring(rowcount, 'td_otros')) then this.SetItem(rowcount, 'td_otros', 'N')
	if f_es_vacio(this.getitemstring(rowcount, 'td_fallos_suelo')) then this.SetItem(rowcount, 'td_fallos_suelo', 'N')
	if f_es_vacio(this.getitemstring(rowcount, 'td_danyos_colindantes')) then this.SetItem(rowcount, 'td_danyos_colindantes', 'N')
	if f_es_vacio(this.getitemstring(rowcount, 'td_danyos_cosas_ajenas_obra')) then this.SetItem(rowcount, 'td_danyos_cosas_ajenas_obra', 'N')
	if f_es_vacio(this.getitemstring(rowcount, 'td_revestimientos_fachada')) then this.SetItem(rowcount, 'td_revestimientos_fachada', 'N')
	if f_es_vacio(this.getitemstring(rowcount, 'td_danyos_estructurales')) then this.SetItem(rowcount, 'td_danyos_estructurales', 'N')	
	if f_es_vacio(this.getitemstring(rowcount, 'td_danyos_alicatados')) then this.SetItem(rowcount, 'td_danyos_alicatados', 'N')	
	if f_es_vacio(this.getitemstring(rowcount, 'td_danyos_solados')) then this.SetItem(rowcount, 'td_danyos_solados', 'N')	
	this.update()
end if

end event

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3630
integer height = 808
long backcolor = 79741120
string text = "Causas Da$$HEX1$$f100$$ENDHEX$$os"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Compile!"
long picturemaskcolor = 536870912
dw_siniestros_causas_danyos dw_siniestros_causas_danyos
end type

on tabpage_7.create
this.dw_siniestros_causas_danyos=create dw_siniestros_causas_danyos
this.Control[]={this.dw_siniestros_causas_danyos}
end on

on tabpage_7.destroy
destroy(this.dw_siniestros_causas_danyos)
end on

type dw_siniestros_causas_danyos from u_dw within tabpage_7
integer x = 18
integer y = 28
integer width = 3570
integer height = 756
integer taborder = 11
string dataobject = "d_siniestros_causas_danyos"
boolean ib_rmbmenu = false
end type

event retrieveend;call super::retrieveend;// Modificado David 10-11-2005 - Evitamos error "required value missing"
if rowcount > 0 then
	if f_es_vacio(this.getitemstring(rowcount, 'cd_error_dis_proy')) then this.SetItem(rowcount, 'cd_error_dis_proy', 'N')
	if f_es_vacio(this.getitemstring(rowcount, 'cd_defectos_cimentacion')) then this.SetItem(rowcount, 'cd_defectos_cimentacion', 'N')
	if f_es_vacio(this.getitemstring(rowcount, 'cd_excavacion_excesiva')) then this.SetItem(rowcount, 'cd_excavacion_excesiva', 'N')
	if f_es_vacio(this.getitemstring(rowcount, 'cd_otras')) then this.SetItem(rowcount, 'cd_otras', 'N')
	if f_es_vacio(this.getitemstring(rowcount, 'cd_error_calculo_estructural')) then this.SetItem(rowcount, 'cd_error_calculo_estructural', 'N')
	if f_es_vacio(this.getitemstring(rowcount, 'cd_mala_ejecucion')) then this.SetItem(rowcount, 'cd_mala_ejecucion', 'N')
	if f_es_vacio(this.getitemstring(rowcount, 'cd_mal_uso')) then this.SetItem(rowcount, 'cd_mal_uso', 'N')
	this.update()
end if

end event

type dw_2 from u_dw within w_siniestros_detalle
boolean visible = false
integer x = 201
integer y = 108
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_siniestros_listados_ficha"
end type

