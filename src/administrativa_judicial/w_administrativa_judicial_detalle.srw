HA$PBExportHeader$w_administrativa_judicial_detalle.srw
forward
global type w_administrativa_judicial_detalle from w_detalle
end type
type tab_1 from tab within w_administrativa_judicial_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_administrativa_judicial_detalle_fase from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_administrativa_judicial_detalle_fase dw_administrativa_judicial_detalle_fase
end type
type tabpage_2 from userobject within tab_1
end type
type dw_administrativa_judicial_detalle_promo from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_administrativa_judicial_detalle_promo dw_administrativa_judicial_detalle_promo
end type
type tabpage_3 from userobject within tab_1
end type
type dw_administrativa_judicial_detalle_col from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_administrativa_judicial_detalle_col dw_administrativa_judicial_detalle_col
end type
type tab_1 from tab within w_administrativa_judicial_detalle
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_administrativa_judicial_detalle from w_detalle
integer width = 3488
integer height = 1916
string title = "Detalle V$$HEX1$$ed00$$ENDHEX$$a Administrativa y Judicial"
tab_1 tab_1
end type
global w_administrativa_judicial_detalle w_administrativa_judicial_detalle

type variables
u_dw idw_contrato, idw_clientes, idw_colegiados
end variables

on w_administrativa_judicial_detalle.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_administrativa_judicial_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event activate;call super::activate;g_dw_lista	= g_dw_lista_ad_judicial
g_w_lista   = g_lista_ad_judicial
g_w_detalle = g_detalle_ad_judicial
g_lista     = 'w_administrativa_judicial_lista'
g_detalle   = 'w_administrativa_judicial_detalle'
end event

event open;call super::open;idw_contrato = tab_1.tabpage_1.dw_administrativa_judicial_detalle_fase
idw_clientes = tab_1.tabpage_2.dw_administrativa_judicial_detalle_promo
idw_colegiados = tab_1.tabpage_3.dw_administrativa_judicial_detalle_col

//Enlazamos los datawindows correspondientes para poder sacar la informacion q los relaciona.
f_enlaza_dw(dw_1,idw_colegiados,'id_administracion','id_administracion')
f_enlaza_dw(dw_1,idw_contrato,'id_fase','id_fase')
f_enlaza_dw(dw_1,idw_clientes,'id_fase','id_fase')

//Redimensionamos los tabs  y las ventanas asociadas
inv_resize.of_Register (tab_1, "scaletoright&bottom")
inv_resize.of_Register (idw_contrato, "scaletoright&bottom")
inv_resize.of_Register (idw_clientes, "scaletoright&bottom")
inv_resize.of_Register (idw_colegiados, "scaletoright&bottom")

end event

event csd_anterior();call super::csd_anterior;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	//Cogemos el id_administracion y el id_fase
//	g_ad_judicial_consulta.id_fase = g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_fase")
	g_ad_judicial_consulta.id_administracion = g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_administracion")
	dw_1.event csd_retrieve()
end if
end event

event csd_primero();call super::csd_primero;//Preguntamos si hay filas el datawindows de la lista
if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(1)
	g_dw_lista.scrolltorow(1)
	//Cogemos el id_administracion y el id_fase
	g_ad_judicial_consulta.id_administracion = g_dw_lista.getitemstring(1,"id_administracion")
//	g_ad_judicial_consulta.id_fase = g_dw_lista.getitemstring(1,"id_fase")
	dw_1.event csd_retrieve()
end if
end event

event csd_siguiente();call super::csd_siguiente;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	//Cogemos el id_administracion y el id_fase
//	g_ad_judicial_consulta.id_fase = g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_fase")
	g_ad_judicial_consulta.id_administracion = g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_administracion")
	dw_1.event csd_retrieve()
end if

end event

event csd_ultimo();call super::csd_ultimo;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(g_dw_lista.rowcount())
	g_dw_lista.scrolltorow(g_dw_lista.rowcount())
	//Cogemos el id_administracion y el id_fase
	g_ad_judicial_consulta.id_administracion = g_dw_lista.getitemstring(g_dw_lista.rowcount(),"id_administracion")
//	g_ad_judicial_consulta.id_fase = g_dw_lista.getitemstring(g_dw_lista.rowcount(),"id_fase")
	
	dw_1.event csd_retrieve()
end if

end event

