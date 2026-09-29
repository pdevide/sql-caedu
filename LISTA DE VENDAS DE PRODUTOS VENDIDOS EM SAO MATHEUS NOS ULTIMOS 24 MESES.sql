select produto 
from produtos
where produto in (
select produto 
from LOJA_VENDA_PRODUTO a
inner join LOJA_VENDA b on b.DATA_VENDA=a.DATA_VENDA and b.CODIGO_FILIAL=a.CODIGO_FILIAL and b.TICKET=a.TICKET
where a.CODIGO_FILIAL='000018' and a.DATA_VENDA>'20210101')




