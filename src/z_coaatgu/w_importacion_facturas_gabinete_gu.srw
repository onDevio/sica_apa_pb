HA$PBExportHeader$w_importacion_facturas_gabinete_gu.srw
forward
global type w_importacion_facturas_gabinete_gu from w_sheet
end type
type cb_impr from commandbutton within w_importacion_facturas_gabinete_gu
end type
type cb_importar from commandbutton within w_importacion_facturas_gabinete_gu
end type
type cb_procesar from commandbutton within w_importacion_facturas_gabinete_gu
end type
type tab_1 from tab within w_importacion_facturas_gabinete_gu
end type
type tabpage_1 from userobject within tab_1
end type
type cb_imprimir from commandbutton within tabpage_1
end type
type dw_incidencias from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_imprimir cb_imprimir
dw_incidencias dw_incidencias
end type
type tabpage_3 from userobject within tab_1
end type
type cb_imprimir2 from commandbutton within tabpage_3
end type
type dw_clientes from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cb_imprimir2 cb_imprimir2
dw_clientes dw_clientes
end type
type tabpage_6 from userobject within tab_1
end type
type cb_imprimir3 from commandbutton within tabpage_6
end type
type dw_articulos from u_dw within tabpage_6
end type
type tabpage_6 from userobject within tab_1
cb_imprimir3 cb_imprimir3
dw_articulos dw_articulos
end type
type tabpage_4 from userobject within tab_1
end type
type cb_imprimir4 from commandbutton within tabpage_4
end type
type dw_poblaciones from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_1
cb_imprimir4 cb_imprimir4
dw_poblaciones dw_poblaciones
end type
type tabpage_5 from userobject within tab_1
end type
type cb_imprimir5 from commandbutton within tabpage_5
end type
type dw_formas_pago from u_dw within tabpage_5
end type
type tabpage_5 from userobject within tab_1
cb_imprimir5 cb_imprimir5
dw_formas_pago dw_formas_pago
end type
type tabpage_2 from userobject within tab_1
end type
type dw_facturas_lineas from u_dw within tabpage_2
end type
type dw_facturas from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_facturas_lineas dw_facturas_lineas
dw_facturas dw_facturas
end type
type tab_1 from tab within w_importacion_facturas_gabinete_gu
tabpage_1 tabpage_1
tabpage_3 tabpage_3
tabpage_6 tabpage_6
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_2 tabpage_2
end type
type cb_grabar_elementos from commandbutton within w_importacion_facturas_gabinete_gu
end type
type cb_grabar_facturas from commandbutton within w_importacion_facturas_gabinete_gu
end type
type dw_temporal from u_dw within w_importacion_facturas_gabinete_gu
end type
type cb_ver_todas from commandbutton within w_importacion_facturas_gabinete_gu
end type
type dw_clientes_terceros from u_dw within w_importacion_facturas_gabinete_gu
end type
type st_progreso from statictext within w_importacion_facturas_gabinete_gu
end type
type dw_fichero from u_dw within w_importacion_facturas_gabinete_gu
end type
end forward

global type w_importacion_facturas_gabinete_gu from w_sheet
integer x = 201
integer y = 324
integer width = 4119
integer height = 2576
string title = "Importaci$$HEX1$$f300$$ENDHEX$$n de Facturas"
windowstate windowstate = maximized!
boolean ib_isupdateable = false
event csd_aplicar_filtros ( long fila )
cb_impr cb_impr
cb_importar cb_importar
cb_procesar cb_procesar
tab_1 tab_1
cb_grabar_elementos cb_grabar_elementos
cb_grabar_facturas cb_grabar_facturas
dw_temporal dw_temporal
cb_ver_todas cb_ver_todas
dw_clientes_terceros dw_clientes_terceros
st_progreso st_progreso
dw_fichero dw_fichero
end type
global w_importacion_facturas_gabinete_gu w_importacion_facturas_gabinete_gu

type variables
string is_prefijo_clientes_gabinete
string is_prefijo_articulos_gabinete = 'G'
string is_serie_facturas_gabinete
string is_centro_facturas_gabinete
// Para los esclavos
u_dw idw_poblaciones, idw_formas_pago, idw_articulos, idw_clientes, idw_incidencias, idw_facturas, idw_facturas_lineas

boolean ib_filtrar = true, ib_procesando = false
boolean ib_procesar_poblaciones = false
end variables

forward prototypes
public function string wf_validar_facturas ()
public subroutine wf_vaciar_dw ()
public function string wf_validar_poblaciones ()
public function string wf_validar_clientes ()
public function string wf_validar_articulos ()
public function string wf_validar_f_pago ()
public function string wf_comprueba_articulo (long fila)
public function string wf_comprueba_forma_pago (long fila)
public function string wf_comprueba_poblacion (long fila)
public function string wf_cuenta_cliente (string codigo)
public function string wf_crear_factura (long fila, string id_cliente, string id_poblacion, string articulo, string forma_pago)
public subroutine wf_colocar_incidencia (long fila, string elemento, string texto, string confirmar, string crear, string tipo)
public function string wf_comprueba_cliente (long fila, string poblacion)
end prototypes

event csd_aplicar_filtros(long fila);// FUNCION QUE SE ENCARGA DE APLICAR LOS FILTROS A TODOS LOS DW!

string filtro

// Mientras se procesa no se filtra!!
if ib_procesando then return

if not ib_filtrar then
	// Quitamos todos los filtros de los dw
	filtro = ''
	ib_filtrar = true
else
	IF fila<1 or fila> dw_fichero.RowCount() then return
	// Aplicamos el filtro
	filtro = "id_pedido = '"+dw_fichero.GetitemString(fila, 'id_pedido')+"'"
end if

idw_poblaciones.setfilter(filtro)
idw_poblaciones.filter()
idw_formas_pago.setfilter(filtro)
idw_formas_pago.filter()
idw_articulos.setfilter(filtro)
idw_articulos.filter()
idw_clientes.setfilter(filtro)
idw_clientes.filter()
idw_incidencias.setfilter(filtro)
idw_incidencias.filter()
idw_facturas.setfilter(filtro)
idw_facturas.filter()
if filtro = '' then
	idw_facturas_lineas.setfilter(filtro)
	idw_facturas_lineas.filter()
end if
	

end event

public function string wf_validar_facturas ();string mensaje = ''


mensaje=mensaje + f_valida(idw_facturas,'fecha','NONULO','Debe especificar un valor en el campo Fecha.')
mensaje=mensaje + f_valida(idw_facturas,'nif','NOVACIO','Debe especificar un valor en el campo NIF.')
mensaje=mensaje + f_valida(idw_facturas,'tipo_factura','NOVACIO','Debe especificar un valor en el campo Tipo de factura.')
mensaje=mensaje + f_valida(idw_facturas,'nombre','NOVACIO','Debe especificar un valor en el campo Nombre.')
mensaje=mensaje + f_valida(idw_facturas,'domicilio','NOVACIO','Debe especificar un valor en el campo Domicilio.')
mensaje=mensaje + f_valida(idw_facturas,'poblacion','NOVACIO','Debe especificar un valor en el campo Poblaci$$HEX1$$f300$$ENDHEX$$n.')

mensaje=mensaje + f_valida(idw_facturas_lineas,'t_iva','NOVACIO','Debe especificar un valor en el campo Tipo de IVA.')
mensaje=mensaje + f_valida(idw_facturas_lineas,'articulo','NOVACIO','Debe especificar un valor en el campo Art$$HEX1$$ed00$$ENDHEX$$culo.')

return mensaje
end function

public subroutine wf_vaciar_dw ();// Reseteamos los dw
idw_articulos.reset()
idw_poblaciones.reset()
idw_formas_pago.reset()
idw_clientes.reset()
idw_incidencias.reset()
idw_facturas.reset()
idw_facturas_lineas.reset()

st_progreso.text = ''

end subroutine

public function string wf_validar_poblaciones ();string mensaje = ''
int fila, res, retorno=1
long ll_pos_en_dw1[]

mensaje += f_valida(idw_poblaciones,'cod_pos','NOVACIO','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo Postal.'+cr)
mensaje += f_valida(idw_poblaciones,'descripcion','NOVACIO','Debe especificar un valor en el campo Descripci$$HEX1$$f300$$ENDHEX$$n.'+cr)
mensaje += f_valida(idw_poblaciones,'provincia','NOVACIO','Debe especificar un valor en el campo Provincia.'+cr)

//Andr$$HEX1$$e900$$ENDHEX$$s 9/2/05
//Ponemos en un dw las filas de la bd mas las a$$HEX1$$f100$$ENDHEX$$adidas por el usuario
dw_temporal.dataobject='d_mant_poblaciones'
dw_temporal.settransobject(sqlca)
dw_temporal.retrieve()


//Copiamos las filas nuevas al dw_temporal
for fila=1 to idw_poblaciones.Rowcount()
	if idw_poblaciones.GetItemStatus( fila,0, Primary!) = NewModified! then
		//idw_poblaciones.rowscopy(fila,fila,Primary!,dw_temporal,dw_temporal.rowcount(),Primary!)
		dw_temporal.insertrow(0)
		dw_temporal.setitem(dw_temporal.rowcount(), 'cod_pob', idw_poblaciones.GetItemString(fila, 'cod_pos'))// Ponemos directamente el codigo postal!
		dw_temporal.setitem(dw_temporal.rowcount(), 'cod_pos', idw_poblaciones.GetItemString(fila, 'cod_pos'))
		dw_temporal.setitem(dw_temporal.rowcount(), 'descripcion', idw_poblaciones.GetItemString(fila, 'descripcion'))
		dw_temporal.setitem(dw_temporal.rowcount(), 'provincia', idw_poblaciones.GetItemString(fila, 'provincia'))
		dw_temporal.setitem(dw_temporal.rowcount(), 'pob_mopu', idw_poblaciones.GetItemString(fila, 'pob_mopu'))
		dw_temporal.setitem(dw_temporal.rowcount(), 'tipo', idw_poblaciones.GetItemString(fila, 'tipo'))
		
		ll_pos_en_dw1[dw_temporal.rowcount()-1]=fila
	END IF
next

//comprobamos si hay claves primarias duplicadas (cod_pos)
for fila=1 to dw_temporal.rowcount()
	if dw_temporal.GetItemStatus( fila,0, Primary!) = NewModified! then
			res = f_busca_duplicados_colum_dw (dw_temporal, 'cod_pob', fila)
		if res>0 then
			mensaje=mensaje+'El C$$HEX1$$f300$$ENDHEX$$digo postal de la fila:'+string(ll_pos_en_dw1[fila])+' est$$HEX2$$e1002000$$ENDHEX$$repetido. Introduzca un valor diferente'+cr
		end if
	end if
