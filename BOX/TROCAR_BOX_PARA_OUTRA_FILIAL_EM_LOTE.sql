set nocount on

-- Cria dataset temporario
declare @caixas table 
(id int identity(1,1) not null, 
caixa varchar(8) not null, 
filial varchar(25) not null)

-- Popula o dataset com os caixas e destinos 
-- Neste caso, origem sempre é Maua
/*
insert into @caixas (CAIXA, FILIAL) values ('11582936', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11582937', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11582938', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11582939', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11582940', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11582941', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11582942', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11582943', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11514703', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11447541', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11517461', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11531478', 'CRUZEIRO');
insert into @caixas (CAIXA, FILIAL) values ('11478380', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11478381', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11478382', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11478812', 'PRAIA GRANDE');
insert into @caixas (CAIXA, FILIAL) values ('11478813', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11427377', 'CRUZEIRO');
insert into @caixas (CAIXA, FILIAL) values ('11478083', 'PRAIA GRANDE');
insert into @caixas (CAIXA, FILIAL) values ('11586522', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11446045', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11446046', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11540936', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11540936', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11567898', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11567898', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11326761', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11326762', 'CRUZEIRO');
insert into @caixas (CAIXA, FILIAL) values ('11550395', 'PRAIA GRANDE');
insert into @caixas (CAIXA, FILIAL) values ('11550396', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11550397', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11550398', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11531178', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11531213', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11586520', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11546123', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11546124', 'PRAIA GRANDE');
insert into @caixas (CAIXA, FILIAL) values ('11546125', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11580282', 'ITAIM');
insert into @caixas (CAIXA, FILIAL) values ('11583500', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11583501', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11583502', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11583503', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11583504', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11583505', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('10730994', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11454764', 'SP - CAPAO CENTRO');
insert into @caixas (CAIXA, FILIAL) values ('11583217', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11583218', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11583219', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11583220', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11583362', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11583363', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11583364', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11583365', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11583366', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11583634', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11583635', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11583636', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11583637', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11583638', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11583639', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('10827373', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11274549', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11274550', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11274753', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11568162', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11568163', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11568164', 'VILA FORMOSA');
*/
insert into @caixas (CAIXA, FILIAL) values ('11509416', 'SP - TUCURUVI');
insert into @caixas (CAIXA, FILIAL) values ('11509417', 'SP - TUCURUVI');
insert into @caixas (CAIXA, FILIAL) values ('11520171', 'SP - TUCURUVI');
insert into @caixas (CAIXA, FILIAL) values ('11520172', 'SP - TUCURUVI');
insert into @caixas (CAIXA, FILIAL) values ('11520173', 'SP - TUCURUVI');
insert into @caixas (CAIXA, FILIAL) values ('11520174', 'SP - TUCURUVI');
insert into @caixas (CAIXA, FILIAL) values ('11568079', 'SP - TUCURUVI');
insert into @caixas (CAIXA, FILIAL) values ('11568080', 'SP - TUCURUVI');
insert into @caixas (CAIXA, FILIAL) values ('11568081', 'SP - TUCURUVI');
/*
insert into @caixas (CAIXA, FILIAL) values ('11520083', 'IPIRANGA');
insert into @caixas (CAIXA, FILIAL) values ('11520084', 'IPIRANGA');
insert into @caixas (CAIXA, FILIAL) values ('11520085', 'IPIRANGA');
insert into @caixas (CAIXA, FILIAL) values ('11568009', 'IPIRANGA');
insert into @caixas (CAIXA, FILIAL) values ('11568010', 'IPIRANGA');
insert into @caixas (CAIXA, FILIAL) values ('11568011', 'IPIRANGA');
insert into @caixas (CAIXA, FILIAL) values ('11568012', 'IPIRANGA');
insert into @caixas (CAIXA, FILIAL) values ('11519973', 'CIDADE TIRADENTES');
insert into @caixas (CAIXA, FILIAL) values ('11519974', 'CIDADE TIRADENTES');
insert into @caixas (CAIXA, FILIAL) values ('11519975', 'CIDADE TIRADENTES');
insert into @caixas (CAIXA, FILIAL) values ('11519976', 'CIDADE TIRADENTES');
insert into @caixas (CAIXA, FILIAL) values ('11519977', 'CIDADE TIRADENTES');
insert into @caixas (CAIXA, FILIAL) values ('11519978', 'CIDADE TIRADENTES');
insert into @caixas (CAIXA, FILIAL) values ('11519979', 'CIDADE TIRADENTES');
insert into @caixas (CAIXA, FILIAL) values ('11472629', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11472630', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11552059', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11472731', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11472732', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11472733', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11472734', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11472735', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11472736', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11473133', 'SP - METRO CAPAO');
insert into @caixas (CAIXA, FILIAL) values ('11473134', 'SP - METRO CAPAO');
insert into @caixas (CAIXA, FILIAL) values ('11473135', 'SP - METRO CAPAO');
insert into @caixas (CAIXA, FILIAL) values ('11473136', 'SP - METRO CAPAO');
insert into @caixas (CAIXA, FILIAL) values ('11473137', 'SP - METRO CAPAO');
insert into @caixas (CAIXA, FILIAL) values ('11473138', 'SP - METRO CAPAO');
insert into @caixas (CAIXA, FILIAL) values ('11473571', 'SP - METRO CAPAO');
insert into @caixas (CAIXA, FILIAL) values ('11473572', 'SP - METRO CAPAO');
insert into @caixas (CAIXA, FILIAL) values ('11473573', 'SP - METRO CAPAO');
insert into @caixas (CAIXA, FILIAL) values ('11473574', 'SP - METRO CAPAO');
insert into @caixas (CAIXA, FILIAL) values ('11473575', 'SP - METRO CAPAO');
insert into @caixas (CAIXA, FILIAL) values ('11473771', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11473772', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11473773', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11473774', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11473775', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11473776', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11586530', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11473992', 'HORTOLANDIA');
insert into @caixas (CAIXA, FILIAL) values ('11473993', 'HORTOLANDIA');
insert into @caixas (CAIXA, FILIAL) values ('11473994', 'HORTOLANDIA');
insert into @caixas (CAIXA, FILIAL) values ('11473995', 'HORTOLANDIA');
insert into @caixas (CAIXA, FILIAL) values ('11567024', 'SP - METRO CAPAO');
insert into @caixas (CAIXA, FILIAL) values ('11567025', 'SP - METRO CAPAO');
insert into @caixas (CAIXA, FILIAL) values ('11567026', 'SP - METRO CAPAO');
insert into @caixas (CAIXA, FILIAL) values ('11567027', 'SP - METRO CAPAO');
insert into @caixas (CAIXA, FILIAL) values ('11567028', 'SP - METRO CAPAO');
insert into @caixas (CAIXA, FILIAL) values ('11567128', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11567129', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11586402', 'HORTOLANDIA');
insert into @caixas (CAIXA, FILIAL) values ('11586403', 'HORTOLANDIA');
insert into @caixas (CAIXA, FILIAL) values ('11505371', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11505372', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11505518', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11517841', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11517879', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11479844', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11479845', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11497194', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11497195', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11586518', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11504097', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11504098', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11504047', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11504048', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11586288', 'SP - TUCURUVI');
insert into @caixas (CAIXA, FILIAL) values ('11586289', 'SP - TUCURUVI');
insert into @caixas (CAIXA, FILIAL) values ('11586290', 'SP - TUCURUVI');
insert into @caixas (CAIXA, FILIAL) values ('11538234', 'SP - TUCURUVI');
insert into @caixas (CAIXA, FILIAL) values ('11538235', 'SP - TUCURUVI');
insert into @caixas (CAIXA, FILIAL) values ('11538236', 'SP - TUCURUVI');
insert into @caixas (CAIXA, FILIAL) values ('11538237', 'SP - TUCURUVI');
insert into @caixas (CAIXA, FILIAL) values ('11538309', 'SP - TUCURUVI');
insert into @caixas (CAIXA, FILIAL) values ('11538310', 'SP - TUCURUVI');
insert into @caixas (CAIXA, FILIAL) values ('11505610', 'SOROCABA');
insert into @caixas (CAIXA, FILIAL) values ('11505611', 'SOROCABA');
insert into @caixas (CAIXA, FILIAL) values ('11505612', 'SOROCABA');
insert into @caixas (CAIXA, FILIAL) values ('11505613', 'SOROCABA');
insert into @caixas (CAIXA, FILIAL) values ('11401074', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11401075', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11401076', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('10951156', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11402234', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11402235', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11586525', 'VILA DAS MERCES');
insert into @caixas (CAIXA, FILIAL) values ('11504596', 'VILA DAS MERCES');
insert into @caixas (CAIXA, FILIAL) values ('11586531', 'VILA DAS MERCES');
insert into @caixas (CAIXA, FILIAL) values ('11552460', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11523249', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11523344', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11523345', 'VILA FORMOSA');
insert into @caixas (CAIXA, FILIAL) values ('11586472', 'ITAIM');
insert into @caixas (CAIXA, FILIAL) values ('11587401', 'ITAIM');
insert into @caixas (CAIXA, FILIAL) values ('11480774', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11480775', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11480776', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11480777', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11480865', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11480866', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11582774', 'HORTOLANDIA');
insert into @caixas (CAIXA, FILIAL) values ('11582775', 'HORTOLANDIA');
insert into @caixas (CAIXA, FILIAL) values ('11291579', 'CARAGUATATUBA');
*/
insert into @caixas (CAIXA, FILIAL) values ('11291580', 'FRANCISCO MORATO');
/*
insert into @caixas (CAIXA, FILIAL) values ('11291581', 'PRAIA GRANDE');
insert into @caixas (CAIXA, FILIAL) values ('11248778', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11467482', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11467483', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11471980', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11509927', 'ITAQUERA');
insert into @caixas (CAIXA, FILIAL) values ('11509928', 'ITAQUERA');
insert into @caixas (CAIXA, FILIAL) values ('11509929', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11509930', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11509931', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11509932', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11509933', 'JAÇANA');
insert into @caixas (CAIXA, FILIAL) values ('11510053', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11510054', 'SUMARE');
insert into @caixas (CAIXA, FILIAL) values ('11510055', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11510056', 'SP - BRASILANDIA');
insert into @caixas (CAIXA, FILIAL) values ('11510057', 'SP - BRASILANDIA');
insert into @caixas (CAIXA, FILIAL) values ('11510304', 'PRAIA GRANDE');
insert into @caixas (CAIXA, FILIAL) values ('11510305', 'JAÇANA');
insert into @caixas (CAIXA, FILIAL) values ('11510306', 'SP - GRAJAU');
insert into @caixas (CAIXA, FILIAL) values ('11510307', 'SP - GRAJAU');
insert into @caixas (CAIXA, FILIAL) values ('11510308', 'ITAQUA');
insert into @caixas (CAIXA, FILIAL) values ('11510309', 'ITAQUA');
insert into @caixas (CAIXA, FILIAL) values ('11510310', 'ITU');
insert into @caixas (CAIXA, FILIAL) values ('11162803', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11481787', 'TAUBATE');
insert into @caixas (CAIXA, FILIAL) values ('11481788', 'CARAGUATATUBA');
insert into @caixas (CAIXA, FILIAL) values ('11481789', 'PINDAMONHANGABA');
insert into @caixas (CAIXA, FILIAL) values ('11481790', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11512328', 'ITAQUERA');
insert into @caixas (CAIXA, FILIAL) values ('11512329', 'ITAPEVI');
insert into @caixas (CAIXA, FILIAL) values ('11512330', 'FRANCISCO MORATO');
insert into @caixas (CAIXA, FILIAL) values ('11512331', 'SP - BRASILANDIA');
insert into @caixas (CAIXA, FILIAL) values ('11520687', 'ITAQUERA');
insert into @caixas (CAIXA, FILIAL) values ('11520688', 'ITAPEVI');
insert into @caixas (CAIXA, FILIAL) values ('11520689', 'PRAIA GRANDE');
insert into @caixas (CAIXA, FILIAL) values ('11107257', 'OSASCO CENTRO');
insert into @caixas (CAIXA, FILIAL) values ('11518553', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11518980', 'ITAQUERA');
insert into @caixas (CAIXA, FILIAL) values ('11521326', 'ITAQUERA');
insert into @caixas (CAIXA, FILIAL) values ('11521327', 'ITAQUERA');
insert into @caixas (CAIXA, FILIAL) values ('11521328', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11521329', 'OSASCO CENTRO');
insert into @caixas (CAIXA, FILIAL) values ('11521685', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11521686', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11521687', 'IPIRANGA');
insert into @caixas (CAIXA, FILIAL) values ('11521688', 'IPIRANGA');
insert into @caixas (CAIXA, FILIAL) values ('11521400', 'ITAQUERA');
insert into @caixas (CAIXA, FILIAL) values ('11521401', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11521402', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11521403', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11521404', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11521405', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11582602', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11582603', 'ITAPEVI');
insert into @caixas (CAIXA, FILIAL) values ('11521534', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11521535', 'OSASCO CENTRO');
insert into @caixas (CAIXA, FILIAL) values ('11521536', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11521537', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11521538', 'SP - BRASILANDIA');
insert into @caixas (CAIXA, FILIAL) values ('11521608', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11521609', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11521610', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('10985134', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11406312', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11406313', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11406314', 'PRAIA GRANDE');
insert into @caixas (CAIXA, FILIAL) values ('11406315', 'JAÇANA');
insert into @caixas (CAIXA, FILIAL) values ('11406316', 'OSASCO CENTRO');
insert into @caixas (CAIXA, FILIAL) values ('11406317', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11406318', 'BARUERI');
insert into @caixas (CAIXA, FILIAL) values ('10818968', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11481949', 'JAÇANA');
insert into @caixas (CAIXA, FILIAL) values ('11481950', 'SP - LAJEADO');
insert into @caixas (CAIXA, FILIAL) values ('11481951', 'VILA DIRCE');
insert into @caixas (CAIXA, FILIAL) values ('11520974', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11520975', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11520976', 'PRAIA GRANDE');
insert into @caixas (CAIXA, FILIAL) values ('11520977', 'PRAIA GRANDE');
insert into @caixas (CAIXA, FILIAL) values ('11520978', 'ITAPEVI');
insert into @caixas (CAIXA, FILIAL) values ('11535534', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11535535', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11535536', 'CARAGUATATUBA');
insert into @caixas (CAIXA, FILIAL) values ('11239817', 'ITAIM');
insert into @caixas (CAIXA, FILIAL) values ('11513540', 'FERRAZ');
insert into @caixas (CAIXA, FILIAL) values ('11513541', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11513647', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11444847', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11556866', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11556867', 'IPIRANGA');
insert into @caixas (CAIXA, FILIAL) values ('11556868', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11556977', 'FERRAZ');
insert into @caixas (CAIXA, FILIAL) values ('11557081', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11536506', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11536507', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11536508', 'IPIRANGA');
insert into @caixas (CAIXA, FILIAL) values ('11536509', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11536510', 'FERRAZ');
insert into @caixas (CAIXA, FILIAL) values ('11558067', 'IPIRANGA');
insert into @caixas (CAIXA, FILIAL) values ('11558068', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11558069', 'SAO MATHEUS');
insert into @caixas (CAIXA, FILIAL) values ('11558070', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11558071', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11558072', 'FRANCO DA ROCHA');
insert into @caixas (CAIXA, FILIAL) values ('11558073', 'FRANCO DA ROCHA');
insert into @caixas (CAIXA, FILIAL) values ('11558277', 'CARAGUATATUBA');
insert into @caixas (CAIXA, FILIAL) values ('11558278', 'CARAGUATATUBA');
insert into @caixas (CAIXA, FILIAL) values ('11558279', 'JAÇANA');
insert into @caixas (CAIXA, FILIAL) values ('11558280', 'SP - LAJEADO');
insert into @caixas (CAIXA, FILIAL) values ('11584007', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11584008', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11584009', 'ITAQUERA');
insert into @caixas (CAIXA, FILIAL) values ('11584010', 'SUMARE');
insert into @caixas (CAIXA, FILIAL) values ('10793489', 'JAÇANA');
insert into @caixas (CAIXA, FILIAL) values ('11584405', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11584406', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11584407', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11584408', 'CIDADE OCIAN');
insert into @caixas (CAIXA, FILIAL) values ('11584453', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11584454', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11584482', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11584483', 'CARAPICUIBA');
insert into @caixas (CAIXA, FILIAL) values ('11584484', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11584516', 'REGISTRO');
insert into @caixas (CAIXA, FILIAL) values ('11584517', 'REGISTRO');
insert into @caixas (CAIXA, FILIAL) values ('11584518', 'FERRAZ');
insert into @caixas (CAIXA, FILIAL) values ('11584569', 'VICENTE DE CARVALHO');
insert into @caixas (CAIXA, FILIAL) values ('11584570', 'CIDADE TIRADENTES');
insert into @caixas (CAIXA, FILIAL) values ('11560285', 'ITAQUERA');
insert into @caixas (CAIXA, FILIAL) values ('11560286', 'ITAQUERA');
insert into @caixas (CAIXA, FILIAL) values ('11560287', 'ITAQUERA');
insert into @caixas (CAIXA, FILIAL) values ('11523833', 'ITAQUERA');
insert into @caixas (CAIXA, FILIAL) values ('11560192', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11560193', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11560194', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11578709', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11578710', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11578735', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11578736', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11578879', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11578880', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11578911', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11578912', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11579127', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11579153', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11579154', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11578959', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11578960', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11578828', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11578829', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11579032', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11579033', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11582214', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11579059', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11579060', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11582260', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11582261', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11578569', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11575671', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11578410', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11578411', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11578468', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11578517', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11575770', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11575771', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11494725', 'ITAQUERA');
insert into @caixas (CAIXA, FILIAL) values ('11308501', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11308502', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11308503', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11308504', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11308505', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11556831', 'ITAQUERA');
insert into @caixas (CAIXA, FILIAL) values ('11575192', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11575238', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11575289', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11576538', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11576539', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11436610', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11581626', 'COTIA');
insert into @caixas (CAIXA, FILIAL) values ('11576014', 'COTIA');
*/
--select distinct filial from @caixas --where filial not in (select filial from filiais)


