declare @tab1 table (desc_colecao varchar(25))

insert into @tab1 values ('OUT/INV 23')
insert into @tab1 values ('PRI/VER  23/24')
insert into @tab1 values ('OUT/INV 24')
insert into @tab1 values ('PRI/VER  24/25')
insert into @tab1 values ('OUT/INV 25')
insert into @tab1 values ('PRI/VER  25/26')
insert into @tab1 values ('OUT/INV 26')
insert into @tab1 values ('PRI/VER  26/27')
insert into @tab1 values ('OUT/INV 27')
insert into @tab1 values ('PRI/VER  27/28')
insert into @tab1 values ('OUT/INV 28')
insert into @tab1 values ('PRI/VER  28/29')
insert into @tab1 values ('OUT/INV 29')
insert into @tab1 values ('PRI/VER  29/30')
insert into @tab1 values ('OUT/INV 30')
insert into @tab1 values ('PRI/VER  30/31')

--insert into COLECOES (COLECAO, DESC_COLECAO, INATIVO, DATA_PARA_TRANSFERENCIA) 
select 'PV'+REPLACE(RIGHT(DESC_COLECAO,5),'/','') AS COLECAO,desc_colecao,
0 AS INATIVO,GETDATE() AS DATA_PARA_TRANSFERENCIA 
from @tab1 a
where a.desc_colecao  in 
(select DESC_COLECAO from COLECOES)


