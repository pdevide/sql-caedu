--select * from compras where erp_cups_processo_ccf_cca = '0083/17' and TOT_QTDE_ENTREGAR>0

select * from estoque_prod_ent where pedido in (
'192721E'
,'192723'
,'198180'
,'198183'
,'203638'
,'203641'
,'203641E'
,'203642'
,'206563')


BEGIN TRAN
update compras_produto
set qtde_entregue = qtde_original, 
	qtde_entregar = 0,
	valor_entregue = valor_original,
	valor_entregar=0,
	CE1 = 0,CE2 = 0,CE3 = 0,CE4 = 0,CE5 = 0,CE6 = 0,CE7 = 0,CE8 = 0,CE9 = 0,CE10 = 0,CE11 = 0,CE12 = 0,CE13 = 0,CE14 = 0,CE15 = 0,CE16 = 0
WHERE PEDIDO IN (
'192721E'
,'192723'
,'198180'
,'198183'
,'203638'
,'203641'
,'203641E'
,'203642'
,'206563');

UPDATE COMPRAS
SET TOT_QTDE_ENTREGAR=0,TOT_VALOR_ENTREGAR=0
WHERE PEDIDO IN (
'192721E'
,'192723'
,'198180'
,'198183'
,'203638'
,'203641'
,'203641E'
,'203642'
,'206563');

COMMIT



