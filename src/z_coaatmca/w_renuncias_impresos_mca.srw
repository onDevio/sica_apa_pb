HA$PBExportHeader$w_renuncias_impresos_mca.srw
forward
global type w_renuncias_impresos_mca from w_response
end type
type dw_1 from u_dw within w_renuncias_impresos_mca
end type
type cb_1 from commandbutton within w_renuncias_impresos_mca
end type
type st_1 from statictext within w_renuncias_impresos_mca
end type
type cb_imprimir from commandbutton within w_renuncias_impresos_mca
end type
type cb_imprimir_todos from commandbutton within w_renuncias_impresos_mca
end type
type cb_preview from commandbutton within w_renuncias_impresos_mca
end type
type dw_colegiados from u_dw within w_renuncias_impresos_mca
end type
type dw_opciones from u_dw within w_renuncias_impresos_mca
end type
end forward

global type w_renuncias_impresos_mca from w_response
integer width = 1787
integer height = 2084
string title = "Renuncias"
event csd_opciones_impresion ( )
dw_1 dw_1
cb_1 cb_1
st_1 st_1
cb_imprimir cb_imprimir
cb_imprimir_todos cb_imprimir_todos
cb_preview cb_preview
dw_colegiados dw_colegiados
dw_opciones dw_opciones
end type
global w_renuncias_impresos_mca w_renuncias_impresos_mca

type variables
w_fases_detalle iw_fases
st_renuncias_impresion st_datos 
string is_id_fase

n_csd_impresion_formato impresion_formato
end variables

event csd_opciones_impresion();w_fases_detalle ventana
datetime f_entrada
string dia_hora

ventana= g_detalle_fases

//Datos de copias en papel
impresion_formato.papel = g_formato_impresion.papel
impresion_formato.copias 					= 1
impresion_formato.impresora_pag_desde 	= 1
impresion_formato.impresora_intervalo 	= 'T'
impresion_formato.impresora_intercalar 	= false

//Datos de copias en email
impresion_formato.email = g_formato_impresion.email	
impresion_formato.asunto_email = 'Renuncia Exp. '+ ventana.dw_1.GetItemString(ventana.dw_1.GetRow(),'n_expedi')
impresion_formato.texto_email 	= ''
impresion_formato.direccion_email 	= ''
//impresion_formato.direccion_email = f_devuelve_mail(i_id_col)

//Datos de copias en pdf
impresion_formato.visualizar_web 		= 'N'
impresion_formato.pdf = g_formato_impresion.pdf
impresion_formato.pdf_previsualizar 	= false	//No se muestra una previsualizaci$$HEX1$$f300$$ENDHEX$$n del pdf

//General
impresion_formato.destino 			= 'C'
impresion_formato.referencia 		= is_id_fase
impresion_formato.avisos 			= 0 		
impresion_formato.modo_creacion	= 2		//Avisamos si ya existe
impresion_formato.masivo = false
//	impresion_formato.id_receptor=i_id_col
//impresion_formato.generar_registro=g_formato_impresion.generar_registro
impresion_formato.generar_registro='S'
impresion_formato.tipo_receptor='C'
impresion_formato.serie='RENUNCIA'
//impresion_formato.ruta_relativa 		= g_ejercicio+'\'+idw_resumen.GetItemString(1,'n_colegiado')  // Ya no sirve
impresion_formato.ruta_automatica=true

dia_hora=string(datetime(today(),now()),'YYYYMMDD_HHMMSS')
f_entrada= ventana.dw_1.GetItemDateTime(ventana.dw_1.GetRow(),'f_entrada')
impresion_formato.ruta_base	  = g_directorio_documentos_visared
impresion_formato.ruta_relativa1=''
impresion_formato.ruta_relativa2=string(year(date(f_entrada)))
impresion_formato.ruta_relativa3= ventana.dw_1.GetItemString(ventana.dw_1.GetRow(),'n_registro')
impresion_formato.ruta_relativa4='renuncias'
impresion_formato.nombre = 'RENUNCIA_'+dia_hora

end event

