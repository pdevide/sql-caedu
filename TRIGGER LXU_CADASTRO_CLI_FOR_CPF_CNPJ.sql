CREATE OR ALTER TRIGGER LXU_CADASTRO_CLI_FOR_CPF_CNPJ
ON [dbo].[CADASTRO_CLI_FOR]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON
    /*
    PAULO DEVIDE - 22-05-2026
    valida conteudo das colunas
    CGC_CPF
    COBRANCA_CGC
    ENTREGA_CGC
    */

    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE (dbo.fn_ValidaDocumento(i.CGC_CPF) = 0 
                or dbo.fn_ValidaDocumento(i.COBRANCA_CGC) = 0 
                or dbo.fn_ValidaDocumento(i.ENTREGA_CGC) = 0)
    )
    BEGIN
        RAISERROR('CPF ou CNPJ invalido. Operacao cancelada.', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
END
