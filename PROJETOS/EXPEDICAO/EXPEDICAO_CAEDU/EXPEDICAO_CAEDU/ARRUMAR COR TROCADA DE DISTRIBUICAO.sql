/*
select FP.NF_SAIDA,vp.pedido, ve.pedido, a.*
--UPDATE VP SET COR_PRODUTO='00140'
--UPDATE VE SET COR_PRODUTO='00140'
--update a set cor_produto='00140'
from CAEDU_RESERVA_AUTOMATICA A
LEFT JOIN produtos_packs_permitidos ppp on ppp.produto=a.produto and ppp.cor_produto = a.cor_produto
left join vendas v on v.pedido = a.venda
left join vendas_produto vp on vp.pedido = a.venda
left join vendas_prod_embalado ve  on ve.pedido = a.venda
left join faturamento_prod fp on fp.caixa = a.caixa
left join filiais f on f.filial = a.FILIAL
left join produtos_precos pp on pp.produto = a.produto and pp.CODIGO_TAB_PRECO='02'
left join produtos p on p.produto = a.produto 
left join faturamento_caixas fc on fc.caixa = a.caixa
where 1=1
and fp.NF_SAIDA is null
and p.produto = 'V2210361'
and a.pedido = '360935'
*/


select 
	--1 AS rownum	
	--,a.caixa	
	--,f.filial doca	
	--,f.clifor as codigo_filial	
	--,a.filial	
	--,'P' origem	
	--,a.DISTRIBUICAO as distribuicao	
	--,a.produto	
	--,a.filial as lojadestino	
	--,filial_origem	
	--,a.qtde_total	
	--,1 qtde_pack	
	--,venda	
	--,ppp.pack	
	--,pp.preco1 as custo_1	
	--,grade	
	--,erp_qtd_pack	
	--,1 qtde_packs	
	--,ppp.cor_produto	
	--,ppp.qtde	
	--,ppp.q1	
	--,ppp.q2	
	--,ppp.q3	
	--,ppp.q4	
	--,ppp.q5	
	--,ppp.q6	
	--,ppp.q7	
	--,ppp.q8	
	--,ppp.q9	
	--,ppp.q10	
	--,ppp.q11	
	--,ppp.q12	
	--,ppp.q13	
	--,ppp.q14	
	--,ppp.q15	
	--,ppp.q16	
	--,1 qtde_total_valor
FP.NF_SAIDA,V.CLIENTE_ATACADO, vp.pedido, ve.pedido, a.*, PPP.PACK AS PACK_PERMITIDO
--UPDATE VP SET COR_PRODUTO='00140'
--UPDATE VE SET COR_PRODUTO='00140'
--update a set cor_produto='00140'
--UPDATE A SET PACK = 'A'

--update v set APROVACAO='A', FILIAL='CD - SP - SAO ROQUE', FILIAL_DIGITACAO='CD - SP - SAO ROQUE'
--update ve set FILIAL='CD - SP - SAO ROQUE'
--UPDATE V SET APROVACAO='A', CLIENTE_ATACADO='IPIRANGA', 
--REPRESENTANTE='IPIRANGA', NOME_CLIFOR_ENTREGA='IPIRANGA', GERENTE='IPIRANGA'
--UPDATE VE SET NOME_CLIFOR='IPIRANGA',REPRESENTANTE='IPIRANGA'
--update fc SET NOME_CLIFOR='IPIRANGA', NOME_CLIFOR_ENTREGA='IPIRANGA'

from CAEDU_RESERVA_AUTOMATICA_PACK_WMS A
LEFT JOIN produtos_packs_permitidos ppp on ppp.produto=a.produto 
			--and ppp.cor_produto = a.cor_produto
			--AND ppp.PACK = a.PACK
left join vendas v on v.pedido = a.venda
left join vendas_produto vp on vp.pedido = a.venda
left join vendas_prod_embalado ve  on ve.pedido = a.venda
left join faturamento_prod fp on fp.caixa = a.caixa
left join filiais f on f.filial = a.FILIAL
left join produtos_precos pp on pp.produto = a.produto and pp.CODIGO_TAB_PRECO='02'
left join produtos p on p.produto = a.produto 
left join faturamento_caixas fc on fc.caixa = a.caixa
where 1=1
and fp.NF_SAIDA is null
--and p.produto = '00039217'
and a.DISTRIBUICAO in (
 '00041606'
,'00041003'
,'00040726'
,'00040024'
,'00039217'
,'00039216'
)
--AND A.PRODUTO IN ('55060645','55060646','53022324')
AND A.CAIXA = '34326724'

GO
/*
DIST		PRODUTO
00039216	55060645
00039217	55060646
00040024	53022324

*/
/*
select distribuicao, pack, produto, COUNT(*) AS QTY 
from caedu_reserva_automatica_pack_wms
where distribuicao in (
 '00041606'
,'00041003'
,'00040726'
,'00040024'
,'00039217'
,'00039216'
)
GROUP BY distribuicao, pack, produto

*/

SELECT * FROM CGP_PDA_WMS_STATUS_DISTRIBUICAO 
where distribuicao in (
 '00041606'
,'00041003'
,'00040726'
,'00040024'
,'00039217'
,'00039216'
)



--SELECT * 
--UPDATE A SET DATA='20251217'
--FROM CAEDU_RESERVA_AUTOMATICA_PACK_WMS A
--where distribuicao in (
-- '00041606'
--,'00041003'
--,'00040726'
--,'00040024'
--,'00039217'
--,'00039216'
--)

SELECT * FROM PRODUTOS_PACKS_PERMITIDOS
WHERE PRODUTO IN ('55060645','55060646','53022324')


select * from CGP_TRANSF_CAIXA_FILIAL
where caixa in ('34326723','34326724','34326725')


select * fROM filiais where cod_filial in ('000221','000055')


