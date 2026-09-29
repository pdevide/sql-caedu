--Mês|código do item|Quantidade|Valor item|Unidade de medida|chave Nf-e|CFOP
select cast(e.RECEBIMENTO as date) as RECEBIMENTO, month(e.RECEBIMENTO) as mes, e.NATUREZA,ei.codigo_item, ei.QTDE_ITEM, ei.valor_item,e.CHAVE_NFE, 
ei.CLASSIF_FISCAL, ei.INDICADOR_CFOP, ei.CODIGO_FISCAL_OPERACAO, ei.UNIDADE, ei.DESCRICAO_ITEM, ei.ID_EXCECAO_IMPOSTO,
e.NF_ENTRADA, e.SERIE_NF_ENTRADA, e.NOME_CLIFOR
from entradas E
inner join 
	ENTRADAS_ITEM ei 
		on ei.NF_ENTRADA=e.NF_ENTRADA and  ei.SERIE_NF_ENTRADA=e.SERIE_NF_ENTRADA and ei.NOME_CLIFOR=e.NOME_CLIFOR
where 
	(E.RECEBIMENTO between '20150701' and '20151231')
	and (E.filial = 'CD REGIS')
order by E.RECEBIMENTO


