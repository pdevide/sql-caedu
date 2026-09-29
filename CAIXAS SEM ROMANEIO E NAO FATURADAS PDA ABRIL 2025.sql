SELECT tab1.*, 'CX-'+RTRIM(LTRIM(CAIXA)) AS VENDA, 1 AS QTDE_PACK, 'CD - SP - SAO ROQUE' AS FILIAL_ORIGEM, lojadestino AS FILIAL,
	quantas_cores_packs = (SELECT COUNT(*) FROM PRODUTOS_PACKS_PERMITIDOS WHERE produto = tab1.produto),
	p.grade, p.erp_qtd_pack, p.TRIBUT_ORIGEM, pp.*, PPC.PRECO1 AS CUSTO_1
FROM (
	SELECT A.*,
	tem_faturamento_prod = CASE WHEN EXISTS (SELECT 1 FROM FATURAMENTO_PROD WHERE caixa = a.caixa) THEN 1 ELSE 0 END,
	tem_faturamento_caixas = CASE WHEN EXISTS (SELECT 1 FROM FATURAMENTO_CAIXAS WHERE caixa = a.caixa) THEN 1 ELSE 0 END,
	tem_vendas_prod_embalado = CASE WHEN EXISTS (SELECT 1 FROM VENDAS_PROD_EMBALADO WHERE caixa = a.caixa) THEN 1 ELSE 0 END
	FROM  [ccp\paulo.devide].[tb_pda_wms_estoque_caixas_2] a) as tab1
INNER JOIN PRODUTOS p ON p.produto = tab1.produto
INNER JOIN PRODUTOS_PACKS_PERMITIDOS pp ON pp.produto = tab1.produto
INNER JOIN PRODUTOS_PRECOS PPC ON PPC.PRODUTO = TAB1.PRODUTO AND PPC.CODIGO_TAB_PRECO='02'
WHERE tab1.tem_faturamento_prod = 0 AND tab1.tem_vendas_prod_embalado=0 AND lojadestino<>'' AND TAB1.TEM_FATURAMENTO_CAIXAS=0
	AND (SELECT COUNT(*) FROM PRODUTOS_PACKS_PERMITIDOS WHERE produto = tab1.produto)=1