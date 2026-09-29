insert into PARAMETROS_USERS
select usuario, 'PALMA_ACESSO_999409', valor_atual_user, getdate()
from PARAMETROS_USERS where PARAMETRO = 'PALMA_ACESSO_999309'
and usuario <> 'CCP\ADRIANA.ALVES'