select	a.CODIGO_BARRA, 
		a.PRODUTO, 
		a.COR_PRODUTO, 
		a.TAMANHO, 
		a.GRADE, 
		b.INATIVO, 
		b.DESC_PRODUTO
from PRODUTOS_BARRA a
inner join produtos b on b.PRODUTO = a.PRODUTO
order by a.PRODUTO, a.COR_PRODUTO, a.TAMANHO
