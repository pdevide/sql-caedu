with wprod (produto, desc_produto, grade, griffe, linha, grupo_produto, 
			subgrupo_produto, data_umode, data_cadastramento, data_para_transferencia, erp_data_atualizacao,
			qtd_cores, qtd_cores_barras, qtd_tamanho_barras, tamanhos_digitaveis)
as (
select	p.produto, 
		P.desc_produto,
		grade,
		griffe,
		linha,
		grupo_produto,
		subgrupo_produto,
		p.data_umode,
		p.data_cadastramento,
		p.data_para_transferencia,
		p.erp_data_atualizacao,
		(select count(*) from produto_cores where produto=p.produto) as qtd_cores,
		(select count(distinct cor_produto) from produtos_barra where produto=p.produto) as qtd_cores_barras,
		(select count(distinct tamanho) from produtos_barra where produto=p.produto) as qtd_tamanho_barras,
		(select  
			(case when tamanho_1 like  '%.%' or tamanho_1 = '' then 0 else 1 end) + 
			(case when tamanho_2 like  '%.%' or tamanho_2 = '' then 0 else 1 end) + 
			(case when tamanho_3 like  '%.%' or tamanho_3 = '' then 0 else 1 end) + 
			(case when tamanho_4 like  '%.%' or tamanho_4 = '' then 0 else 1 end) + 
			(case when tamanho_5 like  '%.%' or tamanho_5 = '' then 0 else 1 end) + 
			(case when tamanho_6 like  '%.%' or tamanho_6 = '' then 0 else 1 end) + 
			(case when tamanho_7 like  '%.%' or tamanho_7 = '' then 0 else 1 end) + 
			(case when tamanho_8 like  '%.%' or tamanho_8 = '' then 0 else 1 end) + 
			(case when tamanho_9 like  '%.%' or tamanho_9 = '' then 0 else 1 end) + 
			(case when tamanho_10 like  '%.%' or tamanho_10 = '' then 0 else 1 end) + 
			(case when tamanho_11 like  '%.%' or tamanho_11 = '' then 0 else 1 end) + 
			(case when tamanho_12 like  '%.%' or tamanho_12 = '' then 0 else 1 end) + 
			(case when tamanho_13 like  '%.%' or tamanho_13 = '' then 0 else 1 end) + 
			(case when tamanho_14 like  '%.%' or tamanho_14 = '' then 0 else 1 end) + 
			(case when tamanho_15 like  '%.%' or tamanho_15 = '' then 0 else 1 end) + 
			(case when tamanho_16 like  '%.%' or tamanho_16 = '' then 0 else 1 end) 
			from produtos_tamanhos where grade=p.grade) as tamanhos_digitaveis
from produtos p
where p.inativo=0 and p.grade <> 'PRODUTO ANTIGO')           

select * 
from wprod
where 1=1
--and (qtd_cores != qtd_cores_barras) 
and (qtd_tamanho_barras != tamanhos_digitaveis )
and exists (select 1
from estoque_produtos 
where produto = wprod.produto and (
(es1<>0) or
(es2<>0) or
(es3<>0) or
(es4<>0) or
(es5<>0) or
(es6<>0) or
(es7<>0) or
(es8<>0) or
(es9<>0) or
(es10<>0) or
(es11<>0) or
(es12<>0) or
(es13<>0) or
(es14<>0) or
(es15<>0) or
(es16>0)) )

select * from produtos where produto = '13060226'
select * from produto_cores where produto = '13060226'
select * from produtos_barra where produto = '13060226'
select * from produtos_tamanhos where grade = '48 AO 52'