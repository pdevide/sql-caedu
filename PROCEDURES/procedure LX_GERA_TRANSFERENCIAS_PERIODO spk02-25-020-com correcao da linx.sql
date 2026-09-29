CREATE or ALTER PROCEDURE [dbo].[LX_GERA_TRANSFERENCIAS_PERIODO] @DATA_INICIAL  DATETIME, 
														@DATA_FINAL    DATETIME, 
														@FILIAL_FILTRO VARCHAR(25) = NULL, 
														@FILIAL_ORIGEM VARCHAR(25) = NULL, 
														@EMPRESA       INT, 
														@CHAVE_NFE	   VARCHAR(44) = NULL
AS 
	-- 28/10/2024 - CARLOS ALBERTO	   - LINXERP-20619 - 01.24.020 - #45# - AJUSTE NO USO DA FUNÇÃO FX_PARAMETRO
	-- 09/06/2023 - CARLOS ALBERTO     - LINXERP-13765 - 01.23.030 - #44#  - GERAR IMPOSTOS DE NOTA DE ENTRADA CONFORME EXCEÇÃO - CONTROLADO POR FLAG NA EXCEÇÃO E NA TELA DE GERAÇÃO DE TRANSFERÊNCIAS.
	-- 06/06/2023 - CARLOS ALBERTO     - LINXERP-14857 - 01.23.030 - #43#  - MELHORIA DE PERFORMANCE.
	-- 12/03/2020 - JULIANA NASCIMENTO - MODASP-11643  - 01.20     - #41#  - AJUSTE NA CORREÇÃO #33# NA VALIDAÇÃO DA MATRIZ FISCAL NA CHAMADA DA FUNÇÃO FX_ID_EXCECAO_IMPOSTO 
	-- 30/05/2019 - RODRIGO SOUZA      - ID 120049     - 01.19.040 - #40#  - CORREÇÃO PARA PREENCHER O CAMPO PRECO_UNITARIO_ORIGINAL DA TABELA ENTRADAS_ITEM. 
	-- 21/09/2018 - CARLOS ALBERTO     - ID 95070      - 03.18.010 - #39#  - POSSIBILITAR LEVAR OS DESCONTOS CONCEDIDOS POR CONDIÇÃO DE PAGAMENTO NO FATURAMENTO PARA A NOTA DE ENTRADA GERADA.
	-- 29/08/2018 - CARLOS ALBERTO     - ID 74289      - 02.18.030 - #38#  - TRAZER OS DADOS DE TRIBUTAÇÃO ICMS E TRIBUTAÇÃO ORIGEM DA EXCEÇÃO DE IMPOSTO, QUANDO HOUVER.
	-- 09/08/2018 - CRISPIM/CARLOS     - ID 88404      - 02.18.010 - #37#  - MELHORIA DE PERFORMANCE.
    -- 21/03/2018 - CARLOS ALBERTO	   - ID 66662	   - 01.18.010 - #36#  - REVISÃO DA CONDIÇÃO DE GERAÇÃO DE NOTA DE ENTRADA COM O PARÂMETRO VERIFICA_LOJA_ENTRADA ATIVADO.
    -- 11/12/2017 - CARLOS ALBERTO	   - ID 54117	   - 03.17.010 - #35#  - AJUSTE NA VALIDAÇÃO DO PARÂMETRO VERIFICA_LOJA_ENTRADA
    -- 19/10/2017 - JAQUE LAURENTI	   - ID 45023	   - SPK 3.17  - #34#  - REALIZAR O UPDATE NOS DADOS DE NF DE ENTRADA DA TABELA AF_LOCAL_ENTRADA QUANDO A NOTA FOR DE TRANSF DE ATIVO
	-- 29/03/2017 - JAQUE LAURENTI     - ID 26888      - 01.17.000 - #33#  - INCLUSÃO DA VALIDAÇÃO DA MATRIZ FISCAL NA CHAMADA DA FUNÇÃO FX_ID_EXCECAO_IMPOSTO 
    -- 18/01/2017 - LUCAS SOUZA        - ID 18058      - 01.17     - #32#  - VALIDAR O PARAMETRO VERIFICA_LOJA_ENTRADA
    -- 25/11/2016 - CARLOS ALBERTO     - ID 12951      - 01.17     - #31#  - REVISÃO NOS PARÂMETROS DA FUNÇÃO FX_ID_EXCECAO_IMPOSTO.
    -- 03/10/2016 - CARLOS ALBERTO     - ID 9972       - 01.17     - #30#  - AJUSTE NA VERIFICAÇÃO DE NOTAS A SEREM GERADAS POR TRANSFERÊNCIA, COM ORIGEM NAS NOTAS DE LOJA. ESTAVA COMPARANDO A FILIAL DA NOTA DE LOJA COM O CLIENTE DA NOTA DE FATURAMENTO. AJUSTADO PARA COMPARAR A FILIAL ORIGEM DA NOTA DE ENTRADA NA LOJA COM A FILIAL DA NOTA DE SAÍDA EMITIDA NA LOJA.
    -- 26/09/2016 - CARLOS ALBERTO     - ID 8410       - 02.16     - #29#  - INCLUSÃO DO CAMPO INFORMACAO_COMPLEMENTAR DA TABELA LOJA_NOTA_FISCAL NA GERAÇÃO DAS NOTAS DE TRANSFERÊNCIA. NÃO ESTAVA ALIMENTANDO O CAMPO DE OBSERVAÇÃO NAS NOTAS GERADAS, CAUSANDO PROBLEMA NA GERAÇÃO DO REGISTRO C110 DO SPED.
    -- 01/09/2016 - CARLOS ALBERTO     - ID 8410       - 02.16     - #28#  - INCLUSÃO DO CAMPO OBS DA TABELA LOJA_NOTA_FISCAL NA GERAÇÃO DAS NOTAS DE TRANSFERÊNCIA. NÃO ESTAVA ALIMENTANDO O CAMPO DE OBSERVAÇÃO NAS NOTAS GERADAS, CAUSANDO PROBLEMA NA GERAÇÃO DO REGISTRO C110 DO SPED.
    -- 10/08/2016 - CARLOS ALBERTO     - ID 7559       - 01.16.010 - #27#  - AJUSTE NA CRIAÇÃO DA TABELA TEMPORÁRIA #TMP_ITEM_IMPRESSAO PARA PADRONIZAR O COLLATE DOS CAMPOS CHAR E VARCHAR.
    -- 26/07/2016 - CARLOS ALBERTO     - ID 2077       - 01.16.010 - #26#  - RETIRADA A ALTERAÇÃO #20# PARA QUE SEJA ANALISADA NOVAMENTE. PROVAVELMENTE É PROBLEMA OPERACIONAL DO CLIENTE SOLICITANTE DA DEMANDA.
    -- 15/07/2016 - CARLOS ALBERTO     - ID 2339       - 01.16.010 - #25#  - ALTERAÇÃO NA CRIAÇÃO DAS TEMPORÁRIAS #TMP_IMPOSTO_ENT E #TMP_ITEM_IMPRESSAO PARA NÃO NOMEAR AS CONSTRAINTS. DESSA FORMA EVITAMOS CONFLITOS QUANDO MAIS DE UMA ESTAÇÃO EXECUTA A ROTINA SIMULTANEAMENTE.
    -- 05/07/2016 - CARLOS ALBERTO     - ID 5836       - 02.16     - #24#  - AJUSTE NA GERAÇÃO DA DATA DE RECEBIMENTO DE NOTAS VINDAS DA TABELA LOJA_ENTRADAS PARA NÃO GRAVAR HORAS:MINUTOS:SEGUNDOS.
    -- 30/06/2016 - CARLOS ALBERTO     - ID 5267       - 01.16.010 - #23#  - RETIRADA DA ALTERAÇÃO #19#, O TRATAMENTO DA SÉRIE SERÁ FEITO NA GERAÇÃO DO SPED FISCAL E CONTRIBUIÇÕES.
    -- 11/05/2016 - CARLOS ALBERTO     - ID 2718       - 01.16.010 - #22#  - INCLUSÃO DE ATUALIZAÇÃO DO CAMPO EMPRESA NA INSERÇÃO DE DADOS NA TABELA ENTRADAS, PARA GERAÇÃO DE TRANSFERÊNCIAS.
    -- 06/05/2016 - Crispim            - ID 2685       - 01.16.010 - #21#  - Melhoria de performace no processo de integração de notas fiscais.
    -- 12/04/2016 - CARLOS ALBERTO     - ID 2077       - 01.16.010 - #20# - CORREÇÃO NA RESTRIÇÃO DE VERIFICAÇÃO DE EXISTÊNICA DE NOTA DE ENTRADA EM LOJAS. INCLUÍDA VERIFICAÇÃO POR DATA DE EMISSÃO, PERMITINDO NOTAS COM MESMO NÚMERO SEREM TRANSFERIDAS CONFORME A NECESSIDADE.
    -- 16/03/2016 - CARLOS ALBERTO     - ID 2080       - 01.16.010 - #19# - INFORMAR OS CAMPOS NF_PROPRIA_EMITIDA E NF_ENTRADA_PROPRIA COM 1 NA GERAÇÃO DAS NOTAS DE TRANSFERÊNCIA. NOTAS DE TRANSFERÊNCIA GERADAS SÃO DE EMISSÃO PRÓPRIA, É NECESSÁRIO MARCAR ESSE CAMPO PARA A SÉRIE SER APRESENTADA CORRETAMENTE NA GERAÇÃO DOS SPED FISCAL E CONTRIBUIÇÕES.
    -- 05/01/2016 - LUCAS SOUZA        - ID 1420       - 01.16    - #18# - INCLUIR VALIDAÇÃO DE TRANSFERÊNCIA FEITA TAMBÉM PELO CAMPO NUMERO_NF_TRANSFERENCIA 
    -- 27/08/2015 - DANIEL GONCALVES   - TP 9960678    - 01.15.003 - #17# - INCLUIDO UPDATE PARA O ITEM_IMPRESSAO NA TABELA LOJA_ENTRADAS_PRODUTO.
    -- 07/05/2015 - CARLOS ALBERTO     - TP 8423432    - 01.15.003 - #16# - CORREÇÃO NA INFORMAÇÃO DA DATA DE RECEBIMENTO PARA NOTAS DE TRANSFERÊNCIA ENTRE FILIAIS.
    -- 27/04/2015 - MARCELO FUSTINI    - TP 8431242    - 01.15.002 - #15# - INSERIDO O CAMPO AGRUPAMENTO_ITENS
    -- 28/01/2015 - CARLOS ALBERTO     - TP 7686302    - 01.15.002 - #14# - INCLUSÃO DE DADOS NO CAMPO ORIGEM_ITEM PARA NOTAS DE TRANSFERÊNCIA.
    -- 23/09/2014 - LUCAS SOUZA        - TP 6232145    - 02.14.002 - #13# - UTILIZAR CHAVE TRANSPORTADORA PARA FAZER LEFT JOINT COM A TABELA DE TRANSPORTADORAS
    -- 26/08/2014 - LUCAS SOUZA        - TP 6232145    - 02.14.002 - #12# - UTILIZAR DATA DE CONFERÊNCIA DA ENTRADA NA LOJA COMO DATA DE RECEBIMENTO DA NOTA
    -- 05/08/2014 - WENDEL CRESPIGIO   - TP 6043906    - 02.14.001 - #11# - ADICIONADO TRATAMENTO PARA CONVERTER A DATA DE RECEBIMENTO PARA O PADRÃO SEM HORAS [AAAAMMDD].
    -- 21/07/2014 - CARLOS ALBERTO     - TP 6031839    - 02.14.001 - #10# - AJUSTE NA COMPARAÇÃO DO MODELO FISCAL DAS NOTAS PARA EVITAR A CONVERSÃO DE DADOS IMPLÍCITA NA CONDIÇÃO DAS QUERYS.
    -- 12/05/2014 - DANIEL GONCALVES   - TP 5504795    - 02.14.000 - #9# - INCLUIDO LEFT JOIN PARA A TABELA DE TRANSPORTADORA.
    -- 28/03/2014 - CARLOS ALBERTO     - TP 5318138    - 02.14.000 - #8# - ATUALIZADO O CAMPO TRANSPORTADORA_A_PAGAR NA TABELA ENTRADAS COM A TRANSPORTADORA DAS NOTAS DE SAÍDA VERIFICANDO LOJA_ENTRADAS.
    -- 15/01/2014 - CARLOS ALBERTO     - TP 4935924    - #7# - ATUALIZADO O CAMPO TRANSPORTADORA_A_PAGAR NA TABELA ENTRADAS COM A TRANSPORTADORA DAS NOTAS DE SAÍDA.
    -- 19/12/2013 - WENDEL CRESPIGIO   - TP 4829574    - #6# - ADICIONADO FILTRO PARA SOMENTE LEVAR NOTAS MODELO 55 QUANDO APROVADAS PELA SEFAZ.
    -- 28/10/2013 - DANIEL GONCALVES   - TP 4529078    - #5# - INCLUSÃO DOS CAMPOS FIN_EMISSAO_NFE, TIPO_EMISSAO_NFE E STATUS_NFE NOS SELECTS DE FATURAMENTO.
    -- 01/10/2013 - WENDEL CRESPIGIO   - TP 4395487    - #4# - ALTERAÇÃO DO SELECT COM LEFT PARA INNER JOIN COMO ERA ANTES NÃO ESTAVA SENDO INTEGRADO NOTAS DE CONSUMIVEIS.
    -- 21/08/2013 - DANIEL GONCALVES   - TP 4228418    - #3# - ALTERADO O LEFT JOIN PARA INNER JOIN NAS TEMPORARIAS DE ENTRADAS E ENTRADAS ITEM.
    -- 27/06/2013 - MARCELO FUSTINI    - TP 3945475    - #2# - ACERTO NAS DATAS DE EMISSÃO E RECEBIMENTO DA INTEGRAÇÃO VERIFICANDO LOJA_ENTRADAS
    -- 06/05/2013 - MARCELO FUSTINI    - TP 3699899    - #1# - ALTERADOS CURSORES DE READ_ONLY PARA FAST_FORWARD
    -- 03/05/2013 - MARCELO FUSTINI    - TP 3699899    - PROCEDURE REESCRITA PARA EVITAR BLOCKING E ATENDER MELHORIA DE PERFORMANCE
    SET NOCOUNT ON; 

    --------------------------------------------------------------------------------------------------------------------------------------     
    DECLARE @FILIAL                     VARCHAR(25), 
            @NF_SAIDA                   CHAR(15), 
            @SERIE_NF                   CHAR(6), 
            @ESPECIE_SERIE              INT, 
            @NOME_CLIFOR_CUR            VARCHAR(25), 
            @NF_ENTRADA_CUR             VARCHAR(15), 
            @SERIE_NF_ENTRADA_CUR       CHAR(6), 
            @TIPO_PRODUCAO              VARCHAR(6), 
            @TIPO_ENTRADAS_PADRAO       VARCHAR(25), 
            @RATEIO_CENTRO_CUSTO_PADRAO VARCHAR(15), 
            @MOEDA_PADRAO               VARCHAR(6), 
            @VERIFICA_LOJA_ENTRADAS     BIT,
			@CONTABILIDADE_ATIVA		BIT, /*#43#*/
			@RECALCULAR_IMPOSTO_EXCECAO BIT  /*#44#*/
			
    DECLARE @ROWSENTITEM				BIGINT, 
            @COUNT						BIGINT, 
            @ROWSLOJAENTITEM			BIGINT; --> #21# Declaração de variáveis posteriormente utilizadas para atualização em lotes  
    -----------------------------------------------------------------------------------------------------------------------------------------------     
    SELECT @ESPECIE_SERIE = Cast(VALOR_ATUAL AS INT) 
    FROM   PARAMETROS 
    WHERE  PARAMETRO = 'ESPECIE_SERIE_AUTO'; 

    SELECT @TIPO_PRODUCAO = VALOR_ATUAL 
    FROM   PARAMETROS 
    WHERE  PARAMETRO = 'TIPO_PRODUCAO'; 

    SELECT @TIPO_ENTRADAS_PADRAO = Rtrim(VALOR_ATUAL) 
    FROM   PARAMETROS 
    WHERE  PARAMETRO = 'TIPO_ENTRADA_PADRAO'; 

    SELECT @RATEIO_CENTRO_CUSTO_PADRAO = Rtrim(VALOR_ATUAL) 
    FROM   PARAMETROS 
    WHERE  PARAMETRO = 'RATEIO_CENTRO_CST_PADRAO'; 

	/*#43#*/
    SELECT @CONTABILIDADE_ATIVA = CASE WHEN ISNULL(VALOR_ATUAL, '.F.') = '.T.' THEN 1 ELSE 0 END 
    FROM   PARAMETROS(NOLOCK) 
    WHERE  PARAMETRO = 'CONTABILIDADE_ATIVA'; 
	/*#43#*/

    SELECT @VERIFICA_LOJA_ENTRADAS = CASE WHEN ISNULL(VALOR_ATUAL, '.F.') = '.T.' THEN 1 ELSE 0 END 
    FROM   PARAMETROS(NOLOCK) 
    WHERE  PARAMETRO = 'VERIFICA_LOJA_ENTRADA'; 

    SELECT @VERIFICA_LOJA_ENTRADAS = ISNULL(@VERIFICA_LOJA_ENTRADAS, 0); 

    SELECT @MOEDA_PADRAO = MOEDA 
    FROM   MOEDAS 
    WHERE  INDICA_PADRAO = 1; 

    -- #21# Declaração de variável para definição de contexto com o objetivo de evitar multiplas validações desnecessárias em triggers.
    --      Criação de tabela temporária para alterar a geração dos impostos, atualimente feito linha a linha, para lotes.   
    DECLARE @CONTEXT VARBINARY(100); 

    CREATE TABLE #TMP_IMPOSTO_ENT 
      ( 
         NOME_CLIFOR      VARCHAR(25) COLLATE DATABASE_DEFAULT, 
         NF_ENTRADA       CHAR(15) COLLATE DATABASE_DEFAULT, 
         SERIE_NF_ENTRADA VARCHAR(6) COLLATE DATABASE_DEFAULT, 
         GERA_IMPOSTO     BIT NOT NULL, 
         /*#25#constraint XPK#TMP_IMPOSTO_ENT*/ 
         PRIMARY KEY(NF_ENTRADA, SERIE_NF_ENTRADA, NOME_CLIFOR) 
      ); 

    -----------------------------------------------------------------------------------------------------------------------------------------------     
    -- TABELA TEMP DE FATURAMENTO  
    -- APENAS TRANSFERÊNCIAS QUE NÃO SEJAM PARA LOJAS/*#12#*/  
    SELECT DISTINCT FAT.FILIAL, 
                    FAT.NF_SAIDA, 
                    FAT.SERIE_NF, 
                    FAT.NOME_CLIFOR, 
                    FAT.NATUREZA_SAIDA, 
                    FAT.CONDICAO_PGTO, 
                    FAT.TABELA_FILHA, 
                    FAT.EMISSAO, 
                    FAT.QTDE_TOTAL, 
                    FAT.TIMESTAMP, 
                    FAT.VALOR_TOTAL, 
                    FAT.FRETE, 
                    FAT.SEGURO, 
                    FAT.ENCARGO, 
                    DESCONTO = CASE WHEN FAT.DESCONTO_COND_PGTO = 0 THEN FAT.DESCONTO ELSE FAT.DESCONTO_COND_PGTO END, /*#39#*/
                    FAT.ICMS, 
                    FAT.ICMS_BASE, 
                    FAT.IPI_VALOR, 
                    FAT.ACERTO_CONTAS_P_R, 
                    FAT.NF_FATURA, 
                    FAT.DEVOLUCAO, 
                    FAT.MOEDA, 
                    FAT.VALOR_IMPOSTO_AGREGAR, 
                    FAT.RATEIO_CENTRO_CUSTO, 
                    FAT.VALOR_SUB_ITENS, 
                    FAT.CHAVE_NFE, 
                    FAT.PROTOCOLO_AUTORIZACAO_NFE, 
                    FAT.DATA_AUTORIZACAO_NFE, 
                    FAT.FIN_EMISSAO_NFE,--#5#  
                    FAT.TIPO_EMISSAO_NFE,--#5#  
                    FAT.STATUS_NFE,--#5#  
                    FAT.TRANSPORTADORA,--#7#  
                    FAT.EMISSAO AS DATA_RECEBIMENTO,/*#12#*/ 
                    FAT.AGRUPAMENTO_ITENS /*#15#*/, 
                    INDICA_TRANSFERENCIA_PARA_LOJA = 0 /*#32#*/ 
    INTO   #FATURAMENTO 
    FROM   FATURAMENTO AS FAT(NOLOCK) 
           JOIN EMPRESA AS EMP(NOLOCK) 
             ON EMP.EMPRESA = FAT.EMPRESA 
           JOIN NATUREZAS_SAIDAS AS NS(NOLOCK) 
             ON FAT.NATUREZA_SAIDA = NS.NATUREZA_SAIDA 
           JOIN NATUREZAS_ENTRADAS AS NE(NOLOCK) 
             ON NS.NATUREZA_ENTRADA_AUTOMATICA = NE.NATUREZA 
           JOIN FILIAIS AS F(NOLOCK) 
             ON FAT.NOME_CLIFOR = F.FILIAL 
           JOIN FILIAIS AS F2(NOLOCK) 
             ON FAT.FILIAL = F2.FILIAL 
           INNER JOIN SERIES_NF AS SN --#6#  
                   ON SN.SERIE_NF = FAT.SERIE_NF 
           INNER JOIN CTB_ESPECIE_SERIE AS CES --#6#  
                   ON CES.ESPECIE_SERIE = SN.ESPECIE_SERIE 
           LEFT JOIN LOJA_ENTRADAS AS LE /*#12#*/ 
                  ON FAT.FILIAL = LE.FILIAL_ORIGEM /*#12#*/ 
                     AND FAT.NF_SAIDA = ISNULL(LE.NUMERO_NF_TRANSFERENCIA, LE.ROMANEIO_NF_SAIDA) /*#18# #12#*/
                     AND FAT.SERIE_NF = LE.SERIE_NF_ENTRADA /*#12#*/ 
    WHERE  FAT.EMPRESA = @EMPRESA 
           AND F.INDICA_BENEFICIADOR = 0 
           AND F.INDICA_FRANQUIA = 0 
           AND FAT.NOTA_CANCELADA = 0 
           AND ISNULL(F.MATRIZ_FISCAL, '') <> ISNULL(F2.MATRIZ_FISCAL, '') 
           AND ( FAT.NOME_CLIFOR = @FILIAL_FILTRO 
                  OR @FILIAL_FILTRO IS NULL ) 
           AND ( FAT.FILIAL = @FILIAL_ORIGEM 
                  OR @FILIAL_ORIGEM IS NULL ) 
           AND ( FAT.CHAVE_NFE = @CHAVE_NFE 
                  OR @CHAVE_NFE IS NULL ) 
           AND FAT.EMISSAO BETWEEN @DATA_INICIAL AND @DATA_FINAL 
           AND ( CES.NUMERO_MODELO_FISCAL = '55' 
                 AND FAT.STATUS_NFE = 5 --#6#  --#10#  
                  OR CES.NUMERO_MODELO_FISCAL <> '55' ) --#6#  --#10#  
           AND NOT EXISTS (SELECT 1 
                           FROM   ENTRADAS AS ENT(NOLOCK) 
                           WHERE  ENT.NOME_CLIFOR = FAT.FILIAL 
                                  AND ENT.NF_ENTRADA = FAT.NF_SAIDA 
                                  AND ENT.SERIE_NF_ENTRADA = FAT.SERIE_NF) 
           AND ISNULL(LE.NUMERO_NF_TRANSFERENCIA, LE.ROMANEIO_NF_SAIDA) IS NULL; /*#18# #12#*/

    -- APENAS TRANSFERÊNCIAS QUE SEJAM PARA LOJAS/*#12#*/  
    INSERT INTO #FATURAMENTO 
    SELECT DISTINCT FAT.FILIAL, 
                    FAT.NF_SAIDA, 
                    FAT.SERIE_NF, 
                    FAT.NOME_CLIFOR, 
                    FAT.NATUREZA_SAIDA, 
                    FAT.CONDICAO_PGTO, 
                    FAT.TABELA_FILHA, 
                    FAT.EMISSAO, 
                    FAT.QTDE_TOTAL, 
                    FAT.TIMESTAMP, 
                    FAT.VALOR_TOTAL, 
                    FAT.FRETE, 
                    FAT.SEGURO, 
                    FAT.ENCARGO, 
                    DESCONTO = CASE WHEN FAT.DESCONTO_COND_PGTO = 0 THEN FAT.DESCONTO ELSE FAT.DESCONTO_COND_PGTO END, /*#39#*/
                    FAT.ICMS, 
                    FAT.ICMS_BASE, 
                    FAT.IPI_VALOR, 
                    FAT.ACERTO_CONTAS_P_R, 
                    FAT.NF_FATURA, 
                    FAT.DEVOLUCAO, 
                    FAT.MOEDA, 
                    FAT.VALOR_IMPOSTO_AGREGAR, 
                    FAT.RATEIO_CENTRO_CUSTO, 
                    FAT.VALOR_SUB_ITENS, 
                    FAT.CHAVE_NFE, 
                    FAT.PROTOCOLO_AUTORIZACAO_NFE, 
                    FAT.DATA_AUTORIZACAO_NFE, 
                    FAT.FIN_EMISSAO_NFE,--#5#  
                    FAT.TIPO_EMISSAO_NFE,--#5#  
                    FAT.STATUS_NFE,--#5#  
                    FAT.TRANSPORTADORA,--#7#  
                    Cast(CONVERT(CHAR(8), COALESCE(LE.DATA_ENTRADA_CONFERIDA, LE.EMISSAO, FAT.EMISSAO), 112) AS DATETIME),/*#24#*/
                    --#24#COALESCE(LE.DATA_ENTRADA_CONFERIDA, LE.EMISSAO, FAT.EMISSAO),/*#12#*/  
                    FAT.AGRUPAMENTO_ITENS,/*#15#*/ 
                    INDICA_TRANSFERENCIA_PARA_LOJA = 1 /*#32#*/
    FROM   FATURAMENTO AS FAT(NOLOCK) 
           JOIN EMPRESA AS EMP(NOLOCK) 
             ON EMP.EMPRESA = FAT.EMPRESA 
           JOIN NATUREZAS_SAIDAS AS NS(NOLOCK) 
             ON FAT.NATUREZA_SAIDA = NS.NATUREZA_SAIDA 
           JOIN NATUREZAS_ENTRADAS AS NE(NOLOCK) 
             ON NS.NATUREZA_ENTRADA_AUTOMATICA = NE.NATUREZA 
           JOIN FILIAIS AS F(NOLOCK) 
             ON FAT.NOME_CLIFOR = F.FILIAL 
           JOIN FILIAIS AS F2(NOLOCK) 
             ON FAT.FILIAL = F2.FILIAL 
           INNER JOIN SERIES_NF AS SN --#6#  
                   ON SN.SERIE_NF = FAT.SERIE_NF 
           INNER JOIN CTB_ESPECIE_SERIE AS CES --#6#  
                   ON CES.ESPECIE_SERIE = SN.ESPECIE_SERIE 
           INNER JOIN LOJA_ENTRADAS AS LE 
                   ON FAT.FILIAL = LE.FILIAL_ORIGEM 
                      AND FAT.NF_SAIDA = ISNULL(LE.NUMERO_NF_TRANSFERENCIA, LE.ROMANEIO_NF_SAIDA) /*#18#*/
                      AND FAT.SERIE_NF = LE.SERIE_NF_ENTRADA 
    WHERE  FAT.EMPRESA = @EMPRESA 
           AND F.INDICA_BENEFICIADOR = 0 
           AND F.INDICA_FRANQUIA = 0 
           AND FAT.NOTA_CANCELADA = 0 
           AND ISNULL(F.MATRIZ_FISCAL, '') <> ISNULL(F2.MATRIZ_FISCAL, '') 
           AND ( FAT.NOME_CLIFOR = @FILIAL_FILTRO 
                  OR @FILIAL_FILTRO IS NULL ) 
           AND ( FAT.FILIAL = @FILIAL_ORIGEM 
                  OR @FILIAL_ORIGEM IS NULL ) 
           AND ( FAT.CHAVE_NFE = @CHAVE_NFE 
                  OR @CHAVE_NFE IS NULL ) 
           AND Cast(CONVERT(CHAR(8), COALESCE(LE.DATA_ENTRADA_CONFERIDA, LE.EMISSAO, FAT.EMISSAO), 112) AS DATETIME) BETWEEN @DATA_INICIAL AND @DATA_FINAL /*#24#*/
           --#24#AND COALESCE(LE.DATA_ENTRADA_CONFERIDA, LE.EMISSAO, FAT.EMISSAO) BETWEEN @DATA_INICIAL AND @DATA_FINAL /*#12#*/
           AND LE.ENTRADA_CONFERIDA = 1 /*#12#*/ 
           AND ( CES.NUMERO_MODELO_FISCAL = '55' 
                 AND FAT.STATUS_NFE = 5 --#6#  --#10#  
                  OR CES.NUMERO_MODELO_FISCAL <> '55' ) --#6#  --#10#  
           AND NOT EXISTS (SELECT 1 
                           FROM   ENTRADAS AS ENT(NOLOCK) 
                           WHERE  ENT.NOME_CLIFOR = FAT.FILIAL 
                                  AND ENT.NF_ENTRADA = FAT.NF_SAIDA 
                                  AND ENT.SERIE_NF_ENTRADA = FAT.SERIE_NF); 

    -- FIM - TABELA TEMP DE FATURAMENTO     
    -----------------------------------------------------------------------------------------------------------------------------------------------     
    -- TABELA TEMP DE FATURAMENTO_ITEM     
    SELECT FI.CLASSIF_FISCAL, 
           FI.CODIGO_ITEM, 
           FI.ORIGEM_ITEM,--#14#  
           FI.COD_TABELA_FILHA, 
           FI.COMISSAO_ITEM, 
           FI.COMISSAO_ITEM_GERENTE, 
           FI.REFERENCIA, 
           FI.CONTA_CONTABIL, 
           FI.DESCONTO_ITEM, 
           FI.DESCRICAO_ITEM, 
           FI.FAIXA, 
           FI.INDICADOR_CFOP, 
           FI.TRIBUT_ORIGEM, 
           FI.ITEM_IMPRESSAO, 
           FI.NF_SAIDA, 
           FI.FILIAL, 
           FI.PESO, 
           FI.PORCENTAGEM_ITEM_RATEIO, 
           FI.PRECO_UNITARIO, 
           FI.QTDE_DEVOLVIDA, 
           FI.QTDE_ITEM, 
           FI.QTDE_RETORNAR_BENEFICIAMENTO, 
           FI.SERIE_NF, 
           FI.SUB_ITEM_TAMANHO, 
           FI.TRIBUT_ICMS, 
           FI.UNIDADE, 
           FI.VALOR_ITEM, 
           FI.REFERENCIA_ITEM, 
           FI.REFERENCIA_PEDIDO, 
           FI.TIMESTAMP, 
           FI.MPADRAO_VALOR_ENCARGOS, 
           FI.MPADRAO_VALOR_DESCONTOS, 
           FI.NAO_SOMA_VALOR 
    INTO   #FATURAMENTO_ITEM_PERIODO 
    FROM   FATURAMENTO_ITEM AS FI(NOLOCK) 
           INNER JOIN #FATURAMENTO AS FP 
                   ON FP.NF_SAIDA = FI.NF_SAIDA 
                      AND FP.SERIE_NF = FI.SERIE_NF 
                      AND FP.FILIAL = FI.FILIAL; 

    -- FIM - TABELA TEMP DE FATURAMENTO_ITEM     
    -----------------------------------------------------------------------------------------------------------------------------------------------     
    IF @VERIFICA_LOJA_ENTRADAS = 0 
      BEGIN 
          -----------------------------------------------------------------------------------------------------------------------------------------------     
          -- TABELA TEMP DE ENTRADAS (FATURAMENTO SEM VERIFICAR LOJA_ENTRADAS)    
          SELECT NOME_CLIFOR = FAT.FILIAL, 
                 NF_ENTRADA = NF_SAIDA, 
                 SERIE_NF_ENTRADA = SERIE_NF, 
                 TABELA_FILHA = TABELA_FILHA, 
                 FILIAL = FAT.NOME_CLIFOR, 
                 EMISSAO = FAT.EMISSAO, 
                 RECEBIMENTO = FAT.DATA_RECEBIMENTO,/*#12#*/ 
                 QTDE_TOTAL = FAT.QTDE_TOTAL, 
                 VALOR_TOTAL = CASE 
                                 WHEN SERIE_NF = @TIPO_PRODUCAO THEN DBO.FX_PRODUCAO_PRECO(FAT.TIMESTAMP, 'F') /*#45#*/
                                 ELSE FAT.VALOR_TOTAL 
                               END, 
                 FRETE = FRETE, 
                 SEGURO = SEGURO, 
                 DESCONTO = FAT.DESCONTO, 
                 ENCARGO = FAT.ENCARGO, 
                 ICMS_VALOR = ICMS, 
                 IPI_VALOR = IPI_VALOR, 
                 ICMS_BASE = ICMS_BASE, 
                 NATUREZA = NE.NATUREZA, 
                 ACERTO_CONTAS_P_R = ACERTO_CONTAS_P_R, 
                 CONDICAO_PGTO = ISNULL(FPG.COND_PGTO_ENTRADA, (SELECT Max(CONDICAO_PGTO) 
                                                                FROM   COND_ENT_PGTOS(NOLOCK)
                                                                WHERE  TIPO_CONDICAO = 'VISTA')),
                 COD_TRANSACAO = 'ENTRADAS_109', 
                 NF_FATURA = NF_FATURA, 
                 DEVOLUCAO = DEVOLUCAO, 
                 NF_PROPRIA_EMITIDA = 0,/*#19# #23#*/ 
                 TRANSF_FILIAL = 1, 
                 NF_ENTRADA_PROPRIA = 0,/*#19# #23#*/ 
                 FRETE_A_PAGAR = FRETE, 
                 IMPORTACAO = 0, 
                 MOEDA = ISNULL(MOEDA, @MOEDA_PADRAO), 
                 VALOR_IMPOSTO_AGREGAR = VALOR_IMPOSTO_AGREGAR, 
                 RATEIO_FILIAL = CLIFOR.COD_CLIFOR, 
                 ESPECIE_SERIE = ISNULL((SELECT SERIES_NF.ESPECIE_SERIE 
                                         FROM   SERIES_NF(NOLOCK) 
                                         WHERE  SERIES_NF.SERIE_NF = FAT.SERIE_NF), @ESPECIE_SERIE),
                 RATEIO_CENTRO_CUSTO = ISNULL(RATEIO_CENTRO_CUSTO, @RATEIO_CENTRO_CUSTO_PADRAO),
                 TIPO_ENTRADAS = @TIPO_ENTRADAS_PADRAO, 
                 COD_CLIFOR_SACADO = F.COD_FILIAL, 
                 VALOR_SUB_ITENS = FAT.VALOR_SUB_ITENS, 
                 CHAVE_NFE = CHAVE_NFE, 
                 PROTOCOLO_AUTORIZACAO_NFE = PROTOCOLO_AUTORIZACAO_NFE, 
                 DATA_AUTORIZACAO_NFE = DATA_AUTORIZACAO_NFE, 
                 DATA_DIGITACAO = Cast(CONVERT(CHAR(8), Getdate(), 112) AS DATETIME), 
                 FIN_EMISSAO_NFE = FAT.FIN_EMISSAO_NFE,--#5#  
                 TIPO_EMISSAO_NFE = FAT.TIPO_EMISSAO_NFE,--#5#  
                 STATUS_NFE = FAT.STATUS_NFE,--#5#  
                 TRANSPORTADORA_A_PAGAR = FAT.TRANSPORTADORA,--#7#  
                 AGRUPAMENTO_ITENS = FAT.AGRUPAMENTO_ITENS /*#15#*/ 
          INTO   #ENTRADAS_PERIODO 
          FROM   #FATURAMENTO AS FAT 
                 JOIN FILIAIS AS F(NOLOCK) 
                   ON FAT.NOME_CLIFOR = F.FILIAL 
                 JOIN CADASTRO_CLI_FOR AS CLIFOR(NOLOCK) 
                   ON FAT.NOME_CLIFOR = CLIFOR.NOME_CLIFOR 
                 JOIN NATUREZAS_SAIDAS AS NS(NOLOCK) 
                   ON FAT.NATUREZA_SAIDA = NS.NATUREZA_SAIDA 
                 JOIN NATUREZAS_ENTRADAS AS NE(NOLOCK) 
                   ON NS.NATUREZA_ENTRADA_AUTOMATICA = NE.NATUREZA 
                 LEFT JOIN FORMA_PGTO AS FPG(NOLOCK) 
                        ON FPG.CONDICAO_PGTO = FAT.CONDICAO_PGTO; 

          -- FIM - TABELA TEMP DE ENTRADAS (FATURAMENTO SEM VERIFICAR LOJA_ENTRADAS)    
          ---------------------------------------------------------------------------------------------------------------------------------------------------------  
          -- TABELA TEMP DE ENTRADAS_ITEM (FATURAMENTO_ITEM SEM VERIFICAR LOJA_ENTRADAS)    
          --> #21#  Criação explícita da tabela temporária ao invés de criá-la através da instrução SELECT INTO. 
          -->        Inclusão de coluna sequencial (row_number) para controlar a inclusão/alteração de registros em lote.
          CREATE TABLE #ENTRADAS_ITEM_PERIODO 
            ( 
               ID                           BIGINT NOT NULL PRIMARY KEY, 
               CLASSIF_FISCAL               CHAR(10) COLLATE DATABASE_DEFAULT NOT NULL, 
               CODIGO_FISCAL_OPERACAO       CHAR(4) COLLATE DATABASE_DEFAULT NULL, 
               CODIGO_ITEM                  VARCHAR(50) COLLATE DATABASE_DEFAULT NOT NULL, 
               ORIGEM_ITEM                  CHAR(1) COLLATE DATABASE_DEFAULT NULL, 
               COD_TABELA_FILHA             CHAR(1) COLLATE DATABASE_DEFAULT NULL, 
               COMISSAO_ITEM                NUMERIC(13, 10) NULL, 
               COMISSAO_ITEM_GERENTE        NUMERIC(13, 10) NULL, 
               CONTA_CONTABIL               VARCHAR(20) COLLATE DATABASE_DEFAULT NULL, 
               DESCONTO_ITEM                NUMERIC(14, 2) NULL, 
               DESCRICAO_ITEM               VARCHAR(80) COLLATE DATABASE_DEFAULT NULL, 
               FAIXA                        CHAR(1) COLLATE DATABASE_DEFAULT NOT NULL, 
               ID_EXCECAO_IMPOSTO           INT NULL, 
               INDICADOR_CFOP               TINYINT NULL, 
               ITEM_IMPRESSAO               CHAR(4) COLLATE DATABASE_DEFAULT NOT NULL, 
               NF_ENTRADA                   CHAR(15) COLLATE DATABASE_DEFAULT NOT NULL, 
               NOME_CLIFOR                  VARCHAR(25) COLLATE DATABASE_DEFAULT NOT NULL, 
               PESO                         NUMERIC(7, 3) NULL, 
               PORCENTAGEM_ITEM_RATEIO      NUMERIC(13, 10) NULL, 
               PRECO_UNITARIO               NUMERIC(15, 5) NULL, 
               QTDE_DEVOLVIDA               NUMERIC(9, 3) NULL, 
               QTDE_ITEM                    NUMERIC(9, 3) NULL, 
               QTDE_RETORNAR_BENEFICIAMENTO NUMERIC(9, 3) NULL, 
               SERIE_NF_ENTRADA             VARCHAR(6) COLLATE DATABASE_DEFAULT NOT NULL, 
               SUB_ITEM_TAMANHO             INT NOT NULL, 
               TRIBUT_ICMS                  CHAR(3) COLLATE DATABASE_DEFAULT NOT NULL, 
               TRIBUT_ORIGEM                CHAR(3) COLLATE DATABASE_DEFAULT NOT NULL, 
               UNIDADE                      VARCHAR(5) COLLATE DATABASE_DEFAULT NULL, 
               VALOR_ITEM                   NUMERIC(14, 2) NULL, 
               REFERENCIA                   VARCHAR(50) COLLATE DATABASE_DEFAULT NOT NULL, 
               REFERENCIA_ITEM              VARCHAR(12) COLLATE DATABASE_DEFAULT NULL, 
               REFERENCIA_PEDIDO            VARCHAR(12) COLLATE DATABASE_DEFAULT NULL, 
               DIVERGENTE                   INT NOT NULL, 
               TIMESTAMP                    VARCHAR(25) COLLATE DATABASE_DEFAULT NULL, 
               REFERENCIA_ENTREGA_PEDIDO    INT NULL, 
               VALOR_ENCARGOS               NUMERIC(14, 2) NULL, 
               VALOR_DESCONTOS              NUMERIC(14, 2) NULL, 
               NAO_SOMA_VALOR               BIT NOT NULL, 
               VALOR_ENCARGOS_IMPORTACAO    INT NOT NULL, 
               RATEIO_FILIAL                CHAR(6) COLLATE DATABASE_DEFAULT NULL, 
               RATEIO_CENTRO_CUSTO          VARCHAR(15) COLLATE DATABASE_DEFAULT NOT NULL ,
			   PRECO_UNITARIO_ORIGINAL      NUMERIC(15, 5) NULL --#40#
            ); 

          SET @ROWSENTITEM = 0; 

          INSERT INTO #ENTRADAS_ITEM_PERIODO 
                      (ID, 
                       CLASSIF_FISCAL, 
                       CODIGO_FISCAL_OPERACAO, 
                       CODIGO_ITEM, 
                       ORIGEM_ITEM, 
                       COD_TABELA_FILHA, 
                       COMISSAO_ITEM, 
                       COMISSAO_ITEM_GERENTE, 
                       CONTA_CONTABIL, 
                       DESCONTO_ITEM, 
                       DESCRICAO_ITEM, 
                       FAIXA, 
                       ID_EXCECAO_IMPOSTO, 
                       INDICADOR_CFOP, 
                       ITEM_IMPRESSAO, 
                       NF_ENTRADA, 
                       NOME_CLIFOR, 
                       PESO, 
                       PORCENTAGEM_ITEM_RATEIO, 
                       PRECO_UNITARIO, 
                       QTDE_DEVOLVIDA, 
                       QTDE_ITEM, 
                       QTDE_RETORNAR_BENEFICIAMENTO, 
                       SERIE_NF_ENTRADA, 
                       SUB_ITEM_TAMANHO, 
                       TRIBUT_ICMS, 
                       TRIBUT_ORIGEM, 
                       UNIDADE, 
                       VALOR_ITEM, 
                       REFERENCIA, 
                       REFERENCIA_ITEM, 
                       REFERENCIA_PEDIDO, 
                       DIVERGENTE, 
                       TIMESTAMP, 
                       REFERENCIA_ENTREGA_PEDIDO, 
                       VALOR_ENCARGOS, 
                       VALOR_DESCONTOS, 
                       NAO_SOMA_VALOR, 
                       VALOR_ENCARGOS_IMPORTACAO, 
                       RATEIO_FILIAL, 
                       RATEIO_CENTRO_CUSTO,
					   PRECO_UNITARIO_ORIGINAL --#40#
					   ) 
          SELECT ROW_NUMBER() 
                   OVER( 
                     ORDER BY FI.NF_SAIDA, FI.SERIE_NF, FI.ITEM_IMPRESSAO, FI.FILIAL) AS ID, 
                 CLASSIF_FISCAL = FI.CLASSIF_FISCAL, 
                 CODIGO_FISCAL_OPERACAO = CASE 
                                            WHEN CTBE.CFOP_OBRIGATORIO IS NOT NULL THEN CTBE.CFOP_OBRIGATORIO
                                            ELSE 
                                              CASE 
                                                WHEN CLIFOR.PAIS <> F.PAIS THEN CTBC.CODIGO_FISCAL_EXTERIOR
                                                WHEN CLIFOR.UF <> F.UF THEN CTBC.CODIGO_FISCAL_INTERESTADUAL
                                                ELSE CTBC.CODIGO_FISCAL_OPERACAO 
                                              END 
                                          END, 
                 CODIGO_ITEM = FI.CODIGO_ITEM, 
                 ORIGEM_ITEM = FI.ORIGEM_ITEM,--#14#  
                 COD_TABELA_FILHA = FI.COD_TABELA_FILHA, 
                 COMISSAO_ITEM = FI.COMISSAO_ITEM, 
                 COMISSAO_ITEM_GERENTE = FI.COMISSAO_ITEM_GERENTE, 
                 CONTA_CONTABIL = ISNULL(DBO.FX_CONTA_CONTABIL_OPERACAO_INVERSA(FI.REFERENCIA, NS.TIPO_OPERACAO, 'E', FI.COD_TABELA_FILHA), FI.CONTA_CONTABIL),
                 DESCONTO_ITEM = FI.DESCONTO_ITEM, 
                 DESCRICAO_ITEM = FI.DESCRICAO_ITEM, 
                 FAIXA = FI.FAIXA, 
                 ID_EXCECAO_IMPOSTO = DBO.FX_ID_EXCECAO_IMPOSTO(CTBO.CTB_TIPO_OPERACAO, F.COD_CLIFOR, ISNULL(DBO.FX_INDICADOR_CFOP(FP.NOME_CLIFOR, ISNULL(FI.REFERENCIA, FI.CODIGO_ITEM), FI.COD_TABELA_FILHA), FI.INDICADOR_CFOP), 'E', ISNULL(FP.NOME_CLIFOR, NULL), --#41#
                                      /*#33# INCLUSÃO DA MATRIZ FISCAL*/ 
                                      /*@FILIAL_FILTRO, /*#31#*/ */
                                      FP.NOME_CLIFOR, FP.EMISSAO, FI.TRIBUT_ORIGEM, CASE 
                                                                                      WHEN CLIFOR.PAIS <> F.PAIS THEN CTBC.CODIGO_FISCAL_EXTERIOR
                                                                                      WHEN CLIFOR.UF <> F.UF THEN CTBC.CODIGO_FISCAL_INTERESTADUAL
                                                                                      ELSE CTBC.CODIGO_FISCAL_OPERACAO
                                                                                    END, ISNULL(FI.REFERENCIA, FI.CODIGO_ITEM), /*#31#*/
                                      F.NOME_CLIFOR, CASE 
                                                       WHEN FI.COD_TABELA_FILHA = 'R' THEN 'P'
                                                       ELSE 
                                                         CASE 
                                                           WHEN FI.COD_TABELA_FILHA = 'T' THEN 'M'
                                                           ELSE FI.COD_TABELA_FILHA 
                                                         END 
                                                     END, NS.NATUREZA_ENTRADA_AUTOMATICA, CLIFOR.COD_CLIFOR),
                 INDICADOR_CFOP = ISNULL(DBO.FX_INDICADOR_CFOP(FP.NOME_CLIFOR, ISNULL(FI.REFERENCIA, FI.CODIGO_ITEM), FI.COD_TABELA_FILHA), FI.INDICADOR_CFOP),/*#31#*/
                 ITEM_IMPRESSAO = FI.ITEM_IMPRESSAO, 
                 NF_ENTRADA = FI.NF_SAIDA, 
                 NOME_CLIFOR = FI.FILIAL, 
                 PESO = FI.PESO, 
                 PORCENTAGEM_ITEM_RATEIO = FI.PORCENTAGEM_ITEM_RATEIO, 
                 PRECO_UNITARIO = FI.PRECO_UNITARIO, 
                 QTDE_DEVOLVIDA = FI.QTDE_DEVOLVIDA, 
                 QTDE_ITEM = FI.QTDE_ITEM, 
                 QTDE_RETORNAR_BENEFICIAMENTO = FI.QTDE_RETORNAR_BENEFICIAMENTO, 
                 SERIE_NF_ENTRADA = FI.SERIE_NF, 
                 SUB_ITEM_TAMANHO = FI.SUB_ITEM_TAMANHO, 
                 TRIBUT_ICMS = COALESCE(CTBE.TRIBUT_ICMS, FI.TRIBUT_ICMS), /*#38#*/
                 TRIBUT_ORIGEM = COALESCE(CTBE.TRIBUT_ORIGEM, FI.TRIBUT_ORIGEM),	/*#38#*/
                 UNIDADE = FI.UNIDADE, 
                 VALOR_ITEM = FI.VALOR_ITEM, 
                 REFERENCIA = ISNULL(FI.REFERENCIA, FI.CODIGO_ITEM), 
                 REFERENCIA_ITEM = FI.REFERENCIA_ITEM, 
                 REFERENCIA_PEDIDO = FI.REFERENCIA_PEDIDO, 
                 DIVERGENTE = 0, 
                 TIMESTAMP = FI.TIMESTAMP, 
                 REFERENCIA_ENTREGA_PEDIDO = NULL, 
                 VALOR_ENCARGOS = FI.MPADRAO_VALOR_ENCARGOS, 
                 VALOR_DESCONTOS = FI.MPADRAO_VALOR_DESCONTOS, 
                 NAO_SOMA_VALOR = FI.NAO_SOMA_VALOR, 
                 VALOR_ENCARGOS_IMPORTACAO = 0, 
                 RATEIO_FILIAL = CLIFOR.COD_CLIFOR, 
                 RATEIO_CENTRO_CUSTO = ISNULL(FP.RATEIO_CENTRO_CUSTO, @RATEIO_CENTRO_CUSTO_PADRAO),
				 PRECO_UNITARIO_ORIGINAL = FI.PRECO_UNITARIO --#40#
          --INTO   #ENTRADAS_ITEM_PERIODO  
          FROM   #FATURAMENTO AS FP 
                 JOIN FILIAIS 
                   ON FP.FILIAL = FILIAIS.FILIAL /*#33# INCLUSÃO DA FILIAL PARA BUSCAR A MATRIZ FISCAL */
                 JOIN NATUREZAS_SAIDAS AS NS(NOLOCK) 
                   ON FP.NATUREZA_SAIDA = NS.NATUREZA_SAIDA 
                 JOIN #FATURAMENTO_ITEM_PERIODO AS FI 
                   ON FP.FILIAL = FI.FILIAL 
                      AND FP.NF_SAIDA = FI.NF_SAIDA 
                      AND FP.SERIE_NF = FI.SERIE_NF 
                 JOIN CADASTRO_CLI_FOR AS CLIFOR(NOLOCK) 
                   ON FP.NOME_CLIFOR = CLIFOR.NOME_CLIFOR 
                 JOIN CADASTRO_CLI_FOR AS F(NOLOCK) 
                   ON FP.FILIAL = F.NOME_CLIFOR 
                 JOIN NATUREZAS_ENTRADAS AS NE(NOLOCK) 
                   ON NS.NATUREZA_ENTRADA_AUTOMATICA = NE.NATUREZA 
                 JOIN CTB_LX_TIPO_OPERACAO AS CTBO(NOLOCK) 
                   ON CTBO.CTB_TIPO_OPERACAO = NE.CTB_TIPO_OPERACAO 
                 JOIN CTB_LX_CARACTERISTICA_CFOP AS CTBC(NOLOCK) 
                   ON CTBC.CTB_TIPO_OPERACAO = CTBO.CTB_TIPO_OPERACAO 
                      AND CTBC.INDICADOR_FISCAL_TERCEIRO = F.INDICADOR_FISCAL_TERCEIRO 
                      AND CTBC.INDICADOR_CFOP = ISNULL(DBO.FX_INDICADOR_CFOP(FP.NOME_CLIFOR, ISNULL(FI.REFERENCIA, FI.CODIGO_ITEM), FI.COD_TABELA_FILHA), FI.INDICADOR_CFOP)
                 LEFT JOIN CTB_EXCECAO_IMPOSTO AS CTBE(NOLOCK) 
                        ON CTBE.ID_EXCECAO_IMPOSTO = DBO.FX_ID_EXCECAO_IMPOSTO(CTBO.CTB_TIPO_OPERACAO, F.COD_CLIFOR, ISNULL(DBO.FX_INDICADOR_CFOP(FP.NOME_CLIFOR, ISNULL(FI.REFERENCIA, FI.CODIGO_ITEM), FI.COD_TABELA_FILHA), FI.INDICADOR_CFOP), 'E', ISNULL(FILIAIS.MATRIZ_FISCAL, NULL),
                                                     /*#33# INCLUSÃO DA MATRIZ FISCAL*/ 
                                                     /*@FILIAL_FILTRO, /*#31#*/ */
                                                     FP.NOME_CLIFOR, FP.EMISSAO, FI.TRIBUT_ORIGEM, CASE
                                                                                                     WHEN CLIFOR.PAIS <> F.PAIS THEN CTBC.CODIGO_FISCAL_EXTERIOR
                                                                                                     WHEN CLIFOR.UF <> F.UF THEN CTBC.CODIGO_FISCAL_INTERESTADUAL
                                                                                                     ELSE CTBC.CODIGO_FISCAL_OPERACAO
                                                                                                   END, ISNULL(FI.REFERENCIA, FI.CODIGO_ITEM), /*#31#*/
                                                     F.NOME_CLIFOR, CASE 
                                                                      WHEN FI.COD_TABELA_FILHA = 'R' THEN 'P'
                                                                      ELSE 
                                                                        CASE 
                                                                          WHEN FI.COD_TABELA_FILHA = 'T' THEN 'M'
                                                                          ELSE FI.COD_TABELA_FILHA
                                                                        END 
                                                                    END, NS.NATUREZA_ENTRADA_AUTOMATICA, CLIFOR.COD_CLIFOR);

          SET @ROWSENTITEM = @@ROWCOUNT; --> Crispim 
          --SELECT * INTO ##ENTRADAS_ITEM_PERIODO FROM #ENTRADAS_ITEM_PERIODO 
          -- FIM - TABELA TEMP DE ENTRADAS_ITEM (FATURAMENTO_ITEM SEM VERIFICAR LOJA_ENTRADAS)    
          -----------------------------------------------------------------------------------------------------------------------------------------------     
          -- INSERÇÃO NAS TABELAS FÍSICAS (ENTRADAS E ENTRADAS_ITEM SEM VERIFICAR LOJA_ENTRADAS)    
          INSERT INTO ENTRADAS 
                      (NOME_CLIFOR, 
                       NF_ENTRADA, 
                       SERIE_NF_ENTRADA, 
                       TABELA_FILHA, 
                       FILIAL, 
                       EMISSAO, 
                       RECEBIMENTO, 
                       QTDE_TOTAL, 
                       VALOR_TOTAL, 
                       FRETE, 
                       SEGURO, 
                       DESCONTO, 
                       ENCARGO, 
                       ICMS_VALOR, 
                       IPI_VALOR, 
                       ICMS_BASE, 
                       NATUREZA, 
                       ACERTO_CONTAS_P_R, 
                       CONDICAO_PGTO, 
                       COD_TRANSACAO, 
                       NF_FATURA, 
                       DEVOLUCAO, 
                       NF_PROPRIA_EMITIDA, 
                       TRANSF_FILIAL, 
                       NF_ENTRADA_PROPRIA, 
                       FRETE_A_PAGAR, 
                       IMPORTACAO, 
                       MOEDA, 
                       VALOR_IMPOSTO_AGREGAR, 
                       RATEIO_FILIAL, 
                       ESPECIE_SERIE, 
                       RATEIO_CENTRO_CUSTO, 
                       TIPO_ENTRADAS, 
                       COD_CLIFOR_SACADO, 
                       VALOR_SUB_ITENS, 
                       CHAVE_NFE, 
                       PROTOCOLO_AUTORIZACAO_NFE, 
                       DATA_AUTORIZACAO_NFE, 
                       DATA_DIGITACAO, 
                       FIN_EMISSAO_NFE,/*--#5# */ 
                       TIPO_EMISSAO_NFE,/*--#5# */ 
                       STATUS_NFE,/*--#5# */ 
                       TRANSPORTADORA_A_PAGAR,/*--#7# */ 
                       AGRUPAMENTO_ITENS, 
                       EMPRESA /*#22#*/ 
          ) /*#15#*/ 
          SELECT NOME_CLIFOR, 
                 NF_ENTRADA, 
                 SERIE_NF_ENTRADA, 
                 TABELA_FILHA, 
                 FILIAL, 
                 EMISSAO, 
                 RECEBIMENTO, 
                 QTDE_TOTAL, 
                 VALOR_TOTAL, 
                 FRETE, 
                 SEGURO, 
                 DESCONTO, 
                 ENCARGO, 
                 ICMS_VALOR, 
                 IPI_VALOR, 
                 ICMS_BASE, 
                 NATUREZA, 
                 ACERTO_CONTAS_P_R, 
                 CONDICAO_PGTO, 
                 COD_TRANSACAO, 
                 NF_FATURA, 
                 DEVOLUCAO, 
                 NF_PROPRIA_EMITIDA, 
                 TRANSF_FILIAL, 
                 NF_ENTRADA_PROPRIA, 
                 FRETE_A_PAGAR, 
                 IMPORTACAO, 
                 MOEDA, 
                 VALOR_IMPOSTO_AGREGAR, 
                 RATEIO_FILIAL, 
                 ESPECIE_SERIE, 
                 RATEIO_CENTRO_CUSTO, 
                 TIPO_ENTRADAS, 
                 COD_CLIFOR_SACADO, 
                 VALOR_SUB_ITENS, 
                 CHAVE_NFE, 
                 PROTOCOLO_AUTORIZACAO_NFE, 
                 DATA_AUTORIZACAO_NFE, 
                 DATA_DIGITACAO, 
                 FIN_EMISSAO_NFE,/*--#5# */ 
                 TIPO_EMISSAO_NFE,/*--#5# */ 
                 STATUS_NFE,/*--#5# */ 
                 TRANSPORTADORA_A_PAGAR,/*--#7# */ 
                 AGRUPAMENTO_ITENS,/*#15#*/ 
                 @EMPRESA /*#22#*/ 
          FROM   #ENTRADAS_PERIODO;

          --> #21#  Inclusão registros em lote para minimizar escalonamento de bloqueios. 
          -->        Definição de contexto para evitar multiplas validações desnecessárias em triggers. 
          SET @CONTEXT = 0x53454D5F46494C415F45544C; --0x4C585F474552415F5452414E53464552454E434941535F504552494F444F  
          SET CONTEXT_INFO @CONTEXT; 
          --> #21# Início 
          SET @COUNT = 1; 

          WHILE @COUNT <= @ROWSENTITEM 
            BEGIN 
                INSERT INTO ENTRADAS_ITEM 
                            (CLASSIF_FISCAL, 
                             CODIGO_FISCAL_OPERACAO, 
                             CODIGO_ITEM, 
                             ORIGEM_ITEM,/*--#14# */ 
                             COD_TABELA_FILHA, 
                             COMISSAO_ITEM, 
                             COMISSAO_ITEM_GERENTE, 
                             CONTA_CONTABIL, 
                             DESCONTO_ITEM, 
                             DESCRICAO_ITEM, 
                             FAIXA, 
                             ID_EXCECAO_IMPOSTO, 
                             INDICADOR_CFOP, 
                             ITEM_IMPRESSAO, 
                             NF_ENTRADA, 
                             NOME_CLIFOR, 
                             PESO, 
                             PORCENTAGEM_ITEM_RATEIO, 
                             PRECO_UNITARIO, 
                             QTDE_DEVOLVIDA, 
                             QTDE_ITEM, 
                             QTDE_RETORNAR_BENEFICIAMENTO, 
                             SERIE_NF_ENTRADA, 
                             SUB_ITEM_TAMANHO, 
                             TRIBUT_ICMS, 
                             TRIBUT_ORIGEM, 
                             UNIDADE, 
                             VALOR_ITEM, 
                             REFERENCIA, 
                             REFERENCIA_ITEM, 
                             REFERENCIA_PEDIDO, 
                             DIVERGENTE, 
                             TIMESTAMP, 
                             REFERENCIA_ENTREGA_PEDIDO, 
                             VALOR_ENCARGOS, 
                             VALOR_DESCONTOS, 
                             NAO_SOMA_VALOR, 
                             VALOR_ENCARGOS_IMPORTACAO, 
                             RATEIO_FILIAL, 
                             RATEIO_CENTRO_CUSTO,
							 PRECO_UNITARIO_ORIGINAL ) --#40#
                SELECT CLASSIF_FISCAL, 
                       CODIGO_FISCAL_OPERACAO, 
                       CODIGO_ITEM, 
                       ORIGEM_ITEM, 
                       COD_TABELA_FILHA, 
                       COMISSAO_ITEM, 
                       COMISSAO_ITEM_GERENTE, 
                       CONTA_CONTABIL, 
                       DESCONTO_ITEM, 
                       DESCRICAO_ITEM, 
                       FAIXA, 
                       ID_EXCECAO_IMPOSTO, 
                       INDICADOR_CFOP, 
                       ITEM_IMPRESSAO, 
                       NF_ENTRADA, 
                       NOME_CLIFOR, 
                       PESO, 
                       PORCENTAGEM_ITEM_RATEIO, 
                       PRECO_UNITARIO, 
                       QTDE_DEVOLVIDA, 
                       QTDE_ITEM, 
                       QTDE_RETORNAR_BENEFICIAMENTO, 
                       SERIE_NF_ENTRADA, 
                       SUB_ITEM_TAMANHO, 
                       TRIBUT_ICMS, 
                       TRIBUT_ORIGEM, 
                       UNIDADE, 
                       VALOR_ITEM, 
                       REFERENCIA, 
                       REFERENCIA_ITEM, 
                       REFERENCIA_PEDIDO, 
                       DIVERGENTE, 
                       TIMESTAMP, 
                       REFERENCIA_ENTREGA_PEDIDO, 
                       VALOR_ENCARGOS, 
                       VALOR_DESCONTOS, 
                       NAO_SOMA_VALOR, 
                       VALOR_ENCARGOS_IMPORTACAO, 
                       RATEIO_FILIAL, 
                       RATEIO_CENTRO_CUSTO,
					   PRECO_UNITARIO_ORIGINAL --#40#
                FROM   #ENTRADAS_ITEM_PERIODO 
                WHERE  ID >= @COUNT 
                       AND ID <= @COUNT + 1999;	/*#37#*/

                SET @COUNT+=2000;	/*#37#*/

				/**#34#**/
				UPDATE	ENTRADA
				SET		ENTRADA.NF_ENTRADA = TEMP.NF_ENTRADA,
						ENTRADA.SERIE_NF_ENTRADA = TEMP.SERIE_NF_ENTRADA,
						ENTRADA.NOME_CLIFOR = TEMP.NOME_CLIFOR,
						ENTRADA.RATEIO_FILIAL = TEMP.RATEIO_FILIAL,
						ENTRADA.RATEIO_CENTRO_CUSTO = TEMP.RATEIO_CENTRO_CUSTO,
						ENTRADA.ITEM_IMPRESSAO = TEMP.ITEM_IMPRESSAO,
						ENTRADA.SUB_ITEM_TAMANHO = TEMP.SUB_ITEM_TAMANHO
				FROM		AF_LOCAL_ENTRADA AS ENTRADA
				JOIN		AF_LOCAL_SAIDA AS SAIDA
				ON		ENTRADA.ID_LOCAL_IMOBILIZADO = SAIDA.ID_LOCAL_IMOBILIZADO
						AND ENTRADA.EMPRESA = SAIDA.EMPRESA
				JOIN		#ENTRADAS_ITEM_PERIODO AS TEMP
				ON		SAIDA.NF_SAIDA = TEMP.NF_ENTRADA
						AND SAIDA.SERIE_NF = TEMP.SERIE_NF_ENTRADA
						AND SAIDA.FILIAL = TEMP.NOME_CLIFOR
						AND SAIDA.ITEM_IMPRESSAO = TEMP.ITEM_IMPRESSAO
						AND SAIDA.SUB_ITEM_TAMANHO = TEMP.SUB_ITEM_TAMANHO
				WHERE    ENTRADA.NF_ENTRADA IS NULL 
						 AND ENTRADA.SERIE_NF_ENTRADA IS NULL 
						 AND ENTRADA.NOME_CLIFOR IS NULL
						 AND ENTRADA.ITEM_IMPRESSAO IS NULL
						 AND ENTRADA.SUB_ITEM_TAMANHO IS NULL;
			/**#34#**/
			END;

          SET CONTEXT_INFO 0x; 
      --> #21# Fim 
      -- FIM - INSERÇÃO NAS TABELAS FÍSICAS (ENTRADAS E ENTRADAS_ITEM SEM VERIFICAR LOJA_ENTRADAS)  
      -----------------------------------------------------------------------------------------------------------------------------------------------     
      END; 
    ELSE 
      BEGIN 
          -----------------------------------------------------------------------------------------------------------------------------------------------     
          -- TABELA TEMP DE ENTRADAS (FATURAMENTO VERIFICANDO LOJA_ENTRADAS)    
          SELECT NOME_CLIFOR = FAT.FILIAL, 
                 NF_ENTRADA = NF_SAIDA, 
                 SERIE_NF_ENTRADA = SERIE_NF, 
                 TABELA_FILHA = TABELA_FILHA, 
                 FILIAL = FAT.NOME_CLIFOR, 
                 EMISSAO = FAT.EMISSAO, 
                 RECEBIMENTO = FAT.DATA_RECEBIMENTO,/*#12#*/ 
                 QTDE_TOTAL = FAT.QTDE_TOTAL, 
                 VALOR_TOTAL = CASE 
                                 WHEN SERIE_NF = @TIPO_PRODUCAO THEN DBO.FX_PRODUCAO_PRECO(FAT.TIMESTAMP, 'F')	/*#45#*/
                                 ELSE FAT.VALOR_TOTAL 
                               END, 
                 FRETE = FRETE, 
                 SEGURO = SEGURO, 
                 DESCONTO = FAT.DESCONTO, 
                 ENCARGO = FAT.ENCARGO, 
                 ICMS_VALOR = ICMS, 
                 IPI_VALOR = IPI_VALOR, 
                 ICMS_BASE = ICMS_BASE, 
                 NATUREZA = NE.NATUREZA, 
                 ACERTO_CONTAS_P_R = ACERTO_CONTAS_P_R, 
                 CONDICAO_PGTO = ISNULL(FPG.COND_PGTO_ENTRADA, (SELECT Max(CONDICAO_PGTO) 
                                                                FROM   COND_ENT_PGTOS(NOLOCK)
                                                                WHERE  TIPO_CONDICAO = 'VISTA')),
                 COD_TRANSACAO = 'ENTRADAS_109', 
                 NF_FATURA = NF_FATURA, 
                 DEVOLUCAO = DEVOLUCAO, 
                 NF_PROPRIA_EMITIDA = 0,/*#19# #23#*/ 
                 TRANSF_FILIAL = 1, 
                 NF_ENTRADA_PROPRIA = 0,/*#19# #23#*/ 
                 FRETE_A_PAGAR = FRETE, 
                 IMPORTACAO = 0, 
                 MOEDA = ISNULL(MOEDA, @MOEDA_PADRAO), 
                 VALOR_IMPOSTO_AGREGAR = VALOR_IMPOSTO_AGREGAR, 
                 RATEIO_FILIAL = CLIFOR.COD_CLIFOR, 
                 ESPECIE_SERIE = ISNULL((SELECT SERIES_NF.ESPECIE_SERIE 
                                         FROM   SERIES_NF(NOLOCK) 
                                         WHERE  SERIES_NF.SERIE_NF = FAT.SERIE_NF), @ESPECIE_SERIE),
                 RATEIO_CENTRO_CUSTO = ISNULL(RATEIO_CENTRO_CUSTO, @RATEIO_CENTRO_CUSTO_PADRAO),
                 TIPO_ENTRADAS = @TIPO_ENTRADAS_PADRAO, 
                 COD_CLIFOR_SACADO = F.COD_FILIAL, 
                 VALOR_SUB_ITENS = FAT.VALOR_SUB_ITENS, 
                 CHAVE_NFE = CHAVE_NFE, 
                 PROTOCOLO_AUTORIZACAO_NFE = PROTOCOLO_AUTORIZACAO_NFE, 
                 DATA_AUTORIZACAO_NFE = DATA_AUTORIZACAO_NFE, 
                 DATA_DIGITACAO = Cast(CONVERT(CHAR(8), Getdate(), 112) AS DATETIME), 
                 FIN_EMISSAO_NFE = FAT.FIN_EMISSAO_NFE,--#5#  
                 TIPO_EMISSAO_NFE = FAT.TIPO_EMISSAO_NFE,--#5#  
                 STATUS_NFE = FAT.STATUS_NFE,--#5#  
                 TRANSPORTADORA_A_PAGAR = FAT.TRANSPORTADORA,--#7#  
                 AGRUPAMENTO_ITENS = FAT.AGRUPAMENTO_ITENS /*#15#*/ 
          INTO   #ENTRADAS_PERIODO_1 
          FROM   #FATURAMENTO AS FAT 
                 JOIN FILIAIS AS F(NOLOCK) 
                   ON FAT.NOME_CLIFOR = F.FILIAL 
                 JOIN CADASTRO_CLI_FOR AS CLIFOR(NOLOCK) 
                   ON FAT.NOME_CLIFOR = CLIFOR.NOME_CLIFOR 
                 JOIN NATUREZAS_SAIDAS AS NS(NOLOCK) 
                   ON FAT.NATUREZA_SAIDA = NS.NATUREZA_SAIDA 
                 JOIN NATUREZAS_ENTRADAS AS NE(NOLOCK) 
                   ON NS.NATUREZA_ENTRADA_AUTOMATICA = NE.NATUREZA 
                 LEFT JOIN (SELECT FILIAL_ORIGEM,-- #3# #4#  
                                   NUMERO_NF_TRANSFERENCIA, 
                                   SERIE_NF_ENTRADA, 
                                   Max(EMISSAO)                                                          AS EMISSAO,
                                   Max(Cast(ISNULL(LOJA_ENTRADAS.ENTRADA_CONFERIDA, 0 /*#32#*/) AS INT)) AS ENTRADA_CONFERIDA
                            FROM   LOJA_ENTRADAS(NOLOCK) 
                            GROUP  BY FILIAL_ORIGEM, 
                                      NUMERO_NF_TRANSFERENCIA, 
                                      SERIE_NF_ENTRADA) AS LE 
                        ON FAT.FILIAL = LE.FILIAL_ORIGEM 
                           AND FAT.NF_SAIDA = LE.NUMERO_NF_TRANSFERENCIA 
                           AND FAT.SERIE_NF = LE.SERIE_NF_ENTRADA 
                 LEFT JOIN FORMA_PGTO AS FPG(NOLOCK) 
                        ON FPG.CONDICAO_PGTO = FAT.CONDICAO_PGTO 
          WHERE  ( ISNULL(LE.ENTRADA_CONFERIDA, 0) = 1 
                   AND FAT.INDICA_TRANSFERENCIA_PARA_LOJA = 1 )
                   OR FAT.INDICA_TRANSFERENCIA_PARA_LOJA = 0 /*#32#*/;	/*#36#*/

          -- FIM - TABELA TEMP DE ENTRADAS (FATURAMENTO VERIFICANDO LOJA_ENTRADAS)    
          -----------------------------------------------------------------------------------------------------------------------------------------------     
          --> #21#  Criação explícita da tabela temporária ao invés de criá-la através da instrução SELECT INTO. 
          -->        Inclusão de coluna sequencial (row_number) para controlar a inclusão/alteração de registros em lote.
          CREATE TABLE #ENTRADAS_ITEM_PERIODO_1 
            ( 
               ID                           BIGINT NOT NULL PRIMARY KEY, 
               CLASSIF_FISCAL               CHAR(10) COLLATE DATABASE_DEFAULT NOT NULL, 
               CODIGO_FISCAL_OPERACAO       CHAR(4) COLLATE DATABASE_DEFAULT NULL, 
               CODIGO_ITEM                  VARCHAR(50) COLLATE DATABASE_DEFAULT NOT NULL, 
               ORIGEM_ITEM                  CHAR(1) COLLATE DATABASE_DEFAULT NULL, 
               COD_TABELA_FILHA             CHAR(1) COLLATE DATABASE_DEFAULT NULL, 
               COMISSAO_ITEM                NUMERIC(13, 10) NULL, 
               COMISSAO_ITEM_GERENTE        NUMERIC(13, 10) NULL, 
               CONTA_CONTABIL               VARCHAR(20) COLLATE DATABASE_DEFAULT NULL, 
               DESCONTO_ITEM                NUMERIC(14, 2) NULL, 
               DESCRICAO_ITEM               VARCHAR(80) COLLATE DATABASE_DEFAULT NULL, 
               FAIXA                        CHAR(1) COLLATE DATABASE_DEFAULT NOT NULL, 
               ID_EXCECAO_IMPOSTO           INT NULL, 
               INDICADOR_CFOP               TINYINT NULL, 
               ITEM_IMPRESSAO               CHAR(4) COLLATE DATABASE_DEFAULT NOT NULL, 
               NF_ENTRADA                   CHAR(15) COLLATE DATABASE_DEFAULT NOT NULL, 
               NOME_CLIFOR                  VARCHAR(25) COLLATE DATABASE_DEFAULT NOT NULL, 
               PESO                         NUMERIC(7, 3) NULL, 
               PORCENTAGEM_ITEM_RATEIO      NUMERIC(13, 10) NULL, 
               PRECO_UNITARIO               NUMERIC(15, 5) NULL, 
               QTDE_DEVOLVIDA               NUMERIC(9, 3) NULL, 
               QTDE_ITEM                    NUMERIC(9, 3) NULL, 
               QTDE_RETORNAR_BENEFICIAMENTO NUMERIC(9, 3) NULL, 
               SERIE_NF_ENTRADA             VARCHAR(6) COLLATE DATABASE_DEFAULT NOT NULL, 
               SUB_ITEM_TAMANHO             INT NOT NULL, 
               TRIBUT_ICMS                  CHAR(3) COLLATE DATABASE_DEFAULT NOT NULL, 
               TRIBUT_ORIGEM                CHAR(3) COLLATE DATABASE_DEFAULT NOT NULL, 
               UNIDADE                      VARCHAR(5) COLLATE DATABASE_DEFAULT NULL, 
               VALOR_ITEM                   NUMERIC(14, 2) NULL, 
               REFERENCIA                   VARCHAR(50) COLLATE DATABASE_DEFAULT NOT NULL, 
               REFERENCIA_ITEM              VARCHAR(12) COLLATE DATABASE_DEFAULT NULL, 
               REFERENCIA_PEDIDO            VARCHAR(12) COLLATE DATABASE_DEFAULT NULL, 
               DIVERGENTE                   INT NOT NULL, 
               TIMESTAMP                    VARCHAR(25) COLLATE DATABASE_DEFAULT NULL, 
               REFERENCIA_ENTREGA_PEDIDO    INT NULL, 
               VALOR_ENCARGOS               NUMERIC(14, 2) NULL, 
               VALOR_DESCONTOS              NUMERIC(14, 2) NULL, 
               NAO_SOMA_VALOR               BIT NOT NULL, 
               VALOR_ENCARGOS_IMPORTACAO    INT NOT NULL, 
               RATEIO_FILIAL                CHAR(6) COLLATE DATABASE_DEFAULT NULL, 
               RATEIO_CENTRO_CUSTO          VARCHAR(15) COLLATE DATABASE_DEFAULT NOT NULL,
			   PRECO_UNITARIO_ORIGINAL      NUMERIC(15, 5) NULL --#40# 
            ); 

          SET @ROWSENTITEM = 0; 

          INSERT INTO #ENTRADAS_ITEM_PERIODO_1 
                      (ID, 
                       CLASSIF_FISCAL, 
                       CODIGO_FISCAL_OPERACAO, 
                       CODIGO_ITEM, 
                       ORIGEM_ITEM, 
                       COD_TABELA_FILHA, 
                       COMISSAO_ITEM, 
                       COMISSAO_ITEM_GERENTE, 
                       CONTA_CONTABIL, 
                       DESCONTO_ITEM, 
                       DESCRICAO_ITEM, 
                       FAIXA, 
                       ID_EXCECAO_IMPOSTO, 
                       INDICADOR_CFOP, 
                       ITEM_IMPRESSAO, 
                       NF_ENTRADA, 
                       NOME_CLIFOR, 
                       PESO, 
                       PORCENTAGEM_ITEM_RATEIO, 
                       PRECO_UNITARIO, 
                       QTDE_DEVOLVIDA, 
                       QTDE_ITEM, 
                       QTDE_RETORNAR_BENEFICIAMENTO, 
                       SERIE_NF_ENTRADA, 
                       SUB_ITEM_TAMANHO, 
                       TRIBUT_ICMS, 
                       TRIBUT_ORIGEM, 
                       UNIDADE, 
                       VALOR_ITEM, 
                       REFERENCIA, 
                       REFERENCIA_ITEM, 
                       REFERENCIA_PEDIDO, 
                       DIVERGENTE, 
                       TIMESTAMP, 
                       REFERENCIA_ENTREGA_PEDIDO, 
                       VALOR_ENCARGOS, 
                       VALOR_DESCONTOS, 
                       NAO_SOMA_VALOR, 
                       VALOR_ENCARGOS_IMPORTACAO, 
                       RATEIO_FILIAL, 
                       RATEIO_CENTRO_CUSTO,
					   PRECO_UNITARIO_ORIGINAL) --#40#
          -- TABELA TEMP DE ENTRADAS_ITEM (FATURAMENTO_ITEM VERIFICANDO LOJA_ENTRADAS)    
          SELECT ROW_NUMBER() 
                   OVER( 
                     ORDER BY FI.NF_SAIDA, FI.SERIE_NF, FI.ITEM_IMPRESSAO, FI.FILIAL) AS ID, 
                 CLASSIF_FISCAL = FI.CLASSIF_FISCAL, 
                 CODIGO_FISCAL_OPERACAO = CASE 
                                            WHEN CTBE.CFOP_OBRIGATORIO IS NOT NULL THEN CTBE.CFOP_OBRIGATORIO
                                            ELSE 
                                              CASE 
                                                WHEN CLIFOR.PAIS <> F.PAIS THEN CTBC.CODIGO_FISCAL_EXTERIOR
                                                WHEN CLIFOR.UF <> F.UF THEN CTBC.CODIGO_FISCAL_INTERESTADUAL
                                                ELSE CTBC.CODIGO_FISCAL_OPERACAO 
                                              END 
                                          END, 
                 CODIGO_ITEM = FI.CODIGO_ITEM, 
                 ORIGEM_ITEM = FI.ORIGEM_ITEM,--#14#  
                 COD_TABELA_FILHA = FI.COD_TABELA_FILHA, 
                 COMISSAO_ITEM = FI.COMISSAO_ITEM, 
                 COMISSAO_ITEM_GERENTE = FI.COMISSAO_ITEM_GERENTE, 
                 CONTA_CONTABIL = ISNULL(DBO.FX_CONTA_CONTABIL_OPERACAO_INVERSA(ISNULL(FI.REFERENCIA, FI.CODIGO_ITEM), NS.TIPO_OPERACAO, 'E', FI.COD_TABELA_FILHA), FI.CONTA_CONTABIL),
                 DESCONTO_ITEM = FI.DESCONTO_ITEM, 
                 DESCRICAO_ITEM = FI.DESCRICAO_ITEM, 
                 FAIXA = FI.FAIXA, 
                 ID_EXCECAO_IMPOSTO = DBO.FX_ID_EXCECAO_IMPOSTO(CTBO.CTB_TIPO_OPERACAO, F.COD_CLIFOR, ISNULL(DBO.FX_INDICADOR_CFOP(FP.NOME_CLIFOR, ISNULL(FI.REFERENCIA, FI.CODIGO_ITEM), FI.COD_TABELA_FILHA), FI.INDICADOR_CFOP), 'E', ISNULL(FP.NOME_CLIFOR, NULL), --#41#
                                      /*#33# INCLUSÃO DA MATRIZ FISCAL*/ 
                                      /*@FILIAL_FILTRO, /*#31#*/ */
                                      FP.NOME_CLIFOR, FP.EMISSAO, FI.TRIBUT_ORIGEM, CASE 
                                                                                      WHEN CLIFOR.PAIS <> F.PAIS THEN CTBC.CODIGO_FISCAL_EXTERIOR
                                                                                      WHEN CLIFOR.UF <> F.UF THEN CTBC.CODIGO_FISCAL_INTERESTADUAL
                                                                                      ELSE CTBC.CODIGO_FISCAL_OPERACAO
                                                                                    END, ISNULL(FI.REFERENCIA, FI.CODIGO_ITEM), /*#31#*/
                                      F.NOME_CLIFOR, CASE 
                                                       WHEN FI.COD_TABELA_FILHA = 'R' THEN 'P'
                                                       ELSE 
                                                         CASE 
                                                           WHEN FI.COD_TABELA_FILHA = 'T' THEN 'M'
                                                           ELSE FI.COD_TABELA_FILHA 
                                                         END 
                                                     END, NS.NATUREZA_ENTRADA_AUTOMATICA, CLIFOR.COD_CLIFOR),
                 INDICADOR_CFOP = ISNULL(DBO.FX_INDICADOR_CFOP(FP.NOME_CLIFOR, ISNULL(FI.REFERENCIA, FI.CODIGO_ITEM), FI.COD_TABELA_FILHA), FI.INDICADOR_CFOP),/*#31#*/
                 ITEM_IMPRESSAO = FI.ITEM_IMPRESSAO, 
                 NF_ENTRADA = FI.NF_SAIDA, 
                 NOME_CLIFOR = FI.FILIAL, 
                 PESO = FI.PESO, 
                 PORCENTAGEM_ITEM_RATEIO = FI.PORCENTAGEM_ITEM_RATEIO, 
                 PRECO_UNITARIO = FI.PRECO_UNITARIO, 
                 QTDE_DEVOLVIDA = FI.QTDE_DEVOLVIDA, 
                 QTDE_ITEM = FI.QTDE_ITEM, 
                 QTDE_RETORNAR_BENEFICIAMENTO = FI.QTDE_RETORNAR_BENEFICIAMENTO, 
                 SERIE_NF_ENTRADA = FI.SERIE_NF, 
                 SUB_ITEM_TAMANHO = FI.SUB_ITEM_TAMANHO, 
                 TRIBUT_ICMS = COALESCE(CTBE.TRIBUT_ICMS, FI.TRIBUT_ICMS), /*#38#*/
                 TRIBUT_ORIGEM = COALESCE(CTBE.TRIBUT_ORIGEM, FI.TRIBUT_ORIGEM),	/*#38#*/
                 UNIDADE = FI.UNIDADE, 
                 VALOR_ITEM = FI.VALOR_ITEM, 
                 REFERENCIA = ISNULL(FI.REFERENCIA, FI.CODIGO_ITEM), 
                 REFERENCIA_ITEM = FI.REFERENCIA_ITEM, 
                 REFERENCIA_PEDIDO = FI.REFERENCIA_PEDIDO, 
                 DIVERGENTE = 0, 
                 TIMESTAMP = FI.TIMESTAMP, 
                 REFERENCIA_ENTREGA_PEDIDO = NULL, 
                 VALOR_ENCARGOS = FI.MPADRAO_VALOR_ENCARGOS, 
                 VALOR_DESCONTOS = FI.MPADRAO_VALOR_DESCONTOS, 
                 NAO_SOMA_VALOR = FI.NAO_SOMA_VALOR, 
                 VALOR_ENCARGOS_IMPORTACAO = 0, 
                 RATEIO_FILIAL = CLIFOR.COD_CLIFOR, 
                 RATEIO_CENTRO_CUSTO = ISNULL(FP.RATEIO_CENTRO_CUSTO, @RATEIO_CENTRO_CUSTO_PADRAO),
				 PRECO_UNITARIO_ORIGINAL = FI.PRECO_UNITARIO --#40#
          --INTO   #ENTRADAS_ITEM_PERIODO_1  
          FROM   #FATURAMENTO AS FP 
                 JOIN FILIAIS 
                   ON FP.FILIAL = FILIAIS.FILIAL /*#33# INCLUSÃO DA FILIAL PARA BUSCAR A MATRIZ FISCAL */
                 JOIN NATUREZAS_SAIDAS AS NS(NOLOCK) 
                   ON FP.NATUREZA_SAIDA = NS.NATUREZA_SAIDA 
                 JOIN #FATURAMENTO_ITEM_PERIODO AS FI 
                   ON FP.FILIAL = FI.FILIAL 
                      AND FP.NF_SAIDA = FI.NF_SAIDA 
                      AND FP.SERIE_NF = FI.SERIE_NF 
                 JOIN CADASTRO_CLI_FOR AS CLIFOR(NOLOCK) 
                   ON FP.NOME_CLIFOR = CLIFOR.NOME_CLIFOR 
                 JOIN CADASTRO_CLI_FOR AS F(NOLOCK) 
                   ON FP.FILIAL = F.NOME_CLIFOR 
                 JOIN NATUREZAS_ENTRADAS AS NE(NOLOCK) 
                   ON NS.NATUREZA_ENTRADA_AUTOMATICA = NE.NATUREZA 
                 JOIN CTB_LX_TIPO_OPERACAO AS CTBO(NOLOCK) 
                   ON CTBO.CTB_TIPO_OPERACAO = NE.CTB_TIPO_OPERACAO 
                 JOIN CTB_LX_CARACTERISTICA_CFOP AS CTBC(NOLOCK) 
                   ON CTBC.CTB_TIPO_OPERACAO = CTBO.CTB_TIPO_OPERACAO 
                      AND CTBC.INDICADOR_FISCAL_TERCEIRO = F.INDICADOR_FISCAL_TERCEIRO 
                      AND CTBC.INDICADOR_CFOP = ISNULL(DBO.FX_INDICADOR_CFOP(FP.NOME_CLIFOR, ISNULL(FI.REFERENCIA, FI.CODIGO_ITEM), FI.COD_TABELA_FILHA), FI.INDICADOR_CFOP)
                 LEFT JOIN (SELECT FILIAL_ORIGEM,-- #3# #4#  
                                   NUMERO_NF_TRANSFERENCIA, 
                                   SERIE_NF_ENTRADA, 
                                   Max(EMISSAO)                                                          AS EMISSAO,
                                   Max(Cast(ISNULL(LOJA_ENTRADAS.ENTRADA_CONFERIDA, 0 /*#32#*/) AS INT)) AS ENTRADA_CONFERIDA
                            FROM   LOJA_ENTRADAS(NOLOCK) 
                            GROUP  BY FILIAL_ORIGEM, 
                                      NUMERO_NF_TRANSFERENCIA, 
                                      SERIE_NF_ENTRADA) AS LE 
                        ON FP.FILIAL = LE.FILIAL_ORIGEM 
                           AND FP.NF_SAIDA = LE.NUMERO_NF_TRANSFERENCIA 
                           AND FP.SERIE_NF = LE.SERIE_NF_ENTRADA 
                 LEFT JOIN CTB_EXCECAO_IMPOSTO AS CTBE(NOLOCK) 
                        ON CTBE.ID_EXCECAO_IMPOSTO = DBO.FX_ID_EXCECAO_IMPOSTO(CTBO.CTB_TIPO_OPERACAO, F.COD_CLIFOR, ISNULL(DBO.FX_INDICADOR_CFOP(FP.NOME_CLIFOR, ISNULL(FI.REFERENCIA, FI.CODIGO_ITEM), FI.COD_TABELA_FILHA), FI.INDICADOR_CFOP), 'E', ISNULL(FP.NOME_CLIFOR, NULL), --#41#
                                                     /*#33# INCLUSÃO DA MATRIZ FISCAL*/ 
                                                     /*@FILIAL_FILTRO, /*#31#*/ */
                                                     FP.NOME_CLIFOR, FP.EMISSAO, FI.TRIBUT_ORIGEM, CASE
                                                                                                     WHEN CLIFOR.PAIS <> F.PAIS THEN CTBC.CODIGO_FISCAL_EXTERIOR
                                                                                                     WHEN CLIFOR.UF <> F.UF THEN CTBC.CODIGO_FISCAL_INTERESTADUAL
                                                                                                     ELSE CTBC.CODIGO_FISCAL_OPERACAO
                                                                                                   END, ISNULL(FI.REFERENCIA, FI.CODIGO_ITEM), /*#31#*/
                                                     F.NOME_CLIFOR, CASE 
                                                                      WHEN FI.COD_TABELA_FILHA = 'R' THEN 'P'
                                                                      ELSE 
                                                                        CASE 
                                                                          WHEN FI.COD_TABELA_FILHA = 'T' THEN 'M'
                                                                          ELSE FI.COD_TABELA_FILHA
                                                                        END 
                                                                    END, NS.NATUREZA_ENTRADA_AUTOMATICA, CLIFOR.COD_CLIFOR)
          WHERE  ( ISNULL(LE.ENTRADA_CONFERIDA, 0) = 1 
                   AND FP.INDICA_TRANSFERENCIA_PARA_LOJA = 1 )
                   OR FP.INDICA_TRANSFERENCIA_PARA_LOJA = 0 /*#32#*/;	/*#36#*/

          SET @ROWSENTITEM = @@ROWCOUNT; --> Crispim 
          --SELECT * INTO ##ENTRADAS_ITEM_PERIODO_1 FROM #ENTRADAS_ITEM_PERIODO_1 
          -- FIM - TABELA TEMP DE ENTRADAS_ITEM (FATURAMENTO_ITEM VERIFICANDO LOJA_ENTRADAS) 
          -----------------------------------------------------------------------------------------------------------------------------------------------     
          -- INSERÇÃO NAS TABELAS FÍSICAS (ENTRADAS E ENTRADAS_ITEM VERIFICANDO LOJA_ENTRADAS)     
          INSERT INTO ENTRADAS 
                      (NOME_CLIFOR, 
                       NF_ENTRADA, 
                       SERIE_NF_ENTRADA, 
                       TABELA_FILHA, 
                       FILIAL, 
                       EMISSAO, 
                       RECEBIMENTO, 
                       QTDE_TOTAL, 
                       VALOR_TOTAL, 
                       FRETE, 
                       SEGURO, 
                       DESCONTO, 
                       ENCARGO, 
                       ICMS_VALOR, 
                       IPI_VALOR, 
                       ICMS_BASE, 
                       NATUREZA, 
                       ACERTO_CONTAS_P_R, 
                       CONDICAO_PGTO, 
                       COD_TRANSACAO, 
                       NF_FATURA, 
                       DEVOLUCAO, 
                       NF_PROPRIA_EMITIDA, 
                       TRANSF_FILIAL, 
                       NF_ENTRADA_PROPRIA, 
                       FRETE_A_PAGAR, 
                       IMPORTACAO, 
                       MOEDA, 
                       VALOR_IMPOSTO_AGREGAR, 
                       RATEIO_FILIAL, 
                       ESPECIE_SERIE, 
                       RATEIO_CENTRO_CUSTO, 
                       TIPO_ENTRADAS, 
                       COD_CLIFOR_SACADO, 
                       VALOR_SUB_ITENS, 
                       CHAVE_NFE, 
                       PROTOCOLO_AUTORIZACAO_NFE, 
                       DATA_AUTORIZACAO_NFE, 
                       DATA_DIGITACAO, 
                       FIN_EMISSAO_NFE,/*--#5# */ 
                       TIPO_EMISSAO_NFE,/*--#5# */ 
                       STATUS_NFE,/*--#5# */ 
                       TRANSPORTADORA_A_PAGAR,/*--#7# */ 
                       AGRUPAMENTO_ITENS, 
                       EMPRESA /*#22#*/ 
			          ) /*#15#*/ 
          SELECT NOME_CLIFOR, 
                 NF_ENTRADA, 
                 SERIE_NF_ENTRADA, 
                 TABELA_FILHA, 
                 FILIAL, 
                 EMISSAO, 
                 RECEBIMENTO, 
                 QTDE_TOTAL, 
                 VALOR_TOTAL, 
                 FRETE, 
                 SEGURO, 
                 DESCONTO, 
                 ENCARGO, 
                 ICMS_VALOR, 
                 IPI_VALOR, 
                 ICMS_BASE, 
                 NATUREZA, 
                 ACERTO_CONTAS_P_R, 
                 CONDICAO_PGTO, 
                 COD_TRANSACAO, 
                 NF_FATURA, 
                 DEVOLUCAO, 
                 NF_PROPRIA_EMITIDA, 
                 TRANSF_FILIAL, 
                 NF_ENTRADA_PROPRIA, 
                 FRETE_A_PAGAR, 
                 IMPORTACAO, 
                 MOEDA, 
                 VALOR_IMPOSTO_AGREGAR, 
                 RATEIO_FILIAL, 
                 ESPECIE_SERIE, 
                 RATEIO_CENTRO_CUSTO, 
                 TIPO_ENTRADAS, 
                 COD_CLIFOR_SACADO, 
                 VALOR_SUB_ITENS, 
                 CHAVE_NFE, 
                 PROTOCOLO_AUTORIZACAO_NFE, 
                 DATA_AUTORIZACAO_NFE, 
                 DATA_DIGITACAO, 
                 FIN_EMISSAO_NFE,/*--#5# */ 
                 TIPO_EMISSAO_NFE,/*--#5# */ 
                 STATUS_NFE,/*--#5# */ 
                 TRANSPORTADORA_A_PAGAR,/*--#7# */ 
                 AGRUPAMENTO_ITENS,/*#15#*/ 
                 @EMPRESA /*#22#*/ 
          FROM   #ENTRADAS_PERIODO_1;

          --> #21#  Inclusão registros em lote para minimizar escalonamento de bloqueios. 
          -->        Definição de contexto para evitar multiplas validações desnecessárias em triggers. 
          SET @CONTEXT = 0x53454D5F46494C415F45544C; --0x4C585F474552415F5452414E53464552454E434941535F504552494F444F  
          SET CONTEXT_INFO @CONTEXT; 
          --> Crispim 
          SET @COUNT = 1; 

          WHILE @COUNT <= @ROWSENTITEM 
            BEGIN 
                --> Ponto de Atenção ! 
                INSERT INTO ENTRADAS_ITEM 
                            (CLASSIF_FISCAL, 
                             CODIGO_FISCAL_OPERACAO, 
                             CODIGO_ITEM, 
                             ORIGEM_ITEM,/* #14# */ 
                             COD_TABELA_FILHA, 
                             COMISSAO_ITEM, 
                             COMISSAO_ITEM_GERENTE, 
                             CONTA_CONTABIL, 
                             DESCONTO_ITEM, 
                             DESCRICAO_ITEM, 
                             FAIXA, 
                             ID_EXCECAO_IMPOSTO, 
                             INDICADOR_CFOP, 
                             ITEM_IMPRESSAO, 
                             NF_ENTRADA, 
                             NOME_CLIFOR, 
                             PESO, 
                             PORCENTAGEM_ITEM_RATEIO, 
                             PRECO_UNITARIO, 
                             QTDE_DEVOLVIDA, 
                             QTDE_ITEM, 
                             QTDE_RETORNAR_BENEFICIAMENTO, 
                             SERIE_NF_ENTRADA, 
                             SUB_ITEM_TAMANHO, 
                             TRIBUT_ICMS, 
                             TRIBUT_ORIGEM, 
                             UNIDADE, 
                             VALOR_ITEM, 
                             REFERENCIA, 
                             REFERENCIA_ITEM, 
                             REFERENCIA_PEDIDO, 
                             DIVERGENTE, 
                             TIMESTAMP, 
                             REFERENCIA_ENTREGA_PEDIDO, 
                             VALOR_ENCARGOS, 
                             VALOR_DESCONTOS, 
                             NAO_SOMA_VALOR, 
                             VALOR_ENCARGOS_IMPORTACAO, 
                             RATEIO_FILIAL, 
                             RATEIO_CENTRO_CUSTO,
							 PRECO_UNITARIO_ORIGINAL) --#40#
                SELECT CLASSIF_FISCAL, 
                       CODIGO_FISCAL_OPERACAO, 
                       CODIGO_ITEM, 
                       ORIGEM_ITEM,/*#14# */ 
                       COD_TABELA_FILHA, 
                       COMISSAO_ITEM, 
                       COMISSAO_ITEM_GERENTE, 
                       CONTA_CONTABIL, 
                       DESCONTO_ITEM, 
                       DESCRICAO_ITEM, 
                       FAIXA, 
                       ID_EXCECAO_IMPOSTO, 
                       INDICADOR_CFOP, 
                       ITEM_IMPRESSAO, 
                       NF_ENTRADA, 
                       NOME_CLIFOR, 
                       PESO, 
                       PORCENTAGEM_ITEM_RATEIO, 
                       PRECO_UNITARIO, 
                       QTDE_DEVOLVIDA, 
                       QTDE_ITEM, 
                       QTDE_RETORNAR_BENEFICIAMENTO, 
                       SERIE_NF_ENTRADA, 
                       SUB_ITEM_TAMANHO, 
                       TRIBUT_ICMS, 
                       TRIBUT_ORIGEM, 
                       UNIDADE, 
                       VALOR_ITEM, 
                       REFERENCIA, 
                       REFERENCIA_ITEM, 
                       REFERENCIA_PEDIDO, 
                       DIVERGENTE, 
                       TIMESTAMP, 
                       REFERENCIA_ENTREGA_PEDIDO, 
                       VALOR_ENCARGOS, 
                       VALOR_DESCONTOS, 
                       NAO_SOMA_VALOR, 
                       VALOR_ENCARGOS_IMPORTACAO, 
                       RATEIO_FILIAL, 
                       RATEIO_CENTRO_CUSTO ,
					   PRECO_UNITARIO_ORIGINAL --#40#
                FROM   #ENTRADAS_ITEM_PERIODO_1 
                WHERE  ID >= @COUNT 
                       AND ID <= @COUNT + 1999; 	/*#37#*/

                SET @COUNT+=2000;	/*#37#*/

				/**#34#**/
				UPDATE	ENTRADA
				SET		ENTRADA.NF_ENTRADA = TEMP.NF_ENTRADA,
						ENTRADA.SERIE_NF_ENTRADA = TEMP.SERIE_NF_ENTRADA,
						ENTRADA.NOME_CLIFOR = TEMP.NOME_CLIFOR,
						ENTRADA.RATEIO_FILIAL = TEMP.RATEIO_FILIAL,
						ENTRADA.RATEIO_CENTRO_CUSTO = TEMP.RATEIO_CENTRO_CUSTO,
						ENTRADA.ITEM_IMPRESSAO = TEMP.ITEM_IMPRESSAO,
						ENTRADA.SUB_ITEM_TAMANHO = TEMP.SUB_ITEM_TAMANHO
				FROM		AF_LOCAL_ENTRADA AS ENTRADA
				JOIN		AF_LOCAL_SAIDA AS SAIDA
				ON		ENTRADA.ID_LOCAL_IMOBILIZADO = SAIDA.ID_LOCAL_IMOBILIZADO
						AND ENTRADA.EMPRESA = SAIDA.EMPRESA
				JOIN		#ENTRADAS_ITEM_PERIODO_1 AS TEMP
				ON		SAIDA.NF_SAIDA = TEMP.NF_ENTRADA
						AND SAIDA.SERIE_NF = TEMP.SERIE_NF_ENTRADA
						AND SAIDA.FILIAL = TEMP.NOME_CLIFOR
						AND SAIDA.ITEM_IMPRESSAO = TEMP.ITEM_IMPRESSAO
						AND SAIDA.SUB_ITEM_TAMANHO = TEMP.SUB_ITEM_TAMANHO
				WHERE    ENTRADA.NF_ENTRADA IS NULL 
						 AND ENTRADA.SERIE_NF_ENTRADA IS NULL 
						 AND ENTRADA.NOME_CLIFOR IS NULL
						 AND ENTRADA.ITEM_IMPRESSAO IS NULL
						 AND ENTRADA.SUB_ITEM_TAMANHO IS NULL;

						 /**#34#**/
            END; 

          SET CONTEXT_INFO 0x; 

          -- FIM - INSERÇÃO NAS TABELAS FÍSICAS (ENTRADAS E ENTRADAS_ITEM VERIFICANDO LOJA_ENTRADAS)    
          --------------------------------------------------------------------------------------------------------------------------------------------------------------------     
          --> #21#  Atualização de registros em lote para minimizar escalonamento de bloqueios. 
          DECLARE @ROWSITEMIMP BIGINT = 1; 

          -- GRAVAR REFERÊNCIA DA NF NA TABELA LOJA_ENTRADAS     
          WHILE @ROWSITEMIMP > 0 
            BEGIN 
                UPDATE TOP (3000) A 
                SET    NF_ENTRADA = B.NF_ENTRADA, 
                       NOME_CLIFOR = B.NOME_CLIFOR, 
                       SERIE_NF_ENTRADA = B.SERIE_NF_ENTRADA, 
                       DATA_PARA_TRANSFERENCIA = Getdate() 
                FROM   LOJA_ENTRADAS A 
                       JOIN ENTRADAS B(NOLOCK) 
                         ON B.NOME_CLIFOR = A.FILIAL 
                            AND B.NF_ENTRADA = A.ROMANEIO_NF_SAIDA 
                            AND B.SERIE_NF_ENTRADA = A.SERIE_NF_ENTRADA 
                       JOIN #FATURAMENTO C 
                         ON A.FILIAL_ORIGEM = C.FILIAL 
                            AND A.ROMANEIO_NF_SAIDA = C.NF_SAIDA 
                            AND A.SERIE_NF_ENTRADA = C.SERIE_NF 
                WHERE  A.NF_ENTRADA IS NULL; 

                -- FIM - GRAVAR REFERÊNCIA DA NF NA TABELA LOJA_ENTRADAS     
                --UPDATE top(2000)  A SET    NF_ENTRADA = B.NF_ENTRADA, NOME_CLIFOR = B.NOME_CLIFOR, SERIE_NF_ENTRADA = B.SERIE_NF_ENTRADA 
                --FROM  #FATURAMENTO C  
                --INNER LOOP JOIN  LOJA_ENTRADAS A ON A.FILIAL_ORIGEM = C.FILIAL AND A.ROMANEIO_NF_SAIDA = C.NF_SAIDA AND A.SERIE_NF_ENTRADA = C.SERIE_NF 
                --INNER LOOP JOIN ENTRADAS B (NOLOCK) ON B.NOME_CLIFOR = A.FILIAL AND B.NF_ENTRADA = A.ROMANEIO_NF_SAIDA AND B.SERIE_NF_ENTRADA = A.SERIE_NF_ENTRADA 
                --WHERE  A.NF_ENTRADA IS NULL  
                --option (recompile) 
                SET @ROWSITEMIMP = @@ROWCOUNT; 
            END; 

          --waitfor delay '00:02:00' 
          SET @ROWSITEMIMP = 0; 

          -------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
          --select COUNT(*) from dbo.LxProcessoSP --1 
          --> #21#  Criação explícita da tabela temporária para geração de impostos por lote ao invés de gerar linha a linha
          CREATE TABLE #TMP_ITEM_IMPRESSAO 
            ( 
               ID               INT IDENTITY(1, 1) NOT NULL, 
               FILIAL           VARCHAR(25) COLLATE DATABASE_DEFAULT /*#27#*/ NOT NULL, 
               ROMANEIO_PRODUTO CHAR(15) COLLATE DATABASE_DEFAULT /*#27#*/ NOT NULL, 
               PRODUTO          CHAR(12) COLLATE DATABASE_DEFAULT /*#27#*/ NOT NULL, 
               COR_PRODUTO      CHAR(10) COLLATE DATABASE_DEFAULT /*#27#*/ NOT NULL, 
               ITEM_IMPRESSAO   CHAR(4) COLLATE DATABASE_DEFAULT, /*#27#*/ 
               /*constraint XPK#TMP_ITEM_IMPRESSAO*/ 
               PRIMARY KEY(ID, FILIAL, ROMANEIO_PRODUTO, PRODUTO, COR_PRODUTO, ITEM_IMPRESSAO)
            ); 

          INSERT INTO #TMP_ITEM_IMPRESSAO 
                      (FILIAL, 
                       ROMANEIO_PRODUTO, 
                       PRODUTO, 
                       COR_PRODUTO, 
                       ITEM_IMPRESSAO) 
          SELECT LE.FILIAL, 
                 LE.ROMANEIO_PRODUTO, 
                 FP.PRODUTO, 
                 FP.COR_PRODUTO, 
                 Max(FP.ITEM_IMPRESSAO) AS ITEM_IMPRESSAO 
          FROM   #ENTRADAS_PERIODO_1 AS EP 
                 INNER JOIN #ENTRADAS_ITEM_PERIODO_1 AS EIP 
                         ON EP.NOME_CLIFOR = EIP.NOME_CLIFOR 
                            AND EP.NF_ENTRADA = EIP.NF_ENTRADA 
                            AND EP.SERIE_NF_ENTRADA = EIP.SERIE_NF_ENTRADA 
                 INNER JOIN DBO.FATURAMENTO_PROD AS FP 
                         ON EIP.NOME_CLIFOR = FP.FILIAL 
                            AND EIP.NF_ENTRADA = FP.NF_SAIDA 
                            AND EIP.SERIE_NF_ENTRADA = FP.SERIE_NF 
                            AND EIP.ITEM_IMPRESSAO = FP.ITEM_IMPRESSAO 
                 INNER JOIN DBO.LOJA_ENTRADAS AS LE 
                         ON LE.NUMERO_NF_TRANSFERENCIA = EP.NF_ENTRADA 
                            AND LE.FILIAL_ORIGEM = EP.NOME_CLIFOR 
                            AND LE.SERIE_NF_ENTRADA = EP.SERIE_NF_ENTRADA 
          --INNER JOIN LOJA_ENTRADAS_PRODUTO AS LEP WITH (ROWLOCK) ON LE.ROMANEIO_PRODUTO = LEP.ROMANEIO_PRODUTO AND LE.FILIAL = LEP.FILIAL AND LEP.PRODUTO = FP.PRODUTO  
          --  AND LEP.COR_PRODUTO = FP.COR_PRODUTO 
          --WHERE  LEP.ITEM_IMPRESSAO IS NULL 
          GROUP  BY LE.ROMANEIO_PRODUTO, 
                    LE.FILIAL, 
                    FP.PRODUTO, 
                    FP.COR_PRODUTO; --,  FP.ITEM_IMPRESSAO 

          SET @ROWSITEMIMP = @@ROWCOUNT; 
          --select COUNT(*) from dbo.LxProcessoSP --1 
          --select * into ##TMP_ITEM_IMPRESSAO from #TMP_ITEM_IMPRESSAO as EP   
          --return 
          --> #21#  Atualização de registros em lote para minimizar escalonamento de bloqueios. 
          -->        Definição de contexto para evitar multiplas validações desnecessárias em triggers. 
          SET @COUNT = 1; 
          SET @CONTEXT = 0x53454D5F46494C415F45544C; --0x4C585F474552415F5452414E53464552454E434941535F504552494F444F  
          SET CONTEXT_INFO @CONTEXT; 

          WHILE @COUNT <= @ROWSITEMIMP 
            BEGIN 
                UPDATE LEP 
                SET    ITEM_IMPRESSAO = EP.ITEM_IMPRESSAO, 
                       DATA_PARA_TRANSFERENCIA = Getdate() 
                FROM   #TMP_ITEM_IMPRESSAO AS EP 
                       INNER JOIN LOJA_ENTRADAS_PRODUTO AS LEP 
                               ON EP.ROMANEIO_PRODUTO = LEP.ROMANEIO_PRODUTO 
                                  AND EP.FILIAL = LEP.FILIAL 
                                  AND LEP.PRODUTO = EP.PRODUTO 
                                  AND LEP.COR_PRODUTO = EP.COR_PRODUTO 
                WHERE  EP.ID >= @COUNT 
                       AND EP.ID <= @COUNT + 1999	/*#37#*/
                       AND LEP.ITEM_IMPRESSAO IS NULL 
                OPTION( RECOMPILE); 

                SET @COUNT+=2000;	/*#37#*/
            END; 
      --waitfor delay '00:03:00'; 
      --if @DATA_INICIAL = '20160204' 
      --select COUNT(*) from dbo.LxProcessoSP --3 
      END; 

    SET CONTEXT_INFO 0x; 

    -----------------------------------------------------------------------------------------------------------------------------------------------     
    -- GERAÇÃO DE IMPOSTOS   
    IF (SELECT Object_id('TEMPDB..#ENTRADAS_PERIODO')) IS NOT NULL 
      BEGIN 
          --> #21#  Definição de contexto para evitar multiplas validações desnecessárias em triggers. 
          SET @CONTEXT = 0x53454D5F46494C415F45544C; --0x4C585F474552415F5452414E53464552454E434941535F504552494F444F  
          SET CONTEXT_INFO @CONTEXT; 

          --> #21#  Criação explícita da tabela temporária para geração de impostos por lote ao invés de gerar linha a linha 
          INSERT INTO #TMP_IMPOSTO_ENT 
                      (NOME_CLIFOR, 
                       NF_ENTRADA, 
                       SERIE_NF_ENTRADA, 
                       GERA_IMPOSTO) 
          SELECT DISTINCT A.NOME_CLIFOR, 
                          A.NF_ENTRADA, 
                          A.SERIE_NF_ENTRADA, 
                          CASE 
                            WHEN A.SERIE_NF_ENTRADA <> @TIPO_PRODUCAO THEN 1 
                            ELSE 0 
                          END AS GERA_IMPOSTO 
          --INTO  ##TMP_IMPOSTO_ENT 
          FROM   DBO.ENTRADAS AS A(NOLOCK) 
                 JOIN #ENTRADAS_PERIODO AS B(NOLOCK) 
                   ON A.NOME_CLIFOR = B.NOME_CLIFOR 
                      AND A.NF_ENTRADA = B.NF_ENTRADA 
                      AND A.SERIE_NF_ENTRADA = B.SERIE_NF_ENTRADA; 

          DECLARE CUR_IMPOSTO CURSOR LOCAL FAST_FORWARD /*#1#*/ 
          FOR 
            SELECT NOME_CLIFOR, 
                   NF_ENTRADA, 
                   SERIE_NF_ENTRADA 
            FROM   #TMP_IMPOSTO_ENT 
            ORDER  BY NOME_CLIFOR, 
                      NF_ENTRADA, 
                      SERIE_NF_ENTRADA; 

          OPEN CUR_IMPOSTO; 

          FETCH NEXT FROM CUR_IMPOSTO INTO @NOME_CLIFOR_CUR, @NF_ENTRADA_CUR, @SERIE_NF_ENTRADA_CUR;

          WHILE @@FETCH_STATUS = 0 
            BEGIN 
                IF @SERIE_NF_ENTRADA_CUR <> @TIPO_PRODUCAO 
                  BEGIN 

					  /*#44#*/
					  IF EXISTS (SELECT TOP 1 1 
								 FROM DBO.ENTRADAS_ITEM AS NF (NOLOCK) 
								 INNER JOIN DBO.CTB_EXCECAO_IMPOSTO AS EXC (NOLOCK) 
										 ON NF.ID_EXCECAO_IMPOSTO = EXC.ID_EXCECAO_IMPOSTO 
								 WHERE	NF.NF_ENTRADA = @NF_ENTRADA_CUR 
										AND NF.NOME_CLIFOR = @NOME_CLIFOR_CUR 
										AND NF.SERIE_NF_ENTRADA = @SERIE_NF_ENTRADA_CUR
										AND EXC.RECRIA_IMPOSTOS_TRANSFERENCIA = 1)
					      SET @RECALCULAR_IMPOSTO_EXCECAO = 1;
					  ELSE 
						  SET @RECALCULAR_IMPOSTO_EXCECAO = 0;
					  /*#44#*/

			          EXEC LX_GERA_IMPOSTOS_ENTRADA	@NOME_CLIFOR_CUR, 
													@NF_ENTRADA_CUR, 
													@SERIE_NF_ENTRADA_CUR, --(#ENTRADAS_PERIODO) 
													0,							 --@RECRIAR						/*#44#*/
													1,							 --@EXECUTAR_AJUSTE_GRUPO		/*#44#*/
													0,							 --@RECALCULAR_IMPOSTO_AGREGAR	/*#44#*/
													@RECALCULAR_IMPOSTO_EXCECAO	 --@RECALCULAR_IMPOSTO_EXCECAO	/*#44#*/

                  --EXEC LX_CONCILIA_IMPOSTOS_ENTRADA_POR_SAIDA @NOME_CLIFOR_CUR, @NF_ENTRADA_CUR, @SERIE_NF_ENTRADA_CUR 
                  END; 

                --INTEGRAÇÃO CONTÁBIL     
                IF @CONTABILIDADE_ATIVA = 1	--#43# EXISTS (SELECT 1 FROM   PARAMETROS(NOLOCK) WHERE  PARAMETRO = 'CONTABILIDADE_ATIVA' AND VALOR_ATUAL = '.T.') 
                  BEGIN 
                      EXEC LX_CTB_INTEGRAR_ENTRADA	@NOME_CLIFOR_CUR, 
													@NF_ENTRADA_CUR, 
													@SERIE_NF_ENTRADA_CUR 
                  END; 

                FETCH NEXT FROM CUR_IMPOSTO INTO @NOME_CLIFOR_CUR, @NF_ENTRADA_CUR, @SERIE_NF_ENTRADA_CUR;
            END; 

          CLOSE CUR_IMPOSTO; 

          DEALLOCATE CUR_IMPOSTO; 

          --> #21# Execução da procedure de geração de impostos para processamento em lote, ao invés de linha a linha
          EXEC DBO.LX_CONCILIA_IMPOSTOS_ENTRADA_POR_SAIDA	@NOME_CLIFOR_CUR, 
															@NF_ENTRADA_CUR, 
															@SERIE_NF_ENTRADA_CUR; 

          TRUNCATE TABLE #TMP_IMPOSTO_ENT; 

          SET CONTEXT_INFO 0x; 
      END; 

    IF (SELECT Object_id('TEMPDB..#ENTRADAS_PERIODO_1')) IS NOT NULL 
      BEGIN 
          --> #21#  Definição de contexto para evitar multiplas validações desnecessárias em triggers. 
          SET @CONTEXT = 0x53454D5F46494C415F45544C; --0x4C585F474552415F5452414E53464552454E434941535F504552494F444F  
          SET CONTEXT_INFO @CONTEXT; 

          --> #21#  Criação explícita da tabela temporária para geração de impostos por lote ao invés de gerar linha a linha 
          INSERT INTO #TMP_IMPOSTO_ENT 
                      (NOME_CLIFOR, 
                       NF_ENTRADA, 
                       SERIE_NF_ENTRADA, 
                       GERA_IMPOSTO) 
          SELECT DISTINCT A.NOME_CLIFOR, 
                          A.NF_ENTRADA, 
                          A.SERIE_NF_ENTRADA, 
                          CASE 
                            WHEN A.SERIE_NF_ENTRADA <> @TIPO_PRODUCAO THEN 1 
                            ELSE 0 
                          END AS GERA_IMPOSTO 
          --INTO  #TMP_IMPOSTO_ENT 
          FROM   DBO.ENTRADAS AS A(NOLOCK) 
                 JOIN #ENTRADAS_PERIODO_1 AS B(NOLOCK) 
                   ON A.NOME_CLIFOR = B.NOME_CLIFOR 
                      AND A.NF_ENTRADA = B.NF_ENTRADA 
                      AND A.SERIE_NF_ENTRADA = B.SERIE_NF_ENTRADA; 

          DECLARE CUR_IMPOSTO CURSOR LOCAL FAST_FORWARD /*#1#*/ 
          FOR 
            SELECT NOME_CLIFOR, 
                   NF_ENTRADA, 
                   SERIE_NF_ENTRADA 
            FROM   #TMP_IMPOSTO_ENT AS A(NOLOCK) 
            ORDER  BY NOME_CLIFOR, 
                      NF_ENTRADA, 
                      SERIE_NF_ENTRADA; 

          OPEN CUR_IMPOSTO; 

          FETCH NEXT FROM CUR_IMPOSTO INTO @NOME_CLIFOR_CUR, @NF_ENTRADA_CUR, @SERIE_NF_ENTRADA_CUR;

          WHILE @@FETCH_STATUS = 0 
            BEGIN 
                IF @SERIE_NF_ENTRADA_CUR <> @TIPO_PRODUCAO 
                  BEGIN 

					  /*#44#*/
					  IF EXISTS (SELECT TOP 1 1 
								 FROM DBO.ENTRADAS_ITEM AS NF (NOLOCK) 
								 INNER JOIN DBO.CTB_EXCECAO_IMPOSTO AS EXC (NOLOCK) 
										 ON NF.ID_EXCECAO_IMPOSTO = EXC.ID_EXCECAO_IMPOSTO 
								 WHERE	NF.NF_ENTRADA = @NF_ENTRADA_CUR 
										AND NF.NOME_CLIFOR = @NOME_CLIFOR_CUR 
										AND NF.SERIE_NF_ENTRADA = @SERIE_NF_ENTRADA_CUR
										AND EXC.RECRIA_IMPOSTOS_TRANSFERENCIA = 1)
					      SET @RECALCULAR_IMPOSTO_EXCECAO = 1;
					  ELSE 
						  SET @RECALCULAR_IMPOSTO_EXCECAO = 0;
					  /*#44#*/

                      EXEC LX_GERA_IMPOSTOS_ENTRADA	@NOME_CLIFOR_CUR, 
													@NF_ENTRADA_CUR, 
													@SERIE_NF_ENTRADA_CUR, --(#ENTRADAS_PERIODO_1) 
													0,							 --@RECRIAR						/*#44#*/
													1,							 --@EXECUTAR_AJUSTE_GRUPO		/*#44#*/
													0,							 --@RECALCULAR_IMPOSTO_AGREGAR	/*#44#*/
													@RECALCULAR_IMPOSTO_EXCECAO	 --@RECALCULAR_IMPOSTO_EXCECAO	/*#44#*/

                  --EXEC LX_CONCILIA_IMPOSTOS_ENTRADA_POR_SAIDA @NOME_CLIFOR_CUR, @NF_ENTRADA_CUR, @SERIE_NF_ENTRADA_CUR 
                  END; 

                --INTEGRAÇÃO CONTÁBIL     
                IF @CONTABILIDADE_ATIVA = 1	--#43# EXISTS (SELECT 1 FROM   PARAMETROS(NOLOCK) WHERE  PARAMETRO = 'CONTABILIDADE_ATIVA' AND VALOR_ATUAL = '.T.') 
                  BEGIN 
                      EXEC LX_CTB_INTEGRAR_ENTRADA	@NOME_CLIFOR_CUR, 
													@NF_ENTRADA_CUR, 
													@SERIE_NF_ENTRADA_CUR 
                  END; 

                FETCH NEXT FROM CUR_IMPOSTO INTO @NOME_CLIFOR_CUR, @NF_ENTRADA_CUR, @SERIE_NF_ENTRADA_CUR;
            END; 

          CLOSE CUR_IMPOSTO; 

          DEALLOCATE CUR_IMPOSTO; 

          --> #21# Execução da procedure de geração de impostos para processamento em lote, ao invés de linha a linha
          EXEC DBO.LX_CONCILIA_IMPOSTOS_ENTRADA_POR_SAIDA	@NOME_CLIFOR_CUR, 
															@NF_ENTRADA_CUR, 
															@SERIE_NF_ENTRADA_CUR; 

          TRUNCATE TABLE #TMP_IMPOSTO_ENT; 

          SET CONTEXT_INFO 0x; 
      END; 

    -- FIM - GERAÇÃO DE IMPOSTOS     
    -----------------------------------------------------------------------------------------------------------------------------------------------    
    -- TABELA TEMP DE LOJA_NOTA FISCAL  
    --APENAS TRANSFERENCIAS QUE NÃO SEJAM PARA LOJAS /*#12#*/  
    SELECT DISTINCT F2.FILIAL, 
                    LJ.NF_NUMERO, 
                    LJ.SERIE_NF, 
                    LJ.CODIGO_FILIAL, 
                    LJ.NATUREZA_OPERACAO_CODIGO, 
                    LJ.EMISSAO, 
                    LJ.QTDE_TOTAL, 
                    LJ.VALOR_TOTAL, 
                    LJ.FRETE, 
                    LJ.SEGURO, 
                    LJ.ENCARGO, 
                    LJ.DESCONTO, 
                    LJ.VALOR_IMPOSTO_AGREGAR, 
                    LJ.COD_CLIFOR, 
                    LJ.VALOR_TOTAL_ITENS, 
                    LJ.CHAVE_NFE, 
                    LJ.PROTOCOLO_AUTORIZACAO_NFE, 
                    LJ.DATA_AUTORIZACAO_NFE, 
                    LJ.FIN_EMISSAO_NFE,--#5#  
                    LJ.TIPO_EMISSAO_NFE,--#5#  
                    LJ.STATUS_NFE,--#5#  
                    ISNULL(TRANSP.TRANSPORTADORA, LJ.TRANSPORTADORA)    AS TRANSPORTADORA,/*#13#*/
                    Cast(CONVERT(CHAR(8), LJ.EMISSAO, 112) AS DATETIME) AS DATA_RECEBIMENTO,/*#24#*/
                    --LJ.EMISSAO                                       AS DATA_RECEBIMENTO /*#12#*/ 
                    Cast(LJ.OBS AS VARCHAR(MAX))                        AS OBS,/*#28#*/ 
                    Cast(LJ.OBS_INTERESSE_FISCO AS VARCHAR(4000))       AS OBS_INTERESSE_FISCO,/*#28#*/
                    Cast(LJ.INFORMACAO_COMPLEMENTAR AS VARCHAR(4000))   AS INFORMACAO_COMPLEMENTAR,/*#29#*/
                    INDICA_TRANSFERENCIA_PARA_LOJA = 0 /*#32#*/ 
    INTO   #LOJA_NOTA_FISCAL 
    FROM   LOJA_NOTA_FISCAL AS LJ(NOLOCK) 
           JOIN EMPRESA AS E(NOLOCK) 
             ON E.EMPRESA = LJ.EMPRESA 
           JOIN LOJAS_NATUREZA_OPERACAO AS LNO(NOLOCK) 
             ON LJ.NATUREZA_OPERACAO_CODIGO = LNO.NATUREZA_OPERACAO_CODIGO 
           JOIN NATUREZAS_SAIDAS AS NS(NOLOCK) 
             ON LNO.NATUREZA_SAIDA = NS.NATUREZA_SAIDA 
           JOIN NATUREZAS_ENTRADAS AS NE(NOLOCK) 
             ON NS.NATUREZA_ENTRADA_AUTOMATICA = NE.NATUREZA 
           JOIN FILIAIS AS F(NOLOCK) 
             ON LJ.COD_CLIFOR = F.COD_FILIAL 
           JOIN LOJAS_VAREJO AS LV(NOLOCK) 
             ON LV.CODIGO_FILIAL = LJ.CODIGO_FILIAL 
           JOIN FILIAIS AS F2(NOLOCK) 
             ON LV.FILIAL = F2.FILIAL 
           INNER JOIN SERIES_NF AS SN --#6#  
                   ON SN.SERIE_NF = LJ.SERIE_NF 
           INNER JOIN CTB_ESPECIE_SERIE AS CES --#6#  
                   ON CES.ESPECIE_SERIE = SN.ESPECIE_SERIE --#7#  
           LEFT JOIN TRANSPORTADORAS AS TRANSP WITH (NOLOCK) --#9#  
                  /*#13#*/ 
                  ON TRANSP.TRANSPORTADORA = LJ.TRANSPORTADORA /*ON  TRANSP.CGC = LJ.TRANSP_CGC 
                                                                         AND TRANSP.RAZAO_SOCIAL = LJ.TRANSP_RAZAO_SOCIAL*/
           LEFT JOIN LOJA_ENTRADAS AS LE /*#12#*/ 
                  ON LV.FILIAL = LE.FILIAL_ORIGEM /*#30#*/ 
                     --#30#ON F.FILIAL = LE.FILIAL_ORIGEM /*#12#*/  
                     AND LJ.NF_NUMERO = ISNULL(LE.NUMERO_NF_TRANSFERENCIA, LE.ROMANEIO_NF_SAIDA) /*#18#*/ /*#12#*/
                     AND LJ.SERIE_NF = LE.SERIE_NF_ENTRADA /*#12#*/ 
    /*AND LJ.EMISSAO = LE.EMISSAO /*#20#*/*/ /*#26#*/ 
    WHERE  LJ.EMPRESA = @EMPRESA 
           AND F.INDICA_BENEFICIADOR = 0 
           AND F.INDICA_FRANQUIA = 0 
           AND LJ.NOTA_CANCELADA = 0 
           AND ISNULL(F.MATRIZ_FISCAL, '') <> ISNULL(F2.MATRIZ_FISCAL, '') 
           AND ( F.FILIAL = @FILIAL_FILTRO 
                  OR @FILIAL_FILTRO IS NULL ) 
           AND ( F2.FILIAL = @FILIAL_ORIGEM 
                  OR @FILIAL_ORIGEM IS NULL ) 
           AND ( LJ.CHAVE_NFE = @CHAVE_NFE 
                  OR @CHAVE_NFE IS NULL ) 
           AND LJ.EMISSAO BETWEEN @DATA_INICIAL AND @DATA_FINAL 
           AND ( CES.NUMERO_MODELO_FISCAL = '55' 
                 AND LJ.STATUS_NFE = 5 --#6#  --#10#  
                  OR CES.NUMERO_MODELO_FISCAL <> '55' ) --#6#  --#10#  
           AND NOT EXISTS (SELECT 1 
                           FROM   ENTRADAS AS E(NOLOCK) 
                           WHERE  E.NOME_CLIFOR = F2.FILIAL 
                                  AND E.NF_ENTRADA = LJ.NF_NUMERO 
                                  AND E.SERIE_NF_ENTRADA = LJ.SERIE_NF) 
           AND ISNULL(LE.NUMERO_NF_TRANSFERENCIA, LE.ROMANEIO_NF_SAIDA) /*#18#*/ IS NULL; /*#12#*/

    --APENAS TRANSFERENCIAS QUE SEJAM PARA LOJAS /*#12#*/  
    INSERT INTO #LOJA_NOTA_FISCAL 
    SELECT DISTINCT F2.FILIAL, 
                    LJ.NF_NUMERO, 
                    LJ.SERIE_NF, 
                    LJ.CODIGO_FILIAL, 
                    LJ.NATUREZA_OPERACAO_CODIGO, 
                    LJ.EMISSAO, 
                    LJ.QTDE_TOTAL, 
                    LJ.VALOR_TOTAL, 
                    LJ.FRETE, 
                    LJ.SEGURO, 
                    LJ.ENCARGO, 
                    LJ.DESCONTO, 
                    LJ.VALOR_IMPOSTO_AGREGAR, 
                    LJ.COD_CLIFOR, 
                    LJ.VALOR_TOTAL_ITENS, 
                    LJ.CHAVE_NFE, 
                    LJ.PROTOCOLO_AUTORIZACAO_NFE, 
                    LJ.DATA_AUTORIZACAO_NFE, 
                    LJ.FIN_EMISSAO_NFE,--#5#  
                    LJ.TIPO_EMISSAO_NFE,--#5#  
                    LJ.STATUS_NFE,--#5#  
                    ISNULL(TRANSP.TRANSPORTADORA, LJ.TRANSPORTADORA)  AS TRANSPORTADORA,/*#13#*/
                    Cast(CONVERT(CHAR(8), COALESCE(LE.DATA_ENTRADA_CONFERIDA, LE.EMISSAO, LJ.EMISSAO), 112) AS DATETIME),/*#24#*/
                    --#24#COALESCE(LE.DATA_ENTRADA_CONFERIDA, LE.EMISSAO, LJ.EMISSAO) /*#12#*/  
                    Cast(LJ.OBS AS VARCHAR(MAX))                      AS OBS,/*#28#*/ 
                    Cast(LJ.OBS_INTERESSE_FISCO AS VARCHAR(4000))     AS OBS_INTERESSE_FISCO,/*#28#*/
                    Cast(LJ.INFORMACAO_COMPLEMENTAR AS VARCHAR(4000)) AS INFORMACAO_COMPLEMENTAR,/*#29#*/
                    INDICA_TRANSFERENCIA_PARA_LOJA = 1 /*#32#*/ 
    FROM   LOJA_NOTA_FISCAL AS LJ(NOLOCK) 
           JOIN EMPRESA AS E(NOLOCK) 
             ON E.EMPRESA = LJ.EMPRESA 
           JOIN LOJAS_NATUREZA_OPERACAO AS LNO(NOLOCK) 
             ON LJ.NATUREZA_OPERACAO_CODIGO = LNO.NATUREZA_OPERACAO_CODIGO 
           JOIN NATUREZAS_SAIDAS AS NS(NOLOCK) 
             ON LNO.NATUREZA_SAIDA = NS.NATUREZA_SAIDA 
           JOIN NATUREZAS_ENTRADAS AS NE(NOLOCK) 
             ON NS.NATUREZA_ENTRADA_AUTOMATICA = NE.NATUREZA 
           JOIN FILIAIS AS F(NOLOCK) 
             ON LJ.COD_CLIFOR = F.COD_FILIAL 
           JOIN LOJAS_VAREJO AS LV(NOLOCK) 
             ON LV.CODIGO_FILIAL = LJ.CODIGO_FILIAL 
           JOIN FILIAIS AS F2(NOLOCK) 
             ON LV.FILIAL = F2.FILIAL 
           INNER JOIN SERIES_NF AS SN --#6#  
                   ON SN.SERIE_NF = LJ.SERIE_NF 
           INNER JOIN CTB_ESPECIE_SERIE AS CES --#6#  
                   ON CES.ESPECIE_SERIE = SN.ESPECIE_SERIE --#7#  
           LEFT JOIN TRANSPORTADORAS AS TRANSP WITH (NOLOCK) --#9#  
                  /*#13#*/ 
                  ON TRANSP.TRANSPORTADORA = LJ.TRANSPORTADORA /*ON  TRANSP.CGC = LJ.TRANSP_CGC 
                                                                         AND TRANSP.RAZAO_SOCIAL = LJ.TRANSP_RAZAO_SOCIAL*/
           LEFT JOIN LOJA_ENTRADAS AS LE /*#12#*/ 
                  ON LV.FILIAL = LE.FILIAL_ORIGEM /*#30#*/ 
                     --#30#ON F.FILIAL = LE.FILIAL_ORIGEM /*#12#*/  
                     AND LJ.NF_NUMERO = ISNULL(LE.NUMERO_NF_TRANSFERENCIA, LE.ROMANEIO_NF_SAIDA) /*#18#*/ /*#12#*/
                     AND LJ.SERIE_NF = LE.SERIE_NF_ENTRADA /*#12#*/ 
    WHERE  LJ.EMPRESA = @EMPRESA 
           AND F.INDICA_BENEFICIADOR = 0 
           AND F.INDICA_FRANQUIA = 0 
           AND LJ.NOTA_CANCELADA = 0 
           AND ISNULL(F.MATRIZ_FISCAL, '') <> ISNULL(F2.MATRIZ_FISCAL, '') 
           AND ( F.FILIAL = @FILIAL_FILTRO 
                  OR @FILIAL_FILTRO IS NULL ) 
           AND ( F2.FILIAL = @FILIAL_ORIGEM 
                  OR @FILIAL_ORIGEM IS NULL ) 
           AND ( LJ.CHAVE_NFE = @CHAVE_NFE 
                  OR @CHAVE_NFE IS NULL ) 
           AND COALESCE(LE.DATA_ENTRADA_CONFERIDA, LE.EMISSAO, LJ.EMISSAO) BETWEEN @DATA_INICIAL AND @DATA_FINAL /*#12#*/
           AND ( CES.NUMERO_MODELO_FISCAL = '55' 
                 AND LJ.STATUS_NFE = 5 --#6#  --#10#  
                  OR CES.NUMERO_MODELO_FISCAL <> '55' ) --#6#  --#10#  
           AND NOT EXISTS (SELECT 1 
                           FROM   ENTRADAS AS E(NOLOCK) 
                           WHERE  E.NOME_CLIFOR = F2.FILIAL 
                                  AND E.NF_ENTRADA = LJ.NF_NUMERO 
                                  AND E.SERIE_NF_ENTRADA = LJ.SERIE_NF) 
           AND LE.ENTRADA_CONFERIDA = 1; /*#12#*/ 

    -- FIM - TABELA TEMP DE LOJA_NOTA FISCAL    
    -----------------------------------------------------------------------------------------------------------------------------------------------    
    IF @VERIFICA_LOJA_ENTRADAS = 0 
      BEGIN 
          -----------------------------------------------------------------------------------------------------------------------------------------------    
          -- TABELA TEMP DE ENTRADAS (LOJA_NOTA_FISCAL SEM VERIFICAR LOJA_ENTRADAS)    
          SELECT NOME_CLIFOR = F2.FILIAL, 
                 NF_ENTRADA = LP.NF_NUMERO, 
                 SERIE_NF_ENTRADA = LP.SERIE_NF, 
                 TABELA_FILHA = 'FAT_IMAGEM', 
                 FILIAL = CLIFOR.NOME_CLIFOR, 
                 EMISSAO = LP.EMISSAO, 
                 RECEBIMENTO = LP.DATA_RECEBIMENTO,/*#12#*/ 
                 QTDE_TOTAL = LP.QTDE_TOTAL, 
                 VALOR_TOTAL = LP.VALOR_TOTAL, 
                 FRETE = LP.FRETE, 
                 SEGURO = LP.SEGURO, 
                 DESCONTO = LP.DESCONTO, 
                 ENCARGO = LP.ENCARGO, 
                 ICMS_VALOR = 0.00, 
                 IPI_VALOR = 0.00, 
                 ICMS_BASE = 0.00, 
                 NATUREZA = NE.NATUREZA, 
                 ACERTO_CONTAS_P_R = 0, 
                 CONDICAO_PGTO = (SELECT Max(CONDICAO_PGTO) 
                                  FROM   COND_ENT_PGTOS(NOLOCK) 
                                  WHERE  TIPO_CONDICAO = 'VISTA'), 
                 COD_TRANSACAO = 'ENTRADAS_109', 
                 NF_FATURA = 0, 
                 DEVOLUCAO = 0, 
                 NF_PROPRIA_EMITIDA = 0,/*#19# #23#*/ 
                 TRANSF_FILIAL = 1, 
                 NF_ENTRADA_PROPRIA = 0,/*#19# #23#*/ 
                 FRETE_A_PAGAR = LP.FRETE, 
                 IMPORTACAO = 0, 
                 MOEDA = @MOEDA_PADRAO, 
                 VALOR_IMPOSTO_AGREGAR = LP.VALOR_IMPOSTO_AGREGAR, 
                 RATEIO_FILIAL = LP.COD_CLIFOR, 
                 ESPECIE_SERIE = ISNULL((SELECT SERIES_NF.ESPECIE_SERIE 
                                         FROM   SERIES_NF(NOLOCK) 
                                         WHERE  SERIES_NF.SERIE_NF = LP.SERIE_NF), @ESPECIE_SERIE),
                 RATEIO_CENTRO_CUSTO = @RATEIO_CENTRO_CUSTO_PADRAO, 
                 TIPO_ENTRADAS = @TIPO_ENTRADAS_PADRAO, 
                 COD_CLIFOR_SACADO = F.COD_FILIAL, 
                 VALOR_SUB_ITENS = LP.VALOR_TOTAL_ITENS, 
                 CHAVE_NFE = LP.CHAVE_NFE, 
                 PROTOCOLO_AUTORIZACAO_NFE = LP.PROTOCOLO_AUTORIZACAO_NFE, 
                 DATA_AUTORIZACAO_NFE = LP.DATA_AUTORIZACAO_NFE, 
                 DATA_DIGITACAO = Cast(CONVERT(CHAR(8), Getdate(), 112) AS DATETIME), 
                 NATUREZA_OPERACAO_CODIGO = LP.NATUREZA_OPERACAO_CODIGO, 
                 CODIGO_FILIAL = LP.CODIGO_FILIAL, 
                 NF_NUMERO = LP.NF_NUMERO, 
                 SERIE_NF = LP.SERIE_NF, 
                 COD_CLIFOR = LP.COD_CLIFOR, 
                 FIN_EMISSAO_NFE = LP.FIN_EMISSAO_NFE,--#5#  
                 TIPO_EMISSAO_NFE = LP.TIPO_EMISSAO_NFE,--#5#  
                 STATUS_NFE = LP.STATUS_NFE,--#5#  
                 TRANSPORTADORA = LP.TRANSPORTADORA,--#7# 
                 LP.OBS,/*#28#*/ 
                 LP.OBS_INTERESSE_FISCO,/*#28#*/ 
                 LP.INFORMACAO_COMPLEMENTAR /*#29#*/ 
          INTO   #LOJA_NOTA_FISCAL_PERIODO 
          FROM   #LOJA_NOTA_FISCAL AS LP 
                 JOIN LOJAS_NATUREZA_OPERACAO AS LNO(NOLOCK) 
                   ON LP.NATUREZA_OPERACAO_CODIGO = LNO.NATUREZA_OPERACAO_CODIGO 
                 JOIN FILIAIS AS F(NOLOCK) 
                   ON LP.COD_CLIFOR = F.COD_FILIAL 
                 JOIN CADASTRO_CLI_FOR AS CLIFOR(NOLOCK) 
                   ON LP.COD_CLIFOR = CLIFOR.COD_CLIFOR 
                 JOIN NATUREZAS_SAIDAS AS NS(NOLOCK) 
                   ON LNO.NATUREZA_SAIDA = NS.NATUREZA_SAIDA 
                 JOIN NATUREZAS_ENTRADAS AS NE(NOLOCK) 
                   ON NS.NATUREZA_ENTRADA_AUTOMATICA = NE.NATUREZA 
                 LEFT JOIN LOJAS_VAREJO AS LV(NOLOCK) 
                        ON LV.CODIGO_FILIAL = LP.CODIGO_FILIAL 
                 LEFT JOIN FILIAIS AS F2 
                        ON LV.FILIAL = F2.FILIAL; 

          -- FIM - TABELA TEMP DE ENTRADAS (LOJA_NOTA_FISCAL SEM VERIFICAR LOJA_ENTRADAS)    
          -----------------------------------------------------------------------------------------------------------------------------------------------    
          --> #21#  Criação explícita da tabela temporária ao invés de criá-la através da instrução SELECT INTO. 
          -->        Inclusão de coluna sequencial (row_number) para controlar a inclusão/alteração de registros em lote.
          SET @ROWSLOJAENTITEM = 0; 

          -- TABELA TEMP DE ENTRADAS_ITEM (LOJA_NOTA_FISCAL_ITEM SEM VERIFICAR LOJA_ENTRADAS)
          CREATE TABLE #LOJA_NOTA_FISCAL_ITEM_PERIODO 
            ( 
               ID                           BIGINT NOT NULL PRIMARY KEY, 
               CLASSIF_FISCAL               CHAR(10) COLLATE DATABASE_DEFAULT NOT NULL, 
               CODIGO_FISCAL_OPERACAO       CHAR(4) COLLATE DATABASE_DEFAULT NULL, 
               CODIGO_ITEM                  VARCHAR(50) COLLATE DATABASE_DEFAULT NOT NULL, 
               ORIGEM_ITEM                  CHAR(1) NOT NULL, 
               COD_TABELA_FILHA             CHAR(1) COLLATE DATABASE_DEFAULT NOT NULL, 
               COMISSAO_ITEM                NUMERIC(2, 2) NOT NULL, 
               COMISSAO_ITEM_GERENTE        NUMERIC(2, 2) NOT NULL, 
               CONTA_CONTABIL               VARCHAR(20) COLLATE DATABASE_DEFAULT NULL, 
               DESCONTO_ITEM                NUMERIC(14, 2) NULL, 
               DESCRICAO_ITEM               VARCHAR(80) NULL, 
               FAIXA                        VARCHAR(1) COLLATE DATABASE_DEFAULT NOT NULL, 
               ID_EXCECAO_IMPOSTO           INT NULL, 
               INDICADOR_CFOP               TINYINT NOT NULL, 
               ITEM_IMPRESSAO               CHAR(4) COLLATE DATABASE_DEFAULT NOT NULL, 
               NF_ENTRADA                   CHAR(15) COLLATE DATABASE_DEFAULT NOT NULL, 
               NOME_CLIFOR                  VARCHAR(25) COLLATE DATABASE_DEFAULT NOT NULL, 
               PESO                         NUMERIC(7, 3) NULL, 
               PORCENTAGEM_ITEM_RATEIO      NUMERIC(8, 5) NULL, 
               PRECO_UNITARIO               NUMERIC(15, 5) NULL, 
               QTDE_DEVOLVIDA               NUMERIC(2, 2) NOT NULL, 
               QTDE_ITEM                    NUMERIC(9, 3) NULL, 
               QTDE_RETORNAR_BENEFICIAMENTO NUMERIC(2, 2) NOT NULL, 
               SERIE_NF_ENTRADA             VARCHAR(6) COLLATE DATABASE_DEFAULT NOT NULL, 
               SUB_ITEM_TAMANHO             INT NOT NULL, 
               TRIBUT_ICMS                  CHAR(3) COLLATE DATABASE_DEFAULT NOT NULL, 
               TRIBUT_ORIGEM                CHAR(3) COLLATE DATABASE_DEFAULT NULL, 
               UNIDADE                      VARCHAR(5) COLLATE DATABASE_DEFAULT NULL, 
               VALOR_ITEM                   NUMERIC(14, 2) NULL, 
               REFERENCIA                   VARCHAR(50) COLLATE DATABASE_DEFAULT NULL, 
               REFERENCIA_ITEM              VARCHAR(12) COLLATE DATABASE_DEFAULT NULL, 
               REFERENCIA_PEDIDO            VARCHAR(12) COLLATE DATABASE_DEFAULT NULL, 
               DIVERGENTE                   INT NOT NULL, 
               TIMESTAMP                    INT NULL, 
               REFERENCIA_ENTREGA_PEDIDO    INT NULL, 
               VALOR_ENCARGOS               NUMERIC(16, 2) NOT NULL, 
               VALOR_DESCONTOS              NUMERIC(16, 2) NOT NULL, 
               NAO_SOMA_VALOR               BIT NOT NULL, 
               VALOR_ENCARGOS_IMPORTACAO    INT NOT NULL, 
               RATEIO_FILIAL                CHAR(6) COLLATE DATABASE_DEFAULT NULL, 
               RATEIO_CENTRO_CUSTO          VARCHAR(15) COLLATE DATABASE_DEFAULT NULL 
            ); 

          INSERT INTO #LOJA_NOTA_FISCAL_ITEM_PERIODO 
                      (ID, 
                       CLASSIF_FISCAL, 
                       CODIGO_FISCAL_OPERACAO, 
                       CODIGO_ITEM, 
                       ORIGEM_ITEM, 
                       COD_TABELA_FILHA, 
                       COMISSAO_ITEM, 
                       COMISSAO_ITEM_GERENTE, 
                       CONTA_CONTABIL, 
                       DESCONTO_ITEM, 
                       DESCRICAO_ITEM, 
                       FAIXA, 
                       ID_EXCECAO_IMPOSTO, 
                       INDICADOR_CFOP, 
                       ITEM_IMPRESSAO, 
                       NF_ENTRADA, 
                       NOME_CLIFOR, 
                       PESO, 
                       PORCENTAGEM_ITEM_RATEIO, 
                       PRECO_UNITARIO, 
                       QTDE_DEVOLVIDA, 
                       QTDE_ITEM, 
                       QTDE_RETORNAR_BENEFICIAMENTO, 
                       SERIE_NF_ENTRADA, 
                       SUB_ITEM_TAMANHO, 
                       TRIBUT_ICMS, 
                       TRIBUT_ORIGEM, 
                       UNIDADE, 
                       VALOR_ITEM, 
                       REFERENCIA, 
                       REFERENCIA_ITEM, 
                       REFERENCIA_PEDIDO, 
                       DIVERGENTE, 
                       TIMESTAMP, 
                       REFERENCIA_ENTREGA_PEDIDO, 
                       VALOR_ENCARGOS, 
                       VALOR_DESCONTOS, 
                       NAO_SOMA_VALOR, 
                       VALOR_ENCARGOS_IMPORTACAO, 
                       RATEIO_FILIAL, 
                       RATEIO_CENTRO_CUSTO) 
          SELECT ROW_NUMBER() 
                   OVER( 
                     ORDER BY LI.NF_NUMERO, LI.SERIE_NF, LI.ITEM_IMPRESSAO, CLIFOR.COD_CLIFOR) AS ID,
                 CLASSIF_FISCAL = LI.CLASSIF_FISCAL, 
                 CODIGO_FISCAL_OPERACAO = CASE 
                                            WHEN CTBI.CFOP_OBRIGATORIO IS NOT NULL THEN CTBI.CFOP_OBRIGATORIO
                                            ELSE 
                                              CASE 
                                                WHEN CLIFOR.PAIS <> F.PAIS THEN CTBC.CODIGO_FISCAL_EXTERIOR
                                                WHEN CLIFOR.UF <> F.UF THEN CTBC.CODIGO_FISCAL_INTERESTADUAL
                                                ELSE CTBC.CODIGO_FISCAL_OPERACAO 
                                              END 
                                          END, 
                 CODIGO_ITEM = LI.CODIGO_ITEM, 
                 ORIGEM_ITEM = LI.ORIGEM_ITEM,--#14#  
                 COD_TABELA_FILHA = 'P', 
                 COMISSAO_ITEM = 0.00, 
                 COMISSAO_ITEM_GERENTE = 0.00, 
                 CONTA_CONTABIL = ISNULL(DBO.FX_CONTA_CONTABIL_OPERACAO_INVERSA(LI.REFERENCIA, NS.TIPO_OPERACAO, 'E', 'P'), LI.CONTA_CONTABIL),
                 DESCONTO_ITEM = LI.DESCONTO_ITEM, 
                 DESCRICAO_ITEM = LI.DESCRICAO_ITEM, 
                 FAIXA = '', 
                 ID_EXCECAO_IMPOSTO = DBO.FX_ID_EXCECAO_IMPOSTO(CTBO.CTB_TIPO_OPERACAO, F.COD_CLIFOR, ISNULL(DBO.FX_INDICADOR_CFOP(CLIFOR.NOME_CLIFOR, LI.REFERENCIA, 'P'), LI.INDICADOR_CFOP), 'E', ISNULL(CLIFOR.NOME_CLIFOR, NULL), /*#33# INCLUSÃO DA MATRIZ FISCAL*/ --#44#
                                      /*@FILIAL_FILTRO, /*#31#*/ */
                                      CLIFOR.NOME_CLIFOR, LP.EMISSAO, LI.TRIBUT_ORIGEM, CASE 
                                                                                          WHEN CLIFOR.PAIS <> F.PAIS THEN CTBC.CODIGO_FISCAL_EXTERIOR
                                                                                          WHEN CLIFOR.UF <> F.UF THEN CTBC.CODIGO_FISCAL_INTERESTADUAL
                                                                                          ELSE CTBC.CODIGO_FISCAL_OPERACAO
                                                                                        END, LI.REFERENCIA, F.NOME_CLIFOR, CASE
                                                                                                                             WHEN 'P' = 'R' THEN 'P'
                                                                                                                             ELSE
                                                                                                                               CASE
                                                                                                                                 WHEN 'P' = 'T' THEN 'M'
                                                                                                                                 ELSE 'P'
                                                                                                                               END
                                                                                                                           END, NS.NATUREZA_ENTRADA_AUTOMATICA, CLIFOR.COD_CLIFOR),
                 INDICADOR_CFOP = ISNULL(DBO.FX_INDICADOR_CFOP(CLIFOR.NOME_CLIFOR, LI.REFERENCIA, 'P'), LI.INDICADOR_CFOP),
                 ITEM_IMPRESSAO = LI.ITEM_IMPRESSAO, 
                 NF_ENTRADA = LI.NF_NUMERO, 
                 NOME_CLIFOR = F.NOME_CLIFOR, 
                 PESO = LI.PESO, 
                 PORCENTAGEM_ITEM_RATEIO = LI.PORCENTAGEM_ITEM_RATEIO, 
                 PRECO_UNITARIO = LI.PRECO_UNITARIO, 
                 QTDE_DEVOLVIDA = 0.00, 
                 QTDE_ITEM = LI.QTDE_ITEM, 
                 QTDE_RETORNAR_BENEFICIAMENTO = 0.00, 
                 SERIE_NF_ENTRADA = LI.SERIE_NF, 
                 SUB_ITEM_TAMANHO = LI.SUB_ITEM_TAMANHO, 
                 TRIBUT_ICMS = COALESCE(CTBI.TRIBUT_ICMS, LI.TRIBUT_ICMS), /*#38#*/
                 TRIBUT_ORIGEM = COALESCE(CTBI.TRIBUT_ORIGEM, LI.TRIBUT_ORIGEM),	/*#38#*/
                 UNIDADE = LI.UNIDADE, 
                 VALOR_ITEM = LI.VALOR_ITEM, 
                 REFERENCIA = LI.REFERENCIA, 
                 REFERENCIA_ITEM = LI.REFERENCIA_ITEM, 
                 REFERENCIA_PEDIDO = LI.REFERENCIA_PEDIDO, 
                 DIVERGENTE = 0, 
                 TIMESTAMP = NULL, 
                 REFERENCIA_ENTREGA_PEDIDO = NULL, 
                 VALOR_ENCARGOS = LI.VALOR_ENCARGOS, 
                 VALOR_DESCONTOS = LI.VALOR_DESCONTOS, 
                 NAO_SOMA_VALOR = LI.NAO_SOMA_VALOR, 
                 VALOR_ENCARGOS_IMPORTACAO = 0, 
                 RATEIO_FILIAL = CLIFOR.COD_CLIFOR, 
                 RATEIO_CENTRO_CUSTO = @RATEIO_CENTRO_CUSTO_PADRAO 
          --INTO   #LOJA_NOTA_FISCAL_ITEM_PERIODO  
          FROM   #LOJA_NOTA_FISCAL_PERIODO AS LP 
                 JOIN LOJAS_NATUREZA_OPERACAO AS LNO(NOLOCK) 
                   ON LP.NATUREZA_OPERACAO_CODIGO = LNO.NATUREZA_OPERACAO_CODIGO 
                 JOIN NATUREZAS_SAIDAS AS NS(NOLOCK) 
                   ON LNO.NATUREZA_SAIDA = NS.NATUREZA_SAIDA 
                 JOIN LOJA_NOTA_FISCAL_ITEM AS LI(NOLOCK) 
                   ON LP.CODIGO_FILIAL = LI.CODIGO_FILIAL 
                      AND LP.NF_NUMERO = LI.NF_NUMERO 
                      AND LP.SERIE_NF = LI.SERIE_NF 
                 JOIN CADASTRO_CLI_FOR AS CLIFOR(NOLOCK) 
                   ON LP.COD_CLIFOR = CLIFOR.COD_CLIFOR 
                 JOIN LOJAS_VAREJO AS LV(NOLOCK) 
                   ON LV.CODIGO_FILIAL = LP.CODIGO_FILIAL 
                 JOIN FILIAIS 
                   ON LV.FILIAL = FILIAIS.FILIAL /*#33# INCLUSÃO DA FILIAL PARA BUSCAR A MATRIZ FISCAL */
                 JOIN CADASTRO_CLI_FOR AS F(NOLOCK) 
                   ON LV.FILIAL = F.NOME_CLIFOR 
                 JOIN NATUREZAS_ENTRADAS AS NE(NOLOCK) 
                   ON NS.NATUREZA_ENTRADA_AUTOMATICA = NE.NATUREZA 
                 JOIN CTB_LX_TIPO_OPERACAO AS CTBO(NOLOCK) 
                   ON CTBO.CTB_TIPO_OPERACAO = NE.CTB_TIPO_OPERACAO 
                 JOIN CTB_LX_CARACTERISTICA_CFOP AS CTBC(NOLOCK) 
                   ON CTBC.CTB_TIPO_OPERACAO = CTBO.CTB_TIPO_OPERACAO 
                      AND CTBC.INDICADOR_FISCAL_TERCEIRO = F.INDICADOR_FISCAL_TERCEIRO 
                      AND CTBC.INDICADOR_CFOP = ISNULL(DBO.FX_INDICADOR_CFOP(CLIFOR.NOME_CLIFOR, LI.REFERENCIA, 'P'), LI.INDICADOR_CFOP)
                 LEFT JOIN CTB_EXCECAO_IMPOSTO AS CTBI(NOLOCK) 
                        ON CTBI.ID_EXCECAO_IMPOSTO = DBO.FX_ID_EXCECAO_IMPOSTO(CTBO.CTB_TIPO_OPERACAO, F.COD_CLIFOR, ISNULL(DBO.FX_INDICADOR_CFOP(CLIFOR.NOME_CLIFOR, LI.REFERENCIA, 'P'), LI.INDICADOR_CFOP), 'E', ISNULL(CLIFOR.NOME_CLIFOR, NULL), /*#33# INCLUSÃO DA MATRIZ FISCAL*/ --#41#
                                                     /*@FILIAL_FILTRO, /*#31#*/ */
                                                     CLIFOR.NOME_CLIFOR, LP.EMISSAO, LI.TRIBUT_ORIGEM, CASE
                                                                                                         WHEN CLIFOR.PAIS <> F.PAIS THEN CTBC.CODIGO_FISCAL_EXTERIOR
                                                                                                         WHEN CLIFOR.UF <> F.UF THEN CTBC.CODIGO_FISCAL_INTERESTADUAL
                                                                                                         ELSE CTBC.CODIGO_FISCAL_OPERACAO
                                                                                                       END, LI.REFERENCIA, F.NOME_CLIFOR, CASE
                                                                                                                                            WHEN 'P' = 'R' THEN 'P'
                                                                                                                                            ELSE
                                                                                                                                              CASE
                                                                                                                                                WHEN 'P' = 'T' THEN 'M'
                                                                                                                                                ELSE 'P'
                                                                                                                                              END
                                                                                                                                          END, NS.NATUREZA_ENTRADA_AUTOMATICA, CLIFOR.COD_CLIFOR);

          SET @ROWSLOJAENTITEM = @@ROWCOUNT; --> Crispim 

          --SELECT * INTO ##LOJA_NOTA_FISCAL_ITEM_PERIODO FROM #LOJA_NOTA_FISCAL_ITEM_PERIODO
          -- FIM - TABELA TEMP DE ENTRADAS_ITEM (LOJA_NOTA_FISCAL_ITEM SEM VERIFICAR LOJA_ENTRADAS)    
          -----------------------------------------------------------------------------------------------------------------------------------------------    
          -- INSERÇÃO NAS TABELAS FÍSICAS (ENTRADAS E ENTRADAS_ITEM SEM VERIFICAR LOJA_ENTRADAS)    
          INSERT INTO ENTRADAS 
                      (NOME_CLIFOR, 
                       NF_ENTRADA, 
                       SERIE_NF_ENTRADA, 
                       TABELA_FILHA, 
                       FILIAL, 
                       EMISSAO, 
                       RECEBIMENTO, 
                       QTDE_TOTAL, 
                       VALOR_TOTAL, 
                       FRETE, 
                       SEGURO, 
                       DESCONTO, 
                       ENCARGO, 
                       ICMS_VALOR, 
                       IPI_VALOR, 
                       ICMS_BASE, 
                       NATUREZA, 
                       ACERTO_CONTAS_P_R, 
                       CONDICAO_PGTO, 
                       COD_TRANSACAO, 
                       NF_FATURA, 
                       DEVOLUCAO, 
                       NF_PROPRIA_EMITIDA, 
                       TRANSF_FILIAL, 
                       NF_ENTRADA_PROPRIA, 
                       FRETE_A_PAGAR, 
                       IMPORTACAO, 
                       MOEDA, 
                       VALOR_IMPOSTO_AGREGAR, 
                       RATEIO_FILIAL, 
                       ESPECIE_SERIE, 
                       RATEIO_CENTRO_CUSTO, 
                       TIPO_ENTRADAS, 
                       COD_CLIFOR_SACADO, 
                       VALOR_SUB_ITENS, 
                       CHAVE_NFE, 
                       PROTOCOLO_AUTORIZACAO_NFE, 
                       DATA_AUTORIZACAO_NFE, 
                       DATA_DIGITACAO, 
                       FIN_EMISSAO_NFE,--#5#   
                       TIPO_EMISSAO_NFE,/*--#5# */ 
                       STATUS_NFE,/*--#5# */ 
                       TRANSPORTADORA_A_PAGAR, 
                       EMPRESA,/*#22#*/ 
                       OBS, 
                       OBS_INTERESSE_FISCO,/*#28#*/ 
                       INFORMACAO_COMPLEMENTAR /*#29#*/ 
          ) --#7#  
          SELECT NOME_CLIFOR, 
                 NF_ENTRADA, 
                 SERIE_NF_ENTRADA, 
                 TABELA_FILHA, 
                 FILIAL, 
                 EMISSAO, 
                 RECEBIMENTO, 
                 QTDE_TOTAL, 
                 VALOR_TOTAL, 
                 FRETE, 
                 SEGURO, 
                 DESCONTO, 
                 ENCARGO, 
                 ICMS_VALOR, 
                 IPI_VALOR, 
                 ICMS_BASE, 
                 NATUREZA, 
                 ACERTO_CONTAS_P_R, 
                 CONDICAO_PGTO, 
                 COD_TRANSACAO, 
                 NF_FATURA, 
                 DEVOLUCAO, 
                 NF_PROPRIA_EMITIDA, 
                 TRANSF_FILIAL, 
                 NF_ENTRADA_PROPRIA, 
                 FRETE_A_PAGAR, 
                 IMPORTACAO, 
                 MOEDA, 
                 VALOR_IMPOSTO_AGREGAR, 
                 RATEIO_FILIAL, 
                 ESPECIE_SERIE, 
                 RATEIO_CENTRO_CUSTO, 
                 TIPO_ENTRADAS, 
                 COD_CLIFOR_SACADO, 
                 VALOR_SUB_ITENS, 
                 CHAVE_NFE, 
                 PROTOCOLO_AUTORIZACAO_NFE, 
                 DATA_AUTORIZACAO_NFE, 
                 DATA_DIGITACAO, 
                 FIN_EMISSAO_NFE,/*--#5# */ 
                 TIPO_EMISSAO_NFE,/*--#5# */ 
                 STATUS_NFE,/*--#5# */ 
                 TRANSPORTADORA,/*--#7#*/ 
                 @EMPRESA,/*#22#*/ 
                 OBS, 
                 OBS_INTERESSE_FISCO,/*#28#*/ 
                 INFORMACAO_COMPLEMENTAR /*#29#*/ 
          FROM   #LOJA_NOTA_FISCAL_PERIODO;

          --> #21#  Inclusão registros em lote para minimizar escalonamento de bloqueios. 
          -->        Definição de contexto para evitar multiplas validações desnecessárias em triggers. 
          SET @CONTEXT = 0x53454D5F46494C415F45544C; --0x4C585F474552415F5452414E53464552454E434941535F504552494F444F  
          SET CONTEXT_INFO @CONTEXT; 
          --> Crispim 
          SET @COUNT = 1; 

          WHILE @COUNT <= @ROWSLOJAENTITEM 
            BEGIN 
                --> Ponto de Atenção ! 
                INSERT INTO ENTRADAS_ITEM 
                            (CLASSIF_FISCAL, 
                             CODIGO_FISCAL_OPERACAO, 
                             CODIGO_ITEM, 
                             ORIGEM_ITEM,/*--#14# */ 
                             COD_TABELA_FILHA, 
                             COMISSAO_ITEM, 
                             COMISSAO_ITEM_GERENTE, 
                             CONTA_CONTABIL, 
                             DESCONTO_ITEM, 
                             DESCRICAO_ITEM, 
                             FAIXA, 
                             ID_EXCECAO_IMPOSTO, 
                             INDICADOR_CFOP, 
                             ITEM_IMPRESSAO, 
                             NF_ENTRADA, 
                             NOME_CLIFOR, 
                             PESO, 
                             PORCENTAGEM_ITEM_RATEIO, 
                             PRECO_UNITARIO, 
                             QTDE_DEVOLVIDA, 
                             QTDE_ITEM, 
                             QTDE_RETORNAR_BENEFICIAMENTO, 
                             SERIE_NF_ENTRADA, 
                             SUB_ITEM_TAMANHO, 
                             TRIBUT_ICMS, 
                             TRIBUT_ORIGEM, 
                             UNIDADE, 
                             VALOR_ITEM, 
                             REFERENCIA, 
                             REFERENCIA_ITEM, 
                             REFERENCIA_PEDIDO, 
                             DIVERGENTE, 
                             TIMESTAMP, 
                             REFERENCIA_ENTREGA_PEDIDO, 
                             VALOR_ENCARGOS, 
                             VALOR_DESCONTOS, 
                             NAO_SOMA_VALOR, 
                             VALOR_ENCARGOS_IMPORTACAO, 
                             RATEIO_FILIAL, 
                             RATEIO_CENTRO_CUSTO) 
                SELECT CLASSIF_FISCAL, 
                       CODIGO_FISCAL_OPERACAO, 
                       CODIGO_ITEM, 
                       ORIGEM_ITEM,/*--#14# */ 
                       COD_TABELA_FILHA, 
                       COMISSAO_ITEM, 
                       COMISSAO_ITEM_GERENTE, 
                       CONTA_CONTABIL, 
                       DESCONTO_ITEM, 
                       DESCRICAO_ITEM, 
                       FAIXA, 
                       ID_EXCECAO_IMPOSTO, 
                       INDICADOR_CFOP, 
                       ITEM_IMPRESSAO, 
                       NF_ENTRADA, 
                       NOME_CLIFOR, 
                       PESO, 
                       PORCENTAGEM_ITEM_RATEIO, 
                       PRECO_UNITARIO, 
                       QTDE_DEVOLVIDA, 
                       QTDE_ITEM, 
                       QTDE_RETORNAR_BENEFICIAMENTO, 
                       SERIE_NF_ENTRADA, 
                       SUB_ITEM_TAMANHO, 
                       TRIBUT_ICMS, 
                       TRIBUT_ORIGEM, 
                       UNIDADE, 
                       VALOR_ITEM, 
                       REFERENCIA, 
                       REFERENCIA_ITEM, 
                       REFERENCIA_PEDIDO, 
                       DIVERGENTE, 
                       TIMESTAMP, 
                       REFERENCIA_ENTREGA_PEDIDO, 
                       VALOR_ENCARGOS, 
                       VALOR_DESCONTOS, 
                       NAO_SOMA_VALOR, 
                       VALOR_ENCARGOS_IMPORTACAO, 
                       RATEIO_FILIAL, 
                       RATEIO_CENTRO_CUSTO 
                FROM   #LOJA_NOTA_FISCAL_ITEM_PERIODO 
                WHERE  ID >= @COUNT 
                       AND ID <= @COUNT + 1999;	/*#37#*/

                SET @COUNT+=2000;	/*#37#*/

				/**#34#**/
				UPDATE	ENTRADA
				SET		ENTRADA.NF_ENTRADA = TEMP.NF_ENTRADA,
						ENTRADA.SERIE_NF_ENTRADA = TEMP.SERIE_NF_ENTRADA,
						ENTRADA.NOME_CLIFOR = TEMP.NOME_CLIFOR,
						ENTRADA.RATEIO_FILIAL = TEMP.RATEIO_FILIAL,
						ENTRADA.RATEIO_CENTRO_CUSTO = TEMP.RATEIO_CENTRO_CUSTO,
						ENTRADA.ITEM_IMPRESSAO = TEMP.ITEM_IMPRESSAO,
						ENTRADA.SUB_ITEM_TAMANHO = TEMP.SUB_ITEM_TAMANHO
				FROM		AF_LOCAL_ENTRADA AS ENTRADA
				JOIN		AF_LOCAL_SAIDA AS SAIDA
				ON		ENTRADA.ID_LOCAL_IMOBILIZADO = SAIDA.ID_LOCAL_IMOBILIZADO
						AND ENTRADA.EMPRESA = SAIDA.EMPRESA
				JOIN		#LOJA_NOTA_FISCAL_ITEM_PERIODO AS TEMP
				ON		SAIDA.NF_SAIDA = TEMP.NF_ENTRADA
						AND SAIDA.SERIE_NF = TEMP.SERIE_NF_ENTRADA
						AND SAIDA.FILIAL = TEMP.NOME_CLIFOR
						AND SAIDA.ITEM_IMPRESSAO = TEMP.ITEM_IMPRESSAO
						AND SAIDA.SUB_ITEM_TAMANHO = TEMP.SUB_ITEM_TAMANHO
				WHERE    ENTRADA.NF_ENTRADA IS NULL 
						 AND ENTRADA.SERIE_NF_ENTRADA IS NULL 
						 AND ENTRADA.NOME_CLIFOR IS NULL
						 AND ENTRADA.ITEM_IMPRESSAO IS NULL
						 AND ENTRADA.SUB_ITEM_TAMANHO IS NULL;
						 /**#34#**/
            END; 

          SET CONTEXT_INFO 0x; 
      -- FIM - INSERÇÃO NAS TABELAS FÍSICAS (ENTRADAS E ENTRADAS_ITEM SEM VERIFICAR LOJA_ENTRADAS)  
      -----------------------------------------------------------------------------------------------------------------------------------------------    
      END; 
    ELSE 
      BEGIN 
          -----------------------------------------------------------------------------------------------------------------------------------------------    
          -- TABELA TEMP DE ENTRADAS (LOJA_NOTA_FISCAL VERIFICANDO LOJA_ENTRADAS)    
          SELECT NOME_CLIFOR = F2.FILIAL, 
                 NF_ENTRADA = LP.NF_NUMERO, 
                 SERIE_NF_ENTRADA = LP.SERIE_NF, 
                 TABELA_FILHA = 'FAT_IMAGEM', 
                 FILIAL = CLIFOR.NOME_CLIFOR, 
                 EMISSAO = LP.EMISSAO,/*#2#*/ 
                 --#16#RECEBIMENTO = LP.DATA_RECEBIMENTO,/*#12#*/  
                 --#24#RECEBIMENTO = (ISNULL(CASE WHEN LE.EMISSAO <= LP.DATA_RECEBIMENTO THEN LP.DATA_RECEBIMENTO ELSE LE.EMISSAO END, LP.DATA_RECEBIMENTO)), --#16# 
                 RECEBIMENTO = Cast(CONVERT(CHAR(8), ISNULL(CASE 
                                                              WHEN LE.EMISSAO <= LP.DATA_RECEBIMENTO THEN LP.DATA_RECEBIMENTO
                                                              ELSE LE.EMISSAO 
                                                            END, LP.DATA_RECEBIMENTO), 112) AS DATETIME),/*#24#*/
                 QTDE_TOTAL = LP.QTDE_TOTAL, 
                 VALOR_TOTAL = LP.VALOR_TOTAL, 
                 FRETE = LP.FRETE, 
                 SEGURO = LP.SEGURO, 
                 DESCONTO = LP.DESCONTO, 
                 ENCARGO = LP.ENCARGO, 
                 ICMS_VALOR = 0.00, 
                 IPI_VALOR = 0.00, 
                 ICMS_BASE = 0.00, 
                 NATUREZA = NE.NATUREZA, 
                 ACERTO_CONTAS_P_R = 0, 
                 CONDICAO_PGTO = (SELECT Max(CONDICAO_PGTO) 
                                  FROM   COND_ENT_PGTOS(NOLOCK) 
                                  WHERE  TIPO_CONDICAO = 'VISTA'), 
                 COD_TRANSACAO = 'ENTRADAS_109', 
                 NF_FATURA = 0, 
                 DEVOLUCAO = 0, 
                 NF_PROPRIA_EMITIDA = 0,/*#19# #23#*/ 
                 TRANSF_FILIAL = 1, 
                 NF_ENTRADA_PROPRIA = 0,/*#19# #23#*/ 
                 FRETE_A_PAGAR = LP.FRETE, 
                 IMPORTACAO = 0, 
                 MOEDA = @MOEDA_PADRAO, 
                 VALOR_IMPOSTO_AGREGAR = LP.VALOR_IMPOSTO_AGREGAR, 
                 RATEIO_FILIAL = LP.COD_CLIFOR, 
                 ESPECIE_SERIE = ISNULL((SELECT SERIES_NF.ESPECIE_SERIE 
                                         FROM   SERIES_NF(NOLOCK) 
                                         WHERE  SERIES_NF.SERIE_NF = LP.SERIE_NF), @ESPECIE_SERIE),
                 RATEIO_CENTRO_CUSTO = @RATEIO_CENTRO_CUSTO_PADRAO, 
                 TIPO_ENTRADAS = @TIPO_ENTRADAS_PADRAO, 
                 COD_CLIFOR_SACADO = F.COD_FILIAL, 
                 VALOR_SUB_ITENS = LP.VALOR_TOTAL_ITENS, 
                 CHAVE_NFE = LP.CHAVE_NFE, 
                 PROTOCOLO_AUTORIZACAO_NFE = LP.PROTOCOLO_AUTORIZACAO_NFE, 
                 DATA_AUTORIZACAO_NFE = LP.DATA_AUTORIZACAO_NFE, 
                 DATA_DIGITACAO = Cast(CONVERT(CHAR(8), Getdate(), 112) AS DATETIME), 
                 FIN_EMISSAO_NFE = LP.FIN_EMISSAO_NFE,--#5#  
                 TIPO_EMISSAO_NFE = LP.TIPO_EMISSAO_NFE,--#5#  
                 STATUS_NFE = LP.STATUS_NFE,--#5#  
                 TRANSPORTADORA = LP.TRANSPORTADORA,-- #8#  
                 LP.OBS,/*#28#*/ 
                 LP.OBS_INTERESSE_FISCO,/*#28#*/ 
                 LP.INFORMACAO_COMPLEMENTAR /*#29#*/ 
          INTO   #LOJA_NOTA_FISCAL_PERIODO_1 
          FROM   #LOJA_NOTA_FISCAL AS LP 
                 JOIN LOJAS_NATUREZA_OPERACAO AS LNO(NOLOCK) 
                   ON LP.NATUREZA_OPERACAO_CODIGO = LNO.NATUREZA_OPERACAO_CODIGO 
                 JOIN FILIAIS AS F(NOLOCK) 
                   ON LP.COD_CLIFOR = F.COD_FILIAL 
                 JOIN CADASTRO_CLI_FOR AS CLIFOR(NOLOCK) 
                   ON LP.COD_CLIFOR = CLIFOR.COD_CLIFOR 
                 JOIN NATUREZAS_SAIDAS AS NS(NOLOCK) 
                   ON LNO.NATUREZA_SAIDA = NS.NATUREZA_SAIDA 
                 JOIN NATUREZAS_ENTRADAS AS NE(NOLOCK) 
                   ON NS.NATUREZA_ENTRADA_AUTOMATICA = NE.NATUREZA 
                 LEFT JOIN LOJAS_VAREJO AS LV(NOLOCK) 
                        ON LV.CODIGO_FILIAL = LP.CODIGO_FILIAL 
                 LEFT JOIN FILIAIS AS F2 
                        ON LV.FILIAL = F2.FILIAL 
                 LEFT JOIN (SELECT FILIAL_ORIGEM,-- #3# #4#  
                                   NUMERO_NF_TRANSFERENCIA, 
                                   SERIE_NF_ENTRADA, 
                                   Max(EMISSAO)                                                          AS EMISSAO,
                                   Max(Cast(ISNULL(LOJA_ENTRADAS.ENTRADA_CONFERIDA, 0 /*#32#*/) AS INT)) AS ENTRADA_CONFERIDA
                            FROM   LOJA_ENTRADAS(NOLOCK) 
                            GROUP  BY FILIAL_ORIGEM, 
                                      NUMERO_NF_TRANSFERENCIA, 
                                      SERIE_NF_ENTRADA) AS LE 
                        ON F2.FILIAL = LE.FILIAL_ORIGEM 
                           AND LP.NF_NUMERO = LE.NUMERO_NF_TRANSFERENCIA 
                           AND LP.SERIE_NF = LE.SERIE_NF_ENTRADA 
          WHERE  ( ISNULL(LE.ENTRADA_CONFERIDA, 0) = 1 
                   AND LP.INDICA_TRANSFERENCIA_PARA_LOJA = 1 ) 
                  OR LP.INDICA_TRANSFERENCIA_PARA_LOJA = 0 /*#32#*/; 

          -- FIM - TABELA TEMP DE ENTRADAS (LOJA_NOTA_FISCAL VERIFICANDO LOJA_ENTRADAS)    
          -----------------------------------------------------------------------------------------------------------------------------------------------    
          -- TABELA TEMP DE ENTRADAS_ITEM (LOJA_NOTA_FISCAL_ITEM VERIFICANDO LOJA_ENTRADAS)  
          --> #21#  Criação explícita da tabela temporária ao invés de criá-la através da instrução SELECT INTO. 
          -->        Inclusão de coluna sequencial (row_number) para controlar a inclusão/alteração de registros em lote.
          SET @ROWSLOJAENTITEM = 0; 

          CREATE TABLE #LOJA_NOTA_FISCAL_ITEM_PERIODO_1 
            ( 
               ID                           BIGINT NOT NULL PRIMARY KEY, 
               CLASSIF_FISCAL               CHAR(10) COLLATE DATABASE_DEFAULT NOT NULL, 
               CODIGO_FISCAL_OPERACAO       CHAR(4) COLLATE DATABASE_DEFAULT NULL, 
               CODIGO_ITEM                  VARCHAR(50) COLLATE DATABASE_DEFAULT NOT NULL, 
               ORIGEM_ITEM                  CHAR(1) NOT NULL, 
               COD_TABELA_FILHA             CHAR(1) COLLATE DATABASE_DEFAULT NOT NULL, 
               COMISSAO_ITEM                NUMERIC(2, 2) NOT NULL, 
               COMISSAO_ITEM_GERENTE        NUMERIC(2, 2) NOT NULL, 
               CONTA_CONTABIL               VARCHAR(20) COLLATE DATABASE_DEFAULT NULL, 
               DESCONTO_ITEM                NUMERIC(14, 2) NULL, 
               DESCRICAO_ITEM               VARCHAR(80) NULL, 
               FAIXA                        VARCHAR(1) COLLATE DATABASE_DEFAULT NOT NULL, 
               ID_EXCECAO_IMPOSTO           INT NULL, 
               INDICADOR_CFOP               TINYINT NOT NULL, 
               ITEM_IMPRESSAO               CHAR(4) COLLATE DATABASE_DEFAULT NOT NULL, 
               NF_ENTRADA                   CHAR(15) COLLATE DATABASE_DEFAULT NOT NULL, 
               NOME_CLIFOR                  VARCHAR(25) COLLATE DATABASE_DEFAULT NOT NULL, 
               PESO                         NUMERIC(7, 3) NULL, 
               PORCENTAGEM_ITEM_RATEIO      NUMERIC(8, 5) NULL, 
               PRECO_UNITARIO               NUMERIC(15, 5) NULL, 
               QTDE_DEVOLVIDA               NUMERIC(2, 2) NOT NULL, 
               QTDE_ITEM                    NUMERIC(9, 3) NULL, 
               QTDE_RETORNAR_BENEFICIAMENTO NUMERIC(2, 2) NOT NULL, 
               SERIE_NF_ENTRADA             VARCHAR(6) COLLATE DATABASE_DEFAULT NOT NULL, 
               SUB_ITEM_TAMANHO             INT NOT NULL, 
               TRIBUT_ICMS                  CHAR(3) COLLATE DATABASE_DEFAULT NOT NULL, 
               TRIBUT_ORIGEM                CHAR(3) COLLATE DATABASE_DEFAULT NULL, 
               UNIDADE                      VARCHAR(5) COLLATE DATABASE_DEFAULT NULL, 
               VALOR_ITEM                   NUMERIC(14, 2) NULL, 
               REFERENCIA                   VARCHAR(50) COLLATE DATABASE_DEFAULT NULL, 
               REFERENCIA_ITEM              VARCHAR(12) COLLATE DATABASE_DEFAULT NULL, 
               REFERENCIA_PEDIDO            VARCHAR(12) COLLATE DATABASE_DEFAULT NULL, 
               DIVERGENTE                   INT NOT NULL, 
               TIMESTAMP                    INT NULL, 
               REFERENCIA_ENTREGA_PEDIDO    INT NULL, 
               VALOR_ENCARGOS               NUMERIC(16, 2) NOT NULL, 
               VALOR_DESCONTOS              NUMERIC(16, 2) NOT NULL, 
               NAO_SOMA_VALOR               BIT NOT NULL, 
               VALOR_ENCARGOS_IMPORTACAO    INT NOT NULL, 
               RATEIO_FILIAL                CHAR(6) COLLATE DATABASE_DEFAULT NULL, 
               RATEIO_CENTRO_CUSTO          VARCHAR(15) COLLATE DATABASE_DEFAULT NULL 
            ); 

          INSERT INTO #LOJA_NOTA_FISCAL_ITEM_PERIODO_1 
                      (ID, 
                       CLASSIF_FISCAL, 
                       CODIGO_FISCAL_OPERACAO, 
                       CODIGO_ITEM, 
                       ORIGEM_ITEM, 
                       COD_TABELA_FILHA, 
                       COMISSAO_ITEM, 
                       COMISSAO_ITEM_GERENTE, 
                       CONTA_CONTABIL, 
                       DESCONTO_ITEM, 
                       DESCRICAO_ITEM, 
                       FAIXA, 
                       ID_EXCECAO_IMPOSTO, 
                       INDICADOR_CFOP, 
                       ITEM_IMPRESSAO, 
                       NF_ENTRADA, 
                       NOME_CLIFOR, 
                       PESO, 
                       PORCENTAGEM_ITEM_RATEIO, 
                       PRECO_UNITARIO, 
                       QTDE_DEVOLVIDA, 
                       QTDE_ITEM, 
                       QTDE_RETORNAR_BENEFICIAMENTO, 
                       SERIE_NF_ENTRADA, 
                       SUB_ITEM_TAMANHO, 
                       TRIBUT_ICMS, 
                       TRIBUT_ORIGEM, 
                       UNIDADE, 
                       VALOR_ITEM, 
                       REFERENCIA, 
                       REFERENCIA_ITEM, 
                       REFERENCIA_PEDIDO, 
                       DIVERGENTE, 
                       TIMESTAMP, 
                       REFERENCIA_ENTREGA_PEDIDO, 
                       VALOR_ENCARGOS, 
                       VALOR_DESCONTOS, 
                       NAO_SOMA_VALOR, 
                       VALOR_ENCARGOS_IMPORTACAO, 
                       RATEIO_FILIAL, 
                       RATEIO_CENTRO_CUSTO) 
          SELECT ROW_NUMBER() 
                   OVER( 
                     ORDER BY LI.NF_NUMERO, LI.SERIE_NF, LI.ITEM_IMPRESSAO, CLIFOR.COD_CLIFOR) AS ID,
                 CLASSIF_FISCAL = LI.CLASSIF_FISCAL, 
                 CODIGO_FISCAL_OPERACAO = CASE 
                                            WHEN CTBI.CFOP_OBRIGATORIO IS NOT NULL THEN CTBI.CFOP_OBRIGATORIO
                                            ELSE 
                                              CASE 
                                                WHEN CLIFOR.PAIS <> F.PAIS THEN CTBC.CODIGO_FISCAL_EXTERIOR
                                                WHEN CLIFOR.UF <> F.UF THEN CTBC.CODIGO_FISCAL_INTERESTADUAL
                                                ELSE CTBC.CODIGO_FISCAL_OPERACAO 
                                              END 
                                          END, 
                 CODIGO_ITEM = LI.CODIGO_ITEM, 
                 ORIGEM_ITEM = LI.ORIGEM_ITEM,--#14#  
                 COD_TABELA_FILHA = 'P', 
                 COMISSAO_ITEM = 0.00, 
                 COMISSAO_ITEM_GERENTE = 0.00, 
                 CONTA_CONTABIL = ISNULL(DBO.FX_CONTA_CONTABIL_OPERACAO_INVERSA(LI.REFERENCIA, NS.TIPO_OPERACAO, 'E', 'P'), LI.CONTA_CONTABIL),
                 DESCONTO_ITEM = LI.DESCONTO_ITEM, 
                 DESCRICAO_ITEM = LI.DESCRICAO_ITEM, 
                 FAIXA = '', 
                 ID_EXCECAO_IMPOSTO = DBO.FX_ID_EXCECAO_IMPOSTO(CTBO.CTB_TIPO_OPERACAO, F.COD_CLIFOR, ISNULL(DBO.FX_INDICADOR_CFOP(CLIFOR.NOME_CLIFOR, LI.REFERENCIA, 'P'), LI.INDICADOR_CFOP), 'E', ISNULL(CLIFOR.NOME_CLIFOR, NULL), /*#33# INCLUSÃO DA MATRIZ FISCAL*/ --#41#
                                      /*@FILIAL_FILTRO, /*#31#*/ */
                                      CLIFOR.NOME_CLIFOR, LP.EMISSAO, LI.TRIBUT_ORIGEM, CASE 
                                                                                          WHEN CLIFOR.PAIS <> F.PAIS THEN CTBC.CODIGO_FISCAL_EXTERIOR
                                                                                          WHEN CLIFOR.UF <> F.UF THEN CTBC.CODIGO_FISCAL_INTERESTADUAL
                                                                                          ELSE CTBC.CODIGO_FISCAL_OPERACAO
                                                                                        END, LI.REFERENCIA, F.NOME_CLIFOR, CASE
                                                                                                                             WHEN 'P' = 'R' THEN 'P'
                                                                                                                             ELSE
                                                                                                                               CASE
                                                                                                                                 WHEN 'P' = 'T' THEN 'M'
                                                                                                                                 ELSE 'P'
                                                                                                                               END
                                                                                                                           END, NS.NATUREZA_ENTRADA_AUTOMATICA, CLIFOR.COD_CLIFOR),
                 INDICADOR_CFOP = ISNULL(DBO.FX_INDICADOR_CFOP(CLIFOR.NOME_CLIFOR, LI.REFERENCIA, 'P'), LI.INDICADOR_CFOP),
                 ITEM_IMPRESSAO = LI.ITEM_IMPRESSAO, 
                 NF_ENTRADA = LI.NF_NUMERO, 
                 NOME_CLIFOR = F.NOME_CLIFOR, 
                 PESO = LI.PESO, 
                 PORCENTAGEM_ITEM_RATEIO = LI.PORCENTAGEM_ITEM_RATEIO, 
                 PRECO_UNITARIO = LI.PRECO_UNITARIO, 
                 QTDE_DEVOLVIDA = 0.00, 
                 QTDE_ITEM = LI.QTDE_ITEM, 
                 QTDE_RETORNAR_BENEFICIAMENTO = 0.00, 
                 SERIE_NF_ENTRADA = LI.SERIE_NF, 
                 SUB_ITEM_TAMANHO = LI.SUB_ITEM_TAMANHO, 
                 TRIBUT_ICMS = COALESCE(CTBI.TRIBUT_ICMS, LI.TRIBUT_ICMS), /*#38#*/
                 TRIBUT_ORIGEM = COALESCE(CTBI.TRIBUT_ORIGEM, LI.TRIBUT_ORIGEM),	/*#38#*/
                 UNIDADE = LI.UNIDADE, 
                 VALOR_ITEM = LI.VALOR_ITEM, 
                 REFERENCIA = LI.REFERENCIA, 
                 REFERENCIA_ITEM = LI.REFERENCIA_ITEM, 
                 REFERENCIA_PEDIDO = LI.REFERENCIA_PEDIDO, 
                 DIVERGENTE = 0, 
                 TIMESTAMP = NULL, 
                 REFERENCIA_ENTREGA_PEDIDO = NULL, 
                 VALOR_ENCARGOS = LI.VALOR_ENCARGOS, 
                 VALOR_DESCONTOS = LI.VALOR_DESCONTOS, 
                 NAO_SOMA_VALOR = LI.NAO_SOMA_VALOR, 
                 VALOR_ENCARGOS_IMPORTACAO = 0, 
                 RATEIO_FILIAL = CLIFOR.COD_CLIFOR, 
                 RATEIO_CENTRO_CUSTO = @RATEIO_CENTRO_CUSTO_PADRAO 
          --INTO   #LOJA_NOTA_FISCAL_ITEM_PERIODO_1  
          FROM   #LOJA_NOTA_FISCAL AS LP 
                 JOIN LOJAS_NATUREZA_OPERACAO AS LNO(NOLOCK) 
                   ON LP.NATUREZA_OPERACAO_CODIGO = LNO.NATUREZA_OPERACAO_CODIGO 
                 JOIN NATUREZAS_SAIDAS AS NS(NOLOCK) 
                   ON LNO.NATUREZA_SAIDA = NS.NATUREZA_SAIDA 
                 JOIN LOJA_NOTA_FISCAL_ITEM AS LI(NOLOCK) 
                   ON LP.CODIGO_FILIAL = LI.CODIGO_FILIAL 
                      AND LP.NF_NUMERO = LI.NF_NUMERO 
                      AND LP.SERIE_NF = LI.SERIE_NF 
                 JOIN CADASTRO_CLI_FOR AS CLIFOR(NOLOCK) 
                   ON LP.COD_CLIFOR = CLIFOR.COD_CLIFOR 
                 JOIN LOJAS_VAREJO AS LV(NOLOCK) 
                   ON LV.CODIGO_FILIAL = LP.CODIGO_FILIAL 
                 JOIN FILIAIS 
                   ON LV.FILIAL = FILIAIS.FILIAL /*#33# INCLUSÃO DA FILIAL PARA BUSCAR A MATRIZ FISCAL */
                 JOIN CADASTRO_CLI_FOR AS F(NOLOCK) 
                   ON LV.FILIAL = F.NOME_CLIFOR 
                 JOIN NATUREZAS_ENTRADAS AS NE(NOLOCK) 
                   ON NS.NATUREZA_ENTRADA_AUTOMATICA = NE.NATUREZA 
                 JOIN CTB_LX_TIPO_OPERACAO AS CTBO(NOLOCK) 
                   ON CTBO.CTB_TIPO_OPERACAO = NE.CTB_TIPO_OPERACAO 
                 JOIN CTB_LX_CARACTERISTICA_CFOP AS CTBC(NOLOCK) 
                   ON CTBC.CTB_TIPO_OPERACAO = CTBO.CTB_TIPO_OPERACAO 
                      AND CTBC.INDICADOR_FISCAL_TERCEIRO = F.INDICADOR_FISCAL_TERCEIRO 
                      AND CTBC.INDICADOR_CFOP = ISNULL(DBO.FX_INDICADOR_CFOP(CLIFOR.NOME_CLIFOR, LI.REFERENCIA, 'P'), LI.INDICADOR_CFOP)
                 LEFT JOIN (SELECT FILIAL_ORIGEM,-- #3# #4#  
                                   NUMERO_NF_TRANSFERENCIA, 
                                   SERIE_NF_ENTRADA, 
                                   Max(EMISSAO)                                                          AS EMISSAO,
                                   ISNULL(Max(Cast(LOJA_ENTRADAS.ENTRADA_CONFERIDA AS INT)), 0 /*#32#*/) AS ENTRADA_CONFERIDA
                            FROM   LOJA_ENTRADAS(NOLOCK) 
                            GROUP  BY FILIAL_ORIGEM, 
                                      NUMERO_NF_TRANSFERENCIA, 
                                      SERIE_NF_ENTRADA) AS LE 
                        ON F.NOME_CLIFOR = LE.FILIAL_ORIGEM 
                           AND LP.NF_NUMERO = LE.NUMERO_NF_TRANSFERENCIA 
                           AND LP.SERIE_NF = LE.SERIE_NF_ENTRADA 
                 LEFT JOIN CTB_EXCECAO_IMPOSTO AS CTBI(NOLOCK) 
                        ON CTBI.ID_EXCECAO_IMPOSTO = DBO.FX_ID_EXCECAO_IMPOSTO(CTBO.CTB_TIPO_OPERACAO, F.COD_CLIFOR, ISNULL(DBO.FX_INDICADOR_CFOP(CLIFOR.NOME_CLIFOR, LI.REFERENCIA, 'P'), LI.INDICADOR_CFOP), 'E', ISNULL(CLIFOR.NOME_CLIFOR, NULL), /*#33# INCLUSÃO DA MATRIZ FISCAL*/ --#41#
                                                     /*@FILIAL_FILTRO, /*#31#*/ */
                                                     CLIFOR.NOME_CLIFOR, LP.EMISSAO, LI.TRIBUT_ORIGEM, CASE
                                                                                                         WHEN CLIFOR.PAIS <> F.PAIS THEN CTBC.CODIGO_FISCAL_EXTERIOR
                                                                                                         WHEN CLIFOR.UF <> F.UF THEN CTBC.CODIGO_FISCAL_INTERESTADUAL
                                                                                                         ELSE CTBC.CODIGO_FISCAL_OPERACAO
                                                                                                       END, LI.REFERENCIA, F.NOME_CLIFOR, CASE
                                                                                                                                            WHEN 'P' = 'R' THEN 'P'
                                                                                                                                            ELSE
                                                                                                                                              CASE
                                                                                                                                                WHEN 'P' = 'T' THEN 'M'
                                                                                                                                                ELSE 'P'
                                                                                                                                              END
                                                                                                                                          END, NS.NATUREZA_ENTRADA_AUTOMATICA, CLIFOR.COD_CLIFOR)
          WHERE  ( ISNULL(LE.ENTRADA_CONFERIDA, 0) = 1 
                   AND LP.INDICA_TRANSFERENCIA_PARA_LOJA = 1 ) 
                  OR LP.INDICA_TRANSFERENCIA_PARA_LOJA = 0 /*#32#*/; 

          SET @ROWSLOJAENTITEM = @@ROWCOUNT; --> Crispim 
          -- FIM - TABELA TEMP DE ENTRADAS_ITEM (LOJA_NOTA_FISCAL_ITEM VERIFICANDO LOJA_ENTRADAS)    
          -----------------------------------------------------------------------------------------------------------------------------------------------    
          -- INSERÇÃO NAS TABELAS FÍSICAS (ENTRADAS E ENTRADAS_ITEM VERIFICANDO LOJA_ENTRADAS)    
          INSERT INTO ENTRADAS 
                      (NOME_CLIFOR, 
                       NF_ENTRADA, 
                       SERIE_NF_ENTRADA, 
                       TABELA_FILHA, 
                       FILIAL, 
                       EMISSAO, 
                       RECEBIMENTO, 
                       QTDE_TOTAL, 
                       VALOR_TOTAL, 
                       FRETE, 
                       SEGURO, 
                       DESCONTO, 
                       ENCARGO, 
                       ICMS_VALOR, 
                       IPI_VALOR, 
                       ICMS_BASE, 
                       NATUREZA, 
                       ACERTO_CONTAS_P_R, 
                       CONDICAO_PGTO, 
                       COD_TRANSACAO, 
                       NF_FATURA, 
                       DEVOLUCAO, 
                       NF_PROPRIA_EMITIDA, 
                       TRANSF_FILIAL, 
                       NF_ENTRADA_PROPRIA, 
                       FRETE_A_PAGAR, 
                       IMPORTACAO, 
                       MOEDA, 
                       VALOR_IMPOSTO_AGREGAR, 
                       RATEIO_FILIAL, 
                       ESPECIE_SERIE, 
                       RATEIO_CENTRO_CUSTO, 
                       TIPO_ENTRADAS, 
                       COD_CLIFOR_SACADO, 
                       VALOR_SUB_ITENS, 
                       CHAVE_NFE, 
                       PROTOCOLO_AUTORIZACAO_NFE, 
                       DATA_AUTORIZACAO_NFE, 
                       DATA_DIGITACAO, 
                       FIN_EMISSAO_NFE,/*--#5# */ 
                       TIPO_EMISSAO_NFE,/*--#5# */ 
                       STATUS_NFE,/*--#5# */ 
                       TRANSPORTADORA_A_PAGAR, 
                       EMPRESA,/*#22#*/ 
                       OBS, 
                       OBS_INTERESSE_FISCO,/*#28#*/ 
                       INFORMACAO_COMPLEMENTAR /*#29#*/ 
          ) --#8#  
          SELECT NOME_CLIFOR, 
                 NF_ENTRADA, 
                 SERIE_NF_ENTRADA, 
                 TABELA_FILHA, 
                 FILIAL, 
                 EMISSAO, 
                 RECEBIMENTO, 
                 QTDE_TOTAL, 
                 VALOR_TOTAL, 
                 FRETE, 
                 SEGURO, 
                 DESCONTO, 
                 ENCARGO, 
                 ICMS_VALOR, 
                 IPI_VALOR, 
                 ICMS_BASE, 
                 NATUREZA, 
                 ACERTO_CONTAS_P_R, 
                 CONDICAO_PGTO, 
                 COD_TRANSACAO, 
                 NF_FATURA, 
                 DEVOLUCAO, 
                 NF_PROPRIA_EMITIDA, 
                 TRANSF_FILIAL, 
                 NF_ENTRADA_PROPRIA, 
                 FRETE_A_PAGAR, 
                 IMPORTACAO, 
                 MOEDA, 
                 VALOR_IMPOSTO_AGREGAR, 
                 RATEIO_FILIAL, 
                 ESPECIE_SERIE, 
                 RATEIO_CENTRO_CUSTO, 
                 TIPO_ENTRADAS, 
                 COD_CLIFOR_SACADO, 
                 VALOR_SUB_ITENS, 
                 CHAVE_NFE, 
                 PROTOCOLO_AUTORIZACAO_NFE, 
                 DATA_AUTORIZACAO_NFE, 
                 DATA_DIGITACAO, 
                 FIN_EMISSAO_NFE,/*--#5# */ 
                 TIPO_EMISSAO_NFE,/*--#5# */ 
                 STATUS_NFE,/*--#5# */ 
                 TRANSPORTADORA,/*-- #8#*/ 
                 @EMPRESA,/*#22#*/ 
                 OBS, 
                 OBS_INTERESSE_FISCO,/*#28#*/ 
                 INFORMACAO_COMPLEMENTAR /*#29#*/ 
          FROM   #LOJA_NOTA_FISCAL_PERIODO_1;

          --> #21#  Inclusão registros em lote para minimizar escalonamento de bloqueios. 
          -->        Definição de contexto para evitar multiplas validações desnecessárias em triggers. 
          SET @CONTEXT = 0x53454D5F46494C415F45544C; --0x4C585F474552415F5452414E53464552454E434941535F504552494F444F  
          SET CONTEXT_INFO @CONTEXT; 
          --> Crispim 
          SET @COUNT = 1; 

          WHILE @COUNT <= @ROWSLOJAENTITEM 
            BEGIN 
                INSERT INTO ENTRADAS_ITEM 
                            (CLASSIF_FISCAL, 
                             CODIGO_FISCAL_OPERACAO, 
                             CODIGO_ITEM, 
                             ORIGEM_ITEM,/*--#14# */ 
                             COD_TABELA_FILHA, 
                             COMISSAO_ITEM, 
                             COMISSAO_ITEM_GERENTE, 
                             CONTA_CONTABIL, 
                             DESCONTO_ITEM, 
                             DESCRICAO_ITEM, 
                             FAIXA, 
                             ID_EXCECAO_IMPOSTO, 
                             INDICADOR_CFOP, 
                             ITEM_IMPRESSAO, 
                             NF_ENTRADA, 
                             NOME_CLIFOR, 
                             PESO, 
                             PORCENTAGEM_ITEM_RATEIO, 
                             PRECO_UNITARIO, 
                             QTDE_DEVOLVIDA, 
                             QTDE_ITEM, 
                             QTDE_RETORNAR_BENEFICIAMENTO, 
                             SERIE_NF_ENTRADA, 
                             SUB_ITEM_TAMANHO, 
                             TRIBUT_ICMS, 
                             TRIBUT_ORIGEM, 
                             UNIDADE, 
                             VALOR_ITEM, 
                             REFERENCIA, 
                             REFERENCIA_ITEM, 
                             REFERENCIA_PEDIDO, 
                             DIVERGENTE, 
                             TIMESTAMP, 
                             REFERENCIA_ENTREGA_PEDIDO, 
                             VALOR_ENCARGOS, 
                             VALOR_DESCONTOS, 
                             NAO_SOMA_VALOR, 
                             VALOR_ENCARGOS_IMPORTACAO, 
                             RATEIO_FILIAL, 
                             RATEIO_CENTRO_CUSTO) 
                SELECT CLASSIF_FISCAL, 
                       CODIGO_FISCAL_OPERACAO, 
                       CODIGO_ITEM, 
                       ORIGEM_ITEM,/*--#14# */ 
                       COD_TABELA_FILHA, 
                       COMISSAO_ITEM, 
                       COMISSAO_ITEM_GERENTE, 
                       CONTA_CONTABIL, 
                       DESCONTO_ITEM, 
                       DESCRICAO_ITEM, 
                       FAIXA, 
                       ID_EXCECAO_IMPOSTO, 
                       INDICADOR_CFOP, 
                       ITEM_IMPRESSAO, 
                       NF_ENTRADA, 
                       NOME_CLIFOR, 
                       PESO, 
                       PORCENTAGEM_ITEM_RATEIO, 
                       PRECO_UNITARIO, 
                       QTDE_DEVOLVIDA, 
                       QTDE_ITEM, 
                       QTDE_RETORNAR_BENEFICIAMENTO, 
                       SERIE_NF_ENTRADA, 
                       SUB_ITEM_TAMANHO, 
                       TRIBUT_ICMS, 
                       TRIBUT_ORIGEM, 
                       UNIDADE, 
                       VALOR_ITEM, 
                       REFERENCIA, 
                       REFERENCIA_ITEM, 
                       REFERENCIA_PEDIDO, 
                       DIVERGENTE, 
                       TIMESTAMP, 
                       REFERENCIA_ENTREGA_PEDIDO, 
                       VALOR_ENCARGOS, 
                       VALOR_DESCONTOS, 
                       NAO_SOMA_VALOR, 
                       VALOR_ENCARGOS_IMPORTACAO, 
                       RATEIO_FILIAL, 
                       RATEIO_CENTRO_CUSTO 
                FROM   #LOJA_NOTA_FISCAL_ITEM_PERIODO_1 
                WHERE  ID >= @COUNT 
                       AND ID <= @COUNT + 1999;	/*#37#*/

                SET @COUNT+=2000;	/*#37#*/

				/**#34#**/
				UPDATE	ENTRADA
				SET		ENTRADA.NF_ENTRADA = TEMP.NF_ENTRADA,
						ENTRADA.SERIE_NF_ENTRADA = TEMP.SERIE_NF_ENTRADA,
						ENTRADA.NOME_CLIFOR = TEMP.NOME_CLIFOR,
						ENTRADA.RATEIO_FILIAL = TEMP.RATEIO_FILIAL,
						ENTRADA.RATEIO_CENTRO_CUSTO = TEMP.RATEIO_CENTRO_CUSTO,
						ENTRADA.ITEM_IMPRESSAO = TEMP.ITEM_IMPRESSAO,
						ENTRADA.SUB_ITEM_TAMANHO = TEMP.SUB_ITEM_TAMANHO
				FROM		AF_LOCAL_ENTRADA AS ENTRADA
				JOIN		AF_LOCAL_SAIDA AS SAIDA
				ON		ENTRADA.ID_LOCAL_IMOBILIZADO = SAIDA.ID_LOCAL_IMOBILIZADO
						AND ENTRADA.EMPRESA = SAIDA.EMPRESA
				JOIN		#LOJA_NOTA_FISCAL_ITEM_PERIODO_1 AS TEMP
				ON		SAIDA.NF_SAIDA = TEMP.NF_ENTRADA
						AND SAIDA.SERIE_NF = TEMP.SERIE_NF_ENTRADA
						AND SAIDA.FILIAL = TEMP.NOME_CLIFOR
						AND SAIDA.ITEM_IMPRESSAO = TEMP.ITEM_IMPRESSAO
						AND SAIDA.SUB_ITEM_TAMANHO = TEMP.SUB_ITEM_TAMANHO
				WHERE    ENTRADA.NF_ENTRADA IS NULL 
						 AND ENTRADA.SERIE_NF_ENTRADA IS NULL 
						 AND ENTRADA.NOME_CLIFOR IS NULL
						 AND ENTRADA.ITEM_IMPRESSAO IS NULL
						 AND ENTRADA.SUB_ITEM_TAMANHO IS NULL;
						 /**#34#**/
            END; 

          SET CONTEXT_INFO 0x; 
          -- FIM - INSERÇÃO NAS TABELAS FÍSICAS (ENTRADAS E ENTRADAS_ITEM VERIFICANDO LOJA_ENTRADAS)    
          -----------------------------------------------------------------------------------------------------------------------------------------------    
          -- GRAVAR REFERÊNCIA DA NF NA TABELA LOJA_ENTRADAS     
          --> #21#  Atualização de registros em lote para minimizar escalonamento de bloqueios. 
          SET @ROWSITEMIMP = 1; 

          WHILE @ROWSITEMIMP > 0 
            BEGIN 
                UPDATE TOP (3000) A 
                SET    NF_ENTRADA = B.NF_ENTRADA, 
                       NOME_CLIFOR = B.NOME_CLIFOR, 
                       SERIE_NF_ENTRADA = B.SERIE_NF_ENTRADA, 
                       DATA_PARA_TRANSFERENCIA = Getdate() 
                FROM   DBO.LOJA_ENTRADAS A(NOLOCK) 
                       JOIN DBO.ENTRADAS B(NOLOCK) 
                         ON B.NOME_CLIFOR = A.FILIAL 
                            AND B.NF_ENTRADA = A.ROMANEIO_NF_SAIDA 
                            AND B.SERIE_NF_ENTRADA = A.SERIE_NF_ENTRADA 
                       JOIN #FATURAMENTO C 
                         ON A.FILIAL_ORIGEM = C.FILIAL 
                            AND A.ROMANEIO_NF_SAIDA = C.NF_SAIDA 
                            AND B.SERIE_NF_ENTRADA = C.SERIE_NF 
                WHERE  A.NF_ENTRADA IS NULL; 

                SET @ROWSITEMIMP = @@ROWCOUNT; 
            END; 

          SET @ROWSITEMIMP = 0; 
      /*17*/ 
      /* 
      UPDATE EP 
      SET EP.ITEM_IMPRESSAO = EI.ITEM_IMPRESSAO 
          FROM LOJA_ENTRADAS E (NOLOCK) 
          JOIN ENTRADAS B (NOLOCK)  
          ON B.FILIAL = E.FILIAL AND 
         B.NF_ENTRADA = E.ROMANEIO_NF_SAIDA AND  
         B.SERIE_NF_ENTRADA = E.SERIE_NF_ENTRADA  
              JOIN LOJA_ENTRADAS_PRODUTO EP 
          ON EP.ROMANEIO_PRODUTO = E.ROMANEIO_PRODUTO AND 
         EP.FILIAL           = E.FILIAL  
          JOIN (SELECT NOME_CLIFOR, NF_ENTRADA, SERIE_NF_ENTRADA, ITEM_IMPRESSAO, MAX(REFERENCIA)PRODUTO, MAX(REFERENCIA_ITEM) COR_PRODUTO FROM ENTRADAS_ITEM  
         GROUP BY NOME_CLIFOR, NF_ENTRADA, SERIE_NF_ENTRADA, ITEM_IMPRESSAO ) EI 
          ON B.NF_ENTRADA = EI.NF_ENTRADA AND 
         EI.NOME_CLIFOR = B.NOME_CLIFOR AND 
         B.SERIE_NF_ENTRADA = EI.SERIE_NF_ENTRADA AND 
         EP.PRODUTO = EI.PRODUTO AND  
         EP.COR_PRODUTO = LEFT(EI.COR_PRODUTO,5) 
          WHERE EP.ITEM_IMPRESSAO IS NULL 
      */ 
      -- FIM - GRAVAR REFERÊNCIA DA NF NA TABELA LOJA_ENTRADAS     
      -----------------------------------------------------------------------------------------------------------------------------------------------     
      END; 

    -----------------------------------------------------------------------------------------------------------------------------------------------     
    -- GERAÇÃO DE IMPOSTOS     
    IF (SELECT Object_id('TEMPDB..#LOJA_NOTA_FISCAL_PERIODO')) IS NOT NULL 
      BEGIN 
          --> #21#  Definição de contexto para evitar multiplas validações desnecessárias em triggers. 
          SET @CONTEXT = 0x53454D5F46494C415F45544C; --0x4C585F474552415F5452414E53464552454E434941535F504552494F444F  
          SET CONTEXT_INFO @CONTEXT; 

          --Crispim 
          INSERT INTO #TMP_IMPOSTO_ENT 
                      (NOME_CLIFOR, 
                       NF_ENTRADA, 
                       SERIE_NF_ENTRADA, 
                       GERA_IMPOSTO) 
          SELECT DISTINCT A.NOME_CLIFOR, 
                          A.NF_ENTRADA, 
                          A.SERIE_NF_ENTRADA, 
                          CASE 
                            WHEN A.SERIE_NF_ENTRADA <> @TIPO_PRODUCAO THEN 1 
                            ELSE 0 
                          END AS GERA_IMPOSTO 
          --INTO  #TMP_IMPOSTO_ENT 
          FROM   DBO.ENTRADAS AS A(NOLOCK) 
                 JOIN #LOJA_NOTA_FISCAL_PERIODO AS B(NOLOCK) 
                   ON A.NOME_CLIFOR = B.NOME_CLIFOR 
                      AND A.NF_ENTRADA = B.NF_ENTRADA 
                      AND A.SERIE_NF_ENTRADA = B.SERIE_NF_ENTRADA; 

          DECLARE CUR_IMPOSTO CURSOR LOCAL FAST_FORWARD /*#1#*/ 
          FOR 
            SELECT NOME_CLIFOR, 
                   NF_ENTRADA, 
                   SERIE_NF_ENTRADA 
            FROM   #TMP_IMPOSTO_ENT 
            ORDER  BY NOME_CLIFOR, 
                      NF_ENTRADA, 
                      SERIE_NF_ENTRADA; 

          OPEN CUR_IMPOSTO; 

          FETCH NEXT FROM CUR_IMPOSTO INTO @NOME_CLIFOR_CUR, @NF_ENTRADA_CUR, @SERIE_NF_ENTRADA_CUR;
          WHILE @@FETCH_STATUS = 0 
            BEGIN 
                IF @SERIE_NF_ENTRADA_CUR <> @TIPO_PRODUCAO 
                  BEGIN 

					  /*#44#*/
					  IF EXISTS (SELECT TOP 1 1 
								 FROM DBO.ENTRADAS_ITEM AS NF (NOLOCK) 
								 INNER JOIN DBO.CTB_EXCECAO_IMPOSTO AS EXC (NOLOCK) 
										 ON NF.ID_EXCECAO_IMPOSTO = EXC.ID_EXCECAO_IMPOSTO 
								 WHERE	NF.NF_ENTRADA = @NF_ENTRADA_CUR 
										AND NF.NOME_CLIFOR = @NOME_CLIFOR_CUR 
										AND NF.SERIE_NF_ENTRADA = @SERIE_NF_ENTRADA_CUR
										AND EXC.RECRIA_IMPOSTOS_TRANSFERENCIA = 1)
					      SET @RECALCULAR_IMPOSTO_EXCECAO = 1;
					  ELSE 
						  SET @RECALCULAR_IMPOSTO_EXCECAO = 0;
					  /*#44#*/

                      EXEC LX_GERA_IMPOSTOS_ENTRADA	@NOME_CLIFOR_CUR, 
													@NF_ENTRADA_CUR, 
													@SERIE_NF_ENTRADA_CUR, --(#LOJA_NOTA_FISCAL_PERIODO) 
													0,							 --@RECRIAR						/*#44#*/
													1,							 --@EXECUTAR_AJUSTE_GRUPO		/*#44#*/
													0,							 --@RECALCULAR_IMPOSTO_AGREGAR	/*#44#*/
													@RECALCULAR_IMPOSTO_EXCECAO	 --@RECALCULAR_IMPOSTO_EXCECAO	/*#44#*/

                  --EXEC LX_CONCILIA_IMPOSTOS_ENTRADA_POR_SAIDA_ @NOME_CLIFOR_CUR, @NF_ENTRADA_CUR, @SERIE_NF_ENTRADA_CUR 
                  END; 

                --INTEGRAÇÃO CONTÁBIL     
                IF @CONTABILIDADE_ATIVA = 1	--#43# EXISTS (SELECT 1 FROM   PARAMETROS(NOLOCK) WHERE  PARAMETRO = 'CONTABILIDADE_ATIVA' AND VALOR_ATUAL = '.T.') 
                  BEGIN 
                      EXEC LX_CTB_INTEGRAR_ENTRADA	@NOME_CLIFOR_CUR, 
													@NF_ENTRADA_CUR, 
													@SERIE_NF_ENTRADA_CUR 
                  END; 

                FETCH NEXT FROM CUR_IMPOSTO INTO @NOME_CLIFOR_CUR, @NF_ENTRADA_CUR, @SERIE_NF_ENTRADA_CUR;
            END; 

          CLOSE CUR_IMPOSTO; 

          DEALLOCATE CUR_IMPOSTO; 

          --> #21# Execução da procedure de geração de impostos para processamento em lote, ao invés de linha a linha
   
		 EXEC DBO.LX_CONCILIA_IMPOSTOS_ENTRADA_POR_SAIDA	@NOME_CLIFOR_CUR, 
															@NF_ENTRADA_CUR, 
															@SERIE_NF_ENTRADA_CUR; 

          TRUNCATE TABLE #TMP_IMPOSTO_ENT; 

          SET CONTEXT_INFO 0x; 
      END; 

    IF (SELECT Object_id('TEMPDB..#LOJA_NOTA_FISCAL_PERIODO_1')) IS NOT NULL 
      BEGIN 
          --> #21#  Definição de contexto para evitar multiplas validações desnecessárias em triggers. 
          SET @CONTEXT = 0x53454D5F46494C415F45544C; --0x4C585F474552415F5452414E53464552454E434941535F504552494F444F  
          SET CONTEXT_INFO @CONTEXT; 

          --#21# 
          INSERT INTO #TMP_IMPOSTO_ENT 
                      (NOME_CLIFOR, 
                       NF_ENTRADA, 
                       SERIE_NF_ENTRADA, 
                       GERA_IMPOSTO) 
          SELECT DISTINCT A.NOME_CLIFOR, 
                          A.NF_ENTRADA, 
                          A.SERIE_NF_ENTRADA, 
                          CASE 
                            WHEN A.SERIE_NF_ENTRADA <> @TIPO_PRODUCAO THEN 1 
                            ELSE 0 
                          END AS GERA_IMPOSTO 
          --INTO  #TMP_IMPOSTO_ENT 
          FROM   DBO.ENTRADAS AS A(NOLOCK) 
                 JOIN #LOJA_NOTA_FISCAL_PERIODO_1 AS B(NOLOCK) 
                   ON A.NOME_CLIFOR = B.NOME_CLIFOR 
                      AND A.NF_ENTRADA = B.NF_ENTRADA 
                      AND A.SERIE_NF_ENTRADA = B.SERIE_NF_ENTRADA; 

          DECLARE CUR_IMPOSTO CURSOR LOCAL FAST_FORWARD /*#1#*/ 
          FOR 
            SELECT NOME_CLIFOR, 
                   NF_ENTRADA, 
                   SERIE_NF_ENTRADA 
            FROM   #TMP_IMPOSTO_ENT 
            ORDER  BY NOME_CLIFOR, 
                      NF_ENTRADA, 
                      SERIE_NF_ENTRADA; 

          OPEN CUR_IMPOSTO; 

          FETCH NEXT FROM CUR_IMPOSTO INTO @NOME_CLIFOR_CUR, @NF_ENTRADA_CUR, @SERIE_NF_ENTRADA_CUR;

          WHILE @@FETCH_STATUS = 0 
            BEGIN 
                IF @SERIE_NF_ENTRADA_CUR <> @TIPO_PRODUCAO 
                  BEGIN 

					  /*#44#*/
					  IF EXISTS (SELECT TOP 1 1 
								 FROM DBO.ENTRADAS_ITEM AS NF (NOLOCK) 
								 INNER JOIN DBO.CTB_EXCECAO_IMPOSTO AS EXC (NOLOCK) 
										 ON NF.ID_EXCECAO_IMPOSTO = EXC.ID_EXCECAO_IMPOSTO 
								 WHERE	NF.NF_ENTRADA = @NF_ENTRADA_CUR 
										AND NF.NOME_CLIFOR = @NOME_CLIFOR_CUR 
										AND NF.SERIE_NF_ENTRADA = @SERIE_NF_ENTRADA_CUR
										AND EXC.RECRIA_IMPOSTOS_TRANSFERENCIA = 1)
					      SET @RECALCULAR_IMPOSTO_EXCECAO = 1;
					  ELSE 
						  SET @RECALCULAR_IMPOSTO_EXCECAO = 0;
					  /*#44#*/

                      EXEC LX_GERA_IMPOSTOS_ENTRADA	@NOME_CLIFOR_CUR, 
													@NF_ENTRADA_CUR, 
													@SERIE_NF_ENTRADA_CUR, --(#LOJA_NOTA_FISCAL_PERIODO_1) 
													0,							 --@RECRIAR						/*#44#*/
													1,							 --@EXECUTAR_AJUSTE_GRUPO		/*#44#*/
													0,							 --@RECALCULAR_IMPOSTO_AGREGAR	/*#44#*/
													@RECALCULAR_IMPOSTO_EXCECAO	 --@RECALCULAR_IMPOSTO_EXCECAO	/*#44#*/

                  --EXEC LX_CONCILIA_IMPOSTOS_ENTRADA_POR_SAIDA @NOME_CLIFOR_CUR, @NF_ENTRADA_CUR, @SERIE_NF_ENTRADA_CUR 
                  END; 

                --INTEGRAÇÃO CONTÁBIL     
                IF @CONTABILIDADE_ATIVA = 1	--#43# EXISTS (SELECT 1 FROM   PARAMETROS(NOLOCK) WHERE  PARAMETRO = 'CONTABILIDADE_ATIVA' AND VALOR_ATUAL = '.T.') 
                  BEGIN 
                      EXEC LX_CTB_INTEGRAR_ENTRADA	@NOME_CLIFOR_CUR, 
													@NF_ENTRADA_CUR, 
													@SERIE_NF_ENTRADA_CUR 
                  END; 

                FETCH NEXT FROM CUR_IMPOSTO INTO @NOME_CLIFOR_CUR, @NF_ENTRADA_CUR, @SERIE_NF_ENTRADA_CUR;
            END; 

          CLOSE CUR_IMPOSTO; 

          DEALLOCATE CUR_IMPOSTO; 

          --> #21# Execução da procedure de geração de impostos para processamento em lote, ao invés de linha a linha
          EXEC DBO.LX_CONCILIA_IMPOSTOS_ENTRADA_POR_SAIDA	@NOME_CLIFOR_CUR, 
															@NF_ENTRADA_CUR, 
															@SERIE_NF_ENTRADA_CUR; 

          TRUNCATE TABLE #TMP_IMPOSTO_ENT; 

          SET CONTEXT_INFO 0x; 
      END; 

    SET CONTEXT_INFO 0x; 
    -- FIM - GERAÇÃO DE IMPOSTOS     
    -----------------------------------------------------------------------------------------------------------------------------------------------    
    SET NOCOUNT OFF;