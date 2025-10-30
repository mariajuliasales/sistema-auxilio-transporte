# Sistema de Auxílio Transporte

Sistema desenvolvido como parte de uma prova de proficiência em PostgreSQL, demonstrando conhecimentos em banco de dados relacionais. O projeto implementa um sistema completo de gerenciamento de auxílio transporte para funcionários, utilizando recursos como triggers, stored procedures, consultas complexas e log de auditoria.

## Estrutura do Banco de Dados

O sistema é composto por quatro tabelas principais:

1. `funcionarios`: Armazena informações dos funcionários (ID, nome, cpf, matrícula, cargo, departamento, etc.)
2. `solicitacoes_auxilio`: Registra as solicitações de auxílio transporte com status (PENDENTE, APROVADO, REJEITADO, PAGO, CANCELADO)
3. `pagamentos_auxilio`: Controla os pagamentos realizados para as solicitações aprovadas
4. `log_auditoria`: Mantém o histórico de todas as operações realizadas no sistema

## Questões 

1. **Consulta de Solicitações Aprovadas (JOIN e ORDER BY)**
   - Lista solicitações aprovadas nos últimos 6 meses
   - Ordenadas por departamento e valor
   - Inclui informações do funcionário e da solicitação

2. **Relatório Mensal de Solicitações (GROUP BY e HAVING)**
   - Agrupa solicitações por ano/mês
   - Calcula totais e médias
   - Filtra meses com mais de 10 solicitações

3. **Trigger para Atualização de Pagamentos**
   - Atualiza status da solicitação após pagamento
   - Registra operação no log de auditoria
   - Mantém consistência entre pagamentos e solicitações

4. **Stored Procedure para Cancelamento**
   - Procedimento `sp_cancelar_solicitacao(INT, TEXT)`
   - Validações de regras de negócio
   - Registro de log automático

5. **Análise de Gastos por Funcionário**
   - Ranking de funcionários por departamento
   - Cálculo de percentuais e totais
   - TOP 3 gastadores por departamento

## Estrutura de Arquivos

- `create-tables.sql`: Script de criação das tabelas do banco de dados.
- `mock-dados.sql`: Script com dados de exemplo para teste do sistema.
- `questao01.sql` a `questao05.sql`: Scripts com consultas específicas para cada questão da prova.
- `README.md`: Documentação do projeto.

## Como Executar o Sistema

### Pré-requisitos
- PostgreSQL instalado
- Acesso ao terminal psql
- Git instalado

### Passo a Passo

1. Clone o repositório e entre na pasta do projeto:
```bash
git clone https://github.com/mariajuliasales/sistema-auxilio-transporte.git
cd sistema-auxilio-transporte
```

2. Abra o terminal e conecte-se ao PostgreSQL:
```bash
psql -U seu_usuario
```

3. Crie o banco de dados:
```sql
CREATE DATABASE prova_banco_dados;
```

4. Conecte-se ao banco de dados criado:
```sql
\c prova_banco_dados
```

5. Execute os scripts na seguinte ordem:

   a. Criação das tabelas:
   ```bash
   \i create-tables.sql
   ```

   b. Inserção dos dados de exemplo:
   ```bash
   \i mock-dados.sql
   ```

   c. Execute as consultas disponíveis:
   ```bash
   \i questaoXX.sql
   ```
   (Substitua XX pelo número da questão desejada: 01, 02, 03, 04 ou 05)

## Exemplos de Uso

### Consultando solicitações aprovadas
```sql
\i questao01.sql
```

### Gerando relatório mensal
```sql
\i questao02.sql
```

### Registrando um novo pagamento (ativa trigger)
```sql
INSERT INTO pagamentos_auxilio (id_solicitacao, valor_pago)
VALUES (1, 200.00);
```

### Cancelando uma solicitação
```sql
SELECT sp_cancelar_solicitacao(1, 'Solicitação cancelada a pedido do funcionário');
```

### Visualizando ranking de gastos
```sql
\i questao05.sql
```

