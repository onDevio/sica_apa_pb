HA$PBExportHeader$w_cartas_defuncion_generacion.srw
forward
global type w_cartas_defuncion_generacion from w_response
end type
type dw_1 from u_dw within w_cartas_defuncion_generacion
end type
type cb_1 from commandbutton within w_cartas_defuncion_generacion
end type
type cb_salir from commandbutton within w_cartas_defuncion_generacion
end type
end forward

global type w_cartas_defuncion_generacion from w_response
integer x = 214
integer y = 221
integer width = 1829
integer height = 980
string title = "Cartas de Defunci$$HEX1$$f300$$ENDHEX$$n"
event csd_generar_carta_defuncion ( )
event csd_rellenar_carta ( st_colegiado_defuncion st_datos,  datastore ds )
event csd_generar_carta_inspec ( string tipo )
event csd_generar_carta_cliente ( )
event csd_generar_carta_ayuntamiento ( )
event csd_generar_carta_arq ( )
dw_1 dw_1
cb_1 cb_1
cb_salir cb_salir
end type
global w_cartas_defuncion_generacion w_cartas_defuncion_generacion

type variables
st_colegiado_defuncion ist_datos
datastore ds_fases_exp_abiertos

n_csd_impresion_formato uo_impresion





end variables

event csd_generar_carta_defuncion();long tot
string id_col
integer j

ist_datos.n_colegiado=dw_1.GetItemString(1,'n_col')
ist_datos.f_defuncion = dw_1.GetItemDatetime(1,'f_defuncion')

select id_colegiado into :id_col from colegiados where n_colegiado=:ist_datos.n_colegiado;

ds_fases_exp_abiertos= create datastore
ds_fases_exp_abiertos.dataobject='d_fases_exp_abiertos_mca'
ds_fases_exp_abiertos.SetTransObject(SQLCA)
tot=ds_fases_exp_abiertos.retrieve(id_col)

if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!", "Se han encontrado "+string(tot)+" expedientes abiertos. $$HEX1$$bf00$$ENDHEX$$Desea imprimir las cartas para todos ellos?",QUestion!,YesNo!)<>1 then return

for j=1 to 5 

	choose case j
		case 1  // CARTA AL CLIENTE
			if dw_1.GetItemString(1,'cliente')='S' then
				event csd_generar_carta_cliente()
			end if				
		case 2  // CARTA AL AYUNTAMIENTO
			if dw_1.GetItemString(1,'ayuntamiento')='S' then
				event csd_generar_carta_ayuntamiento()
			end if					
		case 3  // COLEGIO DE ARQUITECTOS	
			if dw_1.GetItemString(1,'col_arq')='S' then
				event csd_generar_carta_arq()
			end if
		case 4  // INSPECCION DE TRABAJO
			if dw_1.GetItemString(1,'inspeccion')='S' then
				event csd_generar_carta_inspec('I')		
			end if			
		case 5  // CONSELLERIA DE TRABAJO
			if dw_1.GetItemString(1,'conselleria')='S' then
				event csd_generar_carta_inspec('C')		
			end if
	end choose
next



end event

event csd_rellenar_carta(st_colegiado_defuncion st_datos, datastore ds);//
long fila

fila=ds.insertrow(0)
ds.SetItem(fila,'destinatario',st_datos.destinatario_nombre)	
if lower(ds.describe("destinatario2.name")) = 'destinatario2' then ds.SetItem(fila,'destinatario2',st_datos.destinatario_nombre2)	
ds.SetItem(fila,'domicilio_dest',st_datos.destinatario_emplaz)
ds.SetItem(fila,'poblacion_dest',st_datos.destinatario_poblacion)		
ds.SetItem(fila,'clientes',st_datos.clientes)	
ds.SetItem(fila,'arquitectos',st_datos.arquitectos)	
ds.SetItem(fila,'nombre_col',st_datos.nombre)
ds.SetItem(fila,'f_defuncion',st_datos.f_defuncion)
ds.SetItem(fila,'descripcion',st_datos.encargo)
ds.SetItem(fila,'municipio',st_datos.municipio)	
ds.SetItem(fila,'n_visado',st_datos.n_visado)
ds.SetItem(fila,'f_visado',st_datos.f_visado)	
ds.SetItem(fila,'emplazamiento',st_datos.emplaz)
ds.SetItem(fila,'t_act',st_datos.t_act)
ds.SetItem(fila,'fecha',dw_1.GetItemDateTime(1,'fecha'))
end event

