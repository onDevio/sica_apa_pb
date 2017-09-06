--SCP-2277 sql vincular compañía a fases_colegiados
ALTER TABLE fases_colegiados add tiene_src char(1) DEFAULT 'N' null, src_cia varchar(2) null
GO
-- Para todos: se asigna NO tiene SRC por defecto
UPDATE fases_colegiados SET FC.tiene_src = 'N', FC.src_cia =''
GO
-- De los datos actuales: se asigna SRC y a la compañía MUSAAT si tiene un MUSAAT dicho colegiado asignado al contrato
UPDATE fases_colegiados 
	SET FC.tiene_src = 'S', FC.src_cia = 'MU'
		FROM fases_colegiados FC, musaat_movimientos MM 
			WHERE 	FC.id_fase = MM.id_fase AND
					MM.id_col = FC.id_col AND 
					FC.tiene_src = 'N'
GO

--SCP-2277 sql tabla colegios codigo zurich
ALTER TABLE colegios ADD cod_zurich varchar(2) null
GO
UPDATE colegios SET cod_zurich = 'AA' WHERE cod_colegio = '01' -- ALAVA
UPDATE colegios SET cod_zurich = 'AB' WHERE cod_colegio = '02' -- ALBACETE
UPDATE colegios SET cod_zurich = 'A'  WHERE cod_colegio = '03' -- ALICANTE
UPDATE colegios SET cod_zurich = 'AL' WHERE cod_colegio = '04' -- ALMERIA
UPDATE colegios SET cod_zurich = 'AS' WHERE cod_colegio = '05' -- ASTURIAS
UPDATE colegios SET cod_zurich = 'AV' WHERE cod_colegio = '06' -- AVILA
UPDATE colegios SET cod_zurich = 'BA' WHERE cod_colegio = '07' -- BADAJOZ
UPDATE colegios SET cod_zurich = 'B'  WHERE cod_colegio = '08' -- BARCELONA
UPDATE colegios SET cod_zurich = 'BU' WHERE cod_colegio = '09' -- BURGOS
UPDATE colegios SET cod_zurich = 'CC' WHERE cod_colegio = '10' -- CACERES
UPDATE colegios SET cod_zurich = 'CA' WHERE cod_colegio = '11' -- CADIZ
UPDATE colegios SET cod_zurich = 'CN' WHERE cod_colegio = '12' -- CANTABRIA
UPDATE colegios SET cod_zurich = 'CS' WHERE cod_colegio = '13' -- CASTELLON
UPDATE colegios SET cod_zurich = 'CR' WHERE cod_colegio = '14' -- CIUDAD REAL
UPDATE colegios SET cod_zurich = 'CO' WHERE cod_colegio = '15' -- CORDOBA
UPDATE colegios SET cod_zurich = 'CU' WHERE cod_colegio = '16' -- CUENCA
UPDATE colegios SET cod_zurich = 'G'  WHERE cod_colegio = '17' -- GIRONA
UPDATE colegios SET cod_zurich = 'GR' WHERE cod_colegio = '18' -- GRANADA
UPDATE colegios SET cod_zurich = 'GU' WHERE cod_colegio = '19' -- GUADALAJARA
UPDATE colegios SET cod_zurich = 'SS' WHERE cod_colegio = '20' -- GUIPUZCOA
UPDATE colegios SET cod_zurich = 'H'  WHERE cod_colegio = '21' -- HUELVA
UPDATE colegios SET cod_zurich = 'HU' WHERE cod_colegio = '22' -- HUESCA
UPDATE colegios SET cod_zurich = 'IB' WHERE cod_colegio = '23' -- IBIZA
UPDATE colegios SET cod_zurich = 'J'  WHERE cod_colegio = '24' -- JAEN
UPDATE colegios SET cod_zurich = 'C'  WHERE cod_colegio = '25' -- A CORUÑA
UPDATE colegios SET cod_zurich = 'LO' WHERE cod_colegio = '26' -- LA RIOJA
UPDATE colegios SET cod_zurich = 'GC' WHERE cod_colegio = '27' -- GRAN CANARIA
UPDATE colegios SET cod_zurich = 'LE' WHERE cod_colegio = '28' -- LEON
UPDATE colegios SET cod_zurich = 'L'  WHERE cod_colegio = '29' -- LLEIDA
UPDATE colegios SET cod_zurich = 'LU' WHERE cod_colegio = '30' -- LUGO
UPDATE colegios SET cod_zurich = 'M'  WHERE cod_colegio = '31' -- MADRID
UPDATE colegios SET cod_zurich = 'MA' WHERE cod_colegio = '32' -- MALAGA
UPDATE colegios SET cod_zurich = 'ML' WHERE cod_colegio = '33' -- MALLORCA
UPDATE colegios SET cod_zurich = 'MN' WHERE cod_colegio = '34' -- MENORCA
UPDATE colegios SET cod_zurich = 'MU' WHERE cod_colegio = '35' -- MURCIA
UPDATE colegios SET cod_zurich = 'N'  WHERE cod_colegio = '36' -- NAVARRA
UPDATE colegios SET cod_zurich = 'O'  WHERE cod_colegio = '37' -- OURENSE
UPDATE colegios SET cod_zurich = 'P'  WHERE cod_colegio = '38' -- PALENCIA
UPDATE colegios SET cod_zurich = 'PO' WHERE cod_colegio = '39' -- PONTEVEDRA
UPDATE colegios SET cod_zurich = 'SA' WHERE cod_colegio = '40' -- SALAMANCA
UPDATE colegios SET cod_zurich = 'SG' WHERE cod_colegio = '41' -- SEGOVIA
UPDATE colegios SET cod_zurich = 'SE' WHERE cod_colegio = '42' -- SEVILLA
UPDATE colegios SET cod_zurich = 'SO' WHERE cod_colegio = '43' -- SORIA
UPDATE colegios SET cod_zurich = 'T'  WHERE cod_colegio = '44' -- TARRAGONA
UPDATE colegios SET cod_zurich = 'TF' WHERE cod_colegio = '45' -- TENERIFE
UPDATE colegios SET cod_zurich = 'TR' WHERE cod_colegio = '46' -- TERUEL
UPDATE colegios SET cod_zurich = 'TO' WHERE cod_colegio = '47' -- TOLEDO
UPDATE colegios SET cod_zurich = 'V'  WHERE cod_colegio = '48' -- VALENCIA
UPDATE colegios SET cod_zurich = 'VA' WHERE cod_colegio = '49' -- VALLADOLID
UPDATE colegios SET cod_zurich = 'VI' WHERE cod_colegio = '50' -- VIZCAYA
UPDATE colegios SET cod_zurich = 'ZA' WHERE cod_colegio = '51' -- ZAMORA
UPDATE colegios SET cod_zurich = 'Z'  WHERE cod_colegio = '52' -- ZARAGOZA
UPDATE colegios SET cod_zurich = 'TE' WHERE cod_colegio = '55' -- TERRES
UPDATE colegios SET cod_zurich = 'LA' WHERE cod_colegio = '56' -- LANZAROTE
UPDATE colegios SET cod_zurich = 'NC' WHERE cod_colegio = '62' -- NUEVA COLEGIACION
UPDATE colegios SET cod_zurich = 'FU' WHERE cod_colegio = '96' -- FUERTEVENTURA
GO