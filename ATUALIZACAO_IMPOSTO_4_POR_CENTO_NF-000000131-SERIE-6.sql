select * from faturamento where nf_saida = '000000131' and serie_nf='6' and filial='NOVO SP - ATACADO 2'

select * from FATURAMENTO_IMPOSTO where nf_saida = '000000131' and serie_nf='6' and filial='NOVO SP - ATACADO 2'


UPDATE 
FATURAMENTO_IMPOSTO 
SET TAXA_IMPOSTO = 4,
VALOR_IMPOSTO = 305.63,
VALOR_IMPOSTO_CALCULADO = 305.63
where nf_saida = '000000131' and serie_nf='6' and filial='NOVO SP - ATACADO 2' AND ID_IMPOSTO = 1