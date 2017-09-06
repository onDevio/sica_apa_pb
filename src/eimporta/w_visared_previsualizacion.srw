HA$PBExportHeader$w_visared_previsualizacion.srw
forward
global type w_visared_previsualizacion from w_response
end type
type cb_cerrar from commandbutton within w_visared_previsualizacion
end type
type cb_1 from commandbutton within w_visared_previsualizacion
end type
type dw_1 from u_dw within w_visared_previsualizacion
end type
type st_leyenda from statictext within w_visared_previsualizacion
end type
type r_1 from rectangle within w_visared_previsualizacion
end type
type tab_1 from tab within w_visared_previsualizacion
end type
type tabpage_4 from userobject within tab_1
end type
type dw_arquitectos from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_arquitectos dw_arquitectos
end type
type tabpage_2 from userobject within tab_1
end type
type dw_colegiados from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_colegiados dw_colegiados
end type
type tabpage_5 from userobject within tab_1
end type
type dw_clientes from u_dw within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_clientes dw_clientes
end type
type tabpage_3 from userobject within tab_1
end type
type dw_constructores from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_constructores dw_constructores
end type
type tabpage_1 from userobject within tab_1
end type
type dw_estadisticas from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_estadisticas dw_estadisticas
end type
type tabpage_6 from userobject within tab_1
end type
type dw_gastos from u_dw within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_gastos dw_gastos
end type
type tabpage_7 from userobject within tab_1
end type
type dw_cuadro_superficies from u_dw within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_cuadro_superficies dw_cuadro_superficies
end type
type tabpage_8 from userobject within tab_1
end type
type dw_datos_urbanisticos from u_dw within tabpage_8
end type
type tabpage_8 from userobject within tab_1
dw_datos_urbanisticos dw_datos_urbanisticos
end type
type tabpage_9 from userobject within tab_1
end type
type dw_datos_estadisticos from u_dw within tabpage_9
end type
type tabpage_9 from userobject within tab_1
dw_datos_estadisticos dw_datos_estadisticos
end type
type tab_1 from tab within w_visared_previsualizacion
tabpage_4 tabpage_4
tabpage_2 tabpage_2
tabpage_5 tabpage_5
tabpage_3 tabpage_3
tabpage_1 tabpage_1
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
end type
end forward

global type w_visared_previsualizacion from w_response
integer width = 3643
integer height = 2340
boolean controlmenu = false
cb_cerrar cb_cerrar
cb_1 cb_1
dw_1 dw_1
st_leyenda st_leyenda
r_1 r_1
tab_1 tab_1
end type
global w_visared_previsualizacion w_visared_previsualizacion

type variables
string i_fichero_ini

u_dw idw_estadisticas
end variables

on w_visared_previsualizacion.create
int iCurrent
call super::create
this.cb_cerrar=create cb_cerrar
this.cb_1=create cb_1
this.dw_1=create dw_1
this.st_leyenda=create st_leyenda
this.r_1=create r_1
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cerrar
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.st_leyenda
this.Control[iCurrent+5]=this.r_1
this.Control[iCurrent+6]=this.tab_1
end on

on w_visared_previsualizacion.destroy
call super::destroy
destroy(this.cb_cerrar)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.st_leyenda)
destroy(this.r_1)
destroy(this.tab_1)
end on

event open;call super::open;f_centrar_ventana(this)

if LeftA(g_colegio,5)='COAAT' then
	tab_1.tabpage_6.visible=False
//	tab_1.tabpage_1.visible=false
end if

f_marca_vacios(this)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_visared_previsualizacion
integer x = 1321
integer y = 948
integer taborder = 30
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_visared_previsualizacion
integer x = 2437
integer y = 948
end type

type cb_cerrar from commandbutton within w_visared_previsualizacion
integer x = 3177
integer y = 2128
integer width = 411
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_visared_previsualizacion
boolean visible = false
integer x = 2043
integer y = 452
integer width = 402
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none2"
end type

event clicked;st_visared_busqueda parametros

parametros.n_expediente=dw_1.GetItemString(dw_1.getRow(),'n_expedi')
parametros.fase=dw_1.getitemString(dw_1.getRow(),'tipo_actuacion')
parametros.n_registro=dw_1.getitemString(dw_1.getRow(),'n_registro')
parametros.nif_cliente=tab_1.tabpage_5.dw_clientes.getitemString(1,'nif')
parametros.n_colegiado=dw_1.getitemString(dw_1.getRow(),'n_col')
parametros.nombre_promotor=tab_1.tabpage_5.dw_clientes.getitemString(1,'cliente')
parametros.nombre_colegiado=dw_1.getitemString(dw_1.getRow(),'nombre')

openwithparm(w_visared_busqueda,parametros)
end event

type dw_1 from u_dw within w_visared_previsualizacion
integer width = 3584
integer height = 960
integer taborder = 20
string dataobject = "d_visared_previsualizacion_visared"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;int fila
String dato
datetime fecha
string ls_version, ls_tipo_envio, ls_tipo, ls_comentario, ls_tipo_servicio


i_fichero_ini = Message.stringParm

settransobject(SQLCA)

ls_version = ProfileString(i_fichero_ini,"VERSION","version","")
//Inserto una fila
fila = InsertRow(0)

SetItem(fila, "n_registro", ProfileString(i_fichero_ini,"CONTRATO","n_registro",""))
SetItem(fila, "n_expedi", ProfileString(i_fichero_ini,"CONTRATO","n_expedi",""))

