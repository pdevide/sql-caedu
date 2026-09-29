select ep.filial, sum(ep.ESTOQUE) estoque, sum(ep.ESTOQUE * pp.preco1) as custo
from ESTOQUE_PRODUTOS ep
inner join PRODUTOS_PRECOS pp on pp.produto = ep.produto and pp.CODIGO_TAB_PRECO='00'
group by filial
order by filial