event csd_generar_carta_inspec(string tipo);string id_col,nom_col,ape_col,sexo,pob
long tot,i,fila,j,z
datetime f_baja,f_defuncion
string n_col
string n_calle,piso,puerta,tipo_via,emplaz,emplazamiento
string poblacion,provincia
string id_cli,dest_nom,dest_ape,dest_tipo_via, dest_nombre_via, dest_cod_pos, dest_poblacion, dest_provincia
datastore ds_clientes
datastore ds_carta_inspec

ds_carta_inspec= create datastore
ds_carta_inspec.dataobject='d_carta_defuncion_inspec_mca'
ds_carta_inspec.SetTransObject(SQLCA)

ds_carta_inspec.reset()

select id_colegiado,nombre,apellidos,sexo,f_baja into :id_col,:nom_col,:ape_col,:sexo,:f_baja from colegiados where n_colegiado=:ist_datos.n_colegiado;

if sexo='M' then
	ape_col='D. '+nom_col+' '+ape_col
else
	ape_col='D$$HEX1$$f100$$ENDHEX$$a. '+nom_col+ ' '+ape_col
end if
ist_datos.nombre=ape_col
if Not(IsNull(f_defuncion)) then f_baja=f_defuncion


if tipo='I' then
	ist_datos.destinatario_nombre='INSPECCION DE TRABAJO'
	ist_datos.destinatario_nombre2='Administraci$$HEX1$$f300$$ENDHEX$$n Perif$$HEX1$$e900$$ENDHEX$$rica del Estado'
	ist_datos.destinatario_emplaz  ='C/ Miquel Capllonch, 12 - 3$$HEX1$$ba00$$ENDHEX$$'
	ist_datos.destinatario_poblacion = '07010 - Palma de Mallorca'		
else
	ist_datos.destinatario_nombre='CONSELLERIA DE TRABAJO'
	ist_datos.destinatario_nombre2  ='Plaza del Caudillo S/N'
	ist_datos.destinatario_emplaz  ='Pol$$HEX1$$ed00$$ENDHEX$$gono Son Castell$$HEX1$$f300$$ENDHEX$$'
	ist_datos.destinatario_poblacion = '07009 - Palma de Mallorca'		
end if
						

