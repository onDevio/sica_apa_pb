HA$PBExportHeader$w_colegiados_impresos.srw
forward
global type w_colegiados_impresos from w_response
end type
type dw_1 from u_dw within w_colegiados_impresos
end type
type cb_1 from commandbutton within w_colegiados_impresos
end type
type st_1 from statictext within w_colegiados_impresos
end type
type cb_imprimir from commandbutton within w_colegiados_impresos
end type
type cb_imprimir_todos from commandbutton within w_colegiados_impresos
end type
type cb_preview from commandbutton within w_colegiados_impresos
end type
end forward

global type w_colegiados_impresos from w_response
integer width = 1787
integer height = 1568
string title = "Impresos Colegiales"
dw_1 dw_1
cb_1 cb_1
st_1 st_1
cb_imprimir cb_imprimir
cb_imprimir_todos cb_imprimir_todos
cb_preview cb_preview
end type
global w_colegiados_impresos w_colegiados_impresos

type variables
w_colegiados_detalle iw_colegiados
end variables

on w_colegiados_impresos.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.st_1=create st_1
this.cb_imprimir=create cb_imprimir
this.cb_imprimir_todos=create cb_imprimir_todos
this.cb_preview=create cb_preview
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_imprimir
this.Control[iCurrent+5]=this.cb_imprimir_todos
this.Control[iCurrent+6]=this.cb_preview
end on

on w_colegiados_impresos.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cb_imprimir)
destroy(this.cb_imprimir_todos)
destroy(this.cb_preview)
end on

event open;call super::open;string ventana
iw_colegiados = g_detalle_colegiados

f_centrar_ventana(this)

ventana = this.classname()
dw_1.retrieve(ventana)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_colegiados_impresos
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_colegiados_impresos
end type

type dw_1 from u_dw within w_colegiados_impresos
event csd_imprimir ( string dw,  boolean preview )
integer x = 73
integer y = 100
integer width = 1618
integer height = 1188
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_colegiados_impresos"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event csd_imprimir(string dw, boolean preview);string id_colegiado, nombre, apellidos, nif, direccion, cuenta, localidad, n_colegiado, src_n_poliza, src_cober
string correo, n_mutualista, n_consejo, cuenta_dom, banco_dom, sociedad, id_soc, telef, fax, situacion, desc_sit
string desc_banco, alta, telef2, telef3, src_alta, n_mutualista_premaat, n_acreditado, sexo, src_cia, num_soc ,ejerce
string alta_musaat, compania, alta_premaat, fecha, parrafo_1, parrafo_2, parrafo_3, escuela
datetime src_f_baja, src_cober_f_baja, fecha_colegiacion, f_alta, f_nacimiento, f_titulacion
double src_coef_cm, prima, coeficiente

datastore ds_impresion
ds_impresion = create datastore
ds_impresion.dataObject = dw
ds_impresion.insertrow(0)

