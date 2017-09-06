HA$PBExportHeader$w_renuncias_impresos.srw
forward
global type w_renuncias_impresos from w_response
end type
type dw_1 from u_dw within w_renuncias_impresos
end type
type cb_1 from commandbutton within w_renuncias_impresos
end type
type st_1 from statictext within w_renuncias_impresos
end type
type cb_imprimir from commandbutton within w_renuncias_impresos
end type
type cb_imprimir_todos from commandbutton within w_renuncias_impresos
end type
type cb_preview from commandbutton within w_renuncias_impresos
end type
end forward

global type w_renuncias_impresos from w_response
integer width = 1787
integer height = 1568
string title = "Renuncias"
dw_1 dw_1
cb_1 cb_1
st_1 st_1
cb_imprimir cb_imprimir
cb_imprimir_todos cb_imprimir_todos
cb_preview cb_preview
end type
global w_renuncias_impresos w_renuncias_impresos

type variables
w_fases_detalle iw_fases
end variables

on w_renuncias_impresos.create
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

on w_renuncias_impresos.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cb_imprimir)
destroy(this.cb_imprimir_todos)
destroy(this.cb_preview)
end on

event open;call super::open;string ventana
iw_fases = g_detalle_fases

f_centrar_ventana(this)

ventana = this.classname()
dw_1.retrieve(ventana)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_renuncias_impresos
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_renuncias_impresos
end type

type dw_1 from u_dw within w_renuncias_impresos
event csd_imprimir ( string dw,  boolean preview )
integer x = 73
integer y = 100
integer width = 1618
integer height = 1188
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_renuncias_impresos"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event csd_imprimir(string dw, boolean preview);string id_fase, descripcion, poblacion, cliente, colegiado, direccion, fecha, lugar_fecha, id_cliente,secretario
string poblacion_cliente,direccion_cliente
string texto_ayto, dest_ayto1, texto_prop, dom_prop, pob_prop, dest_trab1, texto_trab, dest_trab2, t_act
string dest_trab3, dest_ayto2, dest_ayto3, cod_pob, col_dom, col_pob, n_visado, encargo, ape_arq, nom_arq
string arquitecto, parrafo2, texto_cliente, texto_promotor, texto_col_arq
// Julian CGU-85
string propiedad,emplazamiento,municipio,nombre,cp,fecha_renuncia, fecha_entrada
// Fin Julian
int i,j
datetime f_renuncia, f_entrada


datastore ds_impresion
ds_impresion = create datastore
ds_impresion.dataObject = dw
ds_impresion.insertrow(0)

// Recuperamos Datos del detalle de fases
id_fase		= iw_fases.dw_1.GetItemString(1,'id_fase')
descripcion	= iw_fases.dw_1.getItemstring(1,'descripcion')
cod_pob		= iw_fases.dw_1.GetItemString(1,'poblacion')
id_cliente	= iw_fases.tab_1.tabpage_1.dw_fases_promotores.GetItemString(1,'id_cliente')
t_act			= iw_fases.dw_1.GetItemString(1,'fase')


	






//for j = 1 to 	iw_fases.tab_1.tabpage_1.dw_fases_promotores.rowcount()
for i = 1 to iw_fases.tab_1.tabpage_2.dw_fases_colegiados.rowcount()
	if g_colegio = 'COAATGU' then
			colegiado = iw_fases.tab_1.tabpage_2.dw_fases_colegiados.GetItemString(i,'id_col')
		end if
	if iw_fases.tab_1.tabpage_2.dw_fases_colegiados.GetItemString(i,'renunciado') = 'S' then
		colegiado = iw_fases.tab_1.tabpage_2.dw_fases_colegiados.GetItemString(i,'id_col')
	end if
next

