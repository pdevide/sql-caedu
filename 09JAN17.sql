select * from CAE_MODELOS_EXCEL


select * from fornecedores 

caedu_laudo_pedido_item


select * from CAEDU_LISTA_COMBO where CODIGO = ?XX

PRODUTOS_PACKS_PERMITIDOS

select * from compras_produto where produto = '06100885'

167040  

select * from CAEDU_COMPRAS_PRODUTOS_PACKS where pedido = '167040'


select
ID_LAUDO, PRODUTO, COR_PRODUTO, DESC_COR_PRODUTO, QTDE, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, Q22, Q23, Q24, Q25, Q26, Q27, Q28, Q29, Q30, Q31, Q32, Q33, Q34, Q35, Q36, Q37, Q38, Q39, Q40, Q41, Q42, Q43, Q44, Q45, Q46, Q47, Q48
FROM CAEDU_LAUDO_PEDIDO_GRADE
WHERE ID_LAUDO = ''

exec pr_grade_produto_cor '167040','06100885','00147' 
					?v_caedu_compras_produtos_packs.produto,?v_caedu_compras_produtos_packs.cor_produto

select grade from produtos where produto = '06100885'
select * from produtos_tamanhos where grade = 'G1 AO G3'       

LX_TAMANHOS_DIGITADOS_GRADE 'CALCADO 17/18 A0 27/28'

LX_TAMANHOS_DIGITADOS_GRADE 'P AO G'


          