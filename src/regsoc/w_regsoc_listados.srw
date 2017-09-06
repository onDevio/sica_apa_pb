HA$PBExportHeader$w_regsoc_listados.srw
forward
global type w_regsoc_listados from w_listados
end type
end forward

global type w_regsoc_listados from w_listados
integer height = 2148
string title = "Listados Registro Sociedades"
end type
global w_regsoc_listados w_regsoc_listados

on w_regsoc_listados.create
call super::create
end on

on w_regsoc_listados.destroy
call super::destroy
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

// Se desplaza el apuntador al primer registro
dw_listados_varios.scrolltorow(1)
dw_listados_varios.setfocus()

end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_regsoc_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_regsoc_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_regsoc_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_regsoc_listados
integer x = 2679
integer width = 955
end type

type cb_ver from w_listados`cb_ver within w_regsoc_listados
end type

event cb_ver::clicked;call super::clicked;string sql_nuevo, listado,descripcion
 
long i,filas
 
dw_listados.AcceptText()
dw_1.of_setprintpreview(TRUE)
sql_nuevo = g_dw_lista.describe("datawindow.table.select")
string apellidos,nombre,cif,colegio,n_colegiado,razon,cif_sociedad
cif_sociedad=dw_listados.getitemstring(1,'cif')
razon=dw_listados.getitemstring(1,'razon')
apellidos=dw_listados.getitemstring(1,'apellidos')
nombre=dw_listados.getitemstring(1,'nombre')
cif=dw_listados.getitemstring(1,'cif_socio')
colegio=dw_listados.getitemstring(1,'colegio')
n_colegiado=dw_listados.getitemstring(1,'num_colegiado')
// Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios

if dw_listados_varios.rowcount()= 0 then return

listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado
if (listado='d_regsoc_listados_sociedades' or listado='d_regsoc_listados_socios') and g_modo_funcionamiento='1' then
 // enlazamos con colegiados
 dw_1.dataobject = listado + '_enlazado'
end if
// Se asigna el titulo del informe con la descripcion
descripcion=dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'descripcion')
 
dw_1.of_SetTransObject(SQLCA)
sql_nuevo = dw_1.describe("datawindow.table.select")
 
// RYC 2008
// REALIZAMOS LAS CONSULTAS
f_sql('multidisciplinar','LIKE','multidisciplinar',dw_listados,sql_nuevo,g_tipo_base_datos,'')
f_sql('acreditado','LIKE','acreditado',dw_listados,sql_nuevo,g_tipo_base_datos,'')
f_sql('num_reg_colegio','LIKE','n_reg_colegio',dw_listados,sql_nuevo,g_tipo_base_datos,'')
f_sql('num_reg_mercantil','LIKE','n_reg_mercantil',dw_listados,sql_nuevo,g_tipo_base_datos,'')
f_sql('cod_forma_juridica','LIKE','cod_forma_juridica',dw_listados,sql_nuevo,g_tipo_base_datos,'')
f_sql('cod_reg_mercantil','LIKE','cod_reg_mercantil',dw_listados,sql_nuevo,g_tipo_base_datos,'')
if g_modo_funcionamiento<>'1' then    ////////NO ENLAZADO
 f_sql('cif','LIKE','cif',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
 f_sql('razon_social','LIKE','razon',Parent.dw_1,sql_nuevo,g_tipo_base_datos,'')
else
 if not f_es_vacio(cif_sociedad) then  
    if PosA(sql_nuevo,'WHERE')<=0 then
     sql_nuevo=sql_nuevo + " WHERE regsoc.id_colegiado_sociedad IN ( select id_colegiado from colegiados where  nif like '%" + cif_sociedad + "%') "
    else
      sql_nuevo=sql_nuevo + " AND regsoc.id_colegiado_sociedad IN ( select id_colegiado from colegiados where  nif like '%" + cif_sociedad + "%')"
        end if 
   end if
   if not f_es_vacio(razon) then
    //messagebox('fdsfs',sql_nuevo)
    if PosA(sql_nuevo,'WHERE')<=0 then
     sql_nuevo=sql_nuevo + " WHERE regsoc.id_colegiado_sociedad IN ( select id_colegiado from colegiados where  apellidos like '%" + razon + "%') "
    else
      sql_nuevo=sql_nuevo + " AND regsoc.id_colegiado_sociedad IN ( select id_colegiado from colegiados where  apellidos like '%" + razon + "%')"
        end if 
   end if
end if// RYC 2008
// REALIZAMOS LAS CONSULTAS (FECHAS)
f_sql('fecha_salida_registro','>=','f_desde_com_d_reg',dw_listados,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha_salida_registro','<','f_hasta_com_d_reg',dw_listados,sql_nuevo,g_tipo_base_datos,'')
f_sql('regsoc.fecha_baja','>=','f_desde_com_reg',dw_listados,sql_nuevo,g_tipo_base_datos,'')
f_sql('regsoc.fecha_baja','<','f_hasta_com_reg',dw_listados,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha_llegada_colegio','>=','f_desde_rec_col',dw_listados,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha_llegada_colegio','<','f_hasta_rec_col',dw_listados,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha_junta','>=','f_desde_junta',dw_listados,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha_junta','<','f_hasta_junta',dw_listados,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha_inscripcion','>=','f_desde_ins_reg',dw_listados,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha_inscripcion','<','f_hasta_ins_reg',dw_listados,sql_nuevo,g_tipo_base_datos,'')
 
// Socios
 
if g_modo_funcionamiento<>'1' then    ////////NO ENLAZADO
   if not f_es_vacio(apellidos) then
    //messagebox('fdsfs',sql_nuevo)
    if PosA(sql_nuevo,'WHERE')<=0 then
     sql_nuevo=sql_nuevo + " WHERE regsoc.id_regsoc IN ( select regsoc_socio.id_regsoc from regsoc_socio where regsoc_socio.apellidos like '%" + apellidos + "%')"
    else
      sql_nuevo=sql_nuevo + " AND regsoc.id_regsoc IN ( select regsoc_socio.id_regsoc from regsoc_socio where regsoc_socio.apellidos like '%" + apellidos + "%')"
    end if
   end if
   if not f_es_vacio(nombre) then
    //messagebox('fdsfs',sql_nuevo)
    if PosA(sql_nuevo,'WHERE')<=0 then
     sql_nuevo=sql_nuevo + " WHERE regsoc.id_regsoc IN ( select regsoc_socio.id_regsoc from regsoc_socio where regsoc_socio.nombre like '%" + nombre + "%')"
    else
      sql_nuevo=sql_nuevo + " AND regsoc.id_regsoc IN ( select regsoc_socio.id_regsoc from regsoc_socio where regsoc_socio.nombre like '%" + nombre + "%')"
    end if
   end if
   if not f_es_vacio(cif) then
    //messagebox('fdsfs',sql_nuevo)
    if PosA(sql_nuevo,'WHERE')<=0 then
     sql_nuevo=sql_nuevo + " WHERE regsoc.id_regsoc IN ( select regsoc_socio.id_regsoc from regsoc_socio where regsoc_socio.cif like '" + cif + "%')"
    else
      sql_nuevo=sql_nuevo + " AND regsoc.id_regsoc IN ( select regsoc_socio.id_regsoc from regsoc_socio where regsoc_socio.cif like '" + cif + "%')"
    end if
   end if
   if not f_es_vacio(colegio) then
    //messagebox('fdsfs',sql_nuevo)
    if PosA(sql_nuevo,'WHERE')<=0 then
     sql_nuevo=sql_nuevo + " WHERE regsoc.id_regsoc IN ( select regsoc_socio.id_regsoc from regsoc_socio where regsoc_socio.colegio_procedencia like '%" + colegio + "%')"
    else
      sql_nuevo=sql_nuevo + " AND regsoc.id_regsoc IN ( select regsoc_socio.id_regsoc from regsoc_socio where regsoc_socio.colegio_procedencia like '%" + colegio + "%')"
    end if
   end if
   if not f_es_vacio(n_colegiado) then
    //messagebox('fdsfs',sql_nuevo)
    if PosA(sql_nuevo,'WHERE')<=0 then
     sql_nuevo=sql_nuevo + " WHERE regsoc.id_regsoc IN ( select regsoc_socio.id_regsoc from regsoc_socio where regsoc_socio.num_colegiado like '" + n_colegiado + "%')"
    else
      sql_nuevo=sql_nuevo + " AND regsoc.id_regsoc IN ( select regsoc_socio.id_regsoc from regsoc_socio where regsoc_socio.num_colegiado like '" + n_colegiado + "%')"
    end if
   end if
else                             //////// ENLAZADO
   if not f_es_vacio(apellidos) then
    
    if PosA(sql_nuevo,'WHERE')<=0 then
     sql_nuevo=sql_nuevo + " WHERE regsoc.id_colegiado_sociedad IN ( select regsoc_socio.id_colegiado_sociedad from regsoc_socio where id_colegiado in (select colegiados.id_colegiado from colegiados where apellidos like '%" + apellidos + "%')) or (regsoc.id_colegiado_sociedad in ( select regsoc_socio.id_colegiado_sociedad from regsoc_socio where id_cliente in (select clientes.id_cliente from clientes where apellidos like '%" + apellidos + "%')))"
    else
      sql_nuevo=sql_nuevo + " AND (regsoc.id_colegiado_sociedad IN ( select regsoc_socio.id_colegiado_sociedad from regsoc_socio where id_colegiado in (select colegiados.id_colegiado from colegiados where apellidos like '%" + apellidos + "%'))) or (regsoc.id_colegiado_sociedad in ( select regsoc_socio.id_colegiado_sociedad from regsoc_socio where id_cliente in (select clientes.id_cliente from clientes where apellidos like '%" + apellidos + "%')))"
        end if 
   end if
   if not f_es_vacio(nombre) then
    //messagebox('fdsfs',sql_nuevo)
    if PosA(sql_nuevo,'WHERE')<=0 then
     sql_nuevo=sql_nuevo + " WHERE regsoc.id_colegiado_sociedad IN ( select regsoc_socio.id_colegiado_sociedad from regsoc_socio where regsoc_socio.id_colegiado in (select colegiados.id_colegiado from colegiados where colegiados.nombre like '%" + nombre + "%')) or (regsoc.id_colegiado_sociedad in ( select regsoc_socio.id_colegiado_sociedad from regsoc_socio where regsoc_socio.id_cliente in (select clientes.id_cliente from clientes where nombre like '%" + nombre + "%')))"
    else
      sql_nuevo=sql_nuevo + " AND (regsoc.id_colegiado_sociedad IN ( select regsoc_socio.id_colegiado_sociedad from regsoc_socio where regsoc_socio.id_colegiado in (select colegiados.id_colegiado from colegiados where colegiados.nombre like '%" + nombre + "%'))) or (regsoc.id_colegiado_sociedad in ( select regsoc_socio.id_colegiado_sociedad from regsoc_socio where regsoc_socio.id_cliente in (select clientes.id_cliente from clientes where nombre like '%" + nombre + "%')))"
        end if 
   end if
   if not f_es_vacio(cif) then
    //messagebox('fdsfs',sql_nuevo)
    if PosA(sql_nuevo,'WHERE')<=0 then
     sql_nuevo=sql_nuevo + " WHERE regsoc.id_colegiado_sociedad IN ( select regsoc_socio.id_colegiado_sociedad from regsoc_socio where regsoc_socio.id_colegiado in (select colegiados.id_colegiado from colegiados where nif like '%" + cif + "%')) or (regsoc.id_colegiado_sociedad in ( select regsoc_socio.id_colegiado_sociedad from regsoc_socio where regsoc_socio.id_cliente in (select clientes.id_cliente from clientes where nif like '%" + cif + "%')))"
    else
      sql_nuevo=sql_nuevo + " AND (regsoc.id_colegiado_sociedad IN ( select regsoc_socio.id_colegiado_sociedad from regsoc_socio where regsoc_socio.id_colegiado in (select colegiados.id_colegiado from colegiados where nif like '%" + cif + "%'))) or (regsoc.id_colegiado_sociedad in ( select regsoc_socio.id_colegiado_sociedad from regsoc_socio where regsoc_socio.id_cliente in (select clientes.id_cliente from clientes where nif like '%" + cif + "%')))"
        end if 
   end if
   if not f_es_vacio(colegio) then
    //messagebox('fdsfs',sql_nuevo)
//    if pos(sql_nuevo,'WHERE')<=0 then
//     sql_nuevo=sql_nuevo + " WHERE regsoc.id_regsoc IN ( select id_regsoc from regsoc_socio where colegio_procedencia like '%" + colegio + "%')"
//    else
//      sql_nuevo=sql_nuevo + " AND regsoc.id_regsoc IN ( select id_regsoc from regsoc_socio where colegio_procedencia like '%" + colegio + "%')"
//    end if
   end if
   if not f_es_vacio(n_colegiado) then
    //messagebox('fdsfs',sql_nuevo)
    if PosA(sql_nuevo,'WHERE')<=0 then
     sql_nuevo=sql_nuevo + " WHERE regsoc.id_colegiado_sociedad IN ( select regsoc_socio.id_colegiado_sociedad from regsoc_socio where regsoc_socio.id_colegiado in (select colegiados.id_colegiado from colegiados where colegiados.n_colegiado like '%" + n_colegiado + "%')) or (regsoc.id_colegiado_sociedad in ( select regsoc_socio.id_colegiado_sociedad from regsoc_socio where regsoc_socio.id_cliente in (select clientes.id_cliente from clientes where clientes.n_cliente like '%" + n_colegiado + "%')))"
    else
      sql_nuevo=sql_nuevo + " AND (regsoc.id_colegiado_sociedad IN ( select regsoc_socio.id_colegiado_sociedad from regsoc_socio where regsoc_socio.id_colegiado in (select colegiados.id_colegiado from colegiados where colegiados.n_colegiado like '%" + n_colegiado + "%'))) or (regsoc.id_colegiado_sociedad in ( select regsoc_socio.id_colegiado_sociedad from regsoc_socio where regsoc_socio.id_cliente in (select clientes.id_cliente from clientes where clientes.n_cliente like '%" + n_colegiado + "%')))"
        end if 
   end if 
 
end if
 
 
 
dw_1.SetTransobject(sqlca)
dw_1.Modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")
dw_1.retrieve()
 
// Al final:
if dw_1.rowcount() > 0 then
 dw_1.visible     = true
 dw_1.event pfc_printpreview()
 this.enabled        = false
 cb_zoom.enabled     = true
 cb_imprimir.enabled = true
 cb_guardar.enabled  = true
else
 messagebox(g_titulo,'No se han encontrados registros segun las especificaciones.')
end if

end event

type cb_salir from w_listados`cb_salir within w_regsoc_listados
end type

type dw_listados from w_listados`dw_listados within w_regsoc_listados
integer width = 2624
integer height = 1720
string dataobject = "d_regsoc_consulta"
boolean ib_isupdateable = false
end type

type cb_imprimir from w_listados`cb_imprimir within w_regsoc_listados
end type

type cb_zoom from w_listados`cb_zoom within w_regsoc_listados
end type

type cb_esp from w_listados`cb_esp within w_regsoc_listados
end type

type cb_guardar from w_listados`cb_guardar within w_regsoc_listados
end type

type cb_escala from w_listados`cb_escala within w_regsoc_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_regsoc_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_regsoc_listados
end type

type dw_1 from w_listados`dw_1 within w_regsoc_listados
end type

