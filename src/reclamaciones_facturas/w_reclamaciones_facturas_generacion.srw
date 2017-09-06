HA$PBExportHeader$w_reclamaciones_facturas_generacion.srw
forward
global type w_reclamaciones_facturas_generacion from w_detalle
end type
type cb_generar_cartas from commandbutton within w_reclamaciones_facturas_generacion
end type
type dw_facturas from u_dw within w_reclamaciones_facturas_generacion
end type
type cb_buscar_facturas from commandbutton within w_reclamaciones_facturas_generacion
end type
type cb_imprimir_cartas from commandbutton within w_reclamaciones_facturas_generacion
end type
type cb_carta_previa from commandbutton within w_reclamaciones_facturas_generacion
end type
end forward

global type w_reclamaciones_facturas_generacion from w_detalle
integer width = 4155
integer height = 1724
cb_generar_cartas cb_generar_cartas
dw_facturas dw_facturas
cb_buscar_facturas cb_buscar_facturas
cb_imprimir_cartas cb_imprimir_cartas
cb_carta_previa cb_carta_previa
end type
global w_reclamaciones_facturas_generacion w_reclamaciones_facturas_generacion

type variables
boolean ib_consulta_ventana = false
string isql_original
end variables

forward prototypes
public subroutine wf_imprimir_cartas ()
end prototypes

public subroutine wf_imprimir_cartas ();long copias, fila, k
string tipo_reclamacion, id_grupo, id_factura, dw, lista_ids, sql

// Preguntamos las copias que se quieren imprimir
openwithparm(w_n_copias, 'RECLAMACION')
if not isnumber(Message.StringParm) then return
copias = long(Message.StringParm)
// fin  copias


// Creamos el datastore
datastore ds
ds = create datastore
FOR fila = 1 TO dw_1.RowCount()
	
	// Hay que generar la nueva reclamacion
	tipo_reclamacion = dw_1.getitemString(fila, 'tipo_reclamacion')
	// Colocamos el dw asociado al tipo de reclamacion en el datastore a imprimir
	dw = f_dame_dw_asociado_tipo_reclamacion(tipo_reclamacion)
	if f_es_vacio(dw) then return
	ds.dataobject = dw
	ds.settransobject (SQLCA)
	
	
	// Seg$$HEX1$$fa00$$ENDHEX$$n sea agrupada o sin agrupar hacemos una cosa u otra
	if f_reclamacion_agrupada(tipo_reclamacion) then
		id_factura = dw_1.getitemString(fila, 'id_factura')
		id_grupo = dw_1.getitemString(fila, 'id_grupo')
		ds.retrieve(id_factura)
		// Las recorremos para imprimirlas
		for k = 1 to copias
			if ds.rowcount()>0 then ds.print()
		next
		// Agregamos todas las facturas del grupo para imprimir el listado
		lista_ids = "'"+id_factura+"'"
		// Nos tenemos que saltar todas las facturas de este grupo
		DO WHILE fila<dw_1.RowCount() 
			if f_es_vacio(dw_1.getitemString(fila+1, 'id_grupo')) then exit
			if id_grupo<>dw_1.getitemString(fila+1, 'id_grupo') then
				// Salimos del bucle
				exit
			else
				// Pasamos todas las que sean de este grupo
				if LenA(lista_ids)>0 then lista_ids += ", "
				id_factura = dw_1.getitemString(fila+1, 'id_factura')
				lista_ids += "'"+id_factura+"'"
				fila++
			end if
		LOOP
		// Cambiamos al listado de facturas e imprimimos este
		ds.dataobject = 'd_reclamaciones_facturas_agrup_facts'
		ds.settransobject (SQLCA)
		sql = ds.describe("datawindow.table.select")
		// Anyadimos la condicion de las facturas
		sql += " AND csi_facturas_emitidas.id_factura in ("+lista_ids+")"
		ds.modify("datawindow.table.select= ~"" + sql + "~"")
		ds.retrieve()
		for k = 1 to copias
			if ds.rowcount()>0 then ds.print()
		next
	else
		id_factura = dw_1.getitemString(fila, 'id_factura')
		ds.retrieve(id_factura)
		// Las recorremos para imprimirlas
		for k = 1 to copias
			if ds.rowcount()>0 then ds.print()
		next
	end if

	
	// Si nos hemos pasado de rango salimos
	if fila>dw_1.RowCount() then exit
