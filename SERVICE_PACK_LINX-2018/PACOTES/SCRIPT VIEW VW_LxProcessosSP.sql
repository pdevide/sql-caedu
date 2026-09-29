CREATE view VW_LxProcessosSP
as
SELECT CAST(dbo.lxprocessosp.id AS INT) AS ID, 
       dbo.lxprocessosp.data, 
       CAST(dbo.lxprocessosp.sp AS VARCHAR(100)) AS SP, 
       dbo.lxprocessosp.status, 
       dbo.lxprocessosp.usuario, 
       dbo.lxprocessosp.versao, 
       dbo.lxprocessosp.build, 
       dbo.lxprocessospitem.id     AS ItemId, 
       dbo.lxprocessospitem.data   AS ItemData, 
       CAST(dbo.lxprocessospitem.transacao AS VARCHAR(100)) AS TRANSACAO, 
       dbo.lxprocessospitem.idlxtipotransacao, 
       dbo.lxprocessospitem.status AS ItemStatus, 
       CAST(dbo.lxprocessospitem.mensagem AS VARCHAR(100)) AS MENSAGEM, 
       CAST(dbo.lxtipotransacao.descricaotipotransacao AS VARCHAR(50)) AS DESCRICAOTIPOTRANSACAO, 
       dbo.lxtipotransacao.extensao, 
       dbo.lxtipotransacao.tipoacao 
FROM   dbo.lxprocessosp 
       INNER JOIN dbo.lxprocessospitem 
               ON dbo.lxprocessosp.id = dbo.lxprocessospitem.idlxprocessosp 
       INNER JOIN dbo.lxtipotransacao 
               ON dbo.lxprocessospitem.idlxtipotransacao = dbo.lxtipotransacao.id 