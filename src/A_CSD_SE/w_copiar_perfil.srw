HA$PBExportHeader$w_copiar_perfil.srw
forward
global type w_copiar_perfil from w_consulta
end type
end forward

global type w_copiar_perfil from w_consulta
int Height=748
end type
global w_copiar_perfil w_copiar_perfil

on w_copiar_perfil.create
call super::create
end on

on w_copiar_perfil.destroy
call super::destroy
end on

type st_5 from w_consulta`st_5 within w_copiar_perfil
boolean BringToTop=true
string Text="Selecione el usuario al cual quiere copiar el perfil."
end type

type cb_1 from w_consulta`cb_1 within w_copiar_perfil
int X=256
int Y=488
boolean BringToTop=true
end type

event cb_1::clicked;call super::clicked;
closewithreturn(parent,dw_1.getitemstring(1,1))
end event

type cb_2 from w_consulta`cb_2 within w_copiar_perfil
int X=878
int Y=488
boolean BringToTop=true
end type

type cb_ayuda from w_consulta`cb_ayuda within w_copiar_perfil
int X=1326
int Y=368
boolean Visible=false
boolean BringToTop=true
end type

type dw_1 from w_consulta`dw_1 within w_copiar_perfil
int Y=152
int Height=172
string DataObject="d_aux_usuario"
end type

