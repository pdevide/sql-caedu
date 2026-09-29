select p.erp_qtd_pack, p.grade, a.cor_produto, p.desc_produto, a.*
--update a set qtde=5, q1=5
from produtos_packs_permitidos a
inner join produtos p on p.produto = a.produto
where a.produto = 'Z6180066'

select * 
from estoque_produtos 
where 1=1
and filial = 'CD - SP - SAO ROQUE'
AND PRODUTO = 'Z6180066'

INSERT INTO produtos_packs_permitidos 
(PRODUTO,PACK,QTDE,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15,Q16
,Q17,Q18,Q19,Q20,Q21,Q22,Q23,Q24,Q25,Q26,Q27,Q28,Q29,Q30,Q31,Q32,Q33,Q34,
Q35,Q36,Q37,Q38,Q39,Q40,Q41,Q42,Q43,Q44,Q45,Q46,Q47,Q48,DATA_PARA_TRANSFERENCIA,
COR_PRODUTO,INDICA_PACK_COR,INATIVO)
SELECT
PRODUTO,
'B' AS PACK,
QTDE,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15,Q16,Q17,Q18,
Q19,Q20,Q21,Q22,Q23,Q24,Q25,Q26,Q27,Q28,Q29,Q30,Q31,Q32,Q33,Q34,Q35,Q36,Q37,Q38,
Q39,Q40,Q41,Q42,Q43,Q44,Q45,Q46,Q47,Q48,DATA_PARA_TRANSFERENCIA,
'00076' AS COR_PRODUTO,
INDICA_PACK_COR,INATIVO
FROM produtos_packs_permitidos
WHERE produto = 'Z6180066'

update 
produtos_packs_permitidos
set COR_PRODUTO='00003'
WHERE produto = 'Z6180066' and pack='A'