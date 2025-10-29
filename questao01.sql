SELECT 
    f.nome AS nome_funcionario,
    f.matricula,
    f.departamento,
    s.valor_solicitado,
    s.status,
    s.data_solicitacao
FROM 
    solicitacoes_auxilio s
JOIN 
    funcionarios f 
    ON s.id_funcionario = f.id_funcionario
WHERE 
    s.status = 'APROVADO'
    AND s.data_solicitacao >= CURRENT_DATE - INTERVAL '6 months'
ORDER BY 
    f.departamento ASC,
    s.valor_solicitado DESC;
