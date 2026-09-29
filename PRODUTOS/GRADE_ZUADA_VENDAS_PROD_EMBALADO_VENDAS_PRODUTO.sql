select * from compras_produto where pedido = '216313-1'

select * from produtos_barra where produto ='E3010015'    

select * from faturamento_caixas where caixa =  '12870207'



select * from vendas_prod_embalado where caixa in ('12870207','12870208','12870209','12870210','12870211')


select * from produtos_packs_permitidos where produto = 'Z2010062'    

select * from produtos_tamanhos where grade = 'unico'

update produtos_packs_permitidos
set q1=30,q2=0,q3=0,q4=0,q5=0,q6=0,q7=0,q8=0,q9=0,q10=0,q11=0,q12=0,q13=0,q14=0,q15=0,q16=0
where produto = 'Z2010062'    

SELECT * FROM VENDAS_PRODUTO WHERE PEDIDO IN ('CX-12870207','CX-12870208','CX-12870209','CX-12870210','CX-12870211')

SELECT * FROM VENDAS_PROD_EMBALADO WHERE CAIXA IN ('12870207','12870208','12870209','12870210','12870211')

--SELECT * FROM FATURAMENTO_CAIXAS WHERE CAIXA IN ('12870207','12870208','12870209','12870210','12870211')


UPDATE VENDAS_PRODUTO 
SET 
VO1=30, 
VO2=0, 
VO3=0, 
VO4=0, 
VO5=0, 
VO6=0, 
VO7=0, 
VO8=0, 
VO9=0, 
VO10=0, 
VO11=0, 
VO12=0, 
VO13=0, 
VO14=0, 
VO15=0, 
VO16=0,
VE1=30, 
VE2=0, 
VE3=0, 
VE4=0, 
VE5=0, 
VE6=0, 
VE7=0, 
VE8=0, 
VE9=0, 
VE10=0, 
VE11=0, 
VE12=0, 
VE13=0, 
VE14=0, 
VE15=0, 
VE16=0
WHERE PEDIDO IN ('CX-12870207','CX-12870208','CX-12870209','CX-12870210','CX-12870211')

UPDATE VENDAS_PROD_EMBALADO 
SET
E1=30,E2=0, E3=0, E4=0, E5=0, E6=0, E7=0, E8=0, E9=0, E10=0, E11=0, E12=0, E13=0, E14=0, E15=0, E16=0
WHERE CAIXA IN ('12870207','12870208','12870209','12870210','12870211')