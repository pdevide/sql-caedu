/*
select c.nf_saida, b.doca, b.faturado, * 
from [ccp\paulo.devide].TB_ESTOQUE_PDA_10JUNHO25 a
inner join PDA_WMS_TB_EMBARQUE b on b.caixa = a.caixa
left join faturamento_prod c on c.caixa=a.caixa
*/


with base_pedido (pedido,data,data_unous,caixa,QTDE_TOTAL,caixa_faturada,
				filial_distribuicao,filial_emitente,filial_faturada,
				nf_saida,serie_nf,chave_nfe,natureza_saida,loja_destino_caixa)
as (
select	a.pedido,
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
		c.NATUREZA_SAIDA,
		d.NOME_CLIFOR AS LOJA_DESTINO_CAIXA
from CAEDU_RESERVA_AUTOMATICA a
left join faturamento_prod b on b.caixa=a.caixa
left join faturamento c on c.nf_saida=b.NF_SAIDA and c.SERIE_NF=b.SERIE_NF and c.FILIAL=b.FILIAL
left join FATURAMENTO_CAIXAS d on d.caixa=a.caixa
where a.DATA > '20250101'
)

select  pedido,	
		LOJA_DESTINO_CAIXA,	
		COUNT(FILIAL_DISTRIBUICAO) AS QTD_FILIAL_DISTRIBUICAO,
		COUNT(FILIAL_FATURADA) AS QTD_FILIAL_FATURADA
from base_pedido
WHERE 1=1 --FILIAL_FATURADA IS NOT NULL
--AND DISTRIBUICAO='00034715'
GROUP BY pedido,	
		LOJA_DESTINO_CAIXA	
having COUNT(FILIAL_DISTRIBUICAO)<>COUNT(FILIAL_FATURADA) and COUNT(FILIAL_DISTRIBUICAO)>0 and COUNT(FILIAL_FATURADA)>0
ORDER BY pedido

--distribuicao	FILIAL_DISTRIBUICAO	FILIAL_FATURADA	Soma de QTDE_TOTAL	Contagem de caixa	Contagem de caixa_faturada
