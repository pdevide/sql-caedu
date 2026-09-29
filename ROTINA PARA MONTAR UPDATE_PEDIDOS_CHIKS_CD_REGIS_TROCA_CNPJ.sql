select * from compras 
where 1=1 
and PEDIDO_FORNECEDOR like 'NF CHIKS:%'
and FORNECEDOR = 'CHIK S CENTER MODAS 00190' 
and EMISSAO = '2019-06-03'


select 'UPDATE COMPRAS SET FILIAL_A_ENTREGAR = '+CHAR(39)+'CD REGIS'+CHAR(39)+
		', FILIAL_A_FATURAR = '+CHAR(39)+'CD REGIS'+CHAR(39)+
		', FORNECEDOR = ' + CHAR(39) + 'CHIK S CENTER MODAS 00190' + CHAR(39) +
			' WHERE PEDIDO = '+CHAR(39)+RTRIM(PEDIDO)+CHAR(39)+';'
from compras 
where 1=1 
and PEDIDO_FORNECEDOR like 'NF CHIKS:%'
and FORNECEDOR = 'CHIK S CENTER MODAS LTDA' 
and EMISSAO = '2019-06-03'


select * from fornecedores where fornecedor like '%chik%'
