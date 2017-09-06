HA$PBExportHeader$w_ofertas_detalle.srw
forward
global type w_ofertas_detalle from w_detalle
end type
type tab_1 from tab within w_ofertas_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type pb_clien from picturebutton within tabpage_1
end type
type dw_ofertas_detalle_tercero_ofertante from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
pb_clien pb_clien
dw_ofertas_detalle_tercero_ofertante dw_ofertas_detalle_tercero_ofertante
end type
type tabpage_2 from userobject within tab_1
end type
type dw_ofertas_detalle_colegiados_asignados from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_ofertas_detalle_colegiados_asignados dw_ofertas_detalle_colegiados_asignados
end type
type tab_1 from tab within w_ofertas_detalle
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_ofertas_detalle from w_detalle
integer width = 3323
integer height = 2040
string title = "Detalle de Ofertas"
event csd_refrescar_datos_empresa_ofertante ( )
tab_1 tab_1
end type
global w_ofertas_detalle w_ofertas_detalle

type variables
//Instancia para guardar el valor del colegiado
string i_ofertas_lista_id_oferta,i_ofertas_lista_id_ofertante
end variables

on w_ofertas_detalle.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_ofertas_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event open;call super::open;//Enlazamos los datawindows correspondientes para poder sacar la informacion q los relaciona.
f_enlaza_dw(dw_1,tab_1.tabpage_1.dw_ofertas_detalle_tercero_ofertante,'id_ofertante','id_cliente')
f_enlaza_dw(dw_1,tab_1.tabpage_2.dw_ofertas_detalle_colegiados_asignados,'id_oferta','id_oferta')

//Redimensionamos los tabs  y las ventanas asociadas
inv_resize.of_Register (tab_1, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_1, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_1.dw_ofertas_detalle_tercero_ofertante, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_1.pb_clien, "fixedtoright")

inv_resize.of_Register (tab_1, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_2, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_2.dw_ofertas_detalle_colegiados_asignados, "scaletoright&bottom")

end event

event csd_anterior();call super::csd_anterior;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	//Cogemos el colegiado asociado a la demanda
	g_ofertas_consulta.id_ofertante= g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_ofertante")
	g_ofertas_consulta.id_oferta= g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_oferta")
	dw_1.event csd_retrieve()
end if
end event

event csd_primero();call super::csd_primero;//Preguntamos si hay filas el datawindows de la lista
if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(1)
	g_dw_lista.scrolltorow(1)
	//Cogemos el id_oferta y id_ofertante
		g_ofertas_consulta.id_oferta = g_dw_lista.getitemstring(1,"id_oferta")
		g_ofertas_consulta.id_ofertante= g_dw_lista.getitemstring(1,"id_ofertante")
	dw_1.event csd_retrieve()
end if
end event

event csd_siguiente();call super::csd_siguiente;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
		g_ofertas_consulta.id_oferta = g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_oferta")
		g_ofertas_consulta.id_ofertante = g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_ofertante")
	dw_1.event csd_retrieve()
end if

end event

event csd_ultimo();call super::csd_ultimo;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(g_dw_lista.rowcount())
	g_dw_lista.scrolltorow(g_dw_lista.rowcount())
	//Cogemos el id_siniestro y el id_fase
		g_ofertas_consulta.id_oferta= g_dw_lista.getitemstring(g_dw_lista.rowcount(),"id_oferta")
		g_ofertas_consulta.id_ofertante= g_dw_lista.getitemstring(g_dw_lista.rowcount(),"id_ofertante")
	dw_1.event csd_retrieve()
end if

end event

event csd_nuevo;call super::csd_nuevo;if AncestorReturnValue>0 then
	//Ponemos el foco dentro del datawindows principal.
	dw_1.setfocus()
	
	
	//Ponemos un valor al identificador de la oferta mediante el contador  ID_OFERTA_BT
	dw_1.SetItem(dw_1.GetRow(),'id_oferta',f_siguiente_numero('ID_OFERTA_BT',10))
	
	
	//Ponemos un valor al identificador de la oferta ; NO CONTADOR sino el siguiente numero de
	long max_oferta
	select  max(convert(integer,n_oferta)) into:max_oferta from bt_ofertas;
	
	max_oferta=max_oferta+1
	
	dw_1.SetItem(dw_1.GetRow(),'n_oferta',RightA('000000000000'+string(max_oferta),10))
	
	
	//Ponemos las variables instancia a vacio, ya que creamos una oferta nueva
	g_ofertas_consulta.id_ofertante=''
	g_ofertas_consulta.id_oferta=''
end if

return AncestorReturnValue
end event

