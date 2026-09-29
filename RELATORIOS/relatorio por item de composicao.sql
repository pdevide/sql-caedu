--Se precisarem do comando no futuro segue abaixo
 
--Exemplo de geração de relatório para o mês 10/2020:
 
select * INTO REL_ITENS_COMPOSICAO_10_2020
from FX_CM_MONTA_CARDEX_PA_SALDO_INICIAL_FINAL ('%','%','%','20201001','20201031',0,'202010')
 


	
--Faço um "select into" para jogar os dados em uma tabela física temporária para fazer a extração dos dados posteriormente
--	Os parâmetros alterados na função são:
--	- Primeiro dia do mês no formato aaaammdd(20201001)
--	- Último dia do mês no formato aaaammdd(20201031)
--	- E competência no formato aaaamm(202010)
--	- Esses parâmetros são alterados de acordo com a competência solicitada pelos usuários, os demais parâmetros são fixos
