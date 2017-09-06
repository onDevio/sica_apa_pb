declare @colegio varchar(10)
declare @contador int
declare @contador_consultas varchar(10)
declare @contador_consultas_datos int 
declare @id_consulta varchar(10)
declare @max_datos int
select @colegio = texto from var_globales where nombre = 'COLEGIO'
//
// SCP-2210
if @colegio = 'COAATZ' 
   begin 
      insert into var_globales (nombre, sn, descripcion, modificable) values ("g_visualizar_facturas_sin_firma_en_web", "N", "Variable que permite indicar si las facturas no firmadas se pueden visualizar desde la web", "S")
   end 
else
   begin 
      insert into var_globales (nombre, sn, descripcion, modificable) values ("g_visualizar_facturas_sin_firma_en_web", "S", "Variable que permite indicar si las facturas no firmadas se pueden visualizar desde la web", "S")
   end
//
// SCP-2321
if @colegio = 'COAATZ' or @colegio = 'COAATCC' or @colegio = 'COAATAVI' or @colegio = 'COAATNA'
   begin 
      insert into var_globales (nombre, sn, descripcion, modificable) values ("g_enviar_email_facturacion_clientes", "S", "Variable que determina si se enviarán por email las  facturas a clientes en el proceso de emisión facturas", "S")
   end
else
   begin
      insert into var_globales (nombre, sn, descripcion, modificable) values ("g_enviar_email_facturacion_clientes", "N", "Variable que determina si se enviarán por email las  facturas a clientes en el proceso de emisión facturas", "S")
   end 
//
// SCP-2327
select @contador_consultas = replicate ('0', 10 - char_length(convert(varchar, convert(int,valor) + 1)) ) + convert(varchar, convert(int,valor) + 1) from contadores where contador = 'CONSULTAS'
select @contador_consultas_datos = valor + 1 from contadores where contador = 'CONSULTAS_DATOS'
select @id_consulta = id_consulta from consultas where ventana = 'w_sellador' and descripcion = 'INICIO'
insert into consultas (id_consulta, ventana, descripcion, fecha, usuario) select @contador_consultas as id, 'w_impresion_datos_sellado' , descripcion, GETDATE(), usuario from consultas where id_consulta = @id_consulta
update contadores set valor = convert(int, @contador_consultas) where contador = 'CONSULTAS'
insert into consultas_datos_aux (datawindow, columna, valor_double, valor_string, valor_datetime, fila, id_consulta) select datawindow, columna, valor_double, valor_string, valor_datetime, fila, id_consulta from consultas_datos where id_consulta = @id_consulta
insert into consultas_datos (id_consulta_datos, datawindow, columna, valor_double, valor_string, valor_datetime, fila, id_consulta) select  replicate ('0', 10 - char_length(convert(varchar, @contador_consultas_datos + id_consulta_datos)) ) + convert(varchar, @contador_consultas_datos + id_consulta_datos) as id, datawindow, columna, valor_double, valor_string, valor_datetime, fila, @contador_consultas from consultas_datos_aux
select @max_datos = max(id_consulta_datos) from consultas_datos_aux
update contadores set valor = @max_datos + @contador_consultas_datos where contador = 'CONSULTAS_DATOS'
//
// SCP-2359
if ((@colegio = 'COAATCC') or (@colegio = 'COAATZ'))
	begin
		INSERT INTO var_globales (nombre, numero, descripcion, modificable) VALUES ('numero_impresos_listados_domiciliaciones', 1,'Número impresiones listados de domiciliaciones', 'S')
	end
if (@colegio <> 'COAATCC') and (@colegio <> 'COAATZ')
	begin
		INSERT INTO var_globales (nombre, numero, descripcion, modificable) VALUES ('numero_impresos_listados_domiciliaciones', 2,'Número impresiones listados de domiciliaciones', 'S')
	end
;