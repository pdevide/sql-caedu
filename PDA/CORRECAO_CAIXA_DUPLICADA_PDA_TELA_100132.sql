/*
CAIXA			DOCA
=============== =================
109708131098792	MAUA PACK
109469581094740	PRAIA GRANDE PACK

SP - PIRAPORINHA CAIXA 109901981096341
*/

--DELETE FROM PDA_WMS_TB_EMBARQUE WHERE CAIXA ='110731661110139'	and doca ='CIDADE TIRADENTES PACK'
--VARZEA PAULISTA PACK


--select * from PDA_WMS_TB_EMBARQUE where doca like 'IPIRANGA%' AND DATA>='20180718'
select * from PDA_WMS_TB_EMBARQUE  where len(caixa) > 8 AND FATURADO=0

select * from filiais where filial like '%registro%'

declare @doca varchar(50) = 'REGISTRO CAIXA'
declare @filial varchar(25) = 'REGISTRO'
declare @encavalado varchar(15) = '130189041301890'
declare @parte1 varchar(7) = left(@encavalado,7)
declare @parte2 varchar(7) = right(@encavalado,7)

--parte 1
select * from PDA_WMS_TB_EMBARQUE WHERE DOCA LIKE @doca AND FATURADO=0  and caixa like @parte1+'%'
select * from vendas_prod_embalado where nome_clifor = @filial AND caixa like @parte1+'%'
--parte 2
select * from PDA_WMS_TB_EMBARQUE WHERE DOCA LIKE @doca AND FATURADO=0  and caixa like @parte2+'%'
select * from vendas_prod_embalado where nome_clifor = @filial AND caixa like @parte2+'%'

DELETE FROM PDA_WMS_TB_EMBARQUE where doca = 'IPIRANGA PACK' and caixa = '116792171167921'

update PDA_WMS_TB_EMBARQUE set caixa='13017821' where doca = 'BARUERI CAIXA' and caixa = '130178211301782'

/*RESOLU��O DELETE NO CAIXA DUPLICADA, POIS ELA � ENCONTRADA NOS DOIS SELECTS ACIMA, TANTO OS 7 PRIMEIROS
DA ESQUERDA PARA DIREITA QUANTO OS 7 ULTIMOS DA DIREITA PARA A ESQUERDA 
AS CAIXAS SAO ENCONTRADAS NOS DOIS SELECTS
*/
DELETE from PDA_WMS_TB_EMBARQUE WHERE DOCA LIKE 'MAUA PACK' AND FATURADO=0  and caixa = '109708131098792'


-- 109469581094740	PRAIA GRANDE PACK
select * from PDA_WMS_TB_EMBARQUE WHERE DOCA LIKE 'PRAIA GRANDE PACK' AND FATURADO=0  and caixa like '1094695%'
select * from vendas_prod_embalado where nome_clifor = 'PRAIA GRANDE' AND caixa like '1094695%'

select * from PDA_WMS_TB_EMBARQUE WHERE DOCA LIKE 'PRAIA GRANDE PACK' AND FATURADO=0  and caixa like '1094740%'
select * from vendas_prod_embalado where nome_clifor = 'PRAIA GRANDE' AND caixa like '1094740%'
/*RESOLU��O DELETE NO CAIXA DUPLICADA, POIS ELA � ENCONTRADA NOS DOIS SELECTS ACIMA, TANTO OS 7 PRIMEIROS
DA ESQUERDA PARA DIREITA QUANTO OS 7 ULTIMOS DA DIREITA PARA A ESQUERDA 
AS CAIXAS SAO ENCONTRADAS NOS DOIS SELECTS
*/
DELETE  from PDA_WMS_TB_EMBARQUE WHERE DOCA LIKE 'FRANCISCO MORATO PACK' AND FATURADO=0  and caixa = '13404875'


select doca, count(*) from PDA_WMS_TB_EMBARQUE where faturado=0
group by doca

update PDA_WMS_TB_EMBARQUE set faturado=1 where faturado=0


delete from PDA_WMS_TB_EMBARQUE WHERE DOCA LIKE 'COTIA CAIXA' AND FATURADO=0  and caixa = '13939897'

select * from PDA_WMS_TB_EMBARQUE where caixa = '13939897'


select doca, count(*) as qt from PDA_WMS_TB_EMBARQUE where faturado=1
and data>'20190801'
group by doca order by doca


update PDA_WMS_TB_EMBARQUE set faturado=1 where faturado=0
and doca in (
'OSASCO CENTRO PACK'
)

select * from PDA_WMS_TB_EMBARQUE where doca = 'SANTO ANDRE - CENTRO PACK' and data>='20190731' and faturado = 1 and datepart(MI,data)=25

UPDATE PDA_WMS_TB_EMBARQUE SET FATURADO = 0 where doca = 'SANTO ANDRE - CENTRO PACK' and data>='20190731' and faturado = 1 and datepart(MI,data)=25

select /*DISTINCT  datepart(MI,data)*/ * from PDA_WMS_TB_EMBARQUE where doca = 'SANTO ANDRE - CENTRO PACK' and data>='20190731' and faturado = 0 -- and datepart(MI,data)=25

UPDATE PDA_WMS_TB_EMBARQUE SET FATURADO = 1 where doca = 'SANTO ANDRE - CENTRO PACK' and data>='20190731' and faturado = 0 and datepart(MI,data)=10


UPDATE PDA_WMS_TB_EMBARQUE SET FATURADO = 0 
where doca = 'SANTO ANDRE - CENTRO PACK' and data>='20190731' and faturado =1 and datepart(MI,data)=10


select * from PDA_WMS_TB_EMBARQUE where  doca = 'SANTO ANDRE - CENTRO PACK' 
and data>'20190802' /*and faturado = 0*/ and datepart(HOUR,data)=16
--and caixa  in (select caixa from faturamento_prod)

select  from PDA_WMS_TB_EMBARQUE where  doca = 'SANTO ANDRE - CENTRO PACK' 
and data>'20190801'


select * from PDA_WMS_TB_EMBARQUE where doca  = 'SANTO ANDRE - CENTRO PACK' and DATEPART(MI,DATA)=13

-- 339
UPDATE PDA_WMS_TB_EMBARQUE 
SET FATURADO=0
where faturado=1 and doca  = 'SANTO ANDRE - CENTRO PACK' and DATEPART(MI,DATA)=13


--456
UPDATE PDA_WMS_TB_EMBARQUE 
SET FATURADO = 0
where  doca = 'SANTO ANDRE - CENTRO PACK' 
and data>'20190802' /*and faturado = 0*/ and datepart(HOUR,data)=16