HA$PBExportHeader$w_etiquetas_visado_tg.srw
forward
global type w_etiquetas_visado_tg from w_response
end type
type dw_1 from u_dw within w_etiquetas_visado_tg
end type
type cb_previsualizar from commandbutton within w_etiquetas_visado_tg
end type
type cb_actualizar from commandbutton within w_etiquetas_visado_tg
end type
type cb_salir from commandbutton within w_etiquetas_visado_tg
end type
type dw_impresion from u_dw within w_etiquetas_visado_tg
end type
type cb_imprimir from commandbutton within w_etiquetas_visado_tg
end type
type cb_cerrar from commandbutton within w_etiquetas_visado_tg
end type
type dw_historico from u_dw within w_etiquetas_visado_tg
end type
end forward

global type w_etiquetas_visado_tg from w_response
integer width = 2167
integer height = 1676
event csd_cargar_datos_historico ( )
event csd_cargar_colegiados ( )
dw_1 dw_1
cb_previsualizar cb_previsualizar
cb_actualizar cb_actualizar
cb_salir cb_salir
dw_impresion dw_impresion
cb_imprimir cb_imprimir
cb_cerrar cb_cerrar
dw_historico dw_historico
end type
global w_etiquetas_visado_tg w_etiquetas_visado_tg

type variables
string i_id_fase,i_id_expedi,i_hoja_encargo, i_tipo_act
end variables

forward prototypes
public subroutine wf_rellenar_etiqueta (st_datos_etiquetas st_etiqueta)
end prototypes

event csd_cargar_datos_historico();long num

num=dw_historico.retrieve(i_id_expedi,i_hoja_encargo)

//Reseteamos los campos de insercion
dw_1.SetItem(1,'hoja_encargo',0)
dw_1.SetItem(1,'cq',0)	
dw_1.SetItem(1,'aprov_ps',0)		
dw_1.SetItem(1,'ess',0)			
dw_1.SetItem(1,'aprov_pr',0)			
dw_1.SetItem(1,'libro_ord',0)			
dw_1.SetItem(1,'hoja_asume',0)		
dw_1.SetItem(1,'ccq',0)		
dw_1.SetItem(1,'ebss',0)		
dw_1.SetItem(1,'css',0)			
dw_1.SetItem(1,'libro_inc',0)			
dw_1.SetItem(1,'cfo',0)				
dw_1.SetItem(1,'renuncia',0)	
dw_1.SetItem(1,'cfa',0)	
dw_1.SetItem(1,'hoja_encargo_tot',0)
dw_1.SetItem(1,'cq_tot',0)	
dw_1.SetItem(1,'aprov_ps_tot',0)		
dw_1.SetItem(1,'ess_tot',0)			
dw_1.SetItem(1,'aprov_pr_tot',0)			
dw_1.SetItem(1,'libro_ord_tot',0)			
dw_1.SetItem(1,'hoja_asume_tot',0)		
dw_1.SetItem(1,'ccq_tot',0)		
dw_1.SetItem(1,'ebss_tot',0)		
dw_1.SetItem(1,'css_tot',0)			
dw_1.SetItem(1,'libro_inc_tot',0)			
dw_1.SetItem(1,'cfo_tot',0)				
dw_1.SetItem(1,'renuncia_tot',0)	
dw_1.SetItem(1,'cfa_tot',0)	

// Cargamos los datos del historico
if num>0 then
	dw_historico.SetFilter("tipo_etiqueta='h_encargo'")
	dw_historico.Filter()
	if dw_historico.rowcount()>0 then dw_1.SetItem(1,'hoja_encargo_tot',dw_historico.GetItemNumber(1,'num_etiquetas'))
	
	dw_historico.SetFilter("tipo_etiqueta='cq'")
	dw_historico.Filter()
	if dw_historico.rowcount()>0 then dw_1.SetItem(1,'cq_tot',dw_historico.GetItemNumber(1,'num_etiquetas'))
	
	dw_historico.SetFilter("tipo_etiqueta='aprov_ps'")
	dw_historico.Filter()
	if dw_historico.rowcount()>0 then dw_1.SetItem(1,'aprov_ps_tot',dw_historico.GetItemNumber(1,'num_etiquetas'))

	dw_historico.SetFilter("tipo_etiqueta='ess'")
	dw_historico.Filter()
	if dw_historico.rowcount()>0 then dw_1.SetItem(1,'ess_tot',dw_historico.GetItemNumber(1,'num_etiquetas'))

	dw_historico.SetFilter("tipo_etiqueta='aprov_pr'")
	dw_historico.Filter()
	if dw_historico.rowcount()>0 then dw_1.SetItem(1,'aprov_pr_tot',dw_historico.GetItemNumber(1,'num_etiquetas'))

	dw_historico.SetFilter("tipo_etiqueta='libro_ord'")
	dw_historico.Filter()
	if dw_historico.rowcount()>0 then dw_1.SetItem(1,'libro_ord_tot',dw_historico.GetItemNumber(1,'num_etiquetas'))

	dw_historico.SetFilter("tipo_etiqueta='hoja_asume'")
	dw_historico.Filter()
	if dw_historico.rowcount()>0 then dw_1.SetItem(1,'hoja_asume_tot',dw_historico.GetItemNumber(1,'num_etiquetas'))

	dw_historico.SetFilter("tipo_etiqueta='ccq'")
	dw_historico.Filter()
	if dw_historico.rowcount()>0 then dw_1.SetItem(1,'ccq_tot',dw_historico.GetItemNumber(1,'num_etiquetas'))

	dw_historico.SetFilter("tipo_etiqueta='ebss'")
	dw_historico.Filter()
	if dw_historico.rowcount()>0 then dw_1.SetItem(1,'ebss_tot',dw_historico.GetItemNumber(1,'num_etiquetas'))

	dw_historico.SetFilter("tipo_etiqueta='css'")
	dw_historico.Filter()
	if dw_historico.rowcount()>0 then dw_1.SetItem(1,'css_tot',dw_historico.GetItemNumber(1,'num_etiquetas'))

	dw_historico.SetFilter("tipo_etiqueta='libro_inc'")
	dw_historico.Filter()
	if dw_historico.rowcount()>0 then dw_1.SetItem(1,'libro_inc_tot',dw_historico.GetItemNumber(1,'num_etiquetas'))

	dw_historico.SetFilter("tipo_etiqueta='cfo'")
	dw_historico.Filter()
	if dw_historico.rowcount()>0 then dw_1.SetItem(1,'cfo_tot',dw_historico.GetItemNumber(1,'num_etiquetas'))

	dw_historico.SetFilter("tipo_etiqueta='cfa'")
	dw_historico.Filter()
	if dw_historico.rowcount()>0 then dw_1.SetItem(1,'cfa_tot',dw_historico.GetItemNumber(1,'num_etiquetas'))

	dw_historico.SetFilter("tipo_etiqueta='renuncia'")
	dw_historico.Filter()
	if dw_historico.rowcount()>0 then dw_1.SetItem(1,'renuncia_tot',dw_historico.GetItemNumber(1,'num_etiquetas'))

