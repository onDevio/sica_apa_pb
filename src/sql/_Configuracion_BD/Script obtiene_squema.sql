select  right('create table dbo.' + so1.name + '(' + '', 255 * ( abs( sign(sc1.colid - 1) - 1 ) ) )+
        sc1.name + ' ' +
        st1.name + ' ' +
        substring( '(' + rtrim( convert( char, sc1.length ) ) + ') ', 1,
        patindex('%char', st1.name ) * 10 ) +
        substring( '(' + rtrim( convert( char, sc1.prec ) ) + ', ' + rtrim(
        convert( char, sc1.scale ) ) + ') ' , 1, patindex('numeric', st1.name ) * 10 ) +
        substring( 'NOT NULL', ( convert( int, convert( bit,( sc1.status & 8 ) ) ) * 4 ) + 1,
        8 * abs(convert(bit, (sc1.status & 0x80)) - 1 ) ) +
        right('identity ', 9 * convert(bit, (sc1.status & 0x80)) ) +
        right(',', 5 * ( convert(int,sc2.colid) - convert(int,sc1.colid) ) ) +
        right(' )' +  '' + '', 255 * abs( sign( ( convert(int,sc2.colid) - convert(int,sc1.colid) ) ) -
1 ) )
from    sysobjects so1,
        syscolumns sc1,
        syscolumns sc2,
        systypes st1
where so1.type = 'U'
and sc1.id = so1.id
and st1.usertype = sc1.usertype
and sc2.id = sc1.id
and sc2.colid = (select max(colid)
                from syscolumns
                where id = sc1.id)
order by so1.name, sc1.colid
