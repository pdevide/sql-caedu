alter table dbo.produtos
	add ERP_ST_QUALIDADE int not null,
	constraint DF_ERP_STATUS_QUALIDADE DEFAULT( 0 ) FOR ERP_ST_QUALIDADE
	
GO

/*
alter table dbo.produtos drop constraint CHK_ERP_STATUS_QUALIDADE
go
alter table dbo.produtos drop constraint DF_ERP_STATUS_QUALIDADE
go
alter table dbo.produtos drop column ERP_ST_QUALIDADE
GO
*/
