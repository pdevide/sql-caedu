
CREATE OR ALTER TRIGGER LXI_CADASTRO_CLI_FOR_ValidaCaracteres
ON CADASTRO_CLI_FOR
AFTER INSERT
AS
BEGIN
/*
PAULO DEVIDE
DATA CRIAÇÃO: 15-06-2026
*/
    SET NOCOUNT ON;

    DECLARE @PADRAO VARCHAR(100) = '%[^A-Za-z0-9._ /&-]%';

    -- Verifica se algum registro inserido possui caracteres inválidos
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE PATINDEX(@PADRAO, LTRIM(RTRIM(NOME_CLIFOR))   COLLATE Latin1_General_BIN) > 0
           OR PATINDEX(@PADRAO, LTRIM(RTRIM(RAZAO_SOCIAL))  COLLATE Latin1_General_BIN) > 0
    )
    BEGIN
        ROLLBACK TRANSACTION;

        RAISERROR(
            'INSERT bloqueado: NOME_CLIFOR ou RAZAO_SOCIAL contém caracteres especiais não permitidos.',
            16, -- Severity
            1   -- State
        );
    END
END;
GO