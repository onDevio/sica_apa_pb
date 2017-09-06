HA$PBExportHeader$w_calculo_honorarios_le.srw
$PBExportComments$Heredada de la ventana de Cuenca
forward
global type w_calculo_honorarios_le from w_response
end type
type cb_3 from commandbutton within w_calculo_honorarios_le
end type
type cb_2 from commandbutton within w_calculo_honorarios_le
end type
type cb_1 from commandbutton within w_calculo_honorarios_le
end type
type dw_1 from u_dw within w_calculo_honorarios_le
end type
type dw_2 from u_dw within w_calculo_honorarios_le
end type
type cb_4 from commandbutton within w_calculo_honorarios_le
end type
end forward

global type w_calculo_honorarios_le from w_response
integer width = 2839
integer height = 1952
string title = "C$$HEX1$$e100$$ENDHEX$$lculo de Honorarios"
event csd_cargar_datos ( )
event csd_recalcular ( )
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
dw_2 dw_2
cb_4 cb_4
end type
global w_calculo_honorarios_le w_calculo_honorarios_le

type variables
datastore i_ds_hon
string i_id_fase
st_calculo_honorarios i_st_hon
end variables

event csd_cargar_datos();// Evento que recupera los datos del calculo de honorarios
string tarifa, param[5], campo, contenido, formula, desarrollo
int i
double importe, p1, p2, p3, p4, p5

datastore ds_datos
ds_datos = create Datastore
ds_datos.DataObject = 'd_fases_honorarios_le'
ds_datos.SetTransObject(SQLCA)

// Si no tenemos id_fase, no estamos en contratos y no hay que recuperar de la bd
// Insertamos los datos que se le han pasado a la ventana en la estructura
if f_es_vacio(i_id_fase) then
	ds_datos.insertrow(0)

	ds_datos.setitem(1, 'tarifa', i_st_hon.tarifa)
	ds_datos.setitem(1, 'epigrafe', i_st_hon.contenido)
	ds_datos.setitem(1, 'formula_ho', i_st_hon.formula)
	ds_datos.setitem(1, 'desarrollo_ho', i_st_hon.desarrollo)
	ds_datos.setitem(1, 'importe_ho', i_st_hon.importe)
	ds_datos.setitem(1, 'p1', i_st_hon.p1)
	ds_datos.setitem(1, 'p2', i_st_hon.p2)
	ds_datos.setitem(1, 'p3', i_st_hon.p3)
	ds_datos.setitem(1, 'p4', i_st_hon.p4)
	ds_datos.setitem(1, 'p5', i_st_hon.p5)
	ds_datos.setitem(1, 'pem_min', i_st_hon.pem_min)	
else
	ds_datos.retrieve(i_id_fase)

	if ds_datos.rowcount()=0 then return
end if

tarifa = ds_datos.getitemstring(1, 'tarifa')	

if f_es_vacio(tarifa) then return

// Rellenamos el dw con los datos que no son los par$$HEX1$$e100$$ENDHEX$$metros
dw_1.setitem(1, 'tarifa', tarifa)
dw_1.trigger event itemchanged(1, dw_1.object.tarifa, tarifa)
dw_1.setitem(1, 'contenido', ds_datos.getitemstring(1, 'epigrafe'))
dw_1.setitem(1, 'formula', ds_datos.getitemstring(1, 'formula_ho'))
dw_1.setitem(1, 'desarrollo', ds_datos.getitemstring(1, 'desarrollo_ho'))
dw_1.setitem(1, 'importe', ds_datos.getitemnumber(1, 'importe_ho'))
dw_1.setitem(1, 'pem_min', ds_datos.getitemnumber(1, 'pem_min'))

// Obtenemos los par$$HEX1$$e100$$ENDHEX$$metros utilizados para el c$$HEX1$$e100$$ENDHEX$$lculo de esa tarifa
SELECT ho_tarifas.param1, ho_tarifas.param2, ho_tarifas.param3, ho_tarifas.param4, ho_tarifas.param5  
INTO :param[1], :param[2], :param[3], :param[4], :param[5]  
FROM ho_tarifas  
WHERE ho_tarifas.cod_tarifa = :tarifa   ;

// Rellenamos los campos correspondientes obteniendo el valor de los paramX
for i=1 to 5
	campo = 'p' + string(i)

	// Con el string vac$$HEX1$$ed00$$ENDHEX$$o el setitem da error, con null no
	if param[i]='' then continue
	
	// Para los campos de tipo string hacemos la conversi$$HEX1$$f300$$ENDHEX$$n (1=S; 0=N)
	if LeftA(dw_1.Describe(param[i]+".ColType"),4) = 'char' then
		if ds_datos.getitemnumber(1, campo) = 1 then
			dw_1.setitem(1, param[i], 'S')
		else
			dw_1.setitem(1, param[i], 'N')
		end if
	else
		dw_1.setitem(1, param[i], ds_datos.getitemnumber(1, campo))
	end if
