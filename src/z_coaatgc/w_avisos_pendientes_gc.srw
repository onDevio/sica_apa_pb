HA$PBExportHeader$w_avisos_pendientes_gc.srw
forward
global type w_avisos_pendientes_gc from w_popup
end type
type sle_1 from singlelineedit within w_avisos_pendientes_gc
end type
type st_1 from statictext within w_avisos_pendientes_gc
end type
type dw_2 from u_dw within w_avisos_pendientes_gc
end type
type dw_1 from u_dw within w_avisos_pendientes_gc
end type
end forward

global type w_avisos_pendientes_gc from w_popup
integer width = 3136
integer height = 1648
string title = "Avisos pendientes"
long backcolor = 32768
event csd_aviso_regularizacion ( )
sle_1 sle_1
st_1 st_1
dw_2 dw_2
dw_1 dw_1
end type
global w_avisos_pendientes_gc w_avisos_pendientes_gc

event csd_aviso_regularizacion();// Evento que muestra un aviso cuando la musaat calculada es diferente de la que
// aparece en el aviso
st_musaat_datos datos_musaat
boolean regulariza_musaat=FALSE
string id_col, id_minuta, id_fase, mensaje=''
double retorno, musaat, musaat_cobrado, base
int i

// Miramos en todos los avisos
for i=1 to dw_1.rowcount()
	musaat_cobrado = f_redondea(dw_1.getitemnumber(i, 'base_musaat'))
	if not musaat_cobrado > 0 then continue

	// No consideramos las modificaciones o anulaciones
	if LeftA(dw_1.getitemstring(i, 'tipo_minuta'),1) <> '1' then continue

	id_col = dw_1.getitemstring(i, 'fases_minutas_id_colegiado')
	id_minuta = dw_1.getitemstring(i, 'fases_minutas_id_minuta')
	id_fase = dw_1.getitemstring(i, 'fases_minutas_id_fase')
	
	datos_musaat.recuperar = TRUE
	datos_musaat.id_minuta = id_minuta 
	datos_musaat.importe_sobre_honos = dw_1.getitemnumber(i, 'base_musaat')
	datos_musaat.porc_sobre_honos = dw_1.getitemnumber(i, 'porc_honos')
	datos_musaat.regulariza = TRUE
	datos_musaat.f_pago = datetime(today())
	datos_musaat.n_visado = id_fase
	datos_musaat.id_col = id_col
	if f_colegiado_tipopersona(id_col) = 'S' then datos_musaat.id_sociedad = id_col
	datos_musaat.cobertura = 0
	
	if f_colegiado_tipopersona(id_col) = 'S' then
		retorno = f_musaat_calcula_prima_sociedad(datos_musaat)			
	else
		retorno = f_musaat_calcula_prima(datos_musaat)
	end if		
	musaat = datos_musaat.prima_comp		
	musaat = f_redondea(musaat)
	
	base = f_redondea(musaat - musaat_cobrado)
	
	//if base <> 0 then
	//Cambio Luis CGC-117
	if base > 0.01 or base < -0.01 then
		mensaje += 'El importe de Musaat puede haber variado en el aviso n$$HEX2$$ba002000$$ENDHEX$$'+dw_1.getitemstring(i, 'fases_minutas_n_aviso') + cr
	end if
next

if mensaje<>'' then
	messagebox(g_titulo, mensaje)
end if

end event

on w_avisos_pendientes_gc.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_1
end on

on w_avisos_pendientes_gc.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;call super::open;string pendiente
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
pendiente = message.stringparm
//messagebox('kk', pendiente)
dw_1.retrieve(pendiente)
dw_2.retrieve(pendiente)

if dw_1.rowcount() = 0  and dw_2.rowcount() = 0 then
	messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n", "Este expediente no tiene gastos pendientes")
	close(this)
	return
end if

double tot_av=0, tot_doc=0, total=0

if dw_1.rowcount() > 0 then tot_av = dw_1.getitemnumber(1,'total')
if dw_2.rowcount() > 0 then tot_doc = dw_2.getitemnumber(1,'total_final')

total = tot_av + tot_doc

sle_1.text = string(total)

post event csd_aviso_regularizacion()
end event

type sle_1 from singlelineedit within w_avisos_pendientes_gc
integer x = 2473
integer y = 1376
integer width = 603
integer height = 112
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 255
long backcolor = 12632256
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_avisos_pendientes_gc
integer x = 2171
integer y = 1400
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Total:"
boolean focusrectangle = false
end type

type dw_2 from u_dw within w_avisos_pendientes_gc
integer x = 18
integer y = 820
integer width = 3058
integer height = 496
integer taborder = 0
string dataobject = "d_documentos_pendientes_gc"
end type

event doubleclicked;call super::doubleclicked;close(w_avisos_pendientes_gc)
end event

event retrieveend;call super::retrieveend;//if rowcount = 0 then 
//	messagebox('Atencion','Este expediente no tiene documentos pendientes.')
//	close(w_avisos_pendientes_gc)
//end if
end event

type dw_1 from u_dw within w_avisos_pendientes_gc
integer x = 18
integer y = 12
integer width = 3058
integer height = 792
integer taborder = 0
string dataobject = "d_avisos_pendientes_gc"
end type

event retrieveend;call super::retrieveend;//if rowcount = 0 then 
//	messagebox('Atencion','Este expediente no tiene avisos pendientes.')
//	close(w_avisos_pendientes_gc)
//end if
end event

event doubleclicked;call super::doubleclicked;close(w_avisos_pendientes_gc)
end event

