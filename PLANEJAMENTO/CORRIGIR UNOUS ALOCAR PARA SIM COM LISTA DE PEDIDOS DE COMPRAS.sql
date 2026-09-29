select c.* 
update c set UNOUS_ALOCAR=1
from compras_produto a 
inner join produtos  b on b.PRODUTO = a.PRODUTO
inner join CAE_PRODUTOS_FATOR_P c on b.GRIFFE = c.GRIFFE and b.LINHA = c.LINHA and b.GRUPO_PRODUTO = c.GRUPO_PRODUTO and c.SUBGRUPO_PRODUTO=b.SUBGRUPO_PRODUTO
where pedido in 
('272807V'
,'273011V'
,'260457V'
,'272807'
,'273011')
