
--use CAEDU
/*
SELECT * FROM VENDAS_PROD_EMBALADO 
WHERE CAIXA IN (
select a.caixa
--UPDATE A SET GERADO=1
from caedu_reserva_automatica a 
left join faturamento_prod fp on fp.caixa = a.caixa
where 1=1
and fp.nf_saida is null
and a.pedido = '371173'
)
*/

SELECT 
1 AS rownum	
,a.caixa	
,f.filial as doca	
,f.COD_FILIAL as codigo_filial	
,f.filial	
,'P' origem	
,a.pedido as distribuicao	
,a.produto	
,f.filial as lojadestino	
,filial_origem	
,a.qtde_total	
,1 qtde_pack	
,venda	
,ppp.pack	
,preco1 as custo_1	
,grade	
,erp_qtd_pack	
,1 qtde_packs	
,a.cor_produto	
,ppp.qtde	
,ppp.q1	
,ppp.q2	
,ppp.q3	
,ppp.q4	
,ppp.q5	
,ppp.q6	
,ppp.q7	
,ppp.q8	
,ppp.q9	
,ppp.q10	
,ppp.q11	
,ppp.q12	
,ppp.q13	
,ppp.q14	
,ppp.q15	
,ppp.q16	
,1 qtde_total_valor
--update cp set packs='B'
--UPDATE A SET FILIAL = 'SP SH JARDIM ORIENTE'
from caedu_reserva_automatica a
left join compras_produto cp on cp.pedido=a.pedido and cp.produto=a.produto and cp.COR_PRODUTO=a.cor_produto
left join PDA_WMS_TB_EMBARQUE pda on pda.caixa=a.CAIXA
left join PRODUTOS_PRECOS pp on pp.produto = a.PRODUTO and pp.CODIGO_TAB_PRECO='02'
left join PRODUTOS P ON P.PRODUTO = a.PRODUTO
left join PRODUTOS_PACKS_PERMITIDOS ppp 
			on ppp.produto = a.produto and ppp.cor_produto=a.COR_PRODUTO and ppp.pack=cp.PACKS
left join filiais F on F.filial = a.filial
where a.caixa in  
(select cra.caixa
from caedu_reserva_automatica cra 
left join faturamento_prod fp on fp.caixa = cra.caixa
where 1=1
and fp.nf_saida is null
and cra.pedido = '371173')
AND F.FILIAL!='JAÇANA'
ORDER BY F.FILIAL