next
//fin Andr$$HEX1$$e900$$ENDHEX$$s 9/2/2005

return mensaje

end function

public function string wf_validar_clientes ();string mensaje = ''
if f_puedo_escribir(g_usuario, '0000000006')= -1 then return '-1'

//mensaje=mensaje + f_valida(dw_1,'n_cliente','NOVACIO','Debe especificar un valor en el campo n$$HEX1$$fa00$$ENDHEX$$mero de cliente')
mensaje=mensaje + f_valida(idw_clientes,'apellidos','NOVACIO','Debe especificar un valor en el campo apellidos')

return mensaje	

end function

public function string wf_validar_articulos ();string mensaje = ''

mensaje = f_valida(idw_articulos, 'codigo_articulo', 'NONULO', "Debe indicar la relaci$$HEX1$$f300$$ENDHEX$$n con c$$HEX1$$f300$$ENDHEX$$digo de art$$HEX1$$ed00$$ENDHEX$$culo del SICA")

return mensaje


// C$$HEX1$$f300$$ENDHEX$$digo anterior
//string mensaje = ''
//
//mensaje += f_valida(idw_articulos,'codigo','NOVACIO','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo.')
//mensaje += f_valida(idw_articulos,'cuenta','NOVACIO','Debe especificar un valor en el campo Cuenta.')
////mensaje += f_valida(idw_articulos,'cta_presupuestaria','NOVACIO','Debe especificar un valor en el campo Cta. Presupuestaria.'+cr)
//mensaje += f_valida(idw_articulos,'exp','NOVACIO','Debe especificar un valor en el campo Exp.')
//mensaje += f_valida(idw_articulos,'general','NOVACIO','Debe especificar un valor en el campo General.')
//mensaje += f_valida(idw_articulos,'importe','NOCERO','Debe especificar un valor en el campo Importe.')
//mensaje += f_valida(idw_articulos,'impuesto','NOCERO','Debe especificar un valor en el campo Impuesto.')
//mensaje += f_valida(idw_articulos,'activo','NOVACIO','Debe especificar un valor en el campo Activo.')
//
//
//return mensaje
end function

public function string wf_validar_f_pago ();string mensaje = ''

mensaje = f_valida(idw_formas_pago, 'tipo_pago', 'NONULO', "Debe indicar la relaci$$HEX1$$f300$$ENDHEX$$n con una forma de pago del SICA")

return mensaje
end function

public function string wf_comprueba_articulo (long fila);string articulo_fich, articulo, desc_articulo_fich
long n_reg, fila_insert
	
// MIRAMOS SI LA FORMA DE PAGO EXISTE EXISTE
articulo_fich = string(dw_fichero.GetitemNumber(fila, 'id_producto'))
desc_articulo_fich = string(dw_fichero.GetitemString(fila, 'nombre_producto'))

select count(*) into :n_reg from csi_art_serv_correspo where articulo_externo = :articulo_fich;
if n_reg = 1 then
	select codigo_articulo into :articulo from csi_art_serv_correspo where articulo_externo = :articulo_fich;
else
	// Hacemos una incidencia
	if f_es_vacio(articulo_fich) then
		// Colocamos la incidencia
		wf_colocar_incidencia(fila, 'ARTICULO', "No existe art$$HEX1$$ed00$$ENDHEX$$culo en la factura. Indicar una en la previsualizaci$$HEX1$$f300$$ENDHEX$$n del fichero y procesar nuevamente", 'N', 'N','L')
		articulo = ''
	else	
		// Metemos una linea por si quiere definir la correspondencia.
		if idw_articulos.find("articulo_externo ='"+articulo_fich+"'", 1, idw_articulos.RowCount()) = 0 then
			fila_insert = idw_articulos.insertrow(0)
			idw_articulos.setitem(fila_insert, 'id_pedido', dw_fichero.GetitemString(fila, 'id_pedido'))
			idw_articulos.setitem(fila_insert, 'articulo_externo', articulo_fich)
			idw_articulos.setitem(fila_insert, 'desc_articulo_externo', desc_articulo_fich)
			
			// Colocamos la incidencia
			wf_colocar_incidencia(fila, 'ARTICULO', "La correspondencia del art$$HEX1$$ed00$$ENDHEX$$culo de la factura y de SICA no est$$HEX2$$e1002000$$ENDHEX$$definida en el sistema", 'N', 'N','G')
			articulo = '-1'
		end if
	end if
	
	
end if	
return articulo


// C$$HEX1$$f300$$ENDHEX$$digo antiguo
//string cod_articulo, nombre_articulo
//long n_reg, fila_insert
//	
//// MIRAMOS SI EL ARTICULO EXISTE
//cod_articulo = is_prefijo_articulos_gabinete+string(dw_fichero.GetitemNumber(fila, 'id_producto'))
//nombre_articulo = dw_fichero.GetitemString(fila, 'nombre_producto')
//
//select count(*) into :n_reg from csi_articulos_servicios where codigo = :cod_articulo;
//
//if n_reg = 1 then
//	// Perfecto, encontramos el articulo
//else
//	// Hay que hacer el codigo necesario para agregar el articulo....pero si no est$$HEX2$$e1002000$$ENDHEX$$ya, claro!
//	if idw_articulos.find("codigo ='"+cod_articulo+"'", 1, idw_articulos.RowCount()) = 0 then
//		fila_insert = idw_articulos.insertrow(0)
//		idw_articulos.setitem(fila_insert, 'id_pedido', dw_fichero.GetitemString(fila, 'id_pedido'))
//	
//		idw_articulos.setitem(fila_insert, 'codigo', cod_articulo)
//		idw_articulos.setitem(fila_insert, 'descripcion', nombre_articulo)
//		idw_articulos.setitem(fila_insert, 'importe', dw_fichero.GetitemNumber(fila, 'precio_unidad'))
//		idw_articulos.setitem(fila_insert, 't_iva', right('00'+string(dw_fichero.GetitemNumber(fila, 'tipo_iva')),2))
//		idw_articulos.setitem(fila_insert, 'impuesto', dw_fichero.GetitemNumber(fila, 'iva'))
//		idw_articulos.setitem(fila_insert, 'colegio', g_colegio)
//		idw_articulos.setitem(fila_insert, 'empresa', g_empresa)
//		// Colocamos la incidencia
//		wf_colocar_incidencia(fila, 'ARTICULO', "El art$$HEX1$$ed00$$ENDHEX$$culo indicado no est$$HEX2$$e1002000$$ENDHEX$$definido en el sistema", 'N', 'N')
//		
//	end if
//	cod_articulo = '-1'
//end if
//
//return cod_articulo
end function

public function string wf_comprueba_forma_pago (long fila);string forma_pago_fich, forma_pago
long n_reg, fila_insert
	
// MIRAMOS SI LA FORMA DE PAGO EXISTE EXISTE
forma_pago_fich = dw_fichero.GetitemString(fila, 'forma_pago')

select count(*) into :n_reg from csi_formas_de_pago_correspo where forma_pago_externa = :forma_pago_fich;
if n_reg = 1 then
	select tipo_pago into :forma_pago from csi_formas_de_pago_correspo where forma_pago_externa = :forma_pago_fich;
else
	// Hacemos una incidencia
	if f_es_vacio(forma_pago_fich) then
		// Colocamos la incidencia
		wf_colocar_incidencia(fila, 'FORMA DE PAGO', "No existe forma de pago en la factura. Indicar una en la previsualizaci$$HEX1$$f300$$ENDHEX$$n del fichero y procesar nuevamente", 'N', 'N', 'L')
		forma_pago = '00'
		
	else	
		// Metemos una linea por si quiere definir la correspondencia.
		if idw_formas_pago.find("forma_pago_externa ='"+forma_pago_fich+"'", 1, idw_formas_pago.RowCount()) = 0 then
			fila_insert = idw_formas_pago.insertrow(0)
			idw_formas_pago.setitem(fila_insert, 'id_pedido', dw_fichero.GetitemString(fila, 'id_pedido'))
			idw_formas_pago.setitem(fila_insert, 'forma_pago_externa', forma_pago_fich)
			
			// Colocamos la incidencia
			wf_colocar_incidencia(fila, 'FORMA DE PAGO', "La correspondencia de la forma de pago de la factura y de SICA no est$$HEX2$$e1002000$$ENDHEX$$definida en el sistema", 'N', 'N', 'G')
		end if
		forma_pago = '-1'
	end if
	
end if
	
return forma_pago
end function

public function string wf_comprueba_poblacion (long fila);string id_poblacion, cod_postal, ciudad, cp, descrip
long n_reg, fila_insert

	
// MIRAMOS SI LA POBLACION EXISTE
cod_postal = trim(dw_fichero.GetitemString(fila, 'cod_postal'))
ciudad = trim(dw_fichero.GetitemString(fila, 'ciudad'))

select count(*) into :n_reg from poblaciones where cod_pos = :cod_postal and descripcion = :ciudad;
if n_reg = 1 then
	// Genial!, existe
	id_poblacion = cod_postal
