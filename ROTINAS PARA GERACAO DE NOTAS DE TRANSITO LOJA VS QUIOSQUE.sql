USE [CAEDU]
GO
/****** Object:  StoredProcedure [dbo].[CGP_QUEBRA_ITENS_LISTA_SKU_QTDE]    Script Date: 26/08/2026 12:15:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
criar coluna ERP_CUPS_ID_TRANSFERENCIA na tabela FATURAMENTO
*/
alter table dbo.faturamento 
add ERP_CUPS_ID_TRANSFERENCIA  VARCHAR(50) NULL
GO

/*
criar procedure para fazer split do parametro @lista_itens
*/
CREATE OR ALTER PROCEDURE [dbo].[CGP_QUEBRA_ITENS_LISTA_SKU_QTDE]
/*
DESCRIÇÃO /OBJETIVO:
LISTA DE ITENS PARA O FATURAMENTO
FORMATO: SKU, QTDE
DELIMITADOR: ;
CADA GRUPO DE SKU E QUANTIDADE SÃO DELIMITADOS POR , E AO FINAL SEPARADOS POR ;
NO ULTIMO GRUPO NÃO INFORMAR ;
AUTOR: PAULO DEVIDE
DATA CRIAÇÃO: 28-06-2026
*/
     @lista_itens varchar(max) 
--exemplo de lista
--set @lista_itens = '012264990000301,8;012264990000302,2;012264990000303,8;012264990000304,10;012264990000305,7'
AS
BEGIN
    DECLARE @tab_itens TABLE (
        id_rows      INT          IDENTITY(1,1) NOT NULL PRIMARY KEY,
        codigo_barra VARCHAR(25)  NOT NULL,
        qtde         INT          NOT NULL
    )

    declare @tab_itens_nf table (
    id_rows int not null primary key,
    codigo_barra varchar(25) not null,
    qtde int not null,
    PRODUTO varchar(12) not null,
    COR_PRODUTO varchar(10) not null,
    POSICAO INT NOT NULL,
    GRADE_SKU VARCHAR(25) NOT NULL,
    GRADE_PRODUTO VARCHAR(25) NOT NULL,
    PRECO_TRANSFERENCIA NUMERIC(14,2) NOT NULL
    )

    -- Converte a lista em XML para facilitar o split
    DECLARE @xml XML
    SET @xml = CAST('<i>' + REPLACE(@lista_itens, ';', '</i><i>') + '</i>' AS XML)

    INSERT INTO @tab_itens (codigo_barra, qtde)
    SELECT
        LTRIM(RTRIM(LEFT(item.value('.', 'VARCHAR(50)'),  CHARINDEX(',', item.value('.', 'VARCHAR(50)')) - 1))) AS codigo_barra,
        CAST(LTRIM(RTRIM(SUBSTRING(item.value('.', 'VARCHAR(50)'), CHARINDEX(',', item.value('.', 'VARCHAR(50)')) + 1, 50))) AS INT) AS qtde
    FROM @xml.nodes('/i') AS T(item)

    -- Carrega resultado para tabela de itens de faturamento
    INSERT INTO @tab_itens_nf
    SELECT a.id_rows, pb.CODIGO_BARRA, a.qtde, pb.PRODUTO, pb.COR_PRODUTO, pb.TAMANHO, pb.GRADE, p.GRADE, isnull(pp.PRECO1,1)
    FROM @tab_itens a
    INNER JOIN produtos_barra pb on pb.codigo_barra = a.codigo_barra
    INNER JOIN produtos p on p.produto = pb.produto
    INNER JOIN produtos_precos pp on pp.PRODUTO=pb.PRODUTO and pp.CODIGO_TAB_PRECO='02'
    INNER JOIN (
    SELECT
        pt.GRADE,
        v.Posicao       AS Tamanho_Posicao,
        v.TamanhoValor  AS Tamanho
    FROM dbo.PRODUTOS_TAMANHOS AS pt
    CROSS APPLY (
        VALUES
            (1,  pt.TAMANHO_1),
            (2,  pt.TAMANHO_2),
            (3,  pt.TAMANHO_3),
            (4,  pt.TAMANHO_4),
            (5,  pt.TAMANHO_5),
            (6,  pt.TAMANHO_6),
            (7,  pt.TAMANHO_7),
            (8,  pt.TAMANHO_8),
            (9,  pt.TAMANHO_9),
            (10, pt.TAMANHO_10),
            (11, pt.TAMANHO_11),
            (12, pt.TAMANHO_12),
            (13, pt.TAMANHO_13),
            (14, pt.TAMANHO_14),
            (15, pt.TAMANHO_15),
            (16, pt.TAMANHO_16)
    ) AS v(Posicao, TamanhoValor)
    WHERE
        v.TamanhoValor IS NOT NULL
        AND LTRIM(RTRIM(v.TamanhoValor)) <> ''
        --AND GRADE = '10 AO 16'
        AND v.TamanhoValor NOT LIKE '%.%'
    --ORDER BY
    --    pt.GRADE,
    --    v.Posicao
    ) t on t.GRADE = p.GRADE and pb.TAMANHO=t.Tamanho_Posicao
    order by a.id_rows
    -- retorna um dataset estruturado
    select * from @tab_itens_nf
END
GO

/*
CRIA PROCEDURE PARA GERAR NOTA FISCAL DE TRANSFERENCIA ENTRE FILIAIS
*/

CREATE OR ALTER PROCEDURE [dbo].[CGP_CAEDU_GERA_NOTA_FISCAL_TRANSFERENCIA] 
	@FILIAL_ORIGEM VARCHAR(25),   -- LOJA DE ORIGEM
	@FILIAL_DESTINO VARCHAR(25),  -- LOJA DESTINO
	@LISTA_ITENS VARCHAR(MAX),     -- LISTA DE CODIGOS DE BARRA NO FORMATO CODIGO_DE_BARRA,QTDE;CODIGO_DE_BARRA,QTDE;...CODIGO_DE_BARRA,QTDE
	@SERIE_SAIDA VARCHAR(10) = '02', -- VALOR PADRÃO ATENDE 99% DAS FILIAIS
	@ERP_CUPS_ID_TRANSFERENCIA VARCHAR(50)=NULL, /* UUID da transferência EXEMPLO --> 2b5f312c-872a-4fc4-87e8-89afe4be0d63 */
	@VOLUMES_NF INT = 1 /* VOLUMES DA NOTA */

