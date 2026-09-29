DECLARE @USUARIO VARCHAR(25) = 'CCP\PAULO.DEVIDE' 

select * from [dbo].[USERS]
where USUARIO like @USUARIO      

--select * from [dbo].[USERS_CUBOS_PERMITIDOS] não tem nada

select * from [dbo].[USERS_GRUPO] where LX_SYSTEM_USER = @USUARIO 

select * from [dbo].[USERS_GRUPO_LISTA]

select * from [dbo].[USERS_MATRIZ_CONTABIL] where USUARIO like @USUARIO

select * from [dbo].[USERS_MODULOS] where USUARIO like @USUARIO

select * from [dbo].[USERS_TRANSACOES] where USUARIO like @USUARIO

--select * from [dbo].[USERS_TRANSACOES_FAVORITOS]

select * from [dbo].[PROP_USERS]

select * from [dbo].[PARAMETROS_USERS] WHERE USUARIO LIKE @USUARIO

--select * from [dbo].[PARAMETROS_EMPRESA_USERS]

