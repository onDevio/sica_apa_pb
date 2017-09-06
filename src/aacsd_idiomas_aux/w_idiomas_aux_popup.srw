HA$PBExportHeader$w_idiomas_aux_popup.srw
forward
global type w_idiomas_aux_popup from w_popup
end type
type cb_salir from commandbutton within w_idiomas_aux_popup
end type
type cb_guardar from commandbutton within w_idiomas_aux_popup
end type
type ddlb_idioma from dropdownlistbox within w_idiomas_aux_popup
end type
type st_idioma from statictext within w_idiomas_aux_popup
end type
type ddlb_modulos from dropdownlistbox within w_idiomas_aux_popup
end type
type st_modulo from statictext within w_idiomas_aux_popup
end type
type dw_traducciones from u_csd_dw within w_idiomas_aux_popup
end type
end forward

global type w_idiomas_aux_popup from w_popup
integer width = 2821
integer height = 1124
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean center = true
boolean ib_isupdateable = false
event inserta_traduccion ( string texto_tag,  string traduccion,  string modulo,  string nombre )
cb_salir cb_salir
cb_guardar cb_guardar
ddlb_idioma ddlb_idioma
st_idioma st_idioma
ddlb_modulos ddlb_modulos
st_modulo st_modulo
dw_traducciones dw_traducciones
end type
global w_idiomas_aux_popup w_idiomas_aux_popup

type variables
string i_idioma
end variables

event inserta_traduccion(string texto_tag, string traduccion, string modulo, string nombre);string i_modulo,inserta,texto
Long posicion,li_fila


posicion = Pos(texto_tag,',')
texto = left(texto_tag,posicion - 1)
texto_tag = texto
posicion = Pos(texto_tag,'.')
modulo = left(texto_tag,posicion - 1)
i_idioma = g_idioma.of_getidioma( )

if i_idioma = 'ca' then
select traduccion into :traduccion from messages_ca where tag =:texto_tag; 
end if

CHOOSE CASE i_idioma
	case 'ca'
	  ddlb_idioma.selectitem(1)
	  
end choose
    if dw_traducciones.find( "tag="+"'"+texto_tag+"'", 1,dw_traducciones.rowcount()) <= 0 then
	li_fila = dw_traducciones.insertrow(0)
	dw_traducciones.setitem( li_fila, 'tag', texto_tag)
	dw_traducciones.setitem( li_fila, 'modulo', modulo)
	posicion = Pos(texto_tag,".")
	nombre = Mid(texto_tag,posicion +1)
    dw_traducciones.setitem( li_fila, 'nombre', nombre)
	 dw_traducciones.setitem( li_fila, 'traduccion', traduccion)
end if


end event

on w_idiomas_aux_popup.create
int iCurrent
call super::create
this.cb_salir=create cb_salir
this.cb_guardar=create cb_guardar
this.ddlb_idioma=create ddlb_idioma
this.st_idioma=create st_idioma
this.ddlb_modulos=create ddlb_modulos
this.st_modulo=create st_modulo
this.dw_traducciones=create dw_traducciones
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_salir
this.Control[iCurrent+2]=this.cb_guardar
this.Control[iCurrent+3]=this.ddlb_idioma
this.Control[iCurrent+4]=this.st_idioma
this.Control[iCurrent+5]=this.ddlb_modulos
this.Control[iCurrent+6]=this.st_modulo
this.Control[iCurrent+7]=this.dw_traducciones
end on

on w_idiomas_aux_popup.destroy
call super::destroy
destroy(this.cb_salir)
destroy(this.cb_guardar)
destroy(this.ddlb_idioma)
destroy(this.st_idioma)
destroy(this.ddlb_modulos)
destroy(this.st_modulo)
destroy(this.dw_traducciones)
end on

event open;call super::open;//dw_traducciones.settransobject(SQLCA)
 g_idioma.of_cambia_textos(this)
string texto_tag,texto,nombre,i_modulo,inserta,traduccion
Long posicion,li_fila
texto = Message.stringparm
posicion = Pos(texto,',')
texto_tag = left(texto,posicion - 1)
i_modulo = Mid(texto,posicion + 1)
i_idioma = g_idioma.of_getidioma( )

if i_idioma = 'ca' then
select traduccion into :traduccion from messages_ca where tag =:texto_tag; 
end if

ddlb_modulos.selectitem(integer(ddlb_modulos.finditem( i_modulo,0)))
CHOOSE CASE i_idioma
	case 'ca'
	 // dw_traducciones.dataobject = 'd_idiomas_aux_catalan'
	  //dw_traducciones.settransobject(SQLCA)	
	  ddlb_idioma.selectitem(1)
	  