dato = ProfileString(i_fichero_ini,"CONTRATO","colegiado","")
SetItem(fila, "n_col", dato)
SetItem(fila, "nombre",f_visared_nombre_colegiado(dato))
SetItem(fila, "n_consejo",f_visared_colegiado_consejo(dato))
SetItem(fila, "nif",f_visared_colegiado_nif(dato))

SetItem(fila, "n_reg_colegial", ProfileString(i_fichero_ini,"CONTRATO","n_reg_colegial",""))
SetItem(fila, "n_exp_colegial", ProfileString(i_fichero_ini,"CONTRATO","n_exp_colegial",""))

dato = ProfileString(i_fichero_ini,"CONTRATO","f_entrada","")
if NOT f_es_vacio(dato) then
	fecha = datetime(date(dato),time('00:00:00'))
	SetItem(fila, "f_entrada",fecha)
end if

dato = ProfileString(i_fichero_ini,"CONTRATO","f_visado","")
if NOT f_es_vacio(dato) then 
	fecha = datetime(date(dato),time('00:00:00'))
	SetItem(fila, "f_visado",fecha)
end if

dato = ProfileString(i_fichero_ini,"CONTRATO","f_abono","")
if NOT f_es_vacio(dato) then 
	fecha = datetime(date(dato),time('00:00:00'))
	SetItem(fila, "f_abono", fecha)	
end if

dato = ProfileString(i_fichero_ini,"CONTRATO","f_final_obra","")
if NOT f_es_vacio(dato) then
	fecha = datetime(date(dato),time('00:00:00'))
	SetItem(fila, "f_final_obra", fecha)
end if

SetItem(fila, "cerrado", ProfileString(i_fichero_ini,"CONTRATO","cerrado","N"))
SetItem(fila, "titulo", ProfileString(i_fichero_ini,"CONTRATO","titulo",""))

dato = ProfileString(i_fichero_ini,"CONTRATO","tipo_actuacion","")
dato = f_tipo_actuacion(dato)
SetItem(fila, "tipo_actuacion", dato)

dato = ProfileString(i_fichero_ini,"CONTRATO","tipo_obra","")
dato = f_visared_tipo_trabajo(dato)
SetItem(fila, "tipo_obra", dato)

dato = ProfileString(i_fichero_ini,"CONTRATO","destino","")
dato = f_visared_trabajo(dato)
SetItem(fila, "destino", dato)

SetItem(fila, "administracion", ProfileString(i_fichero_ini,"CONTRATO","administracion",""))

dato = ProfileString(i_fichero_ini,"CONTRATO","tipo_via_emplazamiento","")
dato = f_visared_tipo_via(dato)
SetItem(fila, "tipo_via_emplazamiento", dato)

SetItem(fila, "emplazamiento", ProfileString(i_fichero_ini,"CONTRATO","emplazamiento",""))
SetItem(fila, "n_calle", ProfileString(i_fichero_ini,"CONTRATO","n_calle",""))

string prov,cod_pos,desc_prov
dato = ProfileString(i_fichero_ini,"CONTRATO","desc_poblacion","")
prov = ProfileString(i_fichero_ini,"CONTRATO","provincia","")
cod_pos = ProfileString(i_fichero_ini,"CONTRATO","cod_pos","")
prov=right('00000'+prov,5)
select nombre into :desc_prov from provincias where cod_provincia=:prov;

SetItem(fila, "poblacion",cod_pos )
SetItem(fila, "nombre_poblacion", dato)
SetItem(fila, "provincia", desc_prov)

dato = ProfileString(i_fichero_ini,"CONTRATO","gestion_de_cobro","")
SetItem(fila, "tipo_gestion", dato)

SetItem(fila, "honorarios", integer(ProfileString(i_fichero_ini,"CONTRATO","honorarios","")))
SetItem(fila, "observaciones", ProfileString(i_fichero_ini,"CONTRATO","observaciones",""))
//SetItem(fila, "", ProfileString(i_fichero_ini,"CONTRATO","",""))

//SCP-653. Alexis. 17/11/2010. Se a$$HEX1$$f100$$ENDHEX$$ade el tipo de env$$HEX1$$ed00$$ENDHEX$$o y el comentario
ls_tipo = ProfileString(i_fichero_ini,"DESCRIPTORES","tipo","")
ls_tipo_servicio = ProfileString(i_fichero_ini,"DESCRIPTORES","tipo_servicio","")
SetItem(fila, "tipo_envio", ls_tipo)

ls_comentario = ProfileString(i_fichero_ini,"DESCRIPTORES","comentario","")
if f_es_vacio(ls_comentario) then
	if ls_version = 'FEW' then
		select comentario_frontend into :ls_comentario from tipos_envio_visared where id_tipo_envio = :ls_tipo_servicio;
	else 
		select comentario_visared into :ls_comentario from tipos_envio_visared where codigo = :ls_tipo;
	end if
end if
setitem(fila, 'comentario', ls_comentario)



end event

type st_leyenda from statictext within w_visared_previsualizacion
integer x = 297
integer y = 2152
integer width = 709
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
string text = "En rojo los campos vacios"
boolean focusrectangle = false
end type

type r_1 from rectangle within w_visared_previsualizacion
integer linethickness = 1
long fillcolor = 255
integer x = 151
integer y = 2152
integer width = 137
integer height = 56
end type

