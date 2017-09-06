HA$PBExportHeader$w_reparos_lista.srw
forward
global type w_reparos_lista from w_lista
end type
type cb_subsanar_todos from commandbutton within w_reparos_lista
end type
type dw_notificacion from u_dw within w_reparos_lista
end type
type cb_notificar from commandbutton within w_reparos_lista
end type
type cb_anyadir from commandbutton within w_reparos_lista
end type
type cb_subsanar from commandbutton within w_reparos_lista
end type
type cb_anyadir_todos_col from commandbutton within w_reparos_lista
end type
type dw_colegiados_por_fases from u_dw within w_reparos_lista
end type
type cb_mail from commandbutton within w_reparos_lista
end type
type dw_fase_actual from u_dw within w_reparos_lista
end type
type dw_fases_estados from u_dw within w_reparos_lista
end type
type dw_lista_clientes_fase from u_dw within w_reparos_lista
end type
type dw_lista_colegiados_fase from u_dw within w_reparos_lista
end type
type cb_anular_fase from commandbutton within w_reparos_lista
end type
end forward

global type w_reparos_lista from w_lista
integer height = 1380
string title = "Lista de Reparos de Fases"
string menuname = "m_reparos_lista"
event csd_anyadir ( )
event csd_anyadir_todos ( )
event csd_subsanar ( )
event csd_subsanar_todos ( )
event csd_notificar_carta ( )
event csd_notificar_email ( )
event csd_anular_fase ( )
cb_subsanar_todos cb_subsanar_todos
dw_notificacion dw_notificacion
cb_notificar cb_notificar
cb_anyadir cb_anyadir
cb_subsanar cb_subsanar
cb_anyadir_todos_col cb_anyadir_todos_col
dw_colegiados_por_fases dw_colegiados_por_fases
cb_mail cb_mail
dw_fase_actual dw_fase_actual
dw_fases_estados dw_fases_estados
dw_lista_clientes_fase dw_lista_clientes_fase
dw_lista_colegiados_fase dw_lista_colegiados_fase
cb_anular_fase cb_anular_fase
end type
global w_reparos_lista w_reparos_lista

type variables
string i_id_reg_actual

DataWindowChild i_dwc_colegiados
end variables

event csd_anyadir();cb_anyadir.triggerevent(clicked!)
end event

event csd_anyadir_todos();cb_anyadir_todos_col.triggerevent(clicked!)
end event

event csd_subsanar();cb_subsanar.triggerevent(clicked!)
end event

event csd_subsanar_todos();cb_subsanar_todos.triggerevent(clicked!)
end event

event csd_notificar_carta();cb_notificar.triggerevent(clicked!)
end event

event csd_notificar_email();cb_mail.triggerevent(clicked!)
end event

event csd_anular_fase();cb_anular_fase.triggerevent(clicked!)
end event

on w_reparos_lista.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_reparos_lista" then this.MenuID = create m_reparos_lista
this.cb_subsanar_todos=create cb_subsanar_todos
this.dw_notificacion=create dw_notificacion
this.cb_notificar=create cb_notificar
this.cb_anyadir=create cb_anyadir
this.cb_subsanar=create cb_subsanar
this.cb_anyadir_todos_col=create cb_anyadir_todos_col
this.dw_colegiados_por_fases=create dw_colegiados_por_fases
this.cb_mail=create cb_mail
this.dw_fase_actual=create dw_fase_actual
this.dw_fases_estados=create dw_fases_estados
this.dw_lista_clientes_fase=create dw_lista_clientes_fase
this.dw_lista_colegiados_fase=create dw_lista_colegiados_fase
this.cb_anular_fase=create cb_anular_fase
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_subsanar_todos
this.Control[iCurrent+2]=this.dw_notificacion
this.Control[iCurrent+3]=this.cb_notificar
this.Control[iCurrent+4]=this.cb_anyadir
this.Control[iCurrent+5]=this.cb_subsanar
this.Control[iCurrent+6]=this.cb_anyadir_todos_col
this.Control[iCurrent+7]=this.dw_colegiados_por_fases
this.Control[iCurrent+8]=this.cb_mail
this.Control[iCurrent+9]=this.dw_fase_actual
this.Control[iCurrent+10]=this.dw_fases_estados
this.Control[iCurrent+11]=this.dw_lista_clientes_fase
this.Control[iCurrent+12]=this.dw_lista_colegiados_fase
this.Control[iCurrent+13]=this.cb_anular_fase
end on

on w_reparos_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_subsanar_todos)
destroy(this.dw_notificacion)
destroy(this.cb_notificar)
destroy(this.cb_anyadir)
destroy(this.cb_subsanar)
destroy(this.cb_anyadir_todos_col)
destroy(this.dw_colegiados_por_fases)
destroy(this.cb_mail)
destroy(this.dw_fase_actual)
destroy(this.dw_fases_estados)
destroy(this.dw_lista_clientes_fase)
destroy(this.dw_lista_colegiados_fase)
destroy(this.cb_anular_fase)
end on

event activate;call super::activate;g_dw_lista  = dw_lista
g_w_lista   = g_lista_reparos
g_lista     = 'w_reparos_lista'

end event

event csd_consulta;int retorno
//Comprobamos cambios pendientes antes de seguir
retorno= EVENT CloseQuery()
if retorno = 1 then return

