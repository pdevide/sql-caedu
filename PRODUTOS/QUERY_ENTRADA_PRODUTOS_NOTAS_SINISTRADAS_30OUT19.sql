select fp.NF_SAIDA, fp.SERIE_NF, fp.FILIAL, fp.PRODUTO, fp.COR_PRODUTO, fp.QTDE, fp.PRECO, fp.VALOR,  
F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14, F15, F16
from faturamento f
inner join faturamento_prod fp on fp.NF_SAIDA=f.NF_SAIDA and fp.FILIAL = f.FILIAL and fp.SERIE_NF = f.SERIE_NF
where f.nf_saida in 
('000023558','000023559','000023561','000023564','000023565','000023567','000023570') 
and F.filial = 'CD CAJAMAR'