//	dw_1.SetItem(1,'hoja_encargo_tot',dw_historico.GetItemNumber(1,'hoja_encargo'))
//	dw_1.SetItem(1,'cq_tot',dw_historico.GetItemNumber(1,'prog_cq'))	
//	dw_1.SetItem(1,'aprov_ps_tot',dw_historico.GetItemNumber(1,'aprov_ps'))		
//	dw_1.SetItem(1,'ess_tot',dw_historico.GetItemNumber(1,'ess'))			
//	dw_1.SetItem(1,'aprov_pr_tot',dw_historico.GetItemNumber(1,'aprov_pr'))			
//	dw_1.SetItem(1,'libro_ord_tot',dw_historico.GetItemNumber(1,'libro_ord'))			
//	dw_1.SetItem(1,'hoja_asume_tot',dw_historico.GetItemNumber(1,'hoja_asume'))		
//	dw_1.SetItem(1,'ccq_tot',dw_historico.GetItemNumber(1,'ccq'))		
//	dw_1.SetItem(1,'ebss_tot',dw_historico.GetItemNumber(1,'ebss'))		
//	dw_1.SetItem(1,'css_tot',dw_historico.GetItemNumber(1,'css'))			
//	dw_1.SetItem(1,'libro_inc_tot',dw_historico.GetItemNumber(1,'libro_inc'))			
//	dw_1.SetItem(1,'cfo_tot',dw_historico.GetItemNumber(1,'cfo'))				
//	dw_1.SetItem(1,'cfa_tot',dw_historico.GetItemNumber(1,'cfa'))		
//	dw_1.SetItem(1,'renuncia_tot',dw_historico.GetItemNumber(1,'renuncia'))			
end if





end event

event csd_cargar_colegiados();//
long i,fila,j,res
string n_col,id_col,nombre,apellidos,id_fase_col,id_soc,id_col_ficticio
DatawindowChild dwc_col1,dwc_col2,dwc_col3
double porcen,porcen_socio
Datastore ds_col,ds_col_asoc

select id_colegiado into :id_col_ficticio from colegiados where n_colegiado='00000';

ds_col=create datastore
ds_col.DataObject='d_fases_colegiados'
ds_col.SetTransObject(SQLCA)
ds_col.retrieve(i_id_fase)
if not(f_es_vacio(id_col_ficticio)) then
	ds_col.SetFilter("id_col <> '"+id_col_ficticio+"'")
	ds_col.Filter()
end if

ds_col_asoc=create datastore
ds_col_asoc.DataObject='d_fases_colegiados_asociados'
ds_col_asoc.SetTransObject(SQLCA)

dw_1.GetChild('id_colegiado',dwc_col1)
dw_1.GetChild('id_colegiado2',dwc_col2)
dw_1.GetChild('id_colegiado3',dwc_col3)


// Cargamos los colegiados
for i=1 to ds_col.rowcount()
	fila=dwc_col1.insertrow(0)
	id_col=ds_col.GetItemString(i,'id_col')
	porcen=ds_col.GetItemNumber(i,'porcen_a')
	id_fase_col=ds_col.GetItemString(i,'id_fases_colegiados')
	
	select n_colegiado,nombre,apellidos into :n_col,:nombre,:apellidos from colegiados where id_colegiado=:id_col;
	if f_es_vacio(nombre) then
		nombre=apellidos
	else
		nombre=nombre+' '+apellidos
	end if
	dwc_col1.SetItem(fila,'id_colegiado',id_col)
	dwc_col1.SetItem(fila,'n_colegiado',n_col)	
	dwc_col1.SetItem(fila,'nombre',nombre)		
	dwc_col1.SetItem(fila,'porcen',porcen)			
	
	
	// Cargamos los asociados SOLO TERRES
	if g_colegio='COAATTEB' then
		res=ds_col_asoc.retrieve(id_fase_col)
		
		for j=1 to ds_col_asoc.rowcount()
			id_col=ds_col_asoc.GetItemString(j,'id_col_per')
			id_soc=ds_col_asoc.GetItemString(j,'id_col_aso')
			porcen_socio=ds_col_asoc.GetItemNumber(j,'porcent')
			select n_colegiado,nombre,apellidos into :n_col,:nombre,:apellidos from colegiados where id_colegiado=:id_col;
			if f_es_vacio(nombre) then
				nombre=apellidos
			else
				nombre=nombre+' '+apellidos
			end if
			fila=dwc_col1.insertrow(0)
			dwc_col1.SetItem(fila,'id_colegiado',id_col)
			dwc_col1.SetItem(fila,'n_colegiado',n_col)	
			dwc_col1.SetItem(fila,'nombre',nombre)			
			dwc_col1.SetItem(fila,'id_sociedad',id_soc)	
			dwc_col1.SetItem(fila,'porcen',f_redondea(porcen_socio*porcen/100))
		next		
	end if
next

dwc_col1.rowscopy(1,dwc_col1.rowcount(),Primary!,dwc_col2,1,Primary!)
dwc_col1.rowscopy(1,dwc_col1.rowcount(),Primary!,dwc_col3,1,Primary!)


string id_col1
if dwc_col1.rowcount()>0 then 
	id_col1=dwc_col1.GetItemString(1,'id_colegiado')
	dw_1.SetItem(1,'id_colegiado',id_col1)
	dw_1.SetItem(1,'porcen_col1',f_redondea(dwc_col1.GetItemNumber(1,'porcen')))	
