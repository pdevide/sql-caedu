/*
select /*a.sk_dia, e.DAT_DIA, c.COD_FILIAL, b.cod_produto, b.dsc_produto, a.COR_PRODUTO, d.DSC_COR, a.QTD_ESTOQUE, a.CUSTO*/
SUM(A.QTD_ESTOQUE)
from fat_estoque a
--inner join dim_produto b on b.sk_produto = a.sk_produto
inner join DIM_FILIAL c on c.SK_FILIAL = a.SK_FILIAL
--inner join DIM_PRODUTO_CORES d on d.COD_COR = a.COR_PRODUTO
inner join DIM_DIA e on e.SK_DIA = a.SK_DIA
where a.sk_dia = 20220901 and c.COD_FILIAL = 'PRAIA GRANDE'

Bom dia.
Prezados, após realizar os procedimentos de subir o arquivo final (txt) no LINX, referente ao inventário da loja Praia Grande 
com início na noite de 08/09/22 e final na manhã de 09/09/22. Observei os seguintes erros em ordem sequencial.
1.	Saldo divergente do posicionamento após fechamento da tesouraria no dia 08/09/22. 
Saldo após fechamento da tesouraria era de 94.640. Durante o upload do arquivo, LINX sinalizou 93.311.
dia 7 -> 95772
dia 8 -> 94640
dia 9 -> 98998
*/

select sum(qtd_estoque) from fat_estoque where sk_dia = 20220901 and sk_filial = 44


--select * from DIM_FILIAL where COD_FILIAL like 'itaim%'


select * from dim_dia where sk_ano = 2022