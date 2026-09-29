--select * from ESTOQUE_PROD_CONTAGEM order by DATA_AJUSTE desc



select a.nome_contagem, 
		cast(pai.EMISSAO as date) as EMISSAO, 
		sum(QTDE_AJUSTE) QTDE_AJUSTE, 
		sum(pp.PRECO1) CUSTO1
from ESTOQUE_PROD_CTG_AJUSTE a
inner join ESTOQUE_PROD_CONTAGEM pai on pai.NOME_CONTAGEM = a.NOME_CONTAGEM
inner join produtos_precos pp on pp.produto = a.produto and pp.CODIGO_TAB_PRECO='00'
--where a.nome_contagem = 'CRUZEIRO 30-07-2018'
group by a.nome_contagem, cast(pai.EMISSAO as date)
order by cast(pai.EMISSAO as date) 


      