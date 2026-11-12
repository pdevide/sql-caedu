USE [CAEDU]
GO

DECLARE @erro NVARCHAR(4000) = NULL;

BEGIN TRY
    BEGIN TRAN;

    DISABLE TRIGGER [dbo].[LXU_PRODUTOS] ON [dbo].[PRODUTOS];
    DISABLE TRIGGER ALL ON [dbo].[PRODUTOS_BARRA];
    DISABLE TRIGGER [dbo].[LXU_PRODUTOS_GRADE] ON [dbo].[PRODUTOS];
    -- DISABLE aqui a trigger que realmente bloqueia a grade (use a consulta acima)

    UPDATE PRODUTOS SET GRADE = '4 AO 10'
    WHERE PRODUTO = 'F0010179';

    EXEC CGP_LX_GERAR_CODIGO_BARRA 'F0010179';
    
    update a set q4=3,q5=3,q6=3,q7=3
    from PRODUTOS_PACKS_PERMITIDOS a 
    where produto = 'F0010179'

    COMMIT TRAN;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRAN;
    SET @erro = ERROR_MESSAGE();
END CATCH;

-- Sempre religa, com sucesso ou erro, já fora da transação
ENABLE TRIGGER [dbo].[LXU_PRODUTOS] ON [dbo].[PRODUTOS];
ENABLE TRIGGER ALL ON [dbo].[PRODUTOS_BARRA];
ENABLE TRIGGER [dbo].[LXU_PRODUTOS_GRADE] ON [dbo].[PRODUTOS];

-- ENABLE da(s) outra(s) trigger(s) desabilitada(s)

IF @erro IS NULL PRINT 'Atualização concluída com sucesso.';
ELSE PRINT 'Erro, rollback efetuado: ' + @erro;
GO


