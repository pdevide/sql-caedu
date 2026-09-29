--SELECT dbo.NumeroPorExtenso(123333)

CREATE OR ALTER FUNCTION dbo.NumeroPorExtenso (@nNumero DECIMAL(18, 2))
RETURNS VARCHAR(MAX)
AS
BEGIN

	/* Função auxiliar para converter números em extenso*/
	DECLARE @cResultado varchar(max)

	-- Array de Unidades
    DECLARE @aUnidades TABLE 
	(Numero INT, 
	Nome VARCHAR(20))

	-- Array de Dezenas
    DECLARE @aDezenas TABLE 
	(Numero INT, 
	Nome VARCHAR(20))

	-- Array de Centenas
	DECLARE @aCentenas TABLE 
	(Numero INT, 
	Nome VARCHAR(20))

	/*Preencher os arrays com os valores correspondentes*/
	INSERT INTO @aUnidades VALUES 
        (1, 'um'), (2, 'dois'), (3, 'tres'), (4, 'quatro'), (5, 'cinco'), 
        (6, 'seis'), (7, 'sete'), (8, 'oito'), (9, 'nove'), (10, 'dez'), 
        (11, 'onze'), (12, 'doze'), (13, 'treze'), (14, 'quatorze'), 
        (15, 'quinze'), (16, 'dezesseis'), (17, 'dezessete'), (18, 'dezoito'),(19, 'dezenove')

	INSERT INTO @aDezenas VALUES 
		(2, 'vinte'), (3, 'trinta'), (4, 'quarenta'), 
        (5, 'cinquenta'), (6, 'sessenta'), (7, 'setenta'), (8, 'oitenta'), 
        (9, 'noventa')

	INSERT INTO @aCentenas VALUES 
		(1, 'Cento'), (2, 'duzentos'), (3, 'trezentos'), 
        (4, 'quatrocentos'), (5, 'quinhentos'), (6, 'seiscentos'), 
        (7, 'setecentos'), (8, 'oitocentos'), (9, 'novecentos')

    /* Tratamento especial para 100 */
    IF @nNumero = 100
        RETURN 'cem'

    set @cResultado = ''

    /* Tratamento para milhões e bilhões */
	IF @nNumero >= 1000000000 /*bilhao*/
	begin
        declare @nParteBilhao INT
        set @nParteBilhao = FLOOR(@nNumero / 1000000000)
        IF @nParteBilhao = 1
            SET @cResultado = 'um bilhao'
        ELSE
            SET @cResultado = DBO.NumeroPorExtenso(@nParteBilhao) + ' bilhoes'
        
        set @nNumero = @nNumero % 1000000000
        IF @nNumero > 0
            set @cResultado = @cResultado + ' e '
    END

    IF @nNumero >= 1000000 /*milhao*/
	begin
        declare @nParteMilhao INT
        set @nParteMilhao = FLOOR(@nNumero / 1000000)
        IF @nParteMilhao = 1
            SET @cResultado = 'um milhao'
        ELSE
            SET @cResultado = DBO.NumeroPorExtenso(@nParteMilhao) + ' milhoes'
        
        set @nNumero = @nNumero % 1000000
        IF @nNumero > 0
            set @cResultado = @cResultado + ' e '
    END

    /* Tratamento para milhares */
    IF @nNumero >= 1000
	BEGIN
        declare @nParteMilhar INT
        SET @nParteMilhar = FLOOR(@nNumero / 1000)
        IF @nParteMilhar = 1
            SET @cResultado = @cResultado + 'mil'
        ELSE
            SET @cResultado = @cResultado + dbo.NumeroPorExtenso(@nParteMilhar) + ' mil'
        
        SET @nNumero = @nNumero % 1000

        IF @nNumero > 0
            SET @cResultado = @cResultado + ' e '
        
    END

    /* Se o número for maior ou igual a 100 */
    IF @nNumero >= 100
	BEGIN
        DECLARE @nParteCentena INT
        SET @nParteCentena = FLOOR(@nNumero / 100)
        SET @cResultado = @cResultado + 
			(select Nome from @aCentenas where Numero = @nParteCentena)

        set @nNumero = @nNumero % 100
        IF @nNumero > 0
            SET @cResultado = @cResultado + ' e '
        
    END

    /* Se o número for maior ou igual a 20 */
    IF @nNumero >= 20
	BEGIN
        DECLARE @nParteDezena INT
        SET @nParteDezena = FLOOR(@nNumero / 10)
        SET @cResultado = @cResultado + 
		(select Nome from @aDezenas where Numero = @nParteDezena)

        SET @nNumero = @nNumero % 10
        IF @nNumero > 0
            SET @cResultado = @cResultado + ' e '
        
    END

    /* Se o número for menor que 20 */
    IF @nNumero > 0
        SET @cResultado = @cResultado + 
		(select Nome from @aUnidades where Numero = @nNumero)
    

    RETURN @cResultado
END
