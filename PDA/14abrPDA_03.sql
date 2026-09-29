
select a.CAIXA
, A.PRODUTO,
B.CAIXA AS EMBALADO, B.NOME_CLIFOR, B.FILIAL, B.COR_PRODUTO,C.ESTOQUE
from [ccp\paulo.devide].PDA_WMS_VOLUMES_FATURAR_ABRIL_25 a
inner JOIN VENDAS_PROD_EMBALADO B ON B.caixa = A.CAIXA
LEFT JOIN ESTOQUE_PRODUTOS C
	ON C.FILIAL=B.FILIAL AND C.PRODUTO = B.PRODUTO AND C.COR_PRODUTO=B.COR_PRODUTO


SELECT * 
FROM ESTOQUE_PRODUTOS 
WHERE PRODUTO IN ('51043939','D6180296','N5020054') AND FILIAL='CD - SP - SAO ROQUE'

--51043939    	00084     
--D6180296    	00130     
--N5020054    	00203  

select * from compras_produto where produto = '51043939'  
select cor_produto,* 
from produtos_packs_permitidos 
where produto in ('51043939','D6180296','N5020054')

select * from CAEDU_COMPRAS_PRODUTOS_PACKS_total where produto = '51043939'

insert into produtos_packs_permitidos (produto,pack,qtde,q1,q2,q3,q4,q5,data_para_transferencia,cor_produto,indica_pack_cor,inativo)
values ('51043939','A',6,0,1,2,2,1,getdate(),'00084',1,0)     
delete from produtos_packs_permitidos where produto = 'N5020054' and COR_PRODUTO='00183'
