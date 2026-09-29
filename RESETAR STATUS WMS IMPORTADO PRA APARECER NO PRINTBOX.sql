--37843 e a 38268
declare @nf varchar(15) = '000042103'
declare @serie varchar(6) = '02'
declare @operacao int = 1

if @operacao = 1
begin
SELECT CAST(1 AS BIT) AS SELECAO, PACK,PRODUTO,NF,SERIE,A.ID_COLETA ETIQUETA,B.STATUS
 FROM  PDA_WMS_TB_RECEBIMENTO_IMPORTADO_COLETA A 
 INNER JOIN PDA_WMS_TB_REC_CD_STATUS_RECEBIMENTO B  
 ON (LTRIM(RTRIM(A.NF))+' '+LTRIM(RTRIM(SERIE)) = B.PEDIDO) WHERE /*B.STATUS>=3 */ 1=1
 AND A.NF=@nf AND SERIE=@serie
end
else
begin 
	update PDA_WMS_TB_REC_CD_STATUS_RECEBIMENTO set STATUS=3
	where pedido = @nf + ' ' + @serie
end



