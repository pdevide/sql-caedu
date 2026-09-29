select cp.PEDIDO, cp.PRODUTO, cast(cp.ENTREGA as date) ENTREGA, 
CAST(cp.LIMITE_ENTREGA AS date) AS LIMITE_ENTREGA, h.*
from COMPRAS c
inner join COMPRAS_PRODUTO cp 
	on cp.pedido = c.pedido
inner join produtos p on p.produto = cp.PRODUTO
inner join (select distinct griffe, linha, grupo_produto, subgrupo_produto, UNOUS_ALOCAR, UNOUS_NIVEL 
from CAE_PRODUTOS_FATOR_P 
) h on h.GRIFFE=p.GRIFFE and h.LINHA=p.LINHA 
		and h.GRUPO_PRODUTO=p.GRUPO_PRODUTO and h.SUBGRUPO_PRODUTO=p.SUBGRUPO_PRODUTO
where cp.ENTREGA>'20240101' and h.UNOUS_ALOCAR=0