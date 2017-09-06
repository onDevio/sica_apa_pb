HA$PBExportHeader$w_avisos_pendientes.srw
forward
global type w_avisos_pendientes from w_popup
end type
type dw_1 from u_dw within w_avisos_pendientes
end type
end forward

global type w_avisos_pendientes from w_popup
integer x = 214
integer y = 221
integer width = 3136
integer height = 1648
string title = "Avisos pendientes"
long backcolor = 32768
dw_1 dw_1
end type
global w_avisos_pendientes w_avisos_pendientes

on w_avisos_pendientes.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_avisos_pendientes.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;call super::open;string pendiente
dw_1.settransobject(sqlca)
pendiente = message.stringparm
//messagebox('kk', pendiente)
dw_1.retrieve(pendiente)

end event

type dw_1 from u_dw within w_avisos_pendientes
integer x = 18
integer y = 12
integer width = 3058
integer height = 1496
integer taborder = 0
string dataobject = "d_avisos_pendientes"
end type

event retrieveend;call super::retrieveend;if rowcount = 0 then 
	messagebox('Atencion','Este expediente no tiene avisos pendientes.')
	close(w_avisos_pendientes)
end if
end event

event doubleclicked;call super::doubleclicked;close(w_avisos_pendientes)
end event

