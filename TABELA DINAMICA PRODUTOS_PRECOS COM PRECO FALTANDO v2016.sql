DECLARE @columns NVARCHAR(MAX), @whereClause NVARCHAR(MAX), @sql NVARCHAR(MAX);

-- Gera a lista de colunas dinamicamente (compatível com SQL 2016)
SELECT @columns = STUFF((
    SELECT ',' + QUOTENAME(CODIGO_TAB_PRECO)
    FROM (
        SELECT DISTINCT A.CODIGO_TAB_PRECO 
        FROM TABELAS_PRECO A
        INNER JOIN INFO_LOJAS B ON B.CODIGO_PRECO = A.CODIGO_TAB_PRECO
        WHERE A.INATIVO = 0 
          AND B.ATIVO = 1 
          AND B.LOJA <> 'MATRIZ'
    ) AS codes
    ORDER BY CODIGO_TAB_PRECO
    FOR XML PATH(''), TYPE
).value('.', 'NVARCHAR(MAX)'), 1, 1, '');

-- Gera a cláusula WHERE com OR entre as colunas (compatível com SQL 2016)
SELECT @whereClause = STUFF((
    SELECT ' OR ' + QUOTENAME(CODIGO_TAB_PRECO) + ' IS NULL'
    FROM (
        SELECT DISTINCT A.CODIGO_TAB_PRECO 
        FROM TABELAS_PRECO A
        INNER JOIN INFO_LOJAS B ON B.CODIGO_PRECO = A.CODIGO_TAB_PRECO
        WHERE A.INATIVO = 0 
          AND B.ATIVO = 1 
          AND B.LOJA <> 'MATRIZ'
    ) AS codes
    ORDER BY CODIGO_TAB_PRECO
    FOR XML PATH(''), TYPE
).value('.', 'NVARCHAR(MAX)'), 1, 4, '');

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
