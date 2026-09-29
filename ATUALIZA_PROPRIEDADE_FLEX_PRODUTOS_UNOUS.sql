/*
chamado 338620
select * 
update a set UNOUS_NIVEL='FLEX'
from CAE_PRODUTOS_FATOR_P a 
where GRIFFE='ACESSORIOS' and linha = 'INFANTIL' and GRUPO_PRODUTO = 'INVERNO LINHA NOITE' and subgrupo_produto = 'PIJAMA MENINA'

select * 
--update a set UNOUS_NIVEL='FLEX'
from CAE_PRODUTOS_FATOR_P a 
where GRIFFE='ACESSORIOS' and linha = 'INFANTIL' and GRUPO_PRODUTO = 'INVERNO LINHA NOITE' and subgrupo_produto = 'PIJAMA MENINO'

select * 
--update a set UNOUS_NIVEL='FLEX'
from CAE_PRODUTOS_FATOR_P a 
where GRIFFE='ACESSORIOS' and linha = 'INFANTIL' and GRUPO_PRODUTO = 'LINHA NOITE' and subgrupo_produto = 'PIJAMA MENINA'

select * 
--update a set UNOUS_NIVEL='FLEX'
from CAE_PRODUTOS_FATOR_P a 
where GRIFFE='ACESSORIOS' and linha = 'INFANTIL' and GRUPO_PRODUTO = 'LINHA NOITE' and subgrupo_produto = 'PIJAMA MENINO'
ACESSORIOS INFANTIL LINHA NOITE   PIJAMA MENINA
ACESSORIOS INFANTIL LINHA NOITE   PIJAMA MENINO

*/

declare @produtos table (id int identity(1,1), produto varchar(8), valor varchar(70)) 