// Recuperamos Datos del detalle de colegiados
id_colegiado			= iw_colegiados.dw_1.getItemstring(1,'id_colegiado')
n_colegiado				= iw_colegiados.dw_1.GetItemString(1,'n_colegiado')
nombre					= iw_colegiados.dw_1.GetItemString(1,'nombre')
apellidos				= iw_colegiados.dw_1.GetItemString(1,'apellidos')
direccion				= iw_colegiados.dw_1.GetItemString(1,'domicilio_activo')
localidad				= iw_colegiados.dw_1.GetItemString(1,'poblacion_activa')
nif						= iw_colegiados.dw_1.getitemstring(1,'nif')
n_consejo				= iw_colegiados.dw_1.GetItemString(1,'n_consejo')
correo					= iw_colegiados.tab_1.tabpage_8.tab_3.tabpage_9.dw_colegiados_cesion_datos_internet.GetItemString(1,'email')
f_alta					= iw_colegiados.dw_1.getitemdatetime(1,'f_alta')
banco_dom				= iw_colegiados.tab_1.tabpage_5.tab_2.tabpage_13.dw_colegiados_banco_cuenta.GetItemString(1,'banco_domic')
cuenta_dom				= iw_colegiados.tab_1.tabpage_5.tab_2.tabpage_13.dw_colegiados_banco_cuenta.GetItemString(1,'datos_bancarios_iban')
telef						= iw_colegiados.tab_1.tabpage_19.dw_colegiados_telefonos.GetItemString(1,'telefono_2')
telef2					= iw_colegiados.tab_1.tabpage_19.dw_colegiados_telefonos.GetItemString(1,'telefono_1')
telef3					= iw_colegiados.tab_1.tabpage_19.dw_colegiados_telefonos.GetItemString(1,'telefono_3')
fax						= iw_colegiados.tab_1.tabpage_19.dw_colegiados_telefonos.GetItemString(1,'telefono_5')
situacion 				= iw_colegiados.dw_1.getitemstring(1, 'situacion')
n_acreditado 			= iw_colegiados.dw_1.getitemstring(1, 'n_acreditado')
sexo 						= iw_colegiados.dw_1.getitemstring(1, 'sexo')
fecha_colegiacion 	= iw_colegiados.dw_1.GetItemdatetime(1,'f_colegiacion')
escuela					= iw_colegiados.tab_1.tabpage_7.tab_4.tabpage_17.dw_titulacion.GetItemString(1,'cons_escuela_final')
f_nacimiento			= iw_colegiados.dw_1.getitemdatetime(1,'f_nacimiento')
f_titulacion			= iw_colegiados.dw_1.getitemdatetime(1,'f_titulacion')
ejerce				=iw_colegiados.dw_1.getitemstring(1, 'Ejerciente')
// Recuperamos Datos de la BD
///*** Se modifica esta consulta debido al cambio de campos, surgi$$HEX2$$f3002000$$ENDHEX$$el error en La rioja. CRI-154 *///
//SELECT id_col_soc INTO :id_soc FROM sociedades WHERE id_col_soc = :id_colegiado  ; // Antes del cambio CRI-154
SELECT id_col_soc INTO :id_soc FROM sociedades WHERE id_col_per = :id_colegiado  ; //Cambio
///*** Fin cambios CRI-154 por ALexis. 07/08/2009 ***///

if not f_es_vacio(id_soc) then
	SELECT apellidos INTO :sociedad FROM colegiados WHERE id_colegiado = :id_soc ;
	num_soc = f_colegiado_n_col(id_soc)
end if

// MUSAAT
SELECT n_mutualista, src_n_poliza, src_f_baja, src_cober_f_baja, src_cober, src_coef_cm, src_alta
INTO :n_mutualista, :src_n_poliza, :src_f_baja, :src_cober_f_baja, :src_cober, :src_coef_cm, :src_alta
FROM musaat
WHERE id_col = :id_colegiado ;

if sqlca.sqlcode = 0 then
	if src_alta = 'N' then
		alta_musaat = 'NO'
		coeficiente = 0.00
	else
		select prima into :prima from musaat_cober_src	where codigo = :src_cober ;
		compania = 'MUSAAT'
		alta_musaat = 'SI'
		coeficiente = src_coef_cm
	end if
else
	alta_musaat = 'NO'
	coeficiente = 0.00
end if

// PREMAAT
SELECT alta, n_mutualista INTO :alta, :n_mutualista_premaat FROM premaat WHERE id_col = :id_colegiado ;

if sqlca.sqlcode = 0 then
	if alta = 'S' then
		alta_premaat = 'SI'
	else
		alta_premaat = 'NO'
		n_mutualista_premaat = ''
	end if				
else
	alta_premaat = 'NO'
	n_mutualista_premaat = ''
end if

// Otros
select descripcion into :desc_sit from t_altas_bajas_situaciones where codigo = :situacion ;
select descripcion into :desc_banco from csi_bancos_maestro where id = :banco_dom ;
fecha = lower(f_fecha_en_letras(datetime(today()), 'l'))
cuenta = gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban(cuenta_dom)