event activate;call super::activate;g_dw_lista	= g_dw_lista_ofertas
g_w_lista   = g_lista_ofertas
g_w_detalle = g_detalle_ofertas
g_lista     = 'w_ofertas_lista'
g_detalle   = 'w_ofertas_detalle'
end event

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje=''
int retorno=1

//PERMISOS
if f_puedo_escribir(g_usuario,'0000000013')=-1 then return -1

//Validaciones del datawindows principal (dw_1)
//---------------------------------------------

mensaje=mensaje + f_valida(dw_1,'n_oferta','NOVACIO','Debe especificar un valor para el numero de oferta')
//mensaje=mensaje + f_valida(dw_1,'id_ofertante','NOVACIO','Debe especificar un valor en la Empresa Ofertante')

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno = -1
end if
return retorno
end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_ofertas_detalle
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_ofertas_detalle
end type

type cb_nuevo from w_detalle`cb_nuevo within w_ofertas_detalle
end type

type cb_ayuda from w_detalle`cb_ayuda within w_ofertas_detalle
end type

type cb_grabar from w_detalle`cb_grabar within w_ofertas_detalle
end type

type cb_ant from w_detalle`cb_ant within w_ofertas_detalle
end type

type cb_sig from w_detalle`cb_sig within w_ofertas_detalle
end type

type dw_1 from w_detalle`dw_1 within w_ofertas_detalle
integer x = 37
integer y = 32
integer width = 3150
integer height = 772
string dataobject = "d_ofertas_detalle"
boolean border = false
end type

event dw_1::csd_retrieve();//Comprobamos que la variabe que le pasamos, en este caso el identificador de la oferta
if g_ofertas_consulta.id_oferta= '' or isnull(g_ofertas_consulta.id_oferta) then return
int    retorno
double i
//Cerramos la consulta
retorno = parent.event closequery()
if retorno = 1 then return
//Retriveamos los datos de la oferta
this.retrieve(g_ofertas_consulta.id_oferta)

//Vaciamos la variable instancia del colegiado
g_ofertas_consulta.id_oferta=''
end event

event dw_1::buttonclicked;call super::buttonclicked;string id_ofertante,id_cli,nif_ofertante
st_ficha_cliente datos_cliente
integer resp

choose case dwo.name
	case 'b_busqueda_ofertante'
	//Abrimos la ventana de b$$HEX1$$fa00$$ENDHEX$$squeda de ofertantes
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Empresas"
		g_busqueda.dw="d_lista_busqueda_terceros"
		id_ofertante=f_busqueda_terceros(g_terceros_codigos.ofertante)
		if f_es_vacio(id_ofertante) then return
		dw_1.SetItem(1,'id_ofertante',id_ofertante)
		//Retriveamos el tab para que refresque cada vez
		tab_1.tabpage_1.dw_ofertas_detalle_tercero_ofertante.retrieve(id_ofertante)
case 'insertar_tercero'
	nif_ofertante= f_siguiente_nif_ofer()
	//Para que pregunte si quiere que insertemos un nuevo ofertante automaticamente
	resp=MessageBox(g_titulo,'$$HEX1$$bf00$$ENDHEX$$Desea dar de alta a un nuevo ofertante?',Question!,YesNo!,1)
	if resp=1 then 
	//Aqui va el c$$HEX1$$f300$$ENDHEX$$digo q abre la ventana 
		datos_cliente.nif=nif_ofertante
		datos_cliente.tipo_tercero = g_terceros_codigos.ofertante
		OpenWithParm(w_fases_ficha_cliente,datos_cliente)
		id_cli = Message.StringParm
		this.SetItem(this.getrow(),'id_ofertante',id_cli)
		//Retriveamos el tab para que refresque cada vez
		tab_1.tabpage_1.dw_ofertas_detalle_tercero_ofertante.retrieve(id_cli)
	end if
case else
end choose

end event

event dw_1::itemchanged;call super::itemchanged;//Para cuando se coga el tipo de trabajo....
string tipo_trabajo
choose case dwo.name
	case 'tipo_obra'
		SELECT tipos_trabajos.d_t_trabajo INTO :tipo_trabajo FROM tipos_trabajos WHERE tipos_trabajos.c_t_trabajo=:data;
		this.SetItem(1,'tipo_trabajo',tipo_trabajo)

END CHOOSE



end event

type tab_1 from tab within w_ofertas_detalle
integer x = 37
integer y = 904
integer width = 3150
integer height = 892
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
integer x = 18
integer y = 112
integer width = 3113
integer height = 764
long backcolor = 79741120
string text = "Empresa Ofertante "
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "OleGenReg!"
long picturemaskcolor = 536870912
pb_clien pb_clien
dw_ofertas_detalle_tercero_ofertante dw_ofertas_detalle_tercero_ofertante
end type

