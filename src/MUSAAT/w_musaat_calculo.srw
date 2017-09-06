HA$PBExportHeader$w_musaat_calculo.srw
forward
global type w_musaat_calculo from w_popup
end type
type cb_3 from commandbutton within w_musaat_calculo
end type
type cb_calcular from commandbutton within w_musaat_calculo
end type
type cb_1 from commandbutton within w_musaat_calculo
end type
type dw_2 from datawindow within w_musaat_calculo
end type
type dw_1 from datawindow within w_musaat_calculo
end type
type dw_imprimir_ficha from u_dw within w_musaat_calculo
end type
end forward

global type w_musaat_calculo from w_popup
integer x = 214
integer y = 221
integer width = 2939
integer height = 2012
string title = "C$$HEX1$$e100$$ENDHEX$$lculo de MUSAAT"
cb_3 cb_3
cb_calcular cb_calcular
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
dw_imprimir_ficha dw_imprimir_ficha
end type
global w_musaat_calculo w_musaat_calculo

type variables
string i_accion = 'CONSULTA'
w_fases_detalle i_w
end variables

forward prototypes
public function integer f_validaciones_previas ()
end prototypes

public function integer f_validaciones_previas ();string tipo_act, tipo_obra, tabla, n_col
double superficie, pem, volumen

n_col = dw_1.getitemstring(1, 'colegiado')
tipo_act = dw_2.getitemstring(1, 'tipo_actuacion')
tipo_obra = dw_2.getitemstring(1, 'tipo_obra')
superficie = dw_2.getitemnumber(1, 'superficie')
pem = dw_2.getitemnumber(1, 'pem')
volumen = dw_2.getitemnumber(1, 'volumen')

if f_es_vacio(tipo_act) then
	messagebox(g_titulo, g_idioma.of_getmsg('msg_musaat.introducir_tipo_actuacion','Debe introducir un Tipo de Actuaci$$HEX1$$f300$$ENDHEX$$n'))
	return -1
end if
if f_es_vacio(tipo_obra) then
	messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.introducir_tipo_obra', 'Debe introducir un Tipo de Obra'))
	return -1
end if
if f_es_vacio(n_col) then
	messagebox(g_titulo, g_idioma.of_getmsg('msg_musaat.introducir_colegiado','Debe introducir un Colegiado'))
	return -1
end if
if isnull(superficie) then
	messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.introducir_superficie', 'Debe introducir la Superficie'))
	return -1	
end if

// Entramos en la tabla C
SELECT tabla
INTO :tabla
FROM musaat_coef_c
WHERE (tipoact = :tipo_act OR tipoact = '*' ) AND (tipoobra = :tipo_obra OR tipoobra = '*') AND (desde_sup <= :superficie) AND (hasta_sup >=:superficie) ;

choose case tabla
	case 'A', 'B', 'C'
		if isnull(pem) or pem = 0 then
			messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.introducir_presupuesto_ejecucion_material', 'Debe introducir el Presupuesto de Ejecuci$$HEX1$$f300$$ENDHEX$$n Material'))
			return -1		
		end if	
	case 'E'
		if isnull(volumen) or volumen = 0 then
			messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.introducir_volumen',  'Debe introducir el Volumen'))
			return -1					
		end if
end choose
return 0
end function

on w_musaat_calculo.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_calcular=create cb_calcular
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.dw_imprimir_ficha=create dw_imprimir_ficha
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_calcular
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.dw_imprimir_ficha
end on

on w_musaat_calculo.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_calcular)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.dw_imprimir_ficha)
end on

event open;call super::open;string entrada
string n_reg
i_accion= message.stringparm
if f_es_vacio(i_accion) then i_accion = 'CONSULTA'
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_1.insertrow(0)
dw_2.insertrow(0)



end event

type cb_3 from commandbutton within w_musaat_calculo
string tag = "texto=general.cerrar"
integer x = 2427
integer y = 1800
integer width = 402
integer height = 96
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
end type

event clicked;close(parent)
end event

type cb_calcular from commandbutton within w_musaat_calculo
string tag = "texto=general.calcular"
integer x = 128
integer y = 1796
integer width = 402
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Calcular"
end type