for i=1 to ds_fases_exp_abiertos.rowcount()

	pob=ds_fases_exp_abiertos.GetItemString(i,'poblacion')

	select p.descripcion,pr.nombre into :poblacion,:provincia from poblaciones p,provincias pr 
	where p.cod_pob=:pob and p.provincia=pr.cod_provincia;
	ist_datos.t_act = ds_fases_exp_abiertos.GetItemString(i,'fase')
	ist_datos.municipio = poblacion + ' ('+provincia+') '
	ist_datos.id_fase = ds_fases_exp_abiertos.GetItemString(i,'id_fase')
	ist_datos.tipo_via=ds_fases_exp_abiertos.GetItemString(i,'tipo_via_emplazamiento')
	ist_datos.emplaz=ds_fases_exp_abiertos.GetItemString(i,'emplazamiento')	
	ist_datos.n_calle=ds_fases_exp_abiertos.GetItemString(i,'n_calle')	
	ist_datos.piso=ds_fases_exp_abiertos.GetItemString(i,'piso')	
	ist_datos.puerta=ds_fases_exp_abiertos.GetItemString(i,'puerta')		
	ist_datos.encargo=ds_fases_exp_abiertos.GetItemString(i,'descripcion')
	ist_datos.n_visado=ds_fases_exp_abiertos.GetItemString(i,'archivo')
	ist_datos.f_visado=ds_fases_exp_abiertos.GetItemDateTime(i,'f_visado')
	ist_datos.clientes=f_clientes_fases(ist_datos.id_fase)
	ist_datos.arquitectos=f_arquitectos_fases(ist_datos.id_fase)
	emplazamiento=ist_datos.emplaz
	
	string d_tipo_via
	select descripcion into :d_tipo_via from tipos_via where cod_tipo_via=:ist_datos.tipo_via;
	ist_datos.tipo_via=d_tipo_via	

	if not(f_es_vacio(ist_datos.tipo_via)) and ist_datos.tipo_via<>'-' then emplazamiento=ist_datos.tipo_via + ' '+emplazamiento
	if not(f_es_vacio(ist_datos.n_calle)) then emplazamiento+=', '+ist_datos.n_calle
	if not(f_es_vacio(ist_datos.piso)) then emplazamiento+=' piso '+ist_datos.piso	
	if not(f_es_vacio(ist_datos.puerta)) then emplazamiento+=' puerta '+ist_datos.puerta			
	ist_datos.emplaz=emplazamiento
	if left(ist_datos.t_act,1)<>'0' then continue
	
	uo_impresion.expediente	=	ds_fases_exp_abiertos.GetItemString(i,'n_registro')
	uo_impresion.n_expedi	=ist_datos.id_fase	
	uo_impresion.asunto_registro='CARTA DEFUNCION COLEGIADO '+ist_datos.n_colegiado+' - '+ape_col+'. N$$HEX2$$ba002000$$ENDHEX$$Registro: '+ds_fases_exp_abiertos.GetItemString(i,'n_registro')
	uo_impresion.referencia=ist_datos.id_fase
	event csd_rellenar_carta(ist_datos,ds_carta_inspec)		
next

if tipo='I' then	
	uo_impresion.receptor='INSPECCION DE TRABAJO'
	uo_impresion.nombre='carta_defuncion_inspec_col_'+ist_datos.n_colegiado
else
	uo_impresion.tipo_receptor='O'
	uo_impresion.receptor='CONSELLERIA DE TRABAJO'
	uo_impresion.nombre='carta_defuncion_consell_col_'+ist_datos.n_colegiado					
end if
uo_impresion.tipo_receptor='O'
uo_impresion.dw=ds_carta_inspec
uo_impresion.f_impresion()			
	
	
end event

event csd_generar_carta_cliente();string id_col,nom_col,ape_col,sexo,pob
long tot,i,fila,j,z
datetime f_baja,f_defuncion
string n_col
string n_calle,piso,puerta,tipo_via,emplaz,emplazamiento
string poblacion,provincia
string id_cli,dest_nom,dest_ape,dest_tipo_via, dest_nombre_via, dest_cod_pos, dest_poblacion, dest_provincia
datastore ds,ds_clientes
datastore ds_fases_exp_abiertos_cli
string id_cli_anterior

ds= create datastore
ds.dataobject='d_carta_defuncion_cliente_mca'
ds.SetTransObject(SQLCA)

ds.reset()

select id_colegiado,nombre,apellidos,sexo,f_baja into :id_col,:nom_col,:ape_col,:sexo,:f_baja from colegiados where n_colegiado=:ist_datos.n_colegiado;

ds_fases_exp_abiertos_cli= create datastore
ds_fases_exp_abiertos_cli.dataobject='d_fases_exp_abiertos_cli_mca'
ds_fases_exp_abiertos_cli.SetTransObject(SQLCA)
tot=ds_fases_exp_abiertos_cli.retrieve(id_col)