else
	// Problemas... a ver como encontramos la poblacion... :'(
	select count(*) into :n_reg from poblaciones where cod_pos like :cod_postal+'%' and descripcion = :ciudad;
	if n_reg = 1 then
		// genial!
		select cod_pos into :id_poblacion from poblaciones where cod_pos like :cod_postal+'%' and descripcion = :ciudad;
	elseif n_reg = 0 then
		select count(*) into :n_reg from poblaciones where cod_pos like :cod_postal+'%';
		if n_reg = 1 then
			// Creemos que es esa poblacion, pero no estamos seguros
			select cod_pos, descripcion into :cp, :descrip from poblaciones where cod_pos like :cod_postal+'%';
			id_poblacion = '-1'
			
			// Colocamos la incidencia
			wf_colocar_incidencia(fila, 'POBLACI$$HEX1$$d300$$ENDHEX$$N', "La poblaci$$HEX1$$f300$$ENDHEX$$n "+ciudad +" (CP : "+cod_postal+") podr$$HEX1$$ed00$$ENDHEX$$a ser la poblaci$$HEX1$$f300$$ENDHEX$$n "+descrip +" (CP : "+cp+") del SICA.", 'S', 'S', 'G')
			
			
		elseif n_reg= 0 then
			// No hay ninguno con ese codigo, buscamos por descripcion
			select count(*) into :n_reg from poblaciones where descripcion like :ciudad+'%';
			if n_reg = 0 then
				// Hay que crearla y punto
				// Metemos una linea por si quiere definir la correspondencia.
				if idw_poblaciones.find("cod_pos ='"+cod_postal+"'", 1, idw_poblaciones.RowCount()) = 0 then
					fila_insert = idw_poblaciones.insertrow(0)
					idw_poblaciones.setitem(fila_insert, 'id_pedido', dw_fichero.GetitemString(fila, 'id_pedido'))
					idw_poblaciones.setitem(fila_insert, 'cod_pos', cod_postal)
					idw_poblaciones.setitem(fila_insert, 'descripcion', ciudad)
					idw_poblaciones.setitem(fila_insert, 'provincia', RightA('00000'+LeftA(cod_postal,2),5))
					idw_poblaciones.setitem(fila_insert, 'tipo', 'X')
					
					// Colocamos la incidencia
					wf_colocar_incidencia(fila, 'POBLACI$$HEX1$$d300$$ENDHEX$$N', "La poblaci$$HEX1$$f300$$ENDHEX$$n "+ciudad +" (CP : "+cod_postal+") no est$$HEX2$$e1002000$$ENDHEX$$definida en el sistema. Se crear$$HEX2$$e1002000$$ENDHEX$$autom$$HEX1$$e100$$ENDHEX$$ticamente", 'N', 'N', 'G')
					
				end if
			elseif n_reg=1 then
				select cod_pos, descripcion into :cp, :descrip from poblaciones where descripcion like :ciudad+'%';
				// podria ser esa
				id_poblacion = '-1'
				
				// Colocamos la incidencia
				wf_colocar_incidencia(fila, 'POBLACI$$HEX1$$d300$$ENDHEX$$N', "La poblaci$$HEX1$$f300$$ENDHEX$$n "+ciudad +" (CP : "+cod_postal+") podr$$HEX1$$ed00$$ENDHEX$$a ser la poblaci$$HEX1$$f300$$ENDHEX$$n "+descrip +" (CP : "+cp+") del SICA.", 'S', 'S','G')
				
			else
				// Ni idea, hay muchas
				id_poblacion = '-1'
				
				if idw_poblaciones.find("cod_pos ='"+cod_postal+"'", 1, idw_poblaciones.RowCount()) = 0 then
					fila_insert = idw_poblaciones.insertrow(0)
					idw_poblaciones.setitem(fila_insert, 'id_pedido', dw_fichero.GetitemString(fila, 'id_pedido'))
					idw_poblaciones.setitem(fila_insert, 'cod_pos', cod_postal)
					idw_poblaciones.setitem(fila_insert, 'descripcion', ciudad)
					idw_poblaciones.setitem(fila_insert, 'provincia', RightA('00000'+LeftA(cod_postal,2),5))
					idw_poblaciones.setitem(fila_insert, 'tipo', 'X')
					
					// Colocamos la incidencia
					wf_colocar_incidencia(fila, 'POBLACI$$HEX1$$d300$$ENDHEX$$N', "No se ha podido determinar la poblaci$$HEX1$$f300$$ENDHEX$$n "+ciudad +" (CP : "+cod_postal+") a cual corresponde del sistema.", 'N', 'N','G')
				end if
			end if
		else
			// No tenemos ni idea
			id_poblacion = '-1'

			// Colocamos la incidencia
			wf_colocar_incidencia(fila, 'POBLACI$$HEX1$$d300$$ENDHEX$$N', "No se ha podido determinar la poblaci$$HEX1$$f300$$ENDHEX$$n "+ciudad +" (CP : "+cod_postal+") a cual corresponde del sistema.", 'N', 'S','G')
		end if		
	else
		// No tenemos ni idea, hay varias poblaciones con ese codigo
		id_poblacion = '-1'
		
		// Colocamos la incidencia
		wf_colocar_incidencia(fila, 'POBLACI$$HEX1$$d300$$ENDHEX$$N', "No se ha podido determinar la poblaci$$HEX1$$f300$$ENDHEX$$n "+ciudad +" (CP : "+cod_postal+") a cual corresponde del sistema.", 'N', 'S','G')
	end if
		
			
end if

return id_poblacion
end function

public function string wf_cuenta_cliente (string codigo);// Devuelve la cuenta contable por defecto con los d$$HEX1$$ed00$$ENDHEX$$gitos necesarios y adem$$HEX1$$e100$$ENDHEX$$s la crea

long digitos_relleno
string relleno, cuenta_contable
string titulo, nif

if f_es_vacio(codigo) then codigo = ''

digitos_relleno = g_num_digitos - LenA(g_prefijo_clientes)
relleno = RightA('0000000000',digitos_relleno)
cuenta_contable = RightA(relleno + codigo, digitos_relleno)
cuenta_contable = g_prefijo_clientes + cuenta_contable 


//if f_es_vacio(cuenta_contable) then
//	cuenta_contable = Right('0000000000',g_num_digitos)
//else
//	titulo = f_dame_cliente(codigo)
//	nif = f_dame_nif (codigo)
//	// Creo la nueva cuenta contable para el cliente en el Plan de cuentas, 
//	// 	y actualizo en el cliente la cuenta contable
//
//	st_cuenta cuenta_struct
//	
//	cuenta_struct.cuenta 		= cuenta_contable
//	cuenta_struct.titulo 		= titulo
//	cuenta_struct.resumen 		= nif
//	cuenta_struct.final 			= 'D'
//	cuenta_struct.empresa		= 'S'
//	cuenta_struct.debe			= 0
//	cuenta_struct.haber			= 0
//	cuenta_struct.saldo			= 0
//	cuenta_struct.presupuesto	= 0
//	cuenta_struct.id_col			= ''
//	cuenta_struct.s1				= 0
//	cuenta_struct.s2				= 0
//	cuenta_struct.s3				= 0
//	cuenta_struct.ica				= 0
//	cuenta_struct.otros			= 0
//	if not f_es_vacio(f_cuenta_pgc_sincronizada(cuenta_struct, 'N')) then 
//		rollback using bd_ejercicio;
//	else
//		commit using bd_ejercicio;
//	end if
//
//end if
return cuenta_contable 
end function

public function string wf_crear_factura (long fila, string id_cliente, string id_poblacion, string articulo, string forma_pago);// Permite la creacion de facturas 
string id_factura, id_pedido, n_factura, desc_articulo, obs
long fila_insert,fila_insert_lineas
double total_linea

// ES SU ID FACTURA
id_pedido = dw_fichero.GetitemString(fila, 'id_pedido')

// Miramos si ese id_pedido ya tiene la cabecera de la factura generada
fila_insert = idw_facturas.find("id_pedido = '"+id_pedido+"'", 1, idw_facturas.RowCount())
if fila_insert = 0 then
	///////////////////////////
	// generamos la cabecera de la factura
	///////////////////////////
	fila_insert = idw_facturas.insertrow(0)
	id_factura = string(fila_insert)//f_siguiente_numero('FACTUEMI',10)
	n_factura = string(fila_insert)
	
	if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)

	idw_facturas.setitem(fila_insert, 'id_pedido', id_pedido)
	idw_facturas.setitem(fila_insert, 'id_factura', id_factura)
	idw_facturas.setitem(fila_insert, 'n_fact', n_factura)
	idw_facturas.setitem(fila_insert, 'fecha', date(dw_fichero.Getitemdatetime(fila, 'fecha_pedido')))
	idw_facturas.setitem(fila_insert, 'nif', f_formatea_nombre_campo(dw_fichero.GetitemString(fila, 'cif')))
	idw_facturas.setitem(fila_insert, 'nombre', dw_fichero.GetitemString(fila, 'nombre_companyia'))
	idw_facturas.setitem(fila_insert, 'domicilio', dw_fichero.GetitemString(fila, 'direccion'))
	idw_facturas.setitem(fila_insert, 'poblacion', dw_fichero.GetitemString(fila, 'ciudad'))
	idw_facturas.setitem(fila_insert, 'id_persona', id_cliente)
	idw_facturas.setitem(fila_insert, 'tipo_persona', 'P') // Siempre cliente
	idw_facturas.setitem(fila_insert, 'tipo_factura', g_colegio_cliente)// Siempre colegio-cliente
	idw_facturas.setitem(fila_insert, 'formadepago', forma_pago)
	idw_facturas.setitem(fila_insert, 'banco', '50') // David 07/04/2006 - INC.5071
	idw_facturas.setitem(fila_insert, 'pagado', 'N')
	//idw_facturas.setitem(fila_insert, 'f_pago', date(dw_fichero.GetitemDateTime(fila, 'fecha_pago')))
	idw_facturas.setitem(fila_insert, 'centro', is_centro_facturas_gabinete)
	idw_facturas.setitem(fila_insert, 'proyecto', g_explotacion_por_defecto)
	idw_facturas.setitem(fila_insert, 'usuario', g_usuario)
	idw_facturas.setitem(fila_insert, 'empresa', g_empresa)
	obs = "Importada del pedido '"+id_pedido+"'"+cr+"Forma pago factura original : "+dw_fichero.GetitemString(fila, 'forma_pago')
	idw_facturas.setitem(fila_insert, 'obs', obs)
	idw_facturas.setitem(fila_insert, 'observaciones_text', obs)
	idw_facturas.setitem(fila_insert, 'asunto', "Importada del pedido '"+id_pedido+"'")
	
	
	idw_facturas.setitem(fila_insert, 'total', 0)
	
/*		CAMPOS NO RELLENADOS
         csi_facturas_emitidas.cuenta,   
         csi_facturas_emitidas.base_imp,   
         csi_facturas_emitidas.iva,   
         csi_facturas_emitidas.descuento,   
         csi_facturas_emitidas.subtotal,   
         csi_facturas_emitidas.banco,   
         csi_facturas_emitidas.t_iva,   
         csi_facturas_emitidas.tipo_reten,   
         csi_facturas_emitidas.importe_reten,   
         csi_facturas_emitidas.emisor,   
         csi_facturas_emitidas.n_fact_unico,   
         csi_facturas_emitidas.irpf_colegio,   
*/
	
	
else
	// La factura ya est$$HEX2$$e1002000$$ENDHEX$$generada
	id_factura = idw_facturas.GetItemString(fila_insert, 'id_factura')
	n_factura = idw_facturas.GetItemString(fila_insert, 'n_fact')
end if


///////////////////////////
// Insertamos el articulo (modificaciones por lo del dto!)
///////////////////////////
fila_insert_lineas = idw_facturas_lineas.insertrow(0)

idw_facturas_lineas.setitem(fila_insert_lineas, 'id_factura', id_factura)
idw_facturas_lineas.setitem(fila_insert_lineas, 'n_factura', n_factura)
idw_facturas_lineas.setitem(fila_insert_lineas, 'articulo', articulo)

