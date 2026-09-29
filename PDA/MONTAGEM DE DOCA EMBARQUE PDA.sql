--insert into PDA_WMS_TB_EMBARQUE 
select 
		CAIXA
		,rtrim(f.filial) + ' CAIXA' DOCA
		,f.COD_FILIAL CODIGO_FILIAL
		,665 USUARIO
		,getdate() DATA
		,0 as FATURADO
		,21044 CODIGO_TRANSPORTADORA
		,'FFN9612' PLACA
		,'06647/06648' LACRE
		,2 COD_TIPO_VEICULO
		,26 CODIGO_ROTA
		,'Alex De Souza Paula' MOTORISTA
		,'111.222.333-45' DOC_MOTORISTA
from VENDAS_PROD_EMBALADO a
inner join filiais f on f.FILIAL= a.NOME_CLIFOR
where NOME_CLIFOR='MAUA' and (entrega between  '20260626' and '20260626')
and exists (select 1 from estoque_produtos e where produto = a.PRODUTO and e.filial = 'CD - SP - SAO ROQUE' and e.estoque>0)

LX_PROCESSOS

--select * from filiais
/*

SELECT * 
--UPDATE A SET CODIGO_FILIAL = '000217' 
FROM PDA_WMS_TB_EMBARQUE A 
WHERE FATURADO=0
--MG SH BIG CONTAGEM CAIXA
*/

--select * from PDA_WMS_TB_EMBARQUE where DOCA like 'SP- SHOPPING ATRIUM%' and DATA>'20250901'

--select * from FILIAIS order by FILIAL desc


--SELECT * 
----UPDATE A SET FATURADO=0
--FROM PDA_WMS_TB_EMBARQUE A WHERE DATA>'20251007' and FATURADO=0


