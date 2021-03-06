// SCP-2497 
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO' 
if @colegio = 'COAATAVI' OR @colegio ='COAATGU' OR @colegio = 'COAATLE' OR @colegio = 'COAATA' OR @colegio = 'COAATNA' OR @colegio ='COAATTGN' OR @colegio = 'COAATTEB' OR @colegio = 'COAATMCA' OR @colegio = 'COAATCC' OR @colegio = 'COAATLL'
   begin 
       insert into var_globales (nombre, sn, descripcion, modificable) values ('g_utiliza_f_abono_fichero_eco', 'S','Indica que si se enviará la fecha de abono, en caso afirmativo, o la fecha de visado para los movimientos de musaat', 'N')
   end 
else 
   begin
       insert into var_globales (nombre, sn, descripcion, modificable) values ('g_utiliza_f_abono_fichero_eco', 'N','Indica que si se enviará la fecha de abono, en caso afirmativo, o la fecha de visado para los movimientos de musaat', 'N')
   end 
// SCP-2351 
if @colegio = 'COAATLR' 
   begin 
       insert into var_globales (nombre, texto, descripcion, modificable) values ('g_musaat_movi_fecha_sistema_o_factura', 'F','Indica el valor de la fecha a asignar al movimiento creado al facturar MUSAAT, Fecha Sistema->S ó Factura->F', 'N')
   end 
else 
   begin
       insert into var_globales (nombre, texto, descripcion, modificable) values ('g_musaat_movi_fecha_sistema_o_factura', 'S','Indica el valor de la fecha a asignar al movimiento creado al facturar MUSAAT, Fecha Sistema->S ó Factura->F', 'N')
   end 
;