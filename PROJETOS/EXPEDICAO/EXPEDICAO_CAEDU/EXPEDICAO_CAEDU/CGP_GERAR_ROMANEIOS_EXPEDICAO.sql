/*
PROCEDURE PARA CONFERIR E GERAR ROMANEIOS EXPEDIÇÃO
AUTOR........: PAULO EDUARDO DEVIDE	
DATA CRIAÇÃO.: 20-08-2026
OBJETIVO.....: GERAR BOX PARA AS CAIXAS NÃO ENCONTRADAS 
				DA CAEDU_RESERVA_AUTOMATICA E TAMBEM DA 
				CAEDU_RESERVA_AUTOMATICA_PACK_WMS
*/

CREATE OR ALTER PROCEDURE CGP_GERAR_ROMANEIOS_EXPEDICAO
    @CONFIRMAR VARCHAR(1) = 'N'
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DECLARE @TABCSV TABLE (
            rownum              INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
            caixa               CHAR(8) NULL,
            doca                VARCHAR(25) NULL,
            codigo_filial       CHAR(6) NULL,
            filial              VARCHAR(25) NULL,
            origem              VARCHAR(1) NULL,
            distribuicao        VARCHAR(12) NULL,
            produto             VARCHAR(12) NULL,
            lojadestino         VARCHAR(25) NULL,
            filial_origem       VARCHAR(25) NULL,
            qtde_total          INT NULL,
            qtde_pack           INT NULL,
            venda               VARCHAR(12) NULL,
            pack                CHAR(2) NULL,
            custo_1             NUMERIC(14,2) NULL,
            grade               VARCHAR(25) NULL,
            erp_qtd_pack        INT NULL,
            qtde_packs          INT NULL,
            cor_produto         CHAR(10) NULL,
            qtde                INT NULL,
            q1                  INT NULL,
            q2                  INT NULL,
            q3                  INT NULL,
            q4                  INT NULL,
            q5                  INT NULL,
            q6                  INT NULL,
            q7                  INT NULL,
            q8                  INT NULL,
            q9                  INT NULL,
            q10                 INT NULL,
            q11                 INT NULL,
            q12                 INT NULL,
            q13                 INT NULL,
            q14                 INT NULL,
            q15                 INT NULL,
            q16                 INT NULL,
            qtde_total_valor    INT NULL
        );

        INSERT INTO @TABCSV
        SELECT 
            --1 AS rownum,
            a.caixa,
            f.filial AS doca,
            f.clifor AS codigo_filial,
            a.filial,
            'W' AS origem,
            a.distribuicao AS distribuicao,
            a.produto,
            a.filial AS lojadestino,
            a.filial_origem,
            a.qtde_total,
            1 AS qtde_pack,
            a.venda,
            ppp.pack,
            pp.preco1 AS custo_1,
            grade,
            erp_qtd_pack,
            1 AS qtde_packs,
            ppp.cor_produto AS cor_produto,
            ppp.qtde,
            ppp.q1,
            ppp.q2,
            ppp.q3,
            ppp.q4,
            ppp.q5,
            ppp.q6,
            ppp.q7,
            ppp.q8,
            ppp.q9,
            ppp.q10,
            ppp.q11,
            ppp.q12,
            ppp.q13,
            ppp.q14,
            ppp.q15,
            ppp.q16,
            1 AS qtde_total_valor
        FROM caedu_reserva_automatica_pack_wms a
            --INNER JOIN compras_produto cp ON cp.pedido = a.pedido AND cp.produto = a.produto AND cp.COR_PRODUTO = a.cor_produto
            LEFT JOIN PDA_WMS_TB_EMBARQUE pda ON pda.caixa = a.CAIXA
            INNER JOIN PRODUTOS_PRECOS pp ON pp.produto = a.PRODUTO AND pp.CODIGO_TAB_PRECO = '02'
            INNER JOIN PRODUTOS P ON P.PRODUTO = a.PRODUTO
            INNER JOIN PRODUTOS_PACKS_PERMITIDOS ppp 
                ON ppp.produto = a.produto 
                --AND ppp.cor_produto = a.COR_PRODUTO 
                AND ppp.pack = a.PACK
            INNER JOIN filiais f ON f.filial = a.filial
            LEFT JOIN faturamento_prod fp ON fp.caixa = a.CAIXA
        WHERE a.caixa IN (
                SELECT x.caixa 
                FROM PDA_WMS_TB_EMBARQUE x 
                LEFT JOIN vendas_prod_embalado b ON b.caixa = x.caixa 
                WHERE x.FATURADO = 0 AND b.caixa IS NULL
            )
            AND fp.NF_SAIDA IS NULL /* Somente traz as caixas que não foram faturadas ainda */

        UNION ALL

        SELECT 
            --1 AS rownum,
            a.caixa,
            F.FILIAL AS doca,
            F.COD_FILIAL AS codigo_filial,
            F.filial,
            'P' AS origem,
            a.pedido AS distribuicao,
            a.produto,
            F.filial AS lojadestino,
            a.filial_origem,
            a.qtde_total,
            1 AS qtde_pack,
            a.venda,
            ppp.pack,
            pp.preco1 AS custo_1,
            grade,
            erp_qtd_pack,
            1 AS qtde_packs,
            a.cor_produto,
            ppp.qtde,
            ppp.q1,
            ppp.q2,
            ppp.q3,
            ppp.q4,
            ppp.q5,
            ppp.q6,
            ppp.q7,
            ppp.q8,
            ppp.q9,
            ppp.q10,
            ppp.q11,
            ppp.q12,
            ppp.q13,
            ppp.q14,
            ppp.q15,
            ppp.q16,
            1 AS qtde_total_valor
        FROM caedu_reserva_automatica a
            LEFT JOIN compras_produto cp ON cp.pedido = a.pedido AND cp.produto = a.produto AND cp.COR_PRODUTO = a.cor_produto
            LEFT JOIN PDA_WMS_TB_EMBARQUE pda ON pda.caixa = a.CAIXA
            LEFT JOIN PRODUTOS_PRECOS pp ON pp.produto = a.PRODUTO AND pp.CODIGO_TAB_PRECO = '02'
            LEFT JOIN PRODUTOS P ON P.PRODUTO = a.PRODUTO
            LEFT JOIN PRODUTOS_PACKS_PERMITIDOS ppp 
                ON ppp.produto = a.produto AND ppp.cor_produto = a.COR_PRODUTO AND ppp.pack = cp.PACKS
            LEFT JOIN FILIAIS F ON F.FILIAL = A.filial
            LEFT JOIN faturamento_prod fp ON fp.caixa = a.CAIXA
        WHERE a.caixa IN (
                SELECT x.caixa 
                FROM PDA_WMS_TB_EMBARQUE x 
                LEFT JOIN vendas_prod_embalado b ON b.caixa = x.caixa 
                WHERE x.FATURADO = 0 AND b.caixa IS NULL
            )
            AND fp.NF_SAIDA IS NULL; /* Somente traz as caixas que não foram faturadas ainda */

        /* LISTAR SOMENTE PARA CONFERIR ANTES DE GERAR */
        IF @CONFIRMAR = 'N'
        BEGIN
            SELECT * FROM @TABCSV;
            RETURN;
        END

        /* AQUI COMEÇA A ROTINA PARA GERAR OS ROMANEIOS SE @CONFIRMAR = 'S' */
        BEGIN TRANSACTION;

        DECLARE @V_PRODUTOS TABLE (
            ROWNUM INT NOT NULL IDENTITY(1,1), 
            PRODUTO VARCHAR(12) NULL, 
            COR_PRODUTO VARCHAR(10) NULL
        );

        INSERT INTO @V_PRODUTOS 
        SELECT DISTINCT produto, cor_produto 
        FROM @TABCSV 
        WHERE qtde > 0;

        DECLARE @PARAMETROS TABLE (
            TIPO_VENDA              VARCHAR(15) NULL,
            CODIGO_TAB_PRECO        VARCHAR(2),
            FRETE_PAGO              BIT,
            CTRL_MULT_ENTREGAS      BIT,
            REPRESENTANTE_PADRAO    VARCHAR(25),
            TRANSPORTADORA_PADRAO   VARCHAR(25),
            COND_PGTO_PADRAO        VARCHAR(6),
            COLECAO_PADRAO          VARCHAR(10),
            MOEDA_PADRAO            VARCHAR(6),
            TIPO_CAIXA_PADRAO       VARCHAR(2),
            TIPO_FRETE_DISTRIBUICAO VARCHAR(2),
            APROVACAO               VARCHAR(1)
        );

        INSERT INTO @PARAMETROS
        SELECT 
            ISNULL(DBO.FX_PARAMETRO_EMPRESA('TIPO_VENDA', 0), '') AS TIPO_VENDA,
            ISNULL(DBO.FX_PARAMETRO_EMPRESA('TABELA_PRECO_PADRAO', 0), '') AS CODIGO_TAB_PRECO,
            (CASE WHEN ISNULL(DBO.FX_PARAMETRO_EMPRESA('FRETE_PAGO', 0), '.F.') = '.T.' THEN 1 ELSE 0 END) AS FRETE_PAGO,
            (CASE WHEN ISNULL(DBO.FX_PARAMETRO_EMPRESA('CTRL_MULT_ENTREGAS', 0), '.F.') = '.T.' THEN 1 ELSE 0 END) AS CTRL_MULT_ENTREGAS,
            ISNULL(DBO.FX_PARAMETRO_EMPRESA('REPRESENTANTE_PADRAO', 0), '') AS REPRESENTANTE_PADRAO,
            ISNULL(DBO.FX_PARAMETRO_EMPRESA('TRANSPORTADORA_PADRAO', 0), '') AS TRANSPORTADORA_PADRAO,
            ISNULL(DBO.FX_PARAMETRO_EMPRESA('COND_PGTO_PADRAO', 0), '') AS COND_PGTO_PADRAO,
            ISNULL(RTRIM(LTRIM(DBO.FX_PARAMETRO('COLECAO_PADRAO'))), '') AS COLECAO_PADRAO,
            ISNULL(DBO.FX_PARAMETRO_EMPRESA('MOEDA_PADRAO', 0), '') AS MOEDA_PADRAO,
            ISNULL(DBO.FX_PARAMETRO_EMPRESA('TIPO_CAIXA_PADRAO', 0), '') AS TIPO_CAIXA_PADRAO,
            ISNULL(DBO.FX_PARAMETRO_EMPRESA('TIPO_FRETE_DISTRIBUICAO', 0), '') AS TIPO_FRETE_DISTRIBUICAO,
            'A' AS APROVACAO;

        DECLARE @tLogErros TABLE (
            tabela VARCHAR(100) NULL, 
            chave  VARCHAR(100) NULL, 
            msg    VARCHAR(250) NULL
        );

        DECLARE 
            @I            INT, 
            @TOT          INT, 
            @PROXIMA_SEQ  VARCHAR(6), 
            @PEDIDO       VARCHAR(12), 
            @CAIXA        VARCHAR(8);

        /* DEFINE AS VARIÁVEIS DE TRABALHO */
        DECLARE 
            @TIPO_VENDA              VARCHAR(15),
            @CODIGO_TAB_PRECO        VARCHAR(2),
            @FRETE_PAGO              BIT,
            @CTRL_MULT_ENTREGAS      BIT,
            @REPRESENTANTE_PADRAO    VARCHAR(25),
            @TRANSPORTADORA_PADRAO   VARCHAR(25),
            @COND_PGTO_PADRAO        VARCHAR(6),
            @COLECAO_PADRAO          VARCHAR(10),
            @MOEDA_PADRAO            VARCHAR(6),
            @TIPO_CAIXA_PADRAO       VARCHAR(2),
            @TIPO_FRETE_DISTRIBUICAO VARCHAR(2),
            @APROVACAO               VARCHAR(1);

        /* SETA O VALOR PADRÃO PARA AS VARIÁVEIS DE TRABALHO */
        SELECT 
            @TIPO_VENDA              = TIPO_VENDA,
            @CODIGO_TAB_PRECO        = CODIGO_TAB_PRECO,
            @FRETE_PAGO              = FRETE_PAGO,
            @CTRL_MULT_ENTREGAS      = CTRL_MULT_ENTREGAS,
            @REPRESENTANTE_PADRAO    = REPRESENTANTE_PADRAO,
            @TRANSPORTADORA_PADRAO   = TRANSPORTADORA_PADRAO,
            @COND_PGTO_PADRAO        = COND_PGTO_PADRAO,
            @COLECAO_PADRAO          = COLECAO_PADRAO,
            @MOEDA_PADRAO            = MOEDA_PADRAO,
            @TIPO_CAIXA_PADRAO       = TIPO_CAIXA_PADRAO,
            @TIPO_FRETE_DISTRIBUICAO = TIPO_FRETE_DISTRIBUICAO,
            @APROVACAO               = APROVACAO
        FROM @PARAMETROS;

        SELECT 
            @I   = MIN(ROWNUM), 
            @TOT = MAX(ROWNUM) 
        FROM @TABCSV;

        WHILE @I <= @TOT 
        BEGIN    
            SELECT 
                @PEDIDO = VENDA, 
                @CAIXA  = CAIXA
            FROM @TABCSV
            WHERE ROWNUM = @I;

            /* SE NÃO EXISTIR A VENDA, INSERE, SENÃO PULA */
            IF NOT EXISTS (SELECT 1 FROM VENDAS WHERE PEDIDO = @PEDIDO)
            BEGIN
                /* INSERE VENDAS */
                INSERT INTO VENDAS (
                    PEDIDO, 
                    COLECAO, 
                    CODIGO_TAB_PRECO,
                    TIPO, 
                    DATA_RECEBIMENTO,
                    CONDICAO_PGTO, 
                    FILIAL, 
                    CLIENTE_ATACADO,
                    TRANSPORTADORA, 
                    MOEDA, 
                    EMISSAO, 
                    DESCONTO, 
                    ENCARGO, 
                    VALOR_IPI,
                    CTRL_MULT_ENTREGAS, 
                    APROVACAO, 
                    TABELA_FILHA,
                    CADASTRAMENTO,
                    ACEITA_PECAS_PEQUENAS, 
                    ACEITA_PECAS_COM_CORTE,
                    APROVADO_POR,
                    REPRESENTANTE, 
                    GERENTE,
                    ENTREGA_CIF,
                    tipo_frete,
                    tipo_caixa,
                    FILIAL_DIGITACAO,
                    NOME_CLIFOR_ENTREGA,
                    TRANSP_REDESPACHO,
                    NATUREZA_SAIDA
                ) 
                SELECT 
                    V_CAIXAS.VENDA,
                    @COLECAO_PADRAO,
                    @CODIGO_TAB_PRECO,
                    @TIPO_VENDA,
                    CONVERT(VARCHAR, GETDATE(), 112),
                    @COND_PGTO_PADRAO,
                    V_CAIXAS.FILIAL_ORIGEM,
                    V_CAIXAS.FILIAL,
                    @TRANSPORTADORA_PADRAO,
                    @MOEDA_PADRAO,
                    CONVERT(VARCHAR, GETDATE(), 112),
                    0,
                    0,
                    0,
                    1,
                    @APROVACAO,
                    'VENDAS_PRODUTO',
                    CONVERT(VARCHAR, GETDATE(), 112),
                    100,
                    100,
                    ' ',
                    V_CAIXAS.FILIAL,
                    V_CAIXAS.FILIAL,
                    1,
                    NULL,
                    NULL,
                    'CD - SP - SAO ROQUE',
                    V_CAIXAS.FILIAL,
                    NULL, 
                    '120.01'
                FROM @TABCSV V_CAIXAS
                WHERE ROWNUM = @I;
            END /* IF NOT EXISTS (SELECT 1 FROM VENDAS WHERE PEDIDO = @PEDIDO) */

            /* SE NÃO EXISTIR FATURAMENTO_CAIXAS, INSERE, SENÃO PULA */
            IF NOT EXISTS (SELECT 1 FROM FATURAMENTO_CAIXAS WHERE CAIXA = @CAIXA)
            BEGIN
                --** FATURAMENTO_CAIXAS
                INSERT INTO FATURAMENTO_CAIXAS (
                    CAIXA,
                    NOME_CLIFOR,
                    PESO_BRUTO_CAIXA,
                    PESO_LIQUIDO_CAIXA,
                    DATA_EMBALAGEM,
                    EMBALADOR,
                    QTDE_CAIXA,
                    TIPO_CAIXA,
                    NOME_CLIFOR_ENTREGA,
                    CODIGO_LOCAL_ENTREGA
                ) 
                SELECT 
                    V_CAIXAS.caixa,
                    V_CAIXAS.filial,
                    80,
                    0,
                    CONVERT(VARCHAR, GETDATE(), 112),
                    'automatico',
                    V_CAIXAS.qtde_total,
                    '01',
                    V_CAIXAS.filial,
                    NULL 
                FROM @TABCSV V_CAIXAS
                WHERE ROWNUM = @I;
            END /* IF NOT EXISTS (SELECT 1 FROM FATURAMENTO_CAIXAS WHERE CAIXA = @CAIXA) */

            /* SE NÃO EXISTIR A VENDAS_PRODUTO, INSERE, SENÃO PULA */
            IF NOT EXISTS (SELECT 1 FROM VENDAS_PRODUTO WHERE PEDIDO = @PEDIDO)
            BEGIN
                --** VENDAS_PRODUTO
                INSERT INTO VENDAS_PRODUTO (
                    PEDIDO, PRODUTO, COR_PRODUTO, ENTREGA, LIMITE_ENTREGA, 
                    QTDE_ORIGINAL, QTDE_ENTREGAR, VALOR_ORIGINAL, VALOR_ENTREGAR, PRECO1, PRECO2, PRECO3, PRECO4, 
                    VO1, VO2, VO3, VO4, VO5, VO6, VO7, VO8, VO9, VO10, VO11, VO12, VO13, VO14, VO15, VO16, VO17, VO18, VO19, VO20, 
                    VO21, VO22, VO23, VO24, VO25, VO26, VO27, VO28, VO29, VO30, VO31, VO32, VO33, VO34, VO35, VO36, VO37, VO38, VO39, VO40, VO41, 
                    VO42, VO43, VO44, VO45, VO46, VO47, VO48, VE1, VE2, VE3, VE4, VE5, VE6, VE7, VE8, VE9, VE10, VE11, VE12, VE13, VE14, 
                    VE15, VE16, VE17, VE18, VE19, VE20, VE21, VE22, VE23, VE24, VE25, VE26, VE27, VE28, VE29, VE30, VE31, VE32, VE33, VE34, VE35, 
                    VE36, VE37, VE38, VE39, VE40, VE41, VE42, VE43, VE44, VE45, VE46, VE47, VE48, ITEM_PEDIDO
                ) 
                SELECT 
                    V_CAIXAS.VENDA, V_CAIXAS.PRODUTO, V_CAIXAS.COR_PRODUTO, CONVERT(VARCHAR, GETDATE(), 112), CONVERT(VARCHAR, GETDATE(), 112), V_CAIXAS.QTDE, 
                    V_CAIXAS.QTDE, 
                    V_CAIXAS.QTDE * V_CAIXAS.custo_1, V_CAIXAS.QTDE * V_CAIXAS.custo_1, V_CAIXAS.CUSTO_1, V_CAIXAS.CUSTO_1, V_CAIXAS.CUSTO_1, V_CAIXAS.CUSTO_1, 
                    V_CAIXAS.Q1, V_CAIXAS.Q2, V_CAIXAS.Q3, V_CAIXAS.Q4, V_CAIXAS.Q5, 
                    V_CAIXAS.Q6, V_CAIXAS.Q7, V_CAIXAS.Q8, V_CAIXAS.Q9, V_CAIXAS.Q10, 
                    V_CAIXAS.Q11, V_CAIXAS.Q12, V_CAIXAS.Q13, V_CAIXAS.Q14, V_CAIXAS.Q15, 
                    V_CAIXAS.Q16, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 
                    0, 0, 0, 
                    V_CAIXAS.Q1, V_CAIXAS.Q2, V_CAIXAS.Q3, V_CAIXAS.Q4, V_CAIXAS.Q5, 
                    V_CAIXAS.Q6, V_CAIXAS.Q7, V_CAIXAS.Q8, V_CAIXAS.Q9, V_CAIXAS.Q10, 
                    V_CAIXAS.Q11, V_CAIXAS.Q12, V_CAIXAS.Q13, V_CAIXAS.Q14, V_CAIXAS.Q15, 
                    V_CAIXAS.Q16, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 
                    0, 0, 0, 
                    '0000' 
                FROM @TABCSV V_CAIXAS
                WHERE ROWNUM = @I;
            END /* IF NOT EXISTS (SELECT 1 FROM VENDAS_PRODUTO WHERE PEDIDO = @PEDIDO) */

            IF NOT EXISTS (SELECT 1 FROM VENDAS_PROD_EMBALADO WHERE CAIXA = @CAIXA)
            BEGIN
                /* GERA NOVA SEQUENCIA E ATUALIZA A TABELA DE SEQUENCIAIS DO LINX */
                SELECT @PROXIMA_SEQ = RIGHT('000000' + CONVERT(VARCHAR(6), CAST(sequencia AS INT) + 1), 6) 
                FROM SEQUENCIAIS 
                WHERE tabela_coluna LIKE 'VENDAS_PROD_EMBALADO.ITEM';

                --** Atualiza tabela no Linx
                UPDATE SEQUENCIAIS 
                SET sequencia = @PROXIMA_SEQ 
                WHERE tabela_coluna LIKE 'VENDAS_PROD_EMBALADO.ITEM';

                INSERT INTO VENDAS_PROD_EMBALADO (
                    CAIXA_FECHADA, CAIXA,           NOME_CLIFOR,            PEDIDO,         ENTREGA,
                    ROMANEIO,      PRODUTO,         COR_PRODUTO,            QTDE_EMBALADA,
                    E1,            E2,              E3,                     E4, 
                    E5,            E6,              E7,                     E8, 
                    E9,            E10,             E11,                    E12, 
                    E13,           E14,             E15,                    E16, 
                    E17,           E18,             E19,                    E20, 
                    E21,           E22,             E23,                    E24, 
                    E25,           E26,             E27,                    E28,
                    E29,           E30,             E31,                    E32,
                    E33,           E34,             E35,                    E36, 
                    E37,           E38,             E39,                    E40, 
                    E41,           E42,             E43,                    E44, 
                    E45,           E46,             E47,                    E48, 
                    ITEM,          PRECO1,          VALOR_EMBALADO,         FILIAL,
                    PEDIDO_PRODUTO,PEDIDO_COR_PRODUTO, ORIGEM,                  MATA_SALDO,
                    ITEM_PEDIDO,   representante
                ) 
                SELECT 
                    1,
                    V_CAIXAS.caixa, V_CAIXAS.FILIAL, V_CAIXAS.VENDA, CONVERT(VARCHAR, GETDATE(), 112), NULL, V_CAIXAS.produto, V_CAIXAS.cor_produto, V_CAIXAS.qtde,
                    V_CAIXAS.Q1, V_CAIXAS.Q2, V_CAIXAS.Q3, V_CAIXAS.Q4, V_CAIXAS.Q5, V_CAIXAS.Q6, V_CAIXAS.Q7, V_CAIXAS.Q8, V_CAIXAS.Q9, V_CAIXAS.Q10, 
                    V_CAIXAS.Q11, V_CAIXAS.Q12, V_CAIXAS.Q13, V_CAIXAS.Q14, V_CAIXAS.Q15, V_CAIXAS.Q16, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                    0, 0, 0, 0, 0, 0, 0, 0, 
                    @PROXIMA_SEQ, V_CAIXAS.CUSTO_1, V_CAIXAS.CUSTO_1 * V_CAIXAS.qtde, V_CAIXAS.filial_origem,
                    V_CAIXAS.produto, V_CAIXAS.cor_produto, 'S', 0, '0000', V_CAIXAS.FILIAL 
                FROM @TABCSV V_CAIXAS
                WHERE ROWNUM = @I;
            END /* IF NOT EXISTS (SELECT 1 FROM VENDAS_PROD_EMBALADO WHERE CAIXA = @CAIXA) */

            UPDATE a 
            SET 
                TOT_VALOR_ENTREGAR = (TOT_VALOR_ENTREGAR + b.valor_original), 
                TOT_VALOR_ORIGINAL = (TOT_VALOR_ORIGINAL + b.valor_original),
                TOT_QTDE_ENTREGAR  = (TOT_QTDE_ENTREGAR + b.qtde_original), 
                TOT_QTDE_ORIGINAL  = (TOT_QTDE_ORIGINAL + b.qtde_original), 
                VALOR_SUB_ITENS    = (VALOR_SUB_ITENS + b.valor_original) 
            FROM vendas a 
                INNER JOIN vendas_produto b ON b.pedido = a.pedido 
            WHERE a.pedido = @PEDIDO;

            /* VAI PARA A PRÓXIMA CAIXA */
            SET @I += 1;
        END

        -- Confirma todas as alterações caso tudo ocorra sem erros
        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        -- Desfaz as alterações caso algum erro ocorra dentro do bloco TRANSACTION
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Captura os dados do erro para exibição/diagnóstico
        DECLARE 
            @ErrorMessage  NVARCHAR(4000) = ERROR_MESSAGE(),
            @ErrorSeverity INT           = ERROR_SEVERITY(),
            @ErrorState    INT           = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO