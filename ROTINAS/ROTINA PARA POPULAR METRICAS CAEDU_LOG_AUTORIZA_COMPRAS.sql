BEGIN TRANSACTION;

BEGIN TRY
    -- 1. Tabela de memória com Identity para controle do loop
    DECLARE @TmpPendentes TABLE (
        RowID               INT IDENTITY(1,1),
        PEDIDO              CHAR(8),
        PRODUTO             CHAR(12),
        COR_PRODUTO         CHAR(10),
        DATA_LOG            DATETIME,
        VALOR_ANTES         VARCHAR(40),
        VALOR_DEPOIS        VARCHAR(40),
        USUARIO_PEDIDO      VARCHAR(25)
    );

    -- 2. Carga dos itens de COMPRAS_PRODUTO que não possuem registro no Log
    INSERT INTO @TmpPendentes (
        PEDIDO, 
        PRODUTO, 
        COR_PRODUTO, 
        DATA_LOG, 
        VALOR_ANTES, 
        VALOR_DEPOIS, 
        USUARIO_PEDIDO
    )
    SELECT 
        cp.PEDIDO,
        cp.PRODUTO,
        ISNULL(cp.COR_PRODUTO, '00001'),
        ISNULL(tg.data_alteracao, GETDATE()),
        CONVERT(VARCHAR(10), ISNULL(tg.entrega_antiga, cp.ENTREGA), 103),
        CONVERT(VARCHAR(10), ISNULL(tg.entrega_nova, cp.ENTREGA), 103),
        ISNULL(tg.login, SYSTEM_USER)
    FROM dbo.COMPRAS c WITH (NOLOCK)
    INNER JOIN dbo.COMPRAS_PRODUTO cp WITH (NOLOCK) 
        ON cp.PEDIDO = c.PEDIDO
    LEFT JOIN dbo.CAEDU_LOG_AUTORIZA_COMPRAS l WITH (NOLOCK) 
        ON l.PEDIDO = cp.PEDIDO AND l.PRODUTO = cp.PRODUTO
    OUTER APPLY (
        SELECT TOP 1 entrega_antiga, entrega_nova, data_alteracao, login
        FROM dbo.TRIGGER_PORTAL WITH (NOLOCK)
        WHERE PEDIDO = c.PEDIDO
        ORDER BY id DESC
    ) tg
    WHERE c.STATUS_COMPRA = '04'
      AND c.EMISSAO > '20260101'
      AND l.PEDIDO IS NULL;

    DECLARE @RowID INT = 1;
    DECLARE @TotalRows INT = (SELECT COUNT(*) FROM @TmpPendentes);

    -- 3. Percorre os registros salvando primeiramente a Pai e em seguida a Filha
    WHILE (@RowID <= @TotalRows)
    BEGIN
        DECLARE @Pedido        CHAR(8);
        DECLARE @Produto       CHAR(12);
        DECLARE @CorProduto    CHAR(10);
        DECLARE @DataLog       DATETIME;
        DECLARE @ValorAntes    VARCHAR(40);
        DECLARE @ValorDepois   VARCHAR(40);
        DECLARE @UsuarioPedido VARCHAR(25);
        DECLARE @Obs           VARCHAR(250);

        SELECT 
            @Pedido        = PEDIDO,
            @Produto       = PRODUTO,
            @CorProduto    = COR_PRODUTO,
            @DataLog       = DATA_LOG,
            @ValorAntes    = VALOR_ANTES,
            @ValorDepois   = VALOR_DEPOIS,
            @UsuarioPedido = USUARIO_PEDIDO
        FROM @TmpPendentes
        WHERE RowID = @RowID;

        SET @Obs = 'Data de Entrega foi alterada de => ' + ISNULL(@ValorAntes, '') + ' para => ' + ISNULL(@ValorDepois, '');

        -- Inserção na Tabela Pai (CAEDU_LOG_AUTORIZA_COMPRAS) com STATUS_PEDIDO = 3
        IF NOT EXISTS (
            SELECT 1 
            FROM dbo.CAEDU_LOG_AUTORIZA_COMPRAS 
            WHERE PEDIDO = @Pedido AND PRODUTO = @Produto
        )
        BEGIN
            INSERT INTO dbo.CAEDU_LOG_AUTORIZA_COMPRAS (
                PEDIDO, 
                PRODUTO, 
                DATA_LOG, 
                STATUS_PEDIDO
            )
            VALUES (
                @Pedido, 
                @Produto, 
                @DataLog, 
                3 -- Status 3 fixado
            );
        END

        -- Inserção na Tabela Filha (CAEDU_LOG_AUTORIZA_COMPRAS_ITEM) com COD_METRICA = '04'
        IF NOT EXISTS (
            SELECT 1 
            FROM dbo.CAEDU_LOG_AUTORIZA_COMPRAS_ITEM 
            WHERE PEDIDO = @Pedido 
              AND PRODUTO = @Produto 
              AND COR_PRODUTO = @CorProduto 
              AND COD_METRICA = '04' 
              AND DATA_LOG = @DataLog
        )
        BEGIN
            INSERT INTO dbo.CAEDU_LOG_AUTORIZA_COMPRAS_ITEM (
                PEDIDO,
                PRODUTO,
                COR_PRODUTO,
                COD_METRICA,
                DATA_LOG,
                TIPO_OP,
                VALOR_ANTES,
                VALOR_DEPOIS,
                APROVADO,
                USUARIO_PEDIDO,
                USUARIO_APROVADOR,
                OBS
            )
            VALUES (
                @Pedido,
                @Produto,
                @CorProduto,
                '04', -- Métrica 04 fixada
                @DataLog,
                'A',
                @ValorAntes,
                @ValorDepois,
                0, -- Aprovado = .F.
                @UsuarioPedido,
                NULL,
                @Obs
            );
        END

        SET @RowID = @RowID + 1;
    END

    COMMIT TRANSACTION;
    PRINT 'Popular Log concluído. Itens inseridos: ' + CAST(@TotalRows AS VARCHAR(10));
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0)
        ROLLBACK TRANSACTION;

    THROW;
END CATCH;
