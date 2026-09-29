USE [CAEDU]
GO

/****** Object:  View [dbo].[CGP_VW_DADOS_PRECOS]    Script Date: 24/10/2022 15:47:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[CGP_VW_DADOS_PRECOS] AS
SELECT 
       il.CODIGO_FILIAL,
       substring(RTRIM(LTRIM(F.CGC_CPF)), 9,4) as COD_LOJA,
       A.PRODUTO AS PRODUTO, 
       case when (A.CODIGO_TAB_PRECO = '04') then 2 else 1 end as tipo_venda,
       A.PRECO1 AS PRECO1,
       A.CODIGO_TAB_PRECO AS CODIGO_TAB_PRECO 
FROM PRODUTOS_PRECOS A        (nolock)
INNER JOIN PRODUTOS B         (nolock) ON A.PRODUTO = B.PRODUTO 
inner join PARAMETROS_LOJA pl (nolock) on pl.PARAMETRO = 'CODIGO_TAB_PRECO' and A.CODIGO_TAB_PRECO = pl.VALOR_ATUAL
inner join FILIAIS f          (nolock) on f.COD_FILIAL = pl.CODIGO_FILIAL 
inner join info_lojas il      (nolock) on il.CODIGO_FILIAL = f.COD_FILIAL and il.ATIVO = '1'
WHERE 1 = 1 
AND B.ENVIA_LOJA_VAREJO = 1
AND A.PRECO1 <> 0.00
AND F.FILIAL NOT LIKE '%CD %'
union all
SELECT 
       il.CODIGO_FILIAL,
       substring(RTRIM(LTRIM(F.CGC_CPF)), 9,4) as COD_LOJA,
       A.PRODUTO AS PRODUTO, 
       case when (A.CODIGO_TAB_PRECO = '04') then 2 else 1 end as tipo_venda,
       A.PRECO1 AS PRECO1,
       A.CODIGO_TAB_PRECO AS CODIGO_TAB_PRECO 
FROM PRODUTOS_PRECOS A        (nolock)
INNER JOIN PRODUTOS B         (nolock) ON A.PRODUTO = B.PRODUTO 
inner join PARAMETROS_LOJA pl (nolock) on pl.PARAMETRO = 'CODIGO_TAB_PRECO' and A.CODIGO_TAB_PRECO = '04' and pl.CODIGO_FILIAL not in ('999999')
inner join FILIAIS f          (nolock) on f.COD_FILIAL = pl.CODIGO_FILIAL 
inner join info_lojas il      (nolock) on il.CODIGO_FILIAL = f.COD_FILIAL and il.ATIVO = '1'
WHERE 1 = 1 
AND B.ENVIA_LOJA_VAREJO = 1
AND A.PRECO1 <> 0.00
AND F.FILIAL NOT LIKE '%CD %'
GO


