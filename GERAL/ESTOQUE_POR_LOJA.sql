SELECT Rtrim (dbo.estoque_produtos.filial)   AS FILIAL, 
       dbo.estoque_produtos.produto, 
       Rtrim (dbo.produtos.griffe)           AS GRIFFE, 
       Rtrim (dbo.produtos.linha)            AS LINHA, 
       Rtrim (dbo.produtos.grupo_produto)    AS GRUPO_PRODUTO, 
       Rtrim (dbo.produtos.subgrupo_produto) AS SUBGRUPO_PRODUTO, 
       dbo.produtos.fator_p, 
       Sum (dbo.estoque_produtos.estoque)    AS QTDE, 
       Avg (dbo.produtos.preco_reposicao_1)  AS CUSTO, 
       Avg (dbo.produtos_precos.preco1)      AS PREÇO 
FROM   dbo.estoque_produtos 
       INNER JOIN dbo.produtos_precos 
               ON dbo.estoque_produtos.produto = dbo.produtos_precos.produto 
       INNER JOIN dbo.produtos 
               ON dbo.produtos_precos.produto = dbo.produtos.produto 
WHERE  ( dbo.produtos_precos.codigo_tab_preco = '05' ) 
       AND ( dbo.estoque_produtos.estoque > 0 ) 
	   AND (dbo.estoque_produtos.FILIAL = 'SP - SH CANTAREIRA')
GROUP  BY dbo.estoque_produtos.filial, 
          dbo.estoque_produtos.produto, 
          dbo.produtos.griffe, 
          dbo.produtos.linha, 
          dbo.produtos.grupo_produto, 
          dbo.produtos.subgrupo_produto, 
          dbo.produtos.fator_p 
ORDER  BY dbo.estoque_produtos.produto 

