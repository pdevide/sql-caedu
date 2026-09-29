CREATE OR ALTER TRIGGER LXU_TRANSPORTADORAS_CNPJ
ON [dbo].[TRANSPORTADORAS]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON
    /*
    PAULO DEVIDE - 25-05-2026
    valida conteudo das coluna
    CGC
    */

    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE (dbo.fn_ValidaDocumento(i.CGC) = 0)
    )
    BEGIN
        RAISERROR('CPF ou CNPJ invalido. Operacao cancelada.', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
END
