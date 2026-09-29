WITH SEMBOX (FILIAL,LOJADESTINO,CAIXA,DOCA,CODIGO_FILIAL,DATA,FATURADO,PEDIDO,PRODUTO,COR_PRODUTO,QTDE_EMBALADA)
AS
(
SELECT F.FILIAL, F.FILIAL AS LOJADESTINO,A.CAIXA,A.DOCA,A.CODIGO_FILIAL,A.DATA,A.FATURADO,
VE.PEDIDO,VE.PRODUTO,VE.COR_PRODUTO,VE.QTDE_EMBALADA
FROM PDA_WMS_TB_EMBARQUE A
INNER JOIN FILIAIS F ON F.COD_FILIAL=A.CODIGO_FILIAL
LEFT JOIN FATURAMENTO_PROD FP ON FP.CAIXA=A.CAIXA
LEFT JOIN VENDAS_PROD_EMBALADO VE ON VE.CAIXA=A.CAIXA
WHERE 1=1
AND FP.CAIXA IS NULL --AND VE.CAIXA IS not NULL
--AND A.DATA>'20250101' AND A.DATA < CONVERT(varchar,GETDATE(),112)
AND A.DATA>'20250101' AND A.DATA < '20250801'--CONVERT(varchar,GETDATE(),112)
)
select count(*) 
--into [ccp\paulo.devide].[TB_CAIXAS_A_FATURAR_20250519]
from sembox


select b.nf_saida, 
(select top 1 rtrim(produto)+'|'+rtrim(cor_produto) as produto_cor from caedu_reserva_automatica where caixa = a.caixa) as produto_cor_pedido,
(select top 1 rtrim(produto)+'|'+rtrim(cor_produto) as produto_cor from caedu_reserva_automatica_wms where caixa = a.caixa) as produto_cor_wms
,a.* 
from PDA_WMS_TB_EMBARQUE a
left join faturamento_prod b on b.caixa = a.caixa
where a.data>'20250101' and a.data<'20250801'
and a.FATURADO=1 and b.NF_SAIDA is null


select descricao, codigo from caedu_lista_combo where id_dominio='026' 