// EXCEPCIONES
CHOOSE CASE dw
	//javier Osuna 27/05/2010

	CASE 'd_acreditacion_colegial_certificado_lr','d_acreditacion_colegial_texto_libre_lr'
		parrafo_1 = "D./D$$HEX1$$aa00$$ENDHEX$$. " + upper(f_devuelve_secretario()) + ", Secretario/a del Colegio Oficial de Aparejadores, Arquitectos T$$HEX1$$e900$$ENDHEX$$cnicos e Ingenieros de Edificaci$$HEX1$$f300$$ENDHEX$$n de La Rioja,"
			if situacion ="B" and (dw= 'd_acreditacion_colegial_texto_libre_lr' or dw='d_acreditacion_colegial_certificado_lr') then//comprobamos que este de alta
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El colegiado para el cual intenta obtener el certificado se encuentra de baja")	
			end if	
	CASE 'd_acreditacion_colegial_certificado_gui', 'd_acreditacion_colegial_colegio_gui'
		if sexo = 'S' then // Sociedad
			string cols_soc='', col, id_col, n_cons, n_acre, n_mut, n_prem, n_pol, alta_mus, comp, alta_prem, s_coef='', s_prima=''
			int i
			datastore ds_col
			ds_col = create datastore
			ds_col.dataobject = 'd_colegiados_personas'
			ds_col.settransobject(sqlca)
			ds_col.retrieve(id_colegiado)
			
			// Datos de los colegiados que forman la sociedad
			n_consejo = ''
			alta_musaat = ''
			compania = ''
			n_mutualista = ''
			src_n_poliza = ''
			alta_premaat = ''
			n_mutualista_premaat = ''
			
			for i=1 to ds_col.rowcount()
				id_col = ds_col.getitemstring(i, 'id_col_per')
				col = f_colegiado_nombre_apellido(id_col)
				cols_soc += col + ', con N.I.F. ' + ds_col.getitemstring(i, 'compute_1') + ', '
				
				SELECT n_consejo INTO :n_cons FROM colegiados  WHERE id_colegiado = :id_col ;
				if isnull(n_cons) or n_cons = '' then n_cons = '-'
				n_consejo += n_cons + '   '
				
				SELECT n_mutualista, src_n_poliza, src_cober, src_coef_cm, src_alta
				INTO :n_mut, :n_pol, :src_cober, :src_coef_cm, :src_alta
				FROM musaat	WHERE id_col = :id_col ;
				
				if sqlca.sqlcode = 0 then
					if src_alta = 'N' then
						alta_mus = 'NO'
						coeficiente = 0.00
						n_mut = '-'
						n_pol = '-'
					else
						select prima into :prima from musaat_cober_src	where codigo = :src_cober ;
						comp = 'MUSAAT'
						alta_mus = 'SI'
						coeficiente = src_coef_cm
						if isnull(n_mut) then n_mut = '-'
						if isnull(n_pol) then n_pol = '-'
					end if
				else
					alta_mus = 'NO'
					coeficiente = 0.00
					n_mut = '-'
					n_pol = '-'
				end if				
				
				SELECT alta, n_mutualista INTO :alta, :n_prem 
				FROM premaat WHERE id_col = :id_col ;
				
				if sqlca.sqlcode = 0 then
					if alta = 'S' then
						alta_prem = 'SI'
					else
						alta_prem = 'NO'
						n_prem = '-'
					end if
				else
					alta_prem = 'NO'
					n_prem = '-'
				end if
				
				alta_musaat += alta_mus + '   '
				compania += comp + '   '
				n_mutualista += n_mut + '   '
				src_n_poliza += n_pol + '   '
				s_coef += string(coeficiente, "#,##0.00") + '   '
				s_prima += string(prima, "#,##0") + '   '
				alta_premaat += alta_prem + '   '
				n_mutualista_premaat += n_prem + '   '
			next
		else
			s_coef = string(coeficiente, "#,##0.00")
			s_prima = string(prima, "#,##0")			
		end if
		destroy ds_col
		
		if isnull(nombre) then
			nombre = ''
		else
			nombre = ' ' + nombre
		end if
		sociedad = apellidos + nombre
		
		if lower(ds_impresion.describe("cols_soc.name")) = 'cols_soc' then ds_impresion.setitem(1, 'cols_soc', LeftA(cols_soc, LenA(cols_soc)-2))
		if lower(ds_impresion.describe("s_coef.name")) = 's_coef' then ds_impresion.setitem(1, 's_coef', s_coef)
		if lower(ds_impresion.describe("s_prima.name")) = 's_prima' then ds_impresion.setitem(1, 's_prima', s_prima)
		fecha = lower(f_fecha_en_letras(datetime(today()), 'n'))
		if isnull(telef) then telef=''
		if isnull(telef2) then telef2=''
		if telef<>'' and telef2<> '' then 
			telef = telef + ' / ' + telef2
		else
			telef = telef + telef2
		end if 
 
	CASE 'd_acreditacion_colegial_colegio_gc'
		parrafo_1 = upper(f_certificados_dame_cargo('SECRETARIO'))+", SECRETARIO DEL COLEGIO OFICIAL DE APAREJADORES Y ARQUITECTOS TECNICOS DE GRAN CANARIA"
		
		//Modificado para la incidencia CGC-98. Alexis 31-8-2009
		If sexo <> 'F' then
			parrafo_2 = "Lo certifica a instancia del interesado, para acreditar su situaci$$HEX1$$f300$$ENDHEX$$n" &
			+ " colegial a efectos de ejercer profesionalmente en la demarcaci$$HEX1$$f300$$ENDHEX$$n del COAAT de Lanzarote, en el que " & 
			+ "deber$$HEX2$$e1002000$$ENDHEX$$presentar la preceptiva comunicaci$$HEX1$$f300$$ENDHEX$$n del trabajo a realizar a efectos de su visado."
		else 	
			parrafo_2 = "Lo certifica a instancia de la interesada, para acreditar su situaci$$HEX1$$f300$$ENDHEX$$n" &
			+ " colegial a efectos de ejercer profesionalmente en la demarcaci$$HEX1$$f300$$ENDHEX$$n del COAAT de Lanzarote, en el que " & 
			+ "deber$$HEX2$$e1002000$$ENDHEX$$presentar la preceptiva comunicaci$$HEX1$$f300$$ENDHEX$$n del trabajo a realizar a efectos de su visado."
		end if	
		
		If sexo <> 'F' then
			parrafo_3 = "Que el Arquitecto T$$HEX1$$e900$$ENDHEX$$cnico D."+nombre + " " + apellidos+" colegiado n$$HEX2$$ba002000$$ENDHEX$$"+n_colegiado+ " se encuentra al d$$HEX1$$ed00$$ENDHEX$$a" &
			+ " de la fecha de alta en este Colegio, al corriente de todas sus obligaciones y en el pleno uso de sus derechos corporativos."
		else
			parrafo_3 = "Que la Arquitecta T$$HEX1$$e900$$ENDHEX$$cnica D$$HEX1$$aa00$$ENDHEX$$."+nombre + " " + apellidos+" colegiada n$$HEX2$$ba002000$$ENDHEX$$"+n_colegiado+ " se encuentra al d$$HEX1$$ed00$$ENDHEX$$a" &
			+ " de la fecha de alta en este Colegio, al corriente de todas sus obligaciones y en el pleno uso de sus derechos corporativos."
		end if
		
		ds_impresion.setItem(1,'lugar_fecha','En Las Palmas de Gran Canaria,  a  '+string(day(today()))+' de ' &
			+ lower(f_obtener_mes(datetime(today())))+' de '+string(year(today())))
		ds_impresion.setItem(1,'presidente',"D. "+f_certificados_dame_cargo('PRESIDENTE'))
		ds_impresion.setItem(1,'presidente_2',"          V$$HEX2$$ba002000$$ENDHEX$$B$$HEX13$$ba00200020002000200020002000200020002000200020002000$$ENDHEX$$El Presidente")
		
	CASE 'd_acreditacion_colegial_colegio_lr'
		if situacion ="B" and (dw= 'd_acreditacion_colegial_colegio_lr') then//comprobamos que este de alta
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El colegiado para el cual intenta obtener el certificado se encuentra de baja")	
		end if	
		direccion = direccion + ' Poblaci$$HEX1$$f300$$ENDHEX$$n ' + localidad
		ds_impresion.setitem(1, 'mandar', lower(f_fecha_en_letras(datetime(today()), 'l')))

	CASE 'd_certificado_colegiacion_tfe'
		fecha = f_fecha_en_letras(fecha_colegiacion,'n')
		
		if iw_colegiados.tab_1.tabpage_22.dw_mutua.getitemstring(1,'alta') = 'S' then
			ds_impresion.setitem(1,'num_premaat',iw_colegiados.tab_1.tabpage_22.dw_mutua.getitemstring(1,'n_mutualista'))
			ds_impresion.setitem(1,'visible_1','S')
		else
			ds_impresion.setitem(1,'visible_2','S')
		end if
		
	CASE 'd_impreso_colegiacion_src_lr', 'd_impreso_colegiacion_lr'
		//javier Osuna 27/05/2010
		if situacion ="B" and dw= 'd_impreso_colegiacion_lr' then//comprobamos que este de alta
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El colegiado para el cual intenta obtener el certificado se encuentra de baja")	

		end if
	
		if alta_musaat = 'NO' and   dw= 'd_impreso_colegiacion_src_lr' then 
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El Colegiado para el cual est$$HEX2$$e1002000$$ENDHEX$$intentando obtener el impreso no se encuentra dado de alta en SRC")
		end if


	
		parrafo_1 = "D./D$$HEX1$$aa00$$ENDHEX$$. " + upper(f_devuelve_secretario()) + ", Secretario/a del Colegio Oficial de Aparejadores, Arquitectos T$$HEX1$$e900$$ENDHEX$$cnicos e Ingenieros de Edificaci$$HEX1$$f300$$ENDHEX$$n de La Rioja,"

	CASE 'd_acreditacion_colegial_certificado_za', 'd_acreditacion_colegial_certificado_gu'
		if f_es_vacio(telef) then
			if f_es_vacio(telef2) then
				telef = telef3
			else
				telef = telef2
			end if
		end if
		
		cuenta = gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban(cuenta_dom) + '     ' + desc_banco

		select src_cia into :src_cia from musaat where id_col = :id_colegiado ;
		compania = f_musaat_descripcion_companyia(src_cia)
		
		fecha = lower(f_fecha_en_letras(datetime(today()), 'n'))
		
		//Modificado Jesus 26/11/09 
		//Zaragoza: en vez de direccion normal poner direccion fiscal
		SELECT nom_via into :direccion
		FROM domicilios
		WHERE id_colegiado=:id_colegiado AND fiscal='S';

	CASE 'd_certificado_colegiacion_lr'
		//Andr$$HEX1$$e900$$ENDHEX$$s 13/7/2005
		//Metemos un dato para que salga el preview en w_preview
		//javier Osuna 27/05/2010
		if situacion ="B" and dw= 'd_certificado_colegiacion_lr' then//comprobamos que este de alta
			Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n","El colegiado para el cual intenta obtener el certificado se encuentra de baja")	

		end if
	


		ds_impresion.setitem(1,'nombre','a')
		
	CASE 'd_impreso_baja_gc', 'd_impreso_bajatotal_gc'
		if dw = 'd_impreso_baja_gc' then
			parrafo_2 = "SOLICITA  se proceda a cursar su baja como colegiado adscrito a este Colegio(1) trasladando su expediente al Colegio de "
		else
			parrafo_2 = "SOLICITA  se proceda a cursar su baja como colegiado adscrito a este Colegio(1) "
		end if
		ds_impresion.setItem(1,'lugar_fecha','En Las Palmas de Gran Canaria,  a  '+string(day(today()))+' de ' &
			+ lower(f_obtener_mes(datetime(today())))+' de '+string(year(today())))

	CASE 'd_impreso_colegiacion_gc', 'd_impreso_colegiadoycorriente_gc', 'd_impreso_noejerciente_gc', &
		  'd_impreso_concurso_gc', 'd_impreso_declaracion_gc', 'd_impreso_residente_gc', 'd_impreso_colegiado_gc'
		parrafo_1 = upper(f_certificados_dame_cargo('SECRETARIO'))+", SECRETARIO DEL COLEGIO OFICIAL DE APAREJADORES Y ARQUITECTOS TECNICOS DE GRAN CANARIA"
		ds_impresion.setItem(1,'presidente',"D. "+f_certificados_dame_cargo('PRESIDENTE'))
		ds_impresion.setItem(1,'presidente_2',"          V$$HEX2$$ba002000$$ENDHEX$$B$$HEX13$$ba00200020002000200020002000200020002000200020002000$$ENDHEX$$El Presidente")
		choose case dw
			case 'd_impreso_colegiacion_gc'
				parrafo_2 = "Y para que as$$HEX2$$ed002000$$ENDHEX$$conste a los efectos de su colegiaci$$HEX1$$f300$$ENDHEX$$n como Residente " &
				+ "en el Colegio Oficial de Aparejadores y Arquitectos T$$HEX1$$e900$$ENDHEX$$cnicos de , expido la presente " &
				+ "en Las Palmas de Gran Canaria,  a  "+string(day(today()))+" de " + lower(f_obtener_mes(datetime(today())))+" de "+string(year(today()))
			case 'd_impreso_colegiadoycorriente_gc', 'd_impreso_concurso_gc', 'd_impreso_declaracion_gc', 'd_impreso_residente_gc', 'd_impreso_colegiado_gc'
				parrafo_2 = "Y para que as$$HEX2$$ed002000$$ENDHEX$$conste a los efectos oportunos, expido la presente " &
				+ "en Las Palmas de Gran Canaria,  a  "+string(day(today()))+" de " + lower(f_obtener_mes(datetime(today())))+" de "+string(year(today()))
			case 'd_impreso_noejerciente_gc'
				parrafo_2 = "Y para que as$$HEX2$$ed002000$$ENDHEX$$conste ante el INEM expido el presente " &
				+ "en Las Palmas de Gran Canaria,  a  "+string(day(today()))+" de " + lower(f_obtener_mes(datetime(today())))+" de "+string(year(today()))
		end choose
	CASE 'd_impreso_fax_gc'
		ds_impresion.setItem(1,'lugar_fecha',string(day(today()))+" de " + lower(f_obtener_mes(datetime(today())))+" de "+string(year(today())))
		
	CASE 'd_impreso_alta_bu', 'd_impreso_baja_bu'
		ds_impresion.setItem(1,'lugar_fecha','Burgos,  '+lower(f_fecha_en_letras(datetime(today()), 'n')))
		
	CASE 'd_acreditacion_colegial_certificado_cu', 'd_acreditacion_colegial_colegio_cu'
		if sexo = 'S' then // Sociedad
			ds_col = create datastore
			ds_col.dataobject = 'd_colegiados_personas'
			ds_col.settransobject(sqlca)
			ds_col.retrieve(id_colegiado)

			for i=1 to ds_col.rowcount()
				id_col = ds_col.getitemstring(i, 'id_col_per')
				col = f_colegiado_nombre_apellido(id_col)
				cols_soc += col + ', con N.I.F. ' + ds_col.getitemstring(i, 'compute_1') + ', '
			next
		end if
		destroy ds_col
		
		if isnull(nombre) then
			nombre = ''
		else
			nombre = ' ' + nombre
		end if
		sociedad = apellidos + nombre
		if lower(ds_impresion.describe("cols_soc.name")) = 'cols_soc' then ds_impresion.setitem(1, 'cols_soc', LeftA(cols_soc, LenA(cols_soc)-2))		

