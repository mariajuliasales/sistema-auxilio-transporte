/*
- QUESTÃO 2 - GROUP BY e HAVING
    Crie uma consulta que mostre um relatório mensal de solicitações, contendo:
        - Ano e mês da solicitação
        - Quantidade total de solicitações
        - Valor total solicitado
        - Valor médio das solicitações
        - Quantidade de solicitações aprovadas

    Requisitos:
        - Agrupar por ano e mês
        - Mostrar APENAS os meses que tiveram mais de 10 solicitações
        - Ordenar do mês mais recente para o mais antigo
        - Formatar o ano/mês como 'YYYY-MM'
*/

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