on w_renuncias_impresos_mca.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.st_1=create st_1
this.cb_imprimir=create cb_imprimir
this.cb_imprimir_todos=create cb_imprimir_todos
this.cb_preview=create cb_preview
this.dw_colegiados=create dw_colegiados
this.dw_opciones=create dw_opciones
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_imprimir
this.Control[iCurrent+5]=this.cb_imprimir_todos
this.Control[iCurrent+6]=this.cb_preview
this.Control[iCurrent+7]=this.dw_colegiados
this.Control[iCurrent+8]=this.dw_opciones
end on

on w_renuncias_impresos_mca.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cb_imprimir)
destroy(this.cb_imprimir_todos)
destroy(this.cb_preview)
destroy(this.dw_colegiados)
destroy(this.dw_opciones)
end on

event open;call super::open;string ventana

iw_fases = g_detalle_fases
is_id_fase=Message.StringParm

f_centrar_ventana(this)

ventana = this.classname()
dw_opciones.insertrow(0)
dw_1.retrieve(ventana)
dw_colegiados.retrieve(is_id_fase)

impresion_formato=create n_csd_impresion_formato
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_renuncias_impresos_mca
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_renuncias_impresos_mca
end type

type dw_1 from u_dw within w_renuncias_impresos_mca
event csd_imprimir ( string dw,  boolean preview )
integer x = 73
integer y = 100
integer width = 1618
integer height = 644
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_renuncias_impresos"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event csd_imprimir(string dw, boolean preview);//
string id_fase,n_visado,n_expedi,n_reg
string cp,direccion
long i
string id_cliente,descrip,tipo_act,t_act
string clientes,cliente,emp,calle,puerta,piso,pob,colegiados_comas
string destinatario,domicilio_dest,poblacion_dest
string d_tipo_via,d_nom_via,d_cod_pos,d_pob,d_prov
string colegiado,colegiados,id_col, archivo, id_renuncia
double porcentaje,porcen_a
datastore ds_clientes,ds_renuncia,ds_colegiados
string nom_col,app_col
string final,tipo,dia_hora
string id_destinatario,n_colegiado,municipio
w_fases_detalle ventana
datetime fecha,f_renuncia,f_visado
string op1,op2,op3,op4
ventana=g_detalle_fases

ds_renuncia=create datastore
ds_renuncia.dataobject=dw
ds_renuncia.insertrow(0)



id_fase=is_id_fase
dia_hora=string(today(),'yyyymmdd')+'_'+string(now(),'hhmm')
id_col=dw_colegiados.GetItemSTring(dw_colegiados.GetRow(),'id_col')
n_colegiado=dw_colegiados.GetItemSTring(dw_colegiados.GetRow(),'n_colegiado')
impresion_formato.expediente = ventana.dw_1.GetItemString(ventana.dw_1.GetRow(),'n_registro')
impresion_formato.n_expedi = id_fase
fecha=datetime(today(),now())
f_renuncia=dw_colegiados.GetItemdatetime(dw_colegiados.GetRow(),'f_renuncia')
// campo Clientes
ds_clientes=create datastore
ds_clientes.dataobject='d_fases_promotores'
ds_clientes.SetTransObject(SQLCA)
ds_clientes.retrieve(id_fase)

clientes=""
for i=1 to ds_clientes.rowcount()
	id_cliente=ds_clientes.GetItemString(i,'id_cliente')
	cliente=f_dame_cliente ( id_cliente )
	clientes+=cliente+'~n~r'
next

// campo Colegiados
ds_colegiados=create datastore
ds_colegiados.dataobject='d_fases_colegiados'
ds_colegiados.SetTransObject(SQLCA)
ds_colegiados.retrieve(id_fase)

colegiados=''
colegiados_comas=''
for i=1 to ds_colegiados.rowcount()
	if ds_colegiados.GetItemString(i,'renunciado')='S' or ds_colegiados.GetItemString(i,'id_col')=id_col then continue
	porcen_a=ds_colegiados.GetItemNumber(i,'porcen_a')
	colegiado=f_colegiado_apellido ( ds_colegiados.GetItemString(i,'id_col') )
	//colegiados+=colegiado+' - '+string(porcen_a,'###.00')+'% ~n~r'
	colegiados+=colegiado+' - '+string(porcen_a,'###.00')+'% ~n~r'
	colegiados_comas+=colegiado+', '
next

colegiados_comas=left(colegiados_comas,len(colegiados_comas) - 2)



