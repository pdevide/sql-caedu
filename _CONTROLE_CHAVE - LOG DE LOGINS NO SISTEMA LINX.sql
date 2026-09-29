create table DBO._CONTROLE_CHAVE (
	id int identity(1,1) not null, 
	workstation varchar(50) null, 
	login varchar(50) null, 
	linxuser varchar(50) null, 
	dt_access datetime not null default getdate(), 
	linxkey varchar(50) null)
go

alter table DBO._CONTROLE_CHAVE
add constraint PK_CONTROLE_CHAVE PRIMARY KEY (ID)
GO