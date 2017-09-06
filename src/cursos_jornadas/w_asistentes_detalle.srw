HA$PBExportHeader$w_asistentes_detalle.srw
forward
global type w_asistentes_detalle from w_detalle
end type
end forward

global type w_asistentes_detalle from w_detalle
integer height = 1192
string title = "Detalle de Asistentes"
string menuname = "m_detalle_asistentes_cursos_jornadas"
boolean minbox = false
end type
global w_asistentes_detalle w_asistentes_detalle

on w_asistentes_detalle.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_detalle_asistentes_cursos_jornadas" then this.MenuID = create m_detalle_asistentes_cursos_jornadas
end on

on w_asistentes_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;g_dw_lista=g_dw_lista_asistentes

g_w_lista=g_lista_asistentes
g_w_detalle=g_detalle_asistentes

g_lista='w_asistentes_lista'
g_detalle='w_asistentes_detalle'
end event

event type integer csd_nuevo();call super::csd_nuevo;If AncestorReturnValue>0 then
	string n_colegiado
	integer num_reg
	
	//Ponemos los datos necesarios para crear un nuevo asistente
	dw_1.SetItem(dw_1.getrow(),'id_asistente',f_siguiente_numero('FORMACION_ASISTENTES',10))
	dw_1.SetItem(dw_1.GetRow(),'id_curso',g_id_curso)
	dw_1.SetItem(dw_1.GetRow(),'f_inscripcion',datetime(today()))
	
	dw_1.SetFocus()
	
	//-------------------------------
	if g_n_plazas_libres>0 then
		g_n_plazas_libres=g_n_plazas_libres - 1
	
	else
		g_n_lista_espera=g_n_lista_espera + 1
		dw_1.SetItem(dw_1.GetRow(),'n_lista_espera',g_n_lista_espera)
	end if
	//-------------------------------
	
	
	//CONTROLAREMOS SI ES UN CURSO, PARA QUE PAGE O SI EL UNA JORNADA 
	string tipo_conv
	
	select tipo_convocatoria
	into:tipo_conv
	from formacion_cursos
	where formacion_cursos.id_curso=:g_id_curso;
	
	IF tipo_conv ='J' then
		dw_1.Modify("pagado_t.Visible=0")
		dw_1.Modify("pagado.Visible=0")
		dw_1.Modify("f_pago_t.Visible=0")
		dw_1.Modify("f_pago.Visible=0")
		dw_1.Modify("n_recibo_t.Visible=0")
		dw_1.Modify("n_recibo.Visible=0")
		dw_1.Modify("importe.Visible=0")
		dw_1.Modify("importe_t.Visible=0")
		dw_1.Modify("a_nombre_de_t.Visible=0")
		dw_1.Modify("a_nombre_de.Visible=0")
		
	else
		dw_1.SetItem(dw_1.GetRow(),'importe',g_importe_ncol)
		
	end if
end if

return AncestorReturnValue
	

end event

event csd_anterior();call super::csd_anterior;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.RowCount()>0 then
g_asistentes_consulta.id_asistente=g_dw_lista.GetItemString(g_dw_lista.GetRow(),'id_asistente')
	dw_1.event csd_retrieve()
end if

end event

event csd_siguiente();call super::csd_siguiente;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.RowCount()>0 then
	g_asistentes_consulta.id_asistente=g_dw_lista.GetItemString(g_dw_lista.GetRow(),'id_asistente')
	dw_1.event csd_retrieve()
end if
end event

event csd_primero();call super::csd_primero;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.RowCount()>0 then
	g_dw_lista.SetRow(1)
	g_dw_lista.ScrollToRow(1)
	g_asistentes_consulta.id_asistente=g_dw_lista.GetItemString(1,'id_asistente')
	
	dw_1.event csd_retrieve()
end if
end event

