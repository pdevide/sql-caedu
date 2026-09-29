CREATE or ALTER PROCEDURE CGP_BAIXA_TRANSITO_AUTOMATICO_NOTAS_QUIOSQUE
/*
PAULO DEVIDE
CRIAÇÃO: 03-09-2026
FINALIDADE: VARRER NOTAS FISCAIS DO PROCESSO DE TRANSFERENCIA ENTRE LOJAS E QUIOSQUES 
            E BAIXAR O TRANSITO DAS NOTAS FISCAIS AUTORIZADAS AUTOMATICAMENTE, 
            SEM A NECESSIDADE DE BAIXAR PELA TELA DO LINX
            
*/
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON; -- Garante rollback automático em erros críticos de execução

    BEGIN TRY
        -- 1. Declaração das tabelas temporárias
        DECLARE @NOTAS_TRANSITO TABLE (
            ROWNUM                  INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
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

        -- 2. Carga Inicial dos Dados
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
                        AND loja_entradas.numero_nf_transferencia = loja_entradas_dif.numero_nf_transferencia
                        AND loja_entradas.filial_origem = loja_entradas_dif.filial_origem
                        AND loja_entradas.romaneio_nf_saida = loja_entradas_dif.romaneio_nf_saida
                        AND loja_entradas.emissao = loja_entradas_dif.emissao
                        AND loja_entradas.romaneio_produto = loja_entradas_dif.romaneio_produto
        WHERE  filiais.matriz IN ( 'MATRIZ' )
               AND loja_entradas.entrada_conferida = 0
               AND loja_entradas.entrada_cancelada = 0
               /*Filtra somente as notas deste processo de tranferencia Quiosque vs Lojas*/
               AND EXISTS(SELECT 1 
                          FROM FATURAMENTO 
                          WHERE CHAVE_NFE = loja_entradas.CHAVE_NFE 
                            AND ERP_CUPS_ID_TRANSFERENCIA IS NOT NULL) 
        ORDER BY emissao ASC, filiais.filial;

        -- 3. Variáveis de Controle do Loop
        DECLARE @ROWNUM INT,
                @TOTREG INT;

        SELECT @ROWNUM = MIN(ROWNUM), @TOTREG = MAX(ROWNUM) 
        FROM @NOTAS_TRANSITO;

        DECLARE @ROMANEIO_PRODUTO        CHAR(15),
                @FILIAL                  VARCHAR(25),
                @COD_FILIAL              VARCHAR(6),
                @PROX_SEQUENCIA          INT,
                @FILIAL_ORIGEM           VARCHAR(25),
                @NUMERO_NF_TRANSFERENCIA VARCHAR(15);

        -- 4. Início da Transação
        BEGIN TRANSACTION;

        WHILE @ROWNUM <= @TOTREG
        BEGIN
            SELECT  @ROMANEIO_PRODUTO        = A.ROMANEIO_PRODUTO,
                    @FILIAL                  = A.FILIAL,
                    @COD_FILIAL              = F.COD_FILIAL,
                    @FILIAL_ORIGEM           = A.FILIAL_ORIGEM,
                    @NUMERO_NF_TRANSFERENCIA = A.NUMERO_NF_TRANSFERENCIA
            FROM @NOTAS_TRANSITO A
            INNER JOIN FILIAIS F ON F.FILIAL = A.FILIAL
            WHERE ROWNUM = @ROWNUM;

            -- Atualiza Entrada
            UPDATE loja_entradas
            SET    entrada_conferida = 1,
                   entrada_encerrada = 1,
                   status_transito   = 4,
                   obs               = 'retirado do transito pela tela de Liberação'
            WHERE  romaneio_produto  = @ROMANEIO_PRODUTO
            AND    filial            = @FILIAL;

            -- Atualiza Data para Transferencia do Estoque
            UPDATE a
            SET    a.data_para_transferencia = GETDATE()
            FROM   estoque_produtos a
            INNER JOIN loja_entradas_produto b
                    ON a.filial = b.filial
                   AND a.produto = b.produto
                   AND a.cor_produto = b.cor_produto
            INNER JOIN loja_entradas c
                    ON b.filial = c.filial
                   AND b.romaneio_produto = c.romaneio_produto
            WHERE  c.romaneio_produto = @ROMANEIO_PRODUTO
            AND    c.filial           = @FILIAL;

            -- Obtém Próxima Sequência (Tratamento para NULL via ISNULL)
            SELECT @PROX_SEQUENCIA = ISNULL(MAX(SEQUENCIA), 0) + 1
            FROM LOJA_PROCESSOS 
            WHERE PROCESSO = 'LX120024 - BAIXAR TRANSITO DA LOJA'
            AND CODIGO_FILIAL = @COD_FILIAL;

            -- Insere Histórico no Processo
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
                'UPDATE LOJA_TRANSITO SET LANCADO_LOJA = 1 WHERE FILIAL_ORIGEM = ''' + @FILIAL_ORIGEM + ''' AND NUMERO_NF_TRANSFERENCIA = ''' + @NUMERO_NF_TRANSFERENCIA + '''',
                GETDATE(),
                NULL,
                NULL,
                GETDATE()
            );

            SET @ROWNUM += 1;
        END

        -- Finaliza a transação com sucesso
        COMMIT TRANSACTION;

        -- Retorno com Sucesso para a Aplicação
        SELECT 
            1 AS StatusExecucao,
            'Processamento concluído com sucesso.' AS Mensagem,
            ISNULL(@TOTREG, 0) AS TotalRegistrosProcessados;

    END TRY
    BEGIN CATCH
        -- Desfaz alterações em caso de erro
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Captura dos Detalhes do Erro
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(),
                @ErrorSeverity INT           = ERROR_SEVERITY(),
                @ErrorState INT              = ERROR_STATE(),
                @ErrorNumber INT             = ERROR_NUMBER(),
                @ErrorLine INT               = ERROR_LINE();

        -- Retorno em Dataset para Aplicação (OPÇÃO 1)
        SELECT 
            0 AS StatusExecucao,
            @ErrorMessage AS Mensagem,
            @ErrorNumber AS CodigoErro,
            @ErrorLine AS LinhaErro;

        -- Lança o Erro Nativo para a Aplicação/Driver capturar via Exceção (OPÇÃO 2)
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END