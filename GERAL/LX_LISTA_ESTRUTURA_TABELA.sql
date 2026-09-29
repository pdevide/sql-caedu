CREATE PROCEDURE DBO.LX_LISTA_ESTRUTURA_TABELA

 @tableName NVARCHAR(128) 

 AS
-- Consulta para listar a estrutura da tabela
SELECT 
	TABLE_SCHEMA,
	TABLE_NAME AS TABELA,
	ORDINAL_POSITION AS colid,
    COLUMN_NAME AS NomeColuna,
    LOWER(DATA_TYPE) AS TipoDado,
    CASE WHEN LOWER(DATA_TYPE) IN ('numeric','decimal') 
		then '('+convert(varchar,numeric_precision)+','+convert(varchar,numeric_scale)+')'
    WHEN LOWER(DATA_TYPE) LIKE '%char%'  
		then '('+convert(varchar,CHARACTER_MAXIMUM_LENGTH)+')'
	ELSE ''
	END AS Tamanho,
    IS_NULLABLE AS PodeSerNulo,
    COLUMN_DEFAULT AS ValorPadrao
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @tableName;
