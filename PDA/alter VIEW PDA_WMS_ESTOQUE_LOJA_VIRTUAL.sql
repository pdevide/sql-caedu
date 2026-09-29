USE [CAEDU]
GO

/****** Object:  View [dbo].[PDA_WMS_ESTOQUE_LOJA_VIRTUAL]    Script Date: 10/11/2020 09:58:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
select * from [PDA_WMS_ESTOQUE_LOJA_VIRTUAL] where produto = '06371255'

ALTER VIEW [dbo].[PDA_WMS_ESTOQUE_LOJA_VIRTUAL]
AS

SELECT 
		Ltrim(Rtrim(filial))            AS FILIAL, 
        Ltrim(Rtrim(C.produto))          AS PRODUTO, 
        Ltrim(Rtrim(B.codigo_barra))     AS CODIGO_BARRA, 
        Ltrim(Rtrim(B.cor_produto))      AS COR_PRODUTO, 
        RIGHT('00'+convert(varchar,b.TAMANHO),2)  AS TAMANHO, 
        Ltrim(Rtrim(B.grade))            AS GRADE, 
        unpvt.qtde AS ESTOQUE_COD_BARRA 
			FROM (SELECT produto, cor_produto,  FILIAL,ES1,ES2,ES3,ES4,ES5,ES6,ES7,ES8,ES9,ES10,ES11,ES12,ES13,ES14,ES15,ES16,ES17,ES18,ES19,ES20
			FROM [CAEDU].[dbo].estoque_produtos
			where FILIAL ='LOJA VIRTUAL' 
			                ) p
			UNPIVOT
(qtde FOR tamanho IN
(ES1,ES2,ES3,ES4,ES5,ES6,ES7,ES8,ES9,ES10,ES11,ES12,ES13,ES14,ES15,ES16,ES17,ES18,ES19,ES20) )AS unpvt
LEFT JOIN (
SELECT  PRODUTO, COR_PRODUTO, TAMANHO, GRADE, MIN(CODIGO_BARRA) AS CODIGO_BARRA
FROM [CAEDU].[dbo].PRODUTOS_BARRA
WHERE codigo_barra NOT LIKE '%D' 
GROUP BY PRODUTO, COR_PRODUTO, TAMANHO, GRADE
) B ON B.PRODUTO = unpvt.PRODUTO AND B.COR_PRODUTO = unpvt.COR_PRODUTO AND B.TAMANHO = substring(unpvt.tamanho,3,2)
LEFT join [CAEDU].[dbo].PRODUTOS as c on b.PRODUTO=c.PRODUTO
LEFT join [CAEDU].[dbo].PRODUTO_CORES as e on c.PRODUTO=e.PRODUTO and unpvt.COR_PRODUTO=e.COR_PRODUTO
LEFT join [CAEDU].[dbo].produtos_precos as H on c.PRODUTO=h.PRODUTO where h.CODIGO_TAB_PRECO ='00'
go
