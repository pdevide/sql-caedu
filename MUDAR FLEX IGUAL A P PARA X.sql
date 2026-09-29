select * from dbo.CAE_PRODUTOS_FATOR_P where UNOUS_NIVEL is null


select * 
from  PRODUTOS p
left join dbo.CAE_PRODUTOS_FATOR_P a on p.GRIFFE=a.GRIFFE
				and p.LINHA=a.LINHA
				and p.GRUPO_PRODUTO=a.GRUPO_PRODUTO
				and p.SUBGRUPO_PRODUTO=a.SUBGRUPO_PRODUTO
where p.PRODUTO= '01040622'


select * 
from prop_produtos pp
inner join PRODUTOS p on p.PRODUTO = pp.PRODUTO
inner join dbo.UNOUS_CAE_PRODUTOS_FATOR_P a on p.GRIFFE=a.GRIFFE
				and p.LINHA=a.LINHA
				and p.GRUPO_PRODUTO=a.GRUPO_PRODUTO
				and p.SUBGRUPO_PRODUTO=a.SUBGRUPO_PRODUTO
where PROPRIEDADE = '00105' and a.UNOUS_NIVEL = 'FLEX'


select * from PROP_PRODUTOS where PRODUTO = '01040622' and propriedade > '00100'
--01040622 - JAQUETA MASC CONT INV2429 PARKA ZIPER