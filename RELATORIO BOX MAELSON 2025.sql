select (select top 1 t1.distribuicao from (select pedido as distribuicao from caedu_reserva_automatica
			where caixa = ve.caixa
		union all
		select distribuicao from caedu_reserva_automatica_pack_wms
					where caixa = ve.caixa) as T1
		) as distribuicao,
ve.NOME_CLIFOR, ve.produto, ve.COR_PRODUTO, 
p.DESC_PRODUTO, p.grade, p.erp_qtd_pack, p.griffe, p.linha, p.GRUPO_PRODUTO, p.SUBGRUPO_PRODUTO,
ve.FILIAL, ve.ITEM, ve.PEDIDO, ve.CAIXA, ve.ENTREGA,
ve.REPRESENTANTE,ve.PRECO1, ve.QTDE_EMBALADA, ve.VALOR_EMBALADO
,ve.E1,ve.E2,ve.E3,ve.E4,ve.E5,ve.E6,ve.E7,ve.E8,ve.E9,ve.E10,ve.E11
,ve.E12,ve.E13,ve.E14,ve.E15,ve.E16
from vendas_prod_embalado ve
inner join produtos p on p.produto=ve.produto
where ve.pedido like 'CX-%'