event clicked;string n_visado
int retorno
dw_1.accepttext()
dw_2.accepttext()
if f_validaciones_previas() <> 0 then return
//if not f_es_vacio(dw_1.getitemstring(1, 'contrato') then
//end if
st_musaat_datos st_musaat_datos
//st_musaat_datos.n_visado = dw_1.getitemstring(1, 'contrato')
st_musaat_datos.id_col = dw_1.getitemstring(1, 'id_col')
st_musaat_datos.tipo_act = dw_2.getitemstring(1, 'tipo_actuacion')
st_musaat_datos.tipo_obra = dw_2.getitemstring(1, 'tipo_obra')
st_musaat_datos.pem = dw_2.getitemnumber(1, 'pem')
st_musaat_datos.superficie = dw_2.getitemnumber(1, 'superficie')
st_musaat_datos.volumen = dw_2.getitemnumber(1, 'volumen')
st_musaat_datos.porcentaje = dw_2.getitemnumber(1, 'porcentaje')
st_musaat_datos.cobertura = dw_2.getitemnumber(1, 'cobertura') 
st_musaat_datos.coef_cm = dw_2.getitemnumber(1, 'coef_cm')
//Luis CZA-149
i_w = g_detalle_fases
st_musaat_datos.colindantes2m = dw_2.getitemstring(1, 'colindantes2m')

//Cambio Jesus SCP-776
//st_musaat_datos.coef_recargo = dw_2.getitemnumber(1, 'src_recargo')

///*** SCP-778. Alexis. 21/12/2010. Cambio para la aceptaci$$HEX1$$f300$$ENDHEX$$n del codigo de colegio de destino
st_musaat_datos.cod_colegio = dw_2.getitemstring(1, 'colegio_dest' )


f_musaat_calcula_prima(st_musaat_datos)

dw_2.setitem(1, 'presupuesto_calculo', st_musaat_datos.pem)
dw_2.setitem(1, 'tabla', st_musaat_datos.tabla)
dw_2.setitem(1, 'cobertura', st_musaat_datos.cobertura)
dw_2.setitem(1, 'importe_musaat', st_musaat_datos.prima_comp)
dw_2.setitem(1, 'coef_k', st_musaat_datos.coef_k)
dw_2.setitem(1, 'coef_c', st_musaat_datos.coef_c)
dw_2.setitem(1, 'coef_g', st_musaat_datos.coef_g)
dw_2.setitem(1, 'coef_cm', st_musaat_datos.coef_cm)
dw_2.setitem(1, 'coef_colegio', st_musaat_datos.coef_colegio)
dw_2.setitem(1, 'formula', st_musaat_datos.formula)
dw_2.setitem(1, 'colindantes2m', st_musaat_datos.colindantes2m)
dw_2.setitem(1, 'src_recargo', st_musaat_datos.coef_recargo)
end event

type cb_1 from commandbutton within w_musaat_calculo
string tag = "texto=general.imprimir"
integer x = 663
integer y = 1796
integer width = 402
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
end type

event clicked;dw_imprimir_ficha.reset()
dw_imprimir_ficha.insertrow(0)

string id_col, tipo_act, tipo_obra, destino_obra
id_col = dw_1.getitemstring(1,'id_col')
tipo_act = dw_2.getitemstring(1,'tipo_actuacion')
tipo_obra = dw_2.getitemstring(1,'tipo_obra')
destino_obra = dw_2.getitemstring(1,'destino_obra')
dw_imprimir_ficha.setitem(1,'colegiado',f_colegiado_n_col(id_col) + ' - ' + f_colegiado_nombre_apellido(id_col))
dw_imprimir_ficha.setitem(1,'contrato',dw_1.getitemstring(1,'contrato'))
dw_imprimir_ficha.setitem(1,'cm',dw_2.getitemnumber(1,'coef_cm'))
dw_imprimir_ficha.setitem(1,'cobertura',dw_2.getitemnumber(1,'cobertura'))
dw_imprimir_ficha.setitem(1,'tipoact',tipo_act + ' - ' + f_dame_desc_tipo_actuacion(tipo_act))
dw_imprimir_ficha.setitem(1,'tipoobra',tipo_obra  + ' - ' + f_dame_desc_tipo_obra(tipo_obra) )
dw_imprimir_ficha.setitem(1,'destino',destino_obra  + ' - ' + f_dame_desc_destino_obra(destino_obra) )
dw_imprimir_ficha.setitem(1,'pres_calculo',dw_2.getitemnumber(1,'presupuesto_calculo'))
dw_imprimir_ficha.setitem(1,'presupuesto', dw_2.getitemnumber(1,'pem'))
dw_imprimir_ficha.setitem(1,'participacion',dw_2.getitemnumber(1,'porcentaje'))
dw_imprimir_ficha.setitem(1,'volumen',dw_2.getitemnumber(1,'volumen'))
dw_imprimir_ficha.setitem(1,'superficie',dw_2.getitemnumber(1,'superficie'))
dw_imprimir_ficha.setitem(1,'k',dw_2.getitemnumber(1,'coef_k'))
dw_imprimir_ficha.setitem(1,'g',dw_2.getitemnumber(1,'coef_g'))
dw_imprimir_ficha.setitem(1,'c',dw_2.getitemnumber(1,'coef_c'))
dw_imprimir_ficha.setitem(1,'col',dw_2.getitemnumber(1,'coef_colegio'))
dw_imprimir_ficha.setitem(1,'tarifa',dw_2.getitemstring(1,'tabla'))
dw_imprimir_ficha.setitem(1,'importe',dw_2.getitemnumber(1,'importe_musaat'))
dw_imprimir_ficha.setitem(1,'formula',dw_2.getitemstring(1,'formula'))
dw_imprimir_ficha.print()
//dw_imprimir_ficha.visible = true
end event

