HA$PBExportHeader$w_master.srw
$PBExportComments$Extension Master Window class
forward
global type w_master from pfc_w_master
end type
end forward

global type w_master from pfc_w_master
end type
global w_master w_master

on w_master.create
call super::create
end on

on w_master.destroy
call super::destroy
end on

event open;call super::open;if g_usar_idioma='S' then g_idioma.of_cambia_textos( this)

end event

