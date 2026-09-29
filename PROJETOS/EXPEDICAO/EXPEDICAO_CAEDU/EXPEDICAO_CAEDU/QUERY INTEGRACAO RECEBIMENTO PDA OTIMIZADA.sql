-- CTE 1: Leitura única de LOJA_ENTRADAS filtrada
WITH CTE_Entradas AS (
    SELECT 
        A.ROMANEIO_PRODUTO
      , A.FILIAL
      , A.FILIAL_ORIGEM
      , A.NUMERO_NF_TRANSFERENCIA
      , A.SERIE_NF_ENTRADA
      , A.CHAVE_NFE
      , A.EMISSAO
    FROM LOJA_ENTRADAS A WITH (NOLOCK)
    WHERE A.ENTRADA_ENCERRADA = 0
      AND A.FILIAL = 'CD - SP - SAO ROQUE'
),

-- CTE 2: Pedidos transferidos (substitui a subquery IN + JOIN da CTE Z)
CTE_PedidosTransferidos AS (
    SELECT DISTINCT ISNULL(C.PEDIDO, C.ITEM_CAEDU) AS PEDIDO_TRANSFERENCIA
    FROM CTE_Entradas A
    INNER JOIN LOJA_ENTRADAS_PRODUTO B WITH (NOLOCK)
        ON B.ROMANEIO_PRODUTO = A.ROMANEIO_PRODUTO
    INNER JOIN FATURAMENTO_PROD C WITH (NOLOCK)
        ON  C.FILIAL   = A.FILIAL_ORIGEM
        AND C.NF_SAIDA = A.NUMERO_NF_TRANSFERENCIA
        AND C.SERIE_NF = A.SERIE_NF_ENTRADA
        AND C.PRODUTO  = B.PRODUTO
        AND C.COR_PRODUTO = B.COR_PRODUTO
),

-- CTE 3: Dados de transito/fornecedor (antiga subquery Z)
CTE_Transito AS (
    SELECT
        XX.PEDIDO_TRANSFERENCIA
      , CP.ERP_CUPS_SEGMENTO
      , CP.FILIAL_A_ENTREGAR
      , CP.FORNECEDOR
      , F.ERP_IMPORTADORA
      , E.PEDIDO
      , E.NOME_CLIFOR
    FROM (
        SELECT 
            CTN.NOME_CLIFOR
          , CTN.NF_ENTRADA
          , CTN.SERIE_NF_ENTRADA
          , CTN.PEDIDO_TRANSFERENCIA
          , CCF.CLIFOR
        FROM CSM_TRANSITO_NOTAS CTN WITH (NOLOCK)
        INNER JOIN CADASTRO_CLI_FOR CCF WITH (NOLOCK)
            ON CCF.NOME_CLIFOR = CTN.NOME_CLIFOR
        WHERE CTN.PEDIDO_TRANSFERENCIA IN (
            SELECT PEDIDO_TRANSFERENCIA FROM CTE_PedidosTransferidos
        )
    ) XX
    INNER JOIN ESTOQUE_PROD_ENT E WITH (NOLOCK)
        ON  E.NF_ENTRADA      = XX.NF_ENTRADA
        AND E.SERIE_NF_ENTRADA = XX.SERIE_NF_ENTRADA
        AND E.NOME_CLIFOR      = XX.NOME_CLIFOR
    INNER JOIN COMPRAS CP WITH (NOLOCK)
        ON CP.PEDIDO = E.PEDIDO
    INNER JOIN FORNECEDORES F WITH (NOLOCK)
        ON F.FORNECEDOR = CP.FORNECEDOR
    WHERE F.ERP_IMPORTADORA = 0
),

-- CTE 4: Contagem de importados por CHAVE_NFE (evita recálculo)
CTE_Importados AS (
    SELECT 
        T2.CHAVE_NFE
      , COUNT(*) AS IMPORTADOS
    FROM FATURAMENTO_PROD T1 WITH (NOLOCK)
    INNER JOIN FATURAMENTO T2 WITH (NOLOCK)
        ON  T2.NF_SAIDA  = T1.NF_SAIDA
        AND T2.SERIE_NF  = T1.SERIE_NF
        AND T2.FILIAL    = T1.FILIAL
    INNER JOIN PRODUTOS T3 WITH (NOLOCK)
        ON T3.PRODUTO = T1.PRODUTO
    INNER JOIN FORNECEDORES T4 WITH (NOLOCK)
        ON T4.FORNECEDOR = T3.FABRICANTE
    WHERE T4.ERP_IMPORTADORA = 1
    GROUP BY T2.CHAVE_NFE
),

-- CTE 5: Itens por romaneio (substitui subquery correlacionada do SELECT)
-- Rodará UMA vez e será usada via FOR JSON por romaneio no SELECT final
CTE_Itens AS (
    SELECT
        CP.ROMANEIO_PRODUTO
      , CP.FILIAL
      , CP.PRODUTO
      , CP.QTDE_ENTRADA AS QUANTIDADE
    FROM LOJA_ENTRADAS_PRODUTO CP WITH (NOLOCK)
    INNER JOIN PRODUTOS_BARRA C WITH (NOLOCK)
        ON  C.PRODUTO     = CP.PRODUTO
        AND C.COR_PRODUTO = CP.COR_PRODUTO
    INNER JOIN CTE_Entradas D
        ON  D.ROMANEIO_PRODUTO = CP.ROMANEIO_PRODUTO
        AND D.FILIAL           = CP.FILIAL
    WHERE CP.QTDE_ENTRADA > 0
)

