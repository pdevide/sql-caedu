--select * 
--from produto_cores a
--where produto = 'Z5030023'
declare @tabpro table (codigobarra varchar(20))

insert into @tabpro values ('D91600230000304');
insert into @tabpro values ('D90203370000404');
insert into @tabpro values ('34015958901');
insert into @tabpro values ('340161920002901');
insert into @tabpro values ('Z3010017901');
insert into @tabpro values ('Z3010030901');
insert into @tabpro values ('34015958901');
insert into @tabpro values ('34015958901');
insert into @tabpro values ('Z3010033901');
insert into @tabpro values ('Z3010033901');
insert into @tabpro values ('V10100530000301');
insert into @tabpro values ('Z2010082901');
insert into @tabpro values ('Z2010068901');
insert into @tabpro values ('Z2010084901');
insert into @tabpro values ('Z2010056901');
insert into @tabpro values ('Z2010085901');
insert into @tabpro values ('Z20100960002901');
insert into @tabpro values ('Z20100960002901');
insert into @tabpro values ('Z20100960002901');
insert into @tabpro values ('Z2010069901');
insert into @tabpro values ('Z20100880002901');
insert into @tabpro values ('Z2010071901');
insert into @tabpro values ('Z2010079901');
insert into @tabpro values ('Z2010084901');
insert into @tabpro values ('Z20100960002901');
insert into @tabpro values ('Z20100960002901');
insert into @tabpro values ('Z20100960002901');
insert into @tabpro values ('Z2010080901');
insert into @tabpro values ('Z20100960002901');
insert into @tabpro values ('Z20100960002901');
insert into @tabpro values ('Z2010085901');
insert into @tabpro values ('Z2010084901');
insert into @tabpro values ('Z2010070901');
insert into @tabpro values ('Z2010085901');
insert into @tabpro values ('Z20100880002901');
insert into @tabpro values ('Z20100960002901');
insert into @tabpro values ('Z20100960002901');
insert into @tabpro values ('Z20100960002901');
insert into @tabpro values ('Z20100960002901');
insert into @tabpro values ('Z2010085901');
insert into @tabpro values ('Z20100960002901');
insert into @tabpro values ('Z20100960002901');
insert into @tabpro values ('Z2010084901');
insert into @tabpro values ('Z2010084901');
insert into @tabpro values ('Z20100880002901');
insert into @tabpro values ('Z2010085901');
insert into @tabpro values ('D80303270015802');
insert into @tabpro values ('V10100630023906');
insert into @tabpro values ('Z50300310002901');
insert into @tabpro values ('Z50300310002901');
insert into @tabpro values ('Z50300350002901');
insert into @tabpro values ('Z5030023901');
insert into @tabpro values ('Z50300350002901');
insert into @tabpro values ('Z50300270002901');
insert into @tabpro values ('Z50300350002901');
insert into @tabpro values ('Z5030023901');
insert into @tabpro values ('Z50300310002901');
insert into @tabpro values ('Z50300280002901');
insert into @tabpro values ('Z5030023901');
insert into @tabpro values ('620402450002901');
insert into @tabpro values ('620402450002901');
insert into @tabpro values ('620402590002901');
insert into @tabpro values ('620402450002901');
insert into @tabpro values ('620402450002901');
insert into @tabpro values ('620502810002901');
insert into @tabpro values ('620502650002901');
insert into @tabpro values ('620502650002901');
insert into @tabpro values ('Z3010020901');
insert into @tabpro values ('F50100230002901');
insert into @tabpro values ('D70302960011205');
insert into @tabpro values ('454606780000303');
insert into @tabpro values ('N50200070000303');
insert into @tabpro values ('240500800013101');
insert into @tabpro values ('D70302780000302');
insert into @tabpro values ('510217710011301');
insert into @tabpro values ('700264080014001');
insert into @tabpro values ('700258800011203');
insert into @tabpro values ('451002810006504');
insert into @tabpro values ('Z2010063901');
insert into @tabpro values ('130901220014504');
insert into @tabpro values ('180902690002902');
insert into @tabpro values ('E5010003901');
insert into @tabpro values ('620502380002901');
insert into @tabpro values ('130812660000306');
insert into @tabpro values ('620502380002901');
insert into @tabpro values ('Z2010078901');
insert into @tabpro values ('620502380002901');
insert into @tabpro values ('181300050006502');
insert into @tabpro values ('181300210006501');
insert into @tabpro values ('440802770010602');
insert into @tabpro values ('770100420002901');
insert into @tabpro values ('130901710000306');
insert into @tabpro values ('181300180006504');
insert into @tabpro values ('242101700016003');

select a.*, b.CODIGO_BARRA, b.PRODUTO 
from @tabpro a
left join PRODUTOS_BARRA b on b.CODIGO_BARRA = a.codigobarra
where b.CODIGO_BARRA is null