on tabpage_1.create
this.pb_clien=create pb_clien
this.dw_ofertas_detalle_tercero_ofertante=create dw_ofertas_detalle_tercero_ofertante
this.Control[]={this.pb_clien,&
this.dw_ofertas_detalle_tercero_ofertante}
end on

on tabpage_1.destroy
destroy(this.pb_clien)
destroy(this.dw_ofertas_detalle_tercero_ofertante)
end on

type pb_clien from picturebutton within tabpage_1
integer x = 2793
integer y = 80
integer width = 297
integer height = 160
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Ficha Ampliada"
boolean originalsize = true
vtextalign vtextalign = multiline!
end type

event clicked;IF dw_ofertas_detalle_tercero_ofertante.rowcount() <= 0 then return

g_dw_lista_clientes = dw_ofertas_detalle_tercero_ofertante
g_clientes_consulta.id_cliente = dw_ofertas_detalle_tercero_ofertante.GetItemString(dw_ofertas_detalle_tercero_ofertante.GetRow(), 'id_cliente')

// Para ir a su ficha, debe estar introducido anteriormente
int cliente

SELECT count(*) INTO :cliente  FROM clientes  
WHERE clientes.id_cliente = :g_clientes_consulta.id_cliente   ;

if cliente=0 then return 

OpenSheet(g_detalle_clientes, 'w_clientes_detalle',  w_aplic_frame, 0, original!)

DO WHILE isvalid(g_detalle_clientes)
	yield()
LOOP

// Refrescamos por si han hecho cambios
tab_1.tabpage_1.dw_ofertas_detalle_tercero_ofertante.retrieve(dw_1.getitemstring(1, 'id_ofertante'))


end event

type dw_ofertas_detalle_tercero_ofertante from u_dw within tabpage_1
integer x = 23
integer y = 52
integer width = 2816
integer height = 656
integer taborder = 11
string dataobject = "d_ofertas_detalle_tercero_ofertante"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3113
integer height = 764
long backcolor = 79741120
string text = "Colegiados Asignados"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Move!"
long picturemaskcolor = 536870912
dw_ofertas_detalle_colegiados_asignados dw_ofertas_detalle_colegiados_asignados
end type

on tabpage_2.create
this.dw_ofertas_detalle_colegiados_asignados=create dw_ofertas_detalle_colegiados_asignados
this.Control[]={this.dw_ofertas_detalle_colegiados_asignados}
end on

on tabpage_2.destroy
destroy(this.dw_ofertas_detalle_colegiados_asignados)
end on

type dw_ofertas_detalle_colegiados_asignados from u_dw within tabpage_2
integer x = 23
integer y = 52
integer width = 2816
integer height = 656
integer taborder = 11
string dataobject = "d_ofertas_detalle_colegiados_asignados"
boolean border = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;string id_colegiado,tipo_bolsa
double cant

choose case dwo.name
	case 'cb_busqueda_colegiados'
		tipo_bolsa=dw_1.GetItemString(1,'tipo_bolsa')
		If not(f_es_vacio(tipo_bolsa)) then
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados Asignados"
			g_busqueda.dw="d_lista_busqueda_colegiados_bolsa"
			//LLamamos a la funcion de colegiados pasandole el tipo de bolsa
			if g_colegio = 'COAATGC' then
      			id_colegiado=f_busqueda_colegiados_asignados_1(tipo_bolsa)
		     else
				id_colegiado=f_busqueda_colegiados_asignados(tipo_bolsa)
			end if
		end if 
		if f_es_vacio(id_colegiado) then return
		this.Setitem(row,'id_colegiado',id_colegiado)
		
	case 'b_ficha_col'
		id_colegiado=this.GetItemString(row,'id_colegiado')
		select count(*) into :cant from colegiados where colegiados.id_colegiado=:id_colegiado;
		if cant >0 then
			if not(f_es_vacio(id_colegiado)) then
				//datos_colegiado.id_colegiado= id_colegiado
				OpenWithParm(w_fases_ficha_colegiado,id_colegiado)
			end if
		else	
			MessageBox(g_titulo,'El colegiado NO existe.')
		end if
end choose

end event

event type long pfc_addrow();call super::pfc_addrow;//Ponemos un valor al identificador de la oferta mediante el contador  ID_OFERTA_ASIGNADA
this.SetItem(ancestorreturnvalue,'id_ofertas_asigna',f_siguiente_numero('ID_OFERTA_ASIGNA',10))
return AncestorReturnValue

end event

event type long pfc_insertrow();call super::pfc_insertrow;//Ponemos un valor al identificador de la oferta mediante el contador  ID_OFERTA_ASIGNADA
this.SetItem(ancestorreturnvalue,'id_ofertas_asigna',f_siguiente_numero('ID_OFERTA_ASIGNA',10))
return AncestorReturnValue

end event

