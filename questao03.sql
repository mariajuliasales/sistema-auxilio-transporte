/*
- QUESTÃO 3 - TRIGGER 
    Crie um TRIGGER que:
        - Seja acionado APÓS a inserção de um novo registro na tabela pagamentos
        - Atualize automaticamente o status da solicitação correspondente para 'PAGO'
        - Registre na tabela log_auditoria as informações da operação
*/

CREATE OR REPLACE FUNCTION trg_pagamento_atualiza_status()
RETURNS TRIGGER AS $$
DECLARE
    v_status_atual VARCHAR(20);
BEGIN

    SELECT status INTO v_status_atual
    FROM solicitacoes_auxilio
    WHERE id_solicitacao = NEW.id_solicitacao;
    
    IF v_status_atual IN ('CANCELADO', 'REJEITADO') THEN
    RAISE EXCEPTION 'Não é possível pagar uma solicitação com status % (ID: %)', v_status_atual, NEW.id_solicitacao;
    END IF;

    UPDATE solicitacoes_auxilio
    SET status = 'PAGO'
    WHERE id_solicitacao = NEW.id_solicitacao;

    INSERT INTO log_auditoria (tabela_afetada, operacao, registro_id, detalhes)
    VALUES (
        'pagamentos_auxilio',
        'INSERT',
        NEW.id_pagamento,
        CONCAT('Pagamento registrado e solicitação ', NEW.id_solicitacao, ' atualizada para PAGO.')
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_pagamento_insert
AFTER INSERT ON pagamentos_auxilio
FOR EACH ROW
EXECUTE FUNCTION trg_pagamento_atualiza_status();