HA$PBExportHeader$w_sellador_integridad_detalle.srw
forward
global type w_sellador_integridad_detalle from w_response
end type
type dw_bd from u_dw within w_sellador_integridad_detalle
end type
type st_1 from statictext within w_sellador_integridad_detalle
end type
type st_2 from statictext within w_sellador_integridad_detalle
end type
type dw_docs from u_dw within w_sellador_integridad_detalle
end type
type cb_cerrar from u_cb within w_sellador_integridad_detalle
end type
type cb_subsanar from u_cb within w_sellador_integridad_detalle
end type
type dw_leyenda from u_dw within w_sellador_integridad_detalle
end type
type st_3 from statictext within w_sellador_integridad_detalle
end type
type st_4 from statictext within w_sellador_integridad_detalle
end type
type st_exp from statictext within w_sellador_integridad_detalle
end type
type st_reg from statictext within w_sellador_integridad_detalle
end type
end forward

global type w_sellador_integridad_detalle from w_response
integer width = 2779
integer height = 1768
event csd_comprobar ( boolean subsanar )
event csd_cargar_ficheros ( )
dw_bd dw_bd
st_1 st_1
st_2 st_2
dw_docs dw_docs
cb_cerrar cb_cerrar
cb_subsanar cb_subsanar
dw_leyenda dw_leyenda
st_3 st_3
st_4 st_4
st_exp st_exp
st_reg st_reg
end type
global w_sellador_integridad_detalle w_sellador_integridad_detalle

type variables
string color_original,i_id_fase
end variables

forward prototypes
public function string wf_acorta_nombre (string nombre)
end prototypes

event csd_comprobar(boolean subsanar);// Este evento realiza la comprobacion de incidencias y las subsana si la variable esta a true

long i,linea,fila
string fichero,id_fichero,tamano_kb,ruta,tamano_bd,tamano_fic,fichero_largo,accion,ruta_base
n_cst_color colores
double tamano

ruta=dw_bd.GetItemSTring(1,'ruta_fichero')
ruta_base= f_obtener_ruta_base(left(ruta,4))

// Comprobacion directa
for i=1 to dw_bd.rowcount()
	fichero=dw_bd.GetItemString(i,'nombre_fichero')
	id_fichero=dw_bd.GetItemString(i,'id_fichero')	
	linea=dw_docs.find("lower(nombre_fichero_largo)='"+lower(fichero)+"'",1,dw_docs.rowcount())
	
	fichero="'"+fichero+"'"	
	tamano_bd=dw_bd.GetItemString(i,'tamano')
	tamano_fic=""
	if linea>0 then tamano_fic=dw_docs.GetItemString(linea,'tamano')
	
	fila=dw_bd.find("lower(nombre_fichero)="+lower(fichero)+" and id_fichero<>'"+id_fichero+"'",1,dw_bd.rowcount())
	// La entrada NO existe en la carpeta local
	if linea = 0 then
		if subsanar then
			dw_bd.SetItem(i,'incidencia','N')
			delete fases_documentos_visared where id_fichero=:id_fichero;
			f_dw_resaltar_fila(dw_bd, 'nombre_fichero',fichero,colores.green)
		else			
			dw_bd.SetItem(i,'incidencia','S')
			f_dw_resaltar_fila(dw_bd, 'nombre_fichero',fichero,colores.red)
		end if
	
	// La entrada est$$HEX2$$e1002000$$ENDHEX$$duplicada
	elseif fila>0 then
		if subsanar then
			f_dw_resaltar_fila(dw_bd, 'nombre_fichero',fichero,colores.green)
			dw_bd.deleterow(fila)
			dw_bd.SetItem(i,'incidencia','N')
		else
			f_dw_resaltar_fila(dw_bd, 'nombre_fichero',fichero,colores.brown)
			dw_bd.SetItem(i,'incidencia','S')
			dw_bd.SetItem(fila,'incidencia','S')
		end if
	// El tama$$HEX1$$f100$$ENDHEX$$o de los ficheros es distinto
	elseif tamano_bd<>tamano_fic or IsNull(tamano_bd) or IsNull(tamano_fic) then
		if subsanar then
			tamano_kb=dw_docs.GetItemString(linea,'tamano')
			f_dw_resaltar_fila(dw_bd, 'nombre_fichero',fichero,colores.green)
			f_dw_resaltar_fila(dw_docs, 'nombre_fichero',fichero,colores.green)
			update fases_documentos_visared set tamano=:tamano_kb where id_fichero=:id_fichero;
			dw_bd.SetItem(i,'incidencia','N')
			dw_docs.SetItem(linea,'incidencia','N')			
		else	
			dw_bd.SetItem(i,'incidencia','S')
			dw_docs.SetItem(linea,'incidencia','S')
			f_dw_resaltar_fila(dw_bd, 'nombre_fichero',fichero,colores.yellow)
			f_dw_resaltar_fila(dw_docs, 'nombre_fichero',fichero,colores.yellow)		
		end if
	end if
	
