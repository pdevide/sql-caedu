USE [CAEDU]
GO

BEGIN TRAN;

-- 1. Desabilita as triggers principal e da tabela filha
DISABLE TRIGGER [dbo].[LXU_PRODUTOS] ON [dbo].[PRODUTOS];
DISABLE TRIGGER [dbo].[LXU_PRODUTOS_BARRA] ON [dbo].[PRODUTOS_BARRA];

BEGIN TRY
    -- 2. Realiza a correção dos atributos comerciais e integração
    -- coloque aqui o UPDATE que vai ser feito - com a trigger desabilitada
    /*
    UPDATE PRODUTOS 
    SET ENVIA_LOJA_VAREJO = 1, 
        ENVIA_VAREJO_INTERNET = 1, 
        ERP_CUPS_SEGMENTO = '000155'
    WHERE PRODUTO = 'F0010224';
    */

    UPDATE PRODUTOS SET GRADE = '4 AO 10' 
    WHERE PRODUTO = 'F0010179';

    EXEC CGP_LX_GERAR_CODIGO_BARRA 'F0010179';

    
    -- 3. Religamento obrigatório das triggers antes de efetivar
    ENABLE TRIGGER [dbo].[LXU_PRODUTOS] ON [dbo].[PRODUTOS];
    ENABLE TRIGGER [dbo].[LXU_PRODUTOS_BARRA] ON [dbo].[PRODUTOS_BARRA];
    
    COMMIT TRAN;
    PRINT 'Atualização e religamento concluídos com sucesso.';
END TRY
BEGIN CATCH
    -- 4. Em caso de falha, força o religamento antes do rollback
    ENABLE TRIGGER [dbo].[LXU_PRODUTOS] ON [dbo].[PRODUTOS];
    ENABLE TRIGGER [dbo].[LXU_PRODUTOS_BARRA] ON [dbo].[PRODUTOS_BARRA];
    
    ROLLBACK TRAN;
    PRINT 'Erro. Triggers religadas e rollback efetuado: ' + ERROR_MESSAGE();
END CATCH
GO

