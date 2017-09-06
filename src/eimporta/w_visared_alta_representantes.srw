HA$PBExportHeader$w_visared_alta_representantes.srw
forward
global type w_visared_alta_representantes from w_response
end type
type cb_1 from commandbutton within w_visared_alta_representantes
end type
type cb_aceptar from commandbutton within w_visared_alta_representantes
end type
type dw_3 from u_dw within w_visared_alta_representantes
end type
type dw_tipos_clientes from u_dw within w_visared_alta_representantes
end type
end forward

global type w_visared_alta_representantes from w_response
integer width = 2592
integer height = 1660
string title = "Alta Representantes VISARED"
cb_1 cb_1
cb_aceptar cb_aceptar
dw_3 dw_3
dw_tipos_clientes dw_tipos_clientes
end type
global w_visared_alta_representantes w_visared_alta_representantes

type variables
long il_numero_cli
end variables

event open;string id_cliente,tipo,prov
st_clientes datos_cliente
//string pob

f_centrar_ventana(this)
datos_cliente = message.PowerObjectParm
il_numero_cli=long(datos_cliente.numero_cliente)
if IsNumber(datos_cliente.cod_prov) then 
	prov=RightA('00000'+datos_cliente.cod_prov,5)
else
	prov=datos_cliente.cod_prov+'%'
	select cod_provincia into :prov from provincias where nombre like :prov;
end if	

//Ficha del cliente
id_cliente = f_siguiente_numero('CLIENTES',10)
dw_3.InsertRow(0)
dw_3.SetItem(dw_3.GetRow(),'id_cliente',id_cliente)
dw_3.SetItem(dw_3.GetRow(),'n_cliente',datos_cliente.n_cliente)
dw_3.SetItem(dw_3.GetRow(),'apellidos',datos_cliente.apellidos)
dw_3.SetItem(dw_3.GetRow(),'nombre',datos_cliente.nombre)
dw_3.SetItem(dw_3.GetRow(),'nif',datos_cliente.nif)
dw_3.SetItem(dw_3.GetRow(),'tipo_persona',datos_cliente.tipo_persona)
dw_3.SetItem(dw_3.GetRow(),'sexo',datos_cliente.sexo)
dw_3.SetItem(dw_3.GetRow(),'observaciones','Cliente dado de alta mediante Visado Electr$$HEX1$$f300$$ENDHEX$$nico')
dw_3.SetItem(dw_3.GetRow(),'email',datos_cliente.email)
dw_3.SetItem(dw_3.GetRow(),'url',datos_cliente.url)
dw_3.SetItem(dw_3.GetRow(),'tipo_via',datos_cliente.tipo_via)
dw_3.SetItem(dw_3.GetRow(),'nombre_via',datos_cliente.nombre_via)
// CAMBIADO LUIS 19/4/2005
//TEMPORAL, AQUI TENEMOS LA DESCRIPCION, ASI QUE AVERIGUAMOS EL CODIGO DE POBLACION
//select cod_pob into :pob from poblaciones where descripcion like :datos_cliente.cod_pob;
//dw_3.SetItem(dw_3.GetRow(),'cod_pob',pob)
dw_3.SetItem(dw_3.GetRow(),'cod_pob',datos_cliente.cod_pob)
dw_3.SetItem(dw_3.GetRow(),'cod_prov',prov)
dw_3.SetItem(dw_3.GetRow(),'pais',datos_cliente.pais)

//dw_3.SetItem(dw_3.GetRow(),'cp',f_devuelve_cod_postal(pob)) // CAMBIADO LUIS 19/4/2005
dw_3.SetItem(dw_3.GetRow(),'cp',datos_cliente.cp)
dw_3.SetItem(dw_3.GetRow(),'telefono',datos_cliente.telefono)
dw_3.SetItem(dw_3.GetRow(),'fax',datos_cliente.fax)
//dw_3.SetItem(dw_3.GetRow(),'cuenta_banco',datos_cliente.cuenta_banco)

if not LeftA(g_colegio,5)='COAAT' then // los aparejadores no tienen $$HEX1$$e900$$ENDHEX$$sta opci$$HEX1$$f300$$ENDHEX$$n
	dw_3.SetItem(dw_3.GetRow(),'empresa',g_empresa)
end if

//Tipo de Tercero
dw_tipos_clientes.InsertRow(0)
dw_tipos_clientes.SetItem(dw_tipos_clientes.GetRow(),'id',f_siguiente_numero('CLIENTES_TERCEROS',10))
dw_tipos_clientes.SetItem(dw_tipos_clientes.GetRow(),'id_cliente',id_cliente)

