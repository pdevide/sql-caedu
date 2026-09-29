/*nome_clifor,nf_saida,qtde_total,chave_nfe,emissao
select data, sum(qtde_total) as qtde_total
from caedu_reserva_automatica
where data between '20250401' and '20250423' 
group by data

select data, sum(qtde_total) as qtde_total
from caedu_reserva_automatica_pack_wms
where data between '20250401' and '20250423' 
group by data
order by data asc

USE CAEDU

select zz.DATA_DISTRIBUICAO,   sum(zz.qtde_total) as qtde_total
from (
SELECT T1.DISTRIBUICAO, T3.FABRICANTE AS FORNECEDOR, T1.FILIAL_ORIGEM,       
T3.PRODUTO, T3.DESC_PRODUTO, T3.GRIFFE,         
T3.LINHA, T3.GRUPO_PRODUTO, T3.SUBGRUPO_PRODUTO, T3.GRADE,        
T1.DATA AS DATA_DISTRIBUICAO, CAST(MONTH(T1.DATA) AS INT) AS MES_DISTRIBUICAO,        
CAST(YEAR(T1.DATA) AS INT) AS ANO_DISTRIBUICAO,        
FATURADO =       
CASE               WHEN ISNULL(T4.NF_SAIDA,'')>'' THEN 'SIM'              
ELSE 'NÃO'      END,      
T1.CAIXA, T1.FILIAL AS FILIAL_DESTINO, T4.NF_SAIDA, T4.SERIE_NF, 
T2.EMISSAO AS EMISSAO_NF,        
CAST(MONTH(T2.EMISSAO) AS INT) AS MES_EMISSAO_NF,        
CAST(YEAR(T2.EMISSAO) AS INT) AS ANO_EMISSAO_NF,           
T3.ERP_QTD_PACK AS QTDE_PACK, 
t1.qtde_total
FROM CAEDU_RESERVA_AUTOMATICA_WMS T1 (NOLOCK)       
LEFT JOIN PRODUTOS T3 ON T3.PRODUTO = T1.PRODUTO     
LEFT JOIN FATURAMENTO_PROD T4 ON T4.CAIXA = T1.CAIXA AND T4.PRODUTO = T1.PRODUTO AND T4.COR_PRODUTO = T1.COR_PRODUTO      
LEFT JOIN FATURAMENTO T2 ON T2.NF_SAIDA = T4.NF_SAIDA AND T2.SERIE_NF = T4.SERIE_NF AND T2.FILIAL = T4.FILIAL
where data between '20250401' and '20250423') as ZZ
group by zz.DATA_DISTRIBUICAO
order by zz.DATA_DISTRIBUICAO

select count(*) 
from [ccp\paulo.devide].[vw_pda_caixas_3]
--2028


select distinct nome_clifor --'insert into curlojas values ('+ char(34) + rtrim(nome_clifor) + char(34) + ')'  
from [ccp\paulo.devide].[vw_pda_caixas_3] 
order by 1 desc

nome_clifor,nf_saida,qtde_total,chave_nfe,emissao/
*/

declare @filial varchar(25), @volume int

set @filial = 'VILA FORMOSA'
set @volume = 136

select chave_nfe,nome_clifor,nf_saida,qtde_total,chave_nfe,emissao,status_nfe 
from faturamento 
where emissao = '20250502' 
and nome_clifor = @filial 
and qtde_total = @volume



--update caedu_reserva_automatica set data = '20250424'
--select distinct pedido, data
--from caedu_reserva_automatica
--where pedido in ('353944','353940','353942')


--select nome_clifor,nf_saida,qtde_total,chave_nfe,emissao 
--from 
--compras_produto  
--where pedido in ('353944','353940','353942')

--select data_cadastramento,nome_clifor,nf_saida,qtde_total,chave_nfe,emissao from produtos 
--where produto in (
--'A0040332', 'A0040333', 'A0040334')    

--select nome_clifor,nf_saida,qtde_total,chave_nfe,emissao 