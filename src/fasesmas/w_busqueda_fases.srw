HA$PBExportHeader$w_busqueda_fases.srw
forward
global type w_busqueda_fases from w_busqueda
end type
type dw_3 from u_dw within w_busqueda_fases
end type
end forward

global type w_busqueda_fases from w_busqueda
integer width = 2985
integer height = 2116
dw_3 dw_3
end type
global w_busqueda_fases w_busqueda_fases

type variables
string sql
end variables

on w_busqueda_fases.create
int iCurrent
call super::create
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
end on

on w_busqueda_fases.destroy
call super::destroy
destroy(this.dw_3)
end on

event open;call super::open;sql = dw_1.describe("datawindow.table.select")

dw_3.SetFocus()
//dw_1.retrieve('%')
end event

event pfc_updatespending;call super::pfc_updatespending;return 0
end event

type cb_recuperar_pantalla from w_busqueda`cb_recuperar_pantalla within w_busqueda_fases
end type

type cb_guardar_pantalla from w_busqueda`cb_guardar_pantalla within w_busqueda_fases
end type

type sle_1 from w_busqueda`sle_1 within w_busqueda_fases
end type

type dw_2 from w_busqueda`dw_2 within w_busqueda_fases
boolean visible = false
integer x = 832
integer y = 544
integer width = 1975
integer height = 92
integer taborder = 50
end type

event dw_2::editchanged;if not f_es_vacio(data) then dw_1.Retrieve(data+'%')
end event

type st_1 from w_busqueda`st_1 within w_busqueda_fases
end type

type st_2 from w_busqueda`st_2 within w_busqueda_fases
boolean visible = false
integer y = 552
integer width = 777
string text = "Apellido/Sociedad activo al teclear:"
end type

type cb_1 from w_busqueda`cb_1 within w_busqueda_fases
integer y = 1880
integer taborder = 70
end type

event cb_1::clicked;if dw_1.Rowcount() < 1 then
	//Lanzamos el Btn. Buscar si ha puesto valor en alguno de los campos de consulta
	dw_3.AcceptText()
	IF (NOT f_es_vacio(dw_3.GetItemString(1,'n_expediente')) OR &
		NOT f_es_vacio(dw_3.GetItemString(1,'n_registro'))  OR &
 		NOT f_es_vacio(dw_3.GetItemString(1,'estado')) OR &
		NOT f_es_vacio(dw_3.GetItemString(1,'emplazamiento')) OR &
		NOT f_es_vacio(dw_3.GetItemString(1,'id_colegiado')) OR &
		NOT f_es_vacio(dw_3.GetItemString(1,'nombre_colegiado')) OR &
		NOT f_es_vacio(dw_3.GetItemString(1,'trabajo'))  OR &
		NOT f_es_vacio(dw_3.GetItemString(1,'tipo_trabajo')) OR &
		NOT f_es_vacio(dw_3.GetItemString(1,'poblacion')) OR &
		NOT f_es_vacio(dw_3.GetItemString(1,'nombre_via')) OR &
		NOT f_es_vacio(dw_3.GetItemString(1,'id_cliente')) OR &
		NOT f_es_vacio(dw_3.GetItemString(1,'nombre_promotor')) OR &
		NOT isnull(dw_3.GetItemDateTime(1,'f_entrada_desde'))  OR &
		NOT isnull(dw_3.GetItemDateTime(1,'f_visado_desde'))  OR &
		NOT isnull(dw_3.GetItemDateTime(1,'f_abono_desde')) ) THEN
				dw_3.TriggerEvent("buttonclicked")
	END IF
	
	// Si no ha encontrado ninguno, cerramos la ventana
	if dw_1.Rowcount() < 1 then
		parent.event pfc_close()
		return
	end if
end if
closewithreturn(parent,dw_1.GetItemString(dw_1.GetRow(),1))

end event

type cb_2 from w_busqueda`cb_2 within w_busqueda_fases
integer y = 1880
integer taborder = 80
boolean cancel = true
end type