end if
if dwc_col1.rowcount()>1 then 
	dw_1.SetItem(1,'id_colegiado2',dwc_col1.GetItemString(2,'id_colegiado'))
	dw_1.SetItem(1,'porcen_col2',f_redondea(dwc_col1.GetItemNumber(2,'porcen')))			
end if
if dwc_col1.rowcount()>2 then 
	dw_1.SetItem(1,'id_colegiado3',dwc_col1.GetItemString(3,'id_colegiado'))
	dw_1.SetItem(1,'porcen_col3',f_redondea(dwc_col1.GetItemNumber(3,'porcen')))		
end if



end event

public subroutine wf_rellenar_etiqueta (st_datos_etiquetas st_etiqueta);long fila,ren
string nombre_etiqueta,texto_descripcion,id_ren,descripcion,n_renuncia
string t_act

fila=dw_impresion.insertrow(0)
dw_impresion.SetItem(fila,'colegiado',st_etiqueta.colegiado)
dw_impresion.SetItem(fila,'colegiado2',st_etiqueta.colegiado2)
dw_impresion.SetItem(fila,'colegiado3',st_etiqueta.colegiado3)
dw_impresion.SetItem(fila,'promotor',st_etiqueta.promotor)
dw_impresion.SetItem(fila,'emplazamiento',st_etiqueta.emplazamiento)
dw_impresion.SetItem(fila,'poblacion',st_etiqueta.poblacion)
dw_impresion.SetItem(fila,'superficie',st_etiqueta.superficie)
dw_impresion.SetItem(fila,'pem',st_etiqueta.pem)
dw_impresion.SetItem(fila,'fecha',st_etiqueta.fecha)
dw_impresion.SetItem(fila,'contratista',st_etiqueta.contratista)
dw_impresion.SetItem(fila,'tipo',string(st_etiqueta.tipo))
dw_impresion.SetItem(fila,'codigos','CODIS: '+st_etiqueta.codigos)
descripcion=st_etiqueta.descripcion

//SCP-818. Jesus. Se a$$HEX1$$f100$$ENDHEX$$ade tipo de tr$$HEX1$$e100$$ENDHEX$$mite
//dw_impresion.SetItem(fila,'tipo_tramite',st_etiqueta.tipo_tramite)

//SCP-1073. Se corrige el SetItem anterior, puesto que se ha detectado que Terres no tiene ese campo
if lower(dw_impresion.describe("tipo_tramite.name")) = 'tipo_tramite' then dw_impresion.SetItem(fila,'tipo_tramite',st_etiqueta.tipo_tramite)

if lower(dw_impresion.describe("n_visado.name")) = 'n_visado' then dw_impresion.SetItem(fila,'n_visado',st_etiqueta.n_visado)
if lower(dw_impresion.describe("codigos.name")) = 'codigos' then dw_impresion.SetItem(fila,'codigos','CODIS: '+st_etiqueta.codigos)
if lower(dw_impresion.describe("num_visados.name")) = 'num_visados' then dw_impresion.SetItem(fila,'num_visados',st_etiqueta.num_visados)


nombre_etiqueta=''
choose case st_etiqueta.tipo
	case 2
		nombre_etiqueta='PCQ:'
	case 3		
		nombre_etiqueta='Aprovaci$$HEX2$$f3002000$$ENDHEX$$Pla Seg.:'
	case 4		
		nombre_etiqueta='Estudi S.S.:'
	case 5		
		nombre_etiqueta='Aprovaci$$HEX2$$f3002000$$ENDHEX$$Pla Res.:'
	case 6
		if  string(i_tipo_act)<>'76' then
			nombre_etiqueta = "Llibre d'ordres"
		end if
	case 7		
		if g_colegio='COAATTEB' then
			//select id_renuncia,fase into :id_ren,:t_act from fases_renuncias r,fases f where r.id_fase=f.id_fase and f.id_fase=:i_id_fase order by fecha desc;
			select n_renuncia,fase into :n_renuncia,:t_act from fases_renuncias r,fases f where r.id_fase=f.id_fase and f.id_fase=:i_id_fase order by fecha desc;
			if IsNull(n_renuncia) then 
				id_ren=''
			else
				//if IsNumber(id_ren) then id_ren=string(long(id_ren))
			end if
			
			nombre_etiqueta='Ren$$HEX1$$fa00$$ENDHEX$$ncia '+n_renuncia+' ('+t_act+')'
		else
			nombre_etiqueta='Ren$$HEX1$$fa00$$ENDHEX$$ncia'
		end if
		descripcion=""
	case 9		
		nombre_etiqueta='Compliment CQ:'
	case 10		
		nombre_etiqueta='E.B.S.S.:'
	case 11		
		nombre_etiqueta='Coord. Seguretat:'
	case 13
		if  string(i_tipo_act)='76' then
			nombre_etiqueta='C.F.O.H.:'	
		else
		    nombre_etiqueta='C.F.O.:'	
		end if
	case 14		
		nombre_etiqueta='C.F.Act.:'

end choose


if IsNull(nombre_etiqueta) then nombre_etiqueta=''
if IsNull(descripcion) then descripcion=''

if g_colegio='COAATLL' then
	texto_descripcion=st_etiqueta.descripcion
	if right(nombre_etiqueta,1)=':' then nombre_etiqueta=left(nombre_etiqueta, len(nombre_etiqueta) - 1)
else
	texto_descripcion=nombre_etiqueta+descripcion
end if
//if g_colegio='COAATTEB' and st_etiqueta.tipo<>7 then texto_descripcion+='('+st_etiqueta.codigos+')'

if lower(dw_impresion.describe("descripcion.name")) = 'descripcion' then dw_impresion.SetItem(fila,'descripcion',texto_descripcion)
if lower(dw_impresion.describe("nombre_etiqueta.name")) = 'nombre_etiqueta' then dw_impresion.SetItem(fila,'nombre_etiqueta',nombre_etiqueta)
if lower(dw_impresion.describe("n_registro.name")) = 'n_registro' then dw_impresion.SetItem(fila,'n_registro',st_etiqueta.n_registro)




end subroutine

