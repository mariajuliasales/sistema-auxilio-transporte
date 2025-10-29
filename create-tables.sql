CREATE TABLE funcionarios (
    id_funcionario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    matricula VARCHAR(20) UNIQUE NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    endereco VARCHAR(150) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    uf CHAR(2) NOT NULL,
    meio_transporte VARCHAR(50) NOT NULL
);


CREATE TABLE solicitacoes_auxilio (
    id_solicitacao SERIAL PRIMARY KEY,
    id_funcionario INT NOT NULL,
    data_solicitacao DATE NOT NULL DEFAULT CURRENT_DATE,
    valor_solicitado NUMERIC(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('PENDENTE', 'APROVADO', 'REJEITADO', 'PAGO', 'CANCELADO')),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
);


CREATE TABLE pagamentos_auxilio (
    id_pagamento SERIAL PRIMARY KEY,
    id_solicitacao INT UNIQUE NOT NULL,
    data_pagamento DATE NOT NULL DEFAULT CURRENT_DATE,
    valor_pago NUMERIC(10, 2) NOT NULL,
    FOREIGN KEY (id_solicitacao) REFERENCES solicitacoes_auxilio(id_solicitacao)
);


CREATE TABLE log_auditoria (
    id_log SERIAL PRIMARY KEY,
    tabela_afetada VARCHAR(50) NOT NULL,
    operacao VARCHAR(10) NOT NULL,
    registro_id INT,
    data_hora TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    detalhes TEXT
);