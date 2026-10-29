SELECT C.PEDIDO, ISNULL(PDA.STATUS_PDA,1) STATUS_PDA,
(SELECT COUNT(*) FROM CAEDU_RESERVA_AUTOMATICA WHERE PEDIDO = C.PEDIDO) AS QTD_DISTRIBUIDA,
(SELECT COUNT(*) FROM dbo.caedu_reserva_automatica cra WITH (NOLOCK)
INNER JOIN dbo.faturamento_prod fp WITH (NOLOCK) ON fp.CAIXA = cra.caixa
WHERE cra.pedido = C.PEDIDO) AS QTD_FATURADA
FROM COMPRAS C
LEFT JOIN dbo.CGP_PDA_WMS_STATUS_DISTRIBUICAO PDA ON PDA.DISTRIBUICAO=C.PEDIDO
WHERE C.PEDIDO = '380244'


select c.ERP_UNOUS_DATA_ENVIO,* 
from COMPRAS_PRODUTO cp 
inner join compras c on c.pedido=cp.pedido
where cp.pedido = '380244'


--SELECT * 
--FROM CAEDU_RESERVA_AUTOMATICA 
--WHERE PEDIDO = '379072'

--SELECT *
--FROM dbo.CGP_PDA_WMS_STATUS_DISTRIBUICAO WITH (NOLOCK)
--WHERE DISTRIBUICAO = '379072'



--SELECT @StatusPDA = ISNULL(STATUS_PDA, 1)
--            FROM dbo.CGP_PDA_WMS_STATUS_DISTRIBUICAO WITH (NOLOCK)
--            WHERE DISTRIBUICAO = @PedidoAtual 
--              AND ISNULL(STATUS_PDA, 1) < 2;

--            IF @@ROWCOUNT = 0
--            BEGIN
--                SET @StatusPDA = 1;
--            END

--            -- Regra de exclusão
--            IF @StatusPDA = 1
--            BEGIN
--                IF EXISTS (
--                    SELECT 1 
--                    FROM dbo.caedu_reserva_automatica cra WITH (NOLOCK)
--                    WHERE cra.pedido = @PedidoAtual
--                )
--                AND NOT EXISTS (
--                    SELECT 1
--FROM dbo.caedu_reserva_automatica cra WITH (NOLOCK)
--INNER JOIN dbo.faturamento_prod fp WITH (NOLOCK) ON fp.CAIXA = cra.caixa
--WHERE cra.pedido = @PedidoAtual
                --)