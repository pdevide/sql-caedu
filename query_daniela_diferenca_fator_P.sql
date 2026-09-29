
--select * from CAE_PRODUTOS_FATOR_P


select 
	p.produto, 
	p.DESC_PRODUTO, 
	p.GRIFFE, 
	p.LINHA, 
	p.GRUPO_PRODUTO, 
	p.SUBGRUPO_PRODUTO, 
	pp.PRECO1, 
	p.FATOR_P, 
	cp.REFERENCIA 
from produtos p
INNER JOIN PRODUTOS_PRECOS pp on pp.PRODUTO = p.PRODUTO and pp.CODIGO_TAB_PRECO='01'
INNER JOIN CAE_PRODUTOS_FATOR_P cp 
	on cp.GRIFFE = p.GRIFFE 
		and cp.LINHA = p.LINHA 
		and cp.GRUPO_PRODUTO = p.GRUPO_PRODUTO 
		and cp.SUBGRUPO_PRODUTO = p.SUBGRUPO_PRODUTO
		and pp.preco1 between cp.VALOR1 and cp.VALOR2
where 
	p.griffe = 'CALCADOS' 
	and p.linha = 'FEMININO' 
	and p.grupo_produto = 'SAPATILHA' 
	and p.subgrupo_produto = 'SAPATILHA'   
	and cp.REFERENCIA <> p.FATOR_P