END CHOOSE

// Tel$$HEX1$$e900$$ENDHEX$$fonos
if f_es_vacio(telef) then
	if f_es_vacio(telef2) then
		telef = telef3
	else
		telef = telef2
	end if
end if

// Insertamos en el dw de esta forma para que si no existe el campo no d$$HEX2$$e9002000$$ENDHEX$$error
if lower(ds_impresion.describe("n_colegiado.name")) 			= 'n_colegiado' 			then ds_impresion.setitem(1, 'n_colegiado', n_colegiado)
if lower(ds_impresion.describe("num_col.name")) 				= 'num_col' 				then ds_impresion.setitem(1, 'num_col', n_colegiado)
if lower(ds_impresion.describe("nombre.name")) 					= 'nombre' 					then ds_impresion.setitem(1, 'nombre', nombre + ' ' + apellidos)
if lower(ds_impresion.describe("nombre_col.name")) 			= 'nombre_col' 			then ds_impresion.setitem(1, 'nombre_col', nombre + ' ' + apellidos)
if lower(ds_impresion.describe("domicilio.name")) 				= 'domicilio' 				then ds_impresion.setitem(1, 'domicilio', direccion)
if lower(ds_impresion.describe("poblacion.name")) 				= 'poblacion' 				then ds_impresion.setitem(1, 'poblacion', localidad)
if lower(ds_impresion.describe("dni.name")) 						= 'dni' 						then ds_impresion.setitem(1, 'dni', nif)
if lower(ds_impresion.describe("nacional.name")) 				= 'nacional' 				then ds_impresion.setitem(1, 'nacional', n_consejo)
if lower(ds_impresion.describe("cuenta.name")) 					= 'cuenta' 					then ds_impresion.setitem(1, 'cuenta', cuenta)
if lower(ds_impresion.describe("email.name")) 					= 'email' 					then ds_impresion.setitem(1, 'email', correo)
if lower(ds_impresion.describe("f_alta.name")) 					= 'f_alta' 					then ds_impresion.setitem(1, 'f_alta', f_alta)
if lower(ds_impresion.describe("cuenta_dom.name")) 			= 'cuenta_dom' 			then ds_impresion.setitem(1, 'cuenta_dom', cuenta_dom)
if lower(ds_impresion.describe("banco.name")) 					= 'banco' 					then ds_impresion.setitem(1, 'banco', desc_banco)
if lower(ds_impresion.describe("tfno.name")) 					= 'tfno'						then ds_impresion.setitem(1, 'tfno', telef)
if lower(ds_impresion.describe("fax.name")) 						= 'fax' 						then ds_impresion.setitem(1, 'fax', fax)
if lower(ds_impresion.describe("ejer_prof.name")) 				= 'ejer_prof' 				then ds_impresion.setitem(1, 'ejer_prof', desc_sit)
if lower(ds_impresion.describe("acreditado.name")) 			= 'acreditado' 			then ds_impresion.setitem(1, 'acreditado', n_acreditado)
if lower(ds_impresion.describe("n_acreditado.name")) 			= 'n_acreditado' 			then ds_impresion.setitem(1, 'n_acreditado', n_acreditado)
if lower(ds_impresion.describe("sexo.name")) 					= 'sexo'						then ds_impresion.setitem(1, 'sexo', sexo)
if lower(ds_impresion.describe("fecha.name")) 					= 'fecha'					then ds_impresion.setitem(1, 'fecha', fecha)
if lower(ds_impresion.describe("ejer_prof.name")) 				= 'ejer_prof'				then ds_impresion.setitem(1, 'ejer_prof', desc_sit)
if lower(ds_impresion.describe("sociedad.name")) 				= 'sociedad'				then ds_impresion.setitem(1, 'sociedad', sociedad)
if lower(ds_impresion.describe("num_soc.name")) 				= 'num_soc'					then ds_impresion.setitem(1, 'num_soc', num_soc)
if lower(ds_impresion.describe("alta.name")) 					= 'alta'						then ds_impresion.setitem(1, 'alta', alta_musaat)
if lower(ds_impresion.describe("musaat.name")) 					= 'musaat'					then ds_impresion.setitem(1, 'musaat', alta_musaat)
if lower(ds_impresion.describe("coeficiente.name")) 			= 'coeficiente'			then ds_impresion.setitem(1, 'coeficiente', coeficiente)
if lower(ds_impresion.describe("compania.name")) 				= 'compania'				then ds_impresion.setitem(1, 'compania', compania)
if lower(ds_impresion.describe("cobertura.name")) 				= 'cobertura'				then ds_impresion.setitem(1, 'cobertura', prima)
if lower(ds_impresion.describe("mutualista.name")) 			= 'mutualista'				then ds_impresion.setitem(1, 'mutualista', n_mutualista)
if lower(ds_impresion.describe("poliza.name")) 					= 'poliza'					then ds_impresion.setitem(1, 'poliza', src_n_poliza)
if lower(ds_impresion.describe("alta_premaat.name")) 			= 'alta_premaat'			then ds_impresion.setitem(1, 'alta_premaat', alta_premaat)
if lower(ds_impresion.describe("premaat.name")) 				= 'premaat'					then ds_impresion.setitem(1, 'premaat', n_mutualista_premaat)
if lower(ds_impresion.describe("parrafo_1.name")) 				= 'parrafo_1'				then ds_impresion.setitem(1, 'parrafo_1', parrafo_1)
if lower(ds_impresion.describe("parrafo_2.name")) 				= 'parrafo_2'				then ds_impresion.setitem(1, 'parrafo_2', parrafo_2)
if lower(ds_impresion.describe("parrafo_3.name")) 				= 'parrafo_3'				then ds_impresion.setitem(1, 'parrafo_3', parrafo_3)
if lower(ds_impresion.describe("f_colegiacion.name")) 		= 'f_colegiacion'			then ds_impresion.setitem(1, 'f_colegiacion', fecha_colegiacion)
if lower(ds_impresion.describe("escuela.name")) 				= 'escuela'					then ds_impresion.setitem(1, 'escuela', escuela)
if lower(ds_impresion.describe("f_nacimiento.name")) 			= 'f_nacimiento'			then ds_impresion.setitem(1, 'f_nacimiento', f_nacimiento)
if lower(ds_impresion.describe("f_titulacion.name")) 			= 'f_titulacion'			then ds_impresion.setitem(1, 'f_titulacion', f_titulacion)
if lower(ds_impresion.describe("ejerce_col.name")) 			= 'ejerce_col'			then ds_impresion.setitem(1, 'ejerce_col', ejerce)

