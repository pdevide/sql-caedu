
ALTER PROCEDURE DBO.CGP_LX_GERAR_CODIGO_BARRA 
	@produto varchar(12)
AS
BEGIN
	declare @grade varchar(25), @griffe varchar(25)
	declare @tab_cores table (id int identity(1,1), produto varchar(12), cor_produto varchar(10), desc_cor_produto varchar(40))
	DECLARE @VALOR_ETIQ_DUPLA VARCHAR(5)

	select @VALOR_ETIQ_DUPLA=VALOR_ATUAL from parametros where parametro = 'P_ETIQUETA_DUPLA'         

	insert into @tab_cores (produto, cor_produto, desc_cor_produto)
	select  produto, cor_produto, desc_cor_produto
	from PRODUTO_CORES where produto = @produto

	declare @tab_grade table (id int identity(1,1), posicao int, tamanho varchar(8))

	select  @GRADE = GRADE, @griffe = GRIFFE
	from produtos p
	where p.produto = @produto


	insert into @tab_grade (posicao, tamanho)
	exec LX_TAMANHOS_DIGITADOS_GRADE @grade

	DECLARE @TAB_BARRAS TABLE (
	PRODUTO VARCHAR(12),
	COR_PRODUTO VARCHAR(10),
	GRADE VARCHAR(8),
	CODIGO_BARRA VARCHAR(25),
	DESC_COR_PRODUTO VARCHAR(40),
	CODIGO_BARRA_PADRAO BIT,
	TIPO_COD_BAR tinyint,
	TAMANHO INT
	)

	DECLARE @MIN_CORES INT, @MAX_CORES INT
	DECLARE @MIN_SIZES INT, @MAX_SIZES INT

	SELECT  @MIN_CORES = min(id), @MAX_CORES = max(id)
	from @tab_cores


	declare 
		@COR_PRODUTO VARCHAR(10),
		@CODIGO_BARRA VARCHAR(25),
		@DESC_COR_PRODUTO VARCHAR(40),
		@CODIGO_BARRA_PADRAO BIT,
		@TIPO_COD_BAR tinyint,
		@POSICAO_CHAR VARCHAR(2), 
		@POSICAO INT

	while @MIN_CORES <= @MAX_CORES /* Faz um loop pra gerar por produto + cor + tamanhos */
	begin

		select @COR_PRODUTO = cor_produto, @DESC_COR_PRODUTO=desc_cor_produto 
		from @tab_cores where id = @MIN_CORES

		SELECT  @MIN_SIZES = min(id), @MAX_SIZES = max(id)
		from @tab_grade

		while @MIN_SIZES <= @MAX_SIZES
		begin

			SELECT @GRADE=tamanho, @POSICAO_CHAR=RIGHT('00'+CONVERT(VARCHAR,POSICAO),2), @POSICAO=POSICAO  
			FROM @tab_grade
			WHERE ID = @MIN_SIZES

			SET @CODIGO_BARRA = RTRIM(LTRIM(@produto))+RTRIM(LTRIM(@COR_PRODUTO))+@POSICAO_CHAR
			SET @CODIGO_BARRA_PADRAO=1
			SET @TIPO_COD_BAR=2

			insert into @TAB_BARRAS (PRODUTO, COR_PRODUTO, GRADE, CODIGO_BARRA, DESC_COR_PRODUTO, CODIGO_BARRA_PADRAO, TIPO_COD_BAR, TAMANHO)
			values (@PRODUTO, @COR_PRODUTO, @GRADE, @CODIGO_BARRA, @DESC_COR_PRODUTO, @CODIGO_BARRA_PADRAO, @TIPO_COD_BAR, @POSICAO)

			IF @griffe='CALCADOS' AND @VALOR_ETIQ_DUPLA='.T.'
			BEGIN
				SET @CODIGO_BARRA = RTRIM(LTRIM(@produto))+RTRIM(LTRIM(@COR_PRODUTO))+@POSICAO_CHAR+'D'
				SET @CODIGO_BARRA_PADRAO=0
				SET @TIPO_COD_BAR=2
				insert into @TAB_BARRAS (PRODUTO, COR_PRODUTO, GRADE, CODIGO_BARRA, DESC_COR_PRODUTO, CODIGO_BARRA_PADRAO, TIPO_COD_BAR, TAMANHO)
				values (@PRODUTO, @COR_PRODUTO, @GRADE, @CODIGO_BARRA, @DESC_COR_PRODUTO, @CODIGO_BARRA_PADRAO, @TIPO_COD_BAR, @POSICAO)
			END

			set @MIN_SIZES = @MIN_SIZES + 1
		end

		set @MIN_CORES = @MIN_CORES + 1
	end

	--SELECT * FROM  @tab_cores
	--SELECT * FROM @tab_grade
	--SELECT * FROM @TAB_BARRAS

	--SELECT * FROM PRODUTOS_BARRA WHERE PRODUTO = @produto
	if exists (select 1 from PRODUTOS_BARRA where produto = @produto)
	begin
		delete from PRODUTOS_BARRA where produto = @produto
	--select 'deletar'
	end
	INSERT INTO PRODUTOS_BARRA (CODIGO_BARRA,
								PRODUTO,
								COR_PRODUTO,
								TAMANHO,
								GRADE,
								DATA_PARA_TRANSFERENCIA,
								CODIGO_BARRA_PADRAO,
								INATIVO,
								TIPO_COD_BAR)
	SELECT CODIGO_BARRA,PRODUTO,COR_PRODUTO,TAMANHO,GRADE,GETDATE() AS DATA_PARA_TRANSFERENCIA,CODIGO_BARRA_PADRAO,CAST(0 AS BIT) AS INATIVO,TIPO_COD_BAR
	FROM @TAB_BARRAS
	
END
