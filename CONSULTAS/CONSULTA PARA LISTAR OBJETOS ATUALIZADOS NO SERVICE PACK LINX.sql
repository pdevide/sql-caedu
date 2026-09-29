SELECT SP.Id,SP.Data,SP,SP.Status, CASE WHEN SP.Status=1 THEN 'OK' ELSE 'ERRO' END AS DESC_STATUS,
SP.Usuario,SP.CheckBox,SP.Versao,SP.Build, 
SP1.id_item,SP1.IdLxProcessoSP,SP1.Data, SP1.Transacao, SP1.DescricaoTipoTransacao,SP1.Status, SP1.Mensagem
FROM LxProcessoSP SP 
inner join (
Select	A.Id AS id_item, A.IdLxProcessoSP, A.Data, A.Transacao, 
        B.DescricaoTipoTransacao, 
		Case When A.Status = 1 Then 'OK' Else 'Erro' End As Status, A.Mensagem
From	    LxProcessoSPItem As A
		Inner Join LxTipoTransacao As B	On	A.IdLxTipoTransacao	=	B.Id) SP1 on SP1.IdLxProcessoSP = SP.ID
where SP.Data>'20251231'
ORDER BY SP.id DESC, SP1.id_item DESC