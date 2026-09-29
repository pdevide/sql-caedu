/*
server = 172.16.6.57
database = CAEDU_BI
user = diariodebordo
*/

select a.sk_dia, e.DAT_DIA, c.COD_FILIAL, b.cod_produto, b.dsc_produto, a.COR_PRODUTO, d.DSC_COR, a.QTD_ESTOQUE, a.CUSTO
from fat_estoque a
inner join dim_produto b on b.sk_produto = a.sk_produto
inner join DIM_FILIAL c on c.SK_FILIAL = a.SK_FILIAL
inner join DIM_PRODUTO_CORES d on d.COD_COR = a.COR_PRODUTO
inner join DIM_DIA e on e.SK_DIA = a.SK_DIA
where a.sk_dia = 20190630 
--and a.sk_filial = 21
and b.cod_produto = 'B0010010'

--select top 10 * from fat_estoque
--select top 100 * from dim_dia