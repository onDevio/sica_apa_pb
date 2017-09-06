HA$PBExportHeader$w_reclamaciones_facturas_lista.srw
forward
global type w_reclamaciones_facturas_lista from w_lista
end type
end forward

global type w_reclamaciones_facturas_lista from w_lista
end type
global w_reclamaciones_facturas_lista w_reclamaciones_facturas_lista

on w_reclamaciones_facturas_lista.create
call super::create
end on

on w_reclamaciones_facturas_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_1 from w_lista`st_1 within w_reclamaciones_facturas_lista
end type

type dw_lista from w_lista`dw_lista within w_reclamaciones_facturas_lista
string dataobject = "d_reclamaciones_facturas_lista"
end type

type cb_consulta from w_lista`cb_consulta within w_reclamaciones_facturas_lista
end type

type cb_detalle from w_lista`cb_detalle within w_reclamaciones_facturas_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_reclamaciones_facturas_lista
end type