//Abrimos la ventana de consulta
open(w_reparos_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()
end event

event pfc_postopen;call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_reparos = dw_lista
end event

event csd_nuevo();call super::csd_nuevo;int indice
indice = dw_lista.RowCount()
dw_lista.InsertRow(indice+1)
dw_lista.SetItem(indice+1,'id_reparo',f_siguiente_numero('REPAROS',10))
dw_lista.SetItem(indice+1,'f_emision',datetime(Today()))
dw_lista.SetRow(indice+1)
dw_lista.SetColumn('n_regfase')

end event

event open;call super::open;inv_resize.of_Register (cb_anyadir, "FixedtoBottom")
inv_resize.of_Register (cb_subsanar, "FixedtoBottom")
inv_resize.of_Register (cb_subsanar_todos, "FixedtoBottom")
inv_resize.of_Register (cb_notificar, "FixedtoBottom")
inv_resize.of_Register (cb_anyadir_todos_col, "FixedtoBottom")
inv_resize.of_Register (cb_mail, "FixedtoBottom")
inv_resize.of_Register (cb_anular_fase, "FixedtoBottom")


dw_notificacion.dataobject = g_carta_reparos
dw_notificacion.settransobject(sqlca)
end event

event type integer pfc_preupdate();// Control de permisos
if f_puedo_escribir(g_usuario, '0000000017')= -1 then return -1

string mensaje='', tipo_pers = '', ident_fase, id_col, t_reparo, fase, col, t_rep, id_reparo
datetime f_emision, f_subsanacion
int i, j, repetidos=0, retorno=1
boolean repetidos_bd=false

if dw_lista.RowCount()>0 then
	mensaje+= f_valida(dw_lista,'n_regfase','NOVACIO','Debe especificar un valor en el campo Registro.')
	mensaje+= f_valida(dw_lista,'id_col','NOVACIO','Debe especificar un valor en el campo Colegiado.')
	mensaje+= f_valida(dw_lista,'tipo_reparo','NOVACIO','Debe especificar un valor en el campo Tipo de Reparo.')
	mensaje+= f_valida(dw_lista,'f_emision','NONULO','Debe especificar un valor en el campo Fecha Emisi$$HEX1$$f300$$ENDHEX$$n.')
	
	//Se controla que la fecha de Emisi$$HEX1$$f300$$ENDHEX$$n no sea mayor que la de Subsanaci$$HEX1$$f300$$ENDHEX$$n
	f_emision=dw_lista.getitemdatetime(dw_lista.getrow(),'f_emision')
	f_subsanacion=dw_lista.getitemdatetime(dw_lista.getrow(),'f_subsanacion')
	
	if not isnull(f_emision) and not isnull(f_subsanacion) and f_subsanacion < f_emision then
		mensaje=mensaje + cr + 'La fecha de subsanaci$$HEX1$$f300$$ENDHEX$$n debe ser mayor que la de emisi$$HEX1$$f300$$ENDHEX$$n'
	end if 

	if mensaje<>'' then 
		messagebox(g_titulo, mensaje, stopsign!)
		retorno=-1
	end if
end if

return retorno

end event

event csd_detalle;call super::csd_detalle;if dw_lista.getrow() < 1 then return
end event

event csd_listados;call super::csd_listados;open(w_reparos_listados)

end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_reparos_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_reparos_lista
end type

type st_1 from w_lista`st_1 within w_reparos_lista
integer x = 37
integer y = 1120
end type

type dw_lista from w_lista`dw_lista within w_reparos_lista
event after_retrieverow ( )
event csd_recupera_datos ( )
event comprueba_repetidos ( )
integer x = 37
integer y = 32
integer width = 3442
integer height = 1064
integer taborder = 50
string dataobject = "d_reparos_lista"
boolean hscrollbar = true
end type

event dw_lista::csd_recupera_datos();string id_col,id_regfase
string col,regfase, colegiado
int i

if rowcount() > 0 then
	for i=1 to this.rowcount()
			id_regfase=this.GetItemString(i,'id_fase')
			id_col=this.GetItemString(i,'id_col')
		
			regfase = f_dame_n_reg(id_regfase)
		//	col = f_colegiado_n_col(id_col)
			colegiado = LeftA(f_colegiado_apellido(id_col),60)
			
			this.SetItem(i,'n_regfase',regfase)
		//	this.SetItem(i,'n_colegiado',col)
			this.SetItem(i,'colegiado',colegiado)
		next
	end if

// Para evitar el Closequery, restauramos el estado de cambios del dw
this.ResetUpdate()
end event

event dw_lista::comprueba_repetidos();//string ident_fase,id_col,t_reparo,id_reparo
//string fase,col,t_rep
//int i,repetidos=0 
//
//// Comprueba si hay valores repetidos entre la fila actual modificada y:
////		1,		el resto de filas del dw
////		2,		valores en la BD
//ident_fase = this.GetItemString(this.getrow(),'id_fase')
//id_col = this.GetItemString(this.getrow(),'id_col')
//t_reparo = this.GetItemString(this.getrow(),'tipo_reparo')
//id_reparo =this.GetItemString(this.getrow(),'id_reparo')
//
//if not(f_es_vacio(ident_fase)) and not(f_es_vacio(id_col)) and not(f_es_vacio(t_reparo)) then
//	for i=1 to this.rowCount() 
//		if i <> this.Getrow() then
//			fase = this.GetItemString(i,'id_fase')
//			col = this.GetItemString(i,'id_col')
//			t_rep = this.GetItemString(i,'tipo_reparo')
//			if fase=ident_fase and id_col=col and t_reparo=t_rep then
//				repetidos++
//			end if
//		end if
//	next
//end if
//
//// repetidos en el dw
//if repetidos>0 then
//	messagebox(g_titulo,'Existe otro reparo con las mismas caracter$$HEX1$$ed00$$ENDHEX$$sticas.')
//// repetidos en la BD
//elseif f_comprueba_repetidos(ident_fase,id_col,t_reparo,id_reparo) then 
//	messagebox(g_titulo,'Existen reparos repetidos entre la ventana y los datos en la BD.')
//end if
//
end event

event dw_lista::buttonclicked;call super::buttonclicked;string id_fase, a, estado
int num_fases

id_fase = this.GetItemString(row,'id_fase')

CHOOSE CASE dwo.name
	CASE 'b_busqueda_fases'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Fases"
		g_busqueda.dw="d_lista_busqueda_fases"
		id_fase=f_busqueda_fases()
		select estado into :estado from fases where id_fase = :id_fase;
//			if id_fase="-1" then
//				this.deleterow(row)
//			else
		if id_fase<>"" then
			dw_fase_actual.Retrieve(id_fase)
			dw_fases_estados.Retrieve(id_fase)
			if (estado<>g_fases_estados.registrado) and (estado<>g_fases_estados.retenido) &
				and (estado<>g_fases_estados.verificado) then
				messagebox(g_titulo,'El estado en que se encuentra la fase no permite a$$HEX1$$f100$$ENDHEX$$adir reparos')
				return 1
			else
				//Comprobamos que la fase no este ya en estado "Con reparos",si no es as$$HEX2$$ed002000$$ENDHEX$$la ponemos
				//y a$$HEX1$$f100$$ENDHEX$$adimos entrada en DW fases_estados
				if estado<>g_fases_estados.retenido then
					num_fases=dw_fases_estados.RowCount()
					dw_fase_actual.setitem(1,'estado',g_fases_estados.retenido)
					dw_fases_estados.insertrow(num_fases+1)
					dw_fases_estados.setitem(num_fases+1,'id_fase',id_fase)
					dw_fases_estados.setitem(num_fases+1,'estado',g_fases_estados.retenido)
					dw_fases_estados.setitem(num_fases+1,'fecha',today())
					dw_fases_estados.setitem(num_fases+1,'usuario',g_usuario)
				end if
				this.setitem(row,'id_fase',id_fase)
				this.setitem(row,'n_regfase',f_dame_n_reg(id_fase))
			end if
			//end if
		end if
		i_dwc_colegiados.Retrieve(id_fase)			
		this.PostEvent('comprueba_repetidos')
end choose

end event

event dw_lista::itemchanged;call super::itemchanged;string  id_col,ident_fase, col,registro,estado,t_reparo, texto, tipo
integer num_fases

ident_fase = this.GetItemString(row,'id_fase')
id_col = this.GetItemString(row,'id_col')
t_reparo = this.GetItemString(row,'tipo_reparo')

CHOOSE CASE this.getcolumnname()
	CASE 'n_regfase'
		// se verifica que existe la fase en la tabla fase
		registro=this.gettext()
		if not(f_es_vacio(registro)) then
			select id_fase,estado into :ident_fase,:estado from fases where n_registro = :registro;
			if f_es_vacio(ident_fase) then 
				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de registro v$$HEX1$$e100$$ENDHEX$$lido.')
				this.setfocus()
				return 1
			else
				//Comprobamos que no haya ning$$HEX1$$fa00$$ENDHEX$$n colegiado con el mismo reparo
				dw_fase_actual.Retrieve(ident_fase)
				dw_fases_estados.Retrieve(ident_fase)
				if (estado<>g_fases_estados.registrado) and (estado<>g_fases_estados.retenido) &
					and (estado<>g_fases_estados.verificado) then
					messagebox(g_titulo,'El estado en que se encuentra la fase no permite a$$HEX1$$f100$$ENDHEX$$adir reparos')
					return 1
				else   //Cambiamos la fase a "Con Reparos"
					if estado<>g_fases_estados.retenido then
						num_fases=dw_fases_estados.RowCount()
						dw_fase_actual.setitem(1,'estado',g_fases_estados.retenido)
						dw_fases_estados.insertrow(num_fases+1)
						dw_fases_estados.setitem(num_fases+1,'id_fase',ident_fase)
						dw_fases_estados.setitem(num_fases+1,'estado',g_fases_estados.retenido)
						dw_fases_estados.setitem(num_fases+1,'fecha',today())
						dw_fases_estados.setitem(num_fases+1,'usuario',g_usuario)

					end if
					this.setitem(row,'id_fase', ident_fase)
					// Reseteo el colegiado
					this.setitem(row,'id_col', '')
					this.setitem(row,'colegiado', '')
				end if
			end if
		end if
		i_dwc_colegiados.Retrieve(ident_fase)		
		this.PostEvent('comprueba_repetidos')
		
	/*CASE 'n_colegiado'
		// se verifica que existe el colegiado en la tabla colegiados
		col=this.gettext()
		if not(f_es_vacio(col)) then
			select id_colegiado into :id_col from colegiados where n_colegiado = :col;
			if f_es_vacio(id_col) then 
				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
				this.setfocus()
				return 1
			else
					if f_pertenece_a_fase(id_col,ident_fase)=1 then
						this.setitem(row,'id_col', id_col)
					else
						messagebox(g_titulo,'El colegiado no pertenece a la fase especificada.')
						this.setfocus()
						return 1
					end if
			end if
		end if
		this.PostEvent('comprueba_repetidos')*/
	
	CASE 'id_col'
		this.SetItem(row,'colegiado', f_colegiado_apellido(data))
		this.PostEvent('comprueba_repetidos')

	CASE 'tipo_reparo'
		SELECT t_reparos_fases.observaciones, t_reparos_fases.tipo  
		INTO :texto, :tipo  
		FROM t_reparos_fases  
   	WHERE t_reparos_fases.codigo = :data   ;
		
		this.setitem(row, 'tipo', tipo)
		this.setitem(row, 'texto', texto)
		this.PostEvent('comprueba_repetidos')
		
	case 'tipo'
		this.post setitem(row, 'tipo_reparo', '')
END CHOOSE

end event

event dw_lista::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
//Desactivamos la opci$$HEX1$$f300$$ENDHEX$$n de que se muestre el foco en azul
this.of_SetRowSelect(FALSE)

/// Preparamos el dddw de colegiados de la fase ( hacemos un insertrow 
//		pq tiene retrieval argument )
this.GetChild('id_col',i_dwc_colegiados)
i_dwc_colegiados.settransobject(sqlca)
i_dwc_colegiados.InsertRow (0)
end event

event dw_lista::itemerror;call super::itemerror;return 1
end event

event dw_lista::doubleclicked;call super::doubleclicked;string texto, asunto

this.AcceptText()

CHOOSE CASE dwo.name
	CASE 't_texto'
		g_busqueda.titulo="Texto"
		texto = this.GetItemString(row, 'texto')
		openwithparm(w_observaciones, texto)
		if Message.Stringparm <> '-1' then
			texto = Message.Stringparm
			if not f_es_vacio(texto) then this.SetItem(row,'texto',texto)
		end if
END CHOOSE

end event

event dw_lista::retrieveend;call super::retrieveend;int i
//Hacemos un retrieve de los colegiados de las fases
//for i = 1 to this.RowCount()
//	i_dwc_colegiados.Retrieve(this.GetItemString(i,'id_col'))
//next

this.PostEvent('csd_recupera_datos')
end event

event dw_lista::rowfocuschanged;call super::rowfocuschanged;string mensaje='', tipo_pers = ''
datetime f_emision, f_subsanacion

//Validaciones del datawindows principal (dw_lista)
//---------------------------------------------
mensaje=mensaje + f_valida(dw_lista,'n_regfase','NOVACIO','Debe especificar un valor en el campo N$$HEX2$$ba002000$$ENDHEX$$de fase.')
mensaje=mensaje + f_valida(dw_lista,'id_col','NOVACIO','Debe especificar un valor en el campo N$$HEX2$$ba002000$$ENDHEX$$de colegiado.')
mensaje=mensaje + f_valida(dw_lista,'tipo_reparo','NOVACIO','Debe especificar un valor en el campo Tipo de Reparo.')
mensaje=mensaje + f_valida(dw_lista,'f_emision','NONULO','Debe especificar un valor en el campo Fecha Emisi$$HEX1$$f300$$ENDHEX$$n.')
mensaje=mensaje + f_valida(dw_lista,'usuario','NOVACIO','Debe especificar un valor en el campo Usuario.')


//Se controla que la fecha de Emisi$$HEX1$$f300$$ENDHEX$$n no sea mayor que la de Subsanaci$$HEX1$$f300$$ENDHEX$$n
//f_emision=dw_lista.getitemdatetime(currentrow,'f_emision')
//f_subsanacion=dw_lista.getitemdatetime(currentrow,'f_subsanacion')

if not isnull(f_emision) and not isnull(f_subsanacion) and f_subsanacion > f_emision then
	mensaje=mensaje + cr + 'Fecha de subsanaci$$HEX1$$f300$$ENDHEX$$n no debe ser mayor que la de Emisi$$HEX1$$f300$$ENDHEX$$n'
end if 

end event

event dw_lista::pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;m_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = True
end event

event type long dw_lista::pfc_addrow();call super::pfc_addrow;this.SetItem(this.GetRow(),'id_reparo',f_siguiente_numero('REPAROS',10))
this.SetItem(this.GetRow(),'f_emision',datetime(Today()))
dw_lista.SetRow(this.GetRow())
dw_lista.SetColumn('n_regfase')

// A$$HEX1$$f100$$ENDHEX$$adimos al dddw de colegiados de la fase
i_dwc_colegiados.InsertRow (0)

return 1

end event

event dw_lista::pfc_insertrow;call super::pfc_insertrow;this.SetItem(this.GetRow(),'id_reparo',f_siguiente_numero('REPAROS',10))
this.SetItem(this.GetRow(),'f_emision',datetime(Today()))
//this.SetRow(indice+1)
dw_lista.SetColumn('n_regfase')

/// a$$HEX1$$f100$$ENDHEX$$adimos al dddw de colegiados de la fase
i_dwc_colegiados.InsertRow (0)

return 1
end event

event type integer dw_lista::pfc_predeleterow();call super::pfc_predeleterow;string notificado, email, telfax, id_fase
int num_fases

if dw_lista.rowcount() = 0 then return -1

notificado = this.GetitemString(this.getRow(),'notificado')
email = this.GetitemString(this.getRow(),'email')
telfax = this.GetitemString(this.getRow(),'telfax')

if notificado='S' or email='S' or telfax = 'S' then
	messagebox(g_titulo,'No se puede borrar un reparo que ha sido notificado.')
	return 0	
end if

id_fase = dw_lista.getitemstring(this.getrow(), 'id_fase')
if f_es_vacio(id_fase) then return 1

datastore ds_rep
ds_rep = create datastore
ds_rep.dataobject = 'ds_fases_otros_reparos_contrato'
ds_rep.settransobject(sqlca)
ds_rep.retrieve(id_fase, dw_lista.getitemstring(this.getrow(), 'id_reparo'))

if ds_rep.RowCount() = 0 then
	Messagebox(g_titulo,'La fase pasar$$HEX2$$e1002000$$ENDHEX$$al estado Registrado (en an$$HEX1$$e100$$ENDHEX$$lisis)')
	//Dejamos la fase en an$$HEX1$$e100$$ENDHEX$$lisis
	dw_fase_actual.Retrieve(id_fase)
	dw_fases_estados.Retrieve(id_fase)
	num_fases=dw_fases_estados.RowCount()
	dw_fase_actual.setitem(1,'estado',g_fases_estados.registrado)
	dw_fases_estados.insertrow(num_fases+1)
	dw_fases_estados.setitem(num_fases+1,'id_fase',id_fase)
	dw_fases_estados.setitem(num_fases+1,'estado',g_fases_estados.registrado)
	dw_fases_estados.setitem(num_fases+1,'fecha',today())
	dw_fases_estados.setitem(num_fases+1,'usuario',g_usuario)
end if

dw_lista.update()
dw_fases_estados.update()
dw_fase_actual.update()
destroy ds_rep

return 1
end event

event dw_lista::rowfocuschanging;call super::rowfocuschanging;// Cuando cambiamos el foco de fila, debemos recuperar en el dddw de colegiados
// para que podamos seleccionar s$$HEX1$$f300$$ENDHEX$$lo los de esa fase y no hayan errores
string ident_fase

if this.rowcount() = 0 then return

// Controlamos si ya hay filas en el dw
IF newrow > 0 then
	ident_fase=this.GetItemString(newrow,'id_fase')
	if f_es_vacio(ident_fase) then ident_fase = ''
	
	i_dwc_colegiados.Retrieve(ident_fase)	
END IF
end event

event dw_lista::itemfocuschanged;call super::itemfocuschanged;choose case dwo.name
	case 'tipo_reparo'
		if this.getitemstring(row,'tipo') <> '' then	
			DataWindowChild tipo_reparo
			this.GetChild('tipo_reparo', tipo_reparo)						
			tipo_reparo.setfilter("tipo ='" + this.getitemstring(row,'tipo') + "'")		
			tipo_reparo.filter()
		end if
end choose

end event

event dw_lista::clicked;call super::clicked;choose case dwo.name
	case 'tipo_reparo'
		DataWindowChild tipo_reparo
		this.GetChild('tipo_reparo', tipo_reparo)
		if not f_es_vacio(this.getitemstring(row,'tipo')) then
			tipo_reparo.setfilter("tipo ='" + this.getitemstring(row,'tipo') + "'")		
			tipo_reparo.filter()
		end if
end choose

end event

type cb_consulta from w_lista`cb_consulta within w_reparos_lista
integer x = 3205
integer y = 796
end type

type cb_detalle from w_lista`cb_detalle within w_reparos_lista
integer x = 3351
integer y = 908
integer taborder = 30
end type

type cb_ayuda from w_lista`cb_ayuda within w_reparos_lista
integer x = 3351
integer y = 1016
integer taborder = 40
end type

type cb_subsanar_todos from commandbutton within w_reparos_lista
boolean visible = false
integer x = 1033
integer y = 1064
integer width = 425
integer height = 80
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Subsanar &Todos"
end type

event clicked;if f_puedo_escribir(g_usuario, '0000000017')= -1 then return

int n, num_fases, i
string todos = 'S', id_fase
datastore ds_rep
ds_rep = create datastore
ds_rep.dataobject = 'ds_fases_otros_reparos_contrato'
ds_rep.settransobject(sqlca)

if dw_lista.RowCount()>0 then
	for n = 1 to dw_lista.RowCount()
		if isnull(dw_lista.GetItemDateTime(n,'f_subsanacion')) then	
			dw_lista.SetItem(n,'f_subsanacion',datetime(Today()))
		
			// Se comprueba si est$$HEX1$$e100$$ENDHEX$$n todos subsanados de ese contrato
			id_fase = dw_lista.getitemstring(n, 'id_fase')
	
			ds_rep.retrieve(id_fase, dw_lista.getitemstring(n, 'id_reparo'))
			todos = 'S'
			for i = 1 to ds_rep.RowCount()
				if isnull(ds_rep.GetItemDateTime(i,'f_subsanacion')) then todos = 'N'
			next
			
			// Cambiamos el estado y a$$HEX1$$f100$$ENDHEX$$adimos el cambio de estado
			if todos = 'S' then
				dw_fase_actual.Retrieve(id_fase)
				dw_fases_estados.Retrieve(id_fase)
				num_fases=dw_fases_estados.RowCount()
				dw_fase_actual.setitem(1,'estado',g_fases_estados.registrado)
				dw_fases_estados.insertrow(num_fases+1)
				dw_fases_estados.setitem(num_fases+1,'id_fase',id_fase)
				dw_fases_estados.setitem(num_fases+1,'estado',g_fases_estados.registrado)
				dw_fases_estados.setitem(num_fases+1,'fecha',today())
				dw_fases_estados.setitem(num_fases+1,'usuario',g_usuario)
				
				dw_fases_estados.update()
				dw_fase_actual.update()
			end if
			dw_lista.update()
		end if
	next
end if

destroy ds_rep

end event

type dw_notificacion from u_dw within w_reparos_lista
boolean visible = false
integer x = 2798
integer y = 668
integer width = 302
integer height = 300
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_reparos_notificacion"
boolean ib_isupdateable = false
end type

type cb_notificar from commandbutton within w_reparos_lista
boolean visible = false
integer x = 1518
integer y = 1064
integer width = 462
integer height = 80
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Notificar por Carta"
end type

event clicked;if f_puedo_escribir(g_usuario, '0000000017')= -1 then return

// modificado Ricardo 03/12/12
// Hay que obligar a grabar primero
long grabado_correctamente 
grabado_correctamente = parent.trigger event pfc_save()
if not(grabado_correctamente=1 or grabado_correctamente=0) then return
// FIN modificado Ricardo 03/12/12

//call super::clicked;
int n, i, j
string id_col, notificacion, id_fase, id_exp, trabajo, emplazamiento, n_regfase, n_exp, clientes='', colegiados=''
datetime f_subsanacion

if dw_lista.RowCount()>0 then
	// Ponemos todos los reparos "no subsanados" como NO notificados, para poder notificarlos
	// todas las veces que queramos
	for n = 1 to dw_lista.RowCount()
		if isnull(dw_lista.GetItemDatetime(n,'f_subsanacion')) then
			dw_lista.SetItem(n,'notificado','N')
		end if
	next

	// Notificamos los reparos no subsanados
	for n = 1 to dw_lista.RowCount()
		notificacion = dw_lista.GetItemString(n,'notificado')
		id_fase = dw_lista.GetItemString(n,'id_fase')
		id_exp = f_fases_id_expedi(id_fase)
		trabajo = f_dame_desc_tipo_obra(f_dame_tipo_obra(id_fase)) + ' / ' + f_dame_descripcion_contrato(id_fase) //f_devuelve_trabajo(id_exp)
		emplazamiento = f_devuelve_emplazamiento(id_exp) + ' ' + f_fases_n_calle(id_fase) + ' - ' + f_poblacion_descripcion_contrato(f_fases_poblacion(id_fase)) //f_devuelve_emplazamiento(id_exp)
		f_subsanacion = dw_lista.GetItemDatetime(n,'f_subsanacion')
		
		if notificacion <> 'S' and isnull(f_subsanacion) then
			n_regfase = f_dame_n_reg(id_fase) //+' / '+f_dame_exp(id_fase)
			n_exp = f_dame_exp(id_fase)
			id_col = dw_lista.GetItemString(n,'id_col')
			dw_lista_clientes_fase.Retrieve(id_fase)
			dw_lista_colegiados_fase.Retrieve(id_fase)
			clientes =''
			colegiados =''
			for j=1 to dw_lista_clientes_fase.RowCount()
				clientes = clientes + f_dame_cliente(dw_lista_clientes_fase.GetItemString(j,'id_cliente'))+cr
			next
			
			for j=1 to dw_lista_colegiados_fase.RowCount()
				colegiados = colegiados + f_colegiado(dw_lista_colegiados_fase.GetItemString(j,'id_col'))+cr
			next
//			if dw_lista.ModifiedCount()>0 then
//				Parent.TriggerEvent(closequery!)
//			end if
			dw_notificacion.retrieve(id_col,id_fase)
			dw_notificacion.SetItem(1,'n_regfase',n_regfase)
			dw_notificacion.SetItem(1,'trabajo',trabajo)
			dw_notificacion.SetItem(1,'emplazamiento',emplazamiento)
			dw_notificacion.SetItem(1,'clientes',clientes)
			dw_notificacion.SetItem(1,'colegiados',colegiados)
			if lower(dw_notificacion.describe("n_exp.name")) = 'n_exp' then dw_notificacion.setitem(1, 'n_exp', n_exp)
	
			dw_notificacion.Print()
			if g_colegio = 'COAATGU' then dw_notificacion.Print()
			
			for i = 1 to dw_lista.RowCount()
				if dw_lista.GetItemString(i,'id_col')=id_col and dw_lista.GetItemString(i,'id_fase')=id_fase and isnull(dw_lista.GetItemDatetime(i,'f_subsanacion')) then
					dw_lista.SetItem(i,'notificado','S')
				end if
			next
		end if
	next
end if

end event

type cb_anyadir from commandbutton within w_reparos_lista
boolean visible = false
integer x = 64
integer y = 1064
integer width = 425
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&A$$HEX1$$f100$$ENDHEX$$adir"
end type

event clicked;dw_lista.event pfc_addrow()

end event

type cb_subsanar from commandbutton within w_reparos_lista
boolean visible = false
integer x = 549
integer y = 1064
integer width = 425
integer height = 80
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Subsanar"
end type

event clicked;if f_puedo_escribir(g_usuario, '0000000017')= -1 then return

if dw_lista.RowCount()>0 then
	if isnull(dw_lista.GetItemDatetime(dw_lista.getRow(),'f_subsanacion')) then
			dw_lista.SetItem(dw_lista.GetRow(),'f_subsanacion',datetime(Today()))
		else
			messagebox(G_TITULO,'El reparo ya ha sido subsanado con anterioridad.')
	end if
else
	return
end if

// Se comprueba si est$$HEX1$$e100$$ENDHEX$$n todos subsanados
int n, num_fases
string todos = 'S', id_fase
datastore ds_rep

ds_rep = create datastore
ds_rep.dataobject = 'ds_fases_otros_reparos_contrato'
ds_rep.settransobject(sqlca)

id_fase = dw_lista.getitemstring(dw_lista.getrow(), 'id_fase')

if f_es_vacio(id_fase) then return

ds_rep.retrieve(id_fase, dw_lista.getitemstring(dw_lista.getrow(), 'id_reparo'))

for n = 1 to ds_rep.RowCount()
	if isnull(ds_rep.GetItemDateTime(n,'f_subsanacion')) then todos = 'N'
next
// Cambiamos el estado y a$$HEX1$$f100$$ENDHEX$$adimos el cambio de estado
if todos = 'S' then
	dw_fase_actual.Retrieve(id_fase)
	dw_fases_estados.Retrieve(id_fase)
	num_fases=dw_fases_estados.RowCount()
	dw_fase_actual.setitem(1,'estado',g_fases_estados.registrado)
	dw_fases_estados.insertrow(num_fases+1)
	dw_fases_estados.setitem(num_fases+1,'id_fase',id_fase)
	dw_fases_estados.setitem(num_fases+1,'estado',g_fases_estados.registrado)
	dw_fases_estados.setitem(num_fases+1,'fecha',today())
	dw_fases_estados.setitem(num_fases+1,'usuario',g_usuario)
end if

dw_lista.update()
dw_fases_estados.update()
dw_fase_actual.update()
destroy ds_rep
end event

type cb_anyadir_todos_col from commandbutton within w_reparos_lista
boolean visible = false
integer x = 2565
integer y = 1064
integer width = 425
integer height = 80
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&A$$HEX1$$f100$$ENDHEX$$adir Todos"
end type

event clicked;int indice,i,j,col_por_insertar
string tipo_reparo,texto,usuario,id_fase,col_fase,col_reparo,col,treparo_fase,t_reparo,estado
string fase_reparo,fase_fase,id_col_pdte, tipo
boolean existe_reparo=false
int borrar=0,resp,num_fases

if f_puedo_escribir(g_usuario, '0000000017')= -1 then return

// Confirmamos los $$HEX1$$fa00$$ENDHEX$$ltimos cambios...
if dw_lista.ModifiedCount()>0 then
	resp= Parent.EVENT CloseQuery_msgbox()
	if resp=2 or resp=3 then // 2 no graba, 3 cancela
		MessageBox(g_titulo,'No se han guardado los cambios, por tanto no se a$$HEX1$$f100$$ENDHEX$$adir$$HEX1$$e100$$ENDHEX$$n reparos')
		return
	end if
end if
	
if dw_lista.RowCount()>0 then
	// Obtenemos el num de col. insertados para esa fase con reparos en col_por_insertar
	id_fase = dw_lista.GetItemString(dw_lista.GetRow(),'id_fase')
	tipo_reparo = dw_lista.GetItemString(dw_lista.getRow(),'tipo_reparo')
	tipo = dw_lista.GetItemString(dw_lista.getRow(),'tipo')
	col =dw_lista.GetItemString(dw_lista.GetRow(),'id_col')
	if f_es_vacio(col) then 
		col=''
		borrar=dw_lista.GetRow()
	end if
	// Recupera colegiados de la fase que no tienen el mismo tipo de reparo
	// a los que se le a$$HEX1$$f100$$ENDHEX$$adir$$HEX2$$e1002000$$ENDHEX$$reparo (le pasa como retrieval el tipo_reparo)
	col_por_insertar=dw_colegiados_por_fases.Retrieve(id_fase,col,tipo_reparo)
	indice = dw_lista.RowCount()
	
	// Comprobamos que haya alg$$HEX1$$fa00$$ENDHEX$$n colegiado para insertar
	if col_por_insertar >0 then 
		for i=1 to col_por_insertar 
			existe_reparo=false 

			IF not(existe_reparo) then
				id_col_pdte = dw_colegiados_por_fases.GetItemString(i,'id_col')
				
				id_fase=dw_lista.GetItemString(dw_lista.getRow(),'id_fase')
				texto = dw_lista.GetItemString(dw_lista.getRow(),'texto')
				dw_lista.InsertRow(indice+1)
				dw_lista.SetItem(indice+1,'n_regfase',f_dame_n_reg(id_fase))
				dw_lista.SetItem(indice+1,'id_fase',id_fase)
				dw_lista.SetItem(indice+1,'colegiado',f_colegiado_apellido(id_col_pdte))
				dw_lista.SetItem(indice+1,'id_col',id_col_pdte)
				dw_lista.SetItem(indice+1,'id_reparo',f_siguiente_numero('REPAROS',10))
				dw_lista.SetItem(indice+1,'f_emision',datetime(Today()))
				dw_lista.SetItem(indice+1,'tipo_reparo',tipo_reparo)
				dw_lista.SetItem(indice+1,'tipo',tipo)				
				dw_lista.SetItem(indice+1,'texto',texto)
				dw_lista.SetItem(indice+1,'usuario',g_usuario)
				indice++
			end if
		next
		
		// Cambiamos el estado de la fase si corresponde
		dw_fase_actual.Retrieve(id_fase)
		dw_fases_estados.Retrieve(id_fase)
		select estado into :estado from fases where id_fase = :id_fase;
		if (estado<>g_fases_estados.registrado) and (estado<>g_fases_estados.retenido) &
		and (estado<>g_fases_estados.verificado) then
			messagebox(g_titulo,'El estado en que se encuentra la fase no permite a$$HEX1$$f100$$ENDHEX$$adir reparos')
			return 1
		else   
			if estado<>g_fases_estados.retenido then
				num_fases=dw_fases_estados.RowCount()
				dw_fase_actual.setitem(1,'estado',g_fases_estados.retenido)
				dw_fases_estados.insertrow(num_fases+1)
				dw_fases_estados.setitem(num_fases+1,'id_fase',id_fase)
				dw_fases_estados.setitem(num_fases+1,'estado',g_fases_estados.retenido)
				dw_fases_estados.setitem(num_fases+1,'fecha',today())
				dw_fases_estados.setitem(num_fases+1,'usuario',g_usuario)
			end if
		end if
	end if
	
	if borrar>0 and col_por_insertar>0 then
		dw_lista.Deleterow(borrar)
	end if
end if

end event

type dw_colegiados_por_fases from u_dw within w_reparos_lista
boolean visible = false
integer x = 3136
integer y = 24
integer width = 302
integer height = 300
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_reparos_colegiados_por_fases"
end type

type cb_mail from commandbutton within w_reparos_lista
boolean visible = false
integer x = 2039
integer y = 1064
integer width = 466
integer height = 80
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Notificar por &Email"
end type

event clicked;string colegiado,mail,nmail,id_fase,t_reparo
datetime f_subsanacion
string texto = ''
string mensaje = '',ls_id_cliente, ls_emplazamiento, ls_nombre, ls_clientes 
long ll_cuantos
string mensaje0 = 'Los siguientes reparos no han sido notificados por falta de Email de sus colegiados: '+ cr
int i,j

if f_puedo_escribir(g_usuario, '0000000017')= -1 then return

if dw_lista.RowCount()>0 then
	j=0
	// Ponemos todos los notificados por mail a N, para poder reenviarlos todas las veces que
	// queramos
	
	for i = 1 to dw_lista.RowCount()
		if isnull(dw_lista.GetItemDatetime(i,'f_subsanacion')) then
			dw_lista.SetItem(i,'email','N')
		end if
	next
	
	for i=1 to dw_lista.RowCount() 
	nmail=dw_lista.GetItemString(i,'email')
	t_reparo=dw_lista.GetItemString(i,'tipo_reparo')
	f_subsanacion=dw_lista.GetItemDatetime(i,'f_subsanacion')
		if nmail<>'S' and isnull(f_subsanacion) then
			id_fase = dw_lista.GetItemString(i,'id_fase')
			colegiado = dw_lista.GetItemString(i,'id_col')
			texto = 'Estimado compa$$HEX1$$f100$$ENDHEX$$ero :'+cr+cr+'En relaci$$HEX1$$f300$$ENDHEX$$n al expediente '+f_dame_n_reg(id_fase)+' / '+f_dame_exp(id_fase)+', se han observado los siguientes REPAROS : '+cr+cr
			//Modificaci$$HEX1$$f300$$ENDHEX$$n realizada por Luis para la incidencia CRI-57 15/01/2009
			if(g_colegio = 'COAATLR')then
				datastore ds_fases_promotores
				ds_fases_promotores = create datastore
				ds_fases_promotores.dataobject = 'd_fases_promotores'
				ds_fases_promotores.SetTransObject(SQLCA)
				ds_fases_promotores.retrieve(id_fase)
				
				ll_cuantos = ds_fases_promotores.rowcount()
				for i = 1 to ll_cuantos
					ls_id_cliente = ds_fases_promotores.getitemstring(i,"id_cliente")
					ls_nombre = f_dame_cliente(ls_id_cliente)
					ls_clientes = ls_clientes+', '+ls_nombre
				next
				select emplazamiento into :ls_emplazamiento from fases where id_fase=:id_fase;  
				texto = 'Estimado compa$$HEX1$$f100$$ENDHEX$$ero :'+cr+cr+'En relaci$$HEX1$$f300$$ENDHEX$$n al expediente '+f_dame_n_reg(id_fase)+' / '+f_dame_exp(id_fase)+', con promotor/es '+ls_clientes+' y situaci$$HEX1$$f300$$ENDHEX$$n en '+ls_emplazamiento+', se han observado los siguientes REPAROS : '+cr+cr
			end if
			//fin modificado Luis
			// A$$HEX1$$f100$$ENDHEX$$adimos todos los reparos de un mismo colegiado...
			for j=1 to dw_lista.RowCount()
				if dw_lista.GetItemString(j,'id_fase')=id_fase and dw_lista.GetItemString(j,'id_col')=colegiado and isnull(dw_lista.GetItemDatetime(j,'f_subsanacion'))then
					texto = texto+f_devuelve_tipo_reparo(dw_lista.GetItemString(j,'tipo_reparo')) + ' :'+ cr + cr
					if not isnull(dw_lista.GetItemString(j,'texto')) then	texto = texto + dw_lista.GetItemString(j,'texto') + cr
					dw_lista.SetItem(j,'email','S')
				end if
			next
			mail = f_devuelve_mail(colegiado)
			
			if not(f_es_vacio(mail)) then
				f_enviar_email('Notificaciones de Reparos',texto,mail,'csd','','')
				dw_lista.SetItem(i,'email','S')
				j++
			else
				mensaje = mensaje + 'Linea('+string(i)+')  '+ f_colegiado(colegiado)+ '  ' +f_devuelve_tipo_reparo(t_reparo)+cr
			end if
		end if
	next
	
	if not(f_es_vacio(mensaje)) then 
		mensaje = mensaje0 + mensaje +cr
		messagebox(g_titulo,mensaje)
	end if
end if

end event

type dw_fase_actual from u_dw within w_reparos_lista
boolean visible = false
integer x = 3141
integer y = 672
integer width = 302
integer height = 300
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_reparos_fase_actual"
end type

type dw_fases_estados from u_dw within w_reparos_lista
boolean visible = false
integer x = 3131
integer y = 352
integer width = 302
integer height = 300
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_fases_estados"
end type

type dw_lista_clientes_fase from u_dw within w_reparos_lista
boolean visible = false
integer x = 2784
integer y = 24
integer width = 302
integer height = 300
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_reparos_lista_clientes"
end type

type dw_lista_colegiados_fase from u_dw within w_reparos_lista
boolean visible = false
integer x = 2793
integer y = 344
integer width = 302
integer height = 300
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_reparos_lista_colegiados"
end type

type cb_anular_fase from commandbutton within w_reparos_lista
boolean visible = false
integer x = 3049
integer y = 1064
integer width = 425
integer height = 80
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "An&ular Fase"
end type

event clicked;string id_f,est,f_m_n_av,anul
long i
int err
datetime fecha_hoy

if f_puedo_escribir(g_usuario, '0000000017')= -1 then return

if dw_lista.rowcount()=0 then return

if messageBox(g_titulo, "Est$$HEX2$$e1002000$$ENDHEX$$a punto de anular el contrato "+dw_lista.getitemstring(dw_lista.getrow(), 'n_regfase')+cr+"$$HEX1$$bf00$$ENDHEX$$Desea continuar y anular el contrato?", question!, yesno!, 2) = 2 then return


fecha_hoy = datetime(today(), now())

// Sacamos el id_fase para cambiar el estado en dicho id_fase
// Cogemos el id_fase
id_f = dw_lista.getitemstring(dw_lista.getrow(), 'id_fase')
// Cogemos el estado de la fase
select estado into:est from fases where id_fase=:id_f ;
if est<>g_fases_estados.anulado then 
	// Si a$$HEX1$$fa00$$ENDHEX$$n no est$$HEX2$$e1002000$$ENDHEX$$anulado cambiamos
	// El valor del estado de dicho id_fase a anulado
	update fases set estado = :g_fases_estados.anulado where id_fase=:id_f;
	// Intentamos colocar en el historico de estados (no hago control de errores porque no vale la pena pa eso)
	INSERT INTO fases_estados (id_fase,cod_estado,fecha,usuario) VALUES (:id_f,:g_fases_estados.anulado,:fecha_hoy,:g_usuario)  ;
	// Confirmamos el grabado
	commit;
end if

end event

