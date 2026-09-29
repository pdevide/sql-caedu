
select 
		fi.NF_SAIDA,	
		fi.FILIAL,
		fi.CODIGO_ITEM,	
		fi.DESCRICAO_ITEM,	
		fi.QTDE_ITEM,
		FI.PRECO_UNITARIO,
		fi.VALOR_ITEM,
		fi.CLASSIF_FISCAL,
		fi.CODIGO_FISCAL_OPERACAO,
		p.INDICADOR_CFOP
from	faturamento f
inner join FATURAMENTO_ITEM fi 
	on fi.NF_SAIDA = f.NF_SAIDA 
		and fi.FILIAL = f.FILIAL 
		and fi.SERIE_NF = f.SERIE_NF
inner join produtos p on p.produto = fi.CODIGO_ITEM
where f.NATUREZA_SAIDA = '199.06' 