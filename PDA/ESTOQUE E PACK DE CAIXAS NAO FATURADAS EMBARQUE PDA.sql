USE CAEDU
--update caedu_reserva_automatica_pack_wms set gerado = 1
--where distribuicao in ('00032950','00032351')



select B.DESC_PRODUTO,A.PRODUTO, A.COR_PRODUTO, A.FILIAL, B.GRADE, B.ERP_QTD_PACK,A.ESTOQUE, 
A.ES1, A.ES2, A.ES3, A.ES4, A.ES5, A.ES6, A.ES7, A.ES8,
A.ES9, A.ES10, A.ES11, A.ES12, A.ES13, A.ES15, A.ES15, A.ES16
from estoque_produtos A
INNER JOIN PRODUTOS B ON B.PRODUTO = A.PRODUTO
where filial = 'CD - SP - SAO ROQUE' 
AND A.PRODUTO IN 
(SELECT PRODUTO 
FROM [ccp\paulo.devide].VW_CAIXAS_NAO_FATURADAS_PDA_4
GROUP BY PRODUTO)
ORDER BY PRODUTO, COR_PRODUTO


select B.DESC_PRODUTO,A.PRODUTO, A.COR_PRODUTO, B.GRADE, B.ERP_QTD_PACK, A.PACK, A.QTDE, 
A.Q1, A.Q2, A.Q3, A.Q4, A.Q5, A.Q6, A.Q7, A.Q8,
A.Q9, A.Q10, A.Q11, A.Q12, A.Q13, A.Q15, A.Q15, A.Q16
from PRODUTOS_PACKS_PERMITIDOS A
INNER JOIN PRODUTOS B ON B.PRODUTO = A.PRODUTO
where 1=1
AND A.PRODUTO IN 
(SELECT PRODUTO 
FROM [ccp\paulo.devide].VW_CAIXAS_NAO_FATURADAS_PDA_4
GROUP BY PRODUTO)
ORDER BY PRODUTO, PACK







--N2030324    	00016     


select * 
--update a set gerado=1
from caedu_reserva_automatica_pack_wms a where distribuicao = '00032972' and gerado=0

select * from produto_cores where produto = 'N2030324'


insert into PRODUTOS_PACKS_PERMITIDOS
(produto, pack, qtde, 
Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8,
Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16,
data_para_transferencia, cor_produto, INDICA_PACK_COR, INATIVO
)
select a.produto, 'B' as pack, a.qtde, 
A.Q1, A.Q2, A.Q3, A.Q4, A.Q5, A.Q6, A.Q7, A.Q8,
A.Q9, A.Q10, A.Q11, A.Q12, A.Q13, A.Q14, A.Q15, A.Q16,
data_para_transferencia, '00016' as cor_produto, INDICA_PACK_COR, INATIVO
from produtos_packs_permitidos a where produto = 'N2030324'