--insert into @produtos (produto, valor) values ('B0010011','ESCOVA')
insert into @produtos (produto, valor) values ('Z4010128','PRESILHAS')
insert into @produtos (produto, valor) values ('Z4010188','PRESILHAS')
insert into @produtos (produto, valor) values ('Z4010190','ELASTICO')
insert into @produtos (produto, valor) values ('F5010025','ELASTICO')
insert into @produtos (produto, valor) values ('F5010013','PRESILHAS')
insert into @produtos (produto, valor) values ('F5010002','ELASTICO')
insert into @produtos (produto, valor) values ('F5010012','ELASTICO')
insert into @produtos (produto, valor) values ('F5010003','ELASTICO')
insert into @produtos (produto, valor) values ('F5010004','TIARA')
insert into @produtos (produto, valor) values ('F5010053','TIARA')
insert into @produtos (produto, valor) values ('F5010054','TIARA')
insert into @produtos (produto, valor) values ('F5010055','TIARA')
insert into @produtos (produto, valor) values ('F5010056','TIARA')
insert into @produtos (produto, valor) values ('F5010057','TIARA')
insert into @produtos (produto, valor) values ('Z5010073','BLOCO DE NOTAS')
insert into @produtos (produto, valor) values ('Z5010074','BLOCO DE NOTAS')
insert into @produtos (produto, valor) values ('Z5010082','CADERNO')
insert into @produtos (produto, valor) values ('Z5010087','CADERNO')
insert into @produtos (produto, valor) values ('Z5010088','CADERNO')
insert into @produtos (produto, valor) values ('Z5010089','CADERNO')
insert into @produtos (produto, valor) values ('Z5010058','CADERNO')
insert into @produtos (produto, valor) values ('Z5010057','CADERNO')
insert into @produtos (produto, valor) values ('Z5010030','CADERNO')
insert into @produtos (produto, valor) values ('Z5010032','CADERNO')
insert into @produtos (produto, valor) values ('Z5010033','CADERNO')
insert into @produtos (produto, valor) values ('Z5010034','CADERNO')
insert into @produtos (produto, valor) values ('Z5010035','CADERNO')
insert into @produtos (produto, valor) values ('Z5010036','CADERNO')
insert into @produtos (produto, valor) values ('Z5010037','CADERNO')
insert into @produtos (produto, valor) values ('Z5010038','CADERNO')
insert into @produtos (produto, valor) values ('Z5010039','CADERNO')
insert into @produtos (produto, valor) values ('Z5010040','CADERNO')
insert into @produtos (produto, valor) values ('Z5010041','CADERNO')
insert into @produtos (produto, valor) values ('Z5010042','CADERNO')
insert into @produtos (produto, valor) values ('Z5010065','CADERNO')
insert into @produtos (produto, valor) values ('Z5010043','CADERNO')
insert into @produtos (produto, valor) values ('Z5010052','CADERNO')
insert into @produtos (produto, valor) values ('Z5010053','CADERNO')
insert into @produtos (produto, valor) values ('Z5010054','CADERNO')
insert into @produtos (produto, valor) values ('Z5010055','CADERNO')
insert into @produtos (produto, valor) values ('Z5010056','CADERNO')
insert into @produtos (produto, valor) values ('Z5010064','CADERNO')
insert into @produtos (produto, valor) values ('Z5010085','CADERNO')
insert into @produtos (produto, valor) values ('Z1010068','CADERNO')
insert into @produtos (produto, valor) values ('Z5010045','CADERNO')
insert into @produtos (produto, valor) values ('Z5010046','CADERNO')
insert into @produtos (produto, valor) values ('Z5010047','CADERNO')
insert into @produtos (produto, valor) values ('Z5010068','CADERNO')
insert into @produtos (produto, valor) values ('Z5010077','CADERNO')
insert into @produtos (produto, valor) values ('Z5010078','CADERNO')
insert into @produtos (produto, valor) values ('Z5010079','CADERNO')
insert into @produtos (produto, valor) values ('Z5010083','CADERNO')
insert into @produtos (produto, valor) values ('Z5010044','CADERNO')
insert into @produtos (produto, valor) values ('Z5010095','CADERNO')
insert into @produtos (produto, valor) values ('Z5010096','CADERNO')
insert into @produtos (produto, valor) values ('Z5010031','CADERNO')
insert into @produtos (produto, valor) values ('Z5010059','CADERNO')
insert into @produtos (produto, valor) values ('Z5010060','CADERNO')
insert into @produtos (produto, valor) values ('Z5010061','CADERNO')
insert into @produtos (produto, valor) values ('Z5010101','PLANNER')
insert into @produtos (produto, valor) values ('Z5010092','CADERNO')
insert into @produtos (produto, valor) values ('58100040','PROTETOR ORELHA')
insert into @produtos (produto, valor) values ('58100053','PROTETOR ORELHA')
insert into @produtos (produto, valor) values ('58100039','GORRO')
insert into @produtos (produto, valor) values ('44080390','GORRO')
insert into @produtos (produto, valor) values ('44080391','GORRO')
insert into @produtos (produto, valor) values ('44080392','GORRO')
insert into @produtos (produto, valor) values ('44080394','GORRO')
insert into @produtos (produto, valor) values ('44080393','GORRO')
insert into @produtos (produto, valor) values ('44080307','GORRO')
insert into @produtos (produto, valor) values ('44080308','GORRO')
insert into @produtos (produto, valor) values ('44080310','PASHMINA')
insert into @produtos (produto, valor) values ('62010463','PASHMINA')
insert into @produtos (produto, valor) values ('62010356','ROSA')
insert into @produtos (produto, valor) values ('24050063','AMARELO')
insert into @produtos (produto, valor) values ('24200191','PRETO  P')
insert into @produtos (produto, valor) values ('24210214','MASH')
insert into @produtos (produto, valor) values ('24990143','GARRAFA')
insert into @produtos (produto, valor) values ('24990169','GARRAFA')
insert into @produtos (produto, valor) values ('24990193','GARRAFA')
insert into @produtos (produto, valor) values ('24990135','COPO')
insert into @produtos (produto, valor) values ('24990182','DUOMO - MICROFIBRA')
insert into @produtos (produto, valor) values ('24990125','MASH - ALGODAO')
insert into @produtos (produto, valor) values ('24990126','MASH - ALGODAO')
insert into @produtos (produto, valor) values ('24990127','MASH - ALGODAO')
insert into @produtos (produto, valor) values ('24990148','MASH - ALGODAO')
insert into @produtos (produto, valor) values ('24970002','MASH - ALGODAO')
insert into @produtos (produto, valor) values ('58020043','P - TAMANHO')
insert into @produtos (produto, valor) values ('44080348','CURTO')
insert into @produtos (produto, valor) values ('62050283','SAPATILHA PP')
insert into @produtos (produto, valor) values ('62050284','SAPATILHA M')
insert into @produtos (produto, valor) values ('62050277','SAPATILHA PP')
insert into @produtos (produto, valor) values ('62050285','SAPATILHA P')
insert into @produtos (produto, valor) values ('62050286','SAPATILHA P')
insert into @produtos (produto, valor) values ('62050287','SAPATILHA P')
insert into @produtos (produto, valor) values ('23060049','LICENCIADO GG')
insert into @produtos (produto, valor) values ('23860012','ESTAMPADO G')
insert into @produtos (produto, valor) values ('23060073','LICENCIADO M')
insert into @produtos (produto, valor) values ('23060072','LICENCIADO PP')
insert into @produtos (produto, valor) values ('44080300','LICENCIADO P')
insert into @produtos (produto, valor) values ('23150062','CHAVEIRO')
insert into @produtos (produto, valor) values ('23150022','CHAVEIRO')
insert into @produtos (produto, valor) values ('23150071','CHAVEIRO')
insert into @produtos (produto, valor) values ('23150069','CHAVEIRO')
insert into @produtos (produto, valor) values ('77020111','CAIXA SORTIDA M')
insert into @produtos (produto, valor) values ('77020095','CAIXA SORTIDA M')
insert into @produtos (produto, valor) values ('77030172','SACOLA M')
insert into @produtos (produto, valor) values ('77030168','SACOLA M')
insert into @produtos (produto, valor) values ('18030309','SACOLA M')
insert into @produtos (produto, valor) values ('Z4010109','SACOLA G')
insert into @produtos (produto, valor) values ('F5010074','SACO 30x44')
insert into @produtos (produto, valor) values ('44080285','SACO 30x44')
insert into @produtos (produto, valor) values ('18030317','SACOLA M')
insert into @produtos (produto, valor) values ('24020417','E')
insert into @produtos (produto, valor) values ('24020419','F')
insert into @produtos (produto, valor) values ('24020418','G')
insert into @produtos (produto, valor) values ('24050087','H')
insert into @produtos (produto, valor) values ('24050088','I')
insert into @produtos (produto, valor) values ('24200254','J')
insert into @produtos (produto, valor) values ('24200243','K')
insert into @produtos (produto, valor) values ('24200242','L')
insert into @produtos (produto, valor) values ('24200240','M')
insert into @produtos (produto, valor) values ('24200241','N')
insert into @produtos (produto, valor) values ('24200244','O')
insert into @produtos (produto, valor) values ('24200245','Q')
insert into @produtos (produto, valor) values ('24200235','R')
insert into @produtos (produto, valor) values ('23030608','4-8')
insert into @produtos (produto, valor) values ('18060106','S')
insert into @produtos (produto, valor) values ('18060108','T')
insert into @produtos (produto, valor) values ('18060109','U')
insert into @produtos (produto, valor) values ('62010376','V')
insert into @produtos (produto, valor) values ('62010484','W')
insert into @produtos (produto, valor) values ('62010489','X')
insert into @produtos (produto, valor) values ('62080232','Y')
insert into @produtos (produto, valor) values ('62080245','Z')
insert into @produtos (produto, valor) values ('62080244','AA')
insert into @produtos (produto, valor) values ('62080234','AB')
insert into @produtos (produto, valor) values ('62080235','AC')
insert into @produtos (produto, valor) values ('62020171','1-3')
insert into @produtos (produto, valor) values ('23150025','4-8')
insert into @produtos (produto, valor) values ('23150015','10-16')
insert into @produtos (produto, valor) values ('55130093','AD')
insert into @produtos (produto, valor) values ('55130104','AE')
insert into @produtos (produto, valor) values ('55040211','AF')
insert into @produtos (produto, valor) values ('26050124','AG')
insert into @produtos (produto, valor) values ('23030664','A')
insert into @produtos (produto, valor) values ('23030655','B')
insert into @produtos (produto, valor) values ('23030656','C')
insert into @produtos (produto, valor) values ('23030663','10-16')
insert into @produtos (produto, valor) values ('23030660','4-8')
insert into @produtos (produto, valor) values ('23030644','10-16')
insert into @produtos (produto, valor) values ('23030645','10-16')
insert into @produtos (produto, valor) values ('23030641','D')
insert into @produtos (produto, valor) values ('23030642','4-10')
insert into @produtos (produto, valor) values ('23030661','4-10')
insert into @produtos (produto, valor) values ('23030643','4-10')
insert into @produtos (produto, valor) values ('23030657','10-16')
insert into @produtos (produto, valor) values ('23030658','E')
insert into @produtos (produto, valor) values ('23030627','A')
insert into @produtos (produto, valor) values ('23030742','B')
insert into @produtos (produto, valor) values ('23030748','C')
insert into @produtos (produto, valor) values ('23030754','D')
insert into @produtos (produto, valor) values ('23030652','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030617','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030623','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030619','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030607','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030622','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030647','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030632','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030638','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030666','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030633','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030654','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030649','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030615','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030611','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030639','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030650','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030651','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030665','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030637','ESTAMPADO                                                             ')
insert into @produtos (produto, valor) values ('23030634','MALHA')
insert into @produtos (produto, valor) values ('23030697','MALHA')
insert into @produtos (produto, valor) values ('23030751','LICENCIADO')
insert into @produtos (produto, valor) values ('23030720','ESTAMPADO')
insert into @produtos (produto, valor) values ('23030670','LICENCIADO')
insert into @produtos (produto, valor) values ('23030669','LICENCIADO')
insert into @produtos (produto, valor) values ('23030673','ESTAMPADO')
insert into @produtos (produto, valor) values ('23030716','ESTAMPADO')
insert into @produtos (produto, valor) values ('23030680','ESTAMPADO')
insert into @produtos (produto, valor) values ('23030696','ESTAMPADO')
insert into @produtos (produto, valor) values ('23030695','ESTAMPADO')
insert into @produtos (produto, valor) values ('23030672','ESTAMPADO')
insert into @produtos (produto, valor) values ('23030684','ESTAMPADO')


DECLARE @min int, @max int, @produto varchar(8), @valor varchar(50)

select @min = min(id), @max = max(id) from @produtos

WHILE @min <= @max
begin
	
	select @produto = produto, @valor = valor
	from @produtos	
	where id = @min
	if exists(select 1 from prop_produtos where propriedade = '00105' and produto = @produto)
	begin
		update prop_produtos set VALOR_PROPRIEDADE = @valor, DATA_PARA_TRANSFERENCIA=getdate()
		where propriedade = '00105' and produto = @produto
	end
	else
	begin
		insert into PROP_PRODUTOS values ('00105',@produto,1,@valor,getdate())
	end
	update produtos set DATA_PARA_TRANSFERENCIA = getdate() where produto = @produto
	print @min
	set @min = @min + 1
end




