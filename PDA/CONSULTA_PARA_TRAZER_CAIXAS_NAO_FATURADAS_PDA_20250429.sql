create view [ccp\paulo.devide].VW_CAIXAS_NAO_FATURADAS_PDA_4
as

select 
F.filial
,A.CAIXA	
,DOCA	
,CODIGO_FILIAL	
,USUARIO
,DATA	
,FATURADO	
,d.distribuicao	
,d.produto	
,F.filial as lojadestino	
,d.filial_origem	
,d.qtde_total	
,d.qtde_pack	
,d.venda	
,d.pack	
,d.origem
,PP.PRECO1 AS CUSTO_1
,B.GRADE
,B.ERP_QTD_PACK
,(SELECT COUNT(*) FROM PRODUTOS_PACKS_PERMITIDOS WHERE PRODUTO = D.PRODUTO) AS qtde_packs

from	PDA_WMS_TB_EMBARQUE A

left join FILIAIS F ON F.COD_FILIAL = A.CODIGO_FILIAL

left join FATURAMENTO_PROD FP ON FP.CAIXA = A.CAIXA

LEFT JOIN (

SELECT caixa
,distribuicao	
,produto	
,filial as lojadestino	
,filial_origem	
,qtde_total	
,qtde_pack	
,venda	
,pack	
,'W' as origem
FROM CAEDU_RESERVA_AUTOMATICA_PACK_WMS W

UNION 

SELECT caixa
,pedido as distribuicao	
,produto	
,filial as lojadestino	
,filial_origem	
,qtde_total	
,qtde_pack	
,venda	
,' ' as pack	
,'P' as origem
from CAEDU_RESERVA_AUTOMATICA CD

) D on D.caixa = A.CAIXA

LEFT JOIN PRODUTOS_PRECOS PP ON PP.PRODUTO = D.PRODUTO AND PP.CODIGO_TAB_PRECO = '02'

LEFT JOIN PRODUTOS B ON B.PRODUTO = D.PRODUTO

WHERE 1=1 
AND A.DATA > '20250101' AND A.DATA < CONVERT(VARCHAR,GETDATE(),112)
AND FP.CAIXA IS NULL 
AND D.CAIXA IS NOT NULL
	