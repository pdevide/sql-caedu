select f.filial, f.nf_saida, f.serie_nf, f.EMISSAO, f.VALOR_TOTAL,fp.ITEM_IMPRESSAO ,fp.PRODUTO, fp.COR_PRODUTO, fp.QTDE,  fp.PRECO, fp.VALOR
from faturamento f
inner join FATURAMENTO_PROD fp 
		on fp.NF_SAIDA=f.NF_SAIDA and fp.FILIAL=f.FILIAL and fp.SERIE_NF=f.SERIE_NF
where	1=1 
		and (f.EMISSAO between '20190101' and '20190630')
		and f.NATUREZA_SAIDA = '128.01' 
order by fp.nf_saida, fp.ITEM_IMPRESSAO


