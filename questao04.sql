/*
-- QUESTÃO 4 - STORED PROCEDURE
    Crie uma STORED PROCEDURE chamada sp_cancelar_solicitacao que:
        - Receba ID da solicitação e motivo
        - Verifique se pode cancelar (não pode se já foi PAGO)
        - Atualize o status para CANCELADO
        - Registre no log
        - Retorne mensagem de sucesso ou erro
*/

CREATE OR REPLACE FUNCTION sp_cancelar_solicitacao(
    p_id_solicitacao INT,
    p_motivo TEXT
)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    v_status_atual VARCHAR(20);
BEGIN
    SELECT status INTO v_status_atual
    FROM solicitacoes_auxilio
    WHERE id_solicitacao = p_id_solicitacao;

    IF NOT FOUND THEN
        RETURN FORMAT(' Solicitação %s não encontrada.', p_id_solicitacao);
    END IF;

    IF v_status_atual = 'PAGO' THEN
        RETURN FORMAT(' Não é possível cancelar. Solicitação %s já foi paga.', p_id_solicitacao);
    END IF;

    IF v_status_atual = 'CANCELADO' THEN
        RETURN FORMAT(' Solicitação %s já está cancelada.', p_id_solicitacao);
    END IF;

    UPDATE solicitacoes_auxilio
    SET status = 'CANCELADO'
    WHERE id_solicitacao = p_id_solicitacao;

    INSERT INTO log_auditoria (tabela_afetada, operacao, registro_id, detalhes)
    VALUES (
        'solicitacoes_auxilio',
        'UPDATE',
        p_id_solicitacao,
        'Solicitação cancelada. Motivo: ' || p_motivo
    );

    RETURN FORMAT(' Solicitação %s cancelada com sucesso. Motivo: %s', p_id_solicitacao, p_motivo);

END;
$$;