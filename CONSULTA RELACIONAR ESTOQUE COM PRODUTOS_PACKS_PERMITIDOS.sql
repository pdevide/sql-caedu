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
