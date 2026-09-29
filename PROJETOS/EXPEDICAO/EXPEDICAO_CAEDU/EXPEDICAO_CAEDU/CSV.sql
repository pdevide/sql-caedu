--use caedu

SELECT 
1 AS rownum	
,b.caixa	
,doca	
,codigo_filial	
,filial	
,'P' origem	
,distribuicao	
,b.produto	
,filial as lojadestino	
,filial_origem	
,qtde_total	
,qtde_pack	
,venda	
,ppp.pack	
,preco1 as custo_1	
,grade	
,erp_qtd_pack	
,1 qtde_packs	
,b.cor_produto	
,qtde	
,q1	
,q2	
,q3	
,q4	
,q5	
,q6	
,q7	
,q8	
,q9	
,q10	
,q11	
,q12	
,q13	
,q14	
,q15	
,q16	
,1 qtde_total_valor
from CGP_LOG_DISTRIBUICOES_EXCLUIDAS a
inner join CGP_LOG_DISTRIBUICOES_EXCLUIDAS_ITENS b 
			on b.id=a.id
inner join PDA_WMS_TB_EMBARQUE pda on pda.caixa=b.CAIXA
inner join PRODUTOS_PRECOS pp on pp.produto = b.PRODUTO and pp.CODIGO_TAB_PRECO='02'
inner join PRODUTOS P ON P.PRODUTO = B.PRODUTO
inner join PRODUTOS_PACKS_PERMITIDOS ppp 
			on ppp.produto = b.produto and ppp.cor_produto=b.COR_PRODUTO and ppp.pack=b.PACK
where b.caixa in  ('31085785','31085921') --('34546498','34546503','34546506','34546514','34546523')
--(select x.caixa from PDA_WMS_TB_EMBARQUE x left join vendas_prod_embalado b on b.caixa=x.caixa where x.FATURADO=0 and b.caixa is null)

 