on w_etiquetas_visado_tg.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_previsualizar=create cb_previsualizar
this.cb_actualizar=create cb_actualizar
this.cb_salir=create cb_salir
this.dw_impresion=create dw_impresion
this.cb_imprimir=create cb_imprimir
this.cb_cerrar=create cb_cerrar
this.dw_historico=create dw_historico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_previsualizar
this.Control[iCurrent+3]=this.cb_actualizar
this.Control[iCurrent+4]=this.cb_salir
this.Control[iCurrent+5]=this.dw_impresion
this.Control[iCurrent+6]=this.cb_imprimir
this.Control[iCurrent+7]=this.cb_cerrar
this.Control[iCurrent+8]=this.dw_historico
end on

on w_etiquetas_visado_tg.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_previsualizar)
destroy(this.cb_actualizar)
destroy(this.cb_salir)
destroy(this.dw_impresion)
destroy(this.cb_imprimir)
destroy(this.cb_cerrar)
destroy(this.dw_historico)
end on

event open;call super::open;string n_visado,id_col,id_cli,n_expedi,desc_fase,id_col_ficticio 
datawindowchild dwc_col,dwc_cli,dwc_col2,dwc_col3
datastore ds_fases_colegiados
datetime f_entrada
i_id_fase=Message.StringParm


// Activamos el control calendario para los campos de tipo fecha
dw_1.of_SetDropDownCalendar(True)
dw_1.iuo_calendar.of_register(dw_1.iuo_calendar.DDLB)
dw_1.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_1.iuo_calendar.of_SetInitialValue(True)

select f.id_expedi,f.archivo,fc.id_col,fcli.id_cliente,e.n_expedi,f.celda,f.descripcion,f.f_entrada, f.fase
into :i_id_expedi,:n_visado,:id_col,:id_cli,:n_expedi,:i_hoja_encargo,:desc_fase,:f_entrada, :i_tipo_act
from fases f,fases_colegiados fc,fases_clientes fcli,expedientes e where f.id_fase=:i_id_fase and fc.id_fase=f.id_fase and fcli.id_fase=f.id_fase and e.id_expedi=f.id_expedi;


dw_1.GetChild('id_promotor',dwc_cli)
dwc_cli.SetTransObject(SQLCA)
dwc_cli.retrieve(i_id_fase)


dw_1.insertrow(0)
event csd_cargar_colegiados()
if g_colegio='COAATTGN' or g_colegio='COAATTEB' then
	dw_1.SetItem(1,'n_visado',n_expedi)
else
	//SCP-1344 En lleida se trata del caso especial 76
	if i_tipo_act = '76' then 
		dw_1.object.libro_ord_t.text="C$$HEX1$$e800$$ENDHEX$$dula d'habitabilitat"
	end if
	dw_1.SetItem(1,'n_visado',n_visado)
end if

dw_1.SetItem(1,'descripcion',desc_fase)
dw_1.SetItem(1,'id_promotor',id_cli)
dw_1.SetItem(1,'num_hoja',i_hoja_encargo)



//if g_colegio='COAATTGN' then
//	dw_1.SetItem(1,'fecha',f_entrada)
//else
	dw_1.SetItem(1,'fecha',datetime(today()))	
//end if



event csd_cargar_datos_historico()
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_etiquetas_visado_tg
integer x = 1015
integer y = 1116
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_etiquetas_visado_tg
integer x = 1591
integer y = 1124
end type

type dw_1 from u_dw within w_etiquetas_visado_tg
integer x = 18
integer y = 32
integer width = 2098
integer height = 1388
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_etiquetas_visado_datos"
boolean vscrollbar = false
boolean border = false
string icon = "AppIcon!"
boolean ib_isupdateable = false
end type

event editchanged;call super::editchanged;cb_actualizar.enabled=true
end event

event itemchanged;call super::itemchanged;long num

choose case dwo.name
	case 'num_hoja'
		i_hoja_encargo=data
		select count(*) into :num from fases where id_expedi=:i_id_expedi and celda=:i_hoja_encargo;
		
		if num <= 0 then
			MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$", "La fulla de enc$$HEX1$$e000$$ENDHEX$$rrec seleccionada no existeix")
			return 2
		end if
		event csd_cargar_datos_historico()
end choose
end event

type cb_previsualizar from commandbutton within w_etiquetas_visado_tg
integer x = 224
integer y = 1468
integer width = 402
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Previsualizar"
end type

event clicked;long i,fila,posic_nvis,pos_final
string cod_trabajo,desc_trabajo,dest_int,num_hoja,num_visados,nvis
double pem,sup,sup_viv,sup_garaje,sup_otros
string n_visado,fecha_s,n_col,id_col,id_cli,texto,emplaz,texto_pem,texto_pem1
string promotor,contratista,apellidos_col,nombre_col,apellidos_cli,nombre_cli,nombre_col2,nombre_col3,apellidos_col2,apellidos_col3,n_col2,id_col2,id_col3,n_col3
string t_act,id_expedi,tipos,n_vis,porcen_col,porcen_col2,porcen_col3
string texto_superficie,cod_pos,poblacion,calle,piso,puerta
string is_tipo_tramite,dw,n_registro,desc_obra,tipo_via
st_datos_etiquetas  lst_etiquetas
dw_1.AcceptText()


select texto into :dw from var_globales where nombre='g_dw_etiquetas_visado';

//SCP-1368
/*if g_colegio= 'COAATLL' then
 if  (string(i_tipo_act)='76'  ) then 
	   dw_impresion.dataobject='d_etiquetas_habitabilidad_ll'
    else 
	    dw_impresion.dataobject='d_etiquetas_visado_impresion_ll'	
    end if
end if*/

////////////////////////////////
if f_es_vacio(dw) then
choose case  g_colegio
	case 'COAATTGN'
		dw_impresion.dataobject='d_etiquetas_visado_impresion_tg'		
	case 'COAATTEB'
		dw_impresion.dataobject='d_etiquetas_visado_impresion_teb'		
	case 'COAATLL'
		//SCP-1368 
   		dw_impresion.dataobject='d_etiquetas_visado_impresion_ll'	
	end choose
