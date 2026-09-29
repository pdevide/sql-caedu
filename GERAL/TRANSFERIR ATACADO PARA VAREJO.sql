declare @tabpedido table (id int identity(1,1), pedido varchar(12), saldo int)
insert into @tabpedido (pedido, saldo) values ('276453',1770)
insert into @tabpedido (pedido, saldo) values ('276463',1860)
insert into @tabpedido (pedido, saldo) values ('276464',1800)
insert into @tabpedido (pedido, saldo) values ('276476',1230)
insert into @tabpedido (pedido, saldo) values ('276477',1500)
insert into @tabpedido (pedido, saldo) values ('276473',2460)
insert into @tabpedido (pedido, saldo) values ('276475',1260)
insert into @tabpedido (pedido, saldo) values ('276499',1440)
insert into @tabpedido (pedido, saldo) values ('276500',1704)
insert into @tabpedido (pedido, saldo) values ('276501',1680)
insert into @tabpedido (pedido, saldo) values ('276502',1464)
insert into @tabpedido (pedido, saldo) values ('276507',1440)
insert into @tabpedido (pedido, saldo) values ('276508',1704)
insert into @tabpedido (pedido, saldo) values ('276509',1704)
insert into @tabpedido (pedido, saldo) values ('276462',1704)
insert into @tabpedido (pedido, saldo) values ('276495',1392)
insert into @tabpedido (pedido, saldo) values ('276496',1584)
insert into @tabpedido (pedido, saldo) values ('276498',1584)
insert into @tabpedido (pedido, saldo) values ('276511',1416)
insert into @tabpedido (pedido, saldo) values ('276497',1608)
insert into @tabpedido (pedido, saldo) values ('276510',1584)

select c.pedido, c.TOT_QTDE_ORIGINAL, a.saldo, pt.PRODUTO, pt.QTDE, cast((a.saldo /pt.QTDE) as float) as caixas,
pt.Q1, pt.Q2, pt.Q3, pt.Q4, pt.Q5, pt.Q6, pt.Q7, pt.Q8, pt.Q9, pt.Q10
from @tabpedido a 
inner join compras c on c.pedido = a.pedido
inner join CAEDU_COMPRAS_PRODUTOS_PACKS_TOTAL pt on pt.pedido = a.pedido

/*
EXEC CGP_MOVIMENTA_ESTOQUE_FILIAIS 
'CD CAJAMAR', 
'VENDA ATACADO', 
'450725470000301;20|450725470000302;40|450725470000303;40|450725470000304;20|450725490014101;20|450725490014102;40|450725490014103;40|450725490014104;20|450802140000301;20|450802140000302;40|450802140000303;40|450802140000304;20|451002870006501;20|451002870006502;40|451002870006503;40|451002870006504;20|451402740000301;30|451402740000302;60|451402740000303;30', 
@TRANSFERIDO=0
*/



