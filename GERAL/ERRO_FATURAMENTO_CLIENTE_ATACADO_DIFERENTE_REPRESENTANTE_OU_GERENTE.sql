select * from vendas_prod_embalado where caixa = '10004046'

select * from vendas where pedido = 'CX-10017806'
--'CX-10004046'


select * from vendas where cliente_atacado = 'OSASCO CENTRO' and (cliente_atacado<>representante)


UPDATE VENDAS
SET REPRESENTANTE = CLIENTE_ATACADO, GERENTE = CLIENTE_ATACADO
WHERE PEDIDO IN
('CX-10004042', 
'CX-10004043', 
'CX-10004044', 
'CX-10004045') 