end if
//////////////////////////////
//if f_es_vacio(dw) then
//	if g_colegio='COAATTGN' then
//		dw_impresion.dataobject='d_etiquetas_visado_impresion_tg'
//	else
//		dw_impresion.dataobject='d_etiquetas_visado_impresion_teb'
//	end if
//else
//	dw_impresion.dataobject=dw
//	
//end if

dw_impresion.reset()

fecha_s=String(dw_1.GetItemDateTime(1,'fecha'),'dd/mm/yy')
id_col=dw_1.GetItemString(1,'id_colegiado')
id_col2=dw_1.GetItemString(1,'id_colegiado2')
id_col3=dw_1.GetItemString(1,'id_colegiado3')
id_cli=dw_1.GetItemString(1,'id_promotor')
contratista=dw_1.GetItemString(1,'contratista')
porcen_col=string(dw_1.GetItemNumber(1,'porcen_col1'))
porcen_col2=string(dw_1.GetItemNumber(1,'porcen_col2'))
porcen_col3=string(dw_1.GetItemNumber(1,'porcen_col3'))
num_hoja=dw_1.GetItemString(1,'num_hoja')

select n_colegiado,nombre,apellidos into :n_col,:nombre_col,:apellidos_col from colegiados where id_colegiado=:id_col;
select n_colegiado,nombre,apellidos into :n_col2,:nombre_col2,:apellidos_col2 from colegiados where id_colegiado=:id_col2;
select n_colegiado,nombre,apellidos into :n_col3,:nombre_col3,:apellidos_col3 from colegiados where id_colegiado=:id_col3;
select nombre,apellidos into :nombre_cli,:apellidos_cli from clientes where id_cliente=:id_cli;


if IsNull(n_col) then n_col=''
if IsNull(n_col2) then n_col2=''
if IsNull(n_col3) then n_col3=''
if not(f_es_vacio(nombre_col)) then apellidos_col=apellidos_col+', ' +nombre_col
if not(f_es_vacio(nombre_cli)) then apellidos_cli=apellidos_cli+' ' +nombre_cli
if not(f_es_vacio(nombre_col2)) then apellidos_col2=apellidos_col2+', ' +nombre_col2
if not(f_es_vacio(nombre_col3)) then apellidos_col3=apellidos_col3+', ' +nombre_col3

// Separado en varias selects para evitar que con registros antiguos no salga ningun resultado
string cod_pob,trabajo,destino_int

//SCP-818. Jesus. Se a$$HEX1$$f100$$ENDHEX$$ade a la SELECT el tipo de tr$$HEX1$$e100$$ENDHEX$$mite.
select f.n_registro,f.descripcion,f.id_expedi,f.tipo_via_emplazamiento,f.emplazamiento,f.n_calle,f.piso,f.puerta,f.poblacion,f.trabajo,f.destino_int,f.id_tramite
into :n_registro,:desc_obra,:id_expedi,:tipo_via,:emplaz,:calle,:piso,:puerta,:cod_pob,:trabajo,:destino_int, :is_tipo_tramite
from fases f where id_fase=:i_id_fase;

select p.cod_pos,p.descripcion
into :cod_pos,:poblacion
from poblaciones p 
where cod_pob=:cod_pob;

select u.pem,u.sup_viv,u.sup_garage,u.sup_otros
into :pem,:sup_viv,:sup_garaje,:sup_otros
from fases_usos u
where id_fase=:i_id_fase;

select t.d_trabajo
into :desc_trabajo
from trabajos t
where  t.c_trabajo=:trabajo;

select d.descripcion
into :dest_int
from t_destinos d
where d.codigo=:destino_int;


if IsNull(pem) then pem=0
if IsNull(sup_viv) then sup_viv=0
if IsNull(sup_garaje) then sup_garaje=0
if IsNull(sup_otros) then sup_otros=0

//SCP-818. Jesus. Se tipifica tipo_tramite para las etiquetas:
//    * Si tipo de tr$$HEX1$$e100$$ENDHEX$$mite es IP - Etiqueta VISAT (V)
//    * Si tipo de tr$$HEX1$$e100$$ENDHEX$$mite es REDAP - Etiqueta REDAP (RP)
//    * Si tipo de tr$$HEX1$$e100$$ENDHEX$$mite es REDOC - Etiqueta REDOC
//    * Si tipo de tr$$HEX1$$e100$$ENDHEX$$mite es MUSAAT - Etiqueta REDOC
//    * Si tipo de tr$$HEX1$$e100$$ENDHEX$$mite es Visado Voluntario - Etiqueta (V)
//    * En el caso de tipo de tr$$HEX1$$e100$$ENDHEX$$mite est$$HEX2$$e1002000$$ENDHEX$$en blanco (Los visados antiguos al Decreto) - Que coja la etiqueta VISAT (V)

if f_es_vacio(is_tipo_tramite) then 
	is_tipo_tramite='V'
else
	if is_tipo_tramite='REDOC' or is_tipo_tramite='MUSAAT' then
		is_tipo_tramite='REDOC'
	else
		if is_tipo_tramite<>'REDAP' then 
			is_tipo_tramite='V'
		end if
	end if
end if

sup=sup_viv+sup_garaje+sup_otros
if g_colegio='COAATLL' and tipo_via<>'-' then
	emplaz=tipo_via+'/'+emplaz
end if
if not(f_es_vacio(calle)) then
	emplaz=emplaz+', '+string(calle)
end if
if not(f_es_vacio(piso)) then
	emplaz=emplaz+' pis '+string(piso)
end if
if not(f_es_vacio(puerta)) then
	emplaz=emplaz+' porta '+string(puerta)
end if

DECLARE variable CURSOR FOR  
SELECT distinct fase,n_registro
 FROM fases
WHERE id_expedi=:id_expedi and celda=:num_hoja
order by celda;

Open variable;
lst_etiquetas.codigos=""
lst_etiquetas.num_visados=""
fetch variable into :t_act,:nvis;
do while sqlca.sqlcode = 0
	if IsNull(t_act) then t_act=''
	if IsNull(nvis) then nvis=''
	if pos(lst_etiquetas.codigos,t_act) <= 0 then lst_etiquetas.codigos+=t_act+" / "
	
	lst_etiquetas.num_visados+=nvis+", "

	fetch variable into :t_act,:nvis;	
loop
close variable;
if len(lst_etiquetas.num_visados)>1 then lst_etiquetas.num_visados=left(lst_etiquetas.num_visados, len(lst_etiquetas.num_visados) -2)