/*
-- AUTOR: PAULO EDUARDO DEVIDE
-- 24-06-2026
-- OBJETIVO:
GERAR UMA NOTA FISCAL DE TRANSFERENCIA 120.01 DE UMA LOJA PARA OUTRA, TRANSFERINDO ITENS COM PREÇO DE TABELA 02 (TRANSFERÊNCIA) POR CODIGO DE BARRA
PARAMÊTROS:
@FILIAL_ORIGEM
@FILIAL_DESTINO
@LISTA_ITENS
EXEMPLO:
@lista_itens = '012264990000301,8;012264990000302,2;012264990000303,8;012264990000304,10;012264990000305,7'
OBS: NÃO PASSAR O ; APÓS O ULTIMO ITEM
A QTDE É DELIMITADA PELA , 
O GRUPO CODIGO_BARRA + QTDE É DELIMITADO PELO ;

ALTERAÇÃO SOLICITADA DANILO 07-07-2026
	- INCLUIR PARAMETROS @ERP_CUPS_ID_TRANSFERENCIA e @VOLUMES_NF
	- CRIAR COLUNA ERP_CUPS_ID_TRANSFERENCIA NA TABELA FATURAMENTO
	- O PARAMETRO @VOLUMES_NF DEVE SER INFORMADO NA CAPA DA NOTA
	- CRIAR UMA VALIDAÇÃO DO PARAMETRO @LISTA_ITENS, VERIFICANDO SE O SKU PASSADO EXISTE E RETORNAR MSG EM CASO DE ERRO
	- COMPILAR PROCEDURE CGP_CAEDU_GERA_NOTA_FISCAL_TRANSFERENCIA NO BANCO  CCP-DEV-SQL-005 PARA HOMOLOGAÇÃO
	- COMPILAR PROCEDURE CGP_QUEBRA_ITENS_LISTA_SKU_QTDE          NO BANCO  CCP-DEV-SQL-005 PARA HOMOLOGAÇÃO

ALTERAÇÃO SOLICITADA DANILO 24-07-26
	- RETORNAR O STATUS DE ERRO PARA SER CAPTURADO PELA APLICAÇÃO
--******************************************************************************************************************************************************

*/
AS 
BEGIN

	SET NOCOUNT ON; -- NÃO MOSTRAR LINHAS AFETADAS
	SET XACT_ABORT ON; -- ATIVAR COMANDO PARA INTERROMPER E CAPTURAR O ERRO

	DECLARE @PRODUTO VARCHAR(12), @NOME_CLIFOR VARCHAR(25), @COD_CLIFOR VARCHAR(6), @TIPO_FATURAMENTO VARCHAR(25), @SERIE_NF VARCHAR(3), 
	@ITEM INT, @ITEM_CHAR4 CHAR(4), @CFOP VARCHAR(4), @RATEIO_CENTRO_CUSTO VARCHAR(15), @RATEIO_FILIAL VARCHAR(15), @ID_EXCECAO INT, 
	@NATUREZA_SAIDA VARCHAR(6), @VALOR NUMERIC(18,2), @QTDE INT, @FILIAL VARCHAR(25), @CONDICAO_PGTO VARCHAR(3), @TRANSPORTADORA VARCHAR(25),
	@ERRMSG VARCHAR(300), @VALOR_ITEM NUMERIC(18,2), @QTDE_ITEM INT, @UNIDADE VARCHAR(6), @DESC_PRODUTO VARCHAR(40), @TAB_PRECO VARCHAR(6),
	@UF_TERCEIRO VARCHAR(2), @UF_FILIAL VARCHAR(2), @ID_EXCECAO_IMPOSTO INT, @COD_FILIAL VARCHAR(6), @PRECO NUMERIC(18,2), @CONTA VARCHAR(20),
	@NF_SAIDA VARCHAR(10), @ANOMES CHAR(4), @CHAVE_NFE VARCHAR(44), @CNPJ VARCHAR(19), @CIDADE VARCHAR(35), @REPRESENTANTE VARCHAR(25), 
	@CAIXA VARCHAR(8), @ROMANEIO VARCHAR(8), @ITEM_CHAR6 VARCHAR(6), @COR_PRODUTO VARCHAR(10), @TOT_VALOR NUMERIC(18,2), 
	@COD_FILIAL_ESTOQUE VARCHAR(8), @OBS VARCHAR(500), @GERENTE VARCHAR(25), @COMISSAO NUMERIC(10,2), @COMISSAO_GERENTE NUMERIC(10,2), 
	@peso numeric(14,3), @MATRIZ_FISCAL CHAR(25), @NF_ENTRADA VARCHAR(15), @SERIE_NF_ENTRADA VARCHAR(6), @FILIAL_ENTRADA VARCHAR(25), 
	@NOME_CLIFOR_FORNEC VARCHAR(25), @fator_preco numeric(7,2), @tipo_frete varchar(2), @tipo_volume varchar(20), @VOLUMES INT, 
	@CTB_TIPO_OPERACAO INT;

	/*
	VARIÁVEIS PARA TRATAMENTO DE ERRO
	*/
	DECLARE
		@NUMERO_ERRO INT,
		@MENSAGEM_ERRO NVARCHAR(2048),
		@PROCEDURE_ERRO SYSNAME,
		@LINHA_ERRO INT,
		@ERRO_APLICACAO NVARCHAR(2048);
	--**************************************

	/*VARIAVEL QUE CONTEM O VALOR DO PARAMETRO UTC VALOR = 3 PARA HORARIO NORMAL E VALOR = 4 PARA HORARIO DE VERAO */
	DECLARE @UTC_FUSO INT; 

	--*************************************************-- controle de fluxo de erros
	BEGIN TRY
	--*************************************************--

		SELECT @UTC_FUSO = CAST(VALOR_ATUAL AS INT) FROM PARAMETROS 
		WHERE PARAMETRO = 'PALMA_UTC_NFE_CAEDU'

		set @TIPO_FRETE = '02'
		set @tipo_volume = 'CAIXA' 

		SET @CONTA = ''

		/*TABELA PARA ARMAZENAR E CRIAR A CHAVE DA NOTA FISCAL*/
		IF OBJECT_ID('tempdb..#TEMP') IS NOT NULL -- SE EXISTIR FAZ UM DROP ANTES DE CRIAR
		BEGIN
			DROP TABLE #TEMP
		END
		CREATE TABLE #TEMP(CHAVE_NF char(44))                      

		SET @ERRMSG = '';             

		delete from #TEMP;

		BEGIN TRANSACTION;

		set @NOME_CLIFOR = null
		set @FILIAL = @FILIAL_ORIGEM --@FILIAL_ENTRADA
		set @MATRIZ_FISCAL = @FILIAL_ENTRADA

		set @fator_preco = 1
	

		-- SETANDO INFORMACOES BASICAS DO FATURAMENTO 
		SET @FILIAL_ENTRADA = @FILIAL_ORIGEM
		SET @NOME_CLIFOR = @FILIAL_DESTINO

		if @NOME_CLIFOR is not null
		begin
			SELECT	@VOLUMES = isnull(@VOLUMES_NF, 1), 
					@TRANSPORTADORA = 'O PROPRIO', 
					@OBS = 'NF TRANSFERENCIA ENTRE LOJAS' 


			SELECT @COD_FILIAL = COD_CLIFOR, @UF_FILIAL = UF, @CNPJ = CGC_CPF, @CIDADE = CIDADE FROM CADASTRO_CLI_FOR WHERE NOME_CLIFOR = @FILIAL_ORIGEM 

			SELECT @COD_CLIFOR = B.COD_CLIFOR, @UF_TERCEIRO = B.UF FROM CADASTRO_CLI_FOR B WHERE B.NOME_CLIFOR  = @FILIAL_DESTINO 

			SELECT @TIPO_FATURAMENTO = 'TRANSFERENCIA'
			SELECT @SERIE_NF = @SERIE_SAIDA -- PEGA O VALOR PASSADO POR PARAMETRO 
			SELECT @NATUREZA_SAIDA = '120.01' 
			SELECT @CTB_TIPO_OPERACAO = 120
			SELECT @TAB_PRECO = '02' 
			SELECT @RATEIO_FILIAL = COD_FILIAL
			FROM FILIAIS WHERE FILIAL = @FILIAL_DESTINO
			SELECT @RATEIO_CENTRO_CUSTO = '005' -- ainda a ser definido


			SELECT @CFOP =  '5152' 

			SELECT @CONDICAO_PGTO = '001' 

			-- TOTALIZANDO AS RESERVAS PARA INSERIR NA CAPA DA NF

			set	@REPRESENTANTE = @FILIAL_ORIGEM
			set	@GERENTE = @FILIAL_ORIGEM 
			set @COMISSAO = 0
			set @COMISSAO_GERENTE = 0
			set @VALOR = 0

			DECLARE @TAB_PRODUTOS_NF 
			TABLE (
					ID_ROWS INT NOT NULL PRIMARY KEY,
					CODIGO_BARRA VARCHAR(25) NOT NULL,
					QTDE INT NOT NULL,
					PRODUTO VARCHAR(12) NOT NULL,
					COR_PRODUTO VARCHAR(10) NOT NULL,
					POSICAO INT NOT NULL,
					GRADE_SKU VARCHAR(25) NOT NULL,
					GRADE_PRODUTO VARCHAR(25) NOT NULL,
					PRECO_TRANSFERENCIA NUMERIC(14,2) NOT NULL
					)
	
			INSERT INTO @TAB_PRODUTOS_NF
			EXEC DBO.CGP_QUEBRA_ITENS_LISTA_SKU_QTDE @LISTA_ITENS

			select	@QTDE = sum(QTDE)
			from @TAB_PRODUTOS_NF

			/*
			EXEMPLO DE DATASET RETORNADO PELA PROCEDURE DBO.CGP_QUEBRA_ITENS_LISTA_SKU_QTDE (FAZ SPLIT DO PARAMETRO @LISTA_ITENS)
			id_rows     codigo_barra              qtde        PRODUTO      COR_PRODUTO POSICAO     GRADE_SKU                 GRADE_PRODUTO             PRECO_TRANSFERENCIA
			----------- ------------------------- ----------- ------------ ----------- ----------- ------------------------- ------------------------- -------------------
			1           012264990000301           8           01226499     00003       1           PP                        PP AO GG                  35.50
			2           012264990000302           2           01226499     00003       2           P                         PP AO GG                  35.50
			3           012264990000303           8           01226499     00003       3           M                         PP AO GG                  35.50
			4           012264990000304           10          01226499     00003       4           G                         PP AO GG                  35.50
			*/
				-- INSERE A CAPA 

			SET @peso = 1

			/*
			INSERE A CAPA DA NOTA FISCAL TABELA FATURAMENTO
			*/
			PRINT @NOME_CLIFOR

			INSERT INTO FATURAMENTO(FILIAL,NF_SAIDA,SERIE_NF,CODIGO_LOCAL_ENTREGA,FILIAL_FATURADA,TIPO_FATURAMENTO,LANCAMENTO,NOME_CLIFOR
			,CONDICAO_PGTO,NATUREZA_SAIDA,TRANSPORTADORA,TRANSP_REDESPACHO,TIPO_FRETE,COD_TRANSACAO,EMISSAO,DATA_SAIDA,FRETE,SEGURO,DESCONTO
			,DESCONTO_COND_PGTO,ENCARGO,ICMS,IPI_VALOR,VALOR_TOTAL,QTDE_TOTAL,NF_FATURA,FATURA,NOTA_IMPRESSA,ACERTO_CONTAS_P_R,TABELA_FILHA
			,OBS,PESO_LIQUIDO,PESO_BRUTO,VOLUMES,TIPO_VOLUME,CONFERIDO,CONFERIDO_POR,ENTREGA_CIF,IRRF,IRRF_RET_FONTE,NOTA_CANCELADA,DEVOLUCAO
			,REPRESENTANTE,COMISSAO,PORCENTAGEM_ACERTO,GERENTE,COMISSAO_GERENTE,DESCONTO_BRUTO,TIMESTAMP,CONFERENCIA,MARCA_EXPORTACAO
			,ATUALIZACAO_EXPORTAR,DATA_EXPORTACAO,ICMS_BASE,STATUS_TRANSITO,DATA_CANCELAMENTO,VALOR_CANCELADO,QTDE_CANCELADA,MOEDA
			,CAMBIO_NA_DATA,COBRAR_MOEDA_PADRAO,DATA_FATURAMENTO_RELATIVO,RECARGO,DATA_PARA_TRANSFERENCIA,NOME_CLIFOR_ENTREGA,TABELA_PRECO_FRETE
			,VALOR_FRETE,NOME_CLIFOR_COBRANCA,VALOR_ADICIONAL,IPI_ADICIONAL,OBS_TRANSPORTE,AGRUPAMENTO_ITENS,COMISSAO_VALOR,COMISSAO_VALOR_GERENTE
			,CTB_ITEM,CTB_LANCAMENTO,DESCONTO_BRUTO_1,DESCONTO_BRUTO_2,DESCONTO_BRUTO_3,DESCONTO_BRUTO_4,DESCONTO_SOBRE_1,DESCONTO_SOBRE_2
			,DESCONTO_SOBRE_3,DESCONTO_SOBRE_4,EMPRESA,FATURA_FILIAL,FATURA_NUMERO,FATURA_SERIE,ICMS_ISENTO,ICMS_OUTROS,MPADRAO_DESCONTO
			,MPADRAO_DESCONTO_COND_PGTO,MPADRAO_ENCARGO,MPADRAO_FRETE,MPADRAO_IMPOSTO_AGREGAR,MPADRAO_SEGURO,MPADRAO_VALOR_SUB_ITENS,MPADRAO_VALOR_TOTAL
			,MULTI_DESCONTO_ACUMULAR,NUMERO_CONFERENCIA,PORC_DESCONTO,PORC_DESCONTO_BRUTO,PORC_DESCONTO_COND_PGTO,PORC_DESCONTO_DIGITADO,PORC_ENCARGO
			,RATEIO_CENTRO_CUSTO,RATEIO_FILIAL,VALOR_DIFERENCA_GUIA_FATURA,VALOR_IMPOSTO_AGREGAR,VALOR_SUB_ITENS,IMPRIMIR_ENDERECO_COBRANCA
			,INDICA_CONSUMIDOR_FINAL,BANCO,AGENCIA,RESPONSAVEL_TRANSPORTE,NOTA_COMPLEMENTAR,NUMERO_CONHECIMENTO_RELACIONADO,PORC_DESCONTO_SEFAZ
			,DESCONTO_SEFAZ,MPADRAO_DESCONTO_SEFAZ,ID_CAIXA_PGTO,NRO_DE,DATA_DE,NATUREZA_EXPORTACAO,NRO_RE,DATA_RE,NRO_CONHECIMENTO_EMBARQUE
			,DATA_CONHECIMENTO,TIPO_CONHECIMENTO,COD_PAIS,NRO_COMPROVANTE_EXPORTACAO,DATA_COMPROVANTE_EXPORTACAO,DATA_AVERBACAO,NF_EMITIDA_EXPORTADOR
			,COD_RELACIONAMENTO_RE_NF,NF_E_NUMERO,NF_E_DATA_EMISSAO,NF_E_COD_VERIFICACAO,NF_E_DATA_QUITACAO_GUIA,NF_E_GERACAO,SEQUENCIAL_UNICO
			,DATA_GERACAO_NSU,CODIGO_CLIENTE_VAREJO,PROTOCOLO_AUTORIZACAO_NFE,COD_MOTIVO_CANC,PIN,CHAVE_NFE,PROTOCOLO_CANCELAMENTO_NFE
			,DATA_AUTORIZACAO_NFE,GERAR_AUTOMATICO,STATUS_NFE,LOG_STATUS_NFE,MOTIVO_CANCELAMENTO_NFE,PRIORIZACAO,TIPO_EMISSAO_NFE,FIN_EMISSAO_NFE
			,REGISTRO_DPEC,DATA_REGISTRO_DPEC,ITEM_NFE,OBS_INTERESSE_FISCO,DATA_CONTINGENCIA,JUSTIFICATIVA_CONTINGENCIA,UF_EMBARQUE_EXPORTACAO
			,LOCAL_EMBARQUE_EXPORTACAO,CFOP_CANCELAMENTO,VALOR_DESPACHO,VALOR_IMPOSTO_INCIDENCIA,MPADRAO_VALOR_IMPOSTO_INCIDENCIA,VEICULO_PLACA
			,UF_PLACA_VEICULO,MARCA_VOLUMES,NUMERACAO_VOLUMES,INFORMACAO_COMPLEMENTAR, INFO_PGTO, UTC_EMISSAO, UTC_DATA_SAIDA,ERP_CUPS_ID_TRANSFERENCIA)
			SELECT @FILIAL
			,'XYXZ' --@NF_SAIDA AS NF_SAIDA                      
			,@SERIE_NF AS SERIE_NF                      
			,NULL AS CODIGO_LOCAL_ENTREGA                      
			,NULL AS FILIAL_FATURADA                      
			,@TIPO_FATURAMENTO AS TIPO_FATURAMENTO                      
			,NULL AS LANCAMENTO                      
			,@NOME_CLIFOR AS NOME_CLIFOR                      
			,@CONDICAO_PGTO AS CONDICAO_PGTO     
			,@NATUREZA_SAIDA AS NATUREZA_SAIDA                      
			,@TRANSPORTADORA AS TRANSPORTADORA                 
			,@TRANSPORTADORA AS TRANSP_REDESPACHO              
			,@tipo_frete AS TIPO_FRETE                      
			,'FATURAMENTO_022' AS COD_TRANSACAO                      
			,CAST(GETDATE() AS DATE) AS EMISSAO                      
			,CAST(GETDATE() AS DATE) AS DATA_SAIDA                      
			,0.00 AS FRETE                      
			,0.00 AS SEGURO                      
			,0.00 AS DESCONTO                      
			,0.00 AS DESCONTO_COND_PGTO                      
			,0.00 AS ENCARGO                      
			,0.00 AS ICMS                      
			,0.00 AS IPI_VALOR                      
			,@VALOR AS VALOR_TOTAL                      
			,@QTDE AS QTDE_TOTAL                      
			,0 AS NF_FATURA                      
			,NULL AS FATURA                      
			,0 AS NOTA_IMPRESSA                      
			,0 AS ACERTO_CONTAS_P_R                      
			,'FATURAMENTO_PROD' AS TABELA_FILHA                      
			,@OBS 
			,isnull(@peso,0) AS PESO_LIQUIDO                      
			,isnull(@peso,0) AS PESO_BRUTO                      
			,@VOLUMES AS VOLUMES                      
			,@TIPO_VOLUME AS TIPO_VOLUME                      
			, 0 AS CONFERIDO                      
			,'SA' CONFERIDO_POR                      
			,1 AS ENTREGA_CIF                      
			,0 AS IRRF                      
			,0 AS IRRF_RET_FONTE                      
			,0 AS NOTA_CANCELADA                      
			,0 AS DEVOLUCAO                      
			,@REPRESENTANTE AS REPRESENTANTE                      
			,@COMISSAO AS COMISSAO                      
			,100 AS PORCENTAGEM_ACERTO                      
			,@GERENTE AS GERENTE                      
			,@COMISSAO_GERENTE AS COMISSAO_GERENTE                      
			,0 AS DESCONTO_BRUTO                      
			,NULL AS TIMESTAMP                      
			,NULL AS CONFERENCIA                      
			,NULL AS MARCA_EXPORTACAO                      
			,NULL AS ATUALIZACAO_EXPORTAR                      
			,NULL AS DATA_EXPORTACAO                      
			,0 AS ICMS_BASE                      
			,NULL AS STATUS_TRANSITO                      
			,NULL AS DATA_CANCELAMENTO                      
			,0 AS VALOR_CANCELADO                      
			,0 AS QTDE_CANCELADA                      
			,'R$' AS MOEDA                      
			,1 AS CAMBIO_NA_DATA                      
			,1 AS COBRAR_MOEDA_PADRAO                      
			,NULL AS DATA_FATURAMENTO_RELATIVO                      
			,0 AS RECARGO                      
			,GETDATE() AS DATA_PARA_TRANSFERENCIA                      
			,@NOME_CLIFOR AS NOME_CLIFOR_ENTREGA                      
			,NULL AS TABELA_PRECO_FRETE                      
			,0 AS VALOR_FRETE                      
			,NULL AS NOME_CLIFOR_COBRANCA                      
			,NULL AS VALOR_ADICIONAL                      
			,NULL AS IPI_ADICIONAL     
			,NULL AS OBS_TRANSPORTE                      
			,0 AS AGRUPAMENTO_ITENS                      
			,ROUND(@VALOR * (@COMISSAO/100),2) AS COMISSAO_VALOR                      
			,ROUND(@VALOR * (@COMISSAO_GERENTE/100),2) AS COMISSAO_VALOR_GERENTE                      
			,NULL AS CTB_ITEM                      
			,NULL AS CTB_LANCAMENTO                      
			,0 AS DESCONTO_BRUTO_1                      
			,0 AS DESCONTO_BRUTO_2                      
			,0 AS DESCONTO_BRUTO_3                      
			,0 AS DESCONTO_BRUTO_4                      
			,0 AS DESCONTO_SOBRE_1                      
			,0 AS DESCONTO_SOBRE_2                      
			,0 AS DESCONTO_SOBRE_3                      
			,0 AS DESCONTO_SOBRE_4                      
			,1 AS EMPRESA                      
			,NULL AS FATURA_FILIAL                      
			,NULL AS FATURA_NUMERO                      
			,NULL AS FATURA_SERIE                      
			,0 AS ICMS_ISENTO                      
			,0 AS ICMS_OUTROS                      
			,0 AS MPADRAO_DESCONTO                      
			,0 AS MPADRAO_DESCONTO_COND_PGTO                      
			,0 AS MPADRAO_ENCARGO                      
			,0 AS MPADRAO_FRETE                      
			,0 AS MPADRAO_IMPOSTO_AGREGAR                      
			,0 AS MPADRAO_SEGURO                      
			,@VALOR AS MPADRAO_VALOR_SUB_ITENS                      
			,@VALOR AS MPADRAO_VALOR_TOTAL                    
			,0 AS MULTI_DESCONTO_ACUMULAR                      
			,NULL AS NUMERO_CONFERENCIA                      
			,0 AS PORC_DESCONTO                      
			,0 AS PORC_DESCONTO_BRUTO                      
			,0 AS PORC_DESCONTO_COND_PGTO                      
			,0 AS PORC_DESCONTO_DIGITADO                      
			,0 AS PORC_ENCARGO                      
			,@RATEIO_CENTRO_CUSTO AS RATEIO_CENTRO_CUSTO                      
			,@RATEIO_FILIAL AS RATEIO_FILIAL                      
			,0 AS VALOR_DIFERENCA_GUIA_FATURA                      
			,0 AS VALOR_IMPOSTO_AGREGAR                      
			,@VALOR AS VALOR_SUB_ITENS                      
			,0 AS IMPRIMIR_ENDERECO_COBRANCA                      
			,0 AS INDICA_CONSUMIDOR_FINAL                      
			,NULL AS BANCO                      
			,NULL AS AGENCIA                      
			,NULL AS RESPONSAVEL_TRANSPORTE                      
			,0 AS NOTA_COMPLEMENTAR                      
			,NULL AS NUMERO_CONHECIMENTO_RELACIONADO                      
			,0 AS PORC_DESCONTO_SEFAZ                      
			,0 AS DESCONTO_SEFAZ                      
			,0 AS MPADRAO_DESCONTO_SEFAZ                      
			,NULL AS ID_CAIXA_PGTO                      
			,NULL AS NRO_DE                      
			,NULL AS DATA_DE                      
			,NULL AS NATUREZA_EXPORTACAO                      
			,NULL AS NRO_RE                      
			,NULL AS DATA_RE                      
			,NULL AS NRO_CONHECIMENTO_EMBARQUE                      
			,NULL AS DATA_CONHECIMENTO                      
			,NULL AS TIPO_CONHECIMENTO                      
			,NULL AS COD_PAIS                      
			,NULL AS NRO_COMPROVANTE_EXPORTACAO                      
			,NULL AS DATA_COMPROVANTE_EXPORTACAO                      
			,NULL AS DATA_AVERBACAO                      
			,NULL AS NF_EMITIDA_EXPORTADOR                      
			,NULL AS COD_RELACIONAMENTO_RE_NF                      
			,NULL AS NF_E_NUMERO                      
			,NULL AS NF_E_DATA_EMISSAO                      
			,NULL AS NF_E_COD_VERIFICACAO                      
			,NULL AS NF_E_DATA_QUITACAO_GUIA                      
			,NULL AS NF_E_GERACAO                      
			,NULL AS SEQUENCIAL_UNICO                      
			,NULL AS DATA_GERACAO_NSU                      
			,NULL AS CODIGO_CLIENTE_VAREJO                      
			,NULL AS PROTOCOLO_AUTORIZACAO_NFE                      
			,NULL AS COD_MOTIVO_CANC                      
			,NULL AS PIN                      
			,NULL AS CHAVE_NFE                      
			,NULL AS PROTOCOLO_CANCELAMENTO_NFE                      
			,NULL AS DATA_AUTORIZACAO_NFE                      
			,0 AS GERAR_AUTOMATICO                      
			,1 AS STATUS_NFE                
			,0 AS LOG_STATUS_NFE                      
			,NULL AS MOTIVO_CANCELAMENTO_NFE                      
			,0 AS PRIORIZACAO                      
			,1 AS TIPO_EMISSAO_NFE                      
			,1 AS FIN_EMISSAO_NFE                      
			,0 AS REGISTRO_DPEC                      
			,'19000101' AS DATA_REGISTRO_DPEC                      
			,0 AS ITEM_NFE                      
			,NULL AS OBS_INTERESSE_FISCO                      
			,NULL AS DATA_CONTINGENCIA                      
			,NULL AS JUSTIFICATIVA_CONTINGENCIA                      
			,NULL AS UF_EMBARQUE_EXPORTACAO                      
			,NULL AS LOCAL_EMBARQUE_EXPORTACAO                      
			,NULL AS CFOP_CANCELAMENTO                      
			,0 AS VALOR_DESPACHO                      
			,NULL AS VALOR_IMPOSTO_INCIDENCIA                      
			,NULL AS MPADRAO_VALOR_IMPOSTO_INCIDENCIA                      
			,NULL AS VEICULO_PLACA   
			,NULL AS UF_PLACA_VEICULO                      
			,NULL AS MARCA_VOLUMES                      
			,NULL AS NUMERACAO_VOLUMES                      
			,NULL AS INFORMACAO_COMPLEMENTAR                      
			, '90' as INFO_PGTO,
			@UTC_FUSO AS UTC_EMISSAO,
			@UTC_FUSO AS UTC_DATA_SAIDA,
			@ERP_CUPS_ID_TRANSFERENCIA


			PRINT 'FATURAMENTO_PROD'                        

			/* CRIA TEMPORARIA PARA AGRUPAR OS DADOS NO FORMATO HORIZONTAL F1, F2, F3, ...F48 */
			DECLARE @TAB_PRODUTOS_NF_AGRUPADA
			TABLE (
					ID_ROWS INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
					PRODUTO VARCHAR(12) NOT NULL,
					COR_PRODUTO VARCHAR(10) NOT NULL,
					F1 int NULL, F2 int NULL, F3 int NULL, F4 int NULL, F5 int NULL, F6 int NULL, F7 int NULL, F8 int NULL, 
					F9 int NULL, F10 int NULL, F11 int NULL, F12 int NULL, F13 int NULL, F14 int NULL, F15 int NULL, F16 int NULL, 
					F17 int NULL, F18 int NULL, F19 int NULL, F20 int NULL, F21 int NULL, F22 int NULL, F23 int NULL, F24 int NULL, 
					F25 int NULL, F26 int NULL, F27 int NULL, F28 int NULL, F29 int NULL, F30 int NULL, F31 int NULL, F32 int NULL, 
					F33 int NULL, F34 int NULL, F35 int NULL, F36 int NULL, F37 int NULL, F38 int NULL, F39 int NULL, F40 int NULL, 
					F41 int NULL, F42 int NULL, F43 int NULL, F44 int NULL, F45 int NULL, F46 int NULL, F47 int NULL, F48 int NULL,
					PRECO1 numeric(14,2) NULL, QTDE int, VALOR numeric(14,2)
					)
			INSERT INTO @TAB_PRODUTOS_NF_AGRUPADA (PRODUTO, COR_PRODUTO, 
													F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14, F15, F16, 
													F17, F18, F19, F20, F21, F22, F23, F24, F25, F26, F27, F28, F29, F30, F31, 
													F32, F33, F34, F35, F36, F37, F38, F39, F40, F41, F42, F43, F44, F45, F46, F47, F48 
													)

			SELECT
				PRODUTO,
				COR_PRODUTO,
				ISNULL([1],  0) AS F1,
				ISNULL([2],  0) AS F2,
				ISNULL([3],  0) AS F3,
				ISNULL([4],  0) AS F4,
				ISNULL([5],  0) AS F5,
				ISNULL([6],  0) AS F6,
				ISNULL([7],  0) AS F7,
				ISNULL([8],  0) AS F8,
				ISNULL([9],  0) AS F9,
				ISNULL([10], 0) AS F10,
				ISNULL([11], 0) AS F11,
				ISNULL([12], 0) AS F12,
				ISNULL([13], 0) AS F13,
				ISNULL([14], 0) AS F14,
				ISNULL([15], 0) AS F15,
				ISNULL([16], 0) AS F16,
				ISNULL([17], 0) AS F17,
				ISNULL([18], 0) AS F18,
				ISNULL([19], 0) AS F19,
				ISNULL([20], 0) AS F20,
				ISNULL([21], 0) AS F21,
				ISNULL([22], 0) AS F22,
				ISNULL([23], 0) AS F23,
				ISNULL([24], 0) AS F24,
				ISNULL([25], 0) AS F25,
				ISNULL([26], 0) AS F26,
				ISNULL([27], 0) AS F27,
				ISNULL([28], 0) AS F28,
				ISNULL([29], 0) AS F29,
				ISNULL([30], 0) AS F30,
				ISNULL([31], 0) AS F31,
				ISNULL([32], 0) AS F32,
				ISNULL([33], 0) AS F33,
				ISNULL([34], 0) AS F34,
				ISNULL([35], 0) AS F35,
				ISNULL([36], 0) AS F36,
				ISNULL([37], 0) AS F37,
				ISNULL([38], 0) AS F38,
				ISNULL([39], 0) AS F39,
				ISNULL([40], 0) AS F40,
				ISNULL([41], 0) AS F41,
				ISNULL([42], 0) AS F42,
				ISNULL([43], 0) AS F43,
				ISNULL([44], 0) AS F44,
				ISNULL([45], 0) AS F45,
				ISNULL([46], 0) AS F46,
				ISNULL([47], 0) AS F47,
				ISNULL([48], 0) AS F48
			FROM (
				-- ✅ Pré-agrupamento: soma as qtdes antes do PIVOT para garantir se tiver sku repetido que some as quantidades
				SELECT
					PRODUTO,
					COR_PRODUTO,
					POSICAO,
					SUM(QTDE) AS QTDE
				FROM @TAB_PRODUTOS_NF
				GROUP BY PRODUTO, COR_PRODUTO, POSICAO
			) AS D
			PIVOT (
				SUM(QTDE)
				FOR POSICAO IN (
					[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],
					[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],
					[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],
					[31],[32],[33],[34],[35],[36],[37],[38],[39],[40],
					[41],[42],[43],[44],[45],[46],[47],[48]
				)
			) AS P
			ORDER BY PRODUTO, COR_PRODUTO


			/* ATUALIZA O PREÇO UNITÁRIO E O VALOR TOTAL POR LINHA DE PRODUTO /COR_PRODUTO COM A TABELA DE PREÇOS 02 (TRANSFERENCIA) */
			UPDATE T1 SET   PRECO1 = T2.PRECO1,
							QTDE = (F1+F2+F3+F4+F5+F6+F7+F8+F9+F10+F11+F12+F13+F14+F15+F16+F17+F18+F19+F20+F21+F22+F23+F24+
									F25+F26+F27+F28+F29+F30+F31+F32+F33+F34+F35+F36+F37+F38+F39+F40+F41+F42+F43+F44+F45+F46+F47+F48),
							VALOR = (F1+F2+F3+F4+F5+F6+F7+F8+F9+F10+F11+F12+F13+F14+F15+F16+F17+F18+F19+F20+F21+F22+F23+F24+
									F25+F26+F27+F28+F29+F30+F31+F32+F33+F34+F35+F36+F37+F38+F39+F40+F41+F42+F43+F44+F45+F46+F47+F48) * T2.PRECO1
			FROM @TAB_PRODUTOS_NF_AGRUPADA T1
			LEFT JOIN PRODUTOS_PRECOS T2 ON T2.PRODUTO = T1.PRODUTO AND T2.CODIGO_TAB_PRECO='02'

			DECLARE @ROWID INT, @TOTITENS INT
		
			/* DEFINE A PRIMEIRA E A ULTIMA LINHA DO LOOP*/
			SELECT @ROWID = MIN(IT.ID_ROWS), @TOTITENS=MAX(IT.ID_ROWS)
			FROM @TAB_PRODUTOS_NF_AGRUPADA IT

			WHILE @ROWID <= @TOTITENS /* VARRE TODA A TABELA TEMPORARIA DE ITENS */
			BEGIN
			
				INSERT INTO FATURAMENTO_PROD(FILIAL                          
				,NF_SAIDA                          
				,SERIE_NF                          
				,PRODUTO                          
				,COR_PRODUTO                          
				,ITEM                          
				,PEDIDO                          
				,PEDIDO_PRODUTO                          
				,PEDIDO_COR                          
				,ENTREGA                          
				,CAIXA                          
				,IPI                          
				,ICMS                          
				,DESCONTO_ITEM                          
				,QTDE                          
				,PRECO                          
				,VALOR                          
				,PACKS                          
				,MATA_SALDO  
				,F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14, F15, F16, F17, F18, F19, F20 
				,F21, F22, F23, F24, F25, F26, F27, F28, F29, F30, F31, F32, F33, F34, F35, F36, F37, F38, F39 
				,F40, F41, F42, F43, F44, F45, F46, F47, F48		
				,FAIXA                          
				,ORIGEM                          
				,ROMANEIO                          
				,CUSTO_NA_DATA                          
				,MOEDA                          
				,CAMBIO_NA_DATA                          
				,ORIGEM_EMB                          
				,DATA_PARA_TRANSFERENCIA                          
				,CODIGO_LOCAL_ENTREGA                          
				,CODIGO_FISCAL_OPERACAO                          
				,COD_FILIAL_ESTOQUE                          
				,CUSTO_NA_DATA_2                          
				,CUSTO_NA_DATA_3                          
				,CUSTO_NA_DATA_4                          
				,ITEM_IMPRESSAO                          
				,ITEM_IMPRESSAO_FATURA                          
				,ITEM_PEDIDO                          
				,ORDEM_PRODUCAO                          
				,PRECO_2                          
				,PRECO_3                          
				,PRECO_4                          
				,VALOR_DIFERENCA_GUIA_FATURA_ITEM                          
				,DESC_VENDA_CLIENTE                       
				,ID_MODIFICACAO                          
				,LICENCIADO_ROYALTIES                          
				,ID_VENDA_ENTREGA_FUTURA                          
				,TIMESTAMP)       
		
				SELECT @FILIAL AS FILIAL                          
				,'XYXZ' AS NF_SAIDA                          
				,@SERIE_NF AS SERIE_NF                          
				,A.PRODUTO                          
				,A.COR_PRODUTO                          
				,format(@ROWID,'000000') AS ITEM  /* NUMERO DA LINHA COM ZEROS A ESQUERDA COM 6 POSIÇÕES*/                      
				,NULL AS PEDIDO                          
				,NULL AS PEDIDO_PRODUTO                          
				,NULL AS PEDIDO_COR                          
				,NULL AS ENTREGA                          
				,null AS CAIXA                          
				,0 AS IPI                          
				,0 AS ICMS                          
				,0 AS DESCONTO_ITEM                          
				,A.QTDE AS QTDE                          
				,a.PRECO1 AS PRECO                          
				,a.VALOR AS VALOR                          
				,NULL AS PACKS                          
				,0 AS MATA_SALDO    
				,F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14, F15, F16, F17, F18, F19, F20, F21, F22, F23, F24, 
				F25, F26, F27, F28, F29, F30, F31, F32, F33, F34, F35, F36, F37, F38, F39, F40, F41, F42, F43, F44, F45, F46, F47, F48	
				,1 AS FAIXA                          
				,'O' AS ORIGEM                          
				,NULL AS ROMANEIO                          
				,a.preco1 AS CUSTO_NA_DATA                          
				--  ,NULL AS TIMESTAMP                          
				,'R$' AS MOEDA                          
				,1 AS CAMBIO_NA_DATA                          
				,'V' AS ORIGEM_EMB                          
				,GETDATE() AS DATA_PARA_TRANSFERENCIA                          
				,NULL AS CODIGO_LOCAL_ENTREGA                          
				,@CFOP AS CODIGO_FISCAL_OPERACAO                          
				,C.COD_FILIAL AS COD_FILIAL_ESTOQUE                          
				,0 AS CUSTO_NA_DATA_2                          
				,0 AS CUSTO_NA_DATA_3                          
				,0 AS CUSTO_NA_DATA_4                          
				,RIGHT('000000' + LTRIM(RTRIM(CAST(ROW_NUMBER() OVER(ORDER BY A.PRODUTO ASC, A.COR_PRODUTO ASC) AS VARCHAR(4)))),4) AS ITEM_IMPRESSAO                          
				,'' AS ITEM_IMPRESSAO_FATURA                          
				,NULL AS ITEM_PEDIDO                       
				,NULL AS ORDEM_PRODUCAO                          
				,0 AS PRECO_2                   
				,0 AS PRECO_3                          
				,0 AS PRECO_4                          
				,0 AS VALOR_DIFERENCA_GUIA_FATURA_ITEM                          
				,NULL AS DESC_VENDA_CLIENTE                          
				,NULL AS ID_MODIFICACAO                          
				,0 AS LICENCIADO_ROYALTIES                          
				,NULL AS ID_VENDA_ENTREGA_FUTURA                          
				,dbo.fx_producao_preco(CAST(a.preco1 * @fator_preco AS VARCHAR(12)), 'T') /* função core da Linx para calcular timestamp */                         
				from @TAB_PRODUTOS_NF_AGRUPADA a
				JOIN FILIAIS C ON C.FILIAL = @FILIAL_ORIGEM

			
				SET @ROWID += 1

			END
		
        
		-- Insiro os itens abertos por produto - cor - tamanho    

			INSERT INTO FATURAMENTO_ITEM(CLASSIF_FISCAL                          
			,CODIGO_FISCAL_OPERACAO                          
			,CODIGO_ITEM                          
			,COD_TABELA_FILHA                          
			,COMISSAO_ITEM                          
			,COMISSAO_ITEM_GERENTE                          
			,CONTA_CONTABIL                          
			,DESCONTO_ITEM                          
			,DESCRICAO_ITEM                          
			,FAIXA                          
			,FILIAL                          
			,ID_EXCECAO_IMPOSTO                          
			,INDICADOR_CFOP                          
			,ITEM_IMPRESSAO                          
			,MPADRAO_DESCONTO_ITEM                          
			,MPADRAO_PRECO_UNITARIO                          
			,MPADRAO_VALOR_ITEM                          
			,NF_SAIDA                          
			,PESO                          
			,PORCENTAGEM_ITEM_RATEIO                          
			,PRECO_UNITARIO                
			,QTDE_DEVOLVIDA                          
			,QTDE_ITEM                          
			,QTDE_RETORNAR_BENEFICIAMENTO                          
			,SERIE_NF                          
			,SUB_ITEM_TAMANHO                          
			,TRIBUT_ICMS                          
			,TRIBUT_ORIGEM                          
			,UNIDADE                          
			,VALOR_ITEM                          
			,REFERENCIA                          
			,REFERENCIA_ITEM                          
			,REFERENCIA_PEDIDO                          
			,TIMESTAMP                
			,MPADRAO_VALOR_DESCONTOS                          
			,MPADRAO_VALOR_ENCARGOS                          
			,NAO_SOMA_VALOR                          
			,OBS_ITEM                          
			,ITEM_NFE                          
			,MPADRAO_SEGURO_ITEM                          
			,MPADRAO_FRETE_ITEM                          
			,MPADRAO_ENCARGO_ITEM                          
			,RATEIO_FILIAL                       
			,RATEIO_CENTRO_CUSTO                          
			,ORIGEM_ITEM                          
			,VALOR_IMPOSTO_ITEM                          
			,INDICA_PRODUTO_PROCESSO                          
			,CODIGO_FCI                          
			,PRECO_UNITARIO_ORIGINAL           
			,CTB_TIPO_OPERACAO)                          
			SELECT		p.CLASSIF_FISCAL                          
				,@CFOP AS CODIGO_FISCAL_OPERACAO                          
				,rtrim(a.PRODUTO) AS CODIGO_ITEM                          
				,'P' AS COD_TABELA_FILHA                          
				,@comissao AS COMISSAO_ITEM                          
				,@comissao_gerente AS COMISSAO_ITEM_GERENTE                          
				--,@CONTA AS CONTA_CONTABIL      
				,p.conta_contabil                     
				,0 AS DESCONTO_ITEM                          
				,rtrim(isnull(p.DESC_PROD_NF, p.DESC_PRODUTO)) AS DESCRICAO_ITEM                          
				,1 AS FAIXA                          
				,@FILIAL AS FILIAL                          
				,DBO.FX_ID_EXCECAO_IMPOSTO (@CTB_TIPO_OPERACAO, @COD_CLIFOR, P.INDICADOR_CFOP,'S',@FILIAL, @MATRIZ_FISCAL, GETDATE(), '0', @CFOP, @PRODUTO, @NOME_CLIFOR, 'P', @NATUREZA_SAIDA, @COD_FILIAL)                 
				,P.INDICADOR_CFOP AS INDICADOR_CFOP                          
				,RIGHT('000000' + LTRIM(RTRIM(CAST(ROW_NUMBER() OVER(ORDER BY A.PRODUTO ASC) AS VARCHAR(4)))),4)  AS ITEM_IMPRESSAO                          
				,0 AS MPADRAO_DESCONTO_ITEM                          
				,A.PRECO AS MPADRAO_PRECO_UNITARIO                          
				,sum(A.preco * a.qtde) AS MPADRAO_VALOR_ITEM                          
				,'XYXZ' AS NF_SAIDA                          
				,0 AS PESO                          
				,100 * (sum(A.preco * a.qtde)/@TOT_VALOR) AS PORCENTAGEM_ITEM_RATEIO                          
				,A.PRECO AS PRECO_UNITARIO                          
				,0 AS QTDE_DEVOLVIDA                          
				,sum(a.qtde) AS QTDE_ITEM                          
				,0 AS QTDE_RETORNAR_BENEFICIAMENTO               
				,@SERIE_NF AS SERIE_NF                          
				,1 AS SUB_ITEM_TAMANHO                          
				,P.TRIBUT_ICMS AS TRIBUT_ICMS                          
				,p.TRIBUT_ORIGEM                           
				,p.UNIDADE                          
				,sum(A.preco * a.qtde)  AS VALOR_ITEM                          
				,a.produto AS REFERENCIA                          
				,null AS REFERENCIA_ITEM                          
				,NULL AS REFERENCIA_PEDIDO                          
				,DBO.FX_PRODUCAO_PRECO(CAST(A.PRECO AS VARCHAR(12)),'T') AS TIMESTAMP                          
				,0 AS MPADRAO_VALOR_DESCONTOS                          
				,0 AS MPADRAO_VALOR_ENCARGOS                          
				,0 AS NAO_SOMA_VALOR                          
				,NULL AS OBS_ITEM                          
				,'0' AS ITEM_NFE                          
				,0 AS MPADRAO_SEGURO_ITEM                          
				,0 AS MPADRAO_FRETE_ITEM                          
				,0 AS MPADRAO_ENCARGO_ITEM                          
				,@RATEIO_FILIAL AS RATEIO_FILIAL                          
				,@RATEIO_CENTRO_CUSTO AS RATEIO_CENTRO_CUSTO                          
				,'P' AS ORIGEM_ITEM                          
				,0 AS VALOR_IMPOSTO_ITEM                          
				,0 AS INDICA_PRODUTO_PROCESSO                          
				,NULL AS CODIGO_FCI                          
				,A.PRECO AS PRECO_UNITARIO_ORIGINAL                          
				,@CTB_TIPO_OPERACAO AS CTB_TIPO_OPERACAO            
				FROM FATURAMENTO_PROD A                          
				JOIN FATURAMENTO B ON A.NF_SAIDA = B.NF_SAIDA AND A.FILIAL = B.FILIAL AND A.SERIE_NF = B.SERIE_NF
				JOIN FILIAIS C ON B.FILIAL = C.FILIAL
				join produtos p on a.produto = p.produto
				join produto_cores pc on a.produto = pc.produto and a.COR_PRODUTO = pc.COR_PRODUTO
				join PRODUTOS_TAMANHOS pt on p.grade = pt.grade
				WHERE A.NF_SAIDA = 'XYXZ' AND A.SERIE_NF = @SERIE_NF AND A.FILIAL = @FILIAL and a.qtde > 0
				group by p.CLASSIF_FISCAL, a.PRODUTO, p.conta_contabil, P.INDICADOR_CFOP, A.PRECO, P.TRIBUT_ICMS, p.TRIBUT_ORIGEM, p.unidade, rtrim(isnull(p.DESC_PROD_NF, p.DESC_PRODUTO))


				select @valor = sum(valor_item) from faturamento_item WHERE NF_SAIDA = 'XYXZ'  
		
				update a set
					a.item_impressao = b.item_impressao
				from faturamento_prod a
				join faturamento_item b on a.nf_saida = b.nf_saida and a.filial = b.filial and a.serie_nf = b.serie_nf and a.produto = b.codigo_item
				where a.nf_saida = 'XYXZ'  
		
				UPDATE FATURAMENTO set
					VALOR_TOTAL = @VALOR, 
					COMISSAO_VALOR = ROUND(@VALOR * (@COMISSAO/100),2),   
					COMISSAO_VALOR_GERENTE = ROUND(@VALOR * (@COMISSAO_GERENTE/100),2) ,
					MPADRAO_VALOR_SUB_ITENS = @VALOR ,
					MPADRAO_VALOR_TOTAL = @VALOR      ,
					VALOR_SUB_ITENS = @VALOR          
				WHERE NF_SAIDA = 'XYXZ'                       

				-- ATUALIZA O NUMERO DA NOTA FISCAL
		
		 
				UPDATE faturamento_sequenciais SET SEQUENCIAL = SEQUENCIAL + 1 WHERE SERIE_NF = @SERIE_NF and filial = @filial

				UPDATE faturamento_sequenciais SET SEQUENCIAL = REPLICATE('0', 9 - LEN(LTRIM(RTRIM(SEQUENCIAL)))) + LTRIM(SEQUENCIAL) WHERE SERIE_NF = @SERIE_NF 
		
				SELECT @NF_SAIDA = SEQUENCIAL FROM faturamento_sequenciais WHERE SERIE_NF = @SERIE_NF and filial = @filial

				UPDATE FATURAMENTO SET NF_SAIDA = @NF_SAIDA WHERE NF_SAIDA = 'XYXZ'                       

				EXEC dbo.LX_GERA_IMPOSTOS_SAIDA @FILIAL, @NF_SAIDA, @SERIE_NF, 1, 0, 1             
                        
				SELECT @ANOMES = RIGHT(CAST(DATEPART(YY,GETDATE()) AS CHAR(4)),2) +                 
				CASE WHEN LEN(CAST(DATEPART(MM,GETDATE()) AS CHAR(2))) = 2                 
				THEN CAST(DATEPART(MM,GETDATE()) AS CHAR(2))                
				ELSE '0' + CAST(DATEPART(MM,GETDATE()) AS CHAR(2)) END                 
                  
				update a set
				a.item_nfe =  b.num 
				from faturamento_item a
				join 
				(
				select ROW_NUMBER() OVER(ORDER BY nf_saida ASC) as num, * from faturamento_item where nf_saida = @NF_SAIDA and serie_nf = @SERIE_NF and filial = @filial
				) b on a.nf_saida = b.nf_saida and a.filial = b.filial and a.serie_nf = b.serie_nf and a.item_impressao = b.item_impressao and a.SUB_ITEM_TAMANHO = b.SUB_ITEM_TAMANHO
				where a. nf_saida = @NF_SAIDA and a.serie_nf = @SERIE_NF and a.filial = @filial
	    
				INSERT INTO #TEMP EXEC DBO.LX_GERA_CHAVE_NFE_GENERICA @NF_SAIDA,@SERIE_NF,@CNPJ,@CIDADE,@UF_FILIAL,@ANOMES,'55',1,'4.00'                   
         
				SELECT @CHAVE_NFE = CHAVE_NF FROM #TEMP                       
                        
				UPDATE FATURAMENTO SET CHAVE_NFE = @CHAVE_NFE, DATA_HORA_EMISSAO = GETDATE(),               
				UTC_DATA_SAIDA = @UTC_FUSO, UTC_EMISSAO = @UTC_FUSO, FIN_EMISSAO_NFE = 1               
				WHERE NF_SAIDA = @NF_SAIDA AND SERIE_NF = @SERIE_NF  and filial = @filial           

				PRINT @NF_SAIDA
				print @SERIE_NF                      

				EXEC LX_CTB_INTEGRAR_FATURAMENTO @FILIAL, @NF_SAIDA, @SERIE_NF

				UPDATE FATURAMENTO_PROD SET ORIGEM = 'E' WHERE FILIAL = @FILIAL AND NF_SAIDA = @NF_SAIDA AND SERIE_NF = @SERIE_NF

				COMMIT TRANSACTION             

				/* EXCLUI A TABELA TEMPORÁRIA QUE ARMAZENOU A CHAVE DA NOTA*/
				IF OBJECT_ID('tempdb..#TEMP') IS NOT NULL
				BEGIN
					DROP TABLE #TEMP;
				END;

				/*
				Exibe mensagem de sucesso com os dados da nota fiscal
				*/
				SELECT
					CAST(1 AS INT) AS SUCESSO,
					@NF_SAIDA AS NF_SAIDA,
					@SERIE_NF AS SERIE_NF,
					@CHAVE_NFE AS CHAVE_NFE,
					CAST(NULL AS VARCHAR(2048)) AS MENSAGEM;
			END

		END TRY /* fim do bloco BEGIN TRY */

		BEGIN CATCH /* INÍCIO do bloco BEGIN CATCH tratamento de erros */

			IF XACT_STATE() <> 0
				ROLLBACK TRANSACTION;

			SELECT
				@NUMERO_ERRO = ERROR_NUMBER(),
				@MENSAGEM_ERRO = ERROR_MESSAGE(),
				@PROCEDURE_ERRO = ERROR_PROCEDURE(),
				@LINHA_ERRO = ERROR_LINE();

			SET @ERRO_APLICACAO =
				LEFT(
					N'Não foi possível gerar a nota fiscal de transferência. '
					+ N'Erro SQL '
					+ CONVERT(NVARCHAR(20), ISNULL(@NUMERO_ERRO, 0))
					+ N'. '
					+ ISNULL(@MENSAGEM_ERRO, N'')
					+ N' Procedimento: '
					+ ISNULL(@PROCEDURE_ERRO, N'')
					+ N'. Linha: '
					+ CONVERT(NVARCHAR(20), ISNULL(@LINHA_ERRO, 0)),
					2048
				);

			THROW 51000, @ERRO_APLICACAO, 1;

		END CATCH;
END;
GO