desc_articulo = dw_fichero.GetitemString(fila, 'nombre_producto')
if abs(dw_fichero.GetitemNumber(fila, 'cantidad'))<>1 then desc_articulo += " ( "+string(dw_fichero.GetitemNumber(fila, 'cantidad'))+" uds.)"

idw_facturas_lineas.setitem(fila_insert_lineas, 'descripcion_larga', desc_articulo)
//idw_facturas_lineas.setitem(fila_insert_lineas, 'unidades', dw_fichero.GetitemNumber(fila, 'cantidad'))
idw_facturas_lineas.setitem(fila_insert_lineas, 'unidades', dw_fichero.GetitemNumber(fila, 'cantidad')/abs(dw_fichero.GetitemNumber(fila, 'cantidad'))) // Pondr$$HEX2$$e1002000$$ENDHEX$$1 o -1
//idw_facturas_lineas.setitem(fila_insert_lineas, 'precio', dw_fichero.GetitemNumber(fila, 'precio_unidad'))
idw_facturas_lineas.setitem(fila_insert_lineas, 'precio', abs(dw_fichero.GetitemNumber(fila, 'precio_con_descuento')))
//idw_facturas_lineas.setitem(fila_insert_lineas, 'subtotal', dw_fichero.GetitemNumber(fila, 'cantidad')*dw_fichero.GetitemNumber(fila, 'precio_unidad'))
idw_facturas_lineas.setitem(fila_insert_lineas, 'subtotal', dw_fichero.GetitemNumber(fila, 'precio_con_descuento'))
//idw_facturas_lineas.setitem(fila_insert_lineas, 'porcent_dto', dw_fichero.GetitemNumber(fila, 'descuento')*100)
idw_facturas_lineas.setitem(fila_insert_lineas, 'porcent_dto', 0)
//idw_facturas_lineas.setitem(fila_insert_lineas, 'importe_dto', round(dw_fichero.GetitemNumber(fila, 'precio_unidad')*dw_fichero.GetitemNumber(fila, 'descuento')*100,0)/100)
idw_facturas_lineas.setitem(fila_insert_lineas, 'importe_dto', 0)
idw_facturas_lineas.setitem(fila_insert_lineas, 't_iva', RightA('00'+string(dw_fichero.GetitemNumber(fila, 'tipo_iva')),2))
idw_facturas_lineas.setitem(fila_insert_lineas, 'subtotal_iva', dw_fichero.GetitemNumber(fila, 'iva'))

total_linea = idw_facturas_lineas.GetitemNumber(fila_insert_lineas, 'subtotal') - idw_facturas_lineas.GetItemNumber(fila_insert_lineas, 'importe_dto')+idw_facturas_lineas.GetItemNumber(fila_insert_lineas, 'subtotal_iva')

idw_facturas.setitem(fila_insert, 'total', idw_facturas.GetitemNumber(fila_insert, 'total')+total_linea)


return id_factura
end function

public subroutine wf_colocar_incidencia (long fila, string elemento, string texto, string confirmar, string crear, string tipo);// Se encarga de colocar las incidencias que se le pasan
// Tipo de incidencia: L.Leve; G:Grave
// Confirmar: Activa el bot$$HEX1$$f300$$ENDHEX$$n de confirmar
// Crear: activa el bot$$HEX1$$f300$$ENDHEX$$n de cobrar
long fila_insert


fila_insert = idw_incidencias.insertrow(0)
if fila <>0 then idw_incidencias.setitem(fila_insert, 'id_pedido', dw_fichero.GetitemString(fila, 'id_pedido'))
idw_incidencias.setitem(fila_insert, 'elemento', elemento)
idw_incidencias.setitem(fila_insert, 'texto', texto)
idw_incidencias.setitem(fila_insert, 'confirmar', confirmar)
idw_incidencias.setitem(fila_insert, 'crear', crear)
idw_incidencias.setitem(fila_insert, 'orden',fila_insert)
idw_incidencias.setitem(fila_insert, 'tipo',tipo)

end subroutine

public function string wf_comprueba_cliente (long fila, string poblacion);string id_cliente, n_cliente, nombre, cif, cod_pos, prov, pais, cid_bbdd, n_cliente_sin_prefijo
long n_reg, fila_insert
	
// MIRAMOS SI EL CLIENTE EXISTE!
n_cliente = is_prefijo_clientes_gabinete + string(dw_fichero.GetitemNumber(fila, 'id_cliente'))
n_cliente_sin_prefijo = string(dw_fichero.GetitemNumber(fila, 'id_cliente'))
select count(*) into :n_reg from clientes, clientes_terceros where clientes.id_cliente = clientes_terceros.id_cliente and clientes_terceros.c_tercero = :g_terceros_codigos.cliente_gabinete and n_cliente = :n_cliente;

if n_reg=0 then
//	// No existe... hay que mirar por cif,por si tenemos suerte
	cif = f_formatea_nombre_campo(dw_fichero.GetitemString(fila, 'cif'))
	nombre = dw_fichero.GetitemString(fila, 'nombre_companyia')
//	select count(*) into :n_reg from clientes, clientes_terceros where clientes.id_cliente = clientes_terceros.id_cliente and clientes_terceros.c_tercero = :g_terceros_codigos.cliente_gabinete and  nif = :cif and apellidos = :nombre;
//	
//	if n_reg=1 then
//		// Si el cif coincide y el nombre tambien... 
//		select clientes.id_cliente into :id_cliente from clientes, clientes_terceros where clientes.id_cliente = clientes_terceros.id_cliente and clientes_terceros.c_tercero = :g_terceros_codigos.cliente_gabinete and  nif = :cif and apellidos = :nombre;
//	else
//		// A partir de aqu$$HEX2$$ed002000$$ENDHEX$$es euristica... pq o bien el nif no es el mismo y el nombre no es el mismo
//		// Lo miramos por nombre
//		select count(*) into :n_reg from clientes, clientes_terceros where clientes.id_cliente = clientes_terceros.id_cliente and clientes_terceros.c_tercero = :g_terceros_codigos.cliente_gabinete and  apellidos = :nombre;
//		if n_reg = 1 then
//			select nif into :cid_bbdd from clientes, clientes_terceros where clientes.id_cliente = clientes_terceros.id_cliente and clientes_terceros.c_tercero = :g_terceros_codigos.cliente_gabinete and  apellidos = :nombre;
//			// Raro es que hayan 2 con el mismo nombre... pero por si acaso...
//			// Colocamos la incidencia
//			wf_colocar_incidencia(fila, 'CLIENTE', "Existe un cliente con el mismo nombre ["+nombre+"] pero con diferente NIF ("+cif+" <-> "+cid_bbdd+").", 'S', 'S', 'G')
//		elseif n_reg = 0 then
			// No existe, se crea
			// Hay que hacer el codigo necesario para agregar el cliente....pero si no est$$HEX2$$e1002000$$ENDHEX$$ya, claro!
			if idw_clientes.find("n_cliente ='"+n_cliente+"'", 1, idw_clientes.RowCount()) = 0 then
				fila_insert = idw_clientes.insertrow(0)
				idw_clientes.setitem(fila_insert, 'id_pedido', dw_fichero.GetitemString(fila, 'id_pedido'))
			
				idw_clientes.setitem(fila_insert, 'n_cliente', n_cliente)
				idw_clientes.setitem(fila_insert, 'nif', cif)
				idw_clientes.setitem(fila_insert, 'tipo_via', '00')
				idw_clientes.setitem(fila_insert, 'apellidos', nombre)
				idw_clientes.setitem(fila_insert, 'nombre_via', dw_fichero.GetitemString(fila, 'direccion'))
				idw_clientes.setitem(fila_insert, 'telefono', trim(dw_fichero.GetitemString(fila, 'prefijo'))+trim(dw_fichero.GetitemString(fila, 'telefono')))
				idw_clientes.setitem(fila_insert, 'observaciones', 'Ciudad : '+trim(dw_fichero.GetitemString(fila, 'ciudad'))+' ( CP : '+trim(dw_fichero.GetitemString(fila, 'cod_postal'))+' ) / Regi$$HEX1$$f300$$ENDHEX$$n : '+trim(dw_fichero.GetitemString(fila, 'region')))				
				idw_clientes.setitem(fila_insert, 'visible_web', 'N')
				idw_clientes.setitem(fila_insert, 'empresa', g_empresa)
				idw_clientes.setitem(fila_insert, 'cuenta_contable', wf_cuenta_cliente(n_cliente_sin_prefijo )/*f_cuenta_contable_defecto_cli_provs('C',id_cliente)*/)

				// Colocamos la incidencia
				wf_colocar_incidencia(fila, 'CLIENTE', "El cliente con el NIF "+cif+" nombre "+nombre+" no est$$HEX2$$e1002000$$ENDHEX$$definido en el sistema.", 'N', 'N', 'G')

//				if poblacion<>'-1' then
					SELECT poblaciones.cod_pos,poblaciones.provincia,provincias.cod_pais INTO :cod_pos,:prov,:pais FROM poblaciones,provincias WHERE ( poblaciones.provincia = provincias.cod_provincia ) and ( ( poblaciones.cod_pob = :poblacion ));
					idw_clientes.setitem(fila_insert, 'cod_pob', poblacion)
					idw_clientes.setitem(fila_insert, 'cp', cod_pos)
					idw_clientes.setitem(fila_insert, 'cod_prov', prov)
					idw_clientes.setitem(fila_insert, 'pais', pais)
//				end if
			end if
