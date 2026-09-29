WITH BASE (NF_SAIDA,Produto,DescricaoCaixa,Endereco,DescricaoProduto,CodigoCodigoNivel1,DescricaoCodigoNivel1
,CodigoCodigoNivel2,DescricaoCodigoNivel2,CodigoCodigoNivel3,DescricaoCodigoNivel3,CodigoCodigoNivel4
,DescricaoCodigoNivel4,CodigoCodigoNivel5,DescricaoCodigoNivel5,Quantidade,Tamanho,Cor
,Grade,CodigoPedido,LojaDestino,Deposito,UnidadeMedida)
AS
(SELECT (select TOP 1 MAX(NF_SAIDA) FROM FATURAMENTO_PROD WHERE CAIXA=A.DescricaoCaixa) as NF_SAIDA
	  ,a.[Produto]
      ,[DescricaoCaixa]
      ,[Endereco]
      ,[DescricaoProduto]
      ,[CodigoCodigoNivel1]
      ,[DescricaoCodigoNivel1]
      ,[CodigoCodigoNivel2]
      ,[DescricaoCodigoNivel2]
      ,[CodigoCodigoNivel3]
      ,[DescricaoCodigoNivel3]
      ,[CodigoCodigoNivel4]
      ,[DescricaoCodigoNivel4]
      ,[CodigoCodigoNivel5]
      ,[DescricaoCodigoNivel5]
      ,[Quantidade]
      ,[Tamanho]
      ,[Cor]
      ,[Grade]
      ,[CodigoPedido]
      ,[LojaDestino]
      ,[Deposito]
      ,[UnidadeMedida]
FROM [CAEDU].[ccp\paulo.devide].[CGP_BOXPDA_20250801] a)
SELECT a.NOME_CLIFOR,a.PRODUTO,a.COR_PRODUTO,a.FILIAL,a.ITEM,a.PEDIDO,a.CAIXA
,a.ENTREGA,a.CAIXA_FECHADA,a.REPRESENTANTE,a.PRECO1,a.VALOR_EMBALADO,a.QTDE_EMBALADA
,a.E1,a.E2,a.E3,a.E4,a.E5,a.E6,a.E7,a.E8,a.E9,a.E10,a.E11,a.E12,a.E13,a.E14,a.E15,a.E16
,B.*
FROM VENDAS_PROD_EMBALADO A
LEFT JOIN  base B ON B.DescricaoCaixa=a.CAIXA


