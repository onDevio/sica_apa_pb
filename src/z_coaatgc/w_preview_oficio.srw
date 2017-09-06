HA$PBExportHeader$w_preview_oficio.srw
forward
global type w_preview_oficio from w_response
end type
type dw_1 from u_dw within w_preview_oficio
end type
type cb_1 from commandbutton within w_preview_oficio
end type
type cb_2 from commandbutton within w_preview_oficio
end type
end forward

global type w_preview_oficio from w_response
integer width = 3529
integer height = 2492
string title = "Previsualizaci$$HEX1$$f300$$ENDHEX$$n"
event csd_rellenar_oficio ( )
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_preview_oficio w_preview_oficio

type variables
st_preview ist_preview
w_fases_detalle iw_fases
string i_id_fase
end variables

event csd_rellenar_oficio();// EVENTO PARA RELLENAR TODOS LOS DATOS NECESARIOS PARA OBTENER EL OFICIO
string sl_total_colegiados, sl_cliente, sl_total_clientes, sl_fecha, pobla, sl_num_contrato, sl_archivo, sl_arquitectos
string tipo_act, cod_prov_prof, colegiado, id_col, id_fases_col, n_col, apell, nomb, nif, daf, paf, apellidos_arq
string descripcion, obs, t_via, nomvia, numero, des_via, emplazamiento, poblacion, tipo_via_prof, nom_via_prof
string cod_pob_prof, id_cliente, sl_autores, id_fase
datetime ldtt_hoy, f_visado
date ldt_hoy
long i, cols

iw_fases = g_detalle_fases

// Lo primero es obtener los datos del contrato para saber si corresponde imprimir el oficio
id_fase = iw_fases.dw_1.getItemstring(1,'id_fase')
sl_num_contrato = iw_fases.dw_1.getItemstring(1,'n_expedi')
descripcion = iw_fases.dw_1.getItemstring(1,'descripcion')
obs = iw_fases.dw_1.getItemstring(1,'observaciones')
t_via = iw_fases.dw_1.getItemstring(1,'tipo_via_emplazamiento')
nomvia = iw_fases.dw_1.getItemstring(1,'emplazamiento')
numero = iw_fases.dw_1.getItemstring(1,'n_calle')
poblacion = iw_fases.dw_1.getItemstring(1,'poblacion')
tipo_act = iw_fases.dw_1.getItemstring(1,'fase')
sl_archivo = iw_fases.dw_fases_datos_exp.getItemstring(1,'archivo_exp')
f_visado = iw_fases.dw_1.getItemdatetime(1,'f_visado')
i_id_fase = id_fase

//SELECT n_expedi, descripcion, observaciones, tipo_via_emplazamiento, emplazamiento, n_calle, poblacion, fase
//into :sl_num_contrato, :descripcion, :obs, :t_via, :nomvia, :numero, :poblacion, :tipo_act
//from fases where id_fase = :id_fase;

//SELECT expedientes.archivo
//into :sl_archivo
//from expedientes, fases where expedientes.id_expedi = fases.id_expedi and  id_fase = :id_fase;

// Creamos un datastore para recuperar los colegiados del contrato
datastore ds_fases_colegiados
ds_fases_colegiados = create datastore
ds_fases_colegiados.dataobject = 'd_fases_colegiados'
ds_fases_colegiados.setFilter("renunciado<>'S'")
ds_fases_colegiados.Settransobject(SQLCA)
ds_fases_colegiados.retrieve(id_fase)