type tab_1 from tab within w_visared_previsualizacion
integer y = 928
integer width = 3621
integer height = 1184
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean multiline = true
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_4 tabpage_4
tabpage_2 tabpage_2
tabpage_5 tabpage_5
tabpage_3 tabpage_3
tabpage_1 tabpage_1
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
end type

on tab_1.create
this.tabpage_4=create tabpage_4
this.tabpage_2=create tabpage_2
this.tabpage_5=create tabpage_5
this.tabpage_3=create tabpage_3
this.tabpage_1=create tabpage_1
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_9=create tabpage_9
this.Control[]={this.tabpage_4,&
this.tabpage_2,&
this.tabpage_5,&
this.tabpage_3,&
this.tabpage_1,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9}
end on

on tab_1.destroy
destroy(this.tabpage_4)
destroy(this.tabpage_2)
destroy(this.tabpage_5)
destroy(this.tabpage_3)
destroy(this.tabpage_1)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_9)
end on

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3584
integer height = 960
long backcolor = 79741120
string text = "Arquitectos t$$HEX1$$e900$$ENDHEX$$cnicos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "custom041!"
long picturemaskcolor = 536870912
dw_arquitectos dw_arquitectos
end type

on tabpage_4.create
this.dw_arquitectos=create dw_arquitectos
this.Control[]={this.dw_arquitectos}
end on

on tabpage_4.destroy
destroy(this.dw_arquitectos)
end on

type dw_arquitectos from u_dw within tabpage_4
integer x = 50
integer y = 64
integer width = 3520
integer height = 852
integer taborder = 10
boolean enabled = false
string dataobject = "d_visared_previsualizacion_arquitectos"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;int fila,total,procesados,sufijo
string parametro

i_fichero_ini = Message.StringParm

settransobject(SQLCA)

/*******   Colegiados   *******/

Total=integer(ProfileString(i_fichero_ini,"COLEGIADOS","total",""))
procesados=0
sufijo=1
if isNull(total) then
	return
end if
do while procesados<total
	//Inserto una fila
	fila = InsertRow(0)
	parametro="numero_"+string(sufijo)
	SetItem(fila, "numero", ProfileString(i_fichero_ini,"COLEGIADOS",parametro,""))

	parametro="porcentaje_"+string(sufijo)
	SetItem(fila, "porcentaje",double(ProfileString(i_fichero_ini,"COLEGIADOS",parametro,"")))
	
	parametro="autor_"+string(sufijo)
	SetItem(fila, "autor", ProfileString(i_fichero_ini,"COLEGIADOS",parametro,""))

	parametro="director_"+string(sufijo)
	SetItem(fila, "director", ProfileString(i_fichero_ini,"COLEGIADOS",parametro,""))
	
	parametro="nombre_"+string(sufijo)
	SetItem(fila, "nombre", ProfileString(i_fichero_ini,"COLEGIADOS",parametro,""))
	
	parametro="nif_"+string(sufijo)
	SetItem(fila, "nif", ProfileString(i_fichero_ini,"COLEGIADOS",parametro,""))
	
//	parametro="miembro_sociedad_"+string(sufijo)
//	SetItem(fila, "miembro_sociedad", ProfileString(i_fichero_ini,"COLEGIADOS",parametro,""))	
//	
	procesados=procesados+1
	sufijo=sufijo+1
Loop

/*******   ASOCIADOS*******/

Total=integer(ProfileString(i_fichero_ini,"ASOCIADOS","total",""))
procesados=0
sufijo=1
if isNull(total) then
	return
end if
do while procesados<total
	//Inserto una fila
	fila = InsertRow(0)
	parametro="numero_"+string(sufijo)
	SetItem(fila, "numero", ProfileString(i_fichero_ini,"ASOCIADOS",parametro,""))

	parametro="porcentaje_"+string(sufijo)
	SetItem(fila, "porcentaje",double(ProfileString(i_fichero_ini,"ASOCIADOS",parametro,"")))
	
	parametro="autor_"+string(sufijo)
	SetItem(fila, "autor", ProfileString(i_fichero_ini,"ASOCIADOS",parametro,""))

	parametro="director_"+string(sufijo)
	SetItem(fila, "director", ProfileString(i_fichero_ini,"ASOCIADOS",parametro,""))
	
	parametro="nombre_"+string(sufijo)
	SetItem(fila, "nombre", ProfileString(i_fichero_ini,"ASOCIADOS",parametro,""))
	
	parametro="nif_"+string(sufijo)
	SetItem(fila, "nif", ProfileString(i_fichero_ini,"ASOCIADOS",parametro,""))
	
//	parametro="miembro_sociedad_"+string(sufijo)
//	SetItem(fila, "miembro_sociedad", ProfileString(i_fichero_ini,"COLEGIADOS",parametro,""))	
//	
	procesados=procesados+1
	sufijo=sufijo+1
Loop
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3584
integer height = 960
long backcolor = 79741120
string text = "Otros Profesionales"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "custom032!"
long picturemaskcolor = 536870912
dw_colegiados dw_colegiados
end type

on tabpage_2.create
this.dw_colegiados=create dw_colegiados
this.Control[]={this.dw_colegiados}
end on

on tabpage_2.destroy
destroy(this.dw_colegiados)
end on

type dw_colegiados from u_dw within tabpage_2
integer x = 50
integer y = 64
integer width = 3520
integer height = 864
integer taborder = 11
boolean enabled = false
string dataobject = "d_visared_previsualizacion_colegiados"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;int fila,total,procesados,sufijo
string parametro