event type integer csd_nuevo();call super::csd_nuevo;if AncestorReturnValue>0 then
	//Introducimos en el campo clave el valor obtenido desde el contador.
	dw_1.SetItem(dw_1.GetRow(),'id_administracion',f_siguiente_numero('ID_ADMINISTRACION',10))
	
	//Ponemos el numero del registro; NO CONTADOR sino el numero de registro q tengamos.
	integer max_registro
	select  max(convert(integer,n_interno)) into:max_registro from fases_administrativa_judicial;
	
	
	if isnull(max_registro) then 
		max_registro=1 
	else 
		max_registro=max_registro+1
	end if 
	
	dw_1.SetItem(dw_1.GetRow(),'n_interno',RightA('000000000000'+string(max_registro),10))
	
	dw_1.SetItem(dw_1.GetRow(),'fecha',today())
	//donde "n" es un entero que indica la longitud en caracteres del contador
	dw_1.setfocus()
	
//	//Vaciamos la variable global id_administracion y de id_fase
//	g_ad_judicial_consulta.id_administracion=''
//	g_ad_judicial_consulta.id_fase=''
//	//Datawindows de datos de colegiados
//	tab_1.tabpage_3.dw_administrativa_judicial_detalle_col.retrieve(g_ad_judicial_consulta.id_fase)
//	//Datawindows de clientes
//	tab_1.tabpage_2.dw_administrativa_judicial_detalle_promo.retrieve(g_ad_judicial_consulta.id_fase)
//	//Datawindows de la fase
//	tab_1.tabpage_1.dw_administrativa_judicial_detalle_fase.retrieve(g_ad_judicial_consulta.id_administracion)
end if

return AncestorReturnValue
end event

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje=''

//PERMISOS
if f_puedo_escribir(g_usuario,'0000000035')=-1 then return -1

mensaje=mensaje + f_valida(dw_1,'n_interno','NOVACIO','Debe especificar un valor en n$$HEX1$$fa00$$ENDHEX$$mero del siniestro')
//mensaje=mensaje + f_valida(dw_1,'n_musaat','NOVACIO','Debe especificar un valor en numero del musaat')

int retorno=1
if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno = -1
end if
return retorno

end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_administrativa_judicial_detalle
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_administrativa_judicial_detalle
end type

type cb_nuevo from w_detalle`cb_nuevo within w_administrativa_judicial_detalle
end type

type cb_ayuda from w_detalle`cb_ayuda within w_administrativa_judicial_detalle
end type

type cb_grabar from w_detalle`cb_grabar within w_administrativa_judicial_detalle
end type

type cb_ant from w_detalle`cb_ant within w_administrativa_judicial_detalle
end type

type cb_sig from w_detalle`cb_sig within w_administrativa_judicial_detalle
end type

type dw_1 from w_detalle`dw_1 within w_administrativa_judicial_detalle
integer width = 3351
integer height = 856
string dataobject = "d_administrativa_judicial_detalle"
boolean border = false
end type

event dw_1::buttonclicked;call super::buttonclicked;CHOOSE CASE dwo.name
	CASE 'b_busqueda_fase'
		string id_fase,id_administracion,id_colegiado
		integer fila,i
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
//			g_ad_judicial_consulta.id_fase=id_fase
			//Datawindows de datos de la fase
			idw_contrato.retrieve(id_fase)
			//Datawindows de clientes
			idw_clientes.retrieve(id_fase)
			//Insertamos dentro de la tabla fases_administrativa_jud_col
			id_administracion=dw_1.GetItemString(1,'id_administracion')
			ds_fases_colegiados.retrieve(id_fase)
		
			for i = 1 to ds_fases_colegiados.rowcount()
				fila=idw_colegiados.InsertRow(0)
				id_colegiado=ds_fases_colegiados.GetItemString(i,'id_col')
				//Para coger la poliza y la cobertura
				string poliza, cobertura,desc_poliza
				double prima_cobertura
				select musaat.src_n_poliza, musaat.src_cober into :poliza, :cobertura from musaat where musaat.id_col=:id_colegiado;
				select musaat_cober_src.prima into :prima_cobertura from  musaat_cober_src where musaat_cober_src.codigo=:cobertura;
			
				idw_colegiados.SetItem(fila,'id_administracion',id_administracion)
				idw_colegiados.SetItem(fila,'id_colegiado',id_colegiado)
				idw_colegiados.SetItem(fila,'src_n_poliza',poliza)
				idw_colegiados.SetItem(fila,'src_cober',cobertura)
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

