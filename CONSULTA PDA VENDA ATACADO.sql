--select b.*
--from estoque_prod_ent a 
--INNER JOIN estoque_prod_ent b on b.ROMANEIO_PRODUTO= a.ROMANEIO_PRODUTO and b.FILIAL = a.FILIAL
--where a.pedido = '373253'

--select b.*
--from compras a 
--INNER JOIN compras_produto b on b.pedido = a.pedido
--where a.pedido = '373253'

SELECT RTRIM(A.PEDIDO)                        AS CodigoPedido
               , RTRIM(A.ROMANEIO_PRODUTO)     AS RomaneioProduto
               , RTRIM(A.NF_ENTRADA)                 AS NotaFiscal
               , /*RTRIM(A.CHAVE_NFE) */ ''          AS ChaveNfe
               , RTRIM(A.SERIE_NF_ENTRADA)           AS Serie
               , RTRIM(CONVERT(DATE,A.EMISSAO))      AS Emissao
               , RTRIM(F.COD_FILIAL)      AS CodigoFornecedorErp
               , 0  ValidFornecedor
               , A.FILIAL
               , A.DATA_PARA_TRANSFERENCIA
               , (SELECT RTRIM(ROMANEIO_PRODUTO)       AS CodigoPedido
                  , RTRIM(PRODUTO)         AS Produto
                  , RTRIM(QUANTIDADE)     AS Quantidade
                  , NULL         AS Custo
                  , NULL         AS Desconto
                  , NULL         AS ValorTotal
                  , RTRIM(PACKS)                      AS CodigoPack
                  FROM
                  (
                    SELECT DISTINCT CP.ROMANEIO_PRODUTO
                   , CP.PRODUTO
                   , CP.QTDE AS QUANTIDADE
                   , CP.PACKS           
                   FROM ESTOQUE_PROD1_ENT CP
                   JOIN PRODUTOS_BARRA C ON C.PRODUTO = CP.PRODUTO 
                         AND C.COR_PRODUTO = CP.COR_PRODUTO
                   JOIN ESTOQUE_PROD_ENT D  ON D.ROMANEIO_PRODUTO = CP.ROMANEIO_PRODUTO 
                         AND D.FILIAL = CP.FILIAL
                  WHERE CP.ROMANEIO_PRODUTO = A.ROMANEIO_PRODUTO /* INCLUIR RELACIONAMENTO COM FILIAL TAMBEM */AND CP.FILIAL=A.FILIAL
                  GROUP BY CP.ROMANEIO_PRODUTO
                  , CP.PRODUTO
                  , CP.QTDE
                  , CP.PACKS
                  ) p
                 WHERE QUANTIDADE > 0 FOR JSON PATH ) as RecebimentoItens
               FROM ESTOQUE_PROD_ENT A
               JOIN ESTOQUE_PROD1_ENT P ON A.ROMANEIO_PRODUTO = P.ROMANEIO_PRODUTO 
                      AND A.FILIAL = P.FILIAL
               JOIN COMPRAS C ON C.PEDIDO = A.PEDIDO
             LEFT JOIN FILIAIS F ON F.FILIAL = A.FILIAL
              WHERE C.ERP_CUPS_SEGMENTO  = 'ATACADO'
                AND C.FILIAL_A_ENTREGAR = 'CD BARRA VELHA'
                AND CONVERT(DATE, ISNULL(A.DATA_PARA_TRANSFERENCIA, '19000101')) >= (GETDATE()-7)
                AND a.PEDIDO = '373253'
              GROUP BY A.PEDIDO
               , A.ROMANEIO_PRODUTO
               , A.EMISSAO
               , A.NF_ENTRADA
               , A.SERIE_NF_ENTRADA
               , F.COD_FILIAL
               , A.FILIAL
               , A.DATA_PARA_TRANSFERENCIA
              ORDER BY A.EMISSAO DESC