i_fichero_ini = Message.StringParm

settransobject(SQLCA)

/*******   Asociados   *******/

Total=integer(ProfileString(i_fichero_ini,"ARQUITECTOS","total",""))
procesados=0
sufijo=1

do while procesados<total
	//Inserto una fila
	fila = InsertRow(0)
	parametro="numero_"+string(sufijo)
	SetItem(fila, "numero", ProfileString(i_fichero_ini,"ARQUITECTOS",parametro,""))

	parametro="porcentaje_"+string(sufijo)
	SetItem(fila, "porcentaje", double(ProfileString(i_fichero_ini,"ARQUITECTOS",parametro,"")))

	parametro="autor_"+string(sufijo)
	SetItem(fila, "autor", ProfileString(i_fichero_ini,"ARQUITECTOS",parametro,""))

	parametro="director_"+string(sufijo)
	SetItem(fila, "director", ProfileString(i_fichero_ini,"ARQUITECTOS",parametro,""))
	
	parametro="nombre_"+string(sufijo)
	SetItem(fila, "nombre", ProfileString(i_fichero_ini,"ARQUITECTOS",parametro,""))
	
	parametro="nif_"+string(sufijo)
	SetItem(fila, "nif", ProfileString(i_fichero_ini,"ARQUITECTOS",parametro,""))
	
	
	procesados=procesados+1
	sufijo=sufijo+1
Loop

/*
	parametro="_"+string(sufijo)
	SetItem(fila, "", ProfileString(i_fichero_ini,"COLEGIADOS",parametro,""))
*/
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3584
integer height = 960
long backcolor = 79741120
string text = "Clientes"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "custom076!"
long picturemaskcolor = 536870912
dw_clientes dw_clientes
end type

on tabpage_5.create
this.dw_clientes=create dw_clientes
this.Control[]={this.dw_clientes}
end on

on tabpage_5.destroy
destroy(this.dw_clientes)
end on

type dw_clientes from u_dw within tabpage_5
integer x = 50
integer y = 64
integer width = 3520
integer height = 836
integer taborder = 11
boolean enabled = false
string dataobject = "d_visared_previsualizacion_clientes"
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;int fila,total,procesados,sufijo
string parametro

i_fichero_ini = Message.StringParm

settransobject(SQLCA)

Total=integer(ProfileString(i_fichero_ini,"CLIENTES","total",""))
procesados=0
sufijo=1
if isNull(total) then
	return
end if
do while procesados<total
	//Inserto una fila
	fila = InsertRow(0)
	
	parametro="nif_"+string(sufijo)
	SetItem(fila, "nif", ProfileString(i_fichero_ini,"CLIENTES",parametro,""))
	
	parametro="promotor_"+string(sufijo)
	SetItem(fila, "promotor", ProfileString(i_fichero_ini,"CLIENTES",parametro,""))
		//			participacion
	parametro="participacion_"+string(sufijo)
	SetItem(fila, "porcentaje", double(ProfileString(i_fichero_ini,"CLIENTES",parametro,"")))
	
	parametro = ProfileString(i_fichero_ini,"CLIENTES","nombre_"+string(sufijo),"") + " "  + &
					ProfileString(i_fichero_ini,"CLIENTES","apellidos_"+string(sufijo),"")
	
	SetItem(fila, "cliente", parametro)
	
	procesados=procesados+1
	sufijo=sufijo+1
Loop

/*
	parametro="_"+string(sufijo)
	SetItem(fila, "", ProfileString(i_fichero_ini,"CLIENTES",parametro,""))
*/
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3584
integer height = 960
long backcolor = 79741120
string text = "Constructores"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "createLibrary!"
long picturemaskcolor = 536870912
dw_constructores dw_constructores
end type

on tabpage_3.create
this.dw_constructores=create dw_constructores
this.Control[]={this.dw_constructores}
end on

on tabpage_3.destroy
destroy(this.dw_constructores)
end on

type dw_constructores from u_dw within tabpage_3
integer x = 50
integer y = 64
integer width = 3520
integer height = 832
integer taborder = 10
boolean enabled = false
string dataobject = "d_visared_previsualizacion_constructores"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;int fila,total,procesados,sufijo
string parametro

i_fichero_ini = Message.StringParm

settransobject(SQLCA)

/*******   CONSTRUCTORES   *******/

Total=integer(ProfileString(i_fichero_ini,"CONSTRUCTORES","total",""))
procesados=0
sufijo=1
if isNull(total) then
	return
end if
do while procesados<total
	//Inserto una fila
	fila = InsertRow(0)
	parametro="nombre_"+string(sufijo)
	SetItem(fila, "nombre", ProfileString(i_fichero_ini,"CONSTRUCTORES",parametro,""))

	parametro="contratista_"+string(sufijo)
	SetItem(fila, "contratista", ProfileString(i_fichero_ini,"CONSTRUCTORES",parametro,""))

	parametro="constructor_"+string(sufijo)
	SetItem(fila, "constructor", ProfileString(i_fichero_ini,"CONSTRUCTORES",parametro,""))

	procesados=procesados+1
	sufijo=sufijo+1
Loop


end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3584
integer height = 960
long backcolor = 79741120
string text = "Estad$$HEX1$$ed00$$ENDHEX$$stica"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "custom067!"
long picturemaskcolor = 536870912
dw_estadisticas dw_estadisticas
end type

