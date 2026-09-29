select venda,* 
--update a set gerado=1
from caedu_reserva_automatica a where pedido = '277533'


select pp.* 
from produtos p
inner join PRODUTOS_PACKS_PERMITIDOS pp on pp.PRODUTO = p.PRODUTO
where p.produto = 'Z8030018'    



select ve.* 
from vendas a 
inner join vendas_produto b on b.PEDIDO = a.pedido
inner join VENDAS_PROD_EMBALADO ve on 'CX-'+ve.CAIXA = b.PEDIDO
where a.pedido in (select venda from caedu_reserva_automatica where pedido = '276523E' )

