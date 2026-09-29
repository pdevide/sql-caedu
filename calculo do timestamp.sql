-- calculo do timestamp para colunas decimal (18,0) no SQL Server
select datediff(second, dateadd(hour, datediff(hour, getutcdate(), getdate()), '19700101'), getdate()) as [TIMESTAMP]



select * 
UPDATE F SET INFO_PGTO=90
from faturamento F 
where status_nfe<> 5 and filial = 'CD BARRA VELHA' AND EMISSAO = '20210901'
