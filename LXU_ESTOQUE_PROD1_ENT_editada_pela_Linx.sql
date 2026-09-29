CREATE TRIGGER [dbo].[LXU_ESTOQUE_PROD1_ENT] ON [dbo].[ESTOQUE_PROD1_ENT]
  for UPDATE NOT FOR REPLICATION
  as
/* UPDATE trigger on ESTOQUE_PROD1_ENT */
/* default body for LXU_ESTOQUE_PROD1_ENT */

-- 12/06/2026 - DARIO SILVA     - ENTERMODA-40728 - 01.26.050 - #9# - Correção ao alterar/salvar
-- 15/05/2026 - ROBERTO AUGUSTO - ENTERMODA-39876 - 01.26.040 - #8# - Ajustando o filtro do parametro CONSIDERA_TRANSITO_ESTOQ
-- 06/04/2026 - ROBERTO AUGUSTO - ENTERMODA-38611 - 01.26.040 - #7# - Trânsito entre filiais de retaguarda
-- 20/01/2025 - Marcelo Faria   - #6# - ENTERMODA-14817 - Gravar o historico/saldo de crédito de transferência.
-- 07/11/2018 - Rodrigo Souza   - #5# - Demanda 100368 - Correção para atualizar corretamente a data de encerramento da op.
-- 05/09/2017  JAQUE LAURENTI   - #4# - Demanda 43211 - Correção para permitir entrada por ordem de produção para filiais da mesma matriz fiscal.
-- REPLICAÇÃO DA DEMANDA 37316
-- 07/11/2016 - Rodrigo Souza	- #3# - Demanda 7429 - Comentada alteração #1# pois os itens serão gerados de outra maneira para atender o K260.
-- 10/06/2016 - Szalontai		- #2# - Demanda 1658 - Tratamento de custo por matriz contabil
-- 28/09/2015 - SZALONTAI		- #1# ADIÇÃO DE TRATAMENTO PARA OP DE RETRABALHO
--
-- 29/05/2013 - WENDEL - 3621638 ALTERAÇÃO NA QUERY QUE FAZ OS CALCULOS PARA ATUALIZAR O ESTOQUE
-- 23/07/2012 - RAFAEL - ALTERAÇÃO NA QUANTIDADE DE DIGITOS DA NOTA FISCAL E SERIE NF
-- 23/07/2012 - RAFAEL - ALTERAÇÃO NA QUANTIDADE DE DIGITOS DA NOTA FISCAL E SERIE NF
-- 08/01/2008 - Fabiano Banin - Só deve verificar os bloqueios de ajuste/parâmetro qdo alterar campos de qtdes.
-- 14/12/2005 - SZALONTAI - ADICAO DO TRATAMENTO PARA ATUALIZAR O CAMPO VALOR_TAREFA NA TABELA PRODUCAO_TAREFAS NO MOMENTO DE
--							FINALIZAR A OP. 
-- 01/09/2005 - Fabiano Banin - Alteração no insert da produção tarefa, esta sendo verificado se a tarefa da tabela esta nulo ou não.
-- 09/08/2005 - Fabiano Banin - Alteração na verificação do ajuste, só irá verificar se for alterado a qtde da entrada.
-- 19/10/2004 - SZALONTAI - ADICAO DE LOCAL NA CRIAÇÃO DO CURSOR TEMPORARIO
--

begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insROMANEIO_PRODUTO char(8), 
           @insFILIAL varchar(25), 
           @insPRODUTO char(12), 
           @insCOR_PRODUTO char(10),
           @delROMANEIO_PRODUTO char(8), 
           @delFILIAL varchar(25), 
           @delPRODUTO char(12), 
           @delCOR_PRODUTO char(10),
           @insTAREFA char(10), 
           @insQTDE QTDE_PRODUTO, 
           @insTOTAL QTDE_PRODUTO, 
           @insORDEM_PRODUCAO char(8), 
           @insEn_1  QTDE_PRODUTO, @insEn_2  QTDE_PRODUTO, @insEn_3  QTDE_PRODUTO, @insEn_4  QTDE_PRODUTO, 
           @insEn_5  QTDE_PRODUTO, @insEn_6  QTDE_PRODUTO, @insEn_7  QTDE_PRODUTO, @insEn_8  QTDE_PRODUTO, 
           @insEn_9  QTDE_PRODUTO, @insEn_10 QTDE_PRODUTO, @insEn_11 QTDE_PRODUTO, @insEn_12 QTDE_PRODUTO, 
           @insEn_13 QTDE_PRODUTO, @insEn_14 QTDE_PRODUTO, @insEn_15 QTDE_PRODUTO, @insEn_16 QTDE_PRODUTO, 
           @insEn_17 QTDE_PRODUTO, @insEn_18 QTDE_PRODUTO, @insEn_19 QTDE_PRODUTO, @insEn_20 QTDE_PRODUTO, 
           @insEn_21 QTDE_PRODUTO, @insEn_22 QTDE_PRODUTO, @insEn_23 QTDE_PRODUTO, @insEn_24 QTDE_PRODUTO, 
           @insEn_25 QTDE_PRODUTO, @insEn_26 QTDE_PRODUTO, @insEn_27 QTDE_PRODUTO, @insEn_28 QTDE_PRODUTO, 
           @insEn_29 QTDE_PRODUTO, @insEn_30 QTDE_PRODUTO, @insEn_31 QTDE_PRODUTO, @insEn_32 QTDE_PRODUTO, 
           @insEn_33 QTDE_PRODUTO, @insEn_34 QTDE_PRODUTO, @insEn_35 QTDE_PRODUTO, @insEn_36 QTDE_PRODUTO, 
           @insEn_37 QTDE_PRODUTO, @insEn_38 QTDE_PRODUTO, @insEn_39 QTDE_PRODUTO, @insEn_40 QTDE_PRODUTO, 
           @insEn_41 QTDE_PRODUTO, @insEn_42 QTDE_PRODUTO, @insEn_43 QTDE_PRODUTO, @insEn_44 QTDE_PRODUTO, 
           @insEn_45 QTDE_PRODUTO, @insEn_46 QTDE_PRODUTO, @insEn_47 QTDE_PRODUTO, @insEn_48 QTDE_PRODUTO,
			@insDATA_Emissao DATETIME,
           @errno   int,
           @errmsg  varchar(255)
		   ,@TIPO_PROCESSO INT  --#1# 

		   ,@ORIGEM_TRANSITO  BIT = 0 -- #8# 
		   ,@ATUALIZA_ESTOQUE BIT = 1 -- #8# 

  select @numrows = @@rowcount

-- Debug
SELECT  'LXU_ESTOQUE_PROD1_ENT'

/*-- Verifica Movimentacao Estoque PA ---------------------------------------------------------------------------------*/

	/*--- BLOQUEIO POR AJUSTE ---*/
	BEGIN

		IF ( UPDATE(QTDE) OR UPDATE(EN_1) OR UPDATE(EN_2) OR UPDATE(EN_3) OR UPDATE(EN_4) OR UPDATE(EN_5) OR UPDATE(EN_6) OR UPDATE(EN_7) OR 
             UPDATE(EN_8) OR UPDATE(EN_9) OR UPDATE(EN_10) OR UPDATE(EN_11) OR UPDATE(EN_12) OR UPDATE(EN_13) OR UPDATE(EN_14) OR UPDATE(EN_15) OR
             UPDATE(EN_16) OR UPDATE(EN_17) OR UPDATE(EN_18) OR UPDATE(EN_19) OR UPDATE(EN_20) OR UPDATE(EN_21) OR UPDATE(EN_22) OR UPDATE(EN_23) OR
             UPDATE(EN_24) OR UPDATE(EN_25) OR UPDATE(EN_26) OR UPDATE(EN_27) OR UPDATE(EN_28) OR UPDATE(EN_29) OR UPDATE(EN_30) OR UPDATE(EN_31) OR
             UPDATE(EN_32) OR UPDATE(EN_33) OR UPDATE(EN_34) OR UPDATE(EN_35) OR UPDATE(EN_36) OR UPDATE(EN_37) OR UPDATE(EN_38) OR UPDATE(EN_39) OR
             UPDATE(EN_40) OR UPDATE(EN_41) OR UPDATE(EN_42) OR UPDATE(EN_43) OR UPDATE(EN_44) OR UPDATE(EN_45) OR UPDATE(EN_46) OR UPDATE(EN_47) OR
             UPDATE(EN_48) )
		BEGIN

			/*
			DECLARE @xDataSaldo DateTime

			SELECT @xDataSaldo='18000101'
			SELECT @xDataSaldo=ISNULL(CONVERT(DATETIME,VALOR_ATUAL,103),'18000101') FROM PARAMETROS WHERE PARAMETRO='DATA_BLOQUEIO_MOV_PA'

			
			
			IF (	SELECT 	COUNT(*)
				FROM	Deleted, ESTOQUE_PROD_ENT
				WHERE	Deleted.ROMANEIO_PRODUTO = ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO AND 
								Deleted.FILIAL = ESTOQUE_PROD_ENT.FILIAL AND
					ESTOQUE_PROD_ENT.EMISSAO <= @xDataSaldo 
					
					)+
			   (	SELECT 	COUNT(*)
				FROM	Inserted, ESTOQUE_PROD_ENT
				WHERE	Inserted.ROMANEIO_PRODUTO = ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO AND 
								Inserted.FILIAL = ESTOQUE_PROD_ENT.FILIAL AND
					ESTOQUE_PROD_ENT.EMISSAO <= @xDataSaldo 
					
					) > 0

			BEGIN
				SELECT 	@errno=30002,
					@errmsg='Não é possível Alterar Movimentacao de Estoque anterior a #'+CONVERT(Char(10),@xDataSaldo,103)+' !'
				GOTO error
			END
			*/

			/*
			#2#
			-------------------------------------------------------------------------------------------------------------------------
			INICIO
			-------------------------------------------------------------------------------------------------------------------------
			*/
			--/*
			DECLARE @xDataSaldoD DateTime,@xDataSaldoI DateTime,@xfilial char(25)
			SELECT @xDataSaldoD='18000101',@xDataSaldoI='18000101'
	
			SELECT @xDataSaldoD=C.DATA_SALDO_PA
   			FROM Deleted A	 
			INNER JOIN ESTOQUE_PROD_ENT B ON	A.ROMANEIO_PRODUTO = B.ROMANEIO_PRODUTO AND 
												A.FILIAL = B.FILIAL
			INNER JOIN CM_DATA_FECHAMENTO C	ON	B.FILIAL = C.FILIAL AND B.EMISSAO<=C.DATA_SALDO_PA

			SELECT @xDataSaldoI=C.DATA_SALDO_PA,@xfilial = B.FILIAL	
   			FROM Inserted A	 
			INNER JOIN ESTOQUE_PROD_ENT B ON	A.ROMANEIO_PRODUTO = B.ROMANEIO_PRODUTO AND 
												A.FILIAL = B.FILIAL
			INNER JOIN CM_DATA_FECHAMENTO C	ON	B.FILIAL = C.FILIAL AND B.EMISSAO<=C.DATA_SALDO_PA

	
			IF	(
					SELECT COUNT(*)    
   					FROM Deleted A	 
					INNER JOIN ESTOQUE_PROD_ENT B ON	A.ROMANEIO_PRODUTO = B.ROMANEIO_PRODUTO AND 
														A.FILIAL = B.FILIAL
					INNER JOIN CM_DATA_FECHAMENTO C	ON	B.FILIAL = C.FILIAL AND B.EMISSAO<=@xDataSaldoD 
				) +
				(
					SELECT COUNT(*)    
   					FROM Inserted A	 
					INNER JOIN ESTOQUE_PROD_ENT B ON	A.ROMANEIO_PRODUTO = B.ROMANEIO_PRODUTO AND 
														A.FILIAL = B.FILIAL
					INNER JOIN CM_DATA_FECHAMENTO C	ON	B.FILIAL = C.FILIAL AND B.EMISSAO<=@xDataSaldoI 
			   )
			   > 0	
			BEGIN
				SELECT 	@errno=30002,
					@errmsg='Não é possível Alterar Movimentacao de Estoque anterior a #'+CONVERT(Char(10),@xDataSaldoD,103)+' para a filial '+rtrim(ltrim(@xfilial))+' !'
				GOTO error
			END

			--*/
			/*
			-------------------------------------------------------------------------------------------------------------------------
			FIM
			-------------------------------------------------------------------------------------------------------------------------
			*/



			IF EXISTS(SELECT *
				FROM	Deleted, ESTOQUE_PROD_ENT, ESTOQUE_PRODUTOS 
				WHERE	DELETED.ROMANEIO_PRODUTO = ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO AND 
	                         DELETED.FILIAL = ESTOQUE_PROD_ENT.FILIAL AND
					ESTOQUE_PRODUTOS.FILIAL=DELETED.FILIAL AND
					ESTOQUE_PRODUTOS.PRODUTO=DELETED.PRODUTO AND
					ESTOQUE_PRODUTOS.COR_PRODUTO=DELETED.COR_PRODUTO AND
					ESTOQUE_PROD_ENT.EMISSAO < ESTOQUE_PRODUTOS.DATA_AJUSTE ) OR
			   EXISTS(SELECT *
				FROM	Inserted, ESTOQUE_PROD_ENT, ESTOQUE_PRODUTOS 
				WHERE	INSERTED.ROMANEIO_PRODUTO = ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO AND 
	                         INSERTED.FILIAL = ESTOQUE_PROD_ENT.FILIAL AND
					ESTOQUE_PRODUTOS.FILIAL=INSERTED.FILIAL AND
					ESTOQUE_PRODUTOS.PRODUTO=INSERTED.PRODUTO AND
					ESTOQUE_PRODUTOS.COR_PRODUTO=INSERTED.COR_PRODUTO AND
					ESTOQUE_PROD_ENT.EMISSAO < ESTOQUE_PRODUTOS.DATA_AJUSTE ) 
	
			BEGIN
				SELECT 	@errno=30002,
					@errmsg='Não é possível Alterar Movimentacao de Estoque anterior ao Ajuste !'
				GOTO error
			END

		END

	END

