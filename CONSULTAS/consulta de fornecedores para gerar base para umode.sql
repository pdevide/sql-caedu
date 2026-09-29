select a.CLIFOR as reference,
a.NOME_CLIFOR as name,
a.CIDADE as city,
a.UF as state,
a.PAIS as country,
a.OBS_DE_FATURAMENTO as observations,
a.CGC_CPF as cnpj,
a.razao_social as corporate_name,
a.EMAIL_NFE as email,
a.TELEFONE1 as whatsapp,
a.TELEFONE1 as phone,
null as shipping_company,
null as state_registration,
null as representative,
null as segment,
null as supplier_type,
case when a.inativo = 1 then 0 
else 1 
end as active,
a.DATA_PARA_TRANSFERENCIA
from CADASTRO_CLI_FOR a
inner join FORNECEDORES b ON b.CLIFOR=A.CLIFOR
WHERE b.FORNECE_PROD_ACAB=1