NEXT
// Destruimos el datastore
destroy ds
end subroutine

on w_reclamaciones_facturas_generacion.create
int iCurrent
call super::create
this.cb_generar_cartas=create cb_generar_cartas
this.dw_facturas=create dw_facturas
this.cb_buscar_facturas=create cb_buscar_facturas
this.cb_imprimir_cartas=create cb_imprimir_cartas
this.cb_carta_previa=create cb_carta_previa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_generar_cartas
this.Control[iCurrent+2]=this.dw_facturas
this.Control[iCurrent+3]=this.cb_buscar_facturas
this.Control[iCurrent+4]=this.cb_imprimir_cartas
this.Control[iCurrent+5]=this.cb_carta_previa
end on

on w_reclamaciones_facturas_generacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_generar_cartas)
destroy(this.dw_facturas)
destroy(this.cb_buscar_facturas)
destroy(this.cb_imprimir_cartas)
destroy(this.cb_carta_previa)
end on

event open;call super::open;inv_resize.of_unregister(dw_1)
inv_resize.of_Register (dw_1, "ScaletoRight&Bottom")
inv_resize.of_Register (dw_facturas, "ScaletoRight")

// Nos guardamos la sql original
isql_original = dw_facturas.describe("datawindow.table.select")

end event

event type integer csd_nuevo();// Sobreescrito
return -1

end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_reclamaciones_facturas_generacion
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_reclamaciones_facturas_generacion
end type

type cb_nuevo from w_detalle`cb_nuevo within w_reclamaciones_facturas_generacion
end type

type cb_ayuda from w_detalle`cb_ayuda within w_reclamaciones_facturas_generacion
end type

type cb_grabar from w_detalle`cb_grabar within w_reclamaciones_facturas_generacion
end type

type cb_ant from w_detalle`cb_ant within w_reclamaciones_facturas_generacion
end type

type cb_sig from w_detalle`cb_sig within w_reclamaciones_facturas_generacion
end type

type dw_1 from w_detalle`dw_1 within w_reclamaciones_facturas_generacion
integer x = 9
integer y = 840
integer width = 4082
integer height = 700
string dataobject = "d_reclamaciones_facturas_lista"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event dw_1::csd_retrieve;call super::csd_retrieve;if f_es_vacio(g_reclamaciones_facturas.consulta) then return


// Tenemos la consulta en la variable global, solo tenemos que sacar el where
long pos, pos_nueva
string consulta, sql_nuevo, sql_original

pos = PosA(g_reclamaciones_facturas.consulta, "WHERE")
if ib_consulta_ventana then pos = 1

// Sacamos la parte del where
if pos >0 then
	if not ib_consulta_ventana then
		consulta = MidA(g_reclamaciones_facturas.consulta, pos, LenA(g_reclamaciones_facturas.consulta))
		// Concatenamos esta consulta a nuestro dw
		// 	 SCP-601
		pos = PosA(g_reclamaciones_facturas.consulta, "FROM")
		consulta="id_factura in (Select id_factura "+MidA(g_reclamaciones_facturas.consulta, pos, LenA(g_reclamaciones_facturas.consulta))+")"
	
		//
		sql_nuevo = dw_facturas.describe("datawindow.table.select")
		pos_nueva = PosA(sql_nuevo, "WHERE")
		if pos>0 then
			sql_nuevo = sql_nuevo+" and "+consulta
		else
			sql_nuevo = sql_nuevo+" where "+consulta
		end if
		
		//Andres: $$HEX1$$bf00$$ENDHEX$$Este es un buen sitio para a$$HEX1$$f100$$ENDHEX$$adir mi condicion?
		//..and where csi_facturas_emitidas.total>0
		dw_facturas.setredraw(false)	
		//Colocamos la nueva SQL

		dw_facturas.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
	end if
	// Retriveamos
	dw_facturas.retrieve()
	// Restauramos la SQL
	dw_facturas.modify("datawindow.table.select= ~"" + isql_original + "~"")
	
	long fila
	string id_factura, tipo_persona, remesada, tipo_reclamacion

	if dw_facturas.rowcount()<1 then 
		dw_facturas.setredraw(true)	
		return
	end if

	FOR fila = 1 TO dw_facturas.rowcount()
		id_factura = dw_facturas.getitemstring(fila, 'id_factura')
		tipo_persona = dw_facturas.getitemstring(fila, 'tipo_persona')
		remesada = f_dame_remesada_factura(id_factura)
		
		tipo_reclamacion = f_dame_reclamacion_siguiente(id_factura, tipo_persona, remesada)
		
		// Colocamos el tipo de 
		dw_facturas.setitem(fila, 'tipo_reclamacion', tipo_reclamacion)
		if tipo_reclamacion = 'NO' then dw_facturas.setitem(fila, 'generar_reclamacion', 'N')
		// Evitamos que casque luego... si no tiene valor le quitamos el check de generar reclamacion
		if f_es_vacio(tipo_reclamacion) then dw_facturas.setitem(fila, 'generar_reclamacion', 'N')
	NEXT
	//dw_facturas.sort()
	// Volvemos a permitir el redibujado
	dw_facturas.setredraw(true)	
	dw_1.reset()