if sexo='M' then
	ape_col='D. '+nom_col+' '+ape_col
else
	ape_col='D$$HEX1$$f100$$ENDHEX$$a. '+nom_col+ ' '+ape_col
end if
ist_datos.nombre=ape_col
if Not(IsNull(f_defuncion)) then f_baja=f_defuncion

	

id_cli_anterior=''
for i=1 to ds_fases_exp_abiertos_cli.rowcount()	
	//if i=100 then exit

	id_cli=ds_fases_exp_abiertos_cli.GetItemString(i,'id_cliente')
	
	if id_cli<>id_cli_anterior and i>1 and ds.rowcount()>0 then
		id_cli_anterior=id_cli
		ds.SetSort("destinatario A")
		ds.Sort()
		ds.GroupCalc()		
		uo_impresion.dw=ds
		uo_impresion.tipo_receptor='T'
		uo_impresion.id_receptor=id_cli
		uo_impresion.nombre='carta_defuncion_promotor_col_'+ist_datos.n_colegiado
		uo_impresion.f_impresion()
		ds.reset()
	end if
	pob=ds_fases_exp_abiertos_cli.GetItemString(i,'poblacion')

	select p.descripcion,pr.nombre into :poblacion,:provincia from poblaciones p,provincias pr 
	where p.cod_pob=:pob and p.provincia=pr.cod_provincia;
	ist_datos.t_act = ds_fases_exp_abiertos_cli.GetItemString(i,'fase')
	ist_datos.municipio = poblacion + ' ('+provincia+') '
	ist_datos.id_fase = ds_fases_exp_abiertos_cli.GetItemString(i,'id_fase')
	ist_datos.tipo_via=ds_fases_exp_abiertos_cli.GetItemString(i,'tipo_via_emplazamiento')
	ist_datos.emplaz=ds_fases_exp_abiertos_cli.GetItemString(i,'emplazamiento')	
	ist_datos.n_calle=ds_fases_exp_abiertos_cli.GetItemString(i,'n_calle')	
	ist_datos.piso=ds_fases_exp_abiertos_cli.GetItemString(i,'piso')	
	ist_datos.puerta=ds_fases_exp_abiertos_cli.GetItemString(i,'puerta')		
	ist_datos.encargo=ds_fases_exp_abiertos_cli.GetItemString(i,'descripcion')
	ist_datos.n_visado=ds_fases_exp_abiertos_cli.GetItemString(i,'archivo')
	ist_datos.f_visado=ds_fases_exp_abiertos_cli.GetItemDateTime(i,'f_visado')
	ist_datos.clientes=f_clientes_fases(ist_datos.id_fase)
	ist_datos.arquitectos=f_arquitectos_fases(ist_datos.id_fase)
	emplazamiento=ist_datos.emplaz
	
	string d_tipo_via
	select descripcion into :d_tipo_via from tipos_via where cod_tipo_via=:ist_datos.tipo_via;
	ist_datos.tipo_via=d_tipo_via

	if not(f_es_vacio(ist_datos.tipo_via)) and ist_datos.tipo_via<>'-' then emplazamiento=ist_datos.tipo_via + ' '+emplazamiento
	if not(f_es_vacio(ist_datos.n_calle)) then emplazamiento+=', '+ist_datos.n_calle
	if not(f_es_vacio(ist_datos.piso)) then emplazamiento+=' piso '+ist_datos.piso	
	if not(f_es_vacio(ist_datos.puerta)) then emplazamiento+=' puerta '+ist_datos.puerta			
	ist_datos.emplaz=emplazamiento
	
	uo_impresion.expediente	=	ds_fases_exp_abiertos_cli.GetItemString(i,'n_registro')
	uo_impresion.n_expedi	=ist_datos.id_fase	
	uo_impresion.asunto_registro='CARTA DEFUNCION COLEGIADO '+ist_datos.n_colegiado+' - '+ape_col+'. N$$HEX2$$ba002000$$ENDHEX$$Registro: '+ds_fases_exp_abiertos_cli.GetItemString(i,'n_registro')
	uo_impresion.referencia=ist_datos.id_fase

	dest_nom=''
	dest_ape=''

	select c.nombre,c.apellidos,v.descripcion,c.nombre_via
	into :dest_nom,:dest_ape,:dest_tipo_via,:dest_nombre_via
	from clientes c,tipos_via v where c.tipo_via=v.cod_tipo_via and c.id_cliente=:id_cli;

	select p.cod_pos,p.descripcion,pr.nombre
	into :dest_cod_pos,:dest_poblacion,:dest_provincia
	from clientes c,poblaciones p,provincias pr where c.id_cliente=:id_cli and c.cod_pob=p.cod_pob and p.provincia=pr.cod_provincia;
		
	if f_es_vacio(dest_nom) then
		dest_nom=dest_ape
	else
		dest_nom=dest_nom+' '+dest_ape
	end if
	
	if not(f_es_vacio(dest_tipo_via)) and dest_tipo_via<>'-' then
		dest_nombre_via=dest_tipo_via+ dest_nombre_via
	end if
	
	ist_datos.destinatario_nombre=dest_nom
	ist_datos.destinatario_emplaz  =dest_nombre_via
	ist_datos.destinatario_poblacion = dest_cod_pos+' - '+dest_poblacion+' ('+dest_provincia+') '
	
	event csd_rellenar_carta(ist_datos,ds)

	id_cli_anterior=id_cli