on tabpage_1.create
this.dw_estadisticas=create dw_estadisticas
this.Control[]={this.dw_estadisticas}
end on

on tabpage_1.destroy
destroy(this.dw_estadisticas)
end on

type dw_estadisticas from u_dw within tabpage_1
integer x = 50
integer y = 64
integer width = 3520
integer height = 860
integer taborder = 31
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_visared_previsualizacion_estadisticas"
boolean vscrollbar = false
boolean border = false
string icon = "AppIcon!"
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;int fila
string colindantes2m

if LeftA(g_colegio,5)='COAAT' then
	i_fichero_ini = Message.StringParm
	dataObject='d_fases_datos_estadistica'
	settransobject(SQLCA)


	fila = InsertRow(0)
	// MODIFICADO RICARDO 2004-08-18-> Permitir los decimales en las superficies
	SetItem(fila, "pem", double(ProfileString(i_fichero_ini,"CONTRATO","pem","")))
	SetItem(fila, "sup_viv", double(ProfileString(i_fichero_ini,"CONTRATO","sup_viv","")))
	SetItem(fila, "sup_garaje", double(ProfileString(i_fichero_ini,"CONTRATO","sup_garaje","")))
	SetItem(fila, "sup_otros", double(ProfileString(i_fichero_ini,"CONTRATO","sup_otros","")))
	SetItem(fila, "volumen", double(ProfileString(i_fichero_ini,"CONTRATO","volumen","")))
	SetItem(fila, "altura", double(ProfileString(i_fichero_ini,"CONTRATO","altura","")))
	SetItem(fila, "num_viv", integer(ProfileString(i_fichero_ini,"CONTRATO","num_viv","")))
	SetItem(fila, "num_edif", integer(ProfileString(i_fichero_ini,"CONTRATO","num_edif","")))

	
	SetItem(fila, "colindantes", ProfileString(i_fichero_ini,"CONTRATO","colindantes",""))
	colindantes2m=ProfileString(i_fichero_ini,"CONTRATO","colindantes2m","")
	if f_es_vacio(colindantes2m) then
		colindantes2m=ProfileString(i_fichero_ini,"CONTRATO","colindates2m","")
	end if
	SetItem(fila, "colindantes2m",colindantes2m)
	
	SetItem(fila, "nivel_cont", ProfileString(i_fichero_ini,"CONTRATO","nivel control calidad",""))
	
	SetItem(fila, "uso", ProfileString(i_fichero_ini,"CONTRATO","uso",""))
	
	SetItem(fila, "estudio_geo", ProfileString(i_fichero_ini,"CONTRATO","estudio geotecnico",""))
	SetItem(fila, "cc_externo", ProfileString(i_fichero_ini,"CONTRATO","control calidad externo",""))
	SetItem(fila, "plantas_baj", integer(ProfileString(i_fichero_ini,"CONTRATO","plantas_baj","")))
	SetItem(fila, "sup_baj", double(ProfileString(i_fichero_ini,"CONTRATO","sup_baj","")))
	SetItem(fila, "plantas_sob",integer( ProfileString(i_fichero_ini,"CONTRATO","plantas_sob","")))
	SetItem(fila, "sup_sob", double(ProfileString(i_fichero_ini,"CONTRATO","sup_sob","")))
	// FIN MODIFICADO RICARDO 2004-08-18
	
	
	
else

i_fichero_ini = Message.StringParm


settransobject(SQLCA)

