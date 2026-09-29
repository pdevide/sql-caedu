DECLARE @columns NVARCHAR(MAX), @whereClause NVARCHAR(MAX), @sql NVARCHAR(MAX);

-- Gera a lista de colunas dinamicamente
SELECT @columns = STRING_AGG(QUOTENAME(CODIGO_TAB_PRECO), ',')
FROM (
    SELECT DISTINCT A.CODIGO_TAB_PRECO 
    FROM TABELAS_PRECO A
    INNER JOIN INFO_LOJAS B ON B.CODIGO_PRECO = A.CODIGO_TAB_PRECO
    WHERE A.INATIVO = 0 
      AND B.ATIVO = 1 
      AND B.LOJA <> 'MATRIZ'
) AS codes;

-- Gera a cláusula WHERE com OR entre as colunas
SELECT @whereClause = STRING_AGG(QUOTENAME(CODIGO_TAB_PRECO) + ' IS NULL', ' OR ')
FROM (
    SELECT DISTINCT A.CODIGO_TAB_PRECO 
    FROM TABELAS_PRECO A
    INNER JOIN INFO_LOJAS B ON B.CODIGO_PRECO = A.CODIGO_TAB_PRECO
    WHERE A.INATIVO = 0 
      AND B.ATIVO = 1 
      AND B.LOJA <> 'MATRIZ'
) AS codes;

-- Monta e executa a query dinâmica
SET @sql = N'
SELECT 
    PRODUTO,
    ' + @columns + '
FROM (
    SELECT 
        PP.PRODUTO,
        PP.CODIGO_TAB_PRECO,
        PP.PRECO1
    FROM PRODUTOS_PRECOS PP
    WHERE PP.CODIGO_TAB_PRECO IN (
        SELECT A.CODIGO_TAB_PRECO 
        FROM TABELAS_PRECO A
        INNER JOIN INFO_LOJAS B ON B.CODIGO_PRECO = A.CODIGO_TAB_PRECO
        WHERE A.INATIVO = 0 
          AND B.ATIVO = 1 
          AND B.LOJA <> ''MATRIZ''
    )
) AS SourceTable
PIVOT (
    MAX(PRECO1)
    FOR CODIGO_TAB_PRECO IN (' + @columns + ')
) AS PivotTable
WHERE ' + @whereClause + '
ORDER BY PRODUTO;
';

EXEC sp_executesql @sql;