//id_cliente	= iw_fases.tab_1.tabpage_1.dw_fases_promotores.GetItemString(j,'id_cliente')
col_dom = f_domicilio_activo(colegiado)
col_pob = f_poblacion_activa(colegiado)
poblacion_cliente = f_poblacion_cliente(id_cliente)
colegiado = f_colegiado_nombre_apellido(colegiado)
cliente = f_dame_cliente(id_cliente)
poblacion = f_poblacion_descripcion(cod_pob)
direccion_cliente = f_domicilio_cliente(id_cliente)
direccion = f_dame_direccion_contrato(id_fase)
fecha = lower(f_fecha_en_letras(datetime(today()), 'n'))
lugar_fecha = g_col_ciudad + ", " + fecha
dom_prop = f_dame_domicilio(id_cliente)
pob_prop = f_retorna_poblacion(id_cliente)
n_visado = f_fases_n_salida(id_fase)
//cp_cliente = f_devuelve_cod_postal(pob_prop)

if isnull(n_visado) then n_visado = ''
if isnull(descripcion) then descripcion = ''
if iw_fases.tab_1.tabpage_16.dw_arquitectos.rowcount()>0 then
	ape_arq = iw_fases.tab_1.tabpage_16.dw_arquitectos.GetItemString(1,'apellidos')
	nom_arq = iw_fases.tab_1.tabpage_16.dw_arquitectos.GetItemString(1,'nombre')
	arquitecto = ape_arq
	if not f_es_vacio(nom_arq) then arquitecto = ape_arq + ', ' + nom_arq
end if

encargo = f_dame_desc_tipo_actuacion(t_act)

// Carta Ayto
texto_ayto = "Le comunicamos que en la Secretar$$HEX1$$ed00$$ENDHEX$$a de este Colegio ha tenido entrada con fecha " + &
	+ fecha + ", escrito de renuncia del Arquitecto T$$HEX1$$e900$$ENDHEX$$cnico D./D$$HEX2$$aa002000$$ENDHEX$$" + colegiado + &
	+ ", como Director de la ejecuci$$HEX1$$f300$$ENDHEX$$n de la obra de " + descripcion + " en " + direccion + &
	+ ", a nombre de D./D$$HEX2$$aa002000$$ENDHEX$$" + cliente + ", de su t$$HEX1$$e900$$ENDHEX$$rmino municipal."
dest_ayto1 = "Ilmo. Sr. Alcalde Presidente del Ayuntamiento de " + poblacion
//dest_ayto2 = "Pl. Mayor, 1"
dest_ayto3 = f_devuelve_cod_postal(cod_pob) + " " + poblacion
if(g_colegio = 'COAATTEB' or g_colegio='COAATLL')then
	texto_ayto = 'En aquesta Seu Col.legial s$$HEX1$$b400$$ENDHEX$$ha rebut ren$$HEX1$$fa00$$ENDHEX$$ncia d$$HEX1$$b400$$ENDHEX$$intervenci$$HEX2$$f3002000$$ENDHEX$$professional formulada per l$$HEX1$$b400$$ENDHEX$$arquitecte t$$HEX1$$e800$$ENDHEX$$cnic senyor '+ colegiado +'.'+cr+cr+'Aquest va a ser nomenat per intervenir en les obres de '+descripcion+' situat a '+direccion+', promogudes per '+cliente+'.'
end if

// Carta Propiedad
texto_prop = "Le comunicamos que en la Secretar$$HEX1$$ed00$$ENDHEX$$a de este Colegio ha tenido entrada con fecha " + &
	+ fecha + ", escrito de renuncia del Arquitecto T$$HEX1$$e900$$ENDHEX$$cnico D./D$$HEX2$$aa002000$$ENDHEX$$" + colegiado + &
	+ ", a los contratos visados a su nombre, consistentes en " + descripcion + " en " + direccion + &
	+ ", por lo que deber$$HEX2$$e1002000$$ENDHEX$$proceder al nombramiento de un nuevo Arquitecto T$$HEX1$$e900$$ENDHEX$$cnico para las obras" + &
	+ " en cuesti$$HEX1$$f300$$ENDHEX$$n."

