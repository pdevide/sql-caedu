select um.* 
from users u
inner join USERS_MODULOS um on um.USUARIO=u.USUARIO
where u.usuario like 'CCP\FABIANA.SANTOS'

select um.* 
from users u
inner join USERS_MODULOS um on um.USUARIO=u.USUARIO
where u.usuario like 'CCP\JOAO.NETO'

select ut.* 
from users u
inner join USERS_TRANSACOES ut on ut.USUARIO=u.USUARIO
where u.usuario like 'CCP\FABIANA.SANTOS' and COD_TRANSACAO='LX999319_001'

select ut.* 
--update ut set ACESSO_BLOQUEADO=0,INCLUIR=1,ALTERAR=1,EXCLUIR=1,PESQUISAR=1,PESQUISA_ESPECIAL=1,IMPRIMIR=1,CRIAR_RELATORIO=1,ITEM_EXCLUIR=1,ITEM_INCLUIR=1
from users u
inner join USERS_TRANSACOES ut on ut.USUARIO=u.USUARIO
where u.usuario like 'CCP\JOAO.NETO' and COD_TRANSACAO='LX999319_001'


select * from PARAMETROS where PARAMETRO like '%999%'

select * from PARAMETROS_USERS where usuario in ('CCP\FABIANA.SANTOS','CCP\JOAO.NETO')
order by PARAMETRO, usuario

insert into PARAMETROS_USERS 
values
('CCP\JOAO.NETO','ACESSO_LIBERA_TABPRECO','.T.',getdate()),            
('CCP\JOAO.NETO','PALMA_ACESSO_999309','.T.',getdate()),            
('CCP\JOAO.NETO','PALMA_BOTAO_GERAR_DISTRIB','CCP\JOAO.NETO',getdate()),            
('CCP\JOAO.NETO','PALMA_LIMITE_SALDO_OTB','100000',getdate()),            
('CCP\JOAO.NETO','PALMA_LIBERA_HORARIO','.T.',getdate())

select * from TRANSACOES where COD_TRANSACAO='LX999319_001'
