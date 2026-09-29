/*
* CSV 5
* PEGA DADOS DA CAEDU_RESERVA_AUTOMATICA_PACK_WMS
*/

SELECT 
	1 AS rownum	
	,a.caixa	
	,f.filial doca	
	,f.clifor as codigo_filial	
	,a.filial	
	,'W' origem	
	,a.distribuicao as distribuicao	
	,a.produto	
	,a.filial as lojadestino	
	,filial_origem	
	,a.qtde_total	
	,1 qtde_pack	
	,venda	
	,ppp.pack	
	,preco1 as custo_1	
	,grade	
	,erp_qtd_pack	
	,1 qtde_packs	
	,ppp.cor_produto cor_produto	
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
	--INTO [CCP\PAULO.DEVIDE].TEMP_CSV
	from caedu_reserva_automatica_pack_wms a
	--inner join compras_produto cp on cp.pedido=a.pedido and cp.produto=a.produto and cp.COR_PRODUTO=a.cor_produto
	left join PDA_WMS_TB_EMBARQUE pda on pda.caixa=a.CAIXA
	inner join PRODUTOS_PRECOS pp on pp.produto = a.PRODUTO and pp.CODIGO_TAB_PRECO='02'
	inner join PRODUTOS P ON P.PRODUTO = a.PRODUTO
	inner join PRODUTOS_PACKS_PERMITIDOS ppp 
				on ppp.produto = a.produto 
				--and ppp.cor_produto=a.COR_PRODUTO 
				and ppp.pack=a.PACK
	inner join filiais f on f.filial=a.filial
	where a.caixa in 
--(
--'37151279'
--)

(select x.caixa from PDA_WMS_TB_EMBARQUE x left join vendas_prod_embalado b on b.caixa=x.caixa where x.FATURADO=0 and b.caixa is null)
/*
select * 
--update a set pack = 
--case when pack = 'A' then 'B'
--	 when pack = 'B' then 'A'
--end
from CAEDU_RESERVA_AUTOMATICA_PACK_WMS a
where caixa 
in (
'34771460',       
'34771445',       
'34751091' )

select * from PRODUTOS_PACKS_PERMITIDOS 
where produto in ('44150048','53022323')
*/