string tipo_tercero = '23'
dw_tipos_clientes.SetItem(dw_tipos_clientes.GetRow(),'c_tercero', tipo_tercero)


	

end event

on w_visared_alta_representantes.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_aceptar=create cb_aceptar
this.dw_3=create dw_3
this.dw_tipos_clientes=create dw_tipos_clientes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_aceptar
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.dw_tipos_clientes
end on

on w_visared_alta_representantes.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_aceptar)
destroy(this.dw_3)
destroy(this.dw_tipos_clientes)
end on

event pfc_preupdate;call super::pfc_preupdate;string cod_pob,tipo_via
long numero


cod_pob=dw_3.getItemString(1,'cod_pob')
tipo_via=dw_3.getItemString(1,'tipo_via')
select count(*) into :numero from poblaciones where cod_pob = :cod_pob;

if numero<1 then
	MessageBox("Poblaci$$HEX1$$f300$$ENDHEX$$n","No existe la poblaci$$HEX1$$f300$$ENDHEX$$n seleccionada. Corrijala antes de continuar")
	return -1
end if

select count(*) into :numero from tipos_via where cod_tipo_via = :tipo_via;

if numero<1 then
	MessageBox("Tipo de Via","No existe el tipo de v$$HEX1$$ed00$$ENDHEX$$a seleccionado. Corrijalo antes de continuar")
	return -1
end if

return 1
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_visared_alta_representantes
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_visared_alta_representantes
end type

type cb_1 from commandbutton within w_visared_alta_representantes
integer x = 1307
integer y = 1400
integer width = 462
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;dw_3.ResetUpdate()
dw_tipos_clientes.ResetUpdate()
CloseWithReturn(parent,-1)
end event

type cb_aceptar from commandbutton within w_visared_alta_representantes
integer x = 750
integer y = 1396
integer width = 462
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;int res
res=parent.event pfc_save() 
if res<0 then return

g_campos_subsanados.rep_nif[il_numero_cli]=dw_3.GetItemString(dw_3.Getrow(),'nif')

CloseWithReturn(parent,1)
end event

type dw_3 from u_dw within w_visared_alta_representantes
event csd_asignar_nif ( )
integer x = 87
integer y = 48
integer width = 2427
integer height = 1276
integer taborder = 10
string dataobject = "d_fases_clientes_ficha"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event csd_asignar_nif;string nif,letra

nif = f_siguiente_numero('CLIENTES_IND',8)

letra = f_calcula_letra_nif(nif)
nif = nif + letra

this.SetItem(1,'nif',nif)
end event

event buttonclicked;string pob,cod_provincia,cod_postal,cod_pais
choose case dwo.name
	CASE 'b_pobla'
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		
		cod_provincia=f_devuelve_cod_provincia(pob)
		cod_postal=f_devuelve_cod_postal(pob)
		cod_pais=f_devuelve_cod_pais(pob)
			
		this.setitem(1,'cod_pob',pob)
		this.setitem(1,'cp',cod_postal)
		this.setitem(1,'cod_prov',cod_provincia)
		this.setitem(1,'pais',cod_pais)		
		
	CASE ELSE
end choose
end event

event itemchanged;call super::itemchanged;string cod_postal,cod_provincia,cod_pais,nif_
string nif,letra

choose case dwo.name
	case 'cod_pob'
		cod_provincia=f_devuelve_cod_provincia(data)
		cod_postal=f_devuelve_cod_postal(data)
		cod_pais=f_devuelve_cod_pais(data)
			
		this.setitem(1,'cp',cod_postal)
		this.setitem(1,'cod_prov',cod_provincia)
		this.setitem(1,'pais',cod_pais)		
	CASE 'nif'
		nif_ = string(data)
		if data='IND' or data ='ind' then this.Postevent('csd_asignar_nif')
		this.setitem(row,'nif',f_formatear_nif(nif_))
end choose
end event

event itemfocuschanged;string nif_

nif_ = this.getitemstring(1,'nif')
if nif_='IND' or nif_ ='ind' then this.Postevent('csd_asignar_nif')
this.setitem(row,'nif',f_formatear_nif(nif_))



end event

type dw_tipos_clientes from u_dw within w_visared_alta_representantes
boolean visible = false
integer x = 2249
integer y = 1032
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_clientes_terceros"
end type

