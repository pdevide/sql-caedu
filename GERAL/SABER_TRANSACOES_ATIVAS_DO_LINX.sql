select * from transacoes
where COD_TRANSACAO in (select COD_TRANSACAO from TRANSACOES_NAVEGA where HABILITADO=1)


