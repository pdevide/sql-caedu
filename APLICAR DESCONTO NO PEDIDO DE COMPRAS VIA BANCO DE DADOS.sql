--select * from compras where desconto > 0 and DATA_PARA_TRANSFERENCIA>='20220620'

--select * from COMPRAS_PRODUTO where pedido in ('260989','274177','274250','279074')


update compras set desconto = 234.00, TOT_VALOR_ORIGINAL = (TOT_VALOR_ORIGINAL - 234.00) WHERE PEDIDO = '2711602E'

