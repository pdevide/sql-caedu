--select 
--P.REFER_FABRICANTE,
--P.griffe,
--P.linha,
--P.GRUPO_PRODUTO,
--P.SUBGRUPO_PRODUTO,
--A.PRODUTO,
--A.COR_PRODUTO,
--'' AS CODIGO_BARRA,
--P.DESC_PRODUTO,
--PC.desc_cor_produto,r
--0 TAMANHO,
--A.ESTOQUE
--from estoque_produtos a
--INNER JOIN (select FILIAL 
--			from filiais where CGC_CPF = '46377727004776') b ON b.FILIAL = A.FILIAL
--INNER JOIN PRODUTOS P
--	ON P.PRODUTO = A.PRODUTO
--INNER JOIN PRODUTO_CORES PC
--	ON PC.PRODUTO = A.PRODUTO AND PC.COR_PRODUTO = A.COR_PRODUTO
--where a.ESTOQUE<>0


SELECT    c.griffe, c.linha, c.GRUPO_PRODUTO, c.SUBGRUPO_PRODUTO, C.PRODUTO, b.COR_PRODUTO, B.CODIGO_BARRA, c.DESC_PRODUTO,
         e.desc_cor_produto, c.refer_fabricante, unpvt.filial, 
              RIGHT('00'+convert(varchar,b.TAMANHO),2) as TAMANHO, unpvt.qtde, h.PRECO1 as CUSTO
              FROM (SELECT produto, cor_produto, estoque_produtos.filial, ES1,ES2,ES3,ES4,ES5,ES6,ES7,ES8,ES9,ES10,ES11,ES12,ES13,ES14,ES15,ES16,ES17,ES18,ES19,ES20
                           FROM estoque_produtos
							INNER JOIN (select FILIAL 
										from filiais where CGC_CPF = '46377727004776') fi ON fi.FILIAL = estoque_produtos.FILIAL
                           AND ESTOQUE <> 0
                           ) p
                    UNPIVOT
(qtde FOR tamanho IN
(ES1,ES2,ES3,ES4,ES5,ES6,ES7,ES8,ES9,ES10,ES11,ES12,ES13,ES14,ES15,ES16,ES17,ES18,ES19,ES20) )AS unpvt 
--LEFT join PRODUTOS_BARRA as b on unpvt.produto=b.produto and unpvt.COR_PRODUTO=b.COR_PRODUTO and substring(unpvt.tamanho,3,2)=b.TAMANHO
LEFT JOIN (
SELECT  PRODUTO, COR_PRODUTO, TAMANHO, MIN(CODIGO_BARRA) AS CODIGO_BARRA
FROM PRODUTOS_BARRA
GROUP BY PRODUTO, COR_PRODUTO, TAMANHO
) B ON B.PRODUTO = unpvt.PRODUTO AND B.COR_PRODUTO = unpvt.COR_PRODUTO AND B.TAMANHO = substring(unpvt.tamanho,3,2)
LEFT join PRODUTOS as c on b.PRODUTO=c.PRODUTO 
LEFT join PRODUTO_CORES as e on c.PRODUTO=e.PRODUTO and unpvt.COR_PRODUTO=e.COR_PRODUTO 
LEFT join produtos_precos as H on c.PRODUTO=h.PRODUTO where h.CODIGO_TAB_PRECO ='00'
order by FILIAL, CODIGO_BARRA




					


