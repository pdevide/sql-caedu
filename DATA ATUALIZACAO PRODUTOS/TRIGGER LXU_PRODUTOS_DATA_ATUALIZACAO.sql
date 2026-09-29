
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:		Paulo Devide
-- Create date: 29/02/2024
-- Description:	Trigger para atualizar a coluna 
-- ERP_DATA_ATUALIZACAO para todas as atualizações
-- exceto para quando for atualizado pela tabela
-- produtos_precos
-- ================================================
CREATE OR ALTER TRIGGER dbo.LXU_PRODUTOS_DATA_ATUALIZACAO 
   ON  dbo.PRODUTOS 
   AFTER UPDATE
AS 
BEGIN

	SET NOCOUNT ON;

	IF NOT UPDATE(ERP_DATA_ATUALIZACAO)
		update p set ERP_DATA_ATUALIZACAO=GETDATE() 
		FROM inserted i
		INNER JOIN PRODUTOS p
			ON p.PRODUTO=i.PRODUTO
	


END
GO