next

	
end event

event csd_generar_carta_ayuntamiento();string id_col,nom_col,ape_col,sexo,pob
long tot,i,fila,j,z
datetime f_baja,f_defuncion
string n_col
string n_calle,piso,puerta,tipo_via,emplaz,emplazamiento
string poblacion,provincia
string id_cli,dest_nom,dest_ape,dest_tipo_via, dest_nombre_via, dest_cod_pos, dest_poblacion, dest_provincia
datastore ds,ds_clientes
datastore ds_fases_exp_abiertos_cli
string municipio,m_direc,m_cp
string municipio_anterior

ds= create datastore
ds.dataobject='d_carta_defuncion_ayto_mca'
ds.SetTransObject(SQLCA)

ds.reset()

select id_colegiado,nombre,apellidos,sexo,f_baja into :id_col,:nom_col,:ape_col,:sexo,:f_baja from colegiados where n_colegiado=:ist_datos.n_colegiado;

ds_fases_exp_abiertos_cli= create datastore
ds_fases_exp_abiertos.dataobject='d_fases_exp_abiertos_mca'
ds_fases_exp_abiertos.SetTransObject(SQLCA)
tot=ds_fases_exp_abiertos.retrieve(id_col)

ds_fases_exp_abiertos.SetSort('pob_mopu a')
ds_fases_exp_abiertos.Sort()

if sexo='M' then
	ape_col='D. '+nom_col+' '+ape_col
else
	ape_col='D$$HEX1$$f100$$ENDHEX$$a. '+nom_col+ ' '+ape_col
end if
ist_datos.nombre=ape_col
if Not(IsNull(f_defuncion)) then f_baja=f_defuncion