select f.n_registro, e.n_expedi,f.archivo,f.f_visado, f.descripcion, f.emplazamiento, f.n_calle, f.piso, f.puerta, p.descripcion,m.descripcion, t.d_t_trabajo, f.fase
into :n_reg,:n_expedi,:n_visado,:f_visado,:descrip,:emp,:calle,:piso,:puerta,:pob,:municipio,:tipo_act, :t_act
from fases f,poblaciones p,municipios m,expedientes e,tipos_trabajos t
where f.id_expedi=e.id_expedi and f.tipo_trabajo=t.c_t_trabajo and f.id_fase=:id_fase and f.poblacion=p.cod_pob and
p.pob_mopu=m.cod_muni and p.provincia=m.provincia;
 
porcentaje=dw_colegiados.GetItemNumber(1,'porc_renuncia')

if not(f_es_vacio(calle)) then emp+=', '+calle
if not(f_es_vacio(piso)) then emp+=', piso '+piso
if not(f_es_vacio(puerta)) then emp+=', pta '+puerta
if not(f_es_vacio(pob)) then emp+=', '+pob



// DESTINATARIO
select nombre,apellidos into :nom_col,:app_col from colegiados where id_colegiado=:id_col;

op1=dw_opciones.GetItemString(1,'opcion1')
op2=dw_opciones.GetItemString(1,'opcion2')
op3=dw_opciones.GetItemString(1,'opcion3')
op4=dw_opciones.GetItemString(1,'opcion4')

if lower(ds_renuncia.describe("colegio.name")) = 'colegio' then ds_renuncia.SetItem(1,'colegio',g_nombre_colegio_carta)
if lower(ds_renuncia.describe("colegio_direc.name")) = 'colegio_direc' then ds_renuncia.SetItem(1,'colegio_direc',g_direc_colegio_carta)
if lower(ds_renuncia.describe("colegio_pob.name")) = 'colegio_pob' then ds_renuncia.SetItem(1,'colegio_pob',g_pobla_colegio_carta)
if lower(ds_renuncia.describe("colegio_tlf.name")) = 'colegio_tlf' then ds_renuncia.SetItem(1,'colegio_tlf',g_col_telefono)
if lower(ds_renuncia.describe("colegio_fax.name")) = 'colegio_fax' then ds_renuncia.SetItem(1,'colegio_fax',g_col_fax)
if lower(ds_renuncia.describe("colegio_email.name")) = 'colegio_email' then ds_renuncia.SetItem(1,'colegio_email',g_email_colegio_carta)
if lower(ds_renuncia.describe("colegiados.name")) = 'colegiados' then ds_renuncia.SetItem(1,'colegiados',colegiados)
if lower(ds_renuncia.describe("colegiados_comas.name")) = 'colegiados_comas' then ds_renuncia.SetItem(1,'colegiados_comas',colegiados_comas)
if lower(ds_renuncia.describe("clientes.name")) = 'clientes' then ds_renuncia.SetItem(1,'clientes',clientes)
if lower(ds_renuncia.describe("emplazamiento.name")) = 'emplazamiento' then ds_renuncia.SetItem(1,'emplazamiento',emp)
if lower(ds_renuncia.describe("descripcion.name")) = 'descripcion' then ds_renuncia.SetItem(1,'descripcion',descrip)
if lower(ds_renuncia.describe("n_registro.name")) = 'n_registro' then ds_renuncia.SetItem(1,'n_reg',n_reg)
if lower(ds_renuncia.describe("n_expedi.name")) = 'n_expedi' then ds_renuncia.SetItem(1,'n_expedi',n_expedi)
if lower(ds_renuncia.describe("n_visado.name")) = 'n_visado' then ds_renuncia.SetItem(1,'n_visado',n_visado)
if lower(ds_renuncia.describe("tipo_actuacion.name")) = 'tipo_actuacion' then ds_renuncia.SetItem(1,'tipo_actuacion',tipo_act)
if lower(ds_renuncia.describe("t_act.name")) = 't_act' then ds_renuncia.SetItem(1,'t_act',t_act)
if lower(ds_renuncia.describe("f_renuncia.name")) = 'f_renuncia' then ds_renuncia.SetItem(1,'f_renuncia',f_renuncia)
if lower(ds_renuncia.describe("fecha.name")) = 'fecha' then ds_renuncia.SetItem(1,'fecha',fecha)
if lower(ds_renuncia.describe("f_visado.name")) = 'f_visado' then ds_renuncia.SetItem(1,'f_visado',f_visado)
if lower(ds_renuncia.describe("destinatario.name")) = 'destinatario' then ds_renuncia.SetItem(1,'destinatario',destinatario)
if lower(ds_renuncia.describe("domicilio_dest.name")) = 'domicilio_dest' then ds_renuncia.SetItem(1,'domicilio_dest',domicilio_dest)
if lower(ds_renuncia.describe("poblacion_dest.name")) = 'poblacion_dest' then ds_renuncia.SetItem(1,'poblacion_dest',poblacion_dest)
if lower(ds_renuncia.describe("porcentaje.name")) = 'porcentaje' then ds_renuncia.SetItem(1,'porcentaje',string(porcentaje)+' %')
if lower(ds_renuncia.describe("n_reg_salida.name")) = 'n_reg_salida' then ds_renuncia.SetItem(1,'n_reg_salida','RENUNCIA - '+f_siguiente_numero_registro_es('RENUNCIA',10))
if lower(ds_renuncia.describe("n_renuncia.name")) = 'n_renuncia' then ds_renuncia.SetItem(1,'n_renuncia',id_renuncia)
if lower(ds_renuncia.describe("municipio.name")) = 'municipio' then ds_renuncia.SetItem(1,'municipio',pob)
if lower(ds_renuncia.describe("nombre_col.name")) = 'nombre_col' then ds_renuncia.SetItem(1,'nombre_col',nom_col+' '+app_col)
if lower(ds_renuncia.describe("opcion1.name")) = 'opcion1' then ds_renuncia.SetItem(1,'opcion1',op1)
if lower(ds_renuncia.describe("opcion2.name")) = 'opcion2' then ds_renuncia.SetItem(1,'opcion2',op2)
if lower(ds_renuncia.describe("opcion3.name")) = 'opcion3' then ds_renuncia.SetItem(1,'opcion3',op3)
if lower(ds_renuncia.describe("opcion4.name")) = 'opcion4' then ds_renuncia.SetItem(1,'opcion4',op4)



