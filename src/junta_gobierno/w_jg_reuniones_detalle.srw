HA$PBExportHeader$w_jg_reuniones_detalle.srw
forward
global type w_jg_reuniones_detalle from w_detalle
end type
type tab_1 from tab within w_jg_reuniones_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_jg_reuniones_asistentes_detalle from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_jg_reuniones_asistentes_detalle dw_jg_reuniones_asistentes_detalle
end type
type tab_1 from tab within w_jg_reuniones_detalle
tabpage_1 tabpage_1
end type
end forward

global type w_jg_reuniones_detalle from w_detalle
integer width = 3429
integer height = 1596
string title = "Detalle de Junta de Gobierno"
tab_1 tab_1
end type
global w_jg_reuniones_detalle w_jg_reuniones_detalle

forward prototypes
public function integer wf_divisible (double dividendo, double divisor)
end prototypes

public function integer wf_divisible (double dividendo, double divisor);//Esta funcion nos devuelve si un cierto valor es multiplio de otro
//Dada la propiedad de la divisi$$HEX1$$f300$$ENDHEX$$n, podemos averiguar si es m$$HEX1$$fa00$$ENDHEX$$ltiplo o no

double res=0,res_entero=0
integer valor=0
//Cogemos el valor de la divisi$$HEX1$$f300$$ENDHEX$$n
res=dividendo/divisor
//Cogemos y lo truncamos para obtener la parte entera
res_entero=truncate(res,0)
//Si Multiplicamos la parte entera y el divisor si nos da el valor del
//dividendo, eso significar$$HEX2$$e1002000$$ENDHEX$$que es divisible.....
if (res_entero*divisor=dividendo) 	then
	//Valor divisible
	valor = 1
end if
	
return valor
		
		

end function

on w_jg_reuniones_detalle.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_jg_reuniones_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event activate;call super::activate;g_dw_lista	= g_dw_lista_jgreuniones
g_w_lista   = g_lista_jgreuniones
g_w_detalle = g_detalle_jgreuniones

g_lista     = 'w_jg_reuniones_lista'
g_detalle   = 'w_jg_reuniones_detalle'
end event

event open;call super::open;//Enlazamos los datawindows correspondientes para poder sacar la informacion q los relaciona.
f_enlaza_dw(dw_1,tab_1.tabpage_1.dw_jg_reuniones_asistentes_detalle,'id_reunion','id_reunion')

//Redimensionamos los tabs  y las ventanas asociadas
inv_resize.of_Register (tab_1, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_1, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_1.dw_jg_reuniones_asistentes_detalle, "scaletoright&bottom")

end event

event type integer csd_nuevo();call super::csd_nuevo;If AncestorReturnValue>0 then
	string tipo
	//Ponemos el foco dentro del datawindows principal.
	dw_1.setfocus()
	
	//Ponemos un valor al identificador de la reunion de la junta de govierno, el contador  ID_JG_REUNION
	dw_1.SetItem(dw_1.GetRow(),'id_reunion',f_siguiente_numero('ID_JG_REUNION',10))
	//Ponemos la fecha de hoy
	dw_1.SetItem(dw_1.GetRow(),'fecha',datetime(today()))
	//Ponemos por defecto Ordinaria
	tipo='O'
	dw_1.SetItem(dw_1.GetRow(),'tipo',tipo)
	 
	//Ponemos las variables instancia a vacio, ya que creamos una reunion nueva
	g_jgreuniones_consulta.id_reunion=''
end if

return AncestorReturnValue
end event

event csd_primero();call super::csd_primero;//Preguntamos si hay filas el datawindows de la lista
if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(1)
	g_dw_lista.scrolltorow(1)
	//Cogemos el id de la reunion
		g_jgreuniones_consulta.id_reunion = g_dw_lista.getitemstring(1,"id_reunion")
		dw_1.event csd_retrieve()
end if
end event

event csd_siguiente();call super::csd_siguiente;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	g_jgreuniones_consulta.id_reunion = g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_reunion")
	dw_1.event csd_retrieve()
end if

end event

event csd_ultimo();call super::csd_ultimo;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(g_dw_lista.rowcount())
	g_dw_lista.scrolltorow(g_dw_lista.rowcount())
	//Cogemos el id de la reunion
	g_jgreuniones_consulta.id_reunion = g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_reunion")
		dw_1.event csd_retrieve()
end if

end event

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje=''
int retorno=1

if f_puedo_escribir(g_usuario,'0000000011')=-1 then return -1

mensaje=mensaje + f_valida(dw_1,'tipo','NOVACIO','Debe especificar el tipo de la reuni$$HEX1$$f300$$ENDHEX$$n: ORDINARIA O EXTRAORDINARIA')
mensaje=mensaje + f_valida(dw_1,'lugar','NOVACIO','Debe especificar el lugar donde se realizaran las reuniones')

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno = -1
end if
return retorno
end event

event csd_anterior();call super::csd_anterior;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	g_jgreuniones_consulta.id_reunion = g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_reunion")
	//Cogemos el colegiado asociado a la demanda
	dw_1.event csd_retrieve()
end if
end event

