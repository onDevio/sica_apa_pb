HA$PBExportHeader$w_calculo_tarifas.srw
forward
global type w_calculo_tarifas from w_response
end type
type cb_2 from commandbutton within w_calculo_tarifas
end type
type dw_descuentos from u_dw within w_calculo_tarifas
end type
type cb_1 from commandbutton within w_calculo_tarifas
end type
type gb_1 from groupbox within w_calculo_tarifas
end type
type cb_impr from commandbutton within w_calculo_tarifas
end type
type dw_imprimir_ficha from u_dw within w_calculo_tarifas
end type
type tab_1 from tab within w_calculo_tarifas
end type
type tabpage_1 from userobject within tab_1
end type
type dw_parametros from u_dw within tabpage_1
end type
type dw_1 from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_parametros dw_parametros
dw_1 dw_1
end type
type tab_1 from tab within w_calculo_tarifas
tabpage_1 tabpage_1
end type
type dw_asociados from u_dw within w_calculo_tarifas
end type
type dw_resumen from u_dw within w_calculo_tarifas
end type
type dw_resumen_por_act from u_dw within w_calculo_tarifas
end type
type cb_limpiar from commandbutton within w_calculo_tarifas
end type
type gb_2 from groupbox within w_calculo_tarifas
end type
type gb_4 from groupbox within w_calculo_tarifas
end type
end forward

global type w_calculo_tarifas from w_response
integer width = 2971
integer height = 2960
string title = "C$$HEX1$$e100$$ENDHEX$$lculo Gastos"
event csd_rellenar_ventana ( )
event csd_datos_defecto ( )
cb_2 cb_2
dw_descuentos dw_descuentos
cb_1 cb_1
gb_1 gb_1
cb_impr cb_impr
dw_imprimir_ficha dw_imprimir_ficha
tab_1 tab_1
dw_asociados dw_asociados
dw_resumen dw_resumen
dw_resumen_por_act dw_resumen_por_act
cb_limpiar cb_limpiar
gb_2 gb_2
gb_4 gb_4
end type
global w_calculo_tarifas w_calculo_tarifas

type variables
DataWindowChild i_dwc_colegiados_asociados
datawindow dw_1, dw_hon_min // , dw_parametros

string i_tramite_defecto

end variables

event csd_rellenar_ventana();// Rellenamos la ventana con los datos de la fase desde la que se llama a la ventana

string id_fase,t_act,tipo_obra,tipo_gestion,destino_int,tramite, colindantes
double sup_viv,sup_otros,sup_garaje,superficie,volumen,pem,porc_a,altura,num_viv
string n_col,id_col,trabajo,ejerce_func,administracion,desc_fase, visared

id_fase=g_fases_busqueda.id_fase

select e.administracion,f.descripcion,f.fase,f.tipo_trabajo,f.trabajo,f.tipo_gestion,f.destino_int,u.num_viv,u.superficie,u.volumen,u.sup_viv,u.sup_garage,u.sup_otros,u.pem,u.altura,c.n_colegiado,c.id_colegiado,fc.porcen_a,fc.facturado,f.id_tramite, u.colindantes2m, e_mail
into :administracion,:desc_fase,:t_act,:tipo_obra,:trabajo,:tipo_gestion,:destino_int,:num_viv,:superficie,:volumen,:sup_viv,:sup_garaje,:sup_otros,:pem,:altura,:n_col,:id_col,:porc_a,:ejerce_func,:tramite, :colindantes, :visared
from expedientes e,fases f,fases_colegiados fc,colegiados c,fases_usos u where e.id_expedi = f.id_expedi and f.id_fase=:id_fase and f.id_fase=u.id_fase and fc.id_fase=f.id_fase and fc.id_col=c.id_colegiado;

dw_1.SetItem(1,'id_fase',id_fase)
dw_1.SetItem(1,'n_col',n_col)
dw_1.SetItem(1,'id_col',id_col)
dw_1.SetItem(1,'porcen_a',porc_a)
dw_1.SetItem(1,'fase_1',t_act)
dw_1.SetItem(1,'tipo_trabajo',tipo_obra)
dw_1.SetItem(1,'trabajo',trabajo)
dw_1.SetItem(1,'tipo_gestion',tipo_gestion)
dw_1.SetItem(1,'superficie',superficie)
dw_1.SetItem(1,'sup_viv',sup_viv)
dw_1.SetItem(1,'sup_garage',sup_garaje)
dw_1.SetItem(1,'sup_otros',sup_otros)
dw_1.SetItem(1,'volumen',volumen)
dw_1.SetItem(1,'altura',altura)
dw_1.SetItem(1,'pem',pem)
dw_1.SetItem(1,'destino_int',destino_int)
dw_1.setitem(1,'id_tramite',tramite)
dw_1.setitem(1,'e_mail',visared)
dw_1.setitem(1,'cod_colegio_dest',g_colegio)
if f_es_vacio(colindantes) then colindantes = 'N'
dw_1.setitem(1,'colindantes2m',colindantes)
//SCP-2048
if f_existe_columna_en_dw (dw_1,'descripcion') = 1 then dw_1.SetItem(1,'descripcion',desc_fase)
if f_existe_columna_en_dw (dw_1,'administracion') = 1 then dw_1.SetItem(1,'administracion',administracion)
if f_existe_columna_en_dw (dw_1,'num_viv') = 1 then dw_1.SetItem(1,'num_viv',num_viv)
if f_existe_columna_en_dw (dw_1,'funcionario') = 1 then dw_1.SetItem(1,'funcionario',ejerce_func)



end event

on w_calculo_tarifas.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.dw_descuentos=create dw_descuentos
this.cb_1=create cb_1
this.gb_1=create gb_1
this.cb_impr=create cb_impr
this.dw_imprimir_ficha=create dw_imprimir_ficha
this.tab_1=create tab_1
this.dw_asociados=create dw_asociados
this.dw_resumen=create dw_resumen
this.dw_resumen_por_act=create dw_resumen_por_act
this.cb_limpiar=create cb_limpiar
this.gb_2=create gb_2
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.dw_descuentos
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_impr
this.Control[iCurrent+6]=this.dw_imprimir_ficha
this.Control[iCurrent+7]=this.tab_1
this.Control[iCurrent+8]=this.dw_asociados
this.Control[iCurrent+9]=this.dw_resumen
this.Control[iCurrent+10]=this.dw_resumen_por_act
this.Control[iCurrent+11]=this.cb_limpiar
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_4
end on

on w_calculo_tarifas.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.dw_descuentos)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.cb_impr)
destroy(this.dw_imprimir_ficha)
destroy(this.tab_1)
destroy(this.dw_asociados)
destroy(this.dw_resumen)
destroy(this.dw_resumen_por_act)
destroy(this.cb_limpiar)
destroy(this.gb_2)
destroy(this.gb_4)
end on

event open;call super::open;
f_centrar_ventana(this)

dw_1 = tab_1.tabpage_1.dw_1
dw_1.DataObject='d_calculo_tarifas'
dw_1.SetTransObject(SQLCA)

if g_colegio='COAATTEB' then
	dw_imprimir_ficha.dataobject='d_fases_calculo_gastos_imprimir_teb'	
	dw_imprimir_ficha.SetTransObject(SQLCA)
elseif g_colegio='COAATTGN' or g_colegio='COAATLL' then
	dw_imprimir_ficha.dataobject='d_fases_calculo_gastos_imprimir_tg'
	dw_imprimir_ficha.SetTransObject(SQLCA)
elseif g_colegio='COAATMCA' then
	datawindowchild dwc
	dw_1.GetChild('tipologia_edif',dwc)
	dwc.SetTransObject(SQLCA)
	dwc.retrieve()
	dw_imprimir_ficha.dataobject='d_fases_calculo_gastos_imprimir_teb'	
	dw_imprimir_ficha.SetTransObject(SQLCA)
