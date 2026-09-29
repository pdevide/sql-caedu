select count(*)
/*	
	a.ROMANEIO_PRODUTO,
	a.filial as loja,
	CODIGO_LOJA
	a.emissao as data,
	a.enb_terminal as ecf,
	a.enb_coo as cupom,
	b.qtde,
	b.valor,
	b.produto, 
	b.cor_produto,
	b.enb_codigo_barra as codigo_barra,
	a.NF_ENTRADA,
	a.SERIE_NF_ENTRADA
*/	
from estoque_prod_ent a
inner join 
	estoque_prod1_ent b
		on b.romaneio_produto = a.romaneio_produto and b.filial = a.filial
where 
	a.ROMANEIO_PRODUTO <> ''  
	and (a.emissao between '20151001' and '20170430')
	and a.RESPONSAVEL = 'INTEGRAÇÃO.EMSEMBLE' 
	and a.CM_OPERACAO = '005' 
	and a.TIPO_ROMANEIO = 'DEVOLUCAO DE VENDA'
	and a.NF_ENTRADA is not null
	
	--select 1626223 - 1572429
	--53794