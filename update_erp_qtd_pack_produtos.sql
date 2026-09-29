
update p
set ERP_QTD_PACK = xuxa.qtde,
SORTIMENTO_TAMANHO = 1 
from produtos p , (
select produto, pack, sum(qtde) as qtde 
from PRODUTOS_PACKS_PERMITIDOS 
where data_para_transferencia >= '20170104'
AND PACK = 'A'
group by produto, pack ) as xuxa
where p.produto = xuxa.PRODUTO