//		else
//			// Hay varios con el mismo nombre
//			fila_insert = idw_clientes.insertrow(0)
//			idw_clientes.setitem(fila_insert, 'id_pedido', dw_fichero.GetitemString(fila, 'id_pedido'))
//		
//			idw_clientes.setitem(fila_insert, 'n_cliente', n_cliente)
//			idw_clientes.setitem(fila_insert, 'nif', cif)
//			idw_clientes.setitem(fila_insert, 'tipo_via', '00')
//			idw_clientes.setitem(fila_insert, 'apellidos', nombre)
//			idw_clientes.setitem(fila_insert, 'nombre_via', dw_fichero.GetitemString(fila, 'direccion'))
//			idw_clientes.setitem(fila_insert, 'telefono', trim(dw_fichero.GetitemString(fila, 'prefijo'))+trim(dw_fichero.GetitemString(fila, 'telefono')))
//			idw_clientes.setitem(fila_insert, 'observaciones', 'Ciudad : '+trim(dw_fichero.GetitemString(fila, 'ciudad'))+' ( CP : '+trim(dw_fichero.GetitemString(fila, 'cod_postal'))+' ) / Regi$$HEX1$$f300$$ENDHEX$$n : '+trim(dw_fichero.GetitemString(fila, 'region')))				
//			idw_clientes.setitem(fila_insert, 'visible_web', 'N')
//			idw_clientes.setitem(fila_insert, 'empresa', g_empresa)
//			idw_clientes.setitem(fila_insert, 'cuenta_contable', wf_cuenta_cliente(n_cliente_sin_prefijo ))
//
////			if poblacion<>'-1' then
//				SELECT poblaciones.cod_pos,poblaciones.provincia,provincias.cod_pais INTO :cod_pos,:prov,:pais FROM poblaciones,provincias WHERE ( poblaciones.provincia = provincias.cod_provincia ) and ( ( poblaciones.cod_pob = :poblacion ));
//				idw_clientes.setitem(fila_insert, 'cod_pob', poblacion)
//				idw_clientes.setitem(fila_insert, 'cp', cod_pos)
//				idw_clientes.setitem(fila_insert, 'cod_prov', prov)
//				idw_clientes.setitem(fila_insert, 'pais', pais)
////			end if
//			
//			// Colocamos la incidencia
//			wf_colocar_incidencia(fila, 'CLIENTE', "Existen varios clientes con el mismo nombre "+nombre+". Se crear$$HEX2$$e1002000$$ENDHEX$$uno nuevo.", 'N', 'N', 'G')
//		end if
		id_cliente = '-1'
//	end if
else
	// Existe!
	select clientes.id_cliente into :id_cliente from clientes, clientes_terceros where clientes.id_cliente = clientes_terceros.id_cliente and clientes_terceros.c_tercero = :g_terceros_codigos.cliente_gabinete and  n_cliente = :n_cliente;
end if


return id_cliente
end function

on w_importacion_facturas_gabinete_gu.create
int iCurrent
call super::create
this.cb_impr=create cb_impr
this.cb_importar=create cb_importar
this.cb_procesar=create cb_procesar
this.tab_1=create tab_1
this.cb_grabar_elementos=create cb_grabar_elementos
this.cb_grabar_facturas=create cb_grabar_facturas
this.dw_temporal=create dw_temporal
this.cb_ver_todas=create cb_ver_todas
this.dw_clientes_terceros=create dw_clientes_terceros
this.st_progreso=create st_progreso
this.dw_fichero=create dw_fichero
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_impr
this.Control[iCurrent+2]=this.cb_importar
this.Control[iCurrent+3]=this.cb_procesar
this.Control[iCurrent+4]=this.tab_1
this.Control[iCurrent+5]=this.cb_grabar_elementos
this.Control[iCurrent+6]=this.cb_grabar_facturas
this.Control[iCurrent+7]=this.dw_temporal
this.Control[iCurrent+8]=this.cb_ver_todas
this.Control[iCurrent+9]=this.dw_clientes_terceros
this.Control[iCurrent+10]=this.st_progreso
this.Control[iCurrent+11]=this.dw_fichero
end on

on w_importacion_facturas_gabinete_gu.destroy
call super::destroy
destroy(this.cb_impr)
destroy(this.cb_importar)
destroy(this.cb_procesar)
destroy(this.tab_1)
destroy(this.cb_grabar_elementos)
destroy(this.cb_grabar_facturas)
destroy(this.dw_temporal)
destroy(this.cb_ver_todas)
destroy(this.dw_clientes_terceros)
destroy(this.st_progreso)
destroy(this.dw_fichero)
end on

event open;call super::open;dw_fichero.of_SetLinkage(TRUE)
of_SetResize (true)
 
// asignamos las variables de instancia
idw_poblaciones = tab_1.tabpage_4.dw_poblaciones
idw_formas_pago = tab_1.tabpage_5.dw_formas_pago
idw_articulos	 = tab_1.tabpage_6.dw_articulos
idw_clientes	 = tab_1.tabpage_3.dw_clientes
idw_incidencias = tab_1.tabpage_1.dw_incidencias
idw_facturas 	 = tab_1.tabpage_2.dw_facturas
idw_facturas_lineas 	 = tab_1.tabpage_2.dw_facturas_lineas


// Hacemos el redimensionado
inv_resize.of_register (cb_ver_todas, "fixedtoright")
inv_resize.of_Register (dw_fichero, "ScaletoRight")
inv_resize.of_Register (tab_1, "scaletoright&bottom")
inv_resize.of_register (idw_poblaciones, "scaletoright&bottom")
inv_resize.of_register (idw_formas_pago, "scaletoright&bottom")
inv_resize.of_register (idw_articulos, "scaletoright&bottom")
inv_resize.of_register (idw_clientes, "scaletoright&bottom")
inv_resize.of_register (idw_incidencias, "scaletoright&bottom")
inv_resize.of_register (idw_facturas, "scaletoright&bottom")
inv_resize.of_register (idw_facturas_lineas, "FixedToBottom&ScaleToRight")
inv_resize.of_register (tab_1.tabpage_1.cb_imprimir, "fixedtobottom")
inv_resize.of_register (tab_1.tabpage_3.cb_imprimir2, "fixedtobottom")
inv_resize.of_register (tab_1.tabpage_4.cb_imprimir4, "fixedtobottom")
inv_resize.of_register (tab_1.tabpage_5.cb_imprimir5, "fixedtobottom")
inv_resize.of_register (tab_1.tabpage_6.cb_imprimir3, "fixedtobottom")
inv_resize.of_register (cb_impr, "fixedtoright")

// Cogemos las variables que nos hacen falta
SELECT texto into :is_prefijo_clientes_gabinete from var_globales where nombre = 'g_prefijo_clientes_gabinete';
SELECT texto into :is_serie_facturas_gabinete from var_globales where nombre = 'g_serie_facturas_gabinete';
SELECT texto into :is_centro_facturas_gabinete from var_globales where nombre = 'g_centro_facturas_gabinete';


end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_importacion_facturas_gabinete_gu
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_importacion_facturas_gabinete_gu
end type

type cb_impr from commandbutton within w_importacion_facturas_gabinete_gu
integer x = 3328
integer y = 876
integer width = 402
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;dw_fichero.print()
end event

type cb_importar from commandbutton within w_importacion_facturas_gabinete_gu
integer x = 27
integer y = 876
integer width = 402
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Importar Fichero"
end type

event clicked;string nom_fich, directorio
n_cst_filesrvwin32 cambia_directorio

cb_procesar.enabled = false
cb_grabar_elementos.enabled = false
cb_grabar_facturas.enabled = false
dw_fichero.reset() // Quitamos la secciona anterior
wf_vaciar_dw()

cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()  //para tener el directorio de trabajo
If GetFileOpenName('Seleccione el nombre del Fichero', nom_fich, nom_fich, '.TXT', 'Ficheros de datos (*.TXT),*.TXT,') <> 1 Then 
	// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
	cambia_directorio.of_changedirectory(directorio)
	destroy cambia_directorio
	return 
end if
	dw_fichero.ImportFile(nom_fich)  //empezamos en la 1$$HEX1$$aa00$$ENDHEX$$, fichero sin descripciones
	cb_ver_todas.trigger event clicked() // Para evitar cualquier filtro
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio

dw_fichero.setsort('id_pedido')
dw_fichero.sort()
cb_procesar.enabled = true

end event

type cb_procesar from commandbutton within w_importacion_facturas_gabinete_gu
integer x = 448
integer y = 876
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
boolean enabled = false
string text = "Procesar"
end type

event clicked;// Este bot$$HEX1$$f300$$ENDHEX$$n es el que se encarga de validar los datos y comprobar que todo este correcto antes de hacer absolutamente nada
long fila
string id_cliente, id_poblacion, articulo, forma_pago
boolean b_error = false
double dl_incidencias_leves = 0, dl_incidencias_graves = 0

// VAciamos los dw
wf_vaciar_dw()
cb_grabar_elementos.enabled = false
cb_grabar_facturas.enabled = false


dw_fichero.trigger event pfc_accepttext(true)
ib_procesando = true
cb_ver_todas.trigger event clicked()

idw_facturas.setredraw(false)
idw_facturas_lineas.setredraw(false)


FOR fila = 1 TO dw_fichero.RowCount()
	yield()
	
	st_progreso.text = 'Procesando '+string(fila)+' de '+string(dw_fichero.RowCount())
	
	// MIRAMOS SI LA POBLACION EXISTE!
	if ib_procesar_poblaciones then
		id_poblacion = wf_comprueba_poblacion(fila)
	else
		id_poblacion = g_fases_inicio.poblacion // Poblaci$$HEX1$$f300$$ENDHEX$$n por defecto
	end if

	// MIRAMOS SI EL CLIENTE EXISTE!
	id_cliente = wf_comprueba_cliente(fila, id_poblacion)

	// MIRAMOS LA FORMA DE PAGO
	forma_pago = wf_comprueba_forma_pago(fila)

	// MIRAMOS SI EL ARTICULO
	articulo = wf_comprueba_articulo(fila)

	// Si no ha habido problema alguno con lo que hemos hecho hasta ahora... creamos las facturas
	if id_cliente<>'-1' and (not ib_procesar_poblaciones or (ib_procesar_poblaciones and id_poblacion<>'-1')) and forma_pago<>'-1' and articulo <>'-1' then
		wf_crear_factura(fila, id_cliente, id_poblacion, articulo, forma_pago)
		
	else
//		messagebox('', 'id_cliente '+id_cliente+cr+'id_poblacion ' +id_poblacion+cr+'forma_pago '+forma_pago+cr+'articulo '+articulo)
		b_error = true
	end if
NEXT

idw_facturas.setredraw(true)
idw_facturas_lineas.setredraw(true)

ib_procesando = false
for fila = 1 to idw_incidencias.rowcount()
	if idw_incidencias.GetItemString(fila,'tipo') = 'G' then dl_incidencias_graves ++
	if idw_incidencias.GetItemString(fila,'tipo') = 'L' then dl_incidencias_leves ++		
next
	
if dl_incidencias_graves > 0  then 

	messagebox(g_titulo, "Todos los elementos del fichero no estaban creados previamente."+cr+"Revise las incidencias y el resto de pesta$$HEX1$$f100$$ENDHEX$$as, para grabar los elementos de las facturas."+cr+"Hasta que no se definan correctamente no se generar$$HEX1$$e100$$ENDHEX$$n la facturas"+cr &
	+"Se han detectado " + string(dl_incidencias_graves)+" incidencias graves y "+string(dl_incidencias_leves)+" incidencias leves.")
	st_progreso.text = 'Recorriendo cada pedido se ven las incidencias de ese pedido concreto'


	// Colocamos la incidencia
	wf_colocar_incidencia(0, 'FINAL', "RECUERDE SOLUCIONAR LAS INCIDENCIAS, GRABAR ELEMENTOS Y PROCESAR NUEVAMENTE", 'N', 'N', 'C')
	
	cb_grabar_elementos.enabled = true	
