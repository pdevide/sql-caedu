WITH caixas as (
select t1.*
from (
select *,
case 
	when (select count(*) from faturamento_prod where caixa = a.caixa) > 0 then 'FATURADO'
	when (select count(*) from vendas_prod_embalado where caixa = a.caixa) > 0 then 'EMBALADO'
	when (select count(*) from pda_wms_tb_embarque w
			where w.caixa = a.caixa and w.faturado=1  and  
			not exists (select 1 from faturamento_prod where caixa=a.caixa) ) > 0 then 'RETIRADO'
	else 'SEM TRATAMENTO'
	end as STATUS_CAIXA
from [ccp\paulo.devide].[tb_pda_wms_estoque_caixas_2] a
where isnull(lojadestino,'') != '') t1
where t1.status_caixa = 'SEM TRATAMENTO'),
packs as (
select caixa, caixas.produto, caixas.qtde as qtde_pda, p.grade, p.erp_qtd_pack, 
x.q1, x.q2, x.q3, x.q4, x.q5, x.q6, x.q7, x.q8, x.q9, 
x.q10, x.q11, x.q12, x.q13, x.q14, x.q15, x.q16, x.pack, x.qtde as totpack
from caixas
inner join produtos_packs_permitidos x
	on x.produto = caixas.produto
inner join produtos p on p.produto = caixas.produto
	)
select * from packs