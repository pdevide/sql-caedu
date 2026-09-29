

select * 
from PRODUTOS_TAMANHOS pt
where grade = (select grade from produtos where produto = 'C1150082')


select pp.* 
--update p set ERP_QTD_PACK=24
--update pp set qtde=24, q7=6, q8=6, q9=6, q10=6
from produtos p 
inner join PRODUTOS_PACKS_PERMITIDOS pp 
	on pp.PRODUTO = p.PRODUTO
where p.produto = 'C1150082'

select a.* 
from compras c
inner join CAEDU_COMPRAS_PRODUTOS_PACKS a
--inner join CAEDU_COMPRAS_PRODUTOS_PACKS_TOTAL a
	on a.pedido = c.pedido
where c.pedido = '244920'