municipio_anterior=''
for i=1 to ds_fases_exp_abiertos.rowcount()	
	if left(ds_fases_exp_abiertos.GetItemString(i,'fase'),1)<>'1' then continue		

	pob=ds_fases_exp_abiertos.GetItemString(i,'poblacion')
	m_direc=''
	m_cp=''	
	municipio=''	
	
	select m.descripcion,m.direccion,m.cp into :municipio,:m_direc,:m_cp 
	from poblaciones p,municipios m
	where p.provincia='00007' and p.cod_pob=:pob and p.pob_mopu=m.cod_muni
	and m.provincia='00007';
	
	if municipio<>municipio_anterior and i>1 and ds.rowcount()>0 then
		municipio_anterior=municipio
		ds.SetSort("destinatario A")
		ds.Sort()

		uo_impresion.expediente	=	ds_fases_exp_abiertos.GetItemString(i,'n_registro')
		uo_impresion.n_expedi	=ist_datos.id_fase	
		uo_impresion.asunto_registro='CARTA DEFUNCION COLEGIADO '+ist_datos.n_colegiado+' - '+ape_col+'. N$$HEX2$$ba002000$$ENDHEX$$Registro: '+ds_fases_exp_abiertos.GetItemString(i,'n_registro')
		uo_impresion.referencia=ist_datos.id_fase

		uo_impresion.dw=ds
		uo_impresion.tipo_receptor='T'
		uo_impresion.id_receptor=id_cli
		uo_impresion.nombre='carta_defuncion_ayto_col_'+ist_datos.n_colegiado
		uo_impresion.f_impresion()

		ds.reset()
	end if


	select p.descripcion,pr.nombre into :poblacion,:provincia from poblaciones p,provincias pr 
	where p.cod_pob=:pob and p.provincia=pr.cod_provincia;
	ist_datos.t_act = ds_fases_exp_abiertos.GetItemString(i,'fase')
	ist_datos.municipio = poblacion + ' ('+provincia+') '
	ist_datos.id_fase = ds_fases_exp_abiertos.GetItemString(i,'id_fase')
	ist_datos.tipo_via=ds_fases_exp_abiertos.GetItemString(i,'tipo_via_emplazamiento')
	ist_datos.emplaz=ds_fases_exp_abiertos.GetItemString(i,'emplazamiento')	
	ist_datos.n_calle=ds_fases_exp_abiertos.GetItemString(i,'n_calle')	
	ist_datos.piso=ds_fases_exp_abiertos.GetItemString(i,'piso')	
	ist_datos.puerta=ds_fases_exp_abiertos.GetItemString(i,'puerta')		
	ist_datos.encargo=ds_fases_exp_abiertos.GetItemString(i,'descripcion')
	ist_datos.n_visado=ds_fases_exp_abiertos.GetItemString(i,'archivo')
	ist_datos.f_visado=ds_fases_exp_abiertos.GetItemDateTime(i,'f_visado')
	ist_datos.clientes=f_clientes_fases(ist_datos.id_fase)
	ist_datos.arquitectos=f_arquitectos_fases(ist_datos.id_fase)
	emplazamiento=ist_datos.emplaz
	
	string d_tipo_via
	select descripcion into :d_tipo_via from tipos_via where cod_tipo_via=:ist_datos.tipo_via;
	ist_datos.tipo_via=d_tipo_via

	if not(f_es_vacio(ist_datos.tipo_via)) and ist_datos.tipo_via<>'-' then emplazamiento=ist_datos.tipo_via + ' '+emplazamiento
	if not(f_es_vacio(ist_datos.n_calle)) then emplazamiento+=', '+ist_datos.n_calle
	if not(f_es_vacio(ist_datos.piso)) then emplazamiento+=' piso '+ist_datos.piso	
	if not(f_es_vacio(ist_datos.puerta)) then emplazamiento+=' puerta '+ist_datos.puerta			
	ist_datos.emplaz=emplazamiento
		
	ist_datos.destinatario_nombre='AYUNTAMIENTO DE '+poblacion
	ist_datos.destinatario_emplaz  =m_direc
	ist_datos.destinatario_poblacion = m_cp+' - '+poblacion+' (BALEARES) '
	
	event csd_rellenar_carta(ist_datos,ds)

	municipio_anterior=municipio
next


end event

