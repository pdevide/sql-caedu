select * 
from loja_venda a
where DATA_VENDA = '20241117' and codigo_filial='000004'
--and TICKET='P0000163'

select b.* 
from loja_venda a
inner join LOJA_VENDA_PRODUTO b 
	on b.DATA_VENDA = a.DATA_VENDA and b.CODIGO_FILIAL=a.CODIGO_FILIAL
and b.TICKET=a.TICKET
where A.DATA_VENDA = '20241117' and A.codigo_filial='000004'
and A.TICKET='P0000162'



DELETE FROM LOJA_VENDA 
where DATA_VENDA = '20241117' and codigo_filial='000004'
and TICKET='P0000162'

DELETE FROM LOJA_VENDA where DATA_VENDA = '20241117' and codigo_filial='000004' and TICKET='P0000162'
