-- ============================================================
-- Função: dbo.fn_ValidaDocumento
-- Valida CPF, CNPJ numérico (legado) e CNPJ alfanumérico (novo)
-- Retorna: 1 = válido | 0 = inválido
-- Compatível com SQL Server 2016+
-- ============================================================

CREATE OR ALTER FUNCTION dbo.fn_ValidaDocumento
(
    @documento VARCHAR(20)
)
RETURNS BIT
AS
BEGIN

    -- --------------------------------------------------------
    -- Normalização: remove pontuação e espaços
    -- --------------------------------------------------------
    DECLARE @doc VARCHAR(20)

    SET @doc = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                    UPPER(LTRIM(RTRIM(@documento))),
               '.', ''), '-', ''), '/', ''), ' ', ''), '_', '')

    -- Descarta nulos e vazios
    IF @doc IS NULL OR LEN(@doc) = 0
        RETURN 0

    -- --------------------------------------------------------
    -- Roteamento por tamanho e conteúdo
    -- --------------------------------------------------------
    -- CPF  = 11 caracteres totalmente numéricos
    -- CNPJ = 14 caracteres (numérico legado ou alfanumérico)
    -- --------------------------------------------------------

    IF LEN(@doc) = 11 AND @doc NOT LIKE '%[^0-9]%'
        RETURN dbo.fn_ValidaCPF(@doc)

    IF LEN(@doc) = 14
        RETURN dbo.fn_ValidaCNPJ(@doc)

    RETURN 0

END
GO


-- ============================================================
-- Função auxiliar: dbo.fn_ValidaCPF
-- Espera 11 dígitos numéricos sem formatação
-- ============================================================

CREATE OR ALTER FUNCTION dbo.fn_ValidaCPF
(
    @cpf VARCHAR(11)
)
RETURNS BIT
AS
BEGIN

    -- Rejeita sequências iguais (ex: 000.000.000-00, 111.111.111-11)
    IF @cpf IN (
        '00000000000','11111111111','22222222222','33333333333',
        '44444444444','55555555555','66666666666','77777777777',
        '88888888888','99999999999'
    )
        RETURN 0

    DECLARE @i   INT = 1
    DECLARE @sum INT = 0
    DECLARE @dv1 INT
    DECLARE @dv2 INT
    DECLARE @resto INT

    -- 1º dígito verificador
    SET @sum = 0
    SET @i   = 1
    WHILE @i <= 9
    BEGIN
        SET @sum = @sum + CAST(SUBSTRING(@cpf, @i, 1) AS INT) * (11 - @i)
        SET @i = @i + 1
    END

    SET @resto = @sum % 11
    SET @dv1   = CASE WHEN @resto < 2 THEN 0 ELSE 11 - @resto END

    IF @dv1 <> CAST(SUBSTRING(@cpf, 10, 1) AS INT)
        RETURN 0

    -- 2º dígito verificador
    SET @sum = 0
    SET @i   = 1
    WHILE @i <= 10
    BEGIN
        SET @sum = @sum + CAST(SUBSTRING(@cpf, @i, 1) AS INT) * (12 - @i)
        SET @i = @i + 1
    END

    SET @resto = @sum % 11
    SET @dv2   = CASE WHEN @resto < 2 THEN 0 ELSE 11 - @resto END

    IF @dv2 <> CAST(SUBSTRING(@cpf, 11, 1) AS INT)
        RETURN 0

    RETURN 1

END
GO


-- ============================================================
-- Função auxiliar: dbo.fn_ValidaCNPJ
-- Valida CNPJ numérico legado E alfanumérico (SERPRO)
-- Espera 14 caracteres sem formatação, em maiúsculas
-- ============================================================

CREATE OR ALTER FUNCTION dbo.fn_ValidaCNPJ
(
    @cnpj VARCHAR(14)
)
RETURNS BIT
AS
BEGIN

    -- Rejeita sequências iguais apenas para CNPJ puramente numérico
    IF @cnpj NOT LIKE '%[^0-9]%'
    BEGIN
        IF @cnpj IN (
            '00000000000000','11111111111111','22222222222222',
            '33333333333333','44444444444444','55555555555555',
            '66666666666666','77777777777777','88888888888888',
            '99999999999999'
        )
            RETURN 0
    END

    -- Valida que os 2 últimos chars (DVs) são numéricos
    IF SUBSTRING(@cnpj, 13, 1) LIKE '[^0-9]' OR
       SUBSTRING(@cnpj, 14, 1) LIKE '[^0-9]'
        RETURN 0

    -- --------------------------------------------------------
    -- Converte cada caractere para seu valor numérico:
    -- '0'-'9' → ASCII - 48
    -- 'A'-'Z' → ASCII - 48  (A=17, B=18 ... conforme tabela SERPRO)
    -- --------------------------------------------------------
    DECLARE @valores TABLE (pos INT, val INT)

    INSERT INTO @valores (pos, val)
    SELECT
        n.pos,
        ASCII(SUBSTRING(@cnpj, n.pos, 1)) - 48  -- regra SERPRO
    FROM (VALUES
         (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13)
    ) AS n(pos)

    -- --------------------------------------------------------
    -- 1º DV — pesos distribuídos da direita p/ esquerda (2-9)
    -- sobre os 12 primeiros caracteres
    -- Posição:  1  2  3  4  5  6  7  8  9 10 11 12
    -- Peso:     5  4  3  2  9  8  7  6  5  4  3  2
    -- --------------------------------------------------------
    DECLARE @pesos1 TABLE (pos INT, peso INT)
    INSERT INTO @pesos1 (pos, peso) VALUES
        (1,5),(2,4),(3,3),(4,2),(5,9),(6,8),
        (7,7),(8,6),(9,5),(10,4),(11,3),(12,2)

    DECLARE @soma1 INT = 0

    SELECT @soma1 = SUM(v.val * p.peso)
    FROM @valores v
    INNER JOIN @pesos1 p ON p.pos = v.pos

    DECLARE @resto1 INT = @soma1 % 11
    DECLARE @dv1    INT = CASE WHEN @resto1 <= 1 THEN 0 ELSE 11 - @resto1 END

    -- Confere 1º DV (posição 13)
    IF @dv1 <> (SELECT val FROM @valores WHERE pos = 13)
        RETURN 0

    -- --------------------------------------------------------
    -- 2º DV — inclui o 1º DV (13 caracteres no total)
    -- Posição:  1  2  3  4  5  6  7  8  9 10 11 12 13
    -- Peso:     6  5  4  3  2  9  8  7  6  5  4  3  2
    -- --------------------------------------------------------
    DECLARE @pesos2 TABLE (pos INT, peso INT)
    INSERT INTO @pesos2 (pos, peso) VALUES
        (1,6),(2,5),(3,4),(4,3),(5,2),(6,9),
        (7,8),(8,7),(9,6),(10,5),(11,4),(12,3),(13,2)

    DECLARE @soma2 INT = 0

    SELECT @soma2 = SUM(v.val * p.peso)
    FROM @valores v
    INNER JOIN @pesos2 p ON p.pos = v.pos

    DECLARE @resto2 INT = @soma2 % 11
    DECLARE @dv2    INT = CASE WHEN @resto2 <= 1 THEN 0 ELSE 11 - @resto2 END

    -- Confere 2º DV (posição 14)
    DECLARE @dv2_doc INT = ASCII(SUBSTRING(@cnpj, 14, 1)) - 48
    IF @dv2 <> @dv2_doc
        RETURN 0

    RETURN 1

END
GO