//Modificado Luis 04/02/2009 para incidencia ictl-71	
// Carta cliente
if(g_colegio = 'COAATTEB' or g_colegio='COAATLL')then	
	texto_cliente = "Li comuniquem que en aquest Col.legi ha tingut entrada amb data " + &
		+ fecha + ", escrit de ren$$HEX1$$fa00$$ENDHEX$$ncia, la qual adjuntem, del Arquitecte T$$HEX1$$e900$$ENDHEX$$cnic D./D$$HEX2$$aa002000$$ENDHEX$$" + colegiado + &
		+ ", als contractes visats al seu nom, consistents en " + descripcion + " situats a " + direccion + &
		+ ", pel qu$$HEX2$$e8002000$$ENDHEX$$deur$$HEX2$$e0002000$$ENDHEX$$nombrar un nou Arquitecte T$$HEX1$$e800$$ENDHEX$$cnic per a les obres en q$$HEX1$$fc00$$ENDHEX$$esti$$HEX1$$f300$$ENDHEX$$."
end if	
//fin modificado Luis


//Modificado Luis 06/02/2009 para incidencia ictl-71	
// Carta col. arq.
if(g_colegio = 'COAATTEB' or g_colegio='COAATLL')then	
	texto_col_arq = "Per al seu coneixement i als efectes que procedeixen, li adjunto "+ &
	+"c$$HEX1$$f200$$ENDHEX$$pia de la comunicaci$$HEX2$$f3002000$$ENDHEX$$enviada al promotor de les obres que en la "+ &
	+"mateixa es fan refer$$HEX1$$e800$$ENDHEX$$ncia i relativa a l$$HEX1$$1920$$ENDHEX$$obligaci$$HEX2$$f3002000$$ENDHEX$$que l$$HEX1$$1920$$ENDHEX$$incumbeix de "+ &
	+"nomenar un nou Arquitecte T$$HEX1$$e800$$ENDHEX$$cnic i/o Coordinador de Seguretat i "+ &
	+"Salut Laboral, pel cessament del anterior. "
end if	
//fin modificado Luis

//Modificado Luis 04/02/2009 para incidencia ictl-71	
// Carta promotor
if(g_colegio = 'COAATTEB' or g_colegio='COAATLL')then	
	texto_promotor = "Promotor: " +cliente+cr+"Obra: "+descripcion+cr+"Situaci$$HEX1$$f300$$ENDHEX$$: "+direccion+cr+"Arquitecte T$$HEX1$$e900$$ENDHEX$$cnic / Aparellador: " + colegiado 
end if	
//fin modificado Luis

// Carta Trabajo
texto_trab = "Les comunicamos que con fecha " + fecha + ", se ha presentado en este Colegios carta de" +&
	+ " renuncia del Arquitecto T$$HEX1$$e900$$ENDHEX$$cnico D./D$$HEX2$$aa002000$$ENDHEX$$" + colegiado + ", a la obra consistente en " + descripcion +&
	+ ", sita en " + direccion + ", propiedad de D./D$$HEX2$$aa002000$$ENDHEX$$" + cliente + "."
//dest_trab1 = "Consejer$$HEX1$$ed00$$ENDHEX$$a de Trabajo y Empleo"
//dest_trab2 = "Avda. Castilla, 7"
//dest_trab3 = "19071 Guadalajara"
if(g_colegio = 'COAATTEB' or g_colegio='COAATLL')then
	texto_trab = 'En aquesta Seu Col.legial s$$HEX1$$b400$$ENDHEX$$ha rebut ren$$HEX1$$fa00$$ENDHEX$$ncia d$$HEX1$$b400$$ENDHEX$$intervenci$$HEX2$$f3002000$$ENDHEX$$professional formulada per l$$HEX1$$b400$$ENDHEX$$arquitecte t$$HEX1$$e800$$ENDHEX$$cnic senyor '+ colegiado +'.'+cr+cr+'Aquest va a ser nomenat per intervenir en les obres de '+descripcion+' situat a '+direccion+', promogudes per '+cliente+ '.'
end if

