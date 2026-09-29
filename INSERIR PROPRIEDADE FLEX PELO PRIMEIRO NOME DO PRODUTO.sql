
declare @Tab table (id int identity(1,1), produto varchar(12))
insert into @Tab (produto) values ('87020003')
insert into @Tab (produto) values ('87020004')
insert into @Tab (produto) values ('87020005')
insert into @Tab (produto) values ('87020006')
insert into @Tab (produto) values ('87020007')
insert into @Tab (produto) values ('87020008')
insert into @Tab (produto) values ('87020009')
insert into @Tab (produto) values ('87020011')
insert into @Tab (produto) values ('89010007')
insert into @Tab (produto) values ('89010008')
insert into @Tab (produto) values ('89010009')
insert into @Tab (produto) values ('89020012')
insert into @Tab (produto) values ('93010002')
insert into @Tab (produto) values ('93010003')
insert into @Tab (produto) values ('93010004')
insert into @Tab (produto) values ('93010005')
insert into @Tab (produto) values ('93010006')
insert into @Tab (produto) values ('93010007')
insert into @Tab (produto) values ('93010008')
insert into @Tab (produto) values ('93010009')
insert into @Tab (produto) values ('93010010')
insert into @Tab (produto) values ('93010011')
insert into @Tab (produto) values ('93010012')
insert into @Tab (produto) values ('93010013')
insert into @Tab (produto) values ('93010014')
insert into @Tab (produto) values ('93010015')
insert into @Tab (produto) values ('93010016')
insert into @Tab (produto) values ('93010017')
insert into @Tab (produto) values ('93010018')
insert into @Tab (produto) values ('93010019')
insert into @Tab (produto) values ('93010020')
insert into @Tab (produto) values ('93020003')
insert into @Tab (produto) values ('93020004')
insert into @Tab (produto) values ('93020005')
insert into @Tab (produto) values ('93020006')
insert into @Tab (produto) values ('93020007')
insert into @Tab (produto) values ('93020008')
insert into @Tab (produto) values ('93020009')
insert into @Tab (produto) values ('93020010')
insert into @Tab (produto) values ('93020011')
insert into @Tab (produto) values ('93020012')
insert into @Tab (produto) values ('93020013')
insert into @Tab (produto) values ('93020014')
insert into @Tab (produto) values ('93020015')
insert into @Tab (produto) values ('93020016')
insert into @Tab (produto) values ('93020017')
insert into @Tab (produto) values ('93020018')
insert into @Tab (produto) values ('93020019')
insert into @Tab (produto) values ('93020020')
insert into @Tab (produto) values ('93020021')
insert into @Tab (produto) values ('93020022')
insert into @Tab (produto) values ('93020023')
insert into @Tab (produto) values ('93020024')
insert into @Tab (produto) values ('93020025')
insert into @Tab (produto) values ('93020026')
insert into @Tab (produto) values ('93020027')
insert into @Tab (produto) values ('93020028')
insert into @Tab (produto) values ('93020029')
insert into @Tab (produto) values ('93020030')
insert into @Tab (produto) values ('93020031')
insert into @Tab (produto) values ('93020032')
insert into @Tab (produto) values ('93020033')
insert into @Tab (produto) values ('93020034')
insert into @Tab (produto) values ('93020035')

--INSERT INTO PROP_PRODUTOS
/*SELECT '00105' AS PROPRIEDADE, A.PRODUTO,1 AS ITEM_PROPRIEDADE,
DBO.TRIM(SUBSTRING(p.DESC_PRODUTO,1,CHARINDEX(' ',P.DESC_PRODUTO,1))) AS VALOR_PROPRIEDADE,
GETDATE() AS DATA_PARA_TRANSFERENCIA */
SELECT pp.*
from @Tab a
inner join PRODUTOS p on p.PRODUTO=a.produto
/*inner join CAE_PRODUTOS_FATOR_P c 
	on c.GRIFFE=p.GRIFFE and c.LINHA=p.LINHA 
	and c.GRUPO_PRODUTO=p.GRUPO_PRODUTO
	and c.SUBGRUPO_PRODUTO=p.SUBGRUPO_PRODUTO*/
left join PROP_PRODUTOS pp on pp.PRODUTO=a.produto and pp.PROPRIEDADE='00105'
order by a.produto

