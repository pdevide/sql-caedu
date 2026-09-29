CREATE table [ccp\paulo.devide].TB_ESTOQUE_PDA_10JUNHO25 (
ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
Deposito VARCHAR(25) null,	
Endereco VARCHAR(25) null,		
Acoes VARCHAR(25) null,		
Palete VARCHAR(25) null,		
Caixa VARCHAR(8) null,		
Produto VARCHAR(8) null,		
EAN VARCHAR(20) null,		
Tamanho VARCHAR(10) null,		
Cor VARCHAR(6) null,		
Desc_Produto VARCHAR(40) null,		
Unidade_Medida VARCHAR(10) null,		
Pedido VARCHAR(12) null,		
Estoque INT null,		
Lojadestino VARCHAR(25) null)	
GO

CREATE INDEX IDX_TB_ESTOQUE_PDA_10JUNHO25_CAIXA  
ON [ccp\paulo.devide].TB_ESTOQUE_PDA_10JUNHO25 (CAIXA)
GO

select * from [ccp\paulo.devide].TB_ESTOQUE_PDA_10JUNHO25