event dw_1::csd_retrieve();call super::csd_retrieve;//Comprobamos que la variabe que le pasamos, en este caso el identificador de la administracion
if g_ad_judicial_consulta.id_administracion ='' or isnull(g_ad_judicial_consulta.id_administracion) then return
int    retorno
double i
//Cerramos la consulta
retorno = parent.event closequery()
if retorno = 1 then return
//Retriveamos los datos del administracion
this.retrieve(g_ad_judicial_consulta.id_administracion)
////Datawindows de datos de la fase
//tab_1.tabpage_1.dw_administrativa_judicial_detalle_fase.retrieve(g_ad_judicial_consulta.id_fase)
////Datawindows de clientes
//tab_1.tabpage_2.dw_administrativa_judicial_detalle_promo.retrieve(g_ad_judicial_consulta.id_fase)
////Datawindows de colegiados
//tab_1.tabpage_3.dw_administrativa_judicial_detalle_col.retrieve(g_ad_judicial_consulta.id_administracion)

//Vaciamos la variable global id_administracion y de id_fase
g_ad_judicial_consulta.id_administracion=''
//g_ad_judicial_consulta.id_fase=''
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

type tab_1 from tab within w_administrativa_judicial_detalle
integer x = 18
integer y = 956
integer width = 3410
integer height = 716
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
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3374
integer height = 588
long backcolor = 79741120
string text = "Contrato"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Cascade!"
long picturemaskcolor = 536870912
dw_administrativa_judicial_detalle_fase dw_administrativa_judicial_detalle_fase
end type

on tabpage_1.create
this.dw_administrativa_judicial_detalle_fase=create dw_administrativa_judicial_detalle_fase
this.Control[]={this.dw_administrativa_judicial_detalle_fase}
end on

on tabpage_1.destroy
destroy(this.dw_administrativa_judicial_detalle_fase)
end on

type dw_administrativa_judicial_detalle_fase from u_dw within tabpage_1
integer x = 18
integer y = 20
integer width = 3342
integer height = 556
integer taborder = 11
string dataobject = "d_administrativa_judicial_detalle_fase"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3374
integer height = 588
long backcolor = 79741120
string text = "Clientes"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom076!"
long picturemaskcolor = 536870912
dw_administrativa_judicial_detalle_promo dw_administrativa_judicial_detalle_promo
end type

on tabpage_2.create
this.dw_administrativa_judicial_detalle_promo=create dw_administrativa_judicial_detalle_promo
this.Control[]={this.dw_administrativa_judicial_detalle_promo}
end on

on tabpage_2.destroy
destroy(this.dw_administrativa_judicial_detalle_promo)
end on

type dw_administrativa_judicial_detalle_promo from u_dw within tabpage_2
integer x = 18
integer y = 20
integer width = 3342
integer height = 556
integer taborder = 11
string dataobject = "d_administrativa_judicial_detalle_promo"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3374
integer height = 588
long backcolor = 79741120
string text = "Colegiados"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Move!"
long picturemaskcolor = 536870912
dw_administrativa_judicial_detalle_col dw_administrativa_judicial_detalle_col
end type

on tabpage_3.create
this.dw_administrativa_judicial_detalle_col=create dw_administrativa_judicial_detalle_col
this.Control[]={this.dw_administrativa_judicial_detalle_col}
end on

on tabpage_3.destroy
destroy(this.dw_administrativa_judicial_detalle_col)
end on

type dw_administrativa_judicial_detalle_col from u_dw within tabpage_3
integer x = 18
integer y = 20
integer width = 3342
integer height = 556
integer taborder = 11
string dataobject = "d_administrativa_judicial_detalle_col"
end type

event retrieveend;call super::retrieveend;integer i
string cobertura

for i=1 to this.Rowcount()
	cobertura=this.getItemstring(i,'src_cober')
	if cobertura<>'00'then
		this.setitem(i,'compute_0005','S')
		this.setitemStatus(i,'compute_0005',primary!,notmodified!)
		this.setitemStatus(i,0,primary!,notmodified!)
	end if
next 	

end event

event itemchanged;call super::itemchanged;string cobertura
integer i
choose case dwo.name
	case "src_cober"
		if NOT f_es_vacio(data) then
			i=this.GetRow()
			this.setitem(i,'compute_0005','S')
		end if
		iF data='00' then 
			i=this.GetRow()
			this.setitem(i,'compute_0005','N')
		end if

	
END CHOOSE
end event

event buttonclicked;call super::buttonclicked;string id_col,n_col,desc_pob
string pob, cobertura
integer i
choose case dwo.name
	case "b_busca_colegiado"
  		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()   
		if NOT f_es_vacio(id_col)  then
			i=this.GetRow()
			this.setitem(i,'id_colegiado',id_col)
			this.setitem(i,'src_n_poliza',f_musaat_numpol(id_col))
			SELECT musaat.src_cober INTO :cobertura FROM musaat WHERE musaat.id_col = :id_col ;
			this.setitem(i,'src_cober', cobertura)
		end if
	
END CHOOSE
end event