/*---------------------------------------------------------------------------------------------------------------------*/

/* ESTOQUE_PROD_ENT R/1175 ESTOQUE_PROD1_ENT ON CHILD UPDATE RESTRICT */
/*#9#*/
IF UPDATE(ROMANEIO_PRODUTO) OR UPDATE(FILIAL)
 BEGIN

	IF EXISTS   (SELECT 1 FROM inserted I WHERE I.ROMANEIO_PRODUTO IS NOT NULL
					AND I.FILIAL IS NOT NULL
					AND NOT EXISTS
					(
						SELECT 1 FROM ESTOQUE_PROD_ENT AS E
						WHERE E.ROMANEIO_PRODUTO = I.ROMANEIO_PRODUTO
						AND E.FILIAL = I.FILIAL
					)
				)
    BEGIN
        SELECT 
            @errno  = 30007,
            @errmsg = 'Impossível Atualizar  #ESTOQUE_PROD1_ENT #porque #ESTOQUE_PROD_ENT #não existe.'
        GOTO error
    END
 END

  --if
  --  update(ROMANEIO_PRODUTO) or
  --  update(FILIAL)
  --begin
  --  select @nullcnt = 0
  --  select @validcnt = count(*)
  --    from inserted,ESTOQUE_PROD_ENT
  --   where
  --         inserted.ROMANEIO_PRODUTO = ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO and
  --         inserted.FILIAL = ESTOQUE_PROD_ENT.FILIAL
    
  --  if @validcnt + @nullcnt != @numrows
  --  begin
  --    select @errno  = 30007,
  --           @errmsg = 'Impossível Atualizar  #ESTOQUE_PROD1_ENT #porque #ESTOQUE_PROD_ENT #não existe.'
  --    goto error
  --  end
  --end
/*#9#*/

/* PRODUTO_CORES R/1152 ESTOQUE_PROD1_ENT ON CHILD UPDATE RESTRICT */
  if
    update(PRODUTO) or
    update(COR_PRODUTO)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,PRODUTO_CORES
     where
           inserted.PRODUTO = PRODUTO_CORES.PRODUTO and
           inserted.COR_PRODUTO = PRODUTO_CORES.COR_PRODUTO
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar  #ESTOQUE_PROD1_ENT #porque #PRODUTO_CORES #não existe.'
      goto error
    end
  end

/* PRODUCAO_TAREFAS R/700 ESTOQUE_PROD1_ENT ON CHILD UPDATE RESTRICT */
  if
    update(TAREFA)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,PRODUCAO_TAREFAS
     where
           inserted.TAREFA = PRODUCAO_TAREFAS.TAREFA
    select @nullcnt = count(*) from inserted where
      inserted.TAREFA is null
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar  #ESTOQUE_PROD1_ENT #porque #PRODUCAO_TAREFAS #não existe.'
      goto error
    end
  end

/* PRODUCAO_ORDEM R/697 ESTOQUE_PROD1_ENT ON CHILD UPDATE RESTRICT */
  if
    update(ORDEM_PRODUCAO)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,PRODUCAO_ORDEM
     where
           inserted.ORDEM_PRODUCAO = PRODUCAO_ORDEM.ORDEM_PRODUCAO
  select @nullcnt = count(*) from inserted where
      inserted.ORDEM_PRODUCAO is null
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar  #ESTOQUE_PROD1_ENT #porque #PRODUCAO_ORDEM #não existe.'
      goto error
    end
  end


-- #8#
/*
IF 
	EXISTS (	SELECT TOP 1 1 
						FROM inserted AS A 
						JOIN ESTOQUE_PROD_ENT AS B ON A.ROMANEIO_PRODUTO =B.ROMANEIO_PRODUTO AND A.FILIAL =B.FILIAL 
						WHERE B.ENTRADA_ENCERRADA=1
						AND B.TIPO_ENTRADA=7 
			   )
	AND 
		DBO.[FX_PARAMETRO] ('CONSIDERA_TRANSITO_ESTOQ')='.T.' -- #7#
			 OR ( -- #8# inicio
					DBO.[FX_PARAMETRO] ('CONSIDERA_TRANSITO_ESTOQ')='.F.' 
					AND EXISTS (	SELECT TOP 1 1 
									FROM inserted AS A 
									JOIN ESTOQUE_PROD_ENT AS B ON A.ROMANEIO_PRODUTO =B.ROMANEIO_PRODUTO AND A.FILIAL =B.FILIAL 
									WHERE B.ENTRADA_ENCERRADA=1
								)
				)  -- #8# fim
	 BEGIN

	 SET @ATUALIZA_ESTOQUE = 0
END
*/

/*
IF EXISTS (	SELECT TOP 1 1 
				  FROM inserted AS A 
				  JOIN ESTOQUE_PROD_ENT AS B ON A.ROMANEIO_PRODUTO =B.ROMANEIO_PRODUTO AND A.FILIAL =B.FILIAL 
				 WHERE B.ENTRADA_ENCERRADA=1 AND B.TIPO_ENTRADA=7

			  ) 
		  AND DBO.[FX_PARAMETRO] ('CONSIDERA_TRANSITO_ESTOQ')='.F.'
BEGIN
		SET @ATUALIZA_ESTOQUE = 0
END
*/

-- ORIGEM TRANSITO
/*
IF EXISTS (	SELECT TOP 1 1 
				  FROM inserted AS A 
				  JOIN ESTOQUE_PROD_ENT AS B ON A.ROMANEIO_PRODUTO =B.ROMANEIO_PRODUTO AND A.FILIAL =B.FILIAL 
				 WHERE B.TIPO_ENTRADA=7
				   AND B.STATUS_TRANSITO NOT IN (3,4)

			  ) 
		  AND DBO.[FX_PARAMETRO] ('CONSIDERA_TRANSITO_ESTOQ')='.F.'
BEGIN
		SET @ATUALIZA_ESTOQUE = 0
END
*/

-- Debug (1)
SELECT 'Debug (1)',
B.*
FROM inserted AS A 
JOIN ESTOQUE_PROD_ENT AS B ON A.ROMANEIO_PRODUTO =B.ROMANEIO_PRODUTO AND A.FILIAL =B.FILIAL 
----

IF EXISTS (	SELECT TOP 1 1 

				FROM inserted AS A 

				JOIN ESTOQUE_PROD_ENT AS B ON A.ROMANEIO_PRODUTO =B.ROMANEIO_PRODUTO AND A.FILIAL =B.FILIAL 

				WHERE B.TIPO_ENTRADA=7
			) 
BEGIN
	SET @ORIGEM_TRANSITO = 1

	IF DBO.[FX_PARAMETRO] ('CONSIDERA_TRANSITO_ESTOQ')='.T.'

			OR ( -- #9# inicio

				DBO.[FX_PARAMETRO] ('CONSIDERA_TRANSITO_ESTOQ')='.F.' 

				AND EXISTS (	SELECT TOP 1 1 

								FROM inserted AS A 

								JOIN ESTOQUE_PROD_ENT AS B ON A.ROMANEIO_PRODUTO =B.ROMANEIO_PRODUTO AND A.FILIAL =B.FILIAL 

								WHERE B.ENTRADA_ENCERRADA=1

							)

			)  -- #9# fim

			BEGIN
				SET @ATUALIZA_ESTOQUE = 1

				-- Debug (2)
				SELECT 'Degug (2)','@ATUALIZA_ESTOQUE = ', @ATUALIZA_ESTOQUE
			END

	ELSE	
		BEGIN
			SET @ATUALIZA_ESTOQUE = 0	

				-- Debug (3)
				SELECT 'Debug (3)','@ATUALIZA_ESTOQUE = ', @ATUALIZA_ESTOQUE
		END
END


IF @ATUALIZA_ESTOQUE = 1 -- #8#
BEGIN -- #7#

		-- Debug (4)
		SELECT 'Debug (4)','IF @ATUALIZA_ESTOQUE = ', @ATUALIZA_ESTOQUE

/*-- Atualiza Estoque PA ----------------------------------------------------------------------------------------------*/
/* Atualizacao de Estoque */

