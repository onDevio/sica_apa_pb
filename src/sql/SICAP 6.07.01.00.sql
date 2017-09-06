alter table premaat add alta_reta char(1) DEFAULT 'N' null;
alter table premaat add fecha_alta_reta datetime null;
alter table premaat add fecha_baja_reta datetime null;
update premaat set alta_reta = 'N';

