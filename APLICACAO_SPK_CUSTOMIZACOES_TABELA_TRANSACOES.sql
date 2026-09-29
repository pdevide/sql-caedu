declare @codigo varchar(50) 

set @codigo = 'PRODUTOS_001'

select * from transacoes a where a.COD_TRANSACAO = @codigo;

/*

--update transacoes set control_sistema = '001015GP0' WHERE COD_TRANSACAO = 'CLIENTES_001';

--update transacoes set control_sistema = '004006GP0' WHERE COD_TRANSACAO = 'COMPRAS_999' ;

--update transacoes set control_sistema = '002006GP0' WHERE COD_TRANSACAO = 'PRODUTOS_001';

--update transacoes set control_sistema = '002005GP0' WHERE COD_TRANSACAO = 'PRODUTOS_GRIFFES_001';

--update transacoes set control_sistema = '100101GP0' WHERE COD_TRANSACAO = 'FATURAMENTO_022';

--update transacoes set control_sistema = '100102GP0' WHERE COD_TRANSACAO = 'FATURAMENTO_023';

--update transacoes set control_sistema = '100132GP0' WHERE COD_TRANSACAO = 'FATURAMENTO_052';

--update transacoes set control_sistema = '100135GP0' WHERE COD_TRANSACAO = 'FATURAMENTO_054';

--update transacoes set control_sistema = '005102GP3' WHERE COD_TRANSACAO = 'ENTRADAS_102';

--update transacoes set control_sistema = '005015GP0' WHERE COD_TRANSACAO = 'ESTOQUE_PROD_CONTA_001';

*/