parrafo2 = "A tal efecto rogamos nos indiques si la obra est$$HEX2$$e1002000$$ENDHEX$$en ejecuci$$HEX1$$f300$$ENDHEX$$n, especificando las unidades de " +&
	+ "obra ejecutadas bajo tu direcci$$HEX1$$f300$$ENDHEX$$n y el porcentaje que supone sobre la totalidad."

//Modificado Jesus 20/01/2010 ictl-241
if (g_colegio = 'COAATTEB' or g_colegio='COAATLL') then
	parrafo2 = "A aquest efecte preguem ens indiquis si l'obra est$$HEX2$$e0002000$$ENDHEX$$en execuci$$HEX1$$f300$$ENDHEX$$, especificant les unitats d'" +&
	+ "obra executades sota la teva adre$$HEX1$$e700$$ENDHEX$$a i el percentatge que suposa sobre la totalitat."
end if

// Juli$$HEX1$$e100$$ENDHEX$$n CGC-58

secretario = g_secretario
if g_colegio = 'COAATGC' then 
	
	select max(fecha) into :f_renuncia from fases_renuncias where id_fase = :id_fase;
	fecha_renuncia = lower(f_fecha_en_letras(f_renuncia, 'n'))
	if isnull(fecha_renuncia) then fecha_renuncia = ''
	
	//Modificaci$$HEX1$$f300$$ENDHEX$$n Jesus 26/01/2010 cgc-58 a$$HEX1$$f100$$ENDHEX$$adir campo de fecha entrada en carta de ayuntamiento
	select f_entrada into :f_entrada from fases where id_fase = :id_fase;
	fecha_entrada = lower(f_fecha_en_letras(f_entrada, 'n'))
	if isnull(fecha_entrada) then fecha_entrada = ''
	
	//Obtener la direccion del ayuntamiento.
	select nombre_via into :dest_ayto2 from clientes where id_cliente='0000003108';
	dest_ayto2=WordCap(lower(dest_ayto2))
	
	texto_cliente = "Le comunicamos que Don " + colegiado + ", Arquitecto T$$HEX1$$e900$$ENDHEX$$cnico contratado como " + &
	" Director de Ejecuci$$HEX1$$f300$$ENDHEX$$n (y Coordinador de Seguridad y Salud durante la ejecuci$$HEX1$$f300$$ENDHEX$$n) de la obra " + &
	 " consistente en " + descripcion + ", sita en "+ direccion + ", del t$$HEX1$$e900$$ENDHEX$$rmino municipal de " + poblacion + "," + &
	 " el pasado d$$HEX1$$ed00$$ENDHEX$$a "+ fecha_renuncia +  " present$$HEX2$$f3002000$$ENDHEX$$en este Colegio Profesional un escrito en el que proced$$HEX1$$ed00$$ENDHEX$$a a notificar " + &
	 " su renuncia a la referida intervenci$$HEX1$$f300$$ENDHEX$$n profesional (a las referidas intervenciones profesionales)."
	 
	texto_trab = "Por medio del presente escrito les comunicamos que con fecha " + fecha_renuncia + ", " + &
	 "el Arquitecto T$$HEX1$$e900$$ENDHEX$$cnico D. " + colegiado + " present$$HEX2$$f3002000$$ENDHEX$$en este Colegio un escrito "+&
	 "en el que comunicaba su renuncia a la Coordinaci$$HEX1$$f300$$ENDHEX$$n de Seguridad y Salud durante la ejecuci$$HEX1$$f300$$ENDHEX$$n de la obra " + &
	 "consistente en " + descripcion + " en " + direccion +  " "+ & 
	 "del del t$$HEX1$$e900$$ENDHEX$$rmino municipal de " + poblacion + ", sin que hasta la fecha se haya procedido "+& 
	 "por parte del autor del encargo,"+ cliente +  ", con domicilio en " + direccion_cliente + "," +&
	 "del t$$HEX1$$e900$$ENDHEX$$rmino municipal de " + poblacion_cliente +", a notificar a este Colegio el nombramiento "+&
	 "de un nuevo arquitecto t$$HEX1$$e900$$ENDHEX$$cnico responsable de la coordinaci$$HEX1$$f300$$ENDHEX$$n de seguridad y salud durante la ejecuci$$HEX1$$f300$$ENDHEX$$n de la referida obra, "+&
	 "lo que ponemos en su conocimiento a los efectos procedentes."
	 
	  //Modificado Jesus 26/01/2010 cgc-58
	texto_ayto = "Por medio del presente escrito les notificamos que, con fecha " +  /*fecha_renuncia*/fecha_entrada +", " + &
	    "D.   "+  colegiado + "   comunic$$HEX2$$f3002000$$ENDHEX$$a este Colegio Profesional su renuncia a la intervenci$$HEX1$$f300$$ENDHEX$$n profesional como  " + &
	  "Director de Ejecuci$$HEX1$$f300$$ENDHEX$$n de la obra consistente en " + descripcion +  &
	  ", sito en " + direccion+ ", del t$$HEX1$$e900$$ENDHEX$$rmino municipal de " + poblacion + ", para la que estaba nombrado por " + &
	  " encargo de " + cliente + " , con domicilio en " + direccion_cliente + " " + &
	 " del t$$HEX1$$e900$$ENDHEX$$rmino municipal de " + poblacion_cliente + " , lo que ponemos en su conocimiento a los efectos procedentes."
