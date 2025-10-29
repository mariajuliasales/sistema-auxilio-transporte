CREATE OR REPLACE PROCEDURE sp_cancelar_solicitacao(
    p_id_solicitacao INT,
    p_motivo TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_status_atual VARCHAR(20);
BEGIN
    SELECT status INTO v_status_atual
    FROM solicitacoes_auxilio
    WHERE id_solicitacao = p_id_solicitacao;

    IF NOT FOUND THEN
        RAISE NOTICE ' Solicitação % não encontrada.', p_id_solicitacao;
        RETURN;
    END IF;

    IF v_status_atual = 'PAGO' THEN
        RAISE NOTICE ' Não é possível cancelar. Solicitação % já foi paga.', p_id_solicitacao;
        RETURN;
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

    RAISE NOTICE ' Solicitação % cancelada com sucesso. Motivo: %', p_id_solicitacao, p_motivo;

END;
$$;