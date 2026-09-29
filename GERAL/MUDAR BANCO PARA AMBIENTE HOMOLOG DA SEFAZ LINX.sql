/*
Ambiente de Homologação. 
- IDENTIFICA_AMBIENTE_NFE = valor atual: '2' 
- IP_WS_NFE = valor atual: '201.56.69.84' ou '52.170.73.24' 
- PORTA_IP_WS_NFE = valor atual: '2804' 
- TIPO_COMUNICACAO_XML_NFE = valor atual: 'WEB SERVICE'
*/


select * 
--UPDATE A SET VALOR_ATUAL='2'
from PARAMETROS A where PARAMETRO = 'IDENTIFICA_AMBIENTE_NFE' --mudar pra 2

select * 
--UPDATE A SET VALOR_ATUAL='52.170.73.24'
from PARAMETROS A where PARAMETRO = 'IP_WS_NFE' --mudar pra '201.56.69.84'

select * 
--UPDATE A SET VALOR_ATUAL = '2804'
from PARAMETROS A where PARAMETRO = 'PORTA_IP_WS_NFE' --mudar pra '2804'

select * 
--UPDATE A SET VALOR_ATUAL = 'WEB SERVICE'
from PARAMETROS A where PARAMETRO = 'TIPO_COMUNICACAO_XML_NFE' --mudar pra 'WEB SERVICE'
