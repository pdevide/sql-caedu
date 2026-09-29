
SET NOCOUNT ON
DECLARE @NOTAS_TRANSITO TABLE (
    ROWNUM INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ROMANEIO_PRODUTO        CHAR(15),
    FILIAL                  VARCHAR(25),
    REGIAO                  VARCHAR(25),
    FILIAL_ORIGEM           VARCHAR(25),
    TIPO_ENTRADA_SAIDA      VARCHAR(2),
    CODIGO_TAB_PRECO        VARCHAR(2),
    NUMERO_NF_TRANSFERENCIA VARCHAR(15),
    FORNECEDOR              VARCHAR(25),
    RESPONSAVEL             VARCHAR(25),
    EMISSAO                 DATETIME,
    OBS                     VARCHAR(220),
    ENTRADA_CONFERIDA       BIT,
    ENTRADA_SEM_PRODUTOS    BIT,
    QTDE_TOTAL              INT,
    VALOR_TOTAL             NUMERIC(14, 2),
    FATOR_PRECO             NUMERIC(5, 2),
    ROMANEIO_NF_SAIDA       VARCHAR(15),
    VALOR_NAO_CONFERIDO     NUMERIC(14, 2),
    QTDE_NAO_CONFERIDA      INT,
    LIBERA_TRANSITO         BIT,
    STATUS_TRANSITO         VARCHAR(1),
    CHAVE_NFE               VARCHAR(44)
);

DECLARE @NOTAS_TRANSITO_PRODUTOS TABLE (
    grade               VARCHAR(25),
    filial              VARCHAR(25),
    romaneio_produto    VARCHAR(15),
    produto             VARCHAR(12),
    cor_produto         VARCHAR(10),
    en1  INT, en2  INT, en3  INT, en4  INT, en5  INT, en6  INT, en7  INT, en8  INT,
    en9  INT, en10 INT, en11 INT, en12 INT, en13 INT, en14 INT, en15 INT, en16 INT,
    en17 INT, en18 INT, en19 INT, en20 INT, en21 INT, en22 INT, en23 INT, en24 INT,
    en25 INT, en26 INT, en27 INT, en28 INT, en29 INT, en30 INT, en31 INT, en32 INT,
    en33 INT, en34 INT, en35 INT, en36 INT, en37 INT, en38 INT, en39 INT, en40 INT,
    en41 INT, en42 INT, en43 INT, en44 INT, en45 INT, en46 INT, en47 INT, en48 INT,
    valor               NUMERIC(14, 2),
    preco4              NUMERIC(14, 2),
    preco3              NUMERIC(14, 2),
    preco2              NUMERIC(14, 2),
    preco1              NUMERIC(14, 2),
    qtde_entrada        INT,
    cor_sortida_trocada VARCHAR(10),
    pedido_compra       VARCHAR(8),
    pedido              VARCHAR(8)
);

INSERT INTO @NOTAS_TRANSITO (
    ROMANEIO_PRODUTO,
    FILIAL,
    REGIAO,
    FILIAL_ORIGEM,
    TIPO_ENTRADA_SAIDA,
    CODIGO_TAB_PRECO,
    NUMERO_NF_TRANSFERENCIA,
    FORNECEDOR,
    RESPONSAVEL,
    EMISSAO,
    OBS,
    ENTRADA_CONFERIDA,
    ENTRADA_SEM_PRODUTOS,
    QTDE_TOTAL,
    VALOR_TOTAL,
    FATOR_PRECO,
    ROMANEIO_NF_SAIDA,
    VALOR_NAO_CONFERIDO,
    QTDE_NAO_CONFERIDA,
    LIBERA_TRANSITO,
    STATUS_TRANSITO,
    CHAVE_NFE
)
SELECT loja_entradas.romaneio_produto,
       loja_entradas.filial,
       regiao,
       loja_entradas.filial_origem,
       loja_entradas.tipo_entrada_saida,
       loja_entradas.codigo_tab_preco,
       loja_entradas.numero_nf_transferencia,
       loja_entradas.fornecedor,
       loja_entradas.responsavel,
       loja_entradas.emissao,
       loja_entradas.obs,
       loja_entradas.entrada_conferida,
       loja_entradas.entrada_sem_produtos,
       loja_entradas.qtde_total,
       loja_entradas.valor_total,
       loja_entradas.fator_preco,
       loja_entradas.romaneio_nf_saida,
       loja_entradas.valor_nao_conferido,
       loja_entradas.qtde_nao_conferida,
       CONVERT(BIT, 0) AS LIBERA_TRANSITO,
       loja_entradas_dif.status_transito,
       LOJA_ENTRADAS.CHAVE_NFE
