select log.*,pedido.CAEDU_DATA_ENTREGA_ORIGINAL 
from [CAEDU].[dbo].[CAEDU_COMPRAS_ENTREGA_LOG] log 
inner join [CAEDU].[dbo].[COMPRAS] pedido 
on log.PEDIDO = pedido.PEDIDO 
where 1=1 
and log.DATA_ENTREGA between '@DATA1' and '@DATA2' 
order by log.pedido,log.DATA_ENTREGA desc;

select top 10 * from [CAEDU].[dbo].[COMPRAS_PRODUTO_ENTREGA];

select top 10 pedido.CAEDU_DATA_ENTREGA_ORIGINAL, pedido.* 
from [CAEDU].[dbo].[COMPRAS] pedido 
where pedido.CAEDU_DATA_ENTREGA_ORIGINAL is not null 
and pedido.CADASTRAMENTO between '2014-01-01' and '2022-02-28'
order by pedido.CAEDU_DATA_ENTREGA_ORIGINAL desc;