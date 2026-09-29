
with packs (PEDIDO, PRODUTO, COR_PRODUTO, DESC_COR_PRODUTO, QTDE,
q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, 
q12, q13, q14, q15, q16)
as
(
select a.PEDIDO, a.PRODUTO, a.COR_PRODUTO, a.DESC_COR_PRODUTO, a.QTDE,
a.q1, a.q2, a.q3, a.q4, a.q5, a.q6, a.q7, a.q8, a.q9, a.q10, a.q11, 
a.q12, a.q13, a.q14, a.q15, a.q16
from CAEDU_COMPRAS_PRODUTOS_PACKS a
inner join (
select distinct produto, Cor_produto, Distribuicao
from [CCP\PAULO.DEVIDE].[TB_CAIXAS_PDA_FASTASMA_4K] C
where 1=1
AND C.Distribuicao IN ('350060'  
,'350065'  
,'347775'  
,'348308'  
,'350684'  
,'348551'  
,'347172'  
,'348230'  
,'347635'  
,'347406'  
,'330078'  
,'331620'  
,'348053'  
,'333342'  
,'333388'  
,'346393')  
) Z on Z.PRODUTO=a.PRODUTO and z.Cor_produto=a.COR_PRODUTO and z.Distribuicao=a.PEDIDO
)

select z.caixa, z.filial, z.produto, z.QUANTIDADE, z.lojadestino,
z.Distribuicao, a.COR_PRODUTO, a.qtde,
a.q1, a.q2, a.q3, a.q4, a.q5, a.q6, a.q7, a.q8, a.q9, a.q10, a.q11, 
a.q12, a.q13, a.q14, a.q15, a.q16, pp.preco1 as custo_1, p.grade, 
p.erp_qtd_pack, 'CD - SP - SAO ROQUE' AS filial_origem, 'CX-'+rtrim(z.caixa) as venda,
a.qtde as QTDE_TOTAL
from packs a
inner join [CCP\PAULO.DEVIDE].[TB_CAIXAS_PDA_FASTASMA_4K] z
				on Z.PRODUTO=a.PRODUTO and z.Cor_produto=a.COR_PRODUTO and z.Distribuicao=a.PEDIDO
inner join produtos_precos pp on pp.produto = a.produto and pp.CODIGO_TAB_PRECO='02'
inner join produtos p on p.produto = a.produto 

