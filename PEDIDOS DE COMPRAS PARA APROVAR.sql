--select * from CAEDU_METRICAS_LOG_COMPRAS

--select * from CAEDU_LOG_AUTORIZA_COMPRAS
--select * from CAEDU_LOG_AUTORIZA_COMPRAS_ITEM
--select * from CAEDU_LOG_AUTORIZA_COMPRAS_STATUS
--select * from CAEDU_METRICAS_LOG_COMPRAS


select	a.PEDIDO, 
		p.GRIFFE, 
		p.LINHA, 
		p.GRUPO_PRODUTO, 
		p.SUBGRUPO_PRODUTO,
		a.PRODUTO, 
		p.desc_produto, 
		a.COR_PRODUTO, 
		pc.DESC_COR_PRODUTO,
		a.COD_METRICA, 
		b.DESC_METRICA, 
		a.DATA_LOG, 
		a.TIPO_OP, 
		a.VALOR_ANTES, 
		a.VALOR_DEPOIS, 
		a.USUARIO_PEDIDO, 
		a.OBS,
		c.FORNECEDOR, 
		k.ENTREGA,
		k.LIMITE_ENTREGA
		
from CAEDU_LOG_AUTORIZA_COMPRAS_ITEM a
inner join CAEDU_METRICAS_LOG_COMPRAS b on b.COD_METRICA = a.COD_METRICA
inner join PRODUTOS p on p.PRODUTO = a.PRODUTO
left join PRODUTO_CORES pc on pc.produto = a.PRODUTO and pc.COR_PRODUTO = a.COR_PRODUTO
inner join COMPRAS c on c.PEDIDO = a.PEDIDO 
left join (select distinct pedido, entrega, limite_entrega, produto, COR_PRODUTO from compras_produto) as k
	on k.PEDIDO = a.PEDIDO and k.PRODUTO = a.PRODUTO and k.COR_PRODUTO = a.COR_PRODUTO
where APROVADO=0
order by data_log desc
