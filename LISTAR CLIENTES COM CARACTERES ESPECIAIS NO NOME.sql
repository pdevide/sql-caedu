declare @PADRAO varchar(100) = '%[^A-Za-z0-9._ /&-]%' 

select *
from CLIENTES_ATACADO
where PATINDEX(@PADRAO, LTRIM(RTRIM(CLIENTE_ATACADO)) COLLATE Latin1_General_BIN) > 0
and inativo = 0
order by CLIENTE_ATACADO