IF UPDATE(PRODUTO) OR UPDATE(COR_PRODUTO) OR UPDATE(FILIAL) OR
     UPDATE(EN_1) OR UPDATE(EN_2) OR UPDATE(EN_3) OR 
     UPDATE(EN_4) OR UPDATE(EN_5) OR UPDATE(EN_6) OR 
     UPDATE(EN_7) OR UPDATE(EN_8) OR UPDATE(EN_9) OR 
     UPDATE(EN_10) OR UPDATE(EN_11) OR UPDATE(EN_12) OR 
     UPDATE(EN_13) OR UPDATE(EN_14) OR UPDATE(EN_15) OR 
     UPDATE(EN_16) OR UPDATE(EN_17) OR UPDATE(EN_18) OR 
     UPDATE(EN_19) OR UPDATE(EN_20) OR UPDATE(EN_21) OR 
     UPDATE(EN_22) OR UPDATE(EN_23) OR UPDATE(EN_24) OR 
     UPDATE(EN_25) OR UPDATE(EN_26) OR UPDATE(EN_27) OR 
     UPDATE(EN_28) OR UPDATE(EN_29) OR UPDATE(EN_30) OR 
     UPDATE(EN_31) OR UPDATE(EN_32) OR UPDATE(EN_33) OR 
     UPDATE(EN_34) OR UPDATE(EN_35) OR UPDATE(EN_36) OR 
     UPDATE(EN_37) OR UPDATE(EN_38) OR UPDATE(EN_39) OR 
     UPDATE(EN_40) OR UPDATE(EN_41) OR UPDATE(EN_42) OR 
     UPDATE(EN_43) OR UPDATE(EN_44) OR UPDATE(EN_45) OR 
     UPDATE(EN_46) OR UPDATE(EN_47) OR UPDATE(EN_48) 
  BEGIN

	---- Debug (5)
	SELECT 'Debug (5)','IF UPDATE(PRODUTO) OR UPDATE(COR_PRODUTO) OR UPDATE(FILIAL)'
  
	---- Debug (6) Inicio
	--SELECT 'Debug (6)'

	--		SELECT Produto, Cor_Produto, Filial,
	--			SUM(EN_1) AS EN_1, SUM(EN_2) AS EN_2, SUM(EN_3) AS EN_3, SUM(EN_4) AS EN_4,
	--			SUM(EN_5) AS EN_5, SUM(EN_6) AS EN_6, SUM(EN_7) AS EN_7, SUM(EN_8) AS EN_8,
	--			SUM(EN_9) AS EN_9, SUM(EN_10) AS EN_10,SUM(EN_11) AS EN_11,SUM(EN_12) AS EN_12,
	--			SUM(EN_13) AS EN_13,SUM(EN_14) AS EN_14,SUM(EN_15) AS EN_15,SUM(EN_16) AS EN_16,
	--			SUM(EN_17) AS EN_17,SUM(EN_18) AS EN_18,SUM(EN_19) AS EN_19,SUM(EN_20) AS EN_20,
	--			SUM(EN_21) AS EN_21,SUM(EN_22) AS EN_22,SUM(EN_23) AS EN_23,SUM(EN_24) AS EN_24,
	--			SUM(EN_25) AS EN_25,SUM(EN_26) AS EN_26,SUM(EN_27) AS EN_27,SUM(EN_28) AS EN_28,
	--			SUM(EN_29) AS EN_29,SUM(EN_30) AS EN_30,SUM(EN_31) AS EN_31,SUM(EN_32) AS EN_32,
	--			SUM(EN_33) AS EN_33,SUM(EN_34) AS EN_34,SUM(EN_35) AS EN_35,SUM(EN_36) AS EN_36,
	--			SUM(EN_37) AS EN_37,SUM(EN_38) AS EN_38,SUM(EN_39) AS EN_39,SUM(EN_40) AS EN_40,
	--			SUM(EN_41) AS EN_41,SUM(EN_42) AS EN_42,SUM(EN_43) AS EN_43,SUM(EN_44) AS EN_44,
	--			SUM(EN_45) AS EN_45,SUM(EN_46) AS EN_46,SUM(EN_47) AS EN_47,SUM(EN_48) AS EN_48
	--		FROM Inserted                        
	--		GROUP BY Produto, Cor_Produto, Filial
	     
	--		UNION	
	     
	--		SELECT Produto, Cor_Produto, Filial,
	--			SUM(EN_1)*-1 AS EN_1, SUM(EN_2)*-1 AS EN_2, SUM(EN_3)*-1 AS EN_3, SUM(EN_4)*-1 AS EN_4,
	--			SUM(EN_5)*-1 AS EN_5, SUM(EN_6)*-1 AS EN_6, SUM(EN_7)*-1 AS EN_7, SUM(EN_8)*-1 AS EN_8,
	--			SUM(EN_9)*-1 AS EN_9, SUM(EN_10)*-1 AS EN_10,SUM(EN_11)*-1 AS EN_11, SUM(EN_12)*-1 AS EN_12,
	--			SUM(EN_13)*-1 AS EN_13,SUM(EN_14)*-1 AS EN_14,SUM(EN_15)*-1 AS EN_15,SUM(EN_16)*-1 AS EN_16,
	--			SUM(EN_17)*-1 AS EN_17,SUM(EN_18)*-1 AS EN_18,SUM(EN_19)*-1 AS EN_19,SUM(EN_20)*-1 AS EN_20,
	--			SUM(EN_21)*-1 AS EN_21,SUM(EN_22)*-1 AS EN_22,SUM(EN_23)*-1 AS EN_23,SUM(EN_24)*-1 AS EN_24,
	--			SUM(EN_25)*-1 AS EN_25,SUM(EN_26)*-1 AS EN_26,SUM(EN_27)*-1 AS EN_27,SUM(EN_28)*-1 AS EN_28,
	--			SUM(EN_29)*-1 AS EN_29,SUM(EN_30)*-1 AS EN_30,SUM(EN_31)*-1 AS EN_31,SUM(EN_32)*-1 AS EN_32,
	--			SUM(EN_33)*-1 AS EN_33,SUM(EN_34)*-1 AS EN_34,SUM(EN_35)*-1 AS EN_35,SUM(EN_36)*-1 AS EN_36,
	--			SUM(EN_37)*-1 AS EN_37,SUM(EN_38)*-1 AS EN_38,SUM(EN_39)*-1 AS EN_39,SUM(EN_40)*-1 AS EN_40,
	--			SUM(EN_41)*-1 AS EN_41,SUM(EN_42)*-1 AS EN_42,SUM(EN_43)*-1 AS EN_43,SUM(EN_44)*-1 AS EN_44,
	--			SUM(EN_45)*-1 AS EN_45,SUM(EN_46)*-1 AS EN_46,SUM(EN_47)*-1 AS EN_47,SUM(EN_48)*-1 AS EN_48
	--		FROM Deleted
	--		--#8# Inicio
	--	    WHERE @ORIGEM_TRANSITO = 0
	--			OR
	--			(@ORIGEM_TRANSITO = 1 AND  (deleted.ATUALIZOU_ESTOQUE =1 OR DBO.[FX_PARAMETRO] ('CONSIDERA_TRANSITO_ESTOQ')='.T.')) 
	--		--#8# Fim
	--		GROUP BY Produto, Cor_Produto, Filial
	---- Debug (6) Fim
	
	--#8# Inicio
	--IF CURSOR_STATUS('global', 'cur_ESTOQUE_PROD1_ENT') >= -1
	--BEGIN
	--	CLOSE cur_ESTOQUE_PROD1_ENT;
	--	DEALLOCATE cur_ESTOQUE_PROD1_ENT;
	--END
	
	IF CURSOR_STATUS('local', 'cur_ESTOQUE_PROD1_ENT') >= -1
	BEGIN
		CLOSE cur_ESTOQUE_PROD1_ENT;
		DEALLOCATE cur_ESTOQUE_PROD1_ENT;
	END
	--#8# Fim

	--DECLARE cur_ESTOQUE_PROD1_ENT CURSOR FOR	   --#8# 
	DECLARE cur_ESTOQUE_PROD1_ENT CURSOR LOCAL FOR --#8# 
		SELECT A.Produto, A.Cor_Produto, A.Filial,
			SUM(A.EN_1), SUM(A.EN_2), SUM(A.EN_3), SUM(A.EN_4),
			SUM(A.EN_5), SUM(A.EN_6), SUM(A.EN_7), SUM(A.EN_8),
			SUM(A.EN_9), SUM(A.EN_10),SUM(A.EN_11),SUM(A.EN_12),
			SUM(A.EN_13),SUM(A.EN_14),SUM(A.EN_15),SUM(A.EN_16),
			SUM(A.EN_17),SUM(A.EN_18),SUM(A.EN_19),SUM(A.EN_20),
			SUM(A.EN_21),SUM(A.EN_22),SUM(A.EN_23),SUM(A.EN_24),
			SUM(A.EN_25),SUM(A.EN_26),SUM(A.EN_27),SUM(A.EN_28),
			SUM(A.EN_29),SUM(A.EN_30),SUM(A.EN_31),SUM(A.EN_32),
			SUM(A.EN_33),SUM(A.EN_34),SUM(A.EN_35),SUM(A.EN_36),
			SUM(A.EN_37),SUM(A.EN_38),SUM(A.EN_39),SUM(A.EN_40),
			SUM(A.EN_41),SUM(A.EN_42),SUM(A.EN_43),SUM(A.EN_44),
			SUM(A.EN_45),SUM(A.EN_46),SUM(A.EN_47),SUM(A.EN_48)
		FROM
		(
			SELECT Produto, Cor_Produto, Filial,
				SUM(EN_1) AS EN_1, SUM(EN_2) AS EN_2, SUM(EN_3) AS EN_3, SUM(EN_4) AS EN_4,
				SUM(EN_5) AS EN_5, SUM(EN_6) AS EN_6, SUM(EN_7) AS EN_7, SUM(EN_8) AS EN_8,
				SUM(EN_9) AS EN_9, SUM(EN_10) AS EN_10,SUM(EN_11) AS EN_11,SUM(EN_12) AS EN_12,
				SUM(EN_13) AS EN_13,SUM(EN_14) AS EN_14,SUM(EN_15) AS EN_15,SUM(EN_16) AS EN_16,
				SUM(EN_17) AS EN_17,SUM(EN_18) AS EN_18,SUM(EN_19) AS EN_19,SUM(EN_20) AS EN_20,
				SUM(EN_21) AS EN_21,SUM(EN_22) AS EN_22,SUM(EN_23) AS EN_23,SUM(EN_24) AS EN_24,
				SUM(EN_25) AS EN_25,SUM(EN_26) AS EN_26,SUM(EN_27) AS EN_27,SUM(EN_28) AS EN_28,
				SUM(EN_29) AS EN_29,SUM(EN_30) AS EN_30,SUM(EN_31) AS EN_31,SUM(EN_32) AS EN_32,
				SUM(EN_33) AS EN_33,SUM(EN_34) AS EN_34,SUM(EN_35) AS EN_35,SUM(EN_36) AS EN_36,
				SUM(EN_37) AS EN_37,SUM(EN_38) AS EN_38,SUM(EN_39) AS EN_39,SUM(EN_40) AS EN_40,
				SUM(EN_41) AS EN_41,SUM(EN_42) AS EN_42,SUM(EN_43) AS EN_43,SUM(EN_44) AS EN_44,
				SUM(EN_45) AS EN_45,SUM(EN_46) AS EN_46,SUM(EN_47) AS EN_47,SUM(EN_48) AS EN_48
			FROM Inserted                        
			GROUP BY Produto, Cor_Produto, Filial
	     
			UNION	
	     
			SELECT Produto, Cor_Produto, Filial,
				SUM(EN_1)*-1 AS EN_1, SUM(EN_2)*-1 AS EN_2, SUM(EN_3)*-1 AS EN_3, SUM(EN_4)*-1 AS EN_4,
				SUM(EN_5)*-1 AS EN_5, SUM(EN_6)*-1 AS EN_6, SUM(EN_7)*-1 AS EN_7, SUM(EN_8)*-1 AS EN_8,
				SUM(EN_9)*-1 AS EN_9, SUM(EN_10)*-1 AS EN_10,SUM(EN_11)*-1 AS EN_11, SUM(EN_12)*-1 AS EN_12,
				SUM(EN_13)*-1 AS EN_13,SUM(EN_14)*-1 AS EN_14,SUM(EN_15)*-1 AS EN_15,SUM(EN_16)*-1 AS EN_16,
				SUM(EN_17)*-1 AS EN_17,SUM(EN_18)*-1 AS EN_18,SUM(EN_19)*-1 AS EN_19,SUM(EN_20)*-1 AS EN_20,
				SUM(EN_21)*-1 AS EN_21,SUM(EN_22)*-1 AS EN_22,SUM(EN_23)*-1 AS EN_23,SUM(EN_24)*-1 AS EN_24,
				SUM(EN_25)*-1 AS EN_25,SUM(EN_26)*-1 AS EN_26,SUM(EN_27)*-1 AS EN_27,SUM(EN_28)*-1 AS EN_28,
				SUM(EN_29)*-1 AS EN_29,SUM(EN_30)*-1 AS EN_30,SUM(EN_31)*-1 AS EN_31,SUM(EN_32)*-1 AS EN_32,
				SUM(EN_33)*-1 AS EN_33,SUM(EN_34)*-1 AS EN_34,SUM(EN_35)*-1 AS EN_35,SUM(EN_36)*-1 AS EN_36,
				SUM(EN_37)*-1 AS EN_37,SUM(EN_38)*-1 AS EN_38,SUM(EN_39)*-1 AS EN_39,SUM(EN_40)*-1 AS EN_40,
				SUM(EN_41)*-1 AS EN_41,SUM(EN_42)*-1 AS EN_42,SUM(EN_43)*-1 AS EN_43,SUM(EN_44)*-1 AS EN_44,
				SUM(EN_45)*-1 AS EN_45,SUM(EN_46)*-1 AS EN_46,SUM(EN_47)*-1 AS EN_47,SUM(EN_48)*-1 AS EN_48
			FROM Deleted
			--#8# Inicio
		    WHERE @ORIGEM_TRANSITO = 0
				OR
				(@ORIGEM_TRANSITO = 1 AND  (deleted.ATUALIZOU_ESTOQUE =1 OR DBO.[FX_PARAMETRO] ('CONSIDERA_TRANSITO_ESTOQ')='.T.')) 
			--#8# Fim

			GROUP BY Produto, Cor_Produto, Filial
		) A                   
		GROUP BY A.Produto, A.Cor_Produto, A.Filial

    OPEN cur_ESTOQUE_PROD1_ENT

    DECLARE @cProduto Char(12), @cCor_Produto Char(10), @cFilial VarChar(25), @nEstoque Int,
  	    @nEs1  Int, @nEs2  Int, @nEs3  Int, @nEs4  Int, @nEs5  Int, @nEs6  Int, @nEs7  Int, @nEs8  Int,
            @nEs9  Int, @nEs10 Int, @nEs11 Int, @nEs12 Int, @nEs13 Int, @nEs14 Int, @nEs15 Int, @nEs16 Int,
            @nEs17 Int, @nEs18 Int, @nEs19 Int, @nEs20 Int, @nEs21 Int, @nEs22 Int, @nEs23 Int, @nEs24 Int, 
            @nEs25 Int, @nEs26 Int, @nEs27 Int, @nEs28 Int, @nEs29 Int, @nEs30 Int, @nEs31 Int, @nEs32 Int, 
            @nEs33 Int, @nEs34 Int, @nEs35 Int, @nEs36 Int, @nEs37 Int, @nEs38 Int, @nEs39 Int, @nEs40 Int, 
            @nEs41 Int, @nEs42 Int, @nEs43 Int, @nEs44 Int, @nEs45 Int, @nEs46 Int, @nEs47 Int, @nEs48 Int

    FETCH NEXT FROM cur_ESTOQUE_PROD1_ENT INTO @cProduto,@cCor_Produto,@cFilial,
                            @nEs1,  @nEs2,  @nEs3,  @nEs4,  @nEs5,  @nEs6,  @nEs7,  @nEs8,  @nEs9,  @nEs10, @nEs11, @nEs12, 
                 @nEs13, @nEs14, @nEs15, @nEs16, @nEs17, @nEs18, @nEs19, @nEs20, @nEs21, @nEs22, @nEs23, @nEs24, 
                            @nEs25, @nEs26, @nEs27, @nEs28, @nEs29, @nEs30, @nEs31, @nEs32, @nEs33, @nEs34, @nEs35, @nEs36, 
                            @nEs37, @nEs38, @nEs39, @nEs40, @nEs41, @nEs42, @nEs43, @nEs44, @nEs45, @nEs46, @nEs47, @nEs48

    WHILE (@@Fetch_Status = 0)
      BEGIN
 
 		-- Debug (7)
		SELECT 'Debug (7)', @nEs1 as nES1,@nEs2 as nES2,@nEs3 as nES3,@nEs4 as nES4,@nEs5 as nES5,@nEs6 as nES6,@nEs7 as nES7,@nEs8 as nES8
		---

        SELECT @nEstoque = @nEs1 + @nEs2 + @nEs3 + @nEs4 + @nEs5 + @nEs6 + @nEs7 + @nEs8 + @nEs9 + @nEs10 + @nEs11 + @nEs12 + 
                  @nEs13 + @nEs14 + @nEs15 + @nEs16 + @nEs17 + @nEs18 + @nEs19 + @nEs20 + @nEs21 + @nEs22 + @nEs23 + @nEs24 + 
                  @nEs25 + @nEs26 + @nEs27 + @nEs28 + @nEs29 + @nEs30 + @nEs31 + @nEs32 + @nEs33 + @nEs34 + @nEs35 + @nEs36 + 
                  @nEs37 + @nEs38 + @nEs39 + @nEs40 + @nEs41 + @nEs42 + @nEs43 + @nEs44 + @nEs45 + @nEs46 + @nEs47 + @nEs48


		-- Debug (8)
		SELECT  'Debug (8)','COUNT(*) FROM estoque_produtos WHERE PRODUTO=@cProduto AND COR_PRODUTO=@cCor_Produto AND FILIAL=@cFilial'
				,@cProduto,@cCor_Produto,@cFilial
				,(SELECT COUNT(*) FROM estoque_produtos WHERE PRODUTO=@cProduto AND COR_PRODUTO=@cCor_Produto AND FILIAL=@cFilial)
		-- 

		IF (SELECT COUNT(*) FROM estoque_produtos WHERE PRODUTO=@cProduto AND COR_PRODUTO=@cCor_Produto AND FILIAL=@cFilial) > 0
			BEGIN -- Debug

				-- Debug (9) Inicio
				SELECT 'Debug (9): ESTOQUE CALCULADO'
				--,ESTOQUE = ESTOQUE + @nEstoque, 
				--		ULTIMA_ENTRADA = GETDATE(),
				--		ES1 =ES1  + @nES1,  ES2 =ES2  + @nES2,  ES3 =ES3  + @nES3,
				--		ES4 =ES4  + @nES4,  ES5 =ES5  + @nES5,  ES6 =ES6  + @nES6,
				--		ES7 =ES7  + @nES7,  ES8 =ES8  + @nES8,  ES9 =ES9  + @nES9,
				--		ES10=ES10 + @nES10, ES11=ES11 + @nES11, ES12=ES12 + @nES12, 
				--		ES13=ES13 + @nES13, ES14=ES14 + @nES14, ES15=ES15 + @nES15,
				--		ES16=ES16 + @nES16, ES17=ES17 + @nES17, ES18=ES18 + @nES18,
				--		ES19=ES19 + @nES19, ES20=ES20 + @nES20, ES21=ES21 + @nES21,
				--		ES22=ES22 + @nES22, ES23=ES23 + @nES23, ES24=ES24 + @nES24,
				--		ES25=ES25 + @nES25, ES26=ES26 + @nES26, ES27=ES27 + @nES27,
				--		ES28=ES28 + @nES28, ES29=ES29 + @nES29, ES30=ES30 + @nES30,
				--		ES31=ES31 + @nES31, ES32=ES32 + @nES32, ES33=ES33 + @nES33,
				--		ES34=ES34 + @nES34, ES35=ES35 + @nES35, ES36=ES36 + @nES36,
				--		ES37=ES37 + @nES37, ES38=ES38 + @nES38, ES39=ES39 + @nES39,
				--		ES40=ES40 + @nES40, ES41=ES41 + @nES41, ES42=ES42 + @nES42,
				--		ES43=ES43 + @nES43, ES44=ES44 + @nES44, ES45=ES45 + @nES45,
				--		ES46=ES46 + @nES46, ES47=ES47 + @nES47, ES48=ES48 + @nES48
				--FROM estoque_produtos
				--WHERE PRODUTO=@cProduto AND COR_PRODUTO=@cCor_Produto AND FILIAL=@cFilial
				-- Debug (9) Fim

				UPDATE ESTOQUE_PRODUTOS
				SET ESTOQUE = ESTOQUE + @nEstoque, 
						ULTIMA_ENTRADA = GETDATE(),
						ES1 =ES1  + @nES1,  ES2 =ES2  + @nES2,  ES3 =ES3  + @nES3,
						ES4 =ES4  + @nES4,  ES5 =ES5  + @nES5,  ES6 =ES6  + @nES6,
						ES7 =ES7  + @nES7,  ES8 =ES8  + @nES8,  ES9 =ES9  + @nES9,
						ES10=ES10 + @nES10, ES11=ES11 + @nES11, ES12=ES12 + @nES12, 
						ES13=ES13 + @nES13, ES14=ES14 + @nES14, ES15=ES15 + @nES15,
						ES16=ES16 + @nES16, ES17=ES17 + @nES17, ES18=ES18 + @nES18,
						ES19=ES19 + @nES19, ES20=ES20 + @nES20, ES21=ES21 + @nES21,
						ES22=ES22 + @nES22, ES23=ES23 + @nES23, ES24=ES24 + @nES24,
						ES25=ES25 + @nES25, ES26=ES26 + @nES26, ES27=ES27 + @nES27,
						ES28=ES28 + @nES28, ES29=ES29 + @nES29, ES30=ES30 + @nES30,
						ES31=ES31 + @nES31, ES32=ES32 + @nES32, ES33=ES33 + @nES33,
						ES34=ES34 + @nES34, ES35=ES35 + @nES35, ES36=ES36 + @nES36,
						ES37=ES37 + @nES37, ES38=ES38 + @nES38, ES39=ES39 + @nES39,
						ES40=ES40 + @nES40, ES41=ES41 + @nES41, ES42=ES42 + @nES42,
						ES43=ES43 + @nES43, ES44=ES44 + @nES44, ES45=ES45 + @nES45,
						ES46=ES46 + @nES46, ES47=ES47 + @nES47, ES48=ES48 + @nES48
				FROM estoque_produtos
				WHERE PRODUTO=@cProduto AND COR_PRODUTO=@cCor_Produto AND FILIAL=@cFilial

			END -- Debug
 		ELSE
          INSERT INTO Estoque_Produtos (Produto,Cor_Produto,Filial,Estoque, ULTIMA_ENTRADA,
                    Es1,  Es2,  Es3,  Es4,  Es5,  Es6,  Es7,  Es8,  Es9,  Es10, Es11, Es12, Es13, Es14, Es15, Es16,  
                    Es17, Es18, Es19, Es20, Es21, Es22, Es23, Es24, Es25, Es26, Es27, Es28, Es29, Es30, Es31, Es32,
                    Es33, Es34, Es35, Es36, Es37, Es38, Es39, Es40, Es41, Es42, Es43, Es44, Es45, Es46, Es47, Es48)
             VALUES(@cProduto, @cCor_Produto, @cFilial, @nEstoque, GETDATE(),
                    @nEs1,  @nEs2,@nEs3,  @nEs4,@nEs5,  @nEs6,@nEs7,  @nEs8,
                    @nEs9,  @nEs10,@nEs11, @nEs12,@nEs13, @nEs14,@nEs15, @nEs16,
                    @nEs17, @nEs18,@nEs19, @nEs20,@nEs21, @nEs22,@nEs23, @nEs24,
                    @nEs25, @nEs26,@nEs27, @nEs28,@nEs29, @nEs30,@nEs31, @nEs32,
                    @nEs33, @nEs34,@nEs35, @nEs36,@nEs37, @nEs38,@nEs39, @nEs40,
                    @nEs41, @nEs42,@nEs43, @nEs44,@nEs45, @nEs46,@nEs47, @nEs48)

          IF @@ROWCOUNT = 0
		  BEGIN
            select @errno  = 30002,
                   @errmsg = 'Operação Cancelada, Não foi Possível Atualizar #ESTOQUE_PRODUTOS#.'
            goto error
          END

		-------------------------------------------------------------------------
		-- #7# Inicio 
		-------------------------------------------------------------------------
		--IF @ORIGEM_TRANSITO = 1
		--BEGIN
			UPDATE	ESTOQUE_PROD1_ENT
			SET		ATUALIZOU_ESTOQUE =1
			FROM	ESTOQUE_PROD1_ENT
				JOIN	inserted 
					ON  ESTOQUE_PROD1_ENT.ROMANEIO_PRODUTO	=inserted.ROMANEIO_PRODUTO 
					AND ESTOQUE_PROD1_ENT.FILIAL			=inserted.FILIAL 
					AND ESTOQUE_PROD1_ENT.PRODUTO			=inserted.PRODUTO
					AND ESTOQUE_PROD1_ENT.COR_PRODUTO		=inserted.COR_PRODUTO
			WHERE	ESTOQUE_PROD1_ENT.PRODUTO			=@cProduto
			AND		ESTOQUE_PROD1_ENT.COR_PRODUTO		=@cCor_Produto
			AND		ESTOQUE_PROD1_ENT.FILIAL			=@cFilial
		--END
		-------------------------------------------------------------------------
		-- #7# Fim
		-------------------------------------------------------------------------

        FETCH NEXT FROM cur_ESTOQUE_PROD1_ENT INTO @cProduto, @cCor_Produto, @cFilial,
                            @nEs1,  @nEs2,  @nEs3,  @nEs4,  @nEs5,  @nEs6,  @nEs7,  @nEs8,  @nEs9,  @nEs10, @nEs11, @nEs12, 
                            @nEs13, @nEs14, @nEs15, @nEs16, @nEs17, @nEs18, @nEs19, @nEs20, @nEs21, @nEs22, @nEs23, @nEs24, 
                            @nEs25, @nEs26, @nEs27, @nEs28, @nEs29, @nEs30, @nEs31, @nEs32, @nEs33, @nEs34, @nEs35, @nEs36, 
                            @nEs37, @nEs38, @nEs39, @nEs40, @nEs41, @nEs42, @nEs43, @nEs44, @nEs45, @nEs46, @nEs47, @nEs48
      END


    CLOSE cur_ESTOQUE_PROD1_ENT
    DEALLOCATE cur_ESTOQUE_PROD1_ENT

   END