end if



// Fin Juli$$HEX1$$e100$$ENDHEX$$n


// Insertamos en el dw de esta forma para que si no existe el campo no d$$HEX2$$e9002000$$ENDHEX$$error
if lower(ds_impresion.describe("lugar_fecha.name"))= 'lugar_fecha'	then ds_impresion.setitem(1, 'lugar_fecha', lugar_fecha)
if lower(ds_impresion.describe("fecha.name"))= 'fecha'	then ds_impresion.setitem(1, 'fecha', string(date(today())))
if lower(ds_impresion.describe("texto_ayto.name"))	= 'texto_ayto' 	then ds_impresion.setitem(1, 'texto_ayto', texto_ayto)
if lower(ds_impresion.describe("dest_ayto1.name")) = 'dest_ayto1' 	then ds_impresion.setitem(1, 'dest_ayto1', dest_ayto1)
if (g_colegio = 'COAATGC') then
	if lower(ds_impresion.describe("dest_ayto2.name")) = 'dest_ayto2' 	then ds_impresion.setitem(1, 'dest_ayto2', dest_ayto2)
end if
if lower(ds_impresion.describe("dest_ayto3.name")) = 'dest_ayto3' 	then ds_impresion.setitem(1, 'dest_ayto3', dest_ayto3)
if lower(ds_impresion.describe("texto_prop.name"))	= 'texto_prop' 	then ds_impresion.setitem(1, 'texto_prop', texto_prop)
if lower(ds_impresion.describe("texto_cliente.name"))	= 'texto_cliente' 	then ds_impresion.setitem(1, 'texto_cliente', texto_cliente)
if lower(ds_impresion.describe("prop.name"))  		= 'prop' 			then ds_impresion.setitem(1, 'prop', cliente)
if lower(ds_impresion.describe("dom_prop.name"))  	= 'dom_prop' 		then ds_impresion.setitem(1, 'dom_prop', dom_prop)
if lower(ds_impresion.describe("pob_prop.name"))  	= 'pob_prop' 		then ds_impresion.setitem(1, 'pob_prop', pob_prop)
if lower(ds_impresion.describe("texto_trab.name"))	= 'texto_trab' 	then ds_impresion.setitem(1, 'texto_trab', texto_trab)
if lower(ds_impresion.describe("texto_promotor.name"))	= 'texto_promotor' 	then ds_impresion.setitem(1, 'texto_promotor', texto_promotor)
if lower(ds_impresion.describe("texto_col_arq.name"))	= 'texto_col_arq' 	then ds_impresion.setitem(1, 'texto_col_arq', texto_col_arq)
//if lower(ds_impresion.describe("dest_trab1.name")) = 'dest_trab1'		then ds_impresion.setitem(1, 'dest_trab1', dest_trab1)
//if lower(ds_impresion.describe("dest_trab2.name")) = 'dest_trab2'		then ds_impresion.setitem(1, 'dest_trab2', dest_trab2)
//if lower(ds_impresion.describe("dest_trab3.name")) = 'dest_trab3'		then ds_impresion.setitem(1, 'dest_trab3', dest_trab3)
if lower(ds_impresion.describe("ayto.name"))			= 'ayto' 			then ds_impresion.setitem(1, 'ayto', "AYUNTAMIENTO DE " + poblacion)
if(g_colegio = 'COAATTEB' or g_colegio='COAATLL')then
	if lower(ds_impresion.describe("ayto.name"))			= 'ayto' 			then ds_impresion.setitem(1, 'ayto', "AJUNTAMENT DE " + poblacion)
