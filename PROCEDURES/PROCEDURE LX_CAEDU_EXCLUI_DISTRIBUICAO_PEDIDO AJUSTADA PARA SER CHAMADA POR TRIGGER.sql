USE [CAEDU]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[LX_CAEDU_EXCLUI_DISTRIBUICAO_PEDIDO] 
    @PEDIDO CHAR(12) -- Ajustado de VARCHAR(8) para CHAR(12)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IGNORA_INTEGRACAO VARCHAR(3);
    DECLARE @ROMANEIO_PRODUTO CHAR(8) = '';
    DECLARE @OrigemPedido INT;

    ------------------------------------------------------------------
    -- 1. VALIDAÇÕES PRÉVIAS (Sem abrir transação ainda)
    ------------------------------------------------------------------
    SELECT @IGNORA_INTEGRACAO = RTRIM(LTRIM(VALOR_ATUAL)) 
    FROM dbo.parametros WITH (NOLOCK) 
    WHERE parametro = 'PALMA_IGNORA_INTEGR_PDA';

    /* Se a distribuição ainda não foi integrada na PDA, não permite excluir */
    IF @IGNORA_INTEGRACAO = '.F.'
    BEGIN
        IF NOT EXISTS (
            SELECT 1 
            FROM dbo.CGP_PDA_WMS_STATUS_DISTRIBUICAO WITH (NOLOCK) 
            WHERE DISTRIBUICAO = @PEDIDO
        )
        BEGIN
            RAISERROR ('Erro: Não foi possível a exclusão da distribuição, pois ela não foi integrada na PDA.', 16, 1); 
            RETURN -1;
        END
    END;

    /* Se STATUS da distribuição for diferente de 1, não permite excluir */
    IF EXISTS (
        SELECT 1 
        FROM dbo.CGP_PDA_WMS_STATUS_DISTRIBUICAO WITH (NOLOCK) 
        WHERE DISTRIBUICAO = @PEDIDO AND ISNULL(STATUS_PDA, 1) <> 1
    )
    BEGIN
        RAISERROR ('Erro: STATUS PDA não permitido para excluir a distribuição.', 16, 1); 
        RETURN -1;
    END;

    /* Se a distribuição não existe, aborta o processo */
    IF NOT EXISTS (
        SELECT 1 
        FROM dbo.caedu_reserva_automatica WITH (NOLOCK) 
        WHERE pedido = @PEDIDO
    )
    BEGIN
        RAISERROR ('Erro: Distribuição não existe.', 16, 1); 
        RETURN -1;
    END;

    /* Verifica se o pedido já foi faturado */
    IF EXISTS (
        SELECT 1 
        FROM dbo.faturamento_prod fp WITH (NOLOCK)
        INNER JOIN dbo.caedu_reserva_automatica cra WITH (NOLOCK) ON fp.CAIXA = cra.caixa
        WHERE cra.pedido = @PEDIDO
    )
    BEGIN
        RAISERROR ('Erro: Pedido já faturado. Não foi possível a exclusão da distribuição.', 16, 1); 
        RETURN -1;
    END;

    ------------------------------------------------------------------
    -- 2. COLETA DE DADOS AUXILIARES
    ------------------------------------------------------------------
    SELECT DISTINCT @ROMANEIO_PRODUTO = ISNULL(ROMANEIO_PRODUTO, '') 
    FROM dbo.CAEDU_RESERVA_AUTOMATICA WITH (NOLOCK) 
    WHERE PEDIDO = @PEDIDO;

    SELECT @OrigemPedido = 
        CASE WHEN FILIAL_A_ENTREGAR IN (
            'CD BARRA VELHA', 'CD NAVEGANTES', 'NAVEGANTES CQ',
            'VENDA ATACADO BARRA VELHA', 'VENDA ATACADO SC'
        ) THEN 2 ELSE 1 END
    FROM dbo.COMPRAS WITH (NOLOCK)
    WHERE PEDIDO = @PEDIDO;

    ------------------------------------------------------------------
    -- 3. EXCLUSÃO (Gerenciamento de Savepoint para Triggers)
    ------------------------------------------------------------------
    -- Detecta se já existe transação aberta (ex: chamada via Trigger)
    DECLARE @InTran BIT = CASE WHEN @@TRANCOUNT > 0 THEN 1 ELSE 0 END;

    IF @InTran = 1
        SAVE TRANSACTION Savepoint_ExcluiDistribuicao;
    ELSE
        BEGIN TRANSACTION EXCLUI_DISTRIBUICAO;

    BEGIN TRY

        /* EXCLUI VENDAS_PROD_EMBALADO usando JOIN */
        DELETE vpe
        FROM dbo.VENDAS_PROD_EMBALADO vpe
        INNER JOIN dbo.caedu_reserva_automatica cra ON cra.venda = vpe.PEDIDO
        WHERE cra.pedido = @PEDIDO;

        /* EXCLUI VENDAS_PRODUTO usando JOIN */
        DELETE vp
        FROM dbo.VENDAS_PRODUTO vp
        INNER JOIN dbo.caedu_reserva_automatica cra ON cra.venda = vp.PEDIDO
        WHERE cra.pedido = @PEDIDO;

        /* EXCLUI FATURAMENTO_CAIXAS usando JOIN */
        DELETE fc
        FROM dbo.FATURAMENTO_CAIXAS fc
        INNER JOIN dbo.caedu_reserva_automatica cra ON cra.CAIXA = fc.CAIXA
        WHERE cra.pedido = @PEDIDO;

        /* Guarda os dados da distribuição excluída */
        EXEC dbo.CGP_GUARDA_LOG_DISTRIBUICAO_EXCLUIDA @OrigemPedido, @PEDIDO;

        /* Atualiza os pedidos de Venda para status REPROVADO */
        UPDATE v 
        SET v.APROVACAO = 'R',
            v.OBS_TRANSPORTE = 'DISTRIBUICAO EXCLUIDA PERTENCE AO PEDIDO ' + @PEDIDO
        FROM dbo.caedu_reserva_automatica a
        INNER JOIN dbo.vendas v ON v.PEDIDO = a.venda
        WHERE a.pedido = @PEDIDO;

        /* Exclui a distribuição */
        DELETE FROM dbo.caedu_reserva_automatica 
        WHERE pedido = @PEDIDO;

        /* Atualiza/Insere status na PDA */
        IF EXISTS (
            SELECT 1 
            FROM dbo.CGP_PDA_WMS_STATUS_DISTRIBUICAO 
            WHERE DISTRIBUICAO = @PEDIDO
        )
        BEGIN
            UPDATE dbo.CGP_PDA_WMS_STATUS_DISTRIBUICAO 
            SET STATUS_LINX = 13, 
                DATA_STATUS_LINX = GETDATE(), 
                DATA_PROCESSAMENTO = NULL
            WHERE DISTRIBUICAO = @PEDIDO;
        END
        ELSE
        BEGIN
            INSERT INTO dbo.CGP_PDA_WMS_STATUS_DISTRIBUICAO (
                ORIGEM, DISTRIBUICAO, STATUS_LINX, DATA_STATUS_LINX, DATA_PROCESSAMENTO
            )
            VALUES (
                @OrigemPedido, @PEDIDO, 13, GETDATE(), NULL
            );
        END;

        -- Conclui transação apenas se ela foi criada exclusivamente nesta procedure
        IF @InTran = 0
            COMMIT TRANSACTION EXCLUI_DISTRIBUICAO;

        RETURN 0;

    END TRY
    BEGIN CATCH
        -- Em caso de erro, desfaz apenas o Savepoint se estava dentro de trigger/transação externa
        IF @InTran = 1
            ROLLBACK TRANSACTION Savepoint_ExcluiDistribuicao;
        ELSE
            ROLLBACK TRANSACTION EXCLUI_DISTRIBUICAO;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        RETURN -1;
    END CATCH;
END;
GO