END -- #7# FIM
   

/*---------------------------------------------------------------------------------------------------------------------*/
/*--LINX---------------------------------------------------------------------------------*/
IF UPDATE(ORDEM_PRODUCAO) OR UPDATE(TAREFA) OR
	UPDATE(EN_1) OR UPDATE(EN_2) OR UPDATE(EN_3) OR UPDATE(EN_4) OR UPDATE(EN_5) OR UPDATE(EN_6) OR
	UPDATE(EN_7) OR UPDATE(EN_8) OR UPDATE(EN_9) OR UPDATE(EN_10) OR UPDATE(EN_11) OR UPDATE(EN_12) OR
	UPDATE(EN_13) OR UPDATE(EN_14) OR UPDATE(EN_15) OR UPDATE(EN_16) OR UPDATE(EN_17) OR UPDATE(EN_18) OR
	UPDATE(EN_19) OR UPDATE(EN_20) OR UPDATE(EN_21) OR UPDATE(EN_22) OR UPDATE(EN_23) OR UPDATE(EN_24) OR
	UPDATE(EN_25) OR UPDATE(EN_26) OR UPDATE(EN_27) OR UPDATE(EN_28) OR UPDATE(EN_29) OR UPDATE(EN_30) OR
	UPDATE(EN_31) OR UPDATE(EN_32) OR UPDATE(EN_33) OR UPDATE(EN_34) OR UPDATE(EN_35) OR UPDATE(EN_36) OR
	UPDATE(EN_37) OR UPDATE(EN_38) OR UPDATE(EN_39) OR UPDATE(EN_40) OR UPDATE(EN_41) OR UPDATE(EN_42) OR
	UPDATE(EN_43) OR UPDATE(EN_44) OR UPDATE(EN_45) OR UPDATE(EN_46) OR UPDATE(EN_47) OR UPDATE(EN_48)
