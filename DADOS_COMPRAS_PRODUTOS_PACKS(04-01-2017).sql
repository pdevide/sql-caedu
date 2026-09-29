select cp.pedido,cp.produto produto1, cp.cor_produto cor_produto1, ppp.*
from compras_produto cp
inner join (
			select produto, cor_produto, PACK, qtde from PRODUTOS_PACKS_PERMITIDOS 
			where DATA_PARA_TRANSFERENCIA >= '20170104' and DATA_PARA_TRANSFERENCIA < '20170105'
			) ppp on ppp.PRODUTO = cp.PRODUTO AND ppp.COR_PRODUTO = cp.COR_PRODUTO



