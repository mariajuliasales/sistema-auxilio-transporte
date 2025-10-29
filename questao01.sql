/*
- QUESTÃO 1 - JOIN e ORDER BY
    Crie uma consulta que retorne:
        - Nome do funcionário
        - Matrícula
        - Departamento
        - Valor solicitado
        - Status da solicitação
        - Data da solicitação

    Requisitos:
        - Incluir APENAS solicitações com status 'APROVADO'
        - Ordenar por departamento (ordem alfabética) e depois por valor solicitado (do maior para o menor)
        - Incluir somente solicitações feitas nos últimos 6 meses
*/

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
