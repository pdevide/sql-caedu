--use CAEDU
--GO
/* 1) SABER SE TEM CAIXAS SEM VENDAS_PROD_EMBALADO */
select * 
--update a set FATURADO=1
from PDA_WMS_TB_EMBARQUE a
left join vendas_prod_embalado b on b.caixa=a.caixa
where a.FATURADO=0 
--AND DOCA LIKE '%morato%'
and b.caixa is null

/* 2) VERIFICAR STATUS DAS DISTRIBUIÇÕES DAS CAIXAS SE GEROU OU NÃO*/
select c.caixa, gerado, *
from CAEDU_RESERVA_AUTOMATICA c
where c.caixa in (select a.caixa 
from PDA_WMS_TB_EMBARQUE a
left join vendas_prod_embalado b on b.caixa=a.caixa
where a.FATURADO=0 and b.caixa is null
)

/* 3) SABER SE A(S) DISTRIBUIÇÃO DA(S) CAIXA(S) FOI EXCLUIDA(S) */
SELECT * 
FROM CGP_LOG_DISTRIBUICOES_EXCLUIDAS A 
INNER JOIN CGP_LOG_DISTRIBUICOES_EXCLUIDAS_ITENS B ON B.ID=A.ID
WHERE --B.CAIXA IN ('31863211')
b.caixa in ('31863439','31863440','31863441','31863442','31863445','31863446')

/* 4) SABER SE A CAIXA FOI TRANSFERIDA DE UMA FILIAL PARA OUTRA FILIAL*/
select a.*, b.filial 
from dbo.CGP_TRANSF_CAIXA_FILIAL a
inner join filiais b on b.cod_filial = a.filial_para
where --caixa in ('30910490')
caixa in ('31863439','31863440','31863441','31863442','31863445','31863446')

/* CORRIGE AS CAGADAS DAS VENDAS */ 
select a.caixa, a.DOCA, v.filial, v.FILIAL_DIGITACAO,  v.CLIENTE_ATACADO,fc.NOME_CLIFOR, ve.NOME_CLIFOR, ve.FILIAL
,'('+char(39)+RTRIM(a.caixa)+char(39)+','+char(39)+rtrim(v.pedido)+char(39)+'),',VP.PEDIDO, fp.nf_saida
--update v set APROVACAO='A', FILIAL='CD - SP - SAO ROQUE', FILIAL_DIGITACAO='CD - SP - SAO ROQUE'
--update ve set FILIAL='CD - SP - SAO ROQUE'
--UPDATE V SET APROVACAO='A', CLIENTE_ATACADO='SP SH CAMPO LIMPO', 
--REPRESENTANTE='SP SH CAMPO LIMPO', NOME_CLIFOR_ENTREGA='SP SH CAMPO LIMPO', GERENTE='SP SH CAMPO LIMPO'
--UPDATE VE SET NOME_CLIFOR='SP SH CAMPO LIMPO',REPRESENTANTE='SP SH CAMPO LIMPO'
--update fc SET NOME_CLIFOR='SP SH CAMPO LIMPO', NOME_CLIFOR_ENTREGA='SP SH CAMPO LIMPO'
--update a set FATURADO=0
from PDA_WMS_TB_EMBARQUE a
left join vendas v on v.pedido='CX-'+a.caixa
LEFT JOIN VENDAS_PRODUTO VP ON VP.PEDIDO='CX-'+a.caixa
left join VENDAS_PROD_EMBALADO ve on ve.caixa=a.caixa
left join faturamento_caixas fc on fc.caixa=a.CAIXA
left join faturamento_prod fp on fp.caixa = a.caixa
where 1=1 and a.FATURADO=0 
--and a.caixa in ('30097821')
--and a.caixa in ('31085785','31085921')
and a.caixa in (select x.caixa from PDA_WMS_TB_EMBARQUE x 
					left join vendas_prod_embalado b on b.caixa=x.caixa 
					where x.FATURADO=0 and b.caixa is null)
--and a.doca like 'SP SH CAMPO LIMPO PACK'
--and a.caixa in (select caixa from caedu_reserva_automatica where pedido='349195-1')
--and a.doca like 'sao matheus%' 

--and (v.filial  <> 'CD - SP - SAO ROQUE' or ve.FILIAL <> 'CD - SP - SAO ROQUE')
--and v.CLIENTE_ATACADO <> REPLACE(REPLACE(doca,'PACK',''),'CAIXA','')
--AND VE.NOME_CLIFOR <> REPLACE(REPLACE(doca,'PACK',''),'CAIXA','')
--and fc.NOME_CLIFOR  <> REPLACE(REPLACE(doca,'PACK',''),'CAIXA','')


/*RESUMO DAS DOCAS*/
select doca,count(a.caixa) as caixas_pda, 
	count(b.caixa) as caixas_linx, count(c.caixa) as faturadas
