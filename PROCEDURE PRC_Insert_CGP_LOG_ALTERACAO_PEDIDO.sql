/*
IF OBJECT_ID('dbo.CGP_LOG_ALTERACAO_PEDIDO', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.CGP_LOG_ALTERACAO_PEDIDO;
    
    CREATE TABLE dbo.CGP_LOG_ALTERACAO_PEDIDO
    (
        ID              INT IDENTITY(1,1) PRIMARY KEY,
        PEDIDO          VARCHAR(8)   NULL,
        CAMPO           VARCHAR(100) NULL,
        VALOR_ANTERIOR  VARCHAR(200) NULL,
        VALOR_NOVO      VARCHAR(200) NULL,
        USUARIO         VARCHAR(100) NULL,
        DATA_HORA       DATETIME2(0) NOT NULL,
        ARQUIVO_ORIGEM  VARCHAR(200) NULL
    )
END
GO
*/

CREATE OR ALTER PROCEDURE dbo.PRC_INSERT_CGP_LOG_ALTERACAO_PEDIDO
(
    @PEDIDO         VARCHAR(8),
    @CAMPO          VARCHAR(100),
    @VALOR_ANTERIOR VARCHAR(200) = NULL,
    @VALOR_NOVO     VARCHAR(200) = NULL,
    @USUARIO        VARCHAR(100) = NULL,
    @ARQUIVO_ORIGEM VARCHAR(200) = NULL
)
AS
BEGIN
    /*
    AUTOR....: PAULO DEVIDE
    CRIADO EM: 10-08-2026
    OBJETIVO.: ATUALIZAR CAMPOS ESPECÍFICOS DO PEDIDO DE COMPRAS E REGISTRAR EM LOG QUEM FEZ A 
                ALTERAÇÃO E QUANDO FEZ
    */
    SET NOCOUNT ON;

    -- Validação de parâmetros obrigatórios antes de iniciar a transação
    IF @PEDIDO IS NULL OR @CAMPO IS NULL
    BEGIN
        RAISERROR('Os parâmetros @PEDIDO e @CAMPO são obrigatórios.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        -- Início da transação explícita
        BEGIN TRANSACTION;

        /* 1. Registra o log */
        INSERT INTO dbo.CGP_LOG_ALTERACAO_PEDIDO
        (
            PEDIDO,
            CAMPO,
            VALOR_ANTERIOR,
            VALOR_NOVO,
            USUARIO,
            DATA_HORA,
            ARQUIVO_ORIGEM
        )
        VALUES
        (
            @PEDIDO,
            @CAMPO,
            @VALOR_ANTERIOR,
            @VALOR_NOVO,
            @USUARIO,
            SYSDATETIME(),
            @ARQUIVO_ORIGEM
        );

        /* 2. Executa as atualizações condicionais */
        IF @CAMPO = 'TIPO_COMPRA'
        BEGIN
            UPDATE COMPRAS
               SET TIPO_COMPRA = RTRIM(LTRIM(@VALOR_NOVO)), 
                   DATA_PARA_TRANSFERENCIA = GETDATE()
             WHERE PEDIDO = @PEDIDO;
        END

        IF @CAMPO = 'ERP_MES_NA_LOJA'
        BEGIN
            UPDATE COMPRAS
               SET ERP_MES_NA_LOJA = RTRIM(LTRIM(@VALOR_NOVO)), 
                   DATA_PARA_TRANSFERENCIA = GETDATE()
             WHERE PEDIDO = @PEDIDO;
        END

        IF @CAMPO = 'CLUSTER_UNOUS'
        BEGIN
            UPDATE PROP_COMPRAS
               SET VALOR_PROPRIEDADE = RTRIM(LTRIM(@VALOR_NOVO)), 
                   DATA_PARA_TRANSFERENCIA = GETDATE()
             WHERE PEDIDO = @PEDIDO 
               AND PROPRIEDADE = '00120';

            UPDATE COMPRAS
               SET DATA_PARA_TRANSFERENCIA = GETDATE(), 
                   ERP_UNOUS_DATA_ENVIO = NULL
             WHERE PEDIDO = @PEDIDO;
        END

        -- Confirma a transação se todas as operações forem bem-sucedidas
        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        -- Se houver uma transação ativa/com erro, faz o rollback total
        IF XACT_STATE() <> 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;

        -- Re-lança o erro original com a pilha de execução
        THROW;
    END CATCH;
END;
GO