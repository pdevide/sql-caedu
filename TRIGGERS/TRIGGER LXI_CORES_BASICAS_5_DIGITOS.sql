CREATE OR ALTER TRIGGER LXI_CORES_BASICAS_5_DIGITOS
ON dbo.cores_basicas
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    declare @cor varchar(10)
    select @cor = RTRIM(LTRIM(cor)) from inserted

    -- 1) Validação: somente números e exatamente 5 caracteres
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE
            -- Tamanho diferente de 5
            LEN(RTRIM(LTRIM(i.COR))) <> 5
            OR
            -- Contém algo que não seja dígito
            RTRIM(LTRIM(i.COR)) LIKE '%[^0-9]%'
    )
    BEGIN
        declare @msg varchar(200)
        set @msg = 'Código da COR ' + @cor + ' invalido! Deve conter exatamente 5 dígitos numéricos (00000 a 99999).Complete com zeros a esquerda!'

        RAISERROR(@msg, 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

END;
GO