BEGIN
	DECLARE @VALOR NUMERIC(14,2)-- ADICIONADO POR SZALONTAI EM 14/12/05
	DECLARE @CUSTO1 NUMERIC(14,2),@CUSTO2 NUMERIC(14,2),@CUSTO3 NUMERIC(14,2),@CUSTO4 NUMERIC(14,2)--#1# 

	DECLARE CurUpdate_Estoque_Prod1_Ent CURSOR LOCAL FOR 
		SELECT 	Romaneio_Produto, Filial /*ISNULL(FILIAIS.MATRIZ_FISCAL,INSERTED.FILIAL)#5#*/,Produto,Cor_Produto,Tarefa,Ordem_Producao,ISNULL(Qtde,0), 
			ISNULL(En_1,0) ,ISNULL(En_2,0) ,ISNULL(En_3,0) ,ISNULL(En_4,0) ,ISNULL(En_5,0) ,ISNULL(En_6,0) ,ISNULL(En_7,0) ,ISNULL(En_8,0) ,ISNULL(En_9,0) ,ISNULL(En_10,0),ISNULL(En_11,0),ISNULL(En_12,0),
			ISNULL(En_13,0),ISNULL(En_14,0),ISNULL(En_15,0),ISNULL(En_16,0),ISNULL(En_17,0),ISNULL(En_18,0),ISNULL(En_19,0),ISNULL(En_20,0),ISNULL(En_21,0),ISNULL(En_22,0),ISNULL(En_23,0),ISNULL(En_24,0),
			ISNULL(En_25,0),ISNULL(En_26,0),ISNULL(En_27,0),ISNULL(En_28,0),ISNULL(En_29,0),ISNULL(En_30,0),ISNULL(En_31,0),ISNULL(En_32,0),ISNULL(En_33,0),ISNULL(En_34,0),ISNULL(En_35,0),ISNULL(En_36,0),
			ISNULL(En_37,0),ISNULL(En_38,0),ISNULL(En_39,0),ISNULL(En_40,0),ISNULL(En_41,0),ISNULL(En_42,0),ISNULL(En_43,0),ISNULL(En_44,0),ISNULL(En_45,0),ISNULL(En_46,0),ISNULL(En_47,0),ISNULL(En_48,0),
			ISNULL(VALOR,0)-- ADICIONADO POR SZALONTAI EM 14/12/05
			,ISNULL(CUSTO1,0),ISNULL(CUSTO2,0),ISNULL(CUSTO3,0),ISNULL(CUSTO4,0) --#1# 
		FROM INSERTED
			--JOIN FILIAIS ON INSERTED.FILIAL = FILIAIS.FILIAL --#4# --#5#
		UNION
		SELECT 	Romaneio_Produto,/*#4# Filial */ISNULL(FILIAIS.MATRIZ_FISCAL,DELETED.FILIAL)/*#4#*/,Produto,Cor_Produto,Tarefa,Ordem_Producao,ISNULL(Qtde,0)*-1,
			ISNULL(En_1,0)*-1 ,ISNULL(En_2,0)*-1 ,ISNULL(En_3,0)*-1 ,ISNULL(En_4,0)*-1 ,ISNULL(En_5,0)*-1 ,ISNULL(En_6,0)*-1 ,ISNULL(En_7,0)*-1 ,ISNULL(En_8,0)*-1 ,ISNULL(En_9,0)*-1 ,ISNULL(En_10,0)*-1,ISNULL(En_11,0)*-1,ISNULL(En_12,0)*-1,
			ISNULL(En_13,0)*-1,ISNULL(En_14,0)*-1,ISNULL(En_15,0)*-1,ISNULL(En_16,0)*-1,ISNULL(En_17,0)*-1,ISNULL(En_18,0)*-1,ISNULL(En_19,0)*-1,ISNULL(En_20,0)*-1,ISNULL(En_21,0)*-1,ISNULL(En_22,0)*-1,ISNULL(En_23,0)*-1,ISNULL(En_24,0)*-1,
			ISNULL(En_25,0)*-1,ISNULL(En_26,0)*-1,ISNULL(En_27,0)*-1,ISNULL(En_28,0)*-1,ISNULL(En_29,0)*-1,ISNULL(En_30,0)*-1,ISNULL(En_31,0)*-1,ISNULL(En_32,0)*-1,ISNULL(En_33,0)*-1,ISNULL(En_34,0)*-1,ISNULL(En_35,0)*-1,ISNULL(En_36,0)*-1,
			ISNULL(En_37,0)*-1,ISNULL(En_38,0)*-1,ISNULL(En_39,0)*-1,ISNULL(En_40,0)*-1,ISNULL(En_41,0)*-1,ISNULL(En_42,0)*-1,ISNULL(En_43,0)*-1,ISNULL(En_44,0)*-1,ISNULL(En_45,0)*-1,ISNULL(En_46,0)*-1,ISNULL(En_47,0)*-1,ISNULL(En_48,0)*-1,
			ISNULL(VALOR,0)*-1-- ADICIONADO POR SZALONTAI EM 14/12/05
			,ISNULL(CUSTO1,0)*-1,ISNULL(CUSTO2,0)*-1,ISNULL(CUSTO3,0)*-1,ISNULL(CUSTO4,0)*-1--#1# 
		FROM DELETED
			JOIN FILIAIS ON DELETED.FILIAL = FILIAIS.FILIAL --#4#

	OPEN CurUpdate_Estoque_Prod1_Ent
	
	FETCH NEXT FROM CurUpdate_Estoque_Prod1_Ent INTO @insRomaneio_Produto,@insFilial,@insProduto,@insCor_Produto,@insTarefa,@insOrdem_Producao,@insQtde, 
			@insEn_1 ,@insEn_2 ,@insEn_3 ,@insEn_4 ,@insEn_5 ,@insEn_6 ,@insEn_7 ,@insEn_8 ,@insEn_9 ,@insEn_10,@insEn_11,@insEn_12,
			@insEn_13,@insEn_14,@insEn_15,@insEn_16,@insEn_17,@insEn_18,@insEn_19,@insEn_20,@insEn_21,@insEn_22,@insEn_23,@insEn_24,
			@insEn_25,@insEn_26,@insEn_27,@insEn_28,@insEn_29,@insEn_30,@insEn_31,@insEn_32,@insEn_33,@insEn_34,@insEn_35,@insEn_36,
			@insEn_37,@insEn_38,@insEn_39,@insEn_40,@insEn_41,@insEn_42,@insEn_43,@insEn_44,@insEn_45,@insEn_46,@insEn_47,@insEn_48,
			@VALOR-- ADICIONADO POR SZALONTAI EM 14/12/05
			,@CUSTO1 ,@CUSTO2 ,@CUSTO3 ,@CUSTO4 --#1# 
	IF @@rowcount >= 0
	BEGIN

		WHILE @@fetch_status = 0
		BEGIN

			if @insTarefa is not null
			begin

				SELECT @insData_Emissao=Emissao From Estoque_Prod_Ent where Romaneio_produto=@insRomaneio_Produto and Filial = @InsFilial
				
	        		IF (SELECT COUNT(*) FROM Producao_Tarefas_Saldo WHERE Tarefa=@insTarefa AND Ordem_Producao=@insOrdem_Producao AND Produto=@insProduto AND Cor_Produto=@insCor_Produto)>0
						IF (SELECT COUNT(*) FROM Producao_Tarefas_Saldo 
							WHERE Tarefa=@insTarefa AND Ordem_Producao=@insOrdem_Producao AND Produto=@insProduto AND Cor_Produto=@insCor_Produto AND 
								S1 -@insEn_1 =0 AND S2 -@insEn_2 =0 AND S3 -@insEn_3 =0 AND S4 -@insEn_4 =0 AND S5 -@insEn_5 =0 AND S6 -@insEn_6 =0 AND S7 -@insEn_7 =0 AND S8 -@insEn_8 =0 AND 
								S9 -@insEn_9 =0 AND S10-@insEn_10=0 AND S11-@insEn_11=0 AND S12-@insEn_12=0 AND S13-@insEn_13=0 AND S14-@insEn_14=0 AND S15-@insEn_15=0 AND S16-@insEn_16=0 AND 
								S17-@insEn_17=0 AND S18-@insEn_18=0 AND S19-@insEn_19=0 AND S20-@insEn_20=0 AND S21-@insEn_21=0 AND S22-@insEn_22=0 AND S23-@insEn_23=0 AND S24-@insEn_24=0 AND 
								S25-@insEn_25=0 AND S26-@insEn_26=0 AND S27-@insEn_27=0 AND S28-@insEn_28=0 AND S29-@insEn_29=0 AND S30-@insEn_30=0 AND S31-@insEn_31=0 AND S32-@insEn_32=0 AND 
								S33-@insEn_33=0 AND S34-@insEn_34=0 AND S35-@insEn_35=0 AND S36-@insEn_36=0 AND S37-@insEn_37=0 AND S38-@insEn_38=0 AND S39-@insEn_39=0 AND S40-@insEn_40=0 AND 
								S41-@insEn_41=0 AND S42-@insEn_42=0 AND S43-@insEn_43=0 AND S44-@insEn_44=0 AND S45-@insEn_45=0 AND S46-@insEn_46=0 AND S47-@insEn_47=0 AND S48-@insEn_48=0) > 0
		
							DELETE 	FROM Producao_Tarefas_Saldo
							WHERE Tarefa=@insTarefa AND Ordem_Producao=@insOrdem_Producao AND Produto=@insProduto AND Cor_Produto=@insCor_Produto
						ELSE
							UPDATE Producao_Tarefas_Saldo SET QTDE_S=QTDE_S-(@InsQtde),
								S1 =S1 -(@insEn_1) ,S2 =S2 -(@insEn_2) ,S3 =S3 -(@insEn_3) ,S4 =S4 -(@insEn_4) ,S5 =S5 -(@insEn_5) ,S6 =S6 -(@insEn_6) ,S7 =S7 -(@insEn_7) ,S8 =S8 -(@insEn_8) ,
								S9 =S9 -(@insEn_9) ,S10=S10-(@insEn_10),S11=S11-(@insEn_11),S12=S12-(@insEn_12),S13=S13-(@insEn_13),S14=S14-(@insEn_14),S15=S15-(@insEn_15),S16=S16-(@insEn_16),
								S17=S17-(@insEn_17),S18=S18-(@insEn_18),S19=S19-(@insEn_19),S20=S20-(@insEn_20),S21=S21-(@insEn_21),S22=S22-(@insEn_22),S23=S23-(@insEn_23),S24=S24-(@insEn_24),
								S25=S25-(@insEn_25),S26=S26-(@insEn_26),S27=S27-(@insEn_27),S28=S28-(@insEn_28),S29=S29-(@insEn_29),S30=S30-(@insEn_30),S31=S31-(@insEn_31),S32=S32-(@insEn_32),
								S33=S33-(@insEn_33),S34=S34-(@insEn_34),S35=S35-(@insEn_35),S36=S36-(@insEn_36),S37=S37-(@insEn_37),S38=S38-(@insEn_38),S39=S39-(@insEn_39),S40=S40-(@insEn_40),
								S41=S41-(@insEn_41),S42=S42-(@insEn_42),S43=S43-(@insEn_43),S44=S44-(@insEn_44),S45=S45-(@insEn_45),S46=S46-(@insEn_46),S47=S47-(@insEn_47),S48=S48-(@insEn_48)
								WHERE Tarefa=@insTarefa AND Ordem_Producao=@insOrdem_Producao AND Produto=@insProduto AND Cor_Produto=@insCor_Produto
					ELSE
						INSERT Producao_Tarefas_Saldo (Tarefa,Ordem_Producao,Produto,Cor_Produto,Qtde_S,
							S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16,S17,S18,S19,S20,S21,S22,S23,S24,
							S25,S26,S27,S28,S29,S30,S31,S32,S33,S34,S35,S36,S37,S38,S39,S40,S41,S42,S43,S44,S45,S46,S47,S48)
						VALUES (@InsTarefa,@InsOrdem_Producao,@InsProduto,@InsCor_Produto,Abs(@insQtde),
							Abs(@insEn_1), Abs(@insEn_2), Abs(@insEn_3), Abs(@insEn_4), Abs(@insEn_5), Abs(@insEn_6), Abs(@insEn_7), Abs(@insEn_8), Abs(@insEn_9), Abs(@insEn_10),Abs(@insEn_11),Abs(@insEn_12),
							Abs(@insEn_13),Abs(@insEn_14),Abs(@insEn_15),Abs(@insEn_16),Abs(@insEn_17),Abs(@insEn_18),Abs(@insEn_19),Abs(@insEn_20),Abs(@insEn_21),Abs(@insEn_22),Abs(@insEn_23),Abs(@insEn_24),
							Abs(@insEn_25),Abs(@insEn_26),Abs(@insEn_27),Abs(@insEn_28),Abs(@insEn_29),Abs(@insEn_30),Abs(@insEn_31),Abs(@insEn_32),Abs(@insEn_33),Abs(@insEn_34),Abs(@insEn_35),Abs(@insEn_36),
							Abs(@insEn_37),Abs(@insEn_38),Abs(@insEn_39),Abs(@insEn_40),Abs(@insEn_41),Abs(@insEn_42),Abs(@insEn_43),Abs(@insEn_44),Abs(@insEn_45),Abs(@insEn_46),Abs(@insEn_47),Abs(@insEn_48))
	
				
				UPDATE PRODUCAO_TAREFAS SET QTDE_EM_PROCESSO=QTDE_EM_PROCESSO-(@InsQtde),
						    QTDE_FINALIZADA =QTDE_FINALIZADA+(@InsQtde) ,
						    ENCERRAMENTO = @insData_Emissao,
							valor_tarefa = valor_tarefa + @VALOR -- ADICIONADO POR SZALONTAI EM 14/12/05
				WHERE TAREFA = @insTarefa

			end

			UPDATE PRODUCAO_ORDEM_COR SET QTDE_P = QTDE_P-@insQtde,
				P1 =P1 -@insEn_1 ,P2 =P2 -@insEn_2 ,P3 =P3 -@insEn_3 ,P4 =P4 -@insEn_4 ,P5 =P5 -@insEn_5 ,P6 =P6 -@insEn_6 ,P7 =P7 -@insEn_7 ,P8 =P8 -@insEn_8,
				P9 =P9 -@insEn_9 ,P10=P10-@insEn_10,P11=P11-@insEn_11,P12=P12-@insEn_12,P13=P13-@insEn_13,P14=P14-@insEn_14,P15=P15-@insEn_15,P16=P16-@insEn_16,
				P17=P17-@insEn_17,P18=P18-@insEn_18,P19=P19-@insEn_19,P20=P20-@insEn_20,P21=P21-@insEn_21,P22=P22-@insEn_22,P23=P23-@insEn_23,P24=P24-@insEn_24,
				P25=P25-@insEn_25,P26=P26-@insEn_26,P27=P27-@insEn_27,P28=P28-@insEn_28,P29=P29-@insEn_29,P30=P30-@insEn_30,P31=P31-@insEn_31,P32=P32-@insEn_32,
				P33=P33-@insEn_33,P34=P34-@insEn_34,P35=P35-@insEn_35,P36=P36-@insEn_36,P37=P37-@insEn_37,P38=P38-@insEn_38,P39=P39-@insEn_39,P40=P40-@insEn_40,
				P41=P41-@insEn_41,P42=P42-@insEn_42,P43=P43-@insEn_43,P44=P44-@insEn_44,P45=P45-@insEn_45,P46=P46-@insEn_46,P47=P47-@insEn_47,P48=P48-@insEn_48
			WHERE ORDEM_PRODUCAO=@insOrdem_Producao AND PRODUTO = @insProduto AND COR_PRODUTO =@insCor_Produto
	

			UPDATE PRODUCAO_ORDEM SET QTDE_EM_PRODUCAO = QTDE_EM_PRODUCAO-(@insQtde)
	   			WHERE ORDEM_PRODUCAO=@insOrdem_Producao

			Select @insTotal=sum(qtde_p) From producao_ordem_cor 
        	  		Where ORDEM_PRODUCAO=@insOrdem_Producao Group by ordem_producao
    

			If (@insTotal = 0)
			begin
				Update producao_ordem Set qtde_em_producao = @insTotal, 
						Status = 'E',
						encerramento = @insData_Emissao
					Where ORDEM_PRODUCAO=@insOrdem_Producao
				UPDATE PRODUCAO_RESERVA SET RESERVA   = 0 , 
						DIFERENCA_PREVISAO =RESERVA_ORIGINAL - consumida 
					Where ORDEM_PRODUCAO=@insOrdem_Producao
			end

			if (@insTotal <> 0)
			begin
				Update producao_ordem Set qtde_em_producao = @insTotal, 
							Status = 'P',
							encerramento = null
					Where ORDEM_PRODUCAO=@insOrdem_Producao
			
				UPDATE PRODUCAO_RESERVA SET RESERVA   = CASE WHEN (RESERVA_ORIGINAL - consumida  > 0 AND MATAR_SALDO_RESERVA=0) 
                                      THEN (RESERVA_ORIGINAL - consumida ) ELSE 0 END,                                                        
                                            DIFERENCA_PREVISAO = CASE WHEN (RESERVA_ORIGINAL - consumida  < 0 OR MATAR_SALDO_RESERVA=1) THEN  (RESERVA_ORIGINAL - consumida) ELSE 0 END 
					Where ORDEM_PRODUCAO=@insOrdem_Producao
			end	

			----#3# - Inicio

					----#1# - Inicio
					---- TRATAMENTO PARA OP DE RETRABALHO
					--SELECT @TIPO_PROCESSO = TIPO_PROCESSO 
					--FROM PRODUCAO_ORDEM A 
					--Where ORDEM_PRODUCAO=@insOrdem_Producao
			
					--IF @TIPO_PROCESSO =5
					--BEGIN

					--	-- 1) SAIDA DO PRODUTO DE RETRALHO
					--	UPDATE ESTOQUE_PROD1_SAI SET 
					--			CUSTO1=CUSTO1+@CUSTO1,
					--			CUSTO2=CUSTO2+@CUSTO2,
					--			CUSTO3=CUSTO3+@CUSTO3,
					--			CUSTO4=CUSTO4+@CUSTO4,
					--			QTDE = QTDE-@insQtde,
					--		SA_1 =SA_1 +@insEn_1 ,SA_2 =SA_2 +@insEn_2 ,SA_3 =SA_3 +@insEn_3 ,SA_4 =SA_4 +@insEn_4 ,SA_5 =SA_5 +@insEn_5 ,SA_6 =SA_6 +@insEn_6 ,SA_7 =SA_7 +@insEn_7 ,SA_8 =SA_8 +@insEn_8,
					--		SA_9 =SA_9 +@insEn_9 ,SA_10=SA_10+@insEn_10,SA_11=SA_11+@insEn_11,SA_12=SA_12+@insEn_12,SA_13=SA_13+@insEn_13,SA_14=SA_14+@insEn_14,SA_15=SA_15+@insEn_15,SA_16=SA_16+@insEn_16,
					--		SA_17=SA_17+@insEn_17,SA_18=SA_18-@insEn_18,SA_19=SA_19+@insEn_19,SA_20=SA_20+@insEn_20,SA_21=SA_21+@insEn_21,SA_22=SA_22+@insEn_22,SA_23=SA_23+@insEn_23,SA_24=SA_24+@insEn_24,
					--		SA_25=SA_25+@insEn_25,SA_26=SA_26+@insEn_26,SA_27=SA_27+@insEn_27,SA_28=SA_28+@insEn_28,SA_29=SA_29+@insEn_29,SA_30=SA_30+@insEn_30,SA_31=SA_31+@insEn_31,SA_32=SA_32+@insEn_32,
					--		SA_33=SA_33+@insEn_33,SA_34=SA_34+@insEn_34,SA_35=SA_35+@insEn_35,SA_36=SA_36+@insEn_36,SA_37=SA_37+@insEn_37,SA_38=SA_38+@insEn_38,SA_39=SA_39+@insEn_39,SA_40=SA_40+@insEn_40,
					--		SA_41=SA_41+@insEn_41,SA_42=SA_42+@insEn_42,SA_43=SA_43+@insEn_43,SA_44=SA_44+@insEn_44,SA_45=SA_45+@insEn_45,SA_46=SA_46+@insEn_46,SA_47=SA_47+@insEn_47,SA_48=SA_48+@insEn_48
					--	WHERE ROMANEIO_PRODUTO = 'O'+@insRomaneio_Produto AND FILIAL = @insFilial AND PRODUTO = @insProduto AND COR_PRODUTO =@insCor_Produto

					--	-- 2) TABELA MOVIMENTACOES_INTERNAS_PA		
					--	UPDATE  D
					--	SET QTDE_TRANSF =  QTDE_TRANSF+@insQtde,
					--		CUSTO_DESMEMBRADO = CUSTO_DESMEMBRADO+@CUSTO1
					--	FROM PRODUTO_MONTAGEM_KIT A
					--	INNER JOIN PRODUCAO_ORDEM_COR B ON	A.PRODUTO = B.PRODUTO AND 
					--								A.COR_PRODUTO = B.COR_PRODUTO
					--	INNER JOIN PRODUCAO_ORDEM C ON B.ORDEM_PRODUCAO = C.ORDEM_PRODUCAO	
					--	INNER JOIN MOVIMENTACOES_INTERNAS_PA D on	D.PRODUTO = B.PRODUTO AND 
					--												D.COR_PRODUTO = B.COR_PRODUTO AND 
					--												D.PRODUTO_DESTINO = A.KIT_PRODUTO AND 
					--												D.COR_PRODUTO_DESTINO = A.KIT_COR_PRODUTO
					--	WHERE	D.ROMANEIO_PRODUTO = 'O'+@insRomaneio_Produto and
					--			D.ROMANEIO_DESTINO = 'D'+@insRomaneio_Produto and
					--			D.FILIAL = @insFilial and
					--			B.PRODUTO = @insProduto and 
					--			B.COR_PRODUTO = @insCor_Produto and 
					--			c.ORDEM_PRODUCAO=@insOrdem_Producao


					--	-- 3) FAZ A ATUALIZAÇÃO DO PRODUTO PA VIA PROCEDURE LX_GERA_MOVIMENTACOES_INTERNAS_PA
					--	set @insRomaneio_Produto='D'+@insRomaneio_Produto
					--	EXEC LX_GERA_MOVIMENTACOES_INTERNAS_PA	@FILIAL = @insFilial,	@ROMANEIO_DESTINO =@insRomaneio_Produto		


					--	UPDATE D
					--	SET ESTOQUE = ESTOQUE + @insQtde, 
					--			ULTIMA_ENTRADA = GETDATE(),
					--			ES1 =ES1  + @insEn_1,  ES2 =ES2  + @insEn_2,  ES3 =ES3  + @insEn_3,
					--			ES4 =ES4  + @insEn_4,  ES5 =ES5  + @insEn_5,  ES6 =ES6  + @insEn_6,
					--			ES7 =ES7  + @insEn_7,  ES8 =ES8  + @insEn_8,  ES9 =ES9  + @insEn_9,
					--			ES10=ES10 + @insEn_10, ES11=ES11 + @insEn_11, ES12=ES12 + @insEn_12, 
					--			ES13=ES13 + @insEn_13, ES14=ES14 + @insEn_14, ES15=ES15 + @insEn_15,
					--			ES16=ES16 + @insEn_16, ES17=ES17 + @insEn_17, ES18=ES18 + @insEn_18,
					--			ES19=ES19 + @insEn_19, ES20=ES20 + @insEn_20, ES21=ES21 + @insEn_21,
					--			ES22=ES22 + @insEn_22, ES23=ES23 + @insEn_23, ES24=ES24 + @insEn_24,
					--			ES25=ES25 + @insEn_25, ES26=ES26 + @insEn_26, ES27=ES27 + @insEn_27,
					--			ES28=ES28 + @insEn_28, ES29=ES29 + @insEn_29, ES30=ES30 + @insEn_30,
					--			ES31=ES31 + @insEn_31, ES32=ES32 + @insEn_32, ES33=ES33 + @insEn_33,
					--			ES34=ES34 + @insEn_34, ES35=ES35 + @insEn_35, ES36=ES36 + @insEn_36,
					--			ES37=ES37 + @insEn_37, ES38=ES38 + @insEn_38, ES39=ES39 + @insEn_39,
					--			ES40=ES40 + @insEn_40, ES41=ES41 + @insEn_41, ES42=ES42 + @insEn_42,
					--			ES43=ES43 + @insEn_43, ES44=ES44 + @insEn_44, ES45=ES45 + @insEn_45,
					--			ES46=ES46 + @insEn_46, ES47=ES47 + @insEn_47, ES48=ES48 + @insEn_48
					--	FROM PRODUTO_MONTAGEM_KIT A
					--	INNER JOIN PRODUCAO_ORDEM_COR B ON	A.PRODUTO = B.PRODUTO AND 
					--								A.COR_PRODUTO = B.COR_PRODUTO
					--	INNER JOIN PRODUCAO_ORDEM C ON B.ORDEM_PRODUCAO = C.ORDEM_PRODUCAO	
					--	INNER JOIN ESTOQUE_PRODUTOS D on	D.PRODUTO = A.KIT_PRODUTO AND 
					--										D.COR_PRODUTO = A.KIT_COR_PRODUTO

					--	WHERE B.PRODUTO=@cProduto AND B.COR_PRODUTO=@cCor_Produto AND D.FILIAL=@cFilial and 
					--			c.ORDEM_PRODUCAO=@insOrdem_Producao


					--END/*@TIPO_PROCESSO =5*/
					----#1# - Fim
			
			----#3# - Fim

			FETCH NEXT FROM CurUpdate_Estoque_Prod1_Ent INTO @insRomaneio_Produto,@insFilial,@insProduto,@insCor_Produto,@insTarefa,@insOrdem_Producao,@insQtde, 
					@insEn_1 ,@insEn_2 ,@insEn_3 ,@insEn_4 ,@insEn_5 ,@insEn_6 ,@insEn_7 ,@insEn_8 ,@insEn_9 ,@insEn_10,@insEn_11,@insEn_12,
					@insEn_13,@insEn_14,@insEn_15,@insEn_16,@insEn_17,@insEn_18,@insEn_19,@insEn_20,@insEn_21,@insEn_22,@insEn_23,@insEn_24,
					@insEn_25,@insEn_26,@insEn_27,@insEn_28,@insEn_29,@insEn_30,@insEn_31,@insEn_32,@insEn_33,@insEn_34,@insEn_35,@insEn_36,
					@insEn_37,@insEn_38,@insEn_39,@insEn_40,@insEn_41,@insEn_42,@insEn_43,@insEn_44,@insEn_45,@insEn_46,@insEn_47,@insEn_48,
					@VALOR-- ADICIONADO POR SZALONTAI EM 14/12/05
					,@CUSTO1 ,@CUSTO2 ,@CUSTO3 ,@CUSTO4 --#1# 


		END /* WHILE @@fetch_status = 0 */

	END /* IF @@rowcount >= 0 */

	CLOSE CurUpdate_Estoque_Prod1_Ent
	DEALLOCATE CurUpdate_Estoque_Prod1_Ent
