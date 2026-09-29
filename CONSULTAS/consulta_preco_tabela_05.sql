select p.produto, p.DESC_PRODUTO, p.DATA_CADASTRAMENTO,
p.GRIFFE, p.LINHA, p.GRUPO_PRODUTO, p.SUBGRUPO_PRODUTO,
p00.PRECO1 as preco_tab00, p01.PRECO1 as preco_tab01, p05.PRECO1 as preco_tab05, p85.PRECO1 as preco_tab85
from produtos p
left join produtos_precos p00 on p00.PRODUTO = p.PRODUTO and p00.CODIGO_TAB_PRECO='00'
left join produtos_precos p01 on p01.PRODUTO = p.PRODUTO and p01.CODIGO_TAB_PRECO='01'
left join produtos_precos p05 on p05.PRODUTO = p.PRODUTO and p05.CODIGO_TAB_PRECO='05'
left join produtos_precos p85 on p85.PRODUTO = p.PRODUTO and p85.CODIGO_TAB_PRECO='85'
where p05.preco1 <> 0
order by p.PRODUTO