end if
if lower(ds_impresion.describe("dest_col1.name")) 	= 'dest_col1'		then ds_impresion.setitem(1, 'dest_col1', colegiado)
if lower(ds_impresion.describe("dest_col2.name")) 	= 'dest_col2'		then ds_impresion.setitem(1, 'dest_col2', col_dom)
if lower(ds_impresion.describe("dest_col3.name")) 	= 'dest_col3'		then ds_impresion.setitem(1, 'dest_col3', col_pob)
if lower(ds_impresion.describe("obra.name"))			= 'obra' 			then ds_impresion.setitem(1, 'obra', descripcion)
if lower(ds_impresion.describe("n_visado.name"))	= 'n_visado' 		then ds_impresion.setitem(1, 'n_visado', n_visado)
if lower(ds_impresion.describe("ubicacion.name")) 	= 'ubicacion'		then ds_impresion.setitem(1, 'ubicacion', direccion)
if lower(ds_impresion.describe("colegiado.name")) 	= 'colegiado'		then ds_impresion.setitem(1, 'colegiado', colegiado)
if lower(ds_impresion.describe("encargo.name")) 	= 'encargo'			then ds_impresion.setitem(1, 'encargo', encargo)
if lower(ds_impresion.describe("arquitecto.name"))	= 'arquitecto' 	then ds_impresion.setitem(1, 'arquitecto', arquitecto)
if lower(ds_impresion.describe("parrafo2.name"))	= 'parrafo2' 		then ds_impresion.setitem(1, 'parrafo2', parrafo2)
if lower(ds_impresion.describe("secretario.name"))	= 'secretario' 		then ds_impresion.setitem(1, 'secretario', secretario)
if lower(ds_impresion.describe("poblacion_cliente.name"))	= 'poblacion_cliente' 		then ds_impresion.setitem(1, 'poblacion_cliente', poblacion_cliente)
if lower(ds_impresion.describe("direccion_cliente.name"))	= 'direccion_cliente' 		then ds_impresion.setitem(1, 'direccion_cliente', direccion_cliente)
//if lower(ds_impresion.describe("cp.name"))	= 'cp' 		then ds_impresion.setitem(1, 'cp', cp_cliente)
//MessageBox('',f_devuelve_secretario() + ' var: ' + g_secretario)

st_preview st_preview
st_preview.dataobject = dw
st_preview.modulo = 'RENUNCIAS'
string datos