impresion_formato.dw=ds_renuncia
long j

final=mid(dw,18)
tipo=left(final,pos(final,'_') -1)
choose case upper(tipo)
	case 'COLEGIADO'
		for i=1 to ds_colegiados.rowcount()
			colegiados_comas=''
			colegiados=''
			for j=1 to ds_colegiados.rowcount()
				if i=j then continue
				colegiado=f_colegiado_apellido ( ds_colegiados.GetItemString(j,'id_col') )
				colegiados_comas+=colegiado+', '
			next
			
			id_destinatario=ds_colegiados.getitemString(i,'id_col')
			if id_destinatario=id_col then continue
			
			select v.descripcion,d.nom_via,p.cod_pos,p.descripcion,pr.nombre
			into :d_tipo_via,:d_nom_via,:d_cod_pos,:d_pob,:d_prov
			from domicilios d,poblaciones p,provincias pr,tipos_via v
			where d.id_colegiado=:id_destinatario and d.tipo_via*=v.cod_tipo_via and d.cod_pob=p.cod_pob  and d.cod_prov=pr.cod_provincia;
			if IsNull(d_tipo_via) then d_tipo_via=''
			destinatario=f_colegiado_apellido( id_destinatario)
			domicilio_dest=trim(d_tipo_via+' '+d_nom_via)
			poblacion_dest=trim(d_cod_pos+' '+d_pob+' ('+d_prov+')')
		
			if lower(ds_renuncia.describe("destinatario.name")) = 'destinatario' then ds_renuncia.SetItem(1,'destinatario',destinatario)
			if lower(ds_renuncia.describe("domicilio_dest.name")) = 'domicilio_dest' then ds_renuncia.SetItem(1,'domicilio_dest',domicilio_dest)
			if lower(ds_renuncia.describe("poblacion_dest.name")) = 'poblacion_dest' then ds_renuncia.SetItem(1,'poblacion_dest',poblacion_dest)
			if lower(ds_renuncia.describe("colegiados_comas.name")) = 'colegiados_comas' then ds_renuncia.SetItem(1,'colegiados_comas',colegiados_comas)

		
		
			impresion_formato.dw=ds_renuncia
			impresion_formato.tipo_receptor='C'
			impresion_formato.nombre='RENUNCIA_COLEGIADO_'+string(i)+'_'+n_colegiado+'_'+dia_hora
			impresion_formato.asunto_registro='CARTA RENUNCIA COLEGIADO'	
			impresion_formato.id_receptor= id_destinatario
			
			impresion_formato.f_impresion()		
		next
	case 'CLIENTE'
		string cod_pob,tipo_via
		for i=1 to ds_clientes.rowcount()
			
			id_cliente=ds_clientes.getitemString(i,'id_cliente')
			d_nom_via=''
			d_cod_pos=''
			cod_pob=''
			tipo_via=''
			d_pob=''
			d_prov=''
			select c.nombre_via,c.cp,c.cod_pob,c.tipo_via
			into :d_nom_via,:d_cod_pos,:cod_pob,:tipo_via
			from clientes c
			where c.id_cliente=:id_cliente;		
			
			if tipo_via<>'00' then
				select descripcion
				into :d_tipo_via
				from tipos_via
				where cod_tipo_via=:tipo_via;
			end if
			
			select p.descripcion,pr.nombre
			into :d_pob,:d_prov
			from poblaciones p,provincias pr
			where p.cod_pob=:cod_pob  and p.provincia=pr.cod_provincia;		
			
			if IsNull(d_tipo_via) then d_tipo_via=''
			destinatario=f_dame_cliente(id_cliente)
			domicilio_dest=trim(d_tipo_via+' '+d_nom_via)
			poblacion_dest=trim(d_cod_pos+' '+d_pob)
			if not(f_es_vacio(d_prov)) then poblacion_dest+=' ('+d_prov+')'
			
			if lower(ds_renuncia.describe("destinatario.name")) = 'destinatario' then ds_renuncia.SetItem(1,'destinatario',destinatario)
			if lower(ds_renuncia.describe("domicilio_dest.name")) = 'domicilio_dest' then ds_renuncia.SetItem(1,'domicilio_dest',domicilio_dest)
			if lower(ds_renuncia.describe("poblacion_dest.name")) = 'poblacion_dest' then ds_renuncia.SetItem(1,'poblacion_dest',poblacion_dest)

			impresion_formato.dw=ds_renuncia
			impresion_formato.tipo_receptor='P'
			impresion_formato.nombre='RENUNCIA_CLIENTE_'+string(i)+'_'+n_colegiado+'_'+dia_hora
			impresion_formato.asunto_registro='CARTA RENUNCIA CLIENTE'	
			impresion_formato.id_receptor= id_cliente
			
			impresion_formato.f_impresion()		
			
		next
	case 'AYTO'
		string cod_mun,mun
		select p.descripcion,pr.nombre,p.pob_mopu into :d_pob,:d_prov,:cod_mun
		from fases f,poblaciones p,provincias pr where f.id_fase=:id_fase and f.poblacion=p.cod_pob and p.provincia=pr.cod_provincia;
		select cp,direccion,descripcion into :cp,:domicilio_dest,:mun from municipios where provincia='00007' and cod_muni=:cod_mun;
		if f_es_vacio(cp) then cp=''
		destinatario='AYUNTAMIENTO DE '+mun
		poblacion_dest=cp+' '+mun+' ('+d_prov+')'
		
		if lower(ds_renuncia.describe("destinatario.name")) = 'destinatario' then ds_renuncia.SetItem(1,'destinatario',destinatario)	
		if lower(ds_renuncia.describe("poblacion_dest.name")) = 'poblacion_dest' then ds_renuncia.SetItem(1,'poblacion_dest',poblacion_dest)
		if lower(ds_renuncia.describe("domicilio_dest.name")) = 'domicilio_dest' then ds_renuncia.SetItem(1,'domicilio_dest',domicilio_dest)
		
		impresion_formato.tipo_receptor='O'
		impresion_formato.nombre='RENUNCIA_AYTO_'+dia_hora
		impresion_formato.asunto_registro='CARTA RENUNCIA AYUNTAMIENTO'
		impresion_formato.receptor= 'AYUNTAMIENTO DE '+mun	
		impresion_formato.f_impresion()			
	case 'INSPEC'	
		impresion_formato.tipo_receptor='O'
		impresion_formato.nombre='RENUNCIA_INSPEC_'+dia_hora
		impresion_formato.asunto_registro='CARTA RENUNCIA INSPECCION DE TRABAJO'
		impresion_formato.receptor= 'INSPECCION DE TRABAJO'
		impresion_formato.f_impresion()		
	case 'CONSELLERIA'
		impresion_formato.tipo_receptor='O'
		impresion_formato.nombre='RENUNCIA_CONSELLERIA_'+dia_hora
		impresion_formato.asunto_registro='CARTA RENUNCIA CONSELLERIA DE TRABAJO Y FORMACION'
		impresion_formato.receptor= 'CONSELLERIA DE TRABAJO Y FORMACION'
		impresion_formato.f_impresion()		

