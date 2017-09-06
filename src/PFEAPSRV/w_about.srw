HA$PBExportHeader$w_about.srw
$PBExportComments$Extension About window
forward
global type w_about from pfc_w_about
end type
end forward

global type w_about from pfc_w_about
integer height = 736
end type
global w_about w_about

on w_about.create
call super::create
end on

on w_about.destroy
call super::destroy
end on

type p_about from pfc_w_about`p_about within w_about
integer x = 18
integer y = 16
integer width = 457
integer height = 480
boolean originalsize = false
end type

type st_application from pfc_w_about`st_application within w_about
integer x = 530
integer width = 1088
integer height = 184
end type

type st_version from pfc_w_about`st_version within w_about
integer x = 530
integer y = 268
integer width = 1088
end type

type cb_ok from pfc_w_about`cb_ok within w_about
integer y = 540
end type

type st_copyright from pfc_w_about`st_copyright within w_about
integer x = 530
integer y = 348
integer width = 1088
integer height = 156
end type