else
	messagebox(g_titulo, "Procesado con $$HEX1$$e900$$ENDHEX$$xito. Pueden grabarse las facturas")
	st_progreso.text = ''
	cb_grabar_facturas.enabled = true
end if

end event

type tab_1 from tab within w_importacion_facturas_gabinete_gu
integer x = 27
integer y = 996
integer width = 4064
integer height = 1468
integer taborder = 30
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
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_3 tabpage_3
tabpage_6 tabpage_6
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_3=create tabpage_3
this.tabpage_6=create tabpage_6
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_3,&
this.tabpage_6,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_3)
destroy(this.tabpage_6)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4027
integer height = 1352
long backcolor = 79741120
string text = "Incidencias Encontradas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_imprimir cb_imprimir
dw_incidencias dw_incidencias
end type

on tabpage_1.create
this.cb_imprimir=create cb_imprimir
this.dw_incidencias=create dw_incidencias
this.Control[]={this.cb_imprimir,&
this.dw_incidencias}
end on

on tabpage_1.destroy
destroy(this.cb_imprimir)
destroy(this.dw_incidencias)
end on

type cb_imprimir from commandbutton within tabpage_1
integer y = 1260
integer width = 402
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;idw_incidencias.print()
end event

type dw_incidencias from u_dw within tabpage_1
integer x = 5
integer y = 4
integer width = 4018
integer height = 1248
integer taborder = 11
string dataobject = "d_import_incidencias_gu"
end type

event buttonclicked;call super::buttonclicked;string id_pedido, cp, cod_postal, cif_origen, cif_nuevo, descripcion
string texto
long posicion, posicion_fin, fila, fila_insert, fila_correc
boolean b_esta_filtrado 


id_pedido = this.GetItemString(row, 'id_pedido')
texto = this.GetItemString(row, 'texto')

b_esta_filtrado = not(idw_incidencias.describe("datawindow.table.filter") = '?')
idw_incidencias.setredraw(false) //Evita cualquier posible parpadeo


CHOOSE CASE dwo.name
	CASE 'b_confirmar'
		// Confirmamos que la accion del sistema es la adecuada
		CHOOSE CASE this.GetItemString(row, 'elemento')
			CASE 'POBLACI$$HEX1$$d300$$ENDHEX$$N'
				// Renombramos el codigo de poblacion en la parte superior
				// hay que buscar el segundo codigo postal
				posicion = PosA(texto, "(CP :",PosA(texto, ")"))
				posicion_fin = PosA(texto, ")",posicion)
				cp = MidA(texto, posicion+LenA("(CP :"),posicion_fin - (posicion +LenA("(CP :")))
				
				posicion = PosA(texto, "poblaci$$HEX1$$f300$$ENDHEX$$n",PosA(texto, ")"))
				posicion_fin = PosA(texto, "(CP :",posicion)
				descripcion = trim(MidA(texto, posicion+LenA("poblaci$$HEX1$$f300$$ENDHEX$$n"),posicion_fin - (posicion +LenA("poblaci$$HEX1$$f300$$ENDHEX$$n"))))
				
				fila = dw_fichero.find("id_pedido = '"+id_pedido+"'", 1, dw_fichero.RowCount())
				DO WHILE fila>0
					dw_fichero.setitem(fila, "cod_postal", cp)
					dw_fichero.setitem(fila, "ciudad", descripcion)
					fila = dw_fichero.find("id_pedido = '"+id_pedido+"'", fila+1, dw_fichero.RowCount())
				LOOP
				
				this.SetItem(row, 'texto', texto +  " (CORREGIDO. Procesar nuevamente)")
			CASE 'CLIENTE'
				posicion = PosA(texto, "(")
				posicion_fin = PosA(texto, "<->",posicion)
				cif_origen = trim(MidA(texto, posicion+LenA("("),posicion_fin - (posicion +LenA("("))))
				posicion = posicion_fin+LenA("<->")
				posicion_fin = PosA(texto, ")",posicion)
				cif_nuevo = MidA(texto, posicion+LenA("("),posicion_fin - (posicion +LenA("(")))

				fila = dw_fichero.find("id_pedido = '"+id_pedido+"'", 1, dw_fichero.RowCount())
				DO WHILE fila>0
					dw_fichero.setitem(fila, "cif", cif_nuevo)
					fila = dw_fichero.find("id_pedido = '"+id_pedido+"'", fila+1, dw_fichero.RowCount())
				LOOP
				
				this.SetItem(row, 'texto', texto +  " (CORREGIDO. Procesar nuevamente)")
		END CHOOSE
		// Todas las que tengan este mismo texto tambien las dejamos igual
		fila_correc = idw_incidencias.find("id_pedido = '"+id_pedido+"' and confirmar = 'S'", 1, idw_incidencias.RowCount())
		DO WHILE fila_correc>0
			this.SetItem(fila_correc, 'texto', texto +  " (CORREGIDO. Procesar nuevamente, tras grabar elementos)")
			this.SetItem(fila_correc, 'confirmar', 'N')
			this.SetItem(fila_correc, 'crear', 'N')
			fila_correc = idw_incidencias.find("id_pedido = '"+id_pedido+"' and confirmar = 'S'", 1, idw_incidencias.RowCount())
		LOOP
		
		
	CASE 'b_crear'
		CHOOSE CASE this.GetItemString(row, 'elemento')
			CASE 'POBLACI$$HEX1$$d300$$ENDHEX$$N'
				fila = dw_fichero.find("id_pedido = '"+id_pedido+"'", 1, dw_fichero.RowCount())

				cod_postal = dw_fichero.GetItemString(fila, "cod_postal")
				
				if b_esta_filtrado then cb_ver_todas.trigger event clicked()
				
				if idw_poblaciones.find("cod_pos ='"+cod_postal+"'", 1, idw_poblaciones.RowCount()) = 0 then
					fila_insert = idw_poblaciones.insertrow(0)
					idw_poblaciones.setitem(fila_insert, 'id_pedido', dw_fichero.GetitemString(fila, 'id_pedido'))
					idw_poblaciones.setitem(fila_insert, 'cod_pos', cod_postal)
					idw_poblaciones.setitem(fila_insert, 'descripcion', dw_fichero.GetitemString(fila, 'ciudad'))
					idw_poblaciones.setitem(fila_insert, 'provincia', RightA('00000'+LeftA(cod_postal,2),5))
					idw_poblaciones.setitem(fila_insert, 'tipo', 'X')
				end if
				
				this.SetItem(row, 'texto', texto +  " (CORREGIDO. Procesar nuevamente, tras grabar elementos)")
				if b_esta_filtrado then w_importacion_facturas_gabinete_gu.trigger event csd_aplicar_filtros(fila)
				
				
				// Todas las que tengan este mismo texto tambien las dejamos igual
				fila_correc = idw_incidencias.find("texto = '"+texto+"' and crear = 'S'", 1, idw_incidencias.RowCount())
				DO WHILE fila_correc>0
					this.SetItem(fila_correc, 'texto', texto +  " (CORREGIDO. Procesar nuevamente, tras grabar elementos)")
					this.SetItem(fila_correc, 'confirmar', 'N')
					this.SetItem(fila_correc, 'crear', 'N')
					fila_correc = idw_incidencias.find("texto = '"+texto+"' and crear = 'S'", 1, idw_incidencias.RowCount())
				LOOP
				
			CASE 'CLIENTE'
				// Pillamos los datos del cliente y creamos el cliente 
				fila = dw_fichero.find("id_pedido = '"+id_pedido+"'", 1, dw_fichero.RowCount())
				fila_insert = idw_clientes.insertrow(0)

				if b_esta_filtrado then cb_ver_todas.trigger event clicked()
				
				if idw_clientes.find("n_cliente ='"+is_prefijo_clientes_gabinete + string(dw_fichero.GetitemNumber(fila, 'id_cliente'))+"'", 1, idw_poblaciones.RowCount()) = 0 then
					idw_clientes.setitem(fila_insert, 'id_pedido', dw_fichero.GetitemString(fila, 'id_pedido'))
					idw_clientes.setitem(fila_insert, 'n_cliente', is_prefijo_clientes_gabinete + string(dw_fichero.GetitemNumber(fila, 'id_cliente')))
					idw_clientes.setitem(fila_insert, 'nif', f_formatea_nombre_campo(dw_fichero.GetitemString(fila, 'cif')))
					idw_clientes.setitem(fila_insert, 'tipo_via', '00')
					idw_clientes.setitem(fila_insert, 'apellidos', dw_fichero.GetitemString(fila, 'nombre_companyia'))
					idw_clientes.setitem(fila_insert, 'nombre_via', dw_fichero.GetitemString(fila, 'direccion'))
					idw_clientes.setitem(fila_insert, 'telefono', trim(dw_fichero.GetitemString(fila, 'prefijo'))+trim(dw_fichero.GetitemString(fila, 'telefono')))
					idw_clientes.setitem(fila_insert, 'observaciones', 'Ciudad : '+trim(dw_fichero.GetitemString(fila, 'ciudad'))+' ( CP : '+trim(dw_fichero.GetitemString(fila, 'cod_postal'))+' ) / Regi$$HEX1$$f300$$ENDHEX$$n : '+trim(dw_fichero.GetitemString(fila, 'region')))				
					idw_clientes.setitem(fila_insert, 'cuenta_contable', wf_cuenta_cliente(string(dw_fichero.GetitemNumber(fila, 'id_cliente'))))//f_cuenta_contable_defecto_cli_provs('C',string(dw_fichero.GetitemNumber(fila, 'id_cliente'))))
					
	//				if poblacion<>'-1' then
	//					SELECT poblaciones.cod_pos,poblaciones.provincia,provincias.cod_pais INTO :cod_pos,:prov,:pais FROM poblaciones,provincias WHERE ( poblaciones.provincia = provincias.cod_provincia ) and ( ( poblaciones.cod_pob = :poblacion ));
	//					idw_clientes.setitem(fila_insert, 'cod_pob', poblacion)
	//					idw_clientes.setitem(fila_insert, 'cp', cod_pos)
	//					idw_clientes.setitem(fila_insert, 'cod_prov', prov)
	//					idw_clientes.setitem(fila_insert, 'pais', pais)
	//				end if
				end if
				this.SetItem(row, 'texto', texto +  " (CORREGIDO. Procesar nuevamente, tras grabar elementos)")
				// Todas las que tengan este mismo texto tambien las dejamos igual
				fila_correc = idw_incidencias.find("texto = '"+texto+"' and crear = 'S'", 1, idw_incidencias.RowCount())
				DO WHILE fila_correc>0
					this.SetItem(fila_correc, 'texto', texto +  " (CORREGIDO. Procesar nuevamente, tras grabar elementos)")
					this.SetItem(fila_correc, 'confirmar', 'N')
					this.SetItem(fila_correc, 'crear', 'N')
					fila_correc = idw_incidencias.find("texto = '"+texto+"' and crear = 'S'", 1, idw_incidencias.RowCount())
				LOOP
				
				if b_esta_filtrado then w_importacion_facturas_gabinete_gu.trigger event csd_aplicar_filtros(fila)
		END CHOOSE