end choose




end event

event rowfocuschanged;call super::rowfocuschanged;string final,tipo

final=mid(dw_1.GetItemString(currentrow,'dw'),18)
tipo=upper(left(final,pos(final,'_') -1))

if tipo='CONSELLERIA' or tipo='INSPEC' then
	dw_opciones.visible=true
else
	dw_opciones.visible=false	
end if

end event

event retrieveend;call super::retrieveend;if rowcount()>0 then this.event rowfocuschanged(1)
end event

type cb_1 from commandbutton within w_renuncias_impresos_mca
integer x = 1326
integer y = 1856
integer width = 402
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cerrar"
boolean cancel = true
end type

event clicked;close(parent)
end event

type st_1 from statictext within w_renuncias_impresos_mca
integer x = 69
integer y = 24
integer width = 914
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione la carta que desee"
boolean focusrectangle = false
end type

type cb_imprimir from commandbutton within w_renuncias_impresos_mca
integer x = 69
integer y = 1856
integer width = 402
integer height = 92
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

event clicked;
parent.event csd_opciones_impresion()

if impresion_formato.f_opciones_impresion()<>1 then return

dw_1.event csd_imprimir(dw_1.getitemstring(dw_1.getrow(), 'dw'), false)
end event

type cb_imprimir_todos from commandbutton within w_renuncias_impresos_mca
integer x = 485
integer y = 1856
integer width = 402
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir Todas"
end type

