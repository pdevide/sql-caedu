--select * from FILIAIS where FILIAL like 'Go%'


declare @filial varchar(25) = 'GO - SH PORTAL SUL'     
select f.FILIAL, f.DT_ULTIMO_INVENTARIO, f.RESPONSAVEL_ULTIMO_INVENTARIO, f.EM_INVENTARIO
--update f set DT_ULTIMO_INVENTARIO='20240702'
from FILIAIS f 
where FILIAL = @filial

select * 
--update a set DATA_SALDO_PA = '20240702'
from CM_DATA_FECHAMENTO a where FILIAL = 'GO - SH PORTAL SUL'     


select * 
--update a set EM_INVENTARIO=1
from CGP_LOG_ARQUIVO_AF_INVENTARIO a where FILIAL = @filial and DATA_HORA_CONSULTA>='20240702'

select * 
--update a set EM_INVENTARIO=1
from CGP_LOG_CONSULTA_ESTOQUE_FILIAL a where FILIAL = @filial and DATA_HORA_CONSULTA>='20240702'

select * 
from CGP_LOG_FILIAL_INVENTARIO a where FILIAL = @filial and DATA_STATUS>='20240702'
