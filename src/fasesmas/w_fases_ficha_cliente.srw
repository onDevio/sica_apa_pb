HA$PBExportHeader$w_fases_ficha_cliente.srw
forward
global type w_fases_ficha_cliente from w_response
end type
type dw_clientes_terceros from u_dw within w_fases_ficha_cliente
end type
type cb_1 from commandbutton within w_fases_ficha_cliente
end type
type cb_aceptar from commandbutton within w_fases_ficha_cliente
end type
type dw_3 from u_dw within w_fases_ficha_cliente
end type
type cb_2 from commandbutton within w_fases_ficha_cliente
end type
end forward

global type w_fases_ficha_cliente from w_response
integer x = 214
integer y = 221
integer width = 2386
integer height = 1696
string title = "Informaci$$HEX1$$f300$$ENDHEX$$n Cliente"
boolean contexthelp = true
dw_clientes_terceros dw_clientes_terceros
cb_1 cb_1
cb_aceptar cb_aceptar
dw_3 dw_3
cb_2 cb_2
end type
global w_fases_ficha_cliente w_fases_ficha_cliente

type variables

end variables

event open;call super::open;string id_cliente
st_ficha_cliente datos_cliente

f_centrar_ventana(this)
datos_cliente = message.PowerObjectParm
if not(f_es_vacio(datos_cliente.id_cliente)) then
	dw_3.Retrieve(datos_cliente.id_cliente)
	dw_3.Enabled = False
end if

if not(f_es_vacio(datos_cliente.nif)) then
	dw_3.SetTabOrder('nif',0)
	dw_3.Enabled = True
	dw_3.InsertRow(0)
	dw_3.SetItem(dw_3.GetRow(),'id_cliente',f_siguiente_numero('CLIENTES',10))
	dw_3.SetItem(dw_3.GetRow(),'nif',datos_cliente.nif)
	dw_3.SetItem(dw_3.GetRow(),'empresa',g_empresa)
	if LeftA(datos_cliente.nif,4) <> "AUTO" and not isnumber(LeftA(datos_cliente.nif,1)) then
		dw_3.SetItem(dw_3.GetRow(),'tipo_persona',"1") // Si el NIF empieza por letra es una persona juridica
	end if
	// Le metemos tipo de tercero cliente
	dw_clientes_terceros.insertrow(0)
	dw_clientes_terceros.SetItem(1,'id',f_siguiente_numero('CLIENTES_TERCEROS',10))
	dw_clientes_terceros.SetItem(1,'id_cliente',dw_3.getitemstring(dw_3.getrow(), 'id_cliente'))
	dw_clientes_terceros.SetItem(1,'c_tercero',datos_cliente.tipo_tercero)	
end if	

end event

on w_fases_ficha_cliente.create
int iCurrent
call super::create
this.dw_clientes_terceros=create dw_clientes_terceros
this.cb_1=create cb_1
this.cb_aceptar=create cb_aceptar
this.dw_3=create dw_3
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_clientes_terceros
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_aceptar
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.cb_2
end on

on w_fases_ficha_cliente.destroy
call super::destroy
destroy(this.dw_clientes_terceros)
destroy(this.cb_1)
destroy(this.cb_aceptar)
destroy(this.dw_3)
destroy(this.cb_2)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_ficha_cliente
integer x = 2318
integer y = 1352
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_ficha_cliente
integer x = 2318
integer y = 1464
end type

type dw_clientes_terceros from u_dw within w_fases_ficha_cliente
boolean visible = false
integer x = 1605
integer y = 1432
integer taborder = 20
string dataobject = "d_clientes_terceros"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_1 from commandbutton within w_fases_ficha_cliente
integer x = 974
integer y = 1424
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
Close(parent)
end event

type cb_aceptar from commandbutton within w_fases_ficha_cliente
integer x = 416
integer y = 1424
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
end type

event clicked;parent.TriggerEvent('pfc_save')
// Avisar si existe un colegiado con el nif del tercero
if not f_es_vacio(f_colegiado_id_colegiado(dw_3.getitemstring(1, 'nif'))) then 
	messagebox(g_titulo, "AVISO DUPLICIDAD DE NIF: Existe un colegiado con este nif")
end if
CloseWithReturn(parent,dw_3.GetItemString(1,'id_cliente'))

end event

type dw_3 from u_dw within w_fases_ficha_cliente
integer x = 37
integer y = 32
integer width = 2313
integer height = 1300
integer taborder = 10
string dataobject = "d_fases_clientes_ficha"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;string pob
choose case dwo.name
	CASE 'b_pobla'
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(1,'cod_pob',pob)
		this.SetItem(1,'cp',f_devuelve_cod_postal(pob))
		this.SetItem(1,'cod_prov',f_devuelve_cod_provincia(pob))
		this.SetItem(1,'pais',f_devuelve_cod_pais(pob))
end choose
end event

event itemchanged;call super::itemchanged;string pob, cod
long num_pob

choose case dwo.name
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

		
//		if f_es_vacio(data) then return
//		this.SetItem(1,'cod_pob',data)
//		this.SetItem(1,'cp',f_devuelve_cod_postal(data))
//		this.SetItem(1,'cod_prov',f_devuelve_cod_provincia(data))
//		this.SetItem(1,'pais',f_devuelve_cod_pais(data))
end choose

end event

event csd_tecla;call super::csd_tecla;if key = keyF4! and this.getcolumnname() = 'nombre_via' then
	st_busqueda_calles_llamada lst_llamada
	st_busqueda_calles_retorno lst_retorno
	 
	g_busqueda.titulo='B$$HEX1$$fa00$$ENDHEX$$squeda de calles'
	g_busqueda.dw='d_calles_busqueda'
	 
	// Si le pasamos un codigo de provincia en lst_llamada s$$HEX1$$f300$$ENDHEX$$lo se pueden buscar calles de esa provincia
	if not f_es_vacio(g_cod_prov_colegio) then lst_llamada.cod_provincia = '000' + g_cod_prov_colegio
	 
	openwithparm(w_busqueda_calles,lst_llamada)
	 
	lst_retorno=Message.Powerobjectparm
	 
	// Antes de mostrar los resultados hay que comprobar que los campos no sean vacios 
	if not isvalid(lst_retorno) then
		return
	else
		this.setitem(1, 'cod_pob', lst_retorno.cod_poblacion)
		this.setitem(1, 'cp', lst_retorno.cod_pos)
		this.setitem(1, 'nombre_via', lst_retorno.calle)
		this.SetItem(1, 'cod_prov', f_devuelve_cod_provincia(lst_retorno.cod_poblacion))
		this.SetItem(1, 'pais', f_devuelve_cod_pais(lst_retorno.cod_poblacion))		
	end if
end if

end event

type cb_2 from commandbutton within w_fases_ficha_cliente
integer x = 1531
integer y = 1424
integer width = 462
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Ficha Ampliada"
end type

event clicked;IF dw_3.rowcount() <= 0 then return

g_dw_lista_clientes = dw_3
g_clientes_consulta.id_cliente = dw_3.GetItemString(dw_3.GetRow(), 'id_cliente')

// Para ir a su ficha, debe estar introducido anteriormente
int cliente

SELECT count(*) 
INTO :cliente  
FROM clientes  
WHERE clientes.id_cliente = :g_clientes_consulta.id_cliente   ;

if cliente=0 then return 

OpenSheet(g_detalle_clientes, 'w_clientes_detalle',  w_aplic_frame, 0, original!)

close(parent)

end event

