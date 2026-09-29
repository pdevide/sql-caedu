SELECT p.produto, p.data_para_transferencia, 
p.erp_data_atualizacao, p.erp_cups_stylenumber, 
	P.FABRICANTE, P.REFER_FABRICANTE
FROM PRODUTOS P
WHERE ISNULL(DATA_UMODE,'') != ''
and P.PRODUTO = '18030370'    
--AND P.ERP_CUPS_STYLENUMBER IS NULL

select * 
--update pp set preco1=20.04
from PRODUTOS_PRECOS pp
where produto = '18030370' and CODIGO_TAB_PRECO='00'

