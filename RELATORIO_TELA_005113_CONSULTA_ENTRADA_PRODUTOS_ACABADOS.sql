select filial, p.fabricante, e.NOME_CLIFOR, cast(RECEBIMENTO as date) as RECEBIMENTO, sum(ei.QTDE_ITEM) as qtde
from entradas e
inner join entradas_item ei 
	on ei.NOME_CLIFOR=e.NOME_CLIFOR and ei.NF_ENTRADA = e.NF_ENTRADA and ei.SERIE_NF_ENTRADA  = e.serie_nf_entrada
inner join produtos p on p.produto = ei.CODIGO_ITEM
where recebimento >= '20181203' and recebimento <= '20181207'
		AND COD_TRANSACAO='ENTRADAS_102'
group by filial, p.fabricante, e.NOME_CLIFOR, cast(RECEBIMENTO as date)

