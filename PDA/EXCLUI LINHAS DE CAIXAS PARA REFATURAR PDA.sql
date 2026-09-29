CREATE PROCEDURE [ccp\paulo.devide].[lx_exclui_romaneios_pda_por_filial]
@FILIAL VARCHAR(25)
AS
set nocount on

DECLARE @TABELA1 TABLE (ID INT IDENTITY(1,1) NOT NULL, CAIXA VARCHAR(8))

INSERT INTO @TABELA1 
select caixa_pda
from [ccp\paulo.devide].[vw_caixas_nao_faturadas_pda]
where filial = @FILIAL

/* FIM */
DECLARE @MIN INT, @MAX INT
SELECT @MIN=MIN(ID), @MAX=MAX(ID) FROM @TABELA1


declare @caixa varchar(8) 
declare @pedido varchar(12)


WHILE @MIN <= @MAX
BEGIN
	print @min

	SELECT @CAIXA = CAIXA
	FROM @TABELA1 WHERE ID = @MIN

	--set @caixa = '30867047'
	set @pedido = 'CX-'+@caixa

	if exists( select 1 from vendas_prod_embalado 
				where pedido = @pedido)
		BEGIN
			delete from vendas_prod_embalado where pedido = @pedido
			PRINT 'EXCLUIU VENDAS_PROD_EMBALADO -> ' + @pedido
		END

	if exists( select 1 from vendas_produto 
				where pedido = @pedido)
		begin
			delete from vendas_produto where pedido = @pedido
			PRINT 'EXCLUIU VENDAS_PRODUTO -> ' + @pedido
		end

	--if exists( select 1 from vendas 
	--		where pedido = @pedido)
	--	BEGIN
	--		delete from vendas where pedido = @pedido
	--		PRINT 'EXCLUIU VENDAS -> ' + @pedido
	--	END

	if exists (select 1 from faturamento_caixas 
				where caixa = @caixa)
		BEGIN
			delete from faturamento_caixas where caixa = @caixa
			PRINT 'EXCLUIU faturamento_caixas -> ' + @caixa
		END

		set @min = @min + 1
END
set nocount off
