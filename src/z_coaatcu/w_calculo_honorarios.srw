HA$PBExportHeader$w_calculo_honorarios.srw
forward
global type w_calculo_honorarios from w_response
end type
type cb_3 from commandbutton within w_calculo_honorarios
end type
type cb_2 from commandbutton within w_calculo_honorarios
end type
type cb_1 from commandbutton within w_calculo_honorarios
end type
type dw_1 from u_dw within w_calculo_honorarios
end type
end forward

global type w_calculo_honorarios from w_response
integer x = 214
integer y = 221
integer width = 2839
integer height = 1588
string title = "C$$HEX1$$e100$$ENDHEX$$lculo de Honorarios"
event csd_cargar_datos ( )
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_calculo_honorarios w_calculo_honorarios

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
ds_datos.DataObject = 'd_fases_cip_cu'
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

on w_calculo_honorarios.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
end on

on w_calculo_honorarios.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
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

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_calculo_honorarios
integer x = 2770
integer y = 1184
integer width = 82
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_calculo_honorarios
integer x = 2770
integer y = 1088
integer width = 155
end type

type cb_3 from commandbutton within w_calculo_honorarios
integer x = 1481
integer y = 1300
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

type cb_2 from commandbutton within w_calculo_honorarios
integer x = 809
integer y = 1300
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
i_ds_hon.DataObject = 'd_calculo_honorarios'
i_ds_hon.SetTransObject(SQLCA)

dw_1.rowscopy(1, 1, Primary!, i_ds_hon, 1, Primary!)

closewithreturn(parent, i_ds_hon)

end event

type cb_1 from commandbutton within w_calculo_honorarios
integer x = 2258
integer y = 660
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Calcular"
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

// Calculamos los honorarios
f_calcular_honteor_cu(st_hon)

// Visualizamos los resultados
if not f_es_vacio(st_hon.formula) then dw_1.setitem(1, 'formula', st_hon.formula)
dw_1.setitem(1, 'desarrollo', st_hon.desarrollo)
dw_1.setitem(1, 'importe', st_hon.importe)
end event

type dw_1 from u_dw within w_calculo_honorarios
integer x = 37
integer y = 32
integer width = 2747
integer height = 1188
integer taborder = 10
string dataobject = "d_calculo_honorarios"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;string formula

CHOOSE CASE dwo.name
	CASE 'tarifa'

		// Obtenemos la formula y la mostramos
		SELECT ho_tarifas.formula  
		INTO :formula  
		FROM ho_tarifas  
		WHERE ho_tarifas.cod_tarifa = :data   ;

		this.setitem(1, 'formula', formula)

		// Inicializamos valores de los parametros
		f_inicializar_valores_st_honteor_datos (parent)
		
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
		post f_parametriza_ventana_calculo_honorarios(parent)
		
	CASE 'nueva_planta'
		formula = this.getitemstring(1, 'formula')
		if data = 'S' then
			if right(formula,4)='1,20' then formula = LeftA(formula, LenA(formula) - 7)
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

