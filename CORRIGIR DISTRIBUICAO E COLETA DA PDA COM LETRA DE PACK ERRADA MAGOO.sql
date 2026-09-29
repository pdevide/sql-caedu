--00034725
--00034418
--00034020

select * from CAEDU_RESERVA_AUTOMATICA_PACK_WMS 
where distribuicao = '00034418'

select * from produtos_packs_permitidos where produto = '53022320'

--SELECT * FROM DBO.CGP_TRANSF_CAIXA_FILIAL

999325



select * 
from faturamento_caixas 
where data_para_transferencia>'20250522' 
order by data_para_transferencia desc






--SELECT * 
----UPDATE A SET DATA='20250522'
--FROM CAEDU_RESERVA_AUTOMATICA A
--WHERE PEDIDO IN ('345354')

--select * from sysobjects where name like 'pda%coleta%' and type='U'

select * from PDA_WMS_TB_DISTRIBUICAO_COLETA
where distribuicao = '00034418'


select * 
--update a set pack = 'A'
from CAEDU_RESERVA_AUTOMATICA_PACK_WMS a
where distribuicao = '00034418'

select * 
--update a set caixa = replace(caixa,'B|','A|')
from PDA_WMS_TB_DISTRIBUICAO_COLETA a
where distribuicao = '00034418'
