select tab1.*, (qtd_caixas - faturadas) [nao faturadas]
from 
(
select convert(varchar,data,112) as data,
count(a.caixa) as qtd_caixas,
count(b.caixa) as faturadas
from pda_wms_tb_embarque a
left join faturamento_prod b on b.caixa = a.caixa
where data>'20250101'
group by convert(varchar,data,112)
) as tab1
order by 1

select a.CAIXA as caixa_pda,
a.DOCA,
a.CODIGO_FILIAL,
a.DATA,
a.FATURADO,
convert(varchar,a.data,112) as Data1,
b.nf_saida, 
c.nome_clifor,
b.caixa as caixa_linx
from PDA_WMS_TB_EMBARQUE a 
left join FATURAMENTO_PROD b on b.caixa = a.caixa
left join FATURAMENTO c ON c.NF_SAIDA=b.NF_SAIDA AND c.filial=b.filial and c.SERIE_NF=b.SERIE_NF
where data>'20250101'
order by a.data, a.doca



select * from [ccp\paulo.devide].[tb_pda_wms_estoque_caixas]
where caixa  in ('30211087','30211088','30211089')



/*
SELECT tab1.*, 'CX-'+RTRIM(LTRIM(CAIXA)) AS VENDA, 1 AS QTDE_PACK, 'CD - SP - SAO ROQUE' AS FILIAL_ORIGEM, lojadestino AS FILIAL,
	quantas_cores_packs = (SELECT COUNT(*) FROM PRODUTOS_PACKS_PERMITIDOS WHERE produto = tab1.produto),
	p.grade, p.erp_qtd_pack, p.TRIBUT_ORIGEM, pp.*, PPC.PRECO1 AS CUSTO_1
FROM (
	SELECT A.*,
	tem_faturamento_prod = CASE WHEN EXISTS (SELECT 1 FROM FATURAMENTO_PROD WHERE caixa = a.caixa) THEN 1 ELSE 0 END,
	tem_faturamento_caixas = CASE WHEN EXISTS (SELECT 1 FROM FATURAMENTO_CAIXAS WHERE caixa = a.caixa) THEN 1 ELSE 0 END,
	tem_vendas_prod_embalado = CASE WHEN EXISTS (SELECT 1 FROM VENDAS_PROD_EMBALADO WHERE caixa = a.caixa) THEN 1 ELSE 0 END
	FROM  [ccp\paulo.devide].[tb_pda_wms_estoque_caixas_2] a where a.qtde>0) as tab1
INNER JOIN PRODUTOS p ON p.produto = tab1.produto
INNER JOIN PRODUTOS_PACKS_PERMITIDOS pp ON pp.produto = tab1.produto and pp.qtde>0
INNER JOIN PRODUTOS_PRECOS PPC ON PPC.PRODUTO = TAB1.PRODUTO AND PPC.CODIGO_TAB_PRECO='02'
WHERE tab1.tem_faturamento_prod = 0 AND tab1.tem_vendas_prod_embalado=0 AND lojadestino<>'' AND TAB1.TEM_FATURAMENTO_CAIXAS=0
	AND (SELECT COUNT(*) FROM PRODUTOS_PACKS_PERMITIDOS WHERE produto = tab1.produto)>1
	AND (TAB1.QTDE % PP.QTDE = 0)
*/