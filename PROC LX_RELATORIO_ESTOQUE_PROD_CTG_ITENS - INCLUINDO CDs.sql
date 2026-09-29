USE [CAEDU]
GO
/****** Object:  StoredProcedure [dbo].[LX_RELATORIO_ESTOQUE_PROD_CTG_ITENS]    Script Date: 13/03/2020 15:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[LX_RELATORIO_ESTOQUE_PROD_CTG_ITENS] 
@PFILIAL VARCHAR(25) = NULL, 
@PAPAGAR_TEMP BIT = 1
AS
SET NOCOUNT ON
DECLARE @CURRENT_YEAR INT
SELECT @CURRENT_YEAR = DATEPART(YY,GETDATE())
DECLARE @TAB_CONTAGEM TABLE (REGN INT IDENTITY(1,1), ID_CONTAGEM INT, FILIAL VARCHAR(25), NOME_CONTAGEM VARCHAR(25), EMISSAO DATETIME)

INSERT INTO @TAB_CONTAGEM
SELECT ROW_NUMBER() OVER(PARTITION BY filial ORDER BY FILIAL, EMISSAO DESC ) 
    AS ID_CONTAGEM,
FILIAL, NOME_CONTAGEM, EMISSAO FROM ESTOQUE_PROD_CONTAGEM 
WHERE YEAR(EMISSAO) = @CURRENT_YEAR
ORDER BY FILIAL, EMISSAO DESC 

DECLARE @LOJAS TABLE (ID INT IDENTITY(1,1), CODIGO_FILIAL CHAR(6), FILIAL VARCHAR(25))
INSERT INTO @LOJAS

SELECT DISTINCT A.CODIGO_FILIAL, FILIAL 
FROM LOJA_VENDA A 
INNER JOIN FILIAIS B ON B.COD_FILIAL = A.CODIGO_FILIAL
WHERE YEAR(DATA_VENDA)>=YEAR(GETDATE()) AND B.FILIAL = ISNULL(@PFILIAL, B.FILIAL)

UNION ALL 
/*ADICIONA OS CDs de SAO PAULO e SANTA CATARINA*/
SELECT COD_FILIAL, FILIAL
FROM FILIAIS
WHERE FILIAL IN ('CD CAJAMAR','CD BARRA VELHA','CD NAVEGANTES')


DECLARE @I INT = 1
DECLARE @TOTLOJAS INT
SELECT @TOTLOJAS = MAX(ID) FROM @LOJAS

DECLARE @FILIAL VARCHAR(25) 
DECLARE @NOME_CONTAGEM VARCHAR(25)
DECLARE @EMISSAO DATETIME

DECLARE @REPORT_NUM uniqueidentifier = NEWID()
DECLARE @PRECO1 NUMERIC(14,2) = 0.00
DECLARE @PRODUTO CHAR(12) = ''

DECLARE @TAB_CONTAGEM_FILIAIS TABLE (NOME_CONTAGEM VARCHAR(25), FILIAL VARCHAR(25), EMISSAO DATETIME)

