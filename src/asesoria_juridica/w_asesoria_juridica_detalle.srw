HA$PBExportHeader$w_asesoria_juridica_detalle.srw
forward
global type w_asesoria_juridica_detalle from w_detalle
end type
end forward

global type w_asesoria_juridica_detalle from w_detalle
integer height = 1424
string title = "Detalle de la Asesor$$HEX1$$ed00$$ENDHEX$$a Jur$$HEX1$$ed00$$ENDHEX$$dica"
end type
global w_asesoria_juridica_detalle w_asesoria_juridica_detalle

on w_asesoria_juridica_detalle.create
call super::create
end on

on w_asesoria_juridica_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;g_dw_lista	= g_dw_lista_as_juridica
g_w_lista   = g_lista_as_juridica
g_w_detalle = g_detalle_as_juridica

g_lista     = 'w_asesoria_juridica_lista'
g_detalle   = 'w_asesoria_juridica_detalle'
end event

event csd_anterior();call super::csd_anterior;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	g_as_juridica_consulta.id_asesoria = g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_asesoria")
	//Cogemos el colegiado asociado a la demanda
	dw_1.event csd_retrieve()
end if
end event

event type integer csd_nuevo();call super::csd_nuevo;if AncestorReturnValue>0 then
	
	string tipo
	//Ponemos el foco dentro del datawindows principal.
	dw_1.setfocus()
	
	//Ponemos un valor al identificador de la asesor$$HEX1$$ed00$$ENDHEX$$aa jur$$HEX1$$ed00$$ENDHEX$$dica, el contador  ID_ASESORIA_JURIDICA
	dw_1.SetItem(dw_1.GetRow(),'id_asesoria',f_siguiente_numero('ID_ASESORIA_JURIDICA',10))
	//Ponemos un valor del numero asesor$$HEX1$$ed00$$ENDHEX$$a, el contador  N_ASESORIA_JURIDICA
	dw_1.SetItem(dw_1.GetRow(),'n_asesoria',f_siguiente_numero('N_ASESORIA_JURIDICA',10))
	
	//Ponemos la fecha de hoy
	dw_1.SetItem(dw_1.GetRow(),'fecha',datetime(today()))
	
	//Ponemos las variables instancia a vacio, ya que creamos una reunion nueva
	g_as_juridica_consulta.id_asesoria=''

end if

return AncestorReturnValue
end event

event csd_primero();call super::csd_primero;//Preguntamos si hay filas el datawindows de la lista
if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(1)
	g_dw_lista.scrolltorow(1)
	//Cogemos el id de la reunion
		g_as_juridica_consulta.id_asesoria = g_dw_lista.getitemstring(1,"id_asesoria")
		dw_1.event csd_retrieve()
end if
end event

event csd_siguiente();call super::csd_siguiente;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	g_as_juridica_consulta.id_asesoria = g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_asesoria")
	dw_1.event csd_retrieve()
end if

end event

event csd_ultimo();call super::csd_ultimo;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(g_dw_lista.rowcount())
	g_dw_lista.scrolltorow(g_dw_lista.rowcount())
	//Cogemos el id de la reunion
	g_as_juridica_consulta.id_asesoria = g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_asesoria")
		dw_1.event csd_retrieve()
end if

end event

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje=''

//PERMISOS
if f_puedo_escribir(g_usuario,'0000000034')=-1 then return -1

mensaje=mensaje + f_valida(dw_1,'n_asesoria','NOVACIO','Debe especificar un valor en numero de asesoria')
mensaje=mensaje + f_valida(dw_1,'id_col','NOVACIO','Debe especificar un colegiado')

int retorno=1
if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno = -1
end if
return retorno




end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_asesoria_juridica_detalle
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_asesoria_juridica_detalle
end type

type cb_nuevo from w_detalle`cb_nuevo within w_asesoria_juridica_detalle
end type

type cb_ayuda from w_detalle`cb_ayuda within w_asesoria_juridica_detalle
end type

type cb_grabar from w_detalle`cb_grabar within w_asesoria_juridica_detalle
end type

type cb_ant from w_detalle`cb_ant within w_asesoria_juridica_detalle
end type

type cb_sig from w_detalle`cb_sig within w_asesoria_juridica_detalle
end type

type dw_1 from w_detalle`dw_1 within w_asesoria_juridica_detalle
integer y = 32
integer height = 1004
string title = "Detalle de la Asesor$$HEX1$$ed00$$ENDHEX$$a Jur$$HEX1$$ed00$$ENDHEX$$dica"
string dataobject = "d_asesoria_juridica_detalle"
boolean border = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event dw_1::buttonclicked;call super::buttonclicked;string id_col

choose case dwo.name
	case "b_busqueda_colegiado"
  		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()   
		if NOT f_es_vacio(id_col)  then
			this.setitem(1,'id_col',id_col)
			this.setitem(1,'compute_1',f_colegiado_n_col(id_col))
			this.setitem(1,'compute_2',f_nombre_colegiado(id_col))
		end if

END CHOOSE
end event

event dw_1::csd_retrieve();call super::csd_retrieve;//Comprobamos que la variabe que le pasamos, en este caso el identificador de la asesoria
if g_as_juridica_consulta.id_asesoria='' or isnull(g_as_juridica_consulta.id_asesoria) then return
int    retorno
double i
//Cerramos la consulta
retorno = parent.event closequery()
if retorno = 1 then return
//Retriveamos los datos de la asesoria
this.retrieve(g_as_juridica_consulta.id_asesoria)

//Vaciamos la variable instancia de la asesoria
g_as_juridica_consulta.id_asesoria=''
end event

event dw_1::csd_enter;//
end event

