HA$PBExportHeader$w_calculo_honorarios_za.srw
$PBExportComments$Heredada de la ventana de Cuenca
forward
global type w_calculo_honorarios_za from w_calculo_honorarios
end type
type cb_4 from commandbutton within w_calculo_honorarios_za
end type
type dw_2 from u_dw within w_calculo_honorarios_za
end type
end forward

global type w_calculo_honorarios_za from w_calculo_honorarios
integer height = 1952
cb_4 cb_4
dw_2 dw_2
end type
global w_calculo_honorarios_za w_calculo_honorarios_za

on w_calculo_honorarios_za.create
int iCurrent
call super::create
this.cb_4=create cb_4
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_4
this.Control[iCurrent+2]=this.dw_2
end on

on w_calculo_honorarios_za.destroy
call super::destroy
destroy(this.cb_4)
destroy(this.dw_2)
end on

event open;call super::open;dw_2.insertrow(0)

dw_1.event itemchanged(1, dw_1.object.contenido, dw_1.getitemstring(1, 'contenido'))

// Obtenemos los par$$HEX1$$e100$$ENDHEX$$metros utilizados para el c$$HEX1$$e100$$ENDHEX$$lculo del pem m$$HEX1$$ed00$$ENDHEX$$nimo
CHOOSE CASE dw_1.getitemstring(1, 'tarifa')
	CASE '1.1'
		dw_2.setitem(1, 'num_resp', i_st_hon.coef_a)
		dw_2.setitem(1, 'superficie', i_st_hon.coef_b)
	CASE '2.1'
		dw_2.setitem(1, 'uso', i_st_hon.coef_a)
		dw_2.setitem(1, 'dificil_acc', i_st_hon.coef_b)
		dw_2.setitem(1, 'sup_acond', i_st_hon.coef_c)
	CASE '4', '17'
		dw_2.setitem(1, 'sup_urb', i_st_hon.coef_a)
		dw_2.setitem(1, 'tipo_terr', i_st_hon.coef_b)
	CASE '16'
		dw_2.setitem(1, 'nave', i_st_hon.coef_a)
		dw_2.setitem(1, 'superficie', i_st_hon.coef_b)
	CASE '17'
END CHOOSE

end event

event csd_cargar_datos();// SOBREESCRITO
// Evento que recupera los datos del calculo de honorarios
string tarifa, param[5], campo, contenido, formula, desarrollo
int i
double importe, p1, p2, p3, p4, p5

datastore ds_datos
ds_datos = create Datastore
ds_datos.DataObject = 'd_fases_cip_za'
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

	if isnull(param[i]) then continue
	
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

type cb_recuperar_pantalla from w_calculo_honorarios`cb_recuperar_pantalla within w_calculo_honorarios_za
integer taborder = 0
end type

type cb_guardar_pantalla from w_calculo_honorarios`cb_guardar_pantalla within w_calculo_honorarios_za
integer taborder = 0
end type

type cb_3 from w_calculo_honorarios`cb_3 within w_calculo_honorarios_za
integer x = 1605
integer y = 1708
integer width = 407
integer taborder = 60
end type

type cb_2 from w_calculo_honorarios`cb_2 within w_calculo_honorarios_za
integer y = 1708
integer taborder = 50
end type

event cb_2::clicked;// Sobreescrito
dw_1.accepttext()

//cb_1.triggerevent(clicked!)

i_ds_hon = create Datastore

if g_colegio='COAATTER' then
	i_ds_hon.DataObject='d_calculo_honorarios_ter'
else
i_ds_hon.DataObject = 'd_calculo_honorarios_za'	
end if

i_ds_hon.SetTransObject(SQLCA)

// Pasamos los datos utilizados para el pem m$$HEX1$$ed00$$ENDHEX$$nimo
dw_1.setitem(1, 'num_resp', dw_2.getitemnumber(1, 'num_resp'))
dw_1.setitem(1, 'uso', dw_2.getitemnumber(1, 'uso'))
dw_1.setitem(1, 'dificil_acc', dw_2.getitemnumber(1, 'dificil_acc'))
dw_1.setitem(1, 'sup_acond', dw_2.getitemnumber(1, 'sup_acond'))
dw_1.setitem(1, 'sup_urb', dw_2.getitemnumber(1, 'sup_urb'))
dw_1.setitem(1, 'tipo_terr', dw_2.getitemnumber(1, 'tipo_terr'))
dw_1.setitem(1, 'nave', dw_2.getitemnumber(1, 'nave'))

