/*
Query Fiscal

Produtos ativos e com estoque
Com pedido de compra em aberto
Nacionais e Importados
Trazer fornecedor
Trazer os 3 campos Tribut_origem */

select	p.produto, 
		pc.COR_PRODUTO,
		pc.DESC_COR_PRODUTO,
		p.DESC_PRODUTO, 
		p.GRIFFE, 
		p.LINHA, 
		p.GRUPO_PRODUTO, 
		p.SUBGRUPO_PRODUTO,
		p.GRADE,
		p.FABRICANTE,
		p.TRIBUT_ORIGEM as TRIBUT_ORIGEM_PRODUTO,
		pc.TRIBUT_ORIGEM as TRIBUT_ORIGEM_COR,
		CASE WHEN p.TRIBUT_ORIGEM=PC.TRIBUT_ORIGEM THEN 'IGUAL'
			ELSE	'DIFERENTE' END AS COMPARA
		--(select X.FILIAL,TRIBUT_ORIGEM from PRODUTOS_INDICADOR_CFOP X where produto=p.produto
		--for json auto) as TRIBUT_ORIGEM_ABA_CARAC_CONTAB,
		--(select Z.COR_PRODUTO,Z.TRIBUT_ORIGEM from PRODUTO_CORES Z where produto=p.produto
		--for json auto) as TRIBUT_ORIGEM_ABA_CORES
from produtos p
INNER JOIN PRODUTO_CORES pc on pc.PRODUTO=p.PRODUTO
where p.INATIVO=0
and exists (
select produto from estoque_produtos
where 1=1 and 
((ES1<>0) OR (ES2<>0) OR (ES3<>0) OR (ES4<>0) OR (ES5<>0) OR (ES6<>0) 
		OR (ES7<>0) OR (ES8<>0) OR (ES9<>0) OR (ES10<>0) OR (ES11<>0) OR (ES12<>0) 
		OR (ES13<>0) OR (ES14<>0) OR (ES15<>0) OR (ES16<>0))
)
and exists (
select 1 
from compras_produto cp
inner join compras c on cp.pedido=cp.PEDIDO
where produto=p.PRODUTO and c.TOT_QTDE_ENTREGAR>0
)



select	p.produto, 
		p.DESC_PRODUTO, 
		p.GRIFFE, 
		p.LINHA, 
		p.GRUPO_PRODUTO, 
		p.SUBGRUPO_PRODUTO,
		p.GRADE,
		p.FABRICANTE,
		p.CLASSIF_FISCAL,
		p.ID_CEST_NCM,
		p.TRIBUT_ORIGEM as TRIBUT_ORIGEM_PRODUTO,
		pic.FILIAL,
		pic.TRIBUT_ORIGEM as TRIBUT_ORIGEM_CARAC_CONTAB,
		pic.INDICADOR_CFOP,
		pic.TIPO_ITEM_SPED,
		CASE WHEN p.TRIBUT_ORIGEM=pic.TRIBUT_ORIGEM THEN 'IGUAL'
			ELSE	'DIFERENTE' END AS COMPARA

from produtos p
left JOIN PRODUTOS_INDICADOR_CFOP pic on pic.PRODUTO=p.PRODUTO
where p.INATIVO=0
and exists (
select produto from estoque_produtos
where 1=1 and 
((ES1<>0) OR (ES2<>0) OR (ES3<>0) OR (ES4<>0) OR (ES5<>0) OR (ES6<>0) 
		OR (ES7<>0) OR (ES8<>0) OR (ES9<>0) OR (ES10<>0) OR (ES11<>0) OR (ES12<>0) 
		OR (ES13<>0) OR (ES14<>0) OR (ES15<>0) OR (ES16<>0))
)
and exists (
select 1 
from compras_produto cp
inner join compras c on cp.pedido=cp.PEDIDO
where produto=p.PRODUTO and c.TOT_QTDE_ENTREGAR>0
)


select  
	TABELA_LX_CEST.CODIGO_CEST, 
	TABELA_LX_NCM.CODIGO_NCM, 
	Cast(TABELA_LX_CEST.DESCRICAO As VARCHAR(254)) As DESCRICAO, 
	CEST_NCM.ID, TABELA_LX_CEST.INATIVO 
from TABELA_LX_CEST   
JOIN CEST_NCM ON TABELA_LX_CEST.ID = CEST_NCM.ID_CEST 
JOIN TABELA_LX_NCM ON CEST_NCM.ID_NCM = TABELA_LX_NCM.ID 
where  TABELA_LX_CEST.CODIGO_CEST LIKE '1900500' 
And CEST_NCM.INATIVO = 0  
And TABELA_LX_NCM.INATIVO = 0  
And TABELA_LX_CEST.INATIVO = 0  
and TABELA_LX_NCM.CODIGO_NCM = '42029200'


select ID_CEST_NCM,* from produtos where produto = '55110301'