from PDA_WMS_TB_EMBARQUE a
left join VENDAS_PROD_EMBALADO b on b.CAIXA =a.CAIXA
left join FATURAMENTO_PROD c on c.caixa=a.caixa
where faturado=0 
group by doca
having count(a.caixa) <> count(b.caixa)


select v.pedido pedido_venda,
		vp.pedido pedido_vp,ve.pedido pedido_emb,
		a.caixa, fp.nf_saida, pp.preco1, a.*
from caedu_reserva_automatica a
left join vendas v on v.pedido=a.venda
left join vendas_produto vp on vp.pedido=a.venda
left join VENDAS_PROD_EMBALADO ve on ve.pedido=a.venda
left join faturamento_prod fp on fp.caixa=a.caixa
left join produtos_precos pp on pp.CODIGO_TAB_PRECO='02' and pp.produto=a.produto
where a.pedido = '349548' and fp.NF_SAIDA is null

select * from CAEDU_RESERVA_AUTOMATICA_PACK_WMS where produto='55060904'


select * from estoque_produtos where produto='55060904' and filial = 'CD - SP - SAO ROQUE'

select v.pedido,vp.pedido,ve.pedido, vp.cor_produto, ve.COR_PRODUTO,*
--'('+char(39)+replace(RTRIM(vp.pedido),'CX-','')+char(39)+','+char(39)+rtrim(v.pedido)+char(39)+'),'
--update ve set COR_PRODUTO='00083'
from vendas v
left join vendas_produto vp on vp.PEDIDO=v.pedido
left join VENDAS_PROD_EMBALADO ve on ve.PEDIDO=v.pedido
where vp.PRODUTO='55060904' and ve.COR_PRODUTO is null



select * from produtos_packs_permitidos where PRODUTO='55060904'

select * from compras_produto where PRODUTO='55060904' 

select * from cores_basicas


select nf_saida,* 
update a set FATURADO=1
from PDA_WMS_TB_EMBARQUE a
left join faturamento_prod b on b.caixa=a.caixa
where a.FATURADO=0 
--AND DOCA LIKE '%guaru%'
and b.caixa is not null


select * 
from CGP_LOG_DISTRIBUICOES_EXCLUIDAS a
inner join CGP_LOG_DISTRIBUICOES_EXCLUIDAS_ITENS b 
			on b.id=a.id
where b.caixa in ('34657045','34657073')


select * from caedu_reserva_automatica_pack_wms b
where b.caixa in ('34657045','34657073')

select * from dbo.CGP_PDA_WMS_STATUS_DISTRIBUICAO
where distribuicao in ('354388','350580')

select gerado, caixa, * 
from caedu_reserva_automatica a
inner join vendas v on v.pedido=a.venda
where a.pedido='359691'

--delete from caedu_reserva_automatica where caixa='34143224'
--delete from caedu_reserva_automatica where caixa='34143616'


select gerado,a.caixa, b.pedido, c.pedido, d.pedido, e.nf_saida, a.* 
from CAEDU_RESERVA_AUTOMATICA a 
--inner join vendas b on b.pedido=a.venda
left join VENDAS_PROD_EMBALADO b on b.pedido=a.venda
left join VENDAS_PRODUTO c on c.pedido=a.venda
left join VENDAS d on d.pedido=a.venda
left join FATURAMENTO_PROD e on e.caixa=a.caixa
where 1=1
and b.caixa is null 
--and a.pedido in ('359342','358155E','356744')
and a.caixa in (
select caixa from pda_wms_tb_embarque where faturado=0 and DOCA LIKE 'JAÇA%'
)

select *
--update a set faturado=1
from PDA_WMS_TB_EMBARQUE a 
inner join faturamento_prod b on b.caixa=a.caixa
where 1=1
and a.doca like 'SP - SANTO AMARO%' 
and data>'20251222'
and faturado=0

select b.nf_saida, a.* 
--update a set faturado=1
from pda_wms_tb_embarque a
inner join faturamento_prod b on b.caixa=a.caixa
where a.doca = 'SP - PIRAPORINHA CAIXA'
and a.faturado=0

SELECT * FROM VENDAS_PROD_EMBALADO 
WHERE CAIXA IN (
select a.caixa
--UPDATE A SET GERADO=1
from caedu_reserva_automatica a 
left join faturamento_prod fp on fp.caixa = a.caixa
where 1=1
and fp.nf_saida is null
and a.pedido = '371173'
)

update caedu_reserva_automatica set data = '20260213' where pedido = '370226'


select * from CAEDU_LISTA_COMBO where id_dominio='026'

/* verifica as caixas da mesma distribuição */
select * from caedu_reserva_automatica where caixa = '37167932'       
--*************************************************************
select fp.nf_saida, ve.pedido, a.*
from caedu_reserva_automatica a 
left join faturamento_prod fp on fp.caixa = a.caixa
left join vendas_prod_embalado ve on ve.caixa=a.caixa
where a.pedido = '378683'
--*************************************************************
