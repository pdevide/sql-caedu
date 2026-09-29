select * 
from trigger_portal where data_alteracao>'20180430'order by pedido, data_alteracao desc


select * from CAEDU_LOG_AUTORIZA_COMPRAS
select * from CAEDU_LOG_AUTORIZA_COMPRAS_ITEM WHERE DATA_LOG>'20180430' --AND COD_METRICA='04' ORDER BY PEDIDO


compras_produto
--select * from CAEDU_LOG_AUTORIZA_COMPRAS_STATUS

update compras_produto set ERP_CUPS_CUSTO_FOB_MINIMO=1 where pedido = 'x'

update compras_produto set ERP_CUPS_CUSTO_FOB_MINIMO=2.15 where pedido = '184658'
update compras_produto set ERP_CUPS_CUSTO_FOB_MINIMO=2.15 where pedido = '184659'
update compras_produto set ERP_CUPS_CUSTO_FOB_MINIMO=1.6 where pedido = '184660'
update compras_produto set ERP_CUPS_CUSTO_FOB_MINIMO=1.6 where pedido = '184661'
update compras_produto set ERP_CUPS_CUSTO_FOB_MINIMO=1.15 where pedido = '184662'
update compras_produto set ERP_CUPS_CUSTO_FOB_MINIMO=1.15 where pedido = '184663'
update compras_produto set ERP_CUPS_CUSTO_FOB_MINIMO=1.1 where pedido = '184664'
update compras_produto set ERP_CUPS_CUSTO_FOB_MINIMO=1.1 where pedido = '184665'
update compras_produto set ERP_CUPS_CUSTO_FOB_MINIMO=1.1 where pedido = '184666'
update compras_produto set ERP_CUPS_CUSTO_FOB_MINIMO=1.35 where pedido = '184667'
update compras_produto set ERP_CUPS_CUSTO_FOB_MINIMO=1.35 where pedido = '184668'



Código : 061009900014001           erro : Item sem Preço 
Código : D90202180010905D Erro : código de barra não encontrado !!!
Código : D90202170014705D Erro : código de barra não encontrado !!!

select * from produtos_barra where codigo_barra = 'D90202170014705D'

select * from produtos_precos where produto = '06100990'

insert into produtos_precos (codigo_tab_preco, produto, preco1, preco2, preco3, preco4, limite_desconto, promocao_desconto, ult_atualizacao, data_para_transferencia)
values ('02', '06100990', 27, 0, 0, 0, 0, 0, '20180626', getdate())





select * from produtos_barra where produto = 'D9020217'

insert into produtos_barra (CODIGO_BARRA, PRODUTO, COR_PRODUTO, TAMANHO, GRADE, DATA_PARA_TRANSFERENCIA, CODIGO_BARRA_PADRAO, INATIVO, TIPO_COD_BAR, LX_STATUS_REGISTRO)
select rtrim(CODIGO_BARRA)+'D', PRODUTO, COR_PRODUTO, TAMANHO, GRADE, DATA_PARA_TRANSFERENCIA, CODIGO_BARRA_PADRAO, INATIVO, TIPO_COD_BAR, LX_STATUS_REGISTRO 
from produtos_barra where produto = 'D9020217'