end if



g_reclamaciones_facturas.consulta = ''
end event

type cb_generar_cartas from commandbutton within w_reclamaciones_facturas_generacion
integer x = 1696
integer y = 716
integer width = 631
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Generaci$$HEX1$$f300$$ENDHEX$$n de Cartas"
end type

event clicked;

long fila, fila_insert
string tipo_reclamacion, id_grupo, nombre = '', nombre_ant = '-1'

if dw_facturas.RowCount()>0 then
	FOR fila = 1 TO dw_facturas.RowCount()
		if dw_facturas.getitemString(fila, 'generar_reclamacion') = 'S' then
			// Hay que generar la nueva reclamacion
			tipo_reclamacion = dw_facturas.getitemString(fila, 'tipo_reclamacion')
			nombre = dw_facturas.getitemString(fila, 'nombre')
			
			if f_reclamacion_agrupada(tipo_reclamacion) then
				if nombre <> nombre_ant then
					// Generamos un nuevo numero de grupo
					id_grupo = f_siguiente_numero('RECLAM_FACT_GRUPO', 10)
					nombre_ant = nombre
				end if
			else
				id_grupo = ''
			end if
			
			// Colocamos la fila en el nuevo valor
			fila_insert = dw_1.insertrow(0)
			dw_1.setitem(fila_insert, 'id_reclamacion_factura', f_siguiente_numero('RECLAM_FACT', 10))
			dw_1.setitem(fila_insert, 'id_grupo', id_grupo)
			dw_1.setitem(fila_insert, 'f_reclamacion', datetime(today(), now()))
			dw_1.setitem(fila_insert, 'tipo_reclamacion', tipo_reclamacion)
			dw_1.setitem(fila_insert, 'id_factura', dw_facturas.getitemString(fila, 'id_factura'))
			dw_1.setitem(fila_insert, 'n_fact', dw_facturas.getitemString(fila, 'n_fact'))
			dw_1.setitem(fila_insert, 'fecha', dw_facturas.getitemDateTime(fila, 'fecha'))
			dw_1.setitem(fila_insert, 'nombre', dw_facturas.getitemString(fila, 'nombre'))
			dw_1.setitem(fila_insert, 'tipo_persona', dw_facturas.getitemString(fila, 'tipo_persona'))
		end if
	NEXT
	// Una vez generadas las facturas... vaciamos
	dw_facturas.reset()
end if

// Imprimimos las cartas
wf_imprimir_cartas()
end event

type dw_facturas from u_dw within w_reclamaciones_facturas_generacion
integer x = 9
integer y = 4
integer width = 4082
integer height = 700
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_reclamaciones_facturas_generacion"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;// Colocamos el filtrado de las pagadas
// modificado por andr$$HEX1$$e900$$ENDHEX$$s: No han de salir las facturas cuyo total<=0 (a$$HEX1$$f100$$ENDHEX$$adido "and total>0")
// Modificado David 26/12/2005: Filtramos por el nuevo campo "reclamar" de las facturas 
//this.setfilter("pagado <>'S' and total>0 and reclamar = 'S' and ( isnull(id_fase) or id_fase = '')")
this.setsort("nombre A") 