END CHOOSE

// quitamos los dos botones de esta fila, una vez elegido
this.setitem(row, 'confirmar', 'N')
this.setitem(row, 'crear', 'N')
idw_incidencias.setredraw(true)//permitimos el redibujado
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4027
integer height = 1352
long backcolor = 79741120
string text = "Clientes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_imprimir2 cb_imprimir2
dw_clientes dw_clientes
end type

on tabpage_3.create
this.cb_imprimir2=create cb_imprimir2
this.dw_clientes=create dw_clientes
this.Control[]={this.cb_imprimir2,&
this.dw_clientes}
end on

on tabpage_3.destroy
destroy(this.cb_imprimir2)
destroy(this.dw_clientes)
end on

type cb_imprimir2 from commandbutton within tabpage_3
integer y = 1260
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;idw_clientes.print()
end event

type dw_clientes from u_dw within tabpage_3
integer x = 5
integer y = 4
integer width = 4018
integer height = 1248
integer taborder = 11
string dataobject = "d_import_clientes_gu"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event buttonclicked;call super::buttonclicked;string pob

CHOOSE CASE dwo.name
	CASE 'b_poblaciones'
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(row,'cod_pob',pob)
		this.event itemchanged(row, this.object.cod_pob, pob)
END CHOOSE
end event

event itemchanged;call super::itemchanged;string cod_postal, cod_provincia, cod_pais

CHOOSE CASE dwo.name
	CASE 'cod_pob'
		cod_provincia=f_devuelve_cod_provincia(data)
		cod_postal=f_devuelve_cod_postal(data)
		cod_pais=f_devuelve_cod_pais(data)
			
		this.setitem(row,'cod_pob',data)
		this.setitem(row,'cp',cod_postal)
		this.setitem(row,'cod_prov',cod_provincia)
		this.setitem(row,'pais',cod_pais)
	CASE 'cp'
END CHOOSE
end event

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4027
integer height = 1352
long backcolor = 79741120
string text = "Art$$HEX1$$ed00$$ENDHEX$$culos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_imprimir3 cb_imprimir3
dw_articulos dw_articulos
end type

on tabpage_6.create
this.cb_imprimir3=create cb_imprimir3
this.dw_articulos=create dw_articulos
this.Control[]={this.cb_imprimir3,&
this.dw_articulos}
end on

on tabpage_6.destroy
destroy(this.cb_imprimir3)
destroy(this.dw_articulos)
end on

type cb_imprimir3 from commandbutton within tabpage_6
integer y = 1260
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;idw_articulos.print()
end event

type dw_articulos from u_dw within tabpage_6
integer x = 5
integer y = 4
integer width = 4018
integer height = 1248
integer taborder = 11
string dataobject = "d_import_articulos_correspo_gu"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event buttonclicked;// Este bot$$HEX1$$f300$$ENDHEX$$n es el que se encarga de validar los datos y comprobar que todo este correcto antes de hacer absolutamente nada
long fila
string id_cliente, id_poblacion, articulo, forma_pago
boolean b_error = false

// VAciamos los dw
wf_vaciar_dw()
cb_grabar_elementos.enabled = false
cb_grabar_facturas.enabled = false


dw_fichero.trigger event pfc_accepttext(true)
ib_procesando = true
cb_ver_todas.trigger event clicked()

idw_facturas.setredraw(false)
idw_facturas_lineas.setredraw(false)


FOR fila = 1 TO dw_fichero.RowCount()
	yield()
	
	st_progreso.text = 'Procesando '+string(fila)+' de '+string(dw_fichero.RowCount())
	
	// MIRAMOS SI LA POBLACION EXISTE!
	if ib_procesar_poblaciones then
		id_poblacion = wf_comprueba_poblacion(fila)
	else
		id_poblacion = '-1'
	end if

	// MIRAMOS SI EL CLIENTE EXISTE!
	id_cliente = wf_comprueba_cliente(fila, id_poblacion)

	// MIRAMOS LA FORMA DE PAGO
	forma_pago = wf_comprueba_forma_pago(fila)

	// MIRAMOS SI EL ARTICULO
	articulo = wf_comprueba_articulo(fila)
	
	
	// Si no ha habido problema alguno con lo que hemos hecho hasta ahora... creamos las facturas
	if id_cliente<>'-1' and (not ib_procesar_poblaciones or (ib_procesar_poblaciones and id_poblacion<>'-1')) and forma_pago<>'-1' and articulo <>'-1' then
		wf_crear_factura(fila, id_cliente, id_poblacion, articulo, forma_pago)
	else
//		messagebox('', 'id_cliente '+id_cliente+cr+'id_poblacion ' +id_poblacion+cr+'forma_pago '+forma_pago+cr+'articulo '+articulo)
		b_error = true
	end if
NEXT

idw_facturas.setredraw(true)
idw_facturas_lineas.setredraw(true)

ib_procesando = false
if b_error then 
	messagebox(g_titulo, "Todos los elementos del fichero no estaban creados previamente."+cr+"Revise las incidencias y el resto de pesata$$HEX1$$f100$$ENDHEX$$as, para grabar los elementos de las facturas."+cr+"Hasta que no se definan correctamente no se generar$$HEX1$$e100$$ENDHEX$$n la facturas")
	st_progreso.text = 'Recorriendo cada pedido se ven las incidencias de ese pedido concreto'


	// Colocamos la incidencia
	wf_colocar_incidencia(0, 'FINAL', "RECUERDE SOLUCIONAR LAS INCIDENCIAS, GRABAR ELEMENTOS Y PROCESAR NUEVAMENTE", 'N', 'N', 'C')
	
	cb_grabar_elementos.enabled = true	
else
	messagebox(g_titulo, "Procesado con $$HEX1$$e900$$ENDHEX$$xito. Pueden grabarse las facturas")
	st_progreso.text = ''
	cb_grabar_facturas.enabled = true
end if

end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4027
integer height = 1352
long backcolor = 79741120
string text = "Poblaciones"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_imprimir4 cb_imprimir4
dw_poblaciones dw_poblaciones
end type

on tabpage_4.create
this.cb_imprimir4=create cb_imprimir4
this.dw_poblaciones=create dw_poblaciones
this.Control[]={this.cb_imprimir4,&
this.dw_poblaciones}
end on

on tabpage_4.destroy
destroy(this.cb_imprimir4)
destroy(this.dw_poblaciones)
end on

event constructor;call super::constructor;this.visible = ib_procesar_poblaciones
end event

type cb_imprimir4 from commandbutton within tabpage_4
integer y = 1260
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;idw_poblaciones.print()
end event

type dw_poblaciones from u_dw within tabpage_4
integer x = 5
integer y = 4
integer width = 4018
integer height = 1248
integer taborder = 11
string dataobject = "d_import_poblaciones_gu"
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4027
integer height = 1352
long backcolor = 79741120
string text = "Forma de pago"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_imprimir5 cb_imprimir5
dw_formas_pago dw_formas_pago
end type

on tabpage_5.create
this.cb_imprimir5=create cb_imprimir5
this.dw_formas_pago=create dw_formas_pago
this.Control[]={this.cb_imprimir5,&
this.dw_formas_pago}
end on

on tabpage_5.destroy
destroy(this.cb_imprimir5)
destroy(this.dw_formas_pago)
end on

type cb_imprimir5 from commandbutton within tabpage_5
integer y = 1260
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;idw_formas_pago.print()
end event

type dw_formas_pago from u_dw within tabpage_5
integer x = 5
integer y = 4
integer width = 4018
integer height = 1248
integer taborder = 11
string dataobject = "d_import_formas_pago_corresp_gu"
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4027
integer height = 1352
long backcolor = 79741120
string text = "Facturas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_facturas_lineas dw_facturas_lineas
dw_facturas dw_facturas
end type

on tabpage_2.create
this.dw_facturas_lineas=create dw_facturas_lineas
this.dw_facturas=create dw_facturas
this.Control[]={this.dw_facturas_lineas,&
this.dw_facturas}
end on

on tabpage_2.destroy
destroy(this.dw_facturas_lineas)
destroy(this.dw_facturas)
end on

type dw_facturas_lineas from u_dw within tabpage_2
integer x = 5
integer y = 1016
integer width = 4018
integer height = 332
integer taborder = 11
string dataobject = "d_import_lineas_fact_emitidas_gu"
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type dw_facturas from u_dw within tabpage_2
integer x = 5
integer y = 4
integer width = 4018
integer height = 1008
integer taborder = 11
string dataobject = "d_import_facturacion_emitida_detalle_gu"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_rmbmenu = false
end type

event rowfocuschanging;call super::rowfocuschanging;// Filtramos el dw de abajo para ver lo de esa factura
string id_factura

if idw_facturas.rowcount() = 0 then return

if ib_procesando then return

if newrow>0 and newrow<=idw_facturas.rowcount() then
	id_factura = idw_facturas.getitemstring(newrow, 'id_factura')
	idw_facturas_lineas.setfilter("id_factura = '"+id_factura+"'")
	idw_facturas_lineas.filter()
end if
end event

type cb_grabar_elementos from commandbutton within w_importacion_facturas_gabinete_gu
integer x = 869
integer y = 876
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
boolean enabled = false
string text = "Grabar Elem."
end type

event clicked;// Grabamos cada uno de los tabs!
string mensaje, mensaje_clientes, mensaje_articulos, mensaje_poblaciones, mensaje_f_pago
string id_cliente
long fila, fila_insert
string texto


idw_clientes.trigger event pfc_accepttext(true)
idw_articulos.trigger event pfc_accepttext(true)
idw_poblaciones.trigger event pfc_accepttext(true)
idw_formas_pago.trigger event pfc_accepttext(true)

cb_ver_todas.trigger event clicked()

texto = st_progreso.text
st_progreso.text = "Validando elementos a crear"
setpointer(hourglass!)