else
	dw_imprimir_ficha.dataobject='d_fases_calculo_gastos_imprimir_castellano'	
	dw_imprimir_ficha.SetTransObject(SQLCA)
end if	



select texto into :i_tramite_defecto from var_globales where nombre='g_tramite_defecto';

dw_1.dynamic event pfc_addrow()
dw_1.setitem(1, 'f_entrada', date(datetime(today())))
dw_1.setitem(1, 'f_calculo_musaat', date(datetime(today())))
dw_1.setitem(1,'porcen_a', 100)
dw_1.setitem(1,'id_tramite',i_tramite_defecto)
dw_1.setitem(1,'cod_colegio_dest',g_colegio)
//dw_colegiados.event pfc_addrow()
//dw_colegiados.setitem(1,'porcen_a', 100)
dw_resumen.event pfc_addrow()



if not(f_es_vacio(g_fases_busqueda.id_fase)) then event csd_rellenar_ventana()

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_calculo_tarifas
integer y = 1496
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_calculo_tarifas
integer y = 1332
integer taborder = 0
end type

type cb_2 from commandbutton within w_calculo_tarifas
integer x = 2021
integer y = 2760
integer width = 480
integer height = 96
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
boolean cancel = true
end type

event clicked;close(parent)

end event

type dw_descuentos from u_dw within w_calculo_tarifas
event csd_calcular_descuentos ( )
event csd_calcular_descuentos_nuevo ( )
event csd_calcular_musaat ( )
integer x = 64
integer y = 1292
integer width = 2816
integer height = 724
integer taborder = 30
string dataobject = "d_calculo_gastos_informes_tg"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_calcular_descuentos();Setpointer(HourGlass!)
double cip = 0, dv = 0, musaat = 0, cip_incrementar = 0, dv_incrementar = 0
st_csi_articulos_servicios st_csi_articulos_servicios
double i,j, porcen
int fila_insertada,ind
string id_col, id_asociado, obra_oficial, ls_muestra_articulos_a_cero
int ret
double sup_viv,sup_otros,sup_garaje,importe_base

string formula_actual="",desarrollo_actual
long res
string t_act,t_tramite,id_informe, visared
double total_informe
n_csd_calculo_gastos uo_calculo_gastos

dw_resumen_por_act.insertrow(0)
dw_resumen_por_act.insertrow(0)
dw_resumen_por_act.insertrow(0)

select sn into :ls_muestra_articulos_a_cero from var_globales where nombre = 'g_muestra_articulos_a_cero';

//**************
// ARTICULOS
//**************
// cargo la estructura


sup_viv = dw_1.getitemnumber(1, 'sup_viv')
sup_otros= dw_1.getitemnumber(1, 'sup_otros')
sup_garaje=dw_1.getitemnumber(1, 'sup_garage')
if IsNull(sup_viv) then sup_viv=0
if IsNull(sup_otros) then sup_otros=0	
if IsNull(sup_garaje) then sup_garaje=0	

obra_oficial = dw_1.GetItemString(dw_1.GetRow(),'administracion')
if f_es_vacio(obra_oficial) then obra_oficial = 'N'
visared = dw_1.GetItemString(dw_1.GetRow(),'e_mail')


t_tramite=dw_1.GetItemString(dw_1.GetRow(),'id_tramite')

for j=1 to 3
	uo_calculo_gastos=create n_csd_calculo_gastos
res=uo_calculo_gastos.of_conectar_transaccion(sqlca.DBMS,sqlca.database,sqlca.LogID,sqlca.LogPass,sqlca.servername,sqlca.userid,sqlca.dbpass,sqlca.lock,sqlca.dbparm,'TRUE')

if res<0 then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al conectar a la base de datos")
end if

	uo_calculo_gastos.of_set_string('tipo_obra',dw_1.GetItemString(dw_1.GetRow(),'tipo_trabajo'))		
	uo_calculo_gastos.of_set_string('colegio',dw_1.GetItemString(dw_1.GetRow(),'cod_colegio_dest'))		
	uo_calculo_gastos.of_set_string('visared',dw_1.GetItemString(dw_1.GetRow(),'e_mail'))		
	uo_calculo_gastos.of_set_string('obra_oficial', obra_oficial)
	uo_calculo_gastos.of_set_string('tipo_gestion',dw_1.GetItemString(dw_1.GetRow(),'tipo_gestion'))		
	uo_calculo_gastos.of_set_double('superficie',sup_viv+sup_otros+sup_garaje)				
	uo_calculo_gastos.of_set_double('pem',dw_1.getitemnumber(1, 'pem'))	
	uo_calculo_gastos.of_set_string('visared', visared)
	
	choose case g_colegio
		case 'COAATLL', 'COAATAVI'
			uo_calculo_gastos.of_set_double('otro_rango',dw_1.getitemnumber(1, 'volumen'))
		case else
			uo_calculo_gastos.of_set_double('otro_rango',dw_1.getitemnumber(1, 'num_viv'))
	end choose		

	t_act=dw_1.GetItemString(dw_1.GetRow(),'fase_'+string(j))
	if f_es_vacio(t_act) then continue
	uo_calculo_gastos.of_set_string('tipo_act',t_act)		

	
//	DECLARE tarifas_coef cursor for SELECT id_informe
//			  FROM tarifas_informes_x_tramite WHERE tipo_tramite=:t_tramite and colegio=:g_colegio and :visared like visared ;
//	open tarifas_coef; 
//	i=0 
	
	string ls_visared_tramites
	ls_visared_tramites = visared
	// S$$HEX1$$ed00$$ENDHEX$$: 'V' => 'S'
	IF visared = 'V' THEN 
		ls_visared_tramites = 'S'
	// Otros : 'S' => sin equivalencia, debe ser distinto a 'S', 'N'
	elseif visared = 'S' THEN 	
		ls_visared_tramites = 'O'
	end if
	
	datastore informes

	informes = create datastore
	informes.dataobject = 'd_fases_informes_x_tramite'
	informes.SetTransObject(SQLCA)
	informes.Retrieve (ls_visared_tramites, t_tramite, g_colegio)

	for i=1 to informes.RowCount()
	//do while true