next

// Comprobacion inversa
for i=1 to dw_docs.rowcount()
	fichero=dw_docs.GetItemString(i,'nombre_fichero')
	fichero_largo=dw_docs.GetItemString(i,'nombre_fichero_largo')
	linea=dw_bd.find("lower(nombre_fichero)='"+lower(fichero_largo)+"'",1,dw_bd.rowcount())

	if linea = 0 then
		if subsanar then
			accion=dw_docs.GetItemString(i,'accion')
			choose case accion
				case 'F'		// CREA UNA NUEVA ENTRADA			
					fila=dw_bd.insertrow(0)								
					dw_bd.setitem(fila, 'id_fichero', f_siguiente_numero('FASES_DOCU_VISARED', 10))
					dw_bd.setitem(fila, 'id_fase', i_id_fase)
					dw_bd.setitem(fila, 'nombre_fichero', fichero)
					dw_bd.setitem(fila, 'ruta_fichero',ruta)
					dw_bd.setitem(fila, 'sellado', 'N')
					dw_bd.setitem(fila, 'fecha', today())
					dw_bd.setitem(fila,'visualizar_web', 'N')
					tamano = Ceiling(gnv_fichero.of_GetFileSize(ruta_base + ruta + fichero_largo) / 1024)
					dw_bd.SetItem(fila,'tamano',string(tamano,"#,###,##0") + ' Kb')
					gnv_fichero.of_filerename(ruta_base + ruta + fichero_largo,ruta_base + ruta + fichero)
					f_dw_resaltar_fila(dw_bd, 'nombre_fichero',"'"+fichero+"'",colores.green)
				case 'X'		// BORRA EL FICHERO
					FileDelete(ruta_base + ruta + fichero_largo	)
				// case 'V' // NO HACE NADA
			end choose
			dw_docs.SetItem(i,'incidencia','N')
			f_dw_resaltar_fila(dw_docs, 'nombre_fichero',"'"+fichero+"'",colores.green)

		else
			dw_docs.SetItem(i,'accion','')
			if RightA(fichero,4)='.pdf' or RightA(fichero,4)='.zip' then
				dw_docs.SetItem(i,'accion','F')
			else
				dw_docs.SetItem(i,'accion','V')
			end if
			dw_docs.SetItem(i,'incidencia','S')
			f_dw_resaltar_fila(dw_docs, 'nombre_fichero',"'"+fichero+"'"	,colores.red)
		end if
	end if
next

dw_bd.update()


end event

event csd_cargar_ficheros();string n_registro,n_expedi,fase,id_fase,ruta,fichero,fichero_largo,ruta_base
long num_ficheros,fila,i,total
n_cst_dirattrib lista_ficheros[]
double tamano

i_id_fase=Message.StringParm

select e.n_expedi,f.fase,n_registro into :n_expedi,:fase,:n_registro
from fases f,expedientes e
where f.id_expedi=e.id_expedi and f.id_fase=:i_id_fase;

//this.title=n_expedi + '-' + fase + '  N$$HEX2$$ba002000$$ENDHEX$$Reg: ' + n_registro
st_exp.text=n_expedi + '-' + fase
st_reg.text= n_registro

// Cargamos los datos de los ficheros de la BD
total=dw_bd.retrieve(i_id_fase)

if total=0 then
	MessageBox(g_titulo,'No existen ficheros en este expediente')
	Close(this)
	return
else
	ruta=dw_bd.GetItemString(1,'ruta_fichero')
end if
st_2.text=ruta

ruta_base=f_obtener_ruta_base(left(ruta,4))

// Cargamos los datos de los ficheros fisicos
num_ficheros = gnv_fichero.of_dirlist(ruta_base + ruta + "*.*",0,lista_ficheros[])

for i=1 to num_ficheros
	fila=dw_docs.insertrow(0)
	fichero_largo=lista_ficheros[i].is_FileName
	dw_docs.SetItem(fila,'nombre_fichero_largo',fichero_largo)	
	fichero=wf_acorta_nombre(fichero_largo)
	dw_docs.SetItem(fila,'nombre_fichero',fichero)
	tamano = Ceiling(gnv_fichero.of_GetFileSize(ruta_base + ruta + fichero_largo) / 1024)
	dw_docs.SetItem(fila,'tamano',string(tamano,"#,###,##0") + ' Kb')
next

dw_docs.sort()


event csd_comprobar(false)
end event

public function string wf_acorta_nombre (string nombre);string izq,ext

if LenA(nombre)<= 100 then return nombre

ext=RightA(nombre,4)
izq=LeftA(nombre,96)

return izq+ext


end function