-- variaveis de controle de loop
declare @i int = 1
declare @tot int

select @tot = max(id) from @caixas

-- declare variaveis de trabalho
declare @caixa varchar(8) 
declare @filial varchar(25) 

-- inicio do loop
while @i <= @tot
begin

	select @caixa = CAIXA, @filial = FILIAL 
	FROM @caixas 
	WHERE ID = @i

	UPDATE VENDAS_PROD_EMBALADO 
		SET NOME_CLIFOR=@filial , 
			representante = @filial 
	WHERE CAIXA=@caixa

	-- se atualizou, atualiza as demais tabelas tambem
	IF @@ROWCOUNT > 0  
	begin
		UPDATE FATURAMENTO_CAIXAS 
		SET NOME_CLIFOR=@filial, 
		NOME_CLIFOR_ENTREGA = @filial
		WHERE CAIXA=@caixa
      
		UPDATE B 
		SET CLIENTE_ATACADO=@filial, 
			nome_clifor_entrega  = @filial, 
			representante = @filial, 
			gerente= @filial   
		FROM VENDAS_PROD_EMBALADO A 
		INNER JOIN VENDAS B 
			ON A.PEDIDO=B.PEDIDO 
					WHERE CAIXA =@caixa
	end

	-- passa para o proximo registro do dataset
	set @i = @i + 1
end

set nocount off


