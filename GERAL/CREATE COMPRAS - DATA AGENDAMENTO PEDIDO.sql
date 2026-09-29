ALTER TABLE COMPRAS 
ADD ERP_AGENDAMENTO_PEDIDO DATETIME NULL
GO


--select * from COMPRAS where ERP_UNOUS_DATA_ENVIO is not null order by emissao desc

--select pedido, ERP_UNOUS_DATA_ENVIO, ERP_AGENDAMENTO_PEDIDO 
--from compras where pedido = '239776'


--update compras
--set ERP_AGENDAMENTO_PEDIDO=getdate()
--where pedido = '239776'
