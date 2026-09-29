select p.produto, pb.produto, pb.CODIGO_BARRA, len(pb.CODIGO_BARRA) as tamanho_barra, p.DATA_CADASTRAMENTO, cp.LIMITE_ENTREGA, 
p.GRIFFE, p.linha, p.grupo_produto, p.SUBGRUPO_PRODUTO, cp.FORNECEDOR 
from produtos p
left join produtos_barra pb 
	on p.produto = pb.produto
left join (select distinct produto, limite_entrega, fornecedor 
from compras_produto c1 inner join compras c on c.pedido = c1.pedido) cp on cp.PRODUTO = p.PRODUTO
where cp.LIMITE_ENTREGA between '@DATA1' and '@DATA2'
and len(pb.CODIGO_BARRA)<15 
order by 6 asc



