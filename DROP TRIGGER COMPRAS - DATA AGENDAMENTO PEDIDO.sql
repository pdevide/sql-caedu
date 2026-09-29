ALTER TABLE COMPRAS 
DROP COLUMN ERP_AGENDAMENTO_PEDIDO 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--ATUALIZAÇÃO DE TRIGGER DE UPDATE PARA CONTROLE DE LX_STATUS_COMPRA - ENVIO ETL
ALTER TRIGGER [dbo].[LXUDT_COMPRAS] ON [dbo].[COMPRAS]
FOR UPDATE NOT FOR REPLICATION
AS 
-- TRIGGER PARA CONTROLE DE DATA_PARA_TRANSFERENCIA
BEGIN
	---DATA PARA TRANSFERENCIA---------------------------------------------------------------------------
	IF NOT UPDATE(DATA_PARA_TRANSFERENCIA)
	UPDATE 	T
	SET 	DATA_PARA_TRANSFERENCIA = GETDATE()
	FROM 	[COMPRAS] T
			JOIN INSERTED I ON
				I.[PEDIDO]=T.[PEDIDO]
	-----------------------------------------------------------------------------------------------------

	---LX_STATUS_COMPRA---------------------------------------------------------------------------
	IF NOT UPDATE(LX_STATUS_COMPRA)
	UPDATE 	T
	SET 	LX_STATUS_COMPRA = 1, DATA_PARA_TRANSFERENCIA = I.DATA_PARA_TRANSFERENCIA 
	FROM 	[COMPRAS] T
			JOIN INSERTED I ON
				I.[PEDIDO]=T.[PEDIDO]
	-----------------------------------------------------------------------------------------------------
	RETURN
END
GO