if g_colegio = 'COAATZ' or g_colegio = 'COAATGU' or g_colegio = 'COAATLE' or g_colegio = 'COAATAVI' then
	//Andr$$HEX1$$e900$$ENDHEX$$s: 28/1/2005
	//Registramos la impresi$$HEX1$$f300$$ENDHEX$$n del impreso
	string ls_id_carta,ls_id_referencia,ls_tipo,ls_modulo_asociado, n_registro
	date ld_fecha
	
	ld_fecha=today()
	
	ls_id_carta      =f_siguiente_numero('ID_CARTA',10)
	ls_id_referencia =id_colegiado
	n_registro		  = f_siguiente_numero('N_REGISTRO', 10)
	
	//esto habr$$HEX2$$e1002000$$ENDHEX$$que cambiarlo en el futuro
	if dw = 'd_acreditacion_colegial_certificado_za' or dw = 'd_acreditacion_colegial_certificado_gu' then ls_tipo='01'
	if dw = 'd_acreditacion_colegial_colegio_za' or dw = 'd_acreditacion_colegial_colegio_gu' then ls_tipo='02'
	ls_modulo_asociado='COLEGIADOS'
	
	//guardamos
//	INSERT INTO cartas 
//	//VALUES (:ls_id_carta,:ls_tipo,:ld_fecha,:ls_modulo_asociado,:ls_id_referencia,:g_usuario);
//	VALUES (:ls_id_carta, '', :ld_fecha, :ls_modulo_asociado, :ls_id_referencia, :g_usuario, '0000000000', :n_registro, :ls_tipo, '');

	INSERT INTO cartas (id_carta, tipo, fecha, modulo_asociado, id_referencia, cod_usuario, plantilla, n_registro)
	//VALUES (:ls_id_carta,:ls_tipo,:ld_fecha,:ls_modulo_asociado,:ls_id_referencia,:g_usuario);
	VALUES (:ls_id_carta, '', :ld_fecha, :ls_modulo_asociado, :ls_id_referencia, :g_usuario, :ls_tipo, :n_registro);	
	
	IF SQLCA.SQLCode = -1 THEN
		rollback;
		MessageBox(g_titulo,g_idioma.of_getmsg('colegiados.impresion_impreso', "Error al registrar la impresi$$HEX1$$f300$$ENDHEX$$n del impreso"))
	ELSE
		commit;
	END IF
