
select * 
--update a set UNOUS_ALOCAR=1
from CAE_PRODUTOS_FATOR_P a
inner join (
select p.griffe,p.LINHA,p.GRUPO_PRODUTO,p.SUBGRUPO_PRODUTO, p.PRODUTO, cp.PEDIDO 
from compras_produto cp
inner join produtos p on p.PRODUTO = cp.PRODUTO
where cp.PEDIDO in 
('286255',
'286312',
'286312V',
'278966',
'282782V',
'279182',
'279182V',
'278871',
'278871V',
'287001',
'287001V',
'286999',
'286999V'
)) q 
	on q.GRIFFE=a.GRIFFE and q.LINHA = a.LINHA 
		and q.GRUPO_PRODUTO = a.GRUPO_PRODUTO 
		and q.SUBGRUPO_PRODUTO=a.SUBGRUPO_PRODUTO