//		fetch tarifas_coef into :id_informe;
//		if sqlca.sqlcode <> 0 then exit
//		uo_calculo_gastos.of_set_string('informe',id_informe)
//		
//		string t 
//		t = uo_calculo_gastos.f_obtener_tarifa()
//		total_informe=uo_calculo_gastos.of_calcular_importe_total()
//		importe_base = uo_calculo_gastos.f_calcular_importe_base()
		
		id_informe = informes.GetItemString(i, 'id_informe');
		//if sqlca.sqlcode <> 0 then exit
		uo_calculo_gastos.of_set_string('informe',id_informe)
		total_informe=uo_calculo_gastos.of_calcular_importe_total()
		importe_base = uo_calculo_gastos.f_calcular_importe_base()
	
		if f_valida_articulo_activo(id_informe, g_empresa) = 0 then continue
		
		
		//**************
		// INSERTAR LA FILA EN GASTOS
		//**************
		if total_informe <> 0 then
			//Comprobar si ya se ha calculado anteriormente
			long fila
			double valor_ant
			fila_insertada=this.insertrow(0)
			this.setitem(fila_insertada, 'tipo_informe', id_informe)
			this.setitem(fila_insertada, 'tipo_actuacion', t_act)
			// cojo los datos del concepto
			st_csi_articulos_servicios.codigo =id_informe
			if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
				st_csi_articulos_servicios.t_iva = g_t_iva_defecto
			end if
			this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
			if dw_1.GetItemnumber(dw_1.GetRow(),'porcen_a') <100 then
				total_informe = total_informe * (dw_1.GetItemnumber(dw_1.GetRow(),'porcen_a')/100)
				
				//SCP-1542 Solo aplica a tarragona
				if total_informe <  importe_base and g_colegio = 'COAATTGN' then total_informe = importe_base
					
			end if
			this.setitem(fila_insertada, 'cuantia_colegiado',total_informe  )
			this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(total_informe, st_csi_articulos_servicios.t_iva ))
			// Se guarda la formula sustituida Agregado el 13/10/08
			//this.setitem(fila_insertada, 'formula_sustituida', uo_calculo_gastos.of_get_string('dip_formula_desarrollo'))
		
		else // Si la tarifa no existe inserta una linea de cip con valor 0
			if (ls_muestra_articulos_a_cero = 'S') then 
				fila = this.Find("tipo_informe = '" + id_informe+ "'",0,this.RowCount())
				if fila = 0 Then
					fila_insertada = this.event pfc_addrow()
					this.setitem(fila_insertada, 'tipo_informe', id_informe)
					st_csi_articulos_servicios.codigo = id_informe
					if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
						st_csi_articulos_servicios.t_iva = g_t_iva_defecto
					end if
					this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
					this.setitem(fila_insertada, 'cuantia_colegiado', 0)
					this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(total_informe, st_csi_articulos_servicios.t_iva ))
			
				end if
			end if
		end if
		
		
		formula_actual=dw_resumen.GetItemSTring(1,'formula')
		desarrollo_actual=dw_resumen.GetItemSTring(1,'desarrollo')
		
		if IsNull(formula_actual) then 
			formula_actual=""
		else
			formula_actual+='~n'
		end if
		
		if IsNull(desarrollo_actual) then 
			desarrollo_actual=""
		else
			desarrollo_actual+='~n'
		end if
		
		formula_actual +=id_informe+' ('+string(j)+') = '+uo_calculo_gastos.of_get_string('formula')
		desarrollo_actual +=id_informe+' ('+string(j)+') = '+uo_calculo_gastos.of_get_string('desarrollo')	
		
		dw_resumen.SetItem(1,'formula',formula_actual)
		dw_resumen.SetItem(1,'desarrollo',desarrollo_actual)		
	next
	//loop
	
	
	//close tarifas_coef;
	destroy informes
	destroy uo_calculo_gastos
next


end event

event csd_calcular_descuentos_nuevo();Setpointer(HourGlass!)
double cip = 0, dv = 0, musaat = 0, cip_incrementar = 0, dv_incrementar = 0
st_csi_articulos_servicios st_csi_articulos_servicios
st_dv_datos st_dv_datos
st_musaat_datos st_musaat_datos
double i,j, porcen
int fila_insertada,ind
string id_col, id_asociado
int ret,res

string formula_desarrollo_mussat="",formula_mussat=""
string formula_desarrollo_cip="",formula_cip=""
string formula_desarrollo_dv="",formula_dv=""

n_calculo_gastos_gen uo_calculo_gastos
uo_calculo_gastos=create n_calculo_gastos_gen

string obra_oficial
double sup_garaje,sup_otros,sup_viv
dw_resumen_por_act.insertrow(0)
dw_resumen_por_act.insertrow(0)
dw_resumen_por_act.insertrow(0)


res=uo_calculo_gastos.of_conectar_transaccion(sqlca.DBMS,sqlca.database,sqlca.LogID,sqlca.LogPass,sqlca.servername,sqlca.userid,sqlca.dbpass,sqlca.lock,sqlca.dbparm,'TRUE')

if res<0 then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al conectar a la base de datos")
end if


//**************
// CIP
//**************
// cargo la estructura
for i=1 to 3
	uo_calculo_gastos.of_set_string('colegio', g_colegio)
	

		obra_oficial=dw_1.getitemstring(1, 'administracion')
		uo_calculo_gastos.of_set_string('tipo_gestion',dw_1.GetItemString(1,'tipo_gestion'))
		uo_calculo_gastos.of_set_fecha('f_entrada',dw_1.GetItemdatetime(1,'f_entrada'))

		uo_calculo_gastos.of_set_string('admon',obra_oficial)	
		uo_calculo_gastos.of_set_string('tipo_act', dw_1.getitemstring(1, 'fase_'+string(i)))		
		uo_calculo_gastos.of_set_string('tipo_obra',dw_1.getitemstring(1, 'tipo_trabajo'))
		uo_calculo_gastos.of_set_string('destino',dw_1.getitemstring(1, 'trabajo'))
		uo_calculo_gastos.of_set_double('volumen', dw_1.GetItemnumber(1,'volumen'))
		uo_calculo_gastos.of_set_double('vol_edif', dw_1.GetItemnumber(1,'volumen'))		
		uo_calculo_gastos.of_set_double('altura',dw_1.GetItemnumber(1,'altura'))						
		sup_viv = dw_1.getitemnumber(1, 'sup_viv')
		if IsNull(sup_viv) then sup_viv=0
		sup_otros= dw_1.getitemnumber(1, 'sup_otros')
		if IsNull(sup_otros) then sup_otros=0
		sup_garaje= dw_1.getitemnumber(1, 'sup_garage')		
		if IsNull(sup_garaje) then sup_garaje=0		
		uo_calculo_gastos.of_set_double('sup_viviendas',sup_viv)							
		uo_calculo_gastos.of_set_double('sup_otros',sup_otros + sup_garaje)
		uo_calculo_gastos.of_set_double('superficie',sup_viv+sup_otros+sup_garaje)				
		uo_calculo_gastos.of_set_double('pem',dw_1.getitemnumber(1, 'pem'))	
		if g_colegio = 'COAATMCA' then uo_calculo_gastos.of_set_double('pem_seg',dw_1.getitemnumber(1, 'pem_seguridad'))	
		uo_calculo_gastos.of_set_double('num_viv',dw_1.getitemnumber(1, 'num_viv'))	
		if g_colegio = 'COAATMCA' then uo_calculo_gastos.of_set_string('tipologia',dw_1.GetItemString(1,'tipologia_edif'))
		
		
		if lower( dw_1.describe("destino_int.name")) = 'otros_destinos'  then 	uo_calculo_gastos.of_set_string('destino_int',dw_1.getitemString(1, 'destino_int'))
		if lower( dw_1.describe("visared.name")) = 'visared'  then 	uo_calculo_gastos.of_set_string('visared',dw_1.GetItemString(1,'visared'))
		if lower( dw_1.describe("cc_externo.name")) = 'cc_externo'  then 	uo_calculo_gastos.of_set_string('cc_externo',dw_1.GetItemString(1,'cc_externo'))
		if lower( dw_1.describe("funcionario.name")) = 'funcionario' then uo_calculo_gastos.of_set_string('funcionario',dw_1.getitemString(1, 'funcionario'))
		if lower( dw_1.describe("mantenimiento.name")) = 'mantenimiento' then uo_calculo_gastos.of_set_string('mantenimiento',dw_1.getitemString(1, 'mantenimiento'))


	if f_es_vacio(dw_1.getitemstring(1, 'fase_'+string(i))) then continue

	
	porcen = dw_1.GetItemNumber(1,'porcen_a')
	//st_cip_datos.modulo = 'G'
	
	uo_calculo_gastos.of_set_double('porcentaje',porcen)
	uo_calculo_gastos.of_calcular_dip()
	uo_calculo_gastos.of_calcular_dv()

	
	cip = uo_calculo_gastos.of_get_double('dip')
	dv = uo_calculo_gastos.of_get_double('dv')
	// Ya aplica el porcentaje en la funci$$HEX1$$f300$$ENDHEX$$n de c$$HEX1$$e100$$ENDHEX$$lculo tanto en TGN como en TEB
	//cip = st_cip_datos.cip * porcen/100
	
	if isnull(cip) then cip = 0
	if isnull(dv) then dv = 0
	// Solo para el colegio de la rioja
	string ctrl_calidad_interno

		
	ctrl_calidad_interno = 'N'
	
	fila_insertada = this.event pfc_addrow()
	if fila_insertada > 0 then
		
		this.setitem(fila_insertada, 'tipo_actuacion', dw_1.getitemstring(1, 'fase_'+string(i)))
		this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.cip)
		// cojo los datos del concepto
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.cip
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		this.setitem(fila_insertada, 'cuantia_colegiado', cip )
		this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(cip, st_csi_articulos_servicios.t_iva ))

		formula_cip += 'DIP ('+string(i)+') = ' +uo_calculo_gastos.of_get_string('dip_formula') +'~n'
		formula_desarrollo_cip += 'DIP ('+string(i)+') = '+ uo_calculo_gastos.of_get_string('dip_formula_desarrollo') +'~n'	

	end if
	
	if dv>0 then
		fila_insertada = this.event pfc_addrow()
		if fila_insertada > 0 then
			
			this.setitem(fila_insertada, 'tipo_actuacion', dw_1.getitemstring(1, 'fase_'+string(i)))
			this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.dv)
			// cojo los datos del concepto
			st_csi_articulos_servicios.codigo = g_codigos_conceptos.dv
			if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
				st_csi_articulos_servicios.t_iva = g_t_iva_defecto
			end if
			this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
			this.setitem(fila_insertada, 'cuantia_colegiado', dv )
			this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(dv, st_csi_articulos_servicios.t_iva ))
	
			formula_dv += 'DV ('+string(i)+') = ' +uo_calculo_gastos.of_get_string('dv_formula') +'~n'
			formula_desarrollo_dv += 'DV ('+string(i)+') = '+ uo_calculo_gastos.of_get_string('dv_formula_desarrollo') +'~n'	
	
		end if		
	end if
	
	
