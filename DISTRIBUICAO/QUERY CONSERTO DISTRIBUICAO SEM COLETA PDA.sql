--select ID_COLETA,DISTRIBUICAO,PRODUTO,QTDE, substring(CAIXA,1,1) as PACK,
--		ROW_NUMBER() OVER (PARTITION BY DISTRIBUICAO order by DISTRIBUICAO,ID_COLETA) as COD_COLETA
--		FROM PDA_WMS_TB_DISTRIBUICAO_COLETA










select * 
--update a set DISTRIBUICAO='00016287'
from PDA_WMS_TB_DISTRIBUICAO_COLETA a 
where produto = '23030724'

select distinct distribuicao, produto, data from CAEDU_RESERVA_AUTOMATICA_PACK_WMS where produto = '23030724'



select distinct distribuicao, produto 
from caedu_reserva_automatica_pack_wms 
where produto in
('24050124'
,'24200418'
,'24210413'
,'24200405'
,'24050118'
,'24210420'
,'24200419'
,'24200424'
,'24240095'
,'24230093'
,'24200413'
,'24240096'
,'24210421'
,'24020508'
,'24230091'
,'24210427'
,'24210410'
,'24200426'
,'24990240'
,'24020519'
,'24020517'
,'24020509'
,'24210411'
,'24990242'
,'24990215'
,'24990217')

select DISTRIBUICAO, PRODUTO, SUM(quantidade), pack 
from PDA_WMS_TB_DISTRIBUICAO where DISTRIBUICAO  = '00015853'
 group by DISTRIBUICAO, PRODUTO, pack

 exec PDA_WMS_SP_IN_RESERVA_DISTRIBUICAO '24990215',160,'00015853','A'

 select * from PRODUTOS_PACKS_PERMITIDOS where produto = '24990215'

 select * from PDA_WMS_TB_ARMAZENAGEM_PALETE where produto = '24990215'

 select * from PDA_WMS_LOG_MOTAGEM_PALETE where produto = '24990215' order by data desc

 select * from PDA_WMS_TB_DISTRIBUICAO_COLETA where produto = '24990215' order by DATA_COLETA desc
 

 
SELECT SUM(QTDE_ESTOQUE-QTDE) as qty
FROM(
	SELECT   QTDE_ESTOQUE= QUANTIDADE,
				ISNULL(RES.QTDE,0)  QTDE  
        FROM   (  SELECT   ID_ENDERECO,						      
							SUM(QUANTIDADE / ISNULL(PP.QTDE,1))QUANTIDADE,
							AP.PRODUTO,
							AP.PACK						
				FROM  PDA_WMS_TB_ARMAZENAGEM E 
				INNER JOIN PDA_WMS_TB_ARMAZENAGEM_PALETE AP ON AP.PALETE = E.PALETE
					        LEFT JOIN PRODUTOS_PACKS_PERMITIDOS PP ON PP.PRODUTO = AP.PRODUTO AND PP.PACK = AP.PACK
				WHERE  AP.PRODUTO = '24990215'  AND AP.PACK='A'  
				GROUP BY ID_ENDERECO, AP.PRODUTO, AP.PACK
			    ) EST  
				LEFT JOIN (SELECT PRODUTO,     
								QTDE=SUM(QTDE),
								PACK    
							FROM   PDA_WMS_TB_RESERVA_DISTRIBUICAO P     
									LEFT JOIN PDA_WMS_STATUS_DISTRIBUICAO SP  ON SP.DISTRIBUICAO = P.DISTRIBUICAO     
								WHERE  PRODUTO = '24990215'   AND PACK='A'
								AND SP.STATUS NOT IN( 3, 4, 5, 6 )     
								GROUP  BY PRODUTO,PACK 
						) RES  ON EST.PRODUTO = RES.PRODUTO AND RES.PACK=EST.PACK)RES

 select * from PDA_WMS_TB_RESERVA_DISTRIBUICAO where PRODUTO = 'Z5030045'
select * from PDA_WMS_TB_RESERVA_DISTRIBUICAO where DISTRIBUICAO = '00015853'
select * from PDA_WMS_TB_DISTRIBUICAO_COLETA where DISTRIBUICAO = '00015853'



select distribuicao,produto,filial,count(qtde_pack) as qtde,
row_number() over (partition by distribuicao order by distribuicao, filial) as cod
from caedu_reserva_automatica_pack_wms 
where produto in (
'B0020040'    
,'B0040023'
,'B0020041'  
,'B0040025'    
,'Z1010089'    
,'B0040024'  
,'Z2010195'  
,'61020130'
,'24050124'
,'24200418'
,'24210413'
,'24200405'
,'24050118'
,'24210420'
,'24200419'
,'24200424'
,'24240095'
,'24230093'
,'24200413'
,'24240096'
,'24210421'
,'24020508'
,'24230091'
,'24210427'
,'24210410'
,'24200426'
,'24990240'
,'24020519'
,'24020517'
,'24020509'
,'24210411'
,'24990242'
,'24990215'
,'24990217'
)
group by distribuicao,produto,filial


/*

----select * from PDA_WMS_TB_DISTRIBUICAO
--WHERE DISTRIBUICAO in (

select a.distribuicao,a.produto, quantidade as qtde 
from PDA_WMS_TB_DISTRIBUICAO a
--inner join caedu_reserva_automatica_pack_wms b on b.distribuicao = a.distribuicao and b.produto = a.produto
where a.distribuicao = '00015249'in 
('B0020040'    
,'B0040023'
,'B0020041'  
,'B0040025'    
,'Z1010089'    
,'B0040024'  
,'Z2010195'  
,'61020130'
,'24050124'
,'24200418'
,'24210413'
,'24200405'
,'24050118'
,'24210420'
,'24200419'
,'24200424'
,'24240095'
,'24230093'
,'24200413'
,'24240096'
,'24210421'
,'24020508'
,'24230091'
,'24210427'
,'24210410'
,'24200426'
,'24990240'
,'24020519'
,'24020517'
,'24020509'
,'24210411'
,'24990242'
,'24990215'
,'24990217')
--)


select distinct a.distribuicao 
from CAEDU_RESERVA_AUTOMATICA_PACK_WMS a 
inner join PDA_WMS_TB_DISTRIBUICAO b on b.distribuicao = a.distribuicao
where a.data='20221020'





*/


select * from caedu_reserva_automatica_pack_wms where distribuicao = '00015572'