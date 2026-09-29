select a.pedido, cast(a.tot_qtde_original as int) as tot_qtde_original , a.erp_percent_distrib, a.erp_total_qtd_distrib, a.ERP_TOTAL_CAIXAS_ORIGINAL, 
' | ', b.produto,  b.qtde ,     
CAST( ( a.tot_qtde_original/b.qtde ) as int) as caixa_calculada,

case 
       when (( a.tot_qtde_original/b.qtde )-a.ERP_TOTAL_CAIXAS_ORIGINAL) = 0 then 'OK' 
       when (( a.tot_qtde_original/b.qtde )-a.ERP_TOTAL_CAIXAS_ORIGINAL) <> 0 then 'ERRO' 
       end , 
       c.ERP_QTD_PACK as pack_do_produto

from compras a  inner join CAEDU_COMPRAS_PRODUTOS_PACKS_TOTAL B
       on a.pedido = b.pedido
       inner join produtos C
       on b.produto = c.produto
where a.pedido in ('164030',
'164034',
'164025',
'164028',
'164045')
