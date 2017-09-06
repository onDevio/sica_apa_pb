HA$PBExportHeader$w_reparos_nuevo_detalle.srw
forward
global type w_reparos_nuevo_detalle from w_response
end type
type dw_detalle from u_dw within w_reparos_nuevo_detalle
end type
type cb_1 from commandbutton within w_reparos_nuevo_detalle
end type
type cb_2 from commandbutton within w_reparos_nuevo_detalle
end type
end forward

global type w_reparos_nuevo_detalle from w_response
integer width = 2729
integer height = 1560
dw_detalle dw_detalle
cb_1 cb_1
cb_2 cb_2
end type
global w_reparos_nuevo_detalle w_reparos_nuevo_detalle

type variables
string is_id_reparos_ficha,is_id_fase
end variables

on w_reparos_nuevo_detalle.create
int iCurrent
call super::create
this.dw_detalle=create dw_detalle
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_detalle
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_reparos_nuevo_detalle.destroy
call super::destroy
destroy(this.dw_detalle)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;string n_ficha

is_id_reparos_ficha=Message.StringParm
select n_ficha,id_fase into :n_ficha,:is_id_fase from reparos_ficha where id_reparo_ficha=:is_id_reparos_ficha;

f_centrar_ventana(this)

this.title = 'Incidencia '+n_ficha


choose case g_colegio
	case 'COAATCC' 
		dw_detalle.dataobject='d_reparos_detalle_rep_cc'
	case 'COAATNA'
		dw_detalle.dataobject='d_reparos_detalle_rep_na'

end choose


if f_es_vacio(is_id_reparos_ficha) then 
	return
else
	dw_detalle.SetTransObject(SQLCA)
	dw_detalle.retrieve(is_id_reparos_ficha)
end if

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_reparos_nuevo_detalle
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_reparos_nuevo_detalle
end type

type dw_detalle from u_dw within w_reparos_nuevo_detalle
integer x = 37
integer y = 16
integer width = 2638
integer height = 1284
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_reparos_detalle_rep_na"
boolean border = false
end type

type cb_1 from commandbutton within w_reparos_nuevo_detalle
integer x = 1413
integer y = 1344
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cerrar"
end type

event clicked;Close(parent)
end event

type cb_2 from commandbutton within w_reparos_nuevo_detalle
integer x = 891
integer y = 1344
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;string n_reg,id_col,email,n_expedi,movil,n_col,nombre_fich
long i
datastore ds_imprime_hoja
string pdf,sms,papel,mail
string dw_imp

choose case g_colegio
	case 'COAATNA'
		dw_imp='d_reparos_detalle_nuevo_na'
	case 'COAATCC'
		dw_imp='d_incidencias_gestor_documental_cc'		
	case else
		
end choose

select n_registro,n_expedi into :n_reg,:n_expedi from fases where id_fase=:is_id_fase;
datastore ds_colegiados,ds_clientes
ds_colegiados=create datastore
ds_colegiados.dataobject='d_fases_colegiados'
ds_colegiados.SetTransObject(SQLCA)
ds_colegiados.retrieve(is_id_fase)

ds_clientes=create datastore
ds_clientes.dataobject='d_fases_promotores'
ds_clientes.SetTransObject(SQLCA)
ds_clientes.retrieve(is_id_fase)


n_csd_impresion_formato uo_impresion
uo_impresion=create n_csd_impresion_formato
uo_impresion.copias=1

uo_impresion.generar_registro='S' //g_formato_impresion.generar_registro
uo_impresion.tipo_receptor='C'
uo_impresion.asunto_email='Incidencias '+n_reg
uo_impresion.asunto_registro='Incidencias '+n_reg
uo_impresion.receptor=''
uo_impresion.serie='INC'
uo_impresion.texto_sms="Incidencia del encargo "+n_reg+" de su cliente "+ds_clientes.GetItemString(1,'cliente')+". Consulte su e-mail, Intranet o departamento de visado en horario de atenci$$HEX1$$f300$$ENDHEX$$n"
uo_impresion.texto_email="Incidencia del encargo "+n_reg+" de su cliente "+ds_clientes.GetItemString(1,'cliente')+".Adjuntamos el documento informativo."
uo_impresion.email = 'S'
uo_impresion.pdf= 'S'
uo_impresion.sms='S'

//uo_impresion.tipo_doc='AY'