FROM   loja_entradas
       JOIN filiais
         ON loja_entradas.filial = filiais.filial
       LEFT JOIN loja_entradas_dif
              ON loja_entradas.filial = loja_entradas_dif.filial
                 AND loja_entradas.numero_nf_transferencia =
                     loja_entradas_dif.numero_nf_transferencia
                 AND loja_entradas.filial_origem =
                     loja_entradas_dif.filial_origem
                 AND loja_entradas.romaneio_nf_saida =
                     loja_entradas_dif.romaneio_nf_saida
                 AND loja_entradas.emissao = loja_entradas_dif.emissao
                 AND loja_entradas.romaneio_produto =
                     loja_entradas_dif.romaneio_produto
WHERE  /*loja_entradas.emissao >= '20260903'
       AND loja_entradas.emissao <= '20260903'*/
       1=1
       AND filiais.matriz IN ( 'MATRIZ' )
       AND loja_entradas.entrada_conferida = 0
       AND loja_entradas.entrada_cancelada = 0
       /* verifica se é uma nota fiscal do processo de transferência entre loja vs quiosque ou quiosque vs loja do Danilo */
       AND EXISTS(SELECT 1 
                    FROM FATURAMENTO 
                    WHERE CHAVE_NFE = loja_entradas.CHAVE_NFE AND ERP_CUPS_ID_TRANSFERENCIA IS NOT NULL) 
ORDER  BY emissao ASC,
          filiais.filial 

DECLARE @ROWNUM INT,
        @TOTREG INT

SELECT @ROWNUM=MIN(ROWNUM), @TOTREG=MAX(ROWNUM) 
FROM @NOTAS_TRANSITO

DECLARE     @ROMANEIO_PRODUTO CHAR(15),
            @FILIAL VARCHAR(25),
            @COD_FILIAL VARCHAR(6),
            @PROX_SEQUENCIA INT,
            @FILIAL_ORIGEM VARCHAR(25),
            @NUMERO_NF_TRANSFERENCIA VARCHAR(15)

WHILE @ROWNUM <= @TOTREG
BEGIN

    SELECT  @ROMANEIO_PRODUTO = A.ROMANEIO_PRODUTO,
            @FILIAL = A.FILIAL,
            @COD_FILIAL = F.COD_FILIAL,
            @FILIAL_ORIGEM = a.FILIAL_ORIGEM,
            @NUMERO_NF_TRANSFERENCIA = a.NUMERO_NF_TRANSFERENCIA
    FROM @NOTAS_TRANSITO A
    INNER JOIN FILIAIS F ON F.FILIAL = A.FILIAL
    WHERE ROWNUM = @ROWNUM

    UPDATE loja_entradas
    SET    entrada_conferida = 1,
           entrada_encerrada = 1,
           status_transito = 4,
           obs = 'retirado do transito pela tela de Liberação'
    WHERE  romaneio_produto=@ROMANEIO_PRODUTO
    AND    filial =@FILIAL

    UPDATE a
    SET        a.data_para_transferencia = Getdate ()
    FROM       estoque_produtos a
    INNER JOIN loja_entradas_produto b
    ON         a.filial = b.filial
    AND        a.produto = b.produto
    AND        a.cor_produto = b.cor_produto
    INNER JOIN loja_entradas c
    ON         b.filial = c.filial
    AND        b.romaneio_produto = c.romaneio_produto
    WHERE      c.romaneio_produto = @ROMANEIO_PRODUTO
    AND        c.filial = @FILIAL
    
    
    SELECT @PROX_SEQUENCIA = MAX(SEQUENCIA)+1
    FROM LOJA_PROCESSOS 
    WHERE PROCESSO = 'LX120024 - BAIXAR TRANSITO DA LOJA'
    AND CODIGO_FILIAL = @COD_FILIAL
    

    INSERT INTO loja_processos
    (
        codigo_filial,
        sequencia,
        processo,
        comando,
        data_criacao,
        data_processo,
        erro,
        data_para_transferencia
    )
    VALUES
    (
        @COD_FILIAL,
        @PROX_SEQUENCIA,
        'LX120024 - BAIXAR TRANSITO DA LOJA',
        'UPDATE LOJA_TRANSITO SET LANCADO_LOJA = 1 WHERE FILIAL_ORIGEM = '+char(39)+@FILIAL_ORIGEM+char(39)+' AND NUMERO_NF_TRANSFERENCIA = '+char(39)+@NUMERO_NF_TRANSFERENCIA+char(39),
        GETDATE(),
        NULL,
        NULL,
        GETDATE()
    );

    SET @ROWNUM += 1
END

