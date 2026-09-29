declare @tabpedidos table (
id int identity (1,1) not null primary key,
pedido varchar(12) not null,
cluster varchar(70) not null)

declare @id int, @tot int, @pedido varchar(12), @cluster varchar(70)

insert into @tabpedidos (pedido, cluster) values ('383878V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383880V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383881V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383888V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383890V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383891V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383899V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383901V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383902V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383903V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383904V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383908V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('3839091V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('3839092V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383911V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383913V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383914V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383915V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383921V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383925V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383928V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383931V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383933V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383935V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383940V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383941V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383942V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383955V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383956V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383957V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383958V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383959V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383960V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383963V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383965V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383968V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383972V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383982V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383983V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383986V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384000V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384002V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384004V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384005V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384006V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384007V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384015V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384019V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384020V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384021V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384022V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384023V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384024V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384027V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384029V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384032V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384041V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384043V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384050V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384054V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384056V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384062V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384063V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384064V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384065V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384066V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384067V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384068V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384073V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384085V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384092V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384093V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384097V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384098V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384104V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384112V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384123V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384126V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384127V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384133V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384137V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384143V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384153V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384162V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384183V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384189V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384193V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384197V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384199V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384203V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384205V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384207V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384210V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384213V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384214V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384215V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384216V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384218V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384247V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384248V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384249V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384254V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384255V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384256V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384257V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384258V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384259V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384261V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384269V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384272V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384274V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384306V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384307V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384311V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384313V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384315V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384317V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384318V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384321V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384322V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384323V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384324V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384325V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384326V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384327V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384328V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384329V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384330V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384331V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384332V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384333V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384334V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384335V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384336V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384337V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384338V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384339V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384340V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384341V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384342V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384343V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384344V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384346V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384347V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384348V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384349V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384350V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384351V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384352V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384353V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384354V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384355V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384356V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384357V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384358V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384359V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384360V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384361V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384362V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384363V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384364V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384365V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384366V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384373V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384376V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384377V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384378V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384470V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384471V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384472V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384473V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384474V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384476V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384497V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384498V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384499V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384500V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384504V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384505V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384506V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384507V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384508V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384509V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384516V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384517V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384518V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384519V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384520V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384521V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384522V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384523V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384524V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384525V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384526V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384527V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384529V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384531V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384532V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384533V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384552V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384553V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384556V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384557V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384558V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384560V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384575V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384579V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384583V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384586V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384600V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384603V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384608V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384611V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384614V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384617V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384618V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384619V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384620V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384621V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384623V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384624V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384625V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384626V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384627V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384629V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384631V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384637V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384638V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384639V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384643V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384644V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384646V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384647V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384651V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384653V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384654V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384655V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384656V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384657V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384658V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384659V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384660V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384661V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384662V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384663V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384665V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384667V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384668V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384669V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384670V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384671V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384673V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384674V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384676V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384677V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384679V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384684V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384689V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384690V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384692V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384693V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384694V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384698V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384699V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384701V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384703V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384704V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384706V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384708V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384709V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384710V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384711V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('384723V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383434V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383451V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383453V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383456V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383457V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383458V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383459V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383468V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383469V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383471V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383474V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383476V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383477V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383478V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383481V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383482V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383483V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383485V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383488V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383491V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383520V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383522V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383523V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383525V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383530V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383532V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383534V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383536V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383541V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383547V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383553V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383559V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383573V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383574V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383575V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383577V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383583V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383585V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383587V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383590V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383591V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383593V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383595V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383596V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383597V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383598V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383599V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383602V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383604V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383606V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383607V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383608V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383609V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383612V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383615V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383620V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383635V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383639V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383640V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383650V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383705V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383706V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383707V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383708V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383796V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383797V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383801V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383802V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383803V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383805V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383849V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383850V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('383852V','0.01 - EMPRESA - TODAS AS LOJAS + ECOMM');
insert into @tabpedidos (pedido, cluster) values ('365067','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('360921','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('360923','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('360924','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('360925','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('361773','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('362016','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('383909-1','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('383921','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('383925','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('383928','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384047','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384053','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384073','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384247','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384248','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384249','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384250','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384251','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384252','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384255','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384256','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384257','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384259','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384261','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384306','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384307','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384311','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384688','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384691','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384695','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('384700','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('383496','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('383590','0.02 - EMPRESA - LOJAS FISICAS');
insert into @tabpedidos (pedido, cluster) values ('383595','0.02 - EMPRESA - LOJAS FISICAS');

;with  base as (
select a.*, pc.valor_propriedade,  
case when ISNULL(a.cluster,'') <> ISNULL(pc.VALOR_PROPRIEDADE,'') then 'DIFERENTE'
ELSE 'IGUAL'
END AS COMPARA
from @tabpedidos a
left join prop_compras pc on pc.propriedade = '00120' and pc.pedido=a.pedido)

select @id = min(id), @tot = max(id)
from base

while @id <= @tot
begin

	select	@pedido = pedido,
			@cluster = cluster
	from @tabpedidos a
	where id = @id

	if exists (select 1 from prop_compras where propriedade = '00120' and pedido = @pedido)
	begin
		update prop_compras
		set VALOR_PROPRIEDADE = @cluster
		where propriedade = '00120' and pedido = @pedido
	end
	else
	begin
		insert into PROP_COMPRAS (PROPRIEDADE,PEDIDO,ITEM_PROPRIEDADE,VALOR_PROPRIEDADE,DATA_PARA_TRANSFERENCIA)
		values ('00120',@pedido,1,@cluster,getdate())
	end

	/*reseta a data do pedido para ser enviado para a UNOUS novamente com o cluster corrigido */
	update compras	
		set DATA_PARA_TRANSFERENCIA = GETDATE(), ERP_UNOUS_DATA_ENVIO=null 
	where pedido = @pedido

	set @id += 1
end

