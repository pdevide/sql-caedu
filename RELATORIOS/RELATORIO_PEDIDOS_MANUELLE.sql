select 
	c.PEDIDO, 
	cp.PRODUTO, 
	p.desc_produto,
	cp.COR_PRODUTO, 
	pco.DESC_COR_PRODUTO,
	P.GRADE,
	P.LINHA,
	P.GRIFFE,
	P.GRUPO_PRODUTO,
	P.SUBGRUPO_PRODUTO,
	cast(c.EMISSAO as date) as EMISSAO,
	cp.QTDE_ORIGINAL,
	cp.QTDE_CANCELADA,
	cp.QTDE_ENTREGAR,
	cp.VALOR_ORIGINAL, 
	cp.VALOR_ENTREGUE,
	cp.VALOR_ENTREGAR,
	cast(cp.ENTREGA as date) as ENTREGA,
	cast(cp.LIMITE_ENTREGA as date) as LIMITE_ENTREGA,
	c.STATUS_APROVACAO,
	c.STATUS_COMPRA

from compras c
inner join COMPRAS_PRODUTO cp on cp.PEDIDO=c.pedido
inner join PRODUTOS p on p.PRODUTO = cp.PRODUTO
left join PRODUTO_CORES pco on pco.PRODUTO=cp.PRODUTO AND pco.COR_PRODUTO = cp.COR_PRODUTO

where c.emissao between '20151001' and '20170630'
