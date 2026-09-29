select
	filial as origem,
	nome_clifor as lojadestino,
	format(emissao,'dd-MM-yyyy') as transferencia,
	cast(QTDE_TOTAL as int) as qtde_total,
	VALOR_TOTAL as valor_total,
	NATUREZA_SAIDA, 
	CHAVE_NFE,
	NF_SAIDA, 
	SERIE_NF,
	STATUS_NFE
from faturamento
where filial not like 'CD%' and NATUREZA_SAIDA='120.01'
and emissao > '20231231'
order by emissao,filial