-- Query principal
SELECT 
    RTRIM(A.ROMANEIO_PRODUTO)          AS CodigoPedido
  , RTRIM(A.NUMERO_NF_TRANSFERENCIA)   AS NotaFiscal
  , RTRIM(A.CHAVE_NFE)                 AS ChaveNfe
  , RTRIM(A.SERIE_NF_ENTRADA)          AS Serie
  , CONVERT(DATE, A.EMISSAO)           AS Emissao        -- RTRIM desnecessário em DATE
  , FN.CLIFOR                          AS CodigoFornecedorErp
  , CASE WHEN FN.CLIFOR IS NULL THEN 0 ELSE 1 END        AS ValidFornecedor
  , ISNULL(FP.PEDIDO, FP.ITEM_CAEDU)                     AS Pedido
  , CASE 
        WHEN MAX(ISNULL(TAB1.IMPORTADOS, 0)) > 0 
        THEN 'T' ELSE 'TI' 
    END                                AS TipoEntrada
  , (
        SELECT 
            RTRIM(CI.ROMANEIO_PRODUTO) AS CodigoPedido
          , RTRIM(CI.PRODUTO)          AS Produto
          , RTRIM(CI.QUANTIDADE)       AS Quantidade
          , NULL                       AS Custo
          , NULL                       AS Desconto
          , NULL                       AS ValorTotal
        FROM CTE_Itens CI
        WHERE CI.ROMANEIO_PRODUTO = A.ROMANEIO_PRODUTO
          AND CI.FILIAL           = A.FILIAL
        GROUP BY CI.ROMANEIO_PRODUTO, CI.PRODUTO, CI.QUANTIDADE
        FOR JSON PATH
    )                                  AS RecebimentoItens
  , MAX(ISNULL(TAB1.IMPORTADOS, 0))    AS IMPORTADOS
  , MAX(FP.ITEM_CAEDU)                 AS ITEM_CAEDU

FROM CTE_Entradas A
JOIN LOJA_ENTRADAS_PRODUTO P WITH (NOLOCK)
    ON  P.ROMANEIO_PRODUTO = A.ROMANEIO_PRODUTO
    AND P.FILIAL           = A.FILIAL
LEFT JOIN FATURAMENTO_PROD FP WITH (NOLOCK)
    ON  FP.FILIAL          = A.FILIAL_ORIGEM
    AND FP.NF_SAIDA        = A.NUMERO_NF_TRANSFERENCIA
    AND FP.PRODUTO         = P.PRODUTO
    AND FP.COR_PRODUTO     = P.COR_PRODUTO
LEFT JOIN CTE_Transito Z
    ON  Z.PEDIDO_TRANSFERENCIA = ISNULL(FP.ITEM_CAEDU, FP.PEDIDO)
LEFT JOIN FILIAIS F WITH (NOLOCK)
    ON  F.FILIAL = A.FILIAL_ORIGEM
LEFT JOIN CTE_Importados TAB1
    ON  TAB1.CHAVE_NFE = A.CHAVE_NFE
LEFT JOIN FORNECEDORES FN WITH (NOLOCK)
    ON  FN.FORNECEDOR = Z.NOME_CLIFOR

GROUP BY
    A.ROMANEIO_PRODUTO
  , A.EMISSAO
  , A.CHAVE_NFE
  , A.NUMERO_NF_TRANSFERENCIA
  , A.SERIE_NF_ENTRADA
  , z.FORNECEDOR
  , F.COD_FILIAL
  , A.FILIAL
  , FP.PEDIDO
  , FN.CLIFOR
  , FP.ITEM_CAEDU

ORDER BY A.EMISSAO DESC

/*
--[{"CodigoPedido":"A0148495","Produto":"62080327","Quantidade":"720"}]
[{"CodigoPedido":"A0112576","Produto":"62010775","Quantidade":"2520"}]
[{"CodigoPedido":"A0122017","Produto":"62010789","Quantidade":"2400"}]


select * from compras_produto where produto = '62080327'

select * from LOJA_ENTRADAS where romaneio_produto = 'A0122017'


select item_caedu,pedido,* from faturamento_prod where filial = 'CD BARRA VELHA' and nf_saida  = '000000881' and serie_nf='010'


select * from CSM_TRANSITO_NOTAS where PEDIDO_TRANSFERENCIA = '111286'

select * from ESTOQUE_PROD_ENT where NOME_CLIFOR='PARS INDUSTRIA E COMERCIO' and NF_ENTRADA='000002252'

select * from compras where pedido = '345430  '  

select * from compras_produto where pedido = '345430  '  

TRANSFERÊNCIA NACIONAL	16751	2	375794V	BEST	24
TRANSFERÊNCIA NACIONAL	16752	2	377117V	BEST	24
TRANSFERÊNCIA NACIONAL	16753	2	375687V	BEST	24
TRANSFERÊNCIA NACIONAL	16754	1	375670V	BEST	10
TRANSFERÊNCIA NACIONAL	16755	2	378654V	BRASIL ATIVO	24
TRANSFERÊNCIA NACIONAL	16756	2	376129V	DETRICK	24

select * from ESTOQUE_PROD_ENT where pedido = '375794V'
select * from compras where pedido = '375794V'  
select * from compras_produto where pedido = '375794V'  
select * from csm_transito_notas where nf_entrada = '000048865' and nome_clifor = 'BEST TEXTIL LTDA - 0001'
select * from faturamento_prod where pedido = '134090'     
select * from loja_entradas where NUMERO_NF_TRANSFERENCIA='000016751' and serie_nf_entrada='010' and filial_origem='cd barra velha'

*/