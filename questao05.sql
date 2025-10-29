/*
-- QUESTÃO 5 - SUBCONSULTA e WINDOW FUNCTION
    Crie uma consulta que identifique os funcionários "top gastadores":
        - Nome do funcionário
        - Departamento
        - Total gasto
        - Quantidade de solicitações aprovadas
        - Ranking dentro do departamento
        - Percentual do total do departamento

    Requisitos:
        - Apenas solicitações APROVADAS com pagamentos
        - TOP 3 de cada departamento
        - Percentual com 2 casas decimais
*/

WITH ranking_funcionarios AS (
    SELECT
        f.nome,
        f.departamento,
        SUM(p.valor_pago) AS total_gasto,
        COUNT(s.id_solicitacao) AS qtd_solicitacoes,
        RANK() OVER (PARTITION BY f.departamento ORDER BY SUM(p.valor_pago) DESC) AS ranking_departamento,
        ROUND(
            100 * SUM(p.valor_pago) / SUM(SUM(p.valor_pago)) OVER (PARTITION BY f.departamento),
            2
        ) AS percentual_departamento
    FROM funcionarios f
    JOIN solicitacoes_auxilio s ON s.id_funcionario = f.id_funcionario
    JOIN pagamentos_auxilio p ON p.id_solicitacao = s.id_solicitacao
    WHERE s.status = 'APROVADO'
    GROUP BY f.nome, f.departamento
)

SELECT *
FROM ranking_funcionarios
WHERE ranking_departamento <= 3
ORDER BY departamento, ranking_departamento;