END
/*---------------------------------------------------------------------------------------*/

/*-- Atualiza Custo Reposicao -----------------------------------------------------------*/
IF EXISTS(SELECT VALOR_ATUAL FROM PARAMETROS WHERE PARAMETRO='ENTRADA_ATUALIZA_CUSTO_PA' AND VALOR_ATUAL <> 0)
BEGIN
	DECLARE @cNOME_CLIFOR_NF VARCHAR(25), @cNF_ENTRADA_NF CHAR(15), @cSERIE_NF_ENTRADA_NF CHAR(6), @cPRODUTO_NF CHAR(12), @cCOR_PRODUTO_NF CHAR(10)
	DECLARE CUR_NF CURSOR FOR
		SELECT DISTINCT B.NOME_CLIFOR, B.NF_ENTRADA, B.SERIE_NF_ENTRADA, A.PRODUTO, A.COR_PRODUTO
		FROM INSERTED A
			JOIN ESTOQUE_PROD_ENT B ON B.ROMANEIO_PRODUTO=A.ROMANEIO_PRODUTO AND B.FILIAL=A.FILIAL

	OPEN CUR_NF
	FETCH NEXT FROM CUR_NF INTO @cNOME_CLIFOR_NF, @cNF_ENTRADA_NF, @cSERIE_NF_ENTRADA_NF, @cPRODUTO_NF, @cCOR_PRODUTO_NF
	WHILE @@FETCH_STATUS=0
	BEGIN		
		exec LX_ATUALIZA_CUSTO_REPOSICAO_PA @cNOME_CLIFOR_NF, @cNF_ENTRADA_NF, @cSERIE_NF_ENTRADA_NF, @cPRODUTO_NF, @cCOR_PRODUTO_NF
		FETCH NEXT FROM CUR_NF INTO @cNOME_CLIFOR_NF, @cNF_ENTRADA_NF, @cSERIE_NF_ENTRADA_NF, @cPRODUTO_NF, @cCOR_PRODUTO_NF
	END
	CLOSE CUR_NF
	DEALLOCATE CUR_NF