end if

// Mandamos a imprimir el datawindow
if preview then
	st_preview st_preview
	st_preview.dataobject = dw
	st_preview.modulo = 'IMPRESOS'
	string datos
	datos = string(ds_impresion.Describe("DataWindow.Data"))
	st_preview.data = datos
	openwithparm(w_preview, st_preview)
else
	ds_impresion.print()
end if

// Destruimos el datastore para liberar memoria
destroy ds_impresion

end event

type cb_1 from commandbutton within w_colegiados_impresos
string tag = "texto=general.cerrar"
integer x = 1294
integer y = 1344
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

type st_1 from statictext within w_colegiados_impresos
string tag = "texto=general.seleccionar_impreso"
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
string text = "Seleccione en el impreso que desee"
boolean focusrectangle = false
end type

type cb_imprimir from commandbutton within w_colegiados_impresos
string tag = "texto=general.imprimir"
integer x = 37
integer y = 1344
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

event clicked;dw_1.event csd_imprimir(dw_1.getitemstring(dw_1.getrow(), 'dw'), false)
end event

type cb_imprimir_todos from commandbutton within w_colegiados_impresos
string tag = "texto=general.imprimir_todos"
integer x = 453
integer y = 1344
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
string text = "Imprimir Todos"
end type

event clicked;long i
for i = 1 to dw_1.rowcount()
	dw_1.setrow(i)
	cb_imprimir.triggerevent(clicked!)
next
end event

type cb_preview from commandbutton within w_colegiados_impresos
string tag = "texto=general.previsualizar"
integer x = 873
integer y = 1344
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