if len(lst_etiquetas.codigos)>0 then lst_etiquetas.codigos=left(lst_etiquetas.codigos,len(lst_etiquetas.codigos)-2)

n_visado=dw_1.GetItemString(1,'n_visado')
texto_superficie='Sup.'+string(sup,'#,##0.00')+' m2'
texto_pem='Pem.'+string(pem,'#,##0.00')+'$$HEX1$$ac20$$ENDHEX$$'

if (g_colegio= 'COAATLL' and  string(i_tipo_act)='76'  ) then
   lst_etiquetas.colegiado=apellidos_col
   if not(f_es_vacio(apellidos_col2)) then lst_etiquetas.colegiado2=apellidos_col2
   if not(f_es_vacio(apellidos_col3)) then lst_etiquetas.colegiado3=apellidos_col3
else
   lst_etiquetas.colegiado=n_col+'-'+apellidos_col+'-'+porcen_col+"%"
   if not(f_es_vacio(apellidos_col2)) then lst_etiquetas.colegiado2=n_col2+'-'+apellidos_col2+'-'+porcen_col2+"%"
   if not(f_es_vacio(apellidos_col3)) then lst_etiquetas.colegiado3=n_col3+'-'+apellidos_col3+'-'+porcen_col3+"%"
end if

lst_etiquetas.n_visado=n_visado + '/'+ num_hoja
lst_etiquetas.promotor=apellidos_cli
lst_etiquetas.emplazamiento=emplaz
lst_etiquetas.poblacion=cod_pos +' - '+poblacion
lst_etiquetas.pem=texto_pem
lst_etiquetas.superficie=texto_superficie
lst_etiquetas.fecha = fecha_s
lst_etiquetas.descripcion=dw_1.GetItemString(1,'descripcion')
lst_etiquetas.contratista=dw_1.GetItemString(1,'contratista')
lst_etiquetas.n_registro=n_registro
//SCP-1508
lst_etiquetas.tipo_tramite = is_tipo_tramite
if f_es_vacio(lst_etiquetas.descripcion) then lst_etiquetas.descripcion=dest_int
//SCP-818. Jesus. Se a$$HEX1$$f100$$ENDHEX$$ade tipo de tr$$HEX1$$e100$$ENDHEX$$mite
//dw_impresion.SetItem(fila,'tipo_tramite',st_etiqueta.tipo_tramite)
//SCP-1073. Jesus. Se a$$HEX1$$f100$$ENDHEX$$ade tipo de tr$$HEX1$$e100$$ENDHEX$$mite s$$HEX1$$f300$$ENDHEX$$lo cuando sea necesario
if lower(dw_impresion.describe("tipo_tramite.name")) = 'tipo_tramite' then dw_impresion.SetItem(fila,'tipo_tramite',lst_etiquetas.tipo_tramite)

// Hoja de Encargo   TIPO=1
for i=1 to dw_1.GetItemNumber(1,'hoja_encargo')
	lst_etiquetas.tipo=1
	wf_rellenar_etiqueta(lst_etiquetas)
next

// Programa CQ		TIPO=2
for i=1 to dw_1.GetItemNumber(1,'cq')
	lst_etiquetas.tipo=2
	wf_rellenar_etiqueta(lst_etiquetas)
next

//Aprovaci$$HEX1$$f300$$ENDHEX$$n del Plan de Seguridad TIPO=3
for i=1 to dw_1.GetItemNumber(1,'aprov_ps')
	lst_etiquetas.tipo=3
	wf_rellenar_etiqueta(lst_etiquetas)
next

// Estudio de Seguridad y salud	TIPO=4
for i=1 to dw_1.GetItemNumber(1,'ess')
	lst_etiquetas.tipo=4
	wf_rellenar_etiqueta(lst_etiquetas)
next

// Libro de Registro	TIPO=5
for i=1 to dw_1.GetItemNumber(1,'aprov_pr')
	lst_etiquetas.tipo=5
	wf_rellenar_etiqueta(lst_etiquetas)
next

// Libro de Ordenes TIPO=6
for i=1 to dw_1.GetItemNumber(1,'libro_ord')
	lst_etiquetas.tipo=6
	if  (i = 1 and string(i_tipo_act)='76'  ) then 
		dw_impresion.dataobject='d_etiquetas_habitabilidad_ll'
	end if 
	wf_rellenar_etiqueta(lst_etiquetas)	
next

// Renuncia 			TIPO=7
for i=1 to dw_1.GetItemNumber(1,'renuncia')
	lst_etiquetas.tipo=7
	wf_rellenar_etiqueta(lst_etiquetas)
next

// Hoja_asume		TIPO=8
for i=1 to dw_1.GetItemNumber(1,'hoja_asume')
	lst_etiquetas.tipo=8
	wf_rellenar_etiqueta(lst_etiquetas)
next

// Complimente C.Q.	TIPO=9
for i=1 to dw_1.GetItemNumber(1,'ccq')
	lst_etiquetas.tipo=9
	wf_rellenar_etiqueta(lst_etiquetas)
next

// EBSS TIPO=10
for i=1 to dw_1.GetItemNumber(1,'ebss')
	lst_etiquetas.tipo=10
	wf_rellenar_etiqueta(lst_etiquetas)
next

// CSS TIPO=11
for i=1 to dw_1.GetItemNumber(1,'css')
	lst_etiquetas.tipo=11
	wf_rellenar_etiqueta(lst_etiquetas)
next

// Libro de Incidencias	TIPO=12
for i=1 to dw_1.GetItemNumber(1,'libro_inc')
	lst_etiquetas.tipo=12
	wf_rellenar_etiqueta(lst_etiquetas)
next

// Certificado Final de Obra	TIPO=13
for i=1 to dw_1.GetItemNumber(1,'cfo')
	lst_etiquetas.tipo=13
	wf_rellenar_etiqueta(lst_etiquetas)
next

// Certificado Final de Act.	TIPO=14
for i=1 to dw_1.GetItemNumber(1,'cfa')
	lst_etiquetas.tipo=14
	wf_rellenar_etiqueta(lst_etiquetas)
next