end choose
posicion = Pos(texto,";")
inserta =left(texto,posicion) 

	li_fila = dw_traducciones.insertrow(0)
	dw_traducciones.setitem( li_fila, 'tag', texto_tag)
	dw_traducciones.setitem( li_fila, 'modulo', i_modulo)
	posicion = Pos(texto_tag,".")
	nombre = Mid(texto_tag,posicion +1)
    dw_traducciones.setitem( li_fila, 'nombre', nombre)
	 dw_traducciones.setitem( li_fila, 'traduccion',traduccion)


/*dw_traducciones.retrieve(texto_tag)
if dw_traducciones.retrieve(texto_tag) = 0 then
	dw_traducciones.insertrow(0)
	dw_traducciones.setitem( 1, 'tag', texto_tag)
	dw_traducciones.setitem( 1, 'modulo', i_modulo)
	posicion = Pos(texto_tag,".")
	nombre = Mid(texto_tag,posicion +1)
    dw_traducciones.setitem( 1, 'nombre', nombre)
end if	*/


end event

type cb_salir from commandbutton within w_idiomas_aux_popup
string tag = "texto=general.salir"
integer x = 1454
integer y = 904
integer width = 402
integer height = 112
integer taborder = 30
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

type cb_guardar from commandbutton within w_idiomas_aux_popup
string tag = "texto=general.guardar"
integer x = 1015
integer y = 904
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;integer l_i,l_cuantos
string l_nombre,l_modulo,l_traduccion,l_tag,l_idioma

l_idioma = g_idioma.of_getidioma( )
dw_traducciones.acceptText()
for l_i = 1 to dw_traducciones.Rowcount() 
	l_nombre = dw_traducciones.getitemstring(l_i,"nombre")
    l_modulo = dw_traducciones.getitemstring(l_i,"modulo")
	l_traduccion = dw_traducciones.getitemstring(l_i,"traduccion")	 
	l_tag = dw_traducciones.getitemstring(l_i,"tag")	
	
	if l_idioma = 'ca' then
	  select count(*) into :l_cuantos from messages_ca where tag =:l_tag;	
	  if isNull(l_cuantos) then l_cuantos=0
	  if l_cuantos <= 0 then
		insert into messages_ca(tag,traduccion,modulo,nombre) values(:l_tag,:l_traduccion,:l_modulo,:l_nombre);		
	else
		update messages_ca set tag=:l_tag,traduccion=:l_traduccion,modulo=:l_modulo,nombre=:l_nombre
		where tag=:l_tag; 
	end if
    end if	
next	

if sqlca.sqlcode<>0 then
	rollback;
	messagebox("ERROR","Ha ocurrido un error al grabar los datos.")
else
	commit;
	dw_traducciones.reset()
	Messagebox("IDIOMAS","Datos guardados/actualizados de forma correcta. para ver los cambios cierre y abra esta ventana.")
end if

end event

type ddlb_idioma from dropdownlistbox within w_idiomas_aux_popup
integer x = 1490
integer y = 40
integer width = 713
integer height = 400
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string item[] = {"Espa$$HEX1$$f100$$ENDHEX$$ol","Catal$$HEX1$$e000$$ENDHEX$$"}
borderstyle borderstyle = stylelowered!
end type

type st_idioma from statictext within w_idiomas_aux_popup
integer x = 1166
integer y = 56
integer width = 306
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Idioma:"
boolean focusrectangle = false
end type

type ddlb_modulos from dropdownlistbox within w_idiomas_aux_popup
integer x = 389
integer y = 40
integer width = 713
integer height = 400
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string item[] = {"Admin. judicial","Almacen","Aparatos tecnicos","Arquitectos","Arte / Cemento","Asesoria Judicial","Asistente","Demandas","Consejo","Contabilidad","Cuotas","Cursos Jornadas","Domic.","Importa","Facturacion","Fases","Fomento","Garantias","General","Incidencias","Junta Gobierno","Libros","Liquidacion","minutas","MUSAAT","colegiados"}
borderstyle borderstyle = stylelowered!
end type

type st_modulo from statictext within w_idiomas_aux_popup
integer x = 64
integer y = 56
integer width = 306
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Modulo:"
boolean focusrectangle = false
end type

type dw_traducciones from u_csd_dw within w_idiomas_aux_popup
integer x = 27
integer y = 172
integer width = 2770
integer height = 700
integer taborder = 10
string dataobject = "d_idiomas_aux_externo"
end type

