select * from compras where erp_cups_processo_ccf_cca = '0066/18' and TOT_QTDE_ENTREGAR=0 

select * from compras_produto where pedido ='179721'  

BEGIN TRAN
update compras_produto
set qtde_entregue = 0, 
	qtde_entregar = QTDE_ORIGINAL,
	valor_entregue = 0,
	valor_entregar=valor_original,
	CE1 = CO1,CE2 = CO2,CE3 = CO3,CE4 = CO4,CE5 = CO5,CE6 = CO6,CE7 = CO7,CE8 = CO8,CE9 = CO9,CE10 = CO10,CE11 = CO11,CE12 = CO12,CE13 = CO13,CE14 = CO14,CE15 = CO15,CE16 = CO16
WHERE PEDIDO = '179730E'


UPDATE COMPRAS
SET TOT_QTDE_ENTREGAR=TOT_QTDE_ORIGINAL,TOT_VALOR_ENTREGAR=TOT_VALOR_ORIGINAL
WHERE PEDIDO = '179730E'

COMMIT