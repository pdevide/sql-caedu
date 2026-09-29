--select   a.PRODUTO, CONVERT (MONEY,A.VALOR_999) valor_999, CONVERT (MONEY,B.VALOR_ITENS) valor_itens,
--        CONVERT (MONEY,A.QTDE_999) QTDE_999, CONVERT (MONEY,B.QTDE_ITENS) QTDE_itens
select  a.filial,  a.PRODUTO, A.VALOR_999 valor_999, B.VALOR_ITENS valor_itens,
       A.QTDE_999 QTDE_999, B.QTDE_ITENS QTDE_itens
from (SELECT filial,  produto, sum(valor) valor_999, SUM(QTDE) QTDE_999
       from cm_estoque_pa_composicao A 
       where cod_custo_medio = '201805'  AND ITEM_COMPOSICAO = '999'
       group by  produto,filial) a 
 inner join (select c.filial, c.produto,  
             SUM(c.VALOR*d.fator_est_proprio) valor_itens, SUM(C.QTDE*D.FATOR_EST_PROPRIO) QTDE_ITENS
             from cm_estoque_pa_composicao c, cm_item_composicao d
             where c.cod_custo_medio = '201805'  AND c.ITEM_COMPOSICAO <> '999'
             and c.item_composicao = d.item_composicao
             group by produto,filial) b on
             a.produto = b.produto and
			 a.filial = b.filial 
WHERE A.VALOR_999 <> B.VALOR_ITENS
AND A.PRODUTO =   '23100013'           
order by 1


SELECT filial, ITEM_COMPOSICAO, SUM(VALOR)/SUM(QTDE) , SUM(QTDE) QTDE, SUM(VALOR) FROM CM_ESTOQUE_PA_COMPOSICAO 
WHERE PRODUTO = '23100013' AND COD_CUSTO_MEDIO = '201805'  and filial = 'BARUERI'
GROUP BY ITEM_COMPOSICAO,filial