next

destroy ds_datos

end event

event csd_recalcular();// Cogemos los datos que se hayan pasado
dw_1.setitem(1, 'presupuesto', i_st_hon.presupuesto)
dw_1.setitem(1, 'superficie', i_st_hon.superficie)
dw_1.setitem(1, 'altura', i_st_hon.altura)
dw_1.setitem(1, 'volumen', i_st_hon.volumen)
dw_1.setitem(1, 'tipologia', i_st_hon.medianeras)

cb_1.triggerevent(clicked!) // Calculamos
cb_2.triggerevent(clicked!) // Cerramos

end event

on w_calculo_honorarios_le.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.cb_4
end on

on w_calculo_honorarios_le.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_4)
end on

event open;call super::open;// Recogemos la estructura
i_st_hon = message.powerobjectparm

i_id_fase = i_st_hon.id_fase

f_centrar_ventana(this)

dw_1.insertrow(0)

event csd_cargar_datos()

//// Hasta que no seleccione tarifa no hay contenidos
string tarifa
tarifa = dw_1.getitemstring(1, 'tarifa')
if isnull(tarifa) then tarifa = ''
DataWindowChild dwc_cont
dw_1.GetChild('contenido', dwc_cont)
dwc_cont.setfilter("cod_tarifa = '" + tarifa + "'")		
dwc_cont.filter()

if i_st_hon.modo_oculto = 'S' then
	this.hide()
	postevent("csd_recalcular")
end if

dw_2.insertrow(0)

dw_1.event itemchanged(1, dw_1.object.contenido, dw_1.getitemstring(1, 'contenido'))

// Obtenemos los par$$HEX1$$e100$$ENDHEX$$metros utilizados para el c$$HEX1$$e100$$ENDHEX$$lculo del pem m$$HEX1$$ed00$$ENDHEX$$nimo
CHOOSE CASE dw_1.getitemstring(1, 'tarifa')
	CASE 'A.1.6'
		if i_st_hon.coef_a = 1 then
			dw_2.setitem(1, 'superficie', i_st_hon.coef_b)
			dw_2.setitem(1, 'tipo_terr', i_st_hon.coef_c)
		else
			dw_2.setitem(1, 'uso', i_st_hon.coef_a)
		end if
END CHOOSE

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_calculo_honorarios_le
integer x = 2770
integer y = 1184
integer width = 82
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_calculo_honorarios_le
integer x = 2770
integer y = 1088
integer width = 155
end type

type cb_3 from commandbutton within w_calculo_honorarios_le
integer x = 1481
integer y = 1708
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Ca&ncelar"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_2 from commandbutton within w_calculo_honorarios_le
integer x = 809
integer y = 1708
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
end type

event clicked;dw_1.accepttext()

cb_1.triggerevent(clicked!)

i_ds_hon = create Datastore
i_ds_hon.DataObject = 'd_calculo_honorarios_le'
i_ds_hon.SetTransObject(SQLCA)

dw_1.rowscopy(1, 1, Primary!, i_ds_hon, 1, Primary!)

closewithreturn(parent, i_ds_hon)

end event

type cb_1 from commandbutton within w_calculo_honorarios_le
integer x = 485
integer y = 1120
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Calcular &Hon."
end type

event clicked;dw_1.accepttext()
st_honteor_datos st_hon

