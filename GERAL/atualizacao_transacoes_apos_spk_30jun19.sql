select a.control_sistema,* FROM TRANSACOES a WHERE LEFT(a.CONTROL_SISTEMA ,6) IN 
('001013'
,'001015'
,'001016'
,'004006'
,'005015'
,'005102'
,'005109'
,'009022'
,'009140'
,'009150'
,'100101'
,'100102'
,'100132'
,'100135'
,'120007'
,'150008'
,'002006'
,'100136')
order by a.control_sistema

update transacoes set control_sistema = '002006CSM' where cod_transacao = 'PRODUTOS_001';
update transacoes set control_sistema = '004006CSM' where cod_transacao = 'COMPRAS_999';
update transacoes set control_sistema = '100132CSM' where cod_transacao = 'FATURAMENTO_052';
update transacoes set control_sistema = '100135CSM' where cod_transacao = 'FATURAMENTO_054';
