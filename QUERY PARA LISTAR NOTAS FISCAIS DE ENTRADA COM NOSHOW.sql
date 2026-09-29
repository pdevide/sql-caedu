select a.FILIAL, a.NOME_CLIFOR, a.NF_ENTRADA, a.SERIE_NF_ENTRADA, a.PEDIDO, a.EMISSAO,
' | ' , Y.*,
' | ' , 
g.NF_ENTRADA, G.FILIAL, g.NATUREZA, G.SERIE_NF, G.RECEBIMENTO, G.EMISSAO, G.FATURA, G.QTDE_TOTAL, G.VALOR_TOTAL, G.CTB_LANCAMENTO,
' | ' , 
DATEPART(ww,Y.limite_entrega) as Semana_pedido,   DATEPART(ww,G.RECEBIMENTO) as Semana_NF,   
( DATEPART(ww,Y.limite_entrega) -  DATEPART(ww,G.RECEBIMENTO) ) as FLAG,
H.*, 
(select top 1 DATA_ALTERACAO_ENTREGA 
	from CAEDU_COMPRAS_ENTREGA_LOG 
	where CAEDU_COMPRAS_ENTREGA_LOG.PEDIDO = y.pedido_compras
	order by PEDIDO, DATA_ALTERACAO_ENTREGA desc) as DATA_ALTERACAO_ENTREGA, 
(select top 1 DATA_ENTREGA_NOVA 
	from CAEDU_COMPRAS_ENTREGA_LOG 
	where CAEDU_COMPRAS_ENTREGA_LOG.PEDIDO = y.pedido_compras
	order by PEDIDO, DATA_ALTERACAO_ENTREGA desc) as DATA_ENTREGA_NOVA, 
(select top 1 MOTIVO 
	from CAEDU_COMPRAS_ENTREGA_LOG 
	where CAEDU_COMPRAS_ENTREGA_LOG.PEDIDO = y.pedido_compras
	order by PEDIDO, DATA_ALTERACAO_ENTREGA desc) as MOTIVO, 
(select top 1 USUARIO 
	from CAEDU_COMPRAS_ENTREGA_LOG 
	where CAEDU_COMPRAS_ENTREGA_LOG.PEDIDO = y.pedido_compras
	order by PEDIDO, DATA_ALTERACAO_ENTREGA desc) as USUARIO

from estoque_prod_ent a
       left join (select a.pedido as pedido_compras, a.fornecedor, a.emissao, a.TOT_QTDE_ORIGINAL, a.TOT_QTDE_ENTREGAR, a.TOT_VALOR_ORIGINAL, a.TOT_VALOR_ENTREGAR, a.tipo_compra,
                           MAX(b.LIMITE_ENTREGA) as limite_entrega  
                           from compras a , COMPRAS_PRODUTO b
                           where a.pedido = b.pedido 
                           group by a.pedido, a.fornecedor, a.emissao, a.TOT_QTDE_ORIGINAL, a.TOT_QTDE_ENTREGAR, a.TOT_VALOR_ORIGINAL, a.TOT_VALOR_ENTREGAR, a.tipo_compra
                           ) Y
                           on a.pedido = y.pedido_compras
       left join ENTRADAS G
       on a.nf_entrada = g.nf_entrada
       and a.serie_nf_entrada = g.serie_nf_entrada
       and a.NOME_CLIFOR = G.NOME_CLIFOR
       left join (select Y.DATA_PAGAMENTO, Y.DESCONTO_EFETIVADO, Y.DESCONTO_EFETIVADO_PADRAO,  Y.DESCONTO_OBTIDO, Y.ID_PARCELA, Y.LANCAMENTO, Y.LANCAMENTO_MOV,
                           Z.LX_TIPO_LANCAMENTO, Z.DATA_DIGITACAO, Z.DEBITO, substring(Z.HISTORICO,1,50) as HIST
                           from CTB_A_PAGAR_MOV Y 
                           left join CTB_LANCAMENTO_ITEM Z
                           on Y.LANCAMENTO = Z.LANCAMENTO and Z.LX_TIPO_LANCAMENTO = 'BTP'
                           and Z.HISTORICO like '%NOSHOW%'
                           ) H
                           on G.CTB_LANCAMENTO = H.LANCAMENTO_MOV

where Y.pedido_compras is not null
and a.EMISSAO >='20260101'
and G.NATUREZA = '200.01'
and a.nome_clifor NOT IN ('KOMPORT','HARPIA IMPORTADORA E DIST')
and ( DATEPART(ww,Y.limite_entrega) -  DATEPART(ww,G.RECEBIMENTO) ) <> 0
--and H.DATA_PAGAMENTO is not null
--order by a.EMISSAO desc
order by H.DATA_PAGAMENTO desc