//Inserto una fila
fila = InsertRow(0)
// MODIFICADO RICARDO 2004-08-18-> Permitir los decimales en las superficies
SetItem(fila, "n_vpo",integer(ProfileString(i_fichero_ini,"ESTADISTICAS","n_vpo","")))
SetItem(fila, "n_vl",  integer(ProfileString(i_fichero_ini,"ESTADISTICAS","n_vpo","")))
SetItem(fila, "n_vpt", integer(ProfileString(i_fichero_ini,"ESTADISTICAS","n_vpt","")))
SetItem(fila, "n_otros", integer(ProfileString(i_fichero_ini,"ESTADISTICAS","n_otros","")))
SetItem(fila, "n_alm", integer(ProfileString(i_fichero_ini,"ESTADISTICAS","n_alm","")))
SetItem(fila, "n_naves", integer(ProfileString(i_fichero_ini,"ESTADISTICAS","n_naves","")))
SetItem(fila, "vpo_presup_viv", double(ProfileString(i_fichero_ini,"ESTADISTICAS","vpo_presup_viv","")))
SetItem(fila, "vpo_presup_garajes", double(ProfileString(i_fichero_ini,"ESTADISTICAS","vpo_presup_garajes","")))
SetItem(fila, "vpo_presup_locales", double(ProfileString(i_fichero_ini,"ESTADISTICAS","vpo_presup_locales","")))
SetItem(fila, "vpo_presup_total", double(ProfileString(i_fichero_ini,"ESTADISTICAS","vpo_presup_total","")))
SetItem(fila, "vpo_sup_viv", double(ProfileString(i_fichero_ini,"ESTADISTICAS","vpo_sup_viv","")))
SetItem(fila, "vpo_sup_garajes", double(ProfileString(i_fichero_ini,"ESTADISTICAS","vpo_sup_garajes","")))
SetItem(fila, "vpo_sup_locales", double(ProfileString(i_fichero_ini,"ESTADISTICAS","vpo_sup_locales","")))
SetItem(fila, "vpo_sup_total", double(ProfileString(i_fichero_ini,"ESTADISTICAS","vpo_sup_total","")))
SetItem(fila, "vl_presup_viv", double(ProfileString(i_fichero_ini,"ESTADISTICAS","vl_presup_viv","")))
SetItem(fila, "vl_presup_garajes", double(ProfileString(i_fichero_ini,"ESTADISTICAS","vl_presup_garajes","")))
SetItem(fila, "vl_presup_locales", double(ProfileString(i_fichero_ini,"ESTADISTICAS","vl_presup_locales","")))
SetItem(fila, "vl_presup_total", double(ProfileString(i_fichero_ini,"ESTADISTICAS","vl_presup_total","")))
SetItem(fila, "vl_sup_viv_2", double(ProfileString(i_fichero_ini,"ESTADISTICAS","vl_sup_viv","")))
SetItem(fila, "vl_sup_garajes", double(ProfileString(i_fichero_ini,"ESTADISTICAS","vl_sup_garajes","")))
SetItem(fila, "vl_sup_locales", double(ProfileString(i_fichero_ini,"ESTADISTICAS","vl_sup_locales","")))
SetItem(fila, "vl_sup_total", double(ProfileString(i_fichero_ini,"ESTADISTICAS","vl_sup_total","")))
SetItem(fila, "otros_presup_viv", double(ProfileString(i_fichero_ini,"ESTADISTICAS","otros_presup_viv","")))
SetItem(fila, "otros_presup_garajes", double(ProfileString(i_fichero_ini,"ESTADISTICAS","otros_presup_garajes","")))
SetItem(fila, "otros_presup_locales", double(ProfileString(i_fichero_ini,"ESTADISTICAS","otros_presup_locales","")))
SetItem(fila, "otros_presup_total", double(ProfileString(i_fichero_ini,"ESTADISTICAS","otros_presup_total","")))
SetItem(fila, "otros_sup_viv", double(ProfileString(i_fichero_ini,"ESTADISTICAS","otros_sup_viv","")))
SetItem(fila, "otros_sup_garajes", double(ProfileString(i_fichero_ini,"ESTADISTICAS","otros_sup_garajes","")))
SetItem(fila, "otros_sup_locales", double(ProfileString(i_fichero_ini,"ESTADISTICAS","otros_sup_locales","")))
SetItem(fila, "otros_sup_total", double(ProfileString(i_fichero_ini,"ESTADISTICAS","otros_sup_total","")))
SetItem(fila, "obra_ext_presup_total", integer(ProfileString(i_fichero_ini,"ESTADISTICAS","obra_ext_presup_total","")))
SetItem(fila, "total_presupuesto", double(ProfileString(i_fichero_ini,"ESTADISTICAS","total_presupuesto","")))
SetItem(fila, "total_superficie", double(ProfileString(i_fichero_ini,"ESTADISTICAS","total_superficie","")))
SetItem(fila, "promocion_publica", ProfileString(i_fichero_ini,"ESTADISTICAS","promocion_publica",""))

SetItem(fila, "tipo_obra", ProfileString(i_fichero_ini,"ESTADISTICAS","tipo_obra",""))
// FIN MODIFICADO RICARDO 2004-08-18-> Permitir los decimales en las superficies

end if

/*
SetItem(fila, "", ProfileString(i_fichero_ini,"ESTADISTICAS","",""))
*/
end event

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3584
integer height = 960
long backcolor = 79741120
string text = "Gastos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "custom048!"
long picturemaskcolor = 536870912
dw_gastos dw_gastos
end type

on tabpage_6.create
this.dw_gastos=create dw_gastos
this.Control[]={this.dw_gastos}
end on

on tabpage_6.destroy
destroy(this.dw_gastos)
end on

type dw_gastos from u_dw within tabpage_6
integer x = 50
integer y = 64
integer width = 3520
integer height = 828
integer taborder = 10
boolean enabled = false
string dataobject = "d_visared_previsualizacion_gastos"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;int fila,total,procesados,sufijo
string parametro, dato

if LeftA(g_colegio,5)='COAAT' then
	return
end if

i_fichero_ini = Message.StringParm

settransobject(SQLCA)

/*******   Gastos   *******/

Total=integer(ProfileString(i_fichero_ini,"GASTOS","total",""))
procesados=0
sufijo=1
if isNull(total) then
	return
end if
do while procesados<total
	//Inserto una fila
	fila = InsertRow(0)
	
	parametro="t_iva_"+string(sufijo)
	dato=ProfileString(i_fichero_ini,"GASTOS",parametro,"")
	//dato=f_visared_descripcion_iva(dato)
	SetItem(fila, "tipo_de_iva", dato)
	
	parametro="tipo_gasto_"+string(sufijo)
	dato=ProfileString(i_fichero_ini,"GASTOS",parametro,"")
	dato=f_visared_descripcion_gasto(dato)
	SetItem(fila, "tipo_gasto", dato)

	parametro="importe_"+string(sufijo)
	SetItem(fila, "importe", double(ProfileString(i_fichero_ini,"GASTOS",parametro,"")))
	
	parametro="total_"+string(sufijo)
	SetItem(fila, "total", double(ProfileString(i_fichero_ini,"GASTOS",parametro,"")))
	
	parametro="descripcion_"+string(sufijo)
	SetItem(fila, "descripcion", double(ProfileString(i_fichero_ini,"GASTOS",parametro,"")))
	procesados++
	sufijo++
loop