// Rellenamos la estructura
st_hon.tarifa 			= dw_1.getitemstring(1, 'tarifa')
st_hon.contenido 		= dw_1.getitemstring(1, 'contenido')
st_hon.nueva_planta 	= dw_1.getitemstring(1, 'nueva_planta')
st_hon.presupuesto 	= dw_1.getitemnumber(1, 'presupuesto')
st_hon.superficie 	= dw_1.getitemnumber(1, 'superficie')
st_hon.volumen 		= dw_1.getitemnumber(1, 'volumen')
st_hon.altura 			= dw_1.getitemnumber(1, 'altura')
st_hon.tipologia 		= dw_1.getitemnumber(1, 'tipologia')
st_hon.tipo_edificio = dw_1.getitemnumber(1, 'tipo_edificio')
st_hon.edad 			= dw_1.getitemnumber(1, 'edad')
st_hon.perimetro 		= dw_1.getitemnumber(1, 'perimetro')
st_hon.tipo_terreno	= dw_1.getitemnumber(1, 'tipo_terreno')
st_hon.perim_sup 		= dw_1.getitemnumber(1, 'perim_sup')
st_hon.plantas_dif	= dw_1.getitemnumber(1, 'plantas_dif')
st_hon.plantas_ide	= dw_1.getitemnumber(1, 'plantas_ide')
st_hon.alz_sec_det	= dw_1.getitemnumber(1, 'alz_sec_det')
st_hon.parcelas		= dw_1.getitemnumber(1, 'parcelas')
st_hon.cantidad		= dw_1.getitemnumber(1, 'cantidad')
st_hon.valor_tasacion= dw_1.getitemnumber(1, 'valor_tasacion')
st_hon.desc_prec		= dw_1.getitemstring(1, 'desc_prec')
st_hon.num_ofertas 	= dw_1.getitemnumber(1, 'num_ofertas')
st_hon.num_partidas	= dw_1.getitemnumber(1, 'num_partidas')
st_hon.horas 			= dw_1.getitemnumber(1, 'horas')
st_hon.horas_extra	= dw_1.getitemnumber(1, 'horas_extra')
st_hon.distancia		= dw_1.getitemnumber(1, 'distancia')
st_hon.jornadas		= dw_1.getitemnumber(1, 'jornadas')
st_hon.noches 			= dw_1.getitemnumber(1, 'noches')
st_hon.radio 			= dw_1.getitemnumber(1, 'radio')
st_hon.estructura		= dw_1.getitemnumber(1, 'estructura')
st_hon.tipo_inst		= dw_1.getitemnumber(1, 'tipo_inst')
st_hon.num_viviendas	= dw_1.getitemnumber(1, 'num_viviendas')
st_hon.num_plantas	= dw_1.getitemnumber(1, 'num_plantas')
//st_hon.planos			= dw_1.getitemnumber(1, 'planos')
//st_hon.tasac_valor	= dw_1.getitemstring(1, 'tasac_valor')
//st_hon.parcial			= dw_1.getitemstring(1, 'parcial')
//st_hon.seguimiento	= dw_1.getitemstring(1, 'seguimiento')
//st_hon.pres_calidad	= dw_1.getitemnumber(1, 'pres_calidad')
//st_hon.admon			= dw_1.getitemstring(1, 'admon')
//st_hon.fecha			= i_st_hon.fecha

// Calculamos los honorarios
f_calcular_honteor_le(st_hon)

// Visualizamos los resultados
if not f_es_vacio(st_hon.formula) then dw_1.setitem(1, 'formula', st_hon.formula)
dw_1.setitem(1, 'desarrollo', st_hon.desarrollo)
dw_1.setitem(1, 'importe', st_hon.importe)

end event

type dw_1 from u_dw within w_calculo_honorarios_le
event csd_ocultar_campos ( )
integer x = 37
integer y = 32
integer width = 2747
integer height = 1596
integer taborder = 10
string dataobject = "d_calculo_honorarios_le"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_ocultar_campos();// Evento que oculta los campos y etiquetas del dw de calculo de pem
int i
string campo

for i=1 to integer(dw_2.Object.DataWindow.Column.Count)
	campo = dw_2.Describe("#" + string(i) + ".Name")
	dw_2.Modify("#" + string(i) + ".Visible = 0")
	dw_2.Modify(campo + "_t" + ".Visible = 0")
next

cb_4.visible = false // Bot$$HEX1$$f300$$ENDHEX$$n Calcular PEM
dw_2.object.b_usos.visible = false // Bot$$HEX1$$f300$$ENDHEX$$n U

end event

event itemchanged;call super::itemchanged;string contenido, tarifa, formula

contenido = dw_1.getitemstring(1, 'contenido')
tarifa = dw_1.getitemstring(1, 'tarifa')

