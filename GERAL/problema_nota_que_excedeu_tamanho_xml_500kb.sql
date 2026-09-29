--SELECT * FROM faturamento_prod_97403
--SELECT * FROM faturamento_ITEM_97403
--SELECT * FROM faturamento_IMPOSTO_97403

select A.ITEM_IMPRESSAO,A.* 
from faturamento_prod A where nf_saida = '0097403' and filial='CD REGIS' AND SERIE_NF='1'
ORDER BY A.ITEM_IMPRESSAO

select * 
from faturamento_ITEM where nf_saida = '0097403' and filial='CD REGIS' AND SERIE_NF='1'

select * 
from faturamento_IMPOSTO  

SELECT  DISTINCT (PEDIDO) FROM FATURAMENTO_PROD  where nf_saida = '0097403' and filial='CD REGIS' AND SERIE_NF='1'


SELECT * FROM FATURAMENTO_CAIXAS WHERE CAIXA IN (SELECT CAIXA FROM faturamento_prod_97403)
SELECT * FROM VENDAS_PROD_EMBALADO WHERE CAIXA IN (SELECT CAIXA FROM faturamento_prod_97403)


select A.ITEM_IMPRESSAO,COUNT(*) 
from faturamento_prod A where nf_saida = '0097403' and filial='CD REGIS' AND SERIE_NF='1'
GROUP BY A.ITEM_IMPRESSAO



EXEC LX_GERA_NFE_SEFAZ_4_00 '0097403','1','CD REGIS',1 


select a.*, b.FILIAL 
from PDA_WMS_TB_EMBARQUE a 
inner join FILIAIS b on b.cod_filial = a.codigo_filial
where CAIXA IN (SELECT CAIXA FROM faturamento_prod_97403)
--AND a.FATURADO=0
--and b.filial LIKE 'SANTOS%'

select * 
into PDA_WMS_TB_EMBARQUE_SANTOS_GONZAGA_CAIXA_26nov18
from PDA_WMS_TB_EMBARQUE
where doca = 'SANTOS - GONZAGA CAIXA'
and data >= '20181126' and data <'20181127'
and caixa in (SELECT CAIXA FROM faturamento_prod_97403)
and faturado = 1

set rowcount 0
go
update pda_wms_tb_embarque set faturado = 0 
--select * from pda_wms_tb_embarque
where doca = 'SANTOS - GONZAGA CAIXA'
and data >= '20181126' and data <'20181127'
and caixa in (SELECT CAIXA FROM PDA_WMS_TB_EMBARQUE_SANTOS_GONZAGA_CAIXA_26nov18)
go

select * from pda_wms_tb_embarque (nolock)
where doca = 'SANTOS - GONZAGA CAIXA'
and data >= '20181126' and data <'20181127'
and caixa in (SELECT CAIXA FROM faturamento_prod_97403) and faturado = 1
