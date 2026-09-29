select R.* 
--UPDATE R SET GERADO=1
from vendas v
inner join vendas_produto vp on vp.PEDIDO=v.PEDIDO
inner join (
select 'CX-'+rtrim(caixa) as VENDA, GERADO
from caedu_reserva_automatica 
where pedido = '276523E'
) r on r.venda = v.pedido