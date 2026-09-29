select cp.* 
from compras c
inner join COMPRAS_PRODUTO cp on cp.PEDIDO = c.PEDIDO
inner join PRODUTOS p on p.PRODUTO = cp.PRODUTO
where year(emissao)=2019 
and fornecedor like '%CHIK%'
and c.pedido not in
(select a.pedido 
from compras a
inner join COMPRAS_PROD_CANCELADA b on b.pedido = a.pedido
where year(a.emissao)=2019 
and a.fornecedor like '%CHIK%')



select ep.pedido, ep.emissao, 
ep1.ROMANEIO_PRODUTO, ep1.PRODUTO, p.desc_produto, 
ep1.COR_PRODUTO, pc.DESC_COR_PRODUTO, p.GRADE, p.ERP_QTD_PACK,
ep1.FILIAL, ep1.QTDE, ep1.EN_1, ep1.CUSTO1, ep1.VALOR, ep1.ITEM_IMPRESSAO,
ep1.packs, ep.NF_ENTRADA, ep.SERIE_NF_ENTRADA, ep.NOME_CLIFOR
from estoque_prod_ent ep
inner join estoque_prod1_ent ep1 
	on ep1.ROMANEIO_PRODUTO = ep.ROMANEIO_PRODUTO and ep1.FILIAL = ep.FILIAL
inner join produtos p on p.PRODUTO = ep1.PRODUTO
inner join PRODUTO_CORES pc 
	on pc.PRODUTO = ep1.PRODUTO and pc.COR_PRODUTO=ep1.COR_PRODUTO
where pedido in (
select c.pedido 
from compras c
inner join COMPRAS_PRODUTO cp on cp.PEDIDO = c.PEDIDO
inner join PRODUTOS p on p.PRODUTO = cp.PRODUTO
where year(emissao)=2019 
and fornecedor like '%CHIK%'
and c.pedido not in
(select a.pedido 
from compras a
inner join COMPRAS_PROD_CANCELADA b on b.pedido = a.pedido
where year(a.emissao)=2019 
and a.fornecedor like '%CHIK%'))