WHILE @I <= @TOTLOJAS
BEGIN

	-- PEGA A FILIAL A SER PROCESSADA
	SELECT @FILIAL = FILIAL 
	FROM @LOJAS 
	WHERE ID = @I


	-- PEGA O ULTIMO INVENTARIO MAIS RECENTE
	/* --- não pega mais o ultimo inventário mais recente. Agora pega todos que ocorreram no ano corrente - comentado em 30-09-2019
	SELECT @NOME_CONTAGEM = NOME_CONTAGEM, @EMISSAO = EMISSAO
	FROM @TAB_CONTAGEM 
	WHERE FILIAL = @FILIAL AND ID_CONTAGEM = 1 
	*/

	--select a.preco1  
	--	from produtos_precos a 
	--	where a.codigo_tab_preco  
	--	in (select x.codigo_tab_preco from TABELAS_PRECO x where x.codigo_tab_preco in  
	--	(select valor_atual from PARAMETROS_LOJA , FILIAIS  
	--	where PARAMETROS_LOJA.CODIGO_FILIAL = FILIAIS.COD_FILIAL 
	--	and filiais.FILIAL = @FILIAL and PARAMETROS_LOJA.PARAMETRO = 'codigo_tab_preco') AND PRODUTO = @PRODUTO) 

	/* APAGA OS DADOS DA @TAB_CONTAGEM_FILIAIS --> 30-SET-2019 */
	DELETE FROM @TAB_CONTAGEM_FILIAIS
	/* INSERE AS CONTAGEM QUE FORAM FEITAS NO ULTIMO ANO CORRENTE NA TABELA @TAB_CONTAGEM_FILIAIS --> 30-SET-2019 */
	INSERT INTO @TAB_CONTAGEM_FILIAIS
	SELECT NOME_CONTAGEM, FILIAL, EMISSAO 
	FROM @TAB_CONTAGEM 
	WHERE FILIAL = @FILIAL

	INSERT INTO RELATORIO_ESTOQUE_PROD_CTG_ITENS 
	SELECT     @REPORT_NUM AS REPORT_NUM,
			   /*@FILIAL*/ TCF.FILIAL AS FILIAL,
			   /*@EMISSAO */ TCF.EMISSAO AS EMISSAO,
			   estoque_prod_ctg_itens.produto, 
			   estoque_prod_ctg_itens.cor_produto, 
			   estoque_prod_ctg_itens.nome_contagem, 
			   estoque_prod_ctg_itens.qtde_contagem, 
			   estoque_prod_ctg_itens.saldo_contagem, 
			   qtde_contagem-saldo_contagem AS diferenca_total, 
			   estoque_prod_ctg_itens.q1, 
			   estoque_prod_ctg_itens.q2, 
			   estoque_prod_ctg_itens.q3, 
			   estoque_prod_ctg_itens.q4, 
			   estoque_prod_ctg_itens.q5, 
			   estoque_prod_ctg_itens.q6, 
			   estoque_prod_ctg_itens.q7, 
			   estoque_prod_ctg_itens.q8, 
			   estoque_prod_ctg_itens.q9, 
			   estoque_prod_ctg_itens.q10, 
			   estoque_prod_ctg_itens.q11, 
			   estoque_prod_ctg_itens.q12, 
			   estoque_prod_ctg_itens.q13, 
			   estoque_prod_ctg_itens.q14, 
			   estoque_prod_ctg_itens.q15, 
			   estoque_prod_ctg_itens.q16, 
			   0 AS q17, 
			   0 AS q18, 
			   0 AS q19, 
			   0 AS q20, 
			   0 AS q21, 
			   0 AS q22, 
			   0 AS q23, 
			   0 AS q24, 
			   0 AS q25, 
			   0 AS q26, 
			   0 AS q27, 
			   0 AS q28, 
			   0 AS q29, 
			   0 AS q30, 
			   0 AS q31, 
			   0 AS q32, 
			   0 AS q33, 
			   0 AS q34, 
			   0 AS q35, 
			   0 AS q36, 
			   0 AS q37, 
			   0 AS q38, 
			   0 AS q39, 
			   0 AS q40, 
			   0 AS q41, 
			   0 AS q42, 
			   0 AS q43, 
			   0 AS q44, 
			   0 AS q45, 
			   0 AS q46, 
			   0 AS q47, 
			   0 AS q48, 
			   estoque_prod_ctg_itens.s1, 
			   estoque_prod_ctg_itens.s2, 
			   estoque_prod_ctg_itens.s3, 
			   estoque_prod_ctg_itens.s4, 
			   estoque_prod_ctg_itens.s5, 
			   estoque_prod_ctg_itens.s6, 
			   estoque_prod_ctg_itens.s7, 
			   estoque_prod_ctg_itens.s8, 
			   estoque_prod_ctg_itens.s9, 
			   estoque_prod_ctg_itens.s10, 
			   estoque_prod_ctg_itens.s11, 
			   estoque_prod_ctg_itens.s12, 
			   estoque_prod_ctg_itens.s13, 
			   estoque_prod_ctg_itens.s14, 
			   estoque_prod_ctg_itens.s15, 
			   estoque_prod_ctg_itens.s16, 
			   0 AS s17, 
			   0 AS s18, 
			   0 AS s19, 
			   0 AS s20, 
			   0 AS s21, 
			   0 AS s22, 
			   0 AS s23, 
			   0 AS s24, 
			   0 AS s25, 
			   0 AS s26, 
			   0 AS s27, 
			   0 AS s28, 
			   0 AS s29, 
			   0 AS s30, 
			   0 AS s31, 
			   0 AS s32, 
			   0 AS s33, 
			   0 AS s34, 
			   0 AS s35, 
			   0 AS s36, 
			   0 AS s37, 
			   0 AS s38, 
			   0 AS s39, 
			   0 AS s40, 
			   0 AS s41, 
			   0 AS s42, 
			   0 AS s43, 
			   0 AS s44, 
			   0 AS s45, 
			   0 AS s46, 
			   0 AS s47, 
			   0 AS s48, 
			   produtos.desc_produto, 
			   produtos.grupo_produto, 
			   produtos.subgrupo_produto, 
			   produtos.grade, 
			   produtos.unidade, 
			   produtos.peso, 
			   produtos.revenda, 
			   produto_cores.desc_cor_produto, 
			   produto_cores.cor_sortida, 
			   produto_cores.cor_fabricante, 
			   produtos.refer_fabricante, 
			   estoque_prod_ctg_itens.q1-estoque_prod_ctg_itens.s1 AS d1, 
			   q2                       -s2                        AS d2, 
			   q3                       -s3                        AS d3, 
			   q4                       -s4                        AS d4, 
			   q5                       -s5                        AS d5, 
			   q6                       -s6                        AS d6, 
			   q7                       -s7                        AS d7, 
			   q8                       -s8                        AS d8, 
			   q9                       -s9                        AS d9, 
			   q10                      -s10                       AS d10, 
			   q11                      -s11                       AS d11, 
			   q12                      -s12                       AS d12, 
			   q13                      -s13                       AS d13, 
			   q14                      -s14                       AS d14, 
			   q15                      -s15                       AS d15, 
			   q16                      -s16                       AS d16, 
			   q17                      -s17                       AS d17, 
			   q18                      -s18                       AS d18, 
			   q19                      -s19                       AS d19, 
			   q20                      -s20                       AS d20, 
			   q21                      -s21                       AS d21, 
			   q22                      -s22                       AS d22, 
			   q23                      -s23                       AS d23, 
			   q24                      -s24                       AS d24, 
			   q25                      -s25                       AS d25, 
			   q26                      -s26                       AS d26, 
			   q27                      -s27                       AS d27, 
			   q28                      -s28                       AS d28, 
			   q29                      -s29                       AS d29, 
			   q30                      -s30                       AS d30, 
			   q31                      -s31                       AS d31, 
			   q32                      -s32                       AS d32, 
			   q33                      -s33                       AS d33, 
			   q34                      -s34                       AS d34, 
			   q35                      -s35                       AS d35, 
			   q36                      -s36                       AS d36, 
			   q37                      -s37                       AS d37, 
			   q38                      -s38                       AS d38, 
			   q39                      -s39                       AS d39, 
			   q40                      -s40                       AS d40, 
			   q41                      -s41                       AS d41, 
			   q42                      -s42                       AS d42, 
			   q43                      -s43                       AS d43, 
			   q44                      -s44                       AS d44, 
			   q45                      -s45                       AS d45, 
			   q46                      -s46                       AS d46, 
			   q47                      -s47                       AS d47, 
			   q48                      -s48                       AS d48, 
			   produtos.ponteiro_preco_tam, 
			   produtos.varia_preco_cor, 
			   produtos.varia_preco_tam, 
			   produto_cores.custo_reposicao1, 
			   produto_cores.custo_reposicao2, 
			   produto_cores.custo_reposicao3, 
			   --produto_cores.custo_reposicao4, 
			   (select TOP 1 ISNULL(a.preco1, 0.00)  
					from produtos_precos a 
					where a.codigo_tab_preco  
					in (select x.codigo_tab_preco from TABELAS_PRECO x where x.codigo_tab_preco in  
					(select valor_atual from PARAMETROS_LOJA , FILIAIS  
					where PARAMETROS_LOJA.CODIGO_FILIAL = FILIAIS.COD_FILIAL 
					and filiais.FILIAL = @FILIAL and PARAMETROS_LOJA.PARAMETRO = 'codigo_tab_preco') 
					AND PRODUTO = estoque_prod_ctg_itens.produto) ) AS custo_reposicao4,
			   estoque_produtos.custo_medio1, 
			   estoque_produtos.custo_medio2, 
			   estoque_produtos.custo_medio3, 
			   estoque_produtos.custo_medio4, 
			   CONVERT(NUMERIC(14,2),0) AS custo4_a_valorizar, 
			   CONVERT(NUMERIC(14,2),0) AS custo3_a_valorizar, 
			   CONVERT(NUMERIC(14,2),0) AS custo2_a_valorizar, 
			   CONVERT(NUMERIC(14,2),0) AS custo1_a_valorizar, 
			   CONVERT(NUMERIC(14,2),0) AS valor_contagem_diferenca, 
			   produtos.linha, 
			   produtos.griffe , 
			   estoque_prod_ctg_itens.erp_justificativa 
	FROM       estoque_prod_ctg_itens 
	INNER JOIN produtos 
	ON         estoque_prod_ctg_itens.produto = produtos.produto 
	INNER JOIN produto_cores 
	ON         estoque_prod_ctg_itens.produto = produto_cores.produto 
	AND        estoque_prod_ctg_itens.cor_produto = produto_cores.cor_produto 
	INNER JOIN estoque_prod_contagem 
	ON         estoque_prod_ctg_itens.nome_contagem = estoque_prod_contagem.nome_contagem 
	LEFT JOIN  estoque_produtos 
	ON         estoque_prod_ctg_itens.produto = estoque_produtos.produto 
	AND        estoque_prod_ctg_itens.cor_produto = estoque_produtos.cor_produto 
	AND        estoque_prod_contagem.filial = estoque_produtos.filial 
	INNER JOIN @TAB_CONTAGEM_FILIAIS TCF ON TCF.NOME_CONTAGEM = estoque_prod_contagem.nome_contagem AND TCF.FILIAL = estoque_prod_contagem.FILIAL 
	--WHERE      estoque_prod_ctg_itens.nome_contagem IN (SELECT NOME_CONTAGEM FROM @TAB_CONTAGEM_FILIAIS) 
	ORDER BY   estoque_prod_ctg_itens.produto, 
			   estoque_prod_ctg_itens.cor_produto

	-- INCREMENTA O CONTADOR DE REGISTRO PARA IR PARA A PROXIMA FILIAL
	SET @I = @I + 1