end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE 'tipo_reclamacion'
		IF data = 'NO' then this.setitem(row, 'generar_reclamacion', 'N')
	CASE 'generar_reclamacion'
		if this.getitemstring(row, 'tipo_reclamacion') = 'NO' and data = 'S' then
			post messagebox(g_titulo, "No existe carga asociada a este tipo de reclamacion")
			return 2
		end if
END CHOOSE
end event

type cb_buscar_facturas from commandbutton within w_reclamaciones_facturas_generacion
integer x = 1051
integer y = 716
integer width = 631
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Buscar facturas"
end type

event clicked;// Hacemos que la variable global apunte a nuestro dw 
g_dw_lista = dw_facturas

// Abrimos la ventana de consulta de facturas
open(w_facturacion_emitida_consulta)
ib_consulta_ventana = true
g_reclamaciones_facturas.consulta = '-1' // Colocamos algo
dw_1.trigger event csd_retrieve()
ib_consulta_ventana = false
end event

type cb_imprimir_cartas from commandbutton within w_reclamaciones_facturas_generacion
integer x = 2341
integer y = 716
integer width = 631
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Imprimir Cartas"
end type

event clicked;// Imprimimos las cartas
wf_imprimir_cartas()
end event

type cb_carta_previa from commandbutton within w_reclamaciones_facturas_generacion
integer x = 2985
integer y = 716
integer width = 631
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Carta previa"
end type

event constructor;//CHOOSE CASE g_colegio
//	CASE 'COAATLR'
//		this.visible = true
//	CASE 'COAATGC'
//		this.visible = true
//	CASE ELSE
//		this.visible = false
//END CHOOSE
end event

event clicked;long fila, fila_insert, respuesta = -1
string tipo_reclamacion, id_grupo, nombre = '', nombre_ant = '-1'

// Estas cartas no se guardan !!!!


if dw_facturas.RowCount()>0 then
	FOR fila = 1 TO dw_facturas.RowCount()
		if dw_facturas.getitemString(fila, 'generar_reclamacion') = 'S' then
			// Hay que generar la nueva reclamacion
			tipo_reclamacion = '99'
			nombre = dw_facturas.getitemString(fila, 'nombre')
			
			if f_reclamacion_agrupada(tipo_reclamacion) then
				if nombre <> nombre_ant then
					// Generamos un nuevo numero de grupo
					id_grupo = f_siguiente_numero('RECLAM_FACT_GRUPO', 10)
					nombre_ant = nombre
				end if
			else
				id_grupo = ''
			end if
			
			if respuesta = -1 then
				respuesta = Messagebox(g_titulo, "Va a imprimir las cartas previas. Estas no se quedan almacenadas"+cr+"$$HEX1$$bf00$$ENDHEX$$Desea continuar?",question!, yesno!,2)
				if respuesta = 2 then return
			end if
			
			// Colocamos la fila en el nuevo valor
			fila_insert = dw_1.insertrow(0)
//			dw_1.setitem(fila_insert, 'id_reclamacion_factura', f_siguiente_numero('RECLAM_FACT', 10))
			dw_1.setitem(fila_insert, 'id_grupo', id_grupo)
			dw_1.setitem(fila_insert, 'f_reclamacion', datetime(today(), now()))
			dw_1.setitem(fila_insert, 'tipo_reclamacion', tipo_reclamacion)
			dw_1.setitem(fila_insert, 'id_factura', dw_facturas.getitemString(fila, 'id_factura'))
			dw_1.setitem(fila_insert, 'n_fact', dw_facturas.getitemString(fila, 'n_fact'))
			dw_1.setitem(fila_insert, 'fecha', dw_facturas.getitemDateTime(fila, 'fecha'))
			dw_1.setitem(fila_insert, 'nombre', dw_facturas.getitemString(fila, 'nombre'))
			dw_1.setitem(fila_insert, 'tipo_persona', dw_facturas.getitemString(fila, 'tipo_persona'))
		end if
	NEXT
	// Una vez generadas las facturas... vaciamos
	dw_facturas.reset()
end if

// Imprimimos las cartas
wf_imprimir_cartas()
// Y borramos las previas
dw_1.reset()
end event

