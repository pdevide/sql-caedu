 SET NOCOUNT ON
DECLARE 
	@TABCAIXAS TABLE (ID INT IDENTITY(1,1), CAIXA VARCHAR(8) NOT NULL)
	--insert into @TABCAIXAS (caixa) 
	--select caixa from PDA_WMS_TRANSFERE_ESTOQUE_LOJA_VIRTUAL where caixa_excluida=0 and flg_processamento=1
	--values ('17344503'),('17344275')
insert into @tabcaixas (caixa) values ('18434686');
insert into @tabcaixas (caixa) values ('18434687');
insert into @tabcaixas (caixa) values ('18434688');
insert into @tabcaixas (caixa) values ('18434689');
insert into @tabcaixas (caixa) values ('18434690');
insert into @tabcaixas (caixa) values ('18434691');
insert into @tabcaixas (caixa) values ('18434692');
insert into @tabcaixas (caixa) values ('18434693');
insert into @tabcaixas (caixa) values ('18434696');
insert into @tabcaixas (caixa) values ('18434697');
insert into @tabcaixas (caixa) values ('18434698');
insert into @tabcaixas (caixa) values ('18434699');
insert into @tabcaixas (caixa) values ('18434700');
insert into @tabcaixas (caixa) values ('18434701');
insert into @tabcaixas (caixa) values ('18434702');
insert into @tabcaixas (caixa) values ('18434703');
insert into @tabcaixas (caixa) values ('18434706');
insert into @tabcaixas (caixa) values ('18434707');
insert into @tabcaixas (caixa) values ('18434708');
insert into @tabcaixas (caixa) values ('18434709');
insert into @tabcaixas (caixa) values ('18434710');
insert into @tabcaixas (caixa) values ('18434711');
insert into @tabcaixas (caixa) values ('18434712');
insert into @tabcaixas (caixa) values ('18434713');


DECLARE @I INT, @TOT INT, @CAIXA VARCHAR(8), @TIPO_DISTRIBUICAO INT /* 1 - PEDIDO 2 - WMS */

SELECT @I=MIN(ID), @TOT=MAX(ID) 
FROM @TABCAIXAS

BEGIN
	
	DECLARE @ERROFAT BIT
	SET @ERROFAT = 0
	DECLARE @MSG VARCHAR(1000)
	-- Executando a tarefa em transa豫o

	WHILE @I<=@TOT
	BEGIN

		SELECT @CAIXA = CAIXA
		FROM @TABCAIXAS WHERE ID= @I

		SET @TIPO_DISTRIBUICAO = 0
		IF EXISTS(SELECT 1 from VENDAS_PROD_EMBALADO where CAIXA = @CAIXA) 
		BEGIN
			SET @TIPO_DISTRIBUICAO = 3
		END
		IF EXISTS(SELECT 1 from CAEDU_RESERVA_AUTOMATICA_PACK_WMS where CAIXA = @CAIXA) 
		BEGIN
			SET @TIPO_DISTRIBUICAO = 2
		END
		IF EXISTS(SELECT 1 from CAEDU_RESERVA_AUTOMATICA where CAIXA = @CAIXA) 
		BEGIN
			SET @TIPO_DISTRIBUICAO = 1
		END

		IF @TIPO_DISTRIBUICAO = 2
		BEGIN	
			BEGIN TRY

				DELETE FROM FATURAMENTO_CAIXAS
				WHERE CAIXA = @CAIXA AND CAIXA NOT IN (SELECT CAIXA FROM FATURAMENTO_PROD)

				DELETE FROM CAEDU_RESERVA_AUTOMATICA_WMS 
				WHERE CAIXA = @CAIXA

				DELETE
				FROM VENDAS_PROD_EMBALADO
				WHERE CAIXA = @CAIXA

				DELETE CAEDU_RESERVA_AUTOMATICA_PACK_WMS 
				WHERE CAIXA = @CAIXA

			END TRY

			BEGIN CATCH

				 SET @MSG = 'ERRO NA TRANSA플O: '+ERROR_MESSAGE()
				RAISERROR(@MSG, 16, 1)
				/*ROLLBACK TRAN -- TRANSA플O ABERTA NO LINX*/

			END CATCH
		END

		IF @TIPO_DISTRIBUICAO = 1
		BEGIN	
			BEGIN TRY

				DELETE FROM FATURAMENTO_CAIXAS
				WHERE CAIXA = @CAIXA AND CAIXA NOT IN (SELECT CAIXA FROM FATURAMENTO_PROD)

				DELETE FROM CAEDU_RESERVA_AUTOMATICA
				WHERE CAIXA = @CAIXA

				DELETE
				FROM VENDAS_PROD_EMBALADO
				WHERE CAIXA = @CAIXA

			END TRY

			BEGIN CATCH

				 SET @MSG = 'ERRO NA TRANSA플O: '+ERROR_MESSAGE()
				RAISERROR(@MSG, 16, 1)
				/*ROLLBACK TRAN -- TRANSA플O ABERTA NO LINX*/

			END CATCH
		END

		IF @TIPO_DISTRIBUICAO = 3
		BEGIN	
			BEGIN TRY

				DELETE FROM FATURAMENTO_CAIXAS
				WHERE CAIXA = @CAIXA AND CAIXA NOT IN (SELECT CAIXA FROM FATURAMENTO_PROD)

				DELETE
				FROM VENDAS_PROD_EMBALADO
				WHERE CAIXA = @CAIXA

			END TRY

			BEGIN CATCH

				 SET @MSG = 'ERRO NA TRANSA플O: '+ERROR_MESSAGE()
				RAISERROR(@MSG, 16, 1)
				/*ROLLBACK TRAN -- TRANSA플O ABERTA NO LINX*/

			END CATCH
		END
		IF @TIPO_DISTRIBUICAO > 0
		BEGIN
			PRINT 'ID = '+CONVERT(VARCHAR,@I )+' DE '+CONVERT(VARCHAR,@TOT )+' ==> CAIXA = '+@CAIXA+' ==> TIPO DISTRIBUICAO = '+ CONVERT(VARCHAR,@TIPO_DISTRIBUICAO)
		END
		ELSE
		BEGIN
			PRINT 'ID = '+CONVERT(VARCHAR,@I )+' ==> CAIXA = '+@CAIXA+' N? EXISTE!'
		END

		SET @I = @I + 1

	END


END
SET NOCOUNT OFF
--update PDA_WMS_TRANSFERE_ESTOQUE_LOJA_VIRTUAL 
--set caixa_excluida=1
--where caixa_excluida=0 and flg_processamento=1