END
/*---------------------------------------------------------------------------------------*/

/*---------------------------------------------------------------------------------------*/
--#6# inicio
IF EXISTS(SELECT VALOR_ATUAL FROM PARAMETROS WHERE PARAMETRO='CTRL_CUSTO_PARA_TRANSF' AND RTRIM(LTRIM(VALOR_ATUAL)) = '.T.')
BEGIN
    DELETE H
	FROM CUSTO_COMPRAS_HISTORICO H
	INNER JOIN (
		SELECT ROMANEIO_PRODUTO, FILIAL, PRODUTO, COR_PRODUTO
		FROM INSERTED
		UNION ALL
		SELECT ROMANEIO_PRODUTO, FILIAL, PRODUTO, COR_PRODUTO
		FROM DELETED
	) AS D
		ON H.ROMANEIO_PRODUTO = D.ROMANEIO_PRODUTO
		AND H.FILIAL = D.FILIAL
		AND H.PRODUTO = D.PRODUTO
		AND H.COR_PRODUTO = D.COR_PRODUTO
		AND H.TIPO_MOVIMENTO = 0;

	WITH CTE_COMPRAS_HISTORICO AS
    (
        SELECT 
            '0' AS TIPO_MOVIMENTO,
            RTRIM(A.ROMANEIO_PRODUTO) + 
            (CASE WHEN ISNULL(G.NF_ENTRADA, '') = '' THEN '' ELSE '/' END) + RTRIM(ISNULL(G.NF_ENTRADA, '')) AS DOC,
            ('OP:' + RTRIM(ISNULL(B.ORDEM_PRODUCAO, '')) + '/PED:' + RTRIM(ISNULL(B.PEDIDO, '')) + '/OS:' + 
             RTRIM(ISNULL(B.ORDEM_SERVICO, ''))) AS OP_PED_ROMAN,
            G.NF_ENTRADA AS NOTA_FISCAL,
            G.SERIE_NF_ENTRADA AS SERIE_NF, 
            G.ESPECIE_SERIE,
            A.PRODUTO,
            A.COR_PRODUTO, 
            A.FILIAL, 
            G.RECEBIMENTO AS EMISSAO, 
            G.NATUREZA,
            A.QTDE,
            A.VALOR,
            (CASE WHEN ISNULL(G.NF_ENTRADA, '') = '' 
                  THEN 'ENTRADA NORMAL' 
                  ELSE (CASE WHEN RTRIM(ISNULL(B.PEDIDO, '')) = '' 
                             THEN 'ENTRADA DE NF' 
                             ELSE 'ENTRADA DE NF POR PEDIDO' 
                        END) 
            END) AS DESC_TIPO_MOVIMENTO,
            GETDATE() AS DATA_HISTORICO,
			A.ROMANEIO_PRODUTO
        FROM INSERTED A
             INNER JOIN ESTOQUE_PROD_ENT B WITH (NOLOCK) ON B.ROMANEIO_PRODUTO = A.ROMANEIO_PRODUTO AND 
                                                          B.FILIAL = A.FILIAL
             INNER JOIN ENTRADAS G WITH (NOLOCK) ON G.NF_ENTRADA = B.NF_ENTRADA AND 
                                                  G.NOME_CLIFOR = B.NOME_CLIFOR AND 
                                                  G.SERIE_NF_ENTRADA = B.SERIE_NF_ENTRADA
             INNER JOIN PRODUTOS P WITH (NOLOCK) ON P.PRODUTO = A.PRODUTO
			 INNER JOIN NATUREZAS_ENTRADAS C WITH (NOLOCK)  ON C.NATUREZA = G.NATUREZA
		     LEFT JOIN CTB_LX_TIPO_OPERACAO TTO WITH (NOLOCK) ON TTO.CTB_TIPO_OPERACAO = C.CTB_TIPO_OPERACAO
		WHERE ISNULL(TTO.TIPO_OPERACAO, C.TIPO_OPERACAO) <> 'D'

		UNION ALL

		SELECT 
            '0' AS TIPO_MOVIMENTO,
            RTRIM(A.ROMANEIO_PRODUTO) AS DOC,
            ( 'OP:' + RTRIM(ISNULL(B.ORDEM_PRODUCAO, '')) + '/PED:' + RTRIM(ISNULL(B.PEDIDO, '')) + '/OS:' + 
	         RTRIM(ISNULL(B.ORDEM_SERVICO, '')) ) AS OP_PED_ROMAN,
            NULL AS NOTA_FISCAL,
            NULL AS SERIE_NF, 
            NULL AS ESPECIE_SERIE,
            A.PRODUTO,
            A.COR_PRODUTO, 
            A.FILIAL, 
            B.EMISSAO, 
            NULL AS NATUREZA,
            A.QTDE,
            A.VALOR,
            'ENTRADA POR OP' AS DESC_TIPO_MOVIMENTO,
            GETDATE() AS DATA_HISTORICO,
			A.ROMANEIO_PRODUTO
        FROM INSERTED A
             INNER JOIN ESTOQUE_PROD_ENT B WITH (NOLOCK) ON B.ROMANEIO_PRODUTO = A.ROMANEIO_PRODUTO AND 
                                                          B.FILIAL = A.FILIAL
             INNER JOIN PRODUTOS P WITH (NOLOCK) ON P.PRODUTO = A.PRODUTO
		WHERE B.ORDEM_PRODUCAO IS NOT NULL AND 
	      ISNULL(B.TIPO_ENTRADA, 1) NOT IN ( 3, 4 )

		UNION ALL

		SELECT 
            '0' AS TIPO_MOVIMENTO,
            RTRIM(A.ROMANEIO_PRODUTO) + ( CASE WHEN ISNULL(G.NF_ENTRADA, '') = '' THEN '' ELSE '/' END ) + RTRIM(ISNULL(G.NF_ENTRADA, '')) AS DOC,
            ( 'OP:' + RTRIM(ISNULL(B.ORDEM_PRODUCAO, '')) + '/PED:' + RTRIM(ISNULL(B.PEDIDO, '')) + '/OS:' + 
	        RTRIM(ISNULL(B.ORDEM_SERVICO, '')) ) AS OP_PED_ROMAN,
            G.NF_ENTRADA AS NOTA_FISCAL,
            G.SERIE_NF_ENTRADA AS SERIE_NF, 
            G.ESPECIE_SERIE,
            A.PRODUTO,
            A.COR_PRODUTO, 
            A.FILIAL, 
            ISNULL(G.RECEBIMENTO,B.EMISSAO) AS EMISSAO, 
            G.NATUREZA,
            A.QTDE,
            A.VALOR,
            (CASE WHEN ISNULL(G.NF_ENTRADA, '') = '' 
	            THEN ( CASE WHEN TIPO_ENTRADA = '4' 
	                      THEN 'ENTRADA POR DEVOLUÇÃO' 
	                      ELSE ( CASE WHEN B.ROMANEIO_ORIGEM IS NOT NULL AND B.FILIAL_ORIGEM IS NOT NULL 
	                                THEN 'ENTRADA POR TRANSFERENCIA'
	                                ELSE 'ENTRADA NORMAL' 
	                             END )
	                   END ) 
	            ELSE ( CASE WHEN ISNULL(TTO.TIPO_OPERACAO, C.TIPO_OPERACAO) = 'D' 
	                      THEN 'ENTRADA DE NF POR DEVOLUÇÃO'
	                      ELSE ( CASE WHEN RTRIM(ISNULL(B.PEDIDO, '')) = '' 
	                                THEN 'ENTRADA DE NF' 
	                                ELSE 'ENTRADA DE NF POR PEDIDO' 
	                             END ) 
	                   END ) 
	        END) AS DESC_TIPO_MOVIMENTO,
            GETDATE() AS DATA_HISTORICO,
			A.ROMANEIO_PRODUTO
        FROM INSERTED A
             INNER JOIN ESTOQUE_PROD_ENT B WITH (NOLOCK) ON B.ROMANEIO_PRODUTO = A.ROMANEIO_PRODUTO AND 
                                                          B.FILIAL = A.FILIAL
             LEFT JOIN ENTRADAS G WITH (NOLOCK) ON G.NF_ENTRADA = B.NF_ENTRADA AND 
                                                  G.NOME_CLIFOR = B.NOME_CLIFOR AND 
                                                  G.SERIE_NF_ENTRADA = B.SERIE_NF_ENTRADA
             INNER JOIN PRODUTOS P WITH (NOLOCK) ON P.PRODUTO = A.PRODUTO
			 LEFT JOIN NATUREZAS_ENTRADAS C WITH (NOLOCK)  ON C.NATUREZA = G.NATUREZA
		     LEFT JOIN CTB_LX_TIPO_OPERACAO TTO WITH (NOLOCK) ON TTO.CTB_TIPO_OPERACAO = C.CTB_TIPO_OPERACAO
		WHERE B.ORDEM_PRODUCAO IS NULL AND 
			( G.NF_ENTRADA IS NULL OR 
	        ISNULL(TTO.TIPO_OPERACAO,C.TIPO_OPERACAO) = 'D' )

    )

    INSERT INTO CUSTO_COMPRAS_HISTORICO 
        (TIPO_MOVIMENTO, DOC, OP_PED_ROMAN, NOTA_FISCAL, SERIE_NF, ESPECIE_SERIE, PRODUTO, COR_PRODUTO, FILIAL, EMISSAO, NATUREZA, QTDE, VALOR, DESC_TIPO_MOVIMENTO, DATA_HISTORICO, ROMANEIO_PRODUTO)
    SELECT 
        TIPO_MOVIMENTO, DOC, OP_PED_ROMAN, NOTA_FISCAL, SERIE_NF, ESPECIE_SERIE, 
        PRODUTO, COR_PRODUTO, FILIAL, EMISSAO, NATUREZA, QTDE, VALOR, 
        DESC_TIPO_MOVIMENTO, DATA_HISTORICO, ROMANEIO_PRODUTO
    FROM CTE_COMPRAS_HISTORICO;
END;
--#6# fim
/*---------------------------------------------------------------------------------------*/


  return
error:
	raiserror (@errmsg, 16, 1)
    rollback transaction
end
GO

ALTER TABLE [dbo].[ESTOQUE_PROD1_ENT] ENABLE TRIGGER [LXU_ESTOQUE_PROD1_ENT]
GO


