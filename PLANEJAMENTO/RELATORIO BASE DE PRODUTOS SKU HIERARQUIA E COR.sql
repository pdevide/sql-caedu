select p.griffe, p.linha, p.GRUPO_PRODUTO, p.SUBGRUPO_PRODUTO, p.produto, p.DESC_PRODUTO, p.grade, p.DATA_CADASTRAMENTO,
pb.CODIGO_BARRA, pb.TAMANHO, pb.grade as grade_sku, pc.COR_PRODUTO, pc.DESC_COR_PRODUTO 
from produtos p
inner join PRODUTOS_BARRA pb on pb.PRODUTO = p.produto
inner join PRODUTO_CORES pc on pc.PRODUTO = pb.PRODUTO and pc.COR_PRODUTO=pb.COR_PRODUTO
where p.DATA_CADASTRAMENTO > '20200101'
