DECLARE @TEXTO VARCHAR(50) 

SET @TEXTO = 'MAÇÃ'
select dbo.fx_contem_caracter_especial(@TEXTO,0)


SET @TEXTO = 'PAULO'
select dbo.fx_contem_caracter_especial(@TEXTO,0)


SET @TEXTO = 'NOME DO FORNECEDOR& RESTO'
select dbo.fx_contem_caracter_especial(@TEXTO,0)


--select so.name, so.type, sc.*
--from syscomments sc
--inner join sysobjects so on so.id = sc.id
--where sc.text like '%fx_contem_caracter_especial%'
