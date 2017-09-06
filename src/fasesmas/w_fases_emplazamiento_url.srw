HA$PBExportHeader$w_fases_emplazamiento_url.srw
forward
global type w_fases_emplazamiento_url from w_response
end type
type cb_aceptar from u_cb within w_fases_emplazamiento_url
end type
type cb_cancelar from u_cb within w_fases_emplazamiento_url
end type
type dw_1 from u_dw within w_fases_emplazamiento_url
end type
end forward

global type w_fases_emplazamiento_url from w_response
integer width = 2533
integer height = 892
string title = "Localizaci$$HEX1$$f300$$ENDHEX$$n del emplazamiento en Google Maps"
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
dw_1 dw_1
end type
global w_fases_emplazamiento_url w_fases_emplazamiento_url

on w_fases_emplazamiento_url.create
int iCurrent
call super::create
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_aceptar
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.dw_1
end on

on w_fases_emplazamiento_url.destroy
call super::destroy
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
destroy(this.dw_1)
end on

event open;call super::open;string id_fase
long res
string tipos_via,emplaz,calle,pob,prov,direccion_completa
n_cst_string lnv_string


f_centrar_ventana(this)

id_fase=Message.StringParm


dw_1.SetTransObject(SQLCA)
res=dw_1.retrieve(id_fase)


select t.descripcion,f.emplazamiento,f.n_calle,pob.descripcion,pro.nombre
into :tipos_via,:emplaz,:calle,:pob,:prov
from fases f,poblaciones pob,provincias pro,tipos_via t
where id_fase=:id_fase and t.cod_tipo_via=f.tipo_via_emplazamiento and 
f.poblacion=pob.cod_pob and pob.provincia=pro.cod_provincia;


emplaz=trim(emplaz)
emplaz=lnv_string.of_globalreplace(emplaz, " ", "+" )

if not(isNull(tipos_via)) then direccion_completa+=tipos_via+"+"
if not(IsNull(emplaz)) then direccion_completa+=emplaz
if not(IsNull(calle)) then  direccion_completa+=","+calle
if Not(isNull(pob)) then direccion_completa+=","+pob
if Not(isNull(prov)) then direccion_completa+=","+prov	


if res<=0 then	
	MessageBox("$$HEX1$$a100$$ENDHEX$$Atencion!", "No se introdujo ninguna URL para la obra. Se construir$$HEX2$$e1002000$$ENDHEX$$con el emplazamiento actual")
	res=dw_1.insertrow(0)
	dw_1.SetItem(res,'id_fase',id_fase)
	dw_1.SetItem(res,'emplazamiento_url',"http://maps.google.com/maps?f=q&hl=es&geocode=&q="+direccion_completa+",Espa$$HEX1$$f100$$ENDHEX$$a&z=15")
else
	if f_es_vacio(dw_1.GetItemString(res,'emplazamiento_url')) then
		MessageBox("$$HEX1$$a100$$ENDHEX$$Atencion!", "No se introdujo ninguna URL para la obra. Se construir$$HEX2$$e1002000$$ENDHEX$$con el emplazamiento actual")
		dw_1.SetItem(res,'emplazamiento_url',"http://maps.google.com/maps?f=q&hl=es&geocode=&q="+direccion_completa+",Espa$$HEX1$$f100$$ENDHEX$$a&z=15")
	end if
end if


//http://maps.google.com/maps?f=q&hl=es&geocode=&q=calle+alvaro+de+bazan,10,valencia,espa%C3%B1a&z=15

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_emplazamiento_url
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_emplazamiento_url
end type

type cb_aceptar from u_cb within w_fases_emplazamiento_url
integer x = 841
integer y = 656
integer taborder = 11
boolean bringtotop = true
string text = "Aceptar"
end type

event clicked;call super::clicked;dw_1.update()

Close(parent)
end event

type cb_cancelar from u_cb within w_fases_emplazamiento_url
integer x = 1307
integer y = 656
integer taborder = 21
boolean bringtotop = true
string text = "Cancelar"
end type

event clicked;call super::clicked;Close(parent)
end event

type dw_1 from u_dw within w_fases_emplazamiento_url
integer x = 50
integer y = 28
integer width = 2377
integer height = 576
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_fases_emplazamiento_url"
boolean vscrollbar = false
boolean border = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;string url

url=dw_1.GetItemString(dw_1.GetRow(),'emplazamiento_url')
Run('C:\Archivos de programa\Internet Explorer\iexplore.exe "'+url+'"',maximized!)
end event

