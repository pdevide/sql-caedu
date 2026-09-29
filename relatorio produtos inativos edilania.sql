select	p.PRODUTO, 
		pc.COR_PRODUTO,
		pc.FIM_VENDAS,
		p.DESC_PRODUTO,
		p.GRADE,
		p.INATIVO, 
		p.GRIFFE,
		p.LINHA,
		p.GRUPO_PRODUTO,
		p.SUBGRUPO_PRODUTO,
		e.estoque as estoque_geral
from PRODUTOS p
inner join PRODUTO_CORES pc 
	on pc.PRODUTO = p.PRODUTO
inner join (
select PRODUTO, cor_produto, SUM(estoque) estoque
from ESTOQUE_PRODUTOS 
group by PRODUTO, COR_PRODUTO
) e 
on e.PRODUTO = pc.PRODUTO and e.COR_PRODUTO=pc.COR_PRODUTO
where p.INATIVO = 1
order by 1,2