type dw_1 from w_busqueda`dw_1 within w_busqueda_fases
integer x = 37
integer y = 1068
integer width = 2894
integer height = 760
integer taborder = 60
end type

event dw_1::constructor;call super::constructor;// Column header sort
inv_sort.of_SetColumnHeader (true)
// Set to simple sort style
inv_sort.of_SetStyle (2)
end event

event dw_1::pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_debug.enabled = False

end event

type dw_3 from u_dw within w_busqueda_fases
integer x = 14
integer width = 2853
integer height = 1032
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_fases_consulta_busqueda"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;string  sql_nuevo = '', sql_origen = ''
string  n_colegiado, n_nif, n_expediente
string  id_col, id_cliente, pob
boolean do_case = False

if isnull(dwo) then do_case = False else do_case = True

if do_case then
	choose case dwo.name
		case "b_1"
			this.accepttext()
			sql_nuevo = dw_1.describe("datawindow.table.select")
			sql_origen= sql_nuevo
		
			//Se inicializan los id de Colegiado y cliente para no alterar el sql
			dw_3.setitem(1,'id_colegiado','')
			dw_3.setitem(1,'id_cliente','')
		
			// Se preparan los id de Colegiados y Cliente
			n_colegiado = dw_3.getitemstring(1,'n_colegiado')
			if not f_es_vacio(n_colegiado) then
				dw_3.setitem(1,'id_colegiado',f_busca_id_colegiado_por_codigo(n_colegiado))
			end if	
			
			n_nif = dw_3.getitemstring(1,'nif_promotor')
			if not f_es_vacio(n_nif) then
				dw_3.setitem(1,'id_cliente',f_cliente_id_cliente(n_nif))
			end if	
			
			// ICC-57
			if g_colegio = 'COAATCC' then
				string n_registro
				n_registro =  dw_3.getitemstring(1,'n_registro')
				if not f_es_vacio(n_registro) and len(n_registro) < 6 then
					n_registro = 'C' + right(g_ejercicio,2) + right('00000' + n_registro,5) + f_delegacion_siglas(g_cod_delegacion)
					dw_3.setitem(1,'n_registro',n_registro)
				end if
			end if			
			
			f_sql('expedientes.n_expedi','LIKE','n_expediente',dw_3,sql_nuevo,g_tipo_base_datos,'')
			f_sql('fases.n_registro','LIKE','n_registro',dw_3,sql_nuevo,g_tipo_base_datos,'')
			f_sql('fases.f_entrada','>=','f_entrada_desde',dw_3,sql_nuevo,g_tipo_base_datos,'')
			f_sql('fases.f_entrada','<','f_entrada_hasta',dw_3,sql_nuevo,g_tipo_base_datos,'')
			f_sql('fases.f_visado','>=','f_visado_desde',dw_3,sql_nuevo,g_tipo_base_datos,'')
			f_sql('fases.f_visado','<','f_visado_hasta',dw_3,sql_nuevo,g_tipo_base_datos,'')
			f_sql('fases.f_abono','>=','f_abono_desde',dw_3,sql_nuevo,g_tipo_base_datos,'')
			f_sql('fases.f_abono','<','f_abono_hasta',dw_3,sql_nuevo,g_tipo_base_datos,'')
			f_sql('fases.estado','LIKE','estado',dw_3,sql_nuevo,g_tipo_base_datos,'')
			f_sql('fases.fase','LIKE','fase',dw_3,sql_nuevo,g_tipo_base_datos,'')
			f_sql('fases.n_calle','LIKE','n_calle',dw_3,sql_nuevo,g_tipo_base_datos,'')
			f_sql('fases.trabajo','=','trabajo',dw_3,sql_nuevo,g_tipo_base_datos,'')
			f_sql('fases.tipo_trabajo','=','tipo_trabajo',dw_3,sql_nuevo,g_tipo_base_datos,'')
			f_sql('fases.poblacion','=','poblacion',dw_3,sql_nuevo,g_tipo_base_datos,'')
			f_sql('poblaciones.descripcion','=','des_poblacion',dw_3,sql_nuevo,g_tipo_base_datos,'')
			f_sql('fases.emplazamiento','LIKE INSIDE','emplazamiento',dw_3,sql_nuevo,g_tipo_base_datos,'')
		
			f_sql('fases_colegiados.id_col','LIKE','id_colegiado',dw_3,sql_nuevo,g_tipo_base_datos,'')
			f_sql('colegiados.apellidos','LIKE','nombre_colegiado',dw_3,sql_nuevo,g_tipo_base_datos,'')
		
			f_sql('fases_clientes.id_cliente','LIKE','id_cliente',dw_3,sql_nuevo,g_tipo_base_datos,'') 
			f_sql('clientes.apellidos','LIKE','nombre_promotor',dw_3,sql_nuevo,g_tipo_base_datos,'') 
			
			f_sql('expedientes.archivo','LIKE','archivo',dw_3,sql_nuevo,g_tipo_base_datos,'')
			f_sql('fases.archivo','LIKE','archivo_fases',dw_3,sql_nuevo,g_tipo_base_datos,'')
			
			//messagebox(' sql ',sql_nuevo)
			if sql_nuevo=sql_origen then 
				MessageBox(g_titulo,'Ha de especificar al menos un par$$HEX1$$e100$$ENDHEX$$metro de b$$HEX1$$fa00$$ENDHEX$$squeda')
			else
				dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
				// dw_2.setitem(1,1,'') 		// no se usa esta DW en esta ventana
				dw_1.Retrieve('%')
			
				// Se restablece la propiedad select para una nueva consulta
				dw_1.modify("datawindow.table.select= ~"" + sql_origen + "~"")
				
				// Para restablecer el valor inicial en DW
				// dw_3.setitem(1,'n_expediente','')	
			end if
				
		case "b_busca_colegiado"
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
			g_busqueda.dw="d_lista_busqueda_colegiados"
			id_col=f_busqueda_colegiados()
			if NOT f_es_vacio(id_col)  then
				this.setitem(1,'n_colegiado',f_colegiado_n_col(id_col))
			end if
	
		case "b_busca_cliente"
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Clientes"
			g_busqueda.dw="d_lista_busqueda_clientes"
			id_cliente=f_busqueda_clientes("")
			if NOT f_es_vacio(id_cliente)  then
				this.setitem(1,'nif_promotor',f_dame_nif(id_cliente))
			end if
	
		CASE 'bb_poblacion'
			g_busqueda.titulo='Poblaciones'
			g_busqueda.dw='d_poblaciones_lista_busqueda'
			pob=f_busqueda_poblaciones()
			if f_es_vacio(pob) then return
			this.SetItem(1,'poblacion',pob)
		end choose
end if

end event

event constructor;call super::constructor;this.insertrow(0)

//Se activa el Drop Down para el Calendar
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

// this.setformat('f_entrada','dd/mm/yyyy')
end event

event itemerror;call super::itemerror;// messagebox(g_titulo,'La informaci$$HEX1$$f300$$ENDHEX$$n introducida en alg$$HEX1$$fa00$$ENDHEX$$n par$$HEX1$$e100$$ENDHEX$$metro es incorrecta')
return 1
end event

