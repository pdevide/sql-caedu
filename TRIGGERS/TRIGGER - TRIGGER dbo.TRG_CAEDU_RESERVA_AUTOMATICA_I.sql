USE CAEDU;
GO

CREATE OR ALTER TRIGGER dbo.TRG_CAEDU_RESERVA_AUTOMATICA_I
ON dbo.CAEDU_RESERVA_AUTOMATICA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    /*
        Captura os pedidos envolvidos nesta operação.

        A tabela inserted pode conter:
        - Uma linha, no caso do IRIS;
        - Várias linhas, no caso do FoxPro;
        - Vários pedidos, se houver INSERT em lote.
    */
    SELECT DISTINCT
        pedido
    INTO #PedidosInseridos
    FROM inserted;


    /*
        Busca o limite de caixas do pedido.

        O UPDLOCK/HOLDLOCK impede que duas inserções simultâneas
        para o mesmo pedido ultrapassem o limite ao mesmo tempo.
    */
    SELECT
        c.pedido,
        c.ERP_TOTAL_QTD_DISTRIB
    INTO #LimitesPedido
    FROM dbo.COMPRAS AS c WITH (UPDLOCK, HOLDLOCK)
    INNER JOIN #PedidosInseridos AS p
        ON p.pedido = c.pedido;


    /*
        Pedido inexistente na tabela COMPRAS.
    */
    IF EXISTS
    (
        SELECT 1
        FROM #PedidosInseridos AS p
        LEFT JOIN #LimitesPedido AS l
            ON l.pedido = p.pedido
        WHERE l.pedido IS NULL
    )
    BEGIN
        THROW 51000,
              'ERRO_RESERVA: pedido não localizado na tabela COMPRAS.',
              1;
    END;


    /*
        ERP_TOTAL_QTD_DISTRIB precisa estar preenchido.
    */
    IF EXISTS
    (
        SELECT 1
        FROM #LimitesPedido
        WHERE ERP_TOTAL_QTD_DISTRIB IS NULL
    )
    BEGIN
        THROW 51001,
              'ERRO_RESERVA: ERP_TOTAL_QTD_DISTRIB está nulo na tabela COMPRAS.',
              1;
    END;


    /*
        A trigger AFTER INSERT já enxerga as linhas recém-inseridas.

        A contagem é feita por pedido e por caixa distinta.

        Exemplo:

            pedido   caixa   cor
            360122   1001    00184
            360122   1001    00200

        Resultado:

            COUNT(DISTINCT caixa) = 1
    */
    ;WITH CaixasPorPedido AS
    (
        SELECT
            p.pedido,
            COUNT(DISTINCT r.caixa) AS QTD_CAIXAS_UTILIZADAS
        FROM #PedidosInseridos AS p
 INNER JOIN dbo.CAEDU_RESERVA_AUTOMATICA AS r
            ON r.pedido = p.pedido
        GROUP BY
            p.pedido
    )
    SELECT
        c.pedido,
        QTD_CAIXAS_UTILIZADAS,
        l.ERP_TOTAL_QTD_DISTRIB
    INTO #PedidosExcedidos
    FROM CaixasPorPedido AS c
    INNER JOIN #LimitesPedido AS l
        ON l.pedido = c.pedido
    WHERE c.QTD_CAIXAS_UTILIZADAS > l.ERP_TOTAL_QTD_DISTRIB;


    /*
        Bloqueia a operação quando ultrapassar o limite.

        O erro será:

        - Capturado pelo CATCH da PRC_CRIARALOCACAO no IRIS;
        - Colocado em @P_RETORNO;
        - Retornado ao FoxPro pelo F_execute();
        - Tratado pelo ROLLBACK externo do FoxPro.
    */
    IF EXISTS
    (
        SELECT 1
        FROM #PedidosExcedidos
    )
    BEGIN
        DECLARE @Mensagem nvarchar(2048);

        SELECT TOP (1)
            @Mensagem = CONCAT(
                'ERRO_LIMITE_CAIXAS: ',
                'pedido ',
                CONVERT(nvarchar(100), pedido),
                ' excedeu o limite de caixas. ',
                'Caixas utilizadas: ',
                QTD_CAIXAS_UTILIZADAS,
                '. Limite permitido: ',
                ERP_TOTAL_QTD_DISTRIB,
                '.'
            )
        FROM #PedidosExcedidos
        ORDER BY
            pedido;

        THROW 51002, @Mensagem, 1;
    END;
END;
GO