dw_1.rowscopy(1, 1, Primary!, i_ds_hon, 1, Primary!)

closewithreturn(parent, i_ds_hon)

end event

type cb_1 from w_calculo_honorarios`cb_1 within w_calculo_honorarios_za
integer x = 485
integer y = 1120
integer taborder = 40
string text = "Calcular &Hon."
end type

event cb_1::clicked;// SOBREESCRITO (para q calcule con la funci$$HEX1$$f300$$ENDHEX$$n de Zaragoza)

dw_1.accepttext()
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
if lower(dw_1.describe("agropec.name")) = 'agropec' then st_hon.agrop = dw_1.getitemString(1, 'agropec')
if lower(dw_1.describe("ebss.name")) = 'ebss' then st_hon.ebss = dw_1.getitemstring(1, 'ebss')
if lower(dw_1.describe("s_compartida.name")) = 's_compartida' then st_hon.s_compartida = dw_1.getitemstring(1, 's_compartida')
if lower(dw_1.describe("urbanizacion.name")) = 'urbanizacion' then st_hon.urbanizacion = dw_1.getitemstring(1, 'urbanizacion')
// Calculamos los honorarios
if g_colegio='COAATTER' then
	f_calcular_honteor_ter(st_hon)
else
	f_calcular_honteor_za(st_hon)
end if

// Visualizamos los resultados
if not f_es_vacio(st_hon.formula) then dw_1.setitem(1, 'formula', st_hon.formula)
dw_1.setitem(1, 'desarrollo', st_hon.desarrollo)
dw_1.setitem(1, 'importe', st_hon.importe)
end event

type dw_1 from w_calculo_honorarios`dw_1 within w_calculo_honorarios_za
event csd_ocultar_campos ( )
integer height = 1596
string dataobject = "d_calculo_honorarios_za"
end type

event dw_1::csd_ocultar_campos();// Evento que oculta los campos y etiquetas del dw de calculo de pem
int i
string campo

for i=1 to integer(dw_2.Object.DataWindow.Column.Count)
	campo = dw_2.Describe("#" + string(i) + ".Name")
	dw_2.Modify("#" + string(i) + ".Visible = 0")
	dw_2.Modify(campo + "_t" + ".Visible = 0")
next

cb_4.visible = false // Bot$$HEX1$$f300$$ENDHEX$$n Calcular PEM
dw_2.object.b_preg.visible = false // Bot$$HEX1$$f300$$ENDHEX$$n P
dw_2.object.b_usos.visible = false // Bot$$HEX1$$f300$$ENDHEX$$n U

end event

event dw_1::itemchanged;call super::itemchanged;string contenido, tarifa

contenido = dw_1.getitemstring(1, 'contenido')
tarifa = dw_1.getitemstring(1, 'tarifa')

