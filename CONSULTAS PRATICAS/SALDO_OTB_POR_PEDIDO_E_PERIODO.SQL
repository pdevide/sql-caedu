
DECLARE @PRODUTO VARCHAR(12), @MES INT
SET @PRODUTO = '24150054'
SET @MES = 201612

select a.* 
from caedu_verba_compras a
join (select * from produtos where produto = @PRODUTO) p 
	on p.GRIFFE=a.griffe and p.LINHA = a.linha and p.GRUPO_PRODUTO = a.grupo and p.SUBGRUPO_PRODUTO = a.subgrupo

where mes = @MES

