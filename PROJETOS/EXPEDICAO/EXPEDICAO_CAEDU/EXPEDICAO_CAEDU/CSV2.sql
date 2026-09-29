--use CAEDU
SELECT 
1 AS rownum	
,a.caixa	
,F.FILIAL AS doca	
,F.COD_FILIAL AS codigo_filial	
,F.filial	
,'P' origem	
,a.pedido as distribuicao	
,a.produto	
,F.filial as lojadestino	
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
left join FILIAIS F ON F.FILIAL = A.filial
where a.caixa in  

--(select a.caixa
--from caedu_reserva_automatica a
--left join faturamento_prod b on b.caixa = a.caixa
--left join vendas_prod_embalado c on c.caixa = a.CAIXA
--where a.pedido in (
--'374844E',
--'378186E'
--)
--and b.nf_saida is null and c.pedido is null)



--(select cra.caixa
--from caedu_reserva_automatica cra 
--left join faturamento_prod fp on fp.caixa = cra.caixa
--where 1=1
--and fp.nf_saida is null
--and cra.pedido = '371173')
--('34368288','34368288','34368288','34368301','34368301','34368301','34368318','34368318','34368318','34368319','34368319','34368319')

-- descomentar esse para ficar default
(select x.caixa from PDA_WMS_TB_EMBARQUE x left join vendas_prod_embalado b on b.caixa=x.caixa where x.FATURADO=0 and b.caixa is null)
--and CODIGO_FILIAL = '000027'
--and pda.doca <> 'SP SH JARDIM ORIENTE PACK' --and filial_origem='CD CAJAMAR' 
--AND FILIAL<>'SP SH JARDIM ORIENTE'     
--and a.caixa <> '34546515'
--and codigo_filial='000027'    
--(select a.caixa
--from caedu_reserva_automatica a
--left join VENDAS_PROD_EMBALADO b on b.caixa=a.caixa
--where a.pedido='355770' and b.caixa is null)


--(
--select a.caixa
----gerado, b.pedido, a.caixa, * 
--from caedu_reserva_automatica a
--left join vendas_prod_embalado b on b.caixa=a.caixa
--left join faturamento_prod fp on fp.caixa = a.caixa
--where a.pedido in (
--'371232'  
--) 
--and b.pedido is null and fp.nf_saida is null
--)
--and F.FILIAL != 'JAÇANA'