this.visible=false
cb_cerrar.visible=true
cb_imprimir.enabled=true
dw_impresion.visible=true
end event

type cb_actualizar from commandbutton within w_etiquetas_visado_tg
integer x = 1065
integer y = 1468
integer width = 402
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Actualizar"
end type

event clicked;long num=1


dw_1.AcceptText()
dw_historico.SetFilter("")
dw_historico.Filter()

num=dw_historico.Find("tipo_etiqueta='h_encargo'",1,dw_historico.rowcount())
if num>0 then 
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'hoja_encargo')+dw_1.GetItemNumber(1,'hoja_encargo_tot'))
	
else
	num=dw_historico.insertrow(0)
	dw_historico.SetItem(num,'id_expedi',i_id_expedi)
	dw_historico.SetItem(num,'id_etiqueta',f_siguiente_numero('ETIQUETAS_VISADO',10))
	dw_historico.SetItem(num,'hoja_encargo',dw_1.GetItemString(1,'num_hoja'))
	dw_historico.SetItem(num,'tipo_etiqueta','h_encargo')
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'hoja_encargo')+dw_1.GetItemNumber(1,'hoja_encargo_tot'))
end if

num=dw_historico.Find("tipo_etiqueta='cq'",1,dw_historico.rowcount())
if num>0 then 
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'cq')+dw_1.GetItemNumber(1,'cq_tot'))
else
	num=dw_historico.insertrow(0)
	dw_historico.SetItem(num,'id_expedi',i_id_expedi)
	dw_historico.SetItem(num,'id_etiqueta',f_siguiente_numero('ETIQUETAS_VISADO',10))
	dw_historico.SetItem(num,'hoja_encargo',dw_1.GetItemString(1,'num_hoja'))
	dw_historico.SetItem(num,'tipo_etiqueta','cq')
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'cq')+dw_1.GetItemNumber(1,'cq_tot'))
end if

num=dw_historico.Find("tipo_etiqueta='aprov_ps'",1,dw_historico.rowcount())
if num>0 then 
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'aprov_ps')+dw_1.GetItemNumber(1,'aprov_ps_tot'))
else
	num=dw_historico.insertrow(0)
	dw_historico.SetItem(num,'id_expedi',i_id_expedi)
	dw_historico.SetItem(num,'id_etiqueta',f_siguiente_numero('ETIQUETAS_VISADO',10))
	dw_historico.SetItem(num,'hoja_encargo',dw_1.GetItemString(1,'num_hoja'))
	dw_historico.SetItem(num,'tipo_etiqueta','aprov_ps')
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'aprov_ps')+dw_1.GetItemNumber(1,'aprov_ps_tot'))
end if	

num=dw_historico.Find("tipo_etiqueta='ess'",1,dw_historico.rowcount())
if num>0 then
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'ess')+dw_1.GetItemNumber(1,'ess_tot'))	
else
	num=dw_historico.insertrow(0)
	dw_historico.SetItem(num,'id_expedi',i_id_expedi)
	dw_historico.SetItem(num,'id_etiqueta',f_siguiente_numero('ETIQUETAS_VISADO',10))
	dw_historico.SetItem(num,'hoja_encargo',dw_1.GetItemString(1,'num_hoja'))
	dw_historico.SetItem(num,'tipo_etiqueta','ess')
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'ess')+dw_1.GetItemNumber(1,'ess_tot'))
end if	

num=dw_historico.Find("tipo_etiqueta='aprov_pr'",1,dw_historico.rowcount())
if num>0 then 
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'aprov_pr')+dw_1.GetItemNumber(1,'aprov_pr_tot'))		
else
	num=dw_historico.insertrow(0)
	dw_historico.SetItem(num,'id_expedi',i_id_expedi)
	dw_historico.SetItem(num,'id_etiqueta',f_siguiente_numero('ETIQUETAS_VISADO',10))
	dw_historico.SetItem(num,'hoja_encargo',dw_1.GetItemString(1,'num_hoja'))
	dw_historico.SetItem(num,'tipo_etiqueta','aprov_pr')
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'aprov_pr')+dw_1.GetItemNumber(1,'aprov_pr_tot'))
end if		

num=dw_historico.Find("tipo_etiqueta='libro_ord'",1,dw_historico.rowcount())
if num>0 then 
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'libro_ord')+dw_1.GetItemNumber(1,'libro_ord_tot'))	
else
	num=dw_historico.insertrow(0)
	dw_historico.SetItem(num,'id_expedi',i_id_expedi)
	dw_historico.SetItem(num,'id_etiqueta',f_siguiente_numero('ETIQUETAS_VISADO',10))
	dw_historico.SetItem(num,'hoja_encargo',dw_1.GetItemString(1,'num_hoja'))
	dw_historico.SetItem(num,'tipo_etiqueta','libro_ord')
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'libro_ord')+dw_1.GetItemNumber(1,'libro_ord_tot'))
end if	

num=dw_historico.Find("tipo_etiqueta='renuncia'",1,dw_historico.rowcount())
if num>0 then 
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'renuncia')+dw_1.GetItemNumber(1,'renuncia_tot'))	
else
	num=dw_historico.insertrow(0)
	dw_historico.SetItem(num,'id_expedi',i_id_expedi)
	dw_historico.SetItem(num,'id_etiqueta',f_siguiente_numero('ETIQUETAS_VISADO',10))
	dw_historico.SetItem(num,'hoja_encargo',dw_1.GetItemString(1,'num_hoja'))
	dw_historico.SetItem(num,'tipo_etiqueta','renuncia')
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'renuncia')+dw_1.GetItemNumber(1,'renuncia_tot'))
end if		

num=dw_historico.Find("tipo_etiqueta='hoja_asume'",1,dw_historico.rowcount())
if num>0 then 
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'hoja_asume')+dw_1.GetItemNumber(1,'hoja_asume_tot'))	
else
	num=dw_historico.insertrow(0)
	dw_historico.SetItem(num,'id_expedi',i_id_expedi)
	dw_historico.SetItem(num,'id_etiqueta',f_siguiente_numero('ETIQUETAS_VISADO',10))
	dw_historico.SetItem(num,'hoja_encargo',dw_1.GetItemString(1,'num_hoja'))
	dw_historico.SetItem(num,'tipo_etiqueta','hoja_asume')
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'hoja_asume')+dw_1.GetItemNumber(1,'hoja_asume_tot'))
end if	

