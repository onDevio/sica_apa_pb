//SCP-2406
INSERT INTO musaat_tipologia VALUES ('30','3','0','Final de Obra');
Alter table musaat_movimientos add fecha_cfo datetime null;

//SCP-2383
delete from musaat_tarifas where tarifa = 'F';