event csd_generar_carta_arq();	/*			case 3  // COLEGIO DE ARQUITECTOS
					if dw_1.GetItemString(1,'col_arq')<>'S' then continue
					ist_datos.destinatario_nombre='COLEGIO DE ARQUITECTOS DE BALEARES'
					ist_datos.destinatario_emplaz  ='C/ Portella 14'
					ist_datos.destinatario_poblacion = '07001 - Palma de Mallorca'					
	
					event csd_rellenar_carta(ist_datos,ds_carta_col_arq)
					uo_impresion.dw=ds_carta_col_arq
					uo_impresion.tipo_receptor='O'
					uo_impresion.receptor='COLEGIO DE ARQUITECTOS DE BALEARES'
					uo_impresion.nombre='carta_defuncion_colarq_col_'+ist_datos.n_colegiado
					
					uo_impresion.f_impresion()*/
					
				
	string id_col,nom_col,ape_col,sexo,pob
long tot,i,fila,j,z
datetime f_baja,f_defuncion
string n_col
string n_calle,piso,puerta,tipo_via,emplaz,emplazamiento
string poblacion,provincia
string id_cli,dest_nom,dest_ape,dest_tipo_via, dest_nombre_via, dest_cod_pos, dest_poblacion, dest_provincia
datastore ds_clientes
datastore ds_carta_col_arq

ds_carta_col_arq= create datastore
ds_carta_col_arq.dataobject='d_carta_defuncion_col_arq_mca'
ds_carta_col_arq.SetTransObject(SQLCA)

ds_carta_col_arq.reset()

select id_colegiado,nombre,apellidos,sexo,f_baja into :id_col,:nom_col,:ape_col,:sexo,:f_baja from colegiados where n_colegiado=:ist_datos.n_colegiado;

if sexo='M' then
	ape_col='D. '+nom_col+' '+ape_col
else
	ape_col='D$$HEX1$$f100$$ENDHEX$$a. '+nom_col+ ' '+ape_col
end if
ist_datos.nombre=ape_col
if Not(IsNull(f_defuncion)) then f_baja=f_defuncion



ist_datos.destinatario_nombre='COLEGIO DE ARQUITECTOS DE BALEARES'
ist_datos.destinatario_emplaz  ='C/ Portella 14'
ist_datos.destinatario_poblacion = '07001 - Palma de Mallorca'		



for i=1 to ds_fases_exp_abiertos.rowcount()

	pob=ds_fases_exp_abiertos.GetItemString(i,'poblacion')

	select p.descripcion,pr.nombre into :poblacion,:provincia from poblaciones p,provincias pr 
	where p.cod_pob=:pob and p.provincia=pr.cod_provincia;
	ist_datos.t_act = ds_fases_exp_abiertos.GetItemString(i,'fase')
	ist_datos.municipio = poblacion + ' ('+provincia+') '
	ist_datos.id_fase = ds_fases_exp_abiertos.GetItemString(i,'id_fase')
	ist_datos.tipo_via=ds_fases_exp_abiertos.GetItemString(i,'tipo_via_emplazamiento')
	ist_datos.emplaz=ds_fases_exp_abiertos.GetItemString(i,'emplazamiento')	
	ist_datos.n_calle=ds_fases_exp_abiertos.GetItemString(i,'n_calle')	
	ist_datos.piso=ds_fases_exp_abiertos.GetItemString(i,'piso')	
	ist_datos.puerta=ds_fases_exp_abiertos.GetItemString(i,'puerta')		
	ist_datos.encargo=ds_fases_exp_abiertos.GetItemString(i,'descripcion')
	ist_datos.n_visado=ds_fases_exp_abiertos.GetItemString(i,'archivo')
	ist_datos.f_visado=ds_fases_exp_abiertos.GetItemDateTime(i,'f_visado')
	ist_datos.clientes=f_clientes_fases(ist_datos.id_fase)
	ist_datos.arquitectos=f_arquitectos_fases(ist_datos.id_fase)
	emplazamiento=ist_datos.emplaz

	string d_tipo_via
	select descripcion into :d_tipo_via from tipos_via where cod_tipo_via=:ist_datos.tipo_via;
	ist_datos.tipo_via=d_tipo_via

	if not(f_es_vacio(ist_datos.tipo_via)) and ist_datos.tipo_via<>'-' then emplazamiento=ist_datos.tipo_via + ' '+emplazamiento
	if not(f_es_vacio(ist_datos.n_calle)) then emplazamiento+=', '+ist_datos.n_calle
	if not(f_es_vacio(ist_datos.piso)) then emplazamiento+=' piso '+ist_datos.piso	
	if not(f_es_vacio(ist_datos.puerta)) then emplazamiento+=' puerta '+ist_datos.puerta			
	ist_datos.emplaz=emplazamiento
	if left(ist_datos.t_act,1)<>'0' then continue
	
	uo_impresion.expediente	=	ds_fases_exp_abiertos.GetItemString(i,'n_registro')
	uo_impresion.n_expedi	=ist_datos.id_fase	
	uo_impresion.asunto_registro='CARTA DEFUNCION COLEGIADO '+ist_datos.n_colegiado+' - '+ape_col+'. N$$HEX2$$ba002000$$ENDHEX$$Registro: '+ds_fases_exp_abiertos.GetItemString(i,'n_registro')
	uo_impresion.referencia=ist_datos.id_fase


	event csd_rellenar_carta(ist_datos,ds_carta_col_arq)		
