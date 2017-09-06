select  'drop table dbo.' + so1.name  
from  sysobjects so1
where so1.type = 'U'
order by so1.name
go