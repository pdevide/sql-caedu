select	b.DATA_LOG,
		b.TIPO_OP,
		a.PEDIDO, 
		a.STATUS_PEDIDO, 
		st.DESC_STATUS, 
		b.APROVADO, 
		b.COD_METRICA, 
		CM.DESC_METRICA,
		b.VALOR_ANTES,
		b.VALOR_ANTES,
		b.PRODUTO, 
		p.DESC_PRODUTO, 
		b.COR_PRODUTO, 
		pc.DESC_COR_PRODUTO,
		b.USUARIO_PEDIDO,
		b.USUARIO_APROVADOR,
		b.OBS
from CAEDU_LOG_AUTORIZA_COMPRAS a (nolock) 
inner join CAEDU_LOG_AUTORIZA_COMPRAS_ITEM b (nolock)  
			on b.pedido = a.pedido and b.PRODUTO = a.PRODUTO 
inner join CAEDU_LOG_AUTORIZA_COMPRAS_STATUS st  (nolock) on st.COD_STATUS = a.STATUS_PEDIDO
inner join PRODUTO_CORES pc  (nolock)  on pc.produto = b.produto and pc.COR_PRODUTO = b.COR_PRODUTO
inner join PRODUTOS p (nolock) on p.produto = b.PRODUTO
inner join CAEDU_METRICAS_LOG_COMPRAS CM (nolock) on CM.COD_METRICA = b.COD_METRICA
WHERE b.DATA_LOG between '20181001' and '20181018' AND A.PEDIDO = '205015'
ORDER BY b.DATA_LOG DESC