next


//**************
// COAATMCA: TARIFA DE MANTENIMIENTO
//**************

string t_act
boolean mant=false
st_calculo_dip st_mant
string formula_mant='',formula_desarrollo_mant=''
double tarifa_manten, porc_mant

if g_colegio='COAATMCA' then
	for i=1 to 3
		t_act=dw_1.getitemstring(1, 'fase_'+string(i))
		if f_es_vacio(t_act) then continue
		if left(t_act,1)='1' and dw_1.getitemString(1, 'mantenimiento')='S' then
			st_mant.pem=dw_1.getitemnumber(1, 'pem')
			st_mant.superficie=sup_viv+sup_otros+sup_garaje
			st_mant.fecha=dw_1.GetItemdatetime(1,'f_entrada')
			st_mant.admon=obra_oficial
			f_calcular_tarifa_manten_coaatmca(st_mant)
			tarifa_manten=st_mant.cip
			porc_mant =  dw_1.getitemnumber(1, 'porcen_a')	
		
			tarifa_manten = tarifa_manten * porc_mant / 100
			if tarifa_manten>0 then
				fila_insertada = this.event pfc_addrow()
				if fila_insertada > 0 then
					this.setitem(fila_insertada, 'tipo_actuacion', t_act)
					this.setitem(fila_insertada, 'tipo_informe', '43')
					st_csi_articulos_servicios.codigo = '43'
					if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
						st_csi_articulos_servicios.t_iva = g_t_iva_defecto
					end if
					this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
					this.setitem(fila_insertada, 'cuantia_colegiado', tarifa_manten )
					this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(tarifa_manten, st_csi_articulos_servicios.t_iva ))
					
					formula_mant += 'MANT ('+string(i)+') = ' + st_mant.formula + '~n'
					formula_desarrollo_mant += 'MANT ('+string(i)+') = ' + st_mant.desarrollo +'~n'
				end if
			end if			
		end if
	next

end if


//**************
// MUSAAT
//**************

for ind=1 to 3

	double porc_col = 0, porc_col_real = 0, suma_porc = 0
	// Suma de la Musaat de todos los colegiado
	// Si es una asociaci$$HEX1$$f300$$ENDHEX$$n, de todos los asociados
	st_musaat_datos.n_visado = dw_1.getitemstring(1, 'id_fase')
	st_musaat_datos.tipo_act = dw_1.getitemstring(1, 'fase_'+string(ind))
	st_musaat_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_trabajo')
	st_musaat_datos.f_calculo = dw_1.getitemdatetime(1, 'f_calculo_musaat')
	st_musaat_datos.pem = dw_1.getitemnumber(1, 'pem')
	st_musaat_datos.administracion = dw_1.getitemstring(1, 'administracion')
	st_musaat_datos.superficie = dw_1.getitemnumber(1, 'sup_viv')	+ dw_1.getitemnumber(1, 'sup_otros') + dw_1.getitemnumber(1, 'sup_garage')
	st_musaat_datos.volumen = dw_1.getitemnumber(1, 'volumen')
	st_musaat_datos.colindantes2m = dw_1.getitemstring(1, 'colindantes2m')
	st_musaat_datos.cod_colegio = dw_1.getitemstring(1, 'cod_colegio_dest')
	st_musaat_datos.recuperar = false
	
	if f_es_vacio(st_musaat_datos.tipo_act) then continue
	

	suma_porc =  dw_1.getitemnumber(1, 'porcen_a')	
	porc_col =  dw_1.getitemnumber(1, 'porcen_a')	
	id_col = dw_1.getitemstring(1, 'id_col')
	st_musaat_datos.porcentaje = porc_col
	st_musaat_datos.id_col = id_col
	if f_colegiado_tipopersona(id_col) = 'S' then	
		f_musaat_calcula_prima_sociedad(st_musaat_datos)
		musaat = st_musaat_datos.prima_comp	
	else
		f_musaat_calcula_prima(st_musaat_datos)	
		musaat = st_musaat_datos.prima_comp		
	end if
	
	if isnull(musaat) then musaat = 0
	
	// El control de calidad (31,32,33) no paga prima complementaria si el colegiado realiza la direcci$$HEX1$$f300$$ENDHEX$$n(11,13,14,16,17)
	string fase1, fase2, fase3	
	if LeftA(st_musaat_datos.tipo_act,1) = '3' then 
		fase1=dw_1.getitemstring(1, 'fase_1')
		fase2=dw_1.getitemstring(1, 'fase_2')
		fase3=dw_1.getitemstring(1, 'fase_3')
		IF fase1 = '11' or fase1='13' or fase1='14' or fase1='16' or fase1= '17' or fase2 = '11' or fase2='13' or fase2='14' or fase2='16' or fase2= '17' or &
			+ fase3 = '11' or fase3='13' or fase3='14' or fase3='16' or fase3= '17' then musaat = 0
	end if
	
	
	if musaat > 0 then
		//Comprobar si ya se ha calculado los DV anteriormente
		long fila_musaat
		double musaat_ant
		
		fila_insertada = this.event pfc_addrow()
		if fila_insertada > 0 then
			this.setitem(fila_insertada, 'tipo_actuacion', st_musaat_datos.tipo_act)
			this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.musaat_variable)
			st_csi_articulos_servicios.codigo = g_codigos_conceptos.musaat_variable
			if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
				st_csi_articulos_servicios.t_iva = g_t_iva_defecto
			end if
			this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
			this.setitem(fila_insertada, 'cuantia_colegiado', musaat )
			this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(musaat, st_csi_articulos_servicios.t_iva ))
			
			formula_mussat += 'MUSAAT ('+string(ind)+') = ' + st_musaat_datos.formula + '~n'
			formula_desarrollo_mussat += 'MUSAAT ('+string(ind)+') = ' + st_musaat_datos.desarrollo +'~n'
		end if
	end if
	dw_resumen_por_act.setitem(ind, 'formula', 'MUSAAT ('+string(ind)+') = ' + st_musaat_datos.formula + '~n' +  'DIP ('+string(ind)+') = ' + uo_calculo_gastos.of_get_string('dip_formula') + '~n' )
	dw_resumen_por_act.setitem(ind, 'desarrollo', 'MUSAAT ('+string(ind)+') = ' + st_musaat_datos.desarrollo + '~n' + 'DIP ('+string(ind)+') = ' + uo_calculo_gastos.of_get_string('dip_formula_desarrollo') +'~n'	)		