num=dw_historico.Find("tipo_etiqueta='ccq'",1,dw_historico.rowcount())
if num>0 then 
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'ccq')+dw_1.GetItemNumber(1,'ccq_tot'))	
else
	num=dw_historico.insertrow(0)
	dw_historico.SetItem(num,'id_expedi',i_id_expedi)
	dw_historico.SetItem(num,'id_etiqueta',f_siguiente_numero('ETIQUETAS_VISADO',10))
	dw_historico.SetItem(num,'hoja_encargo',dw_1.GetItemString(1,'num_hoja'))
	dw_historico.SetItem(num,'tipo_etiqueta','ccq')
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'ccq')+dw_1.GetItemNumber(1,'ccq_tot'))
end if	

num=dw_historico.Find("tipo_etiqueta='ebss'",1,dw_historico.rowcount())
if num>0 then 
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'ebss')+dw_1.GetItemNumber(1,'ebss_tot'))	
else
	num=dw_historico.insertrow(0)
	dw_historico.SetItem(num,'id_expedi',i_id_expedi)
	dw_historico.SetItem(num,'id_etiqueta',f_siguiente_numero('ETIQUETAS_VISADO',10))
	dw_historico.SetItem(num,'hoja_encargo',dw_1.GetItemString(1,'num_hoja'))
	dw_historico.SetItem(num,'tipo_etiqueta','ebss')
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'ebss')+dw_1.GetItemNumber(1,'ebss_tot'))
end if	

num=dw_historico.Find("tipo_etiqueta='css'",1,dw_historico.rowcount())
if num>0 then 
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'css')+dw_1.GetItemNumber(1,'css_tot'))		
else
	num=dw_historico.insertrow(0)
	dw_historico.SetItem(num,'id_expedi',i_id_expedi)
	dw_historico.SetItem(num,'id_etiqueta',f_siguiente_numero('ETIQUETAS_VISADO',10))
	dw_historico.SetItem(num,'hoja_encargo',dw_1.GetItemString(1,'num_hoja'))
	dw_historico.SetItem(num,'tipo_etiqueta','css')
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'css')+dw_1.GetItemNumber(1,'css_tot'))
end if	

num=dw_historico.Find("tipo_etiqueta='libro_inc'",1,dw_historico.rowcount())
if num>0 then 
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'libro_inc')+dw_1.GetItemNumber(1,'libro_inc_tot'))			
else
	num=dw_historico.insertrow(0)
	dw_historico.SetItem(num,'id_expedi',i_id_expedi)
	dw_historico.SetItem(num,'id_etiqueta',f_siguiente_numero('ETIQUETAS_VISADO',10))
	dw_historico.SetItem(num,'hoja_encargo',dw_1.GetItemString(1,'num_hoja'))
	dw_historico.SetItem(num,'tipo_etiqueta','libro_inc')
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'libro_inc')+dw_1.GetItemNumber(1,'libro_inc_tot'))
end if	

num=dw_historico.Find("tipo_etiqueta='cfo'",1,dw_historico.rowcount())
if num>0 then 
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'cfo')+dw_1.GetItemNumber(1,'cfo_tot'))		
else
	num=dw_historico.insertrow(0)
	dw_historico.SetItem(num,'id_expedi',i_id_expedi)
	dw_historico.SetItem(num,'id_etiqueta',f_siguiente_numero('ETIQUETAS_VISADO',10))
	dw_historico.SetItem(num,'hoja_encargo',dw_1.GetItemString(1,'num_hoja'))
	dw_historico.SetItem(num,'tipo_etiqueta','cfo')
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'cfo')+dw_1.GetItemNumber(1,'cfo_tot'))
end if	

num=dw_historico.Find("tipo_etiqueta='cfa'",1,dw_historico.rowcount())
if num>0 then
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'cfa')+dw_1.GetItemNumber(1,'cfa_tot'))	
else
	num=dw_historico.insertrow(0)
	dw_historico.SetItem(num,'id_expedi',i_id_expedi)
	dw_historico.SetItem(num,'id_etiqueta',f_siguiente_numero('ETIQUETAS_VISADO',10))
	dw_historico.SetItem(num,'hoja_encargo',dw_1.GetItemString(1,'num_hoja'))
	dw_historico.SetItem(num,'tipo_etiqueta','cfa')
	dw_historico.SetItem(num,'num_etiquetas',dw_1.GetItemNumber(1,'cfa')+dw_1.GetItemNumber(1,'cfa_tot'))
end if		


if dw_historico.update()>0 then 
	parent.event csd_cargar_datos_historico()
	MessageBox("Ok!","Comptadors actualitzats correctament")
	this.enabled=false
end if


end event

type cb_salir from commandbutton within w_etiquetas_visado_tg
integer x = 1486
integer y = 1468
integer width = 402
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Salir"
end type

event clicked;close(parent)
end event

type dw_impresion from u_dw within w_etiquetas_visado_tg
boolean visible = false
integer x = 32
integer y = 4
integer width = 2107
integer height = 1392
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_etiquetas_visado_impresion_tg"
boolean ib_isupdateable = false
end type

type cb_imprimir from commandbutton within w_etiquetas_visado_tg
integer x = 645
integer y = 1468
integer width = 402
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Imprimir"
end type

event clicked;string impresora,impresora_old

impresora_old=PrintGetPrinter()

impresora=ProfileString(g_dir_aplicacion+"sica.ini","Parametros","ImpresoraTickets","")

if f_es_vacio(impresora) then 
	PrintSetup()
else
	PrintSetPrinter(impresora)
end if

dw_impresion.print()

// Restauramos la impresora
PrintSetPrinter(impresora_old)
end event

type cb_cerrar from commandbutton within w_etiquetas_visado_tg
boolean visible = false
integer x = 187
integer y = 1468
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cerrar Prev."
end type

event clicked;cb_imprimir.enabled=false
cb_previsualizar.visible=true
this.visible=false

dw_impresion.visible=false
end event

type dw_historico from u_dw within w_etiquetas_visado_tg
boolean visible = false
integer x = 1303
integer y = 988
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_etiquetas_visado_historico_tg"
end type

