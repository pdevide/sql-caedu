with estoque (filial, produto, cor_produto,grade, estoque, pack,
ES1, ES2, ES3, ES4, ES5, ES6, ES7, ES8, ES9, ES10, ES11, ES12, ES13, ES14, ES15, ES16, ERP_QTD_PACK,
qtde, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16)
as (
select ep.filial, p.produto, ep.cor_produto
,p.grade, estoque, pp.pack,
ES1, ES2, ES3, ES4, ES5, ES6, ES7, ES8, ES9, ES10, ES11, ES12, ES13, ES14, ES15, ES16, P.ERP_QTD_PACK,
pp.qtde, pp.Q1, pp.Q2, pp.Q3, pp.Q4, pp.Q5, pp.Q6, pp.Q7, pp.Q8, pp.Q9, pp.Q10, pp.Q11, pp.Q12, 
pp.Q13, pp.Q14, pp.Q15, pp.Q16
from produtos p 
inner join estoque_produtos ep 
	on ep.produto = p.produto
left join produtos_packs_permitidos pp 
	on pp.produto = ep.produto and pp.cor_produto = ep.cor_produto
where 1=1
and ep.filial = 'CD - SP - SAO ROQUE'
and p.produto in
(select produto from [ccp\paulo.devide].TB_CAIXAS_A_FATURAR_20250609 group by produto)
)
select a.* 
--update a set	qtde_packs=1, 
--cor_produto = b.cor_produto, qtde = b.qtde,
--q1 = b.q1, q2 = b.q2, q3 = b.q3, q4 = b.q4, q5 = b.q5, 
--q6 = b.q6, q7 = b.q7, q8 = b.q8, q9 = b.q9, q10 = b.q10, 
--q11 = b.q11, q12 = b.q12, q13 = b.q13, q14 = b.q14, q15 = b.q15, q16 = b.q16
--from [ccp\paulo.devide].TB_CAIXAS_A_FATURAR_20250602 a
from [ccp\paulo.devide].TB_CAIXAS_A_FATURAR_20250609 a
inner join estoque b on b.produto=a.produto



