SELECT
    TO_CHAR(s.data_solicitacao, 'YYYY-MM') AS ano_mes,
    COUNT(*) AS total_solicitacoes,
    SUM(s.valor_solicitado) AS valor_total_solicitado,
    AVG(s.valor_solicitado) AS valor_medio_solicitacoes,
    COUNT(*) FILTER (WHERE s.status = 'APROVADO') AS total_aprovadas
FROM
    solicitacoes_auxilio s
GROUP BY
    TO_CHAR(s.data_solicitacao, 'YYYY-MM')
HAVING
    COUNT(*) > 10
ORDER BY
    ano_mes DESC;