next

// Mostramos la formula y el desarrollo aplicados en el calculo de musaat
dw_resumen.setitem(1, 'formula', formula_cip+formula_mant +  formula_dv  + formula_mussat + '~n'  )
dw_resumen.setitem(1, 'desarrollo', formula_desarrollo_cip +formula_desarrollo_mant + formula_desarrollo_dv  + formula_desarrollo_mussat + '~n' )				

this.Sort()
this.GroupCalc()

end event

event csd_calcular_musaat();Setpointer(HourGlass!)
double cip = 0, dv = 0, musaat = 0, cip_incrementar = 0, dv_incrementar = 0

st_csi_articulos_servicios st_csi_articulos_servicios
st_musaat_datos st_musaat_datos
double i,j, porcen
int fila_insertada,ind
string id_col, id_asociado
int ret

string formula_desarrollo_mussat="",formula_mussat=""
string formula_actual,desarrollo_actual

dw_resumen_por_act.insertrow(0)
dw_resumen_por_act.insertrow(0)
dw_resumen_por_act.insertrow(0)


//**************
// MUSAAT
//**************

for ind=1 to 3

	double porc_col = 0, porc_col_real = 0, suma_porc = 0
	// Suma de la Musaat de todos los colegiado
	// Si es una asociaci$$HEX1$$f300$$ENDHEX$$n, de todos los asociados
	st_musaat_datos.n_visado = dw_1.getitemstring(1, 'id_fase')
	st_musaat_datos.tipo_act = dw_1.getitemstring(1, 'fase_'+string(ind))
	st_musaat_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_trabajo')
	st_musaat_datos.f_calculo = dw_1.getitemdatetime(1, 'f_calculo_musaat')
	st_musaat_datos.pem = dw_1.getitemnumber(1, 'pem')
	st_musaat_datos.administracion = dw_1.getitemstring(1, 'administracion')
	st_musaat_datos.superficie = dw_1.getitemnumber(1, 'sup_viv')	+ dw_1.getitemnumber(1, 'sup_otros') + dw_1.getitemnumber(1, 'sup_garage')
	st_musaat_datos.volumen = dw_1.getitemnumber(1, 'volumen')
	st_musaat_datos.colindantes2m = dw_1.getitemstring(1, 'colindantes2m')
	st_musaat_datos.cod_colegio = dw_1.getitemstring(1, 'cod_colegio_dest')
	
	st_musaat_datos.recuperar = false
	
	if f_es_vacio(st_musaat_datos.tipo_act) then continue
	
	// Suma de los % de los colegiados
	/*for j = 1 to dw_colegiados.rowcount()
		suma_porc +=  dw_colegiados.getitemnumber(j, 'porcen_a')	
	next*/
	suma_porc =  dw_1.getitemnumber(1, 'porcen_a')	
	
		porc_col =  dw_1.getitemnumber(1, 'porcen_a')	
		id_col = dw_1.getitemstring(1, 'id_col')
		if lower(dw_1.describe("funcionario.name")) = 'funcionario' then st_musaat_datos.funcionario = dw_1.getitemString(1, 'funcionario')
	//	if isnull(suma_porc) or suma_porc = 0 then exit
	//	porc_col_real = porc_col / suma_porc * 100	
		st_musaat_datos.porcentaje = porc_col
		st_musaat_datos.id_col = id_col
		if f_colegiado_tipopersona(id_col) = 'S' then	
			f_musaat_calcula_prima_sociedad(st_musaat_datos)
			musaat = st_musaat_datos.prima_comp	
		else
			f_musaat_calcula_prima(st_musaat_datos)	
			musaat = st_musaat_datos.prima_comp		
		end if
	if isnull(musaat) then musaat = 0
	
	// El control de calidad (31,32,33) no paga prima complementaria si el colegiado realiza la direcci$$HEX1$$f300$$ENDHEX$$n(11,13,14,16,17)
	string fase1, fase2, fase3	
	if LeftA(st_musaat_datos.tipo_act,1) = '3' then 
		fase1=dw_1.getitemstring(1, 'fase_1')
		fase2=dw_1.getitemstring(1, 'fase_2')
		fase3=dw_1.getitemstring(1, 'fase_3')
		IF fase1 = '11' or fase1='13' or fase1='14' or fase1='16' or fase1= '17' or fase2 = '11' or fase2='13' or fase2='14' or fase2='16' or fase2= '17' or &
			+ fase3 = '11' or fase3='13' or fase3='14' or fase3='16' or fase3= '17' then musaat = 0
	end if
	
	
	if musaat > 0 then
		//Comprobar si ya se ha calculado los DV anteriormente
		long fila_musaat
		double musaat_ant
		
		fila_insertada = this.event pfc_addrow()
		if fila_insertada > 0 then
			this.setitem(fila_insertada, 'tipo_actuacion', st_musaat_datos.tipo_act)
			this.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.musaat_variable)
			st_csi_articulos_servicios.codigo = g_codigos_conceptos.musaat_variable
			if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
				st_csi_articulos_servicios.t_iva = g_t_iva_defecto
			end if
			this.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
			this.setitem(fila_insertada, 'cuantia_colegiado', musaat )
			this.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(musaat, st_csi_articulos_servicios.t_iva ))
			
			formula_mussat += 'MUSAAT ('+string(ind)+') = ' + st_musaat_datos.formula + '~n'
			formula_desarrollo_mussat += 'MUSAAT ('+string(ind)+') = ' + st_musaat_datos.desarrollo +'~n'
		end if
	end if
	dw_resumen_por_act.setitem(ind, 'formula', 'MUSAAT ('+string(ind)+') = ' + st_musaat_datos.formula )
	dw_resumen_por_act.setitem(ind, 'desarrollo', 'MUSAAT ('+string(ind)+') = ' + st_musaat_datos.desarrollo)		
next



// Mostramos la formula y el desarrollo aplicados en el calculo de musaat
formula_actual=dw_resumen.GetItemSTring(1,'formula')
desarrollo_actual=dw_resumen.GetItemSTring(1,'desarrollo')

if IsNull(formula_actual) then 
	formula_actual=""
else
	formula_actual+='~n'
end if

if IsNull(desarrollo_actual) then 
	desarrollo_actual=""
else
	desarrollo_actual+='~n'
end if

formula_actual +=formula_mussat
desarrollo_actual += formula_desarrollo_mussat

dw_resumen.SetItem(1,'formula',formula_actual)
dw_resumen.SetItem(1,'desarrollo',desarrollo_actual)		
		
			

this.Sort()
this.GroupCalc()

end event

event constructor;call super::constructor;this.object.t_4.visible = false
this.object.descripcion.visible = false
end event

event itemchanged;call super::itemchanged;integer i
double porcen
string t_iva

t_iva=this.getitemstring(row,'t_iva')
SELECT csi_t_iva.porcent INTO :porcen  FROM csi_t_iva WHERE csi_t_iva.t_iva = :t_iva ;

choose case dwo.name
//	case 'tipo_informe'
//		SELECT csi_articulos_servicios.t_iva INTO :t_iva  FROM csi_articulos_servicios  
//	   WHERE ( csi_articulos_servicios.codigo = :data ) AND ( csi_articulos_servicios.colegio = :g_colegio ) ; 
//		this.setitem(row,'t_iva',t_iva)			
	case 't_iva'
		SELECT csi_t_iva.porcent INTO :porcen  FROM csi_t_iva WHERE csi_t_iva.t_iva = :data ;
      this.setitem(row, 'impuesto_cliente',f_redondea(this.getitemnumber(row,'cuantia_cliente')*porcen/100))    
		this.setitem(row, 'impuesto_colegiado',f_redondea(this.getitemnumber(row,'cuantia_colegiado')*porcen/100))  
