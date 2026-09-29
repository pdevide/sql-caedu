select fat.FILIAL, fat.NOME_CLIFOR, fat.EMISSAO, 
		fat.NF_SAIDA, fat.SERIE_NF, fat.TIPO_FATURAMENTO,
		fat.NATUREZA_SAIDA, fat.COD_TRANSACAO, fat.VALOR_TOTAL, 
		fat.QTDE_TOTAL, fat.TABELA_FILHA, cast(fat.OBS as varchar(100)) OBS, fat.NOTA_CANCELADA,
		fat.STATUS_NFE, fat.CHAVE_NFE, fat.DATA_CANCELAMENTO
from faturamento fat 
inner join 
(select f.filial
from filiais f
inner join INFO_LOJAS i on i.LOJA=f.FILIAL
where 
	FILIAL not like 'CD%' 
	and FILIAL not like 'VENDA%'
	and FILIAL not like 'POS%'
	and FILIAL not like 'REJEITADO%'
	and FILIAL not like 'CAEDU%') as lojas
on lojas.FILIAL = fat.FILIAL	
where fat.EMISSAO>= '20240101' and fat.EMISSAO<'20240201'