uo_impresion.visualizar_web = 'N'
uo_impresion.destino='F'
uo_impresion.referencia=is_id_fase
uo_impresion.ruta_automatica=true
uo_impresion.ruta_relativa1=''
uo_impresion.ruta_relativa2=''
uo_impresion.ruta_relativa3=n_reg
uo_impresion.n_expedi=is_id_fase
uo_impresion.expediente=n_reg
uo_impresion.nombre="Incidencia_Reg_"+n_reg + "_Col_"

nombre_fich=uo_impresion.nombre
// SI HAY MAS DE UN COLEGIADO 
if ds_colegiados.rowcount()>1 then
	uo_impresion.masivo=true
	if uo_impresion.f_opciones_impresion()>0 then 
	
		for i=1 to ds_colegiados.rowcount()

			ds_imprime_hoja = create datastore

			id_col=ds_colegiados.GetItemString(i,'id_col')
			select n_colegiado,email,telefono_3 into :n_col,:email,:movil from colegiados where id_colegiado=:id_col;
			uo_impresion.direccion_email=email
			uo_impresion.moviles=movil
			uo_impresion.id_receptor=id_col
			uo_impresion.nombre=nombre_fich+n_col
			
			choose case g_colegio
				case 'COAATCC' 
					ds_imprime_hoja.dataobject = 'd_incidencias_gestor_documental_cc'	
					ds_imprime_hoja.SetTransObject(SQLCA)					
					f_rellenar_incid_gestor_docum_cc(is_id_fase,ds_imprime_hoja,is_id_reparos_ficha,id_col)
				case 'COAATNA'
					ds_imprime_hoja.dataobject = 'd_reparos_detalle_nuevo_na'
					ds_imprime_hoja.SetTransObject(SQLCA)					
					ds_imprime_hoja.retrieve(is_id_reparos_ficha)
			end choose
			uo_impresion.dw=ds_imprime_hoja
			uo_impresion.f_impresion()
		next			
	end if	 
else // SI SOLO HAY UN COLEGIADO 
	id_col=ds_colegiados.GetItemString(1,'id_col')
	select n_colegiado,email,telefono_3 into :n_col,:email,:movil from colegiados where id_colegiado=:id_col;
	if IsNull(n_col) then n_col=''
	uo_impresion.moviles=movil
	uo_impresion.direccion_email=email
	uo_impresion.id_receptor=id_col
	uo_impresion.nombre=nombre_fich+n_col	
	if uo_impresion.f_opciones_impresion()>0 then 	
		ds_imprime_hoja = create datastore
			choose case g_colegio
				case 'COAATCC' 
					ds_imprime_hoja.dataobject = 'd_incidencias_gestor_documental_cc'				
					ds_imprime_hoja.SetTransObject(SQLCA)
					f_rellenar_incid_gestor_docum_cc(is_id_fase,ds_imprime_hoja,is_id_reparos_ficha,id_col)
				case 'COAATNA'
					ds_imprime_hoja.dataobject = 'd_reparos_detalle_nuevo_na'
					ds_imprime_hoja.SetTransObject(SQLCA)
					ds_imprime_hoja.retrieve(is_id_reparos_ficha)
			end choose		
		
		uo_impresion.dw=ds_imprime_hoja
		uo_impresion.f_impresion()	
	end if
end if



pdf=uo_impresion.pdf
sms=uo_impresion.sms
papel=uo_impresion.papel
email=uo_impresion.email


// No se hacen todos en el mismo update para que sea acumulativo y al darle varias veces al boton imprimir
// vaya acumulando los tipos de impresi$$HEX1$$f300$$ENDHEX$$n
if pdf='S' then 
	update reparos_ficha set web=:pdf where id_reparo_ficha=:is_id_reparos_ficha;
end if

if sms='S' then 
	update reparos_ficha set sms=:sms where id_reparo_ficha=:is_id_reparos_ficha;
end if

if papel='S' then 
	update reparos_ficha set carta=:papel where id_reparo_ficha=:is_id_reparos_ficha;
end if

if email='S' then 
	update reparos_ficha set email=:email where id_reparo_ficha=:is_id_reparos_ficha;
end if
	
w_fases_detalle ventana
ventana=g_detalle_fases
ventana.idw_fases_registros.retrieve(ventana.dw_1.GetItemString(ventana.dw_1.GetRow(),'id_fase'))

end event