//	case 'cuantia_cliente'
//		this.setitem(row, 'impuesto_cliente',f_redondea(double(data)*porcen/100))   
	case 'cuantia_colegiado'	
		this.setitem(row, 'impuesto_colegiado',f_redondea(double(data)*porcen/100))  
end choose
	
end event

type cb_1 from commandbutton within w_calculo_tarifas
integer x = 46
integer y = 2760
integer width = 498
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Calcular &Gastos"
end type

event clicked;//dw_colegiados.AcceptText()

dw_1.AcceptText()
Setpointer(HourGlass!)
dw_descuentos.Reset()
dw_resumen.Reset()
dw_resumen.insertrow(0)

dw_descuentos.event csd_calcular_descuentos()		

dw_descuentos.event csd_calcular_musaat()		



end event

type gb_1 from groupbox within w_calculo_tarifas
integer x = 32
integer width = 2880
integer height = 1280
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type cb_impr from commandbutton within w_calculo_tarifas
event csd_imprimir ( )
integer x = 562
integer y = 2760
integer width = 480
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
end type

event clicked;string n_col, tipo_act, tipo_obra, destino_obra, id_col
int i, fila, ind
	string t1,t2,t3,tipo_o
string tipo_act2,tipo_act3,n_reg,id_fase, email
n_csd_impresion_formato uo_impresion
uo_impresion=create n_csd_impresion_formato

dw_1.accepttext()
//dw_parametros.accepttext()
//dw_colegiados.accepttext()
//n_col = dw_colegiados.getitemstring(1,'n_col')
//id_col = dw_colegiados.getitemstring(1,'id_col')
n_col = dw_1.getitemstring(1,'n_col')
id_col = dw_1.getitemstring(1,'id_col')
tipo_obra = dw_1.getitemstring(1,'tipo_trabajo')
tipo_act = dw_1.getitemstring(1,'fase_1')
tipo_act2 = dw_1.getitemstring(1,'fase_2')
tipo_act3 = dw_1.getitemstring(1,'fase_3')
id_fase = dw_1.GetItemString(1,'id_fase')

select n_registro into :n_reg from fases where id_fase=:id_fase;
select email into :email from colegiados where id_colegiado=:id_col;


dw_imprimir_ficha.reset()



for i=1 to dw_descuentos.rowcount()
	
	fila = dw_imprimir_ficha.insertrow(0)
	
	dw_imprimir_ficha.setitem(fila,'colegiado',n_col + ' - ' + f_colegiado_nombre_apellido(id_col))
	dw_imprimir_ficha.setitem(fila,'participacion',dw_1.getitemnumber(1, 'porcen_a'))
	

	t1=tipo_act + ' - ' + f_dame_desc_tipo_actuacion(tipo_act)
	t2=tipo_act2 + ' - ' + f_dame_desc_tipo_actuacion(tipo_act2)
	t3=tipo_act3 + ' - ' + f_dame_desc_tipo_actuacion(tipo_act3)
	tipo_o=tipo_obra  + ' - ' + f_dame_desc_tipo_obra(tipo_obra) 
	dw_imprimir_ficha.setitem(fila,'tipoact',t1)
	dw_imprimir_ficha.setitem(fila,'tipoact2',t2)
	dw_imprimir_ficha.setitem(fila,'tipoact3',t3)		
	if lower(dw_imprimir_ficha.describe("tipoobra.name")) = 'tipoobra' then
		dw_imprimir_ficha.setitem(fila,'tipoobra',tipo_o)
	end if
	if lower(dw_imprimir_ficha.describe("codigo_tipo_obra.name")) = 'codigo_tipo_obra' then
		dw_imprimir_ficha.setitem(fila,'codigo_tipo_obra',tipo_obra)
	end if
	if lower(dw_imprimir_ficha.describe("tipo_reforma.name")) = 'tipo_reforma' then
		dw_imprimir_ficha.setitem(fila,'tipo_reforma', dw_1.getitemstring(1,'tipo_reforma'))
	end if
	//dw_imprimir_ficha.setitem(fila,'tipoobra',tipo_o)
	dw_imprimir_ficha.setitem(fila,'destino', dw_1.getitemstring(1,'trabajo'))
	dw_imprimir_ficha.setitem(fila,'destino_int', dw_1.getitemstring(1,'destino_int'))
//		dw_imprimir_ficha.setitem(fila,'tipo_gestion', dw_1.getitemstring(1,'tipo_gestion'))
	if lower(dw_imprimir_ficha.describe("administracion.name")) = 'administracion' then	 dw_imprimir_ficha.setitem(fila,'administracion',dw_1.getitemstring(1,'administracion'))
	dw_imprimir_ficha.setitem(fila,'f_entrada',dw_1.getitemdatetime(1,'f_entrada'))
	dw_imprimir_ficha.setitem(fila,'f_calculo',dw_1.getitemdatetime(1,'f_calculo_musaat'))	
	dw_imprimir_ficha.setitem(fila,'sup_viv',dw_1.getitemnumber(1,'sup_viv'))
	dw_imprimir_ficha.setitem(fila,'sup_garaje',dw_1.getitemnumber(1,'sup_garage'))
	dw_imprimir_ficha.setitem(fila,'sup_otros',dw_1.getitemnumber(1,'sup_otros'))		
	dw_imprimir_ficha.setitem(fila,'superficie',dw_1.getitemnumber(1,'superficie'))
	dw_imprimir_ficha.setitem(fila,'volumen',dw_1.getitemnumber(1,'volumen'))
	dw_imprimir_ficha.setitem(fila,'altura',dw_1.getitemnumber(1,'altura'))
	if lower(dw_imprimir_ficha.describe("colindantes.name")) = 'colindantes' then dw_imprimir_ficha.setitem(fila,'colindantes',dw_1.getitemstring(1,'colindantes2m'))
	if lower(dw_imprimir_ficha.describe("mantenimiento.name")) = 'mantenimiento' then dw_imprimir_ficha.setitem(fila,'mantenimiento',dw_1.getitemstring(1,'mantenimiento'))
//	dw_imprimir_ficha.setitem(fila,'t_terreno',dw_parametros.getitemstring(1,'t_terreno'))
	dw_imprimir_ficha.setitem(fila,'presupuesto', dw_1.getitemnumber(1,'pem'))
	dw_imprimir_ficha.setitem(fila,'num_viv', dw_1.getitemnumber(1,'num_viv'))
	
	dw_imprimir_ficha.setitem(fila,'cobertura',f_musaat_dame_cobertura_src(id_col))
	dw_imprimir_ficha.setitem(fila,'bonusmalus',f_musaat_dame_coef_cm(id_col))

	dw_imprimir_ficha.setitem(fila,'act_tipo_desc',dw_descuentos.GetItemString(i,'tipo_actuacion'))		
	dw_imprimir_ficha.setitem(fila,'tipo_desc',dw_descuentos.getitemstring(i,'tipo_informe'))
		
	dw_imprimir_ficha.setitem(fila,'iva',dw_descuentos.getitemstring(i,'t_iva'))
	dw_imprimir_ficha.setitem(fila,'base',dw_descuentos.getitemnumber(i,'cuantia_colegiado'))
	dw_imprimir_ficha.setitem(fila,'impuesto',dw_descuentos.getitemnumber(i,'impuesto_colegiado'))		

	dw_imprimir_ficha.setitem(fila,'formula',dw_resumen.getitemString(1,'formula'))
	dw_imprimir_ficha.setitem(fila,'desarrollo',dw_resumen.getitemstring(1,'desarrollo'))
