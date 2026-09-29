with base_pedido (origem,pedido,data,data_unous,caixa,QTDE_TOTAL,caixa_faturada,
				filial_distribuicao,filial_emitente,filial_faturada,
				nf_saida,serie_nf,chave_nfe,emissao,natureza_saida,loja_destino_caixa)
as (
select	'P' as origem,
		a.pedido as distribuicao,
		A.DATA,
		A.DATA_UNOUS,
		a.caixa, 
		A.QTDE_TOTAL,
		b.caixa as caixa_faturada,
		a.FILIAL as FILIAL_DISTRIBUICAO,
		c.FILIAL as FILIAL_EMITENTE,
		c.NOME_CLIFOR AS FILIAL_FATURADA,
		c.NF_SAIDA,
		c.SERIE_NF,
		c.CHAVE_NFE,
		c.emissao,
		c.NATUREZA_SAIDA,
		d.NOME_CLIFOR AS LOJA_DESTINO_CAIXA
from CAEDU_RESERVA_AUTOMATICA a
left join faturamento_prod b on b.caixa=a.caixa
left join faturamento c on c.nf_saida=b.NF_SAIDA and c.SERIE_NF=b.SERIE_NF and c.FILIAL=b.FILIAL
left join FATURAMENTO_CAIXAS d on d.caixa=a.caixa
where a.DATA > '20250101'
)
SELECT * FROM base_pedido

go

with base_wms (origem,distribuicao,data,data_unous,caixa,QTDE_TOTAL,caixa_faturada,
				filial_distribuicao,filial_emitente,filial_faturada,
				nf_saida,serie_nf,chave_nfe,emissao,natureza_saida,loja_destino_caixa)
as (
select	'W'  AS ORIGEM,
		a.distribuicao,
		A.DATA,
		A.DATA_UNOUS,
		a.caixa, 
		A.QTDE_TOTAL,
		b.caixa as caixa_faturada,
		a.FILIAL as FILIAL_DISTRIBUICAO,
		c.FILIAL as FILIAL_EMITENTE,
		c.NOME_CLIFOR AS FILIAL_FATURADA,
		c.NF_SAIDA,
		c.SERIE_NF,
		c.CHAVE_NFE,
		c.EMISSAO,
		c.NATUREZA_SAIDA,
		d.NOME_CLIFOR AS LOJA_DESTINO_CAIXA
from CAEDU_RESERVA_AUTOMATICA_PACK_WMS a
left join faturamento_prod b on b.caixa=a.caixa
left join faturamento c on c.nf_saida=b.NF_SAIDA and c.SERIE_NF=b.SERIE_NF and c.FILIAL=b.FILIAL
left join FATURAMENTO_CAIXAS d on d.caixa=a.caixa
where a.DATA > '20250101'
)
select * from base_wms
GO

SELECT * FROM [ccp\paulo.devide].TB_ESTOQUE_PDA_10JUNHO25
go

select * from pda_wms_tb_embarque where data>'20250101'


