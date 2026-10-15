-- =====================================================================
-- SCRIPT 1 - PILOTO: nova NF da TR-15073813 (substitui a NF 000000020 inutilizada)
-- Banco CAEDU (Linx). Emite SO se a transferencia nao tiver NF ativa.
-- =====================================================================
USE CAEDU;
SET NOCOUNT ON;
SET ARITHABORT ON;

DECLARE @UUID VARCHAR(36) = '4ecdf9f5-d040-4e78-ad7f-fc73461b74e4';

IF EXISTS (SELECT 1 FROM dbo.FATURAMENTO
            WHERE DATA_CANCELAMENTO IS NULL AND ERP_CUPS_ID_TRANSFERENCIA = @UUID)
BEGIN
  RAISERROR('TR-15073813 ja tem NF ativa - nada foi emitido.', 16, 1);
  RETURN;
END

EXEC dbo.CGP_CAEDU_GERA_NOTA_FISCAL_TRANSFERENCIA
     @FILIAL_ORIGEM             = 'SP SH LITORAL PLAZA',
     @FILIAL_DESTINO            = 'SP SH LITORAL PLAZA QS',
     @LISTA_ITENS               = 'Z40105150013701,5',
     @SERIE_SAIDA               = '02',
     @ERP_CUPS_ID_TRANSFERENCIA = @UUID,
     @VOLUMES_NF                = 1;

-- Prova da emissao: 1 linha com PECAS_NA_NF = 5.
-- Vazio = o ERP cancelou a emissao (ex.: estoque insuficiente na origem).
SELECT f.NF_SAIDA, f.SERIE_NF, f.EMISSAO, f.CHAVE_NFE,
       (SELECT SUM(fp.QTDE) FROM dbo.FATURAMENTO_PROD fp
         WHERE fp.FILIAL = f.FILIAL AND fp.NF_SAIDA = f.NF_SAIDA AND fp.SERIE_NF = f.SERIE_NF) AS PECAS_NA_NF
  FROM dbo.FATURAMENTO f
 WHERE f.DATA_CANCELAMENTO IS NULL
   AND f.ERP_CUPS_ID_TRANSFERENCIA = @UUID;