next
if dw_imprimir_ficha.rowcount()>0 then 
	dw_imprimir_ficha.groupcalc()

	uo_impresion.copias=1
	uo_impresion.generar_registro='X' //g_formato_impresion.generar_registro
	uo_impresion.tipo_receptor='O'
	uo_impresion.asunto_email='Enviament del c$$HEX1$$e000$$ENDHEX$$lcul de despeses a data '+string(today(),'dd/mm/yyyy')
	uo_impresion.asunto_registro='Enviament del c$$HEX1$$e000$$ENDHEX$$lcul de despeses a data '+string(today(),'dd/mm/yyyy')
	uo_impresion.texto_email='C$$HEX1$$e000$$ENDHEX$$lcul de DRETS i MUSAAT corresponent a:'+'~n'
	if not(f_es_vacio(t1)) then uo_impresion.texto_email+='Tipus Actuaci$$HEX2$$f3002000$$ENDHEX$$1:'+t1+' ~n'
	if not(f_es_vacio(t2)) then uo_impresion.texto_email+='Tipus Actuaci$$HEX2$$f3002000$$ENDHEX$$2:'+t2+' ~n'
	if not(f_es_vacio(t3)) then uo_impresion.texto_email+='Tipus Actuaci$$HEX2$$f3002000$$ENDHEX$$3:'+t3+' ~n'
	if not(f_es_vacio(tipo_o)) then uo_impresion.texto_email+='Tipus Obra:'+tipo_o

	uo_impresion.receptor=''
	uo_impresion.serie='SCOR'
	uo_impresion.tipo_doc='CG'
	uo_impresion.dw=dw_imprimir_ficha
	uo_impresion.visualizar_web = 'N'
	uo_impresion.email = 'N'
	uo_impresion.pdf= 'N'
	uo_impresion.papel='S'
	uo_impresion.referencia=id_fase
	uo_impresion.ruta_automatica=false
	uo_impresion.ruta_relativa1=''
	uo_impresion.ruta_relativa2=string(year(today()))
	uo_impresion.ruta_relativa3=n_reg
	uo_impresion.nombre="despeses"
	uo_impresion.direccion_email=email
	if uo_impresion.f_opciones_impresion()>0 then uo_impresion.f_impresion()
	//dw_imprimir_ficha.print()
end if

end event

type dw_imprimir_ficha from u_dw within w_calculo_tarifas
boolean visible = false
integer x = 183
integer y = 1732
integer width = 302
integer height = 232
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_fases_calculo_gastos_imprimir_tg"
boolean hscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event doubleclicked;call super::doubleclicked;this.visible = false
end event

type tab_1 from tab within w_calculo_tarifas
event create ( )
event destroy ( )
integer x = 64
integer y = 44
integer width = 2816
integer height = 1224
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2779
integer height = 1108
long backcolor = 79741120
string text = "Datos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_parametros dw_parametros
dw_1 dw_1
end type

on tabpage_1.create
this.dw_parametros=create dw_parametros
this.dw_1=create dw_1
this.Control[]={this.dw_parametros,&
this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_parametros)
destroy(this.dw_1)
end on

type dw_parametros from u_dw within tabpage_1
integer x = 2194
integer y = 88
integer width = 430
integer height = 336
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_fases_usos_apas"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_1 from u_dw within tabpage_1
integer y = 4
integer width = 2080
integer height = 1104
integer taborder = 10
string dataobject = "d_calculo_tarifas"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event buttonclicked;call super::buttonclicked;string id_colegiado,col,alta_baja,mensaje,sit
int i
choose case dwo.name
	case 'cb_busqueda_colegiados'
	g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
	g_busqueda.dw="d_lista_busqueda_colegiados"
	
	id_colegiado=f_busqueda_colegiados()
	if f_es_vacio(id_colegiado) then return
	this.setitem(row,'id_col',id_colegiado)
	select n_colegiado,situacion into :col,:sit from colegiados where id_colegiado = :id_colegiado;
	this.setitem(row,'n_col',col)

// SCP-2048 Se inicializa a 'N' El usuario deber$$HEX2$$e1002000$$ENDHEX$$seleccionar manualmente 'Ejerce como funcionario'
//	if sit='F' then
//		if lower(this.describe("funcionario.name")) = 'funcionario' then this.SetItem(row,'funcionario','S')
//	else
//		if lower(this.describe("funcionario.name")) = 'funcionario' then this.SetItem(row,'funcionario','N')
//	end if
	if lower(this.describe("funcionario.name")) = 'funcionario' then this.SetItem(row,'funcionario','N') 
	if this.rowcount() > 1 then
		for i=1 to this.rowcount()
			if this.getitemstring(i,'id_col')=id_colegiado and i <> row then
				MessageBox(g_titulo,'No puede haber un colegiado duplicado.')
				return -1
	//			i=this.rowcount() + 1			
	//			this.triggerevent ("csd_borrar_cod")
	//			this.postevent ("pfc_addrow")
	//		
			end if
		next
	end if
	//this.Event Trigger validar_colegiado(id_colegiado)
	mensaje=f_control_de_incidencias('C',id_colegiado)
end choose

end event

event itemchanged;call super::itemchanged;st_control_eventos c_evento
int    i
string alta_baja,id,empresa,id_col,id_fase,mensaje,cobertura
double suma=0,total_hon,por,suma_porcentajes_col,i_porcen
boolean valido

choose case dwo.name
	case 'n_col'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_col',f_colegiado_id_col(data))
		// SCP-2048 Se inicializa a 'N' El usuario deber$$HEX2$$e1002000$$ENDHEX$$seleccionar manualmente 'Ejerce como funcionario'
//	select situacion into :sit from colegiados where id_colegiado = :id_col;
//
//		if sit='F' then
//			if lower(this.describe("funcionario.name")) = 'funcionario' then this.SetItem(row,'funcionario','S')
//		else
//			if lower(this.describe("funcionario.name")) = 'funcionario' then this.SetItem(row,'funcionario','N')
//		end if
		if lower(this.describe("funcionario.name")) = 'funcionario' then this.SetItem(row,'funcionario','N')
		
		// Si es asociaci$$HEX1$$f300$$ENDHEX$$n
		// Borro para que no quede basura en la bd
			
		for i = dw_asociados.rowcount() to 1 step -1
			dw_asociados.deleterow(i)
		next
		if f_colegiado_tipopersona(f_colegiado_id_col(data)) = 'S' then	
//			dw_asociados.visible = true
			datastore ds_colegiados_asociados
			ds_colegiados_asociados = create datastore						
			// Modificado David 28/02/2006 - Obtenemos el porcentaje real, quitando los posibles asociados no colegiados
			ds_colegiados_asociados.dataobject = 'ds_colegiados_personas' //'d_colegiados_personas'
			ds_colegiados_asociados.settransobject(sqlca)								
			ds_colegiados_asociados.retrieve(f_colegiado_id_col(data))
			//dw_colegiados.setredraw(false)
			for i = 1 to ds_colegiados_asociados.rowcount()
				dw_asociados.event pfc_addrow()
				// Modificado David 28/02/2006 - Obtenemos el porcentaje real, quitando los posibles asociados no colegiados
				dw_asociados.setitem(i, 'porcent', ds_colegiados_asociados.getitemnumber(i, 'porc_col_real')) //'porcent'))
				dw_asociados.setitem(i, 'id_col_per', ds_colegiados_asociados.getitemstring(i, 'id_col_per'))								
			next
			dw_asociados.setredraw(true)
		//	dw_colegiados.setredraw(true)
			destroy ds_colegiados_asociados			
		else
			dw_asociados.visible = false
		end if
			
		SELECT musaat.src_cober INTO :cobertura FROM musaat WHERE musaat.id_col = :id_col ;
		if not isnull(cobertura) then this.setitem(row,'cobertura',cobertura)

	
	case 'porcen_a'
		i_porcen=getitemnumber(this.getrow(),'porcen_a')
		this.postevent("csd_porcentajes")
		//this.PostEvent('comprobar_porcentajes')
	//	this.PostEvent('comprueba_integridad_minutas')
		if g_suma_porcentajes_col > 100 then
			messagebox(g_titulo,'La participaci$$HEX1$$f300$$ENDHEX$$n de los colegiados es mayor de 100.')
		end if
	
	case 'funcionario'
		if data = 'S' then
			messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_marcar_col_funcionario','$$HEX3$$a100a100a100$$ENDHEX$$Atenci$$HEX1$$f300$$ENDHEX$$n!!! : Marcar este colegiado como funcionario supondr$$HEX2$$e1002000$$ENDHEX$$que no se le cobrar$$HEX2$$e1002000$$ENDHEX$$MUSAAT en obras oficiales'))
		end if		
		
	case else
