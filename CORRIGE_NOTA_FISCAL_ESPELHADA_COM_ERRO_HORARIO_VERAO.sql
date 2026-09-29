SELECT		EMISSAO, DATA_HORA_EMISSAO, dateadd(MI, -5, data_hora_emissao) as novo, UTC_DATA_SAIDA, UTC_EMISSAO, STATUS_NFE, *
FROM		FATURAMENTO (nolock)
WHERE		NF_SAIDA='000024169' and filial='CD NAVEGANTES'


update faturamento --set 
set UTC_DATA_SAIDA = 3, UTC_EMISSAO = 3, DATA_HORA_EMISSAO = dateadd(MI, -60, data_hora_emissao)
-- select * from faturamento
WHERE	emissao>='20181109'	and filial='CD NAVEGANTES' and status_nfe=4


select getdate()
update 
FATURAMENTO 
set UTC_DATA_SAIDA = 3, UTC_EMISSAO = 3, DATA_HORA_EMISSAO = '2018-11-06 16:00:00'
WHERE		NF_SAIDA='000024120' and filial='CD NAVEGANTES'

update faturamento set STATUS_NFE=3
where nf_saida = '000001473' and filial='CD BARRA VELHA'
000001473      
select * from FATURAMENTO where nf_saida = '000001473' and filial='CD BARRA VELHA'

select * from faturamento where nf_saida = '000024120'      


SELECT		EMISSAO, DATA_HORA_EMISSAO, UTC_DATA_SAIDA, UTC_EMISSAO, STATUS_NFE, *
FROM		FATURAMENTO 
WHERE STATUS_NFE = 5 AND EMISSAO BETWEEN '20181105' AND '20181106'

select * 
FROM		FATURAMENTO 
where nf_saida >='000024150'  and nf_saida    <='000024160'      
and status_nfe=4

update FATURAMENTO set UTC_DATA_SAIDA = 3, UTC_EMISSAO = 3
where nf_saida >='000024161'  and nf_saida    <='000024162'      
and status_nfe=4



SELECT * FROM FATURAMENTO WHERE EMISSAO ='20181108' and status_nfe=5


select * from fornecedores where fornecedor like '%LUCAS%'