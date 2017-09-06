HA$PBExportHeader$w_eimporta_extrayendo.srw
forward
global type w_eimporta_extrayendo from w_eimporta_procesando
end type
end forward

global type w_eimporta_extrayendo from w_eimporta_procesando
string title = "Extrayendo..."
end type
global w_eimporta_extrayendo w_eimporta_extrayendo

on w_eimporta_extrayendo.create
call super::create
end on

on w_eimporta_extrayendo.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_eimporta_procesando`cb_recuperar_pantalla within w_eimporta_extrayendo
end type

type cb_guardar_pantalla from w_eimporta_procesando`cb_guardar_pantalla within w_eimporta_extrayendo
end type

type st_1 from w_eimporta_procesando`st_1 within w_eimporta_extrayendo
end type

type cb_1 from w_eimporta_procesando`cb_1 within w_eimporta_extrayendo
end type