CHOOSE CASE dwo.name
	CASE 'tarifa'
		// Obtenemos la formula y la mostramos
		SELECT ho_tarifas.formula  
		INTO :formula  
		FROM ho_tarifas  
		WHERE ho_tarifas.cod_tarifa = :data   ;

		this.setitem(1, 'formula', formula)

		// Inicializamos valores de los parametros
		f_inicializar_valores_st_honteor_dat_le (parent)
		
		// Filtramos los contenidos
		DataWindowChild dwc_cont
		this.GetChild('contenido', dwc_cont)
		dwc_cont.setfilter("cod_tarifa = '" + data + "'")		
		dwc_cont.filter()

		// Si no hay contenidos para la tarifa lo ocultamos 
		if dwc_cont.rowcount() = 0 then 
			this.object.contenido.visible = 0
			this.object.contenido_t.visible = 0
		else
			if dwc_cont.rowcount() = 1 then this.setitem(1, 'contenido', dwc_cont.getitemstring(1, 'cod_contenido'))
			this.object.contenido.visible = 1
			this.object.contenido_t.visible = 1
		end if
		
		// Mostramos los parametros correspondientes
		post f_parametriza_ventana_calculo_honos_le(parent)
		
		
		// PEM Minimo
		event csd_ocultar_campos()
		
		// Cogemos el pem y el presupuesto que se le haya pasado
		this.setitem(1, 'presupuesto', i_st_hon.presupuesto)
		this.setitem(1, 'superficie', i_st_hon.superficie)
		this.setitem(1, 'altura', i_st_hon.altura)
		this.setitem(1, 'volumen', i_st_hon.volumen)
		this.setitem(1, 'tipologia', i_st_hon.medianeras)
		dw_2.setitem(1, 'superficie', i_st_hon.superficie)
		
		if data = 'A.1.6' then
			cb_4.visible = true
			dw_2.object.uso.visible = true
			dw_2.object.uso_t.visible = true
			dw_2.object.b_usos.visible = true
			dw_2.object.nave.visible = true
			dw_2.object.nave_t.visible = true
		end if

	CASE 'contenido'
		event csd_ocultar_campos()
		
		if tarifa = 'A.1.6' then
			cb_4.visible = true
			dw_2.object.uso.visible = true
			dw_2.object.uso_t.visible = true
			dw_2.object.b_usos.visible = true
			dw_2.object.nave.visible = true
			dw_2.object.nave_t.visible = true
		end if

	CASE 'nueva_planta'
		formula = this.getitemstring(1, 'formula')
		if data = 'S' then
			formula = LeftA(formula, LenA(formula) - 7)
			this.setitem(1, 'formula', formula)
		else
			this.setitem(1, 'formula', formula + ' x 1,20')
		end if		
		
END CHOOSE

end event

event doubleclicked;// Sobreescrito
end event

event clicked;call super::clicked;string tarifa

CHOOSE CASE dwo.name
	CASE 'contenido'
		tarifa = this.getitemstring(1, 'tarifa')
		if isnull(tarifa) then tarifa = ''
		DataWindowChild dwc_cont
		this.GetChild('contenido', dwc_cont)
		dwc_cont.setfilter("cod_tarifa = '" + tarifa + "'")		
		dwc_cont.filter()
		
END CHOOSE

end event

type dw_2 from u_dw within w_calculo_honorarios_le
integer x = 37
integer y = 252
integer width = 2747
integer height = 212
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_calculo_pem_min_le"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;double res

choose case dwo.name
	case 'b_usos'
		openwithparm(w_pem_minimo_aux, 'U')
		res = message.doubleparm
		dw_2.setitem(1, 'uso', res)
end choose

end event

event itemchanged;call super::itemchanged;if dwo.name = 'nave' then
	if double(data) = 1 then
		this.object.tipo_terr_t.visible = true
		this.object.tipo_terr.visible = true
		this.object.superficie.visible = true
		this.object.superficie_t.visible = true
		this.object.uso.visible = false
		this.object.b_usos.visible = false
		this.object.uso_t.visible = false
	else
		this.object.tipo_terr_t.visible = false
		this.object.tipo_terr.visible = false
		this.object.superficie.visible = false
		this.object.superficie_t.visible = false
		this.object.uso.visible = true
		this.object.b_usos.visible = true
		this.object.uso_t.visible = true
	end if
end if

end event

type cb_4 from commandbutton within w_calculo_honorarios_le
integer x = 485
integer y = 468
integer width = 402
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Calcular &PEM"
end type

event clicked;dw_2.accepttext()
st_honteor_datos st_hon

// Rellenamos la estructura
st_hon.tarifa 			= dw_1.getitemstring(1, 'tarifa')
st_hon.superficie 	= dw_2.getitemnumber(1, 'superficie')
st_hon.uso				= dw_2.getitemnumber(1, 'uso')
st_hon.tipo_terr		= dw_2.getitemnumber(1, 'tipo_terr')
st_hon.nave				= dw_2.getitemnumber(1, 'nave')

// Calculamos el pem minimo
f_calcular_pem_min_le(st_hon)

// Visualizamos los resultados
dw_1.setitem(1, 'pem_min', st_hon.pem_min)
dw_1.setitem(1, 'presupuesto', st_hon.pem_min)
if dw_1.getitemnumber(1, 'superficie') = 0 then dw_1.setitem(1, 'superficie', st_hon.superficie)

end event

