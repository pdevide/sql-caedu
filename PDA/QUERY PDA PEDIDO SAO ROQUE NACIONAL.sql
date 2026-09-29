SELECT DISTINCT
       RTRIM(A.PEDIDO)                  AS Pedido,
       RTRIM(B.COD_FILIAL)              AS CodigoFilial,
       RTRIM(A.CAIXA)                   AS Caixa,
       RTRIM(A.PEDIDO)                  AS CodigoDistribuicao,
       RTRIM(A.PRODUTO)                 AS Produto,
       A.QTDE_TOTAL                     AS Quantidade,
       ''                               AS Cor,
       ''                               AS Grade,
       ''                               AS Tamanho,
       RTRIM(Z.LINHA)                   AS Grupo,
       RTRIM(Z.GRIFFE)                  AS Grife,
       RTRIM(COLECOES.DESC_COLECAO)     AS Colecao,
       CASE
           WHEN Z.COD_CATEGORIA = '2' THEN 'Cabide'
           ELSE ''
       END                              AS Cabide,
       RTRIM(B.erp_cod_rota)            AS CodigoRota,
       (SELECT NOME_CLIFOR
          FROM FATURAMENTO_CAIXAS (NOLOCK)            
         WHERE CAIXA = A.CAIXA)         AS CaixaNome,
       RTRIM(B.FILIAL)                  AS DescricaoFilial
FROM   CAEDU_RESERVA_AUTOMATICA A (NOLOCK)
JOIN   PRODUTOS Z (NOLOCK)
       ON Z.PRODUTO = A.PRODUTO
JOIN   FILIAIS B (NOLOCK)
       ON A.FILIAL = B.FILIAL
LEFT JOIN COLECOES (NOLOCK)
       ON COLECOES.COLECAO = Z.COLECAO
WHERE  A.PEDIDO IN ('')         -- colocar Pedido aqui
GROUP BY
       A.PEDIDO,
       B.COD_FILIAL,
       A.CAIXA,
       A.PRODUTO,
       A.QTDE_TOTAL,
       Z.LINHA,
       Z.GRIFFE,
       COLECOES.DESC_COLECAO,
       Z.COD_CATEGORIA,
       B.erp_cod_rota,
       B.FILIAL;
