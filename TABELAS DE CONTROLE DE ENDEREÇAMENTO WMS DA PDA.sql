select * from CAEDU_RESERVA_AUTOMATICA_PACK_WMS where distribuicao = '00011923'
select * from pda_wms_tb_distribuicao where distribuicao = '00011923'
select * from dbo.PDA_WMS_TB_CONTROLE_DISTRIBUICAO  where distribuicao = '00011923'
select * from pda_wms_tb_distribuicao_coleta where distribuicao = '00011923'
select * from dbo.PDA_WMS_TB_RESERVA_DISTRIBUICAO where distribuicao = '00011923'

DELETE from pda_wms_tb_distribuicao where distribuicao = '00011923'
DELETE from dbo.PDA_WMS_TB_CONTROLE_DISTRIBUICAO  where distribuicao = '00011923'
DELETE from pda_wms_tb_distribuicao_coleta where distribuicao = '00011923'
DELETE from dbo.PDA_WMS_TB_RESERVA_DISTRIBUICAO where distribuicao = '00011923'


DECLARE @P_RETORNO VARCHAR(MAX)
EXEC PRC_PDA_ATUALIZA_TABELAS_DISTRIBUICAO_WMS '00011923', @P_RETORNO OUTPUT
SELECT @P_RETORNO