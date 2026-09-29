alter table REL_ITENS_COMPOSICAO_04_2017_20170516
add REGNUM int null
go


with cte as (
    select
        t.regnum,
        row_number() over(partition by t.item_composicao order by t.item_composicao) as rn
    from REL_ITENS_COMPOSICAO_04_2017_20170516 as t
)
update cte set regnum = rn
go


create index ix01_REL_ITENS_COMPOSICAO_04_2017_20170516 on REL_ITENS_COMPOSICAO_04_2017_20170516
(item_composicao asc, regnum asc)
go


/* 

select top 100000 a.regnum,* 
from REL_ITENS_COMPOSICAO_04_2017_20170516 a where item_composicao = '003' order by a.regnum

 */

select * from REL_ITENS_COMPOSICAO_04_2017_20170516 where item_composicao = '012' and regnum between 50001 and 100000

SELECT COUNT(*) FROM REL_ITENS_COMPOSICAO_04_2017_20170516

SELECT COUNT(*) FROM REL_ITENS_COMPOSICAO_12_2016_20170208 