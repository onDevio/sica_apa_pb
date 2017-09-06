HA$PBExportHeader$w_visared_busqueda.srw
forward
global type w_visared_busqueda from w_popup
end type
type dw_1 from u_dw within w_visared_busqueda
end type
type dw_2 from u_dw within w_visared_busqueda
end type
type cb_salir from commandbutton within w_visared_busqueda
end type
end forward

global type w_visared_busqueda from w_popup
integer width = 3264
integer height = 2208
string title = "B$$HEX1$$fa00$$ENDHEX$$squeda Rapida de Fases"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
dw_1 dw_1
dw_2 dw_2
cb_salir cb_salir
end type
global w_visared_busqueda w_visared_busqueda

event open;call super::open;st_visared_busqueda parametros

parametros=Message.PowerObjectParm

f_centrar_ventana(this)
dw_1.settrans(SQLCA)
dw_1.insertrow(0)

dw_1.setItem(dw_1.getrow(),"n_expediente",parametros.n_expediente)
dw_1.setItem(dw_1.getrow(),"fase",parametros.fase)
dw_1.setItem(dw_1.getrow(),"n_registro",parametros.n_registro)
dw_1.setItem(dw_1.getrow(),"nif_promotor",parametros.nif_cliente)
dw_1.setItem(dw_1.getrow(),"n_colegiado",parametros.n_colegiado)
dw_1.setItem(dw_1.getrow(),"nombre_promotor",parametros.nombre_promotor)
dw_1.setItem(dw_1.getrow(),"nombre_colegiado",parametros.nombre_colegiado)

//dw_1.setItem(dw_1.getrow(),"",)
//dw_1.setItem(dw_1.getrow(),"",)
////
//messagebox("parametros",parametros.n_expediente)
//messagebox("parametros",parametros.fase)
//messagebox("parametros",parametros.n_registro)
//messagebox("parametros",parametros.nif_cliente)
//messagebox("parametros",parametros.n_colegiado)
//messagebox("parametros",parametros.nombre_promotor)
//messagebox("parametros",parametros.nombre_colegiado)





end event

on w_visared_busqueda.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_salir=create cb_salir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_salir
end on

on w_visared_busqueda.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_salir)
end on

type dw_1 from u_dw within w_visared_busqueda
integer x = 78
integer y = 36
integer width = 2135
integer height = 692
integer taborder = 10
string dataobject = "d_visared_busqueda"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;string id_col, id_cliente
string nombre, apellidos
string sql_nuevo = '', activa
string sql_old

choose case dwo.name
	case "b_busca_colegiado"
  		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()   
		if NOT f_es_vacio(id_col)  then
			this.setitem(this.getrow(),'n_colegiado',f_colegiado_n_col(id_col))
			select nombre, apellidos into :nombre, :apellidos from colegiados where id_colegiado=:id_col;
			this.setitem(this.getrow(),'nombre_colegiado',nombre +' '+apellidos)
		end if

	case "b_busca_cliente"
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
		g_busqueda.dw="d_lista_busqueda_clientes"
		id_cliente=f_busqueda_clientes("")
		if NOT f_es_vacio(id_cliente)  then
			this.setitem(this.getrow(),'nif_promotor',f_dame_nif(id_cliente))			
			select nombre, apellidos into :nombre, :apellidos from clientes where id_cliente=:id_cliente;
			this.setitem(this.getrow(),'nombre_promotor',nombre +' '+apellidos)
		end if
	case "b_buscar"
	
	sql_old=dw_2.describe("datawindow.table.select")
	
	sql_nuevo=sql_old

	dw_2.AcceptText()

//PREGUNTAR A RAUL POR EL VALOR DEL id_fase
	f_sql('fases.n_registro','LIKE','n_registro',dw_1,sql_nuevo,g_tipo_base_datos,'')
	f_sql('fases.n_expedi','<=','n_expedienteh',dw_1,sql_nuevo,g_tipo_base_datos,'')
	f_sql('fases.n_expedi','>','n_expediente',dw_1,sql_nuevo,g_tipo_base_datos,'')	
	f_sql('fases.fase','LIKE','fase',dw_1,sql_nuevo,g_tipo_base_datos,'')	
	f_sql('fases_colegiados.id_col','=','n_colegiado',dw_1,sql_nuevo,g_tipo_base_datos,'')	
	f_sql('colegiados.apellidos','LIKE','nombre_colegiado',dw_1,sql_nuevo,g_tipo_base_datos,'')	
	f_sql('clientes.nif','LIKE','nif_promotor',dw_1,sql_nuevo,g_tipo_base_datos,'') 	
	f_sql('clientes.apellidos','LIKE','nombre_promotor',dw_1,sql_nuevo,g_tipo_base_datos,'') 

	dw_2.modify("Datawindow.table.select=~"" + sql_nuevo + "~"")
	dw_2.retrieve()
	dw_2.modify("Datawindow.table.select=~"" + sql_old + "~"")

END CHOOSE
	
end event

type dw_2 from u_dw within w_visared_busqueda
integer x = 32
integer y = 752
integer width = 3721
integer height = 1120
integer taborder = 10
string dataobject = "d_visared_busqueda_lista"
end type

type cb_salir from commandbutton within w_visared_busqueda
integer x = 3072
integer y = 1912
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;close(parent)
end event

