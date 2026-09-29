--select b.caixa, a.filial
--from [ccp\paulo.devide].[VW_CAIXAS_NAO_FATURADAS_PDA_4] a
--left join vendas_prod_embalado b on b.caixa = a.caixa
--where b.caixa is not null


select * 
--update a set ERP_EBS_AR_DATA_ENVIO=null,
--ERP_EBS_GL_DATA_ENVIO=null,
--ERP_EBS_SYNCHRO_DATA_ENVIO=null
from faturamento a where chave_nfe = '35250446377727011390550010000036711546795691'


select * 
update a set entrada_conferida = 1
from loja_entradas a where chave_nfe = '35250446377727011390550010000036711546795691'


select * from LX_PROCESSO_LOG where comando like '%000003671%'

LX_GERA_TRANSFERENCIA_AUTOMATICA @FILIAL='CD - SP - SAO ROQUE', @ROMANEIO_PRODUTO='000003671',@FILIAL_DESTINO='GO SH APARECIDA',@SERIE_NF='1', @ORIGEM='F', @EXCLUSAO='S'
