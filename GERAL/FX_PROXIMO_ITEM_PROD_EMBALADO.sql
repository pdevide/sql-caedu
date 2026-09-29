select dbo.FX_PROXIMO_ITEM_PROD_EMBALADO('BARUERI','M1010113','00107','CD REGIS')

/*
select  --ITEM = RIGHT('000000' + CONVERT(VARCHAR,CAST(MAX(ITEM) AS INT)+1), 6) 
*
from vendas_prod_embalado 
WHERE NOME_CLIFOR = 'BARUERI' AND PRODUTO = 'M1010113' AND COR_PRODUTO='00107' AND FILIAL = 'CD REGIS'
GO
*/

 ALTER FUNCTION [dbo].[FX_PROXIMO_ITEM_PROD_EMBALADO] 
(   
 @NOME_CLIFOR varchar(25), 
 @PRODUTO char(12), 
 @COR_PRODUTO char(10), 
 @FILIAL varchar(25)
)

RETURNS varchar(6)

AS

begin

declare @item varchar(6) 

select  @item = RIGHT('000000' + CONVERT(VARCHAR,CAST(MAX(ITEM) AS INT)+1), 6) 
from vendas_prod_embalado 
WHERE NOME_CLIFOR = @NOME_CLIFOR AND PRODUTO = @PRODUTO AND COR_PRODUTO=@COR_PRODUTO AND FILIAL = @FILIAL 

IF @item = '000000'
begin
    set @item = null
end

return @item

end