// Validamos los clientes!
mensaje_clientes = wf_validar_clientes()
if mensaje_clientes = '-1' then 
	return
else
	if not f_es_vacio(mensaje_clientes) then mensaje += 'CLIENTES : '+mensaje_clientes+cr
end if

// Validamos los articulos!
mensaje_articulos = wf_validar_articulos()
if mensaje_articulos = '-1' then 
	return
else
	if not f_es_vacio(mensaje_articulos) then mensaje += 'ARTICULOS : '+mensaje_articulos+cr
end if


if ib_procesar_poblaciones then
	// Validamos las poblaciones!
	mensaje_poblaciones = wf_validar_poblaciones()
	if mensaje_poblaciones = '-1' then 
		return
	else
		if not f_es_vacio(mensaje_poblaciones) then mensaje += 'POBLACIONES : '+cr+mensaje_poblaciones+cr
	end if
end if


// Validamos los forma pago!
mensaje_f_pago = wf_validar_f_pago()
if mensaje_f_pago = '-1' then 
	return
else
	if not f_es_vacio(mensaje_f_pago) then mensaje += 'FORMA PAGO : '+mensaje_f_pago+cr
end if


if not f_es_vacio(mensaje) then
	messagebox(g_titulo, "Encontrados los siguientes problemas "+cr+cr+mensaje)
ELSE
	// GRABAMOS TODO EN bbdd!
	dw_temporal.update() // Grabamos las poblaciones
	
	for fila = 1 to idw_formas_pago.RowCount()
		idw_formas_pago.setitem(fila, 'id', f_siguiente_numero('f_pago_relac',10))
	next
 	idw_formas_pago.update()
	// Grabamos los articulos
	
	for fila = 1 to idw_articulos.RowCount()
		idw_articulos.setitem(fila, 'id', f_siguiente_numero('articulo_relac',10))
	next
	idw_articulos.update()
	
	// Grabamos los clientes
	// Colocamos el id
	for fila = 1 to idw_clientes.RowCount()
		id_cliente = f_siguiente_numero('CLIENTES',10)
		idw_clientes.SetItem(fila,'id_cliente',id_cliente)
		// Generamos el tipo de tercero
		fila_insert = dw_clientes_terceros.InsertRow(0)
		dw_clientes_terceros.SetItem(fila_insert,'id',f_siguiente_numero('CLIENTES_TERCEROS',10))
		dw_clientes_terceros.SetItem(fila_insert,'id_cliente',id_cliente)
		dw_clientes_terceros.SetItem(fila_insert,'c_tercero', g_terceros_codigos.cliente_gabinete)
	next

	idw_clientes.update()
	dw_clientes_terceros.update()
	
	this.enabled = false
end if

st_progreso.text = texto
setpointer(arrow!)
end event

type cb_grabar_facturas from commandbutton within w_importacion_facturas_gabinete_gu
integer x = 1289
integer y = 876
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
boolean enabled = false
string text = "Grabar Facts."
end type

event clicked;// Hay que generar las facturas correctamente y guardarlas
st_facturas datos_facturacion
datastore lineas_factura
string id_factura_primera, id_factura_ultima, id_factura, mensaje = '', nif, nombre, domicilio, poblacion,n_fact
long fila, j
double total_linea, n_fact_contador


// Aceptamos los datos
idw_facturas.AcceptText()
idw_facturas_lineas.AcceptText()


cb_ver_todas.trigger event clicked()// Quitamos ltodos los filtros
// VALIDACIONES
mensaje = wf_validar_facturas()

if not f_es_vacio(mensaje) then 
	Messagebox(g_titulo, mensaje, stopsign!)
	return
end if

// Creamos el datastore
lineas_factura = create Datastore
lineas_factura.DataObject = 'd_fases_lineas_facturas'
lineas_factura.SetTransObject(SQLCA)


// Evitamos el vaile del dw
idw_facturas_lineas.setredraw(false)
FOR fila = 1 TO idw_facturas.RowCount()
	// Filtramos las lineas de esa factura solo
	idw_facturas_lineas.setfilter("id_factura = '"+idw_facturas.getitemstring(fila, 'id_factura')+"'")
	idw_facturas_lineas.filter()	
	
	nif = idw_facturas.GetItemString(fila,'nif')
	nombre = idw_facturas.GetItemString(fila,'nombre')
	domicilio = idw_facturas.GetItemString(fila,'domicilio')
	poblacion = idw_facturas.GetItemString(fila,'poblacion')
	
	
	datos_facturacion.id_receptor		= idw_facturas.GetItemString(fila,'id_persona')
	datos_facturacion.formapago		= idw_facturas.GetItemString(fila,'formadepago')
	datos_facturacion.serie				= is_serie_facturas_gabinete
	datos_facturacion.fecha				= idw_facturas.GetItemDateTime(fila,'fecha')
	datos_facturacion.num_originales	= 0
	datos_facturacion.num_copias		= 0
	datos_facturacion.banco				= idw_facturas.GetItemString(fila,'banco')
	datos_facturacion.asunto			= idw_facturas.GetItemString(fila,'asunto')
	datos_facturacion.obs				= idw_facturas.GetItemString(fila,'obs')
	datos_facturacion.tipo_factura 	= idw_facturas.GetItemString(fila,'tipo_factura')
	datos_facturacion.incluir_todos 	= 'S'
	datos_facturacion.pagada			= idw_facturas.GetItemString(fila,'pagado')
	datos_facturacion.es_colegiado	= false

	// N$$HEX1$$fa00$$ENDHEX$$mero de factura
	n_fact_contador = double(idw_facturas.GetItemString(fila,'id_pedido'))
	// Componemos el n$$HEX1$$fa00$$ENDHEX$$mero de factura
	n_fact = RightA('000000'+idw_facturas.GetItemString(fila,'id_pedido'),6)
	n_fact = LeftA( RightA(trim(datos_facturacion.serie),6) + '-' + RightA(g_ejercicio,2) + n_fact, 15)
	datos_facturacion.n_fact = n_fact
	// Actualizamos el contador con la $$HEX1$$fa00$$ENDHEX$$ltima factura
	if n_fact_contador>= 0 then
		update csi_series
		set contador=:n_fact_contador
		where serie=:is_serie_facturas_gabinete;
	end if
	COMMIT;
	

	lineas_factura.reset()
	FOR j=1 TO idw_facturas_lineas.RowCount()
		
		lineas_factura.InsertRow(0)
		lineas_factura.SetItem(j,'descripcion_larga',idw_facturas_lineas.GetItemString(j,'descripcion_larga'))
		lineas_factura.SetItem(j,'precio',idw_facturas_lineas.GetItemNumber(j,'precio'))
		lineas_factura.SetItem(j,'unidades',idw_facturas_lineas.GetItemNumber(j,'unidades'))
		lineas_factura.SetItem(j,'subtotal',idw_facturas_lineas.GetItemNumber(j,'subtotal'))
		lineas_factura.SetItem(j,'t_iva',idw_facturas_lineas.GetItemString(j,'t_iva'))
		lineas_factura.SetItem(j,'subtotal_iva',idw_facturas_lineas.GetItemNumber(j,'subtotal_iva'))
		lineas_factura.SetItem(j,'articulo',idw_facturas_lineas.GetItemString(j,'articulo'))
		total_linea = idw_facturas_lineas.GetitemNumber(j, 'subtotal') - idw_facturas_lineas.GetItemNumber(j, 'importe_dto')+idw_facturas_lineas.GetItemNumber(j, 'subtotal_iva')
		lineas_factura.SetItem(j,'total',total_linea)
	NEXT
	
	datos_facturacion.ds_lineas = lineas_factura
	
	// Generamos la factura
	id_factura = f_factura(datos_facturacion)
         
	if id_factura='-1' then 
		Messagebox(g_titulo, "Se ha producido un error al generar las facturas. Avise al depatarmento de inform$$HEX1$$e100$$ENDHEX$$tica, enviando el fichero cargado")
		destroy lineas_factura
		idw_facturas_lineas.setfilter("")
		idw_facturas_lineas.filter()	
		idw_facturas_lineas.setredraw(true)
		return
	else
		// Cambiamos la nombre, nif, y poblacion a los indicados en la factura y el centro, por si no coinciden 100%
		UPDATE csi_facturas_emitidas SET nif = :nif,nombre = :nombre,domicilio = :domicilio,poblacion = :poblacion, centro =:is_centro_facturas_gabinete WHERE id_factura = :id_factura;
		// CAmbiamos el centro de los cobros y de los articulos
		UPDATE csi_lineas_fact_emitidas SET centro = :is_centro_facturas_gabinete WHERE id_factura = :id_factura;
		UPDATE csi_cobros SET centro = :is_centro_facturas_gabinete WHERE id_factura = :id_factura;
	end if
	
	// Nos apuntamos las facturas
	if f_es_vacio(id_factura_primera) then id_factura_primera = id_factura
	id_factura_ultima = id_factura
NEXT

MessageBox(g_titulo, 'El proceso se ha realizado con $$HEX1$$e900$$ENDHEX$$xito. '+cr+&
			+ 'Rango de facturas creadas: ' + f_dame_n_fact_de_id(id_factura_primera) + ' - '  +&
			+ f_dame_n_fact_de_id(id_factura_ultima), Information!)


// volvemos a permitir el redibujado
idw_facturas_lineas.reset()
idw_facturas.reset()
idw_facturas_lineas.setredraw(true)
cb_grabar_facturas.enabled = false
cb_procesar.enabled = false

// Destruimos el datastore
destroy lineas_factura
end event

type dw_temporal from u_dw within w_importacion_facturas_gabinete_gu
boolean visible = false
integer x = 2487
integer y = 864
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_mant_poblaciones"
end type

type cb_ver_todas from commandbutton within w_importacion_facturas_gabinete_gu
integer x = 3749
integer y = 876
integer width = 343
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Ver Todas"
end type

event clicked;ib_filtrar = false
parent.trigger event csd_aplicar_filtros(0)
end event

type dw_clientes_terceros from u_dw within w_importacion_facturas_gabinete_gu
boolean visible = false
integer x = 2830
integer y = 868
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_clientes_terceros"
end type

type st_progreso from statictext within w_importacion_facturas_gabinete_gu
integer x = 1742
integer y = 884
integer width = 1554
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_fichero from u_dw within w_importacion_facturas_gabinete_gu
integer x = 27
integer y = 12
integer width = 4064
integer height = 840
integer taborder = 10
string dataobject = "d_import_facturas_gabinete_gu"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;parent.trigger event csd_aplicar_filtros(currentrow)
end event

