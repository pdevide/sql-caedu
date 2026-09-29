--select 'insert into @tabela1 (caixa) values ('+char(39)+rtrim(caixa_pda)+char(39)+')'
--from [ccp\paulo.devide].[vw_caixas_nao_faturadas_pda]
--where filial = 'CARAPICUIBA'


--SELECT tab1.*, CAIXA_PDA AS CAIXA,filial as lojadestino, 'CX-'+RTRIM(LTRIM(CAIXA_PDA)) AS VENDA, 1 AS QTDE_PACK, 'CD - SP - SAO ROQUE' AS FILIAL_ORIGEM,
--quantas_cores_packs = (SELECT COUNT(*) FROM PRODUTOS_PACKS_PERMITIDOS WHERE produto = tab1.produto),
--p.grade, p.erp_qtd_pack, p.TRIBUT_ORIGEM, pp.*, PPC.PRECO1 AS CUSTO_1
--FROM (
--SELECT A.*,
--tem_faturamento_prod = CASE WHEN EXISTS (SELECT 1 FROM FATURAMENTO_PROD WHERE caixa = a.caixa_pda) THEN 1 ELSE 0 END,
--tem_faturamento_caixas = CASE WHEN EXISTS (SELECT 1 FROM FATURAMENTO_CAIXAS WHERE caixa = a.caixa_pda) THEN 1 ELSE 0 END,
--tem_vendas_prod_embalado = CASE WHEN EXISTS (SELECT 1 FROM VENDAS_PROD_EMBALADO WHERE caixa = a.caixa_pda) THEN 1 ELSE 0 END
--from [ccp\paulo.devide].[vw_caixas_nao_faturadas_pda] a
--where filial = 'BARREIRO') as tab1
--INNER JOIN PRODUTOS p ON p.produto = tab1.produto
--INNER JOIN PRODUTOS_PACKS_PERMITIDOS pp ON pp.produto = tab1.produto and pp.qtde>0
--INNER JOIN PRODUTOS_PRECOS PPC ON PPC.PRODUTO = TAB1.PRODUTO AND PPC.CODIGO_TAB_PRECO='02'
--WHERE tab1.tem_faturamento_prod = 0
--AND (SELECT COUNT(*) FROM PRODUTOS_PACKS_PERMITIDOS WHERE produto = tab1.produto)=1
--AND (TAB1.QTDE_TOTAL % PP.QTDE = 0)


EXEC [ccp\paulo.devide].[lx_exclui_romaneios_pda_por_filial] 'JARDIM IGUATEMI'


select rtrim(caixa) as caixa --'insert into @tabela1 (caixa) values ('+char(39)+rtrim(caixa_pda)+char(39)+')'
from [ccp\paulo.devide].[vw_caixas_nao_faturadas_pda] a
inner join VENDAS_PROD_EMBALADO b on b.caixa = a.caixa_pda
where a.filial = 'MOGI DAS CRUZES' and b.produto NOT IN ('N2030324','58100131')


--lx_processos

