select 'E' as tipo, a.NATUREZA, CM_ITEM_COMPOSICAO, sum(valor_total) as valor_total 
from 
entradas a
inner join NATUREZAS_ENTRADAS b  on b.NATUREZA = a.NATUREZA
where RECEBIMENTO between '20210101' and '20210131'
group by a.natureza, b.CM_ITEM_COMPOSICAO

union 

select 'S' as tipo, a.NATUREZA_SAIDA, b.CM_ITEM_COMPOSICAO, sum(valor_total) as valor_total
from faturamento a
inner join NATUREZAS_SAIDAS b on b.NATUREZA_SAIDA = a.NATUREZA_SAIDA
where emissao between '20210101' and '20210131'
group by a.NATUREZA_SAIDA, b.CM_ITEM_COMPOSICAO



select * 
from faturamento where natureza_saida = '100.01' 
and emissao between '20210101' and '20210131'