event csd_ultimo();call super::csd_ultimo;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.RowCount()>0 then
	g_dw_lista.SetRow(g_dw_lista.RowCount())
	g_dw_lista.ScrollToRow(g_dw_lista.RowCount())
	g_asistentes_consulta.id_asistente=g_dw_lista.GetItemString(g_dw_lista.RowCount(),'id_asistente')
	
	dw_1.event csd_retrieve()
end if

end event

event type integer pfc_preupdate();string mensaje=''
integer p_l
if f_puedo_escribir(g_usuario,'0000000030')=-1 then return -1

//mensaje=mensaje + f_valida(dw_1,'nif','NONULO','Debe especificar el NIF.')
mensaje=mensaje + f_valida(dw_1,'nombre','NOVACIO','Debe especificar el nombre del colegiado.')
mensaje=mensaje + f_valida(dw_1,'apellidos','NOVACIO','Debe especificar los apellidos del colegiado.')

int retorno=1

if mensaje<>'' then
	messagebox(G_TITULO,mensaje,StopSign!)

	retorno=-1

end if


return retorno
end event

event open;dw_1.event pfc_addrow()
if g_boton=true then
	this.event csd_nuevo()
	g_boton=false
end if




end event

event pfc_postupdate;call super::pfc_postupdate;integer li_respuesta

li_respuesta=messageBox(g_titulo,"$$HEX1$$bf00$$ENDHEX$$Desea a$$HEX1$$f100$$ENDHEX$$adir otro asistente?",Question!,YesNo!)

if li_respuesta=1 then
	event csd_nuevo()
end if

return 1

end event

type cb_nuevo from w_detalle`cb_nuevo within w_asistentes_detalle
end type

type cb_ayuda from w_detalle`cb_ayuda within w_asistentes_detalle
end type

type cb_grabar from w_detalle`cb_grabar within w_asistentes_detalle
end type

type cb_ant from w_detalle`cb_ant within w_asistentes_detalle
end type

type cb_sig from w_detalle`cb_sig within w_asistentes_detalle
end type

type dw_1 from w_detalle`dw_1 within w_asistentes_detalle
integer x = 23
integer y = 20
integer width = 2921
integer height = 956
string dataobject = "d_asistentes_detalle"
boolean border = false
end type

event dw_1::csd_retrieve;call super::csd_retrieve;if g_asistentes_consulta.id_asistente='' or isnull(g_asistentes_consulta.id_asistente) then return
int retorno
retorno=parent.event closequery()
if retorno=1 then return
this.retrieve(g_asistentes_consulta.id_asistente)
g_asistentes_consulta.id_asistente=''
end event

event dw_1::buttonclicked;call super::buttonclicked;string cod_pob,cod_provincia
string id_persona,id_tercero

choose case dwo.name
//Bot$$HEX1$$f300$$ENDHEX$$n de b$$HEX1$$fa00$$ENDHEX$$squeda de colegiados
	case 'b_busqueda_colegiado'
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
			g_busqueda.dw="d_lista_busqueda_colegiados"
			id_persona=f_busqueda_colegiados()
			if f_es_vacio(id_persona)then
				//this.deleterow(row)
			else
				this.setitem(this.getrow(),'n_colegiado',f_colegiado_n_col(id_persona))
				this.setitem(this.getrow(),'nif',f_devuelve_nif(id_persona))
				this.setitem(this.getrow(),'nombre',f_colegiado_nombre(id_persona))
				this.setitem(this.getrow(),'apellidos',f_colegiado_apellidos(id_persona))
				this.setitem(this.getrow(),'direccion',f_colegiado_domicilio(id_persona))
				this.setitem(this.getrow(),'cp',f_colegiado_cp(id_persona))
				this.setitem(this.getrow(),'poblacion',f_colegiado_cp(id_persona))
				this.setitem(this.getrow(),'provincia',f_colegiado_provincia(id_persona))
				this.setitem(this.getrow(),'telefono',f_colegiado_telefono(id_persona))
				this.SetItem(this.GetRow(),'importe',g_importe_col)
				
		end if
				
		
