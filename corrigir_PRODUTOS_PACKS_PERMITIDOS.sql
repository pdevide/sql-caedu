
Pedido 153360 / produto 70024615 – pack correto de 12 – incluir a cor rose.
Pedido 153933 / produto 70054164 – pack correto de 12 – incluir a cor pink.


51032120
51032127

51032206
51032207
51032204

--select * from CAEDU_COMPRAS_PRODUTOS_PACKS where produto = '51032204'

DECLARE @PRODUTO1 VARCHAR(8) = '51032127'

select ERP_QTD_PACK from produtos where produto = @PRODUTO1

select * from PRODUTO_CORES where produto = @PRODUTO1
--in  ('53021047','53021069','53021068','53021070')

SELECT * FROM PRODUTOS_PACKS_PERMITIDOS WHERE PRODUTO = @PRODUTO1

UPDATE PRODUTOS_PACKS_PERMITIDOS 
SET QTDE = 8, Q1 =2, Q2 = 2, Q3 = 2, Q4 = 2 
WHERE PRODUTO = '70024620' AND COR_PRODUTO <> '00003'     

UPDATE PRODUTOS SET ERP_QTD_PACK = 36 WHERE PRODUTO = '51011817' 

select @@


DECLARE @PRODUTO VARCHAR(12), @COR CHAR(5), @TOTPACK INT
SET @PRODUTO = '51032127'
SET @COR = '00088'
SET @TOTPACK = 10

--select * From produtos_packs_permitidos where produto = @PRODUTO 
insert into PRODUTOS_PACKS_PERMITIDOS (PRODUTO, PACK, QTDE, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, Q22, Q23, Q24, Q25, Q26, Q27, Q28, Q29, Q30, Q31, Q32, Q33, Q34, Q35, Q36, Q37, Q38, Q39, Q40, Q41, Q42, Q43, Q44, Q45, Q46, Q47, Q48, DATA_PARA_TRANSFERENCIA, COR_PRODUTO, INDICA_PACK_COR, INATIVO)
select top 1 PRODUTO, PACK, QTDE, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, Q18, Q19, Q20, Q21, Q22, Q23, Q24, Q25, Q26, Q27, Q28, Q29, Q30, Q31, Q32, Q33, Q34, Q35, Q36, Q37, Q38, Q39, Q40, Q41, Q42, Q43, Q44, Q45, Q46, Q47, Q48, DATA_PARA_TRANSFERENCIA, @COR as COR_PRODUTO, INDICA_PACK_COR, INATIVO
From produtos_packs_permitidos where produto = @PRODUTO 

update 
produtos set 
erp_qtd_pack = @TOTPACK
where produto = @PRODUTO



update produtos_packs_permitidos
set qtde = 24, q1 = 8, q2 = 8, q3 = 8, q4 = 0 where produto = '23160043' and COR_PRODUTO = '00029'

DELETE FROM produtos_packs_permitidos
WHERE PRODUTO = '70053224' AND COR_PRODUTO = '00103'

SELECT * FROM CAEDU_COMPRAS_PRODUTOS_PACKS_TOTAL
WHERE PRODUTO IN 
('53021047','53021069','53021068','53021070')


--===================================================================================================================================================================================================================================================================================================================================================================--


/*
select produto, pack, qtde, COR_PRODUTO 
from produtos_packs_permitidos where produto in (
'51011752',
'51011753',
'51011809',
'51011755',
'51011744',
'51011745',
'51011808',
'51011748',
'51011749',
'51041567',
'51041564',
'51041565',
'51041565',
'51041565'
)
*/

/*
PRODUTO		COR1		COR2		COR CADASTRADA
51011752	00025     	00108     	00025	OK
51011753	00103     	00141     	00103	OK	
51011809	00103     	00131     	00103	OK
51011755	00025     	00141     	00025	OK
51011744	00107     	00138     	00107	OK
51011745	00088     	00101     	00088	OK
51011808	00130     	00138     	00130	OK
51011748	00107     	00138     	00107	OK
51011749	00087     	00107     	00087	OK
51041567	00108     	00113     	00108	OK
51041564	00013     	00101     	00013	OK
51041565	00113     	00151     	00113	OK
51041565	00113     	00151     	00113	OK
51041565	00113     	00151     	00113	OK

Pedido 149667  produto 70053918  
Pedido 149665   produto 70053916   
pack de  10
70041774  
70041775  

pedido	produto	colocar pack 	incluir cor	codigo da cor
156392	51050158	16	off White	00112 ok
156394	51050159	16	off White	00112 ok
156395	51050160	16	off White	00112 ok
156255	51050157	16	rosa pó	00192

pedido	produto	colocar pack 	incluir cor	código da cor
152760	70052025	12	off White	00112
153357	70024612	18	Off White/mescla	00112/00113

pedido	produto	colocar pack 	incluir cor	código da cor
154410	70024498	16	off White	00112
152613	70024554	18	Branco	00004

============================================
153292 – 70024469 – pack 12 royal 00106
153289 – 70024327 – pack 12 off white 00112

62060003

SELECT * FROM CAEDU_COMPRAS_PRODUTOS_PACKS WHERE PEDIDO= '147563'
LX_CADE PACK

*/

147563
51021446

select * from compras_produto where produto = '63020106'    


select * from ESTOQUE_PRODUTOS_HISTORICO
lx_cade historico