/*
SetItem(fila, "", ProfileString(i_fichero_ini,"GASTOS",parametro,""))
*/
end event

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3584
integer height = 960
long backcolor = 79741120
string text = "Superficies"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom041!"
long picturemaskcolor = 536870912
dw_cuadro_superficies dw_cuadro_superficies
end type

on tabpage_7.create
this.dw_cuadro_superficies=create dw_cuadro_superficies
this.Control[]={this.dw_cuadro_superficies}
end on

on tabpage_7.destroy
destroy(this.dw_cuadro_superficies)
end on

type dw_cuadro_superficies from u_dw within tabpage_7
integer x = 50
integer y = 64
integer width = 3520
integer height = 1016
integer taborder = 11
boolean enabled = false
string dataobject = "d_coactfe_fases_cuadro_superficies"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;long fila
string param
boolean sin_param
string nulo
setnull(nulo)

i_fichero_ini = Message.StringParm

fila = this.insertrow(0)

sin_param = true

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","unidadesvivienda",cr)
sin_param = sin_param and param=cr
SetItem(fila, "unidadesvivienda", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","unidadesoficinas",cr)
sin_param = sin_param and param=cr
SetItem(fila, "unidadesoficinas", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","unidadescomercial",cr)
sin_param = sin_param and param=cr
SetItem(fila, "unidadescomercial", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","unidadesgaraje",cr)
sin_param = sin_param and param=cr
SetItem(fila, "unidadesgaraje", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","unidadesotros",cr)
sin_param = sin_param and param=cr
SetItem(fila, "unidadesotros", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","m2utilesvivienda",cr)
sin_param = sin_param and param=cr
SetItem(fila, "m2utilesvivienda", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","m2utilesoficinas",cr)
sin_param = sin_param and param=cr
SetItem(fila, "m2utilesoficinas", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","m2utilescomercial",cr)
sin_param = sin_param and param=cr
SetItem(fila, "m2utilescomercial", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","m2utilesgaraje",cr)
sin_param = sin_param and param=cr
SetItem(fila, "m2utilesgaraje", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","m2utilesotros",cr)
sin_param = sin_param and param=cr
SetItem(fila, "m2utilesotros", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","m2constvivienda",cr)
sin_param = sin_param and param=cr
SetItem(fila, "m2constvivienda", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","m2constsoficinas",cr)
sin_param = sin_param and param=cr
SetItem(fila, "m2constoficinas", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","m2constcomercial",cr)
sin_param = sin_param and param=cr
SetItem(fila, "m2constcomercial", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","m2constgaraje",cr)
sin_param = sin_param and param=cr
SetItem(fila, "m2constgaraje", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","m2constotros",cr)
sin_param = sin_param and param=cr
SetItem(fila, "m2constotros", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","suptotalutil",cr)
sin_param = sin_param and param=cr
SetItem(fila, "suptotalutil", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","suptotalconst",cr)
sin_param = sin_param and param=cr
SetItem(fila, "suptotalconst", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","presupuestoem",cr)
sin_param = sin_param and param=cr
SetItem(fila, "presupuestoem", double(param))

// Si no se ha encontrado ning$$HEX1$$fa00$$ENDHEX$$n valor en el ini ocultamos la pesta$$HEX1$$f100$$ENDHEX$$a
if sin_param then
	tab_1.tabpage_7.visible = false
end if

end event

type tabpage_8 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3584
integer height = 960
long backcolor = 79741120
string text = "D. Urban$$HEX1$$ed00$$ENDHEX$$sticos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "CreateLibrary5!"
long picturemaskcolor = 536870912
dw_datos_urbanisticos dw_datos_urbanisticos
end type

on tabpage_8.create
this.dw_datos_urbanisticos=create dw_datos_urbanisticos
this.Control[]={this.dw_datos_urbanisticos}
end on

on tabpage_8.destroy
destroy(this.dw_datos_urbanisticos)
end on

type dw_datos_urbanisticos from u_dw within tabpage_8
integer x = 50
integer width = 3520
integer height = 988
integer taborder = 11
boolean enabled = false
string dataobject = "d_coactfe_fases_datos_urbanisticos"
boolean border = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;long fila
string param
boolean sin_param
string nulo
setnull(nulo)

i_fichero_ini = Message.StringParm

fila = this.insertrow(0)

sin_param = true

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","uso_predominante_norm",cr)
sin_param = sin_param and param=cr
if param = cr then param = ""
SetItem(fila, "uso_predominante_norm", param)

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","uso_predominante_proy",cr)
sin_param = sin_param and param=cr
if param = cr then param = ""
SetItem(fila, "uso_predominante_proy", param)

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","clasificacion_suelo_norm",cr)
sin_param = sin_param and param=cr
if param = cr then param = ""
SetItem(fila, "clasificacion_suelo_norm", param)

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","clasificacion_suelo_proy",cr)
sin_param = sin_param and param=cr
if param = cr then param = ""
SetItem(fila, "clasificacion_suelo_proy", param)

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","supparcelanm2",cr)
sin_param = sin_param and param=cr
SetItem(fila, "supparcelanm2", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","supparcelapm2",cr)
sin_param = sin_param and param=cr
SetItem(fila, "supparcelapm2", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","ocupaplantanporcen",cr)
sin_param = sin_param and param=cr
SetItem(fila, "ocupaplantanporcen", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","ocupaplantanm2",cr)
sin_param = sin_param and param=cr
SetItem(fila, "ocupaplantanm2", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","ocupaplantapporcen",cr)
sin_param = sin_param and param=cr
SetItem(fila, "ocupaplantapporcen", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","ocupaplantapm2",cr)
sin_param = sin_param and param=cr
SetItem(fila, "ocupaplantapm2", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","suptotalconsn",cr)
sin_param = sin_param and param=cr
SetItem(fila, "suptotalconsn", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","nplantassr",cr)
sin_param = sin_param and param=cr
SetItem(fila, "nplantassr", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","nplantasbr",cr)
sin_param = sin_param and param=cr
SetItem(fila, "nplantasbr", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","nplantassr_proyecto",cr)
sin_param = sin_param and param=cr
SetItem(fila, "nplantassr_proyecto", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","nplantasbr_proyecto",cr)
sin_param = sin_param and param=cr
SetItem(fila, "nplantasbr_proyecto", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","alturamaxnm",cr)
sin_param = sin_param and param=cr
SetItem(fila, "alturamaxnm", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","edificabinm3",cr)
sin_param = sin_param and param=cr
SetItem(fila, "edificabinm3", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","edificabinm2",cr)
sin_param = sin_param and param=cr
SetItem(fila, "edificabinm2", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","avianm",cr)
sin_param = sin_param and param=cr
SetItem(fila, "avianm", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","alinderonm",cr)
sin_param = sin_param and param=cr
SetItem(fila, "alinderonm", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","entreedifnm",cr)
sin_param = sin_param and param=cr
SetItem(fila, "entreedifnm", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","aticonm",cr)
sin_param = sin_param and param=cr
SetItem(fila, "aticonm", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","fondonm",cr)
sin_param = sin_param and param=cr
SetItem(fila, "fondonm", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","suptotalconsp",cr)
sin_param = sin_param and param=cr
SetItem(fila, "suptotalconsp", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","alturamaxpm",cr)
sin_param = sin_param and param=cr
SetItem(fila, "alturamaxpm", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","edificabipm3",cr)
sin_param = sin_param and param=cr
SetItem(fila, "edificabipm3", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","edificabipm2",cr)
sin_param = sin_param and param=cr
SetItem(fila, "edificabipm2", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","aviapm",cr)
sin_param = sin_param and param=cr
SetItem(fila, "aviapm", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","alinderopm",cr)
sin_param = sin_param and param=cr
SetItem(fila, "alinderopm", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","entreedifpm",cr)
sin_param = sin_param and param=cr
SetItem(fila, "entreedifpm", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","aticopm",cr)
sin_param = sin_param and param=cr
SetItem(fila, "aticopm", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","fondopm",cr)
sin_param = sin_param and param=cr
SetItem(fila, "fondopm", double(param))

// Si no se ha encontrado ning$$HEX1$$fa00$$ENDHEX$$n valor en el ini ocultamos la pesta$$HEX1$$f100$$ENDHEX$$a
if sin_param then
	tab_1.tabpage_8.visible = false
end if

end event

type tabpage_9 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3584
integer height = 960
long backcolor = 79741120
string text = "D. Estad$$HEX1$$ed00$$ENDHEX$$sticos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom067!"
long picturemaskcolor = 536870912
dw_datos_estadisticos dw_datos_estadisticos
end type

on tabpage_9.create
this.dw_datos_estadisticos=create dw_datos_estadisticos
this.Control[]={this.dw_datos_estadisticos}
end on

on tabpage_9.destroy
destroy(this.dw_datos_estadisticos)
end on

type dw_datos_estadisticos from u_dw within tabpage_9
integer x = 50
integer y = 68
integer width = 3520
integer height = 828
integer taborder = 11
boolean enabled = false
string dataobject = "d_coactfe_fases_datos_estadisticos"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;long fila
string param
boolean sin_param
string nulo
setnull(nulo)

i_fichero_ini = Message.StringParm

fila = this.insertrow(0)

sin_param = true

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","tipo_edificacion",cr)
sin_param = sin_param and param=cr
if param=cr then param=""
SetItem(fila, "tipo_edificacion", param)

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","regimen_uso",cr)
sin_param = sin_param and param=cr
if param=cr then param=""
SetItem(fila, "regimen_uso", param)

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","nivel_control_estructura",cr)
sin_param = sin_param and param=cr
if param=cr then param=""
SetItem(fila, "nivel_control_estructura", param)

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","hormigon",cr)
sin_param = sin_param and param=cr
if param=cr then param=""
SetItem(fila, "hormigon", param)

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","acero",cr)
sin_param = sin_param and param=cr
if param=cr then param=""
SetItem(fila, "acero", param)

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","ejecucion",cr)
sin_param = sin_param and param=cr
if param=cr then param=""
SetItem(fila, "ejecucion", param)

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","ensayo_materiales",cr)
sin_param = sin_param and param=cr
if param=cr then param=""
SetItem(fila, "ensayo_materiales", param)

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","ensayo",cr)
sin_param = sin_param and param=cr
SetItem(fila, "ensayo", double(param))

param = ProfileString(i_fichero_ini,"COACTFE_URBANISTICOS","ucestudiosegysaludprocede",cr)
sin_param = sin_param and param=cr
if param=cr then param=""
SetItem(fila, "ucestudiosegysaludprocede", param)

// Si no se ha encontrado ning$$HEX1$$fa00$$ENDHEX$$n valor en el ini ocultamos la pesta$$HEX1$$f100$$ENDHEX$$a
if sin_param then
	tab_1.tabpage_9.visible = false
end if

end event

