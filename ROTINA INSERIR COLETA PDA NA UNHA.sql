select * FROM 
PDA_WMS_TB_DISTRIBUICAO_COLETA 
WHERE distribuicao in ('00038020', '00038266')


select * 
--update a set gerado=0
from CAEDU_RESERVA_AUTOMATICA_PACK_WMS a
--WHERE distribuicao in ('00038020', '00038266')
where distribuicao = '00038020'
--and caixa = '31852565'

insert into PDA_WMS_TB_DISTRIBUICAO_COLETA (distribuicao,id_endereco,produto,usuario,qtde,caixa,TIMESTAMP)
select	distribuicao,
		1 as id_endereco,
		produto,
		819 as usuario,
		qtde_total as qtde,
		pack+'|'+rtrim(produto)+'|000000|000|'+rtrim(caixa) as caixa,
		45781 as TIMESTAMP
from CAEDU_RESERVA_AUTOMATICA_PACK_WMS
where distribuicao = '00038266'

select top 10 pack+'|'+rtrim(produto)+'|000000|000|'+rtrim(caixa)
from CAEDU_RESERVA_AUTOMATICA_PACK_WMS
where distribuicao = '00034715'

select * from produtos where produto = '34016279'


select * from vendas_prod_embalado where entrega > '20250503'


select * from caedu_reserva_automatica_pack_wms where caixa = '31147577'


select RTRIM(B.NOME_CLIFOR)+';'+RTRIM(B.CAIXA) AS XUXA
from CAEDU_RESERVA_AUTOMATICA_PACK_WMS a
inner join VENDAS_PROD_EMBALADO b on b.caixa = a.caixa
where distribuicao = '00034715'
ORDER BY 1


select * from [ccp\paulo.devide].caixas_distrib_34715




select b.*
--update b set faturado=0
from CAEDU_RESERVA_AUTOMATICA_PACK_WMS a
inner join pda_wms_tb_embarque b on b.caixa = a.caixa
where distribuicao = '00034715' and faturado=1


select B.NF_SAIDA,A.* 
from pda_wms_tb_embarque A 
LEFT JOIN FATURAMENTO_PROD B ON B.CAIXA = A.CAIXA
where data>'20250507' 
and doca like 'VILA FORMOSA%'
AND B.NF_SAIDA IS NULL


SELECT * FROM VENDAS_PROD_EMBALADO WHERE CAIXA IN ('31863929','31863930')

SELECT * FROM CAEDU_RESERVA_AUTOMATICA WHERE CAIXA IN ('31863929','31863930')

SELECT * FROM FATURAMENTO WHERE NOME_CLIFOR='VILA FORMOSA' AND EMISSAO='20250507'


SELECT B.PEDIDO, A.* 
FROM CAEDU_RESERVA_AUTOMATICA A 
LEFT JOIN VENDAS B ON B.PEDIDO = A.VENDA
WHERE A.PEDIDO = '350362'
AND B.PEDIDO IS NOT NULL



SELECT * FROM PRODUTOS WHERE PRODUTO = '51180309'



select * from compras where pedido like '353841%'