sl_total_colegiados =''
for i = 1 to ds_fases_colegiados.rowcount()
	if ( ds_fases_colegiados.getitemnumber(i,'porcen_a') > 0 ) then 
		colegiado = ''
		id_col = ds_fases_colegiados.getitemstring(i,"id_col")
		id_fases_col = ds_fases_colegiados.getitemstring(i, 'id_fases_colegiados')
	
		if f_colegiado_tipopersona(id_col) <> 'S' then
			select n_colegiado,apellidos,nombre,nif,domicilio_activo,poblacion_activa 
			into :n_col, :apell, :nomb, :nif, :daf, :paf
			from colegiados where id_colegiado=:id_col;
			
			SELECT tipo_via, nom_via, cod_pob, cod_prov 
			into :tipo_via_prof, :nom_via_prof, :cod_pob_prof, :cod_prov_prof 
			from domicilios where id_colegiado = :id_col and fiscal = 'S';
		
			if not f_es_vacio(nom_via_prof) then
	//			daf= f_obtener_domicilio_activo(tipo_via_prof,nom_via_prof)
	//			paf= f_obtener_poblacion_activa(cod_pob_prof, cod_prov_prof)
				daf = f_domicilio_fiscal (id_col)
				paf = f_poblacion_fiscal (id_col)
			end if
			
			if not f_es_vacio(n_col) then colegiado += n_col + ' - '
			if f_es_vacio(nomb) then colegiado += apell else colegiado += nomb + ' ' + apell		
			if not f_es_vacio(nif) then colegiado += ', N.I.F. ' +  nif
			if not f_es_vacio(daf) then colegiado += '~r' + daf
			if not f_es_vacio(paf) then colegiado += ' - ' + paf + cr
			if ds_fases_colegiados.getitemstring(i,"tipo_a") = 'S' then sl_autores += colegiado 
		else 
			// Creamos un dastastore para obtener todos los colegiados de esa sociedad
			datastore ds_cols_soc
			ds_cols_soc = create datastore
			ds_cols_soc.dataobject = 'ds_fases_colegiados_asociados'
			ds_cols_soc.settransobject(sqlca)
			ds_cols_soc.retrieve(id_fases_col)
	
			colegiado = ''
			for cols = 1 to ds_cols_soc.rowcount()
				if ( ds_cols_soc.getitemnumber(i,'porcent') > 0 ) then 
					
					id_col = ds_cols_soc.getitemstring(cols,"id_col_per")
					select n_colegiado,apellidos,nombre,nif,domicilio_activo,poblacion_activa 
						into :n_col, :apell, :nomb, :nif, :daf, :paf
						from colegiados where id_colegiado=:id_col;
					
					SELECT tipo_via, nom_via, cod_pob, cod_prov 
					into :tipo_via_prof, :nom_via_prof, :cod_pob_prof, :cod_prov_prof 
					from domicilios 
					where id_colegiado = :id_col and fiscal = 'S';
				
					if not f_es_vacio(nom_via_prof) then
		//				daf= f_obtener_domicilio_activo(tipo_via_prof,nom_via_prof)
		//				paf= f_obtener_poblacion_activa(cod_pob_prof, cod_prov_prof)
						daf = f_domicilio_fiscal (id_col)
						paf = f_poblacion_fiscal (id_col)
					end if
					
					if LenA(colegiado)>0 then colegiado += ', ' 
					if not f_es_vacio(n_col) then colegiado += n_col + ' - '
					if f_es_vacio(nomb) then colegiado += apell else colegiado += nomb +	' ' + apell
					if not f_es_vacio(nif) then colegiado += ', N.I.F. ' +  nif
					if not f_es_vacio(daf) then colegiado += '~r' + daf
					if not f_es_vacio(paf) then colegiado += ' - ' + paf + cr
				end if	
			next
			// Destruimos el datastore creado
			destroy ds_cols_soc
		end if
	//	if len(sl_total_colegiados)>0 then sl_total_colegiados += ', ' else sl_total_colegiados = ' - Don/Do$$HEX1$$f100$$ENDHEX$$a  '
		sl_total_colegiados += colegiado
	end if	
next
// Destruimos le datastore 
destroy ds_fases_colegiados


// Hay que hacer el recorrido de los clientes buscando los promotores
datastore ds_fases_promotores
ds_fases_promotores = create datastore
ds_fases_promotores.dataobject = 'd_fases_promotores'
ds_fases_promotores.SetTransObject(SQLCA)
ds_fases_promotores.retrieve(id_fase)

for i = 1 to ds_fases_promotores.RowCount()
	if (ds_fases_promotores.getitemstring(i,"promotor") = 'S') and (ds_fases_promotores.getitemnumber(i,'porcen') > 0) then 
		sl_cliente = ''
//		string id_representante
//		id_representante = ds_fases_promotores.getitemstring(i,"id_representante")
//		if not f_es_vacio(id_representante) then
//			sl_cliente = f_dame_cliente ( id_representante )
//			nif = ds_fases_promotores.getitemstring(i,"nif_representante")
//			if not f_es_vacio(nif) then sl_cliente += ' con N.I.F.  ' + nif 
//			sl_cliente += " en representaci$$HEX1$$f300$$ENDHEX$$n de "
//		end if		
		
		
		id_cliente = ds_fases_promotores.getitemstring(i,"id_cliente")
		sl_cliente += f_dame_cliente(id_cliente)
		nif = f_dame_nif(id_cliente)
		 
//		if len(sl_total_clientes) = 0 then sl_total_clientes = "Sr.  "
		sl_total_clientes += sl_cliente
		if not f_es_vacio(nif) then sl_total_clientes += ', C.I.F '  + nif
		sl_total_clientes += '~r' + f_dame_domicilio(id_cliente)
		sl_total_clientes += ' - ' + f_retorna_poblacion (id_cliente)
		sl_total_clientes += cr
	end if
next

// Destruimos el datastore
destroy ds_fases_promotores


// Obtenemos los arquitectos participantes en la obra
datastore ds_fases_arquitectos
ds_fases_arquitectos = create datastore
ds_fases_arquitectos.dataobject = 'd_fases_arquitectos'
ds_fases_arquitectos.settransobject (SQLCA)
ds_fases_arquitectos.retrieve(id_fase)
// REcorremos los arquitectos del contrato
sl_arquitectos=''
FOR i = 1 TO ds_fases_arquitectos.RowCount()
	if ds_fases_arquitectos.GetItemString(i, 'tipo_a')='S' then
		apellidos_arq = ds_fases_arquitectos.GetItemString(i, 'apellidos')
		if not f_es_vacio(ds_fases_arquitectos.GetItemString(i, 'nombre')) then apellidos_arq += ', '+ds_fases_arquitectos.GetItemString(i, 'nombre')