on w_sellador_integridad_detalle.create
int iCurrent
call super::create
this.dw_bd=create dw_bd
this.st_1=create st_1
this.st_2=create st_2
this.dw_docs=create dw_docs
this.cb_cerrar=create cb_cerrar
this.cb_subsanar=create cb_subsanar
this.dw_leyenda=create dw_leyenda
this.st_3=create st_3
this.st_4=create st_4
this.st_exp=create st_exp
this.st_reg=create st_reg
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_bd
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_docs
this.Control[iCurrent+5]=this.cb_cerrar
this.Control[iCurrent+6]=this.cb_subsanar
this.Control[iCurrent+7]=this.dw_leyenda
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_exp
this.Control[iCurrent+11]=this.st_reg
end on

on w_sellador_integridad_detalle.destroy
call super::destroy
destroy(this.dw_bd)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_docs)
destroy(this.cb_cerrar)
destroy(this.cb_subsanar)
destroy(this.dw_leyenda)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_exp)
destroy(this.st_reg)
end on

event open;call super::open;color_original=dw_bd.Object.DataWindow.Detail.Color

f_centrar_ventana(this)

dw_leyenda.insertrow(0)

event csd_cargar_ficheros()
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_sellador_integridad_detalle
integer x = 1847
integer y = 1420
integer width = 549
integer taborder = 20
string text = "Recuperar pantalla"
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_sellador_integridad_detalle
integer x = 2085
integer y = 1512
integer width = 489
string text = "Guardar pantalla"
end type

type dw_bd from u_dw within w_sellador_integridad_detalle
integer x = 23
integer y = 644
integer width = 1335
integer height = 856
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sellador_integridad_doc_visared"
boolean hscrollbar = true
boolean livescroll = false
end type

type st_1 from statictext within w_sellador_integridad_detalle
integer x = 421
integer y = 528
integer width = 498
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Base de Datos"
boolean focusrectangle = false
end type

type st_2 from statictext within w_sellador_integridad_detalle
integer x = 1408
integer y = 528
integer width = 1358
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Base de Datos"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_docs from u_dw within w_sellador_integridad_detalle
integer x = 1413
integer y = 644
integer width = 1335
integer height = 856
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sellador_integridad_doc_visared"
boolean hscrollbar = true
boolean livescroll = false
boolean ib_isupdateable = false
end type

event clicked;call super::clicked;choose case dwo.name
	case 'p_v'
		this.SetItem(row,'accion','X')
	case 'p_x'
		this.SetItem(row,'accion','F')
	case 'p_flecha'
		this.SetItem(row,'accion','V')		

		
		/*
	case 'columna_blanco'
		if this.GetItemString(row,'accion')='V' then 
			this.SetItem(row,'accion','X')
			return
		end if
		if this.GetItemString(row,'accion')='X' then 
			this.SetItem(row,'accion','F')
			return
		end if		
		if this.GetItemString(row,'accion')='F' then 
			this.SetItem(row,'accion','V')
			return
		end if		*/	
		
		
end choose
end event

type cb_cerrar from u_cb within w_sellador_integridad_detalle
integer x = 1330
integer y = 1528
integer width = 439
integer taborder = 11
boolean bringtotop = true
string text = "Cerrar"
end type

event clicked;call super::clicked;close(parent)
end event

type cb_subsanar from u_cb within w_sellador_integridad_detalle
integer x = 864
integer y = 1528
integer width = 439
integer taborder = 11
boolean bringtotop = true
string text = "Subsanar Todos"
end type

event clicked;call super::clicked;dw_bd.Modify( 'DataWindow.Detail.Color="'+color_original+'"')
dw_docs.Modify( 'DataWindow.Detail.Color="'+color_original+'"')

parent.event csd_comprobar(true)
//parent.event csd_cargar_ficheros()

MessageBox(g_titulo,"Correcci$$HEX1$$f300$$ENDHEX$$n Terminada")

end event

type dw_leyenda from u_dw within w_sellador_integridad_detalle
integer x = 1006
integer y = 32
integer width = 1650
integer height = 472
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sellador_integridad_leyenda"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;if data='S' then
	dw_bd.SetFilter("incidencia='S'")
	dw_bd.Filter()
	
	dw_docs.SetFilter("incidencia='S'")
	dw_docs.Filter()
else
	dw_bd.SetFilter("")
	dw_bd.Filter()

	dw_docs.SetFilter("")
	dw_docs.Filter()
end if
end event

type st_3 from statictext within w_sellador_integridad_detalle
integer x = 73
integer y = 40
integer width = 471
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$ba002000$$ENDHEX$$Expediente"
boolean focusrectangle = false
end type

type st_4 from statictext within w_sellador_integridad_detalle
integer x = 73
integer y = 244
integer width = 475
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$ba002000$$ENDHEX$$Registro"
boolean focusrectangle = false
end type

type st_exp from statictext within w_sellador_integridad_detalle
integer x = 73
integer y = 116
integer width = 805
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "exp"
boolean focusrectangle = false
end type

type st_reg from statictext within w_sellador_integridad_detalle
integer x = 73
integer y = 316
integer width = 800
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "reg"
boolean focusrectangle = false
end type