end choose


end event

type dw_asociados from u_dw within w_calculo_tarifas
boolean visible = false
integer x = 2432
integer y = 700
integer width = 1431
integer height = 384
integer taborder = 0
string dataobject = "d_fases_colegiados_asociados"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event pfc_addrow;call super::pfc_addrow;this.setitem(this.getrow(), 'id_col_aso', dw_1.getitemstring(dw_1.getrow(), 'id_col'))
this.setitem(this.getrow(), 'id_fase', dw_1.getitemstring(dw_1.getrow(), 'id_fase'))

return 1
end event

event constructor;this.getchild('id_col_per',i_dwc_colegiados_asociados)

i_dwc_colegiados_asociados.settransobject(sqlca)
i_dwc_colegiados_asociados.InsertRow (0)
end event

type dw_resumen from u_dw within w_calculo_tarifas
event csd_calcula_honos_teo ( )
integer x = 128
integer y = 2052
integer width = 2743
integer height = 624
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_calculo_gastos_musaat_tg"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_calcula_honos_teo();//st_cip_datos st_cip_datos
//double hon_teor = 0
//
//this.insertrow(0)
//// cargo la estructura
//st_cip_datos.tipo_act = dw_1.getitemstring(1, 'fase')
//st_cip_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_trabajo')
//st_cip_datos.superficie = dw_parametros.getitemnumber(1, 'superficie')
//st_cip_datos.pem = dw_parametros.getitemnumber(1, 'pem')
//st_cip_datos.admon = dw_1.getitemstring(1, 'administracion')
//st_cip_datos.volumen = dw_parametros.GetItemNumber(1,'volumen')
//st_cip_datos.altura = dw_parametros.GetItemNumber(1,'altura')
//st_cip_datos.colindantes = dw_parametros.GetItemString(1,'colindantes')
//st_cip_datos.tipo_gestion = dw_1.GetItemString(1,'tipo_gestion')
//
//st_cip_datos.long_per = dw_parametros.GetItemNumber(1,'longitud_per')
//st_cip_datos.vol_tierras = dw_parametros.GetItemNumber(1,'volumen_tierras')
//st_cip_datos.valor_terreno = dw_parametros.getitemnumber(1, 'valor_terreno')	
//st_cip_datos.valor_tasacion = dw_parametros.getitemnumber(1, 'valor_tasacion')
//st_cip_datos.valoracion_estim = dw_parametros.getitemnumber(1, 'valoracion_estim')
//st_cip_datos.estructura = dw_parametros.GetItemString(1,'estructura')
//st_cip_datos.t_medicion = dw_parametros.GetItemString(1,'t_medicion')
//st_cip_datos.replan_deslin = dw_parametros.GetItemString(1,'replan_deslin')
//st_cip_datos.t_terreno = dw_parametros.GetItemString(1,'t_terreno')
//
////// el 100%
//st_cip_datos.porcentaje = 100 
////// calculo
//f_calcular_hon_teor(st_cip_datos)
//hon_teor = st_cip_datos.hon_teor
//if isnull(hon_teor) then hon_teor = 0
//
//this.setitem(1, 'honos_teor', hon_teor)
//
end event

type dw_resumen_por_act from u_dw within w_calculo_tarifas
event csd_calcula_honos_teo ( )
boolean visible = false
integer x = 2569
integer y = 2676
integer width = 320
integer height = 192
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_calculo_gastos_musaat_tg"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_calcula_honos_teo();//st_cip_datos st_cip_datos
//double hon_teor = 0
//
//this.insertrow(0)
//// cargo la estructura
//st_cip_datos.tipo_act = dw_1.getitemstring(1, 'fase')
//st_cip_datos.tipo_obra = dw_1.getitemstring(1, 'tipo_trabajo')
//st_cip_datos.superficie = dw_parametros.getitemnumber(1, 'superficie')
//st_cip_datos.pem = dw_parametros.getitemnumber(1, 'pem')
//st_cip_datos.admon = dw_1.getitemstring(1, 'administracion')
//st_cip_datos.volumen = dw_parametros.GetItemNumber(1,'volumen')
//st_cip_datos.altura = dw_parametros.GetItemNumber(1,'altura')
//st_cip_datos.colindantes = dw_parametros.GetItemString(1,'colindantes')
//st_cip_datos.tipo_gestion = dw_1.GetItemString(1,'tipo_gestion')
//
//st_cip_datos.long_per = dw_parametros.GetItemNumber(1,'longitud_per')
//st_cip_datos.vol_tierras = dw_parametros.GetItemNumber(1,'volumen_tierras')
//st_cip_datos.valor_terreno = dw_parametros.getitemnumber(1, 'valor_terreno')	
//st_cip_datos.valor_tasacion = dw_parametros.getitemnumber(1, 'valor_tasacion')
//st_cip_datos.valoracion_estim = dw_parametros.getitemnumber(1, 'valoracion_estim')
//st_cip_datos.estructura = dw_parametros.GetItemString(1,'estructura')
//st_cip_datos.t_medicion = dw_parametros.GetItemString(1,'t_medicion')
//st_cip_datos.replan_deslin = dw_parametros.GetItemString(1,'replan_deslin')
//st_cip_datos.t_terreno = dw_parametros.GetItemString(1,'t_terreno')
//
////// el 100%
//st_cip_datos.porcentaje = 100 
////// calculo
//f_calcular_hon_teor(st_cip_datos)
//hon_teor = st_cip_datos.hon_teor
//if isnull(hon_teor) then hon_teor = 0
//
//this.setitem(1, 'honos_teor', hon_teor)
//
end event

type cb_limpiar from commandbutton within w_calculo_tarifas
integer x = 1527
integer y = 2760
integer width = 480
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Limpiar C$$HEX1$$e100$$ENDHEX$$lculo"
end type

event clicked;/*dw_1.SetItem(1,'fase_1','')
dw_1.SetItem(1,'fase_2','')
dw_1.SetItem(1,'fase_3','')
dw_1.SetItem(1,'tipo_trabajo','')
dw_1.SetItem(1,'trabajo','')
dw_1.SetItem(1,'destino_int','')
dw_1.SetItem(1,'n_col','')
dw_1.SetItem(1,'id_col','')
dw_1.SetItem(1,'porcen_a',0)
dw_1.SetItem(1,'sup_viv',0)
dw_1.SetItem(1,'sup_garage',0)
dw_1.SetItem(1,'sup_otros',0)
dw_1.SetItem(1,'num_viv',0)
dw_1.SetItem(1,'pem',0)
dw_1.SetItem(1,'volumen',0)
dw_1.SetItem(1,'altura',0)
dw_1.SetItem(1,'tipo_reforma',0)
*/
dw_1.reset()
dw_1.insertrow(0)
dw_1.setitem(1, 'f_entrada', date(datetime(today())))
dw_1.setitem(1, 'f_calculo_musaat', date(datetime(today())))
dw_1.setitem(1,'porcen_a', 100)
dw_1.setitem(1,'id_tramite',i_tramite_defecto)
dw_1.setitem(1,'cod_colegio_dest',g_colegio)
dw_descuentos.Reset()
dw_resumen.reset()
dw_resumen.insertrow(0)


end event

type gb_2 from groupbox within w_calculo_tarifas
integer x = 37
integer y = 1248
integer width = 2875
integer height = 792
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_4 from groupbox within w_calculo_tarifas
integer x = 41
integer y = 2024
integer width = 2875
integer height = 672
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