event clicked;long i
string final,tipo,fase
w_fases_detalle ventana

ventana=g_detalle_fases

parent.event csd_opciones_impresion()
if impresion_formato.f_opciones_impresion()<>1 then return
		
if g_colegio='COAATMCA' then
	// PARA MALLORCA SALTAMOS LA DEL AYTO EN LAS 0x e INSPECCION Y CONSELLERIA EN LAS 1X
	fase=ventana.dw_1.GetItemString(ventana.dw_1.GetRow(),'fase')
	for i = 1 to dw_1.rowcount()
		dw_1.setrow(i)
		final=mid(dw_1.GetItemString(i,'dw'),18)
		tipo=upper(left(final,pos(final,'_') -1))
		if left(fase,1)='0' and (tipo='AYTO') then continue
		if left(fase,1)='1' and (tipo='INSPEC' or tipo='CONSELLERIA') then continue		
		

		dw_1.event csd_imprimir(dw_1.getitemstring(dw_1.getrow(), 'dw'), false)		
		
		
	next
	
	
else


	for i = 1 to dw_1.rowcount()
		dw_1.setrow(i)
		dw_1.event csd_imprimir(dw_1.getitemstring(dw_1.getrow(), 'dw'), false)		
	next

end if
end event

type cb_preview from commandbutton within w_renuncias_impresos_mca
boolean visible = false
integer x = 905
integer y = 1856
integer width = 402
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Previsualizar"
end type

event clicked;dw_1.event csd_imprimir(dw_1.getitemstring(dw_1.getrow(), 'dw'), true)
end event

type dw_colegiados from u_dw within w_renuncias_impresos_mca
integer x = 41
integer y = 792
integer width = 1664
integer height = 444
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_colegiados_renuncia_mca"
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)
this.of_SetTransObject(SQLCA)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

// Enable printpreview service
of_SetPrintPreview (true)
end event

type dw_opciones from u_dw within w_renuncias_impresos_mca
integer x = 23
integer y = 1308
integer width = 1696
integer height = 524
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_renuncias_opciones_inspec_mca"
boolean vscrollbar = false
boolean border = false
end type