type dw_2 from datawindow within w_musaat_calculo
integer x = 87
integer y = 288
integer width = 2779
integer height = 1488
integer taborder = 20
string title = "none"
string dataobject = "d_musaat_calculo_datos"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//Andr$$HEX1$$e900$$ENDHEX$$s: Hacemos que se calcule el total siempre que el usuario cambie la cobertura

if dwo.name='cobertura' then
	cb_calcular.event post  clicked()
end if

end event

type dw_1 from datawindow within w_musaat_calculo
event csd_coloca_datos_seguro ( )
integer x = 119
integer y = 68
integer width = 2697
integer height = 188
integer taborder = 10
string title = "none"
string dataobject = "d_musaat_calculo_busqueda"
boolean livescroll = true
end type

event csd_coloca_datos_seguro();string id_col
id_col = this.getitemstring(1, 'id_col')

dw_2.post setitem(1, 'cobertura', f_musaat_dame_cobertura_src(id_col))
dw_2.post setitem(1, 'coef_cm', f_musaat_dame_coef_cm(id_col)) 	
end event

event itemchanged;string n_reg, id_col
choose case dwo.name
	case 'contrato'
//		// Rellenar los datos del contrato
//		
//		double pem, presupuesto, altura,volumen, superficie, cobertura, coef_cm
//		string colindantes, administracion, tipo_act, tipo_obra, destino
//		n_reg = data
//		id_col = this.getitemstring(1, 'id_col')
//		  SELECT fases_usos.pem,   
//         fases_usos.presupuesto,   
//         fases_usos.altura,   
//         fases_usos.volumen,   
//         fases_usos.colindantes,  
//			fases_usos.superficie,
//         expedientes.administracion,   
//         fases.fase,   
//         fases.tipo_trabajo,   
//         fases.trabajo  
//    INTO :pem,   
//         :presupuesto,   
//         :altura,   
//         :volumen,   
//         :colindantes,   
//			:superficie,
//         :administracion,   
//         :tipo_act,   
//         :tipo_obra,   
//         :destino  
//    FROM fases,   
//         expedientes,   
//         fases_usos  
//   WHERE ( fases.id_expedi = expedientes.id_expedi ) and  
//         ( fases.id_fase = fases_usos.id_fase )  and
//			( fases.n_registro = :n_reg )	;
//
//	dw_2.setitem(1, 'tipo_actuacion', tipo_act)
//	dw_2.setitem(1, 'tipo_obra', tipo_obra)
//	dw_2.setitem(1, 'destino_obra', destino)
//	dw_2.setitem(1, 'pem', pem)		
//	dw_2.setitem(1, 'porcentaje', 100)	
//	dw_2.setitem(1, 'superficie', superficie)
//	dw_2.setitem(1, 'volumen', volumen)	
	
	case 'colegiado'
		id_col = f_colegiado_id_col(data)
		this.setitem(1,'id_col',id_col)
		this.post event csd_coloca_datos_seguro()	
end choose
end event

event itemfocuschanged;choose case this.getcolumnname()
	case 'contrato'
//		messagebox(g_titulo, 'Falta enganche con expedientes')
end choose
end event

event buttonclicked;string id_colegiado, n_col
choose case dwo.name
	case 'b_colegiado'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		
		id_colegiado=f_busqueda_colegiados()
		n_col = f_colegiado_n_col(id_colegiado)
		
		if not f_es_vacio(id_colegiado) then this.setitem(row,'id_col',id_colegiado)
		if not f_es_vacio(n_col) then this.setitem(row,'colegiado',n_col)
end choose
end event

type dw_imprimir_ficha from u_dw within w_musaat_calculo
boolean visible = false
integer y = 4
integer width = 2889
integer height = 1672
integer taborder = 0
string dataobject = "d_musaat_impreso_calculo"
boolean hscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event doubleclicked;call super::doubleclicked;this.visible = false
end event