next

	uo_impresion.dw=ds_carta_col_arq
	uo_impresion.tipo_receptor='O'
	uo_impresion.receptor='COLEGIO DE ARQUITECTOS DE BALEARES'
	uo_impresion.nombre='carta_defuncion_colarq_col_'+ist_datos.n_colegiado
uo_impresion.f_impresion()			
	
	
end event

on w_cartas_defuncion_generacion.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_salir=create cb_salir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_salir
end on

on w_cartas_defuncion_generacion.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_salir)
end on

event open;call super::open;string nom,ape
ist_datos=Message.PowerObjectParm

dw_1.insertrow(0)
if not(f_es_vacio(ist_datos.n_colegiado)) then 
	dw_1.SetItem(1,'n_col',ist_datos.n_colegiado)
	select nombre,apellidos into :nom,:ape from colegiados where n_colegiado=:ist_datos.n_colegiado;
	dw_1.SetItem(1,'nombre_col',nom+' '+ape)
	
end if
if not(IsNull(ist_datos.f_defuncion)) then dw_1.SetItem(1,'f_defuncion',ist_datos.f_defuncion)
dw_1.SetItem(1,'fecha',datetime(today()))
f_centrar_ventana(this)
end event

event pfc_postopen;call super::pfc_postopen;dw_1.of_SetDropDownCalendar(True)
dw_1.iuo_calendar.of_register(dw_1.iuo_calendar.DDLB)
dw_1.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_1.iuo_calendar.of_SetInitialValue(True)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_cartas_defuncion_generacion
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_cartas_defuncion_generacion
end type

type dw_1 from u_dw within w_cartas_defuncion_generacion
integer y = 52
integer width = 1792
integer height = 592
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_carta_defuncion_consulta"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type cb_1 from commandbutton within w_cartas_defuncion_generacion
integer x = 443
integer y = 712
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;dw_1.AcceptText()

uo_impresion= create n_csd_impresion_formato

uo_impresion.papel='S'
uo_impresion.pdf='X'
uo_impresion.sms='X'
uo_impresion.email='X'
uo_impresion.copias=1
uo_impresion.generar_registro='S'
uo_impresion.masivo=TRUE
if uo_impresion.f_opciones_impresion()=-1 then return
event csd_generar_carta_defuncion()

close(parent)
end event

type cb_salir from commandbutton within w_cartas_defuncion_generacion
integer x = 896
integer y = 712
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
string text = "Salir"
end type

event clicked;close(parent)
end event

