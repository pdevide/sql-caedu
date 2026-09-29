/*
SELECT dbo.ValorPorExtenso(123333.87)
select dbo.NumeroPorExtenso(13456)

*/


CREATE OR alter FUNCTION dbo.ValorPorExtenso (@nValor DECIMAL(18, 2))
RETURNS VARCHAR(MAX)
AS
BEGIN

    declare		@cExtenso varchar(max), 
				@nInteiro int, 
				@nDecimal int

    /* Separar parte inteira e decimal do valor */
    SET @nInteiro = FLOOR(@nValor)
    SET @nDecimal = ROUND((@nValor - @nInteiro) * 100, 0)

    /* Converter parte inteira por extenso */
    SELECT @cExtenso = dbo.NumeroPorExtenso(@nInteiro) + ' real'
    IF @nInteiro > 1
	begin
        select @cExtenso = dbo.NumeroPorExtenso(@nInteiro) + ' reais'
    end

    /* Se houver parte decimal, adiciona os centavos */
    IF @nDecimal > 0
	begin
        select @cExtenso = @cExtenso + ' e ' + dbo.NumeroPorExtenso(@nDecimal) + ' centavo'
        IF @nDecimal > 1
		BEGIN
            select @cExtenso = @cExtenso + 's'
        END
    end

    RETURN @cExtenso
END

