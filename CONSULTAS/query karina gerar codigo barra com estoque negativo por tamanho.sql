CREATE PROCEDURE DBO.PRC_LISTA_ESTOQUE_NEGATIVO_POR_FILIAL_SKU
	@filial varchar(25) = ''
AS
BEGIN
	set nocount on

	DECLARE @min int, @max int, @min2 int, @max2 int, @linha int, @valor int
	declare @PRODUTO VARCHAR(12),@COR_PRODUTO VARCHAR(10),@PONTEIRO VARCHAR(40)
	DECLARE @ES1 INT,@ES2 INT,@ES3 INT,@ES4 INT,@ES5 INT,@ES6 INT,@ES7 INT,@ES8 INT,
			@ES9 INT,@ES10 INT,@ES11 INT,@ES12 INT,@ES13 INT,@ES14 INT,@ES15 INT,@ES16 INT

	declare @TAMANHO INT, @CODIGO_BARRA VARCHAR(25), @QTDE INT

	DECLARE @TAB_SAIDA TABLE (
	FILIAL VARCHAR(25),
	PRODUTO VARCHAR(12),
	COR_PRODUTO VARCHAR(10),
	TAMANHO INT,
	CODIGO_BARRA VARCHAR(25),
	QTDE INT)

	DECLARE @TAB_ESTOQUE TABLE (
	ID INT IDENTITY(1,1) PRIMARY KEY NONCLUSTERED,
	FILIAL VARCHAR(25),
	PRODUTO VARCHAR(12),
	COR_PRODUTO VARCHAR(10),
	PONTEIRO VARCHAR(16),
	ES1 INT,
	ES2 INT,
	ES3 INT,
	ES4 INT,
	ES5 INT,
	ES6 INT,
	ES7 INT,
	ES8 INT,
	ES9 INT,
	ES10 INT,
	ES11 INT,
	ES12 INT,
	ES13 INT,
	ES14 INT,
	ES15 INT,
	ES16 INT,
	ESTOQUE INT)

	INSERT INTO @TAB_ESTOQUE
	(FILIAL,PRODUTO,COR_PRODUTO,PONTEIRO,ES1,ES2,ES3,ES4,ES5,ES6,ES7,ES8,ES9,
	ES10,ES11,ES12,ES13,ES14,ES15,ES16,ESTOQUE)
	select	FILIAL,
			PRODUTO,
			COR_PRODUTO,
			case when es1 < 0 then '1' else '0' end + 
			case when es2 < 0 then '1' else '0' end + 
			case when es3 < 0 then '1' else '0' end + 
			case when es4 < 0 then '1' else '0' end + 
			case when es5 < 0 then '1' else '0' end + 
			case when es6 < 0 then '1' else '0' end + 
			case when es7 < 0 then '1' else '0' end + 
			case when es8 < 0 then '1' else '0' end + 
			case when es9 < 0 then '1' else '0' end + 
			case when es10 < 0 then '1' else '0' end + 
			case when ES11 < 0 then '1' else '0' end + 
			case when es12 < 0 then '1' else '0' end + 
			case when es13 < 0 then '1' else '0' end + 
			case when es14 < 0 then '1' else '0' end + 
			case when es15 < 0 then '1' else '0' end + 
			case when es16 < 0 then '1' else '0' end as ponteiro,
			ES1,
			ES2,
			ES3,
			ES4,
			ES5,
			ES6,
			ES7,
			ES8,
			ES9,
			ES10,
			ES11,
			ES12,
			ES13,
			ES14,
			ES15,
			ES16,
			ESTOQUE
	from ESTOQUE_PRODUTOS 
	where FILIAL = @filial and (
	es1 < 0 or es2 < 0 or es3 < 0 or es4 < 0 or es5 < 0 or es6 < 0 or es7 < 0 or es8 < 0 
	or es9 < 0 or es10 < 0 or es11 < 0 or es12 < 0 or es13 < 0 or es14 < 0 or es15 < 0 or es16 < 0) 

	--SELECT * FROM @TAB_ESTOQUE

	SELECT @min=MIN(id),@max=MAX(id)
	FROM @TAB_ESTOQUE

	while @min <= @max
	begin
		select @PRODUTO=produto,@COR_PRODUTO=cor_produto,@PONTEIRO=PONTEIRO,
			@ES1 = ES1,	@ES2 = ES2,	@ES3 = ES3,	@ES4 = ES4,	@ES5 = ES5,
			@ES6 = ES6, @ES7 = ES7,	@ES8 = ES8,	@ES9 = ES9,	@ES10 = ES10,
			@ES11 = ES11, @ES12 = ES12, @ES13 = ES13, @ES14 = ES14, @ES15 = ES15,
			@ES16 = ES16
		from @TAB_ESTOQUE
		where ID = @min

		select @min2 = 1, @max2 = 16

		while @min2 <= @max2
		begin

			select @valor = SUBSTRING(@PONTEIRO,@min2,1)

			if @valor = 1
			begin

				select TOP 1 
					@CODIGO_BARRA=CODIGO_BARRA, @TAMANHO=TAMANHO
				from PRODUTOS_BARRA 
				where PRODUTO = @PRODUTO and COR_PRODUTO=@COR_PRODUTO and TAMANHO=@min2

				select @QTDE = 
						case when @min2 =  1 then @ES1
						 when @min2 =  2 then @ES2
						 when @min2 =  3 then @ES3
						 when @min2 =  4 then @ES4
						 when @min2 =  5 then @ES5
						 when @min2 =  6 then @ES6
						 when @min2 =  7 then @ES7
						 when @min2 =  8 then @ES8
						 when @min2 =  9 then @ES9
						 when @min2 =  10 then @ES10
						 when @min2 =  11 then @ES11
						 when @min2 =  12 then @ES12
						 when @min2 =  13 then @ES13
						 when @min2 =  14 then @ES14
						 when @min2 =  15 then @ES15
						 when @min2 =  16 then @ES16
						 END

				INSERT INTO @TAB_SAIDA
				(FILIAL, PRODUTO, COR_PRODUTO, TAMANHO, CODIGO_BARRA, QTDE)
				VALUES 
				(@FILIAL, @PRODUTO, @COR_PRODUTO, @TAMANHO, @CODIGO_BARRA, @QTDE)

			end -- if @valor = 1

			set @min2 += 1
		end

		set @min += 1
	end

	select * from @TAB_SAIDA

	set nocount off
END






