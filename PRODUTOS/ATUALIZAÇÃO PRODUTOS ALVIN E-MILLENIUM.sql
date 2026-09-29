--Olá Paulo Eduardo Devide por gentileza, 
--refazer o processo de atualização de preço e estoque dos 
--produtos 01225266 e M1050017 que você fez na semana passada, 
--por gentileza, não esquecendo da data de transferência, pode me as evidencias novamente após a alteração, para fazer uma nova validação hoje ? 


select * 
--update a set preco1 = 31.99
from produtos_precos a 
where CODIGO_TAB_PRECO='73' and produto = 'M1050017'

--update produtos set DATA_PARA_TRANSFERENCIA = getdate() where produto = 'M1050017'

select DATA_PARA_TRANSFERENCIA, * from produtos where produto = 'M1050017'

