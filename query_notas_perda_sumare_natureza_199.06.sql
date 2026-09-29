select 
a.nf_saida, a.NF_SAIDA, a.FILIAL, a.CODIGO_ITEM, p.DESC_PRODUTO, cast(a.QTDE_ITEM as int) as QTDE, a.VALOR_ITEM
from FATURAMENTO_ITEM a
inner join faturamento f on f.NF_SAIDA = a.NF_SAIDA and f.SERIE_NF = a.SERIE_NF and f.FILIAL = a.FILIAL
inner join produtos p on p.PRODUTO = a.CODIGO_ITEM
where f.NATUREZA_SAIDA = '199.06'
ORDER BY a.nf_saida, ITEM_IMPRESSAO