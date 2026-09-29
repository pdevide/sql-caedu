

ALTER TABLE ESTOQUE_PROD_CONTAGEM 
ADD ERP_NFE_PERDA_EMITIDA BIT NOT NULL DEFAULT (0)
GO

/*
lx_cade contagem

select * from ESTOQUE_PROD_CONTAGEM

select nome_contagem, filial, 1 as selecao from ESTOQUE_PROD_CONTAGEM

*/