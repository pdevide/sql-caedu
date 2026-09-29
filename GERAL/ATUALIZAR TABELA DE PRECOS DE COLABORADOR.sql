update produtos_precos set  PRECO1_ANTERIOR=preco1, preco1 = 19.99, DATA_CARGA_PRECOS='20200304',DATA_PARA_TRANSFERENCIA=getdate() where produto = '01230644' and CODIGO_TAB_PRECO='04'
update produtos_precos set  PRECO1_ANTERIOR=preco1, preco1 = 39.99, DATA_CARGA_PRECOS='20200304',DATA_PARA_TRANSFERENCIA=getdate() where produto = '45460734' and CODIGO_TAB_PRECO='04'
update produtos_precos set  PRECO1_ANTERIOR=preco1, preco1 = 49.99, DATA_CARGA_PRECOS='20200304',DATA_PARA_TRANSFERENCIA=getdate() where produto = '51042613' and CODIGO_TAB_PRECO='04'
update produtos_precos set  PRECO1_ANTERIOR=preco1, preco1 = 15.99, DATA_CARGA_PRECOS='20200304',DATA_PARA_TRANSFERENCIA=getdate() where produto = '70057918' and CODIGO_TAB_PRECO='04'
update produtos_precos set  PRECO1_ANTERIOR=preco1, preco1 = 15.99, DATA_CARGA_PRECOS='20200304',DATA_PARA_TRANSFERENCIA=getdate() where produto = '70057959' and CODIGO_TAB_PRECO='04'
update produtos_precos set  PRECO1_ANTERIOR=preco1, preco1 = 29.99, DATA_CARGA_PRECOS='20200304',DATA_PARA_TRANSFERENCIA=getdate() where produto = '49030645' and CODIGO_TAB_PRECO='04'
update produtos_precos set  PRECO1_ANTERIOR=preco1, preco1 = 15.99, DATA_CARGA_PRECOS='20200304',DATA_PARA_TRANSFERENCIA=getdate() where produto = '51033190' and CODIGO_TAB_PRECO='04'
update produtos_precos set  PRECO1_ANTERIOR=preco1, preco1 = 49.99, DATA_CARGA_PRECOS='20200304',DATA_PARA_TRANSFERENCIA=getdate() where produto = 'Z6010199' and CODIGO_TAB_PRECO='04'
update produtos_precos set  PRECO1_ANTERIOR=preco1, preco1 = 29.99, DATA_CARGA_PRECOS='20200304',DATA_PARA_TRANSFERENCIA=getdate() where produto = '70058031' and CODIGO_TAB_PRECO='04'


select PRECO1_ANTERIOR, preco1, DATA_CARGA_PRECOS, DATA_PARA_TRANSFERENCIA, produto, CODIGO_TAB_PRECO 
from produtos_precos where CODIGO_TAB_PRECO='04' and DATA_CARGA_PRECOS='20200304'