//		if len(sl_arquitectos)=0 then  sl_arquitectos += "Sr./s "
		sl_arquitectos += apellidos_arq + cr
	end if
NEXT
// Destruimos el datastore
destroy ds_fases_arquitectos


// Construimos la direccion
des_via = f_dame_desc_tipo_via(t_via)
emplazamiento = ''
if not f_es_vacio(des_via) then emplazamiento += des_via +" "
if not f_es_vacio(nomvia) then emplazamiento += nomvia +" "
if not f_es_vacio(numero) then emplazamiento += numero +" "
pobla = f_poblacion_descripcion(poblacion)

// Construimos la fecha que aparecer$$HEX2$$e1002000$$ENDHEX$$en el escrito
ldtt_hoy =datetime(today(),now())
ldt_hoy  = today()
//sl_fecha = 'Las Palmas de Gran Canaria a ' + string(day(ldt_hoy)) + ' de ' + lower(f_obtener_mes (ldtt_hoy)) + ' de ' + string(year(ldt_hoy))
sl_fecha = string(f_visado, "dd/mm/yyyy")

// Colocamos los datos obtenidos en el datastore para su impresion
dw_1.insertrow(0)
dw_1.setitem(1,"n_contrato",sl_num_contrato)
dw_1.setitem(1,"archivo",sl_archivo)
dw_1.setitem(1,"colegiado",LeftA(sl_total_colegiados,LenA(sl_total_colegiados)-2))
dw_1.setitem(1,"cliente",LeftA(sl_total_clientes,LenA(sl_total_clientes)-2))  
dw_1.setitem(1,"emplazamiento",emplazamiento)  
dw_1.setitem(1,"descripcion",descripcion)
dw_1.setitem(1,"alcalde",pobla)
dw_1.setitem(1,"fecha",sl_fecha)
dw_1.setitem(1,"localidad",pobla)
dw_1.setitem(1,"arquitectos",LeftA(sl_arquitectos,LenA(sl_arquitectos)-2))
dw_1.setitem(1,"arquitectos_ess",LeftA(sl_arquitectos,LenA(sl_arquitectos)-2))
dw_1.setitem(1,"tipo_actuacion",tipo_act)

end event

on w_preview_oficio.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_preview_oficio.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;event csd_rellenar_oficio()

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_preview_oficio
integer x = 3154
integer y = 1024
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_preview_oficio
integer x = 3154
integer y = 896
end type

type dw_1 from u_dw within w_preview_oficio
integer x = 37
integer y = 32
integer width = 3429
integer height = 2156
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_oficio_gc"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;//of_setprintpreview(true)
end event

type cb_1 from commandbutton within w_preview_oficio
integer x = 1335
integer y = 2232
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
end type

event clicked;dw_1.accepttext()
//dw_1.print()

/*if g_colegio = 'COAATGU' then
	// Eligen n$$HEX2$$ba002000$$ENDHEX$$de copias
	int i
	string  sl_copias
	openwithparm(w_n_copias, ist_preview.modulo)
	sl_copias  = Message.StringParm
	for i=1 to long(sl_copias)
		dw_1.print()
	next
else
	dw_1.print()
end if
*/
string pobla,n_reg,fecha

pobla=dw_1.GetItemString(1,'alcalde')
fecha=dw_1.GetItemString(1,'fecha')
select n_registro into :n_reg from fases where id_fase=:i_id_fase;
n_csd_impresion_formato uo_impresion
uo_impresion=create n_csd_impresion_formato
uo_impresion.avisos=1
uo_impresion.copias=1
uo_impresion.generar_registro='N' //g_formato_impresion.generar_registro
uo_impresion.tipo_receptor='O'
uo_impresion.asunto_email='CARTA AL AYUNTAMIENTO DE '+pobla
uo_impresion.asunto_registro='CARTA AL AYUNTAMIENTO DE '+pobla
uo_impresion.receptor='AYUNTAMIENTO DE '+pobla
uo_impresion.serie='AYTO'
uo_impresion.tipo_doc='AY'
uo_impresion.dw=dw_1
uo_impresion.visualizar_web = 'N'
uo_impresion.email = 'N'
uo_impresion.pdf= 'N'
uo_impresion.papel='S'
uo_impresion.referencia=i_id_fase
uo_impresion.ruta_automatica=true
uo_impresion.ruta_relativa1=''
uo_impresion.ruta_relativa2=string(year(date(fecha)))
uo_impresion.ruta_relativa3=n_reg
uo_impresion.nombre="carta_ayuntamiento"
if uo_impresion.f_opciones_impresion()>0 then uo_impresion.f_impresion()


end event

type cb_2 from commandbutton within w_preview_oficio
integer x = 3122
integer y = 2232
integer width = 343
integer height = 92
integer taborder = 40
boolean bringtotop = true
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

