 
select
produtos.PRODUTO
,CLASSIF_FISCAL
,TIPO_PRODUTO
,DESC_PRODUTO
,GRUPO_PRODUTO
,SUBGRUPO_PRODUTO
,COLECAO
,GRADE
,LINHA
,GRIFFE
,REFER_FABRICANTE
,FABRICANTE
,INATIVO
,INDICADOR_CFOP
,ID_EXCECAO_GRUPO
,ID_EXCECAO_IMPOSTO
,FATOR_P
,CONTINUIDADE
,COD_CATEGORIA
,COD_SUBCATEGORIA
,TIPO_ITEM_SPED
,ERP_QTD_PACK
from produtos 
inner join (
select produto,  max(estoque) as estoque from estoque_produtos 
group by produto
having max(estoque) > 0
) as estoque on estoque.PRODUTO = produtos.PRODUTO
where produtos.inativo=0 