CHOOSE CASE dwo.name
	CASE 'tarifa'
		event csd_ocultar_campos()
		f_inicializar_valores_st_honteor_dat_za (parent)
		
		// Cogemos el pem y el presupuesto que se le haya pasado
		this.setitem(1, 'presupuesto', i_st_hon.presupuesto)
		this.setitem(1, 'superficie', i_st_hon.superficie)
		this.setitem(1, 'altura', i_st_hon.altura)
		this.setitem(1, 'volumen', i_st_hon.volumen)
		this.setitem(1, 'tipologia', i_st_hon.medianeras)
		dw_2.setitem(1, 'superficie', i_st_hon.superficie)
		dw_2.setitem(1, 'sup_urb', i_st_hon.superficie)
		dw_2.setitem(1, 'sup_acond', i_st_hon.superficie)		
		
		CHOOSE CASE data
			CASE '16'
				dw_2.object.nave.visible = true
				dw_2.object.nave_t.visible = true
				dw_2.object.superficie.visible = true
				dw_2.object.superficie_t.visible = true
				cb_4.visible = true
			CASE '17'
				dw_2.object.sup_urb.visible = true
				dw_2.object.sup_urb_t.visible = true
				dw_2.object.tipo_terr.visible = true
				dw_2.object.tipo_terr_t.visible = true
				cb_4.visible = true
		//	CASE '21'
		//		if g_colegio='COAATTER' then dw_1.object.jornadas_t.text='Visitas Realizadas'
				
		END CHOOSE
		post f_parametriza_ventana_calculo_honos_za(parent)
	CASE 'contenido'
		event csd_ocultar_campos()
		CHOOSE CASE data
			CASE 'EG', 'RP'
				if tarifa = '1.1' then
					dw_2.object.num_resp.visible = true
					dw_2.object.num_resp_t.visible = true
					dw_2.object.superficie.visible = true
					dw_2.object.superficie_t.visible = true
					dw_2.object.b_preg.visible = true
					cb_4.visible = true
				end if
				if tarifa = '2.1' then
					dw_2.object.uso.visible = true
					dw_2.object.uso_t.visible = true
					dw_2.object.dificil_acc.visible = true
					dw_2.object.dificil_acc_t.visible = true
					dw_2.object.sup_acond.visible = true
					dw_2.object.sup_acond_t.visible = true
					dw_2.object.b_usos.visible = true
					cb_4.visible = true
				end if
				if tarifa = '4' then
					dw_2.object.sup_urb.visible = true
					dw_2.object.sup_urb_t.visible = true
					dw_2.object.tipo_terr.visible = true
					dw_2.object.tipo_terr_t.visible = true
					cb_4.visible = true
				end if
			CASE 'URB', 'EDF'
				if tarifa = '17' then
					dw_2.object.sup_urb.visible = true
					dw_2.object.sup_urb_t.visible = true
					dw_2.object.tipo_terr.visible = true
					dw_2.object.tipo_terr_t.visible = true
					cb_4.visible = true
				end if
		END CHOOSE

END CHOOSE

end event

event dw_1::constructor;call super::constructor;if g_colegio='COAATTER' then
	this.DataObject='d_calculo_honorarios_ter'
	this.SetTransObject(SQLCA)
end if

end event

type cb_4 from commandbutton within w_calculo_honorarios_za
integer x = 485
integer y = 468
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
string text = "Calcular &PEM"
end type

event clicked;dw_2.accepttext()
st_honteor_datos st_hon

// Rellenamos la estructura
st_hon.tarifa 			= dw_1.getitemstring(1, 'tarifa')
st_hon.superficie 	= dw_2.getitemnumber(1, 'superficie')
st_hon.num_resp		= dw_2.getitemnumber(1, 'num_resp')
st_hon.uso				= dw_2.getitemnumber(1, 'uso')
st_hon.dificil_acc	= dw_2.getitemnumber(1, 'dificil_acc')
st_hon.sup_acond		= dw_2.getitemnumber(1, 'sup_acond')
st_hon.sup_urb			= dw_2.getitemnumber(1, 'sup_urb')
st_hon.tipo_terr		= dw_2.getitemnumber(1, 'tipo_terr')
st_hon.nave				= dw_2.getitemnumber(1, 'nave')

// Calculamos los honorarios
f_calcular_pem_min_za(st_hon)

// Visualizamos los resultados
dw_1.setitem(1, 'pem_min', st_hon.pem_min)
dw_1.setitem(1, 'presupuesto', st_hon.pem_min)
if dw_1.getitemnumber(1, 'superficie') = 0 then dw_1.setitem(1, 'superficie', st_hon.superficie)

end event

type dw_2 from u_dw within w_calculo_honorarios_za
integer x = 37
integer y = 252
integer width = 2747
integer height = 212
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_calculo_pem_min_za"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;double res

choose case dwo.name
	case 'b_preg'
		openwithparm(w_pem_minimo_aux, 'P')
		res = message.doubleparm
		dw_2.setitem(1, 'num_resp', res)
	case 'b_usos'
		openwithparm(w_pem_minimo_aux, 'U')
		res = message.doubleparm
		dw_2.setitem(1, 'uso', res)
end choose

end event