type cb_nuevo from w_detalle`cb_nuevo within w_jg_reuniones_detalle
end type

type cb_ayuda from w_detalle`cb_ayuda within w_jg_reuniones_detalle
end type

type cb_grabar from w_detalle`cb_grabar within w_jg_reuniones_detalle
end type

type cb_ant from w_detalle`cb_ant within w_jg_reuniones_detalle
end type

type cb_sig from w_detalle`cb_sig within w_jg_reuniones_detalle
end type

type dw_1 from w_detalle`dw_1 within w_jg_reuniones_detalle
integer x = 23
integer y = 44
integer height = 424
string dataobject = "d_jg_reuniones_detalle"
boolean border = false
end type

event dw_1::csd_retrieve();call super::csd_retrieve;//Comprobamos que la variabe que le pasamos, en este caso el identificador de la oferta
if g_jgreuniones_consulta.id_reunion='' or isnull(g_jgreuniones_consulta.id_reunion) then return
int    retorno
double i
//Cerramos la consulta
retorno = parent.event closequery()
if retorno = 1 then return
//Retriveamos los datos de la oferta
this.retrieve(g_jgreuniones_consulta.id_reunion)

//Vaciamos la variable instancia de la reunion
g_jgreuniones_consulta.id_reunion=''
end event

type tab_1 from tab within w_jg_reuniones_detalle
integer x = 23
integer y = 392
integer width = 3305
integer height = 1004
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
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3269
integer height = 876
long backcolor = 79741120
string text = "Asistentes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Picture!"
long picturemaskcolor = 536870912
dw_jg_reuniones_asistentes_detalle dw_jg_reuniones_asistentes_detalle
end type

on tabpage_1.create
this.dw_jg_reuniones_asistentes_detalle=create dw_jg_reuniones_asistentes_detalle
this.Control[]={this.dw_jg_reuniones_asistentes_detalle}
end on

on tabpage_1.destroy
destroy(this.dw_jg_reuniones_asistentes_detalle)
end on

type dw_jg_reuniones_asistentes_detalle from u_dw within tabpage_1
integer x = 9
integer y = 56
integer width = 3173
integer height = 796
integer taborder = 11
string dataobject = "d_jg_reuniones_asistentes_detalle"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event type long pfc_addrow();call super::pfc_addrow;//Ponemos un valor al identificador del asistente mediante el contador  ID_JG_ASISTENTE
this.SetItem(ancestorreturnvalue,'id_asistente',f_siguiente_numero('ID_JG_ASISTENTE',10))

return AncestorReturnValue

end event

event buttonclicked;call super::buttonclicked;string tipo
double horas,dietas
//Aceptamos los datos que hay en la ventana de arriba
dw_1.AcceptText()
//Dependiendo del valor del tipo incrementaremos/decrementaremos 1.5 o 2
tipo=dw_1.GetItemString(dw_1.getrow(),'tipo')
If f_es_vacio(tipo) then return 1

choose case dwo.name
	case 'b_inc_horas'
		//Si incrementamos horas, en una reunion ordinaria
		if tipo='O' then
			horas=this.GetItemNumber(row,'horas')
			horas=horas + g_jg_horas_ordinarias
			this.SetItem(row,'horas',horas)
		end if 
		if tipo='E' then 
		//Si incrementamos horas, en una reunion extraordinaria
			horas=this.GetItemNumber(row,'horas')
			horas=horas +  g_jg_horas_extraordinarias
			this.SetItem(row,'horas',horas)
		end if
		case 'b_dec_horas'
		//Si decrementamos horas, en una reunion ordinaria
		if tipo='O' then
			horas=this.GetItemNumber(row,'horas')
			If horas=00.00  then return 1
			horas=horas -  g_jg_horas_ordinarias
			this.SetItem(row,'horas',horas)
		end if
		if tipo='E' then 
		//Si decrementamos horas, en una reunion extraordinaria
			horas=this.GetItemNumber(row,'horas')
			If horas=00.00  then return 1
			horas=horas -  g_jg_horas_extraordinarias
			this.SetItem(row,'horas',horas)
		end if

	case 'b_inc_dietas'	
		//Si incrementamos dietas,tanto si es una reunion extraordinaria como si es ordinaria
			dietas=this.GetItemNumber(row,'dietas')
			dietas=dietas + g_jg_precio_dieta
			this.SetItem(row,'dietas',dietas)
	case 'b_dec_dietas'	
		//Si decrementamos dietas,tanto si es una reunion extraordinaria como si es ordinaria
			dietas=this.GetItemNumber(row,'dietas')
			If dietas =00.00  then return 1
			dietas=dietas - g_jg_precio_dieta
			this.SetItem(row,'dietas',dietas)

end choose

end event

event type long pfc_insertrow();call super::pfc_insertrow;//Ponemos un valor al identificador del asistente mediante el contador  ID_JG_ASISTENTE
this.SetItem(ancestorreturnvalue,'id_asistente',f_siguiente_numero('ID_JG_ASISTENTE',10))

return AncestorReturnValue

end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'cargo'
		string nombre, cod_cargo
		cod_cargo = data
		select nombre into :nombre from cargos  where cargos = :cod_cargo;
		this.setitem(row, 'nombre', nombre)
end choose
end event