CASE 'b_busqueda_poblacion'
		
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		cod_pob=f_busqueda_poblaciones()
		if f_es_vacio(cod_pob) then return
		this.SetItem(row,'poblacion',cod_pob)
		cod_provincia=f_devuelve_cod_provincia(cod_pob)
		this.setitem(row,'provincia',cod_provincia)
		this.setitem(row,'cp',cod_pob)
		

END CHOOSE




end event

event dw_1::retrieveend;//if this.GetItemString(this.GetRow(),'pagado')='N' then
//	this.SetTabOrder('f_pago',0)
//else
//	this.SetTabOrder('f_pago',105)
//end if

//if this.GetItemString(this.GetRow(),'n_colegiado')<>'' then
//	this.SetTabOrder('n_colegiado',0)
//	if this.GetItemString(this.GetRow(),'nif')<>'' then
//		this.SetTabOrder('nif',0)
//	else
//		this.SetTabOrder('nif',10)
//	end if
//	this.SetTabOrder('nombre',0)
//	this.SetTabOrder('apellidos',0)
//	this.SetTabOrder('direccion',0)
//	this.SetTabOrder('poblacion',0)
//	this.SetTabOrder('provincia',0)
//	this.SetTabOrder('cp',0)
//	this.SetTabOrder('telefono',0)
//else
////	this.SetTabOrder('n_colegiado',10)
//	this.SetTabOrder('nif',10)
//	this.SetTabOrder('nombre',30)
//	this.SetTabOrder('apellidos',40)
//	this.SetTabOrder('direccion',50)
//	this.SetTabOrder('poblacion',60)
//	this.SetTabOrder('provincia',70)
//	this.SetTabOrder('cp',80)
//	this.SetTabOrder('telefono',90)
//end if
end event

event dw_1::itemchanged;call super::itemchanged;string n_col
string encontrado,cod_provincia,cod_postal
integer num_reg

choose case dwo.name
//Si se paga se habilita la fecha de pago y el importe ESTE CODIGO SE DEBERIA DE QUITAR
//	case 'pagado'
//		if string(data)='N' then
//			this.SetTabOrder('f_pago',0)
//			this.SetTabOrder('importe',0)
//		else
//			this.SetTabOrder('f_pago',95)
//			this.SetTabOrder('importe',105)
//		end if
	CASE 'cod_pob'
		cod_provincia=f_devuelve_cod_provincia(data)
		cod_postal=f_devuelve_cod_postal(data)
		
		this.setitem(row,'cod_pob',data)
		this.setitem(row,'cp',cod_postal)
		this.setitem(row,'provincia',cod_provincia)
	
	CASE 'n_colegiado'
		string id_col
		id_col = f_colegiado_id_col(data)
		
		this.setitem(this.getrow(),'nif',f_devuelve_nif(id_col))
		this.setitem(this.getrow(),'nombre',f_colegiado_nombre(id_col))
		this.setitem(this.getrow(),'apellidos',f_colegiado_apellidos(id_col))
		this.setitem(this.getrow(),'direccion',f_colegiado_domicilio(id_col))
		this.setitem(this.getrow(),'cp',f_colegiado_cp(id_col))
		this.setitem(this.getrow(),'poblacion',f_colegiado_cp(id_col))
		this.setitem(this.getrow(),'provincia',f_colegiado_provincia(id_col))
		this.setitem(this.getrow(),'telefono',f_colegiado_telefono(id_col))
	
		If not(f_es_vacio(data)) then 
				select count(*)
				into:num_reg
				from colegiados
				where colegiados.n_colegiado=:data;
			If num_reg>0  then 
				dw_1.SetItem(dw_1.GetRow(),'importe',g_importe_col)
			else 
				dw_1.SetItem(dw_1.GetRow(),'importe',g_importe_ncol)
			end if 
		end if
		
end choose

end event