END

SELECT 	[nome_contagem],
		RELATORIO_ESTOQUE_PROD_CTG_ITENS.filial,
		[EMISSAO],
		[EMISSAO2],
		[Griffe],	
		[Linha],	
		[Produto],	
		cor_produto as [Cor],	
		qtde_contagem as [Qtde Ctg],	
		SALDO_CONTAGEM as [Saldo],	
		diferenca_total as [Diferença],	
		VALOR_CONTAGEM_DIFERENCA as [Valor da contagem],	
		isnull(q1,0) + isnull(q2,0) + isnull(q3,0) + isnull(q4,0) + isnull(q5,0) + isnull(q6,0) + isnull(q7,0) 
		+ isnull(q8,0) + isnull(q9,0) + isnull(q10,0) + isnull(q11,0) + isnull(q12,0) + isnull(q13,0) 
		+ isnull(q14,0) + isnull(q15,0) + isnull(q16,0)  [Quantidade por tamanhos],	
		isnull(s1,0) + isnull(s2,0) + isnull(s3,0) + isnull(s4,0) + isnull(s5,0) + isnull(s6,0) + isnull(s7,0) 
		+ isnull(s8,0) + isnull(s9,0) + isnull(s10,0) + isnull(s11,0) + isnull(s12,0) + isnull(s13,0) 
		+ isnull(s14,0) + isnull(s15,0) + isnull(s16,0)  [Saldo por tamanhos],	
		DESC_PRODUTO as [Desc Produto],	
		DESC_COR_PRODUTO as [Desc Cor Produto],	
		[Unidade],	
		[Peso],	
		refer_fabricante as [Refer Fabricante],	
		[Revenda],	
		cor_sortida as [Cor Sortida],	
		CUSTO1_A_VALORIZAR as [Custo1 A Valorizar],	
		CUSTO2_A_VALORIZAR as [Custo2 A Valorizar],	
		CUSTO3_A_VALORIZAR as [Custo3 A Valorizar],	
		CUSTO4_A_VALORIZAR as [Custo4 A Valorizar],	
		GRUPO_PRODUTO as [Grupo Produto],	
		SUBGRUPO_PRODUTO as [Subgrupo Produto],	
		CUSTO_REPOSICAO1 as [Custo Reposicao1],	
		CUSTO_REPOSICAO4 as [Custo Reposicao4],
		diferenca_total * CUSTO_REPOSICAO1 as [DIVERGENCIA],
		F.COD_FILIAL
FROM RELATORIO_ESTOQUE_PROD_CTG_ITENS
INNER JOIN FILIAIS F 
	ON F.FILIAL = RELATORIO_ESTOQUE_PROD_CTG_ITENS.FILIAL
WHERE REPORT_NUM = @REPORT_NUM
ORDER BY REPORT_NUM, NOME_CONTAGEM, PRODUTO, COR_PRODUTO

IF @PAPAGAR_TEMP=1
BEGIN
	DELETE FROM RELATORIO_ESTOQUE_PROD_CTG_ITENS
	WHERE REPORT_NUM = @REPORT_NUM
END
SET NOCOUNT OFF

