alter TABLE [dbo].[LOJA_PEDIDO]
	add
    [ID_CAMPANHA_ORIGEM][VARCHAR](50) NULL,
    [CANAL_OMS] [varchar](50) NULL,
    [CHANNEL_ID] [varchar](100) NULL,
    [OUTRAS_DESPESAS] [numeric](14, 2) NULL,
    [OUTRAS_DESPESAS_ITENS] [numeric](14, 2) NULL,
    [CRE] [int] NULL,
    [STATUS_FCONTROL] [varchar](15) NULL
go


alter TABLE [dbo].[LOJA_PEDIDO_PRODUTO]
	add
    [OUTRAS_DESPESAS] [numeric](14, 2) NULL
go

alter TABLE [dbo].[LOJA_VENDA]
	add
    [EMPRESA] [int] NULL,
    [CTB_LANCAMENTO] [int] NULL,
    [CTB_ITEM] [int] NULL,
    [ID_ATENDIMENTO] [bigint] NULL
go

alter TABLE [dbo].[LOJA_VENDA_PARCELAS]
	add
    [LX_METODO_PGTO] [int] NULL
go
	