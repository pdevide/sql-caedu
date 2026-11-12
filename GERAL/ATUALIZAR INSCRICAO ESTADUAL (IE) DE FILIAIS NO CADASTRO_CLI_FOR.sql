--Ajustar a IE no LINX ERP, para a filial "MG RUA UBERLANDIA CT" 46377727011128 para o novo número 0040389500672, por favor?


select c.RG_IE,c.cobranca_ie, c.ENTREGA_IE,c.*
--update c set RG_IE = '0040389500672', COBRANCA_IE='0040389500672', ENTREGA_IE='0040389500672'
from cadastro_cli_for c 
inner join filiais f on f.clifor=c.clifor 
and c.nome_clifor = 'MG RUA UBERLANDIA CT'