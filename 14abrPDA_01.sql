SELECT PRODUTO
FROM (
select a.CAIXA, A.PRODUTO,
B.CAIXA AS EMBALADO
from [ccp\paulo.devide].PDA_WMS_VOLUMES_FATURAR_ABRIL_25 a
LEFT JOIN VENDAS_PROD_EMBALADO B ON B.CAIXA = A.CAIXA
WHERE B.CAIXA IS not NULL
) TAB
GROUP BY PRODUTO

/*
44160061
51043939
53022322
53022326
55060645
55060646
60010256
83010157
83010160
83010161
83010162
BE080015
D6041705
N2030323
Z1020151
*/

SELECT P.PRODUTO,P.GRADE,P.ERP_QTD_PACK, PR.PRECO1, B.PACK, B.QTDE, B.COR_PRODUTO, 
Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10
,Q11,Q12,Q13,Q14,Q15,Q16
FROM PRODUTOS P
LEFT JOIN PRODUTOS_PACKS_PERMITIDOS B ON B.PRODUTO = P.PRODUTO
LEFT JOIN PRODUTOS_PRECOS PR ON PR.PRODUTO = P.PRODUTO AND PR.CODIGO_TAB_PRECO='02'
WHERE P.PRODUTO IN (
'44160061',
'51043939',
'60010256',
'BE080015',
'D6041705',
'N2030323',
'Z1020151'
)
ORDER BY P.PRODUTO,B.PACK

select tt.caixa, tt.produto
from (
SELECT A.*,
tem_faturamento_prod = CASE WHEN EXISTS (SELECT 1 FROM FATURAMENTO_PROD WHERE caixa = a.caixa) THEN 1 ELSE 0 END,
tem_faturamento_caixas = CASE WHEN EXISTS (SELECT 1 FROM FATURAMENTO_CAIXAS WHERE caixa = a.caixa) THEN 1 ELSE 0 END,
tem_vendas_prod_embalado = CASE WHEN EXISTS (SELECT 1 FROM VENDAS_PROD_EMBALADO WHERE caixa = a.caixa) THEN 1 ELSE 0 END
FROM  [ccp\paulo.devide].PDA_WMS_VOLUMES_FATURAR_ABRIL_25 a where a.qtde>0
--and a.PRODUTO IN (
--'44160061',
--'51043939',
--'60010256',
--'BE080015',
--'D6041705',
--'N2030323',
--'Z1020151'
--)
) tt
where tt.tem_vendas_prod_embalado=0


select a.*
from [ccp\paulo.devide].PDA_WMS_VOLUMES_FATURAR_ABRIL_25 a
where a.PRODUTO = 'N2030323'    

select * from produtos_packs_permitidos where produto in (
'60010256',
'44160061',
'BE080015')



SELECT tab1.*, 'CX-'+RTRIM(LTRIM(CAIXA)) AS VENDA, 1 AS QTDE_PACK, 'CD - SP - SAO ROQUE' AS FILIAL_ORIGEM, lojadestino AS FILIAL,
quantas_cores_packs = (SELECT COUNT(*) FROM PRODUTOS_PACKS_PERMITIDOS WHERE produto = tab1.produto),
p.grade, p.erp_qtd_pack, p.TRIBUT_ORIGEM, pp.*, PPC.PRECO1 AS CUSTO_1
FROM (
SELECT A.*,
tem_faturamento_prod = CASE WHEN EXISTS (SELECT 1 FROM FATURAMENTO_PROD WHERE caixa = a.caixa) THEN 1 ELSE 0 END,
tem_faturamento_caixas = CASE WHEN EXISTS (SELECT 1 FROM FATURAMENTO_CAIXAS WHERE caixa = a.caixa) THEN 1 ELSE 0 END,
tem_vendas_prod_embalado = CASE WHEN EXISTS (SELECT 1 FROM VENDAS_PROD_EMBALADO WHERE caixa = a.caixa) THEN 1 ELSE 0 END
FROM  [ccp\paulo.devide].PDA_WMS_VOLUMES_FATURAR_ABRIL_25 a where a.qtde>0) as tab1
INNER JOIN PRODUTOS p ON p.produto = tab1.produto
INNER JOIN PRODUTOS_PACKS_PERMITIDOS pp ON pp.produto = tab1.produto and pp.qtde>0
INNER JOIN PRODUTOS_PRECOS PPC ON PPC.PRODUTO = TAB1.PRODUTO AND PPC.CODIGO_TAB_PRECO='02'
WHERE tab1.tem_faturamento_prod = 0 AND tab1.tem_vendas_prod_embalado=0 AND lojadestino<>'' --AND TAB1.TEM_FATURAMENTO_CAIXAS=0
AND (SELECT COUNT(*) FROM PRODUTOS_PACKS_PERMITIDOS WHERE produto = tab1.produto)=1
AND (TAB1.QTDE % PP.QTDE = 0)

select * from estoque_produtos 
where 
filial = 'CD - SP - SAO ROQUE' AND produto in (
'60010256',
'44160061',
'BE080015')

select COR_PRODUTO,PACK,* from produtos_packs_permitidos where produto in (
'60010256',
'44160061',
'BE080015')

delete from faturamento_caixas where caixa = '31169625'


select * from cadastro_cli_for where nome_clifor like 'DF  RUA TAGUATINGA'


select * 
update a set lojadestino = 'DF  RUA TAGUATINGA'
FROM  [ccp\paulo.devide].PDA_WMS_VOLUMES_FATURAR_ABRIL_25 a where caixa ='31169625'
'DF  RUA TAGUATINGA'



select * from vendas_prod_embalado where entrega='20250414'

select count(*) from vendas_prod_embalado where caixa in (
select caixa  from caedu_reserva_automatica_pack_wms where distribuicao = '00033492')

select count(caixa)  from caedu_reserva_automatica_pack_wms where distribuicao = '00033492'

select * from caedu_reserva_automatica_pack_wms where caixa = '31600178'

select *  from caedu_reserva_automatica_pack_wms where distribuicao = '00033492' and filial='BARREIRO'

SELECT * FROM PRODUTOS WHERE PRODUTO = '34016278'


LX_GERA_VENDAS_WMS  '00033492'


SELECT * FROM PDA_WMS_TB_EMBARQUE WHERE CAIXA IN (
select CAIXA  from caedu_reserva_automatica_pack_wms where distribuicao = '00033492')