if g_colegio = 'COAATGC' then
	for j = 1 to 	iw_fases.tab_1.tabpage_1.dw_fases_promotores.rowcount()
		id_cliente	= iw_fases.tab_1.tabpage_1.dw_fases_promotores.GetItemString(j,'id_cliente')
		///*** Se comento la l$$HEX1$$ed00$$ENDHEX$$nea siguiente. no tiene sentido volver a sacarlo. Alexis 28/07/2009
		//col_dom = f_domicilio_activo(colegiado)
		poblacion_cliente = f_poblacion_cliente(id_cliente)
		cliente = f_dame_cliente(id_cliente)
		direccion_cliente = f_domicilio_cliente(id_cliente)
		dom_prop = f_dame_domicilio(id_cliente)
		pob_prop = f_retorna_poblacion(id_cliente)
		dest_ayto1 = "AYUNTAMIENTO DE " + poblacion
		long jj		
		 //Modificado Jesus 26/01/2010 cgc-58
		texto_ayto = "Por medio del presente escrito les notificamos que con fecha " +  /*fecha_renuncia*/fecha_entrada +", " + &
	    "D.   "+  colegiado + "   comunic$$HEX2$$f3002000$$ENDHEX$$a este Colegio Profesional su renuncia a la intervenci$$HEX1$$f300$$ENDHEX$$n profesional como  " + &
	  "Director de Ejecuci$$HEX1$$f300$$ENDHEX$$n de la obra consistente en " + descripcion +  &
	  ", sito en " + direccion+ ", del t$$HEX1$$e900$$ENDHEX$$rmino municipal de " + poblacion + ", para la que estaba nombrado por " + &
	  " encargo de " + cliente + " , con domicilio en " + direccion_cliente + " " + &
	 " del t$$HEX1$$e900$$ENDHEX$$rmino municipal de " + poblacion_cliente + " , lo que ponemos en su conocimiento a los efectos procedentes."
	 
	 // AYUNTAMIENTO GC
		if ds_impresion.dataobject = 'd_renuncias_carta_ayuntamiento_gc' and iw_fases.tab_1.tabpage_1.dw_fases_promotores.rowcount() >1 then
			cliente = ''
      		for jj = 1 to 	iw_fases.tab_1.tabpage_1.dw_fases_promotores.rowcount()
                  id_cliente	= iw_fases.tab_1.tabpage_1.dw_fases_promotores.GetItemString(jj,'id_cliente')
                  direccion_cliente = f_domicilio_cliente(id_cliente)
                  poblacion_cliente = f_poblacion_cliente(id_cliente)	
			if jj= 1 then
       			  cliente = f_dame_cliente(id_cliente) + ' con domicilio en ' + direccion_cliente +&
			       '  del terminal municipal de ' + poblacion_cliente
				else
					 cliente = cliente +';' +  f_dame_cliente(id_cliente) + ' con domicilio en ' + direccion_cliente +&
			       '  del terminal municipal de ' + poblacion_cliente
				end if
                next
					 //Modificado Jesus 26/01/2010 cgc-58
      	 texto_ayto = "Por medio del presente escrito les notificamos que con fecha " +  /*fecha_renuncia*/fecha_entrada +", " + &
	    "D.   "+  colegiado + "   comunic$$HEX2$$f3002000$$ENDHEX$$a este Colegio Profesional su renuncia a la intervenci$$HEX1$$f300$$ENDHEX$$n profesional como  " + &
	  "Director de Ejecuci$$HEX1$$f300$$ENDHEX$$n de la obra consistente en " + descripcion +  &
	  ", sito en " + direccion+ ", del t$$HEX1$$e900$$ENDHEX$$rmino municipal de " + poblacion + ", para la que estaba nombrado por " + &
	  " encargo de " + cliente + " " + " , lo que ponemos en su conocimiento a los efectos procedentes."
		end if
		
		// TRABAJO GC
		if ds_impresion.dataobject = 'd_renuncias_carta_trabajo_gc' and iw_fases.tab_1.tabpage_1.dw_fases_promotores.rowcount() >1 then
			cliente = ''
      		for jj = 1 to 	iw_fases.tab_1.tabpage_1.dw_fases_promotores.rowcount()
                  id_cliente	= iw_fases.tab_1.tabpage_1.dw_fases_promotores.GetItemString(jj,'id_cliente')
                  direccion_cliente = f_domicilio_cliente(id_cliente)
                  poblacion_cliente = f_poblacion_cliente(id_cliente)	
			if jj= 1 then
       			  cliente = f_dame_cliente(id_cliente) + ' con domicilio en ' + direccion_cliente +&
			       '  del terminal municipal de ' + poblacion_cliente
				else
					 cliente = cliente +';' +  f_dame_cliente(id_cliente) + ' con domicilio en ' + direccion_cliente +&
			       '  del terminal municipal de ' + poblacion_cliente
				end if
                next
      	texto_trab = "Por medio del presente escrito les comunicamos que con fecha " + fecha_renuncia + ", " + &
	 "el Arquitecto T$$HEX1$$e900$$ENDHEX$$cnico D. " + colegiado + " present$$HEX2$$f3002000$$ENDHEX$$en este Colegio un escrito "+&
	 "en el que comunicaba su renuncia a la Coordinaci$$HEX1$$f300$$ENDHEX$$n de Seguridad y Salud durante la ejecuci$$HEX1$$f300$$ENDHEX$$n de la obra " + &
	 " consistente en " + descripcion + " en " + direccion +  " "+ & 
	 "del del t$$HEX1$$e900$$ENDHEX$$rmino municipal de " + poblacion + ", sin que hasta la fecha se haya procedido "+& 
	 "por parte del autor del encargo,"+ cliente +  ", a notificar a este Colegio el nombramiento "+&
	 "de un nuevo arquitecto t$$HEX1$$e900$$ENDHEX$$cnico responsable de la coordinaci$$HEX1$$f300$$ENDHEX$$n de seguridad y salud durante la ejecuci$$HEX1$$f300$$ENDHEX$$n de la referida obra, "+&
	 "lo que ponemos en su conocimiento a los efectos procedentes."
		end if
		
		
          if lower(ds_impresion.describe("poblacion_cliente.name"))	= 'poblacion_cliente' 		then ds_impresion.setitem(1, 'poblacion_cliente', poblacion_cliente)
          if lower(ds_impresion.describe("direccion_cliente.name"))	= 'direccion_cliente' 		then ds_impresion.setitem(1, 'direccion_cliente', direccion_cliente)
          if lower(ds_impresion.describe("cliente.name"))	= 'cliente' 								then ds_impresion.setitem(1, 'cliente', cliente)
          if lower(ds_impresion.describe("texto_ayto.name"))	= 'texto_ayto' 	then ds_impresion.setitem(1, 'texto_ayto', texto_ayto)
          if lower(ds_impresion.describe("dest_ayto1.name")) = 'dest_ayto1' 	then ds_impresion.setitem(1, 'dest_ayto1', dest_ayto1)		
          if lower(ds_impresion.describe("texto_trab.name"))	= 'texto_trab' 	then ds_impresion.setitem(1, 'texto_trab', texto_trab)		

		// Mandamos a imprimir el datawindow
		if preview then
			datos = string(ds_impresion.Describe("DataWindow.Data"))
			st_preview.data = datos
			openwithparm(w_preview, st_preview)			
                if ds_impresion.dataobject = 'd_renuncias_carta_ayuntamiento_gc' or  ds_impresion.dataobject = 'd_renuncias_carta_trabajo_gc' then
				exit
			end if
		else
			ds_impresion.print()
			if ds_impresion.dataobject = 'd_renuncias_carta_ayuntamiento_gc' or  ds_impresion.dataobject = 'd_renuncias_carta_trabajo_gc' then
				exit
			end if
		end if
	next
else
	if preview then
	datos = string(ds_impresion.Describe("DataWindow.Data"))
	st_preview.data = datos
	openwithparm(w_preview, st_preview)
	
else
	ds_impresion.print()
end if
end if
//next


// Destruimos el datastore para liberar memoria
destroy ds_impresion

end event

type cb_1 from commandbutton within w_renuncias_impresos
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

type st_1 from statictext within w_renuncias_impresos
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

type cb_imprimir from commandbutton within w_renuncias_impresos
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

type cb_imprimir_todos from commandbutton within w_renuncias_impresos
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
string text = "Imprimir Todas"
end type

event clicked;long i
for i = 1 to dw_1.rowcount()
	dw_1.setrow(i)
	cb_imprimir.triggerevent(clicked!)
next
end event

type cb_preview from commandbutton within w_renuncias_impresos
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

